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

public class PagoCompartido implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO pagocompartidocto ( codtipoconcvalor, porcconcanyo, porcconcevento, valortopeanyo, valortopeevento, ususiscodigo, fecharegistro, codregimenes, codentidadsalud, codcontrato, codestrato) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE pagocompartidocto SET ( codtipoconcvalor, porcconcanyo, porcconcevento, valortopeanyo, valortopeevento, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ? ) WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and codestrato = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM pagocompartidocto WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and codestrato = ?");
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,cad [2]);
                    stmt.setInt(4,Integer.parseInt(request.getParameter("codestratos")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("codtipoconcvalor"));
                    stmt.setDouble(2,Double.parseDouble(request.getParameter("porcconcanyo")));
                    stmt.setDouble(3,Double.parseDouble(request.getParameter("porcconcevento")));
                    stmt.setDouble(4,Double.parseDouble(request.getParameter("valortopeanyo")));
                    stmt.setDouble(5,Double.parseDouble(request.getParameter("valortopeevento")));
                    
                    stmt.setString(6, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(7,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(8,cad [0]);
                    stmt.setString(9,cad [1]);
                    stmt.setString(10,cad [2]);
                    stmt.setInt(11,Integer.parseInt(request.getParameter("codestratos")));

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