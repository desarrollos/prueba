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

public class ProgramaCiclo implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO programaciclo ( codesquemaactividad, aplicamujer, aplicahombre, ususiscodigo, fecharegistro, codprogramapromprev, codactividadsalud, codunidmedidaedad, edad) values ( ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE programaciclo SET ( codesquemaactividad, aplicamujer, aplicahombre, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ? ) WHERE codprogramapromprev = ? and codactividadsalud = ? and codunidmedidaedad = ? and edad = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM programaciclo WHERE codprogramapromprev = ? and codactividadsalud = ? and codunidmedidaedad = ? and edad = ?");
                    stmt.setString(1,request.getParameter("codprogramapromprevs"));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("codactividadsaluds")));                    
                    stmt.setString(3,request.getParameter("codunidmedidaedads"));
                    stmt.setInt(4,Integer.parseInt(request.getParameter("edads")));                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                        
                    stmt.setString(1,request.getParameter("codesquemaactividad"));
                    stmt.setString(2,request.getParameter("aplicamujer").toUpperCase());
                    stmt.setString(3,request.getParameter("aplicahombre").toUpperCase());
                    
                    stmt.setString(4, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(5,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(6,request.getParameter("codprogramapromprevs"));
                    stmt.setInt(7,Integer.parseInt(request.getParameter("codactividadsaluds")));                    
                    stmt.setString(8,request.getParameter("codunidmedidaedads"));
                    stmt.setInt(9,Integer.parseInt(request.getParameter("edads")));   
                }
                
                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                c.cerrarConexion();
                msj = "Acci�n No V�lida";
                request.setAttribute("msj",msj);
                return true;
            }
            
            msj = "La informaci�n ha sido " +msj+ " con �xito";  
            request.setAttribute("msj",msj);
            return true;
        }
        return true;
    }
}