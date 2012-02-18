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

public class Funcionario implements Control{
    
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
            
            String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
            ruta = ruta.replaceAll("\\\\","/");
                      
            try
            {
                c = new ConexionBaseDatos();
                c.abrirConexion();
                
                String archivoGuardar = null;
                if(!request.getParameter("fotodocumentoidentidad").isEmpty() && !request.getParameter("fotodocumentoidentidad").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("fotodocumentoidentidad")+"')";

                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO funcionario ( codtipofuncionario, nombre, matriculaprofesional, codtipoidentidademp, codempresa, codcargo, codocupacion, fechanacimiento, telefonofijo, telefonomovil, codregimeneapb, codentidadsaludeapb, codregimenips, codentidadsaludips, fotodocumentoidentidad, archivofi, codestadofuncionario, codespecialidad, codgruposanguineo, codactividadeconomica, ususiscodigo, fecharegistro, codtipoidentidad, numidentfunc) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE funcionario SET ( codtipofuncionario, nombre, matriculaprofesional, codtipoidentidademp, codempresa, codcargo, codocupacion, fechanacimiento, telefonofijo, telefonomovil, codregimeneapb, codentidadsaludeapb, codregimenips, codentidadsaludips, fotodocumentoidentidad, archivofi, codestadofuncionario, codespecialidad, codgruposanguineo, codactividadeconomica, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ?, ? ) WHERE codtipoidentidad = ? and numidentfunc = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM funcionario WHERE codtipoidentidad = ? and numidentfunc = ?");
                    stmt.setString(1,request.getParameter("codtipoidentidads"));
                    stmt.setString(2,request.getParameter("numidentfuncs"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {                                        
                    String depmun = request.getParameter("codentidadsaludeapbs");                    
                    String[] cad = depmun.split(" ");
                    
                    String depmun2 = request.getParameter("codentidadsaludipss");
                    String[] cad1 = depmun2.split(" ");
                    
                    String depmun3 = request.getParameter("codempresas");
                    String[] cad2 = depmun3.split(" ");
                    
                    stmt.setString(1,request.getParameter("codtipofuncionario"));
                    stmt.setString(2,request.getParameter("nombres"));
                    stmt.setString(3,request.getParameter("matriculaprofesional"));
                    stmt.setString(4,cad2[0]);
                    stmt.setString(5,cad2[1]);
                    stmt.setString(6,request.getParameter("codcargo"));
                    stmt.setString(7,request.getParameter("codocupacion"));
                    stmt.setDate(8,FormatosFecha.fechaToDate(request.getParameter("fechanacimiento")));
                    stmt.setString(9,request.getParameter("telefonofijo"));
                    stmt.setString(10,request.getParameter("telefonomovil"));
                    stmt.setString(11,cad[0]);
                    stmt.setString(12,cad[1]);
                    stmt.setString(13,cad1[0]);
                    stmt.setString(14,cad1[1]);
                    //stmt.setString(14,request.getParameter("tienehuellas").toUpperCase());
                    //queda faltando huella digital, foto, firmadigital
                    
                    stmt.setString(15,request.getParameter("fotodocumentoidentidad"));//esta tiene asociado archivofi
                    stmt.setString(16,request.getParameter("codestadofuncionario"));
                    stmt.setString(17,request.getParameter("codespecialidad"));
                    stmt.setString(18,request.getParameter("codgruposanguineo"));                    
                    stmt.setString(19,request.getParameter("codactividadeconomica"));
                    
                    stmt.setString(20, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(21,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(22,request.getParameter("codtipoidentidads"));
                    stmt.setString(23,request.getParameter("numidentfuncs"));
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