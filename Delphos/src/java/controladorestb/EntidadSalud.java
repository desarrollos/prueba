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

public class EntidadSalud implements Control{
    
    private String msj;
    private ConexionBaseDatos c;    
    
    public boolean doLogic(javax.servlet.http.HttpServletRequest request,
            javax.servlet.http.HttpServletResponse response)
            throws javax.servlet.ServletException, java.io.IOException
    {
     
        if(request.getParameter("hacerSubmit") != null && !request.getParameter("hacerSubmit").equals("0"))
        {
            PreparedStatement stmt = null;
            ResultSet rs = null;
            int idProyecto;
            
            String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
            ruta = ruta.replaceAll("\\\\","/");
                      
            try
            {
                    System.out.println("ENTRA");
                    c = new ConexionBaseDatos();
                    c.abrirConexion();

                    String archivoGuardar = null;
                    if(!request.getParameter("archivoactoadmin").isEmpty() && !request.getParameter("archivoactoadmin").equals(null))
                        archivoGuardar = "lo_import('"+ruta+request.getParameter("archivoactoadmin")+"')";
                    String archivoGuardar2 = null;
                    if(!request.getParameter("logo").isEmpty() && !request.getParameter("logo").equals(null))
                        archivoGuardar2 = "lo_import('"+ruta+request.getParameter("logo")+"')";

                    if( request.getParameter("hacerSubmit").equals("1") )
                    {
                        stmt = c.con.prepareStatement("INSERT INTO entidadsalud ( codtipoidentidad, codempresa, codtipoentidadsalud, codnivelcomplejidad, codclasifentidad, contacto, cargocontacto, lineagratuita, funcionarios, codigobarras, slogan, codhabilitacion, nombrehabilitacion, codtipoespecializacion, codtipoatencion, codestadoentidad, numactoinscripcion, fechaactoadmin, archivoactoadmin, archivofi, logo, archivofi2, ususiscodigo, fecharegistro, codregimenes, codentidadsalud) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, "+archivoGuardar2+", ?, ?, ?, ? )");
                        msj = "ingresada";
                    }
                    else if( request.getParameter("hacerSubmit").equals("2") )
                    {
                        stmt = c.con.prepareStatement("UPDATE entidadsalud SET ( codtipoidentidad, codempresa, codtipoentidadsalud, codnivelcomplejidad, codclasifentidad, contacto, cargocontacto, lineagratuita, funcionarios, codigobarras, slogan, codhabilitacion, nombrehabilitacion, codtipoespecializacion, codtipoatencion, codestadoentidad, numactoinscripcion, fechaactoadmin, archivoactoadmin, archivofi, logo, archivofi2, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, "+archivoGuardar2+", ?, ? ) WHERE codregimenes = ? and codentidadsalud = ?");
                        msj = "modificada";                                        
                    }
                    else
                    {
                    stmt = c.con.prepareStatement("DELETE FROM entidadsalud WHERE codregimenes = ? and codentidadsalud = ?");
                    stmt.setString(1,request.getParameter("codregimeness"));
                    stmt.setString(2,request.getParameter("codentidadsaluds"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    String depmun = request.getParameter("codempresa");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad[0]);
                    stmt.setString(2,cad[1]);
                    stmt.setString(3,request.getParameter("codtipoentidadsalud"));
                    stmt.setString(4,request.getParameter("codnivelcomplejidad"));
                    stmt.setString(5,request.getParameter("codclasifentidad"));
                    stmt.setString(6,request.getParameter("contacto").toUpperCase());
                    stmt.setString(7,request.getParameter("cargocontacto").toUpperCase());
                    stmt.setString(8,request.getParameter("lineagratuita"));
                    stmt.setInt(9,Integer.parseInt(request.getParameter("funcionarios")));
                    stmt.setString(10,request.getParameter("codigobarras"));
                    
                    stmt.setString(11,request.getParameter("slogan").toUpperCase());
                    stmt.setString(12,request.getParameter("codhabilitacion"));
                    stmt.setString(13,request.getParameter("nombrehabilitacion").toUpperCase());
                    stmt.setString(14,request.getParameter("codtipoespecializacion"));
                    stmt.setString(15,request.getParameter("codtipoatencion"));
                    stmt.setString(16,request.getParameter("codestadoentidad"));
                    stmt.setString(17,request.getParameter("numactoinscripcion").toUpperCase());
                    stmt.setDate(18,FormatosFecha.fechaToDate(request.getParameter("fechaactoadmin")));
                    stmt.setString(19,request.getParameter("archivoactoadmin"));
                    stmt.setString(20,request.getParameter("logo"));
                    
                    stmt.setString(21, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(22,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(23,request.getParameter("codregimeness"));
                    stmt.setString(24,request.getParameter("codentidadsaluds"));
                }
                
                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                c.cerrarConexion();
                msj = "Acción No Válida: "+e;
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