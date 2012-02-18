$( document ).ready( function() {
    
    // En algunas lineas se usa id = ""  se hace porque al seleccionar un departamento se registra el id
    // cuando se seleccionan todos los departamentos vuelve y carga en el dialogo ese departamento
    // Al poner ese id en "" vacio ya no lo carga.

    // Mientras que todos los municipios esten chekeados el checkboc Seleccionar Todos se mantiene true de lo contrario false
    cantMunicipiosSeleccionados = function(codDepartamento, haySeleccionados, name) {
        cantSeleccionados = 0;
        $("input[value*='"+ codDepartamento +"_'][name='"+ name +"']").each( function( ) {
            if( $(this).attr("checked") ) {
                cantSeleccionados++;
            }
            input = $("#" + codDepartamento +  "_seleccionarMunicipios_" + ( name.substr(0, name.length - 2) ));
            estanSeleccionados = $("input[name*='estanSeleccionados_"+ ( name.substr(0, name.length - 2) ) +"[]']");
            if( cantSeleccionados < haySeleccionados ) {
                input.attr("checked", false);
                estanSeleccionados.attr("value", codDepartamento + "_noTodos");
            } else {
                input.attr("checked", true);
                estanSeleccionados.attr("value", codDepartamento);

            }

        } );
    };
    
    // Mantiene chekeado el numero de documento afiliado...
    $("#numeroidentafiliado, #codtipoidentafiliado").click( function() {
        $(this).attr("checked", true);
    } );
    // Hace que no se oculte la barra si no se selecciona ningun departamento
    $('#departamentos-municipios').dialog({
        autoOpen: false
    });
    // Estilos botones
    $(function() {
        $("button, input:submit, a", "#drawer").button();

        $("a", "#drawer").click(function() {
            return false;
        });
    });

    // Ajax cargando.
    $("#ajax-cargando").ajaxStart( function() {

        $('#ajax-cargando').dialog({
            autoOpen: true,
            show: 'fold',
            hide: 'drop',
            height : 200,
            width : 400

        });


    } ).ajaxStop( function() {
        $('#ajax-cargando').dialog("destroy");

    } );


    // Implementa el acordion -> lo configura
    $(function() {
        $("#accordion").accordion({
            autoHeight: false,
            navigation: true,
            active : 1


        });
    });
    //------------------------------------------------------------------------
    $(function() {
        $("#accordion_variables").accordion({
            autoHeight: false,
            navigation: true,
            active : 1,
            collapsible: true
        });
    });
    //------------------------------------------------------------------------
    // Manejo de los calendarios
    $(".fecha").datepicker({
        dateFormat : 'yy-mm-dd',
        changeMonth: true,
        changeYear: true

    });
    //------------------------------------------------------------------------
    // Es el Seleccionar todos de los municipios ...
    seleccionarTodosMunicipios = function( id ) {
        id_solo = id.split("_");
        $("#" + id_solo[ 0 ] + "_" + ( name.substr(0, name.length - 2) ) +   " table tr td input[value*='"+ id_solo[ 0 ] +"']").each( function() {
            $(this).attr("checked", $("#" + id).attr("checked"));
        } );
    }
    agregarMunicipios = function( departamentos, name ) {
        codigoDepartamento = departamentos;

        $.post("../ServletSeleccionarMunicipios", {
            "departamentos" : codigoDepartamento,
            "codDepartamento" : 0
        }, function( data ) {

            $(data).find('municipios').each( function() {
                var $municipios = $(this);

                checkMunicipios = "";
                codMunicipios = "";
                nombreMunicipios = "";
                codDepartamento = "";

                $municipios.find("departamentos").each( function () {
                    var $departamentos = $(this);


                    $departamentos.find("municipio").each( function() {
                        var $municipio = $(this);
                        codDepartamento = $municipio.attr("departamento");


                        $municipio.find("codMunicipio").each( function( ) {
                            codMunicipios += '-' +  $(this).text();
                        });
                        $municipio.find("nombre").each( function( ) {
                            nombreMunicipios += '-' +  $(this).text();

                        });

                    } );
                    altBarrios = $("#" + ( name.substr(0, name.length - 2) ) + "_barrios").attr("alt");
                    checked = "";
                    barrios = "";
                    if( altBarrios == "si" )  {
                        checked = '<input type="checkbox" name="barrios_'+ ( name.substr(0, name.length - 2) ) +"[]"+'" checked />';
                        barrios = '<input type="checkbox" /><strong>Barrios</strong>';
                    }
                    
                    codMunicipios = codMunicipios.split("-");
                    nombreMunicipios = nombreMunicipios.split("-");
                    for( n = 1; n < codMunicipios.length; n++ ) {
                        checkMunicipios += '<tr><td></td><td>' +
                        '<input type="checkbox" onclick="cantMunicipiosSeleccionados('+ codDepartamento +', this.alt, \''+ name +'\')"' +
                        'name="'+ name +'" alt="'+ (codMunicipios.length - 1) +'" value="' + codDepartamento + '_' + codMunicipios[ n ] + '"' +
                        'checked="checked"/>( '+ codMunicipios[ n ] +' ) '+ nombreMunicipios[ n ] + '</td><td>'+ checked +'</td></tr>';
                    }
                    if( ! ($('#' + codDepartamento + '_' + ( name.substr(0, name.length - 2) )).is("div")) ) {
                        $("<div id='"+ codDepartamento +"_"+ ( name.substr(0, name.length - 2) ) +"' style='display: none; border:0px solid #333'>" +
                            "<table><tr><td colspan=\"2\"><input type=\"checkbox\" value=\""+ codDepartamento +"\" " +
                            "name=\"estanSeleccionados_"+ ( name.substr(0, name.length - 2) ) +"[]\" "+
                            "id=\""+ codDepartamento +"_seleccionarMunicipios_"+ ( name.substr(0, name.length - 2) ) +"\" "+
                            "title=\""+ name +"\" onclick=\"seleccionarTodosMunicipios(this.id)\" checked /><strong>Seleccionar Todos</strong></td><td>"+
                            barrios+"</td></tr>"+
                            checkMunicipios +"</table></div>").appendTo('#departamentos-municipios');
                                
                    }
                    checkMunicipios = "";
                    codMunicipios = "";
                    nombreMunicipios = "";
                    codDepartamento = "";

                } );

            } );
        });
    }
    peticionMunicipios = ""
    // Maneja la seleccion de elementos checkbox multiples. [*] Seleccionar todos
    $("input[class='seleccionarDepartamentos']").click( function() {
        // Checkbox que selecciona los checkbox hijos...
        check = $(this).attr("checked");

        $('#departamentos-municipios').hide();

        // Se seleccionan iterativamente los elementos hijos con el estado actual del seleccionador... true | false
        $("input[name='"+ $(this).attr("title") +"']").each( function() {
            $(this).attr("checked", check);
            peticionMunicipios += this.value + '-';
        } );
        // Solo si los elementos se chekean
        if( ! check ) {
            return "";
        }
        agregarMunicipios( peticionMunicipios.substr( 0, peticionMunicipios.length - 1), this.alt );

    } );


    $("input[id*='_chekear']").click( function() {
        if( $(this).attr("checked") )  {

            titulo = this.title;
            id_actual = this.id;
            id = id_actual.split("_");
            name = this.alt;

            agregarMunicipios( this.value, name );
            $("#departamentos-municipios").ajaxStop( function() {
                if( id  ) {
                    $("#departamandosmMostrados").val("#" + id[ 0 ] + "_" + ( name.substr(0, name.length - 2) ));
                    $("#" + id[ 0 ] + "_" + ( name.substr(0, name.length - 2) )).css("display", "block");
                    $("#" + id[ 0 ] + "_" + ( name.substr(0, name.length - 2) ) + " table tr td input[name*='" + name + "']").each( function() {
                        $(this).attr("checked", true);
                    } )

                    var dialogo = $('#departamentos-municipios').dialog({
                        autoOpen: true,
                        show: 'fold',
                        hide: 'drop',
                        height : 400,
                        width : 600,
                        title : titulo,
                        buttons: {
                            Cancelar : function () {
                                $(this).dialog('close');

                                codigoDepartamento = $("#departamandosmMostrados").val();
                                $( codigoDepartamento + " table tr td input[name*='"+ name +"']").each( function() {
                                    $(this).attr("checked", false);
                                });
                                elemento = codigoDepartamento.substr( 0 , codigoDepartamento.length - 20 ) +"_"+ ( name.substr(0, name.length - 2) ) +"_"+ "chekear" ;
                                alert( elemento );
                                $( elemento  ).attr("checked", false);
                                id = ""
                            },
                            Aceptar: function() {
                                $(this).dialog('close');
                                id = "";
                            }
                        }

                    });

                    dialogo.css("text-align", "left");
                    dialogo.css("font-size", "15px");
                }
                    
            } );



        }
    } );

    $( "#departamentos-municipios" ).bind( "dialogclose", function(event, ui) {
        id = "";
        // Remueve la capa que se coloca encima de los elementos y no deja seleccionar nada.
        $("div[class='ui-effects-wrapper']").remove();
        chekeados = 0;
        codigoDepartamento = $("#departamandosmMostrados").val();
        $( codigoDepartamento ).hide();
        // Se comprueba la cantidad de checkbox seleccionados, si no hay ninguno, el departamnto al departamento
        // Se le quita la seleccion.
        $( codigoDepartamento + " table tr td input[name*='"+ name +"']").each( function() {
            if( $(this).attr("checked")) {
                chekeados++;
            }
        });
        codDepartamento = codigoDepartamento.split("_");
        if( chekeados == 0 ) {
            $( codDepartamento[ 0 ] + "_"+ ( name.substr(0, name.length - 2) ) +"_chekear" ).attr("checked", false);
        }
        $("#pruebas").val( chekeados );
    });
    //------------------------------------------------------------------------

    // Permite seleccionar grupos de checkbox.
    $("input[id*='seleccionarElementos']").click( function() {
        id = this.id;
        $("input[name='" + this.title + "']").each( function() {
            $(this).attr("checked", $("#" + id).attr("checked"));
        } );
    } );

    // Validacion del reporte en general.
    $("#generar-reporte").click( function() {
        
        // Validamos que almenos tengamos 1 variable para mostrar en el reporte
        haySeleccionados = false;
        $("input[name='seleccionados[]']").each( function() {
            if( $(this).attr("checked")){
                haySeleccionados = true;
            }
        } );
        if( ! haySeleccionados ) {
            $('#mensajes-usuario').dialog({
                autoOpen: true,
                show: 'fold',
                hide: 'drop',
                height : 250,
                width : 400,
                title : "Error de validaci&oacute;n",
                buttons : {
                    Aceptar : function( ) {
                        $(this).dialog('close');
                    }
                }

            });
            $('#mensajes-usuario').html('Seleccione al menos 1 variable para <br />incluir en el reporte.');
            return false;
        }
        $("#departamentos-municipios").parent().appendTo(jQuery("form:first"));
    


    } );


} );


