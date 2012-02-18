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

public class NivelSeguridadOpcion implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO nivelsegopcion ( niseopdescripcion,niseopejecuta, niseopadiciona, niseopmodifica,niseopelimina,niseopconsulta,niseopbuscar,niseopimprime,niseopocultar,ususiscodigo,fecharegistro,niseopcodigo) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                    msj = "ingresada";                    
                                        
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE nivelsegopcion SET ( niseopdescripcion,niseopejecuta, niseopadiciona, niseopmodifica,niseopelimina,niseopconsulta,niseopbuscar,niseopimprime,niseopocultar,ususiscodigo,fecharegistro) = (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE niseopcodigo = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM nivelsegopcion WHERE niseopcodigo = ?");
                    stmt.setString(1,request.getParameter("niseopcodigo").toUpperCase());
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    stmt.setString(1,request.getParameter("niseopdescripcion"));
                    stmt.setString(2,request.getParameter("niseopejecuta").toUpperCase());
                    stmt.setString(3,request.getParameter("niseopadiciona").toUpperCase());
                    stmt.setString(4,request.getParameter("niseopmodifica").toUpperCase());
                    stmt.setString(5,request.getParameter("niseopelimina").toUpperCase());
                    stmt.setString(6,request.getParameter("niseopconsulta").toUpperCase());
                    stmt.setString(7,request.getParameter("niseopbuscar").toUpperCase());
                    stmt.setString(8,request.getParameter("niseopimprime").toUpperCase());
                    stmt.setString(9,request.getParameter("niseopocultar").toUpperCase());
                    stmt.setString(10, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(11,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    stmt.setString(12,request.getParameter("niseopcodigo").toUpperCase());
                    
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