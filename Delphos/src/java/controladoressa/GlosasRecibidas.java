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

public class GlosasRecibidas implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO glosarecarchafil ( descripcion, cantidad, observacion, infoadicional, planaccion, ususiscodigo, fecharegistro, codindiceglosaarcafi, codclaseglosaafil, codtipoglosaarchafil, anyo, mes) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                                       
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE glosarecarchafil SET (descripcion, cantidad, observacion, infoadicional, planaccion, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ? ) WHERE codindiceglosaarcafi = ? and codclaseglosaafil = ? and codtipoglosaarchafil = ? and anyo = ? and mes = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM glosarecarchafil WHERE codindiceglosaarcafi = ? and codclaseglosaafil = ? and codtipoglosaarchafil = ? and anyo = ? and mes = ?");
                    
                    String depmun = request.getParameter("codindiceglosaarcafis");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,cad [2]);
                    stmt.setInt(4,Integer.parseInt(request.getParameter("anyos")));
                    stmt.setInt(5,Integer.parseInt(request.getParameter("mess")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codindiceglosaarcafis");
                    
                    String[] cad = depmun.split(" ");
                                       
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setInt(2,Integer.parseInt(request.getParameter("cantidad")));
                    stmt.setString(3,request.getParameter("observacion").toUpperCase());
                    stmt.setString(4,request.getParameter("infoadicional").toUpperCase());
                    stmt.setString(5,request.getParameter("planaccion").toUpperCase());
                    
                    stmt.setString(6, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(7,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(8,cad [0]);
                    stmt.setString(9,cad [1]);
                    stmt.setString(10,cad [2]);
                    stmt.setInt(11,Integer.parseInt(request.getParameter("anyos")));
                    stmt.setInt(12,Integer.parseInt(request.getParameter("mess")));

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