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

public class Vinculacion extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, empresa_inscripcion_1, barrio_inscripcion_1, entidadsalud_inscripcion_1, funcionario_inscripcion_1,
            funcionario_inscripcion_2, empresa_inscripcion_2;
    HashMap titularfamilia_grupotitular_1;
    HashMap empresa_beneficiario_1, entidadsalud_beneficiario_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());



        empresa_inscripcion_1 = fun.map(dkda.o(vars, "empresa_inscripcion_1").toString());
        empresa_inscripcion_2 = fun.map(dkda.o(vars, "empresa_inscripcion_2").toString());
        barrio_inscripcion_1 = fun.map(dkda.o(vars, "barrio_inscripcion_1").toString());
        entidadsalud_inscripcion_1 = fun.map(dkda.o(vars, "entidadsalud_inscripcion_1").toString());
        funcionario_inscripcion_1 = fun.map(dkda.o(vars, "funcionario_inscripcion_1").toString());
        funcionario_inscripcion_2 = fun.map(dkda.o(vars, "funcionario_inscripcion_2").toString());
        titularfamilia_grupotitular_1 = fun.map(dkda.o(vars, "titularfamilia_grupotitular_1").toString());
        empresa_beneficiario_1 = fun.map(dkda.o(vars, "empresa_beneficiario_1").toString());
        entidadsalud_beneficiario_1 = fun.map(dkda.o(vars, "entidadsalud_beneficiario_1").toString());





        try {
            String opcion = dkda.o(vars, "accion").toString();
            String pestana = dkda.o(vars, "pestana").toString();
            respuesta = "";

            if (pestana.equals("inscripcion") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_inscripcion();
            }
            if (opcion.equals("Registrar") && pestana.equals("inscripcion") && respuesta.length() == 0) {
                out.println(registrar_inscripcion(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("inscripcion") && respuesta.length() == 0) {
                out.println(actualizar_inscripcion(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("inscripcion") && respuesta.length() == 0) {
                out.println(eliminar_inscripcion(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("inscripcion") && respuesta.length() == 0) {
                out.println(obtener_inscripcion(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("documentoinscripcion") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_documentoinscripcion();
            }
            if (opcion.equals("Registrar") && pestana.equals("documentoinscripcion") && respuesta.length() == 0) {
                out.println(registrar_documentoinscripcion(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("documentoinscripcion") && respuesta.length() == 0) {
                out.println(actualizar_documentoinscripcion(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("documentoinscripcion") && respuesta.length() == 0) {
                out.println(eliminar_documentoinscripcion(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("documentoinscripcion") && respuesta.length() == 0) {
                out.println(obtener_documentoinscripcion(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("grupotitular") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_grupotitular();
            }
            System.out.println("Respuesta : " + respuesta);
            if (opcion.equals("Registrar") && pestana.equals("grupotitular") && respuesta.length() == 0) {
                out.println(registrar_grupotitular(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("grupotitular") && respuesta.length() == 0) {
                out.println(actualizar_grupotitular(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("grupotitular") && respuesta.length() == 0) {
                out.println(eliminar_grupotitular(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("grupotitular") && respuesta.length() == 0) {
                out.println(obtener_grupotitular(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("titularfamilia") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_titularfamilia();
            }
            if (opcion.equals("Registrar") && pestana.equals("titularfamilia") && respuesta.length() == 0) {
                out.println(registrar_titularfamilia(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("titularfamilia") && respuesta.length() == 0) {
                out.println(actualizar_titularfamilia(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("titularfamilia") && respuesta.length() == 0) {
                out.println(eliminar_titularfamilia(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("titularfamilia") && respuesta.length() == 0) {
                out.println(obtener_titularfamilia(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("beneficiario") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_beneficiario();
            }
            if (opcion.equals("Registrar") && pestana.equals("beneficiario") && respuesta.length() == 0) {
                out.println(registrar_beneficiario(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("beneficiario") && respuesta.length() == 0) {
                out.println(actualizar_beneficiario(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("beneficiario") && respuesta.length() == 0) {
                out.println(eliminar_beneficiario(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("beneficiario") && respuesta.length() == 0) {
                out.println(obtener_beneficiario(con, dkda.o(vars, "codigo").toString()));
            }
            if (respuesta.length() > 0) {
                out.println(respuesta);
            }
        } finally {
            out.close();
        }
    }

    public String registrar_inscripcion(ConexionBaseDatos con) {
        System.out.println("registrar_inscripcion");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO inscripcion (codunifami,codtipoidentidad,codempresa,tiidenjefhog,idenjefhog,numerdecla,fechadilig,fechainscr,coddepartamento,codmunicipio,codsubgrupo,codbarrio,codregimenes,codentidadsalud,numcuebanc,codbanco,codtipoidenfunapr,numidentfunc,numeromesa,coditipben,meno7anyos,meno7a18anyos,residmunic,comproblig,fechaaprobac,codtipoidenfundil,numidentfuncdil,codtipoidentidadapr,codempresaapr,numeraprob,codiestfam,observacion,ususiscodigo,fecharegistro,arcdocapro,arcdocapro_nombre,archcomins,archcomins_nombre) VALUES "
                    + "(" + (dkda.o(vars, "codunifami_inscripcion").equals("") ? null : "'" + dkda.o(vars, "codunifami_inscripcion") + "'") + ","
                    + (dkda.o(empresa_inscripcion_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_inscripcion_1, "codtipoidentidad") + "'") + "," + (dkda.o(empresa_inscripcion_1, "codempresa").equals("") ? null : "'" + dkda.o(empresa_inscripcion_1, "codempresa") + "'") + "," + (dkda.o(vars, "tiidenjefhog_inscripcion").equals("") ? null : "'" + dkda.o(vars, "tiidenjefhog_inscripcion") + "'") + "," + (dkda.o(vars, "idenjefhog_inscripcion").equals("") ? null : "'" + dkda.o(vars, "idenjefhog_inscripcion") + "'") + "," + (dkda.o(vars, "numerdecla_inscripcion").equals("") ? null : "'" + dkda.o(vars, "numerdecla_inscripcion") + "'") + "," + (dkda.o(vars, "fechadilig_inscripcion").equals("") ? null : "'" + dkda.o(vars, "fechadilig_inscripcion") + "'") + "," + (dkda.o(vars, "fechainscr_inscripcion").equals("") ? null : "'" + dkda.o(vars, "fechainscr_inscripcion") + "'") + "," + (dkda.o(barrio_inscripcion_1, "coddepartamento").equals("") ? null : dkda.o(barrio_inscripcion_1, "coddepartamento")) + "," + (dkda.o(barrio_inscripcion_1, "codmunicipio").equals("") ? null : dkda.o(barrio_inscripcion_1, "codmunicipio")) + "," + (dkda.o(barrio_inscripcion_1, "codsubgrupo").equals("") ? null : dkda.o(barrio_inscripcion_1, "codsubgrupo")) + "," + (dkda.o(barrio_inscripcion_1, "codbarrio").equals("") ? null : dkda.o(barrio_inscripcion_1, "codbarrio")) + "," + (dkda.o(entidadsalud_inscripcion_1, "codregimenes").equals("") ? null : "'" + dkda.o(entidadsalud_inscripcion_1, "codregimenes") + "'") + "," + (dkda.o(entidadsalud_inscripcion_1, "codentidadsalud").equals("") ? null : "'" + dkda.o(entidadsalud_inscripcion_1, "codentidadsalud") + "'") + "," + (dkda.o(vars, "numcuebanc_inscripcion").equals("") ? null : "'" + dkda.o(vars, "numcuebanc_inscripcion") + "'") + "," + (dkda.o(vars, "codbanco_inscripcion").equals("") ? null : "'" + dkda.o(vars, "codbanco_inscripcion") + "'") + "," + (dkda.o(funcionario_inscripcion_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(funcionario_inscripcion_1, "codtipoidentidad") + "'") + "," + (dkda.o(funcionario_inscripcion_1, "numidentfunc").equals("") ? null : "'" + dkda.o(funcionario_inscripcion_1, "numidentfunc") + "'") + "," + (dkda.o(vars, "numeromesa_inscripcion").equals("") ? null : "'" + dkda.o(vars, "numeromesa_inscripcion") + "'") + "," + (dkda.o(vars, "coditipben_inscripcion").equals("") ? null : "'" + dkda.o(vars, "coditipben_inscripcion") + "'") + "," + (dkda.o(vars, "meno7anyos_inscripcion").equals("") ? null : dkda.o(vars, "meno7anyos_inscripcion")) + "," + (dkda.o(vars, "meno7a18anyos_inscripcion").equals("") ? null : "'" + dkda.o(vars, "meno7a18anyos_inscripcion") + "'") + "," + (dkda.o(vars, "residmunic_inscripcion").equals("") ? null : "'" + dkda.o(vars, "residmunic_inscripcion") + "'") + "," + (dkda.o(vars, "comproblig_inscripcion").equals("") ? null : "'" + dkda.o(vars, "comproblig_inscripcion") + "'") + "," + (dkda.o(vars, "fechaaprobac_inscripcion").equals("") ? null : "'" + dkda.o(vars, "fechaaprobac_inscripcion") + "'") + "," + (dkda.o(funcionario_inscripcion_2, "codtipoidentidad").equals("") ? null : "'" + dkda.o(funcionario_inscripcion_2, "codtipoidentidad") + "'") + "," + (dkda.o(funcionario_inscripcion_2, "numidentfunc").equals("") ? null : "'" + dkda.o(funcionario_inscripcion_2, "numidentfunc") + "'") + "," + (dkda.o(empresa_inscripcion_2, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_inscripcion_2, "codtipoidentidad") + "'") + "," + (dkda.o(empresa_inscripcion_2, "codempresa").equals("") ? null : "'" + dkda.o(empresa_inscripcion_2, "codempresa") + "'") + "," + (dkda.o(vars, "numeraprob_inscripcion").equals("") ? null : "'" + dkda.o(vars, "numeraprob_inscripcion") + "'") + "," + (dkda.o(vars, "codiestfam_inscripcion").equals("") ? null : "'" + dkda.o(vars, "codiestfam_inscripcion") + "'") + "," + (dkda.o(vars, "observacion_inscripcion").equals("") ? null : "'" + dkda.o(vars, "observacion_inscripcion") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "arcdocapro_inscripcion").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "arcdocapro_inscripcion") + "')") + "," + (dkda.o(vars, "arcdocapro_inscripcion").equals("") ? null : "'" + dkda.o(vars, "arcdocapro_inscripcion") + "'") + "," + (dkda.o(vars, "archcomins_inscripcion").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archcomins_inscripcion") + "')") + "," + (dkda.o(vars, "archcomins_inscripcion").equals("") ? null : "'" + dkda.o(vars, "archcomins_inscripcion") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_inscripcion&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_inscripcion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error inscripcion.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_inscripcion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE inscripcion SET codunifami = " + (dkda.o(vars, "codunifami_inscripcion").equals("") ? null : "'" + dkda.o(vars, "codunifami_inscripcion") + "'") + ","
                    + "codtipoidentidad = " + (dkda.o(empresa_inscripcion_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_inscripcion_1, "codtipoidentidad") + "'") + ","
                    + "codempresa = " + (dkda.o(empresa_inscripcion_1, "codempresa").equals("") ? null : "'" + dkda.o(empresa_inscripcion_1, "codempresa") + "'") + ",tiidenjefhog = " + (dkda.o(vars, "tiidenjefhog_inscripcion").equals("") ? null : "'" + dkda.o(vars, "tiidenjefhog_inscripcion") + "'") + ",idenjefhog = " + (dkda.o(vars, "idenjefhog_inscripcion").equals("") ? null : "'" + dkda.o(vars, "idenjefhog_inscripcion") + "'") + ",numerdecla = " + (dkda.o(vars, "numerdecla_inscripcion").equals("") ? null : "'" + dkda.o(vars, "numerdecla_inscripcion") + "'") + ",fechadilig = " + (dkda.o(vars, "fechadilig_inscripcion").equals("") ? null : "'" + dkda.o(vars, "fechadilig_inscripcion") + "'") + ",fechainscr = " + (dkda.o(vars, "fechainscr_inscripcion").equals("") ? null : "'" + dkda.o(vars, "fechainscr_inscripcion") + "'") + ",coddepartamento = " + (dkda.o(barrio_inscripcion_1, "coddepartamento").equals("") ? null : dkda.o(barrio_inscripcion_1, "coddepartamento")) + ",codmunicipio = " + (dkda.o(barrio_inscripcion_1, "codmunicipio").equals("") ? null : dkda.o(barrio_inscripcion_1, "codmunicipio")) + ",codsubgrupo = " + (dkda.o(barrio_inscripcion_1, "codsubgrupo").equals("") ? null : dkda.o(barrio_inscripcion_1, "codsubgrupo")) + ",codbarrio = " + (dkda.o(barrio_inscripcion_1, "codbarrio").equals("") ? null : dkda.o(barrio_inscripcion_1, "codbarrio")) + ",codregimenes = " + (dkda.o(entidadsalud_inscripcion_1, "codregimenes").equals("") ? null : "'" + dkda.o(entidadsalud_inscripcion_1, "codregimenes") + "'") + ",codentidadsalud = " + (dkda.o(entidadsalud_inscripcion_1, "codentidadsalud").equals("") ? null : "'" + dkda.o(entidadsalud_inscripcion_1, "codentidadsalud") + "'") + ",numcuebanc = " + (dkda.o(vars, "numcuebanc_inscripcion").equals("") ? null : "'" + dkda.o(vars, "numcuebanc_inscripcion") + "'") + ",codbanco = " + (dkda.o(vars, "codbanco_inscripcion").equals("") ? null : "'" + dkda.o(vars, "codbanco_inscripcion") + "'") + ",codtipoidenfunapr = " + (dkda.o(funcionario_inscripcion_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(funcionario_inscripcion_1, "codtipoidentidad") + "'") + ",numidentfunc = " + (dkda.o(funcionario_inscripcion_1, "numidentfunc").equals("") ? null : "'" + dkda.o(funcionario_inscripcion_1, "numidentfunc") + "'") + ",numeromesa = " + (dkda.o(vars, "numeromesa_inscripcion").equals("") ? null : "'" + dkda.o(vars, "numeromesa_inscripcion") + "'") + ",coditipben = " + (dkda.o(vars, "coditipben_inscripcion").equals("") ? null : "'" + dkda.o(vars, "coditipben_inscripcion") + "'") + ",meno7anyos = " + (dkda.o(vars, "meno7anyos_inscripcion").equals("") ? null : dkda.o(vars, "meno7anyos_inscripcion")) + ",meno7a18anyos = " + (dkda.o(vars, "meno7a18anyos_inscripcion").equals("") ? null : "'" + dkda.o(vars, "meno7a18anyos_inscripcion") + "'") + ",residmunic = " + (dkda.o(vars, "residmunic_inscripcion").equals("") ? null : "'" + dkda.o(vars, "residmunic_inscripcion") + "'") + ",comproblig = " + (dkda.o(vars, "comproblig_inscripcion").equals("") ? null : "'" + dkda.o(vars, "comproblig_inscripcion") + "'") + ",fechaaprobac = " + (dkda.o(vars, "fechaaprobac_inscripcion").equals("") ? null : "'" + dkda.o(vars, "fechaaprobac_inscripcion") + "'") + ",codtipoidenfundil = " + (dkda.o(funcionario_inscripcion_2, "codtipoidentidad").equals("") ? null : "'" + dkda.o(funcionario_inscripcion_2, "codtipoidentidad") + "'") + ",numidentfuncdil = " + (dkda.o(funcionario_inscripcion_2, "numidentfunc").equals("") ? null : "'" + dkda.o(funcionario_inscripcion_2, "numidentfunc") + "'") + ",codtipoidentidadapr = " + (dkda.o(empresa_inscripcion_2, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_inscripcion_2, "codtipoidentidad") + "'") + ",codempresaapr = " + (dkda.o(empresa_inscripcion_2, "codempresa").equals("") ? null : "'" + dkda.o(empresa_inscripcion_2, "codempresa") + "'") + ",numeraprob = " + (dkda.o(vars, "numeraprob_inscripcion").equals("") ? null : "'" + dkda.o(vars, "numeraprob_inscripcion") + "'") + ",codiestfam = " + (dkda.o(vars, "codiestfam_inscripcion").equals("") ? null : "'" + dkda.o(vars, "codiestfam_inscripcion") + "'") + ",observacion = " + (dkda.o(vars, "observacion_inscripcion").equals("") ? null : "'" + dkda.o(vars, "observacion_inscripcion") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",arcdocapro = " + (dkda.o(vars, "arcdocapro_inscripcion").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "arcdocapro_inscripcion") + "')") + ",arcdocapro_nombre = " + (dkda.o(vars, "arcdocapro_inscripcion").equals("") ? null : "'" + dkda.o(vars, "arcdocapro_inscripcion") + "'") + ",archcomins = " + (dkda.o(vars, "archcomins_inscripcion").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archcomins_inscripcion") + "')") + ",archcomins_nombre = " + (dkda.o(vars, "archcomins_inscripcion").equals("") ? null : "'" + dkda.o(vars, "archcomins_inscripcion") + "'") + " WHERE codunifami = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_inscripcion&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_inscripcion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error inscripcion.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_inscripcion(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM inscripcion WHERE codunifami = '" + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_inscripcion&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_inscripcion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error inscripcion.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_inscripcion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "inscripcion.codunifami AS inscripcion_codunifami,"
                    + "inscripcion.codtipoidentidad AS inscripcion_codtipoidentidad,"
                    + "inscripcion.codempresa AS inscripcion_codempresa,"
                    + "inscripcion.tiidenjefhog AS inscripcion_tiidenjefhog,"
                    + "inscripcion.idenjefhog AS inscripcion_idenjefhog,"
                    + "inscripcion.numerdecla AS inscripcion_numerdecla,"
                    + "inscripcion.fechadilig AS inscripcion_fechadilig,"
                    + "inscripcion.fechainscr AS inscripcion_fechainscr,"
                    + "inscripcion.coddepartamento AS inscripcion_coddepartamento,"
                    + "inscripcion.codmunicipio AS inscripcion_codmunicipio,"
                    + "inscripcion.codsubgrupo AS inscripcion_codsubgrupo,"
                    + "inscripcion.codbarrio AS inscripcion_codbarrio,"
                    + "inscripcion.codregimenes AS inscripcion_codregimenes,"
                    + "inscripcion.codentidadsalud AS inscripcion_codentidadsalud,"
                    + "inscripcion.numcuebanc AS inscripcion_numcuebanc,"
                    + "inscripcion.codbanco AS inscripcion_codbanco,"
                    + "inscripcion.codtipoidenfunapr AS inscripcion_codtipoidenfunapr,"
                    + "inscripcion.numidentfunc AS inscripcion_numidentfunc,"
                    + "inscripcion.numeromesa AS inscripcion_numeromesa,"
                    + "inscripcion.coditipben AS inscripcion_coditipben,"
                    + "inscripcion.meno7anyos AS inscripcion_meno7anyos,"
                    + "inscripcion.meno7a18anyos AS inscripcion_meno7a18anyos,"
                    + "inscripcion.residmunic AS inscripcion_residmunic,"
                    + "inscripcion.comproblig AS inscripcion_comproblig,"
                    + "inscripcion.fechaaprobac AS inscripcion_fechaaprobac,"
                    + "inscripcion.codtipoidenfundil AS inscripcion_codtipoidenfundil,"
                    + "inscripcion.numidentfuncdil AS inscripcion_numidentfuncdil,"
                    + "inscripcion.codtipoidentidadapr AS inscripcion_codtipoidentidadapr,"
                    + "inscripcion.codempresaapr AS inscripcion_codempresaapr,"
                    + "inscripcion.numeraprob AS inscripcion_numeraprob,"
                    + "inscripcion.codiestfam AS inscripcion_codiestfam,"
                    + "inscripcion.observacion AS inscripcion_observacion,"
                    + "CASE WHEN inscripcion.arcdocapro_nombre  IS NULL OR inscripcion.arcdocapro_nombre  = '' THEN 0 "
                    + "ELSE lo_export(inscripcion.arcdocapro, '" + fun.temp(request) + "' || inscripcion.arcdocapro_nombre ) END, "
                    + "inscripcion.arcdocapro_nombre AS inscripcion_arcdocapro_nombre,"
                    + "CASE WHEN inscripcion.archcomins_nombre  IS NULL OR inscripcion.archcomins_nombre  = '' THEN 0 "
                    + "ELSE lo_export(inscripcion.archcomins, '" + fun.temp(request) + "' || inscripcion.archcomins_nombre ) END, "
                    + "inscripcion.archcomins_nombre AS inscripcion_archcomins_nombre,"
                    + "banco.codbanco AS banco_codbanco,"
                    + "banco.descripcion AS banco_descripcion,"
                    + "barrio.coddepartamento AS barrio_coddepartamento,"
                    + "barrio.codmunicipio AS barrio_codmunicipio,"
                    + "barrio.codsubgrupo AS barrio_codsubgrupo,"
                    + "barrio.codbarrio AS barrio_codbarrio,"
                    + "barrio.nombre AS barrio_nombre,"
                    + "estadofamilia.codiestfam AS estadofamilia_codiestfam,"
                    + "estadofamilia.descestfam AS estadofamilia_descestfam,"
                    + "entidadsalud.codregimenes AS entidadsalud_codregimenes,"
                    + "entidadsalud.codentidadsalud AS entidadsalud_codentidadsalud,"
                    + "entidadsalud.nombrehabilitacion AS entidadsalud_nombrehabilitacion,"
                    + "tipobeneficiario.coditipben AS tipobeneficiario_coditipben,"
                    + "tipobeneficiario.desctipben AS tipobeneficiario_desctipben,"
                    + "funcionario_1.codtipoidentidad AS funcionario_codtipoidentidad_1,"
                    + "funcionario_1.numidentfunc AS funcionario_numidentfunc_1,"
                    + "funcionario_1.nombre AS funcionario_nombre_1,"
                    + "funcionario_2.codtipoidentidad AS funcionario_codtipoidentidad_2,"
                    + "funcionario_2.numidentfunc AS funcionario_numidentfunc_2,"
                    + "funcionario_2.nombre AS funcionario_nombre_2,"
                    + "empresa_1.codtipoidentidad AS empresa_codtipoidentidad_1,"
                    + "empresa_1.codempresa AS empresa_codempresa_1,"
                    + "empresa_1.nombre AS empresa_nombre_1,"
                    + "empresa_2.codtipoidentidad AS empresa_codtipoidentidad_2,"
                    + "empresa_2.codempresa AS empresa_codempresa_2,"
                    + "empresa_2.nombre AS empresa_nombre_2, "
                    + " tipoidentificacion.codtipoidentidad AS tipoidentificacion_codtipoidentidad, "
                    + "tipoidentificacion.descripcion AS tipoidentificacion_descripcion FROM "
                    + " public.banco banco INNER JOIN public.inscripcion inscripcion ON banco.codbanco = inscripcion.codbanco "
                    + " INNER JOIN public.barrio barrio ON inscripcion.coddepartamento = barrio.coddepartamento "
                    + " AND barrio.codbarrio = inscripcion.codbarrio "
                    + " AND barrio.codmunicipio = inscripcion.codmunicipio "
                    + " AND barrio.codsubgrupo = inscripcion.codsubgrupo "
                    + " INNER JOIN public.entidadsalud entidadsalud ON inscripcion.codregimenes = entidadsalud.codregimenes "
                    + "AND entidadsalud.codentidadsalud = inscripcion.codentidadsalud "
                    + "INNER JOIN public.estadofamilia estadofamilia ON inscripcion.codiestfam = estadofamilia.codiestfam "
                    + "INNER JOIN public.tipobeneficiario tipobeneficiario ON inscripcion.coditipben = tipobeneficiario.coditipben "
                    + "INNER JOIN public.funcionario funcionario_2 ON inscripcion.codtipoidenfundil = funcionario_2.codtipoidentidad "
                    + "AND funcionario_2.numidentfunc = inscripcion.numidentfuncdil "
                    + "INNER JOIN public.funcionario funcionario_1 ON inscripcion.codtipoidenfunapr = funcionario_1.codtipoidentidad "
                    + "AND funcionario_1.numidentfunc = inscripcion.numidentfunc "
                    + "INNER JOIN public.empresa empresa_2 ON inscripcion.codtipoidentidadapr = empresa_2.codtipoidentidad "
                    + "AND empresa_2.codempresa = inscripcion.codempresaapr "
                    + "INNER JOIN public.empresa empresa_1 ON inscripcion.codtipoidentidad = empresa_1.codtipoidentidad "
                    + "AND empresa_1.codempresa = inscripcion.codempresa "
                    + "INNER JOIN public.tipoidentificacion tipoidentificacion ON inscripcion.tiidenjefhog = tipoidentificacion.codtipoidentidad"
                    + " WHERE codunifami = '" + dkda.o(vars, "codigo") + "'";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            System.out.println(sql);

            info += "text|#observacion_inscripcion|" + (rs.getString("inscripcion_observacion") == null ? "" : rs.getString("inscripcion_observacion")) + ":_";

            info += "text|#archcomins_inscripcion|" + (rs.getString("inscripcion_archcomins_nombre") == null ? "" : rs.getString("inscripcion_archcomins_nombre")) + ":_";

            info += "combo|#codiestfam_inscripcion|" + rs.getString("estadofamilia_codiestfam") + "|llenarCombo('codiestfam_inscripcion', '"
                    + rs.getString("estadofamilia_codiestfam") + "', '" + rs.getString("estadofamilia_descestfam") + "'):_";

            info += "text|#numeraprob_inscripcion|" + (rs.getString("inscripcion_numeraprob") == null ? "" : rs.getString("inscripcion_numeraprob")) + ":_";

            info += "text|#arcdocapro_inscripcion|" + (rs.getString("inscripcion_arcdocapro_nombre") == null ? "" : rs.getString("inscripcion_arcdocapro_nombre")) + ":_";

            info += "combo|#funcionario_inscripcion_2|" + "funcionario   codtipoidentidad  " + rs.getString("funcionario_codtipoidentidad_2") + "   numidentfunc  " + rs.getString("funcionario_numidentfunc_2") + "|llenarCombo('funcionario_inscripcion_2', '"
                    + "funcionario   codtipoidentidad  " + rs.getString("funcionario_codtipoidentidad_2") + "   numidentfunc  " + rs.getString("funcionario_numidentfunc_2") + "', '" + rs.getString("funcionario_nombre_2") + "'):_";

            info += "combo|#empresa_inscripcion_2|" + "empresa   codtipoidentidad  " + rs.getString("empresa_codtipoidentidad_2") + "   codempresa  " + rs.getString("empresa_codempresa_2") + "|llenarCombo('empresa_inscripcion_2', '"
                    + "empresa   codtipoidentidad  " + rs.getString("empresa_codtipoidentidad_2") + "   codempresa  " + rs.getString("empresa_codempresa_2") + "', '" + rs.getString("empresa_nombre_2") + "'):_";

            info += "text|#_fechahora_fechaaprobac_inscripcion|" + (rs.getString("inscripcion_fechaaprobac") == null ? "" : rs.getString("inscripcion_fechaaprobac")) + ":_";

            info += "switch|switch_comproblig_inscripcion|" + rs.getString("inscripcion_comproblig") + ":_";

            info += "switch|switch_residmunic_inscripcion|" + rs.getString("inscripcion_residmunic") + ":_";

            info += "text|#meno7a18anyos_inscripcion|" + (rs.getString("inscripcion_meno7a18anyos") == null ? "" : rs.getString("inscripcion_meno7a18anyos")) + ":_";

            info += "text|#meno7anyos_inscripcion|" + (rs.getString("inscripcion_meno7anyos") == null ? "" : rs.getString("inscripcion_meno7anyos")) + ":_";

            info += "combo|#coditipben_inscripcion|" + rs.getString("tipobeneficiario_coditipben") + "|llenarCombo('coditipben_inscripcion', '"
                    + rs.getString("tipobeneficiario_coditipben") + "', '" + rs.getString("tipobeneficiario_desctipben") + "'):_";

            info += "text|#numeromesa_inscripcion|" + (rs.getString("inscripcion_numeromesa") == null ? "" : rs.getString("inscripcion_numeromesa")) + ":_";

            info += "combo|#funcionario_inscripcion_1|" + "funcionario   codtipoidentidad  " + rs.getString("funcionario_codtipoidentidad_1") + "   numidentfunc  " + rs.getString("funcionario_numidentfunc_1") + "|llenarCombo('funcionario_inscripcion_1', '"
                    + "funcionario   codtipoidentidad  " + rs.getString("funcionario_codtipoidentidad_1") + "   numidentfunc  " + rs.getString("funcionario_numidentfunc_1") + "', '" + rs.getString("funcionario_nombre_1") + "'):_";

            info += "combo|#codbanco_inscripcion|" + rs.getString("banco_codbanco") + "|llenarCombo('codbanco_inscripcion', '"
                    + rs.getString("banco_codbanco") + "', '" + rs.getString("banco_descripcion") + "'):_";

            info += "text|#numcuebanc_inscripcion|" + (rs.getString("inscripcion_numcuebanc") == null ? "" : rs.getString("inscripcion_numcuebanc")) + ":_";


            info += "combo|#entidadsalud_inscripcion_1|" + "entidadsalud   codregimenes  " + rs.getString("entidadsalud_codregimenes") + "   codentidadsalud  " + rs.getString("entidadsalud_codentidadsalud") + "|llenarCombo('entidadsalud_inscripcion_1', '"
                    + "entidadsalud   codregimenes  " + rs.getString("entidadsalud_codregimenes") + "   codentidadsalud  " + rs.getString("entidadsalud_codentidadsalud") + "', '" + rs.getString("entidadsalud_nombrehabilitacion") + "'):_";

            info += "combo|#barrio_inscripcion_1|" + "barrio   coddepartamento  " + rs.getString("barrio_coddepartamento") + "   codmunicipio  " + rs.getString("barrio_codmunicipio")
                    + "   codsubgrupo  " + rs.getString("barrio_codsubgrupo") + "   codbarrio  " + rs.getString("barrio_codbarrio") + "|llenarCombo('barrio_inscripcion_1', '"
                    + "barrio   coddepartamento  " + rs.getString("barrio_coddepartamento") + "   codmunicipio  " + rs.getString("barrio_codmunicipio")
                    + "   codsubgrupo  " + rs.getString("barrio_codsubgrupo") + "   codbarrio  " + rs.getString("barrio_codbarrio") + "', '" + rs.getString("barrio_nombre") + "'):_";


            info += "text|#_fechahora_fechainscr_inscripcion|" + (rs.getString("inscripcion_fechainscr") == null ? "" : rs.getString("inscripcion_fechainscr")) + ":_";

            info += "text|#_fechahora_fechadilig_inscripcion|" + (rs.getString("inscripcion_fechadilig") == null ? "" : rs.getString("inscripcion_fechadilig")) + ":_";

            info += "text|#numerdecla_inscripcion|" + (rs.getString("inscripcion_numerdecla") == null ? "" : rs.getString("inscripcion_numerdecla")) + ":_";

            info += "text|#codunifami_inscripcion|" + (rs.getString("inscripcion_codunifami") == null ? "" : rs.getString("inscripcion_codunifami")) + ":_";

            info += "combo|#empresa_inscripcion_1|" + "empresa   codtipoidentidad  " + rs.getString("empresa_codtipoidentidad_1") + "   codempresa  " + rs.getString("empresa_codempresa_1") + "|llenarCombo('empresa_inscripcion_1', '"
                    + "empresa   codtipoidentidad  " + rs.getString("empresa_codtipoidentidad_1") + "   codempresa  " + rs.getString("empresa_codempresa_1") + "', '" + rs.getString("empresa_nombre_1") + "'):_";

            info += "combo|#tiidenjefhog_inscripcion|" + rs.getString("tipoidentificacion_codtipoidentidad") + "|llenarCombo('tiidenjefhog_inscripcion', '"
                    + rs.getString("tipoidentificacion_codtipoidentidad") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";

            info += "text|#idenjefhog_inscripcion|" + (rs.getString("inscripcion_idenjefhog") == null ? "" : rs.getString("inscripcion_idenjefhog")) + ":_";




            respuesta = "opcion=obtener_inscripcion&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_inscripcion&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error inscripcion - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_inscripcion() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM inscripcion  WHERE codunifami = '" + dkda.o(vars, "codunifami_inscripcion") + "'";
            pQuery = conexion.prepareStatement(sql);
            System.out.println("Inscripcion : " + sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_inscripcion() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_inscripcion() {
        String direccion = "opcion=registrar_inscripcion&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_inscripcion();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "codunifami_inscripcion"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
                System.out.println("Aqui");
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codunifami_inscripcion").isEmpty()) {
            error = "Código Único Familia: no puede ser vacio.";

        } else if (dkda.o(empresa_inscripcion_1, "codtipoidentidad").isEmpty()) {
            error = "Empresa Aprobadora: no puede ser vacio.";

        } else if (dkda.o(vars, "tiidenjefhog_inscripcion").isEmpty()) {
            error = "Tipo de Identificacion Jefe del Hogar: no puede ser vacio.";

        } else if (dkda.o(vars, "idenjefhog_inscripcion").isEmpty()) {
            error = "Identificación Jefe del Hogar: no puede ser vacio.";

        } else if (dkda.o(vars, "numerdecla_inscripcion").isEmpty()) {
            error = "Número Declaración: no puede ser vacio.";
        } else if (dkda.o(vars, "fechadilig_inscripcion").isEmpty()) {
            error = "Fecha y Hora Diligenciamiento Inscripción: no puede ser vacio.";
        } else if (dkda.o(vars, "fechainscr_inscripcion").isEmpty()) {
            error = "Fecha y Hora Inscripción: no puede ser vacio.";

        } else if (dkda.o(barrio_inscripcion_1, "coddepartamento").isEmpty()) {
            error = "Barrio - Residencia: no puede ser vacio.";

        } else if (dkda.o(entidadsalud_inscripcion_1, "codregimenes").isEmpty()) {
            error = "IPS Asignada: no puede ser vacio.";

        } else if (dkda.o(vars, "numcuebanc_inscripcion").isEmpty()) {
            error = "Número Cuenta Bancaria: no puede ser vacio.";
        } else if (dkda.o(vars, "codbanco_inscripcion").isEmpty()) {
            error = "Codigo Banco Cuenta: no puede ser vacio.";

        } else if (dkda.o(funcionario_inscripcion_1, "codtipoidentidad").isEmpty()) {
            error = "Tipo de Identificacion Funcionario que Aprueba: no puede ser vacio.";

        } else if (dkda.o(vars, "numeromesa_inscripcion").isEmpty()) {
            error = "Número de Mesa: no puede ser vacio.";
        } else if (dkda.o(vars, "coditipben_inscripcion").isEmpty()) {
            error = "Código Tipo de Beneficiario: no puede ser vacio.";
        } else if (dkda.o(vars, "meno7anyos_inscripcion").isEmpty()) {
            error = "Número de Menores de 7 A&ntilde;os: no puede ser vacio.";
        } else if (dkda.o(vars, "meno7a18anyos_inscripcion").isEmpty()) {
            error = "Número de Ni?os entre 7 y 18 A&ntilde;os: no puede ser vacio.";
        } else if (dkda.o(vars, "residmunic_inscripcion").isEmpty()) {
            error = "Reside en el Municipio (S/N): no puede ser vacio.";
        } else if (dkda.o(vars, "comproblig_inscripcion").isEmpty()) {
            error = "Se Compromete con las Obligaciones: no puede ser vacio.";
        } else if (dkda.o(vars, "fechaaprobac_inscripcion").isEmpty()) {
            error = "Fecha y Hora de Aprobación: no puede ser vacio.";

        } else if (dkda.o(empresa_inscripcion_2, "codtipoidentidad").isEmpty()) {
            error = "Tipo de identificacion Empresa que Aprueba: no puede ser vacio.";

        } else if (dkda.o(funcionario_inscripcion_2, "codtipoidentidad").isEmpty()) {
            error = "Tipo de Identificacion Funcionario que Diligencia Formato: no puede ser vacio.";

        } else if (dkda.o(vars, "arcdocapro_inscripcion").isEmpty()) {
            error = "Documento Afiliaci&oacute;n: no puede ser vacio.";

        } else if (dkda.o(vars, "numeraprob_inscripcion").isEmpty()) {  /*  ///// */
            error = "Número de Afiliaci&oacute;n: no puede ser vacio.";

        } else if (dkda.o(vars, "codiestfam_inscripcion").isEmpty()) {
            error = "Código Estado Familia: no puede ser vacio.";

        } else if (dkda.o(vars, "archcomins_inscripcion").isEmpty()) {
            error = "Comprobante Inscripci&oacute;n: no puede ser vacio.";

        } else if (dkda.o(vars, "observacion_inscripcion").isEmpty()) {
            error = "Observaciones Inscripción: no puede ser vacio.";

        } else if (!v.numeros(dkda.o(vars, "idenjefhog_inscripcion"))) {
            error = "Identificación Jefe del Hogar: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "numerdecla_inscripcion"))) {
            error = "Número Declaración: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "codunifami_inscripcion").length() > 15) {
            error = "Código Único Familia: Valor demasiado Largo.";
        } else if (dkda.o(vars, "idenjefhog_inscripcion").length() > 10) {
            error = "Identificación Jefe del Hogar: Valor demasiado Largo.";
        } else if (dkda.o(vars, "numerdecla_inscripcion").length() > 15) {
            error = "Número Declaración: Valor demasiado Largo.";
        } else if (dkda.o(vars, "meno7a18anyos_inscripcion").length() > 6) {
            error = "Número de Ni?os entre 7 y 18 A?os: Valor demasiado Largo.";
        } else if (dkda.o(vars, "residmunic_inscripcion").length() > 1) {
            error = "Reside en el Municipio (S/N): Valor demasiado Largo.";
        } else if (dkda.o(vars, "comproblig_inscripcion").length() > 1) {
            error = "Se Compromete con las Obligaciones: Valor demasiado Largo.";
        } else if (dkda.o(vars, "observacion_inscripcion").length() > 400) {
            error = "Observaciones Inscripción: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_documentoinscripcion(ConexionBaseDatos con) {
        System.out.println("registrar_documentoinscripcion");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO documentoinscripcion (codunifami,codtipodctoasociado,codtipoidentidad,idenperdoc,descripcion,archidocum,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "codunifami_documentoinscripcion").equals("") ? null : "'" + dkda.o(vars, "codunifami_documentoinscripcion") + "'") + "," + (dkda.o(vars, "codtipodctoasociado_documentoinscripcion").equals("") ? null : "'" + dkda.o(vars, "codtipodctoasociado_documentoinscripcion") + "'") + "," + (dkda.o(vars, "codtipoidentidad_documentoinscripcion").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_documentoinscripcion") + "'") + "," + (dkda.o(vars, "idenperdoc_documentoinscripcion").equals("") ? null : "'" + dkda.o(vars, "idenperdoc_documentoinscripcion") + "'") + "," + (dkda.o(vars, "descripcion_documentoinscripcion").equals("") ? null : "'" + dkda.o(vars, "descripcion_documentoinscripcion") + "'") + "," + (dkda.o(vars, "archidocum_documentoinscripcion").equals("") ? null : "'" + dkda.o(vars, "archidocum_documentoinscripcion") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_documentoinscripcion&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_documentoinscripcion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error documentoinscripcion.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_documentoinscripcion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE documentoinscripcion SET codunifami = " + (dkda.o(vars, "codunifami_documentoinscripcion").equals("") ? null : "'" + dkda.o(vars, "codunifami_documentoinscripcion") + "'") + ",codtipodctoasociado = " + (dkda.o(vars, "codtipodctoasociado_documentoinscripcion").equals("") ? null : "'" + dkda.o(vars, "codtipodctoasociado_documentoinscripcion") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_documentoinscripcion").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_documentoinscripcion") + "'") + ",idenperdoc = " + (dkda.o(vars, "idenperdoc_documentoinscripcion").equals("") ? null : "'" + dkda.o(vars, "idenperdoc_documentoinscripcion") + "'") + ",descripcion = " + (dkda.o(vars, "descripcion_documentoinscripcion").equals("") ? null : "'" + dkda.o(vars, "descripcion_documentoinscripcion") + "'") + ",archidocum = " + (dkda.o(vars, "archidocum_documentoinscripcion").equals("") ? null : "'" + dkda.o(vars, "archidocum_documentoinscripcion") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_documentoinscripcion&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_documentoinscripcion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error documentoinscripcion.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_documentoinscripcion(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM documentoinscripcion WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_documentoinscripcion&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_documentoinscripcion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error documentoinscripcion.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_documentoinscripcion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT documentoinscripcion.\"codunifami\"          AS "
                    + "       documentoinscripcion_codunifami, "
                    + "       documentoinscripcion.\"codtipodctoasociado\" AS "
                    + "       documentoinscripcion_codtipodctoasociado, "
                    + "       documentoinscripcion.\"codtipoidentidad\"    AS "
                    + "       documentoinscripcion_codtipoidentidad, "
                    + "       documentoinscripcion.\"idenperdoc\"          AS "
                    + "       documentoinscripcion_idenperdoc, "
                    + "       documentoinscripcion.\"descripcion\"         AS "
                    + "       documentoinscripcion_descripcion, "
                    + "       documentoinscripcion.\"archidocum\"          AS "
                    + "       documentoinscripcion_archidocum, "
                    + "       tipodctoasociado.\"codtipodctoasociado\"     AS "
                    + "       tipodctoasociado_codtipodctoasociado, "
                    + "       tipodctoasociado.\"descripcion\"             AS "
                    + "       tipodctoasociado_descripcion, "
                    + "       inscripcion.\"codunifami\"                   AS inscripcion_codunifami, "
                    + "       tipoidentificacion.\"codtipoidentidad\"      AS "
                    + "       tipoidentificacion_codtipoidentidad, "
                    + "       tipoidentificacion.\"descripcion\"           AS "
                    + "       tipoidentificacion_descripcion "
                    + "FROM   \"public\".\"inscripcion\" inscripcion "
                    + "       INNER JOIN \"public\".\"documentoinscripcion\" documentoinscripcion "
                    + "         ON inscripcion.\"codunifami\" = documentoinscripcion.\"codunifami\" "
                    + "       INNER JOIN \"public\".\"tipodctoasociado\" tipodctoasociado "
                    + "         ON documentoinscripcion.\"codtipodctoasociado\" = "
                    + "            tipodctoasociado.\"codtipodctoasociado\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON documentoinscripcion.\"codtipoidentidad\" = "
                    + "            tipoidentificacion.\"codtipoidentidad\" WHERE documentoinscripcion.codunifami = '" + dkda.o(sel, "codunifami") + "' AND documentoinscripcion.codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#descripcion_documentoinscripcion|" + (rs.getString("documentoinscripcion_descripcion") == null ? "" : rs.getString("documentoinscripcion_descripcion")) + ":_";

            info += "combo|#codtipoidentidad_documentoinscripcion|" + rs.getString("tipoidentificacion_codtipoidentidad") + "|llenarCombo('codtipoidentidad_documentoinscripcion', '"
                    + rs.getString("tipoidentificacion_codtipoidentidad") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";

            info += "combo|#codtipodctoasociado_documentoinscripcion|" + rs.getString("tipodctoasociado_codtipodctoasociado") + "|llenarCombo('codtipodctoasociado_documentoinscripcion', '"
                    + rs.getString("tipodctoasociado_codtipodctoasociado") + "', '" + rs.getString("tipodctoasociado_descripcion") + "'):_";

            info += "combo|#codunifami_documentoinscripcion|" + rs.getString("documentoinscripcion_codunifami") + "|llenarCombo('codunifami_documentoinscripcion', '"
                    + rs.getString("documentoinscripcion_codunifami") + "', '" + rs.getString("documentoinscripcion_codunifami") + "'):_";

            info += "text|#idenperdoc_documentoinscripcion|" + (rs.getString("documentoinscripcion_idenperdoc") == null ? "" : rs.getString("documentoinscripcion_idenperdoc")) + ":_";


            respuesta = "opcion=obtener_documentoinscripcion&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_documentoinscripcion&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error documentoinscripcion - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_documentoinscripcion() {
        String direccion = "opcion=registrar_documentoinscripcion&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_documentoinscripcion();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codunifami").toString().equals(dkda.o(vars, "codunifami_documentoinscripcion"))
                    && dkda.o(sel, "codtipodctoasociado").toString().equals(dkda.o(vars, "codtipodctoasociado_documentoinscripcion"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codunifami_documentoinscripcion").isEmpty()) {
            error = "C&oacute;digo &Uacute;nico Familia: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipodctoasociado_documentoinscripcion").isEmpty()) {
            error = "Codigo Tipo Documento Asociado: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_documentoinscripcion").isEmpty()) {
            error = "Tipo Identificación: no puede ser vacio.";
        } else if (dkda.o(vars, "idenperdoc_documentoinscripcion").isEmpty()) {
            error = "Identificaci&oacute;n Persona Documento: no puede ser vacio.";
        } else if (dkda.o(vars, "descripcion_documentoinscripcion").isEmpty()) {
            error = "Descripci&oacute;n Documento Inscripci&oacute;n: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "idenperdoc_documentoinscripcion"))) {
            error = "Identificaci&oacute;n Persona Documento: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "idenperdoc_documentoinscripcion").length() > 10) {
            error = "Identificaci&oacute;n Persona Documento: Valor demasiado Largo.";
        } else if (dkda.o(vars, "descripcion_documentoinscripcion").length() > 100) {
            error = "Descripci&oacute;n Documento Inscripci&oacute;n: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_grupotitular(ConexionBaseDatos con) {
        System.out.println("registrar_grupotitular");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO grupotitular (codclagrutit,codunifami,codtipoidentidad,identitfam,observacion,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "codclagrutit_grupotitular").equals("") ? null : "'" + dkda.o(vars, "codclagrutit_grupotitular") + "'") + "," + (dkda.o(titularfamilia_grupotitular_1, "codunifami").equals("") ? null : "'" + dkda.o(titularfamilia_grupotitular_1, "codunifami") + "'") + "," + (dkda.o(titularfamilia_grupotitular_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(titularfamilia_grupotitular_1, "codtipoidentidad") + "'") + "," + (dkda.o(titularfamilia_grupotitular_1, "identitfam").equals("") ? null : "'" + dkda.o(titularfamilia_grupotitular_1, "identitfam") + "'") + "," + (dkda.o(vars, "observacion_grupotitular").equals("") ? null : "'" + dkda.o(vars, "observacion_grupotitular") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_grupotitular&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_grupotitular&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error grupotitular.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_grupotitular(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE grupotitular SET codclagrutit = " + (dkda.o(vars, "codclagrutit_grupotitular").equals("") ? null : "'" + dkda.o(vars, "codclagrutit_grupotitular") + "'") + ",codunifami = " + (dkda.o(titularfamilia_grupotitular_1, "codunifami").equals("") ? null : "'" + dkda.o(titularfamilia_grupotitular_1, "codunifami") + "'") + ",codtipoidentidad = " + (dkda.o(titularfamilia_grupotitular_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(titularfamilia_grupotitular_1, "codtipoidentidad") + "'") + ",identitfam = " + (dkda.o(titularfamilia_grupotitular_1, "identitfam").equals("") ? null : "'" + dkda.o(titularfamilia_grupotitular_1, "identitfam") + "'") + ",observacion = " + (dkda.o(vars, "observacion_grupotitular").equals("") ? null : "'" + dkda.o(vars, "observacion_grupotitular") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codclagrutit = '" + dkda.o(sel, "codclagrutit") + "' AND codunifami = '" + dkda.o(sel, "codunifami") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND identitfam = '" + dkda.o(sel, "identitfam") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_grupotitular&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_grupotitular&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error grupotitular.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_grupotitular(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM grupotitular WHERE codclagrutit = '" + dkda.o(sel, "codclagrutit") + "' AND codunifami = '" + dkda.o(sel, "codunifami") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND identitfam = '" + dkda.o(sel, "identitfam") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_grupotitular&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_grupotitular&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error grupotitular.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_grupotitular(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT grupotitular.\"codclagrutit\"       AS grupotitular_codclagrutit, "
                    + "       grupotitular.\"codunifami\"         AS grupotitular_codunifami, "
                    + "       grupotitular.\"codtipoidentidad\"   AS grupotitular_codtipoidentidad, "
                    + "       grupotitular.\"identitfam\"         AS grupotitular_identitfam, "
                    + "       grupotitular.\"observacion\"        AS grupotitular_observacion, "
                    + "       clasegrupotitular.\"codclagrutit\"  AS clasegrupotitular_codclagrutit, "
                    + "       clasegrupotitular.\"descclagrutit\" AS clasegrupotitular_descclagrutit, "
                    + "       titularfamilia.\"codunifami\"       AS titularfamilia_codunifami, "
                    + "       titularfamilia.\"codtipoidentidad\" AS titularfamilia_codtipoidentidad, "
                    + "       titularfamilia.\"identitfam\"       AS titularfamilia_identitfam, "
                    + "       titularfamilia.\"coditiptit\"       AS titularfamilia_coditiptit "
                    + "FROM   \"public\".\"clasegrupotitular\" clasegrupotitular "
                    + "       INNER JOIN \"public\".\"grupotitular\" grupotitular "
                    + "         ON clasegrupotitular.\"codclagrutit\" = grupotitular.\"codclagrutit\" "
                    + "       INNER JOIN \"public\".\"titularfamilia\" titularfamilia "
                    + "         ON grupotitular.\"codunifami\" = titularfamilia.\"codunifami\" "
                    + "            AND titularfamilia.\"identitfam\" = grupotitular.\"identitfam\" "
                    + "            AND titularfamilia.\"codtipoidentidad\" = "
                    + "                grupotitular.\"codtipoidentidad\" "
                    + "WHERE grupotitular.codclagrutit = '" + dkda.o(sel, "codclagrutit") + "' AND grupotitular.codunifami = '" + dkda.o(sel, "codunifami") + "' AND grupotitular.codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND grupotitular.identitfam = '" + dkda.o(sel, "identitfam") + "' ";


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            System.out.println(sql);

            info += "combo|#titularfamilia_grupotitular_1|" + "titularfamilia   codunifami  " + rs.getString("grupotitular_codunifami") + "   codtipoidentidad  " + rs.getString("grupotitular_codtipoidentidad")
                    + "   identitfam  " + rs.getString("grupotitular_identitfam") + "|llenarCombo('titularfamilia_grupotitular_1', '"
                    + "titularfamilia   codunifami  " + rs.getString("grupotitular_codunifami") + "   codtipoidentidad  " + rs.getString("grupotitular_codtipoidentidad")
                    + "   identitfam  " + rs.getString("grupotitular_identitfam") + "', '" + rs.getString("grupotitular_identitfam") + "'):_";

            info += "combo|#codclagrutit_grupotitular|" + rs.getString("clasegrupotitular_codclagrutit") + "|llenarCombo('codclagrutit_grupotitular', '"
                    + rs.getString("clasegrupotitular_codclagrutit") + "', '" + rs.getString("clasegrupotitular_descclagrutit") + "'):_";

            info += "text|#observacion_grupotitular|" + (rs.getString("grupotitular_observacion") == null ? "" : rs.getString("grupotitular_observacion")) + ":_";

            respuesta = "opcion=obtener_grupotitular&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_grupotitular&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error grupotitular - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_grupotitular() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM grupotitular  WHERE codclagrutit = '" + dkda.o(vars, "codclagrutit_grupotitular") + "'"
                    + " AND codunifami = '" + dkda.o(titularfamilia_grupotitular_1, "codunifami") + "'" + " AND codtipoidentidad = '" + dkda.o(titularfamilia_grupotitular_1, "codtipoidentidad")
                    + "'" + " AND identitfam = '" + dkda.o(titularfamilia_grupotitular_1, "identitfam") + "'";
            pQuery = conexion.prepareStatement(sql);

            System.out.println(sql);

            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_grupotitular() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_grupotitular() {
        String direccion = "opcion=registrar_grupotitular&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_grupotitular();

        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {


            if (!(dkda.o(sel, "codclagrutit").toString().equals(dkda.o(vars, "codclagrutit_grupotitular"))
                    && dkda.o(sel, "codunifami").toString().equals(dkda.o(titularfamilia_grupotitular_1, "codunifami"))
                    && dkda.o(sel, "codtipoidentidad").toString().equals(dkda.o(titularfamilia_grupotitular_1, "codtipoidentidad"))
                    && dkda.o(sel, "identitfam").toString().equals(dkda.o(titularfamilia_grupotitular_1, "identitfam"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            System.out.println("Existe : " + existe);
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codclagrutit_grupotitular").isEmpty()) {
            error = "Código Clase Grupo Titular: no puede ser vacio.";
        } else if (dkda.o(titularfamilia_grupotitular_1, "identitfam").isEmpty()) {
            error = "Titular Familia: no puede ser vacio.";
        } else if (dkda.o(vars, "observacion_grupotitular").isEmpty()) {
            error = "Observaciones: no puede ser vacio.";
        } else if (dkda.o(vars, "observacion_grupotitular").length() > 400) {
            error = "Observaciones: Valor demasiado Largo.";
        }



        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_titularfamilia(ConexionBaseDatos con) {
        System.out.println("registrar_titularfamilia");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO titularfamilia (codunifami,codtipoidentidad,identitfam,coditiptit,fechinitit,vivehijos,numecueban,codbanco,codiesttit,observacion,ususiscodigo,fecharegistro,firmatitul,firmatitul_nombre) VALUES (" + (dkda.o(vars, "codunifami_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "codunifami_titularfamilia") + "'") + "," + (dkda.o(vars, "codtipoidentidad_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_titularfamilia") + "'") + "," + (dkda.o(vars, "identitfam_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "identitfam_titularfamilia") + "'") + "," + (dkda.o(vars, "coditiptit_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "coditiptit_titularfamilia") + "'") + "," + (dkda.o(vars, "fechinitit_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "fechinitit_titularfamilia") + "'") + "," + (dkda.o(vars, "vivehijos_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "vivehijos_titularfamilia") + "'") + "," + (dkda.o(vars, "numecueban_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "numecueban_titularfamilia") + "'") + "," + (dkda.o(vars, "codbanco_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "codbanco_titularfamilia") + "'") + "," + (dkda.o(vars, "codiesttit_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "codiesttit_titularfamilia") + "'") + "," + (dkda.o(vars, "observacion_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "observacion_titularfamilia") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "firmatitul_titularfamilia").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "firmatitul_titularfamilia") + "')") + "," + (dkda.o(vars, "firmatitul_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "firmatitul_titularfamilia") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_titularfamilia&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_titularfamilia&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error titularfamilia.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_titularfamilia(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE titularfamilia SET codunifami = " + (dkda.o(vars, "codunifami_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "codunifami_titularfamilia") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_titularfamilia") + "'") + ",identitfam = " + (dkda.o(vars, "identitfam_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "identitfam_titularfamilia") + "'") + ",coditiptit = " + (dkda.o(vars, "coditiptit_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "coditiptit_titularfamilia") + "'") + ",fechinitit = " + (dkda.o(vars, "fechinitit_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "fechinitit_titularfamilia") + "'") + ",vivehijos = " + (dkda.o(vars, "vivehijos_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "vivehijos_titularfamilia") + "'") + ",numecueban = " + (dkda.o(vars, "numecueban_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "numecueban_titularfamilia") + "'") + ",codbanco = " + (dkda.o(vars, "codbanco_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "codbanco_titularfamilia") + "'") + ",codiesttit = " + (dkda.o(vars, "codiesttit_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "codiesttit_titularfamilia") + "'") + ",observacion = " + (dkda.o(vars, "observacion_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "observacion_titularfamilia") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",firmatitul = " + (dkda.o(vars, "firmatitul_titularfamilia").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "firmatitul_titularfamilia") + "')") + ",firmatitul_nombre = " + (dkda.o(vars, "firmatitul_titularfamilia").equals("") ? null : "'" + dkda.o(vars, "firmatitul_titularfamilia") + "'") + " WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND identitfam = '" + dkda.o(sel, "identitfam") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_titularfamilia&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_titularfamilia&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error titularfamilia.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_titularfamilia(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM titularfamilia WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND identitfam = '" + dkda.o(sel, "identitfam") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_titularfamilia&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_titularfamilia&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error titularfamilia.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_titularfamilia(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT banco.\"codbanco\"                      AS banco_codbanco, "
                    + "       banco.\"descripcion\"                   AS banco_descripcion, "
                    + "       estadotitular.\"codiesttit\"            AS estadotitular_codiesttit, "
                    + "       estadotitular.\"descripcion\"           AS estadotitular_descripcion, "
                    + "       tipotitular.\"coditiptit\"              AS tipotitular_coditiptit, "
                    + "       tipotitular.\"desctiptit\"              AS tipotitular_desctiptit, "
                    + "       titularfamilia.\"codunifami\"           AS titularfamilia_codunifami, "
                    + "       titularfamilia.\"codtipoidentidad\"     AS titularfamilia_codtipoidentidad, "
                    + "       titularfamilia.\"identitfam\"           AS titularfamilia_identitfam, "
                    + "       titularfamilia.\"coditiptit\"           AS titularfamilia_coditiptit, "
                    + "       titularfamilia.\"fechinitit\"           AS titularfamilia_fechinitit, "
                    + "       titularfamilia.\"vivehijos\"            AS titularfamilia_vivehijos, "
                    + "       titularfamilia.\"numecueban\"           AS titularfamilia_numecueban, "
                    + "       titularfamilia.\"codbanco\"             AS titularfamilia_codbanco, "
                    + "       titularfamilia.\"codiesttit\"           AS titularfamilia_codiesttit, "
                    + "       titularfamilia.\"observacion\"          AS titularfamilia_observacion, "
                    + "       titularfamilia.\"ususiscodigo\"         AS titularfamilia_ususiscodigo, "
                    + "       titularfamilia.\"fecharegistro\"        AS titularfamilia_fecharegistro, "
                    + "       titularfamilia.\"firmatitul_nombre\"    AS titularfamilia_firmatitul_nombre, "
                    + " CASE WHEN titularfamilia.firmatitul_nombre  IS NULL OR titularfamilia.firmatitul_nombre  = '' THEN 0 "
                    + " ELSE lo_export(titularfamilia.firmatitul, '" + fun.temp(request) + "' || titularfamilia.firmatitul_nombre ) END, "
                    + "        "
                    + "       tipoidentificacion.\"codtipoidentidad\" AS "
                    + "       tipoidentificacion_codtipoidentidad, "
                    + "       tipoidentificacion.\"descripcion\"      AS tipoidentificacion_descripcion, "
                    + "       inscripcion.\"codunifami\"              AS inscripcion_codunifami "
                    + "FROM   \"public\".\"banco\" banco "
                    + "       INNER JOIN \"public\".\"titularfamilia\" titularfamilia "
                    + "         ON banco.\"codbanco\" = titularfamilia.\"codbanco\" "
                    + "       INNER JOIN \"public\".\"estadotitular\" estadotitular "
                    + "         ON titularfamilia.\"codiesttit\" = estadotitular.\"codiesttit\" "
                    + "       INNER JOIN \"public\".\"inscripcion\" inscripcion "
                    + "         ON titularfamilia.\"codunifami\" = inscripcion.\"codunifami\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON titularfamilia.\"codtipoidentidad\" = "
                    + "            tipoidentificacion.\"codtipoidentidad\" "
                    + "       INNER JOIN \"public\".\"tipotitular\" tipotitular "
                    + "         ON titularfamilia.\"coditiptit\" = tipotitular.\"coditiptit\"  WHERE titularfamilia.codunifami = '"
                    + dkda.o(sel, "codunifami") + "' AND titularfamilia.codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND"
                    + " titularfamilia.identitfam = '" + dkda.o(sel, "identitfam") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#firmatitul_titularfamilia|" + (rs.getString("titularfamilia_firmatitul_nombre") == null ? "" : rs.getString("titularfamilia_firmatitul_nombre")) + ":_";

            info += "combo|#codiesttit_titularfamilia|" + rs.getString("estadotitular_codiesttit") + "|llenarCombo('codiesttit_titularfamilia', '"
                    + rs.getString("estadotitular_codiesttit") + "', '" + rs.getString("estadotitular_descripcion") + "'):_";

            info += "combo|#codbanco_titularfamilia|" + rs.getString("banco_codbanco") + "|llenarCombo('codbanco_titularfamilia', '"
                    + rs.getString("banco_codbanco") + "', '" + rs.getString("banco_descripcion") + "'):_";

            info += "text|#numecueban_titularfamilia|" + (rs.getString("titularfamilia_numecueban") == null ? "" : rs.getString("titularfamilia_numecueban")) + ":_";

            info += "switch|switch_vivehijos_titularfamilia|" + rs.getString("titularfamilia_vivehijos") + ":_";

            info += "text|#_fecha_fechinitit_titularfamilia|" + (rs.getString("titularfamilia_fechinitit") == null ? "" : rs.getString("titularfamilia_fechinitit")) + ":_";

            info += "combo|#coditiptit_titularfamilia|" + rs.getString("tipotitular_coditiptit") + "|llenarCombo('coditiptit_titularfamilia', '"
                    + rs.getString("tipotitular_coditiptit") + "', '" + rs.getString("estadotitular_descripcion") + "'):_";

            info += "text|#identitfam_titularfamilia|" + (rs.getString("titularfamilia_identitfam") == null ? "" : rs.getString("titularfamilia_identitfam")) + ":_";

            info += "combo|#codtipoidentidad_titularfamilia|" + rs.getString("tipoidentificacion_codtipoidentidad") + "|llenarCombo('codtipoidentidad_titularfamilia', '"
                    + rs.getString("tipoidentificacion_codtipoidentidad") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";

            info += "combo|#codunifami_titularfamilia|" + rs.getString("inscripcion_codunifami") + "|llenarCombo('codunifami_titularfamilia', '"
                    + rs.getString("inscripcion_codunifami") + "', '" + rs.getString("inscripcion_codunifami") + "'):_";

            info += "text|#observacion_titularfamilia|" + (rs.getString("titularfamilia_observacion") == null ? "" : rs.getString("titularfamilia_observacion")) + ":_";


            respuesta = "opcion=obtener_titularfamilia&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_titularfamilia&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error titularfamilia - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_titularfamilia() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM titularfamilia  WHERE codunifami = '"
                    + dkda.o(vars, "codunifami_titularfamilia") + "'" + " AND codtipoidentidad = '" + dkda.o(vars, "codtipoidentidad_titularfamilia")
                    + "'" + " AND identitfam = '" + dkda.o(vars, "identitfam_titularfamilia") + "'";


            pQuery = conexion.prepareStatement(sql);
            System.out.println("Consulta : " + sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_titularfamilia() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_titularfamilia() {
        String direccion = "opcion=registrar_titularfamilia&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_titularfamilia();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {

            if (!(dkda.o(sel, "codunifami").toString().equals(dkda.o(vars, "codunifami_titularfamilia"))
                    && dkda.o(sel, "codtipoidentidad").toString().equals(dkda.o(vars, "codtipoidentidad_titularfamilia"))
                    && dkda.o(sel, "identitfam").toString().equals(dkda.o(vars, "identitfam_titularfamilia")))
                    && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }

        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codunifami_titularfamilia").isEmpty()) {
            error = "Código &Uacute;nico Familia: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_titularfamilia").isEmpty()) {
            error = "Tipo Identificaci&oacute;n del Titular: no puede ser vacio.";
        } else if (dkda.o(vars, "identitfam_titularfamilia").isEmpty()) {
            error = "Identificación Titular Familia: no puede ser vacio.";
        } else if (dkda.o(vars, "coditiptit_titularfamilia").isEmpty()) {
            error = "C&oacute;digo Tipo Titular: no puede ser vacio.";
        } else if (dkda.o(vars, "fechinitit_titularfamilia").isEmpty()) {
            error = "Fecha Inicial Asignado Titular: no puede ser vacio.";
        } else if (dkda.o(vars, "vivehijos_titularfamilia").isEmpty()) {
            error = "Vive Hijos o Beneficiarios (S/N): no puede ser vacio.";
        } else if (dkda.o(vars, "numecueban_titularfamilia").isEmpty()) {
            error = "N&uacute;mero Cuenta Bancaria: no puede ser vacio.";
        } else if (dkda.o(vars, "codbanco_titularfamilia").isEmpty()) {
            error = "Codigo Banco Cuenta: no puede ser vacio.";
        } else if (dkda.o(vars, "codiesttit_titularfamilia").isEmpty()) {
            error = "Código Estado Titular Familia: no puede ser vacio.";
        } else if (dkda.o(vars, "firmatitul_titularfamilia").isEmpty()) {
            error = "Firma Titular: no puede ser vacio.";
        } else if (dkda.o(vars, "observacion_titularfamilia").isEmpty()) {
            error = "Observaciones Registro Titular: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "identitfam_titularfamilia"))) {
            error = "Identificación Titular Familia: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "identitfam_titularfamilia").length() > 10) {
            error = "Identificación Titular Familia: Valor demasiado Largo.";
        } else if (dkda.o(vars, "vivehijos_titularfamilia").length() > 1) {
            error = "Vive Hijos o Beneficiarios (S/N): Valor demasiado Largo.";
        } else if (dkda.o(vars, "numecueban_titularfamilia").length() > 20) {
            error = "N&uacute;mero Cuenta Bancaria: Valor demasiado Largo.";
        } else if (dkda.o(vars, "observacion_titularfamilia").length() > 400) {
            error = "Observaciones Registro Titular: Valor demasiado Largo.";
        }



        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_beneficiario(ConexionBaseDatos con) {
        System.out.println("registrar_beneficiario");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO beneficiario (codunifami,codtipoidentidad,identbenef,fechanacim,codigbenef,codtipoparentesco,codtipoidenemp,codempresa,numceresco,escgracodigo,codregimenes,codentidadsalud,numcuebanc,codbanco,vivecontit,codiestben,observacion,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "codunifami_beneficiario").equals("") ? null : "'" + dkda.o(vars, "codunifami_beneficiario") + "'") + "," + (dkda.o(vars, "codtipoidentidad_beneficiario").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_beneficiario") + "'") + "," + (dkda.o(vars, "identbenef_beneficiario").equals("") ? null : "'" + dkda.o(vars, "identbenef_beneficiario") + "'") + "," + (dkda.o(vars, "fechanacim_beneficiario").equals("") ? null : "'" + dkda.o(vars, "fechanacim_beneficiario") + "'") + "," + (dkda.o(vars, "codigbenef_beneficiario").equals("") ? null : "'" + dkda.o(vars, "codigbenef_beneficiario") + "'") + "," + (dkda.o(vars, "codtipoparentesco_beneficiario").equals("") ? null : "'" + dkda.o(vars, "codtipoparentesco_beneficiario") + "'") + "," + (dkda.o(empresa_beneficiario_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_beneficiario_1, "codtipoidentidad") + "'") + "," + (dkda.o(empresa_beneficiario_1, "codempresa").equals("") ? null : "'" + dkda.o(empresa_beneficiario_1, "codempresa") + "'") + "," + (dkda.o(vars, "numceresco_beneficiario").equals("") ? null : "'" + dkda.o(vars, "numceresco_beneficiario") + "'") + "," + (dkda.o(vars, "escgracodigo_beneficiario").equals("") ? null : "'" + dkda.o(vars, "escgracodigo_beneficiario") + "'") + "," + (dkda.o(entidadsalud_beneficiario_1, "codregimenes").equals("") ? null : "'" + dkda.o(entidadsalud_beneficiario_1, "codregimenes") + "'") + "," + (dkda.o(entidadsalud_beneficiario_1, "codentidadsalud").equals("") ? null : "'" + dkda.o(entidadsalud_beneficiario_1, "codentidadsalud") + "'") + "," + (dkda.o(vars, "numcuebanc_beneficiario").equals("") ? null : "'" + dkda.o(vars, "numcuebanc_beneficiario") + "'") + "," + (dkda.o(vars, "codbanco_beneficiario").equals("") ? null : "'" + dkda.o(vars, "codbanco_beneficiario") + "'") + "," + (dkda.o(vars, "vivecontit_beneficiario").equals("") ? null : "'" + dkda.o(vars, "vivecontit_beneficiario") + "'") + "," + (dkda.o(vars, "codiestben_beneficiario").equals("") ? null : "'" + dkda.o(vars, "codiestben_beneficiario") + "'") + "," + (dkda.o(vars, "observacion_beneficiario").equals("") ? null : "'" + dkda.o(vars, "observacion_beneficiario") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_beneficiario&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_beneficiario&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error beneficiario.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_beneficiario(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE beneficiario SET codunifami = " + (dkda.o(vars, "codunifami_beneficiario").equals("") ? null : "'" + dkda.o(vars, "codunifami_beneficiario") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_beneficiario").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_beneficiario") + "'") + ",identbenef = " + (dkda.o(vars, "identbenef_beneficiario").equals("") ? null : "'" + dkda.o(vars, "identbenef_beneficiario") + "'") + ",fechanacim = " + (dkda.o(vars, "fechanacim_beneficiario").equals("") ? null : "'" + dkda.o(vars, "fechanacim_beneficiario") + "'") + ",codigbenef = " + (dkda.o(vars, "codigbenef_beneficiario").equals("") ? null : "'" + dkda.o(vars, "codigbenef_beneficiario") + "'") + ",codtipoparentesco = " + (dkda.o(vars, "codtipoparentesco_beneficiario").equals("") ? null : "'" + dkda.o(vars, "codtipoparentesco_beneficiario") + "'") + ",codtipoidenemp = " + (dkda.o(empresa_beneficiario_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_beneficiario_1, "codtipoidentidad") + "'") + ",codempresa = " + (dkda.o(empresa_beneficiario_1, "codempresa").equals("") ? null : "'" + dkda.o(empresa_beneficiario_1, "codempresa") + "'") + ",numceresco = " + (dkda.o(vars, "numceresco_beneficiario").equals("") ? null : "'" + dkda.o(vars, "numceresco_beneficiario") + "'") + ",escgracodigo = " + (dkda.o(vars, "escgracodigo_beneficiario").equals("") ? null : "'" + dkda.o(vars, "escgracodigo_beneficiario") + "'") + ",codregimenes = " + (dkda.o(entidadsalud_beneficiario_1, "codregimenes").equals("") ? null : "'" + dkda.o(entidadsalud_beneficiario_1, "codregimenes") + "'") + ",codentidadsalud = " + (dkda.o(entidadsalud_beneficiario_1, "codentidadsalud").equals("") ? null : "'" + dkda.o(entidadsalud_beneficiario_1, "codentidadsalud") + "'") + ",numcuebanc = " + (dkda.o(vars, "numcuebanc_beneficiario").equals("") ? null : "'" + dkda.o(vars, "numcuebanc_beneficiario") + "'") + ",codbanco = " + (dkda.o(vars, "codbanco_beneficiario").equals("") ? null : "'" + dkda.o(vars, "codbanco_beneficiario") + "'") + ",vivecontit = " + (dkda.o(vars, "vivecontit_beneficiario").equals("") ? null : "'" + dkda.o(vars, "vivecontit_beneficiario") + "'") + ",codiestben = " + (dkda.o(vars, "codiestben_beneficiario").equals("") ? null : "'" + dkda.o(vars, "codiestben_beneficiario") + "'") + ",observacion = " + (dkda.o(vars, "observacion_beneficiario").equals("") ? null : "'" + dkda.o(vars, "observacion_beneficiario") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND identbenef = '" + dkda.o(sel, "identbenef") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_beneficiario&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_beneficiario&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error beneficiario.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_beneficiario(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM beneficiario WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND identbenef = '" + dkda.o(sel, "identbenef") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_beneficiario&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_beneficiario&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error beneficiario.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_beneficiario(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();

        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT beneficiario.\"codunifami\"             AS beneficiario_codunifami, "
                    + "       beneficiario.\"codtipoidentidad\"       AS beneficiario_codtipoidentidad, "
                    + "       beneficiario.\"identbenef\"             AS beneficiario_identbenef, "
                    + "       beneficiario.\"fechanacim\"             AS beneficiario_fechanacim, "
                    + "       beneficiario.\"codigbenef\"             AS beneficiario_codigbenef, "
                    + "       beneficiario.\"codtipoparentesco\"      AS beneficiario_codtipoparentesco, "
                    + "       beneficiario.\"codtipoidenemp\"         AS beneficiario_codtipoidenemp, "
                    + "       beneficiario.\"codempresa\"             AS beneficiario_codempresa, "
                    + "       beneficiario.\"numceresco\"             AS beneficiario_numceresco, "
                    + "       beneficiario.\"escgracodigo\"           AS beneficiario_escgracodigo, "
                    + "       beneficiario.\"codregimenes\"           AS beneficiario_codregimenes, "
                    + "       beneficiario.\"codentidadsalud\"        AS beneficiario_codentidadsalud, "
                    + "       beneficiario.\"numcuebanc\"             AS beneficiario_numcuebanc, "
                    + "       beneficiario.\"codbanco\"               AS beneficiario_codbanco, "
                    + "       beneficiario.\"vivecontit\"             AS beneficiario_vivecontit, "
                    + "       beneficiario.\"codiestben\"             AS beneficiario_codiestben, "
                    + "       beneficiario.\"observacion\"            AS beneficiario_observacion, "
                    + "       estadobeneficiario.\"codiestben\"       AS estadobeneficiario_codiestben, "
                    + "       estadobeneficiario.\"descestben\"       AS estadobeneficiario_descestben, "
                    + "       banco.\"codbanco\"                      AS banco_codbanco, "
                    + "       banco.\"descripcion\"                   AS banco_descripcion, "
                    + "       inscripcion.\"codunifami\"              AS inscripcion_codunifami, "
                    + "       entidadsalud.\"codentidadsalud\"        AS entidadsalud_codentidadsalud, "
                    + "       entidadsalud.\"codregimenes\"           AS entidadsalud_codregimenes, "
                    + "       entidadsalud.\"nombrehabilitacion\"           AS entidadsalud_nombrehabilitacion, "
                    + "       empresa.\"codtipoidentidad\"            AS empresa_codtipoidentidad, "
                    + "       empresa.\"codempresa\"                  AS empresa_codempresa, "
                    + "       empresa.\"nombre\"                      AS empresa_nombre, "
                    + "       escolaridadgrado.\"escgradescri\"       AS escolaridadgrado_escgradescri, "
                    + "       escolaridadgrado.\"escgracodigo\"       AS escolaridadgrado_escgracodigo, "
                    + "       tipoparentesco.\"codtipoparentesco\"    AS tipoparentesco_codtipoparentesco "
                    + "       , "
                    + "       tipoparentesco.\"descripcion\"          AS "
                    + "       tipoparentesco_descripcion, "
                    + "       tipoidentificacion.\"codtipoidentidad\" AS "
                    + "       tipoidentificacion_codtipoidentidad, "
                    + "       tipoidentificacion.\"descripcion\"      AS tipoidentificacion_descripcion "
                    + "FROM   \"public\".\"banco\" banco "
                    + "       INNER JOIN \"public\".\"beneficiario\" beneficiario "
                    + "         ON banco.\"codbanco\" = beneficiario.\"codbanco\" "
                    + "       INNER JOIN \"public\".\"empresa\" empresa "
                    + "         ON beneficiario.\"codtipoidenemp\" = empresa.\"codtipoidentidad\" "
                    + "            AND empresa.\"codempresa\" = beneficiario.\"codempresa\" "
                    + "       INNER JOIN \"public\".\"entidadsalud\" entidadsalud "
                    + "         ON beneficiario.\"codregimenes\" = entidadsalud.\"codregimenes\" "
                    + "            AND entidadsalud.\"codentidadsalud\" = beneficiario.\"codentidadsalud\" "
                    + "       INNER JOIN \"public\".\"escolaridadgrado\" escolaridadgrado "
                    + "         ON beneficiario.\"escgracodigo\" = escolaridadgrado.\"escgracodigo\" "
                    + "       INNER JOIN \"public\".\"estadobeneficiario\" estadobeneficiario "
                    + "         ON beneficiario.\"codiestben\" = estadobeneficiario.\"codiestben\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON beneficiario.\"codtipoidentidad\" = "
                    + "            tipoidentificacion.\"codtipoidentidad\" "
                    + "       INNER JOIN \"public\".\"tipoparentesco\" tipoparentesco "
                    + "         ON beneficiario.\"codtipoparentesco\" = "
                    + "            tipoparentesco.\"codtipoparentesco\" "
                    + "       INNER JOIN \"public\".\"inscripcion\" inscripcion "
                    + "         ON beneficiario.\"codunifami\" = inscripcion.\"codunifami\" WHERE "
                    + "beneficiario.codunifami = '" + dkda.o(sel, "codunifami") + "' AND beneficiario.codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "'"
                    + "AND beneficiario.identbenef = '" + dkda.o(sel, "identbenef") + "' ";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#observacion_beneficiario|" + (rs.getString("beneficiario_observacion") == null ? "" : rs.getString("beneficiario_observacion")) + ":_";

            info += "switch|switch_vivecontit_beneficiario|" + rs.getString("beneficiario_vivecontit") + ":_";

            info += "combo|#codiestben_beneficiario|" + rs.getString("estadobeneficiario_codiestben") + "|llenarCombo('codiestben_beneficiario', '"
                    + rs.getString("estadobeneficiario_codiestben") + "', '" + rs.getString("estadobeneficiario_descestben") + "'):_";

            info += "combo|#codbanco_beneficiario|" + rs.getString("banco_codbanco") + "|llenarCombo('codbanco_beneficiario', '"
                    + rs.getString("banco_codbanco") + "', '" + rs.getString("banco_descripcion") + "'):_";

            info += "text|#numcuebanc_beneficiario|" + (rs.getString("beneficiario_numcuebanc") == null ? "" : rs.getString("beneficiario_numcuebanc")) + ":_";

            info += "combo|#entidadsalud_beneficiario_1|" + "entidadsalud   codregimenes  " + rs.getString("entidadsalud_codregimenes") + ""
                    + "   codentidadsalud  " + rs.getString("entidadsalud_codentidadsalud") + "|llenarCombo('entidadsalud_beneficiario_1', '"
                    + "entidadsalud   codregimenes  " + rs.getString("entidadsalud_codregimenes") + "  "
                    + " codentidadsalud  " + rs.getString("entidadsalud_codentidadsalud") + "', '"
                    + rs.getString("entidadsalud_nombrehabilitacion") + "'):_";

            info += "combo|#escgracodigo_beneficiario|" + rs.getString("escolaridadgrado_escgracodigo") + "|llenarCombo('escgracodigo_beneficiario', '"
                    + rs.getString("escolaridadgrado_escgracodigo") + "', '" + rs.getString("escolaridadgrado_escgradescri") + "'):_";

            info += "text|#numceresco_beneficiario|" + (rs.getString("beneficiario_numceresco") == null ? "" : rs.getString("beneficiario_numceresco")) + ":_";

            info += "combo|#empresa_beneficiario_1|" + "empresa   codtipoidentidad  " + rs.getString("empresa_codtipoidentidad") + "   "
                    + "codempresa  " + rs.getString("empresa_codempresa") + "|llenarCombo('empresa_beneficiario_1', '"
                    + "empresa   codtipoidentidad  " + rs.getString("empresa_codtipoidentidad") + "   codempresa  "
                    + rs.getString("empresa_codempresa") + "', '" + rs.getString("empresa_nombre") + "'):_";

            info += "combo|#codtipoparentesco_beneficiario|" + rs.getString("tipoparentesco_codtipoparentesco") + "|llenarCombo('codtipoparentesco_beneficiario', '"
                    + rs.getString("tipoparentesco_codtipoparentesco") + "', '" + rs.getString("tipoparentesco_descripcion") + "'):_";

            info += "text|#codigbenef_beneficiario|" + (rs.getString("beneficiario_codigbenef") == null ? "" : rs.getString("beneficiario_codigbenef")) + ":_";

            info += "text|#_fecha_fechanacim_beneficiario|" + (rs.getString("beneficiario_fechanacim") == null ? "" : rs.getString("beneficiario_fechanacim")) + ":_";

            info += "text|#identbenef_beneficiario|" + (rs.getString("beneficiario_identbenef") == null ? "" : rs.getString("beneficiario_identbenef")) + ":_";

            info += "combo|#codtipoidentidad_beneficiario|" + rs.getString("tipoidentificacion_codtipoidentidad") + "|llenarCombo('codtipoidentidad_beneficiario', '"
                    + rs.getString("tipoidentificacion_codtipoidentidad") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";

            info += "combo|#codunifami_beneficiario|" + rs.getString("beneficiario_codunifami") + "|llenarCombo('codunifami_beneficiario', '"
                    + rs.getString("beneficiario_codunifami") + "', '" + rs.getString("beneficiario_codunifami") + "'):_";


            respuesta = "opcion=obtener_beneficiario&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_beneficiario&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error beneficiario - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_beneficiario() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM beneficiario  WHERE codunifami = '" + dkda.o(vars, "codunifami_beneficiario") + "'" 
                    + " AND codtipoidentidad = '" + dkda.o(vars, "codtipoidentidad_beneficiario") + "'" + " AND identbenef = '" + dkda.o(vars, "identbenef_beneficiario") + "'";
            System.out.println( sql );
            
            pQuery = conexion.prepareStatement(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_beneficiario() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_beneficiario() {
        String direccion = "opcion=registrar_beneficiario&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_beneficiario();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            System.out.println( dkda.o(sel, "codunifami")+ " : " +dkda.o(vars, "codunifami_beneficiario")  );
            if (!(dkda.o(sel, "codunifami").toString().equals(dkda.o(vars, "codunifami_beneficiario")) &&
                    dkda.o(sel, "codtipoidentidad").toString().equals(dkda.o(vars, "codtipoidentidad_beneficiario")) && 
                    dkda.o(sel, "identbenef").toString().equals(dkda.o(vars, "identbenef_beneficiario"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codunifami_beneficiario").isEmpty()) {
            error = "Código Único Familia: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_beneficiario").isEmpty()) {
            error = "Tipo de Identificación: no puede ser vacio.";
        } else if (dkda.o(vars, "identbenef_beneficiario").isEmpty()) {
            error = "Identificación Beneficiario: no puede ser vacio.";
        } else if (dkda.o(vars, "fechanacim_beneficiario").isEmpty()) {
            error = "Fecha Nacimiento Beneficiario: no puede ser vacio.";
        } else if (dkda.o(vars, "codigbenef_beneficiario").isEmpty()) {
            error = "Código Beneficiario: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoparentesco_beneficiario").isEmpty()) {
            error = "Codigo Tipo Parentesco  Titular: no puede ser vacio.";
        } else if (dkda.o(empresa_beneficiario_1, "codempresa").isEmpty()) {
            error = "Empresa: no puede ser vacio.";
        } else if (dkda.o(vars, "numceresco_beneficiario").isEmpty()) {
            error = "Número Certificado Escolar Inicial: no puede ser vacio.";
        } else if (dkda.o(vars, "escgracodigo_beneficiario").isEmpty()) {
            error = "Código Grado Escolaridad Inicial: no puede ser vacio.";
        } else if (dkda.o(entidadsalud_beneficiario_1, "codregimenes").isEmpty()) {
            error = "Codigo Regimen IPS Asignada: no puede ser vacio.";
        } else if (dkda.o(vars, "numcuebanc_beneficiario").isEmpty()) {
            error = "Número Cuenta Bancaria: no puede ser vacio.";
        } else if (dkda.o(vars, "codbanco_beneficiario").isEmpty()) {
            error = "Codigo Banco Cuenta: no puede ser vacio.";
        } else if (dkda.o(vars, "codiestben_beneficiario").isEmpty()) {
            error = "Código Estado Beneficiario: no puede ser vacio.";
        } else if (dkda.o(vars, "vivecontit_beneficiario").isEmpty()) {
            error = "Beneficiario Vive Titular (S/N): no puede ser vacio.";
        } else if (dkda.o(vars, "observacion_beneficiario").isEmpty()) {
            error = "Observaciones Registro Beneficiario: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "identbenef_beneficiario"))) {
            error = "Identificación Beneficiario: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "identbenef_beneficiario").length() > 10) {
            error = "Identificación Beneficiario: Valor demasiado Largo.";
        } else if (dkda.o(vars, "observacion_beneficiario").length() > 400) {
            error = "Observaciones Registro Beneficiario: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }// 

    private boolean existe_documentoinscripcion() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM documentoinscripcion  WHERE codunifami = '"
                    + dkda.o(sel, "codunifami") + "'" + " AND codtipodctoasociado = '" + dkda.o(sel, "codtipodctoasociado") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_documentoinscripcion() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
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