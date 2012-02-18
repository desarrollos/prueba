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
import clases.ed_ValidacionCampos;
import java.sql.*;
import java.net.URLDecoder;

/**
 *
 * @author Sebas
 */
public class QuejaClasificacion extends HttpServlet {

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
            String respuesta = validarFormulario_quejaClasificacion();

            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_quejaClasificacion(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_quejaClasificacion(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_quejaClasificacion(con));
                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_quejaClasificacion(ConexionBaseDatos con) {

        System.out.println("REGISGRANDO quejaClasificacion");
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO quejaclasificacion (tipquecodigo, queclacodigo, quecladescri, queclaobserv, ususiscodigo, fecharegistro)"
                    + " VALUES (" + (dkda.o(vars, "tipquecodigo_quejaClasificacion").equals("") ? null : "'"
                    + dkda.o(vars, "tipquecodigo_quejaClasificacion") + "'") + ","
                    + (dkda.o(vars, "queclacodigo_quejaClasificacion").equals("") ? null : "'"
                    + dkda.o(vars, "queclacodigo_quejaClasificacion") + "'") + ","
                    + (dkda.o(vars, "quecladescri_quejaClasificacion").equals("") ? null : "'"
                    + dkda.o(vars, "quecladescri_quejaClasificacion") + "'") + ","
                    + (dkda.o(vars, "queclaobserv_quejaClasificacion").equals("") ? null : "'"
                    + dkda.o(vars, "queclaobserv_quejaClasificacion") + "'") + ","
                    + (dkda.o(vars, "ususiscodigo_quejaClasificacion").equals("") ? "'DELPHOS'" : "'"
                    + dkda.o(vars, "ususiscodigo_quejaClasificacion") + "'") + ","
                    + (dkda.o(vars, "fecharegistro_quejaClasificacion").equals("") ? "NOW()::date" : "'"
                    + dkda.o(vars, "fecharegistro_quejaClasificacion") + "'") + ")";



            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_quejaClasificacion&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_quejaClasificacion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error TipoEntidadSalud.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_quejaClasificacion(ConexionBaseDatos con, String codigo) {
        System.out.println("CODIGO 1: " + dkda.o(selCampos, "tipquecodigo"));
        System.out.println("cdogio 2: " + dkda.o(selCampos, "queclacodigo"));

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql =
                    "SELECT "
                    + "quejaclasificacion.tipquecodigo AS quejaclasificacion_tipquecodigo,"
                    + "quejaclasificacion.queclacodigo AS quejaclasificacion_queclacodigo,"
                    + "quejaclasificacion.quecladescri AS quejaclasificacion_quecladescri,"
                    + "quejaclasificacion.queclaobserv AS quejaclasificacion_queclaobserv,"
                    + "quejaclasificacion.ususiscodigo AS quejaclasificacion_ususiscodigo,"
                    + "quejaclasificacion.fecharegistro AS quejaclasificacion_fecharegistro,"
                    + "tipoqueja.tipquecodigo AS tipoqueja_tipquecodigo,"
                    + "tipoqueja.tipquedescri AS tipoqueja_tipquedescri,"
                    + "tipoqueja.tipqueobserv AS tipoqueja_tipqueobserv,"
                    + "tipoqueja.ususiscodigo AS tipoqueja_ususiscodigo,"
                    + "tipoqueja.fecharegistro AS tipoqueja_fecharegistro"
                    + " FROM public.tipoqueja tipoqueja INNER JOIN public.quejaclasificacion quejaclasificacion ON tipoqueja.tipquecodigo = quejaclasificacion.tipquecodigo"
                    + " WHERE quejaclasificacion.tipquecodigo = '" + dkda.o(selCampos, "tipquecodigo") + "' AND "
                    + "quejaclasificacion.queclacodigo = '" + dkda.o(selCampos, "queclacodigo") + "'";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "combo|#tipquecodigo_quejaClasificacion|"
                    + rs.getString("tipoqueja_tipquecodigo") + "|llenarCombo('tipquecodigo_quejaClasificacion', '"
                    + rs.getString("tipoqueja_tipquecodigo") + "', '" + rs.getString("tipoqueja_tipquedescri") + "'):_";


            info += "text|#queclacodigo_quejaClasificacion|"
                    + (rs.getString("quejaclasificacion_queclacodigo") == null ? ""
                    : rs.getString("quejaclasificacion_queclacodigo")) + ":_";

            info += "text|#quecladescri_quejaClasificacion|"
                    + (rs.getString("quejaclasificacion_quecladescri") == null ? ""
                    : rs.getString("quejaclasificacion_quecladescri")) + ":_";

            info += "text|#queclaobserv_Quejaclasificacion|"
                    + (rs.getString("quejaclasificacion_queclaobserv") == null ? ""
                    : rs.getString("quejaclasificacion_queclaobserv")) + ":_";






//

            respuesta = "opcion=obtener_quejaClasificacion&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_quejaClasificacion&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error Entidad - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_quejaClasificacion(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE quejaclasificacion SET tipquecodigo = "
                    + (dkda.o(vars, "tipquecodigo_quejaClasificacion").equals("") ? null : "'"
                    + dkda.o(vars, "tipquecodigo_quejaClasificacion") + "'") + ",  quecladescri = "
                    + (dkda.o(vars, "quecladescri_quejaClasificacion").equals("") ? null : "'"
                    + dkda.o(vars, "quecladescri_quejaClasificacion") + "'") + ", queclaobserv = "
                    + (dkda.o(vars, "queclaobserv_quejaClasificacion").equals("") ? null : "'"
                    + dkda.o(vars, "queclaobserv_quejaClasificacion") + "'") + ", ususiscodigo = "
                    + (dkda.o(vars, "ususiscodigo_quejaClasificacion").equals("") ? "'DELPHOS'" : "'"
                    + dkda.o(vars, "ususiscodigo_quejaClasificacion") + "'") + ", fecharegistro = "
                    + (dkda.o(vars, "fecharegistro_quejaClasificacion").equals("") ? "NOW()::date" : "'"
                    + dkda.o(vars, "fecharegistro_quejaClasificacion") + "'") + " WHERE quejaclasificacion.tipquecodigo = '" + dkda.o(selCampos, "tipquecodigo") + "' AND "
                    + "quejaclasificacion.queclacodigo = '" + dkda.o(selCampos, "queclacodigo") + "'";

            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_quejaClasificacion&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_quejaClasificacion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Entidad.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String validarFormulario_quejaClasificacion() {
        String direccion = "opcion=registrar_usuarios&&estado=no&&error=si&&errorDes=";
        String error = "";

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
}
