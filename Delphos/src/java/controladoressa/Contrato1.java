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

public class Contrato1 implements Control{
    
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
                if(!request.getParameter("archivo").isEmpty() && !request.getParameter("archivo").equals(null))
                    archivoGuardar = "lo_import('"+ruta+request.getParameter("archivo")+"')";
                
                if( request.getParameter("hacerSubmit").equals("1") )
                {
                    stmt = c.con.prepareStatement("INSERT INTO contrato ( codregimen, numero, descripcion, objeto, fechainicio, fechafinal, codtipocontrato, codgrupopoblacion, codaplicacioncontrato, codclasecontrato, codtipocubrimupc, anyoinicial, mesinicial, codestadocontrato, formapago, coddepartamento, codmunicipio, valor, archivo, archivofi, codigobarras, fechalegalizac, observacion, codmodalidadcontrato, codtiponorma, codnorma, fechanorma, nroradicacion, fechasuscripcion, codtipoidencontratante, codemprcontratante, codtipoidencontratista, codemprcontratista, usuariosconttrato, ususiscodigo, fecharegistro, codregimenes, codentidadsalud, codcontrato ) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE contrato SET ( codregimen, numero, descripcion, objeto, fechainicio, fechafinal, codtipocontrato, codgrupopoblacion, codaplicacioncontrato, codclasecontrato, codtipocubrimupc, anyoinicial, mesinicial, codestadocontrato, formapago, coddepartamento, codmunicipio, valor, archivo, archivofi, codigobarras, fechalegalizac, observacion, codmodalidadcontrato, codtiponorma, codnorma, fechanorma, nroradicacion, fechasuscripcion, codtipoidencontratante, codemprcontratante, codtipoidencontratista, codemprcontratista, usuariosconttrato, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "+archivoGuardar+", ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM contrato WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ?");
                    
                    String depmun = request.getParameter("codentidadsaluds");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,cad[0]);
                    stmt.setString(2,cad[1]);
                    stmt.setString(3,request.getParameter("codcontratos"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    String depmun = request.getParameter("codentidadsaluds");
                    
                    String[] cad = depmun.split(" ");
                    
                    String depmun1 = request.getParameter("codtipocubrimupc");
                    
                    String[] cad1 = depmun1.split(" ");
                    
                    String depmun2 = request.getParameter("codnorma");
                    
                    String[] cad2 = depmun2.split(" ");
                    
                    String depmun3 = request.getParameter("codemprcontratista");
                    
                    String[] cad3 = depmun3.split(" ");
                    
                    String depmun4 = request.getParameter("codemprcontratante");
                    
                    String[] cad4 = depmun4.split(" ");

                    stmt.setString(1,cad1[0]);
                    stmt.setString(2,request.getParameter("numero").toUpperCase());
                    stmt.setString(3,request.getParameter("descripcion").toUpperCase());
                    stmt.setString(4,request.getParameter("objeto").toUpperCase());
                    stmt.setDate(5,FormatosFecha.fechaToDate(request.getParameter("fechainicio")));
                    stmt.setDate(6,FormatosFecha.fechaToDate(request.getParameter("fechafinal")));
                    stmt.setString(7,request.getParameter("codtipocontrato"));
                    stmt.setInt(8,Integer.parseInt(request.getParameter("codgrupopoblacion")));
                    stmt.setString(9,request.getParameter("codaplicacioncontrato"));
                    stmt.setString(10,request.getParameter("codclasecontrato"));
                    stmt.setString(11,cad1[1]);
                    stmt.setInt(12,Integer.parseInt(cad1[2]));
                    stmt.setInt(13,Integer.parseInt(cad1[3]));
                    stmt.setString(14,request.getParameter("codestadocontrato"));
                    stmt.setString(15,request.getParameter("formapago").toUpperCase());
                    stmt.setInt(16,Integer.parseInt(request.getParameter("coddepartamento")));
                    stmt.setInt(17,Integer.parseInt(request.getParameter("codmunicipio")));
                    stmt.setDouble(18,Double.parseDouble(request.getParameter("valor")));          
                    
                    stmt.setString(19,request.getParameter("archivo").toUpperCase());
                    
                    stmt.setString(20,request.getParameter("codigobarras").toUpperCase());
                    stmt.setDate(21,FormatosFecha.fechaToDate(request.getParameter("fechalegalizac")));
                    stmt.setString(22,request.getParameter("observacion").toUpperCase());
                    stmt.setString(23,request.getParameter("codmodalidadcontrato"));
                    stmt.setString(24,cad2[0]);
                    stmt.setString(25,cad2[2]);
                    
                    java.sql.Date date;
                    date = java.sql.Date.valueOf(""+cad2[1]);
                    
                    stmt.setDate(26,date);
                    stmt.setString(27,request.getParameter("nroradicacion").toUpperCase());
                    stmt.setDate(28,FormatosFecha.fechaToDate(request.getParameter("fechasuscripcion")));
                    stmt.setString(29,cad4[0]);
                    stmt.setString(30,cad4[1]);
                    stmt.setString(31,cad3[0]);
                    stmt.setString(32,cad3[1]);
                    stmt.setInt(33,Integer.parseInt(request.getParameter("usuariosconttrato")));
                    
                    stmt.setString(34, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(35,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(36,cad[0]);
                    stmt.setString(37,cad[1]);
                    stmt.setString(38,request.getParameter("codcontratos"));

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