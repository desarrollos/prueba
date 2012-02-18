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

public class Suministros implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO suministros ( descripcion, nombrelargo, nombrecorto, codnnnorma, codigocum, codalterno, codigorips, numexpediente, codconcentracion, codformafarmac, codviaadmin, codunidadmedida, codgruposumin, codsubgruposumin, codclasesumin, codconceptoservicio, codtipomedicamento, codprotocolo, observacion, costo, cantmaxima, codigobarras, aplicahombre, aplicamujer, tarifasmdlv, ususiscodigo, fecharegistro, codsuministro) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                                        
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE suministros SET ( descripcion, nombrelargo, nombrecorto, codnnnorma, codigocum, codalterno, codigorips, numexpediente, codconcentracion, codformafarmac, codviaadmin, codunidadmedida, codgruposumin, codsubgruposumin, codclasesumin, codconceptoservicio, codtipomedicamento, codprotocolo, observacion, costo, cantmaxima, codigobarras, aplicahombre, aplicamujer, tarifasmdlv, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codsuministro = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM suministros WHERE codsuministro = ?");
                    stmt.setString(1,request.getParameter("codsuministro"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    String depmun = request.getParameter("codgruposumin");
                    
                    String[] cad = depmun.split(" ");
                    
                    
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setString(2,request.getParameter("nombrelargo").toUpperCase());
                    stmt.setString(3,request.getParameter("nombrecorto").toUpperCase());
                    stmt.setString(4,request.getParameter("codnnnorma").toUpperCase());
                    stmt.setString(5,request.getParameter("codigocum").toUpperCase());
                    stmt.setString(6,request.getParameter("codalterno").toUpperCase());
                    stmt.setString(7,request.getParameter("codigorips").toUpperCase());
                    stmt.setString(8,request.getParameter("numexpediente").toUpperCase());
                    stmt.setString(9,request.getParameter("codconcentracion"));
                    stmt.setString(10,request.getParameter("codformafarmac"));
                    stmt.setString(11,request.getParameter("codviaadmin"));
                    stmt.setString(12,request.getParameter("codunidadmedida"));
                    stmt.setString(13,cad[0]);
                    stmt.setString(14,cad[1]);
                    stmt.setString(15,request.getParameter("codclasesumin"));
                    stmt.setString(16,request.getParameter("codconceptoservicio"));
                    stmt.setString(17,request.getParameter("codtipomedicamento"));
                    stmt.setString(18,request.getParameter("codprotocolo"));
                    stmt.setString(19,request.getParameter("observacion").toUpperCase());                    
                    stmt.setDouble(20,Double.parseDouble(request.getParameter("costo"))); //numeric(12,2)
                    stmt.setInt(21,Integer.parseInt(request.getParameter("cantmaxima")));
                    stmt.setString(22,request.getParameter("codigobarras").toUpperCase());
                    stmt.setString(23,request.getParameter("aplicahombre").toUpperCase());
                    stmt.setString(24,request.getParameter("aplicamujer").toUpperCase());
                    stmt.setDouble(25,Double.parseDouble(request.getParameter("tarifasmdlv"))); //numeric(12,2)                   
                    
                    stmt.setString(26, (String) request.getSession().getAttribute("login"));
                    
                    stmt.setTimestamp(27,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(28,request.getParameter("codsuministro"));
                    
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