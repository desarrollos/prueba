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

public class RegistroNovedad implements Control{
    
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
                if(!request.getParameter("novearchivo").isEmpty() && !request.getParameter("novearchivo").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("novearchivo")+"')";
                               
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO novedad ( codunifami, codtipoidentidad, noveidentifi, codtiponovedad, novcaucodigo, novefechsoli, novefechnove, tippercodigo, novearchivo, archivofi, noveobservac, ususiscodigo, fecharegistro, noveconsecut) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE novedad SET ( codunifami, codtipoidentidad, noveidentifi, codtiponovedad, novcaucodigo, novefechsoli, novefechnove, tippercodigo, novearchivo, archivofi, noveobservac, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ? ) WHERE noveconsecut = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM novedad WHERE noveconsecut = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("noveconsecut")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("novcaucodigo");
                    
                    String[] cad = depmun.split(" ");

                    
                    stmt.setString(1,request.getParameter("codunifami"));
                    stmt.setString(2,request.getParameter("codtipoidentidad"));                   
                    stmt.setString(3,request.getParameter("noveidentifi").toUpperCase());
                    stmt.setString(4,cad[0]);
                    stmt.setString(5,cad[1]);
                    //stmt.setString(4,request.getParameter("codtiponovedad").toUpperCase());
                    //stmt.setString(5,request.getParameter("novcaucodigo").toUpperCase());
                    stmt.setDate(6,FormatosFecha.fechaToDate(request.getParameter("novefechsoli")));
                    stmt.setDate(7,FormatosFecha.fechaToDate(request.getParameter("novefechnove")));
                    stmt.setString(8,request.getParameter("tippercodigo"));
                    stmt.setString(9,request.getParameter("novearchivo").toUpperCase());
                    stmt.setString(10,request.getParameter("noveobservac").toUpperCase()); 
                    
                    stmt.setString(11, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(12,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(13,Integer.parseInt(request.getParameter("noveconsecut")));
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