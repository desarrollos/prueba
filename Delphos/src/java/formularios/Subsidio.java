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
            
            info += "text|#subscodigo_subsidio|" + (rs.getString("subsidio_subscodigo") == null ? "" : 
                    rs.getString("subsidio_subscodigo")) + ":_";
            
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
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM subsidio  WHERE subscodigo = '" + dkda.o(vars, "subscodigo") + "'");
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
            if (!(dkda.o(sel, "subscodigo").toString().equals(dkda.o(vars, "subscodigo_subsidio"))) && existe == true) {
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
        } else if (dkda.o(vars, "codtiponorma_subsidio").isEmpty()) {
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
            String sql = "";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            respuesta = "opcion=obtener_subsidiomunicipio&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_subsidiomunicipio&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error subsidiomunicipio - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_subsidiomunicipio() {
        String direccion = "opcion=registrar_subsidiomunicipio&&estado=no&&error=si&&errorDes=";
        String error = "";
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
            String sql = "UPDATE subsidiopotencial SET codunifami = " + (dkda.o(vars, "codunifami_subsidiopotencial").equals("") ? null : "'" + dkda.o(vars, "codunifami_subsidiopotencial") + "'") + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_subsidiopotencial").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_subsidiopotencial") + "'") + ",subpotidenti = " + (dkda.o(vars, "subpotidenti_subsidiopotencial").equals("") ? null : "'" + dkda.o(vars, "subpotidenti_subsidiopotencial") + "'") + ",subscodigo = " + (dkda.o(vars, "subscodigo_subsidiopotencial").equals("") ? null : "'" + dkda.o(vars, "subscodigo_subsidiopotencial") + "'") + ",subpotvalsub = " + (dkda.o(vars, "subpotvalsub_subsidiopotencial").equals("") ? null : dkda.o(vars, "subpotvalsub_subsidiopotencial")) + ",coddepartamento = " + (dkda.o(municipio_subsidiopotencial_1, "coddepartamento").equals("") ? null : dkda.o(municipio_subsidiopotencial_1, "coddepartamento")) + ",codmunicipio = " + (dkda.o(municipio_subsidiopotencial_1, "codmunicipio").equals("") ? null : dkda.o(municipio_subsidiopotencial_1, "codmunicipio")) + ",subpotdescri = " + (dkda.o(vars, "subpotdescri_subsidiopotencial").equals("") ? null : "'" + dkda.o(vars, "subpotdescri_subsidiopotencial") + "'") + ",subpotobserv = " + (dkda.o(vars, "subpotobserv_subsidiopotencial").equals("") ? null : "'" + dkda.o(vars, "subpotobserv_subsidiopotencial") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codunifami = '" + dkda.o(sel, "codunifami") + "' AND codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND subpotidenti = '" + dkda.o(sel, "subpotidenti") + "' ";
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
            String sql = "";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            respuesta = "opcion=obtener_subsidiopotencial&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_subsidiopotencial&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error subsidiopotencial - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_subsidiopotencial() {
        String direccion = "opcion=registrar_subsidiopotencial&&estado=no&&error=si&&errorDes=";
        String error = "";
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
            String sql = "";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            respuesta = "opcion=obtener_subsidioasignado&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_subsidioasignado&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error subsidioasignado - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_subsidioasignado() {
        String direccion = "opcion=registrar_subsidioasignado&&estado=no&&error=si&&errorDes=";
        String error = "";
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