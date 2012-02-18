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

public class CuentaContable implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO cuentacontable ( descripcion, codgrupocuencontab, codtipocuentacontable, tercero, movimiento, codestadocuencontab, coddisponibcuencontab, codnaturacuencontab, ususiscodigo, fecharegistro, codcuentacontable) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE cuentacontable SET ( descripcion, codgrupocuencontab, codtipocuentacontable, tercero, movimiento, codestadocuencontab, coddisponibcuencontab, codnaturacuencontab, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codcuentacontable = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM cuentacontable WHERE codcuentacontable = ?");
                    stmt.setString(1,request.getParameter("codcuentacontable"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setString(2,request.getParameter("codgrupocuencontab"));
                    stmt.setString(3,request.getParameter("codtipocuentacontable"));
                    stmt.setString(4,request.getParameter("tercero").toUpperCase());
                    stmt.setString(5,request.getParameter("movimiento").toUpperCase());
                    stmt.setString(6,request.getParameter("codestadocuencontab"));
                    stmt.setString(7,request.getParameter("coddisponibcuencontab"));
                    stmt.setString(8,request.getParameter("codnaturacuencontab"));
                    
                    stmt.setString(9, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(10,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(11,request.getParameter("codcuentacontable"));

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