package controladores;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.ConexionBaseDatos;
import clases.FormatosFecha;
import clases.FormatoTimestamp;

public class ValoracionNutricional implements Control{
    
    private String msj;
    private ConexionBaseDatos c;
    
    public boolean doLogic(javax.servlet.http.HttpServletRequest request,
            javax.servlet.http.HttpServletResponse response)
            throws javax.servlet.ServletException, java.io.IOException
    {
        /*if(request.getSession().getAttribute("login") == null)
            return true;*/

        /*if(request.getSession().getAttribute("login") != null)
            if(!request.getSession().getAttribute("perfil").equals("Administrador"))
                return true;*/
        
        if(request.getParameter("hacerSubmit") != null && !request.getParameter("hacerSubmit").equals("0"))
        {
            PreparedStatement stmt = null;
            ResultSet rs = null;
            int idProyecto;
            
            String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
            ruta = ruta.replaceAll("\\\\","/");

            try
            {
                c = new ConexionBaseDatos();
                c.abrirConexion();
                
                String archivoGuardar = null;
                if(!request.getParameter("nutrarchivo").isEmpty() && !request.getParameter("nutrarchivo").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("nutrarchivo")+"')";
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO nutricionvaloracion ( codtipoidentidad, nutridentifi, nutrcantidad, nutrfechatennutrfechaten, codfinalidadconsulta, coddiagnosticopr, coddiagnosticor1, coddiagnosticor2, coddiagnosticor3, coddiagnosticosa, nutrarchivo, archivofi, nutrobservac, ususiscodigo, fecharegistro, nutridregist) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ? )");
                    msj = "ingresada"; 
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE nutricionvaloracion SET ( codtipoidentidad, nutridentifi, nutrcantidad, nutrfechatennutrfechaten, codfinalidadconsulta, coddiagnosticopr, coddiagnosticor1, coddiagnosticor2, coddiagnosticor3, coddiagnosticosa, nutrarchivo, archivofi, nutrobservac, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ? ) WHERE nutridregist = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM nutricionvaloracion WHERE nutridregist = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("nutridregist")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    stmt.setString(1,request.getParameter("codtipoidentidad"));
                    stmt.setString(2,request.getParameter("nutridentifi").toUpperCase());                   
                    stmt.setInt(3,Integer.parseInt(request.getParameter("nutrcantidad")));
                    stmt.setDate(4,FormatosFecha.fechaToDate(request.getParameter("nutrfechatennutrfechaten")));
                    stmt.setString(5,request.getParameter("codfinalidadconsulta"));
                    stmt.setString(6,request.getParameter("coddiagnosticopr"));
                    stmt.setString(7,request.getParameter("coddiagnosticor1"));
                    stmt.setString(8,request.getParameter("coddiagnosticor2"));
                    stmt.setString(9,request.getParameter("coddiagnosticor3"));
                    stmt.setString(10,request.getParameter("coddiagnosticosa"));
                    stmt.setString(11,request.getParameter("nutrarchivo").toUpperCase());
                    stmt.setString(12,request.getParameter("nutrobservac").toUpperCase());
                    
                    stmt.setString(13, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(14,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(15,Integer.parseInt(request.getParameter("nutridregist")));
                                    
                }
                
                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                c.cerrarConexion();
                msj = "Acción No Válida"+e;
                request.setAttribute("msj",msj);
                return true;
            }
            
            msj = "La información ha sido " +msj+ " con éxito";  
            request.setAttribute("msj",msj);
            return true;
        }
        return true;
    }
}