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

public class EncuentrosOReuniones implements Control{
    
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
            
            String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
            ruta = ruta.replaceAll("\\\\","/");
            
            try
            {
                c = new ConexionBaseDatos();
                c.abrirConexion();
                
                String archivoGuardar = null;
                if(!request.getParameter("encuarchdocu").isEmpty() && !request.getParameter("encuarchdocu").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("encuarchdocu")+"')";
                               
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO encuentroreunion ( coddepartamento, codmunicipio, encuendirecc, enculugarefe, encuenfecha, tisiscodigo, encunumepart, encutemaprin, coditiporeun, codtipoidentidad, encidemadlid, encuenpropos, encuenobjeti, encusoluenco, encuenobserv, encuarchdocu, encufechinfo,archivofi, ususiscodigo, fecharegistro, encuencodigo) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ? )");
                    msj = "ingresada";                    
                    
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE encuentroreunion SET ( coddepartamento, codmunicipio, encuendirecc, enculugarefe, encuenfecha, tisiscodigo, encunumepart, encutemaprin, coditiporeun, codtipoidentidad, encidemadlid, encuenpropos, encuenobjeti, encusoluenco, encuenobserv, encuarchdocu, encufechinfo, archivofi, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?) WHERE encuencodigo = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM encuentroreunion WHERE encuencodigo = ?");
                    stmt.setString(1,request.getParameter("encuencodigo"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    stmt.setInt(1,Integer.parseInt(request.getParameter("coddepartamento")));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("codmunicipio")));
                    stmt.setString(3,request.getParameter("encuendirecc").toUpperCase());
                    stmt.setString(4,request.getParameter("enculugarefe").toUpperCase());
                    stmt.setTimestamp(5,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(request.getParameter("encuenfecha"))));
                    stmt.setString(6,request.getParameter("tisiscodigo"));
                    stmt.setInt(7,Integer.parseInt(request.getParameter("encunumepart")));
                    stmt.setString(8,request.getParameter("encutemaprin").toUpperCase());
                    stmt.setString(9,request.getParameter("coditiporeun"));
                    stmt.setString(10,request.getParameter("codtipoidentidad"));
                    stmt.setString(11,request.getParameter("encidemadlid").toUpperCase());
                    stmt.setString(12,request.getParameter("encuenpropos").toUpperCase());
                    stmt.setString(13,request.getParameter("encuenobjeti").toUpperCase());
                    stmt.setString(14,request.getParameter("encusoluenco").toUpperCase());
                    stmt.setString(15,request.getParameter("encuenobserv").toUpperCase());
                    stmt.setString(16,request.getParameter("encuarchdocu"));
                    stmt.setTimestamp(17,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(request.getParameter("encufechinfo")))); 
                    
                    stmt.setString(18, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(19,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(20,request.getParameter("encuencodigo"));
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