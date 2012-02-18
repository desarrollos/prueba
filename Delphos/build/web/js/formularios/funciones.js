flexiTipoEducacion = { 
	url : '../edinstancias?parametros=opcion=tabla-tabla=tipoeducacion-principal=tipeducodigo-seleccion=tipedudescri-tipo=modificar', 
	dataType : 'xml', 
	height: 280, 
	width : 850, 
	usepager : true, 
	rp : 30, 
	sortname: 'tipeducodigo', 
	sortorder: 'asc', 
	buttons : [ 
	{ 
	name : 'Agregar Nuevo Tipo Educacion', 
	bclass : 'anadir' 
	} 
	] 
}; 

flexiGradoEscolaridad = { 
	url : '../edinstancias?parametros=opcion=tabla-tabla=escolaridadgrado-principal=escgracodigo-seleccion=escgradescri-tipo=modificar', 
	dataType : 'xml', 
	height: 280, 
	width : 850, 
	usepager : true, 
	rp : 30, 
	sortname: 'escgracodigo', 
	sortorder: 'asc', 
	buttons : [ 
	{ 
	name : 'Agregar Nuevo Grado Escolaridad', 
	bclass : 'anadir' 
	} 
	] 
}; 

flexiTipoSubsidio = { 
	url : '../edinstancias?parametros=opcion=tabla-tabla=tiposubsidio-principal=subtipcodigo-seleccion=subtipdescri-tipo=modificar', 
	dataType : 'xml', 
	height: 280, 
	width : 850, 
	usepager : true, 
	rp : 30, 
	sortname: 'subtipcodigo', 
	sortorder: 'asc', 
	buttons : [ 
	{ 
	name : 'Agregar Nuevo Tipo Subsidio', 
	bclass : 'anadir' 
	} 
	] 
}; 

// Variables para el flexi
flexiDocumentoInscripcion = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=documentoinscripcion-principal=codunifami,codtipodctoasociado-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codtipodctoasociado', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Documento Inscripción', 
        bclass : 'anadir' 
    } 
    ] 
}; 

flexiFuncionario = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=funcionario-principal=codtipoidentidad,numidentfunc-seleccion=nombre-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'numidentfunc',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Funcionario',
        bclass : 'anadir'
    }
    ]
};

flexiTipoBeneficiario = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipobeneficiario-principal=coditipben-seleccion=desctipben-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'coditipben',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Tipo Beneficiario',
        bclass : 'anadir'
    }
    ]


};
flexiEstadoEscolaridad = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=escolaridadestado-principal=escestcodigo-seleccion=escescdescri-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'escestcodigo',
    sortorder: 'asc',
    buttons : [
        {
            name : 'Agregar Nuevo Estado Escolaridad',
            bclass : 'anadir'
        }
    ]


};
flexiBeneficiario = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=beneficiario-principal=codunifami,codtipoidentidad,identbenef-seleccion=identbenef-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'identbenef',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Beneficiario',
        bclass : 'anadir'
    }
    ]


};


flexiBanco = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=banco-principal=codbanco-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codbanco',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Banco',
        bclass : 'anadir'
    }
    ]


};

flexiVinculacion = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=inscripcion-principal=codunifami-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codunifami',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nueva Inscripcion',
        bclass : 'anadir'
    }
    ]


};

flexiDocumentoCausal = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=documentocausal-principal=codtiponovedad,novcaucodigo,codtipodctoasociado-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'novcaucodigo',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Documento Causal',
        bclass : 'anadir'
    }
    ]


};

flexiDocumentoQuejas = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=quejadocumento-principal=codunifami,quejconsecut,codtipodctoasociado asociado-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'quejconsecut',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Documento Queja',
        bclass : 'anadir'
    }
    ]


};


flexiClaseGrupoTitular = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=clasegrupotitular-principal=codclagrutit',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codclagrutit',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nueva Clase Grupo Titular',
        bclass : 'anadir'
    }
    ]


};
flexiEstadoTitular = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadotitular-principal=codiesttit',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codiesttit',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Estado Titular',
        bclass : 'anadir'
    }


    ]


};
flexiTipoTitular = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipotitular-principal=coditiptit',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'coditiptit',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Tipo Titular',
        bclass : 'anadir'
    }


    ]


};
flexiEstadoFamilia = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadofamilia-principal=codiestfam-seleccion=descestfam',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codiestfam',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Estado Familia',
        bclass : 'anadir'
    }


    ]


};

flexiTipoPoblacion = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipopoblacion-principal=codtipopoblacion',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codtipopoblacion',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Tipo Poblacion',
        bclass : 'anadir'
    }


    ]


};


flexiQuejasDocumentos = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamodocumento-principal=codtipopoblacion',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codtipopoblacion',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Tipo Poblacion',
        bclass : 'anadir'
    }


    ]


};
flexiTipoNovedadCausal ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=tiponovedad-principal=codtiponovedad-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Novedad Causal',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
}


flexiNovedadCausal ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=novedadcausal-principal=novcaucodigo-seleccion=novcaudescri-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'novcaudescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Novedad Causal',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'novcaudescri',
    sortorder: 'asc'
}


flexiEntidadSalud = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=entidadsalud-principal=codregimenes,codentidadsalud-seleccion=nombrehabilitacion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codentidadsalud',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar nueva entidad salud',
        bclass : 'anadir'
    }
    ]
};



flexiQuejaClasificacion = {
 
    url : '../edinstancias?parametros=opcion=tabla-tabla=quejaclasificacion-seleccion=quecladescri-principal=tipquecodigo,queclacodigo',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'quecladescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Reclamo Clasificacion',
        bclass : 'anadir'
    }]

}

flexiQuejas ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=quejas-principal=quejconsecut,codunifami',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'quejconsecut',
    sortorder: 'asc',
    buttons : [{
        name : 'Modificar', 
        onpress : modificarElemento,
        bclass : 'modificar'
    },
    {
        name : 'Eliminar', 
        onpress : eliminarElementos,
        bclass : 'eliminar'
    },{
        name : 'Agregar Nueva Clasificación Queja',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'quejconsecut',
    sortorder: 'asc'
}




flexiQuejaBeneficiario ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=inscripcion-principal=codunifami-seleccion=codunifami-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codunifami',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Clasificación Queja',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'codunifami',
    sortorder: 'asc'
}


flexiReclamoTipo ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamotipo-principal=rectipcodigo-seleccion=rectipdescri-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'rectipdescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Reclamo',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'rectipdescri',
    sortorder: 'asc'

}
flexiReclamoTipo ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamotipo-principal=rectipcodigo-seleccion=rectipdescri-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'rectipdescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Reclamo',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'rectipdescri',
    sortorder: 'asc'

}
flexiTipoSatisfaccion ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=satisfacciontipo-principal=tipsatcodigo-seleccion=tipsatdescri-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'tipsatdescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Satisfaccion',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'tipsatdescri',
    sortorder: 'asc'

}
flexiRespuestaClasificacion ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=respuestaclasificacion-principal=resclacodigo-seleccion=rescladescri-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'rescladescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Respuesta Clasificacion',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'rescladescri',
    sortorder: 'asc'

}
flexiTipoQueja ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoqueja-principal=tipquecodigo-seleccion=tipquedescri-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'tipquedescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Queja',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'tipquedescri',
    sortorder: 'asc'

}

flexiEncuentroreunion ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=encuentroreunion-principal=encuencodigo-seleccion=encuencodigo-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'encutemaprin',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Encuentro o Reunion',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'encuencodigo',
    sortorder: 'asc'

}

flexiClasificacionReclamo ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamoclasificacion-principal=recclacodigo-seleccion=reccladescri-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'reccladescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Clasificación Reclamo',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'reccladescri',
    sortorder: 'asc'
}


flexiReclamoClasificacion = {
 
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamoclasificacion-seleccion=reccladescri-principal=rectipcodigo,recclacodigo',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'reccladescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Reclamo Clasificacion',
        bclass : 'anadir'
    }]

}



flexiInscripcion ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=inscripcion-principal=codunifami-seleccion=codunifami-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'encutemaprin',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Inscripción',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'codunifami',
    sortorder: 'asc'
}

flexiTipoReclamo ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamotipo-principal=rectipcodigo-seleccion=rectipdescri-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'rectipdescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Reclamo',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'rectipdescri',
    sortorder: 'asc'
}


flexiAsistencia ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=asistentesreunion-principal=encuencodigo,codtipoidentidad,asisteidenti-seleccion=encuencodigo-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'encutemaprin',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Asistencia',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'encuencodigo',
    sortorder: 'asc'
}


flexiGrupoSeguridad = {
 
    url : '../edinstancias?parametros=opcion=tabla-tabla=gruposeguridad-seleccion=grusegdescripcion-principal=grusegcodigo-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'grusegdescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Grupo Seguridad',
        bclass : 'anadir'
    }]

}
flexiTipoReunion = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tiporeunion-principal=coditiporeun-seleccion=desctiporeun-tipo=modificar-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Tipo Reunion',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'desctiporeun',
    sortorder: 'asc'     
}
flexiTipoSistema = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tiposistema-principal=tisiscodigo-seleccion=tisisdescrip-tipo=modificar-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Tipo Sistema',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'tisisdescrip',
    sortorder: 'asc'     
}
flexiEstadosUsuarios = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadousuasistema-principal=codestusuasistema-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Estado Usuario',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'   
}
flexiPlanSalud = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=plansalud-principal=codplansalud-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Plan Salud',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'   
}


flexiActividadEconomica = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=actividadeconomica-principal=codactividadeconomica-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Actividad Economica',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'   
}

flexiTipoAportante = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoaportante-principal=codtipoaportante-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Actividad Economica',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'   
}
flexiTipoContribuyente = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipocontribuyente-principal=codtipocontribuyente-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Actividad Economica',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'   
}

flexiBarrio = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=barrio-principal=codbarrio-seleccion=nombre-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Barrio',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'nombre',
    sortorder: 'asc'   
}

flexiClasePersona = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=clasepersona-principal=codclasepersona-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Clase Persona',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'   
}


flexiSubGrupoGeografico = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=subgrupogeografico-principal=codsubgrupo-seleccion=nombre-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Sub Grupo Geografico',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'nombre',
    sortorder: 'asc'   
}

flexiMunicipio = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=municipio-principal=codmunicipio-seleccion=nombre-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Municipio',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'nombre',
    sortorder: 'asc'   
}
flexiDepartamento = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=departamento-principal=coddepartamento-seleccion=nombre-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Departamento',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'nombre',
    sortorder: 'asc'   
}


flexiOrigenRecurso = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=origenrecurso-seleccion=ordescripcion-principal=orcodigo-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'ordescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Origen Recurso',
        bclass : 'anadir'
    }]
}



flexiReclamos = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamo-seleccion=reclamconsec-principal=codunifami,reclamconsec-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'ordescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Reclamo',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'reclamconsec',
    sortorder: 'asc'  
}

flexiTipoDocumentoAsociado = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipodctoasociado-seleccion=descripcion-principal=codtipodctoasociado-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'ordescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Documento Asociado',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'  
}

flexiSatifaccionTipo = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=satisfacciontipo-seleccion=tipsatdescri-principal=tipsatcodigo-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'ordescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Satisfacción',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'tipsatdescri',
    sortorder: 'asc'  
}
flexiReclamoDocumentos = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamodocumento-seleccion=reclamconsec-principal=reclamconsec,codunifami-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'ordescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Documento Reclamo',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'reclamconsec',
    sortorder: 'asc'  
}

flexiReclamoBeneficiario = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamobeneficiaro-seleccion=reclamconsec-principal=reclamconsec-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'ordescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Reclamo Beneficiario',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'reclamconsec',
    sortorder: 'asc'  
}

flexiRespuestasReclamo = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=respuestareclamo-seleccion=reclamconsec-principal=reclamconsec-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'ordescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Reclamo Beneficiario',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'reclamconsec',
    sortorder: 'asc'  
}


flexiEmpresas = {
    
    url : '../edinstancias?parametros=opcion=tabla-tabla=empresa-seleccion=nombre-principal=codtipoidentidad,codempresa-servlet=Empresas-tipo=modificar',
    form : 'Empresas.jsp',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'nombre',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Empresa',
        bclass : 'anadir',
        onpress : agregar
    }]
}
flexiComplejidad = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=nivelcomplejidad-principal=codnivelcomplejidad-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codnivelcomplejidad',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Complejidad',
        bclass : 'anadir'
    }]
};

flexiEstadoentidadsalud = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadoentidadsalud-seleccion=descripcion-principal=codestadoentidad-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Estado Entidad Salud',
        bclass : 'anadir'
    }],
   
    usepager : true,
    rp : 30,
    sortname: 'codestadoentidad',
    sortorder: 'asc'
};


flexiTipoatencion = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoatencion-seleccion=descripcion-principal=codtipoatencion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Atencion',
        bclass : 'anadir'
    }],
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
};
flexiTipoespecializacionsalud = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoespecializacionsalud-principal=codtipoespecializacion-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Especializacion',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
};
flexiEstadosGruposSeguridad =  {
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadogruposeguridad-principal=esgrsecodigo-seleccion=esgrsedescripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Estado Grupo Seguridad',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'esgrsedescripcion',
    sortorder: 'asc'
}
flexiNivelsegopcion ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=nivelsegopcion-principal=niseopcodigo-seleccion=niseopdescripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Modificar', 
        onpress : modificarElemento,
        bclass : 'modificar'
    },{
        name : 'Agregar Nuevo Perfil',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'niseopdescripcion',
    sortorder: 'asc'    
}

flexiTipoActividad ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoactividad-principal=codtipoactividad-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Modificar', 
        onpress : modificarElemento,
        bclass : 'modificar'
    },{
        name : 'Agregar Nuevo Tipo Actividad',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'    
}


flexiTipoAsistente ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoasistente-principal=tipasicodigo-seleccion=tipasidescri-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Tipo Asistente',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'tipasidescri',
    sortorder: 'asc'    
}


flexiAsistenteExterno ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=encuenasistenteexterno-principal=encuencodigo,codtipoidentidad,externidenti-seleccion=externidenti-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Asistente',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'externidenti',
    sortorder: 'asc'    
}



flexiListaOpcion =  {
    url : '../edinstancias?parametros=opcion=tabla-tabla=listaopcion-principal=lisopccodigo-seleccion=lisopcdescripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Lista Opcion',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'lisopcdescripcion',
    sortorder: 'asc'
}

flexiGruposSeguridad =  {
    url : '../edinstancias?parametros=opcion=tabla-tabla=gruposeguridad-principal=grusegcodigo-seleccion=grusegdescripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Grupo Seguridad',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'grusegdescripcion',
    sortorder: 'asc'
}

flexiSectorEntidad =  {
    url : '../edinstancias?parametros=opcion=tabla-tabla=sectorentidad-principal=codsectorentidad-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Sector Entidad',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
}

flexiEncuentroactividad =  {
    url : '../edinstancias?parametros=opcion=tabla-tabla=encuentroactividad-principal=encuencodigo,codtipoactividad-seleccion=encuencodigo-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Actividad',
        bclass : 'anadir'
    }],
    
    usepager : true,
    
    rp : 30,
    sortname: 'encuencodigo',
    sortorder: 'asc'
}




flexiTipoIdentificacion = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoidentificacion-principal=codtipoidentidad-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Tipo Identificacion',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
}
flexiClasificacionentidad = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=clasificacionentidad-principal=codclasifentidad-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    
    buttons : [{
        name : 'Agregar Nueva Clasificacion Entidad',
        bclass : 'anadir'
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
};
flexiRegimen = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=regimen-principal=codregimen-seleccion=descripcion-tipo=modificar',
    form : 'Regimen.jsp',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Regimen',
        bclass : 'anadir',
            
        onpress : agregar
    }
    ],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
};
flexiEntidad = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoentidadsalud-principal=codtipoentidadsalud-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Entidad',
        bclass : 'anadir'
    }
    ],
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
};
flexiEstadoUsuario = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadousuasistema-principal=codestusuasistema-seleccion=descripcion-tipo=modificar',
    dataType : 'xml',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Estado Usuario',
        bclass : 'anadir'
    }
    ],
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
}



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
    form = '';
    config = new Object(); 
    
    URL = document.URL;
    if( URL.indexOf("tabs-") ) {
    //  alert( URL.lastIndexOf('tabs-') );
    }
    
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
        
        $("#pestana").val($("#tabs > ul > li > a[href*='#tabs-"+ ($("#tabs").tabs('option', 'selected') + 1) +"']").attr('id'));
        
        $("#tabs").bind('tabsselect', function( event, ui ){
            
            
            $("#pestana").val($("#tabs > ul > li > a[href*='#tabs-"+ (ui.index + 1) +"']").attr('id'));
            
            
        //alert($("#tabs > ul > li > a[href*='#tabs-"+ (ui.index + 1) +"']").attr('id'));
        }) 
        
        
    });

    $('.flexigrid tr[id*="row"]').live({
        dblclick : function() {
            id = $(this).attr('id').substr(3);
            codigoSeleccion = id.split("_");
            codigoSeleccion = codigoSeleccion[ 1 ].split("-");
            descripcion = $('tr[id="' + $(this).attr('id') + '"] > td[abbr="'+ codigoSeleccion[ 1 ] +'"] > div > span').html();
            selCombo( codigoSeleccion[ 0 ], descripcion );
            $("#servletActivo").val('');
        },
        mouseover : function() {
            $(this).css('cursor','pointer');
        }
    });


});

function eliminarElementos() {
    elementos = seleccionados().split(',');
    //if( elementos.length != 1 ) {
    $("#codigo").val( elementos );
    accionFormulario($("#servlet").val(), 'Eliminar', '')
//}
    
    
}
function seleccionados() {
    elementos  = '';
    $('.trSelected').each( function(){
        id = $(this).attr('id').substr(3);
        nombreCodigo = id.split("_");
        //console.log( nombreCodigo );
        nombreCodigo = nombreCodigo[ 1 ].split("-");
        elementos += nombreCodigo[ 0 ] + ',';
        
        
    });

    

    return elementos;
}

function modificar( codigo ) {
    $("#codigo").val(codigo);
    $("#accion").val('Obtener');
    //    if( $("#servletActivo").val() != '' ) {
    //        abrirPagina( $("#servletActivo").val() + '.jsp' );
    //        accion( '../' + $("#servletActivo").val(), $('form[id='+ $("#servlet").val() +']').serialize());
    //    } else {
    accion( '../' + $("#servlet").val(), $('form[id='+ $("#servlet").val() +']').serialize());
//  }
}
function modificarElemento(  ){
    elementos = seleccionados().split(',');
    
    if( elementos.length == 2 ) {
        modificar( elementos.toString().substring(0, elementos.toString().length - 1 ))  ;
    } else if( elementos.length == 1) {
        bottomMensaje('Debe seleccionar al menos un elemento','Modificaci&oacute;n', 'e')  ;
        
    } else if( elementos.length > 2) { 
        bottomMensaje('No es posible modificar mas de un elemento','Modificaci&oacute; multiple no permitida', 'e')  ;
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
        console.log( rel );
        $.post('../edinstancias', {
            'parametros' : 'opcion=campos-tabla='+ datos['tabla']
        }, function( data ) {
            flexiParametros.url += '-relacion=' + rel
            $("#combo").val( combo );
            $("#servletActivo").val( ( $("#servlet").val() == datos['servlet'] ? '' :  datos['servlet'] ) );
            $("#tablaContenedor").html("<div id=\"tabla\"></div>");
            //var columnas = $.parseJSON( data );
            //var  searchitems = $.parseJSON( data );
            columnas = data;
            searchitems = data;
            //flexiParametros
            // Botones
            botones = flexiParametros.buttons;

            if( botones.length <= 2 ) {
                botones.push( {
                    name : 'Modificar', 
                    onpress : modificarElemento,
                    bclass : 'modificar'
                }, {
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
                    //                    console.log( botones );
                    botones = new Array();
                //                    console.log( botones );
                //                    console.log("Cerrar")
                },
                modal : true, // Para oscurecer la pantalla
                buttons : {
                    "Cerrar" : function() {
                        tabExiste =  0; 
                        $( this ).dialog("close");
                        $("#tabla").remove();
                        $("#servletActivo").val('');
                        
                        
                    
                    }
                }
            });        
 
        }, 'json');
    } else {
    // console.log('no entra, grid creado jeje');
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
function cerrarMensaje( rediret ) {
    $("#mensaje").fadeOut(1000, function() {
        $(this).dialog('close');
        if( rediret == 's') {
            redireccionar(document.URL);
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
    campos = datos.split(":");
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