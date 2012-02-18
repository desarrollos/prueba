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

public class SubsidioAsignado implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO subsidioasignado ( subasifecini, subasifecfin, subscodigo, subasivalsub, coddepartamento, codmunicipio, subasidescri, codbanco, subasireqedu, subasireqsal, subasiusosub, subasiobserv, ususiscodigo, fecharegistro, codunifami, codtipoidentidad, subpotidenti ) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE subsidioasignado SET (subasifecini, subasifecfin, subscodigo, subasivalsub, coddepartamento, codmunicipio, subasidescri, codbanco, subasireqedu, subasireqsal, subasiusosub, subasiobserv, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codunifami = ? and codtipoidentidad = ? and subpotidenti = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM subsidioasignado WHERE codunifami = ? and codtipoidentidad = ? and subpotidenti = ?");
                    
                    String depmun = request.getParameter("codunifamis");                    
                    String[] cad = depmun.split(" ");

                    stmt.setString(1,cad[0]);
                    stmt.setString(2,cad[1]);
                    stmt.setString(3,cad[2]);
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    String depmun = request.getParameter("codunifamis");                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setDate(1,FormatosFecha.fechaToDate(request.getParameter("subasifecini")));
                    stmt.setDate(2,FormatosFecha.fechaToDate(request.getParameter("subasifecfin")));
                    stmt.setString(3,request.getParameter("subscodigo"));
                    stmt.setDouble(4,Double.parseDouble(request.getParameter("subasivalsub")));                    
                    stmt.setInt(5,Integer.parseInt(request.getParameter("coddepartamento")));
                    stmt.setInt(6,Integer.parseInt(request.getParameter("codmunicipio")));
                    stmt.setString(7,request.getParameter("subasidescri").toUpperCase());
                    stmt.setString(8,request.getParameter("codbanco"));
                    stmt.setString(9,request.getParameter("subasireqedu").toUpperCase());
                    stmt.setString(10,request.getParameter("subasireqsal").toUpperCase());
                    stmt.setString(11,request.getParameter("subasiusosub").toUpperCase());
                    stmt.setString(12,request.getParameter("subasiobserv").toUpperCase());
                    
                    stmt.setString(13, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(14,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(15,cad[0]);
                    stmt.setString(16,cad[1]);
                    stmt.setString(17,cad[2]);                    
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