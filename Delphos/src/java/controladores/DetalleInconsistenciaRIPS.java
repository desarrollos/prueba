package controladores;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.ConexionBaseDatos;
import clases.FormatosFecha;

public class DetalleInconsistenciaRIPS implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO inconsarchivorips ( idregistro, codtipoincarch, codtipoglosarips, idencabezado, codtiporips, codcampoarchivo) values ( ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                    stmt.setInt(4,Integer.parseInt(request.getParameter("idencabezado")));
                    stmt.setString(5,request.getParameter("codtiporips").toUpperCase());
                    stmt.setInt(6,Integer.parseInt(request.getParameter("codcampoarchivo")));

                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE inconsarchivorips SET (idregistro, codtipoincarch, codtipoglosarips) = ( ?, ?, ? ) WHERE idregistro = ? and idencabezado = ? and codcampoarchivo = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM inconsarchivorips WHERE idregistro = ? and idencabezado = ? and codcampoarchivo = ?");                 
                    
                    stmt.setInt(1,Integer.parseInt(request.getParameter("idencabezado")));
                    stmt.setString(2,request.getParameter("codtiporips").toUpperCase());
                    stmt.setInt(3,Integer.parseInt(request.getParameter("codcampoarchivo")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                     
                    stmt.setInt(1,Integer.parseInt(request.getParameter("idregistro")));
                    stmt.setString(2,request.getParameter("codtipoincarch").toUpperCase());
                    stmt.setString(3,request.getParameter("codtipoglosarips").toUpperCase());
                    stmt.setInt(4,Integer.parseInt(request.getParameter("idencabezado")));
                    stmt.setString(5,request.getParameter("codtiporips").toUpperCase());
                    stmt.setInt(6,Integer.parseInt(request.getParameter("codcampoarchivo")));
                }
                
                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                c.cerrarConexion();
                msj = "Error al Actualizar la Base de Datos: "+e+"<br>\n<script>alert('Error al Actualizar el Proyecto')</script>";
                request.setAttribute("msj",msj);
                return true;
            }
            
            msj = "La información ha sido " +msj+ " con exito<br>"
                  +"\n<script>alert('La información ha sido " +msj+ " con exito!')</script>"
                  +"<script>window.top.location='DetalleInconsistenciaRIPS.jsp';</script>";

            request.setAttribute("msj",msj);
            return true;
        }
        return true;
    }
}