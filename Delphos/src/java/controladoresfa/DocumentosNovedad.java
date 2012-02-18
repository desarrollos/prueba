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

public class DocumentosNovedad implements Control{
    
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
                if(!request.getParameter("novdocarchiv").isEmpty() && !request.getParameter("novdocarchiv").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("novdocarchiv")+"')";
                               
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO novedaddocumento ( codtipoidentidad, novdocidenti, novdocdescri, novdocarchiv, archivofi, ususiscodigo, fecharegistro, noveconsecut, codtipodctoasociado, codtiponovedad, novcaucodigo ) values ( ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE novedaddocumento SET ( codtipoidentidad, novdocidenti, novdocdescri, novdocarchiv, archivofi, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, "+archivoGuardar+", ?, ? ) WHERE noveconsecut = ? and codtipodctoasociado = ? and codtiponovedad = ? and novcaucodigo = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM novedaddocumento WHERE noveconsecut = ? and codtipodctoasociado = ? and codtiponovedad = ? and novcaucodigo = ?");
                    
                    String depmun = request.getParameter("novcaucodigos");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setInt(1,Integer.parseInt(request.getParameter("noveconsecuts")));
                    stmt.setString(2,cad[0]);
                    stmt.setString(3,cad[1]);
                    stmt.setString(4,cad[2]);
                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    String depmun = request.getParameter("novcaucodigos");
                    
                    String[] cad = depmun.split(" ");

                    stmt.setString(1,request.getParameter("codtipoidentidad"));
                    stmt.setString(2,request.getParameter("novdocidenti").toUpperCase());
                    stmt.setString(3,request.getParameter("novdocdescri").toUpperCase());
                    stmt.setString(4,request.getParameter("novdocarchiv").toUpperCase());    
                    
                    stmt.setString(5, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(6,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(7,Integer.parseInt(request.getParameter("noveconsecuts")));
                    stmt.setString(8,cad[0]);
                    stmt.setString(9,cad[1]);
                    stmt.setString(10,cad[2]);
                }
                
                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                c.cerrarConexion();
                msj = "Acci�n No V�lida" + e;
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