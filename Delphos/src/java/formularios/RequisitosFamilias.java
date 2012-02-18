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

public class RequisitosFamilias extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, requisitos_requisitos_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());



        requisitos_requisitos_1 = fun.map(dkda.o(vars, "requisitos_requisitos_1").toString());
        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_requisitos();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_requisitos(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_requisitos(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_requisitos(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_requisitos(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_requisitos(ConexionBaseDatos con) {
        System.out.println("registrar_requisitos");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO requisitos (codtiporequisito,coditipben,codactividadsalud,requisdescri,requisobserv,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(requisitos_requisitos_1, "codtiporequisito").equals("") ? null : "'" + dkda.o(requisitos_requisitos_1, "codtiporequisito") + "'") + "," + (dkda.o(requisitos_requisitos_1, "coditipben").equals("") ? null : "'" + dkda.o(requisitos_requisitos_1, "coditipben") + "'") + "," + (dkda.o(vars, "codactividadsalud_requisitos").equals("") ? null : "'" + dkda.o(vars, "codactividadsalud_requisitos") + "'") + "," + (dkda.o(vars, "requisdescri_requisitos").equals("") ? null : "'" + dkda.o(vars, "requisdescri_requisitos") + "'") + "," + (dkda.o(vars, "requisobserv_requisitos").equals("") ? null : "'" + dkda.o(vars, "requisobserv_requisitos") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_requisitos&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_requisitos&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error requisitos.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_requisitos(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE requisitos SET codtiporequisito = " + (dkda.o(requisitos_requisitos_1, "codtiporequisito").equals("") ? null : "'" + dkda.o(requisitos_requisitos_1, "codtiporequisito") + "'") + ",coditipben = " + (dkda.o(requisitos_requisitos_1, "coditipben").equals("") ? null : "'" + dkda.o(requisitos_requisitos_1, "coditipben") + "'") + ",codactividadsalud = " + (dkda.o(vars, "codactividadsalud_requisitos").equals("") ? null : "'" + dkda.o(vars, "codactividadsalud_requisitos") + "'") + ",requisdescri = " + (dkda.o(vars, "requisdescri_requisitos").equals("") ? null : "'" + dkda.o(vars, "requisdescri_requisitos") + "'") + ",requisobserv = " + (dkda.o(vars, "requisobserv_requisitos").equals("") ? null : "'" + dkda.o(vars, "requisobserv_requisitos") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codtiporequisito = '" + dkda.o(sel, "codtiporequisito") + "' AND coditipben = '" + dkda.o(sel, "coditipben") + "' AND codactividadsalud = '" + dkda.o(sel, "codactividadsalud") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_requisitos&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_requisitos&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error requisitos.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_requisitos(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM requisitos WHERE codtiporequisito = '" + dkda.o(sel, "codtiporequisito") + "' AND coditipben = '" + dkda.o(sel, "coditipben") + "' AND codactividadsalud = '" + dkda.o(sel, "codactividadsalud") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_requisitos&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_requisitos&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error requisitos.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_requisitos(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            respuesta = "opcion=obtener_requisitos&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_requisitos&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error requisitos - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_requisitos() {
        String direccion = "opcion=registrar_requisitos&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = existe_requisitos();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codtiporequisito").toString().equals(dkda.o(vars, "codtiporequisito_requisitos")) && dkda.o(sel, "coditipben").toString().equals(dkda.o(vars, "coditipben_requisitos")) && dkda.o(sel, "codactividadsalud").toString().equals(dkda.o(vars, "codactividadsalud_requisitos"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codtiporequisito_requisitos").isEmpty()) {
            error = "Codigo Requisito: no puede ser vacio.";
        } else if (dkda.o(vars, "coditipben_requisitos").isEmpty()) {
            error = "Tipo de Beneficiario: no puede ser vacio.";
        } else if (dkda.o(vars, "codactividadsalud_requisitos").isEmpty()) {
            error = "Codigo Actividad: no puede ser vacio.";
        } else if (dkda.o(vars, "requisdescri_requisitos").isEmpty()) {
            error = "Descripción del Requisito: no puede ser vacio.";
        } else if (dkda.o(vars, "requisdescri_requisitos").length() > 150) {
            error = "Descripción del Requisito: Valor demasiado Largo.";
        } else if (dkda.o(vars, "requisobserv_requisitos").length() > 400) {
            error = "Observaciones Requisito: Valor demasiado Largo.";
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

    private boolean existe_requisitos() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        System.out.println("SELECT COUNT(*) FROM requisitos  WHERE codtiporequisito = '" + dkda.o(sel, "codtiporequisito") + "'" + " AND coditipben = '" + dkda.o(sel, "coditipben") + "'" + " AND codactividadsalud = '" + dkda.o(sel, "codactividadsalud") + "'");
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM requisitos  WHERE codtiporequisito = '" + dkda.o(sel, "codtiporequisito") + "'" + " AND coditipben = '" + dkda.o(sel, "coditipben") + "'" + " AND codactividadsalud = '" + dkda.o(sel, "codactividadsalud") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_requisitos() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }
}
