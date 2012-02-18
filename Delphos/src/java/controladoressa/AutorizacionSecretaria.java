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

public class AutorizacionSecretaria implements Control{
    
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
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO autorizacionsecretaria (codigoips, nombreips, tipoidentpaciente, identpaciente, codigoeapbafiliac, nombreeapb, fechaactual, fechaingreso, nombre1, nombre2, apellido1, apellido2, archivo, archivofi, ususiscodigo, fecharegistro, idautorizacion) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, lo_import('"+ruta+request.getParameter("archivo")+"'), ?, ?, ? )");                    
                    msj = "ingresada";                    
                    
                    stmt.setInt(16,Integer.parseInt(request.getParameter("idautorizacion")));

                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE autorizacionsecretaria SET (codigoips, nombreips, tipoidentpaciente, identpaciente, codigoeapbafiliac, nombreeapb, fechaactual, fechaingreso, nombre1, nombre2, apellido1, apellido2, archivo, archivofi, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, lo_import('"+ruta+request.getParameter("archivo")+"'), ?, ? ) WHERE idautorizacion = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM autorizacionsecretaria WHERE idautorizacion = ?");
                    
                    stmt.setInt(1,Integer.parseInt(request.getParameter("idautorizacion")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    stmt.setString(1,request.getParameter("codigoips").toUpperCase());
                    stmt.setString(2,request.getParameter("nombreips").toUpperCase());
                    stmt.setString(3,request.getParameter("tipoidentpaciente").toUpperCase());
                    stmt.setString(4,request.getParameter("identpaciente").toUpperCase());
                    stmt.setString(5,request.getParameter("codigoeapbafiliac").toUpperCase());
                    stmt.setString(6,request.getParameter("nombreeapb").toUpperCase());
                    
                    stmt.setTimestamp(7,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(request.getParameter("fechaactual"))));
                    stmt.setDate(8,FormatosFecha.fechaToDate(request.getParameter("fechaingreso")));
                    stmt.setString(9,request.getParameter("nombre1").toUpperCase());
                    stmt.setString(10,request.getParameter("nombre2").toUpperCase());
                    stmt.setString(11,request.getParameter("apellido1").toUpperCase());
                    stmt.setString(12,request.getParameter("apellido2").toUpperCase());
                    stmt.setString(13,request.getParameter("archivo").toUpperCase());
                                        
                    stmt.setString(14, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(15,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(16,Integer.parseInt(request.getParameter("idautorizacion")));

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