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

public class Empresas extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, barrio_empresa_1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());



        barrio_empresa_1 = fun.map(dkda.o(vars, "barrio_empresa_1").toString());
        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_empresa();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_empresa(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_empresa(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_empresa(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_empresa(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_empresa(ConexionBaseDatos con) {
        System.out.println("registrar_empresa");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO empresa (codtipoidentidad,codempresa,digitoverificacion,nombre,sigla,telefono,fax,lineagratuita,coddepartamento,codmunicipio,codsubgrupo,codbarrio,direccion,gerente,codactividadeconomica,codsectorentidad,codtipoaportante,email,paginaweb,codtipocontribuyente,codclasepersona,empresasistema,empcodigodane,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "codtipoidentidad_empresa").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_empresa") + "'") + "," + (dkda.o(vars, "codempresa_empresa").equals("") ? null : "'" + dkda.o(vars, "codempresa_empresa") + "'") + "," + (dkda.o(vars, "digitoverificacion_empresa").equals("") ? null : "'" + dkda.o(vars, "digitoverificacion_empresa") + "'") + "," + (dkda.o(vars, "nombre_empresa").equals("") ? null : "'" + dkda.o(vars, "nombre_empresa") + "'") + "," + (dkda.o(vars, "sigla_empresa").equals("") ? null : "'" + dkda.o(vars, "sigla_empresa") + "'") + "," + (dkda.o(vars, "telefono_empresa").equals("") ? null : "'" + dkda.o(vars, "telefono_empresa") + "'") + "," + (dkda.o(vars, "fax_empresa").equals("") ? null : "'" + dkda.o(vars, "fax_empresa") + "'") + "," + (dkda.o(vars, "lineagratuita_empresa").equals("") ? null : "'" + dkda.o(vars, "lineagratuita_empresa") + "'") + "," + (dkda.o(barrio_empresa_1, "coddepartamento").equals("") ? null : dkda.o(barrio_empresa_1, "coddepartamento")) + "," + (dkda.o(barrio_empresa_1, "codmunicipio").equals("") ? null : dkda.o(barrio_empresa_1, "codmunicipio")) + "," + (dkda.o(barrio_empresa_1, "codsubgrupo").equals("") ? null : dkda.o(barrio_empresa_1, "codsubgrupo")) + "," + (dkda.o(barrio_empresa_1, "codbarrio").equals("") ? null : dkda.o(barrio_empresa_1, "codbarrio")) + "," + (dkda.o(vars, "direccion_empresa").equals("") ? null : "'" + dkda.o(vars, "direccion_empresa") + "'") + "," + (dkda.o(vars, "gerente_empresa").equals("") ? null : "'" + dkda.o(vars, "gerente_empresa") + "'") + "," + (dkda.o(vars, "codactividadeconomica_empresa").equals("") ? null : "'" + dkda.o(vars, "codactividadeconomica_empresa") + "'") + "," + (dkda.o(vars, "codsectorentidad_empresa").equals("") ? null : "'" + dkda.o(vars, "codsectorentidad_empresa") + "'") + "," + (dkda.o(vars, "codtipoaportante_empresa").equals("") ? null : "'" + dkda.o(vars, "codtipoaportante_empresa") + "'") + "," + (dkda.o(vars, "email_empresa").equals("") ? null : "'" + dkda.o(vars, "email_empresa") + "'") + "," + (dkda.o(vars, "paginaweb_empresa").equals("") ? null : "'" + dkda.o(vars, "paginaweb_empresa") + "'") + "," + (dkda.o(vars, "codtipocontribuyente_empresa").equals("") ? null : "'" + dkda.o(vars, "codtipocontribuyente_empresa") + "'") + "," + (dkda.o(vars, "codclasepersona_empresa").equals("") ? null : "'" + dkda.o(vars, "codclasepersona_empresa") + "'") + "," + (dkda.o(vars, "empresasistema_empresa").equals("") ? null : "'" + dkda.o(vars, "empresasistema_empresa") + "'") + "," + (dkda.o(vars, "empcodigodane_empresa").equals("") ? null : "'" + dkda.o(vars, "empcodigodane_empresa") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_empresa&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_empresa&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error empresa.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_empresa(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE empresa SET codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_empresa").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_empresa") + "'") + ",codempresa = " + (dkda.o(vars, "codempresa_empresa").equals("") ? null : "'" + dkda.o(vars, "codempresa_empresa") + "'") + ",digitoverificacion = " + (dkda.o(vars, "digitoverificacion_empresa").equals("") ? null : "'" + dkda.o(vars, "digitoverificacion_empresa") + "'") + ",nombre = " + (dkda.o(vars, "nombre_empresa").equals("") ? null : "'" + dkda.o(vars, "nombre_empresa") + "'") + ",sigla = " + (dkda.o(vars, "sigla_empresa").equals("") ? null : "'" + dkda.o(vars, "sigla_empresa") + "'") + ",telefono = " + (dkda.o(vars, "telefono_empresa").equals("") ? null : "'" + dkda.o(vars, "telefono_empresa") + "'") + ",fax = " + (dkda.o(vars, "fax_empresa").equals("") ? null : "'" + dkda.o(vars, "fax_empresa") + "'") + ",lineagratuita = " + (dkda.o(vars, "lineagratuita_empresa").equals("") ? null : "'" + dkda.o(vars, "lineagratuita_empresa") + "'") + ",coddepartamento = " + (dkda.o(barrio_empresa_1, "coddepartamento").equals("") ? null : dkda.o(barrio_empresa_1, "coddepartamento")) + ",codmunicipio = " + (dkda.o(barrio_empresa_1, "codmunicipio").equals("") ? null : dkda.o(barrio_empresa_1, "codmunicipio")) + ",codsubgrupo = " + (dkda.o(barrio_empresa_1, "codsubgrupo").equals("") ? null : dkda.o(barrio_empresa_1, "codsubgrupo")) + ",codbarrio = " + (dkda.o(barrio_empresa_1, "codbarrio").equals("") ? null : dkda.o(barrio_empresa_1, "codbarrio")) + ",direccion = " + (dkda.o(vars, "direccion_empresa").equals("") ? null : "'" + dkda.o(vars, "direccion_empresa") + "'") + ",gerente = " + (dkda.o(vars, "gerente_empresa").equals("") ? null : "'" + dkda.o(vars, "gerente_empresa") + "'") + ",codactividadeconomica = " + (dkda.o(vars, "codactividadeconomica_empresa").equals("") ? null : "'" + dkda.o(vars, "codactividadeconomica_empresa") + "'") + ",codsectorentidad = " + (dkda.o(vars, "codsectorentidad_empresa").equals("") ? null : "'" + dkda.o(vars, "codsectorentidad_empresa") + "'") + ",codtipoaportante = " + (dkda.o(vars, "codtipoaportante_empresa").equals("") ? null : "'" + dkda.o(vars, "codtipoaportante_empresa") + "'") + ",email = " + (dkda.o(vars, "email_empresa").equals("") ? null : "'" + dkda.o(vars, "email_empresa") + "'") + ",paginaweb = " + (dkda.o(vars, "paginaweb_empresa").equals("") ? null : "'" + dkda.o(vars, "paginaweb_empresa") + "'") + ",codtipocontribuyente = " + (dkda.o(vars, "codtipocontribuyente_empresa").equals("") ? null : "'" + dkda.o(vars, "codtipocontribuyente_empresa") + "'") + ",codclasepersona = " + (dkda.o(vars, "codclasepersona_empresa").equals("") ? null : "'" + dkda.o(vars, "codclasepersona_empresa") + "'") + ",empresasistema = " + (dkda.o(vars, "empresasistema_empresa").equals("") ? null : "'" + dkda.o(vars, "empresasistema_empresa") + "'") + ",empcodigodane = " + (dkda.o(vars, "empcodigodane_empresa").equals("") ? null : "'" + dkda.o(vars, "empcodigodane_empresa") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND codempresa = '" + dkda.o(sel, "codempresa") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_empresa&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_empresa&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error empresa.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_empresa(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM empresa WHERE codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND codempresa = '" + dkda.o(sel, "codempresa") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_empresa&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_empresa&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error empresa.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_empresa(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT empresa.\"codtipoidentidad\"       AS empresa_codtipoidentidad, "
                    + "       empresa.\"codempresa\"             AS empresa_codempresa, "
                    + "       empresa.\"digitoverificacion\"     AS empresa_digitoverificacion, "
                    + "       empresa.\"nombre\"                 AS empresa_nombre, "
                    + "       empresa.\"sigla\"                  AS empresa_sigla, "
                    + "       empresa.\"telefono\"               AS empresa_telefono, "
                    + "       empresa.\"fax\"                    AS empresa_fax, "
                    + "       empresa.\"lineagratuita\"          AS empresa_lineagratuita, "
                    + "       empresa.\"coddepartamento\"        AS empresa_coddepartamento, "
                    + "       empresa.\"codmunicipio\"           AS empresa_codmunicipio, "
                    + "       empresa.\"codsubgrupo\"            AS empresa_codsubgrupo, "
                    + "       empresa.\"codbarrio\"              AS empresa_codbarrio, "
                    + "       empresa.\"direccion\"              AS empresa_direccion, "
                    + "       empresa.\"gerente\"                AS empresa_gerente, "
                    + "       empresa.\"codactividadeconomica\"  AS empresa_codactividadeconomica, "
                    + "       empresa.\"codsectorentidad\"       AS empresa_codsectorentidad, "
                    + "       empresa.\"codtipoaportante\"       AS empresa_codtipoaportante, "
                    + "       empresa.\"email\"                  AS empresa_email, "
                    + "       empresa.\"paginaweb\"              AS empresa_paginaweb, "
                    + "       empresa.\"codtipocontribuyente\"   AS empresa_codtipocontribuyente, "
                    + "       empresa.\"codclasepersona\"        AS empresa_codclasepersona, "
                    + "       empresa.\"empresasistema\"         AS empresa_empresasistema, "
                    + "       empresa.\"empcodigodane\"          AS empresa_empcodigodane, "
                    + "       barrio.\"nombre\"                  AS barrio_nombre, "
                    + "       sectorentidad.\"descripcion\"      AS sectorentidad_descripcion, "
                    + "       tipoidentificacion.\"descripcion\" AS tipoidentificacion_descripcion, "
                    + "       actividadeconomica.\"descripcion\" AS actividadeconomica_descripcion, "
                    + "       tipoaportante.\"descripcion\"      AS tipoaportante_descripcion, "
                    + "       tipocontribuyente.\"descripcion\"  AS tipocontribuyente_descripcion, "
                    + "       clasepersona.\"descripcion\"       AS clasepersona_descripcion "
                    + "FROM   \"public\".\"actividadeconomica\" actividadeconomica "
                    + "       INNER JOIN \"public\".\"empresa\" empresa "
                    + "         ON actividadeconomica.\"codactividadeconomica\" = "
                    + "            empresa.\"codactividadeconomica\" "
                    + "       INNER JOIN \"public\".\"barrio\" barrio "
                    + "         ON empresa.\"coddepartamento\" = barrio.\"coddepartamento\" "
                    + "            AND barrio.\"codbarrio\" = empresa.\"codbarrio\" "
                    + "            AND barrio.\"codmunicipio\" = empresa.\"codmunicipio\" "
                    + "            AND barrio.\"codsubgrupo\" = empresa.\"codsubgrupo\" "
                    + "       INNER JOIN \"public\".\"clasepersona\" clasepersona "
                    + "         ON empresa.\"codclasepersona\" = clasepersona.\"codclasepersona\" "
                    + "       INNER JOIN \"public\".\"sectorentidad\" sectorentidad "
                    + "         ON empresa.\"codsectorentidad\" = sectorentidad.\"codsectorentidad\" "
                    + "       INNER JOIN \"public\".\"tipoaportante\" tipoaportante "
                    + "         ON empresa.\"codtipoaportante\" = tipoaportante.\"codtipoaportante\" "
                    + "       INNER JOIN \"public\".\"tipocontribuyente\" tipocontribuyente "
                    + "         ON empresa.\"codtipocontribuyente\" = "
                    + "            tipocontribuyente.\"codtipocontribuyente\" "
                    + "       INNER JOIN \"public\".\"tipoidentificacion\" tipoidentificacion "
                    + "         ON empresa.\"codtipoidentidad\" = tipoidentificacion.\"codtipoidentidad\" "
                    + "WHERE empresa.codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' "
                    + "AND empresa.codempresa = '" + dkda.o(sel, "codempresa") + "' ";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            
            info += "text|#empcodigodane_empresa|" + (rs.getString("empresa_empcodigodane")
                    == null ? "" : rs.getString("empresa_empcodigodane")) + ":_";
            
            info += "switch|switch_empresasistema_empresa|" + rs.getString("empresa_empresasistema") + ":_";
            
            info += "combo|#codclasepersona_empresa|" + rs.getString("empresa_codclasepersona")
                    + "|llenarCombo('codclasepersona_empresa', '"
                    + rs.getString("empresa_codclasepersona") + "', '"
                    + rs.getString("clasepersona_descripcion") + "'):_";
            
            info += "combo|#codtipocontribuyente_empresa|" + rs.getString("empresa_codtipocontribuyente")
                    + "|llenarCombo('codtipocontribuyente_empresa', '"
                    + rs.getString("empresa_codtipocontribuyente") + "', '"
                    + rs.getString("tipocontribuyente_descripcion") + "'):_";
            
            info += "text|#paginaweb_empresa|" + (rs.getString("empresa_paginaweb")
                    == null ? "" : rs.getString("empresa_paginaweb")) + ":_";
            
            info += "text|#email_empresa|" + (rs.getString("empresa_email")
                    == null ? "" : rs.getString("empresa_email")) + ":_";

            info += "combo|#codtipoaportante_empresa|" + rs.getString("empresa_codtipoaportante")
                    + "|llenarCombo('codtipoaportante_empresa', '"
                    + rs.getString("empresa_codtipoaportante") + "', '"
                    + rs.getString("tipoaportante_descripcion") + "'):_";
            
            info += "combo|#codsectorentidad_empresa|" + rs.getString("empresa_codsectorentidad")
                    + "|llenarCombo('codsectorentidad_empresa', '"
                    + rs.getString("empresa_codsectorentidad") + "', '"
                    + rs.getString("sectorentidad_descripcion") + "'):_";
            
            info += "combo|#codactividadeconomica_empresa|" + rs.getString("empresa_codactividadeconomica")
                    + "|llenarCombo('codactividadeconomica_empresa', '"
                    + rs.getString("empresa_codactividadeconomica") + "', '"
                    + rs.getString("actividadeconomica_descripcion") + "'):_";

            info += "text|#gerente_empresa|" + (rs.getString("empresa_gerente")
                    == null ? "" : rs.getString("empresa_gerente")) + ":_";

            info += "text|#direccion_empresa|" + (rs.getString("empresa_direccion")
                    == null ? "" : rs.getString("empresa_direccion")) + ":_";

            info += "combo|#barrio_empresa_1|" + "barrio   coddepartamento  "
                    + rs.getString("empresa_coddepartamento") + "   codmunicipio  " + rs.getString("empresa_codmunicipio")
                    + "   codsubgrupo  " + rs.getString("empresa_codsubgrupo") + "   "
                    + "codbarrio  " + rs.getString("empresa_codbarrio") + "|llenarCombo('barrio_empresa_1', '"
                    + "barrio   coddepartamento  "
                    + rs.getString("empresa_coddepartamento") + "   codmunicipio  " + rs.getString("empresa_codmunicipio")
                    + "   codsubgrupo  " + rs.getString("empresa_codsubgrupo") + "   "
                    + "codbarrio  " + rs.getString("empresa_codbarrio") + "', '" + rs.getString("barrio_nombre") + "'):_";

            info += "text|#lineagratuita_empresa|" + (rs.getString("empresa_lineagratuita")
                    == null ? "" : rs.getString("empresa_lineagratuita")) + ":_";

            info += "text|#fax_empresa|" + (rs.getString("empresa_fax")
                    == null ? "" : rs.getString("empresa_fax")) + ":_";

            info += "text|#telefono_empresa|" + (rs.getString("empresa_telefono")
                    == null ? "" : rs.getString("empresa_telefono")) + ":_";

            info += "text|#sigla_empresa|" + (rs.getString("empresa_sigla")
                    == null ? "" : rs.getString("empresa_sigla")) + ":_";

            info += "text|#nombre_empresa|" + (rs.getString("empresa_nombre")
                    == null ? "" : rs.getString("empresa_nombre")) + ":_";

            info += "text|#digitoverificacion_empresa|" + (rs.getString("empresa_digitoverificacion")
                    == null ? "" : rs.getString("empresa_digitoverificacion")) + ":_";

            info += "text|#codempresa_empresa|" + (rs.getString("empresa_codempresa")
                    == null ? "" : rs.getString("empresa_codempresa")) + ":_";

            info += "combo|#codtipoidentidad_empresa|" + rs.getString("empresa_codtipoidentidad")
                    + "|llenarCombo('codtipoidentidad_empresa', '"
                    + rs.getString("empresa_codtipoidentidad") + "', '"
                    + rs.getString("tipoidentificacion_descripcion") + "'):_";

            respuesta = "opcion=obtener_empresa&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_empresa&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error empresa - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_empresa() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM empresa  WHERE codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "'" + " AND codempresa = '" + dkda.o(sel, "codempresa") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_empresa() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_empresa() {
        String direccion = "opcion=registrar_empresa&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_empresa();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "codtipoidentidad").toString().equals(dkda.o(vars, "codtipoidentidad_empresa")) && dkda.o(sel, "codempresa").toString().equals(dkda.o(vars, "codempresa_empresa"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "codtipoidentidad_empresa").isEmpty()) {
            error = "Tipo Identificacion: no puede ser vacio.";
        } else if (dkda.o(vars, "codempresa_empresa").isEmpty()) {
            error = "Identificacion Empresa: no puede ser vacio.";
        } else if (dkda.o(vars, "digitoverificacion_empresa").isEmpty()) {
            error = "Digito Verificacion Cuando Documento es NIT: no puede ser vacio.";
        } else if (dkda.o(vars, "nombre_empresa").isEmpty()) {
            error = "Nombre de la empresa: no puede ser vacio.";
        } else if (dkda.o(vars, "sigla_empresa").isEmpty()) {
            error = "Sigla Empresa: no puede ser vacio.";
        } else if (dkda.o(vars, "telefono_empresa").isEmpty()) {
            error = "Numero del telefono: no puede ser vacio.";
        } else if (dkda.o(vars, "fax_empresa").isEmpty()) {
            error = "Numero Fax: no puede ser vacio.";
        } else if (dkda.o(vars, "lineagratuita_empresa").isEmpty()) {
            error = "Linea Telefonica Gratuita: no puede ser vacio.";
        } else if (dkda.o(barrio_empresa_1, "coddepartamento").isEmpty()) {
            error = "Barrio: no puede ser vacio.";
        } else if (dkda.o(vars, "direccion_empresa").isEmpty()) {
            error = "Dirección Empresa: no puede ser vacio.";
        } else if (dkda.o(vars, "gerente_empresa").isEmpty()) {
            error = "Nombre Gerente: no puede ser vacio.";
        } else if (dkda.o(vars, "codactividadeconomica_empresa").isEmpty()) {
            error = "Codigo Actividad Economica: no puede ser vacio.";
        } else if (dkda.o(vars, "codsectorentidad_empresa").isEmpty()) {
            error = "Codigo Sector Entidadades: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoaportante_empresa").isEmpty()) {
            error = "Codigo Tipo Aportante: no puede ser vacio.";
        } else if (dkda.o(vars, "email_empresa").isEmpty()) {
            error = "Correo Electronico: no puede ser vacio.";
        } else if (dkda.o(vars, "paginaweb_empresa").isEmpty()) {
            error = "Nombre Página Web (www.): no puede ser vacio.";
        } else if (dkda.o(vars, "codtipocontribuyente_empresa").isEmpty()) {
            error = "Codigo Tipo Contribuyente DIAN: no puede ser vacio.";
        } else if (dkda.o(vars, "codclasepersona_empresa").isEmpty()) {
            error = "Codigo Tipo Persona: no puede ser vacio.";
        } else if (dkda.o(vars, "empresasistema_empresa").isEmpty()) {
            error = "Empresa Instalado Sistema (S/N): no puede ser vacio.";
        } else if (dkda.o(vars, "empcodigodane_empresa").isEmpty()) {
            error = "Código Dane Empresa: no puede ser vacio.";
        } else if (dkda.o(vars, "nombre_empresa").length() > 150) {
            error = "Nombre de la empresa: Valor demasiado Largo.";
        } else if (dkda.o(vars, "sigla_empresa").length() > 40) {
            error = "Sigla Empresa: Valor demasiado Largo.";
        } else if (dkda.o(vars, "telefono_empresa").length() > 30) {
            error = "Numero del telefono: Valor demasiado Largo.";
        } else if (dkda.o(vars, "fax_empresa").length() > 30) {
            error = "Numero Fax: Valor demasiado Largo.";
        } else if (dkda.o(vars, "lineagratuita_empresa").length() > 20) {
            error = "Linea Telefonica Gratuita: Valor demasiado Largo.";
        } else if (dkda.o(vars, "gerente_empresa").length() > 60) {
            error = "Nombre Gerente: Valor demasiado Largo.";
        } else if (dkda.o(vars, "paginaweb_empresa").length() > 60) {
            error = "Nombre Página Web (www.): Valor demasiado Largo.";
        } else if (dkda.o(vars, "empcodigodane_empresa").length() > 18) {
            error = "Código Dane Empresa: Valor demasiado Largo.";
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