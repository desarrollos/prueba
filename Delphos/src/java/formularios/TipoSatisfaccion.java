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
public class TipoSatisfaccion extends HttpServlet {

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
            String respuesta = validarFormulario_tipoSatisfaccion();

            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_tipoSatisfaccion(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_tipoSatisfaccion(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_tipoSatisfaccion(con));
                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_tipoSatisfaccion(ConexionBaseDatos con) {

        System.out.println("REGISGRANDO tipoSatisfaccion");
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "  INSERT INTO satisfacciontipo (tipsatcodigo, tipsatdescri, ususiscodigo, fecharegistro ) "
                    + "VALUES (" + (dkda.o(vars, "tipsatcodigo_tipoSatisfaccion").equals("") ? null : "'"
                    + dkda.o(vars, "tipsatcodigo_tipoSatisfaccion") + "'") + ","
                    + (dkda.o(vars, "tipsatdescri_tipoSatisfaccion").equals("") ? null : "'"
                    + dkda.o(vars, "tipsatdescri_tipoSatisfaccion") + "'") + ","
                    + (dkda.o(vars, "ususiscodigo_tipoSatisfaccion").equals("") ? "'DELPHOS'" : "'"
                    + dkda.o(vars, "ususiscodigo_tipoSatisfaccion") + "'") + ","
                    + (dkda.o(vars, "fecharegistro_tipoSatisfaccion").equals("") ? "NOW()::date" : "'"
                    + dkda.o(vars, "fecharegistro_tipoSatisfaccion") + "'") + ")";



            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_tipoSatisfaccion&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_tipoSatisfaccion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error TipoEntidadSalud.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_tipoSatisfaccion(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener:  " + codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " SELECT "
                    + "satisfacciontipo.tipsatcodigo AS satisfacciontipo_tipsatcodigo,"
                    + "satisfacciontipo.tipsatdescri AS satisfacciontipo_tipsatdescri,"
                    + "satisfacciontipo.ususiscodigo AS satisfacciontipo_ususiscodigo,"
                    + "satisfacciontipo.fecharegistro AS satisfacciontipo_fecharegistro"
                    + " FROM public.satisfacciontipo satisfacciontipo WHERE tipsatcodigo = '" + codigo + "'";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#tipsatcodigo_tipoSatisfaccion|"
                    + (rs.getString("satisfacciontipo_tipsatcodigo") == null ? ""
                    : rs.getString("satisfacciontipo_tipsatcodigo")) + ":_";

            info += "text|#tipsatdescri_tipoSatisfaccion|"
                    + (rs.getString("satisfacciontipo_tipsatdescri") == null ? ""
                    : rs.getString("satisfacciontipo_tipsatdescri")) + ":_";


//

            respuesta = "opcion=obtener_tipoSatisfaccion&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_tipoSatisfaccion&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error Entidad - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_tipoSatisfaccion(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE satisfacciontipo SET tipsatdescri = "
                    + (dkda.o(vars, "tipsatdescri_tipoSatisfaccion").equals("") ? null : "'"
                    + dkda.o(vars, "tipsatdescri_tipoSatisfaccion") + "'") + ", ususiscodigo = "
                    + (dkda.o(vars, "ususiscodigo_tipoSatisfaccion").equals("") ? "'DELPHOS'" : "'"
                    + dkda.o(vars, "ususiscodigo_tipoSatisfaccion") + "'") + ", fecharegistro = "
                    + (dkda.o(vars, "fecharegistro_tipoSatisfaccion").equals("") ? "NOW()::date" : "'"
                    + dkda.o(vars, "fecharegistro_tipoSatisfaccion") + "'")
                    + " WHERE tipsatcodigo =  '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_tipoSatisfaccion&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_tipoSatisfaccion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Entidad.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String validarFormulario_tipoSatisfaccion() {
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
