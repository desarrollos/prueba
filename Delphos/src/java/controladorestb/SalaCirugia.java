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

public class SalaCirugia implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO salacirugia ( descripcion, codalterno, codcentroatencion, codunidadfuncional, codareaservicio, codestadosala, codgrupocamasala, codsubgrupocamasala, ususiscodigo, fecharegistro, codregimenes, codentidadsalud, codsalacirugia) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";  
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE salacirugia SET ( descripcion, codalterno, codcentroatencion, codunidadfuncional, codareaservicio, codestadosala, codgrupocamasala, codsubgrupocamasala, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codregimenes = ? and codentidadsalud = ? and codsalacirugia = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM salacirugia WHERE codregimenes = ? and codentidadsalud = ? and codsalacirugia = ?");
                    
                    String depmun = request.getParameter("codentidadsaluds");                    
                    String[] cad = depmun.split(" ");                    
                    
                    stmt.setString(1,cad[0]);
                    stmt.setString(2,cad[1]);
                    stmt.setString(3,request.getParameter("codsalacirugias"));
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
                    
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setString(2,request.getParameter("codalterno").toUpperCase());
                    stmt.setString(3,cad3[0]);
                    stmt.setString(4,cad3[1]);
                    stmt.setString(5,cad3[2]);
                    stmt.setString(6,request.getParameter("codestadosala"));
                    stmt.setString(7,cad2[0]);
                    stmt.setString(8,cad2[1]);
                    
                    stmt.setString(9, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(10,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(11,cad[0]);
                    stmt.setString(12,cad[1]);
                    stmt.setString(13,request.getParameter("codsalacirugias"));                    
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