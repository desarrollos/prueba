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

public class Vinculacion1 implements Control{
    
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
                if(!request.getParameter("arcdocapro").isEmpty() && !request.getParameter("arcdocapro").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("arcdocapro")+"')";
                
                String archivoGuardar2 = null;
                if(!request.getParameter("archcomins").isEmpty() && !request.getParameter("archcomins").equals(null))
                    archivoGuardar2 = "lo_import('"+ruta+request.getParameter("archcomins")+"')";
                               
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO inscripcion (codtipoidentidad, codempresa, tiidenjefhog, idenjefhog, numerdecla, fechadilig, fechainscr, coddepartamento, codmunicipio, codsubgrupo, codbarrio, codregimenes, codentidadsalud, numcuebanc, codbanco, codtipoidenfunapr, numidentfunc, numeromesa, coditipben, meno7anyos, meno7a18anyos, residmunic, comproblig, fechaaprobac, codtipoidenfundil, numidentfuncdil, codtipoidentidadapr, codempresaapr, arcdocapro, archivofi, numeraprob, codiestfam, archcomins, archivofi2, observacion, ususiscodigo, fecharegistro, codunifami) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, "+archivoGuardar2+", ?, ?, ?, ?)");
                    msj = "ingresada";                    
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE inscripcion SET (codtipoidentidad, codempresa, tiidenjefhog, idenjefhog, numerdecla, fechadilig, fechainscr, coddepartamento, codmunicipio, codsubgrupo, codbarrio, codregimenes, codentidadsalud, numcuebanc, codbanco, codtipoidenfunapr, numidentfunc, numeromesa, coditipben, meno7anyos, meno7a18anyos, residmunic, comproblig, fechaaprobac, codtipoidenfundil, numidentfuncdil, codtipoidentidadapr, codempresaapr, arcdocapro, archivofi, numeraprob, codiestfam, archcomins, archivofi2, observacion, ususiscodigo, fecharegistro) = (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, "+archivoGuardar2+", ?, ?, ?) WHERE codunifami = ?");
                    msj = "modificada";                    
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM inscripcion WHERE codunifami=?");
                    stmt.setString(1,request.getParameter("codunifami"));
                    msj = "eliminada"; 
                }
                
                if( !request.getParameter("hacerSubmit").equals("3"))
                {               
                    String depmun = request.getParameter("codempresas");
                    String[] cad = depmun.split(" ");
                    
                    String depmun2 = request.getParameter("codentidadsaluds");
                    String[] cad2 = depmun2.split(" ");
                    
                    String depmun3 = request.getParameter("numidentfuncs");
                    String[] cad3 = depmun3.split(" ");
                    
                    String depmun4 = request.getParameter("codempresaaprs");
                    String[] cad4 = depmun4.split(" ");
                    
                    String depmun5 = request.getParameter("numidentfuncdils");
                    String[] cad5 = depmun5.split(" ");
                    
                    stmt.setString(1,cad[0]);
                    stmt.setString(2,cad[1]);
                    stmt.setString(3,request.getParameter("tiidenjefhog"));
                    stmt.setString(4,request.getParameter("idenjefhog").toUpperCase());
                    stmt.setString(5,request.getParameter("numerdecla").toUpperCase());
                    stmt.setTimestamp(6,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(request.getParameter("fechadilig"))));
                    stmt.setTimestamp(7,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(request.getParameter("fechainscr"))));
                    stmt.setInt(8,Integer.parseInt(request.getParameter("coddepartamentore")));
                    stmt.setInt(9,Integer.parseInt(request.getParameter("codmunicipiore")));
                    stmt.setInt(10,Integer.parseInt(request.getParameter("codsubgrupo")));
                    stmt.setInt(11,Integer.parseInt(request.getParameter("barriores")));
                    
                    stmt.setString(12,cad2[0]);
                    stmt.setString(13,cad2[1]);
                    stmt.setString(14,request.getParameter("numcuebanc").toUpperCase());
                    stmt.setString(15,request.getParameter("codbanco"));
                    stmt.setString(16,cad3[0]);
                    stmt.setString(17,cad3[1]);
                    stmt.setString(18,request.getParameter("numeromesa").toUpperCase());
                    stmt.setString(19,request.getParameter("coditipben"));
                    stmt.setInt(20,Integer.parseInt(request.getParameter("meno7anyos")));
                    stmt.setInt(21,Integer.parseInt(request.getParameter("meno7a18anyos")));
                    stmt.setString(22,request.getParameter("residmunic").toUpperCase());
                    stmt.setString(23,request.getParameter("comproblig").toUpperCase());
                    stmt.setTimestamp(24,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(request.getParameter("fechaaprobac"))));
                    stmt.setString(25,cad5[0]);
                    stmt.setString(26,cad5[1]);
                    stmt.setString(27,cad4[0]);
                    stmt.setString(28,cad4[1]);
                    stmt.setString(29,request.getParameter("arcdocapro"));
                    
                    stmt.setString(30,request.getParameter("numeraprob").toUpperCase());
                    stmt.setString(31,request.getParameter("codiestfam"));
                    stmt.setString(32,request.getParameter("archcomins"));
                   
                    stmt.setString(33,request.getParameter("observacion").toUpperCase());
                    
                    stmt.setString(34, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(35,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(36,request.getParameter("codunifami"));               
                }
                
                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                c.cerrarConexion();
                msj = "Acción No Válida"+e;
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