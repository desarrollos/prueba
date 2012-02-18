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

public class AsistentesReuniones implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO encuenasistenteexterno ( asiextnombre, asiextapellido, tipasicodigo, exterobserv, ususiscodigo, fecharegistro, encuencodigo, codtipoidentidad, externidenti) values ( ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE encuenasistenteexterno SET ( asiextnombre, asiextapellido, tipasicodigo, exterobserv, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?) WHERE encuencodigo = ? and codtipoidentidad = ? and externidenti = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM encuenasistenteexterno WHERE encuencodigo = ? and codtipoidentidad = ? and externidenti = ?");
                    stmt.setString(1,request.getParameter("encuencodigo"));
                    stmt.setString(2,request.getParameter("codtipoidentidad"));
                    stmt.setString(3,request.getParameter("externidenti"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    //String depmun = request.getParameter("numidentfunc");
                    
                    //String[] cad = depmun.split(" ");
                    
                    //stmt.setString(1,cad[0]);
                    //stmt.setString(2,cad[1]);
                    stmt.setString(1,request.getParameter("asiextnombre").toUpperCase());
                    stmt.setString(2,request.getParameter("asiextapellido").toUpperCase());
                    stmt.setString(3,request.getParameter("tipasicodigo"));
                    stmt.setString(4,request.getParameter("exterobserv").toUpperCase());
                    
                    stmt.setString(5, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(6,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(7,request.getParameter("encuencodigo"));
                    stmt.setString(8,request.getParameter("codtipoidentidad"));
                    stmt.setString(9,request.getParameter("externidenti"));
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