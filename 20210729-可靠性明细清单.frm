<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="明细清单" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="mth"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="yer"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="jx"/>
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
      a.year 年份,
      a.month 月份,
      b.mp_ac_type 机型,
      a.type_val2 机号,
      b.出厂日期,
      b.运营日期,
      b.机龄,
      b.司龄,
      a.defs 故障数,
      a.defs_rate 故障千次率,
      if(c.故障数 is null,0,c.故障数) 故障保留数,
      if(d.故障数 is null,0,d.故障数) 故障open数
from ads_sh_me_defect_report a
left join (
select 
      distinct 
      ac_reg,
      mp_ac_type, 
      date_format(factory_date,'%Y-%m-%d') 出厂日期,
      date_format(ac_op_date,'%Y-%m-%d') 运营日期,
      datediff(curdate(),factory_date)/365 机龄,
      datediff(curdate(),ac_op_date)/365 司龄
from dim_sh_aircraft_info_df
where status_name = '运行'
) b on a.type_val2=b.ac_reg
left join (
select 
      model 机型,
      ac_reg 机号,
      count(*) 故障数
from dwd_sh_me_defect_info_dtl_df
where date_format(date_found,'%Y') = '${yer}'
  ${if(len(mth)==1,"and right(date_format(date_found,'%m'),1) = " + mth,"and date_format(date_found,'%m') = " + mth)}
  and deferred_no is not null
group by model,ac_reg
) c on a.type_val2 = c.机号
left join (
select 
      model 机型,
      ac_reg 机号,
      count(*) 故障数
from dwd_sh_me_defect_info_dtl_df
where date_format(date_found,'%Y') = '${yer}'
  ${if(len(mth)==1,"and right(date_format(date_found,'%m'),1) = " + mth,"and date_format(date_found,'%m') = " + mth)}
  and status = 'open'
group by model,ac_reg
) d on a.type_val2 = d.机号
where 1=1
  and a.year = '${yer}'
  and a.month = '${mth}'
  and a.month is not null
  and type_code1 is null 
  and type_code2 = 'ACNO'
  and b.mp_ac_type = '${jx}'
order by 3,7 desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="年份" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[机务体系数据源_10.33.2.25_me_enter]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
      distinct year
from ads_sh_me_defect_report a
where a.month is not null
  and type_code1 is null 
  and type_code2 = 'ACNO'
order by 1 desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="月份" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="yer"/>
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
      distinct cast(month as signed) 月份 
from ads_sh_me_defect_report a
where a.month is not null
  and type_code1 is null 
  and type_code2 = 'ACNO'
  and year = '${yer}'
order by 1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
</TableDataMap>
<FormMobileAttr>
<FormMobileAttr refresh="false" isUseHTML="false" isMobileOnly="true" isAdaptivePropertyAutoMatch="true" appearRefresh="false" promptWhenLeaveWithoutSubmit="false" allowDoubleClickOrZoom="false"/>
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
<HR F="0" T="0"/>
<FR/>
<HC/>
<FC/>
<UPFCR COLUMN="false" ROW="true"/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1295400,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[0,0,0,2160000,2160000,2160000,2160000,2160000,2160000,2160000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[年份]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[月份]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="1">
<O>
<![CDATA[机型]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="2">
<O>
<![CDATA[机号]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="2">
<O>
<![CDATA[机龄]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="2">
<O>
<![CDATA[司龄]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="2">
<O>
<![CDATA[故障数]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="2">
<O>
<![CDATA[故障\\n千次率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="0" s="2">
<O>
<![CDATA[故障\\n保留数]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="0" s="2">
<O>
<![CDATA[故障\\nopen数]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="明细清单" columnName="年份"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="1" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="明细清单" columnName="月份"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="明细清单" columnName="机型"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper">
<Attr divideMode="1"/>
</RG>
<Result>
<![CDATA[$$$]]></Result>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row()%2 !=0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="3" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="明细清单" columnName="机号"/>
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
<![CDATA[row()%2 !=0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="4" r="1" s="5">
<O t="DSColumn">
<Attributes dsName="明细清单" columnName="机龄"/>
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
<![CDATA[row()%2 !=0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="5" r="1" s="5">
<O t="DSColumn">
<Attributes dsName="明细清单" columnName="司龄"/>
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
<![CDATA[row()%2 !=0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="6" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="明细清单" columnName="故障数"/>
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
<![CDATA[row()%2 !=0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="7" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="明细清单" columnName="故障千次率"/>
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
<![CDATA[row()%2 !=0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="8" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="明细清单" columnName="故障保留数"/>
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
<![CDATA[row()%2 !=0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="9" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="明细清单" columnName="故障open数"/>
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
<![CDATA[row()%2 !=0]]></Formula>
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
<FRFont name="微软雅黑" style="0" size="80"/>
<Background name="ColorBackground" color="-3611690"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="ColorBackground" color="-3611690"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="ColorBackground" color="-5318927"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64"/>
<Background name="NullBackground"/>
<Border>
<Top style="1"/>
<Bottom style="1"/>
<Left style="1"/>
<Right style="1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
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
<![CDATA[m<oLM;t^"%eQq$:`UsuU1L&O,^Kkc:+pA%WXA$6>gm`T205`#ZQ3g;S*QYZfo:&cSQWYmDh(
AYg)(n>u349JM,=AmB!Vq)l$"Lb/`n:<^F1u:Srbh'r5Dgcc?Jf(i=4h0KI*V>/hTteB5L4E
7_gf<Sl^fgANYs]Ahe3,J2IdtrcUF9!77c!Um+7CKS`%pV]AIiC7[oD:2U39.E:_VV^=ZGJM^@
OY:;?*U`&B:=;us78;g4h'l?C=SBV0p8FEI5n[0j=]AkGG0Z9+#A1XGaOZgPph0V)d(B3_88m
\(2J41+8WEaf[e;5d+SFi6k1<X@^4:nAYepZ+k/S-@EtFp?>2hln.JQMjm.fSLN@L:n)::A)
>fE;!\fu4O^f''d+4jV^ciNJMmUb@7e3qkBg'JK0Q#Xm:i*R=2L%b!@mX":;lS!`N3\"^c*a
;4%/up2Q3!\]AZn(f-'^@^I&QlWkmRk[O@FBc/N-]A\Vf61Dq#oVA@d>(^]At'u_S\(%"[47C(H
,.G5Fr#@g2[NNntO\oBji98ZTBcdXDK^WH(%a7C@H8RqDq)k"1Km3>bIR2[0#f>-6&\iq&Go
h]Ae8-QgW:0hGW$k8;[LjctbaSQWgMkEBdX-,jP.o?6D=X75L=cQCG@SUQs:0%Q;l-.\J':`@
W-/(3$mh(AK9A9D&KHDV)eR-3[_ightZh8)G/1q^cmau3lO9B,+`MSu6"h_R*gSRUIc:%+`a
oJ_`J0(b4bOo@mcSYCqDl1rqUrW1'qMG\keZ#5KG+2#]A\<eVn7F#X\19crkB1E#J@+Dm)_G]A
aCK+$jk5[phKV*u>uqml#R0hi)E4T"9]AXD7e0P=j00;%;Mpq]A:p!HCmN^0$gh/u3\j,"cFZL
QA&Kt=QZu[!RG.-",P2K2+kq:G,BF)?-#oNX9)k)H5;$sQDV<rZAZ7E-#:Og8UqVr10<a!-R
QZ_:A(iRU=@HIs+"OpN`?+q>S@s^">IC%?*<k%kN-,O.,\e2%:X;XXJSn<R*J('"N0;'6L9D
#.i_PDXXk"@X&(%*Vcgs02h7AMD?!;1'^5Xne:4DVJVF[[aAUdTIeZ%msKt$ejoF2i;EB_\N
hsdsjo05Th&QuGQP'd(m16Y#3h$t7B9*WO^)X?r(D^?[XBi<,*YDnQ9e=<B>l53HdULR\3]A=
Ym5O![l<?[nn0-\"5:'>0q'BtQ'n`87dRL06l(XkLM`UkmXanC6XlhH<S*PPVP`c?(b+37?-
@K^gjDr`5V=N/f952"9/7GNQ9PUCqp+lq=@]AZ,uStiOLOgGJ0HtoCrjVI&6(YBt/A(o)cScE
8d.<Q%OE@)"ERPHgA`JreC5C98UE)ok->X$[a!_,B<&7#rH@RE,;0J=m9_[p9E?3/JgJJ,t$
*_S(oKq;l_BB(RA9_iHkXFY.9q%+H?=I`1fGcX;mL%4o#RoO/'(rGl)BrDERA_T%OtV01uLU
G*MJb?=lcJ#=0Fg6:f9Z>_!HAr0pJa^pIW_5(H<@?%S;)9e/6;\C@WRj1#fcqqd=7]Ao83<-=
<Gm5>^?5)#pYpODpJKq>nu#I=-,NYL#C<FSeiWi?l'oI1'PlSR)G_iR[cu`d#M0\=J>u17_a
e9'L&_Y;6C_OSEAPk;/jBrl?HdfYmWfLT6eZI>;=[n$1N?Y0"$9\qW\Q,F\6)N"&%X,hrHp:
`Op5qMG5b@k\H@X]AZJsN@(cqr,J+%UBQI%.g^ICn34T+nu<j?Ih)pho5jGJ7"[ScGfN"hb!l
1>-m&)(fFZi'_SlR+f]AuJ?WYah<&[@A07,3<ufQ#N4jDe&pe.SP+0o762!lt7Y?luEhpTm8^
KYpn0'W=sB@@oo<]A*+5MHa)72L:c2f:F3D^l#5pal8g3r]ARMn3*gP\;%VFtJ)CWV*e5EY#<W
73p'>1]A9+!&/lm@po'UOoVKnVKELGLu:WX_d<P.`h^9d9K=ZN4:^^f7B1HorLEdS;VU"Bcq1
qcmV0f[&]AWUccTYFossF:;_\!OYAWFD:C7&+`f1RW&qmJmYeV,",:q#kO(G%LRNd&B'5,cSo
*+O3Wn:YXfP*k)1SUWO;B@80pU'iG`q'O;\Qe,MQ@^cimc?gh[a/!qZl0`dO[Ej=b&%fns7o
V@cOQ:qcp^1a`gO9_V"/2E_osn`_'@S:BCQROoX9P6)*]A7$5bsXrk'ejk<Q/+7j:$l0e"i0@
lPOt($FBGa.WY%SHjEfkH$t0D<S@?an?2,dcCOJ42F^bW^%=S6)=NYP,!o8fnO,RsPCK:K[`
6psi7]Ar6:A%[tmimgp*V[ZL*XSDS-Z8[I>9<-N0A"k*A6&6^pFA,0+*:,bEhI<mpCC&$>2_o
`G&7B*Dmcq@.`)GU2l'&7\]Ae+Jm;/Cr?taRF+J1#81fb4gCpDrd&[F"E;)J(eO!fiTU,>EH*
5]AqA?Pc.(Q9-P*4!TjYL'h^*ciaDR8e9pI6`[[P!_@gSaR+`J[?$<&O/A9,^#,d8C=CAr-hk
EN<EVZ$'c#-\IbAhJ`l7SCEf1drDs#D@KR6^:YUD3g3l*%McRY8C1!P+!?L8PQP<%mu[2#Ol
dTj,1gEXhgSH%H5g-;/'\"0KQg/Z.8eC$JTIn)1Roo@7u1,o)5!UUm[4%=Q_.pj?r8s(p>dh
Q!C.Em!0kDX&2[n$r`;\9uC]ANoAJh(LZJSCp)p+m3jo19JK44eN\6F/uf7opQkXEPYYGh";/
>"Z8jZEAtn[1H-dh@rs9!d.lI0A\,*EGP'mE.l[:iq,[.;Te5BpF>*-i1_MklpKCf8RW?WEZ
"\;k"Q$/Eabs$uJYPV"n69^<ggo\;K\@4Y)E)PuZC^P$'-;#C>4/Ia2]AaXW!PFbPe1"H3mds
(XRW?]A_eB07C:d`d4;cgH5^D@M@Wa^3`bKFm\f.&t9S=\<al8^Z>+h"#T0ORX.BfmnjdtgnE
&TiZMb)XN&)^0<UJL6M;2dJDgO2,fdI,;s3!nsRA!nnt)[WSm!Jq'u&N`!1(FuB;kbGiQc:L
'/#/W`b*7"<ALF_bLW<Y]ATqI6Dks)S_#ffc.pe7#;q_b[9mbbBQ\>6$lC4Y.+G#-DtFa)qjM
r<3s-LEB.o*^4MKaEkcMEW(qaJ_i0IF<ACC3%UJmjn)q3(h_#OV\t'*m=Dg<&kND$\]Ae-R,)
S^EdE`(]A8a%mGfk9.*+SOjX4d`c*5J$dRK,lMmR=/)U'&t_F$ZX:m3G/TsDa;N'&4<ai5mC*
mr#LGG*Kr:\CNbi$[k1R9/9HGrc^"45t3Phrm0c<XA7M$^t`Q3f;DZ(V8r;JtYP#Fg".R-RD
9i/QljQl_2Wb@<\[QMp",$ubV+'X;oD7&Od.%19#q/l!R:B-Nc\EB^HIZ4(cUQs/u!sb2R98
orQs45GPkU:qVPecNP"Nf]A.9JpXeX[&C1<J8H-4&+e48ISLp4jJo;ml8p;5&F-WXminsjicc
I\+^YRcTrq$\API)M:X@o6'KLR$_Q$MlM)9-mqr2<0!28?Fdc8p7uT4Q\l]AsIW&\5<?1.-Na
q[-W6j9L?<9+HMeS6HWL#bK:i>:roOMhpUfb)>G1R9`*g?FWE=A2J,@39h4pH*`(b1s/QAii
2q^]A-CMe7hSWSn@N]AfI2MfqQMDJ(>:Ru2A,=lgB0NIB@rsYCu`E^>ePdP7fMXFnF$m^HH?NA
h8munLkSN2@R-TWkfe)abO!5:+]Ageh@I5g/P-josN+pe=NjXS&o6e^b32t!-<bO;E2r-bS:3
D7b5*l#c9OEBV.`9Gm@4cB?qi%PMg32Q9q04YFgKsdV:K,6]AN;M6^@[#*`4eZiog"G9)kJ"*
5+AA)2k2l!65*-0\"Aa<g3%VIu[oOpj]Adm8ETX+9P]A8kXC)aCUj77SeSA+)rspPRAkETj9@.
3c/r6q%V:MR[,Da*fLCIlhbU@dWH37b6bcX#p9]A<+dF=qJ"`4Z77PN7hK+8ah#(C/AZQFcV4
eD?UWC8.#NIAiH$R1`9a]AEU/^[XbjlOc`f1O?X6lo=K229g,VELc92]ATR5Jcaq\2l[.`I1//
9-@o))kA87C';*HpJ[u*c[GMp8fV-/D=$88jZ[M`&pkZc0N$Lm^I!'"4g;6/FlNA.Sc&6Or_
B>[9C[+O[PpX]A`HCt7j6GmSp&@i"L\r;['+\3k.Bm.U^*b)=)M.F)9jC1+?>OTh;K?tDgsgB
[\!ihS.'2@qgrNi.OX#*qiPY&.OlqZ7hSp2dlk1(_pMlXh)Q8B>Ja+\JCtpt;V7ku=43-^'h
2!Do:m>3,JNSur;'f0SI84Ra5usOS/2h4*2%4fkEN$4\O=(sNiVd8$;Ih.l>&iA"bBh'pRfN
APm:P'7JmBSR'qS28Rre)Q4r%>R=7V`qqbdhCf+8h6gKGi`SF7gn+@6W,-"B]Arr&'5*/)BX%
eN&'8k`Jp>Tts94kR=h:P\]AReR))h+rhFFdflPG(kOc2M1l&o50#mcOFf`68)T$QJEU\aaEL
n*99]A%RI.9-;!+2&2A(:f>6d2Dh`m2u0TLr4G\QSR:M/I6[Z:k['^fi9\Hf2CJBI!b[OYkuH
ZH$N>28TYYV@2H9J07eQu"7tBi8p"%5,V6&ok\F_9on5t5K,"XZS>LO@H!<R[dTYf;;sL,ei
VX(qi?$4Y$</eEn/*ZW]A@PfIN4GP'NY:O)[iqK9q<^[nap/>+4AndeJ'[R;9IttAI/fp4h(:
7:EJs5D__c)f=chB=;N-UXp:Qo8c9_]AoBrsS(D#/GqCQAMl$E[>Z*qc=R%?4;\=CQd;EIP2o
IE!?Wechnd):`Ph[TD;K2,9QRKCT8-;h%':4^*uOY-K;#'e]A=\LBf5[$o)c)?&YB<q*\od_4
LJGHPZ!a5?t(Vl"u`W2l?RQlqLSP<s_N@nlC`mJ"i=lXY2+%etUMh]AFNK(8G?ALf\t/3Yk*b
-JPAiNN%mJ0]A4@5Xf-[E_rTmgukcm:ZS8JGd0h*O`EAH?U#7'Oo#&4i.Ec$q:qQkbPA)l=-[
&<i5Jo_I1H0VGNcDU&-B'hh0(cHa=#Hp?3*G#fMZ)J[aN<K")AR,`W'BBZ.Kd<?*#t`7-VKc
W$\X_H>]AJ6?X0?MMD8_$D_%9C`N)VSm#!np"-rKqG>L!pjtMbQF:a\BeGp9JRn0o_!<0PZ6l
i\o",TOTlY[Y41ZE_Wp;,R]AVI)%$8Q>Z<=9_"Q[[ma=pi*_IPKl<32JLX3f^W]A,->A2Q0`X-
giVic:BK"J\=oBi<q;b=%hJ>eJe:%9Q^`*t!kp7P<EOk,$i%j"SW[i=7)c+da9-(]Aq3+]Al@2
:9spl('=VHd/ujg;RuK1-W&j+c^:#fs1$<+jg/hud^jea6&0[oRNVVLUrrk_lH8$tp44DX!]A
cZ]A/E;MiOFrlEO6#I@1*h`-eZsD%&[TR8'1G7R,b>iG+L15fj'[OTWlCX$nG4[k4GhkF##Ij
jJq^/H]Ag"2gn[Z0Dr6.dnn5OARoa'D)FUmc+rV;jC8B7i%cAB+P2poD8DWLE%L7bT\M8PMUP
3a-+_?Mg->bH\k,500Ku@+0r_H^(U^hl:t5dfAEO"mVd`\WDlM#X%RA$^>#]A%WlVF5_^JK^P
+!s%@PZhMthurL^3:h4c4#*_NXaP>H#+_q+$CL2p3@r7DES"5:(0eg<(=ZC8K;K]AZ\*=LkSa
nD(Jr>Nc0HdH<PNfB`@6%<E?=hP#81>rtN0UYjlD<n>'eaKK2]A`h0dWFF,bDp6_'(tG>*S&l
'g-8+0<FTHNf7Q41m[_Nl=K0K__[e1PCFDrCF'FHd>u$mmdNi(:Q5hq^:%-n"Z6EKu"u"p`e
Jf6Nm#(-Gm[f9d.e%Vb%\n4"_cl(1uMBX"CO9h$qNT"h;lE3sjpVZkH\>RDZo:!62a/euU_,
5XTb8]Ab7CIDle$;e(bZjd)HY#<mHP6&g9]A;r;c63n;I6M/sM<^*6"nZ6HnDafGh@%/E"SGc#
-ne1`:L[$$-=\rpaitcKrk*4HS[Rc3PI&BiqUpcWXu]A.o!#t*02%CR^\_F(gU%tfP4.,;Y8I
_IdV"TQ[!gaG<a?B)EaCM.gL]A^O!#aeR@DdUUl6QXkF^F&7K_8*0-1XP/XiP$)_XPGM@6J$C
64>o5%XSjLT7Y9:ki5BbLo?gYh2O#T\07ln.gr!"g5RP_Sj=-s(lP+S6r*V`?A;BR<]ANQ_,)
L,aHjqsf;g0.r;GU^O0qN0^n#%3g4!M5^<Eh0lu'bf-!UqDn]AL4sCFaGj@>cB?3o<[08YJAj
#tH=JSBGV1baPg(V4lI%dRGr$N*bVp<pJ&BM!Aej*+9,iHfnjmWi98LjeYlXUAU#M!\OF;(0
'IgclkE2Mijm]AXZnIaEgi9^e*\JJKn6UioCV,jK0'Wl8q=rTigB$'L"s#:gZ;dMn%KFi-Z&K
@0]A!ft6N0OrMCI&JD&4LA4)HIb4-A^<j&lu"aGB5gV.I"X"/8p$pY<RlFek)nS(CVa.R>,[G
qL=6PX!N>q3$BfYl,AP!B*h:3VJg6-NW(3\d)BXmpA*)@Ura_FjlR'Ri)#p;;q=ba9*#\:1C
Eo(XdJH(BKsSa;dGdrDkKH%n>N)G63?^We<5="m)l#`@HO"-U'Y@OA*m=O&5SG[jc'HR"rA5
balo)PI=fk\3^!;r^`iA!6?krRug0(%asbc&E]AEs(f=N[7K3`P'.DP@ZJo[5'H2l'd%ii#j(
Zqt\Nk*XoV7[DZ92AJ@Eu9I=XFaYT+T2*@6SaLa$3Or%G$('Rj5LnBoUqZ/^O"cJY>/=^UTc
WC/75f&Zd`0jD5>AE+?7f6L7nqVD\8%#[#YR0Rq-n;TT":GCtaI8l+r*B@XPbo8(+7]A:Q%WL
LnmLqX7f-%'e*BW8B$ljp$\,<1+nV0(`B\aH`)*#sknQol#A:99RH=Q6fS3B#?"3S>[iK$]AQ
9&6_*c:@@HpXNF,N]AN.L?pL@eK==g!KXdD_%&9ETh.4CS4Snsg8thNG7]An#n$oGU-.C4P$c7
M7kKp"[b-nbk/`9Z"a+#MOY_j7Fn:D;OCkgL*fV`>G=brUP70OS9jJiQqf&caTFNlj+-.[:]A
WXi59n(G#<^#!f^d3MMN4ELq^'c;D&`eedlS`FJiqJ&@XJ]ARPlQZ\neT&BrL('9oUc,S?Su&
Y*a!N:p'mA,kZC7\1<IB89P!K,YnAUIKa'HNARS-d9b5XIA;anJB&-V_1KHOEpMjY%:;6R01
VKu+Ld=&9NFrbLj+R#Ok;OJ`REE<CK=ZnKg^TqfKt&RG-uTKhm/lB;S/ALSiX822-6ag!_i\
NJ89oa/e6_fapkJ$5(oDB?'Pf1g/p,\_Cg>#i&SD?T`aTuNVB&Wj6qVCJisb)V#tO_II&hGg
):6od,(93>jQLSP2p/DbEgMpi3GfR?(7fIrLq<@VYhTjbDp(J1B'pH1La!>DgM?o3Ukc:8d*
5^,Dp_9F6l9"?EKrpa-=3st7M-'j.1jd3SpuQr@t8+6]A$qRWY7Z$u]Akoh2=aWOte+`VY5Q_/
TG2a$"#h<i.kANEJIOk6alXt=TAU+cc/t)C$37q4-4S0W8WN=*5E2qt4I+3??nE??W\.r9^q
j5'C%(P8-@8r3^Uj=rnk\K8^Ieau!3_"H=;E>2mk]A,oJ'.B.th))**m.6spFuXD5*,HMeIS8
4f6$H]A(KUbY*eYJOU,ASb=Zd+hP]AlqUCH'hgAX?:tIR5U*NfOQp`Rn<NhCe+gX2gSdN+]A9dc
m:O#E_hTRk#o1LJ&RpEWai!*U>6LG7JXJCe@-AkL3Lg?b3G/=.O!oQONoA=ln!/rJ`'In#a6
i/f8`eZU07X3-m1QW9;]AK4s<?HOE\ZBLQN!)7eZiq`K12%+-Ca2?PA\'hMUkFD5nf"CeI[]An
T>+.ikQ&FN%%2m"#K&C!Y@Q*p`\[a1HAroN"4uPm>'6Nb8;CSChZB#s"op\ZnAT#ELhHp7QT
,W0Y7HmaU='-Y/)'c\F%7iK9?@kSAcM85Q-\>7f!^`M"I50*AU_e\`SObX)rQ96@8OWtg8U2
9J-"J3G)Q[H))$Cikd'ph=%H-l08IWD;kXG1t#5bU<EDejEHB!,@P\_;s"N.@ADVf?)rQ6M(
E0\Ss/ZW7iA*P7/^V8g%>cUpXRg\;uY$cJPG5L.W'>>)D)#$Y($r1UU.)s'IZpV'1h2WSSlF
`dJd<9UQBJ;(h9c*(0D-MR(EnJ!7j]A_pY(ao1iZsBW-^[fcZ);/0tIF!iM[7bqcR+D?*Lt+2
RkkM,$B2;OT*+6.pU]A8:*^!Kmb>kCUId@L>\,_@lk:fl83l_.%?pL\bYO;[IuD92k8"efE!.
untJ%..qqUGi[W)#joPpu]AT:RiH94.%(!!8c-JeU$ieQ@q)m'D'K2lf)Z`nq@Bbc:LHcsXa=
A@bubqA*0N+pf"X>TN"s.E]Ae"Tia]A^B-Zi,Kor\uZI3Zo;5XJ@BO0AHT[R=b9hjije@h[*nV
!a&q3qH*+'s!E0m@?ujB9I6':R:,XW0TocI'9Z]ARr"1albU"s_I\\!.Ao#]Ao1R:9OOZ?#H5s
t.7S>U6Hn]A_?_,hk_L3WDBKLi=LJ:S^Bp,Y^)sNr[`eU(DF^iGVET\RWm6o!!mC8L"]Ai_sI0
+'83-Hp.UP%W`K4F$3l=T4FTRB7aHYfX&Bn+./XBn8=:#LWnG`TJ4/`MA\.Bu>9O!`C\q<?O
deSq6<`@d)%a@Ch<o5-J/cDr8_sg'HjoV;Wt`Ce-^)hJal/Sdb5E4lp5fc+j%i'5EViI<UBj
.\LY9hu$T6OZRCV]A@IC09f:p6>,!5!QE;A^O5*`;NGC*1En<f"`i2P0.09ttAM'Ufdu-2)8M
(.ohFY2QM_5:5.[_;F/@79QA$9@d/Qo:7`R3TaBRM")j1>bHh8abkrq4@j$-!,JeQUFQ+hG)
X-U+K?Y&447N#,g1>tPDf$nPGY!VWicZDqoohM1#$LEm8k$eT<'(A3orI4[eLe<\raJD/"]A/
KeY^*!53.3g#$(/oI>^.g$[j<Jd'jfK9n\!MhR):V]Aua9rf27P[+6Y-TV0^>^@tQEhec?K^K
6f&%rKj;DJ[YZ?R#asN+:at^XB*'46rDpBA\kXe%4EQ%NqEJ*8_.^7b>%cH2]AI7eD`/4u^7X
q]A<M(k_567WpCkACpp+6@EGiN@?o(P:Llg/t^?UQ59LOf4j8LqtV!R'Dlr;Q[k&GSu8S:KIu
j.k8>l_t]AC;G\o='[gS!QWZn2F-Xmc5HYW8fU):+!nBsI+1q"!4"B?5+'YmoH*2YSa7CWR>Q
!8to%#H0`Z"'95H33/1Qf2+El97R$8X$7Th3ElRfcmmlSlCZ['hY&bnJRc^1Y)Q,so>PMd+u
k_rN0@>CPrY7eDLRr3UX]A?TX<?U_@b3kuKU7E1^K'L\aeD#ITVlpCtRpJ?MWp]A*]AFEoKY!EH
!`#'81FB1Y*V'9"@@>K.3RKWI,Dal,R/Zt9]AgoH1OcdSnXt.1K1H,"9e[ZN*D483%0hAS'!F
1WL!V8W+l`/hBgI4Eq5Td!n4M%d8>aR6.)p\WPs-;Y#lH!a!?gA/cTW='!3Y`cN8h,jqSnuo
Ze+o%4?pf`N#jJfD7!WTgK!%/\V5126Ope"e_.lb6&#@/SDK=g,W7d'pJ6l#6uA/3f+*rPP-
drFI?UG\+C=%LJ+T(n-O'F3o_t,6J<krd:md+po9AR07Nc]AD#U3f0TPGjQLV#T\;@#]A#10/9
?jjH9R)Iga%mZiN$SmK^!&XsBaYuLL'd?'jP86lYrk-k\(LK'c\4mO\sSd/\tYTXJ/.Wu4Ib
k6(qlko%AG![YkV@s$d#cZ9WiG1cqs#F!9Bj.g+W^?f1_2Z;'Ju:iBn@O/6/&EBk8aJ/;R1^
h&I7H=S"+!6:?tr>mGdJ&PnW;k.:><LKL^gfE"sun>+JIak`al;%&fUD[<#:;#`<JY0OV&nu
(EfFAs$1Xj:u+Jn$<8IREh.t#Gjf8g*_7?XUSArKI)'70HXq&-!kB"I*,JXZmaVn@L>.B`?O
l&s)H:0A`W'dNN"UZ6^d@MYYD0e&nq[6Rl*%W8oNn(SCR&G@YN`BZ@[^8IC1kELm!+F(+?Dp
O-6,;>BtFs@7Gs/a1PC?1W+81hJin1-U<DFie\N)7W_t*&,aUnq,-gAjjcrm0FAjq>$6J-gS
_qKTWuL'2JmmL5`mHX`025qERAp`Noems#NYjDGY?50i%4%al#['A8,_:[06f&,IV0:O+fke
;.jBR>!.7%?;P60&1,=Sbk>]A5&N_AI(c2)D&,`KhS/m>2kca08^dOmD)E#D%C:"uF0W8[jYY
0]A;RgNsu^,:<#%A]Ao62/99UR`K9qL7:"e5$M*2_@6IYcZXI:<F@.[0Z+hp(U*Q3n`\u7<Jlh
;;W+n;,9-u1!YHiA"&Nd2/h;aWN6Qp<X0Cm8V3F-CCATX;Ne*>d"QD(1:4r"j'Fqu@j[iZK$
=.'d*r:6Z=`"rJm1W&fXK!+C`"L*:,C.t=0(R7j&j,D$._>BlZ2n'gcNd8@,tlK)&BM+MBX)
!+jH6g1>'[ge1jpPoqq>R+%44R\Oq'"Li;QDO?-P4@3M<*cO%,H&ujW"ME-P<?ofgX6<JX&Z
M,<W]AXd:CBFNLB`0X,BchY8_%3N@JPs^F_r6]AOq<A8OFoG?601u_o4#`H=59f[6)\[EmM]A[D
D58;)KEse>H]A*bo?p`G-7Ykr<4-<ol>_%b'iH4&DpH/_omPO$,/"E;;LI*>H7>Q3+@uWe)XG
<\UVMm4J1\1$`X45:Of)i+&*/0F/1b%%Sde)'G4A/0E%Yc>:#p(.KJ)QBB*R7V<pZJR`:Ykn
/(I&WI,"Ze$,(?eb@U'+lJUhsqQg>P_H0snQ1W[g!L%'k4+?%]A=7L4F;S"W"ARa=W8[4je0a
dS%V1N,)ds$jp60XcZ\Q2`e,Q>dSP+6K,bU#6C/dMhrbjLjZq\LTZlED!ODBbu`i^(LRMAeR
ic#20;AMC@-'C'!G`&c1Yge1.]AA"KgBLhn0rMpU0=)/sC4&N8R1u&G-`GV!"NIl=:1el!A'?
Y[1WDWleS-e`%#_L4Keh"oPr&+]A%ej)=?%,'_+OR`dkdc$a0!bG:sT&Z!dMK^45KIRT,[]A=;
sFH^;!f/gBQZf.VQ2OLSJ'@l?VHn'Pms3rN\c:j]A4_%/@eNo3!9X`p`gmc[$Fk,n7'3#g_(`
[W_5"aaG"Sg0kEjm`@m!*PHHD"7h?6I'&$a.d['(.3Qs"tqujjLHmR.mde$QL8-bD!,BiJPM
>.Pg-t`g'Eo_@*aoIrn(rSt%Vu,#n[e,(YW)5ik=A3kTorhT9lq)VUXR\fUAC*5Gb3%e1"R4
Nh'#pho]AE7bhe8J[OCa7CcCFVFVesdXY27*C6(#Q5]AB8$Bccjibe0(5P";N\XuP)t,73O&;R
]Au9c2YCfFN$Va76rMfEdN]A-sEL5ZCg#-Fp/0El-[M,B@urK28/(4P<.j]A2eI%;TPu1qOH>01
ugX)mB16r>d+Vh1La6breT6rekJgLMX$8dCkKm2dK3>b^b30%6!ua/$;7q&o?ticjbS<@3We
n.q]A55p!m=F]A+B*A4KU.*InUebD@X"*L1"Lin>'uS'LtCm):/lui57M+i?(Y/1SO47/"^([\
!F%(TIh-Z2_FOCX\U%VUjtC13**gq$#gaCZ=C+5TMZVmfM2#40jFWM84=s1imOEFFa1=\ANj
M"@k8e$Zl$%6l$e3$6/@&iUOshO^-TDXDjMRNWu<.c+XbDkH*1mM^ui+pRqn\^]AN(lHcB*a"
m9juWqEYs;)rqr0AjF6&.0!Cj.fN]Ah(`7kdjPHnd6Z2b,TR]A3PLcGej-icCA_&d/9:cIi(0S
@.D@)U7)9'\[:)5u+AZ>2rh.f4-]AV>)B3.[*VhKuZiR;H\6=6cbp4^cZ[A2Hp>1d3m_n+c4R
+9:3k2YhdXN(QUK6.Y-3>0V&u"Z$><j@mK2rL4-E0M-UGJ?Me8#q2jK4[c=A$@\f4J^Ho2>G
SU'_"W;[0OX2pY!7,Cj&e$*JZDU2)3]A%hRe;JcpLoP4nR[kRC3",a>@QAlS_!Q_/`=>7QGKb
*#WT]A,D.QiPuZA+TA\0>tfiolG24kJ]AOqZjDE\5bF[#5VXl)"pDsS]Asch9dDeAAH36BI^JD7
#TZcb:pb_c(!#<bfi7I['B*P!pV?s)?n2`<V7n)-[d9k[_VgfM+Z^7;kC4o4V_QQ1/kG>*-3
1+9(Bsj=@U-/5aC*EbEMJ*N56]Ab_l&aOn!9*IFQ:,X.HXRP[p8A#,j4X!;kI#2)ngNM$QY4&
'ir8,i-3">~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="441"/>
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
<BoundsAttr x="0" y="96" width="375" height="441"/>
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
<BoundsAttr x="0" y="537" width="375" height="23"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="absolute0"/>
<WidgetID widgetID="dcb19735-bbcc-4046-9654-621a49d9a955"/>
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
<WidgetName name="jx"/>
<LabelName name="年份:"/>
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
<Dictionary class="com.fr.data.impl.CustomDictionary">
<CustomDictAttr>
<Dict key="B737" value="B737"/>
<Dict key="B747" value="B747"/>
<Dict key="B757" value="B757"/>
<Dict key="B767" value="B767"/>
</CustomDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[B737]]></O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="64" y="42" width="120" height="30"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="Label机型"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="Label年份" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[机型:  ]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="微软雅黑" style="1" size="72" foreground="-15386770"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="4" y="42" width="60" height="30"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ComboBox">
<WidgetName name="mth"/>
<LabelName name="月份:"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="月份" frozen="false"/>
<PrivilegeControl/>
<MobileStyle class="com.fr.form.ui.mobile.DefaultMobileStyle" isCustom="true" borderType="1" borderRadius="6.0" iconColor="-14701083">
<Background name="ColorBackground"/>
<FRFont name="SimSun" style="0" size="96" foreground="-15386770"/>
</MobileStyle>
</WidgetAttr>
<Dictionary class="com.fr.data.impl.TableDataDictionary">
<FormulaDictAttr kiName="月份" viName="月份"/>
<TableDataDictAttr>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[月份]]></Name>
</TableData>
</TableDataDictAttr>
</Dictionary>
<widgetValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=format(format(datedelta(today(),-1),"MM"),"#,##0")]]></Attributes>
</O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="252" y="6" width="120" height="30"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="Label月份"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="Label月份" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[月份:  ]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="微软雅黑" style="1" size="72" foreground="-15386770"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="192" y="6" width="60" height="30"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ComboBox">
<WidgetName name="yer"/>
<LabelName name="年份:"/>
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
<FormulaDictAttr kiName="year" viName="year"/>
<TableDataDictAttr>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[年份]]></Name>
</TableData>
</TableDataDictAttr>
</Dictionary>
<widgetValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=format(datedelta(today(),-1),"yyyy")]]></Attributes>
</O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="64" y="6" width="120" height="30"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="Label年份"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="Label年份" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[年份:  ]]></O>
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
<Widget widgetName="Label年份"/>
<Widget widgetName="yer"/>
<Widget widgetName="Label月份"/>
<Widget widgetName="mth"/>
<Widget widgetName="Label机型"/>
<Widget widgetName="jx"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="31" width="375" height="65"/>
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
<![CDATA[1104900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2304000,2016000,2016000,2016000,2016000,2016000,2016000,2016000,2016000,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="9" s="0">
<O>
<![CDATA[  机务可靠性明细清单]]></O>
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
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!c'32cM\u7-"=]Aa4X+O.JGCq,g$V-'QN=[]A><Q<mMCMJYC(.Z[bb'M+_F\0@ZV6:?EV65
pK6Of]Ap=Ps3W,'SHgi"O]AejdKBnk)VSdso4hm#R6*hLP0b'R/`M5F:]AI(Ne'+5$^?>ClrZ9N
!rc`P.W&r#S&JGg6lIfgAilB!m!l`+5r6ao@P!>@aqIFeDbZs&3:X+,-InNSlN3ukFjd(VGm
lEBQS?fg+agT;uMi[7Bfm8kOgUiH;$#Ui+hb,bGSpBmNe!9Mtrg^XjmIGADkM-C(/K[0DAiW
7eaeP38%",Ia&GGEjSZ6"??dKIb2[b<p>YV^65t?NF;:/SS%?K\LQIu;U$cA?TAn-8Sanb3h
lqOcUZ.FBDg#Wb&Fs72q]A>"j3g:]A*SpZ#0gR$s<faF]AE2J*+Dsc6f_Ud(TGR`!TuZ+2*pS6p
`n(520LMJG*]Ai2k,kV0Dg#Sm1"1?j;F6=B>r)!T1uLRl>`YCNS(f-"73no+nfN>@r1OnY[9J
%IH`-6*G<kR,I?OgmCt?f8bSOoPaHq=7"CO9;CAA!eoAiBX7f>.?5S,*HSZ]AUrj[`f^pg0V]A
sP4I!PZKUZ6npp(2%]AFH8*,9V^ZS'MG>Tj4UqM>BDnjRZ#G7r)fKinMoM^EB/Z(Ek'Up9bZ\
IL_Va7mq3OGlT?[/6go!+h^=t6Q)[gh,%o%%&V4=ap#\&2=kEo5ZL:r@J01"=<Y64Pdk$I#E
lGS@/WU,J@7=8Sl>^#J$-fpi^\`bj9K>Li$lu1PK2V\"3cX$Oc1ZYaZ6S(0t`C^\C*;4tHi+
.N?X4\MOF3Z'q1(+#r\#!U"2mlcR0i&c4=ir:=e["oT`?j_(n,lh[KBtGGT,7f2>4(&H[prE
16[.I&`kI[Ip:]A/7M/YKo#9T&eH\`G?/o^7cF:6t$1ss!UO[8f1m+G^eFKOQCbp=::8U.j>n
WbgtpRKaJc51a*V^^^^ogWuZJ?shBD^6%@Fr.h+:TgXYW5cit^L^h#2gSC8A.LF8M=9#n*4M
!Lh^\s`^n_9q=4DDf>P_J_q'h"[9ZHSlVZl?S6moKMhR/5;TW-9)ID$+op."nH]AL<4H$KUCX
B!T2&;WAT9q"^$hXs\Eb^Qu-_'ON>7Nqt:ZJpjUR]AdMePSZtHi/!qj1m9c04d*ZhB`WM=c3A
]A]AoB:\ZNlQ>+(YH'NAl"=eamHdFbeP"ebAT<82&Fdm"-$&/S\8!u0NC,lq[m)IrQ>PC8H6QM
%Lg2fY`XBV*i.He%c"@aZ#/2PJoW#Z)pbnHe4Ce-<[Wf?9&e"TpCdtS]ASuJn=Q`?SFO7+<;O
g(9Q>^-#+=thX?3FKWRRU$ej+)YGqIpihuh(knMK;BbTH>r>!E['j?Im,UYo9chK_gJ+\e`;
!(^s)ud5/-a7j(mI,%YGoVdJVSoF`4OS!hL0:`<q#%DTWFD,6,R*1!b,-r.E!)iVQWp$caQO
HdgOt]AS.A_X+'o]AJaSD1jir:)6=i2']AOT+'7iCjjdWfGhoq")p9]A"rA5su7$&8DE%<]AJ#A>-
1]A($ms1K*S-=a&e;FR?niYJ,kbsL-A)>;BJkaP()";!#%eV`!A+nR8%9*tkY)jH:W%lS#k<+
j#btU`4(D.Nggn:L$KAo&a3+Mj2',Z!aroJ'%3Y")qC:%67cM=THEt%Z@-4-jX-)_$49lSO,
Si'??TJ:)ZuqM?Bnd.6<#b;7#IFL9nQ977*qlDNc:8faCZ6M_@]AA7D2YoBu/YM_/n:H,GR<e
9sFeW4)OJ4bHC9.K\[e>)03pYhq"VRJUZn0e$;6?t%<T6b(QGJ0WinCtgB]A7gVhEmKAX>(uX
LPT8$kjNu.^rJsAKa`g.!9>lNrsE+8>pn^4@iZ).UbYZ/EI^-0dX]AeR&\lSZKJ.J(XZV@\7Z
]APrNEV9G(FNmu*(u6#_2YsX\3G)PI7o$0pr?f5<2TTRq;R*kV;LCHpo^s,p)Y13o0)1,\"On
5e77);Q4^N:Ycef.gG*()+l;`:A.0jH23:@NgO'8"q&L!V%`@c0"koeY]Ag_Gg'qo0K\(Ico<
Q%8^hAHfR($.PJnOQ/qI7nKtcZ7pf0"/n*UDRZhl[ZWBp!nNJl*T)qAq6p/P$u38KY.Tds(M
Y\:nZH'OWuo^hOKH#mZuQkKg1-a)-SAs-O&G.eEise>p<R_<9.1>&i"uQN"cM`*O%Hm*&)=U
Y)hJ^l/nbEeS/!CeHCU0rQ2@q$%Z]ASFZFLGqpC4\mGlg:IfOd;:Ke(?2djlm8)EIr#se"GVS
js)&!KUG=e?9L`V;^6jR^01(6M-C[4*CC;UjQ$JCOVJX?Ff.?1fCMBSn=>'t:.U!Q2uGVt`]A
3e5q)2-O*ajZE6kpOGO@L<BS<6gbi4_A]AjkR(Y-?9-+NUUf^)?`DH#qg^hZC&f'Q&M#n-`OB
o8/nEqNJT"lpkGW)C>Q:Z(rj!O":-/O<<fg:C&-=)<aO4Qi7B52DVBHU*1)b&sHDi&hcSB(J
;0(*V[JZ`O8I]A*1&]A2<a\=AVo=Y4^+1H(V+V$D(NaMrr?.7'5U_nD#I:LBQ$OZm"`#LS=JFn
/-oRn(jM#PqTDpKb-[T^o=$W8ArXg^4kumj1dBQ&D/Fmmg%ZSPi82-0U5pEu2P>@7Dmg:*ea
i,b<>@L<P758.d#V:(n^7#>_&!TIZPGGM#6*7gldaKhee^6p>LUtuqg&`.Id[d;4p&@kkfN:
<%W._nInC<\Z@&ph\.[:S'6Lmu`*V5lN`U4rF3c#F?_,j\cHbQ-q@ZPlV(Wc&YrhkEjaPiGd
]A0:dE?anS3Z[UXU@YEW%\'\efao]A_pk#'hSH5J1**-bo$NaBP`=84\J@!2h7\4*rlr,C_AsF
gE#Bi1NC$MIgNQt-H1Y'o+H1<6WRW(=7T.;f#:V_6LJSI=f^sqjhbH(U<D;YqdV^6$`pcUWg
pIN]A1R+_MLl@5NX&_F3T>%Te>jOsf'T98W,)a>i^j&[1aGXKI6"LOb2M#,_=P]AEMAA)"p.m[
B<[3SW5e!9/VO.[,a$<#F%\pSpuB?J1J7LY5]AO>%,r1fkm+=3,\-LD)9dE"HU?hq-+`719.,
<nSGr'`tkU(!-p9QBaZa]AUj(hl`IbkCkt_J*s..+T!in^>)^3OIbrET)='EtS4087HIL(<C%
Y5*fG%FHkl8dY+QIjl8fOG:LU&!BEckb9rG\G-sH4b\5>?)F>No,m'HmRj>)*3r`88VaO3KL
`3Y&K1\k2`:a<@9=Tn$c:KQqeLQC8u6BWQ5DM^Hk<o>ln+SQRT62Ze[E838++Jni72?kd'`I
'M/MT[M5#d8;_s&R4.YE%r,[SF'cq\\L1`$I1Hj<3VHO@Hc1utLiY/K-HZ[9C<kE0ULq(@qg
6F^Q&4u:M.@0=-^@cm3iCmW2%TkEN(gp3-W800KF2#>Of(2VZA^f\Z7-b-UM?(a6nRSGNXRA
!@'NbGN#r7d0'c`ip,*&R5M*bg_d,UE*P^D(@b2N!)I>G0(Ch5E)"KT"L&Ck(:+BXX9pP9]A7
NLFhE<$=8qMnef>m8:h&L4Jt'QNf6kbU&e!8S<00OgY37_g.5e@U@6Nq>Dc/Y%hSXPG8/\*D
''!e7O8=P$0-f[ou7X$0VPT6<a;Ae?R[^A+17@jP%m[OurGGNnN.W17s>YNHgV#oEP+ne\)J
]A!LU["Z_LPk)S+GSNX<Umnh_>(Oc8=0c*&^<hoEAV4R^e`ceOt6!`.7#.;#,`/uqRU,S)Xbf
ic,1k+^$?Xf+/-6BJ5*]A7RnVgWC74Dj>2#n9C.RT_0R*Xcf?re5-OqR)64`TjF5]AJQDRcJ6q
)ADXul]AS2\9_<q`!)sD,HJ''<[`W#]A(O"V-^S9#S$9fjTf6uL!_A+7<m$?t77d/TAjC-,J)n
CH)<?VgX?q`ejoj.X"rVJm#M=ED#?_?J49R[H]A(-#s$F`pIlWF(aj4\QK\lFA@%$_TL=(:)'
61hj\APG;5W!g+g#En+F,$Q;%8Rb^!jTs)i@N,ml"iSu9@1[-I^VO<a.[GY%o2b!9/o*+Q*t
<@7/:^UG,&Z>r&$B;\L-:pd?P8,<(:Dt_II$!Y;,nHL`IWimhZP'1L$*/$G/YR_siBoG+Bln
A55Y7)a,(gg-Gdnr6+Pqj@Ab:f=,G-Cq"->jb]AY(^V^_0$8e+,E=(6d<CODch2CB-+*uD["6
lpY/&j8In80=8h>DX?RB++rV`n,Xd_nJj:K+oK&"$J\@[RoY+<g1oEH'cRk3KW\RFL:NCE;2
`.7[`5'=oq8rUBjDPK^j&Te[-&.EX"@@[0SiMUiSZE+Sqe1@kOLQ(kF20/O'/guF-P@;cN3P
7lI8eSDYVbG<AH&O!o<?)hQSW1YYjso+-!>\>#bd.]A_j@J]A[J[1Uh1:0Tk4]AWi+_*@E"e05/
TgK?@P%M%X)AYK9Ce1#WOAS=LnpF##O$%4S3PH??7.h>F`*H';pjVQaq3C<pJJM8Ff%R0[KX
o1'Y?^tTV<>'d8WEQsP/Z_goKc)doM2"'f\q8!(TQ:e#;&(t=nYB-\VF-L/Rq*#jl%gJqO2Y
boZjX=c\`,RjhF<!jog$I\p2;G$(MAr]A67JKAR7OX)#hb!]AbIP*@=>Wd.,%hEhD??;fU[L2P
\PsqNMF[[0.%'R)XT'Uf%]A?49Y,bU`t+M,W8c>gDfRXO)tuCIRRS_=h+7l2O-bPpH#/2jrd;
3]A6n=moWV7%`pG=t7Q#Bbs#Jk4IDOX'>a28M2:e!I%`7^E<Q?!7.1TZDDrhuN52uqG`nq>m`
L(74T8`&C>m]A!;,1`+S7=;l,gX<sZM#eW]ANV3WNXTWDj(8q5sP82[8VK)r>lZ>n*FrY3:H?]A
2rJ6VE6_@1lrF,#r`4Xa#egDg7,Hi%jh2Uh;\cf&Vjn0\9>3W%X*sE1!o()P]A/Y4R6eM<9*u
kEJ5P;=;n0T&I6sZZKH\Z'sRo)S-u+=Tn1OT6YhTEWGCU!$YDTQcWC+RU.EF')`HSE&>GpVQ
@[d;INXhA>-5+fTjloTj^%6S'>P36m:*SuAABHeMP^mP#*EsG4mh08Q;Q)`-kZlY$E\ZbEkm
#-EUE,^4PggFO$S^nk6@[^`^_WMXlg@pU>#6qh_*8$r0A`^>IpNJs.li>jN0)U#Zm;bL8BLd
63/#3ohD<>b2'CZ,jR8]A\;Eljj%rO@4na\b,Hn"i6;+P`@-<VZC[emr_;lTUCp$Jc\oINrHr
74cPnpa4XK0X><eW&7R*hF?R3WJ?#LG(b`=D[gM7<V-C'0l('c@sn;e+*DNf;m>?bOUH!h?"
,RU`eRe&4rpE04WCDM2+]A<%$<R^LNSMTh+URgI(Mt4Upn3ZWA]AFKBH7Gm?OA2>?>CtoUH*J/
XZe<K'/4,A'QH(/[!chkH]A>/If!<4$s+I[m,L+K=b4-2U)C\TY(%/4$RR"IGc#LH)InHRGWT
#.I6#h]A(MKuBELKmT`\QY+\i<lJ3m.mq8!m_oO%=SnZ(l>\f0los&&)p,RN%D0S&E9!15rZD
6_:3s-YCrTfu^Sd$g4;8R[l9(8D#`QiFh4+6Z]AI);']AJhirF0nI)%6dRu"*tTfNo6Et&PsD/
%QtES;j)%@.2=AI^_E6t@t+o(`?iFl91u\L(=Pb46"`Qp.,k_b]A1HV,aSBdO<na!45i^%D_\
=TZO+;o]AbQV$9*b5YcP,4'I&nrA'0+V^qer!8SXNpV?ugh:r4X6j3Te?DKJu!nL0l8mbe04+
h'`LR=.KQ!dXFrW.*sl+o.Q4o'2eEX(E)\o5kVsS9$8,O/';uqa31XY^IBN11Q:^Y_S8LCsJ
I]AV86g#SPA'q<36)crpG?Xiur9tNu!W>HH<!NC6\MVf2D<USZ+M<&73(%c!_U`mt8,#5*\Jl
7O$W]A)f1rf)13P?$j@`KTVTHCK:/aW)DLdc>bJ!.q^Jj,AKJHL7r\hCi%dX/o(l@%/s@"!+;
XJlGt_u)Gf*,;d$BuP[=AgfTmEmr_lSr>=O`)M;Nl%gR#M.S\fr#o-EL&g4JBTsdZe+$iN@9
a0!8bdP@&#A>e9X?`c*k[c#PN#9^dCc1JDMCk[lV3Cqu`T-m%A!U:b(U;q;N=h4bde*`86'_
/j^XM#CHIY=$@FZC#Z=6@9D?NW7nFPW:!d^cn=lNDh%pFUZnl&\s6V)_0l4FjqSbf,4&PG;Z
+uG(c+gU:3?&J?itINH/?f1=eB/Kb`=_F!rGbeR!%&(o\0f_'Z1=[6pNN[5X.H:"+"0!'iB/
^>[-@?pD>[=jV3M(U1$dl\Z/R#'m;*UNT*ak2P!ss*P_0f3(D+3bjjq&E>_H4Bb/BJrjkK81
.c$UEqaVZ6]A-iD)qi;D+sL#Xaq[Y#P[AWdJ.kAO+&iTZ,8WfktfUeWn!LWs2Qtfs/d)(It`t
-i]AOT722Ue=jDb3%-I!^b@?["$rO#0;//_EfqdmC"g*D`hD)r.ImQu\1/Y`FE^<tEJ%14Ukn
q*Z"e>0>2;.#VlX(6:G3'BC$fh@Vf??neW[:<'b:ip2jNRHb:Ib0WIB4R(DYc#X<B.HUpN5q
<%i0MFO\r=^"/"]AS[+$aKaOO1'aWUN$FJA+[P4E_'>OCV7Tb$B)66*ZIp=!G0LW%9QGKT^!<
&sJ"/jJ1H7oW=Hm]APn5u0Y=Zo/eLXt"*B=lMHYq@b<`YhN53+,e5CP8T82'51S/G$47'&8/+
F:7B0Mm?=p]Ach#AAri\$[QqDK$Ia:%J:F<-j'A*Pmm\3N?_BNgUtdAmkI\YDh+%JL]A+:nrWU
bR]Ao;@TKI0V<JigE48j</X"PuWLM@=.8o(j,I^*bF"k_XLDfOSM4V37l)"^Q!-Mr,lH-gt*q
dMTQF8#@7I>NKJ'=#0Q?#u^<6Gm@l=7:F?6P:FXKTjbo))(?>jBsb(Q_+\i4%,loPSO[WSd[
sjDO0Tb9:+#TK81s>N2Y@#s/KBHd=a?Pm3tDm!#g[cgcs.IV7-A,_bkcq>#eB+Br9%;EWn%_
je<Gl^mR8,\J/'cPZZDQLg<`o@tfkQ*g<<Z>`Q_&Z@*?<&ul;"ID`Z*nsM9/im:7<?&<gQ3L
&KIp$Vb0QHZq9@;\iN0e"dN%S@Q8oiFU'FX:"cR7Wq?A?\7ml:K1%SSQVECVj#[;2c;3g4lN
>:*]A^;>#7US=G85g-O$XkCqf[/mCh*U;:h=,qY+P@752$P1?qVOZ4/\7mn2]A_NE>Ij+r_]AEE
I\(j)RsQ4e&Fa=,jeXTi4(E9/]AuVJ`a_m0BHe/=hRW6hm+G?dFMEP(5]A?.`bX$b3ClNP"ZJ'
'sgk>?hfX1-lQQnSj`*K6j8&C8.pdXB_qN9BIr>+tZ7f<B2_USJS_Q+aj^!)SYU2lpe?ZG6+
V]A#7j2?UEUb<h\fYI8Zf&NTuJ/j?k/WrLPmC0VhU`a@fM/@2ORg(a&^'Z/n]AYn6)Z*Sqar2:
6+')]AlL)^_QAN'$=A*0<^OP;^]A/ZVX1>?Pg!bI!2ho#'!4p&lF1ppoEHGI"0h&S[nnu%_pUp
RIm)&gQ`YsF^-V$k:)P0[m<a;&a3(fJ6f)@R*^(-L'11#06J8Ed^^6O*Bc?n$[DuR^W\N&Vj
D;!P^K#TF)B,0&l8bEO<13"aBF:jg;Rq,.e,u.NXdh4S5X[1IU7]A+gC$;LFS#Q^eQ.0!;D"#
*C*T\9jG.EqYU=6U']AuB&6jh%43MjHn'AIn7?I(gjmi3'RB(+8!9j+!tZU'T+!WHqU?f;9M^
rOf303u76%.F`WrHN>P)mU<6nL?`:f*6dcfD<8q6`&hI(m#3+f4ZdHQ;`gV!q47Nj~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="31"/>
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
<BoundsAttr x="0" y="0" width="375" height="31"/>
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
<Size width="375" height="560"/>
<ResolutionScalingAttr percent="1.2"/>
<BodyLayoutType type="0"/>
</Center>
</Layout>
<DesignerVersion DesignerVersion="KAA"/>
<PreviewType PreviewType="0"/>
<MobileOnlyTemplateAttrMark class="com.fr.base.iofile.attr.MobileOnlyTemplateAttrMark"/>
<StrategyConfigsAttr class="com.fr.esd.core.strategy.persistence.StrategyConfigsAttr" pluginID="com.fr.plugin.esd" plugin-version="1.5.4">
<StrategyConfigs/>
</StrategyConfigsAttr>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="86f8a34c-2a96-4e85-913c-fa690e7ff43c"/>
</TemplateIdAttMark>
</Form>
