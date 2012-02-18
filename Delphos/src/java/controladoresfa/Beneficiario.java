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

public class Beneficiario implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO beneficiario ( fechanacim, codigbenef, codtipoparentesco, codtipoidenemp, codempresa, numceresco, escgracodigo, codregimenes, codentidadsalud, numcuebanc, codbanco, vivecontit, codiestben, observacion, ususiscodigo, fecharegistro, codunifami, codtipoidentidad, identbenef) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE beneficiario SET ( fechanacim, codigbenef, codtipoparentesco, codtipoidenemp, codempresa, numceresco, escgracodigo, codregimenes, codentidadsalud, numcuebanc, codbanco, vivecontit, codiestben, observacion, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codunifami = ? and codtipoidentidad = ? and identbenef = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM beneficiario WHERE codunifami = ? and codtipoidentidad = ? and identbenef = ?");
                    stmt.setString(1,request.getParameter("codunifamis"));
                    stmt.setString(2,request.getParameter("codtipoidentidads"));
                    stmt.setString(3,request.getParameter("identbenefs"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    String depmun1 = request.getParameter("codentidadsalud");
                    
                    String[] cad1 = depmun1.split(" ");
                    
                    String depmun = request.getParameter("codempresa");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setDate(1,FormatosFecha.fechaToDate(request.getParameter("fechanacim")));
                    stmt.setString(2,request.getParameter("codigbenef"));
                    stmt.setString(3,request.getParameter("codtipoparentesco"));
                    stmt.setString(4,cad[0]);
                    stmt.setString(5,cad[1]);
                    stmt.setString(6,request.getParameter("numceresco"));
                    stmt.setString(7,request.getParameter("escgracodigo"));
                    stmt.setString(8,cad1[0]);
                    stmt.setString(9,cad1[1]);
                    stmt.setString(10,request.getParameter("numcuebanc"));
                    stmt.setString(11,request.getParameter("codbanco"));
                    stmt.setString(12,request.getParameter("vivecontit").toUpperCase());
                    stmt.setString(13,request.getParameter("codiestben").toUpperCase());
                    stmt.setString(14,request.getParameter("observacion").toUpperCase());
                    
                    stmt.setString(15, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(16,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(17,request.getParameter("codunifamis"));
                    stmt.setString(18,request.getParameter("codtipoidentidads"));
                    stmt.setString(19,request.getParameter("identbenefs"));
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