package controladores;

import controladores.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.ConexionBaseDatos;
import clases.FormatosFecha;
import clases.FormatoTimestamp;

public class EscGrupoGrado implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO escgrupogrado ( grugradescri, escgracodigoin, escgracodigofi, grugraobserv, ususiscodigo, fecharegistro, grugracodigo) values ( ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE escgrupogrado SET ( grugradescri, escgracodigoin, escgracodigofi, grugraobserv, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ? ) WHERE grugracodigo = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM escgrupogrado WHERE grugracodigo = ?");
                    stmt.setString(1,request.getParameter("grugracodigo"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    stmt.setString(1,request.getParameter("grugradescri").toUpperCase());
                    stmt.setString(2,request.getParameter("escgracodigoin"));
                    stmt.setString(3,request.getParameter("escgracodigofi"));
                    stmt.setString(4,request.getParameter("grugraobserv").toUpperCase());
                    
                    stmt.setString(5, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(6,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(7,request.getParameter("grugracodigo"));

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