package controladores;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.ConexionBaseDatos;
import clases.FormatosFecha;

public class FuncionarioPorContrato implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO funcionariocontrato ( codtipofuncccto, codempresa, codcargo, observacion, codregimenes, codentidadsalud, codcontrato, codtipoidentidad, numidentfunc, codtipofasecontrato) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                    String depmun = request.getParameter("codcontrato");
                    
                    String[] cad = depmun.split(" ");
                    
                    String idenfun = request.getParameter("numidentfunc");
                    
                    String[] cad1 = idenfun.split(" ");
                    
                    stmt.setString(5,cad [0]);
                    stmt.setString(6,cad [1]);
                    stmt.setString(7,cad [2]);
                    stmt.setString(8,cad1 [0]);
                    stmt.setString(9,cad1 [1]);
                    stmt.setString(10,request.getParameter("codtipofasecontrato").toUpperCase());                    

                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE funcionariocontrato SET ( codtipofuncccto, codempresa, codcargo, observacion) = ( ?, ?, ?, ? ) WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and codtipoidentidad = ? and numidentfunc = ? and codtipofasecontrato = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM funcionariocontrato codregimenes = ? and codentidadsalud = ? and codcontrato = ? and codtipoidentidad = ? and numidentfunc = ? and codtipofasecontrato = ?");
                    
                    String depmun = request.getParameter("codcontrato");
                    
                    String[] cad = depmun.split(" ");
                    
                    String idenfun = request.getParameter("numidentfunc");
                    
                    String[] cad1 = idenfun.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,cad [2]);
                    stmt.setString(4,cad1 [0]);
                    stmt.setString(5,cad1 [1]);
                    stmt.setString(6,request.getParameter("codtipofasecontrato").toUpperCase()); 

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codcontrato");
                    
                    String[] cad = depmun.split(" ");
                    
                    String idenfun = request.getParameter("numidentfunc");
                    
                    String[] cad1 = idenfun.split(" ");
                    
                    stmt.setString(1,request.getParameter("codtipofuncccto").toUpperCase());
                    stmt.setString(2,request.getParameter("codempresa").toUpperCase());
                    stmt.setString(3,request.getParameter("codcargo").toUpperCase());
                    stmt.setString(4,request.getParameter("observacion").toUpperCase());
                    stmt.setString(5,cad [0]);
                    stmt.setString(6,cad [1]);
                    stmt.setString(7,cad [2]);
                    stmt.setString(8,cad1 [0]);
                    stmt.setString(9,cad1 [1]);
                    stmt.setString(10,request.getParameter("codtipofasecontrato").toUpperCase());

                }
                
                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            }
            catch(SQLException e)
            {
                c.cerrarConexion();
                msj = "Error al Actualizar la Base de Datos: "+e+"<br>\n<script>alert('Error al Actualizar el Proyecto')</script>";
                request.setAttribute("msj",msj);
                return true;
            }
            
            msj = "La información ha sido " +msj+ " con exito<br>"
                  +"\n<script>alert('La información ha sido " +msj+ " con exito!')</script>"
                  +"<script>window.top.location='FuncionarioPorContrato.jsp';</script>";

            request.setAttribute("msj",msj);
            return true;
        }
        return true;
    }
}