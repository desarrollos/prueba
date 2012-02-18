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

public class ClaseGrupoTitular extends HttpServlet {

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
            String respuesta = validarFormulario_claseGrupoTitular();

            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_claseGrupoTitular(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_claseGrupoTitular(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_claseGrupoTitular(con));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_claseGrupoTitular());
                }
            }
        } finally {
            out.close();
        }

    }

    public String registrar_claseGrupoTitular(ConexionBaseDatos con) {

        System.out.println("registrar_claseGrupoTitular");
        con.abrirConexion();
        //
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO clasegrupotitular (codclagrutit, descclagrutit, codtipoidentidad, identitfam, ususiscodigo, fecharegistro) VALUES (" + ( dkda.o(vars, "codclagrutit_clasegrupotitular").equals("") ? null : "'" + dkda.o(vars, "codclagrutit_clasegrupotitular") + "'" ) + "," + ( dkda.o(vars, "descclagrutit_clasegrupotitular").equals("") ? null : "'" + dkda.o(vars, "descclagrutit_clasegrupotitular") + "'" ) + "," + ( dkda.o(vars, "codtipoidentidad_clasegrupotitular").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_clasegrupotitular") + "'" ) + "," + ( dkda.o(vars, "identitfam_clasegrupotitular").equals("") ? null : "'" + dkda.o(vars, "identitfam_clasegrupotitular") + "'" ) + ","+ "'"+ fun.usuarioAutenticado(request) +"'" +","+ "NOW()::date" +")";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_claseGrupoTitular&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_claseGrupoTitular&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error TipoEntidadSalud.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_claseGrupoTitular(ConexionBaseDatos con, String codigo) {
        System.out.println("obtener:  " + codigo);

        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT  clasegrupotitular.codclagrutit AS clasegrupotitular_codclagrutit,     clasegrupotitular.descclagrutit AS clasegrupotitular_descclagrutit,"
                    + " clasegrupotitular.codtipoidentidad AS clasegrupotitular_codtipoidentidad,     clasegrupotitular.identitfam AS clasegrupotitular_identitfam,     "
                    + " clasegrupotitular.ususiscodigo AS clasegrupotitular_ususiscodigo,    "
                    + " clasegrupotitular.fecharegistro AS clasegrupotitular_fecharegistro,    "
                    + " tipoidentificacion.descripcion AS tipoidentificacion_descripcion "
                    + " FROM  public.tipoidentificacion tipoidentificacion INNER JOIN public.clasegrupotitular clasegrupotitular ON tipoidentificacion.codtipoidentidad = clasegrupotitular.codtipoidentidad "
                    + " WHERE clasegrupotitular.codclagrutit = '" + codigo + "'";


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#codclagrutit_clasegrupotitular|"
                    + (rs.getString("clasegrupotitular_codclagrutit") == null ? ""
                    : rs.getString("clasegrupotitular_codclagrutit")) + ":_";

            info += "combo|#codtipoidentidad_clasegrupotitular|" + rs.getString("clasegrupotitular_codtipoidentidad")
                    + "|llenarCombo('codtipoidentidad_clasegrupotitular', '" + rs.getString("clasegrupotitular_codtipoidentidad")
                    + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";

            info += "text|#identitfam_clasegrupotitular|"
                    + (rs.getString("clasegrupotitular_identitfam") == null ? ""
                    : rs.getString("clasegrupotitular_identitfam")) + ":_";

            info += "text|#descclagrutit_clasegrupotitular|"
                    + (rs.getString("clasegrupotitular_descclagrutit") == null ? ""
                    : rs.getString("clasegrupotitular_descclagrutit")) + ":_";

            respuesta = "opcion=obtener_claseGrupoTitular&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_claseGrupoTitular&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("obtener_claseGrupoTitular() " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return respuesta;

    }

    public String actualizar_claseGrupoTitular(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;

            String sql = "UPDATE clasegrupotitular SET codclagrutit = "
                    + ( dkda.o(vars, "codclagrutit_clasegrupotitular").equals("") ? null : "'"
                    + dkda.o(vars, "codclagrutit_clasegrupotitular") + "'" ) + ", descclagrutit = "
                    + ( dkda.o(vars, "descclagrutit_clasegrupotitular").equals("") ? null : "'"
                    + dkda.o(vars, "descclagrutit_clasegrupotitular") + "'" ) + ", codtipoidentidad = "
                    + ( dkda.o(vars, "codtipoidentidad_clasegrupotitular").equals("") ? null : "'" + dkda.o(vars, "codtipoidentidad_clasegrupotitular") + "'" ) + ", identitfam = "
                    + ( dkda.o(vars, "identitfam_clasegrupotitular").equals("") ? null : "'" + dkda.o(vars, "identitfam_clasegrupotitular") + "'" ) + ", ususiscodigo = "+ "'"+ fun.usuarioAutenticado(request) +"'" +", fecharegistro = "+ "NOW()::date" +""
                    + " WHERE codclagrutit = '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_claseGrupoTitular&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_claseGrupoTitular&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error Entidad.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String eliminar_claseGrupoTitular() {

        
        Connection conexion = bdS.getConexion();
        String codigo = dkda.o(vars, "codigo").toString().substring(0, dkda.o(vars, "codigo").toString().lastIndexOf(","));
        System.out.println("eliminar_claseGrupoTitular " + codigo);
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "DELETE FROM clasegrupotitular WHERE  codclagrutit='" + codigo  + "'";
            stmt = conexion.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=eliminar_claseGrupoTitular&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=eliminar_claseGrupoTitular&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error TipoEntidadSalud.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }


        return respuesta;

    }

    public String validarFormulario_claseGrupoTitular() {
        String direccion = "opcion=registrar_claseGrupoTitular&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = existe_claseGrupoTitular();


        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "codclagrutit_clasegrupotitular"))) && existe == true) {
                error = "Código Clase Grupo Titular: Ya existe otra Clase Grupo Titular con este Codigo. Verifiquelo por favor";
            }
        } else {
            error = (existe) ? "Código Clase Grupo Titular: Ya existe otra Clase Grupo Titular con este Codigo. Verifiquelo por favor" : "";
        }

        /*** Inicio Validar Vacio */
        if(dkda.o(vars, "codclagrutit_clasegrupotitular").equals("")) {
            error = "Código Clase Grupo Titular: no puede ser vacio.";
        } else if (dkda.o(vars, "codtipoidentidad_clasegrupotitular").equals("")) {
            error = "Tipo Identificación: debe seleccionar un Tipo de identificación.";
        }else if (dkda.o(vars, "identitfam_clasegrupotitular").equals("")) {
            error = "Numero de Identificación Titular: no puede ser vacio.";
        }else if (dkda.o(vars, "descclagrutit_clasegrupotitular").equals("")) {
            error = "Descripción: no puede ser vacio.";
        } /*** Inicio Validar Tipo Dato */
        else if (!v.alfaNumericos(dkda.o(vars, "codclagrutit_clasegrupotitular"))) {
            error = "Código Clase Grupo Titular: tiene caracteres no permitidos.";
        }else if (!v.numeros(dkda.o(vars, "identitfam_clasegrupotitular"))) {
            error = "Numero de Identificación Titular: tiene caracteres no permitidos.";
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

    public boolean existe_claseGrupoTitular() {
        // UT004 - ESS207 - CCF045
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {                                                                            //
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM clasegrupotitular  WHERE codclagrutit  ='" + dkda.o(vars, "codclagrutit_clasegrupotitular") + "'");
            //System.out.println("1. SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            System.out.println("existe_claseGrupoTitular() => " + rQuery.getInt(1));
            pQuery.close();
            rQuery.close();

        } catch (SQLException e) {
            System.err.println("( existe_claseGrupoTitular() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));

        }
        return existe;
    }
}
