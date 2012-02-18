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
import java.sql.*;
import java.net.URLDecoder;

/**
 *
 * @author Sebas
 */
public class Regimen extends HttpServlet {

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
        respuesta = "";


        try {
            String opcion = dkda.o(vars, "accion").toString();
            System.out.println("Opcion : " + opcion);
            respuesta = "";
            String respuesta = validarFormulario_Regimen();
            
            
            System.out.println("respuesta : " + respuesta + "  " + respuesta.length());
            if ((opcion.equals("Registrar") || opcion.equals("Actualizar")) && respuesta.length() > 0) {
                out.println(respuesta);
            } else {

                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_Regimenes(con));
                }
                if (opcion.equals("Obtener")) {

                    out.println(obtener_Regimenes(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {

                    out.println(actualizar_Regimenes(con));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminarRegimen(con, dkda.o(vars, "codigo").toString()));
                }

            }
        } finally {
            out.close();
        }

    }

    public String registrar_Regimenes(ConexionBaseDatos con) {

        System.out.println("REGISGRANDO REGIMENES");
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "INSERT INTO regimen("
                    + "codregimen, codalterno, descripcion, codplansalud, observacion, "
                    + "ususiscodigo, fecharegistro) VALUES "
                    + "('" + dkda.o(vars, "codregimen_regimen") + "', "
                    + "'" + dkda.o(vars, "codalterno_regimen") + "', "
                    + "'" + dkda.o(vars, "descripcion_regimen") + "', "
                    + "'" + dkda.o(vars, "codplansalud_regimen") + "', "
                    + "'" + dkda.o(vars, "observacion_regimen") + "', "
                    + "'DELPHOS', "
                    + "'NOW()')";



            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_regimen&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_regimen&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Regimen.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_Regimenes(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener:  " + codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "regimen.codregimen AS regimen_codregimen,"
                    + "regimen.codalterno AS regimen_codalterno,"
                    + "regimen.descripcion AS regimen_descripcion,"
                    + "regimen.codplansalud AS regimen_codplansalud,"
                    + "regimen.observacion AS regimen_observacion,"
                    + "regimen.ususiscodigo AS regimen_ususiscodigo,"
                    + "regimen.fecharegistro AS regimen_fecharegistro,"
                    + "plansalud.codplansalud AS plansalud_codplansalud,"
                    + "plansalud.descripcion AS plansalud_descripcion,"
                    + "plansalud.observacion AS plansalud_observacion,"
                    + "plansalud.codtiponorma AS plansalud_codtiponorma,"
                    + "plansalud.codnorma AS plansalud_codnorma,"
                    + "plansalud.fechanorma AS plansalud_fechanorma,"
                    + "plansalud.ususiscodigo AS plansalud_ususiscodigo,"
                    + "plansalud.fecharegistro AS plansalud_fecharegistro"
                    + " FROM "
                    + "public.plansalud plansalud INNER JOIN public.regimen regimen ON plansalud.codplansalud = regimen.codplansalud "
                    + "WHERE regimen.codregimen = '" + codigo + "'";


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();


            info += "text|#codregimen_regimen|"
                    + (rs.getString("regimen_codregimen") == null ? ""
                    : rs.getString("regimen_codregimen")) + ":_";

            info += "text|#codalterno_regimen|"
                    + (rs.getString("regimen_codalterno") == null ? ""
                    : rs.getString("regimen_codalterno")) + ":_";

            info += "text|#descripcion_regimen|"
                    + (rs.getString("regimen_descripcion") == null ? ""
                    : rs.getString("regimen_descripcion")) + ":_";

            info += "text|#descripcion_regimen|"
                    + (rs.getString("regimen_descripcion") == null ? ""
                    : rs.getString("regimen_descripcion")) + ":_";

            info += "combo|#codplansalud_regimen|" + rs.getString("plansalud_codplansalud")
                    + "|llenarCombo('codplansalud_regimen', '" + rs.getString("plansalud_codplansalud")
                    + "', '" + rs.getString("plansalud_descripcion") + "'):_";

            info += "text|#observacion_regimen|"
                    + (rs.getString("regimen_observacion") == null ? ""
                    : rs.getString("regimen_observacion")) + ":_";


            respuesta = "opcion=obtener_regimen&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_regimen&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error Regimen - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_Regimenes(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "UPDATE regimen"
                    + " SET "
                    + " codalterno='" + dkda.o(vars, "codalterno_regimen") + "',"
                    + " descripcion='" + dkda.o(vars, "descripcion_regimen") + "',"
                    + " codplansalud=" + dkda.o(vars, "codplansalud_regimen") + ", "
                    + "observacion='" + dkda.o(vars, "observacion_regimen") + "', "
                    + "ususiscodigo='DELPHOS',"
                    + " fecharegistro='NOW()' WHERE codregimen = '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_regimen&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_regimen&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Regimen.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }
    public String eliminarRegimen(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
     
        String[] codigos = codigo.split(",");
        String nuevosCodigos = "";
        for (int n = 0; n < codigos.length; n++) {
            nuevosCodigos += "'" + codigos[n] + "',";
        }
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;

            stmt = con.con.prepareStatement("DELETE FROM regimen WHERE codregimen IN(" + nuevosCodigos.substring(0, nuevosCodigos.length() - 1) + ")");
            stmt.execute();
            respuesta = "opcion=eliminar_regimen&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=eliminar_entidad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Regimen.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }
    public String validarFormulario_Regimen() {
        String direccion = "opcion=validacion&&estado=no&&error=si&&errorDes=";
        String error = "";

        /** Comprobar Existencia Regimenes Tabla regimen **/
        if (existeRegimen()) {
            error = "Código Regimen: Ya existe otro Regimen con este Codigo. Verifiquelo por favor";
        } /** Validar Vacio**/
        else if (dkda.o(vars, "codregimen_regimen").isEmpty()) {
            error = "Código Regimen: Este campo no puede ir vacio.";
        } else if (dkda.o(vars, "descripcion_regimen").isEmpty()) {
            error = "Descripción Regimen: Este campo no puede ir vacio.";
        } else if (dkda.o(vars, "codplansalud_regimen").isEmpty()) {
            error = "Código Plan Salud: Debe Seleccionar un Código.";
        } /**Validar Tipo de Dato Esperado**/
        else if (!v.alfaNumericos(dkda.o(vars, "codregimen_regimen"))) {
            error = "Código Regimen: tiene caracteres no permitidos.";
        } else if (!v.alfaNumericos(dkda.o(vars, "codalterno_regimen")) && (!dkda.o(vars, "codalterno_regimen").isEmpty())) {
            error = "Código Alterno: tiene caracteres no permitidos.";
        } else if (!v.alfaNumericos(dkda.o(vars, "descripcion_regimen"))) {
            error = "Descripción Regimen: tiene caracteres no permitidos.";
        } else if (!v.alfaNumericos(dkda.o(vars, "observacion_regimen")) && (!dkda.o(vars, "observacion_regimen").isEmpty())) {
            error = "Observaciones: tiene caracteres no permitidos.";
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

    public boolean existeRegimen() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {                                                                            //
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM regimen WHERE codregimen ='" + dkda.o(vars, "codregimen_regimen") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();

        } catch (SQLException e) {
            System.err.println("( existeRegimen() ) Error al consultar los campos de la tabla: " + e);
        }
        return existe;
    }
}
