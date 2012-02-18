package clases;

import java.sql.*;

public class ValidacionCamposBD {

    public ValidacionCamposBD() {
    }

    /**
     *
     * @param tabla
     * @param campos
     * @param valores
     * @return Retorna el resultado de la validacion realizada con el procedimiento almacenado
     */
    public String validar(String tabla, String campos, String valores) {
        String resultado = "";
        ConexionBaseDatos con;
        con = new ConexionBaseDatos();

        ResultSet rs = null;
        PreparedStatement pstmt = null;

        try {
            con.abrirConexion();

            pstmt = con.con.prepareStatement("select valida(?,?,?) AS Resultado");
            pstmt.setString(1, tabla);
            pstmt.setString(2, campos);
            pstmt.setString(3, valores);
            rs = pstmt.executeQuery();

            rs.next();
            resultado = rs.getString("Resultado");
            rs.close();
            pstmt.close();

            con.cerrarConexion();
            return resultado;
        } catch (SQLException e) {
            //con.cerrarConexion();
            return "ERR";
        }
    }

    public String validarEstructuraRegistro(String linea, String campos, String delimitador) {
        int cantidad1, cantidad2;

        java.util.Vector vectorCampos1, vectorCampos2;

        vectorCampos1 = UtilidadesDKDA.split(linea, delimitador);
        vectorCampos2 = UtilidadesDKDA.split(campos, ",");

        cantidad1 = vectorCampos1.size();
        cantidad2 = vectorCampos2.size();

        if (cantidad1 == cantidad2) {
            return "OK";
        } else if (cantidad1 < cantidad2) {
            return "ERR-09";
        } else //if(cantidad1>cantidad2)
        {
            return "ERR-10";
        }
    }
}
