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

public class ActividadPaquete implements Control{
    
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
            
                      
            try
            {
                c = new ConexionBaseDatos();
                c.abrirConexion();
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO actividadpaquete ( descripcion, cantidadminima, cantidadmaxima, cantidadpromedio, ususiscodigo, fecharegistro, codactividadsaludppal, codactividadsaluddpdte, codinsumo) values ( ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE actividadpaquete SET ( descripcion, cantidadminima, cantidadmaxima, cantidadpromedio, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ? ) WHERE codactividadsaludppal = ? and codactividadsaluddpdte = ? and codinsumo = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM actividadpaquete WHERE codactividadsaludppal = ? and codactividadsaluddpdte = ? and codinsumo = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("codactividadsaludppal")));                    
                    stmt.setInt(2,Integer.parseInt(request.getParameter("codactividadsaluddpdte")));                    
                    stmt.setString(3,request.getParameter("codinsumo"));                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setInt(2,Integer.parseInt(request.getParameter("cantidadminima")));                    
                    stmt.setInt(3,Integer.parseInt(request.getParameter("cantidadmaxima")));  
                    stmt.setInt(4,Integer.parseInt(request.getParameter("cantidadpromedio")));
                    
                    stmt.setString(5, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(6,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setInt(7,Integer.parseInt(request.getParameter("codactividadsaludppal")));                    
                    stmt.setInt(8,Integer.parseInt(request.getParameter("codactividadsaluddpdte")));                    
                    stmt.setString(9,request.getParameter("codinsumo"));                    

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