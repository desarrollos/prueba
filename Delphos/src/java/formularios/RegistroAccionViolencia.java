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

public class RegistroAccionViolencia extends HttpServlet {

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
            String sql = "SELECT violenciaintrafamiliar.viointid           AS "
                    + "       violenciaintrafamiliar_viointid, "
                    + "       violenciaintrafamiliar.codtipoidentidadpe AS "
                    + "       violenciaintrafamiliar_codtipoidentidadpe, "
                    + "       violenciaintrafamiliar.viointidenti       AS "
                    + "       violenciaintrafamiliar_viointidenti, "
                    + "       violenciaintrafamiliar.tipviocodigo       AS "
                    + "       violenciaintrafamiliar_tipviocodigo, "
                    + "       violenciaintrafamiliar.viointdenunc       AS "
                    + "       violenciaintrafamiliar_viointdenunc, "
                    + "       violenciaintrafamiliar.viointautori       AS "
                    + "       violenciaintrafamiliar_viointautori, "
                    + "       violenciaintrafamiliar.codtipoidentidadde AS "
                    + "       violenciaintrafamiliar_codtipoidentidadde, "
                    + "       violenciaintrafamiliar.viointideden       AS "
                    + "       violenciaintrafamiliar_viointideden, "
                    + "       violenciaintrafamiliar.viointapelli       AS "
                    + "       violenciaintrafamiliar_viointapelli, "
                    + "       violenciaintrafamiliar.viointnombre       AS "
                    + "       violenciaintrafamiliar_viointnombre, "
                    + "       violenciaintrafamiliar.codtipoidentidadg1 AS "
                    + "       violenciaintrafamiliar_codtipoidentidadg1, "
                    + "       violenciaintrafamiliar.violidengen1       AS "
                    + "       violenciaintrafamiliar_violidengen1, "
                    + "       violenciaintrafamiliar.violapellid1       AS "
                    + "       violenciaintrafamiliar_violapellid1, "
                    + "       violenciaintrafamiliar.violnombre1        AS "
                    + "       violenciaintrafamiliar_violnombre1, "
                    + "       violenciaintrafamiliar.codtipoidentidad   AS "
                    + "       violenciaintrafamiliar_codtipoidentidad, "
                    + "       violenciaintrafamiliar.violidengen2       AS "
                    + "       violenciaintrafamiliar_violidengen2, "
                    + "       violenciaintrafamiliar.violapellid2       AS "
                    + "       violenciaintrafamiliar_violapellid2, "
                    + "       violenciaintrafamiliar.violnombre2        AS "
                    + "       violenciaintrafamiliar_violnombre2, "
                    + "       violenciaintrafamiliar.violrelato         AS "
                    + "       violenciaintrafamiliar_violrelato, "
                    + "       violenciaintrafamiliar.violobservac       AS "
                    + "       violenciaintrafamiliar_violobservac, "
                    + "       violenciaintrafamiliar.ususiscodigo       AS "
                    + "       violenciaintrafamiliar_ususiscodigo, "
                    + "       violenciaintrafamiliar.fecharegistro      AS "
                    + "       violenciaintrafamiliar_fecharegistro, "
                    + "       violenciaintrafamiliar.viointfecsuc       AS "
                    + "       violenciaintrafamiliar_viointfecsuc, "
                    + "       violenciaintrafamiliar.violarchivo        AS "
                    + "       violenciaintrafamiliar_violarchivo, "
                    + "       violenciaintrafamiliar.violarchivo_nombre AS "
                    + "       violenciaintrafamiliar_violarchivo_nombre, "
                    + "       tipoviolencia.tipviocodigo                AS tipoviolencia_tipviocodigo, "
                    + "       tipoviolencia.tipviodescri                AS tipoviolencia_tipviodescri, "
                    + "       (SELECT i.descripcion "
                    + "        FROM   tipoidentificacion i, "
                    + "               violenciaintrafamiliar v "
                    + "        WHERE  v.codtipoidentidadpe = i.codtipoidentidad "
                    + "               AND v.viointid = " + codigo + ")               AS identif1, "
                    + "       (SELECT i.descripcion "
                    + "        FROM   tipoidentificacion i, "
                    + "               violenciaintrafamiliar v "
                    + "        WHERE  v.codtipoidentidadde = i.codtipoidentidad "
                    + "               AND v.viointid = " + codigo + ")               AS identif2, "
                    + "       (SELECT i.descripcion "
                    + "        FROM   tipoidentificacion i, "
                    + "               violenciaintrafamiliar v "
                    + "        WHERE  v.codtipoidentidadg1 = i.codtipoidentidad "
                    + "               AND v.viointid = " + codigo + ")               AS identif3, "
                    + "       (SELECT i.descripcion "
                    + "        FROM   tipoidentificacion i, "
                    + "               violenciaintrafamiliar v "
                    + "        WHERE  v.codtipoidentidad = i.codtipoidentidad "
                    + "               AND v.viointid = " + codigo + ")               AS identif4 "
                    + "FROM   public.tipoidentificacion tipoidentificacion "
                    + "       full outer join public.violenciaintrafamiliar violenciaintrafamiliar "
                    + "         ON tipoidentificacion.codtipoidentidad = "
                    + "            violenciaintrafamiliar.codtipoidentidad "
                    + "            AND tipoidentificacion.codtipoidentidad = "
                    + "                violenciaintrafamiliar.codtipoidentidadpe "
                    + "            AND tipoidentificacion.codtipoidentidad = "
                    + "                violenciaintrafamiliar.codtipoidentidadg1 "
                    + "            AND tipoidentificacion.codtipoidentidad = "
                    + "                violenciaintrafamiliar.codtipoidentidadde "
                    + "       inner join public.tipoviolencia tipoviolencia "
                    + "         ON violenciaintrafamiliar.tipviocodigo = tipoviolencia.tipviocodigo "
                    + "WHERE  violenciaintrafamiliar.viointid = " + codigo;
            stmt = con.con.prepareStatement(sql);
            System.out.print( sql );
            rs = stmt.executeQuery();
            rs.next();
            
            info += "text|#viointid_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_viointid") == null ? ""
                    : rs.getString("violenciaintrafamiliar_viointid")) + ":_";

            info += "text|#_fecha_viointfecsuc_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_viointfecsuc") == null ? ""
                    : rs.getString("violenciaintrafamiliar_viointfecsuc")) + ":_";

            info += "combo|#codtipoidentidadpe_violenciaintrafamiliar|" + rs.getString("violenciaintrafamiliar_codtipoidentidadpe")
                    + "|llenarCombo('codtipoidentidadpe_violenciaintrafamiliar', '" + rs.getString("violenciaintrafamiliar_codtipoidentidadpe")
                    + "', '" + rs.getString("identif1") + "'):_";

            info += "combo|#codtipoidentidadde_violenciaintrafamiliar|" + rs.getString("violenciaintrafamiliar_codtipoidentidadde")
                    + "|llenarCombo('codtipoidentidadde_violenciaintrafamiliar', '" + rs.getString("violenciaintrafamiliar_codtipoidentidadde")
                    + "', '" + rs.getString("identif2") + "'):_";

            info += "combo|#codtipoidentidadg1_violenciaintrafamiliar|" + rs.getString("violenciaintrafamiliar_codtipoidentidadg1")
                    + "|llenarCombo('codtipoidentidadg1_violenciaintrafamiliar', '" + rs.getString("violenciaintrafamiliar_codtipoidentidadg1")
                    + "', '" + rs.getString("identif3") + "'):_";

            System.out.println("RESULT QUERY => " + rs.getString("identif4"));

            if (rs.getString("identif4") != null) {
                info += "combo|#codtipoidentidad_violenciaintrafamiliar|" + rs.getString("violenciaintrafamiliar_codtipoidentidad")
                        + "|llenarCombo('codtipoidentidad_violenciaintrafamiliar', '" + rs.getString("violenciaintrafamiliar_codtipoidentidad")
                        + "', '" + rs.getString("identif4") + "'):_";
            }

            info += "combo|#tipviocodigo_violenciaintrafamiliar|" + rs.getString("tipoviolencia_tipviocodigo")
                    + "|llenarCombo('tipviocodigo_violenciaintrafamiliar', '" + rs.getString("tipoviolencia_tipviocodigo")
                    + "', '" + rs.getString("tipoviolencia_tipviodescri") + "'):_";

            info += "text|#viointidenti_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_viointidenti") == null ? ""
                    : rs.getString("violenciaintrafamiliar_viointidenti")) + ":_";

            info += "text|#viointautori_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_viointautori") == null ? ""
                    : rs.getString("violenciaintrafamiliar_viointautori")) + ":_";

            info += "text|#viointideden_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_viointideden") == null ? ""
                    : rs.getString("violenciaintrafamiliar_viointideden")) + ":_";

            info += "text|#viointapelli_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_viointapelli") == null ? ""
                    : rs.getString("violenciaintrafamiliar_viointapelli")) + ":_";

            info += "text|#viointnombre_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_viointnombre") == null ? ""
                    : rs.getString("violenciaintrafamiliar_viointnombre")) + ":_";

            info += "text|#violidengen1_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_violidengen1") == null ? ""
                    : rs.getString("violenciaintrafamiliar_violidengen1")) + ":_";

            info += "text|#violapellid1_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_violapellid1") == null ? ""
                    : rs.getString("violenciaintrafamiliar_violapellid1")) + ":_";

            info += "text|#violnombre1_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_violnombre1") == null ? ""
                    : rs.getString("violenciaintrafamiliar_violnombre1")) + ":_";

            info += "text|#violidengen2_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_violidengen2") == null ? ""
                    : rs.getString("violenciaintrafamiliar_violidengen2")) + ":_";

            info += "text|#violapellid2_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_violapellid2") == null ? ""
                    : rs.getString("violenciaintrafamiliar_violapellid2")) + ":_";

            info += "text|#violnombre2_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_violnombre2") == null ? ""
                    : rs.getString("violenciaintrafamiliar_violnombre2")) + ":_";

            info += "text|#violrelato_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_violrelato") == null ? ""
                    : rs.getString("violenciaintrafamiliar_violrelato")) + ":_";

            info += "text|#violobservac_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_violobservac") == null ? ""
                    : rs.getString("violenciaintrafamiliar_violobservac")) + ":_";


            info += "text|#violarchivo_violenciaintrafamiliar|"
                    + (rs.getString("violenciaintrafamiliar_violarchivo") == null ? ""
                    : rs.getString("violenciaintrafamiliar_violarchivos")) + ":_";


            info += "switch|switch_viointdenunc_violenciaintrafamiliar|" + rs.getString("violenciaintrafamiliar_viointdenunc") + ":_";

            respuesta = "opcion=obtener_violenciaintrafamiliar&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_violenciaintrafamiliar&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error violenciaintrafamiliar - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
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
            error = "Número Registro: no puede ser vacio.";
        } else if (dkda.o(vars, "viointfecsuc_violenciaintrafamiliar").isEmpty()) {
            error = "Fecha Suceso: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidadpe_violenciaintrafamiliar").isEmpty()) {
            error = "Tipo Identificación: no puede ser vacio.";
        } else if (dkda.o(vars, "viointidenti_violenciaintrafamiliar").isEmpty()) {
            error = "Identificación Persona Afectada: no puede ser vacio.";
        } else if (dkda.o(vars, "tipviocodigo_violenciaintrafamiliar").isEmpty()) {
            error = "Tipo Violencia: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidadde_violenciaintrafamiliar").isEmpty()) {
            error = "Tipo Identificacion Presentó Denuncia: no puede ser vacio.";
        } else if (dkda.o(vars, "viointideden_violenciaintrafamiliar").isEmpty()) {
            error = " Identificacion Denunciante: no puede ser vacio.";
        } else if (dkda.o(vars, "viointapelli_violenciaintrafamiliar").isEmpty()) {
            error = "Apellidos Denunciante: no puede ser vacio.";
        } else if (dkda.o(vars, "viointnombre_violenciaintrafamiliar").isEmpty()) {
            error = "Nombres Denunciante: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidadg1_violenciaintrafamiliar").isEmpty()) {
            error = "Tipo Identificacion Denunciado: no puede ser vacio.";
        } else if (dkda.o(vars, "violidengen1_violenciaintrafamiliar").isEmpty()) {
            error = "Identificacion Denunciado 1: no puede ser vacio.";
        } else if (dkda.o(vars, "violapellid1_violenciaintrafamiliar").isEmpty()) {
            error = "Apellidos Denunciado 1: no puede ser vacio.";
        } else if (dkda.o(vars, "violnombre1_violenciaintrafamiliar").isEmpty()) {
            error = "Nombres Denunciado 1: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "viointidenti_violenciaintrafamiliar"))) {
            error = "Identificación Persona Afectada: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "viointideden_violenciaintrafamiliar"))) {
            error = " Identificacion Denunciante: Tiene Caracteres no permitidos.";
        } else if (!v.caracteres(dkda.o(vars, "viointapelli_violenciaintrafamiliar"))) {
            error = "Apellidos Denunciante: Tiene Caracteres no permitidos.";
        } else if (!v.caracteres(dkda.o(vars, "viointnombre_violenciaintrafamiliar"))) {
            error = "Nombres Denunciante: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "violidengen1_violenciaintrafamiliar"))) {
            error = "Identificacion Denunciado 1: Tiene Caracteres no permitidos.";
        } else if (!v.caracteres(dkda.o(vars, "violapellid1_violenciaintrafamiliar"))) {
            error = "Apellidos Denunciado 1: Tiene Caracteres no permitidos.";
        } else if (!v.caracteres(dkda.o(vars, "violnombre1_violenciaintrafamiliar"))) {
            error = "Nombres Denunciado 1: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "violidengen2_violenciaintrafamiliar")) && dkda.o(vars, "violidengen2_violenciaintrafamiliar").length() > 0) {
            error = "Identificacion Denunciado 2: Tiene Caracteres no permitidos.";
        } else if (!v.caracteres(dkda.o(vars, "violapellid2_violenciaintrafamiliar")) && dkda.o(vars, "violapellid2_violenciaintrafamiliar").length() > 0) {
            error = "Apellidos Denunciado 2: Tiene Caracteres no permitidos.";
        } else if (!v.caracteres(dkda.o(vars, "violnombre2_violenciaintrafamiliar")) && dkda.o(vars, "violnombre2_violenciaintrafamiliar").length() > 0) {
            error = "Nombres Denunciado 2: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "viointid_violenciaintrafamiliar").length() > 9) {
            error = "Número Registro: Valor demasiado Largo.";
        } else if (dkda.o(vars, "viointidenti_violenciaintrafamiliar").length() > 18) {
            error = "Identificación Persona Afectada: Valor demasiado Largo.";
        } else if (dkda.o(vars, "viointautori_violenciaintrafamiliar").length() > 100) {
            error = "Autoridad donde acudio: Valor demasiado Largo.";
        } else if (dkda.o(vars, "viointideden_violenciaintrafamiliar").length() > 18) {
            error = " Identificacion Denunciante: Valor demasiado Largo.";
        } else if (dkda.o(vars, "viointapelli_violenciaintrafamiliar").length() > 40) {
            error = "Apellidos Denunciante: Valor demasiado Largo.";
        } else if (dkda.o(vars, "viointnombre_violenciaintrafamiliar").length() > 40) {
            error = "Nombres Denunciante: Valor demasiado Largo.";
        } else if (dkda.o(vars, "violidengen1_violenciaintrafamiliar").length() > 18) {
            error = "Identificacion Denunciado 1: Valor demasiado Largo.";
        } else if (dkda.o(vars, "violapellid1_violenciaintrafamiliar").length() > 40) {
            error = "Apellidos Denunciado 1: Valor demasiado Largo.";
        } else if (dkda.o(vars, "violnombre1_violenciaintrafamiliar").length() > 40) {
            error = "Nombres Denunciado 1: Valor demasiado Largo.";
        } else if (dkda.o(vars, "violidengen2_violenciaintrafamiliar").length() > 18) {
            error = "Identificacion Denunciado 2: Valor demasiado Largo.";
        } else if (dkda.o(vars, "violapellid2_violenciaintrafamiliar").length() > 40) {
            error = "Apellidos Denunciado 2: Valor demasiado Largo.";
        } else if (dkda.o(vars, "violnombre2_violenciaintrafamiliar").length() > 40) {
            error = "Nombres Denunciado 2: Valor demasiado Largo.";
        } else if (dkda.o(vars, "violrelato_violenciaintrafamiliar").length() > 400) {
            error = "Relato Acción de Violencia Intrafamiliar: Valor demasiado Largo.";
        } else if (dkda.o(vars, "violobservac_violenciaintrafamiliar").length() > 400) {
            error = "Observaciones Violencia IntraFamiliar: Valor demasiado Largo.";
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

    private boolean existe_violenciaintrafamiliar() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;

        try {

            if (!dkda.o(vars, "viointid_violenciaintrafamiliar").isEmpty()) {
                pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM violenciaintrafamiliar  WHERE viointid = " + dkda.o(vars, "viointid_violenciaintrafamiliar") + "");
                rQuery = pQuery.executeQuery();
                rQuery.next();
                existe = rQuery.getInt(1) > 0 ? true : false;
                pQuery.close();
                rQuery.close();
            } else {
                existe = false;
            }

        } catch (SQLException e) {
            System.err.println("( existe_violenciaintrafamiliar() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }
}