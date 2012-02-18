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

public class Upcs implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO upcs ( codgrupopoblacion, anyofinal, mesfinal, valoranyo, valormes, valordia, porcincremrelant, fechainicaplic, codtiponorma, codnorma, fechanorma, ususiscodigo, fecharegistro, codregimen, codtipocubrimupc, anyoinicial, mesinicial) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE upcs SET (codgrupopoblacion, anyofinal, mesfinal, valoranyo, valormes, valordia, porcincremrelant, fechainicaplic, codtiponorma, codnorma, fechanorma, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codregimen = ? and codtipocubrimupc = ? and anyoinicial = ? and mesinicial = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM upcs WHERE codregimen = ? and codtipocubrimupc = ? and anyoinicial = ? and mesinicial = ?");
                    
                    String depmun = request.getParameter("codregimens");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setInt(3,Integer.parseInt(request.getParameter("anyoinicials")));
                    stmt.setInt(4,Integer.parseInt(request.getParameter("mesinicials")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codregimens");
                    
                    String[] cad = depmun.split(" ");
                    
                    String unicen = request.getParameter("codnormas");
                    
                    String[] cad1 = unicen.split(" ");
                    
                    stmt.setInt(1,Integer.parseInt(request.getParameter("codgrupopoblacion")));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("anyofinal")));
                    stmt.setInt(3,Integer.parseInt(request.getParameter("mesfinal")));
                    stmt.setDouble(4,Double.parseDouble(request.getParameter("valoranyo")));
                    stmt.setDouble(5,Double.parseDouble(request.getParameter("valormes")));
                    stmt.setDouble(6,Double.parseDouble(request.getParameter("valordia")));
                    stmt.setDouble(7,Double.parseDouble(request.getParameter("porcincremrelant")));
                    stmt.setDate(8,FormatosFecha.fechaToDate(request.getParameter("fechainicaplic")));
                    stmt.setString(9,cad1[0]);
                    stmt.setString(10,cad1[2]);
                    
                    java.sql.Date date;
                    date = java.sql.Date.valueOf(""+cad1[1]);
                    
                    stmt.setDate(11,date);
                    
                    stmt.setString(12, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(13,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(14,cad [0]);
                    stmt.setString(15,cad [1]);
                    stmt.setInt(16,Integer.parseInt(request.getParameter("anyoinicials")));
                    stmt.setInt(17,Integer.parseInt(request.getParameter("mesinicials")));
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