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

public class GrupoTitular implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO grupotitular ( observacion, ususiscodigo, fecharegistro, codclagrutit, codunifami, codtipoidentidad, identitfam ) values ( ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                  
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE grupotitular SET ( observacion, ususiscodigo, fecharegistro ) = ( ?, ?, ? ) WHERE codclagrutit = ? and codunifami = ? and codtipoidentidad = ? and identitfam = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM grupotitular WHERE  codclagrutit = ? and codunifami = ? and codtipoidentidad = ? and identitfam = ?");
                    
                    String depmun = request.getParameter("identitfams");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("codclagrutits"));
                    stmt.setString(2,cad[0]);
                    stmt.setString(3,cad[1]);
                    stmt.setString(4,cad[2]);
                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    String depmun = request.getParameter("identitfams");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("observacion").toUpperCase());
                    
                    stmt.setString(2, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(3,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(4,request.getParameter("codclagrutits"));
                    stmt.setString(5,cad[0]);
                    stmt.setString(6,cad[1]);
                    stmt.setString(7,cad[2]);
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