<%
String jsp = request.getParameter("js");
if( jsp.indexOf("?") == 0 ) {
    String[] jspCorte = jsp.split("?");
    jsp = jspCorte[ 0 ];
    
}
jsp = jsp.substring(0, jsp.length() - 4 );
String[] titulo = jsp.split("/");

int puerto = request.getServerPort();
String ext = (puerto == 8084 ? ".js" : ".js.min");

%>

        <script type="text/javascript" src="../js/jquery/jquery.js">
        </script>
        <title><%=  titulo[ 2 ] %> </title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" media="all" href="../css/delphos.css" /><!--<link rel="stylesheet" type="text/css" media="all" href="../js/jsCalendar/skins/aqua/theme.css" title="Aqua" />-->
        <link href="../images/favicon.ico" rel="Shortcut Icon" type="image/x-icon" />
        <link type="text/css" href="../js/jquery-ui/css/south-street/jquery-ui-1.8.2.custom.css" rel="Stylesheet" />
        <script type="text/javascript" src="../js/jquery-ui/js/jquery-ui-1.8.2.custom.min.js">
        </script>
        <script type="text/javascript" src="../js/timepicker/timepicker.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/formularios/general.css" />
        <script type="text/javascript" src="../js/formularios/funciones<%= ext %>">
        </script>
        <script type="text/javascript" src="../js/formularios/flexis<%= ext %>">
        </script>
        <script type="text/javascript" src="../js<%= jsp %><%= ext %>">
        </script>
        <link rel="stylesheet" type="text/css" href="../js/flexigrid/css/flexigrid.css" />
        <script type="text/javascript" src="../js/flexigrid/js/flexigrid.js">
        </script>
        <script type="text/javascript" src="../js/ajax-switch/ajax-switch/jquery.iphone-switch.js">
        </script>
        <style type="text/css">
            /*<![CDATA[*/
            body {
                background-color: #FFFFFF;
            }
            div.c6 {text-align: center}
            table.c5 {height: 780; border: 0px}
            td.c4 {background: url('../images/back.png')}
            td.c3 {background: url('../images/panel_02.gif')}
            input.c2 {display:none}
            div.c1 {display: none}
            /*]]>*/
        </style>