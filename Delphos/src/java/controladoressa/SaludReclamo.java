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

public class SaludReclamo implements Control{
    
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
                if(!request.getParameter("salrecarchivo").isEmpty() && !request.getParameter("salrecarchivo").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("salrecarchivo")+"')";
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO saludreclamo ( codtipoidentidadper, salrecidentidadper, salrecfecha, coddepartamento, codmunicipio, rectipcodigo, recclacodigo, codtipoidentidad, numidentfunc, salrecarchivo, archivofi, salrecobservacion, ususiscodigo, fecharegistro, salrecid) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE saludreclamo SET ( codtipoidentidadper, salrecidentidadper, salrecfecha, coddepartamento, codmunicipio, rectipcodigo, recclacodigo, codtipoidentidad, numidentfunc, salrecarchivo, archivofi, salrecobservacion, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ? ) WHERE salrecid = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM saludreclamo WHERE salrecid = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("salrecid")));                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    String depmun = request.getParameter("recclacodigo");
                    
                    String[] cad = depmun.split(" ");
                    
                    String depmun1 = request.getParameter("numidentfunc");
                    
                    String[] cad1 = depmun1.split(" ");
                    
                    stmt.setString(1,request.getParameter("codtipoidentidadper"));
                    stmt.setString(2,request.getParameter("salrecidentidadper").toUpperCase());
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("salrecfecha")));
                    stmt.setInt(4,Integer.parseInt(request.getParameter("coddepartamento")));
                    stmt.setInt(5,Integer.parseInt(request.getParameter("codmunicipio")));                  
                    stmt.setString(6,cad[0]);
                    stmt.setString(7,cad[1]);
                    stmt.setString(8,cad1[0]);
                    stmt.setString(9,cad1[1]);
                    stmt.setString(10,request.getParameter("salrecarchivo").toUpperCase());
                    stmt.setString(11,request.getParameter("salrecobservacion").toUpperCase());                    
                    
                    stmt.setString(12, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(13,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(14,Integer.parseInt(request.getParameter("salrecid")));                    
                    

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