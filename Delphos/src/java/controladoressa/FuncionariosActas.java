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

public class FuncionariosActas implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO funcionarioactacto ( codtipofuncionario, codempresa, codcargo, aplicaa, observacion, ususiscodigo, fecharegistro, codtipoactacontrato, codregimenes, codentidadsalud, codcontrato, numeroacta, codtipoidentidad, numidentfunc) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                                        
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE funcionarioactacto SET (codtipofuncionario, codempresa, codcargo, aplicaa, observacion, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ? ) WHERE codtipoactacontrato = ? and codregimenes = ? and codentidadsalud = ? and codcontrato = ? and numeroacta = ? and codtipoidentidad = ? and numidentfunc = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM funcionarioactacto WHERE codtipoactacontrato = ? and codregimenes = ? and codentidadsalud = ? and codcontrato = ? and numeroacta = ? and codtipoidentidad = ? and numidentfunc = ?");
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    String depmun1 = request.getParameter("numidentfuncs");
                    
                    String[] cad1 = depmun1.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,cad [2]);
                    stmt.setString(4,cad [3]);
                    stmt.setString(5,cad [4]);
                    stmt.setString(6,cad1 [0]);
                    stmt.setString(7,cad1 [1]);

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");     
                    
                    String depmun1 = request.getParameter("numidentfuncs");
                    
                    String[] cad1 = depmun1.split(" ");
                    
                    stmt.setString(1,cad1 [2]);
                    stmt.setString(2,request.getParameter("codempresa"));
                    stmt.setString(3,request.getParameter("codcargo"));
                    stmt.setString(4,request.getParameter("aplicaa").toUpperCase());
                    stmt.setString(5,request.getParameter("observacion").toUpperCase()); 
                    
                    stmt.setString(6, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(7,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(8,cad [0]);
                    stmt.setString(9,cad [1]);
                    stmt.setString(10,cad [2]);
                    stmt.setString(11,cad [3]);
                    stmt.setString(12,cad [4]);
                    stmt.setString(13,cad1 [0]);
                    stmt.setString(14,cad1 [1]);

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