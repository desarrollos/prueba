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

public class TipoSubsidio extends HttpServlet {

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
            String respuesta = validarFormulario_tiposubsidio();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_tiposubsidio(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_tiposubsidio(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_tiposubsidio(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_tiposubsidio(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_tiposubsidio(ConexionBaseDatos con) {
        System.out.println("registrar_tiposubsidio");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO tiposubsidio (subtipcodigo,subtipdescri,subtipedaini,subtipedafin,subtipgraini,subtipgrafin,subcatcodigo,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "subtipcodigo_tiposubsidio").equals("") ? null : "'" + dkda.o(vars, "subtipcodigo_tiposubsidio") + "'") + "," + (dkda.o(vars, "subtipdescri_tiposubsidio").equals("") ? null : "'" + dkda.o(vars, "subtipdescri_tiposubsidio") + "'") + "," + (dkda.o(vars, "subtipedaini_tiposubsidio").equals("") ? null : dkda.o(vars, "subtipedaini_tiposubsidio")) + "," + (dkda.o(vars, "subtipedafin_tiposubsidio").equals("") ? null : dkda.o(vars, "subtipedafin_tiposubsidio")) + "," + (dkda.o(vars, "subtipgraini_tiposubsidio").equals("") ? null : "'" + dkda.o(vars, "subtipgraini_tiposubsidio") + "'") + "," + (dkda.o(vars, "subtipgrafin_tiposubsidio").equals("") ? null : "'" + dkda.o(vars, "subtipgrafin_tiposubsidio") + "'") + "," + (dkda.o(vars, "subcatcodigo_tiposubsidio").equals("") ? null : "'" + dkda.o(vars, "subcatcodigo_tiposubsidio") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_tiposubsidio&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_tiposubsidio&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error tiposubsidio.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_tiposubsidio(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE tiposubsidio SET subtipcodigo = " + (dkda.o(vars, "subtipcodigo_tiposubsidio").equals("") ? null : "'" + dkda.o(vars, "subtipcodigo_tiposubsidio") + "'") + ",subtipdescri = " + (dkda.o(vars, "subtipdescri_tiposubsidio").equals("") ? null : "'" + dkda.o(vars, "subtipdescri_tiposubsidio") + "'") + ",subtipedaini = " + (dkda.o(vars, "subtipedaini_tiposubsidio").equals("") ? null : dkda.o(vars, "subtipedaini_tiposubsidio")) + ",subtipedafin = " + (dkda.o(vars, "subtipedafin_tiposubsidio").equals("") ? null : dkda.o(vars, "subtipedafin_tiposubsidio")) + ",subtipgraini = " + (dkda.o(vars, "subtipgraini_tiposubsidio").equals("") ? null : "'" + dkda.o(vars, "subtipgraini_tiposubsidio") + "'") + ",subtipgrafin = " + (dkda.o(vars, "subtipgrafin_tiposubsidio").equals("") ? null : "'" + dkda.o(vars, "subtipgrafin_tiposubsidio") + "'") + ",subcatcodigo = " + (dkda.o(vars, "subcatcodigo_tiposubsidio").equals("") ? null : "'" + dkda.o(vars, "subcatcodigo_tiposubsidio") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE subtipcodigo = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_tiposubsidio&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_tiposubsidio&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error tiposubsidio.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_tiposubsidio(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM tiposubsidio WHERE subtipcodigo = '" + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_tiposubsidio&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_tiposubsidio&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error tiposubsidio.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_tiposubsidio(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " SELECT   tiposubsidio.subtipcodigo,   tiposubsidio.subtipdescri,   tiposubsidio.subtipedaini,   tiposubsidio.subtipedafin,   tiposubsidio.subtipgraini,   tiposubsidio.subtipgrafin,   tiposubsidio.subcatcodigo,  tiposubsidio.ususiscodigo, "
                    + "  tiposubsidio.fecharegistro,   subsidiocategoria.subcatdescri AS CategoriaSubsidioD ,  tiposubsidio.subcatcodigo AS CategoriaSubsidioC,"
                    + "  (SELECT escgradescri FROM escolaridadgrado , tiposubsidio  WHERE escgracodigo =  subtipgraini AND subtipcodigo = '" + codigo + "' ) AS GradoEscolaridadInicial,"
                    + "  tiposubsidio.subtipgraini AS gei,"
                    + "  (SELECT escgradescri FROM escolaridadgrado , tiposubsidio  WHERE escgracodigo =  subtipgrafin AND subtipcodigo = '" + codigo + "' ) AS GradoEscolaridaFinalidad,"
                    + "  tiposubsidio.subtipgrafin AS gef "
                    + " FROM "
                    + "  public.tiposubsidio tiposubsidio, "
                    + "    public.subsidiocategoria "
                    + " WHERE "
                    + "    tiposubsidio.subcatcodigo = subsidiocategoria.subcatcodigo AND  tiposubsidio.subtipcodigo =  '" + codigo + "';";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#subtipcodigo_tiposubsidio|"
                    + (rs.getString(1) == null ? ""
                    : rs.getString(1)) + ":_";
            info += "text|#subtipdescri_tiposubsidio|"
                    + (rs.getString(2) == null ? ""
                    : rs.getString(2)) + ":_";
            info += "text|#subtipedaini_tiposubsidio|"
                    + (rs.getString(3) == null ? ""
                    : rs.getString(3)) + ":_";
            info += "text|#subtipedafin_tiposubsidio|"
                    + (rs.getString(4) == null ? ""
                    : rs.getString(4)) + ":_";

            info += "combo|#subcatcodigo_tiposubsidio|" + rs.getString("CategoriaSubsidioC")
                    + "|llenarCombo('subcatcodigo_tiposubsidio', '" + rs.getString("CategoriaSubsidioC")
                    + "', '" + rs.getString("CategoriaSubsidioD") + "'):_";
            
            info += "combo|#subtipgraini_tiposubsidio|" + rs.getString("gei")
                    + "|llenarCombo('subtipgraini_tiposubsidio', '" + rs.getString("gei")
                    + "', '" + rs.getString("GradoEscolaridadInicial") + "'):_";
            
            info += "combo|#subtipgrafin_tiposubsidio|" + rs.getString("gef")
                    + "|llenarCombo('subtipgrafin_tiposubsidio', '" + rs.getString("gef")
                    + "', '" + rs.getString("GradoEscolaridaFinalidad") + "'):_";
            

            respuesta = "opcion=obtener_tiposubsidio&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_tiposubsidio&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error tiposubsidio - Obtener.java: " + e.getMessage());
        }
        
        return respuesta;
    }

    public String validarFormulario_tiposubsidio() {
        String direccion = "opcion=registrar_tiposubsidio&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = existe_tiposubsidio();
        System.out.println("Existe : "+existe);
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "subtipcodigo_tiposubsidio").toString().equals(dkda.o(vars, "subtipcodigo_tiposubsidio"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "subtipcodigo_tiposubsidio").isEmpty()) {
            error = "Código Tipo Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subcatcodigo_tiposubsidio").isEmpty()) {
            error = "Categoria Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subtipedaini_tiposubsidio").isEmpty()) {
            error = "Edad Inicial: no puede ser vacio.";
        } else if (dkda.o(vars, "subtipedafin_tiposubsidio").isEmpty()) {
            error = "Edad Final: no puede ser vacio.";
        } else if (dkda.o(vars, "subtipgraini_tiposubsidio").isEmpty()) {
            error = "Grado Escolaridad Inicial: no puede ser vacio.";
        } else if (dkda.o(vars, "subtipgrafin_tiposubsidio").isEmpty()) {
            error = "Grado Escolaridad Final: no puede ser vacio.";
        } else if (!v.numeros(dkda.o(vars, "subtipedaini_tiposubsidio"))) {
            error = "Edad Inicial: Tiene Caracteres no permitidos.";
        } else if (!v.numeros(dkda.o(vars, "subtipedafin_tiposubsidio"))) {
            error = "Edad Final: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "subtipcodigo_tiposubsidio").length() > 3) {
            error = "Código Tipo Subsidio: Valor demasiado Largo.";
        } else if (dkda.o(vars, "subtipedaini_tiposubsidio").length() > 4) {
            error = "Edad Inicial: Valor demasiado Largo.";
        } else if (dkda.o(vars, "subtipedafin_tiposubsidio").length() > 4) {
            error = "Edad Final: Valor demasiado Largo.";
        } else if (dkda.o(vars, "subtipdescri_tiposubsidio").length() > 30) {
            error = "Descripción: Valor demasiado Largo.";
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

    private boolean existe_tiposubsidio() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM tiposubsidio  WHERE subtipcodigo = '" + dkda.o(vars, "codigo") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_tiposubsidio() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }
}