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

public class SubsidioCategoria extends HttpServlet {

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
            String respuesta = validarFormulario_subsidiocategoria();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_subsidiocategoria(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_subsidiocategoria(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_subsidiocategoria(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_subsidiocategoria(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_subsidiocategoria(ConexionBaseDatos con) {
        System.out.println("registrar_subsidiocategoria");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO subsidiocategoria (subcatcodigo,subcatdescri,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "subcatcodigo_subsidiocategoria").equals("") ? null : "'" + dkda.o(vars, "subcatcodigo_subsidiocategoria") + "'") + "," + (dkda.o(vars, "subcatdescri_subsidiocategoria").equals("") ? null : "'" + dkda.o(vars, "subcatdescri_subsidiocategoria") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_subsidiocategoria&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_subsidiocategoria&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error subsidiocategoria.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_subsidiocategoria(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE subsidiocategoria SET subcatcodigo = " + (dkda.o(vars, "subcatcodigo_subsidiocategoria").equals("") ? null : "'" + dkda.o(vars, "subcatcodigo_subsidiocategoria") + "'") + ",subcatdescri = " + (dkda.o(vars, "subcatdescri_subsidiocategoria").equals("") ? null : "'" + dkda.o(vars, "subcatdescri_subsidiocategoria") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE subcatcodigo = '" + dkda.o(vars, "codigo") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_subsidiocategoria&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_subsidiocategoria&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error subsidiocategoria.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_subsidiocategoria(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM subsidiocategoria WHERE subcatcodigo = '" + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "'");
            stmt.execute();
            respuesta = "opcion=eliminar_subsidiocategoria&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_subsidiocategoria&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error subsidiocategoria.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_subsidiocategoria(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " SELECT"
                    + "     subsidiocategoria.subcatcodigo AS subsidiocategoria_subcatcodigo,"
                    + "     subsidiocategoria.subcatdescri AS subsidiocategoria_subcatdescri,"
                    + "     subsidiocategoria.ususiscodigo AS subsidiocategoria_ususiscodigo,"
                    + "     subsidiocategoria.fecharegistro AS subsidiocategoria_fecharegistro"
                    + " FROM "
                    + "     public.subsidiocategoria subsidiocategoria "
                    + " WHERE subsidiocategoria.subcatcodigo = '" + codigo + "'";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#subcatcodigo_subsidiocategoria|" + (rs.getString("subsidiocategoria_subcatcodigo") == null ? "" : rs.getString("subsidiocategoria_subcatcodigo")) + ":_";
            
            info += "text|#subcatdescri_subsidiocategoria|" + (rs.getString("subsidiocategoria_subcatdescri") == null ? "" : rs.getString("subsidiocategoria_subcatdescri")) + ":_";

            respuesta = "opcion=obtener_subsidiocategoria&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_subsidiocategoria&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error subsidiocategoria - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_subsidiocategoria() {
        String direccion = "opcion=registrar_subsidiocategoria&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = existe_subsidiocategoria();

        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "subcatcodigo_subsidiocategoria"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "subcatcodigo_subsidiocategoria").isEmpty()) {
            error = "Codigo Categoria Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subcatdescri_subsidiocategoria").isEmpty()) {
            error = "Descripcion Categoria Subsidio: no puede ser vacio.";
        } else if (dkda.o(vars, "subcatcodigo_subsidiocategoria").length() > 3) {
            error = "Codigo Categoria Subsidio: Valor demasiado Largo.";
        } else if (dkda.o(vars, "subcatdescri_subsidiocategoria").length() > 30) {
            error = "Descripcion Categoria Subsidio: Valor demasiado Largo.";
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

    private boolean existe_subsidiocategoria() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        try {
            pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM subsidiocategoria  WHERE subcatcodigo = '" + dkda.o(vars, "subcatcodigo_subsidiocategoria") + "'");
            rQuery = pQuery.executeQuery();
            rQuery.next();
            existe = rQuery.getInt(1) > 0 ? true : false;
            pQuery.close();
            rQuery.close();
        } catch (SQLException e) {
            System.err.println("( existe_subsidiocategoria() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }
}