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

public class Normas implements Control{
    
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
            
            String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
            ruta = ruta.replaceAll("\\\\","/");
                      
            try
            {
                c = new ConexionBaseDatos();
                c.abrirConexion();
                
                String archivoGuardar = null;
                if(!request.getParameter("archivo").isEmpty() && !request.getParameter("archivo").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("archivo")+"')";

                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO normas ( referencia, archivo, archivofi, codestadonorma, ususiscodigo, fecharegistro, codtiponorma, codnorma, fechanorma) values ( ?, ?, "+archivoGuardar+", ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE normas SET ( referencia, archivo, archivofi, codestadonorma, ususiscodigo, fecharegistro ) = ( ?, ?, "+archivoGuardar+", ?, ?, ? ) WHERE codtiponorma = ? and codnorma = ? and fechanorma = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM normas WHERE codtiponorma = ? and codnorma = ? and fechanorma = ?");
                    stmt.setString(1,request.getParameter("codtiponormas"));
                    stmt.setString(2,request.getParameter("codnormas"));
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("fechanormas")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    stmt.setString(1,request.getParameter("referencia").toUpperCase());
                    stmt.setString(2,request.getParameter("archivo"));
                    stmt.setString(3,request.getParameter("codestadonorma"));
                    
                    stmt.setString(4, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(5,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(6,request.getParameter("codtiponormas"));
                    stmt.setString(7,request.getParameter("codnormas"));
                    stmt.setDate(8,FormatosFecha.fechaToDate(request.getParameter("fechanormas")));

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