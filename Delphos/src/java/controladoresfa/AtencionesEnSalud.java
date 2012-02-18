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

public class AtencionesEnSalud implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO saludatencion ( codregimenips, codentidadsaludips, codregimeneapb, codentidadsaludeapb, codtipoidentidad, salateidenti, codactividadsalud, salatecantid, salatefecate, salatefactur, codfinalidadconsulta, coddiagnosticopr, coddiagnosticor1, coddiagnosticor2, coddiagnosticor3, coddiagnosticosa, coddiagnosticonu, ususiscodigo, fecharegistro, salateidregi ) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                    
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE saludatencion SET ( codregimenips, codentidadsaludips, codregimeneapb, codentidadsaludeapb, codtipoidentidad, salateidenti, codactividadsalud, salatecantid, salatefecate, salatefactur, codfinalidadconsulta, coddiagnosticopr, coddiagnosticor1, coddiagnosticor2, coddiagnosticor3, coddiagnosticosa, coddiagnosticonu, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE salateidregi = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM saludatencion WHERE  salateidregi = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("salateidregi")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    String depmun = request.getParameter("codentidadsaludeapb");
                    
                    String[] cad = depmun.split(" ");
                    
                    String depmun1 = request.getParameter("codentidadsaludips");
                    
                    String[] cad1 = depmun1.split(" ");
                    
                    stmt.setString(1,cad1[0]);
                    stmt.setString(2,cad1[1]);
                    stmt.setString(3,cad[0]);
                    stmt.setString(4,cad[1]);//
                    stmt.setString(5,request.getParameter("codtipoidentidad"));
                    stmt.setString(6,request.getParameter("salateidenti").toUpperCase());
                    stmt.setInt(7,Integer.parseInt(request.getParameter("codactividadsalud")));
                    stmt.setInt(8,Integer.parseInt(request.getParameter("salatecantid")));
                    stmt.setDate(9,FormatosFecha.fechaToDate(request.getParameter("salatefecate")));
                    stmt.setString(10,request.getParameter("salatefactur").toUpperCase());
                    stmt.setString(11,request.getParameter("codfinalidadconsulta"));
                    stmt.setString(12,request.getParameter("coddiagnosticopr"));
                    stmt.setString(13,request.getParameter("coddiagnosticor1"));
                    stmt.setString(14,request.getParameter("coddiagnosticor2"));
                    stmt.setString(15,request.getParameter("coddiagnosticor3"));
                    stmt.setString(16,request.getParameter("coddiagnosticosa"));
                    stmt.setString(17,request.getParameter("coddiagnosticonu"));
                                       
                    stmt.setString(18, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(19,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(20,Integer.parseInt(request.getParameter("salateidregi")));
                    //stmt.setString(5,cad[0]);
                    //stmt.setString(6,cad[1]);
                    //stmt.setString(7,cad[2]);
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