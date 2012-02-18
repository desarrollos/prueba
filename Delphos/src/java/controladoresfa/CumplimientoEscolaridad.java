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

public class CumplimientoEscolaridad implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO escolaridadcumplimiento ( codestcumplimiento, esccumobserv, ususiscodigo, fecharegistro, codtipoidentidadins, codempresa, codtipoidentidad, escidentific, escvigencia, espefechinic, espefechfina, codtiporequisito, coditipben, codactividadsalud) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE escolaridadcumplimiento SET ( codestcumplimiento, esccumobserv, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?) WHERE codtipoidentidadins = ? and codempresa = ? and codtipoidentidad = ? and escidentific = ? and escvigencia = ? and espefechinic = ? and espefechfina = ? and codtiporequisito = ? and coditipben = ? and codactividadsalud = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM escolaridadcumplimiento WHERE codtipoidentidadins = ? and codempresa = ? and codtipoidentidad = ? and escidentific = ? and escvigencia = ? and espefechinic = ? and espefechfina = ? and codtiporequisito = ? and coditipben = ? and codactividadsalud = ?");
                    String depmun = request.getParameter("escidentifics");                    
                    String[] cad = depmun.split(" ");
                    
                    String depmun1 = request.getParameter("reqtipcodigos");                    
                    String[] cad1 = depmun1.split(" ");
                    
                    stmt.setString(1,cad[0]);
                    stmt.setString(2,cad[1]);
                    stmt.setString(3,cad[2]);
                    stmt.setString(4,cad[3]);
                    stmt.setInt(5,Integer.parseInt(cad[4]));
                    
                    java.sql.Date date;
                    date = java.sql.Date.valueOf(""+cad[5]);
                    java.sql.Date date1;
                    date1 = java.sql.Date.valueOf(""+cad[6]);
                    
                    stmt.setDate(6,date);
                    stmt.setDate(7,date1);
                    
                    stmt.setString(8,cad1[0]);
                    stmt.setString(9,cad1[1]);
                    stmt.setInt(10,Integer.parseInt(cad1[2]));
                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {          
                                       
                    String depmun = request.getParameter("escidentifics");                    
                    String[] cad = depmun.split(" ");
                    
                    String depmun1 = request.getParameter("reqtipcodigos");                    
                    String[] cad1 = depmun1.split(" ");
                    
                    stmt.setString(1,request.getParameter("codestcumplimiento").toUpperCase());   
                    stmt.setString(2,request.getParameter("esccumobserv").toUpperCase());   
                    
                    stmt.setString(3, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(4,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(5,cad[0]);
                    stmt.setString(6,cad[1]);
                    stmt.setString(7,cad[2]);
                    stmt.setString(8,cad[3]);
                    stmt.setInt(9,Integer.parseInt(cad[4]));
                    
                    java.sql.Date date;
                    date = java.sql.Date.valueOf(""+cad[5]);
                    java.sql.Date date1;
                    date1 = java.sql.Date.valueOf(""+cad[6]);
                    
                    stmt.setDate(10,date);
                    stmt.setDate(11,date1);
                    
                    stmt.setString(12,cad1[0]);
                    stmt.setString(13,cad1[1]);
                    stmt.setInt(14,Integer.parseInt(cad1[2]));
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