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

public class DiagnosticoIps implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO diagnosticoips ( anyofinal, mesfinal, codtipoperiodo, cantidad, observacion, ususiscodigo, fecharegistro, coddiagnostico, anyoinicial, mesinicial ) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    

                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE diagnosticoips SET ( anyofinal, mesfinal, codtipoperiodo, cantidad, observacion, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ? ) WHERE coddiagnostico = ? and anyoinicial = ? and mesinicial = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM diagnosticoips WHERE coddiagnostico = ? and anyoinicial = ? and mesinicial = ?");
                    
                    stmt.setString(1,request.getParameter("coddiagnosticos"));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("anyoinicials")));                    
                    stmt.setInt(3,Integer.parseInt(request.getParameter("mesinicials"))); 
                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                       
                    stmt.setInt(1,Integer.parseInt(request.getParameter("anyofinal"))); 
                    stmt.setInt(2,Integer.parseInt(request.getParameter("mesfinal"))); 
                    stmt.setInt(3,Integer.parseInt(request.getParameter("codtipoperiodo"))); 
                    stmt.setInt(4,Integer.parseInt(request.getParameter("cantidad"))); 
                    stmt.setString(5,request.getParameter("observacion").toUpperCase());
                    
                    stmt.setString(6, (String) request.getSession().getAttribute("login"));
                    
                    stmt.setTimestamp(7,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));                    
                    
                    stmt.setString(8,request.getParameter("coddiagnosticos"));
                    stmt.setInt(9,Integer.parseInt(request.getParameter("anyoinicials")));                    
                    stmt.setInt(10,Integer.parseInt(request.getParameter("mesinicials")));
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