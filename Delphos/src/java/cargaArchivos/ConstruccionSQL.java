package cargaArchivos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import clases.ConexionBaseDatos;
import java.util.HashMap;

public class ConstruccionSQL {

    String variablesSQL, estructuraColumnas;
    HttpServletRequest request;

    public ConstruccionSQL(HttpServletRequest r, HashMap vars) {
        this.request = r;
        int cantidadColumnas = Integer.parseInt(request.getParameter("cantidadColumnas"));

        PreparedStatement pstmt;
        ResultSet rs;

        ConexionBaseDatos con;
        con = new ConexionBaseDatos();

        variablesSQL = "";
        estructuraColumnas = "";

        for (int i = 0; i < cantidadColumnas; i++) {
            String nombreCampo = "";

            //request.getParameter("columna"+i) trae como valor la variable "codcampoarchivo" de la tabla "listacamposarchivo"
            try {
                con.abrirConexion();


                if (vars.containsKey("columna" + i)) {
                    if (Double.parseDouble((String) vars.get("columna" + i)) > 0)// if para verificacion columnas ignorar
                    {
                        pstmt = con.con.prepareStatement("SELECT nombrecampotabla FROM listacamposarchivo WHERE codcampoarchivo=?");
                        pstmt.setDouble(1, Double.parseDouble((String) vars.get("columna" + i)));
                        rs = pstmt.executeQuery();
                        rs.next();
                        nombreCampo = rs.getString("nombrecampotabla");
                        rs.close();
                        pstmt.close();

                        variablesSQL = variablesSQL + "?,";
                        estructuraColumnas = estructuraColumnas + nombreCampo + ",";
                    }
                }

                con.cerrarConexion();
            } catch (SQLException e) {
                con.cerrarConexion();
                System.err.println("Error al consultar los campos de la tabla: " + e.getMessage());
            }
        }

        variablesSQL = variablesSQL.substring(0, variablesSQL.length() - 1);
        estructuraColumnas = estructuraColumnas.substring(0, estructuraColumnas.length() - 1);
    }

    public String construirVariablesSQL() {
        return variablesSQL;
    }

    public String construirEstructuraColumnas() {
        return estructuraColumnas;
    }
}
