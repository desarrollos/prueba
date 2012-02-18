
package controladores;

import java.sql.Connection;
import java.sql.SQLException;

public interface IConexionPool {
    public Connection extraerConexion() throws SQLException;
    public void liberarConexion(Connection conn) throws SQLException;
}
