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

public class RegistroAccionViolencia implements Control{
    
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
                if(!request.getParameter("violarchivo").isEmpty() && !request.getParameter("violarchivo").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("violarchivo")+"')";
                                    
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO violenciaintrafamiliar ( codtipoidentidadpe, viointidenti, viointfecsuc, tipviocodigo, viointdenunc, viointautori, codtipoidentidadde, viointideden, viointapelli, viointnombre, codtipoidentidadg1, violidengen1, violapellid1, violnombre1, codtipoidentidad, violidengen2, violapellid2, violnombre2, violrelato, violarchivo, archivofi, violobservac, ususiscodigo, fecharegistro, viointid) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE violenciaintrafamiliar SET ( codtipoidentidadpe, viointidenti, viointfecsuc, tipviocodigo, viointdenunc, viointautori, codtipoidentidadde, viointideden, viointapelli, viointnombre, codtipoidentidadg1, violidengen1, violapellid1, violnombre1, codtipoidentidad, violidengen2, violapellid2, violnombre2, violrelato, violarchivo, archivofi, violobservac, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?) WHERE viointid = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM violenciaintrafamiliar WHERE viointid = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("viointid")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
  
                    stmt.setString(1,request.getParameter("codtipoidentidadpe"));
                    stmt.setString(2,request.getParameter("viointidenti").toUpperCase());
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("viointfecsuc")));
                    stmt.setString(4,request.getParameter("tipviocodigo"));
                    stmt.setString(5,request.getParameter("viointdenunc").toUpperCase());
                    stmt.setString(6,request.getParameter("viointautori").toUpperCase());
                    stmt.setString(7,request.getParameter("codtipoidentidadde"));
                    stmt.setString(8,request.getParameter("viointideden").toUpperCase());
                    stmt.setString(9,request.getParameter("viointapelli").toUpperCase());
                    stmt.setString(10,request.getParameter("viointnombre").toUpperCase());
                    stmt.setString(11,request.getParameter("codtipoidentidadg1"));
                    stmt.setString(12,request.getParameter("violidengen1").toUpperCase());
                    stmt.setString(13,request.getParameter("violapellid1").toUpperCase());
                    stmt.setString(14,request.getParameter("violnombre1").toUpperCase());
                    stmt.setString(15,request.getParameter("codtipoidentidad"));
                    stmt.setString(16,request.getParameter("violidengen2").toUpperCase());
                    stmt.setString(17,request.getParameter("violapellid2").toUpperCase());
                    stmt.setString(18,request.getParameter("violnombre2").toUpperCase());
                    stmt.setString(19,request.getParameter("violrelato").toUpperCase());
                    stmt.setString(20,request.getParameter("violarchivo").toUpperCase());
                    stmt.setString(21,request.getParameter("violobservac").toUpperCase());
                    
                    stmt.setString(22, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(23,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(24,Integer.parseInt(request.getParameter("viointid")));
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