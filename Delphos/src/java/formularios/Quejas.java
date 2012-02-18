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

public class Quejas extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, quejaclasificacion_quejas_1;
    HashMap quejas_quejadocumento_1;
    HashMap beneficiario_quejabeneficiario_1, quejas_quejabeneficiario_1;
    HashMap quejas_quejarespuesta_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());
        quejaclasificacion_quejas_1 = fun.map(dkda.o(vars, "quejaclasificacion_quejas_1").toString());
        quejas_quejadocumento_1 = fun.map(dkda.o(vars, "quejas_quejadocumento_1").toString());
        beneficiario_quejabeneficiario_1 = fun.map(dkda.o(vars, "beneficiario_quejabeneficiario_1").toString());
        quejas_quejabeneficiario_1 = fun.map(dkda.o(vars, "quejas_quejabeneficiario_1").toString());
        quejas_quejarespuesta_1 = fun.map(dkda.o(vars, "quejas_quejarespuesta_1").toString());
        try {
            String opcion = dkda.o(vars, "accion").toString();
            String pestana = dkda.o(vars, "pestana").toString();
            respuesta = "";

            if (pestana.equals("quejas") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_quejas();
            }
            if (opcion.equals("Registrar") && pestana.equals("quejas") && respuesta.length() == 0) {
                out.println(registrar_quejas(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("quejas") && respuesta.length() == 0) {
                out.println(actualizar_quejas(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("quejas") && respuesta.length() == 0) {
                out.println(eliminar_quejas(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("quejas") && respuesta.length() == 0) {
                out.println(obtener_quejas(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("quejadocumento") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_quejadocumento();
            }
            if (opcion.equals("Registrar") && pestana.equals("quejadocumento") && respuesta.length() == 0) {
                out.println(registrar_quejadocumento(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("quejadocumento") && respuesta.length() == 0) {
                out.println(actualizar_quejadocumento(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("quejadocumento") && respuesta.length() == 0) {
                out.println(eliminar_quejadocumento(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("quejadocumento") && respuesta.length() == 0) {
                out.println(obtener_quejadocumento(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("quejabeneficiario") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_quejabeneficiario();
            }
            if (opcion.equals("Registrar") && pestana.equals("quejabeneficiario") && respuesta.length() == 0) {
                out.println(registrar_quejabeneficiario(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("quejabeneficiario") && respuesta.length() == 0) {
                out.println(actualizar_quejabeneficiario(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("quejabeneficiario") && respuesta.length() == 0) {
                out.println(eliminar_quejabeneficiario(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("quejabeneficiario") && respuesta.length() == 0) {
                out.println(obtener_quejabeneficiario(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("quejarespuesta") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_quejarespuesta();
            }
            if (opcion.equals("Registrar") && pestana.equals("quejarespuesta") && respuesta.length() == 0) {
                out.println(registrar_quejarespuesta(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("quejarespuesta") && respuesta.length() == 0) {
                out.println(actualizar_quejarespuesta(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("quejarespuesta") && respuesta.length() == 0) {
                out.println(eliminar_quejarespuesta(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("quejarespuesta") && respuesta.length() == 0) {
                out.println(obtener_quejarespuesta(con, dkda.o(vars, "codigo").toString()));
            }
            if (respuesta.length() > 0) {
                out.println(respuesta);
            }
        } finally {
            out.close();
        }
    }

    public String registrar_quejas(ConexionBaseDatos con) {
        System.out.println("registrar_quejas");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO quejas (codunifami,quejconsecut,quejciclpago,codtipoidentidadpers,quejidentifi,quejfecha,tipquecodigo,queclacodigo,codtipoidentidad,numidentfunc,quejobservac,ususiscodigo,fecharegistro,quejarchdocu,quejarchdocu_nombre) VALUES (" + (dkda.o(vars, "codunifami_quejas").equals("") ? null : "'" + dkda.o(vars, "codunifami_quejas") + "'") + "," + (dkda.o(vars, "quejconsecut_quejas").equals("") ? null : dkda.o(vars, "quejconsecut_quejas")) + "," + (dkda.o(vars, "quejciclpago_quejas").equals("") ? null : dkda.o(vars, "quejciclpago_quejas")) + "," + (dkda.o(vars, "codtipoidentidadpers_quejas").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadpers_quejas") + "'") + "," + (dkda.o(vars, "quejidentifi_quejas").equals("") ? null : "'" + dkda.o(vars, "quejidentifi_quejas") + "'") + "," + (dkda.o(vars, "quejfecha_quejas").equals("") ? null : "'" + dkda.o(vars, "quejfecha_quejas") + "'") + "," + (dkda.o(quejaclasificacion_quejas_1, "tipquecodigo").equals("") ? null : "'" + dkda.o(quejaclasificacion_quejas_1, "tipquecodigo") + "'") + "," + (dkda.o(quejaclasificacion_quejas_1, "queclacodigo").equals("") ? null : "'" + dkda.o(quejaclasificacion_quejas_1, "queclacodigo") + "'") + "," + (dkda.o(vars, "codtipoidentidad_quejas").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_quejas") + "'") + "," + (dkda.o(vars, "numidentfunc_quejas").equals("") ? null : "'" + dkda.o(vars, "numidentfunc_quejas") + "'") + "," + (dkda.o(vars, "quejobservac_quejas").equals("") ? null : "'" + dkda.o(vars, "quejobservac_quejas") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "quejarchdocu_quejas").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "quejarchdocu_quejas") + "')") + "," + (dkda.o(vars, "quejarchdocu_quejas").equals("") ? null : "'" + dkda.o(vars, "quejarchdocu_quejas") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_quejas&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_quejas&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error quejas.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_quejas(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE quejas SET codunifami = " + (dkda.o(vars, "codunifami_quejas").equals("") ? null : "'" + dkda.o(vars, "codunifami_quejas") + "'") + ",quejconsecut = " + (dkda.o(vars, "quejconsecut_quejas").equals("") ? null : dkda.o(vars, "quejconsecut_quejas")) + ",quejciclpago = " + (dkda.o(vars, "quejciclpago_quejas").equals("") ? null : dkda.o(vars, "quejciclpago_quejas")) + ",codtipoidentidadpers = " + (dkda.o(vars, "codtipoidentidadpers_quejas").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadpers_quejas") + "'") + ",quejidentifi = " + (dkda.o(vars, "quejidentifi_quejas").equals("") ? null : "'" + dkda.o(vars, "quejidentifi_quejas") + "'") + ",quejfecha = " + (dkda.o(vars, "quejfecha_quejas").equals("") ? null : "'" + dkda.o(vars, "quejfecha_quejas") + "'") + ",tipquecodigo = " + (dkda.o(quejaclasificacion_quejas_1, "tipquecodigo").equals("") ? null : "'" + dkda.o(quejaclasificacion_quejas_1, "tipquecodigo") + "'") + ",queclacodigo = " + (dkda.o(quejaclasificacion_quejas_1, "queclacodigo").equals("") ? null : "'" + dkda.o(quejaclasificacion_quejas_1, "queclacodigo") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_quejas").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_quejas") + "'") + ",numidentfunc = " + (dkda.o(vars, "numidentfunc_quejas").equals("") ? null : "'" + dkda.o(vars, "numidentfunc_quejas") + "'") + ",quejobservac = " + (dkda.o(vars, "quejobservac_quejas").equals("") ? null : "'" + dkda.o(vars, "quejobservac_quejas") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",quejarchdocu = " + (dkda.o(vars, "quejarchdocu_quejas").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "quejarchdocu_quejas") + "')") + ",quejarchdocu_nombre = " + (dkda.o(vars, "quejarchdocu_quejas").equals("") ? null : "'" + dkda.o(vars, "quejarchdocu_quejas") + "'") + " WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND quejconsecut = " + dkda.o(sel, "quejconsecut") + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_quejas&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_quejas&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error quejas.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_quejas(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM quejas WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND quejconsecut = " + dkda.o(sel, "quejconsecut") + " ");
            stmt.execute();
            respuesta = "opcion=eliminar_quejas&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_quejas&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error quejas.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_quejas(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            respuesta = "opcion=obtener_quejas&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_quejas&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error quejas - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_quejas() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM quejas  WHERE codunifami = '" + dkda.o(sel, "codunifami") + "'" + " AND quejconsecut = " + dkda.o(sel, "quejconsecut") + "");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_quejas() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_quejas() {
        String direccion = "opcion=registrar_quejas&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_quejas();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codunifami").toString().equals(dkda.o(vars, "codunifami_quejas")) && dkda.o(sel, "quejconsecut").toString().equals(dkda.o(vars, "quejconsecut_quejas"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codunifami_quejas").isEmpty()) {
            error = "Código &Uacute;nico Familia: no puede ser vacio.";
        } else if (dkda.o(vars, "quejconsecut_quejas").isEmpty()) {
            error = "Consecutivo Queja: no puede ser vacio.";
        } else if (dkda.o(vars, "quejciclpago_quejas").isEmpty()) {
            error = "Ciclo Pago Afectado Queja: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidadpers_quejas").isEmpty()) {
            error = "Tipo Identificaci&oacute;n Persona Queja: no puede ser vacio.";
        } else if (dkda.o(vars, "quejidentifi_quejas").isEmpty()) {
            error = "Identificación Persona Queja: no puede ser vacio.";
        } else if (dkda.o(vars, "quejfecha_quejas").isEmpty()) {
            error = "Fecha Queja: no puede ser vacio.";
        } else if (dkda.o(vars, "tipquecodigo_quejas").isEmpty()) {
            error = "Código Tipo de Queja: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_quejas").isEmpty()) {
            error = "Tipo Identificacion Funcionario Recibe la Queja: no puede ser vacio.";
        } else if (dkda.o(vars, "numidentfunc_quejas").isEmpty()) {
            error = "Numero Dcumento Identidad Funcionario Recibe Queja: no puede ser vacio.";
        } else if (dkda.o(vars, "quejarchdocu_quejas").isEmpty()) {
            error = "Archivo Documento Queja: no puede ser vacio.";
        } else if (dkda.o(vars, "quejobservac_quejas").isEmpty()) {
            error = "Observaciones Queja: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "quejidentifi_quejas"))) {
            error = "Identificación Persona Queja: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "quejidentifi_quejas").length() > 10) {
            error = "Identificación Persona Queja: Valor demasiado Largo.";
        } else if (dkda.o(vars, "numidentfunc_quejas").length() > 18) {
            error = "Numero Dcumento Identidad Funcionario Recibe Queja: Valor demasiado Largo.";
        } else if (dkda.o(vars, "quejobservac_quejas").length() > 400) {
            error = "Observaciones Queja: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_quejadocumento(ConexionBaseDatos con) {
        System.out.println("registrar_quejadocumento");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO quejadocumento (codunifami,quejconsecut,codtipodctoasociado,quedocentreg,ususiscodigo,fecharegistro,quedocarchi,quedocarchi_nombre) VALUES (" + (dkda.o(quejas_quejadocumento_1, "codunifami").equals("") ? null : "'" + dkda.o(quejas_quejadocumento_1, "codunifami") + "'") + "," + (dkda.o(quejas_quejadocumento_1, "quejconsecut").equals("") ? null : dkda.o(quejas_quejadocumento_1, "quejconsecut")) + "," + (dkda.o(vars, "codtipodctoasociado_quejadocumento").equals("") ? null : "'" + dkda.o(vars, "codtipodctoasociado_quejadocumento") + "'") + "," + (dkda.o(vars, "quedocentreg_quejadocumento").equals("") ? null : "'" + dkda.o(vars, "quedocentreg_quejadocumento") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "quedocarchi_quejadocumento").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "quedocarchi_quejadocumento") + "')") + "," + (dkda.o(vars, "quedocarchi_quejadocumento").equals("") ? null : "'" + dkda.o(vars, "quedocarchi_quejadocumento") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_quejadocumento&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_quejadocumento&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error quejadocumento.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_quejadocumento(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE quejadocumento SET codunifami = " + (dkda.o(quejas_quejadocumento_1, "codunifami").equals("") ? null : "'" + dkda.o(quejas_quejadocumento_1, "codunifami") + "'") + ",quejconsecut = " + (dkda.o(quejas_quejadocumento_1, "quejconsecut").equals("") ? null : dkda.o(quejas_quejadocumento_1, "quejconsecut")) + ",codtipodctoasociado = " + (dkda.o(vars, "codtipodctoasociado_quejadocumento").equals("") ? null : "'" + dkda.o(vars, "codtipodctoasociado_quejadocumento") + "'") + ",quedocentreg = " + (dkda.o(vars, "quedocentreg_quejadocumento").equals("") ? null : "'" + dkda.o(vars, "quedocentreg_quejadocumento") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",quedocarchi = " + (dkda.o(vars, "quedocarchi_quejadocumento").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "quedocarchi_quejadocumento") + "')") + ",quedocarchi_nombre = " + (dkda.o(vars, "quedocarchi_quejadocumento").equals("") ? null : "'" + dkda.o(vars, "quedocarchi_quejadocumento") + "'") + " WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND quejconsecut = " + dkda.o(sel, "quejconsecut") + " AND codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_quejadocumento&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_quejadocumento&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error quejadocumento.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_quejadocumento(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM quejadocumento WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND quejconsecut = " + dkda.o(sel, "quejconsecut") + " AND codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_quejadocumento&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_quejadocumento&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error quejadocumento.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_quejadocumento(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            respuesta = "opcion=obtener_quejadocumento&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_quejadocumento&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error quejadocumento - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_quejadocumento() {
        String direccion = "opcion=registrar_quejadocumento&&estado=no&&error=si&&errorDes=";
        String error = "";
        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_quejabeneficiario(ConexionBaseDatos con) {
        System.out.println("registrar_quejabeneficiario");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO quejabeneficiario (codunifami,quejconsecut,codtipoidentidad,identbenef,quebenobserv,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(beneficiario_quejabeneficiario_1, "codunifami").equals("") ? null : "'" + dkda.o(beneficiario_quejabeneficiario_1, "codunifami") + "'") + "," + (dkda.o(quejas_quejabeneficiario_1, "quejconsecut").equals("") ? null : dkda.o(quejas_quejabeneficiario_1, "quejconsecut")) + "," + (dkda.o(beneficiario_quejabeneficiario_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(beneficiario_quejabeneficiario_1, "codtipoidentidad") + "'") + "," + (dkda.o(beneficiario_quejabeneficiario_1, "identbenef").equals("") ? null : "'" + dkda.o(beneficiario_quejabeneficiario_1, "identbenef") + "'") + "," + (dkda.o(vars, "quebenobserv_quejabeneficiario").equals("") ? null : "'" + dkda.o(vars, "quebenobserv_quejabeneficiario") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_quejabeneficiario&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_quejabeneficiario&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error quejabeneficiario.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_quejabeneficiario(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE quejabeneficiario SET codunifami = " + (dkda.o(beneficiario_quejabeneficiario_1, "codunifami").equals("") ? null : "'" + dkda.o(beneficiario_quejabeneficiario_1, "codunifami") + "'") + ",quejconsecut = " + (dkda.o(quejas_quejabeneficiario_1, "quejconsecut").equals("") ? null : dkda.o(quejas_quejabeneficiario_1, "quejconsecut")) + ",codtipoidentidad = " + (dkda.o(beneficiario_quejabeneficiario_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(beneficiario_quejabeneficiario_1, "codtipoidentidad") + "'") + ",identbenef = " + (dkda.o(beneficiario_quejabeneficiario_1, "identbenef").equals("") ? null : "'" + dkda.o(beneficiario_quejabeneficiario_1, "identbenef") + "'") + ",quebenobserv = " + (dkda.o(vars, "quebenobserv_quejabeneficiario").equals("") ? null : "'" + dkda.o(vars, "quebenobserv_quejabeneficiario") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND quejconsecut = " + dkda.o(sel, "quejconsecut") + " AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND identbenef = '" + dkda.o(sel, "identbenef") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_quejabeneficiario&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_quejabeneficiario&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error quejabeneficiario.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_quejabeneficiario(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM quejabeneficiario WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND quejconsecut = " + dkda.o(sel, "quejconsecut") + " AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND identbenef = '" + dkda.o(sel, "identbenef") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_quejabeneficiario&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_quejabeneficiario&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error quejabeneficiario.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_quejabeneficiario(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            respuesta = "opcion=obtener_quejabeneficiario&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_quejabeneficiario&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error quejabeneficiario - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_quejabeneficiario() {
        String direccion = "opcion=registrar_quejabeneficiario&&estado=no&&error=si&&errorDes=";
        String error = "";
        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_quejarespuesta(ConexionBaseDatos con) {
        System.out.println("registrar_quejarespuesta");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO quejarespuesta (codunifami,quejconsecut,queresfecha,resclacodigo,codtipoidentidad,numidentfunc,querespercep,tipsatcodigo,queresobserv,ususiscodigo,fecharegistro,queresarchiv,queresarchiv_nombre) VALUES (" + (dkda.o(quejas_quejarespuesta_1, "codunifami").equals("") ? null : "'" + dkda.o(quejas_quejarespuesta_1, "codunifami") + "'") + "," + (dkda.o(quejas_quejarespuesta_1, "quejconsecut").equals("") ? null : dkda.o(quejas_quejarespuesta_1, "quejconsecut")) + "," + (dkda.o(vars, "queresfecha_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "queresfecha_quejarespuesta") + "'") + "," + (dkda.o(vars, "resclacodigo_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "resclacodigo_quejarespuesta") + "'") + "," + (dkda.o(vars, "codtipoidentidad_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_quejarespuesta") + "'") + "," + (dkda.o(vars, "numidentfunc_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "numidentfunc_quejarespuesta") + "'") + "," + (dkda.o(vars, "querespercep_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "querespercep_quejarespuesta") + "'") + "," + (dkda.o(vars, "tipsatcodigo_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "tipsatcodigo_quejarespuesta") + "'") + "," + (dkda.o(vars, "queresobserv_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "queresobserv_quejarespuesta") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "queresarchiv_quejarespuesta").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "queresarchiv_quejarespuesta") + "')") + "," + (dkda.o(vars, "queresarchiv_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "queresarchiv_quejarespuesta") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_quejarespuesta&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_quejarespuesta&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error quejarespuesta.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_quejarespuesta(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE quejarespuesta SET codunifami = " + (dkda.o(quejas_quejarespuesta_1, "codunifami").equals("") ? null : "'" + dkda.o(quejas_quejarespuesta_1, "codunifami") + "'") + ",quejconsecut = " + (dkda.o(quejas_quejarespuesta_1, "quejconsecut").equals("") ? null : dkda.o(quejas_quejarespuesta_1, "quejconsecut")) + ",queresfecha = " + (dkda.o(vars, "queresfecha_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "queresfecha_quejarespuesta") + "'") + ",resclacodigo = " + (dkda.o(vars, "resclacodigo_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "resclacodigo_quejarespuesta") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_quejarespuesta") + "'") + ",numidentfunc = " + (dkda.o(vars, "numidentfunc_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "numidentfunc_quejarespuesta") + "'") + ",querespercep = " + (dkda.o(vars, "querespercep_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "querespercep_quejarespuesta") + "'") + ",tipsatcodigo = " + (dkda.o(vars, "tipsatcodigo_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "tipsatcodigo_quejarespuesta") + "'") + ",queresobserv = " + (dkda.o(vars, "queresobserv_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "queresobserv_quejarespuesta") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",queresarchiv = " + (dkda.o(vars, "queresarchiv_quejarespuesta").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "queresarchiv_quejarespuesta") + "')") + ",queresarchiv_nombre = " + (dkda.o(vars, "queresarchiv_quejarespuesta").equals("") ? null : "'" + dkda.o(vars, "queresarchiv_quejarespuesta") + "'") + " WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND quejconsecut = " + dkda.o(sel, "quejconsecut") + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_quejarespuesta&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_quejarespuesta&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error quejarespuesta.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_quejarespuesta(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM quejarespuesta WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND quejconsecut = " + dkda.o(sel, "quejconsecut") + " ");
            stmt.execute();
            respuesta = "opcion=eliminar_quejarespuesta&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_quejarespuesta&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error quejarespuesta.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_quejarespuesta(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            respuesta = "opcion=obtener_quejarespuesta&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_quejarespuesta&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error quejarespuesta - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_quejarespuesta() {
        String direccion = "opcion=registrar_quejarespuesta&&estado=no&&error=si&&errorDes=";
        String error = "";
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