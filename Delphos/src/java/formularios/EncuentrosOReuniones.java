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

public class EncuentrosOReuniones extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, municipio_encuentroreunion_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());
        municipio_encuentroreunion_1 = fun.map(dkda.o(vars, "municipio_encuentroreunion_1").toString());


        try {
            String opcion = dkda.o(vars, "accion").toString();
            String pestana = dkda.o(vars, "pestana").toString();
            respuesta = "";

            if (pestana.equals("encuentroreunion") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_encuentroreunion();
            }
            if (opcion.equals("Registrar") && pestana.equals("encuentroreunion") && respuesta.length() == 0) {
                out.println(registrar_encuentroreunion(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("encuentroreunion") && respuesta.length() == 0) {
                out.println(actualizar_encuentroreunion(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("encuentroreunion") && respuesta.length() == 0) {
                out.println(eliminar_encuentroreunion(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("encuentroreunion") && respuesta.length() == 0) {
                out.println(obtener_encuentroreunion(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("asistentesreunion") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_asistentesreunion();
            }
            if (opcion.equals("Registrar") && pestana.equals("asistentesreunion") && respuesta.length() == 0) {
                out.println(registrar_asistentesreunion(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("asistentesreunion") && respuesta.length() == 0) {
                out.println(actualizar_asistentesreunion(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("asistentesreunion") && respuesta.length() == 0) {
                out.println(eliminar_asistentesreunion(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("asistentesreunion") && respuesta.length() == 0) {
                out.println(obtener_asistentesreunion(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("encuentroactividad") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_encuentroactividad();
            }
            if (opcion.equals("Registrar") && pestana.equals("encuentroactividad") && respuesta.length() == 0) {
                out.println(registrar_encuentroactividad(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("encuentroactividad") && respuesta.length() == 0) {
                out.println(actualizar_encuentroactividad(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("encuentroactividad") && respuesta.length() == 0) {
                out.println(eliminar_encuentroactividad(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("encuentroactividad") && respuesta.length() == 0) {
                out.println(obtener_encuentroactividad(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("encuenasistenteexterno") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_encuenasistenteexterno();
            }
            if (opcion.equals("Registrar") && pestana.equals("encuenasistenteexterno") && respuesta.length() == 0) {
                out.println(registrar_encuenasistenteexterno(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("encuenasistenteexterno") && respuesta.length() == 0) {
                out.println(actualizar_encuenasistenteexterno(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("encuenasistenteexterno") && respuesta.length() == 0) {
                out.println(eliminar_encuenasistenteexterno(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("encuenasistenteexterno") && respuesta.length() == 0) {
                out.println(obtener_encuenasistenteexterno(con, dkda.o(vars, "codigo").toString()));
            }
            if (respuesta.length() > 0) {
                out.println(respuesta);
            }
        } finally {
            out.close();
        }
    }

    public String registrar_encuentroreunion(ConexionBaseDatos con) {
        System.out.println("registrar_encuentroreunion");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO encuentroreunion (encuencodigo,coddepartamento,codmunicipio,encuendirecc,enculugarefe,encuenfecha,encunumepart,"
                    + "encutemaprin,coditiporeun,codtipoidentidad,encidemadlid,encuenpropos,encuenobjeti,encusoluenco,encuenobserv,encufechinfo,"
                    + "tisiscodigo,ususiscodigo,archivofi,archivofi_nombre,fecharegistro,encuarchdocu_nombre,encuarchdocu) VALUES "
                    + "(" + (dkda.o(vars, "encuencodigo_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encuencodigo_encuentroreunion") + "'")
                    + "," + (dkda.o(municipio_encuentroreunion_1, "coddepartamento").equals("") ? null
                    : dkda.o(municipio_encuentroreunion_1, "coddepartamento")) + "," + (dkda.o(municipio_encuentroreunion_1, "codmunicipio").equals("")
                    ? null : dkda.o(municipio_encuentroreunion_1, "codmunicipio")) + "," + (dkda.o(vars, "encuendirecc_encuentroreunion").equals("") ? null
                    : "'" + dkda.o(vars, "encuendirecc_encuentroreunion") + "'") + "," + (dkda.o(vars, "enculugarefe_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "enculugarefe_encuentroreunion") + "'") + "," + (dkda.o(vars, "encuenfecha_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encuenfecha_encuentroreunion") + "'") + "," + (dkda.o(vars, "encunumepart_encuentroreunion").equals("") ? null : dkda.o(vars, "encunumepart_encuentroreunion")) + "," + (dkda.o(vars, "encutemaprin_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encutemaprin_encuentroreunion") + "'") + "," + (dkda.o(vars, "coditiporeun_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "coditiporeun_encuentroreunion") + "'") + "," + (dkda.o(vars, "codtipoidentidad_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_encuentroreunion") + "'") + "," + (dkda.o(vars, "encidemadlid_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encidemadlid_encuentroreunion") + "'") + "," + (dkda.o(vars, "encuenpropos_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encuenpropos_encuentroreunion") + "'") + "," + (dkda.o(vars, "encuenobjeti_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encuenobjeti_encuentroreunion") + "'") + "," + (dkda.o(vars, "encusoluenco_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encusoluenco_encuentroreunion") + "'") + "," + (dkda.o(vars, "encuenobserv_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encuenobserv_encuentroreunion") + "'") + "," + (dkda.o(vars, "encufechinfo_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encufechinfo_encuentroreunion") + "'") + "," + (dkda.o(vars, "tisiscodigo_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "tisiscodigo_encuentroreunion") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + (dkda.o(vars, "archivofi_encuentroreunion").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi_encuentroreunion") + "')") + "," + (dkda.o(vars, "archivofi_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "archivofi_encuentroreunion") + "'") + "," + "NOW()::date" + "," + (dkda.o(vars, "encuarchdocu_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encuarchdocu_encuentroreunion") + "'") + "," + (dkda.o(vars, "encuarchdocu_encuentroreunion").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "encuarchdocu_encuentroreunion") + "')") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_encuentroreunion&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_encuentroreunion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error encuentroreunion.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_encuentroreunion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE encuentroreunion SET encuencodigo = " + (dkda.o(vars, "encuencodigo_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encuencodigo_encuentroreunion") + "'") + ",coddepartamento = " + (dkda.o(municipio_encuentroreunion_1, "coddepartamento").equals("") ? null : dkda.o(municipio_encuentroreunion_1, "coddepartamento")) + ",codmunicipio = " + (dkda.o(municipio_encuentroreunion_1, "codmunicipio").equals("") ? null : dkda.o(municipio_encuentroreunion_1, "codmunicipio")) + ",encuendirecc = " + (dkda.o(vars, "encuendirecc_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encuendirecc_encuentroreunion") + "'") + ",enculugarefe = " + (dkda.o(vars, "enculugarefe_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "enculugarefe_encuentroreunion") + "'") + ",encuenfecha = " + (dkda.o(vars, "encuenfecha_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encuenfecha_encuentroreunion") + "'") + ",encunumepart = " + (dkda.o(vars, "encunumepart_encuentroreunion").equals("") ? null : dkda.o(vars, "encunumepart_encuentroreunion")) + ",encutemaprin = " + (dkda.o(vars, "encutemaprin_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encutemaprin_encuentroreunion") + "'") + ",coditiporeun = " + (dkda.o(vars, "coditiporeun_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "coditiporeun_encuentroreunion") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_encuentroreunion") + "'") + ",encidemadlid = " + (dkda.o(vars, "encidemadlid_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encidemadlid_encuentroreunion") + "'") + ",encuenpropos = " + (dkda.o(vars, "encuenpropos_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encuenpropos_encuentroreunion") + "'") + ",encuenobjeti = " + (dkda.o(vars, "encuenobjeti_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encuenobjeti_encuentroreunion") + "'") + ",encusoluenco = " + (dkda.o(vars, "encusoluenco_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encusoluenco_encuentroreunion") + "'") + ",encuenobserv = " + (dkda.o(vars, "encuenobserv_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encuenobserv_encuentroreunion") + "'") + ",encufechinfo = " + (dkda.o(vars, "encufechinfo_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encufechinfo_encuentroreunion") + "'") + ",tisiscodigo = " + (dkda.o(vars, "tisiscodigo_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "tisiscodigo_encuentroreunion") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",archivofi = " + (dkda.o(vars, "archivofi_encuentroreunion").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi_encuentroreunion") + "')") + ",archivofi_nombre = " + (dkda.o(vars, "archivofi_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "archivofi_encuentroreunion") + "'") + ",fecharegistro = " + "NOW()::date" + ",encuarchdocu_nombre = " + (dkda.o(vars, "encuarchdocu_encuentroreunion").equals("") ? null : "'" + dkda.o(vars, "encuarchdocu_encuentroreunion") + "'") + ",encuarchdocu = " + (dkda.o(vars, "encuarchdocu_encuentroreunion").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "encuarchdocu_encuentroreunion") + "')") + " WHERE encuencodigo = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_encuentroreunion&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_encuentroreunion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error encuentroreunion.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_encuentroreunion(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM encuentroreunion WHERE encuencodigo = '" + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_encuentroreunion&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_encuentroreunion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error encuentroreunion.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_encuentroreunion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT encuentroreunion.\"encuencodigo\"        AS encuentroreunion_encuencodigo, "
                    + "       encuentroreunion.\"coddepartamento\"     AS "
                    + "       encuentroreunion_coddepartamento, "
                    + "       encuentroreunion.\"codmunicipio\"        AS encuentroreunion_codmunicipio, "
                    + "       encuentroreunion.\"encuendirecc\"        AS encuentroreunion_encuendirecc, "
                    + "       encuentroreunion.\"enculugarefe\"        AS encuentroreunion_enculugarefe, "
                    + "       encuentroreunion.\"encuenfecha\"         AS encuentroreunion_encuenfecha, "
                    + "       encuentroreunion.\"encunumepart\"        AS encuentroreunion_encunumepart, "
                    + "       encuentroreunion.\"encutemaprin\"        AS encuentroreunion_encutemaprin, "
                    + "       encuentroreunion.\"coditiporeun\"        AS encuentroreunion_coditiporeun, "
                    + "       encuentroreunion.\"codtipoidentidad\"    AS "
                    + "       encuentroreunion_codtipoidentidad, "
                    + "       encuentroreunion.\"encidemadlid\"        AS encuentroreunion_encidemadlid, "
                    + "       encuentroreunion.\"encuenpropos\"        AS encuentroreunion_encuenpropos, "
                    + "       encuentroreunion.\"encuenobjeti\"        AS encuentroreunion_encuenobjeti, "
                    + "       encuentroreunion.\"encusoluenco\"        AS encuentroreunion_encusoluenco, "
                    + "       encuentroreunion.\"encuenobserv\"        AS encuentroreunion_encuenobserv, "
                    + "       encuentroreunion.\"encufechinfo\"        AS encuentroreunion_encufechinfo, "
                    + "       encuentroreunion.\"tisiscodigo\"         AS encuentroreunion_tisiscodigo, "
                    + "       encuentroreunion.\"archivofi\"           AS encuentroreunion_archivofi, "
                    + "       encuentroreunion.\"archivofi_nombre\"    AS "
                    + "       encuentroreunion_archivofi_nombre, "
                    + "CASE WHEN encuentroreunion.archivofi_nombre  IS NULL OR encuentroreunion.archivofi_nombre  = '' THEN 0 "
                    + "ELSE lo_export(encuentroreunion.archivofi, '" + fun.temp(request) + "' || encuentroreunion.archivofi_nombre ) END, "
                    + "       encuentroreunion.\"encuarchdocu_nombre\" AS "
                    + "       encuentroreunion_encuarchdocu_nombre, "
                    + "       encuentroreunion.\"encuarchdocu\"        AS encuentroreunion_encuarchdocu, "
                    + "CASE WHEN encuentroreunion.encuarchdocu_nombre  IS NULL OR encuentroreunion.encuarchdocu_nombre  = '' THEN 0 "
                    + "ELSE lo_export(encuentroreunion.encuarchdocu, '" + fun.temp(request) + "' || encuentroreunion.encuarchdocu_nombre ) END, "
                    + "       tipoidentificacion.\"codtipoidentidad\"  AS "
                    + "       tipoidentificacion_codtipoidentidad, "
                    + "       tipoidentificacion.\"descripcion\"       AS tipoidentificacion_descripcion, "
                    + "       tiporeunion.\"coditiporeun\"             AS tiporeunion_coditiporeun, "
                    + "       tiporeunion.\"desctiporeun\"             AS tiporeunion_desctiporeun, "
                    + "       municipio.\"coddepartamento\"            AS municipio_coddepartamento, "
                    + "       municipio.\"codmunicipio\"               AS municipio_codmunicipio, "
                    + "       municipio.\"nombre\"                     AS municipio_nombre, "
                    + "       tiposistema.\"tisiscodigo\"              AS tiposistema_tisiscodigo, "
                    + "       tiposistema.\"tisisdescrip\"             AS tiposistema_tisisdescrip "
                    + "FROM   \"public\".\"municipio\" municipio "
                    + "       INNER JOIN \"public\".\"encuentroreunion\" encuentroreunion "
                    + "         ON municipio.\"coddepartamento\" = encuentroreunion.\"coddepartamento\" "
                    + "            AND municipio.\"codmunicipio\" = encuentroreunion.\"codmunicipio\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON encuentroreunion.\"codtipoidentidad\" = "
                    + "            tipoidentificacion.\"codtipoidentidad\" "
                    + "       INNER JOIN \"public\".\"tiporeunion\" tiporeunion "
                    + "         ON encuentroreunion.\"coditiporeun\" = tiporeunion.\"coditiporeun\" "
                    + "       INNER JOIN \"public\".\"tiposistema\" tiposistema "
                    + "         ON encuentroreunion.\"tisiscodigo\" = tiposistema.\"tisiscodigo\" WHERE encuencodigo = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#encuenobserv_encuentroreunion|" + (rs.getString("encuentroreunion_encuenobserv") == null ? "" : rs.getString("encuentroreunion_encuenobserv")) + ":_";

            info += "text|#encusoluenco_encuentroreunion|" + (rs.getString("encuentroreunion_encusoluenco") == null ? "" : rs.getString("encuentroreunion_encusoluenco")) + ":_";

            info += "text|#encuenobjeti_encuentroreunion|" + (rs.getString("encuentroreunion_encuenobjeti") == null ? "" : rs.getString("encuentroreunion_encuenobjeti")) + ":_";

            info += "text|#encutemaprin_encuentroreunion|" + (rs.getString("encuentroreunion_encutemaprin") == null ? "" : rs.getString("encuentroreunion_encutemaprin")) + ":_";

            info += "text|#encuarchdocu_encuentroreunion|" + (rs.getString("encuentroreunion_encuarchdocu_nombre") == null ? "" : rs.getString("encuentroreunion_encuarchdocu_nombre")) + ":_";

            info += "text|#archivofi_encuentroreunion|" + (rs.getString("encuentroreunion_archivofi_nombre") == null ? "" : rs.getString("encuentroreunion_archivofi_nombre")) + ":_";

            info += "combo|#tisiscodigo_encuentroreunion|" + rs.getString("tiposistema_tisiscodigo") + "|llenarCombo('tisiscodigo_encuentroreunion', '"
                    + rs.getString("tiposistema_tisiscodigo") + "', '" + rs.getString("tiposistema_tisisdescrip") + "'):_";

            info += "text|#_fechahora_encufechinfo_encuentroreunion|" + (rs.getString("encuentroreunion_encufechinfo") == null ? "" : rs.getString("encuentroreunion_encufechinfo")) + ":_";

            info += "text|#encidemadlid_encuentroreunion|" + (rs.getString("encuentroreunion_encidemadlid") == null ? "" : rs.getString("encuentroreunion_encidemadlid")) + ":_";

            info += "combo|#codtipoidentidad_encuentroreunion|" + rs.getString("tipoidentificacion_codtipoidentidad") + "|llenarCombo('codtipoidentidad_encuentroreunion', '"
                    + rs.getString("tipoidentificacion_codtipoidentidad") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";

            info += "combo|#coditiporeun_encuentroreunion|" + rs.getString("tiporeunion_coditiporeun") + "|llenarCombo('coditiporeun_encuentroreunion', '"
                    + rs.getString("tiporeunion_coditiporeun") + "', '" + rs.getString("tiporeunion_desctiporeun") + "'):_";

            info += "text|#encunumepart_encuentroreunion|" + (rs.getString("encuentroreunion_encunumepart") == null ? "" : rs.getString("encuentroreunion_encunumepart")) + ":_";

            info += "text|#_fechahora_encuenfecha_encuentroreunion|" + (rs.getString("encuentroreunion_encuenfecha") == null ? "" : rs.getString("encuentroreunion_encuenfecha")) + ":_";

            info += "text|#enculugarefe_encuentroreunion|" + (rs.getString("encuentroreunion_enculugarefe") == null ? "" : rs.getString("encuentroreunion_enculugarefe")) + ":_";

            info += "text|#encuendirecc_encuentroreunion|" + (rs.getString("encuentroreunion_encuendirecc") == null ? "" : rs.getString("encuentroreunion_encuendirecc")) + ":_";

            info += "combo|#municipio_encuentroreunion_1|" + "municipio   coddepartamento  " + rs.getString("municipio_coddepartamento") + "  "
                    + " codmunicipio  " + rs.getString("municipio_codmunicipio") + "|llenarCombo('municipio_encuentroreunion_1', '"
                    + "municipio   coddepartamento  " + rs.getString("municipio_coddepartamento") + "  "
                    + " codmunicipio  " + rs.getString("municipio_codmunicipio") + "', '" + rs.getString("municipio_nombre") + "'):_";

            info += "text|#encuencodigo_encuentroreunion|" + (rs.getString("encuentroreunion_encuencodigo") == null ? "" : rs.getString("encuentroreunion_encuencodigo")) + ":_";

            respuesta = "opcion=obtener_encuentroreunion&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_encuentroreunion&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error encuentroreunion - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_encuentroreunion() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM encuentroreunion  WHERE encuencodigo = '" + dkda.o(vars, "encuencodigo_encuentroreunion") + "'";
            System.out.println(sql);
            pQuery = conexion.prepareStatement(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_encuentroreunion() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_encuentroreunion() {
        String direccion = "opcion=registrar_encuentroreunion&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_encuentroreunion();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "encuencodigo_encuentroreunion"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "encuencodigo_encuentroreunion").isEmpty()) {
            error = "Código Encuentros: no puede ser vacio.";
        } else if (dkda.o(vars, "municipio_encuentroreunion_1").isEmpty()) {
            error = "C&oacute;digo Municipio Encuentro: no puede ser vacio.";
        } else if (dkda.o(vars, "encuendirecc_encuentroreunion").isEmpty()) {
            error = "Dirección Encuentro: no puede ser vacio.";
        } else if (dkda.o(vars, "enculugarefe_encuentroreunion").isEmpty()) {
            error = "Lugar Referencia Encuentro: no puede ser vacio.";
        } else if (dkda.o(vars, "encuenfecha_encuentroreunion").isEmpty()) {
            error = "Fecha y Hora  Encuentro: no puede ser vacio.";
        } else if (dkda.o(vars, "encunumepart_encuentroreunion").isEmpty()) {
            error = "Número Participantes Encuentro : no puede ser vacio.";
        } else if (dkda.o(vars, "coditiporeun_encuentroreunion").isEmpty()) {
            error = "Código Tipo de Reunión: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_encuentroreunion").isEmpty()) {
            error = "Tipo Identificacion Madre Líder: no puede ser vacio.";
        } else if (dkda.o(vars, "encidemadlid_encuentroreunion").isEmpty()) {
            error = "Identificación Madre Líder: no puede ser vacio.";
        } else if (dkda.o(vars, "encufechinfo_encuentroreunion").isEmpty()) {
            error = "Fecha Hora Informe: no puede ser vacio.";
        } else if (dkda.o(vars, "tisiscodigo_encuentroreunion").isEmpty()) {
            error = "Tipo Sistema: no puede ser vacio.";
        } else if (dkda.o(vars, "archivofi_encuentroreunion").isEmpty()) {
            error = "Archivo 1: no puede ser vacio.";
        } else if (dkda.o(vars, "encuarchdocu_encuentroreunion").isEmpty()) {
            error = "Archivo 2: no puede ser vacio.";
        } else if (dkda.o(vars, "encutemaprin_encuentroreunion").isEmpty()) {
            error = "Tema Principal: no puede ser vacio.";
        } else if (dkda.o(vars, "encuenobjeti_encuentroreunion").isEmpty()) {
            error = "Objetivo Reunión: no puede ser vacio.";
        } else if (dkda.o(vars, "encusoluenco_encuentroreunion").isEmpty()) {
            error = "Soluciones Encontradas: no puede ser vacio.";
        } else if (dkda.o(vars, "encuenobserv_encuentroreunion").isEmpty()) {
            error = "Observaciones : no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "encidemadlid_encuentroreunion"))) {
            error = "Identificación Madre Líder: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "encuencodigo_encuentroreunion").length() > 6) {
            error = "Código Encuentros: Valor demasiado Largo.";
        } else if (dkda.o(vars, "enculugarefe_encuentroreunion").length() > 70) {
            error = "Lugar Referencia Encuentro: Valor demasiado Largo.";
        } else if (dkda.o(vars, "encidemadlid_encuentroreunion").length() > 10) {
            error = "Identificación Madre Líder: Valor demasiado Largo.";
        } else if (dkda.o(vars, "encutemaprin_encuentroreunion").length() > 150) {
            error = "Tema Principal: Valor demasiado Largo.";
        } else if (dkda.o(vars, "encuenobjeti_encuentroreunion").length() > 150) {
            error = "Objetivo Reunión: Valor demasiado Largo.";
        } else if (dkda.o(vars, "encusoluenco_encuentroreunion").length() > 400) {
            error = "Soluciones Encontradas: Valor demasiado Largo.";
        } else if (dkda.o(vars, "encuenobserv_encuentroreunion").length() > 400) {
            error = "Observaciones : Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_asistentesreunion(ConexionBaseDatos con) {
        System.out.println("registrar_asistentesreunion");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO asistentesreunion (encuencodigo,codtipoidentidad,asisteidenti,asispertprog,codunifami,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "encuencodigo_asistentesreunion").equals("") ? null : "'" + dkda.o(vars, "encuencodigo_asistentesreunion") + "'") + "," + (dkda.o(vars, "codtipoidentidad_asistentesreunion").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_asistentesreunion") + "'") + "," + (dkda.o(vars, "asisteidenti_asistentesreunion").equals("") ? null : "'" + dkda.o(vars, "asisteidenti_asistentesreunion") + "'") + "," + (dkda.o(vars, "asispertprog_asistentesreunion").equals("") ? null : "'" + dkda.o(vars, "asispertprog_asistentesreunion") + "'") + "," + (dkda.o(vars, "codunifami_asistentesreunion").equals("") ? null : "'" + dkda.o(vars, "codunifami_asistentesreunion") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_asistentesreunion&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_asistentesreunion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error asistentesreunion.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_asistentesreunion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE asistentesreunion SET encuencodigo = " + (dkda.o(vars, "encuencodigo_asistentesreunion").equals("") ? null : "'" + dkda.o(vars, "encuencodigo_asistentesreunion") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_asistentesreunion").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_asistentesreunion") + "'") + ",asisteidenti = " + (dkda.o(vars, "asisteidenti_asistentesreunion").equals("") ? null : "'" + dkda.o(vars, "asisteidenti_asistentesreunion") + "'") + ",asispertprog = " + (dkda.o(vars, "asispertprog_asistentesreunion").equals("") ? null : "'" + dkda.o(vars, "asispertprog_asistentesreunion") + "'") + ",codunifami = " + (dkda.o(vars, "codunifami_asistentesreunion").equals("") ? null : "'" + dkda.o(vars, "codunifami_asistentesreunion") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE encuencodigo = '" + dkda.o(sel, "encuencodigo") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND asisteidenti = '" + dkda.o(sel, "asisteidenti") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_asistentesreunion&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_asistentesreunion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error asistentesreunion.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_asistentesreunion(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM asistentesreunion WHERE encuencodigo = '" + dkda.o(sel, "encuencodigo") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND asisteidenti = '" + dkda.o(sel, "asisteidenti") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_asistentesreunion&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_asistentesreunion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error asistentesreunion.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_asistentesreunion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT asistentesreunion.\"encuencodigo\"      AS asistentesreunion_encuencodigo, "
                    + "       asistentesreunion.\"codtipoidentidad\"  AS "
                    + "       asistentesreunion_codtipoidentidad, "
                    + "       asistentesreunion.\"asisteidenti\"      AS asistentesreunion_asisteidenti, "
                    + "       asistentesreunion.\"asispertprog\"      AS asistentesreunion_asispertprog, "
                    + "       asistentesreunion.\"codunifami\"        AS asistentesreunion_codunifami, "
                    + "       inscripcion.\"codunifami\"              AS inscripcion_codunifami, "
                    + "       tipoidentificacion.\"codtipoidentidad\" AS "
                    + "       tipoidentificacion_codtipoidentidad, "
                    + "       tipoidentificacion.\"descripcion\"      AS tipoidentificacion_descripcion, "
                    + "       encuentroreunion.\"encuencodigo\"       AS encuentroreunion_encuencodigo "
                    + "FROM   \"public\".\"encuentroreunion\" encuentroreunion "
                    + "       INNER JOIN \"public\".\"asistentesreunion\" asistentesreunion "
                    + "         ON encuentroreunion.\"encuencodigo\" = asistentesreunion.\"encuencodigo\" "
                    + "       INNER JOIN \"public\".\"inscripcion\" inscripcion "
                    + "         ON asistentesreunion.\"codunifami\" = inscripcion.\"codunifami\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON asistentesreunion.\"codtipoidentidad\" = "
                    + "            tipoidentificacion.\"codtipoidentidad\"  WHERE asistentesreunion.encuencodigo = '"
                    + dkda.o(sel, "encuencodigo") + "' AND asistentesreunion.codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND asistentesreunion.asisteidenti = '"
                    + dkda.o(sel, "asisteidenti") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "combo|#codunifami_asistentesreunion|" + rs.getString("inscripcion_codunifami") + "|llenarCombo('codunifami_asistentesreunion', '"
                    + rs.getString("inscripcion_codunifami") + "', '" + rs.getString("inscripcion_codunifami") + "'):_";

            info += "switch|switch_asispertprog_asistentesreunion|" + rs.getString("asistentesreunion_asispertprog") + ":_";

            info += "text|#asisteidenti_asistentesreunion|" + (rs.getString("asistentesreunion_asisteidenti") == null ? "" : rs.getString("asistentesreunion_asisteidenti")) + ":_";

            info += "combo|#codtipoidentidad_asistentesreunion|" + rs.getString("tipoidentificacion_codtipoidentidad") + "|llenarCombo('codtipoidentidad_asistentesreunion', '"
                    + rs.getString("tipoidentificacion_codtipoidentidad") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";

            info += "combo|#encuencodigo_asistentesreunion|" + rs.getString("asistentesreunion_encuencodigo") + "|llenarCombo('encuencodigo_asistentesreunion', '"
                    + rs.getString("asistentesreunion_encuencodigo") + "', '" + rs.getString("asistentesreunion_encuencodigo") + "'):_";

            respuesta = "opcion=obtener_asistentesreunion&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_asistentesreunion&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error asistentesreunion - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_asistentesreunion() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM asistentesreunion  WHERE encuencodigo = '"
                    + dkda.o(vars, "encuencodigo_asistentesreunion") + "'" + " AND codtipoidentidad = '" + dkda.o(vars, "codtipoidentidad_asistentesreunion") + "'"
                    + " AND asisteidenti = '" + dkda.o(vars, "asisteidenti_asistentesreunion") + "'";
            System.out.println(sql);

            pQuery = conexion.prepareStatement(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_asistentesreunion() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_asistentesreunion() {
        String direccion = "opcion=registrar_asistentesreunion&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = existe_asistentesreunion();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "encuencodigo").toString().equals(dkda.o(vars, "encuencodigo_asistentesreunion"))
                    && dkda.o(sel, "codtipoidentidad").toString().equals(dkda.o(vars, "codtipoidentidad_asistentesreunion"))
                    && dkda.o(sel, "asisteidenti").toString().equals(dkda.o(vars, "asisteidenti_asistentesreunion"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "encuencodigo_asistentesreunion").isEmpty()) {
            error = "Código Encuentros: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_asistentesreunion").isEmpty()) {
            error = "Tipo Identificaci&oacute;n Asistente: no puede ser vacio.";
        } else if (dkda.o(vars, "asisteidenti_asistentesreunion").isEmpty()) {
            error = "Identificación Asistente Reunión: no puede ser vacio.";
        } else if (dkda.o(vars, "asispertprog_asistentesreunion").isEmpty()) {
            error = "Asistente Pertenece Programa (S/N): no puede ser vacio.";
        } else if (dkda.o(vars, "codunifami_asistentesreunion").isEmpty()) {
            error = "Código Único Familia Pertenece Asistente: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "asisteidenti_asistentesreunion"))) {
            error = "Identificación Asistente Reunión: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "asisteidenti_asistentesreunion").length() > 10) {
            error = "Identificación Asistente Reunión: Valor demasiado Largo.";
        } else if (dkda.o(vars, "asispertprog_asistentesreunion").length() > 1) {
            error = "Asistente Pertenece Programa (S/N): Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_encuentroactividad(ConexionBaseDatos con) {
        System.out.println("registrar_encuentroactividad");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO encuentroactividad (encuencodigo,codtipoactividad,codtipoidentidad,numidentfunc,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "encuencodigo_encuentroactividad").equals("") ? null : "'" + dkda.o(vars, "encuencodigo_encuentroactividad") + "'") + "," + (dkda.o(vars, "codtipoactividad_encuentroactividad").equals("") ? null : "'" + dkda.o(vars, "codtipoactividad_encuentroactividad") + "'") + "," + (dkda.o(vars, "codtipoidentidad_encuentroactividad").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_encuentroactividad") + "'") + "," + (dkda.o(vars, "numidentfunc_encuentroactividad").equals("") ? null : "'" + dkda.o(vars, "numidentfunc_encuentroactividad") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_encuentroactividad&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_encuentroactividad&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error encuentroactividad.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_encuentroactividad(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE encuentroactividad SET encuencodigo = " + (dkda.o(vars, "encuencodigo_encuentroactividad").equals("") ? null : "'"
                    + dkda.o(vars, "encuencodigo_encuentroactividad") + "'") + ",codtipoactividad = "
                    + (dkda.o(vars, "codtipoactividad_encuentroactividad").equals("") ? null : "'"
                    + dkda.o(vars, "codtipoactividad_encuentroactividad") + "'") + ",codtipoidentidad = "
                    + (dkda.o(vars, "codtipoidentidad_encuentroactividad").equals("") ? null : "'"
                    + dkda.o(vars, "codtipoidentidad_encuentroactividad") + "'") + ",numidentfunc = "
                    + (dkda.o(vars, "numidentfunc_encuentroactividad").equals("") ? null : "'"
                    + dkda.o(vars, "numidentfunc_encuentroactividad") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'"
                    + ",fecharegistro = " + "NOW()::date" + " WHERE encuencodigo = '" + dkda.o(sel, "encuencodigo") + "' AND codtipoactividad = '"
                    + dkda.o(sel, "codtipoactividad") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_encuentroactividad&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_encuentroactividad&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error encuentroactividad.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_encuentroactividad(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM encuentroactividad WHERE encuencodigo = '" + dkda.o(sel, "encuencodigo") + "' AND codtipoactividad = '" + dkda.o(sel, "codtipoactividad") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_encuentroactividad&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_encuentroactividad&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error encuentroactividad.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_encuentroactividad(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT encuentroactividad.\"encuencodigo\"     AS encuentroactividad_encuencodigo, "
                    + "       encuentroactividad.\"codtipoactividad\" AS "
                    + "       encuentroactividad_codtipoactividad, "
                    + "       encuentroactividad.\"codtipoidentidad\" AS "
                    + "       encuentroactividad_codtipoidentidad, "
                    + "       encuentroactividad.\"numidentfunc\"     AS encuentroactividad_numidentfunc, "
                    + "       encuentroreunion.\"encuencodigo\"       AS encuentroreunion_encuencodigo, "
                    + "       tipoactividad.\"codtipoactividad\"      AS tipoactividad_codtipoactividad, "
                    + "       tipoactividad.\"descripcion\"           AS tipoactividad_descripcion, "
                    + "       tipoidentificacion.\"codtipoidentidad\" AS "
                    + "       tipoidentificacion_codtipoidentidad, "
                    + "       tipoidentificacion.\"descripcion\"      AS tipoidentificacion_descripcion "
                    + "FROM   \"public\".\"encuentroreunion\" encuentroreunion "
                    + "       INNER JOIN \"public\".\"encuentroactividad\" encuentroactividad "
                    + "         ON encuentroreunion.\"encuencodigo\" = encuentroactividad.\"encuencodigo\" "
                    + "       INNER JOIN \"public\".\"tipoactividad\" tipoactividad "
                    + "         ON encuentroactividad.\"codtipoactividad\" = "
                    + "            tipoactividad.\"codtipoactividad\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON encuentroactividad.\"codtipoidentidad\" = "
                    + "            tipoidentificacion.\"codtipoidentidad\"   WHERE "
                    + "encuentroactividad.encuencodigo = '" + dkda.o(sel, "encuencodigo") + "'"
                    + " AND encuentroactividad.codtipoactividad = '" + dkda.o(sel, "codtipoactividad") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();


            info += "text|#numidentfunc_encuentroactividad|" + (rs.getString("encuentroactividad_numidentfunc") == null ? "" : rs.getString("encuentroactividad_numidentfunc")) + ":_";

            info += "combo|#codtipoidentidad_encuentroactividad|" + rs.getString("tipoidentificacion_codtipoidentidad") + "|llenarCombo('codtipoidentidad_encuentroactividad', '"
                    + rs.getString("tipoidentificacion_codtipoidentidad") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";

            info += "combo|#codtipoactividad_encuentroactividad|" + rs.getString("tipoactividad_codtipoactividad") + "|llenarCombo('codtipoactividad_encuentroactividad', '"
                    + rs.getString("tipoactividad_codtipoactividad") + "', '" + rs.getString("tipoactividad_descripcion") + "'):_";

            info += "combo|#encuencodigo_encuentroactividad|" + rs.getString("encuentroactividad_encuencodigo") + "|llenarCombo('encuencodigo_encuentroactividad', '"
                    + rs.getString("encuentroactividad_encuencodigo") + "', '" + rs.getString("encuentroactividad_encuencodigo") + "'):_";

            respuesta = "opcion=obtener_encuentroactividad&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_encuentroactividad&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error encuentroactividad - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_encuentroactividad() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM encuentroactividad "
                    + " WHERE encuencodigo = '" + dkda.o(vars, "encuencodigo_encuentroactividad") + "'" + ""
                    + " AND codtipoactividad = '" + dkda.o(vars, "codtipoactividad_encuentroactividad") + "'";
            pQuery = conexion.prepareStatement(sql);
            System.out.println(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_encuentroactividad() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_encuentroactividad() {
        String direccion = "opcion=registrar_encuentroactividad&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_encuentroactividad();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            System.out.println(dkda.o(sel, "encuencodigo").toString() + "   " + dkda.o(vars, "encuencodigo_encuentroactividad"));
            System.out.println(dkda.o(sel, "codtipoactividad").toString() + "   " + dkda.o(vars, "codtipoactividad_encuentroactividad"));


            if (!(dkda.o(sel, "encuencodigo").toString().equals(dkda.o(vars, "encuencodigo_encuentroactividad"))
                    && dkda.o(sel, "codtipoactividad").toString().equals(dkda.o(vars, "codtipoactividad_encuentroactividad"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "encuencodigo_encuentroactividad").isEmpty()) {
            error = "Código Encuentros o Reuniones: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoactividad_encuentroactividad").isEmpty()) {
            error = "Codigo Tipo Actividad : no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_encuentroactividad").isEmpty()) {
            error = "Tipo Identificacion Funcionario Líder Actividad: no puede ser vacio.";
        } else if (dkda.o(vars, "numidentfunc_encuentroactividad").isEmpty()) {
            error = "Numero Documento Identidad Funcionario Líder Actividad: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "numidentfunc_encuentroactividad"))) {
            error = "Numero Documento Identidad Funcionario Líder Actividad: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "numidentfunc_encuentroactividad").length() > 10) {
            error = "Numero Documento Identidad Funcionario Líder Actividad: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }// 

    public String registrar_encuenasistenteexterno(ConexionBaseDatos con) {
        System.out.println("registrar_encuenasistenteexterno");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO encuenasistenteexterno (encuencodigo,codtipoidentidad,externidenti,asiextnombre,asiextapellido,tipasicodigo,exterobserv,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "encuencodigo_encuenasistenteexterno").equals("") ? null : "'" + dkda.o(vars, "encuencodigo_encuenasistenteexterno") + "'") + "," + (dkda.o(vars, "codtipoidentidad_encuenasistenteexterno").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_encuenasistenteexterno") + "'") + "," + (dkda.o(vars, "externidenti_encuenasistenteexterno").equals("") ? null : "'" + dkda.o(vars, "externidenti_encuenasistenteexterno") + "'") + "," + (dkda.o(vars, "asiextnombre_encuenasistenteexterno").equals("") ? null : "'" + dkda.o(vars, "asiextnombre_encuenasistenteexterno") + "'") + "," + (dkda.o(vars, "asiextapellido_encuenasistenteexterno").equals("") ? null : "'" + dkda.o(vars, "asiextapellido_encuenasistenteexterno") + "'") + "," + (dkda.o(vars, "tipasicodigo_encuenasistenteexterno").equals("") ? null : "'" + dkda.o(vars, "tipasicodigo_encuenasistenteexterno") + "'") + "," + (dkda.o(vars, "exterobserv_encuenasistenteexterno").equals("") ? null : "'" + dkda.o(vars, "exterobserv_encuenasistenteexterno") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_encuenasistenteexterno&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_encuenasistenteexterno&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error encuenasistenteexterno.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_encuenasistenteexterno(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE encuenasistenteexterno SET encuencodigo = " + (dkda.o(vars, "encuencodigo_encuenasistenteexterno").equals("") ? null : "'" + dkda.o(vars, "encuencodigo_encuenasistenteexterno") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_encuenasistenteexterno").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_encuenasistenteexterno") + "'") + ",externidenti = " + (dkda.o(vars, "externidenti_encuenasistenteexterno").equals("") ? null : "'" + dkda.o(vars, "externidenti_encuenasistenteexterno") + "'") + ",asiextnombre = " + (dkda.o(vars, "asiextnombre_encuenasistenteexterno").equals("") ? null : "'" + dkda.o(vars, "asiextnombre_encuenasistenteexterno") + "'") + ",asiextapellido = " + (dkda.o(vars, "asiextapellido_encuenasistenteexterno").equals("") ? null : "'" + dkda.o(vars, "asiextapellido_encuenasistenteexterno") + "'") + ",tipasicodigo = " + (dkda.o(vars, "tipasicodigo_encuenasistenteexterno").equals("") ? null : "'" + dkda.o(vars, "tipasicodigo_encuenasistenteexterno") + "'") + ",exterobserv = " + (dkda.o(vars, "exterobserv_encuenasistenteexterno").equals("") ? null : "'" + dkda.o(vars, "exterobserv_encuenasistenteexterno") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE encuencodigo = '" + dkda.o(sel, "encuencodigo") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND externidenti = '" + dkda.o(sel, "externidenti") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_encuenasistenteexterno&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_encuenasistenteexterno&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error encuenasistenteexterno.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_encuenasistenteexterno(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM encuenasistenteexterno WHERE encuencodigo = '" + dkda.o(sel, "encuencodigo") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND externidenti = '" + dkda.o(sel, "externidenti") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_encuenasistenteexterno&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_encuenasistenteexterno&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error encuenasistenteexterno.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_encuenasistenteexterno(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;

            String sql = ""
                    + "SELECT encuenasistenteexterno.\"encuencodigo\"     AS "
                    + "       encuenasistenteexterno_encuencodigo "
                    + "       , "
                    + "       encuenasistenteexterno.\"codtipoidentidad\" AS "
                    + "       encuenasistenteexterno_codtipoidentidad, "
                    + "       encuenasistenteexterno.\"externidenti\"     AS "
                    + "       encuenasistenteexterno_externidenti, "
                    + "       encuenasistenteexterno.\"asiextnombre\"     AS "
                    + "       encuenasistenteexterno_asiextnombre, "
                    + "       encuenasistenteexterno.\"asiextapellido\"   AS "
                    + "       encuenasistenteexterno_asiextapellido, "
                    + "       encuenasistenteexterno.\"tipasicodigo\"     AS "
                    + "       encuenasistenteexterno_tipasicodigo, "
                    + "       encuenasistenteexterno.\"exterobserv\"      AS "
                    + "       encuenasistenteexterno_exterobserv, "
                    + "       tipoasistente.\"tipasicodigo\"              AS tipoasistente_tipasicodigo, "
                    + "       tipoasistente.\"tipasidescri\"              AS tipoasistente_tipasidescri, "
                    + "       tipoidentificacion.\"codtipoidentidad\"     AS "
                    + "       tipoidentificacion_codtipoidentidad, "
                    + "       tipoidentificacion.\"descripcion\"          AS "
                    + "       tipoidentificacion_descripcion, "
                    + "       encuentroreunion.\"encuencodigo\"           AS "
                    + "       encuentroreunion_encuencodigo "
                    + "FROM   \"public\".\"encuentroreunion\" encuentroreunion "
                    + "       INNER JOIN \"public\".\"encuenasistenteexterno\" encuenasistenteexterno "
                    + "         ON encuentroreunion.\"encuencodigo\" = "
                    + "            encuenasistenteexterno.\"encuencodigo\" "
                    + "       INNER JOIN \"public\".\"tipoasistente\" tipoasistente "
                    + "         ON encuenasistenteexterno.\"tipasicodigo\" = tipoasistente.\"tipasicodigo\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON encuenasistenteexterno.\"codtipoidentidad\" = "
                    + "            tipoidentificacion.\"codtipoidentidad\"  WHERE encuenasistenteexterno.encuencodigo = '" + dkda.o(sel, "encuencodigo") + "' "
                    + "AND encuenasistenteexterno.codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND encuenasistenteexterno.externidenti = '" + dkda.o(sel, "externidenti") + "' ";
            System.out.println(sql);


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            
            info += "text|#exterobserv_encuenasistenteexterno|" + (rs.getString("encuenasistenteexterno_exterobserv") == null ? "" : rs.getString("encuenasistenteexterno_exterobserv")) + ":_";
            
            info += "combo|#tipasicodigo_encuenasistenteexterno|" + rs.getString("tipoasistente_tipasicodigo") + "|llenarCombo('tipasicodigo_encuenasistenteexterno', '"
                    + rs.getString("tipoasistente_tipasicodigo") + "', '" + rs.getString("tipoasistente_tipasidescri") + "'):_";
            
            info += "text|#asiextapellido_encuenasistenteexterno|" + (rs.getString("encuenasistenteexterno_asiextapellido") == null ? "" : rs.getString("encuenasistenteexterno_asiextapellido")) + ":_";
            
            info += "text|#asiextnombre_encuenasistenteexterno|" + (rs.getString("encuenasistenteexterno_asiextnombre") == null ? "" : rs.getString("encuenasistenteexterno_asiextnombre")) + ":_";
            
            info += "text|#externidenti_encuenasistenteexterno|" + (rs.getString("encuenasistenteexterno_externidenti") == null ? "" : rs.getString("encuenasistenteexterno_externidenti")) + ":_";
            
            info += "combo|#codtipoidentidad_encuenasistenteexterno|" + rs.getString("tipoidentificacion_codtipoidentidad") + "|llenarCombo('codtipoidentidad_encuenasistenteexterno', '"
                    + rs.getString("tipoidentificacion_codtipoidentidad") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";
            
            info += "combo|#encuencodigo_encuenasistenteexterno|" + rs.getString("encuenasistenteexterno_encuencodigo") + "|llenarCombo('encuencodigo_encuenasistenteexterno', '"
                    + rs.getString("encuenasistenteexterno_encuencodigo") + "', '" + rs.getString("encuenasistenteexterno_encuencodigo") + "'):_";
            
            respuesta = "opcion=obtener_encuenasistenteexterno&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_encuenasistenteexterno&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error encuenasistenteexterno - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_encuenasistenteexterno() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM encuenasistenteexterno  WHERE encuencodigo = '" + 
                    dkda.o(vars, "encuencodigo_encuenasistenteexterno") + "'" + " AND codtipoidentidad = '" + dkda.o(vars, "codtipoidentidad_encuenasistenteexterno") + "'" + ""
                    + " AND externidenti = '" + dkda.o(vars, "externidenti_encuenasistenteexterno") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_encuenasistenteexterno() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_encuenasistenteexterno() {
        String direccion = "opcion=registrar_encuenasistenteexterno&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_encuenasistenteexterno();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "encuencodigo").toString().equals(dkda.o(vars, "encuencodigo_encuenasistenteexterno")) && dkda.o(sel, "codtipoidentidad").toString().equals(dkda.o(vars, "codtipoidentidad_encuenasistenteexterno")) && dkda.o(sel, "externidenti").toString().equals(dkda.o(vars, "externidenti_encuenasistenteexterno"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "encuencodigo_encuenasistenteexterno").isEmpty()) {
            error = "Código Encuentros o Reuniones: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_encuenasistenteexterno").isEmpty()) {
            error = "Tipo Identificacion Asistente Externo: no puede ser vacio.";
        } else if (dkda.o(vars, "externidenti_encuenasistenteexterno").isEmpty()) {
            error = "Identificación Asistente Externo: no puede ser vacio.";
        } else if (dkda.o(vars, "asiextnombre_encuenasistenteexterno").isEmpty()) {
            error = "Nombres Asistente Externo: no puede ser vacio.";
        } else if (dkda.o(vars, "asiextapellido_encuenasistenteexterno").isEmpty()) {
            error = "Apellidos Asistente Externo: no puede ser vacio.";
        } else if (dkda.o(vars, "tipasicodigo_encuenasistenteexterno").isEmpty()) {
            error = "Código Tipo Asistente: no puede ser vacio.";
        } else if (dkda.o(vars, "exterobserv_encuenasistenteexterno").isEmpty()) {
            error = "Observaciones Asistente Externo: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "externidenti_encuenasistenteexterno"))) {
            error = "Identificación Asistente Externo: Tiene Caracteres no permitidos.";
        } else if (!v.caracteres(dkda.o(vars, "asiextnombre_encuenasistenteexterno"))) {
            error = "Nombres Asistente Externo: Tiene Caracteres no permitidos.";
        } else if (!v.caracteres(dkda.o(vars, "asiextapellido_encuenasistenteexterno"))) {
            error = "Apellidos Asistente Externo: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "externidenti_encuenasistenteexterno").length() > 10) {
            error = "Identificación Asistente Externo: Valor demasiado Largo.";
        } else if (dkda.o(vars, "asiextnombre_encuenasistenteexterno").length() > 30) {
            error = "Nombres Asistente Externo: Valor demasiado Largo.";
        } else if (dkda.o(vars, "asiextapellido_encuenasistenteexterno").length() > 30) {
            error = "Apellidos Asistente Externo: Valor demasiado Largo.";
        } else if (dkda.o(vars, "exterobserv_encuenasistenteexterno").length() > 400) {
            error = "Observaciones Asistente Externo: Valor demasiado Largo.";
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