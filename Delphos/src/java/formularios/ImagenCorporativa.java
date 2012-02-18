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

public class ImagenCorporativa extends HttpServlet {

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
            String respuesta = validarFormulario_imagencorporativa();
            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {
                System.out.println("OPCION : " + opcion);
                if (opcion.equals("Registrar")) {
                    out.println(registrar_imagencorporativa(con));
                }
                if (opcion.equals("Obtener")) {
                    out.println(obtener_imagencorporativa(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Actualizar")) {
                    out.println(actualizar_imagencorporativa(con, dkda.o(vars, "codigo").toString()));
                }
                if (opcion.equals("Eliminar")) {
                    out.println(eliminar_imagencorporativa(con, dkda.o(vars, "codigo").toString()));
                }
            }
        } finally {
            out.close();
        }
    }

    public String registrar_imagencorporativa(ConexionBaseDatos con) {
        System.out.println("registrar_imagencorporativa");
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = " INSERT INTO imagencorporativa (imacorid,tisiscodigo,tipcorcodigo,imacordescripc,imacormostrar,estcorcodigo,ususiscodigo,fecharegistro) VALUES (" + (dkda.o(vars, "imacorid_imagencorporativa").equals("") ? null : dkda.o(vars, "imacorid_imagencorporativa")) + "," + (dkda.o(vars, "tisiscodigo_imagencorporativa").equals("") ? null : "'" + dkda.o(vars, "tisiscodigo_imagencorporativa") + "'") + "," + (dkda.o(vars, "tipcorcodigo_imagencorporativa").equals("") ? null : "'" + dkda.o(vars, "tipcorcodigo_imagencorporativa") + "'") + "," + (dkda.o(vars, "imacordescripc_imagencorporativa").equals("") ? null : "'" + dkda.o(vars, "imacordescripc_imagencorporativa") + "'") + "," + (dkda.o(vars, "imacormostrar_imagencorporativa").equals("") ? null : "'" + dkda.o(vars, "imacormostrar_imagencorporativa") + "'") + "," + (dkda.o(vars, "estcorcodigo_imagencorporativa").equals("") ? null : "'" + dkda.o(vars, "estcorcodigo_imagencorporativa") + "'") + "," + "'" + fun.usuarioAutenticado(request) + "'" + "," + "NOW()::date" + ")";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_imagencorporativa&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=registrar_imagencorporativa&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error imagencorporativa.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String actualizar_imagencorporativa(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE imagencorporativa SET imacorid = " + (dkda.o(vars, "imacorid_imagencorporativa").equals("") ? null : dkda.o(vars, "imacorid_imagencorporativa")) + ",tisiscodigo = " + (dkda.o(vars, "tisiscodigo_imagencorporativa").equals("") ? null : "'" + dkda.o(vars, "tisiscodigo_imagencorporativa") + "'") + ",tipcorcodigo = " + (dkda.o(vars, "tipcorcodigo_imagencorporativa").equals("") ? null : "'" + dkda.o(vars, "tipcorcodigo_imagencorporativa") + "'") + ",imacordescripc = " + (dkda.o(vars, "imacordescripc_imagencorporativa").equals("") ? null : "'" + dkda.o(vars, "imacordescripc_imagencorporativa") + "'") + ",imacormostrar = " + (dkda.o(vars, "imacormostrar_imagencorporativa").equals("") ? null : "'" + dkda.o(vars, "imacormostrar_imagencorporativa") + "'") + ",estcorcodigo = " + (dkda.o(vars, "estcorcodigo_imagencorporativa").equals("") ? null : "'" + dkda.o(vars, "estcorcodigo_imagencorporativa") + "'") + ",ususiscodigo = " + "'" + fun.usuarioAutenticado(request) + "'" + ",fecharegistro = " + "NOW()::date" + " WHERE imacorid = " + dkda.o(vars, "codigo") + " ";
            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_imagencorporativa&&estado=si&&error=no&&errorDes=no&&codigo=4";
        } catch (SQLException e) {
            respuesta = "opcion=actualizar_imagencorporativa&&estado=no&&error=si&&errorDes=" + estadosSQL.getM(e.getSQLState(), e.getMessage());
            System.out.println("Error imagencorporativa.java: " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String eliminar_imagencorporativa(ConexionBaseDatos con, String codigo) {
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
            stmt = con.con.prepareStatement("DELETE FROM imagencorporativa WHERE imacorid = " + dkda.o(vars, "codigo").substring(0, dkda.o(vars, "codigo").length() - 1) + "");
            stmt.execute();
            respuesta = "opcion=eliminar_imagencorporativa&&estado=si&&error=no&&errorDes=no";
        } catch (SQLException e) {
            respuesta = "opcion=eliminar_imagencorporativa&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error imagencorporativa.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_imagencorporativa(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT imagencorporativa.imacorid       AS imagencorporativa_imacorid, "
                    + "       imagencorporativa.tisiscodigo    AS imagencorporativa_tisiscodigo, "
                    + "       imagencorporativa.tipcorcodigo   AS imagencorporativa_tipcorcodigo, "
                    + "       imagencorporativa.imacordescripc AS imagencorporativa_imacordescripc, "
                    + "       imagencorporativa.imacormostrar  AS imagencorporativa_imacormostrar, "
                    + "       imagencorporativa.estcorcodigo   AS imagencorporativa_estcorcodigo, "
                    + "       imagencorporativa.ususiscodigo   AS imagencorporativa_ususiscodigo, "
                    + "       imagencorporativa.fecharegistro  AS imagencorporativa_fecharegistro, "
                    + "       estadocorporativa.estcorcodigo   AS estadocorporativa_estcorcodigo, "
                    + "       estadocorporativa.estcordescripc AS estadocorporativa_estcordescripc, "
                    + "       tipocorporativa.tipcorcodigo     AS tipocorporativa_tipcorcodigo, "
                    + "       tipocorporativa.tipcordescripc   AS tipocorporativa_tipcordescripc, "
                    + "       tiposistema.tisiscodigo          AS tiposistema_tisiscodigo, "
                    + "       tiposistema.tisisdescrip         AS tiposistema_tisisdescrip "
                    + "FROM   public.estadocorporativa estadocorporativa "
                    + "       inner join public.imagencorporativa imagencorporativa "
                    + "         ON estadocorporativa.estcorcodigo = imagencorporativa.estcorcodigo "
                    + "       inner join public.tipocorporativa tipocorporativa "
                    + "         ON imagencorporativa.tipcorcodigo = tipocorporativa.tipcorcodigo "
                    + "       inner join public.tiposistema tiposistema "
                    + "         ON imagencorporativa.tisiscodigo = tiposistema.tisiscodigo "
                    + "WHERE  imagencorporativa.imacorid =  " + codigo;
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            info += "text|#imacorid_imagencorporativa|"
                    + (rs.getString("imagencorporativa_imacorid") == null ? ""
                    : rs.getString("imagencorporativa_imacorid")) + ":_";



            info += "combo|#tisiscodigo_imagencorporativa|" + rs.getString("imagencorporativa_tisiscodigo")
                    + "|llenarCombo('tisiscodigo_imagencorporativa', '" + rs.getString("imagencorporativa_tisiscodigo")
                    + "', '" + rs.getString("tiposistema_tisisdescrip") + "'):_";

            info += "combo|#tipcorcodigo_imagencorporativa|" + rs.getString("imagencorporativa_tipcorcodigo")
                    + "|llenarCombo('tipcorcodigo_imagencorporativa', '" + rs.getString("imagencorporativa_tipcorcodigo")
                    + "', '" + rs.getString("tipocorporativa_tipcordescripc") + "'):_";

            info += "switch|switch_imacormostrar_imagencorporativa|" + rs.getString("imagencorporativa_imacormostrar") + ":_";

            info += "combo|#estcorcodigo_imagencorporativa|" + rs.getString("imagencorporativa_estcorcodigo")
                    + "|llenarCombo('estcorcodigo_imagencorporativa', '" + rs.getString("imagencorporativa_estcorcodigo")
                    + "', '" + rs.getString("estadocorporativa_estcordescripc") + "'):_";


            info += "text|#imacordescripc_imagencorporativa|"
                    + (rs.getString("imagencorporativa_imacordescripc") == null ? ""
                    : rs.getString("imagencorporativa_imacordescripc")) + ":_";

            respuesta = "opcion=obtener_imagencorporativa&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");
        } catch (SQLException e) {
            respuesta = "opcion=obtener_imagencorporativa&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error imagencorporativa - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;
    }

    public String validarFormulario_imagencorporativa() {
        String direccion = "opcion=registrar_imagencorporativa&&estado=no&&error=si&&errorDes=";
        String error = "";
        Boolean existe = existe_imagencorporativa();
        if (dkda.o(vars, "accion").toString().equals("Actualizar")) {
            if (!(dkda.o(vars, "codigo").toString().equals(dkda.o(vars, "imacorid_imagencorporativa"))) && existe == true) {
                error = "Ya existe un registro en la tabla con esta informacion. Verifique los campos";
            }
        } else {
            error = (existe) ? "Ya existe un registro en la tabla con esta informacion. Verifique los campos" : "";
        }
        if (dkda.o(vars, "imacorid_imagencorporativa").isEmpty()) {
            error = "Codigo Imagen Corporativa: no puede ser vacio.";
        } else if (dkda.o(vars, "tisiscodigo_imagencorporativa").isEmpty()) {
            error = " Tipo Sistemas: no puede ser vacio.";
        } else if (dkda.o(vars, "tipcorcodigo_imagencorporativa").isEmpty()) {
            error = "Tipo Imagen Corporativa: no puede ser vacio.";
        } else if (dkda.o(vars, "estcorcodigo_imagencorporativa").isEmpty()) {
            error = "Estado Imagen Corporativa: no puede ser vacio.";
        } else if (dkda.o(vars, "imacordescripc_imagencorporativa").isEmpty()) {
            error = "Descripción Imagen Corporativa: no puede ser vacio.";
        } else if (dkda.o(vars, "imacorid_imagencorporativa").length() > 9) {
            error = "Codigo Imagen Corporativa: Valor demasiado Largo.";
        } else if (dkda.o(vars, "imacormostrar_imagencorporativa").length() > 1) {
            error = "Mostrar Imagen Corporativa: Valor demasiado Largo.";
        } else if (dkda.o(vars, "imacordescripc_imagencorporativa").length() > 250) {
            error = "Descripción Imagen Corporativa: Valor demasiado Largo.";
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

    private boolean existe_imagencorporativa() {
        PreparedStatement pQuery = null;
        ResultSet rQuery = null;
        Connection conexion = bdS.getConexion();
        boolean existe = true;
        System.out.println("Valor = " + dkda.o(vars, "imacorid_imagencorporativa"));
        try {
            if (!dkda.o(vars, "imacorid_imagencorporativa").isEmpty()) {
                pQuery = conexion.prepareStatement("SELECT COUNT(*) FROM imagencorporativa  WHERE imacorid = " + dkda.o(vars, "imacorid_imagencorporativa") + "");
                rQuery = pQuery.executeQuery();
                rQuery.next();
                existe = rQuery.getInt(1) > 0 ? true : false;
                pQuery.close();
                rQuery.close();
            } else {
                existe = false;
            }
        } catch (SQLException e) {
            System.err.println("( existe_imagencorporativa() ) " + estadosSQL.getM(e.getSQLState(), e.getMessage()));
        }
        return existe;
    }
}