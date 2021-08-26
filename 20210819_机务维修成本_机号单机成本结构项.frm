<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="统计截至" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
concat(DATE_FORMAT(date_sub(date_sub(curdate(),interval 1 day),interval 1 month), '%Y'),'-01') 起始时间,
DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%Y-%m') 统计截至
from dual]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="明细数据" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="aircraft"/>
<O>
<![CDATA[]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[机务体系数据源_10.33.2.25_me_enter]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
      model_msg 机号,
      analysis_num 成本结构项编号,
      analysis_description 成本结构项,
      sum(res_dmbtr) 还原后成本金额,
      sum(fh) 飞行小时,
      sum(res_dmbtr)/sum(fh) 还原后小时成本
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di
where interval_date = 'monthly'
  and gjahr > '2020'
  and gjahr <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%Y')
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and model = 'aircraft'
  and bukrs = 'EX01'
  and model_msg = '${aircraft}'
  and analysis_description not in 
('总成本','非运营成本','航材处置成本','飞机机身成本','发动机机身成本','过渡检成本',
'飞机成本-飞机改装-适航类','飞机成本-飞机改装-运行改善类')
group by model_msg,analysis_num,analysis_description
order by 
case analysis_description when '运营成本' then 1 
when '相对变动成本' then 2 when '发动机循环成本' then 3
when '发动机小修成本' then 4 when '飞机日常维修成本' then 5
when '周转件成本-维修' then 6 when '周转件成本-租赁' then 7
when '大部件维修成本' then 8 when '大部件租赁成本' then 9
when '相对固定成本' then 10 when '周转件成本-折旧' then 11
when '飞机运营定检' then 12 when '技术服务费' then 13
when '工具成本' then 14 end]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="机号" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[机务体系数据源_10.33.2.25_me_enter]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
      distinct model_msg 机号
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di
where interval_date = 'monthly'
  and gjahr > '2020'
  and gjahr <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%Y')
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and model = 'aircraft'
  and bukrs = 'EX01'
order by 1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
</TableDataMap>
<FormMobileAttr>
<FormMobileAttr refresh="false" isUseHTML="false" isMobileOnly="true" isAdaptivePropertyAutoMatch="true" appearRefresh="false" promptWhenLeaveWithoutSubmit="false" allowDoubleClickOrZoom="false"/>
</FormMobileAttr>
<Parameters>
<Parameter>
<Attributes name="aircraft"/>
<O>
<![CDATA[B-2899]]></O>
</Parameter>
</Parameters>
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
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="absolute0"/>
<WidgetID widgetID="43b02c61-dbc3-4351-9733-e6ffbc76fd9a"/>
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
<InnerWidget class="com.fr.form.ui.ComboBox">
<WidgetName name="aircraft"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="年份" frozen="false"/>
<PrivilegeControl/>
<MobileStyle class="com.fr.form.ui.mobile.DefaultMobileStyle" isCustom="true" borderType="1" borderRadius="5.0" iconColor="-14701083">
<Background name="ColorBackground"/>
<FRFont name="SimSun" style="0" size="96" foreground="-15386770"/>
</MobileStyle>
</WidgetAttr>
<EMSG>
<![CDATA[请选择年份！]]></EMSG>
<allowBlank>
<![CDATA[false]]></allowBlank>
<Dictionary class="com.fr.data.impl.TableDataDictionary">
<FormulaDictAttr kiName="机号" viName="机号"/>
<TableDataDictAttr>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[机号]]></Name>
</TableData>
</TableDataDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[]]></O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="64" y="6" width="384" height="30"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="Label机型_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="Label年份" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[机号：]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="微软雅黑" style="1" size="72" foreground="-15386770"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="4" y="6" width="60" height="30"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="Label机型_c"/>
<Widget widgetName="aircraft"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="30" width="375" height="35"/>
</Widget>
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
<WidgetID widgetID="26eac0b1-d1e4-4b7d-be20-4ccae84babbd"/>
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
<Refresh class="com.fr.plugin.reportRefresh.ReportExtraRefreshAttr" pluginID="com.fr.plugin.reportRefresh.v10" plugin-version="1.5.4">
<Refresh state="0" interval="0.0" refreshArea="" customClass="false"/>
</Refresh>
<FormElementCase>
<ReportPageAttr>
<HR F="0" T="0"/>
<FR/>
<HC F="0" T="0"/>
<FC/>
<UPFCR COLUMN="true" ROW="true"/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[2057400,1008000,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,4320000,3600000,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[机号]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[成本结构项\\n编号]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="动态参数1">
<JavaScript class="com.fr.js.ParameterJavaScript">
<Parameters>
<Parameter>
<Attributes name="asc"/>
<O>
<![CDATA[E2]]></O>
</Parameter>
</Parameters>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[成本构成项]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="动态参数1">
<JavaScript class="com.fr.js.ParameterJavaScript">
<Parameters>
<Parameter>
<Attributes name="asc"/>
<O>
<![CDATA[F2]]></O>
</Parameter>
</Parameters>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[成本金额\\n(元)]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="动态参数1">
<JavaScript class="com.fr.js.ParameterJavaScript">
<Parameters>
<Parameter>
<Attributes name="asc"/>
<O>
<![CDATA[G2]]></O>
</Parameter>
</Parameters>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[飞行小时]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[维修\\n小时成本\\n(元/小时)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="明细数据" columnName="机号"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="1" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="明细数据" columnName="成本结构项编号"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="明细数据" columnName="成本结构项"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="3" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="明细数据" columnName="还原后成本金额"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="4" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="明细数据" columnName="飞行小时"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="5" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="明细数据" columnName="还原后小时成本"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-15386770"/>
<Background name="ColorBackground" color="-2167817"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[ja7G@e)gSD7DVb%Fuk?`%&hW(.MTN-j0GemiYX+Vfi2A&:^O$RjKcU>LH)TPD4N5UEnN0H;M
;$&>dj_qZ4(0YPf[JUA&9(8NOc<R?2l/8*5U$7@@_K=]Am.ZcomED#o6`ajchm>5I%FslfXN*
EA!-5S"Uc)jXS^21RhdQ"'"D>#MqA!>gA[-L"-gQ.!VuN%2dcRb;`#i2Pe*WfGX.!6=FU54Z
@?-DQ';2dERfhpNC2dmJ%U"O]ADJ!D%R9^A$eWJ\CHl0S,eIt?V.t4=p[5O>q7!E@*=M]A[Xi`
m+=ballob[4rn6t-_DWfn_FlMkkN"ZGU>ebBZBgT[NLo7RQ6e:O_AU$q0Z7TIKfikLW,HTqD
D,2>N,deu<YQfRiZCZ4tN`RRfg&?:71A8+IB=1!'Y7t^/kUrZ)%B"erifCH(FZ-3S7X26]Ana
QW[hDrjLOtoA.h\^d@H)5d!l&C%Rh)B<G.TF9mFn@IpCnc*J/hFpe`eD;np![.F2)'<r5j]A@
XiNY4FrR`P&1;T7B8uA`hp[WbQaSi7jrIlB60o.TcB<?\klONOe6:pq?j5.SsL-Q;959X?/'
ZA#Q0#n@]AQV$lBF<?StLu::7j3nO'?HnZF%<5Dd+jh^klGAB`gMH#FX]AU"B0p#Eb-(+MUZJr
HWX=`du",r,AE,1eXJhbjE>E;VH`l9.%8\),$>l\4q#SfL'[0/LQdCWoeOm\\Y<JGI^?c=I3
b$mKD@f1Jh[q?jq<e`,F]A^"/(aH<L&.j8$LY?%^&2h!?\3,C@J`eD=*'RKmKc+5SE#?decJ5
[\rDaVZ&b.Ef,]A`8PPB@Lt\N,`'Ljn=8Z^rR(nDQN\Nd(?P`E$8c\EdW')c(/S7D83YH=cUN
7X2Ddu^+FlFP,VBG8EI<+aR^Bh%Piq2WqhS#qN"jM<-XHOKtM9k,I!OTb*@8U;F\HlR2Y*j^
6u)$-k3a4JTihs\I5;_mdomq%:bb@I*]Aq2Z&3VXNaCV#1L+qK-gSCVPP97Xi&%DcoA2rC.Y&
Z?QMPN(9Cq<Z46$-:<B\16d,KP0GQ7dB/hTJ]AQ($5<KhWOmJ[@S#X=5kW*>;4X^V+48(9=LE
$<CRgU2MDpP?+CrKsp_]AR,%KQ;H?e?en1aUS$ChYrT/pBS.RZi[5:Qe)g&bbeQD3Yf[FHk%U
YZEm(t2h0:<TeHXMbSmm(a1@r9s/rT>Q-(U)>OOClAsO3oWm49-(';/Y^f/Qkq*IUL7j(;72
Rm=)*YKA:g^`m^rsY,1ZOP1NcWhalnBVZ#+n:7_UBp/gVl/]A=i^X:&>I(UoGt(jk5-Pk93h.
TuO$/\]As0a6k67<.tSh5K<%:+T4QjHZNA.:=!E+;cm'rr;3k\lEG-1ZnTfng&Ehc.Mn++g01
surVGdQaIlhoeEX#@+Lh-#08Q%=h25Ht:VE%*QSC+q%>ktKW\Y7.=;T7.!/Pg5GnNHG37fK>
BsUr2k;ItLZ5`%XnA6VHSn'44eIaIdFa$O6oA$`P@@F=/qes,O#R$F.Ddd1[E&)+Fh#2H.V"
fXZo3u-`._!/L+me'?m:0c@TmJ8JFY"g<@eU3KY#f&$C:j'_*PNiCMJX-eKcim8J9)OMe`I[
-#^PqWU^ZtMKepAJ_hE*sT&o`W(:6SU=7U[i8(3PJY/V^+D*-M'2smN'PJ2CO0APPVM",<f?
.XLeO'E$lbc)F_aP/TnT!n,JHh?dqgOAPd(Kn\se&"dZP:a^'nZl%F(@bTAMn)E%m&:/tNsU
aRP?DF-m+cpRLS+!%h5#;6>F3l@'@Fs_XO;2_)51.D]Ag6FIb\SZfbGtHTH%XMN\`[g2nkgmT
d&>\*OCn%A1hqgSB6`B141bLSgtO=dNZRA-8gQkM^B%b#V'u`533,K?@3)?k@Wd'aREr,b)R
:80k.=),<$,hnkh9]A^K`YX&(Sr!'kdI?]A3H+QB@IjqI_h_Je"W-\BNEM]A!]Aih=B)K%haAj)-
q1<T3X`IW]Aaaj,rHQAd*n?T)k_!9.O9VdWOS&t,_Jma$1Z$\Q0@^gMZ<P:YFLRg^kS$cQI]AN
JSSh]Aj.C["UMRo7,_=r;!p\n,uIqH)4,itGj8&hn`dLqgJ^>YdAR1t:a^<hY46?]ACL@"Q4bl
0<`2F#RT;4gMm[6MDS#Qp&9(78[,.?/+$L1-'@]AZV@qobTtLR&60]ATkl@4^/sE8@0@h]ArIaf
-)poffj;C-?Dee'>T>rFe_[XP'OD/O/OUT+S(T`"r:Kq#1[;,siQEG?JeW+C)JI.7bn@kr#'
3FhSC;noT,na@:q!jRd`1al69\</\&<<2TQLE0fi+ASS+Oc3!b'u88[EMt:;@m%/9?,[a'9-
Q?-,M53#`eX!#OtoFUdHJ1t009p-VM?L)WglTc7.IiuIUI[3h1#Hts_u$DI1XG!6)Pg_k@\5
&)PP:8>3g>LZs#`jUC-H)3OLQr)\7Z:MYZ;>o'Po>"Z%5u+&aInIi&=7(N&(aR"+4"tE`(#f
]A&&D_eP`:D1[o/1(r.pJ=8;at;m2C0KJQ^_GmqSq!KC1\:qJ1tGV:@W=K'giW7;/Uk8dje3-
CG>]A</b\UW]A?j_e=Yj)i`FcHd>TXp:lR*D&EVURu_\d.=(gLOeO8R3o3i#TupBZo5U;>1Oa6
fWT"dMdWg1GmM]Ah>]Ak2]As61gcm-kTB1%"r!Qof\FQ[uXu2D!J07rqr+2AdPsFJufr>jgX;Z0
COk3Jm"Zidm!XRV#6]A(A$`p$a/:>E5i$`\'n#%HN`mQV@:gu?d/;9pQ>Y8WCnZ(P=kTH&@?d
nEK'2Mf=i;I0$S-c%&sINo0lX1D81jt&M0G=_NE:ScJoe-c&Q;*LRZ@%Sjo?Us)mA[+>GVH4
CE"N&-F<.@\O+T3kD-\;*E>RoQiQPtbZr]A*`XF<)25YM77q5WtgQNE:q$2/AeCDQFpT=fOCS
"LAK7*[Uau+/M2kH++[tm6fA/fen)#:PF)c&S]A)=b!L.PciW`NFW<a%O0XEr(bM<,%-,=mF%
(+M//5A_b>RVc&g&^X4[,M=a+>s]A/7MK]Aoj&!M]A#ePq6f9I<%.>2:+=B/7(a3eN$Pg70DGb@
?(@asflB\8#28n;Q.KEu*<Ks8Q$nLHWr#L0s='DOr@>pn"a4[NQ?7MI>l-Ht\]AS^SZ2k.D4+
M.'>gOT$Ahq/1)^]A4V*"8(:;$1KaEK'PLlJ*;Gi@8h<l)5>l:KWGL1C)7@a7pL\`dH'+crJ.
-*1AOLILj:BXRclV//cpCrcs4\4/7DJ'8,>76d*KY(TSjbV=Ib)6*$AKS.h5UI(CZ/rrgm&!
jd0)MWch@u?VaqH1A$\?29*`Tp.7,XV+nnZ9ttk.-ob8aeYH*B+c0NJJN%C;,>#mj>G$#c5.
'`g<H?&JY.r#(&<C3#\5><.MiFAA'UmN(!,P((1JQ<Jp:?dQ"[EXaXn=EQ<<400]A)sQuHpC"
#G,Nk-Xa>%F.K!ihD@]AB*UdU\F>fdlE=F<X&gc;E;Smg>sL\I0d*u(/^&I=2i2'5M#L'sTHK
O<)AjA\*$[iHE(j(hEh(E"b9N+F,J+4/27JP`C4&5"5/<`AT8fL-[gHpkej//[\pXt6@rNam
sA89me-;+2?/UDX1Vd&V=p>DcaH!lA.[<kJh2#Mp/B_%hVt/I>lWBKKe;bN%0&Bl7.WK<8M;
s4>)9rmn@@)_sJ%8:_)M&"TV.n*]AK]Ao&E/7>">dF`"ch:2WOKMk#`<V\g'3DTeFPbY1.BbN-
?-qR!3Y<U*NZ[G9MNDeA"tK3IoKj^*tk<or<CNT%WFCc#+:8he"TL<",-O;Z%n1`U4ZLA#?@
#I2Y#TE>K'U3><!(n1DYBr`,m[p:*\N*Pe=K?!24n!r\Dj=`bgliKsYede32a.P+IDl"'k,P
c[$&<CfN.IsAtM5n6TDWcB>R,E0u5abgZOC*\ue*7^[N`-c<ZZ^t\MHA?iiO5i9aU)<Q\OWj
Esq3U(kit^Qu*$%Qa2TK,)LcbpFo-#sk?"c(u'/@%&S"pI&G)M?:$6md20Q`kSg=2I?`M[,/
>4X#\T3j_4Q6S?$<ao#Co:lg]Ad#YqFF<_BV8e?918YJq4UJnu$_4"shA9(p%/a%.LHgH$ggn
mb$/N`j*DTdj/*#>:R7-FVTU-ib09^IiFC7"(K\GqsJJuM0Ec0^U4hK&H?NPeDG'pH'SXH':
B9>&??;!,C0-#3`&I"N![.+'K.<tSKi?0l08B&`+0L<MgQX9&89*:ns(^uBV9nm[9C5s!A#"
e5A7"ENg3<;MWun]A[<EP<<RZZ\jUGJ#7D@;(9ZUY.kllW%n#lNM3dSI_g;0pl4q6Xn$_a>'[
4^=Y0t+QGFaI#\+bgI4Hb]A>?h.;iXBr=./5<:1otCH(I?JK[:s5YkF%kC\"cadH*A]A(k2?o@
=LZ8GPt1/`3HS4q>0N(S!;RFbkID]A*j0e%cRlKMf]Aj2G:BJll=*?Fq\bX@hAmF=#SV^q^3-.
k@YKf_T,`Vl*9]AGGpJT%.^`&$ZgY`Og&m`V`K7IftU5b$aNcAW&OV%%9)Rl`?Rc+dM^Pktft
lO1H29:Y@Z8k#CKU4;jddV"R1RQ$VD#DHH0HFlCHMR8<B*hp]Ac;S#=DmFY%EC)o5a'BRF9f,
rB7qe<M#K"Fi2":ZVtH\-c`/*6*jk`"]APaEq`AO[adU=P<g"1KF^M=@npC]A]An*M7<'Y3.nR+
eF_)SaBI_&ur"u*Hs!'k,NH%MlDeno^&Bpt-cC0C".K)IP#d,Yi;Q,`(=D)=rQH<seN@O1Ap
9_EZLYbds?5a]AUFr2IoX&@7?ps3/,saTk5t5u&Y1P(&)jk[nc%Z++]A4g+"CAJ(J:EN$pm#ns
RMV74nElonO7AEXS]AB/>17ZZ%Q2laFKph<Xb!LH8N.>_\5Qt1nFuT-6.WU_p`q-'9(3<h+m!
p%aBUTSSFKb$r%-N4Tl//j"oTXZKrhU\Ijg.W+;[ddKfD5S8?(YG9Erk>3Cg*CQprip_J3B-
2ep7"dqZ\Kb.L93i^27M.!^TAa)ZYpCfF`+Qec=E/6r^PhF<+V<F0m':[iN4^@?a<!S,-+);
_]A.,j0Nj\jDP;[(9[o&W?6LS_f+fl#aR0VAK*Uhm<Tlii`Q/PshDkSGi;1c,oPoSJa1C&iQ;
+ZGjJh\4'0B3b3D9]AP/Z&Z+DS=0`H%c=l=3f.CaElM"5t8j%[]Aaq2F/.[LbTJ2^u/=<]AHe]A2
gC!CjWC,A)/h:31A,5=^CY.9pXXr9k7.sJ>%dQ)B$Pf$.qUJRh%!IoYDg:,,Fii)M]Au6Buu5
Af\/*\@^)OEN;H4&d,GX=U'P0_rAH:S,$&@Z]AaI$^jNDD6,hIUO<G-,m/'?cj[h3V>ai7ohG
fT1t[*25/.'eA.7]AXp-fSCI=Oruq;W0*n2?B)0(T1:?Lk*+YeUH(gkGMt\801RiWGCX!m@%Q
7U2eB(K<9WkC,m@F4W3sd,bpS;G*OkI8PgE8;^1,*Bq`!*ua1HDH]A)d`ah'459lX.I<[Vs(3
-RUiLBM`*sko*3+XYqjjKY\PqX[M-j3Tag9a'EhK8]A"ktE4)^U##n*K49s/V"-"53P52uhFl
cQ$;u9&/l]AchTqM<#/E,:BV_t_8E<!)LC*Q^1Fb"0.0Y)72Wn>JAo.=u0E]A`IY;KV^%JC(7T
kN4W]Ac-[pSC*!$B?NACi^3_=$LF)"OQ8g)+S/M>pPh$Gn]AH(^b=dEiE'_=a^#fso;@prVo@;
S@TSefN2/jMu%^6q``;#ubJgJJI,M80L&>r+N7'SmJQbVF%PnN5V>;58;p)NocfU3a(uF"#K
`CY/s>\lelIVD\*d=k9PMr"9O,$,N/;/4CW#F_p8V81mJYcZ5E2.!f2),)kr]A7d;$'#bu98"
k<u(XDNSYnoP2A=`)Be(V>TK\/['u\Lh(mH\ZjEhlE8ag<SHU;G9@=%#qZrb-5asCAXHL>kJ
@f^fSSJ/=7#)=XC+\D%DG=g#3i#9OX;YMb$`E#9e%a+MO:-=^4Ka:Pu.onf@\]AWfAt*a5iJ;
cFO8jX?oRZ!:NAel(IBnXTq4M7lC^j@=cPcbF4M4Q-G/dKoIVDJ.J>m>NQc=:$^Q\Ndfi0_2
u#^"3\KfVN(?oXi#o<(nZLO920Bhj*4`m+(dtPF<MRG+HqJY$D8=/Q7.G8Mg7r\)T4nh@+q)
3ZB>q_1+eCs8RU&%$QiVDu=<!A6>5+%KX>`$5iU@lX+"t#PiI4Vd)PKH@>O^fana6crMf6L\
5cq;\C2S(Wa1&#M9&S<9N@NRZYi#N-V.dCC43F<HM=&QXm`X<i:i^\)<EghK_L,EM)[0=/r4
FDH<115]A1g-DfA0W*X5/E_h)e&o8Y(AoO#@Aqd^&glRXDZ:SM!-:8)teV[<hR+-O3KjG`V[_
s4gCNUSSUbA>>)\mj!#h<`fkgUGc4;ade_e6PQdFtRlZ%qD`)?2M8b]AFL,mX%TN<Y_Z1KVMK
ic^fH9/t!D((!#D2aSNa6I>)5L$u09a2'=$>%@pPU\5)\1r8_IGsid79aS7g>/^lZ!8WTl]AK
b'r!&9eIF<&C^P?M*4I`:aCgtli&=o3Dr=YN_F_;<,88G^CNcDXo_h-A&+)<ZR4:<iSBj36Y
Wl^''>iboRqh$!t6[B44R#%:cHf8Ru$RZe]AiHckU&UaEO8eK/CWDId]A(#DR$A4b#C/JnJCmI
s:o6]A7u1.uI<R626jel\[I#]AT=A=1B5^"ZV28MCcT/5IjuX)Ir"HYoq3"+T@7L47^dc1%W,I
'C@n,3GT?p2,i#VZfYbuH<"g.2aY-,/I[>pSJWs-c.\lP_>tmX*EG<Q\T+`E'oRf2hk)3*(f
X^tlSM0C1.Sm'h(@2NaHFTYWJaa*58;9iKd3G$Sd_aR)0.5?tJ<[lN#n_N";:Pd.^S]AUrdDm
C=<GY)Tlq^=",$UV,G@Ae<IDB#h7Nf>a"+;sdj33%-Z%Q-a_(>i-=-*%5"WR[Al;sTLP\/Fj
3ta^_QZaqtYlT?D[*qVA)=YZ\/+DqgNT.Ca:aP'23UL[+J2pg8GIq<t3p$r,PH4$=>NQ?aqA
En1nuW+jWA&,Oj#_E*d"k8E:n_:S@njYg!s\LsN0cs4fY9SX':b$5e#cfP1:9l.f9[F(a(n'
SMp=GPB7!ai4U!Ml)4*'BdJb:@p/%YriA8me^jImWFm$R4i8tsq:P$!ikKR]AfZ!3ZOqg]AB#_
dj.d'.Ul"X6<.`)hD)B1(?B=V+%.\Z22__hF+`R&8KbBX:rTODH)5/`/Y54WWSO1.7GYEd*C
e>WCi(8S-1_Dd[=^HWl?OKS(c&!<aH5%a!\T4B`*t3#d*+bh42u-<d)p\h\t%BFu)imPfQiJ
UU+`?ZEX0Qa86Q3_pq#KAZ4%gXJ&fs.$2fdfKIn$a]AP7>_u$;g2.thdm_6KGmC>5/HbVu=Ah
$G.^7iJdK.p]ANq)C=J\=b)f+nB>`oEg//"c3&R%a'ZT]A$IBdF.p)g,,"hq%aT@?)b(shTG!@
.:b#:::7aH!=iOTCo^8[3"<gXnQ/UM.XGh_5-<39c[Mm[<dC[tsX[r_"^rM7'<P%iM')Ja-+
]A4I)i"C\2cu$8TlSW?[ft<q=[()\3a[Ti]A_F<14K"CM8jqMNZq$2RXTEpUtrCPb86%=&-o@&
mUH#0Fj1Lrm:#)Qn#5;fSm$5QX1qhLbY;`0!)2g?,]AfM/BD6oCgWK,oW*U[6oiOt*qO2_kGE
4_.cM4##P%B6Nu'8.pL3X.[\Fd&g0TKft_X?W/JIXg>%Sd,H8@TU`>jAIJbH`1>eiiE:KoV`
T4WcOP0TJg]A"jS^Jt"B->N)R%cY:bu:jN!5("gU4Y14O<H(>92`8:U\SB*0jC.+C$d:%0^i]A
P]AdU.Z?JS$)\nXdAEQ)41R]AA,<nccF@a8#Bi0\5u>S6>k\2,lhF?r7<[R"F;u]A]A!B=CiOIEW
C,e.8qUG:)tF:r?l7#@=Z4b\&l5;sJX>X7"5k1u*)?"4A7d>nlZ/+5WiGt:f0,fg,ciF&IZ"
9b`5!F3#aT!GOCC[=_NnAO32W`[io_q&2C!oNfNHeI-koDgg[,<l(,,NYD"2'm?S<Y0"GjPT
)EHb[BV\a`(n]Ak\%-njVliipnH+7^IF!kS_T'<7:7=g,PQL[XncOI,S(ggLd$YX*Md6aSl3d
-X^%8FcDQjFjma@%PME\rHVQK*r9l`ZENL-R<uKY#9>>)BMJr@<s3R!kI-M&1>m2\&u6QRaS
-Y4\A7+,1J:K]A3_/Y8BOOh&r#XbNhr86(&G5%>0r=hnM`52i_Q@7P6t4-Jl'Ak#KcP!qSuA<
+fV?L]Al7dMkA]ArEV"oj:(&6q<n#DG&obW\N/9un6S=nU$e?ddZ2rKd:Wea\8P$4K%s@GK/fa
EU`CHmDr9H(5?>J5=8+j>gnIqmpKim-<?M8s)BhRBGH=DcuP!DVq:;IiQh?tl@6GL/b!&>='
<5fUX#,oLJ]AjCtj9gK?_7"#cl%,[`Z9+QkobVV&6%LaadW"B%AksnIF:iDhV+1-T)DB6nNK`
LMNXFBmD-?9?oj+ciN(jt#",<dmN/UUlBEV5&4]AY6%?-XTn6$uHChoIR/+$S!E>_k]A/1aq$"
)(>cWOF.jH_P[uWk9cZJWN-ot."o#<ekESfbB9T9BKGnVqESW^U<c"G>2nr@GdiGf`-s*3(L
1h`@%tK>V9e(%@Fjl_nU=F6bTM-q,W"KN/'Hae#J,OYUk(U:g$f?#4V/Uc>-o<JYGI`F:\;%
?gqm$Eh!\2`as+.$MAK%OTKa=98W(rE2q3s^iV`!=.BYM5\Sp'',AHP0'(U+T]A!?-U*@2c;S
rDA,`^uWXTdCK>#TmTI[j(X.?XhR?%.RDreSpE\4>L(_I8P_$:a_\8U\[=$Xd4PGl2T#LaJ8
]Ae!@f>`AF-(;fQocU2f/FDo2.%*=Fr(9O/lA#$M8XE\;]AlFr;I[N?5hIHf`AY.CT-<9%2^G?
_XM8Y/77d+/\#r38#sf.-0Z,rgO^MQ:CRA:tQL%coZhCcr3?IXiZFKB=>As,"/dq:OEhb/T7
s..mF>WG3,h2Icd[nVIXE#V.rEk82;5R-U+^ScI5kpm!KtA%I4a@\/3u;%F]Aml`tm7Coor9R
&1K>+#!0<e@[0X]A+ufA5b,p9M-hCE7.!lA=7gfW@_dNQI\+l9:l]ApQ2gV<k;8&NO)hUC=agZ
M#ZoffTj[K4p8?E9_e6e6cjW.G\)'q7n<.r#R*MB80ft6Ga*#dYA*i4;rXi_AE9IRVD3?F2o
8ssR0A1!Ms5)/q2@bD!tZsd<m-khbM9q#UbRk6\CO944tN2"-mW]AXCS4^n,)r8T1_:mRP,B_
J4Z_C_r_C,qVH@Ja;'T5=\p"#dPrWZp1nftD@+DWi80Jb@e6Q"QBN$WTbam7Y^Ul"rR$+5LW
^3ReZ'$uAPaB#M-A`X?N4O7DdZDI@KH&.Fa`MnZ@?(hJ^_7RK[^0C^l^9k,cf/jhMf$[LS?+
409H0S]A<pPrhqbg8f'GA,-Ye3ns6ji496RXZoiE(K^XlCnECPTsEP-E:%=-\J%/gJ_>jC;<s
f$_[C'FpF+M2+d8*AHBt2CVTKQGiD?^;l/fVcjsk.1mX+\4ObaO%$#-6m7*.<`Z`cRKaS['!
;j<p']A9n@5i4p9;,bPXj&JgE]AOOdjgBh,'EPh;@'#9=h#VgSmQcTCNOQ?![590CXOlLULpn$
N<L]A(\m75)R9[Y(:$hr_a,sYbRHJ0''Z7O[G5W)POAG0DLX%QggBXr7b7kls,?e;MH<u%TP(
^0g&aqPc=6H0!Y=JeDn*]AN?\[XY+'="E*a=\p>HVa-\=glZFECO=%Af$/%G:.et!D?<DI-32
tj6t6-8j]A5e48/RV=@Sgr8b\?'h,rORhhT-Fm?7=nRAP]A9%?W5\,2Gm<de3XJAD0Z#O?EgCQ
c^P)Ajk+HG]A^>nT]A&RZmot9dsEEHoR8C`caMZ^jh>gk"GI:JB*gopQ9PMkg>.$-eq+%j;(_0
Csh"^?uf'>Xmdq<j,0E,X;#O0Ys8jhe<_7<uS4_"qPO$9M%(<s#[0C"1-MN+^CsW<(>QfBco
ld2f.ng4Sljf["Wt,j0>Y-Nm.f#F#n"Z_m>Brcq@*XiR57'\7G=5XFRnMTeZ$MtbTV*Z;m>?
8E[lHXQ&*?8$5fg?8nW2KJ7WdZ76=`0`l&@2p%1rr+uWhB;^DKL#'";]A=&P+sIj4,"Qg,q=@
SO(9ZiPA\!-Rf>8XEnNmOESJf*b*cjU$l,D]AdqCu29@uG$a8b&c<(J\-&0oBa8K8@UC8h5*?
A7">9"hLaW1YI3Z[^dh-IFhqE8BZ0:&]A_VcG2X"89h\D;Q2&&IGXVHRaB1&HBYJc6]AMYhp,R
Y-B+dba@C<I[-[GPW,r2npkGqno[4A!3J"P2_%]A$PMOEFiRb(JT\<fcOD.'NDW$"pL48RqZI
#7c&4a]AJH[+DK4^/1!o4fiZ?bs7[]AE_-EediE3*Gk2lh0VH_nC_!!"n@<Jk9^/a2&fr@"d7S
kph;r)2;2AO$)t5k<YuVc.\kW"Rj;j&Mn6&`G?m[_'8K>'sRH[oY5bZ@2(4#"WYdA/Q\=P+?
-PK2K8d0*0qAO(/"="2TR[MY/g.R,(LFfQ0r"mp9AK]A='`-4m\!K1rC4JcEKLO?>IXUYmR['
GmXm#]AM7uBe#/tAf`X!CAGprJ4a9QE7M_J=Cu05rMurS%iK!UDR_,^`:Eo7Ln93'1]AMe#"/B
E7gorg@p6$V>Tcbi!eVB7LPM1P?.\*#&KQlK7If>)5GoYE^`@I(OcB7eOf)\]AJ;YomZ"I;?0
OW#\sh:\j@L@6A1mdGAuehDSY!f5)Q'd(i(cF_B`8U\=UP*!HuI.Z%On5GWbk^FJU7+%5G/r
K820&QcIC*N--S14.>/K:<k`TG.?_%8BHp0@-5lo4GYY<fD)>c=@H4ZcllseNRC-JA.Yeomk
EJ5\+c7T1p`Yn>on?_VtR,r3orkr%n*+V6G*%j%\0:Ja1'1-YC&_Ng]A;Df/rWpaAs-+TFs7p
2fkW8n[r@:Q$RcW'?0fQa6t$DIV)&kgP>]ASZ&]AR4s,!_;hLZj&q+$GT9r_uS=@+#l]A@*9\Hl
ekam"&r\=mV:7XH9Y*I[.ViKs4:;R2E!8Ip$qgpd9TN3s-cH]A]A6bkI7h0jV[X5VVE#&fc.B!
4.@l%=/?5udVHb(bg;5S[1!pmL[pVM=!f)=R0HGU0o:P)@aLuKq<$l4cblBKinBdmIeFkE*k
6sr-!kLN_4hOClCUj5rJQf.uPW@@%Zd<-PkhM^+$n3U?Pt[6]Aa=8KD'J<q9SG"Z;7LkBiE/P
e#E5K`t&6#q,Q4p?dgDP@p",NU0I(*%%1+b3l+-(u)#jT;0q@S&!$-7=R!XU1^\ukg*l495b
Zb$rb=&oLes.hFH&h@TiJj,Mnr]AM(a9T78SZ1U]A^A9\"9iK)B=l1L;pj>s0eE]A8$?(%:)i=H
/)?RT*E"`G9*da%PoMO8g['OXS=AS*Ml\YtJ`jQ?eXb:'ej"=EPB0?`D1kiUfs8IhEUY+gBj
_/fu.PFg5)aZio[,Q2F=n;9E]AmSm/Sa%]AYC%5OHBsVhbkt$1(bEcdHut(7KH_cG5eHY2eO$i
=kPtor^+042M1e$&oB]A]Al2HV0.N:0gU:'F$;UM9$c+j]ALk#;"eC8?HoFDAN34I"eZCh28`7%
LD*^"pFA;l%i:<<XYa>E3YN]A>sOghs=[4EA5WKB<_mP8WSo3>5.MqVmHAroFhT?c!M\(NV"g
RY6EX@l##=Gb6mt8&CiHn,D;NdemN6\o^T@m'aHsOQ]A)%0=?f5I0FLb^$LuV=;3QlEUbP_Ar
hTolk]AK[MG9$e3t_s#0/s&D(rhElijW_jbq"ajO/2]A.RdF1taH8c\X*$qSaLJ^MkT,%bdiOF
hB9&-2TWC)C.+0Vq]A2mBC<R;uR)a9p?H?7?.5<;a?[W>er_JI!Gnsrers"se!C.\)c[kD<9>
r(!!l^bk'cJ+]A:I*egS]A^JPS5jLk1e_HNBJ)f9D>/sVU4;ubK*W"->Eu8N3okMP=6&]A2ZkR<
S18#J0uM`T!e9OZE0lOQ]ANPDK4QkZn&cKlQuTX)Cj("F;jDq']A=pe/<TS6#snTY^%^o8s99@
_4"d[=t?)ikMX(TEWI0Z.7Xe,9O71Vn9=-)c4QAKFN<8!EED_WTc3XJ7B=bI*Q67$NrI$F5;
rGY1"#Cc\CU,F'#.MZ3M)7hH,doLNg]A28,!b:AS8u#3WX4\9R24s>K8s3-55]AK!abN&]AifN\
H\@*)?D*I$"]A)kou'7oTJ>O#>."Ig%&9WcM+>Ws`+H96F9JB:X>T/=ZTL'7#THrU*BD9bY!L
@=M!/qZTO&TICJ*L?]AnD0Us'HB=%LnWabnJk?a&dp`2^asF-YS6:Qjc*0$7qSRL^m8@_bLu$
a[;EO0#e;o@>RY6d%T/hJfod:iim6!o1J)2;'lV.2mp]AWr^\i/g4O%LAE0WS@s?M#>4*TlUR
-,^HfKn!5'TEMM)LR3T"@b4pt#PpHs_-CT1W\3\bTt-1(Bh*j#d@pGJ5[Qp%JiiMVl(^NmAK
FINBo/Am>-8=%R4@QXEkBC#5/W2kic`JW-2%R$G3T(K\8ocRc&c\Vlne,/^Sus4PbmtZP=gH
\b(`4qhf=\CZMh$\2JaVfBC@lMZNr9tHrb5Ha7YD-4@s\Bo8b)^s5GO\os']Ad-l]AL*NAqWY^
ZbC2UXkgIT>LSu$g+L8OtJtZP*!fnEMc#UjE%_EUT04bkJYoYOWG@\R<s1b%LhO"?Mrp8ehf
adH*1,%_YH7r=/L<:UA6i0SN"LeoKCFgYN(+?jPjo=:^=i8Vf)06oW6Nn"S(r-/FX&2fmY-h
<#ts?Fui3]A@E^dj`0K/jLHeQ0"s`/m3>R]A&q#.%7&p`(kS:PVcJE_PWZ.)XVH-:md`?dL+r\
]A>E5e2R/7-;S'Q$AlMXAPOa^9@H.phOc*IVWLLU:.2M9O./:8KErl`8+ufR-0dkQ/,,n5PQt
pYp[`K[oXTB'Q#l0c+bX^i(7P85)^eO<_rV2NAE]AiJ;&l25gj`cE'9D_%HpB$=$PW'L^9+*2
!ScR*RfoJ!Xkh83%`%@2]A4/,dY+h&Oq+\N`D,hIo;j"895T/m4jK-?T!8oT%QKn1=^h28lk-
kUiG@bL!RN[:'!afETm#!Zm/^[^;+-lVd81(+BlC_Mo:UU^_o8G7Yg\MoiN.Cc"<(8s(S$Bt
E;)2=+8I2U#LI.bfKOAmn60o0ESC`i(ogu(1m=%`8m,ZTI5<XO:V4qqp<6]A0EoY*J^$WhuO8
O>IF3Rj7gE@_feK\KYLY@LcfGkB#1)'h:?\^Os#$FRXU"D<m2c'Y@<UPLbeS*A)YlD$C#.\`
^he0b&,dkaVLOV>NnMgU,g6`K#H"?#"+A`#G%K)d4N(\G?IPtsX.+'.s7#WV(q5W?X,6,2r#
oLAla@d;>84WZljp,)e3EttarkL@s1#RhgrU[8M4T[\uMY[#$eRqq:`LeaQPj:p:'%SLeW1&
N:Z4&*bmp.UE=TZc(Uk('P/q$3Bg':^iaonjjBKs,d;AlDr,nEJOCg?e!',*PJU:*^EJM`#c
W[s%Pr!C`Y5H\3NqS2uq+a+V7fV?l]A!G!\>>^aY-]A')r#NpM?-/Z9g7Shtud-Qsl(0Gd2+ab
)oE!,IcYdNM2FPV9it?A6^]A,l;0[+J`8?2%gBZ!B_5mX<3jqDrsO\XF8F"cl,sL]Ak_)l=tT)
.!?J"1-V004V(69DNYh!Lj6'id'!B2^$D%"lWNP9B0]AG4X,@,]A]A`b?*[ILVUtWNBt&0dOdd&
ZeCO!QXCSac/lY+!DfQ=i)1(Q!'!lS7Mp+&Z*clFFXMp!\rSS#1XQ%Q89^rW*,t_2tT64Lg^
2F4KVIT9q'TQF`3$7)q:u:io.EI-uO/oVE,=LG6]Ag#V(-qb:)u-CW'ZQ@f^lg$lC]AQmePpTs
ZRX-AXV%m9N>@X(RI3'+O8<3p84rJ"Ei3;.I$FPp'7/5aC'DL1o$krW-TF*2lG6nsX\V$5Ta
fVE5sG&Z-S1?KN-R&M2o2R/dU7fsY"B0ipoZN55.ZO<Sg]AD>7S[6<lh?@Rq%>_ejMAG3P/nQ
Od9IFT":3AKpIp7?FL."I>kmshjB3G/h_Mr&kmRsR<(I!V2A,q81:C#4e:[q+rf/C)93L5Xm
e@534[W//SS2e62mAb>O`qQ:U".4;<'q0jg;EID*D83c!;KIf;Fh_);LMhWj+M/I0M?2fG*p
MHc7ge3&d2A'"MNZN3Z(ZIXU2^Q/\#^l"1RZ>F*MNn1HGn0_Ot%=FJ98pT34a:B:s36*6u_P
Z;j6%/]ADfmTI"pgUKtAabilD)d3>#<IJZ7_".=dmU(4X-OlcPPj#V(X'+?G-a/FsaXcjqEKg
Kc'&1mYYrCF?;)*Pb`eb:@]Ap,c.8M5(Pidis?.X+t2B8,0+%TuKpLXVcDuO?#pLQ;ko$3S#'
^f&tZ2:MDsfod'aX@M4A,e<0W=p2MTO[;c,Qn%@2;c>7\')#FAA3I`ep5N3Y+cm]AQYs138`f
kAuce#e^051&i8&rRi7#=m+uF1XX55$t%cS#hKe#^Y/`n]A,Dhruq=C*_4B)EMK=Z'`8om9@_
UY1KF,:c`d@)@(o5I@6br.]AHa)*RoS:JX&qc5B<s)3iF$D9ZmcQ?_B!TISV>&sq%BJ*>eD-Y
<16<7<NHZ))$E*XRqL?2O0EciKNOL2e8h=k39*9h^Dk^YVlWO*s(TtD1MPOgd^,1I>rh_p%B
#3Fg':f/p/b:5,S,(ur=YV8j+LOc6nNH>k\`@&)LsE-'=3"S<MD)N,9N@Vm*<IQZg3(8`$V%
^Zd8*fcgY']AN;PbrI+"E,qL?-Anb]A*R@?/??T-hjW@.1Mr/4LpDk.>lYfiLXGEV$HYNmAa!j
elp`,Lhhl+1@?#X,d`Xph%T93[YQg?2pshb&CeMWt==f>7NO\IrVf)GVT#D%FXiqgI!;$S_/
_7!?>NU@UKQoEZB6D;<Hfe(B%^Jc@VtL+*M_T;<D*-W]A8sM:&l&IkrS67(;ENjfpGr]Aj;hZo
3KDBK@e)ULGo%+e%h>*1_+Y;t*SuQ$ZD=V4-ToEHB8MY`-2fdDA1&RMW*+7e+\<`W2Cs&C7%
(WID/"5&?1beIr#03rB9L+1g9F!+Z1B7M7'Uo9)pc54\@_7(0E9\db0V@s%M,GF@E_S=C<2/
^"Z(%afGuNM`124rVVN4RS1iH_Tq.6s1Eo('XPlBYBJ"M\8Rfm3IaMn:MI9Yn'?]A$n<K)VEh
fOUHM1LT6AtL@&VeF"/M_\RL+@^pL)k=L0,X6V-PADO,Ums\ZMlJk[s,b.,Y^)E2!S$VYM-u
+04+fZf8=cnBc!`GYl-56^IB6SmiB+V^;.JF@\c9@((q]AguAGt^FJ5l"Ef!-M2EDV^%DSlFM
d:/'@Ibs:A(]A^&I/^5cLF8%_IDc%K%ph=^AnEKObiH6V.ab`cbNO4sb@0XK7Tk>IL\]A1R:1I
1nsQ/TA1jc"q9cY@4/6po25fD=-rS9[?&4m5b#K&73hJO`fQ1d'nK4OBhsqBK'E#QeXVJ&JT
aCU6hsa-TrFN<'g</X\I=@+LkU]A=EG%&aP'O+"hc9J3pC,<')7Q@XfdEB3r;=q"!S2%Ts4/M
W[W8@XX]A__fUXdhhf7Gq5TIFMLkRU*<1dIJ1)_,k8cJc1bhX%rOr/\%ZA1(\@^2EX/TR)^>K
R47.\842\'ipI-dJ=3jWjM0kqed08n[[YS*h,%=..Ihs]AGfGSiI3>M\^dk#h3,kc[)tTDuL-
j3)fVG/W@K>%1U'b]A$)G#b&"1qd4\iMRd=VWora*lY:gl*ZSY5J+U2OSG;s3:WG%&BPYu`K?
R\OWac68dmp_W(\R]A;JaL3pDf'a*nr8\orI4~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="470"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report1"/>
<WidgetID widgetID="26eac0b1-d1e4-4b7d-be20-4ccae84babbd"/>
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
<HC F="0" T="3"/>
<FC/>
<UPFCR COLUMN="true" ROW="false"/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1676400,1296000,1296000,1296000,1296000,1296000,1296000,1296000,1296000,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2160000,2880000,2160000,2160000,2520000,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[价值\\n维度]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[指标名称]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[权重]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[类别]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="年月"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="1"/>
</C>
<C c="0" r="1" rs="2" s="1">
<O>
<![CDATA[成本]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" rs="2" s="1">
<O>
<![CDATA[不含油可用\\n吨公里成本]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" rs="2" s="1">
<O>
<![CDATA[40%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="1">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="吨公里成本目标"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="2" s="1">
<O>
<![CDATA[实际]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" s="3">
<PrivilegeControl/>
<Expand dir="1"/>
</C>
<C c="0" r="3" rs="2" s="1">
<O>
<![CDATA[客户]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="3" rs="2" s="1">
<O>
<![CDATA[考核准点率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="3" rs="2" s="1">
<O>
<![CDATA[15%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="1">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="3" s="4">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="考核准点率目标"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="4" s="1">
<O>
<![CDATA[实际]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="4" s="3">
<PrivilegeControl/>
<Expand dir="1"/>
</C>
<C c="0" r="5" rs="4" s="1">
<O>
<![CDATA[风控]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5" rs="2" s="1">
<O>
<![CDATA[人为原因的\\n严重差错\\n万时率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="5" rs="2" s="1">
<O>
<![CDATA[30%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5" s="1">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="5" s="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[right(E1,2) = "全年"]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[1.2]]></O>
</HighlightAction>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性2]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[right(E1,2) != '全年']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[/]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="1" upParentDefault="false" up="E1"/>
</C>
<C c="3" r="6" s="1">
<O>
<![CDATA[实际]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="6" s="5">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="万时率"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.ListCondition">
<JoinCondition join="0">
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[E1 >= format(today(), "yyyyMM")]]></Formula>
</Condition>
</JoinCondition>
<JoinCondition join="0">
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[right(E1, 2) != '全年']]></Formula>
</Condition>
</JoinCondition>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="1"/>
</C>
<C c="1" r="7" rs="2" s="1">
<O>
<![CDATA[人为原因的\\n事故/征候\\n发生值]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="7" rs="2" s="1">
<O>
<![CDATA[一票\\n否决项\t]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="7" s="1">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="7" s="2">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[right(E1, 2) = '全年']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[0]]></O>
</HighlightAction>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性2]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[right(E1, 2) != '全年']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[/]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="1"/>
</C>
<C c="3" r="8" s="1">
<O>
<![CDATA[实际]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="8" s="3">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="事件数量"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<CellPageAttr/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[当前月份及以后为空]]></Name>
<Condition class="com.fr.data.condition.ListCondition">
<JoinCondition join="0">
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[E1 >= format(today(), "yyyyMM")]]></Formula>
</Condition>
</JoinCondition>
<JoinCondition join="0">
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[right(E1, 2) != "全年"]]></Formula>
</Condition>
</JoinCondition>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[]]></O>
</HighlightAction>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[事故及征候大于0标红]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[E9 > 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="微软雅黑" style="1" size="72" foreground="-65536"/>
</HighlightAction>
</Highlight>
</HighlightList>
<CellInsertPolicy/>
<Expand dir="1"/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="72"/>
<Background name="ColorBackground" color="-7223594"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80"/>
<Background name="ColorBackground" color="-7223594"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="ColorBackground" color="-2758673"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="ColorBackground" color="-4531745"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="ColorBackground" color="-2758673"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="ColorBackground" color="-4531745"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[jLb^s;ebtYDFY:)'L\#b3]A^_9M?WKG,2e7e!`hR_)?CQWN$O(BTMf5D0K)a\(^m:,(_A,>M%
,INQma9Q#SBT5&:/kgj<&K6nb[d1i*,l)f=gLQ'j[sJDqSd<HU#i_pNnOZZ+!jYY9?,Ig9_$
qG&H1rD;&f6g9d9+kK]A3<UV$BESS?PFb]A[j44:lnPMb9"6`M*]AuV&.4kC&/$HNk5Mfm!Or.+
TJF]ASFWfjB#/,hef:)QR8n]A"i(WQ4J]A6D+ZPLl#[[OV'4*&H6;j#)n7Ykn"os7_F'uh[Hh>=
MoF)D6oTMU<^=_#O*k_^ifW.jq8\T^>7BNBA)QY(^bHY^["D@0(ffN$W1PFQrVl=.*e7`OYT
8h'Tc9!.0>l\H</1`eaRMMlhbFAI5glnWa`fO2qplPHTD'<WP<dSZBrDX7XCmElUSd>M`+MK
9O58lG>+(a\9dSbb]Ah^@U)@@(Qrb@dnFInp5\14IF@,?:%;[E$=bSA7+-&s8LE\Is:c$S9oW
e+TMJ_BeCh8%efVq6`@[S'+<#;pS"`&h8cc!"/s!`I%W=VhW<.:ookAt9]AXR>H.$=C`!G'A-
GjK[4r?S+e,>*0^suQ_A`L%03IJrkOJNq(p)X<aH,U!=?qC9NNsKpdPP^"V(Et55+>@"!;L_
55BCGYWBff]As:Qr8[<[j$gU_+[-Ii17TqVL2rEVO:>.th>so(c%OMtc@C(VMK%g>9FYdJWdV
7i`cSWsPQNN<rrTLr":Ze5%aD,,ND.qWD)mHm<71H!Vh#;\nA)`H3mJ/CsgREVj7"Dd`LFV>
qMJOE]Analm"@,h"\2bqlZOjoO.>,_Y254HcJX0QS*YhV/oDd)JU0&VA#OMM>]ACY4K'oG)<:d
=jld-HTBu2&>X,oLhmnMs2#j>`*$V<Lo&pF.]A:u1+P4BRV]AiBuTa0u:[=o?.qA]A0FO]A2e]A3r
Z#9fGO*4KLs=Sc=auA#pen=D[<mnGllR/%,n\S?8%3^\"STp;(!]A?$.b)o7[s1+^OXu/3i+2
G\8!^(Eq_58IqmaJ/iKAGs;ViR.lm&(M3e*b$W,q:iD4,[\fdlfgDq.]A;[C'3B]A5Sa>GN?WF
n?HeBkI:3&\bXFM+fn"Hd,I5I7^bVsC_16tZece=%XF\2T^dDRP;ju,b%>J6fa<=H%TmMHKD
t%(oG]AI-`R[]A42L_<7DXY9m/$8)>I3mk':>)u#r2l#)n6(/iiKigXi&XrfALiSY(<a.nqT?`
sA5DC*#\C&WYsUtYri3DAN2qkMNe)?6mGl[=X":=<ABqI:MH_U,5q8NKWa#k<)?&=R"0Fend
k?*%A;6!gEr:CnH$&#/NcN*F'pupOhVnlH]A32F,68:lO5nVO+]A2^mrQ,fLhD(r#\PfHjb$Th
Op_:OF=EEnbkDR</`J2O^NP=Xc)L;m<QrH%Cemu,ru^2<c*imR/F`&619J'.\gs6BFR2&EZs
=Mqh7J'Q"_!,)k3KY8mMqH^Peo+S8l(hRFKbkbm]Af8(i7OMusVY_IbVS1K/G`c"D^il\Q*2J
YGKr.@CQc2!ioYElbXU-_>':Y+FsF(_lm"bkM`+DWLk=)g]Ab4<U@a"mb%1%iq!Sg`uD$]ABqM
^oi&?oX->ZXVYf^#7q."TCU!bn`?u@K)d(lIE)qP#8hY*]AJT]AGtA`lHO\Qa#LAqI]AjX(9E,N
`(-72dfh"KnOMi1LGPo^Ol.54HI*0]ACM@2!P=mdg!TcUg-ZCj^RSuj@=.TI5WhP]A.(-]A3)fO
aq;=YL]Apd"Udf_b925(,goj-MH(=NX&('[GmKk_7&[S*u%/CD<64@W?N1n_Wp/9[PH@V43TZ
j$"eVoBd&1d]A;flq6pY#q2;rGV4bj"`^3QhUnos@.O$4$D&mb=bgp%u#LbZ2K?_Fh</lr,N&
mURIi93D7?#<QeYdnYQis]A>]Aailnr2Hs%.CDNQ+"3,[9,UXTnb%W'F57)gMUMYUmDG<&E!`^
'/VhT\X`^6i89#``n8p7.]AB6j[1\%0_-$0h`FL03N77)QYE%cjL"AJdm"ijV/48K$"qs=RY:
W3%CL$-'XL</*rB?4RobW_55Hf\_KDi'q]A)^5M'UHVpD7pIK)IbtIr-C2=L'C/WuipP@7-$j
Y%\T0g'cMM@_X_g]A,rlm273[#iEF]AqA7^,<iS(gbK?IUX^10&E0^Gh7TF`oObo[pT!efd-h5
mDY.+:-(h!I5IOXV+$Y!;(GjTaoi)7]A[t6%>6BkO9Y.3nLWmKHiY*h$B3;j]AgA7eL\0dQ)jf
Y?M+jdU&\Tn(s`$=Rp<k\Vf)=KW;IjTaf3o$?ucPd'Nb-,.qbM.W6]A;p,>J'Ti%FSZge3M8]A
f`$$q*"M7trpf+YQETaci&WQK\aFsLf^.Hg\"BnX+#L/.i5l6X)>Bt*%<nf9:\6XV"q`Gq#*
u<XZa"TttDZB5h>D\kmgNP#P#]A]A;0pfIUgcX[UZ,A222KH@YjY.\B#l?:.Q2tfsJe@K2g%[5
\S9lhJF7Ce,4_H1sV9AEVPZD&feBs%Kjg\c:?AKlNNZ#OSY_#aMejs[WiDuPujO4qKngYo`;
g'Ch\Yn:]A)n'i21S^o0#;hDNeM@5^NDlb1U&+d-[;E'eoW5p,Z7YLb>X-[?`>CYh:o.j[\r9
d/+r<8TDj5iSpW>]ALkS4;[pDY707f(2QZe3P[U>UWk"-J(e$eJ]A[U$ZGWMore'J6*)L%#f3\
.9$gpLd9?4cjSP^=$]AiterY@IS.#a_]AXW`!ra'8E8Mgo5fOaul4_D0MkQ(&^m_&@#6;/tEBF
<5]AaR0bEi(29&l`7EYC6X@#4gkbtOUmVT%>[<[El"_l4#KlbI[U&/,0a4Y^'01jN@HFR*+2&
0g"qmpll&jdCV`_K7FBKOH<od_kD%`AGG>J&XeE=?/G:m!$0CuHb-^BDk^)1E$S<X[XF\IEt
>iG+4Th*eI/8)c!DKKa'.r`ni51?.+e9!,Wc^D`BRui(<=IP/`*Sng-=,a6B:W#rs7R[7>9+
)<6@qA*_A".@S7ZJ"++V:D;_3/tH.mG/1/fi\XF&3Y*ncTajS6QqWSXl^nTa'nN;>APeZL4=
Hc2pSu@8LX@957W-5c?m))J3M:N9i#N*i"Zd$AO0T9I!3;)T'9?Q*`?:PW%[7q/T1^5.p0Xo
%h+)QsgGHlTP4^%Jo,S9fNqFm-%%?)"#Tni"hIk!;S_l^2&Z_^r[TR<X3Ca,cqN!*mV+lX;_
GE?L_a\$;O"uSobS(,7)\Argo6g'7+?bR-;4dBo'81FiFj-9oQlfWmHdlOo45h1TB)A*57oY
24N^@D&Y\711(fBWD%-*_1WbT+6L%$j4-[:EBY*AG@AS^VdU1`n2"/BY=/5$#3X(re\;!;*,
u61/XDE]AAb'h<2ONPMUE/RZ<A$S=TqEb@pkaI$"%805]A90'"IA@n6pIPc<KF_Ue.`tqk_4i(
8"O?]Afr;LBBar9p=nj"1$q;eDPOjrQ*]AKK62`o6/r\M2@Ap7ZhWEd!Fj0.!QtJuR1h\(2cW+
22.M`oajG0'lqaaJs]ArH0qTV>!\Hm>Z'(Ufkl:WI#=m4Y3K1Grnt]AJ_\TCq0gP<k[NQ'3'd;
hNHY<q$hT8=#RTl#6%N0#M#M:N2.$;lOh\.@YT`UksIE+Z-LiD:N/F5$:Iecf%FWTMZ:q'n'
pTKVs/9e/odTgsJk)\33=B(:>#&cT2jUeo0p0O@m?Zh"pXg1I`6'Oga__X]A@[f[l1!NO6?j;
R`Id5-d[R7,=B2[h#nTX#]AFcqLcqbV3k>&ZAC..L'^I=X8R_Y9Sa0V*eb'EdGJ4FHO/O_"*n
s&rN4i0l(h:S.?ah:j.SF/NJD5IB!RE.!ip%oIjB2Bd,\6YpGtVTGXtWK9huKc3gsUL'!Ojf
3@*170e$sp58[:eu0KIFAYGl0-(0co+92jU?=IVb#$<UhMb;9js@qZ,/`6\Uu$Z8G&pXXNb@
p`m%GSdr8oDt.mk`!b_!Tul:O/FX=X`j8mTN4r,DDub,kR)TCU9q1)-cbbh<G,H;_Vc3k`e,
1fmu=OR')?C8PV(V5GdCoTB,27q5<Zbj:@icJec*k@mZm1IMh&/OhKlJ%OR0)gjM0pjhkoV_
-p_o?Q<rh<<@_6:rP,ER]Ag+;s$fskrk<4RqKQs^>YAJ#R_Q^CEbGM13'-1E\mGoMfuC)"gR%
oIVX8F&L-CK#g.qQg0e0e(26QZ<d&jl`QOnJO=rMc#cD6;[@\Et3taL$)G43-g$oN5a1_eQQ
7N64]Aui^53F1I^as(uB,@g(GBr0:kb>[o8HreE\TfI'@I<f0JFEUT[hA`(J;7f['U]AZ9jiiH
@L@B.G!<t(\biZE6pQ3Ik8,e\NKn%fk(%A30KB#N+V`Sdq+S'1p%3KUV6RG"Wmc`B]A*"F&Q<
Xf"e!DsW0CiFWdQRQ!)RW9Jt,C8Kn)P@hD!]A#Nng&#lVs)i[WsS>2n@(U+6,Sgpqc`rLC=bN
RurY5A.]A.$''d`Vl>Vqb)sb&h;ORiEbZG3k76^%R4^!%V377oPt"^I0]Abo9X4a(p?^ZYKhok
6/3?EObd$+kpC_nelr8`LWZWUY[21HqrcPZ#D>Gl#kRM@B>j:t&"]A2^m>)/"E[/N$_s'c-p:
*P8MO9*Aj=nSS)8&_mq-6,?N_e%BUn3jf4>\r\N;2R>Ur\*4(?&^#j%MPPIa=?.T17nC]AbJ$
Z/@s5&D4Dd8g[q<+JJ\"<$lPu.ZN'G8*#PMh]Abs<$-o=(OuHoc%AcX5`1(d,<A#Cc_lU3CX1
eRg'j\2KK"UC7779.)_""><n=jA?t$)k%Q'"br\#hq\LmNJgH1p\rK9^2M8;<`$bLY&+&R6R
UFp$^:3TX8*2:(,=:Nf6VFh2,uf_.;A;@$3+Xe?ZMPBPf9h>80[eQFNFWjnCNX#d^Sm2s0E2
]A*N-J(rSF7T)#YJgkO-urm9Jgb2ej#02XaaV\>3p/P0HH1NFc\38hMPO'2?dmqL-5f($=m6F
Yg@7FR@-5o!^%FT3mE%";#A#*8j'MPBca(TBfNY*;VuC5$Dj:bkW=;j.)U,pg=/4?%ZWIQ=H
,AU!73WE[O]ALl1+h\05LI$H2Xgu3DPj.5g8uOg2#QfSF`j+]Al+7r8&dV$:Y9Dt]ACB7KksoaC
7`J6T:R13mQK3E@>b`m5*?:-2,Vn(4dmX'F=+B%M<UOs^W$>d;gUD9oXk40\6"S`\?U)lZlt
n.-s3**`q0ij@`^p]Aj<2M[[gtB5r<f;;;YWlOWS6==a)hh(j9j%C=fuCk"?[d7R-g9a#9jbS
C&ZW9?ioA/s\'%lX,i]AMA4;<m0MsML#nq!pN(q5]A<0PGG3,.)i$hmf$l+_7jEBP5_OOIACG2
\W01RWhPpo4NjW[IXkg/+]AONbe)]AJ:7nlb#\e<lWt;M5p:23C%U,;\U\JS/"@ZYER"ZDD8.*
%oZ,<Ph=q$e57?&RJa>''dE:7i?+6DI"-;0m;YZA-R&QH-BcXh(ZQZgq;fCO,Kf2roRU<uf[
r]A`]A!dR,08lqO!4^!9/"&9rX6"4nVak0_BR)\e\4&o(a%$5s2T3JseTj<i0dK&Ypn*koIRg`
ICB'a5B$ZormY/Rn4-B,LiX?gX>%k]ALE$+n^+]A/op9*hHMXfH.cJF%/u@/RhoqB%5aE&2*uK
Sj[(`NPbReKUV9eeBd\4MJnChcTMVt*iu4^89)Y1)[gVQqo&J:ZkE/>`Eq?.=9SDpHUW@pfT
sd5Nk\tD(r+mH]Aru3<<QW+r8I*@@MMi-EZ+Qk&Sp5&bJ-V%E&JK0Q"7e4G:TUr5d41P+NQ"8
22S&6\"f<PHaF4BB_'7"EY'HWH0;2QlPN></W^85m(!\;8!hf:2q,t]A\:Pu%pNe$fj/b:E'o
)`j4[)lN'2\D\-!+.<ogO+Q:r5-:lHB+.<+iN@A\agl,)L=VVe??H@QoR9o5S%N:%e'6Z4\\
HAd)K'Oil<lDR=3DVDM`eMHPfU,IO1tLVac@8%'W2POQi^j]A>5Sl.Y[@;omA,A#/"Tm0h93p
$_rkl3EGJGS;u)Hj8o.aZMfD,-"+s/il/0f-&KEkC8:Ns,D1:H5[WLFVX2SYnVec4u1J_H"q
ujZ#[fk@KcfmCns1PY_prG:V`Z_E,n#o"Ya24.==8KAsOI,^$nido&^76JF.`_]A$QCPmSn!W
VdQc[h.SQdr%q;.T<P$Z_>2>`,h^7rV4+RYE`mlt;YQ3EC,>'s+:P(EVeao9[(4+).-,L]AG=
b81E+@4*(Rn3.73/.+6tF&Skl!K^X`G4g(QO6)U+>AcP8#<=D$'SET,Nl/iS>pu(3TDRqb<d
MhTpjG9M4l/*UF<s5G"jOtCqI5UJ5bJnWp1-)=lTse_G\B<e>,X=Jchb?d668T;/")#[Rj3,
]A/jqp1d,78hLhh`6#[14[f[VWi<&^OLK$8P1NC7jWVOq0Nqn0&)JP4)Pe]A<]A*P+b9V*.G/id
FCY6hFi2B6)DKlQ*M(gbcQ"k4&)LL&'*o'Tdto\C69nIf_q<Le0('uSDkX/6Hq]AO;?u`ikR>
XoFc<rm>J3Q9+`b&)0\\ttCo:CsGA&MO]Ana>(.rG]Au=A)gJ%@P9KU^007./<jTXDSnV^PG-O
+h.\49.=u)Z]AX+$j?f,tp[\EKo'.</W(eU0^B>`nobho&eISrlT3^ELDJqAeI0?t?,p.n!<,
ARF0G3\G`%bb.]A+;HO+rFNOm0[DDZIM5,8.p>!jrE[3Gp6n"UR9YYCRe2.L/M-Zb[k%LVEKa
Q#D$(P5=W)6Q5aC"Zij&oe&qd;3`)RY'Z]AN^Paomf)6_]AE]A_0WfLI6FRjQE@<V6kblqjd"OO
7eXV&CcM!<3\k#MmG#R=%UE8h5n0_7Pil42cl*Dp^9jZ?*#B(-TD&]A/ddV?plRU"D3N)e_U&
Bsq5jj^'Gd.70MJO,VH9qoduA`"FH9?'Lq`?FTi!?(c1T#eQ%nE(GM%<N)<%U0E*3-o(:=FD
VBt9+.Sm36:YYN@0_E^g@:Z7gp]AJ+kZ4`99O\ED8j8505Qd#d+L(?0lWi!OXm;UIH9IMJ2Gs
Y+iI-U02;sBH20g&0#+Q1/J)(nVdK.-qN=4X8aNN83##L30*gsb!OB^q?=m@6".1\"dSq>qe
tBF%5Dr=:E7B"j4R.L0`$IE@a#$YEs_"um*Rj)]AsZ(kM\SaY?:ZMP/?es+gi$hE80<^ud2Gr
D\/B;^E=1:JSpMi'fq>4"K6DOd#*B7Tir,K.EP&ALOWc5_.6!ZAi:I91>X%\^Dt$dtBomE:r
9_W`&&4M7:=Hh9DP*_J<>(BK4u9-,)Z`Hs?7U+aYqW7$jT?CT&o22?9T4/Qu?\>R`]A78:1+=
h-D9Y@sJ[@'CDJ'_A8$sJEW+Q,WKW9E"WcL2]AR;1dCV:CNaa*\1[eo?>`YO)Fq$nsR+0qHn1
e=[/:Z4aiTTI1i5El)S76ZS%\m4"/+bEcq9mJ<6Pqqgb6RKK'pn^Lo^EIs3d'5EjYr\jRd_s
Xi<'KV'OK\1]A;Ii,"gX%)B1_1Vg-\&H`6Id[AE1KN[Z=P!q=#fF4(e,6IX\er=i>h!:o>+a\
qZ,q#0'e^1U`^U/ZFF'[c;=s3iG"[YX*nE1L?Gchn?m4>m&inX04rE4^Qf*-WR*>.4S:$;d!
F<)$<Q"_&8M0KGYRC>tOh@pc(d'PGK94?e-6WIjIam!jl_A1K/h`ZB&5EfKiPF*CMb_!gY^5
cM4p#)VV^6.+HN.6o<cdUU+3A!*b^Sb!+?W_/J/K.Hnnp%?/-\Z[tMh"!?cY?6--[eT8d'R;
*WJlI9njjT/d+14p$7g>3rS0j1A5C'A0oS1<FJ;PdQp('A540*c**Gd)KXY^]AmHB_KO-EM"P
G1sGsgpH@IQ,Wj?'4T/j5Qe1(3Df*9cPG,=C7-tMti3#Wb;QDZ3ee`c9_*TS^4mmTU>C#Wg;
+:sp0__-N_DG5\gH^G8X7FRZ0GsUmS6Cr-@[hW<o@E8@IC^?DCmY+"J_AX2WQ&sm*^CVB[G9
J*IeA.Ha*UnfYZ;HUN^4e*S*cuY<_ue:^>`CT'f<RZB8-h-2-,mX#o@J!>R!)b-^3!XC&p?%
*t?fB4h/f`>F;7Mb/aaf(2rTlSbs/aT[si]Al28UJ"7'Lk:WEH_-CNqA75;'m(jV+9,KAkV@+
Id,s0G1>'En3G^5lhL:q-:.jg9@Qn/(!-&MIq8OfEN3CS*e?RE4%mK-)9U,W+Vo=Ypj-'o(+
/L9`nYff&D:]A9+^cUT=I[^Ak!<>sAn:Pee'N+,,UW.^-'[>!"Za60E5/gWB&#p%5i2F8hrD3
f!8m6AJgPeiJn=\r_Bh&@(j'o,67-atH9Gau-LKNpD(Cs05?Q->nttrXt!)!\U?+%6'C*g#(
+2e^d3*Y-,\Uf$6ro9-a-))S%3d(o+#+Jl(93FU,$]Ae0$uKWBT^]AiY\&Wk$[UJ<rE""=IrO&
,]AC]Agi=ja-+C8g``N7<6LtlSORJ_<t<ZF:=Zco+T"^KS'[?l8cFg@Ynppc0Cd@$;;HD]A`i?1
/kQHNN!iYonol2*T$UDH";,=$EsoD*8N5iVsLD5>q3nFP+W0F2q:FZ'"AR%]A&apc97c=EVCO
#V(2D1jKr#Vi?s@FmU8,'Kijn\5>u7s<&2L%l'kAI=5]AQZTs/DtaD>:Oq1Gn]ABcJJ#b#7_jD
e`9PC(6_"Z)f(j;BlWIETI_KqI0inA[`&SN^>70N"B4heFZ5;E5Nb\VBK@NH\hA*)@kO!5bR
/oCB'^9r.DP/XJO.0^7-,kP/2[.S_Y=m1$qhLcH?$n2^1&bg!on`Z.ldVkC0&%OM5TplQ.nu
j`t%0TE$3p:le(\2KBg\4EIPi(=083/Ln-[Q:f&e.m4nL0dJ#_4]AoY<9dih.H_0P-c!1*5q8
j1nHheOcQp6-nVY[C\(+8,@`5rX(fM3Y;6(Ofe4E)1mL@IQ+pfTSD!il41D%%$EUNR?7`',)
<`66q5nQfki>8bhP\((,DIA_Ba#g5k1S&$]AScPf850_3teWGl,OUFkkDSjQ5YN-pB4Fh#CJ=
<81\jr9F"%Wb/sME;^R;e5GHdGDT03pGbl:5^uAR;N(4F_,AaTh'mq0%Fd(C?fRdd$P[q6O(
QF9`csD;QV+_1q44.<o(P#/bh,aXqPll'Efh]A.S`Aki)+@g0[/h\$God\FIc1fT[<3C/Br#D
XL/0#-BTun0.FrEfXH=V(R:!Fc8.Jh22Egs`Z,7m*?>MeT/^\Y.HSG)`f@k6NCZbWUTB6Z#g
0L4Q72[#7j[1onJn0"gdIZE$m(2A5H5Nfeg/9pV#;?b2QIE-#0j\Fl'-GcYpC5+[5RN=?Orp
_9uESB4J0]A?rp^]ABi-jdSm[;K%-d*BW5G91_??;k2h00FBHY#14>"4[\l>ccLSf`g/-ccQRD
fiSPi:NoAWGsN!$%SE8<TRs@]Am[p^]AiCTAm/,$TiDZ#_Cj!ALpb.gI#cqhTSBu;+1Zdo+5Pt
P?.eFb$f^bM;.fD``\"U>->BRJM6Q#Zp)DPt>]Aou^Sp\ac+N0::O9Cs7k&J`B&oVqIo]A]ApH^
OC,kSFhZ`S)T6*,4Q=iqVF",ZKBuVL>?\R^4ipb/r<kIeR,lOSAq#e;h]A1VDj*HaI7QJMa?c
9/ipZg1-Z/"pZJpXf:`+8k)L+oi$a%^njHcP"Zq``ASOc0h@\K1qnc2=TEd#:(k+7D.YY;Y>
3JYB=MNXA2U]A$IIOrq[>4H>D^`#Q0%QJ^o8@>A`>,5o^m.(F"i:+")<1SK^_-3h$74N,K3Mp
CiYjTJP2pSVI"cYtmBqrM9KZHb]A*b+-\.=K(]ASEs7Mn3-9V;Q8@D<3m/PMP'*%^oI]A>0k59$
#T_#CGh:XSq:IJ5toD>Mr+neG^7Z6a%l0J>bUE%b]A`C]AZ[>c24-cnO>9_0bRD>0nJT-51iaC
m/#'OYB#GQcA^IG(Hp,'Sa(q<OIMAl^\p.7rKiUQjTu_8:`*W(_o8ZK(A_,VMdE*RR/0sO[t
fZ+ZGJh!nNi-:"*"eePp17eR(8-Q_YF-CrgD%_a"t`M+E^9<4N68``/dKlPtLagIFH7)#<.E
1<V02+`u?L13]Ab&BWZM+n'dUkPl._\2fM3USs0IjDb$^P.CF+nH(?9&/TlhToDO$+Nb'ZQ.2
@5H_f'e2Oi"E-dCg6.kB[Q+;Wa"gujeZr<g-Z*8C=U+k:n"Tak*VP(0nCUr;6J1&U'"!`%*L
?J.$+<)kB-:sm@t.L++r_,\i_V!KT&e[Bb0f^q3!)9LB/;E:Y[bNL@]AG8l7d;@#Q'nnW4=e7
h:O1>,@r94WO%'A]A:%cO>(s1OMO#u2XWZ[b.L,p`KklQ<pOj6QHOYr'X.3JIFMYm$knfPRc6
V:OQJG4h"I<#]AB:q6WENm#LDa3lcp85?l4AL_gSu)2J("<p%VOg,A54OQJBA,^7d_&[("?$.
0%dc*=;8OA%i(Ct06Wj*AWI';qgZQ#\+K]A_`%o)7#Mm/*2ee[dD]A4!');G/en27V]AQ'%>R7P
P.3r/k^uu@EpWd0'&*icU4i'D3/*XUTr5]AI'RFtp[k53m#lN`*(FHf5?ZbtHa;jNg:pDDLs'
!!:hUO*kUW*0o;>!-9?M+'A@tYbe,H33TM%*gkoJj`TU-(;rdm&kK3GU-%U1g<fKn\9/TaqW
DUp9'>6(=o*bf!WmcHQ#a(G#p\sX<]AC+nje$@9IQeSqs6pk;"im!nF*[Y6_JSB73+E-NG*p)
=jEkpG+LZ7"I%X#0`;=6NgeqW7K#?1Ih6+PRKf8(Dp+CDFQqNS]A!=OJ1rd'e-C_$,u&t\dUO
Bbq`h&[W57s-$*PB:DVCnru"E6BgrUSP\`oANm+KHgs\4=F[,ZN(-B':;aN(n*c;su[]AR,Xa
<r,oo%42L\BJgC$:$XP>A8Z^e<GDT,$\oi#3c'te;N]A`L5-u\j]A.;X5`;k.6]AFU72GH;H]Ab_
G*-W&s_J>"($7h?N!J^86a/IMQ5reK8S-J@C,@F%N3s-DSmE7fb0LX'4%r9>?!aCA@59LI<A
n';WYl^pL,2dg\gHM2']AGf[%K-O3jk6'WDr\N@n(#md9-FqqFg8;p4H_^'[%;@ZCamr`.sC*
C:->l'f2/fk@uAsp64S.o'=mj7!E^*\(n&igAB,X&Gf]A)>8+EdGB#,5eD*F:\&,9Z_.^G`!7
.:,!e+%9ft;0d<_W.c'Y\2q%'dA9A\4Vfj<UC$1/ib/gB.(/Jq0&hlQs[QsIu]Ab^p/Aqe&eJ
Bta#pm+I(&"s37E(FpCT)g_=g`0U4UJYZoB1EP5(e6,;4`--)f1Vm5KC0a3/ZE07_>[1nj3i
BT5\K3)A/Iqtr3EaLF&2P-hf^?=k:_2a0+Ahmnt.-B>N!,U0'L3[0/C%fh=2u?F/s7cU<;bn
)h6Rj"-\M*M!`u$[r^PKNf"#m6LaV2jdn%j(,D==&E/0/k"EcKA-e_4CZ(UcrgCD\(pl0d**
n<XXV74,A^AMPUuB,Z?K6nJNRaViA>)B=j?km\h0XuOc&358QjW.m\bD</N`*@qLBR..<7[j
/-\ZMVBaL;nEDX.F;GP4f?q6r0VDAYb[khReJD;GS3#OCJPK:j;[j`r3]A<j,`JiV)ff=]A;fc
eq&i0KN>.ZmBMX,uJ;^nVL,JUB%^J/AGM=M^W*>=-SuX2OCke55)OtI!`mt/mck%*ai+l?2q
1RqA%!nXkC_q&nEf?#\b=AdpF<npS7'aFmqjn_is2MlCX5>AB3%llhTX/!Ig+/m&3e*:c*VL
=!ppk*9K4a2s[Q3J]AX@`N1usS^Y&paYj\mOSn,,j$"/Ou,K$[4j.3dnLnV\JZ#6Dj%[s1V"G
%E'^Xn#P_@hnW"?^aD#VDYs_Bn3'6Ne!#U/NV.BP63WS3O,a\lX;d?c8=0#b#hsmEBUg1aa%
NrbQcj!4G[Q1^R[X-,Q^,)4R1C)#5L?#P#f8Ym\153O#lJ.d\.qkmi&M%4/?WlZVUBg"!140
ZDrWjrS&gd(";CrX%E[k3S!C+roTe;+"U5*YHsnQ?<lP(rQ8Z5$Sa4fr/ZI%qC5ra)VHT$g4
d"@fTbJj,PrU`aO[O1J@5l,k]AEA<Y4KM5e^hMrC8CP@<9Jbp^7&o8&;D#LW0\1jNVpL/^@(0
bbM7E[_cPQDI<n%,7cU2=*\]A]AYW&bYTJS=RX*Q&5E8(ZIOLgm1D"mRF20R?Jp_^Xm1enG5Up
Y[bl8)3T*0*=PhWWiO(P)-oHKHm*P;MF3'Ztd-h=L'""TmeC?,-<2/'``D`9OTKq-bY&cSH/
-]ATL^+enfVk9&KVTCF<)U(d.6X6uo+.q!T_tU&$&SF\Q^)SMi2E^O1[CG+'"s(L+&jSs+4d,
Gf?;AbaWMa<U@o-an![0bT_)Ilf93.h%`<$MC-3%S\m&'qfr2E*=0M7>i1/Md*h;h$@-t2Q9
AJg452ckF\;[Yqm+n]A8Q'eEUPU0DcXC@Y]Ag]AQTUAs8!OFXMU`\=7aPlR!R4jG(oqknYG10\M
p?Emi64>EHBVdLBQ:]As!A]AtJGbn%YQADI#WF^<cr&8D+!ZK.WpKa-:;nOY,$9k,@Xc9R!\02
&=O3rjk2FL_<+H]Al-OHC`%H?NgXnWqf,HDd1B4#8jjd+SN$B;/fO>Ur8k#V#f/O>\UdVc?t+
V#)G%:@:e)XkQsVK<g(klFK?l642h8"-lL4>DSSWg#N9CS"V?SXU`U'I#FC5\%i8K<cpiX1G
;ejB-mjZ;JFC4k$L/%0lTXm+_]AL_/KOBk=EE&qaIZNfrTIbQ,=*<Y!DoFb4?^;*Eo`hJ1ZC/
)U<>B?+f4fDER<"O_noN(TZ11uPG-R+qojr1*Rn^^SkXaBT3IR'[H&Cg]AI`jg.=_q'3"8b^J
fRU^S;O=,@P>tN:hjHKaN&dDtN5#UO".PqYp+0i3%2C7k_8l_a1j['G*`&&.)26,<*7k7-ii
:>9_a@8Hnr@abGfc[I(@*6U#iQ*82-sm!S[m#P-*^M0ac"BWFFD#<V2K-@cdsS7f!fGQ8KqI
Vc"O'=jXEO'PEh+V+Pk*^FaG^1oWA_aGT+4T)80j43RcSZpopf?>>]AGU*d+><pHXkT$]AoeKY
koSQTq,lNZ=&"7%4A\[aqCqhprRk0@d2r2VL)\CX8f**'-YItk6`a,[M.rtJMI%e\i8kgW=\
i=2,Qp8@?E2%KFSg9e4>8rpZO-".@?i]A.dllk:MrQTh4)sK'7+Ca]AG_Y?"4E>3,s6[lVdg1A
9-.%4N;r#nNg(L[3`+HI"[Li@p5K=rmi0sQqmU8R'P3rD9Bkc[bC=p"pOF1f.R3FR+cCHMRN
35?[Uc[dru(hqYG\TS3&fLMf>!'W?8#9!k]A'rBLQ94:K9TAMboMOnrs6HuVr\'H%B!dpW2)k
#WTm6Q/Qpf9/Y;5C<nuWo6;<5.3.3ieq4=m%C4mg!QHQ2E3Pp;HS<SL'3hGunLJtePG[o6KY
m`,>>3EO;\8pRs:bsc0R3\0MAI-=ONGJL!kpPd0p;`Rt$Peugac_2g>RPWVY2M;"g6YT(ir@
e,6rs>f)i2rX<*Q4G%LqWt^O)^pjX8tH'7qsr(-d8t1tI:I3^AjXp1fq]Ahg(mmAT@Li_42Na
S<Mc6jXt[3a[OO'D@TH>U9F.taX+e_rQW8&2aV&od4fOmrp$d:qt"SJ:(Hq&l[5R1chMD%R'
P^0eV`$E+F_J0YeT9M_^V+Lmn0KVAM4"!`,')1%kbp%Hc2G[#5WiIm_99Vs2&7":\J_m$':2
5gDh+HY(7S4MZ"'B%Y-WP:B'<)O=Dg+Y!ef',(5ImBen:T'h+(Zr?q*nn>`C"ZYRL6;YKeLk
F_o>r]AeC".1:X[Vi4"B9/Wj6R@r^ak:XI?F$8()hcAg9>YsZq,'lF.R"foO[78'5KT,qbH%$
CA@`X-uY^=Vg[VjHdNRO]A4AE9)'aXIup\4qB(`.T?Fl`l`r&?sUkj3Fs_'<T1R4i6`lqhU%d
F'=]AD:MuJ:_G>_!og"K$YkbkS.rO*JQOC..L4U2l%b9-fer\$\^8A.V0LAPM$Y8KPk]AW;?<"
]AW6"Z.'g%>n7i5nq=7.6B0d[@Ao:p"\.Z=&W]A*_6c^drk#`:RkbK"54@4b.=_s)I_\'_-:p/
X7;f>arZnX7ie+$E[m#"+:V@Nf=oR^@O8^a9#D+^?jT16]A7JOO3Ag0?.HY?o-OH#V(Lhm_pD
dT(DXCi?O_KJ[+<N'\bm:Tpb*!m4+fZ4dj2^i8SckLV1kXmqe'^-LgG:J(gdOaa!DSeO\a/(
=-/PnON4jFL#nme1M-Q4)D4O234i8uOZB*Duc??("Kd5hS'%LiVVcIm<SOt:d7_/J$mEg(j6
DYT0#Y[X>20PT'uYnW!^L($d(_W@O5/baAl2kkWUY(#4m]A3u0AKn2]A"h"E]AnF!Um,c780Y!'
96C%"0^B7)b"sO+*u#[D6AX?icA_j%CScekJg]A1BoP2k(SH=[T7i)5C3oT4n>jFS3JP.B89'
uo*rck?4(gh'e`oL0IC*+"GDK%6H""`Daj%$ms9%j!KUfb#1u%ROtnhU6aP$>!#Q@iS:l[Mc
1khm2O(5]AFW`U6!>C[`LP]ALQ3No"u7JG97AkT^=Ln+1o#,9?9[>:@Ep<YjrIggIAkp,C\r)M
m/!88Oi;-.X44VQekFm^]A\,r:RM*p<r2<4[K+g?+4Y"4J3F!.mKM>mR(lUnu(%1]A$X7`+KBn
,h]AG&9\NK126`a<1!A?8fs+,\#8MZd>&q>sp.a?<;9M\a+1OINeSV8;[d'7jV-6[Ci1.#o!]A
IC2a;X=hlQZ9cYQNlsC)iYg)YQrn`+5OP4MdGK`p%&t'f9o9%Dc$5orm1>k;cr[ai>?$G\ZL
>bLmo;/HCB<RP+"uK,/>D.T6d?0G2?98&PH!k2nU&362!N?\mV>G/8i59\qpq+4/NWI"1\kO
ja\%X[E<GTso_pVZu\j='!cLDiOU(;FidA&DS5kO\@XkC,Mf$(i.%?C:WD?d6jN9h<aW&idV
dVlFFm^P^Wt2j=pB+H4t;7W&Lf?Yr46<8MX<p5?G@&D4(qD3H3_9?q-!qWZ]An=p(?X5kF$bS
Ph+7IX0&M%&%^6T$JX&&F#lj0C@62KVmql.2A9Kt(j1BtlC`X^e/9H]Ae^fCp-,SKc7gI8o<0
Rks[LNh\10qBh@4ep>RNkID!(hU_gd)gr%^cbQN[>c/5;I',=57u,[FA;tlRX%.>Vk1D=@EU
;2*5645]Ar7F-?@sk)nm[MNFL\(TJm'Diu^,q#Zg7h(.#O.["q(]A4`a[7oT[&tlZ>>W)M+0m%
")(^MX)5qIjj.kG9K9P&nt_489`_s*I)8l5I0:5h6WY$j;r<I@pP/Zi?J6mA$n-6Z`N!na>P
"ujK#,WK^OS34\@@Z[>$U-.=_.kAR3Q&:?^9%l32rP0(DD.Bq3^tG*b?5nD@dd21<[+I[n^L
3`,PbYEmHb4^3*%@Z_=aEKE9%.BH^Woj]A.j9193ei-FMRZ<I(#"+/,T^GOt#B]ApFZr.>q>S0
E2X!%@+0-T>;>4KCjYY-!nr7C\BtB>-G&@:NrVJ*ERY5#i^kn$7%6CZqQU"=!g,,URe:,G1=
OM"``74CQ[i?4,A`5mD.L'B(d;eqZp%_]AB^)YnhZ^a`:c&hkDRVR%+@^?W(A?(\DqFLc&9i@
pl[qhNpYIo6-Npg)b8W=L^h.=MH4Y]AZ]AL:O1Be>W+Z%66`S^$MERq!]AI*YRp3NN$*NrKUBF$
E;U9$=`Gt]A3ZjlkM7MsKX9:9]A=R57-3GrW<(DE2_1T%M>j(V9=U!^+h@i's+-P>0UkKX53C-
fTs`_DJpE&kGJ<A-LH&C0&Rkge?%[!dD;%='!p]A3FnUr0^-9VQFZ`T<O]AcT5]Anb&N2&ZtISY
f'7(`0AV\uX2u3!>k!ZXD5AYFj(d(5I'h`0.Wd2=DM/>]A/#[_dQINYEpsOP4t>f@[7gAb_38
Ce3mJ+e\(/W()uO,l6bkK*F_$tjNB29&Q,:.qcW!LbaI>*7<HZr0F.h#=VWD"i?@$O^;3G9r
nN.>$#qU(WeA#sW=qtZkBMGD`1jHO<[%HMR1IUB1Bu0n8l/M(h'1UNgRttbUJ14?^P8ir"*^
P>Q@Qm/4Hic9(YngCfQqAt>9[<Pdtfh1erC;7:e?U',i2'P%;HH3mLc7dJHB[<4cMq_8JhA:
^?B)WS'']AA-E_15QjD9Yk`sFEhr4AEFj"Pb79"":k<r.9e.ZJ)g9Ne<]A\^i%IKe-JAkai\)=
![/Vqc5H5.AuZHN/%sbNWL\/uHlk0E'0F<m!kaR#\7Xe1+;:+?bZ6\blr4F_&HgpG>X#p-I8
-&?k\(>7]AHWi15#ndW-3#$XNj)o'BJ6N:MInEi.u8CFt_icE8'Hc8E0*;b$QUVP]A6B^YFfN-
982kgj/E'X"]AN3Z#IheWlQXMmRS_2YIT9sMg)[a;i;#(2V^IfcpSi#)9hrTqh&mAZ,M:H':b
c-`%fL$frMSJ1/R66D!#LOP>"]A7+`YiMA6u*kf@L.=ClOkjMBub6YH61JC;l<cB4Xh)68;KZ
RG%q)^Uk*285F6%bKdCY)T!\IMC/h2^f-JF7hH$KJ9MpE!.qCe2BXT1ejmck!Z*AcRd"`(lo
NRbnfesnU@%V9PH@d)r(3R`n@4Ee:#D:9Q:\WU$1'@DR8EoGFnI="nWAC]AGEcDeObM3=0+<u
tmC0H$DHJZ!7qm4O2g+\Kb?f;WP+M(jdR`uUS$@;Q8ORa_ZgPJ8+r3C]AX9slL#Fm@>]A;IO)/
*:b4?Sq<P/>D!%CZm<C#hV<ZpcY#r6Z:To8kGG./GGZ3[XO'OX"rNnl"-NK9JYMW)JYWIT_6
\qnppEtSVb'!G:CMi;V7]A+M(d<cP73_`dtLBMV7Auh/Ks+1IC*D..@8\nAO=\Gk3gXI[4=SP
)':roF38H"+`1.kLhr0GBn?-bXuLccilo!H9!ZXZUmK'<VjkM$]A#*C[rXmnd+n<[n1Bd9!4#
1K94d?&?$9)!e"n;sW(B@(l1aWP("XW*W(8gA(/tZ9INBK))W+fbnX]A#m#P@:3Z%qGQ%[5m9
7_"dJ"di`$=.:Te"RCRWYi,@b(KP^=&Foa,eRpPOB,O[.s$)PBcKP-ck$)??!X$1g8VmGhYi
?nd/EoM1O.k6HfKOE!>-]A(loVjgDWFWG$u-1uhgBo$E*k<BUQbWfIlZ8h[n5B98f4ir]AK/R$
,sCi(W8=#,lsL']A)F/9EKJi:'<@,s)m2^UQ$[A\m0:'pF+3@G';:6mb6JCV"1qJU+sgHR$t_
_lV"H)g6jCI%uuR6MAX:40d]A\$m>[tg/mIQ19ef-;LYh2I,PZ!O?.W-7VZ!jO#aEZR;p+smU
:th'eY.1B:]AsOD^:uLJmpBdN`WnRg7`XZDVT&JSnaV%ZNI(9Ylcn=;Vrq^G!m/i't-h70BH5
0gcI>Z]A#`hHb3(+]A2Xm$0V9T71SMedlZsWiu?33K]AEgS>n%*LP[;NjZ2k^(n.&)+UXJ$SX`g
Bl$#'(^=.@_Fs+.E4C5W:/>h48kjt8UZG`3`n-R\ED@F@o_M@nY9D@Ph1k5%$s45&hWE\E=a
pg?G]A*4r0/bgl:>(?[,Pab!XB,\c%PFQnnF71rJTCOP.Mshg&]ANKp8&#i'hlMtoaQ=`oF.eP
%+t#!32B1Mllc>a)+279c,eXZ5;ucK*d!i0\-oQ[cD>8,*[Ydj,kpn=,fQS-)c#`12#L-)a?
P8M;Q\n8/TCIk<2a.V"D9R3`S^tJ\bV\8Sk6A8TU(V<%qM<2ke9Y[P8WlUCND*ba9/:RD7$1
_I_>e-jR)"M6fk(DOIVM:B3dimWKI=E%QX0=9>4Yeqm+)_W(XBY-.?r$)r=Yn_ge1"&+/>94
:Vje4q/Rd3.D6+lQC^:[=\7k\a(!n/RSGMR+n\.Tn[m5Up!oDb`9]ALSUagA]AQ;<9K6(tRfK[
?hjk0D3Amkp^:M>\&X3TKWSTX]A\!il;`ZB0+q2pUbKR]AODnERtO9j&\*t(c3K]A\G_uYKhq;"
.^g5pXRUFCbL*7[)\SL9JZ6DVou*FOO(XUd+&*N3L/ohV<DMG_qV-]AuL%=O4Yf2[o95jc\/>
k$S/k[u9R1A9Hebu%I5&iGkffZ9RJ]AG$ls4-e%c2"u<6._I/j?5.n0!_Uo1Ij%j?*V<fi/>#
7KHZ<[cqCjN7c(!NpjH57^\=L=H3ZV(6%d\BA"g]AH)BsQ?G[ke@3L&A&.F%b0kr'_[7k*+H!
l#4TNa?t#]A+d3GX88n?]A:H?Inl3S.UhhA%fB++d?M((4g_*@r=.HMqi%1D"+i^HW4\QH/8FD
(.S<;+UARNaY0;(.]Ae$q_6KQJRb69=)\@-k5%"u2/RF;u@V^Ze8ZYDu'A/'`%.<eF9+Ia^3K
k<AjFR@VE=<EQ[0^eJi)^YHL![Q74r$+#BWs6nO(e,qG(:a9iTJ?ETC75D**;;-]A'QK'DV7V
[n#cO:.\XPY<_oL\8r$jU(UTsJ>q=Y<A.V`td[7F4"i]A?G#VBn4MRT4^G9br-`J93)R%oe;E
af%\G\9LP4=Sa'J?#Xq4K]A;h#:?q.V9H"cT!hT\tL7E=?J*02.3]AEZZCMoMjSp,Hj@@^&?Gh
/W9gVr1a@ZhP;64&a4eQ?R\?9rNtkPOCBFd_33-=/W37W2m)8rh:k!j'e;G10$"6GAD:4QYH
tP=`et<m)Hf:ou]AaQD5+0A3mp?<NE8hgi;_\FrP,MDeLFn1^P$[&.(PY@VcT%0V6icl^f3$d
r<'5=X)AI']A\u8Iq5J[S"!TIKil)7JM^ImlO,U`T,+j/KIT9`=s5S761O5>s3'9]Aeo[A.oU!
9I3EPNqSW&f(jh-r(Wh(2NOX0VCe?-l>fA<ApO!S[Q3$-(+@$C/1$WUn_"i82`6)=EB%?.+R
e[NFMBmtM%<4<dcLJCQEDQ_P<&!iuYd3h=@f6_C/EJl,c>fU>i@$34Y7hrcK.nk%,o4`j(5.
&1OG(,EmaK=VcJOj]AX.]A8lc*M!j4Dj+e?u!nsUa)K]A5JY7::U.07Ga-:Op9+Iihl+@/M,i23
XaBW&CMbj?g:A)EO7IoHfAq'^#O>KUMBV#/BI33/hKq9=Q.:NI$\_UX@Xo.%^fYi09i9+(_\
k)bLZKt<0E/L3!Aff+AhcElBp#$hhf1%AIb35n59]AMKN6=U8g(bH%ItPmc_m<)OcnoR?_rI8
a9p).0-i>qY5r\VC8d,!=3lEJI+LkT2Gi^0!=:>CW(2,lobgX3:pNknal"g`_$dSBb[=Nu<T
^=nL^OAH('H-5sVZJj;8p*XsX*^+;?0.JO5sJs&OQ>1nW3d]AQ<oBC,#7r&0eS-3'E',"IVEH
(Ks*E)UiQ,oSFlr4ANs-T_A2EHp55jCO[MljC7iS]A7qH60'l)ST;&+eI*S!!F7gLhNG=F,Pb
4KBQ#r^JG1qTg]A)Y!WDEa5HVWJ4e*qf9Y>t@l>LK,5B=5J6]A=BL**nF1YRi?KeEmi?WVacK_
NcDW<d=!C]A[g$lU[_A^.h#8bY-CMh^m&t*bI?Dl(jE,6/gY?mKjbXnGhNSpJ^XtE8^[Dk0XV
^*/A51G;bAmCPQ`fJLRDSOUk8D&(/rVU@;bl>-LMnsS`<I>@$Wf8UAl&L(7#Nj94`WJ+i<?m
coQYj:O`P,LFk/5"[4k[9HP!^6FS8XDH=qeE;tNmgQ02$;nDRO%WC48/)4S?$qDOW6krHKE:
kBA(o4VERD9h6>e=MPu!R9n;cdI@npX1aDe)M$8$(N-(#GmS'E$<SMO03i$r"aabJU+Teo&4
7Eb3.F(/R+YX85@7R-deYI,)]A-m<:Ji.G%WrK9&kTQJ"$f_"7\sa+k2AlPYo'N\m'cZ3a["k
/RoXH(kj>k$4o:KY"l?Up&=RinF_G'5IA3WE6/)LAK]AFGLla<c_V:k%RfS&cP[`4LKjB$a+h
RO&?!O8aPe-t)L5:-qMIkrV*eEV=-)*=$bm?V!E3qYO+4.&#jIhgmXk14(%rGQ_*[Vn#\&iH
eY3$+;_*u(FFoCb,4Q0tKd,V1@O1Hf.`Z(ZBU>'QpP-b9,g\1UP&1:0/dsE/ODqfC'-5u%!'
OPkC'MHF\qM#g^>=4W%hT/g.qqKK&6/EHNiqW(.>PoWsc"YWPB-_.d)Vfn5-ukB]AH,MVS9X1
sO5InV9L!)=.OP?jamDIYHJ&0SqLICQnN03iCW<YB7Fpae60eRa1'YFe*Y2bp_%?8'`on4VT
X>Dask5?u>(/OMn03p'VRE6!()m<'N$\gk>qg8!9+3F8sF=4KA+3Dl<(MuLM`/]AGirLC6@PA
bq_hbl8bk9H`[.gn#mLq;YKQO2C6\M"'TX/8_K'DMp(.h1[&f=/7#FnBo5E)HC-GT6A&FHIX
#5<6I"8Ibo!Pg,"sqAL!8Ls%1"q<R+.d).@K/10Y.9(UUA4LhfL]AR880"U[M_00?=j+LsfOM
m]AC.DA1_K['>YMc(S$ZnMlaq]AnL/20jnJsKOg#R93M<$VfHWdGY>,hnr6XpVEc"%=r!g^g-i
YjB??Z.8[$Xop&Ue".&^k`>q$Dfs2:t01hp?E/8Iu+StBj<^3dgrFgE-lo6>%<=)M5["7[%_
D5LT=(X01>B]Aah]AZi#N*K0I6a%U5(U@_TG]Am,[N6F=E!`VX*dHm:JMH(;Xo.2sZ6-,gA&gOn
+`Ykg%3T/pRanC`_si_Nu+qO<mcCB7tV7-&rKLc]ApCEai^NQq:71`VCVb/$<rpJ?Sf*/ha^]A
F`S8k*;JCs`Xe"#$H3GVeEiT-)4[;rV8,e<8K]AdLn<*.RMs65K#)U7EY_e;;4Gej!@GuHiZ*
9fC0P-0S*&,Z%>=Z8f.2jjqIO!MUU)g,Y;MR;P!A?d<_q;&pS8qd2.ZX>?#/c"LdTP6?mb(d
SeAY@]AKC(1(IS@8Dr\b3$&jU%V(V[LX7_PG.(A<Zh$(\e`"Z9,J6@/&)"%AeXH^I8RFB=rZe
-;/?F2:OQb3q`hVQ6,$lo'TRKS*.ckNseKKeA;mSHr_HgbKX$d5#9@<eR(7:Wu#Rm*peh&K#
.)`eabK$W&3V-YZO>E2orrkmnME[9A#@be+48iLG_IO)?6%-XE#!C1YMI&M]A^259H?O>`o(-
*/67o"M")C:L4Y1LTq`6A7j:(FcH5k1DBbUYX8N<V'M4nC='*[qVkr*elKq.?5;/HNjJDXK=
>fb3(IWs0hYadKOY9GFLJ5AVB(MfFrN(op;G-jbV]A]A-umGop$+Og\j\qS8SEbW]A\Vo59keu/
=!R*[MEbI2os`"8b\Znq\nW3iA#Y;TMBMXdp'/2rWmX[+GuWIn@+@14\qXM['O"7,m3jB+Eg
:*AFZ!#:PMP*5@?D=<5A^#sld&N1`XGih8+cC9'*TZ0q>Q\o@%JLeV0-RVTs5;'$e(AYa9?i
O#k:<9jF)31q'O-tW\Z;\2Hrfi"qI8Km`[P&T]AZ("o3l?#3SZl;+l53t.QW;Cl?C27LWlhkt
:(BC<N)D&X8JLhV_%L[AhY@WE8]AKj,*jP9c:!tqC4Wp(J.mLdHh9BBJqKB\>9^sH?*Z_nqXZ
gi`TkpOcHakXKbI[[HpUZroFF%Q@=`PL"#ldmcp_gQi1h]AA"k[62a#^BqM/9$MeSqN-PS)R"
2N`7WQ;+r;/<]A`6-T#97T/O!)OENHT.9L@'E=foa`fKA/T^AYP+%CY?AY+Wh@9@`<!^g6gG-
&P-3bs0e<dbSCO&5tfoQE5p8Ae"5P`)<5]AnO)Y*nn/o%`Q\F)D`8n1Vk-_L?2IgW-fF_"%._
eZh),pP@UZVtn1%.UjW5\!%oY-[)4S3sd.ij2:+[X>(AY>%<,Q]A^/1gf^FRpI.:`+G&:r'EI
`NEnil0#kL'OsGGBGh[08%;\j'qOrs%/^%pprFo[DT&Qu"rV,s7*))slQ[UWJrm-G9XMZkRc
5'%C)1</A@>cT+@0qAHAWI\rHo+A58(3?WiS@55m/APn&8qp_9^/^$V*P:Fbmue^iD)G5$.a
YEIBSCUdB%g3_+V65T>Oa--.bKp3&1"<j2QJBD+>&>2qV[PW`X!j!nm."fqWi;]A\q'?S2+"j
qR@c2SUub*n_qs;(t,k6@p#^,dK&;U-!]AV'clt)Mg29M1SZIHq9tb0I_;(W;=2@:M"GW!j&O
fem44^J"'>M^*l2f<SK![esEX?"kP/]AMHJ<(N^%LQlZ9?,>)!)/9YOG62_U;tt]A!W%$A!M)!
GNG1\nr:9d&j*)#ms4\3_nLN("qrsTt^/@i?;7'qo1RmF*As3dgb#(fNPk*7>D$3Bcc3H_9C
JeGQX*!\qT+J[>40%UMn:]AA"0'1BV037GBU(>teHm"2PDuKEolE7F#&),b`i2%E]AMhH;]A,UD
`L9>g!\loRtL")6C/>,`%:a3go%cQbou$('B<,ufhJ'B!cU2th,&>r4o6+(n/8GU08ANZ$<4
MIh99k[P&3dU'AHQfi<h_N,O0F-*hE98BPgmRtP+RIf_]A;U#>,XQ5/VVGYBo1op12oU4tj\r
@WYe&TA"q.b/+FF]AA4EKfo5194f$Np$i\N45DH;ps5:`7^ISJ*gKVF;*i*mc>^a2GIkoh=W*
a&R2P8e#!c:jrf4TOsR!G@(0RDQca!-(=j$%$Y+aLFmFSkBE1%OU'!<F!]A<#H*/-AR%$kPSG
_o$$(:Is.fWh<6/B^AF#?_u22U^s5/8ShBOSN@TM!f<UM^-KjpO2N%50s,=n(8,nP2"8OM)r
,9]A!gMQ+gmMZ`LggX]AP2aj,t4P-2+kt69bN%!eZ"kR>^3Oh,K!!!D8)!UWZ[^jIqKscDJg(!
kb:jtkEd,TE!/YiDc^B2Q?WOU6l^PcIPk58PMl(--+;b/HgnK*_$e5N`9R2TC_jT-`%US?p?
[W$PZsae4!B%#S8t)I2bH)N=rbA?I['hM-++a,o/E.:Fipm`]A`0I+`s[9i+^:&R*\rBkK_Q1
>LUUEBDc!'5)/oK:XrOb"B&%ksT1W_U#LnY8]ATO2Z$"RP)T1[3O8HMNLc:3.>%R>W$SbERQZ
[V599>Or4/%TDPdD0t(_rKCfA+2Jc!q+A)f)%($V<3tWBq.@lE_Um43qCij,FohJl:Li>#B;
5(65.o(^D;`eCe]A@pdt`TZYP<J1K[;eonLnuM9^.H>a0mmM`C]A1t'_$.#h]Amn%Xg"]Ap;,dI+
!8gCLgT``+&:]AImku1[;RX*Cr#Z'm`<\.\:8-Y)T6,ha3`=cdbQuM&'."'FK@s8LRWkDY<&_
e[Od.t?V6mE.B.c!SnpHu4#46uI5,KBub=,7/kbN^FnMmY*MmD5m7P.:H[ak0($Ur5B>mr9b
"mU3a++H;c.0h<+=(>7B)(-bq7D5:#_^\s_a3eQ>eUK$!>5N<A-kkXMI;BF[\82_8U#]A0?JR
8$5oRhXr/Z.L`KY(Rc.P.bS:gt1'UQ,,TJiRF(`oa`lo/mF5*gL#s&:pH,Dk>XG7Q'&MlGB<
s[FkJX@5X\gJ:eq1!nLqsaOplFu>&dZ9A^G3b5*82=3+XYj-]A5-*?Pf!#P56b%PsN4'Ph2U$
doP?r9-gTiX:)rEp2.3AIF0l$Z"V64A,DK7h8!4S&ON_=BLm*u_]A#/p!"E"nAN!=*o\J6'Rm
%KQ2fC9`I\V3nYp^F'H7.?<P%:%"c5h1K5@=:eoMog^p@<^1ps&6)%C\N#>SEZRkSI4TpSnh
9M>l(&BDG4_=X%%boF/3BnKcu'AXh%[YTJAG@>`;n4;aPQi3[B8;HPluOhR$A,D]AUtrWbYeC
l0lR5HgW<YdSfl^/0`Ir8qD7crDDen3:lUdhfCd>#+)*g:)]AAk:o0a=;pVN[lKTJ?IT0A<pu
[WRoa'bhQY39q,-*@481kUpnK\$?FRRX?M>]AXnXGSs1e(h]A8%#BSNd/:(D8(>?k?u[e8F.`F
44L.t$g'\9@#LeM<TBZ`OH&9;Q@,Os=3Qn5/93>h@V$$,IJ"oPh1)%\aaDk(:Zt^(;Ba:\4j
2ZXOT*D%<ombm:R"MTZ%IFRZ7B<Oc\)`lai578P8oWh(QTFWM0<9D/'h6[l[M.!G+)CNE)LE
D-/O%I7I)aV:DS\Nc/TlEltjK5l'QYbcD^a.Ve+MMoWtPA[-!._gBm>p!:V]Au\<Y(`Nq:Y9-
WG*a`]ADCL_mGI>m)f&E"P**8@fH`BOufmp00YH_>r9t*>*/3&d6QY3MY9@C2<$Pp/LbNTUF6
g'QHc2tb+EUW<p3PQR,RC*76,1#]A?1]Al/8B0Z[;Ff-,Wk]AN@pird-Fm=D\oM_]Ag"]AI=WF<RX
CRm>g`a5+A+&BmL9b1YO\OKqB:aruK+A[s2%@_5Q.r.>e>Fs[m'o_%to.4q2Y(T1um2m#NOC
pp8N2L80XtS]AVD-U"K7A<2'0JP[?pg^58*_/An.1^cqZ@mgtl<3kT'd@D&VnQle_NPX,=(Y]A
@^q;K;XH*sR]A\8&]AVhqJZZdSs'TtgUCZdi#,ED;3f]A5&N0FOW+e:h[AQeg^L:"ubhQ"iK@3@
GPo]Al8#+rJ7?1>jL1.!&7'r73]AlQ:BG&j\^XG#Z:X?@KKq)9]AQ6V:VZ?^cAN&XX@CP7&04j-
X:^?@G7Z,9B9Hp8:\AL__f,+(5:Nha,=+8b%k7+[[Q0K=+O<7Z+ZZ3<b7^i^u>\\)MABe7X<
KGFMaK+P'P4ft=\eJ9+J[gD_YcLM\$*t0Yg3n9!n$g8#):bBl4%5d^Xnc&k2fOEWL.@3^b1Q
h%27,-NU$#VaFBDN(06J)o(;c]AD0VV/ZA#j29W%TX29XO:pf7!.bPeKp&"5\)!CKUCBi5j*W
i%]ABAIML"DSOH;*DWsLY>X:&;g)R+GfA1[d)@aV(m,1ef?Y92P5JGY'n7&_qZ&HU4RN]Ak_\j
;ALoP7DdRetkLS6GBIHl_e!Ko%FGO@o=W3bh"aK>+\KX$fKHVKmFe"6(B`cJ80"+s#:2^J<K
*d-femj&u-B:72pnu!5YMXBV5a?7dfB.J;8HHB*u25J-BfSWH8)NWYsi:q)9GW:qT)CG'#po
b>$!qDSR4`+@aemjKZ[O?:^Ck^KU3$nuq"0bIa.hqNqUaRP>'mBS?3+Ko5t*L-jt4.e%hi%>
%P"5Ycr:B6&3)l>iQ?%8g6f]A6rE2$"%d.?)hd"(7KAs>oe(U'$eA\rscui(lT>nZHpj,=FtL
DWAn.Vn3uq.WfZH.Ffp;?e/Gj/7=X%h+W@\N.r?-dPN&K8HgdNd_6e3`P7ZcS/lL;,kH7G%^
Kl8%"rOs]A"h*Zp%7/WpWX:GJHMtIskVcKG#c23J4C7qRNM_"=l7'1(2Q[OG3eLF2%fi9>..'
r(FVL&6c;qZ4qJaCkMurQk7b64gfJ?\t>&WJ>$JP6K?(YXMe>>X.L)bB$N;Mbi*uRh+WuWir
-V=h>G2MjOg@HB))=W8k1,4?e=_TW8NXpDmA+<Fs(JF1B"PM2mDih\m444+$ki2BBk98NB9M
MoV[/BFF3[PVBX@X2Z]AlI8H[PlYUGH*WFfHAf>EN\%q^*oZ^6l8i>CGCS(,48Ln]Ak4??&<,@
ld1b"gDYo<='pJ#nF_("&!<=4?Hqgd$#.M\e/O'A)g+8fg<7GEt0'q%l!T:@t!=qd6;Lhshb
9#*3M-eJA<Y_=]A7!PA,UuU6'ZR2!__a8)D+NW$9_r:tG^d:4$o(YH%cMd&oE\8$bFIX$(NAL
ueqCqi&gQ'@F.OE!7Pu@\[a\q-ZA]A@8R\MiD_4$Q%k!TjhreqKR.nZtdOc,oWS=n-PsI+m>:
Q%u_GEc$?'&U3jJRtnTm$OtFlUhO>1'k<*foAk9?QAA07!I)\FJim,LjAH=Qm7nHH9q,P6YT
iLQ2STL^h!r:_L#*>ki_C6R^2\&j#BAnIA'M0D`YWd^LOge\d`=M:7c$P"T2f5NeDS+.&G&N
(:3Z-_i(D:.8l,E`7WO:m@?9%U)S]AXpoa[>ZD.\,D)I^"Ef_RgS.<cfN&\dGN))<0EU:U+A)
da5==ceKJ7KWlk;OjEi$nut+]A:*P7q'-a'@'D,f`pOQ/P9iKJC2%[U;AoufNZ,(+rh;78'`l
p`PUb+0j$W@3!6(eDDrtgb^E;),nM7niPMH?<U+Ol'&-s#n6qG8c*3Q5+1N[U9DL6a1GD@2G
2ck1k5Ago&30@0u'4fnGH_kC)K[-`Z&JjH*do,bSq)S>.5Sq/%qo,]A&d\uKkEHn3*_?-?Ara
VX1aa7`11P\*#OqV3#?Wr^]A9('D$XX9hV[)9$hq`('krT6_6hTEMa0#*4Q/:b$bFl*+8)3n(
9\PCZ"D#kCNcJZkG'N1:r?VX\[:iF%CRO_B0>:mEi[hP[a!GT#"g0Dp4;7h`rP^FON3PFT0[
69`29:IP[S!$k%13Zh=AC;XY7MHiP'<SNC-;TcoGsRK)JprXYFD'&9MRYQ@b'hVIcBgMBC>g
]Ag(kTtsY0-D>SO)\]A?*pbneH/K?$`K=KGqtck1d.9[kFALMink+8-NDfiVe+uW:Q9Q6SsbS!
a_Nf8U)6N8gYU@((BRtf8,aX\]A]Afid!=-QlJsP`=5aT,%A2;.Nc>IWdO)fD%GAhFHN_Jf+ZN
??8/n(:\YU[`(F]A=?Qp`F_70DQgT[m&j>R;$GTghi6cn5!!;$(-TQCH13VM.k$:(^<i>J"hT
%lfe45D6RrW'+ANt^>p=!bbDF>Cj`RgX4N=8\Mfr@OuLI4-JYJkC<KFpDIPD0`[12^VbCK$?
Ugn&5V9Nn(hu9G7L+LARg.>?P)oD:EhIgI.9\4Z5rm`tdAO[,q2$+#F-WgU?9(_(._':9G68
udijEuM]A!Uj5DR-LDNLBXGMTI`e1\EoRnZUF*,]AkK-7m26(3Tc?4U,rF,`^4_agYi'7iQJP#
;H*s%5I`Q7pB6KaouZX`"/S84.Nl0sE8<<gJrDkA=L2.f/=ZmPGa_f()X!&Peks0co^-a@M9
RK:A_-5m!88'ffF-dYLpeaXO*(<S2)2,?H$@ktZFL4#X/MPRZgFs@^0eT)@JF0bQ\3T&^Y@5
#&=e*A@uL+_/$@J%\ma_N9\D3+*;N*!ca)qsL#/6]AeZdVHF(\f?-tYnX.?2?h>a/]A`\_Zn4o
8b$h]A42fJHFnPXHZni&NHI2&?:NZ'EO<T4A+`DuI.QiK?Mp1]A=dm[iD3e@qVS!34Z&!eFQRK
?]ARLa!\fo]AAPBM<Tu=[h_6*5-X7fo(U<,Irl<WoZm1KeG^R>*S&V;"?!B6A^.1a@`B=$M':`
::_7=e&1<&=Ba=g+(C"EKD&/Wc=-MGp?31M=2L=H)mgja#Q=GW<+NCf>3bA?2m).ak-4o@?f
6C"@SuQFE@YFM=^N(Zc]A5ag3JS2Y;As/99l\*k'5"?gnC[=Io66TDK&1[b5".jbBP;ct_!6p
YIcAi4>>&T*mXWenq*\I57]AH*9f##=0+j.hTOlfAN0X/&.Q.er8Nu8Cd!,."Ik5tW8anYXA&
SS"gGZnRO9)i"L@g7Y9/oL8HCu'\f[6_YI=8IE[%KODJ?U$Kdq^6F'2nqc\qoSD\IsL@JJ)B
qV~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="3" vertical="3" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="65" width="375" height="470"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report3_c"/>
<WidgetAttr invisible="true" description="">
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
<WidgetID widgetID="af07b7d5-14fd-46b7-ba27-f821fa124594"/>
<WidgetAttr invisible="true" description="">
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
<C c="0" r="0" cs="7" s="0">
<O>
<![CDATA[点击表格可向右滑动预览]]></O>
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-6908266"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!C;cgF$hVQi?H7PPk'n;5je*44s<roEl)BbiX7AclB!prefM2tL`'VYfn&X#i.BrRhG>O
s(3J5k``;?p)'Muf*#[@/R3,bP_TaWNnUO//-ZH/B::QkML#'Of_@Du<87ce4Ae^:i+lXhBc
#hi<_Anqj2=baUQ[aZ'7h7dRd5Nr\e6rTF2DrYYE'Eh@`$hRp>4I.N?LhT75bm6.rQ\ZU@QD
\[FPhe`9B3kXm&6XB<R-/%T;b;XT_loPj$51oUM,<P#=O4rapiHJg3Rjl!\\*qF_N]A:\qT2d
K>/gi/.LX%j3,Yf;-nB+Qr@@1W):=?<!Mf.jZ;Kq>K=m?OG:^[@V,0'sVR?lJC5jF:EI>i51
#<lrU3N1GWn0Y&rk^*(/j!gkf+6>g^i+TR54T\@,GH'H)<@/A10@PfrU,_I6'`o9EI1=f<>:
#IX<CjuiD[,/5Uf0X_!^b1]Aae_3n7F<H/0ObiTe6S\t0=usp)VpG<4VpjLUu'JSSa5g&-qP$
GZ>59'D.nNIU&XURdePZMnEgf->2-OIS24L`n#U,`[3RKTfnXbCWVAr&>`gir05lBqfBMSkQ
&P'kP9c"%1<ON*=[j?6PH:P0T8$LVPcm-&A[fuV;RfS@p+-2Va:=o8apX\79rlSJ'1_;nalM
O!)Opio(o\/t@N-=?$S:=\`Dtmh=Nq.]AO;+4C_l9f.0.*W]A7KLWAZGu%p36hOj?oJ,RUc735
ZVu9c_EVJq[:Eie%q>iMi3EAB/_Y(ZmTRrQ)/a9RoP^B42t4\_.2A#`@FWf?nmnBJNnc7rXu
JP\KsK)EM.6*F@0kfW5>#eh]A=,9^Yii;t(8hoFAuo0:Ask=b3/)!'g6[776&goVYi\m7Pcq.
c\]A.Cp(@i'41n!]A(&qGDi]A%;Scr+LX]AiVu&`UlMp83`K17U5i.4mh5lElcI(%rUG']AKX(gFV
km-fWr?<SD)$2D>V!-3)m*gMZCHp?2I7K8L9`Aj/12rfHe'TL*jlql[V7X/%C22>4u?d4p;/
o?6<Qg&l+7cP!Mbh?ZO1*"<O\J$/UAY86D-Q^4<rLFh2iFB3mFJ$63(c,b;tqWjT\K'&Uh9+
/^=&GFgS=:O-?o+c0=dQDuU3p?(e*QUhbDOET@Whfc-+V>S'KTr_<hlp/G;WmNBtN3'ESTl?
7mCDfe4q)L!&g?I@8FO/nX;]ApXX3N$%NQ0K/?*%_AiuZTrsWKZTVPPX(9e0I.-dPGAaJaX/1
gT$40q%"smF&UW)M"Fe*4O.DAsrDWEE:)BBE0pA/Or/iiQQft/CB]Ah>nr9H(HlZn&F0Kbj9J
A6$S"I8>GGTgEQ\S&Lg%:f89%""$k&8\oj["P+/Yt0P1hs$DS6QDS9)!lg%&N&g_j<o1Z9Ps
EugCKc8D$*CcX@6YUT-64s$u:nWBSn>s$ZEA[O;s:0Oh`l,G!4b;9ZWM-*KgD8^PQqgKl.Mb
-cWOu'u&1+l,&lI.@Q5)bF"1Ibd&'DGF76dl;q^V)&"%/RV4(/DMgN:(T!N]An09139H,i414
VM"eQ6j:!Ca9J&$Oq+TDrN,+kFS95Std/?YpqXPOlE@@rlOV-@53*omjT?;'p<c>I7#;ZZr/
u@Ia'pOcne4n5uDroN#kD>)-]A8DG`H7N5WIc9I!`\Y&+$90==AP2PB)=)jmSC.MIHu@3&>oT
^V2.kH`KCYJ,C6Dso"6k4ek5(m'8l-q$fO_jUI3:=EQI%TC$Gf=(@FD9oO3AdcLo/PWath;#
,3FQH]A*K>4bW@]AfU.[^6^VC*g,aTeM.WDE6#u*E)'#"0]A"$g@>;.md0O0^dN4&T\fN]AK?O8l
_=X:I+4;@?Nt=e6iO=)nC3VgX:Ge;P]A'OC37f*9=c07!)+A;<o@uU)n4tU-@@A8>eq96,fMf
@IoH^lnYXR56QoS!^s!2jaZKLt;?Tf6i\0X#)/W&0!-mHq(fe$:Y/]A1fU--&,p%8:_58n$94
f%\4-@fA:/7>'%,^E",kgqh&dE!I\Ut*b&nM^7(1OG`e,q<+;?siH^8#>aIb#ZT.Tn:4lTCi
B=1oi]AW@"f)YZr#F/)_^H!%m5sS=o&d:s_A'519Ns3]A410.Zt#3TaWCWP?*h_[X!`DVYu@g_
TqqnUk@9Ui#,GE>s$(PP&L2SFo-Ut7%q5$HOV35Vd=a^H?fL7>`AZ12s3J00lS=D6H=We$SF
DOgZbhnAslDLlnQPE9AhPH4cn]A(<BG*;jlDo]A%r4>o!>N92gPn^6p:4Kf#_BNR[f"VpS[7\u
?,5*,fc6UZbl&6YRa5EI=Y$@^<HG'%C2^Vu=''I_'MU_."V5^(h;rIelNf,XJs1Y=dMY3[K2
qS&,\\&Tj6ZJ2Y0=hFCW#%6?DB5]ARS:7:a3f`F@TiG^Yk+h@ieIG8f1**9.8->-q#-)klSL;
_U%_W@Km)k'gNXfP&gg9ofZ?f,#-,@C)aTmE6p*%YIA!`g9k$#04ODL,9%T1%p`^,b9d34m0
HN-9seXXo^oiOl%lGGorU.UGEEq=]A,jS/tc"A;M4B3K!Lph?j,*;K*1#4DW:In]A(VtGK.ahf
LRP<P^GKAH(,*jjf'b\/1"XS&'-\=l30UVY?;/!Y(`R8]AFda%sI>.hlV*NAAE\qhbpM?@2cp
Y2qqt_2I`(1NaZ)G(W.26>Qa#OcnE5YgJX!97.p7X7PJ@!+-eFYVP%t1c49,Z8R1YjNt7Lu'
s!UssW&>ka]A=9Xd&Iu>po>cD9ASSR+kfFis/%XcbAE.R?a+tki0JfEC^5(Bhr"UaT[O)+8U/
bF*sVXrbTr[om)7G0/7';jt`[4B1mQ[."'E!rcc*6tFe3d[\aaEHEckEVTlJ3F2N>Pc@ik(0
g!bC<8V@.*RV6,>$Z3r&I)%$X4hW"o;WZI@;hq7]Ac!EoEjaTm+-8AP!EP9Q;+mC=.1J,dH$^
,Am<$laS9t$^KH[5%uZiS#q2%]Am#BcH7]A%:rS%/bk?]ABA(PQ1CGJ:sF0DF;P"nRa+fg0TCIU
aX-f5Wa8`,CYb#RKN<Ie(@1WPiq'S>hIrG\m3leY#KrA_"ktd"]A0V:0t]A#IS9FjU5CD;6QV+
'V0!\*#hueIl0$VQpf^)OP[QO8ZqC:+Nt.gu"S>j)JSQkSh)G>(ojp01-1DT;Yhi&WI"G;NV
H3V$Up&MlXg-^VI$d(=lW)-NQae_9D;C*&CgZJE:>qeEN&>K/QXeIVl>U@.n8N!%FO9aP<$$
s1T"grPQbE[\SFL=6`;)cLq<Dm",f"XfG=W9E,ir(^DnF-$YR=qpp2[42DtPeQkg5[Q/a>U;
if<891\'7$\0eal&2XdAn.l!0rmH3ZTssES@,GqBSL^Sso<F:@5S,;T<.?_M1@X>d&ca'3?/
t2@+/%"R:tI[NA3dWhe72n]A:%)EUZ_/5`Vo#gm.TVa80a'@=XRIq!JV%?%N)Cp4XTD#r\0t/
k!g$EOi18Q)DT[a&=BI_m1!['82LN16*B_i6-=%n1i:]AV\F.LHJ2RlOpVjI;Z-O_,(D%"Lof
UT&@[dh:8Ga-]A)7H.8(S"YT,a92R5#r**pO+3UNYm91T`b@30>Dk#NFN20!+J-daMp"E(]A\A
)E[NMA!O&7'WpD8Sq[kKt/(4H_tQb3:KK<bm<f-<gOG?%H>^ahmI1I6J?6>/6locF1,Ba_:=
\SJ8Q5'OgrDEQpJ<UNTQQNuAgVhQ7A*+@!r%YVAf1_0lq"Gij]AE1pA4E?Ch%I9tmX;@)Q&Om
jREM%BdYc%i`9m$hDV/:63<6<eh!P`O/]AU*0G*n=n]AekU#FrkLTZ(C>k2aTmX/j-#U)@GsI*
-FnN^"3o%\P#X[?+<7)\okk)P!k,&]A2eM`^H,A!_CT8G[WqYBB4$p;KXjD!SClOcA?]ACVJp-
Gt1kDgc4&1o9R:aTTHUrXN3A:A**?=%[JSCM]AYU/n9IAgEr$uN_R_l;CtA"QIe=GDZ3%DqH3
A`YQ.IPo>9KbTI_>bC(->\JGH5dcFN4R=7H&"JqH2hbKgJ6m`OEM>"kZcA8*B$G^,fBlO;L<
6MgQ]A<=ZlB?RhC_#sQ\mqI=]AkGdG,63s'qSV6Mh?/$khoq8;KpWl6]AOhd;LOr<\VFPmW$qN(
IhR*smMk('<IhSi_:c>^T[P$<b5)VM2h_r$Zo"lZd)1DOK%,5nK5VWW_#ThQ,sB^dIF@g)Q#
_r$.J37RZ7&RA08]ATJ:Ct6U,C1pF.@[!_ap+TDg"#X;U@e)[EV`.\h(1E/C5lpL%rpj.Dp0-
)j(\-\[n%DKjs]A<f=p<F]A-;Nq;u@O&dW"a]A$uGX-9p`L$A>)H!W)6^Fp)i$rr,06-UEK[,0Y
L@9(82o,ce[Q<77^ng"(mWa*Yi<k!Cf)]ASnP,J!MSRe?s_.7@YVDE,jAb*b;'=lW&h0h%j)/
62bNl7/'739*hhWQkU5$=2putIXi!,F,-L?IX!u<F.8RX<Xij`n6i9QDKJ]ATUGDHN89(Lf]AJ
DQGoJ%>_HFYQg[*%fJq)'uc$n%3:(<3jNN(u)%27&VJ,T(?N@ZO@Gea^X1[$1lDgqlEZG]AeI
>T^N[&S*h]A'Eun?'_lN!i)Pf?4+p?helBq4L+.mC0CmL<@56Lqg,YuStQ6HXa:g,2^mjH;3f
&JE4&'qj6^!=#8Di:W:8g@1]A:)QWUc!,1SX'DXt>3jG/`ERbh]A(sRc6oegfI%6$%PrOAq`qR
CRE.W?6a.Z]ApcQe]AT#6FdG%VKDH.kh]Ah**P3&;[gsVUsj)O#YCA$V35J30'UdSn@[ah=RE3]A
?&4@9_7['6@j-\4MNm`$A03Se",oAW2C`C.MO\#s'j&dSOTLt#FU0UH]AoNa6pba:IWIq9g@+
#F3oJuME<SB4n!j2YEZeV2"THEnN_=6"T))?C($3Ul<1\%pQ0f(g[)*bJe[iK7Ra?lVDQW@F
q#'=@/>lJZ:i+7NK/P/tM(PueeZ)"?")\Cp]A]A:!jU,b&-5"%_`dLq]AkRBb)NNFhqs=BDTF'a
W)*2*WV@30_O3sB-H<l5.#Of!X^c,KE+G=/c[\*rtt*jXF,0phR/A;U0i1JS0\a?:uQm&3d:
#d&f@bir;>Y6e+6WHYFOp:!0E24&$c]A&dco8e-TB.K!GF;/l**p>!OI@7Nt/EpGZP>t)-hm(
8=DfA_]ALXhj]A9p\*M2=1&pbo/O5s6_F'F@u15\Tn;]ARF&aBaq;TPYrOB8Apt(0t>)$*P/ngL
d/g&e,1+0>@knq?a+K=[d8HF&DtATcpCO'u6f!`J!8'24p?LM3!0k-VN0S2,ICnrR-@[3Jm<
5AA%+\0G,bCH\C8"TB`6KNXjn^D3kLE.fe,`cKs[%Tm`FQDIC?)#kQU!S7/Z0_(kDa!M3=h#
W'WJS_<8iH7&S^39EIDIk:_=k4=]A(I>rjk(fVdUUIh1E+JoRJr8D?@Vb(FQl0[l+\Wn1":B7
rWCB=D.Ut8/;@P6gip^8Ik]AZY<jn'gVL1V!t1+'o>R()+e^Lo0_C`hD/-5LOI9W;.b%?>]AE]A
iHHDLRK=]AE^u_YO?O!-Z+sJXkDk6p>f0Xe<Ed:-0b0&4f"SK!8MlX.1(ojM>UNauR\VbV*_%
Iu@aK=-lWC$GmpfLhMqnF8M1`.VH_.aJ-9=Z53ORBEelQT7U&4&tJp7O'_"j9,4""Tg?2\-V
t4!#o8'&-hmU]A%]Ae6K5h)i(_qb`3)R3`U"[_+U!EXjuX*CO)N#"9Jh5X;IVKsOOD]A%Z^Z0*=
\]A!D*@s$4)ClIE'kou#:_nE^m/h=dah+(C3ECeE'IH#ITTDS<VnRsW3!M;e8)c,"n;@>;6ca
YM(P<8%J(-L,go?]A'EKuDMD0tu<96^hUbDN+I\E@*uiKe]AonC!)n"3mVFA,pn#9:FV8\]A^Oa
cN@hdlRrj70-bn,`5ir*J)BR%In3OPfQt4Y1B;uAj<k?9(HR_QI+KAU+Qr9+4@2kG%DesEqZ
nug(#W]AOkUOHB\$$s+i0S\2d]A4oT$SC%toU1OerPV6h<!!/\g_>_*,(/5LEDtF*1-F+j>@cK
01=VO?V;N45^b_Fi;d5@.hF*5e0ZHnT[TjQ^@rZPs)fJC)`2&cS^*PP9TqS(lK"s\,d[B*\_
3)T$hbM#j.$(GP$:/@!+#a_DT!K?,bPDFN:g.*rIL,@7J:*tsbBFR"dN&T0Htr/r'SP+`.s;
RnT+;t*kB&ZWkBd!cTfX5ELSftj*c*4c=#Gd8#(DAQ>%M>BVA;(F,W:u:2Qe'\L/`?a'3G6Y
,CCn:%83("ej_o#Jb/P@%'D,kT6Ub-cM>4.i&qo.MIKkq/D#nYWkgU,>INdUOV*7U%FUY*jk
;Km@ipP;/IfeaV$ag"Ria2_kX&omN!FdUU`Vq%k28oI0TEs*oXtCkjZOLT:KN`f@AerP3o0h
tT12!1bpm\ajX/g;=)1::N(M]AP1:6#(lS=;%:P@TI*aX*td"`cPU-MkL$N4K<!XR&p1^`l]A<
!YZM^DQhA`Od#',P9`?9NNBl'X4gkE3/Ouo<^AaLsZ[X!(EGL)'=N'1X.1uCR3;J*0uB&aLJ
uE%H4QU?l1Ud>Zf#F;7Cr99Vs!;i-uc4FT52P1uDLID8QX,&5Gf<fX3gnI/0Ws1K%\S-pbMX
"mCj[+Pm:Q+"6VK'$*Aa:KN`KqchGUep@4#,j:cS9g%RWo&'GW]AT)IO'*[?]A,$qsZ.")gFIW
!Wh=4<[R:FlqSI4qCs[*ejfbGPdnl\p1X$`@!n^TkKcRHI=.ndC?B5F?@N3^UO6mHJ1IX5hK
(B22%:.[`l6;YB@&pM6(8]AH#s<oJf0A#+V=:*#HL"Ug)Z(2j[V4ADHuNcOFkfYko2sfN!^AC
Or5]AQNth+gMhE8kr"epg_[CCbr@Rq1l5A?^7J*W\Xf/QmaRWldA]A.LmH#WRE#.FVQql(`/!<
>d,I1"gHC2hH+,-cs)p.fn["SOs94>Im:AX+&?qf?lb9X:GOT"0\Yla9u,%Fg1EM"gS)4dOA
cu<>S]A\h'UOqQ(m+l)t/i;MH`i+Z?"pOI,R>om[5JVKM',mm_Xk,X)tSb/5+/%"`6]AqW5VC0
3#=`dqJ5_8p/A7DjA8@`lH&)Ws2n@P"^um>b6)JY>Le&S`=+Gj,14jZFF(I]A7\g4Rg[diR)S
n^:r\^rso~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="23"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report3"/>
<WidgetID widgetID="af07b7d5-14fd-46b7-ba27-f821fa124594"/>
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
<C c="0" r="0" cs="7" s="0">
<O>
<![CDATA[点击表格可向右滑动预览]]></O>
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-6908266"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!C;cgE)g':_#8k,is-+?LREtP@Yarm(Y5).(U9^Nit6/nXs^&U$"5k;-:C0O.__A.H,8h
">a<[%_/9dCF7;E,k0MEjK23?UWiJV:]A)M:)lj#LA,/Zu`F#W'AtgO0uaqX`(>Litm2Nj#:\
h)\_T)lm@iZ=MEA3mNi*"]ACGUg0-gM&HiLN[G'6`,aiiTAYDDc\)iJ/,BkL5bE`3pcL),dKC
!mOOY;Q]AU/,'UhHFpn+emH:#Y+,4<mds3sY=CAh2uMi%&mlUR&'+=-]A=qYl!g^1+>9^K/:<i
`PV-7QLdm**!L8/ke16Sn+BKAgCl+^_(oQ+H?FF+[XX81ZLf;,k,o^:5Cb;r9)=isP-I,?@7
(kfq*9\lB5r-f[NfPDU+a'.YO0?1I.128]AaVT&=F+0&n1Oms2/^WRqCF'jb`GuZqU7V$G.4Q
DM:ULbNO"[N[Ap9mrLKT>&!(]A*6GF*c;@IBQ.j=3Hf`8;>dpg?@nV4Cn_PrQDe*CFj\>R_L8
-8!(Cqr:/m";g]ADZ_p$3nI"O1a@,9g]AM^=GqAid0Y3B/L#mI&a&kFT*j.BRMhf8XD@6U$!-?
$r*[''9_-DVIX@3';?$-%,5S5JD\nC$IlH(JO-`;a_UhRU]Af\)S5s<+KMK@kpbBA^>dFjZ7F
njM7#Hj#:l[Fc(6+W0"Q^kWoLWD/*7spfU#`Hnk<osH.@YpX6!FQJcjmA;sBMEg+p<b--u#P
%f7.Oo^c4I)KQkKo6F(1AB!>=ZY(l\lf`V%c\gsghmkSU\#t_I.+.s-cMYhKMe=A&OhBbh%0
`@oD42HGKkopX-(V_t@)_MJn'@4$fnV@]AT[jW3"jage[I-!dF/qtTi3P?0,<t8efoTAW%PR(
+KJY\hR^rJ9VEX2pouiiOgh/g6ibn'6P2HDI^U61]A)'SSk_FVlJHmm\d6E'bIH+!B+s&es<M
\VRjpXRNu>lCAi]ALQL+$Y"]AgHfRNCM-c+TSDB[k;?q!1n1(@j07cd-GD[?`m8Bi809C#=g\+
FLg#KVGM/Q"c>%VC.K<i7t@[d96QK,ZA?[4CcJ+6]AkAb?uu;kWDBJb]A:@1X4i#;FDPs,#pG2
F!,"eo6ciL<6q4n!d2R*S?t()QDG!`b>1`*,d:aRYhg'\]A_,%W#QFT`%*Dk)m2=br'*A(QA9
`#d:@@eh2f9QtPNYO"&n)^V_<%&RZu'.i8gHZUZPRqCF,@u`[@D<8:F)W-G"U/71:l$F["qJ
'4$N]A`]AH/*i#I-rtQa@rXW*GIS%.LM_L=9,ZF3/jeB+_2S2UKMWs&oO8.%bdiek*J$^Th,e^
KJ`bF)JDn\_%>BI/1^KSW?UXH[d]ArDq@;n\S@tk&\8FZ0tB7B]AG+-RYmQ2!4qH.e>0Ziq[3*
4\PqX`N2Y-#T;\+K'9<[gp/<l\n[U!lNHerP5@==Eo`=gG0!q/AY&H*@toBXKEVU%eg,#`9&
c2#^=fO#`L]A3Ok,X3/Akc"hW`Kp^6o_3O041r&_dM!]A::aAFB52=cej\&>n>Xt'hTY^R*l9`
".k+@'#/Fi'd9:[f-8gQVl?FE88'A`$-F+<-AEorI-KFjMpu0^fL1UPQqQhq0nB*3kGuc_!c
iQo<mna#gAiVg%;G[Hhfb9kGM4@OLBUMM@=+RQ;)G(RGY)os^ZLF#V9O'm@K+7A6U]AhOC:@Q
i;D^kqqLa8sREV')i1-pMGDPhl:L0Y7>ee&'*O%Z-E0snb;N#@F>h%Ju:0-CC6'a<[uMLn4g
O.?5-8;#&UiQ*Hos)-1Imf%Gc/Po`C=(JP,2CPCuVh-6Y[r/eN=8om12'c;^t3is-MbV8gf!
2=7l+\!777<2$Qki#<b>Auq\h9`"WLc$B&/q7#,OC0`pf.D2+MVs/O1MbR&mHa5V?YuG+Q?B
8:nER<]As*V7:YpMqM%<SqH]A7N(qNEH6W[\;)%I;tmc!H?smC<j<,.n&&J8QDo.a_O4V%Cepa
%>Aqr3MY/uJ0o\?_Uja&s'Xm8\+Xnf*9Wn7\WNRe3cr<3ZF.PbMMH4$)]AabMeh$e6@6)OMF3
b"&uSlMJ0LZGFk,n9V;Mfho<9P&!A8`@4D)iSMbW^.YOOV.Eg_%;CCO=c5KE.,Da$>ZFFn4#
F7<6a_E]AHdqBYWE=7qHHm*8r&EL_]A,o0&uJu)^DNo4,3g^>9R-0?n;;:Ul;C4c[9N<<b.[AJ
El$/8e;=<=g&@OQ'h"ne,A/g0gcIsL?qc\_i$h)PYB)UaZbs-DOX#25iL8&d0^11O7FSfo</
Sb\C@#U2S/.f"$?_L16X9L;Y$Jqg3F-^nrm/Uu\8%59-:KC#G!U!dfA*qFR@<ih^_9TJ4-et
DcV94Vk%qW1As4In0,H#"e)+V,2T6MmY6j@YaQ!(nECPN$^m@^?lKar4p\DZY_9o,+@ECpr4
#Kq3C32FIj[>7V9IH.'2.ed_CVPNbWQ:OtpDk1">".?KLr<m$,ns49WDSa\ED9$!_n.DJ#%M
gR3A`U8IufVn<7V^..4LF'g)gZ)h['>i`q7AH8K]AWF;V,t)@e?[q:ntGsoahr,_.L)O<M?L<
Nmk<@p#kc#BnrWIje[)H@hM3UG+1*4W9rJ@Xqf.EXGbe$E1!l165@Huk(LjkB'po<_gGaF4%
485A<;$g2]A*g=UbPX7)U,-kAUTaYOjKHrFnfcT<N)<6U`+mF$T?ppZXX_saSdJ0fDNq>;@_G
0V))CfFg28S0l/<i[@g.+P'O"%#sU;Cd%HUoSMZlbK%S**F[(VWV<)'*AO_B'999m]A0>'6(j
)J\Ue;mM&"W8c;7Z*!Ipq__!h'qNOqBlh_\WJ#8Fdk!RG&Ue6d(mNSNL;A`YmUH4lNM/9VN(
NXKaW$O+a:ogKUZq7k7&Bk;@PG6PtB1-m,dig/Q1d8jX^c;nFP_79_m:eQbI-W0Rj0d0j(23
kfl(d',*p4.Dh#>FFW%>$iAH#]A^f6#T(.F)C4BZXZeVK0BO&N*fMrj/mpL8;=Q5k5lDn@hbO
70Fnc\#+#S3!)_ON6+UF2u4?AJ"U@>e%`jL*FTVmuLX%Sh1/@)g)1"h@p(>Bdo5.&.+'CU9P
1q6rBoK)CXo,./]A+8?GMa+]Ae.'(3O<d_<+\O0_o7mOoCMVj'+*iD8Igl);62#.aChnT^peI,
jA89-:p@KWVC6qkrI`7Hu!8JTdn/#%d.PJ"fPVu7D#^'\b]AMe-Jgh6d+F*>DnJs6S19V,TXo
@Q^5,13;Z6G#GD?1HbN?Q8g\):c=mS0JBB*c[V/#*@DP[OH.3=+S->]AB^d5X.4clTZ[Im/pn
['pO6I04@!N95E=V[(HfO1M.lrBsE1I)TRfl.<?T#5rA0_`?hBL<OA(DUc>qBiOT/<M*WT,s
FUN:HJm*:]As8QW2#/hU192sQc`t48ajAB=ul5ZJJ3_ra7?<,1W6[^ZKB5obZVZO4Qn-uF6fG
$=(j;U!d*+1k`bm/jucCeq/(Xf>![_L)Y9+XVK#@UGGILnAJnJDSf;gY*iYd;ZQ\CGmJL[Z0
hr,bZCE,`F\`aL0;1`]Ah)/j\VRbkM9HEIoYueTc[$R_%d-MXK>Cp'nrUnR1MK?qMp266?X!s
;ik=7cCTlNplD5d7MR[[/Ek;eWK=AHYNG:7.k=(8;f]A[Gdro]AFd<gVq?G_^[4%T$(RLpjR&f
*(UB<#B8`0D?:[$$=j-icrs$Y<K`#M`*n`Tn%AO1Adl#\X,H-NP4tfN/2snUFFcCaha"k8,T
0YgH\5-g_q"2Of=CEV4p;T/?>MpHq\0X,1-A1OfgeND*3U[-,hAHSao+6PrgDp2i"*$gj/h^
`_-/nGfb98uU#Y[u1fq@DQ=YI:j,X7\\^e[u(8%rO6loD@:M-\QgT3P_$gV<sp2,0R&Z/3hP
&/;jJjrm*fI2P5A@aZiefGrGS[FF1:X8er'!lKeT8u<kDP9qGEChRBkMW`8(=irc*L@J@cZ&
]A/_o'\0TnA*SLh"&)*`\r_X:gfS9RYVt&Kd2+(DACr?jOdm>A<mM*H80\Rq14c3l==!W!*_S
7*[hhadgKYVKJa3c`MkD%7f;,7!*Z:?=^2bVZdi(S9m2n<He`Ol=h+hmaaRLb5)3E>thg"/O
Yh$T+7i\GsuA&3[SLu;\;6-:"3;/jlqj1\K%&pY\l5ide&u1`I[hH*`Hebc/DE9*Gdq5&Af1
h&s?))e^u#jrGHX[B.;`1s"+p+^Nh]A/<@AgoB<;<)T6.j:A#Nh,%t>u\SKNQc;qpPnK_72Z^
0E@F4$8OLR&_IbGC*^+U=eF/(39sOb@[>*n<i8A:&S%;`jF:2G,dWbm2[5=*!AGKajoA&$Su
reD)^mp3_?J/mM\\2?RTGTYp3KH3;n7hT6)MjT3pUGOEDoC40<tp/@E%sHhqm8nOIGXNcgr<
0oO"p'c.oolKMJ%BKJ5k)'4Zo/AiIm'j1^EO\TE#BpGb'VI-VQjqEucBE4&<8$qm*k$'S`qT
[C;$^^oL#MS5ij97.5IHGPGksikc\:&0n^_dB$)^QZ9b%8.VT>TqdF(]A4Z0GDd10_DP5oCCN
o;Yf$p"p>1MI$qaG"lb"boe_R^9'O-00g9=(R2q*(9HWsb^EI=MTB",34C8SQ>l`;/BXP0C=
jjZ&>%C4YUDbPHn]A?S4MSq\2Z$2p!<hX?I7,Fd@>d+uM@Wc(#?m,lT)m"AL@[tNE/1G-mIg%
Z.^fdJ&^ArQa,A:&$(-P/,M/T,+.$#RH"AIH8NCmFW!,2C/NJIBj24GHj:^kRqX^#VIo#]AMs
<m(QX37"#(EFQ.Q9)uiB,NfmM6u7jKGSkGAp887a#^uGSZQFk^e'0Ub_cF50=k?3%4<p[d)M
9$Wfss5GY]A9sK4Ngf!YM&)O:<Zf4;*aDQ!B*lO@iM-+22rt+WdTus3C'm01',m,CS?psOPH:
A_\U+f8.j?cl8BddpSXh4h1?%R#a4#?.4^i44D;.!4rg<0f,.mJ[!?'!<6`\a'4I?"!3isTN
0@rDD$C=1E3Ya":+]A!t"u/)YA/BbGOls;BRG+K3]At4rhSqp-/CdSCUk(3l(YtOXRVAWA'.%R
6j<dCo0[[("e)"Ga>CUc0hTDoQF9]A.6/:G[-;4!'sol;09tEHXBSX./?]AaNTWD>i>3>E_VN;
(;W,t3$tb=gJ!fS"ljXtQ,?u0h`9TLS3/ueElW6%(dN"[%]Ae>JG.RpGVCT"SNPE%?kRT]A@Xa
$*=`*pl"_?.>ceZ>t,?+5CKnT^KQdr:Tq;qpMA5Sl`;c?"1@nhC`rlsD3Aq%K.qD8]A"lkQ7E
IY\1OE;YsUcX.G=,XaK=$fHo(VPIb^[7i%WQ=7pmeTNVW7@@qC)d+DB!*tjK'*2b<AIcc\6E
:kRo$Su/6=0F"R"a>D5Qq@oJ7R03`)_%L0%bkSq#>H#qRd$h"@eOgQ0UfC8,*33P.[IZZ4";
P"gEkG7%QTh4^>Db'"cCG-q(h4YV^njoE7HG"RVU(J4XKrN%6b?D-=Ku_FXomXeB'rh1F!qu
,*ua+R$d-,&%e//0s]A;JE#V4k:UU:lZlG;(>qQ^^p-2ei))fiK9psj2)Eqk"qndsP8Gd\2)O
ON]AEp=&*4=Cp]Ag_9nHd[kG_J.en82hs)>mIS=P9M%Qlo=@k\IRT@7ch*dMBZ^</^)h-c[FmV
rRX2P""Tc"jQj*SL&c2c<G7K]AkcP)ZJI1U!fCm:BH,7U.(PGD8'QX6^?>3M=Ls7MIdo:XX"$
D[[J56o\;+&QeXPt.5,8+60@=SMGYTYPUL^+A25-*J\9G$0QQ+UY\L_K[qRZ;eH=\Ip:kGd<
2*I+8g`.,"UV+)MOVmAn5aKnjCC3thXN:McPG7k?V%n0Ae59pL#kU;o6;JG9%g'N%.'U'K2u
=?S'T.3XS;@@7f>od$%`7s7lDB^%YCp+.T41dTh8YRJs$r+Xn&B_XDJ`,daX3*8!42:itgZi
P$\pTbDY!RJU2/>2]A@*2LZEC+#[`_kHZ&o(o$!hF,[+r&Mu_I1bQ@2-a]A*6'd,#/cb_46Y<t
$?um24Jf-G)OQejJrSH3!HS@"Lk9Sqt+j`#4,n26L.0UjO(CS)cJ5Z18+K+e\(G#acVSr(mX
''Q$2<iitEG=cr!tBLrfrElpp)Ia^&3AH>cJCrc/C%]AC@KA64pd)Rjf%)@*lq/5)/%esiV69
SCbF(`7mNXU;qP>)0d/]AuG*_N_B/dSEEJG>Q3$oa%ng^_cC7;2WX=?LXZIQ@P#58UM;T&X`d
N]A?AK3%m8AL8J6Q@re]A`1o4_=bA\68.Cod?M87.>W2ed`Ufc9]AoK#h#nfb8?)WfJU'"dc@Fe
,0FjG^!mjBlDVXQ5Qi3]Al?3dQna_VF`8*H$N0Ob:cPie-WUCMi=8EC`e(UF8!M0(M,DZ3dpi
<#J=b>@-4jEB=sPkn)4f^[kZBZ5(=Lr:+YF<EB<rWfuFQu\ZuMf:ea8orAY#>YF,Fk2?q/:+
W-]A"`U(VVpF=0*e,#PQZa)q'-doc^D!$)iD@_W'?2.(LR_*L@`EjI![UD"N>KqePGA@;T$k-
j.UPLDLP;^5feNe=[j"B^=VeDi&7.B.$V$NnTm&\`=a""H)Q:'&<&R#ss:O@5Pj\XJ*dMWeb
)`*P(ZA_G*3i+oR)d%I1lT3NJ]ACoT[;rigI.i74a&]AkTmB_gn20J&8m?/@QUD%2:-ndQ6lQ<
QeQj:I!-s,=pKA*jeO5#k4<T;OgNT-=@$)fTRdP6R83pk4^I?<Yq\C`)h/XU^?q3^i+H_7Jt
*\3E)=5h+\]AS%qbf,RCHNG@q51^:-L`0:LHWd-dd7O#D,G6InY./3bgt[tU,.$an[D9:TXs\
qRCt\1:l<R<=^E,PkiZAY,YeNfJ5#Q20Oj[FR(,,A40\%Ujg":e"<-"==(PAC`b`C.IY0Ogl
;sM'AHbQ%`Aha7B:>RoB/S=a!b@?<M=NbqeBuq?lE'*PO\jPEVO!?rM"@'P$f:Kdn'mI$M0N
'i#mm9faH"DEL5oe\?Z,dZ$DH/A/&Z*YnegI`scQT-_SBf]A'`kk8@`Q#C\ET9QFD0'9f8P)'
COQWLIA('JJ[S6KBP\`dZo2;-h?P(V_,@&;e7jNl4#qimG8td4f/@Ch47rPd2a2pCCYZ7_qA
rhJ<`g*[kX]Al19kX]AXRKH!7F/_L`@SQ)@-IgccOn0QXhD.TKnoh;/]A39]A2.A.)f^SP0Wb=4^
65-BQQ*h-`.Lt(^_p/;!6aa>_:1b18QDZ.TDia2G#Y3o5ls'=;+7^6="^,e(cFo^K;`?dZ!I
'T)IE-$,B>2,Mg>-bNrb>h5#`3eqN3u/),'B>BiO(609!MGG%,E^poYi6-do(sVAK\g?>1\Z
cbRJ!Nijfh9!H-0fV"GZ^F>/'PX6tOatLie7$T'%+;0rfX;',6.#$(]AjWPk'<Y-mN\FMnZ?S
L_kJGa4X(=OqJk`FaN!29WXWq,9dUIf48*`j2>H,C'p,1</L.SOm79NPg7p2D;KCc$Q4OF;d
65@nk:?X9D&Ud6)[,VV'f)nS&>F=IjNO.msC73)e+h*[th,KL3W!&W.#$UW[<_B]AgENaCG\^
$i:IiggRJ<=NCCpaW-T&nFjVR/4N/8RcsD!^U4c*G6n2F7bi[I1_T33<l3+\YQ49_p@VlkT:
'DMPRFmM&k^oD%u,&$5BEI(98T#)##GX1u/IY$$sYM2$!#OY:e!9;OtMZB3?M]AYmV1XR=EY<
a0=*d>Jb]AB,1u^!R5A#a1;OhS19d:U32$<:]ACUPT/h`k>aYSQ(<FbV=>NJ`%[N^;FM-gL>`0
Mjl5+Ok*FY8_'MZD2r.Q>%XUt\uuD,4P%Sm0,.jfM1cQ0CdPR_s>PFGGb^kYL]AR'1]AM'bm$L
CNLN,BA9.cu4'93$:>OXskr`UA5:.f3XLYVtL^$8BS4m"4V=P9A:TSR.aJ"/)$F,t#5!-M%>
&j%%!/VJj$aBe)Y=Id$ItRInpFDsHY>BHiQir^_ohR8)X?6ocCX&8W?.kRGLAlnZq,eh+8J`
dhMqD6oXl#!R#"_[4a]AELajs7%E''"_B;.8n6^#Y:k[mAfiU<bUqlCXk9?),f!*'te#X>Db!
gYP!/&l@;bO#A<Uh&Z9iR'c*KQ'k=2fDDB6>c7ipQhW9^DT!9!Vi,lg)H!fdKF3fm"O&*E1?
D)K!^LLa4FGM)e_SCKW/M*8N+0Gg)lJM1U8WIWX%*2ZUfQ,5Dm7opg]Ap0J9I?6?b,9SG%4[m
lkK'c'ShVhkrJ&T5Ouc$lhj]Aua%coB."prWJ6Us.6h&M%o.r59K83kO^jG_,F8g?[q^?-i:8
VMk<MJBD(q"R/:Q4*&m?W[LLeDO[t8Qs0=mUMtQ9W)uP+\66j/:hTCWo3@.Q-EQb_DBCg9mH
iF/<G`cD0/Xg(mN#0mLEY'O.</D**rD(PNT!+jF1Ge3#^Q&Lnr7\#_4D<Y@6<HM?n+;m'e%0
`39V8T!+NXb)YoTXZ%+_mA5,[_@+;h@ok/_W#dG#215[?<R1/*s'rQX@DXN$X+l(ddU)e:>H
T*_jW?%K9'h/f[]AB)LR6X2pa7U,rVf:*A$*Y7b1Q-6!G)Pq*O7%YgAB&C-YJEb`EAqAB$Z/`
d':>VRndJ>Xl#BQ(8U,C1.J/fh+%:_69\\>"mFCZlf"jC2Oo:4)-mJ=YbU6Dqk&)LLl]AN*nb
/7RXR#%:_jGQR?Y4ndRrl*OLHdUeb<?:uh/XQKIGXc8Sp3?Cnq<J48FlOWOl)hQ0X&stueun
h'p#uV4DTpJ\iSu%7Z$W5c]ARZGDIM@oOYja891t$/t#^p`T=#b97Qo+`5:`>]AgLiNEY]A)]A9s
Is.s_+_&`9MW$R8cX)0Q6pI#t3/PS%Y=>i8kacs)?t'!]A:">sg+G1UIS#.6ek@/hT!O/G/Y3
BJ]AHtDOU6e0e:*5_2\\!$VI@LDf2cA-ffUmM[4O!enQU.+b7.^1Qm,i,i\CBhEfmeocdC!]AU
:j;3*\RcS6V2h1P9~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="535" width="375" height="23"/>
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
<WidgetID widgetID="bbff838c-e1cd-4acd-a545-6edd0e1787a5"/>
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
<Refresh class="com.fr.plugin.reportRefresh.ReportExtraRefreshAttr" pluginID="com.fr.plugin.reportRefresh.v10" plugin-version="1.5.4">
<Refresh state="0" interval="0.0" refreshArea="" customClass="false"/>
</Refresh>
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
<![CDATA[1440000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2304000,2016000,2016000,2016000,2016000,2016000,2016000,2016000,2016000,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="9" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="  成本明细表"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" cs="9" s="1">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="    统计周期：" + 统计截至.select(起始时间) + "~" + 统计截至.select(统计截至)]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="128" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<j1a;eOgmICkKV.+9qgVAdNtg<-eRA8DuiJRkVs[?P9<4&sIe>&,Q>&4?thj`J\=@nf!fNJ
`n((8u$(0W^+_2Cb"@<.c<`L'Rf(`/m,BbBH97IYF<M,D('phqMN;.-BT\B=Y53^97?^Ou7`
94at8O-iJAH\8`0o^[gBSET?J`NZ33:6bg3npm6c9R@fKY-d/+[ia:Tcfljc'QVhir%%FOM4
L"a?]A=*EpVUqj)?+9?`)1VYEi4XuPNK5pdJ*>=oEpc?J?2ol0;I*V"[Qa7(G9*l:SCb$Tmt6
Bj2^;\rc&7=W`P1,gmbPUlYH_9+:aP0M2a%Z(C1V3YL!ug5bW%gJXZa)-ac,N0.UMh/!&MtU
>IUoH=<DC.7^SGGW$pdbQ?5(>e%IPn5C9;b`.tV$E$pU\Ha]Ah&Ou47!.LpMa9oM]A7("J1Yad
X$9'up%%#QF>jA7hN`G3^I9nL4X\e:J,,[H_T4AS^?-f@eX;<0$_=^8q*S2^H*d9iOEtWV)+
7:XfPQkFFo$7Z-?tSP'H_/q-]A&gqnN(@@EA,^*qo#dFJlr#1fpohoqtl)o#Y1fW3XNcOM1jh
ff^nCrQ/'d7HtAV4Td#mF6Pk=2(OSB?SZf&f&^\-rR^5MsaI+P&U.a3Yeq8^tZN.>A*Ne=CG
(]A9C&mslGPAFj(F5>US8EU92b*9@-[o[XMp1hm#iW#\o1c?KV^3_Z@0IuNNk?8F6$efbiASj
jVqQ-SP(IdV2&[LcqVD/(I(XZ3o":n#03b?hO`O!]AHRZ!b0;^&e9G$GQ-7m%HP7+>(2c(E^E
HJ/>OJT*.l,$>bqrRFlhVmq]ABSDr=gH2nF*8m9btc@4+Uc]A_4fID&.F.A7$:1Y^YX7euR204
E\dVZ6<kS98^@-md1pm7D8b'LXqoE]Amkc_pjTM^QVqT]Ab2Bo%#EThK7&OG%M3W%8;3Zmht9H
S+VB]A'?$SioT?;'WG!Wf(CrkIu8$1HHGtD`+OFW)"uKSH*R8Y;8hSj8h,Pj`^_Gld]An!r3n6
"YhmT`bC]A>?bm[_a3^975f78!1<9kL9>qaBUJ9GM.2IarRgR\Td,eN'bMBMN0>cUuKP1TY_[
aHO2o"(NuuIBT=(D=>r=:1?X;S/t^,f_=DTo*ZMV"i\SOgt34K;HEL0gI1GG<MC/G8^!IIB!
f:P8?2O2r/?'8IH;)B-$8uM4RZ/)1R+5kPsnV^Xj>Jo/,_.3fp5DK7<I2m,qV-)\O6?3A<0k
Y(X6s5U%nBJAZ(?<0GUe=V:QEN"N6MHH*JGJ:+It,h3q1dj1NgQDe1OS6q!!D?=L!/rdAqHV
QI,(6:?MGJS!:l`#bM7^STW/P./`!hp4e?C1Z&pIFcK)NR#Jb5?PBHolc%-:i$CT1hN39M^(
gD^EZ3AVfGKaI9hTFF`D\_BN*@=rhaE'>YJQ)n]Aj+c]A*65l;6'(HNjkl>=jUF6,F7FkcAp)/
=PE*cHYeP<?jZp)a6R"d2nk$$I_J$j(B7U/Mgpp]Ao2pI/-9S_G%rEa_eR7sd]AU2RG\Bg;lf!
CV9Z[moC<J*3l5k@0=SO^mWU\)0L&M.,u,!mi4b*.&W7/ZYRmCpnpl['--:/hn.ZF&<[>)W=
gbC)mlIF6erhe(2]A`uisc_:6-D;-o,uf9ER?0,#JO2WQ\_Y"[="=0Qf4ntd)bZ]A=,bm8Ho<T
[3WcZ0'l;9g4t[?<*nYMg:t\<,EE$oQ!)2]Atg0b2)5DCaUY,Qfs7+3$_'c$X3FO@eONbl#c*
t8._Fk/L_fH7nbds!7T(\`n*^32J42M7cMR&t]AW8\gf-6A,Y402!7/p6F?S7I;Aba%p%.7KO
rY?6iHLV++&lDaeP"/S2Ge.>5;1bPu>c5q_&3fNb;rT2Vo#`+DYJAjDYg);&EUZ^@hQ)8CCd
\fE\k=A/3Or6D/G@Z#Yndh6m=6hWm%sC@ZDlPufN<4Ao?e_E*D/16q&3,%_;-ETYGK=:q?e:
<jZlimhJ:Qo)a(NET9"R36KK<2(j"ZtD<b<H:*[)/5+I"/UMMeg'E:A"-'Ig"A4r[(ZQ)Mq<
MF\^4\%lHq:5%^L=.oH6)?0VBl`iDUmZf@(A3M6M93W!*kmkMBHg[LB8PqQ)WHq[)9t1n4"P
'Q.?4I4W`N/+PSf=Sd<n=,"ombX[?^9JZMqNo+=\kaH,?lEq(P9)+lD3a\KTh8>:;>h(g>O2
RT\K-<[GZ>UN#=_>q*N]A[<Z5W`j;plC-h'U$APFMAR,qD]AP\g%UPV.1Jnc>NI)C)8Oho)2.e
#D9k2p.8Ue2hoD1&@,95ZL@MBk<Q>EbI++m5X.ZCI$.LKH6]A3&N)[LW]AIa)QbIIA9;Qd\Cf_
/"ERIpbM_Id2bGOZC9T!88=R#(McR.17M7NkWelMnil'b3IIacN<%3;o,P>5?o%%PSc#e]AB&
3[KW5q[b*.GQqXFT^T:WXa&"s2,4PUiUU52W""aTN<P=[,c/S1JS["m_3;Ff3mYH3n@XiV4H
gg0'Y-pB6;_C9VOD^D6<o\ZjD=XH3ZlR5'1+?XHg0W/Y<?'j#8JOVr\?"<Na`'=Jf'"f^F'+
[j%5tGti%\j=O)KWIL;ibRroE[]A7cmX1Di25hu$rhL1[uiJL:r3j.eK`HL@Z^5`?`*otKc*-
8T<cD?TN3,5PFGdY7L)H+:-/?3,UC>%bOm"N1jVKALZPM03rmR(%0U39as<fU1EQlHmZ4Et_
XK^J'1=E?YH(a2KspWgCs"Ros1_;/bq&eeSn\VU9Ag>;S+8Y4&#gZci(:+gEcTUS9T<E,d:g
/%&f#%_qfGX>1m[3AQEiO+<n3Q$Pl$aJG&/;>-[#mZg!V+>`fHb"alp'uOI$:1F;VRtUn.^=
mhU$Fh.@ZID"<t750oq(Lc'@]A&Xehn"3OGf:ZS'Z>E33K47cHqBLpXd?l>jFr5VbqC++aW2^
S6FGg0ULP_?;)/Z>=0g>)4Fa04JXld?.Ind??Jg()R]A.d<_El(_BHk3@:4L7c]ALSopF19J[o
tDD&^>J9q9r4lW']AG^::CjAIbJKH?]A/,O*0JnKdLYo[UNP@8ZrpiplCAF,1(g=I(C9=P`WW-
_;u*XeXSPEV:+oP7I3f/Ej:d/>WdgQ`jhReM%f$cCmr:CDIZ?%PmBg9&:qW7CAR\s_>'61',
),NHIS7<N0tkNXaF?mb,;o^pUk`n+\YP"Fc&H]A+_!7>?4GsK=Pn>Gm:iB2GLCU5J/J[u'S7W
%>3t&8EQEk%n\&NGP(O:'d"-')7T"4,&I9)1Z8U"'P'K*3kf#f@RFIE8N[Fae3^KaG`?7).h
nHcZF;r>FdQe8)*FJO:-LO/f$TQ@#2.84l>`RV6-YClNR)fL^/W.1&a:gr&_U=3]AOkFRkUL%
$c@=!sV7&Os5NB&mGmo`GW]A(4-GLe3l/)nI`B)JXf4^7IGoWN*Ioo`i]A#@Lt5Zk\Tl.pDjp.
:$Uh.O+`co_/qC--q;g;s"'=OiLR$lVeep'AmesM_jn9N@1lKEfkR7"H.8R!Gd*Zp(jV:c17
fDZ<fOf`2('XqDf75O\dEZluB!pe+A4)@L+n?HlGdiVZP`W'8c2m/pa?@FC4^.&d_0pPg(*>
`n(0#a!Mdafeeuf^dS1J`jXY@6ilssb>IEdg68^B;5?RHYJ6m)BCr(/n[n$<`omX-#=hJ0XE
3BEh8;K_pI9%ur+8#l`W=BgFOa6EUNXtE"=:EcL*JhiqrMfCu"qXs?pN?eo(X)UJpGF@H,B0
o`^lYSEWa?b1nkSa]A42f`&'&T0NV`4-4Coh`+dN/!4<TbO",H/e@pNASR^j.c>hW1S]AL.`"7
ZqJ!%N`PG<8YWWs5`e)PMij0u19b/\;q#%MA&$ubhR#.Hj^rG\R8euU`L?QuT-(iQPgmi=Vp
&a,F+m)tdn\T'L?O;C.ZVuu4lo;0p[`A@J(O*R[b1GQX*Q(`[%<7W1/K^IeLbb/t:C*oMHL4
Y2fgA]Acd;Ff'6$XB[ecLcDEk1)nLl#%dF"psSI8,'?@]ArsKE*rR^<"jP7R#hN?a[it$@$ruH
E"A:X?JHLN.8MBI/8pfB^G;0:I<sOGf5]A$HK[)1+V_M=P._]AGb>tIi'GVi=_CO`(,VuBlOQ;
h8q"*Hm^1P\`W/7.T:Wk\R:]A\P8k5;#3Yl;UmI<S+L@aggY=]AguiNr:'S+"FMgilSs<i[bOH
I&:;fNDXAhAMT=D8.rmd%:N75P$EK1b(fZ6ed;%=J/sIRAU8#N)>3kGbm?/@/qcg1<lR]A+Y%
G!%:"nr9>8`K#^"B@p7>i*YgXl=)J3CI)7&qPDX.'$n_808dhUS6Kklf@m>2mCl($+:!4Pu(
#nd.Jd&o.R'`n06-U;+TIC&Sso\R%K%LhAYVU=#ER.[Y/R)aj5fJ,Xr/WJ^8/.s-a,id:8AU
;=EbM7NC*bGG5kEd-VL@VeoSl3N2cr*6*'Tjh4Pt_%h5%Ha0cJnt2n5Zo28NFD89#/kMg#U8
p\8O5q.d^LPjIh!dTu>idshTngt4:_eYCbM=eg;KWBgm$q1W6=X8C0]A%E?+2`="d"pSOGC?C
"T='N'\/Qho"uOM,Wr>_2pW9`gc3H2oo<B>]A6S;t<b,W!hMemMV3[J@77c[FD5ckBnRrHQ>(
&cVBe+=FMQ13CJN(6ce<,[]A)a7WPM*Wi+eOd&EW'e;66631,\`%U/r'$,&]AVEb8BV"JX?3`U
e<Xs)brCT7^V$l7DW'jbQj+<7`jrM,+ojW7,5,L7_lC9Iqm5iB7]An>\XSA(ppohB]A@DqtoEP
m.Q+g8jcn.)g!K-BsN,RgV)S#BHippU8kB(^<N<;=fkR^]A,^Pj1dJcjqfg84LRZ1G5M+m0jJ
5W1R1@05MA+$;1tHNl@hf<9eTk9SrXsL`]AM7IcHcZkO8&SI+[]A7Q?[:*XWXX8c>4Ps4M/P=Z
kUq[2i1QGS;GX?ao/;nAMjJ?^En)eM/$%?!,[u&aCq$GT2qiFM;^4sFc:XnleQ:8g^#]A!ADg
5RZBZ=X\O3"+"V"Fj$CW+Bm".U\.]An]Anm:?;$+9=*`BJ@XXm'D"dLrj(P.kN9>1;(Gum\[Yr
U3JIZ/'(mU$Ul;0m0jrJY+@^[#K*3F7rrf**27tmi2R\=j5-`Pf@pS+ObF"IuCT(f<.nX4.0
U!=@b^A8'bgLg6'\L5YnYW2:G7E`^^Lb`g2VK^)QhC5P8b81;CCG#2;=TN#QVD2Mg6CiPT(3
uE;pX#rfGI.tgA;uAU>GDKU1.8L%0]A&j<HOTYd[MK^fR?h"P.TU7@aA+X.O/0Rc,FCMkrYPl
i,h#]A%</8M51SGQ>rTu8/0&c"28Z@NV/alU;h[en>Y'%*ug1.(?jM,DjqRn2"7]ALr`^5ntBR
U!n1+VC3i]A:r\#(V+tLmu4$A"Sp&5j13LJ4#WUi=&<&P?Ps4E)H!&Q(>Gn8b7s(X9d*CdpS.
QMK3]A"'^@nGK27q]A5R;49`/5;MBT2UEgYP**A@3ZlgE!iYC>.WgfYg=C$b;>jEXjDMk?['m8
7BC^R?T="?6ID!f]A#qmSH*MVK>%1OpoiJGYC7`dU2i!BZ_O`,-A7Bc1"K>(7VsDuGX<Q+,GK
mfVUWIXmM<9Y.LZW.>.uJk1'k8VaEN,kUWjfL.4KF?N5l/M?&+d!E@ZNVDHs*lK9o23(b8!5
$D0MQ@3A`Y4\$u%9`4.Nkm'ZT.]AZZ%?V%0'm>1bR<^q?VK,gB5WL[G,u`3*kLI#F@"Z#Zs8S
CcieGgP1s^SpB+:R?'D$ln@ESl@s,"?rAS5*ONH"`B`#fG9mkFY",]ABWAKd@E@eoG%baTAeK
:?8=O]A<NhOmo:QW01-&%H$C#i7?\6-'2CMU\tqkVE*LWjoVE=U?).t6MI`d8?!'0<hcnqs;,
7$gjG^7[D.>iY39S!7b\kYlHTPFo`3EU-k!<Pe;cKDUj'p+Eh0F,r.DY%5I`g'%7kXl\S+DM
RNp4JBsMc7.8uA\p7*b=JZt2>7icf.Q$N^ZsS]AYME<@7$OtGUs#R!jDc9h-J<iBgI"k#NZWJ
hn'q%h"BLF1G_eYd@&;NL;@J#F;kKPF_CS)&%2<Z8=1KO0To.Y6SVl0"VD!sF3g-+A:u"-^8
k/hKD3T/N/Kfm32mMSrd&8L,U>S:_BOb"NbMh&*?`?&Q.-un2+=Vg]ApQsNm(WX5?11Qa?RB-
i@jL=NXZ/-/VC-HZfJb.42)NVheSOfPT>>CuN+"%ZB@BWsCdMT6r\b8R'U\!`Sk]A5P.0SS[s
A;0kEs*UJ6/"j\S4n8Z,Wipe$UAd:8^%H.DbF1Xi'Pot%hHY<2fXEZ@VAHthi'u:%j5a+)o8
>&GV<O[N]AaL9edfg6uoZ9XuYEZ;Mpr">+)iG/2$+maq6WQ,FgEUKUa=@8l@2\U`Y"a#W#@a1
\`n*Kl$T>MuTp%p=g8Grt]ASCI-@&lm4.'uR*;cpKKa@`;tqYNSI2F\B6gNk\n9A+%$_?0I7g
"1fO3p2^!5C-3('T.!8qm5Y^!=CKB,%W"e`f_X%N^"$3@[:SDM"WOse"=d_9NO-Gkh[<mTl#
N2dNSJ#JarN]AK4EB!Jn4"@dZ(%n,<$-fhXVeu*Vmpq(B(p9oK7uE=`/2f1$U5fq(lp$j0]A#U
(@;M2#n@#[2#=!^@T<VN&UR";/TQ\TrYde8,nI_4&Cb,%[9D$.b4O.A?3qh;$tc*0<Z4O3E\
U#:#))c9NZ.5Z+n->6"W.n."\9rZE9[<)G>oJ(kIT&oa2CSV1@4?#bj']AB[:b#a?Kq:GPbH4
mKn[d\\34n]Al[*eq:HX*dfiL(eY-Z,F\MqNA!&lL3?jHD.RkL`3$-::'D[_VHI&8hhRe\L:N
[)dj_+FPdM/iGHaLQmlM(t6Sft4_j<W?e6'(n!A)XCE%InEE-.$[?W9g\uM:Hl]AA.XRI)kJ5
/N:+eta!Gk^Kf\g0B.LI0cbmPpt)>fCE@QT+Ko#Mlh]Ac)Hp8)u!@T$.2'X\3,&M<?t#j1Y^?
n_SrT.89E_T*NKSDQKo/L2(gt^osS5+Y3a_%kWNO%jll?5^k1=eM^q]AmT=$ak/l["pafekUg
,f5bRoa\rpVdCreS*gP9p(*+/&n9LLB12i2b#'OQAX0!C2r5`LYI^EtEktYD$XG4mVhL"L!b
!>MO+=mr+jnqVRf5aQYY1L>;dH5]A!i;:?sJa8W93j`h@jQ<"'K*#=>dEq<+(7'icBJ"csE8]A
3#%NO"cE`GR';eRg;Qp(6kp!k7%""+mTG@9"DX'V7D+ILi-u77iuMqks$3#TDE^fD%$^EP6e
0mOZ"K$)nIYMPa=#4Wj50:R.6WqZN8"goj1I!b6qOp./=GeM4E<oDT5=$L9;H\,/B2P+F^_?
W0\>jo4Vm@%1oQ\=SDO?RS4,0ojjq79Ic78)AE.ca$$%lPP$"0jaV.=1#%6<^:HiNUAZog2#
$tbUuO%?Y#VAF`Zdn>3uTJBRKJd..N)2Tb#<&Q(@E9=]AuUZOhqS'GSfoiRfeNG#PS5u!P7B#
'Lq;2B)jHG0mH4-D;tH8n.Er4$=FZ_Ok1H>:9X]A>m*JkjY$*^IW*us"`(=@*]A`DcYKZ;R8dX
dCL&enZ7V9KW([MI2`ZLFXosG)<I]AB+d&R5%$J"qZWT@4ol(jd>[srBHs]AR"F0J&YBgd``@@
6t]A;;[ND0P"#-7@qJNO9pU/!hf2"NUBn#p_JFmdHbbmgg;/W2ONu^SU2A<L^dhNhaV*:Jl7[
M!,di4Pgki9#1r;XZqgqb5o=>+8rK8X8""W.nsEDoHpDdC9$Dd/NdQ$:jWBtg4=ReJ;*Fl=-
DAtT08t@7O?r"LA4O5laQ5(nroK@hT$G+c*amnA\#lN8@F28HH^dNO`@)>i%AP-RA&kq)![7
MAF(4>W==<aD;lD.RZri$oDXFGS)=?kOgj;+SJFT<,lh#6Rr=7h!c`m'>j_oe*eoQVD799J?
EA)-FXPML,Fgl8n\4'9eLdfrM<2C`S2kHbj3J3L2%66,LfC.1r"DH)ILak/%5's_qp0T6Ue&
$"UFjtGcUa!ap*t^,'Q>J4M4k4*/mr_h4F$s\N;[E%M!';2D8Q/tC1TZmE7F4O[rNt[qQ!j:
clO?;PpC8c:p"u\-jV1"a26$reX7fU8[D*aY_[h+#:qXkF?a]AG<ZJXV1$"k'"Y]Ad1k6koa*W
QH*;\Z27[1,,\G,o)?(dobq-oh8J*l@-=^fi7UX;Z@n)3a&=q4jM"+^1<Ol#*#jbBmVnIFrd
ICRk`/fBSnR8nLOD^#MCt'E%AhLc.Qhoj4eO3HP@YBrG86hi-=OG0<dN@Sh8h-ADm)B%MTHZ
/$+nqJ5OCd,[XR`H.s_W$CR(@c5&`pS10&IcDVRmqm7<OQM[Vjc1jQNX]A+1U]AYY,MaiAF@Gu
lbZ.a"QTreOSs.<D\;'l.4CiDJq#E@?bAco4Rj;H_h3N7G?O!``7U'R,$#^="nRup%@i)P>_
7=J7=os*!YG?;e3hLV6ml`WK^:4>I1.i?G/Rubbu+)(Fi6<7sud]Ak(I1fR!K+1&;=,*gV!iq
eV%\_pc'gjGb>`A>#F6i_d1;"U,@A!l;g5N:]A@DhJh7]A1IU8gL'7I//m.'VP302hrr"kpskY
jLL(U,P^qe#[o4f:8XGJ,pJpq?B=t):g#*;>?QYuqjSr2R<Y^_]A?F>pAX<8^#P_);Fb/IQcU
n@@a$;u?]A`qOOCq$U&\9+<F@CW3J<MC^@I9oK_Td$A2R[<>&*AsbINY<57'Rkou;)XP/8_be
kqfPi+>#[.MaZ/YC<%2LmsD]A8l-o"GC/N:B^Od+:gS)r/^4&m;4;oN9>:culn4H9uPq"AH;]A
3%EOl'$T8IMH$9?JGK6d^2M&6^%f@F)"t`1.pBDe!?m\m3W+G);hH9k#8B!]AnIEG"F"9FA/c
nHK62<Os15uV,]AY-@U-Y&LQ&l]Aqb&8I#KP"oQgb(,>?*Ritr;k"<]Abg$^.eliL`&qlm.Ct[X
UE%B;K(U.Oo2ZM\/*<3XckNG.n+rYs92Rb=.r"HWnJ6*@s=FX/+$:^gNL@kn&Z@DD?r%2S"G
\LDJT+$'t!qoJ8@,h;!Ylr0crljDD=E6^RdO>l:d&R]A(-=uoU]A#WQ^$#o!U,W^X9>r-L8qf=
EnjUM,S:t8u8<@=AW]AmQ[b.%c2^kN4Gq,sBT,HU1bE-rZTR7ftch8-OL8E=(-p!j?,J$-65e
GtU-OYmB^W:MI[=(7oJ"JB]A3Ih-BkA3`WF&/FsQqq*4UQG$N"Iht&Mdg7p=[GhB<;.eeRh'=
>q&Q^:KR\TZiRqsIUu-T"'`=iKi9fj,M_T4fCKF8&=d3n$hpd/N7+Vu')u-UtKr=Ou,0\1h\
#iB>aqOP'[#Tk2L4XJEORR[@I>]A8bbcU\=B+HJ#FQafZucRW3kF>YNV(r6iM0!pN:k#AB0La
8co0A-=(0U[EF38SG^8B<>QE`M\RjGqDOHRcaFrmPM='1*H'g.h-Bu!^b<%VV'3!^nluEeQ=
KgY+Mfc;:u0JJWnV]AXiH?0p+C]Ai-2Zqcr\3RllZRHE:"hqd,hgWXc).r%71(-qa$5&sP?gk.
MJ1?L:+U''=3L>%ltTjHImMtCUZosD$Q=G(fh#ku_+l./gE$V%hf/id=NG]Aaj71tE/,]A!o*;
%]AMP0h,R1g_gIUFb>Lnj,_>-;-32_A*9!k0LO05W;;e)-J^ng_h!4nbtEIi6Ip8S%0^W')h\
YPe6buJ@f;)ZnSN%<QU:1hIb>t@aYPRs4Wi0]A`($KM7!<air@pm3g#rV<$2#5&h_ER5P[m=8
#4Q%V%pD_`PFNqA3jO(fM&`p]Alb$gC%@TIdnV3HA86LE@rN8AFOsVhRBMM\(PEQJ[&,a?d`;
Sn1RT&EDm?E0?mt1]A>kpUhIi-kfDTGLkrB$n:2Z2SH/bJXCB\TErU?Z1>Z[ifO>Z%P4nD/_P
Tg/,sZ.,<_K6mo,3(E\gD756*_`7GA6NcDX@a+S[`(5M7LPoMQqs=AaWqs/XB]Al\)4![HWns
QcV`k06*,g9-Q09(`GGMh\;&A.>?Y=%V9X+sr4'+]A?gqB<1$iEM#5%k*43d2M>Rr-='8a=ba
bR"odK9L<*/BYcBD!R=(cB^kj7St6IK"Q>,KEA+TJcoZkE5RBc9?,VgWk_US>#aRdo>UCe.G
u]At=J8+)Z46^""=gIGqbRCiJF=R%@/7g%*5ki2C"W*`Z[=1nkP)hai1)pd3B$KT`fd6t7#Sg
otWEk6gSpouD+@&Vq89+56N=@:kpnaG;P5E\c3tEQt"qVLI,b<'^'@+;k$=2iJ%f)?_#N#bi
bN>?lX]A:#LL'kTO&a%\]A2NJ)DjFMd>NlsON34#O&.V%LF?]A6U]Aa@V"BUO0X3s2K=k<%JCX\S
e?e+_9Jjl(mZ(<6bYK8YbL(S/ibVgXLN8qD:'13@'c^Wl[k(#o"g?jdD$Q9g8mn!k4P9)Pk=
7QY>684h;oC<,bH=`4]Aqm-<)i-0JnUkj,TN1L6$lDlT??#p*_G:8BKfg>Ae*u,rMioLNnLG9
MXr2ojFDRM*=&FB7jMRb+q$Sd?+5f70O2Vl80>YT,fZIX.1f>\Al)[i"k.g+kHnl%3s2_jNe
mYAu$RZa;LQf/+QsPc1EP'D["9"73PhPr=QB()b@KJ4FKFt0K@P]AUO.NrQHU&t'@5V#A1=(,
Vh8Q>a(UZQCn+PG6h18MiqG?E!P"jKk_G)if[HM\hS[-cC`tO7<m[m;'+I4ceGCR]A$6^HR%-
Q3V0_i[EC_9h\PI5N%\:l$=7dbs41<^bl#+u[kfAD;KB5jWMdnEXAaT(r>l1W7+%92ls?7")
5:j<A&#5d33.84_ER)Y3]As4Z(YF<W!H!_<ob_Jc!>6eCE$hNNkWf?te$hrDf[F7_/$:GW73%
[,4XHNi!2.n%S#&@9=gCO1(FRH1g%+s>^*`qq3sQpah]Ad@5jrLG+"q*V4&'MDR0SG!^Re9,:
e/%B-K;B4SIBRQ/>^f#fZSK_IU]AcNc>08)g5:$Mkj!eqJ`@-Z6JgC[Q)Q!%_Bo,?D(cmg2("
9W+Se\\KhhJU_9rBjg]A27E.1X/h]Aa9nW(E.0_TH2-"_0qf%IApXrGW'$Af,r!bUrmLVH3Ori
7E)ATPX2?q3l"rpro:'VSHDL.?T+XP(BkRAY>5Q[fHGDJ<,pT,Eo]A%t$@:'IG0Q9Q'0E!jI!
0';RG6Op&nX5G?*:M8k3`YeC^\Z,\$kBc)hc=+e!9^afIF-ca:Ch6WhdOR#@t/Td!RQP(o.(
B-80<-Z%k(9$oe&h^D(rBW<L0qb$Oe3.ks@2GZ9hLsLR82]A63kl_A9*:$9cc?FpC!RM'9b-;
RGNkGkO=r2d48mc`1=TJ6/M.A="_AT9p]ADfs<)'_FnOX'6r#.FUYjl@O2E\(Xnn[cN*#:!p^
a*FRh^g.*_Bm>QSVu`Z8_3Gr):<!)\JGXo_N^tYS4'S`g$,\!U"K1:?O.X6MJD*f]Ar,7]A=^o
Fm_$'XB2P2E%,%A%?segdp_YQrZ9N]A^WcU$'g.64f[AVUT9qg[]AWBTOWien1`q48Fr,NHCZ0
I;K-pRbBA%.e&:TV_T#et0$ebL2UHE-X%<ga>;AmT=_2Qu!iuM$]ADG!^3AJ$<)5OUG8\mcsl
L?osMnofKc=P8q<W[<K5idct64VNkFFogJ"F@L!0\LuC/&o4C`$#E7C>qRABiaGZT0<pM*KU
S>QZ(i1fk>J6`rK>q&'P/WQ\YC`O1cA==\4b88&9=N([)H]A;\Gj#o,J)l,/>%"eA<Ba$$VGT
0Q_s&*UiK!m0<=UaXL*kI<[Xk7q2U*;UF-s+$,50*\[O5qhJ#VSr8BdS(iCH"L&?A9u#MmA%
GQcht=^[BkZCeLigqF$rWc3=99=l[aQlSfP%!c'BHbS#dL)iI\R*F$\dsjMT6ec2#eB\&_2j
YcX1I2/88(VNkKhVll0k"lj]A-g3<F0#6Fp;Gr:'&IeJR@DNE$@!g7tY6bT!$]A5GQ_\d)d,r<
u`P5P!Oj'h2R<:j0aEVk1^j;@t;Sb`TJgF]AFROI2+WZ/YrWjsTX%HX<7EHRRK.k,;J7D$b&$
!gW8Qp4TMqNT&dnY)\&AJ.TOkkt2FbS4gc7n)Io0o<bjh()#KH+T9E_qH0h&*%$nB5BM.qTj
'd8cK0H0@@$u)h2g)n/s(R^ONj=HtWnSJV=[gP^B(8[#sTKV'3m&KVNa9e;F7jc2mX*5%12"
g!WK$57]A?8"%>836akB+%5Cj+#f+!QJ(N6n!?C*it-9-<TlU09juXOKO&u*jC_MF;m@oKdgm
YF[Bn$iHP7gSpPYLlSrj#*:_qQQX5/]As7>]A.o)A[~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="30"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report2"/>
<WidgetID widgetID="bbff838c-e1cd-4acd-a545-6edd0e1787a5"/>
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
<![CDATA[720000,1080000,720000,723900,432000,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2304000,2016000,2016000,2016000,2016000,2016000,2016000,2016000,2016000,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" cs="9" s="1">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=left($mth, 4) + "年顺丰航空B项考评指标"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="3" cs="9" s="2">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="更新时间：" + 数据更新时间.select(加载时间)]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
</CellElementList>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
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
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="128"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9C**;t^"]Af"\k!;p'I#bB.\tbm\/0.QUtLjYbPA<0h45Q>%u5AKm<Ip2]AGe;A#C:\<*%[#\
42S&VdOWA-c+2(.2C2@D]Ar;#E1D2rc7uC]A6+364XcWjrr4$'+$RP_`p`hSchD_!chD^nceht
D1hG*VP9rtj0P/MoJ%RpQ_@u,>'-@2F+.n49ZLEQHa!OJ>gqMnmYJ*BMk\1F]A2=&tYLs;:<T
O\#Y\bbT5gP8G"(.G<PPP=V`n7qs62!funG!.QiX1_3Rs2U)5S$14AgR=/od^Yp-B/-#3I-`
Y\QN45YA2tY;8@rD]A/EM%-V"]AJ<ms^a5?]A9K_mn1_"KL:aNP"&`&eMVi`n0&2#)*\S+VsBKb
aM:a0k.r+UCDaG$ELgO&hT/mZ[lorJeYm6g?/:L_YE)73cMO'NdBi]AOD-M2+1=FLui\$;'QA
VVnaUR#'!c80l,Y/U<VC]Ab<A`VS'pW-[q7UH#ULfeHCm5+!0X>Sfo8eI[=F$=s,=7nmGZ,`d
nA-rP.pgA;=YY6fr:`e@D'>mVmQPSc\EVJu_llp7a/t"OJ;8$58C57#RFSY8A9i'lLC]A,$>>
XrgXOkOB+O@Vp(np%eTQjqJ1je5W<9bj6+C:[r)LKqm$-fa@dZ(f*/JLZ0)Q6n@TBdX/J"`A
.=9Or7c[@bM$)3$0+U-_tiOHsmd$-1\I-4*c,?9YFQCRHQG.+f1m32<C]A<lW`.><]Ap.b4Y>"
%TGW!XKP"MAb:4"4%H:I:e?ZQYb"kVP,#*+$!5FUo1Q[YoiXFmO2I5NlR^btp"=o9CPMrriA
G*GTYOpHR873P:[7U&/08K3=:SaD>4_9me;sEkWZ<\_0)G,LnMmD]Ar%k%u?AM@Xf$;=/)$'f
Dj6Q(U^p.$3\]AQK'.)ab/VAOfI&u:uMRCuUl<q@eS2t=G1J%]AOa$0g-Y_)5#Xek4'CcSKLUC
N^C3j0mjhfchP0O3>K)K.ldTI*5(nPpm>-rXain)<3YQ:Z^OPn-0H/6rf6[Mb,@6<=7DX);R
oMCcC*o.^4#L;4cs36)V&HDL8-9bM[eL'X'ZHN,Y?Q"?lObCK00SaEUa.DW%p'YD";`R>ZC*
ZJF5U`RC7Vo_"_fn?bAJ]AMthrGF&Oe>u@&D@lqS^;CL64I]A2^TBq5mA[@$TFrYk$3U3`U(,!
kM0Hc*l?Ep8ES*bT2unN?dk++<^e;P=VKI**GjDBedU0;]AA([]A[r3:X!^hh:m!a^+knjG<F8
BAec=tX3GAC,&2ia:?tO\Lg5GoM29G^=j&GFp(69B`(QRS/GhAup)6-IlG4*17C<Jc`b8pO2
Qu1[%LM:iIP%m>$N`t)<q=R&N_M"EGr*"$)?B,)q@\/"h36%(U+^m'WnW(,5Np>8lFk>V$sM
dP0-#o!9X!J\I%UDE0gH%%iUq^BVqKSSi=X:Q4Dm4!K,=HPCP4gT@0OU]A`D@?]A!e'6f<qG%!
V*[U!r.)a\b:;H[@mn4)iWQYd>Y&Wnk@pLaRE]AuGbWdaEOcImAI^qgP-O]ARYEdE1$I;uFkp,
Poa:YIIaTGcVb?78_a`YTFS<('b"K#!A6nb'kg5Dc?WVE!s#Y<@hKf8oAYDB<qkd)"mb5u3&
j'Mkl2WM=+RX(@u]AE'Vn""+L*g/M)Y"hHa^T?(Muc85J$OhICoDh"]AC^l,LQ)D5J+lBq_G1K
q%.KICn*X`8$q)]AtPe.FtATIKo`*F9"GO:MHWEdSj"ff\U?(in9FTZ<o:GB"7cQcE;Hu;\#d
XpO(FpKKRNi@7bcHVl%uHF&!rG\?b`!bLVUQflJb&qZ%"')fAq6a^Ug]AspIsM:oNPO)#P?p2
Ch;c;MUhT/5Bs9D,#j]A'>Mcr(mI31kkY7V^JuteTgeTKQAbchFJ#&YWK-p_`^k"-dG2;\4<<
?<Fi%b_D4.\Y>!8f,/.]A7$MWVj\&5K!KK"jsXSAJ]A'4D4f!>#@/YQ(Y?=5*.pug2RpP+7o&d
52'!n+<p-?n/hqfomU!U)J;$,AjTE33E#=R?I*<4ba^?!=^<&/mN<[*()R(q:c5nSu?cf]Ai=
pr!%)Bf;e-33lb-]AMgp`bVt%,p3S)B*Mi"it\REh6sJ<5p0#+3#o,p*T\F)a5Isu5Y8`7DHZ
8nE0bKhSBL^*QYdtNX8VU%1;[CELUAUOE)hj#:pF$Cj33S8Q>MlTIQ%G9A*9U2"VcZ$Q;?R&
N1W/R(2gmKUJu1W*FK_,#(tW<Gaih.r_TdcLeB5UEO=)8$\"uoN"+eDk4,uj[Fb$c)S+.phq
YJp%VOuH0WoWAfn)NcJ_eW29B9$S5lRc,7nM#5DF9tZP+LbKkr2EcJ'2>f'C`SXX+GTFV#W#
6&FT!<A)fk::MBE8N56*NWuubG(50%?:ofl%l:ao(+Kas^W"N<tCgbf$7R`mQb``BM#7/bGQ
tD@4ULuT6>on6k6X`OGEA[U8A6rgLO$dt"*OCu7IOqZ+2HZPkFkh%E'N;n"4t>#?3G_-Plt:
oI)#CdoMchko4lP`+Y/+j_Vu2:g8ULi(gE=%'VL!^'6[s/8O/!>T`VQNjO.M!,Rq<^I)"AV^
n2aiL2_(sZ@$Uo7FhF2$?Y4%NFc1MbqBomq54Y+-gKAkQ8*D3V&?5)AX"-]A>7U>I9paU"KT?
:f#=$5dZBiGFKTMnW5@Xg@(NkkKZ0JgL9IG/u0I)->Qc!@BM#D<,>1J\Po5[!%^J^&5hRXEE
(E#6%"QPaW^#J_>^]Asbuf;D?<Gf:@jak8gaDbn%XCNENiDHup$dArrii@*fa_a!%A\12ts_2
PGcU^qT[i0;?a<K8l^V\]Ar.X"qi%Be%Hc/YA6.]A(QS0!0lE]A-T>&l'gdE@[(IW'K&'nP&/4;
k>@CQAI3&[YH42ADS.m\%?ii?lj7WuOO=0$k7;9aa4J!4='L@Vb&PM848K@[lKXfZr8F[lp]A
+o<"o#,e]AG,R)Dh(bt\GPj**jeg$0i`^&PP=DBoX<VF-W8H(CHhR6E#W[`saCAQ3CelO#;]AK
P2/or>Mjf<9=%&/=kgpHrMW>b1Fq_dk2&C7a^CY+#^X.[qh/Y-\g6ctYdZ:dfVF0/MWI`=KT
o/Z(:g:dLLJ'>6Mm'UYOS(Qt7$MXu\?rfD#)k]AfIp"L;uSXX*#,%iW*`bPos&8H]AqCm%@d\9
jPKXUC3Dm"K<#T8jp)Q4Vff2JAa=WH7.H<MC2L9r[+\^#C$(W+V,8Lp<@,S<R&&e^\9WlBA2
'TJ3K/>QG%^!q9gu\5<lju#3?UnF&$gWNcGJ+q?<^GaESmiSKQIWpk3igg3if+S(4M&Oh<X$
8a=j)K/T+,f`O.(r>QCu<:MqnW'_KE(2o7M\,%^jJkWYUhVLs^?RJ$$AgqV'J]A>t&hFYoIK7
"S19s58N(.(m[23U84q(s+CcM$fg;UYFVi:-nXn4!\N$ajC8NZ-9FVN&WaamQ95,hd@SJKQN
U*%Q5BTW83p$1J:`7]ARTnE<a0ne:XW>PTli3;arP/<VFquPK=`r>7UVb6)u^Pqbbt0Lg"&H?
c4cCTKNu9i0C7e9F_u'MZ\b\$jKGsTY.gj@bp.)NFL-u41,C[jha,ndt]ADS9ME#6KD!lI62N
[&[^Hti8dWp7W6H7/`u&cj*l^iI)^Q_0Qi![WgqGK%LP@#?g@1JSLKrI%KXLl$b#mtjElDBR
GKG"*M7R`8>Y!0`P%c;\CT;Wa*0S@B:%]Ag<Ub9WXq35cs9'(RFH'+arA=U1tG;dTU(\`BbX*
*RDE-?J(BIqMK\lr*L:jjL33V66/lW)g$X-ZJjO4me/eIe:>^q`l-a]AQ!^o>Uc$Md<T7d"K4
tc&oXE%d5"4f[;_rq?bo-ct<\*;:QRE*'2!61O\>UQJ::4BQ;7B))\/o?=KfeGB2Q6R]A:1X5
>B'MFKLa'_\qc9>_-^2ok-]A@rIKh%$D9>ICD^`2(,Rq(Y/nI194WC]AP(PH%]Aplh;'4hQT#7k
(2JpK2EpH1Z@rC8N#::ce?^!!@i4$p8UFj@/s;E\X=da\71gF&K2BuRaL)6Y[imKOQpZsIDI
`JNj\Ff2N3pKD+Z%'DsM7iCZ5)Z/NmhU>.mN\ZmN.5?JjUL[R_BM2s?<^]A*RaHPW`4EtRH9G
/YdEEOW1EaXW[4j<R\Gh2@O*C7i"K9Zu8#Wpa8lcbbaBrT<R(80"me0-KgZ<A!Y0[/Nr#e\u
"@]AJ6\7'SlGa"Vl^)u@Rem?PN>f7h%pMdj6.-%C(D']AB5G4iS487>A8K&1Gdrb,Zb,!5@9Xn
?$)=AdEp*UFdm)\\f!g%N?@3S;*^;]A(b"I,i*TpZij;XV@Lak8!TcDQ^1M9<eDk"!7TMkUZ@
WW%6;QQEiYj>F.;9Ses:1d_a0:b1^Rs3:1r`>"XFO!KVI!G>@ToJ1W$j_PTAY*aW'WnXtZ5%
QLq/-%G+X>V@LjE24^9G5D/c&c!J6f^mR48.r&YY[eq7U0P?p@HAmgAEQl*YD?Y1NkENOR,!
YKBnBH!3>h?+8#(->"?7PWJ\rO8M27umr)]AXtK8,Q[UX.N/W@kj;'URE\6aEDFhoCe097!l<
\<Q4GZrON7rcM@F_M[SK'^-\hBZ5RqcK*rWlpDPMbJLk*SNja8tjQSX*7!Ie41Q3=8`04Ybi
<\QYSujW?WcrV,<&u@MfD(nA%N01DnC?Z""DJ<:.3V4kI^dW]A(^SRY#^cI,J>`03"Cp$6,&C
f5@035s0K/lpe17>pbFFO-GMjlQ9fQDbl>B\)`/%`*X35K&$,,DP;^O#H6:=e?bS_FUkRMm>
"Y/B1IfAuAe0"Ksk/m@d/@(W;k?Nj5rtEN7,a4ZO`)#bH?1QY)`?/2[f1dT7a!A;Z?bDQMOe
XI1A;\/\3Yn%Bo/K(F[r#l1'b9Nt-H"e&aK)=l+@osR,RaIc,VM[?a@;WPCbdRIdk8b=/"u8
pf*<)ABd!HN)M(1X!coQBfK.AiGN]AB%CT4nr'6s*bEnRb16uk7__L&'1i+"bkRF"E'Rl."[f
\*M3>a"2+Se(LMZc&Vj.QZBc8<Eh4r&ss/BOG'1#!^aYnQ/%J-"TdC"eMk3ZRlBo*6'>BS5[
74?VqI,M[@gJg*65j@6UNXHCamJJThYVc\)]AJ,Yf\m7jGW'W2POP\dTiTS!kh!0WIdX'YY^%
bqusi'SEQ-^Y7,Gb.X,pb,A,/D\jt;`29rXi<EHe2/J$'Y4M%PSgbc$0Of\^I"Lig,VO.$.\
m96K@63F$#2N18l66NL^JrsDr4I=SQt<9Y0epqSH2ejGT7F9pO>Lq'_b*IAV5Qd#REZl0"&K
Z!XH&X0C\OL\S_BflfHKn)<^u?F-^REn*Gm=E\V6YGcg]A%CHGaQkYO^H+?\MEoOX>P]As58,I
_^8t+Dl@YN7sQc0kg2(^BYeD.hM%`)f8PcNj<EVJ1;Q)"!/.LAX%-n1?i@'\We;5:>F,gAZS
En\g_cT[>;MC$Xs`iPc\MC9DQlEdt=hWmQXq,cfsbFVVP*3%Enm=`bSAWRKSb;n#75o5F=K+
EQrTT>^;A;qXXq1@47bXYY`bGge#Lt1$PCuX/gW)fYu4Z+'b\f64We"R,)OQPN.J.f#i@+`K
OPARe,+OYIaVeYknB)YeJ24/=Q-n,b.]AEBAdF5j6(@W=X<[[Ku4W9k+!;Zba6"KT%D%%OV!2
ioL?![3U'tA%Il]ASrn(1!5rq]AHfNHOBWTi!s-nVKaMbr3g^i)`A+t6_T\ut^?/4KqN*?j3ml
<kZgbqRqVKQ9$!JV`)\Eo;p$`2ZT_-]A,%lQ;P+8>dL_t+u%/L,<C[1L)[[pnmshp1T'soW%U
j)-d6X3>Sh8T[H[?1?FH1B&Mq!eB@Z_t+:#RS'0'P%b*9#2N`UZq9@d7+J9lJ.Jda7$b5Hk`
Y.o#p*#b;cF3Ft(aEO!s9El`Y\On$eK(Sk,KnO"T0_T[b&fnuphAS!@Z;[6Qb9@I2,mMC*:P
M9S!c3T8&GS#m5sE[C"&uLee"KA#X2jDfMO_/Xb5m']A"3Lac[<7FYeoY.Yfp'U$-f?O)Lb7$
a(_*T6+XS<((.F.-QR#]A:[<:#="VaC]A:DLntX;4ap'=6Bt'/gTJ.cGP-@2R]A/CT=!`fe7&b?
\1IK9/7``?,SoeT?#nb@68WkcZ!FiY]AGuEYnEL*s+g<=lEX]AFZ5[U`R(mYnk?(Vq%@#i3=r$
TQ@6'_R,3n.+,1>3`&S6+\hbI0cpK">q0(TAS8j`2ad[+FaQ_Y`m#gHP2C5Xs8qM]AAI(<nJi
L2U;'eGO1*4tZ6Jao7C\Anh[[jK*?<OI:83QWNP$^PBi11$Ms$P:"!0P8otTW+b9B4'9-Gf$
Z51nW#$noiRRN>FA-G<hblnZ"n!ZPMS&T#3<@bn%ML3*31dJP%p"h-QhR6D$hS4m#Jihb?=>
Pd\2)&Cbm[V.R4cmB'nlH$($1<B,?C0H6#,)F05'GGO&rXebFnE,ci@)Q&I0t,m$S\C,5!8$
gBplnQm'bk&=#Cq-(*EjmKFs(4D4Kj)c:bkX8<?kRS96d[FLYYqRlS@bokf)@V^"_o$D)KHF
nND%f:\o;B:#6A&OPo7Xs"#G@&!aI4RQaPUluOZ!O+eTBUm;'i2"@9m2A/c17I:0!o48(iKl
=\MR0A8S=WS^%fp.r(K)>'$qaIf)t3[O_`+QQ_XSTk,&SPjXb'@;;]AgqQ;0C*g=Wk7EWNl7t
'GMkdT8Vr?'Sn.S=Pb&u>2O8j9&&m"t?IAJ5Bsg;u!@^hX_hKN"-7h?Kt;ka1paq39?dI2j6
N@pDnY*N%]A,r35aQn3E"3mQFoJ_A3b35^GY.M8/,$m"Zm4l0`de211S0jOZ-MS1(*0jPQAP%
aO\qFqVOtYdMK+SeSm27rS^`Eolag.ma5K]A2%#IZc)d:2qm?:Qn%l$5igcP*Pn4)d+JVl#$4
)"O()#5Q$&mCUo=7?R3%I/*ldqPQj0&Vh+=2*lEQb[I^-@^%$Po/>K,+<#?4E0rC\G?X^W0s
gt8;'[afl[W$&A?4O/=-`K<u5+o%L$2G\%Tf;,H^X:`fI&gf\Y;/oWba+0k<+8SbTd^'R+6o
_X%&I4Y)4JJ9^0?+9R=<Gqk5LsL>5S#]AuFf$C%&3_RP^WSEBRWbdk[?CZO[OE.R-r)59+5GX
36a)(-n^L?XZdX*`ML.5]A=+mF>P-'Wl$)m?aC:!;5RR2bf[K!Z5rEN'%U/l2Ija`aCXEH9K4
%+Fb"6N_1coUCeFrM_5Y8S6Ob:#fsok`.fIcs83N,$s'ES-:=Tl2rn>)`(Dj\(a^Lr88K]AA>
GL"P1.BBS#/P=*4V=U6r59Yl(PTB('UIeCu&iP9nFE1BDfE^4Hf3]A$N0[B:a:I_ar@#S;stP
I`M$j_rW<R;IOS/^+;jc^.EK+JDG@#?V8o'`F`7",R0r9HlLi/f]A7oW"DLW0YB0Rn@n&Q;,R
>u@>2lr9^QaDPg;aq;lO0jYl3^dHG^:CE.b/[`GkF1""S#uWj]AYn1Dj<qF4[/\sSjUW=WAH*
Pr-ep%lO[]AUh$A`7be,K-"pd7`,gc-2@#J5c7QjEC80+&lZ%@1755YD\/[0;?GC[<lY:g*NB
nsM!X#Ko/G8&.,[?kERDKs84cO<uuYh]AO?W<-jLg_nqiJ+kJFP5`;Q>PIYL`9ab?L>0YEE!)
?.-JZ_@$10Nn*1?EO?Poan>h+C64UW9(RsT'KMidd!>dN+gLL;HZN9H4O'0XL8/i]A#!GKjpL
01A<u`k5@K_$KVqNKD-YVtLOW/G]A0c:XjJks.FICC0=JS@+gC41Vqf`qp#EWF^3&,Mk_N`1=
l)'p8TcjS7)DT3QcJ%?ZR75DY_mHha,%ebLH)DMEp0Ri)QNt<08Wr,an0LJo\sjdC6d&pq_=
+=%I[N8ZGthYgXbsX"(qWBt^_La#)[D']A=;"Y7I'dZERGUjB%rEUu)odle/8ph[K3n$"Ks(&
sb3Yr9c&T/bPgDQ-$$%ieAkBQ]AQK.\.tgPJumAf#CrcZYsmJ9QcVES3o$?hVZ=lpb""<kRmU
hLei)=6rZ+"'MLJW*h13qHC7QTE^H#Ppo&Pt?PhqHj^4-uTm3[oR1Y'[*o4"$o^I%"L.D^J*
WDG%\n:4^&Z#S:M'Z:9q!hj"$TQ$D"6k@8dSq^@AHk^YCGR1fsU)a.2bT925pl<X(YUM"R)&
XZ6L''QMNa>Y\7$_L-c5oqTi9T\u.+<Cj<<]AR_W8TjlN^)%#O@,&',Bi-#;5d1;RQiQqhG$H
4J6preSDE$d]AH<69&D86TPAtYua/*2^"TER)N]AA:"Q#4PZ2^:ptDYjIQqc<'5Rj'0nKBBG:?
8Y5"`EbdlrAP'EjAh`s&2RqJBhJpuji1GAKjk]A-ZhF\1*5B&KPO.PGkbd)pajiDEA.8J+l$W
6BM#I=#8:Ye@;>DnU\/R5dSaN^!0DKi7QB$JfR`\&.5P*m67h"\CCK=!E(-;:D"o,uOjGs7"
3,&T]Apd3Q`Vi=E`bJSVWh&Pp.-V=oiZp0%iA]A6`YTP//riIZqM9!Y(Io"BJEXa>q3'qrVHGp
mW/lFRN%[mOdA8Dek&`\26sIb&I'4\[N&pYu#5Lrjj53_A-:'.&<gQH!ANNe"L'O`MH[#oho
LC`Ds7hT)4O<j6GNDK[ro=,F-4NIdRI06h?6QH6@5?.+kP&o!fE&QQI_ihGc%i@^1,nM_5ig
h82Adc8(K3I""?^1Y.W.j:<#U:SAA-Pn/re*-!b>'5jGpj3Ye/9j]AU)JU:S(*>RjhO^=X>0u
Yr((tH8BATu^hgQpIEtn<=oR/qWlE7B7\FhQS<F4APe\Apn:\1pb2;G;dFE*(_2P6pS/pVN%
2)7akUHC9<8^fBLe,6(Zk;2PjrH*28*CM[4?O?\*f67_<=)E,!*9H$'aq3kho80<NjIVuKIQ
i!fMlQ`IZ+fVN8Bg>'/Q(MJ^[G<.O(ehNniFO<Rm1Q80:PK0EF-k1Eh$k$h*U3Y0uG,@Q&Vu
.h1XDq;XsujHhX(92ca!)rb1N:FV*t<[D7IA#L,-NmJUVlG73@oWO;EB(.H;g#=^K*50iG_E
\FTl/)"*qVsd4ViDOZpl<6g<YYpD@l'*R[0PP<W<\BTK31.j&c2%1SmnR)H<sV^`6Q#Y;T3f
K=<<%?ohB,TJKh4HIK?RkUBe/ejC#e&A%e1=qdVWfa2qe@a2i`E1dL<Z[Y8hk4"k8a2bX&fW
P;errJW.pO<;<,?G4?Va6I,=6Q'$Z8YV5O.W'lodL&0\*n3O'dNTc<#]A+iF\Gdq%QHUih\p8
,%(*R$-90Y<"*lnK4&2df8#qa/Bl=?HfY-^O)tMB$EC%Z3M,#-&LbTo'7^fm(rNl6IK2S&`W
<@/=F2Z\=F2f7@1<3?eOH?\ff3F)Kah&'tMI.)!/qkP07Y*pH/N(ei,Smp;*N?;_-W[7cWDo
d?QK$R6F56=^KC1PVW_Y!MlB+\S5DZ5#b^U7U^h28)Jh&K,>`P<a*q6+S,R&AuQhjMpP+b#9
@=[:80j7ct_cEiN=em/JrXs)c^Vp@MY9]ApHqu<RM^!N>$Cq?c[W7G7:)^!6Se/$@d`Rh$OQo
.+p=a]A]AbKAKH:@GXUr<K&^$T!oc`+7A*K+R`'uSJAGTL+S2<"jeA"pWiQ.8TIrI%06.-7j-<
"bK2M3p!c\-CV_+d07)>"L&NH'i8rV?=`pheimiI,$VSiB\J,:f!"mb;CB;G#cdUt\^.H"9F
.*fas9+b+tOk+-7MImt\=a+'U7L$/&/JO>,f$'*P_UW(.._t@DrBLotB)o8fI#(jR0Wi0]ADe
T4ep:d@/R!`@#O6%ARQhQUpPlq#%;aJJu$+Em`OL!DYP_YucImbufjn2SS?B9J.a";le!;aX
Yu:@d^O%76j6`5@me))X[bE=dR=KLOruL+FL\N^8FCedj3Nj*Ck8C-&*R=D&O"&njX5#!Iu4
b@GW^`AV7Go5q.Z]A"d(um;%O*FKLME*<&NJP0qofqk#XDnmK>^P=-sW,/n0TJANdHdcegH=]A
qPe4<[]ArnqD>pF&,_p;@X7dOm>P,lMRPGEFQm(dUrmK*>(.Kd9MIf^u[gHgPg*m*/9U&ks-^
h';YKa5uSrD:m;*"[>\i%s2J?$s7U:$@)Cn?Z4Qj#kh78VB#<>KiJ&KWpRGD0(u5Q<&)"45n
D+I(-uV#]AOFm\0L;s3Q-r)'D8;+>3UkLh2#8%I#g3q?MLLDX;=93?9.`lBfMB!?[8\jsQM#5
,Gnqd]A`0HL,FMr@d.D+jm^+GrOup]Aun8ctdn\^,*K80`R5\ADo<[!N_3S'N=bp+<;@[6DY)K
NFCUUkaf4XcEdf"VBU/C#6C+fdsM3@(q!=k,G57:,0WC`,WK<3)%""+bGaAX%2#(`1kuPaM6
,8tpca!;h7j-";aE_gm6lP=lZ9,\+O?>mV=aGZIr7B1Ha@AA)[3UH?>P(+C/R<:U#\'n8%Dl
ZQ.3i4=,WEQS]Ag\eC-<4^.uHKcV+/_Z1(WArq7.[AH0Y7BmFESbUH%-2m*sUlVHj.5C/T/"C
%$qX6r3TuO.On-R";'8/_0juj1dL)mui*5s3!%MED_J4km5FhIqtp\KfUs%mo4CWBqVgofG!
*+ng59(YK6P05U2jd[0onMdH,_,C!EL/>I,f#<HZ2qLMlcbiWHFu4,(k/8n/%@Zr?7hXimGC
j-g2TIVnf-?/(aU<<_cKNsE;AP[CU@.9Mm!@N?WbjQ\#,5/)^q*B98<Epmk]AfiKfWZ5hQm`V
RmIW01Mk-0k>$O,IXKBXfq;mg8.&i&`_TO9)pMqMr.]ABT[bgaCi#1+\9b@ACo55cINSV'I59
\e]Ao8M5;i5L!PRAAlRPh.?.QHp2)gu?8P'H.QF^=^-TW^QH=T0"Wk>Vo\CEQSVI'BkpOq@q]A
6RPkAaZKkVc.5n,'u;Ud34d;8-u]A)<krD-kY8Gk<-p,PA`u?G?ND):3pGdRTA7/RhqJM3DeJ
(t<k@SCnDgGh9^AVr'a!/1h&Q@L%$(Q/<ImF%Ueqb.<Xh-ZAV&X!LB8Qj<q<>Fr<C`F_E23j
c\o=0lbBg;?Jf%<ch4fVd[`Xo\*@jP8%@!soW4^JCOe/+6(3C$gc4MY#)!85i8pK"joKbTWV
.hJrOO&Of80ZMOD%"kRpKc^c&olg;q_e7J`L'T'/;3<]A9c#:M<THWf:u!6>=qo?AJ_\^4J2d
UAh-[U3Wa1r^;/hu.l0QRULKKbMe>,RQf<BF`QjYGq^Y#k9;*E@YZ'h?O\9`"r:..G\&.Ihp
2Q*:XonUHCo+!%1S-d)!-X>]A3nH<HCcfk#/!V"R_JB<#;XIg8_UT3,KT_3RDC??]AE&Vb0^C7
Jbj-X!RBH3.Vgi!VMS?s#D4W5SG+H5)8LHg`NEo]A.feEIAJ)?gL/(sE(*ZU64V7HV37@]A(/_
n._3fH(Tr;FgP+=+L=Ms/N`j(F;Si"ig>#/U$(,M7KO9l'tb9slJ-B>+qG=A%raNYBb@U.N5
T[KgQD#sG1J0;a&hC(RDA-,G\"9Cc#pU6J_5Zl]A-EC\X@X1Y#=htdZNJm`kW8;.RrI95WD',
[W"M<r:NEo&!tfUM+jL9o[3Xh7b0k.8MOZ$-%QUI>H2C*"RINf]Aj%4O94luTrBjs3,L/JNX9
oR5]A"OrD";qK>i2`:4D,ZS'NN6t(VF8m0ia;L6.q6/K9"r5Qs!2l>Jg+qtTjQQb!FM(^WZBa
,ui'kh(6[lon\/;T_J_pYaiu-S,Y_H2B(EQt,X[%"\s1+F5qPoP8BL`k/mO7Z)f4L)$F8us\
H`+h/41i[WCY=ma1g_%jS66@G,$*mcp=f2)?be=JOP9?1^C]AQ#Nmm!K%`CD<OJX>-K9guM':
<i0NJ41U4@`ILmY(ZTqb(]AZr]AM%f`8mZ0H2%CRR2+35<2p(Q!7a#PdY`aPZHl8J*Jte#A#Ir
oFp+MU#G?^a^XZ"BbK@dV*VFRKU_R3S'5P]A&k7PWl:pu)%V?AMcCf9JZa&;7"c[qsuCIkLe"
ZHnG[hu=g,GX`Q\\Yf*a^,3b+GB3;OP(IIVM"KDE:cW2.HJ&Sep^!ipNMd'.13k.2l*Ij&)T
YWTZmb*hAn&+$HVK+O5RX7X6VE@p(-M)\'i8]A\4&=.O!btQS9fq1JPfV*h;\'Yj.<Sm`_rHl
N@-d.#QqGlI_gZ74M\OK0u]Ah.8O$M0r7<7$,^,\WkW'#h6_39_\YY`"M&Hq&iSRL.)NeBUq+
@U9AI_cZ>\fiS[>=@[JfOnfG2linh506(Y<Ir)ku`U@[Ag=e^Xf"Od7FA;67rWTjupuNn;@l
7XjrGE9=tC&+i5ON!I79AA4OoYLRL`YMb-$AGlWA,V]AcbiRBJ@t/<0_3d2<^YfMXXS64In=r
k:)X)j\a`%q^9#1lO_2Zn/`/>b/*NDm>%VXhSTFE?bdO+\s$AOP*ggqmpZd"[XI[_;M]A6Z3/
B/V$Qg.4=Pl-jl/lX+F/ZT&Z<GBe=+LQ+J;+8]A3c"r<,FGj^@C*aMZ'u#XIoBW@K8GCVU@n`
5://,4OHt^Eh#Dgmfs'45ihn69"78u"_GU51P0o^Yf!WdP&<S:N.ih2I(XT^0*W$;WWnt\,6
Y\+LpGD/_*0N<?ab,GgZgE)Ka2A84T#uk(m+>rJ-k;al0#q@F`Z]A:'b([mepI07Vfd:[]Al^8
;!s)o27%NMH7FjK?p^J%@f+jJLh)H1u:+^ptZ;*nWW1b:Mb)'sG2urGt6QZ,Aa*o(Ac>h6s\
P)qcbM+]ABI#\?:ALg%LnX]A,b9G2ZGnOc2E_DM;ACmBGW=j5_$,>stG.UW``W6Or(+#o@)=1)
?9j(O222B.1lrKkDEHOJihJal*<+1;q1]AadCi)Mnk&BIY*u%.M(18]A$($qPMW@\@:m6`\*:(
WJ2#;o5f9@J]A9SIgCqoC9a0Gpq@/\)QP5M+hc,>2Rb469Ma=Q$Ld5TSBrQa@k0e7A^X,Q'e[
NHs>DC5:0CUH:$<9"obAKfo39)HBLF>-oQ]AfBcqi2MaEON(/EW@&'mUt*?7_<&FZq#0'FM*B
HL;ms*kI>?Y\2j&mr/NIl'SF5T9O/!VkTqHX1iC+JU^ejnJ8GQ:ilJ*s#HeU,F+"Y=ljG3Ye
?j$OgI_D)Pd9hLAqnF.V#F4b"libK]AoL!BGtAZTWFg$m7"o$@lR&L@KVE:58Jud^6^KJY$cJ
?k6"R3MS3>T^9OoW'\k_FH[.84*4YC&pfZ5Crmbm5+=$;$lJHH![)&QWdNrLfm6PsO_!,8jo
8qiJ7o3]AXjC6Ol?)RYuogl1KB>4E9*9Lm(,>!/1'HkN')pQ6:>CdL=%2FR1Wa6?R8BKW%WFT
lBL2K27In4<Y)DnU^CJX'G67qA.1^'N3YiN%*b46j?rJX7_jkRBoiK1BjIff_KE6qWn<74#3
c/6K/o:?fc"B2='XX]A`("+,-o3s3L]AK~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="30"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report2_c"/>
<Widget widgetName="absolute0"/>
<Widget widgetName="report1_c"/>
<Widget widgetName="report3_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="1"/>
<AppRelayout appRelayout="true"/>
<Size width="375" height="558"/>
<ResolutionScalingAttr percent="1.2"/>
<BodyLayoutType type="0"/>
</Center>
</Layout>
<DesignerVersion DesignerVersion="KAA"/>
<PreviewType PreviewType="4"/>
<MobileOnlyTemplateAttrMark class="com.fr.base.iofile.attr.MobileOnlyTemplateAttrMark"/>
<StrategyConfigsAttr class="com.fr.esd.core.strategy.persistence.StrategyConfigsAttr" pluginID="com.fr.plugin.esd" plugin-version="1.5.4">
<StrategyConfigs/>
</StrategyConfigsAttr>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="ddce3f94-45af-4fe3-9c5c-0fce7ef88a58"/>
</TemplateIdAttMark>
</Form>
