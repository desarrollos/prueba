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

public class Escolaridad implements Control{
    
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
                if(!request.getParameter("escarchimatr").isEmpty() && !request.getParameter("escarchimatr").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("escarchimatr")+"')";
                
                String archivoGuardar2 = null;
                if(!request.getParameter("escarchicert").isEmpty() && !request.getParameter("escarchicert").equals(null))
                    archivoGuardar2 = "lo_import('"+ruta+request.getParameter("escarchicert")+"')";


                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO escolaridad ( escfecharegi, escfechamatr, escnumermatr, escgracodigo, escprofesor, escestcodigo, escarchimatr, archivofi, escarchicert, archivofi2, escobservaci, ususiscodigo, fecharegistro, codtipoidentidadins, codempresa, codtipoidentidad, escidentific, escvigencia) values ( ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, "+archivoGuardar2+", ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE escolaridad SET ( escfecharegi, escfechamatr, escnumermatr, escgracodigo, escprofesor, escestcodigo, escarchimatr, archivofi, escarchicert, archivofi2, escobservaci, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, "+archivoGuardar2+", ?, ?, ?) WHERE codtipoidentidadins = ? and codempresa = ? and codtipoidentidad = ? and escidentific = ? and escvigencia = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM escolaridad WHERE codtipoidentidadins = ? and codempresa = ? and codtipoidentidad = ? and escidentific = ? and escvigencia = ?");
                    
                    String depmun = request.getParameter("codempresas");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad[0]);
                    stmt.setString(2,cad[1]);
                    stmt.setString(3,request.getParameter("codtipoidentidads"));
                    stmt.setString(4,request.getParameter("escidentifics"));
                    stmt.setInt(5,Integer.parseInt(request.getParameter("escvigencias")));
                    
                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codempresas");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setDate(1,FormatosFecha.fechaToDate(request.getParameter("escfecharegi")));
                    stmt.setString(2,request.getParameter("escfechamatr"));
//                    stmt.setDate(2,FormatosFecha.fechaToDate(request.getParameter("escfechamatr")));
                    stmt.setString(3,request.getParameter("escnumermatr"));
                    stmt.setString(4,request.getParameter("escgracodigo"));
                    stmt.setString(5,request.getParameter("escprofesor"));                    
                    stmt.setString(6,request.getParameter("escestcodigo").toUpperCase());                    
                    stmt.setString(7,request.getParameter("escarchimatr").toUpperCase());
                    stmt.setString(8,request.getParameter("escarchicert").toUpperCase());
                    stmt.setString(9,request.getParameter("escobservaci").toUpperCase());
                    
                    stmt.setString(10, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(11,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(12,cad[0]);
                    stmt.setString(13,cad[1]);
                    stmt.setString(14,request.getParameter("codtipoidentidads"));
                    stmt.setString(15,request.getParameter("escidentifics"));
                    stmt.setInt(16,Integer.parseInt(request.getParameter("escvigencias")));
                                      
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