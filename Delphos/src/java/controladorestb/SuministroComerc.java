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

public class SuministroComerc implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO suministrocomerc ( descripcion, nombrelargo, nombrecorto, codennorma, codigocum, codalterno, codigorips, numexpediente, observacion, costo, cantmaxima, codigobarras, aplicahombre, aplicamujer, tarifasmdlv, codconcentracion, codformafarmac, codviaadmin, codunidadmedida, codtipomedicamento, codprovetitular, codprovefabrica, fecharegistro, codsumincomerc, codsuministro) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                                        
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE suministrocomerc SET ( descripcion, nombrelargo, nombrecorto, codennorma, codigocum, codalterno, codigorips, numexpediente, observacion, costo, cantmaxima, codigobarras, aplicahombre, aplicamujer, tarifasmdlv, codconcentracion, codformafarmac, codviaadmin, codunidadmedida, codtipomedicamento, codprovetitular, codprovefabrica, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codsumincomerc = ? and codsuministro = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM suministrocomerc WHERE codsumincomerc = ? and codsuministro = ?");
                    stmt.setString(1,request.getParameter("codsumincomerc"));
                    stmt.setString(2,request.getParameter("codsuministro"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setString(2,request.getParameter("nombrelargo").toUpperCase());
                    stmt.setString(3,request.getParameter("nombrecorto").toUpperCase());
                    stmt.setString(4,request.getParameter("codennorma").toUpperCase());
                    stmt.setString(5,request.getParameter("codigocum").toUpperCase());
                    stmt.setString(6,request.getParameter("codalterno").toUpperCase());
                    stmt.setString(7,request.getParameter("codigorips").toUpperCase());
                    stmt.setString(8,request.getParameter("numexpediente").toUpperCase());                   
                    stmt.setString(9,request.getParameter("observacion").toUpperCase());                    
                    stmt.setDouble(10,Double.parseDouble(request.getParameter("costo"))); //numeric(12,2)
                    stmt.setInt(11,Integer.parseInt(request.getParameter("cantmaxima")));
                    stmt.setString(12,request.getParameter("codigobarras").toUpperCase());
                    stmt.setString(13,request.getParameter("aplicahombre").toUpperCase());
                    stmt.setString(14,request.getParameter("aplicamujer").toUpperCase());
                    stmt.setDouble(15,Double.parseDouble(request.getParameter("tarifasmdlv"))); //numeric(12,2)                      
                    stmt.setString(16,request.getParameter("codconcentracion"));
                    stmt.setString(17,request.getParameter("codformafarmac"));
                    stmt.setString(18,request.getParameter("codviaadmin"));
                    stmt.setString(19,request.getParameter("codunidadmedida"));
                    stmt.setString(20,request.getParameter("codtipomedicamento"));
                    stmt.setString(21,request.getParameter("codprovetitular"));
                    stmt.setString(22,request.getParameter("codprovefabrica"));
                    
                    //stmt.setString(23, (String) request.getSession().getAttribute("login"));
                    
                    stmt.setTimestamp(23,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(24,request.getParameter("codsumincomerc"));
                    stmt.setString(25,request.getParameter("codsuministro"));
                    
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