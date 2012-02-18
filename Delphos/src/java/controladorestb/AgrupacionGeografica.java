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

public class AgrupacionGeografica implements Control{
    
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
                if(!request.getParameter("mapa").isEmpty() && !request.getParameter("mapa").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("mapa")+"')";
               
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO agrupaciongeografica ( descripcion, habitantes, regionoficial, ususiscodigo, fecharegistro, mapa, archivofi, codareageografica) values ( ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ? )");
                    msj = "ingresada"; 
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE agrupaciongeografica SET ( descripcion,  habitantes, regionoficial, ususiscodigo, fecharegistro, mapa, archivofi ) = ( ?, ?, ?, ?, ?, ?, "+archivoGuardar+" ) WHERE codareageografica = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM agrupaciongeografica WHERE codareageografica = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("codareageografica")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setInt(2,Integer.parseInt(request.getParameter("habitantes")));
                    stmt.setString(3,request.getParameter("regionoficial").toUpperCase());
                    
                    stmt.setString(4, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(5,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(6,request.getParameter("mapa"));             
                    
                    stmt.setInt(7,Integer.parseInt(request.getParameter("codareageografica")));
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