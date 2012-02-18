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
public class TipoEntidad extends HttpServlet {

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
            respuesta = "";
            String respuesta = validarFormulario_Entidad();

            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {

                System.out.println("OPCION : " + opcion);

                if (opcion.equals("Registrar")) {


                    out.println(registrar_Entidad(con));


                }
                if (opcion.equals("Obtener")) {

                    out.println(obtener_Entidad(con, dkda.o(vars, "codigo").toString()));



                }
                if (opcion.equals("Actualizar")) {

                    out.println(actualizar_Entidad(con));

                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_Entidad(ConexionBaseDatos con) {

        System.out.println("REGISGRANDO Entidad");
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "INSERT INTO tipoentidadsalud("
                    + "codtipoentidadsalud, descripcion, ususiscodigo, fecharegistro)"
                    + "VALUES ("
                    + "'" + dkda.o(vars, "codtipoentidadsalud_entidad") + "',"
                    + " '" + dkda.o(vars, "descripcion_entidad") + "', "
                    + "'DELPHOS', "
                    + "'NOW()')";



            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_entidad&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_entidad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error TipoEntidadSalud.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_Entidad(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener:  " + codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "tipoentidadsalud.codtipoentidadsalud AS tipoentidadsalud_codtipoentidadsalud,"
                    + "tipoentidadsalud.descripcion AS tipoentidadsalud_descripcion,"
                    + "tipoentidadsalud.ususiscodigo AS tipoentidadsalud_ususiscodigo,"
                    + "tipoentidadsalud.fecharegistro AS tipoentidadsalud_fecharegistro"
                    + " FROM "
                    + "public.tipoentidadsalud  WHERE tipoentidadsalud.codtipoentidadsalud =  '" + codigo + "'";


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();


            info += "text|#codtipoentidadsalud_entidad|"
                    + (rs.getString("tipoentidadsalud_codtipoentidadsalud") == null ? ""
                    : rs.getString("tipoentidadsalud_codtipoentidadsalud")) + ":_";
            
            info += "text|#descripcion_entidad|"
                    + (rs.getString("tipoentidadsalud_descripcion") == null ? ""
                    : rs.getString("tipoentidadsalud_descripcion")) + ":_";            


            respuesta = "opcion=obtener_entidad&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_entidad&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error Entidad - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_Entidad(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "UPDATE tipoentidadsalud "+
                    "SET descripcion='" + dkda.o(vars, "descripcion_entidad") + "', ususiscodigo='DELPHOS', fecharegistro='NOW()' "
                    + "WHERE codtipoentidadsalud = '"+ dkda.o(vars, "codigo") +"'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_entidad&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_entidad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Entidad.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String validarFormulario_Entidad() {
        String direccion = "opcion=registrar_entidad&&estado=no&&error=si&&errorDes=";
        String error = "";

        /** Comprobar Existencia Regimenes Tabla tipoentidadsalud **/
        if( existeTipoRegimen() ){
            error = "Código Tipo Entidad: Ya existe otro Tipo de Entidad con este Codigo. Verifiquelo por favor";
        }
        /**Comprobar Vacios**/
        else if(dkda.o(vars, "codtipoentidadsalud_entidad").isEmpty()) {
            error = "Código Tipo Entidad: Este campo no puede ir vacio.";
        }else if(dkda.o(vars, "descripcion_entidad").isEmpty()) {
            error = "Descripción Código: Este campo no puede ir vacio.";
        }

         /**Comprobar Tipo esperado**/
         else if (!v.alfaNumericos(dkda.o(vars, "codtipoentidadsalud_entidad"))) {
            error = "Código Tipo Entidad: tiene caracteres no permitidos.";
        }else if (!v.alfaNumericos(dkda.o(vars, "descripcion_entidad"))) {
            error = "Descripción Código: tiene caracteres no permitidos.";
        }

        System.out.println(error);
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

  public boolean existeTipoRegimen() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {                                                                            //
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM tipoentidadsalud WHERE codtipoentidadsalud ='" + dkda.o(vars, "codregimen_regimen") + "'");
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
