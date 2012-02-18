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

public class Barrio implements Control{
    
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
                if(!request.getParameter("mapa").isEmpty() && !request.getParameter("mapa").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("mapa")+"')";
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO barrio ( nombre, representante, habitantes, ususiscodigo, fecharegistro, mapa, archivofi, coddepartamento, codmunicipio, codsubgrupo, codbarrio ) values ( ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE barrio SET ( nombre, representante, habitantes, ususiscodigo, fecharegistro, mapa, archivofi ) = ( ?, ?, ?, ?, ?, ?, "+archivoGuardar+" ) WHERE coddepartamento = ? and codmunicipio = ? and codsubgrupo = ? and codbarrio = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM barrio WHERE coddepartamento = ? and codmunicipio = ? and codsubgrupo = ? and codbarrio = ?");
                    
                    String depmun = request.getParameter("codsubgrupos");                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setInt(1,Integer.parseInt(cad[0]));                    
                    stmt.setInt(2,Integer.parseInt(cad[1]));                    
                    stmt.setInt(3,Integer.parseInt(cad[2]));                     
                    stmt.setInt(4,Integer.parseInt(request.getParameter("codbarrios")));                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                        
                    String depmun = request.getParameter("codsubgrupos");                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("nombrebarrio").toUpperCase());
                    stmt.setString(2,request.getParameter("representante").toUpperCase());
                    stmt.setInt(3,Integer.parseInt(request.getParameter("habitantes")));                    
                                        
                    stmt.setString(4, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(5,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(6,request.getParameter("mapa"));
                    
                    stmt.setInt(7,Integer.parseInt(cad[0]));                    
                    stmt.setInt(8,Integer.parseInt(cad[1]));                    
                    stmt.setInt(9,Integer.parseInt(cad[2]));                    
                    stmt.setInt(10,Integer.parseInt(request.getParameter("codbarrios")));
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