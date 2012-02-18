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

public class Empresa implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO empresa ( digitoverificacion, nombre, sigla, telefono, fax, lineagratuita, coddepartamento, codmunicipio, codsubgrupo, codbarrio, direccion, gerente, codactividadeconomica, codsectorentidad, codtipoaportante, email, paginaweb, codtipocontribuyente, codclasepersona, empresasistema, empcodigodane, ususiscodigo, fecharegistro, codtipoidentidad, codempresa) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE empresa SET ( digitoverificacion, nombre, sigla, telefono, fax, lineagratuita, coddepartamento, codmunicipio, codsubgrupo, codbarrio, direccion, gerente, codactividadeconomica, codsectorentidad, codtipoaportante, email, paginaweb, codtipocontribuyente, codclasepersona, empresasistema, empcodigodane, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codtipoidentidad = ? and codempresa = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM empresa WHERE codtipoidentidad = ? and codempresa = ?");
                    stmt.setString(1,request.getParameter("codtipoidentidads"));
                    stmt.setString(2,request.getParameter("codempresas"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                   
                    String depmun = request.getParameter("codbarrio");                    
                    String[] cad = depmun.split(" ");
                                        
                    stmt.setString(1,request.getParameter("digitoverificacion"));
                    stmt.setString(2,request.getParameter("nombreempresa").toUpperCase());
                    stmt.setString(3,request.getParameter("sigla").toUpperCase());
                    stmt.setString(4,request.getParameter("telefono").toUpperCase());
                    stmt.setString(5,request.getParameter("fax").toUpperCase());
                    stmt.setString(6,request.getParameter("lineagratuita").toUpperCase());
                    stmt.setInt(7,Integer.parseInt(cad[0]));                    
                    stmt.setInt(8,Integer.parseInt(cad[1]));                    
                    stmt.setInt(9,Integer.parseInt(cad[2]));                    
                    stmt.setInt(10,Integer.parseInt(cad[3]));                    
                    stmt.setString(11,request.getParameter("direccion").toUpperCase());
                    stmt.setString(12,request.getParameter("gerente").toUpperCase());
                    stmt.setString(13,request.getParameter("codactividadeconomica"));
                    stmt.setString(14,request.getParameter("codsectorentidad"));
                    stmt.setString(15,request.getParameter("codtipoaportante"));
                    stmt.setString(16,request.getParameter("email"));
                    stmt.setString(17,request.getParameter("paginaweb"));
                    stmt.setString(18,request.getParameter("codtipocontribuyente"));
                    stmt.setString(19,request.getParameter("codclasepersona"));
                    stmt.setString(20,request.getParameter("empresasistema").toUpperCase());
                    stmt.setString(21,request.getParameter("empcodigodane"));
                    
                    stmt.setString(22, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(23,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(24,request.getParameter("codtipoidentidads"));
                    stmt.setString(25,request.getParameter("codempresas"));
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