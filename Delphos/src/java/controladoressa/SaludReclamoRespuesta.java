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

public class SaludReclamoRespuesta implements Control{
    
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
                if(!request.getParameter("sarerearchivo").isEmpty() && !request.getParameter("sarerearchivo").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("sarerearchivo")+"')";

                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO saludreclamorespuesta ( sarerefecha, codtipoidentidad, numidentfunc, sarerepercepcion, tipsatcodigo, sarerearchivo, archivofi, sarereobservacion, ususiscodigo, fecharegistro, salrecid, resclacodigo) values ( ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE saludreclamorespuesta SET ( sarerefecha, codtipoidentidad, numidentfunc, sarerepercepcion, tipsatcodigo, sarerearchivo, archivofi, sarereobservacion, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ? ) WHERE salrecid = ? and resclacodigo = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM saludreclamorespuesta WHERE salrecid = ? and resclacodigo = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("salrecids")));   
                    stmt.setString(2,request.getParameter("resclacodigos"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    String depmun1 = request.getParameter("numidentfunc");
                    
                    String[] cad1 = depmun1.split(" ");
                    
                    stmt.setDate(1,FormatosFecha.fechaToDate(request.getParameter("sarerefecha")));
                    stmt.setString(2,cad1[0]);
                    stmt.setString(3,cad1[1]);
                    stmt.setString(4,request.getParameter("sarerepercepcion").toUpperCase());
                    stmt.setString(5,request.getParameter("tipsatcodigo"));
                    stmt.setString(6,request.getParameter("sarerearchivo").toUpperCase());
                    stmt.setString(7,request.getParameter("sarereobservacion").toUpperCase());                    
                    
                    stmt.setString(8, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(9,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(10,Integer.parseInt(request.getParameter("salrecids")));                    
                    stmt.setString(11,request.getParameter("resclacodigos"));

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