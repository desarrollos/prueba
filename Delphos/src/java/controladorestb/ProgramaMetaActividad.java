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

public class ProgramaMetaActividad implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO programametaactividad ( cantpotencvigencia, cantminima, porccumplimiento, ususiscodigo, fecharegistro, codprogramapromprev, codactividadsalud) values ( ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE programametaactividad SET ( cantpotencvigencia, cantminima, porccumplimiento, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ? ) WHERE codprogramapromprev = ? and codactividadsalud = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM programametaactividad WHERE codprogramapromprev = ? and codactividadsalud = ?");
                    stmt.setString(1,request.getParameter("codprogramapromprevs"));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("codactividadsaluds")));                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                        
                    stmt.setInt(1,Integer.parseInt(request.getParameter("cantpotencvigencia")));                    
                    stmt.setInt(2,Integer.parseInt(request.getParameter("cantminima")));                    
                    stmt.setDouble(3,Double.parseDouble(request.getParameter("porccumplimiento")));  //numeric(5,2) 
                    
                    stmt.setString(4, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(5,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(6,request.getParameter("codprogramapromprevs"));
                    stmt.setInt(7,Integer.parseInt(request.getParameter("codactividadsaluds")));
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