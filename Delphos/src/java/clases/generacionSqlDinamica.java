/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author John J.S
 */
public class generacionSqlDinamica extends HttpServlet {

    String identicaAfi = "", tipoIdeAfi = "" ,priNombreAfi = "", segNombreAfi = "", priApellidoAfi = "", segApellidoAfi = "";
    UtilidadesDKDA ValidarFechas = new UtilidadesDKDA();

    public String init(HttpServletRequest request) {

        String SQL = "";

        identicaAfi = request.getParameter("numeroidentafiliado");
        tipoIdeAfi = request.getParameter("codtipoidentafiliado");
        priNombreAfi = request.getParameter("primernombre");
        segNombreAfi = request.getParameter("segundonombre");
        priApellidoAfi = request.getParameter("primerapellido");
        segApellidoAfi = request.getParameter("segundoapellido");
        String Fechas[] = request.getParameterValues("fechanacimiento[]");

        /* - ----- Dinamismo Campo Número Documento Afiliado - numeroidentafiliado ---- - */
        // Aplica para el LIKE
        if (identicaAfi.length() != 0 && identicaAfi.indexOf("%") != -1) {
            SQL += " AND numeroidentafiliado LIKE '" + identicaAfi + "'";
        } //Aplica para el =
        else if (identicaAfi.length() != 0 && identicaAfi.indexOf("%") == -1) {
            SQL += " AND numeroidentafiliado = '" + identicaAfi + "'";
        } // Aplica para el vacio
        else if (identicaAfi.length() == 0) {
        }

        /* - ----- Dinamismo Campo Primer Nombre del Afiliado - primernombre ---- - */
        // Aplica para el LIKE
        if (priNombreAfi.length() != 0 && priNombreAfi.indexOf("%") != -1) {
            SQL += " AND primernombre LIKE '" + priNombreAfi + "'";
        } //Aplica para el =
        else if (priNombreAfi.length() != 0 && priNombreAfi.indexOf("%") == -1) {
            SQL += " AND primernombre = '" + priNombreAfi + "'";
        } // Aplica para el vacio
        else if (priNombreAfi.length() == 0) {
        }



        /* - ----- Dinamismo Campo  Segundo Nombre del Afiliado - segundonombre ---- - */
        // Aplica para el LIKE
        if (segNombreAfi.length() != 0 && segNombreAfi.indexOf("%") != -1) {
            SQL += " AND segundonombre LIKE '" + segNombreAfi + "'";
        } //Aplica para el =
        else if (segNombreAfi.length() != 0 && segNombreAfi.indexOf("%") == -1) {
            SQL += " AND segundonombre = '" + segNombreAfi + "'";
        } // Aplica para el vacio
        else if (segNombreAfi.length() == 0) {
        }


        /* - ----- Dinamismo Campo Primer Apellido del Afiliado - primerapellido ---- - */
        // Aplica para el LIKE
        if (priApellidoAfi.length() != 0 && priApellidoAfi.indexOf("%") != -1) {
            SQL += " AND primerapellido LIKE '" + priApellidoAfi + "'";
        } //Aplica para el =
        else if (priApellidoAfi.length() != 0 && priApellidoAfi.indexOf("%") == -1) {
            SQL += " AND primerapellido = '" + priApellidoAfi + "'";
        } // Aplica para el vacio
        else if (priApellidoAfi.length() == 0) {
        }



        /* - ----- Dinamismo Campo Segundo Apellido del Afiliado - segundoapellido ---- - */
        // Aplica para el LIKE
        if (segApellidoAfi.length() != 0 && segApellidoAfi.indexOf("%") != -1) {
            SQL += " AND segundoapellido LIKE '" + segApellidoAfi + "'";
        } //Aplica para el =
        else if (segApellidoAfi.length() != 0 && segApellidoAfi.indexOf("%") == -1) {
            SQL += " AND segundoapellido = '" + segApellidoAfi + "'";
        } // Aplica para el vacio
        else if (segApellidoAfi.length() == 0) {
        }


        /* - ----- Dinamismo Campo Fechas de Nacimiento - fechanacimiento[] ---- - */
        if ( ! Fechas[0].isEmpty() && ! Fechas[1].isEmpty()  ) {

            // Validar Fechas


            if (ValidarFechas.diasEntreFechas31Dias(ValidarFechas.edStringAFecha(Fechas[0]), ValidarFechas.edStringAFecha(Fechas[1])) >= 0) {
                SQL += " AND ( fechanacimiento BETWEEN '" + Fechas[0] + "' AND '" + Fechas[1] + "') ";

            } else {
                //System.out.println("La FECHAA NO ES VALIDAA : " + ValidarFechas.diasEntreFechas(ValidarFechas.edStringAFecha(Fechas[0]), ValidarFechas.edStringAFecha(Fechas[1])));
            }


        }
        // Al final se genera las SQL departamento-municipio residencia, falta agregar que se genere la de nacimiento
        // Bueno, falta la base de datos...
        SQL +=  generarIN( "codtipoidentafiliado" , "tipodocumentoafiliado[]" , request) + generarIN("codsexo", "codsexo[]", request) + generarIN("codestadocivil", "codestadocivil[]", request) +  departamentosMunicipios(request, "departamentoResidencia[]", "municipiosResidencia[]");

        // Con este if se quita el AND del inicio de
        // el String. :) ; para ello debe de ser mayor a 4 caracteres.

        if (SQL.length() >= 4) {
            if (SQL.substring(1, 4).equals("AND")) {
                SQL = " " + SQL.substring(5);
            }
        }

        
         System.out.println("Asi quedaria el SQL: |"+SQL);


        return "";
    }
    // NOTA :
    // La tabla o campo donde apunta actualmente la generacion de estas SQL dinamicas, deben
    // ser cambiadas, y reemplazarlas por las que es...
    public String departamentosMunicipios(HttpServletRequest request, String departamento, String municipio) {
        
        String dtosDepar[] = request.getParameterValues( departamento );

        String todosMunicipios[] = request.getParameterValues("estanSeleccionados_" + municipio);

        // Si no hay nada seleccionado, que continue con lo otro.
        if (dtosDepar == null || todosMunicipios == null) {
            return "";
        }
        // Determina si los todos los departamentos de un municipio estan o no seleccionados


        String dtosMuni[] = request.getParameterValues( municipio );

        String stringDepartamento = "";
        String stringMunicipios = "";
        String finalString = "";
        String anterior = "";

        for (int n = 0; n < dtosMuni.length; n++) {

            String codDepar_codMuni[] = dtosMuni[n].split("_");
            if (anterior.equals(codDepar_codMuni[ 0])) {
                continue;
            }
            // Solo genera el SQL, mientras el departamento este seleccionado.
            int cant = 0;
            for (int s = 0; s < dtosDepar.length; s++) {
                if (codDepar_codMuni[ 0].equals(dtosDepar[s])) {
                    cant++;
                }

            }
            if (cant == 0) {
                continue;
            }

            anterior = codDepar_codMuni[ 0];
            stringDepartamento = codDepar_codMuni[ 0] + ".";

            for (int v = 0; v < dtosMuni.length; v++) {

                String codDepar_codMuni_2[] = dtosMuni[v].split("_");
                if (codDepar_codMuni[ 0].equals(codDepar_codMuni_2[ 0])) {
                    stringMunicipios += codDepar_codMuni_2[ 1] + "-";
                }
            }
            finalString += stringDepartamento + stringMunicipios.substring(0, stringMunicipios.length() - 1) + ",";
            stringMunicipios = "";


        }
        // -> 1.1-4-5, 2.6-9-0
        // -> 1/1

        String deparMunicipios[] = (finalString.substring(0, finalString.length() - 1)).split(",");
        String departamentoMunicipio = "";

        if (deparMunicipios.length == 1) {
            String codDepartamento[] = deparMunicipios[ 0].split("\\.");
            if (!todosMunicipios[ 0].equals(codDepartamento[ 0])) {
                String sqlDepartamento = " AND d.coddepartamento = '" + codDepartamento[ 0] + "' AND m.codmunicipio IN";
                // Municipios
                String municipios[] = codDepartamento[ 1].split("-");
                String sqlMunicipios = "";
                for (int n = 0; n < municipios.length; n++) {
                    sqlMunicipios += "'" + municipios[n] + "',";
                }
                sqlMunicipios = "(" + (sqlMunicipios.substring(0, sqlMunicipios.length() - 1)) + ")";

                departamentoMunicipio = sqlDepartamento + sqlMunicipios;
            } else {
                departamentoMunicipio = " AND d.coddepartamento = '" + codDepartamento[ 0] + "'";
            }

        } else {
            String sqlDepartamentos = "";
            for (int n = 0; n < deparMunicipios.length; n++) {

                String codDepar_codMuni[] = deparMunicipios[n].split("\\.");
                String codDepartamento = codDepar_codMuni[ 0];
                boolean existeEntodosMunicipios = false;
                for( int e = 0; e < todosMunicipios.length; e++ ) {
                    if( todosMunicipios[ e ].equals( codDepartamento ) ){
                        existeEntodosMunicipios = true;
                        System.out.println( "Dentro: " + todosMunicipios[ e ] );
                        break;
                    }

                }

                if ( ! existeEntodosMunicipios) {

                    sqlDepartamentos = " ( d.coddepartamento = '" + codDepartamento + "' AND m.codmunicipio IN";
                    // Municipios
                    String municipios[] = codDepar_codMuni[ 1].split("-");
                    String sqlMunicipios = "";
                    for (int v = 0; v < municipios.length; v++) {
                        sqlMunicipios += "'" + municipios[v] + "',";
                    }
                    sqlMunicipios = "(" + (sqlMunicipios.substring(0, sqlMunicipios.length() - 1)) + ")) OR ";
                    //sqlDepartamentosMunicipios += sqlDepartamentosMunicipios + sqlMunicipios;
                    departamentoMunicipio += sqlDepartamentos + sqlMunicipios;
                } else {
                    departamentoMunicipio += " ( d.coddepartamento = '" + codDepartamento + "' ) OR ";
                }

            }

            departamentoMunicipio = " AND (" + departamentoMunicipio.substring(0, departamentoMunicipio.length() - 3) + ")";
        }
        return departamentoMunicipio;
    }


    /**
     * 
     * @param CampoBD Campo de la Base de datos a la cual se hace referencia
     * @param CampoForm Value del Campo del Formulario desde donde se hace la Peticion
     * @param request Peticion que es entregada al Servelet para hacer el procedimiento.
     * @return sintaxisQuery Retorna String con fragmento sql utilizando el IN.
     */
    public static String generarIN(String CampoBD, String CampoForm, HttpServletRequest request) {
        String sintaxisQuery = "";

        String elemRequest[] = request.getParameterValues(CampoForm);

        if (elemRequest != null) {

            sintaxisQuery = " AND " + CampoBD + " IN(";
            for (int i = 0; i < elemRequest.length; i++) {
                sintaxisQuery += "'" + elemRequest[i] + "',";
            }
            sintaxisQuery = sintaxisQuery.substring(1, sintaxisQuery.length() - 1) + ") ";
            System.out.println(sintaxisQuery);
        }

        return sintaxisQuery;

    }


    /**
     * Calcular Dimencion en Pixeles de un Elemento apartir del numero de Letras que
     * Contenga.
     * </br>
     * @param Calcular String que sera lo que se va a Calcular, valores posibles:
     *  </br>
     * -> Hoja  </br>
     * -> Banda_Lineas  </br>
     * -> Logo_Delphos  </br>
     * -> Paginador1  </br>
     * -> Paginador2 </br>
     * -> Margen  </br>
     * @param tamanoDatos Tamano retornado en numero de Caracteres
     * @return size Tamano en Pixeles
     */

    public static int DimencionReport(String Calcular, int tamanoDatos) {

        int size = 0;


        // Si el Tama?o es Mayor al A4
        if ((tamanoDatos * 8) > 842) {

            if (Calcular.equals("Hoja")) {
                size = tamanoDatos * 8;
            }

            if (Calcular.equals("Banda_Lineas")) {
                // El 40 son las Margenes Izquierda (20) y Derecha (020)
                size = (tamanoDatos * 8) - 40;
            }

            if (Calcular.equals("Logo_Delphos")) {
                // El 160 es el Ancho del Logo y el 40 Corresponden a las Margenes Izq y Dere
                size = (tamanoDatos * 8) - 160 - 40;
            }

            if (Calcular.equals("Paginador1")) {
                size = (tamanoDatos * 7) - 143;
            }

            if (Calcular.equals("Paginador2")) {
                size = (tamanoDatos * 7) - 61;
            }

            if (Calcular.equals("Margen")) {
                size = (tamanoDatos * 8) - 40;
            }

        } // Si Tama?o es Igual o Menos a A4 842
        else {

            if (Calcular.equals("Hoja")) {
                size = 842;
            }

            if (Calcular.equals("Banda_Lineas")) {
                size = 794;
            }

            if (Calcular.equals("Logo_Delphos")) {
                size = 634;
            }

            if (Calcular.equals("Paginador1")) {
                size = 672;
            }

            if (Calcular.equals("Paginador2")) {
                size = 754;
            }

            if (Calcular.equals("Margen")) {
                size = 842 - 40;
            }
        }

        tamanoDatos = 0;

        return size;
    }
}
