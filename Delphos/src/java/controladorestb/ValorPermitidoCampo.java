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

public class ValorPermitidoCampo implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO valorpermitidocampo ( valorinicial, valorfinal, descripcion, ususiscodigo, fecharegistro, codproceso, codcampoarchivo, consecutivo) values ( ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE valorpermitidocampo SET ( valorinicial, valorfinal, descripcion, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ? ) WHERE codproceso = ? and codcampoarchivo = ? and consecutivo = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM valorpermitidocampo WHERE codproceso = ? and codcampoarchivo = ? and consecutivo = ?");
                    stmt.setString(1,request.getParameter("codproceso"));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("codcampoarchivo")));                    
                    stmt.setInt(3,Integer.parseInt(request.getParameter("consecutivo")));                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                       
                    stmt.setDouble(1,Double.parseDouble(request.getParameter("valorinicial"))); //numeric(12,2)                                      
                    stmt.setDouble(2,Double.parseDouble(request.getParameter("valorfinal"))); //numeric(12,2)                   
                    stmt.setString(3,request.getParameter("descripcion").toUpperCase()); 
                    
                    stmt.setString(4,(String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(5,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(6,request.getParameter("codproceso"));
                    stmt.setInt(7,Integer.parseInt(request.getParameter("codcampoarchivo")));                    
                    stmt.setInt(8,Integer.parseInt(request.getParameter("consecutivo")));

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