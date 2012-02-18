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

public class RegistroEstimulacionTemprana implements Control{
    
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
                if(!request.getParameter("esttemarchiv").isEmpty() && !request.getParameter("esttemarchiv").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("esttemarchiv")+"')";
                               
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO estimulaciontemprana ( codtipoidentidad, esttemidenti, esttemfecact, esttemquien, tipestcodigo, esttemaccion, esttemarchiv, archivofi, esttemobserv, ususiscodigo, fecharegistro, esttemid) values ( ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE estimulaciontemprana SET ( codtipoidentidad, esttemidenti, esttemfecact, esttemquien, tipestcodigo, esttemaccion, esttemarchiv, archivofi, esttemobserv, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?) WHERE esttemid = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM estimulaciontemprana WHERE esttemid = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("esttemid")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {

                    stmt.setString(1,request.getParameter("codtipoidentidad"));
                    stmt.setString(2,request.getParameter("esttemidenti").toUpperCase());
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("esttemfecact")));
                    stmt.setString(4,request.getParameter("esttemquien").toUpperCase());
                    stmt.setString(5,request.getParameter("tipestcodigo"));
                    stmt.setString(6,request.getParameter("esttemaccion").toUpperCase());
                    stmt.setString(7,request.getParameter("esttemarchiv").toUpperCase());
                    stmt.setString(8,request.getParameter("esttemobserv").toUpperCase());
                    
                    stmt.setString(9, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(10,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(11,Integer.parseInt(request.getParameter("esttemid")));
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