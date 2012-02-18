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
public class TipoQueja extends HttpServlet {

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
            String respuesta = validarFormulario_tipoQueja();

            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_tipoQueja(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_tipoQueja(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_tipoQueja(con));
                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_tipoQueja(ConexionBaseDatos con) {

        System.out.println("REGISGRANDO tipoActividad");
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "  INSERT INTO tipoqueja (tipquecodigo, tipquedescri, tipqueobserv, ususiscodigo, fecharegistro) "
                    + "VALUES (" + (dkda.o(vars, "tipquecodigo_tipoQueja").equals("") ? null : "'"
                    + dkda.o(vars, "tipquecodigo_tipoQueja") + "'") + ","
                    + (dkda.o(vars, "tipquedescri_tipoQueja").equals("") ? null : "'"
                    + dkda.o(vars, "tipquedescri_tipoQueja") + "'") + ","
                    + (dkda.o(vars, "tipqueobserv_tipoQueja").equals("") ? null : "'"
                    + dkda.o(vars, "tipqueobserv_tipoQueja") + "'") + ","
                    + (dkda.o(vars, "ususiscodigo_tipoQueja").equals("") ? "'DELPHOS'" : "'"
                    + dkda.o(vars, "ususiscodigo_tipoQueja") + "'") + ","
                    + (dkda.o(vars, "fecharegistro_tipoQueja").equals("") ? "NOW()::date" : "'"
                    + dkda.o(vars, "fecharegistro_tipoQueja") + "'") + ")";



            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_tipoQueja&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_tipoQueja&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error TipoEntidadSalud.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_tipoQueja(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener:  " + codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "tipoqueja.tipquecodigo AS tipoqueja_tipquecodigo,"
                    + "tipoqueja.tipquedescri AS tipoqueja_tipquedescri,"
                    + "tipoqueja.tipqueobserv AS tipoqueja_tipqueobserv,"
                    + "tipoqueja.ususiscodigo AS tipoqueja_ususiscodigo,"
                    + "tipoqueja.fecharegistro AS tipoqueja_fecharegistro"
                    + " FROM public.tipoqueja tipoqueja  WHERE tipquecodigo = '" + codigo + "'";


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#tipquecodigo_tipoQueja|"
                    + (rs.getString("tipoqueja_tipquecodigo") == null ? ""
                    : rs.getString("tipoqueja_tipquecodigo")) + ":_";

            info += "text|#tipquedescri_tipoQueja|"
                    + (rs.getString("tipoqueja_tipquedescri") == null ? ""
                    : rs.getString("tipoqueja_tipquedescri")) + ":_";

            info += "text|#tipqueobserv_tipoQueja|"
                    + (rs.getString("tipoqueja_tipqueobserv") == null ? ""
                    : rs.getString("tipoqueja_tipqueobserv")) + ":_";
//

            respuesta = "opcion=obtener_tipoQueja&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_tipoQueja&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error Entidad - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_tipoQueja(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE tipoqueja SET tipquedescri = "
                    + (dkda.o(vars, "tipquedescri_tipoQueja").equals("") ? null : "'"
                    + dkda.o(vars, "tipquedescri_tipoQueja") + "'") + ", tipqueobserv = "
                    + (dkda.o(vars, "tipqueobserv_tipoQueja").equals("") ? null : "'"
                    + dkda.o(vars, "tipqueobserv_tipoQueja") + "'") + ", ususiscodigo = "
                    + (dkda.o(vars, "ususiscodigo_tipoQueja").equals("") ? null : "'"
                    + dkda.o(vars, "ususiscodigo_tipoQueja") + "'") + ", fecharegistro = "
                    + (dkda.o(vars, "fecharegistro_tipoQueja").equals("") ? null : "'"
                    + dkda.o(vars, "fecharegistro_tipoQueja") + "'") + " WHERE tipquecodigo =  '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_tipoQueja&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_tipoQueja&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Entidad.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String validarFormulario_tipoQueja() {
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
