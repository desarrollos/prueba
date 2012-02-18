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

public class NovedadPorCampo implements Control{
    
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
            
            try
            {
                c = new ConexionBaseDatos();
                c.abrirConexion();
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO novedadcampo ( datoanterior, datoactualizado, observacion, ususiscodigo, fecharegistro, idusuario, codtiponovedad, codcampoarchivo, fecha) values ( ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE novedadcampo SET ( datoanterior, datoactualizado, observacion, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ? ) WHERE idusuario = ? and codtiponovedad = ? and codcampoarchivo = ? and fecha = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM novedadcampo WHERE idusuario = ? and codtiponovedad = ? and codcampoarchivo = ? and fecha = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("idusuarios")));
                    stmt.setString(2,request.getParameter("codtiponovedads"));
                    stmt.setInt(3,Integer.parseInt(request.getParameter("codcampoarchivos")));
                    stmt.setDate(4,FormatosFecha.fechaToDate(request.getParameter("fechas")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    stmt.setString(1,request.getParameter("datoanterior").toUpperCase());
                    stmt.setString(2,request.getParameter("datoactualizado").toUpperCase());
                    stmt.setString(3,request.getParameter("observacion").toUpperCase()); 
                    
                    stmt.setString(4, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(5,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(6,Integer.parseInt(request.getParameter("idusuarios")));
                    stmt.setString(7,request.getParameter("codtiponovedads"));
                    stmt.setInt(8,Integer.parseInt(request.getParameter("codcampoarchivos")));
                    stmt.setDate(9,FormatosFecha.fechaToDate(request.getParameter("fechas")));
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