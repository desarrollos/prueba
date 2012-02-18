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

public class ManualActividad implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO manualactividad ( descripcion, codtiponorma, codnorma, fechanorma, ususiscodigo, fecharegistro, codmanualactividad) values ( ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE manualactividad SET ( descripcion, codtiponorma, codnorma, fechanorma, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ? ) WHERE codmanualactividad = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM manualactividad WHERE codmanualactividad = ?");
                    stmt.setString(1,request.getParameter("codmanualactividad"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                                        
                    String depmun = request.getParameter("codnorma");
                    
                    String[] cad = depmun.split(" ");
                    
                   
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setString(2,cad[0]);
                    
                    
                    stmt.setString(3,cad[2]);
                    
                    java.sql.Date date;
                    date = java.sql.Date.valueOf(""+cad[1]);
                    
                    stmt.setDate(4,date);
                    
                    stmt.setString(5, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(6,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(7,request.getParameter("codmanualactividad"));

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