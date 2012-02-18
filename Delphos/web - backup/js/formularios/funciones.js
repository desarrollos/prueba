function switchTipo( id, estado ) {
    $('div[id*="'+ id +'"]').iphoneSwitch(estado,
        function() {
        },
        function() {
        },
        {
            switch_on_container_path: '../js/ajax-switch/ajax-switch/iphone_switch_container_on.png',
            switch_off_container_path: '../js/ajax-switch/ajax-switch/iphone_switch_container_off.png',
            switch_path : '../js/ajax-switch/ajax-switch/iphone_switch.png'
        });    
}

function aplicarTemaBotones () {
    $( "input:submit, a, button, input:reset", ".boton" ).button();
    $( "a", ".boton" ).click(function() {
        return false;
    });
}
   
function configuraciones( config ) {
    // Secuencias
       
    var secuen = '';
    for( n in config.secuencias ){
        secuen += config.secuencias[ n ].nomSec + ',' ; 
    }
    parametros = 'secuen=' + secuen;
       
    $.post('../edinstancias', {
        'parametros' :'opcion=config-' +  parametros
    }, function( data ) {
        // Obteniendo el valor de las secuencias.
        for( n in data.secuencias ){
            id = config.secuencias[ n ].idCampo;
            readonly = config.secuencias[ n ].mod;
            $("#" + id ).val( data.secuencias[ 0 ].valor );
            if( readonly ) {
                $("#" + id ).attr("readOnly", readonly );
            } else {
                $("#" + id ).removeAttr("readOnly");
            }
                
                
        }
    }, 'json')  
       
}

$(document).ready( function( ) {
    // Convierte los titulos a mayusculas
    titutosMayusculas();
    form = '';
    config = new Object(); 
    urlActual = document.URL;
    // Configura el boton doble click del flexigrid, para actualice
    // o seleccione un registro
    configModificar = false;
    // Guardar el emento que el usuario necesita modificar
    datoModificar = '';
    
    
    $('div[id*="switch_"]').iphoneSwitch("on",
        function() {
        },
        function() {
        },
        {
            switch_on_container_path: '../js/ajax-switch/ajax-switch/iphone_switch_container_on.png',
            switch_off_container_path: '../js/ajax-switch/ajax-switch/iphone_switch_container_off.png',
            switch_path : '../js/ajax-switch/ajax-switch/iphone_switch.png'
        });

    
    jQuery(function($){
        $.datepicker.regional['es'] = {
            closeText: 'Cerrar',
            prevText: '<Ant',
            nextText: 'Sig>',
            currentText: 'Hoy',
            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
            monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
            dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
            dayNamesShort: ['Dom','Lun','Mar','Mié','Juv','Vie','Sáb'],
            dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sá'],
            weekHeader: 'Sm',
            dateFormat: 'dd/mm/yy',
            firstDay: 1,
            isRTL: false,
            showMonthAfterYear: false,
            yearSuffix: ''
        };
        $.datepicker.setDefaults($.datepicker.regional['es']);
    });
    $("input[id*='_fecha_']").datepicker({
        dateFormat : 'yy-mm-dd',
        changeMonth: true,
        changeYear: true
    });
    if (typeof jQuery.fn.datetimepicker == 'function') {
        $("input[id*='_fechahora_']").datetimepicker({
            showSecond: true,
            dateFormat : 'dd-mm-yy',
            timeFormat: 'hh:mm:ss',
            second : 0
        });
    }
    $(function() {
        aplicarTemaBotones();
        $("#dialog").scrollTop(0);
        $( "#dialog" ).dialog({
            width:screen.width - 100,
            height: screen.height - 150,
            title : $("#nombreFormulario").val(),
            modal : true,
            closeOnEscape: false,
            close : function() {
                redireccionar('../');
            }
               
        });
        
        $( "#tabs" ).tabs({
                
            });
        // Permite ubicar al usuario en la pesta?a en la que estaba
        // despues de actualizar o insertar un registro en un formulario
        if( urlActual.indexOf('tabs-') ) {
            $("#tabs").tabs({
                "selected" : indexTab() 
            });
            $("#pestana").val(tabId());
        }
        $("#pestana").val(tabId());
        $("#tabs").bind('tabsselect', function( event, ui ){
            $("#pestana").val($("#tabs > ul > li > a[href*='#tabs-"+ (ui.index + 1) +"']").attr('id'));
            urlActual = urlActual.substring(0, posicion_tabs()) + '' + (ui.index + 1);
        }) 
    });

    $('.flexigrid tr[id*="row"]').live({
        
        dblclick : function() {
            
            if( ! configModificar) {
                id = $(this).attr('id').substr(3);
                codigoSeleccion = id.split("_");
                codigoSeleccion = codigoSeleccion[ 1 ].split("--");
                descripcion = $('tr[id="' + $(this).attr('id') + '"] > td[abbr="'+ codigoSeleccion[ 1 ] +'"] > div > span').html();
                selCombo( codigoSeleccion[ 0 ], descripcion );
                $("#servletActivo").val('');
            } else {
                modificarElemento();
            }
            
        },
        
        mouseover : function() {
            
            datoModificar = obtenerElementoId(this.id);
            $(this).css('cursor','pointer');
            
        }
    });


});
function ocultarBottomMensaje( ){
    $("#mensaje").fadeOut(1000, function() {
        $(this).dialog('close');
        
    });
}
function tabId() {
    var id = $("#tabs > ul > li > a[href*='#tabs-"+ ($("#tabs").tabs('option', 'selected') + 1) +"']").attr('id')
    return id;
}
function indexTab() {
    var index = urlActual.substring( posicion_tabs());
    return index;
}
function posicion_tabs() {
    var posicion = urlActual.indexOf('tabs-') + 5;
    return posicion;
}
function titutosMayusculas() {
    // Obtiene el titulo de la pagina abierta y lo convierte a mayusculas.
    $("div[class*='titulo']").html( $("div[class*='titulo']").html(  ).toUpperCase() );
}
function eliminarElementos() {
    elementos = obtenerElementoModificar().split(',');
    //if( elementos.length != 1 ) {
    $("#codigo").val( elementos );
    accionFormulario($("#servlet").val(), 'Eliminar', '')
//}
    
    
}

function obtenerElementoModificar() {
    var elementos  = '';
    $('.trSelected').each( function(){
        elementos += obtenerElementoId( $(this).attr('id') );
    });
    return elementos;
}
// Permite obtener el id del elemento que se quiere modificar en el flexigrid
function obtenerElementoId( id ) {
        var id = id.substr(3);
        nombreCodigo = id.split("_");
        nombreCodigo = nombreCodigo[ 1 ].split("--");
        return nombreCodigo[ 0 ] + ',';

}
function modificar( codigo ) {
    $("#codigo").val(codigo);
    $("#accion").val('Obtener');
    accion( '../' + $("#servlet").val(), $('form[id='+ $("#servlet").val() +']').serialize());
//  }
}
function modificarElemento(  ){
    
    
    if( configModificar  ) {
        datoModificar = datoModificar.split(",");
        modificar( datoModificar.toString().substring(0, datoModificar.toString().length - 1 ))  ;
    } else {
        elementos = obtenerElementoModificar().split(',');
        if( elementos.length == 2  ) {
        
            modificar( elementos.toString().substring(0, elementos.toString().length - 1 ))  ;
        } else if( elementos.length == 1) {
            bottomMensaje('Debe seleccionar al menos un elemento','Modificaci&oacute;n', 'e')  ;
        
        } else if( elementos.length > 2) { 
            bottomMensaje('No es posible modificar mas de un elemento','Modificaci&oacute; multiple no permitida', 'e')  ;
        }
    }
    
    
}
function accion(  servlet, parametros ) {
    $.post( servlet, {
        'parametros' : parametros
    }, function( retorno ) {
        // El substring elimina los 2 caracteres raros que salen cuando la peticion es retornada por el servle
        $("#respuestaAjax").val(retorno.substring(0, retorno.length - 2) );        
        
    })
}

function mapSelects(datos) {
    datosCorte = datos.split("   ");
    var mapa = new Object();
    for (n = 1; n <= (datosCorte.length - 1); n++) {
        if (datosCorte[ n].indexOf("  ") == -1) {
            break;
        }
        claveValor = datosCorte[ n].split("  ");
        //System.out.println("GUARDAR : " + claveValor[ 0 ] + "  " + claveValor[ 1 ]);
        mapa[ claveValor[ 0] ] =  claveValor[ 1];

    }
    return mapa;
}
// titulo del dialog
// tabla a la cual se consultan los datos
// combo al cual se le asignan los datos
tabExiste = 0;
function tabla( flexiParametros, titulo,combo ) {
    
    tabExiste++;
    if( tabExiste == 1 ){
        configModificar = ( combo == '' ? true : false );
        
        
        ocultarBottomMensaje();
        datos = urlDecodificar( flexiParametros.url, "-" );
        form = flexiParametros.form;
        e = false;
        
        // Se comprueba select dependientes...
        dep = config.selDep;
        
        var rel = '';
        for( n in dep ) {
            if( dep[ n ].tabla == datos['tabla'] ){
                selects = dep[ n ].selectRel;
                for( l in selects ) {
                    value = $("#" + selects[ l ].id ).val();
                    //console.log( 'Valor select: ' + $("#" + selects[ l ].id ).val() );
                    if( value == null || value == '' ) {
                        bottomMensaje( selects[ l ].erMeg ,'Elemento dependiente', 'e')  ;
                        e = true;
                        tabExiste = 0;
                        break;
                    } else {
                        var mapa = mapSelects( $("#" + selects[ l ].id ).val());
                        var valor = ( mapa[ selects[ l ].sel ] === undefined ? $("#" + selects[ l ].id ).val()  : mapa[ selects[ l ].sel ]  );
                        rel += selects[ l ].rel + ( isNaN(parseInt( valor )) ? "'" + valor + "'" :  valor); 
                    }
                    
                }
            }
        }
        
        if( e ) {
            
            return true; 
        }
        
        $.post('../edinstancias', {
            'parametros' : 'opcion=campos-tabla='+ datos['tabla']
        }, function( data ) {
            flexiParametros.url += '-relacion=' + rel
            $("#combo").val( combo );
            $("#servletActivo").val( ( $("#servlet").val() == datos['servlet'] ? '' :  datos['servlet'] ) );
            $("#tablaContenedor").html("<div class=\"ui-state-error ui-corner-all\" style=\"padding: 0 .7em;\">"+ 
					"<p><span class=\"ui-icon ui-icon-alert\" style=\"float: left; margin-right: .3em;\"></span> "+
					"Para modificar un registro presiona doble click sobre el.</p>"+
				"</div><div id=\"tabla\"></div>");
            //var columnas = $.parseJSON( data );
            //var  searchitems = $.parseJSON( data );
            columnas = data;
            searchitems = data;
            //flexiParametros
            // Botones
            botones = flexiParametros.buttons;

            if( botones.length <= 2 ) {
                botones.push(/* {
                    name : 'Modificar', 
                    onpress : modificarElemento,
                    bclass : 'modificar'
                },*/ {
                    name : 'Eliminar',
                    onpress : eliminarElementos,
                    bclass : 'eliminar'
                },{
                    name : 'Generar Reporte TXT', 
                    onpress : rePlano,
                    bclass : 'txt'
                }, {
                    name : 'Generar Reporte PDF', 
                    onpress : rePdf,
                    bclass : 'pdf'
                },{
                    name : 'Generar Reporte EXCEL', 
                    onpress : reExcel,
                    bclass : 'xls'
                });
            }
            
            $('#tabla').flexigrid($.extend({}, flexiParametros, { 
                colModel        : columnas, 
                singleSelect : ( datos['tipo'] == 'modificar' ? true : false ),
                searchitems : searchitems,
                buttons : botones,
                onSubmit        : function(){ 
                    $('#tabla').flexOptions({
                        params: [ 

                        {
                            name:'colls', 
                            value: $.param({
                                colls: $.map(columnas, 
                                    function(elem,id){
                                        return elem.name
                                    })
                            })
                        } 
                        ]
                    }); 
                    return true; 
                } 
            })); 
    
    
            $("#tablaContenedor").dialog({
                title : titulo,
                width : 900,
                height : 500,
                autoOpen: true,
                closeOnEscape: true,
                show: "highlight",
                hide: "explode",
                close : function() {
                    tabExiste =  0; 
                    botones = new Array();
                    ocultarBottomMensaje();
                },
                modal : true, // Para oscurecer la pantalla
                buttons : {
                    "Cerrar" : function() {
                        tabExiste =  0; 
                        $( this ).dialog("close");
                        $("#tabla").remove();
                        $("#servletActivo").val('');
                        ocultarBottomMensaje();
                        
                    
                    }
                }
            });        
 
        }, 'json');
    } else {
        console.log('Error funcion tabla() funciones.js');
    }
    
    return false;
    
}

function mapa( datos ) {
    var mapa = new Object();
    
    datosCorte = datos.split("&&");
    for( n = 0; n < datosCorte.length; n++ ) {
        datos = datosCorte[ n ].split("=");
        mapa[datos[ 0 ]] = datos[ 1 ];
    }
    
    return mapa;
}
function dialogMensaje( mensaje, ancho, alto, titulo ) {
    $("#mensaje").html( mensaje );
    $("#mensaje").dialog({
        width : ancho,
        height: alto,
        title : titulo,
        position : 'center',
        closeOnEscape: true,
        modal : true,
        zIndex: 3999,
        
        buttons :  {
            "Cerrar" : function() {
                $(this).dialog('close');
                
            } 
        }
    });   
}
function bottomMensaje( mensaje, titulo ,  tipo, redireccionar ) {
    tiposColor = new Object();
    tiposColor['e'] = '#FF0000'; // error
    tiposColor['ex'] = '#BFDC7E'; // exito
    tiposColor['ad'] = 'FFE39C'; // Advertencia
    
    tiposEfecto = new Object();
    tiposEfecto['e'] = 'shake'; // error
    tiposEfecto['ex'] = 'clip'; // exito
    tiposEfecto['ad'] = 'shake'; // Advertencia


    tiposColores = new Object();
    tiposColores['e'] = '#FFFFFF'; // error
    tiposColores['ex'] = '#000000'; // exito
    tiposColores['ad'] = '#000000'; // Advertencia
    
    mensajesTiempo = new Object();
    mensajesTiempo['ex'] = 2500;
    mensajesTiempo['ad'] = 2500;
    
    $("#mensaje")
    .html( mensaje ).dialog({
        width:screen.width - 100,
        height: 100,
        position : 'bottom',
        modal : false,
        title : titulo,
        show : tiposEfecto[ tipo ],
        autoOpen : true,
        closeOnEscape: true,
        zIndex: 3999
        
    })
    
    .click( function() {
        $(this).fadeOut(1000, function() {
            $(this).dialog('close');
        });
    } ).css('background', tiposColor[ tipo ]).css('color', tiposColores[ tipo ]);
    $(".error").css('color', tiposColores[ tipo ]);
    if( tipo != 'e' ) {
        window.setTimeout("cerrarMensaje('"+ redireccionar +"')",mensajesTiempo[ tipo ]);
    }

}
// Permite que los formularios con pesta?as detecten el #tabs-3 para que se ubiquen donde son en la pesta?a
function actualizarUrl(){
    
}
function cerrarMensaje( rediret ) {
    
    $("#mensaje").fadeOut(1000, function() {
        $(this).dialog('close');
        if( rediret == 's') {
            redireccionar(urlActual);
        }
    });
}
function borrarRespuesta() {
    $("#accion").val('');
    $("#respuestaAjax").val('');
    
}
function selCombo( codigo, nombre ) {
    
    $( "#" + $("#combo").val() ).attr('title', nombre);
    $( "#" + $("#combo").val() ).html('<option value="'+ codigo +'">' + nombre + '</option>')
    $("#tablaContenedor").dialog("close");
    $("#combo").val('');
}

function configurarBotones( tipo ) {
    if( tipo == 'Actualizar' ) {
        $("#accion1, #accion2").css('display', 'none');
        $("#resetFormulario1, #resetFormulario2").css('display', 'none');
        $("#actualizar1, #actualizar2").css('display', 'inline');
        $("#eliminar1, #eliminar2").css('display', 'inline');
        $("#volver_registro1, #volver_registro2").css('display', 'inline');
        
    }
    if( tipo == 'Registrar' ) {
        $("#accion1, #accion2").css('display', 'inline');
        $("#resetFormulario1, #resetFormulario2").css('display', 'inline');
        $("#actualizar1, #actualizar2").css('display', 'none');
        $("#eliminar1, #eliminar2").css('display', 'none');
        $("#volver_registro1, #volver_registro2").css('display', 'none');
    }    
}



function leerDatos( datos ) {
    campos = datos.split(":_");
    for( n = 0; n < campos.length; n++ ) {
        campo = campos[ n ].split('|');
        if( campo[ 0 ] == 'text' ) {
            $( campo[ 1 ] ).val( campo[ 2 ] ) ;
        }
        if( campo[ 0 ] == 'radio' ) {
               
            $( campo[ 1 ] ).attr("checked", true);
            eval( campo[ 2 ]  + ";" );
        }
        if( campo[ 0 ] == 'combo' ) {
            //$( campo[ 1 ] ).find( "option[value="+ campo[ 2 ] +"]" ).attr("selected","selected"); 
            //if( campo.length == 3) {
               
            eval( campo[ 3 ]  + ";" );
        //}
                
        }
        if( campo[ 0 ] == 'switch' ) {
            estado = ( campo[ 2 ] == 's' ? 'on' : 'off' );
            switchTipo( campo[ 1 ], estado );
            $("#" + (campo[ 1 ].substring( 7 )) ).val( campo[ 2 ] );
        }
           
           
    }    
}
function accionFormulario(servlet, tipo, parametros) {
    $("#accion").val(tipo);
    accion( '../'+ servlet , $('form[id='+ servlet +']').serialize());
}
function redireccionar( pagina ) {
    document.location.href = pagina.replace('#', '');
//document.location.href = pagina;
}
function llenarCombo( id, clave, valor ) {
    $("#" + id).html("<option value=\""+ clave +"\">"+ valor +"</option>");
}
function abrirCargaArchivo(campo)
{
    var url;
    url = "../common/PopUpCargaArchivo.jsp?";
    url = url + "campo=" + campo;
    window.open(url,"_blank","width=500,height=190,scrollbars=1,left=350,top=100");
}
function reHref( id ) {
    console.log( $('#' + id).val() );
    if( $('#' + id).val() == '' ) {
        bottomMensaje('No hay archivos para descargar', 'Archivo no existe', 'ad', 'n');
    } else {
        var ruta = '../descargarArchivo?nombreArchivo=';
        window.open( ruta + $('#' + id).val() );
        
    }
    
    return false;
}

function urlDecodificar(urlCodificada,  sp) {
    mapaClaveValor = new Object();
    separacionVariables = urlCodificada.split((sp == '' ? "&" : sp));

    for ( s = 0; s < separacionVariables.length; s++) {
        claveValor = separacionVariables[s].split("=");
        clave = claveValor[ 0];
        valor = claveValor[ 1];
        mapaClaveValor[ clave ] = (valor == "" ? "" : valor);

    }

    return mapaClaveValor;
}

function agregar() {
    console.log( 'Form : ' + form );
    abrirPagina('../formularios/' + form);
}
function abrirPagina( url ) {
    console.log( url );
    WindowObjectReference = window.open(url,"_blank","width="+ (screen.width - 100) +",height=" +(screen.height  - 150) +",scrollbars=1");
    WindowObjectReference.focus();
}
function generarReporte( tipo ){
    $.post("../reportes", {
        'tipo' : tipo
    }, function( data ) {
        
        })
    
}

function rePlano() {
    generarReporte('txt');
}
function rePdf(){
    generarReporte('pdf');
}
function reExcel( ){
    generarReporte('xls');
}