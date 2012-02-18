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

public class ActividadesNutricionales implements Control{
    
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
                if(!request.getParameter("nutregarchiv").isEmpty() && !request.getParameter("nutregarchiv").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("nutregarchiv")+"')";
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO nutricionregistro ( codtipoidentidadper, nutregideper, codtipoidentidadma, nutregidemad, nutregfecact, nutregfecreg, codtipoactividad, nutregarchiv, archivofi, nutregobserv, ususiscodigo, fecharegistro, nutregid) values ( ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE nutricionregistro SET ( codtipoidentidadper, nutregideper, codtipoidentidadma, nutregidemad, nutregfecact, nutregfecreg, codtipoactividad, nutregarchiv, archivofi, nutregobserv, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?) WHERE nutregid = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM nutricionregistro WHERE nutregid = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("nutregid")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {

                    stmt.setString(1,request.getParameter("codtipoidentidadper"));
                    stmt.setString(2,request.getParameter("nutregideper").toUpperCase());
                    stmt.setString(3,request.getParameter("codtipoidentidadma"));
                    stmt.setString(4,request.getParameter("nutregidemad").toUpperCase());
                    stmt.setDate(5,FormatosFecha.fechaToDate(request.getParameter("nutregfecact")));
                    stmt.setDate(6,FormatosFecha.fechaToDate(request.getParameter("nutregfecreg")));
                    stmt.setString(7,request.getParameter("codtipoactividad").toUpperCase());
                    stmt.setString(8,request.getParameter("nutregarchiv"));
                    stmt.setString(9,request.getParameter("nutregobserv").toUpperCase());     
                    
                    stmt.setString(10, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(11,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(12,Integer.parseInt(request.getParameter("nutregid")));
                }
                
                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                c.cerrarConexion();
                msj = "Acci�n No V�lida"+e;
                request.setAttribute("msj",msj);
                return true;
            }
            
            msj = "La informacion ha sido " +msj+ " con exito";
            request.setAttribute("msj",msj);
            return true;
        }
        return true;
    }
}