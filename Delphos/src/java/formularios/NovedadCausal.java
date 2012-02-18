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

public class NovedadCausal extends HttpServlet {

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
            String respuesta = validarFormulario_novedadcausal();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_novedadcausal(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_novedadcausal(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_novedadcausal(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_novedadcausal(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_novedadcausal(ConexionBaseDatos con) {
        System.out.println("registrar_novedadcausal");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO novedadcausal (codtiponovedad,novcaucodigo,novcaudescri,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "codtiponovedad_novedadcausal").equals("") ? null : "'" + dkda.o(vars, "codtiponovedad_novedadcausal") + "'") + "," + (dkda.o(vars, "novcaucodigo_novedadcausal").equals("") ? null : "'" + dkda.o(vars, "novcaucodigo_novedadcausal") + "'") + "," + (dkda.o(vars, "novcaudescri_novedadcausal").equals("") ? null : "'" + dkda.o(vars, "novcaudescri_novedadcausal") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_novedadcausal&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_novedadcausal&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error novedadcausal.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_novedadcausal(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE novedadcausal SET codtiponovedad = " + (dkda.o(vars, "codtiponovedad_novedadcausal").equals("") ? null : "'" + dkda.o(vars, "codtiponovedad_novedadcausal") + "'") + ",novcaucodigo = " + (dkda.o(vars, "novcaucodigo_novedadcausal").equals("") ? null : "'" + dkda.o(vars, "novcaucodigo_novedadcausal") + "'") + ",novcaudescri = " + (dkda.o(vars, "novcaudescri_novedadcausal").equals("") ? null : "'" + dkda.o(vars, "novcaudescri_novedadcausal") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codtiponovedad = '" + dkda.o(sel, "codtiponovedad") + "' AND novcaucodigo = '" + dkda.o(sel, "novcaucodigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_novedadcausal&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_novedadcausal&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error novedadcausal.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_novedadcausal(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM novedadcausal WHERE codtiponovedad = '" + dkda.o(sel, "codtiponovedad") + "' AND novcaucodigo = '" + dkda.o(sel, "novcaucodigo") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_novedadcausal&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_novedadcausal&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error novedadcausal.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_novedadcausal(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener:  " + codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "     novedadcausal.codtiponovedad AS novedadcausal_codtiponovedad,"
                    + "     novedadcausal.novcaucodigo AS novedadcausal_novcaucodigo,"
                    + "     novedadcausal.novcaudescri AS novedadcausal_novcaudescri,"
                    + "     novedadcausal.ususiscodigo AS novedadcausal_ususiscodigo,"
                    + "     novedadcausal.fecharegistro AS novedadcausal_fecharegistro,"
                    + "     tiponovedad.codtiponovedad AS tiponovedad_codtiponovedad,"
                    + "     tiponovedad.descripcion AS tiponovedad_descripcion"
                    + " FROM "
                    + "     public.tiponovedad tiponovedad INNER JOIN public.novedadcausal novedadcausal ON tiponovedad.codtiponovedad = novedadcausal.codtiponovedad"
                    + "  WHERE novedadcausal.codtiponovedad = '" + dkda.o(sel, "codtiponovedad") + "'"
                    + " AND novedadcausal.novcaucodigo = '" + dkda.o(sel, "novcaucodigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "combo|#codtiponovedad_novedadcausal|" + rs.getString("novedadcausal_codtiponovedad")
                    + "|llenarCombo('codtiponovedad_novedadcausal', '" + rs.getString("novedadcausal_codtiponovedad")
                    + "', '" + rs.getString("tiponovedad_descripcion") + "'):_";

            info += "text|#novcaucodigo_novedadcausal|"
                    + (rs.getString("novedadcausal_novcaucodigo") == null ? ""
                    : rs.getString("novedadcausal_novcaucodigo")) + ":_";

            info += "text|#novcaudescri_novedadcausal|"
                    + (rs.getString("novedadcausal_novcaudescri") == null ? ""
                    : rs.getString("novedadcausal_novcaudescri")) + ":_";


            respuesta = "opcion=obtener_novedadcausal&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_novedadcausal&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error NovedadCausal - Obtener.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return respuesta;

    }

    public boolean existe_novedadcausal() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM novedadcausal  WHERE codtiponovedad = '" + dkda.o(vars, "codtiponovedad_novedadcausal") + "' "
                    + "AND novcaucodigo = '" + dkda.o(vars, "novcaucodigo_novedadcausal") + "' ";
            pQuery = conexion.prepareStatement(sql);
            System.out.println(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();

        } catch (SQLException e) {
            System.err.println("( existe_novedadCausal() ) Error al consultar los campos de la tabla: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_novedadcausal() {
        String direccion = "opcion=registrar_novedadcausal&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_novedadcausal();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codtiponovedad").toString().equals(dkda.o(vars, "codtiponovedad_novedadcausal")) && 
                    dkda.o(sel, "novcaucodigo").toString().equals(dkda.o(vars, "novcaucodigo_novedadcausal"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codtiponovedad_novedadcausal").isEmpty()) {
            error = "Codigo del tipo de novedad: no puede ser vacio.";
        } else if (dkda.o(vars, "novcaucodigo_novedadcausal").isEmpty()) {
            error = "Código Causal Novedad: no puede ser vacio.";
        } else if (dkda.o(vars, "novcaudescri_novedadcausal").isEmpty()) {
            error = "Descripción Causa Novedad: no puede ser vacio.";
        } else if (dkda.o(vars, "novcaucodigo_novedadcausal").length() > 3) {
            error = "Código Causal Novedad: Valor demasiado Largo.";
        } else if (dkda.o(vars, "novcaudescri_novedadcausal").length() > 70) {
            error = "Descripción Causa Novedad: Valor demasiado Largo.";
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