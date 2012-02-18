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

public class RubroPptoContrato implements Control{
    
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
                if(!request.getParameter("archsolicdisponib").isEmpty() && !request.getParameter("archsolicdisponib").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("archsolicdisponib")+"')";
                
                String archivoGuardar1 = null;
                if(!request.getParameter("archcertifdisponib").isEmpty() && !request.getParameter("archcertifdisponib").equals(null))
                    archivoGuardar1 = "lo_import('"+ruta+request.getParameter("archcertifdisponib")+"')";
                
                String archivoGuardar2 = null;
                if(!request.getParameter("archcertifregistro").isEmpty() && !request.getParameter("archcertifregistro").equals(null))
                    archivoGuardar2 = "lo_import('"+ruta+request.getParameter("archcertifregistro")+"')";

                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO rubropptocontrato ( disponibilidadppto, nrocompromiso, valorobligado, observacion, archsolicdisponib, archivofi, archcertifdisponib, archivofi2, archcertifregistro, archivofi3, ususiscodigo, fecharegistro, codregimenes, codentidadsalud, codcontrato, codrubropresupuestal, consecutivo) values ( ?, ?, ?, ?, ?, "+archivoGuardar+", ?, "+archivoGuardar1+", ?, "+archivoGuardar2+", ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE rubropptocontrato SET ( disponibilidadppto, nrocompromiso, valorobligado, observacion, archsolicdisponib, archivofi, archcertifdisponib, archivofi2, archcertifregistro, archivofi3, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, "+archivoGuardar+", ?, "+archivoGuardar1+", ?, "+archivoGuardar2+", ?, ? ) WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and codrubropresupuestal = ? and consecutivo = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM rubropptocontrato WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and codrubropresupuestal = ? and consecutivo = ?");
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,cad [2]);
                    stmt.setString(4,request.getParameter("codrubropresupuestals"));
                    stmt.setInt(5,Integer.parseInt(request.getParameter("consecutivos")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("disponibilidadppto").toUpperCase());
                    stmt.setString(2,request.getParameter("nrocompromiso").toUpperCase());
                    stmt.setDouble(3,Double.parseDouble(request.getParameter("valorobligado")));
                    stmt.setString(4,request.getParameter("observacion").toUpperCase());
                    stmt.setString(5,request.getParameter("archsolicdisponib"));
                    stmt.setString(6,request.getParameter("archcertifdisponib"));
                    stmt.setString(7,request.getParameter("archcertifdisponib"));
                    
                    stmt.setString(8, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(9,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(10,cad [0]);
                    stmt.setString(11,cad [1]);
                    stmt.setString(12,cad [2]);
                    stmt.setString(13,request.getParameter("codrubropresupuestals"));
                    stmt.setInt(14,Integer.parseInt(request.getParameter("consecutivos")));

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