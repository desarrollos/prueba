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
public class ReclamoClasificacion extends HttpServlet {

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
            String respuesta = validarFormulario_reclamoClasificacion();

            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_reclamoClasificacion(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_reclamoClasificacion(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_reclamoClasificacion(con));
                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_reclamoClasificacion(ConexionBaseDatos con) {

        System.out.println("REGISGRANDO reclamoClasificacion");
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO reclamoclasificacion (rectipcodigo, recclacodigo, reccladescri, recclaobserv, ususiscodigo, fecharegistro ) "
                    + "VALUES (" + (dkda.o(vars, "rectipcodigo_reclamoClasificacion").equals("") ? null : "'"
                    + dkda.o(vars, "rectipcodigo_reclamoClasificacion") + "'") + ","
                    + (dkda.o(vars, "recclacodigo_reclamoClasificacion").equals("") ? null : "'"
                    + dkda.o(vars, "recclacodigo_reclamoClasificacion") + "'") + ","
                    + (dkda.o(vars, "reccladescri_reclamoClasificacion").equals("") ? null : "'"
                    + dkda.o(vars, "reccladescri_reclamoClasificacion") + "'") + ","
                    + (dkda.o(vars, "recclaobserv_reclamoClasificacion").equals("") ? null : "'"
                    + dkda.o(vars, "recclaobserv_reclamoClasificacion") + "'") + ","
                    + (dkda.o(vars, "ususiscodigo_reclamoClasificacion").equals("") ? "'DELPHOS'" : "'"
                    + dkda.o(vars, "ususiscodigo_reclamoClasificacion") + "'") + ","
                    + (dkda.o(vars, "fecharegistro_reclamoClasificacion").equals("") ? "NOW()::date" : "'"
                    + dkda.o(vars, "fecharegistro_reclamoClasificacion") + "'") + ")";



            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_reclamoClasificacion&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_reclamoClasificacion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Reclamo Clasificacion.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_reclamoClasificacion(ConexionBaseDatos con, String codigo) {
        System.out.println("CODIGO 1: " + dkda.o(selCampos, "rectipcodigo"));
        System.out.println("cdogio 2: " + dkda.o(selCampos, "recclacodigo"));

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql =
                    "SELECT "
                    + "reclamoclasificacion.rectipcodigo AS reclamoclasificacion_rectipcodigo,"
                    + "reclamoclasificacion.recclacodigo AS reclamoclasificacion_recclacodigo,"
                    + "reclamoclasificacion.reccladescri AS reclamoclasificacion_reccladescri,"
                    + "reclamoclasificacion.recclaobserv AS reclamoclasificacion_recclaobserv,"
                    + "reclamoclasificacion.ususiscodigo AS reclamoclasificacion_ususiscodigo,"
                    + "reclamoclasificacion.fecharegistro AS reclamoclasificacion_fecharegistro,"
                    + "reclamotipo.rectipcodigo AS reclamotipo_rectipcodigo,"
                    + "reclamotipo.rectipdescri AS reclamotipo_rectipdescri,"
                    + "reclamotipo.rectipobserv AS reclamotipo_rectipobserv,"
                    + "reclamotipo.ususiscodigo AS reclamotipo_ususiscodigo,"
                    + "reclamotipo.fecharegistro AS reclamotipo_fecharegistro "
                    + " FROM "
                    + "public.reclamotipo reclamotipo INNER JOIN public.reclamoclasificacion reclamoclasificacion ON reclamotipo.rectipcodigo = reclamoclasificacion.rectipcodigo"
                    + " WHERE reclamoclasificacion.rectipcodigo = '" + dkda.o(selCampos, "rectipcodigo") + "' AND "
                    + "reclamoclasificacion.recclacodigo = '" + dkda.o(selCampos, "recclacodigo") + "'";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "combo|#rectipcodigo_reclamoClasificacion|"
                    + rs.getString("reclamotipo_rectipcodigo") + "|llenarCombo('rectipcodigo_reclamoClasificacion', '"
                    + rs.getString("reclamotipo_rectipcodigo") + "', '" + rs.getString("reclamotipo_rectipdescri") + "'):_";


            info += "text|#recclacodigo_reclamoClasificacion|"
                    + (rs.getString("reclamoclasificacion_recclacodigo") == null ? ""
                    : rs.getString("reclamoclasificacion_recclacodigo")) + ":_";

            info += "text|#reccladescri_reclamoClasificacion|"
                    + (rs.getString("reclamoclasificacion_reccladescri") == null ? ""
                    : rs.getString("reclamoclasificacion_reccladescri")) + ":_";

            info += "text|#recclaobserv_reclamoClasificacion|"
                    + (rs.getString("reclamoclasificacion_recclaobserv") == null ? ""
                    : rs.getString("reclamoclasificacion_recclaobserv")) + ":_";







//

            respuesta = "opcion=obtener_reclamoClasificacion&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_reclamoClasificacion&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error Entidad - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_reclamoClasificacion(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " UPDATE reclamoclasificacion SET reccladescri = "
                    + (dkda.o(vars, "reccladescri_reclamoClasificacion").equals("") ? null : "'"
                    + dkda.o(vars, "reccladescri_reclamoClasificacion") + "'") + ", recclaobserv = "
                    + (dkda.o(vars, "recclaobserv_reclamoClasificacion").equals("") ? null : "'"
                    + dkda.o(vars, "recclaobserv_reclamoClasificacion") + "'") + ", ususiscodigo = "
                    + "'" + fun.usuarioAutenticado(request) + "'"
                    + ", fecharegistro = " + "NOW()::date"
                    + " WHERE reclamoclasificacion.rectipcodigo = '" + dkda.o(selCampos, "rectipcodigo") + "' AND "
                    + "reclamoclasificacion.recclacodigo = '" + dkda.o(selCampos, "recclacodigo") + "'";




            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_reclamoClasificacion&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_reclamoClasificacion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Entidad.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String validarFormulario_reclamoClasificacion() {
        String direccion = "opcion=registrar_usuarios&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_reclamoClasificacion();
//        System.out.println("CODIGOO " +  dkda.o(vars, "codigo").toString() );
//        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
//            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "rectipcodigo_reclamoClasificacion"))) && existe == true) {
//                error = "Ya existe un Tipo de Actividad con estos datos. Verifiquelos por favor";
//            }
//        } else {
//            error = (existe) ? "Ya existe un Tipo de Actividad con estos datos. Verifiquelos por favor" : "";
//        }

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

    public boolean existe_reclamoClasificacion() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {                                                                            //
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM reclamoclasificacion  WHERE rectipcodigo  ='" + dkda.o(vars, "rectipcodigo_reclamoClasificacion") + "' AND recclacodigo='" + dkda.o(vars, "recclacodigo_reclamoClasificacion") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            System.out.println("existe_reclamoClasificacion() => " + rQuery.getInt(1));
            pQuery.close();
            rQuery.close();

        } catch (SQLException e) {
            System.err.println("( existe_reclamoClasificacion() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));

        }
        return existe;
    }
}
