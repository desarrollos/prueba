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

public class TipoEducacion extends HttpServlet {

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
            String respuesta = validarFormulario_tipoeducacion();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_tipoeducacion(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_tipoeducacion(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_tipoeducacion(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_tipoeducacion(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_tipoeducacion(ConexionBaseDatos con) {
        System.out.println("registrar_tipoeducacion");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO tipoeducacion (tipeducodigo,tipedudescri,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "tipeducodigo_tipoeducacion").equals("") ? null : "'" + dkda.o(vars, "tipeducodigo_tipoeducacion") + "'") + "," + (dkda.o(vars, "tipedudescri_tipoeducacion").equals("") ? null : "'" + dkda.o(vars, "tipedudescri_tipoeducacion") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_tipoeducacion&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_tipoeducacion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error tipoeducacion.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_tipoeducacion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE tipoeducacion SET tipeducodigo = " + (dkda.o(vars, "tipeducodigo_tipoeducacion").equals("") ? null : "'" + dkda.o(vars, "tipeducodigo_tipoeducacion") + "'") + ",tipedudescri = " + (dkda.o(vars, "tipedudescri_tipoeducacion").equals("") ? null : "'" + dkda.o(vars, "tipedudescri_tipoeducacion") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE tipeducodigo = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_tipoeducacion&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_tipoeducacion&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error tipoeducacion.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_tipoeducacion(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM tipoeducacion WHERE tipeducodigo = '" + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_tipoeducacion&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_tipoeducacion&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error tipoeducacion.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_tipoeducacion(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT     tipoeducacion.tipeducodigo AS tipoeducacion_tipeducodigo,"
                    + "     tipoeducacion.tipedudescri AS tipoeducacion_tipedudescri,"
                    + "     tipoeducacion.ususiscodigo AS tipoeducacion_ususiscodigo,"
                    + "     tipoeducacion.fecharegistro AS tipoeducacion_fecharegistro "
                    + " FROM "
                    + "     public.tipoeducacion tipoeducacion "
                    + " WHERE   tipoeducacion.tipeducodigo = '" + codigo + "' ";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#tipeducodigo_tipoeducacion|"
                    + (rs.getString("tipoeducacion_tipeducodigo") == null ? ""
                    : rs.getString("tipoeducacion_tipeducodigo")) + ":_";

            info += "text|#tipedudescri_tipoeducacion|"
                    + (rs.getString("tipoeducacion_tipedudescri") == null ? ""
                    : rs.getString("tipoeducacion_tipedudescri")) + ":_";

            respuesta = "opcion=obtener_tipoeducacion&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_tipoeducacion&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error tipoeducacion - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_tipoeducacion() {
        String direccion = "opcion=registrar_tipoeducacion&&estado=no&&error=si&&errorDes=";
        String error = "";

        Boolean existe = existe_tipoeducacion();
        System.out.println("Existe ? " + existe);
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "tipeducodigo_tipoeducacion"))) && existe == true) {
                System.out.println( dkda.o(vars, "codigo") );
                System.out.println( dkda.o(vars, "tipeducodigo_tipoeducacion")) ;
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "tipeducodigo_tipoeducacion").isEmpty()) {
            error = "Código Tipo Educación: no puede ser vacio.";
        } else if (dkda.o(vars, "tipedudescri_tipoeducacion").isEmpty()) {
            error = "Descripción Tipo Educación: no puede ser vacio.";
        } else if (dkda.o(vars, "tipeducodigo_tipoeducacion").length() > 3) {
            error = "Código Tipo Educación: Valor demasiado Largo.";
        } else if (dkda.o(vars, "tipedudescri_tipoeducacion").length() > 30) {
            error = "Descripción Tipo Educación: Valor demasiado Largo.";
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

    private boolean existe_tipoeducacion() {
        
//        String pk = "";
//        if (modo.equals("Actualizar")){
//            pk = dkda.o(vars, "codigo");
//        }else{
//            pk = dkda.o(vars, "tipeducodigo_tipoeducacion");
//        }
        
  //      System.out.println("Modo " + modo);
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            System.out.println("SELECT COUNT(*) FROM tipoeducacion  WHERE tipeducodigo = '" + dkda.o(vars, "codigo") + "'");
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM tipoeducacion  WHERE tipeducodigo = '" + dkda.o(vars, "codigo") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_tipoeducacion() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }
}