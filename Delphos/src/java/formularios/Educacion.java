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

public class Educacion extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, empresa_escolaridad_1, escolaridad_escolaridadnovedad_1, empresa_escolaridadnovedad_1,
            escolaridad_escregperiodico_1, firmasautorizadas_escregperiodico_1,
            escregperiodico_escolaridadcumplimiento_1, requisitos_escolaridadcumplimiento_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());

        empresa_escolaridad_1 = fun.map(dkda.o(vars, "empresa_escolaridad_1").toString());
        escolaridad_escolaridadnovedad_1 = fun.map(dkda.o(vars, "escolaridad_escolaridadnovedad_1").toString());
        empresa_escolaridadnovedad_1 = fun.map(dkda.o(vars, "empresa_escolaridadnovedad_1").toString());
        escolaridad_escregperiodico_1 = fun.map(dkda.o(vars, "escolaridad_escregperiodico_1").toString());
        firmasautorizadas_escregperiodico_1 = fun.map(dkda.o(vars, "firmasautorizadas_escregperiodico_1").toString());
        escregperiodico_escolaridadcumplimiento_1 = fun.map(dkda.o(vars, "escregperiodico_escolaridadcumplimiento_1").toString());
        requisitos_escolaridadcumplimiento_1 = fun.map(dkda.o(vars, "requisitos_escolaridadcumplimiento_1").toString());

        try {
            String opcion = dkda.o(vars, "accion").toString();
            String pestana = dkda.o(vars, "pestana").toString();
            respuesta = "";

            if (pestana.equals("escolaridad") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_escolaridad();
            }
            if (opcion.equals("Registrar") && pestana.equals("escolaridad") && respuesta.length() == 0) {
                out.println(registrar_escolaridad(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("escolaridad") && respuesta.length() == 0) {
                out.println(actualizar_escolaridad(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("escolaridad") && respuesta.length() == 0) {
                out.println(eliminar_escolaridad(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("escolaridad") && respuesta.length() == 0) {
                out.println(obtener_escolaridad(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("escolaridadnovedad") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_escolaridadnovedad();
            }
            if (opcion.equals("Registrar") && pestana.equals("escolaridadnovedad") && respuesta.length() == 0) {
                out.println(registrar_escolaridadnovedad(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("escolaridadnovedad") && respuesta.length() == 0) {
                out.println(actualizar_escolaridadnovedad(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("escolaridadnovedad") && respuesta.length() == 0) {
                out.println(eliminar_escolaridadnovedad(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("escolaridadnovedad") && respuesta.length() == 0) {
                out.println(obtener_escolaridadnovedad(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("escregperiodico") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_escregperiodico();
            }
            if (opcion.equals("Registrar") && pestana.equals("escregperiodico") && respuesta.length() == 0) {
                out.println(registrar_escregperiodico(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("escregperiodico") && respuesta.length() == 0) {
                out.println(actualizar_escregperiodico(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("escregperiodico") && respuesta.length() == 0) {
                out.println(eliminar_escregperiodico(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("escregperiodico") && respuesta.length() == 0) {
                out.println(obtener_escregperiodico(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("escolaridadcumplimiento") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_escolaridadcumplimiento();
            }
            if (opcion.equals("Registrar") && pestana.equals("escolaridadcumplimiento") && respuesta.length() == 0) {
                out.println(registrar_escolaridadcumplimiento(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("escolaridadcumplimiento") && respuesta.length() == 0) {
                out.println(actualizar_escolaridadcumplimiento(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("escolaridadcumplimiento") && respuesta.length() == 0) {
                out.println(eliminar_escolaridadcumplimiento(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("escolaridadcumplimiento") && respuesta.length() == 0) {
                out.println(obtener_escolaridadcumplimiento(con, dkda.o(vars, "codigo").toString()));
            }
            if (respuesta.length() > 0) {
                out.println(respuesta);
            }
        } finally {
            out.close();
        }
    }

    public String registrar_escolaridad(ConexionBaseDatos con) {
        System.out.println("registrar_escolaridad");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO escolaridad (codtipoidentidadins,codempresa,codtipoidentidad,escidentific,escvigencia,escfecharegi,escfechamatr,escnumermatr,escgracodigo,escprofesor,escestcodigo,escobservaci,ususiscodigo,fecharegistro,escarchimatr,escarchimatr_nombre,escarchicert,escarchicert_nombre) VALUES (" + (dkda.o(empresa_escolaridad_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_escolaridad_1, "codtipoidentidad") + "'") + "," + (dkda.o(empresa_escolaridad_1, "codempresa").equals("") ? null : "'" + dkda.o(empresa_escolaridad_1, "codempresa") + "'") + "," + (dkda.o(vars, "codtipoidentidad_escolaridad").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_escolaridad") + "'") + "," + (dkda.o(vars, "escidentific_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escidentific_escolaridad") + "'") + "," + (dkda.o(vars, "escvigencia_escolaridad").equals("") ? null : dkda.o(vars, "escvigencia_escolaridad")) + "," + (dkda.o(vars, "escfecharegi_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escfecharegi_escolaridad") + "'") + "," + (dkda.o(vars, "escfechamatr_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escfechamatr_escolaridad") + "'") + "," + (dkda.o(vars, "escnumermatr_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escnumermatr_escolaridad") + "'") + "," + (dkda.o(vars, "escgracodigo_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escgracodigo_escolaridad") + "'") + "," + (dkda.o(vars, "escprofesor_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escprofesor_escolaridad") + "'") + "," + (dkda.o(vars, "escestcodigo_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escestcodigo_escolaridad") + "'") + "," + (dkda.o(vars, "escobservaci_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escobservaci_escolaridad") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "escarchimatr_escolaridad").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "escarchimatr_escolaridad") + "')") + "," + (dkda.o(vars, "escarchimatr_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escarchimatr_escolaridad") + "'") + "," + (dkda.o(vars, "escarchicert_escolaridad").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "escarchicert_escolaridad") + "')") + "," + (dkda.o(vars, "escarchicert_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escarchicert_escolaridad") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_escolaridad&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_escolaridad&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error escolaridad.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_escolaridad(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE escolaridad SET codtipoidentidadins = " + (dkda.o(empresa_escolaridad_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_escolaridad_1, "codtipoidentidad") + "'") + ",codempresa = " + (dkda.o(empresa_escolaridad_1, "codempresa").equals("") ? null : "'" + dkda.o(empresa_escolaridad_1, "codempresa") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_escolaridad").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_escolaridad") + "'") + ",escidentific = " + (dkda.o(vars, "escidentific_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escidentific_escolaridad") + "'") + ",escvigencia = " + (dkda.o(vars, "escvigencia_escolaridad").equals("") ? null : dkda.o(vars, "escvigencia_escolaridad")) + ",escfecharegi = " + (dkda.o(vars, "escfecharegi_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escfecharegi_escolaridad") + "'") + ",escfechamatr = " + (dkda.o(vars, "escfechamatr_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escfechamatr_escolaridad") + "'") + ",escnumermatr = " + (dkda.o(vars, "escnumermatr_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escnumermatr_escolaridad") + "'") + ",escgracodigo = " + (dkda.o(vars, "escgracodigo_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escgracodigo_escolaridad") + "'") + ",escprofesor = " + (dkda.o(vars, "escprofesor_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escprofesor_escolaridad") + "'") + ",escestcodigo = " + (dkda.o(vars, "escestcodigo_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escestcodigo_escolaridad") + "'") + ",escobservaci = " + (dkda.o(vars, "escobservaci_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escobservaci_escolaridad") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",escarchimatr = " + (dkda.o(vars, "escarchimatr_escolaridad").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "escarchimatr_escolaridad") + "')") + ",escarchimatr_nombre = " + (dkda.o(vars, "escarchimatr_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escarchimatr_escolaridad") + "'") + ",escarchicert = " + (dkda.o(vars, "escarchicert_escolaridad").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "escarchicert_escolaridad") + "')") + ",escarchicert_nombre = " + (dkda.o(vars, "escarchicert_escolaridad").equals("") ? null : "'" + dkda.o(vars, "escarchicert_escolaridad") + "'") + " WHERE codtipoidentidadins = '" + dkda.o(sel, "codtipoidentidadins") + "' AND codempresa = '" + dkda.o(sel, "codempresa") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND escidentific = '" + dkda.o(sel, "escidentific") + "' AND escvigencia = " + dkda.o(sel, "escvigencia") + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_escolaridad&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_escolaridad&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error escolaridad.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_escolaridad(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM escolaridad WHERE codtipoidentidadins = '" + dkda.o(sel, "codtipoidentidadins") + "' AND codempresa = '" + dkda.o(sel, "codempresa") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND escidentific = '" + dkda.o(sel, "escidentific") + "' AND escvigencia = " + dkda.o(sel, "escvigencia") + " ");
            stmt.execute();
            respuesta = "opcion=eliminar_escolaridad&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_escolaridad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error escolaridad.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_escolaridad(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT escolaridad.\"codtipoidentidadins\"     AS escolaridad_codtipoidentidadins, "
                    + "       escolaridad.\"codempresa\"              AS escolaridad_codempresa, "
                    + "       escolaridad.\"codtipoidentidad\"        AS escolaridad_codtipoidentidad, "
                    + "       escolaridad.\"escidentific\"            AS escolaridad_escidentific, "
                    + "       escolaridad.\"escvigencia\"             AS escolaridad_escvigencia, "
                    + "       escolaridad.\"escfecharegi\"            AS escolaridad_escfecharegi, "
                    + "       escolaridad.\"escfechamatr\"            AS escolaridad_escfechamatr, "
                    + "       escolaridad.\"escnumermatr\"            AS escolaridad_escnumermatr, "
                    + "       escolaridad.\"escgracodigo\"            AS escolaridad_escgracodigo, "
                    + "       escolaridad.\"escprofesor\"             AS escolaridad_escprofesor, "
                    + "       escolaridad.\"escestcodigo\"            AS escolaridad_escestcodigo, "
                    + "       escolaridad.\"escobservaci\"            AS escolaridad_escobservaci, "
                    + "       escolaridad.\"escarchimatr\"            AS escolaridad_escarchimatr, "
                    + "       escolaridad.\"escarchimatr_nombre\"     AS escolaridad_escarchimatr_nombre, "
                    + " CASE WHEN escolaridad.escarchimatr_nombre  IS NULL OR escolaridad.escarchimatr_nombre  = '' THEN 0 "
                    + " ELSE lo_export(escolaridad.escarchimatr, '" + fun.temp(request) + "' || escolaridad.escarchimatr_nombre ) END, "
                    + "       escolaridad.\"escarchicert\"            AS escolaridad_escarchicert, "
                    + "       escolaridad.\"escarchicert_nombre\"     AS escolaridad_escarchicert_nombre, "
                    + " CASE WHEN escolaridad.escarchicert_nombre  IS NULL OR escolaridad.escarchicert_nombre  = '' THEN 0 "
                    + " ELSE lo_export(escolaridad.escarchicert, '" + fun.temp(request) + "' || escolaridad.escarchicert_nombre ) END, "
                    + "       escolaridadestado.\"escestcodigo\"      AS escolaridadestado_escestcodigo, "
                    + "       escolaridadestado.\"escescdescri\"      AS escolaridadestado_escescdescri, "
                    + "       escolaridadgrado.\"escgracodigo\"       AS escolaridadgrado_escgracodigo, "
                    + "       escolaridadgrado.\"escgradescri\"       AS escolaridadgrado_escgradescri, "
                    + "       tipoidentificacion.\"codtipoidentidad\" AS "
                    + "       tipoidentificacion_codtipoidentidad, "
                    + "       tipoidentificacion.\"descripcion\"      AS tipoidentificacion_descripcion, "
                    + "       empresa.\"codtipoidentidad\"            AS empresa_codtipoidentidad, "
                    + "       empresa.\"codempresa\"                  AS empresa_codempresa, "
                    + "       empresa.\"nombre\"                      AS empresa_nombre "
                    + "FROM   \"public\".\"empresa\" empresa "
                    + "       INNER JOIN \"public\".\"escolaridad\" escolaridad "
                    + "         ON empresa.\"codtipoidentidad\" = escolaridad.\"codtipoidentidadins\" "
                    + "            AND empresa.\"codempresa\" = escolaridad.\"codempresa\" "
                    + "       INNER JOIN \"public\".\"escolaridadestado\" escolaridadestado "
                    + "         ON escolaridad.\"escestcodigo\" = escolaridadestado.\"escestcodigo\" "
                    + "       INNER JOIN \"public\".\"escolaridadgrado\" escolaridadgrado "
                    + "         ON escolaridad.\"escgracodigo\" = escolaridadgrado.\"escgracodigo\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON escolaridad.\"codtipoidentidad\" = "
                    + "            tipoidentificacion.\"codtipoidentidad\"  WHERE escolaridad.codtipoidentidadins = '" + dkda.o(sel, "codtipoidentidadins") + "' "
                    + "AND escolaridad.codempresa = '" + dkda.o(sel, "codempresa") + "'"
                    + " AND escolaridad.codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND escolaridad.escidentific = '" + dkda.o(sel, "escidentific") + "' "
                    + "AND escolaridad.escvigencia = " + dkda.o(sel, "escvigencia") + " ";
            System.out.println(sql);

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#escobservaci_escolaridad|" + (rs.getString("escolaridad_escobservaci") == null ? "" : rs.getString("escolaridad_escobservaci")) + ":_";

            info += "text|#escarchicert_escolaridad|" + (rs.getString("escolaridad_escarchicert_nombre") == null ? "" : rs.getString("escolaridad_escarchicert_nombre")) + ":_";

            info += "text|#escarchimatr_escolaridad|" + (rs.getString("escolaridad_escarchimatr_nombre") == null ? "" : rs.getString("escolaridad_escarchimatr_nombre")) + ":_";

            info += "combo|#escestcodigo_escolaridad|" + rs.getString("escolaridadestado_escestcodigo") + "|llenarCombo('escestcodigo_escolaridad', '"
                    + rs.getString("escolaridadestado_escestcodigo") + "', '" + rs.getString("escolaridadestado_escescdescri") + "'):_";

            info += "text|#escprofesor_escolaridad|" + (rs.getString("escolaridad_escprofesor") == null ? "" : rs.getString("escolaridad_escprofesor")) + ":_";

            info += "combo|#escgracodigo_escolaridad|" + rs.getString("escolaridadgrado_escgracodigo") + "|llenarCombo('escgracodigo_escolaridad', '"
                    + rs.getString("escolaridadgrado_escgracodigo") + "', '" + rs.getString("escolaridadgrado_escgradescri") + "'):_";

            info += "text|#escnumermatr_escolaridad|" + (rs.getString("escolaridad_escnumermatr") == null ? "" : rs.getString("escolaridad_escnumermatr")) + ":_";

            info += "text|#_fecha_escfechamatr_escolaridad|" + (rs.getString("escolaridad_escfechamatr") == null ? "" : rs.getString("escolaridad_escfechamatr")) + ":_";

            info += "text|#_fecha_escfecharegi_escolaridad|" + (rs.getString("escolaridad_escfecharegi") == null ? "" : rs.getString("escolaridad_escfecharegi")) + ":_";

            info += "text|#escvigencia_escolaridad|" + (rs.getString("escolaridad_escvigencia") == null ? "" : rs.getString("escolaridad_escvigencia")) + ":_";

            info += "text|#escidentific_escolaridad|" + (rs.getString("escolaridad_escidentific") == null ? "" : rs.getString("escolaridad_escidentific")) + ":_";

            info += "combo|#codtipoidentidad_escolaridad|" + rs.getString("tipoidentificacion_codtipoidentidad") + "|llenarCombo('codtipoidentidad_escolaridad', '"
                    + rs.getString("tipoidentificacion_codtipoidentidad") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";

            info += "combo|#empresa_escolaridad_1|" + "empresa   codtipoidentidad  " + rs.getString("empresa_codtipoidentidad") + "  "
                    + " codempresa  " + rs.getString("empresa_codempresa") + "|llenarCombo('empresa_escolaridad_1', '"
                    + "empresa   codtipoidentidad  " + rs.getString("empresa_codtipoidentidad") + "   codempresa  "
                    + rs.getString("empresa_codempresa") + "', '" + rs.getString("empresa_nombre") + "'):_";

            respuesta = "opcion=obtener_escolaridad&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_escolaridad&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error escolaridad - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_escolaridad() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM escolaridad  WHERE codtipoidentidadins = '" + dkda.o(empresa_escolaridad_1, "codtipoidentidad")
                    + "'" + " AND codempresa = '" + dkda.o(empresa_escolaridad_1, "codempresa") + "'" + " AND codtipoidentidad = '" + dkda.o(vars, "codtipoidentidad_escolaridad") + "'"
                    + " AND escidentific = '" + dkda.o(vars, "escidentific_escolaridad") + "'" + " AND escvigencia = " + dkda.o(vars, "escvigencia_escolaridad") + "";
            pQuery = conexion.prepareStatement(sql);
            System.out.print(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_escolaridad() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_escolaridad() {
        String direccion = "opcion=registrar_escolaridad&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_escolaridad();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codtipoidentidadins").toString().equals(dkda.o(vars, "codtipoidentidadins_escolaridad")) && dkda.o(sel, "codempresa").toString().equals(dkda.o(vars, "codempresa_escolaridad")) && dkda.o(sel, "codtipoidentidad").toString().equals(dkda.o(vars, "codtipoidentidad_escolaridad")) && dkda.o(sel, "escidentific").toString().equals(dkda.o(vars, "escidentific_escolaridad")) && dkda.o(sel, "escvigencia").toString().equals(dkda.o(vars, "escvigencia_escolaridad"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(empresa_escolaridad_1, "codempresa").isEmpty()) {
            error = "Tipo Identificacion Institución Educativa: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_escolaridad").isEmpty()) {
            error = "Tipo Identificaci&oacute;n Estudiante: no puede ser vacio.";
        } else if (dkda.o(vars, "escidentific_escolaridad").isEmpty()) {
            error = "Identificación Estudiante: no puede ser vacio.";
        } else if (dkda.o(vars, "escvigencia_escolaridad").isEmpty()) {
            error = "A&ntilde;o Vigencia Escolaridad: no puede ser vacio.";
        } else if (dkda.o(vars, "escfecharegi_escolaridad").isEmpty()) {
            error = "Fecha Registro: no puede ser vacio.";
        } else if (dkda.o(vars, "escfechamatr_escolaridad").isEmpty()) {
            error = "Fecha Matricula: no puede ser vacio.";
        } else if (dkda.o(vars, "escnumermatr_escolaridad").isEmpty()) {
            error = "N&uacute;mero de Matricula: no puede ser vacio.";
        } else if (dkda.o(vars, "escgracodigo_escolaridad").isEmpty()) {
            error = "C&oacute;digo Grado Escolaridad: no puede ser vacio.";
        } else if (dkda.o(vars, "escprofesor_escolaridad").isEmpty()) {
            error = "Profesor Coordinador Referente: no puede ser vacio.";
        } else if (dkda.o(vars, "escestcodigo_escolaridad").isEmpty()) {
            error = "C&oacute;digo Estado Escolaridad: no puede ser vacio.";
        } else if (dkda.o(vars, "escarchimatr_escolaridad").isEmpty()) {
            error = "Archivo Documento Matricula: no puede ser vacio.";
        } else if (dkda.o(vars, "escarchicert_escolaridad").isEmpty()) {
            error = "Archivo Documento Certtificado: no puede ser vacio.";
        } else if (dkda.o(vars, "escobservaci_escolaridad").isEmpty()) {
            error = "Observaciones Escolaridad: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "escidentific_escolaridad"))) {
            error = "Identificación Estudiante: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "escvigencia_escolaridad"))) {
            error = "A&ntilde;o Vigencia Escolaridad: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "escidentific_escolaridad").length() > 10) {
            error = "Identificación Estudiante: Valor demasiado Largo.";
        } else if (dkda.o(vars, "escvigencia_escolaridad").length() > 4) {
            error = "A&ntilde;o Vigencia Escolaridad: Valor demasiado Largo.";
        } else if (dkda.o(vars, "escfechamatr_escolaridad").length() > 18) {
            error = "Fecha Matricula: Valor demasiado Largo.";
        } else if (dkda.o(vars, "escnumermatr_escolaridad").length() > 80) {
            error = "N&uacute;mero de Matricula: Valor demasiado Largo.";
        } else if (dkda.o(vars, "escarchicert_escolaridad").length() > 200) {
            error = "Archivo Documento Certtificado: Valor demasiado Largo.";
        } else if (dkda.o(vars, "escobservaci_escolaridad").length() > 400) {
            error = "Observaciones Escolaridad: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_escolaridadnovedad(ConexionBaseDatos con) {
        System.out.println("registrar_escolaridadnovedad");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO escolaridadnovedad (codtipoideninsact,codempresaact,codtipoidentidadest,escidentificest,escvigencia,escnovconsec,escnovfecha,codtipoidentidad,codempresa,codtiponovedad,escnovobserv,ususiscodigo,fecharegistro,escnovarchi,escnovarchi_nombre) VALUES (" + (dkda.o(escolaridad_escolaridadnovedad_1, "codtipoidentidadins").equals("") ? null : "'" + dkda.o(escolaridad_escolaridadnovedad_1, "codtipoidentidadins") + "'") + "," + (dkda.o(escolaridad_escolaridadnovedad_1, "codempresa").equals("") ? null : "'" + dkda.o(escolaridad_escolaridadnovedad_1, "codempresa") + "'") + "," + (dkda.o(escolaridad_escolaridadnovedad_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(escolaridad_escolaridadnovedad_1, "codtipoidentidad") + "'") + "," + (dkda.o(escolaridad_escolaridadnovedad_1, "escidentific").equals("") ? null : "'" + dkda.o(escolaridad_escolaridadnovedad_1, "escidentific") + "'") + "," + (dkda.o(escolaridad_escolaridadnovedad_1, "escvigencia").equals("") ? null : dkda.o(escolaridad_escolaridadnovedad_1, "escvigencia")) + "," + (dkda.o(vars, "escnovconsec_escolaridadnovedad").equals("") ? null : dkda.o(vars, "escnovconsec_escolaridadnovedad")) + "," + (dkda.o(vars, "escnovfecha_escolaridadnovedad").equals("") ? null : "'" + dkda.o(vars, "escnovfecha_escolaridadnovedad") + "'") + "," + (dkda.o(empresa_escolaridadnovedad_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_escolaridadnovedad_1, "codtipoidentidad") + "'") + "," + (dkda.o(empresa_escolaridadnovedad_1, "codempresa").equals("") ? null : "'" + dkda.o(empresa_escolaridadnovedad_1, "codempresa") + "'") + "," + (dkda.o(vars, "codtiponovedad_escolaridadnovedad").equals("") ? null : "'" + dkda.o(vars, "codtiponovedad_escolaridadnovedad") + "'") + "," + (dkda.o(vars, "escnovobserv_escolaridadnovedad").equals("") ? null : "'" + dkda.o(vars, "escnovobserv_escolaridadnovedad") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "escnovarchi_escolaridadnovedad").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "escnovarchi_escolaridadnovedad") + "')") + "," + (dkda.o(vars, "escnovarchi_escolaridadnovedad").equals("") ? null : "'" + dkda.o(vars, "escnovarchi_escolaridadnovedad") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_escolaridadnovedad&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_escolaridadnovedad&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error escolaridadnovedad.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_escolaridadnovedad(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE escolaridadnovedad SET codtipoideninsact = " + (dkda.o(escolaridad_escolaridadnovedad_1, "codtipoidentidadins").equals("") ? null : "'" + dkda.o(escolaridad_escolaridadnovedad_1, "codtipoidentidadins") + "'") + ",codempresaact = " + (dkda.o(escolaridad_escolaridadnovedad_1, "codempresa").equals("") ? null : "'" + dkda.o(escolaridad_escolaridadnovedad_1, "codempresa") + "'") + ",codtipoidentidadest = " + (dkda.o(escolaridad_escolaridadnovedad_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(escolaridad_escolaridadnovedad_1, "codtipoidentidad") + "'") + ",escidentificest = " + (dkda.o(escolaridad_escolaridadnovedad_1, "escidentific").equals("") ? null : "'" + dkda.o(escolaridad_escolaridadnovedad_1, "escidentific") + "'") + ",escvigencia = " + (dkda.o(escolaridad_escolaridadnovedad_1, "escvigencia").equals("") ? null : dkda.o(escolaridad_escolaridadnovedad_1, "escvigencia")) + ",escnovconsec = " + (dkda.o(vars, "escnovconsec_escolaridadnovedad").equals("") ? null : dkda.o(vars, "escnovconsec_escolaridadnovedad")) + ",escnovfecha = " + (dkda.o(vars, "escnovfecha_escolaridadnovedad").equals("") ? null : "'" + dkda.o(vars, "escnovfecha_escolaridadnovedad") + "'") + ",codtipoidentidad = " + (dkda.o(empresa_escolaridadnovedad_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_escolaridadnovedad_1, "codtipoidentidad") + "'") + ",codempresa = " + (dkda.o(empresa_escolaridadnovedad_1, "codempresa").equals("") ? null : "'" + dkda.o(empresa_escolaridadnovedad_1, "codempresa") + "'") + ",codtiponovedad = " + (dkda.o(vars, "codtiponovedad_escolaridadnovedad").equals("") ? null : "'" + dkda.o(vars, "codtiponovedad_escolaridadnovedad") + "'") + ",escnovobserv = " + (dkda.o(vars, "escnovobserv_escolaridadnovedad").equals("") ? null : "'" + dkda.o(vars, "escnovobserv_escolaridadnovedad") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",escnovarchi = " + (dkda.o(vars, "escnovarchi_escolaridadnovedad").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "escnovarchi_escolaridadnovedad") + "')") + ",escnovarchi_nombre = " + (dkda.o(vars, "escnovarchi_escolaridadnovedad").equals("") ? null : "'" + dkda.o(vars, "escnovarchi_escolaridadnovedad") + "'") + " WHERE codtipoideninsact = '" + dkda.o(sel, "codtipoideninsact") + "' AND codempresaact = '" + dkda.o(sel, "codempresaact") + "' AND codtipoidentidadest = '" + dkda.o(sel, "codtipoidentidadest") + "' AND escidentificest = '" + dkda.o(sel, "escidentificest") + "' AND escvigencia = " + dkda.o(sel, "escvigencia") + " AND escnovconsec = '" + dkda.o(sel, "escnovconsec") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_escolaridadnovedad&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_escolaridadnovedad&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error escolaridadnovedad.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_escolaridadnovedad(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM escolaridadnovedad WHERE codtipoideninsact = '" + dkda.o(sel, "codtipoideninsact") + "' AND codempresaact = '" + dkda.o(sel, "codempresaact") + "' AND codtipoidentidadest = '" + dkda.o(sel, "codtipoidentidadest") + "' AND escidentificest = '" + dkda.o(sel, "escidentificest") + "' AND escvigencia = " + dkda.o(sel, "escvigencia") + " AND escnovconsec = '" + dkda.o(sel, "escnovconsec") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_escolaridadnovedad&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_escolaridadnovedad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error escolaridadnovedad.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_escolaridadnovedad(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;

            String sql = ""
                    + "SELECT escolaridadnovedad.\"codtipoideninsact\"   AS "
                    + "       escolaridadnovedad_codtipoideninsact "
                    + "       , "
                    + "       escolaridadnovedad.\"codempresaact\"       AS "
                    + "       escolaridadnovedad_codempresaact, "
                    + "       escolaridadnovedad.\"codtipoidentidadest\" AS "
                    + "       escolaridadnovedad_codtipoidentidadest, "
                    + "       escolaridadnovedad.\"escidentificest\"     AS "
                    + "       escolaridadnovedad_escidentificest, "
                    + "       escolaridadnovedad.\"escvigencia\"         AS "
                    + "       escolaridadnovedad_escvigencia, "
                    + "       escolaridadnovedad.\"escnovconsec\"        AS "
                    + "       escolaridadnovedad_escnovconsec, "
                    + "       escolaridadnovedad.\"escnovfecha\"         AS "
                    + "       escolaridadnovedad_escnovfecha, "
                    + "       escolaridadnovedad.\"codtipoidentidad\"    AS "
                    + "       escolaridadnovedad_codtipoidentidad, "
                    + "       escolaridadnovedad.\"codempresa\"          AS escolaridadnovedad_codempresa "
                    + "       , "
                    + "       escolaridadnovedad.\"codtiponovedad\"      AS "
                    + "       escolaridadnovedad_codtiponovedad, "
                    + "       escolaridadnovedad.\"escnovobserv\"        AS "
                    + "       escolaridadnovedad_escnovobserv, "
                    + "       escolaridadnovedad.\"escnovarchi\"         AS "
                    + "       escolaridadnovedad_escnovarchi, "
                    + "       escolaridadnovedad.\"escnovarchi_nombre\"  AS "
                    + "       escolaridadnovedad_escnovarchi_nombre, "
                    + "CASE WHEN escolaridadnovedad.escnovarchi_nombre  IS NULL OR escolaridadnovedad.escnovarchi_nombre  = '' THEN 0 "
                    + "ELSE lo_export(escolaridadnovedad.escnovarchi, '" + fun.temp(request) + "' || escolaridadnovedad.escnovarchi_nombre ) END, "
                    + "       tiponovedad.\"codtiponovedad\"             AS tiponovedad_codtiponovedad, "
                    + "       tiponovedad.\"descripcion\"                AS tiponovedad_descripcion, "
                    + "       empresa.\"codempresa\"                     AS empresa_codempresa, "
                    + "       empresa.\"codtipoidentidad\"               AS empresa_codtipoidentidad, "
                    + "       empresa.\"nombre\"                         AS empresa_nombre, "
                    + "       escolaridad.\"codtipoidentidadins\"        AS "
                    + "       escolaridad_codtipoidentidadins, "
                    + "       escolaridad.\"codempresa\"                 AS escolaridad_codempresa, "
                    + "       escolaridad.\"codtipoidentidad\"           AS escolaridad_codtipoidentidad, "
                    + "       escolaridad.\"escidentific\"               AS escolaridad_escidentific, "
                    + "       escolaridad.\"escvigencia\"                AS escolaridad_escvigencia "
                    + "FROM   \"public\".\"empresa\" empresa "
                    + "       INNER JOIN \"public\".\"escolaridadnovedad\" escolaridadnovedad "
                    + "         ON empresa.\"codtipoidentidad\" = escolaridadnovedad.\"codtipoidentidad\" "
                    + "            AND empresa.\"codempresa\" = escolaridadnovedad.\"codempresa\" "
                    + "       INNER JOIN \"public\".\"escolaridad\" escolaridad "
                    + "         ON escolaridadnovedad.\"codtipoideninsact\" = "
                    + "            escolaridad.\"codtipoidentidadins\" "
                    + "            AND escolaridad.\"escvigencia\" = escolaridadnovedad.\"escvigencia\" "
                    + "            AND escolaridad.\"codempresa\" = escolaridadnovedad.\"codempresaact\" "
                    + "            AND escolaridad.\"escidentific\" = "
                    + "                escolaridadnovedad.\"escidentificest\" "
                    + "            AND escolaridad.\"codtipoidentidad\" = "
                    + "                escolaridadnovedad.\"codtipoidentidadest\" "
                    + "       INNER JOIN \"public\".\"tiponovedad\" tiponovedad "
                    + "         ON escolaridadnovedad.\"codtiponovedad\" = tiponovedad.\"codtiponovedad\" WHERE "
                    + "escolaridadnovedad.codtipoideninsact = '" + dkda.o(sel, "codtipoideninsact") + "' AND escolaridadnovedad.codempresaact = '"
                    + dkda.o(sel, "codempresaact") + "' "
                    + "AND escolaridadnovedad.codtipoidentidadest = '" + dkda.o(sel, "codtipoidentidadest") + "' AND escolaridadnovedad.escidentificest = '" + dkda.o(sel, "escidentificest")
                    + "' AND escolaridadnovedad.escvigencia = " + dkda.o(sel, "escvigencia") + " AND escolaridadnovedad.escnovconsec = '" + dkda.o(sel, "escnovconsec") + "' ";
            System.out.println(sql);


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#escnovobserv_escolaridadnovedad|" + (rs.getString("escolaridadnovedad_escnovobserv") == null ? "" : rs.getString("escolaridadnovedad_escnovobserv")) + ":_";

            info += "text|#escnovarchi_escolaridadnovedad|" + (rs.getString("escolaridadnovedad_escnovarchi_nombre") == null ? "" : rs.getString("escolaridadnovedad_escnovarchi_nombre")) + ":_";

            info += "combo|#codtiponovedad_escolaridadnovedad|" + rs.getString("tiponovedad_codtiponovedad") + "|llenarCombo('codtiponovedad_escolaridadnovedad', '"
                    + rs.getString("tiponovedad_codtiponovedad") + "', '" + rs.getString("tiponovedad_descripcion") + "'):_";

            info += "combo|#empresa_escolaridadnovedad_1|" + "empresa   codtipoidentidad  " + rs.getString("empresa_codtipoidentidad") + "  "
                    + " codempresa  " + rs.getString("empresa_codempresa") + "|llenarCombo('empresa_escolaridadnovedad_1', '"
                    + "empresa   codtipoidentidad  " + rs.getString("empresa_codtipoidentidad") + "  "
                    + " codempresa  " + rs.getString("empresa_codempresa") + "', '" + rs.getString("empresa_nombre")
                    + "'):_";


            info += "text|#_fecha_escnovfecha_escolaridadnovedad|" + (rs.getString("escolaridadnovedad_escnovfecha") == null ? "" : rs.getString("escolaridadnovedad_escnovfecha")) + ":_";

            info += "combo|#escolaridad_escolaridadnovedad_1|" + "escolaridad   codtipoidentidadins  " + rs.getString("escolaridad_codtipoidentidadins") + "  "
                    + " codempresa  " + rs.getString("escolaridadnovedad_codempresaact")
                    + "   codtipoidentidad  " + rs.getString("escolaridadnovedad_codtipoidentidadest") + "   escidentific  " + rs.getString("escolaridad_escidentific")
                    + "   escvigencia  " + rs.getString("escolaridadnovedad_escvigencia") + "|llenarCombo('escolaridad_escolaridadnovedad_1', '"
                    + "escolaridad   codtipoidentidadins  " + rs.getString("escolaridad_codtipoidentidadins") + "  "
                    + " codempresa  " + rs.getString("escolaridadnovedad_codempresaact")
                    + "   codtipoidentidad  " + rs.getString("escolaridadnovedad_codtipoidentidadest") + "   escidentific  " + rs.getString("escolaridad_escidentific")
                    + "   escvigencia  " + rs.getString("escolaridadnovedad_escvigencia") + "', '" + rs.getString("escolaridadnovedad_codempresaact") + "'):_";


            info += "text|#escnovconsec_escolaridadnovedad|" + (rs.getString("escolaridadnovedad_escnovconsec") == null ? "" : rs.getString("escolaridadnovedad_escnovconsec")) + ":_";

            respuesta = "opcion=obtener_escolaridadnovedad&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_escolaridadnovedad&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error escolaridadnovedad - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_escolaridadnovedad() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM escolaridadnovedad   WHERE codtipoideninsact = '"
                    + dkda.o(escolaridad_escolaridadnovedad_1, "codtipoidentidadins") + "'"
                    + " AND codempresaact = '" + dkda.o(escolaridad_escolaridadnovedad_1, "codempresa") + "' AND "
                    + "codtipoidentidadest = '" + dkda.o(escolaridad_escolaridadnovedad_1, "codtipoidentidad") + "'"
                    + " AND escidentificest = '" + dkda.o(escolaridad_escolaridadnovedad_1, "escidentific") + "'"
                    + " AND escvigencia = " + dkda.o(escolaridad_escolaridadnovedad_1, "escvigencia")
                    + " AND escnovconsec = '" + dkda.o(vars, "escnovconsec_escolaridadnovedad") + "' ";
            System.out.println(sql);
            pQuery = conexion.prepareStatement(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_escolaridadnovedad() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_escolaridadnovedad() {
        String direccion = "opcion=registrar_escolaridadnovedad&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_escolaridadnovedad();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {

            System.out.println(dkda.o(sel, "codtipoideninsact") + "  " + dkda.o(escolaridad_escolaridadnovedad_1, "codtipoidentidadins"));
            System.out.println(dkda.o(sel, "escnovconsec") + "  " + dkda.o(vars, "escnovconsec_escolaridadnovedad"));

            if (!(dkda.o(sel, "codtipoideninsact").toString().equals(dkda.o(escolaridad_escolaridadnovedad_1, "codtipoidentidadins"))
                    && dkda.o(sel, "codempresaact").toString().equals(dkda.o(escolaridad_escolaridadnovedad_1, "codempresa"))
                    && dkda.o(sel, "codtipoidentidadest").toString().equals(dkda.o(escolaridad_escolaridadnovedad_1, "codtipoidentidad"))
                    && dkda.o(sel, "escidentificest").toString().equals(dkda.o(escolaridad_escolaridadnovedad_1, "escidentific"))
                    && dkda.o(sel, "escvigencia").toString().equals(dkda.o(escolaridad_escolaridadnovedad_1, "escvigencia"))
                    && dkda.o(sel, "escnovconsec").toString().equals(dkda.o(vars, "escnovconsec_escolaridadnovedad"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(escolaridad_escolaridadnovedad_1, "codtipoidentidadins").isEmpty()) {
            error = "Institución Educativa Actual: no puede ser vacio.";
        } else if (dkda.o(vars, "escnovconsec_escolaridadnovedad").isEmpty()) {
            error = "Consecutivo Novedad Escolaridad: no puede ser vacio.";
        } else if (dkda.o(vars, "escnovfecha_escolaridadnovedad").isEmpty()) {
            error = "Fecha Novedad Escolaridad: no puede ser vacio.";
        } else if (dkda.o(empresa_escolaridadnovedad_1, "codtipoidentidad").isEmpty()) {
            error = "Tipo Identificacion Empresa Nueva: no puede ser vacio.";
        } else if (dkda.o(vars, "codtiponovedad_escolaridadnovedad").isEmpty()) {
            error = "Codigo Tipo de Novedad: no puede ser vacio.";
        } else if (dkda.o(vars, "escnovarchi_escolaridadnovedad").isEmpty()) {
            error = "Archivo Documento Novedad Escolaridad: no puede ser vacio.";
        } else if (dkda.o(vars, "escnovobserv_escolaridadnovedad").isEmpty()) {
            error = "Observaciones Tipo de Novedad: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "escnovconsec_escolaridadnovedad"))) {
            error = "Consecutivo Novedad Escolaridad: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "escnovobserv_escolaridadnovedad").length() > 400) {
            error = "Observaciones Tipo de Novedad: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_escregperiodico(ConexionBaseDatos con) {
        System.out.println("registrar_escregperiodico");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO escregperiodico (codtipoidentidadins,codempresa,codtipoidentidad,escidentific,escvigencia,espefechinic,espefechfina"
                    + ",codtipoidentidadfir,firmidentifi,espefechregi,especlasprog,espenumefall,espefalljust,especertesco,especertreci,especumprequ,"
                    + "espeobservac,ususiscodigo,fecharegistro,espearchivo,espearchivo_nombre) VALUES (" + (dkda.o(escolaridad_escregperiodico_1,
                    "codtipoidentidadins").equals("") ? null : "'" + dkda.o(escolaridad_escregperiodico_1, "codtipoidentidadins") + "'") + ","
                    + (dkda.o(escolaridad_escregperiodico_1, "codempresa").equals("") ? null : "'" + dkda.o(escolaridad_escregperiodico_1, "codempresa")
                    + "'") + "," + (dkda.o(escolaridad_escregperiodico_1, "codtipoidentidad").equals("") ? null : "'"
                    + dkda.o(escolaridad_escregperiodico_1, "codtipoidentidad") + "'") + "," + (dkda.o(escolaridad_escregperiodico_1, "escidentific").equals("") ? null : "'" + dkda.o(escolaridad_escregperiodico_1, "escidentific") + "'") + "," + (dkda.o(escolaridad_escregperiodico_1, "escvigencia").equals("") ? null : dkda.o(escolaridad_escregperiodico_1, "escvigencia")) + "," + (dkda.o(vars,
                    "espefechinic_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "espefechinic_escregperiodico") + "'") + ","
                    + (dkda.o(vars, "espefechfina_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "espefechfina_escregperiodico") + "'")
                    + "," + (dkda.o(firmasautorizadas_escregperiodico_1, "codtipoidentidadfir").equals("") ? null : "'"
                    + dkda.o(firmasautorizadas_escregperiodico_1, "codtipoidentidadfir") + "'") + "," + (dkda.o(firmasautorizadas_escregperiodico_1,
                    "firmidentifi").equals("") ? null : "'" + dkda.o(firmasautorizadas_escregperiodico_1, "firmidentifi") + "'") + ","
                    + (dkda.o(vars, "espefechregi_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "espefechregi_escregperiodico") + "'") + ","
                    + (dkda.o(vars, "especlasprog_escregperiodico").equals("") ? null : dkda.o(vars, "especlasprog_escregperiodico")) + ","
                    + (dkda.o(vars, "espenumefall_escregperiodico").equals("") ? null : dkda.o(vars, "espenumefall_escregperiodico")) + ","
                    + (dkda.o(vars, "espefalljust_escregperiodico").equals("") ? null : dkda.o(vars, "espefalljust_escregperiodico")) + ","
                    + (dkda.o(vars, "especertesco_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "especertesco_escregperiodico") + "'") + ","
                    + (dkda.o(vars, "especertreci_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "especertreci_escregperiodico") + "'") + ","
                    + (dkda.o(vars, "especumprequ_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "especumprequ_escregperiodico") + "'") + ","
                    + (dkda.o(vars, "espeobservac_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "espeobservac_escregperiodico") + "'") + ","
                    + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "espearchivo_escregperiodico").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "espearchivo_escregperiodico") + "')") + "," + (dkda.o(vars, "espearchivo_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "espearchivo_escregperiodico") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_escregperiodico&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_escregperiodico&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error escregperiodico.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_escregperiodico(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE escregperiodico SET codtipoidentidadins = " + (dkda.o(escolaridad_escregperiodico_1, "codtipoidentidadins").equals("") ? null : "'" + dkda.o(escolaridad_escregperiodico_1, "codtipoidentidadins") + "'") + ",codempresa = " + (dkda.o(escolaridad_escregperiodico_1, "codempresa").equals("") ? null : "'" + dkda.o(escolaridad_escregperiodico_1, "codempresa") + "'") + ",codtipoidentidad = " + (dkda.o(escolaridad_escregperiodico_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(escolaridad_escregperiodico_1, "codtipoidentidad") + "'") + ",escidentific = " + (dkda.o(escolaridad_escregperiodico_1, "escidentific").equals("") ? null : "'" + dkda.o(escolaridad_escregperiodico_1, "escidentific") + "'") + ",escvigencia = " + (dkda.o(escolaridad_escregperiodico_1, "escvigencia").equals("") ? null : dkda.o(escolaridad_escregperiodico_1, "escvigencia")) + ",espefechinic = " + (dkda.o(vars, "espefechinic_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "espefechinic_escregperiodico") + "'") + ",espefechfina = " + (dkda.o(vars, "espefechfina_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "espefechfina_escregperiodico") + "'") + ",codtipoidentidadfir = " + (dkda.o(firmasautorizadas_escregperiodico_1, "codtipoidentidadfir").equals("") ? null : "'" + dkda.o(firmasautorizadas_escregperiodico_1, "codtipoidentidadfir") + "'") + ",firmidentifi = " + (dkda.o(firmasautorizadas_escregperiodico_1, "firmidentifi").equals("") ? null : "'" + dkda.o(firmasautorizadas_escregperiodico_1, "firmidentifi") + "'") + ",espefechregi = " + (dkda.o(vars, "espefechregi_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "espefechregi_escregperiodico") + "'") + ",especlasprog = " + (dkda.o(vars, "especlasprog_escregperiodico").equals("") ? null : dkda.o(vars, "especlasprog_escregperiodico")) + ",espenumefall = " + (dkda.o(vars, "espenumefall_escregperiodico").equals("") ? null : dkda.o(vars, "espenumefall_escregperiodico")) + ",espefalljust = " + (dkda.o(vars, "espefalljust_escregperiodico").equals("") ? null : dkda.o(vars, "espefalljust_escregperiodico")) + ",especertesco = " + (dkda.o(vars, "especertesco_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "especertesco_escregperiodico") + "'") + ",especertreci = " + (dkda.o(vars, "especertreci_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "especertreci_escregperiodico") + "'") + ",especumprequ = " + (dkda.o(vars, "especumprequ_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "especumprequ_escregperiodico") + "'") + ",espeobservac = " + (dkda.o(vars, "espeobservac_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "espeobservac_escregperiodico") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",espearchivo = " + (dkda.o(vars, "espearchivo_escregperiodico").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "espearchivo_escregperiodico") + "')") + ",espearchivo_nombre = " + (dkda.o(vars, "espearchivo_escregperiodico").equals("") ? null : "'" + dkda.o(vars, "espearchivo_escregperiodico") + "'") + " "
                    + "WHERE escregperiodico.codtipoidentidadins = '" + dkda.o(sel, "codtipoidentidadins") + "' AND escregperiodico.codempresa = '" + dkda.o(sel, "codempresa") + "' AND "
                    + "escregperiodico.codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND escregperiodico.escidentific = '" + dkda.o(sel, "escidentific") + "' AND escregperiodico.escvigencia = "
                    + dkda.o(sel, "escvigencia") + " AND escregperiodico.espefechinic = '" + dkda.o(sel, "espefechinic") + "' AND escregperiodico.espefechfina = '" + dkda.o(sel, "espefechfina") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_escregperiodico&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_escregperiodico&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error escregperiodico.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_escregperiodico(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM escregperiodico WHERE codtipoidentidadins = '" + dkda.o(sel, "codtipoidentidadins") + "' AND codempresa = '" + dkda.o(sel, "codempresa") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND escidentific = '" + dkda.o(sel, "escidentific") + "' AND escvigencia = " + dkda.o(sel, "escvigencia") + " AND espefechinic = '" + dkda.o(sel, "espefechinic") + "' AND espefechfina = '" + dkda.o(sel, "espefechfina") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_escregperiodico&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_escregperiodico&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error escregperiodico.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_escregperiodico(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;

            String sql = ""
                    + "SELECT escregperiodico.\"codtipoidentidadins\"   AS "
                    + "       escregperiodico_codtipoidentidadins, "
                    + "       escregperiodico.\"codempresa\"            AS escregperiodico_codempresa, "
                    + "       escregperiodico.\"codtipoidentidad\"      AS "
                    + "       escregperiodico_codtipoidentidad, "
                    + "       escregperiodico.\"escidentific\"          AS escregperiodico_escidentific, "
                    + "       escregperiodico.\"escvigencia\"           AS escregperiodico_escvigencia, "
                    + "       escregperiodico.\"espefechinic\"          AS escregperiodico_espefechinic, "
                    + "       escregperiodico.\"espefechfina\"          AS escregperiodico_espefechfina, "
                    + "       escregperiodico.\"codtipoidentidadfir\"   AS "
                    + "       escregperiodico_codtipoidentidadfir, "
                    + "       escregperiodico.\"firmidentifi\"          AS escregperiodico_firmidentifi, "
                    + "       escregperiodico.\"espefechregi\"          AS escregperiodico_espefechregi, "
                    + "       escregperiodico.\"especlasprog\"          AS escregperiodico_especlasprog, "
                    + "       escregperiodico.\"espenumefall\"          AS escregperiodico_espenumefall, "
                    + "       escregperiodico.\"espefalljust\"          AS escregperiodico_espefalljust, "
                    + "       escregperiodico.\"especertesco\"          AS escregperiodico_especertesco, "
                    + "       escregperiodico.\"especertreci\"          AS escregperiodico_especertreci, "
                    + "       escregperiodico.\"especumprequ\"          AS escregperiodico_especumprequ, "
                    + "       escregperiodico.\"espeobservac\"          AS escregperiodico_espeobservac, "
                    + "       escregperiodico.\"espearchivo\"           AS escregperiodico_espearchivo, "
                    + "       escregperiodico.\"espearchivo_nombre\"    AS "
                    + "       escregperiodico_espearchivo_nombre, "
                    + "CASE WHEN escregperiodico.espearchivo_nombre  IS NULL OR escregperiodico.espearchivo_nombre  = '' THEN 0 "
                    + "ELSE lo_export(escregperiodico.espearchivo, '" + fun.temp(request) + "' || escregperiodico.espearchivo_nombre ) END, "
                    + "       firmasautorizadas.\"codtipoidentidadfir\" AS "
                    + "       firmasautorizadas_codtipoidentidadfir, "
                    + "       firmasautorizadas.\"firmidentifi\"        AS firmasautorizadas_firmidentifi "
                    + "       , "
                    + "       escolaridad.\"codtipoidentidadins\"       AS "
                    + "       escolaridad_codtipoidentidadins, "
                    + "       escolaridad.\"codempresa\"                AS escolaridad_codempresa, "
                    + "       escolaridad.\"codtipoidentidad\"          AS escolaridad_codtipoidentidad, "
                    + "       escolaridad.\"escidentific\"              AS escolaridad_escidentific, "
                    + "       escolaridad.\"escvigencia\"               AS escolaridad_escvigencia "
                    + "FROM   \"public\".\"escolaridad\" escolaridad "
                    + "       INNER JOIN \"public\".\"escregperiodico\" escregperiodico "
                    + "         ON escolaridad.\"codtipoidentidadins\" = "
                    + "            escregperiodico.\"codtipoidentidadins\" "
                    + "            AND escolaridad.\"escvigencia\" = escregperiodico.\"escvigencia\" "
                    + "            AND escolaridad.\"codempresa\" = escregperiodico.\"codempresa\" "
                    + "            AND escolaridad.\"escidentific\" = escregperiodico.\"escidentific\" "
                    + "            AND escolaridad.\"codtipoidentidad\" = "
                    + "                escregperiodico.\"codtipoidentidad\" "
                    + "       INNER JOIN \"public\".\"firmasautorizadas\" firmasautorizadas "
                    + "         ON escregperiodico.\"codtipoidentidadfir\" = "
                    + "            firmasautorizadas.\"codtipoidentidadfir\" "
                    + "            AND firmasautorizadas.\"firmidentifi\" = "
                    + "                escregperiodico.\"firmidentifi\"  WHERE escregperiodico.codtipoidentidadins = '"
                    + dkda.o(sel, "codtipoidentidadins") + "' AND escregperiodico.codempresa = '" + dkda.o(sel, "codempresa") + "' "
                    + "AND escregperiodico.codtipoidentidad = '"
                    + dkda.o(sel, "codtipoidentidad") + "' AND escregperiodico.escidentific = '" + dkda.o(sel, "escidentific") + "'"
                    + " AND escregperiodico.escvigencia = "
                    + dkda.o(sel, "escvigencia") + " AND escregperiodico.espefechinic = '" + dkda.o(sel, "espefechinic") + "' AND escregperiodico.espefechfina = '"
                    + dkda.o(sel, "espefechfina") + "' ";
            System.out.println(sql);

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#espeobservac_escregperiodico|" + (rs.getString("escregperiodico_espeobservac") == null ? "" : rs.getString("escregperiodico_espeobservac")) + ":_";

            info += "text|#espearchivo_escregperiodico|" + (rs.getString("escregperiodico_espearchivo_nombre") == null ? "" : rs.getString("escregperiodico_espearchivo_nombre")) + ":_";

            info += "switch|switch_especumprequ_escregperiodico|" + rs.getString("escregperiodico_especumprequ") + ":_";

            info += "switch|switch_especertreci_escregperiodico|" + rs.getString("escregperiodico_especertreci") + ":_";

            info += "text|#especertesco_escregperiodico|" + (rs.getString("escregperiodico_especertesco") == null ? "" : rs.getString("escregperiodico_especertesco")) + ":_";

            info += "text|#espefalljust_escregperiodico|" + (rs.getString("escregperiodico_espefalljust") == null ? "" : rs.getString("escregperiodico_espefalljust")) + ":_";

            info += "text|#espenumefall_escregperiodico|" + (rs.getString("escregperiodico_espenumefall") == null ? "" : rs.getString("escregperiodico_espenumefall")) + ":_";

            info += "text|#especlasprog_escregperiodico|" + (rs.getString("escregperiodico_especlasprog") == null ? "" : rs.getString("escregperiodico_especlasprog")) + ":_";

            info += "text|#_fecha_espefechregi_escregperiodico|" + (rs.getString("escregperiodico_espefechregi") == null ? "" : rs.getString("escregperiodico_espefechregi")) + ":_";

            info += "combo|#firmasautorizadas_escregperiodico_1|" + "firmasautorizadas   codtipoidentidadfir  " + rs.getString("firmasautorizadas_codtipoidentidadfir") + " "
                    + "  firmidentifi  " + rs.getString("firmasautorizadas_firmidentifi") + "|llenarCombo('firmasautorizadas_escregperiodico_1', '"
                    + "firmasautorizadas   codtipoidentidadfir  " + rs.getString("firmasautorizadas_codtipoidentidadfir") + " "
                    + "  firmidentifi  " + rs.getString("firmasautorizadas_firmidentifi") + "', '" + rs.getString("firmasautorizadas_firmidentifi") + "'):_";

            info += "text|#_fecha_espefechfina_escregperiodico|" + (rs.getString("escregperiodico_espefechfina") == null ? "" : rs.getString("escregperiodico_espefechfina")) + ":_";

            info += "text|#_fecha_espefechinic_escregperiodico|" + (rs.getString("escregperiodico_espefechinic") == null ? "" : rs.getString("escregperiodico_espefechinic")) + ":_";


            info += "combo|#escolaridad_escregperiodico_1|" + "escolaridad   codtipoidentidadins  " + rs.getString("escolaridad_codtipoidentidadins") + "  "
                    + " codempresa  " + rs.getString("escolaridad_codempresa")
                    + "   codtipoidentidad  " + rs.getString("escolaridad_codtipoidentidad") + "   "
                    + "escidentific  " + rs.getString("escolaridad_escidentific")
                    + "   escvigencia  " + rs.getString("escolaridad_escvigencia") + "|llenarCombo('escolaridad_escregperiodico_1', '"
                    + "escolaridad   codtipoidentidadins  " + rs.getString("escolaridad_codtipoidentidadins") + "  "
                    + " codempresa  " + rs.getString("escolaridad_codempresa")
                    + "   codtipoidentidad  " + rs.getString("escolaridad_codtipoidentidad") + "   "
                    + "escidentific  " + rs.getString("escolaridad_escidentific")
                    + "   escvigencia  " + rs.getString("escolaridad_escvigencia") + "', '" + rs.getString("escolaridad_codempresa") + "'):_";

            respuesta = "opcion=obtener_escregperiodico&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_escregperiodico&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error escregperiodico - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_escregperiodico() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM escregperiodico  WHERE codtipoidentidadins = '"
                    + dkda.o(escolaridad_escregperiodico_1, "codtipoidentidadins") + "'" + " "
                    + "AND codempresa = '" + dkda.o(escolaridad_escregperiodico_1, "codempresa") + "'" + " "
                    + "AND codtipoidentidad = '" + dkda.o(escolaridad_escregperiodico_1, "codtipoidentidad") + "'" + " AND escidentific = '"
                    + dkda.o(escolaridad_escregperiodico_1, "escidentific") + "'" + " AND escvigencia = '"
                    + dkda.o(escolaridad_escregperiodico_1, "escvigencia") + "'" + ""
                    + " AND espefechinic = '" + dkda.o(vars, "espefechinic_escregperiodico") + "'" + ""
                    + " AND espefechfina = '" + dkda.o(vars, "espefechfina_escregperiodico") + "'";
            System.out.println(sql);
            pQuery = conexion.prepareStatement(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_escregperiodico() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_escregperiodico() {
        String direccion = "opcion=registrar_escregperiodico&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_escregperiodico();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codtipoidentidadins").toString().equals(dkda.o(escolaridad_escregperiodico_1, "codtipoidentidadins"))
                    && dkda.o(sel, "codempresa").toString().equals(dkda.o(escolaridad_escregperiodico_1, "codempresa"))
                    && dkda.o(sel, "codtipoidentidad").toString().equals(dkda.o(escolaridad_escregperiodico_1, "codtipoidentidad"))
                    && dkda.o(sel, "escidentific").toString().equals(dkda.o(escolaridad_escregperiodico_1, "escidentific"))
                    && dkda.o(sel, "escvigencia").toString().equals(dkda.o(escolaridad_escregperiodico_1, "escvigencia"))
                    && dkda.o(sel, "espefechinic").toString().equals(dkda.o(vars, "espefechinic_escregperiodico"))
                    && dkda.o(sel, "espefechfina").toString().equals(dkda.o(vars, "espefechfina_escregperiodico"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(escolaridad_escregperiodico_1, "codtipoidentidadins").isEmpty()) {
            error = "Escolaridad: no puede ser vacio.";
        } else if (dkda.o(vars, "espefechinic_escregperiodico").isEmpty()) {
            error = "Fecha Inicial Registro Periódico Escolaridad: no puede ser vacio.";
        } else if (dkda.o(vars, "espefechfina_escregperiodico").isEmpty()) {
            error = "Fecha Final Registro Periódico Escolaridad: no puede ser vacio.";
        } else if (dkda.o(firmasautorizadas_escregperiodico_1, "codtipoidentidadfir").isEmpty()) {
            error = "Firma Autorizada: no puede ser vacio.";
        } else if (dkda.o(vars, "espefechregi_escregperiodico").isEmpty()) {
            error = "Fecha Registro Escolaridad Periódica: no puede ser vacio.";
        } else if (dkda.o(vars, "especlasprog_escregperiodico").isEmpty()) {
            error = "N&uacute;mero de Clases Programadas Peri&oacute;do: no puede ser vacio.";
        } else if (dkda.o(vars, "espenumefall_escregperiodico").isEmpty()) {
            error = "N&uacute;mero de Fallas Periódo: no puede ser vacio.";
        } else if (dkda.o(vars, "espefalljust_escregperiodico").isEmpty()) {
            error = "Número de Fallas Justificadas Periódo: no puede ser vacio.";
        } else if (dkda.o(vars, "especertesco_escregperiodico").isEmpty()) {
            error = "N&uacute;mero Certificado Escolar Periódo: no puede ser vacio.";
        } else if (dkda.o(vars, "especertreci_escregperiodico").isEmpty()) {
            error = "Certificado Recibido (S/N): no puede ser vacio.";
        } else if (dkda.o(vars, "especumprequ_escregperiodico").isEmpty()) {
            error = "Cumple Requisitos Subsidio Escolaridad Periódo (S/N): no puede ser vacio.";
        } else if (dkda.o(vars, "espearchivo_escregperiodico").isEmpty()) {
            error = "Archivo Documento Certificado de Escolaridad: no puede ser vacio.";
        } else if (dkda.o(vars, "espeobservac_escregperiodico").isEmpty()) {
            error = "Observaciones Registro Peri&oacute;dico Escolaridad: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "especlasprog_escregperiodico"))) {
            error = "N&uacite;mero de Clases Programadas Periódo: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "espenumefall_escregperiodico"))) {
            error = "N&uacute;mero de Fallas Periódo: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "espefalljust_escregperiodico"))) {
            error = "Número de Fallas Justificadas Periódo: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "especertesco_escregperiodico"))) {
            error = "N&uacute;mero Certificado Escolar Periódo: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "especertesco_escregperiodico").length() > 12) {
            error = "N&uacute;mero Certificado Escolar Periódo: Valor demasiado Largo.";
        } else if (dkda.o(vars, "especertreci_escregperiodico").length() > 1) {
            error = "Certificado Recibido (S/N): Valor demasiado Largo.";
        } else if (dkda.o(vars, "especumprequ_escregperiodico").length() > 1) {
            error = "Cumple Requisitos Subsidio Escolaridad Periódo (S/N): Valor demasiado Largo.";
        } else if (dkda.o(vars, "espeobservac_escregperiodico").length() > 400) {
            error = "Observaciones Registro Peri&oacute;dico Escolaridad: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_escolaridadcumplimiento(ConexionBaseDatos con) {
        System.out.println("registrar_escolaridadcumplimiento");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO escolaridadcumplimiento (codtipoidentidadins,codempresa,codtipoidentidad,escidentific,escvigencia,espefechinic,espefechfina,codtiporequisito,coditipben,codactividadsalud,codestcumplimiento,esccumobserv,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(escregperiodico_escolaridadcumplimiento_1, "codtipoidentidadins").equals("") ? null : "'" + dkda.o(escregperiodico_escolaridadcumplimiento_1, "codtipoidentidadins") + "'") + "," + (dkda.o(escregperiodico_escolaridadcumplimiento_1, "codempresa").equals("") ? null : "'" + dkda.o(escregperiodico_escolaridadcumplimiento_1, "codempresa") + "'") + "," + (dkda.o(escregperiodico_escolaridadcumplimiento_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(escregperiodico_escolaridadcumplimiento_1, "codtipoidentidad") + "'") + "," + (dkda.o(escregperiodico_escolaridadcumplimiento_1, "escidentific").equals("") ? null : "'" + dkda.o(escregperiodico_escolaridadcumplimiento_1, "escidentific") + "'") + "," + (dkda.o(escregperiodico_escolaridadcumplimiento_1, "escvigencia").equals("") ? null : dkda.o(escregperiodico_escolaridadcumplimiento_1, "escvigencia")) + "," + (dkda.o(escregperiodico_escolaridadcumplimiento_1, "espefechinic").equals("") ? null : "'" + dkda.o(escregperiodico_escolaridadcumplimiento_1, "espefechinic") + "'") + "," + (dkda.o(escregperiodico_escolaridadcumplimiento_1, "espefechfina").equals("") ? null : "'" + dkda.o(escregperiodico_escolaridadcumplimiento_1, "espefechfina") + "'") + "," + (dkda.o(requisitos_escolaridadcumplimiento_1, "codtiporequisito").equals("") ? null : "'" + dkda.o(requisitos_escolaridadcumplimiento_1, "codtiporequisito") + "'") + "," + (dkda.o(requisitos_escolaridadcumplimiento_1, "coditipben").equals("") ? null : "'" + dkda.o(requisitos_escolaridadcumplimiento_1, "coditipben") + "'") + "," + (dkda.o(requisitos_escolaridadcumplimiento_1, "codactividadsalud").equals("") ? null : "'" + dkda.o(requisitos_escolaridadcumplimiento_1, "codactividadsalud") + "'") + "," + (dkda.o(vars, "codestcumplimiento_escolaridadcumplimiento").equals("") ? null : "'" + dkda.o(vars, "codestcumplimiento_escolaridadcumplimiento") + "'") + "," + (dkda.o(vars, "esccumobserv_escolaridadcumplimiento").equals("") ? null : "'" + dkda.o(vars, "esccumobserv_escolaridadcumplimiento") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_escolaridadcumplimiento&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_escolaridadcumplimiento&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error escolaridadcumplimiento.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_escolaridadcumplimiento(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE escolaridadcumplimiento SET codtipoidentidadins = " + (dkda.o(escregperiodico_escolaridadcumplimiento_1, "codtipoidentidadins").equals("") ? null : "'" + dkda.o(escregperiodico_escolaridadcumplimiento_1, "codtipoidentidadins") + "'") + ",codempresa = " + (dkda.o(escregperiodico_escolaridadcumplimiento_1, "codempresa").equals("") ? null : "'" + dkda.o(escregperiodico_escolaridadcumplimiento_1, "codempresa") + "'") + ",codtipoidentidad = " + (dkda.o(escregperiodico_escolaridadcumplimiento_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(escregperiodico_escolaridadcumplimiento_1, "codtipoidentidad") + "'") + ",escidentific = " + (dkda.o(escregperiodico_escolaridadcumplimiento_1, "escidentific").equals("") ? null : "'" + dkda.o(escregperiodico_escolaridadcumplimiento_1, "escidentific") + "'") + ",escvigencia = " + (dkda.o(escregperiodico_escolaridadcumplimiento_1, "escvigencia").equals("") ? null : dkda.o(escregperiodico_escolaridadcumplimiento_1, "escvigencia")) + ",espefechinic = " + (dkda.o(escregperiodico_escolaridadcumplimiento_1, "espefechinic").equals("") ? null : "'" + dkda.o(escregperiodico_escolaridadcumplimiento_1, "espefechinic") + "'") + ",espefechfina = " + (dkda.o(escregperiodico_escolaridadcumplimiento_1, "espefechfina").equals("") ? null : "'" + dkda.o(escregperiodico_escolaridadcumplimiento_1, "espefechfina") + "'") + ",codtiporequisito = " + (dkda.o(requisitos_escolaridadcumplimiento_1, "codtiporequisito").equals("") ? null : "'" + dkda.o(requisitos_escolaridadcumplimiento_1, "codtiporequisito") + "'") + ",coditipben = " + (dkda.o(requisitos_escolaridadcumplimiento_1, "coditipben").equals("") ? null : "'" + dkda.o(requisitos_escolaridadcumplimiento_1, "coditipben") + "'") + ",codactividadsalud = " + (dkda.o(requisitos_escolaridadcumplimiento_1, "codactividadsalud").equals("") ? null : "'" + dkda.o(requisitos_escolaridadcumplimiento_1, "codactividadsalud") + "'") + ",codestcumplimiento = " + (dkda.o(vars, "codestcumplimiento_escolaridadcumplimiento").equals("") ? null : "'" + dkda.o(vars, "codestcumplimiento_escolaridadcumplimiento") + "'") + ",esccumobserv = " + (dkda.o(vars, "esccumobserv_escolaridadcumplimiento").equals("") ? null : "'" + dkda.o(vars, "esccumobserv_escolaridadcumplimiento") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codtipoidentidadins = '" + dkda.o(sel, "codtipoidentidadins") + "' AND codempresa = '" + dkda.o(sel, "codempresa") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND escidentific = '" + dkda.o(sel, "escidentific") + "' AND escvigencia = " + dkda.o(sel, "escvigencia") + " AND espefechinic = '" + dkda.o(sel, "espefechinic") + "' AND espefechfina = '" + dkda.o(sel, "espefechfina") + "' AND codtiporequisito = '" + dkda.o(sel, "codtiporequisito") + "' AND coditipben = '" + dkda.o(sel, "coditipben") + "' AND codactividadsalud = '" + dkda.o(sel, "codactividadsalud") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_escolaridadcumplimiento&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_escolaridadcumplimiento&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error escolaridadcumplimiento.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_escolaridadcumplimiento(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM escolaridadcumplimiento WHERE codtipoidentidadins = '" + dkda.o(sel, "codtipoidentidadins") + "' AND codempresa = '" + dkda.o(sel, "codempresa") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND escidentific = '" + dkda.o(sel, "escidentific") + "' AND escvigencia = " + dkda.o(sel, "escvigencia") + " AND espefechinic = '" + dkda.o(sel, "espefechinic") + "' AND espefechfina = '" + dkda.o(sel, "espefechfina") + "' AND codtiporequisito = '" + dkda.o(sel, "codtiporequisito") + "' AND coditipben = '" + dkda.o(sel, "coditipben") + "' AND codactividadsalud = '" + dkda.o(sel, "codactividadsalud") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_escolaridadcumplimiento&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_escolaridadcumplimiento&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error escolaridadcumplimiento.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    private boolean existe_escolaridadcumplimiento() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM escolaridadcumplimiento  WHERE codtipoidentidadins = '" + dkda.o(sel, "codtipoidentidadins") + "'" + " AND codempresa = '" + dkda.o(sel, "codempresa") + "'" + " AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "'" + " AND escidentific = '" + dkda.o(sel, "escidentific") + "'" + " AND escvigencia = " + dkda.o(sel, "escvigencia") + "" + " AND espefechinic = " + dkda.o(sel, "espefechinic") + "" + " AND espefechfina = " + dkda.o(sel, "espefechfina") + "" + " AND codtiporequisito = '" + dkda.o(sel, "codtiporequisito") + "'" + " AND coditipben = '" + dkda.o(sel, "coditipben") + "'" + " AND codactividadsalud = '" + dkda.o(sel, "codactividadsalud") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_escolaridadcumplimiento() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String obtener_escolaridadcumplimiento(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;

            String sql  =" ";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            respuesta = "opcion=obtener_escolaridadcumplimiento&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_escolaridadcumplimiento&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error escolaridadcumplimiento - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_escolaridadcumplimiento() {
        String direccion = "opcion=registrar_escolaridadcumplimiento&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_escolaridadcumplimiento();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codtipoidentidadins").toString().equals(dkda.o(vars, "codtipoidentidadins_escolaridadcumplimiento")) && dkda.o(sel, "codempresa").toString().equals(dkda.o(vars, "codempresa_escolaridadcumplimiento")) && dkda.o(sel, "codtipoidentidad").toString().equals(dkda.o(vars, "codtipoidentidad_escolaridadcumplimiento")) && dkda.o(sel, "escidentific").toString().equals(dkda.o(vars, "escidentific_escolaridadcumplimiento")) && dkda.o(sel, "escvigencia").toString().equals(dkda.o(vars, "escvigencia_escolaridadcumplimiento")) && dkda.o(sel, "espefechinic").toString().equals(dkda.o(vars, "espefechinic_escolaridadcumplimiento")) && dkda.o(sel, "espefechfina").toString().equals(dkda.o(vars, "espefechfina_escolaridadcumplimiento")) && dkda.o(sel, "codtiporequisito").toString().equals(dkda.o(vars, "codtiporequisito_escolaridadcumplimiento")) && dkda.o(sel, "coditipben").toString().equals(dkda.o(vars, "coditipben_escolaridadcumplimiento")) && dkda.o(sel, "codactividadsalud").toString().equals(dkda.o(vars, "codactividadsalud_escolaridadcumplimiento"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(escregperiodico_escolaridadcumplimiento_1, "codtipoidentidadins").isEmpty()) {
            error = "Escolaridad Periodico: no puede ser vacio.";
        } else if (dkda.o(requisitos_escolaridadcumplimiento_1, "codtiporequisito_escolaridadcumplimiento").isEmpty()) {
            error = "C&oacute;digo Requisito: no puede ser vacio.";
        } else if (dkda.o(vars, "codestcumplimiento_escolaridadcumplimiento").isEmpty()) {
            error = "Codigo Estado Cumplimiento: no puede ser vacio.";
        } else if (dkda.o(vars, "esccumobserv_escolaridadcumplimiento").isEmpty()) {
            error = "Observaciones Cumplimiento Escolaridad: no puede ser vacio.";
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
// 
}