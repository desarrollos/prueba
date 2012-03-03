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

public class EntidadSalud extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, empresa_entidadsalud_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());

        empresa_entidadsalud_1 = fun.map(dkda.o(vars, "empresa_entidadsalud_1").toString());
        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_entidadsalud();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_entidadsalud(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_entidadsalud(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_entidadsalud(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_entidadsalud(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_entidadsalud(ConexionBaseDatos con) {
        System.out.println("registrar_entidadsalud");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO entidadsalud (codregimenes,codentidadsalud,codtipoidentidad,codempresa,codtipoentidadsalud,codnivelcomplejidad,codclasifentidad,contacto,cargocontacto,lineagratuita,funcionarios,codigobarras,slogan,codhabilitacion,nombrehabilitacion,codtipoespecializacion,codtipoatencion,codestadoentidad,numactoinscripcion,fechaactoadmin,archivofi,archivofi2,ususiscodigo,fecharegistro,logo,archivoactoadmin,logo_nombre,archivoactoadmin_nombre,archivofi1_nombre,archivofi2_nombre) VALUES (" + (dkda.o(vars, "codregimenes_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codregimenes_entidadsalud") + "'") + "," + (dkda.o(vars, "codentidadsalud_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codentidadsalud_entidadsalud") + "'") + "," + (dkda.o(empresa_entidadsalud_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_entidadsalud_1, "codtipoidentidad") + "'") + "," + (dkda.o(empresa_entidadsalud_1, "codempresa").equals("") ? null : "'" + dkda.o(empresa_entidadsalud_1, "codempresa") + "'") + "," + (dkda.o(vars, "codtipoentidadsalud_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codtipoentidadsalud_entidadsalud") + "'") + "," + (dkda.o(vars, "codnivelcomplejidad_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codnivelcomplejidad_entidadsalud") + "'") + "," + (dkda.o(vars, "codclasifentidad_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codclasifentidad_entidadsalud") + "'") + "," + (dkda.o(vars, "contacto_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "contacto_entidadsalud") + "'") + "," + (dkda.o(vars, "cargocontacto_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "cargocontacto_entidadsalud") + "'") + "," + (dkda.o(vars, "lineagratuita_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "lineagratuita_entidadsalud") + "'") + "," + (dkda.o(vars, "funcionarios_entidadsalud").equals("") ? null : dkda.o(vars, "funcionarios_entidadsalud")) + "," + (dkda.o(vars, "codigobarras_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codigobarras_entidadsalud") + "'") + "," + (dkda.o(vars, "slogan_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "slogan_entidadsalud") + "'") + "," + (dkda.o(vars, "codhabilitacion_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codhabilitacion_entidadsalud") + "'") + "," + (dkda.o(vars, "nombrehabilitacion_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "nombrehabilitacion_entidadsalud") + "'") + "," + (dkda.o(vars, "codtipoespecializacion_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codtipoespecializacion_entidadsalud") + "'") + "," + (dkda.o(vars, "codtipoatencion_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codtipoatencion_entidadsalud") + "'") + "," + (dkda.o(vars, "codestadoentidad_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codestadoentidad_entidadsalud") + "'") + "," + (dkda.o(vars, "numactoinscripcion_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "numactoinscripcion_entidadsalud") + "'") + "," + (dkda.o(vars, "fechaactoadmin_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "fechaactoadmin_entidadsalud") + "'") + "," + (dkda.o(vars, "archivofi_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi_entidadsalud") + "')") + "," + (dkda.o(vars, "archivofi2_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi2_entidadsalud") + "')") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "logo_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "logo_entidadsalud") + "')") + "," + (dkda.o(vars, "archivoactoadmin_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivoactoadmin_entidadsalud") + "')") + "," + (dkda.o(vars, "logo_nombre_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "logo_nombre_entidadsalud") + "')") + "," + (dkda.o(vars, "archivoactoadmin_nombre_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivoactoadmin_nombre_entidadsalud") + "')") + "," + (dkda.o(vars, "archivofi1_nombre_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi1_nombre_entidadsalud") + "')") + "," + (dkda.o(vars, "archivofi2_nombre_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi2_nombre_entidadsalud") + "')") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_entidadsalud&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_entidadsalud&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error entidadsalud.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_entidadsalud(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE entidadsalud SET codregimenes = " + (dkda.o(vars, "codregimenes_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codregimenes_entidadsalud") + "'") + ",codentidadsalud = " + (dkda.o(vars, "codentidadsalud_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codentidadsalud_entidadsalud") + "'") + ",codtipoidentidad = " + (dkda.o(empresa_entidadsalud_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_entidadsalud_1, "codtipoidentidad") + "'") + ",codempresa = " + (dkda.o(empresa_entidadsalud_1, "codempresa").equals("") ? null : "'" + dkda.o(empresa_entidadsalud_1, "codempresa") + "'") + ",codtipoentidadsalud = " + (dkda.o(vars, "codtipoentidadsalud_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codtipoentidadsalud_entidadsalud") + "'") + ",codnivelcomplejidad = " + (dkda.o(vars, "codnivelcomplejidad_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codnivelcomplejidad_entidadsalud") + "'") + ",codclasifentidad = " + (dkda.o(vars, "codclasifentidad_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codclasifentidad_entidadsalud") + "'") + ",contacto = " + (dkda.o(vars, "contacto_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "contacto_entidadsalud") + "'") + ",cargocontacto = " + (dkda.o(vars, "cargocontacto_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "cargocontacto_entidadsalud") + "'") + ",lineagratuita = " + (dkda.o(vars, "lineagratuita_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "lineagratuita_entidadsalud") + "'") + ",funcionarios = " + (dkda.o(vars, "funcionarios_entidadsalud").equals("") ? null : dkda.o(vars, "funcionarios_entidadsalud")) + ",codigobarras = " + (dkda.o(vars, "codigobarras_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codigobarras_entidadsalud") + "'") + ",slogan = " + (dkda.o(vars, "slogan_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "slogan_entidadsalud") + "'") + ",codhabilitacion = " + (dkda.o(vars, "codhabilitacion_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codhabilitacion_entidadsalud") + "'") + ",nombrehabilitacion = " + (dkda.o(vars, "nombrehabilitacion_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "nombrehabilitacion_entidadsalud") + "'") + ",codtipoespecializacion = " + (dkda.o(vars, "codtipoespecializacion_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codtipoespecializacion_entidadsalud") + "'") + ",codtipoatencion = " + (dkda.o(vars, "codtipoatencion_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codtipoatencion_entidadsalud") + "'") + ",codestadoentidad = " + (dkda.o(vars, "codestadoentidad_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "codestadoentidad_entidadsalud") + "'") + ",numactoinscripcion = " + (dkda.o(vars, "numactoinscripcion_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "numactoinscripcion_entidadsalud") + "'") + ",fechaactoadmin = " + (dkda.o(vars, "fechaactoadmin_entidadsalud").equals("") ? null : "'" + dkda.o(vars, "fechaactoadmin_entidadsalud") + "'") + ",archivofi = " + (dkda.o(vars, "archivofi_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi_entidadsalud") + "')") + ",archivofi2 = " + (dkda.o(vars, "archivofi2_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi2_entidadsalud") + "')") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",logo = " + (dkda.o(vars, "logo_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "logo_entidadsalud") + "')") + ",archivoactoadmin = " + (dkda.o(vars, "archivoactoadmin_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivoactoadmin_entidadsalud") + "')") + ",logo_nombre = " + (dkda.o(vars, "logo_nombre_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "logo_nombre_entidadsalud") + "')") + ",archivoactoadmin_nombre = " + (dkda.o(vars, "archivoactoadmin_nombre_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivoactoadmin_nombre_entidadsalud") + "')") + ",archivofi1_nombre = " + (dkda.o(vars, "archivofi1_nombre_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi1_nombre_entidadsalud") + "')") + ",archivofi2_nombre = " + (dkda.o(vars, "archivofi2_nombre_entidadsalud").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi2_nombre_entidadsalud") + "')") + " WHERE codregimenes = '" + dkda.o(sel, "codregimenes") + "' AND codentidadsalud = '" + dkda.o(sel, "codentidadsalud") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_entidadsalud&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_entidadsalud&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error entidadsalud.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_entidadsalud(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM entidadsalud WHERE codregimenes = '" + dkda.o(sel, "codregimenes") + "' AND codentidadsalud = '" + dkda.o(sel, "codentidadsalud") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_entidadsalud&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_entidadsalud&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error entidadsalud.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    private boolean existe_entidadsalud() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM entidadsalud  WHERE codregimenes = '" + dkda.o(sel, "codregimenes") + "'" + " AND codentidadsalud = '" + dkda.o(sel, "codentidadsalud") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_entidadsalud() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String obtener_entidadsalud(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT entidadsalud.\"codregimenes\"            AS entidadsalud_codregimenes, "
                    + "       entidadsalud.\"codentidadsalud\"         AS entidadsalud_codentidadsalud, "
                    + "       entidadsalud.\"codtipoidentidad\"        AS entidadsalud_codtipoidentidad, "
                    + "       entidadsalud.\"codempresa\"              AS entidadsalud_codempresa, "
                    + "       entidadsalud.\"codtipoentidadsalud\"     AS "
                    + "       entidadsalud_codtipoentidadsalud, "
                    + "       entidadsalud.\"codnivelcomplejidad\"     AS "
                    + "       entidadsalud_codnivelcomplejidad, "
                    + "       entidadsalud.\"codclasifentidad\"        AS entidadsalud_codclasifentidad, "
                    + "       entidadsalud.\"contacto\"                AS entidadsalud_contacto, "
                    + "       entidadsalud.\"cargocontacto\"           AS entidadsalud_cargocontacto, "
                    + "       entidadsalud.\"lineagratuita\"           AS entidadsalud_lineagratuita, "
                    + "       entidadsalud.\"funcionarios\"            AS entidadsalud_funcionarios, "
                    + "       entidadsalud.\"codigobarras\"            AS entidadsalud_codigobarras, "
                    + "       entidadsalud.\"slogan\"                  AS entidadsalud_slogan, "
                    + "       entidadsalud.\"codhabilitacion\"         AS entidadsalud_codhabilitacion, "
                    + "       entidadsalud.\"nombrehabilitacion\"      AS entidadsalud_nombrehabilitacion "
                    + "       , "
                    + "       entidadsalud.\"codtipoespecializacion\"  AS "
                    + "       entidadsalud_codtipoespecializacion, "
                    + "       entidadsalud.\"codtipoatencion\"         AS entidadsalud_codtipoatencion, "
                    + "       entidadsalud.\"codestadoentidad\"        AS entidadsalud_codestadoentidad, "
                    + "       entidadsalud.\"numactoinscripcion\"      AS entidadsalud_numactoinscripcion "
                    + "       , "
                    + "       entidadsalud.\"fechaactoadmin\"          AS "
                    + "       entidadsalud_fechaactoadmin, "
                    + "       entidadsalud.\"archivofi\"               AS entidadsalud_archivofi, "
                    + "       entidadsalud.\"archivofi2\"              AS entidadsalud_archivofi2, "
                    + "       entidadsalud.\"logo\"                    AS entidadsalud_logo, "
                    + "       entidadsalud.\"archivoactoadmin\"        AS entidadsalud_archivoactoadmin, "
                    + "       entidadsalud.\"logo_nombre\"             AS entidadsalud_logo_nombre, "
                    + "       entidadsalud.\"archivoactoadmin_nombre\" AS "
                    + "       entidadsalud_archivoactoadmin_nombre, "
                    + "       entidadsalud.\"archivofi1_nombre\"       AS entidadsalud_archivofi1_nombre, "
                    + "       entidadsalud.\"archivofi2_nombre\"       AS entidadsalud_archivofi2_nombre, "
                    + "       clasificacionentidad.\"descripcion\"     AS "
                    + "       clasificacionentidad_descripcion, "
                    + "       empresa.\"nombre\"                       AS empresa_nombre, "
                    + "       estadoentidadsalud.\"descripcion\"       AS estadoentidadsalud_descripcion, "
                    + "       nivelcomplejidad.\"descripcion\"         AS nivelcomplejidad_descripcion, "
                    + "       regimen.\"descripcion\"                  AS regimen_descripcion, "
                    + "       tipoatencion.\"descripcion\"             AS tipoatencion_descripcion, "
                    + "       tipoentidadsalud.\"descripcion\"         AS tipoentidadsalud_descripcion, "
                    + "       tipoespecializacionsalud.\"descripcion\" AS "
                    + "       tipoespecializacionsalud_descripcion "
                    + "FROM   \"public\".\"clasificacionentidad\" clasificacionentidad "
                    + "       INNER JOIN \"public\".\"entidadsalud\" entidadsalud "
                    + "         ON clasificacionentidad.\"codclasifentidad\" = "
                    + "            entidadsalud.\"codclasifentidad\" "
                    + "       INNER JOIN \"public\".\"empresa\" empresa "
                    + "         ON entidadsalud.\"codtipoidentidad\" = empresa.\"codtipoidentidad\" "
                    + "            AND empresa.\"codempresa\" = entidadsalud.\"codempresa\" "
                    + "       INNER JOIN \"public\".\"estadoentidadsalud\" estadoentidadsalud "
                    + "         ON entidadsalud.\"codestadoentidad\" = "
                    + "            estadoentidadsalud.\"codestadoentidad\" "
                    + "       INNER JOIN \"public\".\"nivelcomplejidad\" nivelcomplejidad "
                    + "         ON entidadsalud.\"codnivelcomplejidad\" = "
                    + "            nivelcomplejidad.\"codnivelcomplejidad\" "
                    + "       INNER JOIN \"public\".\"regimen\" regimen "
                    + "         ON entidadsalud.\"codregimenes\" = regimen.\"codregimen\" "
                    + "       INNER JOIN \"public\".\"tipoatencion\" tipoatencion "
                    + "         ON entidadsalud.\"codtipoatencion\" = tipoatencion.\"codtipoatencion\" "
                    + "       INNER JOIN \"public\".\"tipoentidadsalud\" tipoentidadsalud "
                    + "         ON entidadsalud.\"codtipoentidadsalud\" = "
                    + "            tipoentidadsalud.\"codtipoentidadsalud\" "
                    + "       INNER JOIN \"public\".\"tipoespecializacionsalud\" tipoespecializacionsalud "
                    + "         ON entidadsalud.\"codtipoespecializacion\" = "
                    + "            tipoespecializacionsalud.\"codtipoespecializacion\" "
                    + "WHERE entidadsalud.codregimenes = '" + dkda.o(sel, "codregimenes") + "' "
                    + "AND entidadsalud.codentidadsalud = '" + dkda.o(sel, "codentidadsalud") + "' ";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            
            info += "combo|#codregimenes_entidadsalud|" + rs.getString("entidadsalud_codregimenes")
                    + "|llenarCombo('codregimenes_entidadsalud', '"
                    + rs.getString("entidadsalud_codregimenes") + "', '"
                    + rs.getString("regimen_descripcion") + "'):_";
            
            respuesta = "opcion=obtener_entidadsalud&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_entidadsalud&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error entidadsalud - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_entidadsalud() {
        String direccion = "opcion=registrar_entidadsalud&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_entidadsalud();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codregimenes").toString().equals(dkda.o(vars, "codregimenes_entidadsalud")) && dkda.o(sel, "codentidadsalud").toString().equals(dkda.o(vars, "codentidadsalud_entidadsalud"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codregimenes_entidadsalud").isEmpty()) {
            error = "Codigo Regimen: no puede ser vacio.";
        } else if (dkda.o(vars, "codentidadsalud_entidadsalud").isEmpty()) {
            error = "Codigo Entidad Salud: no puede ser vacio.";
        } else if (dkda.o(empresa_entidadsalud_1, "codtipoidentidad").isEmpty()) {
            error = "Empresa: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoentidadsalud_entidadsalud").isEmpty()) {
            error = "Codigo Tipo Entidad Salud: no puede ser vacio.";
        } else if (dkda.o(vars, "codnivelcomplejidad_entidadsalud").isEmpty()) {
            error = "Codigo Nivel Complejidad: no puede ser vacio.";
        } else if (dkda.o(vars, "codclasifentidad_entidadsalud").isEmpty()) {
            error = "Codigo Clasificacion Entidad Salud: no puede ser vacio.";
        } else if (dkda.o(vars, "contacto_entidadsalud").isEmpty()) {
            error = "Nombre del contacto: no puede ser vacio.";
        } else if (dkda.o(vars, "cargocontacto_entidadsalud").isEmpty()) {
            error = "Nombre Cargo Contacto: no puede ser vacio.";
        } else if (dkda.o(vars, "lineagratuita_entidadsalud").isEmpty()) {
            error = "Numero Telefonico Linea Gratuita: no puede ser vacio.";
        } else if (dkda.o(vars, "funcionarios_entidadsalud").isEmpty()) {
            error = "Numero Funcionarios: no puede ser vacio.";
        } else if (dkda.o(vars, "codigobarras_entidadsalud").isEmpty()) {
            error = "Codigo Barras: no puede ser vacio.";
        } else if (dkda.o(vars, "slogan_entidadsalud").isEmpty()) {
            error = "Slogan Empresa: no puede ser vacio.";
        } else if (dkda.o(vars, "codhabilitacion_entidadsalud").isEmpty()) {
            error = "Codigo Habilitacion: no puede ser vacio.";
        } else if (dkda.o(vars, "codhabilitacion_entidadsalud").isEmpty()) {
            error = "Codigo Habilitacion: no puede ser vacio.";
        } else if (dkda.o(vars, "nombrehabilitacion_entidadsalud").isEmpty()) {
            error = "Nombre Habilitacion: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoespecializacion_entidadsalud").isEmpty()) {
            error = "Codigo Tipo Especializacion Salud: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoatencion_entidadsalud").isEmpty()) {
            error = "Codigo Tipo Atencion Salud: no puede ser vacio.";
        } else if (dkda.o(vars, "codestadoentidad_entidadsalud").isEmpty()) {
            error = "Codigo Estado Entidad Salud: no puede ser vacio.";
        } else if (dkda.o(vars, "numactoinscripcion_entidadsalud").isEmpty()) {
            error = "Numero Acto Inscripcion: no puede ser vacio.";
        } else if (dkda.o(vars, "fechaactoadmin_entidadsalud").isEmpty()) {
            error = "Fecha Acto Administrativo: no puede ser vacio.";
        } else if (dkda.o(vars, "archivofi_entidadsalud").isEmpty()) {
            error = "Archivo Físico: no puede ser vacio.";
        } else if (dkda.o(vars, "archivofi2_entidadsalud").isEmpty()) {
            error = "Archivo Físico 2: no puede ser vacio.";
        } else if (dkda.o(vars, "logo_entidadsalud").isEmpty()) {
            error = "Logo: no puede ser vacio.";
        } else if (dkda.o(vars, "archivoactoadmin_entidadsalud").isEmpty()) {
            error = "Archivo Acto Admin: no puede ser vacio.";
        } else if (dkda.o(vars, "cargocontacto_entidadsalud").length() > 30) {
            error = "Nombre Cargo Contacto: Valor demasiado Largo.";
        } else if (dkda.o(vars, "lineagratuita_entidadsalud").length() > 20) {
            error = "Numero Telefonico Linea Gratuita: Valor demasiado Largo.";
        } else if (dkda.o(vars, "funcionarios_entidadsalud").length() > 6) {
            error = "Numero Funcionarios: Valor demasiado Largo.";
        } else if (dkda.o(vars, "codigobarras_entidadsalud").length() > 70) {
            error = "Codigo Barras: Valor demasiado Largo.";
        } else if (dkda.o(vars, "slogan_entidadsalud").length() > 200) {
            error = "Slogan Empresa: Valor demasiado Largo.";
        } else if (dkda.o(vars, "codhabilitacion_entidadsalud").length() > 18) {
            error = "Codigo Habilitacion: Valor demasiado Largo.";
        } else if (dkda.o(vars, "codhabilitacion_entidadsalud").length() > 18) {
            error = "Codigo Habilitacion: Valor demasiado Largo.";
        } else if (dkda.o(vars, "nombrehabilitacion_entidadsalud").length() > 120) {
            error = "Nombre Habilitacion: Valor demasiado Largo.";
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