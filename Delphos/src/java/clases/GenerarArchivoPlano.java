package clases;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;

public class GenerarArchivoPlano 
{
    public GenerarArchivoPlano() 
    {
    }
    
    public boolean generarArchivoPlano(String sql, String nombreArchivo,HttpServletRequest request)
    {
        ConexionBaseDatos c;
        c = new ConexionBaseDatos();
        
        try 
        {
            ResultSet rs;
            PreparedStatement stmt;
            
            c.abrirConexion();
            
            stmt = c.con.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            String ruta = request.getSession().getServletContext().getRealPath("temp")+"\\";
            ruta = ruta.replaceAll("\\\\","/");
            
            BufferedWriter out = new BufferedWriter(new FileWriter(ruta+nombreArchivo));
            
            while(rs.next())
            {
                int i;
                String linea = "";
                
                for(i=1; i<=rs.getMetaData().getColumnCount();i++)
                {
                    linea = linea + rs.getObject(i) + "|";
                }
                
                linea = linea.substring(0,linea.length()-1);
                out.write(linea);
                out.newLine();
            }
            
            out.close();
                    
            c.cerrarConexion();
        } 
        catch(IOException e) 
        {
            c.cerrarConexion();
            System.err.println("Error al generar el archivo plano: "+e);
            return false;
        }
        catch(SQLException sqle)
        {
            c.cerrarConexion();
            System.err.println("Error al consultar los datos: "+sqle);
            return false;
        }
        
        return true;
    }
}