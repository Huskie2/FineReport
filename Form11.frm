<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="明细表" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="name"/>
<O>
<![CDATA[江苏省]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[测试库]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT * FROM 销售明细表  WHERE 1=1 ${if(len(name) == 0,"","and 店铺名称 = '" + name + "'")} order by 销售时间]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="区域销售" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[测试库]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT * FROM 区域销售]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="日销表" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[测试库]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT * FROM 日销售]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="月销量前四" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[测试库]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT * FROM 日销售 limit 4]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
</TableDataMap>
<FormMobileAttr>
<FormMobileAttr refresh="false" isUseHTML="false" isMobileOnly="false" isAdaptivePropertyAutoMatch="false" appearRefresh="false" promptWhenLeaveWithoutSubmit="false" allowDoubleClickOrZoom="true"/>
</FormMobileAttr>
<Parameters/>
<Layout class="com.fr.form.ui.container.WBorderLayout">
<WidgetName name="form"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<ShowBookmarks showBookmarks="false"/>
<Center class="com.fr.form.ui.container.WFitLayout">
<Listener event="afterinit">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[// An highlighted block
FR.HtmlLoader.loadingEffect=function(){}  ]]></Content>
</JavaScript>
</Listener>
<Listener event="afterinit">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[// An highlighted block
$("body").prepend('<canvas id="canvas" style="position:absolute;z-index:-2;"></canvas>');
var canvas = document.getElementById('canvas'),
ctx = canvas.getContext('2d'),
w = canvas.width = window.innerWidth,
h = canvas.height = window.innerHeight,
hue = 217,
stars = []A,
count = 0,
maxStars = 1300;                //星星数量,默认1300
var canvas2 = document.createElement('canvas'),
ctx2 = canvas2.getContext('2d');
canvas2.width = 100;
canvas2.height = 100;
var half = canvas2.width / 2,
gradient2 = ctx2.createRadialGradient(half, half, 0, half, half, half);
gradient2.addColorStop(0.025, '#CCC');
gradient2.addColorStop(0.1, 'hsl(' + hue + ', 61%, 33%)');
gradient2.addColorStop(0.25, 'hsl(' + hue + ', 64%, 6%)');
gradient2.addColorStop(1, 'transparent');
ctx2.fillStyle = gradient2;
ctx2.beginPath();
ctx2.arc(half, half, half, 0, Math.PI * 2);
ctx2.fill();
// End cache
function random(min, max) {
    if (arguments.length < 2) {
        max = min;
        min = 0;
    }
    if (min > max) {
        var hold = max;
        max = min;
        min = hold;
    }
    return Math.floor(Math.random() * (max - min + 1)) + min;
}
function maxOrbit(x, y) {
    var max = Math.max(x, y),
    diameter = Math.round(Math.sqrt(max * max + max * max));
    return diameter / 2;
    //星星移动范围，值越大范围越小，
}
var Star = function() {
    this.orbitRadius = random(maxOrbit(w, h));
    this.radius = random(60, this.orbitRadius) / 10;       //星星大小,值越大星星越小,默认8
    
    this.orbitX = w / 2;
    this.orbitY = h / 2;
    this.timePassed = random(0, maxStars);
    this.speed = random(this.orbitRadius) / 100000;        //星星移动速度,值越大越慢,默认5W
    
    this.alpha = random(2, 10) / 10;
    count++;
    stars[count]A = this;
}
Star.prototype.draw = function() {
    var x = Math.sin(this.timePassed) * this.orbitRadius + this.orbitX,
    y = Math.cos(this.timePassed) * this.orbitRadius + this.orbitY,
    twinkle = random(10);
    if (twinkle === 1 && this.alpha > 0) {
        this.alpha -= 0.05;
    } else if (twinkle === 2 && this.alpha < 1) {
        this.alpha += 0.05;
    }
    ctx.globalAlpha = this.alpha;
    ctx.drawImage(canvas2, x - this.radius / 2, y - this.radius / 2, this.radius, this.radius);
    this.timePassed += this.speed;
}
for (var i = 0; i < maxStars; i++) {
    new Star();
}
function animation() {
    ctx.globalCompositeOperation = 'source-over';
    ctx.globalAlpha = 0.5;                                 //尾巴
    ctx.fillStyle = 'hsla(' + hue + ', 64%, 6%, 2)';
    ctx.fillRect(0, 0, w, h)
    ctx.globalCompositeOperation = 'lighter';
    for (var i = 1,
    l = stars.length; i < l; i++) {
        stars[i]A.draw();
    };
    window.requestAnimationFrame(animation);
}
animation(); 
]]></Content>
</JavaScript>
</Listener>
<Listener event="afterinit">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[// An highlighted block
setTimeout(function(){	
        
	//以下修改文本控件、数字控件的属性	
	$(".fr-texteditor").css({"background":"rgba(0,0,0,0)","color":"#c0c0c0"});//设置背景和字体颜色
	$(".fr-texteditor").css("border","none");//去除边框

	//以下修改下拉单选控件，下拉复选控件和日期控件的属性
	$(".fr-trigger-text.fr-border-box").css({"background":"rgba(0,0,0,0)"});//设置控件本身背景
	$(".fr-trigger-text").find("input").css({"background":"rgba(0,0,0,0)","color":"#c0c0c0"});//设置控件输入框背景和字体颜色
	$(".fr-trigger-text").css("border","none");//去除边框
      $(".fr-trigger-btn-up").css({"background":"rgba(0,0,0,0)","border":"none"});//设置控件右侧点击按钮	
},100)	
]]></Content>
</JavaScript>
</Listener>
<WidgetName name="body"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteBodyLayout">
<Listener event="afterinit">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[// An highlighted block
FR.HtmlLoader.loadingEffect=function(){}  ]]></Content>
</JavaScript>
</Listener>
<Listener event="afterinit">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[// An highlighted block
$("body").prepend('<canvas id="canvas" style="position:absolute;z-index:-2;"></canvas>');
var canvas = document.getElementById('canvas'),
ctx = canvas.getContext('2d'),
w = canvas.width = window.innerWidth,
h = canvas.height = window.innerHeight,
hue = 217,
stars = []A,
count = 0,
maxStars = 1300;                //星星数量,默认1300
var canvas2 = document.createElement('canvas'),
ctx2 = canvas2.getContext('2d');
canvas2.width = 100;
canvas2.height = 100;
var half = canvas2.width / 2,
gradient2 = ctx2.createRadialGradient(half, half, 0, half, half, half);
gradient2.addColorStop(0.025, '#CCC');
gradient2.addColorStop(0.1, 'hsl(' + hue + ', 61%, 33%)');
gradient2.addColorStop(0.25, 'hsl(' + hue + ', 64%, 6%)');
gradient2.addColorStop(1, 'transparent');
ctx2.fillStyle = gradient2;
ctx2.beginPath();
ctx2.arc(half, half, half, 0, Math.PI * 2);
ctx2.fill();
// End cache
function random(min, max) {
    if (arguments.length < 2) {
        max = min;
        min = 0;
    }
    if (min > max) {
        var hold = max;
        max = min;
        min = hold;
    }
    return Math.floor(Math.random() * (max - min + 1)) + min;
}
function maxOrbit(x, y) {
    var max = Math.max(x, y),
    diameter = Math.round(Math.sqrt(max * max + max * max));
    return diameter / 2;
    //星星移动范围，值越大范围越小，
}
var Star = function() {
    this.orbitRadius = random(maxOrbit(w, h));
    this.radius = random(60, this.orbitRadius) / 10;       //星星大小,值越大星星越小,默认8
    
    this.orbitX = w / 2;
    this.orbitY = h / 2;
    this.timePassed = random(0, maxStars);
    this.speed = random(this.orbitRadius) / 150000;        //星星移动速度,值越大越慢,默认5W
    
    this.alpha = random(2, 10) / 10;
    count++;
    stars[count]A = this;
}
Star.prototype.draw = function() {
    var x = Math.sin(this.timePassed) * this.orbitRadius + this.orbitX,
    y = Math.cos(this.timePassed) * this.orbitRadius + this.orbitY,
    twinkle = random(10);
    if (twinkle === 1 && this.alpha > 0) {
        this.alpha -= 0.05;
    } else if (twinkle === 2 && this.alpha < 1) {
        this.alpha += 0.05;
    }
    ctx.globalAlpha = this.alpha;
    ctx.drawImage(canvas2, x - this.radius / 2, y - this.radius / 2, this.radius, this.radius);
    this.timePassed += this.speed;
}
for (var i = 0; i < maxStars; i++) {
    new Star();
}
function animation() {
    ctx.globalCompositeOperation = 'source-over';
    ctx.globalAlpha = 0.5;                                 //尾巴
    ctx.fillStyle = 'hsla(' + hue + ', 64%, 6%, 2)';
    ctx.fillRect(0, 0, w, h)
    ctx.globalCompositeOperation = 'lighter';
    for (var i = 1,
    l = stars.length; i < l; i++) {
        stars[i]A.draw();
    };
    window.requestAnimationFrame(animation);
}
animation(); 
]]></Content>
</JavaScript>
</Listener>
<Listener event="afterinit">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[// An highlighted block
setTimeout(function(){	
        
	//以下修改文本控件、数字控件的属性	
	$(".fr-texteditor").css({"background":"rgba(0,0,0,0)","color":"#c0c0c0"});//设置背景和字体颜色
	$(".fr-texteditor").css("border","none");//去除边框

	//以下修改下拉单选控件，下拉复选控件和日期控件的属性
	$(".fr-trigger-text.fr-border-box").css({"background":"rgba(0,0,0,0)"});//设置控件本身背景
	$(".fr-trigger-text").find("input").css({"background":"rgba(0,0,0,0)","color":"#c0c0c0"});//设置控件输入框背景和字体颜色
	$(".fr-trigger-text").css("border","none");//去除边框
      $(".fr-trigger-btn-up").css({"background":"rgba(0,0,0,0)","border":"none"});//设置控件右侧点击按钮	
},100)	
]]></Content>
</JavaScript>
</Listener>
<WidgetName name="body"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report1_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report1" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report1_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=now()]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.SimpleDateFormatThreadSafe">
<![CDATA[yyyy-MM-dd]]></Format>
<FRFont name="微软雅黑" style="1" size="96" foreground="-11337729"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9=p6;eHlD>IUH:elpm0&BW5G'l]AG:fL6iQg>W_`'cO&oX:j7+MF`<LTKo*TS[N8:;G5g?^t
`[`/9R)[(0M\MAppKkjd#m9JIhuo&s,LP6HFLlHuur_mrN#Ar?qN*+h>/X4859&q42SUhp(S
5;TR<n%"9oR+CNpXaXbpF"?\1E#l%+bi,dNu0:)p@"pC$b^:iONGDdr*<*+)rN<^qOQFC_r%
@mH7pl^p$2dVAg.DH1gT!G1GOO:N:9#/:'nc_61*4`KKQq8]Amk1t9g0uDIgn[DMhV"2:^ibS
+E,dt`Zo$fL6$cf+8;WX0lD8Z4T!`g:\*`@a+4et/ffU_5'Ea8r'?IU%TUAT&qQZ&m)i34GZ
Ju<ksfcr8I>dm:Am)_d-&pKmLj?Z!j:M"@KZ,d#u`6,Bf"]AGt0B1:TQFDo9'!Vqam(TM1P?+
((:3)(l<&@mFts6)7qT'fYDAn#&D[SrU"5"M3>=3#Zt"(Zg&;&d[;TZRM_FrQU>E:Y\rgKR=
nHM\[0ikN%"/\>H>H+k<E[u@8_J)0(?/Q"Le5=>/lZs^)")'kK5`95B3%"Ufe[&nZZ/&c,Km
N?GSl&mdu2AaTSEJ]AB[\kNu3<%k(mIYU>&k(o2mRPOc@T8/D[>j8/Mn&/sOZZ\lNEC=C9619
-lJR*Ll_Y.,'g97Z3LtEU3K%H*g*E0T\@kSDd1<:]A`NL1YeXoc)j<Z,Y/E]A*Mg/$KEZKTPKY
^M,$Y7q/q\'8a`K9_Io\Z+"pd4e9J8W`5,6<:*.2q)uk<XKqh$Hb<tFojsU^@Yq*&/E\M'OO
H[;%'+#L$`9&]Aj1aLjCCJ>V&aYhL8ebN)('XA5#3*tS^(SQ<D+(ps9o!Mgi"`t,Nm;Fj-GRT
9&<0]A.rRq8G5abn@K6JQ(:CB4\'q$;lR3OJQOdYO=H*+ZNAOnfjF<iDNhA,FDH2l9L_Lf&ED
G>//f0(PAM#6=,<S1CW<u%IUd;:%i*MFF,kjIh[pU(Ca>AB.pOY#b4Y4k.ga)7`t^@2>M?:_
/9S7/Ss+fgW*3!BW[Ajn%2=M1ua=2'3GR&j86\Wu5VEZ=!IGcklo]Ad6]A`6#UacWCGXh.47KN
BdnXYp>,hi_[(259l)@dit>6-NP!a01,&K-2<o487!1]An42OA*qV"u>QV_:4k4ds0`cMJ.3]A
=(3DkA7T?c../mQ5/6aYV06oNftl("XHE>@!`[_iX,ZMRJJBO81WMZ8YYpc)I9hMu4#cN\`^
f5;]A!r2ACg,FRscJ;3f58/@ea-ll'niVZ0>!0lGTNVr@K6BM*`tn=cuJfY^9DPFY*8ZOd):?
QSDn=4q9$glJfR[8'X.=2o:tBnf@I^-8TqmCH?;37AAOnQ=!ab<h.RHNf.OKNL`$B!-)WcB9
/ien1=NM\8/'jZ#Ydf+V!M21e@5:Z'i!/c(%F@hOHX4>%fg?0NNl&l"7KKqnprX#,raa%TXd
BZ\.hO(m,s(7Fnd8\.DdbFN^g`lX%H0+a:(F/)Pi`G2Eh'AQ5=k7h5#JFF.14O3(%L"/441+
Sg"#632+_g2+PamkN$AVB@LaPl<@;MT.p9.qu>$p@REIXMHYGa-iTUZ,ppo%bC?X?D_860e3
$bX.89SB$h5`d]Au/Vg0onm9qjA.LJ2`H^fb8@K^nL:b=C`3,T&&2XBq?4PdDcM8PthTuf)71
:N1J5")%3G;qE6Do?XdMWgfpRE$X1<m)u;mH=!E`s9TLQBDe6Gu120\,V8M]AAr&c\cC^$T$)
'1L*B38p1id\c=e;r@n:)IEeW[\!YTei9A_a$0N?h#9M\9Ob<1k]A#iHFH2k$/"pbh(^,^/Ko
Z@2tLY`rU5<r1s2-m*8E5:_/0IP2r?q"WX6'o#Pd[^d<t#BtTg280RWNICY&'5JD(l)O6J\&
Uep;'m$=APj^(.hf.5kkk7&0.YI_;TE;*rqX.R11BkuIhMT;h&Gc]Af.)4$l4qpGa'4#EQNep
lA,XT0O2_jM]AhiF*hagN2NYp)mO7HM3iW?ok,^o+uT\1ag']A@uu&c8N=]A^W%!mh'fG2X584"
G/YE7]AAcZ?"Ypoal)C4kBn\JhFddqMcYF#6AFkQe]AnAd28+)@?L;b89LC1XoHKD'j9%>P5Nk
onL=*^+-\1Y3P8^:#k.rZ?C<m8(m\?GLYs9.o*qFE4Ra+jm12l1_J-dE>Wl\J)NMV\O::Fag
l/Fq,FpVR@_F9g=6u5?V!G$*n=`75]AJ\ft!0E>LA<;,O)N#&I,qt@/V::-AnV@@Lmn>Hf>I8
c7jipd+rSOQQPE(<eM*md6_fX0r61O4##WmBYeFcCR\r/ML,F<]AR/e*q,G0eaUq=B8F1NJ%u
[;jnhaccH/H+U\@h.'/B#k5gKec8673Z/E5VDt.;Qb(R^WS)ZVUNA/!ui">#:ooQsBo6(]AU0
\g>>7l6UfZ-HDHfN:g(8dD[N1(p7dYgmmk3sSmN^hmI#!nWAf'H:i(oGbX'oX,7cPCcZ54n=
;$pBSS$:FKREm27RE+<Amn-PMF8,DYg\hYX';96qTSK_beT;-8*-P:JFS)CrDiC]Aa#Qn"mIL
,Z5;V&=C)^E%@,q5WT#*\I]AI*4^.dRLW!6_C6P)l?j!a&`GDF7;Z)[=pY/3LTI'HVUc]AnG%F
g-fXr:u1W*PAMe:jGD!7,puOR4=Z7JN@-_+\p1P\)#?1$1fW8;RF(UHE!D0XWhUia<G"J$]A1
o'n[*Ob8j_7-Q:hDF6KI.`S![CG"XPX-5\hK7V$*pAYbqL<(iOZE:$l2SdD&Ok$$%ZJ'['%W
%/]AZ#Y:E04tTm^#o@9\MeKq_1/ug7B%r!Ga_YrE,cWT#.ap24U#D7JBhDPH0DjF01OT&]A<eT
asR\VZFPH2-DWO70UIN#d`7a)*eAND8W/"`"9*]AGD!9H5<KH7B#NFd#@m>,U\;<!NjF.=q+7
?DO6NAlGSW=h>NfDn!(#n;4NiPDf3smr%V1LX19s'n`7Uplh+&+X0g?\80Sk=V9ropBCnGXO
DuD((Vl<m%UW)U>Tit&2!MAS4N]AGD'J)K\;8HBM*Sp\rLg/%5E1Qn0;(2genJ_<o"tM3M]AJt
-!EaYXTZAaYbnXDWTeHttU6I-d]A)`M^kTsXnT0iUKI$8<S.?jBr&>Xosg3)>]Ajc)a&%#9D/`
jHDrX=P(4D)eP!n:'?=\+a>\Fh*MU--Z2DZSganige>K0bF0t7`#:$Q;,h1#ME8o+H_t'EQ0
%B3tUesi2[XpP71/E8iMj_0hstZ[F+^e;O@4,!CFiR#Zai6UG-;qkbIjKc$!h(Ci[KU&-dGa
KKuoK2A%i7b/-GEM)q;D"=dt$JM@uI+:(&4%#mm5fg.<=R'(;Qq_a@'or$LWi81Ybc\Se_S'
P4?DE!N_CZL>.LC"*@1$Da$jN7gR1#[S258-@cm,jG0OE1#Ik,U9>AXsQMRebK^Yqrgbs7D)
\]AJ;pY_j-P)@s;!A5]AL7$EMpo6BS+G:GG<&JH7OgDD;[QOE]A2ZD#NKNC6o=uW[teg#]ARj-4^
SikA;+&A%8UlWL#T3]AQXec1/lT"5Pn5hq:a!(?<peh9ZFuCDsVVka\oX-f!*^lkV<KN&*a;&
5:.n$/E2la5>T@6k-FPaT_I`2E99&//N&^'VTXl0E&*NrGcCF6?tKr/?iA8tJN=?RI^`cQZ*
n.BJ7kloG'['d;F?D=C/!!o_X>-&-lTu_Zn+?kq@)9'<!`DC9:<8kk&"<Ru]A!OC7[:8"lVSB
es@7*?L)QF)oQZWh0QRr[DU7oTbeVl[(/=AtY<1,C(5M8hQe+e"bpJ:^I86[HpmI%a`fK1UP
nK$*e@IojUe;0PObmFDCMKSh^cmh:)ZKts[Z8DuJZ%k)JD[:(j!89pl3ja73c^IPKG`%h+^o
!e^WPZYpJ0_H($^i0eE&uR2caHd/!.8K;uH!8WAQ$E-9^[kiK^4)pP^lr19YYjM+TC"0tqZN
!'Ff[1?hK?5%$2M_(Onl$N0LR$tj;^*/mU1DD'%#q0(Z\@b7DWK^Xh"%&c=nR3]AYEqu]Au&5I
c\FG+XA<O'>,pC6OhQL2qe`PsK*T?8?r3<54:'Y.<pOjb9ULk'V%WJM*QB?h#\R7?l)j,7K5
hMa,MQ!>&0fMo1@`d9om5G1NU<0UbYgTVd5-nQ.pR1a@5C12C96LCQl"#<2<Z2seS284SKlG
T$@k!((8ZbI#NR'[)/9bR"nLHQ?Sm*dPN4la8N:T\/XHq2?4ml!`o8"N3qSaF1ra-pXEs3E-
?DbD^^,6mpb#Z"ql09m:hAZ.2g=tH#Gt!MYrp,l_b@h6#4Pr*fBD-a!lo]Ar,*gQb;ea'<XfN
SbZU$K<K]AMge<(MEsl)bK^@6[,rMNDX'oGUhu681^7&\V2cg]AuSn,\O_Mn4DOnjHi[AcghD%
H/AM_V,RENRT^b_rOr0]APSGS'qV\^[!W~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="250" height="150"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report1"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=now()]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style imageLayout="1">
<FRFont name="SimSun" style="1" size="104" foreground="-11337729"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G'=;eMQ60hAZ$m-&OSeg,Lk@llK;JMTs$&BI@S]A?Tu@17"Il/J.:$@r)kk",)%l]A/*4&.I
#Ei6]AmG!=cUoZ-*bHVq$\<7UUB.e&L(S=")%ae":T8@S\7=*h9KtHjogF,=n7@2E:99ChtMD
FcguLThttE;J$PESiJFJ(J08OCb<LIG'aT\Y6dVi?Xbk!!XEjNX"pk(Y`KsqZiBN4B`s,kkg
&BQ@&+*"S33F`)9<nJfChOT-T6VmYWLpi0qE)il^L-Q[/)ApFlb!nYC\I`'`sAr$HU$VE?:I
12V6gAR8FS3[iFI`$PqT!h.'S-HaUB#=T-ZMrSWb:>(Q247eR`nuAmg8;&bO8@b)#L"%7tWM
.j"`NdF]AUU(s3qk]A;-fZ-Whl?]A0FfU#L.m]A6aVHU9,;@=eDA76:QCt>-:!Da`M6'gCq/u&a6
pS14!eDt=haXXV*o-EbGN>JM]A5/';620HoqP0RiMLh6^/&5IjMPOSV(@GFK'I?*d2.JRI<G:
k^Po)5@q1r)oD6)3O\]A<C:*eDtT8WH.htU2$s#e\j$?p36)c)TsZs<PD4[0QSi<K2`^XRV?L
+Qlb*g[Dfcd85O/dC%PfDkcT?HYf?=4)K#.GiVAK[W:E$?f.e:,#SU'+HaASZ"N(9f:f)$0.
a>7[E),*d%]AWoRjf=h6H+")jX\k^X3Q%U&4X]AT7JLF><^G?$%6_/2>V_2[B@L/GK*?q]A\m1T
?ObH)nelm%*&#CKr_7*l28[2[f%lN7qI:)=o<OBaD>;+\H2!^\@d(pI9mT;q1^pA?e)/k'-H
iB%%;(j@G^4']A1Q#3$r-":5U4&CJHEBkI+I*[\B3pe7R0O&q[q)o;7_[1sd18GY-l'd'Zs1;
ki-H]AufH9rOZ]ADCWq+QrL-Wp6hd?*dVR6Zt]AkR'XPnl@+IaZe#hm&V%ZVOU?Gra;M8&8I^ne
g-eUcG__uq+kLTNMi=:8qUTm^N"O:qg+"ESA`*3HO&4i]A')kAkk:X?Od26R1P<pOXHCo*=C1
>pBsK2p)dm7fPjXiDX%qq)=M&]AQXFRLPZP6X-)<@<"9>so%6Z(`Z2"T\;a`=usRef.)%f+Gd
KRCP>L4:e!S+^kf'S(ku%Lc7A`r@9J0:Bt84<gb`DZ>H4\q@sjOYPKTh>RJX-=CQs_'4aO?-
G-gPT'*!rPXHgDD_%Xct0K<iiR*e8NbJL,M%(R(<&&$K&\:8rGebj?qTcR0d"?FS_Pda`<L.
gbu#60M6:O$*7a=\ok):h)9f\3/k/Em5<oT"+hu=8hi%Sg;AM#V702!T8`S&a;@'C/Ya5fAL
6*'jGgF@@aqO;t'LTJafH_M@cepEn-jC&%g@=*39^n$/F.[UJ'`\#mS(d2P:M&C(1-Mte;Es
r+Zd*'CMHRD41I`?$^NNF:Prb?.]Al+C+4Las+ZlDJSaX7.*)=2-g3ooW!&1u*Jc@]AfVci5]A8
.!-oM:HM7SG$)tFX7i3C[.st$8>&GX/C5-N&h0!<=LtR)^H6+`#ueC^L&RY9N)jF'3niUnIq
F8Z;<,IHSm@)25Apc6SC<:Q7'k7k6O8m2==A4g4Hg*IXaGjU[o3d]A,SrM%j@EI4G=AcQ6h=I
u:1Fj;[VIpg._B=<bO>H3cYt8%?P9GGk@I$gcMNh(Bl0.-<A!'e(YB(l[m4IrZ[-$B(M[8oV
tNOK4PpP*WDXRIGW&h-IB5k1M2'gH'IsFXNP,ClfA"tpV[)RPeo().Xe(##YTa%mg@-9bSVd
Q+mcd6k%FaO.Ilc7mBt6*dX/s1E&65mJ;g\"W/eET;P@:!'P3)^+cb5,&)';0r`rBe*9'8B$
NS3["%qC7ldMNY;A$HTV3ZkG\;g/]A7#`&#ipuq.J)ctKMoB/'\/3m3*o[=hHdd77S5V2dB]A'
qg=-%Z88ml7K/frA5@LeqZfHUtMhV`p$Xl),!Uk9s@]AmL*ri+Rnsg7)SZ@o:SU!dR8e^5ss"
q"M@;R5X1Xfh%/Q8F?&st^&D]A(N1hik?[_mr\PIErr6dn?'KCe$o"&Z+&Hq/cNU88m1*sHF#
41lE2R6R+LC9XSkeY7HAd+bR.LG'ZdM*kC29b-t]A:3e=7L<_XbjJ5r'_thG9:0ZeAgT*)g\"
89,Iea781'(HQS:4iAV=`qUSILo6-5sr]An%`PE3q,8o/*E[c)7cpRGYn&V+P8J0N2_q!Wkej
?U)D:j"?t7qC&Ll"XAAYFJ9Kj`:I.[!X\0XDd)/5&>l)1?C0,H0HA8^<1DJ#KH&9HL76*t.Q
bmt+;_ls,j#$2W;5bLKijB\>^Ih>7%he'laJk[;^1"A3G0m:K_uhF9XZ##$Zq/!"Aq)9:,k5
T8IB[ljQ35D3X$2B@bXttq$;&Mqcf@F4f;1EjLTm<c@/0B>X@B&8e<s<9?Og7Zr7&F<uo8sk
f\kp$c;S$[c2N$((f(1JTW9Kfa:i%hG,@VW@Vo1$N0nWn8!nnp!rm(a0TLOGJ=ZP$l8sk)1`
$]AqJt#)/)1?ip.e9,&9;ZVfo>%fi<6CG?0NZ$]A9`McTP3^5!87_0mO[MT!;u.\g;:1c#_3%'
PK,ZlR`+b4Cd=t/G(68qh><6IPhIn\o&>.X!G2#M(b=JF(m\smC%5;r?[aM1%tmj=fZgkr3"
"KCdO'rS3jbbJ&EfrF=+e!t8Vn[Jc@`WU6&dA6jC>$ZW@p&[roG>q+EDc)lRQ'rlh@<q.O:%
&+:e`12\ZZ.VBu[9"&kW+lNAa<Dcp.<_5do[efe='E%c+ILbB,m.uioTk!eG9f#ZEXLJ:-*:
kq(/UuhAj6\2WGFk)(QJ!l!6+TG-5[Aaj^PcF*P-.^Z4al\U;ldTLKrA5.ZgIF?>H!C4%-[c
f:]A_3-U6+qDEfo:?N3p<5_lC#/8qVl#hUGW;+G`9j)*]Aa"Qfo?.Y#!)bTqG!-9Y(KZ'4K)OI
AHKi&$);Gt.(I8Zh`\bS0UOSCcDnM,TV=\>6e6g[\BGBckk0?b(f>57'E3+aPF;R9qW0:7:6
Cdo?>iC>eSD/dq=MKpT'a,<3b/=%j9Qt>nLt@_,6VmtGfKjPVPQtcPmg3faU/T_V,,mGX\tg
RVZN2A>UQ(t<]A2`LGr+KAKYr4]Afuk"T'<"B=^7,_"N#!d:2o%[]AfXH;K8SQ2rjXB]AN(`jr5i
pNL2+HQCuU;;bkr=BFe+,@J1&RoC"9D&*dW!-8cUG@=-Bj^*kQCnW-Q?cb&:hc0:aj$Ln;(5
rh88As!Cgd?e*9U!f)g*NI:qXH/A.X<8"Z=)[$f'o!V@mW?K(([s<8]AKLfm^2X_BhJ+5i@9a
6RW&eJFd3!dK?+dX95EDKPJGF5rXAqH(-O8[,hh.;T\:6#X0$E9B:q+bN<c6PK@&mB"HZM_&
bi82T1PJs(I+OQ[k>'JK6$tWTl#WV;/;_<t[4qMEoo@j6hAFR#Y?`LD';EGI;h6]A5L"=>'ge
[Wh=)qS65o57Mbp[k!??;2NWoZj\Q(ZM&=n"Fs>:Qa>8>cjuX%QdHC$#PA#$UdI=Spr855Mc
AllUVNPmcC3&u>*V^/?7O./"Ar@l8CJ#OODO1L95`(4>YB9Y,1!pe-!(PU.SU/O,Mi.hq,r.
]A!H#EkKMi5YUlKj80BE=jp^cHm\<@V:S%[3$b7M4]AWIZOP-'oO2Cr^7eQ`':.LhIL1J5h089
Q=O[V;<4V'\,cglRVEG-G02\.Z*^&PlLj.+erA>mH+_le"6sTGkc]A8p]A5I@R99fOfB>U?."!
/6`PgGju$(P"L)>JHhg;(2[JQ0:=4j#="5ENiOLt'4+OSo)O1s=N.h#LKe78G(2=2aDncIU+
D`tr?NV)=oX\S6,13ZAk238o$'.MQXY%o7)UJE#/mlh!aVBN1_N&Y;m+/k>ujGj05u33cuea
Ac*G7\G!iC(^A]AV/9AjkW2(/B(lIT/&C*'TdP+DCRW+f"K:&d%9;\j*$F-qTE3c!,*6hdC3)
D)9gog_fVa<48Qh+$XN$:>!W"gLm9agU'Q15Ic`WdD?/0fZR/LUOJCb%]AfX#XZW>%qsN'b='
#k54&M.edF&F4K:p_8*2%>d%Sg3USSR'+M0"#Uo[Q)0eTK7j<+I'f,8$0\?i.`\Be*"NtH-?
'W.CS-'niZ2Kl?sB#3,b/R"(TtFR6pHrXbYI&+2<fXHJJL7)U*bXj"?JAWB+%oP/!+!K8=D*
ZKoi^<5Ldnj>Ck`",Uqu6a5+(Ph]AgZmI1%4bF<i(&1XFOC,-p6:'[(J2pGZ4b6G=\*Ur5DJM
kru[ho8TFP4#WN18o(^qH8"(c2[Uba2-]A!L^-0>DZ<6,oUG#Y[q`+ZETP(G9%>H:f+-uV=nW
C74FCW,`J%d+!`;&Y>P,<Ke1)SqpI)=bGlYA/!LZ<Ak8P@_43a%%;3u5X<X'pQ?d.F5AB5h?
lhC^nBM]A'gOF.i5^j]A(D;VUJ\*i9fEECp/G8Z.$cdZLa"_C]AcrQ*>l7Ej_Q_oEV+T1;>aR)E
1@b8894h=LGYO5>Y?HmW4W1"j?,JIoKD4SXT/g>$Ns7fj(\Z8u6=\#!`I;%uC97DMo[6isL\
ac7s`eZ5+2eXY'<e9i5NMH%=a"KYeW8.+9M1FN7Ld)B;<f6VYlQJ0^?g@-040$GIUBM*\>sk
q#<r$i8I:fB-[3GY\`h6!+pePTVQb\6nPanLAErG]ATFiVk^gYCM0#[+@eaR34:'W?m,M4c,i
ccV+;LL,m.]AG3,O?3SudoZXi2kc]ALd-lV>!Q/+UTId9%6q7"Np`;bWOA50]AR/@YtC%-Zcpai
cr]Ae6`#6+mkQ`XEZ[MA*X/EhO"^+&J/qM3#L!hRb>L'J-aRX6Ho/S(m73P?Xr:RSlZSbEhUa
UHGT2%/P[^`2#M[B"W<ZE_d/hp!H1)S`rrH?%ZU6#'JL8F![^k+92U$*g\)XY=EJ8"'OXpQ!
Z^&Zlpchb`hWs6%A)-=nk?MFdo<mAmAXu1ELEH)YhH/+r:/D0Fi(bjoJ:7b&rfd`g&)A]AP6s
(?jJ9220iAk&@o/=!12M-p4?H)?#Uo%!sGLfQXVj]AB;AG&:p,>>C<>\pk']Alb42;%sf8r5N&
3W8#nV.<ARNX"Bfoi<<3C[eY\Lo9feXNRTDXAf"fBdh_4`uHQ?A*oEctFDou'AID9"&j50kY
RqP_,J9)/:,ZTfNHeT&6pY[+9%^SuOD7&<sB'N[M8>u`9iVmb$cp%L0XXA;4Uh-d\IH21U#l
D:4msAD@rTM&=rri~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="960" y="20" width="166" height="46"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report5_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report5" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report5_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1463040,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[LOGO]]></O>
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="112" foreground="-16711681"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9=p>;cgEb0i%3=1=Ne9$3P93X*u(,9j;"'_2u$+Xb04f1KHdI\$UdV&ZS,aaAZ_TluY(1HS
qAb8D4P`k>R0P@YRAcqG=,('!W`H+Ai\GQiI^.iK3ds_7%X5S$TYlhKB%lj7A=Qp=X6K]Amjh
"hcagYc0%!dM3nr6#65=?p=WG!!&.=Y^l85u./9!/EI/o1GWoX)Wi(;O<7]A[35!O@oT^k;OQ
@53mf)F[`Q;sgnrT9BuN0_d<N@!oa<?thqV`_0^Ub2-LH+ptsDY\EQ9'\.]AeG\0n<ds7jSnf
1.an5AQH63n!SC`63\Q&;E2\gVU&5aL>6nccnFdVY'\QZA\X`)Vm499qK4BO#fnG]Am%V'9Q1
o>mf$C]A"G:rq*[,^0s"Z1f0F9q7c'`YCHEqrkMh]A_(+\ge%=aqGaUs<:QCadX)f&(p0`]ACL&
!*@^B?:'m+2,T+^Wk`2EAEU?oU<"s6[c&m_=j"]AB[$RWZ*lg[]A>drC3-RTh,.F6mcm"8V1DR
Q49%^BpjEjUhpKf25<Ya=8$tt?W![Z/NhaZBDlbqu4d9Gn%IBlA,!X[D&m1Co;4HnDEJ'u'q
aN-?h4:k)/lZ11r`]Aj24_KNoZe'QsS_bYQZuFT#MbWBu>t=OVR+;[eAmDl=aJ;l?k$O,uO,b
`_Ik=+<juR-4QE,/mm7HY7:M9^&:ELANQ:QS-[2$1lmVq9m)pMd#m\jS_e&FW&cc)gOc<^CJ
2*.J%BmodqZ8%2AV;$$+qqoaR1T\bZjf4(kBtL^bT!$BqOPe"84&&T#51MkEdAa0(pfNkBIl
,N8=QgRL['U2o30"h^nr!`J3(4ps]A=+>P^5s.=>i*unH)2/@a$,YZ[8-dWhWf/7OQn<U(cYY
%<JA"-?cOLRVp',<Lr&XJ<OW&bg_Dr'Xj4$U.S5V_qAYf4gBa"on^Rgl,Tkc1`PEeYGWN8Xl
<?jPUU]Al=78!t#NWudqXfN]A!%Ls\05Xs8[UUm)A<t+nEFcI:Q7Z?)M)U5LY0tanKM7Ine(-`
-r`gnF:=!d,eHA*D;is8#!R6Tmppprb$D)O.f/]AfI+pk7K]AqgY7bY$A+hZ:j#n0.4bTDC+":
o5I-1DrZT@NqkpmE1cl$"/p?8;.,1qkUPU2<Zo6Y0_W</(#q>VkO2V#RVm!Y2*mTBEf(d`IU
b#*`sLo$QU2nrG9BILqQRsmAV[X0HsZnCBlK9TY7iI;]AKhorNuWS0a=;9!:Z7He,TAgQoq=7
7&+*&ON/h1S3o#S+_+tbIZc$d%N4rL:c74$mH09iC2glbrN-T$GET![D90Qaof]A2*!?>ESLZ
5_rb15OZJ@Bt`PHbm;QC'U3j.q`48Pl+dXO/.7dPY4KW.8'CT7jXq5!.2>abn8TbQu<@tr8M
Qp;'r<WEQd<h2u@1-*X]AX^_p([L]ALQX=\rg\IjO6L$!R4a%.quK('")Ag(Rl^F.atle`[Qi3
6^$gjWCL!(e;?^(+*=CkN\gYTP&4`<K&aYP5V_O2gn$%LLjsCKp;MAE7kV^j@K^iCcPlW`Ng
5Q66l,%CXRM5@klAhkjT"r[()FVXjbn?X2Q%@5Gh[UuCY>%0@E0]A.;+u7t/<-DH/X-Oqbejr
W[NG5REs$n9m5G^Ims0;10-HFI^-1-jKs+50<!E&cJmiTh1=>rMa2.1elKu*C!AEQDTK_LLM
e@3&J]APT.db^T[i9l%upK%e4[+'?YCNOj,MOe"u]A$b@`OhENnW(dE/:A,tDCtVef,<<&^XI^
OQY`_n2%QCr,EHkcggj_X7]ARa7\V1+&s2\BXtOUSO40uf,ZWB."X02c6?'\!JRcZRH)^k<+&
AfcD/*$DHT?a9&i/Z'[q&_^hdH'7h=kXk_H>$^MlT^D8<fcDDcW%G,0jbXI#DD>C`Rd<2QSa
<]A7G`i.VfWP""61m5H8,>$70F83i&kpIS<nLoD;oWNG'1Da5:^HJniVT<jn:8=38$-6(#nQk
>\EW`H49<rb.d2O,IlEO'EQ#$9TX3+L*%LEXk_t`4l<Ejnlh#da=1GR'X[la?ekol>38k(LZ
*r]A_5`N*4U6UJ/%puYP;^b]AG2;o%eGJDk)=Wsd:G7o`hKIL,PL(MAJ%+?35l#iL(FYTWCKmV
Rr<>3j<FTV_5&"HV$-.J*H_2XG:<5Tt(-'jte`R#3Zg+X1f"MWf0%H_,2BV^XL(5'Xs3julu
j'FfURT1.@Fo@^EEUt-`M289]Aaq"u[ac0[J4YuX'm0ouo(fs?V+-K8c=bP/d><(Td.:lA52o
)n11mM1DP3a&2qjjguWH$Sb24.$g?p5l^"bpUYedHU*R1pscRDKEQ>W,W$8F.Wj<#3N)?A&j
R,b+Wl3A<Td?>Q&H;MVMr9eHA/<[2Q"6UF6`?u2H/DA]AtNXVqFC/A@B<rgIhG%<Y]AX"_ii:(
EWOUa!u0o"7"O@Th?b!An>NRd20%&r&^#4#K!Yj[O!r>9p)j%l8+45(HG#?pKj#2m8XuKYJa
'WM!!)c=NEDG,shmY!_'-MWiuok.4@et2d\qXrHMdU'+NE:_BO]A:&RVllfZ73KgoYUB%.W55
Y^aLcTH]Ad1+D\MMnFndf@)pAfXY?%heuVohK!VM($$%cH[o*=7%9ss(p18:kZ)C2/c2uM/0T
tp0.(3Q%6#8V0j[Ue#BuJ$Qn(%uu_Nka]ANr_US@$PuMk8Ph]A^.AC:HH/YK,XUIC70]AN2cRp#
nVh-*KeHh`H+pN%aF;kXtN,mG^55*'t's`J9QgB&Xrm88EF[(<o*\Jd>J0!qLa:nuqR<9=h"
'Bj*<$;fLOZENAhm-Kr)(4lk0=uB>3W,)C'5!K_R=3"EoU<R7Rm_(GnX$s93>5]A5!2^SjPFI
^k9pDQ-*=n)@ANnm*3AS,?CW<+an9A7BMMGQ`Jb`UD;k,?K.i_CK0#;hL6E)T':lsS!eeEH<
5/m<0rIL/OSi'63-OF5/-f_R:iqkBUF2\+]AMS@NLL:"ohJR/T#+4D1CLhnjHj^-Y$T'tQ3b#
_N0'L1b)Tp*CVQa*IAnml1P%6.Q5)EQG/17/@QD4G&/:&[$i^V?8H)<T?apXm1dc0;$Y(dYT
C1_!'O4;DMV\J&i^h/gO)X+"I9Tl1:_AKDGhE2jIZW(:]A_FLbX053L-aa"!`bi.W6rQ%or'g
R8.q1f[407'^gd@*OtN$EN)0-lFE7om,CTW$%s]AW<n3;OLQ-*9+A8Xk^9Y76C)(kmP2lXZ(]A
>R,T4Lsai?76#fU$bZ=I9+[$?#ke<8CYH\f1%&jF^>H>eG*l]Aq=C`88af9WCg+(I]AfRcObF(
p1rZG'<\lAPE^ERUpuIC3X+cp(f$]A1AoC#>[\3!t#.3MD)-t=X^qdi]A!"@8#0YA?f7$:7m4'
JYR#K[NCTqDD.Q>f/"=a(YQ7t#-21_d)lV%Vfn1<2r/Qpg&Mqn!9bH)G"_emM#,eAQX5E\F0
c(hnbOiV2mCr-F167kW?S_+3R;?jGaA@\s\eNV3+?-(4Punj\TbbQ\SP\]AcrnH(':[)$V^+p
:(@P@Ro7!'O6&'EA^spi>7kR'Vn'*NOU/G8t]A7Gob-.0mYsV+)e\ltM5qG/na(I=Y!:=W!/_
X=='M.4_b=ZOCQS@`<CK[WB;U7mLj>YBMr4Jh=iSg(TW(mV2'!'38V).ik&@h.+Ei,rnTuJ[
M\PbE>]A^9]A>II>b%+A!crSqu7A\*aSOX`sENKajjG-N&d5eTChM[?e]A@*p5]A8egpP`3I3GHW
%V$qX3u$8MYP,l_Z/N0&Pb`E;D*IIa$\mPOC2@`oA/E!;F+D<Zn:g"kf-hYd?45-32a3NtH\
8%]A:_[/h#Crak8I>i$K=`enq`#NT8f%Z"gk_qkgPu:BeD[n,-4Z'-3<)M25pBPI(E@"X7mEK
Wc^/blY\Ro#"Vs[p^"C/U__l<(A)i4D_^Zl@H6XUqo[3WFaK(Bt0gB.i1;*a^nMh$t%dH0pr
ZmjC^G,BiSPXNm:n.A)D^3/uGQki)W'\>64su#t69Zqqd$Re-DJlRWL!?<8\17L[B((HBbpA
1Jl5Wgr/,"X@!u,>U'P?ZN0GG:ai"4/;!,Hk'[DYT!=[mD)1DBY;[f<)kDWD$2=,>/-fnaC.
n;a*-MXnS;-@dF5q3I]Ak=<9-M5/,Y7h^aBkB^oRedbldum:f>_&9]Aj\,NnF]A37JXo,r=Q!c7
7T\r+cZDFl`UtJWC`gM7:]A1]Ag4A_?9M,B-.=$Ma8,@P%()+IZ"uOK]AkRhao_oQ,Ej"Gq9CG_
Vht]AcG!U63A]AL0S-i!7d]Aq[UT\1A.2BLp:h1dcb07bN`U=G3)QKl7a'PQ)PlSV?*dR,:L*Ki
`nB=]AU)\F5./50#,K#E&%6\CS3NMVD,8KOE4%qB,VOr*87Y_$O<n$4N[!Ni88U9hq;j%A,+/
:7reNh^3:/0a`5J21"URTsXYhkH-n6q/3+gpVs656QlL?lu:0qiS+;*(]AA?#+F2cecJ"S>(V
IHO)Thha$M"K`N=oqbH0FPiZI1,b47g'F5-*Ghkt:%SC/iVVot8u`OJR\]AHM8c\Vfs2hQP[k
!4.\V\9.RFtR=5l[7.<JH:FDSggeW>,BNGcUn_]A@n<a4cQ]A:*\p3!j+M*6n$%Cg'AHStoF69
*X%f^/R0E0#S0BQA'8$Z\0Ol!):+,4@"[h1&0\1]A7ZX3HOrahj#fi9k^U#J4ZZf8)H,(Sge7
<"6k=tce^[MYJ4&s;_S*i1)KKuq"+/BEIV=l.@ERa#6)7]A.1IK!djY_rI\U_ruGr=u92\Kk^
dY:N::nBg2F;Eg7eipEK<V=g$qu.N~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="250" height="150"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report5"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1463040,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[LOGO]]></O>
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="112" foreground="-16711681"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9=p>;cgEb0i%3=1=Ne9$3P93X*u(,9j;"'_2u$+Xb04f1KHdI\$UdV&ZS,aaAZ_TluY(1HS
qAb8D4P`k>R0P@YRAcqG=,('!W`H+Ai\GQiI^.iK3ds_7%X5S$TYlhKB%lj7A=Qp=X6K]Amjh
"hcagYc0%!dM3nr6#65=?p=WG!!&.=Y^l85u./9!/EI/o1GWoX)Wi(;O<7]A[35!O@oT^k;OQ
@53mf)F[`Q;sgnrT9BuN0_d<N@!oa<?thqV`_0^Ub2-LH+ptsDY\EQ9'\.]AeG\0n<ds7jSnf
1.an5AQH63n!SC`63\Q&;E2\gVU&5aL>6nccnFdVY'\QZA\X`)Vm499qK4BO#fnG]Am%V'9Q1
o>mf$C]A"G:rq*[,^0s"Z1f0F9q7c'`YCHEqrkMh]A_(+\ge%=aqGaUs<:QCadX)f&(p0`]ACL&
!*@^B?:'m+2,T+^Wk`2EAEU?oU<"s6[c&m_=j"]AB[$RWZ*lg[]A>drC3-RTh,.F6mcm"8V1DR
Q49%^BpjEjUhpKf25<Ya=8$tt?W![Z/NhaZBDlbqu4d9Gn%IBlA,!X[D&m1Co;4HnDEJ'u'q
aN-?h4:k)/lZ11r`]Aj24_KNoZe'QsS_bYQZuFT#MbWBu>t=OVR+;[eAmDl=aJ;l?k$O,uO,b
`_Ik=+<juR-4QE,/mm7HY7:M9^&:ELANQ:QS-[2$1lmVq9m)pMd#m\jS_e&FW&cc)gOc<^CJ
2*.J%BmodqZ8%2AV;$$+qqoaR1T\bZjf4(kBtL^bT!$BqOPe"84&&T#51MkEdAa0(pfNkBIl
,N8=QgRL['U2o30"h^nr!`J3(4ps]A=+>P^5s.=>i*unH)2/@a$,YZ[8-dWhWf/7OQn<U(cYY
%<JA"-?cOLRVp',<Lr&XJ<OW&bg_Dr'Xj4$U.S5V_qAYf4gBa"on^Rgl,Tkc1`PEeYGWN8Xl
<?jPUU]Al=78!t#NWudqXfN]A!%Ls\05Xs8[UUm)A<t+nEFcI:Q7Z?)M)U5LY0tanKM7Ine(-`
-r`gnF:=!d,eHA*D;is8#!R6Tmppprb$D)O.f/]AfI+pk7K]AqgY7bY$A+hZ:j#n0.4bTDC+":
o5I-1DrZT@NqkpmE1cl$"/p?8;.,1qkUPU2<Zo6Y0_W</(#q>VkO2V#RVm!Y2*mTBEf(d`IU
b#*`sLo$QU2nrG9BILqQRsmAV[X0HsZnCBlK9TY7iI;]AKhorNuWS0a=;9!:Z7He,TAgQoq=7
7&+*&ON/h1S3o#S+_+tbIZc$d%N4rL:c74$mH09iC2glbrN-T$GET![D90Qaof]A2*!?>ESLZ
5_rb15OZJ@Bt`PHbm;QC'U3j.q`48Pl+dXO/.7dPY4KW.8'CT7jXq5!.2>abn8TbQu<@tr8M
Qp;'r<WEQd<h2u@1-*X]AX^_p([L]ALQX=\rg\IjO6L$!R4a%.quK('")Ag(Rl^F.atle`[Qi3
6^$gjWCL!(e;?^(+*=CkN\gYTP&4`<K&aYP5V_O2gn$%LLjsCKp;MAE7kV^j@K^iCcPlW`Ng
5Q66l,%CXRM5@klAhkjT"r[()FVXjbn?X2Q%@5Gh[UuCY>%0@E0]A.;+u7t/<-DH/X-Oqbejr
W[NG5REs$n9m5G^Ims0;10-HFI^-1-jKs+50<!E&cJmiTh1=>rMa2.1elKu*C!AEQDTK_LLM
e@3&J]APT.db^T[i9l%upK%e4[+'?YCNOj,MOe"u]A$b@`OhENnW(dE/:A,tDCtVef,<<&^XI^
OQY`_n2%QCr,EHkcggj_X7]ARa7\V1+&s2\BXtOUSO40uf,ZWB."X02c6?'\!JRcZRH)^k<+&
AfcD/*$DHT?a9&i/Z'[q&_^hdH'7h=kXk_H>$^MlT^D8<fcDDcW%G,0jbXI#DD>C`Rd<2QSa
<]A7G`i.VfWP""61m5H8,>$70F83i&kpIS<nLoD;oWNG'1Da5:^HJniVT<jn:8=38$-6(#nQk
>\EW`H49<rb.d2O,IlEO'EQ#$9TX3+L*%LEXk_t`4l<Ejnlh#da=1GR'X[la?ekol>38k(LZ
*r]A_5`N*4U6UJ/%puYP;^b]AG2;o%eGJDk)=Wsd:G7o`hKIL,PL(MAJ%+?35l#iL(FYTWCKmV
Rr<>3j<FTV_5&"HV$-.J*H_2XG:<5Tt(-'jte`R#3Zg+X1f"MWf0%H_,2BV^XL(5'Xs3julu
j'FfURT1.@Fo@^EEUt-`M289]Aaq"u[ac0[J4YuX'm0ouo(fs?V+-K8c=bP/d><(Td.:lA52o
)n11mM1DP3a&2qjjguWH$Sb24.$g?p5l^"bpUYedHU*R1pscRDKEQ>W,W$8F.Wj<#3N)?A&j
R,b+Wl3A<Td?>Q&H;MVMr9eHA/<[2Q"6UF6`?u2H/DA]AtNXVqFC/A@B<rgIhG%<Y]AX"_ii:(
EWOUa!u0o"7"O@Th?b!An>NRd20%&r&^#4#K!Yj[O!r>9p)j%l8+45(HG#?pKj#2m8XuKYJa
'WM!!)c=NEDG,shmY!_'-MWiuok.4@et2d\qXrHMdU'+NE:_BO]A:&RVllfZ73KgoYUB%.W55
Y^aLcTH]Ad1+D\MMnFndf@)pAfXY?%heuVohK!VM($$%cH[o*=7%9ss(p18:kZ)C2/c2uM/0T
tp0.(3Q%6#8V0j[Ue#BuJ$Qn(%uu_Nka]ANr_US@$PuMk8Ph]A^.AC:HH/YK,XUIC70]AN2cRp#
nVh-*KeHh`H+pN%aF;kXtN,mG^55*'t's`J9QgB&Xrm88EF[(<o*\Jd>J0!qLa:nuqR<9=h"
'Bj*<$;fLOZENAhm-Kr)(4lk0=uB>3W,)C'5!K_R=3"EoU<R7Rm_(GnX$s93>5]A5!2^SjPFI
^k9pDQ-*=n)@ANnm*3AS,?CW<+an9A7BMMGQ`Jb`UD;k,?K.i_CK0#;hL6E)T':lsS!eeEH<
5/m<0rIL/OSi'63-OF5/-f_R:iqkBUF2\+]AMS@NLL:"ohJR/T#+4D1CLhnjHj^-Y$T'tQ3b#
_N0'L1b)Tp*CVQa*IAnml1P%6.Q5)EQG/17/@QD4G&/:&[$i^V?8H)<T?apXm1dc0;$Y(dYT
C1_!'O4;DMV\J&i^h/gO)X+"I9Tl1:_AKDGhE2jIZW(:]A_FLbX053L-aa"!`bi.W6rQ%or'g
R8.q1f[407'^gd@*OtN$EN)0-lFE7om,CTW$%s]AW<n3;OLQ-*9+A8Xk^9Y76C)(kmP2lXZ(]A
>R,T4Lsai?76#fU$bZ=I9+[$?#ke<8CYH\f1%&jF^>H>eG*l]Aq=C`88af9WCg+(I]AfRcObF(
p1rZG'<\lAPE^ERUpuIC3X+cp(f$]A1AoC#>[\3!t#.3MD)-t=X^qdi]A!"@8#0YA?f7$:7m4'
JYR#K[NCTqDD.Q>f/"=a(YQ7t#-21_d)lV%Vfn1<2r/Qpg&Mqn!9bH)G"_emM#,eAQX5E\F0
c(hnbOiV2mCr-F167kW?S_+3R;?jGaA@\s\eNV3+?-(4Punj\TbbQ\SP\]AcrnH(':[)$V^+p
:(@P@Ro7!'O6&'EA^spi>7kR'Vn'*NOU/G8t]A7Gob-.0mYsV+)e\ltM5qG/na(I=Y!:=W!/_
X=='M.4_b=ZOCQS@`<CK[WB;U7mLj>YBMr4Jh=iSg(TW(mV2'!'38V).ik&@h.+Ei,rnTuJ[
M\PbE>]A^9]A>II>b%+A!crSqu7A\*aSOX`sENKajjG-N&d5eTChM[?e]A@*p5]A8egpP`3I3GHW
%V$qX3u$8MYP,l_Z/N0&Pb`E;D*IIa$\mPOC2@`oA/E!;F+D<Zn:g"kf-hYd?45-32a3NtH\
8%]A:_[/h#Crak8I>i$K=`enq`#NT8f%Z"gk_qkgPu:BeD[n,-4Z'-3<)M25pBPI(E@"X7mEK
Wc^/blY\Ro#"Vs[p^"C/U__l<(A)i4D_^Zl@H6XUqo[3WFaK(Bt0gB.i1;*a^nMh$t%dH0pr
ZmjC^G,BiSPXNm:n.A)D^3/uGQki)W'\>64su#t69Zqqd$Re-DJlRWL!?<8\17L[B((HBbpA
1Jl5Wgr/,"X@!u,>U'P?ZN0GG:ai"4/;!,Hk'[DYT!=[mD)1DBY;[f<)kDWD$2=,>/-fnaC.
n;a*-MXnS;-@dF5q3I]Ak=<9-M5/,Y7h^aBkB^oRedbldum:f>_&9]Aj\,NnF]A37JXo,r=Q!c7
7T\r+cZDFl`UtJWC`gM7:]A1]Ag4A_?9M,B-.=$Ma8,@P%()+IZ"uOK]AkRhao_oQ,Ej"Gq9CG_
Vht]AcG!U63A]AL0S-i!7d]Aq[UT\1A.2BLp:h1dcb07bN`U=G3)QKl7a'PQ)PlSV?*dR,:L*Ki
`nB=]AU)\F5./50#,K#E&%6\CS3NMVD,8KOE4%qB,VOr*87Y_$O<n$4N[!Ni88U9hq;j%A,+/
:7reNh^3:/0a`5J21"URTsXYhkH-n6q/3+gpVs656QlL?lu:0qiS+;*(]AA?#+F2cecJ"S>(V
IHO)Thha$M"K`N=oqbH0FPiZI1,b47g'F5-*Ghkt:%SC/iVVot8u`OJR\]AHM8c\Vfs2hQP[k
!4.\V\9.RFtR=5l[7.<JH:FDSggeW>,BNGcUn_]A@n<a4cQ]A:*\p3!j+M*6n$%Cg'AHStoF69
*X%f^/R0E0#S0BQA'8$Z\0Ol!):+,4@"[h1&0\1]A7ZX3HOrahj#fi9k^U#J4ZZf8)H,(Sge7
<"6k=tce^[MYJ4&s;_S*i1)KKuq"+/BEIV=l.@ERa#6)7]A.1IK!djY_rI\U_ruGr=u92\Kk^
dY:N::nBg2F;Eg7eipEK<V=g$qu.N~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="28" y="20" width="112" height="46"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<Listener event="afterinit">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[setTimeout(function() {
    //获取报表块宽度
    var wid = ($("div[widgetname='REPORT4_C']A").width() - 17) + 'px';
    //重置报表块宽度
    $("div[widgetname='REPORT4_C']A").css('width', wid);
    //获取报表块高度
    var height = ($("div[widgetname='REPORT4_C']A").height() - 17) + 'px';
    //重置报表块高度
    $("div[widgetname='REPORT4_C']A").css('height', height);
}, 1000);]]></Content>
</JavaScript>
</Listener>
<WidgetName name="report4_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report4" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report4_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR F="0" T="1"/>
<FR/>
<HC/>
<FC/>
<UPFCR COLUMN="false" ROW="true"/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1713600,1523520,1560960,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[792480,1728000,2880000,2880000,1728000,2880000,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="5" s="1">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=$name + "实时销量"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" s="3">
<O>
<![CDATA[序号]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" s="3">
<O>
<![CDATA[店铺名称]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="3">
<O>
<![CDATA[销售时间]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" s="3">
<O>
<![CDATA[分类]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="1" s="3">
<O>
<![CDATA[订单金额]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="5">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=&C3]]></Attributes>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.ObjectCondition">
<Compare op="2">
<O>
<![CDATA[7]]></O>
</Compare>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand dir="0" leftParentDefault="false" left="C3"/>
</C>
<C c="2" r="2" s="5">
<O t="DSColumn">
<Attributes dsName="明细表" columnName="店铺名称"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper">
<Attr divideMode="1"/>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0" order="1">
<SortFormula>
<![CDATA[C2]]></SortFormula>
</Expand>
</C>
<C c="3" r="2" s="5">
<O t="DSColumn">
<Attributes dsName="明细表" columnName="销售时间"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper">
<Attr divideMode="1"/>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="2" s="5">
<O t="DSColumn">
<Attributes dsName="明细表" columnName="分类"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper">
<Attr divideMode="1"/>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="2" s="5">
<O t="DSColumn">
<Attributes dsName="明细表" columnName="订单金额"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper">
<Attr divideMode="1"/>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="1" size="72"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="96" foreground="-16711681"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="1" size="96"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="72" foreground="-16711681"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-16711681"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m99m!;eO[)3d!KcG3ndXFX+#U;(>5(WQ:NB?)!1X,??5rP#fN"/<O4YZZL6l8W>u-&Q2'_Jg
"\uKTN!P_\=@",nWHVQ!f]A86kYYUE_5hWc?0':!P*W-rqY:Y5!0>V^\cjYSaX5SIF%^Q%fbp
5oWulfHY2!=C!U[!^F!FD[->YGdsh>J+919uc2.b.l_[B,nD1>2NHb)e(f5recc6gh9PQSs?
b5Nf]AWt<kI>NIDABa=E"\f*t*RW&n343g[O-OMkm)tsn`*_E.A^]A[[pBt,-3qrBmK-A#0\lU
L3a>^A0:6\E*,h8ASZud[*[rfEu24V]A'"LMbd.kTGB4)YqK:HVH/pR`N;Qh^/J]A&YKU)A1ta
PX=SU,PMqrD3^f;Q$gJ?ZfnBMJ:X#i!\Ut-r8C$2Pu^-1;aE:h8DC=m=><iCGCak&2TW$/?n
kg/jT?)ACE7&RK@-T;I>U!#R0j5<nsmX`p8!@G$Mc<#-Pp1WaDXdNZpce)D-o?JEJqN94O7/
rQ7.!GcJ7SSQP7$[<<?OI/]AoHCJXQ7RDeCZBBERJ#HbF9_:uCi7`PZTVd]A\S@%OW'k7/F,N5
d`l$ea\7qd*f)lcLh8k0:aoVfL;?0Q6D]A$AQ`C"8GdXW[%_GZ0Ve/$n_A0V;0ju$YNTY2Voe
T(h+Bj=ouC0ne+UJkoX^N?`*-r>CU87\=<S@X]A3'MPV\8r3f<!5ec,&[R`fmMhRTYY6d?]A,@
HVIXhVRL(pDKK05a<3l%`nCud)RXH%!CI(aE@#/lZfgrfB,St/YPbbpRkSUB+4if^S:;QS/`
(=1-O3%QMqdTIlZAAAmCHfDN+),(mBs'-o?(jQ)tL3GBpuN,aCJ,3q&k0or7s^@d1FWH<]Au)
)Ij)EYJpGfoAs>;V^RsC%M"d4ZjVZfp"FBT#c^E,Aln<fOKX!&B<M,L]AHbV+;P[]A9Nh51hNH
o"%$'f2E"'YD!r5a7"rs,2:XLT7$)19T^sje'W(eqP\P;P/(1m:sd>-EWsh^U>a\YS'<60c.
']ACopZ_K&MIf#i<".4.(K<KG*.$lT)Lm?$meVanVV$<bRo$[*);>&0[P]AP."+5G_oqEEJT88
+(3F@4Z6s8pHBR]A*gP$[8TTgG^>?rW:ZUY8XEuk\6\,#b'18]AsJ8;R!">:H*T!jB9c?No`JG
T1?fm-D38d:@<%_KGSkI0".6_]AS.a(sqF]AH*nSF5#c9r_g7fO]Ah$RANiN.bl,ic'An<=2h*A
%nXSDg8X>[(er?'+O%.fM<WckA+kG)R`?odk&6AO,$'cecPl]AbTXCX8a+n(F8b3[[u92!XM*
tlAogR[GpQ\ebtWsFDG3EI/IR,/.`2u::#l(5?_:Ygq;[/PRoYGrMBjGhajaX8aOWf>p6&#O
gD0Jgl=qbWX9j^Ru;(p;h#N2E2_IA*84r3g/r-Cd-Q9:2?dG_8@T]ADeA0o3ZN><Ol^5]AmIQ*
_CLH6jI]Ai8rS`GA_<AdLYTkOA5;e1d)`BD!)l=\S`B<A_SK-26MpN)rrbDun77=je%an!.d4
9Rg'RaJsN`SSH+C(tscA[/>_1Uo6a%H?mJ+Z0@'.RmW#5TIZ2Jj&)#Q\V(iL>An;;u-,Efi^
*T7a*#j!ZOjJtjYQ#4Y";r?T7P\)!O]A2=+\l0c#Ce,C.9Fn_(BD&IZRC:L_/sDne$`i3HHa6
!BV[;l0!.\Up2eX9f-9%fi]AL+rB7:<JnPuVX_WM[>_QBhj&VF+u&d:)<i2Kiu7k9UN/LS'`6
9PhrZE_m##gX8E@+iS1@oJ$"qphpQ,#L0+7MYm8Qq*><l1X"+j!k^,!9bQhT-8oe5Zlo'hVi
Xj8*"O;VWsZ"ocL_Yb"D-H]A]A9.qCQ9<XDh9p73t&Q%VR*aDa@uQ`Ylq^stH/&ef_,n%0-/2u
`^[7nL%rS=eg.D;j(U8,74]ADHD<^mAT`pq*-_2,"[L;A"_dJc&5I?Q:,;&6gRJf#omoj$cV$
c7nsJ.QKjE32k6<rN9:;8F^ocJQ7nE[ZPZZ`b"pn=#S)u4o4'6`E@;qEOPf(TIF/M2I*:4C>
lZr=>@Gp);Y<)"&j)t72Ltb+XDk:>H=*hudmp3g2-$9)6.(!XE<2Z9(dls$3,"\1.L'mXj;<
A'4)/c33/\o'E-nbV?9#):rb)gs:9J\*D-V9YYcC//6eh#ilm6b60_6:!/nWG"0[O=950b3]A
%^LiX'^VRD/c^^ND2&>F+j3@[Z4_*8c+)(#A+,1Rk;VC+N=-DRDaBC9kjpo$Ulj@JRFf2^9O
*tF'<6fa?BkNCldg=TVOBkfY4#-V"hOne:d^rQj$eg=o2pA[b,L]AG/Mp;qXKMs_g.nqO=PcQ
^b6'?T+6.&T0rfMr*k]At!PfSQkd`(sMqVrHJB5"R"',LNa@77-ca;&-2?PM5"f_N":O+4P+^
XIl'DLn8obC`gf&Z2,=,<W#5Z2^u2Bc9F8.\Hk0ZInY=JinEuM[ZW1WNnbsK[J?"e,g#rPqK
$nF1%5@n+qtqA$<,RRk%"6QYI0b-B$"$pYt*4gH7mG-L.ZUdF\amgmB19?npEn[8sGgWL\$3
pPiGB_mmn9Lf]A`)1Q=QRJqat0*>bQXVf<8DV<Bg*H=grRgo@?u;Mqb^"(=b9SDH?^F@$#M(o
Ga2A6i3o0YBqUV79E:4G/nU]AKe^9s!Tn0*uHD67XPet\5i_Mm*ApsA2+,)N"'Y-qd$JXDRrg
-]AWH+<hSS`b(Tkc#kU^X!)nQn_2bL1M2hcisF[C_sgg@kH6NbgR:-<0Z?$0elh(KFO^Z!YCH
:u_CWmOsKY*#QLaU[V5*BK.tP+?SPj0UG7Q#_pchUtr4Z.Om7NdF=AkO\nBZ`#<;;7qq.9H,
?kDG!?X?/?*,86E=22'Q&0@:s?a-=!c%'_&9GDqFkm;_<bK9\L$Q]A*Wl.B2#[:X3EbcHH5U5
:SL$okMf15^6?m!na.#>A`!`ARaFn2Q@9Au*4Al#N>t6>W$]A7upApQGh+=[.`-6o+gIE<LCM
o@SG6>&C"_=V&Poh7q/uLN2?mXCA+5inJ]AWB"cEbN)3SN3Dg`rR+jM>"$C%iu\7/fbIHD,*l
Vs!$*'Pj91g]AH9#]A456.lY5`qJ=s##WW6?A7h]Aj`!dWG&rE:pJV9fq8EG2io=@G.bLihlqP+
0;L>01K:8?SM0\_]A/1rQAbS7HZlY1`sX!WT!O7jf(Kl$g7+)Bn@8,*&EEF@)u5UP4er#MIJV
;nb1uePM<?$oPl?]ACH[:1@)aM!"?d'H:Qm*`GWMOHrCn_>#PBBWf'kogL#eOo87:_N%>\m@l
PDYU$49EH:/i\U'8q[V(LhouVT(=P$2h't8J%(*M,YM]AQ56VLoW'[D!hf7Io9kp?PEkK(d\j
jW1WGHf+`LR]AiK%uc]A+)V'G\:F9hl+!hmk0`hcmka"=\JXqsn,O`>^QbKH3!b7kZ5%o[r2o.
mmrehn]A/o*6'#3rb#e?Z-_:4+PJd4ZH7[X0;=M/03`)`e?j^2M.Q8h*`J.+2W0FnDs^7(ui^
Bo?EG?K(0jft'Khcg\hSFX9h>3iL%T`,O7hfCF)cXgUuHL)9NUg.st'%;@%nPbJ!'T5tl.__
W$SlWS8o>5Xfbd!%O"9Cjt5*+MbrEKl8mjif<DJ^`jdHiUqGu'lQrF_/M5_r=b.:R[6GWK6e
NiW>Dd,+Z<Fkb^uil@Zg7GgjV>t[.#SnI[V$!bWDh-'=4.t=M*G-\Y/']A?7b_VW%NA>&Tm2u
e:2;kL+Q7M\.9!L_e1LH;gX/QV/roM(rX/J:22N.1hS_%h/;[M'!tTj^O9]A>p.Wa6N]AC@fEa
j>lrS>hR.gRVj@A:h;r_'nb3(eBCsf'hY+H^9mP"C<p<O.0[@OF[$EH3%e^Dpln2-c@[>00]A
%=-i(o*$K)B568U=/"GEhR`IQo=TJ\:;;OA]AN]AKR1U/dI%XqE9r!VD66J^N-Nhbh>AuM12`R
?p750k`+5Z.1qW0a?Y&H#:M+aT%e[R]A;@6L8Y*T60Q4"$iD\n*=9aQ0Cc;DlrVDJu"N(]A2M[
rEl,'&FJ1Fh;QVrh\(CfJ!!V1HMBC*HB6fSIUL^82?d0s(8V'_Z>C$d5nYB?L+9\R/ZnWdQd
&@tbQ0L@AfS:m3Cn<!3m5#YNh\Ec..%Jd:,%=HQE)0]A10LJ,7`\GaO^34`O\IbeJq1DVp#)m
dRs\KP?E_&`+*K0gOYC4RNpCFQ1<^fc9\[Gj;ega@cq5r5Us[RGI(^cWb7CR)WfITq&=_!Ci
_FUU?Lm4;U/@QWjMkOWdOR)X+"QE\1lL0l_=ElA<3eiSNWX*H/10/TE\oaE4%(2kJ5>Z%JsF
qt`?V4mRCE*UN(0QYgJ/Jqoa[uG9Eh@t]A\8nA5`VQt/_O".c_rplY%X_n"be&`NQfl5RPr!S
H0Z@lCIJ4I]AB(!45luc[KkoFRVN\8lf/:/d0]A#Z1=jl860<c?/#u\O51:FW%R9Rh/E#jX+7c
g<\QRWb@R(I:8ECGD1e`mnZi)*Mq?]AGn*%<a$,+[_'><$aprhp!,:C^`"3S#b/]A[$IhRK/.F
UcYRN(?WE"8nor."Q>=Y&<SQ/4fM:ISFrIdK:7:%+JP)TSn.CUF<N7d2I;um(-kj!d"^Y;cj
PFQ>pq"]A_aqHbr4.t>>`^XNB\Zm>@6d_02NA1%1=TG'?":;6(>N)L;fWQ^IWu;'QPhiE.%%=
EgF<bI;.qIdE2_;.sUUX*_Xb.*`e=LimFLc_d#",<6q8h!kLV9lmf;ag&%!-TIJY"M5>LmQ#
MY*trl_:3JJY;@`qaJ\_H'S3]Ap<lR@[EksCYN`Rf@&tW3'q^]A+GKY,K=tt-bpeneB8BIKVFh
'HWU.mIjMOeIJb;C*V:3MWBqGdjg480WtFW?K,1s;'T:45NF<F(&`Q=lS/CKp^JRDLU)f5dk
bqFi`2S2,1e.>omf/47Ptr]ArINQjEc$>,_4^EKmXBV!^t0%(oM?Y,TK?-SLFq,Z@on1[di0r
b9Rd]A%#nSKcndAlih.I26'*1_H2pl&,$Jr*M?$HC_@KqlCgm;hnJ`'9gE5OLG_m-k()"a,&`
[O#?uL\%StmbEV?G4EV!.hJ6Q/SNP7r;i!(A4ZV;E:D:rLT\)Ti2+\nJ2'^omSdAK%jj`HOk
,QNVUJCp#'3i52N+i?AS;`Q3ol9k+2$?*OB^)uTr2A[ocMa=>BrN"R<[Ht1EB82'(*L.5$R:
\$YU-m&#ML2%IAgJN(1gdW>Pka:<47/0%ERe?i+ED`a]A9_ofWU!;+"TjWa']AH[]AL'ESWag`t
_=@c46]Ai*oDFSY6H'>XV"NtK*M4bEl#j@XM>3na6?hH_dsjD*9;BGONrDkA8lT2^H`G\2H).
m$tL6`5%pM-=(]A8d0+C.lX<I&@V!m=254PO^d>#q0Xg@CB_p6`fl\oZd,^2h@M=:#^"?Q`aR
eAcYQ=U)'aGtRc6#m;&e?A?f(:&U)Bfd=)LfEq#E3GUX/f]AjT4A0r5:Vmoa:F/=uo03/SJ"]A
A,'FfaJ#1T-HWm(P0>j!?-s1J!Y3N^\i#C<bIs8b,B@h[oRp2tJ_Ep(<'gO_m3nuRInm]AY=H
>\_+j'DtT;^cdZYq\D?,S''9c`JUc'Wi$C!8`hpT4(i?X[^0U8'I%jO!528ft>bD8G/h-'!n
?,Bd(Os6jMZ$m<u(Jco@r.n:!(XTs'onHsuO2onDhB1@K5#9!r:?m-j.2l!!Y=@'P0hT7Y5H
tAn`flA6L+HNn8T-^L^]A[AG_13T0ddMg;L*5-[$>X',BXiF7'(P@f)Sp?8e-=uDIisaJ)p'B
-mm$X1k>_FcPg'o=uZ76sMY/Fb=mlJ6o=5O)7=XLCT+(8%V0KpTJ?,J1'l=5lGXbX*gOhG\\
P[G=#*_(b,HAbhiG'`E(;@=eEkT\9KOt3&o,,2C6;B/06ZP-G?6klEOnUY:dF>q*c0$?:Z!G
or[1Itq9a.\fZJ4gKR:JRme.C&\QEL4FBjD:KW\keH<>X"-rPGWf^(h$<(p$,>L)a=:a)brE
`R'ADeG%J4]Af*,l*>*Qj7;7f/%gmd->pgGW3.CSU7jdPJi&NtQa+Mf&@V2oT5S,]Aat;cgm>^
fYI]Am>+;m>2r-N1U\atJ,D"gn56Ccq:htL&J@_Ar?9Ll4LU*=ImTd/R"55e&O5X2\;*]AkXCM
ERidro0(V+'&X@QP1-fWQM1q234W3"QbG(iSR7Dg&fg7>$Y^%HLT0M#1kZ.g;MHL![NTI_Ar
(q2RAZ8d8qeuD(N>dBKF)AdPfrc)Q-[o7sAlfhdOccFoHbo0VJFEKKAnFEUE'DmS-VX/!nWW
fuZV[N/TH+Zj@-c\^(okoC5La\-EK70nWc\^\'N,j?.SE+F!#HVD7oA_i7lA+GI4GWWTM=6=
EVRXinE5eC6:\6%d[qBX/eaOBqLh)p+D18(1I%:5Z;TCmqhnQCj(6iI3)otUZ@/=490%6IJ<
g&k?ndZjZd/gnNT@lid2k/nE8&L>W*H-piq2_7)1n4[7D%KS\<Ls^JBB_BkYGsW-\ViSsAQ^
921U/2EeB\TtDbNb9.oiG\#$1<jGd&X68iUNM/5W7+hKNr#d#?a8L4sgQ^j^m\Os^lnTk_B8
Y.8MZm=LKCmV9M7Oq4uNq.Sg0Y%t>2!TI'IZoZ=&C<H1/3^1i4]AStKPdb1>Hf+>ZS_GdmdOQ
W)/P"#g=S@39Me?'eT;&(s^^+Lp6j[E"9n_@%@VKP1rUZZial`lVhEK\0\q[EnCNf@oFMVK*
SXR35&m,gKoT_D`&n3mD'\%L>;'ga\OE9f[CMcjf-W)>$.?:&C#EZ"Y9FFB7baC3;<FZc;?`
C^-sJbV1Xr0T<'_tQ$(bXt_]AOWubd3q*+nMr`]Aci#MrN*1J>ljVF7J-,QI3:maEjFlPGCFt^
=0,=JQuLL7sNTAP89]AG+@*X81"eSP-hp%%$<p(7d<+Q4V!X@*,OEj@i9fef=>28l2lIeN7G+
ObDaEH!Q;Za)'a?L3Gd?;o5J\R?IASQ-UNdaD^i7is]AO1ATZq%Qh9!Uku:.6r<E7.Duc9bHD
//G4UQL?,,2g$*-0dTQDKBQj]ATF2a1NQ@''&/YJC&i)lWqMD>K^]AE)qR\mg&u;22#RR.XQ*9
MP`]A]A3VdIl'\uP[fHBE7i.t2A*\]A.TsCbuhBMNa:7SV$bIP-KiiUoPpfV#'D3h;%0+=ANueh
-'Ic=O1u51RdEJ)3Ig=A>;?TD5B>s./GF(eiAd16E8-UOP(;sp=H::ITlqgBo3C%$/K?:2D%
4P?b7dk4.h1Y#Z-&^@GI2%Cdp;1%;n<7-2P>B^S&.K?%YJ=o7R-ZRG>&_q0+$rC;kP>,Q.>S
%gV)t_K:mY=K:iB0iYsLj;W2=7p1#?<N`YOPTA[7n5oshk]A2^IP7jT"nGEs^S3nNln`l1UW^
\XO--a+M_NOZ,lSASqTpm]A^2.-#nNf>o6BM@rto#W"bqZt=W>tY<:YP544ZPB)S*,CkjDC,7
oX^ukEXn!Jt]ALLKD'o,d;<DiMI.+\H"_`Y_%6)oL/(Nr^3J-m2&8[J^,7@Bd[6@q0pg$ChL*
%G*Y*#7EMjc^ZpB,Ihr-dI0'fA"T9mq>en=n-^"g4keBC7Um<boOn7UWN1p(I)(GCfiE:/Sb
=G3BjVi_K=B*lLh4=jdgk(YbNn;qQQX%Qbdo#)WN9"XKibLM@p:8>D4f$D+?QY3d/C`.sDkT
!17aXrki19SS#lJn#56d^FPi6NoYW4Vqjo8H!2AIj!&*2-60bP8CKR+=]ADY)FR_[EW)p(A,Z
Ttbhm_8N<$=170\A+hb2j@@3N*`U7+;n;_Lp2']A@tQr^s?oB64TmPUDh)L2jL0qIm/YN.."@
!GnrpDr?JrOGo=skUBBI*V;,aUX[T!UME[:hLH3SQc5J4R&/l\W!*3!6XmG'!3"J>`8$gjSO
W\lr_75N6UMY."2_N*OL+VE7b=LQoqDub*SpXa`(su,t315/^nTg9d6!jR'`tRqW=#M5CmmX
@>HpHFp&G?UW3[>,p43c+U29Ct4G<L(/dMra9Y)Ca:4`oK9:1J2l/j$bV;kW2[_+Y0<QWKb:
?HV+Wat+HS1l,XZj8P\^o-?Xg]AL;#g1q)6kntIgNQ^IeX!r%;0/@Ob3@t=G`U"^T16Na'Kp<
;@P;GP2-?K4SGCVs5q,3LF@I2Ur_;TP.]A)gp2$F=/748Fptp=Y'7m;=3Ye'-ERtT<)h@R'j\
7VMnK)@_O0K25A(g9T>.+`'U0./#fjR!q-/Z/u=c'Dlh+m9eGhslAXAZlmu/6,D4%>5_I"tJ
OC-;iPE<LeI?\+kB++(4(*W\$(XBoJlJd0qRE!.;/):)8qVcp/=KfVs#:J(/gWqL_.u5mc=&
/p]A#[di7;)Q\[rHc+EF1!e0'-0+,1lZfj\$<QSN)b<1_Q#=qk4)H/M=slNP:`i>opL,Jd<'A
*c.pN2q,%t0Md/S?GP&0h<Eup^`h.@\W7($=$O1@#1bhZN[*,Y0>[&<^2*2[<XSRk!PQX]A[G
RrmpTPJPUc6^ZS^$FYC/O%_)c*MlW/aTKD>3J"J7NXC#2p"+Qa)JAR;TUlDGW0^U,X.)kHk5
*EIS!f[fd%5mF@]AW"RB=7/=p1+=,XXd\=LNG^*-_#Y#2c"L$f"Wb9b?F1'aZOdX^W4]AtW0H\
R-%+\TmT>\sN083J&ko!]A/+%">&/tO$/O+(ta6u^6.A+(Gh.s_OBRARZk'p.uO^gRbp91;fn
CCGs4d%I#u(A\b3_WXCe'I;CBcs5^TTlL0O2">OTuZ8JNdH,+]ATc-<3%">Mg=:82;#K!Jrlc
N.!E)eOBiYE(PGJimtC!3(<CGb=4Z?,s?rp8Z>NbJ`\k7\IM`7INPZ0Ed:*J0,!XlGJTbc(e
OYrTqn8*?7kka0==V[2aWONG9kQBkajeaC\kHEVYlgu,;jqk3Vo>n4R3e%@Ln*neIL,">ckV
#?\Tg?JSeWe3`KJqVY.qge_3h.7MWf-St7R)M*i"maP#+hg\OR"\u5\W@jCM[B"<YD'"It9Z
5^:*QUL$p-u`JRR^/elP[oQRBk<HGNnI)%Ukh>H1Pg^tD3pk#-*,FU(_nb&6#R[nFlB#[O]AF
V?A.M+rXCD.Z_e@@J-?k\G46TpeIZ-M%CO5l_->_l]ABi@3,.$IB1l8_aN`q6lU\cJk'f9'7>
\Yn_$p^oboKV:%CeY2L:,)s^oDV5nNVk[X&.%`ug&/-0=G>GNufZ$o^q4O!Tr&DL,Y-(NYo#
Ted+PFUa;AK4TG3s'1qUTQ#H%L7<aB;?BH!^M=/J7'cAb)j]Am>_SA\?=]AcZDJJ*o/9`#CJlI
kI`[SK(UBuk:*<Uj'JpH4FS[OkA/u2-D_>n^i;/pg@J7B^bF<-Sm>\!hQoK8@m9S'`$m:p!f
*N\%Kb9R[d/r&/+S*,iWhDn\&.4>$1/k2jcQs^Sl=I,ods\=F>O`P-lMb,?Mp&%=]AU1ntX3R
eCo?q^#0B+2meggq.M68Y\2k\C4T<cqV"aggFk[$^To's<tp_6HQ8F(VaqWKM$S$EBthn4o$
'@20D.rUkk:cq2`Ldp`SSR%DEe,Rlq=nfDfH4!fA%5!%7h`S8TWWN>b*]AEg=rE3=SeT+C2`/
>JCF^U=*BtAM$dq$/k?smmDMY?T]ALl$Nn?Mf21s.WVSFlN0:Q2K2:]Ab.+F'2NE2jMO69Q;uX
_D&G*Uiq[82N.b<*+5/Q*fEi,TB)AQV0`90OT.JUdVV6?(`qAQWYQCmOD6c8diiYDsG@A1Rp
&ME"Z%X&$"'#Pk4p&_h+rAh%bTb<*DNorb/B3-[%mgA60u*.Dq8\19gcLSrNC$E??KBUm`m<
=#Fu0Ela.en50>^?LZUcakS$*JgNr'ur0_f4ei[U([(R+!PSN!giW4MmMK>K@J05V4Eg'&bk
FZ;o+_*]AEZ\D&2Bl/OJKJ;IVaB5`E/Ahg\lEblG,/-:ADMonfO*;7IQ)1rcZT/t6p3Lf1Y^r
@3UECj:AVDN2M[JIpi5C`h9m26[<lEci\DcTs]Ae=Kg2/+oC]A.4918Cc:1Bj1eFFrr$LXd&;s
5LSfO&j\\<Jg:M8qX8]A39qYjCSLckP7/=gPQmQae=RdccldUA7`4P'i^.ie)+.j@t@7\mhG0
`^Jd066)\D4NNJ-,Q51^79lp<[OAtX'6e@4o_JC*V=&L2C3!c<e'9/^QfMB#/JF^#?U'Q(R^
/`St=0CF""oT.G-/$V7P?eNKRU&,8Ctj`Bs_75?L(>#6om(0>'<o5s<F!@ItNoi'2`nVg:Ul
=3k5+fCYN=`SGdq#rK<Aal4DYjYW[MamaV>Cf(>JG3gm3O4r,^Og+7M2qd<oX/IlLE:+H:M;
'J!46\6UY$9\)dZ+]A<I$d/.bi)prOdT++]Af:74i.'SMCn`t9cDQ3-qB!:uG%Q0Kr$e:6!VQH
qW&F6Oao8eN06k`F!U_H#C/5]AJ-F,QB]AH9O@1Z4*[0.ma3I)KMWUXlJR%]A5dHL=lhWTt]A$lo
YW*/in%-BGa<nu?[-[^`X3B-%I:7o5=*Rh*R@F5jrsYar[a:;A$,/.KuYSc_:J&<cu=>$1VC
mAm0-0tUC,j[e*+>8%1GH99O]A2m:k!^hqFrq^;dkbf[]A$kgJ&dP*B-#bcp_KrQ0ZBthN;=d`
90Wp%V(uQOC_F0JGdU$ikJ/TH$);(siWL+=3ke-#X$0km$U,K@g^b8*UE?kt]A<`3%8#P=M)U
+G[:-RkZftImGlRD"CVJ=[2i;VU6[shjaBC5,<8YMWcUP$IZhrMU;A@9[8-PR:uC>'DIA8<c
)L4?`n%b>2]A2H:$d2n]AW;[u"in6,G`%6@nTIq<slme#QjK0g<QgZ,eN;[2p?L*n0I+lm\;_J
b_<3c\#=kF$/Nd@F]Ao!F*OU^L2AB8_2G\G174ss[Kk!;N0o=lpYjp/bk?LYj@@&G;YNF9LG4
fUiJ3pb=aPfE>P1>!?Ka3-M(.@X!VcU-\@p>+H=8#J!09Otb,(\,_%$3%?pM0U%GAb^]A9@Iq
5hq_K>5`/Fb.er)#>;$]A_XAO60O\3uN%;U\Gk(h&$@\0haf(*d$"<ZO=m#jPIb8cM90<)WG0
eb5[WFrYg]Asm,TAKLrrA2bUSlGtASlcLEBRR="IW/\@EaSQbodA3hCTh#Zc"#$kJOGZ)<8;6
Xg%e:pKqlE_ahXpVRPN.QD@pT:?@)K1lK)f:dn)btnBZZBDKVa/dRS*V&RogKe/\=[03Ym>g
\)WE=M,4Q=IH>k.V4b5-WYUZao%539_]A>co]AM^hgjb*i"&",`-B7Y82X0lef+M%BA/!d'C7@
/UJTUH`MXfYELR?p+B=LU7p3s5&qq?^=U/@RbP1>+P<aoO1kl%)1%?JdL*4RcQfn>Y^7F%ts
-?io(+Ombc$Lk/N*HUC&OD_6_ApEC5#?m00/Qmltgp9n>n"sGR@$n_"mF/iqo:/L4Mpmh/(-
VGjA$e$RF;'\rEf[_tAX\9Z@lR/R8L1RYfu/(,6I0lR"IPlPXh!LO%&h9(M;X4iX.1fRWMbJ
f>QuS6c"A6(Jq%5@*)Io^iNA:UAfd-qEK]A8B1"E_qPL1$=7B1Z((VArXFPuA@%oeUKm-DB6g
I?.p/RcF_W#6>/EV^?SngR'V`2Uqs+ORB12SD:oNfXk&1uiA[P)hK,?s*O,jg[LC6L5Cqs-G
(;7hMeBP1@"'0N`mME"oLrfMq&*E1kalf`ZpMA]AFW[k\f-e;so=#&r0q0)5!_f-c1rOL^%(5
!*V-4NN8Tr9E`nMZub5+EO/?V2%$lnR&G1t&@_^3ka@6XM.k#Ia`1p)5%Sa;`8m=SKCg;/3T
@5SS1W9's7cu@2ZE9kr<7Mo3OI:J[9D[B0gU4(QJgR82.Geh#3kdPZP3T`Setns0oZ[a$W[n
uqrP>aDr\cLD=jNu;qu%d_F!Q$!Yb]AoYSH.L-G%+/$(f"!9*f9_!$-XP"sGF2ABo*2Z8OjQm
2@m@.B$2+T>JuA&T.>dioAq_5rT)u'FKFHKIq(n`<-Xs&$'"keOWQAW`<0>XgYi%CS@Y93)_
nIH0=WKn*[r,q\U(K7Y+)9Vo).GHF:5a6]A4KdUP;WS(oKM:)M+5a>h10Tl[pX?4/HnGfa?>#
&'*$JC<*gQ"JK&g(a&H/nSo4@GkT^NreGnFaS?J[[2hpVNM-"-DhNnu2JjKK-=0\K=!SbDe<
1e!Ms6Se38q?j+'QCIk3A)?9TDL=5>f"gT\9&4Dci]A.Sd.2/Qm<<$/nBd.ZXEn(ElC30;b`o
`^U1=ro'4W:^HR0&T<5Z`*`9TjhG@1_=[a$_UoQ0nGVuI98.:hfC"A!Y6sHZI-C4)Fmr!sM:
7;UePo_cL'dU&":eS:Fel[AfX&@#.3V/k<RBSg;0!"bp^/tQC*VMN*<_Ob-s$[H&ko9^KdFS
[jE1VSk$/[D&m23:Kj!hGQ7SoR2BU?%*[N%39^>?L(L)onB)DjMYZP$;%he$C-Kckr'&#2[;
%#!7@-P&n5jqMN5Ih$1M>u6s4i<``OC'@qH<d6rTs.I`+44L%`^h=@o.KUD-VbmS"'1.XHn%
2pM>l[A.6Wk8[:jq#W*]AVFYMa4eDUI/7sV@(eO_K=35;ZtXMPLFj:[<4E,N6g0L>R#GNV;bk
k/`Y<BDrB3D,A5Ls\8@tBKB`Vul*,D(4L.#pV+I=q@BIod>UPlrP/&j,9r'hkU4_,62c^IdY
F7#unZ0>f1N`faJ*XoUUGn;,>d-VrmX^/JXeWDnK\7f.H,&P0%4Dfg2=[LOr+pLHW7)?Op4d
S&3Ei8&&E38:`/YBSb20hBHErT>3,TC#;_Xbol#-^%&i%7emSLg<<%(5#Ps,7$DheFq;)R.q
qE8#&"]Ad_,82Y?X=`?AY@>\!]A>"+Y0.a!?iXE\sTTQ%;naJN<q,m(1W;@'.Ainc'+9geQ4$9
7d=W0=Zrd-<kU/t-jH/`(#YY8Vq<W9diuCC@4:`P:M49C/lL#eH427)/=lQ>C))Zi8Dk&=,n
0E]AsX,+Is(F1VtX):lRY6ZC@Z.W8MkfY[`riH$U_P?>1;7`ZRkI:?[7#]A/umd%in>E5p.(H#
C2M_%Z8Q_!)H1FcKXgN(b8E,a/5LY7Jf_TZt@qYp.]AmGe+sRkStG0E[pe[YCF\4hn"]Ame~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="250" height="150"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report3"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ImageBackground" layout="1">
<FineImage fm="png">
<IM>
<![CDATA[D0gIM<;ZRmR5nac#%Pi5@Lstk-A>:A80k/X#n]AWu8qnn=2D]AC@9,fA([,#!/&k+">#$htm+t
>F38@EWH0>DSjf(XX]AkP+fDSF_1ocg,j>cguHID^1+Ib=5B78K7^18_`W5NW=S5!<<d-^a!b
M.NaWQJ5o1L<`Gu\\KfoB3@bU$EJ$/deXF(d9VGW:CP5oX>Wb@JD%H?d<N\/-R61pU0l4-17
R%R#b"be]A,]AToU`jq)%I#SJ?_%i<&;:ZLa1*P:*HM&%R;,[,67K;6iIkR7Mr]A2l8<"`+O)ms
qXAu)EH6;5=QWh'Ln06raO!O>Kd0;Vq'J1j@erVZE:lGIK7e;.3a^n>PLpI_L/goEB.WqeZ&
*(Ohqm!R"8V5BS51#pB"[oI\2din[_m&9#/8g!G,/_i&7_DNKTV%tmO\O,`BhYcGXE]A`gUf2
KP/HOa--D%tX9[$[Gc:Me&)Dc\3iK#gn\MS%YCd_\D[8eM>aE7%N5$[?`fs%hfMJ._Z:r<4J
B$(d$!/]A'Cjc;Vbhmi.8/c5hkPQN_q%pN@#g-nC-(^6&oD!e^8n#?^D*,MRh&AVf59jTg1[l
:<V9/)-E@Th,:+FqTdX.F.Am]ACq?+D4%Tg;m@FnEL1^tP+91!L3j'h$N:IIZg$`%EtFFY@81
\<jHdlur\UK:@9NakT$F#)J\frNGFCPr$)GAMniLo*ngCTIY.s&#^X"hq)?hqbp?e5AC%R+m
B$,]A-;@FMA5N5"'>4g6dReGu_XOW!rqh=0TZ8gr-e^d9aBqJH@:)pX_W,$KKJ6d,HpdL:D,q
i%B1>oXa5-$@&;X8#0e]AYDp]AZC8CejV'(6`ql:?q1M[&a#6^35iQQ_VuhNVfkt1YA8B)GOj'
facU/DPTjui:m;l.$i.;:7bB=N:,8$^&0&ftrR)'(Lt&r?)osXsmgcG`Gkn`@[C&LRC-+t/X
aI&Z<u")^>De!X]AkjLUa:H:1g:$?#q'2A1SlU7>Ke(g8UofXBR_q2.OGp'W,W;/A1Ee#RQgR
]A;8X34mUOrY<jM/HWk_lN*EWWMU%(l9MLrJnM:JYDN8ZPGLX74q]AmUeN_'!?+m>B"[)q=bg?
h$D`$T+K3FKL0%-X\KqdO!V"&J-rKC>OG<t8KiSsbC1?j)0J>$SF0A95mLf,Xor`=1!J'#fE
E+Xgi,^:>EFl),o(#`3`-b2g]AQm('<VQlTOn@)C(#6;$T!Q10HR1c&=LbAD"Gm"HK%[7\=u>
u2!M3hN[LN!.5/55%YT-j7]A8;S.7&?7nM$m902(jslm2:fMi0^c\L^O>XW+pWg#9Z0S7aXhX
BJe9LDc*P<3inPB_t=I*<kj;)9MWUGH=="CsCHEb9*Y@c=??drGJa$(1)]Alf>oOJYT>'!:RH
=Ga.*$OUT-56#0ULFOa%l#\&PV<Anat`ZXB2:j:QG*hYaogoRcAVCnqWEIaG5[FsLPH!Su;r
AA\?=j"#;UlKAbGW!ttPpDm8;hh@G:#8>$olXgY>=T1]A=EPtftM\f&phk$c(DN%+Rn=&:3'S
\*k;J!)--ZDgqJolqtT_h4]A<NrH7\kkmC-I;2"lF'7\f,Zb;+E9sLS#&hnSR+F8p0>7H"#DI
n&F%mHC@`CM\?WDtGDR0P_'D<oo7n,GJ]ADF,"!'Ye\id.ZSG:LNG9:UMoP^2>/PY*c?((i2S
-ou>I\@AHbp'O>:4rP35bVgGPr(RaTieCk]A"2`J3p8R'W&gML\DD"fCnr#"(S0oG`2i5W!u$
43('B0>3d71tXg\*;2O)JQRlOJ?@EdT,_HQQhT!=rG[<n_bL@/2L]A-p7j0hk^]AYtH1i-\gut
niba-J!9'$eV+5R-qp#K]AY=QBVd%,*=_O$n^^"a<2HHND3=oc6DPCGeJ=+td&GGM9^/&q/da
,e!g>@B]AWDr9ne/qfZ0m[e6Ds#H-ICSNXOeJ3Ai+[`869lU<V';@N`I)&0jlq@0S'I;$^Jsk
[C?MG>ShBgOS0Q@o<0`h8n8G7n=@_$hLDbLJ=9@5o_)Q>O(#$sl_7Le2gLf(b=(g]Aq'SC2)"
"Zpc%9R(cI@,Z-h%S!)I+F9;_QO7SI0gN%c?&8A:s^MA`&>O-YOIe_Cn4@k$5=.Ig[]A`KL%s
<gCh`$NR_uZ-io5#[OXAcr]Aqhr%%!V#o4=a"sP<%$"(3qsgI%[4#Z[n,npgSm=%hTd/a>s>_
oS7*r3.P\3,'K*!13fT_d=]ABLhp5YY:,H0a`QHGhTbFtK]A[NeB*$n8f5a[bSB',Wrf-hC7gX
chTjEh_)#7u/if`#:07M8HRHQ[WIl7Q4YPXO71G@m&+:#DcpMc^bK!*c!c!gKe'7pNc&8Y=R
41bjt0hVIaNbIVohqS'`9\GF0n6D`+;[=i?X-Fo0aJk.(P5hob(g9$,<@*;cu;)2R<DVJF\U
8$\pn3,<ZX7=ETj]Akg$gCjeZKJJ$]A$_4U+e:?jc-Zh6'>*)G&"ITA2S$%#bJ2JTA)rA^p&sl
bZXYdNeRg'43k6_$R3:_d4/B:_G^X.E7eTl0CidH&T1qHsH-I(VnGfa@PmL:2^DA?P>SSOod
qFf>@98:r77tAM>j'l\P<>(JL-d9n/G3dCdh\/nGF"!j`^l/)u_?p:ndh903:$Ji@/3+.%EZ
3"UD%']An3"-9=Kg.k^2K;ta1Y)h4^j)X?DCA6"@@76@pj2VrhGu)?D"/OfOGPQ[F"G05EQks
E1N!;=l'$[d(F$)Ud%$KK]A4!\n"u_"AmK.Kn?f[nU\>2A$B@YQ@!2>k/\;r%Z)\0CAkT4B+-
13uHH/=\o='9Ou<!X*f'@`qs&OBD@5Ru+t#pUPh"+Cg&OXG]AKRV\!7U6hJf1duKX-K3Bo;qY
\n9t'gn3ibr<>t3O3+s@/G9e?!i[&;l.9hC_OLTC^Wdl0$*g5$s3ZGLhf4R2/=4R-;;a-04^
r4&#N#q)iIAf[$<5Erp[O@#LHASaat$NT8ZeF>t,c?j&]Afd.GGE*tc4lYA8Q>;s8%ijXep>%
kbQr3`gm=Kk]Aa#"0UTWb7dZ#oEY=@RA/c1eLMB!_;-@BJ_N3;DE7n?trt=@[3@<cQAGu+iBT
ChAm:4]At9B`f\P*:Is!g@4e/d&>>3Md]Ab?.$Oj=o<Sc&mLH9Ll;EXhs-\`W^l(Gd/iIehB.J
U#hWgrr\tipoS:RiTFW.1eJJO7"leF+9k[[8D$U(A1[e;6s-`bR_XKj"j;8b9*):Fo)@gkW@
)bGe%op%&UH)^73EFIK]A^gg_+/)nJ$7;kcDJi;eWW7jD@tU6+\>&Du:g_!5s(2MTqUNgm`eg
g0uh,j*,SGar*eU)?goJKf:XE=%4S=aFd+`g@Hj.8]A9!O=JU;mb;nFFgWJG#!fa_BJH]A^n)p
aU(MYi^hp8qYnhp\un_JhK)Z1.HESL]AII+cM>"AHGL7jiogd^nnC:?,;6.>WM^LD2)^kO]AfM
'8uRdoO)(<);VmUjnK^g*@V]ANXVrFLnJrrnfStmVqC+sPCdO/_m%6iFqoQjm)rS')8&W)Uj]A
OF#!kpR1;MZ#$>X5&R\5r*fQZG8*+^7hHHgN"B2X>>,:c5\QN-uC+30^169/9Ps-Lhg7,gpu
7IKbYCA2fi:fUG-(?@\G)lUU&gP(o.)S\_XYc!7ULM',?i-@g`oV*C!,2l5426gQodX:V3uq
V4:p=V)QrK4D`8"<#28`^!H'M!)@-;O<>Fq2SmfdXGnL$*shbHZ+aq:jHE7=,N&;4:ZmBY_%
[o@'ZL6ainc$l,]A@>gUs'h^QSiLP#6+(P^3EVFM99^B2;,DZ?SXB=?>?MB5#%[pdb#$a&t!a
dU\ZSfZ">^b`iW@J=WB#Fs4I1<nqe$lT=@:$GO!t83`f/qTiWDY9tbjGLbk".'C-mVH1<ThC
q-Md,Y2Q\P53pB-7@O=G+8>]A;!;3e4n_t).<.RFNit;R.Ha=n^%,2:fTG*HS4s)?GCm50]A^+
[qk?Th9K]A1QLUqFZJqobUj,L6QQ;"GB2G;XMcp[Y]A>=f_enj6epi+\@u:F#3o*G.#NPKAp9+
1Vl.V2'i?V'K4ok?'2t]AoQ0Og9Cc19!s$W\gr;)oS@?CC+;6B1I'OO&ji*.QT$,CJ^P<&ACL
eW"h*$om680,dW0mn.aL@gW=1[>8%UuI:C:nA`GjS!;Umh"RC6.DRr*\+G1"_u`27SS#!%$L
,64O48brV1baBo8(<,h:en]At.V]AK@C4#0^%AD/paC!s@Jj=7!0TUFbq.ReYbal!=B&oO\^"&
]AZ6.o/"pLph<$_!5M2M<77Hppplh.&##okgcNO\r^0^@?!o&gNi=2rVX6o[@^F#q9hHI[_"[
<\L>1+0CUTQiEOq*CDlpG]A!J%VpG"U3/84F@0"T+P5?q^GaiVT1S`kn(-M.QCYGlS#a'P-OI
q)nIdQnJ.`$P(gbZ/UfSa-l3e07"fU/[3&GKluTg,Bj1%5p.6s%n$WJbt-H\ei5E,M_T<QPq
)6A&4KJS[mGMQ$gek6TYSV^0ft+l]A3>c8ZVG(//l6"lp$`JL-k,:b'LBsNM+&?p+PR.K3O*V
]A>NoHp\^8H[O%POMOT"[/6r`!TWfQt#=_o<`MX\,VW7kArN?VQ>20VW%]Aspl[]A`ML(XJ?++N
NRlG-+e"MNt[Z/q3BsWOnVLl.)n(:7'!n?g_9Ru9dtI^2V4-U$h^P4)Ym/[nCG6/f$.dFG89
3N9!2O!:cS@&'.Y8?b+RECA5kqjB:_9K6[nWpMRm-'@10en=L$3]AO%t<-h;=cJ>$#<48m/,d
+,r-6I[ElJO_#Q97gX^4.4Ko+G.;bR7G)^u`L3n]A.HiD)QT<Fd6V4L+f_0^-BDsf_O/>CBjB
5_^FsYtFKZB>`5bo17UjZMLI$GG&]AUI;_@LdD-g170u.K$Y=WYS7<Jb*"Mp$fA0MEm&!(AF;
J('/Ps-e"Mti_sZP5C7dsE!At11ho&c9jVMcql)g7,1Y9'XdbMV+)M?o<[&r[G("K'A5bjKE
m"d<;o9K&[S8,CVjm#rC*4Ml>sIEQ2n`WdKPhHeKt;^EWOC4*j6s=C(TlLN[79"R$uF_2#Yi
&P[VImY<f?"kB]A<B9im1BfSdEXD.t@l;CgIa&Ca_eR*]A,tFiO5S-I3-NFXgEoi%lQ;@X3=".
I#,%$SP&d1<q4/'ebEBAqas]AJpft?jrk,P8fn5ElQIlF;$<Zr4CPre]A\qVgKSpS2>_8I_^fQ
_POJ*SjF$?oWV&rZd?0U0NHGbq=A\j?M6.mJEe,9Mo!^Khq2cRP(-d$O5ZM7*-gpP[Q03p6H
mQtQ<:()0RlXMZFjGOEqj1En6,B:HHe06%ImDnHi4htKPL7$p'`fS=pgZn7"f:.CF`pd>XRT
9=FN#=^'-'2if+R^dG=]AhPQsf"W_c5.m+Q&4AsN%/9S55?=[=UNtZ<+`&)G*C=cGG4ZVKHYh
4G;gdoM'5tIKd,gc6eI]AL93@C%nCJP`d5nF$1#\SbNi"$m<Tst#>=8p.@;',Hu=t7_(2ZcDs
h_,5W#n`'mh0t-'&_F!/@g3iK[mVtmq8W=\^'m\+)A#rE;]A1h[0QaK`$WWKK(^d$HfW]A+IN>
C)T-KJWe.(;Y!$F&@X'(RN-rAS$lr,6[17M6V+c=s5=a,I*4lJRR%`DJd<'hMhf-*`o&I[\m
f'3%-BaG!H8VD99W7P<_.$=Q:ikEa-qlgS%Q5h2[l@.nZ.q]AfReOP,Uu`rQsp8!*WP.1(kc9
dr3mG1>1/^BML8(R:CbiF8Q.qF^_T=*jPdFB7[_8!&ei=G5UFG!(Ue3^.VSOEW2Z=@2+Ks%/
(\fI'qpEem'-\3E$!aOjr,RL*o"kcR]A!-O?8%cin\.g_&Mb[4]ADW$_k[?AAC2C,_FKo0;-,_
"dG]AKjtEH^VLL'5&r^OXi/Kj)i.g5e7\6)Q<T^B:M-E^V$VZ:QGJ?Qnm[8M,#]AgG0OgRF0jj
`=i=WbJQ+e#QZ2Zp^WciNH>%Zl@DIMj[q7U]AOToV.T'dKTV:ZSLHRc`K_PWRcR*r%eAb,k)^
eE/7O!F`tGX)QW6uN:KFc3dW\oLU-qAqU-M5dsV/mf8$;&EN&oCnol#.;]A<1Te61']AE=O*`&
c.E]AA(cqOC,YZr?<WcDoZN:SO4=sB/@4S"b.HiW4&A0]Arir^G3UkB<[lY_.05eBZ;B\_pec1
0hs&G5>CN\*l4N'@-)cD\SReWt]A<7]A]A>\)?u)-n6N*O"2fiBe_XgD$rSVhmTV3gtjm6<N'$t
djRk8'F#??oOR%AT4:1ch[Or:nj>iXqp2q@\.IiZko=t9HqYC;b?6W0AB94nj=;?k@qYt("W
IF".?Tl_adfY%C``D;;\efUf-JR*2L=RGrKHIAJeLF+"CZ>55f6c@.\g8F'@=Ous""LE1-U1
d=nH3:["Tbk]A&8%#`9_KOs,,"pqrW@fK<enNAX'ftBHd#9k6NO6?_f;U"C"f$Q%1E8ZE0%p2
Q^0F:\V`"oN6trZREMH36M#$:il#Uekb2Er;i>Pc3b5U"6J#@T0bbur/3]AY)R7k=SqXa>KNS
%!A`s)YiS5Q5TN50+C.RbjI!c;G2:.*U%7;SV);s*)/!LEX,<+]A<"r'gj\3+H7UDlr$+91Um
PQ,h)//pWqp6Y6Sk(=AAEs35)PE8_g"Wsqq#;$jk*uoTEVda6pd9NORN'K",pWUhXfEku"e)
>`f.h=Q<)7Q",bMJ3bNi90shd@l;W#(KDs!%2MW5o1\Id30%Mi2!N,Q0^EKYm1<XSQgS;KU;
!fg+QPnDSKMGJu+bqQg.c(]A#Re<r\MVeniat2;&P9hDSgl%Kg7u6ca8*i89/8AZ@.G3*cepW
":#N1B5nNc-3ePo4+P/-P6&)'`O$jR%"@<%TH_=dJP]A_=,^k!TJ;>cHKrgg.#1JmNlbK)9m%
//T@+IS!qL<sCr:l)IjS?#"^EM(]A'stRAJeVh9FR?UCi6Qr:p/D<rH^I::%ZhiLO2rb0h=dE
gkC!fCj'RSkursqOWuUAI1",J-0]AnM6\cu,+;Y4SpV7-$^m).ZFWEW^\a9knc/drOaO"R]A8R
G4mcWgJX''!Saca"kBUTV\^1DC&^12=Pe?Zh%S@8uc)rEhE@V=,0r+;DH\s,-eg%3d-iT1;-
%QS/arF#Ph]AD(WKBBV>-On,u5&4m>;rV#96'7^8aOq`i4$?aYi#(tV;fm1CE'c5`dhgrj3)d
to]A%nga/O^t$`p/B=d%;f=3r59=]Atr617l\m-K/N%hLbMG2t0]A!>_Z-)d:&\]A?<;4nhM&:<9
7*H&#EUL5dU:IqfV^aA_,uB!-cWW/m9H(b>nu+JY<G9+h22,JH?)nI*.S?$%a_X&.)/HAXoC
^J1]A3#sN8S:;?q8cB/9DH@AX07F6/W)<"?tY:*(WqC\M+YtRlm'&gM=<9XN1QS>oD1DJ92%m
U:2r#U+sA8"\M/OkA4'[fmP]AR^rpg=p3X\K:&YL*P16LZ`f6;'F8Y:':-c3SDX<CH_N/5)34
k;o%?H%`fc@a+PX-c"9fiqfAH+XhM>i-BteLDf523VDiP?7]A(?ieLZqlJHglb0L$PVWHB<n"
)okddlF`M%1(UE$@_LVA<JcUo-@RL0M<UC$7!J:>8cbR1*OL>GVB6Kr49Y<_pF>hL\""5_%+
rIKL^.PEgps(6/=+s+8CAM4gE@8F?Y**BcN#ODbZ3A`e.sQkGsHch7=.d@;Jl9E9?8N-<:R<
ht2'`YgdW)=o/:K;KNb$*T=X5]AE3*JB]AJUg9<Nu/+ITY$b.>`*G#l9dn6D:lrM(M6_7\WBU(
cN0JJ=0CT%-=,j3KSeaaQf$-*UC8)G=?0Tf7\eSX.@N4Ma`!o&7[L'VG#OX4DZURj-u5$`)F
Y2Ehk<M1apZ<`jl>0_`]A;_nEc8>.V"4?]A]AST(\*p:\+3]AENkGkR:@>Jdq4JU;^ZEYHW<bEVJ
NHGid,dMJ7*<Mf7l#p_X&-liQ\sa-'SDR*a4><Rf\!9A[jGN".5jD8-nA+A>N-6a]AM@8()l3
o9)cIbaA;=rC0s/ph5d'Mon[tG"?HT1`$Ql"R3^/%$QqU&jmY+2@a;@+6EiVif-Agt>Af<^'
N@8u4L(\\Gc=`HtdZK>loa`Tq38BI08QS7L5a0)I@$,X&'e!(]A-SSIPP\@@pmim-_$!t/9kb
aFhcRKjC`dH@PWV<&moF.4)BZE]A_H9sSR('*]AHL1(\Z>X`H@`3;Z#BUHjBF.^L=5hdfQBJMQ
pVet7SgL'EK`oC4<=^2,m70<SlLWnSrO^5fX?j;27Z`WTnd[LCah(///\L\R9TH;Mia--Gem
-?mKj>WQU46%)K6)?MSR2C5pBWLPs#0't)NH)KpG>*,^8M$4\8(Ams?WR9[a>>(`\$Ik(hs6
8Mq?QR!2^`Q'g2W8fYUB=X]AB(:<i)>i-F+cU-T<Kf!-$H)@l2M"abqS`m?(6^P>L;$/$fU\X
/!7[^8:gJFUn.PNlH@SqR]AGuEc"Y=&22X\^$mkMoZH$3*Ej!rYR^]Au@G\]A,cq":tn.(V=Qnf
#P>b)(ftX(!:/qm*s@/;JX>pU[M[DaH':hVefB@dH/3D<UF7[8l?0c'j=`9*V56^16K-!V.T
[_(,gZ1o)0;LhZ`Y^-.[te;tN,gr/;8(+"g=+^$;C,J3)TA\c[ui`DaD+oPtI'k@e:BG"apR
J,DF0HeS$#fP`*R..62CN;Y@"DB+i<T;;NS#_<FK'bi\3G^H-5,JVQ?!c7OgbdSR0sEMW9>O
;ILtEaaIDcn'I`k"V7Q2fOomgB?=BjjMgO?@\JGeNM(!8&hZQksa@r^4gjAkuL3>'qVk4`hW
HV`[^VjNikC+@:p8@bc;@g9nOCM]A<s>"iU1Q7jLn$ihCum8E$.k,*aUn+t@'4%?SpT0$VhEK
HN:\O_^`$@5ZSkk4o,S*Z#H$]A&^Yao@%#>YR2L/UDdtNnS%kd>MpFs/k>Om[h1bgBQ4;4`,3
GDVsUo/FA^$=gG=gnc&NCMh=*W^Mn8X.&gR2IX+u*CJRbL9QW<Hd^6Jte;>GXi'1So,Nj_Kb
kuE$aV,!'6;;oEFiF;;]A`fNs?JRF5CcD3;cCr7@ma<Ime!^)M1)@`u(NTbceBJ\r,[391eR7
h,`(-4H#tG<g5"OEaUuKqA(;380iG3#$9ecXsc/V*WITn)t3%+/(GC%>>+)J$rYIF(;?OlMk
0XWl"\ul!nXAelPW`\fqEgaEghRiE4UCDSl+Nt24U]AK]A@h6.W$*TYQDfUW@d4-=*5$]A,QP\&
15pTEqE_hr?m*BXa9(O6I6g+,Dn\aj0I0Y:6]A\gNck4)8M:S:VZsJmk@o'7^0.P5ap5rM:H<
n)"+0jAM]A3HMQV0d7+k'#>%2<>"+QRLL9qBLN?M#r@=ZMuO'0KTXpWAj9C@g7p_@;EV0Xck%
ifA4:E(k';nKEE/QW?%376j1j>9sIDoDd,Rfe`]ACeKe,.C5QI0oEm$?6A"c%b`L78^(*:":8
nG4>*4?\7Yq<1mK2#Qkk[9SQ(r<")HVtR=8E^YI<=D_M5!47mrc.4I@b;)i['CI)ELXbc$OH
+.(l('QJ?l,ne`MC@.`r5H#Ero@`WYcOEMsWH\7t\9/`MP*fH)MSR0-p5\%d\eaf<lO+N<f#
5DEG(L,\a2$$T]A*^?YKmE=Q\#W@[!8Kb9Gp=>33lYEc/&jM(I;YQsAIEBgS_E+PrX]Ao!Ila/
NF1N:uh:oO"R/ck%+)0+Zi;2$ogR,@o9C$=XNY:L1><q@+`5pI:]A0#[DYi;Z2b<Lod/NuCm1
>^WhU`-t+lo2X3g,2S-W2pDJAeW><Vdc+HoP08g<HR"eKt_#%%KblSD,t8Wp=,8M71mCc`<k
e^55?Ppab?E,gt@P:LKZ<F:GJ`LND,u8knIBTP)]Ak-WYN^/aMt4`3fG\&g`[$CQj?EMkm-A7
nTO1T)g!G/CC\ip4NX_S'e+42fchG]AT_cn68$D'`qD.ZB-_DL;MY]A/Gf92fZ?6#OgrBjIU45
C(AhiU>>%*G'QNuX:(%R?`44)cJ)3:N.1YICN=D8iB4%%!;eQjQHa^2)K"p<\p6Z/e`'C4U!
bi3bZ";k[tUd:-6k6"<+U6qi2d6I,>eZhEYL;_ZHnheWL_ZupkCRY:l.&PH^TIGcNqM`k^SG
NoTEf'Kk$[f[ruf'Vq*+)%IQ=bm4=>EE_9ZG1;#-C\eE@f[Ki/nKMa)16@>:VpsY/`f(&;i/
gfe=H@B9BDp(!FoIglFh,uS='r)+iDV`AG+gT?#7?o6h5Jkm.<0<.Xp,!LAKh;ls?@=(mFBE
ri8PkVgaM86nEA[q]A7ag1eF%;^HeCQCofbJYh;cJY_Eq>dN`&'m/khM*a#OnL0b3K5>*.Yh&
A!Y[<T#)VYc(.B0\kpEKRI"]AJmlQ>\!+?LFonVAk'M7KZRSH<>N3]AJ+L;D;b5qorOrbmA8A>
8A_c,]Aq)$A`I,5FLB]A<[l+I,cj`*=PsQ<WR54jW72LknL>+Q&Kmp_BW_D;.YMV$(s>el7)+#
;i(*,-lBR?bgUT@,I0B4-=Haokn4N3I.3%3(,TcOuGHnR]Aep#I*HHBfgW[1=-4=/>M561hl'
Ok9CDSfTEYBV\mHW#:6NS_iUXdSB\S@(%i",kMLjOYWcIWN+_;if7iH5g=mrPA2`d'[\a2t#
p$(!K6hg!ITd/6%l.<\#N2#AALln^!EW5XUK:DW&#W(l'F5u3DCR^l<KW2SUh)#&W?-0H:0W
8Vu)?<IB.-!tgD=I;]Ar5(>4ljq`dgLXAol,EXO~
]]></IM>
</FineImage>
</Background>
<Alpha alpha="1.0"/>
</Border>
<Background name="ImageBackground" layout="1">
<FineImage fm="png">
<IM>
<![CDATA[D0gIM<;ZRmR5nac#%Pi5@Lstk-A>:A80k/X#n]AWu8qnn=2D]AC@9,fA([,#!/&k+">#$htm+t
>F38@EWH0>DSjf(XX]AkP+fDSF_1ocg,j>cguHID^1+Ib=5B78K7^18_`W5NW=S5!<<d-^a!b
M.NaWQJ5o1L<`Gu\\KfoB3@bU$EJ$/deXF(d9VGW:CP5oX>Wb@JD%H?d<N\/-R61pU0l4-17
R%R#b"be]A,]AToU`jq)%I#SJ?_%i<&;:ZLa1*P:*HM&%R;,[,67K;6iIkR7Mr]A2l8<"`+O)ms
qXAu)EH6;5=QWh'Ln06raO!O>Kd0;Vq'J1j@erVZE:lGIK7e;.3a^n>PLpI_L/goEB.WqeZ&
*(Ohqm!R"8V5BS51#pB"[oI\2din[_m&9#/8g!G,/_i&7_DNKTV%tmO\O,`BhYcGXE]A`gUf2
KP/HOa--D%tX9[$[Gc:Me&)Dc\3iK#gn\MS%YCd_\D[8eM>aE7%N5$[?`fs%hfMJ._Z:r<4J
B$(d$!/]A'Cjc;Vbhmi.8/c5hkPQN_q%pN@#g-nC-(^6&oD!e^8n#?^D*,MRh&AVf59jTg1[l
:<V9/)-E@Th,:+FqTdX.F.Am]ACq?+D4%Tg;m@FnEL1^tP+91!L3j'h$N:IIZg$`%EtFFY@81
\<jHdlur\UK:@9NakT$F#)J\frNGFCPr$)GAMniLo*ngCTIY.s&#^X"hq)?hqbp?e5AC%R+m
B$,]A-;@FMA5N5"'>4g6dReGu_XOW!rqh=0TZ8gr-e^d9aBqJH@:)pX_W,$KKJ6d,HpdL:D,q
i%B1>oXa5-$@&;X8#0e]AYDp]AZC8CejV'(6`ql:?q1M[&a#6^35iQQ_VuhNVfkt1YA8B)GOj'
facU/DPTjui:m;l.$i.;:7bB=N:,8$^&0&ftrR)'(Lt&r?)osXsmgcG`Gkn`@[C&LRC-+t/X
aI&Z<u")^>De!X]AkjLUa:H:1g:$?#q'2A1SlU7>Ke(g8UofXBR_q2.OGp'W,W;/A1Ee#RQgR
]A;8X34mUOrY<jM/HWk_lN*EWWMU%(l9MLrJnM:JYDN8ZPGLX74q]AmUeN_'!?+m>B"[)q=bg?
h$D`$T+K3FKL0%-X\KqdO!V"&J-rKC>OG<t8KiSsbC1?j)0J>$SF0A95mLf,Xor`=1!J'#fE
E+Xgi,^:>EFl),o(#`3`-b2g]AQm('<VQlTOn@)C(#6;$T!Q10HR1c&=LbAD"Gm"HK%[7\=u>
u2!M3hN[LN!.5/55%YT-j7]A8;S.7&?7nM$m902(jslm2:fMi0^c\L^O>XW+pWg#9Z0S7aXhX
BJe9LDc*P<3inPB_t=I*<kj;)9MWUGH=="CsCHEb9*Y@c=??drGJa$(1)]Alf>oOJYT>'!:RH
=Ga.*$OUT-56#0ULFOa%l#\&PV<Anat`ZXB2:j:QG*hYaogoRcAVCnqWEIaG5[FsLPH!Su;r
AA\?=j"#;UlKAbGW!ttPpDm8;hh@G:#8>$olXgY>=T1]A=EPtftM\f&phk$c(DN%+Rn=&:3'S
\*k;J!)--ZDgqJolqtT_h4]A<NrH7\kkmC-I;2"lF'7\f,Zb;+E9sLS#&hnSR+F8p0>7H"#DI
n&F%mHC@`CM\?WDtGDR0P_'D<oo7n,GJ]ADF,"!'Ye\id.ZSG:LNG9:UMoP^2>/PY*c?((i2S
-ou>I\@AHbp'O>:4rP35bVgGPr(RaTieCk]A"2`J3p8R'W&gML\DD"fCnr#"(S0oG`2i5W!u$
43('B0>3d71tXg\*;2O)JQRlOJ?@EdT,_HQQhT!=rG[<n_bL@/2L]A-p7j0hk^]AYtH1i-\gut
niba-J!9'$eV+5R-qp#K]AY=QBVd%,*=_O$n^^"a<2HHND3=oc6DPCGeJ=+td&GGM9^/&q/da
,e!g>@B]AWDr9ne/qfZ0m[e6Ds#H-ICSNXOeJ3Ai+[`869lU<V';@N`I)&0jlq@0S'I;$^Jsk
[C?MG>ShBgOS0Q@o<0`h8n8G7n=@_$hLDbLJ=9@5o_)Q>O(#$sl_7Le2gLf(b=(g]Aq'SC2)"
"Zpc%9R(cI@,Z-h%S!)I+F9;_QO7SI0gN%c?&8A:s^MA`&>O-YOIe_Cn4@k$5=.Ig[]A`KL%s
<gCh`$NR_uZ-io5#[OXAcr]Aqhr%%!V#o4=a"sP<%$"(3qsgI%[4#Z[n,npgSm=%hTd/a>s>_
oS7*r3.P\3,'K*!13fT_d=]ABLhp5YY:,H0a`QHGhTbFtK]A[NeB*$n8f5a[bSB',Wrf-hC7gX
chTjEh_)#7u/if`#:07M8HRHQ[WIl7Q4YPXO71G@m&+:#DcpMc^bK!*c!c!gKe'7pNc&8Y=R
41bjt0hVIaNbIVohqS'`9\GF0n6D`+;[=i?X-Fo0aJk.(P5hob(g9$,<@*;cu;)2R<DVJF\U
8$\pn3,<ZX7=ETj]Akg$gCjeZKJJ$]A$_4U+e:?jc-Zh6'>*)G&"ITA2S$%#bJ2JTA)rA^p&sl
bZXYdNeRg'43k6_$R3:_d4/B:_G^X.E7eTl0CidH&T1qHsH-I(VnGfa@PmL:2^DA?P>SSOod
qFf>@98:r77tAM>j'l\P<>(JL-d9n/G3dCdh\/nGF"!j`^l/)u_?p:ndh903:$Ji@/3+.%EZ
3"UD%']An3"-9=Kg.k^2K;ta1Y)h4^j)X?DCA6"@@76@pj2VrhGu)?D"/OfOGPQ[F"G05EQks
E1N!;=l'$[d(F$)Ud%$KK]A4!\n"u_"AmK.Kn?f[nU\>2A$B@YQ@!2>k/\;r%Z)\0CAkT4B+-
13uHH/=\o='9Ou<!X*f'@`qs&OBD@5Ru+t#pUPh"+Cg&OXG]AKRV\!7U6hJf1duKX-K3Bo;qY
\n9t'gn3ibr<>t3O3+s@/G9e?!i[&;l.9hC_OLTC^Wdl0$*g5$s3ZGLhf4R2/=4R-;;a-04^
r4&#N#q)iIAf[$<5Erp[O@#LHASaat$NT8ZeF>t,c?j&]Afd.GGE*tc4lYA8Q>;s8%ijXep>%
kbQr3`gm=Kk]Aa#"0UTWb7dZ#oEY=@RA/c1eLMB!_;-@BJ_N3;DE7n?trt=@[3@<cQAGu+iBT
ChAm:4]At9B`f\P*:Is!g@4e/d&>>3Md]Ab?.$Oj=o<Sc&mLH9Ll;EXhs-\`W^l(Gd/iIehB.J
U#hWgrr\tipoS:RiTFW.1eJJO7"leF+9k[[8D$U(A1[e;6s-`bR_XKj"j;8b9*):Fo)@gkW@
)bGe%op%&UH)^73EFIK]A^gg_+/)nJ$7;kcDJi;eWW7jD@tU6+\>&Du:g_!5s(2MTqUNgm`eg
g0uh,j*,SGar*eU)?goJKf:XE=%4S=aFd+`g@Hj.8]A9!O=JU;mb;nFFgWJG#!fa_BJH]A^n)p
aU(MYi^hp8qYnhp\un_JhK)Z1.HESL]AII+cM>"AHGL7jiogd^nnC:?,;6.>WM^LD2)^kO]AfM
'8uRdoO)(<);VmUjnK^g*@V]ANXVrFLnJrrnfStmVqC+sPCdO/_m%6iFqoQjm)rS')8&W)Uj]A
OF#!kpR1;MZ#$>X5&R\5r*fQZG8*+^7hHHgN"B2X>>,:c5\QN-uC+30^169/9Ps-Lhg7,gpu
7IKbYCA2fi:fUG-(?@\G)lUU&gP(o.)S\_XYc!7ULM',?i-@g`oV*C!,2l5426gQodX:V3uq
V4:p=V)QrK4D`8"<#28`^!H'M!)@-;O<>Fq2SmfdXGnL$*shbHZ+aq:jHE7=,N&;4:ZmBY_%
[o@'ZL6ainc$l,]A@>gUs'h^QSiLP#6+(P^3EVFM99^B2;,DZ?SXB=?>?MB5#%[pdb#$a&t!a
dU\ZSfZ">^b`iW@J=WB#Fs4I1<nqe$lT=@:$GO!t83`f/qTiWDY9tbjGLbk".'C-mVH1<ThC
q-Md,Y2Q\P53pB-7@O=G+8>]A;!;3e4n_t).<.RFNit;R.Ha=n^%,2:fTG*HS4s)?GCm50]A^+
[qk?Th9K]A1QLUqFZJqobUj,L6QQ;"GB2G;XMcp[Y]A>=f_enj6epi+\@u:F#3o*G.#NPKAp9+
1Vl.V2'i?V'K4ok?'2t]AoQ0Og9Cc19!s$W\gr;)oS@?CC+;6B1I'OO&ji*.QT$,CJ^P<&ACL
eW"h*$om680,dW0mn.aL@gW=1[>8%UuI:C:nA`GjS!;Umh"RC6.DRr*\+G1"_u`27SS#!%$L
,64O48brV1baBo8(<,h:en]At.V]AK@C4#0^%AD/paC!s@Jj=7!0TUFbq.ReYbal!=B&oO\^"&
]AZ6.o/"pLph<$_!5M2M<77Hppplh.&##okgcNO\r^0^@?!o&gNi=2rVX6o[@^F#q9hHI[_"[
<\L>1+0CUTQiEOq*CDlpG]A!J%VpG"U3/84F@0"T+P5?q^GaiVT1S`kn(-M.QCYGlS#a'P-OI
q)nIdQnJ.`$P(gbZ/UfSa-l3e07"fU/[3&GKluTg,Bj1%5p.6s%n$WJbt-H\ei5E,M_T<QPq
)6A&4KJS[mGMQ$gek6TYSV^0ft+l]A3>c8ZVG(//l6"lp$`JL-k,:b'LBsNM+&?p+PR.K3O*V
]A>NoHp\^8H[O%POMOT"[/6r`!TWfQt#=_o<`MX\,VW7kArN?VQ>20VW%]Aspl[]A`ML(XJ?++N
NRlG-+e"MNt[Z/q3BsWOnVLl.)n(:7'!n?g_9Ru9dtI^2V4-U$h^P4)Ym/[nCG6/f$.dFG89
3N9!2O!:cS@&'.Y8?b+RECA5kqjB:_9K6[nWpMRm-'@10en=L$3]AO%t<-h;=cJ>$#<48m/,d
+,r-6I[ElJO_#Q97gX^4.4Ko+G.;bR7G)^u`L3n]A.HiD)QT<Fd6V4L+f_0^-BDsf_O/>CBjB
5_^FsYtFKZB>`5bo17UjZMLI$GG&]AUI;_@LdD-g170u.K$Y=WYS7<Jb*"Mp$fA0MEm&!(AF;
J('/Ps-e"Mti_sZP5C7dsE!At11ho&c9jVMcql)g7,1Y9'XdbMV+)M?o<[&r[G("K'A5bjKE
m"d<;o9K&[S8,CVjm#rC*4Ml>sIEQ2n`WdKPhHeKt;^EWOC4*j6s=C(TlLN[79"R$uF_2#Yi
&P[VImY<f?"kB]A<B9im1BfSdEXD.t@l;CgIa&Ca_eR*]A,tFiO5S-I3-NFXgEoi%lQ;@X3=".
I#,%$SP&d1<q4/'ebEBAqas]AJpft?jrk,P8fn5ElQIlF;$<Zr4CPre]A\qVgKSpS2>_8I_^fQ
_POJ*SjF$?oWV&rZd?0U0NHGbq=A\j?M6.mJEe,9Mo!^Khq2cRP(-d$O5ZM7*-gpP[Q03p6H
mQtQ<:()0RlXMZFjGOEqj1En6,B:HHe06%ImDnHi4htKPL7$p'`fS=pgZn7"f:.CF`pd>XRT
9=FN#=^'-'2if+R^dG=]AhPQsf"W_c5.m+Q&4AsN%/9S55?=[=UNtZ<+`&)G*C=cGG4ZVKHYh
4G;gdoM'5tIKd,gc6eI]AL93@C%nCJP`d5nF$1#\SbNi"$m<Tst#>=8p.@;',Hu=t7_(2ZcDs
h_,5W#n`'mh0t-'&_F!/@g3iK[mVtmq8W=\^'m\+)A#rE;]A1h[0QaK`$WWKK(^d$HfW]A+IN>
C)T-KJWe.(;Y!$F&@X'(RN-rAS$lr,6[17M6V+c=s5=a,I*4lJRR%`DJd<'hMhf-*`o&I[\m
f'3%-BaG!H8VD99W7P<_.$=Q:ikEa-qlgS%Q5h2[l@.nZ.q]AfReOP,Uu`rQsp8!*WP.1(kc9
dr3mG1>1/^BML8(R:CbiF8Q.qF^_T=*jPdFB7[_8!&ei=G5UFG!(Ue3^.VSOEW2Z=@2+Ks%/
(\fI'qpEem'-\3E$!aOjr,RL*o"kcR]A!-O?8%cin\.g_&Mb[4]ADW$_k[?AAC2C,_FKo0;-,_
"dG]AKjtEH^VLL'5&r^OXi/Kj)i.g5e7\6)Q<T^B:M-E^V$VZ:QGJ?Qnm[8M,#]AgG0OgRF0jj
`=i=WbJQ+e#QZ2Zp^WciNH>%Zl@DIMj[q7U]AOToV.T'dKTV:ZSLHRc`K_PWRcR*r%eAb,k)^
eE/7O!F`tGX)QW6uN:KFc3dW\oLU-qAqU-M5dsV/mf8$;&EN&oCnol#.;]A<1Te61']AE=O*`&
c.E]AA(cqOC,YZr?<WcDoZN:SO4=sB/@4S"b.HiW4&A0]Arir^G3UkB<[lY_.05eBZ;B\_pec1
0hs&G5>CN\*l4N'@-)cD\SReWt]A<7]A]A>\)?u)-n6N*O"2fiBe_XgD$rSVhmTV3gtjm6<N'$t
djRk8'F#??oOR%AT4:1ch[Or:nj>iXqp2q@\.IiZko=t9HqYC;b?6W0AB94nj=;?k@qYt("W
IF".?Tl_adfY%C``D;;\efUf-JR*2L=RGrKHIAJeLF+"CZ>55f6c@.\g8F'@=Ous""LE1-U1
d=nH3:["Tbk]A&8%#`9_KOs,,"pqrW@fK<enNAX'ftBHd#9k6NO6?_f;U"C"f$Q%1E8ZE0%p2
Q^0F:\V`"oN6trZREMH36M#$:il#Uekb2Er;i>Pc3b5U"6J#@T0bbur/3]AY)R7k=SqXa>KNS
%!A`s)YiS5Q5TN50+C.RbjI!c;G2:.*U%7;SV);s*)/!LEX,<+]A<"r'gj\3+H7UDlr$+91Um
PQ,h)//pWqp6Y6Sk(=AAEs35)PE8_g"Wsqq#;$jk*uoTEVda6pd9NORN'K",pWUhXfEku"e)
>`f.h=Q<)7Q",bMJ3bNi90shd@l;W#(KDs!%2MW5o1\Id30%Mi2!N,Q0^EKYm1<XSQgS;KU;
!fg+QPnDSKMGJu+bqQg.c(]A#Re<r\MVeniat2;&P9hDSgl%Kg7u6ca8*i89/8AZ@.G3*cepW
":#N1B5nNc-3ePo4+P/-P6&)'`O$jR%"@<%TH_=dJP]A_=,^k!TJ;>cHKrgg.#1JmNlbK)9m%
//T@+IS!qL<sCr:l)IjS?#"^EM(]A'stRAJeVh9FR?UCi6Qr:p/D<rH^I::%ZhiLO2rb0h=dE
gkC!fCj'RSkursqOWuUAI1",J-0]AnM6\cu,+;Y4SpV7-$^m).ZFWEW^\a9knc/drOaO"R]A8R
G4mcWgJX''!Saca"kBUTV\^1DC&^12=Pe?Zh%S@8uc)rEhE@V=,0r+;DH\s,-eg%3d-iT1;-
%QS/arF#Ph]AD(WKBBV>-On,u5&4m>;rV#96'7^8aOq`i4$?aYi#(tV;fm1CE'c5`dhgrj3)d
to]A%nga/O^t$`p/B=d%;f=3r59=]Atr617l\m-K/N%hLbMG2t0]A!>_Z-)d:&\]A?<;4nhM&:<9
7*H&#EUL5dU:IqfV^aA_,uB!-cWW/m9H(b>nu+JY<G9+h22,JH?)nI*.S?$%a_X&.)/HAXoC
^J1]A3#sN8S:;?q8cB/9DH@AX07F6/W)<"?tY:*(WqC\M+YtRlm'&gM=<9XN1QS>oD1DJ92%m
U:2r#U+sA8"\M/OkA4'[fmP]AR^rpg=p3X\K:&YL*P16LZ`f6;'F8Y:':-c3SDX<CH_N/5)34
k;o%?H%`fc@a+PX-c"9fiqfAH+XhM>i-BteLDf523VDiP?7]A(?ieLZqlJHglb0L$PVWHB<n"
)okddlF`M%1(UE$@_LVA<JcUo-@RL0M<UC$7!J:>8cbR1*OL>GVB6Kr49Y<_pF>hL\""5_%+
rIKL^.PEgps(6/=+s+8CAM4gE@8F?Y**BcN#ODbZ3A`e.sQkGsHch7=.d@;Jl9E9?8N-<:R<
ht2'`YgdW)=o/:K;KNb$*T=X5]AE3*JB]AJUg9<Nu/+ITY$b.>`*G#l9dn6D:lrM(M6_7\WBU(
cN0JJ=0CT%-=,j3KSeaaQf$-*UC8)G=?0Tf7\eSX.@N4Ma`!o&7[L'VG#OX4DZURj-u5$`)F
Y2Ehk<M1apZ<`jl>0_`]A;_nEc8>.V"4?]A]AST(\*p:\+3]AENkGkR:@>Jdq4JU;^ZEYHW<bEVJ
NHGid,dMJ7*<Mf7l#p_X&-liQ\sa-'SDR*a4><Rf\!9A[jGN".5jD8-nA+A>N-6a]AM@8()l3
o9)cIbaA;=rC0s/ph5d'Mon[tG"?HT1`$Ql"R3^/%$QqU&jmY+2@a;@+6EiVif-Agt>Af<^'
N@8u4L(\\Gc=`HtdZK>loa`Tq38BI08QS7L5a0)I@$,X&'e!(]A-SSIPP\@@pmim-_$!t/9kb
aFhcRKjC`dH@PWV<&moF.4)BZE]A_H9sSR('*]AHL1(\Z>X`H@`3;Z#BUHjBF.^L=5hdfQBJMQ
pVet7SgL'EK`oC4<=^2,m70<SlLWnSrO^5fX?j;27Z`WTnd[LCah(///\L\R9TH;Mia--Gem
-?mKj>WQU46%)K6)?MSR2C5pBWLPs#0't)NH)KpG>*,^8M$4\8(Ams?WR9[a>>(`\$Ik(hs6
8Mq?QR!2^`Q'g2W8fYUB=X]AB(:<i)>i-F+cU-T<Kf!-$H)@l2M"abqS`m?(6^P>L;$/$fU\X
/!7[^8:gJFUn.PNlH@SqR]AGuEc"Y=&22X\^$mkMoZH$3*Ej!rYR^]Au@G\]A,cq":tn.(V=Qnf
#P>b)(ftX(!:/qm*s@/;JX>pU[M[DaH':hVefB@dH/3D<UF7[8l?0c'j=`9*V56^16K-!V.T
[_(,gZ1o)0;LhZ`Y^-.[te;tN,gr/;8(+"g=+^$;C,J3)TA\c[ui`DaD+oPtI'k@e:BG"apR
J,DF0HeS$#fP`*R..62CN;Y@"DB+i<T;;NS#_<FK'bi\3G^H-5,JVQ?!c7OgbdSR0sEMW9>O
;ILtEaaIDcn'I`k"V7Q2fOomgB?=BjjMgO?@\JGeNM(!8&hZQksa@r^4gjAkuL3>'qVk4`hW
HV`[^VjNikC+@:p8@bc;@g9nOCM]A<s>"iU1Q7jLn$ihCum8E$.k,*aUn+t@'4%?SpT0$VhEK
HN:\O_^`$@5ZSkk4o,S*Z#H$]A&^Yao@%#>YR2L/UDdtNnS%kd>MpFs/k>Om[h1bgBQ4;4`,3
GDVsUo/FA^$=gG=gnc&NCMh=*W^Mn8X.&gR2IX+u*CJRbL9QW<Hd^6Jte;>GXi'1So,Nj_Kb
kuE$aV,!'6;;oEFiF;;]A`fNs?JRF5CcD3;cCr7@ma<Ime!^)M1)@`u(NTbceBJ\r,[391eR7
h,`(-4H#tG<g5"OEaUuKqA(;380iG3#$9ecXsc/V*WITn)t3%+/(GC%>>+)J$rYIF(;?OlMk
0XWl"\ul!nXAelPW`\fqEgaEghRiE4UCDSl+Nt24U]AK]A@h6.W$*TYQDfUW@d4-=*5$]A,QP\&
15pTEqE_hr?m*BXa9(O6I6g+,Dn\aj0I0Y:6]A\gNck4)8M:S:VZsJmk@o'7^0.P5ap5rM:H<
n)"+0jAM]A3HMQV0d7+k'#>%2<>"+QRLL9qBLN?M#r@=ZMuO'0KTXpWAj9C@g7p_@;EV0Xck%
ifA4:E(k';nKEE/QW?%376j1j>9sIDoDd,Rfe`]ACeKe,.C5QI0oEm$?6A"c%b`L78^(*:":8
nG4>*4?\7Yq<1mK2#Qkk[9SQ(r<")HVtR=8E^YI<=D_M5!47mrc.4I@b;)i['CI)ELXbc$OH
+.(l('QJ?l,ne`MC@.`r5H#Ero@`WYcOEMsWH\7t\9/`MP*fH)MSR0-p5\%d\eaf<lO+N<f#
5DEG(L,\a2$$T]A*^?YKmE=Q\#W@[!8Kb9Gp=>33lYEc/&jM(I;YQsAIEBgS_E+PrX]Ao!Ila/
NF1N:uh:oO"R/ck%+)0+Zi;2$ogR,@o9C$=XNY:L1><q@+`5pI:]A0#[DYi;Z2b<Lod/NuCm1
>^WhU`-t+lo2X3g,2S-W2pDJAeW><Vdc+HoP08g<HR"eKt_#%%KblSD,t8Wp=,8M71mCc`<k
e^55?Ppab?E,gt@P:LKZ<F:GJ`LND,u8knIBTP)]Ak-WYN^/aMt4`3fG\&g`[$CQj?EMkm-A7
nTO1T)g!G/CC\ip4NX_S'e+42fchG]AT_cn68$D'`qD.ZB-_DL;MY]A/Gf92fZ?6#OgrBjIU45
C(AhiU>>%*G'QNuX:(%R?`44)cJ)3:N.1YICN=D8iB4%%!;eQjQHa^2)K"p<\p6Z/e`'C4U!
bi3bZ";k[tUd:-6k6"<+U6qi2d6I,>eZhEYL;_ZHnheWL_ZupkCRY:l.&PH^TIGcNqM`k^SG
NoTEf'Kk$[f[ruf'Vq*+)%IQ=bm4=>EE_9ZG1;#-C\eE@f[Ki/nKMa)16@>:VpsY/`f(&;i/
gfe=H@B9BDp(!FoIglFh,uS='r)+iDV`AG+gT?#7?o6h5Jkm.<0<.Xp,!LAKh;ls?@=(mFBE
ri8PkVgaM86nEA[q]A7ag1eF%;^HeCQCofbJYh;cJY_Eq>dN`&'m/khM*a#OnL0b3K5>*.Yh&
A!Y[<T#)VYc(.B0\kpEKRI"]AJmlQ>\!+?LFonVAk'M7KZRSH<>N3]AJ+L;D;b5qorOrbmA8A>
8A_c,]Aq)$A`I,5FLB]A<[l+I,cj`*=PsQ<WR54jW72LknL>+Q&Kmp_BW_D;.YMV$(s>el7)+#
;i(*,-lBR?bgUT@,I0B4-=Haokn4N3I.3%3(,TcOuGHnR]Aep#I*HHBfgW[1=-4=/>M561hl'
Ok9CDSfTEYBV\mHW#:6NS_iUXdSB\S@(%i",kMLjOYWcIWN+_;if7iH5g=mrPA2`d'[\a2t#
p$(!K6hg!ITd/6%l.<\#N2#AALln^!EW5XUK:DW&#W(l'F5u3DCR^l<KW2SUh)#&W?-0H:0W
8Vu)?<IB.-!tgD=I;]Ar5(>4ljq`dgLXAol,EXO~
]]></IM>
</FineImage>
</Background>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=now()]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-65536"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;P@p?a'!Tbu_c1uNY)r8q=.(*k0O%"$+XGsPG,ae]Ah6e8=\TtX>`Y!bo+uJ@qSK<")+h
F6c<.s1<Pj)#$%MjdlLu#%i*"-*f"Vh["+:0;=OpbW7?a=%Oc-1'N?hOU4m4S4PF$B0W]Afbc
Pq>HoJH/HqTrSsc6B:f*lV\'&WB&-[,ru"+3'aR/)\+rg^J!n&lcSGjtmP!1orRopIT<K2R$
C=oqj7JV3RkrA:hRRq!#QC>oJ%DiV(&,_8*I7nfK,),QFftp$Ec^:/s(C>j=2V5U[8kiYZQ3
LpfZP]AOS$c[iiTA)fgse,DiY>)<g]AUW&VQT@/UHtgsF#%[W6fp(42=4sYNU!RUDf=Ak_PO#L
[-k,Hrg,3_V"'=e`MWYn^n2]AE#M("KV!<G'iUPqtHl#\>Y]Ai_eBi/S'+[_')o\5ZDGt^)_LF
F!NfW4&k(3NoqU8]A7cjLB8m<cd1S?M.HY2k+*&jX!Lm%`-4P0)r>k4]APjX=)seb<jRgJInoQ
g7_AVHrC`<.NS\&,5B,Cjgn>ADV=DmF2^\;7-K>J]AUPlWE?T9QFL9Sp0<.eI&>Glh#a4-/_F
47B;.Bfc#I.cX<m^o>]AIG0fY]A_f.1f6$0i3PL^0bmP3\g+?K2W&Bu'iRs!Gb*d?N=o+@47?g
OG]A=pY`lB'$l:O@fnqlIpF5OMM@!`bfcl;N)`m)gh_,sgER<>YJp?%\*$('oE=IG9FF+&k$1
U%1lFRNRMi'UkY2$WM6XM>?mML9uio*Ek?;:OCaKaMHrR(?#Y$p&&:VkQYonpP7fsUGPcXH\
ErGj=)FXL58p`c,b01Kn>!i575^EanX.Gg)"`Z,_V7$PhR]A4F))("ffat'<F;3pSL:%#4*#T
Shq92Y?/+T9\m!N3a[`YY/_6'MUh*\a$lEQfG0@nPqmk2h6MlCi&8jhimuf1`U>$]AVUU;^`W
(=\`WG'*1ibMIr,ijX0o2F9HPRb*L_hu:;]Auh2*N/lmMS/3;;.2GE-<q"./)dh#C,^YCG&98
0E,Br*taXr)Z/%LD:P,,iLS4()\:Pcc3?oW5C.cV2^<Zu0u3gupE=_%).b>H!?b-hKeZe9]A1
j]ApU&l,a7%kd9^;nu[h[Gu[osMn"1,r8Pf,ndq_nfZk`T6[n@jL:fJ?/lk2c@u&4,Y-]A\)'R
kV(ar8LaO-!u>Sre7h1W]AR7`H3[qgLsrYL[tK!#>%bg[2jO'\&UbZp97g8[,(c-.>'6@3#(W
cLPj%)_OeF0^OGtI;f\k:<qXj@l+=uB1YA7:r]AW"bJ]AR^;Domc+%(_ABecNp&T`DW'jA3I/A
^[0W35lM,H8p,5?6QCe*?FNcl=(n@[eGGlrX`o@32Rlk8"t@7MhL*2i3nS9%2Pth7'<.=YK\
3CO>niLRkQ9uq/?PkBgl(<'7QF2at&"%=h5oXR!-oXPS5)K0392MC4"PI_cH$]A:kXkIP4W5P
0#ZY^RTO=2Hoq?C[UQ=Q`,F3J8Yi,,nsmomktZB]A)V>Zjr]A3KZ30rr$KZ#lj=Q2@8.17"d"c
foL'@H`ODD9'C:oek^6LH%b7>-3WSAJ')FEAU%fB.,>iCf5^@0kF/aU*/eb:*`_ebS`KTSIa
<%\B,4%/D#NB%_m&I1Cp#;_tSpQ8SPX'Ru\&Z/%#Qpu^PUem.K?If5j[-d-%=Z!^.K^MROWM
M32Ddfdk_iY@EqI3?ja@?U(#(l/=d`GbeEOW*)5d5Mf]Aa,Z^NRG9oeE>Ygqfh?*;Mn5%jSlD
7&=`Vr.,!M<lV&cR4&;:aI`f!<I]A56NiX2:=Zad2W3A49JW++!XF!s_NNd.Ack=`YiZX0EGk
W]Ad^0gDd6qki`&oU*=!9Cqh%22s8d\1OO\%5\E:9L)bR4\_/I,DVl`@7U5E$X3/1I&8ZPDrW
u0U#CnL%:pe9sE8XJ:7^k'W-(57t$JD-rE3!8Gf3bKU"^?H[3!s4tG7QV09r!ik<=[6boS<O
_l0VY0]A+0qE<&BTBKTD(b)5)\al5Eb>-?:l%YG2/CIWsZi*Q:n`,dKB*:,k!QJ]AFr[1FL)(#
(/Lkmpo5OJ=rnT'iQ^Z?-n7N16M3X#lW'@7R]An5N>dd]A_J!(skV:PWWD&gbXM\;&_+"e.-Zk
:KLeC5TYs)?Z8_1i6TTkmL7_L':Lg6SiO*m'W8$t"%qVb8d>Kr:PN\aMf=!3"YPIL;2M<f8A
lXpfL%1c,U!:'-s]AV=B\AB\`gdYE:^q.?2!,8Jet)WfED$SibKl>eL@q`^*uegFB!LgLh?Y&
QRn0=94#%c&-&AgOknrun/#/ein/B#2[;OH$6<AqdOO6b7k$WOd5>,7_/tE'D2)KrsN$'nZ!
tr9Ob+A9cYW(h%Gjb#(9]Am<0CU686:ejLS.?hVY-"fDl;Bic5/28hLmo-e]AS3VIY8*`^UAcW
s1IUHgK%VG)E(SY[I`:R6R60g\2\)Wk(/(lWCM-(-di;Lu3-A!pS9)b4h"]ADtu:")A>dj;)O
uG:o*j0jV6201aR-Ts+Iq]A7:OFV_kNKkH03u$Hq.Nc1`.KI%n2o]Ac86F*,LbF([7Y%)3"7\R
IeXT.TB:B:R_:tFghQ-+hD=HH0T,+"fmW=P^oA219[0fWD*7MRmJAMa-Dc\`0bEiGJQ=8>#L
0Wd>[i$8N/o4H$fn#=>h4$Sog*+61\[Z]A"OVlrC4I<JoOK/A";\j":ar[$_[;,5EMtX!Scl/
j#?U,SX'pm#_NA'u0L\.(U.u78(\,3pp`hG.H=hn7F;!#8QDk?$JHn,7MI1`kjj>G+203rSa
Mq%5NF@IY^)MJ60Ri=mfR7?LAlPh/O:9b1\NC]AsS.>rXM4j*]A*2UhZEtQe4$`#7H4Ei\6KB]A
&=kEL3lPW5=!`Po$u))6tK/^C<g&)bg7Y`*mb@OVJIj_-Md--;Ys?lUUar1SLAN=*n!FL84m
2Q,JSB.q-3Yf%\bE%#T?csku0=BoF%-)=[ul,26ZV3KRQZ!cU0fBe5eQp$T<o41bD%Z"XAW`
,DO*&10!S\id-"^3"3"W*f]A^`166+qrt<5g&aEDO\0HdM)8?_nGl_W)Ndt!g,X@9V\4QKr7-
M/dX@IF(Git?mT':29R[Y3L0Xsb#HQ_QGZW]AnX+nN[gOE.*oK(<:U]A1pN#oSMD6AK*p(I[a%
:''.GM-4t3+G5trXQ"d.+3p+/sm2o,IkIr"J%j`!^2OR(Sb?7;lti"BfZl<]A_45s=qNm+Z9.
LLS/+o8(5IK+Y#%^ue?GIIrUp6GBd<PXd*"*mU_rV@JEpCQ%6Uo=Zl4E*TBVONLB!NUc/i2?
$m^?4bqngX/(+8:.FIpn:b7APp;$AXBLu:XV'.Scb%QC$g)#Fe9:8;(XqH)62p^(PXQ?Ym3s
G41?,IT;p:8q,e*A5&1-ls[V`Vr*@,MmKOC[RiVK8hrnn%mBbs2N!*'1**$40eQ1t(<^M]Abh
5;YM"1Y]A(0NPCk'$R-5se!8&'h`\Z9".d.>68i6J#\Y*nfJNEG]AXLQ1u:r5t+"o*OtoX6D`'
ka%iU6\J$>!5pMd2tl'EI@:Z'+dS*kKV#13`t@]A?AWEf/Ipup5mE4g6I;Ge#K^uXRc,-jmI.
'CZ[?=3=p41CE\LK2G3T<n?Cq#?3kSjDl^=9aIFLH8%t:6aO/TI.e:^=2Xu"5[C;_!KA4f)i
'GA[Xi/h"?b96TT`Z!AAVU(@CeS(2"YQL0/34,k1hTXcL'BRLgoljcB?#If.#G)#Lguu_5Ja
NA[_$pY=L9b5r\+-\?#t/@ZMPut/k&&%B$be\jNZ%U:7+a:5MM>$0!)E"N'me`lRj'Y?84+M
e$VM=/PLoHkWj8uXLgLiR46g.,SX:60DG"7iKKr9n!\<ofg_+9lhL#PuauoG'f]A=:!n#G4(Z
$NX4lncZX'Bdg/l1H#oQMR),0=$s^Tn+X@F\tM2>+X<4k06Y\2Nn_rI9*%l-4Gmn03dq\eSF
aH?irkPfbTSo':&O3,@rH$Y>M/?`2d96>)WLAj#G,fEK#-8rSh(IEI*%p'W.aZ5X*J1L/pQ1
eb&2`#Lj7#!sNU#(J/gW_sf+f$9D",<sLg(Z&qm68X.E-J_sc`)2p.g]AFW2WV[U_RjsaD$^q
4@[:0blKLRUqNok3j)551p%/3f#8/H9hVo:I!d^"ZMtB'0\k]AQ!8/rI$osqXmT"Ll[=Bq5ct
.PH"jsSd>3]Af2Asg_XPGSE3m@</q=3h]AA1?^JuQU#"2^Mm5]Aq17#tiu)Y->EtXWI^9FM/C3o
l9R<=GOSd#iQY"Ab>?b3VZdrM^M-?H-4SjB>CoID6,s)*\bBaSKN]Aq%Yb33m7=AL#TRqC]AFf
geQI:\cg(C]A@2E-a>*JV;/W%>&OX\.6[)ef3DgF('Qh"M9]A66nd;_4^"]AJ"ma+W;VRGAB78g
ZP7N^$^DHP<+>K%N*Zo[@8;+t;O.aM:_@%e^(0h3$<5a^Bgd!7!6g#'+MtlS)AC#CB5tK9N\
,FsPF><UpmL>lN,h36%[*J(DbS'Qj7MrY-pB`eU[E0*-i!QeGsGb3;ok?#l>SNf4SL6>gBC[
:^'Se3hc]AJ$f-c>`k\(P>Z2K:hiP^7MTj`Q>j[@nkB!(#.&G?o"p:L;f8q3@BXI?iZTKfo>p
>e]Ah=CpdAU*$fd-R+N$@<N,6+(frKQ`N%D2-2q7/Xq%8@H@=n?q$W=Us#rIVHC4@CTk`+2^=
B`!NO,#kA0F9=p\?U6m$6ao[ss:aRIjW\Bgp!NdGeAe"9f#ZapZO&1KeYb#MH[fHs^NG'RZ.
CQB@bWlnc4Dkt&ON8tB.Z(KKPLFV#kkB.XYH@bNj7;3f:eIh,V%;p_kfXYAI8\+;0h8cCs1n
,E7."6>r"=AFAPKPGia$:`IE)Vm=G2n2")#^U^?CNJ?3CI/XHh5H>b@XEWPO!eHr1c"Cj5=#
MH(4&<5'n(?h]AcJk/OelC5cIf07L\N)%W#J=`,\"_njBJ%2R?7U)J&GfQs7_P<T^eO4FRh1G
iO,2\6/obUsS^/a\5="#^@FLg-DJ9/V76V*)F+`"YP0rW?AqMs-==.@H?W*n)tO:F)q^UIb)
3CBl1cRgHPEd~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="800" y="76" width="346" height="222"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<Listener event="afterinit">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[setTimeout(function() {
$("div[widgetname=REPORT3_C_C]A").find("#frozen-center").css('overflow-x', 'hidden'); 
$("div[widgetname=REPORT3_C_C]A").find("#frozen-center").css('overflow-y', 'hidden');
$("div[widgetname=REPORT3_C_C]A").find("#frozen-north").css('overflow-x', 'hidden');
$("div[widgetname=REPORT3_C_C]A").find("#frozen-north").css('overflow-y', 'hidden');
$("div[widgetname=REPORT3_C_C]A").find(".reportContent").css('overflow-y', 'hidden');
$("div[widgetname=REPORT3_C_C]A").find(".reportContent").css('overflow-x', 'hidden');
}, 500);
window.flag = true;
setTimeout(function() {
$("#frozen-center").mouseover(function() {
window.flag = false;
})
//鼠标悬停，滚动停止 
$("#frozen-center").mouseleave(function() {
window.flag = true;
})
//鼠标离开，继续滚动 
var old = -1;
var interval = setInterval(function() {
if (window.flag) {
currentpos = $("#frozen-center")[0]A.scrollTop;
if (currentpos == old) {
$("#frozen-center")[0]A.scrollTop = 0;
} else {
old = currentpos;
$("#frozen-center")[0]A.scrollTop = currentpos + 1.5;
}
}
}, 100);
//以25ms的速度每次滚动3.5PX 
}, 1000)]]></Content>
</JavaScript>
</Listener>
<WidgetName name="report3_c_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report3_c" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report3_c_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[店铺名称      营业额    同比    毛利     同比]]></O>
<FRFont name="黑体" style="0" size="128" foreground="-16711681"/>
<Position pos="2"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR F="0" T="1"/>
<FR/>
<HC/>
<FC/>
<UPFCR COLUMN="false" ROW="true"/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1713600,1523520,1560960,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[1005840,2880000,2880000,2880000,2880000,2880000,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="5" s="1">
<O>
<![CDATA[店铺日销售排行榜]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" s="3">
<O>
<![CDATA[店铺]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" s="3">
<O>
<![CDATA[营业额]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="3">
<O>
<![CDATA[同比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" s="3">
<O>
<![CDATA[毛利额]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="1" s="3">
<O>
<![CDATA[同比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="日销表" columnName="地级市"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="日销表" columnName="营业额"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="日销表" columnName="同比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="日销表" columnName="毛利额"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="日销表" columnName="同比1"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="1" size="96" foreground="-16711681"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="1" size="96"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="72" foreground="-16711681"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-16711681"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<j=e;cgE9dqS81[>oB5V6,I,(:d$LW3mE:9!5Q3)Q\lW%M^7'CKn.O;$+[tYL^/1WKiDSa]A
O,H@S0i3)<E(Eq62W3La3>H-m:SPJO>78JK0ija[pO0K6,f5*PV+Dm+bf8o*9d'B(*.ZI\*s
=[J#W1qYeFD\IUptn>od!k,r(c9&cpT%gC4HougELru:Kt2teo1baS4`nb')erkmUPRtb$B#
^H"qf0A#[;Z(5"1M%H,cXph6>of7#TI1C^5&O[&Ke(+>EWl?gs88C*^]A(.;an):F&j-9_kI-
tr[UE4H^uN:P+B79ai2l9sh2c5N0ap#gE$mapKR(jP$$h$SdtT]A-25Oh\<((ol@/&dZc^ARa
rL+(ur87$.JQpLR2W(qoT]A_0[4j/FDK-V<l3m[Kjpt,!6pX$I[rg(!XqH7QC6MOsQSmnW:FH
8&8ko1o690MFLEFA&iW`Otfkd[c7"-l<LnF5oMG.tj$.8.m5-l"I$A;C=&T$`[fejTCu'"F]A
^pkVYsjh9)mf/SJ&l*3T1<"Q2G??L+B;Ff`<O`^]AtE*t94:]Ak=j(n1V#Ro4p+dB7fi\i/""n
=l*0[Ij6[%l@&&H\(k1EkcEgl8k[J0"Vg"$;o$c1&[SmPfBV1EI1[.3/aOU!ksDM`E>1o*@3
tpS!LRXS&k'pY&n6p;Sb?H?e+L0%E!%q#-`6m.$CW$&*,]A&"<-1e"Q,Z:^6M;3MWmRCLGc#U
qq*MH0#RRO6'-oA%I_*]A*8P2Zr4\.DK3)<S1!*gVn=&Z>'LTN*3&!RcnjT'o=7GlRL1aeB'H
TrTcVC5*_33M37?_M+SiJi%6G#obY'H#,ah`J/:B+5EF&Yrg(Pbj;5iN<7`UU[J*/bbV&)9?
-V&)1336pO_.R7/hIB,@_92Hl`')CMMU%=-.M=r=)s'Xo*^;F&bfX.!tj0mn3ll+CeiDm6:Y
`=3",A_UA0Doerkt5):R3EtXU;U*@UQ+PZ_3blNlkIr<InP'6oa9gNl9]AAC)E`KJ>U`^N$-^
B?>=kk9Jo@1QV'WomeD,RHW22&#%t@hUqRRSIF>,>\dBU&(1aoq+KJB=#Lp3]AV,JUK/Cq[J)
Hr+scOSaH&s6V0K:lDQ_\=S\=25$hj&^.?)0EP!1!csm%ZB5OiqmK3r.Fd/C'A=EIUm2\)LH
7l@gjDW!m'e:@l6tb6m*_Bs(H\)Q)rb'IfpW%A;c3_Z>qF:<2tC7XWOf`t@X83]A$K.a,>)\s
[`L5NaDAEl+5+s-I1"J7sHQgL7bl=/%37c_@5>!,6"rWp9$,Er?JOMm=!Qe_5rFoo*?H^Z=/
@cH3(*klO$:l+[p"o:AG]Ag8n#=4-Z9i2W%Q;n@QkfPscM]AO&3l`8LTdD)D`@f.>Q#1?h[,<S
CEq<(W(,EnQg@DJo[X>p6up.q%TrPr:7(#^//g(EMK?i'LZ1$_=)*j"[WraFr^i`+lhZcM=2
l*p\5I!YQsibrIh4YE)GrPpT_m!%$?c/#CdDZAhn.+to!?bD_EJ!$@2&OiluTHW9d$+Xp[`9
l,7]A2`Ns^c2r5o]AXdS8.%B*@4e8-TiVa-L^W_@Hf`d5O)ZF&IDf7ni%*!)Yo^8O-@iJ@Yn0^
c!FX#`mn!^qb=Ar>3RMgC55Db_ep#3<8@dJ('1R^W<UhoV,L3'Ho\p:ecH.U*X*5[r*f#1$L
sFG`;%GZ@$a7\pODaOH".Z)A+:/-CQo66i+'Z_#NO+9s-XCG"VcZn>dT+h`HTful]Ae8P=LA7
F1-DS=*pRJZa[!o"N+@Fk5)j>M*QM:.AUqO^>jBN4b,o;Zn]Au0DU/\XTC/c_PTC2(1;JV7=d
0.o;_/noCD=o]AOGJ"o-sCkd;U"D?k>8PNmebn\dAO'sI]Aa?Fn'P6WKD'r/sqo8bWEq-_Xf9L
,2E)TFDs8gWV+=:U#hKnmCG'r^aH%E0nK%H!]AV^h&bGpaMOPU7DNoOF_(gDIR0F3`>!BXIWh
r3uk4s(.,L;J!#SuKn<dj5q;qZko(SW#EaQ.>jJetd"?F$NrF/(L3!(PHI2nm854<\@Rb$E6
>Od,np$%R6ISMTFXCPCL\e9_j37O[3HbmqB^bEYhb7L.GXGd_da9]AAO2cR!`'iBGf:8"*L&O
OWqG[M6<d^nt'$1M(2u@T?lPV\d5KO,V"Wr893]AX#-$JnZ?+MJ"[2c]A!aW'R90A?eu/l9R^\
d^fZ3Sb"Z7,k#OJ!RdOWr\t9S3jNi#GEhAZG6[D.8SZQ_-\0p.Yp82UmOG2me',+&CkM$o`L
fb#WMNTJ`X$As1I,dcQ\1ig+^+Qng.+cPG=+lo]AEPq).pFn,ajm;KSE9iuMAcLA22,:)9=BQ
.+H$8=YX3u(<N;'2-c?BW!0]A=A=DJ/<C5A^,3M!2`>-A6B?GYB_(De)?&tQ"^Smq,Vf=91K/
Lg3+@(H:nA#8]AI*R1"$Ih5\pU2UNFOWkC)[)rZ(d\B$>1oGOfWRBs/a3RtbE]Ae9h/pfaO-_\
^7^E)Q2bgI#,4^`6lp1,;4>,2mt"M1Gl7:Q<Kc.Agh+/#u8m_Qmg.N(mdG@C'%nMTf+2fc+_
H?8.='U?>XI;,&C9i1OCchuS;oE/8VjB6dgfB-Ts8Z;>>J5ETtMQp5?XK5X-W-d#*!2-!<hT
pqFg;<g]AW-u#nGbadlpI/]Ab"&E9rI-G[V8C.8S6&G;tXuYn(3#c'Oe$Y<JWUg*C&IH%909q8
>;Y%?i<,/;36'8il.$m)/9XMFbc\8:B71\LdJNU^V@95e4_F"k3,/>o..NPm([]A7\;R'dV)Z
QYl=Sbf"aiE:te(JB%a9tJp6I#Z@4RZ\GPMcC\&WL.-J(<NW6<V1J]Ag=lpgm%Y+>[pghm\TJ
PXWPTKu=K.Xfg7[U2_AFn+&`8c.H<Eln-P5W2<7t/J/CTMRk^VZSG01I$TN1;o//%27!k%<o
;TXeP.ji<,CUetiQ5=QLP5m@d/-G((Hb./&/U8*X=;W8brYZ9Ea:Ls<;Ai+H_GmjVHZFbdU[
2)6)/Nnf5MC%7[RHE.XTcT(:`9^OGd<R01aDpF)lN>\j#=,'h=Hg(aU'gkW(b1ZG)ANtbH-\
u;bJR8?H[j7$Cq>4`)/HQil$4>GRt%-\-kQWX\>D%0Es+jR`lP$E@_u),W872%mT2@l.!jmN
D]ADtr&k%m4Dm'Ls+n0u$h<E9@52dF%K$*cFj:kYS?UGdWV2:I`4#^YV!?U5nO`V;H"0UI`R)
scl9=rnD(@K-1uQ3QK8.$+-'dNL=+N%E7NWY/T;VS:=E)+E7JJ)@Egr%Xjl[CAl?5B(QF^es
8r/7iVDPr\%_r.RKZE@n$bQ6"pc5bHF2#g)Y'1lVCT)H_6'@c4Ru=MhYS*a9'P;FtOE[.6-=
QYEiQmW\K\8#%@"7U-Ka$G93&nM2cV*mRKQt`-Ad5TTMZ!%,_!o\n=_q?H1S(^bP)"Bn&K91
:j\2(DD<+b2l`deeF'bIg0b0V07#[,-hcQMqCu"-d36/6rS4pk([G&edl,`1'Wo;#A!Ct91k
QZ?$"GOR`p"N4#m7"4!ikLDR,'[q]AN@ib]AS5PdN3?iN49cf$A8km@arXSP=oC1L(WOC3b7i\
2]AGdlf#oB5*X/dN`>;*F!tJY#P0q)1)@F7'K9HFaZnnh42F[_/hcn_S%dc.2=iA[?t+C8CDH
q,<]A-i8%XeYo[AD0o"D\UdVj3QSZ/_CW==bqL'r>[k)RuTP[-+Us/Fd!Sd]AL6ka=_!A]AZ^Ab
V6C!:_<)@)rb+GH1/7L^*6X?@d0F&8r1[7>=,!)C2WSetC,9c7QrRkGF1KMYR30r4W1r!s<#
h")oU3bOk3+qi'S:GmK(+kn)-neK+\;TO&MR@)!(R9!fX0_b4M[?5]A>(a0fd\YVouW[S"soG
\\P#YsW:sWb&-*2BCTf[mOPG2hKelW@l,Z"-7+l6'eDE<tc$]Aq;j*DT9QbO."dq^Y0QXAjEi
Ej+Q^On:M`kk)Y0l(k_6sV`l4u(<pa:oFFY+^Nq/m1a4elF0'sTkkR^u9]AC=Q`U+V"f>u4s_
?LfJ@Q`OUWVq&t1X7f')D;VDUYHO\8llLFZ>;G'FnTnKf6YFi)7,k4h8dCOj]AmC4B>mPd`XZ
[^C=q76:c=a`lciW#9Z$/nu)Ca;VCbAbt7;;oOVS?ZAZ22cRk=HldI^jeZZXGrMEq)PTKOl#
N'6_^*qLa>s4ikO4/-`8Udt68p(O#m2UShCUNn1&'?<4;]A>4g(Pgso*KEQRDhn`rJb`ah/OA
0il]A*Dip+6^q"[ePalNK[PWb?c:YkoGf%W%GKd\,D9)FL#mS]AX9sAT,7]Aq5Gnlpl@[nI@Q[h
mNK6-^Z[\Tq$U*\B="/Y,?V>bB9Z`T@2JHhru.FshqAU@MFdAXI:D3:\-IggVLG*2_Q-@F<+
]A6SXOd!(c<H:]Aks<NYs?QUb-CUX)Pscbb[4nL[:/NF&R0NE(:\;::4(UfrCLIN3Lt)n<Ij42
SI5gf1l<?7J2Qk^@#6e0pEpS/a)Hdq".eoehHkTf:k&a?`^ek,"rUXa=?9gQJP('H?e7h5Y%
94c[[A%:+D5CA#qCqpNU[@;A=G7k@9[TU''^k3<8P^-?S^"ZUuJST@)GbDegpHd%=1d!M!ZN
6PJNWGHPa[A4Ii&s<8$<0n=Wa4X3aV[qNZ(LD@/\pZHKP!nLQqGsbAkQX/05i1SbQ&Z>P>G0
\LZ3ojAe5u"l\1P3s#_RJul'HUF2;?./Z[*NqpU1j#=n\EBGCJF2#uKspm/(m`1[%l<CC@I+
5kCe,OVt_i1e=a47ZZdLk)2mOQ^C`UY'-GD]Am[i;?-b?WF)j&J04F5f@Igo#CO;D"fWh-r^F
be!d&;gB!ptQa>pWdg";,Na*_I"Zj3bK43JM!/32g5N6IH2;&;#Un[,pZH?ur5N(2_^hJK9D
bXS+H,G"E=)2pc2I407]A<)N!D2[C3i1Xgf/?X>?2N;B%"J@"oj#nh0GOie9%;Z;8U@"Ret#K
B2X(aWB)[jRd[GTL"]A2nG3A'Wesgk?=RN[D;kid$Jjf_oUj0"adf'Nhb$P=(54ufVmU=[U&8
r26A)WLG_I@=;blsfP]A&dNoIQDZUR:VS[sd.amWp\"oi\IH?M:4.5gb>S)u3u$7n._=5K576
SZ&4sX<T'P2A.l*5Q/gYr.:Lu]At]AlnpOKD]A>WLD.9sl&PHrriKAj^KsFbt!XD:pP772Abaa7
>DrqRH[[\8T0Rp/_dQ,G2l0Y'9m<g<RT:7OTZ8&W0jN(XhX39nc0.e<C0_r_C!#&a_X?aTh,
IrdGfmL,$dr_l6(ZZpA^P2Ej\)q*1J%gVGJ0foj[dVldE4mJf\c*g&'m]AYYV[qpqEiT\S=cU
a"42hq^6L?eU%U<k@#.2_^6g(>U;X0C:<u;-S!$h:m89:lO:m$VXQfh^2d!PLga,`j^'bGJa
.0'H]Ae60Na/<:#6uZ#,gZlhPQ5gPIDbpLB[dWX1Nh&EH,C\H-.cfh!^N+:ttI.(c'pG"O7))
%E%jR_cVQ:aD-?HQ_KCk]A8U4e..fM((?;Y.c\=.GJsrYrH7Q*i!M8^d<t*Oi-PFT>2PO$Q)Y
cKoX.*r%DJ$FB4!/T`lse$e-*?/bM,nJ/[:$(;e9Pa<6mj[[<1&?h84iRo5-?,n$'In,V^'&
ilYNP]AF0erchc^\4pS!Wj<`kHZ*ijt-AI"G3)RN9AEt;$!V<N@GoI[3("4'6WANep9S6ZAUk
OpT\@i_<&X!=SQ*Gg2=UE/PW8kipBE+S\9%62@),HOF`bYE"HbJ\VC[n,49=*<.?TNggP-jJ
-JOer_$:7B'`FB$F@0I=ki"3ThB&Eq:A8)*uZ'Y7%SK$kbO"BAn@k[`trgiqW-PQ(7DQgN^0
Yms+0jOY6L?Xmj7GQ8G(2Cs"f`r3m5K1rH^=`nlp06.:S6diH'k)DW;1e1pnF/L]ADA)>[_A+
D=kF[`agPWQY*j#Tl$rk1g)+BAN?7/N-N_246r5pDK?Ck%V(f`bLsGi^1V=TkB.bgqP3U,=W
G/u;Pg8$*8>oW`GEV;CKe[:95=8*Cqn7-OQ#,eW9=.9(g6V&dfC0[Y>KT5a*iK)1ttP'TG@D
/Z%;Z0nlTF8gSl6ab+)AI]A$mb%f%HJ$4"F7b2ple-u,6?N[<RW3)LW;*n>[h(XRG=5i<[qmB
G\`e`aE`B;*n^s^S8(k4d!3sN^Ob9ht#qN99QQKZg6qt6$k)d-%&XHfn'[0ipffMOPB8S:.+
0-sBiiJU74R4gfd0Om`7dr,AaLV"hj4#AD*i>;M]A/>@NO<GEI[P358c\3+^[@'SpriM4d8H5
TNO-l4?u;'n;Eg^UUp!Ilu>i,I,\fOQNcR7bB.j)01H<;[Bm/&m,AmM&uO1qCJJ"rIt04L^*
P`3.nPQlS-:?IG5s%kq`J$"9;&\:q.(.DQ"KiWIQR^D3ecDdd@5J<7pJGoA`@86>Jhg+3ua!
0u_#P@7G@V\q6s4=o9rR[LX&Zka;8]A`t/VQTP+lj%15o1*Pn:Rh1:=<r_VM5et?9W/RaRD_R
b+JI_\lZn<_;"JZd75i]AI8]A+5X5K\[[]A;Bu<5)@*QX[,(YRWJG!?pE7OlYLEJcCuB&"B8:t,
#GNS%Y+'nC8OG8uP59C%_'!8m/^pbbKsk%$G)n*0rkJ`Ce>':g@h=VlAn"r_Db!,O.&KG$Eh
Y`'rG;kr9EEP=-5"i7A_U8'c'CJ2e?'TTgWf-bUE(Xa@18naWB5B*W<2=49YU"u#(#^h=<K1
4IB6'n59<D4QdE@hVBso1`u^8MMTtIWHoEr%<M`O%-0WtN/SRmo!Q)G-H/XO1'n9c2Ts=q=k
BD`hF[Nqrh=Xc[m#/arg$4P]AeA/qS$'K#o4J8k('JNf94gZPbrB+I1E8#D]A`sn4mL0+-i%hS
`gn:lP<SgVc]A-KZ</Lo;:U4Ba9[+Vk;*j17L`([Y+NUSq@M5HctU,F&6@!Jg?B0eJ:lN\^9M
hM^*fX:mLs+pYTKe]A[L2QuC,^.((dH;SZ(EZk_U1&h]AfJFi$^13jJW*TH\?bS2'1Pr6R<La]A
5B+T$DXT``&ar3/-PlM:I:&Jn1RYf<sRTSW4Z43G*oJS*^;NH&SN1"FO2u.gf1"ScIRP>"-q
\64+I-%'7EP-G_=8:)Sl>4W\HRM,A2(Wtn4+gWb:C(C^\/7']A"@GZs+F,1*+TRg[Z<<tL%O]A
p!u<3ed2d'H4Fo5:Sh4oQ%J?DDDeh?(G?A%4ZEGgCY#i1c12Yh>#p.cu\9L,Gnu@8Mh>t7(D
'[s(K?a%CAmNq#*W,,s7D:n5q6rnc1(4JphEb7Li#EFrh9@GPAPEjA/E3KK\F]ABM`OR!>/rT
/>.u^*B"j8inhWb:NA=2)g&jL$qka,JjNbnVi`MYd4WoTaPEb#jF&jaf2%&>'HSe3Io.9%5M
iE"VD&V-2@ci&QF>>0#QMc_C&J,<"4)c>IS>i$K0jN)N4COp?8-=Ll`>[S-6_Oi.JRLbc$P?
7O4l)82H>Kf2q"DJ+HZ;.,=BIPe/!4_]AuA;?6f3rF%h4/WL=]AMS+-#5%82i?g\fR&hVLF@>Z
T`JgX29,*N*p]A]A:8>k0j`E2eA"#R;CaYr[8I)p%\eNrM=L7BOOf_M,oV::/%-TN5"D?"XPOj
uYlN=B^Tf-sQTem=7]AV`Eun.q*`E7p`9KES5u/cmXdDDTFV7EH>Qj&"<d.<\gV63$9:f^fp<
HoRBIs$Q!-lGcreg3gW@>`FeG>(-]AXWC:EpXa&f_jk@_cj6Qf9SD.<==FsKIG([iZ<Fn6]A3T
Jp.A?76e:o+?%58=$qi-XpUNemo<FI1l.IJt4CX]AqO6I.:!1PAZ^oLq#tYnu?.jh9Jf"$/KU
hK880L?_c>`A)1LWiuY6'W0Du?Q,#Y#U*t2(13[:ggUU,J-4$WH%A.?tX.)+)PqkiEF3TVlc
e%L7Co%Q)`?1"N:bJnBd_8m48@LMg8EA`J_G4adGh5<bAJG=/ZG%B.nRV5%[M*:>(esnFRuP
1tk.6pn02!5AaogHY'3+54ocCWndTlFcOh_sEaUK6R:d9\fV%LcI!o!DZ#2rHfOX-3\M;Kj"
!(g?"0m`HfdU-:FLe0Ku'\+kdn7Ep-NW#g>7XG;kSjF.U%u5j&-VJl;lRF@s+k]AJajXmm5CK
1(8:E%9hL_cL%2M5-M=0de/L2dD*Zs0iTj3X*#6R^9M'6_k`'nbB^XI7m(\o%J1nrP/VH:!'
\64n.j^H!/rVhjq>j7D?tWao25Ub2=&Qsac+7A'0\:\l'LI#G?70']A+bYPX5t14a(Oq:,<c%
<]ALZ*QaV+*,ZaW0pI"1b.+^O0q4<@;.JILcGPj!0YqaEe)-IYaaN9]A'Io3]AIhta2YchFNg#C
4Ja"hG@q;//?s8ICDbFXoCgD.WsEqXX9"o\<cUXDO(G,Ln4.-.\]ACZU%a(D43-lFAD,ANTuE
'GZJ9j6u&*F-->F24rG6RV:/"T;oGM\at"L[j\0A";p-&i-O5WIAE9+dQXJ!*fI\)O#"0J\&
;%R>e[;drDhd.PdAPC!q/_Cm()#$8r[a$MoC9@b(<jl#bTCq:MnV)_gtTBX_>H_X*I&qHIAB
h=$^OJVWDlZoE7-P<O#]AZ3`G-[n]A2+S)3h*g*Pa7sNcZmtlaq]AC?_K":Yj5h73`7NDESH]A--
^[[Uh=JlrhMu!nDRZYO!e'(GU@ZqPm"#CFHjHH,]A%iFRUps*J?W'g9:b;@.nFCZ_@>3SW1G'
+`H"2!F`Q7.&o#P4:4LTVll18V7MP'0Cr=kCQ5'?9scP_t#p0qq\T`+iGrHH`2lm-=$2/D'U
T'h`0iYICg4qM^'gIY\so<Y&T#C[0!RfpC>^[-Tm]ABe!nKilUoGT&id6P8$C>_dYsn*L!Nqh
tLRN^Q!G#Ojp.aqi)!hWc#?MQ_c(/dXF,*_9t!5+C:)?i"?):HUMMC7ErFU@!WYI<Y^I#0s>
u,WMDEik/==7edj'3E:nZ25/@QQAf!C&fr$,HtR2]A:HsFop/9qmViME4<i<\g70-72W[]Ah//
o)g5IEE5hn'U#TT='SZ`*IM-b0Vo]ALsjNl_[QFWmEY^JSM'ZO3Wbn=@BWP!F`"MtR^usK(=T
oK#@]A-9(O!iLgQMSae2*0pS)H.f-Dpksc"YC#nIG"-=5,AX:N5UaY80pu`pk?6KUYUjW`GE]A
Mq\GH=\r9IGdh9@69`e21p<5B2]AkA+6[I3fe]A7(cDq]A\m"EH#rOj<NF.=^-lU2kh-Q]A?U^q[
,g89H!NhI"pQt5#'TRVtBhi=.]Al2TD]A_QqsSa,1;K8L<@Q_m)P]A%]A1W5X"g9Hl`nHYKp0A#=
oK#XbTj4E%]A5AM(fnf66U!uKr7C6K04;Q@49^UW0%]A;OCuNT4l`<`576$Mr1ABPZqapPuW88
%S?OOZo#W<Bp5V1K672-*I9DENgQmb!B%.^\Ys`nD82ca*ue2q.Gj#g\=hQ,UC".Y!_0kgKR
&>F0t!F'`p.=6!2U<L-t`0nd'bGLOBHa%^XY!4/XCAQ^'YLZ^ERUk3N<\\QW@iW23EF5B+H=
%oYq@otJXtZ8I0\F.Ze5l1IiIfB+>.hrO<a%_(;F`ST!ZN=R>d$,;39g.WAV<V,`oYt,IN:T
1i$gmFZPY5I]AMTZ*8m>JGl]A&k,HM1$/L<IAs)6O,/[*5T0%H@!:B]Al!jIq%Foa_6#o7sTkWK
XBhW8.]A<cl5aq_(GAn[>U?-ZXC8G5`#+lPHU/"ZVQchKj/2p0D;V1OP[pdA@d!/3V3p#SLs+
Z1+-mn7h<SHnY4d82Im&Q.e);>TqRA&KQ(&,0M@X;SX0"Hb1M,<j42f<tCEK!Y4("ju`;F]AQ
QIHi>PY6O'Nh[C(K*RtK68)?.?-h9lfj>P6"#s*D"9_[?Qm0O*:W.-2gSCdX\1N<tu/Rmc[j
lHYtOa]A(Cg1Yi1V;l1Se9VZ'Xr=h325Pr6uF?;%8/f"jYI9T$!?[Vjo4o`Jq-nL0Lo:jPb(j
\oT00gWSh+4NP9Y+=b3(#<-CU&j`"h5hbnc,V>bPY_W5l#c;o3P.bBmLu(g3W^HB_$Li3K*G
#TiD!-[9N-u\o+#V'9RHQ/lmci^*UPd9)A-l*Y*LoK<jS0O67E`28Ee[,VD&]A7X.l)3EG'Ce
,W3"S!u8V&0eE2/,V8\s$RAD'Ss2_@Jaoh?&V)",j)OO,#\3<Q,cUdJ2)'i2=$oPHtDu\#nt
Ui>Yah#/^Q4gIeTZ\4uYdHju]A#R8_j0B/%kE>N:1N`Y#3ZrQB_p>g[U6kCViY9Sdqe#*V+^B
;0-N@8[$2),nq7u08k*fm'5!1"m0OMF,bW)B'^D7O9cgJhFQ;25O$+.Zd[HogGat^p?DLMPu
$^r%L+A<JpHjuQ\UpG1kj`,<&=?uF]AH^`ZT]AEn.cRV%c6?QB3IL>JharPEOf_"=<\hmPgJMU
i7,[#Y.Jo,GrScccB)O6D@4%'+fS*Q?L?#/nF:*&!ab,2O.hp<)\"88]A!/QZo4()4UU[DK)L
Hh2EG)q>GNM>-*Vt5tYA!9&ZE7X%OodII+9lXp<ShSpr@G9SGe'6%E/4CG(gm:TPe=#C8??d
7!*/NIe#QGf]AH>F\"k=OC$l/FI_\e+nW#Cla11?&e[gS#u$]AFLa^1HY3!+$NGs1&,Wu`1=mb
o-V*"C6e9R#NADE)('CM1\PQ(`BH(YB-afp71bIf%k_^-9tR9N.G?eS87KGM1PbooVCJcdVG
YVq.Y"h!Cb]AWNVs'@9UJKS<Wh7,pk6&]AlC)GdYD%e.6a1-$9;`G<r)"Abg2mrA%igOit>.1<
#j%D/=]A#h+>pqeh.MKl6geHT<N%at;oO-K=&PqAk/$iGGTbSnR'o-%Tt"CIVI*`%@ucmQk3]A
aY8)Vh>Lu)Z'ZTG91#WB:A^ck'pn[8lU`Wc6,niMH09U,1h*gJ=jA0]AE+"RWPP!\O:F9^Zb=
5RI>l2\)0XIPoYj*I#0/n$Ic@nN'+^tF5jXn3o$O$\,K_m@1mu/?"'3r_.c19sIH`;Y8:j]AK
cP6`g?812Qkd1NYW0k6g)'g#\H+586GG48fds59]A3@Z4%D+e*mVPSWGTfWMMfKssnLWZk[!^
AVb^:VQC@hhm\(H0'Y0Oi!3+"S'$=XT/XZ:A2q92VV9W?o/=51S,/\%!G;`f/UQ&bjR3>XSa
YI6>-gZsm3@.\>Z^$eEA#T-7Ws2mAuZ3c`^dA`_ap!dGo:dqcn]AlNh`ggo&GGl:abi,KHedP
eK\]AI(s`EiB`@:4#@nY\FVVB3Q:I"f#u$[$Le1^7LNCQHuGnn<DBuLE1dqq^MGW=g1nd1/T_
Nc&FB=(L.!%0+dlC7Ttd"5Zad-37aQ8/o8"Q/UH0M!#sA/r\,*\%?%+`a/9b8$QH-DSj`5qD
$Dd5]ArARaKb'nK67=b!;5(HYK.s,PF"*'sUp!b>h:>-!]A0G#uA>?"/0H@`)Uos="nZ05*3+s
58+h-C':Vpa'oZDbIF,[Wru@]A>7XZ!4!CI#7`FG+j9(\#U,Gmn4=iMRVdGON31:#B*o8gJIm
72TT_K`;77NJlc8AJ<0Q\;/dXA[4"&pF81al\#T2ZX_M/cQc$Yf!4F9+-Y>M#c7Il,<&9pP\
2LF\\Ttl"7+p(FWs20agfLA2&n6/FgmMJ&_l3*[>a`l%#lT!/SgOe4C7>jop&!1s;[j58p\O
ACii^:XdPCsQ"[KQd`fEj]AG:6k@^N-;0P=Ho"6%IAH^!<>YHr4_OA=l-dcVc`o^cQJiG0%dp
m=KUM[9#PU_Wp#h=-iO<!J*%8hY6Sr$fqAg[^6q,E(%-pp8,G(SJiaO"QAEjDRkOCMp!PX6r
WK3R9gD+,Whc6Gh-r62[]A3DVJ-QtXBb%5a0Zu(3<UeEV*9%f?n:0Fg[@F@!ad#"VcA(Doq_'
1I_=OrCSLiomm1UW-omTn;CXi[#TrU2M(m,cH.d(#6AbPkb,<ubS;UAPp8@^!PhB826+o?r3
bR=.STY6jGGU9dn`aqk>^T9j=b7PngDb]A"^-'3[$WN_;qos_B7T1;![5.04LipmS?*f@5qR%
8LWI"C5IK'f~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="36" width="250" height="114"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report3"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="1" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[店铺名称      营业额    同比    毛利     同比]]></O>
<FRFont name="黑体" style="0" size="128" foreground="-16711681"/>
<Position pos="2"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[0,1066800,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[14020800,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O t="DSColumn">
<Attributes dsName="File3" columnName="地级市"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="1">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="<div id=\"demo\" style=\"height:250px;overflow:hidden;\"> <div id=\"indemo\" style=\"height:200%;\"> <div id=\"demo1\"> <br />" + REPLACE(A1, ",", "<br /><br />") + "<br /><br /> </div> <div id=\"demo2\"></div> </div> </div>"]]></Attributes>
</O>
<PrivilegeControl/>
<CellGUIAttr showAsHTML="true"/>
<CellPageAttr/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="黑体" style="0" size="96" foreground="-16711681"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16711681"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9=@.;cgQe1"9l`1pn?"lR=)C_g1OknPjV/-qGt'g1cST80-FCbb2llCGV_p=p)`KGH@>r@k
js*Ag.<0FQbtO<`;X;%@73YX^J\U/4.9?U?.PGJ.T$(-C:9n*BVa7-#:iJo[s.n+$:(8[F\a
N>OV<8n+WrlJ,A;=_4j$km7mq=(2a!<7t1q5$#0a7pR;?Xao<noH!h3eA\YqKdJnN-J,.a4Q
G%RI]A_5+'k51u>IegC2fH/]AIkuepN*=a(>6&VqFR>"(b*VME5Xo2&5*T%2&cYGTE[9IkJr+W
+Ski&MNnd#m$8!iTk$(N*:\!XI_lKmr-d;J;P_2":'\62@.'07,'+7VaU.(:<r?*\&F/K\Ua
kJuhcV8'V(_XZgT?qA$*k.a+3j6AIF1&o,h4"g.oBOa2t4nR>I[a9>VSAR*ZM"+7.(P[qB..
@X3c]AkMVG*Xd&Uq&#g[j<6`N*N'aL6"l!>Os(Rp\W\A->?sUHu+2V]A<@tm]AoP;fgf#=UHNpU
$/GS'GV<X4Wg3g/or9r3%W2FO-EfneamZNdc'.P/4a4/IC%G[nq:;>3jMDA_GOH"LOe'T$2b
H0)I=kco(Q^tbZWZG&mM-\+71\\!-_($8`p>fD?/nFBF;aETNKNE-1CO_bACPT+IUAi#VPuh
>Tg.jJrI3&8L+k`'S';kS"=*oG-M&e>\'L>Y*QLBp7P#R;'p0<"]A]A/blB*j/_CXBR42r<T\A
;6P[*-b.0Jh,D#JO:PG-c<Zp$PFn=7*RPSVR=f`SafXdi/`r+MNuoN8;-#`h6oeF5%5U^I]A#
,t8Ag+TtO1=mZh;g9=?WbF;F(A3j8`0\beDb3ONis='<pQShWFenf[ejkeeIRO-]A@/GeVcD3
dCIp#`ORG;7E24!8i[:Q/YHC1BMmXfK7S\,5?uG-c7ophu,[Z5[Xtk%ZV"oKQI.&6?kq>4Z&
<&55;O<arG2A4E.WYJ&MqH9sWp!)'(F`-iVN+K]Ag`ah>.T"^hFZFS7Nhg)]Aa3L1nZ>g;8Un'
AKm;`i5Nb\Lb!bJ1j,Ft8+>NrKW)=MZp&SS=Ns.tKkai.),MJQ9TF#ercdm!p00M6DOqI"oW
K1DYE92nCkojR.\=HrHd2"JJG2&F-]A-.;&AMdnL:_jsS>.-pIHr1<F/mbu?!ndgT3)ks$tJe
51g0'B\)'$>9@LgN"?(##RRPD69PFZ5MF/*;+]A=00tY+6L-&-"NN`6`AQ6^AeE^@C1lfPj>M
Kq0XXp&"?_?=u9,0,5R*HHWmp"5?9(Pp\I"*8U0(OYmKi#@uJ\X?X@4_r_j,fiOd`cb1ZCn<
&e_hQ^+h4%t%U6;Rq7dPYmi]A0o/qHQBEraUS/_.]ACWN`_!;7d:s=KFf6X7g*;I1aTl"&AR,:
dHX5P^7pq:ZYDk_Q_UPj]A]A:Z.Yu*@`q^D/LZ^O.JNpOK.RWj@?75lNDfc;:5t`UI4lgTYsGZ
3:%,.mLDi%eXD(<']A&H4?0S20@BI;qAf`!2o-$2Jp\[3NqpA*<41Y[26$&l?&8+=$8^A]A_om
"h=7<@,oT6k2`BX"u)KW[ru4uSiCSs>`7:kMb.D<8jIiU?Yr@No17oT10Dr]A.MP<5U&K,o)i
="ng03T$\@OM4\G9a_Da[1ZGR3bNE+_cUXmlra+>CO#oK]Ae`5-u77#,dR):1NFc+%(PMaX`A
BuE-,1SMBZX<&ur,Fs4ih2+7[T/3=1.#l*:g"B$^t[6`I,+?A<MXOdD@W;_E.hQU:<>]A2KNe
:cU,DQt8).-[bt3IL#6skr0j0nk+&@mgZ_b>'CVrOP'NE_0c'GQMhp&$,4Rpe/mX-<+_hsVG
qQY`<>B[PR$HYVK("*,"=?;NuQ.V=TS,9ZSX/nq[?$87ci7f)@AlNLa3?fe7#7[itaWOa9Xn
Q^8bSMPhabPY/2F'k(+d]A?blF3pR[_FAb8$oFD&+OQ(?HM7Io;A3-nRcb++1ZVg#@lfba.+o
3.=P=5>U=E(H2F7\^BADt_HDqDAeK9_p,ZO@JJ"WT/QMZmMb6A*3]A#'q-N$d..?Gc7N(R?*a
>J>jYjd9C_0qZF;m9n'Q<uPDI-DWkU>l+;)W<+P>!0YmPo/V=#=HcX6Qf:VmuqJPF]AH_':TE
<S=2OhhJ$ul>D_h=!8MaOHDV'q1#CKIEW2@&Kl7%hVFZ*:qSc2[@qbE48;J9RO&-!mmD?8`L
]AS05))\?tTa^93&e)AbB:N=>.ai_aJ5AK!@p'ckmb=D_"#A)Bso^Ku+n;.:g+^'k$m<-R+[U
d7Y$.s0)%=@$[Q&@KNQ2#1$NDV.VOtd,l+(S@=Ll[=#jh7h3gPMn?/nZ_:)`iMQ)PqY3!bG'
>5NQ7.Kb;NGrIZ71OtGeJOH5s!N8;;4"rmrc=r-L6A^4:4pun@Ad6@*DE\*th-cLa'P?h;\W
j\$TVb.s_c0-2!.a(@)i`g.]A1Nh-.D>o2F]AH@-*.%Hk0!hQc[k(6UiK5=l(/9m.""V#ZTrdc
F1C7<js(RbXZVmf>N99E_i]Ah+8Y."`MEc/Xs^>D"6=6+thC2Wm*M%=c0-E$iI@+Q*,C8ZgF_
=kC>+_O]AB;&I*ikFi?0uZ^*0hZt:RTq6::EjB@7K&G7Y=oNF"bVkY,>HHmHEdVU'-bp"DrVZ
/WIJiD?T]AO=#`)"[r;$IqVSVQnVher^eI7-fHlf'(S-ZR6qEqC!\X+*46;^"@8DRukfE,%V$
]Alr/.0R#L`0Sn6uIF't=;P?$5M:FUc5Nf4>'C&tsS-f(qFN&/gpN]Atj2YY)qB9lH%)dk.<5I
/cD1DYr@ZUIAe@[F+q=KYW5Jd6o\TVs,JQ4]AbRW`;$BiH4Q(fi882]A7I0J7Z18]AMiV%e;M9C
&1N9i#!2N+?(eEGJ?!YoGX[(="*i'lCM0$8F%1US1i7FNQ$cTEhp<ZH!4j.;qjN62pO)g`Ee
!hiU.Y4k#:gu#uERE'/u,=T6oVqc]A:U<5H1f58$k_!8?'dj1if.a^YlMO<WQD&Q9+O-(3KOV
;7RPY$E9i?j\IQ!)s)=B!"f#%U;[%.a-N4RqsT:#RS,6_sLN$?^E<k(&BP)@I.RoI$+:R8[f
,Co<XK2q0W_/Ij_.!ED\f!:h"EZS8t6m_<MA\&q^30FTgbTttqPM"c5.Y&TZske(eWKtU7NF
DWW-X@Lp[0fWGB)e>)FLrfRN._Mt9E)IFi)`8mhUXu]AWqbV?\*thb7o:$rfN*J@u*\$'U(ps
tEpF:%M;5:GE>4:@r*\l4B$R=Kt;*&O2ffUP9&:'"07dU5?Wf-3`P=XbAa9HhGYU1`i\4HUI
gaCc,p5,oq5PE.J4>o5WM'T)_^"u\-dYrkAf#Z]A$m;d$#M/)8R5"@`qO_cke0-H]AC_h"K1:r
AX>]AGZli3i"HAE\;SIfL>)Ze4dTnb`1@lE^N3`R\:"&\i=#6["JsTN-W,oZg)@r]AnNm[I?YS
),<]AZ\liK>fUGDp/?j6"E8%s`b27MJ3M6uoeU#`]AkHQJWbr>Bic>ig@VCYEN(7_QN6aeJ/]A;
/u2/r]A1h^QFCroo.=RT=6W&OO/=)!4motRVg!@]AB1RPI(;F?.j*jEgYSkWXa5ZNj,^@2hSch
97jB0Tb!qLWEj^;?2P]ANNFUpc9aD1=J3g`oHn"((B\>'FA#!?$jD\/(T2-$2"qa.:0jY(p\k
hn:o=J:2U+_]A53R[%$3]Ar[Ss\eefITI[ui.c8R'YgP2U7l+?$goIOBW+mdHn)Kblm5oAVh$F
Z).QLN.X]A:5ps\;OlI$ZpJu/(e&a$hl*;,fF#GCPU+>.^&j$g[hnnjqKE^QmQ!5;<M-UB?X0
r*S@!'>Bm-^k[m;IMI0dXlI,GKC*%*MK_m&%=2A2-L\aAV,"AfK'dosq$h&"WS<(F7lq^hM"
B#&2#11]A4_/EQMcJosL_B^1pR9H=__m)4RLhiLJRfpQnoR]AHMlN/ITU+)>s0oaXeqE_Inpc'
!44&#F.jQu:(f1ZTiG3f4Wi%-_:f.&2=;r]A#QJsPk[G'p/+I.c>"[go<=bkJ<k$4b]A[C/1[R
Zs5``^hip>VZsu@@55M9B(l?%B',]A8[ql%"5_'-mZ.;JkQ1sRtYKM.)<cI9@%QLO,fh2:'"t
gn)*YEdj>k@uc5YrrZ$/u3Y!/1V<i1R]A`0QNIG;$^kKB\lDo^euVgL)(+/qe)@9;]Al'Yc<o!
p/+g:V0iBitN,(>OANr`r&`UFR)WF.?d!:_mCJP6.<G[R*\:LO(&q6qG`qTbW)3PZHo1C1g7
@WP!K)!MhS-r<A64_tNq1!]Aq.QL6#>B\]Af^6!_h@alZ&BPL>rk8s:1!;#ZY_\18E'8Q4*fa'
Q/c^a_=44IL(*Fm#*B5dMO0VTl;_16hA#s]Abh6U*W&*Ejrn.g"tG;GF$=V\4Wg:HVcSmS[RM
+S"'_/#;kQn/`TZnjOI'/k$#g6L:W.AgYa'U`d&^>M,rP>>7PZk*cml:7P6HV^hb=G+IdL(V
jD2MG3KiJ-fZL`RH047MW@1VBH&U0N^T1B.OkERm20V^=d,'=u*L"?$B]AUb_@Vj$JCUTS71q
2@9Hje9b]Ae3rT.;$&Q_S:6JGNYKl?2F2W0=n86Kl-USj9]A3M'.`]A<6k]AOeV=p!&O7"6VT+Wh
$-PZa0eKRaLhj&3?a?UR+c#;2]Al"s,$&S?R[L>d_!_cjX_34n/[m);Jp5;3#XnrgWQp!/rYo
Q.m_)>7HSL_fCE"&[<4nbes#F[C)f:lT:.i@=`RgBVVT<BOP<*h!3;$7pr2"uO:2#k(0K,)n
[)^p5B%Km6W0PahXRs&T<SW[`T$1,_?to:p)YJ>.'mUWRR:>626Af5a5I$k:<?%0SMrVNC>,
tCm"/H:<Y"r9^=2oX>;f:`u-Z3qgjh]Aa7]AujnF$^sM*pm;LSVEFU@\DuVa"+"'m^:5t=J*a-
*6/_!]ALakA]Ae/8utL*UU3>+&Z:6V)"^B:hO>MDN3nc6Y!uBX0D'W>WYLk8BPj800`V&-?tWA
Hk4D5Q;Vs)-%]A"GH3cb;NSh<e]AI#$Xi!UC6'd.!]AG3&tE29TR$orKm`Ad(W<+dlV/e70>cmY
BP.C,t@$LM0ZCA0c5JO)G=fJf//`WlK:]Ah6nrPDkGA")G<)]A/g>)[qZoOcCu^n@qKi9P"Du:
43iD1Y^d=t;dm0Q^YQ1,]A@7:MA*F+d]ApCN?>B"G'HsY*ORZLAq"Y8/k(Li!,gG\RH`i#_H=C
Wi5Id7F.4j6SSXDi[X@;rB3=U:Qp.DTuAH$O,j&1ssd"Lu>^G?=-Gc<3CAB&*L<OAlW@g2;Y
5Q#\-BOc2*l*g+ZAOgCDbGnnSF-R`t5eXL4<BXotp%%)ct0;^'FDi>TIiG7X]A*a58L2'tQgK
oGZDCPj:8U\=?LK3``!&klah-IM$We-N%IlJOK@nmu^2'.!,1Hh#S&f1r=d0Z=/Ef8o#jgq@
-s2>In[?md7Ono0aKFp#c'ItU2`Puf9PMPZ33pb88\WalGIO:b+j#\b&Df;Y2J^]A?u5^f*7b
<XPj2G9HIG\P*4cA%K*W`8hG-S6;*4=,sahN4+hC#^*V&3pNBMHIoNeHGL'3Y4()g\VI1j4H
IAt-bu-/3pNDIXu;0$!9bj`k)J3jm"ca`PkVbr=6AeFnSM?@g);C\rKRUj#8S9WNV5iu=?,N
XFO&Pr$V*iCl?Fh5[XfW'1g]AL7rHm-FWlkCIJ9/fY9Hn0ai*ojuMVUihBhM@d.1\Tj#N&3rn
4*@t,nXl9C&GS2@cWsU%Z:0sJFRhuW0/)I;E:AVJBOmSrT?dU$Y,eE!'WN$@7?7eY,+06*3/
`LK%$ME#ZF_b.;Jh[Gd`PeVbO+sa^,HCq!9mg<d@#^Uo*&a8%=U6.]A]AN9ME3ENO:8`hFe4*^
Y"f#ZJcGPu(RI<I`>.M@MiVqS3cNo1V7qN%Mnu<KrC`]A&eTXhQ@G<7P4OQuIYD2,';--N$A`
kWBD6oCNo9:=]A"%#N:O>QU6(<dMWAUHD6"'cH6#NALW<*r=]Aak\B*_]AR*6_V\<>N(peX+r9Y
PVIr4u%))2XB4\JiFF<$%j2lN$c+asLnt);o;nTmF]A<;I?4-ooI2t>."00B0l[`a/BD2sft=
V?<"n22V&nok)f/r$Znd*gHZk>"hSWPSiuquU\mn\[QQ\!Lhd3i`i_b-djs&q8frgBFFioj$
ZM:'thnHA<mnGhFMI>>Y(YS`7<Wq_pf^9g>0]A/+CS4cXtIscBrW[5(JGho3%_9Vs9;I/`5D'
I7p'a(<Z%ZHsWAb#8c5LFn0o(P"OAmJcedBb0KMZ::ES9Gl8ggHVCQs??GpkJ4F=p9f/e_iV
6uDfrUJS]AZ2np8Yrr/W1%X*Yp-lGF4Peemgu>Yk<&&"546)0S_Z7HaM(qm2k%RNns)a(`S&7
*+bCip]ARY+:G#BfGj/\.D7]A!2aD<5pHD2UJ91Qg&7kFc3)As3!I$g*$C>pQYRdR/"C.3uK:;
8"YWFZ7hos&S#OrT:XX1@1cD"mi*'nPOOFRmC>B,U6["58HI<i]An5Q2hkfl+T;l8B-GNBHof
'"^`Uk*ZHSeeo@mI[)'&@2'.]ATpTDLT+d,_l'+3+l=>jF7\H3fj9ZA!/"'/S)*DYCaO6:*_$
$U4d(4@15`(5^a95*<jO.n0XKatRjEqt!,Jc!2nuI+s-6jT%4r7M.7t=X/N_Zalc"+nB:+O#
B4KqM3g4r'(~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="5" y="76" width="356" height="222"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report0_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[!?D@'qMA$D7h#eD$31&+%7s)Y;?-[uU]A:Ap.L64Y!!$S?8LOQ="QW-B5u`*!mG1!ej?sj)iK
b6[/0'1J1X_8>8;PBu!"f5<&qhJA/-k)IUmu+p@0egn+b-MS8&eMn^N-rum.U%7?B*^Bmjm/
QEkO*[h5A^dI.ZI2O,8[KLkpB@CdqdFI<nUU6psGm6OYCU&J5Ute`h]A.*^:el+sJ5rU%9l5g
k+TdF47OBil-fl04);9n`%Ns`h,al?TpTd=[OWHl17_[CVCr=2bc\.6q$dC'<Xk!/[Cf+;5L
=Mg@N)DT0&X9;spAhXS3fcrH'V[/kB0ghHEPj>"bG[b$MYcil0ebI.),GlhTY*F%pcRY>P#W
p"02@7u4qP\Er>-!*m<YEALjmPYMXt:+j"\]A_Hi4+3O4nYP9d"_3q,[VWYd2%e<9uH\UQ23q
1TR5d[C\D5>[i+rUZD`dc$]A84s2g/jHWAFD!QF/317/3dC2SpDi)&I0'Cf(q09s"&U_bpYF<
]A^"Xh5!/I:mk>/H2\HN6=5USbnroo@2882da4E!913c@&BQUe^`?Ld(;7RmIZkX9_F5M*1'3
r-=)5a\$B1C)pYpP9pRV$jWdD%Qbu6hB<,hnCWZcDgVuR+,BbgcY,dHcD\mA/bLKoOYOT:NS
Fi$aSXV%fcU"rdEguk\+Ep!<Cah0>@GaX40_=QTKp3]A/6'W>!?Wt3LY"oI[[aQ>eKj.nS(&?
^@0nG!!'fjoRbQE<6cB)Ot!N$e=(C%Q(?)K?Mou]AUiZXg]A?L?VJ./E@c?8Vt-8e]A02SV/E'p
X%6d<N.c!<Cb3&Q;</BDIuD!!"oPlE#=O#,5nTXa0sIG/>q*R`t"u6`47[c7)h<0$i<pFSV)
%p"sE\bU<Gk4/6=;F!e4o0!]A;.*,>:jo5j&h[*H'r;?)'o?Wm\h'EEZSOZMroW@Sq3nL.De6
psacD0aY+/hO:+rRF-Wac$9$YZ"_".FD2Xk<T+KfI?(NF65O[oG'Etl'AVhHMBUh,FX*rH1g
X8rfTJBl&T1t[j;"SDulpoT,NHhJW(M(EEjs5\D1?GBWbD-V#Gel+43*8>P.srm%<nX:8q0q
):@/OB?@YO$r,Ar"ER"tePs]AAZ5kO_]A>s<2bI+_F\U:7OBp?AV)Zg!>/!*4lUZS=PVIj3h0d
Nmee<7:QSsS"a*Vm=6m4ZFJlCX)mQM+8#qRBN9!5P-[Qr9YaaK9ag!:Gn*7Pfm=WSVIr!!$8
Ts,E2%T.M(\-dS8o5Nh$0EjXnuc5WfqSSIgfl]A&iLQ7q't>M/pQrR#a:X[Aep>P.srgbI,.3
41/L88b7a6PJ!N[\IFofA?L1SgF8OaZ^/un(g_=!5OkF*[PYX::8E1R+D&2O_]Aq\X8]AL8kql
ahhla3o[J`u"TBAm^bC0f"J+#8s!!$n%P:;J.Q<*%S[]A-mH[P5S0p3O)PGUtu^.WK@V!s!9_
2Ii\A7S8`+oPPTJ!8rU%7nGXI6AX%nP0m,,!"R)E(S!6Q7Y6Z&23+Bem/[1eFQ*ohO^_\2I<
s^r)pk59GZ]A8C]AmP'PdsE#6!'j&?(l@d=f!dmDod:b]A_m,:U:+e\q!!'f#@7Fr?V;i^^#1?s
QR8Eqan4_>R0G'TrRF:<hP^^odp\FsT_r$LP*"fXH=1A51!!#SZ:.26O@"J~
]]></IM>
</FineImage>
</Background>
<Alpha alpha="1.0"/>
</Border>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[!?D@'qMA$D7h#eD$31&+%7s)Y;?-[uU]A:Ap.L64Y!!$S?8LOQ="QW-B5u`*!mG1!ej?sj)iK
b6[/0'1J1X_8>8;PBu!"f5<&qhJA/-k)IUmu+p@0egn+b-MS8&eMn^N-rum.U%7?B*^Bmjm/
QEkO*[h5A^dI.ZI2O,8[KLkpB@CdqdFI<nUU6psGm6OYCU&J5Ute`h]A.*^:el+sJ5rU%9l5g
k+TdF47OBil-fl04);9n`%Ns`h,al?TpTd=[OWHl17_[CVCr=2bc\.6q$dC'<Xk!/[Cf+;5L
=Mg@N)DT0&X9;spAhXS3fcrH'V[/kB0ghHEPj>"bG[b$MYcil0ebI.),GlhTY*F%pcRY>P#W
p"02@7u4qP\Er>-!*m<YEALjmPYMXt:+j"\]A_Hi4+3O4nYP9d"_3q,[VWYd2%e<9uH\UQ23q
1TR5d[C\D5>[i+rUZD`dc$]A84s2g/jHWAFD!QF/317/3dC2SpDi)&I0'Cf(q09s"&U_bpYF<
]A^"Xh5!/I:mk>/H2\HN6=5USbnroo@2882da4E!913c@&BQUe^`?Ld(;7RmIZkX9_F5M*1'3
r-=)5a\$B1C)pYpP9pRV$jWdD%Qbu6hB<,hnCWZcDgVuR+,BbgcY,dHcD\mA/bLKoOYOT:NS
Fi$aSXV%fcU"rdEguk\+Ep!<Cah0>@GaX40_=QTKp3]A/6'W>!?Wt3LY"oI[[aQ>eKj.nS(&?
^@0nG!!'fjoRbQE<6cB)Ot!N$e=(C%Q(?)K?Mou]AUiZXg]A?L?VJ./E@c?8Vt-8e]A02SV/E'p
X%6d<N.c!<Cb3&Q;</BDIuD!!"oPlE#=O#,5nTXa0sIG/>q*R`t"u6`47[c7)h<0$i<pFSV)
%p"sE\bU<Gk4/6=;F!e4o0!]A;.*,>:jo5j&h[*H'r;?)'o?Wm\h'EEZSOZMroW@Sq3nL.De6
psacD0aY+/hO:+rRF-Wac$9$YZ"_".FD2Xk<T+KfI?(NF65O[oG'Etl'AVhHMBUh,FX*rH1g
X8rfTJBl&T1t[j;"SDulpoT,NHhJW(M(EEjs5\D1?GBWbD-V#Gel+43*8>P.srm%<nX:8q0q
):@/OB?@YO$r,Ar"ER"tePs]AAZ5kO_]A>s<2bI+_F\U:7OBp?AV)Zg!>/!*4lUZS=PVIj3h0d
Nmee<7:QSsS"a*Vm=6m4ZFJlCX)mQM+8#qRBN9!5P-[Qr9YaaK9ag!:Gn*7Pfm=WSVIr!!$8
Ts,E2%T.M(\-dS8o5Nh$0EjXnuc5WfqSSIgfl]A&iLQ7q't>M/pQrR#a:X[Aep>P.srgbI,.3
41/L88b7a6PJ!N[\IFofA?L1SgF8OaZ^/un(g_=!5OkF*[PYX::8E1R+D&2O_]Aq\X8]AL8kql
ahhla3o[J`u"TBAm^bC0f"J+#8s!!$n%P:;J.Q<*%S[]A-mH[P5S0p3O)PGUtu^.WK@V!s!9_
2Ii\A7S8`+oPPTJ!8rU%7nGXI6AX%nP0m,,!"R)E(S!6Q7Y6Z&23+Bem/[1eFQ*ohO^_\2I<
s^r)pk59GZ]A8C]AmP'PdsE#6!'j&?(l@d=f!dmDod:b]A_m,:U:+e\q!!'f#@7Fr?V;i^^#1?s
QR8Eqan4_>R0G'TrRF:<hP^^odp\FsT_r$LP*"fXH=1A51!!#SZ:.26O@"J~
]]></IM>
</FineImage>
</Background>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1828800,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[13075920,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[企业智能运营管理平台]]></O>
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="144" foreground="-13332767"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<WPM;qJH9X_g5'><0`QQ.AUV\slmG-!IdP!m,/aS!L"C65:)(["q[MU0J/<fm53]AU8A,?,*
7&Ee07Au&d#UW.FK%V-jjEM(7.;%(]Ak"S-02AW_VKXSg1IJcPcnGPcdj374O03Pk8<5"msN0
Co8EWP)`IYKfe7SqGtn=srDetd?I.WD]AV_e+\*)]ALg%+qYK9oZ&r.A#<I'gBH6-#GT:!p(M%
igXFr?UH8d5U\QB_5)jX&EgLa#`XDIss0Hn:T?mUt]AHB^%nJUqTghlk$GGIYeTk9S[S"?Z_R
&Qq!Fq#H;hG>#Ron;OOh:'KTPK\pd8M;4$Q2$/=s0l-nVu:dk!\J\l/QRe)>Ae6#,Cba:1D3
g;>4L(L9*t00#<c._kf>#Li_CMrXQc,B(C3`@N(D-suQ//FZ/,_6Mt*it!`qq%^n!qWgq,3;
ueQN^V;#nE@=#gNDr87t*Gsd;!0Sn+K,,Y+75e\dQaUYf?b!@<cEXU:_MOB-,l0ZZsm,(2\n
gm:p,e$W<[FOgg>u0.h"aK]AX=*=95;SV*^kCBnMDn1i85d'te,@c_5OKeC/W-VtQ3R&9$6i`
[[qn*hXtD6*ikTWLl?s;-Q7'hsXs95OL4"0':]AhG(S*,Rb[G,FaC:4n\<fh#$\p5dWB>#6S!
E9c=KqTRHihKKalD2+Xtf#rf*dpHSm'3h,%T(YFsTPaW]A(Q?.sa%26R>!CHVpKfF+X8klsYm
Fp58uhE\j%:b;&GLDTsn_`O=5]Ad?Tje6CR);/o.Os8<6\ZIDH1F3<L@D5`?U+R.)6dQ?[t5!
21`&-fSk%%(->8l'I`\+jjU0lK1WVI2+<Y/p]ApS`CMNCg5]A)_-h$698r,S!$DB191lT&I3<d
aU-$c]A26]AO7U(/U"/gXue^M41r=DK&bjq4@FZ0KcEA.:!8A60;2oM*b2AfA'Z1jE^k1n?Kr&
$LPZU+Rq?Goua[Q8K/754T$c;*#4a_3"k)@B5=qC1DRq-473C-dI6^ET9['FN(@DYU<ZojVG
;IA@e:k0,CChfJ::5g1""VBP<,O%$'[KBpFY/<6I+`K5e3B-@Mq:M&(8</^R<D/+&Gc)FkVa
9Xf3';#h)l=@+I3[IC9m"@O59PGZIUr'&'9hBp5>^HgVCi+qL[7$*-$$N+&h'$(5Aj'..WCJ
j!%7#Nt7QskU+a7liQKg]AUEp?u2$c^3!+q*+6n\e/)MGkA[25L7mMCjOs]A4.f_t%f]A8o@1V,
ag3YR#Igu"eoUR&/pus=+9=A`QTC^=R;f/$*ApRn`EMP#*7iag<cg@TWY1M$4hj>'eVsjZ@m
]ASCGnt+MnQ)(p4gLo?gICA@ob*(Ai68jM[IjP!'Ar2<(J#`*TAAqn&Q`3n#DBm3_o$rDV'MS
j6l.1g(\f(^5IAj<shGslckm!0E!WL^4C1kWaor91C*6YWr+\NV^PIh!CMho5ZT2E-K3)CV:
,'93.EpIl[$gk3?obO6i"0/X1>3F1QYoGMHJjuZ_^o*,.jF#Pclil-Q\SX7CJJ^_f`K<I-E(
^urG1[*4he'BcpL#k1$a`>j$u=()Is[huel$np#JnR+;+1-@V)alcZ64cF8SkceS+2$bK%\d
mPg24F!%_oe=0Q(5.V*1r@&#]AuiuK\YWjc-:.=BL6NmHn2YqGl\V.3;"Cm*"fmm5_8=[0fil
<(%rK_EFMYn[42ONfoQlDeLomklXl4lnZ,YaEpbb'o-I]A>3O\m/%,&L*V[lVt$N2obf^PG[0
A^EbXF88KRV<>fHH\8!Yse%E(rL42QcGI^XA9;_&SO^Z2Jg[2goi7<bBEq^CMnVi<Zgbu>E'
k1!.IaQaiMcH)M#E6a3.VJlJI!eI%_I]A?nEHte4[H&[hJ*8uG-YK!TrUC/b6IcuSe8b9t+,6
8uZ=7fg/@Gi,BW\8419M3e3rmM,?S5O2/><AhT5u+kYb2Yj4butnm)bZ.e/%Odfh*!e<2Q=<
D*Oh-cH8X.;A7)AMJC]A?s=%Z/t4o*lB"AgW2%"f77i8ptQ#I0qO1i$761c%n=b?(dK)G!Zf;
''CJQ=22i4AFp_Hdul=CU)'^>M@Y*U9cK&r]A0.WUPUGsc[-EjbA*BT,0b>`STSb5g=#6]A)]AR
R[%[IR2oc)W/lp9g5dOuA@inC,Fi4JauZ7+%5:)qH5[1XpI-6TkTD8-I=*=fl1qnMP.=mQSA
OcSlZ4VP0P\%MbbIa5bIP&+F,T>Tr;ik-r!bjNg@(l`eV8HH$qL__0u32f^s(I0]A2!]AKWP,r
3K"@dm[$@o,U9f^M)PpuFJQbh#ODIBdb<3O\G@Pis<$m&\RDq#Us(Da(JTT%?ZePD'_7>>Sn
sIHu'UWQ]A6WJkHq;P07SO3LG.W&Q^^#Di?T@YapOF'YAZ`!DC\U[k%Ll__@79DTCZG6qWhoe
l:V1d*D*5#!LGS@31T#Q>^+Uk*0[V6sp?XI;B_,l`-O]AP(%n/U[b\,;?8.ud5sL`b>AV*glY
JA,nT&L2f)-o?V]AB?C3(A'hUkV7pLgjVA06"fW/IYuOQ^Y:&>&-5J%/GXZiLqD1=,&]A2s%Ju
!TbjimCTWTS3^./8[%+b0Bp6]A8"m43I8,<_#jeGkKbjR?p1Ef_5QD:\f#WD5Z`;l$FfK$%jZ
M^nhHfYKkS]A`An"U.\SCj'gOe^j.TGXWJd]A%):Du[1,c-['G+H&%fT5P:(_e#"?L6Va\&Bn_
8r9)_J]Ab6m.2L\ag1C8:TTlsLAK<;2gV*L,V+5m"7:qCO=D3SkC`pK`[?,',\[5ZTZYAFpSq
^K0VWq2J!<qVC?eegD^&]AhJE"/sZ%P^]A[GTs2jK:t%2),]Ar7u%-AJl50>K20h#US,nL0hZL\
I0o5jHD]AMLEHTFW)6nY`b.'FX:"[9j0&1k?I'KJMd+ec'6Y0roMb>,<=h7g7g!N`QU/A.,I>
g;"0VA<9qg4^)\0>mYBug"R=2@Tpfl>Tc+fTZ^;))h.PDa6*DSbj\hZbqBiXj2ii#950K!+.
=.4`,a72(.J&d?r9'VggRB7d4(]A)BE>SV>ae@Q<q?F?89iL*^I6\J<X@.;P*psT#U"2EK,4\
'X6_;"g+V;uCQUuN&m@h*a-V(J3=AE9'OSJ_B@,aVM?t@=IfgI;SW#:gX[VmY?"ihDbFB$B=
UE/0k?h1o^))+)o1JgQ%a3fL12;E9WQ)_LA-'<aQ$JN)KkBUd#$lIjJUHNR"<b=N0/]A<"#![
O$*V_NSCQH<=EW/)t(d\&D-@_PCQ""IjZaF18*huUb_A_fE6q=!=2XIep;kUQ,&!@]AF7hPg-
:OL.KYb2b<VM]ARZ1Q3uM'FDRd>Wf'^5SQSba:#!8fCW0O0oam>f,O:k4Q&;frp@FWhC]AD%\W
Wa"<(6*W$$Z(:lj]Ag[4AI1am$_,dA-2R3I43R,3]A(;V66Y]Ad]A9@W]Ai0Mo%q$Q(e_<meACZIu
@ImB/g$u9BGm?]AL@%hj3p'VT+IXG_lGA3%8oo$I^#jC=M-??T]AoHTKatb';^GjQG4jYL'nKE
R2.L;_En]A,K$[3/fqTtpO>pQ';!GF7)`Xr"K*-kmtOfYiLCP:*,Um4A-Dco/^a*[m4+>hoIW
"mU1r@;e4qHRlQG\qEd`#)q+=9rLL&u0Ah9cJ%+Xk]Ab`rRM+juXJ/P*R):aLT+&USu:Plag)
ApNW=/CUZI#L7'jEV@KckUrF!4[r?1$65Zbk]AeB_9tA:IKPJ2A_=LdPob-)JPJ+h&@,e.O5i
=("3uNo4QhX7Ppm8QN6r1Y?E=PX<hk)'MFS$JC;6%8\YS(7[gEh5.e1KKnN&2WR!\ACRHd!U
F;W^Rqc1Vr,j(T+7n>,MO=T\n>Tt[]A/>WK.mNF<Oc,_^sPK;=K6G.Gbb-"cr#qKDP[oA_:q9
BcT+Ge-[r-cq/ANX0<%=!W9'5;%.AY!c8UGJt:-,f8E:`/[lT8a7[b0'F4@3]AK'pr=5lo>SV
(^o!m(@k@4*:@T/;#bHbP?="V)<L?j5@2MDSC(/]AftkArS8B-:n^H1"EEFne,t/9/a5b-_-M
,R#jt`4W?i;s!fiiZWVXUfk'&H$o]A^KTCQm,KguXJeMAERL-6n2rP`74&]AL\lZm2/SVe_paO
Z*B1jge>C(XWQA+;O+9a:c4jaQoQ/W9(<)nPr&.D_a9\^G+fNd0#U8iWN#n]AA1[,s'_"4!lO
V(=kh`^o7Z=o=:+H>ZM:YfWnd[/*IjI=+T`/->%rHB54*-l1a-ZVakqJrDuEAM1WEN<kXQnM
g!@D%Q:;#&'d<lKpH3!O1M$qXsGf9mP)I;3=JO.Htf^\PCW5idH$e]Ag:)D>o=,Jd2AJ8IV-)
$)'[nc8("/(oouG2grL]AF/Olf,beW7bIN]AI#Wd+a@9n0'P-\*D:+qaJ:5OoftU[$V&@q+V<\
:"Ag?o/A[)(8g!RN/>%tc(LnUV@o`+gY6m_?DVeUk2J<2Qok$PlDpba$l.]AndKtL`s"F19>M
l^8f%f:bGeZVJpZk4@XQ71L?[5mTXTmK^JL#apBdL>:4]A&$g%"u1[2Ol_RbX6k,SW$0XKLp%
C8Fs!2HHcW&V/<5XDG#C._apEc[P(cq=ut=..JO\-kVSn[dAd)^j\0iCkp:oQ7Rs<"dIl=HT
cA5S#$&tRHejok']AfmB0+5]A!UH9sp)*m.uJGpO>b&3(nBB,8dNVF7VZ^1R="@3QQbV.`PR9q
l`Qd#U"LZ7f;>CGnGg/SPmM6:B+#h-&uc-PRA^-aLXmDU$]AQ]A`%Cq2ALc(*E($]A>rcoi&W#-
K"Dn+(@sOD-i,iTpt`c;gbPsMAqupnYBZ=HrK*K3>JSaA;T]Ap-SWHi#&&<0;k(VSU>K;#Ja3
>Se=VqsV4Je,&BA$idCFO,#Y[eR/JYCh_>oN7j>)Pg<*8Hr5+Li)ONEu\M^1->#ZRH=3T:31
lr7nY,lcToH7g3qX_HNUg9Q:URaka&3mU;e"W<'/`Y,Y0L*PKTh<cb#O]A]A^?#J9`&1T#OdjZ
La-3j_p]AI3G?OUTUoU1*GYnf:U=KmNudHaikSqf`%6]AIK=.PZT9pY-%5blnq#[o:^DrH'E\h
a*l:!a!-i9CTRV`P:1/C;VDH%rrggEMU4f1gik87N?9SI@pA,b5QUn@mT'Q!lACDiS[EWLs7
0a?KePEVN*Yk)<F6[:-,M1Ul!5PC'CLp@6C6ogNTU/)s0Eg(m8%]Aj0=o!d$&LXc!&[7hpd?^
tq_Ohn[fdPCLQkJb,b[?8M@oKn_l-k+@JLLCq-:AFVhi(WtHF<QMpm6#J>qdpG-aHR]Ahm"qc
u`R,WTc9UiITa?DG2Du,Jq9Mn<MIj^c.Wj!j>o/@7pIC58).]A]A;kVW70ULpo=./DLT7N9p-i
S]A4&lilV2Nd=Se2`lL0h1lT>`L?NL7XCNIUVeFW-O2cnlnJXm;6-b^Fu#,,$nbpo$^s[MHA8
0O:/XVWa0PR82E,M>B$h-rD'8b1p0".'9QUbPjk.'mVG%g&S7l(R1VuE(>sE;O?())5Vi<Hq
PD!9uXk4HFUMmqh6X<tNe3]AdV+)-a#RJoc"jo;fh$2:p5J%jp'A"@kn^cH@33>gi)TVB3qN+
7dg<t^uBa$$SuA_:f$?(lR*,ZlkZICl!0D-KS*r^Sc)\]Apk.<LI+YV;jANVtQbOFsU#Z%Cpu
I!kBO2A]AHR0^5I8.ZsCr$St):V\Eq]Au>M%mIo5?\iZQA*jHuj:1j_U!Kp8>*9hq6nmNBVoI?
o]A6,fI.A^Is\ZVN?4/P10Qp"PPH:W`Q&Lkgp:jSkE,&20=]AL/bDQIL2jfro=R$X/gnQlob?H
6+YDJSsRHnGSCbTG]AADthae#-LYnSCLuZrDhXlLQHo0o>3trj!]AJYN0\=;_O[,niGXcH%TV&
=&j`9?N2s-pd?;VYn%;QeBsbO(B#8DJ,_%[L`c&ac+c.Xj#K-CUSl*FI7$lUFH9KW^XGM!Ed
70'6>Gd%..K>_]Ak;;uR9Qj^Ja=DP)KtafS`eCiOgg9aYLS%B7j!C[^^\kYEtD'o"qkHuZXDW
GS)<dqd'@1IL6@%MRm7=oZ,BIq5,mt8rrqQ.nMbco-T0*pZB2c37(4bUSQ[^o`]AfjSC%:p5-
Mqc&J_0cL*GfG^F0-VE/F6sOSeQRaKi.HNbK(h&B/J5s,!rS<G5n,+$h2C34jTWCb`gh2!me
sucgrhQ.qsq6-]Amj)ZR^=aKF[Nje0=f7PVYA6j<;>_+K0*Q=bSi((l]AAPL,J!<4oFPu`L_-_
P]AMW,ncY>D*LNbFJSBV'G8pdRg4b3i^QL+-(SQ4t09D]AhY)A1;HYO_E1EbO!I3>7Z=]Ag2>Z%
!ia!7Nt@'oqe#UVA^I5+t[C3(=8s=,^>Zl5CkZ:!;)!J"eN%[Of&[QqBp1Ka@>@>6o\Q(o:C
a]A9%4SjXB20H2b"*OFN=s03B3UCVJ;kd.;2A,/$lraQIbOm5L%fc-k-@RLL&">4rVQ4@GYXr
Po^a^[XVlBq?Yc.F:!eL"Ber>jHW1LW`Pfa?/J(^nca-^>=fB!?a]A1Z6[MA/,*Cf&j6:V$.K
@)>:-(0-3<;n)m_O+N&J)DlR.d!e@0)>@u@p$'\sLl;VB>D,b_SN&pM$Zl#W*Ps$l7+a:MCH
=joX#$@\?`:2l\#f:XsLi0-*?k.WK2Y99oT3m_mS549pB,9p'/heGP8Io=>U?`.6F&VpfEjN
4kli]A4!i;:(P.<_XUkHXE.sJgVXtmrmUOYC,t4G@X(/FC9P)^bIE10";&<[q)t>aNDUJ/&gu
aDM>SNM)(=TRSXZm$,h>p=DsOcJBUZOP9<@%L&lGaZl`\&<%'2lm6)Xu32tZp:VccN36?'@O
V?I0MfKfo/FSnTpRIF_d;ED1,q'd+9"MpOS-XRqEi*IEd[K#e5tM^BfK2B4%4mBpcRhR!-)"
#Q^jP_Ra%0P<U>>WE-o"N5ql^1[oF`1)84<8=qXC)^`Udd16nEsjDH?@N`0UDdLln+s^'W@1
J+8Je;UIeh?_3q_EBrasL`;CIIY=/4R_X4*!>phiK@[rQ'-4eAr98oj&ZQV0U&eJdpWVcfL^
g?ikT3tDI=P-/D%%M&>(e(a8s,SHXXt`8WUMGi:l^%oR8laLNX294Ued`-W%gfF/WN>8GFk4
$cQkA9Oa`*R/!ZmIaXEu@CXf:P4-YH)aBR[FncPIrY9tbiC_fVN$FNiRgi\;AhaV$sl^LAY-
[#>sJQ<Rla7j,N#1&tK\,Q'<c/$8>SDoO/f:nT%[&,oT,LF"lG[-#?3mu+h*Un#i'b[5_G+O
(/;HRKXG?O`HYLNn(gOA;U'4L_s$.FAnYGq=f`ZKkU+hU`7`mm..B-u'Yf9c$;qMANJTjuS,
lc\f]A,8L44L0se:(]AE.kpZ&$p`&UOV6"iBXiRh[)"t$_(!ZnhT;+[a+?#!K5J1aJ`HUC9WC/
JB/,KrN(H%^@U1`C)BX!49;A[T`B'6kdi2.i,ep[H#@CsO&<M62i1gfL+DJG>T9;%Fc&.e*O
#MGh,T&''X^9@<2-o=6u]A'=mMp]AWW)>TKE7&Ls:8%nnEu%'GVj,m!^-N-iNkeH!!CiQKoJTP
_aZ6^B=bbkI>?3Tp4(U22nnAf2@)&jlP[&E;mk$2^0&7MQ%Ub@uF_N^=qs7ZQ,YuDccW,$D(
aeN=-hEOpQ`fZIA;<ODrS\>rpY]AC!FQ9,hi<!EBHiIX(*u+.gRcFb+.ckF=q[Fa1argMViY^
/UGS%LB'GV9ZUebA`R>^f=ON-Vrshg=CjoL88S#p[&[J>ENk'QR"n/?b'B5lk1'dVVJ#&J]A6
e#;LEBY%Vl!sEVUapRYDr&&9'2AHI^\^VTmKANJlf"`O(?;=*I=R9d@dBq76g?Pb)W14$*tr
JQb-BB*;ip!&4==VJNT[g\g;NJh,>+/RXPR#o,0=[3_B2*(aDfTS_[T_/pUifZJp/>V`HJW*
2/=n<RA(iYeY=L^F9(mZo/bl,N%/C;\f)50!DnWSp0E[<@FcMPVD=&G<MV[:(s4)WiOX%kMc
'nG[=qE9j/s#%ogF!&XqYZKATi4WRWm1GnY[TYUE[,Oha_WIJ:f-B5he=9Wo>M^SL-fpY%iZ
*(T@$+.?-Hc@T^n:k9UgNjA*DQ+AcM0lIFu,XV'ma>&s@'QZ]A!3!@q,/$hD-ARO>5He6M/Y1
IsFkSC[t)dAt`B3t?/o)fMYmg_KV*bEp"L4/!fhD92c3S_&B"'(%a`\$WhB?inCmuJR,;b^A
FHo^<97t,OdX=geA)Z/I;a)PX[?,W5f2l(J',q<FqY7A%a@<ZS`pfHVW3)[R1Gt5ANrglt0+
MWSp/fK!+q("65OR1esaiXnNTE*6,)=APs:b8P,UH9,G?g@MN;S&*#C[=6KR7!UNl]A:BNX1A
:BTU_sKpk*Dmf1^!in@Ra`\@BQVg3$#bopju;dIO!-XBQV8L<8PeLV/TPG(8BLqoX[Mp\fm1
8X+`Ybp8&>f?Z8QAqqi!!-TJ%cFL%uisp3"Cko/9mf6+nh32u7-NZ:XTLeik.2Jq;Q#W?b.@
9R,Nj/6>8N$aXqm6>f"qcad_0*Y*SMl!-2ujQ%.#?FqE=.g=<(bD%D:[]AN%AKaY+Qu\e>M?1
RLEC>$'Wd.k\M3.Wf\?e>3?RCXMr,Zrb`?>a[k4$67JDaV\\m$Th(XDur8!1KCip9C$S="pd
Z]AqR'MdY8R`Gaci-<CNQ%mS)M,9up+FR2#@[5.GeQ*hL,&nZ!0^j-ERMHl-U'"5M-0\WOjZ@
'#3i=T<44#au]AiH;#3CLqq?njX7I`s'*7\K]AaAN+Ta"7unAItXuCm*%t[[#+\nFl%L^W&tZS
N"Y+?Af3r2,E!K'8K3"4,*T/8EJ"E\Lg9a;E%-juha]At-]A#e3&0PGRLk%qE>OSI93$g:`G'G
9D.:$.RX)5lgY-^%?=5afKAU)?Hu]A0)@_;Om'@HqAjl*N89AKjZ(0q#Ea^l:m_@hZh#k72DD
i`&,XCYnJb.rlm70oU>=rUDb:ub/Nh3!Gdci5=Pin>@7rJGlm4i#m0puZ23c)Wt`%F$3lt#!
Gl0O")%Kjq-Ea)K(UW>\0E@f-+;qb6m;Q'dnNZWB)`FCU7t3K?4I^]A4desCJ$Hki'd-jMkt<
J;7rJm\+^*sZOp%"JOskDE^Mj,Q79JPj``oFh1s^J`,4^RMG,d53Os+TOI5\:cABL15J&rQ#
WK'Hl23tpG:&K/9kJA<*@d,b]AH7V@.^IR,d0K;@^\FDYC&\+^Ro99;[Y<;lfNe/#+.RFnDKm
"ER:k(HG?TLO.l&>$=B=l'ie;JuV>-jsI>.Frnhnm5EdGA+81:+UcfGYZcilq,,2@`n+ade&
N=iWq-4$S/Aq0rf6s*gp0iS_<+f%8,)/bJ_7que)"*'q;Q_Ve,3eS=0J'R_0rC@;Wc,R#E<P
JsEab#b/l_0Yl1_Mpj6LqVi*&H,<n+RcQK/UR2`fM(phs*X=mg/SsGh>Gt+!!~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="959" height="52"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[ja6efPjeY@4U,%^7<XQ!$SD(clkP6@CR1'LahE`PmBXDO=qFPA*@:S<PDTp7I2t1ZloS_NF-
#28chDh53WHqc_`Z.+fBZUHce%`8?.X3H?El9GjV$MR!.`\<gt2f2p7]A;%DfW(7T1O7Rmf5U
oh88sBeYo#"WT^jmZ`hs2>?;md^KYTsEEA\'4l>9mD>Q=H*`4"(c;qS8D`N*!hno;b!+4ZK=
+t>_aP2KKiKj#^TU$Mn#3SNY^<,i?'m8!SX`]AH=c/-e\I[Y^/^#,E*IacR*>YTi"4qG?`Hh-
?&!]AB6h+h$r1&JY#d+"DCjG(jp4n%n+6s8=V[mL60Z<YPB!-f7-06p^hDmALcWs2X$p+]A3=,
C7,%sm!i>:j_!Cs*3l@">X3EH!!)%C@[BEPl^qD1^2JIR*>nV!j"<-\*dqa,DJ))SBq7I_b3
`M".)]AchAY9iP&D%[R.k%pZpUap=`K'UM6nie?<mYs2Kc4k4"qF@l%:=1u/t_jp^)jd`+#B%
I>Bd&mpAJ_upA;@bd7:O:*EQ$KlSQW+:\JE`rMGhX_'aL,o9W:__h($Dc`?trf6?\;-?U_"F
&@p1^&Gt3kHj@gl%Od0>[=o[(G?H\4mQCI4lCF`s7&p@]Addf&=-9Cdbk1DXS'fuQ3d@^\bLY
cZ6\I2pR,Rct)k&1GG2D()XW+[N5hJ;=Z&`iAKDB\$l8_8BNCE[V10Y_BE;@j<3?qqH)Z<GI
BOg2q05J&%W5lVX.VJId*E7DuUW=aNgL@_LTE"u&:9d\se(9ShYjlu1*FL<"F!%p!b6Aq4F1
#(_Qb@g^de%fVG?.ON:O(jkJJUg0P`"b\+C9Y'd_.)8or;2b'2+[lg&t0RIcEel$lJ2ae&oa
JCd@u&q3(=$G7H,cZ\"p$`H`0QA0)Hp:KN^u5dYPAI?X9@"lsT/?^(X6]AVi[<kOT<@i6#moU
M4)01Gfe"UO.#_N-`&$>b)_qg[>i39D-Q^!8ooo'Ja)'(&t.j`Gp*`0d#.i#JX4?JDp%BD_D
En_7ItCiAhiKqtD(IY$8hJk!J<a]A7#&h3:6<uYfff=lJ3SO:\lfB*hEA)c)oMP1@nhS91=2G
^]AN0VDQ*(_df"'q]APJ>`8@r=80p;W[S/>%G\H,Z'FQ(\hjiSOSAi?^S>q3F8ARthKTUtWoQZ
DXB5I`s3_1Xo<qjmgNJ0DbS2>UrCK$2:[IXTP<q=G6RKVVuHK"@6.*3erhVOJM_V;t&3gg_"
rku,q/gMO4YKaK!*p%"d(4pqXH&r$Ym^g.V3n5&Me*QuOr5jbs7FslHo[NQo>dhb?Q_3f6'D
l`jb4X13MS*W]An*5F.u+#hX,N'*<q;p^,SdoUrZdSE<Xb.ef8R-Mt\D1mm261ZYe,Mf5WgF,
R]A+%KgG_qaPEBTulPdI#6f#X9P.Y&E<rI!bRb?WHR_O"XWBZ5jekZoJb06eB#_fG`6"d,)d3
]A$onIA\I2-1SlMNO^?LQ`D]A"a^<DE32C3Q\?fUNn$t2?so?;WO<:'P^rm9Nfl)I8>Bs66'9&
7-4i1EV1p+&^gcgf>)5kD[CXu9VE\#a6tg2;uS!<4<@M*ROE3pbmf`s_8O)$7Q8L(A<H5L2n
%cFVdg<mRc"gmMUf2kV3hiDZ4aB@Ygo\l+N6n/qFnc76M`gQZYuSZR!hKiZ#5N/%<BU;V8A.
clO.g!lS3n6PRq3jn.U6q*n>.BiI5$_^,q^WT3&#kCTg),CVb*"<_MW6/n<1]A>[*db-sl9`O
cPG`Zf"L#HXE_^t8Pb1//'V`Xo^P%;7QZ0nN?<9Vbu=RW?Dn,kjY+mJE`AgBV*+(mJ<2qCLA
IU;B]A`+<lF=nj<R<Grd[qpI/;*T`;mA67+\5*u=X1q7.uMjPn\Qml=#5L!Zi+_sP/Z)$n-\*
,PE;"_oa=r<NE,Zp&N;iAh=44ZK*HM4)T!@)@AU!7J=2T)HX,+@AhZuMnbZ=kG$;GscY6n%9
rWF7pg65q^XUbj^uIV3uB<99j;PR_HOUt9^64RjJS@pLlAML>#17/-0n]AsD-Jas.5a'%!Iu&
IRaJ^H$_/]A22'RXH-EohlP^\-9"?iD3Pg7cgTW`#ObuT*mWjt6u*kPd4c-c-Lb0L;)06lfZ'
kpbub7/%E)>27tK!ojTk/[?C.hi%MA74!%Y?fS<b7@=(*ItC+YKbM7fS>AjrOG?J>m7\JrVB
bme0:GI8>OK>Nt#$Pm*>5l5*Q\oX#;`p"eS#FmE:eae4&nn2b4pRI!t@-*+o;.g:&qde8u7K
caJ3>)<o.=4UV&VV6n?R5()A\Fsa8sPOA.FAr@<a*]Aq%C>NMA'/>=pm.0>/GI%=Ra=`/6[Lr
Iok9qVSSpk.;bBAQ3$\=^%Q,lfm!pJu[eiN8LkWAB>a:;J]Ao`3Oo4jq'EP+@0bf?XXjd'_n2
9kPQ8t0n9`t5]AdnW]APJM=SH5.GEO[mdCN6^.>X#^:t.V(VeU/s2JiYQ"\rkafZ5nO5"N:COJ
(I]Apa&AB:md(Bj[P>Wp-LGTXP8<']A1(%FK;\Dojq,cdK_sCr.=Nqqim^SRnR-t@\[7>L=`Vo
%'R^f:KKl0YV2/'D+#`6Cc&M5P"1bZU,!g#![1u"5BZ$YS(c]A"GMUgO4f?GEc`$2HlklU6f*
7gkqu_=2="u.PBSZ->$m;V?#[>FQ*uP\b*&Ni&AuYW*'m;bc3+Ppl,d&:W;YYgZeu_R_!?2=
\OW(MG,=2:UcI=!c4=uK]Ah/qer'Tk:+MQ39GmI,n,6.n@>Pi9Or@cGf`=S*Q<PN(e/nq\,T9
aN$mJ%!tD)PILl?QaWbrnc(U23PIJ0#UXF!gPHSFr*!h+2p#]Abd&#282Gr_]ALIkZb&K3mq98
iFH@htFOC`2EgFO#D]A(%Xf75Y5>i8UKQ0Au*HQ?AV/h\Jqa96CqBVghjm9eDq0Tg/h5mj\AD
E&$K;BYEH'+1fh?/q+N/_TP<p]AfJfS9dFs<-^LW+)mDLMKUR&'7SIord]AF&-.(fY-pcHO^B5
%?GI7+P<DIN,l!-kC-`LRBY`O2=nLD;OaOF6tP16n0$"aI-7fE1aO'C8h6mP]A-_LCd`dMkXt
#:2E%U#A!]Ag2[:/$>6jt$Z*e$AB*CKO!EfM:`K_a$:6_)[pH75=Fd9]A5Ok2aVQjJ4@W,lUCB
\fD2X()dNp!!6,G]A[tI7*"4OQ7@#tSN%l%47$EM(Pd.C!]Au4)+j6P3B*H`)_#qP*nE]A^lY@%
#b/jZ4\G>Th,nV[kapNqLQfLElo&OuD1)LLUZ/@oM@n6a2ZE"3IdK'k"kkC.T>JLfn(_XSQ8
Y!T4;XJ+,d?L1UFPmc!5WJ;!a_pNiVE\LL-*2<7kQIFna;[!%(;Xa0j9'T\e6b<oP2EPj0$a
$.).tWO:Dq_?fA3!qG`LhD`j:"Oice[=*K)o#8N.rDH)M<2+R?KoDF"WgE7%s*67,O!87:bl
V1H`l<W*3L)6cR34eD95cNE?b9(cB<D`.^5C8)*V1Z'B5d5N@J!h'G:N8"YS6^13(1/KpPgY
6i?V2#5($WZ%pNK1&_GV%r5A&(YEf6J=MJj<j/d:U81:1G_[TQB:sW2YQdl&^S5Kbd:I%.>;
H$+A:kPCYR"UNkUW0EHqip;&\E)U<.tK$iL1)?/Ob)+XMN*`FGgh$G6X?VZGCQH<mY\``ZE?
#(<0c7P3EKoOfR>*qHVihY?Y!d4`QVZ,-eI97)MB<8d<Mq(L.,"O$m11DMrlLQRO&.2[*D)&
CmA;JRL-GuHZA:Y6A;UG>6.S(A[\=&"ph(7A@jEi3Tn#XbXt.3lYi%6NbS+NHK#.$2$b3jYR
!GZ@%,1nuWZ.ZL(-)-I+fC\al.s13KM2\3?>$^`Ij*=O^+>+N8PqqM$]Aq&b^&<;EJLLRgQH5
*Mb>Pe&[.7$4\Wp<VU$FZoUJ5Qg&mKajI@=S;:bFiY>[W8DDk-iQfU<'W9M"'Xi253hKFRf_
F#80]A^5iOBSXUZjX@:k:=#ip6=FjGo)'=RF'"h[Kh+5qj!M9tZghl,WU8Un#`60'#+(7uq\Q
)sfA;'<-h@^psZhDsf9n2[sj4&f*3W1@!lD=kU2iD4Nb)%'g\UdQT8(d=7T:Op!EqY-1CMe,
Og+F4NKtn_WlfAg07GDAr&"r)FB/[GC:;0>H1G)1#:\Ra6R#A8?Q),]AAGX\#W7l2m8%()r1@
AQfG_o3h4-:A=^fm>nr`aon[`r?QH$^DeKoDUCMK04:H\=qtc5+(2oSlR+T3[!iYZ+lparBT
.8T]A]AU<=dA@-e&m07)9-MVIi%\0RE[Uf<;2oGAIYA8gcRr7E.MCO-BEjG;gLMWd/rPeGlT^Q
S-_:;K:,0D39_r<'$#'k)E?V[br#=FZm!o;+N;b+6'Orq(L+*7AQLg1]A0T%@!$[8gA]AChq\J
EO2eL6o\_IIt7P\?=Z)FP,$V\/<gIMV_I]A.AhHe__&KMm16VA;>@LR-5g"fA\**dq/+?oed]A
pt'AO.1>&.RX-QdYLt+ZluTZj-(%['&!HGJ$4ZfOdcTQcjhIe9FI?PWlf*dN`t",fmKCs5sn
c_$XC7Zf,n98S)T5jQ\GdPs]AN5T)&Z'oR]A9#5EOALKe\AMQV[(>Z%$nQ1\XjjVRc-[OoFat"
3)Q^j<;h4@Hj1<@8t_*f&IDE5=mpM+5/mIr80_>6H[\PYn\BO(LJ6"k)#GroEKV[7*FKS+1X
XcTq0W^f:9bH>fh/q,P$Hd1*K$2->;"gF1EU\EW;`*"[[0>D4k]Ah^rtE54u11&[2$^ChB3i&
M!IFR9(`'JnYTOYMf`sD)<#\Upe[T4+L&@^f-gJQ$FVB^Hoh]AKoiV99`2Qr#_3W1@6`:5D^#
SiW,S!C-c]A/k;EadY<0..edM!oF[`G*$jEmBoYI:-EO9>]A5:ZRr-X#G*0VoU_pun,ZkKm<19
'Ucjpl;0H#sl*Jjf6DujAMtC8^KES@IF==;bMi=0#F*_K69f`;7G,fdD<rL.iLd+NMa?\mNf
5*=U$mpR2C;Ynh(C$uel;F5hSbO*h>d?XH):n8q#\/<6GDm^sA1@0R9>:57DSPXrMQpRBDX>
[1D\H0s8r]A0hI>):>X(KYT7o@jf%m$SnB3C;>^[ke[@\5]A6*3ZP[/>NR^Ekh>eZSTSgSN8:i
-C(p1<J)m0!k(A_,Z-Ds*>*E<SG%\/e5JW'\%@iCm6E\#%?-G:koV-tNqN[@N%Ut*g,?!bkc
T=EHu[H'7iKo%YpT*Y]A29sZli"9d'[*ZE<.(CZk:4V2+&0;3hAhX/PG!;LVBFH#plT_rQQPc
'DbT$"%Xun0\*\5-]AW0RN2An"II=kEt4+q__i<l&"5HPc/,>RT`^pHM!ggmXf/.^*7R8(W4Z
@j@?91<&-;3S_>UT#dVLJTke0qpW]AWjUQ\E0)t8cF;hk%%af@0oppH9g-bS5;%U=*_%Weo78
S8$T-.n.k0!t+M/[!:,`%GQ6@:/-a%Nk/NiflP8,gA4HhMJ6_Yn^Sql:&"QbdC%>>:dN(u)9
0F1cAhtb]AfSU68G5mDhm0)"ti75jjfa>4*OhV&UoCcLB-)=:3Jf1;1J+Vpj/h:?O9K7Gr;#0
+;d?<hli,X(FDDUt)c3o)!^<Cs!Grr$uN%-_T890V>2V!PFJrRWc*,`RoFLccKahmBjII;u=
,rhQ:4oVgQ&QYF&!UptGnBl4-S%lW1O9b@)Cb@KT(D1oq\iW5GK%D*`]A9kYpi27P3;BgoVR"
e>;YHp7:Rj&!KD6c5<!Wb+TtOBZF+;"`p.\j=bMMT^%aO1<hf=/Fa,6u7Z/Hj\:TUU'USopI
&!cmgcqRqcJ.=%N:!<q[j/;p2uh<_!Zt@Tg(sZ!!&.&4P9`9Re]A^l-EC5G`=:<A=X$%l5e4c
Y>?da[PAWhH.b.44Z4T!isCF'aa+-/T66@Hr*r>KpSgn\%7CNGX;(C[BB'93a5,dT[4/Gt8`
:7hG]ApYB[Tf"KCc^/^<p'Uf2r%pZ7JpP0OG9m\4UK\@\3Ds\3nKP%%@eDHW3M!*bNKBU=bpS
bFCGZ$C9"Z`F,$::]AfX%P8$s&_[M.I,*;!Grn9HY!0:QNI<U/(XGofhA<H@=P]AO<&7&u[k!S
EL4$Ygn5l'E1q_^@$%?T4.8)rS9>!2?K1;S+f9"\[s_eDJoSnpAco`iN0/Va,Op,Q[O@U2*E
Qbq&5L8l5cE)dsZffL-@h=^Zb9TpOklbg`MCbR7:oZ2G?XG`(7gb2fRp(]AoRH]A2i-Yb4-]A7=
'"-0RFEk(TEBHsD+2g`F@S;/TF%a^tNRRPZCGr[+!<+(45jmc.h<"ikWNn)4"t:]Aa=b+uI_u
!gCk)`#N@Q'0Dk]ATFK6+d9GD2g-*W#7[:&i,=mDr4P7Zd]A>F4bbTQiKsqSd<N`I@!g^'$@![
nEmm5,;sYj8dRr#E!EnUYNqC:ud7LJ*A>^9f/YY2hJ/4l*'i/H9`6%0k<G\bu/nj?Z9!HUb<
C"\q_s-AsLh#'.es[Y&.i.n^X`P-tehr4%Ht@*kZ'5G2)#MMf8ZKH3GC@srrWHPu@=9STC3(
i^45rta;;BI`=dCK!1+K9k5&Ku.IrCSMh<*'I%)`HON.-TImHe>m:N,;I)q[96UEm3G)j#Pj
G>G`&roo7ahC0F27a5r`os&KBZG8K[bdQ.G?#"e3q7\t3U79"?`n9cr5PWQZrj$69=4$<()b
s=[]Aem?]A4f5O`VugsEY]A/0_[B\'J!&hN9e\B),I<h<EQ$.D++D\dKhXSq<n]Alp(Uurn6\F`5
<%X.Pc!GTgW([VAHe>R"QLuu$q-NW8j4Qqk7I^Zj2Bd@P-`_r_ZYWt3BG%@A%?DA"Xm,Yd,R
)dc_<(;0*3Z$@6UNuc`2OnpPooO`>)LX*Rp,fiR%!#:+/^1b0<%?TW@og>bA@g8<jpE0]Aj]Ab
9Hq(*Y^\8SQlgT*=DFI_;j^Lg#ba)l,.)FjHmY:]A$fge(*&LPM/$cM1<amYd_Z:k&kNf/36a
s/d>j9:Tb#5>[uSIe,uu%#jXi+-N*4+atJ`>hChPI`ZITcF="YU433-`?Ag`J7&ju;gj7_$]A
?E^WH)H:CRu>HW59.R[<f<EfWm[Ra]Ad6;%Q>j'i%L$sSI#Sr8GY;ba!3t,E9V9eJ27pln7DO
[R!.c!ME>]AT3Mdc-XdXJd\k<!jPEEo$;<>Cn9B,UR2>L'<5%8HkNH1p@cAW*'k@>]A_l8LP/C
tm:pn_O.\<bAcaB$r`1O4lb[I@Th^g4;NST@iI=r<m&SUT=5Da"+'0r*J1n/+qM*LBp%:rRJ
=2[j/*@7UkB^XR0`+,<tM\VU#"jWp9(]AVjAEiKAApc`L*Jlj]AI1e0Z(+,-2=Ro1aj!4A]ARm=
)^'"JS+1Uhq`QRS;@1IE?"HZ1`SVYkD[2U-QDfWX^eIn/j$H#Pi:65(nH":S[-Do+K<.MAF6
Ce[-_J3IOi+-(2gSO'6:cn.4(t=%)OEd\3s5%cCL8-"SpHpE19NpX?B:=)0016R)W>\E$-7A
s2]A=OU(5_$0J?21q)0qK7((rL6""flj,$Hk*le)?WY)HDlr[@`V;CL=T@0?'b7c@q=XoO#;"
Grnhe"G>JI[#s6-$!n/m#q^t/8qjtN^Q)__'!]A#f2GO5Xpm#*m_mX"i2#f`-UsdX+RX3ojM*
VN<$9gG-5-k:UL.IkE9[`\n<Hl!VB7R*"77*pNOlG]AJDPuH1l^7^/]A&R>ktQArI)WIY@$9@g
WZSd\:ZRf`\/BRK4SXb>b8Y_KYoMcu-2%JK.et$OA)-\-3t/rd\rZ/ejlrVBWY3`EncXJPIO
jg<fQ1D[0V(\9MA-Z6415#tmS#"m_qIV(c]AjqE0gieA@?_#9^K)jrW@QE9#k\mtC"fohSK2n
"^,[0s0h:td3nKNuZo]AF_C/QZ!YW+]Aa:l)c#14pBWTYo'ab%cA3!?mFuJW.a^Ctafe!%[?k'
dPXh.=a/bMc6lcY;9Ck$c8aRJ"Dpu_:Jf`&ft[cTcrO-aB05QcL]A]A7?mY"l--O#slE<7O_Ch
pu,^:\Aa%Ftg^%lq7MAJ@gfXbI*$`k1AU^!.L/6..'X+&NJfYX.KM-oEL><l>P=B?'Aln+sN
[["Vck&i!!N3Nso'HVaZZT_n,[o(O]A$&NE/5F3@qO&(0&cA@=;([e3SjghUgEl[b1G+Nm./`
H3'CdX$=$W:mog9PuM2<)DWW#+N%+>3F4\3(=$*jiWeMGQ%5G._+e^ldroP"-C]A9D-M:]Asoo
AW+jd(j4F.MM([&)pZqC[`4JH453EW#7OGdJ?sT^\[i@B(=;&8n.b&i?YT*-N,+L@a&9kJjX
o'(cn'3PnUm6GG!JMu/cHYb#$qpp.lg<8K?X"X>S*WsCRTNncG`G:,o<_3sD($=[fGjl#XRj
q5f[E:#Zc1c*g6&qnA?_S1KhTSN26BbkJscFI$LaPA\[2B0.QqjP#ds[8;#F%oY_W8UR@T&C
i^VSc'K'6G2ADL39Dk;VRBN5+Xor!'GD80D]A744>pJO^A55Mh,\?L02aHeiWaC:'0Yje')Z%
S'*ML-NjokQR"+=/HHo_k?c)m&bTr;&:1HKjK.O[Vfho1o7S!NGI[_$SV]An@r2B[bK1b^hEQ
g,F,O*,"S;=[f@nQ[sJCdb>!WpV0N=@p9W%4S?eRo'JN0_,V4?0eU0Ju6PBFLXJ'*G\Xg2-<
f@F4E?.XCT!\'eY15m$q=.kij86ttqkJE"VM"4inQ'8(F_7<6Mh&6ch8E>7G:IFNGud`Zpri
c)iPG/BM</^Xe=@sg0fWIqXi@Z4\f+^:<`p5/,P3i\7Q]AcqK]A=ii@JhD^oS9(;=s\AC&M;cU
hR6D,PM+so,Mb[7`5msBf4Z]A>#FmX*.&t'"ql!8:l-QHZ=23`'DhBTlm,nhZbZ5tTnWlW&a<
i`=@.<"(n:\+XY`Z-\\Lej$**B=FkOUD4jH[`F1B>h-@B.1Z.r8')=i_^n$@9C\F6?<9]AK\c
a>kcc=QBdMBkI0GkMdCup<cTiNV80kH'mo2eJe)q;`,bI8b%5=L#EUfNfPQU._qNAfC!lh's
*a6Qn%iZW`e!;5dao>(p;t`tTAGP^8@nNb21>b&SbdV'fD;K\"&1r'4Ff`(!]Anj9[&%RHb0$
)i\BFO10AO=aXaAU1PH=bD.*A`]A[Sh8c<aTID]Aa8CG!%.HL?h"j:9F6*Tn?GJ^KSe-8-@9IK
Pl@r5(R5TSda+SPni)aS`,K8[.6UOLdd[N>G@IaG-F`_\\N,8edFN?t6YXTYG!@mLPPb:F2_
m`LN%)/DEtTE&8=(28Wgl:'4[t&-H[qV:S'Xm?)'(6N4(9@`KVLlo<;7S#$CX9d0u<Hj^r.6
\bT;8^8)ME.38ZlkQdI[!'d+FmP69RBL7/SKSuud-%&nFoGq%-0TN0M)[m[X8*)ihOVOk;jo
@iROln^_=]A\)<M'eQj)0OXp.c,*>6k!+S3+i)91GYQ$.`XZ^qXX+)9T&#p3^b-eP)Nhm-p%@
<*%=?4\jl^-!0<#OFI^0CZc*##L;GpF\+e^j4efnr^HM59Rh`d'K/8uV1Xq7mRD<j8V7`26T
4/LY"G$(\j>dWO7U;t9cjD2HkWM\W/-g`A['Qa*b+/>Hp'#+U.P1',g#L$IOrp1/*[$NoT6l
S)@4FNfuCT;4]A?*B22f636SSb&g3lmO$k$U?4*4MC#Lg;i,Rmdo*d=%tg^jC[$Ir='78!SoV
(?g830C7ke,modPEookJ4,Dk&3qio$BY3F?6L\SV[%5[)%NcYT$c4Xig5"g3nE/[.fQLm%0/
18qa>T<:>[FbgiV,+6]AkLC^4,caXA66**eVl"J25_G-R^,'YU%G`I1!nkHg3lV4Sqt@2i"36
SMG4cPO1t7E=36V$3/7U:j-=b?G/hm-t2gX(<\]A'j3?Q8)&lB[OnE9@/pds-rm**+Cl\hpoj
qPMEDFaQf,MX[?=0UAWL@C/6qFp+cA-UIqZY99Q@,c!?MqW$#R[9(guJO*fJ4Dk>tr:1bT,g
fd\<7q;GcO%t5mcnVsGS_+J0_)EgCb6'KpqZ,iAs6>o3puue=WkZ1^DLo?32kKYi_]A->5[DC
3Yi8lZ.rW*jYF7Q3^O"o4gCJaiYZ315_J0IFbeA/pi^p..>b!d,)Ii<FLn@F;(a;ugcdD2(k
c^GIK!D6_0h]Amga1TiZ-]AFT*O27'ra4[7pNH!)KSd+89>Q>s#WfkBhDn?W>mc#n`Y$SR@rV(
\`h?/3@D]As-?=:/:+YXmSQDBqjYC&=+lK]A?9QcUh_Oq>[ZmV<hOYq='^l*D*aS?',QKj%$:W
+I^%C-dld2KnFV5bI3P?>DH&0296JfA*Qf`;dU$oEjeqIEn`>UnaO!nG58$aC>abcs(dtaT"
ZKqhl"mrQ%4:D[B;I0"2s!+Z`h''!JaMY]Agr+R"q8H_[59%mUICS2%Eju4IE!r$;Gfd!Gq4V
"icc='.a8\356gDtmDG#B3]AX.(,)!/2-0]Aic`hdWFoCc>=!R?N9p&2lCKt?XGe").\'p]A(KI
QAXrODn`*-tVpH2mHRX%D!OHg_#Z]A/RA'HKKJR/$HW)HAaFN9k>'o^Z,&"#n0dl2PLi7cTH=
*Q1nF]A2iSF>al>f`/*V%j#0,:jtPq=V$J`M4WQ8U,!Kh2(AL']AasXl\is5^1!o)B0aJ0m\i`
?9c=!E[bs]A&7[f&T5iGnLl'$GIF8[C@Mck/e6qffLTHo,^;c,#YD;Loh/Q`;DZV[LG64AD5_
.Y'pl4*.O6+2$Pas*W-oiP^^gJmWR/Z@pj*?[0fZO'Z+KJ]A6cU*o?WVuD893,b<BA$o_C1%5
-.$'@oD]A]AB,%]AG3CDo`)#l=dU%l^Fj=.g"f6=g7aah;-F**aaJGa(-]AVP&PDm<TAgge1oSZF
,20BkUG_3e!FS#cf+r0<8oW6Lh9C)+Ih&*BYJ*>Tt?K1o/>6:(-)-/Em_%a2uK#9".%@k4lQ
&>gEH^Z+sG0qZNFP%B\es"8)2"#Sca/_Pe#J!f]AO@UT:>"V;,:NkdXt?qXWt;M3mCh]AV$jN3
SDn$t.K%du\HF9fp"Rp*g%19MC5Y:>@:i)66*@P&Qjk(XqQO:X#ITXsBlqQNM;9]A<:*X!H[;
@C>(ui%WkD<:=Ice&Bg$ZAHE+&6RZFR;XIs2UP-=?c:ZB3b/qqc5!hAer"!U[RjnRkKC-1@@
qS1)*f8A?0oZ7b6[TMWegbYdC]A13p'DTcI`4c;_SAK,D>6_Qm2k>8VB:Oh3OAZX&dbq>'jN]A
R/@K+)9K\grrH@BK=R?l@8%!IPoBj@od&o.>40R-#40*ZNnLZqCG1DkJW95^gt^7,'j$=&8h
GY]Ah$ob1\-6M,kW+1\)48<7L#qU<71hnYg>t6Wg%Zk<Tc?G3d`#ZWM4XBkIm=En]AmiD<tZAg
5^<N#'ML`0Sm2r=L'TP]A8Z@jXbj[Ghp6f8FC%l643O+<Y(F<)-4h7R)=&'Mm"PgH:AE:sh-k
OBD&KA$m&SC]Ac^/[tYqL9q4Z;YJ7^.lV#YZ<?#mq_5gVOJV3d]AsD&!5m5b@)>h'dW@Z2.TGj
-Ff6.Fos$GX&iWb?Tii^LL_.96.Q=$J(PA@W\APJPa>u*qeX%LX8:@_G*WJ+f'?GE"]AZ"F"]A
&qQQ3s>R`C<Nd\(J1;NLSta&JQp1`6`W!B@=^X94#RPM;UGT&rpe"]A>hU8a^3*G7J2lDXb/k
89BD"[^cIBFtAb5Bk#u*\_p[qb)-R\L;BfFocS,?k-9D^cYh!\(Kpa#j[H!8uUkRdCCZ.;%A
:9X/j4b>ZJTmTsS"He1lG#eFcXl\$_V&ASDHmlCoNYYQS$Ct\(*j`o2./,Zqq,!/,eiOZf*Y
jph7$d*_=]A(csWOW5S]AtJFJ[Vba3cc!3JKASIm%5;8i7C3Qqr2.oN^cmU*b37Mq_XAk#B5t;
Hj`aFa@g1q+$1N.iDh<G30*B*E2a9[gEf0oD$(J(=5tUB*h6)9Q?,Z=`K#3Qi?-:uBC=gpml
=B8=ME6]A6oIW0':Ch#E"PlKQ%4Q5q7rB&8V4-gKDq:ha-\?KRiS8qHGK*Sd4#i&*hT#3DehW
6Y+Q)Hp4RE^La3B8.<@r0)`I3\<bn9RB[nti<C9Q-(nrK2r9H8uY;Rlg5\I44middQn`,j]AE
&7UDee:1/<"n6h1$R9IX#*V4m25<.Gj2SO]A)Ea)c0$YiDCMHqRPh!__e'tns,1tmd".?t;ji
>fJC;F"Q>!/3qk*RPjORuLRj[(7+[g_YZI7`J7WcMR!gW0/F*[rYK.LJ%Y<@hsT!?=IFmhn*
VhL=Q@Gm_;lLL^TWO0;'?G".uIj*'I<\BQ:>UO"D3Qj5U`+-Yr(Pml'@9F=DN`Te86E`m#p'
<u*>$[C3fK\Mp(#19Pe4SPp&/dM9mSW&jse)m`5`02t+f*]Aj;'hcDH8R,djf79G"9fLF4pP9
T[YLHR)(=MLB;51;j11&jQVa<Q"F!NDqg2Z&p,^H,&pOK'kcdNk9PdX7t\B8trKm!;N-q]AA>
-D/4?oAPn7lMQJK7%E&#EQt4Q<GP1UlrIK7CRA]A73o(7LlH3>Z"T1(bNlN[UobYRX(Z3O7/a
&rVoAMMk$mapMWnl4q!qm9qYgTau%e?s_emX#lRPXQnmM\C>LWa%heJ%`Q<Q&2B6Kphj>C@>
=!%`I),K7Kh5UUV_hc"!W<U*ha;LhLp]A=,Cpe`kfr"&r2P8SR/'hZtChHO2=^qTNJSW^pQ,#
)+ISY9]A*G8/VA1^JsSmrmE`]AVT>ddgQ"9kQeYPsXE2:tL0]A5LVS7s9FmlLH7Q?;Dk"lbtYcD
[l;l=\1:*-q<&.n`s\0(U<&heZF8)dK2Y0=!ETG^-RF>_o+D1]A(U;@ncT1CbQK17OrH5TT=*
C%6ph;$\>bn<h#-9V8'l+cJ3=J!OQa78YfLnaLp0*6=5B?&e,J5UL\M#l_g,emVM^HbD/fM%
K/4dUuJje:f"p<0W*1Qi8)<+GGL9)?K2PMt^.4A52H/2S3is9*50LgSo=Tmot56&BC@+>)9%
+BH`5brm["r!VnLfK=@ahT7&#M223bk_t1@Gq^WF(N!QuDlGK&ZEW2\e8*Hanjm%C_;ic90B
Y1.cBZqXVl8QO&o`c#%hi=5K2c+3jIaYTQq'o+[Sp8VpWe2+75Hn5@+WN-P!:>lge3aWf/F`
,C^t@_i!akm/]ACBBUE"!W#hIt\>Sc\6@2j?&MX!-LG^PZ$\riIV=@J:Irr=lCR15.MsSb\@l
;0CapKVR"@HU*d*\/;7BHI.ekSJKmK_.Tc-Y[E=0Vo:5s>kbSVFT)i/'+7Vip<"JVI*mtBc0
Y*OV`#V"!7ig")9uT.E(bpf(f6^HY5MYOZ\a;>!5'qfIi-ejpU%e$4opOM!H%QRl9Sfd4Qnk
l^1U0e#gA?:B\;/B]A'G%6&A_i7+[f816iD-idZJ,.@?Ko3D,_2;JbUiWb:/5Y$E8/dds-9kk
jhr+&#Mc.-Eb]AnkWriqTpj=X9L(edeFWSe!"cX939hIXW(_mDHnb9e7ZnTbE0?aqhKCtOl4s
sbA[2'475+$g$[a1C2;mEVd_YqEhFN`Pd(d[_D8J^n\EgN0h-&=e5q/D^5j\r&D;TO"rh`iX
oPU<%9$_p]A-n[j@94O+eRfJ0"=?gL-8DLMBlQ:BXgt[5Iepm"Rf3gf(_V+D`pW."XXC7.+gU
@7Y14#jVaDmlQme/,/fcOY(MNP`1;)2^5Qp6)NPVY3`$Cpk.+IUH1]ALB;.AgET=^qgP>o$!:
3I3-JnE*a&c<2onATL%le$[0f(LDm;;]A3sLqOe?1Cd$&Z0mT?4i*rRIN>P@V(gb:Fm4QCWPr
l*t*F([meiCL]Af:qVJVhKDWaJT5C]AC7QRcek&FZnT,\H9"$^<\N=^;m"g/5DY,TP_p]AQ"drt
k6G8a^WLXKC-*K#Bh]A$+4KW`D/3T25hEmY7oWO-TPngI]AB$P3,s.TAh8,=c#Da?eH>:O:#E1
2#Ftn1KQIHr[8Xo'T>.$"jma#C+4Itq<%P+$ZW/u`3G)T0=c#jcFfT*n5)=U[&eoP65V&ui6
Wi_9tC/3aKDq.+32gLNP(4nW8ur2OJott86OE3aAKptlBQGSB$1ouEN/e/UrjhpjE'S:\\iX
7)LieL+s[6*dH$M+@+ZBnOt";:c#X<@!ZCB,r=0]AWfb$s:r!3:26A6f6AVtCr$`N7_TfAhJZ
f=<U\Gdud%BUAX;0m`hC!.]AY>o%\^1t6edB\Qn;9,&,Q'&+po6MLa[h_7*AFeZN24nUZ-j3-
8orRc;bE]A!M'pu?Pjer.)h%RBRn4!g11>Q2hLH<$[5l/%J9;8+]Al-</^;GVThRO9=5K)?&;6
;PZ`qA+`ea/]A]At;g5LM:U?ejQGV?GHp60N]Ai=f9^Jm?2#s2a:\h@_%GLYlbQ,C(Gm"*'NU>=
4C*]Asd8Q]AIS,cO`RGrC[j.[oV!;H'Y#'aVCcU&!rsFTrpl^;ICt0?kX5(0J;eZoH$Zgb(V1%
V%)46W"Db_6mIPQI8K<gQD@`kDpmkiU-&98,[P0:[,H:XoZ*g]A`ER^E\IXMl:5knK,+pM/;^
?KO.2:UXU(,?e"o?bVg?-NubSL'Pr<]A`W@Un07\.j]Ae!=t3YV-\*rnll1T5ME.U/?%o'%MQE
nN7pD$]A-R9ILO]AP7U?)!5m6CDoE\,SIo3nU?;Ln##AjY@?F',$_sSGZjNf5tlt=\Y5T'OZ0+
;(`FDB%1j0Vm7TZ>PM6[:L7@P&^t)X3nOIn:Yed^9R"-s2_9iT29-U.SP.e2AS]AXET-*@bcJ
\i+1p,&ud[%]Ako4GD86'lc=H.u/Q&s(6;X6b/mN*tPtR;[[tC+9)l_%9^&`k;34f7&mm+RsU
"f&j^&h;p&sIK(7AmJKa01ggM/^EH86(S"nW'$<D%D[P1l&8QE;c[hoSPb"=]AVUgQg=sdN)0
n<^.66j-ZY-G7\gG6oNl9qMlk(T#Pifi^$`-'*>c:ndLeL-L2q0PTl]AkJ,D:9ic!kg6SQl@I
H):=ZM0eQ^1[8'.nuIUt-3^Ut<IUHC"B;a.`9YX$rh<bLfpKFYAQbjt1N;*@r3Z0%>6+0Y*D
dCZg^"m':!or-\.`f/X8q^52!-#p`H\8#G?^lZDqNT@Pg$Yrks1]AieY#E]A:bnu@jCXMG1X-7
6c"iVpoE%03cA*d;TsY3Oe5fLV1X]A?WWaSA<J8@#;plVE0-Egho(U!</-mmPb:.BjWu[$^"'
.W[Tr(fn6%@*48?[RFg1l?A/8+C+BmDGh66tM$J1l8osIk@e`U,P3+XI+i6CH;-_mEM;9d;5
B>GA1!]A2iArX3]AL7^LR"BpF[jaoI.7nDI!o]A6'OG4#uFPaPX;Zij%pAO-lV&i?Q@.2__EA.T
HH?]An2@nO2dOl@-"gE)V[iC3?Mo1Be6dde3R.iH?.0"lqX,!&.1@h5s8e,S\5d(IChAZd_1W
[Rqq.hY"P+bT2?/-JWKR.?(Nh]ASe$K^:fYSfJ>&RAHqFs9;p&Em\\WNC^\6aR*rgD4#Q1U!J
k#jXVKl%3ddF:"tG[pE^;u[;_pY<A0^@&hOWo]A6gsb%bsm0((sXQR]A.uHnC1j3J@om9e]AE=1
GN%2'A<,aIHhOaN/R=,cCS_Ef[GP[RT^1aAA]Aub0!pWgQI?X>R=ALUcnZk!MTo\Eg'X13d!q
t6*J5A3_^*gE4PJ-AG[15J3pVd"=3QpJ\P;pq#GFZf<ne;c^D")@!6=_pkGY_tBoQrfoJj(k
m;)Qit(WBE/>_=#0F`V9'%U7fV5SU`d@8]AUO*JUSU8k\aPN3_\]A*;\aYtILZ@>lDT%SU(`p-
2Bd\-[MP4(CNEp"&!!5hh=l^cK0j5,5.cAOPB#s$/sSqR@-DdUkK(6g:#oSGdeA;5oI,fln)
6D!BKRD\K;4a5%2?^8fX\m+q*46F,GagP<9cg?bLfl(Ta'FKSF#pu`-uI6#/j9A;EfFOXdQ[
<$K+$_?#/qT(+j,*Qr>P0an=\Mmnl;BK;lkdBLu#&RUn-j/60?oO,IE;CuUpH_+mR4%d4pB2
aV;=Ul3J)Rf1bmO+Nl!Kehb9gMJO>*)"_pE`K34351j`GA6f>.f/tZMGY1bV=]A-Y8U=0$.Y!
#@MY+=De,<AAA6J37K_*,Mn>AW%.,-W?[65`<)&-E0k_)(<r9m%7#"H:WgT>3+OBk.n2pQG"
if,M4K[eb\&MkQ&?![sW@P\SHrkgNBBX'Kb$)T@?Yo@#S6WAYpCqFNSJG,/CI(.&`MQ<1WJB
Ugs/ttkm-N4`1Zb?'Z+(DUJ`HEnNP2OjSju!eW%MKW0`Up::99h/f6n(WjYJe3Q[rG/IF;lF
<#(;U]ALB%?O]AD5/#2=1*D)PEab'9cffVfnZMG'M=phJt'pIKaiNr?"aH9*8X,3s'4S4\e<:?
5o%0Tb']AQjps`aOl6/tjU@Mrj]A:No<S+Q9WS4\1QH\dfV+%OFg9AoY=$@(S#M8Y7_$9Mm,Oq
[C7Im!meXPC21tO@FS3=24Hi-[B/6LBKBD'X[3#VGH<U_1)$Ie>4]AgIQSBi0WN2RA"%s7XWp
iFWMs0sKIXfIkJG5OE^7eIWG=U$BlM*eo1-H="-!YFju?oKV*i_7"[=J]A9Pdgi=C#2QJBOkt
D9A?Ua)pYCXu-r)^Qi9_IQ7#Ct-PZcmWh[.PFj#::fM7%\]A@T3JYTQ[H%.74n\&H%9FWojE^
QnrmN0&oA$fi?EC;@jm>/Yp;'NE")_t'*j-,=H8IMRW4i4[,K1G%Nq_-V4<5nh[k>`T4[DEF
P3RA=*,QR?IX),o$/N[5b:e]A+,D.V:NPhDm03bj]Aa`0?i0K-KLOSoQm[m#!h)16T_),9aQ.=
7)>J5<#W"bX>$V=@mp]AC^E-%4/?+l-+IUP&)ZgSa9lejP&]A7.G:##1bB>rLA^1=?U8h_:3L7
a3?-/F^t(^a3?.+(J&ks`uaD`K((\>1K!9j!%jADh4%J3^!4O%W-,GOH#Ds<"QRmJ5Gn,Js"
#1Kp;"(u\hJSMR(I^#2FJ9(EK-Pb^Vn>7(J2j$mf"aH./bO?.6K>9>B)7%^LW#8qU?I2p6eg
Bo1Wp(`:GBO;ZS55gC3ZWgUC/)M'Xi\5/DY6p4G?aR'pG@`:7MVrJ_WB?\NSR8G<6V]A6gkq<
4)>TOJQL'hqEssRs'(N(UE*>XdlY(]AZe0>E<$4PeGr[%Gp:?=UFIB/.7P=<YGc;CjYGEoS.5
<T'SJeI4a\'2c.'i;3)M.9E-893]APM$N#q85@ZDY/O%[&")-U(kX`RSI]AA0_-C0"2lT[)8@3
,hp6bYQ]A0(s.!?]ADqSfDp.<5.oU:nOU36>a/H$D^(GCX8JWGZ3icP%aHbW$g2!suob%Y/diQ
=mk$X/>A5Ze4d$>>/lgfF%,`E0d.s85TGD]AkRf'^.V%'Ie3::JgRO2.`[p:7bmb.HkM?#&!)
gAkU+/:-3io9u+^QGWBO0;+h&!DqDaF1]AZ_6Mj_mU,iJKW^m+Ur0IORKF#iJ&=dU(fr,'bWi
ZntpU\30*8B,:fVb`2VOmA-QH"CA_kWSYV683pHp+?/jIY)@h*l\q`"H>+=q&Aakh/mEbRlG
b@%31p97+UH'%=^T0o')Xgceh7pRnO@$0X3C94R[RmIfT~
]]></IM>
</FineImage>
</Background>
<Alpha alpha="1.0"/>
</Border>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[ja6efPjeY@4U,%^7<XQ!$SD(clkP6@CR1'LahE`PmBXDO=qFPA*@:S<PDTp7I2t1ZloS_NF-
#28chDh53WHqc_`Z.+fBZUHce%`8?.X3H?El9GjV$MR!.`\<gt2f2p7]A;%DfW(7T1O7Rmf5U
oh88sBeYo#"WT^jmZ`hs2>?;md^KYTsEEA\'4l>9mD>Q=H*`4"(c;qS8D`N*!hno;b!+4ZK=
+t>_aP2KKiKj#^TU$Mn#3SNY^<,i?'m8!SX`]AH=c/-e\I[Y^/^#,E*IacR*>YTi"4qG?`Hh-
?&!]AB6h+h$r1&JY#d+"DCjG(jp4n%n+6s8=V[mL60Z<YPB!-f7-06p^hDmALcWs2X$p+]A3=,
C7,%sm!i>:j_!Cs*3l@">X3EH!!)%C@[BEPl^qD1^2JIR*>nV!j"<-\*dqa,DJ))SBq7I_b3
`M".)]AchAY9iP&D%[R.k%pZpUap=`K'UM6nie?<mYs2Kc4k4"qF@l%:=1u/t_jp^)jd`+#B%
I>Bd&mpAJ_upA;@bd7:O:*EQ$KlSQW+:\JE`rMGhX_'aL,o9W:__h($Dc`?trf6?\;-?U_"F
&@p1^&Gt3kHj@gl%Od0>[=o[(G?H\4mQCI4lCF`s7&p@]Addf&=-9Cdbk1DXS'fuQ3d@^\bLY
cZ6\I2pR,Rct)k&1GG2D()XW+[N5hJ;=Z&`iAKDB\$l8_8BNCE[V10Y_BE;@j<3?qqH)Z<GI
BOg2q05J&%W5lVX.VJId*E7DuUW=aNgL@_LTE"u&:9d\se(9ShYjlu1*FL<"F!%p!b6Aq4F1
#(_Qb@g^de%fVG?.ON:O(jkJJUg0P`"b\+C9Y'd_.)8or;2b'2+[lg&t0RIcEel$lJ2ae&oa
JCd@u&q3(=$G7H,cZ\"p$`H`0QA0)Hp:KN^u5dYPAI?X9@"lsT/?^(X6]AVi[<kOT<@i6#moU
M4)01Gfe"UO.#_N-`&$>b)_qg[>i39D-Q^!8ooo'Ja)'(&t.j`Gp*`0d#.i#JX4?JDp%BD_D
En_7ItCiAhiKqtD(IY$8hJk!J<a]A7#&h3:6<uYfff=lJ3SO:\lfB*hEA)c)oMP1@nhS91=2G
^]AN0VDQ*(_df"'q]APJ>`8@r=80p;W[S/>%G\H,Z'FQ(\hjiSOSAi?^S>q3F8ARthKTUtWoQZ
DXB5I`s3_1Xo<qjmgNJ0DbS2>UrCK$2:[IXTP<q=G6RKVVuHK"@6.*3erhVOJM_V;t&3gg_"
rku,q/gMO4YKaK!*p%"d(4pqXH&r$Ym^g.V3n5&Me*QuOr5jbs7FslHo[NQo>dhb?Q_3f6'D
l`jb4X13MS*W]An*5F.u+#hX,N'*<q;p^,SdoUrZdSE<Xb.ef8R-Mt\D1mm261ZYe,Mf5WgF,
R]A+%KgG_qaPEBTulPdI#6f#X9P.Y&E<rI!bRb?WHR_O"XWBZ5jekZoJb06eB#_fG`6"d,)d3
]A$onIA\I2-1SlMNO^?LQ`D]A"a^<DE32C3Q\?fUNn$t2?so?;WO<:'P^rm9Nfl)I8>Bs66'9&
7-4i1EV1p+&^gcgf>)5kD[CXu9VE\#a6tg2;uS!<4<@M*ROE3pbmf`s_8O)$7Q8L(A<H5L2n
%cFVdg<mRc"gmMUf2kV3hiDZ4aB@Ygo\l+N6n/qFnc76M`gQZYuSZR!hKiZ#5N/%<BU;V8A.
clO.g!lS3n6PRq3jn.U6q*n>.BiI5$_^,q^WT3&#kCTg),CVb*"<_MW6/n<1]A>[*db-sl9`O
cPG`Zf"L#HXE_^t8Pb1//'V`Xo^P%;7QZ0nN?<9Vbu=RW?Dn,kjY+mJE`AgBV*+(mJ<2qCLA
IU;B]A`+<lF=nj<R<Grd[qpI/;*T`;mA67+\5*u=X1q7.uMjPn\Qml=#5L!Zi+_sP/Z)$n-\*
,PE;"_oa=r<NE,Zp&N;iAh=44ZK*HM4)T!@)@AU!7J=2T)HX,+@AhZuMnbZ=kG$;GscY6n%9
rWF7pg65q^XUbj^uIV3uB<99j;PR_HOUt9^64RjJS@pLlAML>#17/-0n]AsD-Jas.5a'%!Iu&
IRaJ^H$_/]A22'RXH-EohlP^\-9"?iD3Pg7cgTW`#ObuT*mWjt6u*kPd4c-c-Lb0L;)06lfZ'
kpbub7/%E)>27tK!ojTk/[?C.hi%MA74!%Y?fS<b7@=(*ItC+YKbM7fS>AjrOG?J>m7\JrVB
bme0:GI8>OK>Nt#$Pm*>5l5*Q\oX#;`p"eS#FmE:eae4&nn2b4pRI!t@-*+o;.g:&qde8u7K
caJ3>)<o.=4UV&VV6n?R5()A\Fsa8sPOA.FAr@<a*]Aq%C>NMA'/>=pm.0>/GI%=Ra=`/6[Lr
Iok9qVSSpk.;bBAQ3$\=^%Q,lfm!pJu[eiN8LkWAB>a:;J]Ao`3Oo4jq'EP+@0bf?XXjd'_n2
9kPQ8t0n9`t5]AdnW]APJM=SH5.GEO[mdCN6^.>X#^:t.V(VeU/s2JiYQ"\rkafZ5nO5"N:COJ
(I]Apa&AB:md(Bj[P>Wp-LGTXP8<']A1(%FK;\Dojq,cdK_sCr.=Nqqim^SRnR-t@\[7>L=`Vo
%'R^f:KKl0YV2/'D+#`6Cc&M5P"1bZU,!g#![1u"5BZ$YS(c]A"GMUgO4f?GEc`$2HlklU6f*
7gkqu_=2="u.PBSZ->$m;V?#[>FQ*uP\b*&Ni&AuYW*'m;bc3+Ppl,d&:W;YYgZeu_R_!?2=
\OW(MG,=2:UcI=!c4=uK]Ah/qer'Tk:+MQ39GmI,n,6.n@>Pi9Or@cGf`=S*Q<PN(e/nq\,T9
aN$mJ%!tD)PILl?QaWbrnc(U23PIJ0#UXF!gPHSFr*!h+2p#]Abd&#282Gr_]ALIkZb&K3mq98
iFH@htFOC`2EgFO#D]A(%Xf75Y5>i8UKQ0Au*HQ?AV/h\Jqa96CqBVghjm9eDq0Tg/h5mj\AD
E&$K;BYEH'+1fh?/q+N/_TP<p]AfJfS9dFs<-^LW+)mDLMKUR&'7SIord]AF&-.(fY-pcHO^B5
%?GI7+P<DIN,l!-kC-`LRBY`O2=nLD;OaOF6tP16n0$"aI-7fE1aO'C8h6mP]A-_LCd`dMkXt
#:2E%U#A!]Ag2[:/$>6jt$Z*e$AB*CKO!EfM:`K_a$:6_)[pH75=Fd9]A5Ok2aVQjJ4@W,lUCB
\fD2X()dNp!!6,G]A[tI7*"4OQ7@#tSN%l%47$EM(Pd.C!]Au4)+j6P3B*H`)_#qP*nE]A^lY@%
#b/jZ4\G>Th,nV[kapNqLQfLElo&OuD1)LLUZ/@oM@n6a2ZE"3IdK'k"kkC.T>JLfn(_XSQ8
Y!T4;XJ+,d?L1UFPmc!5WJ;!a_pNiVE\LL-*2<7kQIFna;[!%(;Xa0j9'T\e6b<oP2EPj0$a
$.).tWO:Dq_?fA3!qG`LhD`j:"Oice[=*K)o#8N.rDH)M<2+R?KoDF"WgE7%s*67,O!87:bl
V1H`l<W*3L)6cR34eD95cNE?b9(cB<D`.^5C8)*V1Z'B5d5N@J!h'G:N8"YS6^13(1/KpPgY
6i?V2#5($WZ%pNK1&_GV%r5A&(YEf6J=MJj<j/d:U81:1G_[TQB:sW2YQdl&^S5Kbd:I%.>;
H$+A:kPCYR"UNkUW0EHqip;&\E)U<.tK$iL1)?/Ob)+XMN*`FGgh$G6X?VZGCQH<mY\``ZE?
#(<0c7P3EKoOfR>*qHVihY?Y!d4`QVZ,-eI97)MB<8d<Mq(L.,"O$m11DMrlLQRO&.2[*D)&
CmA;JRL-GuHZA:Y6A;UG>6.S(A[\=&"ph(7A@jEi3Tn#XbXt.3lYi%6NbS+NHK#.$2$b3jYR
!GZ@%,1nuWZ.ZL(-)-I+fC\al.s13KM2\3?>$^`Ij*=O^+>+N8PqqM$]Aq&b^&<;EJLLRgQH5
*Mb>Pe&[.7$4\Wp<VU$FZoUJ5Qg&mKajI@=S;:bFiY>[W8DDk-iQfU<'W9M"'Xi253hKFRf_
F#80]A^5iOBSXUZjX@:k:=#ip6=FjGo)'=RF'"h[Kh+5qj!M9tZghl,WU8Un#`60'#+(7uq\Q
)sfA;'<-h@^psZhDsf9n2[sj4&f*3W1@!lD=kU2iD4Nb)%'g\UdQT8(d=7T:Op!EqY-1CMe,
Og+F4NKtn_WlfAg07GDAr&"r)FB/[GC:;0>H1G)1#:\Ra6R#A8?Q),]AAGX\#W7l2m8%()r1@
AQfG_o3h4-:A=^fm>nr`aon[`r?QH$^DeKoDUCMK04:H\=qtc5+(2oSlR+T3[!iYZ+lparBT
.8T]A]AU<=dA@-e&m07)9-MVIi%\0RE[Uf<;2oGAIYA8gcRr7E.MCO-BEjG;gLMWd/rPeGlT^Q
S-_:;K:,0D39_r<'$#'k)E?V[br#=FZm!o;+N;b+6'Orq(L+*7AQLg1]A0T%@!$[8gA]AChq\J
EO2eL6o\_IIt7P\?=Z)FP,$V\/<gIMV_I]A.AhHe__&KMm16VA;>@LR-5g"fA\**dq/+?oed]A
pt'AO.1>&.RX-QdYLt+ZluTZj-(%['&!HGJ$4ZfOdcTQcjhIe9FI?PWlf*dN`t",fmKCs5sn
c_$XC7Zf,n98S)T5jQ\GdPs]AN5T)&Z'oR]A9#5EOALKe\AMQV[(>Z%$nQ1\XjjVRc-[OoFat"
3)Q^j<;h4@Hj1<@8t_*f&IDE5=mpM+5/mIr80_>6H[\PYn\BO(LJ6"k)#GroEKV[7*FKS+1X
XcTq0W^f:9bH>fh/q,P$Hd1*K$2->;"gF1EU\EW;`*"[[0>D4k]Ah^rtE54u11&[2$^ChB3i&
M!IFR9(`'JnYTOYMf`sD)<#\Upe[T4+L&@^f-gJQ$FVB^Hoh]AKoiV99`2Qr#_3W1@6`:5D^#
SiW,S!C-c]A/k;EadY<0..edM!oF[`G*$jEmBoYI:-EO9>]A5:ZRr-X#G*0VoU_pun,ZkKm<19
'Ucjpl;0H#sl*Jjf6DujAMtC8^KES@IF==;bMi=0#F*_K69f`;7G,fdD<rL.iLd+NMa?\mNf
5*=U$mpR2C;Ynh(C$uel;F5hSbO*h>d?XH):n8q#\/<6GDm^sA1@0R9>:57DSPXrMQpRBDX>
[1D\H0s8r]A0hI>):>X(KYT7o@jf%m$SnB3C;>^[ke[@\5]A6*3ZP[/>NR^Ekh>eZSTSgSN8:i
-C(p1<J)m0!k(A_,Z-Ds*>*E<SG%\/e5JW'\%@iCm6E\#%?-G:koV-tNqN[@N%Ut*g,?!bkc
T=EHu[H'7iKo%YpT*Y]A29sZli"9d'[*ZE<.(CZk:4V2+&0;3hAhX/PG!;LVBFH#plT_rQQPc
'DbT$"%Xun0\*\5-]AW0RN2An"II=kEt4+q__i<l&"5HPc/,>RT`^pHM!ggmXf/.^*7R8(W4Z
@j@?91<&-;3S_>UT#dVLJTke0qpW]AWjUQ\E0)t8cF;hk%%af@0oppH9g-bS5;%U=*_%Weo78
S8$T-.n.k0!t+M/[!:,`%GQ6@:/-a%Nk/NiflP8,gA4HhMJ6_Yn^Sql:&"QbdC%>>:dN(u)9
0F1cAhtb]AfSU68G5mDhm0)"ti75jjfa>4*OhV&UoCcLB-)=:3Jf1;1J+Vpj/h:?O9K7Gr;#0
+;d?<hli,X(FDDUt)c3o)!^<Cs!Grr$uN%-_T890V>2V!PFJrRWc*,`RoFLccKahmBjII;u=
,rhQ:4oVgQ&QYF&!UptGnBl4-S%lW1O9b@)Cb@KT(D1oq\iW5GK%D*`]A9kYpi27P3;BgoVR"
e>;YHp7:Rj&!KD6c5<!Wb+TtOBZF+;"`p.\j=bMMT^%aO1<hf=/Fa,6u7Z/Hj\:TUU'USopI
&!cmgcqRqcJ.=%N:!<q[j/;p2uh<_!Zt@Tg(sZ!!&.&4P9`9Re]A^l-EC5G`=:<A=X$%l5e4c
Y>?da[PAWhH.b.44Z4T!isCF'aa+-/T66@Hr*r>KpSgn\%7CNGX;(C[BB'93a5,dT[4/Gt8`
:7hG]ApYB[Tf"KCc^/^<p'Uf2r%pZ7JpP0OG9m\4UK\@\3Ds\3nKP%%@eDHW3M!*bNKBU=bpS
bFCGZ$C9"Z`F,$::]AfX%P8$s&_[M.I,*;!Grn9HY!0:QNI<U/(XGofhA<H@=P]AO<&7&u[k!S
EL4$Ygn5l'E1q_^@$%?T4.8)rS9>!2?K1;S+f9"\[s_eDJoSnpAco`iN0/Va,Op,Q[O@U2*E
Qbq&5L8l5cE)dsZffL-@h=^Zb9TpOklbg`MCbR7:oZ2G?XG`(7gb2fRp(]AoRH]A2i-Yb4-]A7=
'"-0RFEk(TEBHsD+2g`F@S;/TF%a^tNRRPZCGr[+!<+(45jmc.h<"ikWNn)4"t:]Aa=b+uI_u
!gCk)`#N@Q'0Dk]ATFK6+d9GD2g-*W#7[:&i,=mDr4P7Zd]A>F4bbTQiKsqSd<N`I@!g^'$@![
nEmm5,;sYj8dRr#E!EnUYNqC:ud7LJ*A>^9f/YY2hJ/4l*'i/H9`6%0k<G\bu/nj?Z9!HUb<
C"\q_s-AsLh#'.es[Y&.i.n^X`P-tehr4%Ht@*kZ'5G2)#MMf8ZKH3GC@srrWHPu@=9STC3(
i^45rta;;BI`=dCK!1+K9k5&Ku.IrCSMh<*'I%)`HON.-TImHe>m:N,;I)q[96UEm3G)j#Pj
G>G`&roo7ahC0F27a5r`os&KBZG8K[bdQ.G?#"e3q7\t3U79"?`n9cr5PWQZrj$69=4$<()b
s=[]Aem?]A4f5O`VugsEY]A/0_[B\'J!&hN9e\B),I<h<EQ$.D++D\dKhXSq<n]Alp(Uurn6\F`5
<%X.Pc!GTgW([VAHe>R"QLuu$q-NW8j4Qqk7I^Zj2Bd@P-`_r_ZYWt3BG%@A%?DA"Xm,Yd,R
)dc_<(;0*3Z$@6UNuc`2OnpPooO`>)LX*Rp,fiR%!#:+/^1b0<%?TW@og>bA@g8<jpE0]Aj]Ab
9Hq(*Y^\8SQlgT*=DFI_;j^Lg#ba)l,.)FjHmY:]A$fge(*&LPM/$cM1<amYd_Z:k&kNf/36a
s/d>j9:Tb#5>[uSIe,uu%#jXi+-N*4+atJ`>hChPI`ZITcF="YU433-`?Ag`J7&ju;gj7_$]A
?E^WH)H:CRu>HW59.R[<f<EfWm[Ra]Ad6;%Q>j'i%L$sSI#Sr8GY;ba!3t,E9V9eJ27pln7DO
[R!.c!ME>]AT3Mdc-XdXJd\k<!jPEEo$;<>Cn9B,UR2>L'<5%8HkNH1p@cAW*'k@>]A_l8LP/C
tm:pn_O.\<bAcaB$r`1O4lb[I@Th^g4;NST@iI=r<m&SUT=5Da"+'0r*J1n/+qM*LBp%:rRJ
=2[j/*@7UkB^XR0`+,<tM\VU#"jWp9(]AVjAEiKAApc`L*Jlj]AI1e0Z(+,-2=Ro1aj!4A]ARm=
)^'"JS+1Uhq`QRS;@1IE?"HZ1`SVYkD[2U-QDfWX^eIn/j$H#Pi:65(nH":S[-Do+K<.MAF6
Ce[-_J3IOi+-(2gSO'6:cn.4(t=%)OEd\3s5%cCL8-"SpHpE19NpX?B:=)0016R)W>\E$-7A
s2]A=OU(5_$0J?21q)0qK7((rL6""flj,$Hk*le)?WY)HDlr[@`V;CL=T@0?'b7c@q=XoO#;"
Grnhe"G>JI[#s6-$!n/m#q^t/8qjtN^Q)__'!]A#f2GO5Xpm#*m_mX"i2#f`-UsdX+RX3ojM*
VN<$9gG-5-k:UL.IkE9[`\n<Hl!VB7R*"77*pNOlG]AJDPuH1l^7^/]A&R>ktQArI)WIY@$9@g
WZSd\:ZRf`\/BRK4SXb>b8Y_KYoMcu-2%JK.et$OA)-\-3t/rd\rZ/ejlrVBWY3`EncXJPIO
jg<fQ1D[0V(\9MA-Z6415#tmS#"m_qIV(c]AjqE0gieA@?_#9^K)jrW@QE9#k\mtC"fohSK2n
"^,[0s0h:td3nKNuZo]AF_C/QZ!YW+]Aa:l)c#14pBWTYo'ab%cA3!?mFuJW.a^Ctafe!%[?k'
dPXh.=a/bMc6lcY;9Ck$c8aRJ"Dpu_:Jf`&ft[cTcrO-aB05QcL]A]A7?mY"l--O#slE<7O_Ch
pu,^:\Aa%Ftg^%lq7MAJ@gfXbI*$`k1AU^!.L/6..'X+&NJfYX.KM-oEL><l>P=B?'Aln+sN
[["Vck&i!!N3Nso'HVaZZT_n,[o(O]A$&NE/5F3@qO&(0&cA@=;([e3SjghUgEl[b1G+Nm./`
H3'CdX$=$W:mog9PuM2<)DWW#+N%+>3F4\3(=$*jiWeMGQ%5G._+e^ldroP"-C]A9D-M:]Asoo
AW+jd(j4F.MM([&)pZqC[`4JH453EW#7OGdJ?sT^\[i@B(=;&8n.b&i?YT*-N,+L@a&9kJjX
o'(cn'3PnUm6GG!JMu/cHYb#$qpp.lg<8K?X"X>S*WsCRTNncG`G:,o<_3sD($=[fGjl#XRj
q5f[E:#Zc1c*g6&qnA?_S1KhTSN26BbkJscFI$LaPA\[2B0.QqjP#ds[8;#F%oY_W8UR@T&C
i^VSc'K'6G2ADL39Dk;VRBN5+Xor!'GD80D]A744>pJO^A55Mh,\?L02aHeiWaC:'0Yje')Z%
S'*ML-NjokQR"+=/HHo_k?c)m&bTr;&:1HKjK.O[Vfho1o7S!NGI[_$SV]An@r2B[bK1b^hEQ
g,F,O*,"S;=[f@nQ[sJCdb>!WpV0N=@p9W%4S?eRo'JN0_,V4?0eU0Ju6PBFLXJ'*G\Xg2-<
f@F4E?.XCT!\'eY15m$q=.kij86ttqkJE"VM"4inQ'8(F_7<6Mh&6ch8E>7G:IFNGud`Zpri
c)iPG/BM</^Xe=@sg0fWIqXi@Z4\f+^:<`p5/,P3i\7Q]AcqK]A=ii@JhD^oS9(;=s\AC&M;cU
hR6D,PM+so,Mb[7`5msBf4Z]A>#FmX*.&t'"ql!8:l-QHZ=23`'DhBTlm,nhZbZ5tTnWlW&a<
i`=@.<"(n:\+XY`Z-\\Lej$**B=FkOUD4jH[`F1B>h-@B.1Z.r8')=i_^n$@9C\F6?<9]AK\c
a>kcc=QBdMBkI0GkMdCup<cTiNV80kH'mo2eJe)q;`,bI8b%5=L#EUfNfPQU._qNAfC!lh's
*a6Qn%iZW`e!;5dao>(p;t`tTAGP^8@nNb21>b&SbdV'fD;K\"&1r'4Ff`(!]Anj9[&%RHb0$
)i\BFO10AO=aXaAU1PH=bD.*A`]A[Sh8c<aTID]Aa8CG!%.HL?h"j:9F6*Tn?GJ^KSe-8-@9IK
Pl@r5(R5TSda+SPni)aS`,K8[.6UOLdd[N>G@IaG-F`_\\N,8edFN?t6YXTYG!@mLPPb:F2_
m`LN%)/DEtTE&8=(28Wgl:'4[t&-H[qV:S'Xm?)'(6N4(9@`KVLlo<;7S#$CX9d0u<Hj^r.6
\bT;8^8)ME.38ZlkQdI[!'d+FmP69RBL7/SKSuud-%&nFoGq%-0TN0M)[m[X8*)ihOVOk;jo
@iROln^_=]A\)<M'eQj)0OXp.c,*>6k!+S3+i)91GYQ$.`XZ^qXX+)9T&#p3^b-eP)Nhm-p%@
<*%=?4\jl^-!0<#OFI^0CZc*##L;GpF\+e^j4efnr^HM59Rh`d'K/8uV1Xq7mRD<j8V7`26T
4/LY"G$(\j>dWO7U;t9cjD2HkWM\W/-g`A['Qa*b+/>Hp'#+U.P1',g#L$IOrp1/*[$NoT6l
S)@4FNfuCT;4]A?*B22f636SSb&g3lmO$k$U?4*4MC#Lg;i,Rmdo*d=%tg^jC[$Ir='78!SoV
(?g830C7ke,modPEookJ4,Dk&3qio$BY3F?6L\SV[%5[)%NcYT$c4Xig5"g3nE/[.fQLm%0/
18qa>T<:>[FbgiV,+6]AkLC^4,caXA66**eVl"J25_G-R^,'YU%G`I1!nkHg3lV4Sqt@2i"36
SMG4cPO1t7E=36V$3/7U:j-=b?G/hm-t2gX(<\]A'j3?Q8)&lB[OnE9@/pds-rm**+Cl\hpoj
qPMEDFaQf,MX[?=0UAWL@C/6qFp+cA-UIqZY99Q@,c!?MqW$#R[9(guJO*fJ4Dk>tr:1bT,g
fd\<7q;GcO%t5mcnVsGS_+J0_)EgCb6'KpqZ,iAs6>o3puue=WkZ1^DLo?32kKYi_]A->5[DC
3Yi8lZ.rW*jYF7Q3^O"o4gCJaiYZ315_J0IFbeA/pi^p..>b!d,)Ii<FLn@F;(a;ugcdD2(k
c^GIK!D6_0h]Amga1TiZ-]AFT*O27'ra4[7pNH!)KSd+89>Q>s#WfkBhDn?W>mc#n`Y$SR@rV(
\`h?/3@D]As-?=:/:+YXmSQDBqjYC&=+lK]A?9QcUh_Oq>[ZmV<hOYq='^l*D*aS?',QKj%$:W
+I^%C-dld2KnFV5bI3P?>DH&0296JfA*Qf`;dU$oEjeqIEn`>UnaO!nG58$aC>abcs(dtaT"
ZKqhl"mrQ%4:D[B;I0"2s!+Z`h''!JaMY]Agr+R"q8H_[59%mUICS2%Eju4IE!r$;Gfd!Gq4V
"icc='.a8\356gDtmDG#B3]AX.(,)!/2-0]Aic`hdWFoCc>=!R?N9p&2lCKt?XGe").\'p]A(KI
QAXrODn`*-tVpH2mHRX%D!OHg_#Z]A/RA'HKKJR/$HW)HAaFN9k>'o^Z,&"#n0dl2PLi7cTH=
*Q1nF]A2iSF>al>f`/*V%j#0,:jtPq=V$J`M4WQ8U,!Kh2(AL']AasXl\is5^1!o)B0aJ0m\i`
?9c=!E[bs]A&7[f&T5iGnLl'$GIF8[C@Mck/e6qffLTHo,^;c,#YD;Loh/Q`;DZV[LG64AD5_
.Y'pl4*.O6+2$Pas*W-oiP^^gJmWR/Z@pj*?[0fZO'Z+KJ]A6cU*o?WVuD893,b<BA$o_C1%5
-.$'@oD]A]AB,%]AG3CDo`)#l=dU%l^Fj=.g"f6=g7aah;-F**aaJGa(-]AVP&PDm<TAgge1oSZF
,20BkUG_3e!FS#cf+r0<8oW6Lh9C)+Ih&*BYJ*>Tt?K1o/>6:(-)-/Em_%a2uK#9".%@k4lQ
&>gEH^Z+sG0qZNFP%B\es"8)2"#Sca/_Pe#J!f]AO@UT:>"V;,:NkdXt?qXWt;M3mCh]AV$jN3
SDn$t.K%du\HF9fp"Rp*g%19MC5Y:>@:i)66*@P&Qjk(XqQO:X#ITXsBlqQNM;9]A<:*X!H[;
@C>(ui%WkD<:=Ice&Bg$ZAHE+&6RZFR;XIs2UP-=?c:ZB3b/qqc5!hAer"!U[RjnRkKC-1@@
qS1)*f8A?0oZ7b6[TMWegbYdC]A13p'DTcI`4c;_SAK,D>6_Qm2k>8VB:Oh3OAZX&dbq>'jN]A
R/@K+)9K\grrH@BK=R?l@8%!IPoBj@od&o.>40R-#40*ZNnLZqCG1DkJW95^gt^7,'j$=&8h
GY]Ah$ob1\-6M,kW+1\)48<7L#qU<71hnYg>t6Wg%Zk<Tc?G3d`#ZWM4XBkIm=En]AmiD<tZAg
5^<N#'ML`0Sm2r=L'TP]A8Z@jXbj[Ghp6f8FC%l643O+<Y(F<)-4h7R)=&'Mm"PgH:AE:sh-k
OBD&KA$m&SC]Ac^/[tYqL9q4Z;YJ7^.lV#YZ<?#mq_5gVOJV3d]AsD&!5m5b@)>h'dW@Z2.TGj
-Ff6.Fos$GX&iWb?Tii^LL_.96.Q=$J(PA@W\APJPa>u*qeX%LX8:@_G*WJ+f'?GE"]AZ"F"]A
&qQQ3s>R`C<Nd\(J1;NLSta&JQp1`6`W!B@=^X94#RPM;UGT&rpe"]A>hU8a^3*G7J2lDXb/k
89BD"[^cIBFtAb5Bk#u*\_p[qb)-R\L;BfFocS,?k-9D^cYh!\(Kpa#j[H!8uUkRdCCZ.;%A
:9X/j4b>ZJTmTsS"He1lG#eFcXl\$_V&ASDHmlCoNYYQS$Ct\(*j`o2./,Zqq,!/,eiOZf*Y
jph7$d*_=]A(csWOW5S]AtJFJ[Vba3cc!3JKASIm%5;8i7C3Qqr2.oN^cmU*b37Mq_XAk#B5t;
Hj`aFa@g1q+$1N.iDh<G30*B*E2a9[gEf0oD$(J(=5tUB*h6)9Q?,Z=`K#3Qi?-:uBC=gpml
=B8=ME6]A6oIW0':Ch#E"PlKQ%4Q5q7rB&8V4-gKDq:ha-\?KRiS8qHGK*Sd4#i&*hT#3DehW
6Y+Q)Hp4RE^La3B8.<@r0)`I3\<bn9RB[nti<C9Q-(nrK2r9H8uY;Rlg5\I44middQn`,j]AE
&7UDee:1/<"n6h1$R9IX#*V4m25<.Gj2SO]A)Ea)c0$YiDCMHqRPh!__e'tns,1tmd".?t;ji
>fJC;F"Q>!/3qk*RPjORuLRj[(7+[g_YZI7`J7WcMR!gW0/F*[rYK.LJ%Y<@hsT!?=IFmhn*
VhL=Q@Gm_;lLL^TWO0;'?G".uIj*'I<\BQ:>UO"D3Qj5U`+-Yr(Pml'@9F=DN`Te86E`m#p'
<u*>$[C3fK\Mp(#19Pe4SPp&/dM9mSW&jse)m`5`02t+f*]Aj;'hcDH8R,djf79G"9fLF4pP9
T[YLHR)(=MLB;51;j11&jQVa<Q"F!NDqg2Z&p,^H,&pOK'kcdNk9PdX7t\B8trKm!;N-q]AA>
-D/4?oAPn7lMQJK7%E&#EQt4Q<GP1UlrIK7CRA]A73o(7LlH3>Z"T1(bNlN[UobYRX(Z3O7/a
&rVoAMMk$mapMWnl4q!qm9qYgTau%e?s_emX#lRPXQnmM\C>LWa%heJ%`Q<Q&2B6Kphj>C@>
=!%`I),K7Kh5UUV_hc"!W<U*ha;LhLp]A=,Cpe`kfr"&r2P8SR/'hZtChHO2=^qTNJSW^pQ,#
)+ISY9]A*G8/VA1^JsSmrmE`]AVT>ddgQ"9kQeYPsXE2:tL0]A5LVS7s9FmlLH7Q?;Dk"lbtYcD
[l;l=\1:*-q<&.n`s\0(U<&heZF8)dK2Y0=!ETG^-RF>_o+D1]A(U;@ncT1CbQK17OrH5TT=*
C%6ph;$\>bn<h#-9V8'l+cJ3=J!OQa78YfLnaLp0*6=5B?&e,J5UL\M#l_g,emVM^HbD/fM%
K/4dUuJje:f"p<0W*1Qi8)<+GGL9)?K2PMt^.4A52H/2S3is9*50LgSo=Tmot56&BC@+>)9%
+BH`5brm["r!VnLfK=@ahT7&#M223bk_t1@Gq^WF(N!QuDlGK&ZEW2\e8*Hanjm%C_;ic90B
Y1.cBZqXVl8QO&o`c#%hi=5K2c+3jIaYTQq'o+[Sp8VpWe2+75Hn5@+WN-P!:>lge3aWf/F`
,C^t@_i!akm/]ACBBUE"!W#hIt\>Sc\6@2j?&MX!-LG^PZ$\riIV=@J:Irr=lCR15.MsSb\@l
;0CapKVR"@HU*d*\/;7BHI.ekSJKmK_.Tc-Y[E=0Vo:5s>kbSVFT)i/'+7Vip<"JVI*mtBc0
Y*OV`#V"!7ig")9uT.E(bpf(f6^HY5MYOZ\a;>!5'qfIi-ejpU%e$4opOM!H%QRl9Sfd4Qnk
l^1U0e#gA?:B\;/B]A'G%6&A_i7+[f816iD-idZJ,.@?Ko3D,_2;JbUiWb:/5Y$E8/dds-9kk
jhr+&#Mc.-Eb]AnkWriqTpj=X9L(edeFWSe!"cX939hIXW(_mDHnb9e7ZnTbE0?aqhKCtOl4s
sbA[2'475+$g$[a1C2;mEVd_YqEhFN`Pd(d[_D8J^n\EgN0h-&=e5q/D^5j\r&D;TO"rh`iX
oPU<%9$_p]A-n[j@94O+eRfJ0"=?gL-8DLMBlQ:BXgt[5Iepm"Rf3gf(_V+D`pW."XXC7.+gU
@7Y14#jVaDmlQme/,/fcOY(MNP`1;)2^5Qp6)NPVY3`$Cpk.+IUH1]ALB;.AgET=^qgP>o$!:
3I3-JnE*a&c<2onATL%le$[0f(LDm;;]A3sLqOe?1Cd$&Z0mT?4i*rRIN>P@V(gb:Fm4QCWPr
l*t*F([meiCL]Af:qVJVhKDWaJT5C]AC7QRcek&FZnT,\H9"$^<\N=^;m"g/5DY,TP_p]AQ"drt
k6G8a^WLXKC-*K#Bh]A$+4KW`D/3T25hEmY7oWO-TPngI]AB$P3,s.TAh8,=c#Da?eH>:O:#E1
2#Ftn1KQIHr[8Xo'T>.$"jma#C+4Itq<%P+$ZW/u`3G)T0=c#jcFfT*n5)=U[&eoP65V&ui6
Wi_9tC/3aKDq.+32gLNP(4nW8ur2OJott86OE3aAKptlBQGSB$1ouEN/e/UrjhpjE'S:\\iX
7)LieL+s[6*dH$M+@+ZBnOt";:c#X<@!ZCB,r=0]AWfb$s:r!3:26A6f6AVtCr$`N7_TfAhJZ
f=<U\Gdud%BUAX;0m`hC!.]AY>o%\^1t6edB\Qn;9,&,Q'&+po6MLa[h_7*AFeZN24nUZ-j3-
8orRc;bE]A!M'pu?Pjer.)h%RBRn4!g11>Q2hLH<$[5l/%J9;8+]Al-</^;GVThRO9=5K)?&;6
;PZ`qA+`ea/]A]At;g5LM:U?ejQGV?GHp60N]Ai=f9^Jm?2#s2a:\h@_%GLYlbQ,C(Gm"*'NU>=
4C*]Asd8Q]AIS,cO`RGrC[j.[oV!;H'Y#'aVCcU&!rsFTrpl^;ICt0?kX5(0J;eZoH$Zgb(V1%
V%)46W"Db_6mIPQI8K<gQD@`kDpmkiU-&98,[P0:[,H:XoZ*g]A`ER^E\IXMl:5knK,+pM/;^
?KO.2:UXU(,?e"o?bVg?-NubSL'Pr<]A`W@Un07\.j]Ae!=t3YV-\*rnll1T5ME.U/?%o'%MQE
nN7pD$]A-R9ILO]AP7U?)!5m6CDoE\,SIo3nU?;Ln##AjY@?F',$_sSGZjNf5tlt=\Y5T'OZ0+
;(`FDB%1j0Vm7TZ>PM6[:L7@P&^t)X3nOIn:Yed^9R"-s2_9iT29-U.SP.e2AS]AXET-*@bcJ
\i+1p,&ud[%]Ako4GD86'lc=H.u/Q&s(6;X6b/mN*tPtR;[[tC+9)l_%9^&`k;34f7&mm+RsU
"f&j^&h;p&sIK(7AmJKa01ggM/^EH86(S"nW'$<D%D[P1l&8QE;c[hoSPb"=]AVUgQg=sdN)0
n<^.66j-ZY-G7\gG6oNl9qMlk(T#Pifi^$`-'*>c:ndLeL-L2q0PTl]AkJ,D:9ic!kg6SQl@I
H):=ZM0eQ^1[8'.nuIUt-3^Ut<IUHC"B;a.`9YX$rh<bLfpKFYAQbjt1N;*@r3Z0%>6+0Y*D
dCZg^"m':!or-\.`f/X8q^52!-#p`H\8#G?^lZDqNT@Pg$Yrks1]AieY#E]A:bnu@jCXMG1X-7
6c"iVpoE%03cA*d;TsY3Oe5fLV1X]A?WWaSA<J8@#;plVE0-Egho(U!</-mmPb:.BjWu[$^"'
.W[Tr(fn6%@*48?[RFg1l?A/8+C+BmDGh66tM$J1l8osIk@e`U,P3+XI+i6CH;-_mEM;9d;5
B>GA1!]A2iArX3]AL7^LR"BpF[jaoI.7nDI!o]A6'OG4#uFPaPX;Zij%pAO-lV&i?Q@.2__EA.T
HH?]An2@nO2dOl@-"gE)V[iC3?Mo1Be6dde3R.iH?.0"lqX,!&.1@h5s8e,S\5d(IChAZd_1W
[Rqq.hY"P+bT2?/-JWKR.?(Nh]ASe$K^:fYSfJ>&RAHqFs9;p&Em\\WNC^\6aR*rgD4#Q1U!J
k#jXVKl%3ddF:"tG[pE^;u[;_pY<A0^@&hOWo]A6gsb%bsm0((sXQR]A.uHnC1j3J@om9e]AE=1
GN%2'A<,aIHhOaN/R=,cCS_Ef[GP[RT^1aAA]Aub0!pWgQI?X>R=ALUcnZk!MTo\Eg'X13d!q
t6*J5A3_^*gE4PJ-AG[15J3pVd"=3QpJ\P;pq#GFZf<ne;c^D")@!6=_pkGY_tBoQrfoJj(k
m;)Qit(WBE/>_=#0F`V9'%U7fV5SU`d@8]AUO*JUSU8k\aPN3_\]A*;\aYtILZ@>lDT%SU(`p-
2Bd\-[MP4(CNEp"&!!5hh=l^cK0j5,5.cAOPB#s$/sSqR@-DdUkK(6g:#oSGdeA;5oI,fln)
6D!BKRD\K;4a5%2?^8fX\m+q*46F,GagP<9cg?bLfl(Ta'FKSF#pu`-uI6#/j9A;EfFOXdQ[
<$K+$_?#/qT(+j,*Qr>P0an=\Mmnl;BK;lkdBLu#&RUn-j/60?oO,IE;CuUpH_+mR4%d4pB2
aV;=Ul3J)Rf1bmO+Nl!Kehb9gMJO>*)"_pE`K34351j`GA6f>.f/tZMGY1bV=]A-Y8U=0$.Y!
#@MY+=De,<AAA6J37K_*,Mn>AW%.,-W?[65`<)&-E0k_)(<r9m%7#"H:WgT>3+OBk.n2pQG"
if,M4K[eb\&MkQ&?![sW@P\SHrkgNBBX'Kb$)T@?Yo@#S6WAYpCqFNSJG,/CI(.&`MQ<1WJB
Ugs/ttkm-N4`1Zb?'Z+(DUJ`HEnNP2OjSju!eW%MKW0`Up::99h/f6n(WjYJe3Q[rG/IF;lF
<#(;U]ALB%?O]AD5/#2=1*D)PEab'9cffVfnZMG'M=phJt'pIKaiNr?"aH9*8X,3s'4S4\e<:?
5o%0Tb']AQjps`aOl6/tjU@Mrj]A:No<S+Q9WS4\1QH\dfV+%OFg9AoY=$@(S#M8Y7_$9Mm,Oq
[C7Im!meXPC21tO@FS3=24Hi-[B/6LBKBD'X[3#VGH<U_1)$Ie>4]AgIQSBi0WN2RA"%s7XWp
iFWMs0sKIXfIkJG5OE^7eIWG=U$BlM*eo1-H="-!YFju?oKV*i_7"[=J]A9Pdgi=C#2QJBOkt
D9A?Ua)pYCXu-r)^Qi9_IQ7#Ct-PZcmWh[.PFj#::fM7%\]A@T3JYTQ[H%.74n\&H%9FWojE^
QnrmN0&oA$fi?EC;@jm>/Yp;'NE")_t'*j-,=H8IMRW4i4[,K1G%Nq_-V4<5nh[k>`T4[DEF
P3RA=*,QR?IX),o$/N[5b:e]A+,D.V:NPhDm03bj]Aa`0?i0K-KLOSoQm[m#!h)16T_),9aQ.=
7)>J5<#W"bX>$V=@mp]AC^E-%4/?+l-+IUP&)ZgSa9lejP&]A7.G:##1bB>rLA^1=?U8h_:3L7
a3?-/F^t(^a3?.+(J&ks`uaD`K((\>1K!9j!%jADh4%J3^!4O%W-,GOH#Ds<"QRmJ5Gn,Js"
#1Kp;"(u\hJSMR(I^#2FJ9(EK-Pb^Vn>7(J2j$mf"aH./bO?.6K>9>B)7%^LW#8qU?I2p6eg
Bo1Wp(`:GBO;ZS55gC3ZWgUC/)M'Xi\5/DY6p4G?aR'pG@`:7MVrJ_WB?\NSR8G<6V]A6gkq<
4)>TOJQL'hqEssRs'(N(UE*>XdlY(]AZe0>E<$4PeGr[%Gp:?=UFIB/.7P=<YGc;CjYGEoS.5
<T'SJeI4a\'2c.'i;3)M.9E-893]APM$N#q85@ZDY/O%[&")-U(kX`RSI]AA0_-C0"2lT[)8@3
,hp6bYQ]A0(s.!?]ADqSfDp.<5.oU:nOU36>a/H$D^(GCX8JWGZ3icP%aHbW$g2!suob%Y/diQ
=mk$X/>A5Ze4d$>>/lgfF%,`E0d.s85TGD]AkRf'^.V%'Ie3::JgRO2.`[p:7bmb.HkM?#&!)
gAkU+/:-3io9u+^QGWBO0;+h&!DqDaF1]AZ_6Mj_mU,iJKW^m+Ur0IORKF#iJ&=dU(fr,'bWi
ZntpU\30*8B,:fVb`2VOmA-QH"CA_kWSYV683pHp+?/jIY)@h*l\q`"H>+=q&Aakh/mEbRlG
b@%31p97+UH'%=^T0o')Xgceh7pRnO@$0X3C94R[RmIfT~
]]></IM>
</FineImage>
</Background>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList/>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="1151" height="65"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report3_c_c_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report3_c_c" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report3_c_c_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[店铺名称      营业额    同比    毛利     同比]]></O>
<FRFont name="黑体" style="0" size="128" foreground="-16711681"/>
<Position pos="2"/>
</WidgetTitle>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[KmJ#,<:ATARDgm?1:E-iaPLAqM%n2W+_?lafge,t-m?eC6APuB@bO8:Ou5#G8n\PTCS[&RA4
1[f9RWMi\(C6I4jRJIk1o^=]AW_)&^9;lQ/7m.&@6kbs!!%[(bY@g5!"oG8LenKcJ!)GM'`n@
b_%rnYgU#MHp)QeI[S(8(4F"jBi/UbIi<Q.pcVD7BCKQ!]A5Y6b_&VElJS05d)0M"KN@tkh''
TIu?BeVu_DL"If*DNj`X(ttAX2?V87.`.Ydk9S-3G0=,qqNn#luW#;CXqYa`NUn7eNUYO_(4
.9VoIdNHoBW'Vto"Bcm.Kc2q@6cG:ZLW!5!Z*8kp3e$n#@8X=rcl\F([,i$5_BNe1=QqR%aO
Y5^kmeeC8PI*/0q;3W??b6rnIX=Z+:Ktc@_>@PbdGnSc*Hf<A=N,OI-r%8k_rGYP,L`!eM':
P2nDH`1HdlU&<#HJZ^gG%b^qZs\mpKoq!r<*tS1R\+r(`YE%>"T+HO0_dT&pF9*Vhd:;LjM#
6g$XDBA6\_%(Hej\H,t!L0?C89c)3XUL4W*M]A:.XqYlR(LKi#$&1EX]A@F'HL2!-dGY1e)8K>
*sZjB8e[E'(m.EH5'q@%-n!p<Y]AmBIkIbo"J7n>%EVeLpF)JKfnVdr8!;uWMn;/.A(7X9pjR
K"?ou+<6g9m%=\9_o+XI-"5c*K#-"m=iH>Im$p^g)Mcd%CI`/W=g1LWQ[\sBquIY_B_(+!DK
Znr#8@%uIUG(a*P1FRq_6WK$i.>M2<$DC3J168686@8+sorc:,=nh;j_'5%/90<HYH>#2!rA
$:a0#H($r+J:J6HrH^,ia4sp'uE,?)AO;p\p!WEgCCOdUl9UW9ni%k#tDtT`m!d!SNJV#VU7
\RNk`.r<18[Q3<Yg::,]A>:7o;9pqjIO41a"-[Qo>R2JI*^ah\,@PU/I4l_bmu6[-Kl30%L"p
XYtlZS#,]AiJSbb#MMUm?"h>9EN"9uo6Ffl#XoW83#Ve=Xm&'8Q+k(="Q=qrCVkBI`cONY6Dl
3)46@6fd9HBXXW#>3<@"EVXH=:(^ZcYqA<B]A\')&OCWDoH,7q7Dbh#N+Ge^HG_#&qM@7PN/&
]AG[Z'H5*c;a7jG,"BY&U,.f_[dBnf(mM>lMk]A)eE'L6:,a<$<`ot,X<fTM1:5m]A:<91'^GHT
p>Inl'#o#gMh2NRaTQM2u,qP"I<o4dua#,$GBeF1]AqC&GUGE*6H/@UPS8$J_5`$r-AIqRZ_=
RK5a/O57U$oWgQqmANAE1kTNl*#YdWVQ7o<EUm"q?9n?NDGrV>Fk#X&l+)9)>f4CPOEL)/j/
081d<]A3OX4Rac8CV\f=06`<tZdu0*+tp',c1.3U28g_8Vr3!-!V0:aYb>6A"*!3c_PGg-m:[
V/0thuLO/pP4^qrBH/g#bh6EZ,H@*Up0KKaSJ`=boO@1b.BZ!7gdS=J]AB;U9k7/\k6l-FfO0
7md9-Y;D'NcgCniUp_%u]AFN&3!P@!+3<g(O+6\3o0$g:D(4kM>a(\Z(^:6L>$HFrKE\(u2>S
cHJ;s7J%Q%aoO&d=cX:P)PVcnK[9F#c[pnV,7G<GabIgi,1dK>9^0ADl5"1n9YGmGRCQ['>@
U8'eO0#['V=2g,_eNQL#`M'H^rf0h<nlH4%^6-qj0iqHF9HIc8um/mO1"Q&%/>qEgrQ;U#tP
/IJ@bk2SD)G+WnHS:f*SdPTaQ)NpoiFm$$5\5f;<GdfOdm]APLmHXVRCJlr0ZWNQU@kXL,n[Z
6es+a%G:EQ<U7LW9pYjniY-$3Fh5N>mpqS&?$Coe6\ftNA<.C(4h4ERZN7PdZ:CDh'$L'e'?
D$DYrp>+aeESWf*/="5c0-Z,r@>GMs.<jmW=uDA:HAhJ8@7k:cnX2L^\/m=Ns/oc.`3l6Vq+
598<,Fd6e"bpOQi-I$SV>WaL7b2KJak!MCmr$;.!Orh,CTM@b@-`c=&[TM**k?iM#nq).n?(
flRG+@G&)Y:""f2u1.qdfT56h$bT`mkn\K`+Rm?R(p1AsL@m.'=N,XY6Ap$i-(s*$tKO@_P,
jT>^SWBJ&%]A-tr^/[7Moipse<p'uQ,(N+FX=?3l9!6fDH\$>LFqe5:^VUsuT=p"SP^n2@r2_
bBaMrk1?H8V'W0Pu*i-Yc<*0pCfFp)OZ4<Zjk,5gaB8IDOA&`,pLB`5CZa`fQu(@#$06`"aQ
FYfjf]A+sgK>3&fc`i)0ck()a()4?*"DPmJNrHfC,H+KU*0BupheQ3RR?"4bTWDo6\O[l;$d4
I(aDXiX,lt7Pr0b?_7oP:?"C<\f=_LeTj[Hk/UI'C5pNH@n2GVWi>3Cn9I`7+\+[juO#N`=9
AF`7f6k6XV\U*GL[jPaJY8O`hh6h"//8I>R@]A[j6hnpmQO!3^C4b&WX23fkqPkfY,TrsChDV
i=^0&q"78A!,:EbQThbE*!>4.rj-+n6?)0VZ`#A8e)a_Qr9^Xf%cL#q2XJZA)UFsKhuX([El
o.8/c("^fP+W*6%V'jtK4@)E."",+('cqA"Zt1V+OVoHN:M1VGIY)%!P;'c[IT0T#T01.;@+
.d)CFH^c:>*$2#K]A3'nScegu,F%3ZI+tk'b'Ji<L2?TO+*k,5aTEc)qnf4]AABk-.D;%6C)75
J.ihJ%W&h9%G,i8+JfYX3sR78>)D`N7G%aJ/PnkS,4^CN*GUH=W(G.S2p84H@6'!:G\]AYY1i
13\2(YkeuXMA^*giEfm/p#?0@l_`UI.^t;p9jQS(U0I%g'Tg9Y,*-0BF'e\$E52%HVPGf:P;
jUJ$<9d&8g[bZ:#hCnsOr*r$gmglfe3KIUB"\b5JM=i7+>`UjEV'0/PKa\kH$;RFZ7lVV&=5
YG3NHuno^Kf`I6XioreNqK[7#Zo9%Z@<ASUtb74Z`^pJ-qJnT$7$Mt"c.KV)o_Cjm7"NDfr"
.tZDpdBWc1.&Dl2f^f=niYEGH""tnaiR'#1dTN/\6;g5\[ESaQBSR5[l.LoVa0S_P6Yc\[ki
Rg6H8^luFGkkU!.:<h7ClsWe<UC.)\`"kc4S@pPY\f7.A@d^GcRTg%4]AH.`g!R9:O,n/@LHB
\ClaBQISP4A`ZOs"`;S]AK,7BM6iUQu1G0W&7C3/^'$rue'XI_u:acWFHSZeSp?[DJ`TE+nT>
HQX@e#mfH:"VH2*@\"$@D7`ALqba/$QFNm5kk&D$ioMH4FD-=9S?S3h6>a#3]A!GRC]Atpe03n
U/(BbO:3g+leJ`QOgfPI`ipk11BULrF?gG.;QmZ]AI,F:Y7\^"8m:@k;j7b0FP)[:)p:@so"!
KBfQ(9PL]A`eZ/]AhP^<Gm.A7rD&p`HdC2O+GDY%#F@GPppUl%j3"T"u1\*PX7X$$Lak,P<i9>
`!7?p"AOAR*p)?Hp9^g.E6?323q.c(?%*HZC&f?S[>of!*D_cl`k=dLGYZ=7,uD5,DN19%m7
j6@PCT9\iQ,T+?r3Zh.lDT7R&[_PWW5+IHu#[)S]A6\p$;OE(_ci=BsInK"epF[aXnKkm$bn;
2R?['X_e,56*gS&;\ETT\'Y50N^aJ8]A<[Eg(J)rgr9@\#k?W3Zl>PfF_ZB1!/-ItIZ%45f3O
JXO?2S=e5DlWOWN5\CQ3JuLGonn9!JfRP]AfZ5@-]AJU^cF-V"dAK0Y4=Qida)OFf$K);'"Iak
=6aB<Y]Ah5fHhJ5gQ,<(_j=G-@!F^j@o+P,4e$'V#n$rRn#D4=X9'N#'2R)b-@Yruj#&G+=R;
SCup8E-CgP(VZKO]A!o-=A+HG#!Ga)oYZl10[g4AmK0e-(LkRd3ZU2VbdZB-4=/2@:d=j7b3Q
_<5F25pC+m.f4&Q'&Q9hU\/etSf*a;'46YMb1%]An)X^[Z,6V<Ur1BD0GlMX"QK)f4';ojS[#
&Hl\aF-?h,O=Yh`^l@W8rp;q$X4UI<6B,!8\,T0Cdg/g$/d,3C^,TU;nJfb@r4jA[rI(p'4[
:h5#!LV2isblqH[i`]AqI9053;B$KEArT0LjMuO-AoQkkaY$CVB`1*fHaT-7,Q/Bl9<@j]AuO"
02R5?'\T`Yqap7Tb`Fg^C^s/Qc.F]Ak(6&BYHp">QEV(X6I_XWPi0dj\:qMd%Um!&n**KRVMu
[>P,g]A"UI,0X8iIm$K>\#(fE9ShV+;n)C8Y,Q4F3fPt<hkHsQs]AQ7hCEtE+=U3\,FhKHDqqu
1H?*1RG=:&V4,t@eMXb!j5laL?VaS;Zb/:,?WVFjp7,)Zk,QKO178^uPWPTr1IXng"PU%a=)
Lj^$+!4e[4n4_/E#`e)Id]A-@ZGV#2A6gWkZmS.9T`XLVQAW9p!3dQ&?(aFRr02E%r9='k:k4
*aPLmG7=F.E`(`!;%%NeRR_%b3]AjZn/U%FEbK5'rb&#m,Vc"X<%P6=DGapaA^E8]A*'^Y5r,E
!3,W]A(c6$%"YQb6:s8T%:(:Y5]A_.4/8h!V?%DJVA;2O33W@b;;lE47+B&'T^iV'H*..<9`R5
@q@\\Gq&V/oZ$I!c$13u(f%aG*ebqTTB&dB/>3V$BmscDuerlHW7p"YeY&Ye:muDVTW\X1*!
T<BT+9Ie#X-94U7g#L=f>TAf*lfPrcYXrZGZkFc(+#Nm!?IjlQ[%MV1rO/J&Xh.Sl\^Kj/@<
8MN19ack$+_!HH[@)8%C]AKZ@',P_9!$D=CM'hb_2Q9_Mi!<+\E>Oe-4BV[e['Akb)'+O*9@$
;j%gU^Zi"KUN1h_s.D)(]A'HrRf"BkTh^1\e5]Aos3W+*B0q1b3la:)Ve3-0:28#DR<0rnRUeF
0ht$hbda#c?,FQ3g&<l1eWX7.p^E"4i5l(?*^E&>4Y8?(5Ise5+`A*#+969H#gGt%]ApCM41k
f9qS@O^mU>a%''CPUl[=_"P1uN8/$>e3L!\[l#>h\BLPqBp"`[Jh0p))T+<QfEHfbY=/7Z$F
=La02I57ArU*cF%KSX$:Cq%aFsm-<NP#@DT:/[)e]Ag%!rj,X3YFD/K<#J\RoA.m3NMpo5UOL
$u="auI8nLqKot_G.f&H*0-1bu*J>0(6k)GuC'EQ\g>"hSZ+r@C&,M!G^b_LgWdSn(mcl[rQ
'!6a8!X2h0f9)NT06hioZ.s3]A>Kd(/tASaR#ja,3c_/r+ojN5sA7)u7&;A&.bi05e[_m&TmX
6M!C(^X:C0c!EJWD$8n$-"5&`LBFEA20tDoBeeC&En"P0",e;*rgSk^1K.Y#UU"(]AW\#T@iK
^JTl%sMJU,09E=;DXWEd!\p/6XGS,8QGP&RT`PEfXDB6j%5o>HT:PbD6%CI3FE97^gEKicIp
YlejWEjgutp%[,RoA3JPPEXaWQ\1p=^1f/\"Xq#[tD>9T41`SHh/Ik:DZD&%N@'A-=ZH<eYk
,pZrRJGEtgpikK>1Z<_Bb^e5<>"$r]AQcD&<:6B>cJm/AMVKN1(^0aaahOEOR29*,4Co'1,I>
,1n3fKq'"B&Y*>Esd"[?CkU-7=FNeqT$hAGTXO6b3q`F-cu`:Q=$<Y[TaUOmu`OX"m64k1GT
rN_e5F,:dDKKEs(@Ej3Lo_[Ud5C$?uA`&]A^!=k%,dpj+C3I3`qV76[hBE9@LY^(>#/.D@7qD
6L0JBX6#_c1M5X8hasi=R\Z(]A5K!iiac5_`eTYqI.S/Z.$;IZsO3QFUI-<Kd]Ag7Tu?\)/U$F
7IOu\"6?,0$<Rq.E]A5Y9q-C=".kpclrUg;!Ef##quad-c[cHh'6LDi60))j%\BP_'V^T',"n
02$]A:1lM8ETEPFZl**[LJt]A-r)^$_+ma]AWSLP-2q:TsU]Am2GP9d?_2TPG<=eonkUq"1h(g#V
Yh+]A6QO7!e#./fJ$8Ir4UKTI]AP;m>.V%B/uGK>q<PF\]AJ=+F3mRXi&-j(Km*WumT2-]A_O;EN
GtVdU+^9;""7/bW*RIf)aSW:8Op.0_lRW=7=\JS:BUt6:2=SL"@Xh4-H1'jZh!&YJViLY^$d
'^oUBo.DcWNG:#KP'f$F)r*ebMrU"^c0VJm'FF&Tf>IiH$H7$b,l>34^Co17iB(AAInZG6j)
,&#h%QW8!(0)e`ISqmq%f<W/DY_k-9Y+j&r*UQ\u>lnN.<K(AR6%-Ad0Io;$DRWF*O6jr,6O
m&fr$X=,/8H.R@%8MC:Z<62<`7"0dgsN;+X]AIQs\UYBo^;T8k[0.P>lPJ.U=)Wp7d1$fiTAY
X%i,%nTs"r)m-Zbo\^G`Q6f;Er+02Ok<"LXWdo#:U9:nWq.4mW`ooC,^,O4#Ls(t2,\bP.J&
Vmu,9:uK+CVE(J/R9M*.7rkQ:<;iPP]A%1?jG8u6JK3GAVf`kfEUL/:`k(S<<*Lb=o^;>.Ud:
^`l'b9?YcHm`doW%:`Wk>jsf^N*)2Hf<q(Fq^"E*kh/qX);m,$-A87s(flA5KI/5p(5oM`GV
\LXRj]A+s)N0htDPEaSQD@2nBf^URq%F@0_Ee(q:Ct=I(@C(/).3I+@S[Q`C`0p)71;DWkA/e
8*N83_pm38pI/0l@C'r0B+Y.;FIb`VZlu!gZhT*X$'$N8uFV7\:q2;\_j4ac?U@(SOp"gftk
p==.k,`*OfBLKO3[3\6$Zsn-jL_`^1#tJiDT2P<If-,.rNQH+N1ubl=SWr@snE%^*CZ1E-J7
J!ubuNtbjeqCS2!<-S&,,+m'7Ms<Dq/Mo_3O7RHiHBf/Q:lk'Vif_aI9;8.batIe1ao,G/@7
sA6$Tt1I`'SX/]ArU#)khi#"Y1c3CqOU^3rRF%+g^VSHJ[:W\3[(=/1%^d"MHCoIpKs`6B<td
'b9`aRX[GJgfCA]Ae3tD7^Nc3ZKE6Wt^:S+0%C,Jg2V6bk'1/WNNU(/6W3)4$;>u0st2Cd@t4
*#M\MI'2F`>c)g4H90SW:!(Me;NH_l[MY6dc!4NIqb9+T'dG5'i+ZY!`Scn%AHhrLusQ+s+k
rl@aIV^GhbOjon4:S`h.6NC"*a4a2Q#7d]AV9H*]Apk^+.3"2qc*F$RR$uNHEWcCGPi\*;ltV`
;r^Xr<Jm`QU0JU/s0mNSKtZN24?78_k+>[LS,3calLi+lbq'Y#o7u1\k%DecaP^.T4ON[Pl2
?+-9goPgF'mbq!e&C-Z1Mos?Je\hIui%Iqu>0@>m0Z4l>qmB4]A2J3\.0M;7^k,mY.:P>?>Qh
FIEk(!fa'MEpLm,Z"LIoAo0gnh&ci*cTMm\Dp)eG4q7d3Zb=:&81"8tn`#4144.W,2h>a!H5
G.FX?H&a\208*^=3Y/.^IO$s2-eT`PlD^KlKI,[G5b7L>b=PHor/do,#+UP7:,/?bMAQNT[n
==#'_j%9ET(;ghXE^ogH31?$c6`!Q;,A.nVMN">V1WTJHO;C1%]AFBU%f=r:16!U$<qc*^0oE
([2t0nSl(.#O,L*3%Cba56[B3HZO2[M)pIP*ESkOS2fc60G/]AcIF4qK#I=1`=S:A\]A$@-tdM
WRB53"hD4H]A1cLu8@u=gqF\_o@dt>\e,\f-5&Opt?P[bZ\9GFXqNQ1OmQc::j%0]AL;o@=I&F
LXO0_sraAr3:Uj2)lIF;3LP"@bb"",Cr2Rkej.u5k$ka['*^d4YOJ354_'PK*C]A(B#OpZFXY
Y>h4M71Pq7^oal6h0CNnu0Z,'U_M/_J.&*,&d:5AEP-?l<3L!G@BjD]AZd(TkGiUr[)Lk!q<2
99179Bg6U?lAVMbokdokt'D7Ra37D:e")0*r[M5C+B/><U(I4"0\^eBHH/1c/5K#(DeT`NVH
WZ;PD-uC18Ho#1`#V_^g-6kMK_)1ISP>@CsRrXWqmr&7ljaXIHam=Y?Q3tUH=dU5kYEf3F-H
s@N9K?'XU=59QH?o;^'e>"b-C`*EoRZ!2IkJr)U,mpSPUkVpSgLur;&CuEXU'<M/]AaGR;%/+
;'LIsB*&b:)j'-8TO]Au0,W,;[]A_Ei3SIOXp[-El:L%j%lGUZ+-b0R72VJS\3M(3GD:Ln)bWm
tn4hL>!NW>Ac`.&t(qXG>uB7@Bn8DXDp.D0EG;a(Y!8kV2(pb5oQ@C"kgGq:M;DF5#"_MU/t
VlJ*Io._bi19,+AGUNILf>bB&=M>gDkML?,q<JFE6&8+h;K6#lNQ)n>\3cQ5[6!;oa7+2l6;
k+jK@N*j_cAC3oO?#RZD@77Pn'Pc8Djnu0Yd^s$6_)d.=dm;<rZVAQRiPHr+fU96@!L@ER4>
7C8-[temM/D[nYDSp`m's!u)]AJBHfOSOOXptZjo5EC_`;HSh1DZqse'VELWqe5;'17^#VcdN
h\R/;V.P]ABD5?k(@^=BF3r^(/aPXS='`2)="H=c'gAonoXGB\4SYR;/2FV0=^aQ!c/G&1@Wo
@JcgNI'KAc*!&'q:OXRQB6iI+r<AAUeso6V$osJTl$rq0Rj:<q(hSN-;(^.hM#!D(d]A9Gf%<
n!>r00_;mP@]A^DDX-iInZ"#dqjM9N#ghm!:@1;R&jqI8=?6&ggHOLDui*JPg!A!1baVqOo)q
<*MRmqfVk??!B[TnWU#q/PAWm"r<Cs`+%+3)Z.:8qfTVo[Y:XKVQJC<&;*l:I#mr?^6c(q;9
aO#iXVr#+DIWAVK2BWA\WnUJ77&tc]ApG*+kmXG*%H$&lXs7)/AbIt(/=OgBQ&S&O6tb,HMi/
8PSbSXg\%piHr#(Q<5h=^=MP__>4+XrOW<ahc;**]Ajj]A4+m9SSnY=2t<)__p:qlmM`a!f:+D
]Ae,#)J!?.,f<<:2"clbJW7E2ONbs?k=,3q@oYQr"/9c^Oeafq6sDuGPo*+p:Gg]A;:Va>QA<3
%g+3GkFa6sH>6BP&8VSTGM+Bs=V/[mZSgO-%#H=KWqPnme:pho:l,HK2dX#Q_W0']ALa%IM+"
`QPNPd&cU-Pm+#IB>SOE/T173.=6/EkP1+>H2<k4@h?F&/8V5\l^"ChSe$rJpZo3-bP9G4fC
pB'Uh/Q=q1A,e8&t,`S['>E="3r1B;]A:H]A="s1=j%cUc]AWU`T3FK2dQ13F_Pp'Q]AYRF1PBHG
/-uC@@J)kXsP[*FucL98Dc*%SA^]A-91'+]A^I,+Wd?1+e$(b]AXBjh$[K6btK+R<%s\*>,EU[/
-s!J'_=Kc(TI`5<3Km58pgoYIMe`G)Q'55Zo8,d2.Gd&*`Tm=?Z7>Um?Hokl5"JjJ-eCT7kh
<Fr5ejKh\+f#2TM9AmCtD8B9QIM#EXg]A#bQCsARcpVCo?(daS+B7bfbV1N3DjYYBI<2.8>;u
`5!j/OiPNKiGVn5Sf_)sF_t]AqV"9]A*Ek-9bd'-ud</GcG!*&:rLa75\r/H:PaY?^d0<s4!'o
k?/)r0^^l5HthGZj6\Q+<h#r,b,G<n"[l`hRWF%ga4uoiRub!@\hdhIPF.Tr<jMNMMR0h9>[
e5ITmtE0F2YSXEqE8X)pPMu,R?/Ap%QUhQM.JkaYs6?^:6<LPZ6<)nI3H\Ft`=,?a#Yp8t'(
4S&rWr/pi4@rH7$4TTJ4KY3U75HcoTnfZZ.]Ap!so4K-m;)$[q"TkE#ZOO#i8$Mh:2niBNP1&
jd*V9fA!7UhkmK63b.qTAaZ4pt^0>sg.\$Sr]A/V`E[+T&FmcW6?j#G4gQA2?YtbE"`V,[ob5
.Tob*^r'G3EZ:hT!GmW<giU:B&aUY4<^GYM6(8#:*d5+plicImL/Y4rj\(.P0-AC#QpJ.hee
:\Y.=Jb+mA$W(8!2Of(kj?$eAaQtQhoGk'GI>\@Y5'N]A$l>[S*@90jo%qBB"hC@>/#FeRh*V
!+0XN%r#f$_>1!S)LYAb<^/5]ANb!f9;Zd2p)TJU>hIep^k_9mYU)/+I(>n<7/QC$;<!@P.'`
VA",YU''JP6<(g_`qnQCtiEIprDYY$A\6G[(uC=-ssM^AOL_6K!,`"Gc^r!4`eb"?3@2b\qF
)$HG9d"d6CVYbLK'h$p9YD2-jQA8s;9!Y@dhjO9fQ0R,&TP5UpnVCC^*aZ.m5T,Pb/?Wklt?
l1F!3FPY;6)[?S2+oRG8`0MctN^Q/Lm0"mEOXULi*uG0.lL5^D<Z]Ao(D%W8i>Yc[Q^lN&7+6
K*biE7f`2)8HG4'4/C\pRoXMtEph&)OM4nerifRWBJ6^IrX2kC_&!3^-]A'n/220**L"S1V)e
HQfTl9VeCQMV1mt%!HEZE]A)/nW0=)cq##WbKkb:#;58.@dYe^`8VofYZk"t;U.+ReaO2M2N5
%(iqjB6`%*F%.`UH3]A/DhURI@'$O[YRWc8,D16u!>)Al#;+-:[,Xi7S6*kC_og^A6[<1RY,=
dL01$(oTjJ-:OMQ><)oaAkH^JpZL)n7=CRDL+ro%C=+hZV.$JuEh?Q+ZQ3qSZWH-8.g#:FF2
n!p=SB5&S@9UKtapA(9Y6aYeLXkXB;G.j4tOPOMX*GSh(!?RRH74R\B0<d6;XHuB.jW[0uAU
Eu0I-Zc@\GC8:5;Tb^;gpprSY[,P1C3o9h+"Y-nd?0EY:C:BJe_32@qhhpcJ"hadZ9EEF^B^
2Giqg#O?fB0$bP"N`#FK!EKO%5U8roP/a^nr+#A65SY(oSf0/oGSO;9UB?o6lh=iQ]A^^:g+D
F_mB]Ad(JYoP;u03)A@]AU.EkuOUQ011YY!oFqo(rdUVa3?@5R5&uC7iXEn+c.X#%dLY%T`IMM
K2b(NWX-g+5*GM"^$H>KOV8McfKmC[:OmF^P"2T"Xs/KR?9*60a3YrDF1-`]AZLIoa98KDB)E
Xb-7<od[>:rK?*XrNbMS?mM"I&`pHpEU/I"FDBnP[6B9!kK&sSFcBTGBCF\\DK#9/1TEJV>"
+rfWQNOt8DZ%!KEkGk@`KP=Ht.B?IfT~
]]></IM>
</FineImage>
</Background>
<Alpha alpha="1.0"/>
</Border>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[KmJ#,<:ATARDgm?1:E-iaPLAqM%n2W+_?lafge,t-m?eC6APuB@bO8:Ou5#G8n\PTCS[&RA4
1[f9RWMi\(C6I4jRJIk1o^=]AW_)&^9;lQ/7m.&@6kbs!!%[(bY@g5!"oG8LenKcJ!)GM'`n@
b_%rnYgU#MHp)QeI[S(8(4F"jBi/UbIi<Q.pcVD7BCKQ!]A5Y6b_&VElJS05d)0M"KN@tkh''
TIu?BeVu_DL"If*DNj`X(ttAX2?V87.`.Ydk9S-3G0=,qqNn#luW#;CXqYa`NUn7eNUYO_(4
.9VoIdNHoBW'Vto"Bcm.Kc2q@6cG:ZLW!5!Z*8kp3e$n#@8X=rcl\F([,i$5_BNe1=QqR%aO
Y5^kmeeC8PI*/0q;3W??b6rnIX=Z+:Ktc@_>@PbdGnSc*Hf<A=N,OI-r%8k_rGYP,L`!eM':
P2nDH`1HdlU&<#HJZ^gG%b^qZs\mpKoq!r<*tS1R\+r(`YE%>"T+HO0_dT&pF9*Vhd:;LjM#
6g$XDBA6\_%(Hej\H,t!L0?C89c)3XUL4W*M]A:.XqYlR(LKi#$&1EX]A@F'HL2!-dGY1e)8K>
*sZjB8e[E'(m.EH5'q@%-n!p<Y]AmBIkIbo"J7n>%EVeLpF)JKfnVdr8!;uWMn;/.A(7X9pjR
K"?ou+<6g9m%=\9_o+XI-"5c*K#-"m=iH>Im$p^g)Mcd%CI`/W=g1LWQ[\sBquIY_B_(+!DK
Znr#8@%uIUG(a*P1FRq_6WK$i.>M2<$DC3J168686@8+sorc:,=nh;j_'5%/90<HYH>#2!rA
$:a0#H($r+J:J6HrH^,ia4sp'uE,?)AO;p\p!WEgCCOdUl9UW9ni%k#tDtT`m!d!SNJV#VU7
\RNk`.r<18[Q3<Yg::,]A>:7o;9pqjIO41a"-[Qo>R2JI*^ah\,@PU/I4l_bmu6[-Kl30%L"p
XYtlZS#,]AiJSbb#MMUm?"h>9EN"9uo6Ffl#XoW83#Ve=Xm&'8Q+k(="Q=qrCVkBI`cONY6Dl
3)46@6fd9HBXXW#>3<@"EVXH=:(^ZcYqA<B]A\')&OCWDoH,7q7Dbh#N+Ge^HG_#&qM@7PN/&
]AG[Z'H5*c;a7jG,"BY&U,.f_[dBnf(mM>lMk]A)eE'L6:,a<$<`ot,X<fTM1:5m]A:<91'^GHT
p>Inl'#o#gMh2NRaTQM2u,qP"I<o4dua#,$GBeF1]AqC&GUGE*6H/@UPS8$J_5`$r-AIqRZ_=
RK5a/O57U$oWgQqmANAE1kTNl*#YdWVQ7o<EUm"q?9n?NDGrV>Fk#X&l+)9)>f4CPOEL)/j/
081d<]A3OX4Rac8CV\f=06`<tZdu0*+tp',c1.3U28g_8Vr3!-!V0:aYb>6A"*!3c_PGg-m:[
V/0thuLO/pP4^qrBH/g#bh6EZ,H@*Up0KKaSJ`=boO@1b.BZ!7gdS=J]AB;U9k7/\k6l-FfO0
7md9-Y;D'NcgCniUp_%u]AFN&3!P@!+3<g(O+6\3o0$g:D(4kM>a(\Z(^:6L>$HFrKE\(u2>S
cHJ;s7J%Q%aoO&d=cX:P)PVcnK[9F#c[pnV,7G<GabIgi,1dK>9^0ADl5"1n9YGmGRCQ['>@
U8'eO0#['V=2g,_eNQL#`M'H^rf0h<nlH4%^6-qj0iqHF9HIc8um/mO1"Q&%/>qEgrQ;U#tP
/IJ@bk2SD)G+WnHS:f*SdPTaQ)NpoiFm$$5\5f;<GdfOdm]APLmHXVRCJlr0ZWNQU@kXL,n[Z
6es+a%G:EQ<U7LW9pYjniY-$3Fh5N>mpqS&?$Coe6\ftNA<.C(4h4ERZN7PdZ:CDh'$L'e'?
D$DYrp>+aeESWf*/="5c0-Z,r@>GMs.<jmW=uDA:HAhJ8@7k:cnX2L^\/m=Ns/oc.`3l6Vq+
598<,Fd6e"bpOQi-I$SV>WaL7b2KJak!MCmr$;.!Orh,CTM@b@-`c=&[TM**k?iM#nq).n?(
flRG+@G&)Y:""f2u1.qdfT56h$bT`mkn\K`+Rm?R(p1AsL@m.'=N,XY6Ap$i-(s*$tKO@_P,
jT>^SWBJ&%]A-tr^/[7Moipse<p'uQ,(N+FX=?3l9!6fDH\$>LFqe5:^VUsuT=p"SP^n2@r2_
bBaMrk1?H8V'W0Pu*i-Yc<*0pCfFp)OZ4<Zjk,5gaB8IDOA&`,pLB`5CZa`fQu(@#$06`"aQ
FYfjf]A+sgK>3&fc`i)0ck()a()4?*"DPmJNrHfC,H+KU*0BupheQ3RR?"4bTWDo6\O[l;$d4
I(aDXiX,lt7Pr0b?_7oP:?"C<\f=_LeTj[Hk/UI'C5pNH@n2GVWi>3Cn9I`7+\+[juO#N`=9
AF`7f6k6XV\U*GL[jPaJY8O`hh6h"//8I>R@]A[j6hnpmQO!3^C4b&WX23fkqPkfY,TrsChDV
i=^0&q"78A!,:EbQThbE*!>4.rj-+n6?)0VZ`#A8e)a_Qr9^Xf%cL#q2XJZA)UFsKhuX([El
o.8/c("^fP+W*6%V'jtK4@)E."",+('cqA"Zt1V+OVoHN:M1VGIY)%!P;'c[IT0T#T01.;@+
.d)CFH^c:>*$2#K]A3'nScegu,F%3ZI+tk'b'Ji<L2?TO+*k,5aTEc)qnf4]AABk-.D;%6C)75
J.ihJ%W&h9%G,i8+JfYX3sR78>)D`N7G%aJ/PnkS,4^CN*GUH=W(G.S2p84H@6'!:G\]AYY1i
13\2(YkeuXMA^*giEfm/p#?0@l_`UI.^t;p9jQS(U0I%g'Tg9Y,*-0BF'e\$E52%HVPGf:P;
jUJ$<9d&8g[bZ:#hCnsOr*r$gmglfe3KIUB"\b5JM=i7+>`UjEV'0/PKa\kH$;RFZ7lVV&=5
YG3NHuno^Kf`I6XioreNqK[7#Zo9%Z@<ASUtb74Z`^pJ-qJnT$7$Mt"c.KV)o_Cjm7"NDfr"
.tZDpdBWc1.&Dl2f^f=niYEGH""tnaiR'#1dTN/\6;g5\[ESaQBSR5[l.LoVa0S_P6Yc\[ki
Rg6H8^luFGkkU!.:<h7ClsWe<UC.)\`"kc4S@pPY\f7.A@d^GcRTg%4]AH.`g!R9:O,n/@LHB
\ClaBQISP4A`ZOs"`;S]AK,7BM6iUQu1G0W&7C3/^'$rue'XI_u:acWFHSZeSp?[DJ`TE+nT>
HQX@e#mfH:"VH2*@\"$@D7`ALqba/$QFNm5kk&D$ioMH4FD-=9S?S3h6>a#3]A!GRC]Atpe03n
U/(BbO:3g+leJ`QOgfPI`ipk11BULrF?gG.;QmZ]AI,F:Y7\^"8m:@k;j7b0FP)[:)p:@so"!
KBfQ(9PL]A`eZ/]AhP^<Gm.A7rD&p`HdC2O+GDY%#F@GPppUl%j3"T"u1\*PX7X$$Lak,P<i9>
`!7?p"AOAR*p)?Hp9^g.E6?323q.c(?%*HZC&f?S[>of!*D_cl`k=dLGYZ=7,uD5,DN19%m7
j6@PCT9\iQ,T+?r3Zh.lDT7R&[_PWW5+IHu#[)S]A6\p$;OE(_ci=BsInK"epF[aXnKkm$bn;
2R?['X_e,56*gS&;\ETT\'Y50N^aJ8]A<[Eg(J)rgr9@\#k?W3Zl>PfF_ZB1!/-ItIZ%45f3O
JXO?2S=e5DlWOWN5\CQ3JuLGonn9!JfRP]AfZ5@-]AJU^cF-V"dAK0Y4=Qida)OFf$K);'"Iak
=6aB<Y]Ah5fHhJ5gQ,<(_j=G-@!F^j@o+P,4e$'V#n$rRn#D4=X9'N#'2R)b-@Yruj#&G+=R;
SCup8E-CgP(VZKO]A!o-=A+HG#!Ga)oYZl10[g4AmK0e-(LkRd3ZU2VbdZB-4=/2@:d=j7b3Q
_<5F25pC+m.f4&Q'&Q9hU\/etSf*a;'46YMb1%]An)X^[Z,6V<Ur1BD0GlMX"QK)f4';ojS[#
&Hl\aF-?h,O=Yh`^l@W8rp;q$X4UI<6B,!8\,T0Cdg/g$/d,3C^,TU;nJfb@r4jA[rI(p'4[
:h5#!LV2isblqH[i`]AqI9053;B$KEArT0LjMuO-AoQkkaY$CVB`1*fHaT-7,Q/Bl9<@j]AuO"
02R5?'\T`Yqap7Tb`Fg^C^s/Qc.F]Ak(6&BYHp">QEV(X6I_XWPi0dj\:qMd%Um!&n**KRVMu
[>P,g]A"UI,0X8iIm$K>\#(fE9ShV+;n)C8Y,Q4F3fPt<hkHsQs]AQ7hCEtE+=U3\,FhKHDqqu
1H?*1RG=:&V4,t@eMXb!j5laL?VaS;Zb/:,?WVFjp7,)Zk,QKO178^uPWPTr1IXng"PU%a=)
Lj^$+!4e[4n4_/E#`e)Id]A-@ZGV#2A6gWkZmS.9T`XLVQAW9p!3dQ&?(aFRr02E%r9='k:k4
*aPLmG7=F.E`(`!;%%NeRR_%b3]AjZn/U%FEbK5'rb&#m,Vc"X<%P6=DGapaA^E8]A*'^Y5r,E
!3,W]A(c6$%"YQb6:s8T%:(:Y5]A_.4/8h!V?%DJVA;2O33W@b;;lE47+B&'T^iV'H*..<9`R5
@q@\\Gq&V/oZ$I!c$13u(f%aG*ebqTTB&dB/>3V$BmscDuerlHW7p"YeY&Ye:muDVTW\X1*!
T<BT+9Ie#X-94U7g#L=f>TAf*lfPrcYXrZGZkFc(+#Nm!?IjlQ[%MV1rO/J&Xh.Sl\^Kj/@<
8MN19ack$+_!HH[@)8%C]AKZ@',P_9!$D=CM'hb_2Q9_Mi!<+\E>Oe-4BV[e['Akb)'+O*9@$
;j%gU^Zi"KUN1h_s.D)(]A'HrRf"BkTh^1\e5]Aos3W+*B0q1b3la:)Ve3-0:28#DR<0rnRUeF
0ht$hbda#c?,FQ3g&<l1eWX7.p^E"4i5l(?*^E&>4Y8?(5Ise5+`A*#+969H#gGt%]ApCM41k
f9qS@O^mU>a%''CPUl[=_"P1uN8/$>e3L!\[l#>h\BLPqBp"`[Jh0p))T+<QfEHfbY=/7Z$F
=La02I57ArU*cF%KSX$:Cq%aFsm-<NP#@DT:/[)e]Ag%!rj,X3YFD/K<#J\RoA.m3NMpo5UOL
$u="auI8nLqKot_G.f&H*0-1bu*J>0(6k)GuC'EQ\g>"hSZ+r@C&,M!G^b_LgWdSn(mcl[rQ
'!6a8!X2h0f9)NT06hioZ.s3]A>Kd(/tASaR#ja,3c_/r+ojN5sA7)u7&;A&.bi05e[_m&TmX
6M!C(^X:C0c!EJWD$8n$-"5&`LBFEA20tDoBeeC&En"P0",e;*rgSk^1K.Y#UU"(]AW\#T@iK
^JTl%sMJU,09E=;DXWEd!\p/6XGS,8QGP&RT`PEfXDB6j%5o>HT:PbD6%CI3FE97^gEKicIp
YlejWEjgutp%[,RoA3JPPEXaWQ\1p=^1f/\"Xq#[tD>9T41`SHh/Ik:DZD&%N@'A-=ZH<eYk
,pZrRJGEtgpikK>1Z<_Bb^e5<>"$r]AQcD&<:6B>cJm/AMVKN1(^0aaahOEOR29*,4Co'1,I>
,1n3fKq'"B&Y*>Esd"[?CkU-7=FNeqT$hAGTXO6b3q`F-cu`:Q=$<Y[TaUOmu`OX"m64k1GT
rN_e5F,:dDKKEs(@Ej3Lo_[Ud5C$?uA`&]A^!=k%,dpj+C3I3`qV76[hBE9@LY^(>#/.D@7qD
6L0JBX6#_c1M5X8hasi=R\Z(]A5K!iiac5_`eTYqI.S/Z.$;IZsO3QFUI-<Kd]Ag7Tu?\)/U$F
7IOu\"6?,0$<Rq.E]A5Y9q-C=".kpclrUg;!Ef##quad-c[cHh'6LDi60))j%\BP_'V^T',"n
02$]A:1lM8ETEPFZl**[LJt]A-r)^$_+ma]AWSLP-2q:TsU]Am2GP9d?_2TPG<=eonkUq"1h(g#V
Yh+]A6QO7!e#./fJ$8Ir4UKTI]AP;m>.V%B/uGK>q<PF\]AJ=+F3mRXi&-j(Km*WumT2-]A_O;EN
GtVdU+^9;""7/bW*RIf)aSW:8Op.0_lRW=7=\JS:BUt6:2=SL"@Xh4-H1'jZh!&YJViLY^$d
'^oUBo.DcWNG:#KP'f$F)r*ebMrU"^c0VJm'FF&Tf>IiH$H7$b,l>34^Co17iB(AAInZG6j)
,&#h%QW8!(0)e`ISqmq%f<W/DY_k-9Y+j&r*UQ\u>lnN.<K(AR6%-Ad0Io;$DRWF*O6jr,6O
m&fr$X=,/8H.R@%8MC:Z<62<`7"0dgsN;+X]AIQs\UYBo^;T8k[0.P>lPJ.U=)Wp7d1$fiTAY
X%i,%nTs"r)m-Zbo\^G`Q6f;Er+02Ok<"LXWdo#:U9:nWq.4mW`ooC,^,O4#Ls(t2,\bP.J&
Vmu,9:uK+CVE(J/R9M*.7rkQ:<;iPP]A%1?jG8u6JK3GAVf`kfEUL/:`k(S<<*Lb=o^;>.Ud:
^`l'b9?YcHm`doW%:`Wk>jsf^N*)2Hf<q(Fq^"E*kh/qX);m,$-A87s(flA5KI/5p(5oM`GV
\LXRj]A+s)N0htDPEaSQD@2nBf^URq%F@0_Ee(q:Ct=I(@C(/).3I+@S[Q`C`0p)71;DWkA/e
8*N83_pm38pI/0l@C'r0B+Y.;FIb`VZlu!gZhT*X$'$N8uFV7\:q2;\_j4ac?U@(SOp"gftk
p==.k,`*OfBLKO3[3\6$Zsn-jL_`^1#tJiDT2P<If-,.rNQH+N1ubl=SWr@snE%^*CZ1E-J7
J!ubuNtbjeqCS2!<-S&,,+m'7Ms<Dq/Mo_3O7RHiHBf/Q:lk'Vif_aI9;8.batIe1ao,G/@7
sA6$Tt1I`'SX/]ArU#)khi#"Y1c3CqOU^3rRF%+g^VSHJ[:W\3[(=/1%^d"MHCoIpKs`6B<td
'b9`aRX[GJgfCA]Ae3tD7^Nc3ZKE6Wt^:S+0%C,Jg2V6bk'1/WNNU(/6W3)4$;>u0st2Cd@t4
*#M\MI'2F`>c)g4H90SW:!(Me;NH_l[MY6dc!4NIqb9+T'dG5'i+ZY!`Scn%AHhrLusQ+s+k
rl@aIV^GhbOjon4:S`h.6NC"*a4a2Q#7d]AV9H*]Apk^+.3"2qc*F$RR$uNHEWcCGPi\*;ltV`
;r^Xr<Jm`QU0JU/s0mNSKtZN24?78_k+>[LS,3calLi+lbq'Y#o7u1\k%DecaP^.T4ON[Pl2
?+-9goPgF'mbq!e&C-Z1Mos?Je\hIui%Iqu>0@>m0Z4l>qmB4]A2J3\.0M;7^k,mY.:P>?>Qh
FIEk(!fa'MEpLm,Z"LIoAo0gnh&ci*cTMm\Dp)eG4q7d3Zb=:&81"8tn`#4144.W,2h>a!H5
G.FX?H&a\208*^=3Y/.^IO$s2-eT`PlD^KlKI,[G5b7L>b=PHor/do,#+UP7:,/?bMAQNT[n
==#'_j%9ET(;ghXE^ogH31?$c6`!Q;,A.nVMN">V1WTJHO;C1%]AFBU%f=r:16!U$<qc*^0oE
([2t0nSl(.#O,L*3%Cba56[B3HZO2[M)pIP*ESkOS2fc60G/]AcIF4qK#I=1`=S:A\]A$@-tdM
WRB53"hD4H]A1cLu8@u=gqF\_o@dt>\e,\f-5&Opt?P[bZ\9GFXqNQ1OmQc::j%0]AL;o@=I&F
LXO0_sraAr3:Uj2)lIF;3LP"@bb"",Cr2Rkej.u5k$ka['*^d4YOJ354_'PK*C]A(B#OpZFXY
Y>h4M71Pq7^oal6h0CNnu0Z,'U_M/_J.&*,&d:5AEP-?l<3L!G@BjD]AZd(TkGiUr[)Lk!q<2
99179Bg6U?lAVMbokdokt'D7Ra37D:e")0*r[M5C+B/><U(I4"0\^eBHH/1c/5K#(DeT`NVH
WZ;PD-uC18Ho#1`#V_^g-6kMK_)1ISP>@CsRrXWqmr&7ljaXIHam=Y?Q3tUH=dU5kYEf3F-H
s@N9K?'XU=59QH?o;^'e>"b-C`*EoRZ!2IkJr)U,mpSPUkVpSgLur;&CuEXU'<M/]AaGR;%/+
;'LIsB*&b:)j'-8TO]Au0,W,;[]A_Ei3SIOXp[-El:L%j%lGUZ+-b0R72VJS\3M(3GD:Ln)bWm
tn4hL>!NW>Ac`.&t(qXG>uB7@Bn8DXDp.D0EG;a(Y!8kV2(pb5oQ@C"kgGq:M;DF5#"_MU/t
VlJ*Io._bi19,+AGUNILf>bB&=M>gDkML?,q<JFE6&8+h;K6#lNQ)n>\3cQ5[6!;oa7+2l6;
k+jK@N*j_cAC3oO?#RZD@77Pn'Pc8Djnu0Yd^s$6_)d.=dm;<rZVAQRiPHr+fU96@!L@ER4>
7C8-[temM/D[nYDSp`m's!u)]AJBHfOSOOXptZjo5EC_`;HSh1DZqse'VELWqe5;'17^#VcdN
h\R/;V.P]ABD5?k(@^=BF3r^(/aPXS='`2)="H=c'gAonoXGB\4SYR;/2FV0=^aQ!c/G&1@Wo
@JcgNI'KAc*!&'q:OXRQB6iI+r<AAUeso6V$osJTl$rq0Rj:<q(hSN-;(^.hM#!D(d]A9Gf%<
n!>r00_;mP@]A^DDX-iInZ"#dqjM9N#ghm!:@1;R&jqI8=?6&ggHOLDui*JPg!A!1baVqOo)q
<*MRmqfVk??!B[TnWU#q/PAWm"r<Cs`+%+3)Z.:8qfTVo[Y:XKVQJC<&;*l:I#mr?^6c(q;9
aO#iXVr#+DIWAVK2BWA\WnUJ77&tc]ApG*+kmXG*%H$&lXs7)/AbIt(/=OgBQ&S&O6tb,HMi/
8PSbSXg\%piHr#(Q<5h=^=MP__>4+XrOW<ahc;**]Ajj]A4+m9SSnY=2t<)__p:qlmM`a!f:+D
]Ae,#)J!?.,f<<:2"clbJW7E2ONbs?k=,3q@oYQr"/9c^Oeafq6sDuGPo*+p:Gg]A;:Va>QA<3
%g+3GkFa6sH>6BP&8VSTGM+Bs=V/[mZSgO-%#H=KWqPnme:pho:l,HK2dX#Q_W0']ALa%IM+"
`QPNPd&cU-Pm+#IB>SOE/T173.=6/EkP1+>H2<k4@h?F&/8V5\l^"ChSe$rJpZo3-bP9G4fC
pB'Uh/Q=q1A,e8&t,`S['>E="3r1B;]A:H]A="s1=j%cUc]AWU`T3FK2dQ13F_Pp'Q]AYRF1PBHG
/-uC@@J)kXsP[*FucL98Dc*%SA^]A-91'+]A^I,+Wd?1+e$(b]AXBjh$[K6btK+R<%s\*>,EU[/
-s!J'_=Kc(TI`5<3Km58pgoYIMe`G)Q'55Zo8,d2.Gd&*`Tm=?Z7>Um?Hokl5"JjJ-eCT7kh
<Fr5ejKh\+f#2TM9AmCtD8B9QIM#EXg]A#bQCsARcpVCo?(daS+B7bfbV1N3DjYYBI<2.8>;u
`5!j/OiPNKiGVn5Sf_)sF_t]AqV"9]A*Ek-9bd'-ud</GcG!*&:rLa75\r/H:PaY?^d0<s4!'o
k?/)r0^^l5HthGZj6\Q+<h#r,b,G<n"[l`hRWF%ga4uoiRub!@\hdhIPF.Tr<jMNMMR0h9>[
e5ITmtE0F2YSXEqE8X)pPMu,R?/Ap%QUhQM.JkaYs6?^:6<LPZ6<)nI3H\Ft`=,?a#Yp8t'(
4S&rWr/pi4@rH7$4TTJ4KY3U75HcoTnfZZ.]Ap!so4K-m;)$[q"TkE#ZOO#i8$Mh:2niBNP1&
jd*V9fA!7UhkmK63b.qTAaZ4pt^0>sg.\$Sr]A/V`E[+T&FmcW6?j#G4gQA2?YtbE"`V,[ob5
.Tob*^r'G3EZ:hT!GmW<giU:B&aUY4<^GYM6(8#:*d5+plicImL/Y4rj\(.P0-AC#QpJ.hee
:\Y.=Jb+mA$W(8!2Of(kj?$eAaQtQhoGk'GI>\@Y5'N]A$l>[S*@90jo%qBB"hC@>/#FeRh*V
!+0XN%r#f$_>1!S)LYAb<^/5]ANb!f9;Zd2p)TJU>hIep^k_9mYU)/+I(>n<7/QC$;<!@P.'`
VA",YU''JP6<(g_`qnQCtiEIprDYY$A\6G[(uC=-ssM^AOL_6K!,`"Gc^r!4`eb"?3@2b\qF
)$HG9d"d6CVYbLK'h$p9YD2-jQA8s;9!Y@dhjO9fQ0R,&TP5UpnVCC^*aZ.m5T,Pb/?Wklt?
l1F!3FPY;6)[?S2+oRG8`0MctN^Q/Lm0"mEOXULi*uG0.lL5^D<Z]Ao(D%W8i>Yc[Q^lN&7+6
K*biE7f`2)8HG4'4/C\pRoXMtEph&)OM4nerifRWBJ6^IrX2kC_&!3^-]A'n/220**L"S1V)e
HQfTl9VeCQMV1mt%!HEZE]A)/nW0=)cq##WbKkb:#;58.@dYe^`8VofYZk"t;U.+ReaO2M2N5
%(iqjB6`%*F%.`UH3]A/DhURI@'$O[YRWc8,D16u!>)Al#;+-:[,Xi7S6*kC_og^A6[<1RY,=
dL01$(oTjJ-:OMQ><)oaAkH^JpZL)n7=CRDL+ro%C=+hZV.$JuEh?Q+ZQ3qSZWH-8.g#:FF2
n!p=SB5&S@9UKtapA(9Y6aYeLXkXB;G.j4tOPOMX*GSh(!?RRH74R\B0<d6;XHuB.jW[0uAU
Eu0I-Zc@\GC8:5;Tb^;gpprSY[,P1C3o9h+"Y-nd?0EY:C:BJe_32@qhhpcJ"hadZ9EEF^B^
2Giqg#O?fB0$bP"N`#FK!EKO%5U8roP/a^nr+#A65SY(oSf0/oGSO;9UB?o6lh=iQ]A^^:g+D
F_mB]Ad(JYoP;u03)A@]AU.EkuOUQ011YY!oFqo(rdUVa3?@5R5&uC7iXEn+c.X#%dLY%T`IMM
K2b(NWX-g+5*GM"^$H>KOV8McfKmC[:OmF^P"2T"Xs/KR?9*60a3YrDF1-`]AZLIoa98KDB)E
Xb-7<od[>:rK?*XrNbMS?mM"I&`pHpEU/I"FDBnP[6B9!kK&sSFcBTGBCF\\DK#9/1TEJV>"
+rfWQNOt8DZ%!KEkGk@`KP=Ht.B?IfT~
]]></IM>
</FineImage>
</Background>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
<UPFCR COLUMN="false" ROW="true"/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9=p:;eNPJ[qiA%.X#()eHdVc`l?%aI1:lq;FQFQI,*q.fntqrZtLIOLPI&8FZWcH'Ssag<&
$i\*G4SM7N'H;8E//,6n/5>Ah]A=2-8]A.U*0WqMagicY4uucjGIh`5_.5.ha'nk9DsqWEpAXH
m^\mN7Q;P]A:4Se(N,=[Vd>J+poL_2irN#;*Ed[*EI:Y,!OFc@6CNK^eirdP_(l#'^o]Als%V5
ICH--1aem^%tNXK'=p.Y0NIpC\pX%;bVT1kJ*T<G`,[J10;YWqX3?">3ZX2]Ad4&3j$]A_gMEm
Tj$T]A]A?OCMWfEc?/\YY>UG>>CK!a%C<-nTig=eu#J<g_@r7`r63Ao2KMak[9`<#i0/>DAK^1
*Vrras3HbK(QXjrMggq>l0TFRhB3Mjb5Q+OH_Rjh/*T'_V="eL0?T=(F!_=bdU1F3X%#aKA:
5kt9?[>*T,.fjf'[?JeI^`p%s5N`,YHT<rI9`Y*dlAb6EDq<jj'0>7__^"qH`.APami6-IID
l4R@7!q7;m7bT/\b'DtH?<O9ZCA'LiF-5b&6Dnnq(Wb/>39>,E'dCc?Woj+!i-]ArRhe]AZ7#B
pKWW>]AG]A`'n=)o5G(KGH^.LM+>'f'aecjmr@^b'GsPbORVY?0O!*gqOfV*lUb7t$*E*"L&+T
X2/=Un.P$=Nmmli&q[\YM)ZtV%C7'jg"FK_QbE]A`hd0"8NLQ)]AZYG@1LJ:iH>==;JEOUCDJm
P@uPUYEJCQC^1o;AU3?toX^4OSuZ-]A?;Wim8+#I"M@lU@l>KO4QWLJ+W_*64J@.+K4.#tu'5
?3I/KWT?3Bd-fVTC=.;9Ku?a>5t`OLOD&)jda%>[]AWAlVf.3Z(-b5:L7Id;.[+03TZo(SuAH
WbnU&=q\?KX1eOOSMaWj/\s7O#]AJCfmC8]AtI8k<+damrDSDem3.A!nlTQ2"3X9YM2:hqD.[L
+.r7ZlQGt'Z?.]A#dSU:RAh*qWrclLM&[[O@Rg'pGKW"MJ%>0Zk/3"W&*b^*c!CLXNLR,Kj8W
)X/$<a'XkFOgZ@m+>'i^RDk]AWekHjT>P$bBqp,?ut')Cc@sERT/C`!rT6F#8[O*Cc(\a6I5i
c4d'W9<P`8>AP*lS0F(X[9b"4n)'s-r6k8@h8QseGa6@i]Au<CJq8)k>&WSCWI^djZ\ALh&Qp
dC>9QhIs$jBFOb=@f<CWMBr>OK6>,t<=t^*hOE>9\1Hrlr_XLaPlY852]A^EQk,RQ;V="^Y=6
aS8PO>3$*3Tj@nm593''MZ5WcDeC#$#[^HY9a:jTrcMhIE$aO;T;:usahT4%]A:ONZ6o!4TaI
k=urK6UJX75Tt@aY^:Jkg9_M/Osh#'CL:V10A??aaI>HiTTjQrP(j0Z/@VRn2Cs4<GRL\.@l
M-Je)Z(71nTBO>%M5^dA'WQn2G-!,F\*QiD40^:Stg8R/R&TRP1:.ecG;b2$VIW-)`]AdYm<m
drRuCo)ar43\;RO>LSl.,;f&2C,;%7@5-IMi4;6_#[X/V!W%Q@gcMOW\+#TY^7Af+A4=HI_D
T[DnA1kD'pg]Akr;]Ad9Qt/;&2hCD\8>0.8+AE#W9APq.^s?bVf"MBpM9":2%k-TO.,Har^6E[
1ZN5dZ6$%2ZI0#DbA<E3j)>^'RqG6'&!ShVt8Zm,:%rdfgCWF>!-mZ[BjQQ5W"l#*#9X_>Hn
WO1d=q4&qo<[;J\m0F5VLc4Qc'l2^g1n7H4E):%C>ZeV<+X4=4m)82'C=$Y.FL#%0$gZc8fa
"tk4-Q]A+/E"2FN"?/[@^ZMG#r1L*;=]A:i!?/R*`(2'YnGJMHE0$bR^KC%#sBXCY\d$UW^`+[
Nk&uo7fYfAan)%CY\%<Y)FKcp$8O*3s)]ASF9MT-KABu8U[TM\iIU6?!_*H$WET%"]AN2N"21T
7+iTkOf<!5!8"<*VR@5r]AQA,')TkmN)uf&Yr6Pjsd9QT`*ZH&07Yn3a6fJR.'+Q\LtIM&s--
YaDF3NAFI7snA_qao(X\,o'NPoiFGFk#_C7R52NbU=A[8!9;Ig#cZV:J"ubX0nbH<"YS9tm%
39*>K;0[D,6<r@CV/HY/3]A4Tf]A7@X!#JQbRKHrdCYiGelqc.O)K8@JkKacuQr(eU./POYEdY
&(?jLB&(_.0#TqZ2/4!XkKS-4TR%J&-k\qW5,GMdg"Kt^Y7kkSV;@/K0aC#V&&iB-qBNhP#B
8:L0&#!r`W<[=:tA$Bp`ASK/L8DZ]A[L^I-uJ)W_i5U7USUGH:hXS8Zl&fo533:e+HGBi$m$k
"VgKHO(c"U8)1k9d*iB4E@,NTXcmhVNQ!f_P'$#ma/SU'%B`)Ie)*kj1L(U"Tjr#T1djguqE
Y=K\F!-\1MH0g:A(;sm!]AoklQZ)\1Rb!W2N;m5\0q!D<o7APD4.l_#BgBrB_[caSBZGk^cnI
r9%N+tGeW/(kEdk(B(/W+$Y@!Y=Ue,EG)ZiE.uhZl?XX;?rFEFN?ILKDT-D`gHDGpAO;uSq%
K@1?/@/k"T;;,Zi:r;P3@]A"b::F5YTCG'\HhfIm^n5S7KK.k$aFpa$S7`XQP`^@\RR%-`&*9
aBh1`3,V4lQ>?+$ite<"HI=6)?l]Ap?Ee3$`dOE`KX$_raE5*A"F"im:mHNmq`8W@tA0Q,k=u
%@XGY^UJQm8b:)[oV?j/^p8K3a,8mPQ4A9'u"=a5H"C&:$A,m)P"4;H:LdhIEK?c2g^kqS%!
:9ca-kCe+iM;>@upllXg;Y<UGCY[gr`_a:uO$`Ks7i_!Kq4V]AWc&BSj,Zm@&uilV,12A^W3b
,H3b%JFPNf;X89/eb7k^]AmUa8ASSamh61jd6iO_Wm3THeeR=1dR^FeZR^c_G#,n;EM:bg,VX
Skk]An+%J7k-Afkrmn:h(?jh]AWS^':9?OEVU'q^_N,dWo8odSA`4Gi+$>gV*JG+:7'U_'gj9;
iVE>iHb>bC+KnjtTejd;S)TbCT#2$E!=%HMn$@LB9g8PIq:"!I8/`8t%:2;]A5g+ru^bIlY>O
MtS<Kj$2"-"$N!o?kCH?/`X7ObQ(#Wdg5%>q7LIrUd\'N3C.erQ_\_5*%(mLgUEo\@g*0RL^
QhLoirQC<MYpNM'd&/e'-*(BBH0oThrJRrONo1T.IMF@m2,_?3P;c!YDd<!;.dT!59iAq*R<
tl]Ag1`._uBL\mfPRC<NJ'u7t4?WHCiC:\JBI(M'I!p=u2dgZ)Z1iU*bd9FNN1l;?gg4F/d'X
M]A)AF#ld=+5(^7.g;_U-BqJbKB8\+V`s>$M<;0YU3fc%c]A$(;ebhdG@3^#p1j;_*m8O@ter\
oB&+@QqAW[bq`d2f,,76Due0o.P:sF,DR]AR>ur%,a=I8gfdX'eFQic*@AiIqiH\7E*d#^l%<
QrWa+pkXGPCVk`mAU*A38N#9MF(>R(GWC)N--C$,gY&1<hLcEQ6G):qmtHDCCIR2iC+ikZ`Y
e-OMI:miMbaX;h;2IiA#0Q'j`#/kSmsD`t,R=Ge92iK!f4g^%NlI()KH]A]Ab;"O3t`qS<a\X"
4oI?Q1E&@K/u$"`\5^gn+Kc\V;XKsiB'(D!ChpE[)%Rf[7l8b"4s_9q*!oHBsjCj@;s`AU.l
tFTjP'XD\:[VdSH3^gX!?6@_^I4-j)EtD@o&)&;CpjV+^oE(4JKLhI13WA:o7(>iSt2\.f::
6ME)Q6mAI(",!Gh1n\bWEmo8/9-%U;i,@[tFY5C-3=1L*5m!$1Do#s\=$bctOfe2'!@i[@D8
qiaR1KU./s3#/]A(chk#!XVWXNWXSr6q8,D]A&?8gV$sE,H_[`Frbts?7*'TV[dV@,?Ke3>ah[
4nH8[)F/8*Y04LlCV1>jgUJ5>flEIr%0moQ[@cV>/-_Xj[R`>aQ_/n%s!%sVDbr/fRYMm;Ic
n."^9@^^G1#7)b]AZR+1[T<e>)kOjK'2BdTgO.&qTE$g_"BEp'NEA`;^E__>gMDHOJa^\V3&H
)V9o'B>>&k0A!2q\5h.+@ae$HE,#J:3qX>mrV#'!Egbk^:Skqh_S*W*QWH:@Fj5kr3`X7b@W
4=\;LB(KM5Hf*OOAA<e\)pU:Jd-]Al@>b\l/Ar]A@8l2jT^<MT#&DLlQtg.Nk4BS^ullG)pj!A
rZ^h++"QAUbSG>pGc7o"r%\GP8..6c-c0Fe;(_)CHf2P\:j>B'/X:X17s/GF*$`U2'%.^gCJ
rn=PT!!+$V+LkHWsE@\U;-(2bk;lZ*q1$F`40?@sjQG83T`\qhb:/iH&KgX1\C/WCcK[1T17
"o;OBoI^Z<5EHJSBJA0is-YTK"]A"')bGi67l<)Z(:E(g2t25p$%p'p=A\,IqlToSQAA(a4>n
Oi_CU'(KZlOg<C'F$.U*9pC*\@a^0I2DqL`2a_t=I@#:GEFm"D]Aqma'cCjuQ-N6fQZM_e9CP
kpN1HQ/V<a38i:bq"b_N?*./#:0bR>k9$?'pg'6Ah'Tg_As2sI!++`5KSEVNX-)o[YUkC.%`
(S[c>S9L,&_CpkNkGM]A1_cuI5)$*UX5.limW8e?qlB/B6g"15+r\9_+/<jJ/W&%1d"+Ai!kW
ug7#Hd[F<::i49Nk4cG1038ft94:FVS:XuZXOWMN0#klTkkudfJ[2c./Y-$k'!8;VeHR3Haf
Bi]A#E(<<#c1Yp<4CEq=^+8EcOJFn$'7j#rf^hcVHl-!^$X%muJaX7+k:*(UY]Ab(>Yj3XgcW3
t%X%-kJ0EB9Ubu4Y"r-n`K-8j8)fB1g@K3rLLbRU)00SZ;2WLhU'f5g@=Dog-`?GK&4VeoN%
?GZIlisRZWIpH+W;[%;KaFnH()OZ`X)AF%mq[TrGg$$Jm#W>sMWLH51#J=&ee8;cfOP"TILr
"\IUiU.@l'h/@K)-A2Kt$7\&;;3Bi$BC.FT9g!WED54Em57gk+-Vk[d(YFP2'.G%.'4Ikm#R
&1+0=+o>6sr(u2t#V^US:P7I"(<m:k+pV\qj4?k[g3fpWj3@Z75C'rp:0VjrEJCcdkBUg\TY
U:'RaZ-+ue:/?`3>k<1F,Ll2O,ur-AHS)g'LBuNU8R/o5Z^9-BM83Eb5eHJ4Dp50pbj'0c\D
9M1gUk1<M1O@,DBp/LGdL<L^AWX#X2am3[td96.EcP)#^O_Ym3X#g4%Ufd_g<OEt/,m4@6dT
#D3rp!Dl^/`^G]A1\_SsshT#=C""8$q\t.8,@3-619)nml,ipW*f-p\E,B[C^L'mN2!:0EQ9P
1HIeEC;U:"NubBJbZ&=^5Zg?E%(o%(6[_cptngJH9;K6u/QT#MU5W?;pL(Dsi+r(<Q0q9E6"
KWN-d1*h@j&3!r,Jq^S'Yg>:7(`))-q\@uQZ1Us5(HE<ODJN"^AK5V8(R]A_3&0<\a16H(g`h
010>o]AM"tEIH+tSQ8Q5/=\fbrl9592*Ce`n-5a8dgXn:#3W.)22:qml7;F&FW>Xq\@!='7CI
'0C:8^!6RJ!c%D8eS8j..C><k27T%JN9$`jOY=C+I^A%9?C;,/K[ifCEZg!*q\(FF2fM9IDk
WaH@'XL$"!FiNPtb"MG:\6Qg[]AFd_3FJ<,-Lb"XP<<3N':E:]AMOoZ&?hp:Jf!,Ebp=DP`ofe
;14lDJlt!?SX$I5HB3Zs+t(OAFT)AID9eq!bcm#6~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="286" height="242"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report3"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="1" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[店铺名称      营业额    同比    毛利     同比]]></O>
<FRFont name="黑体" style="0" size="128" foreground="-16711681"/>
<Position pos="2"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[0,1066800,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[14020800,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O t="DSColumn">
<Attributes dsName="File3" columnName="地级市"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="1">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="<div id=\"demo\" style=\"height:250px;overflow:hidden;\"> <div id=\"indemo\" style=\"height:200%;\"> <div id=\"demo1\"> <br />" + REPLACE(A1, ",", "<br /><br />") + "<br /><br /> </div> <div id=\"demo2\"></div> </div> </div>"]]></Attributes>
</O>
<PrivilegeControl/>
<CellGUIAttr showAsHTML="true"/>
<CellPageAttr/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="黑体" style="0" size="96" foreground="-16711681"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16711681"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9=@.;cgQe1"9l`1pn?"lR=)C_g1OknPjV/-qGt'g1cST80-FCbb2llCGV_p=p)`KGH@>r@k
js*Ag.<0FQbtO<`;X;%@73YX^J\U/4.9?U?.PGJ.T$(-C:9n*BVa7-#:iJo[s.n+$:(8[F\a
N>OV<8n+WrlJ,A;=_4j$km7mq=(2a!<7t1q5$#0a7pR;?Xao<noH!h3eA\YqKdJnN-J,.a4Q
G%RI]A_5+'k51u>IegC2fH/]AIkuepN*=a(>6&VqFR>"(b*VME5Xo2&5*T%2&cYGTE[9IkJr+W
+Ski&MNnd#m$8!iTk$(N*:\!XI_lKmr-d;J;P_2":'\62@.'07,'+7VaU.(:<r?*\&F/K\Ua
kJuhcV8'V(_XZgT?qA$*k.a+3j6AIF1&o,h4"g.oBOa2t4nR>I[a9>VSAR*ZM"+7.(P[qB..
@X3c]AkMVG*Xd&Uq&#g[j<6`N*N'aL6"l!>Os(Rp\W\A->?sUHu+2V]A<@tm]AoP;fgf#=UHNpU
$/GS'GV<X4Wg3g/or9r3%W2FO-EfneamZNdc'.P/4a4/IC%G[nq:;>3jMDA_GOH"LOe'T$2b
H0)I=kco(Q^tbZWZG&mM-\+71\\!-_($8`p>fD?/nFBF;aETNKNE-1CO_bACPT+IUAi#VPuh
>Tg.jJrI3&8L+k`'S';kS"=*oG-M&e>\'L>Y*QLBp7P#R;'p0<"]A]A/blB*j/_CXBR42r<T\A
;6P[*-b.0Jh,D#JO:PG-c<Zp$PFn=7*RPSVR=f`SafXdi/`r+MNuoN8;-#`h6oeF5%5U^I]A#
,t8Ag+TtO1=mZh;g9=?WbF;F(A3j8`0\beDb3ONis='<pQShWFenf[ejkeeIRO-]A@/GeVcD3
dCIp#`ORG;7E24!8i[:Q/YHC1BMmXfK7S\,5?uG-c7ophu,[Z5[Xtk%ZV"oKQI.&6?kq>4Z&
<&55;O<arG2A4E.WYJ&MqH9sWp!)'(F`-iVN+K]Ag`ah>.T"^hFZFS7Nhg)]Aa3L1nZ>g;8Un'
AKm;`i5Nb\Lb!bJ1j,Ft8+>NrKW)=MZp&SS=Ns.tKkai.),MJQ9TF#ercdm!p00M6DOqI"oW
K1DYE92nCkojR.\=HrHd2"JJG2&F-]A-.;&AMdnL:_jsS>.-pIHr1<F/mbu?!ndgT3)ks$tJe
51g0'B\)'$>9@LgN"?(##RRPD69PFZ5MF/*;+]A=00tY+6L-&-"NN`6`AQ6^AeE^@C1lfPj>M
Kq0XXp&"?_?=u9,0,5R*HHWmp"5?9(Pp\I"*8U0(OYmKi#@uJ\X?X@4_r_j,fiOd`cb1ZCn<
&e_hQ^+h4%t%U6;Rq7dPYmi]A0o/qHQBEraUS/_.]ACWN`_!;7d:s=KFf6X7g*;I1aTl"&AR,:
dHX5P^7pq:ZYDk_Q_UPj]A]A:Z.Yu*@`q^D/LZ^O.JNpOK.RWj@?75lNDfc;:5t`UI4lgTYsGZ
3:%,.mLDi%eXD(<']A&H4?0S20@BI;qAf`!2o-$2Jp\[3NqpA*<41Y[26$&l?&8+=$8^A]A_om
"h=7<@,oT6k2`BX"u)KW[ru4uSiCSs>`7:kMb.D<8jIiU?Yr@No17oT10Dr]A.MP<5U&K,o)i
="ng03T$\@OM4\G9a_Da[1ZGR3bNE+_cUXmlra+>CO#oK]Ae`5-u77#,dR):1NFc+%(PMaX`A
BuE-,1SMBZX<&ur,Fs4ih2+7[T/3=1.#l*:g"B$^t[6`I,+?A<MXOdD@W;_E.hQU:<>]A2KNe
:cU,DQt8).-[bt3IL#6skr0j0nk+&@mgZ_b>'CVrOP'NE_0c'GQMhp&$,4Rpe/mX-<+_hsVG
qQY`<>B[PR$HYVK("*,"=?;NuQ.V=TS,9ZSX/nq[?$87ci7f)@AlNLa3?fe7#7[itaWOa9Xn
Q^8bSMPhabPY/2F'k(+d]A?blF3pR[_FAb8$oFD&+OQ(?HM7Io;A3-nRcb++1ZVg#@lfba.+o
3.=P=5>U=E(H2F7\^BADt_HDqDAeK9_p,ZO@JJ"WT/QMZmMb6A*3]A#'q-N$d..?Gc7N(R?*a
>J>jYjd9C_0qZF;m9n'Q<uPDI-DWkU>l+;)W<+P>!0YmPo/V=#=HcX6Qf:VmuqJPF]AH_':TE
<S=2OhhJ$ul>D_h=!8MaOHDV'q1#CKIEW2@&Kl7%hVFZ*:qSc2[@qbE48;J9RO&-!mmD?8`L
]AS05))\?tTa^93&e)AbB:N=>.ai_aJ5AK!@p'ckmb=D_"#A)Bso^Ku+n;.:g+^'k$m<-R+[U
d7Y$.s0)%=@$[Q&@KNQ2#1$NDV.VOtd,l+(S@=Ll[=#jh7h3gPMn?/nZ_:)`iMQ)PqY3!bG'
>5NQ7.Kb;NGrIZ71OtGeJOH5s!N8;;4"rmrc=r-L6A^4:4pun@Ad6@*DE\*th-cLa'P?h;\W
j\$TVb.s_c0-2!.a(@)i`g.]A1Nh-.D>o2F]AH@-*.%Hk0!hQc[k(6UiK5=l(/9m.""V#ZTrdc
F1C7<js(RbXZVmf>N99E_i]Ah+8Y."`MEc/Xs^>D"6=6+thC2Wm*M%=c0-E$iI@+Q*,C8ZgF_
=kC>+_O]AB;&I*ikFi?0uZ^*0hZt:RTq6::EjB@7K&G7Y=oNF"bVkY,>HHmHEdVU'-bp"DrVZ
/WIJiD?T]AO=#`)"[r;$IqVSVQnVher^eI7-fHlf'(S-ZR6qEqC!\X+*46;^"@8DRukfE,%V$
]Alr/.0R#L`0Sn6uIF't=;P?$5M:FUc5Nf4>'C&tsS-f(qFN&/gpN]Atj2YY)qB9lH%)dk.<5I
/cD1DYr@ZUIAe@[F+q=KYW5Jd6o\TVs,JQ4]AbRW`;$BiH4Q(fi882]A7I0J7Z18]AMiV%e;M9C
&1N9i#!2N+?(eEGJ?!YoGX[(="*i'lCM0$8F%1US1i7FNQ$cTEhp<ZH!4j.;qjN62pO)g`Ee
!hiU.Y4k#:gu#uERE'/u,=T6oVqc]A:U<5H1f58$k_!8?'dj1if.a^YlMO<WQD&Q9+O-(3KOV
;7RPY$E9i?j\IQ!)s)=B!"f#%U;[%.a-N4RqsT:#RS,6_sLN$?^E<k(&BP)@I.RoI$+:R8[f
,Co<XK2q0W_/Ij_.!ED\f!:h"EZS8t6m_<MA\&q^30FTgbTttqPM"c5.Y&TZske(eWKtU7NF
DWW-X@Lp[0fWGB)e>)FLrfRN._Mt9E)IFi)`8mhUXu]AWqbV?\*thb7o:$rfN*J@u*\$'U(ps
tEpF:%M;5:GE>4:@r*\l4B$R=Kt;*&O2ffUP9&:'"07dU5?Wf-3`P=XbAa9HhGYU1`i\4HUI
gaCc,p5,oq5PE.J4>o5WM'T)_^"u\-dYrkAf#Z]A$m;d$#M/)8R5"@`qO_cke0-H]AC_h"K1:r
AX>]AGZli3i"HAE\;SIfL>)Ze4dTnb`1@lE^N3`R\:"&\i=#6["JsTN-W,oZg)@r]AnNm[I?YS
),<]AZ\liK>fUGDp/?j6"E8%s`b27MJ3M6uoeU#`]AkHQJWbr>Bic>ig@VCYEN(7_QN6aeJ/]A;
/u2/r]A1h^QFCroo.=RT=6W&OO/=)!4motRVg!@]AB1RPI(;F?.j*jEgYSkWXa5ZNj,^@2hSch
97jB0Tb!qLWEj^;?2P]ANNFUpc9aD1=J3g`oHn"((B\>'FA#!?$jD\/(T2-$2"qa.:0jY(p\k
hn:o=J:2U+_]A53R[%$3]Ar[Ss\eefITI[ui.c8R'YgP2U7l+?$goIOBW+mdHn)Kblm5oAVh$F
Z).QLN.X]A:5ps\;OlI$ZpJu/(e&a$hl*;,fF#GCPU+>.^&j$g[hnnjqKE^QmQ!5;<M-UB?X0
r*S@!'>Bm-^k[m;IMI0dXlI,GKC*%*MK_m&%=2A2-L\aAV,"AfK'dosq$h&"WS<(F7lq^hM"
B#&2#11]A4_/EQMcJosL_B^1pR9H=__m)4RLhiLJRfpQnoR]AHMlN/ITU+)>s0oaXeqE_Inpc'
!44&#F.jQu:(f1ZTiG3f4Wi%-_:f.&2=;r]A#QJsPk[G'p/+I.c>"[go<=bkJ<k$4b]A[C/1[R
Zs5``^hip>VZsu@@55M9B(l?%B',]A8[ql%"5_'-mZ.;JkQ1sRtYKM.)<cI9@%QLO,fh2:'"t
gn)*YEdj>k@uc5YrrZ$/u3Y!/1V<i1R]A`0QNIG;$^kKB\lDo^euVgL)(+/qe)@9;]Al'Yc<o!
p/+g:V0iBitN,(>OANr`r&`UFR)WF.?d!:_mCJP6.<G[R*\:LO(&q6qG`qTbW)3PZHo1C1g7
@WP!K)!MhS-r<A64_tNq1!]Aq.QL6#>B\]Af^6!_h@alZ&BPL>rk8s:1!;#ZY_\18E'8Q4*fa'
Q/c^a_=44IL(*Fm#*B5dMO0VTl;_16hA#s]Abh6U*W&*Ejrn.g"tG;GF$=V\4Wg:HVcSmS[RM
+S"'_/#;kQn/`TZnjOI'/k$#g6L:W.AgYa'U`d&^>M,rP>>7PZk*cml:7P6HV^hb=G+IdL(V
jD2MG3KiJ-fZL`RH047MW@1VBH&U0N^T1B.OkERm20V^=d,'=u*L"?$B]AUb_@Vj$JCUTS71q
2@9Hje9b]Ae3rT.;$&Q_S:6JGNYKl?2F2W0=n86Kl-USj9]A3M'.`]A<6k]AOeV=p!&O7"6VT+Wh
$-PZa0eKRaLhj&3?a?UR+c#;2]Al"s,$&S?R[L>d_!_cjX_34n/[m);Jp5;3#XnrgWQp!/rYo
Q.m_)>7HSL_fCE"&[<4nbes#F[C)f:lT:.i@=`RgBVVT<BOP<*h!3;$7pr2"uO:2#k(0K,)n
[)^p5B%Km6W0PahXRs&T<SW[`T$1,_?to:p)YJ>.'mUWRR:>626Af5a5I$k:<?%0SMrVNC>,
tCm"/H:<Y"r9^=2oX>;f:`u-Z3qgjh]Aa7]AujnF$^sM*pm;LSVEFU@\DuVa"+"'m^:5t=J*a-
*6/_!]ALakA]Ae/8utL*UU3>+&Z:6V)"^B:hO>MDN3nc6Y!uBX0D'W>WYLk8BPj800`V&-?tWA
Hk4D5Q;Vs)-%]A"GH3cb;NSh<e]AI#$Xi!UC6'd.!]AG3&tE29TR$orKm`Ad(W<+dlV/e70>cmY
BP.C,t@$LM0ZCA0c5JO)G=fJf//`WlK:]Ah6nrPDkGA")G<)]A/g>)[qZoOcCu^n@qKi9P"Du:
43iD1Y^d=t;dm0Q^YQ1,]A@7:MA*F+d]ApCN?>B"G'HsY*ORZLAq"Y8/k(Li!,gG\RH`i#_H=C
Wi5Id7F.4j6SSXDi[X@;rB3=U:Qp.DTuAH$O,j&1ssd"Lu>^G?=-Gc<3CAB&*L<OAlW@g2;Y
5Q#\-BOc2*l*g+ZAOgCDbGnnSF-R`t5eXL4<BXotp%%)ct0;^'FDi>TIiG7X]A*a58L2'tQgK
oGZDCPj:8U\=?LK3``!&klah-IM$We-N%IlJOK@nmu^2'.!,1Hh#S&f1r=d0Z=/Ef8o#jgq@
-s2>In[?md7Ono0aKFp#c'ItU2`Puf9PMPZ33pb88\WalGIO:b+j#\b&Df;Y2J^]A?u5^f*7b
<XPj2G9HIG\P*4cA%K*W`8hG-S6;*4=,sahN4+hC#^*V&3pNBMHIoNeHGL'3Y4()g\VI1j4H
IAt-bu-/3pNDIXu;0$!9bj`k)J3jm"ca`PkVbr=6AeFnSM?@g);C\rKRUj#8S9WNV5iu=?,N
XFO&Pr$V*iCl?Fh5[XfW'1g]AL7rHm-FWlkCIJ9/fY9Hn0ai*ojuMVUihBhM@d.1\Tj#N&3rn
4*@t,nXl9C&GS2@cWsU%Z:0sJFRhuW0/)I;E:AVJBOmSrT?dU$Y,eE!'WN$@7?7eY,+06*3/
`LK%$ME#ZF_b.;Jh[Gd`PeVbO+sa^,HCq!9mg<d@#^Uo*&a8%=U6.]A]AN9ME3ENO:8`hFe4*^
Y"f#ZJcGPu(RI<I`>.M@MiVqS3cNo1V7qN%Mnu<KrC`]A&eTXhQ@G<7P4OQuIYD2,';--N$A`
kWBD6oCNo9:=]A"%#N:O>QU6(<dMWAUHD6"'cH6#NALW<*r=]Aak\B*_]AR*6_V\<>N(peX+r9Y
PVIr4u%))2XB4\JiFF<$%j2lN$c+asLnt);o;nTmF]A<;I?4-ooI2t>."00B0l[`a/BD2sft=
V?<"n22V&nok)f/r$Znd*gHZk>"hSWPSiuquU\mn\[QQ\!Lhd3i`i_b-djs&q8frgBFFioj$
ZM:'thnHA<mnGhFMI>>Y(YS`7<Wq_pf^9g>0]A/+CS4cXtIscBrW[5(JGho3%_9Vs9;I/`5D'
I7p'a(<Z%ZHsWAb#8c5LFn0o(P"OAmJcedBb0KMZ::ES9Gl8ggHVCQs??GpkJ4F=p9f/e_iV
6uDfrUJS]AZ2np8Yrr/W1%X*Yp-lGF4Peemgu>Yk<&&"546)0S_Z7HaM(qm2k%RNns)a(`S&7
*+bCip]ARY+:G#BfGj/\.D7]A!2aD<5pHD2UJ91Qg&7kFc3)As3!I$g*$C>pQYRdR/"C.3uK:;
8"YWFZ7hos&S#OrT:XX1@1cD"mi*'nPOOFRmC>B,U6["58HI<i]An5Q2hkfl+T;l8B-GNBHof
'"^`Uk*ZHSeeo@mI[)'&@2'.]ATpTDLT+d,_l'+3+l=>jF7\H3fj9ZA!/"'/S)*DYCaO6:*_$
$U4d(4@15`(5^a95*<jO.n0XKatRjEqt!,Jc!2nuI+s-6jT%4r7M.7t=X/N_Zalc"+nB:+O#
B4KqM3g4r'(~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="5" y="76" width="346" height="240"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="chart0_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="chart0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ChartEditor">
<WidgetName name="chart0_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.catalog.CatalogMainTypeChart">
<SubChart class="com.fr.plugin.chart.catalog.CatalogChart" pluginID="com.fr.plugin.bigScreen.v10">
<attr refreshEnabled="false" refreshTime="10.0"/>
<DataSet class="com.fr.extended.chart.ExtendedTableDataSet">
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[月销量前四]]></Name>
</TableData>
<AbstractDataConfig class="com.fr.plugin.chart.catalog.CatalogDataConfig" pluginID="com.fr.plugin.bigScreen.v10">
<attr themeName="" nodeNames="地级市" nodeNames_customName="" nodeContents="月营业" nodeContents_customName="" customName="false"/>
</AbstractDataConfig>
</DataSet>
<ETitle>
<attr align="left" title=""/>
<moreAttr isShow="true" useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxPro="15.0"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-1"/>
</ETitle>
<ELegend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<attr visible="true" type="gradual" layout="vertical" horizontalAlign="left" verticalAlign="bottom"/>
<GradualIntervalConfig>
<IntervalConfigAttr subColor="-14374913" divStage="2.0"/>
<ValueRange IsCustomMin="false" IsCustomMax="false"/>
<ColorDistList>
<ColorDist color="-4791553" dist="0.0"/>
<ColorDist color="-9583361" dist="0.5"/>
<ColorDist color="-14374913" dist="1.0"/>
</ColorDistList>
</GradualIntervalConfig>
<MapHotAreaColor>
<MC_Attr minValue="0.0" maxValue="100.0" useType="0" areaNumber="5" mainColor="-14374913"/>
</MapHotAreaColor>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-1"/>
</ELegend>
<ETooltip>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="true" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
<attr show="true" fixed="true" follow="true" textStyleAuto="false"/>
<FRFont name="Adelle Basic" style="0" size="72" foreground="-1"/>
<itemList>
<item>
<ETooltipItem>
<Attr enable="true"/>
</ETooltipItem>
</item>
<item>
<ETooltipItem>
<Attr enable="true"/>
</ETooltipItem>
</item>
</itemList>
</ETooltip>
<EGraphics>
<Attr timeUnit="HH:mm:ss" themeColorFirst="-16712452" themeColorSecond="-16712452"/>
<title>
<AutoCustomTextFont>
<textFontAutoCustom auto="true"/>
<FRFont name="Microsoft YaHei" style="0" size="72" foreground="-1"/>
</AutoCustomTextFont>
</title>
<value>
<AutoCustomTextFont>
<textFontAutoCustom auto="true"/>
<FRFont name="Microsoft YaHei" style="0" size="72" foreground="-1"/>
</AutoCustomTextFont>
</value>
</EGraphics>
<Label>
<attr useLabel="true" intervalAuto="true" intervalValue="1"/>
<itemList/>
<AutoCustomTextFont>
<textFontAutoCustom auto="true"/>
<FRFont name="Adelle Basic" style="0" size="72" foreground="-1"/>
</AutoCustomTextFont>
</Label>
<EAutoLink>
<attr intervaltime="4.0"/>
</EAutoLink>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</SubChart>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</InnerWidget>
<BoundsAttr x="286" y="0" width="358" height="219"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ChartEditor">
<WidgetName name="chart0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.catalog.CatalogMainTypeChart">
<SubChart class="com.fr.plugin.chart.catalog.CatalogChart" pluginID="com.fr.plugin.bigScreen.v10">
<attr refreshEnabled="false" refreshTime="10.0"/>
<DataSet class="com.fr.extended.chart.ExtendedReportDataSet">
<AbstractDataConfig class="com.fr.plugin.chart.catalog.CatalogDataConfig" pluginID="com.fr.plugin.bigScreen.v10">
<attr themeName="12" nodeNames="12" nodeNames_customName="" nodeContents="12" nodeContents_customName="" customName="false"/>
</AbstractDataConfig>
</DataSet>
<ETitle>
<attr align="left" title=""/>
<moreAttr isShow="true" useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxPro="15.0"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-1"/>
</ETitle>
<ELegend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<attr visible="true" type="gradual" layout="vertical" horizontalAlign="left" verticalAlign="bottom"/>
<GradualIntervalConfig>
<IntervalConfigAttr subColor="-14374913" divStage="2.0"/>
<ValueRange IsCustomMin="false" IsCustomMax="false"/>
<ColorDistList>
<ColorDist color="-4791553" dist="0.0"/>
<ColorDist color="-9583361" dist="0.5"/>
<ColorDist color="-14374913" dist="1.0"/>
</ColorDistList>
</GradualIntervalConfig>
<MapHotAreaColor>
<MC_Attr minValue="0.0" maxValue="100.0" useType="0" areaNumber="5" mainColor="-14374913"/>
</MapHotAreaColor>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-1"/>
</ELegend>
<ETooltip>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="true" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
<attr show="true" fixed="true" follow="false" textStyleAuto="false"/>
<FRFont name="Adelle Basic" style="0" size="72" foreground="-1"/>
<itemList/>
</ETooltip>
<EGraphics>
<Attr timeUnit="HH:mm:ss" themeColorFirst="-16712452" themeColorSecond="-16712452"/>
<title>
<AutoCustomTextFont>
<textFontAutoCustom auto="true"/>
<FRFont name="Microsoft YaHei" style="0" size="72" foreground="-1"/>
</AutoCustomTextFont>
</title>
<value>
<AutoCustomTextFont>
<textFontAutoCustom auto="true"/>
<FRFont name="Microsoft YaHei" style="0" size="72" foreground="-1"/>
</AutoCustomTextFont>
</value>
</EGraphics>
<Label>
<attr useLabel="true" intervalAuto="true" intervalValue="1"/>
<itemList/>
<AutoCustomTextFont>
<textFontAutoCustom auto="true"/>
<FRFont name="Adelle Basic" style="0" size="72" foreground="-1"/>
</AutoCustomTextFont>
</Label>
<EAutoLink>
<attr intervaltime="3.0"/>
</EAutoLink>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</SubChart>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="365" y="76" width="420" height="240"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report3_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report3" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report3_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[D0gIM<;ZRmR5nac#%Pi5@Lstk-A>:A80k/X#n]AWu8qnn=2D]AC@9,fA([,#!/&k+">#$htm+t
>F38@EWH0>DSjf(XX]AkP+fDSF_1ocg,j>cguHID^1+Ib=5B78K7^18_`W5NW=S5!<<d-^a!b
M.NaWQJ5o1L<`Gu\\KfoB3@bU$EJ$/deXF(d9VGW:CP5oX>Wb@JD%H?d<N\/-R61pU0l4-17
R%R#b"be]A,]AToU`jq)%I#SJ?_%i<&;:ZLa1*P:*HM&%R;,[,67K;6iIkR7Mr]A2l8<"`+O)ms
qXAu)EH6;5=QWh'Ln06raO!O>Kd0;Vq'J1j@erVZE:lGIK7e;.3a^n>PLpI_L/goEB.WqeZ&
*(Ohqm!R"8V5BS51#pB"[oI\2din[_m&9#/8g!G,/_i&7_DNKTV%tmO\O,`BhYcGXE]A`gUf2
KP/HOa--D%tX9[$[Gc:Me&)Dc\3iK#gn\MS%YCd_\D[8eM>aE7%N5$[?`fs%hfMJ._Z:r<4J
B$(d$!/]A'Cjc;Vbhmi.8/c5hkPQN_q%pN@#g-nC-(^6&oD!e^8n#?^D*,MRh&AVf59jTg1[l
:<V9/)-E@Th,:+FqTdX.F.Am]ACq?+D4%Tg;m@FnEL1^tP+91!L3j'h$N:IIZg$`%EtFFY@81
\<jHdlur\UK:@9NakT$F#)J\frNGFCPr$)GAMniLo*ngCTIY.s&#^X"hq)?hqbp?e5AC%R+m
B$,]A-;@FMA5N5"'>4g6dReGu_XOW!rqh=0TZ8gr-e^d9aBqJH@:)pX_W,$KKJ6d,HpdL:D,q
i%B1>oXa5-$@&;X8#0e]AYDp]AZC8CejV'(6`ql:?q1M[&a#6^35iQQ_VuhNVfkt1YA8B)GOj'
facU/DPTjui:m;l.$i.;:7bB=N:,8$^&0&ftrR)'(Lt&r?)osXsmgcG`Gkn`@[C&LRC-+t/X
aI&Z<u")^>De!X]AkjLUa:H:1g:$?#q'2A1SlU7>Ke(g8UofXBR_q2.OGp'W,W;/A1Ee#RQgR
]A;8X34mUOrY<jM/HWk_lN*EWWMU%(l9MLrJnM:JYDN8ZPGLX74q]AmUeN_'!?+m>B"[)q=bg?
h$D`$T+K3FKL0%-X\KqdO!V"&J-rKC>OG<t8KiSsbC1?j)0J>$SF0A95mLf,Xor`=1!J'#fE
E+Xgi,^:>EFl),o(#`3`-b2g]AQm('<VQlTOn@)C(#6;$T!Q10HR1c&=LbAD"Gm"HK%[7\=u>
u2!M3hN[LN!.5/55%YT-j7]A8;S.7&?7nM$m902(jslm2:fMi0^c\L^O>XW+pWg#9Z0S7aXhX
BJe9LDc*P<3inPB_t=I*<kj;)9MWUGH=="CsCHEb9*Y@c=??drGJa$(1)]Alf>oOJYT>'!:RH
=Ga.*$OUT-56#0ULFOa%l#\&PV<Anat`ZXB2:j:QG*hYaogoRcAVCnqWEIaG5[FsLPH!Su;r
AA\?=j"#;UlKAbGW!ttPpDm8;hh@G:#8>$olXgY>=T1]A=EPtftM\f&phk$c(DN%+Rn=&:3'S
\*k;J!)--ZDgqJolqtT_h4]A<NrH7\kkmC-I;2"lF'7\f,Zb;+E9sLS#&hnSR+F8p0>7H"#DI
n&F%mHC@`CM\?WDtGDR0P_'D<oo7n,GJ]ADF,"!'Ye\id.ZSG:LNG9:UMoP^2>/PY*c?((i2S
-ou>I\@AHbp'O>:4rP35bVgGPr(RaTieCk]A"2`J3p8R'W&gML\DD"fCnr#"(S0oG`2i5W!u$
43('B0>3d71tXg\*;2O)JQRlOJ?@EdT,_HQQhT!=rG[<n_bL@/2L]A-p7j0hk^]AYtH1i-\gut
niba-J!9'$eV+5R-qp#K]AY=QBVd%,*=_O$n^^"a<2HHND3=oc6DPCGeJ=+td&GGM9^/&q/da
,e!g>@B]AWDr9ne/qfZ0m[e6Ds#H-ICSNXOeJ3Ai+[`869lU<V';@N`I)&0jlq@0S'I;$^Jsk
[C?MG>ShBgOS0Q@o<0`h8n8G7n=@_$hLDbLJ=9@5o_)Q>O(#$sl_7Le2gLf(b=(g]Aq'SC2)"
"Zpc%9R(cI@,Z-h%S!)I+F9;_QO7SI0gN%c?&8A:s^MA`&>O-YOIe_Cn4@k$5=.Ig[]A`KL%s
<gCh`$NR_uZ-io5#[OXAcr]Aqhr%%!V#o4=a"sP<%$"(3qsgI%[4#Z[n,npgSm=%hTd/a>s>_
oS7*r3.P\3,'K*!13fT_d=]ABLhp5YY:,H0a`QHGhTbFtK]A[NeB*$n8f5a[bSB',Wrf-hC7gX
chTjEh_)#7u/if`#:07M8HRHQ[WIl7Q4YPXO71G@m&+:#DcpMc^bK!*c!c!gKe'7pNc&8Y=R
41bjt0hVIaNbIVohqS'`9\GF0n6D`+;[=i?X-Fo0aJk.(P5hob(g9$,<@*;cu;)2R<DVJF\U
8$\pn3,<ZX7=ETj]Akg$gCjeZKJJ$]A$_4U+e:?jc-Zh6'>*)G&"ITA2S$%#bJ2JTA)rA^p&sl
bZXYdNeRg'43k6_$R3:_d4/B:_G^X.E7eTl0CidH&T1qHsH-I(VnGfa@PmL:2^DA?P>SSOod
qFf>@98:r77tAM>j'l\P<>(JL-d9n/G3dCdh\/nGF"!j`^l/)u_?p:ndh903:$Ji@/3+.%EZ
3"UD%']An3"-9=Kg.k^2K;ta1Y)h4^j)X?DCA6"@@76@pj2VrhGu)?D"/OfOGPQ[F"G05EQks
E1N!;=l'$[d(F$)Ud%$KK]A4!\n"u_"AmK.Kn?f[nU\>2A$B@YQ@!2>k/\;r%Z)\0CAkT4B+-
13uHH/=\o='9Ou<!X*f'@`qs&OBD@5Ru+t#pUPh"+Cg&OXG]AKRV\!7U6hJf1duKX-K3Bo;qY
\n9t'gn3ibr<>t3O3+s@/G9e?!i[&;l.9hC_OLTC^Wdl0$*g5$s3ZGLhf4R2/=4R-;;a-04^
r4&#N#q)iIAf[$<5Erp[O@#LHASaat$NT8ZeF>t,c?j&]Afd.GGE*tc4lYA8Q>;s8%ijXep>%
kbQr3`gm=Kk]Aa#"0UTWb7dZ#oEY=@RA/c1eLMB!_;-@BJ_N3;DE7n?trt=@[3@<cQAGu+iBT
ChAm:4]At9B`f\P*:Is!g@4e/d&>>3Md]Ab?.$Oj=o<Sc&mLH9Ll;EXhs-\`W^l(Gd/iIehB.J
U#hWgrr\tipoS:RiTFW.1eJJO7"leF+9k[[8D$U(A1[e;6s-`bR_XKj"j;8b9*):Fo)@gkW@
)bGe%op%&UH)^73EFIK]A^gg_+/)nJ$7;kcDJi;eWW7jD@tU6+\>&Du:g_!5s(2MTqUNgm`eg
g0uh,j*,SGar*eU)?goJKf:XE=%4S=aFd+`g@Hj.8]A9!O=JU;mb;nFFgWJG#!fa_BJH]A^n)p
aU(MYi^hp8qYnhp\un_JhK)Z1.HESL]AII+cM>"AHGL7jiogd^nnC:?,;6.>WM^LD2)^kO]AfM
'8uRdoO)(<);VmUjnK^g*@V]ANXVrFLnJrrnfStmVqC+sPCdO/_m%6iFqoQjm)rS')8&W)Uj]A
OF#!kpR1;MZ#$>X5&R\5r*fQZG8*+^7hHHgN"B2X>>,:c5\QN-uC+30^169/9Ps-Lhg7,gpu
7IKbYCA2fi:fUG-(?@\G)lUU&gP(o.)S\_XYc!7ULM',?i-@g`oV*C!,2l5426gQodX:V3uq
V4:p=V)QrK4D`8"<#28`^!H'M!)@-;O<>Fq2SmfdXGnL$*shbHZ+aq:jHE7=,N&;4:ZmBY_%
[o@'ZL6ainc$l,]A@>gUs'h^QSiLP#6+(P^3EVFM99^B2;,DZ?SXB=?>?MB5#%[pdb#$a&t!a
dU\ZSfZ">^b`iW@J=WB#Fs4I1<nqe$lT=@:$GO!t83`f/qTiWDY9tbjGLbk".'C-mVH1<ThC
q-Md,Y2Q\P53pB-7@O=G+8>]A;!;3e4n_t).<.RFNit;R.Ha=n^%,2:fTG*HS4s)?GCm50]A^+
[qk?Th9K]A1QLUqFZJqobUj,L6QQ;"GB2G;XMcp[Y]A>=f_enj6epi+\@u:F#3o*G.#NPKAp9+
1Vl.V2'i?V'K4ok?'2t]AoQ0Og9Cc19!s$W\gr;)oS@?CC+;6B1I'OO&ji*.QT$,CJ^P<&ACL
eW"h*$om680,dW0mn.aL@gW=1[>8%UuI:C:nA`GjS!;Umh"RC6.DRr*\+G1"_u`27SS#!%$L
,64O48brV1baBo8(<,h:en]At.V]AK@C4#0^%AD/paC!s@Jj=7!0TUFbq.ReYbal!=B&oO\^"&
]AZ6.o/"pLph<$_!5M2M<77Hppplh.&##okgcNO\r^0^@?!o&gNi=2rVX6o[@^F#q9hHI[_"[
<\L>1+0CUTQiEOq*CDlpG]A!J%VpG"U3/84F@0"T+P5?q^GaiVT1S`kn(-M.QCYGlS#a'P-OI
q)nIdQnJ.`$P(gbZ/UfSa-l3e07"fU/[3&GKluTg,Bj1%5p.6s%n$WJbt-H\ei5E,M_T<QPq
)6A&4KJS[mGMQ$gek6TYSV^0ft+l]A3>c8ZVG(//l6"lp$`JL-k,:b'LBsNM+&?p+PR.K3O*V
]A>NoHp\^8H[O%POMOT"[/6r`!TWfQt#=_o<`MX\,VW7kArN?VQ>20VW%]Aspl[]A`ML(XJ?++N
NRlG-+e"MNt[Z/q3BsWOnVLl.)n(:7'!n?g_9Ru9dtI^2V4-U$h^P4)Ym/[nCG6/f$.dFG89
3N9!2O!:cS@&'.Y8?b+RECA5kqjB:_9K6[nWpMRm-'@10en=L$3]AO%t<-h;=cJ>$#<48m/,d
+,r-6I[ElJO_#Q97gX^4.4Ko+G.;bR7G)^u`L3n]A.HiD)QT<Fd6V4L+f_0^-BDsf_O/>CBjB
5_^FsYtFKZB>`5bo17UjZMLI$GG&]AUI;_@LdD-g170u.K$Y=WYS7<Jb*"Mp$fA0MEm&!(AF;
J('/Ps-e"Mti_sZP5C7dsE!At11ho&c9jVMcql)g7,1Y9'XdbMV+)M?o<[&r[G("K'A5bjKE
m"d<;o9K&[S8,CVjm#rC*4Ml>sIEQ2n`WdKPhHeKt;^EWOC4*j6s=C(TlLN[79"R$uF_2#Yi
&P[VImY<f?"kB]A<B9im1BfSdEXD.t@l;CgIa&Ca_eR*]A,tFiO5S-I3-NFXgEoi%lQ;@X3=".
I#,%$SP&d1<q4/'ebEBAqas]AJpft?jrk,P8fn5ElQIlF;$<Zr4CPre]A\qVgKSpS2>_8I_^fQ
_POJ*SjF$?oWV&rZd?0U0NHGbq=A\j?M6.mJEe,9Mo!^Khq2cRP(-d$O5ZM7*-gpP[Q03p6H
mQtQ<:()0RlXMZFjGOEqj1En6,B:HHe06%ImDnHi4htKPL7$p'`fS=pgZn7"f:.CF`pd>XRT
9=FN#=^'-'2if+R^dG=]AhPQsf"W_c5.m+Q&4AsN%/9S55?=[=UNtZ<+`&)G*C=cGG4ZVKHYh
4G;gdoM'5tIKd,gc6eI]AL93@C%nCJP`d5nF$1#\SbNi"$m<Tst#>=8p.@;',Hu=t7_(2ZcDs
h_,5W#n`'mh0t-'&_F!/@g3iK[mVtmq8W=\^'m\+)A#rE;]A1h[0QaK`$WWKK(^d$HfW]A+IN>
C)T-KJWe.(;Y!$F&@X'(RN-rAS$lr,6[17M6V+c=s5=a,I*4lJRR%`DJd<'hMhf-*`o&I[\m
f'3%-BaG!H8VD99W7P<_.$=Q:ikEa-qlgS%Q5h2[l@.nZ.q]AfReOP,Uu`rQsp8!*WP.1(kc9
dr3mG1>1/^BML8(R:CbiF8Q.qF^_T=*jPdFB7[_8!&ei=G5UFG!(Ue3^.VSOEW2Z=@2+Ks%/
(\fI'qpEem'-\3E$!aOjr,RL*o"kcR]A!-O?8%cin\.g_&Mb[4]ADW$_k[?AAC2C,_FKo0;-,_
"dG]AKjtEH^VLL'5&r^OXi/Kj)i.g5e7\6)Q<T^B:M-E^V$VZ:QGJ?Qnm[8M,#]AgG0OgRF0jj
`=i=WbJQ+e#QZ2Zp^WciNH>%Zl@DIMj[q7U]AOToV.T'dKTV:ZSLHRc`K_PWRcR*r%eAb,k)^
eE/7O!F`tGX)QW6uN:KFc3dW\oLU-qAqU-M5dsV/mf8$;&EN&oCnol#.;]A<1Te61']AE=O*`&
c.E]AA(cqOC,YZr?<WcDoZN:SO4=sB/@4S"b.HiW4&A0]Arir^G3UkB<[lY_.05eBZ;B\_pec1
0hs&G5>CN\*l4N'@-)cD\SReWt]A<7]A]A>\)?u)-n6N*O"2fiBe_XgD$rSVhmTV3gtjm6<N'$t
djRk8'F#??oOR%AT4:1ch[Or:nj>iXqp2q@\.IiZko=t9HqYC;b?6W0AB94nj=;?k@qYt("W
IF".?Tl_adfY%C``D;;\efUf-JR*2L=RGrKHIAJeLF+"CZ>55f6c@.\g8F'@=Ous""LE1-U1
d=nH3:["Tbk]A&8%#`9_KOs,,"pqrW@fK<enNAX'ftBHd#9k6NO6?_f;U"C"f$Q%1E8ZE0%p2
Q^0F:\V`"oN6trZREMH36M#$:il#Uekb2Er;i>Pc3b5U"6J#@T0bbur/3]AY)R7k=SqXa>KNS
%!A`s)YiS5Q5TN50+C.RbjI!c;G2:.*U%7;SV);s*)/!LEX,<+]A<"r'gj\3+H7UDlr$+91Um
PQ,h)//pWqp6Y6Sk(=AAEs35)PE8_g"Wsqq#;$jk*uoTEVda6pd9NORN'K",pWUhXfEku"e)
>`f.h=Q<)7Q",bMJ3bNi90shd@l;W#(KDs!%2MW5o1\Id30%Mi2!N,Q0^EKYm1<XSQgS;KU;
!fg+QPnDSKMGJu+bqQg.c(]A#Re<r\MVeniat2;&P9hDSgl%Kg7u6ca8*i89/8AZ@.G3*cepW
":#N1B5nNc-3ePo4+P/-P6&)'`O$jR%"@<%TH_=dJP]A_=,^k!TJ;>cHKrgg.#1JmNlbK)9m%
//T@+IS!qL<sCr:l)IjS?#"^EM(]A'stRAJeVh9FR?UCi6Qr:p/D<rH^I::%ZhiLO2rb0h=dE
gkC!fCj'RSkursqOWuUAI1",J-0]AnM6\cu,+;Y4SpV7-$^m).ZFWEW^\a9knc/drOaO"R]A8R
G4mcWgJX''!Saca"kBUTV\^1DC&^12=Pe?Zh%S@8uc)rEhE@V=,0r+;DH\s,-eg%3d-iT1;-
%QS/arF#Ph]AD(WKBBV>-On,u5&4m>;rV#96'7^8aOq`i4$?aYi#(tV;fm1CE'c5`dhgrj3)d
to]A%nga/O^t$`p/B=d%;f=3r59=]Atr617l\m-K/N%hLbMG2t0]A!>_Z-)d:&\]A?<;4nhM&:<9
7*H&#EUL5dU:IqfV^aA_,uB!-cWW/m9H(b>nu+JY<G9+h22,JH?)nI*.S?$%a_X&.)/HAXoC
^J1]A3#sN8S:;?q8cB/9DH@AX07F6/W)<"?tY:*(WqC\M+YtRlm'&gM=<9XN1QS>oD1DJ92%m
U:2r#U+sA8"\M/OkA4'[fmP]AR^rpg=p3X\K:&YL*P16LZ`f6;'F8Y:':-c3SDX<CH_N/5)34
k;o%?H%`fc@a+PX-c"9fiqfAH+XhM>i-BteLDf523VDiP?7]A(?ieLZqlJHglb0L$PVWHB<n"
)okddlF`M%1(UE$@_LVA<JcUo-@RL0M<UC$7!J:>8cbR1*OL>GVB6Kr49Y<_pF>hL\""5_%+
rIKL^.PEgps(6/=+s+8CAM4gE@8F?Y**BcN#ODbZ3A`e.sQkGsHch7=.d@;Jl9E9?8N-<:R<
ht2'`YgdW)=o/:K;KNb$*T=X5]AE3*JB]AJUg9<Nu/+ITY$b.>`*G#l9dn6D:lrM(M6_7\WBU(
cN0JJ=0CT%-=,j3KSeaaQf$-*UC8)G=?0Tf7\eSX.@N4Ma`!o&7[L'VG#OX4DZURj-u5$`)F
Y2Ehk<M1apZ<`jl>0_`]A;_nEc8>.V"4?]A]AST(\*p:\+3]AENkGkR:@>Jdq4JU;^ZEYHW<bEVJ
NHGid,dMJ7*<Mf7l#p_X&-liQ\sa-'SDR*a4><Rf\!9A[jGN".5jD8-nA+A>N-6a]AM@8()l3
o9)cIbaA;=rC0s/ph5d'Mon[tG"?HT1`$Ql"R3^/%$QqU&jmY+2@a;@+6EiVif-Agt>Af<^'
N@8u4L(\\Gc=`HtdZK>loa`Tq38BI08QS7L5a0)I@$,X&'e!(]A-SSIPP\@@pmim-_$!t/9kb
aFhcRKjC`dH@PWV<&moF.4)BZE]A_H9sSR('*]AHL1(\Z>X`H@`3;Z#BUHjBF.^L=5hdfQBJMQ
pVet7SgL'EK`oC4<=^2,m70<SlLWnSrO^5fX?j;27Z`WTnd[LCah(///\L\R9TH;Mia--Gem
-?mKj>WQU46%)K6)?MSR2C5pBWLPs#0't)NH)KpG>*,^8M$4\8(Ams?WR9[a>>(`\$Ik(hs6
8Mq?QR!2^`Q'g2W8fYUB=X]AB(:<i)>i-F+cU-T<Kf!-$H)@l2M"abqS`m?(6^P>L;$/$fU\X
/!7[^8:gJFUn.PNlH@SqR]AGuEc"Y=&22X\^$mkMoZH$3*Ej!rYR^]Au@G\]A,cq":tn.(V=Qnf
#P>b)(ftX(!:/qm*s@/;JX>pU[M[DaH':hVefB@dH/3D<UF7[8l?0c'j=`9*V56^16K-!V.T
[_(,gZ1o)0;LhZ`Y^-.[te;tN,gr/;8(+"g=+^$;C,J3)TA\c[ui`DaD+oPtI'k@e:BG"apR
J,DF0HeS$#fP`*R..62CN;Y@"DB+i<T;;NS#_<FK'bi\3G^H-5,JVQ?!c7OgbdSR0sEMW9>O
;ILtEaaIDcn'I`k"V7Q2fOomgB?=BjjMgO?@\JGeNM(!8&hZQksa@r^4gjAkuL3>'qVk4`hW
HV`[^VjNikC+@:p8@bc;@g9nOCM]A<s>"iU1Q7jLn$ihCum8E$.k,*aUn+t@'4%?SpT0$VhEK
HN:\O_^`$@5ZSkk4o,S*Z#H$]A&^Yao@%#>YR2L/UDdtNnS%kd>MpFs/k>Om[h1bgBQ4;4`,3
GDVsUo/FA^$=gG=gnc&NCMh=*W^Mn8X.&gR2IX+u*CJRbL9QW<Hd^6Jte;>GXi'1So,Nj_Kb
kuE$aV,!'6;;oEFiF;;]A`fNs?JRF5CcD3;cCr7@ma<Ime!^)M1)@`u(NTbceBJ\r,[391eR7
h,`(-4H#tG<g5"OEaUuKqA(;380iG3#$9ecXsc/V*WITn)t3%+/(GC%>>+)J$rYIF(;?OlMk
0XWl"\ul!nXAelPW`\fqEgaEghRiE4UCDSl+Nt24U]AK]A@h6.W$*TYQDfUW@d4-=*5$]A,QP\&
15pTEqE_hr?m*BXa9(O6I6g+,Dn\aj0I0Y:6]A\gNck4)8M:S:VZsJmk@o'7^0.P5ap5rM:H<
n)"+0jAM]A3HMQV0d7+k'#>%2<>"+QRLL9qBLN?M#r@=ZMuO'0KTXpWAj9C@g7p_@;EV0Xck%
ifA4:E(k';nKEE/QW?%376j1j>9sIDoDd,Rfe`]ACeKe,.C5QI0oEm$?6A"c%b`L78^(*:":8
nG4>*4?\7Yq<1mK2#Qkk[9SQ(r<")HVtR=8E^YI<=D_M5!47mrc.4I@b;)i['CI)ELXbc$OH
+.(l('QJ?l,ne`MC@.`r5H#Ero@`WYcOEMsWH\7t\9/`MP*fH)MSR0-p5\%d\eaf<lO+N<f#
5DEG(L,\a2$$T]A*^?YKmE=Q\#W@[!8Kb9Gp=>33lYEc/&jM(I;YQsAIEBgS_E+PrX]Ao!Ila/
NF1N:uh:oO"R/ck%+)0+Zi;2$ogR,@o9C$=XNY:L1><q@+`5pI:]A0#[DYi;Z2b<Lod/NuCm1
>^WhU`-t+lo2X3g,2S-W2pDJAeW><Vdc+HoP08g<HR"eKt_#%%KblSD,t8Wp=,8M71mCc`<k
e^55?Ppab?E,gt@P:LKZ<F:GJ`LND,u8knIBTP)]Ak-WYN^/aMt4`3fG\&g`[$CQj?EMkm-A7
nTO1T)g!G/CC\ip4NX_S'e+42fchG]AT_cn68$D'`qD.ZB-_DL;MY]A/Gf92fZ?6#OgrBjIU45
C(AhiU>>%*G'QNuX:(%R?`44)cJ)3:N.1YICN=D8iB4%%!;eQjQHa^2)K"p<\p6Z/e`'C4U!
bi3bZ";k[tUd:-6k6"<+U6qi2d6I,>eZhEYL;_ZHnheWL_ZupkCRY:l.&PH^TIGcNqM`k^SG
NoTEf'Kk$[f[ruf'Vq*+)%IQ=bm4=>EE_9ZG1;#-C\eE@f[Ki/nKMa)16@>:VpsY/`f(&;i/
gfe=H@B9BDp(!FoIglFh,uS='r)+iDV`AG+gT?#7?o6h5Jkm.<0<.Xp,!LAKh;ls?@=(mFBE
ri8PkVgaM86nEA[q]A7ag1eF%;^HeCQCofbJYh;cJY_Eq>dN`&'m/khM*a#OnL0b3K5>*.Yh&
A!Y[<T#)VYc(.B0\kpEKRI"]AJmlQ>\!+?LFonVAk'M7KZRSH<>N3]AJ+L;D;b5qorOrbmA8A>
8A_c,]Aq)$A`I,5FLB]A<[l+I,cj`*=PsQ<WR54jW72LknL>+Q&Kmp_BW_D;.YMV$(s>el7)+#
;i(*,-lBR?bgUT@,I0B4-=Haokn4N3I.3%3(,TcOuGHnR]Aep#I*HHBfgW[1=-4=/>M561hl'
Ok9CDSfTEYBV\mHW#:6NS_iUXdSB\S@(%i",kMLjOYWcIWN+_;if7iH5g=mrPA2`d'[\a2t#
p$(!K6hg!ITd/6%l.<\#N2#AALln^!EW5XUK:DW&#W(l'F5u3DCR^l<KW2SUh)#&W?-0H:0W
8Vu)?<IB.-!tgD=I;]Ar5(>4ljq`dgLXAol,EXO~
]]></IM>
</FineImage>
</Background>
<Alpha alpha="1.0"/>
</Border>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[D0gIM<;ZRmR5nac#%Pi5@Lstk-A>:A80k/X#n]AWu8qnn=2D]AC@9,fA([,#!/&k+">#$htm+t
>F38@EWH0>DSjf(XX]AkP+fDSF_1ocg,j>cguHID^1+Ib=5B78K7^18_`W5NW=S5!<<d-^a!b
M.NaWQJ5o1L<`Gu\\KfoB3@bU$EJ$/deXF(d9VGW:CP5oX>Wb@JD%H?d<N\/-R61pU0l4-17
R%R#b"be]A,]AToU`jq)%I#SJ?_%i<&;:ZLa1*P:*HM&%R;,[,67K;6iIkR7Mr]A2l8<"`+O)ms
qXAu)EH6;5=QWh'Ln06raO!O>Kd0;Vq'J1j@erVZE:lGIK7e;.3a^n>PLpI_L/goEB.WqeZ&
*(Ohqm!R"8V5BS51#pB"[oI\2din[_m&9#/8g!G,/_i&7_DNKTV%tmO\O,`BhYcGXE]A`gUf2
KP/HOa--D%tX9[$[Gc:Me&)Dc\3iK#gn\MS%YCd_\D[8eM>aE7%N5$[?`fs%hfMJ._Z:r<4J
B$(d$!/]A'Cjc;Vbhmi.8/c5hkPQN_q%pN@#g-nC-(^6&oD!e^8n#?^D*,MRh&AVf59jTg1[l
:<V9/)-E@Th,:+FqTdX.F.Am]ACq?+D4%Tg;m@FnEL1^tP+91!L3j'h$N:IIZg$`%EtFFY@81
\<jHdlur\UK:@9NakT$F#)J\frNGFCPr$)GAMniLo*ngCTIY.s&#^X"hq)?hqbp?e5AC%R+m
B$,]A-;@FMA5N5"'>4g6dReGu_XOW!rqh=0TZ8gr-e^d9aBqJH@:)pX_W,$KKJ6d,HpdL:D,q
i%B1>oXa5-$@&;X8#0e]AYDp]AZC8CejV'(6`ql:?q1M[&a#6^35iQQ_VuhNVfkt1YA8B)GOj'
facU/DPTjui:m;l.$i.;:7bB=N:,8$^&0&ftrR)'(Lt&r?)osXsmgcG`Gkn`@[C&LRC-+t/X
aI&Z<u")^>De!X]AkjLUa:H:1g:$?#q'2A1SlU7>Ke(g8UofXBR_q2.OGp'W,W;/A1Ee#RQgR
]A;8X34mUOrY<jM/HWk_lN*EWWMU%(l9MLrJnM:JYDN8ZPGLX74q]AmUeN_'!?+m>B"[)q=bg?
h$D`$T+K3FKL0%-X\KqdO!V"&J-rKC>OG<t8KiSsbC1?j)0J>$SF0A95mLf,Xor`=1!J'#fE
E+Xgi,^:>EFl),o(#`3`-b2g]AQm('<VQlTOn@)C(#6;$T!Q10HR1c&=LbAD"Gm"HK%[7\=u>
u2!M3hN[LN!.5/55%YT-j7]A8;S.7&?7nM$m902(jslm2:fMi0^c\L^O>XW+pWg#9Z0S7aXhX
BJe9LDc*P<3inPB_t=I*<kj;)9MWUGH=="CsCHEb9*Y@c=??drGJa$(1)]Alf>oOJYT>'!:RH
=Ga.*$OUT-56#0ULFOa%l#\&PV<Anat`ZXB2:j:QG*hYaogoRcAVCnqWEIaG5[FsLPH!Su;r
AA\?=j"#;UlKAbGW!ttPpDm8;hh@G:#8>$olXgY>=T1]A=EPtftM\f&phk$c(DN%+Rn=&:3'S
\*k;J!)--ZDgqJolqtT_h4]A<NrH7\kkmC-I;2"lF'7\f,Zb;+E9sLS#&hnSR+F8p0>7H"#DI
n&F%mHC@`CM\?WDtGDR0P_'D<oo7n,GJ]ADF,"!'Ye\id.ZSG:LNG9:UMoP^2>/PY*c?((i2S
-ou>I\@AHbp'O>:4rP35bVgGPr(RaTieCk]A"2`J3p8R'W&gML\DD"fCnr#"(S0oG`2i5W!u$
43('B0>3d71tXg\*;2O)JQRlOJ?@EdT,_HQQhT!=rG[<n_bL@/2L]A-p7j0hk^]AYtH1i-\gut
niba-J!9'$eV+5R-qp#K]AY=QBVd%,*=_O$n^^"a<2HHND3=oc6DPCGeJ=+td&GGM9^/&q/da
,e!g>@B]AWDr9ne/qfZ0m[e6Ds#H-ICSNXOeJ3Ai+[`869lU<V';@N`I)&0jlq@0S'I;$^Jsk
[C?MG>ShBgOS0Q@o<0`h8n8G7n=@_$hLDbLJ=9@5o_)Q>O(#$sl_7Le2gLf(b=(g]Aq'SC2)"
"Zpc%9R(cI@,Z-h%S!)I+F9;_QO7SI0gN%c?&8A:s^MA`&>O-YOIe_Cn4@k$5=.Ig[]A`KL%s
<gCh`$NR_uZ-io5#[OXAcr]Aqhr%%!V#o4=a"sP<%$"(3qsgI%[4#Z[n,npgSm=%hTd/a>s>_
oS7*r3.P\3,'K*!13fT_d=]ABLhp5YY:,H0a`QHGhTbFtK]A[NeB*$n8f5a[bSB',Wrf-hC7gX
chTjEh_)#7u/if`#:07M8HRHQ[WIl7Q4YPXO71G@m&+:#DcpMc^bK!*c!c!gKe'7pNc&8Y=R
41bjt0hVIaNbIVohqS'`9\GF0n6D`+;[=i?X-Fo0aJk.(P5hob(g9$,<@*;cu;)2R<DVJF\U
8$\pn3,<ZX7=ETj]Akg$gCjeZKJJ$]A$_4U+e:?jc-Zh6'>*)G&"ITA2S$%#bJ2JTA)rA^p&sl
bZXYdNeRg'43k6_$R3:_d4/B:_G^X.E7eTl0CidH&T1qHsH-I(VnGfa@PmL:2^DA?P>SSOod
qFf>@98:r77tAM>j'l\P<>(JL-d9n/G3dCdh\/nGF"!j`^l/)u_?p:ndh903:$Ji@/3+.%EZ
3"UD%']An3"-9=Kg.k^2K;ta1Y)h4^j)X?DCA6"@@76@pj2VrhGu)?D"/OfOGPQ[F"G05EQks
E1N!;=l'$[d(F$)Ud%$KK]A4!\n"u_"AmK.Kn?f[nU\>2A$B@YQ@!2>k/\;r%Z)\0CAkT4B+-
13uHH/=\o='9Ou<!X*f'@`qs&OBD@5Ru+t#pUPh"+Cg&OXG]AKRV\!7U6hJf1duKX-K3Bo;qY
\n9t'gn3ibr<>t3O3+s@/G9e?!i[&;l.9hC_OLTC^Wdl0$*g5$s3ZGLhf4R2/=4R-;;a-04^
r4&#N#q)iIAf[$<5Erp[O@#LHASaat$NT8ZeF>t,c?j&]Afd.GGE*tc4lYA8Q>;s8%ijXep>%
kbQr3`gm=Kk]Aa#"0UTWb7dZ#oEY=@RA/c1eLMB!_;-@BJ_N3;DE7n?trt=@[3@<cQAGu+iBT
ChAm:4]At9B`f\P*:Is!g@4e/d&>>3Md]Ab?.$Oj=o<Sc&mLH9Ll;EXhs-\`W^l(Gd/iIehB.J
U#hWgrr\tipoS:RiTFW.1eJJO7"leF+9k[[8D$U(A1[e;6s-`bR_XKj"j;8b9*):Fo)@gkW@
)bGe%op%&UH)^73EFIK]A^gg_+/)nJ$7;kcDJi;eWW7jD@tU6+\>&Du:g_!5s(2MTqUNgm`eg
g0uh,j*,SGar*eU)?goJKf:XE=%4S=aFd+`g@Hj.8]A9!O=JU;mb;nFFgWJG#!fa_BJH]A^n)p
aU(MYi^hp8qYnhp\un_JhK)Z1.HESL]AII+cM>"AHGL7jiogd^nnC:?,;6.>WM^LD2)^kO]AfM
'8uRdoO)(<);VmUjnK^g*@V]ANXVrFLnJrrnfStmVqC+sPCdO/_m%6iFqoQjm)rS')8&W)Uj]A
OF#!kpR1;MZ#$>X5&R\5r*fQZG8*+^7hHHgN"B2X>>,:c5\QN-uC+30^169/9Ps-Lhg7,gpu
7IKbYCA2fi:fUG-(?@\G)lUU&gP(o.)S\_XYc!7ULM',?i-@g`oV*C!,2l5426gQodX:V3uq
V4:p=V)QrK4D`8"<#28`^!H'M!)@-;O<>Fq2SmfdXGnL$*shbHZ+aq:jHE7=,N&;4:ZmBY_%
[o@'ZL6ainc$l,]A@>gUs'h^QSiLP#6+(P^3EVFM99^B2;,DZ?SXB=?>?MB5#%[pdb#$a&t!a
dU\ZSfZ">^b`iW@J=WB#Fs4I1<nqe$lT=@:$GO!t83`f/qTiWDY9tbjGLbk".'C-mVH1<ThC
q-Md,Y2Q\P53pB-7@O=G+8>]A;!;3e4n_t).<.RFNit;R.Ha=n^%,2:fTG*HS4s)?GCm50]A^+
[qk?Th9K]A1QLUqFZJqobUj,L6QQ;"GB2G;XMcp[Y]A>=f_enj6epi+\@u:F#3o*G.#NPKAp9+
1Vl.V2'i?V'K4ok?'2t]AoQ0Og9Cc19!s$W\gr;)oS@?CC+;6B1I'OO&ji*.QT$,CJ^P<&ACL
eW"h*$om680,dW0mn.aL@gW=1[>8%UuI:C:nA`GjS!;Umh"RC6.DRr*\+G1"_u`27SS#!%$L
,64O48brV1baBo8(<,h:en]At.V]AK@C4#0^%AD/paC!s@Jj=7!0TUFbq.ReYbal!=B&oO\^"&
]AZ6.o/"pLph<$_!5M2M<77Hppplh.&##okgcNO\r^0^@?!o&gNi=2rVX6o[@^F#q9hHI[_"[
<\L>1+0CUTQiEOq*CDlpG]A!J%VpG"U3/84F@0"T+P5?q^GaiVT1S`kn(-M.QCYGlS#a'P-OI
q)nIdQnJ.`$P(gbZ/UfSa-l3e07"fU/[3&GKluTg,Bj1%5p.6s%n$WJbt-H\ei5E,M_T<QPq
)6A&4KJS[mGMQ$gek6TYSV^0ft+l]A3>c8ZVG(//l6"lp$`JL-k,:b'LBsNM+&?p+PR.K3O*V
]A>NoHp\^8H[O%POMOT"[/6r`!TWfQt#=_o<`MX\,VW7kArN?VQ>20VW%]Aspl[]A`ML(XJ?++N
NRlG-+e"MNt[Z/q3BsWOnVLl.)n(:7'!n?g_9Ru9dtI^2V4-U$h^P4)Ym/[nCG6/f$.dFG89
3N9!2O!:cS@&'.Y8?b+RECA5kqjB:_9K6[nWpMRm-'@10en=L$3]AO%t<-h;=cJ>$#<48m/,d
+,r-6I[ElJO_#Q97gX^4.4Ko+G.;bR7G)^u`L3n]A.HiD)QT<Fd6V4L+f_0^-BDsf_O/>CBjB
5_^FsYtFKZB>`5bo17UjZMLI$GG&]AUI;_@LdD-g170u.K$Y=WYS7<Jb*"Mp$fA0MEm&!(AF;
J('/Ps-e"Mti_sZP5C7dsE!At11ho&c9jVMcql)g7,1Y9'XdbMV+)M?o<[&r[G("K'A5bjKE
m"d<;o9K&[S8,CVjm#rC*4Ml>sIEQ2n`WdKPhHeKt;^EWOC4*j6s=C(TlLN[79"R$uF_2#Yi
&P[VImY<f?"kB]A<B9im1BfSdEXD.t@l;CgIa&Ca_eR*]A,tFiO5S-I3-NFXgEoi%lQ;@X3=".
I#,%$SP&d1<q4/'ebEBAqas]AJpft?jrk,P8fn5ElQIlF;$<Zr4CPre]A\qVgKSpS2>_8I_^fQ
_POJ*SjF$?oWV&rZd?0U0NHGbq=A\j?M6.mJEe,9Mo!^Khq2cRP(-d$O5ZM7*-gpP[Q03p6H
mQtQ<:()0RlXMZFjGOEqj1En6,B:HHe06%ImDnHi4htKPL7$p'`fS=pgZn7"f:.CF`pd>XRT
9=FN#=^'-'2if+R^dG=]AhPQsf"W_c5.m+Q&4AsN%/9S55?=[=UNtZ<+`&)G*C=cGG4ZVKHYh
4G;gdoM'5tIKd,gc6eI]AL93@C%nCJP`d5nF$1#\SbNi"$m<Tst#>=8p.@;',Hu=t7_(2ZcDs
h_,5W#n`'mh0t-'&_F!/@g3iK[mVtmq8W=\^'m\+)A#rE;]A1h[0QaK`$WWKK(^d$HfW]A+IN>
C)T-KJWe.(;Y!$F&@X'(RN-rAS$lr,6[17M6V+c=s5=a,I*4lJRR%`DJd<'hMhf-*`o&I[\m
f'3%-BaG!H8VD99W7P<_.$=Q:ikEa-qlgS%Q5h2[l@.nZ.q]AfReOP,Uu`rQsp8!*WP.1(kc9
dr3mG1>1/^BML8(R:CbiF8Q.qF^_T=*jPdFB7[_8!&ei=G5UFG!(Ue3^.VSOEW2Z=@2+Ks%/
(\fI'qpEem'-\3E$!aOjr,RL*o"kcR]A!-O?8%cin\.g_&Mb[4]ADW$_k[?AAC2C,_FKo0;-,_
"dG]AKjtEH^VLL'5&r^OXi/Kj)i.g5e7\6)Q<T^B:M-E^V$VZ:QGJ?Qnm[8M,#]AgG0OgRF0jj
`=i=WbJQ+e#QZ2Zp^WciNH>%Zl@DIMj[q7U]AOToV.T'dKTV:ZSLHRc`K_PWRcR*r%eAb,k)^
eE/7O!F`tGX)QW6uN:KFc3dW\oLU-qAqU-M5dsV/mf8$;&EN&oCnol#.;]A<1Te61']AE=O*`&
c.E]AA(cqOC,YZr?<WcDoZN:SO4=sB/@4S"b.HiW4&A0]Arir^G3UkB<[lY_.05eBZ;B\_pec1
0hs&G5>CN\*l4N'@-)cD\SReWt]A<7]A]A>\)?u)-n6N*O"2fiBe_XgD$rSVhmTV3gtjm6<N'$t
djRk8'F#??oOR%AT4:1ch[Or:nj>iXqp2q@\.IiZko=t9HqYC;b?6W0AB94nj=;?k@qYt("W
IF".?Tl_adfY%C``D;;\efUf-JR*2L=RGrKHIAJeLF+"CZ>55f6c@.\g8F'@=Ous""LE1-U1
d=nH3:["Tbk]A&8%#`9_KOs,,"pqrW@fK<enNAX'ftBHd#9k6NO6?_f;U"C"f$Q%1E8ZE0%p2
Q^0F:\V`"oN6trZREMH36M#$:il#Uekb2Er;i>Pc3b5U"6J#@T0bbur/3]AY)R7k=SqXa>KNS
%!A`s)YiS5Q5TN50+C.RbjI!c;G2:.*U%7;SV);s*)/!LEX,<+]A<"r'gj\3+H7UDlr$+91Um
PQ,h)//pWqp6Y6Sk(=AAEs35)PE8_g"Wsqq#;$jk*uoTEVda6pd9NORN'K",pWUhXfEku"e)
>`f.h=Q<)7Q",bMJ3bNi90shd@l;W#(KDs!%2MW5o1\Id30%Mi2!N,Q0^EKYm1<XSQgS;KU;
!fg+QPnDSKMGJu+bqQg.c(]A#Re<r\MVeniat2;&P9hDSgl%Kg7u6ca8*i89/8AZ@.G3*cepW
":#N1B5nNc-3ePo4+P/-P6&)'`O$jR%"@<%TH_=dJP]A_=,^k!TJ;>cHKrgg.#1JmNlbK)9m%
//T@+IS!qL<sCr:l)IjS?#"^EM(]A'stRAJeVh9FR?UCi6Qr:p/D<rH^I::%ZhiLO2rb0h=dE
gkC!fCj'RSkursqOWuUAI1",J-0]AnM6\cu,+;Y4SpV7-$^m).ZFWEW^\a9knc/drOaO"R]A8R
G4mcWgJX''!Saca"kBUTV\^1DC&^12=Pe?Zh%S@8uc)rEhE@V=,0r+;DH\s,-eg%3d-iT1;-
%QS/arF#Ph]AD(WKBBV>-On,u5&4m>;rV#96'7^8aOq`i4$?aYi#(tV;fm1CE'c5`dhgrj3)d
to]A%nga/O^t$`p/B=d%;f=3r59=]Atr617l\m-K/N%hLbMG2t0]A!>_Z-)d:&\]A?<;4nhM&:<9
7*H&#EUL5dU:IqfV^aA_,uB!-cWW/m9H(b>nu+JY<G9+h22,JH?)nI*.S?$%a_X&.)/HAXoC
^J1]A3#sN8S:;?q8cB/9DH@AX07F6/W)<"?tY:*(WqC\M+YtRlm'&gM=<9XN1QS>oD1DJ92%m
U:2r#U+sA8"\M/OkA4'[fmP]AR^rpg=p3X\K:&YL*P16LZ`f6;'F8Y:':-c3SDX<CH_N/5)34
k;o%?H%`fc@a+PX-c"9fiqfAH+XhM>i-BteLDf523VDiP?7]A(?ieLZqlJHglb0L$PVWHB<n"
)okddlF`M%1(UE$@_LVA<JcUo-@RL0M<UC$7!J:>8cbR1*OL>GVB6Kr49Y<_pF>hL\""5_%+
rIKL^.PEgps(6/=+s+8CAM4gE@8F?Y**BcN#ODbZ3A`e.sQkGsHch7=.d@;Jl9E9?8N-<:R<
ht2'`YgdW)=o/:K;KNb$*T=X5]AE3*JB]AJUg9<Nu/+ITY$b.>`*G#l9dn6D:lrM(M6_7\WBU(
cN0JJ=0CT%-=,j3KSeaaQf$-*UC8)G=?0Tf7\eSX.@N4Ma`!o&7[L'VG#OX4DZURj-u5$`)F
Y2Ehk<M1apZ<`jl>0_`]A;_nEc8>.V"4?]A]AST(\*p:\+3]AENkGkR:@>Jdq4JU;^ZEYHW<bEVJ
NHGid,dMJ7*<Mf7l#p_X&-liQ\sa-'SDR*a4><Rf\!9A[jGN".5jD8-nA+A>N-6a]AM@8()l3
o9)cIbaA;=rC0s/ph5d'Mon[tG"?HT1`$Ql"R3^/%$QqU&jmY+2@a;@+6EiVif-Agt>Af<^'
N@8u4L(\\Gc=`HtdZK>loa`Tq38BI08QS7L5a0)I@$,X&'e!(]A-SSIPP\@@pmim-_$!t/9kb
aFhcRKjC`dH@PWV<&moF.4)BZE]A_H9sSR('*]AHL1(\Z>X`H@`3;Z#BUHjBF.^L=5hdfQBJMQ
pVet7SgL'EK`oC4<=^2,m70<SlLWnSrO^5fX?j;27Z`WTnd[LCah(///\L\R9TH;Mia--Gem
-?mKj>WQU46%)K6)?MSR2C5pBWLPs#0't)NH)KpG>*,^8M$4\8(Ams?WR9[a>>(`\$Ik(hs6
8Mq?QR!2^`Q'g2W8fYUB=X]AB(:<i)>i-F+cU-T<Kf!-$H)@l2M"abqS`m?(6^P>L;$/$fU\X
/!7[^8:gJFUn.PNlH@SqR]AGuEc"Y=&22X\^$mkMoZH$3*Ej!rYR^]Au@G\]A,cq":tn.(V=Qnf
#P>b)(ftX(!:/qm*s@/;JX>pU[M[DaH':hVefB@dH/3D<UF7[8l?0c'j=`9*V56^16K-!V.T
[_(,gZ1o)0;LhZ`Y^-.[te;tN,gr/;8(+"g=+^$;C,J3)TA\c[ui`DaD+oPtI'k@e:BG"apR
J,DF0HeS$#fP`*R..62CN;Y@"DB+i<T;;NS#_<FK'bi\3G^H-5,JVQ?!c7OgbdSR0sEMW9>O
;ILtEaaIDcn'I`k"V7Q2fOomgB?=BjjMgO?@\JGeNM(!8&hZQksa@r^4gjAkuL3>'qVk4`hW
HV`[^VjNikC+@:p8@bc;@g9nOCM]A<s>"iU1Q7jLn$ihCum8E$.k,*aUn+t@'4%?SpT0$VhEK
HN:\O_^`$@5ZSkk4o,S*Z#H$]A&^Yao@%#>YR2L/UDdtNnS%kd>MpFs/k>Om[h1bgBQ4;4`,3
GDVsUo/FA^$=gG=gnc&NCMh=*W^Mn8X.&gR2IX+u*CJRbL9QW<Hd^6Jte;>GXi'1So,Nj_Kb
kuE$aV,!'6;;oEFiF;;]A`fNs?JRF5CcD3;cCr7@ma<Ime!^)M1)@`u(NTbceBJ\r,[391eR7
h,`(-4H#tG<g5"OEaUuKqA(;380iG3#$9ecXsc/V*WITn)t3%+/(GC%>>+)J$rYIF(;?OlMk
0XWl"\ul!nXAelPW`\fqEgaEghRiE4UCDSl+Nt24U]AK]A@h6.W$*TYQDfUW@d4-=*5$]A,QP\&
15pTEqE_hr?m*BXa9(O6I6g+,Dn\aj0I0Y:6]A\gNck4)8M:S:VZsJmk@o'7^0.P5ap5rM:H<
n)"+0jAM]A3HMQV0d7+k'#>%2<>"+QRLL9qBLN?M#r@=ZMuO'0KTXpWAj9C@g7p_@;EV0Xck%
ifA4:E(k';nKEE/QW?%376j1j>9sIDoDd,Rfe`]ACeKe,.C5QI0oEm$?6A"c%b`L78^(*:":8
nG4>*4?\7Yq<1mK2#Qkk[9SQ(r<")HVtR=8E^YI<=D_M5!47mrc.4I@b;)i['CI)ELXbc$OH
+.(l('QJ?l,ne`MC@.`r5H#Ero@`WYcOEMsWH\7t\9/`MP*fH)MSR0-p5\%d\eaf<lO+N<f#
5DEG(L,\a2$$T]A*^?YKmE=Q\#W@[!8Kb9Gp=>33lYEc/&jM(I;YQsAIEBgS_E+PrX]Ao!Ila/
NF1N:uh:oO"R/ck%+)0+Zi;2$ogR,@o9C$=XNY:L1><q@+`5pI:]A0#[DYi;Z2b<Lod/NuCm1
>^WhU`-t+lo2X3g,2S-W2pDJAeW><Vdc+HoP08g<HR"eKt_#%%KblSD,t8Wp=,8M71mCc`<k
e^55?Ppab?E,gt@P:LKZ<F:GJ`LND,u8knIBTP)]Ak-WYN^/aMt4`3fG\&g`[$CQj?EMkm-A7
nTO1T)g!G/CC\ip4NX_S'e+42fchG]AT_cn68$D'`qD.ZB-_DL;MY]A/Gf92fZ?6#OgrBjIU45
C(AhiU>>%*G'QNuX:(%R?`44)cJ)3:N.1YICN=D8iB4%%!;eQjQHa^2)K"p<\p6Z/e`'C4U!
bi3bZ";k[tUd:-6k6"<+U6qi2d6I,>eZhEYL;_ZHnheWL_ZupkCRY:l.&PH^TIGcNqM`k^SG
NoTEf'Kk$[f[ruf'Vq*+)%IQ=bm4=>EE_9ZG1;#-C\eE@f[Ki/nKMa)16@>:VpsY/`f(&;i/
gfe=H@B9BDp(!FoIglFh,uS='r)+iDV`AG+gT?#7?o6h5Jkm.<0<.Xp,!LAKh;ls?@=(mFBE
ri8PkVgaM86nEA[q]A7ag1eF%;^HeCQCofbJYh;cJY_Eq>dN`&'m/khM*a#OnL0b3K5>*.Yh&
A!Y[<T#)VYc(.B0\kpEKRI"]AJmlQ>\!+?LFonVAk'M7KZRSH<>N3]AJ+L;D;b5qorOrbmA8A>
8A_c,]Aq)$A`I,5FLB]A<[l+I,cj`*=PsQ<WR54jW72LknL>+Q&Kmp_BW_D;.YMV$(s>el7)+#
;i(*,-lBR?bgUT@,I0B4-=Haokn4N3I.3%3(,TcOuGHnR]Aep#I*HHBfgW[1=-4=/>M561hl'
Ok9CDSfTEYBV\mHW#:6NS_iUXdSB\S@(%i",kMLjOYWcIWN+_;if7iH5g=mrPA2`d'[\a2t#
p$(!K6hg!ITd/6%l.<\#N2#AALln^!EW5XUK:DW&#W(l'F5u3DCR^l<KW2SUh)#&W?-0H:0W
8Vu)?<IB.-!tgD=I;]Ar5(>4ljq`dgLXAol,EXO~
]]></IM>
</FineImage>
</Background>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
<UPFCR COLUMN="false" ROW="true"/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[1066800,2171700,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList/>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;;eNO'M;Y>CPZlZG(">4d4*B@*%kUcq+c4ZCR9l^`kAa"`TqsYh&E5RGR!83UVm@(8l`
Gs['$D]A4X+dJp.7-QG7m[GS&>fRU,Z9;Z(eB1@&/4W%'<R4/L7F;4[pGd'LOUTHbPCl+mJYe
SrAa`6(N1W'/IPhg5u>oI5C`'e&/67;+T.!f(8IKQg$h9="T@o,)mAZ(FhtV^hApm@WM_Q0;
LN_.pSm<CHd?'@=_+DaY+5?\2t<"TpamB`p9,kDRprQ7Ae;CKGOL#e>CUCU6!WnnUqY7R^bO
nHHX2lcei2jL\Q-23IYC90GIV($]A`taEoGkK6%0&4b<3M/mX+E`JYqc'"]A+-]Aq"cql\DSCA=
G4)D44-C,/&_7R?W7V.-"eY]Aq,D5#&qIC&h[^o2Hh=tS`?F5*F,HN?W&j&9KgrF[0Tkp:!'e
uF,kF&Nj:&/nJ>,;.`FoOVEMpgp'>9*C)ipHY=a!\(.<RL(=<90Eb$QYrI6*"Qi8'=KCgR,U
SKjIgPm#"F)*#f>-b#!</+,%=&(X_*c2od,4s7PO46QoFt35\r^W2!1V\GWqFN5<qg;gM<J4
0bj,[iIAsX#)"0hr:tNc$d,:2F_a?+PeKD09Ae3#Q=-d'r.\.dUnJQ'GaC+_s$t&<V50g:SX
Q=GHIT\Jk2X-8:kq+HF)8:(\c'C@8F7U4K52'UI\VXEX\r5e^$gj="F9f_F:rD".#^^*7/8&
</bkt>2hRBX^SD(Wp4Wm&dc,6:?NE;ojG:#h9akpf%f1!$J_Pl/Y15P[DU;.T&^G4]Al\D:;*
)Hi2o-sgh^B;?4*T.BPi$IA\*\i[Q0M,I1JFD`)CC10[\^j58(WoR"ntqRMJoWP0#!krRgQ]A
!.`ILU6LhLuYI$Ka<%*C%5YcsR,'JZpe'N_"p`i\t'hJrlo<aChQeeH8UkilWj5#ETEn,Cg;
/r`Oq.=3<pbQHWGDDs'q>g?_lMOi,),6nZdauS-dL%;7)/feII`$X0CGeY,.!gaWKm^A/3b#
e&h')7RJ.L6S-0LlT,<Z@eXQm)-=6K0%;TPhn;3gEPdRA.+p'm)<lE/Ld,X]A\8B]A(A`@QNlR
(RgIbMcu*$<*\ZYN`G/7]A;4o!j^3<fnG"9j5PdhKhHZbS]Ac1ldTDNf2KRZ5Qh!2nj*a<>qFe
h9&qu!#!bm!.bh6iqBF09P.6U!MqM;$oQr)A=l'YXFjCl]A&Z2h]A<b4!!Y1n7On:H*FfJdXjD
kg0r5Yn\B'0W8#)!jLu)e`AgYL.b%sX&a@?ZaNDg>ns\nO#N0@HJCO5i(KKZjNdcWKT"A/g]A
U=[mi3F%cU[#nj-8%f\0fRb3X0:#g'<e-Bj9k20ga+VS:liPb:rOp<%GCo:%eM;VP:iYf:d[
*l]A`AjP.K4R-lqY(%"*KO'CXmtX3I9RmD&\BnTuj\=N(Lc=f&Z]A%Ei,]A:mWdqUa&Ia^'p1P%
W73fRXP]ACb[+BNur#:ADO:?oDFF%*<,I`\m\[Yo`fG4pk^nNL;eF[5$$/^67GN7ICb*..$>i
0*$YJ5MUr*pRgm(eh36-Kddo!;h%!l6s>AK`]AG7@(I'W3_J-DkhP^\E+fu:EGd-I_.4q+"kV
_p++#"J,$@uJ(h[`L@23is.;4=(_ONDKd9G^VD.RnMbsX8BZ);pSDnK/g5;!?N_#+^28f6fH
a>f2Gg7POHiCN^`D`JR:O++cOm=#V8sjY@Uu@mn#toU0qfqrFolB8">,24+h@UBE#KoKnqV#
eF@^7[-C]AQq=pmkK`E"@TpN7g)*L)eAiC&[=?F`8sS9tD]A(OZ&A.;*FQ_IsY_.0M'N?r/>QQ
(Tc<.]Aj<<h>m^,g[Z,*noq6Rd8Bg*FO$<bhm5]A:c$[2Q"C%jIInr3d/`kOcXKYY!kbLGr=[*
8=+fdjB,#Gps\]A?,LVhm&As+9-;?iAK1QA>$t<U569m#bg-YoVSKAFe]A!/_eq1d^Hmsg$s`L
t!o53oC<nohQkF>ir;I+qkEb/nK?FfVd4`dd1gAlkXk4h@]AO=p3j#iL/?*l!!YLnq1J>%"g0
&Y"^W\hPAR,Hp4Dh4F+%ae(^7:r7_aNUZG=!f);'=32Qr8>ngRb&4P`@V2!_$i#0LJV^#BTD
ni.//n-F^W.#iLAM^I#WWqd&oR"N$U/!JE^]ARO050K'E&iY_IJau?^ZnJ$O6MC2?1A9JG7h#
gXRGOZfnnYiA;9cl!(S&aYkKm#11<\?G]Ab\fd9=I`n"^1fp[%h-4pW"YqetmGs-U1*\6",]A/
As3pHcW'0CI/Yc7&.+q?o<DEOSh?=4rW3h9=d"Mjld8bZo3GYj\c:nX38t&Lf>bY!B(5N-#Y
M3'!Z2`Yp6f(u(34_ofrh_749`]A)SD@%4UEC\^o"TB7@k'^6kVW]A/YFW;;'u=Y>*tmq/`ptb
C"-cI!(m]A"TcNgY`j1j3!r9S`]A_TCX`6\,D/(af%JZN>r"&!-1m9"-Lb$h*)E[m?;YWm5,'#
13gtM1%kQs@B@8%-kQd91]AZm/Xp;]Aj@JRr5^cp#X8m69B6rgVA8.4:7FtG<S19]AV/b.AJs_8
M/;>g-pQbTFUJ@TWq`fJWC4(*`]Ao!%(.7VZa,C3<kP\\IW]A<fQ:W)@'2d\qepqFrpj/Ck>'e
Uo@FR;!&A,ac&9Xk$t/gg-i<gfS\SBO">]A'6::A+u+pqMefMfQU*LfKM8Q'\$Qd]AGojgDB4C
kIk):h,-1WZ\)oB4+=Ya_omF-uQ]AI03Vbqre.7F^bOldIcB12fPUBGAfRk=`:c4(0,C80sDW
Mf'6*rd;,b*lo3":YA46f:;[oMU\QP4OWGmcu%.9XHk;O@K+&Y]A?7`'[_=;GDc&Y(.*!EHkb
5!e,CmEhE4+@HRDCifQ5TXOUh\r8.2iqGu5MVK@1trhG8f8:FCsC4$"Qb#JNZLT>K\V"W^^g
Ha^6X7[$Lg:ESb%8+!oRm3W5<"<7i7HMVL3))$qp3'>\oQdI^JgeFo)lfX901LA.Y'LW`.h&
A1;pXrMR^_Q&"e"r(=SOb4aK)]A0Db@VDBp]ALn)%l4qc1K$%pfB<\k\03k58t?0G;-Ir7/O3+
7dc1k83EK&fWhi5(^aM(S<?8C'%L_]AT7;1_$en2Dn=@CJ[3"b)@L6^#.)Q*RZ02Y%tjZh2H;
SUYV3X^Nc(lt$&Cuo<UZ,5SZCG[CcfumdPMYTQO0c.i_:lAPBr./UjHTJ6uR6JKe\`Xf=-@j
@/JpS;H9u0@)#ne/U)Ifhg/8%/>'-s%<rk0HYP)IgTA9APE@e1M@PtWdIg'_P&Go:1Roo?90
*,!.;%nFO=*KpL&@WY;sr9,/0CL60CB(:nt18G%TN2Yqh[1hS26o"j(@\p:5["0_?I+Pr'):
2d)&!jB+i2iXOh5;p1X]Au8[*gflg(2$%4=<?65!H_p"mt,/&^W[f!@e]Al@ekb:oJUuNd>RZu
!6p6tbRmqT:-1ogIcc"r'$==(((GLM>*@W?3"Dn&@8DYY*!o%bLAt6q_X]A_('7>:pD+-EC52
\G1b-gCrYEYP*@9Zj*o5sCbT8#/b$?p]A:SG[f"#GV7/"H`Op-7]AVTRPF]AH+Ylj0<os1'I7<<
;3lN^0m4>pmlANV?D"?=kYmJ:82f1_AHb[<t(hj[.R@u_g>('`f[&s+JG[t2F%6GY5>H!]AX*
$U(7tWb2H5;P7>A.hbHu.'-g5ON[s,Kq<J#iM8L@9_oF:!rMR60>L@6FNd0Y?^QS<;Y).ULD
d=3O_JoE.,)9B194o`T2[QbEe1#jE;=3X]A-6uCR'Gl?aCU/BjPQ#\6j\M#M?XiTf`s@e]Ard5
)A/rRE@h<FfKkij]A,]AMuV]AR0SYF.Wu3Mga8nMrh0s#puqT05ho7^UqbN.)4-K"qRK,5]ASq;"
EuWiI/@=I,u'*nj?g;?'Yt+mA7,rbc3f2g"4">8FuC''FO7g?Kh-bi`>7&-'+g0f.up74:l_
/Pk$A;e>JRoN99e$IO_uK,j]AT:/;6O27.0#-cKO\Lk^R7TSoe#1LJ^A`ojoaJRBl%,E?:1!?
4X\(f3'eaXQB&VOs"''hZS564%l?d$rPQ*=bGI!=j6BhWb:fgY,]A>KCA`"<V<iN<ULNKQ_&<
$($J&58hOKQ9t9c5Is,W2MV1ccJA39ptOT4PGu:.%6XZ&+VRa[LCDTkV^r`-gKGYsA'H&`)V
P*T/(C;VjTCj<<>IF^U\QVA8WG!BF_21*h>ZKBZ`e%)&n]AZQ1![%rf[Fe*4qWGek#l7l27a=
-m&["57e",$9@OBq[UG+#HKm/j6LBO6DfhSiIioJ-hO\0LE2u4Ihp*UiTRT4^%1]AElP$+R:Y
IH,I:]A1PZ&:3H*]Au\95QE?+>br8Jk:Vd>jYL1`2+;07pPh"m4q8ARX]A-VdEU^[+"&u8N&(Fu
^TQE.]AYs^?YkloCpEqb11q6[87TX*5F3#GaP4ROR*hgoVCd?Z0TnI,0:#H\7-:qDq:[B+n/P
n7[YdMPMB@EtM*ME_e&PBsd[1&uRp/DANRX;^d]A,E\e2j@;2<+oO9`Jc<=\]Ah)KdJe9V;N/'
goCc2'0>3.`@/WrRV:KZ]A3*($Sia,?EA]AQRK8;D0[gGCtb]A--un<V)2.!pI_f&fKmTG5!4YY
j$qp!^Q4%Q-ugH\]A<bm_+r?UR^5pdpR'^;JSK"uX<:DpV^XHq$[AA;Q_$4*g&Bbs&GkjTT=t
&(eP@u^r!`~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="644" y="0" width="313" height="242"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report3"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ImageBackground" layout="1">
<FineImage fm="png">
<IM>
<![CDATA[D0gIM<;ZRmR5nac#%Pi5@Lstk-A>:A80k/X#n]AWu8qnn=2D]AC@9,fA([,#!/&k+">#$htm+t
>F38@EWH0>DSjf(XX]AkP+fDSF_1ocg,j>cguHID^1+Ib=5B78K7^18_`W5NW=S5!<<d-^a!b
M.NaWQJ5o1L<`Gu\\KfoB3@bU$EJ$/deXF(d9VGW:CP5oX>Wb@JD%H?d<N\/-R61pU0l4-17
R%R#b"be]A,]AToU`jq)%I#SJ?_%i<&;:ZLa1*P:*HM&%R;,[,67K;6iIkR7Mr]A2l8<"`+O)ms
qXAu)EH6;5=QWh'Ln06raO!O>Kd0;Vq'J1j@erVZE:lGIK7e;.3a^n>PLpI_L/goEB.WqeZ&
*(Ohqm!R"8V5BS51#pB"[oI\2din[_m&9#/8g!G,/_i&7_DNKTV%tmO\O,`BhYcGXE]A`gUf2
KP/HOa--D%tX9[$[Gc:Me&)Dc\3iK#gn\MS%YCd_\D[8eM>aE7%N5$[?`fs%hfMJ._Z:r<4J
B$(d$!/]A'Cjc;Vbhmi.8/c5hkPQN_q%pN@#g-nC-(^6&oD!e^8n#?^D*,MRh&AVf59jTg1[l
:<V9/)-E@Th,:+FqTdX.F.Am]ACq?+D4%Tg;m@FnEL1^tP+91!L3j'h$N:IIZg$`%EtFFY@81
\<jHdlur\UK:@9NakT$F#)J\frNGFCPr$)GAMniLo*ngCTIY.s&#^X"hq)?hqbp?e5AC%R+m
B$,]A-;@FMA5N5"'>4g6dReGu_XOW!rqh=0TZ8gr-e^d9aBqJH@:)pX_W,$KKJ6d,HpdL:D,q
i%B1>oXa5-$@&;X8#0e]AYDp]AZC8CejV'(6`ql:?q1M[&a#6^35iQQ_VuhNVfkt1YA8B)GOj'
facU/DPTjui:m;l.$i.;:7bB=N:,8$^&0&ftrR)'(Lt&r?)osXsmgcG`Gkn`@[C&LRC-+t/X
aI&Z<u")^>De!X]AkjLUa:H:1g:$?#q'2A1SlU7>Ke(g8UofXBR_q2.OGp'W,W;/A1Ee#RQgR
]A;8X34mUOrY<jM/HWk_lN*EWWMU%(l9MLrJnM:JYDN8ZPGLX74q]AmUeN_'!?+m>B"[)q=bg?
h$D`$T+K3FKL0%-X\KqdO!V"&J-rKC>OG<t8KiSsbC1?j)0J>$SF0A95mLf,Xor`=1!J'#fE
E+Xgi,^:>EFl),o(#`3`-b2g]AQm('<VQlTOn@)C(#6;$T!Q10HR1c&=LbAD"Gm"HK%[7\=u>
u2!M3hN[LN!.5/55%YT-j7]A8;S.7&?7nM$m902(jslm2:fMi0^c\L^O>XW+pWg#9Z0S7aXhX
BJe9LDc*P<3inPB_t=I*<kj;)9MWUGH=="CsCHEb9*Y@c=??drGJa$(1)]Alf>oOJYT>'!:RH
=Ga.*$OUT-56#0ULFOa%l#\&PV<Anat`ZXB2:j:QG*hYaogoRcAVCnqWEIaG5[FsLPH!Su;r
AA\?=j"#;UlKAbGW!ttPpDm8;hh@G:#8>$olXgY>=T1]A=EPtftM\f&phk$c(DN%+Rn=&:3'S
\*k;J!)--ZDgqJolqtT_h4]A<NrH7\kkmC-I;2"lF'7\f,Zb;+E9sLS#&hnSR+F8p0>7H"#DI
n&F%mHC@`CM\?WDtGDR0P_'D<oo7n,GJ]ADF,"!'Ye\id.ZSG:LNG9:UMoP^2>/PY*c?((i2S
-ou>I\@AHbp'O>:4rP35bVgGPr(RaTieCk]A"2`J3p8R'W&gML\DD"fCnr#"(S0oG`2i5W!u$
43('B0>3d71tXg\*;2O)JQRlOJ?@EdT,_HQQhT!=rG[<n_bL@/2L]A-p7j0hk^]AYtH1i-\gut
niba-J!9'$eV+5R-qp#K]AY=QBVd%,*=_O$n^^"a<2HHND3=oc6DPCGeJ=+td&GGM9^/&q/da
,e!g>@B]AWDr9ne/qfZ0m[e6Ds#H-ICSNXOeJ3Ai+[`869lU<V';@N`I)&0jlq@0S'I;$^Jsk
[C?MG>ShBgOS0Q@o<0`h8n8G7n=@_$hLDbLJ=9@5o_)Q>O(#$sl_7Le2gLf(b=(g]Aq'SC2)"
"Zpc%9R(cI@,Z-h%S!)I+F9;_QO7SI0gN%c?&8A:s^MA`&>O-YOIe_Cn4@k$5=.Ig[]A`KL%s
<gCh`$NR_uZ-io5#[OXAcr]Aqhr%%!V#o4=a"sP<%$"(3qsgI%[4#Z[n,npgSm=%hTd/a>s>_
oS7*r3.P\3,'K*!13fT_d=]ABLhp5YY:,H0a`QHGhTbFtK]A[NeB*$n8f5a[bSB',Wrf-hC7gX
chTjEh_)#7u/if`#:07M8HRHQ[WIl7Q4YPXO71G@m&+:#DcpMc^bK!*c!c!gKe'7pNc&8Y=R
41bjt0hVIaNbIVohqS'`9\GF0n6D`+;[=i?X-Fo0aJk.(P5hob(g9$,<@*;cu;)2R<DVJF\U
8$\pn3,<ZX7=ETj]Akg$gCjeZKJJ$]A$_4U+e:?jc-Zh6'>*)G&"ITA2S$%#bJ2JTA)rA^p&sl
bZXYdNeRg'43k6_$R3:_d4/B:_G^X.E7eTl0CidH&T1qHsH-I(VnGfa@PmL:2^DA?P>SSOod
qFf>@98:r77tAM>j'l\P<>(JL-d9n/G3dCdh\/nGF"!j`^l/)u_?p:ndh903:$Ji@/3+.%EZ
3"UD%']An3"-9=Kg.k^2K;ta1Y)h4^j)X?DCA6"@@76@pj2VrhGu)?D"/OfOGPQ[F"G05EQks
E1N!;=l'$[d(F$)Ud%$KK]A4!\n"u_"AmK.Kn?f[nU\>2A$B@YQ@!2>k/\;r%Z)\0CAkT4B+-
13uHH/=\o='9Ou<!X*f'@`qs&OBD@5Ru+t#pUPh"+Cg&OXG]AKRV\!7U6hJf1duKX-K3Bo;qY
\n9t'gn3ibr<>t3O3+s@/G9e?!i[&;l.9hC_OLTC^Wdl0$*g5$s3ZGLhf4R2/=4R-;;a-04^
r4&#N#q)iIAf[$<5Erp[O@#LHASaat$NT8ZeF>t,c?j&]Afd.GGE*tc4lYA8Q>;s8%ijXep>%
kbQr3`gm=Kk]Aa#"0UTWb7dZ#oEY=@RA/c1eLMB!_;-@BJ_N3;DE7n?trt=@[3@<cQAGu+iBT
ChAm:4]At9B`f\P*:Is!g@4e/d&>>3Md]Ab?.$Oj=o<Sc&mLH9Ll;EXhs-\`W^l(Gd/iIehB.J
U#hWgrr\tipoS:RiTFW.1eJJO7"leF+9k[[8D$U(A1[e;6s-`bR_XKj"j;8b9*):Fo)@gkW@
)bGe%op%&UH)^73EFIK]A^gg_+/)nJ$7;kcDJi;eWW7jD@tU6+\>&Du:g_!5s(2MTqUNgm`eg
g0uh,j*,SGar*eU)?goJKf:XE=%4S=aFd+`g@Hj.8]A9!O=JU;mb;nFFgWJG#!fa_BJH]A^n)p
aU(MYi^hp8qYnhp\un_JhK)Z1.HESL]AII+cM>"AHGL7jiogd^nnC:?,;6.>WM^LD2)^kO]AfM
'8uRdoO)(<);VmUjnK^g*@V]ANXVrFLnJrrnfStmVqC+sPCdO/_m%6iFqoQjm)rS')8&W)Uj]A
OF#!kpR1;MZ#$>X5&R\5r*fQZG8*+^7hHHgN"B2X>>,:c5\QN-uC+30^169/9Ps-Lhg7,gpu
7IKbYCA2fi:fUG-(?@\G)lUU&gP(o.)S\_XYc!7ULM',?i-@g`oV*C!,2l5426gQodX:V3uq
V4:p=V)QrK4D`8"<#28`^!H'M!)@-;O<>Fq2SmfdXGnL$*shbHZ+aq:jHE7=,N&;4:ZmBY_%
[o@'ZL6ainc$l,]A@>gUs'h^QSiLP#6+(P^3EVFM99^B2;,DZ?SXB=?>?MB5#%[pdb#$a&t!a
dU\ZSfZ">^b`iW@J=WB#Fs4I1<nqe$lT=@:$GO!t83`f/qTiWDY9tbjGLbk".'C-mVH1<ThC
q-Md,Y2Q\P53pB-7@O=G+8>]A;!;3e4n_t).<.RFNit;R.Ha=n^%,2:fTG*HS4s)?GCm50]A^+
[qk?Th9K]A1QLUqFZJqobUj,L6QQ;"GB2G;XMcp[Y]A>=f_enj6epi+\@u:F#3o*G.#NPKAp9+
1Vl.V2'i?V'K4ok?'2t]AoQ0Og9Cc19!s$W\gr;)oS@?CC+;6B1I'OO&ji*.QT$,CJ^P<&ACL
eW"h*$om680,dW0mn.aL@gW=1[>8%UuI:C:nA`GjS!;Umh"RC6.DRr*\+G1"_u`27SS#!%$L
,64O48brV1baBo8(<,h:en]At.V]AK@C4#0^%AD/paC!s@Jj=7!0TUFbq.ReYbal!=B&oO\^"&
]AZ6.o/"pLph<$_!5M2M<77Hppplh.&##okgcNO\r^0^@?!o&gNi=2rVX6o[@^F#q9hHI[_"[
<\L>1+0CUTQiEOq*CDlpG]A!J%VpG"U3/84F@0"T+P5?q^GaiVT1S`kn(-M.QCYGlS#a'P-OI
q)nIdQnJ.`$P(gbZ/UfSa-l3e07"fU/[3&GKluTg,Bj1%5p.6s%n$WJbt-H\ei5E,M_T<QPq
)6A&4KJS[mGMQ$gek6TYSV^0ft+l]A3>c8ZVG(//l6"lp$`JL-k,:b'LBsNM+&?p+PR.K3O*V
]A>NoHp\^8H[O%POMOT"[/6r`!TWfQt#=_o<`MX\,VW7kArN?VQ>20VW%]Aspl[]A`ML(XJ?++N
NRlG-+e"MNt[Z/q3BsWOnVLl.)n(:7'!n?g_9Ru9dtI^2V4-U$h^P4)Ym/[nCG6/f$.dFG89
3N9!2O!:cS@&'.Y8?b+RECA5kqjB:_9K6[nWpMRm-'@10en=L$3]AO%t<-h;=cJ>$#<48m/,d
+,r-6I[ElJO_#Q97gX^4.4Ko+G.;bR7G)^u`L3n]A.HiD)QT<Fd6V4L+f_0^-BDsf_O/>CBjB
5_^FsYtFKZB>`5bo17UjZMLI$GG&]AUI;_@LdD-g170u.K$Y=WYS7<Jb*"Mp$fA0MEm&!(AF;
J('/Ps-e"Mti_sZP5C7dsE!At11ho&c9jVMcql)g7,1Y9'XdbMV+)M?o<[&r[G("K'A5bjKE
m"d<;o9K&[S8,CVjm#rC*4Ml>sIEQ2n`WdKPhHeKt;^EWOC4*j6s=C(TlLN[79"R$uF_2#Yi
&P[VImY<f?"kB]A<B9im1BfSdEXD.t@l;CgIa&Ca_eR*]A,tFiO5S-I3-NFXgEoi%lQ;@X3=".
I#,%$SP&d1<q4/'ebEBAqas]AJpft?jrk,P8fn5ElQIlF;$<Zr4CPre]A\qVgKSpS2>_8I_^fQ
_POJ*SjF$?oWV&rZd?0U0NHGbq=A\j?M6.mJEe,9Mo!^Khq2cRP(-d$O5ZM7*-gpP[Q03p6H
mQtQ<:()0RlXMZFjGOEqj1En6,B:HHe06%ImDnHi4htKPL7$p'`fS=pgZn7"f:.CF`pd>XRT
9=FN#=^'-'2if+R^dG=]AhPQsf"W_c5.m+Q&4AsN%/9S55?=[=UNtZ<+`&)G*C=cGG4ZVKHYh
4G;gdoM'5tIKd,gc6eI]AL93@C%nCJP`d5nF$1#\SbNi"$m<Tst#>=8p.@;',Hu=t7_(2ZcDs
h_,5W#n`'mh0t-'&_F!/@g3iK[mVtmq8W=\^'m\+)A#rE;]A1h[0QaK`$WWKK(^d$HfW]A+IN>
C)T-KJWe.(;Y!$F&@X'(RN-rAS$lr,6[17M6V+c=s5=a,I*4lJRR%`DJd<'hMhf-*`o&I[\m
f'3%-BaG!H8VD99W7P<_.$=Q:ikEa-qlgS%Q5h2[l@.nZ.q]AfReOP,Uu`rQsp8!*WP.1(kc9
dr3mG1>1/^BML8(R:CbiF8Q.qF^_T=*jPdFB7[_8!&ei=G5UFG!(Ue3^.VSOEW2Z=@2+Ks%/
(\fI'qpEem'-\3E$!aOjr,RL*o"kcR]A!-O?8%cin\.g_&Mb[4]ADW$_k[?AAC2C,_FKo0;-,_
"dG]AKjtEH^VLL'5&r^OXi/Kj)i.g5e7\6)Q<T^B:M-E^V$VZ:QGJ?Qnm[8M,#]AgG0OgRF0jj
`=i=WbJQ+e#QZ2Zp^WciNH>%Zl@DIMj[q7U]AOToV.T'dKTV:ZSLHRc`K_PWRcR*r%eAb,k)^
eE/7O!F`tGX)QW6uN:KFc3dW\oLU-qAqU-M5dsV/mf8$;&EN&oCnol#.;]A<1Te61']AE=O*`&
c.E]AA(cqOC,YZr?<WcDoZN:SO4=sB/@4S"b.HiW4&A0]Arir^G3UkB<[lY_.05eBZ;B\_pec1
0hs&G5>CN\*l4N'@-)cD\SReWt]A<7]A]A>\)?u)-n6N*O"2fiBe_XgD$rSVhmTV3gtjm6<N'$t
djRk8'F#??oOR%AT4:1ch[Or:nj>iXqp2q@\.IiZko=t9HqYC;b?6W0AB94nj=;?k@qYt("W
IF".?Tl_adfY%C``D;;\efUf-JR*2L=RGrKHIAJeLF+"CZ>55f6c@.\g8F'@=Ous""LE1-U1
d=nH3:["Tbk]A&8%#`9_KOs,,"pqrW@fK<enNAX'ftBHd#9k6NO6?_f;U"C"f$Q%1E8ZE0%p2
Q^0F:\V`"oN6trZREMH36M#$:il#Uekb2Er;i>Pc3b5U"6J#@T0bbur/3]AY)R7k=SqXa>KNS
%!A`s)YiS5Q5TN50+C.RbjI!c;G2:.*U%7;SV);s*)/!LEX,<+]A<"r'gj\3+H7UDlr$+91Um
PQ,h)//pWqp6Y6Sk(=AAEs35)PE8_g"Wsqq#;$jk*uoTEVda6pd9NORN'K",pWUhXfEku"e)
>`f.h=Q<)7Q",bMJ3bNi90shd@l;W#(KDs!%2MW5o1\Id30%Mi2!N,Q0^EKYm1<XSQgS;KU;
!fg+QPnDSKMGJu+bqQg.c(]A#Re<r\MVeniat2;&P9hDSgl%Kg7u6ca8*i89/8AZ@.G3*cepW
":#N1B5nNc-3ePo4+P/-P6&)'`O$jR%"@<%TH_=dJP]A_=,^k!TJ;>cHKrgg.#1JmNlbK)9m%
//T@+IS!qL<sCr:l)IjS?#"^EM(]A'stRAJeVh9FR?UCi6Qr:p/D<rH^I::%ZhiLO2rb0h=dE
gkC!fCj'RSkursqOWuUAI1",J-0]AnM6\cu,+;Y4SpV7-$^m).ZFWEW^\a9knc/drOaO"R]A8R
G4mcWgJX''!Saca"kBUTV\^1DC&^12=Pe?Zh%S@8uc)rEhE@V=,0r+;DH\s,-eg%3d-iT1;-
%QS/arF#Ph]AD(WKBBV>-On,u5&4m>;rV#96'7^8aOq`i4$?aYi#(tV;fm1CE'c5`dhgrj3)d
to]A%nga/O^t$`p/B=d%;f=3r59=]Atr617l\m-K/N%hLbMG2t0]A!>_Z-)d:&\]A?<;4nhM&:<9
7*H&#EUL5dU:IqfV^aA_,uB!-cWW/m9H(b>nu+JY<G9+h22,JH?)nI*.S?$%a_X&.)/HAXoC
^J1]A3#sN8S:;?q8cB/9DH@AX07F6/W)<"?tY:*(WqC\M+YtRlm'&gM=<9XN1QS>oD1DJ92%m
U:2r#U+sA8"\M/OkA4'[fmP]AR^rpg=p3X\K:&YL*P16LZ`f6;'F8Y:':-c3SDX<CH_N/5)34
k;o%?H%`fc@a+PX-c"9fiqfAH+XhM>i-BteLDf523VDiP?7]A(?ieLZqlJHglb0L$PVWHB<n"
)okddlF`M%1(UE$@_LVA<JcUo-@RL0M<UC$7!J:>8cbR1*OL>GVB6Kr49Y<_pF>hL\""5_%+
rIKL^.PEgps(6/=+s+8CAM4gE@8F?Y**BcN#ODbZ3A`e.sQkGsHch7=.d@;Jl9E9?8N-<:R<
ht2'`YgdW)=o/:K;KNb$*T=X5]AE3*JB]AJUg9<Nu/+ITY$b.>`*G#l9dn6D:lrM(M6_7\WBU(
cN0JJ=0CT%-=,j3KSeaaQf$-*UC8)G=?0Tf7\eSX.@N4Ma`!o&7[L'VG#OX4DZURj-u5$`)F
Y2Ehk<M1apZ<`jl>0_`]A;_nEc8>.V"4?]A]AST(\*p:\+3]AENkGkR:@>Jdq4JU;^ZEYHW<bEVJ
NHGid,dMJ7*<Mf7l#p_X&-liQ\sa-'SDR*a4><Rf\!9A[jGN".5jD8-nA+A>N-6a]AM@8()l3
o9)cIbaA;=rC0s/ph5d'Mon[tG"?HT1`$Ql"R3^/%$QqU&jmY+2@a;@+6EiVif-Agt>Af<^'
N@8u4L(\\Gc=`HtdZK>loa`Tq38BI08QS7L5a0)I@$,X&'e!(]A-SSIPP\@@pmim-_$!t/9kb
aFhcRKjC`dH@PWV<&moF.4)BZE]A_H9sSR('*]AHL1(\Z>X`H@`3;Z#BUHjBF.^L=5hdfQBJMQ
pVet7SgL'EK`oC4<=^2,m70<SlLWnSrO^5fX?j;27Z`WTnd[LCah(///\L\R9TH;Mia--Gem
-?mKj>WQU46%)K6)?MSR2C5pBWLPs#0't)NH)KpG>*,^8M$4\8(Ams?WR9[a>>(`\$Ik(hs6
8Mq?QR!2^`Q'g2W8fYUB=X]AB(:<i)>i-F+cU-T<Kf!-$H)@l2M"abqS`m?(6^P>L;$/$fU\X
/!7[^8:gJFUn.PNlH@SqR]AGuEc"Y=&22X\^$mkMoZH$3*Ej!rYR^]Au@G\]A,cq":tn.(V=Qnf
#P>b)(ftX(!:/qm*s@/;JX>pU[M[DaH':hVefB@dH/3D<UF7[8l?0c'j=`9*V56^16K-!V.T
[_(,gZ1o)0;LhZ`Y^-.[te;tN,gr/;8(+"g=+^$;C,J3)TA\c[ui`DaD+oPtI'k@e:BG"apR
J,DF0HeS$#fP`*R..62CN;Y@"DB+i<T;;NS#_<FK'bi\3G^H-5,JVQ?!c7OgbdSR0sEMW9>O
;ILtEaaIDcn'I`k"V7Q2fOomgB?=BjjMgO?@\JGeNM(!8&hZQksa@r^4gjAkuL3>'qVk4`hW
HV`[^VjNikC+@:p8@bc;@g9nOCM]A<s>"iU1Q7jLn$ihCum8E$.k,*aUn+t@'4%?SpT0$VhEK
HN:\O_^`$@5ZSkk4o,S*Z#H$]A&^Yao@%#>YR2L/UDdtNnS%kd>MpFs/k>Om[h1bgBQ4;4`,3
GDVsUo/FA^$=gG=gnc&NCMh=*W^Mn8X.&gR2IX+u*CJRbL9QW<Hd^6Jte;>GXi'1So,Nj_Kb
kuE$aV,!'6;;oEFiF;;]A`fNs?JRF5CcD3;cCr7@ma<Ime!^)M1)@`u(NTbceBJ\r,[391eR7
h,`(-4H#tG<g5"OEaUuKqA(;380iG3#$9ecXsc/V*WITn)t3%+/(GC%>>+)J$rYIF(;?OlMk
0XWl"\ul!nXAelPW`\fqEgaEghRiE4UCDSl+Nt24U]AK]A@h6.W$*TYQDfUW@d4-=*5$]A,QP\&
15pTEqE_hr?m*BXa9(O6I6g+,Dn\aj0I0Y:6]A\gNck4)8M:S:VZsJmk@o'7^0.P5ap5rM:H<
n)"+0jAM]A3HMQV0d7+k'#>%2<>"+QRLL9qBLN?M#r@=ZMuO'0KTXpWAj9C@g7p_@;EV0Xck%
ifA4:E(k';nKEE/QW?%376j1j>9sIDoDd,Rfe`]ACeKe,.C5QI0oEm$?6A"c%b`L78^(*:":8
nG4>*4?\7Yq<1mK2#Qkk[9SQ(r<")HVtR=8E^YI<=D_M5!47mrc.4I@b;)i['CI)ELXbc$OH
+.(l('QJ?l,ne`MC@.`r5H#Ero@`WYcOEMsWH\7t\9/`MP*fH)MSR0-p5\%d\eaf<lO+N<f#
5DEG(L,\a2$$T]A*^?YKmE=Q\#W@[!8Kb9Gp=>33lYEc/&jM(I;YQsAIEBgS_E+PrX]Ao!Ila/
NF1N:uh:oO"R/ck%+)0+Zi;2$ogR,@o9C$=XNY:L1><q@+`5pI:]A0#[DYi;Z2b<Lod/NuCm1
>^WhU`-t+lo2X3g,2S-W2pDJAeW><Vdc+HoP08g<HR"eKt_#%%KblSD,t8Wp=,8M71mCc`<k
e^55?Ppab?E,gt@P:LKZ<F:GJ`LND,u8knIBTP)]Ak-WYN^/aMt4`3fG\&g`[$CQj?EMkm-A7
nTO1T)g!G/CC\ip4NX_S'e+42fchG]AT_cn68$D'`qD.ZB-_DL;MY]A/Gf92fZ?6#OgrBjIU45
C(AhiU>>%*G'QNuX:(%R?`44)cJ)3:N.1YICN=D8iB4%%!;eQjQHa^2)K"p<\p6Z/e`'C4U!
bi3bZ";k[tUd:-6k6"<+U6qi2d6I,>eZhEYL;_ZHnheWL_ZupkCRY:l.&PH^TIGcNqM`k^SG
NoTEf'Kk$[f[ruf'Vq*+)%IQ=bm4=>EE_9ZG1;#-C\eE@f[Ki/nKMa)16@>:VpsY/`f(&;i/
gfe=H@B9BDp(!FoIglFh,uS='r)+iDV`AG+gT?#7?o6h5Jkm.<0<.Xp,!LAKh;ls?@=(mFBE
ri8PkVgaM86nEA[q]A7ag1eF%;^HeCQCofbJYh;cJY_Eq>dN`&'m/khM*a#OnL0b3K5>*.Yh&
A!Y[<T#)VYc(.B0\kpEKRI"]AJmlQ>\!+?LFonVAk'M7KZRSH<>N3]AJ+L;D;b5qorOrbmA8A>
8A_c,]Aq)$A`I,5FLB]A<[l+I,cj`*=PsQ<WR54jW72LknL>+Q&Kmp_BW_D;.YMV$(s>el7)+#
;i(*,-lBR?bgUT@,I0B4-=Haokn4N3I.3%3(,TcOuGHnR]Aep#I*HHBfgW[1=-4=/>M561hl'
Ok9CDSfTEYBV\mHW#:6NS_iUXdSB\S@(%i",kMLjOYWcIWN+_;if7iH5g=mrPA2`d'[\a2t#
p$(!K6hg!ITd/6%l.<\#N2#AALln^!EW5XUK:DW&#W(l'F5u3DCR^l<KW2SUh)#&W?-0H:0W
8Vu)?<IB.-!tgD=I;]Ar5(>4ljq`dgLXAol,EXO~
]]></IM>
</FineImage>
</Background>
<Alpha alpha="1.0"/>
</Border>
<Background name="ImageBackground" layout="1">
<FineImage fm="png">
<IM>
<![CDATA[D0gIM<;ZRmR5nac#%Pi5@Lstk-A>:A80k/X#n]AWu8qnn=2D]AC@9,fA([,#!/&k+">#$htm+t
>F38@EWH0>DSjf(XX]AkP+fDSF_1ocg,j>cguHID^1+Ib=5B78K7^18_`W5NW=S5!<<d-^a!b
M.NaWQJ5o1L<`Gu\\KfoB3@bU$EJ$/deXF(d9VGW:CP5oX>Wb@JD%H?d<N\/-R61pU0l4-17
R%R#b"be]A,]AToU`jq)%I#SJ?_%i<&;:ZLa1*P:*HM&%R;,[,67K;6iIkR7Mr]A2l8<"`+O)ms
qXAu)EH6;5=QWh'Ln06raO!O>Kd0;Vq'J1j@erVZE:lGIK7e;.3a^n>PLpI_L/goEB.WqeZ&
*(Ohqm!R"8V5BS51#pB"[oI\2din[_m&9#/8g!G,/_i&7_DNKTV%tmO\O,`BhYcGXE]A`gUf2
KP/HOa--D%tX9[$[Gc:Me&)Dc\3iK#gn\MS%YCd_\D[8eM>aE7%N5$[?`fs%hfMJ._Z:r<4J
B$(d$!/]A'Cjc;Vbhmi.8/c5hkPQN_q%pN@#g-nC-(^6&oD!e^8n#?^D*,MRh&AVf59jTg1[l
:<V9/)-E@Th,:+FqTdX.F.Am]ACq?+D4%Tg;m@FnEL1^tP+91!L3j'h$N:IIZg$`%EtFFY@81
\<jHdlur\UK:@9NakT$F#)J\frNGFCPr$)GAMniLo*ngCTIY.s&#^X"hq)?hqbp?e5AC%R+m
B$,]A-;@FMA5N5"'>4g6dReGu_XOW!rqh=0TZ8gr-e^d9aBqJH@:)pX_W,$KKJ6d,HpdL:D,q
i%B1>oXa5-$@&;X8#0e]AYDp]AZC8CejV'(6`ql:?q1M[&a#6^35iQQ_VuhNVfkt1YA8B)GOj'
facU/DPTjui:m;l.$i.;:7bB=N:,8$^&0&ftrR)'(Lt&r?)osXsmgcG`Gkn`@[C&LRC-+t/X
aI&Z<u")^>De!X]AkjLUa:H:1g:$?#q'2A1SlU7>Ke(g8UofXBR_q2.OGp'W,W;/A1Ee#RQgR
]A;8X34mUOrY<jM/HWk_lN*EWWMU%(l9MLrJnM:JYDN8ZPGLX74q]AmUeN_'!?+m>B"[)q=bg?
h$D`$T+K3FKL0%-X\KqdO!V"&J-rKC>OG<t8KiSsbC1?j)0J>$SF0A95mLf,Xor`=1!J'#fE
E+Xgi,^:>EFl),o(#`3`-b2g]AQm('<VQlTOn@)C(#6;$T!Q10HR1c&=LbAD"Gm"HK%[7\=u>
u2!M3hN[LN!.5/55%YT-j7]A8;S.7&?7nM$m902(jslm2:fMi0^c\L^O>XW+pWg#9Z0S7aXhX
BJe9LDc*P<3inPB_t=I*<kj;)9MWUGH=="CsCHEb9*Y@c=??drGJa$(1)]Alf>oOJYT>'!:RH
=Ga.*$OUT-56#0ULFOa%l#\&PV<Anat`ZXB2:j:QG*hYaogoRcAVCnqWEIaG5[FsLPH!Su;r
AA\?=j"#;UlKAbGW!ttPpDm8;hh@G:#8>$olXgY>=T1]A=EPtftM\f&phk$c(DN%+Rn=&:3'S
\*k;J!)--ZDgqJolqtT_h4]A<NrH7\kkmC-I;2"lF'7\f,Zb;+E9sLS#&hnSR+F8p0>7H"#DI
n&F%mHC@`CM\?WDtGDR0P_'D<oo7n,GJ]ADF,"!'Ye\id.ZSG:LNG9:UMoP^2>/PY*c?((i2S
-ou>I\@AHbp'O>:4rP35bVgGPr(RaTieCk]A"2`J3p8R'W&gML\DD"fCnr#"(S0oG`2i5W!u$
43('B0>3d71tXg\*;2O)JQRlOJ?@EdT,_HQQhT!=rG[<n_bL@/2L]A-p7j0hk^]AYtH1i-\gut
niba-J!9'$eV+5R-qp#K]AY=QBVd%,*=_O$n^^"a<2HHND3=oc6DPCGeJ=+td&GGM9^/&q/da
,e!g>@B]AWDr9ne/qfZ0m[e6Ds#H-ICSNXOeJ3Ai+[`869lU<V';@N`I)&0jlq@0S'I;$^Jsk
[C?MG>ShBgOS0Q@o<0`h8n8G7n=@_$hLDbLJ=9@5o_)Q>O(#$sl_7Le2gLf(b=(g]Aq'SC2)"
"Zpc%9R(cI@,Z-h%S!)I+F9;_QO7SI0gN%c?&8A:s^MA`&>O-YOIe_Cn4@k$5=.Ig[]A`KL%s
<gCh`$NR_uZ-io5#[OXAcr]Aqhr%%!V#o4=a"sP<%$"(3qsgI%[4#Z[n,npgSm=%hTd/a>s>_
oS7*r3.P\3,'K*!13fT_d=]ABLhp5YY:,H0a`QHGhTbFtK]A[NeB*$n8f5a[bSB',Wrf-hC7gX
chTjEh_)#7u/if`#:07M8HRHQ[WIl7Q4YPXO71G@m&+:#DcpMc^bK!*c!c!gKe'7pNc&8Y=R
41bjt0hVIaNbIVohqS'`9\GF0n6D`+;[=i?X-Fo0aJk.(P5hob(g9$,<@*;cu;)2R<DVJF\U
8$\pn3,<ZX7=ETj]Akg$gCjeZKJJ$]A$_4U+e:?jc-Zh6'>*)G&"ITA2S$%#bJ2JTA)rA^p&sl
bZXYdNeRg'43k6_$R3:_d4/B:_G^X.E7eTl0CidH&T1qHsH-I(VnGfa@PmL:2^DA?P>SSOod
qFf>@98:r77tAM>j'l\P<>(JL-d9n/G3dCdh\/nGF"!j`^l/)u_?p:ndh903:$Ji@/3+.%EZ
3"UD%']An3"-9=Kg.k^2K;ta1Y)h4^j)X?DCA6"@@76@pj2VrhGu)?D"/OfOGPQ[F"G05EQks
E1N!;=l'$[d(F$)Ud%$KK]A4!\n"u_"AmK.Kn?f[nU\>2A$B@YQ@!2>k/\;r%Z)\0CAkT4B+-
13uHH/=\o='9Ou<!X*f'@`qs&OBD@5Ru+t#pUPh"+Cg&OXG]AKRV\!7U6hJf1duKX-K3Bo;qY
\n9t'gn3ibr<>t3O3+s@/G9e?!i[&;l.9hC_OLTC^Wdl0$*g5$s3ZGLhf4R2/=4R-;;a-04^
r4&#N#q)iIAf[$<5Erp[O@#LHASaat$NT8ZeF>t,c?j&]Afd.GGE*tc4lYA8Q>;s8%ijXep>%
kbQr3`gm=Kk]Aa#"0UTWb7dZ#oEY=@RA/c1eLMB!_;-@BJ_N3;DE7n?trt=@[3@<cQAGu+iBT
ChAm:4]At9B`f\P*:Is!g@4e/d&>>3Md]Ab?.$Oj=o<Sc&mLH9Ll;EXhs-\`W^l(Gd/iIehB.J
U#hWgrr\tipoS:RiTFW.1eJJO7"leF+9k[[8D$U(A1[e;6s-`bR_XKj"j;8b9*):Fo)@gkW@
)bGe%op%&UH)^73EFIK]A^gg_+/)nJ$7;kcDJi;eWW7jD@tU6+\>&Du:g_!5s(2MTqUNgm`eg
g0uh,j*,SGar*eU)?goJKf:XE=%4S=aFd+`g@Hj.8]A9!O=JU;mb;nFFgWJG#!fa_BJH]A^n)p
aU(MYi^hp8qYnhp\un_JhK)Z1.HESL]AII+cM>"AHGL7jiogd^nnC:?,;6.>WM^LD2)^kO]AfM
'8uRdoO)(<);VmUjnK^g*@V]ANXVrFLnJrrnfStmVqC+sPCdO/_m%6iFqoQjm)rS')8&W)Uj]A
OF#!kpR1;MZ#$>X5&R\5r*fQZG8*+^7hHHgN"B2X>>,:c5\QN-uC+30^169/9Ps-Lhg7,gpu
7IKbYCA2fi:fUG-(?@\G)lUU&gP(o.)S\_XYc!7ULM',?i-@g`oV*C!,2l5426gQodX:V3uq
V4:p=V)QrK4D`8"<#28`^!H'M!)@-;O<>Fq2SmfdXGnL$*shbHZ+aq:jHE7=,N&;4:ZmBY_%
[o@'ZL6ainc$l,]A@>gUs'h^QSiLP#6+(P^3EVFM99^B2;,DZ?SXB=?>?MB5#%[pdb#$a&t!a
dU\ZSfZ">^b`iW@J=WB#Fs4I1<nqe$lT=@:$GO!t83`f/qTiWDY9tbjGLbk".'C-mVH1<ThC
q-Md,Y2Q\P53pB-7@O=G+8>]A;!;3e4n_t).<.RFNit;R.Ha=n^%,2:fTG*HS4s)?GCm50]A^+
[qk?Th9K]A1QLUqFZJqobUj,L6QQ;"GB2G;XMcp[Y]A>=f_enj6epi+\@u:F#3o*G.#NPKAp9+
1Vl.V2'i?V'K4ok?'2t]AoQ0Og9Cc19!s$W\gr;)oS@?CC+;6B1I'OO&ji*.QT$,CJ^P<&ACL
eW"h*$om680,dW0mn.aL@gW=1[>8%UuI:C:nA`GjS!;Umh"RC6.DRr*\+G1"_u`27SS#!%$L
,64O48brV1baBo8(<,h:en]At.V]AK@C4#0^%AD/paC!s@Jj=7!0TUFbq.ReYbal!=B&oO\^"&
]AZ6.o/"pLph<$_!5M2M<77Hppplh.&##okgcNO\r^0^@?!o&gNi=2rVX6o[@^F#q9hHI[_"[
<\L>1+0CUTQiEOq*CDlpG]A!J%VpG"U3/84F@0"T+P5?q^GaiVT1S`kn(-M.QCYGlS#a'P-OI
q)nIdQnJ.`$P(gbZ/UfSa-l3e07"fU/[3&GKluTg,Bj1%5p.6s%n$WJbt-H\ei5E,M_T<QPq
)6A&4KJS[mGMQ$gek6TYSV^0ft+l]A3>c8ZVG(//l6"lp$`JL-k,:b'LBsNM+&?p+PR.K3O*V
]A>NoHp\^8H[O%POMOT"[/6r`!TWfQt#=_o<`MX\,VW7kArN?VQ>20VW%]Aspl[]A`ML(XJ?++N
NRlG-+e"MNt[Z/q3BsWOnVLl.)n(:7'!n?g_9Ru9dtI^2V4-U$h^P4)Ym/[nCG6/f$.dFG89
3N9!2O!:cS@&'.Y8?b+RECA5kqjB:_9K6[nWpMRm-'@10en=L$3]AO%t<-h;=cJ>$#<48m/,d
+,r-6I[ElJO_#Q97gX^4.4Ko+G.;bR7G)^u`L3n]A.HiD)QT<Fd6V4L+f_0^-BDsf_O/>CBjB
5_^FsYtFKZB>`5bo17UjZMLI$GG&]AUI;_@LdD-g170u.K$Y=WYS7<Jb*"Mp$fA0MEm&!(AF;
J('/Ps-e"Mti_sZP5C7dsE!At11ho&c9jVMcql)g7,1Y9'XdbMV+)M?o<[&r[G("K'A5bjKE
m"d<;o9K&[S8,CVjm#rC*4Ml>sIEQ2n`WdKPhHeKt;^EWOC4*j6s=C(TlLN[79"R$uF_2#Yi
&P[VImY<f?"kB]A<B9im1BfSdEXD.t@l;CgIa&Ca_eR*]A,tFiO5S-I3-NFXgEoi%lQ;@X3=".
I#,%$SP&d1<q4/'ebEBAqas]AJpft?jrk,P8fn5ElQIlF;$<Zr4CPre]A\qVgKSpS2>_8I_^fQ
_POJ*SjF$?oWV&rZd?0U0NHGbq=A\j?M6.mJEe,9Mo!^Khq2cRP(-d$O5ZM7*-gpP[Q03p6H
mQtQ<:()0RlXMZFjGOEqj1En6,B:HHe06%ImDnHi4htKPL7$p'`fS=pgZn7"f:.CF`pd>XRT
9=FN#=^'-'2if+R^dG=]AhPQsf"W_c5.m+Q&4AsN%/9S55?=[=UNtZ<+`&)G*C=cGG4ZVKHYh
4G;gdoM'5tIKd,gc6eI]AL93@C%nCJP`d5nF$1#\SbNi"$m<Tst#>=8p.@;',Hu=t7_(2ZcDs
h_,5W#n`'mh0t-'&_F!/@g3iK[mVtmq8W=\^'m\+)A#rE;]A1h[0QaK`$WWKK(^d$HfW]A+IN>
C)T-KJWe.(;Y!$F&@X'(RN-rAS$lr,6[17M6V+c=s5=a,I*4lJRR%`DJd<'hMhf-*`o&I[\m
f'3%-BaG!H8VD99W7P<_.$=Q:ikEa-qlgS%Q5h2[l@.nZ.q]AfReOP,Uu`rQsp8!*WP.1(kc9
dr3mG1>1/^BML8(R:CbiF8Q.qF^_T=*jPdFB7[_8!&ei=G5UFG!(Ue3^.VSOEW2Z=@2+Ks%/
(\fI'qpEem'-\3E$!aOjr,RL*o"kcR]A!-O?8%cin\.g_&Mb[4]ADW$_k[?AAC2C,_FKo0;-,_
"dG]AKjtEH^VLL'5&r^OXi/Kj)i.g5e7\6)Q<T^B:M-E^V$VZ:QGJ?Qnm[8M,#]AgG0OgRF0jj
`=i=WbJQ+e#QZ2Zp^WciNH>%Zl@DIMj[q7U]AOToV.T'dKTV:ZSLHRc`K_PWRcR*r%eAb,k)^
eE/7O!F`tGX)QW6uN:KFc3dW\oLU-qAqU-M5dsV/mf8$;&EN&oCnol#.;]A<1Te61']AE=O*`&
c.E]AA(cqOC,YZr?<WcDoZN:SO4=sB/@4S"b.HiW4&A0]Arir^G3UkB<[lY_.05eBZ;B\_pec1
0hs&G5>CN\*l4N'@-)cD\SReWt]A<7]A]A>\)?u)-n6N*O"2fiBe_XgD$rSVhmTV3gtjm6<N'$t
djRk8'F#??oOR%AT4:1ch[Or:nj>iXqp2q@\.IiZko=t9HqYC;b?6W0AB94nj=;?k@qYt("W
IF".?Tl_adfY%C``D;;\efUf-JR*2L=RGrKHIAJeLF+"CZ>55f6c@.\g8F'@=Ous""LE1-U1
d=nH3:["Tbk]A&8%#`9_KOs,,"pqrW@fK<enNAX'ftBHd#9k6NO6?_f;U"C"f$Q%1E8ZE0%p2
Q^0F:\V`"oN6trZREMH36M#$:il#Uekb2Er;i>Pc3b5U"6J#@T0bbur/3]AY)R7k=SqXa>KNS
%!A`s)YiS5Q5TN50+C.RbjI!c;G2:.*U%7;SV);s*)/!LEX,<+]A<"r'gj\3+H7UDlr$+91Um
PQ,h)//pWqp6Y6Sk(=AAEs35)PE8_g"Wsqq#;$jk*uoTEVda6pd9NORN'K",pWUhXfEku"e)
>`f.h=Q<)7Q",bMJ3bNi90shd@l;W#(KDs!%2MW5o1\Id30%Mi2!N,Q0^EKYm1<XSQgS;KU;
!fg+QPnDSKMGJu+bqQg.c(]A#Re<r\MVeniat2;&P9hDSgl%Kg7u6ca8*i89/8AZ@.G3*cepW
":#N1B5nNc-3ePo4+P/-P6&)'`O$jR%"@<%TH_=dJP]A_=,^k!TJ;>cHKrgg.#1JmNlbK)9m%
//T@+IS!qL<sCr:l)IjS?#"^EM(]A'stRAJeVh9FR?UCi6Qr:p/D<rH^I::%ZhiLO2rb0h=dE
gkC!fCj'RSkursqOWuUAI1",J-0]AnM6\cu,+;Y4SpV7-$^m).ZFWEW^\a9knc/drOaO"R]A8R
G4mcWgJX''!Saca"kBUTV\^1DC&^12=Pe?Zh%S@8uc)rEhE@V=,0r+;DH\s,-eg%3d-iT1;-
%QS/arF#Ph]AD(WKBBV>-On,u5&4m>;rV#96'7^8aOq`i4$?aYi#(tV;fm1CE'c5`dhgrj3)d
to]A%nga/O^t$`p/B=d%;f=3r59=]Atr617l\m-K/N%hLbMG2t0]A!>_Z-)d:&\]A?<;4nhM&:<9
7*H&#EUL5dU:IqfV^aA_,uB!-cWW/m9H(b>nu+JY<G9+h22,JH?)nI*.S?$%a_X&.)/HAXoC
^J1]A3#sN8S:;?q8cB/9DH@AX07F6/W)<"?tY:*(WqC\M+YtRlm'&gM=<9XN1QS>oD1DJ92%m
U:2r#U+sA8"\M/OkA4'[fmP]AR^rpg=p3X\K:&YL*P16LZ`f6;'F8Y:':-c3SDX<CH_N/5)34
k;o%?H%`fc@a+PX-c"9fiqfAH+XhM>i-BteLDf523VDiP?7]A(?ieLZqlJHglb0L$PVWHB<n"
)okddlF`M%1(UE$@_LVA<JcUo-@RL0M<UC$7!J:>8cbR1*OL>GVB6Kr49Y<_pF>hL\""5_%+
rIKL^.PEgps(6/=+s+8CAM4gE@8F?Y**BcN#ODbZ3A`e.sQkGsHch7=.d@;Jl9E9?8N-<:R<
ht2'`YgdW)=o/:K;KNb$*T=X5]AE3*JB]AJUg9<Nu/+ITY$b.>`*G#l9dn6D:lrM(M6_7\WBU(
cN0JJ=0CT%-=,j3KSeaaQf$-*UC8)G=?0Tf7\eSX.@N4Ma`!o&7[L'VG#OX4DZURj-u5$`)F
Y2Ehk<M1apZ<`jl>0_`]A;_nEc8>.V"4?]A]AST(\*p:\+3]AENkGkR:@>Jdq4JU;^ZEYHW<bEVJ
NHGid,dMJ7*<Mf7l#p_X&-liQ\sa-'SDR*a4><Rf\!9A[jGN".5jD8-nA+A>N-6a]AM@8()l3
o9)cIbaA;=rC0s/ph5d'Mon[tG"?HT1`$Ql"R3^/%$QqU&jmY+2@a;@+6EiVif-Agt>Af<^'
N@8u4L(\\Gc=`HtdZK>loa`Tq38BI08QS7L5a0)I@$,X&'e!(]A-SSIPP\@@pmim-_$!t/9kb
aFhcRKjC`dH@PWV<&moF.4)BZE]A_H9sSR('*]AHL1(\Z>X`H@`3;Z#BUHjBF.^L=5hdfQBJMQ
pVet7SgL'EK`oC4<=^2,m70<SlLWnSrO^5fX?j;27Z`WTnd[LCah(///\L\R9TH;Mia--Gem
-?mKj>WQU46%)K6)?MSR2C5pBWLPs#0't)NH)KpG>*,^8M$4\8(Ams?WR9[a>>(`\$Ik(hs6
8Mq?QR!2^`Q'g2W8fYUB=X]AB(:<i)>i-F+cU-T<Kf!-$H)@l2M"abqS`m?(6^P>L;$/$fU\X
/!7[^8:gJFUn.PNlH@SqR]AGuEc"Y=&22X\^$mkMoZH$3*Ej!rYR^]Au@G\]A,cq":tn.(V=Qnf
#P>b)(ftX(!:/qm*s@/;JX>pU[M[DaH':hVefB@dH/3D<UF7[8l?0c'j=`9*V56^16K-!V.T
[_(,gZ1o)0;LhZ`Y^-.[te;tN,gr/;8(+"g=+^$;C,J3)TA\c[ui`DaD+oPtI'k@e:BG"apR
J,DF0HeS$#fP`*R..62CN;Y@"DB+i<T;;NS#_<FK'bi\3G^H-5,JVQ?!c7OgbdSR0sEMW9>O
;ILtEaaIDcn'I`k"V7Q2fOomgB?=BjjMgO?@\JGeNM(!8&hZQksa@r^4gjAkuL3>'qVk4`hW
HV`[^VjNikC+@:p8@bc;@g9nOCM]A<s>"iU1Q7jLn$ihCum8E$.k,*aUn+t@'4%?SpT0$VhEK
HN:\O_^`$@5ZSkk4o,S*Z#H$]A&^Yao@%#>YR2L/UDdtNnS%kd>MpFs/k>Om[h1bgBQ4;4`,3
GDVsUo/FA^$=gG=gnc&NCMh=*W^Mn8X.&gR2IX+u*CJRbL9QW<Hd^6Jte;>GXi'1So,Nj_Kb
kuE$aV,!'6;;oEFiF;;]A`fNs?JRF5CcD3;cCr7@ma<Ime!^)M1)@`u(NTbceBJ\r,[391eR7
h,`(-4H#tG<g5"OEaUuKqA(;380iG3#$9ecXsc/V*WITn)t3%+/(GC%>>+)J$rYIF(;?OlMk
0XWl"\ul!nXAelPW`\fqEgaEghRiE4UCDSl+Nt24U]AK]A@h6.W$*TYQDfUW@d4-=*5$]A,QP\&
15pTEqE_hr?m*BXa9(O6I6g+,Dn\aj0I0Y:6]A\gNck4)8M:S:VZsJmk@o'7^0.P5ap5rM:H<
n)"+0jAM]A3HMQV0d7+k'#>%2<>"+QRLL9qBLN?M#r@=ZMuO'0KTXpWAj9C@g7p_@;EV0Xck%
ifA4:E(k';nKEE/QW?%376j1j>9sIDoDd,Rfe`]ACeKe,.C5QI0oEm$?6A"c%b`L78^(*:":8
nG4>*4?\7Yq<1mK2#Qkk[9SQ(r<")HVtR=8E^YI<=D_M5!47mrc.4I@b;)i['CI)ELXbc$OH
+.(l('QJ?l,ne`MC@.`r5H#Ero@`WYcOEMsWH\7t\9/`MP*fH)MSR0-p5\%d\eaf<lO+N<f#
5DEG(L,\a2$$T]A*^?YKmE=Q\#W@[!8Kb9Gp=>33lYEc/&jM(I;YQsAIEBgS_E+PrX]Ao!Ila/
NF1N:uh:oO"R/ck%+)0+Zi;2$ogR,@o9C$=XNY:L1><q@+`5pI:]A0#[DYi;Z2b<Lod/NuCm1
>^WhU`-t+lo2X3g,2S-W2pDJAeW><Vdc+HoP08g<HR"eKt_#%%KblSD,t8Wp=,8M71mCc`<k
e^55?Ppab?E,gt@P:LKZ<F:GJ`LND,u8knIBTP)]Ak-WYN^/aMt4`3fG\&g`[$CQj?EMkm-A7
nTO1T)g!G/CC\ip4NX_S'e+42fchG]AT_cn68$D'`qD.ZB-_DL;MY]A/Gf92fZ?6#OgrBjIU45
C(AhiU>>%*G'QNuX:(%R?`44)cJ)3:N.1YICN=D8iB4%%!;eQjQHa^2)K"p<\p6Z/e`'C4U!
bi3bZ";k[tUd:-6k6"<+U6qi2d6I,>eZhEYL;_ZHnheWL_ZupkCRY:l.&PH^TIGcNqM`k^SG
NoTEf'Kk$[f[ruf'Vq*+)%IQ=bm4=>EE_9ZG1;#-C\eE@f[Ki/nKMa)16@>:VpsY/`f(&;i/
gfe=H@B9BDp(!FoIglFh,uS='r)+iDV`AG+gT?#7?o6h5Jkm.<0<.Xp,!LAKh;ls?@=(mFBE
ri8PkVgaM86nEA[q]A7ag1eF%;^HeCQCofbJYh;cJY_Eq>dN`&'m/khM*a#OnL0b3K5>*.Yh&
A!Y[<T#)VYc(.B0\kpEKRI"]AJmlQ>\!+?LFonVAk'M7KZRSH<>N3]AJ+L;D;b5qorOrbmA8A>
8A_c,]Aq)$A`I,5FLB]A<[l+I,cj`*=PsQ<WR54jW72LknL>+Q&Kmp_BW_D;.YMV$(s>el7)+#
;i(*,-lBR?bgUT@,I0B4-=Haokn4N3I.3%3(,TcOuGHnR]Aep#I*HHBfgW[1=-4=/>M561hl'
Ok9CDSfTEYBV\mHW#:6NS_iUXdSB\S@(%i",kMLjOYWcIWN+_;if7iH5g=mrPA2`d'[\a2t#
p$(!K6hg!ITd/6%l.<\#N2#AALln^!EW5XUK:DW&#W(l'F5u3DCR^l<KW2SUh)#&W?-0H:0W
8Vu)?<IB.-!tgD=I;]Ar5(>4ljq`dgLXAol,EXO~
]]></IM>
</FineImage>
</Background>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=now()]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-65536"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;P@p?a'!Tbu_c1uNY)r8q=.(*k0O%"$+XGsPG,ae]Ah6e8=\TtX>`Y!bo+uJ@qSK<")+h
F6c<.s1<Pj)#$%MjdlLu#%i*"-*f"Vh["+:0;=OpbW7?a=%Oc-1'N?hOU4m4S4PF$B0W]Afbc
Pq>HoJH/HqTrSsc6B:f*lV\'&WB&-[,ru"+3'aR/)\+rg^J!n&lcSGjtmP!1orRopIT<K2R$
C=oqj7JV3RkrA:hRRq!#QC>oJ%DiV(&,_8*I7nfK,),QFftp$Ec^:/s(C>j=2V5U[8kiYZQ3
LpfZP]AOS$c[iiTA)fgse,DiY>)<g]AUW&VQT@/UHtgsF#%[W6fp(42=4sYNU!RUDf=Ak_PO#L
[-k,Hrg,3_V"'=e`MWYn^n2]AE#M("KV!<G'iUPqtHl#\>Y]Ai_eBi/S'+[_')o\5ZDGt^)_LF
F!NfW4&k(3NoqU8]A7cjLB8m<cd1S?M.HY2k+*&jX!Lm%`-4P0)r>k4]APjX=)seb<jRgJInoQ
g7_AVHrC`<.NS\&,5B,Cjgn>ADV=DmF2^\;7-K>J]AUPlWE?T9QFL9Sp0<.eI&>Glh#a4-/_F
47B;.Bfc#I.cX<m^o>]AIG0fY]A_f.1f6$0i3PL^0bmP3\g+?K2W&Bu'iRs!Gb*d?N=o+@47?g
OG]A=pY`lB'$l:O@fnqlIpF5OMM@!`bfcl;N)`m)gh_,sgER<>YJp?%\*$('oE=IG9FF+&k$1
U%1lFRNRMi'UkY2$WM6XM>?mML9uio*Ek?;:OCaKaMHrR(?#Y$p&&:VkQYonpP7fsUGPcXH\
ErGj=)FXL58p`c,b01Kn>!i575^EanX.Gg)"`Z,_V7$PhR]A4F))("ffat'<F;3pSL:%#4*#T
Shq92Y?/+T9\m!N3a[`YY/_6'MUh*\a$lEQfG0@nPqmk2h6MlCi&8jhimuf1`U>$]AVUU;^`W
(=\`WG'*1ibMIr,ijX0o2F9HPRb*L_hu:;]Auh2*N/lmMS/3;;.2GE-<q"./)dh#C,^YCG&98
0E,Br*taXr)Z/%LD:P,,iLS4()\:Pcc3?oW5C.cV2^<Zu0u3gupE=_%).b>H!?b-hKeZe9]A1
j]ApU&l,a7%kd9^;nu[h[Gu[osMn"1,r8Pf,ndq_nfZk`T6[n@jL:fJ?/lk2c@u&4,Y-]A\)'R
kV(ar8LaO-!u>Sre7h1W]AR7`H3[qgLsrYL[tK!#>%bg[2jO'\&UbZp97g8[,(c-.>'6@3#(W
cLPj%)_OeF0^OGtI;f\k:<qXj@l+=uB1YA7:r]AW"bJ]AR^;Domc+%(_ABecNp&T`DW'jA3I/A
^[0W35lM,H8p,5?6QCe*?FNcl=(n@[eGGlrX`o@32Rlk8"t@7MhL*2i3nS9%2Pth7'<.=YK\
3CO>niLRkQ9uq/?PkBgl(<'7QF2at&"%=h5oXR!-oXPS5)K0392MC4"PI_cH$]A:kXkIP4W5P
0#ZY^RTO=2Hoq?C[UQ=Q`,F3J8Yi,,nsmomktZB]A)V>Zjr]A3KZ30rr$KZ#lj=Q2@8.17"d"c
foL'@H`ODD9'C:oek^6LH%b7>-3WSAJ')FEAU%fB.,>iCf5^@0kF/aU*/eb:*`_ebS`KTSIa
<%\B,4%/D#NB%_m&I1Cp#;_tSpQ8SPX'Ru\&Z/%#Qpu^PUem.K?If5j[-d-%=Z!^.K^MROWM
M32Ddfdk_iY@EqI3?ja@?U(#(l/=d`GbeEOW*)5d5Mf]Aa,Z^NRG9oeE>Ygqfh?*;Mn5%jSlD
7&=`Vr.,!M<lV&cR4&;:aI`f!<I]A56NiX2:=Zad2W3A49JW++!XF!s_NNd.Ack=`YiZX0EGk
W]Ad^0gDd6qki`&oU*=!9Cqh%22s8d\1OO\%5\E:9L)bR4\_/I,DVl`@7U5E$X3/1I&8ZPDrW
u0U#CnL%:pe9sE8XJ:7^k'W-(57t$JD-rE3!8Gf3bKU"^?H[3!s4tG7QV09r!ik<=[6boS<O
_l0VY0]A+0qE<&BTBKTD(b)5)\al5Eb>-?:l%YG2/CIWsZi*Q:n`,dKB*:,k!QJ]AFr[1FL)(#
(/Lkmpo5OJ=rnT'iQ^Z?-n7N16M3X#lW'@7R]An5N>dd]A_J!(skV:PWWD&gbXM\;&_+"e.-Zk
:KLeC5TYs)?Z8_1i6TTkmL7_L':Lg6SiO*m'W8$t"%qVb8d>Kr:PN\aMf=!3"YPIL;2M<f8A
lXpfL%1c,U!:'-s]AV=B\AB\`gdYE:^q.?2!,8Jet)WfED$SibKl>eL@q`^*uegFB!LgLh?Y&
QRn0=94#%c&-&AgOknrun/#/ein/B#2[;OH$6<AqdOO6b7k$WOd5>,7_/tE'D2)KrsN$'nZ!
tr9Ob+A9cYW(h%Gjb#(9]Am<0CU686:ejLS.?hVY-"fDl;Bic5/28hLmo-e]AS3VIY8*`^UAcW
s1IUHgK%VG)E(SY[I`:R6R60g\2\)Wk(/(lWCM-(-di;Lu3-A!pS9)b4h"]ADtu:")A>dj;)O
uG:o*j0jV6201aR-Ts+Iq]A7:OFV_kNKkH03u$Hq.Nc1`.KI%n2o]Ac86F*,LbF([7Y%)3"7\R
IeXT.TB:B:R_:tFghQ-+hD=HH0T,+"fmW=P^oA219[0fWD*7MRmJAMa-Dc\`0bEiGJQ=8>#L
0Wd>[i$8N/o4H$fn#=>h4$Sog*+61\[Z]A"OVlrC4I<JoOK/A";\j":ar[$_[;,5EMtX!Scl/
j#?U,SX'pm#_NA'u0L\.(U.u78(\,3pp`hG.H=hn7F;!#8QDk?$JHn,7MI1`kjj>G+203rSa
Mq%5NF@IY^)MJ60Ri=mfR7?LAlPh/O:9b1\NC]AsS.>rXM4j*]A*2UhZEtQe4$`#7H4Ei\6KB]A
&=kEL3lPW5=!`Po$u))6tK/^C<g&)bg7Y`*mb@OVJIj_-Md--;Ys?lUUar1SLAN=*n!FL84m
2Q,JSB.q-3Yf%\bE%#T?csku0=BoF%-)=[ul,26ZV3KRQZ!cU0fBe5eQp$T<o41bD%Z"XAW`
,DO*&10!S\id-"^3"3"W*f]A^`166+qrt<5g&aEDO\0HdM)8?_nGl_W)Ndt!g,X@9V\4QKr7-
M/dX@IF(Git?mT':29R[Y3L0Xsb#HQ_QGZW]AnX+nN[gOE.*oK(<:U]A1pN#oSMD6AK*p(I[a%
:''.GM-4t3+G5trXQ"d.+3p+/sm2o,IkIr"J%j`!^2OR(Sb?7;lti"BfZl<]A_45s=qNm+Z9.
LLS/+o8(5IK+Y#%^ue?GIIrUp6GBd<PXd*"*mU_rV@JEpCQ%6Uo=Zl4E*TBVONLB!NUc/i2?
$m^?4bqngX/(+8:.FIpn:b7APp;$AXBLu:XV'.Scb%QC$g)#Fe9:8;(XqH)62p^(PXQ?Ym3s
G41?,IT;p:8q,e*A5&1-ls[V`Vr*@,MmKOC[RiVK8hrnn%mBbs2N!*'1**$40eQ1t(<^M]Abh
5;YM"1Y]A(0NPCk'$R-5se!8&'h`\Z9".d.>68i6J#\Y*nfJNEG]AXLQ1u:r5t+"o*OtoX6D`'
ka%iU6\J$>!5pMd2tl'EI@:Z'+dS*kKV#13`t@]A?AWEf/Ipup5mE4g6I;Ge#K^uXRc,-jmI.
'CZ[?=3=p41CE\LK2G3T<n?Cq#?3kSjDl^=9aIFLH8%t:6aO/TI.e:^=2Xu"5[C;_!KA4f)i
'GA[Xi/h"?b96TT`Z!AAVU(@CeS(2"YQL0/34,k1hTXcL'BRLgoljcB?#If.#G)#Lguu_5Ja
NA[_$pY=L9b5r\+-\?#t/@ZMPut/k&&%B$be\jNZ%U:7+a:5MM>$0!)E"N'me`lRj'Y?84+M
e$VM=/PLoHkWj8uXLgLiR46g.,SX:60DG"7iKKr9n!\<ofg_+9lhL#PuauoG'f]A=:!n#G4(Z
$NX4lncZX'Bdg/l1H#oQMR),0=$s^Tn+X@F\tM2>+X<4k06Y\2Nn_rI9*%l-4Gmn03dq\eSF
aH?irkPfbTSo':&O3,@rH$Y>M/?`2d96>)WLAj#G,fEK#-8rSh(IEI*%p'W.aZ5X*J1L/pQ1
eb&2`#Lj7#!sNU#(J/gW_sf+f$9D",<sLg(Z&qm68X.E-J_sc`)2p.g]AFW2WV[U_RjsaD$^q
4@[:0blKLRUqNok3j)551p%/3f#8/H9hVo:I!d^"ZMtB'0\k]AQ!8/rI$osqXmT"Ll[=Bq5ct
.PH"jsSd>3]Af2Asg_XPGSE3m@</q=3h]AA1?^JuQU#"2^Mm5]Aq17#tiu)Y->EtXWI^9FM/C3o
l9R<=GOSd#iQY"Ab>?b3VZdrM^M-?H-4SjB>CoID6,s)*\bBaSKN]Aq%Yb33m7=AL#TRqC]AFf
geQI:\cg(C]A@2E-a>*JV;/W%>&OX\.6[)ef3DgF('Qh"M9]A66nd;_4^"]AJ"ma+W;VRGAB78g
ZP7N^$^DHP<+>K%N*Zo[@8;+t;O.aM:_@%e^(0h3$<5a^Bgd!7!6g#'+MtlS)AC#CB5tK9N\
,FsPF><UpmL>lN,h36%[*J(DbS'Qj7MrY-pB`eU[E0*-i!QeGsGb3;ok?#l>SNf4SL6>gBC[
:^'Se3hc]AJ$f-c>`k\(P>Z2K:hiP^7MTj`Q>j[@nkB!(#.&G?o"p:L;f8q3@BXI?iZTKfo>p
>e]Ah=CpdAU*$fd-R+N$@<N,6+(frKQ`N%D2-2q7/Xq%8@H@=n?q$W=Us#rIVHC4@CTk`+2^=
B`!NO,#kA0F9=p\?U6m$6ao[ss:aRIjW\Bgp!NdGeAe"9f#ZapZO&1KeYb#MH[fHs^NG'RZ.
CQB@bWlnc4Dkt&ON8tB.Z(KKPLFV#kkB.XYH@bNj7;3f:eIh,V%;p_kfXYAI8\+;0h8cCs1n
,E7."6>r"=AFAPKPGia$:`IE)Vm=G2n2")#^U^?CNJ?3CI/XHh5H>b@XEWPO!eHr1c"Cj5=#
MH(4&<5'n(?h]AcJk/OelC5cIf07L\N)%W#J=`,\"_njBJ%2R?7U)J&GfQs7_P<T^eO4FRh1G
iO,2\6/obUsS^/a\5="#^@FLg-DJ9/V76V*)F+`"YP0rW?AqMs-==.@H?W*n)tO:F)q^UIb)
3CBl1cRgHPEd~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="790" y="76" width="356" height="240"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="absolute1_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="chart1_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="chart1" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ChartEditor">
<WidgetName name="chart1_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="11"/>
<newColor borderColor="-3355444" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[新建图表标题]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.map.VanChartMapPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="0" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapTooltip">
<AttrMapTooltip>
<areaTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="true" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</areaTooltip>
<pointTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="true" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</pointTooltip>
<lineTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipStartAndEndNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipStartAndEndNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="true" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</lineTooltip>
</AttrMapTooltip>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrMarkerAlpha">
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrBorderWithAlpha">
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AlphaAttr alpha="1.0"/>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrEffect">
<AttrEffect>
<attr enabled="false" period="3.2"/>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" markerType="RoundFilledMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrCurve">
<AttrCurve>
<attr lineWidth="0.5" bending="30.0" alpha="100.0"/>
</AttrCurve>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrLineEffect">
<AttrEffect>
<attr enabled="true" period="30.0"/>
<lineEffectAttr animationType="default"/>
<marker>
<VanAttrMarker>
<Attr isCommon="false" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[lO<9(kN.ld@UNU%p%320!n*#MbeXK/j[G5P!\&"_(WVVp3QVR99FM?2%#e2+X6kJT%%aVN0'
f#?RK*~
]]></IM>
</FineImage>
</Background>
</VanAttrMarker>
</marker>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapLabel">
<AttrMapLabel>
<areaLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<AttrBorderWithShape>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="true" predefinedStyle="false"/>
<shapeAttr isAutoColor="true" shapeType="RectangularMarker"/>
</AttrBorderWithShape>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="5" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="宋体" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="宋体" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</areaLabel>
<pointLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<AttrBorderWithShape>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="true" predefinedStyle="false"/>
<shapeAttr isAutoColor="true" shapeType="RectangularMarker"/>
</AttrBorderWithShape>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="5" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="宋体" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="宋体" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</pointLabel>
</AttrMapLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<AttrBorderWithShape>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="true" predefinedStyle="false"/>
<shapeAttr isAutoColor="true" shapeType="RectangularMarker"/>
</AttrBorderWithShape>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="5" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="宋体" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="宋体" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="true" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-3355444" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="false" predefinedStyle="false"/>
<FRFont name=".SF NS Text" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="100.0" isHighlight="true"/>
<Attr4VanChartScatter>
<Type rangeLegendType="1"/>
<GradualLegend>
<GradualIntervalConfig>
<IntervalConfigAttr subColor="-14374913" divStage="2.0"/>
<ValueRange IsCustomMin="false" IsCustomMax="false"/>
<ColorDistList>
<ColorDist color="-14548993" dist="0.0"/>
<ColorDist color="-9583361" dist="0.5"/>
<ColorDist color="-14548993" dist="1.0"/>
</ColorDistList>
</GradualIntervalConfig>
<LegendLabelFormat>
<IsCommon commonValueFormat="true"/>
</LegendLabelFormat>
</GradualLegend>
</Attr4VanChartScatter>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false" predefinedStyle="false"/>
<FRFont name="SimSun" style="0" size="72"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="0"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="false"/>
<PredefinedStyle predefinedStyle="false"/>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<GradientStyle>
<Attr gradientType="gradual" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartMapPlotAttr mapType="custom" geourl="assets/map/geographic/world/中国.json" zoomlevel="0" mapmarkertype="1" autoNullValue="false"/>
<pointHotHyperLink>
<NameJavaScriptGroup>
<NameJavaScript name="当前表单对象1">
<JavaScript class="com.fr.form.main.FormHyperlink">
<JavaScript class="com.fr.form.main.FormHyperlink">
<Parameters>
<Parameter>
<Attributes name="name"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=AREA_NAME]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<realateName realateValue="report4" animateType="none"/>
<linkType type="1"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
<NameJavaScript name="当前表单对象2">
<JavaScript class="com.fr.form.main.FormHyperlink">
<JavaScript class="com.fr.form.main.FormHyperlink">
<Parameters>
<Parameter>
<Attributes name="name"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=AREA_NAME]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<realateName realateValue="chart3" animateType="none"/>
<linkType type="0"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
<NameJavaScript name="当前表单对象3">
<JavaScript class="com.fr.form.main.FormHyperlink">
<JavaScript class="com.fr.form.main.FormHyperlink">
<Parameters>
<Parameter>
<Attributes name="name"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=AREA_NAME]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<realateName realateValue="report0_c_c_c_c_c" animateType="none"/>
<linkType type="1"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
<NameJavaScript name="当前表单对象4">
<JavaScript class="com.fr.form.main.FormHyperlink">
<JavaScript class="com.fr.form.main.FormHyperlink">
<Parameters>
<Parameter>
<Attributes name="name"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=AREA_NAME]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<realateName realateValue="report3" animateType="none"/>
<linkType type="1"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
</pointHotHyperLink>
<lineMapDataProcessor>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
</lineMapDataProcessor>
<GisLayer>
<Attr gislayer="predefined_layer" layerName="深蓝"/>
</GisLayer>
<ViewCenter auto="true" longitude="0.0" latitude="0.0"/>
<pointConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</pointConditionCollection>
<lineConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</lineConditionCollection>
<matchResult/>
</Plot>
<ChartDefinition>
<VanMapDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<pointDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[日销表]]></Name>
</TableData>
<CategoryName value="地级市"/>
<ChartSummaryColumn name="月营业" function="com.fr.data.util.function.NoneFunction" customName="月营业"/>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
<matchResult/>
</pointDefinition>
</VanMapDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="a398718b-8256-401b-8c5b-502c7d59b1d4"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
<ThemeAttr>
<Attr darkTheme="false" predefinedStyle="false"/>
</ThemeAttr>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="250" height="150"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ChartEditor">
<WidgetName name="chart1"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="11"/>
<newColor borderColor="-3355444" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[新建图表标题]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.map.VanChartMapPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="0" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrBorderWithAlpha">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AlphaAttr alpha="1.0"/>
</Attr>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="0.75"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrEffect">
<AttrEffect>
<attr enabled="false" period="3.2"/>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrCurve">
<AttrCurve>
<attr lineWidth="0.5" bending="30.0" alpha="100.0"/>
</AttrCurve>
</Attr>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrLineEffect">
<AttrEffect>
<attr enabled="true" period="30.0"/>
<lineEffectAttr animationType="default"/>
<marker>
<VanAttrMarker>
<Attr isCommon="true" markerType="NullMarker" radius="4.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</marker>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapTooltip">
<AttrMapTooltip>
<areaTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="true" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</areaTooltip>
<pointTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="true" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</pointTooltip>
<lineTooltip class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipStartAndEndNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipStartAndEndNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="true" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</lineTooltip>
</AttrMapTooltip>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapLabel">
<AttrMapLabel>
<areaLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="false"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<AttrBorderWithShape>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="true" predefinedStyle="false"/>
<shapeAttr isAutoColor="true" shapeType="RectangularMarker"/>
</AttrBorderWithShape>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="5" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</areaLabel>
<pointLabel class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<AttrBorderWithShape>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="true" predefinedStyle="false"/>
<shapeAttr isAutoColor="true" shapeType="RectangularMarker"/>
</AttrBorderWithShape>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="5" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="宋体" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="宋体" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</pointLabel>
</AttrMapLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<AttrBorderWithShape>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="true" predefinedStyle="false"/>
<shapeAttr isAutoColor="true" shapeType="RectangularMarker"/>
</AttrBorderWithShape>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="5" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="宋体" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="宋体" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="false" markerType="NullMarker" radius="4.5" width="26.0" height="42.0"/>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[!V$='qMA$D7h#eD$31&+%7s)Y;?-[s)#sX:.0p+X!!'fuK$F>r"h7,l5u`*![8q'ZP>rI&r\
2a<?c5?"N!?%$Y[056)e7)tlo#+e#*aq[7&('oD@FN;%(9Ij)d=1!N3sZH.ft@=O9o2o@)uW
_Y'6920Eaa"G_m#S.0F"^hfC,e?1.p2jN5M(kC&ucH,"Fr52N#6A\:DR;;%g<ebslPes;;=r
YF5rM<;gJP\R==b-^jH\[MN.RDq_\3dW!UrmW?"o]A99RcZ5"n4%,8JOf[kn>,phjP%ee-hV!
?dXJj$.+7'r?O1MLun_sJJoWHkAMO$p0&1:I^298E]A7'*]A>OK#?W3.>e,O-)*'>bRle5:t[X
UO88l[HM*?o?/^l6G-"Jk=>2"73o:S$An'CR%i]AZIHGXt(!8I]A8J)2`6[V2c`P7P]AnLTMFJq
`;5D\j:HC&-Tt.PUZHceqM7LdrLmXebZk;0gECl/<hUHEF_P"(TM+="/'SLN4U>j/=N[4Nl?
K*TQq/%M9<)**FGg4*LAs0(/BLI$EIL#m"9`lPa2,&VCjIN),F%5%<Sq]A`IZCSkkbFRd.h4i
XJ&%`U+.=]A_`&L^!dVrN*uhLlN_*pWgCX]A4fhX?St`&n0.enKc2f#3_9YcT4IdSLF>Nu1$[-
b]A:h]AJ7enACW;,[-JkkeSnl2H<joYYTsdPe.]ANIu&0aWHfV54F/r2n/'[fn(f(!N==_FU%q;
905/#Ru`cpr&'B(=C!j6;uJ#s?$KA5o>(Z<n8jj73gQg2a51AsM`V42R)7Ft<7GTXLZ@D,7I
[D6H'/ldkJQl<#;>jtBb^kk/SoK)c;$$h2nO\jB_PG#iu-8c*Ju=sa)KHs3V@RhC+&1s&%pi
`M9>SK5pr_`6h5)s+IEG$gsYAC.:P;aQ#^tI.Q$ofo"bQ;dJEgN+`\'(6!:43"bAkW=73<3'
Ii9/6eMnNPh5&UQk+Y;@%B_J?XpdQf]A=>LP:Hp']AVsXRZK_O6IcP*/!T/lD8QrZsF6m@o4ZO
U3)4J9d_X]A;o:K6&Y=Amg8MK7l<3^`DXNO7[Q3cb$7gV.p:&a\rOP[8K_XW+:-RL;<!7JC0+
2<KV*Pi@]A>Kkkir/EEr:)<W-E_&7oNl\)%Gk&2*1W6@p=R_tAuFq583BtDC:%WR^(^]AQc/WV
HSifsN"Pm2X9uSYiJ(08\tb+\:^Vg$E9\MUl3*N#)Anm9V\82$Z73\q+kj#4F1Yd^VuXG&JM
<c-MQ+>9ZG?eP5Z-*nEf=_`2moAX7j3Bj;8bR8mjJL9EH4Ok"]A=jE`cTFi07LjF\gKC&6r=Q
SNg9o2clQ\BqNcI5GU.n7)JC\N@;q:jFJ)nWelX:U!+>CE(H3r0G$Vfp^lqJ\93]Ab64E)X4s
L?r;:U#HFUbB^85uuL"R@LgB_NZ]A2=87l8KdLE04"IM<<C$Br9%80X-P!a"K?1VQOZ`53Ca[
T\,o//aj0WgEQHQ]A(eN1i^N2,"o-'VlF=SsDuho^\dOb&F4'<]ANjq@)LegkdmnBi-lH^L+^f
<jfLQT6XE@<:jO#WZ9aZCuTaK/1]Acf3_NeRqI\fhF8;L8"b",*"`$^EYD2Ipp(>:]Abk*N?6B
MK3m@f'F'M+*iGL.rpuq8\8_o7e;@7=8>(+R/(K8\^c:HgL\RZ6-4X_dB>W*"J?6T3SA/>%+
4/%fjonApa0BkuMW!p]AG1o`kRnhEPQ'8(H$jMigjt9#=4Jg\P1YU`666cHd!\4C"STi%62lk
l5nj1j$O)`Caj+o2eQ^lgrU)H,<WcKp-[%\$.W8`-9.M<A^fP/?:E1P!#1tD`1TVQ)adJ)XW
M"#Z]A'^,<S\Au,l<nkXA:F%l-&QVW2Tb-XGW^0YhqG1@,@S<3Gr6d2siD(^Q.1sjR2?uSG^P
PViKjWs3n..C_4rP/WO:hNn!!#SZ:.26O@"J~
]]></IM>
</FineImage>
</Background>
</VanAttrMarker>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="true" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-3355444" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="false" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="100.0" isHighlight="true"/>
<Attr4VanChartScatter>
<Type rangeLegendType="1"/>
<GradualLegend>
<GradualIntervalConfig>
<IntervalConfigAttr subColor="-14374913" divStage="2.0"/>
<ValueRange IsCustomMin="false" IsCustomMax="false"/>
<ColorDistList>
<ColorDist color="-4791553" dist="0.0"/>
<ColorDist color="-9583361" dist="0.5"/>
<ColorDist color="-14374913" dist="1.0"/>
</ColorDistList>
</GradualIntervalConfig>
<LegendLabelFormat>
<IsCommon commonValueFormat="true"/>
</LegendLabelFormat>
</GradualLegend>
</Attr4VanChartScatter>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false" predefinedStyle="false"/>
<FRFont name="SimSun" style="0" size="72"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName="新特性"/>
<isCustomFillStyle isCustomFillStyle="false"/>
<PredefinedStyle predefinedStyle="false"/>
<ColorList>
<OColor colvalue="-10243346"/>
<OColor colvalue="-8988015"/>
<OColor colvalue="-472193"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
<OColor colvalue="-10243346"/>
<OColor colvalue="-8988015"/>
<OColor colvalue="-472193"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
<OColor colvalue="-10243346"/>
<OColor colvalue="-8988015"/>
<OColor colvalue="-472193"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
<OColor colvalue="-10243346"/>
<OColor colvalue="-8988015"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<GradientStyle>
<Attr gradientType="gradual" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartMapPlotAttr mapType="point" geourl="assets/map/geographic/world/中国/浙江省.json" zoomlevel="0" mapmarkertype="0" autoNullValue="false" nullvaluecolor="-3355444"/>
<lineMapDataProcessor>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
</lineMapDataProcessor>
<GisLayer>
<Attr gislayer="predefined_layer" layerName="深蓝"/>
</GisLayer>
<ViewCenter auto="true" longitude="0.0" latitude="0.0"/>
<pointConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</pointConditionCollection>
<lineConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</lineConditionCollection>
<matchResult/>
</Plot>
<ChartDefinition>
<VanMapDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<pointDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[File1]]></Name>
</TableData>
<CategoryName value="地级市"/>
<ChartSummaryColumn name="营业额" function="com.fr.data.util.function.NoneFunction" customName="营业额"/>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
<matchResult/>
</pointDefinition>
</VanMapDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="c2772f3b-9e9e-40b5-9ff0-a468ece8a3b3"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipAreaNameFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
<ThemeAttr>
<Attr darkTheme="false" predefinedStyle="false"/>
</ThemeAttr>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="25" y="34" width="385" height="270"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report2_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report2" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report2_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[SU,WF<,:7g,3<Vj>EUT*&oFIBMBYO%K2ee>3\f><b$e8:jKQ_)UQgX,K8N9`,UHW]A;GoN/&7
[!*E<]Ao(F'/1KB%6G?T!rA$ht-_tq5h!lqnB61H[W*dFksCdoJTo(AVE,O&-OFdDd'mXJtt.
!:I]A4?IV5:^IK]Al=*O/qcf&?Ds_7&:F/rgMaqg@+c1Se0Fg%3Ac#`@Ui=Pm%:1j,q5Ng,Lb_
rh3sf#RIH.J,c@Hb7)AiT9d3mHNA@%pdkr4N$!GDJl[X[V;P1oZ6^@6ge:2X$5<A[?NT5Iup
q[nTo03p#,*?VHH:4$4tVnfQ]A8p8)eYWX-m?\E7q/^M>:+!WHX\olO0=@bM4Vn.C\_]A/>_-S
C)h'bONG=_8U4aJ+&*-LT,O;H\5)asGfZ9*eWlX=I;"=EJjnpL%ASRM)0ts$(_0GXGE]AR8^@
.5N\VoGW-jqgG+Ie*i"@%9k7R)$P=,2VWjEXN[1gJMni4GP9qlVBh?"lt/Q+^*[j&7H&>#fW
?)`7o4_^Hhk(i;Va&H!b)C^M]As6'e6ZQo"r"o9G#.n[i;"W$;5gB>RNd5<_t+LsTKUAt9#ip
g>Cn-:--rZu\a.;<7+uk/:8f"JULMIP81J)[`2t96n(0W^YBU&=cNAgj??bFd6bFH@-q(`$$
&`c"T+`lbodJ=1FJc9toL+^L1hoGmi68XHV2pbf-8h+K+U)fPKO,>I:B3I*UD;YIE_=c;&/0
-6k_8k5@F(b&qKDeFf=?Q@b"Tbsru6^tNHU<*"89A=m2,9S<4\Qfei2\2/?s@Vl>OG@HHNcd
2E2eOlGhK*1:QFkF%TP):=mEYWX2\W:<FSa<<3_G>,E8]AX-$lIak#M@&R)"e?NjDq3>Fj-G-
cg9N),4".$lmF'NEiR^VO1pdAu]ARQ29#P?od)+IWk,aNUEMhTU"R8E\.V/7"Da`:"sKdLe'R
k,O?2t.LcefsZCq'PF?Q9gh+T;[b59&J3`8k6\&<Ltl-i(f(!CR:jV3uu]ARefe[tC2l,5!dN
/?WD0etkF"oHk$jcT.!]A?5)A?8-IUH/tNEfQ"XF_2%;3,t@e!UjX6&MhJ;tfNK2p5D`21W)3
5d*NK'(u0674b35h;RBX.MNq6?+;n6B)E,%<[%+C!eeLDg[:MsbVgNt#TPfFcFhOha:A`GS:
r)O5%T1j.b++k,:jEfb9/E-Nd1BW1.(;BBt28'p%/!5RLliDZ'kM:4(tE'G%2_>S54Rr.rR)
.a;24T6l(d'MWhTN3=lm3lQ[F"*di,6'6542)JsBWVY8P%IMF_a<**I^YD8H2OJ,[9CA<]A^f
V0?6j8KVL\8`?e!B*DW=(Y@.6/em;PG)4+@'gSjV8I)q7!IW6Xd+$@r;(5<F,+p->.Zm"l,T
^Em/KCu5!j<.UF?18N%s#9$7-R_bW_N=mYaSN)$]A;ZJCS8[d)34C)lPA.oV0krI&cqN7Vhpj
c`TjMVF%<<OETod-ZNC6d=sF9d4YZ%+Nmt6\kn4s2X2RY;?hhP$rjUl<@t>TR\V9VIfJZ]A0s
4mI@T4H,K>$I+l&4r^Qr\!9T,^[eA8$ma)q1_9Orr:!<D8:JJO1#.aRgkb<A7UjR'_T3ll:2
(o#8-[c`eif.5C:NRU6OcWQY@u(HW's6*6jW"Q2"o[(GDnTSBVeE%d+NY&$)3CsRf8rOKu_c
XmUngCMiej0?a2A<Y_Lf(!MfD^,tQhAD>Zq`&#;?YJs(Lq\t^<">:64DHs,GIaqX^^"<Io:)
(JYt2gH+SY4+$d]AYp7T5rCeaE8cMt)lD?]AQ^&KIsj3I=Ks4R<^&d<[ZluK>01(L&&985PKcu
ei;b<0X@-l@[-CX%eCaG"/Vl6r::Q1pTl!`Z`*K&AXUb)<H+;B32?X8O=2s\!#%O9>S&fep0
`c?J02E9]AN)W*&a]AaV47!hNYSB)IP*DT_(o@OJGBYq'GglVN]AkV]AF%SPD)`*/S_r!==/Ed56
q*!RGAI`qEMM5,fi-5N#iDtIVLaK"TX"c8H0r=`>P+bXPpd#(!Rie2T`7q<DDpk1M?:2q,Od
5okTUGc[:Y]A:LJZ)N/^aH0kilJ3_b$7F7n,B`t[`eR(VUokkcU4LseP/6dZg86Ami72*C#RS
fQi(XI4H)J9!1Bm^Q>1/c]A48Zl5_%8#@4`\d@`j<-.s892YRO\?J"oIkoH=U84hq'^B1X_Q"
-=;'/Xc<HB^AR15V?mcoa3epXq6_M-7tGH.TqYYUL(ae(!T-N<Os@;eCu-8!4gai$k0<.i#l
?mFV'Y,ASDU_S7R7i:2,$X&OQW]AjEVS0`V[p+I3ORR$LIgk:oS\PPU1:]A?)FC2-P+(lC*_d?
Re@]Au8*g>o^XXt&VDpu[9Vdn%aaBEFP_?5W!(=-aSNs?_nQPYb8ppYCnMsmqg%n^L\O"9]Ah%
TQirEqP/,"J&?(o@jI)FTVBVUf%[8i'%+.JXU81!cP/D%epJC<dcA;c$$W(=6RQ5kjrI=Jf'
6c_@#%@SMYQTpj>Xcp2EPLHi<<&qB9:$BN2`$&Y=g/XuqcEhg^s[G6JMmm6ABBU,3R5E)DdW
s*7H-#V&3Hd2<cu/hCr%ACk==g,U)mU/DZE]ACm-\U=U&J!mb?uol5DIC&pWmHOSCVQX=Tj&f
'QggFGI.ZiK(aDNSeK:c?<$]AO"5^kqtN&6:M%Q\2SGCBtM+meV(6Fg-&>1>4%/JE0DLP6uu9
>3QNrDq*C7_BC,a.81&^Im;C=mDdJCmD5M\D4*E96^Z?d862!?Go$1Ul"SSkS"#n$'@F,`[$
f%KT"Nt$j"gZ8QHMeM/F#9;S=37bkj`tOGh?PEfkL)\[W%NX3E:l$1N\]A6K6Pp]A<MOVAaTc3
q#Xk89?Efe'f)Eh"/:3@g7->p43)NSRpBT`I)m\5HI#BL9D"f$.N#G9Mnc=="g#Z(YKX#!8,
L`'c6c"ONR\2C6qNtogg#RU3K5C*=O(>VrlZt?a#6n*CUT50)$E)1"a>6]A@\$=rr,`(P@=*`
s'b?Af1Z<X.f6+c0A&2fs6I0jD#Ajp.oloEnH6K7[>@Oakqr6<9=""dODkqLWNPZc4@@";#M
u(**.EGpt[.")50OW3:p4H0sI?PK@Y@huiPEc^j_MgdDmYk>q_V#kl#@]Ad;<5/?mdB,gF<Nk
UoV^@s0)PJ3hj5,7F-908oV)1I4rMcXb[J$%*[0."(j]A@><]A!7Tg.)]A<7t&-:u;)cID92:EC
daH'Pdf5?^hEiZ!/Ej>5YnKf*Gh_*h=\+JPa*S[2EX3k$cmFV*0p`[J#E^hlo'%1?@$J;V7[
q[%Qu%"_qn(]ArZ0*-Y+j0WH/ApRXhk$uHH1#$bXV?MNdH\Y(m5pl*h]AQC']AF\,$+YZ+8>>AY
KT!Hq,s7rb.#&3dV7`pRkKlpE#$YIU?$$cNG1;\5.l\QS!N86I<XFPm`7]A\L*XgARJk?3c=-
^K6-]A/jghKF1GJ^WORAhY,$t]A2\Yr:AV"W$N]AZNfA8ZLE!J`%B9'^?)"UX_XEON(B(5tMU^F
?!.4*:\Yi?dtii_BH+:`%o0(hu2`;EeMthJstEaKmYkVg=o1A/(2B=[9%W*8e$2^64u2a4.J
jHlUuHH(.$<1SVeqO=bRNMl1!-POD1G';NR_YN/g`^NdGUIAoqJV(VF7\Tq\n*T2@YK"<hJf
0"g_\3+0'6lUHHu7t[ED'o8U"cnd"cgl:]A^<rWKd55pF`Jt%bBJIAe4Ha*WKclUQnVG)O`a'
BZ3WDt4$%!0IsFn<1OY\/o\`Bp*f;:2_TI#GK,`nL49pCuh1f)[e@QSiAuZlEs5Mh2PA+9d#
\&P08&/LGN6<rFM`>_.ogB%UDL<<)gfGC5sPS.#SR".]AKfch8o&,Z:J3l1rf&!,MPS#J[^3B
G01#hUZ)O2G\bIEb(m5+uu#^J1P9+&H$:7F?*Jd;i4/b=#q)A;9/FFh@`i,mERXai\9`hVkk
OmZ#X\0>je@:B#[ce1_Z<eqgI#aOkUMl@R*$S%-h.8bs]A'I#2j\Xs0^MA$Cb]AUpmf]A[_N'=c
,eff3S4OZr_J%jXShb0#UmZKpnb=!N-Z,rP-Zl5%?E2?d\d:<4l&n.29;)Se`?XhfM55cFe%
+N0iX8EWU3J_c-B?ZcTDJTJ_@En,g$>U.+9r<+.0nDb!FWOXJA)ZcTQ)G6`41C`&LN*2']A5f
U(-"]AY^l6C'56?!S"uM.lT4@gupD4+WF*!q:,tlRPN\)U;l.8.DVV"K5Is1CP.BuZg/n#g&0
rq8A=J!^:C1./Zme^S12L'rZI6>_De-k7a^aA%oU"/r^Zk3t/@)H@AY44abc$#$*qXE5DPq7
Tl>FQn:eq__jV_,N]AkQ)*sQeV03`ofFAKX<*O-X53a_KOr;W]AL-2$+(%dT*1H,.Y/5;kO3ki
5ECVE;XiI^n>9r]ACik/o^,QR<Vl5-LcAttiR`q*jXs94J64'P6ru%g(R99:fnU76)WE>6W$/
oPOM\t?\K!b'876]A_=qK2_uF5jBupVrt56(SoKh0Y'5lIl9+_-j@ZKXM[ED5Nl_OSf@0Ml.n
?rP<pqK>T+*-\O>^k)6oYqHaZYAC!lrCr>-iqQk:M`8s=hm"NBm*SXG7d*'sUV%TkZ<t$4A'
MW1W#)DRFM4a?//k&bk9C%(0T_(8c4P#`n,kYePH#?$$]AjJ:&)_6@NRclF>R[0uQG?d8/MPX
sFdZH6q=*22">J+#!>sk;#H*!7ij;L6*Og7>6e^N97?['Cl^Lo,A[S^7W;BqpPTAk5:rI;g7
ia<IV9HUU1A3#)^8fqg]AMo_G=@4[cr+\0ZcY&?CTK!nosQhWEr@L)2gCsN;j$N/n:q]Ac?fSK
I7W;6u0t,]A3AF/^:os`ICk-#_0:?Y&IY*NQKLsX#\3$4$?"X$+,QeE]A=Fk_8XsoeJ0@8<Ph/
p-"OVT&lQ]AL(j`4$J@Eg4h=(ReSZ58l]AZl,OB#4q=ij1t>!(+Y5Fne2kK]AbM<?:bu4(WE(bC
00.!%f^1H)HFbJMg^tpo/H45ZpZS"l86I:,-Kf<;6>TsW(s8*p6^Cg75ZhIRI1moJnY(1/<6
``ET\_$Ef4FBcO#o%Q;#hI,.KsA9gEId,WjXsa@&.23JaAJ,F(=m,>T+o0`#">h;C!XE]AK)S
]Air%aACaeld:%2E#7gD@mJ5("V%eTg,u-nflII;jUNGYQP3!YrmrRu'74i>2(`+.gIAll'CR
WV:`@2A;!;pNE0R\m3W>^W<0qaJm]Ai8[N0P+NS_a(NN^F=t',q_ra>a5OZ?4qoYQ=qn"2UgF
jrhb9p,8FP8=jFnYUaQu+T'r2W8fc0O7&p;fM<bQK'm5u1DEsYlJQ'_MY>Zs8C\S#=?>';@j
NYR<-)%pH+2Y0Th;44Dn1Vl]Ahj(Y/YQaRN(eRu!KO6Y1MhR:SR./:)g3c(&e()!nM23[(l+C
r(gDgBAK,.p.`[#s?Kf<1;-kNRFHcIuR/Ihn4!V&)aGcZNF)17H3T">pI,T$(P=VYm!EL#Va
2cnJ(Qn[--O)/XmUmMrYbe^6O##X;:*pAa*]A4GIjiP"+t9lGVFQo+u14sOL1AA9Sn*8>Do78
`PqR[5"e1MZ]A,^UDohAX6e?%qt+4lMc:<#'XaO/Ma2jhFqA&^n.Ss!CXq$U)*'TQ%PY`M-pP
cEs_Y$*P0OIf6iac8LmpY,K]AI$$7u(l=>sS6>U"o<hmNump//Qp?]A/0KJbZj;r?qu$DZHgcM
p*IX1G<`=52QkWmkK_BfP-7q_@Aqi^Rgolb,,ti3A(q@<;maLQC6+fL!sCUOVN1/A7gkFmud
j=jZs?F&F1Y,-pR-Ha@(2DqU,=[l)KA_)lmHY,$VcoODO400;7XT,Y;ckkbhDs#FJ4=d/+X5
R,?gAM>OWgU?pe,+`8(drrqDtqe9H<(f+)cGEPFU\YL+k_BXGtphZnBAmellr[-\$r_0M+lp
f5"D2(I>s0pQ^r3\uh2gJ9>ZjBG[G"C0u+-ZJ?^oXAc.)?-Q97Du0G!9?rYe#&iOZNN47efO
WW$>YLe!o%U&kDG#P]A(dDMq,CdpkTTIFRetHS<D.S8]A4YCE]A*Vb3$U?1-S*L<'eg;`oE/n/:
?H$(8!0R?:O/-@j)cHFk-WD5-\?.rJ0LMtkI=19ha:U2qt\$_RXkhR&iakc\02H:/YPkVS]Aj
Kf"W_s44#e,!&<q%7J`RN5g@bIp4iQgXSeG1n8BO`:Jr=tbZkl)]Ap/5H^d#`;44gX8GIkFD)
hces,!D3=hDuJB#D(o!#]A0GDf:F]Ad4LKq'0[E795g4+B;9B6XN`Skg+rGBj@Tu0p9.;\DGk/
OI7@'WmNft^"qCLR3=blC>P_=_QjT_%:NADmm3(J1KBqM%2:$q7ggP!%@p)5D.$Y?d<o:X9U
fIIAeFLUFL16J"khrljn1@18MViTST&;$!%k/J/Ji2o?sk*:f4:rL`ulWDO;-`LCl92Oh$&H
XM1rSkm)5\;V79R_gD4=nikb\9!3\7)O-n.4QH:^"PeDQ1PqTq/RV):;!FV\p4+ho^GoY92m
*_RA>Qr>"n^.^g.F[A3EPkB]AUqV80m=l'RWt^dXruSb\4eX1J'ke+G#B&fnsRjmarp@O<rcZ
^%Z#pWp^SRpZ;bqagJ"#HNd1k[iNNEf]Ac_,lg?/udPo0PC(8:\_qeF^,^6EfIb*\A(Xbn@&P
6Wf3t'5MB##rraj]A?G%9Tlr6l"k>R`F<Kb>\-Q^%Rl10]Ar&M_FS<Pj!9`VkHRO1Z0p-0KXU:
O"]A4N$c:N"L8W^I\Y4,:?UT&2`o>u['FNgaEVZ:=caS6?r&=i;,g;O&ATbs+57orHn!T,;0P
gC>C98B"?;8ZG;&@BEf['esL3!>f`8_`_`Vn)qlLN#".rkdP(bg5/[ZC*jXI@hl+RgVjQktT
lIGaB=so8c,4d[nDZB"o4S<*XKs8S]A8;:^;6[]A=!!_W&Z#s/m&Z&8<%bDpQ&>@\(9_D7=ian
ps>q-=nmJA3JY+k9KZW1`P3n,[GCiG=hE;:((![%F4Z)=D(:^^WEP.Tdm;]A6PjJgQUqAn0>Z
d9/Y<E,jinbt7dMk4/N!=3Nb7Xok52[#?.g*e`fQG=IL;)Hh-(#%/Hj1ApO*-Vadc1"r.i7^
?bK.8B`Bn[kYU)BgmO=_E4c$DGP">4BTc?On7>"*"m4Z\;FN(BE*PnIkK,+j0L`;l/VECV/Z
9CK;$iRJHW$9aE4+ur\$7i`kedr!>&UR`HR%26k[J,b>Yb5e`HC0:'/2_eg'5#D104X'S+i5
&JJe(<K?KpnrQd9&BR2O'i+VfdM28L9C<Q(S-`igfkhE=t+9%tgp[h6B;m&eGUs!#,ALip#U
CPn./"1?L*_WmpU[jN)35AdY\(@:A]A9l;&Yrrjq;'Y@N4:n8J\G^A%[k@W!+:0j%m,2@LI2d
gm8W(<`<`.7-o=8;tQfG`Jb\D/j(J(m?C,<"Y,WiI>F<Zf&kU7#U<>2<c`78`"BMh8e]A%W1Y
OGssu\SZblG:-A*m]A2PGWi1,q$%H-8!;-En'%-/F`h677_?nA+NcG3n'H"3,"?n7*B?:>r`6
4>t^7o`r='(NR8.a:EU*b2KU/[Z#]A!e_^0ea)b_XV>O1RPj:7Gjn`E+mIYca^$t,RLB\a[T-
[m2"G>F6C/*YJ.joCR"6r=/:'`//HTik1jF#"_oR$eeR-/[IIL\0RajB-_[lIaM6>sf</!e#
@H<>dRrON'QrnSH2TF3cI!f0"P\c21'@CP2Oe!M7<#>;4AlWp)i&OY]A)+d2[i%YG*F2o5)16
?iH(8:NVo/7V/7mO9"]A-O>u7_3I_/.JL9@q>=+,1g>LdhEOu5cY;`%HQm0#[aVC3TrX&]A./!
TSk1Erdgg//$q/c%#2W5UcN@8!n.4*3AO$VjkJLqDI]A/3<ZN'7+-uAn`<?<+3,moW`YEaoK$
7G`d60Je*l&-7N*)ApA_O>Yl.%mW=lPeF+MEjembUX?m1-=Sk^KB]A>o>OoCnecFsg-Xq>A,E
%3m?dRm`'R$F]AM5XRCk7]AhYP6LBJdU-bbZH4"$/^<6'K#+[2g0Z7+14UZpJBZR5LD*OB-YqX
>5_lKmsX:T-=a^2mHYFXef0s?5t39Rl7C(jdPScEeaUn_`@kHkoGMP=`f>Sg8"<ssrn4i`5n
==\ECeo.N>E86A5aH,0N['0S^j80p99U90fgjImf[.!FZ":%GC3"8Mqt-qMeg*0)236ej>0m
BLPV-kct?:&VY5+un4DL$Y2Vg;Q]AC<eQ9ho+2E7Dn<dW'e0Q#u8Vmu#gr$pU_k/D'pF!dUaC
]APOoD=eVl7%khB0UWb5SsUU5h7WT7?H+4bLMgW";8bUmCH4<!W]Add8csHT)Uq!k7,fcB9hU5
PV`#!f)5LRhcHW-6<UjJk[&,99DGQY9;Zb0l-bgQ&TTt(c_%iEl58ZL,k@EJ&=j3N*gBe#d9
^l>\N0o:M(Jkn6CRTW#^i%''lOTPJj,;\)_H!Ka$*@]At.Aj%OTHT3T+qkRV\0ji;_6n<ZH_5
KM(g&IMLb+,:?<6JApbg4:\L1qu4Mj!1./eR/;br.bY.jM?R?BQA@WO:8p]AQY9PZO_&MCj%\
F#Wf5-4-urQI"uG'UU1ue/NkOradNiJR@o6&\%9of?)c9:XJ:HKep<&O^Re"Ib_65,BNN]A+Z
Jt4gbl)4j%uuCR$U+-T%1*SfOE*X%d:cC>c*S'gWA\$1^E##.dR\&in]ASni0icVUCf*!HTnh
ge6qITg(%q?R1s*rtRh6^D0*#dR3!98T/t%Xhi__TnQAj#^:0q%4s4VYR4X$[?Ue`<fKX.e@
4N=C&$L<I]AWKR2Dk!p\U#>6"f+re':)sMue;MOae9kl=ar;8.!_C]A<I;etoXFKR($TZfT("Y
<^a+'9%"BfD5"[p:EeN&/%DR]AS0r<2&gWUKV/E>uT]Atk.%#t#$bLCEb[Q:)7.9Q=E>1J2Xr_
:DWs_7.^<q0acT1'.^DorU`.)"R7EAt9T]AdnOU9n]A:T`2L^qqjg:e#-]AV[o]A;>&)\+ABkNWA
'^n-G'r@kBYu(1JDPbqp7P0Z4m;]A!?rqiWF`ltHnL8Qq$]A$b3!TAIH;QLq=%bCh34S,[!QLV
cgCBg`]AkL8-5>\Xt3T$L!6Eh5bjH@3;^O&Ppjb]AEAb.Wsic]Ap$:$6Y5j!4W7A(1mp.!lUMAp
cbrkZ]ABCHp:Q9h="?f.<a@E]A5f3J6(88Y(lobE:gRWR=s/"*OIT;WiRNE=,gf>@ZIbI@r:9B
ppP_opcKgrFIHrkhO9-CF//Np`XQ\%s_!fm)WAM6^`)l=RdOFKKl(_(RIF)Lp%n>c:o[Isaj
nAp.n+^@Dr>D\?6kq5M^o,(n=!G14='M8?`lM4V1#8^@dM]AXX-n%f@`Ld"bC`BrQ@+A9fIto
%qc@:2bq\)XFjB4B<>U1>]A#AQnKe\q:WXK>"!V4Z&Ubbh2bh#f4V?j.-5`R[Y%8hc412)ABg
ZW99T,+0@`p9D-9sI=k`=Wmg:Nh5;(#\^lK10gfTgNDrK"W:J,N,d(PZQASO0sD(B5U4hJ]Ak
5q5"g9mcl-PDJB:\8V4T;4Ya0(-B!14$9k&%'@Kk/@gr5kUrIJ!kUdE9:fb6=ktNgc,CL[g[
#$e,smrfYlFX`3CE%AV8*W/A@t.7nK7TAdrj]AFhM#Z%0[UN*<3)5F\K%W3Bb#;Cjc,iWOn^9
7n;JM/6iP)*.Ks`A=#BQ6a*uaKd1h^hi@/'m202uDnS+E>]Aj5J]AFlO!<b=Gg2Cm0R0;1e3DO
ZdGrc=/:)gGmmS97=15/K\h@j>3%oY)n-sU'*@+T'<X5*+'Q*81pVWLd^%%+?h%E1%M]AjceF
t:I_i$Y7n.mm1U.5U:SUsFhNqEX-&=<(AJ6EEKUEt4'X8DnC6k3l<8GlDm/9ncM"S&E]ALu"O
i$4Z?IHjqR3=VaaF1a']Am;Neb"%j&0,n0)r`(G5_B)E+KrH_DPHB]A!ZLB[&0^&7RS0='HX@D
CjQOM%XkL?[?u:IHPk>uG"?(;<*U/T7$.N)>0dLRJOg(H\`N"6[^or!%FQnn+k&?uHZmnImf
c>VI;kmk`*2QSXej\Z[f)%$/.4(LF=*nc[g0WnYTW8s&>M@aZejnl;KjRIRqg]Aa#)<GYIUnO
tmcoPR<,%3RdT0'Pe3<jC?rC:#1$c:GjNOUuLE-Sb@Nh4l]AVG8/t,%Z]AUBi[<]Ag9;RAedka&
+A*`-5>,R*XaQu:YMj)oRH?\Z\?iZF["m[Q'4C@c0rFE=6s*N*b<E#s==I1'Jin(F&oPI(d)
[$.\+KpUuoT3pVs*GFH':#UL"NS.G'9pqQK/VG&%kr2LOF]A7*G^"_6"Kmf&\o%G*nA/j3o]AR
?tML'*hZWe)rJp&='B7$eDleaV]A+ZJK!$53EHcPQ(^~
]]></IM>
</FineImage>
</Background>
<Alpha alpha="1.0"/>
</Border>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[SU,WF<,:7g,3<Vj>EUT*&oFIBMBYO%K2ee>3\f><b$e8:jKQ_)UQgX,K8N9`,UHW]A;GoN/&7
[!*E<]Ao(F'/1KB%6G?T!rA$ht-_tq5h!lqnB61H[W*dFksCdoJTo(AVE,O&-OFdDd'mXJtt.
!:I]A4?IV5:^IK]Al=*O/qcf&?Ds_7&:F/rgMaqg@+c1Se0Fg%3Ac#`@Ui=Pm%:1j,q5Ng,Lb_
rh3sf#RIH.J,c@Hb7)AiT9d3mHNA@%pdkr4N$!GDJl[X[V;P1oZ6^@6ge:2X$5<A[?NT5Iup
q[nTo03p#,*?VHH:4$4tVnfQ]A8p8)eYWX-m?\E7q/^M>:+!WHX\olO0=@bM4Vn.C\_]A/>_-S
C)h'bONG=_8U4aJ+&*-LT,O;H\5)asGfZ9*eWlX=I;"=EJjnpL%ASRM)0ts$(_0GXGE]AR8^@
.5N\VoGW-jqgG+Ie*i"@%9k7R)$P=,2VWjEXN[1gJMni4GP9qlVBh?"lt/Q+^*[j&7H&>#fW
?)`7o4_^Hhk(i;Va&H!b)C^M]As6'e6ZQo"r"o9G#.n[i;"W$;5gB>RNd5<_t+LsTKUAt9#ip
g>Cn-:--rZu\a.;<7+uk/:8f"JULMIP81J)[`2t96n(0W^YBU&=cNAgj??bFd6bFH@-q(`$$
&`c"T+`lbodJ=1FJc9toL+^L1hoGmi68XHV2pbf-8h+K+U)fPKO,>I:B3I*UD;YIE_=c;&/0
-6k_8k5@F(b&qKDeFf=?Q@b"Tbsru6^tNHU<*"89A=m2,9S<4\Qfei2\2/?s@Vl>OG@HHNcd
2E2eOlGhK*1:QFkF%TP):=mEYWX2\W:<FSa<<3_G>,E8]AX-$lIak#M@&R)"e?NjDq3>Fj-G-
cg9N),4".$lmF'NEiR^VO1pdAu]ARQ29#P?od)+IWk,aNUEMhTU"R8E\.V/7"Da`:"sKdLe'R
k,O?2t.LcefsZCq'PF?Q9gh+T;[b59&J3`8k6\&<Ltl-i(f(!CR:jV3uu]ARefe[tC2l,5!dN
/?WD0etkF"oHk$jcT.!]A?5)A?8-IUH/tNEfQ"XF_2%;3,t@e!UjX6&MhJ;tfNK2p5D`21W)3
5d*NK'(u0674b35h;RBX.MNq6?+;n6B)E,%<[%+C!eeLDg[:MsbVgNt#TPfFcFhOha:A`GS:
r)O5%T1j.b++k,:jEfb9/E-Nd1BW1.(;BBt28'p%/!5RLliDZ'kM:4(tE'G%2_>S54Rr.rR)
.a;24T6l(d'MWhTN3=lm3lQ[F"*di,6'6542)JsBWVY8P%IMF_a<**I^YD8H2OJ,[9CA<]A^f
V0?6j8KVL\8`?e!B*DW=(Y@.6/em;PG)4+@'gSjV8I)q7!IW6Xd+$@r;(5<F,+p->.Zm"l,T
^Em/KCu5!j<.UF?18N%s#9$7-R_bW_N=mYaSN)$]A;ZJCS8[d)34C)lPA.oV0krI&cqN7Vhpj
c`TjMVF%<<OETod-ZNC6d=sF9d4YZ%+Nmt6\kn4s2X2RY;?hhP$rjUl<@t>TR\V9VIfJZ]A0s
4mI@T4H,K>$I+l&4r^Qr\!9T,^[eA8$ma)q1_9Orr:!<D8:JJO1#.aRgkb<A7UjR'_T3ll:2
(o#8-[c`eif.5C:NRU6OcWQY@u(HW's6*6jW"Q2"o[(GDnTSBVeE%d+NY&$)3CsRf8rOKu_c
XmUngCMiej0?a2A<Y_Lf(!MfD^,tQhAD>Zq`&#;?YJs(Lq\t^<">:64DHs,GIaqX^^"<Io:)
(JYt2gH+SY4+$d]AYp7T5rCeaE8cMt)lD?]AQ^&KIsj3I=Ks4R<^&d<[ZluK>01(L&&985PKcu
ei;b<0X@-l@[-CX%eCaG"/Vl6r::Q1pTl!`Z`*K&AXUb)<H+;B32?X8O=2s\!#%O9>S&fep0
`c?J02E9]AN)W*&a]AaV47!hNYSB)IP*DT_(o@OJGBYq'GglVN]AkV]AF%SPD)`*/S_r!==/Ed56
q*!RGAI`qEMM5,fi-5N#iDtIVLaK"TX"c8H0r=`>P+bXPpd#(!Rie2T`7q<DDpk1M?:2q,Od
5okTUGc[:Y]A:LJZ)N/^aH0kilJ3_b$7F7n,B`t[`eR(VUokkcU4LseP/6dZg86Ami72*C#RS
fQi(XI4H)J9!1Bm^Q>1/c]A48Zl5_%8#@4`\d@`j<-.s892YRO\?J"oIkoH=U84hq'^B1X_Q"
-=;'/Xc<HB^AR15V?mcoa3epXq6_M-7tGH.TqYYUL(ae(!T-N<Os@;eCu-8!4gai$k0<.i#l
?mFV'Y,ASDU_S7R7i:2,$X&OQW]AjEVS0`V[p+I3ORR$LIgk:oS\PPU1:]A?)FC2-P+(lC*_d?
Re@]Au8*g>o^XXt&VDpu[9Vdn%aaBEFP_?5W!(=-aSNs?_nQPYb8ppYCnMsmqg%n^L\O"9]Ah%
TQirEqP/,"J&?(o@jI)FTVBVUf%[8i'%+.JXU81!cP/D%epJC<dcA;c$$W(=6RQ5kjrI=Jf'
6c_@#%@SMYQTpj>Xcp2EPLHi<<&qB9:$BN2`$&Y=g/XuqcEhg^s[G6JMmm6ABBU,3R5E)DdW
s*7H-#V&3Hd2<cu/hCr%ACk==g,U)mU/DZE]ACm-\U=U&J!mb?uol5DIC&pWmHOSCVQX=Tj&f
'QggFGI.ZiK(aDNSeK:c?<$]AO"5^kqtN&6:M%Q\2SGCBtM+meV(6Fg-&>1>4%/JE0DLP6uu9
>3QNrDq*C7_BC,a.81&^Im;C=mDdJCmD5M\D4*E96^Z?d862!?Go$1Ul"SSkS"#n$'@F,`[$
f%KT"Nt$j"gZ8QHMeM/F#9;S=37bkj`tOGh?PEfkL)\[W%NX3E:l$1N\]A6K6Pp]A<MOVAaTc3
q#Xk89?Efe'f)Eh"/:3@g7->p43)NSRpBT`I)m\5HI#BL9D"f$.N#G9Mnc=="g#Z(YKX#!8,
L`'c6c"ONR\2C6qNtogg#RU3K5C*=O(>VrlZt?a#6n*CUT50)$E)1"a>6]A@\$=rr,`(P@=*`
s'b?Af1Z<X.f6+c0A&2fs6I0jD#Ajp.oloEnH6K7[>@Oakqr6<9=""dODkqLWNPZc4@@";#M
u(**.EGpt[.")50OW3:p4H0sI?PK@Y@huiPEc^j_MgdDmYk>q_V#kl#@]Ad;<5/?mdB,gF<Nk
UoV^@s0)PJ3hj5,7F-908oV)1I4rMcXb[J$%*[0."(j]A@><]A!7Tg.)]A<7t&-:u;)cID92:EC
daH'Pdf5?^hEiZ!/Ej>5YnKf*Gh_*h=\+JPa*S[2EX3k$cmFV*0p`[J#E^hlo'%1?@$J;V7[
q[%Qu%"_qn(]ArZ0*-Y+j0WH/ApRXhk$uHH1#$bXV?MNdH\Y(m5pl*h]AQC']AF\,$+YZ+8>>AY
KT!Hq,s7rb.#&3dV7`pRkKlpE#$YIU?$$cNG1;\5.l\QS!N86I<XFPm`7]A\L*XgARJk?3c=-
^K6-]A/jghKF1GJ^WORAhY,$t]A2\Yr:AV"W$N]AZNfA8ZLE!J`%B9'^?)"UX_XEON(B(5tMU^F
?!.4*:\Yi?dtii_BH+:`%o0(hu2`;EeMthJstEaKmYkVg=o1A/(2B=[9%W*8e$2^64u2a4.J
jHlUuHH(.$<1SVeqO=bRNMl1!-POD1G';NR_YN/g`^NdGUIAoqJV(VF7\Tq\n*T2@YK"<hJf
0"g_\3+0'6lUHHu7t[ED'o8U"cnd"cgl:]A^<rWKd55pF`Jt%bBJIAe4Ha*WKclUQnVG)O`a'
BZ3WDt4$%!0IsFn<1OY\/o\`Bp*f;:2_TI#GK,`nL49pCuh1f)[e@QSiAuZlEs5Mh2PA+9d#
\&P08&/LGN6<rFM`>_.ogB%UDL<<)gfGC5sPS.#SR".]AKfch8o&,Z:J3l1rf&!,MPS#J[^3B
G01#hUZ)O2G\bIEb(m5+uu#^J1P9+&H$:7F?*Jd;i4/b=#q)A;9/FFh@`i,mERXai\9`hVkk
OmZ#X\0>je@:B#[ce1_Z<eqgI#aOkUMl@R*$S%-h.8bs]A'I#2j\Xs0^MA$Cb]AUpmf]A[_N'=c
,eff3S4OZr_J%jXShb0#UmZKpnb=!N-Z,rP-Zl5%?E2?d\d:<4l&n.29;)Se`?XhfM55cFe%
+N0iX8EWU3J_c-B?ZcTDJTJ_@En,g$>U.+9r<+.0nDb!FWOXJA)ZcTQ)G6`41C`&LN*2']A5f
U(-"]AY^l6C'56?!S"uM.lT4@gupD4+WF*!q:,tlRPN\)U;l.8.DVV"K5Is1CP.BuZg/n#g&0
rq8A=J!^:C1./Zme^S12L'rZI6>_De-k7a^aA%oU"/r^Zk3t/@)H@AY44abc$#$*qXE5DPq7
Tl>FQn:eq__jV_,N]AkQ)*sQeV03`ofFAKX<*O-X53a_KOr;W]AL-2$+(%dT*1H,.Y/5;kO3ki
5ECVE;XiI^n>9r]ACik/o^,QR<Vl5-LcAttiR`q*jXs94J64'P6ru%g(R99:fnU76)WE>6W$/
oPOM\t?\K!b'876]A_=qK2_uF5jBupVrt56(SoKh0Y'5lIl9+_-j@ZKXM[ED5Nl_OSf@0Ml.n
?rP<pqK>T+*-\O>^k)6oYqHaZYAC!lrCr>-iqQk:M`8s=hm"NBm*SXG7d*'sUV%TkZ<t$4A'
MW1W#)DRFM4a?//k&bk9C%(0T_(8c4P#`n,kYePH#?$$]AjJ:&)_6@NRclF>R[0uQG?d8/MPX
sFdZH6q=*22">J+#!>sk;#H*!7ij;L6*Og7>6e^N97?['Cl^Lo,A[S^7W;BqpPTAk5:rI;g7
ia<IV9HUU1A3#)^8fqg]AMo_G=@4[cr+\0ZcY&?CTK!nosQhWEr@L)2gCsN;j$N/n:q]Ac?fSK
I7W;6u0t,]A3AF/^:os`ICk-#_0:?Y&IY*NQKLsX#\3$4$?"X$+,QeE]A=Fk_8XsoeJ0@8<Ph/
p-"OVT&lQ]AL(j`4$J@Eg4h=(ReSZ58l]AZl,OB#4q=ij1t>!(+Y5Fne2kK]AbM<?:bu4(WE(bC
00.!%f^1H)HFbJMg^tpo/H45ZpZS"l86I:,-Kf<;6>TsW(s8*p6^Cg75ZhIRI1moJnY(1/<6
``ET\_$Ef4FBcO#o%Q;#hI,.KsA9gEId,WjXsa@&.23JaAJ,F(=m,>T+o0`#">h;C!XE]AK)S
]Air%aACaeld:%2E#7gD@mJ5("V%eTg,u-nflII;jUNGYQP3!YrmrRu'74i>2(`+.gIAll'CR
WV:`@2A;!;pNE0R\m3W>^W<0qaJm]Ai8[N0P+NS_a(NN^F=t',q_ra>a5OZ?4qoYQ=qn"2UgF
jrhb9p,8FP8=jFnYUaQu+T'r2W8fc0O7&p;fM<bQK'm5u1DEsYlJQ'_MY>Zs8C\S#=?>';@j
NYR<-)%pH+2Y0Th;44Dn1Vl]Ahj(Y/YQaRN(eRu!KO6Y1MhR:SR./:)g3c(&e()!nM23[(l+C
r(gDgBAK,.p.`[#s?Kf<1;-kNRFHcIuR/Ihn4!V&)aGcZNF)17H3T">pI,T$(P=VYm!EL#Va
2cnJ(Qn[--O)/XmUmMrYbe^6O##X;:*pAa*]A4GIjiP"+t9lGVFQo+u14sOL1AA9Sn*8>Do78
`PqR[5"e1MZ]A,^UDohAX6e?%qt+4lMc:<#'XaO/Ma2jhFqA&^n.Ss!CXq$U)*'TQ%PY`M-pP
cEs_Y$*P0OIf6iac8LmpY,K]AI$$7u(l=>sS6>U"o<hmNump//Qp?]A/0KJbZj;r?qu$DZHgcM
p*IX1G<`=52QkWmkK_BfP-7q_@Aqi^Rgolb,,ti3A(q@<;maLQC6+fL!sCUOVN1/A7gkFmud
j=jZs?F&F1Y,-pR-Ha@(2DqU,=[l)KA_)lmHY,$VcoODO400;7XT,Y;ckkbhDs#FJ4=d/+X5
R,?gAM>OWgU?pe,+`8(drrqDtqe9H<(f+)cGEPFU\YL+k_BXGtphZnBAmellr[-\$r_0M+lp
f5"D2(I>s0pQ^r3\uh2gJ9>ZjBG[G"C0u+-ZJ?^oXAc.)?-Q97Du0G!9?rYe#&iOZNN47efO
WW$>YLe!o%U&kDG#P]A(dDMq,CdpkTTIFRetHS<D.S8]A4YCE]A*Vb3$U?1-S*L<'eg;`oE/n/:
?H$(8!0R?:O/-@j)cHFk-WD5-\?.rJ0LMtkI=19ha:U2qt\$_RXkhR&iakc\02H:/YPkVS]Aj
Kf"W_s44#e,!&<q%7J`RN5g@bIp4iQgXSeG1n8BO`:Jr=tbZkl)]Ap/5H^d#`;44gX8GIkFD)
hces,!D3=hDuJB#D(o!#]A0GDf:F]Ad4LKq'0[E795g4+B;9B6XN`Skg+rGBj@Tu0p9.;\DGk/
OI7@'WmNft^"qCLR3=blC>P_=_QjT_%:NADmm3(J1KBqM%2:$q7ggP!%@p)5D.$Y?d<o:X9U
fIIAeFLUFL16J"khrljn1@18MViTST&;$!%k/J/Ji2o?sk*:f4:rL`ulWDO;-`LCl92Oh$&H
XM1rSkm)5\;V79R_gD4=nikb\9!3\7)O-n.4QH:^"PeDQ1PqTq/RV):;!FV\p4+ho^GoY92m
*_RA>Qr>"n^.^g.F[A3EPkB]AUqV80m=l'RWt^dXruSb\4eX1J'ke+G#B&fnsRjmarp@O<rcZ
^%Z#pWp^SRpZ;bqagJ"#HNd1k[iNNEf]Ac_,lg?/udPo0PC(8:\_qeF^,^6EfIb*\A(Xbn@&P
6Wf3t'5MB##rraj]A?G%9Tlr6l"k>R`F<Kb>\-Q^%Rl10]Ar&M_FS<Pj!9`VkHRO1Z0p-0KXU:
O"]A4N$c:N"L8W^I\Y4,:?UT&2`o>u['FNgaEVZ:=caS6?r&=i;,g;O&ATbs+57orHn!T,;0P
gC>C98B"?;8ZG;&@BEf['esL3!>f`8_`_`Vn)qlLN#".rkdP(bg5/[ZC*jXI@hl+RgVjQktT
lIGaB=so8c,4d[nDZB"o4S<*XKs8S]A8;:^;6[]A=!!_W&Z#s/m&Z&8<%bDpQ&>@\(9_D7=ian
ps>q-=nmJA3JY+k9KZW1`P3n,[GCiG=hE;:((![%F4Z)=D(:^^WEP.Tdm;]A6PjJgQUqAn0>Z
d9/Y<E,jinbt7dMk4/N!=3Nb7Xok52[#?.g*e`fQG=IL;)Hh-(#%/Hj1ApO*-Vadc1"r.i7^
?bK.8B`Bn[kYU)BgmO=_E4c$DGP">4BTc?On7>"*"m4Z\;FN(BE*PnIkK,+j0L`;l/VECV/Z
9CK;$iRJHW$9aE4+ur\$7i`kedr!>&UR`HR%26k[J,b>Yb5e`HC0:'/2_eg'5#D104X'S+i5
&JJe(<K?KpnrQd9&BR2O'i+VfdM28L9C<Q(S-`igfkhE=t+9%tgp[h6B;m&eGUs!#,ALip#U
CPn./"1?L*_WmpU[jN)35AdY\(@:A]A9l;&Yrrjq;'Y@N4:n8J\G^A%[k@W!+:0j%m,2@LI2d
gm8W(<`<`.7-o=8;tQfG`Jb\D/j(J(m?C,<"Y,WiI>F<Zf&kU7#U<>2<c`78`"BMh8e]A%W1Y
OGssu\SZblG:-A*m]A2PGWi1,q$%H-8!;-En'%-/F`h677_?nA+NcG3n'H"3,"?n7*B?:>r`6
4>t^7o`r='(NR8.a:EU*b2KU/[Z#]A!e_^0ea)b_XV>O1RPj:7Gjn`E+mIYca^$t,RLB\a[T-
[m2"G>F6C/*YJ.joCR"6r=/:'`//HTik1jF#"_oR$eeR-/[IIL\0RajB-_[lIaM6>sf</!e#
@H<>dRrON'QrnSH2TF3cI!f0"P\c21'@CP2Oe!M7<#>;4AlWp)i&OY]A)+d2[i%YG*F2o5)16
?iH(8:NVo/7V/7mO9"]A-O>u7_3I_/.JL9@q>=+,1g>LdhEOu5cY;`%HQm0#[aVC3TrX&]A./!
TSk1Erdgg//$q/c%#2W5UcN@8!n.4*3AO$VjkJLqDI]A/3<ZN'7+-uAn`<?<+3,moW`YEaoK$
7G`d60Je*l&-7N*)ApA_O>Yl.%mW=lPeF+MEjembUX?m1-=Sk^KB]A>o>OoCnecFsg-Xq>A,E
%3m?dRm`'R$F]AM5XRCk7]AhYP6LBJdU-bbZH4"$/^<6'K#+[2g0Z7+14UZpJBZR5LD*OB-YqX
>5_lKmsX:T-=a^2mHYFXef0s?5t39Rl7C(jdPScEeaUn_`@kHkoGMP=`f>Sg8"<ssrn4i`5n
==\ECeo.N>E86A5aH,0N['0S^j80p99U90fgjImf[.!FZ":%GC3"8Mqt-qMeg*0)236ej>0m
BLPV-kct?:&VY5+un4DL$Y2Vg;Q]AC<eQ9ho+2E7Dn<dW'e0Q#u8Vmu#gr$pU_k/D'pF!dUaC
]APOoD=eVl7%khB0UWb5SsUU5h7WT7?H+4bLMgW";8bUmCH4<!W]Add8csHT)Uq!k7,fcB9hU5
PV`#!f)5LRhcHW-6<UjJk[&,99DGQY9;Zb0l-bgQ&TTt(c_%iEl58ZL,k@EJ&=j3N*gBe#d9
^l>\N0o:M(Jkn6CRTW#^i%''lOTPJj,;\)_H!Ka$*@]At.Aj%OTHT3T+qkRV\0ji;_6n<ZH_5
KM(g&IMLb+,:?<6JApbg4:\L1qu4Mj!1./eR/;br.bY.jM?R?BQA@WO:8p]AQY9PZO_&MCj%\
F#Wf5-4-urQI"uG'UU1ue/NkOradNiJR@o6&\%9of?)c9:XJ:HKep<&O^Re"Ib_65,BNN]A+Z
Jt4gbl)4j%uuCR$U+-T%1*SfOE*X%d:cC>c*S'gWA\$1^E##.dR\&in]ASni0icVUCf*!HTnh
ge6qITg(%q?R1s*rtRh6^D0*#dR3!98T/t%Xhi__TnQAj#^:0q%4s4VYR4X$[?Ue`<fKX.e@
4N=C&$L<I]AWKR2Dk!p\U#>6"f+re':)sMue;MOae9kl=ar;8.!_C]A<I;etoXFKR($TZfT("Y
<^a+'9%"BfD5"[p:EeN&/%DR]AS0r<2&gWUKV/E>uT]Atk.%#t#$bLCEb[Q:)7.9Q=E>1J2Xr_
:DWs_7.^<q0acT1'.^DorU`.)"R7EAt9T]AdnOU9n]A:T`2L^qqjg:e#-]AV[o]A;>&)\+ABkNWA
'^n-G'r@kBYu(1JDPbqp7P0Z4m;]A!?rqiWF`ltHnL8Qq$]A$b3!TAIH;QLq=%bCh34S,[!QLV
cgCBg`]AkL8-5>\Xt3T$L!6Eh5bjH@3;^O&Ppjb]AEAb.Wsic]Ap$:$6Y5j!4W7A(1mp.!lUMAp
cbrkZ]ABCHp:Q9h="?f.<a@E]A5f3J6(88Y(lobE:gRWR=s/"*OIT;WiRNE=,gf>@ZIbI@r:9B
ppP_opcKgrFIHrkhO9-CF//Np`XQ\%s_!fm)WAM6^`)l=RdOFKKl(_(RIF)Lp%n>c:o[Isaj
nAp.n+^@Dr>D\?6kq5M^o,(n=!G14='M8?`lM4V1#8^@dM]AXX-n%f@`Ld"bC`BrQ@+A9fIto
%qc@:2bq\)XFjB4B<>U1>]A#AQnKe\q:WXK>"!V4Z&Ubbh2bh#f4V?j.-5`R[Y%8hc412)ABg
ZW99T,+0@`p9D-9sI=k`=Wmg:Nh5;(#\^lK10gfTgNDrK"W:J,N,d(PZQASO0sD(B5U4hJ]Ak
5q5"g9mcl-PDJB:\8V4T;4Ya0(-B!14$9k&%'@Kk/@gr5kUrIJ!kUdE9:fb6=ktNgc,CL[g[
#$e,smrfYlFX`3CE%AV8*W/A@t.7nK7TAdrj]AFhM#Z%0[UN*<3)5F\K%W3Bb#;Cjc,iWOn^9
7n;JM/6iP)*.Ks`A=#BQ6a*uaKd1h^hi@/'m202uDnS+E>]Aj5J]AFlO!<b=Gg2Cm0R0;1e3DO
ZdGrc=/:)gGmmS97=15/K\h@j>3%oY)n-sU'*@+T'<X5*+'Q*81pVWLd^%%+?h%E1%M]AjceF
t:I_i$Y7n.mm1U.5U:SUsFhNqEX-&=<(AJ6EEKUEt4'X8DnC6k3l<8GlDm/9ncM"S&E]ALu"O
i$4Z?IHjqR3=VaaF1a']Am;Neb"%j&0,n0)r`(G5_B)E+KrH_DPHB]A!ZLB[&0^&7RS0='HX@D
CjQOM%XkL?[?u:IHPk>uG"?(;<*U/T7$.N)>0dLRJOg(H\`N"6[^or!%FQnn+k&?uHZmnImf
c>VI;kmk`*2QSXej\Z[f)%$/.4(LF=*nc[g0WnYTW8s&>M@aZejnl;KjRIRqg]Aa#)<GYIUnO
tmcoPR<,%3RdT0'Pe3<jC?rC:#1$c:GjNOUuLE-Sb@Nh4l]AVG8/t,%Z]AUBi[<]Ag9;RAedka&
+A*`-5>,R*XaQu:YMj)oRH?\Z\?iZF["m[Q'4C@c0rFE=6s*N*b<E#s==I1'Jin(F&oPI(d)
[$.\+KpUuoT3pVs*GFH':#UL"NS.G'9pqQK/VG&%kr2LOF]A7*G^"_6"Kmf&\o%G*nA/j3o]AR
?tML'*hZWe)rJp&='B7$eDleaV]A+ZJK!$53EHcPQ(^~
]]></IM>
</FineImage>
</Background>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9=p6>M#:X6J)XM/N1UI-4NN1:m^QqMrG;;\"qT38]AJd8QCZCP2Y&,-7?)j%J[$Km^mV<o3(
EFa&r_*@\SNFl%C-3X_V7gX77**s.L(M68h<6E'$)1=TbhpVeoi+Hd5c:O6TWcrK:0nG3p1n
Jp\TEsj4sOochF8SHMmZ$,7(U>V&,d("bMD"&1$?2O0-J&o@UMB9aL=5n%JAk:]ALAqNHsmKi
?.3rfC3_/RB.pDVcteO^t'3GDV*MVTgnaBLb8Xs2Bd380@@2rk2+`%qqplBd.Ger;E7_EYhd
#Ma0R@s`(Q'7.sn5jR`9'$mC07]AK]AhP:BERSDgJJnq4,K54/ib8g*@6Q*A=mL_qq.su6JqB_
ht[$!7qg\78.nhtIhqhE[_Ygs'HtR[KRQC$=S0Z;;LJ9>Dt:_]AosfV#:G@7kD.<9XGBU$_,a
m;[Vdak]AHg?QNdFLFXpd@55&pLS#Z<+"`gq@e:s*H1J:3kTupQY'S*2E01'KqhFPZ]A)HCVT>
OV0$_,:V%#]Agbc6NB6'n2D[H#h1GsZpFcRU.18jKBUuB)`"NsTXjn*:'FA0%P+72lD$@5)N2
oO*DFd+1`U*j/g,k%GlfJ@k1H;\p[/X12m^@[2@iOgILY-*K'^g<lMgoc\t$fZ,gb[#R%<Q.
1Q&)=s4bd_ddm@3a9NC)aR7&Os5#$"HHM6j.3*m)MUIZM3BQHq;1:N",<@6^-@HnsPZLl=AI
P%<47/4:=,MNWdmT'4ZfqK;S,5t@6\d+YeC3P/-*Vd,aq4kX:[:X$br\]A6:<h9DAM[TY<[DK
^)[HK;)`@,+>:$+!!r&DLe*&So/8g=r!$FIn3DQn1u%h@(>UrhB(T15kC6/biq-7iu?@E"86
4NZLc@]Ae'PY&[[#B41OI"1UcP+HPi<tF<p6?itjm=M@\n_NE2T#CW,D4MMYD7.)W1bCiZ2kF
eGVrjt!URV8Jh@o4(S-&s4%adP7]A<bjJ\'2)Z$sBu]AoUb/JK::RTm2@Lam./Wc-@`o8dm'5l
Z@DIGmP>PX]AGmZCGj^FC4+.4/=oh0CGH:"QZ)C)7#M]A=:2%,Y'@%_^&AX<4VT!]A&Fk<l[qT1
>%,-f6.>2'\SuW.<AXEGX"<Km+%g.')YS00gb2VTrb0YkJ+6XcFKY.i:h`^@m8,AC%k]A8:hE
PV^gLu_Yi"MYt&[I,#XBD;>D-*\3;T_LllDeb&gP:h9XTQ%B;EP6N3(RAlB'/V@CT:F\B,KU
OoNAHNJmD*U;mA@JD]AW44Nhj2%.W:l&pW%ST-1)NEIT^)N94iJS#rt%N_<$!X/44#e^d1f1[
-8uHX#WD[EMr'7;;mjN;N#P(*[DRI@?VR@M<`2O4_!`q]Ad*\aTAlJc_IWZQ*J7UFLT'X/ef@
?fYiGIsc:RLhA^9hDC`I^b,;\-bi]A!S4,l+KiQnlRa/XOq_9QF)O<"8##-$<3U7G^Wf]A0%$=
R:\8(!V(og4BX"SV:TL6qf*CI+="Q6I["A$*i)]Aas$jSVQ`9kI*t1OI2G'sM*aE#uCHZP'7H
mT-GFIMR1\38IP37%L01`D5nqt%M0pTu`BkX]Abf_<blrhM_Jcf:dkiCn*hG9j&:PjC=uqB16
bA?_Wm8hCB57ks0$F6n[T4:@T+eO*bWLY+]Ae3WB2/j=9I1kXf$,J"f(k>^)Pe*k([i"U\1S(
:%_YK4*b%@'WouokC7R.Nf?!#uE#iM>ll7cs'idAGIGR(+Pb:]A=IsjLY'm\`9OK2'=a8VC!C
_.V!eaGp:H1mlKtHi>bR-9n^qnslC1'6>c<nF\I\p$):++4Cd$:k!r5S@+Y^aP6i#J&H^K0I
o15Nq2WBbfH^GJ.f@G80jW?6d>koVS*>o5aXT8cF]Ahc_s;V[3\R'Wi;(lCG0M!JFklFS8\F=
)>I&T8Wlg/bE)QPTXANFrb0ZTB;n=0Mu-JK^_I+-FHm\]A80H/3O*pO9*?B.S81r'SMRS4cnc
0gDj*k9PN/FO-3#^<7pK=#S"4Q?a.3jJ17q_NS#iekkD)N)F<k*S,]A;I!Q3D1o+YeT3Z'MqP
si%A-HME&(rrt@\k),R5]Af)eQBK61gT<0aWH#@^(!f(;+\$*pX?>5n<Q=MZ,JiCMD`-<d'_P
Emq301?kILp&ZQh6?q=8;j#`cHO.kREae!>8"LS"b6$3kM%E%NW/>iXlS[_,Z,<Z"SUL-?RV
i+a^GL9@XGN0.Xrg8//o;sVaRQt-I7;<UPSOf/.oTG:#f+O@L;h%#@<WuMNd72nBE6+j<,hT
TrMl^0^u'iL2]A!_m^H6B>r<'H/k=gB,PVoihq1B#uk8g_A")XL#akofHKk_FTHkLtIXgf:b>
<%u&+@$g"U/MWN[b$q[=s#EJ$YKtC8(5O<P%]AG%XI1/q8iU>g*M,@a,aX4OsJNp7[fK@u`<_
`?Q1i\9K2lq%eCoFm1[hrRi7+CgtQZ!L$K@OWGmF0O]AU56S$EPngetJ;gq2idiF*)cd05af6
4<D.q_$C6E&0o4@U1ARj?C\Y8]A.kjdC8<t%G'n[#G8A<5_Pp+pKR@0Wa6On!Dq?$^/L3tKXi
Wg]As>fKMgCR9I4tTY8R>.t@emM04Qm(tH-$%SQ;9Md]AEA1%:7.(g*[K6<f1&K!A(Sl@X7cFJ
5jR(^4Q1_I[H.1tM?[6TQZ%a#L)^*_0Yn]A<+j<k("s6E$nt3\D;!,kk8dgF3Pf9C//h$_o(t
C.9%=?U2[d@=tD$d1E?i0bieJiRhoK9]A18iEb@S&45#*r#!a@ZXlO5G^<###]A%KS@A?G3cH@
)sQf*9lC8X=9'K*6?[C2XqjIli;uf\ir>D:2R%&?"g]A4n`L@0LT%Y[JLj9&ZDh)^?ONC&$um
l\P%;Jg?8Y;dH5DmCiPG7gE+>&"kZjc:lQBCe1Hl4ZKWC7JcH+[T3NU$nfJLYneTJX#\d#93
dg.kqnL(FtoS<j/r(>I_bTR33@A#!bR8T.q^^Sb[,6"l0>RdgRUtupLZ,'Ug2/6P1?46K[KB
)G0ETjdGXftk\QVe53l]AuVSZ&F4'>2hX8!;B`;:k)(kmKi%7Gp2d*IeUiX"\AAOTP3cBftjJ
'oo_Z#Y9B.IatB&U\t=e#mfk`'E!4$.&Eqf&&EtmMrn3(1/85c7nYAHX.kC#Ih12a()Q.u0"
ABrR(/p,@R?(IS28=$g$hlJ':TNfPSA-8?JH=n,A.;_).d69Q$0u8P&M&^$Lamt`7Mn*P_s-
]A>3]A72K2\#<ZbAu;nXE:Ir?jh,^f-Cmn'b=!P`n&-s+;IOBA46%U,%2OG,#o_iHlk9I?_QIR
,K2/-a[hbX_JFj7cr]A!nb@'"rC4Jd(8nhs.6gU6hQIQgm2^d%*Z$:s+k4pJ?eZ<hS"cYuWT6
lH4(SnWT",r<.VDLjTPm?>B1IYb#is#N#-=[ADj6j6AFY<IF5R5`B:l#qATFMBg,&)46%!MD
kAVQ/W4kRJT=b5auX*ImuCMO_Op!;r>Vr'/F(7OO=:t4J.Kkl"E%;sY(oNMhT^eid_Ct^1h2
1BL0MPdmEpfi\k&rP:>#sFM@3lY;NS4A3%.]A\<G1$]Aeda5d]AmZn[cu$S,muI*N`J+CiObGd:
ua2`?_$5FF=?$B)a,eP+!\1:E7=d7tKDS#!%)62<9j.4>DWLV^i=AHi(#W,Bin+&soQI!'1p
Ts:18oXkG-7YiP!Mfd<P@qdknbt=n\#juAFH@'-IAc>d;\2VmrrfOc*,ES<M+PV))LrLT,Zm
<84-0VTOBB?iM,$+r1-ECMl\`3^*WQ94AW&=gJ3p&rI&LGP:"?)VkC\XCr$-!Sp%N.Sh+3)s
50t^OF6f1a'6^%!>Web'VmK3*2p^tNI?tXh?456`*T%;3'NToFh^Kfc%q-;lqVe]A`=L1)o(7
PH[^md"3!$-Us*AQ*Dj^=P4L*Jp+=hXLP1php5iam6"VB+`nm+n"%EE6lA7?jZP:=0JdP(Zn
*$;&reLdOQ>SS]A_/\ds-dAYptq<Y:`N3XI9DaG)/9bQ:5Q6pqA^'J;7^W*:tZcgjD+m^@2Wn
A-Sr''40`c?O$=Q5c#4EG.qs3kh<eco`l;Qf_`&D^HOdQpl-(I*HNZ,45UP&E:701Eo3JBh&
7luWG'dsk,&rQbED,;BEd^;[q!CU?>h\--7N:*p4@9p2!URJ^A]AVl:5H\'ES_W3p1M+oKJB!
X\_mD1GFRQ$Nl!26-\'7eAnW;Fq;"SEa#(JM\@SMC<K$+ORduer@^_Dend:*c2ITf#d3pZ`;
U:K/qVC/dFG%3+lgla3L\G%q:'jH,So^r9m*o43bOuR.ChsE1NT21363X3AX5L/#T8N5%<8H
;n:M#W:'to>k/.;qShcWo^4dW%6(\Jp<:TcL@NL;7V$poeA*Xmr)l.:^e5\d<XXD*Mg=ZGFI
T*BtLB<s<c'dX_^#t*[bG+r.?;H.Hl;jH@n?A*Z'W2g[lLs2q)kn<0p.=XEV1fhr^'V#knMB
U0Dk2r0Ah*p9u5Q$6c?COb&fSk@g1dNfB<hNqbd87+7(<B+&q;^8*[L7hk!-nS#Y9V]ATrDl^
41^#qJE$g?>V`TGkRKLW+"13*2PDX"@gH^qY=X)$m%&.lV01]AGp5W>KI1]A(SH0?C.b#h0sJ(
on!t@G(*ARcMZ`6sUU;<RD<j#hQaR;0:=GHj-DGJITbaRuMRW*KXsfmX=(4P&(@7f96?4ZTa
l&`:?/Lc)hN#(lOlC^h=<1:CsWE#pI/jmbJ23\8Z;;)Jo3VWCh&R=+G\o8o5*"\>jNj-4h5G
'SRU7\Y'Z!bm1N^lbZSI0k&1ijP4;=4V/OAm[-?fs7@[@YbK5Qkom/j6)u%7:d%I[X_J?sEu
;4A1KcROd;h6n6Cbe!dDU<l6)ttp"(fJ#.a$=ZF!+h=at0p&?dlZ<7?LR5(Ir3L**@<BUEss
/;8260/6prYY=D0=rX@$D82AfoPu:14'o4!q-J:gBP\Qa-JoPtZE"f[`)*D$=2BOGFi\2?Fm
ZC]AF3!sXuO4KOFc3`M#mf8Enj>8X@dKb?a74I-ifPPU2B[o?]AQ(Cf9\2H.66He%I\&]AA@RcX
Qg2=V;NQWgnG0[)+8nEZnep-%=2ZU;e5#6~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="250" height="150"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[SU,WF<,:7g,3<Vj>EUT*&oFIBMBYO%K2ee>3\f><b$e8:jKQ_)UQgX,K8N9`,UHW]A;GoN/&7
[!*E<]Ao(F'/1KB%6G?T!rA$ht-_tq5h!lqnB61H[W*dFksCdoJTo(AVE,O&-OFdDd'mXJtt.
!:I]A4?IV5:^IK]Al=*O/qcf&?Ds_7&:F/rgMaqg@+c1Se0Fg%3Ac#`@Ui=Pm%:1j,q5Ng,Lb_
rh3sf#RIH.J,c@Hb7)AiT9d3mHNA@%pdkr4N$!GDJl[X[V;P1oZ6^@6ge:2X$5<A[?NT5Iup
q[nTo03p#,*?VHH:4$4tVnfQ]A8p8)eYWX-m?\E7q/^M>:+!WHX\olO0=@bM4Vn.C\_]A/>_-S
C)h'bONG=_8U4aJ+&*-LT,O;H\5)asGfZ9*eWlX=I;"=EJjnpL%ASRM)0ts$(_0GXGE]AR8^@
.5N\VoGW-jqgG+Ie*i"@%9k7R)$P=,2VWjEXN[1gJMni4GP9qlVBh?"lt/Q+^*[j&7H&>#fW
?)`7o4_^Hhk(i;Va&H!b)C^M]As6'e6ZQo"r"o9G#.n[i;"W$;5gB>RNd5<_t+LsTKUAt9#ip
g>Cn-:--rZu\a.;<7+uk/:8f"JULMIP81J)[`2t96n(0W^YBU&=cNAgj??bFd6bFH@-q(`$$
&`c"T+`lbodJ=1FJc9toL+^L1hoGmi68XHV2pbf-8h+K+U)fPKO,>I:B3I*UD;YIE_=c;&/0
-6k_8k5@F(b&qKDeFf=?Q@b"Tbsru6^tNHU<*"89A=m2,9S<4\Qfei2\2/?s@Vl>OG@HHNcd
2E2eOlGhK*1:QFkF%TP):=mEYWX2\W:<FSa<<3_G>,E8]AX-$lIak#M@&R)"e?NjDq3>Fj-G-
cg9N),4".$lmF'NEiR^VO1pdAu]ARQ29#P?od)+IWk,aNUEMhTU"R8E\.V/7"Da`:"sKdLe'R
k,O?2t.LcefsZCq'PF?Q9gh+T;[b59&J3`8k6\&<Ltl-i(f(!CR:jV3uu]ARefe[tC2l,5!dN
/?WD0etkF"oHk$jcT.!]A?5)A?8-IUH/tNEfQ"XF_2%;3,t@e!UjX6&MhJ;tfNK2p5D`21W)3
5d*NK'(u0674b35h;RBX.MNq6?+;n6B)E,%<[%+C!eeLDg[:MsbVgNt#TPfFcFhOha:A`GS:
r)O5%T1j.b++k,:jEfb9/E-Nd1BW1.(;BBt28'p%/!5RLliDZ'kM:4(tE'G%2_>S54Rr.rR)
.a;24T6l(d'MWhTN3=lm3lQ[F"*di,6'6542)JsBWVY8P%IMF_a<**I^YD8H2OJ,[9CA<]A^f
V0?6j8KVL\8`?e!B*DW=(Y@.6/em;PG)4+@'gSjV8I)q7!IW6Xd+$@r;(5<F,+p->.Zm"l,T
^Em/KCu5!j<.UF?18N%s#9$7-R_bW_N=mYaSN)$]A;ZJCS8[d)34C)lPA.oV0krI&cqN7Vhpj
c`TjMVF%<<OETod-ZNC6d=sF9d4YZ%+Nmt6\kn4s2X2RY;?hhP$rjUl<@t>TR\V9VIfJZ]A0s
4mI@T4H,K>$I+l&4r^Qr\!9T,^[eA8$ma)q1_9Orr:!<D8:JJO1#.aRgkb<A7UjR'_T3ll:2
(o#8-[c`eif.5C:NRU6OcWQY@u(HW's6*6jW"Q2"o[(GDnTSBVeE%d+NY&$)3CsRf8rOKu_c
XmUngCMiej0?a2A<Y_Lf(!MfD^,tQhAD>Zq`&#;?YJs(Lq\t^<">:64DHs,GIaqX^^"<Io:)
(JYt2gH+SY4+$d]AYp7T5rCeaE8cMt)lD?]AQ^&KIsj3I=Ks4R<^&d<[ZluK>01(L&&985PKcu
ei;b<0X@-l@[-CX%eCaG"/Vl6r::Q1pTl!`Z`*K&AXUb)<H+;B32?X8O=2s\!#%O9>S&fep0
`c?J02E9]AN)W*&a]AaV47!hNYSB)IP*DT_(o@OJGBYq'GglVN]AkV]AF%SPD)`*/S_r!==/Ed56
q*!RGAI`qEMM5,fi-5N#iDtIVLaK"TX"c8H0r=`>P+bXPpd#(!Rie2T`7q<DDpk1M?:2q,Od
5okTUGc[:Y]A:LJZ)N/^aH0kilJ3_b$7F7n,B`t[`eR(VUokkcU4LseP/6dZg86Ami72*C#RS
fQi(XI4H)J9!1Bm^Q>1/c]A48Zl5_%8#@4`\d@`j<-.s892YRO\?J"oIkoH=U84hq'^B1X_Q"
-=;'/Xc<HB^AR15V?mcoa3epXq6_M-7tGH.TqYYUL(ae(!T-N<Os@;eCu-8!4gai$k0<.i#l
?mFV'Y,ASDU_S7R7i:2,$X&OQW]AjEVS0`V[p+I3ORR$LIgk:oS\PPU1:]A?)FC2-P+(lC*_d?
Re@]Au8*g>o^XXt&VDpu[9Vdn%aaBEFP_?5W!(=-aSNs?_nQPYb8ppYCnMsmqg%n^L\O"9]Ah%
TQirEqP/,"J&?(o@jI)FTVBVUf%[8i'%+.JXU81!cP/D%epJC<dcA;c$$W(=6RQ5kjrI=Jf'
6c_@#%@SMYQTpj>Xcp2EPLHi<<&qB9:$BN2`$&Y=g/XuqcEhg^s[G6JMmm6ABBU,3R5E)DdW
s*7H-#V&3Hd2<cu/hCr%ACk==g,U)mU/DZE]ACm-\U=U&J!mb?uol5DIC&pWmHOSCVQX=Tj&f
'QggFGI.ZiK(aDNSeK:c?<$]AO"5^kqtN&6:M%Q\2SGCBtM+meV(6Fg-&>1>4%/JE0DLP6uu9
>3QNrDq*C7_BC,a.81&^Im;C=mDdJCmD5M\D4*E96^Z?d862!?Go$1Ul"SSkS"#n$'@F,`[$
f%KT"Nt$j"gZ8QHMeM/F#9;S=37bkj`tOGh?PEfkL)\[W%NX3E:l$1N\]A6K6Pp]A<MOVAaTc3
q#Xk89?Efe'f)Eh"/:3@g7->p43)NSRpBT`I)m\5HI#BL9D"f$.N#G9Mnc=="g#Z(YKX#!8,
L`'c6c"ONR\2C6qNtogg#RU3K5C*=O(>VrlZt?a#6n*CUT50)$E)1"a>6]A@\$=rr,`(P@=*`
s'b?Af1Z<X.f6+c0A&2fs6I0jD#Ajp.oloEnH6K7[>@Oakqr6<9=""dODkqLWNPZc4@@";#M
u(**.EGpt[.")50OW3:p4H0sI?PK@Y@huiPEc^j_MgdDmYk>q_V#kl#@]Ad;<5/?mdB,gF<Nk
UoV^@s0)PJ3hj5,7F-908oV)1I4rMcXb[J$%*[0."(j]A@><]A!7Tg.)]A<7t&-:u;)cID92:EC
daH'Pdf5?^hEiZ!/Ej>5YnKf*Gh_*h=\+JPa*S[2EX3k$cmFV*0p`[J#E^hlo'%1?@$J;V7[
q[%Qu%"_qn(]ArZ0*-Y+j0WH/ApRXhk$uHH1#$bXV?MNdH\Y(m5pl*h]AQC']AF\,$+YZ+8>>AY
KT!Hq,s7rb.#&3dV7`pRkKlpE#$YIU?$$cNG1;\5.l\QS!N86I<XFPm`7]A\L*XgARJk?3c=-
^K6-]A/jghKF1GJ^WORAhY,$t]A2\Yr:AV"W$N]AZNfA8ZLE!J`%B9'^?)"UX_XEON(B(5tMU^F
?!.4*:\Yi?dtii_BH+:`%o0(hu2`;EeMthJstEaKmYkVg=o1A/(2B=[9%W*8e$2^64u2a4.J
jHlUuHH(.$<1SVeqO=bRNMl1!-POD1G';NR_YN/g`^NdGUIAoqJV(VF7\Tq\n*T2@YK"<hJf
0"g_\3+0'6lUHHu7t[ED'o8U"cnd"cgl:]A^<rWKd55pF`Jt%bBJIAe4Ha*WKclUQnVG)O`a'
BZ3WDt4$%!0IsFn<1OY\/o\`Bp*f;:2_TI#GK,`nL49pCuh1f)[e@QSiAuZlEs5Mh2PA+9d#
\&P08&/LGN6<rFM`>_.ogB%UDL<<)gfGC5sPS.#SR".]AKfch8o&,Z:J3l1rf&!,MPS#J[^3B
G01#hUZ)O2G\bIEb(m5+uu#^J1P9+&H$:7F?*Jd;i4/b=#q)A;9/FFh@`i,mERXai\9`hVkk
OmZ#X\0>je@:B#[ce1_Z<eqgI#aOkUMl@R*$S%-h.8bs]A'I#2j\Xs0^MA$Cb]AUpmf]A[_N'=c
,eff3S4OZr_J%jXShb0#UmZKpnb=!N-Z,rP-Zl5%?E2?d\d:<4l&n.29;)Se`?XhfM55cFe%
+N0iX8EWU3J_c-B?ZcTDJTJ_@En,g$>U.+9r<+.0nDb!FWOXJA)ZcTQ)G6`41C`&LN*2']A5f
U(-"]AY^l6C'56?!S"uM.lT4@gupD4+WF*!q:,tlRPN\)U;l.8.DVV"K5Is1CP.BuZg/n#g&0
rq8A=J!^:C1./Zme^S12L'rZI6>_De-k7a^aA%oU"/r^Zk3t/@)H@AY44abc$#$*qXE5DPq7
Tl>FQn:eq__jV_,N]AkQ)*sQeV03`ofFAKX<*O-X53a_KOr;W]AL-2$+(%dT*1H,.Y/5;kO3ki
5ECVE;XiI^n>9r]ACik/o^,QR<Vl5-LcAttiR`q*jXs94J64'P6ru%g(R99:fnU76)WE>6W$/
oPOM\t?\K!b'876]A_=qK2_uF5jBupVrt56(SoKh0Y'5lIl9+_-j@ZKXM[ED5Nl_OSf@0Ml.n
?rP<pqK>T+*-\O>^k)6oYqHaZYAC!lrCr>-iqQk:M`8s=hm"NBm*SXG7d*'sUV%TkZ<t$4A'
MW1W#)DRFM4a?//k&bk9C%(0T_(8c4P#`n,kYePH#?$$]AjJ:&)_6@NRclF>R[0uQG?d8/MPX
sFdZH6q=*22">J+#!>sk;#H*!7ij;L6*Og7>6e^N97?['Cl^Lo,A[S^7W;BqpPTAk5:rI;g7
ia<IV9HUU1A3#)^8fqg]AMo_G=@4[cr+\0ZcY&?CTK!nosQhWEr@L)2gCsN;j$N/n:q]Ac?fSK
I7W;6u0t,]A3AF/^:os`ICk-#_0:?Y&IY*NQKLsX#\3$4$?"X$+,QeE]A=Fk_8XsoeJ0@8<Ph/
p-"OVT&lQ]AL(j`4$J@Eg4h=(ReSZ58l]AZl,OB#4q=ij1t>!(+Y5Fne2kK]AbM<?:bu4(WE(bC
00.!%f^1H)HFbJMg^tpo/H45ZpZS"l86I:,-Kf<;6>TsW(s8*p6^Cg75ZhIRI1moJnY(1/<6
``ET\_$Ef4FBcO#o%Q;#hI,.KsA9gEId,WjXsa@&.23JaAJ,F(=m,>T+o0`#">h;C!XE]AK)S
]Air%aACaeld:%2E#7gD@mJ5("V%eTg,u-nflII;jUNGYQP3!YrmrRu'74i>2(`+.gIAll'CR
WV:`@2A;!;pNE0R\m3W>^W<0qaJm]Ai8[N0P+NS_a(NN^F=t',q_ra>a5OZ?4qoYQ=qn"2UgF
jrhb9p,8FP8=jFnYUaQu+T'r2W8fc0O7&p;fM<bQK'm5u1DEsYlJQ'_MY>Zs8C\S#=?>';@j
NYR<-)%pH+2Y0Th;44Dn1Vl]Ahj(Y/YQaRN(eRu!KO6Y1MhR:SR./:)g3c(&e()!nM23[(l+C
r(gDgBAK,.p.`[#s?Kf<1;-kNRFHcIuR/Ihn4!V&)aGcZNF)17H3T">pI,T$(P=VYm!EL#Va
2cnJ(Qn[--O)/XmUmMrYbe^6O##X;:*pAa*]A4GIjiP"+t9lGVFQo+u14sOL1AA9Sn*8>Do78
`PqR[5"e1MZ]A,^UDohAX6e?%qt+4lMc:<#'XaO/Ma2jhFqA&^n.Ss!CXq$U)*'TQ%PY`M-pP
cEs_Y$*P0OIf6iac8LmpY,K]AI$$7u(l=>sS6>U"o<hmNump//Qp?]A/0KJbZj;r?qu$DZHgcM
p*IX1G<`=52QkWmkK_BfP-7q_@Aqi^Rgolb,,ti3A(q@<;maLQC6+fL!sCUOVN1/A7gkFmud
j=jZs?F&F1Y,-pR-Ha@(2DqU,=[l)KA_)lmHY,$VcoODO400;7XT,Y;ckkbhDs#FJ4=d/+X5
R,?gAM>OWgU?pe,+`8(drrqDtqe9H<(f+)cGEPFU\YL+k_BXGtphZnBAmellr[-\$r_0M+lp
f5"D2(I>s0pQ^r3\uh2gJ9>ZjBG[G"C0u+-ZJ?^oXAc.)?-Q97Du0G!9?rYe#&iOZNN47efO
WW$>YLe!o%U&kDG#P]A(dDMq,CdpkTTIFRetHS<D.S8]A4YCE]A*Vb3$U?1-S*L<'eg;`oE/n/:
?H$(8!0R?:O/-@j)cHFk-WD5-\?.rJ0LMtkI=19ha:U2qt\$_RXkhR&iakc\02H:/YPkVS]Aj
Kf"W_s44#e,!&<q%7J`RN5g@bIp4iQgXSeG1n8BO`:Jr=tbZkl)]Ap/5H^d#`;44gX8GIkFD)
hces,!D3=hDuJB#D(o!#]A0GDf:F]Ad4LKq'0[E795g4+B;9B6XN`Skg+rGBj@Tu0p9.;\DGk/
OI7@'WmNft^"qCLR3=blC>P_=_QjT_%:NADmm3(J1KBqM%2:$q7ggP!%@p)5D.$Y?d<o:X9U
fIIAeFLUFL16J"khrljn1@18MViTST&;$!%k/J/Ji2o?sk*:f4:rL`ulWDO;-`LCl92Oh$&H
XM1rSkm)5\;V79R_gD4=nikb\9!3\7)O-n.4QH:^"PeDQ1PqTq/RV):;!FV\p4+ho^GoY92m
*_RA>Qr>"n^.^g.F[A3EPkB]AUqV80m=l'RWt^dXruSb\4eX1J'ke+G#B&fnsRjmarp@O<rcZ
^%Z#pWp^SRpZ;bqagJ"#HNd1k[iNNEf]Ac_,lg?/udPo0PC(8:\_qeF^,^6EfIb*\A(Xbn@&P
6Wf3t'5MB##rraj]A?G%9Tlr6l"k>R`F<Kb>\-Q^%Rl10]Ar&M_FS<Pj!9`VkHRO1Z0p-0KXU:
O"]A4N$c:N"L8W^I\Y4,:?UT&2`o>u['FNgaEVZ:=caS6?r&=i;,g;O&ATbs+57orHn!T,;0P
gC>C98B"?;8ZG;&@BEf['esL3!>f`8_`_`Vn)qlLN#".rkdP(bg5/[ZC*jXI@hl+RgVjQktT
lIGaB=so8c,4d[nDZB"o4S<*XKs8S]A8;:^;6[]A=!!_W&Z#s/m&Z&8<%bDpQ&>@\(9_D7=ian
ps>q-=nmJA3JY+k9KZW1`P3n,[GCiG=hE;:((![%F4Z)=D(:^^WEP.Tdm;]A6PjJgQUqAn0>Z
d9/Y<E,jinbt7dMk4/N!=3Nb7Xok52[#?.g*e`fQG=IL;)Hh-(#%/Hj1ApO*-Vadc1"r.i7^
?bK.8B`Bn[kYU)BgmO=_E4c$DGP">4BTc?On7>"*"m4Z\;FN(BE*PnIkK,+j0L`;l/VECV/Z
9CK;$iRJHW$9aE4+ur\$7i`kedr!>&UR`HR%26k[J,b>Yb5e`HC0:'/2_eg'5#D104X'S+i5
&JJe(<K?KpnrQd9&BR2O'i+VfdM28L9C<Q(S-`igfkhE=t+9%tgp[h6B;m&eGUs!#,ALip#U
CPn./"1?L*_WmpU[jN)35AdY\(@:A]A9l;&Yrrjq;'Y@N4:n8J\G^A%[k@W!+:0j%m,2@LI2d
gm8W(<`<`.7-o=8;tQfG`Jb\D/j(J(m?C,<"Y,WiI>F<Zf&kU7#U<>2<c`78`"BMh8e]A%W1Y
OGssu\SZblG:-A*m]A2PGWi1,q$%H-8!;-En'%-/F`h677_?nA+NcG3n'H"3,"?n7*B?:>r`6
4>t^7o`r='(NR8.a:EU*b2KU/[Z#]A!e_^0ea)b_XV>O1RPj:7Gjn`E+mIYca^$t,RLB\a[T-
[m2"G>F6C/*YJ.joCR"6r=/:'`//HTik1jF#"_oR$eeR-/[IIL\0RajB-_[lIaM6>sf</!e#
@H<>dRrON'QrnSH2TF3cI!f0"P\c21'@CP2Oe!M7<#>;4AlWp)i&OY]A)+d2[i%YG*F2o5)16
?iH(8:NVo/7V/7mO9"]A-O>u7_3I_/.JL9@q>=+,1g>LdhEOu5cY;`%HQm0#[aVC3TrX&]A./!
TSk1Erdgg//$q/c%#2W5UcN@8!n.4*3AO$VjkJLqDI]A/3<ZN'7+-uAn`<?<+3,moW`YEaoK$
7G`d60Je*l&-7N*)ApA_O>Yl.%mW=lPeF+MEjembUX?m1-=Sk^KB]A>o>OoCnecFsg-Xq>A,E
%3m?dRm`'R$F]AM5XRCk7]AhYP6LBJdU-bbZH4"$/^<6'K#+[2g0Z7+14UZpJBZR5LD*OB-YqX
>5_lKmsX:T-=a^2mHYFXef0s?5t39Rl7C(jdPScEeaUn_`@kHkoGMP=`f>Sg8"<ssrn4i`5n
==\ECeo.N>E86A5aH,0N['0S^j80p99U90fgjImf[.!FZ":%GC3"8Mqt-qMeg*0)236ej>0m
BLPV-kct?:&VY5+un4DL$Y2Vg;Q]AC<eQ9ho+2E7Dn<dW'e0Q#u8Vmu#gr$pU_k/D'pF!dUaC
]APOoD=eVl7%khB0UWb5SsUU5h7WT7?H+4bLMgW";8bUmCH4<!W]Add8csHT)Uq!k7,fcB9hU5
PV`#!f)5LRhcHW-6<UjJk[&,99DGQY9;Zb0l-bgQ&TTt(c_%iEl58ZL,k@EJ&=j3N*gBe#d9
^l>\N0o:M(Jkn6CRTW#^i%''lOTPJj,;\)_H!Ka$*@]At.Aj%OTHT3T+qkRV\0ji;_6n<ZH_5
KM(g&IMLb+,:?<6JApbg4:\L1qu4Mj!1./eR/;br.bY.jM?R?BQA@WO:8p]AQY9PZO_&MCj%\
F#Wf5-4-urQI"uG'UU1ue/NkOradNiJR@o6&\%9of?)c9:XJ:HKep<&O^Re"Ib_65,BNN]A+Z
Jt4gbl)4j%uuCR$U+-T%1*SfOE*X%d:cC>c*S'gWA\$1^E##.dR\&in]ASni0icVUCf*!HTnh
ge6qITg(%q?R1s*rtRh6^D0*#dR3!98T/t%Xhi__TnQAj#^:0q%4s4VYR4X$[?Ue`<fKX.e@
4N=C&$L<I]AWKR2Dk!p\U#>6"f+re':)sMue;MOae9kl=ar;8.!_C]A<I;etoXFKR($TZfT("Y
<^a+'9%"BfD5"[p:EeN&/%DR]AS0r<2&gWUKV/E>uT]Atk.%#t#$bLCEb[Q:)7.9Q=E>1J2Xr_
:DWs_7.^<q0acT1'.^DorU`.)"R7EAt9T]AdnOU9n]A:T`2L^qqjg:e#-]AV[o]A;>&)\+ABkNWA
'^n-G'r@kBYu(1JDPbqp7P0Z4m;]A!?rqiWF`ltHnL8Qq$]A$b3!TAIH;QLq=%bCh34S,[!QLV
cgCBg`]AkL8-5>\Xt3T$L!6Eh5bjH@3;^O&Ppjb]AEAb.Wsic]Ap$:$6Y5j!4W7A(1mp.!lUMAp
cbrkZ]ABCHp:Q9h="?f.<a@E]A5f3J6(88Y(lobE:gRWR=s/"*OIT;WiRNE=,gf>@ZIbI@r:9B
ppP_opcKgrFIHrkhO9-CF//Np`XQ\%s_!fm)WAM6^`)l=RdOFKKl(_(RIF)Lp%n>c:o[Isaj
nAp.n+^@Dr>D\?6kq5M^o,(n=!G14='M8?`lM4V1#8^@dM]AXX-n%f@`Ld"bC`BrQ@+A9fIto
%qc@:2bq\)XFjB4B<>U1>]A#AQnKe\q:WXK>"!V4Z&Ubbh2bh#f4V?j.-5`R[Y%8hc412)ABg
ZW99T,+0@`p9D-9sI=k`=Wmg:Nh5;(#\^lK10gfTgNDrK"W:J,N,d(PZQASO0sD(B5U4hJ]Ak
5q5"g9mcl-PDJB:\8V4T;4Ya0(-B!14$9k&%'@Kk/@gr5kUrIJ!kUdE9:fb6=ktNgc,CL[g[
#$e,smrfYlFX`3CE%AV8*W/A@t.7nK7TAdrj]AFhM#Z%0[UN*<3)5F\K%W3Bb#;Cjc,iWOn^9
7n;JM/6iP)*.Ks`A=#BQ6a*uaKd1h^hi@/'m202uDnS+E>]Aj5J]AFlO!<b=Gg2Cm0R0;1e3DO
ZdGrc=/:)gGmmS97=15/K\h@j>3%oY)n-sU'*@+T'<X5*+'Q*81pVWLd^%%+?h%E1%M]AjceF
t:I_i$Y7n.mm1U.5U:SUsFhNqEX-&=<(AJ6EEKUEt4'X8DnC6k3l<8GlDm/9ncM"S&E]ALu"O
i$4Z?IHjqR3=VaaF1a']Am;Neb"%j&0,n0)r`(G5_B)E+KrH_DPHB]A!ZLB[&0^&7RS0='HX@D
CjQOM%XkL?[?u:IHPk>uG"?(;<*U/T7$.N)>0dLRJOg(H\`N"6[^or!%FQnn+k&?uHZmnImf
c>VI;kmk`*2QSXej\Z[f)%$/.4(LF=*nc[g0WnYTW8s&>M@aZejnl;KjRIRqg]Aa#)<GYIUnO
tmcoPR<,%3RdT0'Pe3<jC?rC:#1$c:GjNOUuLE-Sb@Nh4l]AVG8/t,%Z]AUBi[<]Ag9;RAedka&
+A*`-5>,R*XaQu:YMj)oRH?\Z\?iZF["m[Q'4C@c0rFE=6s*N*b<E#s==I1'Jin(F&oPI(d)
[$.\+KpUuoT3pVs*GFH':#UL"NS.G'9pqQK/VG&%kr2LOF]A7*G^"_6"Kmf&\o%G*nA/j3o]AR
?tML'*hZWe)rJp&='B7$eDleaV]A+ZJK!$53EHcPQ(^~
]]></IM>
</FineImage>
</Background>
<Alpha alpha="1.0"/>
</Border>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[SU,WF<,:7g,3<Vj>EUT*&oFIBMBYO%K2ee>3\f><b$e8:jKQ_)UQgX,K8N9`,UHW]A;GoN/&7
[!*E<]Ao(F'/1KB%6G?T!rA$ht-_tq5h!lqnB61H[W*dFksCdoJTo(AVE,O&-OFdDd'mXJtt.
!:I]A4?IV5:^IK]Al=*O/qcf&?Ds_7&:F/rgMaqg@+c1Se0Fg%3Ac#`@Ui=Pm%:1j,q5Ng,Lb_
rh3sf#RIH.J,c@Hb7)AiT9d3mHNA@%pdkr4N$!GDJl[X[V;P1oZ6^@6ge:2X$5<A[?NT5Iup
q[nTo03p#,*?VHH:4$4tVnfQ]A8p8)eYWX-m?\E7q/^M>:+!WHX\olO0=@bM4Vn.C\_]A/>_-S
C)h'bONG=_8U4aJ+&*-LT,O;H\5)asGfZ9*eWlX=I;"=EJjnpL%ASRM)0ts$(_0GXGE]AR8^@
.5N\VoGW-jqgG+Ie*i"@%9k7R)$P=,2VWjEXN[1gJMni4GP9qlVBh?"lt/Q+^*[j&7H&>#fW
?)`7o4_^Hhk(i;Va&H!b)C^M]As6'e6ZQo"r"o9G#.n[i;"W$;5gB>RNd5<_t+LsTKUAt9#ip
g>Cn-:--rZu\a.;<7+uk/:8f"JULMIP81J)[`2t96n(0W^YBU&=cNAgj??bFd6bFH@-q(`$$
&`c"T+`lbodJ=1FJc9toL+^L1hoGmi68XHV2pbf-8h+K+U)fPKO,>I:B3I*UD;YIE_=c;&/0
-6k_8k5@F(b&qKDeFf=?Q@b"Tbsru6^tNHU<*"89A=m2,9S<4\Qfei2\2/?s@Vl>OG@HHNcd
2E2eOlGhK*1:QFkF%TP):=mEYWX2\W:<FSa<<3_G>,E8]AX-$lIak#M@&R)"e?NjDq3>Fj-G-
cg9N),4".$lmF'NEiR^VO1pdAu]ARQ29#P?od)+IWk,aNUEMhTU"R8E\.V/7"Da`:"sKdLe'R
k,O?2t.LcefsZCq'PF?Q9gh+T;[b59&J3`8k6\&<Ltl-i(f(!CR:jV3uu]ARefe[tC2l,5!dN
/?WD0etkF"oHk$jcT.!]A?5)A?8-IUH/tNEfQ"XF_2%;3,t@e!UjX6&MhJ;tfNK2p5D`21W)3
5d*NK'(u0674b35h;RBX.MNq6?+;n6B)E,%<[%+C!eeLDg[:MsbVgNt#TPfFcFhOha:A`GS:
r)O5%T1j.b++k,:jEfb9/E-Nd1BW1.(;BBt28'p%/!5RLliDZ'kM:4(tE'G%2_>S54Rr.rR)
.a;24T6l(d'MWhTN3=lm3lQ[F"*di,6'6542)JsBWVY8P%IMF_a<**I^YD8H2OJ,[9CA<]A^f
V0?6j8KVL\8`?e!B*DW=(Y@.6/em;PG)4+@'gSjV8I)q7!IW6Xd+$@r;(5<F,+p->.Zm"l,T
^Em/KCu5!j<.UF?18N%s#9$7-R_bW_N=mYaSN)$]A;ZJCS8[d)34C)lPA.oV0krI&cqN7Vhpj
c`TjMVF%<<OETod-ZNC6d=sF9d4YZ%+Nmt6\kn4s2X2RY;?hhP$rjUl<@t>TR\V9VIfJZ]A0s
4mI@T4H,K>$I+l&4r^Qr\!9T,^[eA8$ma)q1_9Orr:!<D8:JJO1#.aRgkb<A7UjR'_T3ll:2
(o#8-[c`eif.5C:NRU6OcWQY@u(HW's6*6jW"Q2"o[(GDnTSBVeE%d+NY&$)3CsRf8rOKu_c
XmUngCMiej0?a2A<Y_Lf(!MfD^,tQhAD>Zq`&#;?YJs(Lq\t^<">:64DHs,GIaqX^^"<Io:)
(JYt2gH+SY4+$d]AYp7T5rCeaE8cMt)lD?]AQ^&KIsj3I=Ks4R<^&d<[ZluK>01(L&&985PKcu
ei;b<0X@-l@[-CX%eCaG"/Vl6r::Q1pTl!`Z`*K&AXUb)<H+;B32?X8O=2s\!#%O9>S&fep0
`c?J02E9]AN)W*&a]AaV47!hNYSB)IP*DT_(o@OJGBYq'GglVN]AkV]AF%SPD)`*/S_r!==/Ed56
q*!RGAI`qEMM5,fi-5N#iDtIVLaK"TX"c8H0r=`>P+bXPpd#(!Rie2T`7q<DDpk1M?:2q,Od
5okTUGc[:Y]A:LJZ)N/^aH0kilJ3_b$7F7n,B`t[`eR(VUokkcU4LseP/6dZg86Ami72*C#RS
fQi(XI4H)J9!1Bm^Q>1/c]A48Zl5_%8#@4`\d@`j<-.s892YRO\?J"oIkoH=U84hq'^B1X_Q"
-=;'/Xc<HB^AR15V?mcoa3epXq6_M-7tGH.TqYYUL(ae(!T-N<Os@;eCu-8!4gai$k0<.i#l
?mFV'Y,ASDU_S7R7i:2,$X&OQW]AjEVS0`V[p+I3ORR$LIgk:oS\PPU1:]A?)FC2-P+(lC*_d?
Re@]Au8*g>o^XXt&VDpu[9Vdn%aaBEFP_?5W!(=-aSNs?_nQPYb8ppYCnMsmqg%n^L\O"9]Ah%
TQirEqP/,"J&?(o@jI)FTVBVUf%[8i'%+.JXU81!cP/D%epJC<dcA;c$$W(=6RQ5kjrI=Jf'
6c_@#%@SMYQTpj>Xcp2EPLHi<<&qB9:$BN2`$&Y=g/XuqcEhg^s[G6JMmm6ABBU,3R5E)DdW
s*7H-#V&3Hd2<cu/hCr%ACk==g,U)mU/DZE]ACm-\U=U&J!mb?uol5DIC&pWmHOSCVQX=Tj&f
'QggFGI.ZiK(aDNSeK:c?<$]AO"5^kqtN&6:M%Q\2SGCBtM+meV(6Fg-&>1>4%/JE0DLP6uu9
>3QNrDq*C7_BC,a.81&^Im;C=mDdJCmD5M\D4*E96^Z?d862!?Go$1Ul"SSkS"#n$'@F,`[$
f%KT"Nt$j"gZ8QHMeM/F#9;S=37bkj`tOGh?PEfkL)\[W%NX3E:l$1N\]A6K6Pp]A<MOVAaTc3
q#Xk89?Efe'f)Eh"/:3@g7->p43)NSRpBT`I)m\5HI#BL9D"f$.N#G9Mnc=="g#Z(YKX#!8,
L`'c6c"ONR\2C6qNtogg#RU3K5C*=O(>VrlZt?a#6n*CUT50)$E)1"a>6]A@\$=rr,`(P@=*`
s'b?Af1Z<X.f6+c0A&2fs6I0jD#Ajp.oloEnH6K7[>@Oakqr6<9=""dODkqLWNPZc4@@";#M
u(**.EGpt[.")50OW3:p4H0sI?PK@Y@huiPEc^j_MgdDmYk>q_V#kl#@]Ad;<5/?mdB,gF<Nk
UoV^@s0)PJ3hj5,7F-908oV)1I4rMcXb[J$%*[0."(j]A@><]A!7Tg.)]A<7t&-:u;)cID92:EC
daH'Pdf5?^hEiZ!/Ej>5YnKf*Gh_*h=\+JPa*S[2EX3k$cmFV*0p`[J#E^hlo'%1?@$J;V7[
q[%Qu%"_qn(]ArZ0*-Y+j0WH/ApRXhk$uHH1#$bXV?MNdH\Y(m5pl*h]AQC']AF\,$+YZ+8>>AY
KT!Hq,s7rb.#&3dV7`pRkKlpE#$YIU?$$cNG1;\5.l\QS!N86I<XFPm`7]A\L*XgARJk?3c=-
^K6-]A/jghKF1GJ^WORAhY,$t]A2\Yr:AV"W$N]AZNfA8ZLE!J`%B9'^?)"UX_XEON(B(5tMU^F
?!.4*:\Yi?dtii_BH+:`%o0(hu2`;EeMthJstEaKmYkVg=o1A/(2B=[9%W*8e$2^64u2a4.J
jHlUuHH(.$<1SVeqO=bRNMl1!-POD1G';NR_YN/g`^NdGUIAoqJV(VF7\Tq\n*T2@YK"<hJf
0"g_\3+0'6lUHHu7t[ED'o8U"cnd"cgl:]A^<rWKd55pF`Jt%bBJIAe4Ha*WKclUQnVG)O`a'
BZ3WDt4$%!0IsFn<1OY\/o\`Bp*f;:2_TI#GK,`nL49pCuh1f)[e@QSiAuZlEs5Mh2PA+9d#
\&P08&/LGN6<rFM`>_.ogB%UDL<<)gfGC5sPS.#SR".]AKfch8o&,Z:J3l1rf&!,MPS#J[^3B
G01#hUZ)O2G\bIEb(m5+uu#^J1P9+&H$:7F?*Jd;i4/b=#q)A;9/FFh@`i,mERXai\9`hVkk
OmZ#X\0>je@:B#[ce1_Z<eqgI#aOkUMl@R*$S%-h.8bs]A'I#2j\Xs0^MA$Cb]AUpmf]A[_N'=c
,eff3S4OZr_J%jXShb0#UmZKpnb=!N-Z,rP-Zl5%?E2?d\d:<4l&n.29;)Se`?XhfM55cFe%
+N0iX8EWU3J_c-B?ZcTDJTJ_@En,g$>U.+9r<+.0nDb!FWOXJA)ZcTQ)G6`41C`&LN*2']A5f
U(-"]AY^l6C'56?!S"uM.lT4@gupD4+WF*!q:,tlRPN\)U;l.8.DVV"K5Is1CP.BuZg/n#g&0
rq8A=J!^:C1./Zme^S12L'rZI6>_De-k7a^aA%oU"/r^Zk3t/@)H@AY44abc$#$*qXE5DPq7
Tl>FQn:eq__jV_,N]AkQ)*sQeV03`ofFAKX<*O-X53a_KOr;W]AL-2$+(%dT*1H,.Y/5;kO3ki
5ECVE;XiI^n>9r]ACik/o^,QR<Vl5-LcAttiR`q*jXs94J64'P6ru%g(R99:fnU76)WE>6W$/
oPOM\t?\K!b'876]A_=qK2_uF5jBupVrt56(SoKh0Y'5lIl9+_-j@ZKXM[ED5Nl_OSf@0Ml.n
?rP<pqK>T+*-\O>^k)6oYqHaZYAC!lrCr>-iqQk:M`8s=hm"NBm*SXG7d*'sUV%TkZ<t$4A'
MW1W#)DRFM4a?//k&bk9C%(0T_(8c4P#`n,kYePH#?$$]AjJ:&)_6@NRclF>R[0uQG?d8/MPX
sFdZH6q=*22">J+#!>sk;#H*!7ij;L6*Og7>6e^N97?['Cl^Lo,A[S^7W;BqpPTAk5:rI;g7
ia<IV9HUU1A3#)^8fqg]AMo_G=@4[cr+\0ZcY&?CTK!nosQhWEr@L)2gCsN;j$N/n:q]Ac?fSK
I7W;6u0t,]A3AF/^:os`ICk-#_0:?Y&IY*NQKLsX#\3$4$?"X$+,QeE]A=Fk_8XsoeJ0@8<Ph/
p-"OVT&lQ]AL(j`4$J@Eg4h=(ReSZ58l]AZl,OB#4q=ij1t>!(+Y5Fne2kK]AbM<?:bu4(WE(bC
00.!%f^1H)HFbJMg^tpo/H45ZpZS"l86I:,-Kf<;6>TsW(s8*p6^Cg75ZhIRI1moJnY(1/<6
``ET\_$Ef4FBcO#o%Q;#hI,.KsA9gEId,WjXsa@&.23JaAJ,F(=m,>T+o0`#">h;C!XE]AK)S
]Air%aACaeld:%2E#7gD@mJ5("V%eTg,u-nflII;jUNGYQP3!YrmrRu'74i>2(`+.gIAll'CR
WV:`@2A;!;pNE0R\m3W>^W<0qaJm]Ai8[N0P+NS_a(NN^F=t',q_ra>a5OZ?4qoYQ=qn"2UgF
jrhb9p,8FP8=jFnYUaQu+T'r2W8fc0O7&p;fM<bQK'm5u1DEsYlJQ'_MY>Zs8C\S#=?>';@j
NYR<-)%pH+2Y0Th;44Dn1Vl]Ahj(Y/YQaRN(eRu!KO6Y1MhR:SR./:)g3c(&e()!nM23[(l+C
r(gDgBAK,.p.`[#s?Kf<1;-kNRFHcIuR/Ihn4!V&)aGcZNF)17H3T">pI,T$(P=VYm!EL#Va
2cnJ(Qn[--O)/XmUmMrYbe^6O##X;:*pAa*]A4GIjiP"+t9lGVFQo+u14sOL1AA9Sn*8>Do78
`PqR[5"e1MZ]A,^UDohAX6e?%qt+4lMc:<#'XaO/Ma2jhFqA&^n.Ss!CXq$U)*'TQ%PY`M-pP
cEs_Y$*P0OIf6iac8LmpY,K]AI$$7u(l=>sS6>U"o<hmNump//Qp?]A/0KJbZj;r?qu$DZHgcM
p*IX1G<`=52QkWmkK_BfP-7q_@Aqi^Rgolb,,ti3A(q@<;maLQC6+fL!sCUOVN1/A7gkFmud
j=jZs?F&F1Y,-pR-Ha@(2DqU,=[l)KA_)lmHY,$VcoODO400;7XT,Y;ckkbhDs#FJ4=d/+X5
R,?gAM>OWgU?pe,+`8(drrqDtqe9H<(f+)cGEPFU\YL+k_BXGtphZnBAmellr[-\$r_0M+lp
f5"D2(I>s0pQ^r3\uh2gJ9>ZjBG[G"C0u+-ZJ?^oXAc.)?-Q97Du0G!9?rYe#&iOZNN47efO
WW$>YLe!o%U&kDG#P]A(dDMq,CdpkTTIFRetHS<D.S8]A4YCE]A*Vb3$U?1-S*L<'eg;`oE/n/:
?H$(8!0R?:O/-@j)cHFk-WD5-\?.rJ0LMtkI=19ha:U2qt\$_RXkhR&iakc\02H:/YPkVS]Aj
Kf"W_s44#e,!&<q%7J`RN5g@bIp4iQgXSeG1n8BO`:Jr=tbZkl)]Ap/5H^d#`;44gX8GIkFD)
hces,!D3=hDuJB#D(o!#]A0GDf:F]Ad4LKq'0[E795g4+B;9B6XN`Skg+rGBj@Tu0p9.;\DGk/
OI7@'WmNft^"qCLR3=blC>P_=_QjT_%:NADmm3(J1KBqM%2:$q7ggP!%@p)5D.$Y?d<o:X9U
fIIAeFLUFL16J"khrljn1@18MViTST&;$!%k/J/Ji2o?sk*:f4:rL`ulWDO;-`LCl92Oh$&H
XM1rSkm)5\;V79R_gD4=nikb\9!3\7)O-n.4QH:^"PeDQ1PqTq/RV):;!FV\p4+ho^GoY92m
*_RA>Qr>"n^.^g.F[A3EPkB]AUqV80m=l'RWt^dXruSb\4eX1J'ke+G#B&fnsRjmarp@O<rcZ
^%Z#pWp^SRpZ;bqagJ"#HNd1k[iNNEf]Ac_,lg?/udPo0PC(8:\_qeF^,^6EfIb*\A(Xbn@&P
6Wf3t'5MB##rraj]A?G%9Tlr6l"k>R`F<Kb>\-Q^%Rl10]Ar&M_FS<Pj!9`VkHRO1Z0p-0KXU:
O"]A4N$c:N"L8W^I\Y4,:?UT&2`o>u['FNgaEVZ:=caS6?r&=i;,g;O&ATbs+57orHn!T,;0P
gC>C98B"?;8ZG;&@BEf['esL3!>f`8_`_`Vn)qlLN#".rkdP(bg5/[ZC*jXI@hl+RgVjQktT
lIGaB=so8c,4d[nDZB"o4S<*XKs8S]A8;:^;6[]A=!!_W&Z#s/m&Z&8<%bDpQ&>@\(9_D7=ian
ps>q-=nmJA3JY+k9KZW1`P3n,[GCiG=hE;:((![%F4Z)=D(:^^WEP.Tdm;]A6PjJgQUqAn0>Z
d9/Y<E,jinbt7dMk4/N!=3Nb7Xok52[#?.g*e`fQG=IL;)Hh-(#%/Hj1ApO*-Vadc1"r.i7^
?bK.8B`Bn[kYU)BgmO=_E4c$DGP">4BTc?On7>"*"m4Z\;FN(BE*PnIkK,+j0L`;l/VECV/Z
9CK;$iRJHW$9aE4+ur\$7i`kedr!>&UR`HR%26k[J,b>Yb5e`HC0:'/2_eg'5#D104X'S+i5
&JJe(<K?KpnrQd9&BR2O'i+VfdM28L9C<Q(S-`igfkhE=t+9%tgp[h6B;m&eGUs!#,ALip#U
CPn./"1?L*_WmpU[jN)35AdY\(@:A]A9l;&Yrrjq;'Y@N4:n8J\G^A%[k@W!+:0j%m,2@LI2d
gm8W(<`<`.7-o=8;tQfG`Jb\D/j(J(m?C,<"Y,WiI>F<Zf&kU7#U<>2<c`78`"BMh8e]A%W1Y
OGssu\SZblG:-A*m]A2PGWi1,q$%H-8!;-En'%-/F`h677_?nA+NcG3n'H"3,"?n7*B?:>r`6
4>t^7o`r='(NR8.a:EU*b2KU/[Z#]A!e_^0ea)b_XV>O1RPj:7Gjn`E+mIYca^$t,RLB\a[T-
[m2"G>F6C/*YJ.joCR"6r=/:'`//HTik1jF#"_oR$eeR-/[IIL\0RajB-_[lIaM6>sf</!e#
@H<>dRrON'QrnSH2TF3cI!f0"P\c21'@CP2Oe!M7<#>;4AlWp)i&OY]A)+d2[i%YG*F2o5)16
?iH(8:NVo/7V/7mO9"]A-O>u7_3I_/.JL9@q>=+,1g>LdhEOu5cY;`%HQm0#[aVC3TrX&]A./!
TSk1Erdgg//$q/c%#2W5UcN@8!n.4*3AO$VjkJLqDI]A/3<ZN'7+-uAn`<?<+3,moW`YEaoK$
7G`d60Je*l&-7N*)ApA_O>Yl.%mW=lPeF+MEjembUX?m1-=Sk^KB]A>o>OoCnecFsg-Xq>A,E
%3m?dRm`'R$F]AM5XRCk7]AhYP6LBJdU-bbZH4"$/^<6'K#+[2g0Z7+14UZpJBZR5LD*OB-YqX
>5_lKmsX:T-=a^2mHYFXef0s?5t39Rl7C(jdPScEeaUn_`@kHkoGMP=`f>Sg8"<ssrn4i`5n
==\ECeo.N>E86A5aH,0N['0S^j80p99U90fgjImf[.!FZ":%GC3"8Mqt-qMeg*0)236ej>0m
BLPV-kct?:&VY5+un4DL$Y2Vg;Q]AC<eQ9ho+2E7Dn<dW'e0Q#u8Vmu#gr$pU_k/D'pF!dUaC
]APOoD=eVl7%khB0UWb5SsUU5h7WT7?H+4bLMgW";8bUmCH4<!W]Add8csHT)Uq!k7,fcB9hU5
PV`#!f)5LRhcHW-6<UjJk[&,99DGQY9;Zb0l-bgQ&TTt(c_%iEl58ZL,k@EJ&=j3N*gBe#d9
^l>\N0o:M(Jkn6CRTW#^i%''lOTPJj,;\)_H!Ka$*@]At.Aj%OTHT3T+qkRV\0ji;_6n<ZH_5
KM(g&IMLb+,:?<6JApbg4:\L1qu4Mj!1./eR/;br.bY.jM?R?BQA@WO:8p]AQY9PZO_&MCj%\
F#Wf5-4-urQI"uG'UU1ue/NkOradNiJR@o6&\%9of?)c9:XJ:HKep<&O^Re"Ib_65,BNN]A+Z
Jt4gbl)4j%uuCR$U+-T%1*SfOE*X%d:cC>c*S'gWA\$1^E##.dR\&in]ASni0icVUCf*!HTnh
ge6qITg(%q?R1s*rtRh6^D0*#dR3!98T/t%Xhi__TnQAj#^:0q%4s4VYR4X$[?Ue`<fKX.e@
4N=C&$L<I]AWKR2Dk!p\U#>6"f+re':)sMue;MOae9kl=ar;8.!_C]A<I;etoXFKR($TZfT("Y
<^a+'9%"BfD5"[p:EeN&/%DR]AS0r<2&gWUKV/E>uT]Atk.%#t#$bLCEb[Q:)7.9Q=E>1J2Xr_
:DWs_7.^<q0acT1'.^DorU`.)"R7EAt9T]AdnOU9n]A:T`2L^qqjg:e#-]AV[o]A;>&)\+ABkNWA
'^n-G'r@kBYu(1JDPbqp7P0Z4m;]A!?rqiWF`ltHnL8Qq$]A$b3!TAIH;QLq=%bCh34S,[!QLV
cgCBg`]AkL8-5>\Xt3T$L!6Eh5bjH@3;^O&Ppjb]AEAb.Wsic]Ap$:$6Y5j!4W7A(1mp.!lUMAp
cbrkZ]ABCHp:Q9h="?f.<a@E]A5f3J6(88Y(lobE:gRWR=s/"*OIT;WiRNE=,gf>@ZIbI@r:9B
ppP_opcKgrFIHrkhO9-CF//Np`XQ\%s_!fm)WAM6^`)l=RdOFKKl(_(RIF)Lp%n>c:o[Isaj
nAp.n+^@Dr>D\?6kq5M^o,(n=!G14='M8?`lM4V1#8^@dM]AXX-n%f@`Ld"bC`BrQ@+A9fIto
%qc@:2bq\)XFjB4B<>U1>]A#AQnKe\q:WXK>"!V4Z&Ubbh2bh#f4V?j.-5`R[Y%8hc412)ABg
ZW99T,+0@`p9D-9sI=k`=Wmg:Nh5;(#\^lK10gfTgNDrK"W:J,N,d(PZQASO0sD(B5U4hJ]Ak
5q5"g9mcl-PDJB:\8V4T;4Ya0(-B!14$9k&%'@Kk/@gr5kUrIJ!kUdE9:fb6=ktNgc,CL[g[
#$e,smrfYlFX`3CE%AV8*W/A@t.7nK7TAdrj]AFhM#Z%0[UN*<3)5F\K%W3Bb#;Cjc,iWOn^9
7n;JM/6iP)*.Ks`A=#BQ6a*uaKd1h^hi@/'m202uDnS+E>]Aj5J]AFlO!<b=Gg2Cm0R0;1e3DO
ZdGrc=/:)gGmmS97=15/K\h@j>3%oY)n-sU'*@+T'<X5*+'Q*81pVWLd^%%+?h%E1%M]AjceF
t:I_i$Y7n.mm1U.5U:SUsFhNqEX-&=<(AJ6EEKUEt4'X8DnC6k3l<8GlDm/9ncM"S&E]ALu"O
i$4Z?IHjqR3=VaaF1a']Am;Neb"%j&0,n0)r`(G5_B)E+KrH_DPHB]A!ZLB[&0^&7RS0='HX@D
CjQOM%XkL?[?u:IHPk>uG"?(;<*U/T7$.N)>0dLRJOg(H\`N"6[^or!%FQnn+k&?uHZmnImf
c>VI;kmk`*2QSXej\Z[f)%$/.4(LF=*nc[g0WnYTW8s&>M@aZejnl;KjRIRqg]Aa#)<GYIUnO
tmcoPR<,%3RdT0'Pe3<jC?rC:#1$c:GjNOUuLE-Sb@Nh4l]AVG8/t,%Z]AUBi[<]Ag9;RAedka&
+A*`-5>,R*XaQu:YMj)oRH?\Z\?iZF["m[Q'4C@c0rFE=6s*N*b<E#s==I1'Jin(F&oPI(d)
[$.\+KpUuoT3pVs*GFH':#UL"NS.G'9pqQK/VG&%kr2LOF]A7*G^"_6"Kmf&\o%G*nA/j3o]AR
?tML'*hZWe)rJp&='B7$eDleaV]A+ZJK!$53EHcPQ(^~
]]></IM>
</FineImage>
</Background>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9=p6>M#:X6J)XM/N1UI-4NN1:m^QqMrG;;\"qT38]AJd8QCZCP2Y&,-7?)j%J[$Km^mV<o3(
EFa&r_*@\SNFl%C-3X_V7gX77**s.L(M68h<6E'$)1=TbhpVeoi+Hd5c:O6TWcrK:0nG3p1n
Jp\TEsj4sOochF8SHMmZ$,7(U>V&,d("bMD"&1$?2O0-J&o@UMB9aL=5n%JAk:]ALAqNHsmKi
?.3rfC3_/RB.pDVcteO^t'3GDV*MVTgnaBLb8Xs2Bd380@@2rk2+`%qqplBd.Ger;E7_EYhd
#Ma0R@s`(Q'7.sn5jR`9'$mC07]AK]AhP:BERSDgJJnq4,K54/ib8g*@6Q*A=mL_qq.su6JqB_
ht[$!7qg\78.nhtIhqhE[_Ygs'HtR[KRQC$=S0Z;;LJ9>Dt:_]AosfV#:G@7kD.<9XGBU$_,a
m;[Vdak]AHg?QNdFLFXpd@55&pLS#Z<+"`gq@e:s*H1J:3kTupQY'S*2E01'KqhFPZ]A)HCVT>
OV0$_,:V%#]Agbc6NB6'n2D[H#h1GsZpFcRU.18jKBUuB)`"NsTXjn*:'FA0%P+72lD$@5)N2
oO*DFd+1`U*j/g,k%GlfJ@k1H;\p[/X12m^@[2@iOgILY-*K'^g<lMgoc\t$fZ,gb[#R%<Q.
1Q&)=s4bd_ddm@3a9NC)aR7&Os5#$"HHM6j.3*m)MUIZM3BQHq;1:N",<@6^-@HnsPZLl=AI
P%<47/4:=,MNWdmT'4ZfqK;S,5t@6\d+YeC3P/-*Vd,aq4kX:[:X$br\]A6:<h9DAM[TY<[DK
^)[HK;)`@,+>:$+!!r&DLe*&So/8g=r!$FIn3DQn1u%h@(>UrhB(T15kC6/biq-7iu?@E"86
4NZLc@]Ae'PY&[[#B41OI"1UcP+HPi<tF<p6?itjm=M@\n_NE2T#CW,D4MMYD7.)W1bCiZ2kF
eGVrjt!URV8Jh@o4(S-&s4%adP7]A<bjJ\'2)Z$sBu]AoUb/JK::RTm2@Lam./Wc-@`o8dm'5l
Z@DIGmP>PX]AGmZCGj^FC4+.4/=oh0CGH:"QZ)C)7#M]A=:2%,Y'@%_^&AX<4VT!]A&Fk<l[qT1
>%,-f6.>2'\SuW.<AXEGX"<Km+%g.')YS00gb2VTrb0YkJ+6XcFKY.i:h`^@m8,AC%k]A8:hE
PV^gLu_Yi"MYt&[I,#XBD;>D-*\3;T_LllDeb&gP:h9XTQ%B;EP6N3(RAlB'/V@CT:F\B,KU
OoNAHNJmD*U;mA@JD]AW44Nhj2%.W:l&pW%ST-1)NEIT^)N94iJS#rt%N_<$!X/44#e^d1f1[
-8uHX#WD[EMr'7;;mjN;N#P(*[DRI@?VR@M<`2O4_!`q]Ad*\aTAlJc_IWZQ*J7UFLT'X/ef@
?fYiGIsc:RLhA^9hDC`I^b,;\-bi]A!S4,l+KiQnlRa/XOq_9QF)O<"8##-$<3U7G^Wf]A0%$=
R:\8(!V(og4BX"SV:TL6qf*CI+="Q6I["A$*i)]Aas$jSVQ`9kI*t1OI2G'sM*aE#uCHZP'7H
mT-GFIMR1\38IP37%L01`D5nqt%M0pTu`BkX]Abf_<blrhM_Jcf:dkiCn*hG9j&:PjC=uqB16
bA?_Wm8hCB57ks0$F6n[T4:@T+eO*bWLY+]Ae3WB2/j=9I1kXf$,J"f(k>^)Pe*k([i"U\1S(
:%_YK4*b%@'WouokC7R.Nf?!#uE#iM>ll7cs'idAGIGR(+Pb:]A=IsjLY'm\`9OK2'=a8VC!C
_.V!eaGp:H1mlKtHi>bR-9n^qnslC1'6>c<nF\I\p$):++4Cd$:k!r5S@+Y^aP6i#J&H^K0I
o15Nq2WBbfH^GJ.f@G80jW?6d>koVS*>o5aXT8cF]Ahc_s;V[3\R'Wi;(lCG0M!JFklFS8\F=
)>I&T8Wlg/bE)QPTXANFrb0ZTB;n=0Mu-JK^_I+-FHm\]A80H/3O*pO9*?B.S81r'SMRS4cnc
0gDj*k9PN/FO-3#^<7pK=#S"4Q?a.3jJ17q_NS#iekkD)N)F<k*S,]A;I!Q3D1o+YeT3Z'MqP
si%A-HME&(rrt@\k),R5]Af)eQBK61gT<0aWH#@^(!f(;+\$*pX?>5n<Q=MZ,JiCMD`-<d'_P
Emq301?kILp&ZQh6?q=8;j#`cHO.kREae!>8"LS"b6$3kM%E%NW/>iXlS[_,Z,<Z"SUL-?RV
i+a^GL9@XGN0.Xrg8//o;sVaRQt-I7;<UPSOf/.oTG:#f+O@L;h%#@<WuMNd72nBE6+j<,hT
TrMl^0^u'iL2]A!_m^H6B>r<'H/k=gB,PVoihq1B#uk8g_A")XL#akofHKk_FTHkLtIXgf:b>
<%u&+@$g"U/MWN[b$q[=s#EJ$YKtC8(5O<P%]AG%XI1/q8iU>g*M,@a,aX4OsJNp7[fK@u`<_
`?Q1i\9K2lq%eCoFm1[hrRi7+CgtQZ!L$K@OWGmF0O]AU56S$EPngetJ;gq2idiF*)cd05af6
4<D.q_$C6E&0o4@U1ARj?C\Y8]A.kjdC8<t%G'n[#G8A<5_Pp+pKR@0Wa6On!Dq?$^/L3tKXi
Wg]As>fKMgCR9I4tTY8R>.t@emM04Qm(tH-$%SQ;9Md]AEA1%:7.(g*[K6<f1&K!A(Sl@X7cFJ
5jR(^4Q1_I[H.1tM?[6TQZ%a#L)^*_0Yn]A<+j<k("s6E$nt3\D;!,kk8dgF3Pf9C//h$_o(t
C.9%=?U2[d@=tD$d1E?i0bieJiRhoK9]A18iEb@S&45#*r#!a@ZXlO5G^<###]A%KS@A?G3cH@
)sQf*9lC8X=9'K*6?[C2XqjIli;uf\ir>D:2R%&?"g]A4n`L@0LT%Y[JLj9&ZDh)^?ONC&$um
l\P%;Jg?8Y;dH5DmCiPG7gE+>&"kZjc:lQBCe1Hl4ZKWC7JcH+[T3NU$nfJLYneTJX#\d#93
dg.kqnL(FtoS<j/r(>I_bTR33@A#!bR8T.q^^Sb[,6"l0>RdgRUtupLZ,'Ug2/6P1?46K[KB
)G0ETjdGXftk\QVe53l]AuVSZ&F4'>2hX8!;B`;:k)(kmKi%7Gp2d*IeUiX"\AAOTP3cBftjJ
'oo_Z#Y9B.IatB&U\t=e#mfk`'E!4$.&Eqf&&EtmMrn3(1/85c7nYAHX.kC#Ih12a()Q.u0"
ABrR(/p,@R?(IS28=$g$hlJ':TNfPSA-8?JH=n,A.;_).d69Q$0u8P&M&^$Lamt`7Mn*P_s-
]A>3]A72K2\#<ZbAu;nXE:Ir?jh,^f-Cmn'b=!P`n&-s+;IOBA46%U,%2OG,#o_iHlk9I?_QIR
,K2/-a[hbX_JFj7cr]A!nb@'"rC4Jd(8nhs.6gU6hQIQgm2^d%*Z$:s+k4pJ?eZ<hS"cYuWT6
lH4(SnWT",r<.VDLjTPm?>B1IYb#is#N#-=[ADj6j6AFY<IF5R5`B:l#qATFMBg,&)46%!MD
kAVQ/W4kRJT=b5auX*ImuCMO_Op!;r>Vr'/F(7OO=:t4J.Kkl"E%;sY(oNMhT^eid_Ct^1h2
1BL0MPdmEpfi\k&rP:>#sFM@3lY;NS4A3%.]A\<G1$]Aeda5d]AmZn[cu$S,muI*N`J+CiObGd:
ua2`?_$5FF=?$B)a,eP+!\1:E7=d7tKDS#!%)62<9j.4>DWLV^i=AHi(#W,Bin+&soQI!'1p
Ts:18oXkG-7YiP!Mfd<P@qdknbt=n\#juAFH@'-IAc>d;\2VmrrfOc*,ES<M+PV))LrLT,Zm
<84-0VTOBB?iM,$+r1-ECMl\`3^*WQ94AW&=gJ3p&rI&LGP:"?)VkC\XCr$-!Sp%N.Sh+3)s
50t^OF6f1a'6^%!>Web'VmK3*2p^tNI?tXh?456`*T%;3'NToFh^Kfc%q-;lqVe]A`=L1)o(7
PH[^md"3!$-Us*AQ*Dj^=P4L*Jp+=hXLP1php5iam6"VB+`nm+n"%EE6lA7?jZP:=0JdP(Zn
*$;&reLdOQ>SS]A_/\ds-dAYptq<Y:`N3XI9DaG)/9bQ:5Q6pqA^'J;7^W*:tZcgjD+m^@2Wn
A-Sr''40`c?O$=Q5c#4EG.qs3kh<eco`l;Qf_`&D^HOdQpl-(I*HNZ,45UP&E:701Eo3JBh&
7luWG'dsk,&rQbED,;BEd^;[q!CU?>h\--7N:*p4@9p2!URJ^A]AVl:5H\'ES_W3p1M+oKJB!
X\_mD1GFRQ$Nl!26-\'7eAnW;Fq;"SEa#(JM\@SMC<K$+ORduer@^_Dend:*c2ITf#d3pZ`;
U:K/qVC/dFG%3+lgla3L\G%q:'jH,So^r9m*o43bOuR.ChsE1NT21363X3AX5L/#T8N5%<8H
;n:M#W:'to>k/.;qShcWo^4dW%6(\Jp<:TcL@NL;7V$poeA*Xmr)l.:^e5\d<XXD*Mg=ZGFI
T*BtLB<s<c'dX_^#t*[bG+r.?;H.Hl;jH@n?A*Z'W2g[lLs2q)kn<0p.=XEV1fhr^'V#knMB
U0Dk2r0Ah*p9u5Q$6c?COb&fSk@g1dNfB<hNqbd87+7(<B+&q;^8*[L7hk!-nS#Y9V]ATrDl^
41^#qJE$g?>V`TGkRKLW+"13*2PDX"@gH^qY=X)$m%&.lV01]AGp5W>KI1]A(SH0?C.b#h0sJ(
on!t@G(*ARcMZ`6sUU;<RD<j#hQaR;0:=GHj-DGJITbaRuMRW*KXsfmX=(4P&(@7f96?4ZTa
l&`:?/Lc)hN#(lOlC^h=<1:CsWE#pI/jmbJ23\8Z;;)Jo3VWCh&R=+G\o8o5*"\>jNj-4h5G
'SRU7\Y'Z!bm1N^lbZSI0k&1ijP4;=4V/OAm[-?fs7@[@YbK5Qkom/j6)u%7:d%I[X_J?sEu
;4A1KcROd;h6n6Cbe!dDU<l6)ttp"(fJ#.a$=ZF!+h=at0p&?dlZ<7?LR5(Ir3L**@<BUEss
/;8260/6prYY=D0=rX@$D82AfoPu:14'o4!q-J:gBP\Qa-JoPtZE"f[`)*D$=2BOGFi\2?Fm
ZC]AF3!sXuO4KOFc3`M#mf8Enj>8X@dKb?a74I-ifPPU2B[o?]AQ(Cf9\2H.66He%I\&]AA@RcX
Qg2=V;NQWgnG0[)+8nEZnep-%=2ZU;e5#6~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="8" y="7" width="419" height="326"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report2_c"/>
<Widget widgetName="chart1_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="360" y="328" width="430" height="310"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="absolute0_c_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="chart2_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="chart2" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ChartEditor">
<WidgetName name="chart2_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.98"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[新建图表标题]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.column.VanChartColumnPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="0" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="3"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
</Attr>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="宋体" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="宋体" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="function(){ return this.category+this.seriesName+this.value;}" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="true" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="false" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="100.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false" predefinedStyle="false"/>
<FRFont name="宋体" style="0" size="72"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<PredefinedStyle predefinedStyle="false"/>
<ColorList>
<OColor colvalue="-16711681"/>
<OColor colvalue="-11184811"/>
<OColor colvalue="-4363512"/>
<OColor colvalue="-16750485"/>
<OColor colvalue="-3658447"/>
<OColor colvalue="-10331231"/>
<OColor colvalue="-7763575"/>
<OColor colvalue="-6514688"/>
<OColor colvalue="-16744620"/>
<OColor colvalue="-6187579"/>
<OColor colvalue="-15714713"/>
<OColor colvalue="-945550"/>
<OColor colvalue="-4092928"/>
<OColor colvalue="-13224394"/>
<OColor colvalue="-12423245"/>
<OColor colvalue="-10043521"/>
<OColor colvalue="-406154"/>
<OColor colvalue="-13031292"/>
<OColor colvalue="-16732559"/>
<OColor colvalue="-7099690"/>
<OColor colvalue="-11991199"/>
<OColor colvalue="-331445"/>
<OColor colvalue="-6991099"/>
<OColor colvalue="-16686527"/>
<OColor colvalue="-9205567"/>
<OColor colvalue="-7397856"/>
<OColor colvalue="-406154"/>
<OColor colvalue="-2712831"/>
<OColor colvalue="-4737097"/>
<OColor colvalue="-11460720"/>
<OColor colvalue="-6696775"/>
<OColor colvalue="-3685632"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<GradientStyle>
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridPredefinedStyle="false" lineColor="-2039584" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr rotation="-63" alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-2039584"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="true" gridLineType="solid"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridPredefinedStyle="false" lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-2039584"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="true" gridLineType="solid"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="0.0" categoryIntervalPercent="100.0" fixedWidth="true" columnWidth="10" filledWithImage="false" isBar="false"/>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[日销表]]></Name>
</TableData>
<CategoryName value="地级市"/>
<ChartSummaryColumn name="月营业" function="com.fr.data.util.function.NoneFunction" customName="月营业"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="77606efd-f262-497d-91a1-87fc4b1de2df"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
<ThemeAttr>
<Attr darkTheme="false" predefinedStyle="false"/>
</ThemeAttr>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="250" height="150"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ChartEditor">
<WidgetName name="chart2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[新建图表标题]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.column.VanChartColumnPlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="0" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="true" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
</Attr>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="false" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="100.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false" predefinedStyle="false"/>
<FRFont name="宋体" style="0" size="72"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName="新特性"/>
<isCustomFillStyle isCustomFillStyle="false"/>
<PredefinedStyle predefinedStyle="false"/>
<ColorList>
<OColor colvalue="-10243346"/>
<OColor colvalue="-8988015"/>
<OColor colvalue="-472193"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
<OColor colvalue="-10243346"/>
<OColor colvalue="-8988015"/>
<OColor colvalue="-472193"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
<OColor colvalue="-10243346"/>
<OColor colvalue="-8988015"/>
<OColor colvalue="-472193"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
<OColor colvalue="-10243346"/>
<OColor colvalue="-8988015"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<GradientStyle>
<Attr gradientType="gradual" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor mainGridPredefinedStyle="false" lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr rotation="-63" alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="true" gridLineType="solid"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</XAxisList>
<YAxisList>
<VanChartAxis class="com.fr.plugin.chart.attr.axis.VanChartValueAxis">
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor mainGridColor="-3881788" mainGridPredefinedStyle="false" lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="true" gridLineType="solid"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
<VanChartValueAxisAttr isLog="false" valueStyle="false" baseLog="=10"/>
<ds>
<RadarYAxisTableDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<attr/>
</RadarYAxisTableDefinition>
</ds>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="20.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="false"/>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[File3]]></Name>
</TableData>
<CategoryName value="地级市"/>
<ChartSummaryColumn name="营业额" function="com.fr.data.util.function.NoneFunction" customName="营业额"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="8636fcc4-d9fa-498d-a7c7-bdf55918b4d4"/>
<tools hidden="true" sort="true" export="true" fullScreen="true"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
<ThemeAttr>
<Attr darkTheme="false" predefinedStyle="false"/>
</ThemeAttr>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="17" y="58" width="324" height="247"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report0_c_c_c_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report0_c_c_c" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0_c_c_c_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[KmJ#,<:ATARDgm?1:E-iaPLAqM%n2W+_?lafge,t-m?eC6APuB@bO8:Ou5#G8n\PTCS[&RA4
1[f9RWMi\(C6I4jRJIk1o^=]AW_)&^9;lQ/7m.&@6kbs!!%[(bY@g5!"oG8LenKcJ!)GM'`n@
b_%rnYgU#MHp)QeI[S(8(4F"jBi/UbIi<Q.pcVD7BCKQ!]A5Y6b_&VElJS05d)0M"KN@tkh''
TIu?BeVu_DL"If*DNj`X(ttAX2?V87.`.Ydk9S-3G0=,qqNn#luW#;CXqYa`NUn7eNUYO_(4
.9VoIdNHoBW'Vto"Bcm.Kc2q@6cG:ZLW!5!Z*8kp3e$n#@8X=rcl\F([,i$5_BNe1=QqR%aO
Y5^kmeeC8PI*/0q;3W??b6rnIX=Z+:Ktc@_>@PbdGnSc*Hf<A=N,OI-r%8k_rGYP,L`!eM':
P2nDH`1HdlU&<#HJZ^gG%b^qZs\mpKoq!r<*tS1R\+r(`YE%>"T+HO0_dT&pF9*Vhd:;LjM#
6g$XDBA6\_%(Hej\H,t!L0?C89c)3XUL4W*M]A:.XqYlR(LKi#$&1EX]A@F'HL2!-dGY1e)8K>
*sZjB8e[E'(m.EH5'q@%-n!p<Y]AmBIkIbo"J7n>%EVeLpF)JKfnVdr8!;uWMn;/.A(7X9pjR
K"?ou+<6g9m%=\9_o+XI-"5c*K#-"m=iH>Im$p^g)Mcd%CI`/W=g1LWQ[\sBquIY_B_(+!DK
Znr#8@%uIUG(a*P1FRq_6WK$i.>M2<$DC3J168686@8+sorc:,=nh;j_'5%/90<HYH>#2!rA
$:a0#H($r+J:J6HrH^,ia4sp'uE,?)AO;p\p!WEgCCOdUl9UW9ni%k#tDtT`m!d!SNJV#VU7
\RNk`.r<18[Q3<Yg::,]A>:7o;9pqjIO41a"-[Qo>R2JI*^ah\,@PU/I4l_bmu6[-Kl30%L"p
XYtlZS#,]AiJSbb#MMUm?"h>9EN"9uo6Ffl#XoW83#Ve=Xm&'8Q+k(="Q=qrCVkBI`cONY6Dl
3)46@6fd9HBXXW#>3<@"EVXH=:(^ZcYqA<B]A\')&OCWDoH,7q7Dbh#N+Ge^HG_#&qM@7PN/&
]AG[Z'H5*c;a7jG,"BY&U,.f_[dBnf(mM>lMk]A)eE'L6:,a<$<`ot,X<fTM1:5m]A:<91'^GHT
p>Inl'#o#gMh2NRaTQM2u,qP"I<o4dua#,$GBeF1]AqC&GUGE*6H/@UPS8$J_5`$r-AIqRZ_=
RK5a/O57U$oWgQqmANAE1kTNl*#YdWVQ7o<EUm"q?9n?NDGrV>Fk#X&l+)9)>f4CPOEL)/j/
081d<]A3OX4Rac8CV\f=06`<tZdu0*+tp',c1.3U28g_8Vr3!-!V0:aYb>6A"*!3c_PGg-m:[
V/0thuLO/pP4^qrBH/g#bh6EZ,H@*Up0KKaSJ`=boO@1b.BZ!7gdS=J]AB;U9k7/\k6l-FfO0
7md9-Y;D'NcgCniUp_%u]AFN&3!P@!+3<g(O+6\3o0$g:D(4kM>a(\Z(^:6L>$HFrKE\(u2>S
cHJ;s7J%Q%aoO&d=cX:P)PVcnK[9F#c[pnV,7G<GabIgi,1dK>9^0ADl5"1n9YGmGRCQ['>@
U8'eO0#['V=2g,_eNQL#`M'H^rf0h<nlH4%^6-qj0iqHF9HIc8um/mO1"Q&%/>qEgrQ;U#tP
/IJ@bk2SD)G+WnHS:f*SdPTaQ)NpoiFm$$5\5f;<GdfOdm]APLmHXVRCJlr0ZWNQU@kXL,n[Z
6es+a%G:EQ<U7LW9pYjniY-$3Fh5N>mpqS&?$Coe6\ftNA<.C(4h4ERZN7PdZ:CDh'$L'e'?
D$DYrp>+aeESWf*/="5c0-Z,r@>GMs.<jmW=uDA:HAhJ8@7k:cnX2L^\/m=Ns/oc.`3l6Vq+
598<,Fd6e"bpOQi-I$SV>WaL7b2KJak!MCmr$;.!Orh,CTM@b@-`c=&[TM**k?iM#nq).n?(
flRG+@G&)Y:""f2u1.qdfT56h$bT`mkn\K`+Rm?R(p1AsL@m.'=N,XY6Ap$i-(s*$tKO@_P,
jT>^SWBJ&%]A-tr^/[7Moipse<p'uQ,(N+FX=?3l9!6fDH\$>LFqe5:^VUsuT=p"SP^n2@r2_
bBaMrk1?H8V'W0Pu*i-Yc<*0pCfFp)OZ4<Zjk,5gaB8IDOA&`,pLB`5CZa`fQu(@#$06`"aQ
FYfjf]A+sgK>3&fc`i)0ck()a()4?*"DPmJNrHfC,H+KU*0BupheQ3RR?"4bTWDo6\O[l;$d4
I(aDXiX,lt7Pr0b?_7oP:?"C<\f=_LeTj[Hk/UI'C5pNH@n2GVWi>3Cn9I`7+\+[juO#N`=9
AF`7f6k6XV\U*GL[jPaJY8O`hh6h"//8I>R@]A[j6hnpmQO!3^C4b&WX23fkqPkfY,TrsChDV
i=^0&q"78A!,:EbQThbE*!>4.rj-+n6?)0VZ`#A8e)a_Qr9^Xf%cL#q2XJZA)UFsKhuX([El
o.8/c("^fP+W*6%V'jtK4@)E."",+('cqA"Zt1V+OVoHN:M1VGIY)%!P;'c[IT0T#T01.;@+
.d)CFH^c:>*$2#K]A3'nScegu,F%3ZI+tk'b'Ji<L2?TO+*k,5aTEc)qnf4]AABk-.D;%6C)75
J.ihJ%W&h9%G,i8+JfYX3sR78>)D`N7G%aJ/PnkS,4^CN*GUH=W(G.S2p84H@6'!:G\]AYY1i
13\2(YkeuXMA^*giEfm/p#?0@l_`UI.^t;p9jQS(U0I%g'Tg9Y,*-0BF'e\$E52%HVPGf:P;
jUJ$<9d&8g[bZ:#hCnsOr*r$gmglfe3KIUB"\b5JM=i7+>`UjEV'0/PKa\kH$;RFZ7lVV&=5
YG3NHuno^Kf`I6XioreNqK[7#Zo9%Z@<ASUtb74Z`^pJ-qJnT$7$Mt"c.KV)o_Cjm7"NDfr"
.tZDpdBWc1.&Dl2f^f=niYEGH""tnaiR'#1dTN/\6;g5\[ESaQBSR5[l.LoVa0S_P6Yc\[ki
Rg6H8^luFGkkU!.:<h7ClsWe<UC.)\`"kc4S@pPY\f7.A@d^GcRTg%4]AH.`g!R9:O,n/@LHB
\ClaBQISP4A`ZOs"`;S]AK,7BM6iUQu1G0W&7C3/^'$rue'XI_u:acWFHSZeSp?[DJ`TE+nT>
HQX@e#mfH:"VH2*@\"$@D7`ALqba/$QFNm5kk&D$ioMH4FD-=9S?S3h6>a#3]A!GRC]Atpe03n
U/(BbO:3g+leJ`QOgfPI`ipk11BULrF?gG.;QmZ]AI,F:Y7\^"8m:@k;j7b0FP)[:)p:@so"!
KBfQ(9PL]A`eZ/]AhP^<Gm.A7rD&p`HdC2O+GDY%#F@GPppUl%j3"T"u1\*PX7X$$Lak,P<i9>
`!7?p"AOAR*p)?Hp9^g.E6?323q.c(?%*HZC&f?S[>of!*D_cl`k=dLGYZ=7,uD5,DN19%m7
j6@PCT9\iQ,T+?r3Zh.lDT7R&[_PWW5+IHu#[)S]A6\p$;OE(_ci=BsInK"epF[aXnKkm$bn;
2R?['X_e,56*gS&;\ETT\'Y50N^aJ8]A<[Eg(J)rgr9@\#k?W3Zl>PfF_ZB1!/-ItIZ%45f3O
JXO?2S=e5DlWOWN5\CQ3JuLGonn9!JfRP]AfZ5@-]AJU^cF-V"dAK0Y4=Qida)OFf$K);'"Iak
=6aB<Y]Ah5fHhJ5gQ,<(_j=G-@!F^j@o+P,4e$'V#n$rRn#D4=X9'N#'2R)b-@Yruj#&G+=R;
SCup8E-CgP(VZKO]A!o-=A+HG#!Ga)oYZl10[g4AmK0e-(LkRd3ZU2VbdZB-4=/2@:d=j7b3Q
_<5F25pC+m.f4&Q'&Q9hU\/etSf*a;'46YMb1%]An)X^[Z,6V<Ur1BD0GlMX"QK)f4';ojS[#
&Hl\aF-?h,O=Yh`^l@W8rp;q$X4UI<6B,!8\,T0Cdg/g$/d,3C^,TU;nJfb@r4jA[rI(p'4[
:h5#!LV2isblqH[i`]AqI9053;B$KEArT0LjMuO-AoQkkaY$CVB`1*fHaT-7,Q/Bl9<@j]AuO"
02R5?'\T`Yqap7Tb`Fg^C^s/Qc.F]Ak(6&BYHp">QEV(X6I_XWPi0dj\:qMd%Um!&n**KRVMu
[>P,g]A"UI,0X8iIm$K>\#(fE9ShV+;n)C8Y,Q4F3fPt<hkHsQs]AQ7hCEtE+=U3\,FhKHDqqu
1H?*1RG=:&V4,t@eMXb!j5laL?VaS;Zb/:,?WVFjp7,)Zk,QKO178^uPWPTr1IXng"PU%a=)
Lj^$+!4e[4n4_/E#`e)Id]A-@ZGV#2A6gWkZmS.9T`XLVQAW9p!3dQ&?(aFRr02E%r9='k:k4
*aPLmG7=F.E`(`!;%%NeRR_%b3]AjZn/U%FEbK5'rb&#m,Vc"X<%P6=DGapaA^E8]A*'^Y5r,E
!3,W]A(c6$%"YQb6:s8T%:(:Y5]A_.4/8h!V?%DJVA;2O33W@b;;lE47+B&'T^iV'H*..<9`R5
@q@\\Gq&V/oZ$I!c$13u(f%aG*ebqTTB&dB/>3V$BmscDuerlHW7p"YeY&Ye:muDVTW\X1*!
T<BT+9Ie#X-94U7g#L=f>TAf*lfPrcYXrZGZkFc(+#Nm!?IjlQ[%MV1rO/J&Xh.Sl\^Kj/@<
8MN19ack$+_!HH[@)8%C]AKZ@',P_9!$D=CM'hb_2Q9_Mi!<+\E>Oe-4BV[e['Akb)'+O*9@$
;j%gU^Zi"KUN1h_s.D)(]A'HrRf"BkTh^1\e5]Aos3W+*B0q1b3la:)Ve3-0:28#DR<0rnRUeF
0ht$hbda#c?,FQ3g&<l1eWX7.p^E"4i5l(?*^E&>4Y8?(5Ise5+`A*#+969H#gGt%]ApCM41k
f9qS@O^mU>a%''CPUl[=_"P1uN8/$>e3L!\[l#>h\BLPqBp"`[Jh0p))T+<QfEHfbY=/7Z$F
=La02I57ArU*cF%KSX$:Cq%aFsm-<NP#@DT:/[)e]Ag%!rj,X3YFD/K<#J\RoA.m3NMpo5UOL
$u="auI8nLqKot_G.f&H*0-1bu*J>0(6k)GuC'EQ\g>"hSZ+r@C&,M!G^b_LgWdSn(mcl[rQ
'!6a8!X2h0f9)NT06hioZ.s3]A>Kd(/tASaR#ja,3c_/r+ojN5sA7)u7&;A&.bi05e[_m&TmX
6M!C(^X:C0c!EJWD$8n$-"5&`LBFEA20tDoBeeC&En"P0",e;*rgSk^1K.Y#UU"(]AW\#T@iK
^JTl%sMJU,09E=;DXWEd!\p/6XGS,8QGP&RT`PEfXDB6j%5o>HT:PbD6%CI3FE97^gEKicIp
YlejWEjgutp%[,RoA3JPPEXaWQ\1p=^1f/\"Xq#[tD>9T41`SHh/Ik:DZD&%N@'A-=ZH<eYk
,pZrRJGEtgpikK>1Z<_Bb^e5<>"$r]AQcD&<:6B>cJm/AMVKN1(^0aaahOEOR29*,4Co'1,I>
,1n3fKq'"B&Y*>Esd"[?CkU-7=FNeqT$hAGTXO6b3q`F-cu`:Q=$<Y[TaUOmu`OX"m64k1GT
rN_e5F,:dDKKEs(@Ej3Lo_[Ud5C$?uA`&]A^!=k%,dpj+C3I3`qV76[hBE9@LY^(>#/.D@7qD
6L0JBX6#_c1M5X8hasi=R\Z(]A5K!iiac5_`eTYqI.S/Z.$;IZsO3QFUI-<Kd]Ag7Tu?\)/U$F
7IOu\"6?,0$<Rq.E]A5Y9q-C=".kpclrUg;!Ef##quad-c[cHh'6LDi60))j%\BP_'V^T',"n
02$]A:1lM8ETEPFZl**[LJt]A-r)^$_+ma]AWSLP-2q:TsU]Am2GP9d?_2TPG<=eonkUq"1h(g#V
Yh+]A6QO7!e#./fJ$8Ir4UKTI]AP;m>.V%B/uGK>q<PF\]AJ=+F3mRXi&-j(Km*WumT2-]A_O;EN
GtVdU+^9;""7/bW*RIf)aSW:8Op.0_lRW=7=\JS:BUt6:2=SL"@Xh4-H1'jZh!&YJViLY^$d
'^oUBo.DcWNG:#KP'f$F)r*ebMrU"^c0VJm'FF&Tf>IiH$H7$b,l>34^Co17iB(AAInZG6j)
,&#h%QW8!(0)e`ISqmq%f<W/DY_k-9Y+j&r*UQ\u>lnN.<K(AR6%-Ad0Io;$DRWF*O6jr,6O
m&fr$X=,/8H.R@%8MC:Z<62<`7"0dgsN;+X]AIQs\UYBo^;T8k[0.P>lPJ.U=)Wp7d1$fiTAY
X%i,%nTs"r)m-Zbo\^G`Q6f;Er+02Ok<"LXWdo#:U9:nWq.4mW`ooC,^,O4#Ls(t2,\bP.J&
Vmu,9:uK+CVE(J/R9M*.7rkQ:<;iPP]A%1?jG8u6JK3GAVf`kfEUL/:`k(S<<*Lb=o^;>.Ud:
^`l'b9?YcHm`doW%:`Wk>jsf^N*)2Hf<q(Fq^"E*kh/qX);m,$-A87s(flA5KI/5p(5oM`GV
\LXRj]A+s)N0htDPEaSQD@2nBf^URq%F@0_Ee(q:Ct=I(@C(/).3I+@S[Q`C`0p)71;DWkA/e
8*N83_pm38pI/0l@C'r0B+Y.;FIb`VZlu!gZhT*X$'$N8uFV7\:q2;\_j4ac?U@(SOp"gftk
p==.k,`*OfBLKO3[3\6$Zsn-jL_`^1#tJiDT2P<If-,.rNQH+N1ubl=SWr@snE%^*CZ1E-J7
J!ubuNtbjeqCS2!<-S&,,+m'7Ms<Dq/Mo_3O7RHiHBf/Q:lk'Vif_aI9;8.batIe1ao,G/@7
sA6$Tt1I`'SX/]ArU#)khi#"Y1c3CqOU^3rRF%+g^VSHJ[:W\3[(=/1%^d"MHCoIpKs`6B<td
'b9`aRX[GJgfCA]Ae3tD7^Nc3ZKE6Wt^:S+0%C,Jg2V6bk'1/WNNU(/6W3)4$;>u0st2Cd@t4
*#M\MI'2F`>c)g4H90SW:!(Me;NH_l[MY6dc!4NIqb9+T'dG5'i+ZY!`Scn%AHhrLusQ+s+k
rl@aIV^GhbOjon4:S`h.6NC"*a4a2Q#7d]AV9H*]Apk^+.3"2qc*F$RR$uNHEWcCGPi\*;ltV`
;r^Xr<Jm`QU0JU/s0mNSKtZN24?78_k+>[LS,3calLi+lbq'Y#o7u1\k%DecaP^.T4ON[Pl2
?+-9goPgF'mbq!e&C-Z1Mos?Je\hIui%Iqu>0@>m0Z4l>qmB4]A2J3\.0M;7^k,mY.:P>?>Qh
FIEk(!fa'MEpLm,Z"LIoAo0gnh&ci*cTMm\Dp)eG4q7d3Zb=:&81"8tn`#4144.W,2h>a!H5
G.FX?H&a\208*^=3Y/.^IO$s2-eT`PlD^KlKI,[G5b7L>b=PHor/do,#+UP7:,/?bMAQNT[n
==#'_j%9ET(;ghXE^ogH31?$c6`!Q;,A.nVMN">V1WTJHO;C1%]AFBU%f=r:16!U$<qc*^0oE
([2t0nSl(.#O,L*3%Cba56[B3HZO2[M)pIP*ESkOS2fc60G/]AcIF4qK#I=1`=S:A\]A$@-tdM
WRB53"hD4H]A1cLu8@u=gqF\_o@dt>\e,\f-5&Opt?P[bZ\9GFXqNQ1OmQc::j%0]AL;o@=I&F
LXO0_sraAr3:Uj2)lIF;3LP"@bb"",Cr2Rkej.u5k$ka['*^d4YOJ354_'PK*C]A(B#OpZFXY
Y>h4M71Pq7^oal6h0CNnu0Z,'U_M/_J.&*,&d:5AEP-?l<3L!G@BjD]AZd(TkGiUr[)Lk!q<2
99179Bg6U?lAVMbokdokt'D7Ra37D:e")0*r[M5C+B/><U(I4"0\^eBHH/1c/5K#(DeT`NVH
WZ;PD-uC18Ho#1`#V_^g-6kMK_)1ISP>@CsRrXWqmr&7ljaXIHam=Y?Q3tUH=dU5kYEf3F-H
s@N9K?'XU=59QH?o;^'e>"b-C`*EoRZ!2IkJr)U,mpSPUkVpSgLur;&CuEXU'<M/]AaGR;%/+
;'LIsB*&b:)j'-8TO]Au0,W,;[]A_Ei3SIOXp[-El:L%j%lGUZ+-b0R72VJS\3M(3GD:Ln)bWm
tn4hL>!NW>Ac`.&t(qXG>uB7@Bn8DXDp.D0EG;a(Y!8kV2(pb5oQ@C"kgGq:M;DF5#"_MU/t
VlJ*Io._bi19,+AGUNILf>bB&=M>gDkML?,q<JFE6&8+h;K6#lNQ)n>\3cQ5[6!;oa7+2l6;
k+jK@N*j_cAC3oO?#RZD@77Pn'Pc8Djnu0Yd^s$6_)d.=dm;<rZVAQRiPHr+fU96@!L@ER4>
7C8-[temM/D[nYDSp`m's!u)]AJBHfOSOOXptZjo5EC_`;HSh1DZqse'VELWqe5;'17^#VcdN
h\R/;V.P]ABD5?k(@^=BF3r^(/aPXS='`2)="H=c'gAonoXGB\4SYR;/2FV0=^aQ!c/G&1@Wo
@JcgNI'KAc*!&'q:OXRQB6iI+r<AAUeso6V$osJTl$rq0Rj:<q(hSN-;(^.hM#!D(d]A9Gf%<
n!>r00_;mP@]A^DDX-iInZ"#dqjM9N#ghm!:@1;R&jqI8=?6&ggHOLDui*JPg!A!1baVqOo)q
<*MRmqfVk??!B[TnWU#q/PAWm"r<Cs`+%+3)Z.:8qfTVo[Y:XKVQJC<&;*l:I#mr?^6c(q;9
aO#iXVr#+DIWAVK2BWA\WnUJ77&tc]ApG*+kmXG*%H$&lXs7)/AbIt(/=OgBQ&S&O6tb,HMi/
8PSbSXg\%piHr#(Q<5h=^=MP__>4+XrOW<ahc;**]Ajj]A4+m9SSnY=2t<)__p:qlmM`a!f:+D
]Ae,#)J!?.,f<<:2"clbJW7E2ONbs?k=,3q@oYQr"/9c^Oeafq6sDuGPo*+p:Gg]A;:Va>QA<3
%g+3GkFa6sH>6BP&8VSTGM+Bs=V/[mZSgO-%#H=KWqPnme:pho:l,HK2dX#Q_W0']ALa%IM+"
`QPNPd&cU-Pm+#IB>SOE/T173.=6/EkP1+>H2<k4@h?F&/8V5\l^"ChSe$rJpZo3-bP9G4fC
pB'Uh/Q=q1A,e8&t,`S['>E="3r1B;]A:H]A="s1=j%cUc]AWU`T3FK2dQ13F_Pp'Q]AYRF1PBHG
/-uC@@J)kXsP[*FucL98Dc*%SA^]A-91'+]A^I,+Wd?1+e$(b]AXBjh$[K6btK+R<%s\*>,EU[/
-s!J'_=Kc(TI`5<3Km58pgoYIMe`G)Q'55Zo8,d2.Gd&*`Tm=?Z7>Um?Hokl5"JjJ-eCT7kh
<Fr5ejKh\+f#2TM9AmCtD8B9QIM#EXg]A#bQCsARcpVCo?(daS+B7bfbV1N3DjYYBI<2.8>;u
`5!j/OiPNKiGVn5Sf_)sF_t]AqV"9]A*Ek-9bd'-ud</GcG!*&:rLa75\r/H:PaY?^d0<s4!'o
k?/)r0^^l5HthGZj6\Q+<h#r,b,G<n"[l`hRWF%ga4uoiRub!@\hdhIPF.Tr<jMNMMR0h9>[
e5ITmtE0F2YSXEqE8X)pPMu,R?/Ap%QUhQM.JkaYs6?^:6<LPZ6<)nI3H\Ft`=,?a#Yp8t'(
4S&rWr/pi4@rH7$4TTJ4KY3U75HcoTnfZZ.]Ap!so4K-m;)$[q"TkE#ZOO#i8$Mh:2niBNP1&
jd*V9fA!7UhkmK63b.qTAaZ4pt^0>sg.\$Sr]A/V`E[+T&FmcW6?j#G4gQA2?YtbE"`V,[ob5
.Tob*^r'G3EZ:hT!GmW<giU:B&aUY4<^GYM6(8#:*d5+plicImL/Y4rj\(.P0-AC#QpJ.hee
:\Y.=Jb+mA$W(8!2Of(kj?$eAaQtQhoGk'GI>\@Y5'N]A$l>[S*@90jo%qBB"hC@>/#FeRh*V
!+0XN%r#f$_>1!S)LYAb<^/5]ANb!f9;Zd2p)TJU>hIep^k_9mYU)/+I(>n<7/QC$;<!@P.'`
VA",YU''JP6<(g_`qnQCtiEIprDYY$A\6G[(uC=-ssM^AOL_6K!,`"Gc^r!4`eb"?3@2b\qF
)$HG9d"d6CVYbLK'h$p9YD2-jQA8s;9!Y@dhjO9fQ0R,&TP5UpnVCC^*aZ.m5T,Pb/?Wklt?
l1F!3FPY;6)[?S2+oRG8`0MctN^Q/Lm0"mEOXULi*uG0.lL5^D<Z]Ao(D%W8i>Yc[Q^lN&7+6
K*biE7f`2)8HG4'4/C\pRoXMtEph&)OM4nerifRWBJ6^IrX2kC_&!3^-]A'n/220**L"S1V)e
HQfTl9VeCQMV1mt%!HEZE]A)/nW0=)cq##WbKkb:#;58.@dYe^`8VofYZk"t;U.+ReaO2M2N5
%(iqjB6`%*F%.`UH3]A/DhURI@'$O[YRWc8,D16u!>)Al#;+-:[,Xi7S6*kC_og^A6[<1RY,=
dL01$(oTjJ-:OMQ><)oaAkH^JpZL)n7=CRDL+ro%C=+hZV.$JuEh?Q+ZQ3qSZWH-8.g#:FF2
n!p=SB5&S@9UKtapA(9Y6aYeLXkXB;G.j4tOPOMX*GSh(!?RRH74R\B0<d6;XHuB.jW[0uAU
Eu0I-Zc@\GC8:5;Tb^;gpprSY[,P1C3o9h+"Y-nd?0EY:C:BJe_32@qhhpcJ"hadZ9EEF^B^
2Giqg#O?fB0$bP"N`#FK!EKO%5U8roP/a^nr+#A65SY(oSf0/oGSO;9UB?o6lh=iQ]A^^:g+D
F_mB]Ad(JYoP;u03)A@]AU.EkuOUQ011YY!oFqo(rdUVa3?@5R5&uC7iXEn+c.X#%dLY%T`IMM
K2b(NWX-g+5*GM"^$H>KOV8McfKmC[:OmF^P"2T"Xs/KR?9*60a3YrDF1-`]AZLIoa98KDB)E
Xb-7<od[>:rK?*XrNbMS?mM"I&`pHpEU/I"FDBnP[6B9!kK&sSFcBTGBCF\\DK#9/1TEJV>"
+rfWQNOt8DZ%!KEkGk@`KP=Ht.B?IfT~
]]></IM>
</FineImage>
</Background>
<Alpha alpha="1.0"/>
</Border>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[KmJ#,<:ATARDgm?1:E-iaPLAqM%n2W+_?lafge,t-m?eC6APuB@bO8:Ou5#G8n\PTCS[&RA4
1[f9RWMi\(C6I4jRJIk1o^=]AW_)&^9;lQ/7m.&@6kbs!!%[(bY@g5!"oG8LenKcJ!)GM'`n@
b_%rnYgU#MHp)QeI[S(8(4F"jBi/UbIi<Q.pcVD7BCKQ!]A5Y6b_&VElJS05d)0M"KN@tkh''
TIu?BeVu_DL"If*DNj`X(ttAX2?V87.`.Ydk9S-3G0=,qqNn#luW#;CXqYa`NUn7eNUYO_(4
.9VoIdNHoBW'Vto"Bcm.Kc2q@6cG:ZLW!5!Z*8kp3e$n#@8X=rcl\F([,i$5_BNe1=QqR%aO
Y5^kmeeC8PI*/0q;3W??b6rnIX=Z+:Ktc@_>@PbdGnSc*Hf<A=N,OI-r%8k_rGYP,L`!eM':
P2nDH`1HdlU&<#HJZ^gG%b^qZs\mpKoq!r<*tS1R\+r(`YE%>"T+HO0_dT&pF9*Vhd:;LjM#
6g$XDBA6\_%(Hej\H,t!L0?C89c)3XUL4W*M]A:.XqYlR(LKi#$&1EX]A@F'HL2!-dGY1e)8K>
*sZjB8e[E'(m.EH5'q@%-n!p<Y]AmBIkIbo"J7n>%EVeLpF)JKfnVdr8!;uWMn;/.A(7X9pjR
K"?ou+<6g9m%=\9_o+XI-"5c*K#-"m=iH>Im$p^g)Mcd%CI`/W=g1LWQ[\sBquIY_B_(+!DK
Znr#8@%uIUG(a*P1FRq_6WK$i.>M2<$DC3J168686@8+sorc:,=nh;j_'5%/90<HYH>#2!rA
$:a0#H($r+J:J6HrH^,ia4sp'uE,?)AO;p\p!WEgCCOdUl9UW9ni%k#tDtT`m!d!SNJV#VU7
\RNk`.r<18[Q3<Yg::,]A>:7o;9pqjIO41a"-[Qo>R2JI*^ah\,@PU/I4l_bmu6[-Kl30%L"p
XYtlZS#,]AiJSbb#MMUm?"h>9EN"9uo6Ffl#XoW83#Ve=Xm&'8Q+k(="Q=qrCVkBI`cONY6Dl
3)46@6fd9HBXXW#>3<@"EVXH=:(^ZcYqA<B]A\')&OCWDoH,7q7Dbh#N+Ge^HG_#&qM@7PN/&
]AG[Z'H5*c;a7jG,"BY&U,.f_[dBnf(mM>lMk]A)eE'L6:,a<$<`ot,X<fTM1:5m]A:<91'^GHT
p>Inl'#o#gMh2NRaTQM2u,qP"I<o4dua#,$GBeF1]AqC&GUGE*6H/@UPS8$J_5`$r-AIqRZ_=
RK5a/O57U$oWgQqmANAE1kTNl*#YdWVQ7o<EUm"q?9n?NDGrV>Fk#X&l+)9)>f4CPOEL)/j/
081d<]A3OX4Rac8CV\f=06`<tZdu0*+tp',c1.3U28g_8Vr3!-!V0:aYb>6A"*!3c_PGg-m:[
V/0thuLO/pP4^qrBH/g#bh6EZ,H@*Up0KKaSJ`=boO@1b.BZ!7gdS=J]AB;U9k7/\k6l-FfO0
7md9-Y;D'NcgCniUp_%u]AFN&3!P@!+3<g(O+6\3o0$g:D(4kM>a(\Z(^:6L>$HFrKE\(u2>S
cHJ;s7J%Q%aoO&d=cX:P)PVcnK[9F#c[pnV,7G<GabIgi,1dK>9^0ADl5"1n9YGmGRCQ['>@
U8'eO0#['V=2g,_eNQL#`M'H^rf0h<nlH4%^6-qj0iqHF9HIc8um/mO1"Q&%/>qEgrQ;U#tP
/IJ@bk2SD)G+WnHS:f*SdPTaQ)NpoiFm$$5\5f;<GdfOdm]APLmHXVRCJlr0ZWNQU@kXL,n[Z
6es+a%G:EQ<U7LW9pYjniY-$3Fh5N>mpqS&?$Coe6\ftNA<.C(4h4ERZN7PdZ:CDh'$L'e'?
D$DYrp>+aeESWf*/="5c0-Z,r@>GMs.<jmW=uDA:HAhJ8@7k:cnX2L^\/m=Ns/oc.`3l6Vq+
598<,Fd6e"bpOQi-I$SV>WaL7b2KJak!MCmr$;.!Orh,CTM@b@-`c=&[TM**k?iM#nq).n?(
flRG+@G&)Y:""f2u1.qdfT56h$bT`mkn\K`+Rm?R(p1AsL@m.'=N,XY6Ap$i-(s*$tKO@_P,
jT>^SWBJ&%]A-tr^/[7Moipse<p'uQ,(N+FX=?3l9!6fDH\$>LFqe5:^VUsuT=p"SP^n2@r2_
bBaMrk1?H8V'W0Pu*i-Yc<*0pCfFp)OZ4<Zjk,5gaB8IDOA&`,pLB`5CZa`fQu(@#$06`"aQ
FYfjf]A+sgK>3&fc`i)0ck()a()4?*"DPmJNrHfC,H+KU*0BupheQ3RR?"4bTWDo6\O[l;$d4
I(aDXiX,lt7Pr0b?_7oP:?"C<\f=_LeTj[Hk/UI'C5pNH@n2GVWi>3Cn9I`7+\+[juO#N`=9
AF`7f6k6XV\U*GL[jPaJY8O`hh6h"//8I>R@]A[j6hnpmQO!3^C4b&WX23fkqPkfY,TrsChDV
i=^0&q"78A!,:EbQThbE*!>4.rj-+n6?)0VZ`#A8e)a_Qr9^Xf%cL#q2XJZA)UFsKhuX([El
o.8/c("^fP+W*6%V'jtK4@)E."",+('cqA"Zt1V+OVoHN:M1VGIY)%!P;'c[IT0T#T01.;@+
.d)CFH^c:>*$2#K]A3'nScegu,F%3ZI+tk'b'Ji<L2?TO+*k,5aTEc)qnf4]AABk-.D;%6C)75
J.ihJ%W&h9%G,i8+JfYX3sR78>)D`N7G%aJ/PnkS,4^CN*GUH=W(G.S2p84H@6'!:G\]AYY1i
13\2(YkeuXMA^*giEfm/p#?0@l_`UI.^t;p9jQS(U0I%g'Tg9Y,*-0BF'e\$E52%HVPGf:P;
jUJ$<9d&8g[bZ:#hCnsOr*r$gmglfe3KIUB"\b5JM=i7+>`UjEV'0/PKa\kH$;RFZ7lVV&=5
YG3NHuno^Kf`I6XioreNqK[7#Zo9%Z@<ASUtb74Z`^pJ-qJnT$7$Mt"c.KV)o_Cjm7"NDfr"
.tZDpdBWc1.&Dl2f^f=niYEGH""tnaiR'#1dTN/\6;g5\[ESaQBSR5[l.LoVa0S_P6Yc\[ki
Rg6H8^luFGkkU!.:<h7ClsWe<UC.)\`"kc4S@pPY\f7.A@d^GcRTg%4]AH.`g!R9:O,n/@LHB
\ClaBQISP4A`ZOs"`;S]AK,7BM6iUQu1G0W&7C3/^'$rue'XI_u:acWFHSZeSp?[DJ`TE+nT>
HQX@e#mfH:"VH2*@\"$@D7`ALqba/$QFNm5kk&D$ioMH4FD-=9S?S3h6>a#3]A!GRC]Atpe03n
U/(BbO:3g+leJ`QOgfPI`ipk11BULrF?gG.;QmZ]AI,F:Y7\^"8m:@k;j7b0FP)[:)p:@so"!
KBfQ(9PL]A`eZ/]AhP^<Gm.A7rD&p`HdC2O+GDY%#F@GPppUl%j3"T"u1\*PX7X$$Lak,P<i9>
`!7?p"AOAR*p)?Hp9^g.E6?323q.c(?%*HZC&f?S[>of!*D_cl`k=dLGYZ=7,uD5,DN19%m7
j6@PCT9\iQ,T+?r3Zh.lDT7R&[_PWW5+IHu#[)S]A6\p$;OE(_ci=BsInK"epF[aXnKkm$bn;
2R?['X_e,56*gS&;\ETT\'Y50N^aJ8]A<[Eg(J)rgr9@\#k?W3Zl>PfF_ZB1!/-ItIZ%45f3O
JXO?2S=e5DlWOWN5\CQ3JuLGonn9!JfRP]AfZ5@-]AJU^cF-V"dAK0Y4=Qida)OFf$K);'"Iak
=6aB<Y]Ah5fHhJ5gQ,<(_j=G-@!F^j@o+P,4e$'V#n$rRn#D4=X9'N#'2R)b-@Yruj#&G+=R;
SCup8E-CgP(VZKO]A!o-=A+HG#!Ga)oYZl10[g4AmK0e-(LkRd3ZU2VbdZB-4=/2@:d=j7b3Q
_<5F25pC+m.f4&Q'&Q9hU\/etSf*a;'46YMb1%]An)X^[Z,6V<Ur1BD0GlMX"QK)f4';ojS[#
&Hl\aF-?h,O=Yh`^l@W8rp;q$X4UI<6B,!8\,T0Cdg/g$/d,3C^,TU;nJfb@r4jA[rI(p'4[
:h5#!LV2isblqH[i`]AqI9053;B$KEArT0LjMuO-AoQkkaY$CVB`1*fHaT-7,Q/Bl9<@j]AuO"
02R5?'\T`Yqap7Tb`Fg^C^s/Qc.F]Ak(6&BYHp">QEV(X6I_XWPi0dj\:qMd%Um!&n**KRVMu
[>P,g]A"UI,0X8iIm$K>\#(fE9ShV+;n)C8Y,Q4F3fPt<hkHsQs]AQ7hCEtE+=U3\,FhKHDqqu
1H?*1RG=:&V4,t@eMXb!j5laL?VaS;Zb/:,?WVFjp7,)Zk,QKO178^uPWPTr1IXng"PU%a=)
Lj^$+!4e[4n4_/E#`e)Id]A-@ZGV#2A6gWkZmS.9T`XLVQAW9p!3dQ&?(aFRr02E%r9='k:k4
*aPLmG7=F.E`(`!;%%NeRR_%b3]AjZn/U%FEbK5'rb&#m,Vc"X<%P6=DGapaA^E8]A*'^Y5r,E
!3,W]A(c6$%"YQb6:s8T%:(:Y5]A_.4/8h!V?%DJVA;2O33W@b;;lE47+B&'T^iV'H*..<9`R5
@q@\\Gq&V/oZ$I!c$13u(f%aG*ebqTTB&dB/>3V$BmscDuerlHW7p"YeY&Ye:muDVTW\X1*!
T<BT+9Ie#X-94U7g#L=f>TAf*lfPrcYXrZGZkFc(+#Nm!?IjlQ[%MV1rO/J&Xh.Sl\^Kj/@<
8MN19ack$+_!HH[@)8%C]AKZ@',P_9!$D=CM'hb_2Q9_Mi!<+\E>Oe-4BV[e['Akb)'+O*9@$
;j%gU^Zi"KUN1h_s.D)(]A'HrRf"BkTh^1\e5]Aos3W+*B0q1b3la:)Ve3-0:28#DR<0rnRUeF
0ht$hbda#c?,FQ3g&<l1eWX7.p^E"4i5l(?*^E&>4Y8?(5Ise5+`A*#+969H#gGt%]ApCM41k
f9qS@O^mU>a%''CPUl[=_"P1uN8/$>e3L!\[l#>h\BLPqBp"`[Jh0p))T+<QfEHfbY=/7Z$F
=La02I57ArU*cF%KSX$:Cq%aFsm-<NP#@DT:/[)e]Ag%!rj,X3YFD/K<#J\RoA.m3NMpo5UOL
$u="auI8nLqKot_G.f&H*0-1bu*J>0(6k)GuC'EQ\g>"hSZ+r@C&,M!G^b_LgWdSn(mcl[rQ
'!6a8!X2h0f9)NT06hioZ.s3]A>Kd(/tASaR#ja,3c_/r+ojN5sA7)u7&;A&.bi05e[_m&TmX
6M!C(^X:C0c!EJWD$8n$-"5&`LBFEA20tDoBeeC&En"P0",e;*rgSk^1K.Y#UU"(]AW\#T@iK
^JTl%sMJU,09E=;DXWEd!\p/6XGS,8QGP&RT`PEfXDB6j%5o>HT:PbD6%CI3FE97^gEKicIp
YlejWEjgutp%[,RoA3JPPEXaWQ\1p=^1f/\"Xq#[tD>9T41`SHh/Ik:DZD&%N@'A-=ZH<eYk
,pZrRJGEtgpikK>1Z<_Bb^e5<>"$r]AQcD&<:6B>cJm/AMVKN1(^0aaahOEOR29*,4Co'1,I>
,1n3fKq'"B&Y*>Esd"[?CkU-7=FNeqT$hAGTXO6b3q`F-cu`:Q=$<Y[TaUOmu`OX"m64k1GT
rN_e5F,:dDKKEs(@Ej3Lo_[Ud5C$?uA`&]A^!=k%,dpj+C3I3`qV76[hBE9@LY^(>#/.D@7qD
6L0JBX6#_c1M5X8hasi=R\Z(]A5K!iiac5_`eTYqI.S/Z.$;IZsO3QFUI-<Kd]Ag7Tu?\)/U$F
7IOu\"6?,0$<Rq.E]A5Y9q-C=".kpclrUg;!Ef##quad-c[cHh'6LDi60))j%\BP_'V^T',"n
02$]A:1lM8ETEPFZl**[LJt]A-r)^$_+ma]AWSLP-2q:TsU]Am2GP9d?_2TPG<=eonkUq"1h(g#V
Yh+]A6QO7!e#./fJ$8Ir4UKTI]AP;m>.V%B/uGK>q<PF\]AJ=+F3mRXi&-j(Km*WumT2-]A_O;EN
GtVdU+^9;""7/bW*RIf)aSW:8Op.0_lRW=7=\JS:BUt6:2=SL"@Xh4-H1'jZh!&YJViLY^$d
'^oUBo.DcWNG:#KP'f$F)r*ebMrU"^c0VJm'FF&Tf>IiH$H7$b,l>34^Co17iB(AAInZG6j)
,&#h%QW8!(0)e`ISqmq%f<W/DY_k-9Y+j&r*UQ\u>lnN.<K(AR6%-Ad0Io;$DRWF*O6jr,6O
m&fr$X=,/8H.R@%8MC:Z<62<`7"0dgsN;+X]AIQs\UYBo^;T8k[0.P>lPJ.U=)Wp7d1$fiTAY
X%i,%nTs"r)m-Zbo\^G`Q6f;Er+02Ok<"LXWdo#:U9:nWq.4mW`ooC,^,O4#Ls(t2,\bP.J&
Vmu,9:uK+CVE(J/R9M*.7rkQ:<;iPP]A%1?jG8u6JK3GAVf`kfEUL/:`k(S<<*Lb=o^;>.Ud:
^`l'b9?YcHm`doW%:`Wk>jsf^N*)2Hf<q(Fq^"E*kh/qX);m,$-A87s(flA5KI/5p(5oM`GV
\LXRj]A+s)N0htDPEaSQD@2nBf^URq%F@0_Ee(q:Ct=I(@C(/).3I+@S[Q`C`0p)71;DWkA/e
8*N83_pm38pI/0l@C'r0B+Y.;FIb`VZlu!gZhT*X$'$N8uFV7\:q2;\_j4ac?U@(SOp"gftk
p==.k,`*OfBLKO3[3\6$Zsn-jL_`^1#tJiDT2P<If-,.rNQH+N1ubl=SWr@snE%^*CZ1E-J7
J!ubuNtbjeqCS2!<-S&,,+m'7Ms<Dq/Mo_3O7RHiHBf/Q:lk'Vif_aI9;8.batIe1ao,G/@7
sA6$Tt1I`'SX/]ArU#)khi#"Y1c3CqOU^3rRF%+g^VSHJ[:W\3[(=/1%^d"MHCoIpKs`6B<td
'b9`aRX[GJgfCA]Ae3tD7^Nc3ZKE6Wt^:S+0%C,Jg2V6bk'1/WNNU(/6W3)4$;>u0st2Cd@t4
*#M\MI'2F`>c)g4H90SW:!(Me;NH_l[MY6dc!4NIqb9+T'dG5'i+ZY!`Scn%AHhrLusQ+s+k
rl@aIV^GhbOjon4:S`h.6NC"*a4a2Q#7d]AV9H*]Apk^+.3"2qc*F$RR$uNHEWcCGPi\*;ltV`
;r^Xr<Jm`QU0JU/s0mNSKtZN24?78_k+>[LS,3calLi+lbq'Y#o7u1\k%DecaP^.T4ON[Pl2
?+-9goPgF'mbq!e&C-Z1Mos?Je\hIui%Iqu>0@>m0Z4l>qmB4]A2J3\.0M;7^k,mY.:P>?>Qh
FIEk(!fa'MEpLm,Z"LIoAo0gnh&ci*cTMm\Dp)eG4q7d3Zb=:&81"8tn`#4144.W,2h>a!H5
G.FX?H&a\208*^=3Y/.^IO$s2-eT`PlD^KlKI,[G5b7L>b=PHor/do,#+UP7:,/?bMAQNT[n
==#'_j%9ET(;ghXE^ogH31?$c6`!Q;,A.nVMN">V1WTJHO;C1%]AFBU%f=r:16!U$<qc*^0oE
([2t0nSl(.#O,L*3%Cba56[B3HZO2[M)pIP*ESkOS2fc60G/]AcIF4qK#I=1`=S:A\]A$@-tdM
WRB53"hD4H]A1cLu8@u=gqF\_o@dt>\e,\f-5&Opt?P[bZ\9GFXqNQ1OmQc::j%0]AL;o@=I&F
LXO0_sraAr3:Uj2)lIF;3LP"@bb"",Cr2Rkej.u5k$ka['*^d4YOJ354_'PK*C]A(B#OpZFXY
Y>h4M71Pq7^oal6h0CNnu0Z,'U_M/_J.&*,&d:5AEP-?l<3L!G@BjD]AZd(TkGiUr[)Lk!q<2
99179Bg6U?lAVMbokdokt'D7Ra37D:e")0*r[M5C+B/><U(I4"0\^eBHH/1c/5K#(DeT`NVH
WZ;PD-uC18Ho#1`#V_^g-6kMK_)1ISP>@CsRrXWqmr&7ljaXIHam=Y?Q3tUH=dU5kYEf3F-H
s@N9K?'XU=59QH?o;^'e>"b-C`*EoRZ!2IkJr)U,mpSPUkVpSgLur;&CuEXU'<M/]AaGR;%/+
;'LIsB*&b:)j'-8TO]Au0,W,;[]A_Ei3SIOXp[-El:L%j%lGUZ+-b0R72VJS\3M(3GD:Ln)bWm
tn4hL>!NW>Ac`.&t(qXG>uB7@Bn8DXDp.D0EG;a(Y!8kV2(pb5oQ@C"kgGq:M;DF5#"_MU/t
VlJ*Io._bi19,+AGUNILf>bB&=M>gDkML?,q<JFE6&8+h;K6#lNQ)n>\3cQ5[6!;oa7+2l6;
k+jK@N*j_cAC3oO?#RZD@77Pn'Pc8Djnu0Yd^s$6_)d.=dm;<rZVAQRiPHr+fU96@!L@ER4>
7C8-[temM/D[nYDSp`m's!u)]AJBHfOSOOXptZjo5EC_`;HSh1DZqse'VELWqe5;'17^#VcdN
h\R/;V.P]ABD5?k(@^=BF3r^(/aPXS='`2)="H=c'gAonoXGB\4SYR;/2FV0=^aQ!c/G&1@Wo
@JcgNI'KAc*!&'q:OXRQB6iI+r<AAUeso6V$osJTl$rq0Rj:<q(hSN-;(^.hM#!D(d]A9Gf%<
n!>r00_;mP@]A^DDX-iInZ"#dqjM9N#ghm!:@1;R&jqI8=?6&ggHOLDui*JPg!A!1baVqOo)q
<*MRmqfVk??!B[TnWU#q/PAWm"r<Cs`+%+3)Z.:8qfTVo[Y:XKVQJC<&;*l:I#mr?^6c(q;9
aO#iXVr#+DIWAVK2BWA\WnUJ77&tc]ApG*+kmXG*%H$&lXs7)/AbIt(/=OgBQ&S&O6tb,HMi/
8PSbSXg\%piHr#(Q<5h=^=MP__>4+XrOW<ahc;**]Ajj]A4+m9SSnY=2t<)__p:qlmM`a!f:+D
]Ae,#)J!?.,f<<:2"clbJW7E2ONbs?k=,3q@oYQr"/9c^Oeafq6sDuGPo*+p:Gg]A;:Va>QA<3
%g+3GkFa6sH>6BP&8VSTGM+Bs=V/[mZSgO-%#H=KWqPnme:pho:l,HK2dX#Q_W0']ALa%IM+"
`QPNPd&cU-Pm+#IB>SOE/T173.=6/EkP1+>H2<k4@h?F&/8V5\l^"ChSe$rJpZo3-bP9G4fC
pB'Uh/Q=q1A,e8&t,`S['>E="3r1B;]A:H]A="s1=j%cUc]AWU`T3FK2dQ13F_Pp'Q]AYRF1PBHG
/-uC@@J)kXsP[*FucL98Dc*%SA^]A-91'+]A^I,+Wd?1+e$(b]AXBjh$[K6btK+R<%s\*>,EU[/
-s!J'_=Kc(TI`5<3Km58pgoYIMe`G)Q'55Zo8,d2.Gd&*`Tm=?Z7>Um?Hokl5"JjJ-eCT7kh
<Fr5ejKh\+f#2TM9AmCtD8B9QIM#EXg]A#bQCsARcpVCo?(daS+B7bfbV1N3DjYYBI<2.8>;u
`5!j/OiPNKiGVn5Sf_)sF_t]AqV"9]A*Ek-9bd'-ud</GcG!*&:rLa75\r/H:PaY?^d0<s4!'o
k?/)r0^^l5HthGZj6\Q+<h#r,b,G<n"[l`hRWF%ga4uoiRub!@\hdhIPF.Tr<jMNMMR0h9>[
e5ITmtE0F2YSXEqE8X)pPMu,R?/Ap%QUhQM.JkaYs6?^:6<LPZ6<)nI3H\Ft`=,?a#Yp8t'(
4S&rWr/pi4@rH7$4TTJ4KY3U75HcoTnfZZ.]Ap!so4K-m;)$[q"TkE#ZOO#i8$Mh:2niBNP1&
jd*V9fA!7UhkmK63b.qTAaZ4pt^0>sg.\$Sr]A/V`E[+T&FmcW6?j#G4gQA2?YtbE"`V,[ob5
.Tob*^r'G3EZ:hT!GmW<giU:B&aUY4<^GYM6(8#:*d5+plicImL/Y4rj\(.P0-AC#QpJ.hee
:\Y.=Jb+mA$W(8!2Of(kj?$eAaQtQhoGk'GI>\@Y5'N]A$l>[S*@90jo%qBB"hC@>/#FeRh*V
!+0XN%r#f$_>1!S)LYAb<^/5]ANb!f9;Zd2p)TJU>hIep^k_9mYU)/+I(>n<7/QC$;<!@P.'`
VA",YU''JP6<(g_`qnQCtiEIprDYY$A\6G[(uC=-ssM^AOL_6K!,`"Gc^r!4`eb"?3@2b\qF
)$HG9d"d6CVYbLK'h$p9YD2-jQA8s;9!Y@dhjO9fQ0R,&TP5UpnVCC^*aZ.m5T,Pb/?Wklt?
l1F!3FPY;6)[?S2+oRG8`0MctN^Q/Lm0"mEOXULi*uG0.lL5^D<Z]Ao(D%W8i>Yc[Q^lN&7+6
K*biE7f`2)8HG4'4/C\pRoXMtEph&)OM4nerifRWBJ6^IrX2kC_&!3^-]A'n/220**L"S1V)e
HQfTl9VeCQMV1mt%!HEZE]A)/nW0=)cq##WbKkb:#;58.@dYe^`8VofYZk"t;U.+ReaO2M2N5
%(iqjB6`%*F%.`UH3]A/DhURI@'$O[YRWc8,D16u!>)Al#;+-:[,Xi7S6*kC_og^A6[<1RY,=
dL01$(oTjJ-:OMQ><)oaAkH^JpZL)n7=CRDL+ro%C=+hZV.$JuEh?Q+ZQ3qSZWH-8.g#:FF2
n!p=SB5&S@9UKtapA(9Y6aYeLXkXB;G.j4tOPOMX*GSh(!?RRH74R\B0<d6;XHuB.jW[0uAU
Eu0I-Zc@\GC8:5;Tb^;gpprSY[,P1C3o9h+"Y-nd?0EY:C:BJe_32@qhhpcJ"hadZ9EEF^B^
2Giqg#O?fB0$bP"N`#FK!EKO%5U8roP/a^nr+#A65SY(oSf0/oGSO;9UB?o6lh=iQ]A^^:g+D
F_mB]Ad(JYoP;u03)A@]AU.EkuOUQ011YY!oFqo(rdUVa3?@5R5&uC7iXEn+c.X#%dLY%T`IMM
K2b(NWX-g+5*GM"^$H>KOV8McfKmC[:OmF^P"2T"Xs/KR?9*60a3YrDF1-`]AZLIoa98KDB)E
Xb-7<od[>:rK?*XrNbMS?mM"I&`pHpEU/I"FDBnP[6B9!kK&sSFcBTGBCF\\DK#9/1TEJV>"
+rfWQNOt8DZ%!KEkGk@`KP=Ht.B?IfT~
]]></IM>
</FineImage>
</Background>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[2160000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[720000,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="3" s="1">
<O>
<![CDATA[店铺月销售排行榜]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="11">
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="1" size="112" foreground="-16712452"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G'A;cfQ6[SQ4rPqmNl$;u\FVT)M+&M!p6N2&a4XJXBB>#R_?MMdK&#_WcW>%aLV8rUblC'
@KSOg^.HT.rZq[O<j^-:ei(KVV-q`Xi1X,inRb`S'\E%\1^@T5N3=+8Cq=F3ho*]Ata;iJ*1'
#H><]A3n#9Gc9pmcU0BnIm/#Q'd*'7`SA'=oI"S,,f=cd@?Peml$9,IW1W2d$_OqUesF#Zn#f
tY5kD=ZIVQ0#Wi(KLdi5+!,=DVhh+q+i^qZF7u%EUajk4umtFb<Tq?hR:oiB+9(L#D/:,XJ,
%V^;!6/->2QKYS2(Gj"pI`Yc!ZLb\q]A[G>"Z(.ac)F-&+1/?Zf1]AFFMLe9e5d#qIW+(&**1>
V/,)cH94-n>1Z5nG0<)hs3K50h#&J:WfGMAm.XutX5DmlH`-nX3&)jCs#f*g)u*oK?H<%Rj)
9FBLfmj4kE&$i=t"h%=(<kU'lZ%7G*h;I7N!;Ja<Hi\2i78XW&Z05)BW$0h!/OQK;ceQcY_h
TB+*IP_l=^udH,.EhIW]A!T7+WnHY2@3P-%M]A/",A'YFICX/OiIt#2Nd:I7/XfpJQ?@<IK<j_
,\lpnHB(R13hrLV>hM=old,"Zt(Z:e0quV:;,J]AA2Ui?Kr@RtE;r*+e_"P3ZA+]A)8?OG</S^
tDZmbt_M36BcmG1tTRn`S1F[,50eIKH'G0LpG?/pVpZ86?>-+p.`F00=mrH>;hK.22[*ImJ1
#3=D6Kqs=<otlZlC.pAVB^.^+5cDt^'AX3X8F5SZGE&-41kk)DSC+K^eDm/Xa++-L0_BUkJG
*t@41j(@?),#[:0=Q):ecme:*]AdU("Xq6*o$A\=k1A@@FZo(0OO:Ki$9Y'.P?3alXKUq2cC[
]As7^uq_]AP/,%F&Ztaf/b.Bm<2fZ@n2f:Ro(EqXe]Ad?U0&tik9-8CMib?g*ki5b<_lXAQGki<
$ks*fT+2HoJ*?`T.N7_:Sg;1V=+2(A`W(94ZJgY4*`uuDem&J]ACo?"p@7*;@bl>-j/5B`V%_
Gu8NLIWp`-_u@?R.L)SZ$[0l]A$@KF?O'=eh%S#C^13ep?rXq?$'<]AJ1MQ-WA4V/>>XV>S7P8
5;(_ea`ZFR850C,m@0^3,.2TYiZ/bl"Q"\.c/()HNV\7TVc/l1f?BgD]AYCACf=42Vf%RiB6`
&>e:0H;/OoK/%4=W4h;7KDq'(ja2Qd^uLB#&iHraIR)$kCD)XFIh8ERUhr`^,nWI@W<<l@EE
R>qAB)1Y&$qd#;Ul?9Io;c_5b,M:U,<'\YFL[-F8N4oj?n3o)Ld@&k"-1>D,DNdbLRD^:\D+
j[RpIiq-no*aE@if:s,Dq&U\aSZjmJF7XU`QcU%qTg-taHM),SI2t8eTq,l<1@p2TdihM1]A!
kMg>+%tFhr.)kiTiY0g]Ar-I$Us78KOYI:C9^hpj1S0eL=r7LFY?5AGb"^_,,7sL7cl#QT<'9
OI=')2C`[:!u\\TdtL,q5DlfZh`:CpX7L@L:3JeR2:Anm]A"?S=o#5\b=$\F0CK]A'\;JdO7W2
;4]AN8Uhrbj8t45k/<mVaEn*HmU*/@sH).SDTi/L>4K<n'`uuboKQ?Qe)\Mj[m,p;Pqd3,uMf
Kj[jSOp'mp[&a_\ek_AHlF@(dNbO[RWeQFqX0O<6+N/C-;h!=R!&$r`:#&T_3]AC)!$@T$D;o
h]A4k?_,)OJ@[m4h;1inetNhb0t@*<;G*]A-Zr?_aZtr`I7ImbHQ;3=frRU\pBtfb4dU:Wf%ZN
pq+0AfYM0g%Wc$>3J452CA4klc3O5gmU\CTb*\"-_)Be5a^qRe`F?u]AheYAkFWhKqpu&q8+h
mR%h-jm+K\89-?'[t6#6#($Q()KKJ0944r6=5$uV([$+Vm.-D.,GqPKm?\N&d@8s2kqd-74)
/D(r`]Aj*/M`l)_7D7C^4oh4/KlgW&d95AKds$+`H-6OdkHr*A)D!hA)+!GT0SQU]Ab3i><X2>
D'-#_*cYlUDGO@0.Nl7-T53M)4o[sZ`LZF[nUPk'(-s3!%?!a\iP[S,['QW`8[5-CtN_g?Io
++^"osSkWm+jL'*'mK;J>=4T^<21p.\<aq4jN0=6#]AGm9u(Tcnj\fdD:=`d&lnM#.pu``,(,
p3%!rk2>]A@?Z0T#jG"q$@E'_2-r&=K:j?6WM2er`UH1:`id`edH9(ggKn2R\;.m=B:,JR!Xp
YbXp!$8)2*]AA;a[lWd,rPnen1nG>K%U`Ql[LK9c(Km'mEM1r"gRZD$aL)'qY/nSK]A0U@Z;S/
nuHE%t[;Yk3OfR1=NB?jX$1SEQ).`fQ*Q3;Ru'ihE%P%m7'hMUAa@"F&GlVri\J/m.8T3.5U
q`@6&f48ZfK[_(kCK#-WC64]Aj>1*T^Z/5^M:Li4QVibZp#lgq#.#tCuL?jJAJi2,Q7GR;g+2
*"k0^4@c]A$P#mnkpe&X?9^EpOuK7XnJ1?urSA\=02U3f9%e2>?$4CIO)Eh:*W1FseYG"_C8$
1NSOs61r6N@WL(ESUek^tP8qP@q.tgUQ&%kl5V!\d?2f%dPE-+:C^S!k06[En+hd;XtDb1GY
$Dc2sc;^XI^=`:77&e\$H2=*_h5Q[@X5M2rN?G)f3P5j7D0X^+e>XCMb*Q[[(Q`\2cZT8'i_
m",q"iFp,q&Nb&!BM\6!T7J$9b^h`qq]Al.nej1;)Q%j$V)lK[UF`&3@'_Z,T#6)p]AHW4?5mT
t$6kn=Ip,m%`?t8Sc4/Cr!nRdPfp=X%N9,,4'3cr1E==;FSa+B=MB7O_=K6H;c\`1JkfAp-@
htP/]A.kp=;WcArE2#N#ald?2^2KBbW(F[(7t0IY?K(h3+RE'>lQp%C4:a&FQAb>A?1sbY169
m)jsR9Oel3tha>]A*Em.l'=rQ^q"fSl=EO7T@%pO[1T)ltB,_JJ8JU0U]A%N#c8eFWjSU]APPe\
n`/r-ip5(E]A<eX1.ihN?hO<5\">N"o3)TjN,7qV4Vd)C>NcY&-]Aeu0+rd6m+L%fLLpBC2dce
1tEeuo]AS^lCkC_IT:N781kk%j)@+Rt*:iPk-Qcl6h(G?sD)-3[!rC\qkF)Df+]AXql`PT;[Ko
kSe&`9(0;i)]A"9I%K'+'^%$K1Vn#$f[Gm)0n"JZ11RB)`3:?IB\XW[3+\^(f)@oHlUG8!LrZ
gq^mP3#Q.r0*_AP)^JNM[@SYf1mEjjm0BY6n*eBY8Gis1j9-UPNs*`O-@RV0e=mj'Drq.ThR
*Vq6:Z-ZCocA(FcmY6Tf2MFrAg5fi]A6\LfRS-gmEE5W,uqW*:IDj:\g%-Mms,(`@(Ve`t/qP
$7RhKVUe:@%$rOHB!1Hd%#'$B3+pmrLcaHn8(5GkC$4f!Peh`b8a!4L4pr_-RttBBSUP8&GA
KU]ANOEu4cOZrY#;p<<HreAU)@A.a?d2JGXBbi8kN_odEtooW*!0*GN3BuKW!ngp^8)O'(CI7
o82Mg8c+'/!rTumQfJWGZq0\tgKEb[o\f$?FSY2]A&;=9_qBU&rnmA<(f+($BY6PrTJ1cOg]A-
rY=@N*a%)]A%RhD4'#hXM+t+'Xq)%(r9t3.=V[@lCpiE\b\kOe#mpT_Q`>8k<gL%WkuLrF:L`
"9:7TcX]Am=G_<,Y,l*R%Iu]AX*.\.\&_V,dO,oS36%1%XE8lUO'SKfpbHqMtU\PTA&,,CF'SD
1sCWoEYYe)^6^Ll_^RZ!"H9hUBpmVXo9tkP*HB-'8:@d'S,9A]A':Y+fKg8gEr(6rIK)N/NU>
5Mm*WL[KMBq-i8R78E3o0OLf+KYmG20V]Afu6ha07(YbmhAfAnd$6V4oMj0oWuh[[+JGpTW;6
DH'`%B\%9MmM;Wl]AIh23?K`CoZD*qF5Rpms-/_es";Wq*VhUVEi=Z!<LY"i&YbP/W2e?4Y/L
f*On=mQ'Wb$ailV%B43*f),/2affPbtmg\Faejm<@ANfiZ4>RTHA*<8Hs=<E]AXF6p+V0)b&"
Gu4IT99_8Z:bn(X2U)RhNrNN;(.I5km5)mRVfh9+fF;_[1a@';/Chhm7_mr7`N10nZhK#]Aos
"BZpAr`2^@m>r0I=&-?'L;g0N2I"G&$-e1:bYfKZ#d:GS'23`oNlOap75Ci="@;3jFNqVJWY
5SOKJU>3_K:i$pGGfO*heP1po$X]Ad)V0I[Yes^8lJ1Op`sUUb)6=W[9/'Y"e[^f1!t:,B@0(
lMG$s5>u,W,TrnF(5(uNK%.EYqat[&>Aq_G3B4+Q4qFh1>cK`u.qbpL$SceP/@>/X\1FP!?k
:/`WY5n85+FH?.SXL-CLsK@;30S"E[B'l[^D=$b)-k7*Km3Q@Z/Zu,4O3`l=/-iH#@c^=2.N
iH2#^TgM[,ocN6Q)#m[")d0cuHt`TRO-Z(r,r(TCt;I(asPqWH1En7'kKnXEZ_&Z%"R&OOM)
#C2V"i97&kS%0h2j'6PY94#X!kFl8U[;Jt`cM9B^Oo\0mEM?]A]A&?nK:gn+fX\0^oiLHHL5o%
+r.k4Cs0Z_t:8mWBHGkFZO$UHeV4:RNS;%Jo)H9`Bsl^H<8Qi9!m8PTt9g6fR)5&98=Fo7HY
!Zo4G1$!O:.6<Xp;?#RKu*O;/GLB*l&Y2lAZijapKDY?;]A('">?Uh:dIgbRL&+=.#mH!;k2E
S,a]AGEelQXMDc0Zh]Ajt/>:!<FR#_@oANt?:]Ar;cYTa_DMrq-HrQB_&9B0Ue4Ij[:]A5St%\Ur
iP>.Dre`DhL-H7t2r:SWb<AYA04U:_p_1H<LRhnme294qZfC_0GiOB*cLc:&j0OEDLnPJ02f
]A;Sc&%N=dJnOdSD'IeeB(s6Wiq%XEQo@nLfl,\[#o-H9Q:PQJ`+g*;_Pe.Iu`NDrUO>S(gU:
`>jKbXr6Ca",!/I[Q:]AT9HB2QK]A2B+;3@OC]AJ8f6ki,A91CM!R3P3S.DM`GBu7Wm"M<@84o9
>O=%HK>f0kC5,N:]A!1_ArT/oR&*4ZS<IW1dG?bRb5MUA41Rj1SXLGp6JjLRX$CSb.fPDQWM\
f"npD`"NJ8YB2(@)Yh62LsLlXk'0M4:8muO`gAB/7pQ&?*oPY\QSUKRI1)nrg5,.`t75BG<G
Qph-Qc07S5_m#5I2`\0/"DH?`F5&p]A0?h'\sg$-rSt6PpS-(a!$Sda!=EJ\i)pOg-7mNITd^
YQ^5_53[bK^$m]AH_J%7c/IY$e)T@Ld#GiWHjO3u0L]A\($a:`BcUOo8DHU*L7pX_N[c+tZi(9
b.!rQjAtLCDKGp2Srk"ak<s8db1o&$H^7(r*hY!L!hU(5Ou,$(aKlI#2uQZ*>V]A94L.;6kNF
'FK7ko"rh5"<+puSUFs0HqS\l]AHL:o8eHF$!P>:l2U;:W?:3Rr4pO8iA8-We'5cgYQQ3AED_
>jeAJ@bed=Ssaf@-!DABILJ@_F0S5bCRhlH3e"Yr;WA,J'b.h?V\[.$1Qc8>QS6J@N.os39N
Vi%MV%8jcE=Ze30\$`5*]A/`l::d4'7&T!p.9,I(a-ba=L_=BL$iPhT%nj"]A,O\h=e:rD$ZY^
qoM5dG3:$+27jT&X+sk]AA6nHkJ=$ghf5T*Xc9#S)IDIrg]A9uKt7[='3X>Bse`#+:6hX;'3.*
E3+(V,95G$\6V,6(EoEZ3r'$XN*_6p1!,0#j5G^5g&L3CSr$%S+BR`lNldTGt(0SO`]AW(Cf5
@HCK1m+8Oiu[ZB4VKn%2D*$)[b=%?3cm?,o_HU4<@8t"jIq='Qg,YO*6&iTMoXgHIIR&E.,E
#H_ucR8B!AU."`aONo4X5EX-+Um9XSRAN`@3`6l)CRL>;lh2L3O'BQN,^C_"mnG;O9UYYn@>
PsQX+,.1[YA>2N:S7?hXAlMVmrlMTDopDuS%9il0CFoc]AJoB7U-X+tb3'2C7Pj$Ziadi5-5%
b`T!NAPLGB:OU\&d/+k=PApa`\1a`'1GVK6-46'mV)5>%!RP&s4q9&5C+WjK[s)MSB!,;mM3
CN$gl%Acn/a6Pk@Q^CW!Wk$*ho7B&_SnR]AdUJOLj3L6r(*c?NfGPH7k=*2%t&cL+$J"4!t71
IfJfM'b(De_ZTh]AIBWC\p=AqpdY$WNd<)<dh/rRH(SjNUbPngo-I-siJ8WJKUmAN^1[TDk5M
)'65hEW+3IBEQZb=-no6TLG)9eo;W"`LG(aG4f=;lk3BSr2+.A'nSo'Ug)]Ac%4.`27G"I_:X
!Wdm6p,]AXrY!dg9CI8W98I3SZ&W9ghL.=!HU&"F=<>>#Y[XL,TT&-9s6Y[or\,E8$MWE$)/X
*]A3fXrgnVRSM[JRYM^N]Ar3TG_5Y]Ad!m3K&[hK#,W+0Im92n=R!G>&,^7s8m**[]A#NFe;f"JQ
c8.=]AZ:/;WT`q&7%ngeo0a-f:,MGEfKVk?XM+@e[.8]A+5:t*f+9geCOp&"<c']A%Hk,5r4o0b
\@.Z%\E9CUTH?dYEF7PX\CGCn_eOZI+/oej?g#YU99HdB%'mb[F"_+J\iRZ7+Fs'gESfd]Ag)
25!BhIu[7jcgPSH`gmK:rJmcD]AH/+WI?TXrS'*Xi4u?OF&.9V)4f`ZL"kfN8$Q5_4biP#_qh
K@.m&e%C]ApomAO:iP)9(kD_^QTWO<VM/M./;=Nej>R>>XBC_rf;s(`p:d0_HJDrTHB9@KS#%
>t22(_'?K9M2Ce>[D^LrHjQ#,O(]AZ2</"]A`6l?ChBj]Ak:Zbm^UK;r@n#Pn4BLr\<LS/1<^,$
i`h;Ps=J.$ksP=LBBC\0\s6J^rr@IFPUr`o8jE;*]A":.4"`U"tBDak*&\bot9DV(S@FQX5i%
_d?t#;*q*0W7MVF#Yj,u;onu2D\Hg5VhHnqXa7-bq<lFL;)5(&@(6'B8HM+`SgL#(p0&f:PC
.Bu6gObkH<Ci@h@'/`k-D6&!b'Y^3lh'2.b6"+HFQP]A++fQgX70jWVUM0/P*00SSnbiK]ATPT
psb-_YM7(j(%'.12.+rA+uQN@i^L:Z:+iVfdUFqL;k&ORiN<_:@qLMgHVm,dkj$k*_&0V,V4
ifXEI@YNKQ8Z7/08'@jcMRe_M0D,db3iB^@Es_%Vr.D3`+*7WKg8(dNm/sgYKW4(+0d:fl,P
&>ci)/<GQueg)rr=U/#6E1Qc#KOIPC115Q4.Z+KM"4#N)"i`3JuEZ$%tf(ND;7P36]Ah<G$^R
BZOHk5AC;dH4$N]A+_r^4Hd:o4++A#C3`AdEd&mq77_IP]ALlXkKE8+[oRq0:o'aY3aL";"&]A,
tp8cjTn,?ZbgqU5Z@nW8U`?8kl%@/D+34m#!>eXB?&i8PIO@B(X*Z,$5Se"/:/(t"B!u8C-,
@]AdbsHHO%L(.7(MRWT[b6XSi_lXr)(J!4qrd+>f5^-:chD7lc%pD[;O$%<"'irjI^O(?6f:0
-ucGIF&:NR,*$P\LGJ2f=[9JA(nJ[ugJjC-lB.62N!Y;s;0`oI4:F<i0_6Wk%;ne&L[oW%9:
q#)(FB8'd3TQf\Y0J;0;..o8:,WB4XCG(4\ZV$9O[2&@8o!#o'`_Rj-GonT_4ZKMG.%a?a"X
r%&"Hcid5!`btXQ1<)D==s!kms7rh2p:ib*!/.E*@Y]A@uV8m4'd4iE1Z%1X\N[bGj0]AmskV^
?anGBd%/<=0OZP:WR['eG>>T8TYf#MN1ZSRRk+e)X=+K.QAH&?CMq"koO_#5mbEk6a/U'+TX
r+otP,qZI5$A/G6=DeLWBn4g[k6"GZa]A;n&YlM&MV:i^qj,F.cu\*uZ9K/CCRd&gFqK%YKX<
M/m?00._&`dd'/aU=n.E8XktnQ\+!Z"]AVB9GHa%<%nsS:9=saK3f#0^am[WL&5rku4!6mMHI
dkCM%i\39tV,\..U!XU)">LXBdN,%iPS`#7kpos%0IF6(,Df2ihk1%PceCKB^tP3X.0X52nW
)S1#17fLhmHA*6"Q\o*b6"R;rB9ppCef&?eE22JO`TmZg,CgE``!kSjkfGn>Q7:$>;NF"^3&
@+9IARO?D+[)@?/Vs_7gYD[pS$1?Q>fW=lNR5p=i8$BZ68):08gWI=E)+_()$Z;G(_7L]Abe4
ZU7L-[EL*b5sX-nLT2lR*7m_>Ocl6RcK,qRCN;+^L^`a/_U?CK7'^,8L]AUE`>llUA8NnJi5j
0o;&brqM!&%taP^1T@r`5L@9Fn[OPg$bCKhM'[iY:LHgZ'X@2/co3cpk0]A_+EYCG^7<]Af\eh
EJk96kH]A[e2__D8fX`'A=@u0%#jd'1gOWX#QQ)Hk^Li-tc']ARo.>DpW"dqK`%\I<'!V#cC2Y
Pe!kel`RVTB!:?Irhn6Gu`7cZ]A^SJWI=F0<elTb.t~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="250" height="150"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[KmJ#,<:ATARDgm?1:E-iaPLAqM%n2W+_?lafge,t-m?eC6APuB@bO8:Ou5#G8n\PTCS[&RA4
1[f9RWMi\(C6I4jRJIk1o^=]AW_)&^9;lQ/7m.&@6kbs!!%[(bY@g5!"oG8LenKcJ!)GM'`n@
b_%rnYgU#MHp)QeI[S(8(4F"jBi/UbIi<Q.pcVD7BCKQ!]A5Y6b_&VElJS05d)0M"KN@tkh''
TIu?BeVu_DL"If*DNj`X(ttAX2?V87.`.Ydk9S-3G0=,qqNn#luW#;CXqYa`NUn7eNUYO_(4
.9VoIdNHoBW'Vto"Bcm.Kc2q@6cG:ZLW!5!Z*8kp3e$n#@8X=rcl\F([,i$5_BNe1=QqR%aO
Y5^kmeeC8PI*/0q;3W??b6rnIX=Z+:Ktc@_>@PbdGnSc*Hf<A=N,OI-r%8k_rGYP,L`!eM':
P2nDH`1HdlU&<#HJZ^gG%b^qZs\mpKoq!r<*tS1R\+r(`YE%>"T+HO0_dT&pF9*Vhd:;LjM#
6g$XDBA6\_%(Hej\H,t!L0?C89c)3XUL4W*M]A:.XqYlR(LKi#$&1EX]A@F'HL2!-dGY1e)8K>
*sZjB8e[E'(m.EH5'q@%-n!p<Y]AmBIkIbo"J7n>%EVeLpF)JKfnVdr8!;uWMn;/.A(7X9pjR
K"?ou+<6g9m%=\9_o+XI-"5c*K#-"m=iH>Im$p^g)Mcd%CI`/W=g1LWQ[\sBquIY_B_(+!DK
Znr#8@%uIUG(a*P1FRq_6WK$i.>M2<$DC3J168686@8+sorc:,=nh;j_'5%/90<HYH>#2!rA
$:a0#H($r+J:J6HrH^,ia4sp'uE,?)AO;p\p!WEgCCOdUl9UW9ni%k#tDtT`m!d!SNJV#VU7
\RNk`.r<18[Q3<Yg::,]A>:7o;9pqjIO41a"-[Qo>R2JI*^ah\,@PU/I4l_bmu6[-Kl30%L"p
XYtlZS#,]AiJSbb#MMUm?"h>9EN"9uo6Ffl#XoW83#Ve=Xm&'8Q+k(="Q=qrCVkBI`cONY6Dl
3)46@6fd9HBXXW#>3<@"EVXH=:(^ZcYqA<B]A\')&OCWDoH,7q7Dbh#N+Ge^HG_#&qM@7PN/&
]AG[Z'H5*c;a7jG,"BY&U,.f_[dBnf(mM>lMk]A)eE'L6:,a<$<`ot,X<fTM1:5m]A:<91'^GHT
p>Inl'#o#gMh2NRaTQM2u,qP"I<o4dua#,$GBeF1]AqC&GUGE*6H/@UPS8$J_5`$r-AIqRZ_=
RK5a/O57U$oWgQqmANAE1kTNl*#YdWVQ7o<EUm"q?9n?NDGrV>Fk#X&l+)9)>f4CPOEL)/j/
081d<]A3OX4Rac8CV\f=06`<tZdu0*+tp',c1.3U28g_8Vr3!-!V0:aYb>6A"*!3c_PGg-m:[
V/0thuLO/pP4^qrBH/g#bh6EZ,H@*Up0KKaSJ`=boO@1b.BZ!7gdS=J]AB;U9k7/\k6l-FfO0
7md9-Y;D'NcgCniUp_%u]AFN&3!P@!+3<g(O+6\3o0$g:D(4kM>a(\Z(^:6L>$HFrKE\(u2>S
cHJ;s7J%Q%aoO&d=cX:P)PVcnK[9F#c[pnV,7G<GabIgi,1dK>9^0ADl5"1n9YGmGRCQ['>@
U8'eO0#['V=2g,_eNQL#`M'H^rf0h<nlH4%^6-qj0iqHF9HIc8um/mO1"Q&%/>qEgrQ;U#tP
/IJ@bk2SD)G+WnHS:f*SdPTaQ)NpoiFm$$5\5f;<GdfOdm]APLmHXVRCJlr0ZWNQU@kXL,n[Z
6es+a%G:EQ<U7LW9pYjniY-$3Fh5N>mpqS&?$Coe6\ftNA<.C(4h4ERZN7PdZ:CDh'$L'e'?
D$DYrp>+aeESWf*/="5c0-Z,r@>GMs.<jmW=uDA:HAhJ8@7k:cnX2L^\/m=Ns/oc.`3l6Vq+
598<,Fd6e"bpOQi-I$SV>WaL7b2KJak!MCmr$;.!Orh,CTM@b@-`c=&[TM**k?iM#nq).n?(
flRG+@G&)Y:""f2u1.qdfT56h$bT`mkn\K`+Rm?R(p1AsL@m.'=N,XY6Ap$i-(s*$tKO@_P,
jT>^SWBJ&%]A-tr^/[7Moipse<p'uQ,(N+FX=?3l9!6fDH\$>LFqe5:^VUsuT=p"SP^n2@r2_
bBaMrk1?H8V'W0Pu*i-Yc<*0pCfFp)OZ4<Zjk,5gaB8IDOA&`,pLB`5CZa`fQu(@#$06`"aQ
FYfjf]A+sgK>3&fc`i)0ck()a()4?*"DPmJNrHfC,H+KU*0BupheQ3RR?"4bTWDo6\O[l;$d4
I(aDXiX,lt7Pr0b?_7oP:?"C<\f=_LeTj[Hk/UI'C5pNH@n2GVWi>3Cn9I`7+\+[juO#N`=9
AF`7f6k6XV\U*GL[jPaJY8O`hh6h"//8I>R@]A[j6hnpmQO!3^C4b&WX23fkqPkfY,TrsChDV
i=^0&q"78A!,:EbQThbE*!>4.rj-+n6?)0VZ`#A8e)a_Qr9^Xf%cL#q2XJZA)UFsKhuX([El
o.8/c("^fP+W*6%V'jtK4@)E."",+('cqA"Zt1V+OVoHN:M1VGIY)%!P;'c[IT0T#T01.;@+
.d)CFH^c:>*$2#K]A3'nScegu,F%3ZI+tk'b'Ji<L2?TO+*k,5aTEc)qnf4]AABk-.D;%6C)75
J.ihJ%W&h9%G,i8+JfYX3sR78>)D`N7G%aJ/PnkS,4^CN*GUH=W(G.S2p84H@6'!:G\]AYY1i
13\2(YkeuXMA^*giEfm/p#?0@l_`UI.^t;p9jQS(U0I%g'Tg9Y,*-0BF'e\$E52%HVPGf:P;
jUJ$<9d&8g[bZ:#hCnsOr*r$gmglfe3KIUB"\b5JM=i7+>`UjEV'0/PKa\kH$;RFZ7lVV&=5
YG3NHuno^Kf`I6XioreNqK[7#Zo9%Z@<ASUtb74Z`^pJ-qJnT$7$Mt"c.KV)o_Cjm7"NDfr"
.tZDpdBWc1.&Dl2f^f=niYEGH""tnaiR'#1dTN/\6;g5\[ESaQBSR5[l.LoVa0S_P6Yc\[ki
Rg6H8^luFGkkU!.:<h7ClsWe<UC.)\`"kc4S@pPY\f7.A@d^GcRTg%4]AH.`g!R9:O,n/@LHB
\ClaBQISP4A`ZOs"`;S]AK,7BM6iUQu1G0W&7C3/^'$rue'XI_u:acWFHSZeSp?[DJ`TE+nT>
HQX@e#mfH:"VH2*@\"$@D7`ALqba/$QFNm5kk&D$ioMH4FD-=9S?S3h6>a#3]A!GRC]Atpe03n
U/(BbO:3g+leJ`QOgfPI`ipk11BULrF?gG.;QmZ]AI,F:Y7\^"8m:@k;j7b0FP)[:)p:@so"!
KBfQ(9PL]A`eZ/]AhP^<Gm.A7rD&p`HdC2O+GDY%#F@GPppUl%j3"T"u1\*PX7X$$Lak,P<i9>
`!7?p"AOAR*p)?Hp9^g.E6?323q.c(?%*HZC&f?S[>of!*D_cl`k=dLGYZ=7,uD5,DN19%m7
j6@PCT9\iQ,T+?r3Zh.lDT7R&[_PWW5+IHu#[)S]A6\p$;OE(_ci=BsInK"epF[aXnKkm$bn;
2R?['X_e,56*gS&;\ETT\'Y50N^aJ8]A<[Eg(J)rgr9@\#k?W3Zl>PfF_ZB1!/-ItIZ%45f3O
JXO?2S=e5DlWOWN5\CQ3JuLGonn9!JfRP]AfZ5@-]AJU^cF-V"dAK0Y4=Qida)OFf$K);'"Iak
=6aB<Y]Ah5fHhJ5gQ,<(_j=G-@!F^j@o+P,4e$'V#n$rRn#D4=X9'N#'2R)b-@Yruj#&G+=R;
SCup8E-CgP(VZKO]A!o-=A+HG#!Ga)oYZl10[g4AmK0e-(LkRd3ZU2VbdZB-4=/2@:d=j7b3Q
_<5F25pC+m.f4&Q'&Q9hU\/etSf*a;'46YMb1%]An)X^[Z,6V<Ur1BD0GlMX"QK)f4';ojS[#
&Hl\aF-?h,O=Yh`^l@W8rp;q$X4UI<6B,!8\,T0Cdg/g$/d,3C^,TU;nJfb@r4jA[rI(p'4[
:h5#!LV2isblqH[i`]AqI9053;B$KEArT0LjMuO-AoQkkaY$CVB`1*fHaT-7,Q/Bl9<@j]AuO"
02R5?'\T`Yqap7Tb`Fg^C^s/Qc.F]Ak(6&BYHp">QEV(X6I_XWPi0dj\:qMd%Um!&n**KRVMu
[>P,g]A"UI,0X8iIm$K>\#(fE9ShV+;n)C8Y,Q4F3fPt<hkHsQs]AQ7hCEtE+=U3\,FhKHDqqu
1H?*1RG=:&V4,t@eMXb!j5laL?VaS;Zb/:,?WVFjp7,)Zk,QKO178^uPWPTr1IXng"PU%a=)
Lj^$+!4e[4n4_/E#`e)Id]A-@ZGV#2A6gWkZmS.9T`XLVQAW9p!3dQ&?(aFRr02E%r9='k:k4
*aPLmG7=F.E`(`!;%%NeRR_%b3]AjZn/U%FEbK5'rb&#m,Vc"X<%P6=DGapaA^E8]A*'^Y5r,E
!3,W]A(c6$%"YQb6:s8T%:(:Y5]A_.4/8h!V?%DJVA;2O33W@b;;lE47+B&'T^iV'H*..<9`R5
@q@\\Gq&V/oZ$I!c$13u(f%aG*ebqTTB&dB/>3V$BmscDuerlHW7p"YeY&Ye:muDVTW\X1*!
T<BT+9Ie#X-94U7g#L=f>TAf*lfPrcYXrZGZkFc(+#Nm!?IjlQ[%MV1rO/J&Xh.Sl\^Kj/@<
8MN19ack$+_!HH[@)8%C]AKZ@',P_9!$D=CM'hb_2Q9_Mi!<+\E>Oe-4BV[e['Akb)'+O*9@$
;j%gU^Zi"KUN1h_s.D)(]A'HrRf"BkTh^1\e5]Aos3W+*B0q1b3la:)Ve3-0:28#DR<0rnRUeF
0ht$hbda#c?,FQ3g&<l1eWX7.p^E"4i5l(?*^E&>4Y8?(5Ise5+`A*#+969H#gGt%]ApCM41k
f9qS@O^mU>a%''CPUl[=_"P1uN8/$>e3L!\[l#>h\BLPqBp"`[Jh0p))T+<QfEHfbY=/7Z$F
=La02I57ArU*cF%KSX$:Cq%aFsm-<NP#@DT:/[)e]Ag%!rj,X3YFD/K<#J\RoA.m3NMpo5UOL
$u="auI8nLqKot_G.f&H*0-1bu*J>0(6k)GuC'EQ\g>"hSZ+r@C&,M!G^b_LgWdSn(mcl[rQ
'!6a8!X2h0f9)NT06hioZ.s3]A>Kd(/tASaR#ja,3c_/r+ojN5sA7)u7&;A&.bi05e[_m&TmX
6M!C(^X:C0c!EJWD$8n$-"5&`LBFEA20tDoBeeC&En"P0",e;*rgSk^1K.Y#UU"(]AW\#T@iK
^JTl%sMJU,09E=;DXWEd!\p/6XGS,8QGP&RT`PEfXDB6j%5o>HT:PbD6%CI3FE97^gEKicIp
YlejWEjgutp%[,RoA3JPPEXaWQ\1p=^1f/\"Xq#[tD>9T41`SHh/Ik:DZD&%N@'A-=ZH<eYk
,pZrRJGEtgpikK>1Z<_Bb^e5<>"$r]AQcD&<:6B>cJm/AMVKN1(^0aaahOEOR29*,4Co'1,I>
,1n3fKq'"B&Y*>Esd"[?CkU-7=FNeqT$hAGTXO6b3q`F-cu`:Q=$<Y[TaUOmu`OX"m64k1GT
rN_e5F,:dDKKEs(@Ej3Lo_[Ud5C$?uA`&]A^!=k%,dpj+C3I3`qV76[hBE9@LY^(>#/.D@7qD
6L0JBX6#_c1M5X8hasi=R\Z(]A5K!iiac5_`eTYqI.S/Z.$;IZsO3QFUI-<Kd]Ag7Tu?\)/U$F
7IOu\"6?,0$<Rq.E]A5Y9q-C=".kpclrUg;!Ef##quad-c[cHh'6LDi60))j%\BP_'V^T',"n
02$]A:1lM8ETEPFZl**[LJt]A-r)^$_+ma]AWSLP-2q:TsU]Am2GP9d?_2TPG<=eonkUq"1h(g#V
Yh+]A6QO7!e#./fJ$8Ir4UKTI]AP;m>.V%B/uGK>q<PF\]AJ=+F3mRXi&-j(Km*WumT2-]A_O;EN
GtVdU+^9;""7/bW*RIf)aSW:8Op.0_lRW=7=\JS:BUt6:2=SL"@Xh4-H1'jZh!&YJViLY^$d
'^oUBo.DcWNG:#KP'f$F)r*ebMrU"^c0VJm'FF&Tf>IiH$H7$b,l>34^Co17iB(AAInZG6j)
,&#h%QW8!(0)e`ISqmq%f<W/DY_k-9Y+j&r*UQ\u>lnN.<K(AR6%-Ad0Io;$DRWF*O6jr,6O
m&fr$X=,/8H.R@%8MC:Z<62<`7"0dgsN;+X]AIQs\UYBo^;T8k[0.P>lPJ.U=)Wp7d1$fiTAY
X%i,%nTs"r)m-Zbo\^G`Q6f;Er+02Ok<"LXWdo#:U9:nWq.4mW`ooC,^,O4#Ls(t2,\bP.J&
Vmu,9:uK+CVE(J/R9M*.7rkQ:<;iPP]A%1?jG8u6JK3GAVf`kfEUL/:`k(S<<*Lb=o^;>.Ud:
^`l'b9?YcHm`doW%:`Wk>jsf^N*)2Hf<q(Fq^"E*kh/qX);m,$-A87s(flA5KI/5p(5oM`GV
\LXRj]A+s)N0htDPEaSQD@2nBf^URq%F@0_Ee(q:Ct=I(@C(/).3I+@S[Q`C`0p)71;DWkA/e
8*N83_pm38pI/0l@C'r0B+Y.;FIb`VZlu!gZhT*X$'$N8uFV7\:q2;\_j4ac?U@(SOp"gftk
p==.k,`*OfBLKO3[3\6$Zsn-jL_`^1#tJiDT2P<If-,.rNQH+N1ubl=SWr@snE%^*CZ1E-J7
J!ubuNtbjeqCS2!<-S&,,+m'7Ms<Dq/Mo_3O7RHiHBf/Q:lk'Vif_aI9;8.batIe1ao,G/@7
sA6$Tt1I`'SX/]ArU#)khi#"Y1c3CqOU^3rRF%+g^VSHJ[:W\3[(=/1%^d"MHCoIpKs`6B<td
'b9`aRX[GJgfCA]Ae3tD7^Nc3ZKE6Wt^:S+0%C,Jg2V6bk'1/WNNU(/6W3)4$;>u0st2Cd@t4
*#M\MI'2F`>c)g4H90SW:!(Me;NH_l[MY6dc!4NIqb9+T'dG5'i+ZY!`Scn%AHhrLusQ+s+k
rl@aIV^GhbOjon4:S`h.6NC"*a4a2Q#7d]AV9H*]Apk^+.3"2qc*F$RR$uNHEWcCGPi\*;ltV`
;r^Xr<Jm`QU0JU/s0mNSKtZN24?78_k+>[LS,3calLi+lbq'Y#o7u1\k%DecaP^.T4ON[Pl2
?+-9goPgF'mbq!e&C-Z1Mos?Je\hIui%Iqu>0@>m0Z4l>qmB4]A2J3\.0M;7^k,mY.:P>?>Qh
FIEk(!fa'MEpLm,Z"LIoAo0gnh&ci*cTMm\Dp)eG4q7d3Zb=:&81"8tn`#4144.W,2h>a!H5
G.FX?H&a\208*^=3Y/.^IO$s2-eT`PlD^KlKI,[G5b7L>b=PHor/do,#+UP7:,/?bMAQNT[n
==#'_j%9ET(;ghXE^ogH31?$c6`!Q;,A.nVMN">V1WTJHO;C1%]AFBU%f=r:16!U$<qc*^0oE
([2t0nSl(.#O,L*3%Cba56[B3HZO2[M)pIP*ESkOS2fc60G/]AcIF4qK#I=1`=S:A\]A$@-tdM
WRB53"hD4H]A1cLu8@u=gqF\_o@dt>\e,\f-5&Opt?P[bZ\9GFXqNQ1OmQc::j%0]AL;o@=I&F
LXO0_sraAr3:Uj2)lIF;3LP"@bb"",Cr2Rkej.u5k$ka['*^d4YOJ354_'PK*C]A(B#OpZFXY
Y>h4M71Pq7^oal6h0CNnu0Z,'U_M/_J.&*,&d:5AEP-?l<3L!G@BjD]AZd(TkGiUr[)Lk!q<2
99179Bg6U?lAVMbokdokt'D7Ra37D:e")0*r[M5C+B/><U(I4"0\^eBHH/1c/5K#(DeT`NVH
WZ;PD-uC18Ho#1`#V_^g-6kMK_)1ISP>@CsRrXWqmr&7ljaXIHam=Y?Q3tUH=dU5kYEf3F-H
s@N9K?'XU=59QH?o;^'e>"b-C`*EoRZ!2IkJr)U,mpSPUkVpSgLur;&CuEXU'<M/]AaGR;%/+
;'LIsB*&b:)j'-8TO]Au0,W,;[]A_Ei3SIOXp[-El:L%j%lGUZ+-b0R72VJS\3M(3GD:Ln)bWm
tn4hL>!NW>Ac`.&t(qXG>uB7@Bn8DXDp.D0EG;a(Y!8kV2(pb5oQ@C"kgGq:M;DF5#"_MU/t
VlJ*Io._bi19,+AGUNILf>bB&=M>gDkML?,q<JFE6&8+h;K6#lNQ)n>\3cQ5[6!;oa7+2l6;
k+jK@N*j_cAC3oO?#RZD@77Pn'Pc8Djnu0Yd^s$6_)d.=dm;<rZVAQRiPHr+fU96@!L@ER4>
7C8-[temM/D[nYDSp`m's!u)]AJBHfOSOOXptZjo5EC_`;HSh1DZqse'VELWqe5;'17^#VcdN
h\R/;V.P]ABD5?k(@^=BF3r^(/aPXS='`2)="H=c'gAonoXGB\4SYR;/2FV0=^aQ!c/G&1@Wo
@JcgNI'KAc*!&'q:OXRQB6iI+r<AAUeso6V$osJTl$rq0Rj:<q(hSN-;(^.hM#!D(d]A9Gf%<
n!>r00_;mP@]A^DDX-iInZ"#dqjM9N#ghm!:@1;R&jqI8=?6&ggHOLDui*JPg!A!1baVqOo)q
<*MRmqfVk??!B[TnWU#q/PAWm"r<Cs`+%+3)Z.:8qfTVo[Y:XKVQJC<&;*l:I#mr?^6c(q;9
aO#iXVr#+DIWAVK2BWA\WnUJ77&tc]ApG*+kmXG*%H$&lXs7)/AbIt(/=OgBQ&S&O6tb,HMi/
8PSbSXg\%piHr#(Q<5h=^=MP__>4+XrOW<ahc;**]Ajj]A4+m9SSnY=2t<)__p:qlmM`a!f:+D
]Ae,#)J!?.,f<<:2"clbJW7E2ONbs?k=,3q@oYQr"/9c^Oeafq6sDuGPo*+p:Gg]A;:Va>QA<3
%g+3GkFa6sH>6BP&8VSTGM+Bs=V/[mZSgO-%#H=KWqPnme:pho:l,HK2dX#Q_W0']ALa%IM+"
`QPNPd&cU-Pm+#IB>SOE/T173.=6/EkP1+>H2<k4@h?F&/8V5\l^"ChSe$rJpZo3-bP9G4fC
pB'Uh/Q=q1A,e8&t,`S['>E="3r1B;]A:H]A="s1=j%cUc]AWU`T3FK2dQ13F_Pp'Q]AYRF1PBHG
/-uC@@J)kXsP[*FucL98Dc*%SA^]A-91'+]A^I,+Wd?1+e$(b]AXBjh$[K6btK+R<%s\*>,EU[/
-s!J'_=Kc(TI`5<3Km58pgoYIMe`G)Q'55Zo8,d2.Gd&*`Tm=?Z7>Um?Hokl5"JjJ-eCT7kh
<Fr5ejKh\+f#2TM9AmCtD8B9QIM#EXg]A#bQCsARcpVCo?(daS+B7bfbV1N3DjYYBI<2.8>;u
`5!j/OiPNKiGVn5Sf_)sF_t]AqV"9]A*Ek-9bd'-ud</GcG!*&:rLa75\r/H:PaY?^d0<s4!'o
k?/)r0^^l5HthGZj6\Q+<h#r,b,G<n"[l`hRWF%ga4uoiRub!@\hdhIPF.Tr<jMNMMR0h9>[
e5ITmtE0F2YSXEqE8X)pPMu,R?/Ap%QUhQM.JkaYs6?^:6<LPZ6<)nI3H\Ft`=,?a#Yp8t'(
4S&rWr/pi4@rH7$4TTJ4KY3U75HcoTnfZZ.]Ap!so4K-m;)$[q"TkE#ZOO#i8$Mh:2niBNP1&
jd*V9fA!7UhkmK63b.qTAaZ4pt^0>sg.\$Sr]A/V`E[+T&FmcW6?j#G4gQA2?YtbE"`V,[ob5
.Tob*^r'G3EZ:hT!GmW<giU:B&aUY4<^GYM6(8#:*d5+plicImL/Y4rj\(.P0-AC#QpJ.hee
:\Y.=Jb+mA$W(8!2Of(kj?$eAaQtQhoGk'GI>\@Y5'N]A$l>[S*@90jo%qBB"hC@>/#FeRh*V
!+0XN%r#f$_>1!S)LYAb<^/5]ANb!f9;Zd2p)TJU>hIep^k_9mYU)/+I(>n<7/QC$;<!@P.'`
VA",YU''JP6<(g_`qnQCtiEIprDYY$A\6G[(uC=-ssM^AOL_6K!,`"Gc^r!4`eb"?3@2b\qF
)$HG9d"d6CVYbLK'h$p9YD2-jQA8s;9!Y@dhjO9fQ0R,&TP5UpnVCC^*aZ.m5T,Pb/?Wklt?
l1F!3FPY;6)[?S2+oRG8`0MctN^Q/Lm0"mEOXULi*uG0.lL5^D<Z]Ao(D%W8i>Yc[Q^lN&7+6
K*biE7f`2)8HG4'4/C\pRoXMtEph&)OM4nerifRWBJ6^IrX2kC_&!3^-]A'n/220**L"S1V)e
HQfTl9VeCQMV1mt%!HEZE]A)/nW0=)cq##WbKkb:#;58.@dYe^`8VofYZk"t;U.+ReaO2M2N5
%(iqjB6`%*F%.`UH3]A/DhURI@'$O[YRWc8,D16u!>)Al#;+-:[,Xi7S6*kC_og^A6[<1RY,=
dL01$(oTjJ-:OMQ><)oaAkH^JpZL)n7=CRDL+ro%C=+hZV.$JuEh?Q+ZQ3qSZWH-8.g#:FF2
n!p=SB5&S@9UKtapA(9Y6aYeLXkXB;G.j4tOPOMX*GSh(!?RRH74R\B0<d6;XHuB.jW[0uAU
Eu0I-Zc@\GC8:5;Tb^;gpprSY[,P1C3o9h+"Y-nd?0EY:C:BJe_32@qhhpcJ"hadZ9EEF^B^
2Giqg#O?fB0$bP"N`#FK!EKO%5U8roP/a^nr+#A65SY(oSf0/oGSO;9UB?o6lh=iQ]A^^:g+D
F_mB]Ad(JYoP;u03)A@]AU.EkuOUQ011YY!oFqo(rdUVa3?@5R5&uC7iXEn+c.X#%dLY%T`IMM
K2b(NWX-g+5*GM"^$H>KOV8McfKmC[:OmF^P"2T"Xs/KR?9*60a3YrDF1-`]AZLIoa98KDB)E
Xb-7<od[>:rK?*XrNbMS?mM"I&`pHpEU/I"FDBnP[6B9!kK&sSFcBTGBCF\\DK#9/1TEJV>"
+rfWQNOt8DZ%!KEkGk@`KP=Ht.B?IfT~
]]></IM>
</FineImage>
</Background>
<Alpha alpha="1.0"/>
</Border>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[KmJ#,<:ATARDgm?1:E-iaPLAqM%n2W+_?lafge,t-m?eC6APuB@bO8:Ou5#G8n\PTCS[&RA4
1[f9RWMi\(C6I4jRJIk1o^=]AW_)&^9;lQ/7m.&@6kbs!!%[(bY@g5!"oG8LenKcJ!)GM'`n@
b_%rnYgU#MHp)QeI[S(8(4F"jBi/UbIi<Q.pcVD7BCKQ!]A5Y6b_&VElJS05d)0M"KN@tkh''
TIu?BeVu_DL"If*DNj`X(ttAX2?V87.`.Ydk9S-3G0=,qqNn#luW#;CXqYa`NUn7eNUYO_(4
.9VoIdNHoBW'Vto"Bcm.Kc2q@6cG:ZLW!5!Z*8kp3e$n#@8X=rcl\F([,i$5_BNe1=QqR%aO
Y5^kmeeC8PI*/0q;3W??b6rnIX=Z+:Ktc@_>@PbdGnSc*Hf<A=N,OI-r%8k_rGYP,L`!eM':
P2nDH`1HdlU&<#HJZ^gG%b^qZs\mpKoq!r<*tS1R\+r(`YE%>"T+HO0_dT&pF9*Vhd:;LjM#
6g$XDBA6\_%(Hej\H,t!L0?C89c)3XUL4W*M]A:.XqYlR(LKi#$&1EX]A@F'HL2!-dGY1e)8K>
*sZjB8e[E'(m.EH5'q@%-n!p<Y]AmBIkIbo"J7n>%EVeLpF)JKfnVdr8!;uWMn;/.A(7X9pjR
K"?ou+<6g9m%=\9_o+XI-"5c*K#-"m=iH>Im$p^g)Mcd%CI`/W=g1LWQ[\sBquIY_B_(+!DK
Znr#8@%uIUG(a*P1FRq_6WK$i.>M2<$DC3J168686@8+sorc:,=nh;j_'5%/90<HYH>#2!rA
$:a0#H($r+J:J6HrH^,ia4sp'uE,?)AO;p\p!WEgCCOdUl9UW9ni%k#tDtT`m!d!SNJV#VU7
\RNk`.r<18[Q3<Yg::,]A>:7o;9pqjIO41a"-[Qo>R2JI*^ah\,@PU/I4l_bmu6[-Kl30%L"p
XYtlZS#,]AiJSbb#MMUm?"h>9EN"9uo6Ffl#XoW83#Ve=Xm&'8Q+k(="Q=qrCVkBI`cONY6Dl
3)46@6fd9HBXXW#>3<@"EVXH=:(^ZcYqA<B]A\')&OCWDoH,7q7Dbh#N+Ge^HG_#&qM@7PN/&
]AG[Z'H5*c;a7jG,"BY&U,.f_[dBnf(mM>lMk]A)eE'L6:,a<$<`ot,X<fTM1:5m]A:<91'^GHT
p>Inl'#o#gMh2NRaTQM2u,qP"I<o4dua#,$GBeF1]AqC&GUGE*6H/@UPS8$J_5`$r-AIqRZ_=
RK5a/O57U$oWgQqmANAE1kTNl*#YdWVQ7o<EUm"q?9n?NDGrV>Fk#X&l+)9)>f4CPOEL)/j/
081d<]A3OX4Rac8CV\f=06`<tZdu0*+tp',c1.3U28g_8Vr3!-!V0:aYb>6A"*!3c_PGg-m:[
V/0thuLO/pP4^qrBH/g#bh6EZ,H@*Up0KKaSJ`=boO@1b.BZ!7gdS=J]AB;U9k7/\k6l-FfO0
7md9-Y;D'NcgCniUp_%u]AFN&3!P@!+3<g(O+6\3o0$g:D(4kM>a(\Z(^:6L>$HFrKE\(u2>S
cHJ;s7J%Q%aoO&d=cX:P)PVcnK[9F#c[pnV,7G<GabIgi,1dK>9^0ADl5"1n9YGmGRCQ['>@
U8'eO0#['V=2g,_eNQL#`M'H^rf0h<nlH4%^6-qj0iqHF9HIc8um/mO1"Q&%/>qEgrQ;U#tP
/IJ@bk2SD)G+WnHS:f*SdPTaQ)NpoiFm$$5\5f;<GdfOdm]APLmHXVRCJlr0ZWNQU@kXL,n[Z
6es+a%G:EQ<U7LW9pYjniY-$3Fh5N>mpqS&?$Coe6\ftNA<.C(4h4ERZN7PdZ:CDh'$L'e'?
D$DYrp>+aeESWf*/="5c0-Z,r@>GMs.<jmW=uDA:HAhJ8@7k:cnX2L^\/m=Ns/oc.`3l6Vq+
598<,Fd6e"bpOQi-I$SV>WaL7b2KJak!MCmr$;.!Orh,CTM@b@-`c=&[TM**k?iM#nq).n?(
flRG+@G&)Y:""f2u1.qdfT56h$bT`mkn\K`+Rm?R(p1AsL@m.'=N,XY6Ap$i-(s*$tKO@_P,
jT>^SWBJ&%]A-tr^/[7Moipse<p'uQ,(N+FX=?3l9!6fDH\$>LFqe5:^VUsuT=p"SP^n2@r2_
bBaMrk1?H8V'W0Pu*i-Yc<*0pCfFp)OZ4<Zjk,5gaB8IDOA&`,pLB`5CZa`fQu(@#$06`"aQ
FYfjf]A+sgK>3&fc`i)0ck()a()4?*"DPmJNrHfC,H+KU*0BupheQ3RR?"4bTWDo6\O[l;$d4
I(aDXiX,lt7Pr0b?_7oP:?"C<\f=_LeTj[Hk/UI'C5pNH@n2GVWi>3Cn9I`7+\+[juO#N`=9
AF`7f6k6XV\U*GL[jPaJY8O`hh6h"//8I>R@]A[j6hnpmQO!3^C4b&WX23fkqPkfY,TrsChDV
i=^0&q"78A!,:EbQThbE*!>4.rj-+n6?)0VZ`#A8e)a_Qr9^Xf%cL#q2XJZA)UFsKhuX([El
o.8/c("^fP+W*6%V'jtK4@)E."",+('cqA"Zt1V+OVoHN:M1VGIY)%!P;'c[IT0T#T01.;@+
.d)CFH^c:>*$2#K]A3'nScegu,F%3ZI+tk'b'Ji<L2?TO+*k,5aTEc)qnf4]AABk-.D;%6C)75
J.ihJ%W&h9%G,i8+JfYX3sR78>)D`N7G%aJ/PnkS,4^CN*GUH=W(G.S2p84H@6'!:G\]AYY1i
13\2(YkeuXMA^*giEfm/p#?0@l_`UI.^t;p9jQS(U0I%g'Tg9Y,*-0BF'e\$E52%HVPGf:P;
jUJ$<9d&8g[bZ:#hCnsOr*r$gmglfe3KIUB"\b5JM=i7+>`UjEV'0/PKa\kH$;RFZ7lVV&=5
YG3NHuno^Kf`I6XioreNqK[7#Zo9%Z@<ASUtb74Z`^pJ-qJnT$7$Mt"c.KV)o_Cjm7"NDfr"
.tZDpdBWc1.&Dl2f^f=niYEGH""tnaiR'#1dTN/\6;g5\[ESaQBSR5[l.LoVa0S_P6Yc\[ki
Rg6H8^luFGkkU!.:<h7ClsWe<UC.)\`"kc4S@pPY\f7.A@d^GcRTg%4]AH.`g!R9:O,n/@LHB
\ClaBQISP4A`ZOs"`;S]AK,7BM6iUQu1G0W&7C3/^'$rue'XI_u:acWFHSZeSp?[DJ`TE+nT>
HQX@e#mfH:"VH2*@\"$@D7`ALqba/$QFNm5kk&D$ioMH4FD-=9S?S3h6>a#3]A!GRC]Atpe03n
U/(BbO:3g+leJ`QOgfPI`ipk11BULrF?gG.;QmZ]AI,F:Y7\^"8m:@k;j7b0FP)[:)p:@so"!
KBfQ(9PL]A`eZ/]AhP^<Gm.A7rD&p`HdC2O+GDY%#F@GPppUl%j3"T"u1\*PX7X$$Lak,P<i9>
`!7?p"AOAR*p)?Hp9^g.E6?323q.c(?%*HZC&f?S[>of!*D_cl`k=dLGYZ=7,uD5,DN19%m7
j6@PCT9\iQ,T+?r3Zh.lDT7R&[_PWW5+IHu#[)S]A6\p$;OE(_ci=BsInK"epF[aXnKkm$bn;
2R?['X_e,56*gS&;\ETT\'Y50N^aJ8]A<[Eg(J)rgr9@\#k?W3Zl>PfF_ZB1!/-ItIZ%45f3O
JXO?2S=e5DlWOWN5\CQ3JuLGonn9!JfRP]AfZ5@-]AJU^cF-V"dAK0Y4=Qida)OFf$K);'"Iak
=6aB<Y]Ah5fHhJ5gQ,<(_j=G-@!F^j@o+P,4e$'V#n$rRn#D4=X9'N#'2R)b-@Yruj#&G+=R;
SCup8E-CgP(VZKO]A!o-=A+HG#!Ga)oYZl10[g4AmK0e-(LkRd3ZU2VbdZB-4=/2@:d=j7b3Q
_<5F25pC+m.f4&Q'&Q9hU\/etSf*a;'46YMb1%]An)X^[Z,6V<Ur1BD0GlMX"QK)f4';ojS[#
&Hl\aF-?h,O=Yh`^l@W8rp;q$X4UI<6B,!8\,T0Cdg/g$/d,3C^,TU;nJfb@r4jA[rI(p'4[
:h5#!LV2isblqH[i`]AqI9053;B$KEArT0LjMuO-AoQkkaY$CVB`1*fHaT-7,Q/Bl9<@j]AuO"
02R5?'\T`Yqap7Tb`Fg^C^s/Qc.F]Ak(6&BYHp">QEV(X6I_XWPi0dj\:qMd%Um!&n**KRVMu
[>P,g]A"UI,0X8iIm$K>\#(fE9ShV+;n)C8Y,Q4F3fPt<hkHsQs]AQ7hCEtE+=U3\,FhKHDqqu
1H?*1RG=:&V4,t@eMXb!j5laL?VaS;Zb/:,?WVFjp7,)Zk,QKO178^uPWPTr1IXng"PU%a=)
Lj^$+!4e[4n4_/E#`e)Id]A-@ZGV#2A6gWkZmS.9T`XLVQAW9p!3dQ&?(aFRr02E%r9='k:k4
*aPLmG7=F.E`(`!;%%NeRR_%b3]AjZn/U%FEbK5'rb&#m,Vc"X<%P6=DGapaA^E8]A*'^Y5r,E
!3,W]A(c6$%"YQb6:s8T%:(:Y5]A_.4/8h!V?%DJVA;2O33W@b;;lE47+B&'T^iV'H*..<9`R5
@q@\\Gq&V/oZ$I!c$13u(f%aG*ebqTTB&dB/>3V$BmscDuerlHW7p"YeY&Ye:muDVTW\X1*!
T<BT+9Ie#X-94U7g#L=f>TAf*lfPrcYXrZGZkFc(+#Nm!?IjlQ[%MV1rO/J&Xh.Sl\^Kj/@<
8MN19ack$+_!HH[@)8%C]AKZ@',P_9!$D=CM'hb_2Q9_Mi!<+\E>Oe-4BV[e['Akb)'+O*9@$
;j%gU^Zi"KUN1h_s.D)(]A'HrRf"BkTh^1\e5]Aos3W+*B0q1b3la:)Ve3-0:28#DR<0rnRUeF
0ht$hbda#c?,FQ3g&<l1eWX7.p^E"4i5l(?*^E&>4Y8?(5Ise5+`A*#+969H#gGt%]ApCM41k
f9qS@O^mU>a%''CPUl[=_"P1uN8/$>e3L!\[l#>h\BLPqBp"`[Jh0p))T+<QfEHfbY=/7Z$F
=La02I57ArU*cF%KSX$:Cq%aFsm-<NP#@DT:/[)e]Ag%!rj,X3YFD/K<#J\RoA.m3NMpo5UOL
$u="auI8nLqKot_G.f&H*0-1bu*J>0(6k)GuC'EQ\g>"hSZ+r@C&,M!G^b_LgWdSn(mcl[rQ
'!6a8!X2h0f9)NT06hioZ.s3]A>Kd(/tASaR#ja,3c_/r+ojN5sA7)u7&;A&.bi05e[_m&TmX
6M!C(^X:C0c!EJWD$8n$-"5&`LBFEA20tDoBeeC&En"P0",e;*rgSk^1K.Y#UU"(]AW\#T@iK
^JTl%sMJU,09E=;DXWEd!\p/6XGS,8QGP&RT`PEfXDB6j%5o>HT:PbD6%CI3FE97^gEKicIp
YlejWEjgutp%[,RoA3JPPEXaWQ\1p=^1f/\"Xq#[tD>9T41`SHh/Ik:DZD&%N@'A-=ZH<eYk
,pZrRJGEtgpikK>1Z<_Bb^e5<>"$r]AQcD&<:6B>cJm/AMVKN1(^0aaahOEOR29*,4Co'1,I>
,1n3fKq'"B&Y*>Esd"[?CkU-7=FNeqT$hAGTXO6b3q`F-cu`:Q=$<Y[TaUOmu`OX"m64k1GT
rN_e5F,:dDKKEs(@Ej3Lo_[Ud5C$?uA`&]A^!=k%,dpj+C3I3`qV76[hBE9@LY^(>#/.D@7qD
6L0JBX6#_c1M5X8hasi=R\Z(]A5K!iiac5_`eTYqI.S/Z.$;IZsO3QFUI-<Kd]Ag7Tu?\)/U$F
7IOu\"6?,0$<Rq.E]A5Y9q-C=".kpclrUg;!Ef##quad-c[cHh'6LDi60))j%\BP_'V^T',"n
02$]A:1lM8ETEPFZl**[LJt]A-r)^$_+ma]AWSLP-2q:TsU]Am2GP9d?_2TPG<=eonkUq"1h(g#V
Yh+]A6QO7!e#./fJ$8Ir4UKTI]AP;m>.V%B/uGK>q<PF\]AJ=+F3mRXi&-j(Km*WumT2-]A_O;EN
GtVdU+^9;""7/bW*RIf)aSW:8Op.0_lRW=7=\JS:BUt6:2=SL"@Xh4-H1'jZh!&YJViLY^$d
'^oUBo.DcWNG:#KP'f$F)r*ebMrU"^c0VJm'FF&Tf>IiH$H7$b,l>34^Co17iB(AAInZG6j)
,&#h%QW8!(0)e`ISqmq%f<W/DY_k-9Y+j&r*UQ\u>lnN.<K(AR6%-Ad0Io;$DRWF*O6jr,6O
m&fr$X=,/8H.R@%8MC:Z<62<`7"0dgsN;+X]AIQs\UYBo^;T8k[0.P>lPJ.U=)Wp7d1$fiTAY
X%i,%nTs"r)m-Zbo\^G`Q6f;Er+02Ok<"LXWdo#:U9:nWq.4mW`ooC,^,O4#Ls(t2,\bP.J&
Vmu,9:uK+CVE(J/R9M*.7rkQ:<;iPP]A%1?jG8u6JK3GAVf`kfEUL/:`k(S<<*Lb=o^;>.Ud:
^`l'b9?YcHm`doW%:`Wk>jsf^N*)2Hf<q(Fq^"E*kh/qX);m,$-A87s(flA5KI/5p(5oM`GV
\LXRj]A+s)N0htDPEaSQD@2nBf^URq%F@0_Ee(q:Ct=I(@C(/).3I+@S[Q`C`0p)71;DWkA/e
8*N83_pm38pI/0l@C'r0B+Y.;FIb`VZlu!gZhT*X$'$N8uFV7\:q2;\_j4ac?U@(SOp"gftk
p==.k,`*OfBLKO3[3\6$Zsn-jL_`^1#tJiDT2P<If-,.rNQH+N1ubl=SWr@snE%^*CZ1E-J7
J!ubuNtbjeqCS2!<-S&,,+m'7Ms<Dq/Mo_3O7RHiHBf/Q:lk'Vif_aI9;8.batIe1ao,G/@7
sA6$Tt1I`'SX/]ArU#)khi#"Y1c3CqOU^3rRF%+g^VSHJ[:W\3[(=/1%^d"MHCoIpKs`6B<td
'b9`aRX[GJgfCA]Ae3tD7^Nc3ZKE6Wt^:S+0%C,Jg2V6bk'1/WNNU(/6W3)4$;>u0st2Cd@t4
*#M\MI'2F`>c)g4H90SW:!(Me;NH_l[MY6dc!4NIqb9+T'dG5'i+ZY!`Scn%AHhrLusQ+s+k
rl@aIV^GhbOjon4:S`h.6NC"*a4a2Q#7d]AV9H*]Apk^+.3"2qc*F$RR$uNHEWcCGPi\*;ltV`
;r^Xr<Jm`QU0JU/s0mNSKtZN24?78_k+>[LS,3calLi+lbq'Y#o7u1\k%DecaP^.T4ON[Pl2
?+-9goPgF'mbq!e&C-Z1Mos?Je\hIui%Iqu>0@>m0Z4l>qmB4]A2J3\.0M;7^k,mY.:P>?>Qh
FIEk(!fa'MEpLm,Z"LIoAo0gnh&ci*cTMm\Dp)eG4q7d3Zb=:&81"8tn`#4144.W,2h>a!H5
G.FX?H&a\208*^=3Y/.^IO$s2-eT`PlD^KlKI,[G5b7L>b=PHor/do,#+UP7:,/?bMAQNT[n
==#'_j%9ET(;ghXE^ogH31?$c6`!Q;,A.nVMN">V1WTJHO;C1%]AFBU%f=r:16!U$<qc*^0oE
([2t0nSl(.#O,L*3%Cba56[B3HZO2[M)pIP*ESkOS2fc60G/]AcIF4qK#I=1`=S:A\]A$@-tdM
WRB53"hD4H]A1cLu8@u=gqF\_o@dt>\e,\f-5&Opt?P[bZ\9GFXqNQ1OmQc::j%0]AL;o@=I&F
LXO0_sraAr3:Uj2)lIF;3LP"@bb"",Cr2Rkej.u5k$ka['*^d4YOJ354_'PK*C]A(B#OpZFXY
Y>h4M71Pq7^oal6h0CNnu0Z,'U_M/_J.&*,&d:5AEP-?l<3L!G@BjD]AZd(TkGiUr[)Lk!q<2
99179Bg6U?lAVMbokdokt'D7Ra37D:e")0*r[M5C+B/><U(I4"0\^eBHH/1c/5K#(DeT`NVH
WZ;PD-uC18Ho#1`#V_^g-6kMK_)1ISP>@CsRrXWqmr&7ljaXIHam=Y?Q3tUH=dU5kYEf3F-H
s@N9K?'XU=59QH?o;^'e>"b-C`*EoRZ!2IkJr)U,mpSPUkVpSgLur;&CuEXU'<M/]AaGR;%/+
;'LIsB*&b:)j'-8TO]Au0,W,;[]A_Ei3SIOXp[-El:L%j%lGUZ+-b0R72VJS\3M(3GD:Ln)bWm
tn4hL>!NW>Ac`.&t(qXG>uB7@Bn8DXDp.D0EG;a(Y!8kV2(pb5oQ@C"kgGq:M;DF5#"_MU/t
VlJ*Io._bi19,+AGUNILf>bB&=M>gDkML?,q<JFE6&8+h;K6#lNQ)n>\3cQ5[6!;oa7+2l6;
k+jK@N*j_cAC3oO?#RZD@77Pn'Pc8Djnu0Yd^s$6_)d.=dm;<rZVAQRiPHr+fU96@!L@ER4>
7C8-[temM/D[nYDSp`m's!u)]AJBHfOSOOXptZjo5EC_`;HSh1DZqse'VELWqe5;'17^#VcdN
h\R/;V.P]ABD5?k(@^=BF3r^(/aPXS='`2)="H=c'gAonoXGB\4SYR;/2FV0=^aQ!c/G&1@Wo
@JcgNI'KAc*!&'q:OXRQB6iI+r<AAUeso6V$osJTl$rq0Rj:<q(hSN-;(^.hM#!D(d]A9Gf%<
n!>r00_;mP@]A^DDX-iInZ"#dqjM9N#ghm!:@1;R&jqI8=?6&ggHOLDui*JPg!A!1baVqOo)q
<*MRmqfVk??!B[TnWU#q/PAWm"r<Cs`+%+3)Z.:8qfTVo[Y:XKVQJC<&;*l:I#mr?^6c(q;9
aO#iXVr#+DIWAVK2BWA\WnUJ77&tc]ApG*+kmXG*%H$&lXs7)/AbIt(/=OgBQ&S&O6tb,HMi/
8PSbSXg\%piHr#(Q<5h=^=MP__>4+XrOW<ahc;**]Ajj]A4+m9SSnY=2t<)__p:qlmM`a!f:+D
]Ae,#)J!?.,f<<:2"clbJW7E2ONbs?k=,3q@oYQr"/9c^Oeafq6sDuGPo*+p:Gg]A;:Va>QA<3
%g+3GkFa6sH>6BP&8VSTGM+Bs=V/[mZSgO-%#H=KWqPnme:pho:l,HK2dX#Q_W0']ALa%IM+"
`QPNPd&cU-Pm+#IB>SOE/T173.=6/EkP1+>H2<k4@h?F&/8V5\l^"ChSe$rJpZo3-bP9G4fC
pB'Uh/Q=q1A,e8&t,`S['>E="3r1B;]A:H]A="s1=j%cUc]AWU`T3FK2dQ13F_Pp'Q]AYRF1PBHG
/-uC@@J)kXsP[*FucL98Dc*%SA^]A-91'+]A^I,+Wd?1+e$(b]AXBjh$[K6btK+R<%s\*>,EU[/
-s!J'_=Kc(TI`5<3Km58pgoYIMe`G)Q'55Zo8,d2.Gd&*`Tm=?Z7>Um?Hokl5"JjJ-eCT7kh
<Fr5ejKh\+f#2TM9AmCtD8B9QIM#EXg]A#bQCsARcpVCo?(daS+B7bfbV1N3DjYYBI<2.8>;u
`5!j/OiPNKiGVn5Sf_)sF_t]AqV"9]A*Ek-9bd'-ud</GcG!*&:rLa75\r/H:PaY?^d0<s4!'o
k?/)r0^^l5HthGZj6\Q+<h#r,b,G<n"[l`hRWF%ga4uoiRub!@\hdhIPF.Tr<jMNMMR0h9>[
e5ITmtE0F2YSXEqE8X)pPMu,R?/Ap%QUhQM.JkaYs6?^:6<LPZ6<)nI3H\Ft`=,?a#Yp8t'(
4S&rWr/pi4@rH7$4TTJ4KY3U75HcoTnfZZ.]Ap!so4K-m;)$[q"TkE#ZOO#i8$Mh:2niBNP1&
jd*V9fA!7UhkmK63b.qTAaZ4pt^0>sg.\$Sr]A/V`E[+T&FmcW6?j#G4gQA2?YtbE"`V,[ob5
.Tob*^r'G3EZ:hT!GmW<giU:B&aUY4<^GYM6(8#:*d5+plicImL/Y4rj\(.P0-AC#QpJ.hee
:\Y.=Jb+mA$W(8!2Of(kj?$eAaQtQhoGk'GI>\@Y5'N]A$l>[S*@90jo%qBB"hC@>/#FeRh*V
!+0XN%r#f$_>1!S)LYAb<^/5]ANb!f9;Zd2p)TJU>hIep^k_9mYU)/+I(>n<7/QC$;<!@P.'`
VA",YU''JP6<(g_`qnQCtiEIprDYY$A\6G[(uC=-ssM^AOL_6K!,`"Gc^r!4`eb"?3@2b\qF
)$HG9d"d6CVYbLK'h$p9YD2-jQA8s;9!Y@dhjO9fQ0R,&TP5UpnVCC^*aZ.m5T,Pb/?Wklt?
l1F!3FPY;6)[?S2+oRG8`0MctN^Q/Lm0"mEOXULi*uG0.lL5^D<Z]Ao(D%W8i>Yc[Q^lN&7+6
K*biE7f`2)8HG4'4/C\pRoXMtEph&)OM4nerifRWBJ6^IrX2kC_&!3^-]A'n/220**L"S1V)e
HQfTl9VeCQMV1mt%!HEZE]A)/nW0=)cq##WbKkb:#;58.@dYe^`8VofYZk"t;U.+ReaO2M2N5
%(iqjB6`%*F%.`UH3]A/DhURI@'$O[YRWc8,D16u!>)Al#;+-:[,Xi7S6*kC_og^A6[<1RY,=
dL01$(oTjJ-:OMQ><)oaAkH^JpZL)n7=CRDL+ro%C=+hZV.$JuEh?Q+ZQ3qSZWH-8.g#:FF2
n!p=SB5&S@9UKtapA(9Y6aYeLXkXB;G.j4tOPOMX*GSh(!?RRH74R\B0<d6;XHuB.jW[0uAU
Eu0I-Zc@\GC8:5;Tb^;gpprSY[,P1C3o9h+"Y-nd?0EY:C:BJe_32@qhhpcJ"hadZ9EEF^B^
2Giqg#O?fB0$bP"N`#FK!EKO%5U8roP/a^nr+#A65SY(oSf0/oGSO;9UB?o6lh=iQ]A^^:g+D
F_mB]Ad(JYoP;u03)A@]AU.EkuOUQ011YY!oFqo(rdUVa3?@5R5&uC7iXEn+c.X#%dLY%T`IMM
K2b(NWX-g+5*GM"^$H>KOV8McfKmC[:OmF^P"2T"Xs/KR?9*60a3YrDF1-`]AZLIoa98KDB)E
Xb-7<od[>:rK?*XrNbMS?mM"I&`pHpEU/I"FDBnP[6B9!kK&sSFcBTGBCF\\DK#9/1TEJV>"
+rfWQNOt8DZ%!KEkGk@`KP=Ht.B?IfT~
]]></IM>
</FineImage>
</Background>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[5562600,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[1790700,2743200,2743200,2743200,2743200,2743200,1066800,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="5" rs="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0">
<O>
<![CDATA[ ]]></O>
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-65536"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9C*"'A'[a(dtK&DTf`$W$SV0'm82e#lYQ0U:#%?JS=GOYLdO%[2&VUW)sYLA7BDZ[8k]A,=q
m'T(R<b<;q.O=#m?mOpr`e;5lsME*.ihL$2L3]A2aOH/_p#bt$@3X-CUmKOkNmWBrm&!fIEoW
ofl8bG0+<4/!!*&`J!p-C!;K(cT[t!.IE>:]ANnW\-!<6%\IHom;f4WZ99jX7`rqB(JB9[#`b
EuHQZ?c.qI^<#^F5Qo.Ca?dibbCG:r;G]AbIIEC8gVGi:r'tJGMm__SM2j>e)Hg&G&re6#MQl
[XeP;7Ki)&EZP7f$T6:*7nmC!_A1!/CU"s":`3]A@g<+=PL^Q^X6NE`P*:&4Q^GLuSj>n?<<u
);6Wl;/ft9Yuq^B,R\X(iqRi0bp29T($E-Ao#\O#jVDnD.W?jrI'hXnlA?d%P;')#gWk?pD]A
@o\h^&$iW'R&8^m:5I$Y/Q<iOgZ5`I&G:94MA$_,U0Ra%`F#PH,TZ>Lh"7f2&Nh>J^Ai8&+X
CEb&FR!kg>\npRk`[AsnQ;.aYSoOmL.qSg68F5YV;!=-R7OFo:F?UWD"8HtOH36!>pH>K]A87
hoj"$Ic"/[Bl0oq@GVl[5-"[n%>$T"G++;nUH6GD@82fY'<e&G,jY-X`YL)rd<6`;dG+\Ze9
O6;*m@Yd'24QL0QM9*L-f\qE5oQK1D)#V.cdD`3KaCQ/%'nBRt!Ga@#%gEA2^sPE]A@Apj5+l
E/==SEu'P5JP:YM\-9HXi3AeU:*7O1m%s-G6qrm20I!t`2(g.JcZu=,'#MR)E;oJ5_'.($12
\G_i'>ZZl*6CkH]AdWRO&f#,,9a#$Ql#h_4(YW2ZrG'bd\M5+M@rLanLA'VE1g-t)"Bsr*\63
</UTF;DE_g@g$G&ICo@Yu]A`S;_'7RH=FrrZRFC;3,oMBL>q!OXAl2A]A9+pEf85CH"Q!Hf8g/
#MgrQh&e:f*-X1_0f9_U^:\u_[g%sj,+&[er<l@Ug%SeV7psPJL)=L-/?\3/C5cP)*-J[4Lf
Yt(m;%!"6N9X/P$?jJrAQ7\#3%Xe%4$L:bSP\:e:2\E\oLtH@^FnESX/_Kc8VlgS7doo8$f/
-2G'_S4C]A2IsKJ&do!I:OsV.uq2QC"Xk>De&/#T=:h&OuY:h-PKRM$8c6.:5e%pJUrfXLP`M
/R9ffZc)i6O'iI80uB2[[(]Ag/5fV&/Q9=#0`A07L/:!<5pPOfIp1&.e\Rpg4_`9IcE5eL_j3
<%;)"Cd$h5!_\_^%N#fYLJ^f;J_j+opNg>nZ?^$4\RiKM5KLDm;RfA-KMqF(i[3,6+]AJ$F20
sI?R-T#EpX>d1Dj!O4cGEK4.5b\E4JITp!H'%8\Bo's1rd&s&U;:rGjIh=QP!eU@]A7O9Q,NM
``^=Rq=e7KaW:SjL-Fp9d!-XQUZ$Cn;MG_30uaOu"%P62i.#+[kO+)qS.;lN?--5-n*^dR">
nD70s8?\k7i<Bpob;./?1iQ)$C=8o_Ge`i4]AuSs"f+0uoCTXCLaA_ZNisKe@+`,Eo:.^"abV
eU1_37T=ii%g$TFm,C&Ik2rV;0kapHs0F*l=,Z6',!kQC613M2TL#,DR);&3FW$3OCn<KE9_
*X-(2W=_PsATA0<e"q`T)e<t^N`WIgYE4m.K3RPs`?j\d\a76_W=+0EcJ):>iI=>24ra7Z8i
=ul^pc"B;R(!2hJ,>S[cRr"Q/D:se>uK[)kB5s1kB5s1kB6Ofl4+U)o+fu[J5=R(:EIoiC^o
S8"'B%kH5\cnpR,/'ZrGSj4?c6KD,,&JDXH'9!O*njCXWmm3pES^i9EN0m50N$k_rV@ptD93
If(:'J(_`PO<Nn1E\(Gd\qe#aJ)*HQ$4u`mLL/6kcKidAcKidAcKjnBm1(jaXW/DP+@#"S$e
U0i+BCU^6;6I$1(f@mX9ie/$&Ji=FJ(]A>jTJ4X.^TbRr<FJ>,>[;I^n39;JW[)46.o-8P4qp
G):13V&YMhl,^$WW!-"K5>s4YGW[C@o=4PnBYNCr*6(9u"?YEaU"A+1;_`YM:%r?4]AnH%a<*
aN8_nXY+rJ;%(<M!9*$R.c<@_TAn*n17Igq_O.\>t(@_F4pTIS8<,ecZV>uaWOgNl^q5AF+r
rj7Qof!cRI4t=/3?+l\GrZ?rB$ns45XeKu*3O(g`>l%`)(#h:%=e2268A'Yi*gMUukkpYJUD
s0c\D!IWR+249PY*rWglf&UGd=FI%;4=5,j+1VGm5O=5EeAbguFP]A&a$ghL2n!%T-iDQh"r3
V^OTi6CIQ$-fc%rWCTTsLi?Nt,Jr_"(N-3DNdgJnKfLBNgsMas"OJ+uR2bogL]AWQS&2SF.8O
ZVWSP!rm)A&_0fG$k`i_//_p6:5.i2*c@2mfH3@\*kkhcLrC&")==5^'kOu:&kqPsc*)8;tD
l_'3HZ)_@.YG[M!>VfhOB<D"1G<p/VWYg*V65oafdH!X^MJPM/F.",]AIe$l8jV)*L`Qnc<%h
6%'uYFnB\9/fFBDk!ec(EMI\gs("5AKepA0$X`<>ld[F2LI!b(:qp=H">l8NB1It\*)DEa21
9'']AgWrF\l6O<?!93-ja`LuAkLk#mGDfY/&SX/j0_BR*9_:4:`hD",t/8Gu5A^N34m>C:FW)
dQsHR;/0>up@(Hn<N'LRoWN1bSY,2&+iR4oRR6hf@(7#mhrO=^E)Om[CDl_?)TC<BRqUI+/e
]AqF.=\_=M*/&Et=(/&N5%PGo!V`Dre.[es1"k=VJsHRQh`StZcFV_;H5]AEcU25]A1hM/kJs7c
g,]AM+ii45_@*Z$hAuQ&o]AedjACCl"oO_]AK\[U(4DlJe4.J9[!8q"S,PXn=0&t^f(A)(_tZs5
4m+@l[S5e`1"ZC,B-D"Jq/+UqCa(-5bc_IQ"LRYNJ(Zmtp?7GPlSMC+9_%mMQ[S[D<t8@sa!
B5O_&l(JYehBZN&3799VL;p<!oZ:?Z`a3f(<%l]ATJ1_WGiqj2lINE5Ha0D:.1;RBl]AMh.Jcm
[j&gac+2=dlK>>C6a>VR.70$nD+QH^-<g3r`k<kVP&naB[G.b+Kr&MZpCh1>mst0d>3-OUOX
hR_'"<=Q,OEh&<#\O'HH3'&P_bdC7$XP9^u.;)KaJ$Yu9Y+JCeXGLs6ZW\^%llt-!IB0F,)e
><5+$aq;a"&&NANVGa&RkI_Fq9.e9#`A[\=K&ZL<>'/-A<`(i^e&LMWHVF6gH@>Sq8n%Z@p@
MiBPi#pkfN+l4"]AL6%eNSRV6&Bnc8*pu4Af_(6=98+oIi*tbDM'[2sG0Rq[pV`"kGC>N_t?*
jY=M-I3Ub#L8ar<"OMaD&Ek%RVi!D`F<Zt-eZ[f4?]AE".Ai,kUq0]AEHJW5J@$F!Gq#$Rb_QN
7"Mfd6IcAYO,Dqb^/FT4&5;Y8eHVH)g!W=6)+bfVAj^,%baT5EVi>C3UUqe8!<TjP'L4*3=;
)iLImFPeiH\.XQSJ`9)s3'1HGs=r(&j6Qt`G[J<gIND*DuN5#5HhdFUaLu,^Q@S3_+R?VHO:
]A5/XG,43?AXS\Z<7_Li^jM'<U7[:eO&6Qk=2rsuKYac[V+BM1<<YOZ$8CEW_ICJ7EuFN8m6N
06lpUbJ#&U\<:ZD*M_cs5ipT54-E*_aXX/M2=QuUm),!S9]A!Q>IN0$rhdXUtuq-"PWEYuK16
V7ZH*5Q.>(]A6mX1@'.;ePMfN+AbXoKb+]A%Kp3(f=Ya307NpWMOF4_C`,o=.KBdM]AXoXMKbr*
UpW`i=`*dLkjM=PP2mm%h]A+5B<=CG0b.kf:4KGYg,H8SR\lGO8d7JK^ek"6;XRO5Gr/NG9M>
TK@1^]AlMp0Gs7Y`(f-b4SK^?EP1Ge\n"2&i`^T57)RBKk]A)H>"4`aVo]A)DNJX\skClAa_qlr
KaI5\T+'C[[!3'jO!V69HJi8]AC'sRXt)%Q+90`L6Lc/P8D5KP-V4,Yg3W<)_YYqPQjLF/L#V
@i5t^\cHWBH<*M1e-n$]Akt68NhaN:fU]A)VKQ)c=4S??DG*$_VUTr?j<0D\P()p!mq,N9;5>(
COcjhM%sTB+ilNj`@&)VO,"!AN(4_A-EbT/9o!#N:j4U*B<:V-n%G>nmXj^R>YR2&mZn;#5!
ST-ei&DTs*7;q.*a"*->O75&VDrS@QG=!$1M$L%!V<L"Z@\p`IJgLkCnN%gCGDuSm`(ELj\9
(W/]AQ/prXb(QAsk(,/C9T=E4\kC3]Ai]AF74![]A3d$]A-9kKS74%)\i_GAep$]A^KLMXH[mj'lei
]AW0D<F>>[4Hm]AA8b@hfDf@7dG(sn?DTo""D6WYUTamR1f'q,OVU3p'/"]A0*\'J2=Rk.J_V/!
;$gAL='kJ)HDbC>?;n@UPK[6Z/Ze_s_ELh7Ep]A6eSs)^dN??iTRhH`eT+I^k-0ZYD#K`/)l8
J;TA$3(I$H0m:G_daP1<UAM!Ir"Wk<+K;2)k/SQ4)Oh]A^I#mrsT-g8A&e=p,\q5RpH'kob1T
>U3R[F2UP=&u&LuEDb--d=JV[d3Kc*<$3No*jM7lY:+k^e`rb#fm#4Z6$t>(`VRM^a9oje0s
1>;adPo(Nm0:O0RF_j\QqmpKp3%u.2f;!Y3bCXQLS5<Vk%Glp*(g(nZ"J4ssk!0hm/iHM+Tj
-$t*TdtN52]AgOdY)]Ao5>a'$g,#ni4g"G5\n2q[%R%5+h!dd-\#DS96r=Ig:m"OgpN4WH!M4e
"<.-rh*N2mj9G%kZSG2C[t\?H&9KNKk4C+XS*;%1,#@M9@4/pcFI3MBfl[d\81pV.;"P*F,+
!XJt-Y'-SM"j0ELA4`u5c;0srl!t$F.)=^I]Aqu]AKD2Blj3<RIja["CL'\>ufW*BRgSg^'Db[
['[H7Dn*?EW*X!,PBtIO^E@A7,GJ&o\O]AH!CHA/eG'7(XA#]A\L8(SD$.]AsW&:=ir?68-5(F^
4*;8`)1b7q5ru94+$3NJi$&<'f?Q[A_Znd?cW0E9dMVA?B=O>@hHe(Z!8P]AN"#'b39[HXmuq
e"$A3'*e8q(sP+U!gKAXYCm\!m:0FP"I&tnnA%_m*B%FC6M:>17;SjVQk15$Q*hrMBc#V>F=
pNIGeD&^3[;REjWEGEoJHm>^&c2\d-W%F\T1CM_kqB1?f*QSYo/4D4TkG!*tbDSdKG@FF1Di
.>FnmMJ*4%n8e,QFleem8'.<tj^"VrQH*De*Jk)j2CXrhX98sQ4:(hSG!);@:bb)l/-6g3WB
cQ!^F2=&q"%L"'HmfijNl:XX!=H!b&VKlfN738#sFspP+.f]AR&L5UC(sM[3cn%`7:?lAD48Y
#dM[kdit!W1><%_*+#Wj0(Vi4/0h'SOH8JRG!LM/h!2dP3,TFpY):3H)JZ!E-^gIh!7Fo$Vh
h+:;77LPiB27S&m]AAnN_!RX6C8eRaI*K.T!k]A&F*NV^HJ.h$c"bWXIH[)rk"Pp18hIIc-?se
1Q26rX$"sI+H"n7c786-g_r&=TA\>b7]A/Gf#=!!~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="348" height="320"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0_c_c_c_c"/>
<Widget widgetName="chart2_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="5" y="328" width="346" height="310"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="absolute0_c_c_c_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="chart3_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="chart3" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ChartEditor">
<WidgetName name="chart3_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="128" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="true" x="40.0" y="40.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.PiePlot4VanChart">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="0" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="true" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
<AttrLabel>
<labelAttr enable="true"/>
<labelDetail class="com.fr.plugin.chart.base.AttrLabelDetail">
<AttrBorderWithShape>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="true" predefinedStyle="false"/>
<shapeAttr isAutoColor="true" shapeType="RectangularMarker"/>
</AttrBorderWithShape>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
<Attr showLine="true" isHorizontal="true" autoAdjust="false" position="6" align="9" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name=".SF NS Text" style="1" size="160" foreground="-16711681"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name=".SF NS Text" style="1" size="160" foreground="-16711681"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="false"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="function(){ return this.value;}" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="false" predefinedStyle="false"/>
<FRFont name=".SF NS Text" style="0" size="112" foreground="-16711681"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="100.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false" predefinedStyle="false"/>
<FRFont name="SimSun" style="0" size="72"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="2"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<PredefinedStyle predefinedStyle="false"/>
<ColorList>
<OColor colvalue="-16427648"/>
<OColor colvalue="-16711681"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<GradientStyle>
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<PieAttr4VanChart roseType="sameArc" startAngle="0.0" endAngle="360.0" innerRadius="80.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
<ChartDefinition>
<OneValueCDDefinition seriesName="分类" valueName="数量" function="com.fr.data.util.function.SumFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[明细表]]></Name>
</TableData>
<CategoryName value="无"/>
</OneValueCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="261fa2e3-f2de-4c17-85fb-001c012424a0"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
<ThemeAttr>
<Attr darkTheme="false" predefinedStyle="false"/>
</ThemeAttr>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="250" height="150"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ChartEditor">
<WidgetName name="chart3"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-8421505" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
</ChangeAttr>
<Chart name="默认" chartClass="com.fr.plugin.chart.vanchart.VanChart">
<Chart class="com.fr.plugin.chart.vanchart.VanChart">
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<ChartAttr isJSDraw="true" isStyleGlobal="false"/>
<Title4VanChart>
<Title>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-6908266" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<O>
<![CDATA[新建图表标题]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="0"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.PiePlot4VanChart">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1118482" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isNullValueBreak="true" autoRefreshPerSecond="6" seriesDragEnable="false" plotStyle="0" combinedSize="50.0"/>
<newHotTooltipStyle>
<AttrContents>
<Attr showLine="false" position="1" isWhiteBackground="true" isShowMutiSeries="false" seriesLabel="${VALUE}"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
<PercentFormat>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.##%]]></Format>
</PercentFormat>
</AttrContents>
</newHotTooltipStyle>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name="">
<AttrList>
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="宋体" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="宋体" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-16777216"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="true" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.5"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
</ConditionCollection>
<Legend4VanChart>
<Legend>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-3355444" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="false" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="100.0" isHighlight="true"/>
</Legend4VanChart>
<DataSheet>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-16777216" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</GI>
<Attr isVisible="false" predefinedStyle="false"/>
<FRFont name="SimSun" style="0" size="72"/>
</DataSheet>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName="新特性"/>
<isCustomFillStyle isCustomFillStyle="false"/>
<PredefinedStyle predefinedStyle="false"/>
<ColorList>
<OColor colvalue="-10243346"/>
<OColor colvalue="-8988015"/>
<OColor colvalue="-472193"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
<OColor colvalue="-10243346"/>
<OColor colvalue="-8988015"/>
<OColor colvalue="-472193"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
<OColor colvalue="-10243346"/>
<OColor colvalue="-8988015"/>
<OColor colvalue="-472193"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
<OColor colvalue="-10243346"/>
<OColor colvalue="-8988015"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<GradientStyle>
<Attr gradientType="gradual" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<PieAttr4VanChart roseType="normal" startAngle="0.0" endAngle="360.0" innerRadius="0.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
<ChartDefinition>
<OneValueCDDefinition seriesName="营业额" valueName="营业额" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[File1]]></Name>
</TableData>
<CategoryName value="无"/>
</OneValueCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="459c25ba-ad65-4e85-81f1-ac8c62c71545"/>
<tools hidden="true" sort="true" export="true" fullScreen="true"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="xy"/>
<from>
<![CDATA[]]></from>
<to>
<![CDATA[]]></to>
</VanChartZoom>
<refreshMoreLabel>
<attr moreLabel="false" autoTooltip="true"/>
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="false" isCustom="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="SimSun" style="0" size="72"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
</AttrTooltipRichText>
</richText>
<richTextValue class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</richTextValue>
<richTextPercent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</richTextPercent>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<richTextSeries class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="false"/>
</AttrTooltipSeriesFormat>
</richTextSeries>
<richTextChangedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</richTextChangedPercent>
<richTextChangedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="false"/>
</AttrTooltipChangedValueFormat>
</richTextChangedValue>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
</AttrTooltipValueFormat>
</value>
<percent class="com.fr.plugin.chart.base.format.AttrTooltipPercentFormat">
<AttrTooltipPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipPercentFormat>
</percent>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</category>
<series class="com.fr.plugin.chart.base.format.AttrTooltipSeriesFormat">
<AttrTooltipSeriesFormat>
<Attr enable="true"/>
</AttrTooltipSeriesFormat>
</series>
<changedPercent class="com.fr.plugin.chart.base.format.AttrTooltipChangedPercentFormat">
<AttrTooltipChangedPercentFormat>
<Attr enable="false"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##%]]></Format>
</AttrTooltipChangedPercentFormat>
</changedPercent>
<changedValue class="com.fr.plugin.chart.base.format.AttrTooltipChangedValueFormat">
<AttrTooltipChangedValueFormat>
<Attr enable="true"/>
</AttrTooltipChangedValueFormat>
</changedValue>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
<GI>
<AttrBackground>
<Background name="ColorBackground" color="-1"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="4"/>
<newColor borderColor="-15395563" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.8"/>
</AttrAlpha>
</GI>
</AttrTooltip>
</refreshMoreLabel>
<ThemeAttr>
<Attr darkTheme="false" predefinedStyle="false"/>
</ThemeAttr>
</Chart>
<ChartMobileAttrProvider zoomOut="0" zoomIn="2" allowFullScreen="true" functionalWhenUnactivated="false"/>
<MobileChartCollapsedStyle class="com.fr.form.ui.mobile.MobileChartCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
</MobileChartCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="18" y="62" width="281" height="231"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report0_c_c_c_c_c_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report0_c_c_c_c_c" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0_c_c_c_c_c_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[D0gIM<;ZRmR5nac#%Pi5@Lstk-A>:A80k/X#n]AWu8qnn=2D]AC@9,fA([,#!/&k+">#$htm+t
>F38@EWH0>DSjf(XX]AkP+fDSF_1ocg,j>cguHID^1+Ib=5B78K7^18_`W5NW=S5!<<d-^a!b
M.NaWQJ5o1L<`Gu\\KfoB3@bU$EJ$/deXF(d9VGW:CP5oX>Wb@JD%H?d<N\/-R61pU0l4-17
R%R#b"be]A,]AToU`jq)%I#SJ?_%i<&;:ZLa1*P:*HM&%R;,[,67K;6iIkR7Mr]A2l8<"`+O)ms
qXAu)EH6;5=QWh'Ln06raO!O>Kd0;Vq'J1j@erVZE:lGIK7e;.3a^n>PLpI_L/goEB.WqeZ&
*(Ohqm!R"8V5BS51#pB"[oI\2din[_m&9#/8g!G,/_i&7_DNKTV%tmO\O,`BhYcGXE]A`gUf2
KP/HOa--D%tX9[$[Gc:Me&)Dc\3iK#gn\MS%YCd_\D[8eM>aE7%N5$[?`fs%hfMJ._Z:r<4J
B$(d$!/]A'Cjc;Vbhmi.8/c5hkPQN_q%pN@#g-nC-(^6&oD!e^8n#?^D*,MRh&AVf59jTg1[l
:<V9/)-E@Th,:+FqTdX.F.Am]ACq?+D4%Tg;m@FnEL1^tP+91!L3j'h$N:IIZg$`%EtFFY@81
\<jHdlur\UK:@9NakT$F#)J\frNGFCPr$)GAMniLo*ngCTIY.s&#^X"hq)?hqbp?e5AC%R+m
B$,]A-;@FMA5N5"'>4g6dReGu_XOW!rqh=0TZ8gr-e^d9aBqJH@:)pX_W,$KKJ6d,HpdL:D,q
i%B1>oXa5-$@&;X8#0e]AYDp]AZC8CejV'(6`ql:?q1M[&a#6^35iQQ_VuhNVfkt1YA8B)GOj'
facU/DPTjui:m;l.$i.;:7bB=N:,8$^&0&ftrR)'(Lt&r?)osXsmgcG`Gkn`@[C&LRC-+t/X
aI&Z<u")^>De!X]AkjLUa:H:1g:$?#q'2A1SlU7>Ke(g8UofXBR_q2.OGp'W,W;/A1Ee#RQgR
]A;8X34mUOrY<jM/HWk_lN*EWWMU%(l9MLrJnM:JYDN8ZPGLX74q]AmUeN_'!?+m>B"[)q=bg?
h$D`$T+K3FKL0%-X\KqdO!V"&J-rKC>OG<t8KiSsbC1?j)0J>$SF0A95mLf,Xor`=1!J'#fE
E+Xgi,^:>EFl),o(#`3`-b2g]AQm('<VQlTOn@)C(#6;$T!Q10HR1c&=LbAD"Gm"HK%[7\=u>
u2!M3hN[LN!.5/55%YT-j7]A8;S.7&?7nM$m902(jslm2:fMi0^c\L^O>XW+pWg#9Z0S7aXhX
BJe9LDc*P<3inPB_t=I*<kj;)9MWUGH=="CsCHEb9*Y@c=??drGJa$(1)]Alf>oOJYT>'!:RH
=Ga.*$OUT-56#0ULFOa%l#\&PV<Anat`ZXB2:j:QG*hYaogoRcAVCnqWEIaG5[FsLPH!Su;r
AA\?=j"#;UlKAbGW!ttPpDm8;hh@G:#8>$olXgY>=T1]A=EPtftM\f&phk$c(DN%+Rn=&:3'S
\*k;J!)--ZDgqJolqtT_h4]A<NrH7\kkmC-I;2"lF'7\f,Zb;+E9sLS#&hnSR+F8p0>7H"#DI
n&F%mHC@`CM\?WDtGDR0P_'D<oo7n,GJ]ADF,"!'Ye\id.ZSG:LNG9:UMoP^2>/PY*c?((i2S
-ou>I\@AHbp'O>:4rP35bVgGPr(RaTieCk]A"2`J3p8R'W&gML\DD"fCnr#"(S0oG`2i5W!u$
43('B0>3d71tXg\*;2O)JQRlOJ?@EdT,_HQQhT!=rG[<n_bL@/2L]A-p7j0hk^]AYtH1i-\gut
niba-J!9'$eV+5R-qp#K]AY=QBVd%,*=_O$n^^"a<2HHND3=oc6DPCGeJ=+td&GGM9^/&q/da
,e!g>@B]AWDr9ne/qfZ0m[e6Ds#H-ICSNXOeJ3Ai+[`869lU<V';@N`I)&0jlq@0S'I;$^Jsk
[C?MG>ShBgOS0Q@o<0`h8n8G7n=@_$hLDbLJ=9@5o_)Q>O(#$sl_7Le2gLf(b=(g]Aq'SC2)"
"Zpc%9R(cI@,Z-h%S!)I+F9;_QO7SI0gN%c?&8A:s^MA`&>O-YOIe_Cn4@k$5=.Ig[]A`KL%s
<gCh`$NR_uZ-io5#[OXAcr]Aqhr%%!V#o4=a"sP<%$"(3qsgI%[4#Z[n,npgSm=%hTd/a>s>_
oS7*r3.P\3,'K*!13fT_d=]ABLhp5YY:,H0a`QHGhTbFtK]A[NeB*$n8f5a[bSB',Wrf-hC7gX
chTjEh_)#7u/if`#:07M8HRHQ[WIl7Q4YPXO71G@m&+:#DcpMc^bK!*c!c!gKe'7pNc&8Y=R
41bjt0hVIaNbIVohqS'`9\GF0n6D`+;[=i?X-Fo0aJk.(P5hob(g9$,<@*;cu;)2R<DVJF\U
8$\pn3,<ZX7=ETj]Akg$gCjeZKJJ$]A$_4U+e:?jc-Zh6'>*)G&"ITA2S$%#bJ2JTA)rA^p&sl
bZXYdNeRg'43k6_$R3:_d4/B:_G^X.E7eTl0CidH&T1qHsH-I(VnGfa@PmL:2^DA?P>SSOod
qFf>@98:r77tAM>j'l\P<>(JL-d9n/G3dCdh\/nGF"!j`^l/)u_?p:ndh903:$Ji@/3+.%EZ
3"UD%']An3"-9=Kg.k^2K;ta1Y)h4^j)X?DCA6"@@76@pj2VrhGu)?D"/OfOGPQ[F"G05EQks
E1N!;=l'$[d(F$)Ud%$KK]A4!\n"u_"AmK.Kn?f[nU\>2A$B@YQ@!2>k/\;r%Z)\0CAkT4B+-
13uHH/=\o='9Ou<!X*f'@`qs&OBD@5Ru+t#pUPh"+Cg&OXG]AKRV\!7U6hJf1duKX-K3Bo;qY
\n9t'gn3ibr<>t3O3+s@/G9e?!i[&;l.9hC_OLTC^Wdl0$*g5$s3ZGLhf4R2/=4R-;;a-04^
r4&#N#q)iIAf[$<5Erp[O@#LHASaat$NT8ZeF>t,c?j&]Afd.GGE*tc4lYA8Q>;s8%ijXep>%
kbQr3`gm=Kk]Aa#"0UTWb7dZ#oEY=@RA/c1eLMB!_;-@BJ_N3;DE7n?trt=@[3@<cQAGu+iBT
ChAm:4]At9B`f\P*:Is!g@4e/d&>>3Md]Ab?.$Oj=o<Sc&mLH9Ll;EXhs-\`W^l(Gd/iIehB.J
U#hWgrr\tipoS:RiTFW.1eJJO7"leF+9k[[8D$U(A1[e;6s-`bR_XKj"j;8b9*):Fo)@gkW@
)bGe%op%&UH)^73EFIK]A^gg_+/)nJ$7;kcDJi;eWW7jD@tU6+\>&Du:g_!5s(2MTqUNgm`eg
g0uh,j*,SGar*eU)?goJKf:XE=%4S=aFd+`g@Hj.8]A9!O=JU;mb;nFFgWJG#!fa_BJH]A^n)p
aU(MYi^hp8qYnhp\un_JhK)Z1.HESL]AII+cM>"AHGL7jiogd^nnC:?,;6.>WM^LD2)^kO]AfM
'8uRdoO)(<);VmUjnK^g*@V]ANXVrFLnJrrnfStmVqC+sPCdO/_m%6iFqoQjm)rS')8&W)Uj]A
OF#!kpR1;MZ#$>X5&R\5r*fQZG8*+^7hHHgN"B2X>>,:c5\QN-uC+30^169/9Ps-Lhg7,gpu
7IKbYCA2fi:fUG-(?@\G)lUU&gP(o.)S\_XYc!7ULM',?i-@g`oV*C!,2l5426gQodX:V3uq
V4:p=V)QrK4D`8"<#28`^!H'M!)@-;O<>Fq2SmfdXGnL$*shbHZ+aq:jHE7=,N&;4:ZmBY_%
[o@'ZL6ainc$l,]A@>gUs'h^QSiLP#6+(P^3EVFM99^B2;,DZ?SXB=?>?MB5#%[pdb#$a&t!a
dU\ZSfZ">^b`iW@J=WB#Fs4I1<nqe$lT=@:$GO!t83`f/qTiWDY9tbjGLbk".'C-mVH1<ThC
q-Md,Y2Q\P53pB-7@O=G+8>]A;!;3e4n_t).<.RFNit;R.Ha=n^%,2:fTG*HS4s)?GCm50]A^+
[qk?Th9K]A1QLUqFZJqobUj,L6QQ;"GB2G;XMcp[Y]A>=f_enj6epi+\@u:F#3o*G.#NPKAp9+
1Vl.V2'i?V'K4ok?'2t]AoQ0Og9Cc19!s$W\gr;)oS@?CC+;6B1I'OO&ji*.QT$,CJ^P<&ACL
eW"h*$om680,dW0mn.aL@gW=1[>8%UuI:C:nA`GjS!;Umh"RC6.DRr*\+G1"_u`27SS#!%$L
,64O48brV1baBo8(<,h:en]At.V]AK@C4#0^%AD/paC!s@Jj=7!0TUFbq.ReYbal!=B&oO\^"&
]AZ6.o/"pLph<$_!5M2M<77Hppplh.&##okgcNO\r^0^@?!o&gNi=2rVX6o[@^F#q9hHI[_"[
<\L>1+0CUTQiEOq*CDlpG]A!J%VpG"U3/84F@0"T+P5?q^GaiVT1S`kn(-M.QCYGlS#a'P-OI
q)nIdQnJ.`$P(gbZ/UfSa-l3e07"fU/[3&GKluTg,Bj1%5p.6s%n$WJbt-H\ei5E,M_T<QPq
)6A&4KJS[mGMQ$gek6TYSV^0ft+l]A3>c8ZVG(//l6"lp$`JL-k,:b'LBsNM+&?p+PR.K3O*V
]A>NoHp\^8H[O%POMOT"[/6r`!TWfQt#=_o<`MX\,VW7kArN?VQ>20VW%]Aspl[]A`ML(XJ?++N
NRlG-+e"MNt[Z/q3BsWOnVLl.)n(:7'!n?g_9Ru9dtI^2V4-U$h^P4)Ym/[nCG6/f$.dFG89
3N9!2O!:cS@&'.Y8?b+RECA5kqjB:_9K6[nWpMRm-'@10en=L$3]AO%t<-h;=cJ>$#<48m/,d
+,r-6I[ElJO_#Q97gX^4.4Ko+G.;bR7G)^u`L3n]A.HiD)QT<Fd6V4L+f_0^-BDsf_O/>CBjB
5_^FsYtFKZB>`5bo17UjZMLI$GG&]AUI;_@LdD-g170u.K$Y=WYS7<Jb*"Mp$fA0MEm&!(AF;
J('/Ps-e"Mti_sZP5C7dsE!At11ho&c9jVMcql)g7,1Y9'XdbMV+)M?o<[&r[G("K'A5bjKE
m"d<;o9K&[S8,CVjm#rC*4Ml>sIEQ2n`WdKPhHeKt;^EWOC4*j6s=C(TlLN[79"R$uF_2#Yi
&P[VImY<f?"kB]A<B9im1BfSdEXD.t@l;CgIa&Ca_eR*]A,tFiO5S-I3-NFXgEoi%lQ;@X3=".
I#,%$SP&d1<q4/'ebEBAqas]AJpft?jrk,P8fn5ElQIlF;$<Zr4CPre]A\qVgKSpS2>_8I_^fQ
_POJ*SjF$?oWV&rZd?0U0NHGbq=A\j?M6.mJEe,9Mo!^Khq2cRP(-d$O5ZM7*-gpP[Q03p6H
mQtQ<:()0RlXMZFjGOEqj1En6,B:HHe06%ImDnHi4htKPL7$p'`fS=pgZn7"f:.CF`pd>XRT
9=FN#=^'-'2if+R^dG=]AhPQsf"W_c5.m+Q&4AsN%/9S55?=[=UNtZ<+`&)G*C=cGG4ZVKHYh
4G;gdoM'5tIKd,gc6eI]AL93@C%nCJP`d5nF$1#\SbNi"$m<Tst#>=8p.@;',Hu=t7_(2ZcDs
h_,5W#n`'mh0t-'&_F!/@g3iK[mVtmq8W=\^'m\+)A#rE;]A1h[0QaK`$WWKK(^d$HfW]A+IN>
C)T-KJWe.(;Y!$F&@X'(RN-rAS$lr,6[17M6V+c=s5=a,I*4lJRR%`DJd<'hMhf-*`o&I[\m
f'3%-BaG!H8VD99W7P<_.$=Q:ikEa-qlgS%Q5h2[l@.nZ.q]AfReOP,Uu`rQsp8!*WP.1(kc9
dr3mG1>1/^BML8(R:CbiF8Q.qF^_T=*jPdFB7[_8!&ei=G5UFG!(Ue3^.VSOEW2Z=@2+Ks%/
(\fI'qpEem'-\3E$!aOjr,RL*o"kcR]A!-O?8%cin\.g_&Mb[4]ADW$_k[?AAC2C,_FKo0;-,_
"dG]AKjtEH^VLL'5&r^OXi/Kj)i.g5e7\6)Q<T^B:M-E^V$VZ:QGJ?Qnm[8M,#]AgG0OgRF0jj
`=i=WbJQ+e#QZ2Zp^WciNH>%Zl@DIMj[q7U]AOToV.T'dKTV:ZSLHRc`K_PWRcR*r%eAb,k)^
eE/7O!F`tGX)QW6uN:KFc3dW\oLU-qAqU-M5dsV/mf8$;&EN&oCnol#.;]A<1Te61']AE=O*`&
c.E]AA(cqOC,YZr?<WcDoZN:SO4=sB/@4S"b.HiW4&A0]Arir^G3UkB<[lY_.05eBZ;B\_pec1
0hs&G5>CN\*l4N'@-)cD\SReWt]A<7]A]A>\)?u)-n6N*O"2fiBe_XgD$rSVhmTV3gtjm6<N'$t
djRk8'F#??oOR%AT4:1ch[Or:nj>iXqp2q@\.IiZko=t9HqYC;b?6W0AB94nj=;?k@qYt("W
IF".?Tl_adfY%C``D;;\efUf-JR*2L=RGrKHIAJeLF+"CZ>55f6c@.\g8F'@=Ous""LE1-U1
d=nH3:["Tbk]A&8%#`9_KOs,,"pqrW@fK<enNAX'ftBHd#9k6NO6?_f;U"C"f$Q%1E8ZE0%p2
Q^0F:\V`"oN6trZREMH36M#$:il#Uekb2Er;i>Pc3b5U"6J#@T0bbur/3]AY)R7k=SqXa>KNS
%!A`s)YiS5Q5TN50+C.RbjI!c;G2:.*U%7;SV);s*)/!LEX,<+]A<"r'gj\3+H7UDlr$+91Um
PQ,h)//pWqp6Y6Sk(=AAEs35)PE8_g"Wsqq#;$jk*uoTEVda6pd9NORN'K",pWUhXfEku"e)
>`f.h=Q<)7Q",bMJ3bNi90shd@l;W#(KDs!%2MW5o1\Id30%Mi2!N,Q0^EKYm1<XSQgS;KU;
!fg+QPnDSKMGJu+bqQg.c(]A#Re<r\MVeniat2;&P9hDSgl%Kg7u6ca8*i89/8AZ@.G3*cepW
":#N1B5nNc-3ePo4+P/-P6&)'`O$jR%"@<%TH_=dJP]A_=,^k!TJ;>cHKrgg.#1JmNlbK)9m%
//T@+IS!qL<sCr:l)IjS?#"^EM(]A'stRAJeVh9FR?UCi6Qr:p/D<rH^I::%ZhiLO2rb0h=dE
gkC!fCj'RSkursqOWuUAI1",J-0]AnM6\cu,+;Y4SpV7-$^m).ZFWEW^\a9knc/drOaO"R]A8R
G4mcWgJX''!Saca"kBUTV\^1DC&^12=Pe?Zh%S@8uc)rEhE@V=,0r+;DH\s,-eg%3d-iT1;-
%QS/arF#Ph]AD(WKBBV>-On,u5&4m>;rV#96'7^8aOq`i4$?aYi#(tV;fm1CE'c5`dhgrj3)d
to]A%nga/O^t$`p/B=d%;f=3r59=]Atr617l\m-K/N%hLbMG2t0]A!>_Z-)d:&\]A?<;4nhM&:<9
7*H&#EUL5dU:IqfV^aA_,uB!-cWW/m9H(b>nu+JY<G9+h22,JH?)nI*.S?$%a_X&.)/HAXoC
^J1]A3#sN8S:;?q8cB/9DH@AX07F6/W)<"?tY:*(WqC\M+YtRlm'&gM=<9XN1QS>oD1DJ92%m
U:2r#U+sA8"\M/OkA4'[fmP]AR^rpg=p3X\K:&YL*P16LZ`f6;'F8Y:':-c3SDX<CH_N/5)34
k;o%?H%`fc@a+PX-c"9fiqfAH+XhM>i-BteLDf523VDiP?7]A(?ieLZqlJHglb0L$PVWHB<n"
)okddlF`M%1(UE$@_LVA<JcUo-@RL0M<UC$7!J:>8cbR1*OL>GVB6Kr49Y<_pF>hL\""5_%+
rIKL^.PEgps(6/=+s+8CAM4gE@8F?Y**BcN#ODbZ3A`e.sQkGsHch7=.d@;Jl9E9?8N-<:R<
ht2'`YgdW)=o/:K;KNb$*T=X5]AE3*JB]AJUg9<Nu/+ITY$b.>`*G#l9dn6D:lrM(M6_7\WBU(
cN0JJ=0CT%-=,j3KSeaaQf$-*UC8)G=?0Tf7\eSX.@N4Ma`!o&7[L'VG#OX4DZURj-u5$`)F
Y2Ehk<M1apZ<`jl>0_`]A;_nEc8>.V"4?]A]AST(\*p:\+3]AENkGkR:@>Jdq4JU;^ZEYHW<bEVJ
NHGid,dMJ7*<Mf7l#p_X&-liQ\sa-'SDR*a4><Rf\!9A[jGN".5jD8-nA+A>N-6a]AM@8()l3
o9)cIbaA;=rC0s/ph5d'Mon[tG"?HT1`$Ql"R3^/%$QqU&jmY+2@a;@+6EiVif-Agt>Af<^'
N@8u4L(\\Gc=`HtdZK>loa`Tq38BI08QS7L5a0)I@$,X&'e!(]A-SSIPP\@@pmim-_$!t/9kb
aFhcRKjC`dH@PWV<&moF.4)BZE]A_H9sSR('*]AHL1(\Z>X`H@`3;Z#BUHjBF.^L=5hdfQBJMQ
pVet7SgL'EK`oC4<=^2,m70<SlLWnSrO^5fX?j;27Z`WTnd[LCah(///\L\R9TH;Mia--Gem
-?mKj>WQU46%)K6)?MSR2C5pBWLPs#0't)NH)KpG>*,^8M$4\8(Ams?WR9[a>>(`\$Ik(hs6
8Mq?QR!2^`Q'g2W8fYUB=X]AB(:<i)>i-F+cU-T<Kf!-$H)@l2M"abqS`m?(6^P>L;$/$fU\X
/!7[^8:gJFUn.PNlH@SqR]AGuEc"Y=&22X\^$mkMoZH$3*Ej!rYR^]Au@G\]A,cq":tn.(V=Qnf
#P>b)(ftX(!:/qm*s@/;JX>pU[M[DaH':hVefB@dH/3D<UF7[8l?0c'j=`9*V56^16K-!V.T
[_(,gZ1o)0;LhZ`Y^-.[te;tN,gr/;8(+"g=+^$;C,J3)TA\c[ui`DaD+oPtI'k@e:BG"apR
J,DF0HeS$#fP`*R..62CN;Y@"DB+i<T;;NS#_<FK'bi\3G^H-5,JVQ?!c7OgbdSR0sEMW9>O
;ILtEaaIDcn'I`k"V7Q2fOomgB?=BjjMgO?@\JGeNM(!8&hZQksa@r^4gjAkuL3>'qVk4`hW
HV`[^VjNikC+@:p8@bc;@g9nOCM]A<s>"iU1Q7jLn$ihCum8E$.k,*aUn+t@'4%?SpT0$VhEK
HN:\O_^`$@5ZSkk4o,S*Z#H$]A&^Yao@%#>YR2L/UDdtNnS%kd>MpFs/k>Om[h1bgBQ4;4`,3
GDVsUo/FA^$=gG=gnc&NCMh=*W^Mn8X.&gR2IX+u*CJRbL9QW<Hd^6Jte;>GXi'1So,Nj_Kb
kuE$aV,!'6;;oEFiF;;]A`fNs?JRF5CcD3;cCr7@ma<Ime!^)M1)@`u(NTbceBJ\r,[391eR7
h,`(-4H#tG<g5"OEaUuKqA(;380iG3#$9ecXsc/V*WITn)t3%+/(GC%>>+)J$rYIF(;?OlMk
0XWl"\ul!nXAelPW`\fqEgaEghRiE4UCDSl+Nt24U]AK]A@h6.W$*TYQDfUW@d4-=*5$]A,QP\&
15pTEqE_hr?m*BXa9(O6I6g+,Dn\aj0I0Y:6]A\gNck4)8M:S:VZsJmk@o'7^0.P5ap5rM:H<
n)"+0jAM]A3HMQV0d7+k'#>%2<>"+QRLL9qBLN?M#r@=ZMuO'0KTXpWAj9C@g7p_@;EV0Xck%
ifA4:E(k';nKEE/QW?%376j1j>9sIDoDd,Rfe`]ACeKe,.C5QI0oEm$?6A"c%b`L78^(*:":8
nG4>*4?\7Yq<1mK2#Qkk[9SQ(r<")HVtR=8E^YI<=D_M5!47mrc.4I@b;)i['CI)ELXbc$OH
+.(l('QJ?l,ne`MC@.`r5H#Ero@`WYcOEMsWH\7t\9/`MP*fH)MSR0-p5\%d\eaf<lO+N<f#
5DEG(L,\a2$$T]A*^?YKmE=Q\#W@[!8Kb9Gp=>33lYEc/&jM(I;YQsAIEBgS_E+PrX]Ao!Ila/
NF1N:uh:oO"R/ck%+)0+Zi;2$ogR,@o9C$=XNY:L1><q@+`5pI:]A0#[DYi;Z2b<Lod/NuCm1
>^WhU`-t+lo2X3g,2S-W2pDJAeW><Vdc+HoP08g<HR"eKt_#%%KblSD,t8Wp=,8M71mCc`<k
e^55?Ppab?E,gt@P:LKZ<F:GJ`LND,u8knIBTP)]Ak-WYN^/aMt4`3fG\&g`[$CQj?EMkm-A7
nTO1T)g!G/CC\ip4NX_S'e+42fchG]AT_cn68$D'`qD.ZB-_DL;MY]A/Gf92fZ?6#OgrBjIU45
C(AhiU>>%*G'QNuX:(%R?`44)cJ)3:N.1YICN=D8iB4%%!;eQjQHa^2)K"p<\p6Z/e`'C4U!
bi3bZ";k[tUd:-6k6"<+U6qi2d6I,>eZhEYL;_ZHnheWL_ZupkCRY:l.&PH^TIGcNqM`k^SG
NoTEf'Kk$[f[ruf'Vq*+)%IQ=bm4=>EE_9ZG1;#-C\eE@f[Ki/nKMa)16@>:VpsY/`f(&;i/
gfe=H@B9BDp(!FoIglFh,uS='r)+iDV`AG+gT?#7?o6h5Jkm.<0<.Xp,!LAKh;ls?@=(mFBE
ri8PkVgaM86nEA[q]A7ag1eF%;^HeCQCofbJYh;cJY_Eq>dN`&'m/khM*a#OnL0b3K5>*.Yh&
A!Y[<T#)VYc(.B0\kpEKRI"]AJmlQ>\!+?LFonVAk'M7KZRSH<>N3]AJ+L;D;b5qorOrbmA8A>
8A_c,]Aq)$A`I,5FLB]A<[l+I,cj`*=PsQ<WR54jW72LknL>+Q&Kmp_BW_D;.YMV$(s>el7)+#
;i(*,-lBR?bgUT@,I0B4-=Haokn4N3I.3%3(,TcOuGHnR]Aep#I*HHBfgW[1=-4=/>M561hl'
Ok9CDSfTEYBV\mHW#:6NS_iUXdSB\S@(%i",kMLjOYWcIWN+_;if7iH5g=mrPA2`d'[\a2t#
p$(!K6hg!ITd/6%l.<\#N2#AALln^!EW5XUK:DW&#W(l'F5u3DCR^l<KW2SUh)#&W?-0H:0W
8Vu)?<IB.-!tgD=I;]Ar5(>4ljq`dgLXAol,EXO~
]]></IM>
</FineImage>
</Background>
<Alpha alpha="1.0"/>
</Border>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[D0gIM<;ZRmR5nac#%Pi5@Lstk-A>:A80k/X#n]AWu8qnn=2D]AC@9,fA([,#!/&k+">#$htm+t
>F38@EWH0>DSjf(XX]AkP+fDSF_1ocg,j>cguHID^1+Ib=5B78K7^18_`W5NW=S5!<<d-^a!b
M.NaWQJ5o1L<`Gu\\KfoB3@bU$EJ$/deXF(d9VGW:CP5oX>Wb@JD%H?d<N\/-R61pU0l4-17
R%R#b"be]A,]AToU`jq)%I#SJ?_%i<&;:ZLa1*P:*HM&%R;,[,67K;6iIkR7Mr]A2l8<"`+O)ms
qXAu)EH6;5=QWh'Ln06raO!O>Kd0;Vq'J1j@erVZE:lGIK7e;.3a^n>PLpI_L/goEB.WqeZ&
*(Ohqm!R"8V5BS51#pB"[oI\2din[_m&9#/8g!G,/_i&7_DNKTV%tmO\O,`BhYcGXE]A`gUf2
KP/HOa--D%tX9[$[Gc:Me&)Dc\3iK#gn\MS%YCd_\D[8eM>aE7%N5$[?`fs%hfMJ._Z:r<4J
B$(d$!/]A'Cjc;Vbhmi.8/c5hkPQN_q%pN@#g-nC-(^6&oD!e^8n#?^D*,MRh&AVf59jTg1[l
:<V9/)-E@Th,:+FqTdX.F.Am]ACq?+D4%Tg;m@FnEL1^tP+91!L3j'h$N:IIZg$`%EtFFY@81
\<jHdlur\UK:@9NakT$F#)J\frNGFCPr$)GAMniLo*ngCTIY.s&#^X"hq)?hqbp?e5AC%R+m
B$,]A-;@FMA5N5"'>4g6dReGu_XOW!rqh=0TZ8gr-e^d9aBqJH@:)pX_W,$KKJ6d,HpdL:D,q
i%B1>oXa5-$@&;X8#0e]AYDp]AZC8CejV'(6`ql:?q1M[&a#6^35iQQ_VuhNVfkt1YA8B)GOj'
facU/DPTjui:m;l.$i.;:7bB=N:,8$^&0&ftrR)'(Lt&r?)osXsmgcG`Gkn`@[C&LRC-+t/X
aI&Z<u")^>De!X]AkjLUa:H:1g:$?#q'2A1SlU7>Ke(g8UofXBR_q2.OGp'W,W;/A1Ee#RQgR
]A;8X34mUOrY<jM/HWk_lN*EWWMU%(l9MLrJnM:JYDN8ZPGLX74q]AmUeN_'!?+m>B"[)q=bg?
h$D`$T+K3FKL0%-X\KqdO!V"&J-rKC>OG<t8KiSsbC1?j)0J>$SF0A95mLf,Xor`=1!J'#fE
E+Xgi,^:>EFl),o(#`3`-b2g]AQm('<VQlTOn@)C(#6;$T!Q10HR1c&=LbAD"Gm"HK%[7\=u>
u2!M3hN[LN!.5/55%YT-j7]A8;S.7&?7nM$m902(jslm2:fMi0^c\L^O>XW+pWg#9Z0S7aXhX
BJe9LDc*P<3inPB_t=I*<kj;)9MWUGH=="CsCHEb9*Y@c=??drGJa$(1)]Alf>oOJYT>'!:RH
=Ga.*$OUT-56#0ULFOa%l#\&PV<Anat`ZXB2:j:QG*hYaogoRcAVCnqWEIaG5[FsLPH!Su;r
AA\?=j"#;UlKAbGW!ttPpDm8;hh@G:#8>$olXgY>=T1]A=EPtftM\f&phk$c(DN%+Rn=&:3'S
\*k;J!)--ZDgqJolqtT_h4]A<NrH7\kkmC-I;2"lF'7\f,Zb;+E9sLS#&hnSR+F8p0>7H"#DI
n&F%mHC@`CM\?WDtGDR0P_'D<oo7n,GJ]ADF,"!'Ye\id.ZSG:LNG9:UMoP^2>/PY*c?((i2S
-ou>I\@AHbp'O>:4rP35bVgGPr(RaTieCk]A"2`J3p8R'W&gML\DD"fCnr#"(S0oG`2i5W!u$
43('B0>3d71tXg\*;2O)JQRlOJ?@EdT,_HQQhT!=rG[<n_bL@/2L]A-p7j0hk^]AYtH1i-\gut
niba-J!9'$eV+5R-qp#K]AY=QBVd%,*=_O$n^^"a<2HHND3=oc6DPCGeJ=+td&GGM9^/&q/da
,e!g>@B]AWDr9ne/qfZ0m[e6Ds#H-ICSNXOeJ3Ai+[`869lU<V';@N`I)&0jlq@0S'I;$^Jsk
[C?MG>ShBgOS0Q@o<0`h8n8G7n=@_$hLDbLJ=9@5o_)Q>O(#$sl_7Le2gLf(b=(g]Aq'SC2)"
"Zpc%9R(cI@,Z-h%S!)I+F9;_QO7SI0gN%c?&8A:s^MA`&>O-YOIe_Cn4@k$5=.Ig[]A`KL%s
<gCh`$NR_uZ-io5#[OXAcr]Aqhr%%!V#o4=a"sP<%$"(3qsgI%[4#Z[n,npgSm=%hTd/a>s>_
oS7*r3.P\3,'K*!13fT_d=]ABLhp5YY:,H0a`QHGhTbFtK]A[NeB*$n8f5a[bSB',Wrf-hC7gX
chTjEh_)#7u/if`#:07M8HRHQ[WIl7Q4YPXO71G@m&+:#DcpMc^bK!*c!c!gKe'7pNc&8Y=R
41bjt0hVIaNbIVohqS'`9\GF0n6D`+;[=i?X-Fo0aJk.(P5hob(g9$,<@*;cu;)2R<DVJF\U
8$\pn3,<ZX7=ETj]Akg$gCjeZKJJ$]A$_4U+e:?jc-Zh6'>*)G&"ITA2S$%#bJ2JTA)rA^p&sl
bZXYdNeRg'43k6_$R3:_d4/B:_G^X.E7eTl0CidH&T1qHsH-I(VnGfa@PmL:2^DA?P>SSOod
qFf>@98:r77tAM>j'l\P<>(JL-d9n/G3dCdh\/nGF"!j`^l/)u_?p:ndh903:$Ji@/3+.%EZ
3"UD%']An3"-9=Kg.k^2K;ta1Y)h4^j)X?DCA6"@@76@pj2VrhGu)?D"/OfOGPQ[F"G05EQks
E1N!;=l'$[d(F$)Ud%$KK]A4!\n"u_"AmK.Kn?f[nU\>2A$B@YQ@!2>k/\;r%Z)\0CAkT4B+-
13uHH/=\o='9Ou<!X*f'@`qs&OBD@5Ru+t#pUPh"+Cg&OXG]AKRV\!7U6hJf1duKX-K3Bo;qY
\n9t'gn3ibr<>t3O3+s@/G9e?!i[&;l.9hC_OLTC^Wdl0$*g5$s3ZGLhf4R2/=4R-;;a-04^
r4&#N#q)iIAf[$<5Erp[O@#LHASaat$NT8ZeF>t,c?j&]Afd.GGE*tc4lYA8Q>;s8%ijXep>%
kbQr3`gm=Kk]Aa#"0UTWb7dZ#oEY=@RA/c1eLMB!_;-@BJ_N3;DE7n?trt=@[3@<cQAGu+iBT
ChAm:4]At9B`f\P*:Is!g@4e/d&>>3Md]Ab?.$Oj=o<Sc&mLH9Ll;EXhs-\`W^l(Gd/iIehB.J
U#hWgrr\tipoS:RiTFW.1eJJO7"leF+9k[[8D$U(A1[e;6s-`bR_XKj"j;8b9*):Fo)@gkW@
)bGe%op%&UH)^73EFIK]A^gg_+/)nJ$7;kcDJi;eWW7jD@tU6+\>&Du:g_!5s(2MTqUNgm`eg
g0uh,j*,SGar*eU)?goJKf:XE=%4S=aFd+`g@Hj.8]A9!O=JU;mb;nFFgWJG#!fa_BJH]A^n)p
aU(MYi^hp8qYnhp\un_JhK)Z1.HESL]AII+cM>"AHGL7jiogd^nnC:?,;6.>WM^LD2)^kO]AfM
'8uRdoO)(<);VmUjnK^g*@V]ANXVrFLnJrrnfStmVqC+sPCdO/_m%6iFqoQjm)rS')8&W)Uj]A
OF#!kpR1;MZ#$>X5&R\5r*fQZG8*+^7hHHgN"B2X>>,:c5\QN-uC+30^169/9Ps-Lhg7,gpu
7IKbYCA2fi:fUG-(?@\G)lUU&gP(o.)S\_XYc!7ULM',?i-@g`oV*C!,2l5426gQodX:V3uq
V4:p=V)QrK4D`8"<#28`^!H'M!)@-;O<>Fq2SmfdXGnL$*shbHZ+aq:jHE7=,N&;4:ZmBY_%
[o@'ZL6ainc$l,]A@>gUs'h^QSiLP#6+(P^3EVFM99^B2;,DZ?SXB=?>?MB5#%[pdb#$a&t!a
dU\ZSfZ">^b`iW@J=WB#Fs4I1<nqe$lT=@:$GO!t83`f/qTiWDY9tbjGLbk".'C-mVH1<ThC
q-Md,Y2Q\P53pB-7@O=G+8>]A;!;3e4n_t).<.RFNit;R.Ha=n^%,2:fTG*HS4s)?GCm50]A^+
[qk?Th9K]A1QLUqFZJqobUj,L6QQ;"GB2G;XMcp[Y]A>=f_enj6epi+\@u:F#3o*G.#NPKAp9+
1Vl.V2'i?V'K4ok?'2t]AoQ0Og9Cc19!s$W\gr;)oS@?CC+;6B1I'OO&ji*.QT$,CJ^P<&ACL
eW"h*$om680,dW0mn.aL@gW=1[>8%UuI:C:nA`GjS!;Umh"RC6.DRr*\+G1"_u`27SS#!%$L
,64O48brV1baBo8(<,h:en]At.V]AK@C4#0^%AD/paC!s@Jj=7!0TUFbq.ReYbal!=B&oO\^"&
]AZ6.o/"pLph<$_!5M2M<77Hppplh.&##okgcNO\r^0^@?!o&gNi=2rVX6o[@^F#q9hHI[_"[
<\L>1+0CUTQiEOq*CDlpG]A!J%VpG"U3/84F@0"T+P5?q^GaiVT1S`kn(-M.QCYGlS#a'P-OI
q)nIdQnJ.`$P(gbZ/UfSa-l3e07"fU/[3&GKluTg,Bj1%5p.6s%n$WJbt-H\ei5E,M_T<QPq
)6A&4KJS[mGMQ$gek6TYSV^0ft+l]A3>c8ZVG(//l6"lp$`JL-k,:b'LBsNM+&?p+PR.K3O*V
]A>NoHp\^8H[O%POMOT"[/6r`!TWfQt#=_o<`MX\,VW7kArN?VQ>20VW%]Aspl[]A`ML(XJ?++N
NRlG-+e"MNt[Z/q3BsWOnVLl.)n(:7'!n?g_9Ru9dtI^2V4-U$h^P4)Ym/[nCG6/f$.dFG89
3N9!2O!:cS@&'.Y8?b+RECA5kqjB:_9K6[nWpMRm-'@10en=L$3]AO%t<-h;=cJ>$#<48m/,d
+,r-6I[ElJO_#Q97gX^4.4Ko+G.;bR7G)^u`L3n]A.HiD)QT<Fd6V4L+f_0^-BDsf_O/>CBjB
5_^FsYtFKZB>`5bo17UjZMLI$GG&]AUI;_@LdD-g170u.K$Y=WYS7<Jb*"Mp$fA0MEm&!(AF;
J('/Ps-e"Mti_sZP5C7dsE!At11ho&c9jVMcql)g7,1Y9'XdbMV+)M?o<[&r[G("K'A5bjKE
m"d<;o9K&[S8,CVjm#rC*4Ml>sIEQ2n`WdKPhHeKt;^EWOC4*j6s=C(TlLN[79"R$uF_2#Yi
&P[VImY<f?"kB]A<B9im1BfSdEXD.t@l;CgIa&Ca_eR*]A,tFiO5S-I3-NFXgEoi%lQ;@X3=".
I#,%$SP&d1<q4/'ebEBAqas]AJpft?jrk,P8fn5ElQIlF;$<Zr4CPre]A\qVgKSpS2>_8I_^fQ
_POJ*SjF$?oWV&rZd?0U0NHGbq=A\j?M6.mJEe,9Mo!^Khq2cRP(-d$O5ZM7*-gpP[Q03p6H
mQtQ<:()0RlXMZFjGOEqj1En6,B:HHe06%ImDnHi4htKPL7$p'`fS=pgZn7"f:.CF`pd>XRT
9=FN#=^'-'2if+R^dG=]AhPQsf"W_c5.m+Q&4AsN%/9S55?=[=UNtZ<+`&)G*C=cGG4ZVKHYh
4G;gdoM'5tIKd,gc6eI]AL93@C%nCJP`d5nF$1#\SbNi"$m<Tst#>=8p.@;',Hu=t7_(2ZcDs
h_,5W#n`'mh0t-'&_F!/@g3iK[mVtmq8W=\^'m\+)A#rE;]A1h[0QaK`$WWKK(^d$HfW]A+IN>
C)T-KJWe.(;Y!$F&@X'(RN-rAS$lr,6[17M6V+c=s5=a,I*4lJRR%`DJd<'hMhf-*`o&I[\m
f'3%-BaG!H8VD99W7P<_.$=Q:ikEa-qlgS%Q5h2[l@.nZ.q]AfReOP,Uu`rQsp8!*WP.1(kc9
dr3mG1>1/^BML8(R:CbiF8Q.qF^_T=*jPdFB7[_8!&ei=G5UFG!(Ue3^.VSOEW2Z=@2+Ks%/
(\fI'qpEem'-\3E$!aOjr,RL*o"kcR]A!-O?8%cin\.g_&Mb[4]ADW$_k[?AAC2C,_FKo0;-,_
"dG]AKjtEH^VLL'5&r^OXi/Kj)i.g5e7\6)Q<T^B:M-E^V$VZ:QGJ?Qnm[8M,#]AgG0OgRF0jj
`=i=WbJQ+e#QZ2Zp^WciNH>%Zl@DIMj[q7U]AOToV.T'dKTV:ZSLHRc`K_PWRcR*r%eAb,k)^
eE/7O!F`tGX)QW6uN:KFc3dW\oLU-qAqU-M5dsV/mf8$;&EN&oCnol#.;]A<1Te61']AE=O*`&
c.E]AA(cqOC,YZr?<WcDoZN:SO4=sB/@4S"b.HiW4&A0]Arir^G3UkB<[lY_.05eBZ;B\_pec1
0hs&G5>CN\*l4N'@-)cD\SReWt]A<7]A]A>\)?u)-n6N*O"2fiBe_XgD$rSVhmTV3gtjm6<N'$t
djRk8'F#??oOR%AT4:1ch[Or:nj>iXqp2q@\.IiZko=t9HqYC;b?6W0AB94nj=;?k@qYt("W
IF".?Tl_adfY%C``D;;\efUf-JR*2L=RGrKHIAJeLF+"CZ>55f6c@.\g8F'@=Ous""LE1-U1
d=nH3:["Tbk]A&8%#`9_KOs,,"pqrW@fK<enNAX'ftBHd#9k6NO6?_f;U"C"f$Q%1E8ZE0%p2
Q^0F:\V`"oN6trZREMH36M#$:il#Uekb2Er;i>Pc3b5U"6J#@T0bbur/3]AY)R7k=SqXa>KNS
%!A`s)YiS5Q5TN50+C.RbjI!c;G2:.*U%7;SV);s*)/!LEX,<+]A<"r'gj\3+H7UDlr$+91Um
PQ,h)//pWqp6Y6Sk(=AAEs35)PE8_g"Wsqq#;$jk*uoTEVda6pd9NORN'K",pWUhXfEku"e)
>`f.h=Q<)7Q",bMJ3bNi90shd@l;W#(KDs!%2MW5o1\Id30%Mi2!N,Q0^EKYm1<XSQgS;KU;
!fg+QPnDSKMGJu+bqQg.c(]A#Re<r\MVeniat2;&P9hDSgl%Kg7u6ca8*i89/8AZ@.G3*cepW
":#N1B5nNc-3ePo4+P/-P6&)'`O$jR%"@<%TH_=dJP]A_=,^k!TJ;>cHKrgg.#1JmNlbK)9m%
//T@+IS!qL<sCr:l)IjS?#"^EM(]A'stRAJeVh9FR?UCi6Qr:p/D<rH^I::%ZhiLO2rb0h=dE
gkC!fCj'RSkursqOWuUAI1",J-0]AnM6\cu,+;Y4SpV7-$^m).ZFWEW^\a9knc/drOaO"R]A8R
G4mcWgJX''!Saca"kBUTV\^1DC&^12=Pe?Zh%S@8uc)rEhE@V=,0r+;DH\s,-eg%3d-iT1;-
%QS/arF#Ph]AD(WKBBV>-On,u5&4m>;rV#96'7^8aOq`i4$?aYi#(tV;fm1CE'c5`dhgrj3)d
to]A%nga/O^t$`p/B=d%;f=3r59=]Atr617l\m-K/N%hLbMG2t0]A!>_Z-)d:&\]A?<;4nhM&:<9
7*H&#EUL5dU:IqfV^aA_,uB!-cWW/m9H(b>nu+JY<G9+h22,JH?)nI*.S?$%a_X&.)/HAXoC
^J1]A3#sN8S:;?q8cB/9DH@AX07F6/W)<"?tY:*(WqC\M+YtRlm'&gM=<9XN1QS>oD1DJ92%m
U:2r#U+sA8"\M/OkA4'[fmP]AR^rpg=p3X\K:&YL*P16LZ`f6;'F8Y:':-c3SDX<CH_N/5)34
k;o%?H%`fc@a+PX-c"9fiqfAH+XhM>i-BteLDf523VDiP?7]A(?ieLZqlJHglb0L$PVWHB<n"
)okddlF`M%1(UE$@_LVA<JcUo-@RL0M<UC$7!J:>8cbR1*OL>GVB6Kr49Y<_pF>hL\""5_%+
rIKL^.PEgps(6/=+s+8CAM4gE@8F?Y**BcN#ODbZ3A`e.sQkGsHch7=.d@;Jl9E9?8N-<:R<
ht2'`YgdW)=o/:K;KNb$*T=X5]AE3*JB]AJUg9<Nu/+ITY$b.>`*G#l9dn6D:lrM(M6_7\WBU(
cN0JJ=0CT%-=,j3KSeaaQf$-*UC8)G=?0Tf7\eSX.@N4Ma`!o&7[L'VG#OX4DZURj-u5$`)F
Y2Ehk<M1apZ<`jl>0_`]A;_nEc8>.V"4?]A]AST(\*p:\+3]AENkGkR:@>Jdq4JU;^ZEYHW<bEVJ
NHGid,dMJ7*<Mf7l#p_X&-liQ\sa-'SDR*a4><Rf\!9A[jGN".5jD8-nA+A>N-6a]AM@8()l3
o9)cIbaA;=rC0s/ph5d'Mon[tG"?HT1`$Ql"R3^/%$QqU&jmY+2@a;@+6EiVif-Agt>Af<^'
N@8u4L(\\Gc=`HtdZK>loa`Tq38BI08QS7L5a0)I@$,X&'e!(]A-SSIPP\@@pmim-_$!t/9kb
aFhcRKjC`dH@PWV<&moF.4)BZE]A_H9sSR('*]AHL1(\Z>X`H@`3;Z#BUHjBF.^L=5hdfQBJMQ
pVet7SgL'EK`oC4<=^2,m70<SlLWnSrO^5fX?j;27Z`WTnd[LCah(///\L\R9TH;Mia--Gem
-?mKj>WQU46%)K6)?MSR2C5pBWLPs#0't)NH)KpG>*,^8M$4\8(Ams?WR9[a>>(`\$Ik(hs6
8Mq?QR!2^`Q'g2W8fYUB=X]AB(:<i)>i-F+cU-T<Kf!-$H)@l2M"abqS`m?(6^P>L;$/$fU\X
/!7[^8:gJFUn.PNlH@SqR]AGuEc"Y=&22X\^$mkMoZH$3*Ej!rYR^]Au@G\]A,cq":tn.(V=Qnf
#P>b)(ftX(!:/qm*s@/;JX>pU[M[DaH':hVefB@dH/3D<UF7[8l?0c'j=`9*V56^16K-!V.T
[_(,gZ1o)0;LhZ`Y^-.[te;tN,gr/;8(+"g=+^$;C,J3)TA\c[ui`DaD+oPtI'k@e:BG"apR
J,DF0HeS$#fP`*R..62CN;Y@"DB+i<T;;NS#_<FK'bi\3G^H-5,JVQ?!c7OgbdSR0sEMW9>O
;ILtEaaIDcn'I`k"V7Q2fOomgB?=BjjMgO?@\JGeNM(!8&hZQksa@r^4gjAkuL3>'qVk4`hW
HV`[^VjNikC+@:p8@bc;@g9nOCM]A<s>"iU1Q7jLn$ihCum8E$.k,*aUn+t@'4%?SpT0$VhEK
HN:\O_^`$@5ZSkk4o,S*Z#H$]A&^Yao@%#>YR2L/UDdtNnS%kd>MpFs/k>Om[h1bgBQ4;4`,3
GDVsUo/FA^$=gG=gnc&NCMh=*W^Mn8X.&gR2IX+u*CJRbL9QW<Hd^6Jte;>GXi'1So,Nj_Kb
kuE$aV,!'6;;oEFiF;;]A`fNs?JRF5CcD3;cCr7@ma<Ime!^)M1)@`u(NTbceBJ\r,[391eR7
h,`(-4H#tG<g5"OEaUuKqA(;380iG3#$9ecXsc/V*WITn)t3%+/(GC%>>+)J$rYIF(;?OlMk
0XWl"\ul!nXAelPW`\fqEgaEghRiE4UCDSl+Nt24U]AK]A@h6.W$*TYQDfUW@d4-=*5$]A,QP\&
15pTEqE_hr?m*BXa9(O6I6g+,Dn\aj0I0Y:6]A\gNck4)8M:S:VZsJmk@o'7^0.P5ap5rM:H<
n)"+0jAM]A3HMQV0d7+k'#>%2<>"+QRLL9qBLN?M#r@=ZMuO'0KTXpWAj9C@g7p_@;EV0Xck%
ifA4:E(k';nKEE/QW?%376j1j>9sIDoDd,Rfe`]ACeKe,.C5QI0oEm$?6A"c%b`L78^(*:":8
nG4>*4?\7Yq<1mK2#Qkk[9SQ(r<")HVtR=8E^YI<=D_M5!47mrc.4I@b;)i['CI)ELXbc$OH
+.(l('QJ?l,ne`MC@.`r5H#Ero@`WYcOEMsWH\7t\9/`MP*fH)MSR0-p5\%d\eaf<lO+N<f#
5DEG(L,\a2$$T]A*^?YKmE=Q\#W@[!8Kb9Gp=>33lYEc/&jM(I;YQsAIEBgS_E+PrX]Ao!Ila/
NF1N:uh:oO"R/ck%+)0+Zi;2$ogR,@o9C$=XNY:L1><q@+`5pI:]A0#[DYi;Z2b<Lod/NuCm1
>^WhU`-t+lo2X3g,2S-W2pDJAeW><Vdc+HoP08g<HR"eKt_#%%KblSD,t8Wp=,8M71mCc`<k
e^55?Ppab?E,gt@P:LKZ<F:GJ`LND,u8knIBTP)]Ak-WYN^/aMt4`3fG\&g`[$CQj?EMkm-A7
nTO1T)g!G/CC\ip4NX_S'e+42fchG]AT_cn68$D'`qD.ZB-_DL;MY]A/Gf92fZ?6#OgrBjIU45
C(AhiU>>%*G'QNuX:(%R?`44)cJ)3:N.1YICN=D8iB4%%!;eQjQHa^2)K"p<\p6Z/e`'C4U!
bi3bZ";k[tUd:-6k6"<+U6qi2d6I,>eZhEYL;_ZHnheWL_ZupkCRY:l.&PH^TIGcNqM`k^SG
NoTEf'Kk$[f[ruf'Vq*+)%IQ=bm4=>EE_9ZG1;#-C\eE@f[Ki/nKMa)16@>:VpsY/`f(&;i/
gfe=H@B9BDp(!FoIglFh,uS='r)+iDV`AG+gT?#7?o6h5Jkm.<0<.Xp,!LAKh;ls?@=(mFBE
ri8PkVgaM86nEA[q]A7ag1eF%;^HeCQCofbJYh;cJY_Eq>dN`&'m/khM*a#OnL0b3K5>*.Yh&
A!Y[<T#)VYc(.B0\kpEKRI"]AJmlQ>\!+?LFonVAk'M7KZRSH<>N3]AJ+L;D;b5qorOrbmA8A>
8A_c,]Aq)$A`I,5FLB]A<[l+I,cj`*=PsQ<WR54jW72LknL>+Q&Kmp_BW_D;.YMV$(s>el7)+#
;i(*,-lBR?bgUT@,I0B4-=Haokn4N3I.3%3(,TcOuGHnR]Aep#I*HHBfgW[1=-4=/>M561hl'
Ok9CDSfTEYBV\mHW#:6NS_iUXdSB\S@(%i",kMLjOYWcIWN+_;if7iH5g=mrPA2`d'[\a2t#
p$(!K6hg!ITd/6%l.<\#N2#AALln^!EW5XUK:DW&#W(l'F5u3DCR^l<KW2SUh)#&W?-0H:0W
8Vu)?<IB.-!tgD=I;]Ar5(>4ljq`dgLXAol,EXO~
]]></IM>
</FineImage>
</Background>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1866900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[853440,0,1981200,5638800,853440,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" cs="2" s="1">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=$name + "分类销售占比"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="11">
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="112" foreground="-16712452"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9>!@'6gmnh/2!!>IiSE65>0U0&').A1^dao5V/f2Sl[.[jps2G#>T'(gE4A6HJk(Qb!MQRK
`r?XHsE]A[=F&M+cqqg7-.o(:np:3L_'V7!AYh?9Kqm_mG=b+)4o$"luqj(njf:,biJM<c?nF
>T(AF3o\6ibT6kb?ZZG9QH1%g-CKPZ?quiNGkK0Bh4cOkGs4GZWkKJ4Xl`E%FraYt"PA\p+J
N(ogQdh^HVu)D&Vs&o1SeBq/me"BDp!8\:ZDElEjb6En8:Q'GKo=82k5>.g@cNo"e:cGWe=&
/UmJ,9p3n,h$6Df'+OVasM6L"3eP`nHY2oKSo\LiDOfmeU^!@Wlp.Q;Oe4-2CS4jceB2<Uq,
G1GQ!Ya`&,MD!F1^oeB$k=-nY=g9eac&-f<]A>#qp[Bk%>Q48mkAoL6=p=3N"PfO+8>CmVFNW
8R_EKE,H'k$e+dPTCOe))0Y"0e=q-WuhI2[kZChDiNXL^OiV<ohi[1Ip+`)Q?<%:fMu7^fY[
ie(@1\EgF:RY%Ok"]A)DSH[n+aa&4sf,PPhRJ6I?W&)E-rbkR<7BGB3#4h"j5_NE@,1dGf:3W
lVh.Zk9`g<1Ya$>Mg*I0TFD_%tf4Mk81gQfJo1B?+7[^7lG3mKM^=)mQQFY-L3NtE$),/<o.
\,Y$BQI)9ofc!WFQepM$SS1H0fdr.^nj(u6"-=/%W6^T=T)Uo&is<2i@DSqMOa/!BTc]AK:4*
P=@=V2pBmU#3M4rl*ef^0LEFa!]AlF-^@sLYbEAj'_u;kP#2su,T^GV!+Gjal5T8*"lIa>-0/
)cqKK-rOjEGJk1PW,.e^lsOr]AlY4B'W^4`m>^>O2%$<X`@'KOtecK52$llX'[BlTk5H&5-)#
!.+hGg3=J[?C*9XiW:@4'YuQ:l@Bb%$P[GL>Qn,p3Z4V*?%9_rJs/Q0QfA+D-KA#TSX![SuY
ar=(>ETijef'B#UE:r9YkO9KQ=3/M99OJdRjSX$r6RtNfd:EQ:r>Sf<24T:_ncIHU)a$n>Z;
+5/S#cHLZuhVK&,%qVs;*XaS@*Voo?D1dK%_nG#rif_B5_&.Qr'DP"*kj6JX?,9IZZlZJ]AU1
ZeDtNrJ7=H[kIq?qD$\+k6$o@hV[.L\U!Z&I*<ec#^NlkoDa&TDc\$]A`9/);.S:1TDH,?TlW
,Xi)/c:+gA%GPg^Pp6.u!]ALU5R5$:`IW[Lc-MSp.r@#!.A#AKY))XJ+EPAM@3^^l`#bi,Q:6
klSCmf%$\'G$4=S^Is`[<DG)k2%[#?q$;<Oe[,iV#,M$8R5]A^VAQ]A(Q:5k>%1nfAjQUJoE`G
$[=MqA`kUA(FA42WMD08s.s*IMJr%?Jn0:B'nala'I/d+M5d3e%.,/9q^$308^"Y?:W;Nhlt
(XMFFnR*mT5HZc`g=WU(Cca(,e<jGBgK&.mjs'!b_>*AJT?XEAUW_XP)9HHY59m2kHB>,U$T
fuBR(GGNj>,kBZ2QOFAR9D.YHfZ*Ojp9F(UU)8P@b(s`GGuoki#N"o3HV4!kJXdqT2XG0F@>
@nHK]A5G;6qso[5dQ%.S[d-s`M=G8C=b?GqtBT%>dl='W#(KC4S<"keZ[N))c/'47_P.g(FcB
o%[ZPc_IZq(n`aA%!`B-P]AV%\`NdI/9Z<)m7_k)D.[:PlAB>8KY7;$i#A0K5[5^ThKATD.\?
sA>(o)@R?7<F*T'V,%W2oa<)I&qX-/Fk'ZU'M</E]AhUp>V21=69IU&8IdG_WJRO1RH>,9LR,
SM7SDB*U=Q=TRdQ]Am,erU\E2EF#rFRf:EAUa-9JddJ]AVGlbA':GTflut-m#^!jMtgNd'Y:AI
J*o]A0C/91*]AmL&,OP+PoJOh<Lbb-P^Tnq0"/Ni^'l<[E;^JEV?bOIio^f/J:B#CMHrfSqq@:
6a_VT:Rg<O5pFS.Z'OOC#hOcdU0F<hbD$lFtq]A&a9=p\4PUmF-VY_Ptq2Wmk6$.UN9L3VF/-
6pPTgCdgtUJc/BD?WTtC6ff^r5UI6CB*]Aq=CA@]AAX??MnKC"%)')Du6:dedW+g*b#XDDX^a:
YPn#e_0!mM^CA'Jk5KEcaurQgoY'hWhp+oX$,m=fQACY^?am(0%@$?-p\\2_!Mgor.=(>`]AK
CWiLn8O6>h'27+7KD<*AqqHSs-4FlU(^08m$!-q@L6S8op-#-7/`fSFS@-4o$4\:<^c*L\nT
lG2!bc3s[n(o%U,3VOohVYegYU$csA2%]Aa9,\ZaZGG=3L2N#Lt-]A44c!LC>WM$:P-e1&"Fid
T]A":r(UZI;[?]A_HbEi0tGGG2/j.mK9P>KhsB8*=kuTM[^qNnU'h"$V%.b-_7A+$'F-*#9iVt
L(S0Q)O'"7D&+$;0cY`&q9f-[?Co6&@IPgFrXo3r*7B$]AG]ASgY8Qa9]A04MX`-3b9$(@D>I39
(L?nJosiSTNpOA[@l6Z?ol5:CW0#=KcC<ki3\%3WOQ+r(-TX[V'5FL<JqKT8p''ZHJ4WOQD[
Sci9a!0]AcZ'O02puj"FIj2/.W=QFmlT[+$/D_K26B<B\r?Bg<76t,<U/'0X%rTb>lEU8P4R6
ZMp]Ao?9/Y708"0^-KC'8DbYlDMm95d?IJi`<PQN.+`&0-[Ml_"2f.+p)s>QNg7Cs2`Z`V8@_
8Ci"$h'V7;En:gXjrFhfs2HZj#OFCsNEVnrcQZP&&9+&.H'Sn9ptcmT)4qXeoird$<j8lu`?
"l.%&gl*d,L`FV2IZ^@>7N9I$GZ?NCml"+F5]ALU.6%7O--4j66i6B.-`Y>Sa<GpUV(8>_E@6
e]AWqHH;*$/b^TiAj84W'Yj+N\sXbt@-lk^;3<L@9K$VhiK%b"*F7-V(Bf^MC.-;NXn'Wa`uo
2hfJX%j=r0O=R4Y]A2[Djt(5sNsUl-^SNGm/LRr$uF8<)KSocdfXib4G/&jh7c3X7p8eO?Cm*
*IbKQV3VP<9Atr/AJCb<l'T`[oCVUP,tNY62eK#eP>jG-9Kj5qheZQA1tH[OP_)h$Ibl_>a2
fB+jrPU+"J,ibW@m_!mPs5L:k[M@0X==\#_h"?c3$\1[piOD#rkOA2fs0sI$;GJ<4&tgY>_G
e/O4!pAFW[\G1f[oe(>sMXqojN&-8eFL>&S5`T2,@kf&d3:)ARiOQ6bIUB;h778EA+-K9sa=
h/MZXl(ONE%-M*CfiuCfDh8`QLhQ)o#CeJ/OJbr7*;i?AXENrd3f1.cBm+8OL+_4b.Elff!F
.FH$T&rQ.D%5Stg*b[#j^(LSB!r3%e+"j`!Gm\X%g'>dr?`//Vr0hbVAb1W2)/m@=d"/bM_W
3WjEmoh?5mP#o1p'UE9I/YmYqhJjX*@KL'9d.(o,S:T<3NNSB$?r^2U]Ac8(b:DBPcjUZ3:':
WDbS&<%MrQ1g,FMSd[rd'@t($O*q\W5fY:^n*ehmoE^4Ou-%M%X]A7j=s@d+FH';05Ah4R%3Q
'rLj_u--g$\)"j!e2Z8>D]AX/RXl6ROdem\U,4MgnmBX7,u-VRS+T[;)L9Xb@NMMJUPN:^)cL
R.>V"T(]AcI>[:#s3@h8]A;L5HKb`4/8u@^ihQZemlB;8^r!EXil(`/0Q,0^W#LY6Qrmu32Hk!
K,Z0dnYBe)^<nK%^*kFL>)oEo8XY=De"3IApm%N;+[fu_3S+\@VI$\&`2l!807TPRQ*]AT]ApI
[42ut2rFtA4koPi%>Oq*]Alud)I1*fTKp\urTf*8aO(SgI5,kF?cT',.2<SeN\bfLMpqMarWr
&bj'4;TL#-/Q"1Y*PYM7Y-($T<0HmHIa+W]AE`O)\4G';Y"\'W=3Zmh:[-+MO*'@).&<XYo6H
M;Y`g"i;?WPCk9Qe<0N!E*[:qtUTbVXWj>GR`^X*`UCp/?D$El;mmilo!U^K4%U@L/QoacGY
RKC[Z?u'U;9TV<e?lgUfmq:PM3MjLdF5OAXb7He.?Y.=5JoA=d[r4Qg*h!c>WaZ0$kE@^fkl
Uk+?,c86ju(4:F7=c?@VjZr;H;R2DW?r>(K?en.,B!lE%p6/R)"o7>pEiDAL+US3B4/mn%CB
F.HtjZK1rc18sbm`LFYMEmam7;GT-:8)HLH'[-:8-4B7!:@978?!eP@n?s]AtN[Yu320k,$[>
9kO^Z1ZjBAA[gnn"PZ%[04*6<rrR:?TEcT)?.AI2NCHLUXC\1m,*kXIPa;[+U(1(9><P[*rl
u&qd(EOr@nT>RK-RD'@:>'F7;,5KPUl0:h5g;ii[AN;?g5s7d/NXs2/Z-uF23&TBf^GWT6nE
Hp)-^KR/s:@Z`'1*;0T(Ja'<:;bo`1Z9Gjcm]AJU$P!6HcYbW9NFgpd95;WRlYft)KiF?IKIc
4cJFMFPN_<g0:tP;uIUludlaP:[iLiJs4)rD,Oq9-WXZa2&=P#cX2%hI?GsiF4C=_BJ%P&_=
j"EPmWj.?+qUlqp/(ag'VB!=X^C4G(5D'!;YFD-(*NL%4>DNZZG#lL\>e=o%V/4+nUB8WF4J
"\\N6nRB,bacBjgM"o4,u6*S0GFY@6e)qnIa>c09=>n]AkEBM0Ga0_!uH[O_p2E[)Zj*;l':K
YWp106D"^`YEDE8#N_an[>0#5Ir0um"/WiG@^+qU"C!=?b6f[^:cg_uQdi\(9B[eD;G*8;Sb
g(*/hgk2$$gK!*nR%&OG0^h/`d[=1b^e.3iF5h!\X:#'h?f1L(I.J%,iRDT4ZUKB&b$@b8i6
s0_U?<D:;t!,h'*U[8\I,Go)tdd.86Km"5ct;,^TXP7EZ*j)G-=>KOs!(%!)42(Gfibc(9-c
U`f$L'AJF?k)hMSII$anjYA#lmtjLl1Urd$BL#TI-2flq4&SZb1K=mIi.t9K@N9LoXdq///"
qPH%/oVI'0he*Hl!lucd&.[TiG8fC'T=V!"tA>K?Y&kIV=KM3p@_i$-J9YE$N)&CH07i.mFI
'-E[jabBmk^.@[#LpiHlg?N(&-Z1Bgrc_N_LrA_a`@t$&(BhUUV7dF5;r,BV[FnmS:TbR&)M
'PLnLI!0h9o@WlY'L:HMj-C8p:k\%LN.n"5Llq[^6YuS,cncOS'WY%7FcAM_U^*TM#?ML?71
m"EBU[Vb+p.REfViG#bb`8@i?GZqFCFf5Q;K(04jRG,\/REhb5A%6NiQBaB'hFI&HWfOW&A%
7&It"R1g]Ajl`RRLS\u)IiS/N2%P-%9s3ZEldA*oK-`qBl5>G&G=&$[PTn:rRfKY5i"^UD4OH
(FF$3pr!]A0A93`^VS4YSpl,aW=`ZS:,!6dtF0l:Vi\@_e1&TJj89L6s13J!PA=!Y^0%g6SEK
H(L?&_(?^25s5RgG-T$DL4F!l*$ki5c*[*"?AK#\P?)O&n!5]AFto,]A62C4Ae?l!Y`LpidGKK
HUr"$W1ua$uNWh<qc4:4%WBl5-Z6r@f(k&!^U"qImXCuZ@/Yg=IecW8]AV?&65]AOuYf'r;3#b
hg8&)M>Bh\<L#m0e@.67,e80q55rrWlZRQ0\5'+cVI:=qWJnJ-XDrLR0$#;`fOD!PO:5ac*0
n\jDdQ'stjmZ<RdM6g8IO-%k+_a"SmVbqStP#M--.+6ga-K9hR!oG4m"KCHZ2DIAt@C(5McV
dJC4YYNB^S_&i,=L6_j:<DVD\CbX:fu:CfPS4=66&Y'_B4:*,u!>!VF;X*nf]A]AD!Q7bFTraW
ZT0Ygmi<C&CO[6oW7/C"Q&82@!>Wm_qH`e&sd[5c2k"$gR,Qq[t3+7uqnibd<OH<aiQQndIS
qDk\grN3!l7(j,G/pK($<r-P9@u$Y]Aa@=n@>(]AX-U(89mQ4Be@<o`oZ<,nP.<1HeAU,GNN#@
Y@Y""$)Pa0q?PZ,`+i9I;lpmGM+a_"E^oW<5%+.QH0bnBPKra6uMWRW7Dn/)qIL5"I.jZ@>h
]AKg/&PT1<YS+/U<6+VFnc:FBQ!tf.q:(W^2KKjd),lU&@1?neU0+cR#id)k@Dk6Q)s)2&pC\
<"l9*7q"p1.;e2U%7Hpqj=eJ6H9I=1A).1s1Qt^@r.c`tS)l5EE&=bN$YUgFXeb/dQ^6EM6:
;A[)?kMY$aVb%9/skX:rM%0C8i+23a+hL]A?V(jPW(oI$j"I;gZ9)BoGr)Yoj?dB?5j;rN)B$
2u%aG=XTnB5qQb$@0rR8VZK!=Pb1B/qY*_7kEffB=l&U!kU)Pn/#8bX9b&$Ss+9S6"HfkdtP
D**tkBNNb^U-Fu4SuNJG\1fKpeQ]AFh&<I78nHgc$8:5tSgR_B3QH/XlNA$D*r-L=<.l>$($P
gIoY+`>`]AQr3''dDV$J%%`77O/dB,'%_nU$e]A,P)CF+WAL1SSg5sMS17J2l)2/7S(@>%-!-,
E.e2EGFm<#RQ8Zd)?S%)O#-:0!<r"rjhlTR2k>qT1I$Z8feQ$]A.sRdj&W-Xos7!gj]AaHq>YQ
d)=cX`;co2Jb9_$36o8<H=>Mj+-8$GIjnVYF%jY'Z>9TA/(1o[-8(_GP/1N"$PU=p_nLM7%U
f^P`gJ+E"nRoV[1g6ZPd^>+SeP:QR6/,aC=pb[#4qGK1=afHVm5=6q#A:mXN?.'B7DQ=>Q\b
MYiLnnWKG)=<:HCk!RYUAoWLFM<ln,S`cqoLYTqVC9gj@cNI):Kr0@_?,=>bMIVFo'oH!ac5
Yr:-II@H%*f#?&j4m%hJKgUMT-=Eo_W?i`#pPG:`Ct7UX=K^,XPSenF=GfEc9]AAY`bAkgF2;
.dB+?pc0Hl\+dMkG^L_OCZIN&=\Jj;+/L:_)#]Al&#TQ22"A\lMdb^;u8Q/r+Oc<WU^UEZr6U
\KZZHoBKBQHFG?Ns$jN@#L6YIXBQ$O$fe)$uQhs9BDQ.2'FS"@#-Qo68oh6sqYm'S]A&gD;G7
E$AW*r"9+WRkrEpBI>#XDC=L!5BOX\IG1M7p&=-m2X`F<dMY;qiaaH#T;siZ&)7uc@gaZC)W
gTdga7i1j4&6!PW#Sq\-k8UCJ[4TH'-ABIceOaNc)V//872kOJ/T\/NZee<X*5h:+b2KII=[
HnnLYep)ne\S.O5P9='t-19.VaQ-B4WKQ`f(.3s_[Zn;BqB4=]Aa,*T,Q":I9mg6S0^'>3i$J
[efPZQ=Tqalh_.9Qg207E%cMuQo5r02@7p@m.l\(=T]AId]AN$)Z~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="250" height="150"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[KmJ#,<:ATARDgm?1:E-iaPLAqM%n2W+_?lafge,t-m?eC6APuB@bO8:Ou5#G8n\PTCS[&RA4
1[f9RWMi\(C6I4jRJIk1o^=]AW_)&^9;lQ/7m.&@6kbs!!%[(bY@g5!"oG8LenKcJ!)GM'`n@
b_%rnYgU#MHp)QeI[S(8(4F"jBi/UbIi<Q.pcVD7BCKQ!]A5Y6b_&VElJS05d)0M"KN@tkh''
TIu?BeVu_DL"If*DNj`X(ttAX2?V87.`.Ydk9S-3G0=,qqNn#luW#;CXqYa`NUn7eNUYO_(4
.9VoIdNHoBW'Vto"Bcm.Kc2q@6cG:ZLW!5!Z*8kp3e$n#@8X=rcl\F([,i$5_BNe1=QqR%aO
Y5^kmeeC8PI*/0q;3W??b6rnIX=Z+:Ktc@_>@PbdGnSc*Hf<A=N,OI-r%8k_rGYP,L`!eM':
P2nDH`1HdlU&<#HJZ^gG%b^qZs\mpKoq!r<*tS1R\+r(`YE%>"T+HO0_dT&pF9*Vhd:;LjM#
6g$XDBA6\_%(Hej\H,t!L0?C89c)3XUL4W*M]A:.XqYlR(LKi#$&1EX]A@F'HL2!-dGY1e)8K>
*sZjB8e[E'(m.EH5'q@%-n!p<Y]AmBIkIbo"J7n>%EVeLpF)JKfnVdr8!;uWMn;/.A(7X9pjR
K"?ou+<6g9m%=\9_o+XI-"5c*K#-"m=iH>Im$p^g)Mcd%CI`/W=g1LWQ[\sBquIY_B_(+!DK
Znr#8@%uIUG(a*P1FRq_6WK$i.>M2<$DC3J168686@8+sorc:,=nh;j_'5%/90<HYH>#2!rA
$:a0#H($r+J:J6HrH^,ia4sp'uE,?)AO;p\p!WEgCCOdUl9UW9ni%k#tDtT`m!d!SNJV#VU7
\RNk`.r<18[Q3<Yg::,]A>:7o;9pqjIO41a"-[Qo>R2JI*^ah\,@PU/I4l_bmu6[-Kl30%L"p
XYtlZS#,]AiJSbb#MMUm?"h>9EN"9uo6Ffl#XoW83#Ve=Xm&'8Q+k(="Q=qrCVkBI`cONY6Dl
3)46@6fd9HBXXW#>3<@"EVXH=:(^ZcYqA<B]A\')&OCWDoH,7q7Dbh#N+Ge^HG_#&qM@7PN/&
]AG[Z'H5*c;a7jG,"BY&U,.f_[dBnf(mM>lMk]A)eE'L6:,a<$<`ot,X<fTM1:5m]A:<91'^GHT
p>Inl'#o#gMh2NRaTQM2u,qP"I<o4dua#,$GBeF1]AqC&GUGE*6H/@UPS8$J_5`$r-AIqRZ_=
RK5a/O57U$oWgQqmANAE1kTNl*#YdWVQ7o<EUm"q?9n?NDGrV>Fk#X&l+)9)>f4CPOEL)/j/
081d<]A3OX4Rac8CV\f=06`<tZdu0*+tp',c1.3U28g_8Vr3!-!V0:aYb>6A"*!3c_PGg-m:[
V/0thuLO/pP4^qrBH/g#bh6EZ,H@*Up0KKaSJ`=boO@1b.BZ!7gdS=J]AB;U9k7/\k6l-FfO0
7md9-Y;D'NcgCniUp_%u]AFN&3!P@!+3<g(O+6\3o0$g:D(4kM>a(\Z(^:6L>$HFrKE\(u2>S
cHJ;s7J%Q%aoO&d=cX:P)PVcnK[9F#c[pnV,7G<GabIgi,1dK>9^0ADl5"1n9YGmGRCQ['>@
U8'eO0#['V=2g,_eNQL#`M'H^rf0h<nlH4%^6-qj0iqHF9HIc8um/mO1"Q&%/>qEgrQ;U#tP
/IJ@bk2SD)G+WnHS:f*SdPTaQ)NpoiFm$$5\5f;<GdfOdm]APLmHXVRCJlr0ZWNQU@kXL,n[Z
6es+a%G:EQ<U7LW9pYjniY-$3Fh5N>mpqS&?$Coe6\ftNA<.C(4h4ERZN7PdZ:CDh'$L'e'?
D$DYrp>+aeESWf*/="5c0-Z,r@>GMs.<jmW=uDA:HAhJ8@7k:cnX2L^\/m=Ns/oc.`3l6Vq+
598<,Fd6e"bpOQi-I$SV>WaL7b2KJak!MCmr$;.!Orh,CTM@b@-`c=&[TM**k?iM#nq).n?(
flRG+@G&)Y:""f2u1.qdfT56h$bT`mkn\K`+Rm?R(p1AsL@m.'=N,XY6Ap$i-(s*$tKO@_P,
jT>^SWBJ&%]A-tr^/[7Moipse<p'uQ,(N+FX=?3l9!6fDH\$>LFqe5:^VUsuT=p"SP^n2@r2_
bBaMrk1?H8V'W0Pu*i-Yc<*0pCfFp)OZ4<Zjk,5gaB8IDOA&`,pLB`5CZa`fQu(@#$06`"aQ
FYfjf]A+sgK>3&fc`i)0ck()a()4?*"DPmJNrHfC,H+KU*0BupheQ3RR?"4bTWDo6\O[l;$d4
I(aDXiX,lt7Pr0b?_7oP:?"C<\f=_LeTj[Hk/UI'C5pNH@n2GVWi>3Cn9I`7+\+[juO#N`=9
AF`7f6k6XV\U*GL[jPaJY8O`hh6h"//8I>R@]A[j6hnpmQO!3^C4b&WX23fkqPkfY,TrsChDV
i=^0&q"78A!,:EbQThbE*!>4.rj-+n6?)0VZ`#A8e)a_Qr9^Xf%cL#q2XJZA)UFsKhuX([El
o.8/c("^fP+W*6%V'jtK4@)E."",+('cqA"Zt1V+OVoHN:M1VGIY)%!P;'c[IT0T#T01.;@+
.d)CFH^c:>*$2#K]A3'nScegu,F%3ZI+tk'b'Ji<L2?TO+*k,5aTEc)qnf4]AABk-.D;%6C)75
J.ihJ%W&h9%G,i8+JfYX3sR78>)D`N7G%aJ/PnkS,4^CN*GUH=W(G.S2p84H@6'!:G\]AYY1i
13\2(YkeuXMA^*giEfm/p#?0@l_`UI.^t;p9jQS(U0I%g'Tg9Y,*-0BF'e\$E52%HVPGf:P;
jUJ$<9d&8g[bZ:#hCnsOr*r$gmglfe3KIUB"\b5JM=i7+>`UjEV'0/PKa\kH$;RFZ7lVV&=5
YG3NHuno^Kf`I6XioreNqK[7#Zo9%Z@<ASUtb74Z`^pJ-qJnT$7$Mt"c.KV)o_Cjm7"NDfr"
.tZDpdBWc1.&Dl2f^f=niYEGH""tnaiR'#1dTN/\6;g5\[ESaQBSR5[l.LoVa0S_P6Yc\[ki
Rg6H8^luFGkkU!.:<h7ClsWe<UC.)\`"kc4S@pPY\f7.A@d^GcRTg%4]AH.`g!R9:O,n/@LHB
\ClaBQISP4A`ZOs"`;S]AK,7BM6iUQu1G0W&7C3/^'$rue'XI_u:acWFHSZeSp?[DJ`TE+nT>
HQX@e#mfH:"VH2*@\"$@D7`ALqba/$QFNm5kk&D$ioMH4FD-=9S?S3h6>a#3]A!GRC]Atpe03n
U/(BbO:3g+leJ`QOgfPI`ipk11BULrF?gG.;QmZ]AI,F:Y7\^"8m:@k;j7b0FP)[:)p:@so"!
KBfQ(9PL]A`eZ/]AhP^<Gm.A7rD&p`HdC2O+GDY%#F@GPppUl%j3"T"u1\*PX7X$$Lak,P<i9>
`!7?p"AOAR*p)?Hp9^g.E6?323q.c(?%*HZC&f?S[>of!*D_cl`k=dLGYZ=7,uD5,DN19%m7
j6@PCT9\iQ,T+?r3Zh.lDT7R&[_PWW5+IHu#[)S]A6\p$;OE(_ci=BsInK"epF[aXnKkm$bn;
2R?['X_e,56*gS&;\ETT\'Y50N^aJ8]A<[Eg(J)rgr9@\#k?W3Zl>PfF_ZB1!/-ItIZ%45f3O
JXO?2S=e5DlWOWN5\CQ3JuLGonn9!JfRP]AfZ5@-]AJU^cF-V"dAK0Y4=Qida)OFf$K);'"Iak
=6aB<Y]Ah5fHhJ5gQ,<(_j=G-@!F^j@o+P,4e$'V#n$rRn#D4=X9'N#'2R)b-@Yruj#&G+=R;
SCup8E-CgP(VZKO]A!o-=A+HG#!Ga)oYZl10[g4AmK0e-(LkRd3ZU2VbdZB-4=/2@:d=j7b3Q
_<5F25pC+m.f4&Q'&Q9hU\/etSf*a;'46YMb1%]An)X^[Z,6V<Ur1BD0GlMX"QK)f4';ojS[#
&Hl\aF-?h,O=Yh`^l@W8rp;q$X4UI<6B,!8\,T0Cdg/g$/d,3C^,TU;nJfb@r4jA[rI(p'4[
:h5#!LV2isblqH[i`]AqI9053;B$KEArT0LjMuO-AoQkkaY$CVB`1*fHaT-7,Q/Bl9<@j]AuO"
02R5?'\T`Yqap7Tb`Fg^C^s/Qc.F]Ak(6&BYHp">QEV(X6I_XWPi0dj\:qMd%Um!&n**KRVMu
[>P,g]A"UI,0X8iIm$K>\#(fE9ShV+;n)C8Y,Q4F3fPt<hkHsQs]AQ7hCEtE+=U3\,FhKHDqqu
1H?*1RG=:&V4,t@eMXb!j5laL?VaS;Zb/:,?WVFjp7,)Zk,QKO178^uPWPTr1IXng"PU%a=)
Lj^$+!4e[4n4_/E#`e)Id]A-@ZGV#2A6gWkZmS.9T`XLVQAW9p!3dQ&?(aFRr02E%r9='k:k4
*aPLmG7=F.E`(`!;%%NeRR_%b3]AjZn/U%FEbK5'rb&#m,Vc"X<%P6=DGapaA^E8]A*'^Y5r,E
!3,W]A(c6$%"YQb6:s8T%:(:Y5]A_.4/8h!V?%DJVA;2O33W@b;;lE47+B&'T^iV'H*..<9`R5
@q@\\Gq&V/oZ$I!c$13u(f%aG*ebqTTB&dB/>3V$BmscDuerlHW7p"YeY&Ye:muDVTW\X1*!
T<BT+9Ie#X-94U7g#L=f>TAf*lfPrcYXrZGZkFc(+#Nm!?IjlQ[%MV1rO/J&Xh.Sl\^Kj/@<
8MN19ack$+_!HH[@)8%C]AKZ@',P_9!$D=CM'hb_2Q9_Mi!<+\E>Oe-4BV[e['Akb)'+O*9@$
;j%gU^Zi"KUN1h_s.D)(]A'HrRf"BkTh^1\e5]Aos3W+*B0q1b3la:)Ve3-0:28#DR<0rnRUeF
0ht$hbda#c?,FQ3g&<l1eWX7.p^E"4i5l(?*^E&>4Y8?(5Ise5+`A*#+969H#gGt%]ApCM41k
f9qS@O^mU>a%''CPUl[=_"P1uN8/$>e3L!\[l#>h\BLPqBp"`[Jh0p))T+<QfEHfbY=/7Z$F
=La02I57ArU*cF%KSX$:Cq%aFsm-<NP#@DT:/[)e]Ag%!rj,X3YFD/K<#J\RoA.m3NMpo5UOL
$u="auI8nLqKot_G.f&H*0-1bu*J>0(6k)GuC'EQ\g>"hSZ+r@C&,M!G^b_LgWdSn(mcl[rQ
'!6a8!X2h0f9)NT06hioZ.s3]A>Kd(/tASaR#ja,3c_/r+ojN5sA7)u7&;A&.bi05e[_m&TmX
6M!C(^X:C0c!EJWD$8n$-"5&`LBFEA20tDoBeeC&En"P0",e;*rgSk^1K.Y#UU"(]AW\#T@iK
^JTl%sMJU,09E=;DXWEd!\p/6XGS,8QGP&RT`PEfXDB6j%5o>HT:PbD6%CI3FE97^gEKicIp
YlejWEjgutp%[,RoA3JPPEXaWQ\1p=^1f/\"Xq#[tD>9T41`SHh/Ik:DZD&%N@'A-=ZH<eYk
,pZrRJGEtgpikK>1Z<_Bb^e5<>"$r]AQcD&<:6B>cJm/AMVKN1(^0aaahOEOR29*,4Co'1,I>
,1n3fKq'"B&Y*>Esd"[?CkU-7=FNeqT$hAGTXO6b3q`F-cu`:Q=$<Y[TaUOmu`OX"m64k1GT
rN_e5F,:dDKKEs(@Ej3Lo_[Ud5C$?uA`&]A^!=k%,dpj+C3I3`qV76[hBE9@LY^(>#/.D@7qD
6L0JBX6#_c1M5X8hasi=R\Z(]A5K!iiac5_`eTYqI.S/Z.$;IZsO3QFUI-<Kd]Ag7Tu?\)/U$F
7IOu\"6?,0$<Rq.E]A5Y9q-C=".kpclrUg;!Ef##quad-c[cHh'6LDi60))j%\BP_'V^T',"n
02$]A:1lM8ETEPFZl**[LJt]A-r)^$_+ma]AWSLP-2q:TsU]Am2GP9d?_2TPG<=eonkUq"1h(g#V
Yh+]A6QO7!e#./fJ$8Ir4UKTI]AP;m>.V%B/uGK>q<PF\]AJ=+F3mRXi&-j(Km*WumT2-]A_O;EN
GtVdU+^9;""7/bW*RIf)aSW:8Op.0_lRW=7=\JS:BUt6:2=SL"@Xh4-H1'jZh!&YJViLY^$d
'^oUBo.DcWNG:#KP'f$F)r*ebMrU"^c0VJm'FF&Tf>IiH$H7$b,l>34^Co17iB(AAInZG6j)
,&#h%QW8!(0)e`ISqmq%f<W/DY_k-9Y+j&r*UQ\u>lnN.<K(AR6%-Ad0Io;$DRWF*O6jr,6O
m&fr$X=,/8H.R@%8MC:Z<62<`7"0dgsN;+X]AIQs\UYBo^;T8k[0.P>lPJ.U=)Wp7d1$fiTAY
X%i,%nTs"r)m-Zbo\^G`Q6f;Er+02Ok<"LXWdo#:U9:nWq.4mW`ooC,^,O4#Ls(t2,\bP.J&
Vmu,9:uK+CVE(J/R9M*.7rkQ:<;iPP]A%1?jG8u6JK3GAVf`kfEUL/:`k(S<<*Lb=o^;>.Ud:
^`l'b9?YcHm`doW%:`Wk>jsf^N*)2Hf<q(Fq^"E*kh/qX);m,$-A87s(flA5KI/5p(5oM`GV
\LXRj]A+s)N0htDPEaSQD@2nBf^URq%F@0_Ee(q:Ct=I(@C(/).3I+@S[Q`C`0p)71;DWkA/e
8*N83_pm38pI/0l@C'r0B+Y.;FIb`VZlu!gZhT*X$'$N8uFV7\:q2;\_j4ac?U@(SOp"gftk
p==.k,`*OfBLKO3[3\6$Zsn-jL_`^1#tJiDT2P<If-,.rNQH+N1ubl=SWr@snE%^*CZ1E-J7
J!ubuNtbjeqCS2!<-S&,,+m'7Ms<Dq/Mo_3O7RHiHBf/Q:lk'Vif_aI9;8.batIe1ao,G/@7
sA6$Tt1I`'SX/]ArU#)khi#"Y1c3CqOU^3rRF%+g^VSHJ[:W\3[(=/1%^d"MHCoIpKs`6B<td
'b9`aRX[GJgfCA]Ae3tD7^Nc3ZKE6Wt^:S+0%C,Jg2V6bk'1/WNNU(/6W3)4$;>u0st2Cd@t4
*#M\MI'2F`>c)g4H90SW:!(Me;NH_l[MY6dc!4NIqb9+T'dG5'i+ZY!`Scn%AHhrLusQ+s+k
rl@aIV^GhbOjon4:S`h.6NC"*a4a2Q#7d]AV9H*]Apk^+.3"2qc*F$RR$uNHEWcCGPi\*;ltV`
;r^Xr<Jm`QU0JU/s0mNSKtZN24?78_k+>[LS,3calLi+lbq'Y#o7u1\k%DecaP^.T4ON[Pl2
?+-9goPgF'mbq!e&C-Z1Mos?Je\hIui%Iqu>0@>m0Z4l>qmB4]A2J3\.0M;7^k,mY.:P>?>Qh
FIEk(!fa'MEpLm,Z"LIoAo0gnh&ci*cTMm\Dp)eG4q7d3Zb=:&81"8tn`#4144.W,2h>a!H5
G.FX?H&a\208*^=3Y/.^IO$s2-eT`PlD^KlKI,[G5b7L>b=PHor/do,#+UP7:,/?bMAQNT[n
==#'_j%9ET(;ghXE^ogH31?$c6`!Q;,A.nVMN">V1WTJHO;C1%]AFBU%f=r:16!U$<qc*^0oE
([2t0nSl(.#O,L*3%Cba56[B3HZO2[M)pIP*ESkOS2fc60G/]AcIF4qK#I=1`=S:A\]A$@-tdM
WRB53"hD4H]A1cLu8@u=gqF\_o@dt>\e,\f-5&Opt?P[bZ\9GFXqNQ1OmQc::j%0]AL;o@=I&F
LXO0_sraAr3:Uj2)lIF;3LP"@bb"",Cr2Rkej.u5k$ka['*^d4YOJ354_'PK*C]A(B#OpZFXY
Y>h4M71Pq7^oal6h0CNnu0Z,'U_M/_J.&*,&d:5AEP-?l<3L!G@BjD]AZd(TkGiUr[)Lk!q<2
99179Bg6U?lAVMbokdokt'D7Ra37D:e")0*r[M5C+B/><U(I4"0\^eBHH/1c/5K#(DeT`NVH
WZ;PD-uC18Ho#1`#V_^g-6kMK_)1ISP>@CsRrXWqmr&7ljaXIHam=Y?Q3tUH=dU5kYEf3F-H
s@N9K?'XU=59QH?o;^'e>"b-C`*EoRZ!2IkJr)U,mpSPUkVpSgLur;&CuEXU'<M/]AaGR;%/+
;'LIsB*&b:)j'-8TO]Au0,W,;[]A_Ei3SIOXp[-El:L%j%lGUZ+-b0R72VJS\3M(3GD:Ln)bWm
tn4hL>!NW>Ac`.&t(qXG>uB7@Bn8DXDp.D0EG;a(Y!8kV2(pb5oQ@C"kgGq:M;DF5#"_MU/t
VlJ*Io._bi19,+AGUNILf>bB&=M>gDkML?,q<JFE6&8+h;K6#lNQ)n>\3cQ5[6!;oa7+2l6;
k+jK@N*j_cAC3oO?#RZD@77Pn'Pc8Djnu0Yd^s$6_)d.=dm;<rZVAQRiPHr+fU96@!L@ER4>
7C8-[temM/D[nYDSp`m's!u)]AJBHfOSOOXptZjo5EC_`;HSh1DZqse'VELWqe5;'17^#VcdN
h\R/;V.P]ABD5?k(@^=BF3r^(/aPXS='`2)="H=c'gAonoXGB\4SYR;/2FV0=^aQ!c/G&1@Wo
@JcgNI'KAc*!&'q:OXRQB6iI+r<AAUeso6V$osJTl$rq0Rj:<q(hSN-;(^.hM#!D(d]A9Gf%<
n!>r00_;mP@]A^DDX-iInZ"#dqjM9N#ghm!:@1;R&jqI8=?6&ggHOLDui*JPg!A!1baVqOo)q
<*MRmqfVk??!B[TnWU#q/PAWm"r<Cs`+%+3)Z.:8qfTVo[Y:XKVQJC<&;*l:I#mr?^6c(q;9
aO#iXVr#+DIWAVK2BWA\WnUJ77&tc]ApG*+kmXG*%H$&lXs7)/AbIt(/=OgBQ&S&O6tb,HMi/
8PSbSXg\%piHr#(Q<5h=^=MP__>4+XrOW<ahc;**]Ajj]A4+m9SSnY=2t<)__p:qlmM`a!f:+D
]Ae,#)J!?.,f<<:2"clbJW7E2ONbs?k=,3q@oYQr"/9c^Oeafq6sDuGPo*+p:Gg]A;:Va>QA<3
%g+3GkFa6sH>6BP&8VSTGM+Bs=V/[mZSgO-%#H=KWqPnme:pho:l,HK2dX#Q_W0']ALa%IM+"
`QPNPd&cU-Pm+#IB>SOE/T173.=6/EkP1+>H2<k4@h?F&/8V5\l^"ChSe$rJpZo3-bP9G4fC
pB'Uh/Q=q1A,e8&t,`S['>E="3r1B;]A:H]A="s1=j%cUc]AWU`T3FK2dQ13F_Pp'Q]AYRF1PBHG
/-uC@@J)kXsP[*FucL98Dc*%SA^]A-91'+]A^I,+Wd?1+e$(b]AXBjh$[K6btK+R<%s\*>,EU[/
-s!J'_=Kc(TI`5<3Km58pgoYIMe`G)Q'55Zo8,d2.Gd&*`Tm=?Z7>Um?Hokl5"JjJ-eCT7kh
<Fr5ejKh\+f#2TM9AmCtD8B9QIM#EXg]A#bQCsARcpVCo?(daS+B7bfbV1N3DjYYBI<2.8>;u
`5!j/OiPNKiGVn5Sf_)sF_t]AqV"9]A*Ek-9bd'-ud</GcG!*&:rLa75\r/H:PaY?^d0<s4!'o
k?/)r0^^l5HthGZj6\Q+<h#r,b,G<n"[l`hRWF%ga4uoiRub!@\hdhIPF.Tr<jMNMMR0h9>[
e5ITmtE0F2YSXEqE8X)pPMu,R?/Ap%QUhQM.JkaYs6?^:6<LPZ6<)nI3H\Ft`=,?a#Yp8t'(
4S&rWr/pi4@rH7$4TTJ4KY3U75HcoTnfZZ.]Ap!so4K-m;)$[q"TkE#ZOO#i8$Mh:2niBNP1&
jd*V9fA!7UhkmK63b.qTAaZ4pt^0>sg.\$Sr]A/V`E[+T&FmcW6?j#G4gQA2?YtbE"`V,[ob5
.Tob*^r'G3EZ:hT!GmW<giU:B&aUY4<^GYM6(8#:*d5+plicImL/Y4rj\(.P0-AC#QpJ.hee
:\Y.=Jb+mA$W(8!2Of(kj?$eAaQtQhoGk'GI>\@Y5'N]A$l>[S*@90jo%qBB"hC@>/#FeRh*V
!+0XN%r#f$_>1!S)LYAb<^/5]ANb!f9;Zd2p)TJU>hIep^k_9mYU)/+I(>n<7/QC$;<!@P.'`
VA",YU''JP6<(g_`qnQCtiEIprDYY$A\6G[(uC=-ssM^AOL_6K!,`"Gc^r!4`eb"?3@2b\qF
)$HG9d"d6CVYbLK'h$p9YD2-jQA8s;9!Y@dhjO9fQ0R,&TP5UpnVCC^*aZ.m5T,Pb/?Wklt?
l1F!3FPY;6)[?S2+oRG8`0MctN^Q/Lm0"mEOXULi*uG0.lL5^D<Z]Ao(D%W8i>Yc[Q^lN&7+6
K*biE7f`2)8HG4'4/C\pRoXMtEph&)OM4nerifRWBJ6^IrX2kC_&!3^-]A'n/220**L"S1V)e
HQfTl9VeCQMV1mt%!HEZE]A)/nW0=)cq##WbKkb:#;58.@dYe^`8VofYZk"t;U.+ReaO2M2N5
%(iqjB6`%*F%.`UH3]A/DhURI@'$O[YRWc8,D16u!>)Al#;+-:[,Xi7S6*kC_og^A6[<1RY,=
dL01$(oTjJ-:OMQ><)oaAkH^JpZL)n7=CRDL+ro%C=+hZV.$JuEh?Q+ZQ3qSZWH-8.g#:FF2
n!p=SB5&S@9UKtapA(9Y6aYeLXkXB;G.j4tOPOMX*GSh(!?RRH74R\B0<d6;XHuB.jW[0uAU
Eu0I-Zc@\GC8:5;Tb^;gpprSY[,P1C3o9h+"Y-nd?0EY:C:BJe_32@qhhpcJ"hadZ9EEF^B^
2Giqg#O?fB0$bP"N`#FK!EKO%5U8roP/a^nr+#A65SY(oSf0/oGSO;9UB?o6lh=iQ]A^^:g+D
F_mB]Ad(JYoP;u03)A@]AU.EkuOUQ011YY!oFqo(rdUVa3?@5R5&uC7iXEn+c.X#%dLY%T`IMM
K2b(NWX-g+5*GM"^$H>KOV8McfKmC[:OmF^P"2T"Xs/KR?9*60a3YrDF1-`]AZLIoa98KDB)E
Xb-7<od[>:rK?*XrNbMS?mM"I&`pHpEU/I"FDBnP[6B9!kK&sSFcBTGBCF\\DK#9/1TEJV>"
+rfWQNOt8DZ%!KEkGk@`KP=Ht.B?IfT~
]]></IM>
</FineImage>
</Background>
<Alpha alpha="1.0"/>
</Border>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[KmJ#,<:ATARDgm?1:E-iaPLAqM%n2W+_?lafge,t-m?eC6APuB@bO8:Ou5#G8n\PTCS[&RA4
1[f9RWMi\(C6I4jRJIk1o^=]AW_)&^9;lQ/7m.&@6kbs!!%[(bY@g5!"oG8LenKcJ!)GM'`n@
b_%rnYgU#MHp)QeI[S(8(4F"jBi/UbIi<Q.pcVD7BCKQ!]A5Y6b_&VElJS05d)0M"KN@tkh''
TIu?BeVu_DL"If*DNj`X(ttAX2?V87.`.Ydk9S-3G0=,qqNn#luW#;CXqYa`NUn7eNUYO_(4
.9VoIdNHoBW'Vto"Bcm.Kc2q@6cG:ZLW!5!Z*8kp3e$n#@8X=rcl\F([,i$5_BNe1=QqR%aO
Y5^kmeeC8PI*/0q;3W??b6rnIX=Z+:Ktc@_>@PbdGnSc*Hf<A=N,OI-r%8k_rGYP,L`!eM':
P2nDH`1HdlU&<#HJZ^gG%b^qZs\mpKoq!r<*tS1R\+r(`YE%>"T+HO0_dT&pF9*Vhd:;LjM#
6g$XDBA6\_%(Hej\H,t!L0?C89c)3XUL4W*M]A:.XqYlR(LKi#$&1EX]A@F'HL2!-dGY1e)8K>
*sZjB8e[E'(m.EH5'q@%-n!p<Y]AmBIkIbo"J7n>%EVeLpF)JKfnVdr8!;uWMn;/.A(7X9pjR
K"?ou+<6g9m%=\9_o+XI-"5c*K#-"m=iH>Im$p^g)Mcd%CI`/W=g1LWQ[\sBquIY_B_(+!DK
Znr#8@%uIUG(a*P1FRq_6WK$i.>M2<$DC3J168686@8+sorc:,=nh;j_'5%/90<HYH>#2!rA
$:a0#H($r+J:J6HrH^,ia4sp'uE,?)AO;p\p!WEgCCOdUl9UW9ni%k#tDtT`m!d!SNJV#VU7
\RNk`.r<18[Q3<Yg::,]A>:7o;9pqjIO41a"-[Qo>R2JI*^ah\,@PU/I4l_bmu6[-Kl30%L"p
XYtlZS#,]AiJSbb#MMUm?"h>9EN"9uo6Ffl#XoW83#Ve=Xm&'8Q+k(="Q=qrCVkBI`cONY6Dl
3)46@6fd9HBXXW#>3<@"EVXH=:(^ZcYqA<B]A\')&OCWDoH,7q7Dbh#N+Ge^HG_#&qM@7PN/&
]AG[Z'H5*c;a7jG,"BY&U,.f_[dBnf(mM>lMk]A)eE'L6:,a<$<`ot,X<fTM1:5m]A:<91'^GHT
p>Inl'#o#gMh2NRaTQM2u,qP"I<o4dua#,$GBeF1]AqC&GUGE*6H/@UPS8$J_5`$r-AIqRZ_=
RK5a/O57U$oWgQqmANAE1kTNl*#YdWVQ7o<EUm"q?9n?NDGrV>Fk#X&l+)9)>f4CPOEL)/j/
081d<]A3OX4Rac8CV\f=06`<tZdu0*+tp',c1.3U28g_8Vr3!-!V0:aYb>6A"*!3c_PGg-m:[
V/0thuLO/pP4^qrBH/g#bh6EZ,H@*Up0KKaSJ`=boO@1b.BZ!7gdS=J]AB;U9k7/\k6l-FfO0
7md9-Y;D'NcgCniUp_%u]AFN&3!P@!+3<g(O+6\3o0$g:D(4kM>a(\Z(^:6L>$HFrKE\(u2>S
cHJ;s7J%Q%aoO&d=cX:P)PVcnK[9F#c[pnV,7G<GabIgi,1dK>9^0ADl5"1n9YGmGRCQ['>@
U8'eO0#['V=2g,_eNQL#`M'H^rf0h<nlH4%^6-qj0iqHF9HIc8um/mO1"Q&%/>qEgrQ;U#tP
/IJ@bk2SD)G+WnHS:f*SdPTaQ)NpoiFm$$5\5f;<GdfOdm]APLmHXVRCJlr0ZWNQU@kXL,n[Z
6es+a%G:EQ<U7LW9pYjniY-$3Fh5N>mpqS&?$Coe6\ftNA<.C(4h4ERZN7PdZ:CDh'$L'e'?
D$DYrp>+aeESWf*/="5c0-Z,r@>GMs.<jmW=uDA:HAhJ8@7k:cnX2L^\/m=Ns/oc.`3l6Vq+
598<,Fd6e"bpOQi-I$SV>WaL7b2KJak!MCmr$;.!Orh,CTM@b@-`c=&[TM**k?iM#nq).n?(
flRG+@G&)Y:""f2u1.qdfT56h$bT`mkn\K`+Rm?R(p1AsL@m.'=N,XY6Ap$i-(s*$tKO@_P,
jT>^SWBJ&%]A-tr^/[7Moipse<p'uQ,(N+FX=?3l9!6fDH\$>LFqe5:^VUsuT=p"SP^n2@r2_
bBaMrk1?H8V'W0Pu*i-Yc<*0pCfFp)OZ4<Zjk,5gaB8IDOA&`,pLB`5CZa`fQu(@#$06`"aQ
FYfjf]A+sgK>3&fc`i)0ck()a()4?*"DPmJNrHfC,H+KU*0BupheQ3RR?"4bTWDo6\O[l;$d4
I(aDXiX,lt7Pr0b?_7oP:?"C<\f=_LeTj[Hk/UI'C5pNH@n2GVWi>3Cn9I`7+\+[juO#N`=9
AF`7f6k6XV\U*GL[jPaJY8O`hh6h"//8I>R@]A[j6hnpmQO!3^C4b&WX23fkqPkfY,TrsChDV
i=^0&q"78A!,:EbQThbE*!>4.rj-+n6?)0VZ`#A8e)a_Qr9^Xf%cL#q2XJZA)UFsKhuX([El
o.8/c("^fP+W*6%V'jtK4@)E."",+('cqA"Zt1V+OVoHN:M1VGIY)%!P;'c[IT0T#T01.;@+
.d)CFH^c:>*$2#K]A3'nScegu,F%3ZI+tk'b'Ji<L2?TO+*k,5aTEc)qnf4]AABk-.D;%6C)75
J.ihJ%W&h9%G,i8+JfYX3sR78>)D`N7G%aJ/PnkS,4^CN*GUH=W(G.S2p84H@6'!:G\]AYY1i
13\2(YkeuXMA^*giEfm/p#?0@l_`UI.^t;p9jQS(U0I%g'Tg9Y,*-0BF'e\$E52%HVPGf:P;
jUJ$<9d&8g[bZ:#hCnsOr*r$gmglfe3KIUB"\b5JM=i7+>`UjEV'0/PKa\kH$;RFZ7lVV&=5
YG3NHuno^Kf`I6XioreNqK[7#Zo9%Z@<ASUtb74Z`^pJ-qJnT$7$Mt"c.KV)o_Cjm7"NDfr"
.tZDpdBWc1.&Dl2f^f=niYEGH""tnaiR'#1dTN/\6;g5\[ESaQBSR5[l.LoVa0S_P6Yc\[ki
Rg6H8^luFGkkU!.:<h7ClsWe<UC.)\`"kc4S@pPY\f7.A@d^GcRTg%4]AH.`g!R9:O,n/@LHB
\ClaBQISP4A`ZOs"`;S]AK,7BM6iUQu1G0W&7C3/^'$rue'XI_u:acWFHSZeSp?[DJ`TE+nT>
HQX@e#mfH:"VH2*@\"$@D7`ALqba/$QFNm5kk&D$ioMH4FD-=9S?S3h6>a#3]A!GRC]Atpe03n
U/(BbO:3g+leJ`QOgfPI`ipk11BULrF?gG.;QmZ]AI,F:Y7\^"8m:@k;j7b0FP)[:)p:@so"!
KBfQ(9PL]A`eZ/]AhP^<Gm.A7rD&p`HdC2O+GDY%#F@GPppUl%j3"T"u1\*PX7X$$Lak,P<i9>
`!7?p"AOAR*p)?Hp9^g.E6?323q.c(?%*HZC&f?S[>of!*D_cl`k=dLGYZ=7,uD5,DN19%m7
j6@PCT9\iQ,T+?r3Zh.lDT7R&[_PWW5+IHu#[)S]A6\p$;OE(_ci=BsInK"epF[aXnKkm$bn;
2R?['X_e,56*gS&;\ETT\'Y50N^aJ8]A<[Eg(J)rgr9@\#k?W3Zl>PfF_ZB1!/-ItIZ%45f3O
JXO?2S=e5DlWOWN5\CQ3JuLGonn9!JfRP]AfZ5@-]AJU^cF-V"dAK0Y4=Qida)OFf$K);'"Iak
=6aB<Y]Ah5fHhJ5gQ,<(_j=G-@!F^j@o+P,4e$'V#n$rRn#D4=X9'N#'2R)b-@Yruj#&G+=R;
SCup8E-CgP(VZKO]A!o-=A+HG#!Ga)oYZl10[g4AmK0e-(LkRd3ZU2VbdZB-4=/2@:d=j7b3Q
_<5F25pC+m.f4&Q'&Q9hU\/etSf*a;'46YMb1%]An)X^[Z,6V<Ur1BD0GlMX"QK)f4';ojS[#
&Hl\aF-?h,O=Yh`^l@W8rp;q$X4UI<6B,!8\,T0Cdg/g$/d,3C^,TU;nJfb@r4jA[rI(p'4[
:h5#!LV2isblqH[i`]AqI9053;B$KEArT0LjMuO-AoQkkaY$CVB`1*fHaT-7,Q/Bl9<@j]AuO"
02R5?'\T`Yqap7Tb`Fg^C^s/Qc.F]Ak(6&BYHp">QEV(X6I_XWPi0dj\:qMd%Um!&n**KRVMu
[>P,g]A"UI,0X8iIm$K>\#(fE9ShV+;n)C8Y,Q4F3fPt<hkHsQs]AQ7hCEtE+=U3\,FhKHDqqu
1H?*1RG=:&V4,t@eMXb!j5laL?VaS;Zb/:,?WVFjp7,)Zk,QKO178^uPWPTr1IXng"PU%a=)
Lj^$+!4e[4n4_/E#`e)Id]A-@ZGV#2A6gWkZmS.9T`XLVQAW9p!3dQ&?(aFRr02E%r9='k:k4
*aPLmG7=F.E`(`!;%%NeRR_%b3]AjZn/U%FEbK5'rb&#m,Vc"X<%P6=DGapaA^E8]A*'^Y5r,E
!3,W]A(c6$%"YQb6:s8T%:(:Y5]A_.4/8h!V?%DJVA;2O33W@b;;lE47+B&'T^iV'H*..<9`R5
@q@\\Gq&V/oZ$I!c$13u(f%aG*ebqTTB&dB/>3V$BmscDuerlHW7p"YeY&Ye:muDVTW\X1*!
T<BT+9Ie#X-94U7g#L=f>TAf*lfPrcYXrZGZkFc(+#Nm!?IjlQ[%MV1rO/J&Xh.Sl\^Kj/@<
8MN19ack$+_!HH[@)8%C]AKZ@',P_9!$D=CM'hb_2Q9_Mi!<+\E>Oe-4BV[e['Akb)'+O*9@$
;j%gU^Zi"KUN1h_s.D)(]A'HrRf"BkTh^1\e5]Aos3W+*B0q1b3la:)Ve3-0:28#DR<0rnRUeF
0ht$hbda#c?,FQ3g&<l1eWX7.p^E"4i5l(?*^E&>4Y8?(5Ise5+`A*#+969H#gGt%]ApCM41k
f9qS@O^mU>a%''CPUl[=_"P1uN8/$>e3L!\[l#>h\BLPqBp"`[Jh0p))T+<QfEHfbY=/7Z$F
=La02I57ArU*cF%KSX$:Cq%aFsm-<NP#@DT:/[)e]Ag%!rj,X3YFD/K<#J\RoA.m3NMpo5UOL
$u="auI8nLqKot_G.f&H*0-1bu*J>0(6k)GuC'EQ\g>"hSZ+r@C&,M!G^b_LgWdSn(mcl[rQ
'!6a8!X2h0f9)NT06hioZ.s3]A>Kd(/tASaR#ja,3c_/r+ojN5sA7)u7&;A&.bi05e[_m&TmX
6M!C(^X:C0c!EJWD$8n$-"5&`LBFEA20tDoBeeC&En"P0",e;*rgSk^1K.Y#UU"(]AW\#T@iK
^JTl%sMJU,09E=;DXWEd!\p/6XGS,8QGP&RT`PEfXDB6j%5o>HT:PbD6%CI3FE97^gEKicIp
YlejWEjgutp%[,RoA3JPPEXaWQ\1p=^1f/\"Xq#[tD>9T41`SHh/Ik:DZD&%N@'A-=ZH<eYk
,pZrRJGEtgpikK>1Z<_Bb^e5<>"$r]AQcD&<:6B>cJm/AMVKN1(^0aaahOEOR29*,4Co'1,I>
,1n3fKq'"B&Y*>Esd"[?CkU-7=FNeqT$hAGTXO6b3q`F-cu`:Q=$<Y[TaUOmu`OX"m64k1GT
rN_e5F,:dDKKEs(@Ej3Lo_[Ud5C$?uA`&]A^!=k%,dpj+C3I3`qV76[hBE9@LY^(>#/.D@7qD
6L0JBX6#_c1M5X8hasi=R\Z(]A5K!iiac5_`eTYqI.S/Z.$;IZsO3QFUI-<Kd]Ag7Tu?\)/U$F
7IOu\"6?,0$<Rq.E]A5Y9q-C=".kpclrUg;!Ef##quad-c[cHh'6LDi60))j%\BP_'V^T',"n
02$]A:1lM8ETEPFZl**[LJt]A-r)^$_+ma]AWSLP-2q:TsU]Am2GP9d?_2TPG<=eonkUq"1h(g#V
Yh+]A6QO7!e#./fJ$8Ir4UKTI]AP;m>.V%B/uGK>q<PF\]AJ=+F3mRXi&-j(Km*WumT2-]A_O;EN
GtVdU+^9;""7/bW*RIf)aSW:8Op.0_lRW=7=\JS:BUt6:2=SL"@Xh4-H1'jZh!&YJViLY^$d
'^oUBo.DcWNG:#KP'f$F)r*ebMrU"^c0VJm'FF&Tf>IiH$H7$b,l>34^Co17iB(AAInZG6j)
,&#h%QW8!(0)e`ISqmq%f<W/DY_k-9Y+j&r*UQ\u>lnN.<K(AR6%-Ad0Io;$DRWF*O6jr,6O
m&fr$X=,/8H.R@%8MC:Z<62<`7"0dgsN;+X]AIQs\UYBo^;T8k[0.P>lPJ.U=)Wp7d1$fiTAY
X%i,%nTs"r)m-Zbo\^G`Q6f;Er+02Ok<"LXWdo#:U9:nWq.4mW`ooC,^,O4#Ls(t2,\bP.J&
Vmu,9:uK+CVE(J/R9M*.7rkQ:<;iPP]A%1?jG8u6JK3GAVf`kfEUL/:`k(S<<*Lb=o^;>.Ud:
^`l'b9?YcHm`doW%:`Wk>jsf^N*)2Hf<q(Fq^"E*kh/qX);m,$-A87s(flA5KI/5p(5oM`GV
\LXRj]A+s)N0htDPEaSQD@2nBf^URq%F@0_Ee(q:Ct=I(@C(/).3I+@S[Q`C`0p)71;DWkA/e
8*N83_pm38pI/0l@C'r0B+Y.;FIb`VZlu!gZhT*X$'$N8uFV7\:q2;\_j4ac?U@(SOp"gftk
p==.k,`*OfBLKO3[3\6$Zsn-jL_`^1#tJiDT2P<If-,.rNQH+N1ubl=SWr@snE%^*CZ1E-J7
J!ubuNtbjeqCS2!<-S&,,+m'7Ms<Dq/Mo_3O7RHiHBf/Q:lk'Vif_aI9;8.batIe1ao,G/@7
sA6$Tt1I`'SX/]ArU#)khi#"Y1c3CqOU^3rRF%+g^VSHJ[:W\3[(=/1%^d"MHCoIpKs`6B<td
'b9`aRX[GJgfCA]Ae3tD7^Nc3ZKE6Wt^:S+0%C,Jg2V6bk'1/WNNU(/6W3)4$;>u0st2Cd@t4
*#M\MI'2F`>c)g4H90SW:!(Me;NH_l[MY6dc!4NIqb9+T'dG5'i+ZY!`Scn%AHhrLusQ+s+k
rl@aIV^GhbOjon4:S`h.6NC"*a4a2Q#7d]AV9H*]Apk^+.3"2qc*F$RR$uNHEWcCGPi\*;ltV`
;r^Xr<Jm`QU0JU/s0mNSKtZN24?78_k+>[LS,3calLi+lbq'Y#o7u1\k%DecaP^.T4ON[Pl2
?+-9goPgF'mbq!e&C-Z1Mos?Je\hIui%Iqu>0@>m0Z4l>qmB4]A2J3\.0M;7^k,mY.:P>?>Qh
FIEk(!fa'MEpLm,Z"LIoAo0gnh&ci*cTMm\Dp)eG4q7d3Zb=:&81"8tn`#4144.W,2h>a!H5
G.FX?H&a\208*^=3Y/.^IO$s2-eT`PlD^KlKI,[G5b7L>b=PHor/do,#+UP7:,/?bMAQNT[n
==#'_j%9ET(;ghXE^ogH31?$c6`!Q;,A.nVMN">V1WTJHO;C1%]AFBU%f=r:16!U$<qc*^0oE
([2t0nSl(.#O,L*3%Cba56[B3HZO2[M)pIP*ESkOS2fc60G/]AcIF4qK#I=1`=S:A\]A$@-tdM
WRB53"hD4H]A1cLu8@u=gqF\_o@dt>\e,\f-5&Opt?P[bZ\9GFXqNQ1OmQc::j%0]AL;o@=I&F
LXO0_sraAr3:Uj2)lIF;3LP"@bb"",Cr2Rkej.u5k$ka['*^d4YOJ354_'PK*C]A(B#OpZFXY
Y>h4M71Pq7^oal6h0CNnu0Z,'U_M/_J.&*,&d:5AEP-?l<3L!G@BjD]AZd(TkGiUr[)Lk!q<2
99179Bg6U?lAVMbokdokt'D7Ra37D:e")0*r[M5C+B/><U(I4"0\^eBHH/1c/5K#(DeT`NVH
WZ;PD-uC18Ho#1`#V_^g-6kMK_)1ISP>@CsRrXWqmr&7ljaXIHam=Y?Q3tUH=dU5kYEf3F-H
s@N9K?'XU=59QH?o;^'e>"b-C`*EoRZ!2IkJr)U,mpSPUkVpSgLur;&CuEXU'<M/]AaGR;%/+
;'LIsB*&b:)j'-8TO]Au0,W,;[]A_Ei3SIOXp[-El:L%j%lGUZ+-b0R72VJS\3M(3GD:Ln)bWm
tn4hL>!NW>Ac`.&t(qXG>uB7@Bn8DXDp.D0EG;a(Y!8kV2(pb5oQ@C"kgGq:M;DF5#"_MU/t
VlJ*Io._bi19,+AGUNILf>bB&=M>gDkML?,q<JFE6&8+h;K6#lNQ)n>\3cQ5[6!;oa7+2l6;
k+jK@N*j_cAC3oO?#RZD@77Pn'Pc8Djnu0Yd^s$6_)d.=dm;<rZVAQRiPHr+fU96@!L@ER4>
7C8-[temM/D[nYDSp`m's!u)]AJBHfOSOOXptZjo5EC_`;HSh1DZqse'VELWqe5;'17^#VcdN
h\R/;V.P]ABD5?k(@^=BF3r^(/aPXS='`2)="H=c'gAonoXGB\4SYR;/2FV0=^aQ!c/G&1@Wo
@JcgNI'KAc*!&'q:OXRQB6iI+r<AAUeso6V$osJTl$rq0Rj:<q(hSN-;(^.hM#!D(d]A9Gf%<
n!>r00_;mP@]A^DDX-iInZ"#dqjM9N#ghm!:@1;R&jqI8=?6&ggHOLDui*JPg!A!1baVqOo)q
<*MRmqfVk??!B[TnWU#q/PAWm"r<Cs`+%+3)Z.:8qfTVo[Y:XKVQJC<&;*l:I#mr?^6c(q;9
aO#iXVr#+DIWAVK2BWA\WnUJ77&tc]ApG*+kmXG*%H$&lXs7)/AbIt(/=OgBQ&S&O6tb,HMi/
8PSbSXg\%piHr#(Q<5h=^=MP__>4+XrOW<ahc;**]Ajj]A4+m9SSnY=2t<)__p:qlmM`a!f:+D
]Ae,#)J!?.,f<<:2"clbJW7E2ONbs?k=,3q@oYQr"/9c^Oeafq6sDuGPo*+p:Gg]A;:Va>QA<3
%g+3GkFa6sH>6BP&8VSTGM+Bs=V/[mZSgO-%#H=KWqPnme:pho:l,HK2dX#Q_W0']ALa%IM+"
`QPNPd&cU-Pm+#IB>SOE/T173.=6/EkP1+>H2<k4@h?F&/8V5\l^"ChSe$rJpZo3-bP9G4fC
pB'Uh/Q=q1A,e8&t,`S['>E="3r1B;]A:H]A="s1=j%cUc]AWU`T3FK2dQ13F_Pp'Q]AYRF1PBHG
/-uC@@J)kXsP[*FucL98Dc*%SA^]A-91'+]A^I,+Wd?1+e$(b]AXBjh$[K6btK+R<%s\*>,EU[/
-s!J'_=Kc(TI`5<3Km58pgoYIMe`G)Q'55Zo8,d2.Gd&*`Tm=?Z7>Um?Hokl5"JjJ-eCT7kh
<Fr5ejKh\+f#2TM9AmCtD8B9QIM#EXg]A#bQCsARcpVCo?(daS+B7bfbV1N3DjYYBI<2.8>;u
`5!j/OiPNKiGVn5Sf_)sF_t]AqV"9]A*Ek-9bd'-ud</GcG!*&:rLa75\r/H:PaY?^d0<s4!'o
k?/)r0^^l5HthGZj6\Q+<h#r,b,G<n"[l`hRWF%ga4uoiRub!@\hdhIPF.Tr<jMNMMR0h9>[
e5ITmtE0F2YSXEqE8X)pPMu,R?/Ap%QUhQM.JkaYs6?^:6<LPZ6<)nI3H\Ft`=,?a#Yp8t'(
4S&rWr/pi4@rH7$4TTJ4KY3U75HcoTnfZZ.]Ap!so4K-m;)$[q"TkE#ZOO#i8$Mh:2niBNP1&
jd*V9fA!7UhkmK63b.qTAaZ4pt^0>sg.\$Sr]A/V`E[+T&FmcW6?j#G4gQA2?YtbE"`V,[ob5
.Tob*^r'G3EZ:hT!GmW<giU:B&aUY4<^GYM6(8#:*d5+plicImL/Y4rj\(.P0-AC#QpJ.hee
:\Y.=Jb+mA$W(8!2Of(kj?$eAaQtQhoGk'GI>\@Y5'N]A$l>[S*@90jo%qBB"hC@>/#FeRh*V
!+0XN%r#f$_>1!S)LYAb<^/5]ANb!f9;Zd2p)TJU>hIep^k_9mYU)/+I(>n<7/QC$;<!@P.'`
VA",YU''JP6<(g_`qnQCtiEIprDYY$A\6G[(uC=-ssM^AOL_6K!,`"Gc^r!4`eb"?3@2b\qF
)$HG9d"d6CVYbLK'h$p9YD2-jQA8s;9!Y@dhjO9fQ0R,&TP5UpnVCC^*aZ.m5T,Pb/?Wklt?
l1F!3FPY;6)[?S2+oRG8`0MctN^Q/Lm0"mEOXULi*uG0.lL5^D<Z]Ao(D%W8i>Yc[Q^lN&7+6
K*biE7f`2)8HG4'4/C\pRoXMtEph&)OM4nerifRWBJ6^IrX2kC_&!3^-]A'n/220**L"S1V)e
HQfTl9VeCQMV1mt%!HEZE]A)/nW0=)cq##WbKkb:#;58.@dYe^`8VofYZk"t;U.+ReaO2M2N5
%(iqjB6`%*F%.`UH3]A/DhURI@'$O[YRWc8,D16u!>)Al#;+-:[,Xi7S6*kC_og^A6[<1RY,=
dL01$(oTjJ-:OMQ><)oaAkH^JpZL)n7=CRDL+ro%C=+hZV.$JuEh?Q+ZQ3qSZWH-8.g#:FF2
n!p=SB5&S@9UKtapA(9Y6aYeLXkXB;G.j4tOPOMX*GSh(!?RRH74R\B0<d6;XHuB.jW[0uAU
Eu0I-Zc@\GC8:5;Tb^;gpprSY[,P1C3o9h+"Y-nd?0EY:C:BJe_32@qhhpcJ"hadZ9EEF^B^
2Giqg#O?fB0$bP"N`#FK!EKO%5U8roP/a^nr+#A65SY(oSf0/oGSO;9UB?o6lh=iQ]A^^:g+D
F_mB]Ad(JYoP;u03)A@]AU.EkuOUQ011YY!oFqo(rdUVa3?@5R5&uC7iXEn+c.X#%dLY%T`IMM
K2b(NWX-g+5*GM"^$H>KOV8McfKmC[:OmF^P"2T"Xs/KR?9*60a3YrDF1-`]AZLIoa98KDB)E
Xb-7<od[>:rK?*XrNbMS?mM"I&`pHpEU/I"FDBnP[6B9!kK&sSFcBTGBCF\\DK#9/1TEJV>"
+rfWQNOt8DZ%!KEkGk@`KP=Ht.B?IfT~
]]></IM>
</FineImage>
</Background>
<FormElementCase>
<ReportPageAttr>
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[5562600,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[1790700,2743200,2743200,2743200,2743200,2743200,1066800,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="5" rs="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0">
<O>
<![CDATA[ ]]></O>
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-65536"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9C*"'A'[a(dtK&DTf`$W$SV0'm82e#lYQ0U:#%?JS=GOYLdO%[2&VUW)sYLA7BDZ[8k]A,=q
m'T(R<b<;q.O=#m?mOpr`e;5lsME*.ihL$2L3]A2aOH/_p#bt$@3X-CUmKOkNmWBrm&!fIEoW
ofl8bG0+<4/!!*&`J!p-C!;K(cT[t!.IE>:]ANnW\-!<6%\IHom;f4WZ99jX7`rqB(JB9[#`b
EuHQZ?c.qI^<#^F5Qo.Ca?dibbCG:r;G]AbIIEC8gVGi:r'tJGMm__SM2j>e)Hg&G&re6#MQl
[XeP;7Ki)&EZP7f$T6:*7nmC!_A1!/CU"s":`3]A@g<+=PL^Q^X6NE`P*:&4Q^GLuSj>n?<<u
);6Wl;/ft9Yuq^B,R\X(iqRi0bp29T($E-Ao#\O#jVDnD.W?jrI'hXnlA?d%P;')#gWk?pD]A
@o\h^&$iW'R&8^m:5I$Y/Q<iOgZ5`I&G:94MA$_,U0Ra%`F#PH,TZ>Lh"7f2&Nh>J^Ai8&+X
CEb&FR!kg>\npRk`[AsnQ;.aYSoOmL.qSg68F5YV;!=-R7OFo:F?UWD"8HtOH36!>pH>K]A87
hoj"$Ic"/[Bl0oq@GVl[5-"[n%>$T"G++;nUH6GD@82fY'<e&G,jY-X`YL)rd<6`;dG+\Ze9
O6;*m@Yd'24QL0QM9*L-f\qE5oQK1D)#V.cdD`3KaCQ/%'nBRt!Ga@#%gEA2^sPE]A@Apj5+l
E/==SEu'P5JP:YM\-9HXi3AeU:*7O1m%s-G6qrm20I!t`2(g.JcZu=,'#MR)E;oJ5_'.($12
\G_i'>ZZl*6CkH]AdWRO&f#,,9a#$Ql#h_4(YW2ZrG'bd\M5+M@rLanLA'VE1g-t)"Bsr*\63
</UTF;DE_g@g$G&ICo@Yu]A`S;_'7RH=FrrZRFC;3,oMBL>q!OXAl2A]A9+pEf85CH"Q!Hf8g/
#MgrQh&e:f*-X1_0f9_U^:\u_[g%sj,+&[er<l@Ug%SeV7psPJL)=L-/?\3/C5cP)*-J[4Lf
Yt(m;%!"6N9X/P$?jJrAQ7\#3%Xe%4$L:bSP\:e:2\E\oLtH@^FnESX/_Kc8VlgS7doo8$f/
-2G'_S4C]A2IsKJ&do!I:OsV.uq2QC"Xk>De&/#T=:h&OuY:h-PKRM$8c6.:5e%pJUrfXLP`M
/R9ffZc)i6O'iI80uB2[[(]Ag/5fV&/Q9=#0`A07L/:!<5pPOfIp1&.e\Rpg4_`9IcE5eL_j3
<%;)"Cd$h5!_\_^%N#fYLJ^f;J_j+opNg>nZ?^$4\RiKM5KLDm;RfA-KMqF(i[3,6+]AJ$F20
sI?R-T#EpX>d1Dj!O4cGEK4.5b\E4JITp!H'%8\Bo's1rd&s&U;:rGjIh=QP!eU@]A7O9Q,NM
``^=Rq=e7KaW:SjL-Fp9d!-XQUZ$Cn;MG_30uaOu"%P62i.#+[kO+)qS.;lN?--5-n*^dR">
nD70s8?\k7i<Bpob;./?1iQ)$C=8o_Ge`i4]AuSs"f+0uoCTXCLaA_ZNisKe@+`,Eo:.^"abV
eU1_37T=ii%g$TFm,C&Ik2rV;0kapHs0F*l=,Z6',!kQC613M2TL#,DR);&3FW$3OCn<KE9_
*X-(2W=_PsATA0<e"q`T)e<t^N`WIgYE4m.K3RPs`?j\d\a76_W=+0EcJ):>iI=>24ra7Z8i
=ul^pc"B;R(!2hJ,>S[cRr"Q/D:se>uK[)kB5s1kB5s1kB6Ofl4+U)o+fu[J5=R(:EIoiC^o
S8"'B%kH5\cnpR,/'ZrGSj4?c6KD,,&JDXH'9!O*njCXWmm3pES^i9EN0m50N$k_rV@ptD93
If(:'J(_`PO<Nn1E\(Gd\qe#aJ)*HQ$4u`mLL/6kcKidAcKidAcKjnBm1(jaXW/DP+@#"S$e
U0i+BCU^6;6I$1(f@mX9ie/$&Ji=FJ(]A>jTJ4X.^TbRr<FJ>,>[;I^n39;JW[)46.o-8P4qp
G):13V&YMhl,^$WW!-"K5>s4YGW[C@o=4PnBYNCr*6(9u"?YEaU"A+1;_`YM:%r?4]AnH%a<*
aN8_nXY+rJ;%(<M!9*$R.c<@_TAn*n17Igq_O.\>t(@_F4pTIS8<,ecZV>uaWOgNl^q5AF+r
rj7Qof!cRI4t=/3?+l\GrZ?rB$ns45XeKu*3O(g`>l%`)(#h:%=e2268A'Yi*gMUukkpYJUD
s0c\D!IWR+249PY*rWglf&UGd=FI%;4=5,j+1VGm5O=5EeAbguFP]A&a$ghL2n!%T-iDQh"r3
V^OTi6CIQ$-fc%rWCTTsLi?Nt,Jr_"(N-3DNdgJnKfLBNgsMas"OJ+uR2bogL]AWQS&2SF.8O
ZVWSP!rm)A&_0fG$k`i_//_p6:5.i2*c@2mfH3@\*kkhcLrC&")==5^'kOu:&kqPsc*)8;tD
l_'3HZ)_@.YG[M!>VfhOB<D"1G<p/VWYg*V65oafdH!X^MJPM/F.",]AIe$l8jV)*L`Qnc<%h
6%'uYFnB\9/fFBDk!ec(EMI\gs("5AKepA0$X`<>ld[F2LI!b(:qp=H">l8NB1It\*)DEa21
9'']AgWrF\l6O<?!93-ja`LuAkLk#mGDfY/&SX/j0_BR*9_:4:`hD",t/8Gu5A^N34m>C:FW)
dQsHR;/0>up@(Hn<N'LRoWN1bSY,2&+iR4oRR6hf@(7#mhrO=^E)Om[CDl_?)TC<BRqUI+/e
]AqF.=\_=M*/&Et=(/&N5%PGo!V`Dre.[es1"k=VJsHRQh`StZcFV_;H5]AEcU25]A1hM/kJs7c
g,]AM+ii45_@*Z$hAuQ&o]AedjACCl"oO_]AK\[U(4DlJe4.J9[!8q"S,PXn=0&t^f(A)(_tZs5
4m+@l[S5e`1"ZC,B-D"Jq/+UqCa(-5bc_IQ"LRYNJ(Zmtp?7GPlSMC+9_%mMQ[S[D<t8@sa!
B5O_&l(JYehBZN&3799VL;p<!oZ:?Z`a3f(<%l]ATJ1_WGiqj2lINE5Ha0D:.1;RBl]AMh.Jcm
[j&gac+2=dlK>>C6a>VR.70$nD+QH^-<g3r`k<kVP&naB[G.b+Kr&MZpCh1>mst0d>3-OUOX
hR_'"<=Q,OEh&<#\O'HH3'&P_bdC7$XP9^u.;)KaJ$Yu9Y+JCeXGLs6ZW\^%llt-!IB0F,)e
><5+$aq;a"&&NANVGa&RkI_Fq9.e9#`A[\=K&ZL<>'/-A<`(i^e&LMWHVF6gH@>Sq8n%Z@p@
MiBPi#pkfN+l4"]AL6%eNSRV6&Bnc8*pu4Af_(6=98+oIi*tbDM'[2sG0Rq[pV`"kGC>N_t?*
jY=M-I3Ub#L8ar<"OMaD&Ek%RVi!D`F<Zt-eZ[f4?]AE".Ai,kUq0]AEHJW5J@$F!Gq#$Rb_QN
7"Mfd6IcAYO,Dqb^/FT4&5;Y8eHVH)g!W=6)+bfVAj^,%baT5EVi>C3UUqe8!<TjP'L4*3=;
)iLImFPeiH\.XQSJ`9)s3'1HGs=r(&j6Qt`G[J<gIND*DuN5#5HhdFUaLu,^Q@S3_+R?VHO:
]A5/XG,43?AXS\Z<7_Li^jM'<U7[:eO&6Qk=2rsuKYac[V+BM1<<YOZ$8CEW_ICJ7EuFN8m6N
06lpUbJ#&U\<:ZD*M_cs5ipT54-E*_aXX/M2=QuUm),!S9]A!Q>IN0$rhdXUtuq-"PWEYuK16
V7ZH*5Q.>(]A6mX1@'.;ePMfN+AbXoKb+]A%Kp3(f=Ya307NpWMOF4_C`,o=.KBdM]AXoXMKbr*
UpW`i=`*dLkjM=PP2mm%h]A+5B<=CG0b.kf:4KGYg,H8SR\lGO8d7JK^ek"6;XRO5Gr/NG9M>
TK@1^]AlMp0Gs7Y`(f-b4SK^?EP1Ge\n"2&i`^T57)RBKk]A)H>"4`aVo]A)DNJX\skClAa_qlr
KaI5\T+'C[[!3'jO!V69HJi8]AC'sRXt)%Q+90`L6Lc/P8D5KP-V4,Yg3W<)_YYqPQjLF/L#V
@i5t^\cHWBH<*M1e-n$]Akt68NhaN:fU]A)VKQ)c=4S??DG*$_VUTr?j<0D\P()p!mq,N9;5>(
COcjhM%sTB+ilNj`@&)VO,"!AN(4_A-EbT/9o!#N:j4U*B<:V-n%G>nmXj^R>YR2&mZn;#5!
ST-ei&DTs*7;q.*a"*->O75&VDrS@QG=!$1M$L%!V<L"Z@\p`IJgLkCnN%gCGDuSm`(ELj\9
(W/]AQ/prXb(QAsk(,/C9T=E4\kC3]Ai]AF74![]A3d$]A-9kKS74%)\i_GAep$]A^KLMXH[mj'lei
]AW0D<F>>[4Hm]AA8b@hfDf@7dG(sn?DTo""D6WYUTamR1f'q,OVU3p'/"]A0*\'J2=Rk.J_V/!
;$gAL='kJ)HDbC>?;n@UPK[6Z/Ze_s_ELh7Ep]A6eSs)^dN??iTRhH`eT+I^k-0ZYD#K`/)l8
J;TA$3(I$H0m:G_daP1<UAM!Ir"Wk<+K;2)k/SQ4)Oh]A^I#mrsT-g8A&e=p,\q5RpH'kob1T
>U3R[F2UP=&u&LuEDb--d=JV[d3Kc*<$3No*jM7lY:+k^e`rb#fm#4Z6$t>(`VRM^a9oje0s
1>;adPo(Nm0:O0RF_j\QqmpKp3%u.2f;!Y3bCXQLS5<Vk%Glp*(g(nZ"J4ssk!0hm/iHM+Tj
-$t*TdtN52]AgOdY)]Ao5>a'$g,#ni4g"G5\n2q[%R%5+h!dd-\#DS96r=Ig:m"OgpN4WH!M4e
"<.-rh*N2mj9G%kZSG2C[t\?H&9KNKk4C+XS*;%1,#@M9@4/pcFI3MBfl[d\81pV.;"P*F,+
!XJt-Y'-SM"j0ELA4`u5c;0srl!t$F.)=^I]Aqu]AKD2Blj3<RIja["CL'\>ufW*BRgSg^'Db[
['[H7Dn*?EW*X!,PBtIO^E@A7,GJ&o\O]AH!CHA/eG'7(XA#]A\L8(SD$.]AsW&:=ir?68-5(F^
4*;8`)1b7q5ru94+$3NJi$&<'f?Q[A_Znd?cW0E9dMVA?B=O>@hHe(Z!8P]AN"#'b39[HXmuq
e"$A3'*e8q(sP+U!gKAXYCm\!m:0FP"I&tnnA%_m*B%FC6M:>17;SjVQk15$Q*hrMBc#V>F=
pNIGeD&^3[;REjWEGEoJHm>^&c2\d-W%F\T1CM_kqB1?f*QSYo/4D4TkG!*tbDSdKG@FF1Di
.>FnmMJ*4%n8e,QFleem8'.<tj^"VrQH*De*Jk)j2CXrhX98sQ4:(hSG!);@:bb)l/-6g3WB
cQ!^F2=&q"%L"'HmfijNl:XX!=H!b&VKlfN738#sFspP+.f]AR&L5UC(sM[3cn%`7:?lAD48Y
#dM[kdit!W1><%_*+#Wj0(Vi4/0h'SOH8JRG!LM/h!2dP3,TFpY):3H)JZ!E-^gIh!7Fo$Vh
h+:;77LPiB27S&m]AAnN_!RX6C8eRaI*K.T!k]A&F*NV^HJ.h$c"bWXIH[)rk"Pp18hIIc-?se
1Q26rX$"sI+H"n7c786-g_r&=TA\>b7]A/Gf#=!!~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="318" height="320"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0_c_c_c_c_c_c"/>
<Widget widgetName="chart3_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="800" y="328" width="346" height="310"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="true"/>
<MobileWidgetList>
<Widget widgetName="report0_c"/>
<Widget widgetName="report3_c_c_c"/>
<Widget widgetName="chart0_c"/>
<Widget widgetName="report3_c"/>
<Widget widgetName="absolute1_c"/>
<Widget widgetName="absolute0_c_c"/>
<Widget widgetName="absolute0_c_c_c_c"/>
<Widget widgetName="report5_c"/>
<Widget widgetName="report1_c"/>
<Widget widgetName="report4_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
<AppRelayout appRelayout="true"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="957" height="535"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList/>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0"/>
<AppRelayout appRelayout="true"/>
<Size width="957" height="535"/>
<ResolutionScalingAttr percent="1.2"/>
<BodyLayoutType type="1"/>
</Center>
</Layout>
<DesignerVersion DesignerVersion="KAA"/>
<PreviewType PreviewType="0"/>
<WatermarkAttr class="com.fr.base.iofile.attr.WatermarkAttr">
<WatermarkAttr fontSize="20" color="-6710887" horizontalGap="200" verticalGap="100" valid="false">
<Text>
<![CDATA[]]></Text>
</WatermarkAttr>
</WatermarkAttr>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="fdb7a92d-c709-4f7d-8780-535eea2dbe5a"/>
</TemplateIdAttMark>
</Form>
