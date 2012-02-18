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

public class ManualLiquSuminitro implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO manualliqusuminitro ( anyo, mes, valor, ususiscodigo, fecharegistro, codtipometodologia, codsuministro) values ( ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada"; 
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE manualliqusuminitro SET ( anyo, mes, valor, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ? ) WHERE codtipometodologia = ? and codsuministro = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM manualliqusuminitro WHERE codtipometodologia = ? and codsuministro = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("codtipometodologias")));
                    stmt.setString(2,request.getParameter("codsuministros"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                        
                    stmt.setInt(1,Integer.parseInt(request.getParameter("anyo")));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("mes")));
                    stmt.setDouble(3,Double.parseDouble(request.getParameter("valor")));  //numeric(12,2)
                    stmt.setString(4, (String) request.getSession().getAttribute("login"));
                    
                    stmt.setTimestamp(5,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setInt(6,Integer.parseInt(request.getParameter("codtipometodologias")));
                    stmt.setString(7,request.getParameter("codsuministros"));                    
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