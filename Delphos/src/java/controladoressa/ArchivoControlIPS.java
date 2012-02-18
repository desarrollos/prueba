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

public class ArchivoControlIPS implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO archivocontrolips ( codtiporips, cantidadregistros, codestregrips, ususiscodigo, fecharegistro, idencabezado, idregistro) values ( ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                    
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE archivocontrolips SET (codtiporips, cantidadregistros, codestregrips, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ? ) WHERE idencabezado = ? and idregistro = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM archivocontrolips WHERE idencabezado = ? and idregistro = ?");                 
                    
                    stmt.setInt(1,Integer.parseInt(request.getParameter("idencabezados")));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("idregistros")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                     

                    stmt.setString(1,request.getParameter("codtiporips"));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("cantidadregistros")));
                    stmt.setString(3,request.getParameter("codestregrips"));
                    
                    stmt.setString(4, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(5,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(6,Integer.parseInt(request.getParameter("idencabezados")));
                    stmt.setInt(7,Integer.parseInt(request.getParameter("idregistros")));
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