package controladores;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.ConexionBaseDatos;
import clases.FormatosFecha;
import clases.bdS;
import clases.ed_ValidarArchivo;

public class RecepcionArchivo implements Control{
    
    private String msj;
    
    
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
            Connection conexion = bdS.getConexion();
            PreparedStatement stmt = null;
            ResultSet rs = null;
            int idProyecto;
            
            
            try
            {
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = conexion.prepareStatement("INSERT INTO encabezadoarchivo ( codregimenes, codentidadsalud, fechainicial, fechafinal, codarchivo, coddepartamento, codmunicipio, nombrearchivo, codtipoarchivo, nombreenvia, telefonoenvia, emailenvia, fechaenvio, horaenvio, fecharecibo, registros, copiadctoremis, proceso, idencabezado) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                    stmt.setInt(19,Integer.parseInt(request.getParameter("idencabezado")));

                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = conexion.prepareStatement("UPDATE encabezadoarchivo SET (codregimenes, codentidadsalud, fechainicial, fechafinal, codarchivo, coddepartamento, codmunicipio, nombrearchivo, codtipoarchivo, nombreenvia, telefonoenvia, emailenvia, fechaenvio, horaenvio, fecharecibo, registros, copiadctoremis, proceso) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE idencabezado = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = conexion.prepareStatement("DELETE FROM encabezadoarchivo WHERE idencabezado = ?");
                    
                    stmt.setInt(1,Integer.parseInt(request.getParameter("idencabezado")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    Time hora = Time.valueOf(request.getParameter("horaenvio") + ":" + request.getParameter("horaenviomin") +":00");
                    
                    String depmun = request.getParameter("codentidadsalud");
                    
                    String[] cad = depmun.split(" ");
                                       
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("fechainicial")));
                    stmt.setDate(4,FormatosFecha.fechaToDate(request.getParameter("fechafinal")));
                    stmt.setString(5,request.getParameter("codarchivo").toUpperCase());
                    stmt.setInt(6,Integer.parseInt(request.getParameter("coddepartamento")));
                    stmt.setInt(7,Integer.parseInt(request.getParameter("codmunicipio")));
                    stmt.setString(8,request.getParameter("nombrearchivo").toUpperCase());
                    stmt.setString(9,request.getParameter("codtipoarchivo").toUpperCase());
                    stmt.setString(10,request.getParameter("nombreenvia").toUpperCase());
                    stmt.setString(11,request.getParameter("telefonoenvia").toUpperCase());
                    stmt.setString(12,request.getParameter("emailenvia").toUpperCase());
                    stmt.setDate(13,FormatosFecha.fechaToDate(request.getParameter("fechaenvio")));
                    stmt.setTime(14,hora);
                    stmt.setDate(15,FormatosFecha.fechaToDate(request.getParameter("fecharecibo")));
                    stmt.setInt(16,Integer.parseInt(request.getParameter("registros")));
                    stmt.setString(17,request.getParameter("copiadctoremis").toUpperCase());
                    stmt.setString(18,request.getParameter("proceso").toUpperCase());
                    stmt.setInt(19,Integer.parseInt(request.getParameter("idencabezado")));
                }
                
                stmt.executeUpdate();
                stmt.close();

                
            }
            catch(SQLException e)
            {
                ed_ValidarArchivo v = new ed_ValidarArchivo();
                v.generarLog(String.valueOf( request.getParameter("idencabezado")), e.getMessage());
                v = null;
                msj = "Error al Actualizar la Base de Datos: "+e+"<br>\n<script>alert('Error al Actualizar el Proyecto')</script>";
                request.setAttribute("msj",msj);
                return true;
            }
            
            msj = "La información ha sido " +msj+ " con exito<br>"
                  +"\n<script>alert('La información ha sido " +msj+ " con exito!')</script>"
                  +"<script>window.top.location='RecepcionArchivo.jsp';</script>";

            request.setAttribute("msj",msj);
            return true;
        }
        return true;
    }
}