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

public class Liquidacion implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO liquidacioncto ( codtipoactacontrato, codregimenes, codentidadsalud, codcontrato, numeroacta, fecha, nota, nroalterno, saldocontrato, observacionsaldo, ususiscodigo, fecharegistro, nroliquidacion) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                             
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE liquidacioncto SET (codtipoactacontrato, codregimenes, codentidadsalud, codcontrato, numeroacta, fecha, nota, nroalterno, saldocontrato, observacionsaldo, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE nroliquidacion = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM liquidacioncto WHERE nroliquidacion = ?");
                    
                    stmt.setString(1,request.getParameter("nroliquidacion"));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("numeroacta");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,cad [2]);
                    stmt.setString(4,cad [3]);
                    stmt.setString(5,cad [4]);
                    stmt.setDate(6,FormatosFecha.fechaToDate(request.getParameter("fecha")));
                    stmt.setString(7,request.getParameter("nota").toUpperCase());
                    stmt.setString(8,request.getParameter("nroalterno").toUpperCase());
                    stmt.setDouble(9,Double.parseDouble(request.getParameter("saldocontrato")));  
                    stmt.setString(10,request.getParameter("observacionsaldo").toUpperCase());
                    
                    stmt.setString(11, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(12,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(13,request.getParameter("nroliquidacion"));

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