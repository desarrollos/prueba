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

public class Reclamos extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, municipio_reclamo_1, reclamoclasificacion_reclamo_1;
    HashMap reclamo_reclamodocumento_1;
    HashMap beneficiario_reclamobeneficiaro_1, reclamo_reclamobeneficiaro_1;
    HashMap reclamo_respuestareclamo_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());
        municipio_reclamo_1 = fun.map(dkda.o(vars, "municipio_reclamo_1").toString());
        reclamoclasificacion_reclamo_1 = fun.map(dkda.o(vars, "reclamoclasificacion_reclamo_1").toString());
        reclamo_reclamodocumento_1 = fun.map(dkda.o(vars, "reclamo_reclamodocumento_1").toString());
        beneficiario_reclamobeneficiaro_1 = fun.map(dkda.o(vars, "beneficiario_reclamobeneficiaro_1").toString());
        reclamo_reclamobeneficiaro_1 = fun.map(dkda.o(vars, "reclamo_reclamobeneficiaro_1").toString());
        reclamo_respuestareclamo_1 = fun.map(dkda.o(vars, "reclamo_respuestareclamo_1").toString());
        try {
            String opcion = dkda.o(vars, "accion").toString();
            String pestana = dkda.o(vars, "pestana").toString();

            respuesta = "";

            if (pestana.equals("reclamo") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_reclamo();
            }
            if (opcion.equals("Registrar") && pestana.equals("reclamo") && respuesta.length() == 0) {
                out.println(registrar_reclamo(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("reclamo") && respuesta.length() == 0) {
                out.println(actualizar_reclamo(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("reclamo") && respuesta.length() == 0) {
                out.println(eliminar_reclamo(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("reclamo") && respuesta.length() == 0) {
                out.println(obtener_reclamo(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("reclamodocumento") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_reclamodocumento();
            }
            if (opcion.equals("Registrar") && pestana.equals("reclamodocumento") && respuesta.length() == 0) {
                out.println(registrar_reclamodocumento(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("reclamodocumento") && respuesta.length() == 0) {
                out.println(actualizar_reclamodocumento(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("reclamodocumento") && respuesta.length() == 0) {
                out.println(eliminar_reclamodocumento(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("reclamodocumento") && respuesta.length() == 0) {
                out.println(obtener_reclamodocumento(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("reclamobeneficiaro") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_reclamobeneficiaro();
            }
            if (opcion.equals("Registrar") && pestana.equals("reclamobeneficiaro") && respuesta.length() == 0) {
                out.println(registrar_reclamobeneficiaro(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("reclamobeneficiaro") && respuesta.length() == 0) {
                out.println(actualizar_reclamobeneficiaro(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("reclamobeneficiaro") && respuesta.length() == 0) {
                out.println(eliminar_reclamobeneficiaro(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("reclamobeneficiaro") && respuesta.length() == 0) {
                out.println(obtener_reclamobeneficiaro(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("respuestareclamo") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_respuestareclamo();
            }
            if (opcion.equals("Registrar") && pestana.equals("respuestareclamo") && respuesta.length() == 0) {
                out.println(registrar_respuestareclamo(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("respuestareclamo") && respuesta.length() == 0) {
                out.println(actualizar_respuestareclamo(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("respuestareclamo") && respuesta.length() == 0) {
                out.println(eliminar_respuestareclamo(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("respuestareclamo") && respuesta.length() == 0) {
                out.println(obtener_respuestareclamo(con, dkda.o(vars, "codigo").toString()));
            }
            if (respuesta.length() > 0) {
                out.println(respuesta);
            }
        } finally {
            out.close();
        }
    }

    public String registrar_reclamo(ConexionBaseDatos con) {
        System.out.println("registrar_reclamo");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO reclamo (codunifami,reclamconsec,codtipoidentidadper,reclamidentiper,reclamfecha,coddepartamento,codmunicipio,rectipcodigo,recclacodigo,reclciclpago,codtipoidentidad,numidentfunc,reclamobserv,ususiscodigo,fecharegistro,reclarchdocu,reclarchdocu_nombre) VALUES (" + (dkda.o(vars, "codunifami_reclamo").equals("") ? null : "'" + dkda.o(vars, "codunifami_reclamo") + "'") + "," + (dkda.o(vars, "reclamconsec_reclamo").equals("") ? null : dkda.o(vars, "reclamconsec_reclamo")) + "," + (dkda.o(vars, "codtipoidentidadper_reclamo").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadper_reclamo") + "'") + "," + (dkda.o(vars, "reclamidentiper_reclamo").equals("") ? null : "'" + dkda.o(vars, "reclamidentiper_reclamo") + "'") + "," + (dkda.o(vars, "reclamfecha_reclamo").equals("") ? null : "'" + dkda.o(vars, "reclamfecha_reclamo") + "'") + "," + (dkda.o(municipio_reclamo_1, "coddepartamento").equals("") ? null : dkda.o(municipio_reclamo_1, "coddepartamento")) + "," + (dkda.o(municipio_reclamo_1, "codmunicipio").equals("") ? null : dkda.o(municipio_reclamo_1, "codmunicipio")) + "," + (dkda.o(reclamoclasificacion_reclamo_1, "rectipcodigo").equals("") ? null : "'" + dkda.o(reclamoclasificacion_reclamo_1, "rectipcodigo") + "'") + "," + (dkda.o(reclamoclasificacion_reclamo_1, "recclacodigo").equals("") ? null : "'" + dkda.o(reclamoclasificacion_reclamo_1, "recclacodigo") + "'") + "," + (dkda.o(vars, "reclciclpago_reclamo").equals("") ? null : dkda.o(vars, "reclciclpago_reclamo")) + "," + (dkda.o(vars, "codtipoidentidad_reclamo").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_reclamo") + "'") + "," + (dkda.o(vars, "numidentfunc_reclamo").equals("") ? null : "'" + dkda.o(vars, "numidentfunc_reclamo") + "'") + "," + (dkda.o(vars, "reclamobserv_reclamo").equals("") ? null : "'" + dkda.o(vars, "reclamobserv_reclamo") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "reclarchdocu_reclamo").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "reclarchdocu_reclamo") + "')") + "," + (dkda.o(vars, "reclarchdocu_reclamo").equals("") ? null : "'" + dkda.o(vars, "reclarchdocu_reclamo") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_reclamo&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_reclamo&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error reclamo.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_reclamo(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE reclamo SET codunifami = " + (dkda.o(vars, "codunifami_reclamo").equals("") ? null : "'" + dkda.o(vars, "codunifami_reclamo") + "'") + ",reclamconsec = " + (dkda.o(vars, "reclamconsec_reclamo").equals("") ? null : dkda.o(vars, "reclamconsec_reclamo")) + ",codtipoidentidadper = " + (dkda.o(vars, "codtipoidentidadper_reclamo").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadper_reclamo") + "'") + ",reclamidentiper = " + (dkda.o(vars, "reclamidentiper_reclamo").equals("") ? null : "'" + dkda.o(vars, "reclamidentiper_reclamo") + "'") + ",reclamfecha = " + (dkda.o(vars, "reclamfecha_reclamo").equals("") ? null : "'" + dkda.o(vars, "reclamfecha_reclamo") + "'") + ",coddepartamento = " + (dkda.o(municipio_reclamo_1, "coddepartamento").equals("") ? null : dkda.o(municipio_reclamo_1, "coddepartamento")) + ",codmunicipio = " + (dkda.o(municipio_reclamo_1, "codmunicipio").equals("") ? null : dkda.o(municipio_reclamo_1, "codmunicipio")) + ",rectipcodigo = " + (dkda.o(reclamoclasificacion_reclamo_1, "rectipcodigo").equals("") ? null : "'" + dkda.o(reclamoclasificacion_reclamo_1, "rectipcodigo") + "'") + ",recclacodigo = " + (dkda.o(reclamoclasificacion_reclamo_1, "recclacodigo").equals("") ? null : "'" + dkda.o(reclamoclasificacion_reclamo_1, "recclacodigo") + "'") + ",reclciclpago = " + (dkda.o(vars, "reclciclpago_reclamo").equals("") ? null : dkda.o(vars, "reclciclpago_reclamo")) + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_reclamo").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_reclamo") + "'") + ",numidentfunc = " + (dkda.o(vars, "numidentfunc_reclamo").equals("") ? null : "'" + dkda.o(vars, "numidentfunc_reclamo") + "'") + ",reclamobserv = " + (dkda.o(vars, "reclamobserv_reclamo").equals("") ? null : "'" + dkda.o(vars, "reclamobserv_reclamo") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",reclarchdocu = " + (dkda.o(vars, "reclarchdocu_reclamo").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "reclarchdocu_reclamo") + "')") + ",reclarchdocu_nombre = " + (dkda.o(vars, "reclarchdocu_reclamo").equals("") ? null : "'" + dkda.o(vars, "reclarchdocu_reclamo") + "'") + " WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND reclamconsec = " + dkda.o(sel, "reclamconsec") + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_reclamo&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_reclamo&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error reclamo.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_reclamo(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM reclamo WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND reclamconsec = " + dkda.o(sel, "reclamconsec") + " ");
            stmt.execute();
            respuesta = "opcion=eliminar_reclamo&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_reclamo&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error reclamo.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_reclamo(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;

            String sql = ""
                    + "SELECT reclamo.\"codunifami\"                    AS reclamo_codunifami, "
                    + "       reclamo.\"reclamconsec\"                  AS reclamo_reclamconsec, "
                    + "       reclamo.\"codtipoidentidadper\"           AS reclamo_codtipoidentidadper, "
                    + "       reclamo.\"reclamidentiper\"               AS reclamo_reclamidentiper, "
                    + "       reclamo.\"reclamfecha\"                   AS reclamo_reclamfecha, "
                    + "       reclamo.\"coddepartamento\"               AS reclamo_coddepartamento, "
                    + "       reclamo.\"codmunicipio\"                  AS reclamo_codmunicipio, "
                    + "       reclamo.\"rectipcodigo\"                  AS reclamo_rectipcodigo, "
                    + "       reclamo.\"recclacodigo\"                  AS reclamo_recclacodigo, "
                    + "       reclamo.\"reclciclpago\"                  AS reclamo_reclciclpago, "
                    + "       reclamo.\"codtipoidentidad\"              AS reclamo_codtipoidentidad, "
                    + "       reclamo.\"numidentfunc\"                  AS reclamo_numidentfunc, "
                    + "       reclamo.\"reclamobserv\"                  AS reclamo_reclamobserv, "
                    + "       reclamo.\"reclarchdocu\"                  AS reclamo_reclarchdocu, "
                    + "       reclamo.\"reclarchdocu_nombre\"           AS reclamo_reclarchdocu_nombre, "
                    + " CASE WHEN reclamo.reclarchdocu_nombre  IS NULL OR reclamo.reclarchdocu_nombre  = '' THEN 0 "
                    + " ELSE lo_export(reclamo.reclarchdocu, '" + fun.temp(request) + "' || reclamo.reclarchdocu_nombre ) END, "
                    + "       reclamoclasificacion.\"rectipcodigo\"     AS "
                    + "       reclamoclasificacion_rectipcodigo, "
                    + "       reclamoclasificacion.\"recclacodigo\"     AS "
                    + "       reclamoclasificacion_recclacodigo, "
                    + "       reclamoclasificacion.\"reccladescri\"     AS "
                    + "       reclamoclasificacion_reccladescri, "
                    + "       municipio.\"coddepartamento\"             AS municipio_coddepartamento, "
                    + "       municipio.\"codmunicipio\"                AS municipio_codmunicipio, "
                    + "       municipio.\"nombre\"                      AS municipio_nombre, "
                    + "       tipoidentificacion_1.\"codtipoidentidad\" AS "
                    + "       tipoidentificacion_codtipoidentidad_1, "
                    + "       tipoidentificacion_1.\"descripcion\"      AS "
                    + "       tipoidentificacion_descripcion_1, "
                    + "       tipoidentificacion_2.\"codtipoidentidad\" AS "
                    + "       tipoidentificacion_codtipoidentidad_2, "
                    + "       tipoidentificacion_2.\"descripcion\"      AS "
                    + "       tipoidentificacion_descripcion_2, "
                    + "       inscripcion.\"codunifami\"                AS inscripcion_codunifami "
                    + "FROM   \"public\".\"inscripcion\" inscripcion "
                    + "       INNER JOIN \"public\".\"reclamo\" reclamo "
                    + "         ON inscripcion.\"codunifami\" = reclamo.\"codunifami\" "
                    + "       INNER JOIN \"public\".\"municipio\" municipio "
                    + "         ON reclamo.\"coddepartamento\" = municipio.\"coddepartamento\" "
                    + "            AND municipio.\"codmunicipio\" = reclamo.\"codmunicipio\" "
                    + "       INNER JOIN \"public\".\"reclamoclasificacion\" reclamoclasificacion "
                    + "         ON reclamo.\"rectipcodigo\" = reclamoclasificacion.\"rectipcodigo\" "
                    + "            AND reclamoclasificacion.\"recclacodigo\" = reclamo.\"recclacodigo\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion_1 "
                    + "         ON reclamo.\"codtipoidentidadper\" = "
                    + "            tipoidentificacion_1.\"codtipoidentidad\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion_2 "
                    + "         ON reclamo.\"codtipoidentidad\" = tipoidentificacion_2.\"codtipoidentidad\" "
                    + "WHERE reclamo.codunifami = '" + dkda.o(sel, "codunifami") + "' "
                    + "AND reclamo.reclamconsec = " + dkda.o(sel, "reclamconsec") + " ";
            System.out.println(sql);

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#reclamobserv_reclamo|" + (rs.getString("reclamo_reclamobserv") == null ? "" : rs.getString("reclamo_reclamobserv")) + ":_";

            info += "text|#reclarchdocu_reclamo|" + (rs.getString("reclamo_reclarchdocu_nombre") == null ? "" : rs.getString("reclamo_reclarchdocu_nombre")) + ":_";

            info += "text|#numidentfunc_reclamo|" + (rs.getString("reclamo_numidentfunc") == null ? "" : rs.getString("reclamo_numidentfunc")) + ":_";

            info += "combo|#codtipoidentidad_reclamo|" + rs.getString("tipoidentificacion_codtipoidentidad_2") + "|llenarCombo('codtipoidentidad_reclamo', '"
                    + rs.getString("tipoidentificacion_codtipoidentidad_2") + "', '" + rs.getString("tipoidentificacion_descripcion_2") + "'):_";

            info += "text|#reclciclpago_reclamo|" + (rs.getString("reclamo_reclciclpago") == null ? "" : rs.getString("reclamo_reclciclpago")) + ":_";

            info += "combo|#reclamoclasificacion_reclamo_1|" + "reclamoclasificacion   rectipcodigo  " + rs.getString("reclamoclasificacion_rectipcodigo")
                    + "   recclacodigo  " + rs.getString("reclamoclasificacion_recclacodigo") + "|llenarCombo('reclamoclasificacion_reclamo_1', '"
                    + "reclamoclasificacion   rectipcodigo  " + rs.getString("reclamoclasificacion_rectipcodigo")
                    + "   recclacodigo  " + rs.getString("reclamoclasificacion_recclacodigo") + "', '" + rs.getString("reclamoclasificacion_reccladescri") + "'):_";


            info += "combo|#municipio_reclamo_1|" + "municipio   coddepartamento  " + rs.getString("municipio_coddepartamento")
                    + "   codmunicipio  " + rs.getString("municipio_codmunicipio") + "|llenarCombo('municipio_reclamo_1', '"
                    + "municipio   coddepartamento  " + rs.getString("municipio_coddepartamento")
                    + "   codmunicipio  " + rs.getString("municipio_codmunicipio") + "', '" + rs.getString("municipio_nombre") + "'):_";

            info += "text|#_fecha_reclamfecha_reclamo|" + (rs.getString("reclamo_reclamfecha") == null ? "" : rs.getString("reclamo_reclamfecha")) + ":_";

            info += "text|#reclamidentiper_reclamo|" + (rs.getString("reclamo_reclamidentiper") == null ? "" : rs.getString("reclamo_reclamidentiper")) + ":_";

            info += "combo|#codtipoidentidadper_reclamo|" + rs.getString("tipoidentificacion_codtipoidentidad_1") + "|llenarCombo('codtipoidentidadper_reclamo', '"
                    + rs.getString("tipoidentificacion_codtipoidentidad_1") + "', '" + rs.getString("tipoidentificacion_descripcion_1") + "'):_";

            info += "text|#reclamconsec_reclamo|" + (rs.getString("reclamo_reclamconsec") == null ? "" : rs.getString("reclamo_reclamconsec")) + ":_";

            info += "combo|#codunifami_reclamo|" + rs.getString("reclamo_codunifami") + "|llenarCombo('codunifami_reclamo', '"
                    + rs.getString("reclamo_codunifami") + "', '" + rs.getString("reclamo_codunifami") + "'):_";

            respuesta = "opcion=obtener_reclamo&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_reclamo&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error reclamo - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_reclamo() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM reclamo  WHERE codunifami = "
                    + "'" + dkda.o(vars, "codunifami_reclamo") + "'" + " AND reclamconsec = " + dkda.o(vars, "reclamconsec_reclamo") + "";
            System.out.println(sql);

            pQuery = conexion.prepareStatement(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_reclamo() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_reclamo() {
        String direccion = "opcion=registrar_reclamo&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_reclamo();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codunifami").toString().equals(dkda.o(vars, "codunifami_reclamo")) && dkda.o(sel, "reclamconsec").toString().equals(dkda.o(vars, "reclamconsec_reclamo"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codunifami_reclamo").isEmpty()) {
            error = "Código Único Familia: no puede ser vacio.";
        } else if (dkda.o(vars, "reclamconsec_reclamo").isEmpty()) {
            error = "Consecutivo del Reclamo: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidadper_reclamo").isEmpty()) {
            error = "Tipo de Identificacion Persona Afectada: no puede ser vacio.";
        } else if (dkda.o(vars, "reclamidentiper_reclamo").isEmpty()) {
            error = "Identificación Persona Afectada: no puede ser vacio.";
        } else if (dkda.o(vars, "reclamfecha_reclamo").isEmpty()) {
            error = "Fecha del Reclamo: no puede ser vacio.";
        } else if (dkda.o(municipio_reclamo_1, "coddepartamento").isEmpty()) {
            error = "Municipio: no puede ser vacio.";
        } else if (dkda.o(reclamoclasificacion_reclamo_1, "rectipcodigo").isEmpty()) {
            error = "Clasificación Reclamo: no puede ser vacio.";
        } else if (dkda.o(vars, "reclciclpago_reclamo").isEmpty()) {
            error = "Ciclo de Pago Afectado: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_reclamo").isEmpty()) {
            error = "Tipo Identificacion Funcionario que Recibe Reclamo: no puede ser vacio.";
        } else if (dkda.o(vars, "numidentfunc_reclamo").isEmpty()) {
            error = "Identificación Funcionario que Recibe Reclamo: no puede ser vacio.";
        } else if (dkda.o(vars, "reclarchdocu_reclamo").isEmpty()) {
            error = "Archivo Documento Reclamo: no puede ser vacio.";
        } else if (dkda.o(vars, "reclamobserv_reclamo").isEmpty()) {
            error = "Observaciones Reclamo: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "numidentfunc_reclamo"))) {
            error = "Identificación Funcionario que Recibe Reclamo: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "codtipoidentidad_reclamo").length() > 10) {
            error = "Tipo Identificacion Funcionario que Recibe Reclamo: Valor demasiado Largo.";
        } else if (dkda.o(vars, "numidentfunc_reclamo").length() > 18) {
            error = "Identificación Funcionario que Recibe Reclamo: Valor demasiado Largo.";
        } else if (dkda.o(vars, "reclamobserv_reclamo").length() > 400) {
            error = "Observaciones Reclamo: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_reclamodocumento(ConexionBaseDatos con) {
        System.out.println("registrar_reclamodocumento");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO reclamodocumento (codunifami,reclamconsec,codtipodctoasociado,recdocentrga,ususiscodigo,fecharegistro,recdocarchiv,recdocarchiv_nombre) VALUES (" + (dkda.o(reclamo_reclamodocumento_1, "codunifami").equals("") ? null : "'" + dkda.o(reclamo_reclamodocumento_1, "codunifami") + "'") + "," + (dkda.o(reclamo_reclamodocumento_1, "reclamconsec").equals("") ? null : dkda.o(reclamo_reclamodocumento_1, "reclamconsec")) + "," + (dkda.o(vars, "codtipodctoasociado_reclamodocumento").equals("") ? null : "'" + dkda.o(vars, "codtipodctoasociado_reclamodocumento") + "'") + "," + (dkda.o(vars, "recdocentrga_reclamodocumento").equals("") ? null : "'" + dkda.o(vars, "recdocentrga_reclamodocumento") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "recdocarchiv_reclamodocumento").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "recdocarchiv_reclamodocumento") + "')") + "," + (dkda.o(vars, "recdocarchiv_reclamodocumento").equals("") ? null : "'" + dkda.o(vars, "recdocarchiv_reclamodocumento") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_reclamodocumento&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_reclamodocumento&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error reclamodocumento.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_reclamodocumento(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE reclamodocumento SET codunifami = " + (dkda.o(reclamo_reclamodocumento_1, "codunifami").equals("") ? null : "'" + dkda.o(reclamo_reclamodocumento_1, "codunifami") + "'") + ",reclamconsec = " + (dkda.o(reclamo_reclamodocumento_1, "reclamconsec").equals("") ? null : dkda.o(reclamo_reclamodocumento_1, "reclamconsec")) + ",codtipodctoasociado = " + (dkda.o(vars, "codtipodctoasociado_reclamodocumento").equals("") ? null : "'" + dkda.o(vars, "codtipodctoasociado_reclamodocumento") + "'") + ",recdocentrga = " + (dkda.o(vars, "recdocentrga_reclamodocumento").equals("") ? null : "'" + dkda.o(vars, "recdocentrga_reclamodocumento") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",recdocarchiv = " + (dkda.o(vars, "recdocarchiv_reclamodocumento").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "recdocarchiv_reclamodocumento") + "')") + ",recdocarchiv_nombre = " + (dkda.o(vars, "recdocarchiv_reclamodocumento").equals("") ? null : "'" + dkda.o(vars, "recdocarchiv_reclamodocumento") + "'") + " WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND reclamconsec = " + dkda.o(sel, "reclamconsec") + " AND codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_reclamodocumento&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_reclamodocumento&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error reclamodocumento.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_reclamodocumento(ConexionBaseDatos con, String codigo) {
        System.out.println("Eliminar entra" + codigo);
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "DELETE FROM reclamodocumento WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' "
                    + "AND reclamconsec = " + dkda.o(sel, "reclamconsec") + " "
                    + "AND codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=eliminar_reclamodocumento&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_reclamodocumento&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error reclamodocumento.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_reclamodocumento(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;

            String sql = ""
                    + "SELECT reclamodocumento.\"codunifami\"          AS reclamodocumento_codunifami, "
                    + "       reclamodocumento.\"reclamconsec\"        AS reclamodocumento_reclamconsec, "
                    + "       reclamodocumento.\"codtipodctoasociado\" AS "
                    + "       reclamodocumento_codtipodctoasociado, "
                    + "       reclamodocumento.\"recdocentrga\"        AS reclamodocumento_recdocentrga, "
                    + "       reclamodocumento.\"recdocarchiv\"        AS reclamodocumento_recdocarchiv, "
                    + "       reclamodocumento.\"recdocarchiv_nombre\" AS "
                    + "       reclamodocumento_recdocarchiv_nombre, "
                    + "CASE WHEN reclamodocumento.recdocarchiv_nombre  IS NULL OR reclamodocumento.recdocarchiv_nombre  = '' THEN 0 "
                    + "ELSE lo_export(reclamodocumento.recdocarchiv, '" + fun.temp(request) + "' || reclamodocumento.recdocarchiv_nombre ) END, "
                    + "       tipodctoasociado.\"codtipodctoasociado\" AS "
                    + "       tipodctoasociado_codtipodctoasociado, "
                    + "       tipodctoasociado.\"descripcion\"         AS tipodctoasociado_descripcion, "
                    + "       reclamo.\"codunifami\"                   AS reclamo_codunifami, "
                    + "       reclamo.\"reclamconsec\"                 AS reclamo_reclamconsec "
                    + "FROM   \"public\".\"reclamo\" reclamo "
                    + "       INNER JOIN \"public\".\"reclamodocumento\" reclamodocumento "
                    + "         ON reclamo.\"codunifami\" = reclamodocumento.\"codunifami\" "
                    + "            AND reclamo.\"reclamconsec\" = reclamodocumento.\"reclamconsec\" "
                    + "       INNER JOIN \"public\".\"tipodctoasociado\" tipodctoasociado "
                    + "         ON reclamodocumento.\"codtipodctoasociado\" = "
                    + "            tipodctoasociado.\"codtipodctoasociado\" "
                    + "WHERE reclamodocumento.codunifami = '" + dkda.o(sel, "codunifami") + "' AND "
                    + "reclamodocumento.reclamconsec = " + dkda.o(sel, "reclamconsec") + " "
                    + "AND reclamodocumento.codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "' ";
            System.out.println(sql);

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#recdocarchiv_reclamodocumento|" + (rs.getString("reclamodocumento_recdocarchiv_nombre") == null ? "" : rs.getString("reclamodocumento_recdocarchiv_nombre")) + ":_";

            info += "switch|switch_recdocentrga_reclamodocumento|" + rs.getString("reclamodocumento_recdocentrga") + ":_";

            info += "combo|#codtipodctoasociado_reclamodocumento|" + rs.getString("tipodctoasociado_codtipodctoasociado") + "|llenarCombo('codtipodctoasociado_reclamodocumento', '"
                    + rs.getString("tipodctoasociado_codtipodctoasociado") + "', '" + rs.getString("tipodctoasociado_descripcion") + "'):_";

            info += "combo|#reclamo_reclamodocumento_1|" + "reclamo   codunifami  " + rs.getString("reclamodocumento_codunifami") + "   "
                    + "reclamconsec  " + rs.getString("reclamodocumento_reclamconsec") + "|llenarCombo('reclamo_reclamodocumento_1', '"
                    + "reclamo   codunifami  " + rs.getString("reclamodocumento_codunifami") + "   "
                    + "reclamconsec  " + rs.getString("reclamodocumento_reclamconsec") + "', '" + rs.getString("reclamodocumento_reclamconsec") + "'):_";


            respuesta = "opcion=obtener_reclamodocumento&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_reclamodocumento&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error reclamodocumento - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_reclamodocumento() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM reclamodocumento  WHERE "
                    + "codunifami = '" + dkda.o(reclamo_reclamodocumento_1, "codunifami") + "'" + " AND "
                    + "reclamconsec = " + dkda.o(reclamo_reclamodocumento_1, "reclamconsec") + "" + " "
                    + "AND codtipodctoasociado = '" + dkda.o(vars, "codtipodctoasociado_reclamodocumento") + "'";
            System.out.println(sql);
            pQuery = conexion.prepareStatement(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_reclamodocumento() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_reclamodocumento() {
        String direccion = "opcion=registrar_reclamodocumento&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_reclamodocumento();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codunifami").toString().equals(dkda.o(reclamo_reclamodocumento_1, "codunifami"))
                    && dkda.o(sel, "reclamconsec").toString().equals(dkda.o(reclamo_reclamodocumento_1, "reclamconsec"))
                    && dkda.o(sel, "codtipodctoasociado").toString().equals(dkda.o(vars, "codtipodctoasociado_reclamodocumento"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(reclamo_reclamodocumento_1, "codunifami").isEmpty()) {
            error = "Reclamo: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipodctoasociado_reclamodocumento").isEmpty()) {
            error = "Codigo tipo documento asociado: no puede ser vacio.";
        } else if (dkda.o(vars, "recdocentrga_reclamodocumento").isEmpty()) {
            error = "Documento Entregado (S/N): no puede ser vacio.";
        } else if (dkda.o(vars, "recdocarchiv_reclamodocumento").isEmpty()) {
            error = "Archivo Documento Asociado: no puede ser vacio.";
        }



        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_reclamobeneficiaro(ConexionBaseDatos con) {
        System.out.println("registrar_reclamobeneficiaro");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO reclamobeneficiaro (codunifami,reclamconsec,codtipoidentidad,identbenef,recbenobserv,ususiscodigo,fecharegistro) "
                    + "VALUES"
                    + " (" + (dkda.o(beneficiario_reclamobeneficiaro_1, "codunifami").equals("") ? null : "'" + dkda.o(beneficiario_reclamobeneficiaro_1,
                    "codunifami") + "'") + ","
                    + "" + (dkda.o(reclamo_reclamobeneficiaro_1, "reclamconsec").equals("") ? null : dkda.o(reclamo_reclamobeneficiaro_1, "reclamconsec")) + ","
                    + (dkda.o(beneficiario_reclamobeneficiaro_1, "codtipoidentidad").equals("") ? null : "'"
                    + dkda.o(beneficiario_reclamobeneficiaro_1, "codtipoidentidad") + "'") + "," + (dkda.o(beneficiario_reclamobeneficiaro_1, "identbenef").equals("")
                    ? null : "'" + dkda.o(beneficiario_reclamobeneficiaro_1, "identbenef") + "'") + "," + (dkda.o(vars, "recbenobserv_reclamobeneficiaro").equals("")
                    ? null : "'" + dkda.o(vars, "recbenobserv_reclamobeneficiaro") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_reclamobeneficiaro&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_reclamobeneficiaro&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error reclamobeneficiaro.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_reclamobeneficiaro(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE reclamobeneficiaro SET codunifami = " + (dkda.o(beneficiario_reclamobeneficiaro_1, "codunifami").equals("") ? null : "'" + dkda.o(beneficiario_reclamobeneficiaro_1, "codunifami") + "'") + ",reclamconsec = " + (dkda.o(reclamo_reclamobeneficiaro_1, "reclamconsec").equals("") ? null : dkda.o(reclamo_reclamobeneficiaro_1, "reclamconsec")) + ",codtipoidentidad = " + (dkda.o(beneficiario_reclamobeneficiaro_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(beneficiario_reclamobeneficiaro_1, "codtipoidentidad") + "'") + ",identbenef = " + (dkda.o(beneficiario_reclamobeneficiaro_1, "identbenef").equals("") ? null : "'" + dkda.o(beneficiario_reclamobeneficiaro_1, "identbenef") + "'") + ",recbenobserv = " + (dkda.o(vars, "recbenobserv_reclamobeneficiaro").equals("") ? null : "'" + dkda.o(vars, "recbenobserv_reclamobeneficiaro") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND reclamconsec = " + dkda.o(sel, "reclamconsec") + " AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND identbenef = '" + dkda.o(sel, "identbenef") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_reclamobeneficiaro&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_reclamobeneficiaro&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error reclamobeneficiaro.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_reclamobeneficiaro(ConexionBaseDatos con, String codigo) {
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
            String sql = "DELETE FROM reclamobeneficiaro WHERE "
                    + "codunifami = '" + dkda.o(sel, "codunifami") + "' AND"
                    + " reclamconsec = " + dkda.o(sel, "reclamconsec") + ""
                    + " AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "'"
                    + " AND identbenef = '" + dkda.o(sel, "identbenef") + "' ";

            System.out.print(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=eliminar_reclamobeneficiaro&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_reclamobeneficiaro&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error reclamobeneficiaro.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_reclamobeneficiaro(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT reclamobeneficiaro.\"codunifami\"       AS reclamobeneficiaro_codunifami, "
                    + "       reclamobeneficiaro.\"reclamconsec\"     AS reclamobeneficiaro_reclamconsec, "
                    + "       reclamobeneficiaro.\"codtipoidentidad\" AS "
                    + "       reclamobeneficiaro_codtipoidentidad, "
                    + "       reclamobeneficiaro.\"identbenef\"       AS reclamobeneficiaro_identbenef, "
                    + "       reclamobeneficiaro.\"recbenobserv\"     AS reclamobeneficiaro_recbenobserv, "
                    + "       reclamo.\"codunifami\"                  AS reclamo_codunifami, "
                    + "       reclamo.\"reclamconsec\"                AS reclamo_reclamconsec, "
                    + "       beneficiario.\"codunifami\"             AS beneficiario_codunifami, "
                    + "       beneficiario.\"identbenef\"             AS beneficiario_identbenef, "
                    + "       beneficiario.\"codtipoidentidad\"       AS beneficiario_codtipoidentidad "
                    + "FROM   \"public\".\"beneficiario\" beneficiario "
                    + "       INNER JOIN \"public\".\"reclamobeneficiaro\" reclamobeneficiaro "
                    + "         ON beneficiario.\"codunifami\" = reclamobeneficiaro.\"codunifami\" "
                    + "            AND beneficiario.\"identbenef\" = reclamobeneficiaro.\"identbenef\" "
                    + "            AND beneficiario.\"codtipoidentidad\" = "
                    + "                reclamobeneficiaro.\"codtipoidentidad\" "
                    + "       INNER JOIN \"public\".\"reclamo\" reclamo "
                    + "         ON reclamobeneficiaro.\"reclamconsec\" = reclamo.\"reclamconsec\" "
                    + "WHERE reclamobeneficiaro.codunifami = '" + dkda.o(sel, "codunifami") + "' AND "
                    + "reclamobeneficiaro.reclamconsec = " + dkda.o(sel, "reclamconsec") + " AND "
                    + "reclamobeneficiaro.codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND "
                    + "reclamobeneficiaro.identbenef = '" + dkda.o(sel, "identbenef") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#recbenobserv_reclamobeneficiaro|" + (rs.getString("reclamobeneficiaro_recbenobserv") == null ? "" : rs.getString("reclamobeneficiaro_recbenobserv")) + ":_";

            info += "combo|#beneficiario_reclamobeneficiaro_1|" + "beneficiario   codunifami  " + rs.getString("reclamobeneficiaro_codunifami") + "  "
                    + " codtipoidentidad  " + rs.getString("beneficiario_codtipoidentidad") + "   identbenef  "
                    + "" + rs.getString("reclamobeneficiaro_identbenef") + "|llenarCombo('beneficiario_reclamobeneficiaro_1', '"
                    + "beneficiario   codunifami  " + rs.getString("reclamobeneficiaro_codunifami") + "  "
                    + " codtipoidentidad  " + rs.getString("beneficiario_codtipoidentidad") + "   identbenef  "
                    + "" + rs.getString("reclamobeneficiaro_identbenef") + "', '" + rs.getString("reclamobeneficiaro_identbenef") + "'):_";

            info += "combo|#reclamo_reclamobeneficiaro_1|" + "reclamo   codunifami  " + rs.getString("reclamobeneficiaro_codunifami") + "  "
                    + " reclamconsec  " + rs.getString("reclamobeneficiaro_reclamconsec") + "|llenarCombo('reclamo_reclamobeneficiaro_1', '"
                    + "reclamo   codunifami  " + rs.getString("reclamobeneficiaro_codunifami") + "  "
                    + " reclamconsec  " + rs.getString("reclamobeneficiaro_reclamconsec") + "', '" + rs.getString("reclamobeneficiaro_reclamconsec") + "'):_";

            respuesta = "opcion=obtener_reclamobeneficiaro&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_reclamobeneficiaro&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error reclamobeneficiaro - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_reclamobeneficiaro() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM reclamobeneficiaro  WHERE "
                    + "codunifami = '" + dkda.o(beneficiario_reclamobeneficiaro_1, "codunifami") + "'" + " "
                    + "AND reclamconsec = " + dkda.o(reclamo_reclamobeneficiaro_1, "reclamconsec") + "" + " "
                    + "AND codtipoidentidad = '" + dkda.o(beneficiario_reclamobeneficiaro_1, "codtipoidentidad") + "'" + " "
                    + "AND identbenef = '" + dkda.o(beneficiario_reclamobeneficiaro_1, "identbenef") + "'";
            pQuery = conexion.prepareStatement(sql);
            System.out.println( sql );
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_reclamobeneficiaro() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_reclamobeneficiaro() {
        String direccion = "opcion=registrar_reclamobeneficiaro&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_reclamobeneficiaro();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codunifami").toString().equals(dkda.o(beneficiario_reclamobeneficiaro_1, "codunifami")) &&
                    dkda.o(sel, "reclamconsec").toString().equals(dkda.o(reclamo_reclamobeneficiaro_1, "reclamconsec_reclamobeneficiaro")) &&
                    dkda.o(sel, "codtipoidentidad").toString().equals(dkda.o(beneficiario_reclamobeneficiaro_1, "codtipoidentidad")) &&
                    dkda.o(sel, "identbenef").toString().equals(dkda.o(beneficiario_reclamobeneficiaro_1, "identbenef"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(reclamo_reclamobeneficiaro_1, "reclamconsec").isEmpty()) {
            error = "Reclamo: no puede ser vacio.";
        } else if (dkda.o(beneficiario_reclamobeneficiaro_1, "codunifami").isEmpty()) {
            error = "Beneficiario: no puede ser vacio.";
        } else if (dkda.o(vars, "recbenobserv_reclamobeneficiaro").isEmpty()) {
            error = "Observaciones Beneficiario Reclamo: no puede ser vacio.";
        }



        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_respuestareclamo(ConexionBaseDatos con) {
        System.out.println("registrar_respuestareclamo");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO respuestareclamo (codunifami,reclamconsec,resrecfecha,resclacodigo,codtipoidentidad,numidentfunc,resrecpercep,"
                    + "tipsatcodigo,resrecobserv,ususiscodigo,fecharegistro,resrecarcdoc,resrecarcdoc_nombre) VALUES "
                    + "(" + (dkda.o(reclamo_respuestareclamo_1, "codunifami").equals("") ? null : "'" + dkda.o(reclamo_respuestareclamo_1, "codunifami")
                    + "'") + "," + (dkda.o(reclamo_respuestareclamo_1, "reclamconsec").equals("") ? null : dkda.o(reclamo_respuestareclamo_1,
                    "reclamconsec")) + "," + (dkda.o(vars, "resrecfecha_respuestareclamo").equals("") ? null : "'"
                    + dkda.o(vars, "resrecfecha_respuestareclamo") + "'") + "," + (dkda.o(vars, "resclacodigo_respuestareclamo").equals("")
                    ? null : "'" + dkda.o(vars, "resclacodigo_respuestareclamo") + "'") + "," + (dkda.o(vars, "codtipoidentidad_respuestareclamo").equals("")
                    ? null : "'" + dkda.o(vars, "codtipoidentidad_respuestareclamo") + "'") + ","
                    + (dkda.o(vars, "numidentfunc_respuestareclamo").equals("") ? null : "'" + dkda.o(vars, "numidentfunc_respuestareclamo") + "'")
                    + "," + (dkda.o(vars, "resrecpercep_respuestareclamo").equals("") ? null : "'" + dkda.o(vars, "resrecpercep_respuestareclamo") + "'")
                    + "," + (dkda.o(vars, "tipsatcodigo_respuestareclamo").equals("") ? null : "'" + dkda.o(vars, "tipsatcodigo_respuestareclamo") + "'")
                    + "," + (dkda.o(vars, "resrecobserv_respuestareclamo").equals("") ? null : "'" + dkda.o(vars, "resrecobserv_respuestareclamo") + "'")
                    + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ","
                    + (dkda.o(vars, "resrecarcdoc_respuestareclamo").equals("") ? null : "lo_import('" + fun.temp(request)
                    + dkda.o(vars, "resrecarcdoc_respuestareclamo") + "')") + "," + (dkda.o(vars, "resrecarcdoc_respuestareclamo").equals("")
                    ? null : "'" + dkda.o(vars, "resrecarcdoc_respuestareclamo") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_respuestareclamo&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_respuestareclamo&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error respuestareclamo.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_respuestareclamo(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE respuestareclamo SET codunifami = " + (dkda.o(reclamo_respuestareclamo_1, "codunifami").equals("") ? null : "'" + dkda.o(reclamo_respuestareclamo_1, "codunifami") + "'") + ",reclamconsec = " + (dkda.o(reclamo_respuestareclamo_1, "reclamconsec").equals("") ? null : dkda.o(reclamo_respuestareclamo_1, "reclamconsec")) + ",resrecfecha = " + (dkda.o(vars, "resrecfecha_respuestareclamo").equals("") ? null : "'" + dkda.o(vars, "resrecfecha_respuestareclamo") + "'") + ",resclacodigo = " + (dkda.o(vars, "resclacodigo_respuestareclamo").equals("") ? null : "'" + dkda.o(vars, "resclacodigo_respuestareclamo") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_respuestareclamo").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_respuestareclamo") + "'") + ",numidentfunc = " + (dkda.o(vars, "numidentfunc_respuestareclamo").equals("") ? null : "'" + dkda.o(vars, "numidentfunc_respuestareclamo") + "'") + ",resrecpercep = " + (dkda.o(vars, "resrecpercep_respuestareclamo").equals("") ? null : "'" + dkda.o(vars, "resrecpercep_respuestareclamo") + "'") + ",tipsatcodigo = " + (dkda.o(vars, "tipsatcodigo_respuestareclamo").equals("") ? null : "'" + dkda.o(vars, "tipsatcodigo_respuestareclamo") + "'") + ",resrecobserv = " + (dkda.o(vars, "resrecobserv_respuestareclamo").equals("") ? null : "'" + dkda.o(vars, "resrecobserv_respuestareclamo") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",resrecarcdoc = " + (dkda.o(vars, "resrecarcdoc_respuestareclamo").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "resrecarcdoc_respuestareclamo") + "')") + ",resrecarcdoc_nombre = " + (dkda.o(vars, "resrecarcdoc_respuestareclamo").equals("") ? null : "'" + dkda.o(vars, "resrecarcdoc_respuestareclamo") + "'") + " WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND reclamconsec = " + dkda.o(sel, "reclamconsec") + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_respuestareclamo&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_respuestareclamo&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error respuestareclamo.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_respuestareclamo(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM respuestareclamo WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND reclamconsec = " + dkda.o(sel, "reclamconsec") + " ");
            stmt.execute();
            respuesta = "opcion=eliminar_respuestareclamo&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_respuestareclamo&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error respuestareclamo.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_respuestareclamo(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT respuestareclamo.\"codunifami\"          AS respuestareclamo_codunifami, "
                    + "       respuestareclamo.\"reclamconsec\"        AS respuestareclamo_reclamconsec, "
                    + "       respuestareclamo.\"resrecfecha\"         AS respuestareclamo_resrecfecha, "
                    + "       respuestareclamo.\"resclacodigo\"        AS respuestareclamo_resclacodigo, "
                    + "       respuestareclamo.\"codtipoidentidad\"    AS "
                    + "       respuestareclamo_codtipoidentidad, "
                    + "       respuestareclamo.\"numidentfunc\"        AS respuestareclamo_numidentfunc, "
                    + "       respuestareclamo.\"resrecpercep\"        AS respuestareclamo_resrecpercep, "
                    + "       respuestareclamo.\"tipsatcodigo\"        AS respuestareclamo_tipsatcodigo, "
                    + "       respuestareclamo.\"resrecobserv\"        AS respuestareclamo_resrecobserv, "
                    + "       respuestareclamo.\"resrecarcdoc\"        AS respuestareclamo_resrecarcdoc, "
                    + "       respuestareclamo.\"resrecarcdoc_nombre\" AS "
                    + "       respuestareclamo_resrecarcdoc_nombre, "
                    + " CASE WHEN respuestareclamo.resrecarcdoc_nombre  IS NULL OR respuestareclamo.resrecarcdoc_nombre  = '' THEN 0 "
                    + " ELSE lo_export(respuestareclamo.resrecarcdoc, '" + fun.temp(request) + "' || respuestareclamo.resrecarcdoc_nombre ) END, "
                    + "       satisfacciontipo.\"tipsatcodigo\"        AS satisfacciontipo_tipsatcodigo, "
                    + "       satisfacciontipo.\"tipsatdescri\"        AS satisfacciontipo_tipsatdescri, "
                    + "       respuestaclasificacion.\"rescladescri\"  AS "
                    + "       respuestaclasificacion_rescladescri, "
                    + "       respuestaclasificacion.\"resclacodigo\"  AS "
                    + "       respuestaclasificacion_resclacodigo, "
                    + "       reclamo.\"codunifami\"                   AS reclamo_codunifami, "
                    + "       reclamo.\"reclamconsec\"                 AS reclamo_reclamconsec, "
                    + "       tipoidentificacion.\"codtipoidentidad\"  AS "
                    + "       tipoidentificacion_codtipoidentidad, "
                    + "       tipoidentificacion.\"descripcion\"       AS tipoidentificacion_descripcion "
                    + "FROM   \"public\".\"reclamo\" reclamo "
                    + "       INNER JOIN \"public\".\"respuestareclamo\" respuestareclamo "
                    + "         ON reclamo.\"codunifami\" = respuestareclamo.\"codunifami\" "
                    + "            AND reclamo.\"reclamconsec\" = respuestareclamo.\"reclamconsec\" "
                    + "       INNER JOIN \"public\".\"respuestaclasificacion\" respuestaclasificacion "
                    + "         ON respuestareclamo.\"resclacodigo\" = "
                    + "            respuestaclasificacion.\"resclacodigo\" "
                    + "       INNER JOIN \"public\".\"satisfacciontipo\" satisfacciontipo "
                    + "         ON respuestareclamo.\"tipsatcodigo\" = satisfacciontipo.\"tipsatcodigo\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON respuestareclamo.\"codtipoidentidad\" = "
                    + "            tipoidentificacion.\"codtipoidentidad\" "
                    + "WHERE respuestareclamo.codunifami = '" + dkda.o(sel, "codunifami") + "' AND "
                    + "respuestareclamo.reclamconsec = " + dkda.o(sel, "reclamconsec") + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#resrecobserv_respuestareclamo|" + (rs.getString("respuestareclamo_resrecobserv") == null ? "" : rs.getString("respuestareclamo_resrecobserv")) + ":_";

            info += "text|#resrecpercep_respuestareclamo|" + (rs.getString("respuestareclamo_resrecpercep") == null ? "" : rs.getString("respuestareclamo_resrecpercep")) + ":_";

            info += "text|#resrecarcdoc_respuestareclamo|" + (rs.getString("respuestareclamo_resrecarcdoc_nombre") == null ? "" : rs.getString("respuestareclamo_resrecarcdoc_nombre")) + ":_";

            info += "combo|#tipsatcodigo_respuestareclamo|" + rs.getString("satisfacciontipo_tipsatcodigo")
                    + "|llenarCombo('tipsatcodigo_respuestareclamo', '"
                    + rs.getString("satisfacciontipo_tipsatcodigo") + "', '" + rs.getString("satisfacciontipo_tipsatdescri") + "'):_";

            info += "text|#numidentfunc_respuestareclamo|" + (rs.getString("respuestareclamo_numidentfunc") == null ? "" : rs.getString("respuestareclamo_numidentfunc")) + ":_";

            info += "combo|#codtipoidentidad_respuestareclamo|" + rs.getString("tipoidentificacion_codtipoidentidad")
                    + "|llenarCombo('codtipoidentidad_respuestareclamo', '"
                    + rs.getString("tipoidentificacion_codtipoidentidad") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";

            info += "combo|#resclacodigo_respuestareclamo|" + rs.getString("respuestaclasificacion_resclacodigo") + "|llenarCombo('resclacodigo_respuestareclamo', '"
                    + rs.getString("respuestaclasificacion_resclacodigo") + "', '" + rs.getString("respuestaclasificacion_rescladescri") + "'):_";

            info += "text|#_fecha_resrecfecha_respuestareclamo|" + (rs.getString("respuestareclamo_resrecfecha") == null ? "" : rs.getString("respuestareclamo_resrecfecha")) + ":_";

            info += "combo|#reclamo_respuestareclamo_1|" + "reclamo   codunifami  " + rs.getString("respuestareclamo_codunifami") + "  "
                    + " reclamconsec  " + rs.getString("respuestareclamo_reclamconsec") + "|llenarCombo('reclamo_respuestareclamo_1', '"
                    + "reclamo   codunifami  " + rs.getString("respuestareclamo_codunifami") + "  "
                    + " reclamconsec  " + rs.getString("respuestareclamo_reclamconsec") + "', '" + rs.getString("respuestareclamo_reclamconsec") + "'):_";


            respuesta = "opcion=obtener_respuestareclamo&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_respuestareclamo&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error respuestareclamo - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_respuestareclamo() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM respuestareclamo  WHERE "
                    + "codunifami = '" + dkda.o(reclamo_respuestareclamo_1, "codunifami") + "'" + " AND reclamconsec = " + dkda.o(reclamo_respuestareclamo_1, "reclamconsec") + "";
            pQuery = conexion.prepareStatement(sql);
            System.out.println(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_respuestareclamo() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_respuestareclamo() {
        String direccion = "opcion=registrar_respuestareclamo&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_respuestareclamo();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codunifami").toString().equals(dkda.o(reclamo_respuestareclamo_1, "codunifami"))
                    && dkda.o(sel, "reclamconsec").toString().equals(dkda.o(reclamo_respuestareclamo_1, "reclamconsec"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(reclamo_respuestareclamo_1, "codunifami").isEmpty()) {
            error = "Reclamo: no puede ser vacio.";
        } else if (dkda.o(vars, "resrecfecha_respuestareclamo").isEmpty()) {
            error = "Fecha Respuesta Reclamo: no puede ser vacio.";
        } else if (dkda.o(vars, "resclacodigo_respuestareclamo").isEmpty()) {
            error = "Código Clasificación Respuesta: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_respuestareclamo").isEmpty()) {
            error = "Tipo Identificacion Funcionario Respuesta: no puede ser vacio.";
        } else if (dkda.o(vars, "numidentfunc_respuestareclamo").isEmpty()) {
            error = "Numero Documento Identidad Funcionario Respuesta: no puede ser vacio.";
        } else if (dkda.o(vars, "tipsatcodigo_respuestareclamo").isEmpty()) {
            error = "Código Tipo de Satisfacción: no puede ser vacio.";
        } else if (dkda.o(vars, "resrecarcdoc_respuestareclamo").isEmpty()) {
            error = "Archivo Respuesta Reclamo: no puede ser vacio.";
        } else if (dkda.o(vars, "resrecpercep_respuestareclamo").isEmpty()) {
            error = "Percepción Usuario Respuesta Reclamo: no puede ser vacio.";
        } else if (dkda.o(vars, "resrecobserv_respuestareclamo").isEmpty()) {
            error = "Observaciones Respuesta Reclamo: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "numidentfunc_respuestareclamo"))) {
            error = "Numero Documento Identidad Funcionario que da Respuesta: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "numidentfunc_respuestareclamo").length() > 18) {
            error = "Numero Documento Identidad Funcionario que da Respuesta: Valor demasiado Largo.";
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
