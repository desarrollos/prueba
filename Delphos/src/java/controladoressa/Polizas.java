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

public class Polizas implements Control{
    
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
                if(!request.getParameter("archivo").isEmpty() && !request.getParameter("archivo").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("archivo")+"')";
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO polizacontrato ( codregimenes, codentidadsalud, codcontrato, codtipopoliza, codtipoidentaseg, codempresaaseg, codtipoidenttomad, codempresatomador, fechainicial, fechafinal, valor, fechaexpedic, archivo, archivofi, ususiscodigo, fecharegistro, numeropoliza) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ? )");
                    msj = "ingresada";                    
                    
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE polizacontrato SET ( codregimenes, codentidadsalud, codcontrato, codtipopoliza, codtipoidentaseg, codempresaaseg, codtipoidenttomad, codempresatomador, fechainicial, fechafinal, valor, fechaexpedic, archivo, archivofi, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ? ) WHERE numeropoliza = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM polizacontrato WHERE numeropoliza = ?");
                    
                    stmt.setString(1,request.getParameter("numeropoliza"));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    String codase = request.getParameter("codempresaaseg");
                    
                    String[] cad1 = codase.split(" ");
                    
                    String codtom = request.getParameter("codempresatomador");
                    
                    String[] cad2 = codtom.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,cad [2]);
                    stmt.setString(4,request.getParameter("codtipopoliza"));
                    stmt.setString(5,cad1 [0]);
                    stmt.setString(6,cad1 [1]);
                    stmt.setString(7,cad2 [0]);
                    stmt.setString(8,cad2 [1]);
                    stmt.setDate(9,FormatosFecha.fechaToDate(request.getParameter("fechainicial")));
                    stmt.setDate(10,FormatosFecha.fechaToDate(request.getParameter("fechafinal")));
                    stmt.setDouble(11,Double.parseDouble(request.getParameter("valor"))); 
                    stmt.setDate(12,FormatosFecha.fechaToDate(request.getParameter("fechaexpedic")));
                    stmt.setString(13,request.getParameter("archivo").toUpperCase());
                    
                    stmt.setString(14, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(15,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(16,request.getParameter("numeropoliza"));

                }
                
                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                c.cerrarConexion();
                msj = "Acción No Válida";
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