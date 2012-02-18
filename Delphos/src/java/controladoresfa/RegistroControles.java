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

public class RegistroControles implements Control{
    
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
                if(!request.getParameter("contarchivo").isEmpty() && !request.getParameter("contarchivo").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("contarchivo")+"')";
                               
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO registrocontrol ( codtipoidentidadpe, regconidenti, codregimenips, codentidadsaludips, codactividadsalud, coddiagnostico, codfinalidadconsulta, regconcantid, regconfecate, regconcersal, codtipoidentidadfi, firmidentifi, contcertreci, contcumprequ, contarchivo, archivofi, contobservac, ususiscodigo, fecharegistro, salateidregi) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE registrocontrol SET ( codtipoidentidadpe, regconidenti, codregimenips, codentidadsaludips, codactividadsalud, coddiagnostico, codfinalidadconsulta, regconcantid, regconfecate, regconcersal, codtipoidentidadfi, firmidentifi, contcertreci, contcumprequ, contarchivo, archivofi, contobservac, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?) WHERE salateidregi = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM registrocontrol WHERE salateidregi = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("salateidregi")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codentidadsaludips");
                    
                    String[] cad = depmun.split(" ");
                    
                    String depmun1 = request.getParameter("firmidentifi");
                    
                    String[] cad1 = depmun1.split(" ");
                    
                    stmt.setString(1,request.getParameter("codtipoidentidadpe"));
                    stmt.setString(2,request.getParameter("regconidenti").toUpperCase());
                    stmt.setString(3,cad[0]);
                    stmt.setString(4,cad[1]);                    
                    stmt.setInt(5,Integer.parseInt(request.getParameter("codactividadsalud")));
                    stmt.setString(6,request.getParameter("coddiagnostico"));
                    stmt.setString(7,request.getParameter("codfinalidadconsulta"));
                    stmt.setInt(8,Integer.parseInt(request.getParameter("regconcantid")));
                    stmt.setDate(9,FormatosFecha.fechaToDate(request.getParameter("regconfecate")));
                    stmt.setString(10,request.getParameter("regconcersal").toUpperCase());
                    stmt.setString(11,cad1[0]);
                     stmt.setInt(12,Integer.parseInt(cad1[1]));
                    stmt.setString(13,request.getParameter("contcertreci").toUpperCase());
                    stmt.setString(14,request.getParameter("contcumprequ").toUpperCase());
                    stmt.setString(15,request.getParameter("contarchivo").toUpperCase());
                    stmt.setString(16,request.getParameter("contobservac").toUpperCase());
                    
                    stmt.setString(17, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(18,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(19,Integer.parseInt(request.getParameter("salateidregi")));
                                   
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