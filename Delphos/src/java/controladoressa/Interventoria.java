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

public class Interventoria implements Control{
    
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
                if(!request.getParameter("archivo").isEmpty() && !request.getParameter("archivo").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("archivo")+"')";

                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO intervencioncto ( descripcion, observacion, fecha, codtipointervcontrato, nroliquidaccto, archivo, archivofi, ususiscodigo, fecharegistro, codregimenes, codentidadsalud, codcontrato, consecutivo) values ( ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                                        
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE intervencioncto SET (descripcion, observacion, fecha, codtipointervcontrato, nroliquidaccto, archivo, archivofi, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ? ) WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and consecutivo = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM intervencioncto WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and consecutivo = ?");
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,cad [2]);
                    stmt.setInt(4,Integer.parseInt(request.getParameter("consecutivos")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                                       
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setString(2,request.getParameter("observacion").toUpperCase());
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("fecha")));
                    stmt.setString(4,request.getParameter("codtipointervcontrato"));
                    stmt.setString(5,request.getParameter("nroliquidaccto").toUpperCase());
                    stmt.setString(6,request.getParameter("archivo").toUpperCase());
                    
                    stmt.setString(7, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(8,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(9,cad [0]);
                    stmt.setString(10,cad [1]);
                    stmt.setString(11,cad [2]);
                    stmt.setInt(12,Integer.parseInt(request.getParameter("consecutivos")));

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