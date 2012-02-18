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

public class FirmasAutorizadas extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, empresa_firmasautorizadas_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());



        empresa_firmasautorizadas_1 = fun.map(dkda.o(vars, "empresa_firmasautorizadas_1").toString());
        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_firmasautorizadas();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_firmasautorizadas(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_firmasautorizadas(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_firmasautorizadas(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_firmasautorizadas(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_firmasautorizadas(ConexionBaseDatos con) {
        System.out.println("registrar_firmasautorizadas");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO firmasautorizadas (codtipoidentidadfir,firmidentifi,codtipoidentidad,codempresa,firmnombre1,firmnombre2,firmapellido1,firmapellido2,firmfechinic,firmfechfina,firmfirma,firmobservac,ususiscodigo,fecharegistro,firmarchivo,firmarchivo_nombre,huelladactilar,huelladactilar_nombre,foto,foto_nombre,tienehuella) VALUES (" + (dkda.o(vars, "codtipoidentidadfir_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadfir_firmasautorizadas") + "'") + "," + (dkda.o(vars, "firmidentifi_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmidentifi_firmasautorizadas") + "'") + "," + (dkda.o(empresa_firmasautorizadas_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_firmasautorizadas_1, "codtipoidentidad") + "'") + "," + (dkda.o(empresa_firmasautorizadas_1, "codempresa").equals("") ? null : "'" + dkda.o(empresa_firmasautorizadas_1, "codempresa") + "'") + "," + (dkda.o(vars, "firmnombre1_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmnombre1_firmasautorizadas") + "'") + "," + (dkda.o(vars, "firmnombre2_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmnombre2_firmasautorizadas") + "'") + "," + (dkda.o(vars, "firmapellido1_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmapellido1_firmasautorizadas") + "'") + "," + (dkda.o(vars, "firmapellido2_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmapellido2_firmasautorizadas") + "'") + "," + (dkda.o(vars, "firmfechinic_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmfechinic_firmasautorizadas") + "'") + "," + (dkda.o(vars, "firmfechfina_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmfechfina_firmasautorizadas") + "'") + "," + (dkda.o(vars, "firmfirma_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmfirma_firmasautorizadas") + "'") + "," + (dkda.o(vars, "firmobservac_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmobservac_firmasautorizadas") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "firmarchivo_firmasautorizadas").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "firmarchivo_firmasautorizadas") + "')") + "," + (dkda.o(vars, "firmarchivo_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmarchivo_firmasautorizadas") + "'") + "," + (dkda.o(vars, "huelladactilar_firmasautorizadas").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "huelladactilar_firmasautorizadas") + "')") + "," + (dkda.o(vars, "huelladactilar_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "huelladactilar_firmasautorizadas") + "'") + "," + (dkda.o(vars, "foto_firmasautorizadas").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "foto_firmasautorizadas") + "')") + "," + (dkda.o(vars, "foto_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "foto_firmasautorizadas") + "'") + "," + (dkda.o(vars, "tienehuella_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "tienehuella_firmasautorizadas") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_firmasautorizadas&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_firmasautorizadas&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error firmasautorizadas.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_firmasautorizadas(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE firmasautorizadas SET codtipoidentidadfir = " + (dkda.o(vars, "codtipoidentidadfir_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadfir_firmasautorizadas") + "'") + ",firmidentifi = " + (dkda.o(vars, "firmidentifi_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmidentifi_firmasautorizadas") + "'") + ",codtipoidentidad = " + (dkda.o(empresa_firmasautorizadas_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_firmasautorizadas_1, "codtipoidentidad") + "'") + ",codempresa = " + (dkda.o(empresa_firmasautorizadas_1, "codempresa").equals("") ? null : "'" + dkda.o(empresa_firmasautorizadas_1, "codempresa") + "'") + ",firmnombre1 = " + (dkda.o(vars, "firmnombre1_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmnombre1_firmasautorizadas") + "'") + ",firmnombre2 = " + (dkda.o(vars, "firmnombre2_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmnombre2_firmasautorizadas") + "'") + ",firmapellido1 = " + (dkda.o(vars, "firmapellido1_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmapellido1_firmasautorizadas") + "'") + ",firmapellido2 = " + (dkda.o(vars, "firmapellido2_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmapellido2_firmasautorizadas") + "'") + ",firmfechinic = " + (dkda.o(vars, "firmfechinic_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmfechinic_firmasautorizadas") + "'") + ",firmfechfina = " + (dkda.o(vars, "firmfechfina_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmfechfina_firmasautorizadas") + "'") + ",firmfirma = " + (dkda.o(vars, "firmfirma_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmfirma_firmasautorizadas") + "'") + ",firmobservac = " + (dkda.o(vars, "firmobservac_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmobservac_firmasautorizadas") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",firmarchivo = " + (dkda.o(vars, "firmarchivo_firmasautorizadas").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "firmarchivo_firmasautorizadas") + "')") + ",firmarchivo_nombre = " + (dkda.o(vars, "firmarchivo_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "firmarchivo_firmasautorizadas") + "'") + ",huelladactilar = " + (dkda.o(vars, "huelladactilar_firmasautorizadas").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "huelladactilar_firmasautorizadas") + "')") + ",huelladactilar_nombre = " + (dkda.o(vars, "huelladactilar_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "huelladactilar_firmasautorizadas") + "'") + ",foto = " + (dkda.o(vars, "foto_firmasautorizadas").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "foto_firmasautorizadas") + "')") + ",foto_nombre = " + (dkda.o(vars, "foto_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "foto_firmasautorizadas") + "'") + ",tienehuella = " + (dkda.o(vars, "tienehuella_firmasautorizadas").equals("") ? null : "'" + dkda.o(vars, "tienehuella_firmasautorizadas") + "'") + " WHERE codtipoidentidadfir = '" + dkda.o(sel, "codtipoidentidadfir") + "' AND firmidentifi = '" + dkda.o(sel, "firmidentifi") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_firmasautorizadas&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_firmasautorizadas&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error firmasautorizadas.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_firmasautorizadas(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM firmasautorizadas WHERE codtipoidentidadfir = '" + dkda.o(sel, "codtipoidentidadfir") + "' AND firmidentifi = '" + dkda.o(sel, "firmidentifi") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_firmasautorizadas&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_firmasautorizadas&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error firmasautorizadas.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_firmasautorizadas(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "firmasautorizadas.codtipoidentidadfir AS firmasautorizadas_codtipoidentidadfir,"
                    + "firmasautorizadas.firmidentifi AS firmasautorizadas_firmidentifi,"
                    + "firmasautorizadas.codtipoidentidad AS firmasautorizadas_codtipoidentidad,"
                    + "firmasautorizadas.codempresa AS firmasautorizadas_codempresa,"
                    + "firmasautorizadas.firmnombre1 AS firmasautorizadas_firmnombre1,"
                    + "firmasautorizadas.firmnombre2 AS firmasautorizadas_firmnombre2,"
                    + "firmasautorizadas.firmapellido1 AS firmasautorizadas_firmapellido1,"
                    + "firmasautorizadas.firmapellido2 AS firmasautorizadas_firmapellido2,"
                    + "firmasautorizadas.firmfechinic AS firmasautorizadas_firmfechinic,"
                    + "firmasautorizadas.firmfechfina AS firmasautorizadas_firmfechfina,"
                    + "firmasautorizadas.firmfirma AS firmasautorizadas_firmfirma,"
                    + "firmasautorizadas.firmobservac AS firmasautorizadas_firmobservac,"
                    + "firmasautorizadas.ususiscodigo AS firmasautorizadas_ususiscodigo,"
                    + "firmasautorizadas.fecharegistro AS firmasautorizadas_fecharegistro,"
                    + "firmasautorizadas.firmarchivo AS firmasautorizadas_firmarchivo,"
                    + "firmasautorizadas.firmarchivo_nombre AS firmasautorizadas_firmarchivo_nombre,"
                    + "firmasautorizadas.huelladactilar AS firmasautorizadas_huelladactilar,"
                    + "firmasautorizadas.huelladactilar_nombre AS firmasautorizadas_huelladactilar_nombre,"
                    + "firmasautorizadas.foto AS firmasautorizadas_foto,"
                    + "firmasautorizadas.foto_nombre AS firmasautorizadas_foto_nombre,"
                    + "firmasautorizadas.tienehuella AS firmasautorizadas_tienehuella,"
                    + "CASE WHEN firmasautorizadas.firmarchivo_nombre IS NULL OR firmasautorizadas.firmarchivo_nombre = '' THEN 0 "
                    + "ELSE lo_export(firmasautorizadas.firmarchivo, '" + fun.temp(request) + "' || firmasautorizadas.firmarchivo_nombre) END,"
                    + "CASE WHEN firmasautorizadas.huelladactilar_nombre IS NULL OR firmasautorizadas.huelladactilar_nombre = '' THEN 0 "
                    + "ELSE lo_export(firmasautorizadas.huelladactilar, '" + fun.temp(request) + "' || firmasautorizadas.huelladactilar_nombre) END,"
                    + "CASE WHEN firmasautorizadas.foto_nombre IS NULL OR firmasautorizadas.foto_nombre = '' THEN 0 "
                    + "ELSE lo_export(firmasautorizadas.foto, '" + fun.temp(request) + "' || firmasautorizadas.foto_nombre) END,"
                    + "empresa.nombre AS empresa_nombre,"
                    + "tipoidentificacion.descripcion AS tipoidentificacion_descripcion "
                    + " FROM "
                    + " public.empresa empresa INNER JOIN public.firmasautorizadas firmasautorizadas ON empresa.codtipoidentidad = firmasautorizadas.codtipoidentidad "
                    + " AND empresa.codempresa = firmasautorizadas.codempresa "
                    + " INNER JOIN public.tipoidentificacion tipoidentificacion ON firmasautorizadas.codtipoidentidadfir = tipoidentificacion.codtipoidentidad "
                    + "WHERE codtipoidentidadfir = '" + dkda.o(sel, "codtipoidentidadfir") + "' AND firmidentifi = '" + dkda.o(sel, "firmidentifi") + "' ";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();


            info += "combo|#codtipoidentidadfir_firmasautorizadas|" + rs.getString("firmasautorizadas_codtipoidentidadfir") + "|llenarCombo('codtipoidentidadfir_firmasautorizadas', '"
                    + rs.getString("firmasautorizadas_codtipoidentidadfir") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";


            info += "combo|#empresa_firmasautorizadas_1|" + "empresa   codtipoidentidad  " + rs.getString("firmasautorizadas_codtipoidentidad")
                    + "   codempresa  " + rs.getString("firmasautorizadas_codempresa") + "|llenarCombo('empresa_firmasautorizadas_1', '"
                    + "empresa   codtipoidentidad  " + rs.getString("firmasautorizadas_codtipoidentidad")
                    + "   codempresa  " + rs.getString("firmasautorizadas_codempresa") + "', '" + rs.getString("empresa_nombre") + "'):_";


            info += "text|#firmnombre1_firmasautorizadas|" + (rs.getString("firmasautorizadas_firmnombre1") == null ? "" : rs.getString("firmasautorizadas_firmnombre1")) + ":_";

            info += "text|#firmnombre2_firmasautorizadas|" + (rs.getString("firmasautorizadas_firmnombre2") == null ? "" : rs.getString("firmasautorizadas_firmnombre2")) + ":_";

            info += "text|#firmapellido1_firmasautorizadas|" + (rs.getString("firmasautorizadas_firmapellido1") == null ? "" : rs.getString("firmasautorizadas_firmapellido1")) + ":_";

            info += "text|#firmapellido2_firmasautorizadas|" + (rs.getString("firmasautorizadas_firmapellido2") == null ? "" : rs.getString("firmasautorizadas_firmapellido2")) + ":_";


            info += "text|#_fecha_firmfechinic_firmasautorizadas|" + (rs.getString("firmasautorizadas_firmfechinic") == null ? "" : rs.getString("firmasautorizadas_firmfechinic")) + ":_";

            info += "text|#_fecha_firmfechfina_firmasautorizadas|" + (rs.getString("firmasautorizadas_firmfechfina") == null ? "" : rs.getString("firmasautorizadas_firmfechfina")) + ":_";

            info += "text|#firmidentifi_firmasautorizadas|" + (rs.getString("firmasautorizadas_firmidentifi") == null ? "" : rs.getString("firmasautorizadas_firmidentifi")) + ":_";

            info += "text|#firmarchivo_firmasautorizadas|" + (rs.getString("firmasautorizadas_firmarchivo_nombre") == null ? "" : rs.getString("firmasautorizadas_firmarchivo_nombre")) + ":_";

            info += "text|#firmobservac_firmasautorizadas|" + (rs.getString("firmasautorizadas_firmobservac") == null ? "" : rs.getString("firmasautorizadas_firmobservac")) + ":_";

            info += "switch|switch_tienehuella_firmasautorizadas|" + rs.getString("firmasautorizadas_tienehuella") + ":_";


            info += "text|#huelladactilar_firmasautorizadas|" + (rs.getString("firmasautorizadas_huelladactilar_nombre") == null ? "" : rs.getString("firmasautorizadas_huelladactilar_nombre")) + ":_";

            info += "text|#foto_firmasautorizadas|" + (rs.getString("firmasautorizadas_foto_nombre") == null ? "" : rs.getString("firmasautorizadas_foto_nombre")) + ":_";

            info += "text|#firmfirma_firmasautorizadas|" + (rs.getString("firmasautorizadas_firmfirma") == null ? "" : rs.getString("firmasautorizadas_firmfirma")) + ":_";



            respuesta = "opcion=obtener_firmasautorizadas&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_firmasautorizadas&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error firmasautorizadas - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_firmasautorizadas() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM firmasautorizadas  WHERE codtipoidentidadfir = '" + dkda.o(sel, "codtipoidentidadfir") + "'" + " AND firmidentifi = '" + dkda.o(sel, "firmidentifi") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_firmasautorizadas() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_firmasautorizadas() {
        String direccion = "opcion=registrar_firmasautorizadas&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_firmasautorizadas();
        
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codtipoidentidadfir").toString().equals(dkda.o(vars, "codtipoidentidadfir_firmasautorizadas")) && dkda.o(sel, "firmidentifi").toString().equals(dkda.o(vars, "firmidentifi_firmasautorizadas"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codtipoidentidadfir_firmasautorizadas").isEmpty()) {
            error = "Tipo de Identificaci&oacute;n: no puede ser vacio.";
        } else if (dkda.o(vars, "firmidentifi_firmasautorizadas").isEmpty()) {
            error = "Identificación Firma Autorizada Certificar: no puede ser vacio.";
        } else if (dkda.o(vars, "empresa_firmasautorizadas_1").isEmpty()) {
            error = "Institución Educativa: no puede ser vacio.";
        } else if (dkda.o(vars, "firmnombre1_firmasautorizadas").isEmpty()) {
            error = "Nombre 1 Firma Autorizada: no puede ser vacio.";
        } else if (dkda.o(vars, "firmnombre2_firmasautorizadas").isEmpty()) {
            error = "Nombre 2 Firma Autorizada: no puede ser vacio.";
        } else if (dkda.o(vars, "firmapellido1_firmasautorizadas").isEmpty()) {
            error = "Apellido 1 Autorizada: no puede ser vacio.";
        } else if (dkda.o(vars, "firmapellido2_firmasautorizadas").isEmpty()) {
            error = "Apellido 2 Autorizada: no puede ser vacio.";
        } else if (dkda.o(vars, "firmfechinic_firmasautorizadas").isEmpty()) {
            error = "Fecha Inicial: no puede ser vacio.";
        } else if (dkda.o(vars, "firmfechfina_firmasautorizadas").isEmpty()) {
            error = "Fecha Final: no puede ser vacio.";
        } else if (dkda.o(vars, "firmfirma_firmasautorizadas").isEmpty()) {
            error = "Firma Autoriza: no puede ser vacio.";
        } else if (dkda.o(vars, "firmobservac_firmasautorizadas").isEmpty()) {
            error = "Observaciones: no puede ser vacio.";
        } else if (dkda.o(vars, "firmarchivo_firmasautorizadas").isEmpty()) {
            error = "Archivo Documento Autorizando Firma: no puede ser vacio.";
        } else if (dkda.o(vars, "huelladactilar_firmasautorizadas").isEmpty()) {
            error = "Huella Dactilar: no puede ser vacio.";
        } else if (dkda.o(vars, "foto_firmasautorizadas").isEmpty()) {
            error = "Foto: no puede ser vacio.";
        } else if (dkda.o(vars, "tienehuella_firmasautorizadas").isEmpty()) {
            error = "Tiene Huella: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "firmidentifi_firmasautorizadas"))) {
            error = "Identificación Firma Autorizada Certificar: Tiene Caracteres no permitidos.";
        } else if (!v.caracteres(dkda.o(vars, "firmnombre1_firmasautorizadas"))) {
            error = "Nombre 1 Firma Autorizada: Tiene Caracteres no permitidos.";
        } else if (!v.caracteres(dkda.o(vars, "firmnombre2_firmasautorizadas"))) {
            error = "Nombre 2 Firma Autorizada: Tiene Caracteres no permitidos.";
        } else if (!v.caracteres(dkda.o(vars, "firmapellido1_firmasautorizadas"))) {
            error = "Apellido 1 Autorizada: Tiene Caracteres no permitidos.";
        } else if (!v.caracteres(dkda.o(vars, "firmapellido2_firmasautorizadas"))) {
            error = "Apellido 2 Autorizada: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "codtipoidentidadfir_firmasautorizadas").length() > 10) {
            error = "Tipo de Identificaci&oacute;n: Valor demasiado Largo.";
        } else if (dkda.o(vars, "firmidentifi_firmasautorizadas").length() > 18) {
            error = "Identificación Firma Autorizada Certificar: Valor demasiado Largo.";
        } else if (dkda.o(vars, "firmnombre1_firmasautorizadas").length() > 25) {
            error = "Nombre 1 Firma Autorizada: Valor demasiado Largo.";
        } else if (dkda.o(vars, "firmnombre2_firmasautorizadas").length() > 25) {
            error = "Nombre 2 Firma Autorizada: Valor demasiado Largo.";
        } else if (dkda.o(vars, "firmapellido1_firmasautorizadas").length() > 25) {
            error = "Apellido 1 Autorizada: Valor demasiado Largo.";
        } else if (dkda.o(vars, "firmapellido2_firmasautorizadas").length() > 25) {
            error = "Apellido 2 Autorizada: Valor demasiado Largo.";
        } else if (dkda.o(vars, "firmfirma_firmasautorizadas").length() > 100) {
            error = "Firma Autoriza: Valor demasiado Largo.";
        } else if (dkda.o(vars, "firmobservac_firmasautorizadas").length() > 400) {
            error = "Observaciones: Valor demasiado Largo.";
        } else if (dkda.o(vars, "tienehuella_firmasautorizadas").length() > 1) {
            error = "Tiene Huella: Valor demasiado Largo.";
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