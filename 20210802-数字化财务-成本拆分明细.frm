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
      sum(case class_one_dim_name when '人工' then ads_value else 0 end) 人工成本,
      sum(case class_one_dim_name when '燃油' then ads_value else 0 end) 燃油成本,
      sum(case class_one_dim_name when '其他' then ads_value else 0 end) 其他成本,
      sum(case class_one_dim_name when '维修' then ads_value else 0 end) 维修成本,
      sum(case class_one_dim_name when '航空性' then ads_value else 0 end) 折旧性成本,
      sum(case class_one_dim_name when '折旧摊销' then ads_value else 0 end) 折旧摊销成本
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
      sum(case class_two_dim_name when '人工' then ads_value else 0 end) 人工成本,
      sum(case class_two_dim_name when '燃油' then ads_value else 0 end) 燃油成本,
      sum(case class_two_dim_name when '其他' then ads_value else 0 end) 其他成本,
      sum(case class_two_dim_name when '维修' then ads_value else 0 end) 维修成本,
      sum(case class_two_dim_name when '航空性' then ads_value else 0 end) 折旧性成本,
      sum(case class_two_dim_name when '折旧摊销' then ads_value else 0 end) 折旧摊销成本
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
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[720000,720000,720000,720000,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2160000,2160000,3600000,3600000,3600000,3600000,3600000,3600000,3600000,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" rs="2" s="0">
<O>
<![CDATA[机型]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" rs="2" s="0">
<O>
<![CDATA[月份]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" cs="7" s="0">
<O>
<![CDATA[成本金额（万元）]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" s="1">
<O>
<![CDATA[人工]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="1">
<O>
<![CDATA[燃油]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" s="1">
<O>
<![CDATA[维修]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="1" s="1">
<O>
<![CDATA[折旧性]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="1" s="1">
<O>
<![CDATA[折旧摊销]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="1" s="1">
<O>
<![CDATA[其他]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="1" s="1">
<O>
<![CDATA[合计]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" rs="2" s="2">
<O t="DSColumn">
<Attributes dsName="成本拆分" columnName="机型"/>
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
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="1" r="2" rs="2" s="2">
<O t="DSColumn">
<Attributes dsName="成本拆分" columnName="月份"/>
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
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="2" r="2" s="3">
<O t="DSColumn">
<Attributes dsName="成本拆分" columnName="人工成本"/>
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
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="3" r="2" s="3">
<O t="DSColumn">
<Attributes dsName="成本拆分" columnName="燃油成本"/>
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
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="4" r="2" s="3">
<O t="DSColumn">
<Attributes dsName="成本拆分" columnName="维修成本"/>
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
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="5" r="2" s="3">
<O t="DSColumn">
<Attributes dsName="成本拆分" columnName="折旧性成本"/>
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
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="6" r="2" s="3">
<O t="DSColumn">
<Attributes dsName="成本拆分" columnName="折旧摊销成本"/>
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
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="7" r="2" s="3">
<O t="DSColumn">
<Attributes dsName="成本拆分" columnName="其他成本"/>
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
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="8" r="2" s="3">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=C3 + D3 + E3 + F3 + G3 + H3]]></Attributes>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="2" r="3" s="4">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=C3 / I3]]></Attributes>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="3" r="3" s="4">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=D3 / I3]]></Attributes>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="4" r="3" s="4">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=E3 / I3]]></Attributes>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="5" r="3" s="4">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=F3 / I3]]></Attributes>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="6" r="3" s="4">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=G3 / I3]]></Attributes>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="7" r="3" s="4">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=H3 / I3]]></Attributes>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="8" r="3" s="5">
<O t="I">
<![CDATA[1]]></O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[row() % 2 = 0]]></Formula>
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
<FRFont name="微软雅黑" style="1" size="80" foreground="-15386770"/>
<Background name="ColorBackground" color="-2167817"/>
<Border>
<Top style="2" color="-1"/>
<Bottom style="2" color="-1"/>
<Left style="2" color="-1"/>
<Right style="2" color="-1"/>
</Border>
</Style>
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
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border>
<Bottom style="1" color="-855310"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border>
<Bottom style="1" color="-855310"/>
</Border>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[mCWg/'5.#'hQ9Fb2\idgQGa,@CY*]AGJ^C+m!_HTLfYp0]A>EN]A1;%XCM":;O_'s"9$;Mu9P9B
qdGKW&,WL*Rt+W$(%/!_J%W!^[Md+Laot^PR."V7V4iT>uH9rB<8)Gp[P%c?[`_cKBT#3U^M
Y-c(A?s7F='SpTn9fcR>"rn2A=fjUJ!DUoa[^&WYWI-tj\kFO2Km\AkcI%F4q+h_$mTdR7dR
-=<&kL=RPGOdo"bka<Z&"T!Q?>oaOfitcns7tcFkE_[CMeesXr5YENhY4nP9o_E/$eGU_pt`
g%8(bNMrAgd*g7a7nIq*Yp@]A<gGT8R'^^S^9Jkah,uqIS/"j6NrNF&j)[7WNmT\7e0Q<'"=2
A&K[K'BIn:ckO;g:s>5!%fDOL*0;C"7T.pn>2:%]A\6.e7:1.9\BnbqOi2s'ca)%40#/MjAN5
G-3A[pLR"?&k/Z!]A7HAYcM_Yh)mVaJbu(@R_da/[>9K5!U^RKRIfuA@C0^7#>f;;3J'>[($i
)'M>Am(baW]AIfG%b?)!11#=kTQ,uRY>3b-<?r]APOsg"KYk#j@4_4\C(b5cmF14YZ>4EW-]Aq%
dYqdOGNAG>MbqE_(1!2_![0h`s5+Dr?s3qbV67Kp+a\h23kcI@s%#Y*$1Iq=Jg-WFd((29)e
E]Ad$pNp&!!"(9Eq;*0F2-'\iWO&j7,%$RDW509)UV#j`f:?(<bUZh&cP-U\IIVgNcB-/tKVh
Jm8]A@]A;Ca"MXfe[AU&pc!gY^1"XkQg'k^iD%#Fpo)*@7DE,2H$f5'alp)'Ldqegf3U*#GOHl
A.A_/.g@1K:dj-(5e3)(a28?':MurjkHF^G.FL7o?70kJB1;-gQ36nMUh+<JgJl=@J@#<i;+
oW6,M,\CPh#e<V\Ya0:VI[YjI&oi?L+]AJ>D2ggr@`h4<GPQ3Tm*Ft_u]AYNlY.gN!4LY[SPdV
;s+9X5sUkbE]Ao='m>tV(#A?uF#kUR@Z4+gW1n?oH*eOs2_i_'(S<8e8_>d*A89E1SIE8_'CT
+&?)&JgCJVl.C*dkke@ImTKO!J32HR`S.[#J&GrKA/aYU[%%q0U!hkHYWTDr.<_.\tg<B%d`
&_hsu/WKe3UG;,a+EjC+ZJEPpSNlJ[HXPc#Y(>uI+_-!J9%57DS<9VeZbMfqmbNCUF%+j.^h
m$H'"61[De>uYk!J#8Ch&*O,7OeOh%Si</34W"e$W0_F.(mMb5%tE]AfBu8#N7q?WUn>?I"rp
@j0C83CMLSH9&OD7?9BTA28?glpb<LA/PYt8VS<!RI702rZ'N"dX".^6&U)9?gYND;9CYMKP
oh9E[o?(oV>,Mrfj1monMI(+jX<`3M=bmq]A-d9h-8fMFS(sn8k`kKFk_RJSUNplYU3/&(Wo[
V+iEo&aE=[4_Dr0=5dCEh)%@E`,]A'IcdcQ6`8$8AO@L#Gl.gT\&USK#kF[0*;L)nf1t1#pd.
ZCssLiK*-/`:ppHpFS.S=FT$`i$kn3=u`:u0ZDOBhL!R&!O`O/$F3*M]A=V22DXh;A*H.aiC=
a/JYunU-M[4K2Bk=fRfg;:DA^&>l/p1>[]Al4@Xh?)GKGlM,gns;"8>fKgJ75Nbhh4moKhnpr
WV6h",hrC<;Gku7Un(>1[`n.-DCf>qGcksYJ#I+07I&YYPZ$s,?*N]AE@+SkD@Ng1&rh0HOO/
$>$T[JmFpi[fiaio2I]A,7EN;T]A]A+kH$G>,#qg2;#YbcTpeTp%J3P$YF*i:4-NTjBQ;W=&1*^
;ff*.t=N->;S3I,4\$2,?e1':uO_\F>1)4'Mh6d-FM#/h!:KaU3Q@=8%>:lU2eLFu4LY(QSa
q_lX:LTEA;7(S$Nq*s2.RaN7u5A]AUp7Ah/fjK"We1'YPhi7J`U<b"hU=2hbG*A!'fQmenEc.
in%#ZTi_:WluoRb<X'pGi)S'N9b!gg4P\Q%-9@pUmh>Z3\G$!4//pAr;td)^E5D!QMS70&-N
0p37f90E?g]AWt%3Ige%eEV^@&US00aL(GR4Kc=:?3__S5k/bd:=Cto/bDXEch-X8DeK!Yn4<
C[.OlABq^,cF>1:N6?gJu7ZZ9c[6t2NSO(!2q.Aj</(l9/F[]Aoe.fRdECG?^uV9:5?R-+4*E
>e*k#0me9\Nd;HUV(m_[cS#G5[*'sD#W8g/2Hb+T-FBK5Gjlnh7CKf"^KUO#tC;:gHfd7UW<
a!@YW4uC<q@khYoU+j#Z8:>\rNqNX]Ah-8UrO$!]AOWV.]AV-BJ=7NMW>F^sr(HIZ@Xg'&5ROWl
k=>G(*WUPi]A>BX=%S8RKT(GWUB.8'#s*Y!?2c/:nf\>")W1WcN*^(1X<<S]ACda,\^'AJ!ZEs
S7\o3o379HBa[NjLnh*Nk1U[2@jgi7m'_@2q\o6k,>(LT<a]AZD]A-Tak(8Mb!o%"%%[o:,T_Y
L;M,k'8B&>DtVqd,tM!LJn0!oQ[S]Aoa/o7G%.ar\(mH*_1ibb-B0tXNg=$$i_91fIDtiYOnF
?]AVH>`Hi(#TKN"`TaY);;TZ+bs9VJ)f-:raDCS_6I]A4SH:*C2JUXrl;73Geu-10BMIpSGB3[
ep]A0F-0;X4Pc$"2qn(=dJbKd4m"+b0kK7`>=K9EqViL&oq@Cnj+8>[0!aM\F%KKg02Y[WFp\
gRc8-^n->p7SkR952DfgW8Ab>jXXD,l_K&C$h`)%Ht,VEm\d8X$(^-!1je6lH&4AsP2scq^!
#,VQWeA2CN2(o"u!/@1Apj>)hV\-B.b8EPZ1(.rGh<$`EMh^4T=oaCm<j&64bZ5WTuIB'J0T
oO&63p<IO9bEQbUPfZ*6RXB:l-ejFh!U&U/oN^(rJ4<h3$jF;k@O#uD$F(Bp_=LV@Y/feU(4
<QA_6bU)f$q/HuUV]Al92&:E)28UqG8>F*@;$9e.WPLluMF=$oa5Q0d@9Ndd%@uhU_?U/>:j^
ZM+N1`R)!O*5o$C\gYt7QjFMmd_@ldX\p_;@b#5nC&7f[5u#i(m0+OJ1%@T!2F\k&1=H\Yjp
5=1(2u>5dtlV8X>k'EZ_0=\-9!Y.F@a4@iqHC"Z@GIo7X1a:2P&<XRnh/'h3u37*`7%q+I>`
$I;TN_1F$?b`ig'*k+f;^8C++mCRPHH=(Q1PkNZ._HORl9%ek&KXkA5Rr;b@h86;hqV[S)>o
qT=h]A%Zu?k<C'8^OAfD^.HRG9ri.784CJ3/[5"gG:m=?bcC04N=S;3]A8G\3<VNemf+1dmFM5
n931'/&>(+PQTMo!M3Tq*kDYQ&Km9pY/Lg6)hG]Ae<bPd3l'+N[bkX/dC\Lq`fD!sgOcpWPpe
9BqgMEg(_->dd?fL^$pB7O?Bol2G:ZD$1fRmseRDDAC:H]Am]A@,>K?,]AQCt<EPXr]Ac28QIn`u
$V^i=#q:KW:HJA+LgZrV'bkC<,?AlpciY3+?%$Dr^(uDV9n29B]AI.X=h&)Uo2"3/KA_N."R-
]A4cYTR,i>s20&R4b6s5:a>iO1>p%9$L*&7>%X.B>i`V7FI9bjqb*6EZkhV5blT%p%aY3dZ#m
DNPZC]AN@\8#S5A;X78S7\\2qAR&2W'VkXGnaK#er-"Q2&:t(X<SCj52HGZ*j03R+7nY0*BCt
G*<@iuu(JqB:5E4&MQDpR*&4desB_p_i`;"N)mRAR9mdTUf;=1%tYVohDEQ]AuSFF%rBc,o9#
-=AZ=@N-^/WN+JT'?,#7%fpHR&=f*&s28'j*e23r[/S<CC;@$9<1*)%*dbWW%T"q.mjG.L[Z
^;=OUaR#$l++R`aQeF<j;l6)S$nZIBNGka]A\>k%QQT3(AB=ll5]AXdNS[OhD1XJDCTU0,#@c!
oRn"Fdk#KKrr[u6#qK^P7$)&MbC-&gSSN&0'F(PRJ4V84]Afi]Ad2`TC/6q<M_D:*lQO;E$/b#
aH<ic+s)"$n>rR:%_\2lF,1+EFHg4b:7]A//,Ftnj&jB!#H90Yj[,eD?ZJJqR\7S7pM4Ji$*c
G=+2fc(cXOd8I"m//-#Sr_l"9bS9iB7gWkerh^]Ak9..BdqH<a)J$POaH*acATd.]AX&4#Rc>2
1Y23)K>'\ChN<iXC!]AB3]A8`JEs'*U$.T'ji&G.9*EjI*XB2)r/osEYpcB#$:!@>nB30a&4NF
`VLLQOV\+.)<Y7M2_oitKeG>t)X\/iC`QlKZe+`X(SSOlj<[\<WijMh]A3raRU0ZjWDBgV8@K
h\TG5JM6cP/j:s[p(ii,r-T'^l<M3-6?p`L)gLI,16p;VEnV9`*Ub"Nqf\/?NrlHolPIP\gf
u;?oS)#`iaZ_hQa=u4SEQ#4T:Cen^NoXG-Y5_T5q5%p$Z]A[8:clnF.G:sko_d]A(feAJ.REr2
r/nrdRC2n^dDrVgVfT*_e,j;+"=;6MR%BbBF,b1%\$i`Y$EeZT)CPIHde.$6LMbQ:6l@oCMq
q-VK,8GriD;!q"%kU=><ID^)7<Y2L8%tEBep-jq3_GfLD2;@H!<^h=f"'XIKm=n7e$A<k4fA
-_'QG7pkP4Suu]A=?`Zhf'?RIS'[_\M83HLq@c*T]A#GRE92\@'4]Aa0RA).Q`BD)#J^::W]AEJ`
WrWkT!9]A:Km/Ceg25fr$%+t:sqW?FD,ZiR`=C)g3te.O`C4PP+9IXu-'nA(+r4[ru_WDo<uM
q7&(]A$Vm9odM]A)`,Enq\SXWhHJH[iBMAVpX>DE(NE_YB]A'2f#\6'ao>JH!og,=Qf(iJ3u4_E
o=&&6lT8QRqAk+bM`l+Zc6VI?PTA,gX4XbZ0j_c=4H,+YF39)@4T!'#ce#,!cX4%+DXA>.d?
bPL2[nWn_]A-q%7jam\B+H+"JFW7j)^D/uet.YI?.YX^r9f881#H>$`KBHI1lM=nRTR1p#F'M
$^(O<VH3!LiA[d3nkW\@5F7'O-sV&+?Gmd4t7L9N(M$fCtcCQ,D9dM[P^pA1cpk?.c2n\8mp
+k]A<4.Mk3/9YZt#>@PC4!-!:Qg^j(W'"a/@k8:fJK^Ki5sgO@Tl__@OiNmtQ.aWYfa/Xn=Hd
LpK.0H6nKCJ&;t>j2NST]A9P(?Z&^Je-U#^fQmhI)cmklAn5$'oo!\eL;NS+Al@WJ40Do#C'S
SI&nnc<4\jjM3^^R`^,ji`P7t^WCV6OC:_.oBHcIljB%m%"b<XGO/6_tS,Q5Jh"$7<?%5L*F
J3mWSW*&T>HGeW73V)!jPT5PW>W!90DIrSRpL%O/H9VfS`$X1?h<E><ocs(_4YWBPM2^L0HU
'Ua-r"Yl_K<jO-GbTM23+BrI11spT#HV532NsG?PECT<k3=nKpd/6'_!#!D\jg(GAT`4g1WK
4XWX$sh4^V3KY?l,pZSJ]AQ(:B#.keqW!\g-n4mOAs<^]A*TX]AX!0LM=nuE+,Uo.fD'>F)jR[*
O&$PLf4pE%4X.e\3I:Q'i)sc%s4&6bkdYU*!Ya!B.e(m@oOV4<**^KOAa^N>d$+X%#X[Fdbp
e27i3Y2ngsJ:Z<K.%NuV<O_&;?e@&RVVKd4/7eG8DP?M23pX8E+4.@.@O?K>0MUK^fpRBl[X
FRE7ZhHa,%CK(IQq6Ls.YmXNkftFcr6DS7:j.j-g3n8Fe/Y(,P8q);II,po(poc6.qXZ"r5G
O_%AD*LJY'%&F.h6H(0hj@.B,09glg"H^XMZrS;%Xu9=[r'H@SDoo0UF6.U(30R4`6Z?`KU,
a+&J[R6(!f9Gn\c`[p>B=!H2Q^\95D43rRWo+D(VKHRg745>^fYZ@'SS4/.VO@@HhpWAV?/4
X=7?qd*^uND29;(%N^7$HVd$9U&'eS"Zf8.`<``CdZQ@DtI!rdIOC&=7<#5]A!g"M]ANYiAY@,
72<T^,*j]AQMHki0&_kj52>mg;<`^C/4?mr&1FaJ9XVrPTFb=pugh(6l"R6CS/%e#!jCAR**t
DMq\C]A*6B#qB?NgqU$</r2Aoc>X<^Qkp::5mZ>Yp,?F:Y(F:O2*mQ;7?k'^"dZ7WdHJ%l[OE
Nd:q)3@/s6U`B_DU@sXXS6i[JQJb,&uH&aTg=$@Zi48*&cM<dT@7KP[`(6hdW1?]ARa9*^R7>
/1CQZ'Dj&XX__%YF$3SC7JlQ3(?M)6`+1(\hZFS^[,Z*&5TKujJOT'\="C;uao!Z=>,^-4=T
tX=2KF)-Q)M,:n>bN>NE1>#t-#&DF3up?s-89+F97\[6KtHpP"l'JJAboZ'6M,10PRCEYkHC
l[#F.naJ$08Eq6t'\bV3H!NAQ'$Im9QPJIeCNgJlj,.K(bm^SI<f:6%o$:EE/%\+3*.R]A3I%
a%l>T>;p@WS/So`h^H>:)TC[o0<a*T$^4([<$@X\[5a6uZ)&R$(7I4K@fP"@kh&)@K>C"jBC
]A*F$*@+6>iMZaX0=(h\BCcJ9;mH-/O%_pPC,kKDFP*:$sE+mnEU`9!e\k"c=5.s]AeCO4s"cB
VS5mgnK$t6J)3f)?VHnR(dVZpZ3?BAja0;8;CE]A.n+\UtGRUW5oqBbV;q/K^k1Ve;0fTOcNH
bYD6`,Dea#CGoKg@Nm"=d$0ZK5$&?h9GB9j"5&j5hM+1]AQa(0/DeMEd5!=d9F^^VP+f7N>V,
gDA%aKo/XREr-YFtDMAK2/Y:5;be(0plU,tb?>;%_J/OO",3BZblNn\2,$4!AYc0W<]AIdYY)
1u<$RI(0L-4I@5PR6t)K5o]AaOUBM0'c4[3N2cDsBF=4\\_r.#eVn=dM"D4OR&$rV_[WR1nlu
=j#3[X=Y*aLh++YN>S*K-]AU(fJO,To"N?Sd`e%#JJG1`!dHndr8UKf(,s*CHK=5aVtss1^A`
AECJ/!:>RLGKk-+gGkB#IgU5aGL3:EO7;nS0IlE.ROO9W<_!e5ZX@HPo06+D2c%WZu?m=D@H
YoSA-s1J(OUD9h%P#]AFWK=?1=RYP:o$fO2N:VAS=?Jm8X&735?ic[a5<lf$lVmnP\J8:Lk3T
h3rR9"!</tc-RJ;W%pY9"Fb/2;)__''^2#V4gq:S1Q2dFHgR$B8SfL\\&KUA]AZbu&u!K$@bC
YMjbH,;HK_Mfb-E]AoMIebOHQn.T\6AH\Fa!Xthr%#bu+F'T0>AEY+2D)1B!uB>4b^".(.fT[
+5i)TT,@,ip@_[3$/6@0Q%6>;=i@pS5[:>KP-:O%Ac,kcK:3g#Z`1TT20&HFeAgZaq;L7J,*
o$AE9g1Vh2<EQVWDO(Y_,VA5d;M/a!@\s#33Dl1qm#\1qVTCF9UX,f$[lh6K7KKo70SZuT"[
^h!</8A<s/]An%X,=jM".kkfJLipbNUMoafLX@5_%Q&FR0iXa<VZoJ1R`l/]AMIHop\k5[:3er
'%'B'H;PI4ur%a'&6:k^.j)crUYm!!*W.)AX5Y\TDq^;#rbT!M!doG7Lm*CH>%a%GNda]Aup:
AK"GdB(pZY8lY*%gp#K>YYgero'#jThsifE()g&@Cl;a[LbJ0a\+hGh1$am<8Q^'Tq`CO$lj
(Kp;eqR\:V]A;f>B"Vm8]AQ&\Y@&6US&U(6m;\"%%R**'Dr7_dNbk(T?Q<A-CM?ib<8]AP>*=6J
f(Luom[?+d=&@G*9odGqZ\A(V(BW^n!'RTI5A9^p?EF.Kgq[T\DJ%$3Ed6TL`5%WUrh"$[MO
E<DB`j_C8npRcr8/`<\p,/HH$+&gtGbP1[Yo;4"NQ/U/j*UX1?!O)#TdqhDg6p.@m%#>`g&\
4Pfi_'\NiRJOKNu%nN%q7@$sjgch;kOWfLVDM?D!B:-Cs7jKk=rA/]AS_qbcq+TS_hd"Pn.2h
Ym.\bcr"73I7THTkWrNa2t_^:g)KA*T#E`PO?_"1&j.jN6pMD:P:hE/P1kL^40'9n"G\:OkI
2rlDhV]Af/jG:mn@nnN#&rV6YZAbtke;\.82X*:W)/<(,U@7j63`W/!^VG[\6Sl&N`E^UiZIE
OB]AAh'r6*S!;c1NuGX51jd;Y1,`&@cT:Mh9&7#CPX*I8S&H)'ucHQkWC"(?L^QX3c/p=4@+q
q)Z/QQf($(eo:bguLEV.@!>(*rfn>=>f"$,;XI86A`[2^,YK0m_[J[\!KHtdij"I,OTeG:%f
p4kS5-rZs!Cm7J5muVCsioA[C,lgbe\bc;RU*G>=qm([\F3"FII;ki$(2N%7STFdC%M/<J0&
J_f$]AR=<akdM48p(*QStl4(3^Y4A7V_CBWs@D@j@k4=A!UVGoE>ltH@,JGl&<"jcBJ^upeS1
"_F]AJ#Kdj*+t7TA@`rrA'gJL8((!1d44AMXY^1(VC->/ee"4bg*SQfokB=J1b212ddK/g5W%
5_fe:29&20:k2pSG:B+dWbL>$sSQC,nWh$RtT[#&I$lO2i4@<OnegJ6UR\<fIP(?]AXggmS+-
2sMtV23rF)tnK6k"t$XP'q!t(X.I^>BRLA[\=5qEppNVG<N'/8WFr\X$g6b`CS$bVom.K]A(I
,35kIfuik.^:`u"'^?.uaQY#H,!)U_P9Bsb=+e2Wk)@p9%Jk7nfq!j9*;9K@IVZKM1Kk]Amqd
JK6F>N(MM$"8skj$5GTR[c9]A_LELfqZoV9<h&4gXb%Mr=^]AoPR8Kl++[HXOK8I(AJ+/.dBig
o%c>BW76EJo=\J2gZSOBm$<B$#8c0TW[U<u.^OC<\7VNbccp4rtP2c,925Ms^4gc6YiMP=!!
BP?Wui:JOUn;T1V*OVK,!O_\:XDCPQ'FJe-@#OML;S!%)b_lkf;2@ii=qt5/RDe_US$<(plB
3+YHgPJGrk=0!p\FCW4l+Lh%7[&@Pe3j@JNq$?F"`]Aho*[[^I-*fh*bqAE/\5hCi1Km$uc*U
br25E>2W[9q\qg+27;c0MX$Vn=%=%%sC+q5*fO?,>:I2B!hgHi<gKQ"&tiI%>\(rqj$8TUtd
%;DNFbq;\=-,GPth_D2dB2V^Fc&#8fmijFUGOO(Z-ddMj]A8J-ck??UR[',g:^m+KN2/#;d9!
mrIC>!fK(qE>%X7dkGL%4FoE0F3o"8H?9>eD(,9'&qCI-Y8;Xf,1@oXLlV5XF>d69$(#CTDF
5h0K4O6qdf1\grM`N_!Lkq0Bi>%k</@>aIK.1eMjU?]A>U#Ma;8k]A#P?#X)[$Qe6\&HF1Ui$!
_*[>f=7?UBle^Fecs1.hVSu'MQ0^ga`Ri82O_a^?Cn+m$[IMmL(Yg+krWVA(%8aUq)T'6mT/
mt>j@hVq[,3-,geZpp21EpZ=nfMEA5`jf=/#[oJj6?<T54TI=\F<-hu*f_]AA58&SG;&0ak4#
P@_E1e;j1X1*u@e]AC"raPqI<r-*@<^#Y:Z&*.:E[0lcOr(jmqL2t^MLh>g%+[fL)`TUHo`iZ
V88XQVI6^@u9lq573!c=K7l/C]AhUCXa`2U8I4'5=`bt[i1Z"a9r?9k.Mr$ZU-;/l#.WWPmrr
(Q,YmATcL),YUO+.VmD3bSA?k9odurbhe`fck_d:CBfir'I_l]AP2T6W<VA#nh\PQ1erq]Ag$(
hIS8o#q`Zh_5]A'=$e-(\O*T4kY'J(;_7U`-&b(D9sjU,aCg;d?YVG>)HWf%fGe<+LgmHAio)
pM`rTFh&3j4!ro+,SAF3<B[&bOO`cT/@1,Ldm`he3qe%lg%.!<epKJ=<5SJ8#B=LO\sl15C-
7LEiKVRBAe=q\:<T^^*g8[7Y&&RQoAfPXeBP8V,?W"k2Qc;K'K1rTsOpJ9PKf3N*$<VU,qRs
XZGeh]AFiIL#UaSid*[QItB;,ZjQ5C+-LP*As;!m0M5Qc>g]AKqQ(dF:nm*m9>T</oCuBC2,0a
9TpUK3;P'!_2S$r=3ij[$DKUgOF_1X=S\f#c&_@st;J!#<`P]A\X7g]A-Z_Z;07/T94mrpC_Hc
k2jB(E>gVCt6i2^ol:ceCT4L".C7,DDsMRYKURX<<`CFkfYT]A:1"Y,^!]A9N_Br%<^MX%oo6)
^i/[>W$$YX)(ns=hP165uf:;YhUH07!343D]Ah91PV%I<%PEFJ+dL\7-8\WQoI67Xg`JcYSZ:
]A_"H:1RX]AOVU3cdi,R^+AS_j2n_Q>)RoEUPEdB!tD8DMFTf]A)^AFMJZ,_TXO4e-e"(?!Y??q
Y)E2rCf.cV]Ank4rIG7,@\D=cjpa-+WW4S+a]Ah+Zk^<YVsV4m"FtR1[$pQSY90c*_m*fL3.Z=
JJn/IZWTe=?^922Z,F[r,4o.k`9UK>9lZqZCNnEm,onJ=)5fVeFnY:a6QZ,NYN;'(4(R13hf
,F4&eN@DrlU/fTQSj47W:p=-o1A)l,&SerViV;=7Djag]A"g/>KjT!?oPLg\:k]AY8<&+pP.oe
s+VR=fJbokY5(n'>rgW%o^"QA&s[<5@lL:5?/aF)]A`k]AXUfIrbFV-6WIf(9rP;.WH<^.]Asmn
)b5fMb'm(E'BNqSa\\'`W&en1<gk-ioh'B)KCDJ4ithJe1t+1KUUcOa@@/QqZ:\7M$-Cr=ek
LC2Xjq&k,0QZD8Z8.#H(.i=6&J@/5o8D=,`6Js/N9ZJC@aZH3A#^VR%DuD:eg1`2C5n_?2]AA
]AAWhni&3F^,j1T:%?J5bc_D@LPR1ag?>5Y6beOqAM^CsSKEFETZ,3?g+"qNFkkf"hW<.&%DR
<hTLoPt\0S>CTTU[PEhYW1tkY3D["iO,Q2&9aJl1a_J<njB)78Xe#uV'U\#I,4>tO[Gb0cL-
RD;nn.n7hnCVlR9\eH6SN9A_8(\7iZI,Hg_;&:@5?->HQLmU1W4$=2KD=(.RmK>3=rhQZTPk
Z`?&*0X<O->[dHf9N%7%IN3i,IX-N<[[ug.k\%eIVl$0r-YQq0R#e*;Id-MS<%>;u%[_3,NU
]AnfIHij&lT\"Pm3([;5_C1Z/Lu@H3o,c19KQ+9."Y#T9t7ir&SGd;q?Eg.&\4fjG@R0]AmiAf
Br<qR1/AB\8?l:>4"Q%OU>cjArT^Y=@)\6Z-6Ci@\cJK;)Tug:<aNprjh*)($Y&&`VoW\Ps>
pD/IN32RAfB[_iZ3V&:S'a&kj5uEV=+[;BfEtNQA`kAZjJ<'&5J-s".hE\P7INeanBHsQ%@P
aY^"-TM0H=YJLhiR=pgo*VJf@nMRn9UW4G(tQA6^':AM/V7V7'#M?YHM6]AVLWf[i;>UUXi72
A/1Q.37gRnbu$,!Jngo"L6/96E;]AV=^,+UkdhJ#(@b4T,>plL/qQ%M9Dr0*kGb[t$D+]A$C22
o-\`j=>_DCWD(I)L@39((__eB(Z@RY)nN#2H-_,u,;0:0%%Bp/lY>0F<]A4I(Xb+Wc'Aj<8Vd
D5VCuWr.cQZhYt:Vi</8peW%AWA%5t"TompE"m6Ed$HR:.YJ\Sh@q2-FRjb]A-dV_dWQcsA%]A
5DC]AHA3hTgC9@PL8&mB]AYPS^6TBNrZ1+kK[2(u39VI*Z67sl8a#$`_R@fJp(4r=,<IM4L3.n
D6&C9uuW/]A<AeZY!;%ur<+]ADYYEJl9ULj7Q&!4G$*?>&ZWg@Zo>=)C5G?>Hlm^iAdDI2spF.
bi`0r@VT=De5)=+`#G&mk,M4s8chktauhb;>G$rGku"EDAq9lCVG"@%F4JG?d,u4nrS0,:-t
?6SD4c^H?V-->F9h1@2D2`"EaTdX)g@o-U<Ut"86_-BmT&>sWI/CqroC:u^h%@?0r`mk+*r-
Y04`>s*Y;;O@\rae_;UM"45eWX3&."37gg.5U8D3q8TMhacJao@>b/;*\>u%9or77>K2jQpi
\9q-g@)c+3/HSYYE+Nsd&>P.XIkf-TQF426[MMT?7@d<(4(f)`W"#fVVsq_oCU<V#;E`6E>n
YkX]As;!B/[m3_3a[]A7m-;;SV!>3DMOluUfJ449eaNJ.+&?GmAja+K\'rq\uqTWSZo%3@lMri
W)'m'i/2&T"B39!loXh[c,>q3eAmJF@8tPm72ecTl\5cfB^E-;C5a`3(Yh&OGuT2gTHKfB+&
05'>>6$@X1!Fqkj=JS[Q05XI:S1NVf@l39E&jh-mVW-8'AJm(FG3QDSu*qXl3lu?MY:GP0[K
l`f&)UTuZ$0d<-=^nhd&(gQ"W-Q1F1Aa'js;_.IoDDP\R$gq:Bl"<Ch%f5o,U3O90<ff3j]AD
Igm4!<j7]A&un`fFeTDRUWOo)a3_;L#H$=d=>EpmS24q(\q$[gjOX1HaI@A;jE;9(EI>d8$pt
Q/qt!dHQe!(sUOG<jLE\Vaa4aR/ds-O\2Lfq?/l[f8$cs\ORZpe[^[2oV6VpoQ:gj[Ki2QTH
e?iC=5qE"5W&K/;etOWc9Nh>*HoNqL]AL;=GEXb\3fC=cB7[^0dKOm2^>9.'Nc)%\@$0k)ap4
162a=@c`EP`2FgL29ZLVn@D\>QDS72,9rY-*cIfY'.+G\QBlL\GARgJ,[PTpb_F+n8@Uls<d
]AXmBrXff9#j4X_ALB!ecAK!c<"7tH_a&Pk4s'kbY@K+\VE(`[$+n$uMS]AiU9&'X0HP>Zmg4k
Kul=h"0ALg-k68&aHCHjF^gKr`!j]AaeuC2NhB^lcV]A_n]AW82Rr;rQs48\MC?%9"!LhCp4]A9^
4lZ2SB4?"2RMG8sZC.DirmpIEq,e^<l!'->\kXm?<lQaVW/nJh,GrNX$:@bmPb#qW&";rc!F
COY9.[(Xoc7lJMIp;!Kk7$^pK23i*fjEu96dVGR:#(2j%ofttG;UPomfQ2hDM-J[!*t0%anA
`!BmMN?(Ps!K/^Vr+s1nU.fpBOXhiZ%<Fn+Z=k4MTDBPd+@k5Jeoc:j?F1IIVb-^?FMra0h_
a<<u($<E0b4T9LOeHLD4#SOPbV?o*C[h)DtKXtAtrH>qnkWbQg(S$GPQj%;.L/kftL#FUK'5
1&E)ml\6mE8lm"L?9mV7<7XL]AN&e8qdj!'St&#ja&CE3":df#bG`!/EnGhro1qG<mdKt]A$"H
0!lH/1"g[^0a6DSf"S*7\#bu?1%377DS09E:$.6A[6lt@^l!m0(KV,SW0PbKYUo_`kR&eDL4
&g\1j0"m=]A86j=?j8JU8`R`Df'.,RUgBI:92%4r_gI6&9H8).3HIR]Al)mGUagQ<XP@XZK[#Y
'J=i0t"<$6bf1VUZW?L.f,oQhZ%4r3UD:ra.u%eMI%,"H,4.(5_BEKJrY\ki&:`%lb:!cKko
,6K!U7d@Mp*m6\k=+-@Ck0'H9!kI,U<-kP^)$&S5o_'3p?h^2_T"KE7'g[,>1U9O@G#l+#*_
r4m^KE-!s@bkqHLC!Oeeb0j$L]A?ZJ"e2ek.P4R5+s]AEnofc5k(LPt%e`)#:l$9scIQO8qaaO
V>33#Gkf4Sds5D&U\n"K\R+[V1rk6NA"NGFP.bFk-8^4ZD$'`A/IShcLM&dd[RBb(U`YTP\)
T_Zc*#k?lg88"OQrbnck*#n;rXkueu1cQ^:K0XX>ilJhb.nu%cf@0(^U-o=fo+BFCG'd[p@k
G4o@>Ha#LebS]AN[`bn*KZi4=kck7omY12EM1`]AG/(!I,Wu(:qXZ3Bihri45TE7q)IZkaOQCf
,*mjO/A_WmsFoN;a9VH@umoTVjK`cF5*"kATJH(N;ON^g<XBqMdqgL,[]A%9M$An'-;AWT0:b
l1fL]AA)\6eOnPI:9f`ZK[nVO3g0N?=s#d\WO%<1Ra*,#euO/H4^AX(`!*O"a#'DcbR'-ENG/
ZNU'o3ep^EQ=^PV>?f]AnRpf15TJV9et8%1H&'s1,!FA/G4lllW2J:84.U.Z\NuUYf"/XH:j,
.8!Q$J*8ioBfJCOlVh]Ab\^n<.8Fh:E:Xc@Sp.,nVpJd'm7=<O*G2:_oKFUk+qLlH:nGP.Epc
mmJ+QGnZHl<mfkCe1'Yo=>"T1>(U+N3jsHXJVF"4R;BUols=!=#sGf8@AQ"M6,^@YAGGECJT
NLq4n&H*ln2heke^.!t(bs%CX&on2a&0aQNG5M,u=cYH]AKUr\\qJhL$1!g=sae.),,&j#(P#
0*Q@8c)D&HZ2Z8+G`^@EGCGe5q;1l2(A)K19>c4/Q%1u<upZW825#8H#o\>SOY0/_$,>s'9+
:40>jNH?20nrL(W\oGrem!g8<1W9V+>oM_I6J;X_M/mL8V^+ruj/R0us[p::=!Wt!aQ`#YS]A
,,%roT#FXsNHI&66=f8h6co#7\u3TJ@!Buh=81rN>9O,pR_6A3o;V.=H+F:Yo@'4F>d$:')@
Dger@k`V"Nt6N\MHVir[)6;:_+57pO8g/72VaYqHl5"qp#atI!E__32>'sWXBB8,`O3Lb`Q`
"pY;&1#UWO*njbJn+$?SU4f^15s&*&>#s*bgLAiOMg@Mk,"4I@E[HU7#8-2j&S?&0.en+jZG
F@3%?"PPZ1I8n*(bG5OiDiUQ:n<W.d]A5r2oeg;VEG+?#!%,jpRYIK2lGP6q5aY8>%/F>O5bo
A0cC4q.Jo#FtJ!q6`>NQefqVU4$5MZ8BV]A92e)DVEPN=sd5SjrmD5?5KlDGU#NakQ!0iDq*p
pp6J#G[UC<#^i4gB=O429A0^s.$iR.742"GV%l#LT#%Z]A&8<E7'jPO#oiX$6J"W1iA1K!dkC
\@D#gr0c-KUCB@1\rX.feO,"0`:j#h'&`>'tZVK9gM=<%Rj@!Ucs5KXH9PMWbhNTGCs>A.68
,=KDdTJM'ru_Nk59$f\>FTtL3I;Mb@(']ARuU3SfP:g^]A!l&F%m-rq]Aa3A&-RKJ9F+X[[SIj[
4Q;3Q[pPgjLLu'&&?cu.AbGpcEZ3[g+G[?Q1[:-+1JBsEiU")2uHJ=+3D_kTYeTYf,qn#ggR
2[qT,F`PEroV:1VgnVF@k%plF*@6ILjEd<KM3_!'r-C23%!*9nt,7lU1*HF*,9]AbBk,Y3RJR
lbH_0R)3qQeT#<T(`68#*cN"oH-CU_s1/a_^G=,d8I4H_H1j[NV_&r5]ApbH:GoM1"hF6[Ws5
`?9(X`(Ok]A_beO:8bB?KCKH'/mOi>kaPK=t+Bd"bO)LSa_+Ib9lYuA]A*Dt4<8'nr6CKpe'A*
"%-rjYkhEG5q5su:o@$>`S9*'3Su`/Pbo%`GIH#[8blS4Z"nLW=r+(T^o4fS713,JK4TG(`^
\4:4Ida'4s59aa9_&Z,4`A/)9&P>igJ60=g^\gTQfd=9\U*OV(\Od5'%p%$5MrW=KV(Xf)[l
p5V_/n8Wln[&N9&=2oe?$qY:4eWF?m+E88a"B1Pd[OUj?2lp5Qf:%T/fW46>r_5b54l7Q'"c
0?'e,?0jup:XgoLl6%;A<L4;VH$U7AdT-YL-=eoBe^X[BPUubj%3(_OJTR%mO9hshDaiA=%p
Ap'Zc5:aHa:Gu1=duV?1e"MCgTuSF[R@,`F@qd:^1D6ank5tiH5qqYV#gc2!-/P$Tu#Ub+/\
QT.!28boYg(*->R<T"+RCGYc.TYUJ!Yl,P/%'F.oZi^?.3a3/&s,"nJ]AIBWg:N'VA+_[`['l
hoQE<:ML>r6>BE+^HN4G3odrq./^Ng5E1q=`UQs[sNp`a:&[&X'?mQ?\^d48*5V+]A/8$Qjmq
:?s#C.$)sf0C-Vp@O3g</-8&E'5,-iH",e5.`@5di#TohmdpE%u$W";]A@$nIo#Y[E2P18"@?
+ZhFrdC&Gk!!!#M9d(b&oQ68leu'F+NseGJABu1.Crf,dNWm$PZ0LiC=2l@)7$\oE(E,o"cs
:1R_Q#Dm(-ghDchPh9k!-*jMh.AKHM5J@>'-)?^u/b<OQ!rB?p^@dn9(R`?%MC#L-VP#+>dl
E]Aa0bT^i#5aZqMS\GYCge:WOCk82Oe6TG4sTN("EfT>cE^;mG6^9WjM>-=kT!h=\\4QCE13(
gVlUHTT(!HfBlGeO5dniq59@,dJfShrKQ$bZpS?gd5!>BouM?G7d]Al26[?H8-%RLB?<bbQ\I
qZ9VB%;r.Bc`rhu19%gfB,j5M)H`2):_4X1?2d7ZXe)&X=YctEn5HmUp1$%?f:NsjF!5U3QW
A4q@hfN2<3:_//6AJ="*<^"uSWFmsc8VU]ATIaZ3I&3*7<E470YO\#%=7fjBufKJjETFJ1hUH
ebpkg+H9j%-48P+2V1-8i)*Dr"J$J)SN'8N4MV.e#DA#?[dNMQ2?s&rDq4n?2uBN9&=0\&OP
qEi0"8#n`<;?emDL"Ac'f6"E4aM#l3L^ca#a,fLg]A-%k#-S7MX0OW7N//')&8@^4F%l:)^Y>
k#,8$<d%lS/fI_5CV@+!td1'Sop4(MYgodJ1^8iW?@7NB/g[4,,/qsdo9+(BPh:lTS]A!1@i`
q%_Ipmg5B$HY&>GP4QR4Vp0b%PY1k`-HDjNqELqB9hI0f81IWAeG@<N1o/KceLE%Vu:J;7-c
aKQ=c7Xk*HE<3/2DZK("T#(F_&,?1o!7SW-b`b\Z3%US5I_$DDaNF?ZdJk%A2&1\]AiS_Yc?g
hTtpgMY_!s&\m<ePaaY%J(/ml/'/>*,l4]AaWNCOeF#SMmQ#'r\O`SRa?ZMC7EW:JlgT_TYr3
2)cgWf$>dd#7RY^[=fW[14c,2t@S*n;`A;q`H?V8KTW15GG!N!d;!_-H#X6L4:Mha/=O#l@7
Uiq,S-QPGe)IGu<4%mZI#rH&Is":PL*u4qQOOjmL.9efYo'=YrP1]A)P7RO[,/W_WYJf+PfRC
o1[tm,Z/:"qfmPk7Ie8",orU`1288:IWY\A2Vh+\B8*4>qZAp9kR/bj%G[OmgT@Q),5+h,\n
oc`(.c3IU95eAcQCQG80oW+H=Z7lUV@KIT(OM&Kq6+Xg^mIE:_6]A,E8O"Kj&bQ<k`Ir#/$r!
tbr]ARabFN32T4ch`H7`==%FCA^1?P0U0k9`-CX#^aVZ0L_WpRplJ$^eT\S"9E!Pr3PhBn$]Ai
>SuBLmCCtLXoQR0bHBqZd/?%=?^EdGV_Hh!/]A.pE-B;DZd@9^S*.XkRd?nq'XL]A2Kd+I`bW5
BDBg%Gq+%rf]Aq9>!tZ,[f"R;PAdS@e"`)gCJBUeU'jn5.^p9V"$m]A2HE3T-HYRE5VobG4=:A
`eEeMfa>1X2omHO8NrDG;#l4%SM\;\?LIWZ/jQLUT="c1-,IHp;1i[m;.-bi(I/-c2&)MZ0C
6l9k;F>KHTmR3B/p-\J?FA)u$Lg^74OM*&!)U]AbO+;f;t>H*FK5!$q0i8@tHg_HGL(mr<FX,
u]AhJ(EERFYj#YHaMZ[A2"@Pd2*``p]A$_*U).80$?e3XE-rG:H!2[1#/I%uLXF9L+bD%mfg1:
&[).)>"3D<@U!75(83m-Z!B?kepX#$ci7#50o5%Y2mr2JqmB3SL"$pt=/fYbuiB<sBY$tQ2$
0b(#%fjah:LG=h`Q4@(m)XinmjF7A<=#*0NYb$9(h"A1,kMc`!D4?""Sr=$(\(_BKl@b=`5j
flr1mNtrF))g"b*N?,iLcYha]A2KQ^<1mb5?_~
]]></IM>
<ReportFitAttr fitStateInPC="1" fitFont="false"/>
<ElementCaseMobileAttrProvider horizontal="1" vertical="3" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="472"/>
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
<BoundsAttr x="0" y="66" width="960" height="472"/>
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
<WidgetName name="lb"/>
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
<Dict key="CB" value="机群"/>
<Dict key="73" value="B737"/>
<Dict key="74" value="B747"/>
<Dict key="75" value="B757"/>
<Dict key="76" value="B767"/>
</CustomDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[CB]]></O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="85" y="7" width="150" height="25"/>
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
<BoundsAttr x="10" y="7" width="76" height="25"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="Label机型"/>
<Widget widgetName="lb"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="33" width="960" height="33"/>
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
<![CDATA[成本拆分明细清单]]></O>
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
<![CDATA[m<f:@;chPbrES56SQ_D[*GmZqcdjMQ[a@AK84]AVS1MCNseG?+m-DblnX?q/!aQ$$23uLJDV-
$\<)$_[_qM:"A&TXWjc"$h74493qJO%#4`$CGfbtW5n$ah#01+R"Kq"NZDZBiZQmloq&Hd:L
FpY5T3\G_\GpkO>RlPEKs9R1m%neYZ(1?H8b;l36:q<'ses!@KeZRo+Q]A`6'1(S?2ZTOP^0/
Y8N=hiMYZQ(EG&qs^$Olj)=>3Rd=Z1DXdfpH&2sp%=c!5C_^qP7J_GH9J6WdtrQ:FYZ'Q4G\
=`2"_R-Or4(1rsWF5;7TXA(+*)qDA==q>dT7F%eZlZ@9Fj!C0`*S:5R-'ICF+K0rd7-+stc^
Z$uPj`DKQD]AD+?o-G7FY[VbKF_HuKrTSo85V?OrBpgQq:Vr&OO&0?72?089eN7,Q+oC#?^$E
dO_kP=EBaMg%1V;d[&]A7)=DrI?4%P*QY#3T9d$NSbHi8rG6=CP+t7Z%"pC7q5be]A=4nX9tY)
qZuf[I$!ub[OC1LpPj--DRf$pjQA::e`>%(IEC=@Rh,*0aT.sPjUp?j%_`$*QD3*U6WZZ@dK
tpN%?\NY0jcHq/%]A;Xun]Alqkl+V4Wc`#^9]AI^M6Gb#_-;q[KAZ&BIcp@a4$]A.>FIRRST`2(<
mD^Q>K<;FXgm\Zis%N)bQ?k\\TBEl*&jN$#*^QYF\[1mTR@'4C6Bg6;[)"3o/.%/-+`:ssc[
e?"VW7]AZ?Z9s&i!S.D5-N6b>]AeINf8krslN=iU`r4XF5Q)f6,/ZlKnB^hR(pHdYJ+4;=8X-^
Rn+TuiE9`?ilj&`s#W\M\NML<j)1Not":(0k+=n5U0IL=['<LP)(6h]A/1l(,FJ-8@PAgmt,@
X2`c:g[:q&$FJ,O%YL=gY.mk^6r$e%^%l>A&9=^Pfji"WU_pK@2#Z]A7VW[VL]A\@49+lR&Dj1
Se&S13i`Q)$\jBn`/3)9)Ao\VNLX\37:7ph)d1W;.p"u\MYDp)X,T'$Z7V4R]A=bt[X5FV1;q
R^hP?leK&SY6EC-_TOhJ4Q)7b0:?EK<7A7/9`kgY@TD=7k<ga>lFTIC=rAQ0)mSQ4Al-C;U#
QDYjt!Bp0k._EiC0);98?f<0e\"]AT$Q:8'<md)m).sdbLXsF%C?0HA87gQd;_<B-Gk.3A?;r
]A_AW:5d&1W^#b?dS0p\=h?R%5Z7C?Tc8%jSudE1co5KY]AA*6;^M/A4fUKLYM""RjA]AmFRHC<
H3iuqF3+62^a6/q@-J8A^gMo(gfsFr2mRM=^,21<NR4g&'4h1oNn9>09P,,*A,LM>@2=e[/U
_t4E]Aq#0O+Pi)+.L&Gu1NYuh#._;.ejet]A.DDpshP*Q;4roRe.gcfT[^s3B&me7%*9pg3O[b
eArB>GIO^:A/p6C_d,ku5R"_jFV]Anf"KM%VR]AT6mL#n%n5Ue7\YNU[l#X[V*q$<#Lt9?IPL1
osYT?a6g@Rqm50+B;Qs8?68D2o)=GQc(9ehgAG(u.MS4'kEEo8Y4K&oNN=f%hjXme8TO7>'8
[d/I,DYdYAYcC4<e@to:580SY,+24S7KmY>;p7gObcgIVo"OXCIq\6Dl"QjNr;oPD`'`f+dY
uB_dC[='Jm5#;2F^gGaU%oUo[V2cOT<n(NHP@HdVk[N?H+d6\9A.0E@8V8?]AS8`GgX[Ppc#P
Bke3`e9u+$*7M$lZSrSiXQ`WKZFEBNXfR%DEHCpn6/b=Ka;V7@;`<Qb36t`M(Rk5T.AKq'+W
W!TuTO&DR70o:F),^O_Si]As.(';Z+$>16!c-rbGBluRh\Dp;]Ahar'A+b%\Pp=EH1tL]ASd\Mb
:8rG#KFbIDG.!jdC^AEiGF@QUdp+@ZSEX>!,M'n3>MNiMmZ:cA+$(gXpZn3E,]AXW7[@;+0)M
p$J"b\hgaAP%(.2Z+9$4ULCV`J*gq^GP`M[C&`*SC`fAaJgR\bp#<U;/:*2eY:`GIsU&H0b@
"^[THq#-sY/NeqBFeV^l^CZd:G135f"NC@qN,V#Fih;Pl_M-7oYWUQ`]A0'.e_X$^p>s,(s`K
H?sAWmZe5*0)]AsQU>.S(7rVWhF:5\(H>/H]A(lgfA8[b,?W)fpC=8]A$9?5mM?:LpGFX%Y$6hg
#tZ!2WOnpNY2Hac[LS19T%k*[<lMg\=a>H+VoIDJD;B:AI_(j<)#o46OV&Mp4T@=d6>+:\nk
;KTrdG86GU-dg-l-JQP]AG3Kh+T_n_k&rRO`ne`j;;s8!XT.2Kh?1OE><Ub4A_KXRB`[s[0Wn
]A)D?hM?7Ruh#kX-QlP1jAnAF%Qcr2"k+tVU/jQ`7WEb6lT&0Ps['%L=F1]Ae?G4TL-/V20O,,
FRE\_'Hto0'<c@FuG+NK[L!"]AK9HTaVTRh<cjIUh[l$<NnUYT+Q02K[!gNj`7M*eTpqds]AI2
VDE:eJA)Y%UXR+8ON]A!Bh^X6N?.R\qW%;Nn'fYiOlYkeTQ0q:E%Rmg3b7N:f0iFO%T)>/q0]A
QX/5m:k;J`Np%?!Ua7`H.94iqtP/o]A+X7,Pd7X>WK_8r&)P5at+DZ+Ad_8TF(=X5Br1'/m>[
2d^WA\=XaC^?7)[?rOVP)MW9#H!N<T,f5:Yh57LCgH7+Z@Z!1gh)-MIO,6iLnGj*-/;K!UYZ
U)*18D0J)*..'=?Dn%m_+?7UGR_@N`<b>L:H_C-JP'&r=?XNVqH:UP.[c"VCBO`k*A[*ZV\1
,()E$2\g4"Nje:%1NXl%ak=>9#aAXCffAe`*.BAc>D3RN!EE]AQa+HJ)+.W9-A=eX)T]AXo[7%
b6L-m[iU4#H,#Fdpsro^?s(P)+A\W"ie:5>7ki^H6T/%;92_k[;M6$&09;bM[[.jf_bENrtg
N_VljoaDo63pUG2;=1e!MG/h1FWHR#7lJ>:aTGUIeuPlYN(>h6Z;W3Wpd/u)kT/@RMuk/HnU
:V.R)I4=s:B"<)86N=hL7Ka"mI9pHClB;$?hCd!/W\[FcQfO=5)'Oe_!UT('j_+S^2/4GMQH
B\I51/unBT<r(0#p)^U%oj3A<8n;C/rED$j'bYI6j9NX!N?A'u$csEB)euZ_u9r1?PaWPOY[
`=ha0ga[KBt_eJ&j\EjjR*MG3>JjQ]Alc:@P9QP_7%&VkQ_Q]A=0uRbD]AZN>CRXZce#RRtdYPP
?b-Yen*0=GSY&$#TVWBm=RKkm7C'=]A6G-_b80bR?4l5&8i.NoU2K/S]A92$Gpo6?Ae(eo9JOf
D0W)7%(Yk)k&]A!qm(kq2Nk-8:/*MgB^qg.a:5bjr?MG1>]AVXZj75hpI67e`gJH_kOc-"nh;-
jLYa'cOF@9o?R=DX=G9s941ue0L&[HX1;)`@C$E%=GsL31EHE]ARp<J(Q&"8i]AJJ':d"u1bZp
`)j'c^>4/q$?#?fZ,S.n_"r2f_t[p$1R$5*LTKMB%Bq\S1.j13G/U&t+[nA,8]A\SU=F1.*VI
7W:2$q?^E*]ATBn+efD&5ckRFX=]AP]AeFrIRb_Dfr+_n8#r(-JlC=hlIhA4N]AYoCKVJqX7@`OU
mi'IU;p&#R)L_@$PV$*87gPSCiqHWmeR4Y%CD*8MYp&kgU[V,K3,\/>X9.eN7d=#?.Ms%j8#
n;cJ5u+<?`-\SVl&D>YLD:hdVDRFeJ*1Ft1=]Ar-=9\iIQK587YAuS%?o_=?,2K:ujum?PCl9
A?Bn9,%l1IR`l;)<_Y-@04VnBCZ.YAY-bOUG)oT;m]AMmiI+@9rlju44IN^4jKBb,*juk4#Oq
TN1ZiFPq>?+DOWYkbKF@gID4;-39NsI9r9U!L[.l'7?PZ+2?$;i=3)`BjtHRi)XcOdOQb;^/
`f2Y[Mb.,(S(((EQJj2!7U&X3Mo!ngE?:71uN,6^D@9WAif\??r=d2^P9;eI,Ko*J(Y-*PD@
EPKn`Od)=-R1Xj68)%>q-@\-mE.4i$B6#'L/%KE(AG^^Js?dYP>Rl,n?APmCQ)F=<]AG5ONR-
#;3[g&ma)O6-Yn!/Yb(<3OP8OP"C'2^/I&3s:A\5e$NaG(5dR2_C@s5Sn,Xug=E\ahC-PrrO
2U>>]AUe36`7WH,DBa#LhGP@WJj#%#Dok.Hgjs,>0n\IQN6E]Ar*DXaQ\>*C"V#]AiCWC,i;K0]A
S3Pk&a,>liF<BA4a.b?e0TA/<3Smc/bug7GscLhMio50q4$FI3g0&gW)5.@pq2Gs22.2me68
J(R^;lQT0Y2B99`@bA0db`Sc$0q/j%/5bt74Vc5\>4Y%s6Xq;aIA@ZWD)]A:i:<(,Zm&rH7B,
^>B!PLYu[/B^MOKm%<kDBs2i)&qsIkfBSNGD;;:.AuL=>P5),/+H\&C8E6H7Le53?60gO4th
(Z(Ade9_Wt%'n1uiMQ.BBn+%:i`Z_T@7?<qffB7LB%HS='S/J1VuIFul%%_hbA=l$_b]A<t!?
;)-V8=+%LJL.lm2G?:\S=:?QIGpPR2MX"/r9R6JO2]A\o@"P32!3l7nXHi`QB4CGjoqF`QWQm
F7>iNAK4^SjKro2PFL#X$bOQVQ0/4^0=^[FK$\^4jT'c6AbmO_.gS2;-Z3hQ<o-ZHIF1nY1\
S<0K-PnQ20QH2@Ga81_kT;6a5N4V[G$-2,F.R)Wr/81Nf[5IO?V7[&'b\f<ah2!9i`7mquFb
h/"<@Yk'85K7-qdD7TorVDPWB?[<k#"P8Df&'f.9Dc.$6rI0m$r47Ls0o*T\O7;G0>"b$8KU
Y_>gMZm6DK<R)>OKm#fR`H3d/bBf:E_,UZ+PEZ]Ar+k(jGs8)on[(Stmo@lV!`@7*Q0iElRg_
Y2//-EClW2cL(K)HYU"(q)+l5EV$r-'9+8=lY+,hS,VujHP0VNn&qg#X[knU)Y1nB2a@((@W
tdHf=1@T*NR:$44i;PQlCGQK0[u'9\$#)>-'?'rI_8RJb3FF?T8/dKje:es%)V!-eOYR,ekh
?3%&c-H#`AioP^(9P)bV_OtT#hKuBM*^5Ln$?(#U[9e"!g"3i.)q7`V6S#L;O,5SGB05[j<$
!HWBp\:3[4^;RO_QLJihHT^,;l%Y+(QM+I#iG[K;0&TYdC8[f&4p.#?i2jT:?Kb]A9M.Ejing
Gs;jND?#\so(=`(S2`UR'k(j<ckj.MF5\%>,(hND3P3T\GFH\qInZd^(aj++)G`5:ip\&-^R
2&@0t"O\gjllmDA$#T=W@mIKWUG"7ID%Gh=`?cL+A-f!0Hfb%8Yl"0WJaH"'CT`fGn))"Eci
^BV1?>eD7Ad^(Bnth/F^g/+f.l;hl^+5pbuG.c2jaPq73E.aK^PY;g1\+Z#_3T1Eg&T%k(_=
F1WL_&C1_oqZftl*Bdb+b*djp@2Wnh<1GJ/UPHpjM3Y8MQ-j!UO^@KFL<&SB<+Nr8l&"2]AK&
9MBMfd+rCk<RW`!d'r`lTd_UAA\`S-3lqG2pr:M%1"Q0O'Qm.=5'#Q(g1q7!K]A/R`#o]AOB0H
,bFOEFcTrOmUm?8#=l#>PjB,P9H"(9=c?=XFj&s-8=E]A,]A"p(&(%!Wd!!T[RWVaIcM[&Qh.j
U_Y@2*6C_+953tMJ]AuRQD6Qdm0JOI-]AunENPn@APC2<U"IWUhBqi!q3O^fNc<Zo]AL4dO5s#"
#5Tm&KF.*HgCB1W`@'T`7r_p8rqrs5-ep-/Y+O?Ea,K1p/JM[d'JF[-u16q_cBn+!%N^A1EW
AbT/[0]AU@in%#GLIE)eqs2(f9W"gAlArPEM.#k1V`_r83If:':;.[l]AOKkl;=WB]A'n#7tJQ9
09RGLZBb3Pc!V^HjgJ[^eC0*G'm!->UqB\_s[m3!"0a-0>Id'M'1`2D7%43E.2@@b7s8G'\^
es'*@?[8g.Lql%"s-#cs&D:HBW=s0S@Fpj<1jiDecN7S\N]A,""YZ'.,oki2J7'Od3C?1lCeG
F.AR3e@.aAdsAOir<ZXRRA>oD0n!j_l!sE@2qi,f_&Vb5Nj,aL:o[KJ*rq/RZ)`>,AQXQd%G
@k<IBS/$I8-fZna7Z]A9u>PD%)td4=/fI*"<*#>c)T\74c#LN^>DE^<ITT2?)\A\/K@&9!W'u
c4AB:d'W=8d\>n>Jak`akrc"B*XG``c0gAK@6lkOS_UX3DI%9oZeK2JWQ]AnNSJ]A3_t-U]AV'm
*n:]Aj`,cEhtk5?X\KoTr1K)Zb2Y?r]Au)>_k@j3rOAgcnX"so>N4]A4c(!d!Q5;[s-8lJ$,:X?
n__6i27,SK$#_WE54&In*RTemHh&&KVaS-,L`;UNK!g/9RDE1,L^678cX)MR%a]A*3%cMqbs\
l`07+pQNQL&9W5+,<t]ANJrIbd0SE).jQ$Ru5HdRB\oo$m(@ZlIUGGn:r$Vh2UPfX'PV9h"!O
LF0C/[9i!]Aea10G)hC47)iL[g.k]A\r:GfFL(4CZKhWq*O.--^7F7j>DJ">!5WI7dt3._BCI`
a.*utN8F,49D/i&a=DG<sNqiR(cfqJ@QLVKV"8aWM7tT`F'N),fq$>IJ831s['+Yq.pq2Z9P
8W7g`qNao5.pt6%t"0L_>sXNUUHE7K3+%6dlem!Vu(qT<>#[:CL#6WG^sV6B&a<r+"+D.a_^
E1bP$6]A-[g+par;JYo'kAq3/Lhtk6"`aC1ReL_ta<`)K)H10ErES2*)RPI#m)6pC?hul:Sa@
;;&Y:EFE=NhW3"+raU)`]Ah)A7Hq_7SA_kQ4/>G0WG<1aN7NPB5a_7_e^u(X/Qa*T]AO4Z]A[[0
Ss,3akOo3`Y/sfe<OQfi?$j!JM7DdhDC+irAWG/H+2=3se?)rdp<`>9<`K/J7m6nRjh"-.uW
$!1MGJ3Ys]A&`nk(9)Ue$:Idpn!nYh/X03=B.7:rE@F^2$*Spg"f91Zreq!uUTje'5W\W2iWE
/(/KRCnn1R<RmZao6R]A]A*1&f-kWce&JNu(+q%$"s4%FgDsr&lp!L\<Lo:t3@n)7As4;is2]Aj
Ls_nf,FKGD[bPtI[shWX,j-H!.kM)RU%kPrL_0I/gYT^0V/B7c&1[Ps6c?r9kSjY+R?D2<`O
9\<\SLj5!79>*_lFgVOE);rml#$[Vp?;@IYpV_AUApVk<rGOl=hi*ufB/Nd!odk9!BtT0>E(
XJK#ut[Ia"2/#-M<imK@Fj>dCB'#m-;[fcrCa_OeG5F2g9T:iBWI]A^rgZ%!S2;N)&"46I8Uj
.id:^>6Hl=,;W0,ra:XsZhor_loT*>h)I9go'!6Y8,6#DtbjBS;An@#X]ASF0@8Gqnt@Fl5!6
2:=`_*EC5\<5iOW`XK-[BA="^q:E.(,978`;l$c:+r>r;F>/[.$1H(8\2Z25TkUYaNT9O9Ip
bf%ha8!g&=IjLjrUBLqDsWq'm-F7YAjNpa>9E]AUsX=\9&0/OR_IiW-a\#r\Yq"8L-ldR,J]AO
7-/LM<6/F$5BIu[<APBnN5YeUHK'd+qidONX48gX&"rubk3ZF@:r\o$jj<[?+]Ai9IW5]AN)M5
MQsdfEnEE7`Q))AS'o4Wt$uLH<?TiqfZTcGM]A9-nu'\m1q/W#g-W4_t<KX#X9_YEU3"R(ZX6
5pD$l1Y(NTg!>ks-3W8S<7P%$&:oM`50O'dCD+9.BO=C-"+RnMaEZQRoAq2!7=^l&8%)XmfQ
:h><#++pseM9VQX%lqCc_X!W]Ae.UA,\L79!5uk"A(^de!5ZaX7#btJkePFS6fZ_=$u[o="3g
817KS6&;)uCGQr,Q;W&Da"aVL4rlj1PI4:)p?E+s<KlFB/Tb$XNVfY2r2gL^[_gUmd6;%Cm<
JH1fR=b-#J)8M`b_ItL:'3@CL;)&0m'1k6_5B&lWJ.Z)5;\9Kq<3KKtYDsE=l\C$#U%kN66C
JTt2#<15\^,%*!$uo?)g7ckW"Eq2*6:#j(.KWp4(TTZIM`298K[<RY*&SZo`,K>oj;Se,Q:Y
ZU)*uj!e)m3E:O$E2qP'(nHcNeL.7C4!_]AY_NH9.BLOf(DkOT?["LBQh@b@OBi9pQDcB?'0>
qs`gI[p1"U9oToj$EBR'YX[h6=h=Z"G+Q+4q8\INCf*'6NFElggm*aZ^a_`L&fXb6/kM"ZU3
+An5.EP#4Sc-0YCj<_>)\KJY96sbI9"LeKF><T"(1:RWu6+a[4-o.\mK![!#d]A5ijYP^;D#g
KZZ^`8XC0YE're$5h/PQPnRTSYdGS`g%Z8O[G-$F&FNMF44+%)J?dg$]Aesu-&%&@r_@Zc3ks
D!oU/)ui,iXA!?Ar-c"7\eTLaTJ2^?Y6FiZn+3Og&8@i*$L$_se=DW[88L-4fbretF/Onpoh
KT+2h'3,='Pn3G):M1%bt\R-TSRm:[*QV:1bQMHBV=-LY9hC4QH6e6dQSC&!5)1j5d+Ed\L_
?0cl4n5NX4I+6rQ4Z:Z$ifLm`YU!t\<G,+&Kt'hTg4,9&ACpH;Xu5</[YNj"$G/_;j"^jY<<
Fm.jL11FiYJ]A+b@FVI!-)d:`bu;d!)_P7&Mf#oM$H/^k7;"OuM@Pjs65i:/k,J_Uj=$\fqnI
PT]A>@i&u6KO7Ef4a'K"neJ<Ico)eHsfPsL0]AlJ+"04=NJ9j'7eR?&5XG;cDFM#cF9!Pf0l*^
(.r<g;_?da=KWrV&i\ri6\a?QH%@FfjAnfBX%HOp/pnRLXNJ,lc53Leg8sV#8,QeL$(Zd!"Y
[S-IE76=haaXrothapk2H"CPdW3cV\>kWjOb_JhFt(D='FB$j>':^+CJFfY?c:[oc-nGlATn
i;dOli\>cGu<r%`.M0o>HM9b@kIjs%d?Q*<_GC3!)5$)PFT8F+p0J-k>=dk1C5>MOTh*u?t#
?)qfiP`Xsn1mDs[L(hq/[6$]A'/`+>rF3;mXs5Q,0S>7Z4)oTIEBMO,tmtkZf!>aT_kq?X+jV
l-9KIMcN"fFtYj8+.t9V$oUN-`2d?BQ70N&mgcF2e-OKh8PFF#854'Nj(jZL+[7K+Qgj">(Z
'E2rr<~
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
<TemplateIdAttMark TemplateId="834c3465-b127-4916-aa79-c12b248f7783"/>
</TemplateIdAttMark>
</Form>
