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

public class ActividadPlanSalud implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO actividadplansalud ( codunidmedidaedadfin, edadfinal, observacion, codalterno, costo, cantmaxautorizar, codtipoperiodo, incluyetodoenperiodo, cantidadenperiodo, ususiscodigo, fecharegistro, codplansalud, codactividadsalud, codunidmedidaedadini, edadinicial) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE actividadplansalud SET ( codunidmedidaedadfin, edadfinal, observacion, codalterno, costo, cantmaxautorizar, codtipoperiodo, incluyetodoenperiodo, cantidadenperiodo, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codplansalud = ? and codactividadsalud = ? and codunidmedidaedadini = ? and edadinicial = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM actividadplansalud WHERE codplansalud = ? and codactividadsalud = ? and codunidmedidaedadini = ? and edadinicial = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("codplansaluds")));                    
                    stmt.setInt(2,Integer.parseInt(request.getParameter("codactividadsaluds")));                    
                    stmt.setString(3,request.getParameter("codunidmedidaedadinis"));                    
                    stmt.setInt(4,Integer.parseInt(request.getParameter("edadinicials")));                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                        
                    stmt.setString(1,request.getParameter("codunidmedidaedadfin"));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("edadfinal")));
                    stmt.setString(3,request.getParameter("observacion").toUpperCase());
                    stmt.setString(4,request.getParameter("codalterno"));                    
                    stmt.setDouble(5,Double.parseDouble(request.getParameter("costo")));  
                    stmt.setInt(6,Integer.parseInt(request.getParameter("cantmaxautorizar")));                     
                    stmt.setInt(7,Integer.parseInt(request.getParameter("codtipoperiodo")));                    
                    stmt.setString(8,request.getParameter("incluyetodoenperiodo").toUpperCase());                    
                    stmt.setInt(9,Integer.parseInt(request.getParameter("cantidadenperiodo")));
                    
                    stmt.setString(10, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(11,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setInt(12,Integer.parseInt(request.getParameter("codplansaluds")));                    
                    stmt.setInt(13,Integer.parseInt(request.getParameter("codactividadsaluds")));                    
                    stmt.setString(14,request.getParameter("codunidmedidaedadinis"));                    
                    stmt.setInt(15,Integer.parseInt(request.getParameter("edadinicials")));
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