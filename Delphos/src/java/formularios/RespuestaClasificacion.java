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
public class RespuestaClasificacion extends HttpServlet {

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
            String respuesta = validarFormulario_respuestaClasificacion();

            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_respuestaClasificacion(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_respuestaClasificacion(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_respuestaClasificacion(con));
                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_respuestaClasificacion(ConexionBaseDatos con) {

        System.out.println("REGISGRANDO respuestaClasificacion");
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO respuestaclasificacion ( resclacodigo, rescladescri, ususiscodigo, fecharegistro) "
                    + "VALUES (" + ( dkda.o(vars, "resclacodigo_respuestaClasificacion").equals("") ? null : "'" 
                    +dkda.o(vars, "resclacodigo_respuestaClasificacion") + "'" ) + "," 
                    + ( dkda.o(vars, "rescladescri_respuestaClasificacion").equals("") ? null : "'" 
                    + dkda.o(vars, "rescladescri_respuestaClasificacion") + "'" ) + "," 
                    + ( dkda.o(vars, "ususiscodigo_respuestaClasificacion").equals("") ? "'DELPHOS'"  : "'" 
                    + dkda.o(vars, "ususiscodigo_respuestaClasificacion") + "'" ) + "," 
                    + ( dkda.o(vars, "fecharegistro_respuestaClasificacion").equals("") ? "NOW()::date"  : "'" 
                    + dkda.o(vars, "fecharegistro_respuestaClasificacion") + "'" ) + ")";



            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_respuestaClasificacion&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_respuestaClasificacion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error TipoEntidadSalud.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_respuestaClasificacion(ConexionBaseDatos con, String codigo) {
         System.out.println( dkda.o(vars, "rectipcodigo"));
         System.out.println( dkda.o(vars, "recclacodigo"));

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "respuestaclasificacion.resclacodigo AS respuestaclasificacion_resclacodigo,"
                    + "respuestaclasificacion.rescladescri AS respuestaclasificacion_rescladescri,"
                    + "respuestaclasificacion.ususiscodigo AS respuestaclasificacion_ususiscodigo,"
                    + "respuestaclasificacion.fecharegistro AS respuestaclasificacion_fecharegistro"
                    + " FROM public.respuestaclasificacion respuestaclasificacion WHERE resclacodigo = '" + codigo + "'";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#resclacodigo_respuestaClasificacion|"
                    + (rs.getString("respuestaclasificacion_resclacodigo") == null ? ""
                    : rs.getString("respuestaclasificacion_resclacodigo")) + ":_";

            info += "text|#rescladescri_respuestaClasificacion|"
                    + (rs.getString("respuestaclasificacion_rescladescri") == null ? ""
                    : rs.getString("respuestaclasificacion_rescladescri")) + ":_";
            
                    
//

            respuesta = "opcion=obtener_respuestaClasificacion&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_respuestaClasificacion&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error Entidad - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_respuestaClasificacion(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE respuestaclasificacion SET rescladescri = " 
                    + ( dkda.o(vars, "rescladescri_respuestaClasificacion").equals("") ? null : "'" 
                    + dkda.o(vars, "rescladescri_respuestaClasificacion") + "'" ) + ", ususiscodigo = " 
                    + ( dkda.o(vars, "ususiscodigo_respuestaClasificacion").equals("") ? "'DELPHOS'"  : "'" 
                    + dkda.o(vars, "ususiscodigo_respuestaClasificacion") + "'" ) + ", fecharegistro = " 
                    + ( dkda.o(vars, "fecharegistro_respuestaClasificacion").equals("") ? "NOW()::date" : "'" 
                    + dkda.o(vars, "fecharegistro_respuestaClasificacion") + "'" ) 
                    + " WHERE resclacodigo =  '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_respuestaClasificacion&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_respuestaClasificacion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Entidad.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String validarFormulario_respuestaClasificacion() {
        String direccion = "opcion=registrar_usuarios&&estado=no&&error=si&&errorDes=";
        String error = "";
//        Boolean existe = existe_reclamoClasificacion();
//        System.out.println("Codigooo "+dkda.o(vars, "codigo").toString());
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
