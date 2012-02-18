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

public class Cama implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO cama ( codalterno, descripcion, codtipohabitacion, codtipocama, codestadocama, codgrupocamasala, codsubgrupocamasala, observacion, codcentroatencion, codunidadfuncional, codareaservicio, codactividadsalud, ususiscodigo, fecharegistro, codregimenes, codentidadsalud, numerocama) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";  
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE cama SET ( codalterno, descripcion, codtipohabitacion, codtipocama, codestadocama, codgrupocamasala, codsubgrupocamasala, observacion, codcentroatencion, codunidadfuncional, codareaservicio, codactividadsalud, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codregimenes = ? and codentidadsalud = ? and numerocama = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM cama WHERE codregimenes = ? and codentidadsalud = ? and numerocama = ?");
                    
                    String depmun = request.getParameter("codentidadsaluds");                    
                    String[] cad = depmun.split(" ");                    
                    
                    stmt.setString(1,cad[0]);
                    stmt.setString(2,cad[1]);
                    stmt.setString(3,request.getParameter("numerocamas"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {  
                    String depmun = request.getParameter("codentidadsaluds");                    
                    String[] cad = depmun.split(" ");                    
                    
                    String depmun2 = request.getParameter("codgrupocamasalas");                    
                    String[] cad2 = depmun2.split(" ");                    
                    
                    String depmun3 = request.getParameter("codcentroatencions");                    
                    String[] cad3 = depmun3.split(" ");                    
                    
                    stmt.setString(1,request.getParameter("codalterno").toUpperCase());
                    stmt.setString(2,request.getParameter("descripcion").toUpperCase());
                    stmt.setString(3,request.getParameter("codtipohabitacion"));
                    stmt.setString(4,request.getParameter("codtipocama"));
                    stmt.setString(5,request.getParameter("codestadocama"));
                    stmt.setString(6,cad2[0]);
                    stmt.setString(7,cad2[1]);
                    stmt.setString(8,request.getParameter("observacion").toUpperCase());
                    stmt.setString(9,cad3[0]);
                    stmt.setString(10,cad3[1]);
                    stmt.setString(11,cad3[2]);
                    stmt.setInt(12,Integer.parseInt(request.getParameter("codactividadsalud")));     
                    
                    stmt.setString(13, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(14,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(15,cad[0]);
                    stmt.setString(16,cad[1]);
                    stmt.setString(17,request.getParameter("numerocamas"));                    
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