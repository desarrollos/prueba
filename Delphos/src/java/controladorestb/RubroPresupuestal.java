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

public class RubroPresupuestal implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO rubropresupuestal ( descripcion, codalterno, codtiporecursoppto, codcuecontpptoapro, codcuecontpptoejec, codcuecontdisponib, codcuecontcomprom, codcuecontobligac, codcuecontgiro, inversion, observacion, codtipofuentefinancia, ususiscodigo, fecharegistro, codrubropresupuestal) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                       
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE rubropresupuestal SET ( descripcion, codalterno, codtiporecursoppto, codcuecontpptoapro, codcuecontpptoejec, codcuecontdisponib, codcuecontcomprom, codcuecontobligac, codcuecontgiro, inversion, observacion, codtipofuentefinancia, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codrubropresupuestal = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM rubropresupuestal WHERE codrubropresupuestal = ?");
                    stmt.setString(1,request.getParameter("codrubropresupuestal"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setString(2,request.getParameter("codalterno").toUpperCase());
                    stmt.setString(3,request.getParameter("codtiporecursoppto"));
                    stmt.setString(4,request.getParameter("codcuecontpptoapro"));
                    stmt.setString(5,request.getParameter("codcuecontpptoejec"));
                    stmt.setString(6,request.getParameter("codcuecontdisponib"));
                    stmt.setString(7,request.getParameter("codcuecontcomprom"));
                    stmt.setString(8,request.getParameter("codcuecontobligac"));
                    stmt.setString(9,request.getParameter("codcuecontgiro"));
                    stmt.setString(10,request.getParameter("inversion").toUpperCase());
                    stmt.setString(11,request.getParameter("observacion").toUpperCase());
                    stmt.setString(12,request.getParameter("codtipofuentefinancia"));                    
                    
                    stmt.setString(13, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(14,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(15,request.getParameter("codrubropresupuestal"));
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