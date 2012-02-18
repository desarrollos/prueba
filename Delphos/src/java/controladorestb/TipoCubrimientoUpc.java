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

public class TipoCubrimientoUpc implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO tipocubrimientoupc ( descripcion, porcupc, codtiponorma, codnorma, fechanorma, ususiscodigo, fecharegistro, codregimen, codtipocubrimupc) values ( ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    

                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE tipocubrimientoupc SET (descripcion, porcupc, codtiponorma, codnorma, fechanorma, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ? ) WHERE codregimen = ? and codtipocubrimupc = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM tipocubrimientoupc WHERE codregimen = ? and codtipocubrimupc = ?");
                    
                    stmt.setString(1,request.getParameter("codregimens"));
                    stmt.setString(2,request.getParameter("codtipocubrimupcs"));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                    
                    String depmun = request.getParameter("codnorma");
                    
                    String[] cad = depmun.split(" ");                   
                    
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setInt(2,Integer.parseInt(request.getParameter("porcupc")));
                    stmt.setString(3,cad[0]);
                    stmt.setString(4,cad[2]);
                    
                    java.sql.Date date;
                    date = java.sql.Date.valueOf(""+cad[1]);
                    
                    stmt.setDate(5,date);
                    
                    stmt.setString(6, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(7,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(8,request.getParameter("codregimens"));
                    stmt.setString(9,request.getParameter("codtipocubrimupcs"));
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