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

public class Proveedor implements Control{
    
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
            
            
            try
            {
                c = new ConexionBaseDatos();
                c.abrirConexion();
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO proveedor ( nombre, codtipoidentprov, numeroidentprov, codtipoproveedor, codestadoprov, codsectorentidad, codactividadeconomica, codtipoidentgerente, numidentfuncgere, codtipoidentcontac, numidentfunccontac, sigla, codhabilitacion, nombrehabilitac, telefono, fax, lineagratuita, email, coddepartamento, codmunicipio, direccion, codigobarras, ususiscodigo, fecharegistro, codproveedor) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                    msj = "ingresada";                    
                                        
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE proveedor SET ( nombre, codtipoidentprov, numeroidentprov, codtipoproveedor, codestadoprov, codsectorentidad, codactividadeconomica, codtipoidentgerente, numidentfuncgere, codtipoidentcontac, numidentfunccontac, sigla, codhabilitacion, nombrehabilitac, telefono, fax, lineagratuita, email, coddepartamento, codmunicipio, direccion, codigobarras, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codproveedor = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM proveedor WHERE codproveedor = ?");
                    stmt.setString(1,request.getParameter("codproveedor"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    String depmun = request.getParameter("numidentfuncgere");
                    
                    String[] cad = depmun.split(" ");
                    
                    String depmun1 = request.getParameter("numidentfunccontac");
                    
                    String[] cad1 = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("nombre").toUpperCase());
                    stmt.setString(2,request.getParameter("codtipoidentprov"));
                    stmt.setString(3,request.getParameter("numeroidentprov").toUpperCase());
                    stmt.setString(4,request.getParameter("codtipoproveedor"));
                    stmt.setString(5,request.getParameter("codestadoprov"));
                    stmt.setString(6,request.getParameter("codsectorentidad"));
                    stmt.setString(7,request.getParameter("codactividadeconomica"));
                    stmt.setString(8,cad[0]);
                    stmt.setString(9,cad[1]);
                    stmt.setString(10,cad1[0]);
                    stmt.setString(11,cad1[1]);
                    stmt.setString(12,request.getParameter("sigla").toUpperCase());
                    stmt.setString(13,request.getParameter("codhabilitacion"));
                    stmt.setString(14,request.getParameter("nombrehabilitac").toUpperCase());
                    stmt.setString(15,request.getParameter("telefono").toUpperCase());
                    stmt.setString(16,request.getParameter("fax").toUpperCase());
                    stmt.setString(17,request.getParameter("lineagratuita").toUpperCase());
                    stmt.setString(18,request.getParameter("email"));
                    stmt.setInt(19,Integer.parseInt(request.getParameter("coddepartamento"))); 
                    stmt.setInt(20,Integer.parseInt(request.getParameter("codmunicipio")));
                    stmt.setString(21,request.getParameter("direccion").toUpperCase());
                    stmt.setString(22,request.getParameter("codigobarras"));
                                                       
                    stmt.setString(23, (String) request.getSession().getAttribute("login"));
                    
                    stmt.setTimestamp(24,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(25,request.getParameter("codproveedor"));                    
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