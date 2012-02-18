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

public class ActasPorContrato implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO actacontrato ( proposito, fecha, archivo, archivofi, codcentroatencion, codunidadfuncional, codtipofasecontrato, ususiscodigo, fecharegistro, codtipoactacontrato, codregimenes, codentidadsalud, codcontrato, numeroacta) values ( ?, ?, ?,lo_import('"+ruta+request.getParameter("archivo")+"'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                                        
                    //String depmun = request.getParameter("codcontrato");                    
                    //String[] cad = depmun.split(" ");                    
                    //stmt.setString(8,request.getParameter("codtipoactacontrato").toUpperCase());
                    //stmt.setString(9,cad [0]);
                    //stmt.setString(10,cad [1]);
                    //stmt.setString(11,cad [2]);
                    //stmt.setString(12,request.getParameter("numeroacta").toUpperCase());
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE actacontrato SET (proposito, fecha, archivo, archivofi, codcentroatencion, codunidadfuncional, codtipofasecontrato, ususiscodigo, fecharegistro) = ( ?, ?, ?, lo_import('"+ruta+request.getParameter("archivo")+"'), ?, ?, ?, ?, ? ) WHERE codtipoactacontrato = ? and codregimenes = ? and codentidadsalud = ? and codcontrato = ? and numeroacta = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM actacontrato WHERE codtipoactacontrato = ? and codregimenes = ? and codentidadsalud = ? and codcontrato = ? and numeroacta = ?");
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("codtipoactacontratos"));
                    stmt.setString(2,cad [0]);
                    stmt.setString(3,cad [1]);
                    stmt.setString(4,cad [2]);
                    stmt.setString(5,request.getParameter("numeroactas"));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    String unicen = request.getParameter("codunidadfuncional");
                    
                    String[] cad1 = unicen.split(" ");
                    
                    stmt.setString(1,request.getParameter("proposito").toUpperCase());
                    stmt.setTimestamp(2,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(request.getParameter("fecha"))));
                    stmt.setString(3,request.getParameter("archivo").toUpperCase());
                    stmt.setString(4,cad1 [0]);
                    stmt.setString(5,cad1 [1]);
                    stmt.setString(6,request.getParameter("codtipofasecontrato").toUpperCase());
                    
                    stmt.setString(7, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(8,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(9,request.getParameter("codtipoactacontratos"));
                    stmt.setString(10,cad [0]);
                    stmt.setString(11,cad [1]);
                    stmt.setString(12,cad [2]);
                    stmt.setString(13,request.getParameter("numeroactas"));

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