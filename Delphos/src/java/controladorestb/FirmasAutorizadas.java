package controladores;

import controladores.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.ConexionBaseDatos;
import clases.FormatosFecha;
import clases.FormatoTimestamp;

public class FirmasAutorizadas implements Control{
    
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
                if(!request.getParameter("firmarchivo").isEmpty() && !request.getParameter("firmarchivo").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("firmarchivo")+"')";

                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO firmasautorizadas ( codtipoidentidad, codempresa, firmnombre1, firmnombre2, firmapellido1, firmapellido2, firmfechinic, firmfechfina, firmfirma, firmarchivo, archivofi, firmobservac, ususiscodigo, fecharegistro, codtipoidentidadfir, firmidentifi) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE firmasautorizadas SET ( codtipoidentidad, codempresa, firmnombre1, firmnombre2, firmapellido1, firmapellido2, firmfechinic, firmfechfina, firmfirma, firmarchivo, archivofi, firmobservac, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ? ) WHERE codtipoidentidadfir = ? and firmidentifi = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM firmasautorizadas WHERE codtipoidentidadfir = ? and firmidentifi = ?");
                    stmt.setString(1,request.getParameter("codtipoidentidadfir"));
                    stmt.setString(2,request.getParameter("firmidentifis"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    String depmun = request.getParameter("codempresa");
                    
                    String[] cad = depmun.split(" ");

                    
                    stmt.setString(1,cad[0]);
                    stmt.setString(2,cad[1]);
                    stmt.setString(3,request.getParameter("firmnombre1").toUpperCase());
                    stmt.setString(4,request.getParameter("firmnombre2").toUpperCase());
                    stmt.setString(5,request.getParameter("firmapellido1").toUpperCase());
                    stmt.setString(6,request.getParameter("firmapellido2").toUpperCase());
                    stmt.setDate(7,FormatosFecha.fechaToDate(request.getParameter("firmfechinic")));
                    stmt.setDate(8,FormatosFecha.fechaToDate(request.getParameter("firmfechfina")));
                    stmt.setString(9,request.getParameter("firmfirma").toUpperCase());
                    stmt.setString(10,request.getParameter("firmarchivo").toUpperCase());
                    stmt.setString(11,request.getParameter("firmobservac").toUpperCase());
                    
                    stmt.setString(12, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(13,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(14,request.getParameter("codtipoidentidadfirs"));
                    stmt.setString(15,request.getParameter("firmidentifis"));
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