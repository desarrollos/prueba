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

public class EscGrupoGrado extends HttpServlet {

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
            String respuesta = validarFormulario_escgrupogrado();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_escgrupogrado(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_escgrupogrado(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_escgrupogrado(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_escgrupogrado(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_escgrupogrado(ConexionBaseDatos con) {
        System.out.println("registrar_escgrupogrado");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO escgrupogrado (grugracodigo,grugradescri,escgracodigoin,escgracodigofi,grugraobserv,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "grugracodigo_escgrupogrado").equals("") ? null : "'" + dkda.o(vars, "grugracodigo_escgrupogrado") + "'") + "," + (dkda.o(vars, "grugradescri_escgrupogrado").equals("") ? null : "'" + dkda.o(vars, "grugradescri_escgrupogrado") + "'") + "," + (dkda.o(vars, "escgracodigoin_escgrupogrado").equals("") ? null : "'" + dkda.o(vars, "escgracodigoin_escgrupogrado") + "'") + "," + (dkda.o(vars, "escgracodigofi_escgrupogrado").equals("") ? null : "'" + dkda.o(vars, "escgracodigofi_escgrupogrado") + "'") + "," + (dkda.o(vars, "grugraobserv_escgrupogrado").equals("") ? null : "'" + dkda.o(vars, "grugraobserv_escgrupogrado") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_escgrupogrado&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_escgrupogrado&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error escgrupogrado.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_escgrupogrado(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE escgrupogrado SET grugracodigo = " + (dkda.o(vars, "grugracodigo_escgrupogrado").equals("") ? null : "'" + dkda.o(vars, "grugracodigo_escgrupogrado") + "'") + ",grugradescri = " + (dkda.o(vars, "grugradescri_escgrupogrado").equals("") ? null : "'" + dkda.o(vars, "grugradescri_escgrupogrado") + "'") + ",escgracodigoin = " + (dkda.o(vars, "escgracodigoin_escgrupogrado").equals("") ? null : "'" + dkda.o(vars, "escgracodigoin_escgrupogrado") + "'") + ",escgracodigofi = " + (dkda.o(vars, "escgracodigofi_escgrupogrado").equals("") ? null : "'" + dkda.o(vars, "escgracodigofi_escgrupogrado") + "'") + ",grugraobserv = " + (dkda.o(vars, "grugraobserv_escgrupogrado").equals("") ? null : "'" + dkda.o(vars, "grugraobserv_escgrupogrado") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE grugracodigo = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_escgrupogrado&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_escgrupogrado&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error escgrupogrado.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_escgrupogrado(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM escgrupogrado WHERE grugracodigo = '" + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_escgrupogrado&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_escgrupogrado&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error escgrupogrado.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_escgrupogrado(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT grugracodigo, grugradescri, (SELECT escgradescri FROM escolaridadgrado , escgrupogrado  WHERE escgracodigo =  escgracodigoin AND grugracodigo = '" + codigo + "' ), escgracodigoin, (SELECT escgradescri FROM escolaridadgrado , escgrupogrado  WHERE escgracodigo =  escgracodigofi AND grugracodigo = '" + codigo + "' ), escgracodigofi,"
                    + " grugraobserv,  ususiscodigo, fecharegistro  FROM escgrupogrado WHERE grugracodigo = '" + codigo + "'";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#grugracodigo_escgrupogrado|"
                    + (rs.getString(1) == null ? ""
                    : rs.getString(1)) + ":_";

            info += "text|#grugradescri_escgrupogrado|"
                    + (rs.getString(2) == null ? ""
                    : rs.getString(2)) + ":_";

            info += "combo|#escgracodigoin_escgrupogrado|" + rs.getString(4)
                    + "|llenarCombo('escgracodigoin_escgrupogrado', '" + rs.getString(4)
                    + "', '" + rs.getString(3) + "'):_";

            info += "combo|#escgracodigofi_escgrupogrado|" + rs.getString(6)
                    + "|llenarCombo('escgracodigofi_escgrupogrado', '" + rs.getString(6)
                    + "', '" + rs.getString(5) + "'):_";

            info += "text|#grugraobserv_escgrupogrado|"
                    + (rs.getString(7) == null ? ""
                    : rs.getString(7)) + ":_";

            respuesta = "opcion=obtener_escgrupogrado&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_escgrupogrado&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error escgrupogrado - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_escgrupogrado() {
        String direccion = "opcion=registrar_escgrupogrado&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_escgrupogrado();

        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "grugracodigo_escgrupogrado"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "grugracodigo_escgrupogrado").isEmpty()) {
            error = "Código Grupo Grado Escolaridad: no puede ser vacio.";
        } else if (dkda.o(vars, "grugradescri_escgrupogrado").isEmpty()) {
            error = "Descripción: no puede ser vacio.";
        } else if (dkda.o(vars, "escgracodigoin_escgrupogrado").isEmpty()) {
            error = "Grado Escolaridad Inicial: no puede ser vacio.";
        } else if (dkda.o(vars, "escgracodigofi_escgrupogrado").isEmpty()) {
            error = "Grado Escolaridad Final: no puede ser vacio.";
        } else if (dkda.o(vars, "grugracodigo_escgrupogrado").length() > 3) {
            error = "Código Grupo Grado Escolaridad: Valor demasiado Largo.";
        } else if (dkda.o(vars, "grugradescri_escgrupogrado").length() > 30) {
            error = "Descripción: Valor demasiado Largo.";
        } else if (dkda.o(vars, "grugraobserv_escgrupogrado").length() > 400) {
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

    private boolean existe_escgrupogrado() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM escgrupogrado  WHERE grugracodigo = '" + dkda.o(vars, "codigo") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_escgrupogrado() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }
}