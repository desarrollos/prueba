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

public class TipoMetodologia implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO tipometodologia ( descripcion, codtiponorma, codnorma, fechanorma, codmetodoajuste, codtipoajustevalor, ususiscodigo, fecharegistro, codtipometodologia) values ( ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada"; 
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE tipometodologia SET ( descripcion, codtiponorma, codnorma, fechanorma, codmetodoajuste, codtipoajustevalor, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codtipometodologia = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM tipometodologia WHERE codtipometodologia = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("codtipometodologia")));                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                        
                    String depmun = request.getParameter("codnorma");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setString(2,cad[0]);
                    stmt.setString(3,cad[2]);
                    
                    java.sql.Date date;
                    date = java.sql.Date.valueOf(""+cad[1]);
                    
                    stmt.setDate(4,date);
                    stmt.setString(5,request.getParameter("codmetodoajuste"));
                    stmt.setString(6,request.getParameter("codtipoajustevalor"));
                    
                    stmt.setString(7, (String) request.getSession().getAttribute("login"));                    
                    stmt.setTimestamp(8,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setInt(9,Integer.parseInt(request.getParameter("codtipometodologia")));
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