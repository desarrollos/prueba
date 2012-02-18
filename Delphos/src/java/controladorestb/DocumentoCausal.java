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

public class DocumentoCausal implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO documentocausal ( doccauobserv, ususiscodigo, fecharegistro, codtiponovedad, novcaucodigo, codtipodctoasociado) values ( ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE documentocausal SET ( doccauobserv, ususiscodigo, fecharegistro ) = ( ?, ?, ? ) WHERE codtiponovedad = ? and novcaucodigo = ? and codtipodctoasociado = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM documentocausal WHERE codtiponovedad = ? and novcaucodigo = ? and codtipodctoasociado = ?");
                    
                    String depmun = request.getParameter("novcaucodigos");
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad[0]);
                    stmt.setString(2,cad[1]);
                    stmt.setString(3,request.getParameter("codtipodctoasociados"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    stmt.setString(1,request.getParameter("doccauobserv").toUpperCase());
                    
                    stmt.setString(2, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(3,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    String depmun = request.getParameter("novcaucodigos");
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(4,cad[0]);
                    stmt.setString(5,cad[1]);
                    stmt.setString(6,request.getParameter("codtipodctoasociados"));
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