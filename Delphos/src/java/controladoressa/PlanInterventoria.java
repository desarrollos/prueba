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

public class PlanInterventoria implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO planaccintervcto ( actividad, codcargo, fechacumplim, porque, como, recurso, codestcumplimiento, nroliquidacion, ususiscodigo, fecharegistro, codregimenes, codentidadsalud, codcontrato, consintervencion, consecutivo) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                                        
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE planaccintervcto SET (actividad, codcargo, fechacumplim, porque, como, recurso, codestcumplimiento, nroliquidacion, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and consintervencion = ? and consecutivo = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM planaccintervcto WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and consintervencion = ? and consecutivo = ?");
                    
                    String depmun = request.getParameter("consintervencions");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,cad [2]);
                    stmt.setInt(4,Integer.parseInt(cad [3]));
                    stmt.setInt(5,Integer.parseInt(request.getParameter("consecutivos")));
                    

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("consintervencions");
                    
                    String[] cad = depmun.split(" ");
                    
                    
                    stmt.setString(1,request.getParameter("actividad").toUpperCase());
                    stmt.setString(2,request.getParameter("codcargo"));
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("fechacumplim")));
                    stmt.setString(4,request.getParameter("porque").toUpperCase());
                    stmt.setString(5,request.getParameter("como").toUpperCase());
                    stmt.setString(6,request.getParameter("recurso").toUpperCase());
                    stmt.setString(7,request.getParameter("codestcumplimiento"));
                    stmt.setString(8,request.getParameter("nroliquidacion"));
                    
                    stmt.setString(9, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(10,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(11,cad [0]);
                    stmt.setString(12,cad [1]);
                    stmt.setString(13,cad [2]);
                    stmt.setInt(14,Integer.parseInt(cad [3]));
                    stmt.setInt(15,Integer.parseInt(request.getParameter("consecutivos")));

                }
                
                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                c.cerrarConexion();
                msj = "Acción No Válida" + e;
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