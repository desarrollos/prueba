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

public class Novedad extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, documentocausal_novedaddocumento_1, novedadcausal_novedad_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());

        novedadcausal_novedad_1 = fun.map(dkda.o(vars, "novedadcausal_novedad_1").toString());
        documentocausal_novedaddocumento_1 = fun.map(dkda.o(vars, "documentocausal_novedaddocumento_1").toString());


        try {
            String opcion = dkda.o(vars, "accion").toString();
            String pestana = dkda.o(vars, "pestana").toString();
            respuesta = "";

            if (pestana.equals("novedad") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_novedad();
            }
            if (opcion.equals("Registrar") && pestana.equals("novedad") && respuesta.length() == 0) {
                out.println(registrar_novedad(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("novedad") && respuesta.length() == 0) {
                out.println(actualizar_novedad(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("novedad") && respuesta.length() == 0) {
                out.println(eliminar_novedad(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("novedad") && respuesta.length() == 0) {
                out.println(obtener_novedad(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("novedadcampo") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_novedadcampo();
            }
            if (opcion.equals("Registrar") && pestana.equals("novedadcampo") && respuesta.length() == 0) {
                out.println(registrar_novedadcampo(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("novedadcampo") && respuesta.length() == 0) {
                out.println(actualizar_novedadcampo(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("novedadcampo") && respuesta.length() == 0) {
                out.println(eliminar_novedadcampo(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("novedadcampo") && respuesta.length() == 0) {
                out.println(obtener_novedadcampo(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("novedaddocumento") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_novedaddocumento();
            }
            if (opcion.equals("Registrar") && pestana.equals("novedaddocumento") && respuesta.length() == 0) {
                out.println(registrar_novedaddocumento(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("novedaddocumento") && respuesta.length() == 0) {
                out.println(actualizar_novedaddocumento(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("novedaddocumento") && respuesta.length() == 0) {
                out.println(eliminar_novedaddocumento(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("novedaddocumento") && respuesta.length() == 0) {
                out.println(obtener_novedaddocumento(con, dkda.o(vars, "codigo").toString()));
            }
            if (respuesta.length() > 0) {
                out.println(respuesta);
            }
        } finally {
            out.close();
        }
    }

    public String registrar_novedad(ConexionBaseDatos con) {
        System.out.println("registrar_novedad");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO novedad (noveconsecut,codunifami,codtipoidentidad,noveidentifi,codtiponovedad,novcaucodigo,novefechsoli,"
                    + "novefechnove,tippercodigo,noveobservac,ususiscodigo,fecharegistro,novearchivo,novearchivo_nombre) VALUES"
                    + " (" + (dkda.o(vars, "noveconsecut_novedad").equals("") ? null : dkda.o(vars, "noveconsecut_novedad")) + ","
                    + (dkda.o(vars, "codunifami_novedad").equals("") ? null : "'" + dkda.o(vars, "codunifami_novedad") + "'") + ","
                    + (dkda.o(vars, "codtipoidentidad_novedad").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_novedad") + "'") + ","
                    + (dkda.o(vars, "noveidentifi_novedad").equals("") ? null : "'" + dkda.o(vars, "noveidentifi_novedad") + "'") + ","
                    + (dkda.o(novedadcausal_novedad_1, "codtiponovedad").equals("") ? null : "'" + dkda.o(novedadcausal_novedad_1, "codtiponovedad") + "'")
                    + "," + (dkda.o(novedadcausal_novedad_1, "novcaucodigo").equals("") ? null : "'" + dkda.o(novedadcausal_novedad_1, "novcaucodigo") + "'")
                    + "," + (dkda.o(vars, "novefechsoli_novedad").equals("") ? null : "'"
                    + dkda.o(vars, "novefechsoli_novedad") + "'") + "," + (dkda.o(vars, "novefechnove_novedad").equals("") ? null : "'"
                    + dkda.o(vars, "novefechnove_novedad") + "'") + "," + (dkda.o(vars, "tippercodigo_novedad").equals("") ? null : "'"
                    + dkda.o(vars, "tippercodigo_novedad") + "'") + "," + (dkda.o(vars, "noveobservac_novedad").equals("") ? null : "'"
                    + dkda.o(vars, "noveobservac_novedad") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ","
                    + (dkda.o(vars, "novearchivo_novedad").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "novearchivo_novedad") + "')")
                    + "," + (dkda.o(vars, "novearchivo_novedad").equals("") ? null : "'" + dkda.o(vars, "novearchivo_novedad") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_novedad&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_novedad&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error novedad.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_novedad(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE novedad SET noveconsecut = " + (dkda.o(vars, "noveconsecut_novedad").equals("") ? null : dkda.o(vars, "noveconsecut_novedad")) + ",codunifami = " + (dkda.o(vars, "codunifami_novedad").equals("") ? null : "'" + dkda.o(vars, "codunifami_novedad") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_novedad").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_novedad") + "'") + ",noveidentifi = " + (dkda.o(vars, "noveidentifi_novedad").equals("") ? null : "'" + dkda.o(vars, "noveidentifi_novedad") + "'") + ",codtiponovedad = " + (dkda.o(novedadcausal_novedad_1, "codtiponovedad").equals("") ? null : "'" + dkda.o(novedadcausal_novedad_1, "codtiponovedad") + "'") + ",novcaucodigo = " + (dkda.o(novedadcausal_novedad_1, "novcaucodigo").equals("") ? null : "'" + dkda.o(novedadcausal_novedad_1, "novcaucodigo") + "'") + ",novefechsoli = " + (dkda.o(vars, "novefechsoli_novedad").equals("") ? null : "'" + dkda.o(vars, "novefechsoli_novedad") + "'") + ",novefechnove = " + (dkda.o(vars, "novefechnove_novedad").equals("") ? null : "'" + dkda.o(vars, "novefechnove_novedad") + "'") + ",tippercodigo = " + (dkda.o(vars, "tippercodigo_novedad").equals("") ? null : "'" + dkda.o(vars, "tippercodigo_novedad") + "'") + ",noveobservac = " + (dkda.o(vars, "noveobservac_novedad").equals("") ? null : "'" + dkda.o(vars, "noveobservac_novedad") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",novearchivo = " + (dkda.o(vars, "novearchivo_novedad").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "novearchivo_novedad") + "')") + ",novearchivo_nombre = " + (dkda.o(vars, "novearchivo_novedad").equals("") ? null : "'" + dkda.o(vars, "novearchivo_novedad") + "'") + " WHERE noveconsecut = " + dkda.o(vars, "codigo") + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_novedad&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_novedad&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error novedad.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_novedad(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM novedad WHERE noveconsecut = " + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "");
            stmt.execute();
            respuesta = "opcion=eliminar_novedad&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_novedad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error novedad.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_novedad(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT novedad.\"noveconsecut\"                AS novedad_noveconsecut, "
                    + "       novedad.\"codunifami\"                  AS novedad_codunifami, "
                    + "       novedad.\"codtipoidentidad\"            AS novedad_codtipoidentidad, "
                    + "       novedad.\"noveidentifi\"                AS novedad_noveidentifi, "
                    + "       novedad.\"codtiponovedad\"              AS novedad_codtiponovedad, "
                    + "       novedad.\"novcaucodigo\"                AS novedad_novcaucodigo, "
                    + "       novedad.\"novefechsoli\"                AS novedad_novefechsoli, "
                    + "       novedad.\"novefechnove\"                AS novedad_novefechnove, "
                    + "       novedad.\"tippercodigo\"                AS novedad_tippercodigo, "
                    + "       novedad.\"noveobservac\"                AS novedad_noveobservac, "
                    + "       novedad.\"novearchivo_nombre\"          AS novedad_novearchivo_nombre, "
                    + " CASE WHEN novedad.novearchivo_nombre  IS NULL OR novedad.novearchivo_nombre  = '' THEN 0 "
                    + " ELSE lo_export(novedad.novearchivo, '" + fun.temp(request) + "' || novedad.novearchivo_nombre ) END, "
                    + "       inscripcion.\"codunifami\"              AS inscripcion_codunifami, "
                    + "       novedadcausal.\"codtiponovedad\"        AS novedadcausal_codtiponovedad, "
                    + "       novedadcausal.\"novcaucodigo\"          AS novedadcausal_novcaucodigo, "
                    + "       novedadcausal.\"novcaudescri\"          AS novedadcausal_novcaudescri, "
                    + "       tipoidentificacion.\"codtipoidentidad\" AS "
                    + "       tipoidentificacion_codtipoidentidad, "
                    + "       tipoidentificacion.\"descripcion\"      AS tipoidentificacion_descripcion, "
                    + "       tipopersona.\"tippercodigo\"            AS tipopersona_tippercodigo, "
                    + "       tipopersona.\"tipperdescri\"            AS tipopersona_tipperdescri "
                    + "FROM   \"public\".\"inscripcion\" inscripcion "
                    + "       INNER JOIN \"public\".\"novedad\" novedad "
                    + "         ON inscripcion.\"codunifami\" = novedad.\"codunifami\" "
                    + "       INNER JOIN \"public\".\"novedadcausal\" novedadcausal "
                    + "         ON novedad.\"codtiponovedad\" = novedadcausal.\"codtiponovedad\" "
                    + "            AND novedadcausal.\"novcaucodigo\" = novedad.\"novcaucodigo\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON novedad.\"codtipoidentidad\" = tipoidentificacion.\"codtipoidentidad\" "
                    + "       INNER JOIN \"public\".\"tipopersona\" tipopersona "
                    + "         ON novedad.\"tippercodigo\" = tipopersona.\"tippercodigo\" WHERE noveconsecut = " + dkda.o(vars, "codigo") + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#noveobservac_novedad|" + (rs.getString("novedad_noveobservac") == null ? "" : rs.getString("novedad_noveobservac")) + ":_";

            info += "text|#novearchivo_novedad|" + (rs.getString("novedad_novearchivo_nombre") == null ? "" : rs.getString("novedad_novearchivo_nombre")) + ":_";

            info += "combo|#tippercodigo_novedad|" + rs.getString("tipopersona_tippercodigo") + "|llenarCombo('tippercodigo_novedad', '"
                    + rs.getString("tipopersona_tippercodigo") + "', '" + rs.getString("tipopersona_tipperdescri") + "'):_";

            info += "text|#_fecha_novefechnove_novedad|" + (rs.getString("novedad_novefechnove") == null ? "" : rs.getString("novedad_novefechnove")) + ":_";

            info += "text|#_fecha_novefechsoli_novedad|" + (rs.getString("novedad_novefechsoli") == null ? "" : rs.getString("novedad_novefechsoli")) + ":_";

            info += "combo|#novedadcausal_novedad_1|" + "novedadcausal   codtiponovedad  " + rs.getString("novedadcausal_codtiponovedad") + "   novcaucodigo  " + rs.getString("novedadcausal_novcaucodigo") + "|llenarCombo('novedadcausal_novedad_1', '"
                    + "novedadcausal   codtiponovedad  " + rs.getString("novedadcausal_codtiponovedad") + "   novcaucodigo  " + rs.getString("novedadcausal_novcaucodigo") + "', '" + rs.getString("novedadcausal_novcaudescri") + "'):_";

            info += "text|#noveidentifi_novedad|" + (rs.getString("novedad_noveidentifi") == null ? "" : rs.getString("novedad_noveidentifi")) + ":_";

            info += "combo|#codtipoidentidad_novedad|" + rs.getString("tipoidentificacion_codtipoidentidad") + "|llenarCombo('codtipoidentidad_novedad', '"
                    + rs.getString("tipoidentificacion_codtipoidentidad") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";

            info += "combo|#codunifami_novedad|" + rs.getString("inscripcion_codunifami") + "|llenarCombo('codunifami_novedad', '"
                    + rs.getString("inscripcion_codunifami") + "', '" + rs.getString("inscripcion_codunifami") + "'):_";

            info += "text|#noveconsecut_novedad|" + (rs.getString("novedad_noveconsecut") == null ? "" : rs.getString("novedad_noveconsecut")) + ":_";

            respuesta = "opcion=obtener_novedad&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_novedad&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error novedad - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_novedad() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM novedad  WHERE noveconsecut = " + dkda.o(vars, "noveconsecut_novedad") + "";
            pQuery = conexion.prepareStatement(sql);
            System.out.println(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_novedad() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_novedad() {
        String direccion = "opcion=registrar_novedad&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_novedad();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "noveconsecut_novedad"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "noveconsecut_novedad").isEmpty()) {
            error = "Consecutivo Novedad: no puede ser vacio.";
        } else if (dkda.o(vars, "codunifami_novedad").isEmpty()) {
            error = "Código Único Familia: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_novedad").isEmpty()) {
            error = "Tipo Identificacion Persona Presenta Novedad: no puede ser vacio.";
        } else if (dkda.o(vars, "noveidentifi_novedad").isEmpty()) {
            error = "Identificación Persona que Presenta la Novedad: no puede ser vacio.";
        } else if (dkda.o(novedadcausal_novedad_1, "codtiponovedad").isEmpty()) {
            error = "Codigo Tipo Novedad: no puede ser vacio.";
        } else if (dkda.o(vars, "novefechsoli_novedad").isEmpty()) {
            error = "Fecha Solicitud Novedad: no puede ser vacio.";
        } else if (dkda.o(vars, "novefechnove_novedad").isEmpty()) {
            error = "Fecha Novedad: no puede ser vacio.";
        } else if (dkda.o(vars, "tippercodigo_novedad").isEmpty()) {
            error = "Código Tipo de Persona: no puede ser vacio.";
        } else if (dkda.o(vars, "novearchivo_novedad").isEmpty()) {
            error = "Archivo Documento de la Novedad: no puede ser vacio.";
        } else if (dkda.o(vars, "noveobservac_novedad").isEmpty()) {
            error = "Observaciones Novedad: no puede ser vacio.";
        } else if (!v.numDecimal(dkda.o(vars, "noveconsecut_novedad"))) {
            error = "Consecutivo Novedad: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "noveidentifi_novedad"))) {
            error = "Identificación Persona que Presenta la Novedad: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "noveconsecut_novedad").length() > 9) {
            error = "Consecutivo Novedad: Valor demasiado Largo.";
        } else if (dkda.o(vars, "noveidentifi_novedad").length() > 10) {
            error = "Identificación Persona que Presenta la Novedad: Valor demasiado Largo.";
        } else if (dkda.o(vars, "noveobservac_novedad").length() > 400) {
            error = "Observaciones Novedad: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_novedadcampo(ConexionBaseDatos con) {
        System.out.println("registrar_novedadcampo");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO novedadcampo (idusuario,codtiponovedad,codcampoarchivo,fecha,datoanterior,datoactualizado,observacion,ususiscodigo,fecharegistro,idencabezado,codestadoregistro) VALUES (" + (dkda.o(vars, "idusuario_novedadcampo").equals("") ? null : dkda.o(vars, "idusuario_novedadcampo")) + "," + (dkda.o(vars, "codtiponovedad_novedadcampo").equals("") ? null : "'" + dkda.o(vars, "codtiponovedad_novedadcampo") + "'") + "," + (dkda.o(vars, "codcampoarchivo_novedadcampo").equals("") ? null : dkda.o(vars, "codcampoarchivo_novedadcampo")) + "," + (dkda.o(vars, "fecha_novedadcampo").equals("") ? null : "'" + dkda.o(vars, "fecha_novedadcampo") + "'") + "," + (dkda.o(vars, "datoanterior_novedadcampo").equals("") ? null : "'" + dkda.o(vars, "datoanterior_novedadcampo") + "'") + "," + (dkda.o(vars, "datoactualizado_novedadcampo").equals("") ? null : "'" + dkda.o(vars, "datoactualizado_novedadcampo") + "'") + "," + (dkda.o(vars, "observacion_novedadcampo").equals("") ? null : "'" + dkda.o(vars, "observacion_novedadcampo") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "idencabezado_novedadcampo").equals("") ? null : dkda.o(vars, "idencabezado_novedadcampo")) + "," + (dkda.o(vars, "codestadoregistro_novedadcampo").equals("") ? null : "'" + dkda.o(vars, "codestadoregistro_novedadcampo") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_novedadcampo&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_novedadcampo&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error novedadcampo.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_novedadcampo(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE novedadcampo SET idusuario = " + (dkda.o(vars, "idusuario_novedadcampo").equals("") ? null : dkda.o(vars, "idusuario_novedadcampo")) + ",codtiponovedad = " + (dkda.o(vars, "codtiponovedad_novedadcampo").equals("") ? null : "'" + dkda.o(vars, "codtiponovedad_novedadcampo") + "'") + ",codcampoarchivo = " + (dkda.o(vars, "codcampoarchivo_novedadcampo").equals("") ? null : dkda.o(vars, "codcampoarchivo_novedadcampo")) + ",fecha = " + (dkda.o(vars, "fecha_novedadcampo").equals("") ? null : "'" + dkda.o(vars, "fecha_novedadcampo") + "'") + ",datoanterior = " + (dkda.o(vars, "datoanterior_novedadcampo").equals("") ? null : "'" + dkda.o(vars, "datoanterior_novedadcampo") + "'") + ",datoactualizado = " + (dkda.o(vars, "datoactualizado_novedadcampo").equals("") ? null : "'" + dkda.o(vars, "datoactualizado_novedadcampo") + "'") + ",observacion = " + (dkda.o(vars, "observacion_novedadcampo").equals("") ? null : "'" + dkda.o(vars, "observacion_novedadcampo") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",idencabezado = " + (dkda.o(vars, "idencabezado_novedadcampo").equals("") ? null : dkda.o(vars, "idencabezado_novedadcampo")) + ",codestadoregistro = " + (dkda.o(vars, "codestadoregistro_novedadcampo").equals("") ? null : "'" + dkda.o(vars, "codestadoregistro_novedadcampo") + "'") + " WHERE idusuario = " + dkda.o(sel, "idusuario") + " AND codtiponovedad = '" + dkda.o(sel, "codtiponovedad") + "' AND codcampoarchivo = " + dkda.o(sel, "codcampoarchivo") + " AND fecha = '" + dkda.o(sel, "fecha") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_novedadcampo&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_novedadcampo&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error novedadcampo.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_novedadcampo(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM novedadcampo WHERE idusuario = " + dkda.o(sel, "idusuario") + " AND codtiponovedad = '" + dkda.o(sel, "codtiponovedad") + "' AND codcampoarchivo = " + dkda.o(sel, "codcampoarchivo") + " AND fecha = '" + dkda.o(sel, "fecha") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_novedadcampo&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_novedadcampo&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error novedadcampo.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_novedadcampo(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT novedadcampo.\"idusuario\"             AS novedadcampo_idusuario, "
                    + "       novedadcampo.\"codtiponovedad\"        AS novedadcampo_codtiponovedad, "
                    + "       novedadcampo.\"codcampoarchivo\"       AS novedadcampo_codcampoarchivo, "
                    + "       novedadcampo.\"fecha\"                 AS novedadcampo_fecha, "
                    + "       novedadcampo.\"datoanterior\"          AS novedadcampo_datoanterior, "
                    + "       novedadcampo.\"datoactualizado\"       AS novedadcampo_datoactualizado, "
                    + "       novedadcampo.\"observacion\"           AS novedadcampo_observacion, "
                    + "       novedadcampo.\"idencabezado\"          AS novedadcampo_idencabezado, "
                    + "       novedadcampo.\"codestadoregistro\"     AS novedadcampo_codestadoregistro, "
                    + "       estadoregistro.\"codestadoregistro\"   AS estadoregistro_codestadoregistro, "
                    + "       estadoregistro.\"descripcion\"         AS estadoregistro_descripcion, "
                    + "       encabezadoarchivo.\"idencabezado\"     AS encabezadoarchivo_idencabezado, "
                    + "       listacamposarchivo.\"codcampoarchivo\" AS "
                    + "       listacamposarchivo_codcampoarchivo, "
                    + "       listacamposarchivo.\"descripcion\"     AS listacamposarchivo_descripcion, "
                    + "       tiponovedad.\"codtiponovedad\"         AS tiponovedad_codtiponovedad, "
                    + "       tiponovedad.\"descripcion\"            AS tiponovedad_descripcion "
                    + "FROM   \"public\".\"encabezadoarchivo\" encabezadoarchivo "
                    + "       INNER JOIN \"public\".\"novedadcampo\" novedadcampo "
                    + "         ON encabezadoarchivo.\"idencabezado\" = novedadcampo.\"idencabezado\" "
                    + "       INNER JOIN \"public\".\"estadoregistro\" estadoregistro "
                    + "         ON novedadcampo.\"codestadoregistro\" = "
                    + "            estadoregistro.\"codestadoregistro\" "
                    + "       INNER JOIN \"public\".\"listacamposarchivo\" listacamposarchivo "
                    + "         ON novedadcampo.\"codcampoarchivo\" = "
                    + "            listacamposarchivo.\"codcampoarchivo\" "
                    + "       INNER JOIN \"public\".\"tiponovedad\" tiponovedad "
                    + "         ON novedadcampo.\"codtiponovedad\" = tiponovedad.\"codtiponovedad\""
                    + " WHERE novedadcampo.idusuario = " + dkda.o(sel, "idusuario") + " AND novedadcampo.codtiponovedad = '"
                    + dkda.o(sel, "codtiponovedad") + "' AND novedadcampo.codcampoarchivo = " + dkda.o(sel, "codcampoarchivo")
                    + " AND novedadcampo.fecha = '" + dkda.o(sel, "fecha") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "combo|#codestadoregistro_novedadcampo|" + rs.getString("estadoregistro_codestadoregistro") + "|llenarCombo('codestadoregistro_novedadcampo', '"
                    + rs.getString("estadoregistro_codestadoregistro") + "', '" + rs.getString("estadoregistro_descripcion") + "'):_";

            info += "text|#observacion_novedadcampo|" + (rs.getString("novedadcampo_observacion") == null ? "" : rs.getString("novedadcampo_observacion")) + ":_";

            info += "combo|#idencabezado_novedadcampo|" + rs.getString("encabezadoarchivo_idencabezado") + "|llenarCombo('idencabezado_novedadcampo', '"
                    + rs.getString("encabezadoarchivo_idencabezado") + "', '" + rs.getString("encabezadoarchivo_idencabezado") + "'):_";

            info += "text|#datoactualizado_novedadcampo|" + (rs.getString("novedadcampo_datoactualizado") == null ? "" : rs.getString("novedadcampo_datoactualizado")) + ":_";

            info += "text|#datoanterior_novedadcampo|" + (rs.getString("novedadcampo_datoanterior") == null ? "" : rs.getString("novedadcampo_datoanterior")) + ":_";

            info += "text|#_fecha_fecha_novedadcampo|" + (rs.getString("novedadcampo_fecha") == null ? "" : rs.getString("novedadcampo_fecha")) + ":_";

            info += "combo|#codcampoarchivo_novedadcampo|" + rs.getString("listacamposarchivo_codcampoarchivo") + "|llenarCombo('codcampoarchivo_novedadcampo', '"
                    + rs.getString("listacamposarchivo_codcampoarchivo") + "', '" + rs.getString("listacamposarchivo_descripcion") + "'):_";

            info += "combo|#codtiponovedad_novedadcampo|" + rs.getString("tiponovedad_codtiponovedad") + "|llenarCombo('codtiponovedad_novedadcampo', '"
                    + rs.getString("tiponovedad_codtiponovedad") + "', '" + rs.getString("tiponovedad_descripcion") + "'):_";

            info += "text|#idusuario_novedadcampo|" + (rs.getString("novedadcampo_idusuario") == null ? "" : rs.getString("novedadcampo_idusuario")) + ":_";

            respuesta = "opcion=obtener_novedadcampo&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_novedadcampo&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error novedadcampo - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_novedadcampo() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM novedadcampo  WHERE idusuario = "
                    + dkda.o(vars, "idusuario_novedadcampo") + "" + " AND codtiponovedad = '" + dkda.o(vars, "codtiponovedad_novedadcampo") + "'"
                    + " AND codcampoarchivo = " + dkda.o(vars, "codcampoarchivo_novedadcampo") + "" + " AND fecha = '" + dkda.o(vars, "fecha_novedadcampo") + "'";
            System.out.println(sql);
            pQuery = conexion.prepareStatement(sql);
            rQuery = pQuery.executeQuery();

            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_novedadcampo() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_novedadcampo() {
        String direccion = "opcion=registrar_novedadcampo&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_novedadcampo();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "idusuario").toString().equals(dkda.o(vars, "idusuario_novedadcampo")) && dkda.o(sel, "codtiponovedad").toString().equals(dkda.o(vars, "codtiponovedad_novedadcampo")) && dkda.o(sel, "codcampoarchivo").toString().equals(dkda.o(vars, "codcampoarchivo_novedadcampo")) && dkda.o(sel, "fecha").toString().equals(dkda.o(vars, "fecha_novedadcampo"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "idusuario_novedadcampo").isEmpty()) {
            error = "Id Usuario (cupo): no puede ser vacio.";
        } else if (dkda.o(vars, "codtiponovedad_novedadcampo").isEmpty()) {
            error = "Codigo Tipo Novedad: no puede ser vacio.";
        } else if (dkda.o(vars, "codcampoarchivo_novedadcampo").isEmpty()) {
            error = "Codigo Campo en el archivo o Tabla: no puede ser vacio.";
        } else if (dkda.o(vars, "fecha_novedadcampo").isEmpty()) {
            error = "Fecha Nnovedad: no puede ser vacio.";
        } else if (dkda.o(vars, "datoanterior_novedadcampo").isEmpty()) {
            error = "Dato anterior: no puede ser vacio.";
        } else if (dkda.o(vars, "datoactualizado_novedadcampo").isEmpty()) {
            error = "Dato actualizado: no puede ser vacio.";
        } else if (dkda.o(vars, "idencabezado_novedadcampo").isEmpty()) {
            error = "Encabezado Archivo: no puede ser vacio.";
        } else if (dkda.o(vars, "observacion_novedadcampo").isEmpty()) {
            error = "Observaciones: no puede ser vacio.";
        } else if (dkda.o(vars, "idusuario_novedadcampo").length() > 9) {
            error = "Id Usuario (cupo): Valor demasiado Largo.";
        } else if (dkda.o(vars, "datoanterior_novedadcampo").length() > 200) {
            error = "Dato anterior: Valor demasiado Largo.";
        } else if (dkda.o(vars, "datoactualizado_novedadcampo").length() > 200) {
            error = "Dato actualizado: Valor demasiado Largo.";
        } else if (dkda.o(vars, "observacion_novedadcampo").length() > 400) {
            error = "Observaciones: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_novedaddocumento(ConexionBaseDatos con) {
        System.out.println("registrar_novedaddocumento");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO novedaddocumento (noveconsecut,codtipodctoasociado,codtiponovedad,novcaucodigo,codtipoidentidad,novdocidenti,novdocdescri,ususiscodigo,fecharegistro,novdocarchiv,novdocarchiv_nombre) VALUES (" + (dkda.o(vars, "noveconsecut_novedaddocumento").equals("") ? null : dkda.o(vars, "noveconsecut_novedaddocumento")) + "," + (dkda.o(documentocausal_novedaddocumento_1, "codtipodctoasociado").equals("") ? null : "'" + dkda.o(documentocausal_novedaddocumento_1, "codtipodctoasociado") + "'") + "," + (dkda.o(documentocausal_novedaddocumento_1, "codtiponovedad").equals("") ? null : "'" + dkda.o(documentocausal_novedaddocumento_1, "codtiponovedad") + "'") + "," + (dkda.o(documentocausal_novedaddocumento_1, "novcaucodigo").equals("") ? null : "'" + dkda.o(documentocausal_novedaddocumento_1, "novcaucodigo") + "'") + "," + (dkda.o(vars, "codtipoidentidad_novedaddocumento").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_novedaddocumento") + "'") + "," + (dkda.o(vars, "novdocidenti_novedaddocumento").equals("") ? null : "'" + dkda.o(vars, "novdocidenti_novedaddocumento") + "'") + "," + (dkda.o(vars, "novdocdescri_novedaddocumento").equals("") ? null : "'" + dkda.o(vars, "novdocdescri_novedaddocumento") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "novdocarchiv_novedaddocumento").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "novdocarchiv_novedaddocumento") + "')") + "," + (dkda.o(vars, "novdocarchiv_novedaddocumento").equals("") ? null : "'" + dkda.o(vars, "novdocarchiv_novedaddocumento") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_novedaddocumento&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_novedaddocumento&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error novedaddocumento.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_novedaddocumento(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE novedaddocumento SET noveconsecut = " + (dkda.o(vars, "noveconsecut_novedaddocumento").equals("") ? null : dkda.o(vars, "noveconsecut_novedaddocumento")) + ",codtipodctoasociado = " + (dkda.o(documentocausal_novedaddocumento_1, "codtipodctoasociado").equals("") ? null : "'" + dkda.o(documentocausal_novedaddocumento_1, "codtipodctoasociado") + "'") + ",codtiponovedad = " + (dkda.o(documentocausal_novedaddocumento_1, "codtiponovedad").equals("") ? null : "'" + dkda.o(documentocausal_novedaddocumento_1, "codtiponovedad") + "'") + ",novcaucodigo = " + (dkda.o(documentocausal_novedaddocumento_1, "novcaucodigo").equals("") ? null : "'" + dkda.o(documentocausal_novedaddocumento_1, "novcaucodigo") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_novedaddocumento").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_novedaddocumento") + "'") + ",novdocidenti = " + (dkda.o(vars, "novdocidenti_novedaddocumento").equals("") ? null : "'" + dkda.o(vars, "novdocidenti_novedaddocumento") + "'") + ",novdocdescri = " + (dkda.o(vars, "novdocdescri_novedaddocumento").equals("") ? null : "'" + dkda.o(vars, "novdocdescri_novedaddocumento") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",novdocarchiv = " + (dkda.o(vars, "novdocarchiv_novedaddocumento").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "novdocarchiv_novedaddocumento") + "')") + ",novdocarchiv_nombre = " + (dkda.o(vars, "novdocarchiv_novedaddocumento").equals("") ? null : "'" + dkda.o(vars, "novdocarchiv_novedaddocumento") + "'") + " WHERE noveconsecut = " + dkda.o(sel, "noveconsecut") + " AND codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "' AND codtiponovedad = '" + dkda.o(sel, "codtiponovedad") + "' AND novcaucodigo = '" + dkda.o(sel, "novcaucodigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_novedaddocumento&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_novedaddocumento&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error novedaddocumento.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_novedaddocumento(ConexionBaseDatos con, String codigo) {
        System.out.println("El  iminar entra" + codigo);
        con.abrirConexion();
        String[] codigos = codigo.split(",");
        String nuevosCodigos = "";
        for (int n = 0; n < codigos.length; n++) {
            nuevosCodigos += "'" + codigos[n] + "',";
        }
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            stmt = con.con.prepareStatement("DELETE FROM novedaddocumento WHERE noveconsecut = " + dkda.o(sel, "noveconsecut") + " AND codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "' AND codtiponovedad = '" + dkda.o(sel, "codtiponovedad") + "' AND novcaucodigo = '" + dkda.o(sel, "novcaucodigo") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_novedaddocumento&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_novedaddocumento&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error novedaddocumento.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_novedaddocumento(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT novedaddocumento.\"noveconsecut\"        AS novedaddocumento_noveconsecut, "
                    + "       novedaddocumento.\"codtipodctoasociado\" AS "
                    + "       novedaddocumento_codtipodctoasociado, "
                    + "       novedaddocumento.\"codtiponovedad\"      AS novedaddocumento_codtiponovedad "
                    + "       , "
                    + "       novedaddocumento.\"novcaucodigo\"        AS "
                    + "       novedaddocumento_novcaucodigo, "
                    + "       novedaddocumento.\"codtipoidentidad\"    AS "
                    + "       novedaddocumento_codtipoidentidad, "
                    + "       novedaddocumento.\"novdocidenti\"        AS novedaddocumento_novdocidenti, "
                    + "       novedaddocumento.\"novdocdescri\"        AS novedaddocumento_novdocdescri, "
                    + "       novedaddocumento.\"novdocarchiv\"        AS novedaddocumento_novdocarchiv, "
                    + "       novedaddocumento.\"novdocarchiv_nombre\" AS "
                    + "       novedaddocumento_novdocarchiv_nombre, "
                    
                    + " CASE WHEN novedaddocumento.novdocarchiv_nombre  IS NULL OR novedaddocumento.novdocarchiv_nombre  = '' THEN 0 "
                    + " ELSE lo_export(novedaddocumento.novdocarchiv, '" + fun.temp(request) + "' || novedaddocumento.novdocarchiv_nombre ) END, "
                    
                    + "       documentocausal.\"codtiponovedad\"       AS documentocausal_codtiponovedad, "
                    + "       documentocausal.\"novcaucodigo\"         AS documentocausal_novcaucodigo, "
                    + "       documentocausal.\"codtipodctoasociado\"  AS "
                    + "       documentocausal_codtipodctoasociado, "
                    + "       tipoidentificacion.\"codtipoidentidad\"  AS "
                    + "       tipoidentificacion_codtipoidentidad, "
                    + "       tipoidentificacion.\"descripcion\"       AS tipoidentificacion_descripcion, "
                    + "       novedad.\"noveconsecut\"                 AS novedad_noveconsecut "
                    + "FROM   \"public\".\"documentocausal\" documentocausal "
                    + "       INNER JOIN \"public\".\"novedaddocumento\" novedaddocumento "
                    + "         ON documentocausal.\"codtiponovedad\" = novedaddocumento.\"codtiponovedad\" "
                    + "            AND documentocausal.\"codtipodctoasociado\" = "
                    + "                novedaddocumento.\"codtipodctoasociado\" "
                    + "            AND documentocausal.\"novcaucodigo\" = novedaddocumento.\"novcaucodigo\" "
                    + "       INNER JOIN \"public\".\"novedad\" novedad "
                    + "         ON novedaddocumento.\"noveconsecut\" = novedad.\"noveconsecut\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON novedaddocumento.\"codtipoidentidad\" = "
                    + "            tipoidentificacion.\"codtipoidentidad\"  WHERE "
                    + "novedaddocumento.noveconsecut = " + dkda.o(sel, "noveconsecut") + " AND novedaddocumento.codtipodctoasociado = '"
                    + dkda.o(sel, "codtipodctoasociado") + "' AND novedaddocumento.codtiponovedad = '" + dkda.o(sel, "codtiponovedad") + "'"
                    + " AND novedaddocumento.novcaucodigo = '" + dkda.o(sel, "novcaucodigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            
            info += "text|#novdocdescri_novedaddocumento|" + (rs.getString("novedaddocumento_novdocdescri") == null ? "" : rs.getString("novedaddocumento_novdocdescri")) + ":_";
            
            info += "text|#novdocarchiv_novedaddocumento|" + (rs.getString("novedaddocumento_novdocarchiv_nombre") == null ? "" : rs.getString("novedaddocumento_novdocarchiv_nombre")) + ":_";

            info += "combo|#codtipoidentidad_novedaddocumento|" + rs.getString("tipoidentificacion_codtipoidentidad") + "|llenarCombo('codtipoidentidad_novedaddocumento', '"
                    + rs.getString("tipoidentificacion_codtipoidentidad") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";
            
            
            info += "combo|#documentocausal_novedaddocumento_1|" + "documentocausal   codtiponovedad  " + rs.getString("novedaddocumento_codtiponovedad") + " "
                    + "  novcaucodigo  " + rs.getString("novedaddocumento_novcaucodigo") + "   codtipodctoasociado  " + rs.getString("novedaddocumento_codtipodctoasociado") + "|llenarCombo('documentocausal_novedaddocumento_1', '"
                    + "documentocausal   codtiponovedad  " + rs.getString("novedaddocumento_codtiponovedad") + " "
                    + "  novcaucodigo  " + rs.getString("novedaddocumento_novcaucodigo") + "   codtipodctoasociado  " +
                    rs.getString("novedaddocumento_codtipodctoasociado") + "', '" + rs.getString("novedaddocumento_codtipodctoasociado") + "'):_";

            info += "combo|#noveconsecut_novedaddocumento|" + rs.getString("novedaddocumento_noveconsecut") + "|llenarCombo('noveconsecut_novedaddocumento', '"
                    + rs.getString("novedaddocumento_noveconsecut") + "', '" + rs.getString("novedaddocumento_noveconsecut") + "'):_";

            info += "text|#novdocidenti_novedaddocumento|" + (rs.getString("novedaddocumento_novdocidenti") == null ? "" : rs.getString("novedaddocumento_novdocidenti")) + ":_";

            respuesta = "opcion=obtener_novedaddocumento&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_novedaddocumento&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error novedaddocumento - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_novedaddocumento() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM novedaddocumento  WHERE noveconsecut = " +
                    dkda.o(vars, "noveconsecut_novedaddocumento") + "" + " AND codtipodctoasociado = '" + dkda.o(documentocausal_novedaddocumento_1, "codtipodctoasociado") + "'" + " "
                    + "AND codtiponovedad = '" + dkda.o(documentocausal_novedaddocumento_1, "codtiponovedad") + "'" + " AND novcaucodigo = '" + 
                    dkda.o(documentocausal_novedaddocumento_1, "novcaucodigo") + "'";
            
            pQuery = conexion.prepareStatement(sql);
            System.out.println( sql );
            
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_novedaddocumento() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_novedaddocumento() {
        String direccion = "opcion=registrar_novedaddocumento&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_novedaddocumento();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "noveconsecut").toString().equals(dkda.o(vars, "noveconsecut_novedaddocumento")) &&
                    dkda.o(sel, "codtipodctoasociado").toString().equals(dkda.o(documentocausal_novedaddocumento_1, "codtipodctoasociado")) &&
                    dkda.o(sel, "codtiponovedad").toString().equals(dkda.o(documentocausal_novedaddocumento_1, "codtiponovedad")) && 
                    dkda.o(sel, "novcaucodigo").toString().equals(dkda.o(documentocausal_novedaddocumento_1, "novcaucodigo"))) && existe == true) {
                
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "noveconsecut_novedaddocumento").isEmpty()) {
            error = "Consecutivo Novedad: no puede ser vacio.";
        } else if (dkda.o(documentocausal_novedaddocumento_1, "codtiponovedad").isEmpty()) {
            error = "Codigo Tipo Documento Asociado: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_novedaddocumento").isEmpty()) {
            error = "Tipo Identificacion Persona Documento: no puede ser vacio.";
        } else if (dkda.o(vars, "novdocidenti_novedaddocumento").isEmpty()) {
            error = "Identificación Persona Documento: no puede ser vacio.";
        } else if (dkda.o(vars, "novdocarchiv_novedaddocumento").isEmpty()) {
            error = "Novedad Documento: no puede ser vacio.";
        } else if (dkda.o(vars, "novdocdescri_novedaddocumento").isEmpty()) {
            error = "Descripción Documento Novedad: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "novdocidenti_novedaddocumento"))) {
            error = "Identificación Persona Documento: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "novdocidenti_novedaddocumento").length() > 10) {
            error = "Identificación Persona Documento: Valor demasiado Largo.";
        } else if (dkda.o(vars, "novdocdescri_novedaddocumento").length() > 70) {
            error = "Descripción Documento Novedad: Valor demasiado Largo.";
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