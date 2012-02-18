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

public class ActividadSalud extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, subgrupoactividad_actividadsalud_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());

        subgrupoactividad_actividadsalud_1 = fun.map(dkda.o(vars, "subgrupoactividad_actividadsalud_1").toString());
        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_actividadsalud();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_actividadsalud(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_actividadsalud(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_actividadsalud(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_actividadsalud(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_actividadsalud(ConexionBaseDatos con) {
        System.out.println("registrar_actividadsalud");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO actividadsalud (codactividadsalud,descripcion,observacion,codgrupoactividad,codsubgrupo,codambito,"
                    + "codclaseactividad,codconceptoservicio,codtipoactividad,codcategactividad,codprotocolo,codmanualactividad,codnivelcomplejidad,"
                    + "codigoalterno,codigorips,costo,cantidadmaxautorizar,resultadofinal,codigobarras,permitehombre,permitemujer,tiempoaprox,"
                    + "tarifasmlv,cantidaduvr,ususiscodigo,fecharegistro) VALUES "
                    + "(" + (dkda.o(vars, "codactividadsalud_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codactividadsalud_actividadsalud") 
                    + "'") + "," + (dkda.o(vars, "descripcion_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "descripcion_actividadsalud") + "'") 
                    + "," + (dkda.o(vars, "observacion_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "observacion_actividadsalud") + "'") + "," 
                    
                    + (dkda.o(vars, "codgrupoactividad_actividadsalud").equals("") ? null : dkda.o(vars, "codgrupoactividad_actividadsalud")) + "," + 
                    (dkda.o(subgrupoactividad_actividadsalud_1, "codsubgrupo").equals("") ? null : "'" + dkda.o(subgrupoactividad_actividadsalud_1, "codsubgrupo") + "'") + "," + (dkda.o(vars, "codambito_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codambito_actividadsalud") + "'") + "," + (dkda.o(vars, "codclaseactividad_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codclaseactividad_actividadsalud") + "'") + "," + (dkda.o(vars, "codconceptoservicio_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codconceptoservicio_actividadsalud") + "'") + "," + (dkda.o(vars, "codtipoactividad_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codtipoactividad_actividadsalud") + "'") + "," + (dkda.o(vars, "codcategactividad_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codcategactividad_actividadsalud") + "'") + "," + (dkda.o(vars, "codprotocolo_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codprotocolo_actividadsalud") + "'") + "," + (dkda.o(vars, "codmanualactividad_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codmanualactividad_actividadsalud") + "'") + "," + (dkda.o(vars, "codnivelcomplejidad_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codnivelcomplejidad_actividadsalud") + "'") + "," + (dkda.o(vars, "codigoalterno_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codigoalterno_actividadsalud") + "'") + "," + (dkda.o(vars, "codigorips_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codigorips_actividadsalud") + "'") + "," + (dkda.o(vars, "costo_actividadsalud").equals("") ? null : dkda.o(vars, "costo_actividadsalud")) + "," + (dkda.o(vars, "cantidadmaxautorizar_actividadsalud").equals("") ? null : dkda.o(vars, "cantidadmaxautorizar_actividadsalud")) + "," + (dkda.o(vars, "resultadofinal_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "resultadofinal_actividadsalud") + "'") + "," + (dkda.o(vars, "codigobarras_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codigobarras_actividadsalud") + "'") + "," + (dkda.o(vars, "permitehombre_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "permitehombre_actividadsalud") + "'") + "," + (dkda.o(vars, "permitemujer_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "permitemujer_actividadsalud") + "'") + "," + (dkda.o(vars, "tiempoaprox_actividadsalud").equals("") ? null : dkda.o(vars, "tiempoaprox_actividadsalud")) + "," + (dkda.o(vars, "tarifasmlv_actividadsalud").equals("") ? null : dkda.o(vars, "tarifasmlv_actividadsalud")) + "," + (dkda.o(vars, "cantidaduvr_actividadsalud").equals("") ? null : dkda.o(vars, "cantidaduvr_actividadsalud")) + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_actividadsalud&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_actividadsalud&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error actividadsalud.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_actividadsalud(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE actividadsalud SET codactividadsalud = " + (dkda.o(vars, "codactividadsalud_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codactividadsalud_actividadsalud") + "'") + ",descripcion = " + (dkda.o(vars, "descripcion_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "descripcion_actividadsalud") + "'") + ",observacion = " + (dkda.o(vars, "observacion_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "observacion_actividadsalud") + "'") + ",codgrupoactividad = " + (dkda.o(vars, "codgrupoactividad_actividadsalud").equals("") ? null : dkda.o(vars, "codgrupoactividad_actividadsalud")) + ",codsubgrupo = " + (dkda.o(subgrupoactividad_actividadsalud_1, "codsubgrupo").equals("") ? null : "'" + dkda.o(subgrupoactividad_actividadsalud_1, "codsubgrupo") + "'") + ",codambito = " + (dkda.o(vars, "codambito_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codambito_actividadsalud") + "'") + ",codclaseactividad = " + (dkda.o(vars, "codclaseactividad_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codclaseactividad_actividadsalud") + "'") + ",codconceptoservicio = " + (dkda.o(vars, "codconceptoservicio_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codconceptoservicio_actividadsalud") + "'") + ",codtipoactividad = " + (dkda.o(vars, "codtipoactividad_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codtipoactividad_actividadsalud") + "'") + ",codcategactividad = " + (dkda.o(vars, "codcategactividad_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codcategactividad_actividadsalud") + "'") + ",codprotocolo = " + (dkda.o(vars, "codprotocolo_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codprotocolo_actividadsalud") + "'") + ",codmanualactividad = " + (dkda.o(vars, "codmanualactividad_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codmanualactividad_actividadsalud") + "'") + ",codnivelcomplejidad = " + (dkda.o(vars, "codnivelcomplejidad_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codnivelcomplejidad_actividadsalud") + "'") + ",codigoalterno = " + (dkda.o(vars, "codigoalterno_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codigoalterno_actividadsalud") + "'") + ",codigorips = " + (dkda.o(vars, "codigorips_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codigorips_actividadsalud") + "'") + ",costo = " + (dkda.o(vars, "costo_actividadsalud").equals("") ? null : dkda.o(vars, "costo_actividadsalud")) + ",cantidadmaxautorizar = " + (dkda.o(vars, "cantidadmaxautorizar_actividadsalud").equals("") ? null : dkda.o(vars, "cantidadmaxautorizar_actividadsalud")) + ",resultadofinal = " + (dkda.o(vars, "resultadofinal_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "resultadofinal_actividadsalud") + "'") + ",codigobarras = " + (dkda.o(vars, "codigobarras_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "codigobarras_actividadsalud") + "'") + ",permitehombre = " + (dkda.o(vars, "permitehombre_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "permitehombre_actividadsalud") + "'") + ",permitemujer = " + (dkda.o(vars, "permitemujer_actividadsalud").equals("") ? null : "'" + dkda.o(vars, "permitemujer_actividadsalud") + "'") + ",tiempoaprox = " + (dkda.o(vars, "tiempoaprox_actividadsalud").equals("") ? null : dkda.o(vars, "tiempoaprox_actividadsalud")) + ",tarifasmlv = " + (dkda.o(vars, "tarifasmlv_actividadsalud").equals("") ? null : dkda.o(vars, "tarifasmlv_actividadsalud")) + ",cantidaduvr = " + (dkda.o(vars, "cantidaduvr_actividadsalud").equals("") ? null : dkda.o(vars, "cantidaduvr_actividadsalud")) + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codactividadsalud = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_actividadsalud&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_actividadsalud&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error actividadsalud.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_actividadsalud(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM actividadsalud WHERE codactividadsalud = '" + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_actividadsalud&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_actividadsalud&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error actividadsalud.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_actividadsalud(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "actividadsalud.codactividadsalud AS actividadsalud_codactividadsalud,"
                    + "actividadsalud.descripcion AS actividadsalud_descripcion,"
                    + "actividadsalud.observacion AS actividadsalud_observacion,"
                    + "actividadsalud.codgrupoactividad AS actividadsalud_codgrupoactividad,"
                    + "actividadsalud.codsubgrupo AS actividadsalud_codsubgrupo,"
                    + "actividadsalud.codambito AS actividadsalud_codambito,"
                    + "actividadsalud.codclaseactividad AS actividadsalud_codclaseactividad,"
                    + "actividadsalud.codconceptoservicio AS actividadsalud_codconceptoservicio,"
                    + "actividadsalud.codtipoactividad AS actividadsalud_codtipoactividad,"
                    + "actividadsalud.codcategactividad AS actividadsalud_codcategactividad,"
                    + "actividadsalud.codprotocolo AS actividadsalud_codprotocolo,"
                    + "actividadsalud.codmanualactividad AS actividadsalud_codmanualactividad,"
                    + "actividadsalud.codnivelcomplejidad AS actividadsalud_codnivelcomplejidad,"
                    + "actividadsalud.codigoalterno AS actividadsalud_codigoalterno,"
                    + "actividadsalud.codigorips AS actividadsalud_codigorips,"
                    + "actividadsalud.costo AS actividadsalud_costo,"
                    + "actividadsalud.cantidadmaxautorizar AS actividadsalud_cantidadmaxautorizar,"
                    + "actividadsalud.resultadofinal AS actividadsalud_resultadofinal,"
                    + "actividadsalud.codigobarras AS actividadsalud_codigobarras,"
                    + "actividadsalud.permitehombre AS actividadsalud_permitehombre,"
                    + "actividadsalud.permitemujer AS actividadsalud_permitemujer,"
                    + "actividadsalud.tiempoaprox AS actividadsalud_tiempoaprox,"
                    + "actividadsalud.tarifasmlv AS actividadsalud_tarifasmlv,"
                    + "actividadsalud.cantidaduvr AS actividadsalud_cantidaduvr,"
                    + "conceptoservicio.descripcion AS conceptoservicio_descripcion,"
                    + "grupoactividad.descripcion AS grupoactividad_descripcion,"
                    + "manualactividad.descripcion AS manualactividad_descripcion,"
                    + "nivelcomplejidad.descripcion AS nivelcomplejidad_descripcion,"
                    + "protocoloactividad.descripcion AS protocoloactividad_descripcion,"
                    + "tipoactividad.descripcion AS tipoactividad_descripcion,"
                    + "subgrupoactividad.descripcion AS subgrupoactividad_descripcion,"
                    + "ambitoactividad.descripcion AS ambitoactividad_descripcion,"
                    + "categoriaactividad.descripcion AS categoriaactividad_descripcion,"
                    + "claseactividad.descripcion AS claseactividad_descripcion "
                    + " FROM "
                    + "public.ambitoactividad ambitoactividad INNER JOIN public.actividadsalud actividadsalud ON ambitoactividad.codambito = actividadsalud.codambito "
                    + "INNER JOIN public.categoriaactividad categoriaactividad ON actividadsalud.codcategactividad = categoriaactividad.codcategactividad "
                    + "INNER JOIN public.claseactividad claseactividad ON actividadsalud.codclaseactividad = claseactividad.codclaseactividad "
                    + "INNER JOIN public.conceptoservicio conceptoservicio ON actividadsalud.codconceptoservicio = conceptoservicio.codconceptoservicio "
                    + "INNER JOIN public.grupoactividad grupoactividad ON actividadsalud.codgrupoactividad = grupoactividad.codgrupoactividad "
                    + "INNER JOIN public.manualactividad manualactividad ON actividadsalud.codmanualactividad = manualactividad.codmanualactividad "
                    + "INNER JOIN public.nivelcomplejidad nivelcomplejidad ON actividadsalud.codnivelcomplejidad = nivelcomplejidad.codnivelcomplejidad "
                    + "INNER JOIN public.protocoloactividad protocoloactividad ON actividadsalud.codprotocolo = protocoloactividad.codprotocolo "
                    + "INNER JOIN public.subgrupoactividad subgrupoactividad ON actividadsalud.codgrupoactividad = subgrupoactividad.codgrupoactividad "
                    + "AND subgrupoactividad.codsubgrupo = actividadsalud.codsubgrupo "
                    + "INNER JOIN public.tipoactividad tipoactividad ON actividadsalud.codtipoactividad = tipoactividad.codtipoactividad "
                    + "AND grupoactividad.codgrupoactividad = subgrupoactividad.codgrupoactividad  WHERE codactividadsalud = '" + dkda.o(vars, "codigo") + "' ";


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            
            info += "combo|#codgrupoactividad_actividadsalud|" + rs.getString("actividadsalud_codgrupoactividad") + "|llenarCombo('codgrupoactividad_actividadsalud', '" +
                    rs.getString("actividadsalud_codgrupoactividad") + "', '" + rs.getString("grupoactividad_descripcion") + "'):_";

            info += "text|#codactividadsalud_actividadsalud|" + (rs.getString("actividadsalud_codactividadsalud") == null ? "" : rs.getString("actividadsalud_codactividadsalud")) + ":_";
            info += "text|#descripcion_actividadsalud|" + (rs.getString("actividadsalud_descripcion") == null ? "" : rs.getString("actividadsalud_descripcion")) + ":_";
            
            info += "combo|#subgrupoactividad_actividadsalud_1|" +  "subgrupoactividad   codgrupoactividad  " + rs.getString("actividadsalud_codgrupoactividad") 
                    + "   codsubgrupo  " + rs.getString("actividadsalud_codsubgrupo") + "|llenarCombo('subgrupoactividad_actividadsalud_1', '" +
                    "subgrupoactividad   codgrupoactividad  " + rs.getString("actividadsalud_codgrupoactividad") 
                    + "   codsubgrupo  " + rs.getString("actividadsalud_codsubgrupo") + "', '" + rs.getString("subgrupoactividad_descripcion") + "'):_";
            
            
            info += "combo|#codambito_actividadsalud|" + rs.getString("actividadsalud_codambito") + "|llenarCombo('codambito_actividadsalud', '" +
                    rs.getString("actividadsalud_codambito") + "', '" + rs.getString("ambitoactividad_descripcion") + "'):_";

            
            info += "combo|#codclaseactividad_actividadsalud|" + rs.getString("actividadsalud_codambito") + "|llenarCombo('codclaseactividad_actividadsalud', '" +
                    rs.getString("actividadsalud_codambito") + "', '" + rs.getString("claseactividad_descripcion") + "'):_";            
            
            
            info += "combo|#codconceptoservicio_actividadsalud|" + rs.getString("actividadsalud_codconceptoservicio") + "|llenarCombo('codconceptoservicio_actividadsalud', '" +
                    rs.getString("actividadsalud_codconceptoservicio") + "', '" + rs.getString("conceptoservicio_descripcion") + "'):_";            
            
            
            info += "combo|#codtipoactividad_actividadsalud|" + rs.getString("actividadsalud_codtipoactividad") + "|llenarCombo('codtipoactividad_actividadsalud', '" +
                    rs.getString("actividadsalud_codtipoactividad") + "', '" + rs.getString("tipoactividad_descripcion") + "'):_";            

            
            info += "combo|#codcategactividad_actividadsalud|" + rs.getString("actividadsalud_codcategactividad") + "|llenarCombo('codcategactividad_actividadsalud', '" +
                    rs.getString("actividadsalud_codcategactividad") + "', '" + rs.getString("categoriaactividad_descripcion") + "'):_";                        
            
            
            info += "combo|#codprotocolo_actividadsalud|" + rs.getString("actividadsalud_codprotocolo") + "|llenarCombo('codprotocolo_actividadsalud', '" +
                    rs.getString("actividadsalud_codprotocolo") + "', '" + rs.getString("protocoloactividad_descripcion") + "'):_";                                    

            info += "combo|#codmanualactividad_actividadsalud|" + rs.getString("actividadsalud_codmanualactividad") + "|llenarCombo('codmanualactividad_actividadsalud', '" +
                    rs.getString("actividadsalud_codmanualactividad") + "', '" + rs.getString("manualactividad_descripcion") + "'):_";                                    

            
            info += "combo|#codnivelcomplejidad_actividadsalud|" + rs.getString("actividadsalud_codnivelcomplejidad") + "|llenarCombo('codnivelcomplejidad_actividadsalud', '" +
                    rs.getString("actividadsalud_codnivelcomplejidad") + "', '" + rs.getString("nivelcomplejidad_descripcion") + "'):_";                                                
            
            
            info += "text|#codigoalterno_actividadsalud|" + (rs.getString("actividadsalud_codigoalterno") == null ? "" : rs.getString("actividadsalud_codigoalterno")) + ":_";
            
            
            info += "text|#codigorips_actividadsalud|" + (rs.getString("actividadsalud_codigorips") == null ? "" : rs.getString("actividadsalud_codigorips")) + ":_";
            
            info += "text|#costo_actividadsalud|" + (rs.getString("actividadsalud_costo") == null ? "" : rs.getString("actividadsalud_costo")) + ":_";
            
            info += "text|#cantidadmaxautorizar_actividadsalud|" + (rs.getString("actividadsalud_cantidadmaxautorizar") == null ? "" : rs.getString("actividadsalud_cantidadmaxautorizar")) + ":_";
            
            info += "text|#codigobarras_actividadsalud|" + (rs.getString("actividadsalud_codigobarras") == null ? "" : rs.getString("actividadsalud_codigobarras")) + ":_";
            
            info += "text|#resultadofinal_actividadsalud|" + (rs.getString("actividadsalud_resultadofinal") == null ? "" : rs.getString("actividadsalud_resultadofinal")) + ":_";
            

            info += "switch|switch_permitehombre_actividadsalud|" + rs.getString("actividadsalud_permitehombre") + ":_";
            
            info += "switch|switch_permitemujer_actividadsalud|" + rs.getString("actividadsalud_permitemujer") + ":_";
            
            info += "switch|switch_permitemujer_actividadsalud|" + rs.getString("actividadsalud_permitemujer") + ":_";
            
            
            info += "text|#tiempoaprox_actividadsalud|" + (rs.getString("actividadsalud_tiempoaprox") == null ? "" : rs.getString("actividadsalud_tiempoaprox")) + ":_";
            
            info += "text|#tarifasmlv_actividadsalud|" + (rs.getString("actividadsalud_tarifasmlv") == null ? "" : rs.getString("actividadsalud_tarifasmlv")) + ":_";
            
            info += "text|#cantidaduvr_actividadsalud|" + (rs.getString("actividadsalud_cantidaduvr") == null ? "" : rs.getString("actividadsalud_cantidaduvr")) + ":_";
            
            info += "text|#observacion_actividadsalud|" + (rs.getString("actividadsalud_observacion") == null ? "" : rs.getString("actividadsalud_observacion")) + ":_";
            
            respuesta = "opcion=obtener_actividadsalud&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_actividadsalud&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error actividadsalud - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_actividadsalud() {
        String direccion = "opcion=registrar_actividadsalud&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_actividadsalud();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codactividadsalud_actividadsalud").toString().equals(dkda.o(vars, "codactividadsalud_actividadsalud"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codactividadsalud_actividadsalud").isEmpty()) {
            error = "C&oacute;digo de la actividad de salud: no puede ser vacio.";
        } else if (dkda.o(vars, "descripcion_actividadsalud").isEmpty()) {
            error = "Descripci&oacute;n de la actividad: no puede ser vacio.";
        } else if (dkda.o(vars, "codgrupoactividad_actividadsalud").isEmpty()) {
            error = "Grupo Actividad: no puede ser vacio.";
        }
        else if (dkda.o(vars, "subgrupoactividad_actividadsalud_1").isEmpty()) {
            error = "Sub grupo Actividad: no puede ser vacio.";
        } else if (dkda.o(vars, "codambito_actividadsalud").isEmpty()) {
            error = "C&oacute;digo del ambito de la actividad: no puede ser vacio.";
        } else if (dkda.o(vars, "codclaseactividad_actividadsalud").isEmpty()) {
            error = "C&oacute;digo de la clase de actividad: no puede ser vacio.";
        } else if (dkda.o(vars, "codconceptoservicio_actividadsalud").isEmpty()) {
            error = "C&oacute;digo del concepto de servicio: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoactividad_actividadsalud").isEmpty()) {
            error = "C&oacute;digo Tipo Actividad: no puede ser vacio.";
        } else if (dkda.o(vars, "codcategactividad_actividadsalud").isEmpty()) {
            error = "C&oacute;digo Categoria Actividad: no puede ser vacio.";
        } else if (dkda.o(vars, "codprotocolo_actividadsalud").isEmpty()) {
            error = "C&oacute;digo Protocolo: no puede ser vacio.";
        } else if (dkda.o(vars, "codmanualactividad_actividadsalud").isEmpty()) {
            error = "C&oacute;digo Manual Actividad: no puede ser vacio.";
        } else if (dkda.o(vars, "codnivelcomplejidad_actividadsalud").isEmpty()) {
            error = "C&oacute;digo Nivel Complejidad: no puede ser vacio.";
        } else if (dkda.o(vars, "codigoalterno_actividadsalud").isEmpty()) {
            error = "C&oacute;digo Alterno: no puede ser vacio.";
        } else if (dkda.o(vars, "codigorips_actividadsalud").isEmpty()) {
            error = "Codigo Actividad RIPS: no puede ser vacio.";
        } else if (dkda.o(vars, "costo_actividadsalud").isEmpty()) {
            error = "Costo Actividad: no puede ser vacio.";
        } else if (dkda.o(vars, "cantidadmaxautorizar_actividadsalud").isEmpty()) {
            error = "Cantidad Maxima Autorizar: no puede ser vacio.";
        } else if (dkda.o(vars, "codigobarras_actividadsalud").isEmpty()) {
            error = "C&oacute;digo Barras: no puede ser vacio.";
        } else if (dkda.o(vars, "resultadofinal_actividadsalud").isEmpty()) {
            error = "Resultado Final: no puede ser vacio.";
        } else if (dkda.o(vars, "permitehombre_actividadsalud").isEmpty()) {
            error = "Permite Hombre: no puede ser vacio.";
        } else if (dkda.o(vars, "permitemujer_actividadsalud").isEmpty()) {
            error = "Permite Mujer: no puede ser vacio.";
        } else if (dkda.o(vars, "tiempoaprox_actividadsalud").isEmpty()) {
            error = "Tiempo Aproximado: no puede ser vacio.";
        } else if (dkda.o(vars, "tarifasmlv_actividadsalud").isEmpty()) {
            error = "Tarifa Salarios Minimos Legales Vigentes: no puede ser vacio.";
        } else if (dkda.o(vars, "cantidaduvr_actividadsalud").isEmpty()) {
            error = "Cantidad UVRs: no puede ser vacio.";
        } else if (dkda.o(vars, "observacion_actividadsalud").isEmpty()) {
            error = "Observaci&oacute;n: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "codactividadsalud_actividadsalud"))) {
            error = "C&oacute;digo de la actividad de salud: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "codigoalterno_actividadsalud"))) {
            error = "C&oacute;digo Alterno: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "codigorips_actividadsalud"))) {
            error = "Codigo Actividad RIPS: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "cantidadmaxautorizar_actividadsalud"))) {
            error = "Cantidad Maxima Autorizar: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "codigobarras_actividadsalud"))) {
            error = "C&oacute;digo Barras: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "tiempoaprox_actividadsalud"))) {
            error = "Tiempo Aproximado: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "cantidaduvr_actividadsalud"))) {
            error = "Cantidad UVRs: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "codactividadsalud_actividadsalud").length() > 20) {
            error = "C&oacute;digo de la actividad de salud: Valor demasiado Largo.";
        } else if (dkda.o(vars, "descripcion_actividadsalud").length() > 400) {
            error = "Descripci&oacute;n de la actividad: Valor demasiado Largo.";
        } else if (dkda.o(vars, "codigoalterno_actividadsalud").length() > 20) {
            error = "C&oacute;digo Alterno: Valor demasiado Largo.";
        } else if (dkda.o(vars, "codigorips_actividadsalud").length() > 20) {
            error = "Codigo Actividad RIPS: Valor demasiado Largo.";
        } else if (dkda.o(vars, "costo_actividadsalud").length() > 12) {
            error = "Costo Actividad: Valor demasiado Largo.";
        } else if (dkda.o(vars, "cantidadmaxautorizar_actividadsalud").length() > 8) {
            error = "Cantidad Maxima Autorizar: Valor demasiado Largo.";
        } else if (dkda.o(vars, "codigobarras_actividadsalud").length() > 70) {
            error = "C&oacute;digo Barras: Valor demasiado Largo.";
        } else if (dkda.o(vars, "tiempoaprox_actividadsalud").length() > 4) {
            error = "Tiempo Aproximado: Valor demasiado Largo.";
        } else if (dkda.o(vars, "tarifasmlv_actividadsalud").length() > 12) {
            error = "Tarifa Salarios Minimos Legales Vigentes: Valor demasiado Largo.";
        } else if (dkda.o(vars, "cantidaduvr_actividadsalud").length() > 4) {
            error = "Cantidad UVRs: Valor demasiado Largo.";
        } else if (dkda.o(vars, "observacion_actividadsalud").length() > 400) {
            error = "Observaci&oacute;n: Valor demasiado Largo.";
        }


        respuesta = (error.length() > 1 ? direccion + "" + error + "" : "");
        return respuesta;
    }

    private boolean existe_actividadsalud() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM actividadsalud  WHERE codactividadsalud = '" + dkda.o(vars, "codigo") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_actividadsalud() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    // 
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