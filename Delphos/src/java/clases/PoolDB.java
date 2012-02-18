package clases;

import controladores.IConexionPool;
import java.sql.*;
import java.util.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class PoolDB implements IConexionPool {

    protected Stack pool;
    protected DataSource source;

    protected String connectionURL;
    protected String userName;
    protected String password;

    /**
     * Genera Pool básico de conexión utilizando URL , contrase?a y nombre
     */
    public PoolDB() {
//        connectionURL = aConnectionURL;
//        userName = aUserName;
//        password = aPassword;
//        pool = new Stack();


    }

    /** Adquiere conexión del Pool o genera una nueva si el pool esta vacío
     */
    public synchronized Connection extraerConexion()
            throws SQLException {
        System.out.println();
        // Si el pool no esta vacio, tomar una conexion
        if (source != null) {
            System.out.println(" Tomar una conexion del pool");
            return source.getConnection();
        } else {
            // Entonces generar una conexion nueva
            System.out.println(" Genera conexion del pool");
            try {
                // Obtenemos el pool.
                
                Context initCtx = new InitialContext();
                Context envCtx = (Context) initCtx.lookup("java:comp/env");
                source = (DataSource) envCtx.lookup("jdbc/delphos");
                // javax.sql.DataSource ds = (DataSource) contexto.lookup("java:comp/env/jdbc/delphos");
                //bdS.connection = DriverManager.getConnection(url, usuario, clave);
                
            } catch (Exception e) {
                System.out.println(" Exception General (inicializarDataSorce) : " + e.getMessage());
                System.gc();
            }
            return source.getConnection();
        }
    }

    /** Regresar conexion al pool
     */
    public synchronized void liberarConexion(Connection conn)
            throws SQLException {
        conn.close();
        pool.push(conn);
    }
}
