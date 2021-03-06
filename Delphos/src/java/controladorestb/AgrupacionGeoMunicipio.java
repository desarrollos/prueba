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

public class AgrupacionGeoMunicipio implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO agrupaciongeomunicipio ( ususiscodigo, fecharegistro, codareageografica, coddepartamento, codmunicipio ) values ( ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE agrupaciongeomunicipio SET ( ususiscodigo, fecharegistro ) = ( ?, ? ) WHERE codareageografica = ? and coddepartamento = ? and codmunicipio = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM agrupaciongeomunicipio WHERE codareageografica = ? and coddepartamento = ? and codmunicipio = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("codareageograficas")));                    
                    stmt.setInt(2,Integer.parseInt(request.getParameter("coddepartamentos")));                    
                    stmt.setInt(3,Integer.parseInt(request.getParameter("codmunicipios")));                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    stmt.setString(1, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(2,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setInt(3,Integer.parseInt(request.getParameter("codareageograficas")));                    
                    stmt.setInt(4,Integer.parseInt(request.getParameter("coddepartamentos")));                    
                    stmt.setInt(5,Integer.parseInt(request.getParameter("codmunicipios")));
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