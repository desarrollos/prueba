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
public class NivelComplejidad extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    String opcion = "";

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
            opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            System.out.println(opcion);

            String respuesta = validarFormulario_Complejidades();
            System.out.println( "RESPUESTA : " + respuesta  +"  " + respuesta.length());
            if (opcion.equals("Registrar") || opcion.equals("Actualizar")) {
                out.println(respuesta);

            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_Complejidades(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_Complejidades(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_Complejidades(con));

                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminarComplejidad(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_Complejidades(ConexionBaseDatos con) {

        System.out.println("REGISGRANDO Complejidades");
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "INSERT INTO nivelcomplejidad("
                    + "codnivelcomplejidad, descripcion, ususiscodigo, fecharegistro) VALUES ("
                    + "'" + dkda.o(vars, "codnivelcomplejidad_complejidad") + "', "
                    + "'" + dkda.o(vars, "descripcion_complejidad") + "',"
                    + "'DELPHOS', "
                    + "'NOW()')";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_complejidad&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_complejidad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Complejidades.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_Complejidades(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener:  " + codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "nivelcomplejidad.codnivelcomplejidad AS nivelcomplejidad_codnivelcomplejidad,"
                    + "nivelcomplejidad.descripcion AS nivelcomplejidad_descripcion,"
                    + "nivelcomplejidad.ususiscodigo AS nivelcomplejidad_ususiscodigo,"
                    + "nivelcomplejidad.fecharegistro AS nivelcomplejidad_fecharegistro"
                    + " FROM " + " public.nivelcomplejidad nivelcomplejidad  WHERE nivelcomplejidad.codnivelcomplejidad = '" + codigo + "'";


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();


            info += "text|#codnivelcomplejidad_complejidad|"
                    + (rs.getString("nivelcomplejidad_codnivelcomplejidad") == null ? ""
                    : rs.getString("nivelcomplejidad_codnivelcomplejidad")) + ":_";

            info += "text|#descripcion_complejidad|"
                    + (rs.getString("nivelcomplejidad_descripcion") == null ? ""
                    : rs.getString("nivelcomplejidad_descripcion")) + ":_";

            respuesta = "opcion=obtener_complejidad&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_complejidad&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error Complejidades - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_Complejidades(ConexionBaseDatos con) {
        System.out.println("Actualizac complejidades");
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE nivelcomplejidad "
                    + "SET descripcion='" + dkda.o(vars, "descripcion_complejidad") + "',"
                    + " ususiscodigo= 'DELPHOS', "
                    + "fecharegistro= 'NOW()' "
                    + "WHERE codnivelcomplejidad = '" + dkda.o(vars, "codnivelcomplejidad_complejidad") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_complejidad&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_complejidad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Complejidad.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String eliminarComplejidad(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();

        String[] codigos = codigo.split(",");
        String nuevosCodigos = "";
        for (int n = 0; n < codigos.length; n++) {
            nuevosCodigos += "'" + codigos[n] + "',";
        }
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;

            stmt = con.con.prepareStatement("DELETE FROM nivelcomplejidad WHERE codnivelcomplejidad IN(" + nuevosCodigos.substring(0, nuevosCodigos.length() - 1) + ")");
            stmt.execute();
            respuesta = "opcion=eliminar_complejidad&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=eliminar_entidad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Complejidad.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String validarFormulario_Complejidades() {
        String direccion = "opcion=validacion&&estado=no&&error=si&&errorDes=";
        String error = "";

        /** Validar Existencia Tabla nivelcomplejidad**/
        if (opcion.equals("Registrar")) {
            if (existeNivelComplejidad()) {
                error = "Código Nivel Complejidad: Ya existe otro Nivel con este Codigo. Verifiquelo por favor";
            }
        }

        /** Validar Vacios**/
        if (dkda.o(vars, "codnivelcomplejidad_complejidad").isEmpty()) {
            error = "Código Nivel Complejidad: Este campo no puede estar vacio";
        } else if (dkda.o(vars, "descripcion_complejidad").isEmpty()) {
            error = "Descripción: El Codigo de Nivel Complejidad debe tener una Descripción";
        } /** Validar tipo de dato **/
        else if (!v.alfaNumericos(dkda.o(vars, "codnivelcomplejidad_complejidad"))) {
            error = "Código Nivel Complejidad: tiene caracteres no permitidos.";
        } else if (!v.alfaNumericos(dkda.o(vars, "descripcion_complejidad"))) {
            error = "Descripción: tiene caracteres no permitidos.";
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

    public boolean existeNivelComplejidad() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {                                                                            //
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM nivelcomplejidad WHERE codnivelcomplejidad ='" + dkda.o(vars, "codnivelcomplejidad_complejidad") + "'");
            //System.out.println("1. SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            System.out.println("existeTipoEntidadSalud() => " + rQuery.getInt(1));
            pQuery.close();
            rQuery.close();

        } catch (SQLException e) {
            System.err.println("( existeTipoEntidadSalud() ) Error al consultar los campos de la tabla: " + e);
        }
        return existe;
    }
}
