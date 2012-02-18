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

public class RecepcionArchivoRIPS implements Control{
    
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
                    //stmt = c.con.prepareStatement("INSERT INTO encabezadoarchivo ( codregimenes, codentidadsalud, fechainicial, fechafinal, codarchivo, coddepartamento, codmunicipio, nombrearchivo, archivofi, codtipoarchivo, nombreenvia, telefonoenvia, emailenvia, fechaenvio, fecharecibo, registros, copiadctoremis, proceso, ususiscodigo, fecharegistro, idencabezado) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    stmt = c.con.prepareStatement("INSERT INTO encabezadoarchivo ( codregimenes, codentidadsalud, fechainicial, fechafinal, codarchivo, coddepartamento, codmunicipio, nombrearchivo, codtipoarchivo, nombreenvia, telefonoenvia, emailenvia, fechaenvio, fecharecibo, registros, copiadctoremis, proceso, ususiscodigo, fecharegistro, idencabezado) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                    
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    //stmt = c.con.prepareStatement("UPDATE encabezadoarchivo SET (codregimenes, codentidadsalud, fechainicial, fechafinal, codarchivo, coddepartamento, codmunicipio, nombrearchivo, archivofi, codtipoarchivo, nombreenvia, telefonoenvia, emailenvia, fechaenvio, fecharecibo, registros, copiadctoremis, proceso, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE idencabezado = ?");
                    stmt = c.con.prepareStatement("UPDATE encabezadoarchivo SET (codregimenes, codentidadsalud, fechainicial, fechafinal, codarchivo, coddepartamento, codmunicipio, nombrearchivo, codtipoarchivo, nombreenvia, telefonoenvia, emailenvia, fechaenvio, fecharecibo, registros, copiadctoremis, proceso, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE idencabezado = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM encabezadoarchivo WHERE idencabezado = ?");                 
                    
                    stmt.setInt(1,Integer.parseInt(request.getParameter("idencabezado")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                
                    //String depmun = request.getParameter("codentidadsalud");
                    
                    //String[] cad = depmun.split(" ");
                                       
                    //stmt.setString(1,cad [0]);
                    //stmt.setString(2,cad [1]);
                    stmt.setString(1,request.getParameter("codregimenes").toUpperCase());
                    stmt.setString(2,request.getParameter("codentidadsalud").toUpperCase());
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("fechainicial")));
                    stmt.setDate(4,FormatosFecha.fechaToDate(request.getParameter("fechafinal")));
                    stmt.setString(5,request.getParameter("codarchivo").toUpperCase());
                    stmt.setInt(6,Integer.parseInt(request.getParameter("coddepartamento")));
                    stmt.setInt(7,Integer.parseInt(request.getParameter("codmunicipio")));
                    stmt.setString(8,request.getParameter("nombrearchivo").toUpperCase());
                    //archivofi oid, -- Archivo Fisico de Afiliación en BD
                    stmt.setString(9,request.getParameter("codtipoarchivo").toUpperCase());
                    stmt.setString(10,request.getParameter("nombreenvia").toUpperCase());
                    stmt.setString(11,request.getParameter("telefonoenvia").toUpperCase());
                    stmt.setString(12,request.getParameter("emailenvia").toUpperCase());
                    stmt.setTimestamp(13,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(request.getParameter("fechaenvio"))));
                    stmt.setTimestamp(14,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(request.getParameter("fecharecibo"))));
                    stmt.setInt(15,Integer.parseInt(request.getParameter("registros")));
                    stmt.setString(16,request.getParameter("copiadctoremis").toUpperCase());
                    stmt.setString(17,request.getParameter("proceso").toUpperCase());
                    
                    stmt.setString(18, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(19,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(20,Integer.parseInt(request.getParameter("idencabezado")));
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
                  +"<script>window.top.location='RecepcionArchivoRIPS.jsp';</script>";

            request.setAttribute("msj",msj);
            return true;
        }
        return true;
    }
}