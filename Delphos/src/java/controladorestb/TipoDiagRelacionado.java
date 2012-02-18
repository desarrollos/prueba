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

public class TipoDiagRelacionado implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO tipodiagrelacionado ( descripcion, codunidmedidaedadmin, edadminima, codunidmedidaedadmax, edadmaxima, aplicamujer, aplicahombre, aplicauvr, numerouvr, valorensmdlv, valordiagnostico, observacion, ususiscodigo, fecharegistro, codtipodiagnrel) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";  
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE tipodiagrelacionado SET ( descripcion, codunidmedidaedadmin, edadminima, codunidmedidaedadmax, edadmaxima, aplicamujer, aplicahombre, aplicauvr, numerouvr, valorensmdlv, valordiagnostico, observacion, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codtipodiagnrel = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM tipodiagrelacionado WHERE codtipodiagnrel = ?");
                    stmt.setString(1,request.getParameter("codtipodiagnrel"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                        
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setString(2,request.getParameter("codunidmedidaedadmin"));
                    stmt.setInt(3,Integer.parseInt(request.getParameter("edadminima")));
                    stmt.setString(4,request.getParameter("codunidmedidaedadmax"));
                    stmt.setInt(5,Integer.parseInt(request.getParameter("edadmaxima")));
                    stmt.setString(6,request.getParameter("aplicamujer").toUpperCase());
                    stmt.setString(7,request.getParameter("aplicahombre").toUpperCase());
                    stmt.setString(8,request.getParameter("aplicauvr").toUpperCase());
                    stmt.setInt(9,Integer.parseInt(request.getParameter("numerouvr")));
                    stmt.setDouble(10,Double.parseDouble(request.getParameter("valorensmdlv")));
                    stmt.setDouble(11,Double.parseDouble(request.getParameter("valordiagnostico")));
                    stmt.setString(12,request.getParameter("observacion").toUpperCase());
                    
                    stmt.setString(13, (String) request.getSession().getAttribute("login"));                    
                    stmt.setTimestamp(14,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(15,request.getParameter("codtipodiagnrel"));
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