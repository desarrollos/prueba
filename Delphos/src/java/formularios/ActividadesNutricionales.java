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

public class ActividadesNutricionales extends HttpServlet {

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
            String respuesta = validarFormulario_nutricionregistro();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_nutricionregistro(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_nutricionregistro(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_nutricionregistro(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_nutricionregistro(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_nutricionregistro(ConexionBaseDatos con) {
        System.out.println("registrar_nutricionregistro");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO nutricionregistro (nutregid,codtipoidentidadper,nutregideper,codtipoidentidadma,nutregidemad,nutregfecact,nutregfecreg,codtipoactividad,nutregobserv,ususiscodigo,fecharegistro,nutregarchiv,nutregarchiv_nombre) VALUES (" + (dkda.o(vars, "nutregid_nutricionregistro").equals("") ? null : dkda.o(vars, "nutregid_nutricionregistro")) + "," + (dkda.o(vars, "codtipoidentidadper_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadper_nutricionregistro") + "'") + "," + (dkda.o(vars, "nutregideper_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "nutregideper_nutricionregistro") + "'") + "," + (dkda.o(vars, "codtipoidentidadma_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadma_nutricionregistro") + "'") + "," + (dkda.o(vars, "nutregidemad_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "nutregidemad_nutricionregistro") + "'") + "," + (dkda.o(vars, "nutregfecact_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "nutregfecact_nutricionregistro") + "'") + "," + (dkda.o(vars, "nutregfecreg_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "nutregfecreg_nutricionregistro") + "'") + "," + (dkda.o(vars, "codtipoactividad_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "codtipoactividad_nutricionregistro") + "'") + "," + (dkda.o(vars, "nutregobserv_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "nutregobserv_nutricionregistro") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + "," + (dkda.o(vars, "nutregarchiv_nutricionregistro").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "nutregarchiv_nutricionregistro") + "')") + "," + (dkda.o(vars, "nutregarchiv_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "nutregarchiv_nutricionregistro") + "'") + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_nutricionregistro&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_nutricionregistro&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error nutricionregistro.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_nutricionregistro(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE nutricionregistro SET nutregid = " + (dkda.o(vars, "nutregid_nutricionregistro").equals("") ? null : dkda.o(vars, "nutregid_nutricionregistro")) + ",codtipoidentidadper = " + (dkda.o(vars, "codtipoidentidadper_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadper_nutricionregistro") + "'") + ",nutregideper = " + (dkda.o(vars, "nutregideper_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "nutregideper_nutricionregistro") + "'") + ",codtipoidentidadma = " + (dkda.o(vars, "codtipoidentidadma_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidadma_nutricionregistro") + "'") + ",nutregidemad = " + (dkda.o(vars, "nutregidemad_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "nutregidemad_nutricionregistro") + "'") + ",nutregfecact = " + (dkda.o(vars, "nutregfecact_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "nutregfecact_nutricionregistro") + "'") + ",nutregfecreg = " + (dkda.o(vars, "nutregfecreg_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "nutregfecreg_nutricionregistro") + "'") + ",codtipoactividad = " + (dkda.o(vars, "codtipoactividad_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "codtipoactividad_nutricionregistro") + "'") + ",nutregobserv = " + (dkda.o(vars, "nutregobserv_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "nutregobserv_nutricionregistro") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + ",nutregarchiv = " + (dkda.o(vars, "nutregarchiv_nutricionregistro").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "nutregarchiv_nutricionregistro") + "')") + ",nutregarchiv_nombre = " + (dkda.o(vars, "nutregarchiv_nutricionregistro").equals("") ? null : "'" + dkda.o(vars, "nutregarchiv_nutricionregistro") + "'") + " WHERE nutregid = " + dkda.o(vars, "codigo") + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_nutricionregistro&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_nutricionregistro&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error nutricionregistro.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_nutricionregistro(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM nutricionregistro WHERE nutregid = " + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "");
            stmt.execute();
            respuesta = "opcion=eliminar_nutricionregistro&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_nutricionregistro&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error nutricionregistro.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_nutricionregistro(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT"
                    + "     nutricionregistro.nutregid AS nutricionregistro_nutregid,     nutricionregistro.codtipoidentidadper AS nutricionregistro_codtipoidentidadper,"
                    + "     nutricionregistro.nutregideper AS nutricionregistro_nutregideper,     nutricionregistro.codtipoidentidadma AS nutricionregistro_codtipoidentidadma,"
                    + "     nutricionregistro.nutregidemad AS nutricionregistro_nutregidemad,"
                    + "     nutricionregistro.nutregfecact AS nutricionregistro_nutregfecact,"
                    + "     nutricionregistro.nutregfecreg AS nutricionregistro_nutregfecreg,"
                    + "     nutricionregistro.codtipoactividad AS nutricionregistro_codtipoactividad,"
                    + "     tipoactividad.descripcion AS tipoactividad_descripcion,"
                    + "     nutricionregistro.nutregarchiv AS nutricionregistro_nutregarchiv,"
                    + "     nutricionregistro.nutregobserv AS nutricionregistro_nutregobserv,"
                    + "    nutricionregistro.ususiscodigo AS nutricionregistro_ususiscodigo,"
                    + "     nutricionregistro.fecharegistro AS nutricionregistro_fecharegistro,"
                    + "   (SELECT descripcion FROM nutricionregistro , tipoidentificacion WHERE tipoidentificacion.codtipoidentidad =  nutricionregistro.codtipoidentidadper AND nutricionregistro.nutregid = '" + codigo + "' ) AS TipoIdent_per,"
                    + "    (SELECT descripcion FROM nutricionregistro , tipoidentificacion WHERE tipoidentificacion.codtipoidentidad =  nutricionregistro.codtipoidentidadma AND nutricionregistro.nutregid = '" + codigo + "' ) AS TipoIdent_ma,"
                    + "    nutricionregistro.nutregarchiv_nombre AS nutricionregistro_nutregarchiv_nombre"
                    + " FROM "
                    + "     public.tipoactividad tipoactividad , public.nutricionregistro nutricionregistro "
                    + " WHERE nutricionregistro.codtipoactividad = tipoactividad.codtipoactividad AND  nutricionregistro.nutregid  = '" + codigo + "'";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#nutregid_nutricionregistro|"
                    + (rs.getString("nutricionregistro_nutregid") == null ? ""
                    : rs.getString("nutricionregistro_nutregid")) + ":_";

            info += "combo|#codtipoidentidadper_nutricionregistro|" + rs.getString("nutricionregistro_codtipoidentidadper")
                    + "|llenarCombo('codtipoidentidadper_nutricionregistro', '" + rs.getString("nutricionregistro_codtipoidentidadper")
                    + "', '" + rs.getString("TipoIdent_per") + "'):_";

            info += "text|#nutregideper_nutricionregistro|"
                    + (rs.getString("nutricionregistro_nutregideper") == null ? ""
                    : rs.getString("nutricionregistro_nutregideper")) + ":_";
            
            info += "combo|#codtipoidentidadma_nutricionregistro|" + rs.getString("nutricionregistro_codtipoidentidadma")
                    + "|llenarCombo('codtipoidentidadma_nutricionregistro', '" + rs.getString("nutricionregistro_codtipoidentidadma")
                    + "', '" + rs.getString("TipoIdent_ma") + "'):_";

            info += "text|#nutregidemad_nutricionregistro|"
                    + (rs.getString("nutricionregistro_nutregidemad") == null ? ""
                    : rs.getString("nutricionregistro_nutregidemad")) + ":_";
            
             info += "combo|#codtipoactividad_nutricionregistro|" + rs.getString("nutricionregistro_codtipoactividad")
                    + "|llenarCombo('codtipoactividad_nutricionregistro', '" + rs.getString("nutricionregistro_codtipoactividad")
                    + "', '" + rs.getString("tipoactividad_descripcion") + "'):_";
             
             info += "text|#_fecha_nutregfecact_nutricionregistro|" + (rs.getString("nutricionregistro_nutregfecact") == null ? ""
                     : rs.getString("nutricionregistro_nutregfecact")) + ":_";

             info += "text|#_fecha_nutregfecreg_nutricionregistro|" + (rs.getString("nutricionregistro_nutregfecreg") == null ? ""
                     : rs.getString("nutricionregistro_nutregfecreg")) + ":_";
             
             info += "text|#nutregobserv_nutricionregistro|"
                    + (rs.getString("nutricionregistro_nutregobserv") == null ? ""
                    : rs.getString("nutricionregistro_nutregobserv")) + ":_";
             
             info += "text|#nutregarchiv_nutricionregistro|" + (rs.getString("nutricionregistro_nutregarchiv_nombre") == null ? "" 
                     : rs.getString("nutricionregistro_nutregarchiv_nombre")) + ":_";
             
            respuesta = "opcion=obtener_nutricionregistro&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_nutricionregistro&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error nutricionregistro - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_nutricionregistro() {
        String direccion = "opcion=registrar_nutricionregistro&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = existe_nutricionregistro();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "nutregid_nutricionregistro"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "nutregid_nutricionregistro").isEmpty()) {
            error = "Número Registro Nutrición: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidadper_nutricionregistro").isEmpty()) {
            error = "Tipo Identificación Persona: no puede ser vacio.";
        } else if (dkda.o(vars, "nutregideper_nutricionregistro").isEmpty()) {
            error = "Identificación Persona: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidadma_nutricionregistro").isEmpty()) {
            error = "Tipo Identificacion Madre: no puede ser vacio.";
        } else if (dkda.o(vars, "nutregidemad_nutricionregistro").isEmpty()) {
            error = "Identificación Madre: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoactividad_nutricionregistro").isEmpty()) {
            error = "Tipo de actividad: no puede ser vacio.";
        } else if (dkda.o(vars, "nutregfecact_nutricionregistro").isEmpty()) {
            error = "Fecha Actividad : no puede ser vacio.";
        } else if (dkda.o(vars, "nutregfecreg_nutricionregistro").isEmpty()) {
            error = "Fecha del Registro: no puede ser vacio.";
        } else if (dkda.o(vars, "nutregarchiv_nutricionregistro").isEmpty()) {
            error = "Archivo Documento o Certificado: no puede ser vacio.";
        } else if (dkda.o(vars, "nutregobserv_nutricionregistro").isEmpty()) {
            error = "Observaciones Registro Actividad Nutrición: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "nutregideper_nutricionregistro"))) {
            error = "Identificación Persona: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "nutregidemad_nutricionregistro"))) {
            error = "Identificación Madre: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "nutregid_nutricionregistro").length() > 9) {
            error = "Número Registro Nutrición: Valor demasiado Largo.";
        } else if (dkda.o(vars, "nutregideper_nutricionregistro").length() > 18) {
            error = "Identificación Persona: Valor demasiado Largo.";
        } else if (dkda.o(vars, "nutregidemad_nutricionregistro").length() > 18) {
            error = "Identificación Madre: Valor demasiado Largo.";
        } else if (dkda.o(vars, "nutregobserv_nutricionregistro").length() > 400) {
            error = "Observaciones Registro Actividad Nutrición: Valor demasiado Largo.";
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

    private boolean existe_nutricionregistro() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM nutricionregistro  WHERE nutregid = " + dkda.o(vars, "nutregid_nutricionregistro") + "");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_nutricionregistro() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }
}