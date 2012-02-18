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

public class RespuestaGlosas implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO detallerespglosa ( actividadreal, ususiscodigo, fecharegistro, consecutivoresp, codindiceglosaarcafi, codclaseglosaafil, codtipoglosaarchafil, anyo, mes, consecutivorecib) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                                        
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE detallerespglosa SET (actividadreal, ususiscodigo, fecharegistro) = ( ?, ?, ? ) WHERE consecutivoresp = ? and codindiceglosaarcafi = ? and codclaseglosaafil = ? and codtipoglosaarchafil = ? and anyo = ? and mes = ? and consecutivorecib = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM detallerespglosa WHERE consecutivoresp = ? and codindiceglosaarcafi = ? and codclaseglosaafil = ? and codtipoglosaarchafil = ? and anyo = ? and mes = ? and consecutivorecib = ?");
                    
                    String depmun = request.getParameter("codindiceglosaarcafis");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setInt(1,Integer.parseInt(request.getParameter("consecutivoresps")));
                    stmt.setString(2,cad [0]);
                    stmt.setString(3,cad [1]);
                    stmt.setString(4,cad [2]);
                    stmt.setInt(5,Integer.parseInt(cad [3]));
                    stmt.setInt(6,Integer.parseInt(cad [4]));
                    stmt.setInt(7,Integer.parseInt(cad [5]));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {   
                    String depmun = request.getParameter("codindiceglosaarcafis");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("actividadreal").toUpperCase());
                    
                    stmt.setString(2, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(3,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(4,Integer.parseInt(request.getParameter("consecutivoresps")));
                    stmt.setString(5,cad [0]);
                    stmt.setString(6,cad [1]);
                    stmt.setString(7,cad [2]);
                    stmt.setInt(8,Integer.parseInt(cad [3]));
                    stmt.setInt(9,Integer.parseInt(cad [4]));
                    stmt.setInt(10,Integer.parseInt(cad [5]));

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