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

public class UsuariosSistema implements Control {

    private String msj;
    private ConexionBaseDatos c;

    public boolean doLogic(javax.servlet.http.HttpServletRequest request,
            javax.servlet.http.HttpServletResponse response)
            throws javax.servlet.ServletException, java.io.IOException {
        /*if(request.getSession().getAttribute("login") == null)
        return true;*/

        /*if(request.getSession().getAttribute("login") != null)
        if(!request.getSession().getAttribute("perfil").equals("Administrador"))
        return true;*/

        if (request.getParameter("hacerSubmit") != null && !request.getParameter("hacerSubmit").equals("0")) {
            PreparedStatement stmt = null;
            ResultSet rs = null;
            int idProyecto;


            try {
                c = new ConexionBaseDatos();
                c.abrirConexion();

                if (request.getParameter("hacerSubmit").equals("1")) {
                    stmt = c.con.prepareStatement("INSERT INTO usuariosistema ( ususisusuario,ususiscodigoalt,ususisnombre,ususisapellido,codtipoidentidad,ususisindenfica,grusegcodigo,ususiscontrasena,ususiscambio,ususisfechacrea,ususisfechamodi,ususisdias,codestusuasistema,ususismultisesion,ususisinterno,ususiscodigor,fecharegistro,ususiscodigo) values (?,?,?,?,?,?,?,md5(?),?,?,?,?,?,?,?,?,?,?)");
                    msj = "ingresada";

                } else if (request.getParameter("hacerSubmit").equals("2")) {
                    stmt = c.con.prepareStatement("UPDATE usuariosistema SET ( ususisusuario, ususiscodigoalt, ususisnombre,ususisapellido,codtipoidentidad,ususisindenfica,grusegcodigo,ususiscontrasena,ususiscambio,ususisfechacrea,ususisfechamodi,ususisdias,codestusuasistema,ususismultisesion,ususisinterno,ususiscodigor,fecharegistro) = (?,?,?,?,?,?,?,md5(?),?,?,?,?,?,?,?,?,?) WHERE ususiscodigo = ?");
                    msj = "modificada";
                } else {
                    stmt = c.con.prepareStatement("DELETE FROM usuariosistema WHERE ususiscodigo = ?");
                    stmt.setString(1, request.getParameter("ususiscodigo").toUpperCase());
                    msj = "eliminada";
                }

                if (!request.getParameter("hacerSubmit").equals("3")) {
                    java.util.Date today = new java.util.Date();
                    java.sql.Timestamp ts1 = new java.sql.Timestamp(today.getTime());
                    java.sql.Timestamp ts2 = java.sql.Timestamp.valueOf("0000-00-00 00:00:00");
                    

                    stmt.setString(1, request.getParameter("ususisusuario").toUpperCase());
                    stmt.setString(2, request.getParameter("ususiscodigoalt").toUpperCase());
                    stmt.setString(3, request.getParameter("ususisnombre").toUpperCase());
                    stmt.setString(4, request.getParameter("ususisapellido").toUpperCase());
                    stmt.setString(5, request.getParameter("codtipoidentidad").toUpperCase());
                    stmt.setString(6, request.getParameter("ususisindenfica").toUpperCase());
                    stmt.setString(7, request.getParameter("grusegcodigo").toUpperCase());
                    stmt.setString(8, request.getParameter("ususiscontrasena").toUpperCase());
                    stmt.setString(9, request.getParameter("ususiscambio").toUpperCase());
                    stmt.setTimestamp(10, ts2);
                    stmt.setTimestamp(11, ts2);
                    stmt.setInt(12, 7);
                    stmt.setString(13, request.getParameter("codestusuasistema").toUpperCase());
                    stmt.setString(14, request.getParameter("ususismultisesion").toUpperCase());
                    stmt.setString(15, request.getParameter("ususisinterno").toUpperCase());
                    stmt.setString(16, (String) request.getSession().getAttribute("login"));
                    stmt.setTimestamp(17,ts2);
                    stmt.setString(18, request.getParameter("ususiscodigo").toUpperCase());

                }

                stmt.executeUpdate();
                stmt.close();

                c.cerrarConexion();
            } catch (SQLException e) {
                System.out.println("EROR AL INSERTAR USUARIOSISTEMA: " + e.getMessage());
                c.cerrarConexion();
                msj = "Acci&oacute;n No V&aacute;lida";
                request.setAttribute("msj", msj);
                return true;
            }

            msj = "La informaci&oacute;n ha sido " + msj + " con éxito";
            request.setAttribute("msj", msj);
            return true;
        }
        return true;
    }
}
