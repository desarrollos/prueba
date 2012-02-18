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

public class Prueba extends HttpServlet {

    ConexionBaseDatos con;
    HashMap vars = new HashMap();
    String respuesta = "";
    funciones fun = new funciones();
    UtilidadesDKDA dkda = new UtilidadesDKDA();
    HttpServletRequest request;
    private String string;
    ed_ValidacionCampos v = null;
    HashMap sel, empresa_funcionario_1, entidadsalud_funcionario_1, entidadsalud_funcionario_2;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String parametros = new String(URLDecoder.decode(request.getParameter("parametros")).getBytes(), "UTF-8");
        vars = clases.UtilidadesDKDA.urlDecodificar(parametros, "");
        con = new ConexionBaseDatos();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        this.request = request;
        v = new clases.ed_ValidacionCampos();
        sel = fun.map(dkda.o(vars, "codigo").toString());

        

        empresa_funcionario_1 = fun.map(dkda.o(vars, "empresa_funcionario_1").toString());
        entidadsalud_funcionario_1 = fun.map(dkda.o(vars, "entidadsalud_funcionario_1").toString());
        entidadsalud_funcionario_2 = fun.map(dkda.o(vars, "entidadsalud_funcionario_2").toString());
        try {
            String opcion = dkda.o(vars, "accion").toString();
            respuesta = "";
            String respuesta = validarFormulario_funcionario();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_funcionario(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_funcionario(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_funcionario(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_funcionario(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_funcionario(ConexionBaseDatos con) {
        System.out.println("registrar_funcionario");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO funcionario (codtipoidentidad,numidentfunc,codtipofuncionario,nombre,matriculaprofesional,codempresa,codcargo,"
                    + "codocupacion,fechanacimiento,telefonofijo,telefonomovil,codregimeneapb,codentidadsaludeapb,codregimenips,"
                    + "codentidadsaludips,firmadigital,tienehuella,huelladigital,foto,fotodocumentoidentidad,archivofi,"
                    + "codestadofuncionario,codespecialidad,codgruposanguineo,codactividadeconomica,imagenfirma,correoemail,"
                    + "ususiscodigo,fecharegistro) VALUES (" + (dkda.o(empresa_funcionario_1, "codtipoidentidad").equals("") ? null : "'" + 
                    dkda.o(empresa_funcionario_1, "codtipoidentidad") + "'") + "," + (dkda.o(vars, "numidentfunc_funcionario").equals("") ? null : "'" + 
                    dkda.o(vars, "numidentfunc_funcionario") + "'") + "," + (dkda.o(vars, "codtipofuncionario_funcionario").equals("") ? null :
                    "'" + dkda.o(vars, "codtipofuncionario_funcionario") + "'") + "," + (dkda.o(vars, "nombre_funcionario").equals("") ? null : "'" 
                    + dkda.o(vars, "nombre_funcionario") + "'") + "," + (dkda.o(vars, "matriculaprofesional_funcionario").equals("") ? null : "'" + 
                    dkda.o(vars, "matriculaprofesional_funcionario") + "'") + "," + (dkda.o(empresa_funcionario_1, "codempresa").equals("") ? null : "'" + dkda.o(empresa_funcionario_1, "codempresa") + "'") + "," + (dkda.o(vars, "codcargo_funcionario").equals("") ? null : "'" + dkda.o(vars, "codcargo_funcionario") + "'") + "," + (dkda.o(vars, "codocupacion_funcionario").equals("") ? null : "'" + dkda.o(vars, "codocupacion_funcionario") + "'") + "," + (dkda.o(vars, "fechanacimiento_funcionario").equals("") ? null : "'" + dkda.o(vars, "fechanacimiento_funcionario") + "'") + "," + (dkda.o(vars, "telefonofijo_funcionario").equals("") ? null : "'" + dkda.o(vars, "telefonofijo_funcionario") + "'") + "," + (dkda.o(vars, "telefonomovil_funcionario").equals("") ? null : "'" + dkda.o(vars, "telefonomovil_funcionario") + "'") + "," + (dkda.o(entidadsalud_funcionario_1, "codregimenes").equals("") ? null : "'" + dkda.o(entidadsalud_funcionario_1, "codregimenes") + "'") + "," + (dkda.o(entidadsalud_funcionario_1, "codentidadsalud").equals("") ? null : "'" + dkda.o(entidadsalud_funcionario_1, "codentidadsalud") + "'") + "," + (dkda.o(entidadsalud_funcionario_2, "codregimenes").equals("") ? null : "'" + dkda.o(entidadsalud_funcionario_2, "codregimenes") + "'") + "," + (dkda.o(entidadsalud_funcionario_2, "codentidadsalud").equals("") ? null : "'" + dkda.o(entidadsalud_funcionario_2, "codentidadsalud") + "'") + "," + (dkda.o(vars, "firmadigital_funcionario").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "firmadigital_funcionario") + "')") + "," + (dkda.o(vars, "tienehuella_funcionario").equals("") ? null : "'" + dkda.o(vars, "tienehuella_funcionario") + "'") + "," + (dkda.o(vars, "huelladigital_funcionario").equals("") ? null : "'" + dkda.o(vars, "huelladigital_funcionario") + "'") + "," + (dkda.o(vars, "foto_funcionario").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "foto_funcionario") + "')") + "," + (dkda.o(vars, "fotodocumentoidentidad_funcionario").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "fotodocumentoidentidad_funcionario") + "')") + "," + (dkda.o(vars, "archivofi_funcionario").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi_funcionario") + "')") + "," + (dkda.o(vars, "codestadofuncionario_funcionario").equals("") ? null : "'" + dkda.o(vars, "codestadofuncionario_funcionario") + "'") + "," + (dkda.o(vars, "codespecialidad_funcionario").equals("") ? null : "'" + dkda.o(vars, "codespecialidad_funcionario") + "'") + "," + (dkda.o(vars, "codgruposanguineo_funcionario").equals("") ? null : "'" + dkda.o(vars, "codgruposanguineo_funcionario") + "'") + "," + (dkda.o(vars, "codactividadeconomica_funcionario").equals("") ? null : "'" + dkda.o(vars, "codactividadeconomica_funcionario") + "'") + "," + (dkda.o(vars, "imagenfirma_funcionario").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "imagenfirma_funcionario") + "')") + "," + (dkda.o(vars, "correoemail_funcionario").equals("") ? null : "'" + dkda.o(vars, "correoemail_funcionario") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_funcionario&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_funcionario&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error funcionario.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_funcionario(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE funcionario SET codtipoidentidad = " + (dkda.o(empresa_funcionario_1, "codtipoidentidad").equals("") ? null : "'" + dkda.o(empresa_funcionario_1, "codtipoidentidad") + "'") + ",numidentfunc = " + (dkda.o(vars, "numidentfunc_funcionario").equals("") ? null : "'" + dkda.o(vars, "numidentfunc_funcionario") + "'") + ",codtipofuncionario = " + (dkda.o(vars, "codtipofuncionario_funcionario").equals("") ? null : "'" + dkda.o(vars, "codtipofuncionario_funcionario") + "'") + ",nombre = " + (dkda.o(vars, "nombre_funcionario").equals("") ? null : "'" + dkda.o(vars, "nombre_funcionario") + "'") + ",matriculaprofesional = " + (dkda.o(vars, "matriculaprofesional_funcionario").equals("") ? null : "'" + dkda.o(vars, "matriculaprofesional_funcionario") + "'") + ",codempresa = " + (dkda.o(empresa_funcionario_1, "codempresa").equals("") ? null : "'" + dkda.o(empresa_funcionario_1, "codempresa") + "'") + ",codcargo = " + (dkda.o(vars, "codcargo_funcionario").equals("") ? null : "'" + dkda.o(vars, "codcargo_funcionario") + "'") + ",codocupacion = " + (dkda.o(vars, "codocupacion_funcionario").equals("") ? null : "'" + dkda.o(vars, "codocupacion_funcionario") + "'") + ",fechanacimiento = " + (dkda.o(vars, "fechanacimiento_funcionario").equals("") ? null : "'" + dkda.o(vars, "fechanacimiento_funcionario") + "'") + ",telefonofijo = " + (dkda.o(vars, "telefonofijo_funcionario").equals("") ? null : "'" + dkda.o(vars, "telefonofijo_funcionario") + "'") + ",telefonomovil = " + (dkda.o(vars, "telefonomovil_funcionario").equals("") ? null : "'" + dkda.o(vars, "telefonomovil_funcionario") + "'") + ",codregimeneapb = " + (dkda.o(entidadsalud_funcionario_1, "codregimenes").equals("") ? null : "'" + dkda.o(entidadsalud_funcionario_1, "codregimenes") + "'") + ",codentidadsaludeapb = " + (dkda.o(entidadsalud_funcionario_1, "codentidadsalud").equals("") ? null : "'" + dkda.o(entidadsalud_funcionario_1, "codentidadsalud") + "'") + ",codregimenips = " + (dkda.o(entidadsalud_funcionario_2, "codregimenes").equals("") ? null : "'" + dkda.o(entidadsalud_funcionario_2, "codregimenes") + "'") + ",codentidadsaludips = " + (dkda.o(entidadsalud_funcionario_2, "codentidadsalud").equals("") ? null : "'" + dkda.o(entidadsalud_funcionario_2, "codentidadsalud") + "'") + ",firmadigital = " + (dkda.o(vars, "firmadigital_funcionario").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "firmadigital_funcionario") + "')") + ",tienehuella = " + (dkda.o(vars, "tienehuella_funcionario").equals("") ? null : "'" + dkda.o(vars, "tienehuella_funcionario") + "'") + ",huelladigital = " + (dkda.o(vars, "huelladigital_funcionario").equals("") ? null : "'" + dkda.o(vars, "huelladigital_funcionario") + "'") + ",foto = " + (dkda.o(vars, "foto_funcionario").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "foto_funcionario") + "')") + ",fotodocumentoidentidad = " + (dkda.o(vars, "fotodocumentoidentidad_funcionario").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "fotodocumentoidentidad_funcionario") + "')") + ",archivofi = " + (dkda.o(vars, "archivofi_funcionario").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "archivofi_funcionario") + "')") + ",codestadofuncionario = " + (dkda.o(vars, "codestadofuncionario_funcionario").equals("") ? null : "'" + dkda.o(vars, "codestadofuncionario_funcionario") + "'") + ",codespecialidad = " + (dkda.o(vars, "codespecialidad_funcionario").equals("") ? null : "'" + dkda.o(vars, "codespecialidad_funcionario") + "'") + ",codgruposanguineo = " + (dkda.o(vars, "codgruposanguineo_funcionario").equals("") ? null : "'" + dkda.o(vars, "codgruposanguineo_funcionario") + "'") + ",codactividadeconomica = " + (dkda.o(vars, "codactividadeconomica_funcionario").equals("") ? null : "'" + dkda.o(vars, "codactividadeconomica_funcionario") + "'") + ",imagenfirma = " + (dkda.o(vars, "imagenfirma_funcionario").equals("") ? null : "lo_import('" + fun.temp(request) + dkda.o(vars, "imagenfirma_funcionario") + "')") + ",correoemail = " + (dkda.o(vars, "correoemail_funcionario").equals("") ? null : "'" + dkda.o(vars, "correoemail_funcionario") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND numidentfunc = '" + dkda.o(sel, "numidentfunc") + "' ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_funcionario&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_funcionario&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error funcionario.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_funcionario(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM funcionario WHERE codtipoidentidad = '" + dkda.o(sel, "codtipoidentidad") + "' AND numidentfunc = '" + dkda.o(sel, "numidentfunc") + "' ");
            stmt.execute();
            respuesta = "opcion=eliminar_funcionario&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_funcionario&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error funcionario.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_funcionario(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            respuesta = "opcion=obtener_funcionario&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_funcionario&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error funcionario - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_funcionario() {
        String direccion = "opcion=registrar_funcionario&&estado=no&&error=si&&errorDes=";
        String error = "";
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