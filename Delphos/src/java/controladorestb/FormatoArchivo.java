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

public class FormatoArchivo implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO formatoarchivo ( descripcion, formatofecha, separadorcampo, separadoralterno, separadordecimal, separadormil, observacion, ususiscodigo, fecharegistro, codclaseoperarch, consecutivo) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE formatoarchivo SET ( descripcion, formatofecha, separadorcampo, separadoralterno, separadordecimal, separadormil, observacion, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codclaseoperarch = ? and consecutivo = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM formatoarchivo WHERE codclaseoperarch = ? and consecutivo = ?");
                    stmt.setString(1,request.getParameter("codclaseoperarchs"));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("consecutivos")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                        
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setString(2,request.getParameter("formatofecha").toUpperCase());
                    stmt.setString(3,request.getParameter("separadorcampo").toUpperCase());
                    stmt.setString(4,request.getParameter("separadoralterno").toUpperCase());
                    stmt.setString(5,request.getParameter("separadordecimal").toUpperCase());                    
                    stmt.setString(6,request.getParameter("separadormil").toUpperCase());
                    stmt.setString(7,request.getParameter("observacion").toUpperCase());
                    
                    stmt.setString(8, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(9,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(10,request.getParameter("codclaseoperarchs"));
                    stmt.setInt(11,Integer.parseInt(request.getParameter("consecutivos")));
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