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

public class RegistroQuejas implements Control{
    
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
                if(!request.getParameter("quejarchdocu").isEmpty() && !request.getParameter("quejarchdocu").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("quejarchdocu")+"')";

                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO quejas ( quejciclpago, codtipoidentidadpers, quejidentifi, quejfecha, tipquecodigo, queclacodigo, codtipoidentidad, numidentfunc, quejarchdocu, quejobservac, archivofi, ususiscodigo, fecharegistro, codunifami, quejconsecut) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ? )");
                    msj = "ingresada";                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE quejas SET ( quejciclpago, codtipoidentidadpers, quejidentifi, quejfecha, tipquecodigo, queclacodigo, codtipoidentidad, numidentfunc, quejarchdocu, quejobservac, archivofi, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?) WHERE codunifami = ? and  quejconsecut = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM quejas WHERE codunifami = ? and  quejconsecut = ?");
                    stmt.setString(1,request.getParameter("codunifamis"));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("quejconsecuts")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {   
                    String tipque = request.getParameter("queclacodigo");
                    
                    String[] cad = tipque.split(" ");
                    
                    String tipid = request.getParameter("numidentfunc");
                    
                    String[] cad1 = tipid.split(" ");
                    
                    stmt.setInt(1,Integer.parseInt(request.getParameter("quejciclpago")));
                    stmt.setString(2,request.getParameter("codtipoidentidadpers"));
                    stmt.setString(3,request.getParameter("quejidentifi").toUpperCase());
                    stmt.setDate(4,FormatosFecha.fechaToDate(request.getParameter("quejfecha")));
                    stmt.setString(5,cad[0]);
                    stmt.setString(6,cad[1]);
                    
                    stmt.setString(7,cad1[0]);
                    stmt.setString(8,cad1[1]);
                    stmt.setString(9,request.getParameter("quejarchdocu").toUpperCase());
                    stmt.setString(10,request.getParameter("quejobservac").toUpperCase());
                    
                    stmt.setString(11, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(12,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(13,request.getParameter("codunifamis"));
                    stmt.setInt(14,Integer.parseInt(request.getParameter("quejconsecuts")));
                    
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