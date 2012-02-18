/*
   Deluxe Menu Data File
   Created by Deluxe Tuner v3.5
   http://deluxe-menu.com
*/


// -- Deluxe Tuner Style Names
var tstylesNames=["Individual Style","Individual Style","Individual Style","Individual Style",];
var tXPStylesNames=["Individual Style",];
// -- End of Deluxe Tuner Style Names

//--- Common
var tlevelDX=20;
var texpanded=0;
var texpandItemClick=0;
var tcloseExpanded=1;
var tcloseExpandedXP=0;
var ttoggleMode=1;
var tnoWrap=1;
var titemTarget="_blank";
var titemCursor="pointer";
var statusString="link";
var tblankImage="datat.files/blank.gif";
var tpathPrefix_img="";
var tpathPrefix_link="";

//--- Dimensions
var tmenuWidth="230px";
var tmenuHeight="";

//--- Positioning
var tabsolute=1;
var tleft="20px";
var ttop="40px";

//--- Font
var tfontStyle="normal 8pt Tahoma";
var tfontColor=["#3F3D3D","#7E7C7C"];
var tfontDecoration=["none","underline"];
var tfontColorDisabled="#ACACAC";
var tpressedFontColor="#AA0000";

//--- Appearance
var tmenuBackColor="";
var tmenuBackImage="";
var tmenuBorderColor="#FFFFFF";
var tmenuBorderWidth=0;
var tmenuBorderStyle="solid";

//--- Item Appearance
var titemAlign="left";
var titemHeight=22;
var titemBackColor=["#F0F1F5","#F0F1F5"];
var titemBackImage=["",""];

//--- Icons & Buttons
var ticonWidth=21;
var ticonHeight=15;
var ticonAlign="left";
var texpandBtn=["datat.files/expandbtn2.gif","datat.files/expandbtn2.gif","datat.files/collapsebtn2.gif"];
var texpandBtnW=9;
var texpandBtnH=9;
var texpandBtnAlign="left";

//--- Lines
var tpoints=0;
var tpointsImage="";
var tpointsVImage="";
var tpointsCImage="";
var tpointsBImage="";

//--- Floatable Menu
var tfloatable=0;
var tfloatIterations=10;
var tfloatableX=1;
var tfloatableY=1;

//--- Movable Menu
var tmoveable=0;
var tmoveHeight=12;
var tmoveColor="transparent";
var tmoveImage="datat.files/movepic.gif";

//--- XP-Style
var tXPStyle=1;
var tXPIterations=10;
var tXPBorderWidth=1;
var tXPBorderColor="#FFFFFF";
var tXPAlign="left";
var tXPTitleBackColor="#AFB1C3";
var tXPTitleBackImg="datat.files/xptitle_s.gif";
var tXPTitleLeft="datat.files/xptitleleft_s.gif";
var tXPTitleLeftWidth=4;
var tXPIconWidth=31;
var tXPIconHeight=32;
var tXPMenuSpace=10;
var tXPExpandBtn=["datat.files/xpexpand1_s.gif","datat.files/xpexpand1_s.gif","datat.files/xpcollapse1_s.gif","datat.files/xpcollapse1_s.gif"];
var tXPBtnWidth=25;
var tXPBtnHeight=23;
var tXPFilter=1;

//--- Advanced
var tdynamic=0;
var tajax=0;

//--- State Saving
var tsaveState=0;
var tsavePrefix="menu1";

var tstyles = [
    ["tfontStyle=bold 8pt Tahoma","tfontColor=#FFFFFF,#E6E6E6","tfontDecoration=none,none"],
    ["tfontStyle=bold 8pt Tahoma","tfontColor=#3F3D3D,#7E7C7C","tfontDecoration=none,none"],
    ["tfontDecoration=none,none"],
    ["tfontStyle=bold 8pt Tahoma","tfontColor=#444444,#5555FF"],
];
var tXPStyles = [
    ["tXPTitleBackColor=#D9DAE2","tXPTitleBackImg=datat.files/xptitle2_s.gif","tXPExpandBtn=datat.files/xpexpand2_s.gif,datat.files/xpexpand3_s.gif,datat.files/xpcollapse2_s.gif,datat.files/xpcollapse3_s.gif"],
];

var tmenuItems = [

    ["+DELPHOS","", "datat.files/xpicon1_s.gif", "", "", "XP Title Tip", "", "0", "", "", ],
        ["|Home","testlink.htm", "datat.files/icon1_s.gif", "datat.files/icon1_so.gif", "", "Home Page Tip", "", "", "", "", ],
        ["|Familias En Accion","", "datat.files/icon2_s.gif", "datat.files/icon2_so.gif", "", "Product Info Tip", "", "", "", "", ],
            ["||Reuniones","http://localhost:8084/Delphos/FamiliasEnAccion/EncuentrosOReuniones.jsp", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||Features","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||Installation","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||Functions","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||Supported Browsers","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
        ["|Salud","", "datat.files/icon3_s.gif", "datat.files/icon3_so.gif", "", "Samples Tip", "", "", "", "", ],
            ["||Sample 1","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||Sample 2","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||Sample 3","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||Sample 4","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||Sample 5","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||Sample 6","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||More Samples","", "datat.files/icon3_s.gif", "datat.files/icon3_so.gif", "", "", "", "", "", "", ],
                ["|||New Sample 1","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
                ["|||New Sample 2","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
                ["|||New Sample 3","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
                ["|||New Sample 4","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
                ["|||New Sample 5","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
    ["+Samples Gallery","", "", "", "", "XP Title Tip", "", "1", "0", "", ],
        ["|+Samples Block 1","", "datat.files/icon3_s.gif", "datat.files/icon3_so.gif", "", "", "", "", "", "", ],
            ["||New Sample 1","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||New Sample 2","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||New Sample 3","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||New Sample 4","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||New Sample 5","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
        ["|Samples Block 2","", "datat.files/icon3_s.gif", "datat.files/icon3_so.gif", "", "", "", "", "", "", ],
            ["||New Sample 1","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||New Sample 2","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||New Sample 3","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||New Sample 4","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||New Sample 5","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
        ["|Samples Block 3","", "datat.files/icon3_s.gif", "datat.files/icon3_so.gif", "", "", "", "", "", "", ],
            ["||New Sample 1","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||New Sample 2","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||New Sample 3","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||New Sample 4","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
            ["||New Sample 5","testlink.htm", "datat.files/iconarrs.gif", "", "", "", "", "", "", "", ],
];

dtree_init();