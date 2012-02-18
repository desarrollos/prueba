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

public class RegistroEstimulacionTemprana extends HttpServlet {

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
            String respuesta = validarFormulario_estimulaciontemprana();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_estimulaciontemprana(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_estimulaciontemprana(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_estimulaciontemprana(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_estimulaciontemprana(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_estimulaciontemprana(ConexionBaseDatos con) {
        System.out.println("registrar_estimulaciontemprana");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO estimulaciontemprana "
                    + "(esttemid,codtipoidentidad,esttemidenti,esttemfecact,esttemquien,tipestcodigo,esttemaccion,esttemobserv,ususiscodigo,fecharegistro,esttemarchiv,esttemarchiv_nombre) "
                    + "VALUES (" + (dkda.o(vars, "esttemid_estimulaciontemprana").equals("") ? null : dkda.o(vars, "esttemid_estimulaciontemprana")) + "," + (dkda.o(vars, "codtipoidentidad_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_estimulaciontemprana") + "'") + "," + (dkda.o(vars, "esttemidenti_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "esttemidenti_estimulaciontemprana") + "'") + "," + (dkda.o(vars, "esttemfecact_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "esttemfecact_estimulaciontemprana") + "'") + "," + (dkda.o(vars, "esttemquien_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "esttemquien_estimulaciontemprana") + "'") + "," + (dkda.o(vars, "tipestcodigo_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "tipestcodigo_estimulaciontemprana") + "'") + "," + (dkda.o(vars, "esttemaccion_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "esttemaccion_estimulaciontemprana") + "'") + "," + (dkda.o(vars, "esttemobserv_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "esttemobserv_estimulaciontemprana") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "esttemarchiv_estimulaciontemprana").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "esttemarchiv_estimulaciontemprana") + "')") + "," + (dkda.o(vars, "esttemarchiv_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "esttemarchiv_estimulaciontemprana") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_estimulaciontemprana&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_estimulaciontemprana&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error estimulaciontemprana.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_estimulaciontemprana(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE estimulaciontemprana SET esttemid = " + (dkda.o(vars, "esttemid_estimulaciontemprana").equals("") ? null : dkda.o(vars, "esttemid_estimulaciontemprana")) + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_estimulaciontemprana") + "'") + ",esttemidenti = " + (dkda.o(vars, "esttemidenti_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "esttemidenti_estimulaciontemprana") + "'") + ",esttemfecact = " + (dkda.o(vars, "esttemfecact_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "esttemfecact_estimulaciontemprana") + "'") + ",esttemquien = " + (dkda.o(vars, "esttemquien_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "esttemquien_estimulaciontemprana") + "'") + ",tipestcodigo = " + (dkda.o(vars, "tipestcodigo_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "tipestcodigo_estimulaciontemprana") + "'") + ",esttemaccion = " + (dkda.o(vars, "esttemaccion_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "esttemaccion_estimulaciontemprana") + "'") + ",esttemobserv = " + (dkda.o(vars, "esttemobserv_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "esttemobserv_estimulaciontemprana") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",esttemarchiv = " + (dkda.o(vars, "esttemarchiv_estimulaciontemprana").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "esttemarchiv_estimulaciontemprana") + "')") + ",esttemarchiv_nombre = " + (dkda.o(vars, "esttemarchiv_estimulaciontemprana").equals("") ? null : "'" + dkda.o(vars, "esttemarchiv_estimulaciontemprana") + "'") + " WHERE esttemid = " + dkda.o(vars, "codigo") + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_estimulaciontemprana&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_estimulaciontemprana&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error estimulaciontemprana.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_estimulaciontemprana(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM estimulaciontemprana WHERE esttemid = " + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "");
            stmt.execute();
            respuesta = "opcion=eliminar_estimulaciontemprana&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_estimulaciontemprana&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error estimulaciontemprana.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_estimulaciontemprana(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT estimulaciontemprana.esttemid  AS estimulaciontemprana_esttemid "
                    + "       , "
                    + "       estimulaciontemprana.codtipoidentidad    AS "
                    + "       estimulaciontemprana_codtipoidentidad, "
                    + "       estimulaciontemprana.esttemidenti        AS "
                    + "       estimulaciontemprana_esttemidenti, "
                    + "       estimulaciontemprana.esttemfecact        AS "
                    + "       estimulaciontemprana_esttemfecact, "
                    + "       estimulaciontemprana.esttemquien         AS "
                    + "       estimulaciontemprana_esttemquien, "
                    + "       estimulaciontemprana.tipestcodigo        AS "
                    + "       estimulaciontemprana_tipestcodigo, "
                    + "       estimulaciontemprana.esttemaccion        AS "
                    + "       estimulaciontemprana_esttemaccion, "
                    + "       estimulaciontemprana.esttemobserv        AS "
                    + "       estimulaciontemprana_esttemobserv, "
                    + "       estimulaciontemprana.ususiscodigo        AS "
                    + "       estimulaciontemprana_ususiscodigo, "
                    + "       estimulaciontemprana.fecharegistro       AS "
                    + "       estimulaciontemprana_fecharegistro, "
                    + "       estimulaciontemprana.esttemarchiv        AS "
                    + "       estimulaciontemprana_esttemarchiv, "
                    + "       estimulaciontemprana.esttemarchiv_nombre AS "
                    + "       estimulaciontemprana_esttemarchiv_nombre, "
                    + "       tipoestimulacion.tipestcodigo            AS tipoestimulacion_tipestcodigo "
                    + "       , "
                    + "       tipoestimulacion.tipestdescri            AS "
                    + "       tipoestimulacion_tipestdescri, "
                    + "       tipoidentificacion.codtipoidentidad      AS "
                    + "       tipoidentificacion_codtipoidentidad, "
                    + "       tipoidentificacion.descripcion           AS "
                    + "       tipoidentificacion_descripcion "
                    + "FROM   public.tipoestimulacion tipoestimulacion "
                    + "       inner join public.estimulaciontemprana estimulaciontemprana "
                    + "         ON tipoestimulacion.tipestcodigo = estimulaciontemprana.tipestcodigo "
                    + "       inner join public.tipoidentificacion tipoidentificacion "
                    + "         ON estimulaciontemprana.codtipoidentidad = "
                    + "            tipoidentificacion.codtipoidentidad "
                    + " WHERE estimulaciontemprana.esttemid = " + codigo;


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#esttemid_estimulaciontemprana|"
                    + (rs.getString("estimulaciontemprana_esttemid") == null ? ""
                    : rs.getString("estimulaciontemprana_esttemid")) + ":_";

            info += "text|#_fecha_esttemfecact_estimulaciontemprana|"
                    + (rs.getString("estimulaciontemprana_esttemfecact") == null ? ""
                    : rs.getString("estimulaciontemprana_esttemfecact")) + ":_";

            info += "combo|#codtipoidentidad_estimulaciontemprana|" + rs.getString("estimulaciontemprana_codtipoidentidad")
                    + "|llenarCombo('codtipoidentidad_estimulaciontemprana', '" + rs.getString("estimulaciontemprana_codtipoidentidad")
                    + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):";

            info += "text|#esttemidenti_estimulaciontemprana|"
                    + (rs.getString("estimulaciontemprana_esttemidenti") == null ? ""
                    : rs.getString("estimulaciontemprana_esttemidenti")) + ":_";

            info += "text|#esttemquien_estimulaciontemprana|"
                    + (rs.getString("estimulaciontemprana_esttemquien") == null ? ""
                    : rs.getString("estimulaciontemprana_esttemquien")) + ":_";

            info += "combo|#tipestcodigo_estimulaciontemprana|" + rs.getString("estimulaciontemprana_tipestcodigo")
                    + "|llenarCombo('tipestcodigo_estimulaciontemprana', '" + rs.getString("estimulaciontemprana_tipestcodigo")
                    + "', '" + rs.getString("tipoestimulacion_tipestdescri") + "'):_";

            info += "text|#esttemarchiv_estimulaciontemprana|" + (rs.getString("estimulaciontemprana_esttemarchiv_nombre") == null ? ""
                    : rs.getString("estimulaciontemprana_esttemarchiv_nombre")) + ":_";

            info += "text|#esttemaccion_estimulaciontemprana|"
                    + (rs.getString("estimulaciontemprana_esttemaccion") == null ? ""
                    : rs.getString("estimulaciontemprana_esttemaccion")) + ":_";

            info += "text|#esttemobserv_estimulaciontemprana|"
                    + (rs.getString("estimulaciontemprana_esttemobserv") == null ? ""
                    : rs.getString("estimulaciontemprana_esttemobserv")) + ":_";


            respuesta = "opcion=obtener_estimulaciontemprana&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_estimulaciontemprana&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error estimulaciontemprana - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_estimulaciontemprana() {
        String direccion = "opcion=registrar_estimulaciontemprana&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = existe_estimulaciontemprana();
        System.out.println("Existe? " + existe);
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            System.out.println("SEL => " + dkda.o(sel, "esttemid").toString() + " | " + dkda.o(vars, "codigo").toString());
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "esttemid_estimulaciontemprana"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "esttemid_estimulaciontemprana").isEmpty()) {
            error = "Id Registro: no puede ser vacio.";
        } else if (dkda.o(vars, "esttemfecact_estimulaciontemprana").isEmpty()) {
            error = "Fecha Actividad: no puede ser vacio.";
        } else if (dkda.o(vars, "esttemidenti_estimulaciontemprana").isEmpty()) {
            error = "Identificación Persona: no puede ser vacio.";
        } else if (dkda.o(vars, "esttemquien_estimulaciontemprana").isEmpty()) {
            error = "Quién Realizó la Actividad: no puede ser vacio.";
        } else if (dkda.o(vars, "tipestcodigo_estimulaciontemprana").isEmpty()) {
            error = "CódigoTipo Estimulación Temprana: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "esttemid_estimulaciontemprana"))) {
            error = "Id Registro: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "esttemidenti_estimulaciontemprana"))) {
            error = "Identificación Persona: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "esttemid_estimulaciontemprana").length() > 9) {
            error = "Id Registro: Valor demasiado Largo.";
        } else if (dkda.o(vars, "esttemidenti_estimulaciontemprana").length() > 18) {
            error = "Identificación Persona: Valor demasiado Largo.";
        } else if (dkda.o(vars, "esttemquien_estimulaciontemprana").length() > 80) {
            error = "Quién Realizó la Actividad: Valor demasiado Largo.";
        } else if (dkda.o(vars, "esttemaccion_estimulaciontemprana").length() > 200) {
            error = "Acciones de Estimulación Temprana: Valor demasiado Largo.";
        } else if (dkda.o(vars, "esttemobserv_estimulaciontemprana").length() > 400) {
            error = "Observaciones Estimulación Temprana: Valor demasiado Largo.";
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

    private boolean existe_estimulaciontemprana() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {

            if (!dkda.o(vars, "esttemid_estimulaciontemprana").isEmpty()) {
                System.out.println("SELECT COUNT(*) FROM estimulaciontemprana  WHERE esttemid = " + dkda.o(vars, "esttemid_estimulaciontemprana") + "");
                pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM estimulaciontemprana  WHERE esttemid = " + dkda.o(vars, "esttemid_estimulaciontemprana") + "");
                rQuery = pQuery.executeQuery();
                rQuery.next();
                existe = rQuery.getInt(1) > 0 ? true : false;
                pQuery.close();
                rQuery.close();
            } else {
                existe = false;
            }

        } catch (SQLException e) {
            System.err.println("( existe_estimulaciontemprana() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
            existe = false;
        }
        return existe;
    }

}
