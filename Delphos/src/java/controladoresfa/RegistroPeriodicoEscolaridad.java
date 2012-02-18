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

public class RegistroPeriodicoEscolaridad implements Control{
    
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
                if(!request.getParameter("espearchivo").isEmpty() && !request.getParameter("espearchivo").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("espearchivo")+"')";
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO escregperiodico (codtipoidentidadfir, firmidentifi, espefechregi, especlasprog, espenumefall, espefalljust, especertesco, especertreci, especumprequ, espearchivo, archivofi, espeobservac, ususiscodigo, fecharegistro, codtipoidentidadins, codempresa, codtipoidentidad, escidentific, escvigencia, espefechinic, espefechfina) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE escregperiodico SET ( codtipoidentidadfir, firmidentifi, espefechregi, especlasprog, espenumefall, espefalljust, especertesco, especertreci, especumprequ, espearchivo, archivofi, espeobservac, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?) WHERE codtipoidentidadins = ? and codempresa = ? and codtipoidentidad = ? and escidentific = ? and escvigencia = ? and espefechinic = ? and espefechfina = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM escregperiodico WHERE codtipoidentidadins = ? and codempresa = ? and codtipoidentidad = ? and escidentific = ? and escvigencia = ? and espefechinic = ? and espefechfina = ?");
                    
                    String depmun = request.getParameter("escidentifics");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad[0]);
                    stmt.setString(2,cad[1]);
                    stmt.setString(3,cad[2]);
                    stmt.setString(4,cad[3]);
                    stmt.setInt(5,Integer.parseInt(cad[4]));
                    stmt.setDate(6,FormatosFecha.fechaToDate(request.getParameter("espefechinics")));
                    stmt.setDate(7,FormatosFecha.fechaToDate(request.getParameter("espefechfinas")));
                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("escidentifics");                    
                    String[] cad = depmun.split(" ");
                    
                    
                    String codemp1 = request.getParameter("firmidentifis");                    
                    String[] cad1 = codemp1.split(" ");
                    
                    stmt.setString(1,cad1[0]);
                    stmt.setInt(2,Integer.parseInt(cad1[1]));
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("espefechregi")));
                    stmt.setInt(4,Integer.parseInt(request.getParameter("especlasprog")));
                    stmt.setInt(5,Integer.parseInt(request.getParameter("espenumefall")));
                    stmt.setInt(6,Integer.parseInt(request.getParameter("espefalljust")));
                    stmt.setString(7,request.getParameter("especertesco").toUpperCase());
                    stmt.setString(8,request.getParameter("especertreci").toUpperCase());
                    stmt.setString(9,request.getParameter("especumprequ").toUpperCase());
                    stmt.setString(10,request.getParameter("espearchivo").toUpperCase());
                    stmt.setString(11,request.getParameter("espeobservac").toUpperCase());
                    
                    stmt.setString(12, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(13,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(14,cad[0]);
                    stmt.setString(15,cad[1]);
                    stmt.setString(16,cad[2]);
                    stmt.setString(17,cad[3]);
                    stmt.setInt(18,Integer.parseInt(cad[4]));
                    stmt.setDate(19,FormatosFecha.fechaToDate(request.getParameter("espefechinics")));
                    stmt.setDate(20,FormatosFecha.fechaToDate(request.getParameter("espefechfinas")));                    
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