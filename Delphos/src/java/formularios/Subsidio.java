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

public class Subsidio extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, normas_subsidio_1;
    HashMap municipio_subsidiomunicipio_1;
    HashMap municipio_subsidiopotencial_1;
    HashMap subsidiopotencial_subsidioasignado_1, municipio_subsidioasignado_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());
        normas_subsidio_1 = fun.map(dkda.o(vars, "normas_subsidio_1").toString());
        municipio_subsidiomunicipio_1 = fun.map(dkda.o(vars, "municipio_subsidiomunicipio_1").toString());
        municipio_subsidiopotencial_1 = fun.map(dkda.o(vars, "municipio_subsidiopotencial_1").toString());
        subsidiopotencial_subsidioasignado_1 = fun.map(dkda.o(vars, "subsidiopotencial_subsidioasignado_1").toString());
        municipio_subsidioasignado_1 = fun.map(dkda.o(vars, "municipio_subsidioasignado_1").toString());

        try {
            String opcion = dkda.o(vars, "accion").toString();
            String pestana = dkda.o(vars, "pestana").toString();

            System.out.println(opcion);
            System.out.println(pestana);

            respuesta = "";

            if (pestana.equals("subsidio") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_subsidio();
            }
            if (opcion.equals("Registrar") && pestana.equals("subsidio") && respuesta.length() == 0) {
                out.println(registrar_subsidio(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("subsidio") && respuesta.length() == 0) {
                out.println(actualizar_subsidio(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("subsidio") && respuesta.length() == 0) {
                out.println(eliminar_subsidio(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("subsidio") && respuesta.length() == 0) {
                out.println(obtener_subsidio(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("subsidiomunicipio") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_subsidiomunicipio();
            }
            if (opcion.equals("Registrar") && pestana.equals("subsidiomunicipio") && respuesta.length() == 0) {
                out.println(registrar_subsidiomunicipio(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("subsidiomunicipio") && respuesta.length() == 0) {
                out.println(actualizar_subsidiomunicipio(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("subsidiomunicipio") && respuesta.length() == 0) {
                out.println(eliminar_subsidiomunicipio(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("subsidiomunicipio") && respuesta.length() == 0) {
                out.println(obtener_subsidiomunicipio(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("subsidiopotencial") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_subsidiopotencial();
            }
            if (opcion.equals("Registrar") && pestana.equals("subsidiopotencial") && respuesta.length() == 0) {
                out.println(registrar_subsidiopotencial(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("subsidiopotencial") && respuesta.length() == 0) {
                out.println(actualizar_subsidiopotencial(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("subsidiopotencial") && respuesta.length() == 0) {
                out.println(eliminar_subsidiopotencial(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("subsidiopotencial") && respuesta.length() == 0) {
                out.println(obtener_subsidiopotencial(con, dkda.o(vars, "codigo").toString()));
            }
            if (pestana.equals("subsidioasignado") && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                respuesta = validarFormulario_subsidioasignado();
            }
            if (opcion.equals("Registrar") && pestana.equals("subsidioasignado") && respuesta.length() == 0) {
                out.println(registrar_subsidioasignado(con));
            }
            if (opcion.equals("Actualizar") && pestana.equals("subsidioasignado") && respuesta.length() == 0) {
                out.println(actualizar_subsidioasignado(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Eliminar") && pestana.equals("subsidioasignado") && respuesta.length() == 0) {
                out.println(eliminar_subsidioasignado(con, dkda.o(vars, "codigo").toString()));
            }
            if (opcion.equals("Obtener") && pestana.equals("subsidioasignado") && respuesta.length() == 0) {
                out.println(obtener_subsidioasignado(con, dkda.o(vars, "codigo").toString()));
            }
            if (respuesta.length() > 0) {
                out.println(respuesta);
            }
        } finally {
            out.close();
        }
    }

    public String registrar_subsidio(ConexionBaseDatos con) {
        System.out.println("registrar_subsidio");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO subsidio (subscodigo,subsdescripc,subsfechinic,subsfechfina,subtipcodigo,clabencodigo,grugracodigo,subsvalobase,codtiponorma,codnorma,fechanorma,subsobservac,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "subscodigo_subsidio").equals("") ? null : "'" + dkda.o(vars, "subscodigo_subsidio") + "'") + "," + (dkda.o(vars, "subsdescripc_subsidio").equals("") ? null : "'" + dkda.o(vars, "subsdescripc_subsidio") + "'") + "," + (dkda.o(vars, "subsfechinic_subsidio").equals("") ? null : "'" + dkda.o(vars, "subsfechinic_subsidio") + "'") + "," + (dkda.o(vars, "subsfechfina_subsidio").equals("") ? null : "'" + dkda.o(vars, "subsfechfina_subsidio") + "'") + "," + (dkda.o(vars, "subtipcodigo_subsidio").equals("") ? null : "'" + dkda.o(vars, "subtipcodigo_subsidio") + "'") + "," + (dkda.o(vars, "clabencodigo_subsidio").equals("") ? null : "'" + dkda.o(vars, "clabencodigo_subsidio") + "'") + "," + (dkda.o(vars, "grugracodigo_subsidio").equals("") ? null : "'" + dkda.o(vars, "grugracodigo_subsidio") + "'") + "," + (dkda.o(vars, "subsvalobase_subsidio").equals("") ? null : dkda.o(vars, "subsvalobase_subsidio")) + "," + (dkda.o(normas_subsidio_1, "codtiponorma").equals("") ? null : "'" + dkda.o(normas_subsidio_1, "codtiponorma") + "'") + "," + (dkda.o(normas_subsidio_1, "codnorma").equals("") ? null : "'" + dkda.o(normas_subsidio_1, "codnorma") + "'") + "," + (dkda.o(normas_subsidio_1, "fechanorma").equals("") ? null : "'" + dkda.o(normas_subsidio_1, "fechanorma") + "'") + "," + (dkda.o(vars, "subsobservac_subsidio").equals("") ? null : "'" + dkda.o(vars, "subsobservac_subsidio") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_subsidio&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_subsidio&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error subsidio.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_subsidio(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE subsidio SET subscodigo = " + (dkda.o(vars, "subscodigo_subsidio").equals("") ? null : "'" + dkda.o(vars, "subscodigo_subsidio") + "'") + ",subsdescripc = " + (dkda.o(vars, "subsdescripc_subsidio").equals("") ? null : "'" + dkda.o(vars, "subsdescripc_subsidio") + "'") + ",subsfechinic = " + (dkda.o(vars, "subsfechinic_subsidio").equals("") ? null : "'" + dkda.o(vars, "subsfechinic_subsidio") + "'") + ",subsfechfina = " + (dkda.o(vars, "subsfechfina_subsidio").equals("") ? null : "'" + dkda.o(vars, "subsfechfina_subsidio") + "'") + ",subtipcodigo = " + (dkda.o(vars, "subtipcodigo_subsidio").equals("") ? null : "'" + dkda.o(vars, "subtipcodigo_subsidio") + "'") + ",clabencodigo = " + (dkda.o(vars, "clabencodigo_subsidio").equals("") ? null : "'" + dkda.o(vars, "clabencodigo_subsidio") + "'") + ",grugracodigo = " + (dkda.o(vars, "grugracodigo_subsidio").equals("") ? null : "'" + dkda.o(vars, "grugracodigo_subsidio") + "'") + ",subsvalobase = " + (dkda.o(vars, "subsvalobase_subsidio").equals("") ? null : dkda.o(vars, "subsvalobase_subsidio")) + ",codtiponorma = " + (dkda.o(normas_subsidio_1, "codtiponorma").equals("") ? null : "'" + dkda.o(normas_subsidio_1, "codtiponorma") + "'") + ",codnorma = " + (dkda.o(normas_subsidio_1, "codnorma").equals("") ? null : "'" + dkda.o(normas_subsidio_1, "codnorma") + "'") + ",fechanorma = " + (dkda.o(normas_subsidio_1, "fechanorma").equals("") ? null : "'" + dkda.o(normas_subsidio_1, "fechanorma") + "'") + ",subsobservac = " + (dkda.o(vars, "subsobservac_subsidio").equals("") ? null : "'" + dkda.o(vars, "subsobservac_subsidio") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE subscodigo = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_subsidio&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_subsidio&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error subsidio.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_subsidio(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM subsidio WHERE subscodigo = '" + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_subsidio&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_subsidio&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error subsidio.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_subsidio(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;

            String sql = ""
                    + "SELECT subsidio.\"subscodigo\"            AS subsidio_subscodigo, "
                    + "       subsidio.\"subsdescripc\"          AS subsidio_subsdescripc, "
                    + "       subsidio.\"subsfechinic\"          AS subsidio_subsfechinic, "
                    + "       subsidio.\"subsfechfina\"          AS subsidio_subsfechfina, "
                    + "       subsidio.\"subtipcodigo\"          AS subsidio_subtipcodigo, "
                    + "       subsidio.\"clabencodigo\"          AS subsidio_clabencodigo, "
                    + "       subsidio.\"grugracodigo\"          AS subsidio_grugracodigo, "
                    + "       subsidio.\"subsvalobase\"          AS subsidio_subsvalobase, "
                    + "       subsidio.\"codtiponorma\"          AS subsidio_codtiponorma, "
                    + "       subsidio.\"codnorma\"              AS subsidio_codnorma, "
                    + "       subsidio.\"fechanorma\"            AS subsidio_fechanorma, "
                    + "       subsidio.\"subsobservac\"          AS subsidio_subsobservac, "
                    + "       normas.\"referencia\"          AS normas_referencia, "
                    + "       clasebeneficiario.\"clabendescri\" AS clasebeneficiario_clabendescri, "
                    + "       tiposubsidio.\"subtipdescri\"      AS tiposubsidio_subtipdescri, "
                    + "       escgrupogrado.\"grugradescri\"     AS escgrupogrado_grugradescri "
                    + "FROM   \"public\".\"clasebeneficiario\" clasebeneficiario "
                    + "       INNER JOIN \"public\".\"subsidio\" subsidio "
                    + "         ON clasebeneficiario.\"clabencodigo\" = subsidio.\"clabencodigo\" "
                    + "       INNER JOIN \"public\".\"escgrupogrado\" escgrupogrado "
                    + "         ON subsidio.\"grugracodigo\" = escgrupogrado.\"grugracodigo\" "
                    + "       INNER JOIN \"public\".\"normas\" normas "
                    + "         ON subsidio.\"codtiponorma\" = normas.\"codtiponorma\" "
                    + "            AND normas.\"fechanorma\" = subsidio.\"fechanorma\" "
                    + "            AND normas.\"codnorma\" = subsidio.\"codnorma\" "
                    + "       INNER JOIN \"public\".\"tiposubsidio\" tiposubsidio "
                    + "         ON subsidio.\"subtipcodigo\" = tiposubsidio.\"subtipcodigo\" WHERE subscodigo = '" + dkda.o(vars, "codigo") + "' ";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();


            info += "text|#subsobservac_subsidio|" + (rs.getString("subsidio_subsobservac") == null ? ""
                    : rs.getString("subsidio_subsobservac")) + ":_";

            info += "combo|#normas_subsidio_1|" + "normas   codtiponorma  "
                    + rs.getString("subsidio_codtiponorma") + "   "
                    + "codnorma  " + rs.getString("subsidio_codnorma") + "   "
                    + "fechanorma  " + rs.getString("subsidio_fechanorma")
                    + "|llenarCombo('normas_subsidio_1', '"
                    + "normas   codtiponorma  "
                    + rs.getString("subsidio_codtiponorma") + "   "
                    + "codnorma  " + rs.getString("subsidio_codnorma") + "   "
                    + "fechanorma  " + rs.getString("subsidio_fechanorma")
                    + "', '" + rs.getString("normas_referencia") + "'):_";

            info += "text|#subsvalobase_subsidio|" + (rs.getString("subsidio_subsvalobase") == null ? ""
                    : rs.getString("subsidio_subsvalobase")) + ":_";

            info += "combo|#grugracodigo_subsidio|" + rs.getString("subsidio_grugracodigo")
                    + "|llenarCombo('grugracodigo_subsidio', '"
                    + rs.getString("subsidio_grugracodigo") + "', '"
                    + rs.getString("escgrupogrado_grugradescri") + "'):_";

            info += "combo|#clabencodigo_subsidio|" + rs.getString("subsidio_clabencodigo")
                    + "|llenarCombo('clabencodigo_subsidio', '"
                    + rs.getString("subsidio_clabencodigo") + "', '"
                    + rs.getString("clasebeneficiario_clabendescri") + "'):_";

            info += "combo|#subtipcodigo_subsidio|" + rs.getString("subsidio_subtipcodigo")
                    + "|llenarCombo('subtipcodigo_subsidio', '"
                    + rs.getString("subsidio_subtipcodigo") + "', '"
                    + rs.getString("tiposubsidio_subtipdescri") + "'):_";

            info += "text|#_fecha_subsfechfina_subsidio|" + (rs.getString("subsidio_subsfechfina") == null ? ""
                    : rs.getString("subsidio_subsfechfina")) + ":_";

            info += "text|#_fecha_subsfechinic_subsidio|" + (rs.getString("subsidio_subsfechinic") == null ? ""
                    : rs.getString("subsidio_subsfechinic")) + ":_";

            info += "text|#subsdescripc_subsidio|" + (rs.getString("subsidio_subsdescripc") == null ? ""
                    : rs.getString("subsidio_subsdescripc")) + ":_";

            info += "text|#subscodigo_subsidio|" + (rs.getString("subsidio_subscodigo") == null ? ""
                    : rs.getString("subsidio_subscodigo")) + ":_";

            respuesta = "opcion=obtener_subsidio&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_subsidio&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error subsidio - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_subsidio() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM subsidio  WHERE "
                    + "subscodigo = '" + dkda.o(vars, "subscodigo_subsidio") + "'";
            System.out.println(sql);
            pQuery = conexion.prepareStatement(sql);

            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_subsidio() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_subsidio() {
        String direccion = "opcion=registrar_subsidio&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_subsidio();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "subscodigo_subsidio"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "subscodigo_subsidio").isEmpty()) {
            error = "Código Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subsdescripc_subsidio").isEmpty()) {
            error = "Descripción Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subsfechinic_subsidio").isEmpty()) {
            error = "Fecha Inicial Vigencia Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subsfechfina_subsidio").isEmpty()) {
            error = "Fecha Final Vigencia Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subtipcodigo_subsidio").isEmpty()) {
            error = "Código Tipo Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "clabencodigo_subsidio").isEmpty()) {
            error = "Código Clase Beneficiario: no puede ser vacio.";
        } else if (dkda.o(vars, "grugracodigo_subsidio").isEmpty()) {
            error = "Código Grupo Grado Escolaridad: no puede ser vacio.";
        } else if (dkda.o(vars, "subsvalobase_subsidio").isEmpty()) {
            error = "Valor Base Subsidio: no puede ser vacio.";
        } else if (dkda.o(normas_subsidio_1, "codtiponorma").isEmpty()) {
            error = "Codigo Tipo Norma: no puede ser vacio.";
        } else if (dkda.o(vars, "subsobservac_subsidio").isEmpty()) {
            error = "Observaciones Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subscodigo_subsidio").length() > 5) {
            error = "Código Subsidio: Valor demasiado Largo.";
        } else if (dkda.o(vars, "subsdescripc_subsidio").length() > 45) {
            error = "Descripción Subsidio: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_subsidiomunicipio(ConexionBaseDatos con) {
        System.out.println("registrar_subsidiomunicipio");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO subsidiomunicipio (subscodigo,coddepartamento,codmunicipio,submunvalsub,subtipcodigo,submundescri,submunobserv,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "subscodigo_subsidiomunicipio").equals("") ? null : "'" + dkda.o(vars, "subscodigo_subsidiomunicipio") + "'") + "," + (dkda.o(municipio_subsidiomunicipio_1, "coddepartamento").equals("") ? null : dkda.o(municipio_subsidiomunicipio_1, "coddepartamento")) + "," + (dkda.o(municipio_subsidiomunicipio_1, "codmunicipio").equals("") ? null : dkda.o(municipio_subsidiomunicipio_1, "codmunicipio")) + "," + (dkda.o(vars, "submunvalsub_subsidiomunicipio").equals("") ? null : dkda.o(vars, "submunvalsub_subsidiomunicipio")) + "," + (dkda.o(vars, "subtipcodigo_subsidiomunicipio").equals("") ? null : "'" + dkda.o(vars, "subtipcodigo_subsidiomunicipio") + "'") + "," + (dkda.o(vars, "submundescri_subsidiomunicipio").equals("") ? null : "'" + dkda.o(vars, "submundescri_subsidiomunicipio") + "'") + "," + (dkda.o(vars, "submunobserv_subsidiomunicipio").equals("") ? null : "'" + dkda.o(vars, "submunobserv_subsidiomunicipio") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_subsidiomunicipio&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_subsidiomunicipio&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error subsidiomunicipio.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_subsidiomunicipio(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE subsidiomunicipio SET subscodigo = " + (dkda.o(vars, "subscodigo_subsidiomunicipio").equals("") ? null : "'" + dkda.o(vars, "subscodigo_subsidiomunicipio") + "'") + ",coddepartamento = " + (dkda.o(municipio_subsidiomunicipio_1, "coddepartamento").equals("") ? null : dkda.o(municipio_subsidiomunicipio_1, "coddepartamento")) + ",codmunicipio = " + (dkda.o(municipio_subsidiomunicipio_1, "codmunicipio").equals("") ? null : dkda.o(municipio_subsidiomunicipio_1, "codmunicipio")) + ",submunvalsub = " + (dkda.o(vars, "submunvalsub_subsidiomunicipio").equals("") ? null : dkda.o(vars, "submunvalsub_subsidiomunicipio")) + ",subtipcodigo = " + (dkda.o(vars, "subtipcodigo_subsidiomunicipio").equals("") ? null : "'" + dkda.o(vars, "subtipcodigo_subsidiomunicipio") + "'") + ",submundescri = " + (dkda.o(vars, "submundescri_subsidiomunicipio").equals("") ? null : "'" + dkda.o(vars, "submundescri_subsidiomunicipio") + "'") + ",submunobserv = " + (dkda.o(vars, "submunobserv_subsidiomunicipio").equals("") ? null : "'" + dkda.o(vars, "submunobserv_subsidiomunicipio") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE subscodigo = '" + dkda.o(sel, "subscodigo") + "' AND coddepartamento = " + dkda.o(sel, "coddepartamento") + " AND codmunicipio = " + dkda.o(sel, "codmunicipio") + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_subsidiomunicipio&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_subsidiomunicipio&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error subsidiomunicipio.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_subsidiomunicipio(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM subsidiomunicipio WHERE subscodigo = '" + dkda.o(sel, "subscodigo") + "' AND coddepartamento = " + dkda.o(sel, "coddepartamento") + " AND codmunicipio = " + dkda.o(sel, "codmunicipio") + " ");
            stmt.execute();
            respuesta = "opcion=eliminar_subsidiomunicipio&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_subsidiomunicipio&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error subsidiomunicipio.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_subsidiomunicipio(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT subsidiomunicipio.\"subscodigo\"      AS subsidiomunicipio_subscodigo, "
                    + "       subsidiomunicipio.\"coddepartamento\" AS subsidiomunicipio_coddepartamento, "
                    + "       subsidiomunicipio.\"codmunicipio\"    AS subsidiomunicipio_codmunicipio, "
                    + "       subsidiomunicipio.\"submunvalsub\"    AS subsidiomunicipio_submunvalsub, "
                    + "       subsidiomunicipio.\"subtipcodigo\"    AS subsidiomunicipio_subtipcodigo, "
                    + "       subsidiomunicipio.\"submundescri\"    AS subsidiomunicipio_submundescri, "
                    + "       subsidiomunicipio.\"submunobserv\"    AS subsidiomunicipio_submunobserv, "
                    + "       tiposubsidio.\"subtipdescri\"         AS tiposubsidio_subtipdescri, "
                    + "       municipio.\"nombre\"                  AS municipio_nombre, "
                    + "       subsidio.\"subsdescripc\"             AS subsidio_subsdescripc "
                    + "FROM   \"public\".\"municipio\" municipio "
                    + "       INNER JOIN \"public\".\"subsidiomunicipio\" subsidiomunicipio "
                    + "         ON municipio.\"coddepartamento\" = subsidiomunicipio.\"coddepartamento\" "
                    + "            AND municipio.\"codmunicipio\" = subsidiomunicipio.\"codmunicipio\" "
                    + "       INNER JOIN \"public\".\"subsidio\" subsidio "
                    + "         ON subsidiomunicipio.\"subscodigo\" = subsidio.\"subscodigo\" "
                    + "       INNER JOIN \"public\".\"tiposubsidio\" tiposubsidio "
                    + "         ON subsidiomunicipio.\"subtipcodigo\" = tiposubsidio.\"subtipcodigo\" "
                    + "WHERE subsidiomunicipio.subscodigo = '" + dkda.o(sel, "subscodigo") + "' AND "
                    + "subsidiomunicipio.coddepartamento = " + dkda.o(sel, "coddepartamento") + ""
                    + " AND subsidiomunicipio.codmunicipio = " + dkda.o(sel, "codmunicipio") + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#submunobserv_subsidiomunicipio|" + (rs.getString("subsidiomunicipio_submunobserv") == null ? ""
                    : rs.getString("subsidiomunicipio_submunobserv")) + ":_";

            info += "text|#submundescri_subsidiomunicipio|" + (rs.getString("subsidiomunicipio_submundescri") == null ? ""
                    : rs.getString("subsidiomunicipio_submundescri")) + ":_";

            info += "combo|#subtipcodigo_subsidiomunicipio|" + rs.getString("subsidiomunicipio_subtipcodigo")
                    + "|llenarCombo('subtipcodigo_subsidiomunicipio', '"
                    + rs.getString("subsidiomunicipio_subtipcodigo") + "', '"
                    + rs.getString("tiposubsidio_subtipdescri") + "'):_";

            info += "text|#submunvalsub_subsidiomunicipio|" + (rs.getString("subsidiomunicipio_submunvalsub") == null ? ""
                    : rs.getString("subsidiomunicipio_submunvalsub")) + ":_";

            info += "combo|#municipio_subsidiomunicipio_1|" + "municipio   coddepartamento  "
                    + rs.getString("subsidiomunicipio_coddepartamento") + "   "
                    + "codmunicipio  " + rs.getString("subsidiomunicipio_codmunicipio")
                    + "|llenarCombo('municipio_subsidiomunicipio_1', '"
                    + "municipio   coddepartamento  "
                    + rs.getString("subsidiomunicipio_coddepartamento") + "   "
                    + "codmunicipio  " + rs.getString("subsidiomunicipio_codmunicipio")
                    + "', '"
                    + rs.getString("municipio_nombre") + "'):_";

            info += "combo|#subscodigo_subsidiomunicipio|" + rs.getString("subsidiomunicipio_subscodigo")
                    + "|llenarCombo('subscodigo_subsidiomunicipio', '"
                    + rs.getString("subsidiomunicipio_subscodigo") + "', '"
                    + rs.getString("subsidio_subsdescripc") + "'):_";




            respuesta = "opcion=obtener_subsidiomunicipio&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_subsidiomunicipio&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error subsidiomunicipio - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_subsidiomunicipio() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM subsidiomunicipio "
                    + " WHERE subscodigo = '" + dkda.o(vars, "subscodigo_subsidiomunicipio") + "'"
                    + " AND coddepartamento = " + dkda.o(municipio_subsidiomunicipio_1, "coddepartamento") + ""
                    + " AND codmunicipio = " + dkda.o(municipio_subsidiomunicipio_1, "codmunicipio") + "";
            System.out.println(sql);
            pQuery = conexion.prepareStatement(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_subsidiomunicipio() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_subsidiomunicipio() {
        String direccion = "opcion=registrar_subsidiomunicipio&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_subsidiomunicipio();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "subscodigo").toString().equals(dkda.o(vars, "subscodigo_subsidiomunicipio"))
                    && dkda.o(sel, "coddepartamento").toString().equals(dkda.o(municipio_subsidiomunicipio_1, "coddepartamento"))
                    && dkda.o(sel, "codmunicipio").toString().equals(dkda.o(municipio_subsidiomunicipio_1, "codmunicipio")))
                    && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "subscodigo_subsidiomunicipio").isEmpty()) {
            error = "Código Subsidio: no puede ser vacio.";
        } else if (dkda.o(municipio_subsidiomunicipio_1, "coddepartamento").isEmpty()) {
            error = "Municipio: no puede ser vacio.";
        } else if (dkda.o(vars, "submunvalsub_subsidiomunicipio").isEmpty()) {
            error = "Valor Subsidio Municipio: no puede ser vacio.";
        } else if (dkda.o(vars, "subtipcodigo_subsidiomunicipio").isEmpty()) {
            error = "Código Tipo de Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "submundescri_subsidiomunicipio").isEmpty()) {
            error = "Descripción Subsidio Municipio: no puede ser vacio.";
        } else if (dkda.o(vars, "submunobserv_subsidiomunicipio").isEmpty()) {
            error = "Observaciones Subsidio Municipio: no puede ser vacio.";
        } else if (!v.numDecimal(dkda.o(vars, "submunvalsub_subsidiomunicipio"))) {
            error = "Valor Subsidio Municipio: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "submunobserv_subsidiomunicipio").length() > 400) {
            error = "Observaciones Subsidio Municipio: Valor demasiado Largo.";
        }



        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_subsidiopotencial(ConexionBaseDatos con) {
        System.out.println("registrar_subsidiopotencial");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO subsidiopotencial (codunifami,codtipoidentidad,subpotidenti,subscodigo,subpotvalsub,coddepartamento,codmunicipio,subpotdescri,subpotobserv,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "codunifami_subsidiopotencial").equals("") ? null : "'" + dkda.o(vars, "codunifami_subsidiopotencial") + "'") + "," + (dkda.o(vars, "codtipoidentidad_subsidiopotencial").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_subsidiopotencial") + "'") + "," + (dkda.o(vars, "subpotidenti_subsidiopotencial").equals("") ? null : "'" + dkda.o(vars, "subpotidenti_subsidiopotencial") + "'") + "," + (dkda.o(vars, "subscodigo_subsidiopotencial").equals("") ? null : "'" + dkda.o(vars, "subscodigo_subsidiopotencial") + "'") + "," + (dkda.o(vars, "subpotvalsub_subsidiopotencial").equals("") ? null : dkda.o(vars, "subpotvalsub_subsidiopotencial")) + "," + (dkda.o(municipio_subsidiopotencial_1, "coddepartamento").equals("") ? null : dkda.o(municipio_subsidiopotencial_1, "coddepartamento")) + "," + (dkda.o(municipio_subsidiopotencial_1, "codmunicipio").equals("") ? null : dkda.o(municipio_subsidiopotencial_1, "codmunicipio")) + "," + (dkda.o(vars, "subpotdescri_subsidiopotencial").equals("") ? null : "'" + dkda.o(vars, "subpotdescri_subsidiopotencial") + "'") + "," + (dkda.o(vars, "subpotobserv_subsidiopotencial").equals("") ? null : "'" + dkda.o(vars, "subpotobserv_subsidiopotencial") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_subsidiopotencial&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_subsidiopotencial&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error subsidiopotencial.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_subsidiopotencial(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE subsidiopotencial SET codunifami = "
                    + (dkda.o(vars, "codunifami_subsidiopotencial").equals("") ? null : "'"
                    + dkda.o(vars, "codunifami_subsidiopotencial") + "'") + ",codtipoidentidad = "
                    + (dkda.o(vars, "codtipoidentidad_subsidiopotencial").equals("") ? null : "'"
                    + dkda.o(vars, "codtipoidentidad_subsidiopotencial") + "'") + ",subpotidenti = "
                    + (dkda.o(vars, "subpotidenti_subsidiopotencial").equals("") ? null : "'" + dkda.o(vars, "subpotidenti_subsidiopotencial") + "'") + ",subscodigo = "
                    + (dkda.o(vars, "subscodigo_subsidiopotencial").equals("") ? null : "'"
                    + dkda.o(vars, "subscodigo_subsidiopotencial") + "'") + ",subpotvalsub = "
                    + (dkda.o(vars, "subpotvalsub_subsidiopotencial").equals("") ? null
                    : dkda.o(vars, "subpotvalsub_subsidiopotencial")) + ",coddepartamento = "
                    + (dkda.o(municipio_subsidiopotencial_1, "coddepartamento").equals("") ? null
                    : dkda.o(municipio_subsidiopotencial_1, "coddepartamento")) + ",codmunicipio = "
                    + (dkda.o(municipio_subsidiopotencial_1, "codmunicipio").equals("") ? null
                    : dkda.o(municipio_subsidiopotencial_1, "codmunicipio")) + ",subpotdescri = "
                    + (dkda.o(vars, "subpotdescri_subsidiopotencial").equals("") ? null : "'"
                    + dkda.o(vars, "subpotdescri_subsidiopotencial") + "'") + ",subpotobserv = "
                    + (dkda.o(vars, "subpotobserv_subsidiopotencial").equals("") ? null : "'"
                    + dkda.o(vars, "subpotobserv_subsidiopotencial") + "'") + ",ususiscodigo = " + "'"
                    + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date"
                    + " WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' "
                    + "AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' "
                    + "AND subpotidenti = '" + dkda.o(sel, "subpotidenti") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_subsidiopotencial&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_subsidiopotencial&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error subsidiopotencial.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_subsidiopotencial(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM subsidiopotencial WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND subpotidenti = '" + dkda.o(sel, "subpotidenti") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_subsidiopotencial&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_subsidiopotencial&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error subsidiopotencial.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_subsidiopotencial(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT subsidiopotencial.\"codunifami\"       AS subsidiopotencial_codunifami, "
                    + "       subsidiopotencial.\"codtipoidentidad\" AS "
                    + "       subsidiopotencial_codtipoidentidad, "
                    + "       subsidiopotencial.\"subpotidenti\"     AS subsidiopotencial_subpotidenti, "
                    + "       subsidiopotencial.\"subscodigo\"       AS subsidiopotencial_subscodigo, "
                    + "       subsidiopotencial.\"subpotvalsub\"     AS subsidiopotencial_subpotvalsub, "
                    + "       subsidiopotencial.\"coddepartamento\"  AS subsidiopotencial_coddepartamento "
                    + "       , "
                    + "       subsidiopotencial.\"codmunicipio\"     AS "
                    + "       subsidiopotencial_codmunicipio, "
                    + "       subsidiopotencial.\"subpotdescri\"     AS subsidiopotencial_subpotdescri, "
                    + "       subsidiopotencial.\"subpotobserv\"     AS subsidiopotencial_subpotobserv, "
                    + "       municipio.\"nombre\"                   AS municipio_nombre, "
                    + "       subsidio.\"subsdescripc\"              AS subsidio_subsdescripc, "
                    + "       tipoidentificacion.\"descripcion\"     AS tipoidentificacion_descripcion "
                    + "FROM   \"public\".\"inscripcion\" inscripcion "
                    + "       INNER JOIN \"public\".\"subsidiopotencial\" subsidiopotencial "
                    + "         ON inscripcion.\"codunifami\" = subsidiopotencial.\"codunifami\" "
                    + "       INNER JOIN \"public\".\"municipio\" municipio "
                    + "         ON subsidiopotencial.\"coddepartamento\" = municipio.\"coddepartamento\" "
                    + "            AND municipio.\"codmunicipio\" = subsidiopotencial.\"codmunicipio\" "
                    + "       INNER JOIN \"public\".\"subsidio\" subsidio "
                    + "         ON subsidiopotencial.\"subscodigo\" = subsidio.\"subscodigo\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON subsidiopotencial.\"codtipoidentidad\" = "
                    + "            tipoidentificacion.\"codtipoidentidad\""
                    + " WHERE subsidiopotencial.codunifami = '" + dkda.o(sel, "codunifami") + "' "
                    + "AND subsidiopotencial.codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' "
                    + "AND subsidiopotencial.subpotidenti = '" + dkda.o(sel, "subpotidenti") + "' ";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#subpotdescri_subsidiopotencial|" + (rs.getString("subsidiopotencial_subpotobserv") == null ? ""
                    : rs.getString("subsidiopotencial_subpotobserv")) + ":_";

            info += "text|#subpotobserv_subsidiopotencial|" + (rs.getString("subsidiopotencial_subpotdescri") == null ? ""
                    : rs.getString("subsidiopotencial_subpotdescri")) + ":_";

            info += "combo|#municipio_subsidiopotencial_1|" + "municipio   coddepartamento  "
                    + rs.getString("subsidiopotencial_coddepartamento") + "   "
                    + "codmunicipio  " + rs.getString("subsidiopotencial_codmunicipio")
                    + "|llenarCombo('municipio_subsidiopotencial_1', '"
                    + "municipio   coddepartamento  "
                    + rs.getString("subsidiopotencial_coddepartamento") + "   "
                    + "codmunicipio  " + rs.getString("subsidiopotencial_codmunicipio")
                    + "', '"
                    + rs.getString("municipio_nombre") + "'):_";

            info += "text|#subpotvalsub_subsidiopotencial|" + (rs.getString("subsidiopotencial_subpotvalsub") == null ? ""
                    : rs.getString("subsidiopotencial_subpotvalsub")) + ":_";

            info += "combo|#subscodigo_subsidiopotencial|" + rs.getString("subsidiopotencial_subscodigo")
                    + "|llenarCombo('subscodigo_subsidiopotencial', '"
                    + rs.getString("subsidiopotencial_subscodigo") + "', '"
                    + rs.getString("subsidio_subsdescripc") + "'):_";

            info += "text|#subpotidenti_subsidiopotencial|" + (rs.getString("subsidiopotencial_subpotidenti") == null ? ""
                    : rs.getString("subsidiopotencial_subpotidenti")) + ":_";

            info += "combo|#codtipoidentidad_subsidiopotencial|" + rs.getString("subsidiopotencial_codtipoidentidad")
                    + "|llenarCombo('codtipoidentidad_subsidiopotencial', '"
                    + rs.getString("subsidiopotencial_codtipoidentidad") + "', '"
                    + rs.getString("tipoidentificacion_descripcion") + "'):_";

            info += "combo|#codunifami_subsidiopotencial|" + rs.getString("subsidiopotencial_codunifami")
                    + "|llenarCombo('codunifami_subsidiopotencial', '"
                    + rs.getString("subsidiopotencial_codunifami") + "', '"
                    + rs.getString("subsidiopotencial_codunifami") + "'):_";

            respuesta = "opcion=obtener_subsidiopotencial&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_subsidiopotencial&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error subsidiopotencial - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_subsidiopotencial() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM subsidiopotencial  "
                    + "WHERE codunifami = '" + dkda.o(vars, "codunifami_subsidiopotencial") + "'" + " "
                    + "AND codtipoidentidad = '" + dkda.o(vars, "codtipoidentidad_subsidiopotencial") + "'" + " "
                    + "AND subpotidenti = '" + dkda.o(vars, "subpotidenti_subsidiopotencial") + "'";
            System.out.println(sql);
            pQuery = conexion.prepareStatement(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_subsidiopotencial() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_subsidiopotencial() {
        String direccion = "opcion=registrar_subsidiopotencial&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_subsidiopotencial();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codunifami").toString().equals(dkda.o(vars, "codunifami_subsidiopotencial"))
                    && dkda.o(sel, "codtipoidentidad").toString().equals(dkda.o(vars, "codtipoidentidad_subsidiopotencial"))
                    && dkda.o(sel, "subpotidenti").toString().equals(dkda.o(vars, "subpotidenti_subsidiopotencial")))
                    && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codunifami_subsidiopotencial").isEmpty()) {
            error = "Código Único Familia: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_subsidiopotencial").isEmpty()) {
            error = "Tipo Identificacion Beneficiario Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subpotidenti_subsidiopotencial").isEmpty()) {
            error = "Identificación Beneficiario Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subscodigo_subsidiopotencial").isEmpty()) {
            error = "Código Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subpotvalsub_subsidiopotencial").isEmpty()) {
            error = "Valor Subsidio Potencial: no puede ser vacio.";
        } else if (dkda.o(municipio_subsidiopotencial_1, "coddepartamento").isEmpty()) {
            error = "Municipio Segun DANE: no puede ser vacio.";
        } else if (dkda.o(vars, "subpotdescri_subsidiopotencial").isEmpty()) {
            error = "Descripción Subsidio Potencial: no puede ser vacio.";
        } else if (dkda.o(vars, "subpotobserv_subsidiopotencial").isEmpty()) {
            error = "Observaciones Subsidio Potencial: no puede ser vacio.";
        } else if (!v.numDecimal(dkda.o(vars, "subpotvalsub_subsidiopotencial"))) {
            error = "Valor Subsidio Potencial: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "subpotobserv_subsidiopotencial").length() > 400) {
            error = "Observaciones Subsidio Potencial: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    public String registrar_subsidioasignado(ConexionBaseDatos con) {
        System.out.println("registrar_subsidioasignado");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO subsidioasignado (codunifami,codtipoidentidad,subpotidenti,subasifecini,subasifecfin,subscodigo,subasivalsub,coddepartamento,codmunicipio,subasidescri,codbanco,subasireqedu,subasireqsal,subasiusosub,subasiobserv,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(subsidiopotencial_subsidioasignado_1, "codunifami").equals("") ? null : "'" + dkda.o(subsidiopotencial_subsidioasignado_1, "codunifami") + "'") + "," + (dkda.o(subsidiopotencial_subsidioasignado_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(subsidiopotencial_subsidioasignado_1, "codtipoidentidad") + "'") + "," + (dkda.o(subsidiopotencial_subsidioasignado_1, "subpotidenti").equals("") ? null : "'" + dkda.o(subsidiopotencial_subsidioasignado_1, "subpotidenti") + "'") + "," + (dkda.o(vars, "subasifecini_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subasifecini_subsidioasignado") + "'") + "," + (dkda.o(vars, "subasifecfin_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subasifecfin_subsidioasignado") + "'") + "," + (dkda.o(vars, "subscodigo_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subscodigo_subsidioasignado") + "'") + "," + (dkda.o(vars, "subasivalsub_subsidioasignado").equals("") ? null : dkda.o(vars, "subasivalsub_subsidioasignado")) + "," + (dkda.o(municipio_subsidioasignado_1, "coddepartamento").equals("") ? null : dkda.o(municipio_subsidioasignado_1, "coddepartamento")) + "," + (dkda.o(municipio_subsidioasignado_1, "codmunicipio").equals("") ? null : dkda.o(municipio_subsidioasignado_1, "codmunicipio")) + "," + (dkda.o(vars, "subasidescri_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subasidescri_subsidioasignado") + "'") + "," + (dkda.o(vars, "codbanco_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "codbanco_subsidioasignado") + "'") + "," + (dkda.o(vars, "subasireqedu_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subasireqedu_subsidioasignado") + "'") + "," + (dkda.o(vars, "subasireqsal_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subasireqsal_subsidioasignado") + "'") + "," + (dkda.o(vars, "subasiusosub_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subasiusosub_subsidioasignado") + "'") + "," + (dkda.o(vars, "subasiobserv_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subasiobserv_subsidioasignado") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_subsidioasignado&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_subsidioasignado&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error subsidioasignado.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_subsidioasignado(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE subsidioasignado SET codunifami = " + (dkda.o(subsidiopotencial_subsidioasignado_1, "codunifami").equals("") ? null : "'" + dkda.o(subsidiopotencial_subsidioasignado_1, "codunifami") + "'") + ",codtipoidentidad = " + (dkda.o(subsidiopotencial_subsidioasignado_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(subsidiopotencial_subsidioasignado_1, "codtipoidentidad") + "'") + ",subpotidenti = " + (dkda.o(subsidiopotencial_subsidioasignado_1, "subpotidenti").equals("") ? null : "'" + dkda.o(subsidiopotencial_subsidioasignado_1, "subpotidenti") + "'") + ",subasifecini = " + (dkda.o(vars, "subasifecini_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subasifecini_subsidioasignado") + "'") + ",subasifecfin = " + (dkda.o(vars, "subasifecfin_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subasifecfin_subsidioasignado") + "'") + ",subscodigo = " + (dkda.o(vars, "subscodigo_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subscodigo_subsidioasignado") + "'") + ",subasivalsub = " + (dkda.o(vars, "subasivalsub_subsidioasignado").equals("") ? null : dkda.o(vars, "subasivalsub_subsidioasignado")) + ",coddepartamento = " + (dkda.o(municipio_subsidioasignado_1, "coddepartamento").equals("") ? null : dkda.o(municipio_subsidioasignado_1, "coddepartamento")) + ",codmunicipio = " + (dkda.o(municipio_subsidioasignado_1, "codmunicipio").equals("") ? null : dkda.o(municipio_subsidioasignado_1, "codmunicipio")) + ",subasidescri = " + (dkda.o(vars, "subasidescri_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subasidescri_subsidioasignado") + "'") + ",codbanco = " + (dkda.o(vars, "codbanco_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "codbanco_subsidioasignado") + "'") + ",subasireqedu = " + (dkda.o(vars, "subasireqedu_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subasireqedu_subsidioasignado") + "'") + ",subasireqsal = " + (dkda.o(vars, "subasireqsal_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subasireqsal_subsidioasignado") + "'") + ",subasiusosub = " + (dkda.o(vars, "subasiusosub_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subasiusosub_subsidioasignado") + "'") + ",subasiobserv = " + (dkda.o(vars, "subasiobserv_subsidioasignado").equals("") ? null : "'" + dkda.o(vars, "subasiobserv_subsidioasignado") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND subpotidenti = '" + dkda.o(sel, "subpotidenti") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_subsidioasignado&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_subsidioasignado&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error subsidioasignado.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_subsidioasignado(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM subsidioasignado WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND subpotidenti = '" + dkda.o(sel, "subpotidenti") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_subsidioasignado&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_subsidioasignado&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error subsidioasignado.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_subsidioasignado(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT subsidioasignado.\"codunifami\"       AS subsidioasignado_codunifami, "
                    + "       subsidioasignado.\"codtipoidentidad\" AS subsidioasignado_codtipoidentidad, "
                    + "       subsidioasignado.\"subpotidenti\"     AS subsidioasignado_subpotidenti, "
                    + "       subsidioasignado.\"subasifecini\"     AS subsidioasignado_subasifecini, "
                    + "       subsidioasignado.\"subasifecfin\"     AS subsidioasignado_subasifecfin, "
                    + "       subsidioasignado.\"subscodigo\"       AS subsidioasignado_subscodigo, "
                    + "       subsidioasignado.\"subasivalsub\"     AS subsidioasignado_subasivalsub, "
                    + "       subsidioasignado.\"coddepartamento\"  AS subsidioasignado_coddepartamento, "
                    + "       subsidioasignado.\"codmunicipio\"     AS subsidioasignado_codmunicipio, "
                    + "       subsidioasignado.\"subasidescri\"     AS subsidioasignado_subasidescri, "
                    + "       subsidioasignado.\"codbanco\"         AS subsidioasignado_codbanco, "
                    + "       subsidioasignado.\"subasireqedu\"     AS subsidioasignado_subasireqedu, "
                    + "       subsidioasignado.\"subasireqsal\"     AS subsidioasignado_subasireqsal, "
                    + "       subsidioasignado.\"subasiusosub\"     AS subsidioasignado_subasiusosub, "
                    + "       subsidioasignado.\"subasiobserv\"     AS subsidioasignado_subasiobserv, "
                    + "       municipio.\"nombre\"                  AS municipio_nombre, "
                    + "       banco.\"descripcion\"                 AS banco_descripcion, "
                    + "       subsidio.\"subsdescripc\"             AS subsidio_subsdescripc "
                    + "FROM   \"public\".\"banco\" banco "
                    + "       INNER JOIN \"public\".\"subsidioasignado\" subsidioasignado "
                    + "         ON banco.\"codbanco\" = subsidioasignado.\"codbanco\" "
                    + "       INNER JOIN \"public\".\"municipio\" municipio "
                    + "         ON subsidioasignado.\"coddepartamento\" = municipio.\"coddepartamento\" "
                    + "            AND municipio.\"codmunicipio\" = subsidioasignado.\"codmunicipio\" "
                    + "       INNER JOIN \"public\".\"subsidio\" subsidio "
                    + "         ON subsidioasignado.\"subscodigo\" = subsidio.\"subscodigo\" "
                    + "       INNER JOIN \"public\".\"subsidiopotencial\" subsidiopotencial "
                    + "         ON subsidioasignado.\"codunifami\" = subsidiopotencial.\"codunifami\" "
                    + "            AND subsidiopotencial.\"subpotidenti\" = "
                    + "                subsidioasignado.\"subpotidenti\" "
                    + "            AND subsidiopotencial.\"codtipoidentidad\" = "
                    + "                subsidioasignado.\"codtipoidentidad\" "
                    + "WHERE subsidioasignado.codunifami = '" + dkda.o(sel, "codunifami") + "' "
                    + "AND subsidioasignado.codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' "
                    + "AND subsidioasignado.subpotidenti = '" + dkda.o(sel, "subpotidenti") + "' ";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            
            info += "text|#subasiobserv_subsidioasignado|" + (rs.getString("subsidioasignado_subasiobserv") == null ? ""
                    : rs.getString("subsidioasignado_subasiobserv")) + ":_";
            
            info += "text|#subasidescri_subsidioasignado|" + (rs.getString("subsidioasignado_subasidescri") == null ? ""
                    : rs.getString("subsidioasignado_subasidescri")) + ":_";
            
            info += "switch|switch_subasiusosub_subsidioasignado|" + rs.getString("subsidioasignado_subasiusosub") + ":_";
            
            info += "switch|switch_subasireqsal_subsidioasignado|" + rs.getString("subsidioasignado_subasireqsal") + ":_";
            
            info += "switch|switch_subasireqedu_subsidioasignado|" + rs.getString("subsidioasignado_subasireqedu") + ":_";
            
            info += "combo|#codbanco_subsidioasignado|" + rs.getString("subsidioasignado_codbanco") 
                    + "|llenarCombo('codbanco_subsidioasignado', '"
                    + rs.getString("subsidioasignado_codbanco") + "', '" + rs.getString("banco_descripcion") + "'):_";
            
            info += "combo|#municipio_subsidioasignado_1|" + "municipio   coddepartamento  "
                    + rs.getString("subsidioasignado_coddepartamento") + "   "
                    + "codmunicipio  " + rs.getString("subsidioasignado_codmunicipio")
                    + "|llenarCombo('municipio_subsidioasignado_1', '"
                     + "municipio   coddepartamento  "
                    + rs.getString("subsidioasignado_coddepartamento") + "   "
                    + "codmunicipio  " + rs.getString("subsidioasignado_codmunicipio")
                    + "', '"
                    + rs.getString("municipio_nombre") + "'):_";
            
            info += "text|#subasivalsub_subsidioasignado|" + (rs.getString("subsidioasignado_subasivalsub") == null ? ""
                    : rs.getString("subsidioasignado_subasivalsub")) + ":_";

            info += "combo|#subscodigo_subsidioasignado|" + rs.getString("subsidioasignado_subscodigo") 
                    + "|llenarCombo('subscodigo_subsidioasignado', '"
                    + rs.getString("subsidioasignado_subscodigo") + "', '" + rs.getString("subsidio_subsdescripc") + "'):_";

            info += "text|#_fecha_subasifecfin_subsidioasignado|" + (rs.getString("subsidioasignado_subasifecfin") == null ? ""
                    : rs.getString("subsidioasignado_subasifecfin")) + ":_";

            info += "text|#_fecha_subasifecini_subsidioasignado|" + (rs.getString("subsidioasignado_subasifecini") == null ? ""
                    : rs.getString("subsidioasignado_subasifecini")) + ":_";

            info += "combo|#subsidiopotencial_subsidioasignado_1|" + "subsidiopotencial   codunifami  "
                    + rs.getString("subsidioasignado_codunifami") + "   "
                    + "codtipoidentidad  " + rs.getString("subsidioasignado_codtipoidentidad") + "   subpotidenti  "
                    + rs.getString("subsidioasignado_subpotidenti")
                    + "|llenarCombo('subsidiopotencial_subsidioasignado_1', '"
                    + "subsidiopotencial   codunifami  "
                    + rs.getString("subsidioasignado_codunifami") + "   "
                    + "codtipoidentidad  " + rs.getString("subsidioasignado_codtipoidentidad") + "   subpotidenti  "
                    + rs.getString("subsidioasignado_subpotidenti")
                    + "', '"
                    + rs.getString("subsidioasignado_codunifami") + "'):_";

            respuesta = "opcion=obtener_subsidioasignado&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_subsidioasignado&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error subsidioasignado - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_subsidioasignado() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM subsidioasignado  WHERE"
                    + " codunifami = '" + dkda.o(subsidiopotencial_subsidioasignado_1, "codunifami") + "'" + " AND "
                    + "codtipoidentidad = '" + dkda.o(subsidiopotencial_subsidioasignado_1, "codtipoidentidad") + "'" + " AND "
                    + "subpotidenti = '" + dkda.o(subsidiopotencial_subsidioasignado_1, "subpotidenti") + "'");
            
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_subsidioasignado() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_subsidioasignado() {
        String direccion = "opcion=registrar_subsidioasignado&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_subsidioasignado();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codunifami").toString().equals(dkda.o(subsidiopotencial_subsidioasignado_1, "codunifami")) && 
                    dkda.o(sel, "codtipoidentidad").toString().equals(dkda.o(subsidiopotencial_subsidioasignado_1, "codtipoidentidad")) &&
                    dkda.o(sel, "subpotidenti").toString().equals(dkda.o(subsidiopotencial_subsidioasignado_1, "subpotidenti"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(subsidiopotencial_subsidioasignado_1, "codunifami").isEmpty()) {
            error = "Código Único Familia: no puede ser vacio.";
        } else if (dkda.o(vars, "subasifecini_subsidioasignado").isEmpty()) {
            error = "Fecha Inicial Vigencia Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subasifecfin_subsidioasignado").isEmpty()) {
            error = "Fecha Final Vigencia Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subscodigo_subsidioasignado").isEmpty()) {
            error = "Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subasivalsub_subsidioasignado").isEmpty()) {
            error = "Valor Pago Subsidio: no puede ser vacio.";
        } else if (dkda.o(municipio_subsidioasignado_1, "coddepartamento").isEmpty()) {
            error = "Municipio: no puede ser vacio.";
        } else if (dkda.o(vars, "codbanco_subsidioasignado").isEmpty()) {
            error = "Banco: no puede ser vacio.";
        } else if (dkda.o(vars, "subasireqedu_subsidioasignado").isEmpty()) {
            error = "Cumple Requisito Educación (S/N): no puede ser vacio.";
        } else if (dkda.o(vars, "subasireqsal_subsidioasignado").isEmpty()) {
            error = "Cumple Requisito Salud (S/N): no puede ser vacio.";
        } else if (dkda.o(vars, "subasiusosub_subsidioasignado").isEmpty()) {
            error = "Uso Subsidio (S/N): no puede ser vacio.";
        } else if (dkda.o(vars, "subasidescri_subsidioasignado").isEmpty()) {
            error = "Descripción Subsidio Asignado: no puede ser vacio.";
        } else if (dkda.o(vars, "subasiobserv_subsidioasignado").isEmpty()) {
            error = "Observaciones Subsidio Asignado: no puede ser vacio.";
        } else if (!v.numDecimal(dkda.o(vars, "subasivalsub_subsidioasignado"))) {
            error = "Valor Pago Subsidio: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "subasireqedu_subsidioasignado").length() > 1) {
            error = "Cumple Requisito Educación (S/N): Valor demasiado Largo.";
        } else if (dkda.o(vars, "subasireqsal_subsidioasignado").length() > 1) {
            error = "Cumple Requisito Salud (S/N): Valor demasiado Largo.";
        } else if (dkda.o(vars, "subasiusosub_subsidioasignado").length() > 1) {
            error = "Uso Subsidio (S/N): Valor demasiado Largo.";
        } else if (dkda.o(vars, "subasidescri_subsidioasignado").length() > 50) {
            error = "Descripción Subsidio Asignado: Valor demasiado Largo.";
        } else if (dkda.o(vars, "subasiobserv_subsidioasignado").length() > 400) {
            error = "Observaciones Subsidio Asignado: Valor demasiado Largo.";
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