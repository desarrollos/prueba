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

public class EscolaridadGrado extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel;
    HashMap selCampos = null;

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
            String respuesta = validarFormulario_gradosEscolaridad();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_gradosEscolaridad(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_gradosEscolaridad(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_gradosEscolaridad(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_gradosEscolaridad(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_gradosEscolaridad(ConexionBaseDatos con) {
        System.out.println("registrar_gradosEscolaridad");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO escolaridadgrado (escgracodigo,escgradescri,tipeducodigo,ususiscodigo,fecharegistro) VALUES (" + ( dkda.o(vars, "escgracodigo_escolaridadgrado").equals("") ? null : "'" + dkda.o(vars, "escgracodigo_escolaridadgrado") + "'" ) + "," + ( dkda.o(vars, "escgradescri_escolaridadgrado").equals("") ? null : "'" + dkda.o(vars, "escgradescri_escolaridadgrado") + "'" ) + "," + ( dkda.o(vars, "tipeducodigo_escolaridadgrado").equals("") ? null : "'" + dkda.o(vars, "tipeducodigo_escolaridadgrado") + "'" ) + ","+ "'"+ fun.usuarioAutenticado(request) +"'" +","+ "NOW()::date" +")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_gradosEscolaridad&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_gradosEscolaridad&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error escolaridadgrado.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_gradosEscolaridad(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE escolaridadgrado SET escgracodigo = " + (dkda.o(vars, "escgracodigo_escolaridadgrado").equals("") ? null : "'" + dkda.o(vars, "escgracodigo_escolaridadgrado") + "'") + ",escgradescri = " + (dkda.o(vars, "escgradescri_escolaridadgrado").equals("") ? null : "'" + dkda.o(vars, "escgradescri_escolaridadgrado") + "'") + ",tipeducodigo = " + (dkda.o(vars, "tipeducodigo_escolaridadgrado").equals("") ? null : "'" + dkda.o(vars, "tipeducodigo_escolaridadgrado") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE escgracodigo = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_gradosEscolaridad&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_gradosEscolaridad&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error escolaridadgrado.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_gradosEscolaridad(ConexionBaseDatos con, String codigo) {
        System.out.println("Eliminar entra" + codigo);
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            stmt = con.con.prepareStatement("DELETE FROM escolaridadgrado WHERE escgracodigo = '" + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_gradosEscolaridad&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_gradosEscolaridad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error escolaridadgrado.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_gradosEscolaridad(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "escolaridadgrado.escgracodigo AS escolaridadgrado_escgracodigo,"
                    + "escolaridadgrado.escgradescri AS escolaridadgrado_escgradescri,"
                    + "escolaridadgrado.tipeducodigo AS escolaridadgrado_tipeducodigo,"
                    + "escolaridadgrado.ususiscodigo AS escolaridadgrado_ususiscodigo,"
                    + "escolaridadgrado.fecharegistro AS escolaridadgrado_fecharegistro,"
                    + "tipoeducacion.tipeducodigo AS tipoeducacion_tipeducodigo,"
                    + "tipoeducacion.tipedudescri AS tipoeducacion_tipedudescri,"
                    + "tipoeducacion.ususiscodigo AS tipoeducacion_ususiscodigo,"
                    + "tipoeducacion.fecharegistro AS tipoeducacion_fecharegistro FROM "
                    + "public.tipoeducacion tipoeducacion INNER JOIN public.escolaridadgrado escolaridadgrado ON tipoeducacion.tipeducodigo = escolaridadgrado.tipeducodigo "
                    + " WHERE escolaridadgrado.escgracodigo = '" + codigo + "'";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            System.out.println(sql);


            info += "text|#escgracodigo_escolaridadgrado|" + (rs.getString("escolaridadgrado_escgracodigo") == null ? "" : rs.getString("escolaridadgrado_escgracodigo")) + ":_";
            info += "combo|#tipeducodigo_escolaridadgrado|"
                    + rs.getString("tipoeducacion_tipeducodigo") + "|llenarCombo('tipeducodigo_escolaridadgrado', '"
                    + rs.getString("tipoeducacion_tipeducodigo") + "', '" + rs.getString("tipoeducacion_tipedudescri") + "'):_";
            info += "text|#escgradescri_escolaridadgrado|" + (rs.getString("escolaridadgrado_escgradescri") == null ? "" : rs.getString("escolaridadgrado_escgradescri")) + ":_";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            respuesta = "opcion=obtener_gradosEscolaridad&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_gradosEscolaridad&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error escolaridadgrado - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_gradosEscolaridad() {
        String direccion = "opcion=registrar_gradosEscolaridad&&estado=no&&error=si&&errorDes=";
        String error = "";

        boolean existe = existe_gradosEscolaridad();

        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "escgracodigo_escolaridadgrado"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
      

        if (dkda.o(vars, "escgracodigo_escolaridadgrado").isEmpty()) {
            error = "Codigo Grado Escolaridad: no puede ser vacio.";
        } else if (dkda.o(vars, "tipeducodigo_escolaridadgrado").isEmpty()) {
            error = "Tipo Educación: no puede ser vacio.";
        } else if (dkda.o(vars, "escgradescri_escolaridadgrado").isEmpty()) {
            error = "Descripción: no puede ser vacio.";
        } else if (dkda.o(vars, "escgracodigo_escolaridadgrado").length() > 10) {
            error = "Codigo Grado Escolaridad: Valor demasiado Largo.";
        } else if (dkda.o(vars, "escgradescri_escolaridadgrado").length() > 30) {
            error = "Descripción: Valor demasiado Largo.";
        }

        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }// 

    private boolean existe_gradosEscolaridad() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM escolaridadgrado  WHERE escgracodigo = '" + dkda.o(vars, "escgracodigo_gradosEscolaridad") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_gradosEscolaridad() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

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
// 
}