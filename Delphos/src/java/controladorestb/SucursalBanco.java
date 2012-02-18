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

public class SucursalBanco implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO sucursalbanco ( codtipoidendirector, numidentfuncdirector, codtipoidencontacto, numidentfunccontacto, telefono, direccion, coddepartamento, codmunicipio, ususiscodigo, fecharegistro, codbanco, codsucursalbanco) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE sucursalbanco SET ( codtipoidendirector, numidentfuncdirector, codtipoidencontacto, numidentfunccontacto, telefono, direccion, coddepartamento, codmunicipio, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codbanco = ? and codsucursalbanco = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM sucursalbanco WHERE codbanco = ? and codsucursalbanco = ?");
                    stmt.setString(1,request.getParameter("codbanco"));
                    stmt.setString(2,request.getParameter("codsucursalbanco"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    String depmun = request.getParameter("numidentfuncdirector");
                    
                    String[] cad = depmun.split(" ");
                    
                    String unicen = request.getParameter("numidentfunccontacto");
                    
                    String[] cad1 = unicen.split(" ");
                    
                    stmt.setString(1,cad[0]);
                    stmt.setString(2,cad[1]);
                    stmt.setString(3,cad1[0]);
                    stmt.setString(4,cad1[1]);
                    stmt.setString(5,request.getParameter("telefono").toUpperCase());
                    stmt.setString(6,request.getParameter("direccion").toUpperCase());                    
                    stmt.setInt(7,Integer.parseInt(request.getParameter("coddepartamento")));                    
                    stmt.setInt(8,Integer.parseInt(request.getParameter("codmunicipio")));   
                    
                    stmt.setString(9, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(10,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(11,request.getParameter("codbanco"));
                    stmt.setString(12,request.getParameter("codsucursalbanco"));

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