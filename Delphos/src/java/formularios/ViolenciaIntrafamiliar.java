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

public class ViolenciaIntrafamiliar extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());



        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_violenciaintrafamiliar();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_violenciaintrafamiliar(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_violenciaintrafamiliar(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_violenciaintrafamiliar(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_violenciaintrafamiliar(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_violenciaintrafamiliar(ConexionBaseDatos con) {
        System.out.println("registrar_violenciaintrafamiliar");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO violenciaintrafamiliar (viointid,codtipoidentidadpe,viointidenti,tipviocodigo,viointdenunc,viointautori,codtipoidentidadde,viointideden,viointapelli,viointnombre,codtipoidentidadg1,violidengen1,violapellid1,violnombre1,codtipoidentidad,violidengen2,violapellid2,violnombre2,violrelato,violobservac,ususiscodigo,fecharegistro,viointfecsuc,violarchivo,violarchivo_nombre) VALUES (" + (dkda.o(vars, "viointid_violenciaintrafamiliar").equals("") ? null : dkda.o(vars, "viointid_violenciaintrafamiliar")) + "," + (dkda.o(vars, "codtipoidentidadpe_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadpe_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "viointidenti_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "viointidenti_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "tipviocodigo_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "tipviocodigo_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "viointdenunc_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "viointdenunc_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "viointautori_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "viointautori_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "codtipoidentidadde_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadde_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "viointideden_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "viointideden_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "viointapelli_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "viointapelli_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "viointnombre_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "viointnombre_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "codtipoidentidadg1_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadg1_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "violidengen1_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violidengen1_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "violapellid1_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violapellid1_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "violnombre1_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violnombre1_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "codtipoidentidad_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "violidengen2_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violidengen2_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "violapellid2_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violapellid2_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "violnombre2_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violnombre2_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "violrelato_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violrelato_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "violobservac_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violobservac_violenciaintrafamiliar") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "viointfecsuc_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "viointfecsuc_violenciaintrafamiliar") + "'") + "," + (dkda.o(vars, "violarchivo_violenciaintrafamiliar").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "violarchivo_violenciaintrafamiliar") + "')") + "," + (dkda.o(vars, "violarchivo_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violarchivo_violenciaintrafamiliar") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_violenciaintrafamiliar&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_violenciaintrafamiliar&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error violenciaintrafamiliar.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_violenciaintrafamiliar(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE violenciaintrafamiliar SET viointid = " + (dkda.o(vars, "viointid_violenciaintrafamiliar").equals("") ? null : dkda.o(vars, "viointid_violenciaintrafamiliar")) + ",codtipoidentidadpe = " + (dkda.o(vars, "codtipoidentidadpe_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadpe_violenciaintrafamiliar") + "'") + ",viointidenti = " + (dkda.o(vars, "viointidenti_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "viointidenti_violenciaintrafamiliar") + "'") + ",tipviocodigo = " + (dkda.o(vars, "tipviocodigo_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "tipviocodigo_violenciaintrafamiliar") + "'") + ",viointdenunc = " + (dkda.o(vars, "viointdenunc_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "viointdenunc_violenciaintrafamiliar") + "'") + ",viointautori = " + (dkda.o(vars, "viointautori_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "viointautori_violenciaintrafamiliar") + "'") + ",codtipoidentidadde = " + (dkda.o(vars, "codtipoidentidadde_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadde_violenciaintrafamiliar") + "'") + ",viointideden = " + (dkda.o(vars, "viointideden_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "viointideden_violenciaintrafamiliar") + "'") + ",viointapelli = " + (dkda.o(vars, "viointapelli_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "viointapelli_violenciaintrafamiliar") + "'") + ",viointnombre = " + (dkda.o(vars, "viointnombre_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "viointnombre_violenciaintrafamiliar") + "'") + ",codtipoidentidadg1 = " + (dkda.o(vars, "codtipoidentidadg1_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadg1_violenciaintrafamiliar") + "'") + ",violidengen1 = " + (dkda.o(vars, "violidengen1_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violidengen1_violenciaintrafamiliar") + "'") + ",violapellid1 = " + (dkda.o(vars, "violapellid1_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violapellid1_violenciaintrafamiliar") + "'") + ",violnombre1 = " + (dkda.o(vars, "violnombre1_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violnombre1_violenciaintrafamiliar") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_violenciaintrafamiliar") + "'") + ",violidengen2 = " + (dkda.o(vars, "violidengen2_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violidengen2_violenciaintrafamiliar") + "'") + ",violapellid2 = " + (dkda.o(vars, "violapellid2_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violapellid2_violenciaintrafamiliar") + "'") + ",violnombre2 = " + (dkda.o(vars, "violnombre2_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violnombre2_violenciaintrafamiliar") + "'") + ",violrelato = " + (dkda.o(vars, "violrelato_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violrelato_violenciaintrafamiliar") + "'") + ",violobservac = " + (dkda.o(vars, "violobservac_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violobservac_violenciaintrafamiliar") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",viointfecsuc = " + (dkda.o(vars, "viointfecsuc_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "viointfecsuc_violenciaintrafamiliar") + "'") + ",violarchivo = " + (dkda.o(vars, "violarchivo_violenciaintrafamiliar").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "violarchivo_violenciaintrafamiliar") + "')") + ",violarchivo_nombre = " + (dkda.o(vars, "violarchivo_violenciaintrafamiliar").equals("") ? null : "'" + dkda.o(vars, "violarchivo_violenciaintrafamiliar") + "'") + " WHERE viointid = " + dkda.o(vars, "codigo") + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_violenciaintrafamiliar&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_violenciaintrafamiliar&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error violenciaintrafamiliar.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_violenciaintrafamiliar(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM violenciaintrafamiliar WHERE viointid = " + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "");
            stmt.execute();
            respuesta = "opcion=eliminar_violenciaintrafamiliar&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_violenciaintrafamiliar&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error violenciaintrafamiliar.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_violenciaintrafamiliar(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT violenciaintrafamiliar.\"viointid\"           AS "
                    + "       violenciaintrafamiliar_viointid, "
                    + "       violenciaintrafamiliar.\"codtipoidentidadpe\" AS "
                    + "       violenciaintrafamiliar_codtipoidentidadpe, "
                    + "       violenciaintrafamiliar.\"viointidenti\"       AS "
                    + "       violenciaintrafamiliar_viointidenti, "
                    + "       violenciaintrafamiliar.\"tipviocodigo\"       AS "
                    + "       violenciaintrafamiliar_tipviocodigo, "
                    + "       violenciaintrafamiliar.\"viointdenunc\"       AS "
                    + "       violenciaintrafamiliar_viointdenunc, "
                    + "       violenciaintrafamiliar.\"viointautori\"       AS "
                    + "       violenciaintrafamiliar_viointautori, "
                    + "       violenciaintrafamiliar.\"codtipoidentidadde\" AS "
                    + "       violenciaintrafamiliar_codtipoidentidadde, "
                    + "       violenciaintrafamiliar.\"viointideden\"       AS "
                    + "       violenciaintrafamiliar_viointideden, "
                    + "       violenciaintrafamiliar.\"viointapelli\"       AS "
                    + "       violenciaintrafamiliar_viointapelli, "
                    + "       violenciaintrafamiliar.\"viointnombre\"       AS "
                    + "       violenciaintrafamiliar_viointnombre, "
                    + "       violenciaintrafamiliar.\"codtipoidentidadg1\" AS "
                    + "       violenciaintrafamiliar_codtipoidentidadg1, "
                    + "       violenciaintrafamiliar.\"violidengen1\"       AS "
                    + "       violenciaintrafamiliar_violidengen1, "
                    + "       violenciaintrafamiliar.\"violapellid1\"       AS "
                    + "       violenciaintrafamiliar_violapellid1, "
                    + "       violenciaintrafamiliar.\"violnombre1\"        AS "
                    + "       violenciaintrafamiliar_violnombre1, "
                    + "       violenciaintrafamiliar.\"codtipoidentidad\"   AS "
                    + "       violenciaintrafamiliar_codtipoidentidad, "
                    + "       violenciaintrafamiliar.\"violidengen2\"       AS "
                    + "       violenciaintrafamiliar_violidengen2, "
                    + "       violenciaintrafamiliar.\"violapellid2\"       AS "
                    + "       violenciaintrafamiliar_violapellid2, "
                    + "       violenciaintrafamiliar.\"violnombre2\"        AS "
                    + "       violenciaintrafamiliar_violnombre2, "
                    + "       violenciaintrafamiliar.\"violrelato\"         AS "
                    + "       violenciaintrafamiliar_violrelato, "
                    + "       violenciaintrafamiliar.\"violobservac\"       AS "
                    + "       violenciaintrafamiliar_violobservac, "
                    + "       violenciaintrafamiliar.\"viointfecsuc\"       AS "
                    + "       violenciaintrafamiliar_viointfecsuc, "
                    + "       violenciaintrafamiliar.\"violarchivo\"        AS "
                    + "       violenciaintrafamiliar_violarchivo, "
                    + "       violenciaintrafamiliar.\"violarchivo_nombre\" AS "
                    + "       violenciaintrafamiliar_violarchivo_nombre, "
                    
                    + "CASE WHEN violenciaintrafamiliar.violarchivo_nombre  IS NULL OR violenciaintrafamiliar.violarchivo_nombre  = '' THEN 0 "
                    + "ELSE lo_export(violenciaintrafamiliar.violarchivo, '" + fun.temp(request) + "' || violenciaintrafamiliar.violarchivo_nombre ) END, "
                    
                    + "       tipoviolencia.\"tipviodescri\"                AS tipoviolencia_tipviodescri "
                    + "       , "
                    + "       tipoidentificacion_c.\"descripcion\"          AS "
                    + "       tipoidentificacion_c_descripcion, "
                    + "       tipoidentificacion_b.\"descripcion\"          AS "
                    + "       tipoidentificacion_b_descripcion, "
                    + "       tipoidentificacion_a.\"descripcion\"          AS "
                    + "       tipoidentificacion_a_descripcion, "
                    + "       tipoidentificacion.\"descripcion\"            AS "
                    + "       tipoidentificacion_descripcion "
                    + "FROM   \"public\".\"violenciaintrafamiliar\" violenciaintrafamiliar "
                    + "       INNER JOIN \"public\".\"tipoviolencia\" tipoviolencia "
                    + "         ON violenciaintrafamiliar.\"tipviocodigo\" = tipoviolencia.\"tipviocodigo\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON violenciaintrafamiliar.\"codtipoidentidadpe\" = "
                    + "            tipoidentificacion.\"codtipoidentidad\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion_a "
                    + "         ON violenciaintrafamiliar.\"codtipoidentidadde\" = "
                    + "            tipoidentificacion_a.\"codtipoidentidad\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion_b "
                    + "         ON violenciaintrafamiliar.\"codtipoidentidadg1\" = "
                    + "            tipoidentificacion_b.\"codtipoidentidad\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion_c "
                    + "         ON violenciaintrafamiliar.\"codtipoidentidad\" = "
                    + "            tipoidentificacion_c.\"codtipoidentidad\"  WHERE violenciaintrafamiliar.viointid = " + dkda.o(vars, "codigo") + " ";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            
            info += "text|#violobservac_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_violobservac") == null ? "" : 
                    rs.getString("violenciaintrafamiliar_violobservac")) + ":_";            

            info += "text|#viointautori_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_viointautori") == null ? "" : 
                    rs.getString("violenciaintrafamiliar_viointautori")) + ":_";            
            
            info += "text|#violrelato_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_violrelato") == null ? "" : 
                    rs.getString("violenciaintrafamiliar_violrelato")) + ":_";
            
            info += "text|#violarchivo_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_violarchivo_nombre") == null ? "" : 
                    rs.getString("violenciaintrafamiliar_violarchivo_nombre")) + ":_";
            
            info += "text|#_fecha_viointfecsuc_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_viointfecsuc") == null ? "" : 
                    rs.getString("violenciaintrafamiliar_viointfecsuc")) + ":_";
            
            info += "text|#violnombre2_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_violnombre2") == null ? "" : 
                    rs.getString("violenciaintrafamiliar_violnombre2")) + ":_";
            
            info += "text|#violapellid2_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_violapellid2") == null ? "" : 
                    rs.getString("violenciaintrafamiliar_violapellid2")) + ":_";
            
            info += "text|#violidengen2_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_violidengen2") == null ? "" : 
                    rs.getString("violenciaintrafamiliar_violidengen2")) + ":_";
            
            info += "combo|#codtipoidentidad_violenciaintrafamiliar|" + rs.getString("violenciaintrafamiliar_codtipoidentidad") + 
                    "|llenarCombo('codtipoidentidad_violenciaintrafamiliar', '"
                    + rs.getString("violenciaintrafamiliar_codtipoidentidad") + "', '" + rs.getString("tipoidentificacion_b_descripcion") + "'):_";
            
            info += "text|#violnombre1_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_violnombre1") == null ? "" : 
                    rs.getString("violenciaintrafamiliar_violnombre1")) + ":_";
            
            info += "text|#violapellid1_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_violapellid1") == null ? "" : 
                    rs.getString("violenciaintrafamiliar_violapellid1")) + ":_";
            
            info += "text|#violidengen1_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_violidengen1") == null ? "" : 
                    rs.getString("violenciaintrafamiliar_violidengen1")) + ":_";
            
            info += "combo|#codtipoidentidadg1_violenciaintrafamiliar|" + rs.getString("violenciaintrafamiliar_codtipoidentidadg1") + 
                    "|llenarCombo('codtipoidentidadg1_violenciaintrafamiliar', '"
                    + rs.getString("violenciaintrafamiliar_codtipoidentidadg1") + "', '" + rs.getString("tipoidentificacion_b_descripcion") + "'):_";
            
            
            info += "text|#viointnombre_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_viointnombre") == null ? "" : 
                    rs.getString("violenciaintrafamiliar_viointnombre")) + ":_";
            
            info += "text|#viointapelli_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_viointapelli") == null ? "" : 
                    rs.getString("violenciaintrafamiliar_viointapelli")) + ":_";
            
            info += "text|#viointideden_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_viointideden") == null ? "" : rs.getString("violenciaintrafamiliar_viointideden")) + ":_";
            
            info += "combo|#codtipoidentidadde_violenciaintrafamiliar|" + rs.getString("violenciaintrafamiliar_codtipoidentidadde") + 
                    "|llenarCombo('codtipoidentidadde_violenciaintrafamiliar', '"
                    + rs.getString("violenciaintrafamiliar_codtipoidentidadde") + "', '" + rs.getString("tipoidentificacion_a_descripcion") + "'):_";
            
            
            info += "switch|switch_viointdenunc_violenciaintrafamiliar|" + rs.getString("violenciaintrafamiliar_viointdenunc") + ":_";
            
            info += "combo|#tipviocodigo_violenciaintrafamiliar|" + rs.getString("violenciaintrafamiliar_tipviocodigo") + 
                    "|llenarCombo('tipviocodigo_violenciaintrafamiliar', '"
                    + rs.getString("violenciaintrafamiliar_tipviocodigo") + "', '" + rs.getString("tipoviolencia_tipviodescri") + "'):_";
            
            info += "text|#viointidenti_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_viointidenti") == null ? "" : rs.getString("violenciaintrafamiliar_viointidenti")) + ":_";

            info += "combo|#codtipoidentidadpe_violenciaintrafamiliar|" + rs.getString("violenciaintrafamiliar_codtipoidentidadpe") + 
                    "|llenarCombo('codtipoidentidadpe_violenciaintrafamiliar', '"
                    + rs.getString("violenciaintrafamiliar_codtipoidentidadpe") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";
            
            info += "text|#viointid_violenciaintrafamiliar|" + (rs.getString("violenciaintrafamiliar_viointid") == null ? "" : rs.getString("violenciaintrafamiliar_viointid")) + ":_";

            respuesta = "opcion=obtener_violenciaintrafamiliar&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_violenciaintrafamiliar&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error violenciaintrafamiliar - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_violenciaintrafamiliar() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            String sql = "SELECT COUNT(*) FROM violenciaintrafamiliar  WHERE viointid = " + dkda.o(vars, "viointid_violenciaintrafamiliar") + "";
            System.out.println(sql);
            pQuery = conexion.prepareStatement(sql);
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_violenciaintrafamiliar() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_violenciaintrafamiliar() {
        String direccion = "opcion=registrar_violenciaintrafamiliar&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_violenciaintrafamiliar();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "viointid_violenciaintrafamiliar"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "viointid_violenciaintrafamiliar").isEmpty()) {
            error = "Número Registro Violencia Intrafamiliar: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidadpe_violenciaintrafamiliar").isEmpty()) {
            error = "Tipo Identificación Persona Violencia Intrafamiliar: no puede ser vacio.";
        } else if (dkda.o(vars, "viointidenti_violenciaintrafamiliar").isEmpty()) {
            error = "Identificación Persona Violencia Intrafamiliar: no puede ser vacio.";
        } else if (dkda.o(vars, "tipviocodigo_violenciaintrafamiliar").isEmpty()) {
            error = "Código Tipo Violencia Intrafamiliar: no puede ser vacio.";
        } else if (dkda.o(vars, "viointdenunc_violenciaintrafamiliar").isEmpty()) {
            error = "Acción Violencia Intrafamiliar Denunciada (S/N): no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidadde_violenciaintrafamiliar").isEmpty()) {
            error = "Tipo Identificacion Persona Presentó Denuncia: no puede ser vacio.";
        } else if (dkda.o(vars, "viointideden_violenciaintrafamiliar").isEmpty()) {
            error = "Identificacion Persona Presentó Denuncia: no puede ser vacio.";
        } else if (dkda.o(vars, "viointapelli_violenciaintrafamiliar").isEmpty()) {
            error = "Apellidos Presentó Denuncia: no puede ser vacio.";
        } else if (dkda.o(vars, "viointnombre_violenciaintrafamiliar").isEmpty()) {
            error = "Nombres Presentó Denuncia: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidadg1_violenciaintrafamiliar").isEmpty()) {
            error = "Tipo Identificacion 1 Generó Violencia: no puede ser vacio.";
        } else if (dkda.o(vars, "violidengen1_violenciaintrafamiliar").isEmpty()) {
            error = "Identificacion 1 Generó Violencia: no puede ser vacio.";
        } else if (dkda.o(vars, "violapellid1_violenciaintrafamiliar").isEmpty()) {
            error = "Apellidos 1 Generó Violencia: no puede ser vacio.";
        } else if (dkda.o(vars, "violnombre1_violenciaintrafamiliar").isEmpty()) {
            error = "Nombres 1 Generó Violencia: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_violenciaintrafamiliar").isEmpty()) {
            error = "Tipo Identificacion 2 Generó Violencia: no puede ser vacio.";
        } else if (dkda.o(vars, "violidengen2_violenciaintrafamiliar").isEmpty()) {
            error = "Identificacion 2 Generó Violencia: no puede ser vacio.";
        } else if (dkda.o(vars, "violapellid2_violenciaintrafamiliar").isEmpty()) {
            error = "Apellidos 2 Generó Violencia: no puede ser vacio.";
        } else if (dkda.o(vars, "violnombre2_violenciaintrafamiliar").isEmpty()) {
            error = "Nombres 2 Generó Violencia: no puede ser vacio.";
        } else if (dkda.o(vars, "viointfecsuc_violenciaintrafamiliar").isEmpty()) {
            error = "Fecha Suceso Violencia IntraFamiliar: no puede ser vacio.";
        } else if (dkda.o(vars, "violarchivo_violenciaintrafamiliar").isEmpty()) {
            error = "Archivo Documento Denuncia Queja: no puede ser vacio.";
        } else if (dkda.o(vars, "viointautori_violenciaintrafamiliar").isEmpty()) {
            error = "Autoridad Competente donde se Denunció: no puede ser vacio.";
        } else if (dkda.o(vars, "violobservac_violenciaintrafamiliar").isEmpty()) {
            error = "Observaciones Violencia IntraFamiliar: no puede ser vacio.";
        } else if (dkda.o(vars, "viointid_violenciaintrafamiliar").length() > 9) {
            error = "Número Registro Violencia Intrafamiliar: Valor demasiado Largo.";
        } else if (dkda.o(vars, "viointapelli_violenciaintrafamiliar").length() > 40) {
            error = "Apellidos Presentó Denuncia: Valor demasiado Largo.";
        } else if (dkda.o(vars, "viointnombre_violenciaintrafamiliar").length() > 40) {
            error = "Nombres Presentó Denuncia: Valor demasiado Largo.";
        } else if (dkda.o(vars, "violapellid1_violenciaintrafamiliar").length() > 40) {
            error = "Apellidos 1 Generó Violencia: Valor demasiado Largo.";
        } else if (dkda.o(vars, "violnombre1_violenciaintrafamiliar").length() > 40) {
            error = "Nombres 1 Generó Violencia: Valor demasiado Largo.";
        } else if (dkda.o(vars, "violapellid2_violenciaintrafamiliar").length() > 40) {
            error = "Apellidos 2 Generó Violencia: Valor demasiado Largo.";
        } else if (dkda.o(vars, "violnombre2_violenciaintrafamiliar").length() > 40) {
            error = "Nombres 2 Generó Violencia: Valor demasiado Largo.";
        } else if (dkda.o(vars, "violobservac_violenciaintrafamiliar").length() > 400) {
            error = "Observaciones Violencia IntraFamiliar: Valor demasiado Largo.";
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