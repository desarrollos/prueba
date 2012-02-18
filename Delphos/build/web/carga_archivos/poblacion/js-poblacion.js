




$( document ).ready( function() {
    function procesarCriterio( criterio ){
        comenzarCriterio( criterio );
        $("#criterioSeleccionado").val( criterio );
    }
    function ocultuar_registroyregistros_coincidentes( estado ) {
        $("#registro").css("display", estado );
        $("#registros_coincidentes").css("display", estado);
    }
    function errorEncabezado() {
        $("#idEncabezado").dialog("close");
        $( "#encabezadoError" ).dialog({
            width : 500,
            height : 300,
            autoOpen: true,
            show: "highlight",
            hide: "explode",
            modal : true,
            buttons : {
                "Aceptar" : function() {
                    $( this ).dialog("close");
                }
            }
        });
    }

    function finAsistente() {
        $( "#finAsistente" ).dialog({
            width : 570,
            height : 180,
            autoOpen: true,
            show: "highlight",
            hide: "explode",
            title : "Confirmar",
            modal : true,
            buttons : {
                "Cancelar" : function() {
                    $( this ).dialog("close");

                },
                "FINALIZAR" : function() {
                    $( this ).dialog("close");
                    document.location.href = document.URL;

                }
            }

        });
    }
    function sin_registros() {
        $("#sin_registros" ).dialog({
            width : 800,
            height : 150,
            autoOpen: true,
            show: "highlight",
            hide: "explode",
            modal : true,
            title : "Error" ,
            buttons : {
                "Cerrar" : function( ) {
                    $( this ).dialog("close");
                }

            }
        });
    }

    function compararRegistro( dato, registroPoblacion ) {
        $.post('../todoInstancias', {
            'dato' : dato,
            'registroPoblacion' : registroPoblacion,
            'compararRegistro' : true,
            "cantidadColumnas" : $("#cantidadColumnasPoblacion").val(),
            "varsSelecColumnas" : $("form[id='varsSelecColumnas'] ").serialize()

        }, function( data ) {

            $("#registrosAComparar").html( data );

            $("#registrosAComparar" ).dialog({
                width : 800,
                height : 550,
                autoOpen: true,
                show: "highlight",
                hide: "explode",
                modal : true,
                title : "Coincidencias del registro seleccionado" ,
                buttons : {
                    "Cancelar" : function( ) {
                        $( this ).dialog("close");
                    },
                    "Procesar" : function() {
                        $("#advertenciaModificacionPoblacion" ).dialog({
                            width : 915,
                            height : 160,
                            autoOpen: true,
                            show: "highlight",
                            hide: "explode",
                            modal : true,
                            title : "Advertencia" ,
                            buttons : {
                                "Cancelar" : function( ) {
                                    $( this ).dialog("close");
                                },
                                "Si, deseo continuar" : function() {

                                    $.post('../todoInstancias', {
                                        'procesarComparacion' : true,
                                        "valores" : obtenerComparaciones(),
                                        "idusuario" : registroPoblacion
                                    }, function( data ) {
                                        $("#registrosAComparar").dialog("close");
                                        $("#dialog_registro_coincidente").dialog("close");
                                        $("#advertenciaModificacionPoblacion").dialog("close");
                                    
                                    
                                    });

                                
                                }
                            }
                        });

                    
                    }
                }
            });
        });



    }

    function obtenerComparaciones() {
        retorno = '';
        $("select[name*='regiComparado_']").each( function() {
            name = this.name;
            nameCorte = name.split("_");
            retorno +=  nameCorte[ 1 ] + " = '" + $(this).val() +"',";
        } );

        return retorno.substring(0, retorno.length - 1);
    }
    function estadoComparacion(  ) {
        if( $("#comparacion").val() == 'si' ){
            return true;
        }else {
            return false;
        }

    }


    function verCoincidentesDelRegistro( dato, pagina ) {
    

        $.post('../todoInstancias', {
            'reigstroCoincidente' : true,
            "cantidadColumnas" : $("#cantidadColumnasPoblacion").val(),
            "varsSelecColumnas" : $("form[id='varsSelecColumnas'] ").serialize(),
            "dato" : dato,
            "mostrar_primero" : true,
            "pagina" : pagina
        }, function( data ) {
            $("#dialog_registro_coincidente").html( data );

            $("#dialog_registro_coincidente" ).dialog({
                width : 800,
                height : 550,
                autoOpen: true,
                show: "highlight",
                hide: "explode",
                modal : true,
                title : "Coincidencias del registro seleccionado" ,
                buttons : {
                    "Cancelar" : function( ) {
                        $( this ).dialog("close");
                    }
                }
            });
        });

    
    }
    function establecerPosCampos() {
        if( $("#posCampos").val() == '' ) {
            posCampos();
        }
    }


    function obtenerSeleccioNuevos() {
        seleccion = "";
        $("input[name*='registro_nuevo']").each( function() {
            if( $(this).prop("checked") ) {
                seleccion += this.id + ",";
            }
        } )
        return seleccion.substring(0, seleccion.length - 1);

    }
    function paginaNuevos( pagina, encabezado ) {
        $.post('../todoInstancias', {
            'pagina' : pagina,
            'idencabezado' : encabezado,
            'registrosNuevosNovedades' : true,
            "cantidadColumnas" : $("#cantidadColumnasPoblacion").val(),
            "varsSelecColumnas" : $("form[id='varsSelecColumnas'] ").serialize()
        }, function( data ) {
            $("#registros_nuevos").html( data );
        });
    }
    function paginaCoincidencias( pagina, encabezado ) {
        $.post('../todoInstancias', {
            'pagina' : pagina,
            'idencabezado' : encabezado,
            'verCoincidencias' : true,
            "cantidadColumnas" : $("#cantidadColumnasPoblacion").val(),
            "varsSelecColumnas" : $("form[id='varsSelecColumnas'] ").serialize()
        }, function( data ) {
            $("#registros_nuevos").html( data );
        });
    }
    function mostrarRegistrosCoincidentes( encabezado ) {
        $.post('../todoInstancias', {
            'idencabezado' : encabezado,
            'verCoincidencias' : true,
            'devolver_paginador' : true,
            'idencabezado' : $("#numeroId").val(),
            "cantidadColumnas" : $("#cantidadColumnasPoblacion").val(),
            "varsSelecColumnas" : $("form[id='varsSelecColumnas'] ").serialize(),
            'colsSeleccionadas' : valorColumnasSeleccionadas()
        }, function( data ) {
            $("#opcion_seleccionada").html( data );

            $("#opcion_seleccionada" ).dialog({
                width : 900,
                height : 500,
                autoOpen: true,
                show: "highlight",
                hide: "explode",
                modal : true,
                title : "Coincidencias para el encabezado" ,
                buttons : {
                    "Seleccionar una opción diferente" : function( ) {
                    
                        $( this ).dialog("close");
                    }

                }
            });
    
        });
    }

    function confirmarCargarPoblacion() {
        $( "#confirmarCargarPoblacion" ).dialog({
            width : 570,
            height : 180,
            autoOpen: true,
            show: "highlight",
            hide: "explode",
            title : "Confirmar",
            modal : true,
            buttons : {
                "Aceptar" : function()  {
                    $(this).dialog("close");
                    return true;
                },
                "Cancelar" : function()  {
                    $(this).dialog("close");
                    return false;
                }
            }
        });



    }

    function mostrarRegistrosNuevos( encabezado ) {
        $.post('../todoInstancias', {
            'idencabezado' : encabezado,
            'registrosNuevosNovedades' : true,
            'devolver_paginador' : true,
            'idencabezado' : $("#numeroId").val(),
            "cantidadColumnas" : $("#cantidadColumnasPoblacion").val(),
            "varsSelecColumnas" : $("form[id='varsSelecColumnas'] ").serialize()
        }, function( data ) {
            $("#opcion_seleccionada").html( data );

            $("#opcion_seleccionada" ).dialog({
                width : 800,
                height : 500,
                autoOpen: true,
                show: "highlight",
                hide: "explode",
                modal : true,
                title : "Registros nuevos " ,
                buttons : {
                    "Seleccionar una opción diferente" : function( ) {
                        codigo = 'cambiarValorNuevo(' + encabezado + '); $("#cantidadRegistrosNuevos").attr("title", data); ';
                        cantidadNuevos( encabezado,codigo );

                        $( this ).dialog("close");
                    },
                    "Procesar solo seleccionados" : function() {
                        cant = 0;
                        $("input[name*='registro_nuevo']").each( function() {
                            if( $(this).prop("checked") ) {
                                cant++;
                            }
                        } )
                        if( cant > 0 ) {
                            // procesar seleccionados;
                            $.post("../todoInstancias", {
                                "registrarNuevos" : true,
                                "seleccionados" :obtenerSeleccioNuevos(),
                                "encabezado" : encabezado,
                                "cantidadColumnas" : $("#cantidadColumnasPoblacion").val(),
                                "varsSelecColumnas" : $("form[id='varsSelecColumnas'] ").serialize(),
                                "opcion" : "algunos"
                            }, function( data ){
                                codigo = ' if( parseInt( data ) > 0 ) { paginaNuevos( 1, encabezado ); } else { $("#opcion_seleccionada" ).dialog("close"); \n\
                            cambiarValorNuevo(' + encabezado + '); $("#cantidadRegistrosNuevos").attr("title", data); } ';
                                cantidadNuevos( encabezado,codigo );

                            

                            });

                        } else {

                            $("#seleccionarMasDeUnNuevo" ).dialog({
                                width : 600,
                                height : 150,
                                autoOpen: true,
                                show: "highlight",
                                hide: "explode",
                                modal : true,
                                title : "Error",
                                buttons : {
                                    "Aceptar" : function() {
                                        $(this).dialog("close");
                                    }

                                }
                            });


                        }

                    },
                    "Procesar todo" : function( ) {
                        $.post("../todoInstancias", {
                            "registrarNuevos" : true,
                            "opcion" : "todos",
                            "cantidadColumnas" : $("#cantidadColumnasPoblacion").val(),
                            "varsSelecColumnas" : $("form[id='varsSelecColumnas'] ").serialize(),
                            "encabezado" : encabezado
                        }, function( data ){
                            $("#opcion_seleccionada" ).dialog("close");
                            cambiarValorNuevo(encabezado);
                            $("#cantidadRegistrosNuevos").attr("title", 0);
                        });
                    }
                }
            });
        });
    }

    function cambiarValorNuevo( encabezado ) {
        codigo = '$("#cantidadRegistrosNuevos").val( "Registros nuevos ( " + parseInt( data ) + " )" );';
        cantidadNuevos( encabezado, codigo );
    }

    function cantidadNuevos( encabezado, codigo ) {
        $.post("../todoInstancias", {
            "cantidadNuevos" : true,
            "encabezado" : encabezado
        }, function( data ){
            eval( codigo );
        });
    }

    function comenzarCriterio( criterio ) {

        $.post("../GenerarNovedades", {
            "idencabezado" : $("#numeroId").val(),
            "posTipoIDCedula" : obtenerPosTipoIDCedula(),
            "posCampos" : $("#posCampos").val(),
            "cantidadColumnas" : $("#cantidadColumnasPoblacion").val(),
            "varsSelecColumnas" : $("form[id='varsSelecColumnas'] ").serialize(),
            "nombreArchivo" : $("#nombreArchivoPoblacion").val(),
            "fechasSeleccionadas"  : $("#elFormato").val(),
            "criterioSeleccionado" : 'liscamcrit' + criterio,
            "formatoFecha" :  $("#soloFechas").val(),
            "columnasSeleccionadas" : columnasSeleccionadas(),
            "soloTiposFechas" : $("#tiposFecha").val()
        
        }, function( data ) {
            // Genero la cantidad el boton que permite selecciona la cantidad de datos nuevos...
            botones = ''
            $.post('../todoInstancias', {
                'productosNovedades' : true,
                'idencabezado' : $("#numeroId").val()
            }, function( data ) {
                $("#criterio_busqueda_resultado").html( data );

                $("#criterio_busqueda_resultado" ).dialog({
                    width : 600,
                    height : 350,
                    autoOpen: true,
                    show: "highlight",
                    hide: "explode",
                    modal : true,
                    title : "Usted selecciono el criterio de busqueda " + criterio ,
                    buttons : {
                        "Salir" : function() {
                            $( this ).dialog("close"); 
                        }
                    /*"Intentar con otro criterio" : function( ) {

                        $("#si_selecciona_otro_criterio" ).dialog({
                            width : 678,
                            height : 200,
                            autoOpen: true,
                            show: "highlight",
                            hide: "explode",
                            modal : true,
                            title : "Tenga cuidado con su selección",
                            buttons : {
                                "Aceptar" : function() {
                                    $("#criterio_busqueda_resultado").dialog("close");
                                    $.post('../todoInstancias', {
                                        'criterioDiferrente' : true,
                                        'encabezado' : $("#numeroId").val(),
                                        "nombreArchivo" : $("#nombreArchivoPoblacion").val()
                                        
                                    }, function( data ) {
                                        
                                        });

                                    $( this ).dialog("close");
                                },
                                "Cancelar" : function() {
                                    // Lanzar aqui el codigo para que  se haga el rollback
                                    $( this ).dialog("close");
                                }
                            }
                        });

                    }*/
                    }
                });
            });
        });

    }

    function fechaColumnas( columna ) {
        fecha = "";
        $("#tablaColumnas tr:gt(1):lt(5)").each( function() {
            fecha += "<tr><td>Feha columna "+ ( columna + 1 ) +"</td><td>" + $(this).find('td:eq('+ columna +')').html() + "</td></tr>";
        } );
        return fecha;
    }
    function formatoInvalido() {
        var dma1 =  $("select[name*='dma1']").val();
        var dma2 =  $("select[name*='dma2']").val();
        var dma3 =  $("select[name*='dma3']").val();

        if( dma1 == dma2 || dma1 == dma3 || dma2 == dma1 || dma2 == dma3 || dma3 == dma1 || dma3 == dma2  ) {
            return true;
        }
        return false;
    
    }
    function formatoFecha( columna, titulo ) {
        
        
        if( $("#columna" + parseInt(columna)).val() == -1 ) {
            $("#diferenteDeIgnorar" ).dialog({
                width : 600,
                height : 200,
                autoOpen: true,
                show: "highlight",
                hide: "explode",
                modal : true,
                title : "Error",
                buttons : {
                    "Aceptar" : function() {
                        $(this).dialog("close")
                    }

                }
            });
        } else{

            titulo = titulo.split('_');
            
            if( titulo[ 0 ] == 'imgColumna' ) {
        
                $("#formatoFecha").html('<table><tr><td>Delimitador fecha</td><td><label> ; <input type="radio" name="formatoFechaColumnas" value=";" /></label><label>" , "<input type="radio" name="formatoFechaColumnas" value="," /></label>'+
                    '<label>" | "<input type="radio" name="formatoFechaColumnas" value="|" /></label>'+
                    '<label>" / "<input type="radio" name="formatoFechaColumnas" value="/" checked /></label>'+
                    '<label>" - "<input type="radio" name="formatoFechaColumnas" value="-" /></label>'+
                    '<label>Otro<input type="radio" name="formatoFechaColumnas" value="otro" /><input type="text" size="2" name="otro_formatoFechaColumnas" id="otro_formatoFechaColumnas" /></label>'+
                    '</td>' + fechaColumnas( columna ) + '<td>Seleccione formato</td><td>'+
                    '<select name="dma1" id="dma1"><option value="DD" selected>Dia</option>'+
                    '<option value="MM">Mes</option><option value="AAAA">A&ntilde;o</option></select>'+
                    '<select name="dma2" id="dma2"><option value="DD">Dia</option>'+
                    '<option value="MM" selected>Mes</option><option value="AAAA">A&ntilde;o</option></select>'+
                    '<select name="dma3" id="dma3"><option value="DD">Dia</option>'+
                    '<option value="MM">Mes</option><option value="AAAA" selected>A&ntilde;o</option></select>'+
                    '<td id="formato" class="ui-state-error ui-corner-all" style="padding: 0 .7em;display: block !important; ">  </td>'
                    +'</tr></table>');

                $("#formatoFecha" ).dialog({
                    width : 600,
                    height : 400,
                    autoOpen: true,
                    show: "highlight",
                    hide: "explode",
                    modal : true,
                    title : "Columna: " + (parseInt(columna) + 1),
                    buttons : {
                        "Cancelar" : function() {
                            $( this ).dialog("close");
                        },
                    
                        "Aceptar" : function() {
                            if( ! formatoInvalido() ) {
                                agregarFormato( columna );
                                $("img[title='imgColumna_"+ columna +"']").attr('src', '../carga_archivos/poblacion/img/cancel_fecha.png');
                                $("img[title='imgColumna_"+ columna +"']").attr('title', 'imgColumnaCancelar_' +  columna);
                                $( this ).dialog("close");
                                $("#formato td").html('');
                                $("#formatoFecha").html('');
                            } else {
                                $("td[id*='formato']").html('Formato Invalido');
                        
                            }
                    
                
                        }

                    }
                });
            } else if( titulo[ 0 ] == 'imgColumnaCancelar' ) {
        
                $("img[title='"+ titulo[ 0 ] +"_"+ titulo[ 1 ] +"']").attr('src', '../carga_archivos/poblacion/img/fecha.png');
                $("img[title='"+ titulo[ 0 ] +"_"+ titulo[ 1 ] +"']").attr('title', 'imgColumna_' +  columna );
                quitarFormato( columna  );
            }

        }

    }

    function agregarFormato( columna ) {
        delimitador =   $("input[name='formatoFechaColumnas']:checked").val() == 'otro' ? $("#otro_formatoFechaColumnas").val() : $("input[name='formatoFechaColumnas']:checked").val() ;
        var1 = $("#dma1").val();
        var2 = $("#dma2").val();
        var3 = $("#dma3").val();
        var formato = $("#elFormato").val( );


        $("#soloFechas").val( columna + ',' + $("#soloFechas").val()  );


        //columna = $("#columna" + columna).val();
    
        valorActualTiposFecha = $("#tiposFecha").val();
        tipoFecha = $("#columna" + columna).val();
        $("#tiposFecha").val( valorActualTiposFecha + ( valorActualTiposFecha == '' ? '' : ',' )  + tipoFecha.substring(0, tipoFecha.length - 2 ) );


        $("#elFormato").val( formato + ( formato == '' ? '' : ',' ) +  + columna + ":" + delimitador + ":" + var1 + ":" + var2 + ":" + var3  );
    }

    function quitarFormato( columna ) {
        
        // Quitar en formatoFecha
        var seleccion =  $("#soloFechas").val();
        seleccion = seleccion.split(',');
        var seleccionPos = seleccion.indexOf( columna );
        delete seleccion[ seleccionPos ];
        $("#soloFechas").val( seleccion.join(",") );
        
        

        var formato = $("#elFormato").val();
        formato = formato.split(",");
        for(  n = 0; n < formato.length; n++ ) {
            posCol = formato[n ] .split(":");
            if( columna == posCol[ 0 ] ) {
               break; 
            }
        }
        delete formato[ n ];
        $("#elFormato").val( formato.join(",") );
        
        
        // fechaAquitar
        var fecha = $("#columna" + columna).val();
        
        // Fechas seleccionadas
        var fechaSeleccionadas = $("#tiposFecha").val();
        fechaSeleccionadas = fechaSeleccionadas.split(",");
        
        posFecha = fechaSeleccionadas.indexOf( ( fecha.substring( 0, fecha.length - 2 ) ) );
        
        
        delete fechaSeleccionadas[ posFecha ];
        $("#tiposFecha").val( fechaSeleccionadas.join(",") );
        
    }
    function obtenerPosTipoIDCedula() {
        pos = 0;
        mostrar = "";
        $("select[name*='columna']").each( function(){
            //alert( this.value );
            if( this.value == 2154.0 ) {
                mostrar +=  pos +'-codtipoidentafiliado' + ";";
            }
            if( this.value == 2199.0 ) {
                mostrar += pos + '-numeroidentafiliado' + ";";
            }
            pos++;
        } );
        return mostrar;
    }
    function todasLasPosiciones() {
        pos = 0;
        mostrar = "";
        $("select[name*='columna']").each( function(){
            if( this.value != 2154.0 && this.value != 2199.0 && this.value != -1 ) {
                posicion = $(this).val();
                posicion = posicion.toString().split(".");
                mostrar += posicion[ 0 ] + ",";
            }
            pos++;
        } );
        return mostrar.substring( 0 , mostrar.length - 1);

    }
    function posCampos() {
        //alert( "TODAS LAS POSICIONES: " + todasLasPosiciones() );
        $.post('../todoInstancias', {
            'posicionesCampos' : true,
            'campos' : todasLasPosiciones()
        }, function( data ) {
            retorno = "";
            //alert("DATA : " + data);
            camposTodo = data;
            camposTodo = camposTodo.split(";");
            for( n = 0; n < camposTodo.length; n++ ) {
                campo = camposTodo[ n ].split('-');
                pos = 0;
                $("select[name*='columna']").each( function(){
                    if( this.value != 2154.0 && this.value != 2199.0 && this.value != -1 ) {
                        if( (campo[ 0 ] +  '.0') == $(this).val() ) {
                            retorno += pos + "-" + campo[ 1 ] + ";";
                            return true;
                        }
                    }
                    pos++;
                } );
            }
            //alert("TODO RETORNO : " + retorno.substring( 0 , retorno.length - 1 ));
            $("#posCampos").val( retorno.substring( 0 , retorno.length - 1 ));
        });
    }
    function valorColumnasSeleccionadas() {
        retorno = "";
        $("select[name*='columna']").each( function(){
            if( this.value != -1 ) {
                retorno += $(this).val() + ",";
            }
        
        });
        return retorno.substring( 0 , retorno.length -1);
    }
    function seleccionarCoincidentes() {
    
    }
    function seleccionarNuevos() {
        estado = $("#seleccionarTodosLosNuevos").prop("checked");
        $("input[name*='registro_nuevo_']").each(  function() {
            $(this).prop("checked", (estado == false ? false : true));
        } )
    }

    function obtenerDelimitador(  ) {
        return $("#todoDelimitador").val();
    }    
    
    
    function revertirSeleccion( tipoRip ){
        if( tipoRip != "" ) {
            dialogSubidaRips( $("#ripActual").val() );
        } else {
            revertirSeleccionPoblacion();
        }
    }
    
    
    $("input[id*='revertirSel_']").live('click', function(  ) {
        rip = this.id;
        rip = rip.split("_");
        revertirSeleccion( rip[ 1 ] );
    } );
    $("#ignorar_to").live('click', function(  ) {
        ignorar_todos();
    } );
    
    $("img[id*='calendarioFecha_']").live('click', function(  ) {
        id = this.id;
        id = id.split("_");
        formatoFecha( id[ 1 ], this.title );
    } );
    
    
    
    $("#mostrarEncabezados").click( function(  ) {
            
        });
    //        width = 800;
    //        heght = 600;
    //        $("#encabezadosContenedor").html("<div id=\"encabezados\">encabezados</div>");
    //        $("#encabezados").flexigrid({
    //            height: 800,
    //            width : 600,
    //            colModel : [
    //            {
    //                display: 'ID encabezado', 
    //                name : 'id', 
    //                width: 120, 
    //                sortable : true
    //            }  
    //            ],
    //            buttons : [
    //            {
    //                name : 'Bototn 1'
    //            }
    //            ],
    //            searchitems : [
    //            {
    //                display : 'ID encabezado', 
    //                name : 'idencabezado', 
    //                isdefault : true
    //            }
    //            ]
    //        });
    //        
    //        $( "#encabezadosContenedor" ).dialog({
    //            title : "Encabezados registrados en la base de datos",
    //            width : width,
    //            height : heght,
    //            autoOpen: true,
    //            show: "highlight",
    //            hide: "explode",
    //            modal : true,
    //            buttons : {
    //                "Cerrar" : function() {
    //                    $( this ).dialog("close");
    //                }
    //            }
    //        });
    //        $("#encabezadosContenedor").scrollTop(0);
        
        
    // } );
    //    function mostrarEncabezados() {
    //        flexiEncuentroreunion ={
    //            url : '../edinstancias?parametros=opcion=tabla-tabla=encabezadoarchivo-seleccionar=si-modificar=no-eliminar=no-principal=idencabezado-seleccion=codregimenes',
    //            dataType : 'xml',
    //            height: 280,
    //            width : 850,
    //            usepager : true,
    //            rp : 30,
    //            sortname: 'codregimenes',
    //            sortorder: 'asc',
    //            buttons : [{
    //                name : 'Agregar Nuevo Encuentro o Reunion',
    //                bclass : 'anadir'
    //            }]
    //        };
    //        tabla(flexiUsuarios, 'Usuarios Sistema', '' );
    //    }

    $("#ajaxError").ajaxError( function( e, html ){
        $("#dialogError").html('Se produjo un error... disculpa las molestias ...<br /><a href="../descargarArchivo?nombreArchivo=log.txt&id='+ $("#idencabezado").val() +'"><img src=\"../images/descargar.png\" title=\"Descargar datos Inconsistentes\" alt=\"Descargar\"/></a>');
        dialogError();
    //alert("Se produjo un error... disculpa las molestias ...");
    } );

    var dialogError = function() {
        $( "#dialogError" ).dialog({
            width : 570,
            height : 180,
            autoOpen: true,
            show: "highlight",
            hide: "explode",
            modal : true,
            buttons : {
                "Aceptar" : function() {
                    $( this ).dialog("close");
                }
            }
        });
    }


    $("#todoDelimitador").val(',');
    $("input[name*='otroDelimitador']").keypress( function( event ) {
        $("#todoDelimitador").val( String.fromCharCode(event.which) );
    } );

    $("input[name*='delimitador']").click( function() {
        delimitador = $(this).val();
        if( delimitador != 'otro' ) {
            $("#todoDelimitador").val( delimitador );
        }
    } );

    var mostrandoInconNovedades = function(  encabezado, nombreArchivo ) {
        $.post('../todoInstancias', {
            'incon_nove' : 'si',
            'encabezado' : encabezado,
            'nombreArchivo' : nombreArchivo,
            'colsSeleccionadas' : valorColumnasSeleccionadas()
        }, function( data ) {
            $( data ).find("incon_nove").each( function(  ) {
                var $incon_nove = $( this );
                $incon_nove.find( "datos" ).each( function() {
                    var $dato = $( this );
                    id = $dato.attr('id');
                    contenido = $dato.text();
                    $( id ).html( contenido );
                });

            });
        });
    }
    columnasSeleccionadas = function() {
        pos = 0;
        seleccionados = "";
        $("select[name*='columna']").each( function(){
            if( $(this).prop("selectedIndex") != 0 && $(this).prop("selectedIndex") != 1 ){
                seleccionados += this.title + ',';

            }

        } );
        return seleccionados.substr(0, seleccionados.length - 1);
    }
    var  seleccionArchivosASubir = function() {
        if( $("#tipoRip").val() == 'ips' ){
            $("#capa_AV").css("display", "none");
        }
        
        
        $( "#seleccionArchivosASubir" ).dialog({
            width : 570,
            height : 450,
            autoOpen: true,
            show: "highlight",
            hide: "explode",
            modal : true,
            title : "Seleccion personalizada",
            close : function( ){
                
                
            },
            buttons : {
                "Aceptar" : function() {
                    if(oglibarParaQueSubaElDetalle()) {
                        mostrarSoloSeleccionados();
                        // Continua mostrando Subida De Rips mientas que haya queden.
                        dialogSubidaRips('');
                        $(this).dialog('close');
                    } else {
                        
                        $( "#seleccioneDetalle" ).dialog({
                            width : 570,
                            height : 180,
                            autoOpen: true,
                            show: "highlight",
                            hide: "explode",
                            modal : true,
                            buttons : {
                                "Aceptar" : function() {
                                    $( this ).dialog("close");
                                        

                                    
                                }
                            }
                        });
                        
                    }


                }
            }
        });
    }    
    var poblacionRipCargado = function( encabezado, nombreArchivo ){
        $("#poblacionRipCargado" ).dialog({
            width : 400,
            height : 200,
            autoOpen: true,
            show: "highlight",
            hide: "explode",
            modal : true,
            buttons : {
                "Aceptar" : function() {
                    $( this ).dialog("close");
                    dejarAvanzarTab('si');
                    avanzarPosicion();
                    dejarAvanzarTab('no');
                    mostrandoInconNovedades(  encabezado, nombreArchivo  );
                }
            }
        });

    };
    $("input[title*='lineasMostrar']").click( function()  {
        $("#avanzarObligatorio").val('no');
        $(".primerasLineas").html('');
        $.post('../mostrarPrimerasLineas', {
            'nombreArchivo' : $( this.alt ).val()
        }, function( data ){
            $(".primerasLineas").html( data );
        });

    });
    var valoresSeleccionadosCombos = function( diferenteDe ) {
        seleccionados = "";
        $("select[name*='columna']").each( function(){
            if( diferenteDe != this.title ){
                seleccionados += $(this).val() +  ",";
            }
        });

        return seleccionados.substr(0, seleccionados.length - 1 );
    };
    var pintarCombosYaSeleccionados = function( seleccionados, combo ) {
        options = seleccionados.split(',');
        for( n = 0; n < options.length ; n++ ) {
            if( options[ n ] != -1 ) {
                $("option[value='" + options[ n ] + "']").css('background', '#DBE780');
            }
        }

        
    }
    $("select[id*='columna']").live(  {
        click : function() {
            selectIndexAnterior(this.id, this.title);
        },
        change : function( ) {
            seleccionColumnasValidar( this.id, this.title );
        }
    } );
    function selectIndexAnterior( id, pos ) {
        $("#selectIndexAnterior").val( $("#" + id).prop("selectedIndex") );
        $("#selectOption").val( $("#" + id).val() );
        pintarCombosYaSeleccionados( valoresSeleccionadosCombos( pos ), id );
    // Obtento todos los elementos seleccionados en los demas combos
        
    }

    seleccionColumnasValidar = function(idActual, posActual) {
        
        pos = 0;
        error = false;

        $("select[name*='columna']").each( function(){
            if( posActual != pos && ! error ) {
                seleccionada = $("#columna" + posActual).val();
                actual = $("#columna" + pos ).val();
                if(  actual ==  seleccionada  && ( actual != -1 && actual != "" ) ) {
                    $("#errorColumnaRepetida").html("La columna actualmente seleccionada: " + (posActual + 1) +  " Es igual a la columna: " + (pos + 1) + "\n\n\
                    La selecci&oacute;n volvera al estado anterior.");
                    errorColumnaRepetida();
                    // vuelve al estado anterior
                    $("#" + idActual).prop("selectedIndex", $("#selectIndexAnterior").val());
                    error = true;

                } else {
                    $("option[value='"+ $("#selectOption").val() +"']").css('background', '#FFFFFF');
                }
            }
            
            pos++;
        } );
    };
    
    $("#codregimen").change( function( ){
        $("#codtipoestrucarch").val( $(this).val() );
    } );
    // No permite que el usuaruo seleccione otro tab diferente de donde se encuentra
    var dejarAvanzarTab = function( valor ) {
        $("#noAvanzarConTab").val( valor );
    //$("#noAvanzarConTab").val('si');
    }

    var dejarGuardarEncabezado = function( valor ) {
        $("#noReGuardarMismoEncabezado").val( valor );
    }

    var accionNoPermitida = function() {
        $( "#noPermitido" ).dialog({
            width : 570,
            height : 180,
            autoOpen: true,
            show: "highlight",
            hide: "explode",
            modal : true,
            buttons : {
                "Aceptar" : function() {
                    $( this ).dialog("close");
                    if( $("#noReGuardarMismoEncabezado").val() == 'no' ) {

                }
                }
            }
        });
    }
    $("#ajaxStart").ajaxStart( function() {
        $( this ).dialog({
            width : 400,
            height : 200,
            autoOpen: true,
            show: "highlight",
            hide: "explode",
            modal : true,
            zIndex: 5000
        } );
    });
    $("#ajaxStart").ajaxStop( function() {
        $( this ).dialog("close");
    });
    function errorColumnaRepetida() {
        $( "#errorColumnaRepetida" ).dialog({
            width : 570,
            height : 180,
            autoOpen: true,
            show: "highlight",
            hide: "explode",
            modal : true,
            title : "Selección de columnas repetidas",
            buttons : {
                "Aceptar" : function() {
                    $( this ).dialog("close");
                }
            }
        });
    }
    //    $("#ajaxStart").ajaxError( function( e ) {
    //        alert( "Error" );
    //    });
    function identificacionYCedula() {
        tipoId = false;
        cedula = false;
        $("select[name*='columna']").each( function(){
            if( $(this).val() == 2154.0 ) {
                tipoId = true;
            }
            if( $(this).val() == 2199.0 ) {
                cedula = true;
            }
        });
        if( ! tipoId || ! cedula ) {
            $( "#seleccioneTipoIdCedula" ).dialog({
                width : 570,
                height : 180,
                autoOpen: true,
                show: "highlight",
                hide: "explode",
                title : "Confirmar",
                modal : true,
                buttons : {

                    "Cancelar" : function() {

                        $( this ).dialog("close");


                    },
                    "Aceptar" : function() {
                        
                           
                        $( this ).dialog("close");
                    }

                }
            });
            

        }
        return tipoId && cedula ? true : false;
    }

    function seleccionarElTab( posicion ) {
        dejarAvanzarTab('si');
        $("#tabs").tabs("option", "selected", posicion );
        dejarAvanzarTab('no');
    }

    function guardarEncabezado( tipoAgregarModificar ) {
        //alert("Entra 1")
        // En tiempo de ejecucion esta variable cambia de estado con el fin de dejar actualizar el encabezado
        // Cambia mas abajo antes de  registrar_actualizar( null );

        var registrarEncabezado = true;
        if( tabsSeleccionado() == 1 ) {
            $("#avanzarObligatorio").val('si');
        }
        if( tabsSeleccionado() == 3 ) {
            
            finAsistente();
        }
        if( tipoAgregarModificar == "registrar" && tabsSeleccionado() == 0  ) {
            if( $("#noReGuardarMismoEncabezado").val() != 'si' && $("#noAvanzarConTab").val() == 'no' ) {
                accionNoPermitida();
                return 0;
            }
            if( $("#noReGuardarMismoEncabezado").val() == 'no' && $("#noAvanzarConTab").val() == 'si') {
                registrarEncabezado = false;
            //dejarAvanzarTab('si');
            //avanzarPosicion();
            //dejarAvanzarTab('no');
            //return 0;
            }
            //alert("Entra 2 " + tipoAgregarModificar)
            registrar_actualizar( registrarEncabezado );
            // Se llama automaticamente AjaxStop cuando finaliza la peticion
            $("#stopAjaxRegistrarEncabezado").ajaxStop( function() {
                //alert("Entra 3 " + tipoAgregarModificar)
                
                if( tabsSeleccionado() == 0 ) {
                     
                    if( $("#error").val() == 0 ) {
                        if( tipoAgregarModificar == "registrar" && $("#idencabezado").val() != 0 ) {
                            
                            dejarGuardarEncabezado('no');

                            if( $("input[@name='tipoCarga']:checked").val() == 'CargarPoblacion') {
                                $("#mostrarCargaRips").css("display", "none");
                                $("#mostrarCargaPoblacion").css("display", "block");
                            } else if($("input[@name='tipoCarga']:checked").val() == 'CargarRips') {
                                $("#mostrarCargaPoblacion").css("display", "none");
                                $("#mostrarCargaRips").css("display", "block");
                            }

                            // Muestra la barra estatica
                            $("#idEncabezadoParaReporte").css("display", "block");

                          
                            $( "#idEncabezado" ).dialog({
                                width : 500,
                                height : 300,
                                autoOpen: true,
                                show: "highlight",
                                hide: "explode",
                                modal : true,
                                close : function() {

                                },
                                buttons : {
                                    "Aceptar" : function() {
                                        
                                        borrarAletrasCampos();
                                        $( this ).dialog("close");
                                        dejarAvanzarTab('si');
                                        avanzarPosicion();
                                        dejarAvanzarTab('no');
                                        
                                    },
                                    "Generar PDF" : function() {
                                        generarImprimible();
                                        $( this ).dialog("close");
                                    }
                                }
                            });
                            
                            

                            
                        } else {
                            
                    }
                    //
                    }
                    else if( $("#error").val() == 1 ) {
                // verificarCampos();
                }
                //
                } else if( tabsSeleccionado() == 1 && $("#tipoRip").val() == '' && $("#avanzarObligatorio").val() == 'si') {
                    if( $("#error").val( ) == 0 ) {
                        dejarAvanzarTab('si');
                        avanzarPosicion();
                        seleccionarColumnas('');
                        dejarAvanzarTab('no');
                    } else if( $("#error").val( ) == 1 ) {
                        verificarCampos();
                    }
                }
            } );

        }
        else if( tipoAgregarModificar == "registrar" && tabsSeleccionado() == 1 && $("#tipoRip").val() != ''  ){
            // if (identificacionYCedula() ) {
            // Cuando ya se tienen seleccionadas las columnas se presiona en siguiente,
            // eso asi que se inserten los registros de rips
            $("#error").val( 0 );
            //alert("hola: " + $("#cantidadColumnasRips").val());
            $.post('../CargarRips', {
                "idencabezado" : $("#numeroId").val(),
                "cantidadArchivos" : $("#cantidadArchivos").val(),
                "nombreArchivo" : $("#archivoRip_" + traemeRipActual()).val(),
                "delimitador" : obtenerDelimitador(),
                "codtipoestrucarch" : $("#codtipoestrucarch").val(),
                "accion" : $("#accion").val(),
                "tipoRip" : $("#tipoRip_" + traemeRipActual()).val(),
                "tipoRips" : $("#tipoRip").val(),
                "cantidadColumnas" : $("#cantidadColumnasRips").val(),
                "varsSelecColumnas" : $("form[id='varsSelecColumnas'] ").serialize(),
                "columnasSeleccionadas" : columnasSeleccionadas(),
                "formatoFecha" :  $("#elFormato").val(),
                "codregimen" : $("#codregimen").val(),
                "ripsValida" : $("#ripsValida").val(),
                "tipoCarga" : $("input[@name='tipoCarga']:checked").val(),
                'tipo' : 'none',
                'fechaenvio' : $("#fechaenvio").val(),
                "totalColumnas" : $("#totalReal").val()

            }, function( data ) {
                //aqui
                dialogSubidaRips('');
                $("#elFormato").val('');
                            
            // $(( tipoRip == '' ? '#contenido-tab-3' : '#contenido-tab-2' )).html( $(this).text() );
                            
            });            
            
        //            $( "#confirmarCargaArchivos" ).dialog({
        //                width : 570,
        //                height : 180,
        //                autoOpen: true,
        //                show: "highlight",
        //                hide: "explode",
        //                title : "Confirmar",
        //                modal : true,
        //                buttons : {
        //
        //                    "Cancelar" : function() {
        //                        $( this ).dialog("close");
        //                        
        //                    },
        //                    "Aceptar" : function() {
        //                        // Solo entra en la siguiente funcion mientas se ha "poblacion" el seleccionado.
        //                        
        //                        // Se llama automaticamente AjaxStop cuando finaliza la peticion
        //                        $( this ).dialog("close");
        //                    }
        //
        //                }
        //            });
        // }



        }
        else if ( tipoAgregarModificar == "registrar" && tabsSeleccionado() == 1 ) {
            
            $("#error").val( 0 );
            subirPoblacion();
            
        } else if ( tipoAgregarModificar == "registrar" && tabsSeleccionado() == 2 ) {
            if (identificacionYCedula() ) {
                $("#error").val( 0 );
                
                //                $( "#confirmarCargaArchivos" ).dialog({
                //                    width : 570,
                //                    height : 180,
                //                    autoOpen: true,
                //                    show: "highlight",
                //                    hide: "explode",
                //                    title : "Confirmar",
                //                    modal : true,
                //                    buttons : {
                //
                //                        "Cancelar" : function() {
                //
                //                            $( this ).dialog("close");
                //                        
                //
                //                        },
                //                        "Aceptar" : function() {
                $.post("../CargarPoblacion", {
                    "idencabezado" : $("#numeroId").val(),
                    "nombreArchivo" : $("#nombreArchivoPoblacion").val(),
                    "delimitador" : obtenerDelimitador(),
                    "codtipoestrucarch" : $("#codtipoestrucarchPoblacion").val(),
                    "cantidadColumnas" : $("#cantidadColumnasPoblacion").val(),
                    "varsSelecColumnas" : $("form[id='varsSelecColumnas'] ").serialize(),
                    "codregimen" : $("#codregimen").val(),
                    "columnasSeleccionadas" : columnasSeleccionadas(),
                    "formatoFecha" :  $("#elFormato").val(),
                    "tipoCarga" : $("input[@name='tipoCarga']:checked").val(),
                    "totalColumnas" : $("#totalReal").val()
                                

                }, function( data ) {
                    poblacionRipCargado( $("#numeroId").val(), $("#nombreArchivoPoblacion").val() );
                //$("#elFormato").val('');
                });

            //              $( this ).dialog("close");
            //         }
                    
            //        }
            //      });
            }

         
        // Se llama automaticamente AjaxStop cuando finaliza la peticion

        }
    // Aqui cargaria el rip
        
    }
    function ignorar_todos() {
        
        $("select[name*='columna']").each( function(){
            $(this).prop("selectedIndex", 1);
            $( "#" + this.id + " option" ).css("background", "#FFFFFF");
        } );


    };
    function revertirSeleccionPoblacion() {
        $(".primerasLineas").html("");
        $("#id_delimitador").css("display", "none");
        $("#id_nombreArchivo2").css("display", "none");
        $("#varsSelecColumnas").html("");
        $("#contenido-tab-3").html("");
        //$("#nombreArchivo2").val("");
        dejarAvanzarTab('si');
        $("#tabs").tabs("option", "selected", 1 );
        dejarAvanzarTab('no');
        $("#mostrarCargaPoblacion").css("display", "block");
    }
   

    function seleccionarColumnasMostrarlas( tipoRip )  {
        
        
        
        $.post("../SeleccionarColumnas", {
            "datosFormulario" : $("form[id='ripsForm'], form[id='datosFormulario'] ").serialize(),
            "nombreArchivo" : $("#nombreArchivo2").val(),
            "delimitador" : obtenerDelimitador(),
            "otroDelimitador" : obtenerDelimitador(),
            "codregimen" : $("#codregimen").val(), 
            "idencabezado" : $("#numeroId").val(),
            "accion" : $("#accion").val(),
            "rip" : tipoRip,
            "delimitador_rip"  :  obtenerDelimitador(),
            "tipoRip" : $("#tipoRip").val(),
            "archivoRip" : $("#archivoRip").val()

        }, function( data ) {
            $( data ).find("contenido").each( function() {
                var $contenido = $(this);
                continuar = '<input type=\"submit\" value=\"Continuar con el siguiente Rip: "+ siguienteRip() +"\" name=\"siguienteRip\" onclick=\"actualizarRipActual();continuarSiguienteRip()\">';
                
                $contenido.find("html").each( function() {
                    $(( tipoRip == '' ? '#contenido-tab-3' : '#contenido-tab-2' )).html(
                        "<fieldset><legend>Subiendo actualmente un archivo tipo: <strong>" + ( tipoRip == '' ? ' Poblaci&oacute;n' :tipoRip) +"</strong></legend><input type=\"button\" class=\"botonJquery\" name=\"revertir\" id=\"revertirSel_"+ tipoRip +"\" value=\"Revertir la selecci&oacute;n del archivo actual\" />\n\
                        <input type=\"button\" class=\"botonJquery\" name=\"ingnorar_todos\" id=\"ignorar_to\" value=\"Ignorar todos\" />" +
                        /* tipoRip != '' ? continuar : '' +*/
                        $(this).text() + "</fieldset>");
                });

            } );
            //$("#ajaxStart").dialog("close");
            // Escondo la capa para cuando se vuelva a mostrar si seleccionan mas rips
            $("#rips_" + tipoRip).css("display", "none");
        //$("#archivoRip_" + tipoRip).val("");
        }, "xml");
    };

    function seleccionarColumnas( tipoRip ) {
        if( tipoRip == '' ) {
            seleccionarColumnasMostrarlas( tipoRip );
        } else {
            $.post("../todoInstancias", {
                "actualRip" : traemeRipActual(),
                "nombreArchivo" : $("#nombreArchivo2").val(),
                "validaRips" : "si"
            }, function( data ){
                if(  data == 0 ) {
                    $("#id_archivoRip_" + traemeRipActual()).css("display", "block");
                    $("#id_archivoRip_" + traemeRipActual()).html("Archivo rip no valido");
                } else {
                    $("#subidaRips").dialog("close");
                    seleccionarColumnasMostrarlas( tipoRip );
                }
            }, "html");
        }


    }
    function subirRips() {
        $.post("../ServletEncabezadoValida", {
            "tipoValidacion" : "rips",
            "ripsForm" : $("form[id='ripsForm']").serialize()
        }, function( data ) {
            $( data ).find("errores").each( function(  ) {
                var $errores = $( this );
                leerXML( $errores );
            });
            $("#subidaRips").dialog("close");
            dialogSubidaRips('');
        });
    }
    function subirPoblacion() {
        // Poblacion
        if( $("#tipoRip").val() == '' ) {
            $.post("../ServletEncabezadoValida", {
                "tipoValidacion" : "poblacionRips",
                "nombreArchivo2" : $("#nombreArchivo2").val(),
                "delimitador" : obtenerDelimitador(),
                "otroDelimitador" : obtenerDelimitador()
            }, function( data ) {
                $( data ).find("errores").each( function(  ) {
                    var $errores = $( this );
                    leerXML( $errores );
                
                });
            });
        // Rips
        }
    }
    function cantidaValoresRipsEstadoSi() {
        cant = 0;
        $("input[id*='siguienteRip_']").each( function() {
            rip = this.id;
            rip = rip.split('_');

            if( this.value == 'si' && ! estaEnRipsSubidos( rip[ 1 ] ) ) {
                cant++;
            }
        });
        return cant;
    }
    function cambiarValorPosicionRip( id, valor ) {
        $( id ).val( valor );
        
    }
    function sonObligatorios( actual ) {
        $( actual ).click( function() {
            $(this).prop("checked", true );
        } )
    }
    function seleccionDeRips() {
        sonObligatorios();
        $("input[name*='ripsSeleccionados']").each( function() {
            seleccionar = false;
            if( this.alt == 'US' || ( $('#tipoRip').val() == 'ips' && this.alt == 'AF' ) ){
                seleccionar = true;
                sonObligatorios($(this));

            }
            $(this).prop("checked", seleccionar);
        });
    }
    function estaEnRipsSubidos( rip  ) {
        ripsSubidos = $("#ripsSubidos").val().split('-');
        existe = false
        for( n = 0; n < ripsSubidos.length; n++ ) {
            if( rip == ripsSubidos[ n ] && rip != '' ) {
                existe = true;
                break;
            }

        }
        return existe;
    }
    function mostrarSoloSeleccionados() {
        $("input[name*='ripsSeleccionados']").each( function() {
            cambiarValorPosicionRip( "#siguienteRip_" + this.alt, $(this).prop('checked') ? 'si' : 'no' );
        });

    }
    function traemeRipActual(  ) {
        return $("#ripActual").val();
    }
    function oglibarParaQueSubaElDetalle() {
        cantidad = 0;
        resultado = false;
        $("input[name*='ripsSeleccionados']").each( function() {
            if( $(this).prop("checked") ) {
                cantidad++;
            }
        });
        if( $("#tipoRip").val() == 'ips' && cantidad > 2  || $("#tipoRip").val() == 'eap' && cantidad > 1 ) {
            resultado = true;
        }
        return resultado;
    }


    function dialogoContinuarRip( titulo ){
        $("#ajaxStart").dialog("close");
        $( "#subidaRips" ).dialog({
            width : 700,
            height : 430,
            autoOpen: true,
            show: "highlight",
            hide: "explode",
            modal : true,
            title : "Subida Archivos Rips"+ "(" +titulo +")",
            close : function( ){

            },
            buttons : {
                "Continuar" : function() {
                    seleccionarColumnas( titulo );
                    $("#id_archivoRip_" + titulo).css("display", "none");
                    plasmarRipsYaSubidos( titulo )
                    
                }
                
            }
        });
    }
    function disabledRipsYaSubidos() {
        ripsSubidos = $("#ripsSubidos").val().split('-');
        existe = false;
        $("input[name*='ripsSeleccionados']").each( function() {
            for( n = 0; n < ripsSubidos.length; n++ ) {
                if( this.alt == ripsSubidos[ n ] ) {
                    existe = true;
                    break;
                }

            }
            $(this).prop("disabled", existe);
            existe = false;

        });
    }
    function confirmarSiDeseaSubirMasRips() {
        $("#ajaxStart").dialog("close");
        $( "#subirMasRips" ).dialog({
            width : 570,
            height : 180,
            autoOpen: true,
            show: "highlight",
            hide: "explode",
            title : "Confirmar",
            modal : true,
            buttons : {
                "Continuar y generar Novedades/Inconsistencias" : function() {
                    $.post('../CargarRips', {
                        'tipo' : 'subirRips',
                        "idencabezado" : $("#idencabezado").val(),
                        'fechaenvio' : $("#fechaenvio").val()
                    }, function( data ) {
                        
                        if( (data.length > 2 ) && data != undefined ) {
                            data = data.substring( 0 , data.length - 2 );
                            contenido = "";
                            
                            cadaRip = data.split(",");
                            tr = "";
                            for( n = 0; n < cadaRip.length; n++ ) {
                                ripCorte = cadaRip[ n ].split("->");
                            
                                infoRip = ripCorte[ 0 ].split("-");
                                // El rip...
                                rip = infoRip[ 0 ];
                                // Cantidad de datos...
                                cant = infoRip[ 1 ];
                                if( ripCorte[ 1 ] == undefined ) {
                                    break;
                                }
                            
                                archivos = ripCorte[ 1 ].split(":");
                                // Se leen los archivos
                                datosTds = "";
                                for( v = 0; v < archivos.length; v++ ) {
                                    archivosCorte = archivos[ v ].split("|");
                                
                                    nombreArchivo = archivosCorte[ 0 ];
                                    ruta = archivosCorte[ 1 ];
                                
                                    datosTds += '<td><a href="../descargarArchivo?' + ruta +'"><img src=\"../images/descargar.png\" title=\"Descargar datos Inconsistentes\" alt=\"Descargar\"/></a></td>';
                                
                                }
                                tr += "<tr><td>"+ rip +"</td><td  valign=\"middle\">"+ cant +"</td valign=\"middle\">" + datosTds + "</tr>";
                            
                            }
                            tipoCarga = ( $("#tipoRip").val() == "eap" ? "CargarRipsEAPB" : ( $("#tipoRip").val() == 'ips' ? 'CargarRips' : '' )  );
                            
                            
                            
                            contenido = "<p><a href=\"../CertificadoCarga?noEncabezado="+ $("#idencabezado").val() + "&tipoCarga=" + tipoCarga +"\" target=\"_blank\">Descargar certificado de carga</a></p><table border=\"1\" cellspacing=\"10\"><th>Tipo de archivo</th><th>Cantidad de inconsistencias</th><th>Descripci&oacute;n inconsistencias</th></th><th>Datos inconsistentes</th>"+ tr +"</table>";  
                        } else {
                            contenido = "No se generaron Inconsistencias <strong>No hay archivos para descargar</strong>";
                        }
                        
                        $("#tabs_incon_nove-1").html( contenido );
                    });

                    $( this ).dialog("close");
                    dejarAvanzarTab('si');
                    avanzarPosicion();
                    avanzarPosicion();
                    dejarAvanzarTab('no');
                },
                "Seleccionar mas rips" : function() {
                    disabledRipsYaSubidos();
                    seleccionDeRips();
                    seleccionArchivosASubir();
                    // AQUI
                    $( this ).dialog("close");
                }
            }
        });
    }
    function continuarSiguienteRip() {
        cambiarValorPosicionRip( "#siguienteRip_" + traemeRipActual(), 'no' );
        
        plasmarRipsYaSubidos( traemeRipActual() );
        
        dialogSubidaRips( siguienteRip() );
        
        
    //        seleccionarColumnas( siguienteRip() );
    //        $("#id_archivoRip_" + traemeRipActual()).css("display", "none");
        
        
    }
    function actualizarRipActual( ){
        //  alert( siguienteRip() );
        $("#ripActual").val( siguienteRip() );
    }
    function siguienteRip() {
        siguiente = false;
        ripSiguiente = '';
        $("input[id*='siguienteRip_']").each( function() {
            var tipoRip = this.id;
            tipoRip = tipoRip.split("_");
            tipoRip =  tipoRip[ 1 ];
            
            if( this.value == 'si' && ! siguiente ){
                siguiente = true;
                ripSiguiente = tipoRip;
            // alert( ripSiguiente );
            }
            
                    
        });
        return ripSiguiente;
    }
    function dialogSubidaRips( rip ) {
        $(".primerasLineas").html("");
        $("#contenido-tab-2").html("");
        if( rip == '' ) {
    
            if( cantidaValoresRipsEstadoSi() > 0  ) {
                // Limpia el div donde salen las lineas de sugerencia.

                titulo = '';
                entrar = true;
                $("input[id*='siguienteRip_']").each( function() {
                    var tipoRip = this.id;
                    tipoRip = tipoRip.split("_");
                    tipoRip =  tipoRip[ 1 ];
                    //alert( "Rip: " + tipoRip + "  " +estaEnRipsSubidos( tipoRip ));
                    if( ! estaEnRipsSubidos( tipoRip ) ) {
                        if( this.value == 'no' ) {
                            $( "#rips_" + tipoRip ).css("display", "none");
                        } else {
                            //alert( estaEnRipsSubidos( tipoRip ) );
                            if( entrar ) {
                                $( "#rips_" + tipoRip ).css("display", "block");
                                entrar = false;
                                cambiarValorPosicionRip( "#siguienteRip_" + tipoRip, 'no' );
                                titulo = tipoRip;

                                $("#ripActual").val( tipoRip );
                            }
                        }
                    }
                    
        
                } );
                
                dialogoContinuarRip( titulo );
            } else {
                confirmarSiDeseaSubirMasRips();
            }
            

        } else {
            $("#rips_" + rip ).css("display", "block");
            //$("#archivoRip_" + rip).val("");
            dialogoContinuarRip( rip );
        }
    }
    function plasmarRipsYaSubidos( rip ) {
        if( ! estaEnRipsSubidos( rip ) ) {
            $("#ripsSubidos").val( rip + "-" + $("#ripsSubidos").val()  );
        }
    }
    $("#tabs").tabs( {
        select : function () {
            //
            //            if( $("#noAvanzarConTab").val() == 'no' ) {
            //                $("#tabs").tabs("option", "selected", $("#posicionTab").val() );
            //            }
            // Cuando se selecciona IPS O EAPB el entra aqui y empieza a mostrar formularios
            if( $("#tipoRip").val() != '' && cantidaValoresRipsEstadoSi() > 0) {
                seleccionDeRips();
                seleccionArchivosASubir();

               
            }
            
        }
    } );
    
    function registrar_actualizar( registrarEncabezado ) {
        
        $("#error").val( 0 );
        $.post("../ServletEncabezadoValida", {
            "registrarEncabezado" : registrarEncabezado,
            "idencabezado" : $("#idencabezado").val(),
            "tipoValidacion" : "encabezado",
            "hacerSubmit" : "1",  // NO
            "tipoRip" : $("#tipoRip").val(),
            "codregimen" : $("#codregimen").val(),
            "codentidadsalud" : $("#codentidadsalud").val(),
            "grupopoblacion" :    $("#grupopoblacion").prop('disabled') ? 0 : $("#grupopoblacion").val(),
            "fechainicial" : $("#fechainicial").val(),
            "fechafinal" : $("#fechafinal").val(),
            "codarchivo" : $("#codarchivo").val(),
            "coddepartamento" : $("#coddepartamento").val(),
            "codmunicipio" : $("#codmunicipio").val(),
            "codigoTipoArchivo" : ( $("#codigoTipoArchivo").prop('disabled') ? ( $("input[@name='tipoCarga']:checked").val() == 'CargarRips' ? $("#codigoTipoArchivo").val() : 0 ) : $("#codigoTipoArchivo").val() ),
            "nombreenvia" : $("#nombreenvia").val(),
            "telefonoenvia" : $("#telefonoenvia").val(),
            "emailenvia" : $("#emailenvia").val(),
            "fechaenvio" : $("#fechaenvio").val(),
            "fecharecibo" : $("#fecharecibo").val(),
            "registros" : $("#registros").val(),
            "nombreArchivo" : $("#nombreArchivo").val(),
            "tipoCarga" : $("input[@name='tipoCarga']:checked").val(),
            "tipoArchivo" : $("#tipoRip").val() // VERIFICAR ESTO PARA CARGA DE RIPS

        }, function( data ) {
            
            encabezado = 0;
            $( data ).find("errores").each( function(  ) {
                var $errores = $( this );
                // encabezado = $errores.prop("idEncabezado");
                // if( encabezado != 0  ){
                // Se borrar el contenido de esta capa con el fin de que cuando el usuario
                //presione en actualizar no se vuelva a llenar la capa con los mismos datos...
                //if(  registrarEncabezado ) {
                    
                boton =  $("#idEncabezadoParaReporte").html();
                    
                $("#idEncabezadoParaReporte").html('');
                datos = $errores.attr("idEncabezado") + " <br /><span style=\"font-size:15px;\">Fecha y hora: " +  $errores.attr("fecha");
                $("#info").html( datos );
                if( $errores.attr("idEncabezado") > 0 ) {
                    $("#idEncabezadoParaReporte").html( "N&uacute;mero de encabezado: <span class=\"colorVerde\">" + $errores.attr("idEncabezado") + "</span> " + "Fecha y hora: <span class=\"colorVerde\">" + $errores.attr("fecha") +
                        "</span>"  + '<span class="menu"><input type="submit" value="Generar PDF" style="height:33px !important" onclick="generarImprimible()" /></span>' );
                    $("#numeroId, #idencabezado").val(  $errores.attr("idEncabezado") );
                    $("#accion").val( $("input[@name='tipoCarga']:checked").val() );
                    $("#nombreArchivo2").val("");
                }
                //}
                leerXML( $errores );
            //     }

            } )
            

            
        });

    }
    
    
    function capaConsultarContinuar( estado ){
        $("#continuarConsultarEncabezado").css("display", estado);
    }
    function subirDocumeto( estado ){
        if( estado ) {
            $("#subirDocumento").css("display", "block");
            $("#descargarDocumento").css("display", "none");
        } else {
            $("#subirDocumento").css("display", "none");
            $("#descargarDocumento").css("display", "block"); 
        }
    }
    
    $("input[class*='mostrarCapa']").click( function() {
        $("#formulario, #datosFormulario").submit( function() {
            return false;
        } );
        // Se obtiene la primera parte, esta contiene el #id la otra contieneel "agregar" o "modificar"
        id = this.alt;
        id = id.split("-");
        var tipoAgregarModificar = id[ 1 ];
        var tipo = id[ 1 ];
        
        if( tipoAgregarModificar == 'ver' )  {
            capaConsultarContinuar('block');
            subirDocumeto( false );
            
            
        }
        else if( tipoAgregarModificar == 'continuar' )  {
            capaConsultarContinuar('block');
            subirDocumeto( true );
            tipoAgregarModificar = 'registrar';
            
        } else{
            capaConsultarContinuar('none');  
            subirDocumeto( true );
        }
        
        
        
        $( id[ 0 ] ).css('display', 'block');
        $("#posicionTab").val( 0 );

        $( "#contenedor-encabezados" ).dialog({
            width : 980,
            height : 560,
            autoOpen: true,
            show: "highlight",
            hide: "explode",
            modal : true,
            position: 'top',
            title : this.title,
            close : function(  ) {
                document.location.href = document.URL;
            },
            buttons : {
                "Siguiente" : function() {
                    // Solo se guarda si se cumplen las condiciones de guardado...
                    // Las cuales se encuentran en la funcion
                    dejarAvanzarTab('si');
                    
                    guardarEncabezado( tipoAgregarModificar );
                    dejarAvanzarTab('no');
                    $("#contenedor-encabezados").scrollTop(0);
                   
                }/*,

                "Guardar Encabezado" : function( ) {
                    if( ! (tipoAgregarModificar == "registrar" && tabsSeleccionado() == 0)){
                        accionNoPermitida();
                    } else {
                        guardarEncabezado( tipoAgregarModificar );
                    }
                        
                },
                "Modificar Encabezado" : function( ) {
                    if( !(tipoAgregarModificar == "modificar" && tabsSeleccionado() == 0)) {
                        accionNoPermitida();
                    } else {
                    
                }

                }*/
            }
        });
        if( tipo == 'ver' ) {
            $("div[class='ui-dialog-buttonpane ui-widget-content ui-helper-clearfix']").html('');
            $("#tabsAsistente").html('');
            $("#idEncabezadoBuscar").focus();
        }
        if( tipo == 'continuar' ){
            $("#idEncabezadoBuscar").focus();
        }


    } );


} );


 