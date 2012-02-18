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

public class ActividadSalud implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO actividadsalud ( descripcion, observacion, codgrupoactividad, codsubgrupo, codambito, codclaseactividad, codconceptoservicio, codtipoactividad, codcategactividad, codprotocolo, codmanualactividad, codnivelcomplejidad, codigoalterno, codigorips, costo, cantidadmaxautorizar, resultadofinal, codigobarras, permitehombre, permitemujer, tiempoaprox, tarifasmlv, cantidaduvr, ususiscodigo, fecharegistro, codactividadsalud) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE actividadsalud SET ( descripcion, observacion, codgrupoactividad, codsubgrupo, codambito, codclaseactividad, codconceptoservicio, codtipoactividad, codcategactividad, codprotocolo, codmanualactividad, codnivelcomplejidad, codigoalterno, codigorips, costo, cantidadmaxautorizar, resultadofinal, codigobarras, permitehombre, permitemujer, tiempoaprox, tarifasmlv, cantidaduvr, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codactividadsalud = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM actividadsalud WHERE codactividadsalud = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("codactividadsalud")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                     
                    String depmun = request.getParameter("codgrupoactividads");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setString(2,request.getParameter("observacion").toUpperCase());
                    stmt.setInt(3,Integer.parseInt(cad[0]));
                    stmt.setString(4,cad[1]);
                    stmt.setString(5,request.getParameter("codambito"));
                    stmt.setString(6,request.getParameter("codclaseactividad"));                    
                    stmt.setString(7,request.getParameter("codconceptoservicio"));
                    stmt.setString(8,request.getParameter("codtipoactividad"));
                    stmt.setString(9,request.getParameter("codcategactividad"));
                    stmt.setString(10,request.getParameter("codprotocolo"));
                    stmt.setString(11,request.getParameter("codmanualactividad"));
                    stmt.setString(12,request.getParameter("codnivelcomplejidad"));
                    stmt.setString(13,request.getParameter("codigoalterno").toUpperCase());
                    stmt.setString(14,request.getParameter("codigorips").toUpperCase());
                    stmt.setDouble(15,Double.parseDouble(request.getParameter("costo"))); //numeric(12,2)
                    stmt.setInt(16,Integer.parseInt(request.getParameter("cantidadmaxautorizar")));
                    stmt.setString(17,request.getParameter("resultadofinal").toUpperCase());
                    stmt.setString(18,request.getParameter("codigobarras").toUpperCase());                    
                    stmt.setString(19,request.getParameter("permitehombre").toUpperCase());
                    stmt.setString(20,request.getParameter("permitemujer").toUpperCase());
                    stmt.setInt(21,Integer.parseInt(request.getParameter("tiempoaprox")));
                    stmt.setDouble(22,Double.parseDouble(request.getParameter("tarifasmlv")));//numeric(12,2)
                    stmt.setInt(23,Integer.parseInt(request.getParameter("cantidaduvr")));
                    
                    stmt.setString(24, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(25,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setInt(26,Integer.parseInt(request.getParameter("codactividadsalud")));
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