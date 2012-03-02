package clases;

import java.io.*;
import java.nio.charset.CharsetDecoder;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Calendar;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import java.text.Normalizer;
import java.util.regex.Pattern;

public class UtilidadesDKDA {

    public UtilidadesDKDA() {
    }

    public static String formatoFecha(Date fecha) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            return dateFormat.format(fecha);
        } catch (Exception e) {
            System.out.println("Excepcion: " + e);
            return "";
        }
    }

    public static String formatoFecha2(Date fecha) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MMM/yyyy");
            return dateFormat.format(fecha);
        } catch (Exception e) {
            System.out.println("Excepcion: " + e);
            return "";
        }
    }

    public static String formatoDecimal(String parametros, double valor) {
        DecimalFormat Formato = new DecimalFormat(parametros);
        String salida = Formato.format(valor);
        return salida;
    }

    public static double redondearAMiles(double valor) {
        valor = valor / 1000;
        valor = Math.round(valor) * 1000;
        return valor;
    }

    public static String obtenerFechaActual() {
        java.util.Calendar FECHA = java.util.Calendar.getInstance();

        int d, m, a;
        String mes = "", dia = "", fechaActual = "";

        d = FECHA.get(java.util.Calendar.DATE);
        m = FECHA.get(java.util.Calendar.MONTH);
        a = FECHA.get(java.util.Calendar.YEAR);

        switch (m) {
            case 0:
                mes = "01";
                break;
            case 1:
                mes = "02";
                break;
            case 2:
                mes = "03";
                break;
            case 3:
                mes = "04";
                break;
            case 4:
                mes = "05";
                break;
            case 5:
                mes = "06";
                break;
            case 6:
                mes = "07";
                break;
            case 7:
                mes = "08";
                break;
            case 8:
                mes = "09";
                break;
            case 9:
                mes = "10";
                break;
            case 10:
                mes = "11";
                break;
            case 11:
                mes = "12";
                break;
        }

        switch (d) {
            case 1:
                dia = "01";
                break;
            case 2:
                dia = "02";
                break;
            case 3:
                dia = "03";
                break;
            case 4:
                dia = "04";
                break;
            case 5:
                dia = "05";
                break;
            case 6:
                dia = "06";
                break;
            case 7:
                dia = "07";
                break;
            case 8:
                dia = "08";
                break;
            case 9:
                dia = "09";
                break;
            default:
                dia = String.valueOf(d);
                break;
        }
        fechaActual = dia + "-" + mes + "-" + String.valueOf(a);
        return fechaActual;
    }

    public static String obtenerFechaActual2() {
        java.util.Calendar FECHA = java.util.Calendar.getInstance();

        int d, m, a;
        String mes = "", dia = "", fechaActual = "";

        d = FECHA.get(java.util.Calendar.DATE);
        m = FECHA.get(java.util.Calendar.MONTH);
        a = FECHA.get(java.util.Calendar.YEAR);

        switch (m) {
            case 0:
                mes = "Ene";
                break;
            case 1:
                mes = "Feb";
                break;
            case 2:
                mes = "Mar";
                break;
            case 3:
                mes = "Abr";
                break;
            case 4:
                mes = "May";
                break;
            case 5:
                mes = "Jun";
                break;
            case 6:
                mes = "Jul";
                break;
            case 7:
                mes = "Ago";
                break;
            case 8:
                mes = "Sep";
                break;
            case 9:
                mes = "Oct";
                break;
            case 10:
                mes = "Nov";
                break;
            case 11:
                mes = "Dic";
                break;
        }

        switch (d) {
            case 1:
                dia = "01";
                break;
            case 2:
                dia = "02";
                break;
            case 3:
                dia = "03";
                break;
            case 4:
                dia = "04";
                break;
            case 5:
                dia = "05";
                break;
            case 6:
                dia = "06";
                break;
            case 7:
                dia = "07";
                break;
            case 8:
                dia = "08";
                break;
            case 9:
                dia = "09";
                break;
            default:
                dia = String.valueOf(d);
                break;
        }
        fechaActual = dia + "-" + mes + "-" + String.valueOf(a);
        return fechaActual;
    }

    public static String obtenerHoraActual() {
        java.util.Calendar FECHA = java.util.Calendar.getInstance();

        int h, min;

        String hor, minut, hora;

        h = FECHA.get(java.util.Calendar.HOUR_OF_DAY);
        min = FECHA.get(java.util.Calendar.MINUTE);

        switch (h) {
            case 0:
                hor = "00";
                break;
            case 1:
                hor = "01";
                break;
            case 2:
                hor = "02";
                break;
            case 3:
                hor = "03";
                break;
            case 4:
                hor = "04";
                break;
            case 5:
                hor = "05";
                break;
            case 6:
                hor = "06";
                break;
            case 7:
                hor = "07";
                break;
            case 8:
                hor = "08";
                break;
            case 9:
                hor = "09";
                break;
            default:
                hor = String.valueOf(h);
                break;
        }

        switch (min) {
            case 1:
                minut = "01";
                break;
            case 2:
                minut = "02";
                break;
            case 3:
                minut = "03";
                break;
            case 4:
                minut = "04";
                break;
            case 5:
                minut = "05";
                break;
            case 6:
                minut = "06";
                break;
            case 7:
                minut = "07";
                break;
            case 8:
                minut = "08";
                break;
            case 9:
                minut = "09";
                break;
            default:
                minut = String.valueOf(min);
                break;
        }

        hora = hor + ":" + minut + ":00";
        return hora;
    }

    public static long diasEntreFechas(Calendar fechaVieja, Calendar fechaActual) {
        int diaInicial, mesInicial, anoInicial, diaFinal, mesFinal, anoFinal, dias;

        final long msPerDay = 1000 * 60 * 60 * 24;

        final long date1Milliseconds = fechaVieja.getTime().getTime();
        final long date2Milliseconds = fechaActual.getTime().getTime();
        final long result = (date2Milliseconds - date1Milliseconds) / msPerDay;

        //Hasta ac, dias exactos. De ac en adelante, se calcula a dias contables (30 dias).
        diaInicial = fechaVieja.get(java.util.Calendar.DATE);
        mesInicial = fechaVieja.get(java.util.Calendar.MONTH);
        anoInicial = fechaVieja.get(java.util.Calendar.YEAR);

        diaFinal = fechaActual.get(java.util.Calendar.DATE);
        mesFinal = fechaActual.get(java.util.Calendar.MONTH);
        anoFinal = fechaActual.get(java.util.Calendar.YEAR);

        dias = 0;

        /*//Si es necesario hacer el cilculo de meses de 30 dias.
        if(anoInicial < anoFinal || mesInicial < mesFinal)
        {
        while(anoInicial < anoFinal || mesInicial < mesFinal || (mesInicial==mesFinal && anoInicial==anoFinal))
        {
        if(mesInicial==1 || mesInicial==3 || mesInicial==5 || mesInicial==7 || mesInicial==8 || mesInicial==10 || mesInicial==12) //Meses de 31 dias
        {
        if((mesInicial+1 < mesFinal && anoInicial < anoFinal) || (mesInicial == mesFinal && anoInicial < anoFinal) || (mesInicial > mesFinal && anoInicial < anoFinal))
        {
        dias--;
        }
        else if(mesInicial <= mesFinal && anoInicial == anoFinal)
        {
        dias--;
        }
        }
        else if(mesInicial == 2)//Febrero
        {
        if(anoInicial == 2008 || anoInicial == 2012 || anoInicial == 2016 || anoInicial == 2020 || anoInicial == 2024 || anoInicial == 2028 || anoInicial == 2032 || anoInicial == 2036 || anoInicial == 2040)
        {
        if(diaInicial < 29)
        dias++;
        }
        else
        {
        if(diaInicial < 28)
        dias+=2; //Aï¿½o no bisiesto
        }
        }
        
        mesInicial++;
        
        if(mesInicial == 13)
        {
        mesInicial = 1;
        anoInicial++;
        }
        }
        }*/
//------------------------------------------------------------------------------------------------------------------------------------------------------------
        /*//Para el cambio de mes. Ej: De Ago 25 a Sept 5 (10 Dï¿½as)
        if(((mesInicial+1 == mesFinal && anoInicial == anoFinal) || (mesInicial+1 == 13 && mesFinal==1 && anoInicial+1 == anoFinal)) && (diaInicial < diaFinal))
        if((mesInicial==1 || mesInicial==3 || mesInicial==5 || mesInicial==7 || mesInicial==8 || mesInicial==10 || mesInicial==12)) //Meses de 31 dï¿½as
        dias--;
        else if(mesInicial==2) //Aï¿½o bisiesto
        if(anoInicial == 2008 || anoInicial == 2012 || anoInicial == 2016 || anoInicial == 2020 || anoInicial == 2024 || anoInicial == 2028 || anoInicial == 2032 || anoInicial == 2036 || anoInicial == 2040)
        dias++;
        else
        dias+=2; //Aï¿½o no bisiesto*/

        /*//El mes inicial sea menor o igual al mes final. Que el aï¿½o inicial sea menor al aï¿½o final. Que si el mes inicial es igual al final, verifique si el dï¿½a inicial sea menor al dï¿½a final
        while((mesInicial+1 <= mesFinal) || (anoInicial < anoFinal) || (mesInicial == mesFinal && diaInicial < diaFinal))
        {
        if((mesInicial==1 || mesInicial==3 || mesInicial==5 || mesInicial==7 || mesInicial==8 || mesInicial==10 || mesInicial==12) && (diaInicial < 31 && diaInicial < diaFinal)) //Meses de 31 dï¿½as
        dias--;
        else if(mesInicial==2 && diaInicial < 30) //Aï¿½o bisiesto
        if(anoInicial == 2008 || anoInicial == 2012 || anoInicial == 2016 || anoInicial == 2020 || anoInicial == 2024 || anoInicial == 2028 || anoInicial == 2032 || anoInicial == 2036 || anoInicial == 2040)
        dias++;
        else
        dias+=2; //Aï¿½o no bisiesto
        
        mesInicial++;
        
        if(mesInicial == 13)
        {
        mesInicial = 1;
        anoInicial++;
        //dias--;
        }
        }*/

//------------------------------------------------------------------------------------------------------------------------------------------------------------
        diaInicial = fechaVieja.get(java.util.Calendar.DATE);
        mesInicial = fechaVieja.get(java.util.Calendar.MONTH);
        anoInicial = fechaVieja.get(java.util.Calendar.YEAR);

        diaFinal = fechaActual.get(java.util.Calendar.DATE);
        mesFinal = fechaActual.get(java.util.Calendar.MONTH);
        anoFinal = fechaActual.get(java.util.Calendar.YEAR);

        int cantidadMeses, mesInicialAux, anoInicialAux;
        dias = 0;
        cantidadMeses = 0;

        mesInicialAux = mesInicial;
        anoInicialAux = anoInicial;

        if (anoInicial <= anoFinal) {
            while ((anoInicialAux < anoFinal || mesInicialAux < mesFinal)) {
                cantidadMeses++;
                mesInicialAux++;

                if (mesInicialAux == 12) {
                    mesInicialAux = 0;
                    anoInicialAux++;
                }
            }

            if (diaInicial < diaFinal) {
                if (mesInicialAux < mesFinal) {
                    dias = 30 - diaInicial;

                    if (diaFinal == 31) {
                        diaFinal = 30;
                    }

                    dias = dias + diaFinal;
                } else if (mesInicialAux == mesFinal) {
                    if (diaFinal == 31) {
                        diaFinal = 30;
                    }

                    dias = diaFinal - diaInicial;
                }
            } else if (diaInicial > diaFinal) {
                if (cantidadMeses > 0) {
                    cantidadMeses--;
                }

                dias = 30 - diaInicial;
                dias = dias + diaFinal;
            }

            dias = dias + (cantidadMeses * 30);
        }

        return dias;

        //return result + dias;
    }

    public static long diasEntreFechas31Dias(Calendar fechaVieja, Calendar fechaActual) {
        int diaInicial, mesInicial, anoInicial, diaFinal, mesFinal, anoFinal, dias;

        final long msPerDay = 1000 * 60 * 60 * 24;

        final long date1Milliseconds = fechaVieja.getTime().getTime();
        final long date2Milliseconds = fechaActual.getTime().getTime();
        final long result = (date2Milliseconds - date1Milliseconds) / msPerDay;
        return result;
    }

    public static java.sql.Date fechaToDate(String fecha) {
        java.sql.Date date;
        date = java.sql.Date.valueOf(fecha.substring(6, 10) + "-" + fecha.substring(3, 5) + "-" + fecha.substring(0, 2));
        return date;
    }

    public static Calendar edStringAFecha(String Fecha) {
        Calendar cal = Calendar.getInstance();

        try {
            String str_date = Fecha;
            java.text.DateFormat formatter;
            Date date;
            formatter = new SimpleDateFormat("yyyy-MM-dd");
            date = (Date) formatter.parse(str_date);
            cal.setTime(date);
            //System.out.println("Today is " + date);

        } catch (java.text.ParseException e) {
            System.out.println("Exception :" + e);
        }
        return cal;
    }

    public static java.sql.Timestamp fechaToTimeStamp(String fecha) {
        java.sql.Timestamp timeStamp;
        timeStamp = java.sql.Timestamp.valueOf(fecha);
        return timeStamp;
    }

    public static Vector split(String input, String delimiter) {
        boolean wasDelimiter = true;
        String token = null;
        Vector v = new Vector();
        StringTokenizer st = new StringTokenizer(input, delimiter, true);
        while (st.hasMoreTokens()) {
            token = st.nextToken();
            if (token.equals(delimiter)) {
                if (wasDelimiter) {
                    token = "";
                } else {
                    token = null;
                }
                wasDelimiter = true;
            } else {
                wasDelimiter = false;
            }
            if (token != null) {
                v.addElement(token);
            }
        }
        return v;
    }

    public static String o(HashMap vars, String clave) {
        if (vars.containsKey(clave)) {
            return vars.get(clave).toString().trim();
        }
        return "";

    }

    public static HashMap urlDecodificar(String urlCodificada, String sp) {
        HashMap mapaClaveValor = new HashMap();
        String[] separacionVariables = urlCodificada.split(sp.equals("") ? "&" : sp);

        for (int s = 0; s < separacionVariables.length; s++) {
            String[] claveValor = separacionVariables[s].split("=");
            String clave = claveValor[ 0];
            try {
                String valor = claveValor[ 1];
                mapaClaveValor.put(clave, (valor.equals("") ? "" : valor));

            } catch (IndexOutOfBoundsException e) {
            }
        }

        return mapaClaveValor;
    }

    public java.sql.Timestamp ed_Get_timestamp_without_time_zone() {
        //System.out.println( "********************* fecha Funcion ******** "+FormatoTimestamp.fechaToDate2(FormatoTimestamp.obtenerFechaActual()+" "+FormatoTimestamp.obtenerHoraActual()) );
        java.sql.Timestamp fechaactual = new java.sql.Timestamp(System.currentTimeMillis());
        return fechaactual;
    }

    public String crearArchivo(String nombreArchivo, String ruta) {
        String nombreArchivoCreado = "ed_" + nombreArchivo;
        try {
            FileWriter fw = new FileWriter(ruta + nombreArchivoCreado);
        } catch (java.io.IOException ioex) {
            System.out.println("Error archivo: " + ioex.getMessage());
        }
        return nombreArchivoCreado;
    }

    public BufferedReader abrirArchivo(String nombreArchivo, String ruta) {
        BufferedReader br = null;
        try {
            FileReader fw = new FileReader(new File(ruta + nombreArchivo));
            br = new BufferedReader(fw);
        } catch (FileNotFoundException e) {
            System.out.println("Error archivo: " + e.getMessage());
        } catch (IOException ee) {
            System.out.println("Error archivo: " + ee.getMessage());
        }
        return br;

    }
    // Solo para escribir el archivo creado con el idregistro y idencabezado del original

    public void escribirArchivoCreado(BufferedReader contenidoArchivoOriginal, String nombreArchivoCreado, int idencabezado, String ruta, String delimitador) {
        String linea = "";
        FileWriter archivoCreado = null;
        PrintWriter pw = null;


        try {
            archivoCreado = new FileWriter(ruta + nombreArchivoCreado, true);
            pw = new PrintWriter(archivoCreado);
            int idregistro = 1;
            while ((linea = contenidoArchivoOriginal.readLine()) != null) {
                pw.println(idencabezado + delimitador + idregistro + delimitador + linea);
                idregistro++;
            }
        } catch (FileNotFoundException e) {
            System.out.println("Error archivo: " + e.getMessage());
        } catch (IOException ee) {
            System.out.println("Error archivo: " + ee.getMessage());
        }




    }

    public static String estructuraColumnas(HttpServletRequest request) {
        HashMap vars = new HashMap();
        vars = clases.UtilidadesDKDA.urlDecodificar(request.getParameter("varsSelecColumnas"), "");

        String estructuraColumnas = "";
        cargaArchivos.ConstruccionSQL sql;

        sql = new cargaArchivos.ConstruccionSQL(request, vars);
        return sql.construirEstructuraColumnas();
    }

    public static String fechasSeleccionadas(String fechas) {


        String valores = "";
        if (fechas != null) {
            try {
                ConexionBaseDatos con;
                con = new ConexionBaseDatos();
                con.abrirConexion();
                Statement st = con.con.createStatement();
                ResultSet rq = st.executeQuery("SELECT nombrecampotabla FROM listacamposarchivo WHERE codcampoarchivo  IN(" + fechas + ")");
                while (rq.next()) {
                    valores += rq.getString("nombrecampotabla") + ",";
                }

            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }



        }
        return valores;

    }

    public static String convertirACarEspecial(String string) {
        String nuevoString = "";
        if (string == null) {
            return nuevoString;
        }

        for (int n = 0; n < string.length(); n++) {
            String caracter = (string.substring(n, n + 1));

            if (caracter.equals("á")) {
                nuevoString += "&aacute;";
            } else if (caracter.equals("Á")) {
                nuevoString += "&Aacute;";


            } else if (caracter.equals("é")) {
                nuevoString += "&eacute;";
            } else if (caracter.equals("É")) {
                nuevoString += "&Eacute;";


            } else if (caracter.equals("í")) {
                nuevoString += "&iacute;";
            } else if (caracter.equals("Í")) {
                nuevoString += "&Iacute;";


            } else if (caracter.equals("Ó")) {
                nuevoString += "&Oacute;";
            } else if (caracter.equals("ó")) {
                nuevoString += "&oacute;";
            } else if (caracter.equals("Ú") || caracter.equals("\u00dc")) {
                nuevoString += "&Uacute;";
            } else if (caracter.equals("ú") || caracter.equals("\u00fc")) {
                nuevoString += "&uacute;";
            } else if (caracter.equals("\u00f1")) {
                nuevoString += "&ntilde;";
            } else if (caracter.equals("\u00d1")) {
                nuevoString += "&Ntilde;";
            } else {
                nuevoString += caracter;
            }
        }
        return nuevoString;
    }

    public void ed_CodArchivo(String urlArchivo) {

        //Ejecutar siempre y cuando sea un Sistema Operativo
        //de Verdad
        if (System.getProperty("os.name").equals("Linux")) {

            try {
                String command;
                //command = "sed -i '1 s/^\\xef\\xbb\\xbf//' *.txt";
                //command = "sed -i '1 s/^\\xef\\xbb\\xbf//' " + urlArchivo;
                //command = "tail --bytes=+4  " + urlArchivo;
                command = "date";
                final Process process = Runtime.getRuntime().exec(command);
                new Thread() {

                    public void run() {
//                        try {
//                            InputStream is = process.getInputStream();
//                            byte[] buffer = new byte[1024];
//                            for (int count = 0; (count = is.read(buffer)) >= 0;) {
//                                System.out.write(buffer, 0, count);
//                            }
//                        } catch (Exception e) {
//                            e.printStackTrace();
//                        }
                    }
                }.start();
                new Thread() {

                    public void run() {
                        try {
                            InputStream is = process.getErrorStream();
                            byte[] buffer = new byte[1024];
                            for (int count = 0; (count = is.read(buffer)) >= 0;) {
                                System.err.write(buffer, 0, count);
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }.start();

                int returnCode = process.waitFor();
                System.out.println("Return code = " + returnCode);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static void eliminarDirectorioSO(String urlArchivo) {


        //Ejecutar siempre y cuando sea un  Sistema Operativo
        //de Verdad
        if (System.getProperty("os.name").equals("Linux")) {

            try {
                String command;
                //command = " sh -c rm -R -f " + urlArchivo;
                command = "rm -R -f " + urlArchivo;
                System.out.println(command);
                final Process process = Runtime.getRuntime().exec(command);

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("Corriendo desde un Jugete ... ");
            try {
                String command;
                command = "cmd /c RD /S /Q  \"" + urlArchivo + "\" ";
                System.out.println(command);
                final Process process = Runtime.getRuntime().exec(command);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static String remove2(String input) {
        // Descomposición canónica
        String normalized = Normalizer.normalize(input, Normalizer.Form.NFD);
        // Nos quedamos únicamente con los caracteres ASCII
        Pattern pattern = Pattern.compile("\\P{ASCII}");
        return pattern.matcher(normalized).replaceAll("");
    }

    public static String unAccent(String s) {
        //
        // JDK1.5
        //   use sun.text.Normalizer.normalize(s, Normalizer.DECOMP, 0);
        //
        String temp = Normalizer.normalize(s, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("[\\p{InCombiningDiacriticalMarks}\\p{IsLm}\\p{IsSk}]+");
        return pattern.matcher(temp).replaceAll("");
    }

//     public static String normalizeSymbolsAndAccents(String str) {
//    str = org.apache.commons.lang.StringUtils.defaultString(str);
//    String nfdNormalizedString = Normalizer.normalize(str, Normalizer.Form.NFD);
//    Pattern pattern = Pattern.compile("[\\p{InCombiningDiacriticalMarks}\\p{IsLm}\\p{IsSk}]+");
//    return pattern.matcher(nfdNormalizedString).replaceAll("");
//  }
    //http://www.jguru.com/faq/view.jsp?EID=137049
    //native2ascii
    // Devuelve una fecha en el formato dia/mes/anio
    public String intertirFecha(String fecha) {
        String[] fechaCorteHora = fecha.split(" ");
        String[] fechaCorte = fechaCorteHora[ 0].split("-");
        return fechaCorte[ 2] + "-" + fechaCorte[ 1] + "-" + fechaCorte[ 0];
    }

    /**
     * Completa una cadena con el formato esperado.
     * 
     * @param text  String a autocompletar
     * @param formato Formato que tiene que tener la cadena resultante
     * @return String formateado con el formato requerido
     */
    public static String ed_completar(String text, String formato) {
        return text.concat(formato.substring(text.length()));
    }

    /**
     * Convertir un Valor Double de Notacion Cientifica a Notacion Normal
     * @param valor Notacion cienticica 
     * @return String convertido 
     * @see  http://goo.gl/2wqEq
     */
    public static String ed_notacionCientifica_Normal(double valor) {
        java.util.Locale.setDefault(java.util.Locale.US);
        DecimalFormat num = new DecimalFormat("#,###.00");
        return num.format(valor);
    }

    /**
     * Procedimiento para Codificacion Archivos Planos: ( Linux - Java ) 08/08/2011 - @edgaso
     * 
     *   1. get Encoding : file --mime-encoding Contributivo_Jul_2010.Txt
     *   2. Comprobarlo contra : utf-8 //Contributivo_Jul_2010.Txt: utf-8
     *   3. Si son diferentes cambiarlo a utf-8 : iconv --from-code=iso-8859-1 --to-code=utf-8 Contributivo_Jul_2010.Txt > Contributivo_Jul_2010.txt.utf8
     *   4. Reescribir el archivo de uf8 por el nombre del archivo original mv -f Contributivo_Jul_2010.txt.utf8 Contributivo_Jul_2010.Txt 
     * 
     * @see  http://ereimer.net/programs/find-anomalous-textfiles
     * @param urlArchivo Ruta del Archivo Plano que se va a verificar/transformar la codificacion.
     */
    public static void ed_transformarEncodingArchivo(String urlTmp, String urlArchivo) {
        if (System.getProperty("os.name").equals("Linux")) {

            try {
                Runtime r = Runtime.getRuntime();
                System.out.println("file -i " + urlArchivo);
                Process p = r.exec("file -i " + urlArchivo);
                p.waitFor();
                BufferedReader b = new BufferedReader(new InputStreamReader(p.getInputStream()));
                String line = "";
                String codOrigen = "";
//                while ((line = b.readLine()) != null) {
//                    System.out.println(line);
//                }
                line = b.readLine();
                System.out.println("line " + line);
                String[] encodingFile = line.split("=");
                codOrigen = encodingFile[1].replaceAll(" ", "");
                System.out.println("1. codOrigen " + codOrigen);
                if (encodingFile[1].replaceAll(" ", "").contains("unknown-8bit")) {
                    codOrigen = "cp1252";
                }
                if (encodingFile[1].replaceAll(" ", "").contains("unknown")) {
                    codOrigen = "cp1252";
                }
                System.out.println("2. codOrigen |" + codOrigen + "|");
                if (!"utf-8".equals(codOrigen)) {
                    //System.out.println("Distinta Encoding");
                    //Aqui ejecutar para cambiar Enconding
                    //System.out.println("urlArchivo" + urlArchivo + " " + encodingFile[1].replaceAll(" ", ""));
                    ed_iconvArchivo(urlTmp, urlArchivo, codOrigen);
                    //Aqui ejecutar para renombrarlo a como estaba antes.
                    //System.out.println("Cambiando Enconding ...");
                    ed_renombrarArchivo(urlArchivo);
                    //System.out.println("Renombrando Archivo  ...");

                }


            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static boolean ed_iconvArchivo(String urlTmp, String urlArchivo, String encodingOrigen) {
        try {
            Runtime r = Runtime.getRuntime();
            //System.out.println(urlTmp+"ed_iconv.sh " + encodingOrigen + " " + urlArchivo);
            //Process p = r.exec("bash -c 'iconv --from-code=" + encodingOrigen + " --to-code=utf-8 " + urlArchivo + " > " + urlArchivo + ".utf8'");
            System.out.println(urlTmp + "ed_iconv.sh " + encodingOrigen + " " + urlArchivo);
            Process p = r.exec(urlTmp + "ed_iconv.sh " + encodingOrigen + " " + urlArchivo);
            p.waitFor();
            BufferedReader b = new BufferedReader(new InputStreamReader(p.getInputStream()));
            String line = "";
            while ((line = b.readLine()) != null) {
                System.out.println("iconv : " + line);
            }
            return true;

        } catch (Exception e) {
            System.out.println("Error ed_iconvArchivo()" + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static boolean ed_renombrarArchivo(String urlArchivo) {
        try {
            //System.out.println("mv -f " + urlArchivo + ".utf8 " + urlArchivo);
            Runtime r = Runtime.getRuntime();
            Process p = r.exec("mv -f " + urlArchivo + ".utf8 " + urlArchivo);

            return true;

        } catch (Exception e) {
            System.out.println("Error renombrarArchivo()" + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static boolean ed_permisosArchivo(String urlArchivo) {
        if (new File(urlArchivo).exists() && System.getProperty("os.name").equals("Linux") && new File(urlArchivo).isFile()) {
            try {
                System.out.println(" Aplicando ... /bin/chmod 777 " + urlArchivo);
                Runtime r = Runtime.getRuntime();
                Process p = r.exec("/bin/chmod 777 " + urlArchivo);
                BufferedReader b = new BufferedReader(new InputStreamReader(p.getInputStream()));
                p.waitFor();
                String line = "";
                while ((line = b.readLine()) != null) {
                    System.out.println("chmod  : " + line);
                }
                return true;

            } catch (Exception e) {
                System.out.println("Error permisosArchivo()" + e.getMessage());
                e.printStackTrace();
                return false;
            }
        }
        return false;
    }



    /**
     * Asignar permisos de Lectura , Escritura y Ejecucion a los archivos
     * que sean referenciados en esta funcion.
     * @param urlTmp ruta temporal de la aplicacion (donde se encuentra el ed_p.sh)
     * @param urlArchivo ruta donde esta el archivo al que se le quiere cambiar los permisos
     * @return
     */


    public static boolean ed_p(String urlTmp, String urlArchivo) {
        try {
            Runtime r = Runtime.getRuntime();
            
            System.out.println("ed_p() - Cambiando Permisos ... |"+ urlTmp + "ed_p.sh "  + urlArchivo);

            Process p = r.exec(urlTmp + "ed_p.sh "  + urlArchivo);
            p.waitFor();
            BufferedReader b = new BufferedReader(new InputStreamReader(p.getInputStream()));
            String line = "";
            while ((line = b.readLine()) != null) {
                System.out.println("ed_p : " + line);
            }
            return true;

        } catch (Exception e) {
            System.out.println("Error ed_p()" + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
