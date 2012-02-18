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
public class EstadoEscolaridad extends HttpServlet {

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
            String respuesta = validarFormulario_estadoEscolaridad();

            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_estadoEscolaridad(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_estadoEscolaridad(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_estadoEscolaridad(con));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_escolaridadestado(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }

    }

    public String eliminar_escolaridadestado(ConexionBaseDatos con, String codigo) {
        System.out.println("Eliminar entra" + codigo.substring(0, codigo.length() - 1));
        con.abrirConexion();
        String[] codigos = codigo.split(",");
        String nuevosCodigos = "";
        for (int n = 0; n < codigos.length; n++) {
            nuevosCodigos += "'" + codigos[n] + "',";
        }
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            stmt = con.con.prepareStatement("DELETE FROM escolaridadestado WHERE escestcodigo = '" + codigo.substring(0, codigo.length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_estadoEscolaridad&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_estadoEscolaridad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error estadoEscolaridad.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String registrar_estadoEscolaridad(ConexionBaseDatos con) {

        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO escolaridadestado ( escestcodigo, escescdescri, ususiscodigo, fecharegistro)"
                    + " VALUES (" + (dkda.o(vars, "escestcodigo_estadoEscolaridad").equals("") ? null : "'"
                    + dkda.o(vars, "escestcodigo_estadoEscolaridad") + "'") + ","
                    + (dkda.o(vars, "escescdescri_estadoEscolaridad").equals("") ? null : "'"
                    + dkda.o(vars, "escescdescri_estadoEscolaridad") + "'") + "," + "'"
                    + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_estadoEscolaridad&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_estadoEscolaridad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error EstadoEscolaridad.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_estadoEscolaridad(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener:  " + codigo);
        System.out.println(codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "escolaridadestado.escestcodigo AS escolaridadestado_escestcodigo,"
                    + "escolaridadestado.escescdescri AS escolaridadestado_escescdescri,"
                    + "escolaridadestado.ususiscodigo AS escolaridadestado_ususiscodigo,"
                    + "escolaridadestado.fecharegistro AS escolaridadestado_fecharegistro"
                    + " FROM public.escolaridadestado escolaridadestado WHERE escestcodigo = '" + codigo + "'";

            System.out.println(codigo);

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#escestcodigo_estadoEscolaridad|"
                    + (rs.getString("escolaridadestado_escestcodigo") == null ? ""
                    : rs.getString("escolaridadestado_escestcodigo")) + ":_";

            info += "text|#escescdescri_estadoEscolaridad|"
                    + (rs.getString("escolaridadestado_escescdescri") == null ? ""
                    : rs.getString("escolaridadestado_escescdescri")) + ":_";

//

            respuesta = "opcion=obtener_estadoEscolaridad&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_estadoEscolaridad&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error Entidad - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_estadoEscolaridad(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE escolaridadestado SET escestcodigo = "
                    + (dkda.o(vars, "escestcodigo_estadoEscolaridad").equals("") ? null : "'"
                    + dkda.o(vars, "escestcodigo_estadoEscolaridad") + "'") + ",escescdescri = "
                    + (dkda.o(vars, "escescdescri_estadoEscolaridad").equals("") ? null : "'"
                    + dkda.o(vars, "escescdescri_estadoEscolaridad") + "'") + ", ususiscodigo = " + "'"
                    + fun.usuarioAutenticado(request) + "'" + ", fecharegistro = " + "NOW()::date"
                    + " WHERE escestcodigo =  '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_estadoEscolaridad&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_estadoEscolaridad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error Entidad.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String validarFormulario_estadoEscolaridad() {
        String direccion = "opcion=registrar_estadoEscolaridad&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_escolaridadestado();

        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "escestcodigo_estadoEscolaridad").toString().equals(dkda.o(vars, "escestcodigo_estadoEscolaridad"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "escestcodigo_estadoEscolaridad").isEmpty()) {
            error = "C&oacute;digo Estado Escolaridad: no puede ser vacio.";
        } else if (dkda.o(vars, "escescdescri_estadoEscolaridad").isEmpty()) {
            error = "Descripci&oacute;n Estado Escolaridad: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "escestcodigo_estadoEscolaridad"))) {
            error = "C&oacute;digo Estado Escolaridad: Tiene Caracteres no permitidos.";
        } else if (!v.alfaNumericos(dkda.o(vars, "escescdescri_estadoEscolaridad"))) {
            error = "Descripci&oacute;n Estado Escolaridad: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "escestcodigo_estadoEscolaridad").length() > 1) {
            error = "C&oacute;digo Estado Escolaridad: Valor demasiado Largo.";
        } else if (dkda.o(vars, "escescdescri_estadoEscolaridad").length() > 30) {
            error = "Descripci&oacute;n Estado Escolaridad: Valor demasiado Largo.";
        }

        respuesta = (error.length() > 1 ? direccion + "<strong>" + error + "</strong>" : "");

        return respuesta;
    }

    private boolean existe_escolaridadestado() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            System.out.println( "SELECT COUNT(*) FROM escolaridadestado  WHERE escestcodigo = '" + dkda.o(vars, "escestcodigo_estadoEscolaridad") + "'" );
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM escolaridadestado  WHERE escestcodigo = '" + dkda.o(vars, "escestcodigo_estadoEscolaridad") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_escolaridadestado() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
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
