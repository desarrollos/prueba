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

public class Diagnostico implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO diagnostico ( descripcion, coddiag298, coddiagnostico3char, codnivelcomplejidad, codclasediagnostico, codambitodiagnostico, codeventoepidem, codprotocodiagn, codmanualdiagnostico, codgrupodiagn, codsubgrupodiagn, codigoalterno, codigorips, costo, permitehombre, permitemujer, senotifica, diagnutricion, tiempotratamiento, tarifasmdlv, numerouvr, codigobarras, fechacreacion, ususiscodigo, fecharegistro, coddiagnostico) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                                      
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE diagnostico SET ( descripcion, coddiag298, coddiagnostico3char, codnivelcomplejidad, codclasediagnostico, codambitodiagnostico, codeventoepidem, codprotocodiagn, codmanualdiagnostico, codgrupodiagn, codsubgrupodiagn, codigoalterno, codigorips, costo, permitehombre, permitemujer, senotifica, diagnutricion, tiempotratamiento, tarifasmdlv, numerouvr, codigobarras, fechacreacion, ususiscodigo, fecharegistro ) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) WHERE coddiagnostico = ?");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM diagnostico WHERE coddiagnostico = ?");
                    stmt.setString(1,request.getParameter("coddiagnostico"));
                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                                        
                    String depmun = request.getParameter("codgrupodiagn");
                    
                    String[] cad = depmun.split(" ");
                    
                    stmt.setString(1,request.getParameter("descripcion").toUpperCase());
                    stmt.setString(2,request.getParameter("coddiag298"));
                    stmt.setString(3,request.getParameter("coddiagnostico3char"));
                    stmt.setString(4,request.getParameter("codnivelcomplejidad"));
                    stmt.setString(5,request.getParameter("codclasediagnostico"));
                    stmt.setString(6,request.getParameter("codambitodiagnostico"));
                    stmt.setString(7,request.getParameter("codeventoepidem"));
                    stmt.setString(8,request.getParameter("codprotocodiagn"));
                    stmt.setString(9,request.getParameter("codmanualdiagnostico"));
                    stmt.setString(10,cad[0]);
                    stmt.setString(11,cad[1]);
                    stmt.setString(12,request.getParameter("codigoalterno").toUpperCase());
                    stmt.setString(13,request.getParameter("codigorips").toUpperCase());
                    stmt.setDouble(14,Double.parseDouble(request.getParameter("costo")));//numeric(12,2)
                    stmt.setString(15,request.getParameter("permitehombre").toUpperCase());
                    stmt.setString(16,request.getParameter("permitemujer").toUpperCase());
                    stmt.setString(17,request.getParameter("senotifica").toUpperCase());
                    stmt.setString(18,request.getParameter("diagnutricion").toUpperCase());
                    stmt.setInt(19,Integer.parseInt(request.getParameter("tiempotratamiento")));
                    stmt.setString(20,request.getParameter("tarifasmdlv").toUpperCase());
                    stmt.setInt(21,Integer.parseInt(request.getParameter("numerouvr")));
                    stmt.setString(22,request.getParameter("codigobarras").toUpperCase());
                    stmt.setTimestamp(23,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));
                    
                    stmt.setString(24, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(25,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(26,request.getParameter("coddiagnostico"));
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