/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package formularios;

import clases.ConexionBaseDatos;
import clases.UtilidadesDKDA;
import java.io.File;

import java.util.HashMap;
import java.sql.*;
import java.util.Arrays;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Sebas
 */
public class funciones {

    UtilidadesDKDA dkda = new UtilidadesDKDA();

    //public void
    // Retorna las empresas de la tabla
    public String tabla(ConexionBaseDatos con, HashMap vars, HttpServletRequest request, int LIMITE_COLUMNAS) {
        String tabla = vars.get("tabla").toString();
        // Resultados por pagina
        int TAMANIO = 30;
        int LIMITE_TABLA = LIMITE_COLUMNAS;


        // Parametros que manda el flexigrid
        int pagina = Integer.parseInt(request.getParameter("page"));
        String ordenarPor = request.getParameter("sortname");
        String tipoOrden = request.getParameter("sortorder");
        String columnaBusqueda = request.getParameter("qtype");
        String textoBuscado = request.getParameter("query");
        int iniciales = Integer.parseInt(request.getParameter("rp"));

 
        String seleccion = (vars.containsKey("seleccion") ? vars.get("seleccion").toString() : "descripcion");
        String principal = (vars.containsKey("principal") ? vars.get("principal").toString() : "");
        String relacion = (vars.containsKey("relacion") ? vars.get("relacion").toString() : "").replace("|", " = ");


        System.out.println("RELACION : " + relacion);

        String xml = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT " + camposTabla(con, tabla, LIMITE_TABLA, "") + " FROM " + tabla +"  " + ( relacion.equals("") ? "" : " WHERE "
                    + relacion ) +  " " + (textoBuscado.equals("") ? ""
                    : "WHERE  " + "lower(cast(" + (columnaBusqueda) + " as TEXT)) LIKE lower('" + textoBuscado + "') "  +( relacion.equals("") ? "" : "  " + relacion ) ) 
                    
                    + " order by " + ordenarPor + " " + tipoOrden + " LIMIT " + (TAMANIO != iniciales ? iniciales : TAMANIO) + " OFFSET " + ((pagina - 1) * TAMANIO);
                        
            
            request.getSession().setAttribute(usuarioAutenticado(request) + "_reporte", sql);

            System.out.println(sql);

            stmt = con.con.prepareStatement(sql);



            rs = stmt.executeQuery();

            String[] principalCorte = principal.split(",");

            while (rs.next()) {
                String[] campos = camposTabla(con, tabla, LIMITE_TABLA, "").split(",");
                String cell = "";
                String camposValor = "";
                for (int n = 0; n < campos.length; n++) {

                    String dato = dkda.convertirACarEspecial(rs.getString(campos[ n]));
                    cell += "<cell><![CDATA[<span title=\"" + dato.replace("\"", " ") + "\">" + dato.replace("\"", " ") + "</span>]]></cell>";

                    if (principal.indexOf(",") > -1) {
                        if (buscarEnArreglo(principalCorte, campos[ n])) {
                            camposValor += campos[ n] + "  " + rs.getString(campos[ n]) + "   ";
                        }
                    }
                }
                xml += "<row id=\"codigo_" + (principal.indexOf(",") > -1 ? tabla + "   " + camposValor : rs.getString(principal)) + "--" + seleccion + "\">" + cell + "</row>";

            }
            xml = "<rows><page>" + pagina + "</page><total>" + cantidadDatosTabla(con, "SELECT COUNT(*) AS cantidad FROM " + tabla) + "</total> " + xml + "</rows>";

        } catch (SQLException e) {
            System.out.println("Error en clase funciones: " + e.getMessage());
        }

        return xml;
    }

    public int cantidadDatosTabla(ConexionBaseDatos con, String sql) {
        int cantidad = 0;
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            cantidad = rs.getInt("cantidad");
        } catch (SQLException e) {
            System.out.println("Error en clase funciones: " + e.getMessage());
        }

        return cantidad;

    }

    public String temp(HttpServletRequest request) {
        return (request.getSession().getServletContext().getRealPath("temp") + File.separatorChar).replaceAll("\\\\", "/");
    }

    public String empresaNit(ConexionBaseDatos con, String codigo) {
        con.abrirConexion();
        String codtipoidentidad = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            stmt = con.con.prepareStatement("SELECT codtipoidentidad as tipo FROM empresa WHERE codempresa = '" + codigo + "'");
            rs = stmt.executeQuery();
            rs.next();
            codtipoidentidad = (rs.getString("tipo").equals("") ? "nit" : rs.getString("tipo"));
        } catch (SQLException e) {
            System.out.println("Error en clase funciones: " + e.getMessage());
        }
        return codtipoidentidad;
    }

    public HashMap map(String datos) {
        String datosCorte[] = datos.split("   ");
        HashMap mapa = new HashMap();
        //System.out.println("datos : " + datos);
        //System.out.println( "DATOS CORTE LENGTH : " + datosCorte.length ) ;
        for (int n = 1; n <= (datosCorte.length - 1); n++) {
            if (datosCorte[ n].indexOf("  ") == -1) {
                break;
            }
            String claveValor[] = datosCorte[ n].split("  ");
            //System.out.println("GUARDAR : " + claveValor[ 0 ] + "  " + claveValor[ 1 ]);
            mapa.put(claveValor[ 0], claveValor[ 1]);

        }
        return mapa;
    }

    public String camposTabla(ConexionBaseDatos con, String tabla, int limite, String columnas) {
        String[] columnasC = columnas.split(",");

        con.abrirConexion();
        String campos = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT * FROM information_schema.columns WHERE table_name = '" + tabla + "' ORDER BY ordinal_position ASC LIMIT " + limite + " ";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                if (!columnas.equals("") && !buscarEnArreglo(columnasC, rs.getString("column_name"))) {

                    continue;
                }
                campos += rs.getString("column_name") + ",";
            }

        } catch (SQLException e) {
            System.out.println("Error en clase funciones: " + e.getMessage());
        }


        return (campos.indexOf(",") > 0 ? campos.substring(0, campos.length() - 1) : campos);
    }

    public String camposTablaDesc(ConexionBaseDatos con, String tabla, int limite, String columnas) {
        String[] columnasC = columnas.split(",");

        con.abrirConexion();
        String campos = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT  description FROM  information_schema.COLUMNS  LEFT JOIN    pg_class ON COLUMNS.TABLE_NAME::name = pg_class.relname LEFT JOIN     pg_description ON pg_class.oid = pg_description.objoid AND COLUMNS.ordinal_position::INTEGER = pg_description.objsubid WHERE   COLUMNS.table_schema::text = 'public'::text   AND   COLUMNS.TABLE_NAME = '" + tabla + "' LIMIT " + limite;

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                if (!columnas.equals("") && !buscarEnArreglo(columnasC, rs.getString("description"))) {

                    continue;
                }
                campos += rs.getString("description") + ",";
            }

        } catch (SQLException e) {
            System.out.println("Error en clase funciones: " + e.getMessage());
        }

        
        return (campos.indexOf(",") > 0 ? campos.substring(0, campos.length() - 1) : campos);
    }

    private boolean buscarEnArreglo(String[] arreglo, String busqueda) {
        for (int n = 0; n < arreglo.length; n++) {
            if (busqueda.equals(arreglo[ n])) {
                return true;
            }
        }
        return false;
    }
    // Obtiene el valor actual de la secuencia +

    public String vaAcSec(ConexionBaseDatos con, String nomSec) {
        con.abrirConexion();
        String sec = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT last_value FROM " + nomSec;
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            rs.next();
            sec = rs.getString("last_value");


        } catch (SQLException e) {
            System.out.println("Error obteniendo el valor de la secuencia en funciones.java");
        }
        return sec;
    }

    public String tablaJson(String camposDesc, String campos) {
        String json = "";
        String camposA[] = campos.split(",");
        String camposDescA[] = camposDesc.split(",");
        for (int n = 0; n < camposA.length; n++) {
            json += "{ \"name\": \"" + camposA[ n] + "\", \"display\": \"" + ( camposDescA[ n].equals("null") ? "CAMPO SIN NOMBRE" : camposDescA[ n] )  + "\", \"width\": \"120\", \"sortable\" : \"true\"  },";
        }
        json = json.substring(0, json.length() - 1);
         
        return "[" + json + "]";
    }

    public String usuarioAutenticado(HttpServletRequest request) {
        String usuario = request.getSession().getAttribute("login").toString();


        return usuario;
    }

    public String secJson(ConexionBaseDatos con, String[] secuen) {
        String secuencias = "";
        for (String d : secuen) {
            //secuencias += d + ":"+ fun.vaAcSec(con, d) + ",";
            secuencias += "{ \"nomSec\" : \"" + d + "\", \"valor\" : \"" + vaAcSec(con, d) + "\" },";
        }
        return secuencias.substring(0, secuencias.length() - 1);
    }

    public String usuariosSistema(ConexionBaseDatos con, String limite) {
        limite = (limite.equals("") ? "10" : limite);
        con.abrirConexion();
        String campos = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT ususiscodigo,ususisnombre,ususisapellido FROM usuariosistema LIMIT " + limite;

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                campos += "<li class=\"ui-widget-content\" id=\"ususiscodigo_" + rs.getString("ususiscodigo") + "\">" + dkda.convertirACarEspecial(rs.getString("ususisnombre")) + " "
                        + dkda.convertirACarEspecial(rs.getString("ususisapellido")) + "</li>";
            }

            campos = ""
                    + /*"<div class=\"boton\">"
                    + "<input type=\"submit\" value=\"Mostrar Usuarios Registrados\" onclick=\"return tabla(flexiUsuarios, 'Usuarios Sistema', '' )\" />"
                    + "<input type=\"submit\" value=\"Reiniciar\" />"
                    + </div>*/ "<br /><ol class=\"usuarios\">" + campos + "</ol>";

        } catch (SQLException e) {
            System.out.println("Error en clase funciones: " + e.getMessage());
        }

        System.out.println(campos);
        return campos;


    }

    public String usuariosPaginas(ConexionBaseDatos con, String limite, String usuario) {
        limite = (limite.equals("") ? "10" : limite);
        con.abrirConexion();
        String campos = "";
        String campo_o = "";
        try {
            ResultSet rs_o = null;
            PreparedStatement stmt_o = null;
            String sql_o = "SELECT ususiscodigo, lisopccodigo FROM opcionusuario WHERE ususiscodigo = '" + usuario + "'";

            stmt_o = con.con.prepareStatement(sql_o);
            rs_o = stmt_o.executeQuery();
            while (rs_o.next()) {
                campo_o += rs_o.getString("lisopccodigo") + ",";
            }
            String campos_a[] = campo_o.split(",");



            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT lisopccodigo,lisopcprograma,orcodigo FROM listaopcion LIMIT " + limite;

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                // 
                String seleccion = (buscarEnArreglo(campos_a, rs.getString("lisopccodigo")) ? "ui-widget-content ui-selectee ui-selected" : "ui-widget-content ui-selectee");
                campos += "<li  class=\"" + seleccion + "\" id=\"lisopccodigo_" + rs.getString("lisopccodigo") + "\">" + dkda.convertirACarEspecial(rs.getString("lisopcprograma")) + " / "
                        + dkda.convertirACarEspecial(rs.getString("orcodigo")) + "</li>";
            }

            campos = ""
                    + /*"<div class=\"boton\">"
                    + "<input type=\"submit\" value=\"Mostrar Paginas Registradas\" onclick=\"return tabla(flexiUsuarios, 'Usuarios Sistema', '' )\" />"
                    + "<input type=\"submit\" value=\"Reiniciar\" />"
                    + </div>*/ "<br /><ol class=\"paginas\">" + campos + "</ol>";

        } catch (SQLException e) {
            System.out.println("Error en clase funciones: " + e.getMessage());
        }


        return campos;


    }

    public String usuariosPaginasPerfiles(ConexionBaseDatos con, String limite, String usuario, String pagina) {
        limite = (limite.equals("") ? "10" : limite);
        con.abrirConexion();
        String campos = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;
            String sql = "SELECT "
                    + "nivelsegopcion.niseopcodigo AS nivelsegopcion_niseopcodigo "
                    + " FROM "
                    + " public.nivelsegopcion nivelsegopcion INNER JOIN public.opcionusuario opcionusuario ON nivelsegopcion.niseopcodigo = opcionusuario.niseopcodigo"
                    + " WHERE opcionusuario.ususiscodigo = '" + usuario + "' AND opcionusuario.lisopccodigo = '" + pagina + "'";

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            String perfil = "";
            if (rs.next()) {
                perfil = rs.getString("nivelsegopcion_niseopcodigo");
            }


            //System.out.println( "PERFIL : " + perfil );

            rs = null;
            stmt = null;
            sql = "SELECT * FROM nivelsegopcion";
            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {

                campos += "<li class=\"" + (perfil.equals(rs.getString("niseopcodigo")) ? "ui-widget-content ui-selectee ui-selected" : "ui-widget-content ui-selectee") + "\" id=\"nivelsegopcion_" + rs.getString("niseopcodigo") + "\">" + dkda.convertirACarEspecial(rs.getString("niseopdescripcion")) + "</li>";
            }

            //System.out.println( campos );

            campos = ""
                    +/* "<div class=\"boton\">"
                    + "<input type=\"submit\" value=\"Mostrar Perfiles Registrados\" onclick=\"return tabla(flexiUsuarios, 'Usuarios Sistema', '' )\" />"
                    + "<input type=\"submit\" value=\"Reiniciar\" />"
                    + </div>*/ "<br /><ol class=\"perfiles\">" + campos + "</ol>";

        } catch (SQLException e) {
            System.out.println("Error en clase funciones: " + e.getMessage());
        }


        return campos;


    }

    public String guardarUsuariosPaginasPerfiles(ConexionBaseDatos con, String limite, String usuario, String pagina, String perfil) {
        con.abrirConexion();
        String campos = "";
        String sql = "";
        try {
            ResultSet rs = null;
            PreparedStatement stmt = null;

            sql = "SELECT * FROM opcionusuario WHERE ususiscodigo = '" + usuario + "' AND lisopccodigo = '" + pagina + "'";
            System.out.println("CONSULTA : " + sql);

            stmt = con.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            if (rs.next()) {
                System.out.println("Actualizacion");
                rs = null;
                stmt = null;
                sql = "UPDATE opcionusuario SET "
                        + "ususiscodigo = '" + usuario + "',"
                        + "lisopccodigo = '" + pagina + "',"
                        + "niseopcodigo = '" + perfil + "',"
                        + "ususiscodigor = 'DELPHOS',"
                        + "fecharegistro = 'NOW()' WHERE ususiscodigo = '" + usuario + "' AND lisopccodigo = '" + pagina + "' ";
                System.out.println(sql);
                stmt = con.con.prepareStatement(sql);
                stmt.execute();

            } else {
                System.out.println("Inserccion");
                rs = null;
                stmt = null;
                sql = "INSERT INTO opcionusuario(ususiscodigo, lisopccodigo, niseopcodigo, ususiscodigor, fecharegistro) "
                        + "VALUES('" + usuario + "','" + pagina + "','" + perfil + "', 'DELPHOS', 'NOW()')";

                stmt = con.con.prepareStatement(sql);
                boolean estado = stmt.execute();
            }






        } catch (SQLException e) {
            System.out.println("Error en clase funciones: " + e.getMessage());
        }

        return campos;
    }
}
