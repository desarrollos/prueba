package controladores;

import clases.UtilidadesDKDA;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.StringTokenizer;
import java.util.Vector;
import clases.ConexionBaseDatos;
import clases.FormatosFecha;

public class NovedadesPoblacion implements Control{
    
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
        
        if(request.getParameter("hacerSubmit") != null)
        {
            PreparedStatement stmt1 = null, stmt2 = null;
            ResultSet rs1 = null, rs2 = null;
            String codentidadsalud = "";
            
            codentidadsalud = request.getParameter("codentidadsalud");
            
            try
            {
                c = new ConexionBaseDatos();
                c.abrirConexion();
                
                String sql;
                sql = "SELECT n.idusuario,n.codtiponovedad,n.codcampoarchivo,n.idencabezado, n.fecha,n.datoactualizado,l.nombrecampotabla,l.nombretabla "+
                      "FROM novedadcampo n, encabezadoarchivo e, poblacion p, listacamposarchivo l, tipoidentificacion t "+
                      "WHERE n.idencabezado=e.idencabezado AND e.codentidadsalud='"+codentidadsalud+"' AND n.codestadoregistro='SVAL' AND p.idusuario=n.idusuario AND n.codcampoarchivo=l.codcampoarchivo AND t.codtipoidentidad=p.codtipoidentafiliado";

                stmt1 = c.con.prepareStatement(sql);
                rs1 = stmt1.executeQuery();
                while(rs1.next())
                {
                    String valorCheckBox, codTipoNovedad, nombreCampoTabla, nombreTabla, datoActualizado;
                    java.sql.Date fecha;
                    double idUsuario, codCampoArchivo,idEncabezado;

                    codTipoNovedad = rs1.getString("codtiponovedad");
                    nombreTabla = rs1.getString("nombretabla");
                    nombreCampoTabla = rs1.getString("nombrecampotabla");
                    datoActualizado = rs1.getString("datoactualizado");
                    fecha = rs1.getDate("fecha");
                    idUsuario = rs1.getDouble("idusuario");
                    codCampoArchivo = rs1.getDouble("codcampoarchivo");
                    idEncabezado = rs1.getDouble("idencabezado");
                    
                    String[] novedades = request.getParameterValues("novedades");
                    for (int i=0;i<novedades.length; i++) 
                    {
                        valorCheckBox = idUsuario+"|"+codTipoNovedad+"|"+codCampoArchivo+"|"+UtilidadesDKDA.formatoFecha(fecha)+"|"+idEncabezado;
                        valorCheckBox = valorCheckBox.replace(".0","");
                        if(valorCheckBox.equals(novedades[i]))
                        {
                            stmt2 = c.con.prepareStatement("UPDATE poblacion SET "+nombreCampoTabla+"=? WHERE idusuario=?");
                            stmt2.setString(1,datoActualizado);
                            stmt2.setDouble(2,idUsuario);
                            stmt2.executeUpdate();
                            stmt2.close();
                            
                            stmt2 = c.con.prepareStatement("UPDATE novedadcampo SET codestadoregistro=? WHERE idusuario=? AND codtiponovedad=? AND codcampoarchivo=? AND fecha=? AND idencabezado=?");
                            stmt2.setString(1,"VAL");
                            stmt2.setDouble(2,idUsuario);
                            stmt2.setString(3,codTipoNovedad);
                            stmt2.setDouble(4,codCampoArchivo);
                            stmt2.setDate(5,fecha);
                            stmt2.setDouble(6,idEncabezado);
                            stmt2.executeUpdate();
                            stmt2.close();
                        }
                    }
                    /*StringTokenizer tokensInmuebles=new StringTokenizer("","|");
                    while(tokensInmuebles.hasMoreTokens())
                    {
                        codentidadsalud = tokensInmuebles.nextToken();
                    }*/
                }
                
                rs1.close();
                stmt1.close();
                
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
                  +"\n<script>alert('La información ha sido actualizada con exito!')</script>"
                  +"<script>window.top.location='ValidarPoblacion.jsp?codentidadsalud="+codentidadsalud+"';</script>";

            request.setAttribute("msj",msj);
            return true;
        }
        return true;
    }
}