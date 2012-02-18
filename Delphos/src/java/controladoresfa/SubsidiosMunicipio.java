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

public class SubsidiosMunicipio implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO subsidiomunicipio ( submunvalsub, subtipcodigo, submundescri, submunobserv, ususiscodigo, fecharegistro, subscodigo, coddepartamento, codmunicipio) values ( ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE subsidiomunicipio SET ( submunvalsub, subtipcodigo, submundescri, submunobserv, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?) WHERE subscodigo = ? and coddepartamento = ? and codmunicipio = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM subsidiomunicipio WHERE subscodigo = ? and coddepartamento = ? and codmunicipio = ?");
                    stmt.setString(1,request.getParameter("subscodigos"));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("coddepartamentos")));
                    stmt.setInt(3,Integer.parseInt(request.getParameter("codmunicipios")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                   
                    stmt.setDouble(1,Double.parseDouble(request.getParameter("submunvalsub")));
                    stmt.setString(2,request.getParameter("subtipcodigo"));
                    stmt.setString(3,request.getParameter("submundescri").toUpperCase());
                    stmt.setString(4,request.getParameter("submunobserv").toUpperCase());
                    
                    stmt.setString(5, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(6,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(7,request.getParameter("subscodigos"));
                    stmt.setInt(8,Integer.parseInt(request.getParameter("coddepartamentos")));
                    stmt.setInt(9,Integer.parseInt(request.getParameter("codmunicipios")));
                                       
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