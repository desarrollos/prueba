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

public class PlanTarifa implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO plantarifa ( porcentaje, valoractividad, honorariomedico, honorarioanest, honorarioayudante, derechosala, valormasucu, valorperfusion, ususiscodigo, fecharegistro, codtipometodologia, codactividadsalud, anyo, mesinicial, codtipoplantarifa) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE plantarifa SET ( porcentaje, valoractividad, honorariomedico, honorarioanest, honorarioayudante, derechosala, valormasucu, valorperfusion, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codtipometodologia = ? and codactividadsalud = ? and anyo = ? and mesinicial = ? and codtipoplantarifa = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM plantarifa WHERE codtipometodologia = ? and codactividadsalud = ? and anyo = ? and mesinicial = ? and codtipoplantarifa = ?");
                    
                    String depmun = request.getParameter("codtipometodologias");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setInt(1,Integer.parseInt(cad[0]));
                    stmt.setInt(2,Integer.parseInt(cad[1]));
                    stmt.setInt(3,Integer.parseInt(cad[2]));
                    stmt.setInt(4,Integer.parseInt(cad[3]));                     
                    stmt.setString(5,request.getParameter("codtipoplantarifas"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    stmt.setDouble(1,Double.parseDouble(request.getParameter("porcentaje")));        //numeric(5,2)
                    stmt.setDouble(2,Double.parseDouble(request.getParameter("valoractividad")));    //numeric(12,2)                
                    stmt.setDouble(3,Double.parseDouble(request.getParameter("honorariomedico")));    //numeric(12,2)                
                    stmt.setDouble(4,Double.parseDouble(request.getParameter("honorarioanest")));    //numeric(12,2)                
                    stmt.setDouble(5,Double.parseDouble(request.getParameter("honorarioayudante")));    //numeric(12,2)                
                    stmt.setDouble(6,Double.parseDouble(request.getParameter("derechosala")));    //numeric(12,2)                
                    stmt.setDouble(7,Double.parseDouble(request.getParameter("valormasucu")));    //numeric(12,2)                
                    stmt.setDouble(8,Double.parseDouble(request.getParameter("valorperfusion")));    //numeric(12,2)                
                    
                    stmt.setString(9, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(10,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                                        
                    String depmun = request.getParameter("codtipometodologias");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setInt(11,Integer.parseInt(cad[0]));
                    stmt.setInt(12,Integer.parseInt(cad[1]));
                    stmt.setInt(13,Integer.parseInt(cad[2]));
                    stmt.setInt(14,Integer.parseInt(cad[3])); 
                    
                    stmt.setString(15,request.getParameter("codtipoplantarifas"));

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