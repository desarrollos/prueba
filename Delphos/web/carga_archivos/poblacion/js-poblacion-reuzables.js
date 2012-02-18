function generarImprimible() {
    window.open("../ServletNoEncabezado?noEncabezado="+  $("#numeroId").val() +"","_blank","fullscreen=yes,scrollbars=1,left=350,top=100");
}
function certificadoCarga() {
    window.open("../CertificadoCarga?noEncabezado="+  $("#numeroId").val() +"","_blank","fullscreen=yes,scrollbars=1,left=350,top=100");
}
function continuarConsultarEncabezado(){
    // Permite que el encabezado se actualice
    $("#noReGuardarMismoEncabezado").val('no');
    encabezado  = $("#idEncabezadoBuscar").val();
    $("#idencabezado").val( encabezado );
    $.post('../todoInstancias', {
        "encabezado" : encabezado,
        "retornarEncabezado" : true
    }, function(data  ) {
        
        if( data.substring( 0, 5 )  == "vacio" ) {
            encabezadoNoSeEncontro();
            return true;
        }
        
        campos = data.split(":");
        for( n = 0; n < campos.length; n++ ) {
            campo = campos[ n ].split('|');
            if( campo[ 0 ] == 'text' ) {
                $( campo[ 1 ] ).val( campo[ 2 ] ) ;
            }
            if( campo[ 0 ] == 'radio' ) {
               
                $( campo[ 1 ] ).prop("checked", true);
                eval( campo[ 2 ]  + ";" );
            }
            if( campo[ 0 ] == 'combo' ) {
                $( campo[ 1 ] ).find( "option[value="+ campo[ 2 ] +"]" ).prop("selected","selected"); 
                //if( campo.length == 3) {
               
                eval( campo[ 3 ]  + ";" );
            //}
                
            }           
           
           
        }
        
        
    });
    
    
//capaConsultarContinuar('none');
}

$(document).ready( function() {
    
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


    $("#masRips").click( function() {
        //$("#masRipsCapa").css("display", ( $(this).prop("checked") ? "block" : "none" ) );
        $("#masRipsCapa").css("display", ( $("#masRips").prop("checked") ? "block" : "none" ) );
    } );
        
    

    $( "#accordion2" ).accordion();

    $( "#fechainicial, #fechafinal" ).datepicker({
        dateFormat : 'dd-mm-yy',
        changeMonth: true,
        changeYear: true

    });
    $( "#fechaenvio" ).datepicker({
        dateFormat : 'dd-mm-yy',
        changeMonth: true,
        changeYear: true,
        onClose : function(  ){
            $( "#fecharecibo" ).val( $("#fechaenvio").val() );
        }

    });    
    
    
    $( "#fecharecibo" ).datepicker({
        dateFormat : 'dd-mm-yy',
        changeMonth: true,
        changeYear: true

    });

    $(function() {
        $("#tabs").tabs({
            selected: 0
        });
        $("#tabs_incon_nove").tabs({
            selected: 0
        });
    });

    // Permite definir el estilo para los botones...
    $(function() {
        $( "button, input:submit, a, .lineasMostrar, .botonJquery", ".menu" ).button();
        $( "a", ".menu" ).click(function() {
            return false;
        });
    });


} );


var leerXML = function( $errores ) {
    $errores.find( "error" ).each( function() {

        var $error = $( this );
        id = $error.attr("id");
        estado = $error.attr("estado");
        mensaje = "";
        $error.find( "mensaje" ).each( function( )  {
            var $mensaje = $(this);
            mensaje += $mensaje.text() +  "|";

        });
        mensaje = mensaje.split("|");
        mensaje = mensaje[ 0 ];
        $( id ).css( "display", estado );


        $( id ).html( mensaje );
        if( estado == "block" ) {
            $("#error").val( 1 );
        }

    } );
}


var encabezadoNoSeEncontro = function(  ){
    $( "#encabezadoNoSeEncontro" ).dialog({
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
var verificarCampos = function() {
    $( "#verificarCampo" ).dialog({
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

var borrarAletrasCampos = function() {
    $("td[id*='id_']").each( function() {
        $( this ).css("display", "none");
    } );
}
var avanzarPosicion = function( pos ) {
    siguiente = ( pos == null ? $("#tabs").tabs("option", "selected") + 1 : pos);
    $("#tabs").tabs("option", "selected", siguiente );
    $("#posicionTab").val( siguiente );
}
var tabsSeleccionado = function() {
    return $("#tabs").tabs("option", "selected");
}

var entidadSaludDeAcuerdoAregimen = function( entidadSalud ) {
   
    ripsOpoblacion = $("input[@name='tipoCarga']:checked").val();
    
    estado = false;
    if( ripsOpoblacion == 'CargarPoblacion' ) {
        regimen = $("#codregimen").val() == 'otr' || $("#codregimen").val() == 'par' ? false : true ;
        $("#grupopoblacion").prop('disabled',  regimen );

    } 
    //alert( $("input[@name='tipoCarga']:checked").val() );
    $.post('../todoInstancias', {
        'llenarComboSalud' : true,
        'regimen' : $("#codregimen").val(),
        'entidadSalud' : entidadSalud
        

    }, function( data ) {
        
        $("#codentidadsalud").html( data );
        
        if( $("#tipoRip").val() == 'ips' ) {
            $("#ips").prop("checked", true);
        }
        

    });

}

var llenarComboMunicipios = function( municipio ) {

    $.post('../todoInstancias', {
        'llenarComboMunicipios' : true,
        'departamento' : $("#coddepartamento").val(),
        'municipio' : municipio

    }, function( data ) {
        $("#codmunicipio").html( data );
    }, "html");

}

var antesDebeSeleccionarUnRegimen = function() {
    if(  $("#codregimen").val() == '' ) {

        $( "#seleccioneRegimen" ).dialog({
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
descargarSubirDocumento = function( estado )  {
   
    }