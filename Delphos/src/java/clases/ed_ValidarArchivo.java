package clases;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Scanner;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import poblacion.ComunProcesos;
import java.sql.Timestamp;

public class ed_ValidarArchivo {

    //** Instancia de la Clase que devuelve el codigo del campo listacampoarchivo**/
    ComunProcesos idCampo = new ComunProcesos();
    //**Instancia la Clase encargada de la Validacion de los campos (E.R)**//
    ed_ValidacionCampos v;
    //**Instancia la Clase encargada de comprimir/descomprimir archivos**//
    edZip zip;
    HashMap<Integer, String> TipoDatoCampo = new HashMap<Integer, String>();
    HashMap<String, String> TipoDatoCampoCV = new HashMap<String, String>();
    HashMap<Integer, Integer> LongitudRegistro = new HashMap<Integer, Integer>();
    HashMap<Integer, Double> CodigoCampo = new HashMap<Integer, Double>();
    HashMap<String, Integer> ColumSeleccionadas = new HashMap<String, Integer>();
    HashMap<Integer, Integer> longitudCamposTablas = new HashMap<Integer, Integer>();
    /**Ruta Absoluta del Archivo que se esta analizando*/
    String urlArchivo;
    /**Nombre + extension del archivo que se estará validando*/
    String nombreArchivo;
    /** Ruta del Archivo */
    String rutaArchivo;
    /** Entero que contiene el codigo del Encabezado */
    int codEncabezado;
    /** valuesInconsistencias almacenará el VALUES  de la inserccion que se hara a la tabla inconarchafil**/
    StringBuffer valuesInconsistencias = new StringBuffer("");
    String usuario;
    String fechaRegis;
    Timestamp fechaRegistro = new Timestamp(System.currentTimeMillis());
    String tipo;
    /** ruta completa del archivo de Logs generado  */
    static String urlLogInconsistencias = "";
    /** ruta completa del archivo de inconsistencias  */
    static String urlDatosInconsistentes = "";
    static String urlPoblacionPeriodica = "";
    static String urlInconsistencias = "";
    /**En este String se almacena la Ruta donde se va a trabajar la validacion de archivos
    y donde se guardaran y obtendran los datos/archivos del proceso de validacion*/
    static String urlTmp;
    String rutaTemporales;
    String separador;
    String nombreTabla = "";
    String tipoCarga = null;
    String PrefijoRips = null;
    int contadorRips = 1;
    int encabezadoRips;
    int CantidadColumnas;
    int cantidadColumEstructaTotal;
    //tmp
    String lineaCopyInvalida;
    private int columIdentificacion;
    private int columTipoIdentificacion;

    public void validar(String estructuraColumnas, String rutaArchivo, String nombreArchivo, String codigoRegimen, int codEncabezado, String usuario, String columnasSeleccionadas, String separador, String tipo, String tipoCarga, int nColumnas) {
        //System.out.println("ENTRA CONSTRUCTOR");

        v = new ed_ValidacionCampos();
        zip = new edZip();

        this.urlArchivo = rutaArchivo + nombreArchivo;
        this.nombreArchivo = nombreArchivo;
        this.rutaArchivo = rutaArchivo;
        this.codEncabezado = codEncabezado;
        encabezadoRips = codEncabezado;
        this.usuario = usuario;
        this.fechaRegis = new Timestamp(System.currentTimeMillis()).toString();
        this.separador = separador;
        this.tipoCarga = tipoCarga;
        setUrlTmp(rutaArchivo);


        //CargarPoblacion - CargarRips
        System.out.println("Tipo de Carga : *****************>> " + tipoCarga);


        this.tipo = tipo;

        this.cantidadColumEstructaTotal = nColumnas;

        System.out.println(" cantidadColumEstructaTotal " + cantidadColumEstructaTotal);

        rutaTemporales = setCarpetaTrabajo(rutaArchivo);

//        if (encabezadoRips != codEncabezado){
//            contadorRips = 1;
//            System.out.println("nuevo Encabezado | Antes "+encabezadoRips + " Nuevo "  + codEncabezado);
//        }

        if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
            PrefijoRips = v.getPrefijoRips(nombreArchivo);
            contadorRips = getConsecutivoRips();
        }

        System.out.println("estructuraColumnas " + estructuraColumnas + " --  columnasSeleccionadas " + columnasSeleccionadas);
        //System.out.println("Codigo Encabezado " + codEncabezado);

        try {
            getInformacionBD(estructuraColumnas, codigoRegimen, columnasSeleccionadas);
        } catch (SQLException e) {
            System.out.println("Error : getInformacionBD() " + e.getMessage());
        }
        //UtilidadesDKDA.Lectura1(urlArchivo);

        lineaCopyInvalida = lineaCopyInvalida(estructuraColumnas);
        //System.out.println("El Mapa es " + lineaCopyInvalida);

        longitudCamposTablas(tipoCarga, estructuraColumnas, columnasSeleccionadas);
        LeerArchivo(urlArchivo);
        //zip.edZip();

        //ruta();



    }

    void LeerArchivo(String rutaArchivo) {
        //System.out.println("RUTA ARCHIVO :  " + rutaArchivo);

//        System.out.println(new java.io.OutputStreamWriter(System.out).getEncoding());
//        System.out.println(System.getProperty("file.encoding"));
//        System.setProperty("file.encoding", "UTF8");
//        System.out.println(new java.io.OutputStreamWriter(System.out).getEncoding());
//        System.out.println(System.getProperty("file.encoding"));
        File f = new File(rutaArchivo); //"e:/texto.txt"

        int columPromedio = calcularColumPromedio(rutaArchivo, ColumSeleccionadas.size(), cantidadColumEstructaTotal);

        FileReader fr = null;
        BufferedReader br = null;


        //Scanner s;
        int contadorLinea = 0;
        int contadorColumna = 0;

        int validoLongitud = 0;
        int validoTipoDato = 0;

        //Nombre del Campo de la listacamposarchivo(BD)
        String nombreCampo = "";
        //Almanace el codigo del error dado por la funcion en postgres
        String codErrorBD = "";
        //Almacena el valor que se estara analizando (datos individual)
        String valor = "";
        //System.out.println( (int) Math.floor( idCampo.obtenerCodCampoArchivo("fechaafilsissegsoc") )  );


        try {
            fr = new FileReader(f);
            br = new BufferedReader(fr);


            System.out.println("fr.getEncoding() " + fr.getEncoding());

            String linea;

            while ((linea = br.readLine()) != null) {
                if (linea.length() == 0) {
                    continue;
                }
                //  lineaA = 0;

                /**
                 *  Controlar los espacios en Blanco
                 *  al inicio o final del separador. 22/07/2011
                 */
                if (!linea.trim().equals("") && linea.substring(0, 1).equals(separador)) {

                    //    System.out.println("1.Caracter Vacio");
                    linea = " " + linea;
                }
                if (!linea.trim().equals("") && linea.substring(linea.length() - 1).equals(separador)) {
                    //    System.out.println("2.Caracter Vacio");
                    linea = linea + " ";
                }
                String[] lineaA = linea.split(separador, -1);


                /* -_- */




                contadorLinea++;


                // Validar : Estructura erronea por tener Menos Campos


                // System.out.println("columPromedio : " + columPromedio + " | ColumSeleccionadas.size() : " + ColumSeleccionadas.size() + " | lineaA.length : " + lineaA.length);
                // if (cantidadColumEstructaTotal < lineaA.length) ///if ((ColumSeleccionadas.size() == cantidadColumEstructaTotal && lineaA.length < cantidadColumEstructaTotal) && !linea.trim().equals("")) {
                //  {
                //if (lineaA.length < columPromedio && !linea.trim().equals("")) {
                if (((columPromedio < ColumSeleccionadas.size()) || lineaA.length < ColumSeleccionadas.size()) && !linea.trim().equals("")) {
                    // A plano inconsistencias
                    generarArchivo_datosInconsistencias(linea);
                    // a Plano detalle inconsistencias
                    generarArchivo_desInconsistencias("ERR-10 | ERROR: Estructura archivo mas pequena que la esperada | Registro No: " + contadorLinea);

                    if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                        setValuesInconsistencias(contadorLinea, 2199, "ERR-10", PrefijoRips, "2");
                    } else {
                        setValuesInconsistencias(contadorLinea, 2199, "ERR-10");

                        //CantidadColumnas;
                        generarPoblacionPeriodica(codEncabezado, contadorLinea, lineaCopyInvalida, separador);

                    }

                    //System.out.println("Linea No Apta - out!!!");
                    //System.out.println(linea);
                    linea = "";
                }
                //}

                // Validar : Estructura erronea por tener MAS Campos

                //if ((ColumSeleccionadas.size() == cantidadColumEstructaTotal && lineaA.length > cantidadColumEstructaTotal) && !linea.trim().equals("")) {     
                if (lineaA.length > columPromedio && !linea.trim().equals("")) {
                    // A plano inconsistencias
                    generarArchivo_datosInconsistencias(linea);
                    // a Plano detalle inconsistencias
                    generarArchivo_desInconsistencias("ERR-09 | ERROR: Estructura archivo mas grande que la esperada | Registro No: " + contadorLinea);


                    if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                        setValuesInconsistencias(contadorLinea, 2199, "ERR-09", PrefijoRips, "1");
                    } else {
                        setValuesInconsistencias(contadorLinea, 2199, "ERR-09");
                        generarPoblacionPeriodica(codEncabezado, contadorLinea, lineaCopyInvalida, separador);
                    }
                    //System.out.println("Linea No Apta - out!!!");
                    //System.out.println(linea);
                    linea = "";
                }

                if (!linea.trim().equals("")) {
                    // System.out.println("Linea Vacia: " + contadorLinea);

                    // Almacena linea a linea
                    StringBuilder lineaPoblacion = new StringBuilder("");

                    Scanner sl = new Scanner(linea);
                    //sl.useDelimiter("\\s*" + separador + "\\s*");
                    sl.useDelimiter(separador);
                    //System.out.println("Linea Numero " + contadorLinea);
                    while (sl.hasNext()) {
                        valor = sl.next();
                        // No borrar esta linea, si obtiene algun error al consultar longitudes continua con el siguiente rip y no saca problemas


                        //System.out.println( "CONSTAINSSSS: " + ColumSeleccionadas.containsValue(contadorColumna) );
                        if (ColumSeleccionadas.containsValue(contadorColumna)) {

                            /**
                             * Asignar valores por defecto cuando en la posicion 
                             * de identificacion y tipo vengan sin dato.
                             */
                            if (valor.length() == 0 && contadorColumna == columIdentificacion) {
                                int n = (int) (Math.random() * 1999999999);
                                valor = String.valueOf(n);
                                // System.out.println(contadorColumna + " Calculando Random!" + contadorColumna + " - " + columIdentificacion + " Valor " + valor);
                            }
                            if (valor.equals(" ") && contadorColumna == columTipoIdentificacion) {
                                valor = "AS";

                                // System.out.println("Identificacion!! " + contadorColumna + " | " + columTipoIdentificacion + " | " + contadorLinea);
                            }

                            /* -_- */





                            //System.out.println("Valor " + valor + " ||| Longitud " + valor.length() + " <|> " + longitudCamposTablas.get(contadorColumna) );



                            if (valor.length() > longitudCamposTablas.get(contadorColumna)) {
                                // System.out.println("Valor Muy largo!! | Esperado " + longitudCamposTablas.get(contadorColumna));

                                // A plano inconsistencias
                                generarArchivo_datosInconsistencias(linea);
                                // a Plano detalle inconsistencias
                                generarArchivo_desInconsistencias("ERR-11 | ERROR: Longitud para BD Invalido | Long Campo: " + valor.length() + " Long en BD : " + longitudCamposTablas.get(contadorColumna) + " | Registro No: " + contadorLinea + " Columna: " + (contadorColumna + 1) + "| Dato :  " + valor);

                                // a Copy Plano Inconsistencias
                                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                                    // setValuesInconsistencias(contadorLinea, 2199, "ERR-09", PrefijoRips, "1");
                                    setValuesInconsistencias(contadorLinea, CodigoCampo.get(contadorColumna), "ERR-10", PrefijoRips, "4");
                                } else {
                                    setValuesInconsistencias(contadorLinea, CodigoCampo.get(contadorColumna), "ERR-10");
                                    //generarPoblacionPeriodica(codEncabezado, contadorLinea, lineaCopyInvalida, separador);
                                }




                                valor = valor.substring(0, longitudCamposTablas.get(contadorColumna));

                                //System.out.println("Valor Asignado para este caso : " + valor);
                            }

                            if (valor.length() == 0 && (TipoDatoCampo.get(contadorColumna).equals("decimal") || TipoDatoCampo.get(contadorColumna).equals("Numeric"))) {
                                valor = "0";
                            }
                            if (valor.toUpperCase().equals("NULL") && (TipoDatoCampo.get(contadorColumna).equals("decimal") || TipoDatoCampo.get(contadorColumna).equals("Numeric"))) {
                                valor = "0";
                            }

                            if (!valor.equals("0") && (TipoDatoCampo.get(contadorColumna).equals("decimal") || TipoDatoCampo.get(contadorColumna).equals("Numeric"))) {
                                if (!v.numDecimal(valor) || valor.endsWith(".")) {
                                    // A plano inconsistencias
                                    generarArchivo_datosInconsistencias(linea);
                                    // a Plano detalle inconsistencias
                                    generarArchivo_desInconsistencias("ERR-03 | ERROR: Caracter invalido en un numero | Registro No: " + contadorLinea + " Columna: " + (contadorColumna + 1) + "| Dato :  " + valor);

                                    // a Copy Plano Inconsistencias
                                    if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                                        setValuesInconsistencias(contadorLinea, CodigoCampo.get(contadorColumna), "ERR-03", PrefijoRips, "4");
                                    } else {
                                        setValuesInconsistencias(contadorLinea, CodigoCampo.get(contadorColumna), "ERR-03");
                                    }
                                    valor = "0";
                                }
                            }



                            //Si Los numeros tiene Notacion Cientifica!
                            if ((TipoDatoCampo.get(contadorColumna).equals("decimal") || TipoDatoCampo.get(contadorColumna).equals("Numeric")) && valor.toUpperCase().contains("E")) {

                                // A plano inconsistencias
                                generarArchivo_datosInconsistencias(linea);
                                // a Plano detalle inconsistencias
                                generarArchivo_desInconsistencias("ERR-12 | ERROR: Notación Cientifica no permitida en Campos Numericos | Registro No: " + contadorLinea + " Columna: " + (contadorColumna + 1) + "| Dato :  " + valor);

                                // a Copy Plano Inconsistencias
                                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                                    // setValuesInconsistencias(contadorLinea, 2199, "ERR-09", PrefijoRips, "1");
                                    setValuesInconsistencias(contadorLinea, CodigoCampo.get(contadorColumna), "ERR-12", PrefijoRips, "4");
                                } else {
                                    setValuesInconsistencias(contadorLinea, CodigoCampo.get(contadorColumna), "ERR-12");
                                    //generarPoblacionPeriodica(codEncabezado, contadorLinea, lineaCopyInvalida, separador);
                                }
                                valor = "0";
                            }

                            if (valor.toUpperCase().equals("NULL") && (TipoDatoCampo.get(contadorColumna).equals("character") || TipoDatoCampo.get(contadorColumna).equals("varchar") || TipoDatoCampo.get(contadorColumna).equals("alfanumerico"))) {
                                valor = "";
                            }

                            //Validar Hora si viene vacia .. incluirla
                            if ((valor.equals(" ") || valor.length() == 0) && (TipoDatoCampo.get(contadorColumna).equals("hora"))) {
                                valor = "00:00";
                            }
                            if ((valor.equals("") || valor.length() == 0) && (TipoDatoCampo.get(contadorColumna).equals("hora"))) {
                                valor = "00:00";
                            }

                            if ((TipoDatoCampo.get(contadorColumna).equals("hora")) && (!v.hora(valor))) {
                                // A plano inconsistencias
                                generarArchivo_datosInconsistencias(linea);
                                // a Plano detalle inconsistencias
                                generarArchivo_desInconsistencias("ERR-13 | ERROR: Hora invalida | Registro No: " + contadorLinea + " Columna: " + (contadorColumna + 1) + "| Dato :  " + valor);

                                // a Copy Plano Inconsistencias
                                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                                    // setValuesInconsistencias(contadorLinea, 2199, "ERR-09", PrefijoRips, "1");
                                    setValuesInconsistencias(contadorLinea, CodigoCampo.get(contadorColumna), "ERR-13", PrefijoRips, "4");
                                } else {
                                    setValuesInconsistencias(contadorLinea, CodigoCampo.get(contadorColumna), "ERR-13");
                                    //generarPoblacionPeriodica(codEncabezado, contadorLinea, lineaCopyInvalida, separador);
                                }

                                valor = "00:00";
                            }

                            if ((valor.trim().length() < 5) && (TipoDatoCampo.get(contadorColumna).equals("hora"))) {
                                // A plano inconsistencias
                                generarArchivo_datosInconsistencias(linea);
                                // a Plano detalle inconsistencias
                                generarArchivo_desInconsistencias("ERR-13 | ERROR: Hora incompleta | Registro No: " + contadorLinea + " Columna: " + (contadorColumna + 1) + "| Dato :  " + valor);

                                // a Copy Plano Inconsistencias
                                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                                    // setValuesInconsistencias(contadorLinea, 2199, "ERR-09", PrefijoRips, "1");
                                    setValuesInconsistencias(contadorLinea, CodigoCampo.get(contadorColumna), "ERR-13", PrefijoRips, "4");
                                } else {
                                    setValuesInconsistencias(contadorLinea, CodigoCampo.get(contadorColumna), "ERR-13");
                                    //generarPoblacionPeriodica(codEncabezado, contadorLinea, lineaCopyInvalida, separador);
                                }

                                valor = UtilidadesDKDA.ed_completar(valor, "00:00");
                            }


                            //System.out.println( "TipoDatoCampo.get(contadorColumna) " + TipoDatoCampo.get(contadorColumna) );

                            if (valor.length() > 0 && (TipoDatoCampo.get(contadorColumna).equals("timestamp without time zone") || TipoDatoCampo.get(contadorColumna).equals("fecha"))) {
                                String[] solofecha = valor.split(" ");
                                valor = solofecha[0];

                                //Si se presenta el caso 12/13/2008 por el datastyle de la bd
                                if(v.fecha_MDA(valor)){
                                     // A plano inconsistencias
                                    generarArchivo_datosInconsistencias(linea);
                                    // a Plano detalle inconsistencias
                                    generarArchivo_desInconsistencias("ERR-15 | ERROR: Formato de Fecha Invalido | Registro No: " + contadorLinea + " Columna: " + (contadorColumna + 1) + "| Dato :  " + valor);

                                    // a Copy Plano Inconsistencias
                                    if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                                        setValuesInconsistencias(contadorLinea, CodigoCampo.get(contadorColumna), "ERR-15", PrefijoRips, "4");
                                    } else {
                                        setValuesInconsistencias(contadorLinea, CodigoCampo.get(contadorColumna), "ERR-15");
                                    }
                                    valor = "1900-01-01";
                                }

                                if (!v.fecha_AMD(valor) && !v.fecha_DMA(valor) && !v.fecha_MDA(valor)) {
                                    // A plano inconsistencias
                                    generarArchivo_datosInconsistencias(linea);
                                    // a Plano detalle inconsistencias
                                    generarArchivo_desInconsistencias("ERR-05 | ERROR: Caracter invalido en una fecha | Registro No: " + contadorLinea + " Columna: " + (contadorColumna + 1) + "| Dato :  " + valor);

                                    // a Copy Plano Inconsistencias
                                    if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                                        setValuesInconsistencias(contadorLinea, CodigoCampo.get(contadorColumna), "ERR-05", PrefijoRips, "4");
                                    } else {
                                        setValuesInconsistencias(contadorLinea, CodigoCampo.get(contadorColumna), "ERR-05");
                                    }
                                    valor = "1900-01-01";
                                }


                            }

                            if ((valor.equals(" ") || valor.length() == 0) && (TipoDatoCampo.get(contadorColumna).equals("timestamp without time zone") || TipoDatoCampo.get(contadorColumna).equals("fecha"))) {

                                valor = "1900-01-01";
                                //System.out.println(" Valor : " + valor + " ! " + contadorColumna);
                            }

                            if ((valor.equals("") || valor.length() == 0) && (TipoDatoCampo.get(contadorColumna).equals("timestamp without time zone") || TipoDatoCampo.get(contadorColumna).equals("fecha"))) {
                                valor = "1900-01-01";
                                //System.out.println(" Valor : " + valor + " ! " + contadorColumna);
                            }
                            if ((valor.equals("NULL") || valor.length() == 0) && (TipoDatoCampo.get(contadorColumna).equals("timestamp without time zone") || TipoDatoCampo.get(contadorColumna).equals("fecha"))) {

                                valor = "1900-01-01";
                                //System.out.println(" Valor : " + valor + " ! " + contadorColumna);
                            }







                            validoLongitud += vLongitudCampo(valor.length(), contadorColumna, contadorLinea, valor);
                            validoTipoDato += vContenidoCampo(valor, contadorColumna, contadorLinea);
                            lineaPoblacion.append(valor).append(separador);
                        }

                        contadorColumna++;

                    }




                    if ((validoLongitud < ColumSeleccionadas.size()) || (validoTipoDato > 0)) {
                        generarArchivo_datosInconsistencias(linea);
                    } else {

                        if (tipoCarga.equals("CargarPoblacion")) {
                            generarArchivo_correcto(linea);
                        }

                    }

                    //System.out.println( codEncabezado + " " +  contadorLinea + " " + lineaPoblacion.substring(0, lineaPoblacion.length() - 1) + " " + separador );
//                  System.out.println("** Datos Validos **" + lineaPoblacion.substring(0,lineaPoblacion.length()-1));
                    generarPoblacionPeriodica(codEncabezado, contadorLinea, lineaPoblacion.substring(0, lineaPoblacion.length() - 1).replace("\\", ""), separador);
                    contadorColumna = 0;
                    validoLongitud = 0;
                    validoTipoDato = 0;
                    // Eliminamos el contenido cuando se termine de analizar el archivo para liberar recursos.
                    lineaPoblacion.delete(0, lineaPoblacion.length() - 1);

                }
            }
            //Almacenar consecutivo Carga Rips !Solo Rips
            if (PrefijoRips != null) {
                //System.out.println("Consecutivo Rips ! " + contadorRips);
                generarConsecutivo(String.valueOf(contadorRips));
            }

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

    int vLongitudCampo(int tamanocampo, int NoColumna, int NoLinea, String Valor) throws SQLException {

        /** Tabla de Codigos de Error tipoincarchivo*/
        int validador = 0;
        if (tamanocampo <= LongitudRegistro.get(NoColumna)) {
            validador += 1;
        } else {
            // System.err.println("inValido | Linea " + NoLinea + " Columna " + NoColumna + " Tama?o" + tamanocampo + " Valor:  " + Valor);

            generarArchivo_desInconsistencias("ERR-06 | ERROR: Longitud del campo invalida | Long Campo: " + tamanocampo + " Long Esperada: " + LongitudRegistro.get(NoColumna) + " | Registro No: " + NoLinea + " Columna: " + (NoColumna + 1) + "| Dato :  " + Valor);

            if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-06", PrefijoRips, "4");
            } else {
                setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-06");
            }

            //generarArchivo_desInconsistencias("Error ERR-06 | Linea " + NoLinea + " Columna " + (NoColumna + 1) + " Long Campo " + tamanocampo +  " Long Esperada " + LongitudRegistro.get(NoColumna) + " Valor :  " + Valor);
            // System.err.println(NoColumna);
            // temp(NoLinea, CodigoCampo.get(NoColumna), "ERR-06");

        }
        //System.out.println("vLongitudCampo " + validador);
        return validador;

    }

    int vContenidoCampo(String dato, int NoColumna, int NoLinea) {

        int numErrores = 0;


        /**
         * bd 30/06/2011
         * SELECT * FROM tipoincarchivo;
         * SELECT DISTINCT tipodato FROM estructuraarchivo
         * 
         * character
         * Numeric
         * varchar
         * hora
         * Numerc
         * fecha
         * decimal
         * Fecha
        
         */
        // char  - num  - dat - toz - chr
        // *** Caracter                         --tex
        if (TipoDatoCampo.get(NoColumna).equals("character")) {
            if (!v.caracteres(dato) && dato.length() > 0) {
                generarArchivo_desInconsistencias("ERR-01 | ERROR: Campo permite solo caracteres(a-z) | " + " Linea: " + NoLinea + " Columna: " + (NoColumna + 1) + " |Dato: " + dato);
                //System.out.println("Error en dato " + dato + "Linea REgistro " + NoLinea);
                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-01", PrefijoRips, "4");
                } else {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-01");
                }

                numErrores += 1;
            }
        }

        // *** Numerico                         --int
        if (TipoDatoCampo.get(NoColumna).equals("Numeric")) {
            if (!v.numeros(dato) && dato.length() > 0) {
                generarArchivo_desInconsistencias("ERR-02 | ERROR: Campo permite solo numeros(0-9) | " + " Linea: " + NoLinea + " Columna: " + (NoColumna + 1) + " |Dato: " + dato);
                // System.out.println("Error en dato " + dato + "Linea REgistro " + NoLinea);
                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-01", PrefijoRips, "4");
                } else {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-01");
                }

                numErrores += 1;
            }
        }



        // *** Alfanumericos                         --varchar                       
        if (TipoDatoCampo.get(NoColumna).equals("varchar")) {
            if (!v.alfaNumericos(dato) && dato.length() > 0) {
                generarArchivo_desInconsistencias("ERR-08 | ERROR: Campo permite Caracteres Alfanumericos(0-9 / A - Z) | " + " Linea: " + NoLinea + " Columna: " + (NoColumna + 1) + " |Dato: " + dato);
                // System.out.println("Error en dato " + dato + "Linea REgistro " + NoLinea);
                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-08", PrefijoRips, "4");
                } else {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-08");
                }

                numErrores += 1;
            }
        }

        // Provicional 
        if (TipoDatoCampo.get(NoColumna).equals("Provicional")) {
            if (!v.numeros(dato) && dato.length() > 0) {
                generarArchivo_desInconsistencias("ERR-02 | ERROR: Campo permite solo numeros(0-9) | " + " Linea: " + NoLinea + " Columna: " + (NoColumna + 1) + " |Dato: " + dato);
                // System.out.println("Error en dato " + dato + "Linea REgistro " + NoLinea);
                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-01", PrefijoRips, "4");
                } else {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-01");
                }

                numErrores += 1;
            }

            if (dato.length() > 0) {
            }
        }

        // *** Date (Fecha)
        if (TipoDatoCampo.get(NoColumna).equals("Fecha")) {
//            if (!v.numeros(dato) && dato.length() > 0) {
//                generarArchivo_desInconsistencias("ERR-04 | ERROR: Fecha Invalida | " + " Linea: " + NoLinea + " Columna: " + (NoColumna + 1) + " |Dato: " + dato);
//                // System.out.println("Error en dato " + dato + "Linea REgistro " + NoLinea);
//                setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna - 1), "ERR-01");
//                numErrores += 1;
//            }
        }

        // *** toz (timestamp without time zone) Fecha
        if (TipoDatoCampo.get(NoColumna).equals("timestamp without time zone")) {
//            if (!v.numeros(dato) && dato.length() > 0) {
//                generarArchivo_desInconsistencias("ERR-05 | ERROR: Fecha Invalida | " + " Linea: " + NoLinea + " Columna: " + (NoColumna + 1) + " |Dato: " + dato);
//                //System.out.println("Error en dato " + dato + "Linea REgistro " + NoLinea);
//                setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna - 1), "ERR-01");
//                numErrores += 1;
//            } 
        }


        if (TipoDatoCampo.get(NoColumna).equals("CDpEGGbLPPorPcPuS")) {
            if (!v.CDpEGGbLPPorPcPuS(dato) && dato.length() > 0) {
                generarArchivo_desInconsistencias("ERR-14 | ERROR: ERROR: Caracter no valido para este campo | " + " Linea: " + NoLinea + " Columna: " + (NoColumna + 1) + " |Dato: " + dato);
                // System.out.println("Error en dato " + dato + "Linea REgistro " + NoLinea);
                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-14", PrefijoRips, "4");
                } else {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-14");
                }

                numErrores += 1;
            }
        }


        if (TipoDatoCampo.get(NoColumna).equals("CDpEGGbLPPcPuS")) {
            if (!v.CDpEGGbLPPcPuS(dato) && dato.length() > 0) {
                generarArchivo_desInconsistencias("ERR-14 | ERROR: ERROR: Caracter no valido para este campo | " + " Linea: " + NoLinea + " Columna: " + (NoColumna + 1) + " |Dato: " + dato);
                // System.out.println("Error en dato " + dato + "Linea REgistro " + NoLinea);
                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-14", PrefijoRips, "4");
                } else {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-14");
                }

                numErrores += 1;
            }
        }


        if (TipoDatoCampo.get(NoColumna).equals("CEGGbLPPcPuS")) {
            if (!v.CEGGbLPPcPuS(dato) && dato.length() > 0) {
                generarArchivo_desInconsistencias("ERR-14 | ERROR: ERROR: Caracter no valido para este campo | " + " Linea: " + NoLinea + " Columna: " + (NoColumna + 1) + " |Dato: " + dato);
                // System.out.println("Error en dato " + dato + "Linea REgistro " + NoLinea);
                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-14", PrefijoRips, "4");
                } else {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-14");
                }

                numErrores += 1;
            }
        }


        if (TipoDatoCampo.get(NoColumna).equals("CEGGbLPPuS")) {
            if (!v.CEGGbLPPuS(dato) && dato.length() > 0) {
                generarArchivo_desInconsistencias("ERR-14 | ERROR: ERROR: Caracter no valido para este campo | " + " Linea: " + NoLinea + " Columna: " + (NoColumna + 1) + " |Dato: " + dato);
                // System.out.println("Error en dato " + dato + "Linea REgistro " + NoLinea);
                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-14", PrefijoRips, "4");
                } else {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-14");
                }

                numErrores += 1;
            }
        }


        if (TipoDatoCampo.get(NoColumna).equals("GS")) {
            if (!v.GS(dato) && dato.length() > 0) {
                generarArchivo_desInconsistencias("ERR-14 | ERROR: ERROR: Caracter no valido para este campo | " + " Linea: " + NoLinea + " Columna: " + (NoColumna + 1) + " |Dato: " + dato);
                // System.out.println("Error en dato " + dato + "Linea REgistro " + NoLinea);
                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-14", PrefijoRips, "4");
                } else {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-14");
                }

                numErrores += 1;
            }
        }


        if (TipoDatoCampo.get(NoColumna).equals("EG")) {
            if (!v.EG(dato) && dato.length() > 0) {
                generarArchivo_desInconsistencias("ERR-14 | ERROR: ERROR: Caracter no valido para este campo | " + " Linea: " + NoLinea + " Columna: " + (NoColumna + 1) + " |Dato: " + dato);
                // System.out.println("Error en dato " + dato + "Linea REgistro " + NoLinea);
                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-14", PrefijoRips, "4");
                } else {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-14");
                }

                numErrores += 1;
            }
        }


        if (TipoDatoCampo.get(NoColumna).equals("G")) {
            if (!v.G(dato) && dato.length() > 0) {
                generarArchivo_desInconsistencias("ERR-14 | ERROR: ERROR: Caracter no valido para este campo | " + " Linea: " + NoLinea + " Columna: " + (NoColumna + 1) + " |Dato: " + dato);
                // System.out.println("Error en dato " + dato + "Linea REgistro " + NoLinea);
                if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-14", PrefijoRips, "4");
                } else {
                    setValuesInconsistencias(NoLinea, CodigoCampo.get(NoColumna), "ERR-14");
                }

                numErrores += 1;
            }
        }




        return numErrores;
    }

    void vContenidoEsperado() {
    }

    //tener en cuenta BufferedReader, BufferedInputStream, BufferedWriter y BufferedOutputStream
    //http://chuwiki.chuidiang.org/index.php?title=Lectura_y_Escritura_de_Ficheros_en_Java
    void generarArchivo_desInconsistencias(String error) {
        FileWriter fichero = null;
        PrintWriter pw = null;
        try {
            urlLogInconsistencias = rutaTemporales + v.archivoRenombrar(nombreArchivo, "descInconsistencias");
            fichero = new FileWriter(rutaTemporales + v.archivoRenombrar(nombreArchivo, "descInconsistencias"), true);
            pw = new PrintWriter(fichero);
            pw.println(error);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                /*Nuevamente aprovechamos el finally para
                // asegurarnos que se cierra el fichero.*/
                if (null != fichero) {
                    fichero.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }

    void generarArchivo_datosInconsistencias(String error) {
        FileWriter fichero = null;
        PrintWriter pw = null;
        try {
            urlDatosInconsistentes = rutaTemporales + v.archivoRenombrar(nombreArchivo, "datosInconsistentes");
            fichero = new FileWriter(rutaTemporales + v.archivoRenombrar(nombreArchivo, "datosInconsistentes"), true);
            pw = new PrintWriter(fichero);
            pw.println(error);
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

    void generarArchivo_correcto(String dato) {
        FileWriter fichero = null;
        PrintWriter pw = null;
        try {
            fichero = new FileWriter(rutaTemporales + v.archivoRenombrar(nombreArchivo, "Validos"), true);
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

    void generarConsecutivo(String dato) {
        FileWriter fichero = null;
        PrintWriter pw = null;
        try { //= new File(rutaTemporales + "Consecutivo.txt");
            fichero = new FileWriter(rutaTemporales + "Consecutivo.txt", false);
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

    void generarPoblacionPeriodica(Integer id, Integer Consecutivo, String datos, String delimitador) {
        FileWriter fichero = null;
        PrintWriter pw = null;
        try {
            urlPoblacionPeriodica = rutaTemporales + v.archivoRenombrar(nombreArchivo, "copy");
            fichero = new FileWriter(rutaTemporales + v.archivoRenombrar(nombreArchivo, "copy"), true);
            pw = new PrintWriter(fichero);

            //System.out.println("PrefijoRips " + PrefijoRips);


            if (tipoCarga.equals("CargarRips") || tipoCarga.equals("CargarRipsEAPB")) {
                if ((!PrefijoRips.equals("US") && !PrefijoRips.equals("AF"))) {
                    pw.println(id + delimitador + contadorRips++ + delimitador + PrefijoRips + delimitador + datos);
                    // System.out.println("Contador para Rips " + contadorRips);

                } else {
                    contadorRips = 1;
                    pw.println(id + delimitador + Consecutivo + delimitador + datos);

                }
            }
            if (tipoCarga.equals("CargarPoblacion")) {
                pw.println(id + delimitador + Consecutivo + delimitador + datos);
            }



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
                //e2.printStackTrace();
                System.out.println("E2 Error " + e2);
            }
        }
    }

    void generarInconsistencias(String error) {
        FileWriter fichero = null;
        PrintWriter pw = null;
        try {
            urlInconsistencias = rutaTemporales + v.archivoRenombrar(nombreArchivo, "Inconsistencias");
            fichero = new FileWriter(rutaTemporales + v.archivoRenombrar(nombreArchivo, "Inconsistencias"), true);
            pw = new PrintWriter(fichero);

            pw.println(error);

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

    void eliminarArchivoTMP() {
    }

//    public void getInformacionBDtmp(String estructuraColumnas, String codRegimen) throws SQLException {
//
//        //temp();
//        ColumnaArchivo = estructuraColumnas.split(",");
//        String codigoEstructuraArchivo = "";
//
//        PreparedStatement pstmt = null;
//        ResultSet resultQuery = null;
//
//        ConexionBaseDatos con;
//        con = new ConexionBaseDatos();
//
//
//        try {
//            con.abrirConexion();
//            //  System.out.println( "ColumnaArchivo.length " + ColumnaArchivo.length );
//
//            // Query para conocer el Codigo de la Estructura
//
//            pstmt = con.con.prepareStatement(" SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
//            // pstmt.setString(1, ColumnaArchivo[i]);
//            resultQuery = pstmt.executeQuery();
//            resultQuery.next();
//            codigoEstructuraArchivo = resultQuery.getString(1);
//
//
//            for (int i = 0; i < ColumnaArchivo.length; i++) {
//
//                CodigoCampo.put(i, idCampo.obtenerCodCampoArchivo(ColumnaArchivo[i], "poblacionperiodica"));
//
//                //Calcular Longitudes campo
//                pstmt = con.con.prepareStatement(" SELECT   ea.posicionfinal - ea.posicioninicial FROM estructuraarchivo ea , listacamposarchivo l WHERE ea.codtipoestrucarch= ? AND l.codcampoarchivo = ea.codcampoarchivo AND l.nombrecampotabla = ? ");
//                pstmt.setString(1, codigoEstructuraArchivo);
//                pstmt.setString(2, ColumnaArchivo[i]);
//                resultQuery = pstmt.executeQuery();
//                resultQuery.next();
//                //LongitudRegistro.put(i, resultQuery.getInt(1));
//                LongitudRegistro.put(ColumSeleccionadas.get(ColumnaArchivo[i]), resultQuery.getInt(1));
//                //System.out.println("Longitud Campo " + LongitudRegistro.get(i));
//
//                //Determinar tipo de dato
//                pstmt = con.con.prepareStatement(" SELECT tipodato FROM estructuraarchivo WHERE codcampoarchivo = ? ");
//                pstmt.setDouble(1, CodigoCampo.get(i));
//                resultQuery = pstmt.executeQuery();
//                resultQuery.next();
//                TipoDatoCampo.put(ColumSeleccionadas.get(ColumnaArchivo[i]), resultQuery.getString(1));
//                // System.out.println("Tipo de Dato" + TipoDatoCampo.get(i));
//
//
//                resultQuery.close();
//                pstmt.close();
//                // System.out.println( "ContenidoRegistro.size() " + ContenidoRegistro.size() );
//            }
//
//            con.cerrarConexion();
//        } catch (SQLException e) {
//            con.cerrarConexion();
//            System.err.println("Error al consultar los campos de la tabla: " + e);
//        } catch (Exception e) {
//            System.out.println("Error General " + e.getMessage());
//            e.printStackTrace();
//        }
//    }
    public void getInformacionBD(String estructuraColumnas, String codRegimen, String columnasSeleccionadas) throws SQLException {
        //System.out.println("Tipo de estructura: " + this.tipo  );
        estructColumnas(columnasSeleccionadas, estructuraColumnas);

        // ColumnaArchivo = estructuraColumnas.split(",");

        String codigoEstructuraArchivo = "";

        PreparedStatement pstmt = null;
        ResultSet resultQuery = null;

        Connection conexion = bdS.getConexion();




//        for ( int i = 0 ; i < ColumnaArchivo.length ; i++){
//            System.out.println("Valor ColumnaArchivo " + i + "  " + ColumnaArchivo[i] );
//        }




        try {

            //  System.out.println( "ColumnaArchivo.length " + ColumnaArchivo.length );

            // Query para conocer el Codigo de la Estructura

            pstmt = conexion.prepareStatement(" SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
            //System.out.println("1. SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
            resultQuery = pstmt.executeQuery();
            resultQuery.next();
            codigoEstructuraArchivo = resultQuery.getString(1);

            java.util.Set set = ColumSeleccionadas.entrySet();
            java.util.Iterator iter = set.iterator();
            while (iter.hasNext()) {
                java.util.Map.Entry entry = (java.util.Map.Entry) iter.next();
                //System.out.println(entry.getKey() + " -- " + entry.getValue());




                //Calcular Longitudes campo
                pstmt = conexion.prepareStatement(" SELECT   ea.posicionfinal - ea.posicioninicial , nombretabla FROM estructuraarchivo ea , listacamposarchivo l WHERE ea.codtipoestrucarch= ? AND l.codcampoarchivo = ea.codcampoarchivo AND l.nombrecampotabla = ? ");
                //System.out.println(" 2. SELECT   ea.posicionfinal - ea.posicioninicial , nombretabla FROM estructuraarchivo ea , listacamposarchivo l WHERE ea.codtipoestrucarch= "+String.valueOf( this.tipo )+ "  AND l.codcampoarchivo = ea.codcampoarchivo AND l.nombrecampotabla = "+entry.getKey().toString()+" ");
                pstmt.setString(1, String.valueOf(this.tipo));
                pstmt.setString(2, entry.getKey().toString());
                resultQuery = pstmt.executeQuery();
                resultQuery.next();
                //LongitudRegistro.put(i, resultQuery.getInt(1));
                LongitudRegistro.put(Integer.parseInt(entry.getValue().toString()), resultQuery.getInt(1) + 1);


                CodigoCampo.put(Integer.parseInt(entry.getValue().toString()), idCampo.obtenerCodCampoArchivo(entry.getKey().toString(), resultQuery.getString(2)));

                //  System.out.println("Longitud del registro: " + resultQuery.getInt(1)  );
                // System.out.println("Longitud Campo " + LongitudRegistro.get(Integer.parseInt(entry.getValue().toString())));

                //Determinar tipo de dato
                pstmt = conexion.prepareStatement(" SELECT tipodato FROM estructuraarchivo WHERE codcampoarchivo = ? ");
                //System.out.println(" 3.SELECT tipodato FROM estructuraarchivo WHERE codcampoarchivo =  " +  CodigoCampo.get(Integer.parseInt(entry.getValue().toString())));
                pstmt.setDouble(1, CodigoCampo.get(Integer.parseInt(entry.getValue().toString())));
                resultQuery = pstmt.executeQuery();
                resultQuery.next();
                TipoDatoCampo.put(Integer.parseInt(entry.getValue().toString()), resultQuery.getString(1));
                TipoDatoCampoCV.put(entry.getKey().toString(), resultQuery.getString(1));
                System.out.println(" Campo/Tipo : " + " (" + ((Integer.parseInt(entry.getValue().toString()) + 1)) + ") " + entry.getKey().toString() + " | " + resultQuery.getString(1));




                resultQuery.close();
                pstmt.close();
                // System.out.println( "ContenidoRegistro.size() " + ContenidoRegistro.size() );
            }

        } catch (SQLException e) {
            System.err.println("Error al consultar los campos de la tabla: " + e);
        } catch (Exception e) {
            System.out.println("Error General " + e.getMessage());
            e.printStackTrace();
        }
    }

    public String construirDatos(String Datos) {
        return Datos;
    }

    /**
     *
     * @param id_registro Numero de Linea del Registro
     * @param cod_campo Codigo del Campo
     * @param error Codigo del Error Producido
     */
    public void setValuesInconsistencias(Integer id_registro, double cod_campo, String error) {
        //valuesInconsistencias.append("(").append(id_registro).append(",'").append(cod_campo).append("',").append(codEncabezado).append(",'").append(error).append("','").append(error).append("','").append(usuario).append("','").append(fechaRegis).append("'" + ",'SIN VALIDAR'),");
        generarInconsistencias(id_registro + "," + cod_campo + "," + codEncabezado + "," + error + "," + error + "," + usuario + "," + fechaRegis + "," + "SV");
    }

    public void setValuesInconsistencias(Integer id_registro, double cod_campo, String error, String codRips, String tipoglosarip) {
        //valuesInconsistencias.append("(").append(id_registro).append(",'").append(cod_campo).append("',").append(codEncabezado).append(",'").append(error).append("','").append(error).append("','").append(usuario).append("','").append(fechaRegis).append("'" + ",'SIN VALIDAR'),");
        generarInconsistencias(id_registro + "," + cod_campo + "," + codEncabezado + "," + error + "," + usuario + "," + fechaRegis + "," + "SV" + "," + codRips + "," + tipoglosarip);
    }

    public String getValuesInconsistencias() {
        String QueryInconsistencias = valuesInconsistencias.toString();
        if (QueryInconsistencias.length() >= 1) {
            return QueryInconsistencias.substring(0, QueryInconsistencias.length() - 1);
        } else {
            return "";
        }

        //return valuesInconsistencias.toString().substring(0, valuesInconsistencias.length() - 1);
    }

    public void clearValuesInconsistencias() {
        valuesInconsistencias.delete(0, valuesInconsistencias.length());
        valuesInconsistencias = null;
        System.out.println("valor de values novi" + valuesInconsistencias);
    }

    void estructColumnas(String numeroColum, String estructuraColum) {

        System.out.println("estructuraColum " + estructuraColum);
        /** Almance la Estructura de las Columnas del Archivo Seleccionadas*/
        String[] codCampoArchivo;
        /** Almance el orden en que vienen las Columnas del Archivo*/
        String[] ColumnaSelec;


        codCampoArchivo = estructuraColum.split(",");

        CantidadColumnas = codCampoArchivo.length;

        ColumnaSelec = numeroColum.split(",");

        for (int i = 0; i < ColumnaSelec.length; i++) {
            ColumSeleccionadas.put(codCampoArchivo[i], Integer.parseInt(ColumnaSelec[i]));

            if (codCampoArchivo[i].equals("numeroidentafiliado")) {
                columIdentificacion = i;
            }
            if (codCampoArchivo[i].equals("codtipoidentafiliado")) {
                columTipoIdentificacion = i;
            }
        }

    }

    String lineaCopyInvalida(String estructura) {
        String regPoblacionNoValido = "";
        String[] est = estructura.split(",");


        for (int i = 0; i < est.length - 1; i++) {
            boolean generarComas = true;
            //System.out.println(" Valor : " + est[i]);
            //System.out.println("TipoDatoCampoCV " + TipoDatoCampoCV.get(est[i]));
            if (est[i].equals("numeroidentafiliado")) {
                regPoblacionNoValido += "Error Estructura";
                // System.out.println("1 " + i);
                generarComas = false;
            }
            //Si el campo se requerie fecha
            if (TipoDatoCampoCV.get(est[i]).equals("fecha")) {
                regPoblacionNoValido += "1900-01-01";
                // System.out.println("2 " + i);
                generarComas = false;
            }
            //Si el campo se requerie Numerico
            if (TipoDatoCampoCV.get(est[i]).equals("Numeric")) {
                regPoblacionNoValido += "0";
                //  System.out.println("3 " + i);
                generarComas = false;
            }


            if (generarComas = true) {
                regPoblacionNoValido += separador;
                //  System.out.println("4 " + i);
                generarComas = false;
            }











        }
//        java.util.Set set = ColumSeleccionadas.entrySet();
//        java.util.Iterator iter = set.iterator();
//        while (iter.hasNext()) {
//            java.util.Map.Entry entry = (java.util.Map.Entry) iter.next();
//            System.out.println(entry.getKey() + " -- " + entry.getValue());
//            //regPoblacionNoValido.concat(",");
//            
//            if(entry.getKey().toString().equals("numeroidentafiliado")){
//               //regPoblacionNoValido.concat("Estructura Invalida");
//                regPoblacionNoValido += "Estructura Invalida";
//            }else{
//                regPoblacionNoValido += ",";
//            }
//        }


        return regPoblacionNoValido;
    }

//    void registroinconsistencias() {
//
//        ConexionBaseDatos con;
//        con = new ConexionBaseDatos();
//
//        //PreparedStatement pstmt = null;                 //inconarchafil - tmp_gaso
//        try {
//            con.abrirConexion();
//           // pstmt = con.con.prepareStatement("INSERT INTO tmp_gaso(idregistro,codcampoarchivo,idencabezado,descripcion,codtipoincarch,ususiscodigo,fecharegistro,estado) VALUES(?,?,?,?,?,?,?,?) ");
//            // pstmt.clearParameters();
//
//                StamentInconsistencias.executeBatch();
//                StamentInconsistencias.close();
//                con.cerrarConexion();
//                System.out.println("Ejecuto Batch!!");
//
//
//        } catch (SQLException e) {
//            System.err.println("Error SQL tmp(): " + e.getLocalizedMessage());
//            e.printStackTrace();
//
//            con.cerrarConexion();
//        } catch (Exception e) {
//            System.err.println("Error General tmp(): " + e);
//        }
//
//
//
//
//    }
    public String getLogInconsi() {
        return urlLogInconsistencias;
    }

    public String getDatosInconsi() {
        return urlDatosInconsistentes;
    }

    String setCarpetaTrabajo(String ruta) {
        try {
            //System.out.println(ruta + codEncabezado + System.getProperty("file.separator"));
            File directorio = new File(ruta + codEncabezado + System.getProperty("file.separator"));
            directorio.mkdir();
            return directorio.toString() + System.getProperty("file.separator");
        } catch (Exception e) {
            System.out.println("Error settiando ruta Trabajo serCarpetaTrabajo() " + e.getMessage());
            return "null";
        }

    }

    public String getUrlPoblacionPeriodica() {

        System.out.println(codEncabezado + ": *************** " + urlPoblacionPeriodica.replace(System.getProperty("file.separator"), "/"));
        return urlPoblacionPeriodica.replace(System.getProperty("file.separator"), "/");

        // return urlPoblacionPeriodica;
    }

    public String getUrlInconsistencias() {
        return urlInconsistencias.replace(System.getProperty("file.separator"), "/");
        //return urlInconsistencias;
    }

    public String ruta(String encabezado, String nombreArchivo) {
        String ruta = rutaArchivo + encabezado + System.getProperty("file.separator") + v.archivoRenombrar(nombreArchivo, "copy");
        //System.out.println(encabezado + ": Ruta Nueva " + ruta);
        return ruta.replace(System.getProperty("file.separator"), "/");
    }

    public String rutaInconsistencias(String encabezado, String nombrearchivo) {
        String ruta = rutaArchivo + encabezado + System.getProperty("file.separator") + v.archivoRenombrar(nombrearchivo, "Inconsistencias");
        return ruta.replace(System.getProperty("file.separator"), "/");
    }

    public String rutaDatosCorrectos(String encabezado, String nombrearchivo) {
        v = new ed_ValidacionCampos();
        String ruta = rutaArchivo + encabezado + System.getProperty("file.separator") + v.archivoRenombrar(nombrearchivo, "Validos");
        System.out.println("RUTA: " + ruta);
        System.out.println("rutaArchivo " + rutaArchivo);
        return ruta.replace(System.getProperty("file.separator"), "/");
    }

    public String rutaDatosCorrectos(String encabezado, String nombrearchivo, String rutaTmp) {
        v = new ed_ValidacionCampos();
        String ruta = rutaTmp + encabezado + System.getProperty("file.separator") + v.archivoRenombrar(nombrearchivo, "Validos");
        return ruta.replace(System.getProperty("file.separator"), "/");
    }

    /** Rutas Archivos generacion Novedades */
    public String rutaNovedades(String encabezado, String nombrearchivo, String rutaTmp, String nombre) {
        v = new ed_ValidacionCampos();
        String ruta = rutaTmp + encabezado + System.getProperty("file.separator") + "nov" + System.getProperty("file.separator") + v.archivoRenombrar(nombrearchivo, nombre);
        return ruta.replace(System.getProperty("file.separator"), "/");
    }

    public String rutaRips(String encabezado, String nombrearchivo, String rutaArchivo) {
        v = new ed_ValidacionCampos();
        String ruta = rutaArchivo + System.getProperty("file.separator") + encabezado + System.getProperty("file.separator") + v.archivoRenombrar(nombrearchivo, "copy");
        return ruta.replace(System.getProperty("file.separator"), "/");
    }

    public String rutaRipsInconsistencias(String encabezado, String nombrearchivo, String rutaArchivo, String tipo) {
        v = new ed_ValidacionCampos();
        String ruta = rutaArchivo + System.getProperty("file.separator") + encabezado + System.getProperty("file.separator") + v.archivoRenombrar(nombrearchivo, tipo);
        return ruta.replace(System.getProperty("file.separator"), "/");
    }
//     public String rutaCoincidenciasDetalle(String encabezado, String nombrearchivo , String rutaTmp) {
//        v = new ed_ValidacionCampos();
//        String ruta = rutaTmp + encabezado + System.getProperty("file.separator") + v.archivoRenombrar(nombrearchivo, "Validos");
//        return ruta.replace(System.getProperty("file.separator"), "/");
//    }
//
//     public String rutaNovedades(String encabezado, String nombrearchivo , String rutaTmp) {
//        v = new ed_ValidacionCampos();
//        String ruta = rutaTmp + encabezado + System.getProperty("file.separator") + v.archivoRenombrar(nombrearchivo, "Validos");
//        return ruta.replace(System.getProperty("file.separator"), "/");
//    }

    int leerConsecutivoRips(File archivoConsecutivo) {
        File archivo = archivoConsecutivo;
        FileReader fr = null;
        BufferedReader br = null;

        int consecutivoActual = 1;


        try {
            // Apertura del fichero y creacion de BufferedReader para poder
            // hacer una lectura comoda (disponer del metodo readLine()).
            //archivo = new File("C:\\archivo.txt");
            fr = new FileReader(archivo);
            br = new BufferedReader(fr);

            // Lectura del fichero
            String linea;
            while ((linea = br.readLine()) != null) {
                System.out.println(linea);
                consecutivoActual = Integer.parseInt(linea);
            }
        } catch (Exception e) {
            consecutivoActual = 1;
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

        return consecutivoActual;

    }

    int getConsecutivoRips() {

        File consecutivo = new File(rutaTemporales + "Consecutivo.txt");
        if (consecutivo.exists()) {
            //Leer del archivo
            return leerConsecutivoRips(consecutivo);
        } else {
            return 1;
        }

    }

    public void generarLog(String idencabezado, String dato) {

            FileWriter fichero = null;
            PrintWriter pw = null;
            try {

                File log = new File(getUrlTmp() + idencabezado + System.getProperty("file.separator") + "log.txt");

                fichero = new FileWriter(getUrlTmp() + idencabezado + System.getProperty("file.separator") + "log.txt", true);
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

    void longitudCamposTablas(String tipoCarga, String estructuraArchivo, String columnasSeleccionadas) {
        /*
         * Construir mapa .... clave => nColumSelect  valor  => ValorConsulta
         * Modo de Funcion Content Key  si = true .. get() valor.
         */
        //System.out.println("estructuraArchivo " + estructuraArchivo);
        String[] columna = estructuraArchivo.split(",");
        String[] nColumSelect = columnasSeleccionadas.split(",");

        // System.out.println("String[] columna length " + columna.length);
        //System.out.println("String[] nColumSelect length " + nColumSelect.length);

        Connection conexion = bdS.getConexion();

        String tablaRip = "";
        if (tipoCarga.equals("CargarPoblacion")) {

            PreparedStatement pstmt = null;
            ResultSet rQuery = null;



            try {


//                for (int i = 0; i < columna.length; i++) {
//                    pstmt = con.con.prepareStatement(" SELECT length('" + columna[i] + "') FROM poblacionperiodica LIMIT 1");
//                    //System.out.println("1. SELECT codtipoestrucarch FROM tipoestructarch WHERE codregimen='" + codRegimen + "'");
//                    rQuery = pstmt.executeQuery();
//                    rQuery.next();
//                    longitudCamposTablas.put(Integer.parseInt(nColumSelect[i]), (rQuery.getInt(1) - 1));
//                    System.out.println("columna " + columna[i] + " nColumSelect " + nColumSelect[i] + " Longitud BD " + rQuery.getString(1));
//                }

                for (int i = 0; i < columna.length; i++) {

                    //pstmt = con.con.prepareStatement(" SELECT length('" + columna[i] + "') FROM poblacionperiodica LIMIT 1");
                    pstmt = conexion.prepareStatement(" SELECT   COLUMNS.numeric_precision,   COLUMNS.character_maximum_length,   COLUMNS.TABLE_NAME FROM  information_schema.COLUMNS  LEFT JOIN    pg_class ON COLUMNS.TABLE_NAME::name = pg_class.relname LEFT JOIN     pg_description ON pg_class.oid = pg_description.objoid AND COLUMNS.ordinal_position::INTEGER = pg_description.objsubid WHERE   COLUMNS.table_schema::text = 'public'::text   AND   COLUMNS.TABLE_NAME = 'poblacionperiodica' AND COLUMNS.column_name = '" + columna[i] + "' ORDER BY  COLUMNS.TABLE_NAME ASC,  COLUMNS.ordinal_position ASC  ");
                    //  System.out.println(" SELECT   COLUMNS.numeric_precision,   COLUMNS.character_maximum_length,   COLUMNS.TABLE_NAME FROM  information_schema.COLUMNS  LEFT JOIN    pg_class ON COLUMNS.TABLE_NAME::name = pg_class.relname LEFT JOIN     pg_description ON pg_class.oid = pg_description.objoid AND COLUMNS.ordinal_position::INTEGER = pg_description.objsubid WHERE   COLUMNS.table_schema::text = 'public'::text   AND   COLUMNS.TABLE_NAME = 'poblacionperiodica' AND COLUMNS.column_name = '" + columna[i] + "' ORDER BY  COLUMNS.TABLE_NAME ASC,  COLUMNS.ordinal_position ASC ");
                    rQuery = pstmt.executeQuery();
                    rQuery.next();
//
                    if (rQuery.getInt(1) != 0) {
                        //  System.out.println("rQuery.getInt(1)  " + rQuery.getInt(1));
                        longitudCamposTablas.put(Integer.parseInt(nColumSelect[i]), rQuery.getInt(1));
                    }
                    if (rQuery.getInt(2) != 0) {
                        // System.out.println("rQuery.getInt(2)  " + rQuery.getInt(2));
                        longitudCamposTablas.put(Integer.parseInt(nColumSelect[i]), rQuery.getInt(2));
                    }

                    //System.out.println("columna " + columna[i] + " nColumSelect " + nColumSelect[i] + " Longitud BD " + rQuery.getString(1));
                    // System.out.println("RES " + rQuery.getInt(1) + " | " + rQuery.getInt(2));
                }

                rQuery.close();
                pstmt.close();
                // con.cerrarConexion();
                // System.out.println( "ContenidoRegistro.size() " + ContenidoRegistro.size() );
            } catch (SQLException e) {
                System.err.println("Error al consultar los campos de la tabla Poblacion: " + e);
            }
        } else if (tipoCarga.equals("CargarRips")) {

            if (PrefijoRips.equals("US")) {
                //AC - AH - AM - AP - AT AN - AU -  AV - (CT - AD)

                // ripsperiodicousuario US
                // risperiorico factura AF
                // ripsperiodicoips AC - AH - AM - AP - AN - AT - AU
                // ripsperiodicosEAPE AC - AH - AM  - AP - AN - AT - AU -AV

                tablaRip = "ripsperiodicousuario";
            } else if (PrefijoRips.equals("AF")) {
                tablaRip = "ripsperiodicofactura";
            } else if (PrefijoRips.equals("AC") || PrefijoRips.equals("AH") || PrefijoRips.equals("AM") || PrefijoRips.equals("AP") || PrefijoRips.equals("AN") || PrefijoRips.equals("AT") || PrefijoRips.equals("AU")) {
                tablaRip = "ripsperiodicoips";
            }


            PreparedStatement pstmt = null;
            ResultSet rQuery = null;


            try {


                for (int i = 0; i < columna.length; i++) {
                    //System.out.println(" ENTRA " + i);
                    //pstmt = con.con.prepareStatement(" SELECT length('" + columna[i] + "') FROM poblacionperiodica LIMIT 1");
                    pstmt = conexion.prepareStatement(" SELECT   COLUMNS.numeric_precision,   COLUMNS.character_maximum_length,   COLUMNS.TABLE_NAME FROM  information_schema.COLUMNS  LEFT JOIN    pg_class ON COLUMNS.TABLE_NAME::name = pg_class.relname LEFT JOIN     pg_description ON pg_class.oid = pg_description.objoid AND COLUMNS.ordinal_position::INTEGER = pg_description.objsubid WHERE   COLUMNS.table_schema::text = 'public'::text   AND   COLUMNS.TABLE_NAME = '" + tablaRip + "' AND COLUMNS.column_name = '" + columna[i] + "' ORDER BY  COLUMNS.TABLE_NAME ASC,  COLUMNS.ordinal_position ASC  ");
                    //  System.out.println(" SELECT   COLUMNS.numeric_precision,   COLUMNS.character_maximum_length,   COLUMNS.TABLE_NAME FROM  information_schema.COLUMNS  LEFT JOIN    pg_class ON COLUMNS.TABLE_NAME::name = pg_class.relname LEFT JOIN     pg_description ON pg_class.oid = pg_description.objoid AND COLUMNS.ordinal_position::INTEGER = pg_description.objsubid WHERE   COLUMNS.table_schema::text = 'public'::text   AND   COLUMNS.TABLE_NAME = '"+tablaRip+"' AND COLUMNS.column_name = '" + columna[i] + "' ORDER BY  COLUMNS.TABLE_NAME ASC,  COLUMNS.ordinal_position ASC  ");
                    rQuery = pstmt.executeQuery();
                    rQuery.next();
//
                    if (rQuery.getInt(1) != 0) {
                        //  System.out.println("rQuery.getInt(1)  " + rQuery.getInt(1));
                        longitudCamposTablas.put(Integer.parseInt(nColumSelect[i]), rQuery.getInt(1));
                    }
                    if (rQuery.getInt(2) != 0) {
                        // System.out.println("rQuery.getInt(2)  " + rQuery.getInt(2));
                        longitudCamposTablas.put(Integer.parseInt(nColumSelect[i]), rQuery.getInt(2));
                    }
                    if (rQuery.getInt(1) == 0 && rQuery.getInt(2) == 0) {
                        longitudCamposTablas.put(Integer.parseInt(nColumSelect[i]), 23);
                    }

                    //System.out.println("columna " + columna[i] + " nColumSelect " + nColumSelect[i] + " Longitud BD " + rQuery.getString(1));
                    // System.out.println("RES " + rQuery.getInt(1) + " | " + rQuery.getInt(2));
                }



                rQuery.close();
                pstmt.close();

                //  con.cerrarConexion();
                // System.out.println( "ContenidoRegistro.size() " + ContenidoRegistro.size() );
            } catch (SQLException e) {
                System.err.println("Error al consultar los campos de la tabla: " + e);
            }

        } else if (tipoCarga.equals("CargarRipsEAPB")) {

            if (PrefijoRips.equals("US")) {
                //AC - AH - AM - AP - AT AN - AU -  AV - (CT - AD)

                // ripsperiodicousuario US
                // risperiorico factura AF
                // ripsperiodicoips AC - AH - AM - AP - AN - AT - AU
                // ripsperiodicosEAPE AC - AH - AM  - AP - AN - AT - AU -AV

                tablaRip = "ripsperiodicousuario";
            } else if (PrefijoRips.equals("AF")) {
                tablaRip = "ripsperiodicofactura";
            } else if (PrefijoRips.equals("AC") || PrefijoRips.equals("AH") || PrefijoRips.equals("AM") || PrefijoRips.equals("AP") || PrefijoRips.equals("AN") || PrefijoRips.equals("AT") || PrefijoRips.equals("AU")) {
                tablaRip = "ripsperiodicoeapb";
            }


            PreparedStatement pstmt = null;
            ResultSet rQuery = null;


            try {
                for (int i = 0; i < columna.length; i++) {

                    //pstmt = con.con.prepareStatement(" SELECT length('" + columna[i] + "') FROM poblacionperiodica LIMIT 1");
                    pstmt = conexion.prepareStatement(" SELECT   COLUMNS.numeric_precision,   COLUMNS.character_maximum_length,   COLUMNS.TABLE_NAME FROM  information_schema.COLUMNS  LEFT JOIN    pg_class ON COLUMNS.TABLE_NAME::name = pg_class.relname LEFT JOIN     pg_description ON pg_class.oid = pg_description.objoid AND COLUMNS.ordinal_position::INTEGER = pg_description.objsubid WHERE   COLUMNS.table_schema::text = 'public'::text   AND   COLUMNS.TABLE_NAME = '" + tablaRip + "' AND COLUMNS.column_name = '" + columna[i] + "' ORDER BY  COLUMNS.TABLE_NAME ASC,  COLUMNS.ordinal_position ASC  ");
                    //System.out.println(" SELECT   COLUMNS.numeric_precision,   COLUMNS.character_maximum_length,   COLUMNS.TABLE_NAME FROM  information_schema.COLUMNS  LEFT JOIN    pg_class ON COLUMNS.TABLE_NAME::name = pg_class.relname LEFT JOIN     pg_description ON pg_class.oid = pg_description.objoid AND COLUMNS.ordinal_position::INTEGER = pg_description.objsubid WHERE   COLUMNS.table_schema::text = 'public'::text   AND   COLUMNS.TABLE_NAME = '" + tablaRip + "' AND COLUMNS.column_name = '" + columna[i] + "' ORDER BY  COLUMNS.TABLE_NAME ASC,  COLUMNS.ordinal_position ASC  ");
                    rQuery = pstmt.executeQuery();
                    rQuery.next();
//
                    if (rQuery.getInt(1) != 0) {
                        //  System.out.println("rQuery.getInt(1)  " + rQuery.getInt(1));
                        longitudCamposTablas.put(Integer.parseInt(nColumSelect[i]), rQuery.getInt(1));
                    }
                    if (rQuery.getInt(2) != 0) {
                        // System.out.println("rQuery.getInt(2)  " + rQuery.getInt(2));
                        longitudCamposTablas.put(Integer.parseInt(nColumSelect[i]), rQuery.getInt(2));
                    }
                    if (rQuery.getInt(1) == 0 && rQuery.getInt(2) == 0) {
                        longitudCamposTablas.put(Integer.parseInt(nColumSelect[i]), 23);
                    }

                    //  System.out.println("columna " + columna[i] + " nColumSelect " + nColumSelect[i] + " Longitud BD " + rQuery.getString(1));
                    //  System.out.println("RES " + rQuery.getInt(1) + " | " + rQuery.getInt(2));
                }



                rQuery.close();
                pstmt.close();
                // con.cerrarConexion();
                // System.out.println( "ContenidoRegistro.size() " + ContenidoRegistro.size() );
            } catch (SQLException e) {
                System.err.println("Error al consultar los campos de la tabla: (longitudCamposTablas)" + e);
            }

        }

    }

    public static String getUrlTmp() {
        return urlTmp;
    }

    public static void setUrlTmp(String urlTmp) {
        ed_ValidarArchivo.urlTmp = urlTmp;
    }

    Integer calcularColumPromedio(String aPlano, int ColumS, int ColumT) {
        int ColumPromedio = -1;
        System.out.println("ColumS " + ColumS + " |ColumT " + ColumT);
        try {
            BufferedReader bf = new BufferedReader(new FileReader(aPlano));
            String sCadena;
            while ((sCadena = bf.readLine()) != null) {

                String[] lineaLengh = sCadena.split(separador, -1);


                //System.out.println("cadena  : " + sCadena + " Tama?o Linea " + lineaLengh.length + " Columnas totales " + ColumT);
                //System.out.println("lineaLengh.length = " + lineaLengh.length );
                ColumPromedio = lineaLengh.length;
                if (lineaLengh.length <= ColumT) {
                    ColumPromedio = lineaLengh.length;
                    //System.out.println("calcularColumPromedio = " + ColumPromedio );
                    //System.out.println("lineaLengh.length = " + lineaLengh.length );
                    break;
                }
            }

            bf.close();

        } catch (FileNotFoundException fnfe) {
            System.out.println("Error calcularColumPromedio - FileNotFoundException " + fnfe.getMessage());
            fnfe.printStackTrace();
            ColumPromedio = -1;
        } catch (java.io.IOException ioe) {
            System.out.println("Error calcularColumPromedio - IOException " + ioe.getMessage());
            ioe.printStackTrace();
            ColumPromedio = -1;
        }
        return ColumPromedio;
    }
}
