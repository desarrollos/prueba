package clases;

import java.sql.DriverManager;
import javax.sql.DataSource;
import javax.naming.NamingException;
import java.sql.SQLException;

public class ConexionBaseDatos {

    public java.sql.Connection con;

    public ConexionBaseDatos() {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("no encontro el driver: " + ex);
        }
    }

    public void abrirConexion() {
        try {
            if (con == null) {
       //         con = DriverManager.getConnection("jdbc:postgresql://200.30.68.52:5432/delphos", "postgres", "123456");
                 con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/delphos?allowEncodingChanges=true", "postgres", "armen1a@d3lph052011");

                System.out.println("1.0 Se abrio la Conexion con la Base de Datos - Delphos");
            } else {
                if (con.isClosed()) {
                    // javax.sql.DataSource ds = (DataSource) contexto.lookup("java:comp/env/jdbc/delphos");
                    //  con = ds.getConnection();
          //          con = DriverManager.getConnection("jdbc:postgresql://200.30.68.52:5432/delphos", "postgres", "123456");

                 con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/delphos?allowEncodingChanges=true", "postgres", "armen1a@d3lph052011");
                    System.out.println("1.1 Se abrio la Conexion con la Base de Datos - Delphos");
                }
            }
        } catch (SQLException sqlex) {
            System.out.println("Error al Abrir la Conexion con la Base de Datos - Delphos: " + sqlex);
        }
    } 
    public void cerrarConexion() {
        try {
            if (!con.isClosed()) {
                con.close();
                System.out.println("0.0 Se cerro la Conexion con la Base de Datos - Delphos");
            }
        } catch (SQLException sqlex) {
            System.out.println("0.1 Se cerro la Conexion con la Base de Datos - Delphos");
            System.out.println("Error al Cerrar la Conexion con la Base de Datos - Delphos");
        }
    }
}
