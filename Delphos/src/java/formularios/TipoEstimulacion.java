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

public class TipoEstimulacion extends HttpServlet {

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
            String respuesta = validarFormulario_tipoestimulacion();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_tipoestimulacion(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_tipoestimulacion(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_tipoestimulacion(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_tipoestimulacion(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_tipoestimulacion(ConexionBaseDatos con) {
        System.out.println("registrar_tipoestimulacion");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO tipoestimulacion (tipestcodigo,tipestdescri,tipestobserv,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "tipestcodigo_tipoestimulacion").equals("") ? null : "'" + dkda.o(vars, "tipestcodigo_tipoestimulacion") + "'") + "," + (dkda.o(vars, "tipestdescri_tipoestimulacion").equals("") ? null : "'" + dkda.o(vars, "tipestdescri_tipoestimulacion") + "'") + "," + (dkda.o(vars, "tipestobserv_tipoestimulacion").equals("") ? null : "'" + dkda.o(vars, "tipestobserv_tipoestimulacion") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_tipoestimulacion&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_tipoestimulacion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error tipoestimulacion.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_tipoestimulacion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE tipoestimulacion SET tipestcodigo = " + (dkda.o(vars, "tipestcodigo_tipoestimulacion").equals("") ? null : "'" + dkda.o(vars, "tipestcodigo_tipoestimulacion") + "'") + ",tipestdescri = " + (dkda.o(vars, "tipestdescri_tipoestimulacion").equals("") ? null : "'" + dkda.o(vars, "tipestdescri_tipoestimulacion") + "'") + ",tipestobserv = " + (dkda.o(vars, "tipestobserv_tipoestimulacion").equals("") ? null : "'" + dkda.o(vars, "tipestobserv_tipoestimulacion") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE tipestcodigo = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_tipoestimulacion&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_tipoestimulacion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error tipoestimulacion.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_tipoestimulacion(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM tipoestimulacion WHERE tipestcodigo = '" + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_tipoestimulacion&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_tipoestimulacion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error tipoestimulacion.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_tipoestimulacion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "     tipoestimulacion.tipestcodigo AS tipoestimulacion_tipestcodigo,"
                    + "     tipoestimulacion.tipestdescri AS tipoestimulacion_tipestdescri,"
                    + "     tipoestimulacion.tipestobserv AS tipoestimulacion_tipestobserv,"
                    + "     tipoestimulacion.ususiscodigo AS tipoestimulacion_ususiscodigo,"
                    + "     tipoestimulacion.fecharegistro AS tipoestimulacion_fecharegistro"
                    + " FROM "
                    + "     public.tipoestimulacion tipoestimulacion"
                    + " WHERE tipoestimulacion.tipestcodigo = '" + codigo + "'";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#tipestcodigo_tipoestimulacion|" + (rs.getString("tipoestimulacion_tipestcodigo") == null ? "" : rs.getString("tipoestimulacion_tipestcodigo")) + ":_";
            info += "text|#tipestdescri_tipoestimulacion|" + (rs.getString("tipoestimulacion_tipestdescri") == null ? "" : rs.getString("tipoestimulacion_tipestdescri")) + ":_";
            info += "text|#tipestobserv_tipoestimulacion|" + (rs.getString("tipoestimulacion_tipestobserv") == null ? "" : rs.getString("tipoestimulacion_tipestobserv")) + ":_";

            respuesta = "opcion=obtener_tipoestimulacion&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_tipoestimulacion&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error tipoestimulacion - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_tipoestimulacion() {
        String direccion = "opcion=registrar_tipoestimulacion&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_tipoestimulacion();

        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "tipestcodigo_tipoestimulacion"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "tipestcodigo_tipoestimulacion").isEmpty()) {
            error = "Código Tipo Estimulación: no puede ser vacio.";
        } else if (dkda.o(vars, "tipestdescri_tipoestimulacion").isEmpty()) {
            error = "Descripción: no puede ser vacio.";
        } else if (dkda.o(vars, "tipestobserv_tipoestimulacion").isEmpty()) {
            error = "Observaciones: no puede ser vacio.";
        } else if (dkda.o(vars, "tipestcodigo_tipoestimulacion").length() > 3) {
            error = "Código Tipo Estimulación: Valor demasiado Largo.";
        } else if (dkda.o(vars, "tipestdescri_tipoestimulacion").length() > 40) {
            error = "Descripción: Valor demasiado Largo.";
        } else if (dkda.o(vars, "tipestobserv_tipoestimulacion").length() > 400) {
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

    private boolean existe_tipoestimulacion() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM tipoestimulacion  WHERE tipestcodigo = '" + dkda.o(vars, "tipestcodigo_tipoestimulacion") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_tipoestimulacion() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }
}