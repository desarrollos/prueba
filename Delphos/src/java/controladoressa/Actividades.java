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

public class Actividades implements Control{
    
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
                    stmt = c.con.prepareStatement("INSERT INTO actividadcontrato ( codestadoregistro, porcplan, valoractividad, valormedico, valoranestesiologo, valorayudantia, valorsala, valormatesucu, valorperfusion, aplicahombre, aplicamujer, cantmaxima, codtipoperiodo, incluyetodoact, cantsincopago, codalterno, codunidmededadini, edadinicial, codunidmededadfin, edadfinal, observacion, ususiscodigo, fecharegistro, codregimenes, codentidadsalud, codcontrato, codtipometodologia, codactividadsalud, anyo, mesinicial, codtipoplantarifa) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )");
                    msj = "ingresada";                    
                    
                }
                else if( request.getParameter("hacerSubmit").equals("2") )
                {
                    stmt = c.con.prepareStatement("UPDATE actividadcontrato SET ( codestadoregistro, porcplan, valoractividad, valormedico, valoranestesiologo, valorayudantia, valorsala, valormatesucu, valorperfusion, aplicahombre, aplicamujer, cantmaxima, codtipoperiodo, incluyetodoact, cantsincopago, codalterno, codunidmededadini, edadinicial, codunidmededadfin, edadfinal, observacion, ususiscodigo, fecharegistro) = ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and codtipometodologia = ? and codactividadsalud = ? and anyo = ? and mesinicial = ? and codtipoplantarifa = ? ");
                    msj = "modificada";                                        
                }
                else
                {
                    stmt = c.con.prepareStatement("DELETE FROM actividadcontrato WHERE codregimenes = ? and codentidadsalud = ? and codcontrato = ? and codtipometodologia = ? and codactividadsalud = ? and anyo = ? and mesinicial = ? and codtipoplantarifa = ?");
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    String depmun1 = request.getParameter("codtipoplantarifas");
                    
                    String[] cad1 = depmun1.split(" ");
                    
                    stmt.setString(1,cad [0]);
                    stmt.setString(2,cad [1]);
                    stmt.setString(3,cad [2]);
                    stmt.setInt(4,Integer.parseInt(cad1 [0]));
                    stmt.setInt(5,Integer.parseInt(cad1 [1]));
                    stmt.setInt(6,Integer.parseInt(cad1 [2]));
                    stmt.setInt(7,Integer.parseInt(cad1 [3]));
                    stmt.setString(8,cad1 [4]);

                    msj = "eliminada";
                }                
                
                if( !request.getParameter("hacerSubmit").equals("3") )
                {
                    
                    String depmun = request.getParameter("codcontratos");
                    
                    String[] cad = depmun.split(" ");
                    
                    String depmun1 = request.getParameter("codtipoplantarifas");
                    
                    String[] cad1 = depmun1.split(" ");
                    
                    stmt.setString(1,request.getParameter("codestadoregistro"));
                    stmt.setDouble(2,Double.parseDouble(request.getParameter("porcplan")));
                    stmt.setDouble(3,Double.parseDouble(request.getParameter("valoractividad")));
                    stmt.setDouble(4,Double.parseDouble(request.getParameter("valormedico")));
                    stmt.setDouble(5,Double.parseDouble(request.getParameter("valoranestesiologo")));
                    stmt.setDouble(6,Double.parseDouble(request.getParameter("valorayudantia")));
                    stmt.setDouble(7,Double.parseDouble(request.getParameter("valorsala")));
                    stmt.setDouble(8,Double.parseDouble(request.getParameter("valormatesucu")));
                    stmt.setDouble(9,Double.parseDouble(request.getParameter("valorperfusion")));
                    stmt.setString(10,request.getParameter("aplicahombre").toUpperCase());
                    stmt.setString(11,request.getParameter("aplicamujer").toUpperCase());
                    stmt.setInt(12,Integer.parseInt(request.getParameter("cantmaxima")));
                    stmt.setInt(13,Integer.parseInt(request.getParameter("codtipoperiodo")));
                    stmt.setString(14,request.getParameter("incluyetodoact").toUpperCase());
                    stmt.setInt(15,Integer.parseInt(request.getParameter("cantsincopago")));
                    stmt.setString(16,request.getParameter("codalterno").toUpperCase());
                    stmt.setString(17,request.getParameter("codunidmededadini"));
                    stmt.setInt(18,Integer.parseInt(request.getParameter("edadinicial")));
                    stmt.setString(19,request.getParameter("codunidmededadfin"));
                    stmt.setInt(20,Integer.parseInt(request.getParameter("edadfinal")));
                    stmt.setString(21,request.getParameter("observacion").toUpperCase());
                    
                    stmt.setString(22, (String) request.getSession().getAttribute("login"));                 
                    stmt.setTimestamp(23,Timestamp.valueOf(FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual())));

                    stmt.setString(24,cad [0]);
                    stmt.setString(25,cad [1]);
                    stmt.setString(26,cad [2]);
                    stmt.setInt(27,Integer.parseInt(cad1 [0]));
                    stmt.setInt(28,Integer.parseInt(cad1 [1]));
                    stmt.setInt(29,Integer.parseInt(cad1 [2]));
                    stmt.setInt(30,Integer.parseInt(cad1 [3]));
                    stmt.setString(31,cad1 [4]);

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