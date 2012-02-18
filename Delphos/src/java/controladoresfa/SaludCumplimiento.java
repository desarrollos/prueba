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

public class SaludCumplimiento implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO saludcumplimiento ( salcumfecini, salcumfecfin, codtiporequisito, coditipben, codactividadsalud, codestcumplimiento, salcumobserv, ususiscodigo, fecharegistro, codtipoidentidad, salcumidenti) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE saludcumplimiento SET ( salcumfecini, salcumfecfin, codtiporequisito, coditipben, codactividadsalud, codestcumplimiento, salcumobserv, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codtipoidentidad = ? and salcumidenti = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM saludcumplimiento WHERE codtipoidentidad = ? and salcumidenti = ?");
                    stmt.setString(1,request.getParameter("codtipoidentidads"));
                    stmt.setString(2,request.getParameter("salcumidentis"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    String depmun = request.getParameter("codtiporequisitos");                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setDate(1,FormatosFecha.fechaToDate(request.getParameter("salcumfecini")));
                    stmt.setDate(2,FormatosFecha.fechaToDate(request.getParameter("salcumfecfin")));                                        
                    stmt.setString(3,cad[0]);
                    stmt.setString(4,cad[1]);
                    stmt.setInt(5,Integer.parseInt(cad[2]));                    
                    stmt.setString(6,request.getParameter("codestcumplimiento"));
                    stmt.setString(7,request.getParameter("salcumobserv").toUpperCase());
                    
                    stmt.setString(8, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(9,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(10,request.getParameter("codtipoidentidads"));
                    stmt.setString(11,request.getParameter("salcumidentis"));
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