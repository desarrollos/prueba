package formularios;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import clases.ConexionBaseDatos;
import clases.UtilidadesDKDA;
import clases.bdS;
import clases.ed_ValidacionCampos;
import clases.estadosSQL;
import java.sql.*;
import java.net.URLDecoder;

public class FinalidadConsulta extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());



        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_finalidadconsulta();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_finalidadconsulta(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_finalidadconsulta(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_finalidadconsulta(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_finalidadconsulta(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_finalidadconsulta(ConexionBaseDatos con) {
        System.out.println("registrar_finalidadconsulta");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO finalidadconsulta (codfinalidadconsulta,descripcion,observacion,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "codfinalidadconsulta_finalidadconsulta").equals("") ? null : "'" + dkda.o(vars, "codfinalidadconsulta_finalidadconsulta") + "'") + "," + (dkda.o(vars, "descripcion_finalidadconsulta").equals("") ? null : "'" + dkda.o(vars, "descripcion_finalidadconsulta") + "'") + "," + (dkda.o(vars, "observacion_finalidadconsulta").equals("") ? null : "'" + dkda.o(vars, "observacion_finalidadconsulta") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_finalidadconsulta&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_finalidadconsulta&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error finalidadconsulta.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_finalidadconsulta(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE finalidadconsulta SET codfinalidadconsulta = " + (dkda.o(vars, "codfinalidadconsulta_finalidadconsulta").equals("") ? null : "'" + dkda.o(vars, "codfinalidadconsulta_finalidadconsulta") + "'") + ",descripcion = " + (dkda.o(vars, "descripcion_finalidadconsulta").equals("") ? null : "'" + dkda.o(vars, "descripcion_finalidadconsulta") + "'") + ",observacion = " + (dkda.o(vars, "observacion_finalidadconsulta").equals("") ? null : "'" + dkda.o(vars, "observacion_finalidadconsulta") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codfinalidadconsulta = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_finalidadconsulta&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_finalidadconsulta&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error finalidadconsulta.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_finalidadconsulta(ConexionBaseDatos con, String codigo) {
        System.out.println("Eliminar entra" + codigo);
        con.abrirConexion();
        String[] codigos = codigo.split(",");
        String nuevosCodigos = "";
        for (int n = 0; n < codigos.length; n++) {
            nuevosCodigos += "'" + codigos[n] + "',";
        }
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            stmt = con.con.prepareStatement("DELETE FROM finalidadconsulta WHERE codfinalidadconsulta = '" + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_finalidadconsulta&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_finalidadconsulta&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error finalidadconsulta.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_finalidadconsulta(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "finalidadconsulta.codfinalidadconsulta AS finalidadconsulta_codfinalidadconsulta,"
                    + "finalidadconsulta.descripcion AS finalidadconsulta_descripcion,"
                    + "finalidadconsulta.observacion AS finalidadconsulta_observacion "
                    + " FROM "
                    + "public.finalidadconsulta finalidadconsulta WHERE codfinalidadconsulta = '" + dkda.o(vars, "codigo") + "' ";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#observacion_finalidadconsulta|" + (rs.getString("finalidadconsulta_observacion") == null ? "" : rs.getString("finalidadconsulta_observacion")) + ":_";
            info += "text|#descripcion_finalidadconsulta|" + (rs.getString("finalidadconsulta_descripcion") == null ? "" : rs.getString("finalidadconsulta_descripcion")) + ":_";
            info += "text|#codfinalidadconsulta_finalidadconsulta|" + (rs.getString("finalidadconsulta_codfinalidadconsulta") == null ? "" : rs.getString("finalidadconsulta_codfinalidadconsulta")) + ":_";

            respuesta = "opcion=obtener_finalidadconsulta&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_finalidadconsulta&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error finalidadconsulta - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_finalidadconsulta() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM finalidadconsulta  WHERE codfinalidadconsulta = '" + dkda.o(vars, "codfinalidadconsulta") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_finalidadconsulta() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_finalidadconsulta() {
        String direccion = "opcion=registrar_finalidadconsulta&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_finalidadconsulta();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codfinalidadconsulta").toString().equals(dkda.o(vars, "codfinalidadconsulta_finalidadconsulta"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codfinalidadconsulta_finalidadconsulta").isEmpty()) {
            error = "Codigo Finalidad: no puede ser vacio.";
        } else if (dkda.o(vars, "descripcion_finalidadconsulta").isEmpty()) {
            error = "Descripci&oacute;n C&oacute;digo: no puede ser vacio.";
        } else if (dkda.o(vars, "observacion_finalidadconsulta").isEmpty()) {
            error = "Observaciones: no puede ser vacio.";
        } else if (!v.alfaNumericos(dkda.o(vars, "codfinalidadconsulta_finalidadconsulta"))) {
            error = "Codigo Finalidad: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "codfinalidadconsulta_finalidadconsulta").length() > 6) {
            error = "Codigo Finalidad: Valor demasiado Largo.";
        } else if (dkda.o(vars, "descripcion_finalidadconsulta").length() > 80) {
            error = "Descripci&oacute;n C&oacute;digo: Valor demasiado Largo.";
        } else if (dkda.o(vars, "observacion_finalidadconsulta").length() > 400) {
            error = "Observaciones: Valor demasiado Largo.";
        }



        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }// 

    /** * Handles the HTTP GET method. * @param request servlet request * @param response servlet response * @throws ServletException if a servlet-specific error occurs * @throws IOException if an I/O error occurs */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /** * Handles the HTTP POST method. * @param request servlet request * @param response servlet response * @throws ServletException if a servlet-specific error occurs * @throws IOException if an I/O error occurs */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /** * Returns a short description of the servlet. * @return a String containing servlet description */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
// 
}