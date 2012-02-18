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

public class DocumentoCausal extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, novedadcausal_documentocausal_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());

        novedadcausal_documentocausal_1 = fun.map(dkda.o(vars, "novedadcausal_documentocausal_1").toString());
        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_documentocausal();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_documentocausal(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_documentocausal(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_documentocausal(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_documentocausal(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_documentocausal(ConexionBaseDatos con) {
        System.out.println("registrar_documentocausal");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO documentocausal (codtiponovedad,novcaucodigo,codtipodctoasociado,doccauobserv,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(novedadcausal_documentocausal_1, "codtiponovedad").equals("") ? null : "'" + dkda.o(novedadcausal_documentocausal_1, "codtiponovedad") + "'") + "," + (dkda.o(novedadcausal_documentocausal_1, "novcaucodigo").equals("") ? null : "'" + dkda.o(novedadcausal_documentocausal_1, "novcaucodigo") + "'") + "," + (dkda.o(vars, "codtipodctoasociado_documentocausal").equals("") ? null : "'" + dkda.o(vars, "codtipodctoasociado_documentocausal") + "'") + "," + (dkda.o(vars, "doccauobserv_documentocausal").equals("") ? null : "'" + dkda.o(vars, "doccauobserv_documentocausal") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_documentocausal&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_documentocausal&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error documentocausal.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_documentocausal(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE documentocausal SET codtiponovedad = " + (dkda.o(novedadcausal_documentocausal_1, "codtiponovedad").equals("") ? null : "'" + dkda.o(novedadcausal_documentocausal_1, "codtiponovedad") + "'") + ",novcaucodigo = " + (dkda.o(novedadcausal_documentocausal_1, "novcaucodigo").equals("") ? null : "'" + dkda.o(novedadcausal_documentocausal_1, "novcaucodigo") + "'") + ",codtipodctoasociado = " + (dkda.o(vars, "codtipodctoasociado_documentocausal").equals("") ? null : "'" + dkda.o(vars, "codtipodctoasociado_documentocausal") + "'") + ",doccauobserv = " + (dkda.o(vars, "doccauobserv_documentocausal").equals("") ? null : "'" + dkda.o(vars, "doccauobserv_documentocausal") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codtiponovedad = '" + dkda.o(sel, "codtiponovedad") + "' AND novcaucodigo = '" + dkda.o(sel, "novcaucodigo") + "' AND codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_documentocausal&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_documentocausal&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error documentocausal.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_documentocausal(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM documentocausal WHERE codtiponovedad = '" + dkda.o(sel, "codtiponovedad") + "' AND novcaucodigo = '" + dkda.o(sel, "novcaucodigo") + "' AND codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_documentocausal&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_documentocausal&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error documentocausal.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_documentocausal(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT documentocausal.codtiponovedad       AS documentocausal_codtiponovedad, "
                    + "       documentocausal.novcaucodigo         AS documentocausal_novcaucodigo, "
                    + "       documentocausal.codtipodctoasociado  AS "
                    + "       documentocausal_codtipodctoasociado, "
                    + "       documentocausal.doccauobserv         AS documentocausal_doccauobserv, "
                    + "       documentocausal.ususiscodigo         AS documentocausal_ususiscodigo, "
                    + "       documentocausal.fecharegistro        AS documentocausal_fecharegistro, "
                    + "       novedadcausal.codtiponovedad         AS novedadcausal_codtiponovedad, "
                    + "       novedadcausal.novcaucodigo           AS novedadcausal_novcaucodigo, "
                    + "       novedadcausal.novcaudescri           AS novedadcausal_novcaudescri, "
                    + "       tipodctoasociado.codtipodctoasociado AS "
                    + "       tipodctoasociado_codtipodctoasociado, "
                    + "       tipodctoasociado.descripcion         AS tipodctoasociado_descripcion "
                    + "FROM   public.novedadcausal novedadcausal "
                    + "       inner join public.documentocausal documentocausal "
                    + "         ON novedadcausal.codtiponovedad = documentocausal.codtiponovedad "
                    + "            AND novedadcausal.novcaucodigo = documentocausal.novcaucodigo "
                    + "       inner join public.tipodctoasociado tipodctoasociado "
                    + "         ON documentocausal.codtipodctoasociado = "
                    + "            tipodctoasociado.codtipodctoasociado "
                    + " WHERE  documentocausal.codtiponovedad = '" + dkda.o(sel, "codtiponovedad") + "' "
                    + "       AND documentocausal.novcaucodigo = '" + dkda.o(sel, "novcaucodigo") + "' "
                    + "       AND documentocausal.codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "' ";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

//            info += "combo|#novedadcausal_documentocausal_1|" + rs.getString("documentocausal_codtiponovedad")
//                    + "|llenarCombo('novedadcausal_documentocausal_1', '" + rs.getString("documentocausal_codtiponovedad")
//                    + "', '" + rs.getString("novedadcausal_novcaudescri") + "'):_";
            
            info += "combo|#novedadcausal_documentocausal_1|" + "novedadcausal codtiponovedad  " + rs.getString("novedadcausal_codtiponovedad") + "  "
                    + " codempresa  " + rs.getString("empresa_codempresa") + "|llenarCombo('novedadcausal_documentocausal_1', '"
                    + "novedadcausal   codtipoidentidad  " + rs.getString("empresa_codtipoidentidad") + "   codempresa  "
                    + rs.getString("empresa_codempresa") + "', '" + rs.getString("novedadcausal_novcaudescri") + "'):_";

            info += "combo|#codtipodctoasociado_documentocausal|" + rs.getString("documentocausal_codtipodctoasociado")
                    + "|llenarCombo('codtipodctoasociado_documentocausal', '" + rs.getString("documentocausal_codtipodctoasociado")
                    + "', '" + rs.getString("tipodctoasociado_descripcion") + "'):_";

            info += "text|#doccauobserv_documentocausal|"
                    + (rs.getString("documentocausal_doccauobserv") == null ? ""
                    : rs.getString("documentocausal_doccauobserv")) + ":_";


            respuesta = "opcion=obtener_documentocausal&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_documentocausal&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error documentocausal - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_documentocausal() {
        String direccion = "opcion=registrar_documentocausal&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = existe_documentocausal();

        System.out.println("novcaucodigo => " + dkda.o(novedadcausal_documentocausal_1, "novcaucodigo"));
        System.out.println("codtiponovedad => " + dkda.o(novedadcausal_documentocausal_1, "codtiponovedad"));
        System.out.println("******");

        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
           // if (!(dkda.o(sel, "codtiponovedad").toString().equals(dkda.o(novedadcausal_documentocausal_1, "codtiponovedad")) && dkda.o(sel, "novcaucodigo").toString().equals(dkda.o(novedadcausal_documentocausal_1, "novcaucodigo")) && dkda.o(sel, "codtipodctoasociado").toString().equals(dkda.o(vars, "codtipodctoasociado_documentocausal"))) && existe == true) {
            if (! (dkda.o(sel, "codtiponovedad").toString().equals(dkda.o(vars, "codtiponovedad_documentocausal")) && dkda.o(sel, "novcaucodigo").toString().equals(dkda.o(vars, "novcaucodigo_documentocausal")) && dkda.o(sel, "codtipodctoasociado").toString().equals(dkda.o(vars, "codtipodctoasociado_documentocausal")) ) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
                System.out.println(dkda.o(sel, "codtiponovedad").toString() + " |  " + dkda.o(novedadcausal_documentocausal_1, "codtiponovedad"));
                System.out.println(dkda.o(sel, "novcaucodigo") + " | " + dkda.o(novedadcausal_documentocausal_1, "novcaucodigo"));
                System.out.println(dkda.o(sel, "codtipodctoasociado") + " | " + dkda.o(vars, "codtipodctoasociado_documentocausal"));
                System.out.println("******");    
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        System.out.println("valor ====> " + dkda.o(vars, "novedadcausal_documentocausal_1"));
        if (dkda.o(vars, "novedadcausal_documentocausal_1").isEmpty()) {
            error = "Causal Novedad: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipodctoasociado_documentocausal").isEmpty()) {
            error = "Tipo Documento Asociado: no puede ser vacio.";
        } else if (dkda.o(vars, "doccauobserv_documentocausal").isEmpty()) {
            error = "Observaciones Causal Documentos: no puede ser vacio.";
        } else if (dkda.o(vars, "doccauobserv_documentocausal").length() > 400) {
            error = "Observaciones Causal Documentos: Valor demasiado Largo.";
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

    private boolean existe_documentocausal() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            System.out.println("SELECT COUNT(*) FROM documentocausal  WHERE codtiponovedad = '" + dkda.o(sel, "codtiponovedad") + "'" + " AND novcaucodigo = '" + dkda.o(sel, "novcaucodigo") + "'" + " AND codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "'");
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM documentocausal  WHERE codtiponovedad = '" + dkda.o(sel, "codtiponovedad") + "'" + " AND novcaucodigo = '" + dkda.o(sel, "novcaucodigo") + "'" + " AND codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_documentocausal() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }
}