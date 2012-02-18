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

public class Subsidios implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO subsidio ( subsdescripc, subsfechinic, subsfechfina, subtipcodigo, clabencodigo, grugracodigo, subsvalobase, codtiponorma, codnorma, fechanorma, subsobservac, ususiscodigo, fecharegistro, subscodigo) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE subsidio SET ( subsdescripc, subsfechinic, subsfechfina, subtipcodigo, clabencodigo, grugracodigo, subsvalobase, codtiponorma, codnorma, fechanorma, subsobservac, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE subscodigo = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM subsidio WHERE subscodigo = ?");
                    stmt.setString(1,request.getParameter("subscodigo"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    String depmun = request.getParameter("codnorma");                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("subsdescripc").toUpperCase());
                    stmt.setDate(2,FormatosFecha.fechaToDate(request.getParameter("subsfechinic")));
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("subsfechfina")));
                    stmt.setString(4,request.getParameter("subtipcodigo"));
                    stmt.setString(5,request.getParameter("clabencodigo"));
                    stmt.setString(6,request.getParameter("grugracodigo"));
                    stmt.setDouble(7,Double.parseDouble(request.getParameter("subsvalobase")));
                    stmt.setString(8,cad[0]);
                    stmt.setString(9,cad[2]);
                    
                    java.sql.Date date;
                    date = java.sql.Date.valueOf(""+cad[1]);
                    
                    stmt.setDate(10,date);
                    stmt.setString(11,request.getParameter("subsobservac").toUpperCase());
                    
                    stmt.setString(12, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(13,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(14,request.getParameter("subscodigo"));
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