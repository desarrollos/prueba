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

public class EstructuraArchivo implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO estructuraarchivo ( posicionarchivo, separador, posicioninicial, posicionfinal, aplicacotizante, aplicabeneficiario, permitenulo, codtipoentidadsalud, ususiscodigo, fecharegistro, codtipoestrucarch, codcampoarchivo) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                                       
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE estructuraarchivo SET (posicionarchivo, separador, posicioninicial, posicionfinal, aplicacotizante, aplicabeneficiario, permitenulo, codtipoentidadsalud, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codtipoestrucarch = ? and codcampoarchivo = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM estructuraarchivo WHERE codtipoestrucarch = ? and codcampoarchivo = ?");
                    
                    stmt.setString(1,request.getParameter("codtipoestrucarchs"));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("codcampoarchivos")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {   
                    stmt.setInt(1,Integer.parseInt(request.getParameter("posicionarchivo")));
                    stmt.setString(2,request.getParameter("separador").toUpperCase());
                    stmt.setInt(3,Integer.parseInt(request.getParameter("posicioninicial")));
                    stmt.setInt(4,Integer.parseInt(request.getParameter("posicionfinal")));
                    stmt.setString(5,request.getParameter("aplicacotizante").toUpperCase());
                    stmt.setString(6,request.getParameter("aplicabeneficiario").toUpperCase());
                    stmt.setString(7,request.getParameter("permitenulo").toUpperCase());
                    stmt.setString(8,request.getParameter("codtipoentidadsalud"));
                    
                    stmt.setString(9, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(10,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(11,request.getParameter("codtipoestrucarchs"));
                    stmt.setInt(12,Integer.parseInt(request.getParameter("codcampoarchivos")));

                }
                
                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                c.cerrarConexion();
                msj = "Acción No Válida" + e;
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