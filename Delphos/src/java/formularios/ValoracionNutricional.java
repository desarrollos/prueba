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

public class ValoracionNutricional extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "", opcion = "";
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
            opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_nutricionvaloracion();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_nutricionvaloracion(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_nutricionvaloracion(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_nutricionvaloracion(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_nutricionvaloracion(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_nutricionvaloracion(ConexionBaseDatos con) {
        System.out.println("registrar_nutricionvaloracion");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO nutricionvaloracion (nutridregist,codtipoidentidad,nutridentifi,nutrcantidad,nutrfechatennutrfechaten,codfinalidadconsulta,coddiagnosticopr,coddiagnosticor1,coddiagnosticor2,coddiagnosticor3,coddiagnosticosa,nutrobservac,ususiscodigo,fecharegistro,nutrarchivo,nutrarchivo_nombre) VALUES (" + (dkda.o(vars, "nutridregist_nutricionvaloracion").equals("") ? null : dkda.o(vars, "nutridregist_nutricionvaloracion")) + "," + (dkda.o(vars, "codtipoidentidad_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_nutricionvaloracion") + "'") + "," + (dkda.o(vars, "nutridentifi_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "nutridentifi_nutricionvaloracion") + "'") + "," + (dkda.o(vars, "nutrcantidad_nutricionvaloracion").equals("") ? null : dkda.o(vars, "nutrcantidad_nutricionvaloracion")) + "," + (dkda.o(vars, "nutrfechatennutrfechaten_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "nutrfechatennutrfechaten_nutricionvaloracion") + "'") + "," + (dkda.o(vars, "codfinalidadconsulta_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "codfinalidadconsulta_nutricionvaloracion") + "'") + "," + (dkda.o(vars, "coddiagnosticopr_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "coddiagnosticopr_nutricionvaloracion") + "'") + "," + (dkda.o(vars, "coddiagnosticor1_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "coddiagnosticor1_nutricionvaloracion") + "'") + "," + (dkda.o(vars, "coddiagnosticor2_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "coddiagnosticor2_nutricionvaloracion") + "'") + "," + (dkda.o(vars, "coddiagnosticor3_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "coddiagnosticor3_nutricionvaloracion") + "'") + "," + (dkda.o(vars, "coddiagnosticosa_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "coddiagnosticosa_nutricionvaloracion") + "'") + "," + (dkda.o(vars, "nutrobservac_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "nutrobservac_nutricionvaloracion") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "nutrarchivo_nutricionvaloracion").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "nutrarchivo_nutricionvaloracion") + "')") + "," + (dkda.o(vars, "nutrarchivo_nombre_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "nutrarchivo_nombre_nutricionvaloracion") + "'") + ")";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_nutricionvaloracion&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_nutricionvaloracion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error nutricionvaloracion.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_nutricionvaloracion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE nutricionvaloracion SET nutridregist = " + (dkda.o(vars, "nutridregist_nutricionvaloracion").equals("") ? null : dkda.o(vars, "nutridregist_nutricionvaloracion")) + ",codtipoidentidad = " + (dkda.o(vars, "codtipoidentidad_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_nutricionvaloracion") + "'") + ",nutridentifi = " + (dkda.o(vars, "nutridentifi_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "nutridentifi_nutricionvaloracion") + "'") + ",nutrcantidad = " + (dkda.o(vars, "nutrcantidad_nutricionvaloracion").equals("") ? null : dkda.o(vars, "nutrcantidad_nutricionvaloracion")) + ",nutrfechatennutrfechaten = " + (dkda.o(vars, "nutrfechatennutrfechaten_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "nutrfechatennutrfechaten_nutricionvaloracion") + "'") + ",codfinalidadconsulta = " + (dkda.o(vars, "codfinalidadconsulta_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "codfinalidadconsulta_nutricionvaloracion") + "'") + ",coddiagnosticopr = " + (dkda.o(vars, "coddiagnosticopr_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "coddiagnosticopr_nutricionvaloracion") + "'") + ",coddiagnosticor1 = " + (dkda.o(vars, "coddiagnosticor1_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "coddiagnosticor1_nutricionvaloracion") + "'") + ",coddiagnosticor2 = " + (dkda.o(vars, "coddiagnosticor2_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "coddiagnosticor2_nutricionvaloracion") + "'") + ",coddiagnosticor3 = " + (dkda.o(vars, "coddiagnosticor3_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "coddiagnosticor3_nutricionvaloracion") + "'") + ",coddiagnosticosa = " + (dkda.o(vars, "coddiagnosticosa_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "coddiagnosticosa_nutricionvaloracion") + "'") + ",nutrobservac = " + (dkda.o(vars, "nutrobservac_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "nutrobservac_nutricionvaloracion") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",nutrarchivo = " + (dkda.o(vars, "nutrarchivo_nutricionvaloracion").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "nutrarchivo_nutricionvaloracion") + "')") + ",nutrarchivo_nombre = " + (dkda.o(vars, "nutrarchivo_nombre_nutricionvaloracion").equals("") ? null : "'" + dkda.o(vars, "nutrarchivo_nombre_nutricionvaloracion") + "'") + " WHERE nutridregist = " + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_nutricionvaloracion&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_nutricionvaloracion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error nutricionvaloracion.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_nutricionvaloracion(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM nutricionvaloracion WHERE nutridregist = " + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "");
            stmt.execute();
            respuesta = "opcion=eliminar_nutricionvaloracion&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_nutricionvaloracion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error nutricionvaloracion.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_nutricionvaloracion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "nutricionvaloracion.nutridregist AS nutricionvaloracion_nutridregist,"
                    + "nutricionvaloracion.codtipoidentidad AS nutricionvaloracion_codtipoidentidad,"
                    + "nutricionvaloracion.nutridentifi AS nutricionvaloracion_nutridentifi,"
                    + "nutricionvaloracion.nutrcantidad AS nutricionvaloracion_nutrcantidad,"
                    + "nutricionvaloracion.nutrfechatennutrfechaten AS nutricionvaloracion_nutrfechatennutrfechaten,"
                    + "nutricionvaloracion.codfinalidadconsulta AS nutricionvaloracion_codfinalidadconsulta,"
                    + "nutricionvaloracion.coddiagnosticopr AS nutricionvaloracion_coddiagnosticopr,"
                    + "nutricionvaloracion.coddiagnosticor1 AS nutricionvaloracion_coddiagnosticor1,"
                    + "nutricionvaloracion.coddiagnosticor2 AS nutricionvaloracion_coddiagnosticor2,"
                    + "nutricionvaloracion.coddiagnosticor3 AS nutricionvaloracion_coddiagnosticor3,"
                    + "nutricionvaloracion.coddiagnosticosa AS nutricionvaloracion_coddiagnosticosa,"
                    + "nutricionvaloracion.nutrarchivo AS nutricionvaloracion_nutrarchivo,"
                    + "nutricionvaloracion.nutrobservac AS nutricionvaloracion_nutrobservac,"
                    + "tipoidentificacion.codtipoidentidad AS tipoidentificacion_codtipoidentidad,"
                    + "tipoidentificacion.descripcion AS tipoidentificacion_descripcion,"
                    + "tipoidentificacion.codalterno AS tipoidentificacion_codalterno,"
                    + "finalidadconsulta.codfinalidadconsulta AS finalidadconsulta_codfinalidadconsulta,"
                    + "finalidadconsulta.descripcion AS finalidadconsulta_descripcion "
                    + " FROM "
                    + " public.nutricionvaloracion nutricionvaloracion INNER JOIN public.tipoidentificacion tipoidentificacion ON nutricionvaloracion.codtipoidentidad = tipoidentificacion.codtipoidentidad"
                    + " INNER JOIN public.finalidadconsulta finalidadconsulta ON nutricionvaloracion.codfinalidadconsulta = finalidadconsulta.codfinalidadconsulta WHERE "
                    + "nutricionvaloracion.nutridregist = " + dkda.o(vars, "codigo");



            System.out.println("Codigo : " + dkda.o(vars, "codigo"));
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#nutridregist_nutricionvaloracion|" + (rs.getString("nutricionvaloracion_nutridregist") == null ? "" : rs.getString("nutricionvaloracion_nutridregist")) + ":_";
            info += "text|#_fecha_nutrfechatennutrfechaten_nutricionvaloracion|" + (rs.getString("nutricionvaloracion_nutrfechatennutrfechaten") == null ? "" : rs.getString("nutricionvaloracion_nutrfechatennutrfechaten")) + ":_";


            /*
            info += "combo|#_fecha_nutrfechatennutrfechaten_nutricionvaloracion|" + rs.getString("tipoasistente_tipasicodigo") + "|llenarCombo('tipasicodigo_asistentes', '"
            + rs.getString("tipoasistente_tipasicodigo") + "', '" + rs.getString("tipoasistente_tipasidescri") + "'):";
            
             */
            respuesta = "opcion=obtener_nutricionvaloracion&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_nutricionvaloracion&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error nutricionvaloracion - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_nutricionvaloracion() {
        String direccion = "opcion=registrar_nutricionvaloracion&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_nutricionvaloracion();

        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "nutridregist_nutricionvaloracion"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "nutridregist_nutricionvaloracion").isEmpty()) {
            error = "Codigo Valoracion: no puede ser vacio.";
        } else if (dkda.o(vars, "nutrfechatennutrfechaten_nutricionvaloracion").isEmpty()) {
            error = "Fecha Atencion: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_nutricionvaloracion").isEmpty()) {
            error = "Tipo Identificacion: no puede ser vacio.";
        } else if (dkda.o(vars, "nutridentifi_nutricionvaloracion").isEmpty()) {
            error = "Numero  Identificacion: no puede ser vacio.";
        } else if (dkda.o(vars, "nutrcantidad_nutricionvaloracion").isEmpty()) {
            error = "Numero  Identificacion: no puede ser vacio.";
        } else if (dkda.o(vars, "codfinalidadconsulta_nutricionvaloracion").isEmpty()) {
            error = "Finalidad Consulta : no puede ser vacio.";
        } else if (dkda.o(vars, "coddiagnosticopr_nutricionvaloracion").isEmpty()) {
            error = "Dx Principal: no puede ser vacio.";
        } else if (dkda.o(vars, "coddiagnosticor1_nutricionvaloracion").isEmpty()) {
            error = "Dx Relacionado 1: no puede ser vacio.";
        } else if (dkda.o(vars, "coddiagnosticor2_nutricionvaloracion").isEmpty()) {
            error = "Dx Relacionado 2: no puede ser vacio.";
        } else if (dkda.o(vars, "coddiagnosticor3_nutricionvaloracion").isEmpty()) {
            error = "Dx Relacionado 3: no puede ser vacio.";
        } else if (dkda.o(vars, "coddiagnosticosa_nutricionvaloracion").isEmpty()) {
            error = "Dx Salida: no puede ser vacio.";
        } else if (dkda.o(vars, "nutrarchivo_nutricionvaloracion").isEmpty()) {
            error = "Archivo Documento: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "nutrcantidad_nutricionvaloracion"))) {
            error = "Numero  Identificacion: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "nutridregist_nutricionvaloracion").length() > 9) {
            error = "Codigo Valoracion: Valor demasiado Largo.";
        } else if (dkda.o(vars, "nutridentifi_nutricionvaloracion").length() > 18) {
            error = "Numero  Identificacion: Valor demasiado Largo.";
        } else if (dkda.o(vars, "nutrcantidad_nutricionvaloracion").length() > 9) {
            error = "Numero  Identificacion: Valor demasiado Largo.";
        } else if (dkda.o(vars, "coddiagnosticopr_nutricionvaloracion").length() > 6) {
            error = "Dx Principal: Valor demasiado Largo.";
        } else if (dkda.o(vars, "coddiagnosticor1_nutricionvaloracion").length() > 6) {
            error = "Dx Relacionado 1: Valor demasiado Largo.";
        } else if (dkda.o(vars, "nutrobservac_nutricionvaloracion").length() > 400) {
            error = "Observaciones: Valor demasiado Largo.";
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

    
    private boolean existe_nutricionvaloracion() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM nutricionvaloracion  WHERE nutridregist = " + ( opcion.equals("Registrar") ? dkda.o(vars, "nutridregist_nutricionvaloracion") : dkda.o(vars, "codigo") ) + "");
            System.out.println("SELECT COUNT(*) FROM nutricionvaloracion  WHERE nutridregist = " + ( opcion.equals("Registrar") ? dkda.o(vars, "nutridregist_nutricionvaloracion") : dkda.o(vars, "codigo") ) + "");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_nutricionvaloracion() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }
}