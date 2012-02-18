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

public class TitularFamilia implements Control{
    
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
                if(!request.getParameter("firmatitul").isEmpty() && !request.getParameter("firmatitul").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("firmatitul")+"')";
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO titularfamilia ( coditiptit, fechinitit, vivehijos, numecueban, codbanco, codiesttit, observacion, ususiscodigo, fecharegistro, archivofi, firmatitul, codunifami, codtipoidentidad, identitfam) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE titularfamilia SET ( coditiptit, fechinitit, vivehijos, numecueban, codbanco, codiesttit, observacion, ususiscodigo, fecharegistro, archivofi, firmatitul ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ? ) WHERE codunifami = ? and codtipoidentidad = ? and identitfam = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM titularfamilia WHERE codunifami = ? and codtipoidentidad = ? and identitfam = ?");
                    stmt.setString(1,request.getParameter("codunifamis"));
                    stmt.setString(2,request.getParameter("codtipoidentidads"));
                    stmt.setString(3,request.getParameter("identitfams"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                  
                    
                    stmt.setString(1,request.getParameter("coditiptit"));
                    stmt.setDate(2,FormatosFecha.fechaToDate(request.getParameter("fechinitit")));
                    stmt.setString(3,request.getParameter("vivehijos"));
                    stmt.setString(4,request.getParameter("numecueban"));
                    stmt.setString(5,request.getParameter("codbanco"));
                    stmt.setString(6,request.getParameter("codiesttit"));
                    stmt.setString(7,request.getParameter("observacion").toUpperCase());
                    
                    stmt.setString(8, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(9,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                     stmt.setString(10,request.getParameter("firmatitul"));
                    
                    stmt.setString(11,request.getParameter("codunifamis"));
                    stmt.setString(12,request.getParameter("codtipoidentidads"));
                    stmt.setString(13,request.getParameter("identitfams"));
                   
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