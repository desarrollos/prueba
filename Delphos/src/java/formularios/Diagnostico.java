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

public class Diagnostico extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, subgrupodiagnostico_diagnostico_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());



        subgrupodiagnostico_diagnostico_1 = fun.map(dkda.o(vars, "subgrupodiagnostico_diagnostico_1").toString());
        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_diagnostico();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_diagnostico(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_diagnostico(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_diagnostico(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_diagnostico(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_diagnostico(ConexionBaseDatos con) {
        System.out.println("registrar_diagnostico");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO diagnostico (coddiagnostico,descripcion,coddiag298,coddiagnostico3char,codnivelcomplejidad,codclasediagnostico,codambitodiagnostico,codeventoepidem,codprotocodiagn,codmanualdiagnostico,codgrupodiagn,codsubgrupodiagn,codigoalterno,codigorips,costo,permitehombre,permitemujer,senotifica,diagnutricion,tiempotratamiento,tarifasmdlv,numerouvr,codigobarras,fechacreacion,ususiscodigo,fecharegistro,essaludpublica) VALUES (" + (dkda.o(vars, "coddiagnostico_diagnostico").equals("") ? null : "'" + dkda.o(vars, "coddiagnostico_diagnostico") + "'") + "," + (dkda.o(vars, "descripcion_diagnostico").equals("") ? null : "'" + dkda.o(vars, "descripcion_diagnostico") + "'") + "," + (dkda.o(vars, "coddiag298_diagnostico").equals("") ? null : "'" + dkda.o(vars, "coddiag298_diagnostico") + "'") + "," + (dkda.o(vars, "coddiagnostico3char_diagnostico").equals("") ? null : "'" + dkda.o(vars, "coddiagnostico3char_diagnostico") + "'") + "," + (dkda.o(vars, "codnivelcomplejidad_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codnivelcomplejidad_diagnostico") + "'") + "," + (dkda.o(vars, "codclasediagnostico_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codclasediagnostico_diagnostico") + "'") + "," + (dkda.o(vars, "codambitodiagnostico_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codambitodiagnostico_diagnostico") + "'") + "," + (dkda.o(vars, "codeventoepidem_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codeventoepidem_diagnostico") + "'") + "," + (dkda.o(vars, "codprotocodiagn_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codprotocodiagn_diagnostico") + "'") + "," + (dkda.o(vars, "codmanualdiagnostico_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codmanualdiagnostico_diagnostico") + "'") + "," + (dkda.o(subgrupodiagnostico_diagnostico_1, "codgrupodiagn").equals("") ? null : "'" + dkda.o(subgrupodiagnostico_diagnostico_1, "codgrupodiagn") + "'") + "," + (dkda.o(subgrupodiagnostico_diagnostico_1, "codsubgrupodiagn").equals("") ? null : "'" + dkda.o(subgrupodiagnostico_diagnostico_1, "codsubgrupodiagn") + "'") + "," + (dkda.o(vars, "codigoalterno_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codigoalterno_diagnostico") + "'") + "," + (dkda.o(vars, "codigorips_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codigorips_diagnostico") + "'") + "," + (dkda.o(vars, "costo_diagnostico").equals("") ? null : dkda.o(vars, "costo_diagnostico")) + "," + (dkda.o(vars, "permitehombre_diagnostico").equals("") ? null : "'" + dkda.o(vars, "permitehombre_diagnostico") + "'") + "," + (dkda.o(vars, "permitemujer_diagnostico").equals("") ? null : "'" + dkda.o(vars, "permitemujer_diagnostico") + "'") + "," + (dkda.o(vars, "senotifica_diagnostico").equals("") ? null : "'" + dkda.o(vars, "senotifica_diagnostico") + "'") + "," + (dkda.o(vars, "diagnutricion_diagnostico").equals("") ? null : "'" + dkda.o(vars, "diagnutricion_diagnostico") + "'") + "," + (dkda.o(vars, "tiempotratamiento_diagnostico").equals("") ? null : dkda.o(vars, "tiempotratamiento_diagnostico")) + "," + (dkda.o(vars, "tarifasmdlv_diagnostico").equals("") ? null : dkda.o(vars, "tarifasmdlv_diagnostico")) + "," + (dkda.o(vars, "numerouvr_diagnostico").equals("") ? null : dkda.o(vars, "numerouvr_diagnostico")) + "," + (dkda.o(vars, "codigobarras_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codigobarras_diagnostico") + "'") + "," + (dkda.o(vars, "fechacreacion_diagnostico").equals("") ? null : "'" + dkda.o(vars, "fechacreacion_diagnostico") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "essaludpublica_diagnostico").equals("") ? null : "'" + dkda.o(vars, "essaludpublica_diagnostico") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_diagnostico&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_diagnostico&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error diagnostico.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_diagnostico(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE diagnostico SET coddiagnostico = " + (dkda.o(vars, "coddiagnostico_diagnostico").equals("") ? null : "'" + dkda.o(vars, "coddiagnostico_diagnostico") + "'") + ",descripcion = " + (dkda.o(vars, "descripcion_diagnostico").equals("") ? null : "'" + dkda.o(vars, "descripcion_diagnostico") + "'") + ",coddiag298 = " + (dkda.o(vars, "coddiag298_diagnostico").equals("") ? null : "'" + dkda.o(vars, "coddiag298_diagnostico") + "'") + ",coddiagnostico3char = " + (dkda.o(vars, "coddiagnostico3char_diagnostico").equals("") ? null : "'" + dkda.o(vars, "coddiagnostico3char_diagnostico") + "'") + ",codnivelcomplejidad = " + (dkda.o(vars, "codnivelcomplejidad_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codnivelcomplejidad_diagnostico") + "'") + ",codclasediagnostico = " + (dkda.o(vars, "codclasediagnostico_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codclasediagnostico_diagnostico") + "'") + ",codambitodiagnostico = " + (dkda.o(vars, "codambitodiagnostico_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codambitodiagnostico_diagnostico") + "'") + ",codeventoepidem = " + (dkda.o(vars, "codeventoepidem_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codeventoepidem_diagnostico") + "'") + ",codprotocodiagn = " + (dkda.o(vars, "codprotocodiagn_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codprotocodiagn_diagnostico") + "'") + ",codmanualdiagnostico = " + (dkda.o(vars, "codmanualdiagnostico_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codmanualdiagnostico_diagnostico") + "'") + ",codgrupodiagn = " + (dkda.o(subgrupodiagnostico_diagnostico_1, "codgrupodiagn").equals("") ? null : "'" + dkda.o(subgrupodiagnostico_diagnostico_1, "codgrupodiagn") + "'") + ",codsubgrupodiagn = " + (dkda.o(subgrupodiagnostico_diagnostico_1, "codsubgrupodiagn").equals("") ? null : "'" + dkda.o(subgrupodiagnostico_diagnostico_1, "codsubgrupodiagn") + "'") + ",codigoalterno = " + (dkda.o(vars, "codigoalterno_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codigoalterno_diagnostico") + "'") + ",codigorips = " + (dkda.o(vars, "codigorips_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codigorips_diagnostico") + "'") + ",costo = " + (dkda.o(vars, "costo_diagnostico").equals("") ? null : dkda.o(vars, "costo_diagnostico")) + ",permitehombre = " + (dkda.o(vars, "permitehombre_diagnostico").equals("") ? null : "'" + dkda.o(vars, "permitehombre_diagnostico") + "'") + ",permitemujer = " + (dkda.o(vars, "permitemujer_diagnostico").equals("") ? null : "'" + dkda.o(vars, "permitemujer_diagnostico") + "'") + ",senotifica = " + (dkda.o(vars, "senotifica_diagnostico").equals("") ? null : "'" + dkda.o(vars, "senotifica_diagnostico") + "'") + ",diagnutricion = " + (dkda.o(vars, "diagnutricion_diagnostico").equals("") ? null : "'" + dkda.o(vars, "diagnutricion_diagnostico") + "'") + ",tiempotratamiento = " + (dkda.o(vars, "tiempotratamiento_diagnostico").equals("") ? null : dkda.o(vars, "tiempotratamiento_diagnostico")) + ",tarifasmdlv = " + (dkda.o(vars, "tarifasmdlv_diagnostico").equals("") ? null : dkda.o(vars, "tarifasmdlv_diagnostico")) + ",numerouvr = " + (dkda.o(vars, "numerouvr_diagnostico").equals("") ? null : dkda.o(vars, "numerouvr_diagnostico")) + ",codigobarras = " + (dkda.o(vars, "codigobarras_diagnostico").equals("") ? null : "'" + dkda.o(vars, "codigobarras_diagnostico") + "'") + ",fechacreacion = " + (dkda.o(vars, "fechacreacion_diagnostico").equals("") ? null : "'" + dkda.o(vars, "fechacreacion_diagnostico") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",essaludpublica = " + (dkda.o(vars, "essaludpublica_diagnostico").equals("") ? null : "'" + dkda.o(vars, "essaludpublica_diagnostico") + "'") + " WHERE coddiagnostico = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_diagnostico&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_diagnostico&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error diagnostico.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_diagnostico(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM diagnostico WHERE coddiagnostico = '" + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_diagnostico&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_diagnostico&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error diagnostico.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_diagnostico(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "diagnostico.coddiagnostico AS diagnostico_coddiagnostico,"
                    + "diagnostico.descripcion AS diagnostico_descripcion,"
                    + "diagnostico.coddiag298 AS diagnostico_coddiag298,"
                    + "diagnostico.coddiagnostico3char AS diagnostico_coddiagnostico3char,"
                    + "diagnostico.codnivelcomplejidad AS diagnostico_codnivelcomplejidad,"
                    + "diagnostico.codclasediagnostico AS diagnostico_codclasediagnostico,"
                    + "diagnostico.codambitodiagnostico AS diagnostico_codambitodiagnostico,"
                    + "diagnostico.codeventoepidem AS diagnostico_codeventoepidem,"
                    + "diagnostico.codprotocodiagn AS diagnostico_codprotocodiagn,"
                    + "diagnostico.codmanualdiagnostico AS diagnostico_codmanualdiagnostico,"
                    + "diagnostico.codgrupodiagn AS diagnostico_codgrupodiagn,"
                    + "diagnostico.codsubgrupodiagn AS diagnostico_codsubgrupodiagn,"
                    + "diagnostico.codigoalterno AS diagnostico_codigoalterno,"
                    + "diagnostico.codigorips AS diagnostico_codigorips,"
                    + "diagnostico.costo AS diagnostico_costo,"
                    + "diagnostico.permitehombre AS diagnostico_permitehombre,"
                    + "diagnostico.permitemujer AS diagnostico_permitemujer,"
                    + "diagnostico.senotifica AS diagnostico_senotifica,"
                    + "diagnostico.diagnutricion AS diagnostico_diagnutricion,"
                    + "diagnostico.tiempotratamiento AS diagnostico_tiempotratamiento,"
                    + "diagnostico.tarifasmdlv AS diagnostico_tarifasmdlv,"
                    + "diagnostico.numerouvr AS diagnostico_numerouvr,"
                    + "diagnostico.codigobarras AS diagnostico_codigobarras,"
                    + "diagnostico.fechacreacion AS diagnostico_fechacreacion,"
                    + "diagnostico.essaludpublica AS diagnostico_essaludpublica,"
                    + "eventoepidemiologico.descripcion AS eventoepidemiologico_descripcion,"
                    + "manualdiagnostico.descripcion AS manualdiagnostico_descripcion,"
                    + "nivelcomplejidad.descripcion AS nivelcomplejidad_descripcion,"
                    + "protocolodiagnostico.descripcion AS protocolodiagnostico_descripcion,"
                    + "ambitodiagnostico.descripcion AS ambitodiagnostico_descripcion,"
                    + "subgrupodiagnostico.descripcion AS subgrupodiagnostico_descripcion,"
                    + "clasediagnostico.descripcion AS clasediagnostico_descripcion,"
                    + "diagnostico298.descripcion AS diagnostico298_descripcion,"
                    + "diagnostico3char.descripcion AS diagnostico3char_descripcion "
                    + " FROM "
                    + " public.ambitodiagnostico ambitodiagnostico INNER JOIN public.diagnostico diagnostico ON ambitodiagnostico.codambitodiagnostico = diagnostico.codambitodiagnostico "
                    + " INNER JOIN public.clasediagnostico clasediagnostico ON diagnostico.codclasediagnostico = clasediagnostico.codclasediagnostico "
                    + " INNER JOIN public.diagnostico298 diagnostico298 ON diagnostico.coddiag298 = diagnostico298.coddiag298 "
                    + " INNER JOIN public.diagnostico3char diagnostico3char ON diagnostico.coddiagnostico3char = diagnostico3char.coddiagnostico3char "
                    + " INNER JOIN public.eventoepidemiologico eventoepidemiologico ON diagnostico.codeventoepidem = eventoepidemiologico.codeventoepidem "
                    + " INNER JOIN public.manualdiagnostico manualdiagnostico ON diagnostico.codmanualdiagnostico = manualdiagnostico.codmanualdiagnostico "
                    + " INNER JOIN public.nivelcomplejidad nivelcomplejidad ON diagnostico.codnivelcomplejidad = nivelcomplejidad.codnivelcomplejidad "
                    + " INNER JOIN public.protocolodiagnostico protocolodiagnostico ON diagnostico.codprotocodiagn = protocolodiagnostico.codprotocodiagn "
                    + " INNER JOIN public.subgrupodiagnostico subgrupodiagnostico ON diagnostico.codgrupodiagn = subgrupodiagnostico.codgrupodiagn "
                    + " AND subgrupodiagnostico.codsubgrupodiagn = diagnostico.codsubgrupodiagn WHERE coddiagnostico = '" + dkda.o(vars, "codigo") + "' ";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            
            info += "text|#essaludpublica_diagnostico|" + (rs.getString("diagnostico_essaludpublica") == null ? "" : rs.getString("diagnostico_essaludpublica")) + ":_";
            
            info += "text|#_fecha_fechacreacion_diagnostico|" + (rs.getString("diagnostico_fechacreacion") == null ? "" : rs.getString("diagnostico_fechacreacion")) + ":_";
            
            info += "text|#codigobarras_diagnostico|" + (rs.getString("diagnostico_codigobarras") == null ? "" : rs.getString("diagnostico_codigobarras")) + ":_";
            
            info += "text|#numerouvr_diagnostico|" + (rs.getString("diagnostico_numerouvr") == null ? "" : rs.getString("diagnostico_numerouvr")) + ":_";
            
            info += "text|#tarifasmdlv_diagnostico|" + (rs.getString("diagnostico_tarifasmdlv") == null ? "" : rs.getString("diagnostico_tarifasmdlv")) + ":_";
            
            info += "text|#tiempotratamiento_diagnostico|" + (rs.getString("diagnostico_tiempotratamiento") == null ? "" : rs.getString("diagnostico_tiempotratamiento")) + ":_";
            
            info += "text|#diagnutricion_diagnostico|" + (rs.getString("diagnostico_diagnutricion") == null ? "" : rs.getString("diagnostico_diagnutricion")) + ":_";
            
            info += "text|#senotifica_diagnostico|" + (rs.getString("diagnostico_senotifica") == null ? "" : rs.getString("diagnostico_senotifica")) + ":_";
            
            info += "switch|switch_permitemujer_diagnostico|" + rs.getString("diagnostico_permitemujer") + ":_";
            
            info += "switch|switch_permitehombre_diagnostico|" + rs.getString("diagnostico_permitehombre") + ":_";

            info += "text|#costo_diagnostico|" + (rs.getString("diagnostico_costo") == null ? "" : rs.getString("diagnostico_costo")) + ":_";
            
            info += "text|#codigorips_diagnostico|" + (rs.getString("diagnostico_codigorips") == null ? "" : rs.getString("diagnostico_codigorips")) + ":_";
            
            info += "text|#codigoalterno_diagnostico|" + (rs.getString("diagnostico_codigoalterno") == null ? "" : rs.getString("diagnostico_codigoalterno")) + ":_";


            info += "combo|#subgrupodiagnostico_diagnostico_1|" + "subgrupodiagnostico   codgrupodiagn  " + rs.getString("diagnostico_codgrupodiagn")
                    + "   codsubgrupodiagn  " + rs.getString("diagnostico_codsubgrupodiagn") + "|llenarCombo('subgrupodiagnostico_diagnostico_1', '"
                    + "subgrupodiagnostico   codgrupodiagn  " + rs.getString("diagnostico_codgrupodiagn")
                    + "   codsubgrupodiagn  " + rs.getString("diagnostico_codsubgrupodiagn") + "', '" + rs.getString("subgrupodiagnostico_descripcion") + "'):_";


            info += "combo|#codmanualdiagnostico_diagnostico|"
                    + rs.getString("diagnostico_codmanualdiagnostico") + "|llenarCombo('codmanualdiagnostico_diagnostico', '"
                    + rs.getString("diagnostico_codmanualdiagnostico") + "', '" + rs.getString("manualdiagnostico_descripcion") + "'):_";

            info += "combo|#codprotocodiagn_diagnostico|"
                    + rs.getString("diagnostico_codprotocodiagn") + "|llenarCombo('codprotocodiagn_diagnostico', '"
                    + rs.getString("diagnostico_codprotocodiagn") + "', '" + rs.getString("protocolodiagnostico_descripcion") + "'):_";

            info += "combo|#codeventoepidem_diagnostico|"
                    + rs.getString("diagnostico_codeventoepidem") + "|llenarCombo('codeventoepidem_diagnostico', '"
                    + rs.getString("diagnostico_codeventoepidem") + "', '" + rs.getString("eventoepidemiologico_descripcion") + "'):_";

            info += "combo|#codambitodiagnostico_diagnostico|"
                    + rs.getString("diagnostico_codambitodiagnostico") + "|llenarCombo('codambitodiagnostico_diagnostico', '"
                    + rs.getString("diagnostico_codambitodiagnostico") + "', '" + rs.getString("ambitodiagnostico_descripcion") + "'):_";

            info += "combo|#codclasediagnostico_diagnostico|"
                    + rs.getString("diagnostico_codclasediagnostico") + "|llenarCombo('codclasediagnostico_diagnostico', '"
                    + rs.getString("diagnostico_codclasediagnostico") + "', '" + rs.getString("clasediagnostico_descripcion") + "'):_";


            info += "text|#coddiagnostico_diagnostico|" + (rs.getString("diagnostico_coddiagnostico") == null ? "" : rs.getString("diagnostico_coddiagnostico")) + ":_";

            info += "text|#descripcion_diagnostico|" + (rs.getString("diagnostico_descripcion") == null ? "" : rs.getString("diagnostico_descripcion")) + ":_";


            info += "combo|#coddiag298_diagnostico|"
                    + rs.getString("diagnostico_coddiag298") + "|llenarCombo('coddiag298_diagnostico', '"
                    + rs.getString("diagnostico_coddiag298") + "', '" + rs.getString("diagnostico298_descripcion") + "'):_";

            info += "combo|#coddiagnostico3char_diagnostico|"
                    + rs.getString("diagnostico_coddiagnostico3char") + "|llenarCombo('coddiagnostico3char_diagnostico', '"
                    + rs.getString("diagnostico_coddiagnostico3char") + "', '" + rs.getString("diagnostico3char_descripcion") + "'):_";

            info += "combo|#codnivelcomplejidad_diagnostico|"
                    + rs.getString("diagnostico_codnivelcomplejidad") + "|llenarCombo('codnivelcomplejidad_diagnostico', '"
                    + rs.getString("diagnostico_codnivelcomplejidad") + "', '" + rs.getString("nivelcomplejidad_descripcion") + "'):_";

            respuesta = "opcion=obtener_diagnostico&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_diagnostico&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error diagnostico - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_diagnostico() {
        String direccion = "opcion=registrar_diagnostico&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_diagnostico();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "coddiagnostico").toString().equals(dkda.o(vars, "coddiagnostico_diagnostico"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "coddiagnostico_diagnostico").isEmpty()) {
            error = "Codigo Diagnostico: no puede ser vacio.";
        } else if (dkda.o(vars, "descripcion_diagnostico").isEmpty()) {
            error = "Descripcion: no puede ser vacio.";
        } else if (dkda.o(vars, "coddiag298_diagnostico").isEmpty()) {
            error = "Codigo Diagnostico 298: no puede ser vacio.";
        } else if (dkda.o(vars, "coddiagnostico3char_diagnostico").isEmpty()) {
            error = "Codigo Diagnostico 3 Caracteres: no puede ser vacio.";
        } else if (dkda.o(vars, "codnivelcomplejidad_diagnostico").isEmpty()) {
            error = "Codigo Nivel Complejidad: no puede ser vacio.";
        } else if (dkda.o(vars, "codclasediagnostico_diagnostico").isEmpty()) {
            error = "Codigo Clase Diagnóstico: no puede ser vacio.";
        } else if (dkda.o(vars, "codambitodiagnostico_diagnostico").isEmpty()) {
            error = "Codigo Ambito Diagnostico: no puede ser vacio.";
        } else if (dkda.o(vars, "codeventoepidem_diagnostico").isEmpty()) {
            error = "Codigo Evento Epidemiologico: no puede ser vacio.";
        } else if (dkda.o(vars, "codprotocodiagn_diagnostico").isEmpty()) {
            error = "Codigo Protocolo Diagnostico: no puede ser vacio.";
        } else if (dkda.o(vars, "codmanualdiagnostico_diagnostico").isEmpty()) {
            error = "Codigo Manual Diagnostico: no puede ser vacio.";
        } else if (dkda.o(vars, "subgrupodiagnostico_diagnostico_1").isEmpty()) {
            error = "Codigo Sub Grupo Dianostico: no puede ser vacio.";
        } else if (dkda.o(vars, "codigoalterno_diagnostico").isEmpty()) {
            error = "Codigo Alterno Codigo Diagnostico: no puede ser vacio.";
        } else if (dkda.o(vars, "codigorips_diagnostico").isEmpty()) {
            error = "Codigo Diagnostico RIPS: no puede ser vacio.";
        } else if (dkda.o(vars, "costo_diagnostico").isEmpty()) {
            error = "Costo Diagnostico: no puede ser vacio.";
        } else if (dkda.o(vars, "permitehombre_diagnostico").isEmpty()) {
            error = "Diagnostico Permitido Sexo Masculino: no puede ser vacio.";
        } else if (dkda.o(vars, "permitemujer_diagnostico").isEmpty()) {
            error = "Diagnostico Permitido Sexo Femenino: no puede ser vacio.";
        } else if (dkda.o(vars, "senotifica_diagnostico").isEmpty()) {
            error = "Diagnostico Notificacion: no puede ser vacio.";
        } else if (dkda.o(vars, "diagnutricion_diagnostico").isEmpty()) {
            error = "Diagn&oacute;stico Nutrici&oacute;n: no puede ser vacio.";
        } else if (dkda.o(vars, "tiempotratamiento_diagnostico").isEmpty()) {
            error = "Tiempo Tratamiento: no puede ser vacio.";
        } else if (dkda.o(vars, "tarifasmdlv_diagnostico").isEmpty()) {
            error = "Tarifa Salarios Minimos Diarios Legales Vigentes: no puede ser vacio.";
        } else if (dkda.o(vars, "numerouvr_diagnostico").isEmpty()) {
            error = "Numero UVRs: no puede ser vacio.";
        } else if (dkda.o(vars, "codigobarras_diagnostico").isEmpty()) {
            error = "Codigo Barras: no puede ser vacio.";
        } else if (dkda.o(vars, "fechacreacion_diagnostico").isEmpty()) {
            error = "Fecha Creacion: no puede ser vacio.";
        } else if (dkda.o(vars, "essaludpublica_diagnostico").isEmpty()) {
            error = "Evento Salud Publ&iacute;ca: no puede ser vacio.";
        } else if (!v.alfaNumericos(dkda.o(vars, "coddiagnostico_diagnostico"))) {
            error = "Codigo Diagnostico: Tiene Caracteres no permitidos.";
        } else if (!v.alfaNumericos(dkda.o(vars, "codigoalterno_diagnostico"))) {
            error = "Codigo Alterno Codigo Diagnostico: Tiene Caracteres no permitidos.";
        } else if (!v.alfaNumericos(dkda.o(vars, "codigorips_diagnostico"))) {
            error = "Codigo Diagnostico RIPS: Tiene Caracteres no permitidos.";
        } else if (!v.numDecimal(dkda.o(vars, "costo_diagnostico"))) {
            error = "Costo Diagnostico: Tiene Caracteres no permitidos.";
        } else if (!v.numDecimal(dkda.o(vars, "tiempotratamiento_diagnostico"))) {
            error = "Tiempo Tratamiento: Tiene Caracteres no permitidos.";
        } else if (!v.numDecimal(dkda.o(vars, "tarifasmdlv_diagnostico"))) {
            error = "Tarifa Salarios Minimos Diarios Legales Vigentes: Tiene Caracteres no permitidos.";
        } else if (!v.numDecimal(dkda.o(vars, "numerouvr_diagnostico"))) {
            error = "Numero UVRs: Tiene Caracteres no permitidos.";
        } else if (!v.alfaNumericos(dkda.o(vars, "codigobarras_diagnostico"))) {
            error = "Codigo Barras: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "coddiagnostico_diagnostico").length() > 6) {
            error = "Codigo Diagnostico: Valor demasiado Largo.";
        } else if (dkda.o(vars, "descripcion_diagnostico").length() > 220) {
            error = "Descripcion: Valor demasiado Largo.";
        } else if (dkda.o(vars, "codigoalterno_diagnostico").length() > 10) {
            error = "Codigo Alterno Codigo Diagnostico: Valor demasiado Largo.";
        } else if (dkda.o(vars, "codigorips_diagnostico").length() > 10) {
            error = "Codigo Diagnostico RIPS: Valor demasiado Largo.";
        } else if (dkda.o(vars, "costo_diagnostico").length() > 12) {
            error = "Costo Diagnostico: Valor demasiado Largo.";
        } else if (dkda.o(vars, "permitehombre_diagnostico").length() > 1) {
            error = "Diagnostico Permitido Sexo Masculino: Valor demasiado Largo.";
        } else if (dkda.o(vars, "permitemujer_diagnostico").length() > 1) {
            error = "Diagnostico Permitido Sexo Femenino: Valor demasiado Largo.";
        } else if (dkda.o(vars, "senotifica_diagnostico").length() > 1) {
            error = "Diagnostico Notificacion: Valor demasiado Largo.";
        } else if (dkda.o(vars, "diagnutricion_diagnostico").length() > 1) {
            error = "Diagn&oacute;stico Nutrici&oacute;n: Valor demasiado Largo.";
        } else if (dkda.o(vars, "tiempotratamiento_diagnostico").length() > 5) {
            error = "Tiempo Tratamiento: Valor demasiado Largo.";
        } else if (dkda.o(vars, "tarifasmdlv_diagnostico").length() > 10) {
            error = "Tarifa Salarios Minimos Diarios Legales Vigentes: Valor demasiado Largo.";
        } else if (dkda.o(vars, "numerouvr_diagnostico").length() > 5) {
            error = "Numero UVRs: Valor demasiado Largo.";
        } else if (dkda.o(vars, "codigobarras_diagnostico").length() > 75) {
            error = "Codigo Barras: Valor demasiado Largo.";
        } else if (dkda.o(vars, "essaludpublica_diagnostico").length() > 1) {
            error = "Evento Salud Publ&iacute;ca: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }// 

    private boolean existe_diagnostico() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM diagnostico  WHERE coddiagnostico = '" + dkda.o(vars, "coddiagnostico") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_diagnostico() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
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