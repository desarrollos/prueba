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

public class SubsidioPotencial implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO subsidiopotencial ( subscodigo, subpotvalsub, coddepartamento, codmunicipio, subpotdescri, subpotobserv, ususiscodigo, fecharegistro, codunifami, codtipoidentidad, subpotidenti) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE subsidiopotencial SET ( subscodigo, subpotvalsub, coddepartamento, codmunicipio, subpotdescri, subpotobserv, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?) WHERE codunifami = ? and codtipoidentidad = ? and subpotidenti = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM subsidiopotencial WHERE codunifami = ? and codtipoidentidad = ? and subpotidenti = ?");
                    stmt.setString(1,request.getParameter("codunifamis"));
                    stmt.setString(2,request.getParameter("codtipoidentidads"));
                    stmt.setString(3,request.getParameter("subpotidentis"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                   
                    stmt.setString(1,request.getParameter("subscodigo"));
                    stmt.setDouble(2,Double.parseDouble(request.getParameter("subpotvalsub")));
                    
                    stmt.setInt(3,Integer.parseInt(request.getParameter("coddepartamento")));
                    stmt.setInt(4,Integer.parseInt(request.getParameter("codmunicipio")));
                    stmt.setString(5,request.getParameter("subpotdescri").toUpperCase());
                    stmt.setString(6,request.getParameter("subpotobserv").toUpperCase());
                    
                    stmt.setString(7, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(8,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(9,request.getParameter("codunifamis"));
                    stmt.setString(10,request.getParameter("codtipoidentidads"));
                    stmt.setString(11,request.getParameter("subpotidentis"));                    
                }
                
                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                c.cerrarConexion();
                msj = "Acción No Válida"+e;
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