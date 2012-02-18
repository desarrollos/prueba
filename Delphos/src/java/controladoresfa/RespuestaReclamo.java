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

public class RespuestaReclamo implements Control{
    
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
                if(!request.getParameter("resrecarcdoc").isEmpty() && !request.getParameter("resrecarcdoc").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("resrecarcdoc")+"')";

                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO respuestareclamo ( resrecfecha, resclacodigo, codtipoidentidad, numidentfunc, resrecpercep, tipsatcodigo, resrecarcdoc, archivofi, resrecobserv, ususiscodigo, fecharegistro, codunifami, reclamconsec) values ( ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                                                         
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE respuestareclamo SET ( resrecfecha, resclacodigo, codtipoidentidad, numidentfunc, resrecpercep, tipsatcodigo, resrecarcdoc, archivofi, resrecobserv, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?) WHERE codunifami = ? and  reclamconsec = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM respuestareclamo WHERE codunifami = ? and  reclamconsec = ?");
                    
                    String depmun = request.getParameter("reclamconsecs");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad[0]);
                    stmt.setInt(2,Integer.parseInt(cad[1]));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    String depmun1 = request.getParameter("reclamconsecs");
                    
                    String[] cad1 = depmun1.split(" ");
                    
                    String depmun = request.getParameter("numidentfuncs");
                    
                    String[] cad = depmun.split(" ");
          
                    stmt.setDate(1,FormatosFecha.fechaToDate(request.getParameter("resrecfecha")));
                    stmt.setString(2,request.getParameter("resclacodigo"));
                    stmt.setString(3,cad[0]);
                    stmt.setString(4,cad[1]);
                    stmt.setString(5,request.getParameter("resrecpercep").toUpperCase());
                    stmt.setString(6,request.getParameter("tipsatcodigo"));
                    stmt.setString(7,request.getParameter("resrecarcdoc").toUpperCase());
                    stmt.setString(8,request.getParameter("resrecobserv").toUpperCase());
                     
                    stmt.setString(9, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(10,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(11,cad1[0]);
                    stmt.setInt(12,Integer.parseInt(cad1[1]));
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