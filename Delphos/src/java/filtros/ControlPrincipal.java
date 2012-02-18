package filtros;

import java.io.*;
import java.net.*;
import java.util.*;
import java.text.*;
import javax.servlet.*;
import javax.servlet.http.*;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import controladores.Control;


public class ControlPrincipal implements Filter {
    
    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured.
    private FilterConfig filterConfig = null;
    
    /**
     * Metodo init para este filtro
     *
     */
    public void init(FilterConfig filterConfig) {
        
        this.filterConfig = filterConfig;
    }
    
    /**
     *
     * @param request The servlet request we are processing
     * @param result The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest req, ServletResponse resp,
            FilterChain chain)
            throws IOException, ServletException {
        
        //Throwable problem = null;
        //Validar que la solicitud recibida sea HTTP
        if ( !(req instanceof HttpServletRequest) )
            throw new ServletException("Este filtro requiere una solicitud HTTP");
        
        //Volver HTTP a la solicitud y a la respuesta
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        
        //Obtener el nombre (sin extension) del recurso hacia el cual
        //va dirigida la solicitud.
        //También se valida el caso en el cual el destino de la solicitud
        //no es un archivo sino una carpeta
        String uri = request.getRequestURI();
        int start = uri.lastIndexOf("/")+1;
        int stop = uri.lastIndexOf(".");
        String name = "index";
        if ( start < stop ) 
            name = uri.substring(start,stop);
        
        boolean filtrar = true;

        try
        {
            //Obtener el controlador asociado al recurso. El controlador
            //debe tener el mismo nombre del componente. Ejemplo: Si el 
            //componente es la página index.jsp, debe existir un controlador
            //llamado index.java asociado a esa página
            Object objeto = Class.forName("controladores."+name).newInstance();

            //Validación para verificar que el objeto obtenido sea
            //un controlador y no una clase que por casualidad tiene
            //el mismo nombre del componente
            if ( !(objeto instanceof Control) )
                throw new ServletException("La clase controladores."+name+" no implementa la interfaz controladores.Control");

            //Convertir el objeto a controlador e iniciar la lógica
            //del negocio asociada al componente
            Control control = (Control) objeto;
            filtrar = control.doLogic( request, response );
        }
        catch( ClassNotFoundException cnfe )
        {
            //Si el controlador no se encuentra, no se hace nada
        }
        catch( InstantiationException ie )
        {
            //Si es una clase que no pudo ser instanciada
            throw new ServletException(ie);
        }
        catch( IllegalAccessException iae )
        {
            //Cuando no se tienen permisos para acceder a la clase
            throw new ServletException(iae);
        }
        
        //Si la lógica no tuvo fallos, ceder el control al siguiente eslabón
        if ( filtrar )
            chain.doFilter(request, response);   
    }
    
    
    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }
    
    
    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        
        this.filterConfig = filterConfig;
    }
    
    /**
     * Destroy method for this filter
     *
     */
    public void destroy() {
    }
}
