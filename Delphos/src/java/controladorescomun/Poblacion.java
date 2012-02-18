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

public class Poblacion implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO poblacion ( codtipoidentafiliado, numeroidentafiliado, primernombre, segundonombre, primerapellido, segundoapellido, codsexo, codestadocivil, fechanacimiento, coddepartamentonac, codmunicipionac, nombrepadre, nombremadre, telefonores, direccionres, coddepartamentore ,codmunicipiore, codsubgrupo, barriores, codsectorgeografico, codzonageo, tipoidentcotizante, tipoidentaportante, consecutivoafil, fechaafilsissegsoc, fechaafileps, codtipoafiliado, codtipocotizante, numeroidentcotizante, codregimenctoppal, codentidadsaludctoppal, codcontratoppal, afiliadoenbdua, ususiscodigo, fecharegistro, idusuario ) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE poblacion SET ( codtipoidentafiliado, numeroidentafiliado, primernombre, segundonombre, primerapellido, segundoapellido, codsexo, codestadocivil, fechanacimiento, coddepartamentonac, codmunicipionac, nombrepadre, nombremadre, telefonores, direccionres, coddepartamentore ,codmunicipiore, codsubgrupo, barriores, codsectorgeografico, codzonageo, tipoidentcotizante, tipoidentaportante, consecutivoafil, fechaafilsissegsoc, fechaafileps, codtipoafiliado, codtipocotizante, numeroidentcotizante, codregimenctoppal, codentidadsaludctoppal, codcontratoppal, afiliadoenbdua, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE idusuario = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM poblacion WHERE idusuario = ?");
                    stmt.setInt(1,Integer.parseInt(request.getParameter("idusuario")));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                       
                    stmt.setString(1,request.getParameter("codtipoidentafiliado"));
                    stmt.setString(2,request.getParameter("numeroidentafiliado").toUpperCase());
                    stmt.setString(3,request.getParameter("primernombre").toUpperCase());
                    stmt.setString(4,request.getParameter("segundonombre").toUpperCase());
                    stmt.setString(5,request.getParameter("primerapellido").toUpperCase());
                    stmt.setString(6,request.getParameter("segundoapellido").toUpperCase());
                    stmt.setString(7,request.getParameter("codsexo"));
                    stmt.setString(8,request.getParameter("codestadocivil"));
                    stmt.setDate(9,FormatosFecha.fechaToDate(request.getParameter("fechanacimiento")));
                    stmt.setInt(10,Integer.parseInt(request.getParameter("coddepartamentos")));
                    stmt.setInt(11,Integer.parseInt(request.getParameter("codmunicipios")));
                    stmt.setString(12,request.getParameter("nombrepadre").toUpperCase());
                    stmt.setString(13,request.getParameter("nombremadre").toUpperCase());
                    
                    stmt.setString(14,request.getParameter("telefonores").toUpperCase());
                    stmt.setString(15,request.getParameter("direccionres").toUpperCase());
                    stmt.setInt(16,Integer.parseInt(request.getParameter("coddepartamentore")));
                    stmt.setInt(17,Integer.parseInt(request.getParameter("codmunicipiore")));
                    stmt.setInt(18,Integer.parseInt(request.getParameter("codsubgrupo")));
                    stmt.setInt(19,Integer.parseInt(request.getParameter("barriores")));
                    
                    stmt.setString(20,request.getParameter("codsectorgeografico"));
                    stmt.setString(21,request.getParameter("codzonageo"));
                    
                    stmt.setString(22,request.getParameter("tipoidentcotizante"));
                    stmt.setString(23,"CC");
                    
                    stmt.setInt(24,Integer.parseInt(request.getParameter("consecutivoafil")));
                    stmt.setDate(25,FormatosFecha.fechaToDate(request.getParameter("fechaafilsissegsoc")));
                    stmt.setDate(26,FormatosFecha.fechaToDate(request.getParameter("fechaafileps")));
                    stmt.setString(27,request.getParameter("codtipoafiliado"));
                    stmt.setString(28,request.getParameter("codtipocotizante"));
                    stmt.setString(29,request.getParameter("numeroidentcotizante"));
                    
                    String var = request.getParameter("codregimenctoppals");
                    String[] cad = var.split(" ");
                    
                    stmt.setString(30,cad[0]);
                    stmt.setString(31,cad[1]);
                    stmt.setString(32,cad[2]);
                    
                    stmt.setString(33,request.getParameter("afiliadoenbdua"));
                    
                    stmt.setString(34, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(35,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setInt(36,Integer.parseInt(request.getParameter("idusuario")));                                
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