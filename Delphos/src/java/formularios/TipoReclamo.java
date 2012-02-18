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
public class TipoReclamo extends HttpServlet {

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
            String respuesta = validarFormulario_tipoReclamo();

            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_tipoReclamo(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_tipoReclamo(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_tipoReclamo(con));
                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_tipoReclamo(ConexionBaseDatos con) {

        System.out.println("REGISGRANDO tipoReclamo");
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO reclamotipo (rectipcodigo, rectipdescri, rectipobserv, ususiscodigo, fecharegistro) "
                    + "VALUES (" + (dkda.o(vars, "rectipcodigo_tipoReclamo").equals("") ? null : "'"
                    + dkda.o(vars, "rectipcodigo_tipoReclamo") + "'") + ","
                    + (dkda.o(vars, "rectipdescri_tipoReclamo").equals("") ? null : "'"
                    + dkda.o(vars, "rectipdescri_tipoReclamo") + "'") + ","
                    + (dkda.o(vars, "rectipobserv_tipoReclamo").equals("") ? null : "'"
                    + dkda.o(vars, "rectipobserv_tipoReclamo") + "'") + ","
                    + (dkda.o(vars, "ususiscodigo_tipoReclamo").equals("") ? "'DELPHOS'" : "'"
                    + dkda.o(vars, "ususiscodigo_tipoReclamo") + "'") + ","
                    + (dkda.o(vars, "fecharegistro_tipoReclamo").equals("") ? "NOW()::date" : "'"
                    + dkda.o(vars, "fecharegistro_tipoReclamo") + "'") + ")";




            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_tipoReclamo&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_tipoReclamo&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error TipoEntidadSalud.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_tipoReclamo(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener:  " + codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql =
                    "SELECT "
                    + "reclamotipo.rectipcodigo AS reclamotipo_rectipcodigo,"
                    + "reclamotipo.rectipdescri AS reclamotipo_rectipdescri,"
                    + "reclamotipo.rectipobserv AS reclamotipo_rectipobserv,"
                    + "reclamotipo.ususiscodigo AS reclamotipo_ususiscodigo,"
                    + "reclamotipo.fecharegistro AS reclamotipo_fecharegistro"
                    + " FROM "
                    + "public.reclamotipo   reclamotipo WHERE rectipcodigo = '" + codigo + "'";



            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#rectipcodigo_tipoReclamo|"
                    + (rs.getString("reclamotipo_rectipcodigo") == null ? ""
                    : rs.getString("reclamotipo_rectipcodigo")) + ":_";

            info += "text|#rectipdescri_tipoReclamo|"
                    + (rs.getString("reclamotipo_rectipdescri") == null ? ""
                    : rs.getString("reclamotipo_rectipdescri")) + ":_";

            info += "text|#rectipobserv_tipoReclamo|"
                    + (rs.getString("reclamotipo_rectipobserv") == null ? ""
                    : rs.getString("reclamotipo_rectipobserv")) + ":_";
//

            respuesta = "opcion=obtener_tipoReclamo&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_tipoReclamo&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error Entidad - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_tipoReclamo(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE reclamotipo SET  rectipdescri = "
                    + (dkda.o(vars, "rectipdescri_tipoReclamo").equals("") ? null : "'"
                    + dkda.o(vars, "rectipdescri_tipoReclamo") + "'") + ", rectipobserv = "
                    + (dkda.o(vars, "rectipobserv_tipoReclamo").equals("") ? null : "'"
                    + dkda.o(vars, "rectipobserv_tipoReclamo") + "'") + ", ususiscodigo = "
                    + (dkda.o(vars, "ususiscodigo_tipoReclamo").equals("") ? "'DELPHOS'" : "'"
                    + dkda.o(vars, "ususiscodigo_tipoReclamo") + "'") + ", fecharegistro = "
                    + (dkda.o(vars, "fecharegistro_tipoReclamo").equals("") ? "NOW()::date" : "'"
                    + dkda.o(vars, "fecharegistro_tipoReclamo") + "'") + " WHERE rectipcodigo =  '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_tipoReclamo&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_tipoReclamo&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Entidad.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String validarFormulario_tipoReclamo() {
        String direccion = "opcion=registrar_tipoReclamo&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = existe_tipoReclamo();

        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "rectipcodigo_tipoReclamo"))) && existe == true) {
                error = "Código Tipo Reclamo: Ya existe otro Tipo Reclamo con este Codigo. Verifiquelo por favor";
            }
        } else {
            error = (existe) ? "Código Tipo Reclamo: Ya existe otro Tipo Reclamo con este Codigo. Verifiquelo por favor" : "";
        }
        
         /*** Inicio Validar Vacio */
        if(dkda.o(vars, "rectipcodigo_tipoReclamo").isEmpty()) {
            error = "Código Tipo Reclamo: no puede ser vacio.";
        } else if (dkda.o(vars, "rectipdescri_tipoReclamo").isEmpty()) {
            error = "Descripción: no puede ser vacio.";
        }

        /*** Inicio Validar Tipo Dato */
        else if (!v.alfaNumericos(dkda.o(vars, "rectipcodigo_tipoReclamo"))) {
            error = "Código Tipo Reclamo: tiene caracteres no permitidos.";
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


     public boolean existe_tipoReclamo() {
        // UT004 - ESS207 - CCF045
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {                                                                            //
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM reclamotipo  WHERE rectipcodigo  ='" + dkda.o(vars, "rectipcodigo_tipoReclamo") + "'");
            //System.out.println("1. SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            System.out.println("existe_claseGrupoTitular() => " + rQuery.getInt(1));
            pQuery.close();
            rQuery.close();

        } catch (SQLException e) {
            System.err.println("( existe_claseGrupoTitular() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));

        }
        return existe;
    }
}
