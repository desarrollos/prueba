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

public class ManualLiquidacion implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO manualliquidacion ( mesfinal, codgrupoquirurgico, codnivelcomplejidad, coduvr, aplicauvr, numerosmdlv, valoractividad, ayuda, codactividadsaludhonmed, valorhonmedico, codactividadsaludhonanes, valorhonanest, codactividadsaluddersala, valordersala, codactividadsaludmasucu, valormasucu, codactividadsaludperfu, valorperfusion, ususiscodigo, fecharegistro, codtipometodologia, codactividadsalud, anyo, mesinicial ) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE manualliquidacion SET ( mesfinal, codgrupoquirurgico, codnivelcomplejidad, coduvr, aplicauvr, numerosmdlv, valoractividad, ayuda, codactividadsaludhonmed, valorhonmedico, codactividadsaludhonanes, valorhonanest, codactividadsaluddersala, valordersala, codactividadsaludmasucu, valormasucu, codactividadsaludperfu, valorperfusion, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codtipometodologia = ? and codactividadsalud = ? and anyo = ? and mesinicial = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM manualliquidacion WHERE codtipometodologia = ? and codactividadsalud = ? and anyo = ? and mesinicial = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("codtipometodologias")));                    
                    stmt.setInt(2,Integer.parseInt(request.getParameter("codactividadsaluds")));                    
                    stmt.setInt(3,Integer.parseInt(request.getParameter("anyos")));                    
                    stmt.setInt(4,Integer.parseInt(request.getParameter("mesinicials")));                    
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                        
                    stmt.setInt(1,Integer.parseInt(request.getParameter("mesfinal")));                    
                    stmt.setInt(2,Integer.parseInt(request.getParameter("codgrupoquirurgico")));                    
                    stmt.setString(3,request.getParameter("codnivelcomplejidad"));
                    stmt.setInt(4,Integer.parseInt(request.getParameter("coduvr")));                    
                    stmt.setString(5,request.getParameter("aplicauvr").toUpperCase());
                    stmt.setInt(6,Integer.parseInt(request.getParameter("numerosmdlv"))); 
                    stmt.setDouble(7,Double.parseDouble(request.getParameter("valoractividad")));     //numeric(12,2)               
                    stmt.setString(8,request.getParameter("ayuda").toUpperCase());
                    stmt.setInt(9,Integer.parseInt(request.getParameter("codactividadsaludhonmed")));                    
                    stmt.setDouble(10,Double.parseDouble(request.getParameter("valorhonmedico")));                     //numeric(12,2)               
                    stmt.setInt(11,Integer.parseInt(request.getParameter("codactividadsaludhonanes")));                    
                    stmt.setDouble(12,Double.parseDouble(request.getParameter("valorhonanest")));        //numeric(12,2)                           
                    stmt.setInt(13,Integer.parseInt(request.getParameter("codactividadsaluddersala")));                    
                    stmt.setDouble(14,Double.parseDouble(request.getParameter("valordersala")));     //numeric(12,2)                                            
                    stmt.setInt(15,Integer.parseInt(request.getParameter("codactividadsaludmasucu")));   
                    stmt.setDouble(16,Double.parseDouble(request.getParameter("valormasucu")));        //numeric(12,2)                           
                    stmt.setInt(17,Integer.parseInt(request.getParameter("codactividadsaludperfu")));                    
                    stmt.setDouble(18,Double.parseDouble(request.getParameter("valorperfusion")));     //numeric(12,2)    
                    
                    stmt.setString(19, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(20,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setInt(21,Integer.parseInt(request.getParameter("codtipometodologias")));                    
                    stmt.setInt(22,Integer.parseInt(request.getParameter("codactividadsaluds")));                    
                    stmt.setInt(23,Integer.parseInt(request.getParameter("anyos")));                    
                    stmt.setInt(24,Integer.parseInt(request.getParameter("mesinicials")));
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