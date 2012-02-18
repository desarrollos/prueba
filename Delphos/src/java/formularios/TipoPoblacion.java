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

public class TipoPoblacion extends HttpServlet {

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
            String respuesta = validarFormulario_tipoPoblacion();

            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_tipoPoblacion(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_tipoPoblacion(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_tipoPoblacion(con));
                }
                if (opcion.equals("Eliminar")) {
                    out.println( eliminar_tipoPoblacion() );
                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_tipoPoblacion(ConexionBaseDatos con) {

        System.out.println("REGISGRANDO Tipo Poblacion");
        con.abrirConexion();
        //
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT "
                    + "INTO tipopoblacion (codtipopoblacion, descripcion, ususiscodigo, fecharegistro) "
                    + "VALUES "
                    + "(" + (dkda.o(vars, "codtipopoblacion_tipopoblacion").equals("") ? null : "'"
                    + dkda.o(vars, "codtipopoblacion_tipopoblacion") + "'") + "," + (dkda.o(vars, "descripcion_tipopoblacion").equals("") ? null : "'"
                    + dkda.o(vars, "descripcion_tipopoblacion") + "'") + "," + (dkda.o(vars, "ususiscodigo_tipopoblacion").equals("") ? null : "'"
                    + dkda.o(vars, "ususiscodigo_tipopoblacion") + "'") + "," + (dkda.o(vars, "fecharegistro_tipopoblacion").equals("") ? null : "'"
                    + dkda.o(vars, "fecharegistro_tipopoblacion") + "'") + ")";



            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_tipoPoblacion&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_tipoPoblacion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error TipoEntidadSalud.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_tipoPoblacion(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener:  " + codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT     "
                    + "tipopoblacion.codtipopoblacion AS tipopoblacion_codtipopoblacion,     "
                    + "tipopoblacion.descripcion AS tipopoblacion_descripcion,     "
                    + "tipopoblacion.ususiscodigo AS tipopoblacion_ususiscodigo,     "
                    + "tipopoblacion.fecharegistro AS tipopoblacion_fecharegistro "
                    + "FROM public.tipopoblacion tipopoblacion  WHERE tipopoblacion.codtipopoblacion = '" + codigo + "'";


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#codtipopoblacion_tipopoblacion|"
                    + (rs.getString("tipopoblacion_codtipopoblacion") == null ? ""
                    : rs.getString("tipopoblacion_codtipopoblacion")) + ":_";

            info += "text|#descripcion_tipopoblacion|"
                    + (rs.getString("tipopoblacion_descripcion") == null ? ""
                    : rs.getString("tipopoblacion_descripcion")) + ":_";


            respuesta = "opcion=obtener_tipoPoblacion&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_tipoPoblacion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error Entidad - Obtener.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_tipoPoblacion(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE "
                    + "tipopoblacion SET codtipopoblacion = "
                    + (dkda.o(vars, "codtipopoblacion_tipopoblacion").equals("") ? null : "'"
                    + dkda.o(vars, "codtipopoblacion_tipopoblacion") + "'") + ", descripcion = " + (dkda.o(vars, "descripcion_tipopoblacion").equals("") ? null : "'"
                    + dkda.o(vars, "descripcion_tipopoblacion") + "'") + ", ususiscodigo = "
                    + (dkda.o(vars, "ususiscodigo_tipopoblacion").equals("") ? null : "'"
                    + dkda.o(vars, "ususiscodigo_tipopoblacion") + "'") + ", fecharegistro = "
                    + (dkda.o(vars, "fecharegistro_tipopoblacion").equals("") ? null : "'"
                    + dkda.o(vars, "fecharegistro_tipopoblacion") + "'")
                    + " WHERE codtipopoblacion = '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_tipoPoblacion&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_tipoPoblacion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error Entidad.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

     public String eliminar_tipoPoblacion() {

        
        Connection conexion = bdS.getConexion();
        String codigo = dkda.o(vars, "codigo").toString().substring(0,dkda.o(vars, "codigo").toString().lastIndexOf(","));
        
        System.out.println("Eliminado Tipo Poblacion " + codigo);
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "DELETE FROM tipopoblacion WHERE  codtipopoblacion='" + codigo + "'";
            System.out.println(sql);
            stmt = conexion.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=eliminar_tipoPoblacion&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=eliminar_tipoPoblacion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error TipoEntidadSalud.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }

       
        return respuesta;

    }

    public String validarFormulario_tipoPoblacion() {
        String direccion = "opcion=registrar_tipoPoblacion&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe =  exiseTipoPoblacion();

        System.out.println("Accion " + dkda.o(vars, "accion"));
        System.out.println("Codigo " + dkda.o(vars, "codigo"));
        System.out.println("Valor Nuevo " + dkda.o(vars, "codtipopoblacion_tipopoblacion"));

        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (    !(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "codtipopoblacion_tipopoblacion"))) &&  existe == true ) {
                    error = "Código Tipo Población: Ya existe otro Tipo de Poblacion con este Codigo. Verifiquelo por favor";
                    System.out.println("Existe?");
            }
        }else{
             if (existe){error = "Código Tipo Población: Ya existe otro Tipo de Poblacion con este Codigo. Verifiquelo por favor"; }
        }

        /*** Inicio Validar Existencia por codempresa*/
        /*** Inicio Validar Vacio */
        if (dkda.o(vars, "codtipopoblacion_tipopoblacion").equals("")) {
            error = "Código Tipo Población: no puede ser vacio.";
        } else if (dkda.o(vars, "descripcion_tipopoblacion").equals("")) {
            error = "Descripción: no puede ser vacio.";
        } /*** Inicio Validar Tipo Dato */
        else if (!v.alfaNumericos(dkda.o(vars, "codtipopoblacion_tipopoblacion"))) {
            error = "Código Tipo Población: tiene caracteres no permitidos.";
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

    public boolean exiseTipoPoblacion() {
        // UT004 - ESS207 - CCF045
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {                                                                            //
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM tipopoblacion  WHERE codtipopoblacion ='" + dkda.o(vars, "codtipopoblacion_tipopoblacion") + "'");
            //System.out.println("1. SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            System.out.println("exiseTipoPoblacion() => " + rQuery.getInt(1));
            pQuery.close();
            rQuery.close();

        } catch (SQLException e) {
            System.err.println("( exiseTipoPoblacion() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));

        }
        return existe;
    }
}
