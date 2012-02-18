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

public class EstadoFamilia extends HttpServlet {

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
            String respuesta = validarFormulario_estadoFamilia();

            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_estadoFamilia(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_estadoFamilia(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_estadoFamilia(con));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_estadoFamilia());
                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_estadoFamilia(ConexionBaseDatos con) {

        System.out.println("registrar_estadoFamilia");
        con.abrirConexion();
        //
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO estadofamilia (codiestfam, descestfam, ususiscodigo, fecharegistro) VALUES ("
                    + (dkda.o(vars, "codiestfam_estadofamilia").equals("") ? null : "'"
                    + dkda.o(vars, "codiestfam_estadofamilia") + "'") + ","
                    + (dkda.o(vars, "descestfam_estadofamilia").equals("") ? null : "'"
                    + dkda.o(vars, "descestfam_estadofamilia") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";



            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_estadoFamilia&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_estadoFamilia&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error TipoEntidadSalud.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_estadoFamilia(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener_estadoFamilia:  " + codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "     estadofamilia.codiestfam AS estadofamilia_codiestfam,"
                    + "     estadofamilia.descestfam AS estadofamilia_descestfam,"
                    + "     estadofamilia.ususiscodigo AS estadofamilia_ususiscodigo,"
                    + "     estadofamilia.fecharegistro AS estadofamilia_fecharegistro"
                    + " FROM "
                    + " public.estadofamilia estadofamilia WHERE estadofamilia.codiestfam = '" + codigo + "'";
                    System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#codiestfam_estadofamilia|"
                    + (rs.getString("estadofamilia_codiestfam") == null ? ""
                    : rs.getString("estadofamilia_codiestfam")) + ":_";

            info += "text|#descestfam_estadofamilia|"
                    + (rs.getString("estadofamilia_descestfam") == null ? ""
                    : rs.getString("estadofamilia_descestfam")) + ":_";


            respuesta = "opcion=obtener_estadoFamilia&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_estadoFamilia&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error Estado Familia - Obtener.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_estadoFamilia(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE estadofamilia "
                    + "SET codiestfam = "
                    + (dkda.o(vars, "codiestfam_estadofamilia").equals("") ? null : "'"
                    + dkda.o(vars, "codiestfam_estadofamilia") + "'") + ", descestfam = "
                    + (dkda.o(vars, "descestfam_estadofamilia").equals("") ? null : "'"
                    + dkda.o(vars, "descestfam_estadofamilia") + "'") + ", ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ", fecharegistro = " + "NOW()::date" + ""
                    + " WHERE codiestfam = '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_estadoFamilia&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_estadoFamilia&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error Entidad.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String eliminar_estadoFamilia() {

       
        Connection conexion = bdS.getConexion();
        String codigo = dkda.o(vars, "codigo").toString().substring(0,dkda.o(vars, "codigo").toString().lastIndexOf(","));
        
         //System.out.println("eliminar_estadoFamilia " + codigo);
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "DELETE FROM estadofamilia WHERE  codiestfam='" + codigo + "'";
            System.out.println(sql);
            stmt = conexion.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=eliminar_estadoFamilia&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=eliminar_estadoFamilia&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error eliminar_estadoFamilia(): " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }


        return respuesta;

    }

    public String validarFormulario_estadoFamilia() {
        String direccion = "opcion=registrar_estadoFamilia&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = existe_estadoFamilia();

        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "codiestfam_estadofamilia"))) && existe == true) {
                error = "Código Estado Familia: Ya existe otro Estado Familia con este Codigo. Verifiquelo por favor";
            }
        } else {
            if (existe) {
                error = "Código Estado Familia: Ya existe otro Estado Familia con este Codigo. Verifiquelo por favor";
            }
        }

        /*** Inicio Validar Existencia por codempresa*/
        /*** Inicio Validar Vacio */
        
        if (dkda.o(vars, "codiestfam_estadofamilia").equals("")) {
            error = "Código Estado Familia: no puede ser vacio.";
        } else if (dkda.o(vars, "descestfam_estadofamilia").equals("")) {
            error = "Descripción: no puede ser vacio.";
        } /*** Inicio Validar Tipo Dato */
        else if (!v.alfaNumericos(dkda.o(vars, "codiestfam_estadofamilia"))) {
            error = "Código Estado Familia: tiene caracteres no permitidos.";
        }

        if (dkda.o(vars, "codiestfam_estadofamilia").length() > 1){
            error = "Código Estado Familia: El Código solo admite 1 Caracter";
        }
        
        respuesta = (error.length() > 1 ? direccion + "<strong>" + error + "</strong>" : "");

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

    public boolean existe_estadoFamilia() {
        // UT004 - ESS207 - CCF045
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {                                                                            //
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM estadofamilia  WHERE codiestfam ='" + dkda.o(vars, "codiestfam_estadofamilia") + "'");
            //System.out.println("1. SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            System.out.println("existe_estadoFamilia() => " + rQuery.getInt(1));
            pQuery.close();
            rQuery.close();

        } catch (SQLException e) {
            System.err.println("( existe_estadoFamilia() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }
}
