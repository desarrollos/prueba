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

public class NovedadEscolaridad implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO escolaridadnovedad ( escnovfecha, codtipoidentidad, codempresa, codtiponovedad, escnovarchi, archivofi, escnovobserv, ususiscodigo, fecharegistro, codtipoideninsact, codempresaact, codtipoidentidadest, escidentificest, escvigencia, escnovconsec) values ( ?, ?, ?, ?, ?, lo_import('"+ruta+request.getParameter("escnovarchi")+"'), ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE escolaridadnovedad SET ( escnovfecha, codtipoidentidad, codempresa, codtiponovedad, escnovarchi, archivofi, escnovobserv, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, lo_import('"+ruta+request.getParameter("escnovarchi")+"'), ?, ?, ?) WHERE codtipoideninsact = ? and codempresaact = ? and codtipoidentidadest = ? and escidentificest = ? and escvigencia = ? and escnovconsec = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM escolaridadnovedad WHERE codtipoideninsact = ? and codempresaact = ? and codtipoidentidadest = ? and escidentificest = ? and escvigencia = ? and escnovconsec = ?");
                    
                    String depmun = request.getParameter("escidentificests");                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad[0]);
                    stmt.setString(2,cad[1]);  
                    stmt.setString(3,cad[2]);  
                    stmt.setString(4,cad[3]);
                    stmt.setInt(5,Integer.parseInt(cad[4]));
                    stmt.setInt(6,Integer.parseInt(request.getParameter("escnovconsecs")));
                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    String depmun = request.getParameter("codempresa");                    
                    String[] cad = depmun.split(" ");
                    
                    String codemp = request.getParameter("escidentificests");                    
                    String[] cad1 = codemp.split(" "); 
                    
                    stmt.setDate(1,FormatosFecha.fechaToDate(request.getParameter("escnovfecha")));
                    stmt.setString(2,cad[0]);
                    stmt.setString(3,cad[1]);
                    stmt.setString(4,request.getParameter("codtiponovedad"));
                    stmt.setString(5,request.getParameter("escnovarchi").toUpperCase());
                    stmt.setString(6,request.getParameter("escnovobserv").toUpperCase());
                    
                    
                    stmt.setString(7, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(8,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(9,cad1[0]);
                    stmt.setString(10,cad1[1]);  
                    stmt.setString(11,cad1[2]);
                    stmt.setString(12,cad1[3]);
                    stmt.setInt(13,Integer.parseInt(cad1[4]));
                    stmt.setInt(14,Integer.parseInt(request.getParameter("escnovconsecs")));                    
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