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

public class PagosContrato implements Control{
    
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
                if(!request.getParameter("archivoegreso").isEmpty() && !request.getParameter("archivoegreso").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("archivoegreso")+"')";
                
                String archivoGuardar2 = null;
                if(!request.getParameter("archivopago").isEmpty() && !request.getParameter("archivopago").equals(null))
                    archivoGuardar2 = "lo_import('"+ruta+request.getParameter("archivopago")+"')";
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO pagosecretariacto ( codregimen, descripcion, fechapago, codcuentacontable, codtipoidentempr, codempresa, fechainicial, codtipocubrimupc, anyoinicial, mesinicial, valorpago, nrousuarios, saldocontrato, facturaeapb, observacion, archivoegreso, archivofi, archivopago, archivofi2, ususiscodigo, fecharegistro, fechafinal, codregimenes, codentidadsalud, codcontrato, nroorden) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, "+archivoGuardar2+", ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                                        
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE pagosecretariacto SET (codregimen, descripcion, fechapago, codcuentacontable, codtipoidentempr, codempresa, fechainicial, codtipocubrimupc, anyoinicial, mesinicial, valorpago, nrousuarios, saldocontrato, facturaeapb, observacion, archivoegreso, archivofi, archivopago, archivofi2, ususiscodigo, fecharegistro, fechafinal) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, "+archivoGuardar2+", ?, ?, ? ) WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and nroorden = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM pagosecretariacto WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and nroorden = ?");
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,cad [2]);
                    stmt.setString(4,request.getParameter("nroordens"));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    String reg = request.getParameter("codregimen");
                    
                    String[] cad1 = reg.split(" ");
                    
                    String codemp = request.getParameter("codempresa");
                    
                    String[] cad2 = codemp.split(" ");
                    
                    stmt.setString(1,cad1 [0]);
                    stmt.setString(2,request.getParameter("descripcion").toUpperCase());
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("fechapago")));
                    stmt.setString(4,request.getParameter("codcuentacontable"));
                    stmt.setString(5,cad2 [0]);
                    stmt.setString(6,cad2 [1]);
                    stmt.setDate(7,FormatosFecha.fechaToDate(request.getParameter("fechainicial")));
                    stmt.setString(8,cad1 [1]);
                    stmt.setInt(9,Integer.parseInt(cad1 [2]));
                    stmt.setInt(10,Integer.parseInt(cad1 [3]));
                    stmt.setDouble(11,Double.parseDouble(request.getParameter("valorpago"))); 
                    stmt.setInt(12,Integer.parseInt(request.getParameter("nrousuarios")));
                    stmt.setDouble(13,Double.parseDouble(request.getParameter("saldocontrato"))); 
                    stmt.setString(14,request.getParameter("facturaeapb").toUpperCase());
                    stmt.setString(15,request.getParameter("observacion").toUpperCase());
                    stmt.setString(16,request.getParameter("archivoegreso").toUpperCase());
                    stmt.setString(17,request.getParameter("archivopago").toUpperCase());
                    
                    stmt.setString(18, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(19,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setDate(20,FormatosFecha.fechaToDate(request.getParameter("fechafinal")));

                    stmt.setString(21,cad [0]);
                    stmt.setString(22,cad [1]);
                    stmt.setString(23,cad [2]);
                    stmt.setString(24,request.getParameter("nroordens"));

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