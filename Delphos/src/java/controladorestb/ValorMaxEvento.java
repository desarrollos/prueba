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

public class ValorMaxEvento implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO valormaxevento ( codtipoconcvalor, fechainicial, porcanyo, porcevento, valortopeanyo, valortopeevento, ususiscodigo, fecharegistro, codregimen, codestrato, anyo ) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE valormaxevento SET ( codtipoconcvalor, fechainicial, porcanyo, porcevento, valortopeanyo, valortopeevento, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codregimen = ? and codestrato = ? and anyo = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM valormaxevento WHERE codregimen = ? and codestrato = ? and anyo = ?");
                    stmt.setString(1,request.getParameter("codregimen"));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("codestrato")));                    
                    stmt.setInt(3,Integer.parseInt(request.getParameter("anyo")));                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                    
                    
                    String depmun = request.getParameter("codtipoconcvalor");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad[1]);
                    
                    java.sql.Date date;
                    date = java.sql.Date.valueOf(""+cad[0]);
                                        
                    stmt.setDate(2,date);
                    stmt.setDouble(3,Double.parseDouble(request.getParameter("porcanyo")));                    
                    stmt.setDouble(4,Double.parseDouble(request.getParameter("porcevento")));                    
                    stmt.setDouble(5,Double.parseDouble(request.getParameter("valortopeanyo")));                    
                    stmt.setDouble(6,Double.parseDouble(request.getParameter("valortopeevento"))); 
                    
                    stmt.setString(7, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(8,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(9,request.getParameter("codregimen"));
                    stmt.setInt(10,Integer.parseInt(request.getParameter("codestrato")));                    
                    stmt.setInt(11,Integer.parseInt(request.getParameter("anyo")));                    
                    
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