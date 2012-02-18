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

public class SoporteContrato implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO soportecontrato ( aplicaa, observacion, archivo, archivofi, ususiscodigo, fecharegistro, codcontrato, codentidadsalud, codregimenes, codmodalidadcontrato, codclaseactividad, codtiposoporte) values ( ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE soportecontrato SET ( aplicaa, observacion, archivo, archivofi, ususiscodigo, fecharegistro ) = ( ?, ?, ?, "+archivoGuardar+", ?, ? ) WHERE codcontrato = ? and codentidadsalud = ? and codregimenes = ? and codmodalidadcontrato = ? and codclaseactividad = ? and codtiposoporte = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM soportecontrato WHERE codcontrato = ? and codentidadsalud = ? and codregimenes = ? and codmodalidadcontrato = ? and codclaseactividad = ? and codtiposoporte = ?");
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    String depmun1 = request.getParameter("codtiposoportes");
                    
                    String[] cad1 = depmun1.split(" ");
                    
                    stmt.setString(1,cad [2]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,cad [0]);
                    stmt.setString(4,cad1 [0]);
                    stmt.setString(5,cad1 [1]);
                    stmt.setString(6,cad1 [2]);

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    String depmun1 = request.getParameter("codtiposoportes");
                    
                    String[] cad1 = depmun1.split(" ");
                    
                    stmt.setString(1,request.getParameter("aplicaa").toUpperCase());
                    stmt.setString(2,request.getParameter("observacion").toUpperCase());
                    stmt.setString(3,request.getParameter("archivo").toUpperCase());
                    
                    stmt.setString(4, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(5,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(6,cad [2]);
                    stmt.setString(7,cad [1]);
                    stmt.setString(8,cad [0]);
                    stmt.setString(9,cad1 [0]);
                    stmt.setString(10,cad1 [1]);
                    stmt.setString(11,cad1 [2]);


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