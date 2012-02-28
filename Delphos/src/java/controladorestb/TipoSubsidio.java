package controladores;

import controladores.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.ConexionBaseDatos;
import clases.FormatosFecha;
import clases.FormatoTimestamp;

public class TipoSubsidio implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO tiposubsidio ( subtipdescri, subtipedaini, subtipedafin, subtipgraini, subtipgrafin, subcatcodigo, ususiscodigo, fecharegistro, subtipcodigo) values ( ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE tiposubsidio SET ( subtipdescri, subtipedaini, subtipedafin, subtipgraini, subtipgrafin, subcatcodigo, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ? ) WHERE subtipcodigo = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM tiposubsidio WHERE subtipcodigo = ?");
                    stmt.setString(1,request.getParameter("subtipcodigo"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                        
                    stmt.setString(1,request.getParameter("subtipdescri").toUpperCase());
                    stmt.setInt(2,Integer.parseInt(request.getParameter("subtipedaini")));
                    stmt.setInt(3,Integer.parseInt(request.getParameter("subtipedafin")));
                    stmt.setString(4,request.getParameter("subtipgraini"));
                    stmt.setString(5,request.getParameter("subtipgrafin"));
                    stmt.setString(6,request.getParameter("subcatcodigo"));
                    
                    stmt.setString(7, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(8,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(9,request.getParameter("subtipcodigo"));
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