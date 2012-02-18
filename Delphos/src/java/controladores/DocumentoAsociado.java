package controladores;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.ConexionBaseDatos;
import clases.FormatosFecha;

public class DocumentoAsociado implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO documentocontrato ( codtipofasecontrato, codtipoactacontrato, archivo, codregimenes, codentidadsalud, codcontrato, codtipodctoasociado, consecutivo) values ( ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE documentocontrato SET ( codtipofasecontrato, codtipoactacontrato, archivo) = ( ?, ?, ? ) WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and codtipodctoasociado = ? and consecutivo = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM documentocontrato WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and codtipodctoasociado = ? and consecutivo = ?");
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,cad [2]);
                    stmt.setString(4,request.getParameter("codtipodctoasociados").toUpperCase());
                    stmt.setInt(5,Integer.parseInt(request.getParameter("consecutivos")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("codtipofasecontrato").toUpperCase());
                    stmt.setString(2,request.getParameter("codtipoactacontrato").toUpperCase());
                    stmt.setString(3,request.getParameter("archivo").toUpperCase());
                    stmt.setString(4,cad [0]);
                    stmt.setString(5,cad [1]);
                    stmt.setString(6,cad [2]);
                    stmt.setString(7,request.getParameter("codtipodctoasociados").toUpperCase());
                    stmt.setInt(8,Integer.parseInt(request.getParameter("consecutivos")));

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