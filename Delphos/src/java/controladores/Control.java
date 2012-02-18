package controladores;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import javax.servlet.ServletException;

public interface Control 
{
    //Todas las clases que vayan a ser controladoras de una página JSP 
    //deberán implementar esta interfaz
    public boolean doLogic( HttpServletRequest request,
                            HttpServletResponse response )
    throws ServletException, IOException;
        
}
