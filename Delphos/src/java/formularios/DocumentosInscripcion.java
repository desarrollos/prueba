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

public class DocumentosInscripcion extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap selCampos = null;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");



        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();


        selCampos = fun.map(dkda.o(vars, "codigo").toString());

        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_documentosInscripcion();
            System.out.println("Opcion!!! :  |" + dkda.o(vars, "accion").toString());
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_documentosInscripcion(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_documentosInscripcion(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_documentosInscripcion(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_documentosInscripcion(dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_documentosInscripcion(ConexionBaseDatos con) {

        System.out.println("registrar_documentosInscripcion");
        con.abrirConexion();
        //
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO documentocausal (codtiponovedad, novcaucodigo, codtipodctoasociado, doccauobserv, ususiscodigo, fecharegistro) VALUES (" + (dkda.o(vars, "codtiponovedad_documentosInscripcion").equals("") ? null : "'" + dkda.o(vars, "codtiponovedad_documentosInscripcion") + "'") + "," + (dkda.o(vars, "novcaucodigo_documentosInscripcion").equals("") ? null : "'" + dkda.o(vars, "novcaucodigo_documentosInscripcion") + "'") + "," + (dkda.o(vars, "codtipodctoasociado_documentosInscripcion").equals("") ? null : "'" + dkda.o(vars, "codtipodctoasociado_documentosInscripcion") + "'") + "," + (dkda.o(vars, "doccauobserv_documentosInscripcion").equals("") ? null : "'" + dkda.o(vars, "doccauobserv_documentosInscripcion") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";

            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_documentosInscripcion&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_documentosInscripcion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error TipoEntidadSalud.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_documentosInscripcion(ConexionBaseDatos con, String codigo) {

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "     documentocausal.codtiponovedad AS documentocausal_codtiponovedad,"
                    + "     documentocausal.novcaucodigo AS documentocausal_novcaucodigo,"
                    + "     documentocausal.codtipodctoasociado AS documentocausal_codtipodctoasociado,"
                    + "     documentocausal.doccauobserv AS documentocausal_doccauobserv,"
                    + "     documentocausal.ususiscodigo AS documentocausal_ususiscodigo,     "
                    + "     documentocausal.fecharegistro AS documentocausal_fecharegistro,"
                    + "     novedadcausal.novcaudescri AS novedadcausal_novcaudescri,"
                    + "     tipodctoasociado.descripcion AS tipodctoasociado_descripcion,"
                    + "     tiponovedad.descripcion AS tiponovedad_descripcion "
                    + " FROM "
                    + " public.tipodctoasociado tipodctoasociado INNER JOIN public.documentocausal documentocausal ON tipodctoasociado.codtipodctoasociado = documentocausal.codtipodctoasociado"
                    + "     INNER JOIN public.novedadcausal novedadcausal ON documentocausal.codtiponovedad = novedadcausal.codtiponovedad      AND novedadcausal.novcaucodigo = documentocausal.novcaucodigo"
                    + "     INNER JOIN public.tiponovedad tiponovedad ON novedadcausal.codtiponovedad = tiponovedad.codtiponovedad "
                    + " WHERE "
                    + "	documentocausal.codtiponovedad = '" + dkda.o(selCampos, "codtiponovedad") + "' AND documentocausal.novcaucodigo='" + dkda.o(selCampos, "novcaucodigo") + "' AND documentocausal.codtipodctoasociado='" + dkda.o(selCampos, "codtipodctoasociado") + "'";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "combo|#codtiponovedad_documentosInscripcion|" + rs.getString("documentocausal_codtiponovedad")
                    + "|llenarCombo('codtiponovedad_documentosInscripcion', '" + rs.getString("documentocausal_codtiponovedad")
                    + "', '" + rs.getString("tiponovedad_descripcion") + "'):_";

            info += "combo|#novcaucodigo_documentosInscripcion|" + rs.getString("documentocausal_novcaucodigo")
                    + "|llenarCombo('novcaucodigo_documentosInscripcion', '" + rs.getString("documentocausal_novcaucodigo")
                    + "', '" + rs.getString("novedadcausal_novcaudescri") + "'):_";

            info += "combo|#codtipodctoasociado_documentosInscripcion|" + rs.getString("documentocausal_codtipodctoasociado")
                    + "|llenarCombo('codtipodctoasociado_documentosInscripcion', '" + rs.getString("documentocausal_codtipodctoasociado")
                    + "', '" + rs.getString("tipodctoasociado_descripcion") + "'):_";

            info += "text|#doccauobserv_documentosInscripcion|"
                    + (rs.getString("documentocausal_doccauobserv") == null ? ""
                    : rs.getString("documentocausal_doccauobserv")) + ":_";

            respuesta = "opcion=obtener_documentosInscripcion&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_documentosInscripcion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("obtener_documentosInscripcion() " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return respuesta;

    }

    public String actualizar_documentosInscripcion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;

            System.out.println("Codigo " + dkda.o(vars, "codigo"));

            String sql = "UPDATE documentocausal SET codtiponovedad = " + (dkda.o(vars, "codtiponovedad_documentosInscripcion").equals("") ? null : "'" + dkda.o(vars, "codtiponovedad_documentosInscripcion") + "'") + ", novcaucodigo = " + (dkda.o(vars, "novcaucodigo_documentosInscripcion").equals("") ? null : "'" + dkda.o(vars, "novcaucodigo_documentosInscripcion") + "'") + ", codtipodctoasociado = " + (dkda.o(vars, "codtipodctoasociado_documentosInscripcion").equals("") ? null : "'" + dkda.o(vars, "codtipodctoasociado_documentosInscripcion") + "'") + ", doccauobserv = " + (dkda.o(vars, "doccauobserv_documentosInscripcion").equals("") ? null : "'" + dkda.o(vars, "doccauobserv_documentosInscripcion") + "'") + ", ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ", fecharegistro = " + "NOW()::date" + ""
                    + " WHERE "
                    + "	codtiponovedad = '" + dkda.o(selCampos, "codtiponovedad") + "' AND novcaucodigo='" + dkda.o(selCampos, "novcaucodigo") + "' AND codtipodctoasociado='" + dkda.o(selCampos, "codtipodctoasociado") + "'";

            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_documentosInscripcion&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_documentosInscripcion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error Entidad.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String eliminar_documentosInscripcion(String codigo) {

        String[] codigos = codigo.split(",");
        String nuevosCodigos = "";
        for (int n = 0; n < codigos.length; n++) {
            nuevosCodigos += "'" + codigos[n] + "',";
        }

        System.out.println("Eliminar " + "DELETE FROM novedadcausal WHERE novcaucodigo IN(" + nuevosCodigos.substring(0, nuevosCodigos.length() - 1) + ")");
        //System.out.println("eliminar_documentosInscripcion " + dkda.o(vars, "codigo"));
        Connection conexion = bdS.getConexion();
        //
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "DELETE FROM clasegrupotitular WHERE  codclagrutit='" + dkda.o(vars, "codigo").toString() + "'";
            stmt = conexion.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=eliminar_documentosInscripcion&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=eliminar_documentosInscripcion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error TipoEntidadSalud.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }


        return respuesta;

    }

    public String validarFormulario_documentosInscripcion() {
        String direccion = "opcion=registrar_documentosInscripcion&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = existe_documentoInscripcion();

        System.out.println("ExistE? " + existe);
        
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(selCampos, "codunifami").toString().equals(dkda.o(vars, "codunifami_documentoinscripcion")) && dkda.o(selCampos, "codtipodctoasociado").toString().equals(dkda.o(vars, "codtipodctoasociado_documentoinscripcion"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }

        if (dkda.o(vars, "codunifami_documentoinscripcion").isEmpty()) {
            error = "Código Único Familia: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipodctoasociado_documentoinscripcion").isEmpty()) {
            error = "Tipo Documento Asociado: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_documentoinscripcion").isEmpty()) {
            error = "Tipo Identificacion: no puede ser vacio.";
        } else if (dkda.o(vars, "idenperdoc_documentoinscripcion").isEmpty()) {
            error = "Numero Identificacion: no puede ser vacio.";
        } else if (dkda.o(vars, "archidocum_documentoinscripcion").isEmpty()) {
            error = "Archivo Documento: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "idenperdoc_documentoinscripcion"))) {
            error = "Numero Identificacion: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "codunifami_documentoinscripcion").length() > 15) {
            error = "Código Único Familia: Valor demasiado Largo.";
        } else if (dkda.o(vars, "codtipodctoasociado_documentoinscripcion").length() > 6) {
            error = "Tipo Documento Asociado: Valor demasiado Largo.";
        } else if (dkda.o(vars, "codtipoidentidad_documentoinscripcion").length() > 10) {
            error = "Tipo Identificacion: Valor demasiado Largo.";
        } else if (dkda.o(vars, "idenperdoc_documentoinscripcion").length() > 12) {
            error = "Numero Identificacion: Valor demasiado Largo.";
        } else if (dkda.o(vars, "descripcion_documentoinscripcion").length() > 100) {
            error = "Descripción: Valor demasiado Largo.";
        }



        respuesta = (error.length() > 1 ? direccion + "<strong>" + error + "</strong>" : "");

        return respuesta;
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private boolean existe_documentoInscripcion() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM documentoinscripcion  WHERE codunifami = '" + dkda.o(vars, "codunifami_documentoinscripcion") + "' AND codtipodctoasociado = '" + dkda.o(vars, "codtipodctoasociado_documentoinscripcion") + "'" ) ;
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_documentoinscripcion() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }
}
