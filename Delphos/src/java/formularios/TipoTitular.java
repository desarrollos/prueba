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

public class TipoTitular extends HttpServlet {

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
            String respuesta = validarFormulario_tipoTitular();

            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_tipoTitular(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_tipoTitular(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_tipoTitular(con));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_tipoTitular());
                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_tipoTitular(ConexionBaseDatos con) {

        System.out.println("REGISGRANDO Tipo Titular");
        con.abrirConexion();
        //
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO tipotitular (coditiptit, desctiptit, ususiscodigo, fecharegistro) VALUES (" + ( dkda.o(vars, "coditiptit_tipotitular").equals("") ? null : "'" + dkda.o(vars, "coditiptit_tipotitular") + "'" ) + "," + ( dkda.o(vars, "desctiptit_tipotitular").equals("") ? null : "'" + dkda.o(vars, "desctiptit_tipotitular") + "'" ) + ","+ "'"+ fun.usuarioAutenticado(request) +"'" +","+ "NOW()::date" +")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_tipoTitular&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_tipoTitular&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error TipoEntidadSalud.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_tipoTitular(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener:  " + codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT tipotitular.coditiptit AS tipotitular_coditiptit, tipotitular.desctiptit AS tipotitular_desctiptit,     tipotitular.ususiscodigo AS tipotitular_ususiscodigo, tipotitular.fecharegistro AS tipotitular_fecharegistro FROM  public.tipotitular tipotitular  WHERE tipotitular.coditiptit = '" + codigo + "'";


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#coditiptit_tipotitular|"
                    + (rs.getString("tipotitular_coditiptit") == null ? ""
                    : rs.getString("tipotitular_coditiptit")) + ":_";

            info += "text|#desctiptit_tipotitular|"
                    + (rs.getString("tipotitular_desctiptit") == null ? ""
                    : rs.getString("tipotitular_desctiptit")) + ":_";


            respuesta = "opcion=obtener_tipoTitular&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_tipoTitular&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("obtener_tipoTitular() " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_tipoTitular(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE tipotitular SET coditiptit = "
                    + ( dkda.o(vars, "coditiptit_tipotitular").equals("") ? null : "'"
                    + dkda.o(vars, "coditiptit_tipotitular") + "'" )                     + ", desctiptit = "
                    + ( dkda.o(vars, "desctiptit_tipotitular").equals("") ? null : "'"
                    + dkda.o(vars, "desctiptit_tipotitular") + "'" ) + ", ususiscodigo = "+ "'"+ fun.usuarioAutenticado(request) +"'" +", fecharegistro = "+ "NOW()::date" +""
                    + " WHERE coditiptit = '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_tipoTitular&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_tipoTitular&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error Entidad.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String eliminar_tipoTitular() {

        
        Connection conexion = bdS.getConexion();
        String codigo = dkda.o(vars, "codigo").toString().substring(0,dkda.o(vars, "codigo").toString().lastIndexOf(","));
                System.out.println("Eliminado Tipo Titular " + codigo);
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "DELETE FROM tipotitular WHERE  coditiptit='" + codigo + "'";
            System.out.println(sql);
            stmt = conexion.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=eliminar_tipoTitular&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=eliminar_tipoTitular&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error TipoEntidadSalud.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }


        return respuesta;

    }

    public String validarFormulario_tipoTitular() {
        String direccion = "opcion=registrar_tipoTitular&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = exiseTipoTitular();

        System.out.println( "Codigo " + dkda.o(vars, "coditiptit_tipotitular") );

        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "coditiptit_tipotitular"))) && existe == true) {
                error = "Código Tipo Titular: Ya existe otro Tipo de Titular con este Codigo. Verifiquelo por favor";
            }
        } else {
            error = (existe) ? "Código Tipo Titular: Ya existe otro Tipo de Titular con este Codigo. Verifiquelo por favor" : "";
        }

        /*** Inicio Validar Existencia por codempresa*/
        /*** Inicio Validar Vacio */
        if (dkda.o(vars, "coditiptit_tipotitular").equals("")) {
            error = "Código Tipo Titular: no puede ser vacio.";
        } else if (dkda.o(vars, "desctiptit_tipotitular").equals("")) {
            error = "Descripción: no puede ser vacio.";
        } /*** Inicio Validar Tipo Dato */
        else if (!v.alfaNumericos(dkda.o(vars, "coditiptit_tipotitular"))) {
            error = "Código Tipo Titular: tiene caracteres no permitidos.";
        } 

        if (dkda.o(vars, "coditiptit_tipotitular").length() > 2){
            error = "Código Tipo Titular: El Código solo admite 2 Caracteres";
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

    public boolean exiseTipoTitular() {
        // UT004 - ESS207 - CCF045
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {                                                                            //
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM tipotitular  WHERE coditiptit ='" + dkda.o(vars, "coditiptit_tipotitular") + "'");
            //System.out.println("1. SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            System.out.println("exiseTipoTitular() => " + rQuery.getInt(1));
            pQuery.close();
            rQuery.close();

        } catch (SQLException e) {
            System.err.println("( exiseTipoTitular() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));

        }
        return existe;
    }
}
