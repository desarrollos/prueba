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

public class TipoViolencia extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());



        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_tipoviolencia();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_tipoviolencia(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_tipoviolencia(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_tipoviolencia(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_tipoviolencia(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_tipoviolencia(ConexionBaseDatos con) {
        System.out.println("registrar_tipoviolencia");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO tipoviolencia (tipviocodigo,tipviodescri,tipvioobserv,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "tipviocodigo_tipoviolencia").equals("") ? null : "'" + dkda.o(vars, "tipviocodigo_tipoviolencia") + "'") + "," + (dkda.o(vars, "tipviodescri_tipoviolencia").equals("") ? null : "'" + dkda.o(vars, "tipviodescri_tipoviolencia") + "'") + "," + (dkda.o(vars, "tipvioobserv_tipoviolencia").equals("") ? null : "'" + dkda.o(vars, "tipvioobserv_tipoviolencia") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_tipoviolencia&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_tipoviolencia&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error tipoviolencia.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_tipoviolencia(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE tipoviolencia SET tipviocodigo = " + (dkda.o(vars, "tipviocodigo_tipoviolencia").equals("") ? null : "'" + dkda.o(vars, "tipviocodigo_tipoviolencia") + "'") + ",tipviodescri = " + (dkda.o(vars, "tipviodescri_tipoviolencia").equals("") ? null : "'" + dkda.o(vars, "tipviodescri_tipoviolencia") + "'") + ",tipvioobserv = " + (dkda.o(vars, "tipvioobserv_tipoviolencia").equals("") ? null : "'" + dkda.o(vars, "tipvioobserv_tipoviolencia") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE tipviocodigo = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_tipoviolencia&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_tipoviolencia&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error tipoviolencia.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_tipoviolencia(ConexionBaseDatos con, String codigo) {
        System.out.println("Eliminar entra" + codigo);
        con.abrirConexion();
        String[] codigos = codigo.split(",");
        String nuevosCodigos = "";
        for (int n = 0; n < codigos.length; n++) {
            nuevosCodigos += "'" + codigos[n] + "',";
        }
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            stmt = con.con.prepareStatement("DELETE FROM tipoviolencia WHERE tipviocodigo = '" + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_tipoviolencia&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_tipoviolencia&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error tipoviolencia.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_tipoviolencia(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " SELECT      tipoviolencia.tipviocodigo AS tipoviolencia_tipviocodigo,"
                    + "     tipoviolencia.tipviodescri AS tipoviolencia_tipviodescri,     tipoviolencia.tipvioobserv AS tipoviolencia_tipvioobserv,"
                    + "     tipoviolencia.ususiscodigo AS tipoviolencia_ususiscodigo,     tipoviolencia.fecharegistro AS tipoviolencia_fecharegistro"
                    + " FROM      public.tipoviolencia tipoviolencia WHERE tipoviolencia.tipviocodigo  = '"+codigo+"'";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            
            info += "text|#tipviocodigo_tipoviolencia|"
                    + (rs.getString("tipoviolencia_tipviocodigo") == null ? ""
                    : rs.getString("tipoviolencia_tipviocodigo")) + ":_";
            
            info += "text|#tipviodescri_tipoviolencia|"
                    + (rs.getString("tipoviolencia_tipviodescri") == null ? ""
                    : rs.getString("tipoviolencia_tipviodescri")) + ":_";
            
            info += "text|#tipvioobserv_tipoviolencia|"
                    + (rs.getString("tipoviolencia_tipvioobserv") == null ? ""
                    : rs.getString("tipoviolencia_tipvioobserv")) + ":_";
            
            respuesta = "opcion=obtener_tipoviolencia&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_tipoviolencia&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error tipoviolencia - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_tipoviolencia() {
        String direccion = "opcion=registrar_tipoviolencia&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = existe_tipoviolencia();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "tipviocodigo_tipoviolencia"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "tipviocodigo_tipoviolencia").isEmpty()) {
            error = "Código Tipo Violencia : no puede ser vacio.";
        } else if (dkda.o(vars, "tipviodescri_tipoviolencia").isEmpty()) {
            error = "Descripción Tipo Violencia : no puede ser vacio.";
        } else if (dkda.o(vars, "tipvioobserv_tipoviolencia").isEmpty()) {
            error = "Observaciones Tipo Violencia: no puede ser vacio.";
        } else if (dkda.o(vars, "tipviocodigo_tipoviolencia").length() > 3) {
            error = "Código Tipo Violencia : Valor demasiado Largo.";
        } else if (dkda.o(vars, "tipviodescri_tipoviolencia").length() > 50) {
            error = "Descripción Tipo Violencia : Valor demasiado Largo.";
        } else if (dkda.o(vars, "tipvioobserv_tipoviolencia").length() > 400) {
            error = "Observaciones Tipo Violencia: Valor demasiado Largo.";
        }

        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }// 

    /** * Handles the HTTP GET method. * @param request servlet request * @param response servlet response * @throws ServletException if a servlet-specific error occurs * @throws IOException if an I/O error occurs */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /** * Handles the HTTP POST method. * @param request servlet request * @param response servlet response * @throws ServletException if a servlet-specific error occurs * @throws IOException if an I/O error occurs */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /** * Returns a short description of the servlet. * @return a String containing servlet description */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

    private boolean existe_tipoviolencia() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM tipoviolencia  WHERE tipviocodigo = '" + dkda.o(vars, "tipviocodigo_tipoviolencia") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_tipoviolencia() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }
}