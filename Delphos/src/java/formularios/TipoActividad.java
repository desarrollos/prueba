/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
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

/**
 *
 * @author Sebas
 */
public class TipoActividad extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;

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
        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_tipoActividad();
            
            System.out.println( "respuesta" + respuesta );
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_tipoActividad(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_tipoActividad(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_tipoActividad(con));
                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_tipoActividad(ConexionBaseDatos con) {

        System.out.println("REGISGRANDO tipoActividad");
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO tipoactividad (codtipoactividad, descripcion, observacion, ususiscodigo, fecharegistro) "
                    + "VALUES (" + (dkda.o(vars, "codtipoactividad_tipoActividad").equals("") ? null : "'"
                    + dkda.o(vars, "codtipoactividad_tipoActividad") + "'") + ","
                    + (dkda.o(vars, "descripcion_tipoActividad").equals("") ? null : "'"
                    + dkda.o(vars, "descripcion_tipoActividad") + "'") + ","
                    + (dkda.o(vars, "observacion_tipoActividad").equals("") ? null : "'"
                    + dkda.o(vars, "observacion_tipoActividad") + "'") + ","
                    + (dkda.o(vars, "ususiscodigo_tipoActividad").equals("") ? "'DELPHOS'" : "'"
                    + dkda.o(vars, "ususiscodigo_tipoActividad") + "'") + ","
                    + (dkda.o(vars, "fecharegistro_tipoActividad").equals("") ? "NOW()::date" : "'"
                    + dkda.o(vars, "fecharegistro_tipoActividad") + "'") + ")";



            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_tipoActividad&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_tipoActividad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error TipoEntidadSalud.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_tipoActividad(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener:  " + codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "tipoactividad.codtipoactividad AS tipoactividad_codtipoactividad,"
                    + "tipoactividad.descripcion AS tipoactividad_descripcion,"
                    + "tipoactividad.observacion AS tipoactividad_observacion,"
                    + "tipoactividad.ususiscodigo AS tipoactividad_ususiscodigo,"
                    + "tipoactividad.fecharegistro AS tipoactividad_fecharegistro"
                    + " FROM public.tipoactividad tipoactividad WHERE codtipoactividad = '" + codigo + "'";


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#codtipoactividad_tipoActividad|"
                    + (rs.getString("tipoactividad_codtipoactividad") == null ? ""
                    : rs.getString("tipoactividad_codtipoactividad")) + ":_";

            info += "text|#descripcion_tipoActividad|"
                    + (rs.getString("tipoactividad_descripcion") == null ? ""
                    : rs.getString("tipoactividad_descripcion")) + ":_";

            info += "text|#observacion_tipoActividad|"
                    + (rs.getString("tipoactividad_observacion") == null ? ""
                    : rs.getString("tipoactividad_observacion")) + ":_";
//

            respuesta = "opcion=obtener_tipoActividad&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_tipoActividad&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error Entidad - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_tipoActividad(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE tipoactividad SET descripcion = "
                    + (dkda.o(vars, "descripcion_tipoActividad").equals("") ? null : "'"
                    + dkda.o(vars, "descripcion_tipoActividad") + "'") + ", observacion = "
                    + (dkda.o(vars, "observacion_tipoActividad").equals("") ? null : "'"
                    + dkda.o(vars, "observacion_tipoActividad") + "'") + ", ususiscodigo = "
                    + (dkda.o(vars, "ususiscodigo_tipoActividad").equals("") ? "'DELPHOS'" : "'"
                    + dkda.o(vars, "ususiscodigo_tipoActividad") + "'") + ", fecharegistro = "
                    + (dkda.o(vars, "fecharegistro_tipoActividad").equals("") ? "NOW()::date" : "'"
                    + dkda.o(vars, "fecharegistro_tipoActividad") + "'") + " WHERE codtipoactividad =  '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_tipoActividad&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_tipoActividad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Entidad.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String validarFormulario_tipoActividad() {
        String direccion = "opcion=registrar_usuarios&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = existe_tipoActividad();

        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "codtipoactividad_tipoActividad"))) && existe == true) {
                error = "Ya existe un Tipo de Actividad con estos datos. Verifiquelos por favor";
            }
        } else {
            error = (existe) ? "Ya existe un Tipo de Actividad con estos datos. Verifiquelos por favor" : "";
        }

         /*** Inicio Validar Vacio */
        if (dkda.o(vars, "codtipoactividad_tipoActividad").isEmpty()) {
            error = "Código Tipo Actividad: Debe tener un Codigo.";
        } else if (dkda.o(vars, "descripcion_tipoActividad").isEmpty()) {
            error = "Descripción: No puede estar vacia.";
        }
        /*** Inicio Validar Tipo Dato */
        else if (!v.alfaNumericos(dkda.o(vars, "codtipoactividad_tipoActividad"))) {
            error = "Código Tipo Actividad: tiene caracteres no permitidos.";
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

    public boolean existe_tipoActividad() {
        // UT004 - ESS207 - CCF045
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {                                                                            //
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM tipoactividad  WHERE codtipoactividad  ='" + dkda.o(vars, "codtipoactividad_tipoActividad") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            System.out.println("existe_tipoActividad() => " + rQuery.getInt(1));
            pQuery.close();
            rQuery.close();

        } catch (SQLException e) {
            System.err.println("( existe_tipoActividad() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));

        }
        return existe;
    }
}
