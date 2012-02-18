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

public class DocumentosReclamos implements Control{
    
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
                if(!request.getParameter("recdocarchiv").isEmpty() && !request.getParameter("recdocarchiv").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("recdocarchiv")+"')";
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO reclamodocumento ( recdocentrga, recdocarchiv, archivofi, ususiscodigo, fecharegistro, codunifami, reclamconsec, codtipodctoasociado) values ( ?, ?, "+archivoGuardar+", ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE reclamodocumento SET ( recdocentrga, recdocarchiv, archivofi, ususiscodigo, fecharegistro ) = ( ?, ?, "+archivoGuardar+", ?, ? ) WHERE codunifami = ? and reclamconsec = ? and codtipodctoasociado = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM reclamodocumento WHERE codunifami = ? and reclamconsec = ? and codtipodctoasociado = ?");
                    
                    String depmun = request.getParameter("reclamconsecs");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad[0]);
                    stmt.setInt(2,Integer.parseInt(cad[1]));
                    stmt.setString(3,request.getParameter("codtipodctoasociados"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    String depmun = request.getParameter("reclamconsecs");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("recdocentrga").toUpperCase());
                    stmt.setString(2,request.getParameter("recdocarchiv").toUpperCase());
                    
                    stmt.setString(3, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(4,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(5,cad[0]);
                    stmt.setInt(6,Integer.parseInt(cad[1]));
                    stmt.setString(7,request.getParameter("codtipodctoasociados"));
                    
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