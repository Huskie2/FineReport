<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="成本拆分" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="lb"/>
<O>
<![CDATA[CB]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[机务体系数据源_10.33.2.25_me_enter]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
      '机群' 机型,
      right(time_dim,2) 月份,
      sum(case class_one_dim_name when '人工' then ads_value else 0 end)/10000 人工成本,
      sum(case class_one_dim_name when '燃油' then ads_value else 0 end)/10000 燃油成本,
      sum(case class_one_dim_name when '其他' then ads_value else 0 end)/10000 其他成本,
      sum(case class_one_dim_name when '维修' then ads_value else 0 end)/10000 维修成本,
      sum(case class_one_dim_name when '航空性' then ads_value else 0 end)/10000 折旧性成本,
      sum(case class_one_dim_name when '折旧摊销' then ads_value else 0 end)/10000 折旧摊销成本
from ads_sh_fce_fn_data_mag_dtl t
where time_dim >= concat(DATE_FORMAT(date_add(now(),interval -1 month),'%Y'),'01')
  and time_dim <= DATE_FORMAT(date_add(now(),interval -1 month),'%Y%m')
  and time_type = 'month'
  and ads_name = '总成本-成本构成'
  and left(class_one_dim,2) = '${lb}'
  and '${lb}' = 'CB'
group by right(time_dim,2)
union all
select 
      concat('B',class_one_dim) 机型,
      right(time_dim,2) 月份,
      sum(case class_two_dim_name when '人工' then ads_value else 0 end)/10000 人工成本,
      sum(case class_two_dim_name when '燃油' then ads_value else 0 end)/10000 燃油成本,
      sum(case class_two_dim_name when '其他' then ads_value else 0 end)/10000 其他成本,
      sum(case class_two_dim_name when '维修' then ads_value else 0 end)/10000 维修成本,
      sum(case class_two_dim_name when '航空性' then ads_value else 0 end)/10000 折旧性成本,
      sum(case class_two_dim_name when '折旧摊销' then ads_value else 0 end)/10000 折旧摊销成本
from ads_sh_fce_fn_data_mag_dtl t
where time_dim >= concat(DATE_FORMAT(date_add(now(),interval -1 month),'%Y'),'01')
  and time_dim <= DATE_FORMAT(date_add(now(),interval -1 month),'%Y%m')
  and time_type = 'month'
  and class_one_dim_name = '机型'
  and ads_name = '机型成本构成'
  and left(class_one_dim,2) = '${lb}'
group by concat('B',class_one_dim),right(time_dim,2)
order by 2]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="航线明细" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="mth"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="di"/>
<O>
<![CDATA[]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select  
       flight_sect 航段
      ,flight_sect_name   航段名称
      ,d_or_i '国际/国内'
      ,sum(no_tax_plane_amt)/10000 预期收入
      ,sum(no_tax_total_amt)/10000 实际收入
      
      ,sum(plane_amt)/10000   '预期成本'
      ,sum(acti_amt_total)/10000   '实际成本'
      
      ,sum(profit_amt)/10000 盈利万
      ,abs(sum(no_tax_plane_amt)/10000-sum(no_tax_total_amt)/10000)  执行差异
      
from ads_air_abc_income_amt
where d_or_i = '${di}'
  and month = date_format(STR_TO_DATE(concat('${mth}','/01'), '%Y/%m/%d'),'%Y%m')
group by flight_sect,flight_sect_name,d_or_i
order by 8 desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
</TableDataMap>
<ReportFitAttr fitStateInPC="1" fitFont="true"/>
<FormMobileAttr>
<FormMobileAttr refresh="false" isUseHTML="false" isMobileOnly="false" isAdaptivePropertyAutoMatch="false" appearRefresh="false" promptWhenLeaveWithoutSubmit="false" allowDoubleClickOrZoom="false"/>
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
<Refresh class="com.fr.plugin.reportRefresh.ReportExtraRefreshAttr" pluginID="com.fr.plugin.reportRefresh.v10" plugin-version="1.5.4">
<Refresh state="0" interval="0.0" refreshArea="" customClass="false"/>
</Refresh>
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
<![CDATA[1295400,864000,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[4320000,10800000,0,4320000,4320000,4320000,4320000,4320000,4320000,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[航段]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[航段名称]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[区域]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[预期收入\\n（万元）]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[实际收入\\n（万元）]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[预期成本\\n（万元）]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="0">
<O>
<![CDATA[实际成本\\n（万元）]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="0">
<O>
<![CDATA[盈利\\n（万元）]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="0" s="0">
<O>
<![CDATA[执行差异]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="航线明细" columnName="航段"/>
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
<C c="1" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="航线明细" columnName="航段名称"/>
<Complex/>
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
<Attributes dsName="航线明细" columnName="国际/国内"/>
<Complex/>
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
<C c="3" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="航线明细" columnName="预期收入"/>
<Complex/>
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
<C c="4" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="航线明细" columnName="实际收入"/>
<Complex/>
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
<C c="5" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="航线明细" columnName="预期成本"/>
<Complex/>
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
<C c="6" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="航线明细" columnName="实际成本"/>
<Complex/>
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
<C c="7" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="航线明细" columnName="盈利万"/>
<Complex/>
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
<C c="8" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="航线明细" columnName="执行差异"/>
<Complex/>
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
<PaperSetting/>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="72" foreground="-15386770"/>
<Background name="ColorBackground" color="-2167817"/>
<Border>
<Top style="2" color="-1"/>
<Bottom style="2" color="-1"/>
<Left style="2" color="-1"/>
<Right style="2" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border>
<Bottom style="1" color="-855310"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<j7_;chPaX\rse6u-X9+fY.8f!Z2BG_98@>".a'D:,U/0#:H).u8^$OQ:dUKdr3aD2TeT'f
DgeiuN]A485k[TO9cFC"VMtF8-1%[$+ZXth[,=F1Z.7Q5<<uaLH[g_O7&9]Ap0RW%ms<U>-gpq
@Femn&;dL:uC6[WHAab%(C6VN0W)9=fN-u38Qi9j#^--3F/TUZ6Mq1^_q`9C%pVF%up8Zn>o
[h.^eFZo/KS^(#NkLH+S+Q^Q(Ci#&*4t7]AlclcNceeWCh)R:BL6S<KPN<U_*1E#e9\YP>g[d
I85J-E)3jVT9;k^$Hl?iZ"OeE5S%+C*M[^Gi76kV7I:B9/s@,Cn(`<d"NN:WnoK_:J)Ch+92
OWo#6H80m#ICun&eM#>O,Kd!=S.N@XjkCr[hu5WSM1$#TS*g>d%08aiFtRUW.S<p0k3'!]AO'
A(,Zo_2f=;u48'H@[qFEjrpf[r!*_l7W'\)&ELDe@"B*6Iri*A)Y9I+X]A^H[*gMGimAL'%e%
9$;$Ts4$H]A`gi@(!Q/*.<G$O"Y&0ej7*[bPWSVK*DSeDSQ_[i=YWla\"1)+m'1)A."3B>f6#
F@5Z"qVHROYseMV@1c?.M"1&^F)7lq;i<8/NsR`oPFbQ12DnUPs+<&G.b-GeZ)mDp5FInI34
^cZ9iG-N'eJ:$co:7\4OeJl`30AGtsZUU!3.1hncQTF3Do]A=WD<KfLl,$]A,sSXD`VeGXB:Ta
UtF(rlQRmi@a3VXE\:>X"o4LmHIb&q1B-<En=B$c5Ce5*-DnBP<G*`t=lMr]A!,Q,NDGMlEo?
)oAae"3"%_%5CFJMI5G2gl*=k8KN;,+[(?m(0!+3L>G1KO^-441h)IVt3FqGg##9e3mTabLQ
R23aYiK:LB9P;IaL.k:jb4Ih%/R)g?$5g!TWnRl%/E\]Al]A524`P07,m$bEg*o@VBu=90H%2G
F'[/kh`aWqmQl.dB2(ZSa5U6kHSt#=bAi;el'UEa,fU3POjWFA1,X%'`"[WK$M0t\=MBlf\!
iIT3^ApC%Kh1eeLdG'FQKLkJ?@"oC2<:fNGaW`>mSsGP3As,.Iqc%&W`.e'"29P$*n?.d;LO
6G%l9RQq1<Xd,@c'?g=%qa_@(3=DFP-+G^=VoZMD&u=DHm]AnAjj:8hRK#F:Zeq(_81D_Y+:$
lp9493I%H,[7UhMpUX:C]APdkf;ll$@ae5<[:';#Oq6+aFkk>4#hL$`WM!]Allu$sE@,Y%,s13
)?/=\SR\5L90c>@3rCN8s1JLr\=JV;B.MFU,Zd`/FbkMZRGACnnX0beGcf[nHe7A?A>;AGJI
`X5t49#dlZIVNgq&f-qRZ)^Ag4L88Q-ST[plnhQrh[V4+4%OW3PPg7:P/]A4M1gl55#$+q\FV
Vr0m%KY0^o]AU]A!'(3":S(*RK,L<q,$PskLPj"/9du@D@.Eh<^=Np`-Z`$PFuPLZM[22F9/$I
d`Ft<\mAlV6UoLgKR"N=!$m?lSHO'KA:iTI=kZ[b\.bH0D9+Wl_<"`FnSe+bN#,9/SaSLd]A%
?Sq<n7e""dHC!*X9;j$)k9MZ,^>fIZ+"e39Da%j2=R:`P]A8kK^R.1bX%X0n*94U.hV!q!8V7
a\@Xg1!K.p$(j,i'@40aOPp@/:Ek=DQ9S_D)fZ:ram;,=iZ.`VrS)Fu\#T;`'QX0r#G]ADYMQ
/1e+d[;qhQ-opYNkS'rhPC-[.0>>.QLd.pbJE<\'kkp:2Lf28U(6BU;C44KcN:6&H7Ro#%",
+Y8Z,WrZI33#)jido-='iP>TQ>>)IFc:mLUstc;IB`c2-5Tq3ksnVu0"_h=.sJ$*bWUC<^F+
%dJ+$bc<W!^i7+,RcCtR/[W,*h,4!^7j6`1$pGmlq8c7c[q38oFhX-d6FFq%OtfpO:pnL#=J
0S8@=tRT'Qo4e%H(3lW*<#=2UcpA]A'o:ZS_=JbeC'fS<uBJ";Xj7T.+H5(a2#N?9&gB.\ND"
_+8:X-rAB@n*#ip/lMUPWjlfG0_nT&Z*__[uRd:aPR/n97Z[^Rlc@%.m[LKu?HZGXd1pS4L3
1o&mUB'V(pA6?3F04SMWfrPu@:J6dF6tTR72k-B38*P4X;2"M@VeW:>&<U!V5eA-&jQ??+nX
XP<[5)\#6ld=7;p4!KHt=#r>N7JB.?%b8&(DE27d)*\VQ%$184+<(git@<qk)"aP1r;SO$)X
0oMPA>(W4_8,QT;%N[QR/s5]ABJI/,7ImJ>EerE03.l.rZIA;000%:t)LINntZedT`:sa:Zor
XH[gjNpGGcShl)7$5Mm^Ipf4.<U)fDa[EAJj9D_#`W,&+G6gmCa%n$3<V!9)nM`>`G/?3>k8
u2tW&KW>':djp?U_([`Y\R(I[e^3$*X6!Z]A)861,gf\8J'<DVW9-SjAtT\+,#<F^l'Htji(Q
_[D'C.=1VG;;*e^6G/J<f-HBn0g4$4/C68!@Q!+n!j:W0XMQYQm'l-Is"B>fdS1A>YJDHY-O
:C&#0L%9,nfp[tDo=2iD@_/$!H*O#BC:NbP\r\[fNSm+X,W^I?NLf&P&d.temP^SA;E4A%/I
e$\eI/3ts:FpofXSmZQ<U<95Zm:qUoE"SHT?)d:-D*'3C_5_E84)V'joApYr)(\5s'6J8YZV
ii`4+]A9/PZDhV\"+F]AH0`W1o",1Qmho992P$$"\o-4<\S=3?M5/g,/:<r^;[;gR(#[>3!o_f
5Kjl:!ro7j\mmW`]AXKn]AEii^@djGPA)L;hq*&h%F-m-:6G(8!WV/R.e0MB1YrVNWEHhcGI=F
<8Ik879Kc5NEbf8h#"h""'HVY:F&Y@KSl"D6L;H',3m6dG`kaHiDM[iYLouhiBaI1hXdo1,_
9'>e:NNRcNgiaqddOV,C>kSZ-N_CQ=2)^(X)j?i35Oq7^OFWJ$TkTem53:![;4=7eN5%]AH5E
BPEASTpTXQrH7/_+Jgmm6]An^"72;eo%a]A$h6>2RVX'AaI+#Z@J-eb9P>Nb-nfK4R+1L/@2Z'
HDR(V"%hUuZ(cm5b@LDWb.5WV`0PQaD'c[,=lbqq+[ghU(*XT_D/JQ.BqaWH+?aMo2PcDEkS
NfU^KC;eF\IhXJS1/`71q>\f"g'"[dSTfri@?P%3T;.Nt?\mk6aC:-B3pt%XN'q9WgLX=u;J
MgBOD715Lo#^5O*>VSEU%<A!^2PoCaHb_c^S_dohn*5;\[2K1;qs#S]AUUjpYeseV/sN)GV"u
Ku+;i9a^u:_7gOARL<FYb="YJs#=[6KGBs:iG82Jk/(>sqCN55&L',W.=-N4ImCB%l\[i*Ne
\sgRET=W8les^a:olsr-3\f$QI\jc^"6N4(BXt_X957M:$feLD6Pk9omLi3/Jg+]At5MN,,&\
hneoUr?NT9i2,I&5u"^9L"$DgjrZgm1-S/ZLJa;P8BuB*=Xkh5j$7LIbH#HB$H00*/Rd>d`]A
HB:X]A2VQ7[;8.k-(D_9g\F*iq3Wt5LC\)Z`M#0N,bb[:=3V7/&')lmfO0Rc0ehFGQ(6G[o^0
cnTf02/O*a'/['b>sL1;`@m`k0Q.5LsG(A026pD2FUg:[C1O<$Y1V>^5P^o@0g4YLDi$/\/f
f[/O&:5:0Xm[G3P(H%1:EQ'/+LmmI$W7Wf6]AN8J@bE^d>Ns[7Q)I$3eI&80t$6AF(/l[4eKf
RK0j'VoB1A:c2sAeO/cL$ng[Y.Xa,&Q*)q(kJce$@T#'FbA0.HpkhbFB'CA:p8oWC@_1g<^9
k5X0hWA-9M3co>89\"2t``eX"V(VdsD@HlY=Frdjs2YBM/.Z=XWGYV#qYYSq.un#k>+hY]AHa
WQ&m)VhQk2C%&T"]AWR0m0h0&0KV"%a420c]A*.Df\2KrMlhW0/AAN2n79]AS!h$X)H*(Y3Z[jC
k_Q!@;D"US`T:.[@'_Nfs!GJHY:9T>f@.%M!H0krO-!3Qb_8t?+#+F6bTh2!RA*=Z/Qb\(BT
H^g?PJWQgk<ERRkNpcinr7'?A_YIX84rC!p+?Nn7<5D#6*$WhTncO(PTn558]AtYeTERWk$nl
#u7[91(5gW6RfVVoppdnc%QRn,5BUT*Ec&Tmu.q49@lVO_e['@j<)H@@mYpSae=a0CT<JLJ[
;A^EFLpuAN#=h?;95>C+h`+UCSe[-^P2l:@M]AkW9g(jP/1jbE#CEQD1K?<=<5Qq,SaBBMC/U
FeALoqGGjR2e^<_9K(ZDRPh&fQECK_[huG.:@e.FjjR=/T*TQNM$9&&$-"7_Z$biS/"dXMgW
c@%)dRrYRA!jG@jonL?/c[c85<B%Q#o7?pnYn@LZ;@2n?b"ZM9S(+Y'A2\f"`]A)1@D^qG%cl
3.?3:G_3(Ub/6#eKjO/1EAITU*:gS6#<Wrs^WBlu4jE7tXB\nsd'75#s!C"fHi8/ZQ`WMs(M
n[Lm^e9/N?#^/<oj&Q_>dLR&.26+?dT!rd^2T\2e)Y]A[KY-,?YheY+'d3t5,g%R1HC7l1_26
uDce+\e502jR&D<5GQ0oh'*W*Qm;hn1L([IsPN.p=.>YE%U1K;Lf&Cf6=k]AF)p"B^SB=LSOf
ag<6')$ncqgr.>*I%IRq96C4`a/<FbJ<;I!^lcSc+3DbbHIFFLmK4=W01dE"+!6[ra[%,`]AF
1aq\)`8:q6%)cRWQ\n13i+d#'94@<ZZ84!V5(U;U/=aNgRu^O>&Pm7e6[d+pFN#Y[(`YnbXq
LVSGI'A,G^[Y@kcG`"$]A8/Er9]A$:erHHYCP+Lo_A[_:"J$@]AjO?,cp;q">]A;61E&R%rWjtNC
Ju.Qm0aPP4fj:;MX!t=i2545o]A&LX8GIO;G1&(AHP0H:6DhjkN,j]A7^-:=+ZOLA^XM8Atm<]A
s4%;_eT`NOME=(#VkLCm#Pj.o1I<SG>CR\E[jSL`A6_M<!M$YmQto'qt[sBf,MeH%Tk3=>G2
!PQ+K&I_3^D,/_&UR>k*6EO&>Orf=^hnMe=B`mdn'=X@47PA3EY9Nc#:d1GteZ-2O0FqF_Kd
Q]A`KXAAYCKN0^;b@-)j&O)j]AL2Ki'*n-rQb["MVkn5A8WJ#)oDFmZ7(XRjEh*mf&0A0PXnk$
V[N8dh/^-_``j$>hiVH[:uG<S^c<b<p`>=RU,)r).0dZ-KCaS=6t/ZfWA]AQG8t*#'=*jkJ),
F+_>je5+o"GT[?h8)`I1.'eI"E^L#]Aj(PsL:Xu4CL%J6/ZoM\JM!(i)g7<(6qDm`rSl8g]A4(
\)^]A-g3$q:!ioWr>mJriJOAr';e06)J(gp8rO21>coRg4%mo[=,;EMg=s5H71_"A(p;\7'lg
`25R\D`Jsmi=J!D6#apZ"<78<hXlL>dZFH"J?ur,-*s=:49-k&&k''JD*Vm1BS(X'DCm`<l6
++2fH0=UI3G&6i7lt.m+3&pf0MifH!-F$A%1<"4a6,TI_:c:3;1OBVnjWWQ,aXu@6uW!(K_f
^[#n0r3'']A=9kp'S<E4WA&,:n-+,I.*<NqJ1nfQN16W_'lO'*KbS4)5_7bApGO+lt?.:B_B\
R3C[R\[HW6Gn]A*C]A9lUjn#s"7dmnt(DjGB-5F*062Qj*udr3jGEq=l"FZ37@f"j3eIb]A5K`j
*F+@Ahg;m>J,m;8Od4QCJOM!gke8qjO!`meeO9*j'<:4)-]AgNUoaaf)-Riqj#!)8$b[Uml"]A
P(cCRsn.>FE/;_/DO1P=:9ZXQ8G-E^2]ArX40^2nT#(-%Q1+_9<lE(m#ITY*7RSn)%@GqUQo/
gPhF@rPa'aY1$q/ghIjI(6M!qTMu9:G"#jG1kC5WD!7mIu5=taq%6_ZB1RXE&2;gq:CXqB`Q
Cuk*YJ-k+>XlI9pkU.jD[8pNqmTq8+&1-NI)"\Ee3cD4&$(d/h^rY`;cC]A=h_M>h-?\M6"]AO
ATQHf(Z^gOLKF"]Af1b0[r@!0oR(r'f4^@lfBDW_YA6h*/;tEKKF4QHaS9b(\-*D=M5mDsteF
(sVSbK@na-hit.CC./TG%PI\N.biP=Xq%.\tbO!/::O@&p%&`+$2!^D%'T:0;aY$]A:^N$2*L
:DG;Jr7<4fA*'o'H>i6B(>]A)\jn=l+U_?!E>*2cjgU&DbI$.^R>;64;kqc]A4\arpf2MSNGOi
he"Z.P8cNC:@\?R9P4WHr%%`<-kIe$0C92pl5GKGPI4<r,Db%ab*U56%([r*s6Y.f:-"]AR2r
[pJK"[VGF9J(>(&USkeRS!8teEZA,Qs$/E9H!<,R)'1KCJ>(;V$.60chR$E/$JY'R-cdkXK!
&;rJO7Vg:M7&roRL8o&qnlSO"eSH_*LYqU8**CR]Amag4/JAYLtXk",YKu8#X-fZ?9C4:`\@3
Iq=MBV*gP;uta$OhFH/g2qm292[clV3nN=M!f*`T?5QQ1AJKG@IPU-\E<VplbpqWC@t0;FT0
!dqG&NrqN`L?bPDOFqH>:1IIVdC\;OI8(Jd6$c-_]A&3gB<lmU*act.k<!^FcD.7p1LFhMMSm
S]A:a@PEpPInjM2i9ID5#+-'TdcJ.3o=O[U%+pWD`2_Z:BatBpWa5?V<q*,:>&`b'G"T)9>cS
)7V.Rd3JggR:OJ+6r?78-gAd.UQ:n6j>\iWM\Xons<Mi[&$)``\(45:QtcfY7hf/B6Bp8uKU
[Pu't^:5plE*rX-A_58>Y)&P)P)C,<BB<*XJ6+,`-Xm:QDP-&X:6o[W"+^W\DNBEfl_@rWi\
!R17Xd_`JDitCW+0Q^3q&dJUbQSk<-ju"Rh]AC\9!(h+cDsBRYZEHTgi_9_THPj5/p7Sm3AVQ
J?S)5?<GN^ZGnEf/eYo?$5:KFq?=5?]AZ'F`Eg1-3Op5(A`5VG"XM/j"h:;%UC+&CS<r76q0m
+"e=>+j8)RQ-Bu^;.^DKCXB2-197EH?KG_jW>uIr[C:im$%^F=C0WoaAJ>sD[SWkN/B0FZKu
S4BOa9IZra(4I$F-7#k\'LO8VeMEOT1Rn$6&$rHln<.["T`C%uCB2=(\(H]A>Uo8;Z);5Hp"s
*3*9&a32ei6RR'p^024$Uk1[6h84m175fckm5tWO4!CF:c`fKSg>:dfNM0th&a1A;<rInF\M
c32^c1j*kp^Oq)Mr"u3&)1k'$J5f1>b>GeKUPuWb!1X7G=a.<6^*EebA,5rc)]AJh$TBEQ@(\
fn=g&^(A(0=4489P1m,&$Z3S9mmK;(lQKXU%H`kTpjO/VIAt]A]A9ikBf:0FG;7\@R%>%>3=_5
O-2[)*a4U3/K?2U9YP03QdA+<>Y3M'/@hFl;Xh?4ag3,A8nh2D@:6Dc'=1.lGJ4cL.4,l$E&
se);;_jkXi!Sbg)Ke[K956fGJ,ND'jhcX<]ApL=9p8'":&SZo$^$)9@GsnR03;Ki'u^R[lPnO
U9mbG^#=ucO2=(U>[R%red^f67bL1m\sJG$R^JjM4M[L;']A9iu<C+`"']AQauhX5.i>pMR*nl
>Y*?,iT7l>;bSm`o,Fe7B.GjsrV0)ELl/#gCP'$cA;;h>DCt6`_`!OL[i``"3E%cBN9']A(Q.
g^Do,GO:pM9#?1tO^-[Z2iYD,=!HcYd3S##N^#SbF/WT'Mql!93pPY3@gsn<F4;-HT=efs;,
foA2^%YUp)gt&E/&&&cC2du*?dGPS)*l"r_JJ$oY#]APMe(m1KNfam.AcmH2N_(HEJRX'RdC2
L!'52.9%=W7M23u!['X]A[/"%jCeQ8T2Wj67>1Op'IT?26f*Z_O'T7^\RUi`'cp2Lt7r2(#hV
94/[MRgpd.pA?>:kUf@?+Yh89$Y?sI&qP5$nn<:g>!3j<Hqh'>Cgk%U5Co()*>tY[0+!,n&s
TFD7Q),GZar=CfXLE5.2f/mFB>%"X4>/WF;IN[12\g9^lkqR(rhH*F2^I;J/lUsWNsS\q/]Ak
P\0p]A&&Rh@/dlOFfX$Z"-4548Sn@N<jZh:du2);X.n(O4#H1elZ4g*6+@8uHT3;9"W0l^n9_
&/O!SKOj:%ZC4ASIn8_/V=q!G?p"mNrg*,ht=f?)`g"XAi3tr]A%3?g]A]A2MRHoi>M$i.FBJ7M
(,ga>"Y?ubn^%[Td1SK9I@/5*4?"+\m`Y<Z^+hIm/eb*"7R=jDaYA'V"SB1_2(6Y"(M(EU(0
T?k"51hJK@`Bop]A3k4cc]APs"+0-50/>N?udiEcY8ELP(c[Z^r>I/rq9oiJ:@X7>.jE_LJs:a
-"S"bQ"Ba'c#;-^(Oj[p=b&Qb1u-9t:>%)%*%6HE(D]A)U!5G+$55u&h8h[9CH8p3h?gLF)jC
*-)]ArXBT2=lWH<Dhc`@tN&lPhkaBc5T_HD32*77JhJnX(9'YBDlD,W6fapaisC]A_+?LD-[fV
+Cadc7VK[7Y*Y`r;:(9l[5Ufi!0Xgd:W!Q*aS"1-$DQcj"Ch1Y1VkuO-dTrAfcZbX7`_G$Hg
L,3'6FuLPB1[]A]A@Q6>,l)L[p3Brdcq*K73)\T$TK#)Pc&G'YECN8%6!N\UoWT<$$l0gY,4N*
l"k2UVS>&I7'M19b3h?*m58sn;0.ZXE\6;I/(G3Y-3'PMkh=`U+YjD-(.-\4qMlKg3q/<9;_
/p(1I`8+'B>HO?PK5f9Q7E#1iOhmf:#KUG1M..+#lF<UB5mF>4dOX:o@*mohj8'<(2M-*0p/
T6sROORO!>oV*JF/ff$64,Ynnoo0:2CVCAJ4b@To31+ggSh59BS_<"?8D7(+g=t8EZ-opqD>
WfEMK/m_59e;h".o`EIS"NtTIf7bM\td8(SXq44_iY/i-<Cb`+1,aB;OI>mfDr^8!>it[#sJ
T8'MT:,RpKUM:=44E/aQiSd[R95+7#3%Zk@qJ6%Zs"lp`;c,?J0ip=PH>>NFnYrd<fgMRi2i
h?"AjiaJ5l/;V?5X@9IkH1s9<U2QfR4>hORb!""S!Utb@QBUiT*7^'R91G[J"M21fDJ1C01b
HR%'Z51mT`W408t.Zd("P4(U+mL]ADGF]A7+F/uZ;V*jH1gUp^Ufe'KhH)h`-Te97e3SAWgEPi
Vs.[6;3kj6OFTEnrP$9-ckuRaGLq=-Y(=_,T:4Sojn'/@u_R(5mRMMh*+#cD[$3"H@qjro&Z
+r+JiDWT'A]A^&$XbiRl.IF7IPno:hr?P'B8+.:cK&@:9ET^"%OO6UD6/PbTQQJns=ljdCoC3
b`Q#A+MY,PUR-Br*ZFq*0ZnanYLR5GZ`?<TV&Z8"c4mB1i<N@TcBRC!2P;e+X/1<uT0[FM:u
bS!uOM03IGY%u:d#b;JG-u=HUcJYfJ0VT.5Fj2sT.6XcB;'(QA]AW?UPJ$T7T7!Jjsl4k1W@D
C5G+.mtSHKTfKhCQp3nl/'6m;7fTjM(Qm*!@.m&RkG\Eb@?1jul`-O^[klhuYA7I_-sb&sjU
6/,s37=nH/_/=h>@)fK$7pu$ViV]A"uK9ZT]A@UY:3[jN'^Q*VOuJpN&W)s*d&DXa0ib[@\FB,
k3W\:!R7hRGSQ+rme>Z))dt]APFr\C(!oG$*-(MRW5<qjaX4_@O9#;<+JAh#%b)bZ@"F0&ZLL
o"3]AKBG_s9@^jPYP]Ae>#`W;3KL#((FL(HuR\e@+CKSof%:3r;WI48c-6p_&EImQS4Bn8R1@+
4T9DSE&=rrmin6-3V6%nqqeHTB&a&1kk2-[:2MuNeX)fsP1TQ:;dP"cWd*t$mf(=l1mq,gGF
A*Q[.Dt;Ap>A:fJC^Th4<NZ?He%3rn!c;5oMR4M7`)%?F9:b!>9KP>.]A<UHi8Z<,JtUP=MaZ
ZHtc^X>$fcZ*5:44B$.Gu/_Knpmp.RooH,0fj>7]AbU9$i748V0S@QjKdUmgdTf`$^33V+[C"
1s_eZOh,P8;joR.snU$0O>9qdWTa<Dun>h&I=Z8<t0nFRXA(ZY7<L^M%%3WSt7YuoP:XDYeA
_KYhAU*!!4@k9g5T@<I`cuk/d6Mo"g)dPu@5nP/N+pN+84"gH>3,Hf*`MC]AlXCq$eFkgqUV1
o]AI-W/jZhD3sJkt[PY`4jkZpHc&s.dEP/0W7%I5)MYM_0W)_u6!JsMq$]A&htDs97O-_@tmk;
1H.s-0n?>t<e+2/'4<,eN@Y;`5f$n4EHU_>A3[g%Ad7T]Ai_6a=!1'rp,u3^EsC=1%=RLV1qM
VE%TZUFXkd#(@lGG4N8!)mn01mXCjW$!t*ckisG;k:JV6l<?=9mH9O[8'3ngF+P`L37:k=#s
!IQW/k!WlXr>U&)A<^)fA]A"VoLBG_6*XkuIq)K,7(UQX-o#"3q($mq&m"^&a#jq4s3f.&X+E
R\TXnp/\0K*6QAgc_PANO_<n(-f]AX)q&!lFa'AqX976?,Ni8)f'-UiF$YUjYHNV^GY0<ST]AP
Z"1b:8"fI6A9pMApNe"XcSgUQW9\1N/Ur'Eb1#4L3aTX!h@t&R9R/BE03ucCJX,o_#bl()LY
;51Qu)n_l\<,>gr;Cl'$"fVQ?cZ7rN9>k-HngZ()5#9(#2iCjM`Odpl_ZOg)^"mjKd&gFt&k
kg@XPX+t-)([nh45-'L50Wr+$TcM9u%6L"50ac'D:m?\qblrOpoZO=P+#/;Ep4JkW!IkpF5q
-[sd\cY@:9"_R(]A+QP;=8&cr65ff&?]AT/FT')#$EmfAGgX%7bLaCLc;me9Tk_*cj%L^N<4Wl
YYYnSq;*7VG<7>h%CMi[/ra!pNqE(O=(>XV<L\I1i$H>(;DNG(bO-oo/Mp<7#ieg?jT<(i3q
n>N7sUr*\r[Q@^N61Q4d57O7!pR4N"H&NRX/$>O4aMg:pJ?U<Jhn*8<EJ%#4'GnPE:e3sP-[
;gLZl_0)j,4_#%DJmb@tdWJ4*X[!UEbiE_'i29Kq!Po'^J42qnGt_NdPeM*3@H9^bQ9B$Sf'
f4S8s$\0"WW^M'kV+\IdEQK\ENAP[KlF!Iac4T4G<TK9f3Ok7"2@uaE/Y5')$n9i&9Es;Mb%
3hj\Tbb2),5U@,AWpD%+u>E4V8\sM6sRu-rR6T2A;NkKI)@-<Zl7OY7U5%oK?%$r^Pn[A.^]A
plO6JeIjh+WH/=0eV;*)LT+0!&I)H%=-^dUqM>#Rs)@UW`WML1r"#8)8X.!tmjSQ1'Alo1mY
E+gEWakZ&AWG<]A,I!^>_oVEhD9o:Jp]A)=\5<r=@ti2SsGTgM"p<>b<Sk/_&.PiqW3KQfQp)^
=M&gl)LjJULR?E.I1sP_AG0;[e0GAFC\GSaqs(Kr:1.LJS`nb0oZ6+pnk+Hr@DXq*-%OT2>*
>0s<`/Nh'%$,d2g#?["[-'N;aO;`3uWCun[Bm)KF6W5:3^+iZG$*/:RaI)4aUdQS1b]A\1L<S
ck8+6LP)F1Y4>Rl$ERY/X:X0<(U+\*hM')]ASb@aR?]An#*;`nPBYAq`*0Ze#9#ld&,J4IH9(K
V;5Y!4(HrSJp!"m=)m.g#Qcn.Weoa(4GBf5R<X;$SKSQ<S6Vdb(mK2HX+=#?3:gW53!20C>!
E;T:*Q@AML&I3>fDe]AP)mPQue6mD<Qi//X8UdsR\H&EWSB\AEAVkeI**+O=a23MA9p/)]Ac*<
Kb`%X,L>6[mkRBlatsnE1$8a'=2p,t'[N.UKtg?H'FVPq++WaBbk=>,kUO7>>R+lk?U65NBG
B<q3^]ApncW)7dmAV.-5pP&Ud%a@bKE\XgR!4.hOW[*+'OsRD'-8AZ*802iX6sZn<?Wi2ko;l
q8*MpmA+BKis>5g5djGL/LOE\7<_j"/N3*AaV@hLnOY]AgL`ZFf5G.?.'0(+k#Nq`*QX+=1)g
f]Aj^>NZqHYj*&M`CU@1&r/3tHfRK^nH_.6:$3EcKa-NlS'dm@Ddt]A#hQ@o]As0]AqT6h!AP;p1
C[is/hA+s%:/qd7cf'+%I*jK:Wn*$.5:_*Pq=OT_+T$R0.sAL:5:0Tpa&"H9Nassse2oM<U0
15^O49*^aK^onD.uO(Z>GKhEJ)HQ59gdP%'c?*D&%Y"%16W;:\%Lk+`0W]A-*=jm=gj!CF9h;
7Pl55_=hi4lqD"FgQbh7\"&_U`pITg(b"R`mR'7jB*Z7=DIlP("4\cIg#C/)e:!.UN"?aO/`
A"*Y]A?i)j_Y%S)hJ.OoiK*VoqpTHJ+'2Ba)(Q9%quiI)j%GG]A)rC/Q'(USdn%Hqja^_.UG?q
3]A5]A3n#TP:NgGt7r+aF<D>)e+ZhO^tL19&rX&AEUd5l^kg#379n`_<dDD2T!_Ej9W3p\S*Os
$,R&cZpRmSL<$sPOt;E-G?dje9MZdm-'&E\,$l3oU91'u]A[l/=$M84F?P7S./m/&(![&A&f-
&soq5B7'!;&<mjh,A_c0smin08q6nqXuGPBs!UK3ZOmH#=\hZu*l9MT<B?ViE^NXD.@a:H.D
'cqVU%e/fr`k<%Wuolhl8&[/9cO6l=gP_u.&`@!iRna]Afg>!1=mS%7c`=mt'SDsOtus5MHWs
)U4!K^XV/^<=:jMCe</DsRjK]A.ApGmWT'-L2D=]ADthcT\Nsp=h"ABIVTjmG[:&ka/I3;ZZpU
F.$XVAf!RWQpGJPTi2Am)?YcrEN[G"a9+pi\?/rtQHXRE[!JTtmoP8\q#g#@A)AZYIHGLp?O
,<MMr&F+)!f5Ir49l`B^,DsqO,q6V-E)!bqdj(bQ49+$cnD<+]AoZ0?]A:G$HY]AXeu=@KgWjgO
AU]Ak'2Jj%BtEHW@8cHX_/LGOI`;HmDu7jP>gCB")K[he0;oPUI3&e597hYmPf+'1Z*J=_=0>
rLPiP?+rNP\#E!rK&sZ>=2jk<Am;IF1lW+8b(g9SEbbfMR<iXs\VL(B*Bs]AS7#[f"k63^&qm
;O4'KUDEKQVpu@]ADDZMgKrF=aLD;m(DEJ5\grIrLrFEWobB9r3JCtuD/<@!64%7mo2[/Bom6
Ub94XPS+3=Qj+\3)/KHqL0!^Lt'3aq-F^lkLHZcR\R6:M=(7!^s9Nr^.D8AI^JiNlk"MPH-l
&DgYd!]AD0(,m-eh)6JefHCV"_.QQtRXSDK[Y@fS0Umm=%>N#2H=hG`7&2:u+EJ[&o[(5/!?<
:5PHju#t.c,@F%m<&aM<T2632ttXJSN"G5A:t[PJHQVW>(ITCtEN']AXp-8l465P+3jf!c16f
*J3[t8Ym<(__+>P>D9>;Cj&3R5K"&rS;]A22LTbHWN2BVCp^4iqVacts[!7Z-_;O7D)1nU0LN
PKW4bSf05>l+:-NI%&:B%L1>G\f_A5Cc?qUM'U`E.dpNQnME.>H5PX%n4Lf]A=,Ea;]AKu!"/@
m6C;pBY^$[!S)o1RKleH.HpBijQH]A4sE&0aFrR1LQ]A?F-b(i^q5:jqhr'5XZfE[`\j:;b/c(
b=]A^;T7MuDjZ^q:ItGo-BN]A]Aq8^"nW/g&(L`p5fYbk@jK*tU=KjDkk'V3jiI^R0P]AKBeTa`Y
$Z(T':8uS<OZ[S=k?sOp4^`r=a_cl%'n<C8AEVo%_M08802A0V6D%dta)`XGBSA\H3u#@(Hr
P$?2V1M.OB4;p\k"0a5WV[a(C*'8[=g6gIL0JPeQcUh'qLaLF46Y8iC/=Lc\fjB7Kt.fZE`l
A5ftP1-*UBgjGBV=jC_*\*3Q&IEA0Y99iMauHoJo6M)Y"g=-r?=P+T3DV-+-:*t1C_0C^D8O
_[fC+m9\Kk/406"kl1OW9>hUg[JFA$n.Uam92(T<<C2,=MfdTN#/+gk^cHGk,nqF?1#Kjq;5
.Oe)oQ6OE^Fn`Dk99F?ZP4e[Z*3Vj1]AOdn?Ge+$771+9d.)Hcc+_j6H(1F4V:;#m@Dg=+dRR
j"o1P+UE$38+gSCA"V+>$)7YEeYoPHrc,,6FsU]AQqWL_>2mb<*]AA3EHR,U!0\K,1#5!<Sk'1
gN,<f-G&*im?k+33PFesZ'B:-$Mu:)J(?7H:.+*V4VU6m;aEYnEk49Vn:2+rN=aTNa;U>Da,
`"VrW?PblKM8?$2!<(IUr*AV,W#HooRukP:gs\B_^;@D4f4EA#\t^0,VB>4>(^BXs6^SkG=:
h9>'I!ggH%j[6$=86,?2@fHf`C#]Abqsq-]Ar.Hjcua3mn%.UNLGW9"\3Q5I/=7h4%Q3g]A,YTF
TifT7hYC\+MZYt$PbMrSlRJ8qA4/;Y,7V?hl4Iq?L/lb<F#A[=56%u!qBXR:oJ"!%ctPg_n>
L3mg+:^3XU2#ROP1$q'rY+[I)R*Ng'"#h7(7OOB2#CNI[eEQ5f`JE`=/qG!5N`TOR@a7cJ:t
GFHr@pK?U]Ai!!r+P`eE5Ur9F*\F]A1(c_1.b(=oI3fGN6%0*r~
]]></IM>
<ReportFitAttr fitStateInPC="1" fitFont="false"/>
<ElementCaseMobileAttrProvider horizontal="1" vertical="3" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="470"/>
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
<BoundsAttr x="0" y="68" width="960" height="470"/>
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
<InnerWidget class="com.fr.form.ui.DateEditor">
<WidgetName name="mth"/>
<WidgetID widgetID="0515a1ac-78bd-496b-9a73-a15434bff764"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="dateEditor0" frozen="false"/>
<PrivilegeControl/>
<MobileStyle class="com.fr.form.ui.mobile.DefaultMobileStyle" isCustom="true" borderType="1" borderRadius="2.0" iconColor="-15386770">
<Background name="ColorBackground"/>
<FRFont name="SimSun" style="0" size="128"/>
</MobileStyle>
</WidgetAttr>
<allowBlank>
<![CDATA[false]]></allowBlank>
<fontSize>
<![CDATA[14]]></fontSize>
<DateAttr format="yyyy/MM" start="01/01/2021" enddatefm="=format(MONTHDELTA(today(),-1),&quot;yyyy/MM&quot;)"/>
<widgetValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=if(format(today(),"dd")<13,format(MONTHDELTA(today(),-2),"yyyy/MM"),format(MONTHDELTA(today(),-1),"yyyy/MM"))]]></Attributes>
</O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="82" y="8" width="150" height="24"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ComboBox">
<WidgetName name="di"/>
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
<fontSize>
<![CDATA[14]]></fontSize>
<Dictionary class="com.fr.data.impl.CustomDictionary">
<CustomDictAttr>
<Dict key="国内" value="国内"/>
<Dict key="国际" value="国际"/>
</CustomDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[国际]]></O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="337" y="8" width="150" height="24"/>
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
<![CDATA[区域：]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="微软雅黑" style="1" size="72" foreground="-15386770"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="262" y="6" width="76" height="30"/>
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
<![CDATA[月份：]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="微软雅黑" style="1" size="72" foreground="-15386770"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="6" y="6" width="76" height="30"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="Label机型"/>
<Widget widgetName="Label机型_c"/>
<Widget widgetName="mth"/>
<Widget widgetName="di"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="33" width="960" height="35"/>
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
<![CDATA[1008000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2304000,2016000,2016000,2016000,2016000,2016000,2016000,2016000,2016000,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="9" s="0">
<O>
<![CDATA[航段经营明细清单]]></O>
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
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="96" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9C$$;cgE)>%FM;VQKM<eg]AinWblTE=qUTRagBW.LJh`!4,atI@NA)ZKG9Om,WS_h%R/=<f%
O)tUl(=YXMtJKH0*,?Ur_R%WIhc\3C8N5_BC)kS9%Km2n/LL:A0(!bD5iOLO=jCm'HH?s8(?
^f%RY4GH]A'CFiXH)KS5$6p$0\dhZsMpV1jTH^Af!jaIehdSp3"9UbM\rQX>,]Ao=iVdKZpaPO
>:[SIX"Z<(]A@Q%47LbBoIjRAh7[Asaf@:C7m0d4/,f'H0)jiqrm:?hgUFntHt('h6>U*``5Y
E*WlXYDGiFj@/Q^/SN]A]A,erM.[.Ai2,_N`sX0:-=VdWLpD7E;Ptp1%Dle#]A6!!UU.YbJ(A('
F%(qDfa5g,7%MK!,@?`aM^'iOE.i2ICt!0k_JU6?\,@$$p(XB9e8%4DT;1%8r*Ge*Ds__cp$
k9FGU/:->2G0NmbUq33,-tfd)$5>e,I(j,'@?lM<Z1Dq!fS/r7YRO(<?C%Ki#.e5EY!O38RX
.bLGsC-H5,1)cu^M7tqATK:K:)dI7sO;ML:n*NcDMUfauW9t3_JOS:su6G<kHh"e^ppc:nG`
ZYbDa'e.^23m-[77BX;=4(`XH8rG^6MWT@R[BR"#o/dGXsM<@-dIY<l`P2nW*VI7PqtuKaEO
Z%.P(.F_I6+5G.,,r;RTXgp(a;H+Ni=q86o2;&\GS+a*B8ReVh;0)Y2ub2IaKRlg3HFjNg<>
ql*ODFWU[=U?KmD7j8aggn,E]ACX'mps+WAi]A]AbTM[EiLLhF`e><%k[a'r?Of=7"SZ`"0m`+K
VReFsKf16>0!Xj[EuK3GU1:_\kcMH#0DuPuMdC7/1)HC*h2Qre*nL/\?J<;K;t^6*='frK.r
b2ehH94L7#r[=Ag+X?Wh0O$l6eeh384khR^Kg[7mO#Q%f?$K3[BJ8%ZNX/Ye#>5Gb)-+)JPn
p!?b.1L^+A?)m:8<U[0\1NPo9>_.ZVmo77)qBZ`bq#_jZ[S=I!5$f5<,c9`h]A>=gPEfgGCR?
$FN`B)Ys)h\]A;HQ;->q9pfQN$B<2,#n@g+M\Y<Jr*DVeHa2due82HA>a$F/4$i'Dae=TXFi1
'3i+Mn"t0[.si&_FX(HIH>_0"Dt?:mm:c1I5L*R#q;^+)UlMf[NVJNlaS3#WH'-jSd?<MApF
0Ql$XG;g@bJg6CH;lLp.Oj:2mDS/)EQZ$P]AN,n1rA3m`#Q$VHfa6RF`.uVNEWC3YuX;fj=4?
UKGt*aX4;5K*mucdZoNtJCFC[5iepFG&(55mMe%7ZPq$o\NTq&J$`Ve=*=N[G@K16781D#so
-D"6Jp=4G'^['PYcqcob#m^BQdmO5o,_*Kh7$VP:?\X_@UU@nYEhEJ_otl(Ve'[BP2+9eXrd
J?Bq>3S_+7OaI<C["m3*#Kq7!nYQ!E.dA$X&i#E[4%d8Vaoc^^^)nsrBm]Au/fg1@!^q$&[W@
GF[Y27>%.,mQ5;Woan8hKJN:rq\jbPS()BlGO.#X9A7f5Y7cjtatFt-1W5\f"7*=ac!>[9bT
od>OZO4gSEaC_*98a=>>?OgJ_ab+<0K!q\Or9dI+WcQ8VIPVe:$)rb8%HuU\b=hkERJj>Y0*
!q(^ih'I=a@((_d2-/8D+l%pZHgZ\g%m=R(/)s)37aO\8dSM77LS@(E_MnOr\fWCk2$5.0AW
<JD@Sdf^G()/)`-Tq9IHl,:5RJ3D[<8K:.q4c&M@k)k-o]A<#%YOsHkRtoe;#tA2l*T,=TiSi
%EXC#[[pduRPF,VFlHsIF!_N@Eg0fLc0oEREW)T(:mpW_:97m_[t/\G$@Ntq*iR<qq`m\Vqc
&o3`jNJ'sE_psFVXRW5sVh%-Y'hX7P6&`iTg]AjUeL2a8$J8`G]A8k`"tc%H=AN_!Du]Ak!@_>:
]AC'Xs,ep5Y,-M?t+^SfXbLM#CH;l?B[h)dqNa_Gu;*t:Wl=:[eV[kp6I"b]AAE$ePVJ?30:hD
dF0h;^-^C"cjpJMD$]Ajg/N+\Ki^sfcl-2Q[\M+\*.(/E:n"F-KOgk"<t6Nft%Z,GZKg'rA`g
C/uq.f)f:SiRpeC[Og^+aQ*\k6UFS@"`L[q?NA_1$RIa)DUck8i'rsG7Maee_fQQ2qd:SCF$
iOShShWm[EY*<%]A9=g1p5XL#++4AIkJ?EM\i09B)JkfA8r,D7-t\qf]Am>Sk:4p^+42saLb,Q
=($;Hc1dk9/[@u]A]A<#blmACaeL#;\4VDY/bk<ET0:0`b@Dmapl0cXi+^35JT^F4qIkTKY+@C
,5B\U\ZI>]Alt.8gm;U_f]A=E8;QOV\;YX$;eqLts,?#o4r2!ao"W(9P/uTc\#PV3KQ=Os>5*h
_,!-si>6@JhCMDlQG.>:DET+/j6@;WF8)Qq0JIE@['^+OHRfLJD0S;[Wr8>nD-c\U)r*$;O6
lngYqU813^DP:?qE;uMOqbpVa4HLOQcH**+r%`S-r#<ja='HCIj"9k<)fim2BStl19g7c.5@
uW`>bFj%*IR6k[N,R`<(+,,]A.)k?hE?*7qm@[Hk#]A"OJLH3.?&C>a#`hd7+,tZ?&;_K#Kt!0
:pbP.kM,Jq1OFhVC!#2RRXN_3oaV"R)j79REDA`eBFp(CG;p(m+iM)S\O%BR2QD4!i6f&Y-b
&=sY(:R]AB*o:o:M7!)h/l6QB6%[@<QOZeG!qmP4EJ7-UBrp:q,0US*NCB[O*B/GPNim2D3l4
1PZTJ_naj1hLtL3BE@bQEnt'k9Rih>b1>J0:r++7)m!duBBo!^4Gc9t@l/8t(2^Sl!;2St.;
ldLGER=W_8".V4C.@>YAaiq=Kcs_qT!KKsLbIj&*gJu*rlQ#8<PN^V;1pmn)32oTAq02XmKS
SuKo<dP41)6$/@'O[\YQ9shVn)3nZ`VsUOu?>V-X\1+4o[BB0t!VDZ0()6U,4&\!&:qi<_<2
oQS!h,_t2:%[:2trlDnb.DLK"%cr`d?o:N6f[[Hhne]AC/4Am!JZV"X)B[Rk+2VQ&QP!lqD>+
u1\as.p"fU5Ii)rc.f^Rr$:p`:Fa=ak^$99o&b>pW`&<-QmS/\mVGkm]As\g-m&fFZs$3Bf=<
.QH"DA't#ru%'o"'"pSpT'eFq3*a,M]AP0S4-dAVi,>$\,Xr7dk"lJH0=CN`n1)%5B8@@__DA
,$LLjBPc!o-lK;'o:`+=BO=YZ+=c9:MYn6:MRm@FWo(i@IJDH(/.CE0lXEURl'Y3O6&K<><.
bC:>?#4.BKpYY9&]A4;4\SO>^S=rgW#DDR_`*>3*/,\isnLd>e?_g:/.dJUrhl\*EEOY*^:7W
$_K,U\.VF!7X\DhDmaY,^(TtG35d8_8kN6O@!<6)f"Ns>+/!,j#gr*"UUhG^Pt3mI\a,rK:5
>a20:MZTSS#'2qa!00oUC<]AYndNXg0[3nct=U4;W2+eG:22U=`WrnNS?SoSso.\%:@VfqNTJ
-IDJ)(Zi+qFj<@n":3Z=+bE_W"@[oqJ)1(UV@jg(g<%o4f97e"#Efq`%J`VkHdl0g&Bni#S^
QS:jMNUZTEX`,f9.QRRq@c4YD>q"S@F/oHdd53&o(2K2bZSSeH>64P<UdJGru4(sf5DK:H1+
$C1=KU!n4Ld.+8ZSj6_Pn1`bg?$Oo-l[B0WudCFR\^SA)LO_Z3bHj6Io315[S[:DdS[T"b(M
WO4`lBBu9dojt5VHD30V[rluqKuW;R43L`3j[Em@1=PLtccc6`5dTV+]A?A)+2J.]AHS@(/hd-
f4J>^jJBOdHK*XZ'N%Z(\e'4@*V,14"G?J(eaQBJ:Cj./O$'X'j;=ga=pGT4$ckkC^-SgI&W
jG1FaXmD=hM_?Ai\'kuJMkK5?n2kRjQ"KuNY+<,!n2/lK8*,F$F^sg_Kb@l4rKr.:KhkX,D9
l%AadY.XoBIib>'93c7`]ARf-@KjQMoN)8>M0T$joKu)lCNq'7nsZ"G9.#.drJ?P_-\;d)r4p
Y#SBS!We-@lKR4t2"L'FT5UsUD2+HBSer27>Op5A2Vei0gEEiH'V<T$#u]A2U:rpnIb<q_$4V
0jXMkl%-Z-1d?4#,,7%-0.`g5OEUl3n3fUY_=$>oO>MT7`K]Asu%4NI(Qc`K,79o]Ar_md%Ho;
2*Zo*"O]AfN5WKoKEG3h)]AaG<_?m[Ifk4&jO?7<heis1(T^R0\XDIeTF$$uMp40CJU"ASC'69
?naKW05Yarq[Ht>rf;#\%$,Y_:'O>fIc`+'A&Ul5BTi9*qmop,Q3D\Y+fUL%[mO,BUDm+<j#
_pNdIDrSRJO=#pNPV-6#-\PBYL8loKHP9D4?%s#>n%ijYt%k9!g=5UY*_=f),1t^,SQ'I3r,
91*OPkS.R1:>?13"bR(JdW(n\o]AiY*O<*o$7.dIT:pqF=11RmYT-^^'`8&Qs?'AK&-6+B.E-
0@IB%J7>\-/%"jfOgL]A&P+/G3.ODDp/XU-6Wa$h;IURZ_=Bd'-;'+S-#V8!AlSi_k%!R8Wn$
+Q/ZGbRp`:'+77[VRX5tk60f+Z\>!t-[WMkgZlp.@5>r\s@l#EX.kH<k%8LfI0mkRSN+Y1B\
=S=T?bcgPhiKV!GBjVcVH"RP.H7Ftc"E[5hhTuG=#e1F:4g#nBs1]AZ_aRZL7XfZ/im#Y6Q<X
EcN,T$ud%O-n[hcl7\4*<?[io7E>\h-!m.?urL>4e!!rOoMB7BL>W)cl1&:GYE;:S"eJ(d5:
Hm6/J7)@54FsQB8rqHR<g,CcboDfJAslDc\KAeoV/8.0Ek?=W@DF`G3bP25O-G!gYKJ$Ms"Y
=l2ku6",@NnB[o<W;sh.?EFO@oc"(LohbA'9:;?:h@aC,f8\e)8nf/MR^m7>qm*kbSla@HZp
)hlIjj_M[_oh>leXm-p%`dW83n$i<nBklq$qPtT41OlT:&;l0;l>KQUZSf!i?1H:,$Z5ZnJs
2rF3UCT9"2He\PiqJn^_fD">Eub?3#o:"BdqfF7hDa\_VCr)pUT1*.iJVW<GsL,[u##4eQ0&
u7Y;n&"-NU/6pnMP^G8crAU`aq[l)luD^n,g_+7?la*@jT:_/qlZUr=CJG>X=6(n9F?t(gP\
:RGTC2E:#[mg`Lfl%DYJR2%apP<:Wp`]ABW@</$d.Amk`rtb+=>GeTlEnjO]A.9q^086`YZ%_;
%BZMgr:IkV&9\9a?XLQk"csdXR<H^^:hM>pY$>u<:-t^#H-JTPk$!">Z@!V32'N9`rtBUh6B
u-_eRkoQcnVb4;9'J1JTbddT\XWMcru\Jb@p_YTMDVqAgKt=VT?*H;U]AFc@u6Sa!c7*pa*(X
0C_a[EXbM(B7&qa;e$Wp"^G]A`:UD/HOJD=b=RP/DEPd]A3<"s/-LHL\<cn05BYisX?,8=Fe4*
.[Q_oda:6%NctFh4>M2ht!En+Wd2uScn%8=$]Am0KC%C\J)o6TJVs43Ug0G>Y$jYK+Ej6^&lS
fX"@soBo;+2f*Cu3QL^)B(HHZ:TM*fa.1TKW(=$9W"?mqZ5#)#0`.<IfjGopr+X96';nB.*m
]AP8`$PYh7]Ahhc]A-e^Ycsr[Q/41?B8s!%InWl3>:A5[L'JP,EEa#/dg\_,0:+_-iQc\PB(4:B
@HX,7L"`j^C'=:6k*1XsK5dVs3]A$$rk5N+7H-2\H,0/?W:hF!l+;P^C=Kb/@+b:I=#.QAe&P
\TpGLP,rS]A?SA%G9nNJ"LV$<qjF2dgA7qQ0HNu/(;bF4`\P,CZm"DfWA`nOVWkae%,;BP(;E
qTtZ?kkKJbZhfM.3db)ai#_r*\csL`Sr0":I$X!>QA`(fCF.kLbI)HniR37Bg!BLJlao6obj
\5#O5\$o$n[XQr#h/%5W^;));1<T'ctXbY&3r$ri\iOo/`"PrE,f7p%QqX'6PB8N[XbYo\]A_
JMP%59b*$Z2blW0AK[rPW,Ch[MaZ<N]AL8\+7EM&<bQS]ALVIg^q&rK_A>RF2<ZL'&:(1=^EPp
R\FPsV_Ka,j\<U-3b`$6k`6frl@;P(9jh9%RdM_IjF&AhXZZSg9"VJX+=sq^!@GIu?F8`nb`
G10a_i"7VIG!Hs;)%tV!$V_>er!8P7ZTLt?2?WZi71VatR)&eD8]A;S?!Xm$H-BH*GcWeAC-$
3LXm00jPi,/Hquph,^sm+up98r3PH)55@\9SRCq,RG:9,t=QDa40dB;S&Y=[(EG<!LdH:"oe
P55^1To-9g3fG82qGeE1Qh??Jf3!34Gp;]Aa3h'08TOX_/ST&\lfXN`n-AFbE%ZQB5MhXQ&-;
^H,IhT5!jka!NHbP1P1"*V"H=_,LE&7+]AE/:3Mfc)<B@&3=O4;CCUc89\d7o1q_3EQ5db`Ri
L6l4XUkn<HOruB$47@j&:2VfMQl!jF<Te0aU%VB*ZPIFTD4l^5,)LcIDmo>olKAI=L/%DqFt
LrB?ENZM^&\-R0u;rm$_uMOOQ->d/'>poKO>_fc<IPRbu'SfQ#(e2PrI\+4Zcp-`QcA9Vmbq
cVTgFQ!E:HZqrg*m`25Y_j([IOnJ#nN@A;_]A9mYBdN2pU<Esbb=fIA)CcAGCqkkqo*<l_>;9
tl",skNM#0/t",`%f:B=Y'W>R<N!PRi'6Ee*CG]A5c68ka+Ac=PurJAIDLKCEKe8+iQ0UU\$S
5t+7eL#KP(m>"(HhRSV<ESkSsP6#4,bN<@$$T(F%b#Q)q4RK<iM@.gR)lij6_B<K#iYnY36b
ngO>Htf78PIB+]A[KlCel1!nk4[ha&MuX885iCL1g!GELd'.hI"-=oF,#*-I!Yn9ASSdXS+lZ
!MNe\i30l@\3=G61;2#<L2tW>I+DZ+/5;YWf$B@pD<'o2;$q4%"]A;:_O"p&d:5$qk!dXcSIR
!;D7is\h]A4R\!T^o+uc+-=W%l0YdASA;RTGK`MgL_rBrmntihn[X1)`.Ki78mia8D)nDIPlm
FM/$oY.:9ZlF_GK88,D-8?TW)bf>Ho52#P[T2AUjI3*mjUcV*u)QmL5&3Le6rlj6c(9DkO)P
<HK.7c,MV\4?'-MK=ZU=]A/$N9E9m]A3`n?FL3;XX_2#L,,'etNTNG<V^5.WkRLQ'dl2AE@^.E
`:J<K-ac>%HEGV,F`ld-)T^A[S6u4[&p&Z+%Wp(YSFG@p.YE%b0euK6mER-VS/K5XaI-5bS*
+X>*JY@ra>i^$/K]AGu5R4(t03:U<[#@lQ.8P#(0OZY5M^h5r16'#5Q^dq)Ioc_6?B_#uhgdQ
67617aQsu^o)OH']A?W++A\+e@46`:JnG+iQR"J+WPeuR3AmBf0%V&L]AEp.:"&$J5bXO,-&s)
VfZfoRO&qN`/F)E3;+9Z"<[pnNtT4<LJQ,mB#,*>BsFLk@1!0HVT7?P_:k)YIO.2nfDShu=(
GmXi01<po;XX=/pKI!F&*I]AM%0<[)!VKM`]A8#Md<97_gfPX&CW[Q`-5p<55iZrR'Xm35)0_Y
+uV9Zf8FcuXl04@$k0pL3p$@prOpJ!*=K]A\BO@J^7@q(d%qk,br41X9=\=M39QW#>;:EF<Hk
D`0ruV#514$(jCf!S72:4[f9L=?fuj=SA#B7%(q=>')AM[[fr^*H[.N<8uI8T&u_4ik<'83X
m6-/iUZEt5kY5H*LHu&6'.4-:4YhJWEqr"#'6p.^lKP`<jgiS!f[H#LgS<A5[5Ur0.IBn6k8
3U^5<)K@<V/P?m&6U1"lA@I]AWgTqYQXU@f(Be.,X+I?WYYCH]A6Z-jo6K,D(P`f)U3ZUM#Bnc
pLIT(#:UY7<l,LmAYZ5Z7X%4%UHhU7/@k`)hu0Ku%)$MD#=,<a_XFk<6);n-8$d]AIhZ_]AW@+
>Sso!i29@i,ENp<0.r>m,Qsi;su@:BhQYWqP*o'%ir6$"&<m2g-'0X*'L97El-A"dI.OQ<YG
(jgeTG"2IIPIGuppcBs_Y\%)?uBl#1K[K.,Q-dOd!L+>C'bG4D('?n2707q28"XqZL2%m'=N
+sJT,q$%*<1"$pD(rd#j:@[#,m*.$0WDkGoQDu2<.T.T[oo&:JlWp#B'^?(4Z9L&,;JP_jP6
DU9X/,W+#p#INt]AQcoS096i5&[U(tL+!a^F^<*W^ZOTtPP5`j;:W#_9k.0b1_^lYE<8*?^.?
^+ql;bZIZ4:lF[?]Ao@(snDHpb[dpXl8U!Ebe9PT4Yq@h7G2r/q28':$IQ<qAAC"cd[sA7oEc
oP2gL]Aju:m&\3QcVGP!Cm/n`&qEr`,S")N5PekId9Njc2tg)(`_V.?#ldn%X+i2LTH$bH9eL
3SFM/u/GSB20T-7F!?n)Z*hEaeng+5?%3KTFIXiWAQ&JD3\PJ>QkKEpS#3c(NcoLl2jWI9(@
2"L18VtAtBD)GlSb3\rd[;`mas'BVGJSfrrp[IX8h\GX.Z&;E!lY@N-"'O<16`nRj9RXWEoU
=LChYDGre:d,q^#jgkX=@)VN`)%i[e$"dXq.=#-U[L;SMYeH[t_uR@2LfpX33lJG8%G;A3FS
Att)gh2D7^XAR)c,+lUNi7=DX%$aC:S=@2%5WE%LY7uR^H9FRIKk]A'g$eY-,1QIlMcI8pBm%
0T(C:,ahNt@erme?Wc8_hn.oK0n3`g#4Ea?Ql2Gl?`60C]AGL$N~
]]></IM>
<ReportFitAttr fitStateInPC="2" fitFont="false"/>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="33"/>
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
<BoundsAttr x="0" y="0" width="960" height="33"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report2_c"/>
<Widget widgetName="absolute0"/>
<Widget widgetName="report1_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="1"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="538"/>
<ResolutionScalingAttr percent="1.2"/>
<BodyLayoutType type="0"/>
</Center>
</Layout>
<DesignerVersion DesignerVersion="KAA"/>
<PreviewType PreviewType="5"/>
<MobileOnlyTemplateAttrMark class="com.fr.base.iofile.attr.MobileOnlyTemplateAttrMark"/>
<StrategyConfigsAttr class="com.fr.esd.core.strategy.persistence.StrategyConfigsAttr" pluginID="com.fr.plugin.esd" plugin-version="1.5.4">
<StrategyConfigs/>
</StrategyConfigsAttr>
<TemplateCloudInfoAttrMark class="com.fr.plugin.cloud.analytics.attr.TemplateInfoAttrMark" pluginID="com.fr.plugin.cloud.analytics.v10" plugin-version="2.2.0.20210728">
<TemplateCloudInfoAttrMark createTime="1627890189607"/>
</TemplateCloudInfoAttrMark>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="d78847b6-d996-488f-aa7a-6f61dd2ea0d8"/>
</TemplateIdAttMark>
</Form>
