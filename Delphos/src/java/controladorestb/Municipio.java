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

public class Municipio implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO municipio ( nombre, alcalde, secretariosalud, habitantes, ususiscodigo, fecharegistro, mapa, archivofi, coddepartamento, codmunicipio ) values ( ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ? )");
                    msj = "ingresada"; 
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE municipio SET ( nombre, alcalde, secretariosalud, habitantes, ususiscodigo, fecharegistro, mapa, archivofi ) = ( ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+" ) WHERE coddepartamento = ? and codmunicipio = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM municipio WHERE coddepartamento = ? and codmunicipio = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("coddepartamentos")));              
                    stmt.setInt(2,Integer.parseInt(request.getParameter("codmunicipios")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                        
                    stmt.setString(1,request.getParameter("nombremunicipio").toUpperCase());
                    stmt.setString(2,request.getParameter("alcalde").toUpperCase());
                    stmt.setString(3,request.getParameter("secretariosalud").toUpperCase());                    
                    stmt.setInt(4,Integer.parseInt(request.getParameter("habitantes")));                          
                    
                    stmt.setString(5, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(6,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(7,request.getParameter("mapa").toUpperCase());             
                    
                    stmt.setInt(8,Integer.parseInt(request.getParameter("coddepartamentos")));  
                    stmt.setInt(9,Integer.parseInt(request.getParameter("codmunicipios")));
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