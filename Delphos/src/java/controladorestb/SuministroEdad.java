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

public class SuministroEdad implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO suministroedad ( codunidmedidaedadfin, edadfinal, observacion, ususiscodigo, fecharegistro, codsuministro, codunidmedidaedadini, edadinicial) values ( ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                                        
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE suministroedad SET ( codunidmedidaedadfin, edadfinal, observacion, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ? ) WHERE codsuministro = ? and codunidmedidaedadini = ? and edadinicial = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM suministroedad WHERE codsuministro = ? and codunidmedidaedadini = ? and edadinicial = ?");
                    stmt.setString(1,request.getParameter("codsuministros"));
                    stmt.setString(2,request.getParameter("codunidmedidaedadinis"));
                    stmt.setInt(3,Integer.parseInt(request.getParameter("edadinicials")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    stmt.setString(1,request.getParameter("codunidmedidaedadfin"));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("edadfinal")));
                    stmt.setString(3,request.getParameter("observacion").toUpperCase());
                    stmt.setString(4, (String) request.getSession().getAttribute("login"));
                    
                    stmt.setTimestamp(5,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(6,request.getParameter("codsuministros"));
                    stmt.setString(7,request.getParameter("codunidmedidaedadinis"));
                    stmt.setInt(8,Integer.parseInt(request.getParameter("edadinicials")));
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