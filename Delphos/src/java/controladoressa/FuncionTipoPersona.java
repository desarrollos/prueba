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

public class FuncionTipoPersona implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO funciontipofunccto ( aplicaa, observacion, ususiscodigo, fecharegistro, codregimenes, codentidadsalud, codcontrato, codtipofuncionario, codlistafuncion) values ( ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE funciontipofunccto SET ( aplicaa, observacion, ususiscodigo, fecharegistro) = ( ?, ?, ?, ? ) WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and codtipofuncionario = ? and codlistafuncion = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM funciontipofunccto WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and codtipofuncionario = ? and codlistafuncion = ?");
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,cad [2]);
                    stmt.setString(4,request.getParameter("codtipofuncionarios"));
                    stmt.setString(5,request.getParameter("codlistafuncions"));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("aplicaa").toUpperCase());
                    stmt.setString(2,request.getParameter("observacion").toUpperCase());
                    
                    stmt.setString(3, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(4,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(5,cad [0]);
                    stmt.setString(6,cad [1]);
                    stmt.setString(7,cad [2]);
                    stmt.setString(8,request.getParameter("codtipofuncionarios"));
                    stmt.setString(9,request.getParameter("codlistafuncions"));

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