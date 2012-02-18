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

public class TipoIdentificacion implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO tipoidentificacion ( codalterno, descripcion, ususiscodigo, fecharegistro, codtipoidentidad) values ( ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE tipoidentificacion SET ( codalterno, descripcion, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ? ) WHERE codtipoidentidad = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM tipoidentificacion WHERE codtipoidentidad = ?");
                    stmt.setString(1,request.getParameter("codtipoidentidad"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                        
                    stmt.setString(1,request.getParameter("codalterno").toUpperCase());
                    stmt.setString(2,request.getParameter("descripcion").toUpperCase());
                    
                    stmt.setString(3, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(4,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(5,request.getParameter("codtipoidentidad"));
                }
                
                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                if(e.getSQLState().equals("23503"))
                {
                    c.cerrarConexion();
                    msj = "Acci�n No V�lida";
                    request.setAttribute("msj",msj);
                    return true;
                }
                else
                {
                    c.cerrarConexion();
                    msj = "Acci�n No V�lida";
                    request.setAttribute("msj",msj);
                    return true;
                }
            }
            
            msj = "La informaci�n ha sido " +msj+ " con �xito";
            request.setAttribute("msj",msj);
            return true;
        }
        return true;
    }
}