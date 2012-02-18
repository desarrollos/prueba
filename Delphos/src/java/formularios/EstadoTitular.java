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

public class EstadoTitular extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");



        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_estadoTitular();

            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_estadoTitular(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_estadoTitular(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_estadoTitular(con));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_estadoTitular());
                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_estadoTitular(ConexionBaseDatos con) {

        System.out.println("REGISGRANDO Estado Titular");
        con.abrirConexion();
        //
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO estadotitular (codiesttit, descripcion, ususiscodigo, fecharegistro) VALUES (" + (dkda.o(vars, "codiesttit_estadotitular").equals("") ? null : "'" + dkda.o(vars, "codiesttit_estadotitular") + "'") + "," + (dkda.o(vars, "descripcion_estadotitular").equals("") ? null : "'" + dkda.o(vars, "descripcion_estadotitular") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_estadoTitular&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_estadoTitular&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error registrar_estadoTitular() : " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_estadoTitular(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener:  " + codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT      estadotitular.codiesttit AS estadotitular_codiesttit,      estadotitular.descripcion AS estadotitular_descripcion,      estadotitular.ususiscodigo AS estadotitular_ususiscodigo,     estadotitular.fecharegistro AS estadotitular_fecharegistro FROM     public.estadotitular estadotitular "
                    + " WHERE estadotitular.codiesttit = '" + codigo + "'";


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#codiesttit_estadotitular|"
                    + (rs.getString("estadotitular_codiesttit") == null ? ""
                    : rs.getString("estadotitular_codiesttit")) + ":_";

            info += "text|#descripcion_estadotitular|"
                    + (rs.getString("estadotitular_descripcion") == null ? ""
                    : rs.getString("estadotitular_descripcion")) + ":_";


            respuesta = "opcion=obtener_estadoTitular&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_estadoTitular&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("obtener_estadoTitular() " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_estadoTitular(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE estadotitular SET codiesttit = " + (dkda.o(vars, "codiesttit_estadotitular").equals("") ? null : "'" + dkda.o(vars, "codiesttit_estadotitular") + "'") + ", descripcion = " + (dkda.o(vars, "descripcion_estadotitular").equals("") ? null : "'" + dkda.o(vars, "descripcion_estadotitular") + "'") + ", ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ", fecharegistro = " + "NOW()::date" + ""
                    + " WHERE codiesttit = '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_estadoTitular&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_estadoTitular&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error Entidad.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String eliminar_estadoTitular() {

        Connection conexion = bdS.getConexion();
        String codigo = dkda.o(vars, "codigo").toString().substring(0,dkda.o(vars, "codigo").toString().lastIndexOf(","));
        //System.out.println("Eliminado Estado Titular " + codigo);
        
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "DELETE FROM estadotitular WHERE  codiesttit='" + codigo + "'";
            System.out.println(sql);
            stmt = conexion.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=eliminar_estadoTitular&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=eliminar_estadoTitular&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error TipoEntidadSalud.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }


        return respuesta;

    }

    public String validarFormulario_estadoTitular() {
        String direccion = "opcion=registrar_estadoTitular&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = exiseEstadoTitular();

        System.out.println("Codigoooo : |" + dkda.o(vars, "codiesttit_estadotitular"));
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "codiesttit_estadotitular"))) && existe == true) {
                error = "Código Estado Titular: Ya existe otro Estado de Titular con este Codigo. Verifiquelo por favor";
            }
        } else {
            error = (existe) ? "Código Estado Titular: Ya existe otro Estado de Titular con este Codigo. Verifiquelo por favor" : "";
        }

        /*** Inicio Validar Existencia por codempresa*/
        /*** Inicio Validar Vacio */
        if (dkda.o(vars, "codiesttit_estadotitular").equals("")) {
            error = "Código Estado  Titular: no puede ser vacio.";
        } else if (dkda.o(vars, "descripcion_estadotitular").equals("")) {
            error = "Descripción: no puede ser vacio.";
        } /*** Inicio Validar Tipo Dato */
        else if (!v.alfaNumericos(dkda.o(vars, "codiesttit_estadotitular"))) {
            error = "Código Estado  Titular: tiene caracteres no permitidos.";
        }
        
        if (dkda.o(vars, "codiesttit_estadotitular").length() > 2){
            error = "Código Estado  Titular: El Código solo admite 2 Caracteres";
        }

        respuesta = (error.length() > 1 ? direccion + "<strong>" + error + "</strong>" : "");
        System.out.println(respuesta);
        return respuesta;
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public boolean exiseEstadoTitular() {
        // UT004 - ESS207 - CCF045
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {                                                                            //
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM estadotitular  WHERE codiesttit ='" + dkda.o(vars, "codiesttit_estadotitular") + "'");
            //System.out.println("1. SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            System.out.println("exiseEstadoTitular() => " + rQuery.getInt(1));
            pQuery.close();
            rQuery.close();

        } catch (SQLException e) {
            System.err.println("( exiseEstadoTitular() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));

        }
        return existe;
    }
}
