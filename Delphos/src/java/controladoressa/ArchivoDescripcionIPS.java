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

public class ArchivoDescripcionIPS implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO archivodescips ( codregimenpres, codentidadsaludpres, numerofactura, codconceptoservicio, cantidad, valorunitario, valortotal, codestregrips, ususiscodigo, fecharegistro, idencabezado, idregistro) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    

                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE archivodescips SET (codregimenpres, codentidadsaludpres, numerofactura, codconceptoservicio, cantidad, valorunitario, valortotal, codestregrips, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE idencabezado = ? and idregistro = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM archivodescips WHERE idencabezado = ? and idregistro = ?");
                    
                    stmt.setInt(1,Integer.parseInt(request.getParameter("idencabezados")));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("idregistros")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                           
                    String depmun = request.getParameter("codentidadsaludpres");
                    
                    String[] cad = depmun.split(" ");                   
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,request.getParameter("numerofactura").toUpperCase());
                    stmt.setString(4,request.getParameter("codconceptoservicio"));
                    stmt.setInt(5,Integer.parseInt(request.getParameter("cantidad")));
                    stmt.setDouble(6,Double.parseDouble(request.getParameter("valorunitario")));
                    stmt.setDouble(7,Double.parseDouble(request.getParameter("valortotal")));
                    stmt.setString(8,request.getParameter("codestregrips"));
                    
                    stmt.setString(9, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(10,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(11,Integer.parseInt(request.getParameter("idencabezados")));
                    stmt.setInt(12,Integer.parseInt(request.getParameter("idregistros")));

                }
                
                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                c.cerrarConexion();
                msj = "Acci�n No V�lida" + e;
                request.setAttribute("msj",msj);
                return true;
            }
            
            msj = "La informaci�n ha sido " +msj+ " con �xito";  
            request.setAttribute("msj",msj);
            return true;
        }
        return true;
    }
}