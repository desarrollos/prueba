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

public class ActividadIps implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO actividadips ( cantidad, codtipoperiodo, anyofinal, mesfinal, ususiscodigo, fecharegistro, codgrupoactividad, anyoinicial, mesinicial) values ( ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE actividadips SET ( cantidad, codtipoperiodo, anyofinal, mesfinal, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ? ) WHERE codgrupoactividad = ? and anyoinicial = ? and mesinicial = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM actividadips WHERE codgrupoactividad = ? and anyoinicial = ? and mesinicial = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("codgrupoactividads")));                    
                    stmt.setInt(2,Integer.parseInt(request.getParameter("anyoinicials")));                    
                    stmt.setInt(3,Integer.parseInt(request.getParameter("mesinicials")));                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                        
                    stmt.setInt(1,Integer.parseInt(request.getParameter("cantidad")));                    
                    stmt.setInt(2,Integer.parseInt(request.getParameter("codtipoperiodo")));                    
                    stmt.setInt(3,Integer.parseInt(request.getParameter("anyofinal")));  
                    stmt.setInt(4,Integer.parseInt(request.getParameter("mesfinal")));
                    
                    stmt.setString(5, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(6,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setInt(7,Integer.parseInt(request.getParameter("codgrupoactividads")));                    
                    stmt.setInt(8,Integer.parseInt(request.getParameter("anyoinicials")));                    
                    stmt.setInt(9,Integer.parseInt(request.getParameter("mesinicials")));
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