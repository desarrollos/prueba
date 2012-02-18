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

public class SaludQueja implements Control{
    
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
                if(!request.getParameter("salquearchivo").isEmpty() && !request.getParameter("salquearchivo").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("salquearchivo")+"')";
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO saludqueja ( codtipoidentidadper, salqueidentidadper, salquefecha, tipquecodigo, queclacodigo, codtipoidentidad, numidentfunc, salquearchivo, archivofi, salqueobservacion, ususiscodigo, fecharegistro, salqueid) values ( ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE saludqueja SET ( codtipoidentidadper, salqueidentidadper, salquefecha, tipquecodigo, queclacodigo, codtipoidentidad, numidentfunc, salquearchivo, archivofi, salqueobservacion, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ? ) WHERE salqueid = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM saludqueja WHERE salqueid = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("salqueid")));                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    String depmun = request.getParameter("queclacodigo");
                    
                    String[] cad = depmun.split(" ");
                    
                    String depmun1 = request.getParameter("numidentfunc");
                    
                    String[] cad1 = depmun1.split(" ");
                    
                    stmt.setString(1,request.getParameter("codtipoidentidadper"));
                    stmt.setString(2,request.getParameter("salqueidentidadper").toUpperCase());
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("salquefecha")));                    
                    stmt.setString(4,cad[0]);
                    stmt.setString(5,cad[1]);
                    stmt.setString(6,cad1[0]);
                    stmt.setString(7,cad1[1]);
                    stmt.setString(8,request.getParameter("salquearchivo").toUpperCase());
                    stmt.setString(9,request.getParameter("salqueobservacion").toUpperCase());                    
                    
                    stmt.setString(10, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(11,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(12,Integer.parseInt(request.getParameter("salqueid")));                    
                    

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