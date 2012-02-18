/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
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
import clases.ed_ValidacionCampos;
import java.sql.*;
import java.net.URLDecoder;

/**
 *
 * @author Sebas
 */
public class UsuariosSistema extends HttpServlet {

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
        respuesta = "";

        try {
            String opcion = dkda.o(vars, "accion").toString();
            String pestana = dkda.o(vars, "pestana").toString();
            respuesta = "";
            System.out.println(pestana);

            if (pestana.equals("Usuarios")) {
                System.out.println("Entra usuarios");
                String respuesta = validarFormulario_Usuarios();
            }

            if (respuesta.length() > 0 && (opcion.equals("Registrar") || opcion.equals("Actualizar"))) {
                out.println(respuesta);
            } else {

                System.out.println("OPCION : " + opcion);

                if (opcion.equals("Registrar")) {

                    if (pestana.equals("Usuarios")) {
                        out.println(registrar_Usuarios(con));
                    }
                    if (pestana.equals("Grupos")) {
                        out.println(registrar_Grupos(con));
                    }
                    if (pestana.equals("Paginas")) {
                        out.println(registrar_Paginas(con));
                    }
                    if (pestana.equals("Perfiles")) {
                        out.println(registrar_Perfiles(con));
                    }
                    if (pestana.equals("Estados")) {
                        out.println(registrar_Estados(con));
                    }
                    if (pestana.equals("Permisos")) {
                        out.println(registrar_Permisos(con));
                    }
                }
                if (opcion.equals("Obtener")) {
                    if (pestana.equals("Usuarios")) {
                        out.println(obtener_Usuarios(con, dkda.o(vars, "codigo").toString()));
                    }
                    if (pestana.equals("Grupos")) {
                        out.println(obtener_Grupos(con, dkda.o(vars, "codigo").toString()));
                    }
                    if (pestana.equals("Paginas")) {
                        out.println(obtener_Paginas(con, dkda.o(vars, "codigo").toString()));
                    }
                    if (pestana.equals("Perfiles")) {
                        out.println(obtener_Perfiles(con, dkda.o(vars, "codigo").toString()));
                    }
                    if (pestana.equals("Estados")) {
                        out.println(obtener_Estados(con, dkda.o(vars, "codigo").toString()));
                    }
                    if (pestana.equals("Permisos")) {
                        out.println(obtener_Permisos(con, dkda.o(vars, "codigo").toString()));
                    }

                }
                if (opcion.equals("Actualizar")) {
                    if (pestana.equals("Usuarios")) {
                        out.println(actualizar_Usuarios(con));
                    }
                    if (pestana.equals("Grupos")) {
                        out.println(actualizar_Grupos(con));
                    }
                    if (pestana.equals("Paginas")) {
                        out.println(actualizar_Paginas(con));
                    }
                    if (pestana.equals("Perfiles")) {
                        out.println(actualizar_Perfiles(con));
                    }
                    if (pestana.equals("Estados")) {
                        out.println(actualizar_Estados(con));
                    }
                    if (pestana.equals("Permisos")) {
                        out.println(actualizar_Permisos(con));
                    }
                }


            }
        } finally {
            out.close();
        }

    }
    public String registrar_Permisos(ConexionBaseDatos con) {
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "INSERT INTO estadousuasistema "
                    + "(codestusuasistema, descripcion, ususiscodigo, fecharegistro) "
                    + "VALUES("
                    + "'" + dkda.o(vars, "codestusuasistema_estados") + "','"
                    + "" + dkda.o(vars, "descripcion_estados") + "',"
                    + "'DELPHOS',"
                    + "'NOW()')";



            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_estados&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_estados&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_Permisos(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + " SELECT "
                    + "estadousuasistema.codestusuasistema AS estadousuasistema_codestusuasistema,"
                    + "estadousuasistema.descripcion AS estadousuasistema_descripcion,"
                    + "estadousuasistema.ususiscodigo AS estadousuasistema_ususiscodigo,"
                    + "estadousuasistema.fecharegistro AS estadousuasistema_fecharegistro"
                    + " FROM "
                    + " public.estadousuasistema estadousuasistema WHERE estadousuasistema.codestusuasistema = '" + codigo + "'";


            System.out.println(sql);


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();


            info += "text|#codestusuasistema_estados|" + (rs.getString("estadousuasistema_codestusuasistema") == null ? "" : rs.getString("estadousuasistema_codestusuasistema")) + ":_";
            info += "text|#descripcion_estados|" + (rs.getString("estadousuasistema_descripcion") == null ? "" : rs.getString("estadousuasistema_descripcion")) + ":_";

            respuesta = "opcion=obtener_estados&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_estados&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error UsuariosSistena - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_Permisos(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE estadousuasistema SET "
                    + "codestusuasistema = '" + dkda.o(vars, "codestusuasistema_estados") + "',"
                    + "descripcion = '" + dkda.o(vars, "descripcion_estados") + "',"
                    + "ususiscodigo = 'DELPHOS',"
                    + "fecharegistro = 'NOW()'"
                    + " WHERE codestusuasistema = '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_estados&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_estados&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }
    
    
    public String registrar_Estados(ConexionBaseDatos con) {
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "INSERT INTO estadousuasistema "
                    + "(codestusuasistema, descripcion, ususiscodigo, fecharegistro) "
                    + "VALUES("
                    + "'" + dkda.o(vars, "codestusuasistema_estados") + "','"
                    + "" + dkda.o(vars, "descripcion_estados") + "',"
                    + "'DELPHOS',"
                    + "'NOW()')";



            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_estados&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_estados&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_Estados(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + " SELECT "
                    + "estadousuasistema.codestusuasistema AS estadousuasistema_codestusuasistema,"
                    + "estadousuasistema.descripcion AS estadousuasistema_descripcion,"
                    + "estadousuasistema.ususiscodigo AS estadousuasistema_ususiscodigo,"
                    + "estadousuasistema.fecharegistro AS estadousuasistema_fecharegistro"
                    + " FROM "
                    + " public.estadousuasistema estadousuasistema WHERE estadousuasistema.codestusuasistema = '" + codigo + "'";


            System.out.println(sql);


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();


            info += "text|#codestusuasistema_estados|" + (rs.getString("estadousuasistema_codestusuasistema") == null ? "" : rs.getString("estadousuasistema_codestusuasistema")) + ":_";
            info += "text|#descripcion_estados|" + (rs.getString("estadousuasistema_descripcion") == null ? "" : rs.getString("estadousuasistema_descripcion")) + ":_";

            respuesta = "opcion=obtener_estados&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_estados&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error UsuariosSistena - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_Estados(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE estadousuasistema SET "
                    + "codestusuasistema = '" + dkda.o(vars, "codestusuasistema_estados") + "',"
                    + "descripcion = '" + dkda.o(vars, "descripcion_estados") + "',"
                    + "ususiscodigo = 'DELPHOS',"
                    + "fecharegistro = 'NOW()'"
                    + " WHERE codestusuasistema = '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_estados&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_estados&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String registrar_Perfiles(ConexionBaseDatos con) {
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "INSERT INTO nivelsegopcion "
                    + "(niseopcodigo, niseopdescripcion, niseopejecuta, niseopadiciona, niseopmodifica, niseopelimina, niseopconsulta,"
                    + "niseopbuscar, niseopimprime, niseopocultar, ususiscodigo, fecharegistro) "
                    + "VALUES('" + dkda.o(vars, "niseopcodigo_perfiles") + "',"
                    + "'" + dkda.o(vars, "niseopdescripcion_perfiles") + "',"
                    + "'" + dkda.o(vars, "niseopejecuta_perfiles") + "',"
                    + "'" + dkda.o(vars, "niseopadiciona_perfiles") + "',"
                    + "'" + dkda.o(vars, "niseopmodifica_perfiles") + "',"
                    + "'" + dkda.o(vars, "niseopelimina_perfiles") + "',"
                    + "'" + dkda.o(vars, "niseopconsulta_perfiles") + "',"
                    + "'" + dkda.o(vars, "niseopbuscar_perfiles") + "',"
                    + "'" + dkda.o(vars, "niseopimprime_perfiles") + "',"
                    + "'" + dkda.o(vars, "niseopocultar_perfiles") + "',"
                    + "'DELPHOS',"
                    + "'NOW()')";


            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_perfiles&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_perfiles&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_Perfiles(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + " SELECT "
                    + "nivelsegopcion.niseopcodigo AS nivelsegopcion_niseopcodigo,"
                    + "nivelsegopcion.niseopdescripcion AS nivelsegopcion_niseopdescripcion,"
                    + "nivelsegopcion.niseopejecuta AS nivelsegopcion_niseopejecuta,"
                    + "nivelsegopcion.niseopadiciona AS nivelsegopcion_niseopadiciona,"
                    + "nivelsegopcion.niseopmodifica AS nivelsegopcion_niseopmodifica,"
                    + "nivelsegopcion.niseopelimina AS nivelsegopcion_niseopelimina,"
                    + "nivelsegopcion.niseopconsulta AS nivelsegopcion_niseopconsulta,"
                    + "nivelsegopcion.niseopbuscar AS nivelsegopcion_niseopbuscar,"
                    + "nivelsegopcion.niseopimprime AS nivelsegopcion_niseopimprime,"
                    + "nivelsegopcion.niseopocultar AS nivelsegopcion_niseopocultar,"
                    + "nivelsegopcion.ususiscodigo AS nivelsegopcion_ususiscodigo,"
                    + "nivelsegopcion.fecharegistro AS nivelsegopcion_fecharegistro"
                    + " FROM public.nivelsegopcion nivelsegopcion WHERE nivelsegopcion.niseopcodigo = '" + codigo + "'";

            System.out.println(sql);


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();


            info += "text|#niseopcodigo_perfiles|" + (rs.getString("nivelsegopcion_niseopcodigo") == null ? "" : rs.getString("nivelsegopcion_niseopcodigo")) + ":_";
            info += "text|#niseopdescripcion_perfiles|" + (rs.getString("nivelsegopcion_niseopdescripcion") == null ? "" : rs.getString("nivelsegopcion_niseopdescripcion")) + ":_";



            info += "switch|switch_niseopejecuta_perfiles|" + rs.getString("nivelsegopcion_niseopejecuta") + ":_";
            info += "switch|switch_niseopadiciona_perfiles|" + rs.getString("nivelsegopcion_niseopadiciona") + ":_";
            info += "switch|switch_niseopmodifica_perfiles|" + rs.getString("nivelsegopcion_niseopmodifica") + ":_";
            info += "switch|switch_niseopelimina_perfiles|" + rs.getString("nivelsegopcion_niseopelimina") + ":_";
            info += "switch|switch_niseopconsulta_perfiles|" + rs.getString("nivelsegopcion_niseopconsulta") + ":_";
            info += "switch|switch_niseopbuscar_perfiles|" + rs.getString("nivelsegopcion_niseopbuscar") + ":_";
            info += "switch|switch_niseopimprime_perfiles|" + rs.getString("nivelsegopcion_niseopimprime") + ":_";
            info += "switch|switch_niseopocultar_perfiles|" + rs.getString("nivelsegopcion_niseopocultar") + ":_";

            respuesta = "opcion=obtener_perfiles&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_perfiles&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error UsuariosSistena - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_Perfiles(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE nivelsegopcion SET "
                    + "niseopdescripcion = '" + dkda.o(vars, "niseopdescripcion_perfiles") + "',"
                    + "niseopejecuta = '" + dkda.o(vars, "niseopejecuta_perfiles") + "',"
                    + "niseopadiciona = '" + dkda.o(vars, "niseopadiciona_perfiles") + "',"
                    + "niseopmodifica = '" + dkda.o(vars, "niseopmodifica_perfiles") + "',"
                    + "niseopelimina = '" + dkda.o(vars, "niseopelimina_perfiles") + "',"
                    + "niseopconsulta = '" + dkda.o(vars, "niseopconsulta_perfiles") + "',"
                    + "niseopbuscar = '" + dkda.o(vars, "niseopbuscar_perfiles") + "',"
                    + "niseopimprime = '" + dkda.o(vars, "niseopimprime_perfiles") + "',"
                    + "niseopocultar = '" + dkda.o(vars, "niseopocultar_perfiles") + "',"
                    + "ususiscodigo = 'DELPHOS',"
                    + "fecharegistro = 'NOW()' "
                    + " WHERE niseopcodigo = '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_perfiles&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_perfiles&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String registrar_Paginas(ConexionBaseDatos con) {
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "INSERT INTO listaopcion "
                    + "(lisopccodigo, lisopcprograma, lisopcdescripcion, ususiscodigo, fecharegistro, orcodigo) "
                    + "VALUES('" + dkda.o(vars, "lisopccodigo_paginas") + "','" + dkda.o(vars, "lisopcprograma_paginas") + "','"
                    + dkda.o(vars, "lisopcdescripcion_paginas") + "','DELPHOS','NOW()','"
                    + dkda.o(vars, "orcodigo_paginas") + "')";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_paginas&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_paginas&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String obtener_Paginas(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT "
                    + "listaopcion.lisopccodigo AS listaopcion_lisopccodigo,"
                    + "listaopcion.lisopcprograma AS listaopcion_lisopcprograma,"
                    + "listaopcion.lisopcdescripcion AS listaopcion_lisopcdescripcion,"
                    + "listaopcion.ususiscodigo AS listaopcion_ususiscodigo,"
                    + "listaopcion.fecharegistro AS listaopcion_fecharegistro,"
                    + "listaopcion.orcodigo AS listaopcion_orcodigo,"
                    + "origenrecurso.orcodigo AS origenrecurso_orcodigo,"
                    + "origenrecurso.ordescripcion AS origenrecurso_ordescripcion,"
                    + "origenrecurso.ususiscodigo AS origenrecurso_ususiscodigo,"
                    + "origenrecurso.fecharegistro AS origenrecurso_fecharegistro "
                    + " FROM "
                    + "public.origenrecurso origenrecurso INNER JOIN public.listaopcion listaopcion ON origenrecurso.orcodigo = listaopcion.orcodigo"
                    + " WHERE listaopcion.lisopccodigo = '" + codigo + "'";

            System.out.println(sql);


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();


            info += "text|#lisopccodigo_paginas|" + (rs.getString("listaopcion_lisopccodigo") == null ? "" : rs.getString("listaopcion_lisopccodigo")) + ":_";
            info += "text|#lisopcprograma_paginas|" + (rs.getString("listaopcion_lisopcprograma") == null ? "" : rs.getString("listaopcion_lisopcprograma")) + ":_";
            info += "combo|#orcodigo_paginas|" + rs.getString("origenrecurso_orcodigo") + "|llenarCombo('orcodigo_paginas', '" + rs.getString("origenrecurso_orcodigo") + "', '" + rs.getString("origenrecurso_ordescripcion") + "'):_";
            info += "text|#lisopcdescripcion_paginas|" + (rs.getString("listaopcion_lisopcdescripcion") == null ? "" : rs.getString("listaopcion_lisopcdescripcion")) + ":_";

            respuesta = "opcion=obtener_paginas&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_paginas&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error UsuariosSistena - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_Grupos(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE gruposeguridad SET "
                    + "esgrsecodigo = '" + dkda.o(vars, "esgrsecodigo_grupos") + "',"
                    + "grusegdescripcion = '" + dkda.o(vars, "grusegdescripcion_grupos") + "' "
                    + "WHERE grusegcodigo = '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_grupos&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_grupos&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String obtener_Grupos(ConexionBaseDatos con, String codigo) {


        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "SELECT "
                    + "gruposeguridad.grusegcodigo AS gruposeguridad_grusegcodigo,"
                    + "gruposeguridad.grusegdescripcion AS gruposeguridad_grusegdescripcion,"
                    + "gruposeguridad.esgrsecodigo AS gruposeguridad_esgrsecodigo,"
                    + "estadogruposeguridad.esgrsecodigo AS estadogruposeguridad_esgrsecodigo,"
                    + "estadogruposeguridad.esgrsedescripcion AS estadogruposeguridad_esgrsedescripcion,"
                    + "estadogruposeguridad.ususiscodigo AS estadogruposeguridad_ususiscodigo,"
                    + "estadogruposeguridad.fecharegistro AS estadogruposeguridad_fecharegistro "
                    + "FROM public.estadogruposeguridad estadogruposeguridad INNER JOIN public.gruposeguridad gruposeguridad ON estadogruposeguridad.esgrsecodigo = gruposeguridad.esgrsecodigo "
                    + "WHERE gruposeguridad.grusegcodigo = '" + codigo + "'";

//            System.out.println( sql );


            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();


            info += "text|#grusegcodigo_grupos|" + (rs.getString("gruposeguridad_grusegcodigo") == null ? "" : rs.getString("gruposeguridad_grusegcodigo")) + ":_";
            info += "combo|#esgrsecodigo_grupos|" + rs.getString("estadogruposeguridad_ususiscodigo") + "|llenarCombo('esgrsecodigo_grupos', '" + rs.getString("estadogruposeguridad_esgrsecodigo") + "', '" + rs.getString("estadogruposeguridad_esgrsedescripcion") + "'):_";
            info += "text|#grusegdescripcion_grupos|" + (rs.getString("gruposeguridad_grusegdescripcion") == null ? "" : rs.getString("gruposeguridad_grusegdescripcion")) + ":_";

            respuesta = "opcion=obtener_grupos&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_grupos&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error UsuariosSistena - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String actualizar_Paginas(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "UPDATE listaopcion SET "
                    + "lisopcprograma = '" + dkda.o(vars, "lisopcprograma_paginas") + "',"
                    + "lisopcdescripcion = '" + dkda.o(vars, "lisopcdescripcion_paginas") + "',"
                    + "ususiscodigo = 'DELPHOS',"
                    + "fecharegistro = 'NOW()',"
                    + "orcodigo = '" + dkda.o(vars, "orcodigo_paginas") + "' "
                    + " WHERE lisopccodigo = '" + dkda.o(vars, "codigo") + "'";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_paginas&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_paginas&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String registrar_Grupos(ConexionBaseDatos con) {
        con.abrirConexion();
        // 
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "INSERT INTO gruposeguridad"
                    + "(grusegcodigo, esgrsecodigo, grusegdescripcion) "
                    + "VALUES('" + dkda.o(vars, "grusegcodigo_grupos") + "','" + dkda.o(vars, "esgrsecodigo_grupos") + "','" + dkda.o(vars, "grusegdescripcion_grupos") + "')";

            System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_grupos&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_grupos&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + e.getMessage());
        }

        con.cerrarConexion();
        return respuesta;

    }

    public String actualizar_Usuarios(ConexionBaseDatos con) {
        con.abrirConexion();

        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = ""
                    + "UPDATE usuariosistema SET "
                    + "ususiscodigo = '" + dkda.o(vars, "ususiscodigo_usuarios") + "',"
                    + "ususiscodigoalt = '" + dkda.o(vars, "ususiscodigoalt_usuarios") + "',"
                    + "ususisnombre = '" + dkda.o(vars, "ususisnombre_usuarios") + "',"
                    + "ususisapellido = '" + dkda.o(vars, "ususisapellido_usuarios") + "',"
                    + "codtipoidentidad = '" + dkda.o(vars, "codtipoidentidad_usuarios") + "',"
                    + "ususisindenfica = '" + dkda.o(vars, "ususisindenfica_usuarios") + "',"
                    + "grusegcodigo = '" + dkda.o(vars, "grusegcodigo_usuarios") + "',"
                    + "ususiscontrasena = MD5('" + dkda.o(vars, "ususiscontrasena_usuarios") + "'),"
                    + "ususiscambio = '" + dkda.o(vars, "ususiscambio_usuarios") + "',"
                    + "ususisfechamodi = 'NOW()',"
                    + "ususisdias = " + (dkda.o(vars, "ususisdias_usuarios").equals("") ? "0" : dkda.o(vars, "ususisdias_usuarios")) + ","
                    + "codestusuasistema = '" + dkda.o(vars, "codestusuasistema_usuarios") + "',"
                    + "ususismultisesion = '" + dkda.o(vars, "ususismultisesion_usuarios") + "',"
                    + "ususisinterno = '" + dkda.o(vars, "ususisinterno_usuarios") + "',"
                    + "ususiscodigor = 'DELPHOS',"
                    + "fecharegistro = 'NOW',"
                    + "huelladactilarnombre = '" + dkda.o(vars, "huelladactilar_usuarios") + "',"
                    + "fotonombre = '" + dkda.o(vars, "foto_usuarios") + "',"
                    + "tienehuella = '" + dkda.o(vars, "tienehuella_usuarios") + "'"
                    + (dkda.o(vars, "huelladactilar_usuarios").equals("") ? "" : ", huelladactilar = lo_import('" + fun.temp(request) + dkda.o(vars, "huelladactilar_usuarios") + "') ")
                    + (dkda.o(vars, "foto_usuarios").equals("") ? "" : ", foto = lo_import('" + fun.temp(request) + dkda.o(vars, "foto_usuarios") + "') ")
                    + " WHERE ususisusuario = '" + dkda.o(vars, "codigo") + "'"
                    + "";

            System.out.println( sql )        ;
            
            stmt = con.con.prepareStatement(sql);
            stmt.executeUpdate();
            respuesta = "opcion=actualizar_usuarios&&estado=si&&error=no&&errorDes=no&&codigo=4";

        } catch (SQLException e) {
            respuesta = "opcion=actualizar_usuarios&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + dkda.convertirACarEspecial(e.getMessage()));
        }
        con.cerrarConexion();
        return respuesta;



    }

    public String registrar_Usuarios(ConexionBaseDatos con) {
        con.abrirConexion();

        
        
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "INSERT INTO usuariosistema"
                    + "(ususiscodigo, ususisusuario, ususiscodigoalt, ususisnombre, ususisapellido, codtipoidentidad, ususisindenfica, grusegcodigo,"
                    + "ususiscontrasena,ususiscambio, ususisfechacrea,  ususisdias, codestusuasistema, ususismultisesion ,ususisinterno,"
                    + "tienehuella,ususiscodigor, fecharegistro" + (dkda.o(vars, "huelladactilar_usuarios").equals("") ? "" : ",huelladactilar") + " "
                    + ",huelladactilarnombre, "
                    + "fotonombre"
                    + (dkda.o(vars, "foto_usuarios").equals("") ? "" : ",foto") + " ) "
                    + "VALUES('" + dkda.o(vars, "ususiscodigo_usuarios") + "', '" + dkda.o(vars, "ususisusuario_usuarios") + "' ,'" + dkda.o(vars, "ususiscodigoalt_usuarios") + "',"
                    + "'" + dkda.o(vars, "ususisnombre_usuarios") + "', '" + dkda.o(vars, "ususisapellido_usuarios") + "',"
                    + "'" + dkda.o(vars, "codtipoidentidad_usuarios") + "',"
                    + "'" + dkda.o(vars, "ususisindenfica_usuarios") + "', '" + dkda.o(vars, "grusegcodigo_usuarios") + "', "
                    + "MD5('" + dkda.o(vars, "ususiscontrasena_usuarios") + "'), '" + dkda.o(vars, "ususiscambio_usuarios") + "',"
                    + "'" + (dkda.o(vars, "ususisfechacrea_usuarios").equals("") ? "NOW()" : dkda.o(vars, "ususisfechacrea_usuarios") + " 00:00:00") + "' "
                    + ","
                    + "" + (dkda.o(vars, "ususisdias_usuarios").equals("") ? "0" : dkda.o(vars, "ususisdias_usuarios")) + ", '" + dkda.o(vars, "codestusuasistema_usuarios") + "', "
                    + "'" + dkda.o(vars, "ususismultisesion_usuarios") + "', '" + dkda.o(vars, "ususisinterno_usuarios") + "',"
                    + "'" + dkda.o(vars, "tienehuella_usuarios") + "' " + (dkda.o(vars, "ususiscodigor_usuarios").equals("") ? ",'DELPHOS'" : ",'" + dkda.o(vars, "ususiscodigor_usuarios") + "'") + ","
                    + "'NOW()' " + (dkda.o(vars, "huelladactilar_usuarios").equals("") ? "" : ",lo_import('" + fun.temp(request) + dkda.o(vars, "huelladactilar_usuarios") + "')") + ""
                    + (dkda.o(vars, "huelladactilar_usuarios").equals("") ? ",null" : ",'" + dkda.o(vars, "huelladactilar_usuarios") + "'")
                    + (dkda.o(vars, "foto_usuarios").equals("") ? ",null" : ",'" + dkda.o(vars, "foto_usuarios") + "'")
                    + "" + (dkda.o(vars, "foto_usuarios").equals("") ? "" : ",lo_import('" + fun.temp(request) + dkda.o(vars, "foto_usuarios") + "')") + ")";

            //System.out.println(sql);

            stmt = con.con.prepareStatement(sql);
            stmt.execute();
            respuesta = "opcion=registrar_usuarios&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=registrar_usuarios&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + e.getMessage());
        }
        


        con.cerrarConexion();
        return respuesta;
    }

    public String obtener_Usuarios(ConexionBaseDatos con, String codigo) {

        System.out.println(System.getProperty("java.io.tmpdir"));
        con.abrirConexion();
        String info = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "usuariosistema.ususiscodigo AS usuariosistema_ususiscodigo,"
                    + "usuariosistema.ususisusuario AS usuariosistema_ususisusuario,"
                    + "usuariosistema.ususiscodigoalt AS usuariosistema_ususiscodigoalt,"
                    + "usuariosistema.ususisnombre AS usuariosistema_ususisnombre,"
                    + "usuariosistema.ususisapellido AS usuariosistema_ususisapellido,"
                    + "usuariosistema.codtipoidentidad AS usuariosistema_codtipoidentidad,"
                    + "usuariosistema.ususisindenfica AS usuariosistema_ususisindenfica,"
                    + "usuariosistema.grusegcodigo AS usuariosistema_grusegcodigo,"
                    + "usuariosistema.ususiscontrasena AS usuariosistema_ususiscontrasena,"
                    + "usuariosistema.ususiscambio AS usuariosistema_ususiscambio,"
                    + "usuariosistema.ususisfechacrea AS usuariosistema_ususisfechacrea,"
                    + "usuariosistema.ususisfechamodi AS usuariosistema_ususisfechamodi,"
                    + "usuariosistema.ususisdias AS usuariosistema_ususisdias,"
                    + "usuariosistema.codestusuasistema AS usuariosistema_codestusuasistema,"
                    + "usuariosistema.ususismultisesion AS usuariosistema_ususismultisesion,"
                    + "usuariosistema.ususisinterno AS usuariosistema_ususisinterno,"
                    + "usuariosistema.ususiscodigor AS usuariosistema_ususiscodigor,"
                    + "usuariosistema.fecharegistro AS usuariosistema_fecharegistro,"
                    + "usuariosistema.huelladactilarnombre AS usuariosistema_huelladactilarnombre,"
                    + "usuariosistema.fotonombre AS usuariosistema_fotonombre,"
                    + "CASE WHEN usuariosistema.huelladactilarnombre IS NULL OR usuariosistema.huelladactilarnombre = '' THEN 0 "
                    + "ELSE lo_export(usuariosistema.huelladactilar, '" + fun.temp(request) + "' || usuariosistema.huelladactilarnombre) END,"
                    + "CASE WHEN usuariosistema.fotonombre IS NULL OR usuariosistema.fotonombre = '' THEN 0 "
                    + "ELSE lo_export(usuariosistema.foto, '" + fun.temp(request) + "' || usuariosistema.fotonombre) END,"
                    + "usuariosistema.tienehuella AS usuariosistema_tienehuella,"
                    + "tipoidentificacion.codtipoidentidad AS tipoidentificacion_codtipoidentidad,"
                    + "tipoidentificacion.codalterno AS tipoidentificacion_codalterno,"
                    + "tipoidentificacion.descripcion AS tipoidentificacion_descripcion,"
                    + "tipoidentificacion.ususiscodigo AS tipoidentificacion_ususiscodigo,"
                    + "tipoidentificacion.fecharegistro AS tipoidentificacion_fecharegistro,"
                    + "gruposeguridad.grusegcodigo AS gruposeguridad_grusegcodigo,"
                    + "gruposeguridad.grusegdescripcion AS gruposeguridad_grusegdescripcion,"
                    + "gruposeguridad.esgrsecodigo AS gruposeguridad_esgrsecodigo,"
                    + "estadousuasistema.codestusuasistema AS estadousuasistema_codestusuasistema,"
                    + "estadousuasistema.descripcion AS estadousuasistema_descripcion,"
                    + "estadousuasistema.ususiscodigo AS estadousuasistema_ususiscodigo,"
                    + "estadousuasistema.fecharegistro AS estadousuasistema_fecharegistro"
                    + " FROM "
                    + "public.tipoidentificacion tipoidentificacion INNER JOIN public.usuariosistema usuariosistema ON tipoidentificacion.codtipoidentidad = usuariosistema.codtipoidentidad "
                    + "INNER JOIN public.gruposeguridad gruposeguridad ON usuariosistema.grusegcodigo = gruposeguridad.grusegcodigo "
                    + "INNER JOIN public.estadousuasistema estadousuasistema ON usuariosistema.codestusuasistema = estadousuasistema.codestusuasistema"
                    + " WHERE usuariosistema.ususisusuario = '" + codigo + "'";

            //System.out.println(sql);
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();

            //System.out.println("CONTINUA");
//
            info += "text|#ususiscodigo_usuarios|" + (rs.getString("usuariosistema_ususiscodigo") == null ? "" : rs.getString("usuariosistema_ususiscodigo")) + ":_";
            info += "text|#ususisusuario_usuarios|" + (rs.getString("usuariosistema_ususisusuario") == null ? "" : rs.getString("usuariosistema_ususisusuario")) + ":_";
            info += "text|#ususiscodigoalt_usuarios|" + (rs.getString("usuariosistema_ususiscodigoalt") == null ? "" : rs.getString("usuariosistema_ususiscodigoalt")) + ":_";
            info += "text|#ususisnombre_usuarios|" + (rs.getString("usuariosistema_ususisnombre") == null ? "" : rs.getString("usuariosistema_ususisnombre")) + ":_";
            info += "text|#ususisapellido_usuarios|" + (rs.getString("usuariosistema_ususisapellido") == null ? "" : rs.getString("usuariosistema_ususisapellido")) + ":_";

            info += "combo|#codtipoidentidad_usuarios|" + rs.getString("usuariosistema_codtipoidentidad") + "|llenarCombo('codtipoidentidad_usuarios', '" + rs.getString("usuariosistema_codtipoidentidad") + "', '" + rs.getString("tipoidentificacion_descripcion") + "'):_";
            info += "text|#ususisindenfica_usuarios|" + (rs.getString("usuariosistema_ususisindenfica") == null ? "" : rs.getString("usuariosistema_ususisindenfica")) + ":_";
            info += "combo|#grusegcodigo_usuarios|" + rs.getString("usuariosistema_grusegcodigo") + "|llenarCombo('grusegcodigo_usuarios', '" + rs.getString("usuariosistema_grusegcodigo") + "', '" + rs.getString("gruposeguridad_grusegdescripcion") + "'):_";
            info += "text|#ususiscontrasena_usuarios|" + (rs.getString("usuariosistema_ususisindenfica") == null ? "" : "") + ":_";
            info += "text|#ususiscontrasena_repetir_usuarios|" + (rs.getString("usuariosistema_ususisindenfica") == null ? "" : "") + ":_";


            String fechaCreacion[] = rs.getString("usuariosistema_ususisfechacrea").split(" ");


            info += "text|#ususisfechacrea_usuarios|" + (fechaCreacion[ 0] == null ? "" : fechaCreacion[ 0]) + ":_";
            info += "text|#ususisfechacrea_usuarios|" + (rs.getString("usuariosistema_ususisfechacrea") == null ? "" : rs.getString("usuariosistema_ususisfechacrea")) + ":_";



            info += "text|#ususisfechamodi_usuarios|" + (rs.getString("usuariosistema_ususisfechamodi") == null ? "" : rs.getString("usuariosistema_ususisfechamodi")) + ":_";

            info += "text|#ususisdias_usuarios|" + (rs.getString("usuariosistema_ususisdias") == null ? "" : rs.getString("usuariosistema_ususisdias")) + ":_";
//
            info += "text|#huelladactilar_usuarios|" + (rs.getString("usuariosistema_huelladactilarnombre") == null ? "" : rs.getString("usuariosistema_huelladactilarnombre")) + ":_";
            info += "text|#foto_usuarios|" + (rs.getString("usuariosistema_fotonombre") == null ? "" : rs.getString("usuariosistema_fotonombre")) + ":_";

//                // Tipos radio
//
//            info += "radio|#ususiscambio_" + rs.getString("usuariosistema_ususiscambio") + "_usuarios|:";
            info += "switch|switch_ususiscambio_usuarios|" + rs.getString("usuariosistema_ususiscambio") + ":_";
            
            //info += "radio|#ususismultisesion_" + rs.getString("usuariosistema_ususismultisesion") + "_usuarios|:";
            info += "switch|switch_ususismultisesion_usuarios|" + rs.getString("usuariosistema_ususismultisesion") + ":_";
            
            //info += "radio|#ususisinterno_" + rs.getString("usuariosistema_ususisinterno") + "_usuarios|:";
            info += "switch|switch_ususisinterno_usuarios|" + rs.getString("usuariosistema_ususisinterno") + ":_";
            
            //info += "radio|#tienehuella_" + rs.getString("usuariosistema_tienehuella") + "_usuarios|:";
            info += "switch|switch_tienehuella_usuarios|" + rs.getString("usuariosistema_tienehuella") + ":_";

            info += "combo|#codestusuasistema_usuarios|" + rs.getString("usuariosistema_codestusuasistema") + "|llenarCombo('codestusuasistema_usuarios', '" + rs.getString("usuariosistema_codestusuasistema") + "', '" + rs.getString("estadousuasistema_descripcion") + "'):_";
//                System.out.println("INFO : " + info);


            respuesta = "opcion=obtener_usuarios&&estado=si&&error=no&&errorDes=no&&codigo=" + codigo + "&&info=" + info.replace("\"", "");

        } catch (SQLException e) {
            respuesta = "opcion=obtener_usuarios&&estado=no&&error=si&&errorDes=" + dkda.convertirACarEspecial(e.getMessage());
            System.out.println("Error UsuariosSistena - Obtener.java: " + e.getMessage());
        }
        System.out.println(respuesta);
        return respuesta;

    }

    public String eliminar_Usuarios(ConexionBaseDatos con, String codigo) {

        con.abrirConexion();
        String[] codigos = codigo.split(",");
        String nuevosCodigos = "";
        for (int n = 0; n < codigos.length; n++) {
            nuevosCodigos += "'" + codigos[ n] + "',";
        }


        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;

            stmt = con.con.prepareStatement("DELETE FROM usuariosistema WHERE ususiscodigo IN(" + nuevosCodigos.substring(0, nuevosCodigos.length() - 1) + ")");
            stmt.execute();
            respuesta = "opcion=eliminar_usuarios&&estado=si&&error=no&&errorDes=no";

        } catch (SQLException e) {
            respuesta = "opcion=eliminar_usuarios&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return respuesta;

    }

    public String validarFormulario_Usuarios() {
        String direccion = "opcion=validacion&&estado=no&&error=si&&errorDes=";
        String error = "";

        if (existeCodigoUsuarioSistema(con, dkda.o(vars, "ususiscodigo_usuarios"))) {
            error = "El c&oacute;digo de Usuario Sistema ya existe, seleccione otro por favor.";
        } else if (dkda.o(vars, "ususiscodigo_usuarios").equals("")) {
            error = "El campo c&oacute;digo de Usuario Sistema no puede ser vacio.";

        } //        else if( dkda.o(vars, "ususiscodigo_usuarios").equals( dkda.o(vars, "ususisusuario_usuarios") ) ){
        //                    }
        else if (!v.alfaNumericos(dkda.o(vars, "ususisusuario_usuarios")) || dkda.o(vars, "ususisusuario_usuarios").equals("")) {
            error = "El campo Usuario Sistema solo puede contener n&uacute;meros y letras.";
        } else if (existeUsuarioSistema(con, dkda.o(vars, "ususisusuario_usuarios"))) {
            error = "El Usuario Sistema ya existe, seleccione otro por favor.";

        } else if (existeCodigoAlterno(con, dkda.o(vars, "ususiscodigoalt_usuarios"))) {
            error = "El campo c&oacute;digo Alterno Usuario Sistema ya existe, seleccione otro por favor.";
        } else if (dkda.o(vars, "ususiscodigoalt_usuarios").equals("")) {
            error = "El campo c&oacute;digo Alterno Usuario Sistema no puede ser vacio.";

        } else if (dkda.o(vars, "ususisnombre_usuarios").equals("") || !v.caracteres(dkda.o(vars, "ususisnombre_usuarios"))) {
            error = "El campo Nombre Usuario solo permite letras.";

        } else if (dkda.o(vars, "ususisapellido_usuarios").equals("") || !v.caracteres(dkda.o(vars, "ususisapellido_usuarios"))) {
            error = "El campo Apellidos Usuario solo permite letras.";

        } else if (dkda.o(vars, "codtipoidentidad_usuarios").equals("")) {
            error = "El campo Tipo de Identificaci&oacute;n no puede ser vacio.";

        } else if (dkda.o(vars, "ususisindenfica_usuarios").equals("") || !v.numeros(dkda.o(vars, "ususisindenfica_usuarios"))) {
            error = "El campo N&uacute;mero de Identificaci&oacute;n solo permite n&uacute;meros.";

        } else if (dkda.o(vars, "grusegcodigo_usuarios").equals("")) {
            error = "El campo Codigo Grupo Usuario no puede ser vacio.";

        } else if (dkda.o(vars, "codestusuasistema_usuarios").equals("")) {
            error = "El campo Codigo Estado Usuario no puede ser vacio.";

        } else if (dkda.o(vars, "ususisdias_usuarios").equals("") || !v.numeros(dkda.o(vars, "ususisdias_usuarios"))) {
            error = "El campo N&uacute;mero D&iacute;as Caducar Contrase&ntilde;a solo permite n&uacute;meros .";

        } else if (!dkda.o(vars, "ususiscontrasena_usuarios").equals(dkda.o(vars, "ususiscontrasena_repetir_usuarios")) || dkda.o(vars, "ususiscontrasena_repetir_usuarios").equals("")) {
            error = "Las contrase&ntilde;as no coinciden, rectifiquelas e intente de nuevo.";
        }
        respuesta = (error.length() > 1 ? direccion + "<strong>" + error + "</strong>" : "");
        System.out.println("RESPUESTA USUARIOS : " + respuesta);
        return respuesta;
    }

    public boolean existeCodigoUsuarioSistema(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        boolean existe = false;
        try {

            PreparedStatement stmt = null;
            ResultSet rs = null;
            String sql = "SELECT COUNT(*) AS cantidad FROM usuariosistema WHERE ususiscodigo = '" + codigo + "' AND ususisusuario != '" + dkda.o(vars, "codigo") + "'";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            existe = rs.getInt("cantidad") >= 1 ? true : false;

        } catch (SQLException e) {
            respuesta = "opcion=registrar&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return existe;
    }

    public boolean existeUsuarioSistema(ConexionBaseDatos con, String usuario) {
        con.abrirConexion();
        boolean existe = false;
        try {

            PreparedStatement stmt = null;
            ResultSet rs = null;
            String sql = "SELECT COUNT(*) AS cantidad FROM usuariosistema WHERE ususisusuario = '" + usuario + "' AND ususisusuario != '" + dkda.o(vars, "codigo") + "'";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            existe = rs.getInt("cantidad") >= 1 ? true : false;

        } catch (SQLException e) {
            respuesta = "opcion=registrar&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return existe;
    }

    public boolean existeCodigoAlterno(ConexionBaseDatos con, String ususiscodigoalt) {
        con.abrirConexion();
        boolean existe = false;
        try {

            PreparedStatement stmt = null;
            ResultSet rs = null;
            String sql = "SELECT COUNT(*) AS cantidad FROM usuariosistema WHERE ususiscodigoalt = '" + ususiscodigoalt + "' AND ususisusuario != '" + dkda.o(vars, "codigo") + "'";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            existe = rs.getInt("cantidad") >= 1 ? true : false;

        } catch (SQLException e) {
            respuesta = "opcion=registrar&&estado=no&&error=si&&errorDes=" + e.getMessage();
            System.out.println("Error UsuariosSistema.java: " + e.getMessage());
        }
        con.cerrarConexion();
        return existe;
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
}
