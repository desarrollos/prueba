//## {flexiNormas-normas}
flexiNormas = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=normas-principal=codtiponorma,codnorma,fechanorma-seleccion=referencia-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codtiponorma', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva NormA', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiTipoNorma-tiponorma}
flexiTipoNorma = { 
	url : '../edinstancias?parametros=opcion=tabla-tabla=tiponorma-principal=codtiponorma-seleccion=descripcion-tipo=modificar', 
	dataType : 'xml', 
	height: 280, 
	width : 850, 
	usepager : true, 
	rp : 30, 
	sortname: 'codtiponorma', 
	sortorder: 'asc', 
	buttons : [ 
	{ 
	name : 'Agregar Nuevo Tipo Norma', 
	bclass : 'anadir' 
	} 
	] 
}; 

//## {flexiSubsidioAsignado-subsidioasignado}
flexiSubsidioAsignado = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=subsidioasignado-principal=codunifami,codtipoidentidad,subpotidenti-seleccion=codunifami-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codunifami', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Subsidio Asignado', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiSubsidioPotencial-subsidiopotencial}
flexiSubsidioPotencial = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=subsidiopotencial-principal=codunifami,codtipoidentidad,subpotidenti-seleccion=codunifami-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codunifami', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Subsidio Potencial', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiSubsidioMunicipio-subsidiomunicipio}
flexiSubsidioMunicipio = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=subsidiomunicipio-principal=subscodigo,coddepartamento,codmunicipio-seleccion=subscodigo-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'subscodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Subsidio Municipio', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiSubsidio-subsidio}
flexiSubsidio = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=subsidio-principal=subscodigo-seleccion=subsdescripc-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'subscodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Subsidio', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiQuejaRespuesta-quejarespuesta}
flexiQuejaRespuesta = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=quejarespuesta-principal=codunifami,quejconsecut-seleccion=codunifami-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codunifami', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuev', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiTipoRequisito-tiporequisito}
flexiTipoRequisito = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=tiporequisito-principal=codtiporequisito-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codtiporequisito', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Requisito', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiRequisitosFamilias-requisitos}
flexiRequisitosFamilias = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=requisitos-principal=codtiporequisito,coditipben,codactividadsalud-seleccion=requisdescri-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codactividadsalud', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Requisito ', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiTipoCorporativa-tipocorporativa}
flexiTipoCorporativa = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipocorporativa-principal=tipcorcodigo-seleccion=tipcordescripc-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'tipcorcodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Tipo Corporativa', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiEstadoCorporativa-estadocorporativa}
flexiEstadoCorporativa = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadocorporativa-principal=estcorcodigo-seleccion=estcordescripc-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'estcorcodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Estado Corporativa', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiImagenCorporativa-imagencorporativa}
flexiImagenCorporativa = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=imagencorporativa-principal=imacorid-seleccion=imacorid-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'imacorid', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Imagen Corporativa', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiEstadoCumplimactividad-estadocumplimactividad}
flexiEstadoCumplimactividad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadocumplimactividad-principal=codestadocumplimactividad-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codestadocumplimactividad', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Estado Cumplimiento', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiEscolaridadPeriodico-escregperiodico}
flexiEscolaridadPeriodico = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=escregperiodico-principal=codtipoidentidadins,codempresa,codtipoidentidad,escidentific,escvigencia,espefechinic,espefechfina-seleccion=codtipoidentidadins-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codtipoidentidadins', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Escolaridad Periodico', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiEscolaridadNovedad-escolaridadnovedad}
flexiEscolaridadNovedad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=escolaridadnovedad-principal=codtipoideninsact,codempresaact,codtipoidentidadest,escidentificest,escvigencia,escnovconsec-seleccion=escnovconsec-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'escnovconsec', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Escolaridad Novedad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiEscolaridadEstado-escolaridadestado}
flexiEscolaridadEstado = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=escolaridadestado-principal=escestcodigo-seleccion=escescdescri-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'escescdescri', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Escolaridad Estado', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiViolenciaIntraFamiliar-violenciaintrafamiliar}
flexiViolenciaIntraFamiliar = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=violenciaintrafamiliar-principal=viointid-seleccion=viointid-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'viointid', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Registro Acción Violencia', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiEstadoRegistro-estadoregistro}
flexiEstadoRegistro = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadoregistro-principal=codestadoregistro-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codestadoregistro', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Estado Registro', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiEncabezadoArchivo-encabezadoarchivo}
flexiEncabezadoArchivo = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=encabezadoarchivo-principal=idencabezado-seleccion=idencabezado-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'idencabezado', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Encabezado', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiListaCamposArchivo-listacamposarchivo}
flexiListaCamposArchivo = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=listacamposarchivo-principal=codcampoarchivo-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codcampoarchivo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Lista Campo Archivo', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiTipoNovedad-tiponovedad}
flexiTipoNovedad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=tiponovedad-principal=codtiponovedad-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codtiponovedad', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Tipo Novedad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiNovedadDocumento-novedaddocumento}
flexiNovedadDocumento = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=novedaddocumento-principal=noveconsecut,codtipodctoasociado,codtiponovedad,novcaucodigo-seleccion=noveconsecut-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'noveconsecut', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Novedad Documento', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiNovedadCampo-novedadcampo}
flexiNovedadCampo = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=novedadcampo-principal=idusuario,codtiponovedad,codcampoarchivo,fecha-seleccion=idusuario-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'idusuario', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Novedad Campo', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiNovedad-novedad}
flexiNovedad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=novedad-principal=noveconsecut-seleccion=noveconsecut-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'noveconsecut', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Novedad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiTipoPersona-tipopersona}
flexiTipoPersona = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipopersona-principal=tippercodigo-seleccion=tipperdescri-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'tippercodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Tipo Persona', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiTipoTitular-tipotitular}
flexiTipoTitular = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipotitular-principal=coditiptit-seleccion=desctiptit-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'coditiptit', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Tipo Tiular', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiGrupoTiular-grupotitular}
flexiGrupoTiular = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=grupotitular-principal=codclagrutit,codunifami,codtipoidentidad,identitfam-seleccion=identitfam-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'identitfam', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Grupo Titular', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiRequisitos-requisitos}
flexiRequisitos = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=requisitos-principal=codtiporequisito,coditipben,codactividadsalud-seleccion=codtiporequisito-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codtiporequisito', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Requisito', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiTitularFamilia-grupotitular}
flexiTitularFamilia = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=titularfamilia-principal=codclagrutit,codunifami,codtipoidentidad,identitfam-seleccion=identitfam-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'identitfam', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Titular Familia', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiRegistroEstimulacionTemprana-estimulaciontemprana}
flexiRegistroEstimulacionTemprana = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=estimulaciontemprana-principal=esttemid-seleccion=esttemid-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'esttemid', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Estimulacion Temprana', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiActividadesNutricionales-nutricionregistro}
flexiActividadesNutricionales = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=nutricionregistro-principal=nutregid-seleccion=nutregid-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'nutregid', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Actividad Nutricional', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiTipoViolencia-tipoviolencia}
flexiTipoViolencia = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoviolencia-principal=tipviocodigo-seleccion=tipviodescri-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'tipviocodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Tipo Violencia Intrafamiliar', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiEstadoincripIps-estadoincripips}
flexiEstadoincripIps = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadoincripips-principal=esinipscodigo-seleccion=esinipsdescri-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'esinipscodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Estado Inscripci&oacute;n IPS', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiTipoEstimulacion-tipoestimulacion}
flexiTipoEstimulacion = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoestimulacion-principal=tipestcodigo-seleccion=tipestdescri-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'tipestcodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Tipo Estimulacion Temprana', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiSubsidioCategoria-subsidiocategoria}
flexiSubsidioCategoria = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=subsidiocategoria-principal=subcatcodigo-seleccion=subcatdescri-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'subcatcodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Categoria Subsidio', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {FlexiGrupoActividad-grupoactividad}
FlexiGrupoActividad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=grupoactividad-principal=codgrupoactividad-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Grupo Actividad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiActividadSalud-actividadsalud}
flexiActividadSalud = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=actividadsalud-principal=codactividadsalud-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Actividad Salud', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiClaseBeneficiario-clasebeneficiario}
flexiClaseBeneficiario = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=clasebeneficiario-principal=clabencodigo-seleccion=clabencodigo-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'clabencodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Clase Beneficiario', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiSubsidioCategoria-subsidiocategoria}
flexiSubsidioCategoria = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=subsidiocategoria-principal=subcatcodigo-seleccion=subcatdescri-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'subcatdescri', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Categoria Subsidio', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiManualActividad-manualactividad}
flexiManualActividad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=manualactividad-principal=codmanualactividad-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Manual Actividad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiProtocoloActividad-protocoloactividad}
flexiProtocoloActividad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=protocoloactividad-principal=codprotocolo-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Protocolo Actividad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiCategoriaActividad-categoriaactividad}
flexiCategoriaActividad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=categoriaactividad-principal=codcategactividad-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Categoria Actividad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiTipoActividad-tipoactividad}
flexiTipoActividad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoactividad-principal=codtipoactividad-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Tipo Actividad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiConceptoServicio-conceptoservicio}
flexiConceptoServicio = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=conceptoservicio-principal=codconceptoservicio-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Concepto Servicio', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiClaseActividad-claseactividad}
flexiClaseActividad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=claseactividad-principal=codclaseactividad-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Clase Actividad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiAmbitoActividad-ambitoactividad}
flexiAmbitoActividad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=ambitoactividad-principal=codambito-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Ambito Actividad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiSubGrupoAcitivdad-subgrupoactividad}
flexiSubGrupoAcitivdad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=subgrupoactividad-principal=codgrupoactividad,codsubgrupo-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Sub Grupo Actividad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiEscGrupoGrado-escgrupogrado}
flexiEscGrupoGrado = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=escgrupogrado-principal=grugracodigo-seleccion=grugradescri-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'grugracodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Grupo Escolaridad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiEscolaridad-escolaridad}
flexiEscolaridad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=escolaridad-principal=codtipoidentidadins,codempresa,codtipoidentidad,escidentific,escvigencia-seleccion=codempresa-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'escvigencia', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Escolaridad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiEstadoBeneficiario-estadobeneficiario}
flexiEstadoBeneficiario = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadobeneficiario-principal=codiestben-seleccion=descestben-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descestben', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Estado  Beneficiario', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiEscolaridadGrado-escolaridadgrado}
flexiEscolaridadGrado = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=escolaridadgrado-principal=escgracodigo-seleccion=escgradescri-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'escgradescri', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Nivel Escolaridad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 


//## {flexiTipoParentesco-tipoparentesco}
flexiTipoParentesco = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoparentesco-principal=codtipoparentesco-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Tipo Parentesco', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 



//## {flexiFinalidadConsulta-finalidadconsulta}
flexiFinalidadConsulta = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=finalidadconsulta-principal=codfinalidadconsulta-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Finalidad Consulta', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiNutricionValoracion-nutricionvaloracion}
flexiNutricionValoracion = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=nutricionvaloracion-principal=nutridregist-seleccion=nutrcantidad-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'nutridregist', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Valoracion Nutricional', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiSubgrupoDiagnostico-subgrupodiagnostico}
flexiSubgrupoDiagnostico = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=subgrupodiagnostico-principal=codgrupodiagn,codsubgrupodiagn-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Grupo Diagnostico', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiNivelComplejidad-nivelcomplejidad}
flexiNivelComplejidad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=nivelcomplejidad-principal=codnivelcomplejidad-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Nivel Complejidad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiProtocoloDiagnostico-protocolodiagnostico}
flexiProtocoloDiagnostico = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=protocolodiagnostico-principal=codprotocodiagn-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Protocolo Diagnostico', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiManualDiagnostico-manualdiagnostico}
flexiManualDiagnostico = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=manualdiagnostico-principal=codmanualdiagnostico-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codmanualdiagnostico', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Manual Diagnostico', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiEventoEpidemiologico-eventoepidemiologico}
flexiEventoEpidemiologico = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=eventoepidemiologico-principal=codeventoepidem-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Evento Epidemiologico', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiAmbitoDiagnostico-ambitodiagnostico}
flexiAmbitoDiagnostico = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=ambitodiagnostico-principal=codambitodiagnostico-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Ambito Diagnostico', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiClaseDiagnostico-clasediagnostico}
flexiClaseDiagnostico = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=clasediagnostico-principal=codclasediagnostico-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Clase Diagnostico', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiDiagnostico3char-diagnostico3char}
flexiDiagnostico3char = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=diagnostico3char-principal=coddiagnostico3char-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Diagnostico  3 Char', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiDiagnosticos298-diagnostico298}
flexiDiagnosticos298 = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=diagnostico298-principal=coddiag298-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'descripcion', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Diagnostico 298', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiDiagnostico-diagnostico}
flexiDiagnostico = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=diagnostico-principal=coddiagnostico-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'coddiagnostico', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Diagnostico ', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiTipoEducacion-tipoeducacion}
flexiTipoEducacion = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoeducacion-principal=tipeducodigo-seleccion=tipedudescri-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'tipeducodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Tipo Educacion', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiFirmasAutorizadas-firmasautorizadas}
flexiFirmasAutorizadas = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=firmasautorizadas-principal=codtipoidentidadfir,firmidentifi-seleccion=firmidentifi-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'firmidentifi', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nueva Firma Autorizada', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
};
//## {flexiGradoEscolaridad-escolaridadgrado}
flexiGradoEscolaridad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=escolaridadgrado-principal=escgracodigo-seleccion=escgradescri-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'escgracodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Grado Escolaridad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 
//## {flexiTipoSubsidio-tiposubsidio}
flexiTipoSubsidio = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=tiposubsidio-principal=subtipcodigo-seleccion=subtipdescri-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'subtipcodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Tipo Subsidio', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiDocumentoInscripcion-documentoinscripcion}
flexiDocumentoInscripcion = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=documentoinscripcion-principal=codunifami,codtipodctoasociado-seleccion=descripcion-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'codtipodctoasociado', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Documento Inscripción', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 

//## {flexiFuncionario-funcionario}
flexiFuncionario = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=funcionario-principal=codtipoidentidad,numidentfunc-seleccion=nombre-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'numidentfunc',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Funcionario',
        bclass : 'anadir',
        onpress : agregar
    }
    ]
};
//## {flexiTipoBeneficiario-tipobeneficiario}
flexiTipoBeneficiario = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipobeneficiario-principal=coditipben-seleccion=desctipben-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'coditipben',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Tipo Beneficiario',
        bclass : 'anadir',
        onpress : agregar
    }
    ]


};
//## {flexiEstadoEscolaridad-escolaridadestado}
flexiEstadoEscolaridad = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=escolaridadestado-principal=escestcodigo-seleccion=escescdescri-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'escestcodigo',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Estado Escolaridad',
        bclass : 'anadir',
        onpress : agregar
    }
    ]


};
//## {flexiBeneficiario-beneficiario}
flexiBeneficiario = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=beneficiario-principal=codunifami,codtipoidentidad,identbenef-seleccion=identbenef-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'identbenef',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Beneficiario',
        bclass : 'anadir',
        onpress : agregar
    }
    ]


};

//## {flexiBanco-banco}
flexiBanco = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=banco-principal=codbanco-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codbanco',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Banco',
        bclass : 'anadir',
        onpress : agregar
    }
    ]


};
//## {flexiVinculacion-inscripcion}
flexiVinculacion = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=inscripcion-principal=codunifami-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codunifami',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nueva Inscripcion',
        bclass : 'anadir',
        onpress : agregar
    }
    ]


};
//## {flexiDocumentoCausal-documentocausal}
flexiDocumentoCausal = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=documentocausal-principal=codtiponovedad,novcaucodigo,codtipodctoasociado-tipo=modificar-seleccion=codtipodctoasociado',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'novcaucodigo',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Documento Causal',
        bclass : 'anadir',
        onpress : agregar
    }
    ]


};
//## {flexiDocumentoQuejas-quejadocumento}
flexiDocumentoQuejas = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=quejadocumento-principal=codunifami,quejconsecut,codtipodctoasociado-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'quejconsecut',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Documento Queja',
        bclass : 'anadir',
        onpress : agregar
    }
    ]


};

//## {flexiClaseGrupoTitular-clasegrupotitular}
flexiClaseGrupoTitular = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=clasegrupotitular-principal=codclagrutit-seleccion=descclagrutit-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codclagrutit',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nueva Clase Grupo Titular',
        bclass : 'anadir',
        onpress : agregar
    }
    ]


};
//## {flexiEstadoTitular-estadotitular}
flexiEstadoTitular = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadotitular-principal=codiesttit',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codiesttit',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Estado Titular',
        bclass : 'anadir',
        onpress : agregar
    }


    ]


};
//## {flexiTipoTitular-tipotitular}
flexiTipoTitular = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipotitular-principal=coditiptit-seleccion=desctiptit',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'coditiptit',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Tipo Titular',
        bclass : 'anadir',
        onpress : agregar
    }


    ]


};
//## {flexiEstadoFamilia-estadofamilia}
flexiEstadoFamilia = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadofamilia-principal=codiestfam-seleccion=descestfam',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codiestfam',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Estado Familia',
        bclass : 'anadir',
        onpress : agregar
    }


    ]


};
//## {flexiTipoPoblacion-tipopoblacion}
flexiTipoPoblacion = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipopoblacion-principal=codtipopoblacion',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codtipopoblacion',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Tipo Poblacion',
        bclass : 'anadir',
        onpress : agregar
    }


    ]


};

//## {flexiQuejasDocumentos-reclamodocumento}
flexiQuejasDocumentos = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamodocumento-principal=codtipopoblacion',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codtipopoblacion',
    sortorder: 'asc',
    buttons : [
    {
        name : 'Agregar Nuevo Tipo Poblacion',
        bclass : 'anadir',
        onpress : agregar
    }


    ]


};

//## {flexiTipoNovedadCausal-tiponovedad}
flexiTipoNovedadCausal ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=tiponovedad-principal=codtiponovedad-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Novedad Causal',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
}

//## {flexiNovedadCausal-novedadcausal}
flexiNovedadCausal ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=novedadcausal-principal=codtiponovedad,novcaucodigo-seleccion=novcaudescri-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'novcaudescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Novedad Causal',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'novcaudescri',
    sortorder: 'asc'
}

//## {flexiEntidadSalud-entidadsalud}
flexiEntidadSalud = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=entidadsalud-principal=codregimenes,codentidadsalud-seleccion=nombrehabilitacion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codentidadsalud',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar nueva entidad salud',
        bclass : 'anadir',
        onpress : agregar
    }
    ]
};


//## {flexiQuejaClasificacion-quejaclasificacion}
flexiQuejaClasificacion = {
 
    url : '../edinstancias?parametros=opcion=tabla-tabla=quejaclasificacion-seleccion=quecladescri-principal=tipquecodigo,queclacodigo',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'quecladescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Reclamo Clasificacion',
        bclass : 'anadir',
        onpress : agregar
    }]

}
//## {flexiQuejas-quejas}
flexiQuejas ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=quejas-principal=quejconsecut,codunifami-tipo=modificar-seleccion=quejconsecut',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'quejconsecut',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Clasificación Queja',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'quejconsecut',
    sortorder: 'asc'
}



//## {flexiQuejaBeneficiario-inscripcion}
flexiQuejaBeneficiario ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=quejabeneficiario-principal=codunifami,quejconsecut,codtipoidentidad,identbenef-seleccion=codunifami-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codunifami',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Clasificación Queja',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'codunifami',
    sortorder: 'asc'
}

//## {flexiReclamoTipo-reclamotipo}
flexiReclamoTipo ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamotipo-principal=rectipcodigo-seleccion=rectipdescri-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'rectipdescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Reclamo',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'rectipdescri',
    sortorder: 'asc'

}
//## {flexiReclamoTipo-reclamotipo}
flexiReclamoTipo ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamotipo-principal=rectipcodigo-seleccion=rectipdescri-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'rectipdescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Reclamo',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'rectipdescri',
    sortorder: 'asc'

}
//## {flexiTipoSatisfaccion-satisfacciontipo}
flexiTipoSatisfaccion ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=satisfacciontipo-principal=tipsatcodigo-seleccion=tipsatdescri-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'tipsatdescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Satisfaccion',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'tipsatdescri',
    sortorder: 'asc'

}
//## {flexiRespuestaClasificacion-respuestaclasificacion}
flexiRespuestaClasificacion ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=respuestaclasificacion-principal=resclacodigo-seleccion=rescladescri-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'rescladescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Respuesta Clasificacion',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'rescladescri',
    sortorder: 'asc'

}
//## {flexiTipoQueja-tipoqueja}
flexiTipoQueja ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoqueja-principal=tipquecodigo-seleccion=tipquedescri-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'tipquedescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Queja',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'tipquedescri',
    sortorder: 'asc'

}
//## {flexiEncuentroreunion-encuentroreunion}
flexiEncuentroreunion ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=encuentroreunion-principal=encuencodigo-seleccion=encuencodigo-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'encutemaprin',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Encuentro o Reunion',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'encuencodigo',
    sortorder: 'asc'

}
//## {flexiClasificacionReclamo-reclamoclasificacion}
flexiClasificacionReclamo ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamoclasificacion-principal=rectipcodigo,recclacodigo-seleccion=reccladescri-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'reccladescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Clasificación Reclamo',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'reccladescri',
    sortorder: 'asc'
}

//## {flexiReclamoClasificacion-reclamoclasificacion}
flexiReclamoClasificacion = {
 
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamoclasificacion-seleccion=reccladescri-principal=rectipcodigo,recclacodigo',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'reccladescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Reclamo Clasificacion',
        bclass : 'anadir',
        onpress : agregar
    }]

}


//## {flexiInscripcion-inscripcion}
flexiInscripcion ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=inscripcion-principal=codunifami-seleccion=codunifami-tipo=modificar',
    dataType : 'xml', 
    form : 'Vinculacion.jsp?#tabs-1',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'encutemaprin',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Inscripción',
        bclass : 'anadir',
        onpress : agregar,
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'codunifami',
    sortorder: 'asc'
}
//## {flexiTipoReclamo-reclamotipo}
flexiTipoReclamo ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamotipo-principal=rectipcodigo-seleccion=rectipdescri-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'rectipdescri',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Reclamo',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'rectipdescri',
    sortorder: 'asc'
}

//## {flexiAsistencia-asistentesreunion}
flexiAsistencia ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=asistentesreunion-principal=encuencodigo,codtipoidentidad,asisteidenti-seleccion=encuencodigo-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'encutemaprin',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Asistencia',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'encuencodigo',
    sortorder: 'asc'
}

//## {flexiGrupoSeguridad-gruposeguridad}
flexiGrupoSeguridad = {
 
    url : '../edinstancias?parametros=opcion=tabla-tabla=gruposeguridad-seleccion=grusegdescripcion-principal=grusegcodigo-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'grusegdescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Grupo Seguridad',
        bclass : 'anadir',
        onpress : agregar
    }]

}
//## {flexiTipoReunion-tiporeunion}
flexiTipoReunion = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tiporeunion-principal=coditiporeun-seleccion=desctiporeun-tipo=modificar-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Tipo Reunion',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'desctiporeun',
    sortorder: 'asc'     
}
//## {flexiTipoSistema-tiposistema}
flexiTipoSistema = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tiposistema-principal=tisiscodigo-seleccion=tisisdescrip-tipo=modificar-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Tipo Sistema',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'tisisdescrip',
    sortorder: 'asc'     
}
//## {flexiEstadosUsuarios-estadousuasistema}
flexiEstadosUsuarios = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadousuasistema-principal=codestusuasistema-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Estado Usuario',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'   
}
//## {flexiPlanSalud-plansalud}
flexiPlanSalud = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=plansalud-principal=codplansalud-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Plan Salud',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'   
}

//## {flexiActividadEconomica-actividadeconomica}
flexiActividadEconomica = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=actividadeconomica-principal=codactividadeconomica-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Actividad Economica',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'   
}
//## {flexiTipoAportante-tipoaportante}
flexiTipoAportante = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoaportante-principal=codtipoaportante-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Actividad Economica',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'   
}
//## {flexiTipoContribuyente-tipocontribuyente}
flexiTipoContribuyente = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipocontribuyente-principal=codtipocontribuyente-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Actividad Economica',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'   
}
//## {flexiBarrio-barrio}
flexiBarrio = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=barrio-principal=coddepartamento,codmunicipio,codsubgrupo,codbarrio-seleccion=nombre-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Barrio',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'nombre',
    sortorder: 'asc'   
}
//## {flexiClasePersona-clasepersona}
flexiClasePersona = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=clasepersona-principal=codclasepersona-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Clase Persona',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'   
}

//## {flexiSubGrupoGeografico-subgrupogeografico}
flexiSubGrupoGeografico = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=subgrupogeografico-principal=codsubgrupo-seleccion=nombre-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Sub Grupo Geografico',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'nombre',
    sortorder: 'asc'   
}
//## {flexiMunicipio-municipio}
flexiMunicipio = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=municipio-principal=coddepartamento,codmunicipio-seleccion=nombre-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Municipio',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'nombre',
    sortorder: 'asc'   
}
//## {flexiDepartamento-departamento}
flexiDepartamento = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=departamento-principal=coddepartamento-seleccion=nombre-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Departamento',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'nombre',
    sortorder: 'asc'   
}

//## {flexiOrigenRecurso-origenrecurso}
flexiOrigenRecurso = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=origenrecurso-seleccion=ordescripcion-principal=orcodigo-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'ordescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Origen Recurso',
        bclass : 'anadir',
        onpress : agregar
    }]
}


//## {flexiReclamos-reclamo}
flexiReclamos = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamo-seleccion=reclamconsec-principal=codunifami,reclamconsec-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'ordescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Reclamo',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'reclamconsec',
    sortorder: 'asc'  
}
//## {flexiTipoDocumentoAsociado-tipodctoasociado}
flexiTipoDocumentoAsociado = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipodctoasociado-seleccion=descripcion-principal=codtipodctoasociado-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'ordescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Documento Asociado',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'  
}
//## {flexiSatifaccionTipo-satisfacciontipo}
flexiSatifaccionTipo = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=satisfacciontipo-seleccion=tipsatdescri-principal=tipsatcodigo-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'ordescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Tipo Satisfacción',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'tipsatdescri',
    sortorder: 'asc'  
}
//## {flexiReclamoDocumentos-reclamodocumento}
flexiReclamoDocumentos = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamodocumento-seleccion=reclamconsec-principal=reclamconsec,codunifami,codtipodctoasociado-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'ordescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Documento Reclamo',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'reclamconsec',
    sortorder: 'asc'  
}
//## {flexiReclamoBeneficiario-reclamobeneficiaro}
flexiReclamoBeneficiario = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=reclamobeneficiaro-seleccion=reclamconsec-principal=codunifami,reclamconsec,codtipoidentidad,identbenef-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'ordescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Reclamo Beneficiario',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'reclamconsec',
    sortorder: 'asc'  
}
//## {flexiRespuestasReclamo-respuestareclamo}
flexiRespuestasReclamo = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=respuestareclamo-seleccion=reclamconsec-principal=codunifami,reclamconsec-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'ordescripcion',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nuevo Reclamo Beneficiario',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'reclamconsec',
    sortorder: 'asc'  
}

//## {flexiEmpresas-empresa}
flexiEmpresas = {
    
    url : '../edinstancias?parametros=opcion=tabla-tabla=empresa-seleccion=nombre-principal=codtipoidentidad,codempresa-servlet=Empresas-tipo=modificar',
    form : 'Empresas.jsp',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'nombre',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Empresa',
        bclass : 'anadir',
        onpress : agregar,
        onpress : agregar
    }]
}
//## {flexiComplejidad-nivelcomplejidad}
flexiComplejidad = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=nivelcomplejidad-principal=codnivelcomplejidad-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    usepager : true,
    rp : 30,
    sortname: 'codnivelcomplejidad',
    sortorder: 'asc',
    buttons : [{
        name : 'Agregar Nueva Complejidad',
        bclass : 'anadir',
        onpress : agregar
    }]
};
//## {flexiEstadoentidadsalud-estadoentidadsalud}
flexiEstadoentidadsalud = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadoentidadsalud-seleccion=descripcion-principal=codestadoentidad-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Estado Entidad Salud',
        bclass : 'anadir',
        onpress : agregar
    }],
   
    usepager : true,
    rp : 30,
    sortname: 'codestadoentidad',
    sortorder: 'asc'
};

//## {flexiTipoatencion-tipoatencion}
flexiTipoatencion = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoatencion-seleccion=descripcion-principal=codtipoatencion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Atencion',
        bclass : 'anadir',
        onpress : agregar
    }],
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
};
//## {flexiTipoespecializacionsalud-tipoespecializacionsalud}
flexiTipoespecializacionsalud = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoespecializacionsalud-principal=codtipoespecializacion-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Especializacion',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
};
//## {flexiEstadosGruposSeguridad-estadogruposeguridad}
flexiEstadosGruposSeguridad =  {
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadogruposeguridad-principal=esgrsecodigo-seleccion=esgrsedescripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Estado Grupo Seguridad',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'esgrsedescripcion',
    sortorder: 'asc'
}
//## {flexiNivelsegopcion-nivelsegopcion}
flexiNivelsegopcion ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=nivelsegopcion-principal=niseopcodigo-seleccion=niseopdescripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Modificar', 
        onpress : modificarElemento,
        bclass : 'modificar'
    },{
        name : 'Agregar Nuevo Perfil',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'niseopdescripcion',
    sortorder: 'asc'    
}
//## {flexiTipoActividad-tipoactividad}
flexiTipoActividad ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoactividad-principal=codtipoactividad-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Modificar', 
        onpress : modificarElemento,
        bclass : 'modificar'
    },{
        name : 'Agregar Nuevo Tipo Actividad',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'    
}

//## {flexiTipoAsistente-tipoasistente}
flexiTipoAsistente ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoasistente-principal=tipasicodigo-seleccion=tipasidescri-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Tipo Asistente',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'tipasidescri',
    sortorder: 'asc'    
}

//## {flexiAsistenteExterno-encuenasistenteexterno}
flexiAsistenteExterno ={
    url : '../edinstancias?parametros=opcion=tabla-tabla=encuenasistenteexterno-principal=encuencodigo,codtipoidentidad,externidenti-seleccion=externidenti-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Asistente',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'externidenti',
    sortorder: 'asc'    
}


//## {flexiListaOpcion-listaopcion}
flexiListaOpcion =  {
    url : '../edinstancias?parametros=opcion=tabla-tabla=listaopcion-principal=lisopccodigo-seleccion=lisopcdescripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Lista Opcion',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'lisopcdescripcion',
    sortorder: 'asc'
}

//## {flexiGruposSeguridad-gruposeguridad}
flexiGruposSeguridad =  {
    url : '../edinstancias?parametros=opcion=tabla-tabla=gruposeguridad-principal=grusegcodigo-seleccion=grusegdescripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Grupo Seguridad',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'grusegdescripcion',
    sortorder: 'asc'
}
//## {flexiSectorEntidad-sectorentidad}
flexiSectorEntidad =  {
    url : '../edinstancias?parametros=opcion=tabla-tabla=sectorentidad-principal=codsectorentidad-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Sector Entidad',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
}
//## {flexiEncuentroActividad-encuentroactividad}
flexiEncuentroActividad = { 
    url : '../edinstancias?parametros=opcion=tabla-tabla=encuentroactividad-principal=encuencodigo,codtipoactividad-seleccion=encuencodigo-tipo=modificar', 
    dataType : 'xml', 
    form : '', 
    height: 280, 
    width : 850, 
    usepager : true, 
    rp : 30, 
    sortname: 'encuencodigo', 
    sortorder: 'asc', 
    buttons : [ 
    { 
        name : 'Agregar Nuevo Encuentro Actividad', 
        bclass : 'anadir',
        onpress : agregar 
    } 
    ] 
}; 





//## {flexiTipoIdentificacion-tipoidentificacion}
flexiTipoIdentificacion = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoidentificacion-principal=codtipoidentidad-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Tipo Identificacion',
        bclass : 'anadir',
        onpress : agregar,
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
}
//## {flexiClasificacionentidad-clasificacionentidad}
flexiClasificacionentidad = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=clasificacionentidad-principal=codclasifentidad-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    
    buttons : [{
        name : 'Agregar Nueva Clasificacion Entidad',
        bclass : 'anadir',
        onpress : agregar
    }],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
};
//## {flexiRegimen-regimen}
flexiRegimen = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=regimen-principal=codregimen-seleccion=descripcion-tipo=modificar',
    form : 'Regimen.jsp',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Regimen',
        bclass : 'anadir',
        onpress : agregar,
            
        onpress : agregar
    }
    ],
    
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
};
//## {flexiEntidad-tipoentidadsalud}
flexiEntidad = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=tipoentidadsalud-principal=codtipoentidadsalud-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nueva Entidad',
        bclass : 'anadir',
        onpress : agregar
    }
    ],
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
};
//## {flexiEstadoUsuario-estadousuasistema}
flexiEstadoUsuario = {
    url : '../edinstancias?parametros=opcion=tabla-tabla=estadousuasistema-principal=codestusuasistema-seleccion=descripcion-tipo=modificar',
    dataType : 'xml', 
    form : '',
    height: 280,
    width : 850,
    buttons : [{
        name : 'Agregar Nuevo Estado Usuario',
        bclass : 'anadir',
        onpress : agregar
    }
    ],
    usepager : true,
    rp : 30,
    sortname: 'descripcion',
    sortorder: 'asc'
}