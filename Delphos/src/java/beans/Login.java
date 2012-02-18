package beans;


import clases.bdS;
import java.sql.*;

public class Login {
    
    public Login() {
    }

    private String login;

    public String getLogin() {
        return this.login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    private String password;

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    private String nombre;

    public String getNombre() {
        return this.nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    private String apellido;

    public String getApellido() {
        return this.apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    private String codGrupo;

    public String getCodGrupo() {
        return this.codGrupo;
    }

    public void setCodGrupo(String codGrupo) {
        this.codGrupo = codGrupo;
    }
    
    public boolean verificarLogin(String login)
    {
        PreparedStatement stmt;
        ResultSet rs;

        Connection conexion = bdS.getConexion();
        
        try
        {
            stmt = conexion.prepareStatement("SELECT * FROM usuariosistema WHERE ususisusuario=?");
            stmt.setString(1,login);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                stmt.close();
                return true;
            }
            else
            {
                stmt.close();
                setError("Usuario no registrado.\n<script>alert('Usuario no registrado')</script>");
                return false;
            }
        }
        catch(SQLException sqle)
        {
            System.out.println("Error 1: "+sqle);
            return false;
        }
        catch(Exception e)
        {
            System.out.println("Error: "+e);
            setError("Error al consultar la base de datos<br>"+e+".<script>alert('Error al consultar la base de datos\n"+e+"')</script>");
            return false;
        }
    }
    
    public boolean verificarUsuario(String login,String password)
    {
        PreparedStatement stmt;
        ResultSet rs;

        Connection conexion =  bdS.getConexion();
        
        try
        {
            stmt = conexion.prepareStatement("SELECT * FROM usuariosistema WHERE ususisusuario=? AND ususiscontrasena=md5(?)");
            stmt.setString(1,login);
            stmt.setString(2,password);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                setLogin(login);
                setCodGrupo(rs.getString("grusegcodigo"));
                setNombre(rs.getString("ususisnombre"));
                setApellido(rs.getString("ususisapellido"));
                rs.close();
                stmt.close();
                
                return true;
            }
            else
            {
                rs.close();
                stmt.close();
                setError("Verifique el Password.\n<script>alert('Verifique el password')</script>");
                
                return false;
            }
        }
        catch(SQLException sqle)
        {
            return false;
        }
    }

    private String error;

    public String getError() {
        return this.error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
