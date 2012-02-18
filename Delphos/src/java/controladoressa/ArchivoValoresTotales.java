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

public class ArchivoValoresTotales implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO archivovlrtotaleapb ( anyo, mes, totalconsulta, totalproceddiagnost, totalprocedquirurg, totalprocednoquirur, totalpromprev, totalestancia, totalhonorarios, totalderechosala, totalmaterinsumos, totalbancosangre, totalprotesortesis, totalmedicampos, totalmedicamnopos, totaltraslpaciente, ususiscodigo, fecharegistro, idencabezado, idregistro) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                  

                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE archivovlrtotaleapb SET (anyo, mes, totalconsulta, totalproceddiagnost, totalprocedquirurg, totalprocednoquirur, totalpromprev, totalestancia, totalhonorarios, totalderechosala, totalmaterinsumos, totalbancosangre, totalprotesortesis, totalmedicampos, totalmedicamnopos, totaltraslpaciente, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE idencabezado = ? and idregistro = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM archivovlrtotaleapb WHERE idencabezado = ? and idregistro = ?");
                    
                    stmt.setInt(1,Integer.parseInt(request.getParameter("idencabezados")));
                    stmt.setInt(2,Integer.parseInt(request.getParameter("idregistros")));

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    stmt.setInt(1,Integer.parseInt(request.getParameter("anyo")));
                    stmt.setString(2,request.getParameter("mes").toUpperCase());
                    stmt.setDouble(3,Double.parseDouble(request.getParameter("totalconsulta")));
                    stmt.setDouble(4,Double.parseDouble(request.getParameter("totalproceddiagnost")));
                    stmt.setDouble(5,Double.parseDouble(request.getParameter("totalprocedquirurg")));
                    stmt.setDouble(6,Double.parseDouble(request.getParameter("totalprocednoquirur")));
                    stmt.setDouble(7,Double.parseDouble(request.getParameter("totalpromprev")));
                    stmt.setDouble(8,Double.parseDouble(request.getParameter("totalestancia")));
                    stmt.setDouble(9,Double.parseDouble(request.getParameter("totalhonorarios")));
                    stmt.setDouble(10,Double.parseDouble(request.getParameter("totalderechosala")));
                    stmt.setDouble(11,Double.parseDouble(request.getParameter("totalmaterinsumos")));
                    stmt.setDouble(12,Double.parseDouble(request.getParameter("totalbancosangre")));
                    stmt.setDouble(13,Double.parseDouble(request.getParameter("totalprotesortesis")));
                    stmt.setDouble(14,Double.parseDouble(request.getParameter("totalmedicampos")));
                    stmt.setDouble(15,Double.parseDouble(request.getParameter("totalmedicamnopos")));
                    stmt.setDouble(16,Double.parseDouble(request.getParameter("totaltraslpaciente")));
                    
                    stmt.setString(17, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(18,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(19,Integer.parseInt(request.getParameter("idencabezados")));
                    stmt.setInt(20,Integer.parseInt(request.getParameter("idregistros")));

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