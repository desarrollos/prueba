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

public class Salud extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, entidadsalud_inscripcionips_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());



        entidadsalud_inscripcionips_1 = fun.map(dkda.o(vars, "entidadsalud_inscripcionips_1").toString());
        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_inscripcionips();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_inscripcionips(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_inscripcionips(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_inscripcionips(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_inscripcionips(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_inscripcionips(ConexionBaseDatos con) {
        System.out.println("registrar_inscripcionips");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO inscripcionips (codregimenes,codentidadsalud,codtipoidentidad,insipsidenti,insipsfecins,insipshiscli,insipscenate,esinipscodigo,insipsobserv,ususiscodigo,fecharegistro,insipsarchiv,insipsarchiv_nombre) VALUES (" + (dkda.o(entidadsalud_inscripcionips_1, "codregimenes").equals("") ? null : "'" + dkda.o(entidadsalud_inscripcionips_1, "codregimenes") + "'") + "," + (dkda.o(entidadsalud_inscripcionips_1, "codentidadsalud").equals("") ? null : "'" + dkda.o(entidadsalud_inscripcionips_1, "codentidadsalud") + "'") + "," + (dkda.o(vars, "codtipoidentidad_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_inscripcionips") + "'") + "," + (dkda.o(vars, "insipsidenti_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "insipsidenti_inscripcionips") + "'") + "," + (dkda.o(vars, "insipsfecins_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "insipsfecins_inscripcionips") + "'") + "," + (dkda.o(vars, "insipshiscli_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "insipshiscli_inscripcionips") + "'") + "," + (dkda.o(vars, "insipscenate_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "insipscenate_inscripcionips") + "'") + "," + (dkda.o(vars, "esinipscodigo_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "esinipscodigo_inscripcionips") + "'") + "," + (dkda.o(vars, "insipsobserv_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "insipsobserv_inscripcionips") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "insipsarchiv_inscripcionips").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "insipsarchiv_inscripcionips") + "')") + "," + (dkda.o(vars, "insipsarchiv_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "insipsarchiv_inscripcionips") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_inscripcionips&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_inscripcionips&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error inscripcionips.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_inscripcionips(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE inscripcionips SET codregimenes = " + (dkda.o(entidadsalud_inscripcionips_1, "codregimenes").equals("") ? null : "'" + dkda.o(entidadsalud_inscripcionips_1, "codregimenes") + "'") + ",codentidadsalud = " + (dkda.o(entidadsalud_inscripcionips_1, "codentidadsalud").equals("") ? null : "'" + dkda.o(entidadsalud_inscripcionips_1, "codentidadsalud") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_inscripcionips") + "'") + ",insipsidenti = " + (dkda.o(vars, "insipsidenti_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "insipsidenti_inscripcionips") + "'") + ",insipsfecins = " + (dkda.o(vars, "insipsfecins_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "insipsfecins_inscripcionips") + "'") + ",insipshiscli = " + (dkda.o(vars, "insipshiscli_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "insipshiscli_inscripcionips") + "'") + ",insipscenate = " + (dkda.o(vars, "insipscenate_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "insipscenate_inscripcionips") + "'") + ",esinipscodigo = " + (dkda.o(vars, "esinipscodigo_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "esinipscodigo_inscripcionips") + "'") + ",insipsobserv = " + (dkda.o(vars, "insipsobserv_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "insipsobserv_inscripcionips") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",insipsarchiv = " + (dkda.o(vars, "insipsarchiv_inscripcionips").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "insipsarchiv_inscripcionips") + "')") + ",insipsarchiv_nombre = " + (dkda.o(vars, "insipsarchiv_inscripcionips").equals("") ? null : "'" + dkda.o(vars, "insipsarchiv_inscripcionips") + "'") + " WHERE codregimenes = '" + dkda.o(sel, "codregimenes") + "' AND codentidadsalud = '" + dkda.o(sel, "codentidadsalud") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_inscripcionips&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_inscripcionips&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error inscripcionips.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_inscripcionips(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM inscripcionips WHERE codregimenes = '" + dkda.o(sel, "codregimenes") + "' AND codentidadsalud = '" + dkda.o(sel, "codentidadsalud") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_inscripcionips&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_inscripcionips&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error inscripcionips.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    private boolean existe_inscripcionips() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM inscripcionips  "
                    + "WHERE codregimenes = '" + dkda.o(entidadsalud_inscripcionips_1, "codregimenes") + "'" + ""
                    + " AND codentidadsalud = '" + dkda.o(entidadsalud_inscripcionips_1, "codentidadsalud") + "'" + " "
                    + "AND codtipoidentidad = '" + dkda.o(vars, "codtipoidentidad_inscripcionips") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_inscripcionips() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String obtener_inscripcionips(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT inscripcionips.\"codregimenes\"     AS inscripcionips_codregimenes, "
                    + "       inscripcionips.\"codentidadsalud\"  AS inscripcionips_codentidadsalud, "
                    + "       inscripcionips.\"codtipoidentidad\" AS inscripcionips_codtipoidentidad, "
                    + "       inscripcionips.\"insipsidenti\"     AS inscripcionips_insipsidenti, "
                    + "       inscripcionips.\"insipsfecins\"     AS inscripcionips_insipsfecins, "
                    + "       inscripcionips.\"insipshiscli\"     AS inscripcionips_insipshiscli, "
                    + "       inscripcionips.\"insipscenate\"     AS inscripcionips_insipscenate, "
                    + "       inscripcionips.\"esinipscodigo\"    AS inscripcionips_esinipscodigo, "
                    + "       inscripcionips.\"insipsarchiv\"     AS inscripcionips_insipsarchiv, "
                    + "       inscripcionips.\"insipsarchiv_nombre\"     AS inscripcionips_insipsarchiv_nombre, "
                    + "       inscripcionips.\"insipsobserv\"     AS inscripcionips_insipsobserv, "
                    + "       tipoidentificacion.\"descripcion\"  AS tipoidentificacion_descripcion, "
                    + "       estadoincripips.\"esinipsdescri\"   AS estadoincripips_esinipsdescri ,"
                    + "       entidadsalud.\"nombrehabilitacion\"   AS entidadsalud_nombrehabilitacion, "
                    
                    + "CASE WHEN inscripcionips.insipsarchiv_nombre  IS NULL OR inscripcionips.insipsarchiv_nombre  = '' THEN 0 "
                    + "ELSE lo_export(inscripcionips.insipsarchiv, '" + fun.temp(request) + "' || inscripcionips.insipsarchiv_nombre ) END "                    
                    
                    + "FROM   \"public\".\"entidadsalud\" entidadsalud "
                    + "       INNER JOIN \"public\".\"inscripcionips\" inscripcionips "
                    + "         ON entidadsalud.\"codregimenes\" = inscripcionips.\"codregimenes\" "
                    + "            AND entidadsalud.\"codentidadsalud\" = "
                    + "                inscripcionips.\"codentidadsalud\" "
                    + "       INNER JOIN \"public\".\"estadoincripips\" estadoincripips "
                    + "         ON inscripcionips.\"esinipscodigo\" = estadoincripips.\"esinipscodigo\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON inscripcionips.\"codtipoidentidad\" = "
                    + "            tipoidentificacion.\"codtipoidentidad\" "
                    + "WHERE inscripcionips.codregimenes = '" + dkda.o(sel, "codregimenes") + "' "
                    + "AND inscripcionips.codentidadsalud = '" + dkda.o(sel, "codentidadsalud") + "' "
                    + "AND inscripcionips.codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' ";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            
            info += "text|#insipsarchiv_inscripcionips|" + (rs.getString("inscripcionips_insipsarchiv_nombre") == null ? "" : 
                    rs.getString("inscripcionips_insipsarchiv_nombre")) + ":_";              
            
            info += "text|#insipsobserv_inscripcionips|" + (rs.getString("inscripcionips_insipsobserv") == null ? "" : 
                    rs.getString("inscripcionips_insipsobserv")) + ":_";  
            
            info += "combo|#esinipscodigo_inscripcionips|" + rs.getString("inscripcionips_esinipscodigo") +
                    "|llenarCombo('esinipscodigo_inscripcionips', '"
                    + rs.getString("inscripcionips_esinipscodigo") + "', '" +
                    rs.getString("estadoincripips_esinipsdescri") + "'):_";

            info += "text|#insipscenate_inscripcionips|" + (rs.getString("inscripcionips_insipscenate") == null ? "" : 
                    rs.getString("inscripcionips_insipscenate")) + ":_";            
            
            info += "text|#insipshiscli_inscripcionips|" + (rs.getString("inscripcionips_insipshiscli") == null ? "" : 
                    rs.getString("inscripcionips_insipshiscli")) + ":_";
            
            info += "text|#_fecha_insipsfecins_inscripcionips|" + (rs.getString("inscripcionips_insipsfecins") == null ? "" : 
                    rs.getString("inscripcionips_insipsfecins")) + ":_";
            
            info += "text|#insipsidenti_inscripcionips|" + (rs.getString("inscripcionips_insipsidenti") == null ? "" : 
                    rs.getString("inscripcionips_insipsidenti")) + ":_";

            info += "combo|#codtipoidentidad_inscripcionips|" + rs.getString("inscripcionips_codtipoidentidad") +
                    "|llenarCombo('codtipoidentidad_inscripcionips', '"
                    + rs.getString("inscripcionips_codtipoidentidad") + "', '" +
                    rs.getString("tipoidentificacion_descripcion") + "'):_";

            info += "combo|#entidadsalud_inscripcionips_1|" + "entidadsalud   codregimenes  "
                    + rs.getString("inscripcionips_codregimenes") + ""
                    + "   codentidadsalud  " + rs.getString("inscripcionips_codentidadsalud")
                    + "|llenarCombo('entidadsalud_inscripcionips_1', '"
                    + "entidadsalud   codregimenes  " + rs.getString("inscripcionips_codregimenes") + "  "
                    + " codentidadsalud  " + rs.getString("inscripcionips_codentidadsalud") + "', '"
                    + rs.getString("entidadsalud_nombrehabilitacion") + "'):_";


            respuesta = "opcion=obtener_inscripcionips&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_inscripcionips&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error inscripcionips - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_inscripcionips() {
        String direccion = "opcion=registrar_inscripcionips&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_inscripcionips();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codregimenes").toString().equals(dkda.o(entidadsalud_inscripcionips_1, "codregimenes")) 
                    && dkda.o(sel, "codentidadsalud").toString().equals(dkda.o(entidadsalud_inscripcionips_1, "codentidadsalud")) 
                    && dkda.o(sel, "codtipoidentidad").toString().equals(dkda.o(vars, "codtipoidentidad_inscripcionips"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(entidadsalud_inscripcionips_1, "codregimenes").isEmpty()) {
            error = "Codigo del regimen: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_inscripcionips").isEmpty()) {
            error = "Tipo Identificacion Persona Inscripta IPS: no puede ser vacio.";
        } else if (dkda.o(vars, "insipsidenti_inscripcionips").isEmpty()) {
            error = "Identificación Inscripto a IPS: no puede ser vacio.";
        } else if (dkda.o(vars, "insipsfecins_inscripcionips").isEmpty()) {
            error = "Fecha Inscripción IPS: no puede ser vacio.";
        } else if (dkda.o(vars, "insipshiscli_inscripcionips").isEmpty()) {
            error = "Número Historia Clínica: no puede ser vacio.";
        } else if (dkda.o(vars, "insipscenate_inscripcionips").isEmpty()) {
            error = "Centro Atención: no puede ser vacio.";
        } else if (dkda.o(vars, "esinipscodigo_inscripcionips").isEmpty()) {
            error = "Código Estado Inscripción: no puede ser vacio.";
        } else if (dkda.o(vars, "insipsarchiv_inscripcionips").isEmpty()) {
            error = "Archivo Documento Inscripción IPS: no puede ser vacio.";
        } else if (dkda.o(vars, "insipsobserv_inscripcionips").isEmpty()) {
            error = "Observaciones Inscripción IPS: no puede ser vacio.";
        } else if (dkda.o(vars, "insipshiscli_inscripcionips").length() > 18) {
            error = "Número Historia Clínica: Valor demasiado Largo.";
        } else if (dkda.o(vars, "insipscenate_inscripcionips").length() > 70) {
            error = "Centro Atención: Valor demasiado Largo.";
        } else if (dkda.o(vars, "insipsobserv_inscripcionips").length() > 400) {
            error = "Observaciones Inscripción IPS: Valor demasiado Largo.";
        }
        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }// 

    /**
     * * Handles the HTTP GET method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * * Handles the HTTP POST method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
// 
}