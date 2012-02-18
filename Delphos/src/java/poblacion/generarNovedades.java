/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package poblacion;

import clases.ConexionBaseDatos;
import clases.ed_ValidacionCampos;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Scanner;

/**
 *
 * @author gaso
 */
public class generarNovedades {

    // Instancia Conexion BD
    ConexionBaseDatos con;
    //Verifica si campo aplica novedad y retorna codigo.
    NovedadesPoblacion NovPobla;
    // Instancia Clase Validacion con E.R. y demas validaciones genericas.
    ed_ValidacionCampos v;
    //** Instancia de la Clase que devuelve el codigo del campo listacampoarchivo**/
    ComunProcesos idCampo = new ComunProcesos();
    //Mapa que almacena los codigos de los Campos y la posicion en la que vienen
    HashMap<Integer, Double> CodigoCampo = new HashMap<Integer, Double>();
    //Mapa almacena los campos(columnas) que se verificara si aplica Novedad
    HashMap<Integer, String> camposApliNovedad = new HashMap<Integer, String>();
    //Mapa almacena columnas que seran tenidas en cuenta para verificar Usuarios-Nuevos por medio de un [SELECT - LIKE]
    HashMap<Integer, String> columnasObligatorias = new HashMap<Integer, String>();
    //
    HashMap<Integer, String> columnasCoincidencias = new HashMap<Integer, String>();
    //
    HashMap<String, String> columnasFechas = new HashMap<String, String>();
    //Almacena la posicion del campo fecha y su respectivo separador.
    HashMap<Integer, String> ColumFechaSeparador = new HashMap<Integer, String>();
    //Almacena la posicion del ampo fecha y la estructura de como llega AAAA-DD-MM
    HashMap<Integer, String> CFechas = new HashMap<Integer, String>();

    HashMap<Integer, String> posicionColum = new HashMap<Integer, String>();

    HashMap<String, Integer> columCriterios = new HashMap<String, Integer>();
    //Codigo del Encabezado Carga Archivo
    String encabezado;
    // Ruta donde se almacenaran los archivos temporales de la carga
    String rutaTemporales;
    // Nombre del Archivo Plano Correcto generado despues de la validacion y verificacion de Inconsistencias.
    String nombreArchivo;
    // Ruta a donde apuntan las cargas de los archivos Temporales.
    String rutaArchivo;
    String columObligatorias = "";
    String columCoincidencias = "";
    String columFechas = "";
    String estructuraColumnas = "";
    String CamposFechaFormato = "";
    String criterioSeleccionado = "";
    private String consulta;
    int columIdentificacion;
    int columTipoIdentificacion;
    int ConsecutivoCoincidencia = 1;
    StringBuilder NIdentificacionRegistrosNuevos = new StringBuilder("");
    String posicionColumnas;
    //Flag que se activa siempre y cuando se encontraron coincidencias
    Boolean coincidencias = false;
    //Ruta donde estan ubicados los Planos de coincidencias y coincidecia-campos
    String urlcoincpoblacion;
    String urlcoincamposreg;
    String urlnovedadcampo;
    Timestamp fechaRegistro = new Timestamp(System.currentTimeMillis());
    //Usuario del Sistema
    String usuarioSistema;

    /**
     *
     * @param estructuraColumnas Estructura que se escoje para verificar el Archivo.
     * @param Ruta a donde apuntan las cargas de los archivos Temporales. ("/delphos/temp/")
     * @param nombreArchivo Nombre del Archivo Plano generado con Registros Validos para verificar Novedades.
     * @param columObligatorias Posicion-CampoBD de las columnas que seran tomadas en cuenta para verificar si un usuario es nuevo o no.
     * @param urlPoblacion --nn--
     * @param codEncabezado Codigo del Encabezado relacionado con el procedimiento de Novedades/Inconsistencias
     *
     * Javadoc: <strong>GASO</strong>
     */
    public void generarN(String estructuraColumnas, String rutaArchivo, String nombreArchivo, String columObligatorias, String columConsidencias, String columFechas, String urlPoblacion, String codEncabezado, String formatoFechas, String posicionColumnas, String CriterioBus, String usuarioS) {

//        System.out.println("---------------------");
//        System.out.println("1: " + estructuraColumnas);
//        System.out.println("2: " + rutaArchivo);
//        System.out.println("3: " + nombreArchivo);
//        System.out.println("4: " + columObligatorias);
//        System.out.println("6: " + columConsidencias);
//        System.out.println("7: " + columFechas);
//        System.out.println("8: " + urlPoblacion);
//        System.out.println("9: " + codEncabezado);
//        System.out.println("---------------------");
//

        v = new ed_ValidacionCampos();
        con = new ConexionBaseDatos();

        this.encabezado = codEncabezado;
        this.nombreArchivo = nombreArchivo;
        this.rutaArchivo = rutaArchivo;
        this.posicionColumnas = posicionColumnas;
        this.columObligatorias = columObligatorias;
        this.columCoincidencias = columConsidencias;
        this.columFechas = columFechas;
        this.estructuraColumnas = estructuraColumnas;
        this.CamposFechaFormato = formatoFechas;
        this.criterioSeleccionado = CriterioBus;
        this.usuarioSistema = usuarioS;
        //this.rutaArchivosNovedades = rutaArchivo+encabezado+ System.getProperty("file.separator") + "nov" + System.getProperty("file.separator");

        System.out.println( "LINEA DE PRUEBA" );
        rutaTemporales = setCarpetaTrabajo(this.rutaArchivo);
        camposNovedad(estructuraColumnas, columObligatorias, columConsidencias, columFechas, posicionColumnas);
        queryCriterio();
        //setColumnFechas();
        LeerArchivo(urlPoblacion);
        insertCopyCoinci(urlcoincpoblacion, urlcoincamposreg);

     //   System.out.println("criterioSeleccionado " + criterioSeleccionado);
       // System.out.println("posicionColumnas*** " + posicionColumnas);
    }

    void LeerArchivo(String rutaArchivo) {

        File f = new File(rutaArchivo); //"e:/texto.txt"
        FileReader fr = null;
        BufferedReader br = null;

        //Scanner s;
        int contadorLinea = 0;
        int contadorColumna = 0;

        int validoLongitud = 0;
        int validoTipoDato = 0;

        String valor = "";
        //System.out.println( (int) Math.floor( idCampo.obtenerCodCampoArchivo("fechaafilsissegsoc") )  );


        try {
            fr = new FileReader(f);
            br = new BufferedReader(fr);
            
            
            
            String linea;
            int cantidadInsertados = 0;
            while ((linea = br.readLine()) != null) {
                
                if (!linea.trim().equals("")) {
                    // System.out.println("Linea Vacia: " + contadorLinea);

                    // Almacena linea a linea
                    StringBuilder lineaPoblacion = new StringBuilder("");
                    StringBuilder registroObligatorios = new StringBuilder("");
                    StringBuilder registroCoincidencias = new StringBuilder("");
                    //almacena solo los datos(linea) que estan en la estructura
                    StringBuilder datosEstructura = new StringBuilder("");
                    StringBuffer sqlCoincidencias = new StringBuffer();

                    Scanner sl = new Scanner(linea);
                    sl.useDelimiter("\\s*" + "," + "\\s*");
                    contadorLinea++;
                    
                    
                    //System.out.println("Linea Numero " + contadorLinea);

                   
                    while (sl.hasNext()) {
                        valor = sl.next();
                        // if ( (contadorColumna !=0) && ( contadorColumna!=1) ){
                        //System.out.println(valor);
                        lineaPoblacion.append(valor).append(",");
                        //System.out.println("posicionColum.get(contadorColumna)" + posicionColum.get(contadorColumna));
                        if (columnasObligatorias.containsKey(contadorColumna)) {


                            //System.out.println("columnasObligatorias.get(contadorColumna))" + columnasObligatorias.get(contadorColumna)  + "valor " + valor);
                            // System.out.println( "En la posicion " + contadorColumna + " valor e? "  + columnasObligatorias.get(contadorColumna) + " dato " + valor);
                            registroObligatorios.append(columnasObligatorias.get(contadorColumna)).append("=").append("'").append(valor).append("'").append(" AND ");
                            datosEstructura.append(valor).append(",");
                        }
                        if (columnasCoincidencias.containsKey(contadorColumna)) {
                            // System.out.println( "En la posicion " + contadorColumna + " valor e? "  + columnasObligatorias.get(contadorColumna) + " dato " + valor);
//
//                            String like = " LIKE '%" + valor + "%' OR ";
//                            String beetwen = " BETWEEN '" + valor + "' AND " + "'" + valor + "'    ";
//
//                            registroCoincidencias.append(columnasCoincidencias.get(contadorColumna)).append(columnasFechas.containsKey(columnasCoincidencias.get(contadorColumna)) ? beetwen : like);
                            datosEstructura.append(valor).append(",");
                        }
                            //OR(TESTING)  - (AND DEBERIA** DE SER LA DEL RELEASE)
//                        if( columCriterios.containsKey(posicionColum.get(contadorColumna))){
//                            String like2 = " LIKE '%" + valor + "%' AND ";
//                            String beetwen2 = " BETWEEN '" + valor + "' AND " + "'" + valor + "' ";
//                            registroCoincidencias.append( posicionColum.get(contadorColumna) ).append( columnasFechas.containsKey(posicionColum.get(contadorColumna)) ? beetwen2 : like2 );
//                            
//                        }


                        contadorColumna++;
                    }
                    //System.out.println( "SQL coincidencias ***.***: " + registroCoincidencias );


                    String lineaCompleta[] = lineaPoblacion.toString().split(",");

                    String cedulaTipoDocumento = " numeroidentafiliado='" + lineaCompleta[columIdentificacion] + "' AND codtipoidentafiliado= '" + lineaCompleta[columTipoIdentificacion] + "' ";

                    //Cedula Sola
                    String cc = lineaCompleta[columIdentificacion];

                    //  System.out.println("**registroObligatorios** " + registroObligatorios);
                    // System.out.println("**datosEstructura** " + datosEstructura);
                    // System.out.println("**cedulaTipoDocumento** " + cedulaTipoDocumento);

                    
                    if (!comprobarExistenciaCC(registroObligatorios.substring(0, registroObligatorios.length() - 4))) {
                        //System.out.println("registroLinea "+registroLinea);
                        // Se llama al metodo que compruebas las coincidencias del registro actual
                        //System.out.println( "registroCoincidencias: " + registroCoincidencias );
                        //String dato = registroCoincidencias.substring(0, registroCoincidencias.length() - 4);
                        //this.consulta = dato;
                        //System.out.println("DATO Query " + dato);
                        //comprobarCoincidencias(dato, cedulaTipoDocumento, cc, datosEstructura.toString());
                        NIdentificacionRegistrosNuevos.append("'").append( lineaCompleta[columIdentificacion]).append("' , ");
                        String cantidadNuevos[] = NIdentificacionRegistrosNuevos.toString().split(",");
                        
                        if( cantidadNuevos.length == 100 ){
                            cantidadInsertados += 100;
                            System.out.println(cantidadInsertados  + " Registros actualizados");
                            prepararNuevoRegistroPPeriodica();
                            NIdentificacionRegistrosNuevos.delete(0, NIdentificacionRegistrosNuevos.length());
                        }
                        
//                        System.out.println( cc );                
                        //System.out.println( NIdentificacionRegistrosNuevos.append(lineaCompleta[columIdentificacion]).append(" OR ") );
                    } else {
                        // Se llama al metodo que genera las novedades del registro
                       // System.out.println("generarNovedades=> :  cedulaTipoDocumento " + cedulaTipoDocumento + "| cedulaTipoDocumento " + cedulaTipoDocumento + " | cc " + cc + " |  datosEstructura" + datosEstructura.toString() + " | " + estructuraColumnas);
                        //comprobarNovedades(cedulaTipoDocumento, datosEstructura.toString());
                    }


                    contadorColumna = 0;
                    validoLongitud = 0;
                    validoTipoDato = 0;

                    System.gc();

                    //System.out.println("valores UPDATE CC " + NIdentificacionRegistrosNuevos);
                }
            }

            // Actualiza todos los registro con estado N en poblacionPeriodica
            prepararNuevoRegistroPPeriodica();

            System.gc();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // En el finally cerramos el fichero, para asegurarnos
            // que se cierra tanto si todo va bien como si salta
            // una excepcion.
            try {
                if (null != fr) {
                    fr.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }

    }

    /**
     *  - Verificar que campos Aplica Novedad y que Codigo corresponde C/U.
     *  - Settear datos Utilizados para Comprobar Usuarios-Nuevos [SELECT - LIKE]
     * @param estructuraColumnas Orden en que viene las Columnas de SeleccionColumnas
     * @param columObligatorias Orden-CampoBD; con que se verifica Novedades/Inconsistencias
     */
    void camposNovedad(String estructuraColumnas, String columObligatorias, String columConcidencias, String columFechas, String posicionCol) {

        //0-campo;1-campo1

        System.out.println(" => 1. Inicio camposNovedad ... " );
        /****** Setteando Columnas Verificar Usuario Nuevo[SOLO CC Y TIPOID] (Inicio)*********/
        String[] columnasObliC = columObligatorias.split(";");
        String[] columnasObliV;
        String clave, valor;
        for (int i = 0; i < columnasObliC.length; i++) {
            columnasObliV = columnasObliC[i].split("-");
            clave = columnasObliV[ 0];
            valor = columnasObliV[ 1];
            columnasObligatorias.put(Integer.parseInt(clave), valor);
        }
        /****** Setteando Columnas Verificar Usuario Nuevo[SOLO CC Y TIPOID] (Fin)*********/
        /****** Setteando Columnas Verificar Usuario Nuevo [DEMAS CAMPOS ! CC/TIPOID] (Inicio)*********/
        String[] columnasCoicedC = columConcidencias.split(";");
        String[] columnasCoicedV;
        String claveC, valorC;
        for (int i = 0; i < columnasCoicedC.length; i++) {
            columnasCoicedV = columnasCoicedC[i].split("-");
            claveC = columnasCoicedV[ 0];
            valorC = columnasCoicedV[ 1];
            columnasCoincidencias.put(Integer.parseInt(claveC), valorC);
        }
        /****** Setteando Columnas Verificar Usuario Nuevo[DEMAS CAMPOS ! CC/TIPOID]  (Fin)*********/
        /***  Columnas-Fechas*/
        String[] columasFecha = columFechas.split(";");
        for (int i = 0; i < columasFecha.length; i++) {
            columnasFechas.put(columasFecha[i], columasFecha[i]);
        }
        /***  Fin Columnas-Fechas*/
        /****** Comprobando Campos Con Novedad  (Inicio)*********/
        NovPobla = new NovedadesPoblacion("user here");
        String[] estrucColumnas = estructuraColumnas.split(",");
        String CodNovedad = "";
        for (int i = 0; i < estrucColumnas.length; i++) {
            CodNovedad = NovPobla.existeNovedadCampo(estrucColumnas[i]);
            if (CodNovedad.length() != 0) {
                camposApliNovedad.put(i, CodNovedad);
            }

            if (estrucColumnas[i].equals("numeroidentafiliado")) {
                columIdentificacion = i;
            }
            if (estrucColumnas[i].equals("codtipoidentafiliado")) {
                columTipoIdentificacion = i;
            }
        }
        // System.out.println("****numeroidentafiliado " + columIdentificacion + " | codtipoidentafiliado " + columTipoIdentificacion+"****");
        /********* Comprobando Campos Con Novedad  (Fin)*********/
        /****/
//        for (int i = 0; i < estrucColumnas.length; i++) {
//            System.out.println("estrucColumnas " + estrucColumnas[i]);
//        }
        String posicion[] = posicionCol.split(",");
        // System.out.println("posicion Size " + posicion.length);
        for (int g = 0; g < posicion.length; g++) {
            posicionColum.put(Integer.parseInt(posicion[g]), estrucColumnas[g]);
        }
        java.util.Iterator it = posicionColum.entrySet().iterator();
        while (it.hasNext()) {
            java.util.Map.Entry e = (java.util.Map.Entry) it.next();
            //    System.out.println("Posicion Columnas ** " + e.getKey() + " " + e.getValue());
            CodigoCampo.put(Integer.parseInt(e.getKey().toString()), idCampo.obtenerCodCampoArchivo(e.getValue().toString(), "poblacionperiodica"));
        }
        /****/
        java.util.Iterator iterador = columnasFechas.entrySet().iterator();
        while (iterador.hasNext()) {
            java.util.Map.Entry e = (java.util.Map.Entry) iterador.next();
           // System.out.println("columnasFechas ** " + e.getKey() + " " + e.getValue());
        }
        
        System.out.println(" => 1. Fin camposNovedad ... " );
    }

    /**
     * Comprueba por <strong>cada registro</strong> si existe en la
     * tabla de poblacion ; identificando si es una Persona Nueva
     * o no.
     *
     * @param queryValues "WHERE construido dinamicamente "
     * @return false si no hay considencias , true si hay considencias en el registro.
     */
    public boolean comprobarExistenciaCC(String queryValues) {
        Boolean nuevo;
        PreparedStatement prepararQ = null;
        ResultSet resultQ = null;
        try {
            con.abrirConexion();
            prepararQ = con.con.prepareStatement(" SELECT COUNT(*) FROM poblacion WHERE " + queryValues);
           



            //System.out.println("1 - EXISTENCIAS POBLACION: "  + "SELECT COUNT(*) FROM poblacion WHERE " + queryValues);

            //System.out.println("SELECT COUNT(*) FROM poblacion WHERE " + queryValues);

            resultQ = prepararQ.executeQuery();
            resultQ.next();
            nuevo = resultQ.getInt(1) == 0 ? false : true;
            prepararQ.close();
            resultQ.close();
            //con.cerrarConexion();
            return nuevo;
        } catch (SQLException e) {
            //con.cerrarConexion();
            System.err.println("Error al consultar los campos de la tabla (comprobarNovedades()): " + e.getMessage());
            return false;
        }
    }
    int nRegistros = 0;

    public boolean comprobarCoincidencias(String queryValues, String tipodocu_cc, String cc, String datosPoblacionP) {
        Boolean nuevo;

        String[] datosArchivoPlano = datosPoblacionP.toString().substring(0, datosPoblacionP.length() - 1).split(",");

        try {
            con.abrirConexion();
            Statement st = con.con.createStatement();
            ResultSet resultQ = st.executeQuery(" SELECT " + estructuraColumnas + " FROM poblacion WHERE " + queryValues);

            System.out.println("2. -> COINCIDENCIAS: " + " SELECT " + estructuraColumnas + " FROM poblacion WHERE " + queryValues);


            String query[] = estructuraColumnas.split(",");
            if (resultQ.next()) {
                //hay coincidencias...
          //      System.out.println("Hay considencias");

                //String[] datosBD = new String[nColumnas];

//                for (int i = 1; i <= nColumnas; i++) {
//                    System.out.println("datosArchivoPlano " + datosArchivoPlano[i - 1]);
//                    String datoPlano = datosArchivoPlano[i - 1];
//                    if ( resultQ.getMetaData().getColumnTypeName(i).equals("date")  ){
//                        System.out.println("Dato Plano " + datoPlano );
//                    }
//                    datosBD[i - 1] = resultQ.getObject(i).toString();
//                    //Si datos son diferentes
//                    if (!resultQ.getObject(i).toString().equals(datoPlano)) {
//                        // Si no son iguales
//                        System.out.println(" bd " + resultQ.getObject(i).toString() + " | plano " + datosArchivoPlano[i - 1]);
//                        System.out.println("Indentificacion BD: " + resultQ.getString("numeroidentafiliado"));
//                        System.out.println("Identificacion Plano:  " + cc);
//                        gA_coincpoblion(criterioSeleccionado + " " + encabezado + " " + ConsecutivoCoincidencia );
//
//                        ConsecutivoCoincidencia++;
//                    }
//                     // System.out.println("Query " + resultQ.getObject(query[i]).toString());
//                }


                java.util.Set set = posicionColum.entrySet();
                java.util.Iterator iter = set.iterator();
                int contador = 0;
                String datoPlano = "";
                while (iter.hasNext()) {
                    java.util.Map.Entry entry = (java.util.Map.Entry) iter.next();

                    datoPlano = datosArchivoPlano[contador];
                    
                    if (columnasFechas.containsValue(entry.getValue().toString())) {
                        //System.out.println("***********datosArchivoPlano***************** " + datosArchivoPlano[contador]);
                        //System.out.println( "datosArchivoPlano[contador] " + datosArchivoPlano[contador] + " | ColumFechaSeparador.get(entry.getKey().toString()) " + ColumFechaSeparador.get(Integer.parseInt(entry.getKey().toString())) + " | CFechas.get(entry.getKey()).toString() " + CFechas.get(entry.getKey()).toString()  + " Iterador C/V " + entry.getKey() + " " + entry.getValue());
                        datoPlano = fechaCorrecta(datosArchivoPlano[contador], ColumFechaSeparador.get(Integer.parseInt(entry.getKey().toString())), CFechas.get(entry.getKey()).toString());
                    }
               //     System.out.println("!" + resultQ.getObject(entry.getValue().toString()) + " | " + datoPlano);
                    if (!resultQ.getObject(entry.getValue().toString()).toString().equals(datoPlano)) {
                        // --- Si no son iguales

                        //System.out.println(" bd " + resultQ.getObject(entry.getValue().toString()).toString() + " | plano " + datoPlano);
                        //System.out.println("Identificacion Plano:  " + cc);


                        //Presenta Errores Auditar para Eliminar => Next Line
                        //gA_coincpoblacion(ConsecutivoCoincidencia + "," + encabezado + "," + datoPlano + "," + resultQ.getObject(entry.getValue().toString()).toString() + "," + "EA" + "," + criterioSeleccionado);

                        //Generar Copy para Tabla coincpoblacion

                        //System.out.println("__Coincidencias___ " + ConsecutivoCoincidencia + "," + encabezado + "," + cc + "," + resultQ.getString("numeroidentafiliado") + "," + "EA" + "," + criterioSeleccionado);

                        
                        gA_coincpoblacion(ConsecutivoCoincidencia + "," + encabezado + "," + cc + "," + resultQ.getString("numeroidentafiliado") + "," + "EA" + "," + criterioSeleccionado);
                        //System.out.println("NEXT: " + ConsecutivoCoincidencia + "," + encabezado + "," + cc + "," + resultQ.getString("numeroidentafiliado") + "," + "EA" + "," + criterioSeleccionado);

                        //Generar Copu para tabla coincamposreg
                        gA_coincamposreg(ConsecutivoCoincidencia + "," + encabezado + "," + CodigoCampo.get(Integer.parseInt(entry.getKey().toString())));
                        ConsecutivoCoincidencia++;
                    }


                    //System.out.println("Query " + resultQ.getObject(entry.getValue().toString()).toString());

                    contador++;
                }


            } else {
                //No hay coincidencias...
         //       System.out.println("COINCIDENCIAS PRUEBA :"  + NIdentificacionRegistrosNuevos.append(tipodocu_cc).append(" OR ").toString() );

                NIdentificacionRegistrosNuevos.append(tipodocu_cc).append(" OR ");
            }




            //nuevo = resultQ.getInt(1) == 0 ? false : true;
            st.close();
            resultQ.close();
           // con.cerrarConexion();
            return true;
        } catch (SQLException e) {
            con.cerrarConexion();
            System.err.println("Error al consultar los campos de la tabla (comprobarCoincidencias()): " + e);
            return false;
        }
    }

    public boolean prepararNuevoRegistroPPeriodica() {
        
        if( NIdentificacionRegistrosNuevos.length() >= 1 ) {

        Boolean nuevo;
        PreparedStatement prepararQ = null;
        try {
            con.abrirConexion();
            //System.out.println("Ejecutando update registros estado N");
            //System.out.println( NIdentificacionRegistrosNuevos.substring(0, NIdentificacionRegistrosNuevos.length() - 3) );
            //System.out.println( "CONSULTA : " + "UPDATE poblacionperiodica SET codestadousuapoblac = 'N' WHERE  numeroidentafiliado IN (" + NIdentificacionRegistrosNuevos.substring(0, NIdentificacionRegistrosNuevos.length() - 3) + ") AND idencabezado = '" + encabezado + "'" );
            prepararQ = con.con.prepareStatement("UPDATE poblacionperiodica SET codestadousuapoblac = 'N' WHERE  numeroidentafiliado IN (" + NIdentificacionRegistrosNuevos.substring(0, NIdentificacionRegistrosNuevos.length() - 3) + ") AND idencabezado = '" + encabezado + "'");
            prepararQ.executeUpdate();
            System.out.println("Proceso de actualizacion de registros terminado hasta el corte");
            //nuevo = resultQ.getInt(1) == 0 ? false : true;
            prepararQ.close();
            //con.cerrarConexion();
            return true;
        } catch (SQLException e) {
            con.cerrarConexion();
            System.err.println("Error al consultar los campos de la tabla (comprobarCoincidencias()): " + e.getMessage());
            return false;
        }
        }
        return false;
    }

    void aplicaNovedad(String estructuraColumas) {
    }

    /**
     * Settea ruta donde se almacenarán los archivos
     * temporales de la carga de archivo actual ; en base
     * al Encabezado.
     * @param ruta URL de la Carpeta Temporal de Carga Archivos
     * @return String Ruta configurada. - String Null si existen problemas generando Carpetas
     */
    String setCarpetaTrabajo(String ruta) {
        try {
            //System.out.println(ruta + codEncabezado + System.getProperty("file.separator"));
            File directorio = new File(ruta + encabezado + System.getProperty("file.separator") + "nov" + System.getProperty("file.separator"));
            directorio.mkdir();
            return directorio.toString() + System.getProperty("file.separator");
        } catch (Exception e) {
            System.out.println("Error settiando ruta Trabajo serCarpetaTrabajo() " + e.getMessage());
            return "null";
        }

    }

    void setColumnFechas() {
        
        
        String[] columnFechas = CamposFechaFormato.split(",");
        //System.out.println("columnFechas " + columnFechas.length + " | " + CamposFechaFormato);
        String[] datosFecha;
        String clave, valor, separador;
        for (int i = 0; i < columnFechas.length; i++) {
            datosFecha = columnFechas[i].split(":");
            clave = datosFecha[0];
            ColumFechaSeparador.put(Integer.parseInt(clave), datosFecha[1]);
            valor = datosFecha[2] + datosFecha[1] + datosFecha[3] + datosFecha[1] + datosFecha[4];
            CFechas.put(Integer.parseInt(clave), valor);
        }

        java.util.Iterator it = CFechas.entrySet().iterator();
        while (it.hasNext()) {
            java.util.Map.Entry e = (java.util.Map.Entry) it.next();
       //     System.out.println("CFECHA VALUES " + e.getKey() + " " + e.getValue());
        }

        java.util.Iterator itereador = ColumFechaSeparador.entrySet().iterator();
        while (itereador.hasNext()) {
            java.util.Map.Entry e = (java.util.Map.Entry) itereador.next();
       //     System.out.println("ColumFechaSeparador " + e.getKey() + " " + e.getValue());
        }
    }

    String fechaCorrecta(String fecha, String separador, String formato) {

        //String FormatoFecha = "DD:MM:AAAA";

     //   System.out.println("fechaCorrecta() " + fecha + " " + separador + " " + formato);

        String[] formatoFecha = formato.split(separador);
        String[] fechaV = fecha.split(separador);

   //     System.out.println("formatoFecha " + formatoFecha.length);
   //     System.out.println("fechaV " + fechaV.length);


        String fechaReturn = "";

        //Siempre AAAA-MM-DD

        //AAAA-MM-DD
        if (formatoFecha[0].equals("AAAA") && formatoFecha[1].equals("MM") && formatoFecha[2].equals("DD")) {
            fechaReturn = fechaV[0] + "-" + fechaV[1] + "-" + fechaV[2];
        }
        //AAAA-DD-MM
        if (formatoFecha[0].equals("AAAA") && formatoFecha[1].equals("DD") && formatoFecha[2].equals("MM")) {
            fechaReturn = fechaV[0] + "-" + fechaV[2] + "-" + fechaV[1];
        }
        //DD-MM-AAAA
        if (formatoFecha[0].equals("DD") && formatoFecha[1].equals("MM") && formatoFecha[2].equals("AAAA")) {
            fechaReturn = fechaV[2] + "-" + fechaV[1] + "-" + fechaV[0];
        }
        //DD-AAAA-MM
        if (formatoFecha[0].equals("DD") && formatoFecha[1].equals("AAAA") && formatoFecha[2].equals("MM")) {
            fechaReturn = fechaV[1] + "-" + fechaV[2] + "-" + fechaV[0];
        }
        //MM-DD-AAAA
        if (formatoFecha[0].equals("MM") && formatoFecha[1].equals("DD") && formatoFecha[2].equals("AAAA")) {
            fechaReturn = fechaV[2] + "-" + fechaV[0] + "-" + fechaV[1];
        }
        //MM-AAAA-DD
        if (formatoFecha[0].equals("MM") && formatoFecha[1].equals("AAAA") && formatoFecha[2].equals("DD")) {
            fechaReturn = fechaV[1] + "-" + fechaV[0] + "-" + fechaV[2];
        }


    //    System.out.println("fechaReturn " + fechaReturn);

        return fechaReturn;
    }

    String dAnterior = "";
    void gA_coincpoblacion(String dato) {

        
        //System.out.println("Dato Anterior " + dAnterior);
        //System.out.println("gA_coincpoblion " + dato);


       if( !dAnterior.equals(dato) ){
            FileWriter fichero = null;
        PrintWriter pw = null;
        try {
            urlcoincpoblacion = rutaTemporales + v.archivoRenombrar(nombreArchivo, "coinci");
            fichero = new FileWriter(urlcoincpoblacion, true);
            pw = new PrintWriter(fichero);
            pw.println(dato);
            coincidencias = true;
        } catch (Exception e) {
            e.printStackTrace();
            coincidencias = false;
        } finally {
            try {
                // Nuevamente aprovechamos el finally para
                // asegurarnos que se cierra el fichero.
                if (null != fichero) {
                    fichero.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
            dAnterior = dato;
        }
       }
    }

    void gA_coincamposreg(String dato) {
      //  System.out.println("gA_coincpoblion " + dato);
        FileWriter fichero = null;
        PrintWriter pw = null;
        try {
            urlcoincamposreg = rutaTemporales + v.archivoRenombrar(nombreArchivo, "datoscoinci");
            fichero = new FileWriter(urlcoincamposreg, true);
            pw = new PrintWriter(fichero);
            pw.println(dato);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                // Nuevamente aprovechamos el finally para
                // asegurarnos que se cierra el fichero.
                if (null != fichero) {
                    fichero.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }

    void insertCopyCoinci(String urlcoincpoblacion, String urlcoincamposreg) {
        if (coincidencias) {
            try {
                PreparedStatement stmt;
                stmt = con.con.prepareStatement("SET CLIENT_ENCODING='LATIN1'");
                stmt.execute(); 
                stmt.close();
                stmt = con.con.prepareStatement("COPY coincpoblacion ( id,idencabezado,numeroidentafiliadopp,numeroidentafiliadop,estado,criterio) FROM '" + urlcoincpoblacion.replace(System.getProperty("file.separator"), "/") + "' WITH DELIMITER '" + "," + "'");
                stmt.execute();
                stmt = con.con.prepareStatement("COPY coincamposreg ( id,idencabezado,codcampoarchivo) FROM '" + urlcoincamposreg.replace(System.getProperty("file.separator"), "/") + "' WITH DELIMITER '" + "," + "'");
                stmt.execute();

                stmt.close();
            } catch (SQLException e) {
                System.out.println("generarNovedades=>insertCopy() Error " + e);
                e.printStackTrace();
                System.gc();
            }
        }
    }

    void comprobarNovedades(String queryID, String lPlano) {

        String[] datosArchivoPlano = lPlano.toString().substring(0, lPlano.length() - 1).split(",");

        try {
            con.abrirConexion();
            Statement st = con.con.createStatement();
            ResultSet resultQ = st.executeQuery(" SELECT idusuario , " + estructuraColumnas + " FROM poblacion WHERE " + queryID);
            //System.out.println(" 3. -> comprobarNovedades :| SELECT idusuario , " + estructuraColumnas + " FROM poblacion WHERE " + queryID);


            if (resultQ.next()) {

                java.util.Set set = posicionColum.entrySet();
                java.util.Iterator iter = set.iterator();
                int contador = 0;
                String datoPlano = "";
                while (iter.hasNext()) {
                    java.util.Map.Entry entry = (java.util.Map.Entry) iter.next();

                    datoPlano = datosArchivoPlano[contador];

                    if (columnasFechas.containsValue(entry.getValue().toString())) {
                        //System.out.println("***********datosArchivoPlano***************** " + datosArchivoPlano[contador]);
                        //System.out.println( "datosArchivoPlano[contador] " + datosArchivoPlano[contador] + " | ColumFechaSeparador.get(entry.getKey().toString()) " + ColumFechaSeparador.get(Integer.parseInt(entry.getKey().toString())) + " | CFechas.get(entry.getKey()).toString() " + CFechas.get(entry.getKey()).toString()  + " Iterador C/V " + entry.getKey() + " " + entry.getValue());
                        datoPlano = fechaCorrecta(datosArchivoPlano[contador], ColumFechaSeparador.get(Integer.parseInt(entry.getKey().toString())), CFechas.get(entry.getKey()).toString());
                    }
                 //   System.out.println("(comprobarNovedades)!" + resultQ.getObject(entry.getValue().toString()) + " | " + datoPlano);
                    if (!resultQ.getObject(entry.getValue().toString()).toString().equals(datoPlano)) {
                        // --- Si no son iguales
                        //observacion(BD)
                        // ConsecutivoCoincidencia++;
                        gA_novedades(resultQ.getString("idusuario") + "," + CodigoCampo.get(Integer.parseInt(entry.getKey().toString())) + "," + fechaRegistro + "," + resultQ.getObject(entry.getValue().toString()) + "," + datoPlano + "," + " " + "," + usuarioSistema + "," + fechaRegistro + "," + encabezado + "," + "SVAL");
                    }


                    //System.out.println("Query " + resultQ.getObject(entry.getValue().toString()).toString());

                    contador++;
                }

            }

            st.close();
            resultQ.close();
            //con.cerrarConexion();
            //return true;
        } catch (SQLException e) {
            con.cerrarConexion();
            System.err.println("Error al consultar los campos de la tabla (comprobarCoincidencias()): " + e);
            //return false;
        }

    }

    void gA_novedades(String dato) {
        //System.out.println("gA_novedades " + dato);
        FileWriter fichero = null;
        PrintWriter pw = null;
        try {
            urlnovedadcampo = rutaTemporales + v.archivoRenombrar(nombreArchivo, "novedades");
            fichero = new FileWriter(urlnovedadcampo, true);
            pw = new PrintWriter(fichero);
            pw.println(dato);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                // Nuevamente aprovechamos el finally para
                // asegurarnos que se cierra el fichero.
                if (null != fichero) {
                    fichero.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }


    void insertCopyNovedades(String urlnovedadcampoG) {
        if (coincidencias) {
            try {
                PreparedStatement stmt;
                stmt = con.con.prepareStatement("COPY novedadcampo ( idusuario,codtiponovedad,codcampoarchivo,fecha,datoanterior,datoactualizado,observacion,ususiscodigo,fecharegistro,idencabezado,codestadoregistro) FROM '" + urlnovedadcampoG.replace(System.getProperty("file.separator"), "/") + "' WITH DELIMITER '" + "," + "'");
                stmt.execute();
                stmt.close();
            } catch (SQLException e) {
                System.out.println("generarNovedades=>insertCopyNovedades() Error " + e);
                e.printStackTrace();
                System.gc();
            }
        }
    }

    void queryCriterio(){
        PreparedStatement prepararQ = null;
        ResultSet resultQ = null;
        //System.out.println( "SELECT codcampoarchivo , nombrecampotabla FROM listacamposarchivo WHERE "+criterioSeleccionado+" = 1 " );

        try {
            con.abrirConexion();
            prepararQ = con.con.prepareStatement("SELECT codcampoarchivo , nombrecampotabla FROM listacamposarchivo WHERE "+criterioSeleccionado+" = 1 ");
            resultQ = prepararQ.executeQuery();
            while (resultQ.next()){
               // System.out.println( "Valores del mapa: " + resultQ.getString(2)  );

                columCriterios.put(resultQ.getString(2), resultQ.getInt(1));
            }
           // System.out.println("columCriterios Size " + columCriterios.size());
            prepararQ.close();
            resultQ.close();
            //con.cerrarConexion();

        } catch (SQLException e) {
            con.cerrarConexion();
            System.err.println("generarNovedades => queryCriterio() Error: " + e);
        }

    }
}
