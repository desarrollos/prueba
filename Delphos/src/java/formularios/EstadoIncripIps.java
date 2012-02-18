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

public class EstadoIncripIps extends HttpServlet {

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
            String respuesta = validarFormulario_estadoincripips();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_estadoincripips(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_estadoincripips(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_estadoincripips(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_estadoincripips(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_estadoincripips(ConexionBaseDatos con) {
        System.out.println("registrar_estadoincripips");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO estadoincripips (esinipscodigo,esinipsdescri,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "esinipscodigo_estadoincripips").equals("") ? null : "'" + dkda.o(vars, "esinipscodigo_estadoincripips") + "'") + "," + (dkda.o(vars, "esinipsdescri_estadoincripips").equals("") ? null : "'" + dkda.o(vars, "esinipsdescri_estadoincripips") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_estadoincripips&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_estadoincripips&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error estadoincripips.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_estadoincripips(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE estadoincripips SET esinipscodigo = " + (dkda.o(vars, "esinipscodigo_estadoincripips").equals("") ? null : "'" + dkda.o(vars, "esinipscodigo_estadoincripips") + "'") + ",esinipsdescri = " + (dkda.o(vars, "esinipsdescri_estadoincripips").equals("") ? null : "'" + dkda.o(vars, "esinipsdescri_estadoincripips") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE esinipscodigo = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_estadoincripips&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_estadoincripips&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error estadoincripips.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_estadoincripips(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM estadoincripips WHERE esinipscodigo = '" + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_estadoincripips&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_estadoincripips&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error estadoincripips.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_estadoincripips(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "estadoincripips.esinipscodigo AS estadoincripips_esinipscodigo,"
                    + "estadoincripips.esinipsdescri AS estadoincripips_esinipsdescri"
                    + " FROM "
                    + "public.estadoincripips estadoincripips WHERE esinipscodigo = '" + dkda.o(vars, "codigo") + "' ";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#esinipscodigo_estadoincripips|" + (rs.getString("estadoincripips_esinipscodigo") == null ? "" : rs.getString("estadoincripips_esinipscodigo")) + ":_";
            info += "text|#esinipsdescri_estadoincripips|" + (rs.getString("estadoincripips_esinipsdescri") == null ? "" : rs.getString("estadoincripips_esinipsdescri")) + ":_";
            

            respuesta = "opcion=obtener_estadoincripips&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_estadoincripips&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error estadoincripips - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    private boolean existe_estadoincripips() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM estadoincripips  WHERE esinipscodigo = '" + dkda.o(vars, "esinipscodigo") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_estadoincripips() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }

    public String validarFormulario_estadoincripips() {
        String direccion = "opcion=registrar_estadoincripips&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_estadoincripips();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(sel, "esinipscodigo").toString().equals(dkda.o(vars, "esinipscodigo_estadoincripips"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "esinipscodigo_estadoincripips").isEmpty()) {
            error = "C&oacute;digo Estado Inscripci&oacute;n: no puede ser vacio.";
        } else if (dkda.o(vars, "esinipsdescri_estadoincripips").isEmpty()) {
            error = "Descripci&oacute;n Estado Inscripci&oacute;n IPS: no puede ser vacio.";
        } else if (!v.alfaNumericos(dkda.o(vars, "esinipscodigo_estadoincripips"))) {
            error = "C&oacute;digo Estado Inscripci&oacute;n: Tiene Caracteres no permitidos.";
        } else if (dkda.o(vars, "esinipscodigo_estadoincripips").length() > 1) {
            error = "C&oacute;digo Estado Inscripci&oacute;n: Valor demasiado Largo.";
        } else if (dkda.o(vars, "esinipsdescri_estadoincripips").length() > 30) {
            error = "Descripci&oacute;n Estado Inscripci&oacute;n IPS: Valor demasiado Largo.";
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
}