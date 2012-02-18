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

public class InscripcionIPS implements Control{
    
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
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO inscripcionips ( insipsidenti, insipsfecins, insipshiscli, insipscenate, esinipscodigo, insipsarchiv, archivofi, insipsobserv, ususiscodigo, fecharegistro, codregimenes, codentidadsalud, codtipoidentidad ) values ( ?, ?, ?, ?, ?, ?, lo_import('"+ruta+request.getParameter("insipsarchiv")+"'), ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE inscripcionips SET ( insipsidenti, insipsfecins, insipshiscli, insipscenate, esinipscodigo, insipsarchiv, archivofi, insipsobserv, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, lo_import('"+ruta+request.getParameter("insipsarchiv")+"'), ?, ?, ?) WHERE codregimenes = ? and codentidadsalud = ? and codtipoidentidad = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM inscripcionips WHERE codregimenes = ? and codentidadsalud = ? and codtipoidentidad = ?");
                    
                    String depmun = request.getParameter("codentidadsaluds");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad[0]);
                    stmt.setString(2,cad[1]);
                    stmt.setString(3,request.getParameter("codtipoidentidads"));
                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    String depmun = request.getParameter("codentidadsaluds");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("insipsidenti").toUpperCase());
                    stmt.setDate(2,FormatosFecha.fechaToDate(request.getParameter("insipsfecins")));
                    stmt.setString(3,request.getParameter("insipshiscli").toUpperCase());
                    stmt.setString(4,request.getParameter("insipscenate").toUpperCase());
                    stmt.setString(5,request.getParameter("esinipscodigo"));
                    stmt.setString(6,request.getParameter("insipsarchiv").toUpperCase());
                    stmt.setString(7,request.getParameter("insipsobserv").toUpperCase());
                    
                    
                    stmt.setString(8, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(9,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(10,cad[0]);
                    stmt.setString(11,cad[1]);
                    stmt.setString(12,request.getParameter("codtipoidentidads"));
                                       
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