package controladores;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.ConexionBaseDatos;
import clases.FormatosFecha;

public class EntregaBD implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO entregabd ( consecutivo, nombrearchivo, fechaentrega, fechainicbd, fechafinalbd, nroregistros, archivo, codregimenes, codentidadsalud) values ( ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                    String depmun = request.getParameter("codentidadsalud");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(8,cad [0]);
                    stmt.setString(9,cad [1]);

                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE entregabd SET (consecutivo, nombrearchivo, fechaentrega, fechainicbd, fechafinalbd, nroregistros, archivo) = ( ?, ?, ?, ?, ?, ?, ? ) WHERE codregimenes = ? and codentidadsalud = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM entregabd WHERE codregimenes = ? and codentidadsalud = ?");
                    
                    String depmun = request.getParameter("codentidadsalud");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codentidadsalud");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setInt(1,Integer.parseInt(request.getParameter("consecutivo")));
                    stmt.setString(2,request.getParameter("nombrearchivo").toUpperCase());
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("fechaentrega")));
                    stmt.setDate(4,FormatosFecha.fechaToDate(request.getParameter("fechainicbd")));
                    stmt.setDate(5,FormatosFecha.fechaToDate(request.getParameter("fechafinalbd")));
                    stmt.setInt(6,Integer.parseInt(request.getParameter("nroregistros")));
                    stmt.setString(7,request.getParameter("archivo").toUpperCase());
                    stmt.setString(8,cad [0]);
                    stmt.setString(9,cad [1]);

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
                  +"<script>window.top.location='EntregaBD.jsp';</script>";

            request.setAttribute("msj",msj);
            return true;
        }
        return true;
    }
}