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

public class UsuariosAtendidosIPS implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO usuarioatendidoips ( consecutivo, nombre, fechaingreso, codigoprestador, nombreprestador, codigoeapb, nombreeapb, ususiscodigo, fecharegistro, codtipoidentidad, identificacion, fechaactual) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                                        
                    
                    
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE usuarioatendidoips SET (consecutivo, nombre, fechaingreso, codigoprestador, nombreprestador, codigoeapb, nombreeapb, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codtipoidentidad = ? and identificacion = ? and fechaactual = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM usuarioatendidoips WHERE codtipoidentidad = ? and identificacion = ? and fechaactual = ?");
                    
                    stmt.setString(1,request.getParameter("codtipoidentidad"));
                    stmt.setString(2,request.getParameter("identificacion"));
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("fechaactual")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                         
                    //String depmun = request.getParameter("nombreprestador");
                    
                    //String[] cad = depmun.split(" ");
                    
                    //String unicen = request.getParameter("nombreeapb");
                    
                    //String[] cad1 = unicen.split(" ");
                    
                    stmt.setInt(1,Integer.parseInt(request.getParameter("consecutivo")));
                    stmt.setString(2,request.getParameter("nombre").toUpperCase());
                    stmt.setDate(3,FormatosFecha.fechaToDate(request.getParameter("fechaingreso")));
                    stmt.setString(4,request.getParameter("codigoprestador").toUpperCase());
                    stmt.setString(5,request.getParameter("nombreprestador").toUpperCase());
                    stmt.setString(6,request.getParameter("codigoeapb").toUpperCase());
                    stmt.setString(7,request.getParameter("nombreeapb").toUpperCase());
                    
                    stmt.setString(8, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(9,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    //stmt.setString(5,cad1 [1]);
                    //stmt.setString(6,cad1 [0]);
                    //stmt.setString(7,cad1 [1]);
                    //stmt.setString(8,cad1 [0]);
                    stmt.setString(10,request.getParameter("codtipoidentidad"));
                    stmt.setString(11,request.getParameter("identificacion"));
                    stmt.setDate(12,FormatosFecha.fechaToDate(request.getParameter("fechaactual")));

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