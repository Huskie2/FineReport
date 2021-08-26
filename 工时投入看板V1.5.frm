<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="部门" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select short_name as '部门'
from air_rz_fact_kq_month
where type_code in ('部门','全司') 
and date_format(STR_TO_DATE(concat(time_code,'01'), '%Y%m%d'),'%Y')=DATE_FORMAT(date_add(now(),interval -1 month),'%Y')
group by short_name]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="部门比对" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="rq"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=format(MONTHDELTA(today(),-1),"yyyyMM")]]></Attributes>
</O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
time_code
,rz_bm_system
,rz_bm_system_sort
,rz_bm_new
,short_name

,sum(cast(zz_rgs as signed)) as  '投入工时总和'
,sum(is_work) as '行政参照'
,sum(people_rate) as '折算人数'
,sum(cast(zz_rgs as signed))/sum(people_rate) as '人均投入工时'
,sum(cast(zz_rgs as signed))/sum(is_work*8)  as  '投入工时满足率'

from air_rz_fact_kq_month
where time_code='${rq}' and type_code='部门'

group by rz_bm_new,short_name,rz_bm_system,rz_bm_system_sort
order by rz_bm_system_sort asc ,sum(cast(zz_rgs as signed))/sum(people_rate) desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="部门疲劳" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="rq"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=format(MONTHDELTA(today(),-1),"yyyyMM")]]></Attributes>
</O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
time_code as '日期'
,rz_bm_new
,short_name as '部门简称'
,cast(pl_count as unsigned) as '疲劳人数'
,cast(no_pl_count as unsigned) as '非疲劳人员'
,p_num_all as '总人数'
,cast(pl_count as unsigned)/cast(p_num_all  as unsigned) as '疲劳占比'
,if_pl as '是否预警'
from air_rz_fact_kq_month
where type_code='部门' and pl_count>0
and time_code='${rq}'
order by cast(pl_count as unsigned)/cast(p_num_all  as unsigned)  desc
]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="处室疲劳" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="rq"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=format(MONTHDELTA(today(),-1),"yyyyMM")]]></Attributes>
</O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
time_code as '日期'
,concat(short_name,"-",rz_cs) as '处室'
,pl_count as '疲劳人数'
,cast(no_pl_count as unsigned) as '非疲劳人员'
,p_num_all as '总人数'
,cast(pl_count as unsigned) /cast(p_num_all as unsigned) as '疲劳占比'
,if_pl as '是否预警'
from air_rz_fact_kq_month
where type_code='处室' and pl_count>0 and cast(p_num_all as unsigned)>5
and time_code='${rq}'
order by cast(pl_count as unsigned)/cast(p_num_all as unsigned) desc
limit 10]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="地面体系第一" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
rz_bm_system
,rz_bm_new
,system_rn
from air_rz_fact_kq_month
where type_code ='部门'and date_format(STR_TO_DATE(concat(time_code,'01'), '%Y%m%d'),'%Y%m')=DATE_FORMAT(date_add(now(),interval -1 month),'%Y%m')
and system_rn=1
and rz_bm_system='地面体系']]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="飞行体系第一" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
rz_bm_system
,rz_bm_new
,system_rn
from air_rz_fact_kq_month
where type_code ='部门'and date_format(STR_TO_DATE(concat(time_code,'01'), '%Y%m%d'),'%Y%m')=DATE_FORMAT(date_add(now(),interval -1 month),'%Y%m')
and system_rn=1
and rz_bm_system='飞行体系']]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="岗位疲劳" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="rq"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=format(MONTHDELTA(today(),-1),"yyyyMM")]]></Attributes>
</O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
time_code as '日期'
,plans_t as '岗位'
,pl_count as '疲劳人数'
,cast(no_pl_count as unsigned) as '非疲劳人员'
,p_num_all as '总人数'
,cast(pl_count as unsigned)/cast(p_num_all as unsigned) as '疲劳占比'
,if_pl as '是否预警'
from air_rz_fact_kq_month
where type_code='岗位' and pl_count>0
and time_code='${rq}'
and plans_t in ("特车岗","现场控制岗","维修放行岗","维修技术员岗","运控签派岗","安检岗")
order by cast(pl_count as unsigned)/cast(p_num_all as unsigned) desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="月度趋势比对" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="bm"/>
<O>
<![CDATA[全司]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
 a.month_code
,a.type_code
,b.year_code
,concat(a.month_code,'月')
,a.short_name  
,c.zz_rgs_pj  '今年人均投入工时'
,d.zz_rgs_pj  '去年人均投入工时'
,c.zz_rgs_rate  '今年投入工时满足率'
,d.zz_rgs_rate  '去年投入工时满足率'
from
(select a1.month_code,a2.type_code,a2.short_name from dim_rz_kq_month a1
left join (select distinct type_code,short_name  from air_rz_fact_kq_month a2 where a2.type_code in ('部门','全司') and a2.short_name='${bm}') a2
on 1 = 1) a
left join (select max(year_code) as year_code,type_code,short_name  from air_rz_fact_kq_month where type_code in ('部门','全司') group by type_code,short_name) b
on a.type_code = b.type_code
and a.short_name = b.short_name
left join air_rz_fact_kq_month c
on a.type_code = c.type_code
and a.month_code = c.month_code
and b.year_code = c.year_code
and a.short_name = c.short_name
and c.type_code in ('部门','全司')
left join air_rz_fact_kq_month d
on a.type_code = d.type_code
and a.month_code = d.month_code
and b.year_code = cast(d.year_code as SIGNED)+1
and a.short_name = d.short_name
and d.type_code in ('部门','全司')
order by cast(a.month_code as signed) asc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="机务体系第一" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
rz_bm_system
,rz_bm_new
,system_rn
from air_rz_fact_kq_month
where type_code ='部门'and date_format(STR_TO_DATE(concat(time_code,'01'), '%Y%m%d'),'%Y%m')=DATE_FORMAT(date_add(now(),interval -1 month),'%Y%m')
and system_rn=1
and rz_bm_system='机务体系']]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="月份" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
time_code as '日期'
from air_rz_fact_kq_month
group by time_code 
order by  time_code desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="指标" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="rq"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=format(MONTHDELTA(today(),-1),"yyyyMM")]]></Attributes>
</O>
</Parameter>
<Parameter>
<Attributes name="bm"/>
<O>
<![CDATA[全司]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
time_code as '日期'
,zz_rgs_pj as '人均投入工时'
,zz_rgs_pj_tb as '人均投入工时同比'
,zz_rgs_pj_hb as '人均投入工时环比'
,zz_rgs_pj_avg as '累计人均投入工时'
,zz_rgs_rate as '工时投入满足率'
,zz_rgs_rate_tb as '工时投入满足率同比'
,zz_rgs_rate_hb as '工时投入满足率环比'
,zz_rgs_pj_avg as '累计工时投入满足率'
from air_rz_fact_kq_month
where type_code in ('全司','部门')and  time_code='${rq}' and short_name='${bm}'
limit 1
]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="Embedded1" class="com.fr.data.impl.EmbeddedTableData">
<Parameters/>
<DSName>
<![CDATA[]]></DSName>
<ColumnNames>
<![CDATA[部门,,.,,疲劳人员,,.,,非疲劳人员,,.,,疲劳占比]]></ColumnNames>
<ColumnTypes>
<![CDATA[java.lang.String,java.lang.String,java.lang.String,java.lang.Double]]></ColumnTypes>
<RowData ColumnTypes="java.lang.String,java.lang.String,java.lang.String,java.lang.Double">
<![CDATA[HT#Nge#nCp('^:`"pUS%H5<A_:ZlP=3Hl(5\H/T?8As;Blc#/)0AH@abmZRk5pE12003,sRl
c2Me:?!N,[b?)olBT8(CPRT>_j^O0$b)jC.#30'/#=gO9A\2#QO~
]]></RowData>
</TableData>
<TableData name="部门年度累计排名" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="rq"/>
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
time_code as '日期'
,rz_bm_new as '部门'
,short_name as '部门简称'
,zz_rgs_pj_avg as '累计人均投入工时'
,zz_rgs_pj_avg_rn as '累计人均投入工时排名'
,(select zz_rgs_pj_avg as '累计人均投入工时'
from air_rz_fact_kq_month
where type_code ='全司' 
and time_code='${rq}') as '全司累计人均投入工时'
from air_rz_fact_kq_month
where type_code in ('部门','公司') and zz_rgs_pj_avg_rn<=5
and time_code='${rq}'
order by cast(zz_rgs_pj_avg as signed) asc,zz_rgs_pj_avg_rn desc
limit 5]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="指标-年度累计满足率" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="rq"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=format(MONTHDELTA(TODAY(),-1),"yyyyMM")]]></Attributes>
</O>
</Parameter>
<Parameter>
<Attributes name="bm"/>
<O>
<![CDATA[IT]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select time_code
,zz_rgs_rate
from air_rz_fact_kq_month
where type_code in ('全司','部门') and short_name='${bm}'
and left(time_code,4)=left('${rq}',4)
and date_format(STR_TO_DATE(concat(time_code,'01'), '%Y%m%d'),'%Y%m')<=date_format(STR_TO_DATE(concat('${rq}','01'), '%Y%m%d'),'%Y%m')
and date_format(STR_TO_DATE(concat(time_code,'01'), '%Y%m%d'),'%Y%m')>=date_format(STR_TO_DATE(concat(left('${rq}',4),'01','01'), '%Y%m%d'),'%Y%m')
]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="ds1" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select t.*
from air_rz_fact_kq_month t
where type_code='岗位']]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="qsyj" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
time_code as '日期'
,zz_rgs_pj_avg as '累计人均投入工时'

from air_rz_fact_kq_month
where type_code ='全司' 
and date_format(STR_TO_DATE(concat(time_code,'01'), '%Y%m%d'),'%Y%m')=DATE_FORMAT(date_add(now(),interval -1 month),'%Y%m')

]]></Query>
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
<FRFont name="宋体" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ColorBackground" color="-15378278"/>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="absolute0"/>
<WidgetID widgetID="700d3c06-53da-43ae-afa1-26ad7658823a"/>
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
<WidgetName name="chart0_c_c_c"/>
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
<WidgetName name="chart0_c_c_c"/>
<WidgetID widgetID="03443dff-aa65-4db4-a5ee-8ae457cdd728"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<![CDATA[处室风险监控]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="2"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.custom.VanChartCustomPlot">
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
<ConditionAttr name=""/>
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
<Attr position="1" visible="false" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<OColor colvalue="-12080918"/>
<OColor colvalue="-1222640"/>
<OColor colvalue="-1197808"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="true" categoryNum="1"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="true"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0" maxValue="=250"/>
<AxisUnit201106 isCustomMainUnit="true" isCustomSecUnit="false" mainUnit="=10" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0" maxValue="=250"/>
<AxisUnit201106 isCustomMainUnit="true" isCustomSecUnit="false" mainUnit="=10" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<VanChartCustomPlotAttr customStyle="stack_column_line"/>
<CustomPlotList>
<VanChartPlot class="com.fr.plugin.chart.column.VanChartColumnPlot">
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="5"/>
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${CATEGORY}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${CATEGORY}${SERIES}${VALUE}"/>
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
<TableFieldCollection/>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="true"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0" maxValue="=250"/>
<AxisUnit201106 isCustomMainUnit="true" isCustomSecUnit="false" mainUnit="=10" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0" maxValue="=250"/>
<AxisUnit201106 isCustomMainUnit="true" isCustomSecUnit="false" mainUnit="=10" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="0" stacked="true" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="30.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="false"/>
</VanChartPlot>
<VanChartPlot class="com.fr.plugin.chart.line.VanChartLinePlot">
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${CATEGORY}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${CATEGORY}${SERIES}${VALUE}"/>
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
<TableFieldCollection/>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
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
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="solid" lineWidth="2.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="AutoMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="true"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0" maxValue="=250"/>
<AxisUnit201106 isCustomMainUnit="true" isCustomSecUnit="false" mainUnit="=10" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0" maxValue="=250"/>
<AxisUnit201106 isCustomMainUnit="true" isCustomSecUnit="false" mainUnit="=10" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="1" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
</VanChartPlot>
</CustomPlotList>
</Plot>
<ChartDefinition>
<CustomDefinition>
<DefinitionMapList>
<DefinitionMap key="column">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[部门年度累计排名]]></Name>
</TableData>
<CategoryName value="部门简称"/>
<ChartSummaryColumn name="累计人均投入工时" function="com.fr.data.util.function.NoneFunction" customName="累计人均投入工时"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[部门年度累计排名]]></Name>
</TableData>
<CategoryName value="部门简称"/>
<ChartSummaryColumn name="全司累计人均投入工时" function="com.fr.data.util.function.NoneFunction" customName="全司累计人均投入工时"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="fa4a52f3-44fd-4a9b-93e9-45fb28d105a0"/>
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
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<WidgetName name="chart0"/>
<WidgetID widgetID="03443dff-aa65-4db4-a5ee-8ae457cdd728"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<![CDATA[部门疲劳]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="2"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.custom.VanChartCustomPlot">
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
<ConditionAttr name=""/>
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
<Attr position="1" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<OColor colvalue="-1197808"/>
<OColor colvalue="-12080918"/>
<OColor colvalue="-1222640"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<VanChartCustomPlotAttr customStyle="stack_column_line"/>
<CustomPlotList>
<VanChartPlot class="com.fr.plugin.chart.column.VanChartColumnPlot">
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="0" stacked="true" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="30.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="false"/>
</VanChartPlot>
<VanChartPlot class="com.fr.plugin.chart.line.VanChartLinePlot">
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="solid" lineWidth="2.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="AutoMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="1" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
</VanChartPlot>
</CustomPlotList>
</Plot>
<ChartDefinition>
<CustomDefinition>
<DefinitionMapList>
<DefinitionMap key="column">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[Embedded1]]></Name>
</TableData>
<CategoryName value="部门"/>
<ChartSummaryColumn name="疲劳人员" function="com.fr.data.util.function.NoneFunction" customName="疲劳人员"/>
<ChartSummaryColumn name="非疲劳人员" function="com.fr.data.util.function.NoneFunction" customName="非疲劳人员"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[Embedded1]]></Name>
</TableData>
<CategoryName value="部门"/>
<ChartSummaryColumn name="疲劳占比" function="com.fr.data.util.function.NoneFunction" customName="疲劳占比"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="dc65a010-2080-4ccd-980f-291c608ae03f"/>
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
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<BoundsAttr x="22" y="356" width="220" height="164"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="chart0_c_c"/>
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
<WidgetName name="chart0_c_c"/>
<WidgetID widgetID="03443dff-aa65-4db4-a5ee-8ae457cdd728"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<![CDATA[处室饱和度监控]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="2"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.custom.VanChartCustomPlot">
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
<ConditionAttr name=""/>
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
<Attr position="1" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<OColor colvalue="-1197808"/>
<OColor colvalue="-12080918"/>
<OColor colvalue="-1222640"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="true" categoryNum="1"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<VanChartCustomPlotAttr customStyle="stack_column_line"/>
<CustomPlotList>
<VanChartPlot class="com.fr.plugin.chart.column.VanChartColumnPlot">
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${CATEGORY}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${CATEGORY}${SERIES}${VALUE}"/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="0" stacked="true" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="30.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="false"/>
</VanChartPlot>
<VanChartPlot class="com.fr.plugin.chart.line.VanChartLinePlot">
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
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="solid" lineWidth="2.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="AutoMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${CATEGORY}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${CATEGORY}${SERIES}${VALUE}"/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="true" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="1" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
</VanChartPlot>
</CustomPlotList>
</Plot>
<ChartDefinition>
<CustomDefinition>
<DefinitionMapList>
<DefinitionMap key="column">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[处室疲劳]]></Name>
</TableData>
<CategoryName value="处室"/>
<ChartSummaryColumn name="疲劳人数" function="com.fr.data.util.function.NoneFunction" customName="饱和人数"/>
<ChartSummaryColumn name="非疲劳人员" function="com.fr.data.util.function.NoneFunction" customName="正常人数"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[处室疲劳]]></Name>
</TableData>
<CategoryName value="处室"/>
<ChartSummaryColumn name="疲劳占比" function="com.fr.data.util.function.NoneFunction" customName="饱和占比"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="b4f49cec-44ca-44d3-9929-932e6387ca5f"/>
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
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<WidgetName name="chart0"/>
<WidgetID widgetID="03443dff-aa65-4db4-a5ee-8ae457cdd728"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<![CDATA[部门疲劳]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="2"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.custom.VanChartCustomPlot">
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
<ConditionAttr name=""/>
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
<Attr position="1" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<OColor colvalue="-1197808"/>
<OColor colvalue="-12080918"/>
<OColor colvalue="-1222640"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<VanChartCustomPlotAttr customStyle="stack_column_line"/>
<CustomPlotList>
<VanChartPlot class="com.fr.plugin.chart.column.VanChartColumnPlot">
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="0" stacked="true" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="30.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="false"/>
</VanChartPlot>
<VanChartPlot class="com.fr.plugin.chart.line.VanChartLinePlot">
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="solid" lineWidth="2.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="AutoMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="1" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
</VanChartPlot>
</CustomPlotList>
</Plot>
<ChartDefinition>
<CustomDefinition>
<DefinitionMapList>
<DefinitionMap key="column">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[Embedded1]]></Name>
</TableData>
<CategoryName value="部门"/>
<ChartSummaryColumn name="疲劳人员" function="com.fr.data.util.function.NoneFunction" customName="疲劳人员"/>
<ChartSummaryColumn name="非疲劳人员" function="com.fr.data.util.function.NoneFunction" customName="非疲劳人员"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[Embedded1]]></Name>
</TableData>
<CategoryName value="部门"/>
<ChartSummaryColumn name="疲劳占比" function="com.fr.data.util.function.NoneFunction" customName="疲劳占比"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="7f3aa574-1b7d-4627-9987-6501890c0525"/>
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
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<BoundsAttr x="851" y="223" width="283" height="204"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report6"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report6" frozen="false"/>
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
<WidgetName name="report6"/>
<WidgetID widgetID="898778a1-fd0a-4d71-b2c6-290be84e513e"/>
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
<![CDATA[838200,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3467100,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[饱和人员明细]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters>
<Parameter>
<Attributes name="op"/>
<O>
<![CDATA[write]]></O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="600" height="400"/>
<ReportletName extendParameters="true" showPI="true">
<![CDATA[/347732/人员饱和明细.cpt]]></ReportletName>
<Attr>
<DialogAttr class="com.fr.js.ReportletHyperlinkDialogAttr">
<O>
<![CDATA[]]></O>
<Location center="true"/>
</DialogAttr>
</Attr>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
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
<FRFont name="微软雅黑" style="3" size="80" foreground="-1" underline="1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G'=PNUc!B3TL?1UP3*dR%?-G1:3KOLIRO9"S2u]AG<gQ[>I9k>.,nK_IrX7HJ6Wf$:MZDgB
)(]AWG*ZUas>47EdXu36'D?rJ7(,A1"&<3JL'=:ag3@@g?N;<gXEf1_;I?O&KdVAj7uuqlahP
[qoN/:El*uH4oQrR+.ji4-*D[8a6+6A+.o1=]A_FeZPPpcm^Z"4ZqiR5r^-F9QT=g8S'DuLST
Ppo4I-'Ir3H+hYan;(UQMr!_m'jf6+0@QtnUWpm3$!TU,!Q%Q_SbPbVI*T'.t"Cpm?"JgBYl
6.3B3Lcc1og<\ioU1%K93:q)MNr^6\9[aPVIicW?N3%EgaVmI&u_Om,\'g$Q0JKM&Q$pS0ip
=5^SoI,grjroBq,fL[!=ok4;Jdi5G42s1Mf&,aJPhg]AU&h]AGF4qV5Ohf0>Yjp>rUHUMAt54N
*g&9?e>3CIKWH7Wd)XAc6"05=8,rYE'<U'oUu!%;saX^",=+hiP6G]AN&Vh1_co5*a^?j&G99
-+d@b#.,,Cbr7]Ake`Fuuu11(bhcXJ9,AO1TnZ)oGO<76MXZ4#u@`5Wn=s/ne)3VR,QdE8oic
WVoc?#O>1$Mt^p-@65(INkIjI9!3Un`=e7\'0TT1V*(o"W_GO\d"]ANf8B9=Y*<!sdi(.=]A4S
m;5&;]Aeh5n6XY&NF1PH74P/'[1X8Qfkt]AKjf6>H;%a?P/0qGqgh?qqB@h^H1o&?TQ;9?7^$S
ca<^a1jsH:9[4c_p4DcQL3U$cic'H@3*al_?eLjp^.C<Uq1a_tb"/ZX+8b5'cBb<33o7koUG
SO^DUYQMqAe$V#:)g'FD7P,gh,*qHkh9VdfNDEY*NM>3C8@SV]AG\#eBb?)(2[")atHU/`!iF
eJ:O5$7@m3elAr-01;kRj#LB=BA,".jOh]ABgP1CRaKPgSEiuNVnXfmW;S3g5@$ee<BUtcE>A
QG:6itk9ikjl"C)!h:4.*_^_2f.8p,VQK,IU^[TM(L"9ZuT`/\[1`^X*"<J2)2hM/7H`O0s@
AX&Qm&JF=sV?UQ^gtD3?'W;9-c2;Nrdj^"]Ad]Amn(*H_enY_1Bm'[&o@P.6um[]Ak(7A7R_d"#
haECb<(Ht=XZnpJpR#%tZ/JTLoG4-]A"d"\@*5S4g_=\=^$iUCO-,"GBfOE0R-1fk_lksY&o`
'LFbq,J^GA9\42WiU$`5%8oo#n*?]ACtPG8$N9oF1Wj'jaC&!fb*k[gDeu.?B4'So^\&K>ghm
YYOP$GReCT6ge?fRV<;R$CequPpBfk7/S4#.Se8F^IB"`Hi33!j^Dg#<(2Q3#hJp^<%JM<LJ
hG\UHto#&S5GK-j"@#G]A_)F!F1/DdfqSS$T`)Z7HMDU1.oFg+hZ9'Jp+^*^8EssCh;.UG>FO
%Q]A-1pu:]A["UjlB=B1`WtnTBFVahYm-(<eR`XrS<VD2M6Xq.Bf>pY&_;$H7Ug\V<uBF+h;Jh
VKn<<6fe81,.mbb6F,tH//n;fdl.+.PGK0,$9,;W^OO>L`eQM2>q?oqGW)pL_<aN@kP3(SC+
`n$G-KfIp\Lo[CB.%4P?KpS,4bMkD'5AL*'=hR*Gn08ZWqpW7=fNpo3k<YHX*j+Y@SJsSL[1
(GIbtqn[<C'\_a&@HHP&cY9e`tc@KZdPIARdpho3<8EbR=+8E8NZudNGQ/N+]A:Cl>bo'Wf$b
Nkfa@_FG`M#"Tq'ejD>\pjLi\<$`[-'h\ph6Ff.4sOhJApX.1PG*$3+/+i8pGbr&^)moSRWX
u1_g)f@G;\q7K*N&qRWW<1'`!YHd,rUCNODB4ib1RO\p1,LNT5%S"!1AuhM$q_d"@oolVX1r
m>(iCs-#Q2RGE1>)6X2fF<$L20O3G]ALqU-6ao.N7STPdEM"Z8U5H;8sK:K(U!c^:EU*9h3pb
h-E(9r(N."&S#Kkb]A_qt5!F+I/-)8^If,+c,a=-X&N*YnheQ0.;_Z>r5:,C30:J`p$pIRVKo
Idj(PdL6J94'/RNliD>N:`acM\"e*[%;Qe"&&Mn_Ni1=G/9F""L4W=03HXu:`:hHU5**XRY"
>Z)q;Nj6T->$/S[`9KnJgtJN=na!=,@0+5hQ`O8U\'.-@HfAK?8ZhsWM+!l)A5WoORtb4@5'
l[f=a)Ir&#N4=q&<BVaD>[Q!#57i4,=)HPeGEaiuYq\HOf;8"(,:UjX9qd\N7Ea&(.c6:Cm*
<<qBNq98i#"bO#m-DR7U3W7S>TK&F6=iq0RJ['Z5P1$]A7?3RrrK0SV#=#nfBmm0e/=NZ>3s$
20epr[fPV,b`)(h,YAM2+/N&NV')io%Ph_$?gUi,nBWU8A0L(l0,'^t6Do0MJ_2#rKTm0Z9W
-RQg?h:)ju[+[ss#]AT0d3'8lB,Qh$+c)JTIH;73_s-C-\o6,MGM6OFt`(=Pj0MdY?VN%,8jP
i%LhRE%%Tq1`gXY\FR0k%.[[ih@VJW%s'!56EAcIG.;BMS28jAmm!;Z*k(J)VI^*q[.q8@D5
SVB"VRa6.CB..<U5O/\YkA9S3M[1=rHE6>-%,9"tAMUOr<HEL""@H@HZ'rEP+aVHDk!U5Ts\
F0/7m`i0a6C(04FUQ@0d9>-*L_]A0-MN(`HCQq5;p\NnM(RWsFO?I.9o?3\Ua9k`^d)`cnue+
?tN30NG@K([Z"jZX1[O8%arRe<IdXJtP9QrSs>WhSJT&`bqX*[X2ZOD]A\DZR?e<rfA(1cioH
9eT;g6!,;G!q7\s!6<nU1]AMo)o"^P5e8PWnn.;?O^CEYiu0\]Ao:lTD>\H5XRO6\s)FcJrBn,
tPjoP/>TC0kN")O=1t/$/0NZ=R\aj4oBa`PCs%W6]A+Cm'ON&OmEH1&!,KAZVE-3[eS[@SJ4&
40[!t^6D3cBf2P@lP#W-I4Z=V*E<`PNlM0*2HQFu6_NZo,"PPN4tSN&7b,e-qqMQ6Hk0Mq)g
8Cj6\Fb!\OHdoKF0L<Z7kbtqtg.\]Abn?U)aZA5tlSY>f_Aj>eg)ZC$QY4d%["4lE=7?iNJaF
Un4rbH@]A'!RT793'YfO?/Ni&23MaLt[UU.6adcb:W;h?.YE0D:F0$_gE6Na`mlj0dAh,Mj8V
k55]A$hk15,7:0CHAi1ec89V&E(S(P%5'*r5+K4RkAbCKGKcD$2>a8%p_5s@u'.*CC(f"c5kU
tV&fmVSUhWNWA9I2'UDS[5K]A2(Qti10"Pg22;ish>pOB;D-2GGjD[,[k:l$DM$AK0I<P$GQJ
LpnP1Y5iGKPhCWq;G_\6PiGI166LC2SkWZ%DZ?[2OgXo*n&)/LBm?2bcgOWPlbKpgtLC024[
Re\]A)3,4jFU'XkQ\tX_GMRk9:H^#/5Bi5j5"K@I`aiP&rX52iRj*BC(s+N@;7\RV;<m3%IPZ
<e7;QVET#38lTFV)Asc%B#CD*i@H,jSO)8jcc@`ec2[SR<PsFX;^6R)c*f@"TQ<EDmRFU=rX
^j:)f$@Jpl%cTq4#g'`!fLOLnS#hZ+QN#:9S=m*(OSVJs%e3Ik6:1<?2XaNQONCP>&Egi?;?
rXpJNT_U&qmKp<U]AX)qF*0j6Le)ZS!RL@L;*-?5C`*c3^MIg^A$*"&"K"Z":A=(">c.(8okl
WRfC_'n`QlSE=@*H>LjZ8h=K#ug#jZP90m6De]A4"DjKj[r[k*uNP>++?YYd/0\(7I\;8XQKt
i1RCABWuX=#pPq'pG.[bk!B</Vn>anq[tMDX,Y/Q<%Y.*kFibhaC'!Mo>t:>G\q/=U=t@s60
`$#:L;_@nS+S(Lc,\S@?([tP6d%Q9LG,afkb$3$J=S-L2a=d^Sa4U3i_IYDQA*[JO]Anb=U1S
fWp'itHf<2'W2-E:Oe".qN0Q>WST([&]A-Djk4gmcq_Ego()IQ2j*lh"@mO@7r0>4lb$%/;-,
-deT1J^E%JEa\%RY),'T=#IDK+GY'fJ<fUJ0Xak%?)FDO]A]AI'e_Z70XuNWkE[shLQF&[(=N?
>L%@!#A"2t5opJ8grm296(=O#-*,-`c]A-@]AsuMC+8^hsfhOiR_mOW'/%3lEe1rL,>3""+^Hl
4gr<B'9+R_HJOcdBVPkjr%iRa#.X=k@2Kom33EO7"tDDYN?c[D[V$LL@m*7[V\t2j%mroY;0
#6[<Y$OKKCXfHJ$,9M9p)XT`[O<>7t3GY->*(VZA<f8oTF.\-`uI-:+XmE=.s$FHWjK)U#r&
5WbtX`q[oetI.q9HWp"Rq(_>5FADRcIG"\I$-_q]A/Qm7\XlY&.*V*jX.jU)89:7r-%AVYft\
'?=q;M4!Z?k2$mIK7"Ppb5N8Y1"s4I=#S"l7bD)4)468NGiO4^O\/O`r$9tm<'P=-"8p:E1u
tt-7P*X]A`gDe[Ln[JK@r$/_a_8&L)?M5,gA_a/r?i,>6ML\&$;!$M^Z"a(-MdU@b%?4-FN%o
">?Sk+uPDAeQ?.;FiQ?T7td>si9ZVZ%q-@7AqLdlr=6Rd'LiC(4BG]A-U&F;_P?,arr.M'Pb@
'O$_A^paWG"iBIo;hPAYIDuO?h.1Z9o!<LNkQ6`Jbb[n7%nT[tPYd/9;mY`1_rRWfhrFAi?H
GU'rj31KCDT?oU',5&I\I,\pg:@H_dc1*,Emg6!pLXVS>OBNRVU,SbQXeiX[N9]AK@^M&6N_-
V=a2gF[KmGih_+p08LM4G8acNA/(;A"PJ,8qP#8`Y]AN=\&d8(#S\P]A0/F1%&t$[:Z9DgI@ib
bRiA_JO(Vs^5?@Up)^7_PASZAs_XhEucH`74qSHL)m_"EC+cS!Sq;?`Xg[mM?8#t4G?2]AY-p
=4LIUV(d2CP9@gX1?p!;`ghMlPI5_`QX^dYGkMlC@<cb!)^?R@EZhKr8(`gT@&:(1.BD($V=
$u.-'TU'J[kb#=&0mHYgcP73R_C9&T@"lPd5X/@K*#i0\]A)"4`Qa"n#oqU'>"hQUC]ApndEuL
SgK033%Zh5R%;&t!&Ebk+U6\krH)S+`j(qX.lTZL4p<oUJF.WKc;b;'k"gtiW>\srt;4Y%M%
#FPTA@[S(0[uPlA0Spb/^b0oZ*-Kq#I[5Mc.`h5QlQbO_]Ae"C!8i26UC5)9P#\?=8)\0iZXA
8HXRAm7$9?(K8:C6ITrDKU:%aZ1eJdNa<*hk5B:J%m`tZC7`eU@Oc?XASK%?[lKWNu9K$QD\
Am,uYVE#+3EDS:S<o+$\PSu`QXca-1>JMcjCZU`419lP.k`NdpD`eRaM881(aE)Q*bAgqE5+
e,&0V?)D4oMP92Ws;kW2dAjR7O=9pQE]A2</ii9EEl?ojL#_]A6cL;4^RPtb":QtLgA6ISj2F<
2)$s1(UAVkVL@@K#J.MAFdYl4_O8Ru0\,QU~
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
<WidgetName name="report6"/>
<WidgetID widgetID="898778a1-fd0a-4d71-b2c6-290be84e513e"/>
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
<![CDATA[838200,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3467100,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[风险人员明细]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters>
<Parameter>
<Attributes name="op"/>
<O>
<![CDATA[write]]></O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="600" height="400"/>
<ReportletName extendParameters="true" showPI="true">
<![CDATA[/347732/疲劳明细.cpt]]></ReportletName>
<Attr>
<DialogAttr class="com.fr.js.ReportletHyperlinkDialogAttr">
<O>
<![CDATA[]]></O>
<Location center="true"/>
</DialogAttr>
</Attr>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
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
<FRFont name="微软雅黑" style="3" size="80" foreground="-1" underline="1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9=@*;ca`H`bDQ8%^"7OPiul$34(1(GG7NYKU9NX7=@HR'gs!=#36@fdaiUGdOmj8$:G:=A6
_I!@]A;[bB7)D^.Z^6!8P+eAirqe<&frtWR2_tYe)B`%EP]AkkpePc;3G7f!J)@a0\K'?<*O]Aq
$dsN)RRt]Af?f>lUtbX$&]AIXCk#BCVUAOW(OG`b*+=iTo+/O^7gVQP'2A[`mHchA'06AS:(Bf
M0Xu`-HV*8,J*$5Ogk)QT+nPd513.I3+Y2gZH'5(f<_>Qct;0NG2U&Vr/DIKuST!mq[<^d8!
CCk05nPM%Wk.FB4n1gPEC>)u54SM*WM)-2Z&igT.6#.PE\__"IKUZH(:0OS@.!qp&>LTW/`@
8B11c3o,EL;Mr8t-#LliaF-GddH\"F,O_OW?Ka@>fdnY5I,J#r$&/2dck"m&.=W^G'[E+'>Y
NruR`B,*H%2VE7?U@7UutBB!VDa[@km\O*EG5PY)M<XVfpJ-/A0J3E`;eZ<maObjM[Y,'=i<
u=_`FIDdZ;mplR^;dc^3]ADH_P)MRI"%WiFrYPd?1pF-+gq,1de6;'!%fC>_reXKXB)^Ig;`]A
biX%kaFSrj]A"f,.YO4DL.tO/0--S'WUcJ0rOUA$LjVB@E_CI.F_`/X9bU>YI]Adq7Aumi[hnP
mr<&nomP%*U1cqqG,;J[0^8)<p>Bt63a'0U&#0s&)$,og0dDn7HT`fDm8V9:>iZ.u\e-!e.I
U]AdBmIMFA72cN76>8kP@_)/Or7!ir*5Mbs7IA`R\`($G="^dW@\^<!n\a@T1WbM?#4`*";J2
"GJqo,`QGETo`+n(o!a\X)/p:Gqk6UW$F'Wdlu2c:>2llle#/h@Fg+cdU6pH7%NTGV]A&e/4N
oON!QQL6)rro<[ZN:`lep/K-i\LGD]AClcB`nk>u@jP40aM3Chn$Qg]Ag6%d1>>!_u@Q;I90'F
<P#.EmqXlkXt7TH753e\Tc/,OoL7C;nNWJ$+%MnX(&a*AIRqj1cT"%U77066KHI$A9n_;W';
ZX"K<+?4gk$U:.[=;V<P)_b0kCsSH:ZM4!^Gn1A7X%7f@q:=&5^e[P*%QSq]A"ims@h40B8Nj
,)pM-#!j!j3lYR">TF[Shn)PpHuXik^0tA<Ykp"j$fq&B7o(WV8*!Y\3br9DoV/&p8GiAWU_
S/Q=`2:PF/OjOhAc'_(W"-Nh3%;h8AiC1l)[0T)*tpZ>9m<7F7J`o'f>5f=`HrH.dE(F+#0]A
6l2)K5Ehf5=1XgM]Ab0Har;Sr!/\j1j7W;:0b]A(-sS3jjYaI550@YWO(81,9Qlj/S0+0P\S?-
BR1WX&9B#SfO#Q<#t8+M1uFT@GAM1\_+`4jp9W,MDhcs7:Lb0+FkbD;+-N';RMRID*LbZeIW
qA^L1k^h`A0$BGiC/3jS+8B4T)3:44T]A(q4Q6Vh`N@O2*Ga4$MBq(SXnmIqN!ng_^\ur&]A8>
@UOWi1fk1._Zm"ZYHp:I$/l&U>Kl4:ItUV84#C$_T7Of:=PC15O%A\poC=Ok6jo&>+e.&5/@
6iA>>'4"=pb_0dr>[?6MIsTA-/Zq8A[&A,;!V(MYX\s&s0nLgQ&#!")oNbL1R*<<sTWB8Uuf
oh?Hl=)/O@*ie?<&SIi\n0^8\5^cMA>H(7fr77k=K>J[;u2;jG?\)H]A-3<PEDOt!&W8=I'21
<L!I.=iA"jrg*'FqYVM%SiU;mcdkBTQ:[8T;WqCT,Jrme]AVB7b/[7J3lDZT4Q%Bi&*?TlhL@
[@2M=%L_nZK>(tHdu3*tuHW77@M[IO2THAe#$_kOB(3-m@=UVnkYO4L+&<<p9g]AV"aH*+Bu]A
$joQj%9;I!%NPY-'`UecplWZhFJFO/D$rGC#V:XE>e"fGbY4R9L00]A)N'-O;EiNWP9PJif@n
-Agc;MN:La.b4JRE1q+gJVEO4ulZlO]AR)l5pk;N)bO1R45(_"Hl+]A92QH.7:5dmPH0F)Gi\>
8k7[,5X@8ZI-'\+VH!]ATcL[_&X5IHCD<1mFC-IY5pK>SkL38k$d-(KU!e@,Pa#bf*O88kV?h
Z82t$j@?f(]ANNZ^AlM\J!hsl<Yfn[RlXX+R3M.O*J&>7b4C:6J!SD'cG$-c1rHb90'\2+_0/
ouR^)07G.VY$L#T34TUCuY%(JM[U.K6p!U,t5!Gj?1F.fq,B@W)J(mQKE-ZQ2)P0:^nm7?lC
1h%';=oGV5.fh4#5i'8>.'$=:Qg-\Is7f,u1i%U$2Me#e1>"&/E_IDPJ`:OZ\84R%QM+Gi*0
ceVC$5^,Fqp?X@aF1&Q[EHumDl/L`(PG$ZrX7]AKoDE)4m)<kFM)=01]Adj`hD*uE8=WCR6=Z`
+6lM?MMuAmJF^k:n(ld<`XDQSLI!Xag=.=&W=J\Un)f?ROo]A6L)/'TD':J(s?`7,DfaAFoaW
Se,n8KX:3':XUM%[#ndR0hU\`8/X9#Gg!+:s<S:Xsa.]A*uY[O8aCi0qR=MO#i*0h:+WG`&GN
mC2+^lj@dd]Aj*]A$.o4O2RS*@ZTk$:6?'a"!O1LmM$(<#sT=#&K-1hNeX+5u3+3%^,<[!'Cnn
C/t&$'`KW#12X?>SG/-Cf"IErbJue$S,#F"';N:9N0c*>+c45RZkCgB[/t&0"/cIjmV$u^>E
_)ih@iQK1f,IR!n#TY@*>\\Ak3qg^1:W?a[]AH9(:O4?d_?Wm/-<=F;sQ^s*M#WK_RrVR.Hoq
B#SYEr5Y',VKB4?I#O6-Wd!6!)=e75'Nc*#Amm=`u>f*),oZpDK#@Llq9+;e1#3N)`DW;c>-
^eO).\i]A.,MruCa\f[W.EeVo<>Gfb=E^a!9M>gMAXGSJ)LoZca.5!]AcqCTMMK^P*M\H\F!pO
um#+XS01BqAmaq!Fi3;Q@e6T1nCoit7mKe.*6q\K#+al1&JGB8?X82Xd\91+HY<W:C['SsSF
MI%F5RpEXcF88k.l8U#MDpA&1Apd^+Uf9OHf`7FXgc.kI2JEEF@8Q0q^S.A!$;duT7XK1VVT
7fnif'DG!U8`YhJ<k4<a(L]As2N^+c`jLKB0IGZp</WDgmbl!mclNW=)__aBlHJg+cQ+OgrJ2
o-<^$?(C)/`"_5.0ZIKM;B9A;8_n3m6-OVrGQQn2CXs4siAcrkOZNXD/-;hc)5Yk6L6am`">
r@;5pH*<)&k_T1%^lGUZ>&j^Cs-]A6Ah)G,OTqBO;&c=^*:s2E]AMmVNNnCK^$D;,V&KldqP=;
oQM[g7u1.:hqI-F2B`,KqpiIU)%3G?KCc/;pLh"?Dq/CIg,(@QI#Gto!j3t#b90L.__9ZDXF
V2$HYI%j%IXoNjl(!'K1e/72',p-89InD+`pGL'50(^>UUCLr:on08^$`h9HBaqM;4G,Z*Ti
ZfZ;BPWaH41Q(URA/e;\%]A>B7i1K9b)]A#2?CGXNn",'&S@JiHE<nc_+^e/0C3*4Hlrc@5Se.
aP\)?e@qR\(ftPcLm(M(g"I&uU]Acouq1<16aD;d5l]A!C-A"u@D,qi0`iQ2=lMG(C6MS?Q<ek
R,4Qi#ti>HI[T#"`FD$5?nK(pD.u0JHn*#]Ah:"Z]AMr^eV[.>ZRpQ#Ipn5h/FSs:e%=hU?0"0
X49[PK-5?ec:$K<M#RtJSic$HJW\IbTK/8AX#"bkaU)$B%n8HQG$3Oe9&l%%$+2dWtiF0D"T
BU(>H+,NHj)<'1$!p?/TfSk\WKPDi61mChp<FL1$[YJh88iZ3nikfY]A&.I1nn`WMT\")&bjp
pi_jTX5.p_rW.]AWU:c:BGrtl/"`>Tl.LM0=I%\;ij?6.65?,f*\>.=@#R3BCL#@,VG?4+JXK
T_O$E=c%2a>QTN<#:bLj)AS)hi$$I%iC5'LM@*mI-^-#gJi0:!BZFXJfjt"4%-d(,SE,c-G4
jkFFJH/G%h:J[".>.r>9eFnlRW0&K=0;54;]A`$t?`s*38ZnFh>Gos(dCg=PS!m$`CbEc%*$X
\6:[T)ECD_UmJ1OSg<dT,o>l^Ha+5]A@e:0S4`/G:oni4RDDJf+]ABWR=A6h1C5ni+7NQ<i6I)
b)%rS2]A$BHK.S'2@eNIe_2r8O#O./t:d;6l%K2_U&Mh?d%*sbs87a%fLNt6'bTt"arj>*&<)
*1K#i6F1=7O`d?g^kokl-e4f1d$_dDfHD2=p6fosS8*D@9-;h_Ndikm-''W,I^]ADGUFZ`Hfl
dg[2P,1uK<9+`s`P^T#2/-eZ!QXMIRhPFuf>(amGMPpIBX3`t8M[Fc!.Ab%.A[Eksf4Ps[3B
>;6+9D,kTPF=E^r\MGPj@/4<%JG]A:WCORT(]A+5@aV>Z$J)qfKTe:jIfHIC9e:LUf9\`r&*<l
S88B;(sA8R$V(tpQMkW\7rSadX!H8PUdK-hbEKZS/NEc%C2+^&k_o%mLgr*T5Rkk2?e^\-PM
!<~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="1050" y="24" width="88" height="41"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report5"/>
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
<WidgetName name="report5"/>
<WidgetID widgetID="1a3de285-e958-4a55-9332-951b28ec5e4f"/>
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
<![CDATA[952500,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[说  明]]></O>
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
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9FF/;eNP9du-$2!`/!L%TS'Ra&>,7H_cPA,sXL[JI6EH4Apr,CoL-50.DLkR#mhu(>:76et
tt]AVN`=FiBYDV8i^-3Q5SZbRj_SS\YMn)Om?lt6LK2m*NI]A9;mQ*Z@B?9H%t8=Z^\qHhqn6d
YCOQ*9eDtl3T.g&OO,o@jEs_0(p[NNjm,N0e`h,GJ5C($)R9+fap5D2Em^F'\/'%Orm!@c!6
2!aiZBU8;0'l^=JFipcm=c*Yl/SBuqND^Zg&-a+l,U*:_3,$*5Pq,/pVsB12ug_od35(;3fT
0SBUFq6G6I.[f3W3lb)=dc.=?i-,K'(rh<;Iio0LJi+hs4b$:>ELnQBPF,')=)(JT;]AM7Z6D
?!I3^J%298b0pf"]ADo=enN_$JpN84^TVc+6`epXWU92,dgP,5ba(7]A%r5gYQ^[5/$]Aj3T>*5
13mg,)dHrVb%,miO4^+J$BEA>!ZMB(#)rNGXX)j9B'SbcdaCSu>OBf@!/K\\hM=^V_&moEig
2X-$hJ0$A]AtdWg)4kBEZ\L:=!fMs)S.qNOg&k)(HO@?.Sd/<%NERQ*1BoGa;M6f-j6?U9kYq
tljUkp,oN[0ibaE;T;BqNu,=LG2,9c'fo"ZsF0el;cjBT<G^%F`ShQbZ:d/=]A4KNZ8-f+ZJt
siBulC%P1;/#Rs^pS;]ADqKOne;5d<1rk$(YQ<ICI,,5N[-rOVD(aWBHR5eteadl1a6^9/Kh2
>uP21fsEH?m6@]A>Rj1A"-Ko\%K<t`=d=KnefK&RE[N>AFQ,]AAE$D<H#EmN[7>daM.:n@0_jU
dKm$.%$X6mg>l\&hN"#[P)(A,$XnP'NprjrB%PgT_V8jAk<@nMRSZ]Ah9G!r(%EME[NC'OQ)!
XD;dKbTmNZ%B0-m_\D`9JM5ZWPSVst%BTP_q37(YCgbru+7uGhbiFD_mc^sIX)J>Cjre%'I3
6te:LX1$Q#&7YMf9B;"Rk[[#F-]A,ErEi^o#N(b[SS!Lu;fG`&hd2qQ:;[&.<E"5T51*<Knjj
_33d6sX))3p#eRFJA,Yr+rlE8P_j_-9Er)'2m4$Hr$YPb_1XhiFu^2DV$Vn?V%KKj2.S:t06
G8ktsS!i[Wf'2]A&j#NiCHF6ZZ.3]Ad1)Oc^^ZBpU*"'(B4gnj6Lp6b(HHus!n^2'#/"I8[>KE
iIe@jp4s:R]AoZIW9Qmp$A)rJ6h8V_a<(KBmc[D_E!@1Kbg]Aq7<iu%[X6A0&7PBl#]A4/0bb*"
)As?$*`C:%ZYsrlb$JObndB"`s'Q#fV9C41;^>2]AH$L1j7j%58D#NB@7k[JSJdhr<Hga<rh/
l&!n+"("8V=-?LF><Lp*t\cSda$+G69/u2@l6J"Ot//?%./.ZK&%6TNBS8R?gI"@q<t=JKc2
%Fc*l%V48\3O=<?bmN*t=3ikTV3B5MI)bFoH)jQ5;L8EOT!GB)fQ`Oo&HFjBOS-7j,blnh@(
kU4cP]A<t)!CV_ZVFKZdDOad6+R'sln.`Q"3Ws1sCQ1+%&Wk>X%5DWbqDk8uaT>'m<^!ja#ML
l:Q<@NX'A"<Y7aqHBCE`nmQWfM26PURmKM&>h;MrYs/?$dbqZ[*/V8cp'b;5J"6q_+9PW+L7
SS/]AK4*]A<DcjLk&uQ.E-NVhnW\SEgA)1fuG>NBT,`lXmZ&lAG#h@K"BEq\dp:kJ4c.4C[aZ-
Xa,HdOajWoPZ7"rS#@CrE0)Cn?&W6nO[9!nSI6e:@1dNQ<fmX%7hWT#,5qugeZ>S!Njh*pZ,
,q!oIpEL*&bbVS>B^CZ!#o$=X,5?')Gc#lfu/S]A$rPPB%^o#0DC<VmnM=[8C:%*N<!!NOX@K
l_h@Ek42OITain%eMJ6G@.RHjg6QUc(507?%*s/5M,,W!HD_!a]A<$(Tf+s8-^\ZO+<CAMg>2
3J'O(_p7a.qXmBl"N/8l@m3b`:EhX%Abf\"!B=03gE^2J:2-DfqmG!6e>j7:umU?!R2qCW80
,>)\Y\^qnc#WW9cn);Fb&UBh')9-WM'#&+KiS=Z;O%6,pkD66dT$NE1m[E?."`H%$49D9C(f
&2+IY-GMVp<.D*blYui`[]A7l%KbKaVF3N]A:"HmF"?%1S?R09p5!61#RQsKUBG+BaFA79DP.'
i_3,Ui(3ACIP=SB$-ft?8q_0pOsNOE/\3?LSI]A?l**RPUD+R>?+`3!DES3VPiCGeC(PLW<N=
Eb.t(H*(lU.5'>iE#_N(i/0U4%A8d#Lt+o(8VY4>d7,B5U<N9sR&C?rZMWh*r,>2=Or*;NUH
ZGFF;.q-&s(u#3FHDs.P">MjdA::iu"BX]Aa^'[C5\#3nT",Pm[qdX[=Gl/aDb7O$_H=SH+bo
I$]AB1S@GT>8h6h+W@uj<D=g]A^3rQ'/tg'XN^-:u_o)W>o]A'UaJL>p1:.0#+PgqQs</oBK``+
ruW(bYZR"Ne-Y@b0D9VP"e2f_d0/i-se8>0ej['^CX5>)nFIFK&>u_K:<aJZ3AH6gp![Cg;a
?a*`nr\JDhl;ktKU_Q><dT=?N?q=X7:cK]A0/d_T"R&RB_QAn%/7]Af9e1U/m]Am4R@/$LeXNKa
II)D`C0iaTQZY6UkQ@9[_E0lgam6&$5Vrb$Mk8<]A>7mpXj^@U`X#UhWk-(<+Xbu.n-(n0t"A
VO=K%3"-&_2f@N]AeK<8(=PZR"X.^LIaou"$'[q^qd09pb0W\k;L2cSlsWqFI^O;U2Rj3GOo<
r,'g`brhTG29[Qbe95n(jR*&;RYZ?@WLKTO*q?Wn]AeOUUZP<a7XM?Ai1k+^IpeApnYM"FYL4
Sjaj=lYbRSBa_LRBK))6i'aZk&%>%n:.LL@;uBM,6<CZA>`SU+XnO=V8;4n,Q!h1j!aZ."Pg
]AMWV66k]A83t7Km`]A.f7Rrll_&P3BY;35ZU%]Au>]A$q=?aR6;'6)]AdlW1,T=3"n,=p\_NB[T\g
;BlYQ6$fV%-@8.B#7(UOA1Dac251rSXLn:.n0")nQP,++Gh*]AtFrL"ql,6q=(VFkNV5%7:AF
>^R#M'I%P!IXsK`:8cQ7E(`Wm$EhQO.nANEd4">%"r'A=Ok[\ipr.r<7Q_KnXD@3C9ep<S_L
@Rf@u+,_u5M/H@n7k(hQleefbSj\46pGL0)rF2>KpAa`*q4IjP$<+1PDANVIT/u_QEVrS8#q
>H5;T7G)cBPB#/m=/"ai+-SE"s+jL"n7n_ZY#ZpH9Q_AZY&j=DB?%-?ta(;eJ>=pF?LrgpOF
^26]A*n;eXgZU@D8hkLSJP\$BgCt9gE..lsLVU`+g=oXM4@+r@sRS%MF`Q5&gu/Ip28pguTe#
<QPJ7:]At=//)b@<k'Xg%T-$2Y_]ACT7Scm;Fd*9NJi*)^'ko;"!]AF'6l622fB"<4=s1ToR<B0
IRk8lR*l)n?F[@F*QKahH-((@3nuMfqDj#8\Z@W^T<pjAZ_W8>uaOW%9BM5cSIOOp%XL*sTN
5/DRE%VM0I=Bq\_nLF[WJd3MBd,=1-smLNr)W2\nH)[Bg]A(5QK-d%)7khQ$"?Y1/:+5To6>W
QDX_F=3QSnX:.i=GGfKf,B'J#.G?++s4WTXXDX9Q?e3gi0=u2PnQWXp!Y`r5LQ/+lX[Ofm?-
_EW%g`C+]A.6OL]A8iZFW#RODqSIQaIV^Yq^q\_>)TOY^qE(ml@]A&38?%<!0]AL#N[1n8b]ADi#>
g</!ADg?9pG]A3;'@lDV)m!]A&!663)T\NA4[K-$G5Rg8UWRcVuXc:c_Rr3i>Q\*Ed*G]A[B,UP
^?cka#^6M-Gp"&HOJ[=>""pU1Ft,20<aCFr'EQPB!nhWJ#b.T8//MFuC^Lc!M3)Gf-teYEq_
mn??:!hnFKM:\7]AWCmIouWL;d#p=PbcrafO1kN01%4]Abge+[$6Edpctsr#d(1#RUnf&8pW<F
nAF(1JP;siJ]A+-hs4.(jQoq>4R>^a(X"ThBfsUPFbi#7&nelYl/Q>d*LX29"B*#%H<G\T\fd
(S%u:d1WLPT7J=^4L7a0pQ6NUbtOdi/C_9M+t;0X5d6fscR+b77rOlJLY:Kc/*@X3Wr;eHfa
CDs46a$N?:*%85=9p$;#T\.;J'1nNY:Wd+?Z;J\*.gE=ULqb&GWLPFAFZg7e8e6:uFW/e5.W
#"=%))=LW+EsJ31p>VNi#Dj?A]A"mVp13p0NhXaY#aGX=%[0m91^)Y2^$,++A%OB!COZ*mkTq
3"\R;7)U+@(YX5Skr<,cDQh,/YG6a8pY'5^<9GSA+N[*J[Jsb%Ra8PLM/'g2N3A%?q%Q`A\g
irbKDu>TG1j@3l;c\\8r(mH!M,"^<mAV`0h?.ph.WQX7&4e%.Od:WG.BFCtA]AbpYWIu8'#3I
8F*H9cGN*9^.>uM/s'K&L`ofZf6Jl%Q0p_6s$Ed5SR`rVC=Q`[o:FdoM-fa]A$T%jU"#Ak.K"
8;O7F@6[WM-]AjRA80\*b<LW"^1S"ocA$kSkQmTYTN=]ASs/\O96;4ZWS@&OM-)-LEDT3?p[\1
,(%0m4>8!)/po7m"K5`)iu8]A(]A:]ANgmJ)8XU*TI5b1S`-H^"K.+b'"JA]AUK[,i;jW#8QGi3\
6%nYngf'?1t37P<iR)732%&U,'R2IaGri4cbJO`<bS]A<'rZ,E"CM8Akq*b$[,.,CXpdd[$eq
,f:`f:B18SgX0Y"WK^f/VKIdeaWQC[JL!V4\d-Z.!E@YX/pn!3urq[:Y/QQJo1/^apY.t)5%
nIeqqn4$J.[s1OsAbJ0.aCeEXdI8d.HNX-]A<`[biK+O3f0sfY_7hVJIX<iWp'WID)@7/;bt)
!Z;$\iOX='4&3m@."iFn$MSr)!a!W=>LltrR'6as2h^Gh@b@_QQQg5m!c!SSZqb=-58Nl1"P
&tI#jp.l.f;TlH#Y0HeIrG#+j=KplIFY(9LJ'*6RRCcVpee8VeS+lb6b#,`ktqK.fk!di,^=
bMAdVc&[tm"C#hX1'KUsR0SHNtmjDN6M.d\fFJUZ)DUqsk(*P%bS1or6*^1WiVWi.)b#pmGE
4iFO@:2O#,Xau<!]A[JFduQ7TNaqB\Y=+K,gL4;8"LbroZ\,98AJJ0>"UQ*[DOf=<qZ1IOLkS
,S*e.bKWr/O91gnlW!>_47<]AH`gX7Wq*k_=a2<A\e&_s6tiA]A;Z;nJWOFeOsqU-fNcIcU^OF
$k,sBG^2.G?+1->?k)*5WdsuIdh_$rCi./9$S*>t@(2+/oaGRie[>u#a;OM+%K>XdK_G!t55
=TWouZObTABA@rs&~
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
<WidgetID widgetID="1a3de285-e958-4a55-9332-951b28ec5e4f"/>
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
<![CDATA[952500,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[说  明]]></O>
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
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9>!<PLg\Mo2L'?Xf&S)$4,.%MQ'h-MFBgobfP[<=;jEh&:o".UP=h%cq$@P>)Q,u3oZ6!GZ
SCjO%EM(+9[j%9;tbZ8jlU3,V!8Z5QW2BP)s3m&C5+5]Apk.!s%*.I*8Za'TBG(go6\4>]ADp]A
28CO1'He-6XBA1KCdAq\C-Ad+tIe25KPHcWNddZ">Hrd,IN*`r9pD5um`3`q+Y0rU\q.3h^>
>qsp_ti[uTC5@DW`eu:T#lS:LMtKuL2310<Z1]A3H.(Crb+B1+Ff.9<%h2Wr*,T;cUVePNBCr
\*%VN'l#m!S'>[ppWjaJ6DDs`!?>:7h:F(fjmlb9)1?.eB&#G7I$a]AU2P[6Du"j`q3i84Sc*
DW]AqC'Vr-:N=aG5P&q/(`o7Y?_]A'gr[J7&hgZc9h!d3J(bJjM4"r!60m27(a0[$\s7MVOG^L
=eG.I,E\&AsU+q5BH([:jWdknHafOSa7Rh*%^V@_"_4?%.-nV2u^$I'N!]A"KngaXH9QV8g#`
342k++H.(h@hXa't6[jY/_A?^gr=)'b7[X7)$,N4-L0<5YfqB0;b,&]AP\mbsLnh$7_#<B>@q
4.O[cDWULHV?nA<-.TSloU+"jA.t.N)Yar?SGAs:2X1kW80<h7WH2ATKmsaY)<_u.__QU>g'
t_WR@<rbAYkEPMb"<n.TN)Nh9;d7S.eu7c*9J,Fuc2!D$E=96NDr$V\2@1>^C+r+6RaTI)I"
=>;pSVDH'spmAdJeAc))0irp,>D[_71RZr5Ol**Z]An46Y6LrNQSbtq^^=W("22'j</]A,NnZQ
,]AAH'UdNfNDjPpFW:ME)L5ccIHP>"PYof!6$PDf_=%+("hsP;ulf$\Q/5&MTN#mFY&rVMuQH
eceU&m3qF(5'n&=#4#2teb`Qhh$qDdj:.G$LXdP@bE@<[h1*?2NTpYhm#^Rqk*QUgd5q0OH9
p':ep=B]AbdiB4\i;uBgTM(Y6%mUETTTnQIka7*H(ZJq":mcI_g4C\rS7,s"dF#"7Slb;uNbF
9gFErQ5$bAN)?_u_9Ho1V.;+@\!1OF!3fIQtB@?i8c7<$k?UTfM5<X8F!FBmEbBh.u`g',>e
fm_UXdW]A7eHbH@nP9BK&S1=Kgr%!QBR7rEZQKYk5ZFOZDm@Ba&WM;QLb=ik_Lg6L.XU&G;\f
"R6'sg"P7)"i9'9>t)2;]AaQ%!JsnDj"aN&a1&*(YnuG*Jl3<qMK*i7RW@H*um5&TSa3lApt;
dj3HSRaNJj*n%?0L/WDaBZrt;5)*n;"1!3hlg7c\e!EYahhY,-Kn7\9ZR).N<Ia52m]Aka]A/Q
BMLkqK[RQT#Zm*R\V(F8%hVo2:JJ!5Epu)%V1NeJ\6^bC?)T(b6.c2X\/r-8t)ZM896#+Z!3
UkC=<R),'0Zjbe<"qj0.>Bq>iP,mk%%^S*M\O1&-XU2Fi,`Wp#7Y.s5bL[,lWd480=&`m-_.
gNWPt@r(5hqE:M077gB]A"^q&gDu;khU(cq7NOOp&,;LhqBst_/F9jRNL)HnAaf_OD#PG'XpN
b)Rj<5Qm2R0m@f%f(n934@60FAN\O(9&=pTpKn:_Nm>j66VtT85H?E;'u_E'T-Hh5f!HX1L5
qZMPD"rq\$Q:QO92=LSe1Vt%+0;A'\kK&DDjU_jV1Usq#:^ReD*(5M"a./CoH0c89&nh:StD
F0'*hPAYuo'OB4I2SO1^Pa^ocF@g^Xoc^f^Q17R&%FV6bfr:5"Q/tT?/CIF?ZWC\P$RXiSS\
jdU%<V]A^5,_i;Cb&c)?pCX+-,q%R$M>ISkU*o,`H:rjC?,)?;-nd)tub!6t'\3Pt\@cdj>j^
f[FG/gc8Ir9sM;l-2^3Im6oCm:Z'+n2[rH>QE)PlL<frEHmW<?`:,?D-Kh7sL(pj"R8@D2@N
GM<<RfVll^`54h]A622Gn!JPpimVU//5P?WiBA>&"ubsL*K7_EJbJJ!q6r#+pbR^>FQKm!nb2
e$MrT[4/di.R^^ANd"g-Zjso`q/+jW`C@I`3lA&1l`5]A-IV)3`J"mfu-Q8,j3EH<rH2mL-gU
;3m-.MiGJjqV87:db,1)fV$+os,qq=N>$(2KE8L=0DYE6soDjjEf:0-]Aq9CJd8q:7Y`mPmTs
LU6\)8@63YV:VZcn%Oi%PlCE^Z;(t.S4+6EmCGbT]A1HuZ_`Q8S91qoOKiH<08uEh4XFp#IQ"
D)VC55hjt<YefCm)S"YUDR7d,P`[h.\D!,\@UaDPni0?lGdRG=!oaVRQmS;XG_8HZ67jKbpK
E2a#)AHT,W$#_N"Y<J$2e<PGStu7/B>$\Pts-Hqe6V5PEmdh[X,ai"G;8mOk%o8"K'JSng<(
9\tN=:=lc&O1:Zsa\_>7]A=O\TMY?6Nup!eUc?l@=+@TO?kU,ABAA2E<>6pte5g;i=KPfR1f!
X8`Khs1_#!('8]AJC<B^/ncN+M89eam?;\O;.cff3nT9^#@hnm)?d@tU_<n98*gA5Q[s]A36<=
uEDs=AN'lA4HMp)P0PQZ9t#hQ_C8[h#@"DM_d`75bFKO\f[bnh;%pANIU8V;-t8kg=E$;HhA
:3Fhi9h&]AQc3P>U>A>pr"-ZNq:3$>d$nC4G#$>VEgeKLZ+OCs'.[.g_h\+X2'@P>ojefnGE<
o&4bmYH^A*@S\_uX-[Uq0rSeLS&:^sHI9l]ANC,EfVnQf&FXQ&/uPEm=?>uHf"mkTf*rmI\tY
QZ!@>A4(d4nF0%6,LW!d2QkhglW[lO$KRjriOPZm`+AlgPH2&R',%Yo3<i986AHSOV'I9u0@
h!CY;'hDeQrh)cP<he201KJes'l3DEp*lERCNMF'HcVE(%YLP5S0Ng7f/iRU7?V$@LWF<DLS
@+Y.'A[,g.$cXgI=b?Rt<LH>24s`ih4A"bSPP?EtL5(m+Ap"\D=>oMCB[2JAWJOH,k^-SY`7
Y!4iH8;'g[8bO$?o>Bt(kD`NWn^-jWiq8k-F#NMFgH@5E7"RGmXPJ=LU-B3\jqs'=2Zd#S5:
)s=^I:DT$#7hlaQ`IVi;J%sWB8M)L'4,+h0\]Ab[X#F$rT^ps@uO_0X92YU4ODnA1,=+N9BKq
ZoKX'8frXYYRV_Lrph9a#6[D(g'07c+m"GE_<7<(oE\h,Y=A4Q`NO?r'KMZ'J6B%ndnlA:'!
@hc<&s?[0>aL_emqPA#-XiLQgal;!PpAq<TKGMiP._$&)TB2h5;6=KC\P0Vk!0e8Q54H*R3V
1:EnP;C3nRU_G1".2iO,I,NLFJg`SG_rm?P]ADa+FN!:_tOfWGRGZ$gg:93E[.>h;+\'$UcDN
B!!m0@dE;:bgbI1Cpp7SWW&ct&6Q9k7I8`Ck']Aq.Xp#ga0YC^VGS]AMOrXUV1T,u**ogU6hW8
t>%!3(2WSJp_+;)_HG!S.^[@s!\uIh<#]A0M<)dPHNh'"An2kS_BI;%3bl9FD;&9e_.-F(;]As
0MAQPH@((lFmUMQ7b.3=]Ad+).[/Ut8F.Y:orC839]AD:X"]AV]A6_6$n"Ztra-ugH/s;F`m<88+
<e&O<(?_%At4kk\f[14ND9+"*+p>VBHZHmR-cjCi9]A?+P4#]AFO%fU80+p-1WRZ5\P=H$U\=@
^b*GA5FQuUJ/@S*Y,Y1'!d?oh^/Ff,[28-Rn)'CufT2Y?3NkA.fK*ok@Nk6^7!UpkELf=oo,
afYG*8R.-:-I)T!2-\R2AZqft3Hd828>K1o!C]A;r]AR]A%Drt2()#WXq4=0foQV6G7qPnC4n6X
k/Q+GP6BKcr<@9)@rK&d:khCk9R3=-N$$(4^_P.&V>u^Xr3FI#g:F$d!_L?%&-CGj["V!^/\
&cILcI!iA'HX=^P_,*5H:_*bmb#3_6fZ80nZ%e0E&Z:nP<J2Nn1Oi`eULJE2;)u/d1*`jF)8
X,LJ!i$+&Gu*9LkKI)'\-=X:,\Y'9TQ@%J.*V)iCE;I\^i*5c`O0'a@Y1UL58optC`d^YL#q
5'>!0'Srahl-%tF"LcaDsS7G`cigV[Eo+!r;fe9G(2F(Q[QP/u\1N[I+j&Vc6M*O?cP[=5(?
PfNjdp^RhY!_MQ[C8hoF6fq(O+'pY2^4Dg^Q.mj8>g6h6X]A?/bX3I*EkPdN^'G6;\W&9V@"C
RoY>j$aHqQ,egO9D@kSp4EHZo2&sl]Af<f^DuU^;_SU&$Oh\2n-OY\W>&5MQ+f[F"@*J8R&1#
%!fCeAq$>,E)3sAo+W3rk?IluoVDfQg2X0rh4h]A>/+*k)"ag%,7e^&Q((4TkPN"Vh1ougS[_
lZQ@[k8h:]A9V9G1L"tX/N@eXH&A)/7?.Zukrs,\*C@,_GaL(ZCN*MGrM[`a9Xc^UDJ>n7\qO
!c<sL@n/W<S%3s<kg5-0283.,$;<?+H'"ZI.u1bDheH#:h2<.'+$"r3e51L`nlXt+#lmKFG9
$BdBFh+!ZN^O+Z24]Ar(($+)_7gV36*[G>!Y]Aasg@q8[]ARbQ%)2-iX2~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="12" y="580" width="62" height="42"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report4"/>
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
<WidgetName name="report4"/>
<WidgetID widgetID="58f636cb-5108-401a-ba95-89ba53418dd3"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
</InnerWidget>
<BoundsAttr x="0" y="0" width="250" height="150"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report4"/>
<WidgetID widgetID="58f636cb-5108-401a-ba95-89ba53418dd3"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<BoundsAttr x="10" y="548" width="65" height="86"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<Listener event="afterinit">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[setTimeout(function() {
var a = 'report2'; //获取对应报表块名称
var b = a.toUpperCase(); //防止大小写出现误差，此处自动将名称转成大写
var wid = ($("div[widgetname='" + b + "']A").width() - 17) + 'px'; //获取报表块宽度
$("div[widgetname='" + b + "']A").css('width', wid); //重置报表块宽度
var height = ($("div[widgetname='" + b + "']A").height() - 16) + 'px'; //获取报表块高度
$("div[widgetname='" + b + "']A").css('height', height); //重置报表块高度
}, 100);]]></Content>
</JavaScript>
</Listener>
<WidgetName name="report2"/>
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
<WidgetName name="report2"/>
<WidgetID widgetID="b6dd3547-5779-4029-824e-6818c533d715"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<![CDATA[1310640,1005840,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[579120,4686300,2895600,2895600,3108960,487680,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="4" s="1">
<O>
<![CDATA[岗位饱和度监控]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" s="2">
<O>
<![CDATA[岗位名称]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" s="2">
<O>
<![CDATA[饱和人数]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="2">
<O>
<![CDATA[正常人数]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" s="2">
<O>
<![CDATA[饱和占比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="3">
<O t="DSColumn">
<Attributes dsName="岗位疲劳" columnName="岗位"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="2" s="3">
<O t="DSColumn">
<Attributes dsName="岗位疲劳" columnName="疲劳人数"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="2" s="3">
<O t="DSColumn">
<Attributes dsName="岗位疲劳" columnName="非疲劳人员"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Result>
<![CDATA[$$$]]></Result>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="岗位疲劳" columnName="疲劳占比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="2" s="0">
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
<WorkSheetAttr/>
</FormElementCase>
<StyleList>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="88" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border>
<Top style="1" color="-15378278"/>
<Bottom style="1" color="-15378278"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border>
<Top style="1" color="-15378278"/>
<Bottom style="1" color="-15378278"/>
</Border>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<f4F;ch\^X`*NI;.c[M\<9Va>"<,&V2/qZ>Dm[#MU]A"h/5`BC71";H=`.HE9Ees1%B(hW=:
,`g,"o_)gffr`R^-VZOt01]A/4gs-\Kj,Ur@WNc>?`i@qg@:>AifYKc_!,YS=K2@kPm[Es)T7
WI-6NlMk=;Fm",BK(B=&u\)1Doi$jEb$PmX[h:($Vq0U+#&_QR,rqc>X`8o\[8U9r`UUA']A6
0]Ahflegru8lkBOqS=V/o<I&r4Fd+Ic^m/mo"P&uS63<Xk"dm2DgF>4eX-<Ao>S,ps7Q2q:Yu
WXnC0m^&&,!rI1[e<o\SK%3[LAd(^pW,#f`J1[A-&HZaNnI*%.G!:.m:i.K!_2lSk]AC\VL_Q
!Ce2@F8RHY\P,q[cWfYuSe-=Zs+f>"nXJX\gG6&tJN`ciW#dW[V&@"$B+O-B:_3hT';OS.*T
UT+3+h^,PP,/"CcN*^:l50'4J9-j]AK#ZLrLa)!Ui54HoaT)+bqG^]AQ#.3N`%CfH(Lk:!=Uc1
67D=[jDR*jHX\*C"pr0/;_flbq<:#+QNAQmRZ;<,d(AE*i+R)M'EI.8ADo9`+Nd/\^.)..h[
]A@\[#qt`L;jBJa<gSq&Y>i%2[0u'@.U/38+I4OsB.')GY%J,"qtbX4LcVK>1R*Po>UfIp>/r
ap^+oJ!fDL1rf*$J1<obG%B)/^?]A]AFsVU=f6\7:3ofXRU4AVp\X>Kb[LrCGfP;LPE16ebWj`
KP!qOr0ZbqD.I`GY4AA[^AMmKR1ddDC&o;/c9G71I5fKjCHll3;&84Ai[9gk3iE-W`jjWR60
`.dN5=]A.Ih<:h@@,!jG3t!>#$5)tEbK_?:<1omP5Wjui%&/]A7gA0=W&`R#Q[39,I^2!)^839
%?57+r2<b^JLBDib%f;b'ncWk,*_>pge_3tmOCm+h5N-l9_E2!KA*0,Ip7XdP2#'Zth;9;_*
Xn^MJQ!<GYM=/M4C'-Jk9fnPe!AQpOQKfrlu0E$R[?;CV9pb*o5?YO3B;?;ZG_k+#6R(6r6u
[F`L&OJZB=2P?)f?Zc:-Gl&-nt^<;k\UM/>+gk7h[F?cpO'J#UAXb@c:Z-p9R@1(*It5B^j@
bJ<hOm8DK0#LGNpf>aaIBr;#;LR-Coi2LgP%3eCfnV_d+ZubbG(Y".0imTC+U.\8C`=ji4@H
l`544icqOp]A!Q77EK[bqCiS$1gu1*R&--a3L9KJ%o9QP&[31[]A%r.)4m5g%dBYeI99McmQa&
)j;Tu>j!0%r?e!J)Ip<S)0-cMXY-p?a7/JZFWcJ#.#4i:#)an1agVXL6Fjk(nOb_=<Z_1;pm
*3RB2$IuWMVgq:2M@(sc=!dZoq_NLC9$uO,KAs.l@uYg:L*lq:YTu;?DN]A&I_7744u4XJG]Ag
@j7QKBJnX?*J7QMI=h`&4V,^fViI>_=a)'(=fJj^</CSt1ah^*["qX,o[0lNdf[I):TX6BHf
CMDP?5=hCU',Uq7@('/p$Qa*t/V.7g7Z;Y?rIh)l`NMeefG*0M>V@bu+5'A)Hh3S+4<Ip;cu
E[^;#3KM%iF5G_?2n94V26U0R(T,Fc\Ur6c65!oR">uHa1a2Kl-*SUHdIkRU=HQOd`NcH45h
Z-@/gZ^?;imc<l;1ITK<2a6\o"57VD9WLP152(Wehr@NK2Hm8q<a`3qU!MZb`I(ac7_jO/l_
%)V*Wpu(_?c>k@\?@FpSO.?V!%c>;8'AlM&I5EnRW2k#JR/]AQoHT>F!ii`G_)tP'Uh_qM,)@
DhO50YT@XRk[`_8X,g&RLpJtV8",D`j0">\^9fVV]A49$iXt=[I9<Bjr?>'0Hpl'<iXl5t3HJ
9,Js8Jr]A5(=.91`Ar:C["GTr;8X5-od(UVn,_g]ABAKoLE1t=-8)opo/%H/RZH$K1saOj@8Hm
nTe,JVA);LO,-d!,6b#S:CYqAUX"A8YAGS?K>S[OI^NQ=T)65H4#P/g;`L2Om-rdV6?)Gr`L
$@&gGQ.Jk[-M>u\eYtW4a&CAO>\g\W5;;s)6;rs-lkhD+-\?)mbgKePrVR]Au01TdX!-N(+<J
Q-2n1j<PX#\n\51H?1]AhtDg\RHA0*Q4#b%)Ma?K`-LasCNYTSR[r=4-l[ERUcc25S.e:i<X1
ET3N8kPiCJ385\S?8"T"T&N>'N0!]Ai0<!mK]ASk()sng'$/H-=/6-eGCaa%4u[B!4802dUuN(
GBaN:m-j.GPC3H'&Guhhb+^0,eH2phDm)Rr*Pm;//oYXF0?K6n$f#YrQ]AT9t0$G>VLYh,-Hd
e;0.KJ.@]A<CSfidCF`R.,<*e,0L<EV70n^WNKRjk+!)bU]AuDC#FPX<RIEd)oi9?(D/fkTJW2
ci+`Ks\o0mdr"T:UXc[CiGrF`0l&ugH/pB5dmtb&!_<O4L;Ej[b49aJMeSO>0m8I(+dY[Z?;
>LtXj.FG<W2'&#W&oq83JK>d/e7602>UX?/&hJ":FDF3$Pl/7k$e(:E`b*HR/r\M.EdnalP_
PWDS#9`g3^T\J8*k_`CB]AGijrs`nP4'iJ#L/Nbg]A>LnO:8^Z[)$&1rDTbp,CqZ!E<PA60!Sp
MssMp64E^PCtqOq%T;^\`;GLr]AsZt]A&7QJN(\ZVuPF==1!kF,m`GE-2i>O*V$r,?Y6*KQT^$
'_N6=6.4Q\ha^;bpHIg6B9;^K$pRg\=]At]A"HI87@4mE5!al?OQ7?G68qOuh*!l[@63j"Ch)!
,G7dE<<6f^C!,$^CCS-E<H,>6</ACqW":@&&r(nJAJbk\I`$_"d%N[e^6^gXXI%o02h3*59l
rIM8a!=G_Zk3o[]ARQ([\D,^*H?Sq"[VQ)YrLQ9CfhhDq\(H$sPNDccT#n)diMrBk$!Kr+i[>
&Gk"Z"U,aAM^OL*M.f.F)Wn4N\>6FJ:>s%2nZ?ZN>E;$#18_t;>D9leueWSked!qg5^.^l.A
GM'NB'eR^JKY/RhXZ!ZV@qoVaGdAjIe+0\H*?BllR&ZahF6[:Z4YkMeTItqW;iN;WD_d1Vq8
okL1GF,DG`,eE6fNX&THGlE<sG61N4)Ej(\Hq',t2$XN(%6`[F47"2tp*)o#N;,MaV@s[rNX
GbHmk824Hk+Gj*'K]AV>LgUL+@(C[*GC`asRWpf36f5/8k9_qu[8_HocR=)3!#?Vm"BgNJ.Jm
&OGt$Dj:OYn;cP/+$H`T5(V2'VEt)rnR,(/I;4sAuY#HLnec;0BRn*9f7"_p:MSh\Z!^^&n]A
*+JX`KBg=Kn)j9SK#XtR*l%$^Ms$l#WZg$nM)""1pkD$+_cbIuA7.("[k?:1FNUru6*Gta`p
*TGu%e=UD(lqteiX1YKl?+Y>lp'QAJpUj%+)kKfAI[D?m`abU>^3aMIbrf.lW<8]An'",%B4l
snj@bC+QaN$[N@O_15^_(9Tg!WO5AiPLQB(V"UYAcsZ.YQBM2>Kg29`sFSnCk#L!7jq[bQe$
j>tm6Q@=jSAI1E&nq?(Dk7^jIt?4r5IhIf93rL&P-B:Wp"'D!n253h2/ecnXJVOqTEIg&V*-
sZq3;O:gh=fFD]AoJ-H-KM\Z?<r+#Tmk1hq6NOUna8:61D(bb0`H67!B!$S:(b/3pH3"Y^M)R
pF`foA@37(S?+^[/[GM\=c]A-Jr^ldg#%Wo[YT7aGRrQ,TeGAIsj-:u?aK)GU-8VR$AmI@QmV
Ch2J+adGoNL'4J'f86u"&_FCe[9:4,PTil32n90bG'f38m[LVBD49rD0s.Flp?^M`^peG*)F
D:_EoQRm4=3/hIG'-i257Zia+E>aLoMDl`+e)iVg0VAaOpU>5+``1DNEkMigRFcioJjF*R68
O!dnXOS5%+_Bo^XOka]Aamc+3KW2L,&JZmHRp+XE1NWc,%fd55s,D5*->^/cl-<'e(:@PUF9>
-]A388)"/K*i1>^1s>D$>t\>;XOD,$l-s6D>#W+jOZ]ALBEdT^mGMP4Z[4N]AFHKD.IUt(3#Bn8
=#-Q=;H:r;%+L%h_.8T?ZMHC4=?N?"EM*=?D:1]A'a^fa$hDO4V5r#Iii^Tp(Gc5qCTBhP.;8
7W7aB*Qq]AO*p+':[Ob1F0baaI<,ugJm]A8tZr+F9[N!%?k7&fe+lr&0A)/9n=e>oe$UAq;6*k
O&JfTS`@\mD%AY"Nr9OC-MeFRa(:83HquRr3=gAc7iJ]A_;"q$&::"!6a0SKX2R>7G(R[MB:4
iko5_>-$e99!IF1]A;OqY:.8tZl>%b:rftg/7?c4):._N91+-_O%GOmJGiJ2UR3/aVQ!Rrh_O
%_h#:($UA`#LTP#=Yt`<;/*$j*rIRCS^"*Q]Aa7'BAE''A!8ZT)3.C2SJq3J$[8/87b3b#e^A
4:lD/qUMKZL.D]AI!KnOEu:l"_X*DTV"<8>AeG7hY%0H'p_BHR]AsB>P5kGjBf`#k8dM\\`,,G
"l_X>@*^BNmbRAV2`rY-T>t&)RaB%R#6*mLLmk7Bc/VAk,hD=Z?YT&10'3[;B<Ds?Bo?2V6H
GGJ54fRnl:I<gU+g'Ue-ZtN$P+N^Kg9U)J^#T@LF]A^Ad-?6^+7.nrLa3/h.u:d@oX0Ve,>Jc
-ht[0PFfbpWH6a!4rIn1,BcdKZkP,(Ip@;;D-[fmsQ/g`FQE._TaM.#_3m_;-l1R.J]ANq5"1
!('A<7'Cjks&q*oPSh'J'P&TRO8oHaq;Z9')`TD2')@grY)$plF\/dfHTVjZMeks[!T_3nCD
dmV\\5fV/eYG#JeIRpB&c\oLbF8OM\ZiMHV<EBf(tmA*ujP+he0JPo?F'H0H3RRpg'gj\H(j
P[lcta_MW*$qjR.%je=2Jh(Inp9pd&Y?W$4FgaFY*mN,poF7_t4[5ejRH:@O^aNWU._&1EJC
8.&95DBF#2.).MZ*e3C41BpI[`1ZFSs>VUuSVD,1K:?K/lerFQD>*T>2b4!sk9#46F$V3hGT
hRsDG\]Al%>==%ao]A@k"I>CHVO.G4_+;'fL4pi*aa9T-c,(Vh+$dE^cMc"`jRmeI#a]A]AqX)1(
[pRL&`f)*c5jE6;A\2/:Bo.A-lO`#hRM<!)6ak/TZOZSZ13bfb`u'`',/uB/)u,ZFj8n9R$M
[F5CI(>pk%bS4dgb9%LFT]A=?je/C@rf0c,S-m@\?2ohhZenJOol5O?*k4.>qQM2!HjZa`4j_
UN2.Zq@mbU%KR\aWsD6S:l@e`<%=0DLca+i2fJdb>RjpT^Ck*koE['QTGNG&Xd<2qh:UM9\g
*R%#n/C)\>n/ch7'E"Cf*8UaV.0H=Xk?+R@1FIA?ol/M-Og?TnZYd&e<%jkifhRhRTTg'N)H
:qYF6t>sHIlJnA`$AWBHR84gtR+b1!d[48/G^]ArH=[<37&A5Q"ANGBi\K]ATr"Q/7P0rlhqtO
E)c85iY]AV)TVds/]A&P[3m\^&r#Z>q4EN!El<)D%;_H+lEH,WDs4J's67(I17d8iTpbS#[RHB
PO#Sec,69K!-Zl9WDW/F:T)(Yib^k?tnA&a]A?_a>oqK]AC8_*>bAZ*AA'r?2t[e;'dO)bt[-s
3I?a%Zd9HCqPb,E8Fr*p@&k#&3T/8dk<QJA:e]AK.VW-,\3/P,o-!TPt#js$/Zf_[5:M=JmKC
*_[NaHB=J.uN=ZM1$#5.g<1k9@WucSB+RI^A:Y+uLsS[DL[dW3aa&ZPH8U"*`b$%=NZSrTbq
'^(l&nYoE5+0pJ=N1BbJ]Ar7^>V?d;%3WkO@)KkjjbI+IthX95h#]Abo/;#3h;gZB=CnFJTX(d
.rj7)@BJsD3?7W"eG-;qtSAXZl)t)!4kFq+_Z[!1*G?Q?+.'A\$?k7o9G;IEf5_EkE&l`6t[
H[Qt?FQ,s_L3^FdX+3TImsC*VGr@r@9bXc]A$j27+*.EJ^550pR3CH2BI1KVYqqCYO;lgtVYt
,W_B"=4DkDNi!APkGN8k:EY,]Afit>jr\j:H[*[?hPo6Pm0/YG3>hNZ9T"WWj-q#fQJrn[4W_
cLgA!aZrUCQ^%*k^LB,eK,#OQ;6:7H(b$nO1-m0fQ]ARcKZYEMu.uP0_7$L!M`l6I\F:cirp.
B(@X[]A#Pjnqq94"dQJ?JN5@YlpK]AjEN:B$hiri;,D[<MD/lqMT8*K,U=Meo##q/U_#XHK.=k
\3hqcX,M3M]AT1WC-Sg-$./+EA#0BA0PG.]A*>Q^r]ADXUV]A)0rVU\'D+l(YDKp9o,o".bn8G/*
/Rpa82Mql74mI05=fduotc++0YG-$$PD105c)^FJd[0No%NQY+UsZ<V#$El':[<Pm#c#VM(t
c_iXGbflpJC:u:lf\'DqWAr$'#gE(daC7Zc*FRVBl$ddH6@!b,0(l#`%4DZ\mWWtIC&\\(PG
-h,b[d@8=S#q\d^NJuetg)]AA53ODE0sJg3lDO*UfJFV;*SP's1XNcc%L._<b\n#1DlY^%8]At
s0:>`++2c0t`4+:75HrGVO"`ku6:G4N,:O`6J^MOM<1E.r<hK.kmjf%s9]A-FLl]AZJTjiM$k^
Tt@6%e6l:"UB6_L(Kc3bBjEAlNV0.nWOJ=T"tJN9_h?e5cCiZ.q&MQf82rh_?o[4+iMjQ5Ej
F_*<2b;bB-1MbZM'$nn-*5fp$-Cd!)9oDsC$=:Cj5&YN@o!4P;A6K:n!G\lDXQ[l)71nl![1
<ZqTVE]AM=,;3Qof]A+;<L0/No"i-gTi(q0lX`*$U6=A"/C9C^6&.M-\Q9Hlj$W5V@pO'bnl2`
%_B-`m\a#44*Cj_bR&8PQYg,!U/[5+XWZ]A8q'1\A,Mgm)]AR,C1^6,;Vf;5ac%=s_qpSD0".i
Fq#d3i?P)t&2a.G"dfMc+nbs@N*V+4JP>2#^"8j0fA?eW;mOj'73[j;_@9*\L*#N"]AVJB`Qm
:9>!Qr-'E"&I/2jqiu;NX)0jOP98CSBD'$r3P1lok*ghUWO9hk9=K)InX^7:9u1C*]Aoici1L
^1AY=M((BCRM(WaVZc0,\F.Q`h".KTO/ZL^V!DS+9oP9AAc/#nYl5FQH0&r'[gGC'Ltit34F
YG1FHnXn*O#a8CFe92Ui2l#?+W.m=Mp]AkqGA:B!EqB?h>j_BdY/Gj2RpbjR8?c$>V5=lGR9p
fUo?Yf7W>aS?-rN-?j[VlE0GGM;B8Dm5l4m7-]AnN4XagRo1G:?_^I7PiW)'rYsL]AfP-fNOOL
_G4rG>f9MWNj:t9Pl10]A@MNf(l9>;QO9Z$MY+fk;';oB^H=P4\e1_W:2`5'pMDk6j-bW6@)\
JcMU<W#_eV(NFqest;*IT"T:0c*EbR<+e!<T)[GBOu.L$]A<)l>%b::Z9\e[KVYsX<72qi.o<
]AR<HeTk%nZV[/e0'T@p:'1hjp(a6nhr%[qokE3b'W`Th&(,ilk`ISG8_,Pj4]A=A<TfO;N\:]A
NMuRsq.H8Xm;NJ8AhEOf^(p(VQ8u;`<8Nc@eVU/tB&<*7nrt7k#Grtu>6dhZ;>N'cMJ.QbQ(
a)2PgATL@hTEJ4RYb/(o>(X+/TBr_V<<u)IRU)-3#m5*TQ9?Gi^d#$>1$hOYg8XFum^d+VXN
?kqP!RPYjgt`%<Hc#>iW94W8Xfhc,Q9#+Zadm!<Xg1<(o/k#(2b[5R`6+_UNpaGgfM5b1H!G
PJ6ob1s0tV*c7*r^&;="XMPMn`qU,5bp"0Ob;OsLa^lokEC_qL:F82Cp]AXt5ZMR."(?Plr;k
DY8:pT4_!B_+Af[!A53\HWA4YR\j;\<6%@FTS:\s!_iSW4OIcetShC:NDoUcI,L03Qu1m[Fj
^mSNFT/2@h)_d'PI=UJr:R=@6W)_G4rg$H$ZDZbKk7jgdZTp`(3G=%8FlA_D%.qcZ7+7sZ.h
bFde9mtcmsV#6*CQHT$..:o4t@_/d]A1s+=(&1WLFj(m.6lC_menJ25%$S(/`ZFI0EXFA(&hJ
">,[XD?I9a:VJoWp!'Vh_Fo%-Qq]Ao^q9:UXuf30_n\G0l!H:0frEpkqo9l&H6%dh+n4,?d4[
Ad`-?m<>YKIJ/4P^#qc[I#-';-P"*1Hfj4rIJ75jNp@_*dp^$GADG:<ui1U>\PrAKV7ic3nZ
mViO&e)V"Eg<CLF3K?_Z3FB8/R5JioCb&*NrDH/`Us0i$uZH*ND874Z:&8W>1ATVr?7]A0>0I
KQ5qqM(:&\Ft:K6;?CUL]Ai)(92gMW5-s\MhPq/gA)]AY-NR%'H6FbtjW:@j!lOMhOE66n^@/5
Q2O2r4/dbJ6Z[Jl>b;BVulV@uZs*ZB]ATI9a]A-tpGCHiE'*-/W_uB[p6CJcDBO\U4(D5plRXB
HjKY(G/^5fg_8AA&#]A63mbSD(&KYrhi;=Bkc@ODfjW+IrK29Z$bedQ/W#)]A@]Ahi[NDO-jROS
7uLZ[gWQ0*JKnVgQumQnjp;&O<H/4K[!II+cFsYT1.&i.,4hN3u6gW'!D'B*QAcViMDOITXG
t\\3R9f-oE0T_%oJ\^nCc,L'R<gEeU\J8fmE[!-AIZA4.?LU'Mor1T@^iU,.",;X6qjm3CNt
C(ane!?SX5Csn>gE%Br*8A]AtC/rpM3!+2.)TnZ&TY,e$$DnqX@TP2uK4AEK!h_p?7n,E;=7]A
e>a]A8`,72]A;o>$\lZ.huom8M7PR^hqj[k`AOm"D3C^^%'"Q:i,))[!)cB98mq8"O)pQ%IHDM
L-@_\rFfL$Wd@(Uu2`Jiam9!WaENO%]AF8`AHM[Cjb^`t-*W5<5#.]AX[*2:qAVq9ognF0^eK`
N*=Afa,rLC(-9=2K4j*oR&EA-^ia,2muK($XB8>eU#a?_@kWo\6u&ZKrV41O+J/l1">OULa8
t<1uUWhgcJR#gD]AP,#Y!#Zo+s8T(s')X8X+dJTrG?cJX7^++p`/!?'TT99#7BAYHPGMMLg@I
6;tT(5)<gI2$m9A(+dLh^PSR"8j_!P@L9g;Hd1QS-hkFf'k.P@E[b)[ju3^D$i;ErMS7i'b)
5FBE^m`0HZSq?o]ArJ`(/]A'32bI(hU#K8*+7/<"MO*9/3l>T![Vj?\T4B0<n5t1tqE8@(Y?iR
A/59a>n?UY_W_PfeC!]AkUgEccKTrsWZ:t)nVQ`Ehi+D_B+(ktdWeh9sI1/0?&fK_\9M)-Km.
6dr/'uXra1N<("RG,@k84.2#J-s/jhKtj#qOpA+5qXP&P-8Vb=,+;>q++LinF9bj9$'Zp1st
=#S>^;2@MkdiaZls8Y,e2kTGPXig#9;MX!h)cRk>t?Y>6sUof&;`a3]A5HE2'[g=F`SD+!$A0
A#;b)!ebbbeJ7uETmCS)R^fnW[bBjF[4\JOE5S%q;jS%pd=:gdC(m0#,1j.3bcH\5N0X1CNs
H?Je]A%FsQ$+_/5"Fpk*?DX2F2mn+(6YPfFMVEk@O9<"FYH(Qh_6]Apc\k:AK:elGUK0U7R9u#
:h-X)o;_DX$lG!4;>[q=IpNg91#S+*?qB:?m59rF.jl?ZLL,Uc%B]A'7]A6N2/:4FR]A7D+9(Dp
R]AidF8\sg(hLXp#+>MZN^\P3_!HZq5^ndH/V7HdN$^G^U47/Wfat^4QF0b=8o2cl]AUHgr?Lt
5+TE`.n-\i+k1H3fKh?F.Wj!4%kH#[`eK-H>m/`m/MB?U>neC#G.EA!V:5.!!j.>ZH*bmWta
6&;!q5L+he,d_/7IeJ=PLCKV#fcXa=k>3MD,',Cu--Qt'($MC-Cb\*E`o0RfP+[oHL2)@?/`
q4&]A;Vm+oc^O"%@I!T')%cQ4E;D4NrG?eX;`N+'dG_PZGE;l8_1plh[N"m(/3VR0gB(pbt\1
pT!:fp/!d8sWeD<!]Ar&AVQJLfEX^'5*fuKuW"dIn7pd(ptOkUHO=$38&E%u>G?tSd_;`<6#6
aNu_23H>lWSs;scfP>VX<b?g3*fV>Io]A$"=#^'m9G`<9[?/&/e+_RWn+1'HefZ</Vt;4o/gQ
mX,#]A\Aa*!"@%CoK`D<H$2Q/\4M$tp4;W(1AuolKn51,l=Lh#$h0EJ:-qUP$W3[_.ssWhJJ:
\D6dL&UkVh6KuO!n_+#c>PlhClJ#pW6_R__?)2gk2saNdeB,qdXl,;#+.ubg&_6OeKJciqps
4+7cIlKS:ImeW1ksH-d0-+c>=?/!R7[Hp3Jo(MIZ_CCr%QjZ='Kb#"1a=m$AQbX]A*fOm_JH2
E#^]A>FcSS=VmZS+qW+Ql<?2TD)e/6Zq?N'PlMY]Ad!g'"->jjZ0T<UjsqC"K@MT6J.ehl%F<=
T>K5!LZWT0=;8H&_(M)Y=APT_3lL.(;eCSj`?=MeE060k,(@QJP3ZVG"^hB:GmH1g3AfZH3X
WihF]AAr$,#IVFm*.;p\SmuJD7g!(LtLt`]A#WOLZH,_Pu"rqmleU2;GPqI[9L:^-)A+(3iCG+
M._bVA.s5Fb.JtN0W-/0T5X32(8qlKX83,[%/uH77j?;ql7)JPh+6t]A7GlC697ZdUF.Zm'fF
&=p+hp"e0@*EClH(+3lJ0=kc%O-j1p).EU/+UgU,6@,eb;P\R6t48GM3L.]A7Vj$UWRaA<e\#
KVL!=5eY\MHq9Xa8K1maF+<QeeQ[]AQPfi0>%e0W/ei8H'5C&[;[2i`ofADc-e!=^>a@c)r3A
Cd/bkGL9(:!qE+%h_F?$k_33q&AWk!I??N4>ZeB/DQK1>9r23R_0LmF[gYd9q/oDql2:""rO
je?Krcm6lq=RZm>T//*%jL9i%?u@&5_@<C4NO$D@[R*rGbpB"f$3jQO9da6%iS@0Y5U;=7\Y
hgqYE$.)I0FQ`8DR$5`e0DhrhRts#oH:dhp;USLmMYQ<`\KI0&:HR!dg1T]A#s(tL:nROJL<0
==7lgB:Kg59fBFG1YTS-h`<%HkMCMXY]A$S9tCO/&+*Y<_@Uln"G1b"Z'?IU22KPYHd+^NN;P
FBLZQ\@G?mrg\`e>2$`c.%;Bip?N'_P2JPpVcHTd5-)%9N0^TN$#3_NAVN;nZ9O6anZL1$H+
^G[Q=YRnRUG%M'7!i,Q$a5bZCjZ\4-WtV7]AUf7b?5lc124C/)<%`S>[eX#/W$Xh"ociY!@4J
;&GZlLHX=l$V6"%W=OcW-e2/+3c/JqAs@Eog!,u+pjiYjE)We8&8s'PhLXGJMCDtGeLrHf?.
NAQGo2q'XK\#=I#HRsI5p$;/A]A*X'JlUMcA#jiG4%=I,pU9%%4`2:c9nHgbnjSF>7-LI!ipW
e/J1K=PPOYi<=Y.7nqF;Vc<@et.#g'_^M:W+%=q#RZd0Q1.6gN0iD]AJ*+pn[o7CIt16l*`WU
(9=s0Id6&R$o15+_5;@HU'2raY>SNu[p\llFis@$%3M4CYMS8%/B_rSU$S`CjPqE3X:Duf<-
H\_q3(U)K2P$tJPVSE*%Lt$h+Jl(29N/'?qPFCDkF3_C4iXW&GcqIh3h^[9G.R(lh#J\n=Kq
52DROI.e*MlX>u+'tU/Z\b2KHoEEU`ISCffgi8h8^SIe9e!<-Gkh'o@=n-3lqtjCa6.gsHcn
Is4J@@145?(OQL)kq-2-*L&)-]A,=Mo2F[;%9<f2p%A/@sIR'CVin#L5+g'5Nmom?27?S=5&c
C[_%>JVjX$$m5oIMaZeP.h)%$httWnb]AQ0S]A,UFbPM\bqknCmc%LG:hMR%c,M/fB&?,aMRuI
sh!=BDH&]ALk]APT1:BiDq?Q!9C'9'@3YPoUjPq:GRt6\TBcXNU;2#/)d99CV]A%[WQNRc,;#"d
$u\DJ,CFdTqS$f9#5A7]ABf7_Vlgt7l@qJ(Z(qs2X6!u^gLj0#b@<&B>EL.3k%nj?F7E"O`Wa
hg?Lk(Bc'#i9M>Nm%4M490ChMnSeZq:pP1J^?^<JXr]A>c_ZdS@ncMaOdFgTpU:O*"bb`f`nT
pCPmN*oTI.&PhWf5+JZ.dliMcFC+:o5S[E_I7'$YK8oe,oQMgO//F:K1'<$]Ah6NToe.J9``P
Zh<(,sS3Pm'Ms#EYN=)>d3XX8;si=hi(1I2AeugO7>0A+OJnNDi9AkVA4]A`NS.M)LFs1Yk2R
%r*'9dQ!*&'IEll:4qY3eooL.d]A9t7I<(2:<b]AuhU8CnIu.tPdkKj3sQ?4Rot@N-\fOX@F$n
mrAek<Ot"YgeQ$P:P3Ge88?@qo$pUR\j@5UjbA\YU:dr?Q0g4r-%:YY:PlFMSmAMoZ+`1.<d
EqrbV7';aXL!)Ucb5SD#9oqS#8qR^fS6iXGS.+#R)^F<1oHM]A:cUENN;'$GJX7a\'DuX#gpF
\p0XOlHV/C_#5TsS%i[50&B3hRdMB[T<tt%/?=RE9N6dm4AqgmjY:HegSA-k[iCO]A'IA$pG9
5q<s7-=EmjM@l,p0b$>#Ejc/J"XoPHMC7!8[RAir983'7[A3:@Y/AGNGl8;:d`(6g`Zj".jB
,9lRKK4$+4o4PefX(0UOQI?7R.l)uQ2A(".O'1P]AKbTdX)8QX5dKDnqmhEN&;d_c+^dE\IcC
9r'/qsWM`#)nAS8%H-\'$(D=lL^@,U\)sQ]ABdcRoNF@c&[VJaC`IV,*l@6Op$DIgcB/&"OoM
IGc2WM,2**#@)6]A[0?Cb]AJJf>fAo[sGmT*P=1P0j#\E9$S(B0BT[&%[F2TjBX)mQdJR$A#UC
9@im\HAd;]AibL2Lc:=B).a!LcT"[2R6d-.#=E[LYN`_W.>q.K,M$jC><C?dNa8PVAJ^k.?mu
;8SI6cL/b#n,:0D26BfhrW_q"OqFS:.R;H-gJ/mLB$8MZ!DZ+6ongg?ElBC]ATh6%Li6.%#+A
Md#^U%3/DkSa?R-?[S+#!GFZ76"-1UC!/'SX3"5*VN8FV2+"U7gp]AE3>*8SBAO0s]A)Y7)\*^
Z;;lc?5q3cJgj5!(QI+K79SPqSoV"3=4Il+d$FGDo[6)ZdGN&DD-eRg0u0%:;0"Em^K?ICAn
B/LaiM%k-VU@S5X4:L0-6QU+,B4T_Z&.1sTO926uJk=X5'CO)4c?_g)d?5'Vun)A5]AF",!da
b-L`$1]A,[ZQc!Z_oC0r[!d3oLR>:[r`MpnQ/6::&Bs)aQ.@8X'U535,f!>LoOiLE]AYGD5VDV
h:]A\pkq54YENnZAE(hAq.Zb&akO]Af+aB'YPb0`ISF+($?Yl:-@s)j4i:H[U$TfTZh.geAVLk
Zb0X>Z=OMCli>-3*_?KC!ak13N2mH:S=^o3Wp%);ar1ne!#fF'3(HaqPF6.>s<U"TOI!Zn;/
k#5>n_191Z@$41:(U8S[JW'R+tChOCpB8V()mO9ZQ9GX6G[q$]A<ObZ:e\T+KSd%.5i(b?[nH
X5pi!h-jPoM+(e:oRU>"TBhN+Org0!5i'0f23m6GQVH6:(78]A?+1I\S>RK`>O^mM*h!PW^+5
<#0g^s,DJH6`nZ16Y]A?E;V&K!#>?F?p,k<FM!;Ym$nQ!L.6X>)#<Or9rS5iP@]AWW)LI4?c/[
&kp7/46CVoOc"<b5g1*K,naNW*31p,>RhXh9%/F+'=mVQr$_<`.Ea4AaWaO+%-A;`1D$&bfK
G$\?.4PVIC4(RFSmd'3tSE\,d/DR"\mAe.(G9jqiP$G5dRC`2JZ?We->dGK?Oq1ZW19qekjm
k;Ve`"/EkeidtjC1e]A[L/a^n^n1!`VYrX@2bJ4.P%WZJ4)KS:7ju[S.7JY!5]A(iS_[q4O9(t
VM4B'dK*LbQ#it:VsB0-JBIB!#W[,7?9h9Et?H46JH3rg^sc?8^\d,F*_%U_JSn#;F7U:#a?
`VuapQAb.>CfqsGGog\Jl;G[c6eF/bf%+\@@jNQfY/^G6Wc9FPUR^`m\T0-LBN"5Ent;U2[J
S[:6a^8++cn!R[POdArce6<Hl/>:f?mnLk!-B+S^0FMhn;W*rs2lA=gn6Z]A?7U,+ELBoctfX
XBa&DCYmUYhU(<mG`E,C(cE!Rei+2hF=`D8QOdW(PGVS@ROOfBAG36oW^NrF?#WPpKlkLT`?
cg#ib(#utq4Q%\'H<N\kXK%:+5Jkn76GlrNB=+85<p=hd$%1Saj@D.pV99Vk>p_M0We6g*u9
2fLs%ZFAPJ\[%N_6H)C,E^OWL"8hm^Y9=o-]Ac@jqO>1i^r>POo76Y?DoZkp4B*[142JJmG$T
s%pVS7te"#cZ09<K>(^jfi+4'H[OT949)hTlm41adqiF5&BtmF,0g)$n0uS55>#GR=WlTIQk
;I5mXlTG>l:#%-%C95Fnn*,5%DiCs0:&E=(#G#K4#IMTRPmQ9e4@U/D,8`E[R-BCV2a#ao$D
JalB5*jW;+0G,G<0-J&J(c8(0'T3-,95P)uDDYViH^JqUC!o3!bFiD(TSW/k"9Db/)I&#p<5
L6(-[H%ZILmJ4D:#*AcZ3[:4Rq2jo--eGP#=p)uRs<V\1PWJ&p(gK6Gk2io(^nO"9)S\1J(j
-)ri&UO!alY>:&5%hEpEV<E'Ar*B?2t)]AKjC\dH@GbYS/r.^L-f_)^$2A3gMq=I0p]A"NoJ8b
GF7H#3oOq,8HiX8B@<nk.-*7['N&]AnI/!!YqHK7^*2]ASE%2U-3a3mC(V\C)h0@$Gu3/^'Ef1
?tuIt5$-V)esgb\RQl^-+$g5TgNc9it27Ic_)blNuHkWLe]AWrnjKonah7;rTB_HpVbREIN2t
!7#NCAR?N`EqTlVsfADLB.6:uNH*Gj_F0Xa&c["h`/tuI;Sp[K(08Tn+5_8a.FbcsR/?=\/?
f2J(<n!Bm.(e]AJr8>!e!tsGG,33TCU3RA">\B/Tn?R0H3h)QDLuADQmhksObpo#7"m3FXZ1J
l+s#;Q(WA.k:6=]AWW_NR^$n?3.Q<m%X8%_#BoZYX`cK78SEpGWHnnDRIZMm[Zl*[j;"_).@@
[Jmkf;FAiD=XG(uP4WA_JmTuNIV(e@B9cC0$+^E)BK6fQY&kL_r0o"D7E:no'KXl'/nUU8a5
l*?,%OAAA3@`"nV:*]A/,KT^A\;+qh!OO`onusR1(tSo#n(ie+,tCC?NDgYgX47:?_4R15ArJ
)F8FB8B#0h6S!J0M)Y?]ABbBimYQe'=SeII,WW(!._q823"8g23]Ana/43JU@+a5o<OZ#9-V+[
sN;t/=1g,W>K[kBf$W*8]A=T7G939p`eL<nF;$MV(&R!t$f<gq`FM.^OR?^9$&E`Ua&3A%IF0
GI37dC4hPSLoH@rU,`%79H,^5tDc\dG#j/NL9'V[Xqf&BhOS[I`Q2TauqoUEokq=Dj#ZZQG8
C?n!H4.aNX(&]AEiDjA\nU5BJrE8#]Ak*W!Y$D0BC<OaV4q/#Y,-9&G_OkJ'u%\!0Ss!*a$-+P
IaY4&emDQ)<D`eG*>A_Ls]A)^N_3^b4M[\SbaKi#NPX`gipL5Pdfq0I-o6f)=::tWTJFoWb=K
nZX3L[9@$Y9&!`Yd-h0k=e6kO4_=PMXhgG`.L2sDsTifP24n%T;o6Gjhc,qlX/do%HdX6BHp
@<@a4Nd6$jmS\/9@aK.r!?ACLe0\#[-'mm!*D3`qJUtfa3R0R[*M.pJE\%qWKi&Tgi/HMd_&
uL"_^pYYo0\D@r+m?^eD_[SmB5s".:6t5gLlhJ#fECR=o&0PX_`X&$^!>r8O+m+)]A,:B(G`1
H_-gZDnpG$!<ko0r`MSdp9Jbk:+B%K(3&K70<@6/C2+E!BQu$6R't_4?k']ARDaT-,01./@g;
E))L\nD]An]A!k1]AZYike>LWJ_prag5YrP>[0R"i\eC-%oGC$s3##fh3o.9O&[e^^;O_(P3]A;q
+.K'^WI5KnF,>?a*0dlB5"R%#M+3Up:=?@V8VqVQ!%$/BRA+@IPkfV?L<T[1tE`!K_8j*]APA
XhCRRE(dAk9Xh9m:::H7JHi[d2Z^U9>G/8h>4jDQj%49A?2Qqk\gKJ%+]Aq,c(jL-bk]A<#*<&
>QF/=M\FN7!V\fE_`\X@$K'P;fFKc9+&(?E-`!VCc#.C5WEeA/]Ae*h-6=Zthi@oonWW)#t4Y
#l>Q%RQli;L`W'X0_W#<rO@pu1M#P;k]Al^m-;%@B,oC5U@BB4I>_(09s1-dNk-r1Ro!6bK"o
C:Vd3A#ZY4IjTXCK:?<YsKk"Z0ENKt'H'0Q'&A.t-2SW^=Xoq7LB9maO$Wj2976D1\$RW#Bs
Q)V!KUT27-=&iFY`L#6;"+%,7UEaL2o,o/SLDX5[RNVh^XQ-ZT(>Cc\H=5P$:QbBg$e,KL~
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
<WidgetID widgetID="b6dd3547-5779-4029-824e-6818c533d715"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<![CDATA[1310640,1005840,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[579120,3383280,2895600,3108960,487680,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="3" s="1">
<O>
<![CDATA[岗位疲劳]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" s="2">
<O>
<![CDATA[岗位名称]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" s="2">
<O>
<![CDATA[疲劳人数]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="2">
<O>
<![CDATA[疲劳占比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="3">
<O t="DSColumn">
<Attributes dsName="Embedded1" columnName="部门"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="2" s="3">
<O t="DSColumn">
<Attributes dsName="Embedded1" columnName="疲劳人员"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="Embedded1" columnName="疲劳占比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="2" s="0">
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
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="88" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border>
<Top style="1" color="-15378278"/>
<Bottom style="1" color="-15378278"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border>
<Top style="1" color="-15378278"/>
<Bottom style="1" color="-15378278"/>
</Border>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!CPNTW'F-Cb.E]AUZYf5/K*<pE@5.^p\l3a/NB"D_'(WKJ`GF=7DC+lr3;LR-.6UgDKJ5V
bq\Z)qW&<CE"_<=4kHA:TOC8V@X!\%EsehV?u#-THIug-^*Fa*u<JSUU-bQ\XaLI_Y(?rI'1
1n+4IB.2rs!IN8"?"Uc+@XaBl_<u*@^@H<"D$\.oG7@q8>\*,bt(+_H9qfOR+5g(YudjQt8k
UnfkCVSNQr5:D/:\GJ1P6\:6r4pAQVpCYth$ni--SK?7l%Ymu-_:VD?>/]A_9#!@!lemWgjge
,k2sm\qq,OaB\aZ#>p#b!lVEHdYK1Wh4;2O=rA#`SV%<L>pbQ[89jT["-NnuU@!5i%s9^eI?
l=B=):<A'mi4.u<)>F",<`blV?n?-g.gpfdWP%7TLcIa0KQDQq`V$nUWi[[DPElPgrqWVTMh
LW:O_'03lFFS^V'WRSAaAhMcLpqJYLV0fGHUO2<;Z'NaP'm:J^@RO2l@Zrb5ro"(G7-)<2Vf
n#\!s'bn^Q$)+*L(Y*?$KchuI'Vugm;\a)ird-6PRR6<'aN:CnL9Rj>01NB8!$&T3:@Ia0^[
AscWjq1.%&nc,k]A)\rVDmfkiAKEV7h+$+bQdIAr@qhabdY?8sSJOl2RS[:")jB>V@7@p\G"<
HL!Ep7kkan_m/a41r]A7&h_b^N-=[;EC7pAJRMUl45R2.5RH4mD=Hn$S>^VNS'$R4boh%;"D'
UY?c'X,2W^#CHGH;mb?tP$g8oW2tK?<m20]A7nT;1K2("DZf@,t]A&o*aHG"Xf7g]A0+4V$kIo@
?'![n):PFTk3b:@4IlRds6qqXU8X3OFO,X5,*#7(e@f_HrmqhEK`/[D0$;3NZmVZ9oO>-*O2
&XmfOXm\BZJYhcjc,\(5#f\&m_Sm.rON'/EV1[!`&T"*!-q^J"oJJ^>(EO!4>m*+g1;@Zg]Ad
S;$]ACM<NZ%FPLY,ZeORf,UNrZ-(L7/FTsdX/*i3ROJF)FlW.)k8>LSOA@QE>2`US&&-(TV^<
:>?Eg,SOn#0(R]A/oM9"k53"(Q>jV3*7uF.0S]AZeKNSfeb0W<c`R,RLH^_fn6tf1Q%L1B9_f:
8P.k+l5MmXA#oEaZ7:]AnYZmB%GIq7*=`e'4."`jiJu.`i\Rde8_DJO3rj4guju9TFL-p;Yl,
K=$UOB&d=nc0#1A?aMcW!\W-puZ&;:^*?hk(44f':tnp=jGT/CO2*Q>:b=Npbs/\ANPtofTl
9f!NthZ%il>^r0_rSi0)2G1TuDT%7d`3LEWa84cDqh&8dKb0D6TbG&"hMULVrAT6D+]A_c:W1
RsF%VKS-75-;%pKnU)BgV/%&a^_7,U,+U+kole#Xj\=t`5HQ/2cVA-RW5KCW@\f%)B[K:7U=
pHG7]A".^toafM')E102_8>Bts;eM4#%Y+i!S-O\tpu1jR*NQCk\$]ASo_\?O:0N/Zq*ll+Es)
TCR6*VXs-CqHI6J2C"pdA-fM"e#>ls<MdVt2g_D.N7;!9!mD(+W3ZEm,:7>[dJXm$U[?0j*K
i@f>%'clEK-)<%]AM,0e]Aod#9Bp$@rB74Wbds6UgVs#oK>,3m^HI05DV/uklKVGDg=,7dURGM
AU`D(Q)4!`1s8;Q;jZ.%0p6,MD;!FRMJl9FT*&e3)[ah%fD71(S#i.PIc#2U9<RrX=)jZIEV
Z`[+G:GYJ8JqLhHD^lK&4-os*2=g_Xak2rP6/@@k]Ak'%4inN@3\=U:H[JY!/s0i9,$?)/pH<
f5@+IH29VkU]A?W9c>1Y&4,_@D>,,'.Ypo-"q=h8p>\YhDU<9;_P:e5tlGZ]A)23WrR5f,Q*kO
NNPA0"G<KejC'^?Z<egn[`%$lSLc>:'#8or[J!dVXH)T$.R\[<[p6@?"C\<n4O3,F6]A;5Qr_
D9"Fk$gA3gL51T_fueHfCb\!7fuo`l9#."B0%\%s-EYfr2k`W$OV2:94qus'(6M:oOlnlLK$
]ATe+qa=Un;pP!E)MH;e<,$mN@Y+P1-_>;n$`9#H*VCE9=bZVZ)@bW.G\0?!A=3r<lPZJ2#R[
t3lX-g2nfGlpgWX=YsRbACQ%ZN^[;`8UF8S=NP<69QqMD!L^18jF*#!)[R3]Ag$PmQ8fi/d$Y
[(o:`0Lb?T#gZi,FkNE4I7!c&XX)S8Ou!t$"2<%[&FFR(Fj^#-/F6&MIZaVC@L>.rO5QM:cq
CtY!6-fi/Jq]AZ^K5%8DH&P030nNWnj%3-LZ[Adrh]A7KDnoSkunJ\q*LVW!m\%ul9jm:9fUrM
7b'<h:?0/G*A]AV15[cpKuo?*u`KWCFa10Ip9`(bDfl5a>>L3=)*`dPq_).52^=l_G8N/GP.i
W2(>Sr6$'Y^he!Dd-e;.)^X!8q:%mWC'PP]A&Ig#=+8Q;<.]A?^P]AE?0_r/jSX)=i;O5QPbG`J
;[kDlg<<9<S)Z=3&+sjJ\ZG+DiXLD8M@n>`CffTMIQN3\_b,;4C$N:+#VFlcu;1;4p#@c4#B
AR&:il4<geJG97-[Xba?4%gOcbJ_H!Y=Aqe%`>*9*q<,ReW#\a.YPPpLbW\.:R<s'QoTCWbW
q?[hcDn5FT-Un+tB^J,TgOQrJW?Z#u;.kIB,S<s!)q8."3`N$'*TQdr4\W@\j2'MJJC9ca)G
T`+2=&Nj"'ETQ=c&!n27hPjm6c-9H@ln<Mk@;adbWA1dZ]AhV4/--LE_gj?"YBAuWIfXQ<bo6
WP!:7B/#k*m$[^]AOX.QU35]A45hbTroBZof,O<`lMd<XC%&p=l\\%")m9)iI3N[Ihm5GjF$r\
D6MB)Fh(Rg\s+tcn,R8Z>dL7"aS?[FOrODW*&9U("O:?Q.ckaBV-P$&oN1sCGfmuS#Mo!A2E
a9CaI?n8TR?j+dM\/(m('DUj-\nbq*c$pHeKdO'pFDFE;K\*iW$4J]ACh9n$2aRK;KV.Rl]A-+
H'tA-+lEjRT#+YGVc?F%-<(qFr@'d9kW51F`dpeHm)`nJWWH[1a+Tqh;B<>NTWP]A[d-"1ESh
We'eKA!Oc/#!0TO!rPUlG0]Aq<l?@i]AT/:AthmF"'r$N):3RYIgP:tlhtNoTYH$7asUH:E>df
parZWOp2Ph5rp7`YRODA:$XZ,Y"CkA'foi"!/.47=Nt)8CQJc)tF*&$H9_)_fdROr2IcHUHH
+?T8bI,$L9G&p)oNCY54H$UbQ+UjhC%%SpI-$[<DOnu/G!=6q)*(X29H0p>r0k4H(ZqISPWD
#?dZKSo#%QP1hDN/cY6&5EnJYc-=*G>5W6o=X%VVkP8X]AZ&O5<(GYr.L+3OX$npoqY\&l*%M
hB8<,Ou\L7"\!%o<QW0Kl4h4%q@VEb7nZ&*P*]A*-cV>K0\#fQ;n.R"Fn"=m:)X2U#UGE:]AX-
@f=k/jAo;:3u^<@j!Yiugh?W$k(SoRg\n%6M&'V*S(T4''1a>i]A)6SE[.IaHVXi**_<qCRLL
fWco^S)452k&g+o[r%q?kK"XnemS5I'X7k`sL2,*J\g'ls.P82?[V[VY',L_QGK#J'Coh"j\
'r6"4n.0@&`To&8Z'gV+u'C&9aQ=P`_:rhe.\ghhGN*qYWL#k@2o`4Amd\=Z:YWDQY63q2mR
g-4bfn]AqRp@j'<kW9U&UWI^'/OQRiN49cdcC%EC5]AJ830WoVMF.ILG>hD3<Q7P*[o@h&skQE
GuJ9\*B('hUYtAV?@1g]A@B/b.^CmVhQr=a4HVn)T?/NJ6o,:r,/ir#li8#qZ;5,j=0Sf&Qi5
Sq#pEB/iZe+WZVt*fbL1`Oi&(0Z>]A!]A::)&a,U.!85-I2I%eU#Q;1dPY#4@boWJQatsFcp`R
`rC<H<ctD_^keR*S*J)uKDT?RL6j>fDGUD.`e*[/mL,(A1h0C$(re:F>no_QJi^nmM3`lT[`
pmThdX[-%@[O/A^K88V7Z6)-!_>f6)9aO2R\gk6`\\Xm<gLO/Wm5-!';OJs\(U:0[\8p[/8X
RC?"hjld&:sQOlL+Sb57^5ojK7%JnM*lC/i.8.7B?XUP`_$!F9J5b:\c%6h'DjD_)L%,W\-<
JO(Ykaam$;[5B',FQ^C)G$gA?Y0i3*_$1chGGsf[RRMW.')'9S,<Lpj_*-QWf5SblJ0_#;30
^Fbp#RCC^ImE!.gV7M7t*dL3_!AYXCKg2R@i,RikS[0rQ'r0)O;sj.528@n'JQCa_m]AOM$d)
Rs+U,P_==d_GNC]AHoWb+*;tMdBFhPs(D%n@SVsG5JH5]A0LpFk$mo?\[ZPNlgi9*%$5E?2`sK
nsTp>_FeRVde-:561Z:qq-fXkH7Kn%lu9'Q3f,0mdIst?X\SRIa/LTjXWEZKcN6-nbMsqTB*
UZ`<O#<]A'<T-:QSh#Ms7M=NON@umhGd*8[8"#<E]AC>Tt]A$;gucGa^b*ZA?S2nl1Yu,/JZd+D
`+_6_h*AdB4e(f?5Q\i)Lq0Xj4R:<0?u]AeeHZW&@P1BGAQ"g"Cj#,pTI!l+G]AK;2'<)lHtN.
ao#&L9+"Im(V%3@fCJUsr6S/B9g\FZC<5=+\q_S6*lc%8<C*f2";H?\+X#pp6e_NMZ\!?XPc
E<j-OI:*Z>;A'kMaco-1'P^8HNR>kbRV`))hRp5cR2+R^'mEQ=)-.aF2D'7B;;Wi$KWGl8#d
%qE=&%g$UUntsZZtu`-i#tq:>'J(-3]AYY<XM]Agkm)rJZgu]Ah*5*bNMp76pYQED<4qUk,O+D;
=7C+sl&Ep/bs3mZW3(NGfQIR*%4*N;p96kOf6.;.GtZbaLZl;%lDRm'iih)6-JJ,=*U.Ks%S
;Pe,R-<A,n.3Y_b^^D$abNL3X_><Uu?;C30P$KQjJgnuI<ik3d>*;1Jg8J*&Y.MWXUVXpI,]A
I6c/:#gTMjc7ELIDaVT1^FtWd0M?4mPI;RfbbL./NHs.B`*tJFiJ7q0fp5gA:KI2MWYcAA0R
,&["KSicf_[=q<5u*KmuF"J(8ZK!+!DOi#0]AgW!_I\g6U,R,$n4KlWV>f-]Akb2URg9<DQB0j
A*]Ac\/4go%h.T]AjhC&P^+mHU$Z`ZJkU0&F9=[Jr;/VMp0a50VpI'UA_TV2um0b_e5b14NQS;
_!I#1X/"[f(7qL(-^>"em0gSE)G%S%B^a`=tQ+97;cVLk-i!1(;a,E'#i%jA^rY4M$PVMsG)
Sih8?<0TjZ/*6(e6s7DLNqS6KQkRY]ASQ?$rR$2@>2e#b_]A!'b`-\%=qgHbseb__t-($2Yo;F
r-]ASn!h+'5H$^Qq[\3h%\TS/-Ui]AN:)Khk_2,4.2%Mh(S5GE0(EP0I/oCI)m@a_q!XGpmp6e
lL2*KOlB,=,g=G2G0OThXY"n\cEkl9%s*S`M<,@$O+<]A#7>H=m)U1:-eoJr3-iOIU=\WUFR,
hK'P*574:rF*7cF?F??"*pl,>)aGI"2Ht\PbbO`iK(mY.B[G!UoS*_KO&4SpQW?ooRk@Ec1S
H87J@^`hnq!,836L]A(nR%nXOe?-M:&sS-osZCGj[#%#Qb?RF;:*UojJ[7G-iiMLGVC]AHZ?fX
Q5]AM?`b69OBkt>HXOepiFIdok.`%ct^?j.Rm>+F/s.pjrFDm-gm+=mY3u:h5-Iuimd.C-4/I
)b"dL381\pmR(.ba:=cs<;bb1YN4`KOf1lWesSZC92"SnP0^e$8;kri4S#W+d;+q$)t;BseS
s`)_uXf&mN(ZO'<!/g'E<a=oMd@/C`H#.>`Jhoi]AP4f<os]A^>]Aa[=6Fk!*T$--gLp-J]AgJt0
_\OsZ5`-Tp]A:J7$KP!pliC0iGPYNf-G'B9DQ=$Dj@JlMX[#+L#?s+rS_,Z/47c4#G)=n*Tdt
'OlkZMup25I4)b)dh;.47)=Qbc<@aB,mKU+XdLa]Ar8LV_3BMPI0uGF,S'E?NeO:<3:'G$t4s
YDqi\7A?J3_6?Vjf$@ujVoqY3;"p6D:T:9eKJ\jePV2:o_Hc3-hZ*Z1XH1_g=p@2UCu(bc5T
K;V6&Rdtf.Cu]A&]AQ,-q98sUU9B^[S8"`(5g6#(#l$dT`;V(h(it_,g$_gK3MAQpVbsjE]A?Lu
p`0I\hOh?P*K!bptY@TI0diN!N@J^F$W&@e*e>mLN$'B9Z1_Kj;/%^.DSq5r]AS;t$u9AXA<@
k_Mo>g1LD+(=Nf;Nq=R')'A%#g!bUeqM>Tc47QV^;G10c<rlq]A$f;0q^N55.2\=40JeHI6&p
$bVIVKfP%QgSM=Bt7^fbV9;?__7>(M3-q"OKu?VIL6GnOXPd(!A!9rUKi_jhG@7Cs0@%PKdM
kh9b^'GC>Od0F_`)r0S&]A5L*Tf"@Rg<d]A?e^t*&2A6Ek^B&P0\8K.oiHPs?C7sXPpSo30NHD
!)'6&0@Ug""[M)2t.M8U&SiprfP\Q&jRD/hn.d7b'nZWf%-4Oh?Zo%e_f.d^I/:lLdZ89-XI
ThG"SM;?mJ=JWkQ>Pt'dKK97`G_0%WmO[ps=)FU5\jE0:c>DE<0a;QR"i7WiHNfR-EW9[o@6
nDQ0OPnEBObOi#od1"'_Ch2ojsS*oTe+R%#_nG5VtH]Ac_g>HFoLOY8\jR54jLKBJdW,>$SK%
tqf>=e<cK:St\U*`Nng\oAYZ_Z3Y0V93Q0^e*&B9SlNTOBRYJ@`=m#)"eMN%8\_:.f7AFV:p
75,oR&VC!US\:KCShOs/k@s2!JJTaM,@<i8FQ<Sr4g'EpSP:YO8HP1rlPNo=rE!b!2gTX_eg
5D:eMb!0KES`PTNWRiZXfuG:4ia]Af&a^+/VoQ+]AMRO-M34FqiZ2)To@Q5-r+]A%QIhB"NcWWc
f\T>&1b%;jlkIOMal^PL3F,#g<_psXB_;Gb8-em48r;C;IXf7qS_<maRpO^-Z'(ZkfOq9:><
*4T?ps;'f_BN>f1fSIf`n,7ks25r:+K$q8GbZ>UAYK[r==BjD3Zg0(aT&Z2UM9M"-21uZD1A
b:m0f2jhCRar$k47m>W?jPWMro4%c+gk*=NVtBGs$iP1]Ab&lpGHk,0!ReGJMGEhbYWM3*NM5
me@&k4BJYc<VB-f1$Brcs$9lG@(I7N2>SU96!:n"L$Ht*llBlCBKKra:)LPC9lU4V[^.O^M+
"gW$bD,=AXPJEh;ih0H$(%2och5c@`@G4Qsd+iB[a:ehAbFQKZ_9Q.i4A,A`g\A:m?/_DN&K
'SVU-$<M68Q'&#4X,(6W'"UV'T_S!u*4Xn:(.bYXDo]AbEu!nJ?cITOoU^9KcefG',R)&$`4O
HS9g%s@NE7M54Wo%H(3J6GY3m:!bp,6fpjnB:j^JY',b6NM!;gBJOBGUK8sCCO:2*HH@6N]Aj
sk(8a#ba0GjRgTAKG?r\93Xo4a"1l>9JS=WI`8MH6=f6/d5>;Gol]A"t[e6%,r!]AS?+bi0H\n
pkapCiP2iIpPEIkYbh?/_)+W<M(rQMk/@13+4)(j%E7-HOk<(h-p>eb(j,FGnS:KYh33GR9P
5m3h<,S(iMd.9j@22m0@9ICk:kh1L;7/`%jf%POK:Q+Cf\a#L6T9T#g(DipV!u;n>Tu906mm
/c1^PZlYGpsLN*L`'tR#5:=l$L)_gSdM0#L5bL.EATf^uoiY-LuGZNUVZf6GuWiJo')H-9#>
s\9!-eD.-SXjk<pamS;r3;\6o^iuB*d$Hr76f52%KUF8^Nes='!d.IWp).LUEks,lXAuD1lD
6No!-80b>dUlN4?T.j=`?L\Q%_-?[RZo+Ncu_:o(@Depa.J-WK=8_p]A%.$&5/)G:0sl#m&rH
g;?%Tq6YTs)+4_#I/^F[+u\Dhfa,&hkr,LBTP5(o2;)7XMas<Cd]AO/gd'5t_k!8K)N#GDOIm
%lLL-?sO?b4nGd'CM(f'Kusd8U@I220T/s2G3-Xk4a3'sj=/#a-=-WUT+`aXI]A4j0-D@CG(9
;O,cr8+Q$#0H<7c6WhJL4hN/TNA=uV]AA^XE+cn<pll[&D1):BI?aW0Vl%_%.J.Zk^%U.TcCP
@5<Ue[%KQWOZje%fEdA0q+##Eu]At9$HicuelKJ)E`=ud<=1K;c(19Hkm]A!pf0pm0b;nuC?L#
e#8O/!kHK+26qF4AO7`!_O0e^9Y?`PuONt6DO1(8=n^%rSuFRckPi_iLQ]AZ(gTLkIBrM9bme
dSddqI7C*WGq1fQipCfGOtq'uO/t\M]At?Or/M0EG9bK7sV2$'2\YX&lm8,_Y*=(/emXi$pr2
`fN_;_IA6))fWYNPT$5eB2a1RX+qRE#0_0mDP>l*_M+FUm.C*nsBPZd8t%jm7@F2O7BYUF(%
0Rep6j;3Ud9\K_9.G$pPp`3_&[a!d(sebFC[1-aa<e%B;K;r2PLrM>qV!TKq;MF!T.Z9l?`Z
kOc=egf2WOauUkR(/UT$$3.^ZbUid#1ffu=$=@Eb[]A#S;\BM2.YsI9`t9aWnau5YH)%+[[+(
P,cR[pIB(UO-nlYs')QKYq`1RN[e?VDsQf=F^:!Di[%o.]Agjd:7^V#(PS&#qJH3SL&(P1(Zm
$*g9&St7`F(:MFXC10)3ZIJ-k7diq>_%jRCMH7snLBgm:CFijmd>P?.8/VpYf2&Zjd@jII*f
;Vr\IuONSQKNmau!3\F7WZ7i:G'a$X36;)W&T6TI%?bed<,h=JM?C[P@HTmTcHP3*^[,Si]AD
Uo5(qWbG1UADq4T.f[Q,#?h-O6:\SRJIjK35_i9O2?3kc2<R#c_1Fgb`XSEN.#&m)Zm%$C;*
+V)lGT4<=PRf[`dMl*u_]AiY.<]AIu)f<:Th/`kj,I;@F^KG45WdiME]A?6Fnc_5nrAX*/b=DBt
*!Xl$+por0q%1X6g.ocKEj&C#'d[3rduNYRhO.%8memRT1[`h7YfLWC2XP3V>[]AtcF10=qE*
[+(D+k,/1YZhlN!:3tNtT75GAqTm$:r71NmV,bKn0.i87Q6:DNQh0)>gKaaWG/+74eXTk<Ku
ps'Xgk(@#S7Vm96]AVBnmnD?Prd=aZqn$jL<!0]AVI<)-h5RsPUJIK+8-g#Ccg<%`Sg1@#7k5/
8i9Ik$jg#/ne<@CurP&X,s,6AFrr)(2lXF2jJ'l]Ag-TP0)V$3i7U?T#T7lljl]A%[.4\Rf;^A
8'^tHjIiOq$RYjBpH1oV#Ih7,5:8T?RCF2j!;39[/AlrU1$eI4e9`A,!(AnhsZJJ_75TE:FR
;a4LSXGC<PDH+C[&Z.58'jO[u7WEG#.$e"c#u@`D:*=0PY?]AjX+u^k1OkOFbp>mrHSG#$e:%
.I8[Sb&VGg_u>g&\r)gP/.Okb[+(AEAG?N+5O8[tI8uPsfM_@DaT$?.3VD)N;Tq:Y`r?;_<(
YM9>\JM*e!sJhht>)@]AK-FM<Q/JT?8!'.R>e./h(RVg,2UFsomn;!(E++MP]A&`<dN03=?[nt
9;l!R^hO6t!'e3$;-T/$HXhF4**@SC=MSNV)]AFH&^\Po6BD6Jmk\0JEC\@ql76r]A"]A."/B7S
jtE$hdhcKohPdjSf'fdMtR7`9Q:tggd[*g2Q%#H@.r'ZO[S94Xi-LN^)^OC9V'X42)T:VGjj
RZ-(tRkRigs7O7fucp=s.6qO8]AYb\9hieZsJR#PsmlD(ZZ!Rnpgs._ZjYjHF,=)AZ(eRQ'7b
BcM!A^XB;JmX+rDqAr5,VsarP2,C,)NNr'TaZf:\[8]AO<^fM'O(por,eiX(NUT6$^[iC(lUh
%IMIJ=OW,N6P1(&66<.$5-iB!%b%3=hF=?.GDj5N]AB4@REPW=FU&7C<1TE\?%W#&6I.Uf/2W
;oo%(rOhA(4/==)fcB@udd`!-=X4@3d/R&:L?-__]ACC"fk!d1Q^6-CNK[0ejU>jjI^W>7!JC
s=EHQ+CflgD"RPp]A<ZU3k6J1Ni09EDSVb7+!AutSEY:2I@Te^mhEMef7d.uR08r']A&3GYs!J
rW5EA8gS_BF%n45Kppj&ba_/T"CSo2*4f&5h&err]A%2(qkZXJJ\RnF6O%T=!m&:6N>KVF<Y]A
<_a[<5VW9B8&gF*V[J\fiA+V5'qW9Th(!E;\"0o([Gf-9Df)W-j<K_Job^i<,3rhA`o2_til
_g9RPlN%jtmK9iKmdC!ep5jQgc`cJVMCDFpf"!.o,0L6QVI[j6Ge%mh]AS4Fi-eGWpo==mT[b
r9-9:3f>jQ[T7CO@fY_c19B(0?8$,]AI?#(Re1[o=EXGpsDfsp_)I$gtI1C9KTF6*p&j#lRoJ
`-Xo@*$7^jZXWk6Ae092VLmh8&(*h`BH'BmRXgIRL0pZ#%G=sK9Hh0^Qb#S`tarP$Qj(\`n,
/H1LC1@dm$9>pTs"U!H/?F#QCcrYd=GoD+sq46S-#P4hT5)BrbA'0@rWUr&sO3Se>)o,XLC<
6G+YjGeQ`B`kt"dr/Lp5QOgf[/cP$`;Yt&@l%'![G&*/E%m8PI"+I'.9')E2D;i/09plT#6Y
ih]AhcOX^"0$Wdg$GYJdm!#(ptT0oX40:l94+!+&ce7]A)+=+bDrtMC*PA?hBA5%?VeuBB>'`k
8hIoKu.\6ks"XOs*=//7_.k%5G:l,,l#[(!"RUr\AIt99g-5<+*r)^&J?E&>!k_EANNeho[5
&2p`,KRE19Bkt_I!OOoX(fcKrs.od(d?h$pdG&YMk.jc!mioB1h#%Hk');':&=ZY*Mo.lJVi
!eEJbURXo[hsThgM/qo,1os%HIa$,:g2kfZPmlDtG[Ao3KTCfIVqZL3l&mLJ$B_HJdS'2ID.
oUH#VWVB"8CmgoWo60Tu$<6@BAB\M=B?f"JbK]A35j;47^><L/:8JBG4ZGC]A.G.RW^=^WM55P
K95:kba@gJ959(r+V;9.k$(c#Q:Oqs;3LG-f2fIBIPfMRaPK7&.o_k@rUPonWRI4'?IkS`RY
Y\K;OCr;fO?AfjGac5*_>qMu^Y6QP^T^k_6D=gN^`q0l:UKT7:hUu[+tG_!_>=PGp?Y"'1">
aPNGJcYo3+Qi%3@gU:R*1]A077>3=0N;#b5F5u&\HiC>]A!RJ=t#;Ft.M$4ucT2<j^j?1'>OOB
kR!qAs8d.g/IM.66<LIM>;[Z91"CPP7G'!D;]A.l5lN]A0F(lY#<^lbYUO>&f^l@6X`nPXh/o:
:HHJBqUrU0]A&>gnjGrY^+qb<8O73/$+fS_1!G^ZZO:!pkqE+:(90(I"M8$iD%uFtj,?-()H5
U[,YFg.aI798Nn6$qfB?ZGP6cm59r!Zfclm>-Zd0hUf`oF"_mQ]A[UBV^C9Iu(^&:Qb5S%&bH
P+R0`YmhieH.V-d&@e^VEY9u@[>\&QQc6Ji\n.ST!\L"^+A\f?C/0TD_IA[3;Wb8A\Z]A4l.]A
ctYJ1QR'.:Suc70]AY324ML6?E:)*47*+dXpY)>erPqd+&\&!N/+B7_!k]AZsoY[Z_Yi:s:H8N
n+5PM`h#mM+XB$5.=%@ZiAAHQ7FRV=Iio`OR0HD=/h=gjg7<p5AhOp=Ri$J%+Q%t91I?/,IP
S?'o5"lKlDNh;psXl>'4&k74HRd7]Ap10U03&.W@!]Ak#qKWcM6Qq$CZhggTM@MaN`XAkJM6E+
!S[SVEuD&Ib:X4h]A=sack4Kc&@,j`&re(2[LpM2jFWoK8uPPX1i4t5Ubh6@-'b"i4S^"SEUC
:4;.V$+9M:99*^-bkY1`8lLs`_b-0#0*TO_*p3WQgla=5;0PAi0/$sOa[<:mDF24j%-Qg(pr
D!dB"F+eh9%<h+X2lL&4k:hgC.*hkHf(p^GIfG"c5C5T`djI<Aj"[Z%HG;iRnoTQHHH;AJ4#
+M_?%lIEf?J`JL"JSU`YmI:TX;t;%-]A[_;%gJ"[),%DlMqJEA#hjhnUJ\8#,D436g#l(pmYk
ql2Ef;N$_\jO>e/4E/.*IjY@`)?YN:aNW@E$$'sK!6q;)Bb8Pql0T>#$l=hiIR;`AQD=%dUc
t)l.%_#u6)7R[EOgYgN[g64i(SM%gs\ioGo2&n0U^fBJG"_9#B$B;]AjpY\1dm5A)T;ZF#(^.
ONA>4.N_C`o.:q_eb<4p-VL'5MG^RSKTp'FQKj$1X:a$4djXlO#o_"#L$SGJ&NjLcn=?YfAI
l]Ac.mtU!M:2#8),[Bsj4Rh<2RC0[qK._";KcRtDZ/rI!'*`ReB-`@-\.SrW>Nk=3mc"QfEo\
o6<J$ukgqSFRkh(8f<b82pUEBK@q`?Mta)eegS93k6?\=WP`jke0#<&Q\^GP7DoLJ#_!-`sk
K]AsML2Cbe,Cttg[=Aa`.2)FG=rf-;)!F8(!hucFK%![<qgt_49hg]A=Z#!P_rOgBdHCc]A'u*k
bG:FAV*s,2P\q"?siQ@iTn38"O<S*ZmlgM?s,q&;KV<b>n.b&oZ#Q.__@BI:0?Ik5sd09]Aq<
E/\DYBW3U\3gDIZrG=]AEAFG_2*glg">!R"M-'(:i%5:`3&ZQcht'Ud"JU*-u0jLj=OoE$i+6
Gi&(r.SnB(VKmAFiE.@Sd`>Ol%%o94kuH72ndGP+#cpX@c9Nc)BP;4Nm"l770!SPG*$Gkg%&
5`Ik6S/>oM>Kk>B>(Lmlum_&=2q'E>XC^]AT1[``J]A?.JA+FEqE\FAF@H]AD"0lJ!u_o38'G2+
0OB8qOjsb2#>+qP'_Icf^.F?R7(:C<4!GqV@q2+EB*Fl12VFSJbf%7PniMEIj+RYe*bg1)lY
mqB\-YD!TQ&S[IeRUc4MTI\[.2*C^O>/"rrW~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="846" y="444" width="292" height="180"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="chart0"/>
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
<WidgetName name="chart0"/>
<WidgetID widgetID="03443dff-aa65-4db4-a5ee-8ae457cdd728"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<![CDATA[部门饱和度监控]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="2"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.custom.VanChartCustomPlot">
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
<ConditionAttr name=""/>
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
<Attr position="1" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<OColor colvalue="-1197808"/>
<OColor colvalue="-12080918"/>
<OColor colvalue="-1222640"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<VanChartCustomPlotAttr customStyle="stack_column_line"/>
<CustomPlotList>
<VanChartPlot class="com.fr.plugin.chart.column.VanChartColumnPlot">
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${CATEGORY}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${CATEGORY}${SERIES}${VALUE}"/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="0" stacked="true" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="30.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="false"/>
</VanChartPlot>
<VanChartPlot class="com.fr.plugin.chart.line.VanChartLinePlot">
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
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="solid" lineWidth="2.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="AutoMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${CATEGORY}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${CATEGORY}${SERIES}${VALUE}"/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="1" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
</VanChartPlot>
</CustomPlotList>
</Plot>
<ChartDefinition>
<CustomDefinition>
<DefinitionMapList>
<DefinitionMap key="column">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[部门疲劳]]></Name>
</TableData>
<CategoryName value="部门简称"/>
<ChartSummaryColumn name="疲劳人数" function="com.fr.data.util.function.NoneFunction" customName="饱和人数"/>
<ChartSummaryColumn name="非疲劳人员" function="com.fr.data.util.function.NoneFunction" customName="正常人数"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[部门疲劳]]></Name>
</TableData>
<CategoryName value="部门简称"/>
<ChartSummaryColumn name="疲劳占比" function="com.fr.data.util.function.NoneFunction" customName="饱和占比"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="79e86784-b7c5-4fab-8a57-e9448bcd331b"/>
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
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<WidgetName name="chart0"/>
<WidgetID widgetID="03443dff-aa65-4db4-a5ee-8ae457cdd728"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<![CDATA[部门疲劳]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="2"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.custom.VanChartCustomPlot">
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
<ConditionAttr name=""/>
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
<Attr position="1" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<OColor colvalue="-1197808"/>
<OColor colvalue="-12080918"/>
<OColor colvalue="-1222640"/>
<OColor colvalue="-486008"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<VanChartCustomPlotAttr customStyle="stack_column_line"/>
<CustomPlotList>
<VanChartPlot class="com.fr.plugin.chart.column.VanChartColumnPlot">
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="0" stacked="true" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="30.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="false"/>
</VanChartPlot>
<VanChartPlot class="com.fr.plugin.chart.line.VanChartLinePlot">
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="solid" lineWidth="2.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="AutoMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="1" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
</VanChartPlot>
</CustomPlotList>
</Plot>
<ChartDefinition>
<CustomDefinition>
<DefinitionMapList>
<DefinitionMap key="column">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[Embedded1]]></Name>
</TableData>
<CategoryName value="部门"/>
<ChartSummaryColumn name="疲劳人员" function="com.fr.data.util.function.NoneFunction" customName="疲劳人员"/>
<ChartSummaryColumn name="非疲劳人员" function="com.fr.data.util.function.NoneFunction" customName="非疲劳人员"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[Embedded1]]></Name>
</TableData>
<CategoryName value="部门"/>
<ChartSummaryColumn name="疲劳占比" function="com.fr.data.util.function.NoneFunction" customName="疲劳占比"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="3c6bab47-ae75-49cf-892f-1c32c0fc206e"/>
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
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<BoundsAttr x="848" y="12" width="283" height="204"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report1"/>
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
<WidgetName name="report1"/>
<WidgetID widgetID="ca3158b5-101d-49ff-9060-60e5129de432"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<![CDATA[243840,640080,548640,723900,723900,426720,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[152400,2743200,2743200,2743200,2743200,11247120,11125200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="7" s="0">
<O>
<![CDATA[工时衡量指标：以人均投入工时、投入工时满足率为度量，月份维度展示工时投放的趋势，判断与业务高峰是否匹配；部门维度拉通横向对比，清晰展示排位；]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" cs="7" s="1">
<O>
<![CDATA[1.人均投入工时：组织内员工当月实际在岗时间平均值（sum人（投入工时）/人数）；]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="3" cs="7" s="1">
<O>
<![CDATA[2.投入工时满足率：组织内员工投入工时相对当月标准工时的占比（投入工时/标准工时）；]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="4" cs="7" s="0">
<O>
<![CDATA[饱和监控指标：从部门、处室、岗位3个维度逐层分析月均加班超过36小时异常人员分布情况；]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5" cs="7" s="1">
<O>
<![CDATA[月均加班时长 = 投入工时 - 标准工时； 其中投入工时：员工当月在岗时间（sum日（下班卡-上班卡-休息时间））。]]></O>
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
<FRFont name="微软雅黑" style="1" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9C#u;cgQ-[?#$K%;W-@:43[PLN,&.1GY2PO@[gVGeo7p:c#LY95:H3XB%_q7RBl%D/4kT8:
<nq!GOqIS_DLa=i^c0hU2]AC0GLc[jH40_!=;.,69Iib3Hk_8,gALn\@mdK`EFhEiLIU]A^!H_
.qtn-XT8bk9l_EW,^@6,,5JO`^XBGLbTARP.5JK33rot)7kJOsq[e]A`=s89b!kBVDMR_#-KF
`QDR6?hDIZ<Q*_gGX"oDg_%p'f.>q<Km4#,BJ>f]A=sM.r_bCu4_O@"iQoo$s5q4-bPg]A)X@J
HL$BZ"jYj1^QK]A$#c<tR!UGag!MCIaFS,o,NqW4HZdY5*nl.a9ZbMR(N1LCF)82IRjN?`(n[
`thfqfPbfn(T!&8[!$t3%@!-X_P/\5C,A8CG\sHrY/$?G.k"K:@(5gtbRLOC'JE'pem.Ha/V
te8PXaU.CE8P?H!ho^p9ZMR@J:T2Gp1q*9W$-&V(JuG!=1%R>DtdI;P@fMQ2u:A?b*&&?P/`
hTfpt9N88qJ\YNKk:V>9tDbO=?-G(kYZo^"O@f`oJYh>BnJ$qZ;iC9X\q7?U-2)J)2H87;%L
T!nW7G[3Veng,cU;Mb.\F(W&`qrE/3eu?(^G?hR_MLQCh8fk.R4qn#^9=mfUoXWYgtlkmV=#
g^gU,/X>]AHouO8+3jc!=)@o*ODm9E8@jXKKDD>@(niL]A<[op1dKfQFSE/dA/k*EbV[]AlT:s^
%VoLl0XFSgb!7NS`mAej]A/4>?Y$f+:h5Uu8/tqN^Q,=[XBc!)5L\7Ja<<hQY7:4POXN8Y8)h
4sKb6fi;gloW)%AN#9Q=q)LNMCCcn%O+k*J8gmJ(n;;=),bKLZF6i0P\6m&OsDLJ$l&.<hbZ
BfIbEL0$u\<n&Gsg[\m21#MXHE5KPH`OYF;OH/K2=GG1:i-pEc8XGZ,s6<VtS#,[;-!t2tkN
`L3=0cmE%qS1&]AN0!Y&Ak0i%Nl&5L]A_L0o9GM7@bb0&NEc^7_L.jMb^ujsf"$,X.]Ab66<g)5
ON4mr#=f!Bee"2L2VNtTC[M<hWf:C9SD$sm$9]AfoS1TWNIX4hu8R6TihsZ`Y_)^07*4r:.)`
aZOZmIZ'_eX/or.-EU%U6WXgD<bi"Vof)]A@'DgbtTBPRn>:/89TKr/MDZKaqaNEB.bh&Y?@L
Tj!PuI`3J6Crf0GBX*MbkQcdWb"ii)qG)dFkKYVB`\8-g$/^DZ;Mo)7$XjTLB%ud0Ws..p0c
Z\ODDn/(5QMZ;j$-oQ^VMAt?!\)!85+b>L@?r>NEhe*_FY)&_A$ZSX^[=+Ai2e[!Q*Q88VL(
Dh4D>CA*3n^le:G4kmYk=q12YA?c3fAXA*X$LC-m5_%boabS<klB<L8O2SUc&Tl`l<q=]ARqN
QC.T@I-OIEg3mP-se?aZ^QD[G;p'!DJRp_=liDQ&p#X8?p^2tC!/mm2.2l7dGM`:NTnfZ2TQ
h>R7,ca-\(O5T]AtW`#k:Hb:$JLL7dR0.G43X@tdH-@Z<VqZu!24b!&6ZV.m65SR3j_q[r[I;
:_(cK*s%#;8gD?KS]AZgr`H*SY#'BrStfN]AI%gDV+L"9HXkHO!V?W4msB?<Baf%K5g[HQBk2:
TB`:06?3WOQ^=dYR4f@/O5U&*)M]A)f#bgM=*jE@_?kM725!=$e-R::[8h#E:fcF]Ag9e;44_F
MBV#+rXbJDZ;CEbCtsQ0]A70PDI-#Agbj[)@?jLp@JmAn1:KZA)Fr00U'EG7Y5'eHVYurGs%&
^eFUU9o1ef>uGeg.09:teX5kKV$k4k`iVLb+4,jtQA`R=n6A5H7%@Wgj1hh4K[WQ8;51ZZE/
QP^A<oQq%?5K#;;cRGCjA%i0Ep`PQVYh"0./I8$@o5?ipK+Y.PF7-Q;BbDq6-c\d>Y3lu@8>
lGR5In;ND]Al+N?kN&:+AE6HOP'fCh9\J(9UJs6)>?qk`%/R]Ah5PqgYIa+dB'eOlFIqP'>/nr
k-+Y,C$_V@A8%2K<"/.s3Ri8<(3dX$1?S\c^N`dsgOCH'n@,d8>+#_\"?9He8eEI`$(`$knr
Rl@H86InY847O*RPgP?<kNV(mFJW:`dPlf#3$CajEh`=0dr2/Yc<3h+S%LgP>;=J;rjh#HfQ
gO3L&4TAS]A0acIO*ri27#S.$@/#I=H>4aH2IKkWEak2TX1?2TdZ6M\]A%4n9oLR]AL:r54V"jK
a)7NFQ=_I7i74\SOYbV\:&<[i!S_0Da=^0gla$3AUX/WN^%sCf>)+"T8>Kj9LK<@CDg8XPC9
jk^[.^E"KrNAD%i^qSO`?s^U+^+Y"gM7LX>k;0E@*K3kMbYaH>4Wo"D@WYjuQM[O4)^KEK>K
[`6V.Ue&d#GKdTrE,0)W=,[+RP.Kc$Xi9gBlpApp)?,TBnh=B8%^;LO06\$#8N.fel"k:/GR
8X<AgX+QFDfJPf!o0l]A?Y4$#-L9<`#sDoaQBJ7`&XUNFJTLl)6610fa,>Hq%ZCpdb"6pB[>a
UY.*NT4C;&t1i4+KDD\p&m5c&j7Y6!8EX:,Q`FNag:+K4PEO6b_dlif_^ThuWr14to)4]APS3
YWg--JY5lm>*RX4j4nBDT(8+a/qAq]A=t3Q'Rq*;S4`fF9bl4D]AJ0AE-8AVUm4U([XYmfO4%%
rrRps.Y0M`S_q1PU3pas[DPZA+>L6*[]AJYs?1Gd3BVu3eSs/A1U+)oaukNOARAJCD^kRb.!l
!Cq#pJ2='ZCX%gXV[!ct]A`R\aA3E`S,8$3*=fN%Mggi\\g*??n.cG7Z0$/FknNaZV&*&/9[C
"?il;NCmjG&TYA$!Z(Q!eJmu*!>;o`M?RLF+1.Xh,LQT4-WUn!.hdk2EflE5co$E;KX1<3\<
Q2\mE^&$r%n2:Z(Qa,)b!reb:aA#DmW12S.;-J:%?nX+NZ*Q9fff5&g4tD`NQ(Eh*9rX0%BU
W:4l/<u/u5Da6?gcqpBGFI,O<3e:BAOq`L"$SKI,q'fk$g!jtlO.e(sR7_rXLeadZ6696B(^
n%B%i<oh!'9kiO^NEOD"<pW7B<%+l'WQ'.#00$OQ:@;*4>3*`a6BYL"dZn;6p]AfT=CP+<T:u
>V%=RJ`N%nV64[`ef8Zkdm/sA_1GYVb]A+;:(-rA.?+C?6.C2j+d^<3Es*?tp+d8D"df,s?=P
f_7)U2oesfR[]A^9aZ:mE269*<=KWNR!]A:U."%4Va&qfO<B$/u[m9f/.3P-fD6KbO(G??sHi>
3GcPMsmYZ",4OTQ:T/7*j+fEnNtiD-nc[S!N@g'NS`Ab-VT=X6*5Zub[G2CTN#bc16U3:t@0
Jt(Erf;Wkc[Os^bZ+_Yf=&BGW)=%t^RMoOM+=i&r]AOLerr<[^TZu?FrUd?(Qg?ru.'K="XTN
ZGtCk*jC<bUA,6JGnS/&joLJIc;^'UcKa[$"3j7YT8[N)[M`n5i6qWA;?em<V=/2i-(k*Hf[
q&g`NT-IZVspUG_^g9]AH,:ahS"J>=FJqZur4^</+8jHgc$PG+s8i3sgd'gVO!3Fs@.5B)2L;
mLa2YN*XKVW\i7Zc_L(IW#M+VlX5lOk:C.SDri*7B'4Fj$/6RSup#0:lVa>#%FVn^(:-?jf?
ajA@N!#_CDh?PnVD=flGpa94$Q4LfT\;ST447:`g0(^nk+?p*gA.@N&T_m[MZ^U`]AN2KenW/
\64o`ga?%sH>Q[O,h+6KI&cY;e*?SS=Q='-%i=B*ah)(;(o*_QTB7!_Q[FY0d?Gu`*JZgW/X
=>L4bFG?IZ3`?JFm]Ad[Ru_M0+7f=2/'Er]A*FT>FlIaN]A66=dQu#DH7^b(Y<ql^;="]A"^[^#q
Z)XNV[q4_C*E;%D-k,/Dmd9D]A(iQi2eXd)cs8ea`4bTcCNdQ4&28hieuY48AGr4SNMfY=6Am
)&PfSFQpdp.)X=pAg$a/hl&Hdu_dNp]A?;?)@/s@`&8HS>i]AT)gWE>r*Lku67kl,@DCd0Q.Rd
6Qlkrc+[pf94&/oX*%(I@J7_*_="isI\JV5>Tqr3hjh!CNuPD*N#PI:1(i%^8M.FM#Cg)VG#
KJEH=V'Cmd;1V-58C&;.dH,Ft*tH@C)]AR@Y27VFc<i;5KN!7.P@^W]A[%]Ah]AC]AOF"D0anBnGE
A=Iklk\0iNp,[T'7REN(LC$!1cniU2tj-OZ:m6E=ds^A4=OhP5G_frgOkYOut63W3onOXG0[
$q;+q/0ruVu2HUb0'H%-MS]A!<Qlt`r8h;,:%9G;'fWY2VA8oc(mHbe&P7FDQt(T29LbL.T<[
?p)J#ii9oD(e('1m=2`mc0-.j]A=4\(>hh$rLjuL]A@$^*9;16gHAlj(>kM?(olj(SS]A2Pkfs>
GnfISG%12=$.k3Se$n3#8@M`Q<@>,=9XOT]A(rMs9$V;m'VL4p0TIM&Ybo2+'<R@aXne'%(CD
]A9&"*:k!he%=mnsU:G#c6De"tR7'>h>)na7lRY!N>Ag_o+BYJ+'O0rRQ<nVQI,f6I1JgDKVa
9,'*3jE0Hhrfa3FX92NpOcO%WhE/m^5NM.n*g/Cerk'"9gaMof!P0*X,nXce_U)c0t2;e:A?
d1VZaO(i$[,+Vu(&PMu)nOSe6>@hr447@Ndt,X2>.PjI6LFWD!EZI+*<<%d"Zn5GSgGNPHZp
Ta$+HKOG+m0\=kE*:#>EsT252k0Q=r(itW[9^:S`5DKL_*i_L]AG!QgKMS9?%o'SW<B>-5;(5
1.i`iLb4FV%?>Cu(]A5Pb"eEG*Jh-h/#X*-0FSB^WA'_>;u)3jHl$AYNk6(HL8j!RU7HC(Lhq
KgHm!4bP<F:hPSQ:B5!PD%\(76)\^Ori+rMRND\??L&c$^cDb5_dkCnDRhIX\*J'V-/FN&-"
E[YI3/OhhI%F&(4!7:mFNH;AY;cX-"au7\&"9V\5>hogO8IlnX%Uef8%#Qc[\-^dnRP]A0:o[
pf8Ge.!A<*grYE#/!K#"9lr+Zn=&tf9ZIWpld72/n#jMqcMhjTDjk9ONkBh-g/=gr&RkSA5S
+[R9"WfmjqcIhlT^:L#,ZY/RS"eZSVs`N9gN4Y&.=:?9$ubfYB1[`Gf)V`N_+f7[q-GN3Nnq
sGn''2=VJ'Wc"!`)O)trC-98XHCj`R)F#.IUeN@j"@_OVJ[b>I"+WMSdNATT68KJcUYj^\(_
)(-J=duhfn6^=&k_OKn%"h%E;I$?K<4Crf4c*pKTL*GRmcKHI&2P!\-U:S7j++9foj+9agV'
j71g;8S//eH_tAUEurm=L4uIp%iLJR*uFc]AOu?_-IGAA9$H@/(f&L#Tk\Oes(o="%E/K/l+b
mO3lN4U*GfPaX6=INe$)*`YZ$tK>0gP+E!mh\k[^d=,L3nDRJWBQq.r!FLc(CY:I8DJ_SB%]A
:-7A9nB5[b&H(cMaVO`q41WYe^,/X-?;]ABWJ,?uW8\Y$nc/iaBcL4b8FfqIp"8c[e3d8a7hA
rr:r2L)+JK9sD:%oJ*/2[a(+h`]A/M*e;\PC.1qHmHQUf9DTKJ1fm-lbMF7)P*aS,&b>W8JM9
5QWqW6q>nq)*C>)KICMU[K<$@oh.`o1eDNH"Yp^"3A-p.<5b6%T:#o50P8`X2%??"Bhkj18u
*35i1XD9hPfEN(Aii+5\AsVFYXJr^%Qp!jZ-Aiq#q>"qFeu`LljNt"[IF&k"2B$VB^>Wk=2u
%*::=#Yf^hFKgj[(\h]A`lZ18W0b-PE3>L6;XS-Mt[GtAkkEnAo!\e<pq-U%SBArl1Ie;"u=J
`E1<d?,n)-h`e?o!DR*jT'L6]ACkW)Sc;P"d=g\aj^UFqq(e-1cO?V*$BAS3.t]A$S6Jb6_(D=
dUFo'QXM8eU]Arg`HU7#*TbD9hqQ/dAHs_\u\iZj/hY?-N]AHMn)Y^.X%HNKdcQW#leKGn\CKP
/[uGai4:W:s$61mJ$*/Wfmg[6?iLK~
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
<WidgetID widgetID="ca3158b5-101d-49ff-9060-60e5129de432"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<![CDATA[1448640,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[152400,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="4" s="0">
<O>
<![CDATA[说明]]></O>
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
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G-C;eMDndq@sQ;g#]AqC/lD*nlVHab%McG!(i_`6N%Y_Up[7gFS(]A/'dF9CR#n\_JlNpS9$
rrda\[Xn"iaG7&P.)G,oSY'0YgL=WJ27!J<U0L6@R_'W@c#0oU\/a[o4FD&-">=Hd?p(H-^c
^qgHT`8aEA)T:#LD84^hoQP3H6&eab6Hq;>Rl[JOEqEIIW?VCn8aZAt_Wg34Hd_;4:G&K6d:
t@s85\iCR=l#^Bqs6Ng\Q]A]A9OJQbt\nM+>N[NfKHOi)/F%J5RD1"),l.Jp$^QcCAqoEWdFk#
jHosj(=>2DJc()b%6MXWT&<ltn]A[YPSERR`<Gn*]ASW;(p%e)"U_U7It+'=dA&@!j>H4^M?<D
.m2>L-,a)"[rX%MN>sk$q$5Z$Isg6FV^1;gl&9J%CVBP4hXk<dE%37?\TbPa\CkGBF_5XFGu
#=pi=*XmpN`,dH0nQEYG[dL_#(KeQ?UN+Asu9CZVX%J\R3s2Ki\d4'?)3%Q>!=o\")j9^1L>
4hj.V[KLou2A-q\McDQKXhX6a_3nc,o/3P;M4^o$3s5LA4eTgALMMSW$(Wp]ADMcQMm'h2_r@
Q*Lb<&62f;EOPhT.<4B4\\[VD2c9dU_RU6QQ1\d(]A&nm*0]AFV[/;938a-T1D=dq5\NGe_`E<
*YD]AeF^#4=tUojf97D#X^ho@r>&,1Z$8D&:TWr\g2no#1P[)YJi"l:^DaC.Aqq1n>8[RZh.S
`O,OK):)pll7WY;XY60SaIG#Bc-]A9Do065P]As@:.;dL?cU$cs/TaM>NhY,%ml<R`9V_W6h]A<
g[.[ICBFK=XTO=LB_@XJ1`\9d-bOL>n=nMXS8gYOcD3X,Z4DnS]A9se\ZLU6'8C"Us>8G3kVc
s8hptrb+'dUX)"Db(0CK,k.#b]AlLl#`fKJT]A.NPg_[*_q"-Dg_]A5;$;72HK$"KSL?)YbT7r[
n7o.s0uJ$B(L1s8W\("'tug]A'H]ADcq74*(U"-lmTZ^-7il)5C81Bb*h6SL*bJ@Bj7IofRqAn
+/.X;fo:q<J*BhOK*<S-.&c!7..Qa?Eeoo7&>Y^"@>QV$HjL'(X5[KtU![=UO/7Z3&tTBGJB
@Ya3[b^#).k=3?:+MMF\AUn9;P7W/AlCXl+<=bg4&0R!qmDsV/=kcmGlqiOu7OBB"'dG&,o?
knlgQe\t%,Qau3nMGcQ`5eKb=)l?\?^HaN+Tk:FaHdj)N**aZb,^H;&K<3L<oa*3$/'J=cd8
1$bPMl0"E>=l'EXj-VmLh3@m*fmp/8^]ApEFap!RAX]A#_2CfD;R/B.SW_la-=71mWPiD?f)e5
!7MD,_j&-Kt*57a6mFQ91KF*khDXC*YS52I=4SWZZSaBkjb&aAab$(l/q_>1Q#+0m7[&9WqW
BEW*^NO&UYp0J'6&C9d$r@:pr)CJ+RU?+9/TZgo+S;^@-rC-ZcI_4sA^-jM)#qXZW%ff1:+K
3_t2Fo$or@agJg18NTgKELBgTCNDhVIe%i$,Y#Itk1=W?SM1n8JA]A/HdW]Aok6(`54(W38=6n
^&OmYcm(Ks;]A9"GeMQf"fo)42XN4(Yal`R!f9qpe8aYQpnhFHnPo9=Nh<Kd;*[cXMa(#%p5d
t)\RI",eI=I16M12?eZn$fUJB`#E/)r<Cbli*L]A2L,d=^kOd3OW;[#4JmNYKkKA)(+l$+T5V
7iaUd)&d=MrhJQ#kH51cEj5>:#=[]ApPiSZYOBA[a1in;k7@?,/.[3dHN+Mrgg.5Z!?_1&KWQ
h5RF^KuEcEMa;?"?Yq:7.0H[!CAc+/.$,KV&mn;d7k;gH1NTOlq0(Z%0k.AOGIR("f!<)Y%O
rtQ":b]AKC=E%@n/LV;-\jDsQBkh+:7),`qAQ!:[QL-@lA$nMqbh>GtJka=Ym=8WW"?q&YP/A
c;RiT5a]AY1P.FeJfkWkh!9ge*dB4'U1AE_L2*)Igf)n7[*,d\ekk]A-jDkYUc3*"PN*F_@U::
2$.c@N*ekK6`&;@qB\(7Y04?6LSA9443r9dC"Lgmk[U4:ePkl>dcdE8</=WB-ePD.`#s6OWe
_K8Da<#d/qR,cEeTJ`^8Eq;6#o3j/dqQn)I&3_Wg[G:7)bR5o"Qm&^mV0B)*K@uU%HB9m!K'
)K2ZAFW<`b7]AC]Ai@^'Ypo@W7Jcdj]A2@CmK2LIR)soM1$4c]Ael(cgD$?,u+U%4dnam6^K"/35
UT.N(Ubp';"EGb)))W^fh<,?W1H(IDS!`j;rP6*-fWgN8-NS+c[sQM8!R(40D6cBVNH\k$/C
96nVFF]A%3MS?-1Y,@u]A&Ur2#g\*dp_:\d4q6Zc&S%I;I\C+:XR1q^G%NKOXR`fBq5Y`'Uh??
Gb@_M!N%0s]A]AiB'5"dj1)9kL@aRBm/<d4V!4[2L$C-3cSa>pn"%F)TsYO02F!U_CR.E/.n)9
NAt%%\BmuGB:tuXd9*U*ZdY1Z!Z#t#2X;H84N4jLAO,(@rm^.Na9XdF!aC9I0`Sa^u;,(Y+=
!(+CP37[,.MF=fb^G3#_-%$T(rtl/!S+#s;j%kQ25<'=-P=[11EK,TS4&^qaC>I%$_c&"PR.
bKV\W1q[]A5>XXRgiE<]Ad.7j<0O927^+Su-qbXS!6`NU$qVNuWWLEEh4\O,ILFms2CROi0K9h
E`HEV6H?GDu3Z]At;IN-V$Z4g^2hF;LKJC?<er'*Vai_>GtK_$A]A!;UVkb-k&g"m[/0h)m>iG
\N8YZq3Ga7SFMs7-+5RJd,ri[C#8eOg4e/]ALF#g(7qk+*d*"k1^/hB=S9_@$D`@t;\(o5c=*
1cR0nm(nj\-G)Z]AhJDT\;;*Y`:T>BS>u#K!q-Ar$<$Tp+@BU-(6ZQZ,!D^+nD4U=Tn6`ELWS
%a`%H"!h0(S]A\[1KZSD-)#.a\bE6RYJZb_Lb$Jr1^6`ZX#?)r;;H5pt,p_T)P<7$A+tk$J30
bJ"+s@W=;n_#opZ'#(pi>;->Q+NU'EVX*Rm?pD$#JWI$.LBr,Ld%t9r^!?j7KM2g*_VoNU\U
pFGN/pb`GBMJX&uN`,"&mo,.#.=7mj;'&^bL<=<(Z=_.5#7j>tT@N;OhPqM@frc2oT0(K]A8E
PldYI)gnQt&Q(<GG&;HNU6G^l`1-6Ue&N+!Z.l@IN0a<,M%h<DtPGK<n90/jYlG1b>+-'c$o
FZ/EW6I$nO/)13Z3qNO>ms8=`(eFfm":;a'5j("g]A!_8K3=1m<9R`7fr\(Pq)X05_HZ')%9s
#P/>GBOeVeptJXa!Ql$t!0\?Q_&f^UsVHY.8ah8Y>oF\C8qnD8ZX)Elf=C2j^L1Mi/Yh-n`1
Cl=OcYdELa10*OSfZ@SGda@#f.1FH=`L2:?^q6)t!j5HO:6,,UH\pp^?d"$7ckMt"A-8NSaO
P?H@oa3+WX<.gA57+LcOW>J^-,b><TBW<cKu]A=k.7HocOU,UTBnE/UHuj[W*#*0ejd$ooOYn
pM.bG!ZnAb$C?:l_F;Z8c4<N=k20&uYXsD;CN=kaaS0SB?#=8%@s/7!kUno>`r>Io/I!3"oc
Z2]A"3qsY#2?Frt!e?c/YM>Q*m0EG1c;UCcOcX&IkWp&Wj_P(E"E'31N?@'26hqYj[?Smrj3k
biEFGad[jS+!"Eaj>2A#?+&NXZsIdFgrLXD]AXDXCI1oRV(b%4Ftd'oCit"\'IpKt%nqOX$jD
'%3>HQkJ?0OuV.JV$M]AA#rF2\*DP;hSjPB,eugmYU4Zh'R0jA*mbV$DdCdO&laAoeSfIL;gc
I"9)uM\L@SUsPf#"r&^"SS[kom_?FNU/#f!Le8PtjU?d&f0kq4i5BOisloC&tuhg*a/:pnQ[
:K*N$@\q7kTm'IJ?dZsV$_F&KbG440+\,Q]ABp"^i3&++"H30a6Z2]A'_d7&QobH0a3=9/;fBB
;$c2'<:80ZAurf.F$KY!H(K&U\RMf#AttR"hQJWWd4b/5MR/(SMW:"BpcL6gV)0q5urT##5T
\/T2^Xdq*Kq'Lg=ji:t0WVL!Sao!NM%j8P@qpouZ2'CsX>rqP1V\Wu?o#hfr&tM2?0/b]A+)=
#ELm8<2-WS;\aBBTC,J"T7Aa#o5J^er;WG3Xe6Nr&Bb;tDNi5Fg1O.1OQ8!";Q+J.Ud=@.5I
uhF6QVp<?AB]AS@a7p'@i+c0MP:'IlQuXk$tFCI8H/K/U4S1>6WEu^LYr]A;U_,aaip"F)f_Ib
Fpok(G^]AGgi]AL%b^GGi/*X!rd/fDqm]ASBA4/l\aL*jg<L0Y&Y$qYT:>*Ngl`1<GXHc'dNs6i
YPF/Er57W%ZoN95?k"UE<JS_]A1t2#$TLA@'lASOeN,ScfF,koq`_9nW21W=,(#W4.Zq1d)2k
_cI8ug(m*27AhS=kRX2N_$9L`GB!5<NTQ@81i#C8<>5J)'t)rOh=/X^N'+c55%<>lfLUG'G)
E)oXA"*=_Yl:3I'jkSuD:)J-q?E>"!qjuPPUa!A=&4-lI1H:/kfe=/p(hSV3kng+9Par\,[m
91p.P\n^YChEJg4so?(F0kk^m`/`n/V]A%JmD/S=MG>jCn)%@]ALL42AE8Wk*?k8@W%nVSifYY
k@=8EP*$m7,H?4<Ehpnq;-?V0Lka8`n.u-i]A\#O['?K!O>k:$k(c?JXE7o`Yh-m8;+a.]APMR
B8b6#Aeoc!Zi5"+9^ng4<e(3mC+c7o&`&YDD2]A>]AT]A-4C\^[+G>GC9khgBVMTO^Z2C[q26`<
+8HFRE<X4A@5/:WYn.Ga9M^]Ai-lq9YX@mAPeo^%k%P4P*JU<%brW4sUihjD0aG4$c"Q;NP97
n!FTUb+n&K]A,DXu9Q6QnTl!367B"U0N+$,@DYE91=DU=t32G'UfiB!!@-c+&.:M-R#GR,k\V
=NF4G^Y$k3Xm8/U>N,R$5ne5.@34_ZK"d8rB>,3NM0\%7o#sN6X6Hal9FQ']A:Q>EbetJQ;0Y
D3q'j;?u!8e*qCp_AgU*\kkdGH$C]AP%1Q@lf17?/VQ![oh1N."FTLk=gb&AcRr[8<#[IY04;
ZrH&Om4F>Z\%W,!mLcun'[_OGU*^p*="dWg:%XpfoWY9)'Op?g1ZMcO2<)b[p(E,Jhp8C-5r
A1#!@>K?<g3uPgX%bPNPD=i4UB$-Fl2+.P.0LCC3oKB>N_Lgjm@ERoHiIW)``"s13IsK(,#[
#fCAI3t2tNV0kR#YT!bXdD*=5eOahlAd>Ob7-=Nkg>W>E]A^8;9]A8=f`TQ^g\8JMYSg'3876.
pH1rRm--LC;q!;%-Tk+=._-[18n?;,,W#'+TsNeLYA]AE;J'<5kA"u/K6,+n=ucFg!LYE^9#G
'&3c/J)te#3Z5bu>5bsV;*L9=6T4&"QH=`VHK,X8<2j1]A_SbPb;)'lF1GaD)6HisKBDueBs&
c2a)YidR/>ud`e5jgPD(^UGn+D?8h7+?M/D^u+KWsfdBa5EWqBqA\fTo3p5ep@m-j_6$cFd4
Vu-UYWnnSf>8&IG.3N"eC\B>6&%]Aj?/%rMl=D^A73s!W~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="82" y="548" width="751" height="86"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report0_c_c"/>
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
<WidgetName name="report0_c_c"/>
<WidgetID widgetID="be56ac11-b658-428e-8742-d9ad3dcfc26b"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<![CDATA[274320,5974080,2164080,3230880,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="3" s="1">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=left($rq, 4) + "年度累计人均投入工时排名"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="2">
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
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<j7_;cgQE@kWl8#Y494=)qn$[AH3HW!J'PXTGW'8BnDk88=pX"c.a;JQurl@OGQ`2Bq7G!`
`^3,"/t46<%]Ao#pEQ<Lk,\f+Wul.K\S6XCc]A?,S^%pmqUB.QlP0B7kAdW;p=a;1n+XQb[haG
,Bk-5j<u/M*D;)AMn%Z@*K5&e@Jkqm0_M1:h%0"EdH#G'*RmpQSrn;QMR75"VU=@&_)J2mng
+0AgFoV1\3naPJ&i`$2`/['!ioE7)^?P$ZP.p&PNMtj37pg+YJ*Fjn1"FBqII`i'i:39gPpJ
6Khh2(5c2FmXnfE^9<+n/U8f44T!Qot(E\lX8441QMX9,dkd$EJXq+sS0C&/aunWqkIMaE"*
V@I^WefWP>C(MOXja[f]A^0\c`Ok<[srhp^b3,SD7lT]AO,$F]AF"@5RTJYCA<,BmN]A\q`/tom;
(+R@b)q,eFl7Bl8m^d<U-?[=>[t'L&]AX\hUr^:(]A,`s:r'%3MQN2-?'Gh$]A#0dr4iQC&4Al.
T)V&E+=8F+Lh)5MMmb"OfC>2gi'h<W!+#^;eR+g>5.;4iKQQE<oA0$noRNc_Lh"%7,[WIFBk
aXOo;u.TTOUP[V8k,eO-g._NcP*>8LfLhNX<A#*Y1eL%7ks/bHhuc[nJAV1ME?1rHb'Bhr@i
<LqVn0d+^8t]AbG)e@P)Cl/cpH=VSlJXfJpd58n5\UIJ9)'/YZ^+2Q0E#r7C18j:gMX/q,,r"
LC3brC/jo%ZT#023oAc&.O6E^&;cUJr9YruRZs71ET.Nk!&mjg@KUN<E_-[:HWO?-9:GO"#I
7#nG\9e\+e."hnTE#i4:.<gdJ$t5`a@0k"T_on?erh`5+d*D*I"q<Y\&8HH*N=[)Zhpuo"(p
$_TR73mcC7B8;5h4Hj0(=CreNY@:-Md*9^r++1ml?mkj^.7F.(O&7#g/Vs,(-'sZ"aMK@2?'
SupIjs</"Mc.fs0o)5[9jPm!$7(CD:'/cQcW+[]AYot$k^UTJP[Ug%>F_nh_^8;.>-H?Za-QU
l2YtE'GLet-H(4hs\,GqO"ZA-mEJo?+*FeQc'gYLY1=R',W#7pL#pNa[4_nJk"+O!uMo_6m8
X)@cr2Z@PZcgrUsD.JVMh"&#tV&!Ch-]A8J22W#n?I_;'$jT0\M[DMO:n6IN'h%W`2lmBEG<2
1u<=Pf2NUY61W5E^o>8?2#2FY;`u#)bZ#/U""#VdU3.Crp<o`/,r$,4m^t$mk*0a17.GXHg)
4kOiST2OVr)Gdp/B3Op78Q6f^=>cDD%0+'8o^F87mq?^fm&ocY_;A'kPNRQ/fs#mm.YO@Ml8
d>;V%#"f7_%LTYOq\=hd(_`Q'sj!%I/nGmJ40<&C[4d4^E[>dZ[bP\9f-TlHM]A't!os$<0>'
%WE,#CD6)P'/E#7GQA,D.b2Yh`*D?(4Fd8eW!%pba)0=44O66N)&f'0^MCm$?ZZ;2!1`\W'!
iq[']AhA?XPU%f2c2NJWfMshNB@@kOL#R^3s0>['_3C/r2'(tN:8WFcb,%LaM#2WL*m`cpb>1
OcKhdEjN$.2M#K^V=gJY^hN.XSS"Ob$J>;[:6oA7'RpA*`!DUmA-M'!nL\`$O/8Q(/Ys9MS"
iT!=1,<+-Z,$mGUK7^7hl!%Zbp1lq.ss-.2*gI>2q,T@t3D]A!e^hki]A;368GQ'sa'q9>Z-o2
V3bXR@[I-7Y^K[A/KNq3mc0-G+DRajG5]AXZrq"6cK92==B.^AY/b`6`>7I70B?$Q(CXn"(MS
(3`&Vj6H]Ab=c3Ga0=dKI0O(riR)%Vl=BS3HsaFMG.R8%C$DBH^jB@&**V8H/rJaq78N7^$B8
?Ae+2=CY:B(=[@Y>p5OsUWtI.[\a*6<[G"%l,B__X@a<<7[?,mehO:eVK?cQMQ&N$=LOP`.n
</T(]A\knkU]AKCOPQ&h1lEj97K&gqT_.4Lg+%TJHo"c!!IRf<SRFduhipgNRUI:4]A"VLZI.`t
XnAqOQN:!"Pp^]AhB7>8e9*E=b@?Ql+JgE"9Sp(c+o.uBbH,@JR,*`fA@LY8UiS[Ak5E2\h2e
IH<km0U98n]Am(1!asrQs-:tbp8"g'"5!/T/.LQpX]A\B<-cKQEX/*fI[-#+7<,LgPb&gX9lKQ
t`Al/^Z&_DKS3$.]A;"?.JQVS75BeZ.-Eq*HPn`fFp\R<9s.::H[<&sa(*LRL?7U:HoG4U<,+
,H#o\6=8Je$':2>b=M+SSH1NPo(s*0;,iinRZi<leC^LuGa``VS%m'qD9l+0C2+8\;RqSd!r
)tH.,`9fVHV3ToHC1rfV[*NG7W[*I7)D2(AG%'`br7W_d/d_A@Io%WNa)(@=Dqb]APjE1^G;U
tSZ"bMYDIFa'Ab#N;dp$E(Gms&OToF<[K9Qq9(,'4A1]AVD`Krt['duJHe%40mMTimD8,4J=_
*ZjF2=Co/A-4,dIPP3=1>3ei=6j=0RE/F*q,=u6r%P670?Pf+SW+2E?E'D&Vh0"dpRiI!UiE
lZP:NX*Od$&m&:uYr#T"bHh;ter/nagqd,e_"U$^dY1%bu76cN(R@rU-;M27eTHYAfO]Af9e[
TS_5O-,Xk#E"VgQ1dok0CX>X-QB@P]A'a\Nm<dN1+RLopeBm5;ZKCIlffo)C6=lGa]Ad=sB&7t
2"l-%'p[l,X2l.MnS:O$Zit[Q)K>@d/LOe-"-TGa.8"LWOb.Rl\]A<#7\\m@8<fC'\(Jupp//
l=l/SB!I>k=C[Im_L1NUs]AUsQ!GE*X>N983PmU2$>@nKa8\=AJo**(!Vo[ObiOmVED8VI\Y(
(E5>FgKWe*]A,I\,b9'hc)gbiaDZ3`$>$RfbW8//@[uRG[Bh!LEQFM-kFeY&9jc3aSO:QNQ]A&
%'XC9]AT@.Sn.)BiJMW-n^&h^t/V7k+(DmR`Y!>jFBBP-#FCX3+>8H:_&8e7]A\S!E=mF]AdMNc
@REDc`KCqaV*27u!]Ad+sVVIADO[suoiV`2?GM36IJ$nV>YV:UDaq)\Xp6Sgm">cOdE>WiNdr
^j'\jk!3^Y=mM$*%Od4&RQqDt$6C5[n*!Fag.URjcrB&qJ..'pY/Nl300:U_lF&ZFgOf*C^E
+/VaB="Hb)DKbkD[n$D!jk0V/VVF%gcgdF$75SZ,lj>>G&eXZ4f4O<Nle0u-oM?^c;0daUuE
L*YO'Wuh2kPG<qUB6fUmbMqU:@?fu$]Ak#Y3eDN;mKQ5).lmnn`$F:;dZ%h;Rd59kn@iO7reG
$bBq$4"S`8_;gt$iu^BD]A[6R_WTN+'o/A!-tRQdm3*>uTDfEj%T\:*iE*hmM.MpL]ArG1(kLb
rDhhhSAshJgF-27ai,P98,D'eq^,V)]A?;9\/CV"m]A=A#!0n*mQGC\TsLndRA0Kn*r&l&bn$n
hn`P?rTu0uFZm_miDZ&0&Y(6.,-$]A!5=2GViaE:\!.KE:V2K7^Ds03/gqihU,;+g[Z`Z6--4
gg3=%kYka$mSp;ks!-Oi(,d2H%/CSb&^CX]A0X>UImoj=u1[HVRneC9/5^;6*+q,'Tb<C!<&2
I$E'S<TbiUK3h@mA7<=q)$s,S)2XjUNJY@&(<ApeT(=VlC%?tQdk]AU2D9SfTO<">P(#G2R#B
Y$p[!*6]ACf-Skq%uT_N>a4<NP5h(Cp9S3-Qj"`4On]A*7E&kCa$`297tf=Aad%-/+p)B"`9kM
LVoCL9+4?Y2@Z]A('g![,\[$-sj1DJYqZ@dj/6bnH79=PaOt,ZdB58.[bQZkuINEs@IRFf<>j
>qaIkm(I?E$X-iFAFlG4C]A:q$pV)YNC3m<FCEh'6=O#-t#$'gU\mR[SDeWXWqDgs7U^7kcpU
lmUrc*SR)#c5rUU'K*fl5>;k7-/0F#@e_)*b&,V8.(WJKQ&Y4KuNZm1]AoT[TN5?Je"JauK2D
WfSsct@S=cVU$0b/+!5%qAOrD5eN[0I,m*/(67l2,G._b\gC?-;#EWeC[rlZm<V>NG3T!$22
DKeD.(T6/\aY3I,r.T"-friubmuUFamaVtUWQ]A41=Vk2NG/`-TWP;GM^j1sB*V6lGrK+CR:E
qTt\&m%lOeHjf/M.=@DJ^!PPR3F&:28(2"s2\C!BCdWWPF2XZ64"J(&:Y'2I:9.FUmL,rg*S
"QNF5$I:_*hCWF(#5kAO4u5/E$G5gjfQW',1+aLLYpm)fE"tAU4!"X$2U<h@3eZDQ.9K'SM;
Qf9Om-,Me"/&Cp8IN+Fg%.t.3(-arK*O'K.,/p7A<G\(TAjfiE]A'1jAqH_b&/0Vsb7e4g34A
n!%,W,aU9mf>E0N!?)WLU+@LJH%N5[[@LMPU0k%]AToM/<T-`*.@t?dLP*3p@cn;5U#k#UfkG
;k/dm.PrSDYh"V:IWQR'seA\+?Q.uSTDT*AB&bK)>X-riT(b?QDtQ+-L`h_6?u/E6V#2TQ6)
@q&&e-e7J+26'$K0^D(qrm&CP"6p'EX23As.lI`2Uj_]AYmr?#sReGPXCf7AYM3'F9W>jMeGH
u50F=ZpLg?I7.Fa=WQ[r<UEDBPEVdPmFk.qW)dWN?*MP?rgb*Z6R(E_$&h,eK`2[%qd_S%72
?Q"]ATI8b#+8:kuNi,i;6%,3X,54'_%Ji+!FM`6SMtO!.G(?QR`>:p#DGeXXlb)'e6_L*ONZ@
?jHds)b3;V1$Fjk>;^6!M+A?e<(bbn(tW<<%.*i<0$ak),C4^`!CGeP=Wp04)\0%6`G5]AqJ`
6#EZ)"CQu6a]A$>iJf'"PBR1aAC>#&VbXU-"!:N?^.$So/@PgD<Y[85K'!2/;e"m6Z,ZB6[jH
oc]Aa@_$a'37(ujKH4`0G%uk<G<dNZ[(j8(FBT%aAW(cRd4[\g[.o\^J_]A$50*@6-'HP'@cYm
j+4Ck3l]AnM4)u,/-16QY1YPF@U\cR3/W&8+U$+5WN8[5<;9&qU><HAOo4G4"1p3pFR/gbL3G
3>ST9pqEV&',DYVFMBM<DI;<ufP.RI'R![#c0Z\G1gsH5mgW=Wkb@ge4mJuL%bX'I1EtTlQk
r0s2*d9d2Kg*Y_4QtHq-en"4ASL:X$f7/QN0__ROi!"bo6gP=SBG368*Wj/rm@eo&.'iI.u+
<pG@:/pkh(YN$/9>l9CT]ARncH1K=`lCt:Ch;YX7]AZ%h9ha4Loa<+47@W*\MSe8c:q0Tgu`BA
LA]AsVlr*eLGYuehOc&U8P_4V.TmJ0ms,/e[Te:8.7Xd,pI=+b2(##$po:k=%Y\rQ1r$9q>>c
Xs#'VMInp;Yq)g2"sCW%\&1NqRM^C)Um!#:11ufb$A*]A^Qi[kOF\U?%/+81d?AEXM?U&O-"n
HOkEm7ULP0UB4J'#+f^/qV5('M'm/)ObCHVgaSCV2gI)_#bMU$KemfA#o8k<]Ac\l+^ZG+!:W
/kc2XJ]Aj.kK+C+QT3g7`$To59$>i5h@?k6[(T9rlNY1?3tb(>OTC_KTri?>--kdTgl't/Ga^
Nu\iQ8BZ)hH'XIiR#HdT9;8:mpi44\fRq[j-urJ1L,2BRbYBl?K?l]AMkb_)/O)\K,O]A7[co5
,m&Jd"-g6D<V\A)U3n3^5L-.RKU!bMjmJYs<ac0"k%-50jq"d5`ds^c-FL?H1*XR4eQFUFi8
7R.]AjHig(3NS/XZ,aR1\-S@.b36l]AjeS3m\^7^9M)[_45/8Oc#BS^SCFJ@>C9!hbs"A%30&h
`^hN->m/tj@mU5iG8s.'o`qW1;qG.\IZ&a6eBTg:f_j1+f%*"T&_[-KA=F1asg+['m/=Jk/i
QSTcp3BMmIA.af3,;jB.jTK<W8\SP@(IDD?SY^u\\`.73b!0nn:oJ_L$i@kB8pKQjN,%PAtt
%gKQZ$[H8toTE2-71^!g4*Ua-5`Q,YZLXIY4Ld13(D5*5IV.>r+6A66cSbl0ZU.U"]A-\+!AU
*GOL69:s`2/T.>S'GSNM]A-.=_1p_1.Pfh79LWnK/b3Kff9/]A#6YAc2kls@D-.A6q0Zln!8)Z
I.L6V45\0Yct52Y5Sc5>oQi(7g9D`RT@NO,Ph*j0j9Q7A-0iBmjE#@$(DuF5m+C4C#G"hh0=
5N5KbC34V!3X*EfrE"f9/Di-r(?FZ"F+K2_nd!=d[]ASX[fYauC[(6!H!&7^!5n`"e#"`?*Wf
01;./B[pF`J_A/??c"lagP^`Dgm#j07:%_?@P/X51Bh3>#1ol8^bX]ANE5/fMh$'/I+Em@9sA
fRSC'`E^]A;Ob/=2/uKb>W?A5XFU<@R:[*>E@]A6a,I3!+W.K3Fn!+@q??@*Q>RsL)brk-!Zla
r2TtZb5OEA2&(gk0?\@0.>(8?QlR31EkV*Ej;TBr-F.5@nT),P!LV-,[a*@5<ds^:=c1<^,U
!_*p@t)#:-Zj4nNoA&TsRnS#A`lZ#`lVD]A=Fi2*j2k=H`jT3BpF'-N=oh^)D!ds(k9;?p!Hq
<i*]Ag[Uh^I/CL+Yg>GY-o8kk$F>uR5s:T)1JI,XK'HP9D@c]AsiOh[GPYS=p9>h)-lg9YKD<W
#198%4JEKgq@C^#qBf\Yb1ihrLmn33,%bT0J]ArS_CnPnq0!G2$k'"=X_q+.,=`?`bbQ5?A^D
;^HNn02I-3@+NWsS/V=0DC07^mKiTC=><W#E(!tM>f6sC'WWl1N.d+7_mX_1sW*Kt/FnmPeJ
`JU3k.D&n[`Tm3AWOF;p.<]Au.InIqV>YDoood+QY$>BB+HOW2E=fRStV32gDNVoYg8.0;a+3
;AT7%8l1@J&QX8UgA+)XXPQ8B$l.?MKs2M,jGfc1O^(T[>m:&HSg)7W8_#!rBMVIi#V7.@bu
*Fnr<c[&17kAl/+P9)S6L_#3_p6`aM`!rB+l-VX^%<5I[hHX3lnPb64RD7_EM\t.#(91NAm\
t2M/B<YB#?%:OK54>"MdRp9BQ3Y+Yib1)Bhk(Tf[kl%07t9K7XHs@"SuIYlnB1dS^%&>4F#/
T7NIPS:mN0+*[%@g`NZlMFN:R7s/rc@h+,_:P%m#IR#E-$")Jqs@fYOekRP\@0HZD>HZ>%a$
hm-)mV1pSRa3c!-g57U['W6)A0bt/AQF!ckrrqI5]AE9>9c,]AW9g>o7@-i2u_/$ahk#/En7FS
eL4p=K+V"#kZ@0"7Dh6"-RE<B(#jA>1<A+=sCP#FjTG4_]A@8In_JkVE8FBjnAL&fCmc!dGgn
F'@_nh_p&cN9QidU%HTn5+/Wp:[jlh+`ejEY?<LH$E;e)74Y\aHFmcb0c*r:S\jteWbhE2Tj
sQEKK,<YH[mRfA&2ZhRgWS`N9o&8A'c]As*42FM?Hh-i$/j!X9OYEsn58uX;Go';n2W/%V9);
ApHNIiYmS@d/E/Ik=1(n[*;#N'Hk$PGTT$=Xsq2V>;8btY&r-oP#s3Y)J4gD.B!+Ho<&(`L"
>GRX6@<TT5I.R/M534_@a;SdO54LH8>Z<Mk[r:o"h%GLR]Ac:LTn@JLAlFK#0duO*T_5f(537
uJ;pd<Dl+9q@^V@Vr**W0SPG>:CqIrE_&#KPAW(_dd/?35^%%14a'jDC:=L:ZP'dXNt_lEee
Y)f4mP,36RHTQpH2&V0ooERsY0Fkp(>890Q)/JfeE5N'3qPBupqO=-^L[g2j]A'O&*IG5+7"U
4enn0>'4CN/RFPJUGtQ$_!#0-2=SM+E/2d#[B]A;_%<90rA*0KpYU#G%qs..HC2f[;C%^9qgU
>_)o1W^_u"[TE-g#62E1=)'KiPj;"_=>Oqsq86K`bNP*9-mEIe:T3A`q6n/]Ak!]A(UolI/ka8
B/jY!]A8W=`#76(B3V8!q\I5$HY+W2[qKt3a;*F.PTT2q%T8\*n8*#aN]AF#qH+Gc8\BQ!qC'F
o_A_):!?HoAHph[o*Nq!NZ-Z9-)7Fir1Fc9l590WF61rgHmOU6e),bcp;g(kRFL@BuI/Xale
Jm)_]A,$T$fER"Gk/m(@I`.#<[NNj5g[><#<qqh-HpLNo^$k<k$'p2ufs>Nn_?3rA#`PW]A*Xh
-e7[pnmp<o<Ve@6$,C5Yl`9^6[U=B4o4d'r8W+NMZ6[?]AQ6'O*9[\&+%_1k8Q4<t/^J&cQs=
2c4X>b4<O+EX^7cshqR^Oh'V.e4U+O`8_ojO5fF"ac9!#@k`At,DR1mNh^ENg\V9SuG(p[*!
m/)ZOR?mRlp##d'F0/74I#.`^$JgHISbI&j([cUr1GU`H8MaXsiE2&mIqcXcRsr[-!qM.%oj
`VpBVL<%/u4C+><I!\?6OZo(:p6Z.mt;]A?$quJ6]A%*"R4AK#FsPk7,)4te0drVk"UtnN=LFt
p'mp74lg(..kusG>m\;Wl18c`;'DL7`XM:X;P'.'D#,Dsn$Y/q.US4\2N]AHb0kEdNmG[R6o[
[-1-l;@9Z,b)Q,Pkcn2+Bkp`I5c"Z,fbUBnbN^HJD!::o`sD6TP]A1_mQ:Q'#ad-f'8!/qX*s
r$Rlq@&1iNHI0Bsa1ntZ+I5<Tkj?1[-J0D:#NRm+mU-_qSG7P1iVQ/%1;--8@SKmR&mM,gt>
Q*<9RNk2C=+0th?e.aGm2+'/p-7`==*$q!>!iI6qHBh,<`Jm\HF"qOf'tI:gDZh.CG,6"WT*
!1M=T/iH!fH`X[!SZe/e4XlQt,m\F`%bNK_B6UaHJ5\5N@V4_ANq2RPhtV/"s.H*&'ci&uLO
Z^HW7&FUpBn`%L=JQi,f.e@TS@FUq1q/8/<@)kKFkT^Q4h"c@%AdCG.G/edLSL8?HG`W.fX!
Q'l$a"KaS4/S.?Dn8:E-$)r8!Wg_-KZRE`_hL3\\:cK`IIKoVjBo6]AGD@XZ;nCBHl)S3!s2\
..(,)CJhkE*7-]A&1Y2<jpJb7Cl<p!jY0?6*s,W>f_/Ok3>NYFk-(EQ`o]AcPrJEig`8G^Z_td
M?i5[R'eH<E]AY&smiY!@X<qk![s:$PJMMu,/%&<mBhC?Z,b-X63Q[8V0p:$D8ONpSJhm88X)
ePP,c4!0L*4I#_XdT_n@8k*3pK!aZ-JY#'hA.ra)>HQh/E--7XST?SkqU0JH7L[#I#&^1)Ec
7I^R&QE9.W1?VbX7Hg?a>JNK89$!hPN]A>b25/6Y3Wf2OA^?dgf/me0:h<:aB3V:%M%H-f'"5
[K_C6WXl]AJ^5$"$BYR!jh!)-?[3Y9n&]AaU]A:TV$pd1hp@u<!imCLg6BZG,(Mh4on7\8i'HKr
tPB=Xq=]A->Q]AHNp8P8B,sJA$V`a$`m8c<%"Jj:O5Kb%D>]A4,#8.go\LX6&?[S?p#I;ck/'PL
q:i"uW8A-L#Zh4#"#V^$`n3n.UmrrU;6`7tXurhcI<O([YCR+?gJYn/GuJI8)h*:lE+n$$Qq
/eE,K"*?k/2$Y3Ge>n)<X,G)"K$7#tB)d'CHO+%h7G(O#&E,fbJ./84=a/U]AcLI,)coojnN"
m__I_ce;LGg'!nW=\5tX,s#f3*YQN=.gA?$C]A8i+u!FCh5C[,)Er4JBbXS<q8m)K,[^Y!rQ0
d@h@n^>u)gi0L98&N$Z'<QWg$:D6^'e6e$2tJ,?=X[Jd$La`j\HeuO*h@9K`.njZ5==p:c.B
OEKh`>GX"h)-$ob:A>f*'dnZVIcr0r'n5)[PN8`cs_>fWq9Fd]Ae9F*h"Z1FDa$_j`3ss0S^Q
d<oBr@X)71EQ86FRqtE.64(ZQCmr]A%p`L_dr>N/XSOQr'LR9'L=lab[NP9nNmB)De)4CjT@"
EH&mW'?B9':Ldm!Q3'`\P=5*cIK=K@o:50=\ZK6a>`B[sH>/=&7]AC*it!5*;]A8udss]AHR!,6
W07HirSG*OA*%"trk-cWO\4233c,;q:d!k+i9b2:P<eY-\.(s]AQXo;$Y>W9*Jd*P,qF,BU2`
n(KWb[$F9JU]A(;(:pcuV#C3oJg3Su$Eq6n"*5Fu-UGBQNBsCj6gSk+dQg';,`59JT$L/L\IK
-[JCDA04tYXe*'p]A5`b/C[,ZWZJF)jsGZ3M'k6'!l<s1dmpJ!)&73WP0Q3d0t+R-]AdeZ#Vi]A
!L2m=r:f8,1DrLb.WP"i3j%W&9f!Xg8/S.*ldkhBr?:#V=K3>)[ag8[s2HI;I[J`L,J_JOG'
7$jlCB$sRLoQrN:\8[.>+c=2u;a/k7@gD&*HBldqbd)VY,Hq#lML6&E2(AL<gj1N"V#YX^Y!
Gqk35B%i&:r"bXDl_.XTOasWo1oZ\]AO5(2&D1D^,U=u\?6E>&*gXR@Po3-=6^g;W6+khp-3`
g/lI[OGnfrh.YUHRP`C#*o`q?V5hU7lNKcr<odWL<mD3$Z.\g9'8O/^!iY8QdNl>*]A+UkRuB
g;RT8D-D$h<[JmJNV+_R>`1O1WlgCef;+,!mF(Z^HqBZe@\b8C@9Op)XG#+(YUmhZQNmW<_!
?m[;T`(tkfeC)Oa-eFbNL-QQUGR:`QLJF>3<mLM84q&?*I'$@Hi#KSFLr/F78u_Ou"q]ApYS"
MQN"IWuMf9Ft7\?t3U=iMe()nt`"KF"r',(NqX(^Q#^]A22YM!"^@EcOLQ"9#`1I>igkkZpA4
9[.af,oW;Jj7K.uO.gFTRCGfdG684#]A%p,a_6&juI)^1qIS",]AF$'aV<4[FiP*AM/5TQ)![1
ubEm>C5Ur'e+`H[06S-nA3Jk(!'k<V5JFU>U,qI^;4h/3h1Z5n#"d7$tqV]A@tEdL+^Br*&[o
S&[SBtc.:)UB]A#lYdUTH>S+!::iRPd'^-eYXP4>+)+B2rb6a)9Mh^]A]AD7LS>I9TR?qJDG31r
JJgi6'sqtQ<'=6eSLRe@k"E,_18<14FWkRSmW=ZI.>l^rY53^X*"0sjl!lM;YMfnKbZ;clcA
&D&A2/q7G[Q2YEoHLpUT@NKJ>T'uXFc1U=?BQ`PF>nCb+egtJ%0YM>9o8\6pP>nCCMQ(r-J5
0fu.P#)Wf%K>8X$^d`=XKBZ^$BTnDBiA"\")cO'pn=69d'd>pdUc'1J(C61NK@8UDQ7j(qJ'
R:<c"ZrK8D0#U:GKF@'nn4shr-J6)FkHYBEnKbrCX\[+nhgXp9/YaTT00P1%Uq@QT&nGf#V^
JG.+'ZI#ONG,h-aHa=gAGi+N@($;"Xp#\K'bkK]AY9H[m\-l>S<^[$OE%7s5?13i+SHBHA0#-
cqnCIoio]A8/fs]As_oP_kja%%<pc0X(e&aBa'%+[8MCof-'_?4+MZ\i-[UUG9Lk9"L8u-K$4q
AR9AulplaE$Of!?8,XZH*4Ca$S`!#?akRhdAHLic&J>*<W1[i$li4A\!;YjW;aR*UgA%]A!0A
IJfQ4R@?0CF+?g66ZHnUeBnJ>f.s(7ubE-EOBU,YOcM"+80m2j]AMiYQ$%VN"%^9AR;i;5&:Y
]A;@i;nSF-3;WoERsmhaf5_l4`Ig-O7HSTCa>,YU:Tf=28GO-`!fRoQ%l:ZM1nBeO%Sm3,]AH=
k-m?Ml[qXf7;~
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
<WidgetID widgetID="be56ac11-b658-428e-8742-d9ad3dcfc26b"/>
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
<![CDATA[1463040,723900,1295400,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[274320,5974080,2164080,3230880,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="3" s="1">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=$bm + "工时投入趋势"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" rs="4" s="2">
<O t="DSColumn">
<Attributes dsName="指标" columnName="人均投入工时"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="2" s="5">
<O>
<![CDATA[同      比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="6">
<O t="DSColumn">
<Attributes dsName="指标" columnName="人均投入工时同比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="0" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="3" s="5">
<O>
<![CDATA[环      比 ]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="6">
<O t="DSColumn">
<Attributes dsName="指标" columnName="人均投入工时环比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="0" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="4" s="5">
<O>
<![CDATA[年度累计 ]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" s="7">
<O t="DSColumn">
<Attributes dsName="指标" columnName="累计人均投入工时"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="0" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="5" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5" s="4">
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
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="0" size="144" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="72" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="0" size="72" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<j1]AP@qV<D+?\=$<%t]A"isB>;Ss-4$F1u,Z"Ol+U*q-WC(X9>Q37L;+W9U_-pjpN,8*O9O]A
X2t73Q8A:a1H9asmIL(dg\6JHSM1QM5`GcHM\:Kk.@V44giPj:Ac'jF,V:G2N&c]AU\mLB[ck
iQ@:N'eu\\:^\hR<XBDm'ZY$n[mFQEp:VP$N6i=#gq7kb``TNp4e=g2DhC%"#mg$?Md45hOp
>nKL8i2j:M#I88T;\N+IeE#Nf\b!Mo;)o$J,&\\cFM-uFR[_eP6o`cJ%48"PB/<nf?R[mi%O
*)f\%@WjK\JCr;,fJ:?f&1=d=enGd]AnEcY"P]AM+0Z@iE_8d8BhJaiO&Rqeb5tXQ7)^n?n:g]A
H@t41BR\>a+0W&IQT^CsUJF<.:YIV!M#h9#`.mVsAuEN?<K3";lMI29H3mkadW0o/X80E4Pi
Osm+27QS8+"A,2\*PCcL7<Ps7"9?*kb/F/3Zg`IhY*iS,7u5F:Wg3:qFYXRGt/X+=)3_d[tX
Mj5gWmNTaOVWK*@iGk]AU\T.VLV*$?Vt`IOP!eZ?HM,J^6'&YY@8#P/k!lu?lY;X>%?F]A(uq^
8cW7`@iVn-,[R*l4Y8Co.AT[`LtOC<cppj!4u$lgMdqLMqOi'^[6[707_QYc9K/U<Nr\!#JO
`0?GkQqItl-,]A?YiZH-bP&\-%+Rd_M=!N^MpqqX[@BYL^<Kkc<IEq(ED]A\0>)l368[2%K8B/
\KWe%p::/^>[Ej7UMe22>ufqhQh.jn."l-P6T]A>5]A#9sDY,RRUI'&og2mS1K9+dS&DNRs!Q5
*YQI\WWG]A+:uPWj+s9%d<d>Ejt\]Ad_h7;D['8_ScIVS(-'7DF\ZI;/un@GXM!HmXdQXE8'kP
ONq]ATl-T)p%H8gM:jGr_qNteFa30fb`57_"A4"\R^<3r6%\U05Y\!4K^4a(n/fD,nMidUCCP
K_9?'V4q`7uInZICi9cBY#_D%>l!Yd+%I]AY7Ban6\hiFN>,Xg3RJ%2@I4fOe5i.RLfu-hgj[
a0/;SsbWr`i._S6+aSHd-H_LC!QpIW@4k4K1K9!a)bWW;j6o0rPAJ^bSt,Y>a_j=`Sua;Y5*
[)G]Ap]A,*%,*5Fe\fIs&-@-^H8X/`^mJV3<Hq]A16kL-V6949_(6O<_gSLs$'c5MA\(g^SI%m9
m,XGg7A^Vs"oJQLaMEAQKE#YCX<#mX#Y^]A/r&mQsJMY3^F]ACG(3Q;q$q6-aWDsK?.*;p.f`I
ni5!0j0)[dqntd?e4"S=lXBjun3U`@VG),rRO#e/h%m@_1l-O;1n"4A_W\9k:eb>>Gi9U[#\
(Wm?-B6^)R@:K^r+"tP8N>p:r6Z:Xf"`I&I@`+U>VH$l*p2Tjid%*P]A*;l!Y=jh)01MR]A*Jt
G\KmtTNCZOVQ3DR0s\.@p_9-FI"oZ=>3@F2$(D>M87FXBAf:;J`1!gtGm"&KPq`h&4SUDaQh
`Nc>m1k<?PMD1UVb'6X2Go-Y!I?I=5qn[23Q]Ark4!$i6W5LW&=B0,cjJ/g8jbW0GW0$GXG`:
4ZC3,M9$\59[<1op69TB;Z6/`7IP*d2)7i9I/fjeKf"8b&r[hr9(MVH`V[L7[Pscud%C#C_i
<_F)-S1(,Sq6Q%3;dq,h>`Ft=bOKQtaY5`%=p4Vcs]Ar"$.TqkS0En>DIFE)-'nFXK(?pT>j)
e%/C`C*(NQEQI=+_1H[$5Q?M:-j,aE-`R>c.U!lQrl#dWu:(qod1Th!N#l!(m#R`D0H:mgY*
%o!DT]AT[5X8n,@s9l`-NH@<^X0@0<g2.j8s^s$;_<\VU5tncd3qoh4$^?BK"h#5,B+CFnX5r
nBF"o=e\fuCb\>P;%K%00%#K%e)<onE>Sm94H49OENd#b4e#'M<sX%CZ`u&CT]AOk9r<=Gc<^
A-%&:k-Qa!9p9Q1&J4SHPRB$\nV&CQg-$geY!;EC>GRdJML/_Jk?X:L@0#*/(?<(oJ40H8V.
_'VT;"G8g:(=:<"dOS_DX<N0t0fGP^G\J`6f'H0s+54\orFSos*r8Eb7,q$]AuhWQ@Xp\o9/l
J3q[_h;=`6F63%m.5H`Z7SXa,%WWps,7e<20aj%-lpHb)+8?-1RTE(L9]AV5irc:VYZ=CZ(_;
EK^si9]AbuHUmJ\elB(Neu%4+WC+l<9`kpNo!mEfXtDTrFBu0>GUi*[#AYXAFct[WZ1j%p&TN
)kismB]AGkn4Ptc";&0mgLOaZZ0*b%?[@\q,=0/<S5D2#Y'+`fHa7=`;NXW!2`<*#u!V0`J13
6hmVss:91_gA>aC(B,i_DCaG"F)oHpYM@2ek`&&+,ibraM:p8un-?N(f0nR4+'iXjXo-PHPp
'.oX`$:jogJT+)GZ7nY-\jhLAEieh\<gEJrj:Bi[[`%_'\VH*`TrF&N>M4-:A3/Sjgo(%Tlp
("/G"RV@4UKrJ*GL^[dj*ejSK)'Y+J6_*sG-:Uf$7#II:5MHN4]As:.8"S!%0gOSdab<+f9\/
Vh[@Yi:pu,3`$Xd)RSSuq_*dGVul?\uf(n6VlJ3R#PPF-<ZV"3odm,N5LA:;JM(F:=Cc./5!
o$)jD(2#`"-BH;6i+e<0ads"g6]A._/AB[O)@Y1k:"jscIg5BcmJCm+iJ:&(W'@1km^Y`BFel
I9c),kFqC0@UU/"$6k(F?$Cm8ViE3H/%J$2K./=<-oea*T$@Jf40aKl(i7%_f\0hTLEI8fU&
Gq./X<#KfIo$<JYP"V6ZE`>g<_*2,Jb&67D7Hs3,?-jO)8>aRHK%Zt,aMOa<[F[k5b3tOtg*
[G?BSNccGUnqkI%#fff!s.u_4RkHoE\!Y&&uLMA4YgH>NUd>S>GfebR4AS2(`)7,#dZd,l?:
rTPWhtJaI/j,W&:"<qB'st!,PRVT6#E^mjAG&)><HV4&jA=Fh0jRP!@!Ha=kNL9LUg\5Hi81
ED4e#C"[0\pp4LUDLc!!%:s$FQMO,=`9N`2_jr902O<0<p5j1A7t.IUZWD$VPS60:j1?(/]AR
*[7O)`YQlK.^9Vjmi,,Ii]AdY"(RBHC(Td2J]A#al'(N*aO$aSkF*S^c'3%%g;\OnJCU*qbNF;
',Yk4Qha@%jrG]Aic1(QR"eE0^<<JP&-rb:g9W+Z<A"IE[dNU@&_c&;Bg=(\3%W&V#45^P8f2
IG?29/J!j&;RF*TOLuP9O?a8D:XLV\U0Z/EF8N3FDDZM5![Vh<UQBNW\n<Bkf."_C-3a>KES
1/cW!i#.!89==!/aJYe7.pp$9/4J-EVT/"RGg(]A-XLl=`)j<"sc#(NPA#_%2Q(B$h682;b\e
B>[j"LbF[]A6_,LtGh-X'dh;=U/l;`j04mKJ\TcJ@)iA<$U'T/j/O?e)l:e>lDAb#ZVVF9l=N
JkQZ66e1VR=O$^.q:l+U!"ol"m,7:YHlVc-H_Hs00`*OT;#XI6Xgcd61?;1,guCG1,-?p4Zn
2n!3AE\s7jBOI/VgT!+QR>e2#$pI%K,GNR<4Z2u*'0BObj[q7nOYD[m#5;E]At^Y9D>RRd-ms
1F@m<KWldf.i`^"S\-U<[<oVc</CU&o\m\L=2)0chBV-l*lN#<2(F@fXk-<nu>:&+LsdjUT`
pi]Aa,%Nf$l(J!k_U??P%rUOOPKeBMCcU7?=Chi*MqXeU!eXWS$P#m:;.NOVg80);Y[fi$pV.
Zq5gnGS)Suc0:iD:PPoB:n!^<$;-_Gn@k4=bo5)(52J5_[F2dXmVj>ZcQ=X&NoPXkpOu%3Jb
=jC9W@U%a/B;aRdR8W2jT!WlZV@EX`sRt]A:A/!0V.?DOs:n_TD7`r_8o!-%"h\C_3)quoOs*
8-gZ8X)cY!td*5?LESbnpoQ!T]AqYo=k_/P*]ARJQ[b/l]A]A_aSHLUg-P,dG=P00JeE<EIE"e0Y
r1u!mY-ubjp4q3;R(Ot&/^j8P5Y52iS'\DLGu1!M3B=@OVQ;i.00"\bJ__ichd_\[=]A-p\DJ
]A?TpmGl'eq+A[GOF@Me[Q6!@e6L>aE_uDV-U_;i7r$':0D+3a':K?nT%0"-Pp:heJdM?V^@E
?!%87<C;hqc@EU2KS=I@9#ge&,eI"#&n6`A`NAJHJK_2V2+4\!_DWQ\Ml=5V*5Os`"cIn]Ah7
lS?G/Bp*:<4H?F*roHSos)lEjjl$L6#IJ&4YZ-@*tZ63c:&Fn$GZ>cUJEsD4YIlod/n3Xa%P
IEVkG!3J%V,-rb+\#mprae5c75`Uf:pQf!"C>,B[l[coEC:A>*WeJpo3^,9%#N4)FJ:\C-/T
AC.#TA.;qa&gm%f@^f6gYPpp1Ea\A<(5X\4Q%S;J&09aa:TD`&b*r2H=cB<[$4e.5V8+tb:\
.g.<0<27_E4b-hDC/m_uTq\j<.tY.?5NY3fQCGp>T2f.rY4D`qb8pA!IU,q@9TYntYbL[=GQ
CEN>j.#W<X7b_Ac[A2AJ-C;8"UM`@ear3/g["fP*R6s*!+,4lXNDN#g-_C(<&9t4"T.1!&H$
fJ3kg8<?P/&=/@<#<a?kT2cU+:=H3*f-CmU:.)N/ptJ4Km^a3@V2MjKs<kA,GDhI06`JgeJ$
X+D$Z>78_#gSIot%W*n!a[UBK%qDa0g3(KVQo2tW+j!5)$==r\$`m1F_'rsh;+I&'/]AP_j\?
)o9SlgHbmgEKk[lsDi[heB^>+5oqa5H!V2X+/_7A+IVm)I[h%b52J;@@tmP[Td0p(r4#Xf`<
*("1c9##o`5UmfeU;naB3IIo;L%\2W?"9]Aap5R?5;)KnnEm/QY5u18:A-7[)_.'f%"Wfjo)_
:q4U]AVK7>5JJci;k5tV6Q3#"aRoO.`NhnQ'Q`Y%omAh0'o%rr0It#6"MJ%A2PP+irc6p4tL7
Xss:;o&"a6n?26'FZrTQlpnF2MB^U4-WPH*Kt+-Wh2laI[u^*D@;JC!Zk>mbatGL^!!5!!+>
2_LE7(%bc:8Hj!`H0GDn]ABEI8bks2S4#T0RtOpgTokKs/h*"O@S>bR;/f%hg%O8Gi`!+QK*B
m@PpR2!3aFZBLHd-Kt%UZhb"H1q9jYVsS.3p.u^OlBI?!)CsbQ*:[G5'9=$0>+cij[*q;)i/
k\Dq"5[AT')4/2YD!g:06heB-NLiTfD,bq8Dt]Amo6.Hq(/<<Ee[D8D4,$H1p.#1oWQY.dK\a
3-DP2&`em]ACP)+n$b-:b$[jlHZ8\&#?JK6dDlElGp='Qd=dh=R+O:4[b>_Z4&f>B.Jd22J_A
<-f5Q*F+?3e\,cSsK>X.h97IYkWcfpo%ln<#2PGr2!:[NP]AH4Lk2c,003N3Uk6TTeuEQ'%dY
N(_-JK[Yl>pA5s>"@:S."TMK8G&NMg9=MlL,\]Aeul?XoI>@^p1aB05(hQ8Yk;ESg'+&:IJ8$
.DI_EeP.4F@h9*</A9%f3W2cd@+jhhW@e:KL:-g0Xi?M%kEp&AG;Rr4oV/bUa&B@PN.$SbUf
fg)"'@NhW&/R%<;?e$?#:DFh0GZTZT?piP-SM\S#tDSQ^<[J".bbLOk\j%?j_kK^0sb49rcX
ef4^L5cn,g7pV9.'SXR4qbOVkJS?l?]AX"F=7kZ2+Wm_BEeP/`f5^$:_lqi;4/O3XbS%-?(e9
j&lUFKnXf]AAjMmX?_u0J+M/;kL8XGr2Wm57]AiKSS(Hi-/7N+5'1.'4%.2X(DTOrhb5P`);B4
\_j1O]AdsI^RW!=eKf)eF1"6AIoYjDS.dDa(,3*oG3*FD7U&$#E&+jT2ce*6;kerL%s=^('Ol
`iII9\u+3fpKM='g7>^@tlH^TjK,gAFK[OO4l&LaPoH;;T0pfEIg`;r339^94BI;E=H]AUBs8
Yf2i.<4m%"FA5Xgg?j`$4[IH^Ae5s:<sPV>Hc)$ZX%\EF>mo0?9Lc7)*NO?,V8Z[%=hmT)(*
$LBG/1hJu9d-W**e^FDT=Kd!DFOOOpF]A^=+$Ia%Ag.,c-R!QpAZCIKJQ#-n9?(C_a?hELd6E
n@5\%>sZ7;;`6GYf+AVh'tWfH'8D:0$!in-r<aN'c3@PSuE4orc-&<,92gVL%Wi;R3K"%OcR
_'\jLU=)#_Z`-XcXmBTiu#<Z=cZ)c&1:c)DM\LaAk\L^*2=59OV+,5Q^a3KnanY=L)R9sj2m
>_KQZ>X,.<QO?K*Ppr/<gnn2@k^R*f1hJ47.a4iG/,Y<,UY5^40*efE+a`JG)d\0H!?0o!gl
"&5NHXDa+%u!o2CgJ@iC@&M18Bq61Lb?VR9FFcg`kI7u+Pp9Jol#HY$R6@#du(Z\),K2Jrmc
@mIb65gtm1L6ej.0=$8A8O3Jj+?L9-C`Im&5]AQgK?[Ca7g,_7E'4$(2_;qk__Y.pUZm0@XDN
+qHo5E"0P:7<.XH5VE&>Mu8:Hm;QR]A=c6I3IITD!G+k+`.`D(hAM59n2fB-\TTF>g#2Q#fEX
)^&<>r?M<L_mhqh'4bUjCaFV5D^AB)3Cg@!JCO[77U@PUI[4GF\7"5[OP=f(9@koL.o3A!7L
lF=6gH:+DK:gg3b"m7cK"?;)QD-P7DD<*<LM=W=HF]Amgqk56@BgCU@4Vq!,^MLO]A1#t1^F7T
Yb)4h<HmLGM`S@2Vl$8lIOhgt:ahI/:tX%-j7<K<5*L>s<W+#Irt9r4)T'RZ8@;+9lIq1jUT
Bp0bH"9qm5af4l03@lA=E!n).YjcA0Iupd\U`ESBL>]AcuS[ku4M$(%J'nX2pSB`HZ[q=G%`b
j;XbN*.?LP$g4!p_86n]A:CLCan7Y#RnriFC1Fg,GPYR>iSfGgl_5W-"fNL-71eio,aRtBY(Y
tbXDf_n8>FQLcs2)`?;O?N4'dfO+r3_5laVEd\Op#0TsWcWP<(to$;9cr5itgI.Cn<`5gooY
t8,K:L[bGCk%7"]AX=9t&?5<rK@:qg&rFi!Gmt<TerQt62Nfo6fE67uG1L@N5sKA6AW>=Ob+B
Y34+>a>Wgr$U:JQoT[Zh-.UU@#&Tu04U]AMQ:N?;q3:jq#\&L4SQF,Uodn=86$$_B6M,Lhn%*
WX+H;>"`$hGYk-kj#oTYCR?KcB"cWRX:f^\aAj0h3]AMkQ-h*o<]A6o&@ZVcG+lS8h9]AVMAW;T
O#Z$=1AbG$e<,s#,BJ0gNUjJJ3h(@j`(Gr;eio&KT]Ao%e[uT`o),`(C[&q)5Z`&\E-<F:Nc-
^@K&ENo7Ld0n.I]A_B@m`52R;\2lE'ZSUi:I72UC@A&r_n`o8r5XmpT!]A-9GWIk"2<L+m#gpF
\jlg5XLU3\[g$?;8Y=kq'0<OU3VhB-Y_D>11qa!`Ku\0Lo29O%5s/,&q]AZQFVp+m?Va$sbTH
C>1Q8>oP-P1L("\LmWC@>fX;tB#q9tZsr9bOjF>0@DVZU"+4;(tlWZCLakR/P/PkhcZNl'5j
PKSK'gq*UXl\s%/cF(\+k[?T*_-)ks/5_JJ#/ru<-d[NhC=KSaJ<"nD5'`g5U7_)DOsC?so6
Un%F9hP9M)AuA&GNZ,hpAUDN?/o?60AA?Ii2X#+!)MgED:XOq]A0"`JN,)cR,j\Ke<'^5pCWs
oQPg9r(3Z!<"'gb)"C`Fm0Nffo+4@qDV.&`4N*iJ"8VZ(:Z5R)3p<Bb(e0Um3]Ap(93?W?dT/
/BBt>DWI90FSST2QG<&g8F:MN]A^#2rMPL9@tT`=Vqes/qQ\P'EdA8^q,"QZ6p6AO`"e_>Zk!
jAIn-aZ@D8MQ.?]AS/"sngUB:<]A89k!mpgUqLC`1Gk5V6_>@EI3@;e2m&\$5O..l/$3V0K`K:
"HlPGdgD/VLL<V+O70Mag'#5lT;/:P<:m"NT:En>2c([SRAE^TQaFq^o\$hTrq3YVJn1<U=u
Jq7-_L6iD0L)o%l`DIaG?t*>Id"b!lC8>ngJmt0MU'70n,W;Ga?EG",GnF8Nt#+o`'lr3:"A
kGd*mTC*D^4<;(Hb6%dd%(ob,+.c&Z$7'FMBdYc[e\:YNLr]AuhH+YBAZ$""\e&ZWKd!IOY>,
2)qbJS@`[]AEH3"eE)#%Z\]A2#P+7`>J5r!Jlj^er8;9b[3`U[3("79D0kedM53@&GF&gFlWDj
INO_ZYd#Rj"s.hj.L9d0:EM?W_]A9n)N.SB@g#m:K?LPLia'iZM]A[BH@BZ5k7";J&`"4Ijo_!
qbR\N5X*od8&/j]A2:Y"&,'.[n[LbbFc:/?/7m/UjMYR+I0>5uo^@+#&P2BX=h0\aGS4N@m<R
\SY%<RE8g9s3X"sre-!s*Gug#SL09Hj5A+f>_fjqWj`@H(mC5?Y$*e#qOLF-GGoj_Z,f]Ar*4
RO$Rtpo]AMMh6(fB]A:A#N+nCgK2l>QFKiI2Sq.d,4Xp?W7Y*c"VZ<[k2Zb%1AGQ)W2YCES`U,
XmN6Z&3//B</]A@8MA&k]AJ7=&Tm5XTPOGjq@t'H2W:ZK$q5WM[5.bWSa!fpZ#5F_X9aFdjf<M
uf2(WJi'0,l@M=GTfC;&e1\'b]A0muHji+T^tm!-u7$eOfTgehEKYj94/_F=Fu(@MQDHUrO3R
'u!JYHG&r@C^<r]A;(TH:lcJm9l"U]A=d!JHt"9pg5oP=fT_.GfkK.s.R6U#/GVOZ54g1NSF>H
P^&#OH$,f]A`^&gQZNXrN(`F`tt,'2^SWbJbXZj;kJ!=IrBN/PF]AZ,edn]ANIW0D-Lt<r;W71%
=<B*TX(ZlatmSIsOOePPmWP%m"ReM)4'A)T7;K_f6$@"L"d*(ksC#@f?lu-os3jX<i8,":*L
G1`edHiXUn`V;%VO6[$<_lM"E^?>!V,F@3\D!,]AW]API<o2'4)D6>B'F$;Qj=j8_[S/FO.?hK
s&<ug[mi-%_5H_Oj3d)Gd_nOAiS_%-8\QWmPI]AsSP?5-iJ8F3<ZmW`J>=ld)T'@>ZA9lMHI?
h:*8qH)ULH5tWNEP/(kLIA[4k]A.$9Nmh(1i:$)0N3Nji0YPXu$q?_J!nGJA0'UJ#]A<$BQ(;g
Lo5MB6W'18rMWW:qgqb;`qhof6>4S<R0QO71PYPHp#YD='/R5%Q%bO\JR9BSs3O:FI8?R*6"
CgNqBg/FWIB7$9/%KhgK/f)Ij&+Ecao!U+[NfEbF/9tDE)5VDpLo?r.'Q_8Y;A@1]A3$=Qkn@
'duX4,I1aSi:YmrN%f9EMi4hF^=+nMs(U=o`75BAVL_PH']A@-p./W:1$[J1)X]A%,0dt2nag"
YQ]A>bd?6)@uX<(&s6[$7MYAWKG[94k]AHirX',OLJpWphB\^OUlP>I>i$_#gY2#1Hp5JIS`i9
4Erg:M.b$h*dBYGC:O-q9#^T/@UHGb/3"u*ULXV0>0%,6DkP2ZFaf#!c*15P3db]AY?KD[),r
T]Aj&Q3TGfbfocNRpil2J+Ms-^KK3DSCh\XKI!pe^^M]Acj+'F`ldUgC1(5%a:rmNR:n/@S[=6
bVa'LQC(k<cI*"J\)UUSX2mUPf@)*ONCGa;jFZh$!%F[e(5\meI`L@.T\@@kQ)>ce*6I2]AjV
s!Xl=H=Y7HQ&^"MlRq<Nm9RW*EKaQ'$RpQfaqQnX4jG_l>\o.59m\c&CCA0\f/,Fk/^ElQX8
HJ.iWDO*.%\A9[*&V%PG3-g8^&&j3QHNlOPjD&iG*:BRH1.Gd:<FSjK>c7*\=X*eKZ<Mhk:n
Og?c">`:G@X`s&DO's!b]A=2.7@#Q$?LK2C-3l%p`dI#qmi6c)eQEXM%Gr285S]AnthpUhk_9"
NibRi3bi)VkWm1B+FUE"VGf&p5;!f;PeWOIK.I2sG-D[fjN[o(cqb5P$TGXE8s!M5s<$hrr(
P3B5$BYA2ccNn:,LMALh`?@h3/8GUiR._9W,mhA\.P"H>rB8#hLPUHZICi[hsfi8=bF)-"Bl
Cn'++HF?M>a7d\3pJlB#)TMbT(kd3,WpFaXJc6SZaZsg(gls[cckog%Us0[4@T5R%P,`"*"q
EkY<%nC\HqeL018$?Y/@/*pp9EN7##a&nqLQ"Tb>RSb2X?H93TDcaha6YhGpHD[lK&U*f_[E
P<i7,W(G5f6Tu(3F<M0PMAsCm%ZETd^Z\iVL_9,@%ZAj=GE3VA(pn_uCMrS&#5uU`:YWZ4p>
!po(HXC8L0LK5eYTS8e<'nZ65jhXKObud=0EbT[(u5c1gHnHfnOoTfVYK*(<hdG_=#jl>fS!
&I=a?pNS*,[OACp5rn=YGR/U28^UH,o(&L7P5)$3+,mf]At-Cq[iQ3O^sqRgD*;mU)M.24"`a
*crj]A?Srs_(H;lIA?3Z;3,\q83;W`(R:X-L;bL]AAR@@@P%Z^NkF!@CYUY`qVT"RP:NONp?[m
`g#EsR*O5[sghJn0)S_*Zg$gMY%B?]A"53%U#ZTH)7dcfeuta+Yk.%C48oqMU7fYIuq6c(cr0
Dq<EfPG/Q".k;Tq)?[l-7rT?FD,K\J4QDB%1PGFdWr"lm9h8HI2C<MNa;\3nC(-2>(8N#\_.
IAZ?""PZcRnS>eJ]Ae*r\j*mNN?#@6mf\*4<!Bk1_0[IpF1DEc1#QHn$9k%7I3*GjI)D,?RGB
>d+"6.d<'r[_=@/[.Xj,pM99QeSQ.O#+rd!=f9a4uK/cUf_%+MTc'sNuQhsAiIG-7JoQ]AjP4
fSs@=SmUmNA6jtcMNg<!gni+`]AF_'Bqk>4$'sM*9o4lda[b+_29@<S_Yr/e_?a3O#RsRE4tf
Uq7qPIjc8aOQ+jLfs9Ai[/#OlnPIde35B$mp.mJ;G).Omu^c1SaS#VaqKr/Q2AgoZ']A2l&K$
23S<g]AW",o+f(=WYn*E09$tb+QW4kkK(o8)kS%DN8.1sejMG%]A^;C3B6SX!2UTXa[0F1nrNV
8T#4,4h%L/Y*STiA[*\qHs6SJ2<\8_J=R\:43ShZ%^*!<0"0$Dtn]AB$FN@[djrT,$&aqKM7D
7:T-H3VTEB[m)c?!/u4BjPd,N)XJ45]A'%?ASl74,(if2DK8PF>0M>G8A%7Ec1q#+C2o13m*h
.XHM;KZ5OhmtD/+CX$I-+LY2oM"Z`.*9M>'8h0%8Bdi`&p=%ER7Ha3,hbgrT#85oN-'c>EOQ
k4*BjC22[Gg8'5%hXdH<bN]Ac$rdqO*_AqMdK:)T(jI^Y$p^GtcL*`%qP4CA`dgpaU$>W'>DK
c);7^+34HkES=IH!A2]A;nH-N"!tn259(DJUWg%Fh$ZAH+ktH:4m="b9]AX`t3U@-u,S[*8Pot
H&[l;qUL09oj3gfi.g0:>2\a7G9o+A2:AKQsDU%gR-]A><Ql<=CsCQ8=CPiK/oVJSU+`okqE2
6-hO<l>ti`jT/R??]A6mrkZ[kI(NT&LH8n/b=Qo#Za@d=*"J!)tj4WD#9UObR:'4#Q=P3A>G]A
6<Q7CrQ39O)g_abagDObdH!I#WdeYKEW?=K-obWCP<KIdFu+1`>LCg^OWk+%0jlgaJ//oc&n
\p\+,nhg_$Eg7"&blEkJ%L/1(d.TVC%Z6W8V<8rZ\/&qgI/lH.^O'6Ej*#l*nH?<\V4C8N&C
mfWbFnKZ=.Dt3FO>LJFiT\1,V9+sf]A,UkQd163q[pPd,!p6VPa=a:"t_k-4HV[7BO:_d]A"aa
?_IOVPaWnfG-Vd'eX`g(;L(0FC*Y'MFp+Z&2E6@f0K[V1gqU)G*'Mk_5.)Zb';O(nr;)mOZ_
8\ES`I.D34>21>=srQq.;P&RGbq">m)-^kW53UY`G#JaJf`1*]A=0OA.RM1lX>A>]A76':C/2U
/(P[X;s-K>R6h!2#+?>%Yi3c@L1!#Rn#d-,;5KAG,j9Cqk*;PP/<rWb(!>hgXbE\`2pJH,(=
r<Dlb?s`"s:,pJ4ipYCKhs(5.p-X&oj;OU$Zoa7QP:9>+FR."PKM.R:]AoM2m&O!lZ:K!jY\Y
$9Rmu.D_/emV%-`L?EL(n#GR,!Am=M_)>EL,\f!e_"6&1k9).XFA?J[8[OFrH#"dMU=.QC5Z
0EeZ"kiRpdlj<O^u'+i/Z$#d"2V(Wa[Uks1ofN@6$OFJert`BLO=q!p#P;@hr0XlJ$:a5<"n
hq("a[NhCneHrE!S4;ZNE7DD#@/%tZRT#"X"m3;f8hs\<Hgf%bI_t>->Mr?.To*#M3TS-CSE
21A&(8EdgZ!]AJR&+hHb[Y^=&OILB>q?R,Ti9NJc'_0B?F1A)3D<bZ4LP<iOdB=87FS:n2eAr
0e!``CC&S=NiYD.c41do7+n!<?IWcU+=Fed93BKSWH2/ueS")q3#3&='466M"m)sk]A&%u+ZT
FX`)Q53=r;X\_Pa2pOhhQn2u0*T&g:XpB&b'=iJ*eg,>#`nkL_Tl*\/'toCo_8t5he+u;=)^
rF38$8a%T.V=+OOj0.7B$]ALLYH0@PPS=.lGUR($5bm+FYDp1Z'Ps-8pX:mB]AXm$dqduO!`!`
h.[ie\:Q(ut1[Mif4>"!T=a2>WCT'J`?0!U6QkR$bqp%(H^"s6^h6+eQSYG>pin[rH7>;TL9
%:F?7iiWD19Sq=R/eN*)+aEUL+1*`O1+tl="DkJH)%mS@R^<,4oY6^&!+q3`*<Gjns3(DHrE
(+Z^W90mMDPiBi!B(L9KsG.m^Sc2=mVJ'am$Sg=r&:%'cr"\,JWAMaB9)4OG_&N1JS1"7q&t
!H&!UfEo=8,hdO\fmX':,9g,-+#p,h2(6mQ,Q8"A,K:GN;fFAt@8^LNSn1Z('N]AUgJed]Aq=(
Kf]AhB,T^)so*:@L4O&gCF]AnER(u6Q"rE62UQ?)H$$]AsdHS8Zl/7b_SjR2hntKPqhhnX7-U_r
J(?)XAgg6?g(0+TrXA2Uo0A!QC'qIY'j)o1ro=NJ@hKVZ.e80k*0iA?n!r$S+lCQ/!!V0.*q
.1AY*1ItT12@$%WI^5(W+S78'4T94AqJ-f=$pl+OL:]ACAM&>\g#R>(SP(mK?_?:_E"7d5Kd.
D1QYJDQUChPFpVM:,N#>b^R):/J0]A5^N'tc6iXDRNPW&#,@A8DNPcu)>p`"<0i)bU%'rqp=`
't<7VjV?aokPV)a^!%7Eo]A)H"?>%*a`cT<6SqJ54BOZgPAX)LQm[-;X:aY@*q8.(Qg='5?&+
dSF2jcnZHk?KjE8aLR[-Cp>#bs,=\?s7BQ@lf-Q]AcrL+1?pE/^ci%\)TelC@jlI"(=1!oLbY
R<-Q]AgmKP4apT228`FBi-l.Y]Ag*m($c2%0TGRHaGS04Ic^*H/T0,X?6"qECAe!EY<#2"bm)W
_S,L00"#"/AWrM,("t_QBnWpC4[i_`rgVENf:&9)apo(RU)$`)m):X25dVAk9Oih&Kp%W2QQ
j#pYIAo#B8.5r%t=K5>5K]A$4]AGB?re.hH&P]A%$I3*V8$pj5[(%IN17hJTK?3qUhP;=srDM&V
`:QQOSa!WJT?Sl+Nd`+A1t5-pRT.Ye]AbV-uqpGh,^K$<p(V?#9I'WlbNNUPa<Qp>df'Z[(]AQ
JG=$Ff\#gBIl)a,mu;VU7:I-&d8X^"#q#UbOe;o*ICYq1X!>`']A>24=4&"R$PU$&fITBpihP
"%BO#lgQNHb;A0_'$0IcbGT$hl.AfAQH`,D!U0aM'q4cV2Vh_L>M92mRQ\uBk48\/IG(M)M:
?k<KEdP]A2c-?n<:,#cnA.'2E6o<X-o5;eF5^1b=<^41uNq*IoC,"lK%X=6s8$[[X'qRh(Zmk
A%Uo1C,h,jl2:<#e?NBYGV$O$rr`/N.soj20U2"5[En%?5YEO,I8YkOs19/\8k2eT=t&al53
pF;)EX\!\hZA\J%8,1;W(c3(Q^'o#@VmgRCg1*saX`e$iOas$Ef:U`dhh)=636t^Rb*0VE:-
<YaL3Sco'(RLK&aiI6dYUf0U3sGf!I[PTL`(D%68VuC.IPf!Z=Xhe\``cE'M6n*aV==a3*9-
HK/e4OQZiJ"DB/"#jEmHcWWDqVP4DgaqQdo:`H2E\/K9GH,Z+p?V*+FL]ARL0_Wf6K'JKTE+X
ZC:Jfshi,i6nl.R4S%S3poujK52qDL^TUD%S^+lko/OF,29uEp)A!L:6E16Z(-ih=;-*/(C&
uhL,I4Xj9(,L0QrVJ*gW)*&1tKm2iNp)UM-#j!nbfl2maR]A*Q,]A0ngF-nTlAHi1ukr-gk)"A
LpJbR4eIM"o\[,:"?S97]A&&X3d5]AYd:>?R[FS1'?dO+TsXjWVnnC/2*3t.n<Zl\<"TVu!bPf
LVgmX\rA7UK0OULcU(?(@nP^eA,Ep1Nf4K-Jnn=+9DW/J.Tu-4nmpW`XrV!41k]AQ1)W>[G!`
S$cgFKVn%Df7oZ5>^P$H;)6*?^Yf/sX06-cX6VWL]A`hq'+gWHEdGXGGNq(6n'ldQ1T*O_/Yn
)HboKVKil8b(aA9:.U2WNX.U1-O33=g>,37Cm]A0E<r9%+7t?A4&7iA'(lDb6eh57$bJ-^k6B
1B8j9'()SE3ga9SA\]AuSktg/5;0[jmEI%u>M.Wj%:07JeoS?(bAQj9u3%bAfE5%1Ytcn:8f8
31MR%C)1L:KP;*a;AT;oW.ouod2:;r`#gpN5o=m-*#.\r8SnG!*&;8$*p=,2e9AGgZgI@$"0
7P6$(sp7bF-EJ$=-k(e]Adooi;rl%TXM6rF'n9tEV]A0&g"P2]A3Ona*8><isCT3]AU'4If]A127R
AC1RM&D?`ibn*NSh.Ae2ndKReH"?L'm>_r+kC34^t+gcD(7a-Z,.E^/@2mU0iD=?(noI7]Ag/
0_DC^ecJ7"8@:0/6UZ<dl8Q8\g0ps1=Tnq>0La0Sb=X0B)LR(Yn>tPXkM,ua<'XOF75c@SK5
8FZn6aOD6<Whd<T<#J6p^6K=Q1&m1[l;d?FNX9pX[ZK-0h=6UH&_gQu2U5c";RQ/4Xm8^6Q_
?3t<1?aYXsbl"CNm-l0b)^dLiW1H`0eutRg(N3AP#g:T"s-k[trqiml%@!f<=W$PUqoe"8-B
`]Aej:gELX):Veo93:fk6L#HR"5-CG>3Gmh5,f6PY)mhL_cN=TcH.*o$CDJ$`do!#6#oS]AYPB
HNg36`Qbf%3=kG$^fTcC+?h(S9'n:^e2tt(li0sX'2X=4G>$HJOe8t09Z9%sLTYe2QlI$PL\
-5I%/]A:Y6BUrNoUg\c'LNttY?0-q_5MtUM?b[FB/.Ap2Y9mCE*fZ*!G2s?e;0M5'f;#X[kop
98<Of15NOHl!;8<+Wq0T(GVKIc+jAbp=f(^O$A^^mI2eFjZft!Q$hkn'UC+X*K=jV(qSmW`M
?h1BRoAA<X6<r#DEH\RB"K^fir(C>+[H:kW<_59\Mr%LIGj6@N1c9S<D9:IOJSu]AYJDJ.@D.
V60F84@a9<j%1Mr-1K%^e#?crMJLdZXMtH_Lk8lQX5"/ebBn+#Hp$GdF@JGoJnV]AL5K!KrE/
-$^2YarpLMkfUuIcBO?CG7+.1\)]A;hGqgUM"*":4FHWan`op1g#heqOTduRoh\U2GM>n%RD7
3*N>Tb,$\os7V0Gamb-Lu:89'r%D+B=tie6+NiMPe8E0U;JRD2FTrjXY#%f>(_Hm!rB5m#n>
MRaZR3gA*PA;UCD\h!pB_`+`k=8rc@U,<7Y"SN'b+7:X_`IQJGd=6]AU)&g^>GoG\G')N2OJ.
;="4fbmRl.-iL*F%[5oe_GM]A4O_,!p0.-nD'-f%5d2jeA`f>FfmE`6:hd6T_rpR'h"*J=Fjk
Tl>6U%sF(V=^'c,5X:>b%.#;Zjl.?,2>0MiU>_-CmB-@:!FI'(V"sD!tg:1Kc.NY5bQIQSSl
SIG7UdS]AJqKR5aS\=9tYTa[K`0gqT,q]AWE+P=]AH[kT0`h7F53k$'$7s$ml7?n]A:lHQCBE!h=
%7\<fZFQ!@Rc2@Bff*=5;8^(IWT[TZ+#EqgDP+GgDf^`Iqt(Kf)0GqY,Hj'B7C^V(O!kpD5g
fNW>7W3fo]A3BJ$CN5dTlK\8r^sq*qjg77d!o-.5l(e`?su,ImU_5';X25Ht6pQJ6,^YKoTp*
Y]AM!TmhFDB;(R[q$-)&54"-<"V:Of/FCG"6(Uf$(qbI/3W%)RbAD+_/[u/rlF7N[]A8St*2'U
K2tftj_o`c-.UP7%J!4B\_&;[lf3WA2813loPN;_/);6td31=L,_JCmgtIM)Fp89k_^53JeA
oTA/(2oNMT/jlCfIn?Od;a-W$uJ.@.<O:kL4?(f9J@dSZ>=Bdl_qQ+TK?qQ81=@M8R8l5CK_
BuD$>(]AsabS$/"<S15"<EPHFqSPXt;RrhS^"K!9-<_imo><-BN/ac2eIL+>m)c`Xl7K<ILoa
?F+Y,`"R:71?jgct`&;PT^>HDiX_5a^NV:GDuFnRu5Zd6L]Aad)M'QK24BV[OF]A$6_130$a?$
YJ4!A$`C2U=t*n3OWjSW^LTe-/HU8D"Qfu[&Mf)0X/rfre7"G0J$_FN/k'["ZV^boF40L!2`
i#Tk=GIhY(!C:>UmE"YehRrMDC_8FM?^S/0lbed*6%-Xfla>;oq(.aia'%Y)Lrp*bF^jgMTd
$;8<!P0@s,@L)+fY%8:otpXS'c$<rQYkp+[F]AaZu5Z!hcjr;3MYZG)UD_%8"J$Q.D"Ykh`*"
7kH1/g??=G`l@jl'jDEr^cPO%BZstKu?1rH<)lYnf=BOX!dUG("u3Uh7QAgCjq\0h%??D,QO
LBnO#G;T/Wk@COe?FGMVk]Aek7d_Cs6VR96%7]ABO0t$rRO;*p9["r?:5"BjCZ5%OZZ9XQI-\G
;M.8MH'f8eVA&VYRr!QIQM%/^0'oc&MOF0+KJ9@daKElVk'#UOfjQ;I!-o<h_/"LNVR>2]A2R
#JRUI#N$]AOA0s3!E`;ED%'d/]A?<*_1_/,\o0,:B#=r\$Z<=8Zu449Z#PCY>L5MA!;R=laU=8
(5K:0o%g$Uig:T3QPMRm<983U/HcR^O\[8"lDIt\m#;3!.\Yedf$_1ZX4XHt(c";nDH,Pk[J
o/RS,KFgA)`>_aZ^"AeKK!e1<2bH@cG;&Y^J#)7ORnc"qmdX#8n5Ue\oGU*(V;*V$ibd)BH+
f>f7N#@Ts*T&/U0\krRelV\c.#:CWF0+Z?cgD)W$j?p`'Qh7^hgQcrX?"HG,"#CtWC%<:!(/
h.TtSnC?=>8dec?!_)m#oa.a!=F(6T>==);Il3SD1pbI$+tfW;CH&?1]A?`V"<%q^8HOMI1mT
6:<,@NCK`c?KtO#Y*f*r4KXg2c6/10_&K$g=g82ZDIG5:G#PFJg\@L5)]AP7qc8Trt`EIpGJg
-6'H)q),)W:=D'XZ]ADI>'rP(%U'a#=UP*K";^Hp.2"C"X;bOnNLh!nr>QBLkEH.mIVoOE^n9
\Mlc&4qkp.P$,hQB4[M'@BEPB\=Ns#.K1B3d6be0#I`i<&^WgK0)a&"ZjTcfHk[L(4opj.Dc
%'b>>JQ).G?!BABWk;p>8-9F7/938Lg!W#k&gX<^;=-0X'g(H;\;]Ak*FH\O_2O->]A<6P9%b+
]AOh-;fHd]A1>_uAOYZC)uRF^qV2GSK^&X0g'<asiKPZsr;S"#sU6KYO)<2E''bS+pRdp)V>0>
aVC+S;($8Pk`+b):pLM=4E.e=NluV"#u6j#&DsemXdp?je<5*F1H330Xsm"MrHGM;t\U#`bi
h6MmA<3[1dr7^ae4]AFg$K>=*dQ-)=O5]A`1dCW'<l_;u6QE'7N6l3tFB=hQei.j]A6sq*_s$U5
*UU>_io!)`547Wlkmp^@3-c</>F6t:J)(Jbt-%SeD'QaT3"39,`[`S:Z8ABpKeDfk*N.AD^<
\G<-s.ufV'Kl#"DNg1>q.iL>^1UGkV0`$5/"7[>=(f"t^QSb(*j4j]Aq@WV#A8g[&$\Fm6or6
T#',p762HM4(^=+>6-A6ZM?e45f57<X/to//be"c)FFB`b@,og7LV]AUqCFCBjAjH74ua\]A/W
+k4UAib@'OPVCQ/]AP9=57r'5^^0rW?nP/?o+k'MQB0dJg,TNF&T0G%J+Pk%Vq+_foj;aX,to
4$L"q?Au1cFO#*Z^Jk^b5@>3Z9.CX,W5s4sD\UCO6rX\*kT2,NCXiWF78#XSX=_b1<s&]AcWI
nm91`4f&61lKF"9Io(ARH/4QZZgsG#HkF]Ane%-Ya89Vr8e8EHA`??LJ]AQm=OnaD?g+pF)&Ih
d:r.[0Bq!]A61E-UZ;,gJ%L)s&RK_]A#0eUtZTAC)'eB)nk3$Mm_^r"*bjV)<h##Ms#P($/]A8^
7\2Zk^`"o6n[GD7Dbi7IkYu'P`/de8ntVZica9O%S=0m;U+@R,Y[kKLNo4c&hr<0?djY;_J5
<;&o1tUjXr7@LjYG%5<-ZNPr(91i+OS%o:!WcX[8rR9THAeh'!]A$[/m0_F^JMp-"f0UMVMcS
cFLFLRVIZV703#mL4Gq^99W/reV:L;s#W->DX4fnZA%[Z'Fj;,(P0f`$0o<,2ZW=D)jgYX7o
-4$7>o9j2Q`35QBj;&W,oFi]A"^.Ul]ACbQL75I^$@[Sd'e'fnhc7`/+T"63%S&FV'L7;t[8MX
0-F>el2=324]A\O=LZ#LUmrbB*b4I6JXmldJt_PDh-@12F?jA2FN>0_V@"as@h0*nG*!^@:2-
117s,C673Bl,D4GkAiqFb*mGM$Y>]ADYFSIa>"XrmO;_a;clN#i@@%R=nXr\;)oU9eT![j%H_
lr*Nh8:7Q;j>iafRE<#0SCQ,E(Esg4TMH#HL_\!-4p\Ls$1KpWU;>b%-\rne\=YMUTf]A6/gL
?eQg1T=l@WgJ=nR<s7l8rrso~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="10" y="305" width="232" height="227"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ComboBox">
<WidgetName name="rq"/>
<WidgetID widgetID="cd6be55b-03ac-4a89-9f54-11197a48d942"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="comboBox0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Dictionary class="com.fr.data.impl.TableDataDictionary">
<FormulaDictAttr kiName="日期" viName="日期"/>
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
<![CDATA[=FORMAT(monthdelta(today(),-1),"yyyyMM")]]></Attributes>
</O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="716" y="334" width="80" height="22"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="chart7_c_c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="chart7" frozen="false"/>
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
<WidgetName name="chart7_c_c"/>
<WidgetID widgetID="b5840092-a4fa-435b-be72-2c56ca908746"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="部门"+right($rq,2)+"月度工时投入比对"]]></Attributes>
</O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="2"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.custom.VanChartCustomPlot">
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
<ConditionAttr name=""/>
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
<Attr position="1" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<OColor colvalue="-12080918"/>
<OColor colvalue="-1197808"/>
<OColor colvalue="-16015509"/>
<OColor colvalue="-1222640"/>
<OColor colvalue="-8595761"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="2"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=80"/>
<AxisUnit201106 isCustomMainUnit="true" isCustomSecUnit="false" mainUnit="=20" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0.50"/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<VanChartCustomPlotAttr customStyle="column_line"/>
<CustomPlotList>
<VanChartPlot class="com.fr.plugin.chart.column.VanChartColumnPlot">
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="5"/>
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${CATEGORY}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${CATEGORY}${SERIES}${VALUE}"/>
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
<TableFieldCollection/>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
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
</AttrList>
</ConditionAttr>
</DefaultAttr>
<ConditionAttrList>
<List index="0">
<ConditionAttr name="条件属性1">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-1197808"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[4]]></CNUMBER>
<CNAME>
<![CDATA[VALUE]]></CNAME>
<Compare op="3">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=int(max(value("部门比对",9),2),1)]]></Attributes>
</O>
</Compare>
</Condition>
</ConditionAttr>
</List>
</ConditionAttrList>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<VanChartPlotAttr isAxisRotation="false" categoryNum="2"/>
<GradientStyle>
<Attr gradientType="gradual" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=80"/>
<AxisUnit201106 isCustomMainUnit="true" isCustomSecUnit="false" mainUnit="=20" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0.50"/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="0" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="30.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="false"/>
</VanChartPlot>
<VanChartPlot class="com.fr.plugin.chart.line.VanChartLinePlot">
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
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="solid" lineWidth="2.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${CATEGORY}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${CATEGORY}${SERIES}${VALUE}"/>
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
<TableFieldCollection/>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<VanChartPlotAttr isAxisRotation="false" categoryNum="2"/>
<GradientStyle>
<Attr gradientType="gradual" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=80"/>
<AxisUnit201106 isCustomMainUnit="true" isCustomSecUnit="false" mainUnit="=20" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0.50"/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="1" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
</VanChartPlot>
</CustomPlotList>
</Plot>
<ChartDefinition>
<CustomDefinition>
<DefinitionMapList>
<DefinitionMap key="column">
<OneValueCDDefinition valueName="人均投入工时" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[部门比对]]></Name>
</TableData>
<CategoryName value="short_name"/>
<TableMoreCate>
<oneMoreCate cateName="rz_bm_system"/>
</TableMoreCate>
</OneValueCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<OneValueCDDefinition valueName="投入工时满足率" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[部门比对]]></Name>
</TableData>
<CategoryName value="short_name"/>
<TableMoreCate>
<oneMoreCate cateName="rz_bm_system"/>
</TableMoreCate>
</OneValueCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="a493b27a-10f7-4e9a-89c9-94f3cbc3c754"/>
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
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<BoundsAttr x="0" y="0" width="764" height="170"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ChartEditor">
<WidgetName name="chart7"/>
<WidgetID widgetID="b5840092-a4fa-435b-be72-2c56ca908746"/>
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
<Background name="ColorBackground" color="-1"/>
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
<Plot class="com.fr.plugin.chart.custom.VanChartCustomPlot">
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
<ConditionAttr name=""/>
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
<Attr position="1" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<VanChartCustomPlotAttr customStyle="column_line"/>
<CustomPlotList>
<VanChartPlot class="com.fr.plugin.chart.column.VanChartColumnPlot">
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="0" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="20.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="false"/>
</VanChartPlot>
<VanChartPlot class="com.fr.plugin.chart.line.VanChartLinePlot">
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="solid" lineWidth="2.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="AutoMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="1" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
</VanChartPlot>
</CustomPlotList>
</Plot>
<ChartDefinition>
<CustomDefinition>
<DefinitionMapList>
<DefinitionMap key="column">
<OneValueCDDefinition valueName="人均投入工时" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[部门比对]]></Name>
</TableData>
<CategoryName value="short_name"/>
</OneValueCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<OneValueCDDefinition valueName="投入工时满足率" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[部门比对]]></Name>
</TableData>
<CategoryName value="short_name"/>
</OneValueCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="097ef2b9-88b1-4c2b-ae7b-3ebb986467fb"/>
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
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<BoundsAttr x="248" y="305" width="586" height="227"/>
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
<WidgetID widgetID="be56ac11-b658-428e-8742-d9ad3dcfc26b"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<![CDATA[1463040,944880,731520,0,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[274320,6096000,2590800,121920,3886200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="4" s="1">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=right($rq, 2) + "月" + $bm + "工时满足率"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" rs="4" s="2">
<O t="DSColumn">
<Attributes dsName="指标" columnName="工时投入满足率"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="3">
<O>
<![CDATA[同      比:]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" s="5">
<O t="DSColumn">
<Attributes dsName="指标" columnName="工时投入满足率同比"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
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
<![CDATA[len(E2) = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[/]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="2" s="3">
<O>
<![CDATA[环      比:]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" s="5">
<O t="DSColumn">
<Attributes dsName="指标" columnName="工时投入满足率环比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="3" s="6">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="4">
<O t="DSColumn">
<Attributes dsName="指标-年度累计满足率" columnName="zz_rgs_rate"/>
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
<![CDATA[len(D5) != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="4" r="3" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="4" s="3">
<O>
<![CDATA[年度累计:]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" s="4">
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="4" s="5">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=MathGeometricMean(D4)]]></Attributes>
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
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="128" foreground="-1197808"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="80"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="80" foreground="-15386770"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[mCWa-doZ6,m^0Bmeno.lW/<97W+/q-=*E$C7]ARpO#pN$*.O$&B!^[0SUn(Pc7``)mW%9Ap+L
38(?P8MOPt3*l+@MNW63o:K&kN?PqsT0_b^ZK78cM$<q>R8ilBCBc%p\PcgiLe%n,&]A'P;Aj
.mp,S+RPu!6>-r+tB:nTrZtM1-dA!!%rr,pU-\'D?kfBJeQga><oOD!,rhP(8@i'Rd4+6^9L
Zi6+#1c[t5IimI%,m/Z^#[K<Qa_nqGia,OOkHorFm`sNH#Er?jl;V=K']A!),JP3N&35*#cA*
U)I!XGl0fRerT"n``^rKfl>un3Oo\`3VH^j,!]AhsKSdd#>lV4EqYM>>Yo!XH&/BPt>I33`.e
*NCZRY3s&F0`#n-lI7$hs8M.ZH"I=OAX;;6k43?dDGKCRfDBuirl^6&B/ZA00Db"qh=!;3Ft
WIAr/Wf*U/D)im\^>>[4/XPgY&R$HcFViHN0TA4FM;=:&u?sks$@qH+ZE?i#]ASIr@RF&Mq\2
BWqeUB,t6Q$F+WNm57N\IfK'\X^@P:i9-716m%KVe^E)Tp(5r1Uqk#[jbEch5,FHq4hd@6Y;
je&K%0#9`qW^:Sas)JZi=L?mG;8ml!5to=lQ&@pVSYrPI#ir-`5`dej$)UD*5#*ndXREO9-(
+8)r</,CEE<r:.r;C/ffh1Q))>m7lSF@.F;RG)]AiNB.<%m"+-Xkrh,8/u=!uji$`'OrMu!6e
&GL$u;iu2j;12g'Xo5Z9?K$\%[j?DGU-D=r34?UO4KbNje!0cQ<F(#F\<JEpcA6KjE&&_0@]A
!f[T%CbI3?tU5)RWa:WP5tFIAX`&0aZ0+<=M]A>]AW811I[,5-D0QMp1H[;&J_7NUI/Bt53`^U
"B1W!=FM@mPnDcDGr<M<08]AlaYp_LnhkrBOk^QGhDKbXX3ojZ0"SkeMU9KCC.-Q!B4)hC#e1
Y[+Ts*[XO-#6;)FYWC#H>e4=;t]AOln-S5o*9-p9))M'0bT]AXl`YDGab]A*^Snptq=_ipOf1M=
80.cK&QhtF@ciafe&KD6CSrLP0+b(XIH3+N@:%T?B!Uc&,P+Y5qE"=@C:+T?C@phMrq@^1Ep
?YuWT;ZnXXo<<7]AhSP5I@)03Qn,)Pp02B4jFc;@">c^Vm`DrmY4nW+(gA2$MNYg=*GN[nplB
Z@Z5`FJO>X?$3D2D-]AF3Rb+3q:"o`8NkUfZAk8YlV4gq>k\Sa4/q#q]Asr\h$;oEM#KasQ]AtY
Dg2elYEpD+r6JVDUqOpc4&9jEMLCI`he'_.R]AmpZoT0m/6n$<A]Aa,/+hT5o3:b586@^>#F_R
&ojh]ALEI0!1#Nupo^?3.h-HQ?BQ'3km<sbr0SC(Pg%JK?i[kMDB=*0"<;:&,[$Y_<tmsh<g#
Yl$(CWGS.`oT;2"R64Q70]AW;c56#_0?gie"6?lJF1mXKe?4O\Q&hBt^3lrLO<!:Q*,[9n7FI
)_rWdPr8AQFEMLj^C0knT:T%G-7Rc-D`Ei=b+)+#A#FdgE[P8BBE'gHDf<pJ3S4mQ45%V>[R
ZA!rL[Ch3s>^0?O%gr+@_2Jj$ZK$\bVkX'i*\+[D!"_(#TT5Y#i?Fkeb*e1B1t,=JmZ_*@ET
AHOIgT@u8=K1!1.KE,!<*.aFu>C^rkaH#MZI,??OAngpP5QCri9U>!a'aGQ)i7aI05m@Vd?(
!FjLj5=;208_5;#%@E,Hp\7RPKbGB(8i`X/]AIDM>^4s,[!Fj_AJ[uJ=/k7!L78S[6+$E=_sJ
&uHUdM#d!'l;B0&E,6MK<5pe,Lu5!^S9j@kdqD.0ed*iLgS_+R8X0V<GTR'X9i1C1M&R34$C
1Q80.bTG*SYc\G<+r"CqU8u,iP>du09BP$RES:Z+D46.-\n#EmBiG$G79TZW!idR@X9sf=o<
-*)7UUed$a;&81"$]AK5(O8nik0Ri5%k7@_Qi3<@93u;m??h8468)fh0I';P9X`E"OSM*X,Wh
ni$?FIk\K7D9jM%[El^1BU3d-Rps74DafjG3h4f?68P`iVRtLTDBAN4_bm*ouJf/BWcmP3B@
+a;3]A2dI'ii3Wm/Tr^Z*dg5QhX2n<@*(`6]AibcGk!!OYMcV/:-"O<0#T6+1G_VF#CDr6L5be
\.[o_8pH[0Z>YOS>JC1\BmS?PhG18oQD/+X?2q9t?_rC@D=\;^t9KU/gao>CK0!XK2LmpN]A#
WHlt"<2h!d9,(:+@nY$-pCeS+)""c]AhO"bo#Yu^uRQoQ4eM^58neP,G+PrX$;=QS$-DJ9,62
(2U4'9OQMBoN?>sXPf#hth_;MD:f`L("JdnX*QQ*]A4N6!:RX3:@j/m8*N#G/uIoH`DS.OmAB
rJLDJ'%jO^+7`r5(e!UL,W[_c_oRZejj@!uh1S2dCi%O57h<e1Bl:m]ARo42lLW9^e\$9:JQQ
MIjHU`bIID+)"r&%2uGjPYY>S$OG6>dBkRp&skGmi`Jop>p2t?FhaVEX<4H_&k,NLE:0a^m1
hk28@U#a;Lm$Tpj:kb5+_O.[Kb#aU"KmcHD-r]A>W3B-76):C,*F"2aW*(f-4ji1Ko97Om8,[
Kb%u2cP>Y&\2iH>IHa`m_7\4,MBLb?75KWI6GG&7l;_u+/uc#>'n,^"J'!*RjL&D&UF5GO#X
6qBbGY>T4SMN?Z9>W(lIbfhI$]ApuW6@9MW4\YL-J&Q+',C'\[J^9:OQpkuNJ070G%Q9jd0dl
\[1V92Pd5H&JK6s%.Wjq06b[UN)a>=N*3R<.:\#6Cl_>>?fY4cH"*he"M=u,5;,7ksH=9$U7
gK`n^:@Y/Z`7NR,UI0546knI.-=l/VIcsk\ODF3*f:jH>[DTkLfY$O`=KR2c#&qM\S`ugRk7
mrn"jaDE#sH6Cj%u*0h0hAm*b"mX#a6;9hY`e*=+jM$d#8H#i75:UK5`*'@mU#X,S#W9_kbH
?=$.pVOA:H)WT*8l2BU(i9@S21gO;]Ald>"c:-?S1Rd,msi(op'C1[)EOFZG:>V.DDGpnd+B8
q.WGu!5Pl\\T.it,R]Aa8`KcgUfY9l/VL7A)?6=h;/8ToQ]A:5mH\8CUd2A"ZYQG3;4V7j`+^$
%ET[[5ZfJ!l$=ORo99ZQY,\CnHY6h>7)UHpuH#VF&%9*9/NGkXD."V,o*D<[a$B6-f(tGO<R
`A!,!MrVQ_/jn`.Sk_Wn)I+d]A[P$)pnSh:JMb!TXlkQKMs!'2VdidLj5'D_k&0510@J:q;8!
2?<>r990s$P^<p@rspS1KI4+_N<EY@_AY>9O[^r7#QJ7a2^#$J^9;`4H=8tuMVD?0Ada#j@s
M'pp(@&Ujs2:"h6VMA"<)Y:\:N41DJ6cG#]ARf.E@b>l%]A$-;"tH7@"CVZnl5Q-jZn\p&^raS
gVN--?\L*P(i9ii*__a+V:]AiJ-g#h[IBp28aPYan1pXbuq08<6S!hGQP#N.\>L:\1?X*#25^
&NR`+(kQ.XWpp20fmT?.&9_G/!&eGNp#emfdlkXmY+?Qd[ETR`7DB:5J!oj?O+=r;qDf0+(i
41UZ?Uj3Z>9]A+.3Ou\.[[5LE?r37DcRK'B3,F(8HV;2FI7BO0Gp#CFWG["Cc\[3dnZ>FMqQY
%f,Ylb8#o2@OJ^:`2kBHS'^>9H<Zq!rI*rCJ^L]A:2fo1L<I`=U^1-nJG$j0"D+=U>i#-JfB(
Y,HfD-qg-HX0-/f=3O/snT=&,j1^2AJIP\R;-i#K1+,oj[c[4E`'fiCa"T&'@;Lc(#QlC;As
_q:L3bW%_t[d9Ok=e:.8t([+JcNn$7UiaO`:R6pULY5p,;f0.thtj=iC;YfW<78*/+kYk8D)
*H4pR43]AKE<>)XJp,_]AQ_=@-\);GTpF.um.+=_gZc#b>9X4s5;:8J^,kgmk=^jmPJ^2,c$V3
Lg*C@\G>(XIGOl9@W[RJgKS6Fak*!$!G+ZiUupFatATp5YeOmSc:NTV@95(oC.chAjN^2LHE
N<0r@Te3(.\sWjg<$/&h>?[02QAd@!1)d>!bZ<3sp;&^T)6T"5+F2`I#$:G$*!B/bY8#ZCdf
:1RB5e-s%:IQ/nQRH`7^k8rBc3[q9tnb*dReR4se.>`QuQqWPXf0?[jQKRQll"5Qd>h$A*4k
Xi@`/G+rC$b.[I#I\iJX8h,nHJg1f@Vr&YR--S2lpV5:c9I7&J/(S[d\)mCj8(R.NLO4jn<#
AcGMVo]Ad6&S0OO"T!p'3GGTQuSA.FGFhhB&FGU#n28L_>;):,ne8<M,")rb)>V93+IK!88Jd
^9[$RTe3e/hcPO2C@O7h3-@DGj\j+!*U`"Xd1"qRua52[1<IG]A,rKFI^8Pa$kFa3WtQV<"ct
?jX-rJ=/K80:eID9qA$:fuq*6KScX:9p#Af7b$NT-4rC^XZJIHt3VDQlc9OID';o)D"`B-Yp
]AL=>"B.!s4ZI<ZIC8&T.F<m5%m'^+s:TF-ilg<@--Q%<_dis`9Zep^RWAT7<^Z)fu)-B5D45
gaiHOFlX9epn+0`M&`NEd=d!oc0JR[DS3E9F*lHUkXld0E$j&D-t-Vq,,Kb#OJ3GaZ"[*o..
rkji3T:m;0d%*tKk"GFG(Q>7X*f3F"\=]AcPgD!GRrAmmfW5Anp7f7?jqk8nObe6uG7^XFd*"
)A%tYMn(C8gr5rBfDR5Q4CZn()tco+GCp2dn-&I_u#Hag;:Sr%^*!Ce+h_b+4`_'lQEB6GaJ
ubS76<M9qet7X$bm&F4K;%W2#Eb*9e7aEpl-)+G[-tk^64#g//e5I!J9$0QpO]A`2.568NT[@
^d;Ko)BO_&Lr0@MFr4d=I05%r@&IV>/d`KBm[-0IY"P=P"WIqU;DE?bf=``C'QQV!'J)ou!T
Of2q-3'94HF0<lu`IT0q).,8Y,'[RS;,ZAEB5G4FS7V<_W[BlI2dAfk&o+XiNpYOBHV_XKtM
O`;*eIB"4tA@r()WI^mG+K0gR8W*-sKjeeDNJKN2VmLm+13A!SQ&EKu[&")]AJI)bZuQ\V2q]A
ZK@,ganKNA]A'HUX`qu;;[$N3OUW&/W.W%"JfKg08m/AXk:Q>UVP=lf[SF30C0&6<$X'O<F+(
*lWPup-7bA?f%Oc&R>71+pR^rZpPDJCZH7sERVNjbbVOguu>?nfIaS3mmTK!3H3=d.h)[@^R
QijbF>@40(.0\@YjosRggBCRE&[>asNHIqJ,N>f1,pG2Tc!*`LO_&QoDk_PfVqNuVF7O<d2?
@UNdT`g^ik,u/c%'Z;-"7Rdd*nF@]AK<G6V8+o6iYZC.$(sOPYkGEJd[3O^bW,';Q/Ceh5T%,
Gi-r(1.fr*jCWi:"QBT%;e-RGMJrpSVZQL,Q>L!/)%+oeQXMi$P/MbN%0@TH$=nrno!IGu%,
g7R?7oV[r;$Nj.-$b2ME&?QTo6aAhDHeNd?'>>tARU##Zu>D.=&0NmY`^]Am2T8)#n4k8lH'd
+6,s30T#Ud]A0b2A1?N<MSD@4nRuiIITbXL5E<j.!b!Q#$j8di\+==gR0!#F4\!)3sWH/KEs?
72F23!Iqp:k(U]AT0gbV4IFPr::,+$0Y@Z;RR[uBa'u6oVW$let.a&:,'HAS1aY)P2#oGqYHu
I,mA'MBd3-,+N(,Ld%FZg6lM(do"DN"_(H*.15'dZVF!<3PG"H,c<KaHpoo[rSj"7l`>(//7
d"Dn+W>b^j-G<EdLF,LBI>K?VI_UOC=4,$3ZCUQ*=4IFbOM0"\.-[jabB(mlE!tgr>=>7&lf
b14:>H$E:2opk@+S;[9T]AUg'9f"-+lr=RElUsg<1pm$KassYNDcUm&F>_'+2sV/<U5uIV5K-
Nnec3([/H(g19>@n,XN\@6-!>CQ)^l6UAApc:0)$Z4[TRMiVL.shY%AZS0PrX2?=?$k.Xu,5
HDsJ!g6VMOG$g>._<d)/G-e)C[o.%np&t/WBR+^+n2=YbdNiWdoWSc[.9i`DoTTsW]A6B49%t
"<obI&M5I,&WIi10=\"nAeCTM]A-ipR,$0KUu"F"DlQ!OSeM?s*Ier:b,3s@K%QIlG)+Gh#4Z
5;79!)MV+E*WM@o#>3i_QT(\tbr4%k-&`%%d1f*Yd9kG7`k@*T+i,iY@?E#YOOOunm<gHn21
XV>^LZZ-F*)!?SOD,fWin+`#mGJG]A9,lCN4lom#(]AHS5!eC?0f]AUqENe#M8!to0s*J3J>P]A:
\okW*%RC@f-Ccg#A(=\(>=ptE55H)>(4G+0@"'_r?nXJHXi=fmA:aC@39IKaU%K$(`!`_BhM
agOUI:j>d!i(IQUTc?\?=muUndK!gfjR8*C.P"s1q[^oPb<6A5i!^\_WHU:e/j@@=9SL5rcQ
\o'L`U("2E"@W\Td%[($6BsOdlgaamf$NOWUm-#.1oh3cW6c't!g"q<7Weao^.A(Mo1#cjTI
o]Aj>-^L2DBU)H8u_CY8!;E\^&2.a'+3[!S($c^`s]A9H=OOCS!o$.K>uqP#NP5LSZ2(k%"rAV
j4I5&/F-6B);LSQFdQSb6RsNKXiHnm]A2+s5c,`pl*YMT<Sb'_ZM*ok-Q?MMRrE3&fO.T5)hc
%\a"aMBC8N%a]AZDn:rj__h3PRL%3ULtVirbZD]A"YuqKJ2QRqXL%GLfcF`GfT60'@n5P@[_Ee
.h1?0e4KA&"M(h^2jm.C94+^]Agc)3S`,hc8U3!+APcO;0X#C(G7Q-r`2Zfd<\\k<ufqrq$:I
W'R"]AMi0ee"9h21o_(U"Kk'++^edM_lAc>X6@GD&Te-HV'QqYK.<ap4t$WR@28[kr87-\ih5
*p=UctZq76Z<)8RN1%"AW"48IG_<m?/gQD=meX!27Q$@2O@TOId_nj-;:#WX^nlH#%PmU#Fh
fX0kpg/%inPleIp5olAJ`-A)HJh)#io9JiOkqZ"O1lbl):ZRM/fWG%n_D\q(DB^>nCW_6j\-
#NTfgL]A(-%AdGI<E#"4=2o'@'??%tn6U-,g,BVUYCV=jD>*X_dV!.RkdS3QRPB26tHjpZ(?1
/4Ihh%0p:3Th,<Vs4nfEY9n"uQNZ"q>e["F<^^i!Ag3OaC(^*8E-.*RL_5,Y1HI3HL%dPEAa
hQ_Idh<MN)P^%`<(T5L3inIpS)NHh!af"H226\+dufqh4gj`%:CD2!I6KN`CC2Bo+.gKluJ.
BN,kmkp"E=5P^gb5W@,A^I*'9"+.l1,f,QQQKp6DPZq&>[YiR`1^h+&0j9A+:\#jFt8EN1V#
!e,_Z4mN3R(uP<mLqBh+5f"BL06ADNU9ff,bbinI1H*HGlhAH_=I=4Cu3qsr(mOK)"1:"6tW
>-G-MM9;<(/lS$>$il/`l>[Nl$bIr"fnJ,%pd.e&+?KR[Xurm"?mYQO9o+mf92OIfqf$]AbZ*
J_&:VWM"ZJR#UMC:>?>.LQqjhLW&J93LFTg]A2"_J35'$RCT2K@MLH"KDN#N<`dGbWAX91<9G
Y8t$W*XVW'gLKcm\k4/[T#3^ScB&6M"l'LC/_#X(SJGC-Q!:N*'pao[&F,0Rr`\C$NWU337(
DM:/Tq:N<P$'2-Jl\b03qZR8N8Qh%$o6]AJ]A^Fcka\]A!7$>C^,gHjOW/D7#a!t6eJKS.<^HkG
QnlgaW0`jpc8X"]A3sSAeH$9O_1"L*^:-/We8_cS2bG"#/@>5!F*uA9F+u6L8(7630kUcb*3b
$oBm=1;6b4`>G?r(IJ@l/\`+mBe&f4b]A&;4$kNRAA:3ZMR:F6]A('l!-ig6;L@2MR/CTdeV&?
@@5Xg,/26Dq0a\b'"&kc<_kq\;"J?Mh$sp$YJ<S+MUcp:SQ`8+FC>L2X[l_`I.KN<O9/!ClA
V>kUth[7a#R[iEh[8q)<)J_"rj?s0'1pSk>gjL6g3mY\Uj;\dnoS0$sXl48]AE+3&3&(:PNfs
0XZ"*HbtA3Xc4Ma[#":P]ADe^3%s(Xa?.$"g,_Wl!!:-"=]A?J/qXlesS)_G7[mU`+!^?H)B0@
i*2L=<&8`l)X+U\4<h.PIRiWRa8Jb+n>Z9okWer=d(RF?jjr,F@@3`EsXqV9.s_6Q8(k?RO0
EM]A!T[8oZ9YjUm;Br?T@*K[AGTaT=Uu=.8#YJ<IY.Eo!e:-lK&-)[@*!.k?L:K>h&K7!+(2"
dNGm&UWSe`dV7Ta\"L`Z+/8'i$&O%`#Ns&"aRn$F*uE6sQgs04la(DF/6F0m"ad!*(R/!p;0
CJ@!r.NrLU<OpRJ0Dm2E`,Ee-\3-nia)%Rb8'X`t1ck2IM@n)14P#<)E+`p.N#p0]AgB_Ep@l
/p1.1_>["?1'WmrFk>FBlYAnO_SRGp<cr,jF]A"f!Dg>6WZXj3D<g@@MTr#p5:T9I0_CeF+CC
!Uh#S@f%VAP4(=BY*!-9pg?%+p&!H]Ak%RLQh'*N(W'RdnA$P4JJ+,(B<R`TQj<'K@D+R:PXu
UP*eu+,R4qSj]AG5c\c1qgMeTZe!!qPWs,h2Cf.VdbcWJn9P)R-.#'rdHD+gT*L2%V@4<+?\6
B'=c\?sj7(Vi18d$Y3cf2u@!c^Z(H@A#FNhG72#DP6.U=:,[Cm:T4\@JsI'ic:>^]AGC";1i8
F?+$^MKK@"2T*;WgtS]At:\IHukAJ:KS_%goH=Rrqn<=EK>LNR<'0.[`mj2Ws\R<Hp&RXj9K\
Gd;bffH=>oPmoDm6Cd&hpNefK`R'U"::G=U2Aj[[fW='^.H2tD/gJm8;6?YSd5@CK96UfCbE
_RWKH=9,&ot0mU#d77+Y?(7!Dln5WQY?ftZ!53$19S_R9YIjX>S5:U6:An%[0b<H6H)R;M<e
".&*k^]AFBCa(%o*,S)19,P_j+e0Ypo:H64Sn%[5#@mE&Ibt*6T/&,`#iB"q9Gt,)!V75NH,X
(f\Wl7KQNDgO$laQ?_Xh5j`41P_1LAfP#=@3_M5_DVE='S+pq,5na#D[YM]AmLWgNL2J/Dj3)
34o\;&X$mBLZGY9g=o^&6%h,#nJjK[mkj4e_qZVaViig^%M@l_oRH8B-Bl8^gj*QPD/N*#uJ
Mf1`1;.<YaM(d!BPlEIei^+HT'@&47lYj8R0IUh>DH\6B#1sXrooB8,.)h`+)*6aRL*C\Y+e
.^G"/,s;b5jP5gkgaPWJKC3/#B9&k^G)$<Q7XQG<WOMO.mV"O-_M`R6@7!-\+e(!='3IQ<-n
OJ_gPklRJhX94rB)N8)>`VFR-4,p[AE(M>h:,M<CJtVo>e]A[N+9OT3X`Q[3u+R)s5^>eCOF"
kV[[U&5:.UF`_AI:$)TVgV&>.KRm#1(pOHV_qat:NjNDP:(TXKW[Vsnf#=W9/,F32D=OTt\q
&A+_X&5"gAP&VHo0=Vj@/WYEWHW4YFu$$jSDr`Ka:d.AljS'o[j:8jTl'5@G'=hf:S;Efqm=
M?"@B`egSpsjT^:9QeVpDFo`>:2c<Fp0Bhl`)2b_4A;=5s&#NHNn96&P()d`BJf;Yu[A<M(U
08eG@rUHa"%1,fCl'qrMtA;+T_&@93_"1/)5b?'1VsWWm+;dK"#Sg(>4M[2]A+M:DpqQM&N3h
b`F[G#OWA:XHnN%0#L8`r@PZnt1OT,B3[scMrqF^J,nVV@GP>;Ii),N"!0[H*iJLVg+Y\C1@
-s0A"B*=k]A"b7MI$r*^I]A2H?P@p"@,kaCmdQ-nI.4DMNrem+EEBkECVe=9bMNT./<51s#D#1
$9qp,g?.HlefJ\<,4.e2XT#bU(R#ME??/`a2H$Vp/K)/B#\GnD$@/p`Y>$`+#aHTW%16I6q'
8hVR*$jqmi*V7=g*BT-l&`aK08PNe\Z[i9EWrEe\Q,-&c.!$uh*d.X18/pe4//,-t#N8o92/
k<IVD[LgDB'GKNf'BD"O5aUt):pF\c<JWt%-lo)GliU2;Q?eGb$59#:p]AlS7tU^)ZSW]Aa:>f
SN306k<d=.-RlNSXp<Vuh1JlEi-[+rIEASk8LX2uVO8X/WH2Z5_f_1V0ubKFnf`.=9'#9ro*
9:ITYhLpd4ekAo)X^-5R?.pap9rc4EWR#@F*"tiJ=<]AAB=DAVY$6d^`72q0f%nL=RYUuWl[C
LBD+Bgc!FJbl#"cHlR/b.pKD0Ce%O'8Qm92YQTqP;63&NYLqbA9u)@lBXa<lkI5[m`9^!L5A
Z=]A;^3%S`Nilc=VDk<72`3u",Wn`V94P^/lN=B;M$(Fq0WM;"@co;kgEXW6Hn3Mtg#?lmoZN
S+aGV!="ilp4rV;[BH<I:dXj[3oF"SHENe2H"cCnT!)f"H93P8m*j*;/E!6boVWdQJRVsC3H
Il)Y"P)`1bPDa<@W8PcQ8569F0VU<t7#pZ%2?CkZ6pI7>sdMElL]ALWDbYeY>fW7ul&RN82oo
4sANVm7S`L//$gfJ&'q_F3LP#7_OE#,k;<L3OR,?LmN)=JZ2esJKlTthA/k\dbe`)VdkM[UQ
s6k)>%;Od2$(EEND>/qPS%S@`RJVWgocM>ooH`:2Zd&$Yb;,ZO#QL2`&:HJt1F8Ce^F@0-CC
TU1H'#;(Au/ZTG^c5*i1>l5Iqc.PP3%E)'fAMM8>7Fl,pWeIWsd4`$MZ(eTEA?IK5.Q!OE=(
.a.:a.StY8bqBW>3I3bW1HNb2b?tepsgG#&piSdT&8(!^NR*?MTRiUfMb3&hBen$GZ/t/VZ#
DL6=7\"NZQIneb.uYr&pWBjtKoZi[?scJE4$ZO.*gnGOrpa#,V/fM^7lSjhujT_35(`]Ae,AE
G[%C0'$iG]Ab08^o-Ja3=5L/%OC.Ir*V417Q*Z'*ahceCR-hm,C4`#pWd!I`>b?!]A*6Q("([X
p/(cjR,`_>SSN;-SAreL^0si@oUA<n@;H%3d(AZ4(ou3AH$PIp?7haj%A)1b'W&.eD$Z7L\I
AS5QJM:,O#1E8WOoi=!Yu.qi5Q:[Mhg:9VMAbu1be&ocbD_4aBGW!mcT*Au,F[sTiHfK=@3/
auB.s,pSH?%[Ohj-DirG$0^T>J8]A0:*QDVa(U:-UK2nhXLFMs-8<^=C>@od/O/hRYip+;#oI
gJ$A7V\1-H+B_;Mkp:<RTG;&XQKLL.W>0iHJIQ8_nYoi"%g<u:cZ0EPkO`Y:p3(?/ZnU0k$A
@ic!Ld-.HGejM,enX"0C5Y:6'PZ?pukOr^in4:R#($;4#7\.P#EgBqJq:oeRK$]AYIC$?5!&I
8F6g_!V+M<fA7:V.<[5_.a-?;N0%;WGRY--f7N"Eg`R4+la1,UB@Wrcs3G68G!cYRr"l'd%t
N[]AGP>K5MIPqph%RT6;(40;T0]AqrIAJs1]A$GCSFo:3&0_kE'fD=q1AqI-2&TVkaO'Z'K:.\$
)#EYq5h(-`nrf\YEDL2g(M$e2a%ipFGGC9*"gh12cn(r<]A!<(<bphOL5e-l(9FI.pt\KsPl"
tp"tEA!RVab$95E#!D#C'dE0#=F?*bqJ\0h^97pB]AZi\u3g^B#98a&DMA!I0?6o^SVucQk5C
85YEDO/a)\OGPh`IoH$eW0Sk=dZcSJr@V7C.5G>4q"0RM1UH17ZZN6";4Ue[^c%ifE$1&f6U
e`L1$o&]A$pg1%OY\h=bQ6L0&1uKd6]A0k*"f(<k#(YP+/r!,,(N1(naMOF(OdY1s7$.-o;uiD
))?iNh+uj6KOH9`8IlX.K8tHqZT29Mi:l#n961[5S`ktn7%Ue<[klGF+;K>&S^c3$nZ=HAok
(4Nq0^P;J]At1tFTgkPN48g<Q4TNsMgIJ$Y$.5,88qS[7&&t<0<igO*.Thc9\Fk5,hO@"H-K3
Ol+8C*8YIH+?bFp=+Ha(kbDH!ed[u[%Kl]A:ZcD8@@fV#lk&MaRtWDl+orlLMZ9@'b'`@WYCY
0:r'kWUNXe<msBq_?BQW^8l>%9-*2%`]A)1Z;VWPR6odJ/`Q:dG\mG6*p'NYf]A1-^dbRll!F:
1-C4YlNL0Y(CTA]AE&gJ3en4S;l(%TH6l#j-YteHo`dQ6!1oX"-bqoTtC&F%nf:De7:q2BHep
HrAr()br,UWQaiq(pm$Xl(Kc>1c1*c[7nH)5$n3=V:.]A>%P&<_.gMu_l&K6[KPU6g]A)7bcm<
keP6.sf(D&>l?u)t7*8$*0f;#1q%.6@:K-n+QAC&3W_E1J:JWZ"('\13(=b@+Ac)AHoAU@Zb
;9aELFLZ),R$E!O-f8H:KirNtU.OGC[`h=P9Hn3h9F>t+rJ[:Ldj91bTA@g<Q5[8^bVKbTm!
$+JdAkr1H_YP;15KE<b!>&4=,gnLM\.E2mAod\`fP6)oj&qd$3f1dfT!KQ$*/mdj3fe)#ndZ
%#ckZt(s]Ac7^s.Fg"sVXdocYKU"3`ir(1eGEijckIfkWfr,'$M>``;Qht&J>jhI;\M:o-PT<
1=?hHd6),^"JeO95,E/c`PjNqtYHI(I.="[k)=]A^QHDUh%!o'h_14XRJerg1ndeO&^%%sT7^
-RBGl>(t`\s@5AjU^RQRH%.23$Gk=;d4X(7?*+?UJWgk"gRg$q?W+MF+Pu&@_5]AZFb.FHk*F
;4p%;:&kB@ouroq90SV1_r`cMBVcgi8q10I+7K'*I:]A.TbXpe@JPlLfj)HbBO!)4bNDi,)VP
lJ>r:/A43p5`j9:XrrgFk0-b$aYuSH=P]ALp,Vg*'^BmlObT#;B5hG^9LDFh%[ZLJA-)W[NHY
?EOs#>C#3QT7:WT7XS_5a9S3R>8bnOT.1OMqfS:M[#ril<\r?7kf?Sb"8Y0JZAB;NkUT87.[
0A_iLMdMAkb`YJ,GN3i)B?fNjO<0LUbl/BR@9c('H[&6WQjOA-HA-giE-9I.Dc$DT!me(P-X
u^R#@R+(uM8ern@1BrPfGm"4V%$UUEFJ2I,d;:+FH>@R%EYnSpBGp^&"WLTAnou#3Z;d3DnJ
Y32cGqrXCeUbfsd;kB[Uk1p7qQ+Rq/Xr>?q`)4+RB7601(C5]AuU7S%QIh/7iunW?PjB*O[;k
6FX6[XMc@H,&0I8n:A+rac;S[o[UF>:45RJr'H-R:[3R%e_*s`B"uQ"<bX=V\7C4t6F??R%V
5dSb9<;.%l]A4rDJHG91<(p_HkcN-OZgUtAH9Y$aG&?-1RI+.Hot<*ZcF!H1Io]A?oBAmm%c=@
2Q"7qVKpg.A3k%W,Mc:nmXE$d:"*+hrC.!;n9G;lajD8:uoXY2qV``dV!9T1Oi&pICJ'.C?,
(p;Z\a>/e\H/2[i.[+CN!r*5:/oP?cO0:XiaKs_BtO.[<T\W34W2:Bk-S`<Fa?H2(RDiHM%V
F&M\qgG0.XY_3:*saBU"X_2P3C]A2Hn22<b_Db3U+Ja5%U!QU\Cll.FcS8b]AZUdQB`g0O%q`%
@sMp.]Au9:FE@BicYb5\*Ff.Hj7iaLZjj(f-/g[qXX=JLekjH\BgS65o+cZeBR:#5$+CHK^]A#
u2I]A7>(YUmGiE-Q-"`,6np.>/OSr=QU^T18^Z_c;f3s1dB9E/BAamj,UMI70m1*mds]AN?P.i
1a.FFHRAZh(,6?s)j&O3UI,(C3G>+XdJs6F('I`$V#IDFdoFP*&9s^e0):V_[0e&64MR)s!6
,d"dOu2OnhG@;aHm:Z\k22/Flb!$$j%RWIda9:#PJEa_E7LCZAco6;TB,*a2<peT3P&9Fno9
)ANL:cEEOG,[HoP&klO56J3'nn,_R\f)[Ij5R0Sk;4"F#,1N.i+.k5jF9Z5)ehN&]A&(?k"A&
V'/&C8&3RKMWmt"qtW\j+UEA=*l8Mm3Y*qo)iR=Xd8)W:RO?E0B=e-b[u]ARhDH#T+1o-K"4W
+NF6TB^EhGm:f72*<<7?9cT%,<p,V;Tu;V5e*pG;!X.'hDh5/r^O'r*d5m*8OqB3%u&LSs,7
A8Z5ra5SLUfU"qjmf@@(SgW#Q3Gp1SPaTrf=6>^fJ8bV_%ZTFgWc!D=Ug")7<<1ta.V19(n@
-Y>K4!*fb#o6T0`LOYop+4>E2IV)m.gR-Ont69pd56XP6BWFR6(Q5-o8:+MU9iVl6B,-1dZQ
V$Yo8TfMaLmTGr.tl+1^0O6h85k)TggO-7-hI@9uBeP]A)r(dBX.ZNtl*=1,<ail)eLIN#-[Y
]A=dB!TL\t@49fpVf^JP!&83/61]AlUF0fLbT-M_Ir>f'\V^?SNR:t`<[W9g/Ke4#TH".M'#ON
taTllJRm2W*^N5B^+a?(ngGZtX8!B2iXDTE,$5qrH@mHR[*8E#*P3dda!sNOs?WY^4Cta!cA
ZLTf*!E<[ND[8";Ti!e/?,AUmWLM->WZ/IA>4!GHF)NEl0Ar#$U.>N#7%(2suBuhZa25]A*<b
ZPeC6;>%ZkGHmOU]AIBcRiX/n]AA[48+I]A]A0/S7d6Y);%]AR]Aod&>Gu`3YPe3N\]AitVU)dQTVf`
OQTL#($)]A)N]AB6O`e-&j9PVOiZ%@br\Z#-B2<L39CJ-'?2eDmcHe1-L.,65NB'I9d_oq[;$S
R'h)g'XjcN&9[Yt%?]AO>BE>:]AZQ`-K8h7>&bds6S!:)rV\\*Z#kL\LMkN_u6ah]A-mCdY_$12
i4Y,!gp!;\?Tcm!=j8o1lSILbUGX'mK&Q,t]A3TK92]A6f6e@#fdS)HEuX7@lTF(BnY&g]Al!e)
A_M*:NdB,*UNcT,)*i@btq.kV>jlsQ^q;%a"T1hZdFkr5VZ]AK+sP>ulZc&F^PCFe'.1iU'_^
D7Dg5VJ&57]A;@;9O/m-ma0Si92YbJ!q>!/nK,B[2`Tn1?GnGL<^.LF12fMcX@,F3_[T1EojO
=&S)6RN-gop)2CE?)U@N:RG;;(?Lh`l5,e5Qe2\Nl0Tpo5sE5/CmTpl,%c/kgO9!r?C:eb,N
1F^:qGLP8',H:gn)7:9X1hqEV?gIlD3<7Ag=a)^nVA-936d&bojDnpumdbT'Ma:-u'/!d`RU
k>*P7"81\B,!n<c?JZ*b!E/%9_GV&D_4)PGIW)]A..ZR*oi73j5A;`RX9C-cntte_H=]A:T\01
]AEd+<uWspcgJ6d*Z/XL`j?Kh+1PL!%$c!Lm!"Vi#HOH;e\BhfF(&"nn.3bd5hpRI[GSIMjUD
#aN`<3"maUX$!?f=$*Rj1\;.&EE2LIK_9fTBn:-o$#jA`IAJq?P0i$;fnSgb#WRLoWt\O?@"
u54ca./aGrq$CnJ.o>]A:)h^Y@."j7KZ2/f*>2A&fjZI:kNn#G:C=)^bt5ZqXNPB[skcn^Qn%
5l$S6=B?%gD0#<UDc^*uUW/#oTL@@r<bQL?3K%q^%"%^$?:pgXDAPfg6^5]AD2h$_PqYhAar6
a>;M=TRt.Fnat;7]A>$5OU4V+T_k:I^o3Af>*g(R:9V!nMEna;?_]A4WIZ!$/O$<Z=q#J]Ar2^T
]AK(.L.;2ZBg;E(N]Amo]A87Y9jCRRdgo*&b1))s7DR`1k#(sJTZ5?m]AH\ben9JKE8S`XD@<\TX
#a8L6#;Ci]Ak<ZqqjR$B;_#\U/njdts-I?!#D3_2q3oPrr9fs&(?_,VCKodjNlC7W_'"U+"t-
HsoEt`4/g[-0]AqUX8.<kXg]Apg8Rp<cH_)dGeGM=e#i7]A'co6.X!NYN#RTrn'X]AAcBriWKM*Y
]A\e*_=>aUf,;or7UZ_%NARAQ/j]A"=UDNNK<_#q!AHdd$?J\F4^apra<#55*O*:*EQe@@^9?2
t7A`Sdmb:W1Ko#kS1L(-j#Bbun'ZW3A2An&JPBH"kS@"Pt#I*ZD<13oQRQJ<cLMIgJ6cJCto
`/-Zkfh6$1&Y\*hr2(Z+0Dh$GN0-KF:#<DPA%unP20K/1:3NI.65I;`ejZO)S0Q%VuU61")b
.^6XMXl(aJOR,NB40D;lQ-UTE?2Bspg;54>;no"D\,5Lr-T(C?bUs-^%5Rah[H%TN[W>Z]ANk
@^bd]ARWh;g)^HK-oaSBSV8GX_%Gpl]Afd:bc]ABRTb.l:'t[#Te\OuC\2T3YZ/emfCm,j&bH-e
ri6Up$!U:sT<Z\gdK;Y,G(h8HNSkB,SnO59K#!oJ!EkajP$KI\%D6#ek,3kprWQ:kTtKFX?d
eQ@+,R^]Aq?ZE%Hs,+a/Vp;/Z;ZD,El>_<.'h-C*`8/B\T3%bcu3up<GeraILROrHmCd;fm:$
C"$Io8<[F$2GQ+2)b=9\PmI^>5"I,=]Aj5g*J<agoYe?,ENHJA"$XI+h$:uhEp(UDZkCKKJ:g
YX!sO$=t+r67$&lXnee@D`.(m`mu$UNMECU?@'M]ADC=SgN!*:<[!=FU3&b\Isc(;ka1$8V&F
k\aXk?lr)kisDKQdMgXPLq^c>s8ep?U/q$NGM`m!,l0c8)JKAAEYaa]At?s/VhQMC7;[gMp`Q
o4ME5R2tkJ5e>l>>9`pQ%Pkel3^<H6>fL#@`bFbokGClts4sK\NW%Fr*kdu)[/:_ZY$th8Fe
LSU"Mt^na2"g$!3P9f9o)gC$W&t_F>A'8oh%%,_PI5(U)!3m'sURciWb^NkaJ^siBNT,-*.S
6[o>d2>Ap!@T]A/W+J!NP$7jst;$sF&tk.4dA;o#XecWb4]A1a*'>T(N+!X"BNFAp>6b`UVB7j
/%5aA#CmjKd&PD1EnNf#dHdaT\&_bYTpJu'f!ejSG<$,0HfPg)uR3YX_.*QU.k^iPrrl,ZW5
CpI'E.ars=<aE4c-:DJ/b1KVnX:p!E\!YDj;Tp5hIO*EOSY5X6k[>MR9P@\GY70``$H,P.E(
-Z1b'9bi/K4`P&6`L/]A'fh8DK,VmuGghnCK9%Q=l9q,p:7SZ=W5KmSOUN&`lh^QGAn9OHmhM
32F[,9Iuep2SNHbQA7>]Aer5_!P\1US3$/7EO:1V`U4[XS$]A4!4<8ZCP585/gWR%=o\,PV^",
YeJ,,j0#:4N;\(6jrok4p7qT4H/0ga*=%#B`45q+a5F_O\r#U,'op]A!hK75[+F9qKE\VlUqP
G5NJg3)[&G(&42.f\2W^rVF?6EJ"repDOnr#Cne39rjT-\aW`c/,RV]AO0R5eipM@oPPV4n7Q
f,)S/&\s7tt`.c8q(Yj+^VcfX(:BcHA3aPm\)REb&[aDf84m>_c&$O]A83AeWndTZjKNl8Ps`
*25dZ.,CN1mUBVPR5%[Y(l&R1-JLjTZ"CX6A;lqieFG:lBot0%Q!hQZZ%EY3q>>Aag;:Ri&5
3b+CK8N8kEYh:Q*b65INqp+gV++8=n?"4Z-Sc<W[U[ZP0I$=hG3m5dj5Jb-'RmFgegD*W9Mp
CYie\\6P>Y5LrXY@8)f!)&kf'MU2,V.?9WWZm+0bN=Kd?3LMP0qIsUid$c+*&fIgbU"HlO$Z
f$,;1"'":3^Wd7+h$;1LhRm7M\U/A'QQ32,Isuq[^%s]A2+U=0.4`O4!a'nu^]AL)4Q<B'RDKr
j[nr7MC2SA%^fr1m<<k`8OK$5t!bS`jV2*a-II--me1#(,M6<\QaX1Pf%DR!.E#9bBCYYYk=
@b#kGi:P%D<[n/b]A@_q2BgGn.IPUKlY8UVI`]A:.pK.<ZUri;o9Vrn1FNHfa*0lPKY%Q(<L.o
7u?#,f&>@krY$m5:DmakYn%dciZ^hVHiXJ%o=W2.<.9mbE1F(bNaQnMKtrXgRq@_!R70YY<q
XWTF]AQ*%hSTC\oF2TN5:AAHlS@l")@Opg7;5?Y%?09=C5<T53P)L,Je4PC6/Ns)%!qG0u*l!
--7a[!bEP6Bd)"N<KdRf1te+gM\N:76mG>b(*=p9;BFtUN,uEKf,D*d7&A9]AFZIjCW/l)JfS
PO`-[B>Z/9*;,]A%\KK`'^tM1gE8.B^3G00?`raU\(a,c9;\-pX:6=K+952+96l.s,j@'bg`E
B*^MIk037gQ3I<Mc;i2GZ2`>tOf=sRnJ)CLjNfL@+P)[Im]AF:,2pM$I\$5%s?Yhf#6GjpKod
Eicbcn,.SOCId9dXBJAYp4+YdPrNfK,huOiGR:_uU03``+Jcfo"<\ODgF-AJu^6_JV4ZXY@%
oU`8Zd7VOkmU=k3;"ne?)MgPpg@U*>q[(T<&^LG0b+1;rW&GR0_c9#X%^>FmWQ98u1&4HCc1
!WrJhk-9_o[Y>Tbh=q?CB%9-gnTcq@$IS.;%>a&buOi!^m:QOXe9:OVH=c@?n-iFdc=M]A)k:
M'e,7aS51fhkXO.nCEbdsi1("RB=J\iufa>dar`gClh/MQo#SeUqYBAgl-R)_YdRZ'!mUTr[
XIclETjX`HNNKV+UA=em8Pf?4b"?I7VI+YCmU)pis,gV)T]Ansc*6ZRL+oAq*GW!8D=di,%"s
(eZ%#arf#O!E/=t?@sBj^WI5oOb4q$?26FXf7.5]AB1kVs<FeBp80aT6V'.6;14a,j@6h,HS:
7GX]AbSL=(XDBs`%G6CpE8D\',,I'pChgl*&jm'U?US7%<tV,B+YHtkur\)eFebFnZB?ofZNS
89MUVd@Oj><4M0J.7_8$Ht(P\C]A9_[cE-?q9<r_9Vm'5e[*4H^2):E0uhaEO7;Q>Z#3*'Z[B
c1,c%OG'j5;H@OTRafL^\e#Kt):QtXEYGDaDCd37*9+U=_tdXTLJ?k(Os72!1.Lh?V`p*A,9
2t0BE0bVX+,CXtG?j0BhlXP;E6ulYpHdGq@\8E5^X[0cMB9TD0Z"X9*]AuCe$XZnm)n7\D*=h
9E`s7H-\SSYmmGmt"`f&c&E4iru``2,H\TXCh-\/@GMonu2$(H8psqaQoQjBr+L2P7FBU0]AO
>m`bljDOJI2&[QdHLhtSE[XKgJE70'I5R]A)==_hQ!6TAiZ"pJNjgA4C"_Ui,+iW['oYJlide
gX-cnaq6Rm=_S,(Oum(mJG(_O'=/A<%1`='@QOI'.f^>7?a@iH2:'-.jZDiJt8aNmk.&F5&%
DMUC>b-B(#7^Yns)'^Z)&;55kSDi**6>Vj:VM#uC#]A_cj'DF@`'*QtYm"h;%Vt0.?@$5e#@l
XnJg7h/a5q(P/<jbfUjK:+r'Ls'(u+ka=KF_T+-8&>ud?7[UGuH\SXkSU&VKM5#b=pG4Q@!W
R=/rBI-,o#4u8%f~
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
<WidgetID widgetID="be56ac11-b658-428e-8742-d9ad3dcfc26b"/>
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
<![CDATA[1463040,723900,1295400,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[274320,5974080,2164080,3230880,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="3" s="1">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=$bm + "工时投入趋势"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" rs="4" s="2">
<O t="DSColumn">
<Attributes dsName="指标" columnName="人均投入工时"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="2" s="5">
<O>
<![CDATA[同      比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="6">
<O t="DSColumn">
<Attributes dsName="指标" columnName="人均投入工时同比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="0" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="3" s="5">
<O>
<![CDATA[环      比 ]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="6">
<O t="DSColumn">
<Attributes dsName="指标" columnName="人均投入工时环比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="0" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="4" s="5">
<O>
<![CDATA[年度累计 ]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" s="7">
<O t="DSColumn">
<Attributes dsName="指标" columnName="累计人均投入工时"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="0" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="5" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5" s="4">
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
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="0" size="144" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="72" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="0" size="72" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<j1]AP@qV<D+?\=$<%t]A"isB>;Ss-4$F1u,Z"Ol+U*q-WC(X9>Q37L;+W9U_-pjpN,8*O9O]A
X2t73Q8A:a1H9asmIL(dg\6JHSM1QM5`GcHM\:Kk.@V44giPj:Ac'jF,V:G2N&c]AU\mLB[ck
iQ@:N'eu\\:^\hR<XBDm'ZY$n[mFQEp:VP$N6i=#gq7kb``TNp4e=g2DhC%"#mg$?Md45hOp
>nKL8i2j:M#I88T;\N+IeE#Nf\b!Mo;)o$J,&\\cFM-uFR[_eP6o`cJ%48"PB/<nf?R[mi%O
*)f\%@WjK\JCr;,fJ:?f&1=d=enGd]AnEcY"P]AM+0Z@iE_8d8BhJaiO&Rqeb5tXQ7)^n?n:g]A
H@t41BR\>a+0W&IQT^CsUJF<.:YIV!M#h9#`.mVsAuEN?<K3";lMI29H3mkadW0o/X80E4Pi
Osm+27QS8+"A,2\*PCcL7<Ps7"9?*kb/F/3Zg`IhY*iS,7u5F:Wg3:qFYXRGt/X+=)3_d[tX
Mj5gWmNTaOVWK*@iGk]AU\T.VLV*$?Vt`IOP!eZ?HM,J^6'&YY@8#P/k!lu?lY;X>%?F]A(uq^
8cW7`@iVn-,[R*l4Y8Co.AT[`LtOC<cppj!4u$lgMdqLMqOi'^[6[707_QYc9K/U<Nr\!#JO
`0?GkQqItl-,]A?YiZH-bP&\-%+Rd_M=!N^MpqqX[@BYL^<Kkc<IEq(ED]A\0>)l368[2%K8B/
\KWe%p::/^>[Ej7UMe22>ufqhQh.jn."l-P6T]A>5]A#9sDY,RRUI'&og2mS1K9+dS&DNRs!Q5
*YQI\WWG]A+:uPWj+s9%d<d>Ejt\]Ad_h7;D['8_ScIVS(-'7DF\ZI;/un@GXM!HmXdQXE8'kP
ONq]ATl-T)p%H8gM:jGr_qNteFa30fb`57_"A4"\R^<3r6%\U05Y\!4K^4a(n/fD,nMidUCCP
K_9?'V4q`7uInZICi9cBY#_D%>l!Yd+%I]AY7Ban6\hiFN>,Xg3RJ%2@I4fOe5i.RLfu-hgj[
a0/;SsbWr`i._S6+aSHd-H_LC!QpIW@4k4K1K9!a)bWW;j6o0rPAJ^bSt,Y>a_j=`Sua;Y5*
[)G]Ap]A,*%,*5Fe\fIs&-@-^H8X/`^mJV3<Hq]A16kL-V6949_(6O<_gSLs$'c5MA\(g^SI%m9
m,XGg7A^Vs"oJQLaMEAQKE#YCX<#mX#Y^]A/r&mQsJMY3^F]ACG(3Q;q$q6-aWDsK?.*;p.f`I
ni5!0j0)[dqntd?e4"S=lXBjun3U`@VG),rRO#e/h%m@_1l-O;1n"4A_W\9k:eb>>Gi9U[#\
(Wm?-B6^)R@:K^r+"tP8N>p:r6Z:Xf"`I&I@`+U>VH$l*p2Tjid%*P]A*;l!Y=jh)01MR]A*Jt
G\KmtTNCZOVQ3DR0s\.@p_9-FI"oZ=>3@F2$(D>M87FXBAf:;J`1!gtGm"&KPq`h&4SUDaQh
`Nc>m1k<?PMD1UVb'6X2Go-Y!I?I=5qn[23Q]Ark4!$i6W5LW&=B0,cjJ/g8jbW0GW0$GXG`:
4ZC3,M9$\59[<1op69TB;Z6/`7IP*d2)7i9I/fjeKf"8b&r[hr9(MVH`V[L7[Pscud%C#C_i
<_F)-S1(,Sq6Q%3;dq,h>`Ft=bOKQtaY5`%=p4Vcs]Ar"$.TqkS0En>DIFE)-'nFXK(?pT>j)
e%/C`C*(NQEQI=+_1H[$5Q?M:-j,aE-`R>c.U!lQrl#dWu:(qod1Th!N#l!(m#R`D0H:mgY*
%o!DT]AT[5X8n,@s9l`-NH@<^X0@0<g2.j8s^s$;_<\VU5tncd3qoh4$^?BK"h#5,B+CFnX5r
nBF"o=e\fuCb\>P;%K%00%#K%e)<onE>Sm94H49OENd#b4e#'M<sX%CZ`u&CT]AOk9r<=Gc<^
A-%&:k-Qa!9p9Q1&J4SHPRB$\nV&CQg-$geY!;EC>GRdJML/_Jk?X:L@0#*/(?<(oJ40H8V.
_'VT;"G8g:(=:<"dOS_DX<N0t0fGP^G\J`6f'H0s+54\orFSos*r8Eb7,q$]AuhWQ@Xp\o9/l
J3q[_h;=`6F63%m.5H`Z7SXa,%WWps,7e<20aj%-lpHb)+8?-1RTE(L9]AV5irc:VYZ=CZ(_;
EK^si9]AbuHUmJ\elB(Neu%4+WC+l<9`kpNo!mEfXtDTrFBu0>GUi*[#AYXAFct[WZ1j%p&TN
)kismB]AGkn4Ptc";&0mgLOaZZ0*b%?[@\q,=0/<S5D2#Y'+`fHa7=`;NXW!2`<*#u!V0`J13
6hmVss:91_gA>aC(B,i_DCaG"F)oHpYM@2ek`&&+,ibraM:p8un-?N(f0nR4+'iXjXo-PHPp
'.oX`$:jogJT+)GZ7nY-\jhLAEieh\<gEJrj:Bi[[`%_'\VH*`TrF&N>M4-:A3/Sjgo(%Tlp
("/G"RV@4UKrJ*GL^[dj*ejSK)'Y+J6_*sG-:Uf$7#II:5MHN4]As:.8"S!%0gOSdab<+f9\/
Vh[@Yi:pu,3`$Xd)RSSuq_*dGVul?\uf(n6VlJ3R#PPF-<ZV"3odm,N5LA:;JM(F:=Cc./5!
o$)jD(2#`"-BH;6i+e<0ads"g6]A._/AB[O)@Y1k:"jscIg5BcmJCm+iJ:&(W'@1km^Y`BFel
I9c),kFqC0@UU/"$6k(F?$Cm8ViE3H/%J$2K./=<-oea*T$@Jf40aKl(i7%_f\0hTLEI8fU&
Gq./X<#KfIo$<JYP"V6ZE`>g<_*2,Jb&67D7Hs3,?-jO)8>aRHK%Zt,aMOa<[F[k5b3tOtg*
[G?BSNccGUnqkI%#fff!s.u_4RkHoE\!Y&&uLMA4YgH>NUd>S>GfebR4AS2(`)7,#dZd,l?:
rTPWhtJaI/j,W&:"<qB'st!,PRVT6#E^mjAG&)><HV4&jA=Fh0jRP!@!Ha=kNL9LUg\5Hi81
ED4e#C"[0\pp4LUDLc!!%:s$FQMO,=`9N`2_jr902O<0<p5j1A7t.IUZWD$VPS60:j1?(/]AR
*[7O)`YQlK.^9Vjmi,,Ii]AdY"(RBHC(Td2J]A#al'(N*aO$aSkF*S^c'3%%g;\OnJCU*qbNF;
',Yk4Qha@%jrG]Aic1(QR"eE0^<<JP&-rb:g9W+Z<A"IE[dNU@&_c&;Bg=(\3%W&V#45^P8f2
IG?29/J!j&;RF*TOLuP9O?a8D:XLV\U0Z/EF8N3FDDZM5![Vh<UQBNW\n<Bkf."_C-3a>KES
1/cW!i#.!89==!/aJYe7.pp$9/4J-EVT/"RGg(]A-XLl=`)j<"sc#(NPA#_%2Q(B$h682;b\e
B>[j"LbF[]A6_,LtGh-X'dh;=U/l;`j04mKJ\TcJ@)iA<$U'T/j/O?e)l:e>lDAb#ZVVF9l=N
JkQZ66e1VR=O$^.q:l+U!"ol"m,7:YHlVc-H_Hs00`*OT;#XI6Xgcd61?;1,guCG1,-?p4Zn
2n!3AE\s7jBOI/VgT!+QR>e2#$pI%K,GNR<4Z2u*'0BObj[q7nOYD[m#5;E]At^Y9D>RRd-ms
1F@m<KWldf.i`^"S\-U<[<oVc</CU&o\m\L=2)0chBV-l*lN#<2(F@fXk-<nu>:&+LsdjUT`
pi]Aa,%Nf$l(J!k_U??P%rUOOPKeBMCcU7?=Chi*MqXeU!eXWS$P#m:;.NOVg80);Y[fi$pV.
Zq5gnGS)Suc0:iD:PPoB:n!^<$;-_Gn@k4=bo5)(52J5_[F2dXmVj>ZcQ=X&NoPXkpOu%3Jb
=jC9W@U%a/B;aRdR8W2jT!WlZV@EX`sRt]A:A/!0V.?DOs:n_TD7`r_8o!-%"h\C_3)quoOs*
8-gZ8X)cY!td*5?LESbnpoQ!T]AqYo=k_/P*]ARJQ[b/l]A]A_aSHLUg-P,dG=P00JeE<EIE"e0Y
r1u!mY-ubjp4q3;R(Ot&/^j8P5Y52iS'\DLGu1!M3B=@OVQ;i.00"\bJ__ichd_\[=]A-p\DJ
]A?TpmGl'eq+A[GOF@Me[Q6!@e6L>aE_uDV-U_;i7r$':0D+3a':K?nT%0"-Pp:heJdM?V^@E
?!%87<C;hqc@EU2KS=I@9#ge&,eI"#&n6`A`NAJHJK_2V2+4\!_DWQ\Ml=5V*5Os`"cIn]Ah7
lS?G/Bp*:<4H?F*roHSos)lEjjl$L6#IJ&4YZ-@*tZ63c:&Fn$GZ>cUJEsD4YIlod/n3Xa%P
IEVkG!3J%V,-rb+\#mprae5c75`Uf:pQf!"C>,B[l[coEC:A>*WeJpo3^,9%#N4)FJ:\C-/T
AC.#TA.;qa&gm%f@^f6gYPpp1Ea\A<(5X\4Q%S;J&09aa:TD`&b*r2H=cB<[$4e.5V8+tb:\
.g.<0<27_E4b-hDC/m_uTq\j<.tY.?5NY3fQCGp>T2f.rY4D`qb8pA!IU,q@9TYntYbL[=GQ
CEN>j.#W<X7b_Ac[A2AJ-C;8"UM`@ear3/g["fP*R6s*!+,4lXNDN#g-_C(<&9t4"T.1!&H$
fJ3kg8<?P/&=/@<#<a?kT2cU+:=H3*f-CmU:.)N/ptJ4Km^a3@V2MjKs<kA,GDhI06`JgeJ$
X+D$Z>78_#gSIot%W*n!a[UBK%qDa0g3(KVQo2tW+j!5)$==r\$`m1F_'rsh;+I&'/]AP_j\?
)o9SlgHbmgEKk[lsDi[heB^>+5oqa5H!V2X+/_7A+IVm)I[h%b52J;@@tmP[Td0p(r4#Xf`<
*("1c9##o`5UmfeU;naB3IIo;L%\2W?"9]Aap5R?5;)KnnEm/QY5u18:A-7[)_.'f%"Wfjo)_
:q4U]AVK7>5JJci;k5tV6Q3#"aRoO.`NhnQ'Q`Y%omAh0'o%rr0It#6"MJ%A2PP+irc6p4tL7
Xss:;o&"a6n?26'FZrTQlpnF2MB^U4-WPH*Kt+-Wh2laI[u^*D@;JC!Zk>mbatGL^!!5!!+>
2_LE7(%bc:8Hj!`H0GDn]ABEI8bks2S4#T0RtOpgTokKs/h*"O@S>bR;/f%hg%O8Gi`!+QK*B
m@PpR2!3aFZBLHd-Kt%UZhb"H1q9jYVsS.3p.u^OlBI?!)CsbQ*:[G5'9=$0>+cij[*q;)i/
k\Dq"5[AT')4/2YD!g:06heB-NLiTfD,bq8Dt]Amo6.Hq(/<<Ee[D8D4,$H1p.#1oWQY.dK\a
3-DP2&`em]ACP)+n$b-:b$[jlHZ8\&#?JK6dDlElGp='Qd=dh=R+O:4[b>_Z4&f>B.Jd22J_A
<-f5Q*F+?3e\,cSsK>X.h97IYkWcfpo%ln<#2PGr2!:[NP]AH4Lk2c,003N3Uk6TTeuEQ'%dY
N(_-JK[Yl>pA5s>"@:S."TMK8G&NMg9=MlL,\]Aeul?XoI>@^p1aB05(hQ8Yk;ESg'+&:IJ8$
.DI_EeP.4F@h9*</A9%f3W2cd@+jhhW@e:KL:-g0Xi?M%kEp&AG;Rr4oV/bUa&B@PN.$SbUf
fg)"'@NhW&/R%<;?e$?#:DFh0GZTZT?piP-SM\S#tDSQ^<[J".bbLOk\j%?j_kK^0sb49rcX
ef4^L5cn,g7pV9.'SXR4qbOVkJS?l?]AX"F=7kZ2+Wm_BEeP/`f5^$:_lqi;4/O3XbS%-?(e9
j&lUFKnXf]AAjMmX?_u0J+M/;kL8XGr2Wm57]AiKSS(Hi-/7N+5'1.'4%.2X(DTOrhb5P`);B4
\_j1O]AdsI^RW!=eKf)eF1"6AIoYjDS.dDa(,3*oG3*FD7U&$#E&+jT2ce*6;kerL%s=^('Ol
`iII9\u+3fpKM='g7>^@tlH^TjK,gAFK[OO4l&LaPoH;;T0pfEIg`;r339^94BI;E=H]AUBs8
Yf2i.<4m%"FA5Xgg?j`$4[IH^Ae5s:<sPV>Hc)$ZX%\EF>mo0?9Lc7)*NO?,V8Z[%=hmT)(*
$LBG/1hJu9d-W**e^FDT=Kd!DFOOOpF]A^=+$Ia%Ag.,c-R!QpAZCIKJQ#-n9?(C_a?hELd6E
n@5\%>sZ7;;`6GYf+AVh'tWfH'8D:0$!in-r<aN'c3@PSuE4orc-&<,92gVL%Wi;R3K"%OcR
_'\jLU=)#_Z`-XcXmBTiu#<Z=cZ)c&1:c)DM\LaAk\L^*2=59OV+,5Q^a3KnanY=L)R9sj2m
>_KQZ>X,.<QO?K*Ppr/<gnn2@k^R*f1hJ47.a4iG/,Y<,UY5^40*efE+a`JG)d\0H!?0o!gl
"&5NHXDa+%u!o2CgJ@iC@&M18Bq61Lb?VR9FFcg`kI7u+Pp9Jol#HY$R6@#du(Z\),K2Jrmc
@mIb65gtm1L6ej.0=$8A8O3Jj+?L9-C`Im&5]AQgK?[Ca7g,_7E'4$(2_;qk__Y.pUZm0@XDN
+qHo5E"0P:7<.XH5VE&>Mu8:Hm;QR]A=c6I3IITD!G+k+`.`D(hAM59n2fB-\TTF>g#2Q#fEX
)^&<>r?M<L_mhqh'4bUjCaFV5D^AB)3Cg@!JCO[77U@PUI[4GF\7"5[OP=f(9@koL.o3A!7L
lF=6gH:+DK:gg3b"m7cK"?;)QD-P7DD<*<LM=W=HF]Amgqk56@BgCU@4Vq!,^MLO]A1#t1^F7T
Yb)4h<HmLGM`S@2Vl$8lIOhgt:ahI/:tX%-j7<K<5*L>s<W+#Irt9r4)T'RZ8@;+9lIq1jUT
Bp0bH"9qm5af4l03@lA=E!n).YjcA0Iupd\U`ESBL>]AcuS[ku4M$(%J'nX2pSB`HZ[q=G%`b
j;XbN*.?LP$g4!p_86n]A:CLCan7Y#RnriFC1Fg,GPYR>iSfGgl_5W-"fNL-71eio,aRtBY(Y
tbXDf_n8>FQLcs2)`?;O?N4'dfO+r3_5laVEd\Op#0TsWcWP<(to$;9cr5itgI.Cn<`5gooY
t8,K:L[bGCk%7"]AX=9t&?5<rK@:qg&rFi!Gmt<TerQt62Nfo6fE67uG1L@N5sKA6AW>=Ob+B
Y34+>a>Wgr$U:JQoT[Zh-.UU@#&Tu04U]AMQ:N?;q3:jq#\&L4SQF,Uodn=86$$_B6M,Lhn%*
WX+H;>"`$hGYk-kj#oTYCR?KcB"cWRX:f^\aAj0h3]AMkQ-h*o<]A6o&@ZVcG+lS8h9]AVMAW;T
O#Z$=1AbG$e<,s#,BJ0gNUjJJ3h(@j`(Gr;eio&KT]Ao%e[uT`o),`(C[&q)5Z`&\E-<F:Nc-
^@K&ENo7Ld0n.I]A_B@m`52R;\2lE'ZSUi:I72UC@A&r_n`o8r5XmpT!]A-9GWIk"2<L+m#gpF
\jlg5XLU3\[g$?;8Y=kq'0<OU3VhB-Y_D>11qa!`Ku\0Lo29O%5s/,&q]AZQFVp+m?Va$sbTH
C>1Q8>oP-P1L("\LmWC@>fX;tB#q9tZsr9bOjF>0@DVZU"+4;(tlWZCLakR/P/PkhcZNl'5j
PKSK'gq*UXl\s%/cF(\+k[?T*_-)ks/5_JJ#/ru<-d[NhC=KSaJ<"nD5'`g5U7_)DOsC?so6
Un%F9hP9M)AuA&GNZ,hpAUDN?/o?60AA?Ii2X#+!)MgED:XOq]A0"`JN,)cR,j\Ke<'^5pCWs
oQPg9r(3Z!<"'gb)"C`Fm0Nffo+4@qDV.&`4N*iJ"8VZ(:Z5R)3p<Bb(e0Um3]Ap(93?W?dT/
/BBt>DWI90FSST2QG<&g8F:MN]A^#2rMPL9@tT`=Vqes/qQ\P'EdA8^q,"QZ6p6AO`"e_>Zk!
jAIn-aZ@D8MQ.?]AS/"sngUB:<]A89k!mpgUqLC`1Gk5V6_>@EI3@;e2m&\$5O..l/$3V0K`K:
"HlPGdgD/VLL<V+O70Mag'#5lT;/:P<:m"NT:En>2c([SRAE^TQaFq^o\$hTrq3YVJn1<U=u
Jq7-_L6iD0L)o%l`DIaG?t*>Id"b!lC8>ngJmt0MU'70n,W;Ga?EG",GnF8Nt#+o`'lr3:"A
kGd*mTC*D^4<;(Hb6%dd%(ob,+.c&Z$7'FMBdYc[e\:YNLr]AuhH+YBAZ$""\e&ZWKd!IOY>,
2)qbJS@`[]AEH3"eE)#%Z\]A2#P+7`>J5r!Jlj^er8;9b[3`U[3("79D0kedM53@&GF&gFlWDj
INO_ZYd#Rj"s.hj.L9d0:EM?W_]A9n)N.SB@g#m:K?LPLia'iZM]A[BH@BZ5k7";J&`"4Ijo_!
qbR\N5X*od8&/j]A2:Y"&,'.[n[LbbFc:/?/7m/UjMYR+I0>5uo^@+#&P2BX=h0\aGS4N@m<R
\SY%<RE8g9s3X"sre-!s*Gug#SL09Hj5A+f>_fjqWj`@H(mC5?Y$*e#qOLF-GGoj_Z,f]Ar*4
RO$Rtpo]AMMh6(fB]A:A#N+nCgK2l>QFKiI2Sq.d,4Xp?W7Y*c"VZ<[k2Zb%1AGQ)W2YCES`U,
XmN6Z&3//B</]A@8MA&k]AJ7=&Tm5XTPOGjq@t'H2W:ZK$q5WM[5.bWSa!fpZ#5F_X9aFdjf<M
uf2(WJi'0,l@M=GTfC;&e1\'b]A0muHji+T^tm!-u7$eOfTgehEKYj94/_F=Fu(@MQDHUrO3R
'u!JYHG&r@C^<r]A;(TH:lcJm9l"U]A=d!JHt"9pg5oP=fT_.GfkK.s.R6U#/GVOZ54g1NSF>H
P^&#OH$,f]A`^&gQZNXrN(`F`tt,'2^SWbJbXZj;kJ!=IrBN/PF]AZ,edn]ANIW0D-Lt<r;W71%
=<B*TX(ZlatmSIsOOePPmWP%m"ReM)4'A)T7;K_f6$@"L"d*(ksC#@f?lu-os3jX<i8,":*L
G1`edHiXUn`V;%VO6[$<_lM"E^?>!V,F@3\D!,]AW]API<o2'4)D6>B'F$;Qj=j8_[S/FO.?hK
s&<ug[mi-%_5H_Oj3d)Gd_nOAiS_%-8\QWmPI]AsSP?5-iJ8F3<ZmW`J>=ld)T'@>ZA9lMHI?
h:*8qH)ULH5tWNEP/(kLIA[4k]A.$9Nmh(1i:$)0N3Nji0YPXu$q?_J!nGJA0'UJ#]A<$BQ(;g
Lo5MB6W'18rMWW:qgqb;`qhof6>4S<R0QO71PYPHp#YD='/R5%Q%bO\JR9BSs3O:FI8?R*6"
CgNqBg/FWIB7$9/%KhgK/f)Ij&+Ecao!U+[NfEbF/9tDE)5VDpLo?r.'Q_8Y;A@1]A3$=Qkn@
'duX4,I1aSi:YmrN%f9EMi4hF^=+nMs(U=o`75BAVL_PH']A@-p./W:1$[J1)X]A%,0dt2nag"
YQ]A>bd?6)@uX<(&s6[$7MYAWKG[94k]AHirX',OLJpWphB\^OUlP>I>i$_#gY2#1Hp5JIS`i9
4Erg:M.b$h*dBYGC:O-q9#^T/@UHGb/3"u*ULXV0>0%,6DkP2ZFaf#!c*15P3db]AY?KD[),r
T]Aj&Q3TGfbfocNRpil2J+Ms-^KK3DSCh\XKI!pe^^M]Acj+'F`ldUgC1(5%a:rmNR:n/@S[=6
bVa'LQC(k<cI*"J\)UUSX2mUPf@)*ONCGa;jFZh$!%F[e(5\meI`L@.T\@@kQ)>ce*6I2]AjV
s!Xl=H=Y7HQ&^"MlRq<Nm9RW*EKaQ'$RpQfaqQnX4jG_l>\o.59m\c&CCA0\f/,Fk/^ElQX8
HJ.iWDO*.%\A9[*&V%PG3-g8^&&j3QHNlOPjD&iG*:BRH1.Gd:<FSjK>c7*\=X*eKZ<Mhk:n
Og?c">`:G@X`s&DO's!b]A=2.7@#Q$?LK2C-3l%p`dI#qmi6c)eQEXM%Gr285S]AnthpUhk_9"
NibRi3bi)VkWm1B+FUE"VGf&p5;!f;PeWOIK.I2sG-D[fjN[o(cqb5P$TGXE8s!M5s<$hrr(
P3B5$BYA2ccNn:,LMALh`?@h3/8GUiR._9W,mhA\.P"H>rB8#hLPUHZICi[hsfi8=bF)-"Bl
Cn'++HF?M>a7d\3pJlB#)TMbT(kd3,WpFaXJc6SZaZsg(gls[cckog%Us0[4@T5R%P,`"*"q
EkY<%nC\HqeL018$?Y/@/*pp9EN7##a&nqLQ"Tb>RSb2X?H93TDcaha6YhGpHD[lK&U*f_[E
P<i7,W(G5f6Tu(3F<M0PMAsCm%ZETd^Z\iVL_9,@%ZAj=GE3VA(pn_uCMrS&#5uU`:YWZ4p>
!po(HXC8L0LK5eYTS8e<'nZ65jhXKObud=0EbT[(u5c1gHnHfnOoTfVYK*(<hdG_=#jl>fS!
&I=a?pNS*,[OACp5rn=YGR/U28^UH,o(&L7P5)$3+,mf]At-Cq[iQ3O^sqRgD*;mU)M.24"`a
*crj]A?Srs_(H;lIA?3Z;3,\q83;W`(R:X-L;bL]AAR@@@P%Z^NkF!@CYUY`qVT"RP:NONp?[m
`g#EsR*O5[sghJn0)S_*Zg$gMY%B?]A"53%U#ZTH)7dcfeuta+Yk.%C48oqMU7fYIuq6c(cr0
Dq<EfPG/Q".k;Tq)?[l-7rT?FD,K\J4QDB%1PGFdWr"lm9h8HI2C<MNa;\3nC(-2>(8N#\_.
IAZ?""PZcRnS>eJ]Ae*r\j*mNN?#@6mf\*4<!Bk1_0[IpF1DEc1#QHn$9k%7I3*GjI)D,?RGB
>d+"6.d<'r[_=@/[.Xj,pM99QeSQ.O#+rd!=f9a4uK/cUf_%+MTc'sNuQhsAiIG-7JoQ]AjP4
fSs@=SmUmNA6jtcMNg<!gni+`]AF_'Bqk>4$'sM*9o4lda[b+_29@<S_Yr/e_?a3O#RsRE4tf
Uq7qPIjc8aOQ+jLfs9Ai[/#OlnPIde35B$mp.mJ;G).Omu^c1SaS#VaqKr/Q2AgoZ']A2l&K$
23S<g]AW",o+f(=WYn*E09$tb+QW4kkK(o8)kS%DN8.1sejMG%]A^;C3B6SX!2UTXa[0F1nrNV
8T#4,4h%L/Y*STiA[*\qHs6SJ2<\8_J=R\:43ShZ%^*!<0"0$Dtn]AB$FN@[djrT,$&aqKM7D
7:T-H3VTEB[m)c?!/u4BjPd,N)XJ45]A'%?ASl74,(if2DK8PF>0M>G8A%7Ec1q#+C2o13m*h
.XHM;KZ5OhmtD/+CX$I-+LY2oM"Z`.*9M>'8h0%8Bdi`&p=%ER7Ha3,hbgrT#85oN-'c>EOQ
k4*BjC22[Gg8'5%hXdH<bN]Ac$rdqO*_AqMdK:)T(jI^Y$p^GtcL*`%qP4CA`dgpaU$>W'>DK
c);7^+34HkES=IH!A2]A;nH-N"!tn259(DJUWg%Fh$ZAH+ktH:4m="b9]AX`t3U@-u,S[*8Pot
H&[l;qUL09oj3gfi.g0:>2\a7G9o+A2:AKQsDU%gR-]A><Ql<=CsCQ8=CPiK/oVJSU+`okqE2
6-hO<l>ti`jT/R??]A6mrkZ[kI(NT&LH8n/b=Qo#Za@d=*"J!)tj4WD#9UObR:'4#Q=P3A>G]A
6<Q7CrQ39O)g_abagDObdH!I#WdeYKEW?=K-obWCP<KIdFu+1`>LCg^OWk+%0jlgaJ//oc&n
\p\+,nhg_$Eg7"&blEkJ%L/1(d.TVC%Z6W8V<8rZ\/&qgI/lH.^O'6Ej*#l*nH?<\V4C8N&C
mfWbFnKZ=.Dt3FO>LJFiT\1,V9+sf]A,UkQd163q[pPd,!p6VPa=a:"t_k-4HV[7BO:_d]A"aa
?_IOVPaWnfG-Vd'eX`g(;L(0FC*Y'MFp+Z&2E6@f0K[V1gqU)G*'Mk_5.)Zb';O(nr;)mOZ_
8\ES`I.D34>21>=srQq.;P&RGbq">m)-^kW53UY`G#JaJf`1*]A=0OA.RM1lX>A>]A76':C/2U
/(P[X;s-K>R6h!2#+?>%Yi3c@L1!#Rn#d-,;5KAG,j9Cqk*;PP/<rWb(!>hgXbE\`2pJH,(=
r<Dlb?s`"s:,pJ4ipYCKhs(5.p-X&oj;OU$Zoa7QP:9>+FR."PKM.R:]AoM2m&O!lZ:K!jY\Y
$9Rmu.D_/emV%-`L?EL(n#GR,!Am=M_)>EL,\f!e_"6&1k9).XFA?J[8[OFrH#"dMU=.QC5Z
0EeZ"kiRpdlj<O^u'+i/Z$#d"2V(Wa[Uks1ofN@6$OFJert`BLO=q!p#P;@hr0XlJ$:a5<"n
hq("a[NhCneHrE!S4;ZNE7DD#@/%tZRT#"X"m3;f8hs\<Hgf%bI_t>->Mr?.To*#M3TS-CSE
21A&(8EdgZ!]AJR&+hHb[Y^=&OILB>q?R,Ti9NJc'_0B?F1A)3D<bZ4LP<iOdB=87FS:n2eAr
0e!``CC&S=NiYD.c41do7+n!<?IWcU+=Fed93BKSWH2/ueS")q3#3&='466M"m)sk]A&%u+ZT
FX`)Q53=r;X\_Pa2pOhhQn2u0*T&g:XpB&b'=iJ*eg,>#`nkL_Tl*\/'toCo_8t5he+u;=)^
rF38$8a%T.V=+OOj0.7B$]ALLYH0@PPS=.lGUR($5bm+FYDp1Z'Ps-8pX:mB]AXm$dqduO!`!`
h.[ie\:Q(ut1[Mif4>"!T=a2>WCT'J`?0!U6QkR$bqp%(H^"s6^h6+eQSYG>pin[rH7>;TL9
%:F?7iiWD19Sq=R/eN*)+aEUL+1*`O1+tl="DkJH)%mS@R^<,4oY6^&!+q3`*<Gjns3(DHrE
(+Z^W90mMDPiBi!B(L9KsG.m^Sc2=mVJ'am$Sg=r&:%'cr"\,JWAMaB9)4OG_&N1JS1"7q&t
!H&!UfEo=8,hdO\fmX':,9g,-+#p,h2(6mQ,Q8"A,K:GN;fFAt@8^LNSn1Z('N]AUgJed]Aq=(
Kf]AhB,T^)so*:@L4O&gCF]AnER(u6Q"rE62UQ?)H$$]AsdHS8Zl/7b_SjR2hntKPqhhnX7-U_r
J(?)XAgg6?g(0+TrXA2Uo0A!QC'qIY'j)o1ro=NJ@hKVZ.e80k*0iA?n!r$S+lCQ/!!V0.*q
.1AY*1ItT12@$%WI^5(W+S78'4T94AqJ-f=$pl+OL:]ACAM&>\g#R>(SP(mK?_?:_E"7d5Kd.
D1QYJDQUChPFpVM:,N#>b^R):/J0]A5^N'tc6iXDRNPW&#,@A8DNPcu)>p`"<0i)bU%'rqp=`
't<7VjV?aokPV)a^!%7Eo]A)H"?>%*a`cT<6SqJ54BOZgPAX)LQm[-;X:aY@*q8.(Qg='5?&+
dSF2jcnZHk?KjE8aLR[-Cp>#bs,=\?s7BQ@lf-Q]AcrL+1?pE/^ci%\)TelC@jlI"(=1!oLbY
R<-Q]AgmKP4apT228`FBi-l.Y]Ag*m($c2%0TGRHaGS04Ic^*H/T0,X?6"qECAe!EY<#2"bm)W
_S,L00"#"/AWrM,("t_QBnWpC4[i_`rgVENf:&9)apo(RU)$`)m):X25dVAk9Oih&Kp%W2QQ
j#pYIAo#B8.5r%t=K5>5K]A$4]AGB?re.hH&P]A%$I3*V8$pj5[(%IN17hJTK?3qUhP;=srDM&V
`:QQOSa!WJT?Sl+Nd`+A1t5-pRT.Ye]AbV-uqpGh,^K$<p(V?#9I'WlbNNUPa<Qp>df'Z[(]AQ
JG=$Ff\#gBIl)a,mu;VU7:I-&d8X^"#q#UbOe;o*ICYq1X!>`']A>24=4&"R$PU$&fITBpihP
"%BO#lgQNHb;A0_'$0IcbGT$hl.AfAQH`,D!U0aM'q4cV2Vh_L>M92mRQ\uBk48\/IG(M)M:
?k<KEdP]A2c-?n<:,#cnA.'2E6o<X-o5;eF5^1b=<^41uNq*IoC,"lK%X=6s8$[[X'qRh(Zmk
A%Uo1C,h,jl2:<#e?NBYGV$O$rr`/N.soj20U2"5[En%?5YEO,I8YkOs19/\8k2eT=t&al53
pF;)EX\!\hZA\J%8,1;W(c3(Q^'o#@VmgRCg1*saX`e$iOas$Ef:U`dhh)=636t^Rb*0VE:-
<YaL3Sco'(RLK&aiI6dYUf0U3sGf!I[PTL`(D%68VuC.IPf!Z=Xhe\``cE'M6n*aV==a3*9-
HK/e4OQZiJ"DB/"#jEmHcWWDqVP4DgaqQdo:`H2E\/K9GH,Z+p?V*+FL]ARL0_Wf6K'JKTE+X
ZC:Jfshi,i6nl.R4S%S3poujK52qDL^TUD%S^+lko/OF,29uEp)A!L:6E16Z(-ih=;-*/(C&
uhL,I4Xj9(,L0QrVJ*gW)*&1tKm2iNp)UM-#j!nbfl2maR]A*Q,]A0ngF-nTlAHi1ukr-gk)"A
LpJbR4eIM"o\[,:"?S97]A&&X3d5]AYd:>?R[FS1'?dO+TsXjWVnnC/2*3t.n<Zl\<"TVu!bPf
LVgmX\rA7UK0OULcU(?(@nP^eA,Ep1Nf4K-Jnn=+9DW/J.Tu-4nmpW`XrV!41k]AQ1)W>[G!`
S$cgFKVn%Df7oZ5>^P$H;)6*?^Yf/sX06-cX6VWL]A`hq'+gWHEdGXGGNq(6n'ldQ1T*O_/Yn
)HboKVKil8b(aA9:.U2WNX.U1-O33=g>,37Cm]A0E<r9%+7t?A4&7iA'(lDb6eh57$bJ-^k6B
1B8j9'()SE3ga9SA\]AuSktg/5;0[jmEI%u>M.Wj%:07JeoS?(bAQj9u3%bAfE5%1Ytcn:8f8
31MR%C)1L:KP;*a;AT;oW.ouod2:;r`#gpN5o=m-*#.\r8SnG!*&;8$*p=,2e9AGgZgI@$"0
7P6$(sp7bF-EJ$=-k(e]Adooi;rl%TXM6rF'n9tEV]A0&g"P2]A3Ona*8><isCT3]AU'4If]A127R
AC1RM&D?`ibn*NSh.Ae2ndKReH"?L'm>_r+kC34^t+gcD(7a-Z,.E^/@2mU0iD=?(noI7]Ag/
0_DC^ecJ7"8@:0/6UZ<dl8Q8\g0ps1=Tnq>0La0Sb=X0B)LR(Yn>tPXkM,ua<'XOF75c@SK5
8FZn6aOD6<Whd<T<#J6p^6K=Q1&m1[l;d?FNX9pX[ZK-0h=6UH&_gQu2U5c";RQ/4Xm8^6Q_
?3t<1?aYXsbl"CNm-l0b)^dLiW1H`0eutRg(N3AP#g:T"s-k[trqiml%@!f<=W$PUqoe"8-B
`]Aej:gELX):Veo93:fk6L#HR"5-CG>3Gmh5,f6PY)mhL_cN=TcH.*o$CDJ$`do!#6#oS]AYPB
HNg36`Qbf%3=kG$^fTcC+?h(S9'n:^e2tt(li0sX'2X=4G>$HJOe8t09Z9%sLTYe2QlI$PL\
-5I%/]A:Y6BUrNoUg\c'LNttY?0-q_5MtUM?b[FB/.Ap2Y9mCE*fZ*!G2s?e;0M5'f;#X[kop
98<Of15NOHl!;8<+Wq0T(GVKIc+jAbp=f(^O$A^^mI2eFjZft!Q$hkn'UC+X*K=jV(qSmW`M
?h1BRoAA<X6<r#DEH\RB"K^fir(C>+[H:kW<_59\Mr%LIGj6@N1c9S<D9:IOJSu]AYJDJ.@D.
V60F84@a9<j%1Mr-1K%^e#?crMJLdZXMtH_Lk8lQX5"/ebBn+#Hp$GdF@JGoJnV]AL5K!KrE/
-$^2YarpLMkfUuIcBO?CG7+.1\)]A;hGqgUM"*":4FHWan`op1g#heqOTduRoh\U2GM>n%RD7
3*N>Tb,$\os7V0Gamb-Lu:89'r%D+B=tie6+NiMPe8E0U;JRD2FTrjXY#%f>(_Hm!rB5m#n>
MRaZR3gA*PA;UCD\h!pB_`+`k=8rc@U,<7Y"SN'b+7:X_`IQJGd=6]AU)&g^>GoG\G')N2OJ.
;="4fbmRl.-iL*F%[5oe_GM]A4O_,!p0.-nD'-f%5d2jeA`f>FfmE`6:hd6T_rpR'h"*J=Fjk
Tl>6U%sF(V=^'c,5X:>b%.#;Zjl.?,2>0MiU>_-CmB-@:!FI'(V"sD!tg:1Kc.NY5bQIQSSl
SIG7UdS]AJqKR5aS\=9tYTa[K`0gqT,q]AWE+P=]AH[kT0`h7F53k$'$7s$ml7?n]A:lHQCBE!h=
%7\<fZFQ!@Rc2@Bff*=5;8^(IWT[TZ+#EqgDP+GgDf^`Iqt(Kf)0GqY,Hj'B7C^V(O!kpD5g
fNW>7W3fo]A3BJ$CN5dTlK\8r^sq*qjg77d!o-.5l(e`?su,ImU_5';X25Ht6pQJ6,^YKoTp*
Y]AM!TmhFDB;(R[q$-)&54"-<"V:Of/FCG"6(Uf$(qbI/3W%)RbAD+_/[u/rlF7N[]A8St*2'U
K2tftj_o`c-.UP7%J!4B\_&;[lf3WA2813loPN;_/);6td31=L,_JCmgtIM)Fp89k_^53JeA
oTA/(2oNMT/jlCfIn?Od;a-W$uJ.@.<O:kL4?(f9J@dSZ>=Bdl_qQ+TK?qQ81=@M8R8l5CK_
BuD$>(]AsabS$/"<S15"<EPHFqSPXt;RrhS^"K!9-<_imo><-BN/ac2eIL+>m)c`Xl7K<ILoa
?F+Y,`"R:71?jgct`&;PT^>HDiX_5a^NV:GDuFnRu5Zd6L]Aad)M'QK24BV[OF]A$6_130$a?$
YJ4!A$`C2U=t*n3OWjSW^LTe-/HU8D"Qfu[&Mf)0X/rfre7"G0J$_FN/k'["ZV^boF40L!2`
i#Tk=GIhY(!C:>UmE"YehRrMDC_8FM?^S/0lbed*6%-Xfla>;oq(.aia'%Y)Lrp*bF^jgMTd
$;8<!P0@s,@L)+fY%8:otpXS'c$<rQYkp+[F]AaZu5Z!hcjr;3MYZG)UD_%8"J$Q.D"Ykh`*"
7kH1/g??=G`l@jl'jDEr^cPO%BZstKu?1rH<)lYnf=BOX!dUG("u3Uh7QAgCjq\0h%??D,QO
LBnO#G;T/Wk@COe?FGMVk]Aek7d_Cs6VR96%7]ABO0t$rRO;*p9["r?:5"BjCZ5%OZZ9XQI-\G
;M.8MH'f8eVA&VYRr!QIQM%/^0'oc&MOF0+KJ9@daKElVk'#UOfjQ;I!-o<h_/"LNVR>2]A2R
#JRUI#N$]AOA0s3!E`;ED%'d/]A?<*_1_/,\o0,:B#=r\$Z<=8Zu449Z#PCY>L5MA!;R=laU=8
(5K:0o%g$Uig:T3QPMRm<983U/HcR^O\[8"lDIt\m#;3!.\Yedf$_1ZX4XHt(c";nDH,Pk[J
o/RS,KFgA)`>_aZ^"AeKK!e1<2bH@cG;&Y^J#)7ORnc"qmdX#8n5Ue\oGU*(V;*V$ibd)BH+
f>f7N#@Ts*T&/U0\krRelV\c.#:CWF0+Z?cgD)W$j?p`'Qh7^hgQcrX?"HG,"#CtWC%<:!(/
h.TtSnC?=>8dec?!_)m#oa.a!=F(6T>==);Il3SD1pbI$+tfW;CH&?1]A?`V"<%q^8HOMI1mT
6:<,@NCK`c?KtO#Y*f*r4KXg2c6/10_&K$g=g82ZDIG5:G#PFJg\@L5)]AP7qc8Trt`EIpGJg
-6'H)q),)W:=D'XZ]ADI>'rP(%U'a#=UP*K";^Hp.2"C"X;bOnNLh!nr>QBLkEH.mIVoOE^n9
\Mlc&4qkp.P$,hQB4[M'@BEPB\=Ns#.K1B3d6be0#I`i<&^WgK0)a&"ZjTcfHk[L(4opj.Dc
%'b>>JQ).G?!BABWk;p>8-9F7/938Lg!W#k&gX<^;=-0X'g(H;\;]Ak*FH\O_2O->]A<6P9%b+
]AOh-;fHd]A1>_uAOYZC)uRF^qV2GSK^&X0g'<asiKPZsr;S"#sU6KYO)<2E''bS+pRdp)V>0>
aVC+S;($8Pk`+b):pLM=4E.e=NluV"#u6j#&DsemXdp?je<5*F1H330Xsm"MrHGM;t\U#`bi
h6MmA<3[1dr7^ae4]AFg$K>=*dQ-)=O5]A`1dCW'<l_;u6QE'7N6l3tFB=hQei.j]A6sq*_s$U5
*UU>_io!)`547Wlkmp^@3-c</>F6t:J)(Jbt-%SeD'QaT3"39,`[`S:Z8ABpKeDfk*N.AD^<
\G<-s.ufV'Kl#"DNg1>q.iL>^1UGkV0`$5/"7[>=(f"t^QSb(*j4j]Aq@WV#A8g[&$\Fm6or6
T#',p762HM4(^=+>6-A6ZM?e45f57<X/to//be"c)FFB`b@,og7LV]AUqCFCBjAjH74ua\]A/W
+k4UAib@'OPVCQ/]AP9=57r'5^^0rW?nP/?o+k'MQB0dJg,TNF&T0G%J+Pk%Vq+_foj;aX,to
4$L"q?Au1cFO#*Z^Jk^b5@>3Z9.CX,W5s4sD\UCO6rX\*kT2,NCXiWF78#XSX=_b1<s&]AcWI
nm91`4f&61lKF"9Io(ARH/4QZZgsG#HkF]Ane%-Ya89Vr8e8EHA`??LJ]AQm=OnaD?g+pF)&Ih
d:r.[0Bq!]A61E-UZ;,gJ%L)s&RK_]A#0eUtZTAC)'eB)nk3$Mm_^r"*bjV)<h##Ms#P($/]A8^
7\2Zk^`"o6n[GD7Dbi7IkYu'P`/de8ntVZica9O%S=0m;U+@R,Y[kKLNo4c&hr<0?djY;_J5
<;&o1tUjXr7@LjYG%5<-ZNPr(91i+OS%o:!WcX[8rR9THAeh'!]A$[/m0_F^JMp-"f0UMVMcS
cFLFLRVIZV703#mL4Gq^99W/reV:L;s#W->DX4fnZA%[Z'Fj;,(P0f`$0o<,2ZW=D)jgYX7o
-4$7>o9j2Q`35QBj;&W,oFi]A"^.Ul]ACbQL75I^$@[Sd'e'fnhc7`/+T"63%S&FV'L7;t[8MX
0-F>el2=324]A\O=LZ#LUmrbB*b4I6JXmldJt_PDh-@12F?jA2FN>0_V@"as@h0*nG*!^@:2-
117s,C673Bl,D4GkAiqFb*mGM$Y>]ADYFSIa>"XrmO;_a;clN#i@@%R=nXr\;)oU9eT![j%H_
lr*Nh8:7Q;j>iafRE<#0SCQ,E(Esg4TMH#HL_\!-4p\Ls$1KpWU;>b%-\rne\=YMUTf]A6/gL
?eQg1T=l@WgJ=nR<s7l8rrso~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="10" y="160" width="232" height="127"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ComboBox">
<WidgetName name="bm"/>
<WidgetID widgetID="17865f70-d8e3-40dd-ad38-6fe4134bf87d"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="comboBox1" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Dictionary class="com.fr.data.impl.TableDataDictionary">
<FormulaDictAttr kiName="部门" viName="部门"/>
<TableDataDictAttr>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[部门]]></Name>
</TableData>
</TableDataDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[全司]]></O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="719" y="31" width="80" height="22"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report0"/>
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
<WidgetName name="report0"/>
<WidgetID widgetID="be56ac11-b658-428e-8742-d9ad3dcfc26b"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<![CDATA[1463040,944880,723900,1005840,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[274320,6134100,2590800,4076700,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="3" s="1">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=right($rq, 2) + "月" + $bm + "工时投入"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" rs="3" s="2">
<O t="DSColumn">
<Attributes dsName="指标" columnName="人均投入工时"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="3">
<O>
<![CDATA[同      比:]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="4">
<O t="DSColumn">
<Attributes dsName="指标" columnName="人均投入工时同比"/>
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
<![CDATA[len(D2) = 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[/]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="2" s="3">
<O>
<![CDATA[环      比:]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="指标" columnName="人均投入工时环比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="0" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="3" s="3">
<O>
<![CDATA[年度累计:]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="5">
<O t="DSColumn">
<Attributes dsName="指标" columnName="累计人均投入工时"/>
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
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="1" size="128" foreground="-1197808"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<f4BP?6JH[D1bb=CnLt\?JZ78<#0#<!Z^^.]A%_`,I,<..j?GKOoQYY,]A0Y]ANKPao7$^dd&k
%PW!<Phm,T;ssqjJoE+p<]A5P*#WlEPB`M7EGDA1Z(l=lG_kMMtc9`c["sA\aS^OQh-hp\Zbe
gqEHT9ZtRG8:\Pi2ZtKbjd@rSos48?ChgBY4_deT?AZjq&k9G5!f(]A6Pcnm<FHaS#c_I5OE%
u?:\hg5ZAopO(hpVIn?Vk/?NqUXB%s4Ztfbask+AUJtPNpSZh[cu!K1Ui+]AqY*qfi,$$b=Q5
UXZ1.7>$?VEF\!GBd;#CHoI@B%p>-8BHEpI2]A*Oj0&G[-=ZQ=$OZeCfg0*5%$(9H[YYqC-K6
=0t*IeKuUtmT=\Q(LcL4fDYB[AOf@J?sKmgl30s%h"$3$b^#P1Fp)6_N+DJQ,eS,0Z]Aj3idi
H't/T:U_iSpcg6#]A>t2hiHrXSd%l#?bo3T@tp_4SlC%k<?Oa:e(*8CcUkKT%k);O`qP*Y^1E
5&(c9X*UmKIC`I9@@ECsc_rtmTFml!9U,LRS3gB2nm_/u(jCX;ZfTc6ob@O\L+))VKIhT1;]A
_!#rNAl:?h?,=jSI]Aa!EDG$)%l?T;cHe%*]A`2!4[fhid1Z&!!N"WgF*"3Js2mR1/%oq5f,A_
tWl(Rl;h*%:u\[LE[BNYL#a!]An4n=jq)?C"dPEq+[TUg%!PHce-,a?t&D5B&S^,C"[QOjVd]A
FRX65Qg+%Q5Lq<t^%Rq]A$BmK64ed1>C!;&K`>*g$5.!c2I@`m>9s+CY`m:hE\$RsD!U0.:m,
'H]A'pZ+qnm[O!h).,qFQbM7s1\C5Np3r+FE2/>jU?LRo--J^Da=$gWm.YG2!4mq&9Y<BjFLM
VOkZHg]AD28DOP`e\4-.e),BMc.$?S8p+_LTGMu:m;H&dmM9ol/pUT(5C0d.4$.=1/Z2dp7:Z
eXd^C3]Af*;tCdIVE?Y=)fQ?N5JJ8H.'N'tXe#rgLM0]AF/n"J#a%hn#>]AK-,8WSFT"PYmHET!
r$N_J/G'eQ<TOtSq112@eK@'!lm\(*)&U^-UQ`u9h(M;=0@Q3,$SWrhpZm-nE8UFenIY7oUJ
(6pc]AAU<umYTna9^k*h?la:hBV(qFF*)I+.oM<q.^H''H#4.?C;OVEa*K#T2k&0'j_-6L1jm
7,80p2/f72V[^?p/e@JLs<hUA@WC=?1`G`R\@'ausVXUA'N"OC21FImhj`D2,ZnMAul`$d6&
g$F-O7Y?7(D>J277cDIO$H^t=Js%YDY]AVT(;5^Id<54Sdd*MN4=G@@6LqsW<,eR5O"8c_!6c
3-k$h1ehtaf4gjHP#[=T(48S_KtR9HpBi_g5;T4G65*N=;T5a?Dkk(kWe.C-+f3OI=`,R520
!Ljh<;#8!7js2"[a_*AYn81IW$8[]A1L^e*MQLR6&%Vqj>,ZE*eK_'$LP@nI5;Q5;R".=c44q
_[cRUJhKBfp6UCJh1"u@494DG"NP]A&4[cD8ruaEm)3['`"MKD;2W7((jC^<]A/-JfN-X>&7&3
:/JSJ40[CJhR%?EhP91(Vmt=s+W="bmqcBdp?p/L63=*Eo>W=7:&O\iNeG\M%IlJAlAYYa(o
ei^n987T;ja:,b!pGVOP#1Ac(ZYYM4Xk_g*`5";=VR=mDaLoH6MNgPsS'Qf[*?./'d,)A2&5
8O>rGp`L<Hce1Pg730+`ls+/N5d@\HBA!FoMP<&[bc_VO'm/D/S1)Wk4a.q::3L`7&mgu4V/
IHU:)Rk"!coD5sTKtO.*AhmSe;ubre=t#]A4q3GId^sMm9t+I2D-7pp'?%<^X8ZGFqb^d5-Jn
JSPDqVk5qfg=d6m8._3ci"oUEa)9@W0H^RSU*"JV[$MhLH/(rRAs*LXKtOpqdrdF:GVnW_$R
)bQ?7@CcTho6paJa<`)%X]A8nCoS$dP,8U;[5lpp6&$]A=mCn!/j?(5&/g]A0^k?d=Mt]AZi'8Jl
-\]AJRd\ee[iQ.:OH=t4D2WmPnnB$UnKf#7FsE;+boG(GMucF."i%o^JO[g_>!VbTcUCC"Jp4
]A@fK0nFZf:R_>5f;]AN95r)_/9B8hk)R%hN%\[;KU-m4=h*Q*#oL8HO;:]A+]A]A!fM)I]AjM^g>6
E7I;R#3<?%\ad=\7H(#@kaDF$]AQ<i-a6`HA5c`UnS8W*,6!VO1(p$qNW:5@73HBbpD*5"MMf
n+%/m'=lMB52A[^DWat74]AFLbUpjkiG<<"hOSKc^5"'Y"$\$6PX_;=T\-WNp]A,4-5,_7GhGu
F[m':e3Kq,=@toL$)a5t<C?_%@l[I#QWWG>.+o;&s2D__=j5fYli=kalA"#D9G0[\/hMJGEP
Ogl;bYEpa?fO16%=CD/YI7HQ:mTj=*8$B^8E,uiobm2=B#A./,$SfZg:iKR-a2D4sL7)MVLr
1c4XdVa0,-ZE%RL_W,p3Us1rl%_?Zs'3?7N?Sq@T7*cOE4p6?]AA2%k\TH1YJ]A4M:<n1H"hO(
&tgW/`\eq,_0@<4ZiF1nPD`37RSj#Xd.0"t=)RFk5Y_I<;E%'k;:akpB$8#qX,54XtmCsD4I
Jh'<-),h9Z4!Nc4r/qSYY.f"@BU`\=MRSM(jCc*&lV6EC8G3Nj:Kr*=36T28Qo#K#:=2U6+M
>5C'cnq^_SRu[dKaDG6?[]Ak,8%2O1UljCO%*r0kQ[SiPaN4b0=GCU<q)bf@3:2;_oW,Z5H3h
VaHW^a%ti#o*gN4"PMs_U$NuuiXGQ#jgQJ*TD-<0-U8:=<p1i)@@i="./um^XUs[\=Y8TPM#
jrF4o9RYm9&I\L>3WN34t_kC/p93r<H^_#!&Kq!4?hJuI@>/M0s_%uI!mF&S+g$!mF*!h'*@
G>'-o+rEer.iU)0#W5\W2j1jmB?&#7<"SbarH+:>30g0C$uD#u3/7H.VgJWp#jOmRh*E(HA>
XXIf@#=i/b]A!YDO_#sH0"ML0=4',U:l)p`]Aq8Yge1bt46$-fO#.=;F58astam/t&ne9;c4MN
jR9=?QK!,pZ8:.^FliI!e<phX]AZ%f6n.2XPd[bned>K7a6>'Q:+i0oFTik]A9M!BeD8YJT;ob
61hDj0Q:o+o"H6'>*iBKd`i.EZ9\T7B4ek9$o+-H9(r+5R^!SNm[..u>]Ah?[D8m;5=%&0A.9
MY-n=[Xm/<&`,e]Ahm$IlA$`!:7+[=aPJ+L<7SD)L-@b<"es9FoY04lG^)VH5.KA/*5;mS!`b
B,(+WE%V13Z\1BL5Hcop?fQ^kAXETC)Ul\i83Ykm^o%_TO;Q#a<$<CLc6lf76AM-Tj*7?Hsi
-7pqK<Pch@8TSc7>]A;Iu\@%ckkWI&'J7F?t[hVYSI<s*U*+m_C)/BnfU2MrL%8bW*ieMGt,R
HP[K),$h7nBo?Kf^#s06^El^#G-_p#?rQY>q3:s/K$#:U&4q_gj<ph\1cb4"\0#I:b"WQ?6T
-:bDO&aCY&+dW%Or98GB-HU=BG&rLs1hWOB?&&[`<5G'bV_#-q6N2#W^i/SJ]A(et.1H6a<+j
I$)c:ldK6]A&pDM*6\q%Tf>5p*C$ql[R'u@2XI`u(Ppk*jc#=dmhG,S8Hn##"q95I?U"(\eVO
L"hR%a^!.0daPRH-lohV'2]AAlIf+X[:WjSHA'F3JN@r8D7=>;SB!6id_mc79-ZLLo\aE$WkG
q_Z14.%"pODJ@/uHgq:-q+JbESQFrI-I/Iqpjf\h+$G7,gGj:q=RH16S`2ab0d^Q(.[5DUAq
@k1dl1VKh\'.M>iK<aET@D@s5[gQXFrLeI5<RfOuDb.c:Y#D/&h!&.!o^ZN>NA,9a7&G-?;I
,+g%=,D7X$=WH\^f?]A@(j/\6kNaDr)_oEcO"q`+8poKu,+=5)FrLI?(7JCV57,$3@eMSYiZb
fL1O0c+fOnr'u/0*K0a3Is-6>;&La10"4#!<]AcNj$,E-BpRoOW&mL>nHk=U*bb[=]A7V2I,CT
6>rA[^Hj]A.o8lfaH-K/"%Va&f_SZk8I@='K!+KX!j/M3@A(mLtIMPM%]A10Ga-2PG?:?P7E2c
_E4qlG*n]AQdbk5j!o]AW,fCo+*6`ZJ7#`--X@4rM-rU[SZPpY,m3;'EI-X,ONf?-92d3L?@Y[
_2?^FfAB3ldt26'bu\Um5X)D?NY%LPW(JdYc&sgYRrN?BMJWQBFUOq?u]A=2qo=c&2*:G_C"m
!^IoHg/N%fRKYk;,mn0)Ohe=GRWHgu0.tNMIn`"JHg.$^1bDjW5psa$&Ug!<tq,N9M=['i&Y
;S2K'&dfi8cRIVK5RA-$>L^W!9_g8_P3kL?R&00\_h_^i&+X\-^aI58>j6cjO''0lC!+Mds>
MEGk4qE5ng+lR0no+3jVn8lO\kW=S<*n.*i%6O!27(O/QUq-FKWJT"-"1QfIl2Lq@j_mXAA"
H;2hCT(sY$a;ptLQJ]AFu+S<=Ts1Z.R11ZeY@`9/6Su'a]AMHWR``gO!KAZ<BgEplor7Y1%%U&
"-JkP/Q@7V)WUVncO*g6mkh%507:OddHfSQjfp;<@7mVf7P+RlX,$Ta4aYXq,V+J!VF-Lr)#
YpsiCDn6gi[,e$`#/)5GO&uU;lb@f%cs,?@FSDh0GUHbf(Ou]Ad.<C(S\0!m-i&8V2"IG\@>Q
!Ht[p(mQ,Hh#l9^o>:u`=XH^Dk=E"ZT;X-'gM%2k^seg^E7D(ReeWc<j^nS>5kGk6]A(K`J!s
`g6Y8W3H!@9k[bhh3hDZX*n5OH?d3IV=00@3a""2eQHsXse6;b;3qC1l:K7.q="r=O`3d3j1
JG*qqGs$"&_D2B$$1gEt4&P"ZTs5unq[,_5s-)VVbjI7A;pQE96k<\HR+IH4s83(eFYma>3]A
&bM%ZiE)KgQ?ldV%G.d9>X/&6WPi^26p&K?LJN<8/qOac&gCi^r@fCUWYWiCrDPin.WpF6pt
2b+(M6]AfiQh"#4MtqS[]Ae@O/E0[S21V$.&kq-t2,O]A:,i3;*0d/A>3Nk#t"7bVOp8E:KF0$h
*PBaB!i6)]AD$UEa5lS!FN4ifU/8u8FVLE;OFZGW[EQ7thFLa+%`.8*!HFtb]AWK4_hi48>)9l
-VUmDsk=k^q3OY$/ulmi-qkhWY%?>Q)eA`WcTAC-j?<Ac(te)1HUdursu@\)ZIX_X\:0FUCr
8H3-]A/rr'V0j1WJ>F0iMo2Unna>_2=leVQ49Nm'cohC.?G9Pi+"Qi8RKnoCo0#rj/am"K(3N
)P%bZjUX"gD$Ok]ARe=8.T_Vk[hIs987R0BjD1aVEMbpPu-;s5\h4mR,$65.kklEG3KCXq50@
3,]AX-!>kV#@-b0?X]AiIlI"N&A3,7Z!h;dSihYs\)DK5b.*?X;b?*"`V/d;3hkKWjFI3j&Z?)
g+\X*AXf!+'=/T"D<hPh0l@gUUKHMK4JA?\*#VL@L\IC,Upq^b,,.BGLJ.NX!?.Dpu(AQ*^"
74<]AJK&hED)eK@5`?7ru&aS]A>-gH@Dlqm6Q9s,'Mu(CbOapS;APqIl9q!bTZl'd"RmK_tX1W
^0ti;WlB%SIEjLY:3?bj"/3;ZRo=i/s5iE\d5XG0d2+)rA<uOr8dgkch3>H6>.1i[7+?[e#r
B4IZNBbfb6_'eTe>V612ic<L^dJONS5T:kuCS$!kgj[hl2rR9!Z/Nb.Y*,oPE]Au=84YWTRb?
<p!b,i)_bu1JQo&gg(g+^YlSe>p=2g@/>M%PLXfu/2tqX4`I[(N9S1VaoLMbP-@0pm"Sr)?Q
9SDNM-NaoK;MKl6#X%$R^Nf[?BZfe,VfW1l%E2eCTCPeiI=TFVupQcH[Vl.ETFX9<_;2,5aA
b5jm:Nr;G#2TVsbSNZ]A:5'5E_oL#@[`Y/#dXk\]AS&`%CTn"G`7Zk:*dN5eut36#dU=?SEE2%
'tV>d/r!QKZ$MUK[?d5(OTO&K-"oa0*=pkgN@jN)?QMc]A,;^-3qV6`1)s\RBVu/$980:t:!>
AqZ]A<#]ASoT35I%M61q+%J%Lm'GEaVR,d*Cg,;r5.<f-/WM=9_g8AsT^c64#kqh.bEZb=,gZ<
&dZ`@AJZ`:d1^tt/\&9F"L@Kcd83^.ZVh%9;1VW3ok-7^5ia$qKGL?0O_dCV1Q>,.Z]AfSafY
CQ?oF\Rq3VMDqP'FX4m]A7m0e(8,HfkNn/L"dC8V\*]A_f>OQ,TIC7Y%>$lV,fL7h![#5`SpN&
pq3=%C/o[[:WU!rk?=m$ue,5(45njQp3L?kU``MYuY[i+B$oegft)6C]AG.C`@`C_X:F"4d1M
Uus]AB(4-&peF.Ad/^XIHIK@A/@?4cLl:??1f*S5f=<&eMatos]Al6IqV:(Z+1ZaTX^[A#YO`o
J:CF&;7Qh"SJ2Xios\h5EVUk[`acG"kJtNk^a+CY\qnIUnjjCgTHub!^/T6">=n,RBE8aIGd
D]A/R$QX(B0KSQb0$G:%O(eGOGlh;PG=>&@ZI=7sV3a,9_]AH,m9g%R+P#Ia"0GXI2JBoEEC$r
SX5_bPS>i?jI[G;V!X<8)4f\=)@lD:3o7fQBd^M67UcDb%C*/*ifY1K!!1m:Z<"oP"5XP-K^
`T&)cHOWfM).R%k=3W-Zk`374^X@kX!222=XKbm@<&g#-sSO?R+VcQYr"=+oS!SMjlU24252
'dppRe=p5KZj>h.N`oK+BL!kC&-SK900D!M<k")!8nrM_?;2>o!MX/NHi-;"lo1WYV4Wfd0m
[=\i-?W5d$7hh,F9969l&"G5JA5Cncqj9H!V>W<R;q+/ZDcT$f$EL!o7`3gK)pL/9j\=+d!s
(:of`je25^X0UNq*M^0/g?mX%6A@Wlf?N,MaHC+Gh>YWofdM_t49LF-"klS<ek`]A8I,fHP1:
9:smSa`^N&_k:h+@\ZKn)R2H,EO.$nDrj\[5qQa%@@sn>&5u12;$\DVA&)9($]A#sTT5a9MX]A
m/QqpiPTiaOp%e;-ZPojOqXGUcX\?_TTVab:Z9Y4Utf]AT'AK\hEAE81)qWPg0d_+]A?#?+R7%
Dl?$f3EoQBn*]A!TE[O&BC6=/7'!BP7`)(.Co.b`>NhFtD`A95a>=qFUL#8GP@Sfpo7ION9F@
(HIrYFDaP<f^!VT,4GO`&g'UBm\'<+'K8;skAp:P)g7(_e,tP6+R:Q^hRPL"_1d"KER;=6E>
>o$SI!Fri)1i\+(Yl$\NHRuHAb6@@bfC#=[[:HKZX<Z5UH=PcGMYP2aI3CCb9SG+C'Y^<Kk<
9MRK\lf#Y\`d+_n$8]AIT#C<$P@9r$O^f:M@m`c=q$4T;Cr#b'.Y<io78bJ44o$g#*Q9fS<rM
ZOS8Ee^i8s29f]AuBr_`8&hd`r\nGPf6%=o;M#36B6\_AKlMi7[5tJ_70S=Oo?_[i*D%-X#ep
2)pGBUD1&qLjDUhmA]ADeacpW-M-^kH2/T76:%)h5A!&Mj^74ebd:raA`LH"XXZtSkk^XNdL'
^>^NM5NK/I%$2]A(bUF]A$XqF+`ZRNdcr5tE&apHn<Qn93$ATFl#O66M^kJ-=TaSYAY$B\AY%C
%26f^fhd]A:F)qrk3c41IMC^h+-c_P4>@GO6&LK\alGD.XW0WG=^q+W)DEm]ANW?#*>d-.s1+?
g]A"7(^1XRCZ@pOS.H[QfXGuF#AT\eQ<RO@gI01Vh2Q+6mX%!5=HVH6)Vl3OTEPT2T%oGGD>!
QJ"!\jeosmUNs/U7:Xoa\td8oe)gTVr%@9fjsh<"#D\o?Q&9buL"W+O(o=.R4&S7ZDf4oC?3
G#:DbJd]A(82dobN.J6LtRh'EV#Zs,4HW2a_iT*2NE]A:HaHGb\Hb\(:_\`kFl!>LHr;f^biq!
<l<KgWApZmntn$@Z0`=bamb@a._p7g'c.gmOglm`7GrGZKf3j6sbt7q.pu+=">qZ(CWfD>CA
;o:@[LYmVBKqdW61%F$0WWn5@:.g*4m&*@bjXZ3J+Ok6E?bJ3mE[cU4!UG^hp?rD>(ne([U$
?-l6n!Fqjnm]AcV&?9Q_p6+ndQ!%^V5J3.'*sdPS<9J.c9i7H7-0W)B!,(gQElq8ROjd-;[ML
Q!gk47a/'9]A+5<+0R)i"1pHY8BW3`bkiff?7&PChbYU2C1,j:C]Ai,YErRqm"0\Ka5@YoG>#,
g6,UmS'f0rBC4Oo0C)p#VdM[(rKi-$P;DM#Y(72t'5h;_>O@`R-cpUEZEhl.gQh$\@Mt@p?[
PDWm:3[tm%7ja<*%DPWbLKcQ+E?[q(<c@.*LnV6q^,p1Z(SH*0AMjEpR,ui;%e23,(4M'akP
\h3q`;?T*:pfl6!db$n27E_jM16C#5ATN/P#1W[5Q/\X.=`VE6U`97s?3PlO`Z5PfkQ4sHR9
,PqE^E<b0%79mn(2d`LjHN+eGTaba8!h#kfsH30#>o.c3s8r4LP'U5eJ+;Bh>Mq(?-,KP`L^
/O\!0.f=#LHE_QCkJDAj08*qW.#XSokMn_:<AYUOn(j2.Rul:A<ai"SR9Zp+gMD4RKs4\DWq
*SN\U]A8<l"Y]AScR:>\XR[2G2d^cI)0T+XCm/gm/>VFBt]AXML=<b9$cq3Ad%+UQ[hdHA$"4BZ
'F8j\J.?]AdNN:Fb%t2l(cko]A6sA8K,c6/7-f]AbiDY?i`JNV)?!@91IZ.H6:Ig\Ph<3Rg<>k*
LY`YK99r\aoe=-N?ePQC)VC!C@DYcoR"/5'h>"I9jSqS@)3A,lSFV@6)G0;?Zkf*GM*icE;`
UqGOMP1%>mX+Dclr7keW^"U$MiqqiNW5(jIs7fi"PXT7Vk]ABF/Ej)f0pTbEK-GqqGHA1N7$2
OAHV1mr*T(t0MXM`Q:O'@HG&U[)l0LIbmIV+GJXF823KQ)K9+)W$I=4hB0to7tNR10UlTo&7
CuB]ADK:2jXoC\$+jJ;EkcP!(m<-c)N,<j&78@q0E[E:pAl\jGj+Y0cog/iGpQKG4HTZ4TJbY
c]As9uU=\F0'oABl;s!a2]Ad:"_VVG@ADqSH#WteUIDE#6U\K+&aLLGO`2=N[SYm<eKYp;&BP,
LJJ<YsM,@Qf`MKO2P=oUm(ak7\B-@JRFB#ho\1$m3X:uP[(Sbm.]A*W2;9I<JT\A9c#c"u8+&
ic(Z)HAPf*kCbo@G00EYTD<>;!HX2G3fDh/+A;5@R'=.AkFkb#V3G*hu.@CO]AuXAZ3uS-d8p
(I.[rYom;'oZf$3"MmT_MIrcKc\W$E_=LCX29?[Mn8"Y#;l6$9F56S8Tc07*8J;Hk8k'!\O,
rOj%pGe[WFVE!bPJJuSXA`#2h+_;8G.VY&!HmM`*G'mk]Ab2kJUaB74sL_[E1RPM*e="ILA\n
%P+IL<3Ch\F[bC#RJU7E99:rjLk2lB@JW&c+qM:$jh!,KO9:_UGH4%WK=Jc;Bk3fI<<2^@)g
e8BG7+>9_s4?qP)"-hBBno8\iR9!jK%ZD+hJ*%C)^]AZ@+GA]A:i5N*Y%60qKu9Oo4."!r>RmJ
"uT(M-e!_8(E+7a&46i>\XMXGi#Ec.j/8=B8]AKYCFi]AQLrN*$AZ"jl&>Zhg.62g8,LM4f,Q]A
p`kkS:Q4uZ\"e(>[2jDIPgOYMJ5@KGo@^ico'J:O5_JFcK+<ot[(*=4GI#9h#B\n0".#eb7\
ZEF&+rBS/-+:(nmAHt6iUK7)sHVWY3Kq`>OBfHns@Ph)-X6sFnHm?3><=d1Q.)-0>OV#12."
n&I`NF_:bFWh_o"80H3nR'^`5tG?GLgMe<2rV0kh<Zbm;We_]A7nfVorJl;:F[ttT1Y&o5u+&
#3[-iA#fa<eiNp1+14U>J7s%:H4]AVJ;A[[^J<m,m7bJYcSlEj;u+5"h3;6?WDZ^'poAeMs?W
RCO_,X28hr,qpW=H<O(o:%I5RmaFo]A`X'7WsO:8&+'rOE`=2>]As3U<<YhX.7rj_sEZ.:E_Hl
RVS5bl506i,je1Ij.*CW%A(6;boiL&8C)R&cf-JPik!0tpu&nL(\e,O\o'j5qteoPMQ,q(Lh
G>#6m%d-Eu^@[2KrCA5Fb(J;Ne9O5783tNB4ZdbeqV%VN3<E6L?`C)nRE`Yh20H@ITk$ZkLP
,]AtHrkd/Kqs&9edO<%X\MlUMY*YR=AF8tL\bKq_Q/,'g.g4l1qEcccmCW1V'mHhk/phk&B/$
c\6l^nT-AZTe[.QXVe^L$S9LM?IQRq-5lY_lad'DnGq5TORE@TO""AW!/"26PkN3tnI2IQ&i
1B-6/?ClaV^:c"B)t<M70q83F:H\o?1@@3$?l@4l3.alWn`9uJq3s7O]At&WY9BACR.sZ;\i6
mXj$>3,=kfjp:(5:rS5lp7NV$>f34Jl=l]At.8=?L3IN%5c9I.BZ,JXl.tM7h]A+_lAEJ-e5WY
UStL2\E0/5KakGB$:M1mHhlg^Em3"`D\`#;&,f=]ABDHN%6?NJ7jLG4%difNHAt/.>lt-j9%Q
>E'3#FTZZmi6r(GI_PV/r<7Wl<!7<fi>PI*W56QE69F=I`2ta,`=%=9p",p'*[Y<kKeq$l..
ENq7MQX2CN&akDSVlu%YA7N$U(V/ak6EJ@&#JeklX/T:!I5=m^:_rIheXte:?6uK>E]A\<CGq
"$54bj0sj,Q?uV)]A^SVG@LF^`>=u34"bAB:C0V,`1g=kH/j.ffN0[/I8$52ED9Kkn[T4mNJ3
?uBoRj1RKrk*D8A^(9s#tUC[i\<I8X;AK4bVi.n9&j#GYCLe$5\TCetN!LP]AMC-OaeTiu&Yk
6tW*KY%Q1Mg*PF8T\[VeeK75.;'#7j.1V*[@h.'99SX+81nh5<q[Wlk?cDaAqB==WOe[Yln^
uIoX`bngUJ!9CQ)RZB8_^//+]A)ZQT)+n2e[IE9?-a+n7KK\.W&=st`r9Bohe7AYNnsfg3p)<
QkI\`',SU18:5P%L$s(Y'm\>$3E9_Y-4hkd!=h2iE*E5%)InUmV61&;RksQL1/U_7M_AKX#0
9:Zm`/g;YU\`CWrDVYcKT5n^Urd)Zh.@eP23qNl'94J_b0#BDs2bTZ3Kp,"dW6P"[<7IOSJ6
oQ'o1.C%=O\V,c'bKPa'<S8CqWpeAOE]AH88I21$'*J7tSfY9Nn+`4=e7c7SV6MA&c+>XI,.K
`MhbLi-h\A>,4TuMH!,/a`!GdUW.jq0l9nk7%p$YjlObAVq#9dWg:^`.1<0%UF4i/kI6d%V0
*Se*V6CVLof/^:fVk^2/=igqJ`A#'=j8mW[TY*LeJSfp@ai^\GcIRQf@!m^B*QS_P:'L0S@U
tlob9.W^F>OJpAq"`H-5gn*HXH#9B,T?*su'R;W6uqk![I.en(=KJ-0^RO,K62.Yj%Y/`sO'
*LVgQ)Tt.*-ShK<_P')l+Mkh16kkd2KZpC;X_G@a[E[[2@7e+X<T$jZ(h<?@a"^9AFVeDbo=
[`$/oi<BHGQRj6+Pk"pBDr/NEX$)O>lSClcbPKK;B5:FMs<g&l,([Jkf`qnoJ^Yo@.4X\k:7
VoIT3jTkY$CX'#a(2QF5M40I!8XUbTrZK"^GJn+QDY<O^0i,&3Wo2/""Ne=/%NA5=jL.O%6[
J4AfVHQ1&V!@?\=m<ba3"Uifo95:`co5m3/59mZ,NA46A0@0`0)9/+q&I%\8/hPM%]AB]AGDc&
)\b&&VHlk75KMEm)N0L'+E_CO-lZ*cG[))O]Ap22gIXn1iI">OEM[N28h:;!GrDRg^G'tu78L
>p---\?pmjg<e>K8NaaJ2_^[o3t@QWmW5=B]A"#UVlR!V';?D`&&(<F+<t7G#8+LZ/C3'L[_%
!nY.++4!dFC*.cZs(StLZN;2NcYpKf=Pl8\B$%dS0XoAda[>,)Q]A`?2:<=G,jchNW&ZYqMa.
l^-(I-C.-?9<@#lrs'9h_Ed0mT-$aWA5OpX:K'$*gd2'gUJY)^)(bn3<<*$o$c`f>/Q!f/DD
/+O'[B#b`I>41-MU2h5`0A\6S>TfI^RPU.'9kt/PNio1l0f2?7LA,+E6jW/Pl\Une>mpH3ZH
Kb]AVa^!>\s6jJ"Gs[R:8ODXJ`i#<L:0`Lf*"P_$n.`6LVdm:=JD44REMD'-5Bg_@2LE=<8@Q
-9:43u5Pgra>r'Q3Cioq_1p7btc61j8Sh$JS7(Fe#V,eZ=4Q5aJ)Legt6ltfb7`f,bNMbTZ*
;VO]Ae0bN7nZf0?_(idc90hAl8n'/bV>0#pT+865;Hn)_cS`df@?_eLnrgEol%_*/=.]A^D.RW
&Osdd35;it-=6_>I'&Ho*rMQkkWr5)]AbjJu>p,SH2KH8u4<ZLB0@d2_c^T*'26ss,Lep!>10
V#h"B+/)/814B4C\4W@HonfLDZ4BU9q(SE&3tR#Dcq9)sNO3-/p5ei<S!D;5Irq03E,*S[qV
DOZ_$JAL+VT1@`d%Z*p9D'!jr_rF>$H"<4T>@9455WZ%4b=sq]A?C`HG4p?^40O"`:hdal7[p
Xq66!pOY3Q$rlg+:rL;a$"]A_T?_pcT``@PW&Mls*ol0^#uM5b^9$O$<rRBk1%@NbC`bLNZ!B
E#*(6AX?V>J.S-acrhqbJ2'13V7,lA5'o4<NARsY?R>]AI`t[Uq]AT%X@s'rE'?CmrQ-fYAEKq
`=lgh;b't)oN(HYb'g`RA_i(ah=uDr'`W1b^rt6F@j`55&H.(V[/.=sTNj"O3g(?s#VVc.Wr
tnQ\KOeRN1lI0RWD+P(,^"\f]AqaS+ADBC!o]AD\lF4KYT=DBY6X[ppQJ(I*p;T$]A?7JgVEH#1
%;_?W`(5BXugW#!E9MtFC>&B[.efY=?([#)paEf7\=L,.F9p@Tbl%L;&7.)km/<NmmYh4)=Y
+RZsZ&@'$"3`fcQLm(<9%`;4h#VK-r3U4M*+s7b)DYR*T69`f51q2,&FMMt_JHUg,'*JK=RQ
_l4uo:Np$trJJ3KkTh)O0t=7OMD8GI"*<)f[OUl44W=!4&i8PaGQUc#XmTd[gE(mDLa!'_83
[#E;\\$Eah>!k3qB/]A\apf?6#=e-/W\9f.eN6&-a"K=h^>S;Ib4(/Nb@U8$i&H_,[!TC3,B_
V=R'RNZdT#f0?^oB1\:/,*X(Ug'pe))u/gK9/k(-'RVCeUfGHu[7%?uZLT?^m2I#%U1]A@t"7
Z?T/"r@e_VgZa`_LF##$1+=>9+kh\U!ZG.-??Da)&DZrW;Wr7Q#dtoNnjJ't/Oo"/=[]ABqJC
\<'F=#iL0;cL9s685Bl2GTo0ns7bn6k#<kS:^F`ptIrJA)Eqqi`p%DrZ@.AD%mSM[7*+H`2K
:J%#t\eD%urVp0slJERs)2!Y)2B^"SmoF-/d[e]A2l9gIl)Wk=*/SMJ49d.>^r'E]AC+aG+4B2
e8-pbN:C#P1kBc:83_VLdf2W]A0id>o[U=H1^UehmpH\4Ae?>2C+U""g.%Ba!ch]A6MomDE[0W
liPFE#T$ps"t`P;%e`b$54phWh[(p7?DtMa(&)%S<grBs`9pO(tuTF";4HkE54"@U[g`%o#@
NQ<M%$J4R,gH.Fm?:B!d0;&+l\-2.B5nYN-c&I!#sG%=,9$hXdJN)P5P('&7ZbsYP8YfMFCa
KE>h2[eC9@BVH#Z?1B@7>:mb&5R>XKMQN/'>E*TLNO`8o+rY=U&)p)/6Q@dGO=B#PhS)$>5-
PF:^B,6AfT-M8r(b^(.7i)Js2.7J9^Mr=V53Q<kG(0Ct(d+i`c5K1"R94N-$m%l4&ER5`k((
"\Xo^!ACi#KHS=e@H[&;?bd7(rd(aCETE2DR]A@<O@9'kZ(FWT$>TUEHRKd6+?EU>'81RrDqX
DOiRaM^UZ"We^DYr_)0V!"iLtjO1A9lC`osN1]A1G3'.?'\W1,2j=7p12g#\b7L<Yg=YH:,;s
U4F8YHY8e[FFk"mX!!3&XO7i(<N]A/91Wmlo_Xenegp3mrNWp=/p\BZWg&;H=tm5."J"&uSJp
q&/8&2NA,KP$/d#*9*WpA'56V_j,;fPc>/qL=m)L3cg4@onR"p(Fnc[;)4-bsmf-[B<Z_U5*
`LHk4YH&i6oR20t7Jn.@krcM3#A.fESDEEa*`@(/D^.*k>B"^:ZjFX;M:<=-7(![=NU+-a"_
8k=T"4i;JbV:ek\6'kkla6's<,U9Na0C"kUj"-cP!/25"F#;>Zn5@GRkB!)1W7hb<Y(m4?4m
M]A6-bBW!q7:TH]AH'$67,Epmf&r@A;J2H2pHUeql=b`+mq$3$N,-?Z'-)e]ANROFIk^tWbZrj-
,Wqk/eKUtXc'!V%jmC$D,qP)a/TqdM3I=bA!EmfSOD?DrZ]A:A\[\7R".2g;k?n#"TIHET+XH
#!CMBau0BGC2&P+%*nk'"sdD(i:2?3r5<M_K4#IF)HSTq%d$aE[4N]A6-2ibP5"YRI8t^F%s+
4t8+5ng$Pb0]AWn+DgahT74qmlnl4%-mWWiLhSbd<9WaXLjA>IPb<MZH@rN#]AjS/(9P7$'D[0
f8.Y5l%gFlm7p6iG?uZK3K;gJbT/G*49]AOnZ(ia_anSD/J0Gnd=Z,(kQ!7qXbnq9C"GW)J%@
9PFk??&Ld[6`FZ;0_/Sf*%F2KR?c/C4i3s.qd8nOd2l6\%:#R,9IDm$^(VX9DLZ0n5GCQRB'
>1\m23acI'a8:O^%<cijXo#=sPl.ucEkRspL7KB/h!pU*+(L*5T<3QrP%tif4V#-dCAEgf@,
$Nbgk@T4Lm>UOVplccs!N^ga?r?Bu80cG%o/lNA.d2C&]A&T0,aM`3mD;D]A.dii[Wo7O;k2rV
"pe.2P"#,8m^"3e&eKt^p7W\GjhQJe"ro%Hr2O$Bt3Kdg`P@'@VY(Jp1DOF<HSA;a!eCrU$*
:s'c7Uso/BAgVOt"#VI8j.)5-"&\8UoU,E!!*ijn/sIA%X*rSp,#7fE5Kh7P=R]A@teOC<aC,
:,\+j0I6lHmXRQB40-q0=!_htm9o\6!;4P+foF74IA'AU*dBd",t#DM\MI',ruY[;]AKF!0Q!
U&nf_B&mld)^<N[+0-]AV\N1gVaGsq2I#WCl`YChEQ,U\bb(BLPLC3#>L5E#cEG/]A76S/jN2e
07s3<q!=o]A[aBkO]At==eR^@]A\p&6%OPWROMb8c=X[*r*Btp-VFFFDK/A+R8Nr%CO2mASX>p[
Hj/;eEB-;4X5g]AE$=^]AY=UOO\%K5t8j1&pK)A1n*O\&PB21_t-sfC'2n46RQ0";_`Pb"1I%m
0Sk+:7YM=QNn)U&Jr\k.#nl(hh6-3GFY4;%]AN.?ps0A<e6[L'VB[r!YXqP)L;0O/`bg<YhX)
9/]AeRQ;?CM4)Y1kJ-VSmQpKCVQ&$K:HbE[*@`jp-,64iu!!mnICbXU<EI.Ucl,MQK?&(N&!8
'#JLEkHn*D_7.r1/mDEX1]AZYpXYBiN"$e).6/<s^&9r"2lCH$d*F=al(GgCJli[CE922u(ZJ
,EEU(:BDfmr[UoJsEM$Lk1P1aIAcFUm^FN@;etS#-p:Kaio95%f^$faf#)`9V`d6.D]A/DH$1
jX*c2'JDk7N!os5X5,q`e)Ji?R*#I""AP>RHjXI;u@ds%Laq$W@uKWE5/E6$p\#mMW$Oo:U7
bqoYIhW9F"+TXrQ)uCQB2FB(lSk-7e7B`h)h*UBA'6DI2/J-d%H+bjMaSXrf3'dnBQ3FKFdk
KmfX*[2VX;\-h.$lV$53,:lKpG8VHF!.D_je@`PO,MM>X`=X?V_e,de-_`#tR'.9@Y(p3E!6
b/HKtdm8DY%k@[n=?ee%>B"CAeD;NW(?)NYMC9/LK@A+X0RT$^kO`(T._.[38UpWQ$gi6W;!
m2o<C[nZ&F63+8kbo/t,"-k=BesIr[R*-%2nbu"3-SP![tfDVRLkJl6q%0\jFr8@.J6?K&6M
CmV'ibD@-WUNqRam3g%FtDm5bg3l^WNE:744rg46Nk#1alg4D_ai_;AU<I4]Ahso]A&T,b-212
@2DlFdqV=9cOhaqV)'=hXY+92>LiBt(Pss;D:(EfE[F+)V4UU[0aXW/6U)a.3^L?l8\Q]AAZ@
b"i+YqTknr:bZoOfh8[/8@d61?_s"a6^CO;(jX\Y[jVV&<-k%8L/N'.Q&sR]Af7Xa`cIS(KKU
6&mZX^7"H*Te^)Xco0i"s+s-+:s+u:c^TS20rSa71f4kEf=:+g.TV+KAMs^k\mQ4H"12=KU%
'LW6Mt$)7DK@_:]Aeqr7:HIjIA[@8X+YR+AfFpmS&ajp8&3tqa;1F"8ZjPe<hd!=2%tZ1BP9K
c:+)]A9DC<J"HqM6pqBNt?`5KI%;oYln:RipCZNb1#k3r;QW]AL!qb!.P;s\*IE/d3D@rrlR0+
iJVrI2%d=S+Y>qQl:]AkbLC3XpM\#aDeJI2RXSDni*]A+Q.@-Ho0?N#>#_'6YsHJi#O5]A=?ihB
#<rQosBiHV@E[Iaor$c6qf=:>?'te[3g_l%1L<KTJt$3!"<<7HMIF(%2.)KE+-W$4]A&MXF8X
4EF)@WX+HX`BYhZA%CAjj*]ASaSBK5ek6RHi71;T)8::Mk-8-EeG^'>jk,%&[Ms5Q!R3(r\Sq
F-;ED_,Q>-8"nO:E`dfqoOK<GOO2_6QFEP/aVcffLARVrG+RWj\M@onGe)5r^Mj2;bhCWEp@
Eqm*$`hj"=0.:E%o*b?bFW\dP?qh"&Uo(:&I(0@;":S(@COTf$:kEa&XuGqqa+A.UoL$X_4^
.64C7/DNV*E2_/So/@Nq1V]A(.2]A/$6bYGG?IeIsoU9ds#(]AI>U@b=5th1RpS4oC5Tg]ARO-$b
!^]A'b$JKC10%(LdYG3cI\-+c6pO?Z$ZFGYV"G#J%CVORYUSRN#_j1g\H%!rr69JpG-U_)/;j
D;76EN56(@"D$_jegJ4@jK;@n1\3&?dbO>%kf8mO/_HGN;R+C'[1:C&e6.>m;l#ht60aO9>U
7o'q?!tRf.qPuj9a)]A#5N?6@1RELh;c8<X,Q7?GP[f2")#rDfRJ&L%g=#3TGK:I8(do^31>%
^8gKcd10Q/ehm/4N(J1XA%W$<22n1)<[<%_em$F[62D9b:3Zhh0$Ol(`^2]A-6XL`@1r`6Qh3
%(p.*Qrg';Y53XR;N&[Sk\;Pg=q#5je8Kl'd\qD*>"Sh4gYhWWnSM:`]Am`s,m^Jmjs*E]Acjq
iN<D$0aoKNe<pN+?H$jIoUtT"(gS&FRrU@!QL-?rq"$_tK-a`EbY3)p<^M_@b8b_s[,D<;a4
uVa'hEnuCS?!l(')rl7Q*F/R(!?SL3eQ'q(ZjR7uIofe?GY7i)h8p/AM)R9h),%k?T`P@\%B
IC^Zl!SbAhgnOTLs==rOBl>"<NsK%]A\?gE1Kh>#"Bh`50;*d=0O1`PR!uQj@%Y33SU[uQZ]Aa
7G%;2g_1fR4;8b0>j>Vo<7Fr?SX5qn*k^bk7o=P.;L?km<?6bP\*(-NjfR-/BkQpd)M`m?(V
UKG$]Aab!`H5I9>8^C*L>#&iUJ3We9`a`>W*RIY@e'#agj@)OaC3=WmEF_V"X\q+CEXM-<n+l
Vg[MMpM0oR=\,K9b3VQ<-;Y+GRaAe`r\JnuDQpB#nDi:alQ%f38UjHXlWbk`DK';!)W!WX$m
2-D0#''l7l-6"E1Ng^$7G.oaam2ge?lQbSiI)S>k;6@o;WB[)$!);;<Wm_1g?\I2tF8VYV,d
*TK=H$iiBaPV"R6p5CKn4aW(%'utl7(58bCl9a]A5gnU,kkPF`AG!W*)QEO3jL5>qd:W*rjim
19L#33nYNlNV=YZUcphsPb-/n091_nX*hM3pmR57.2#u*-Z/I%@5.dQ;P1Yp5u&F6511.U_J
k?Q8Z$M2to3qRr?mcqVms!h\#eON23IQmD_PpI5-p%mu)FN2\]Aj)),84Z\JT9s6N-?/0D7Np
&L9q>J""(SA(AV4OkPrk/8Nol\c%dCGPXfc(pu@j3/;`]Am]A$)NQb^E\3&:cU)H[[&mbRaMkp
l2psLoa!1#.%1mHMc19Y^I:]ARBP(L!qs/(jRe0HYZ8?]AL5ZfD`m_t@#WdA8DZQIXV8^G+L8r
pFsk.!^]A_qrVdS7$ji\kPZ:S`1Q]A\f=iECKciJ'ojoS2P!%_Qp;id%IH,4[)"p!?`$[+XU[$
%u+,edSE#/#Ak/"njlFFXOk3;p?@q?]Acj^Mt5$GJ^25bj5+Ta`@,B/olXbdHgaTO08F>g&uB
fr!\?Mgq4WbloZsXHG-jRf=$\1cTEHd(WX(^I`O!>9CN<VdF`&a0+()J(M`PREq,f)SLU0X%
SeqF+E.Hf3Xd2#X)Y/ro^-\RV+ZJlZRMm*qFDVbCt@MUt;.28Fh"cR=AK;%Dh9f('552Q71>
t:pb-TYL1Ncnq)p>[2kE-LJ]Ao+A'P,f6^6G8%p@O=:@NU'I[cCl/=_/]A\lIh'n#p+!rkn)CK
e<2B-)H+Ma-tEAdo3T!r?F@/CIa4ff_t:G-aJmg;m^<.Q/iaa$TOS]A\XL0or)gPG\=M6Lal`
FZ!s=G.E;YY\=Qg*9$OKGVDMq]AT!e/r1<GC&&!-5Yg9G)>-;>@,RBV;j(Xp06.hbiqdJs*[G
iJcr:78OEZ3?]AGo8.(ESHi*L";**Q>a<k1N!$VEUAbQZ(22Z9U2NK`dfeUK4rnPT/0n"Zapd
LNk@69;=$.Kb#JA[ST:Ln2_7Ms3Hs3/NZ-ilW/i@<HdXo4+Vk?RTWbl[`!_gr3NeVkcX_b&D
rfMqJ#%=72#3jlcYeCN&5>='km9;d3m:dcqMKV-qj@k<;DKN"?&IieQ)RAg3$Ya'UE!G97#3
.^a3L&Tb<b9VQB+G?3t'@/5bju9@nL\__I:c8sd@)l'M`RV2dec35-reE]A22Bn>E6]A0T3fm*
[KOd+]AVlC]A+5Ri>a?#1O&&i:?Z1M_d9pNu-l%GuNCcKXM*S3/8'YiMk-LMD@5dhG>Z[qD8^-
Q]AV^;90IpgY$:I#\aj,&Z&$;Z5k0)mk/)tIn>L3:#0Yn?6/hJX;p<&>,`W!P'X'D+pPiuB[7
*mcF?p-@6t2#cRA*+`O9UpPJ.sZ^Vbkp$"d;@DHDo:?W]Ac(CQ+,Vk"T5?@Tb3Q2g*JZ!@l@b
(KBTX2Ym-KF-u$'^r]Ad\hp<S,fS=39<-jU+UaSMOuXerD'o=n;`^Ll,C=gXa:\uKj\"tGh`g
)W5u2d*_Kc^(\XS\e2YQ^"!EW!riCUrRMV.JWbG"h(]AGRW!tNi#+('$O&416\!3CZ>&&F/G&
Q:!#`*SB:Ikun-or;Iq<WqqiSk$2LT7RetoKAVr8Sh)>CTM;3jBkkd3K[9RFOGij9.MV.cJO
$mMil#CbeIQXmTUm&e%V6Id^mAgK:,32!8i"!SeZQKD@P&,(u_rX6qEha_sc>Q3@lhS8CIru
YN!IA1[$1;K'Ej\>8'%C>`]A-i+fMP[(S"\<W5XYrAW*PM7YGf06[)=\tT[aE$qmF_>%t/t=b
o4^A'W`;a%p8f'q+VmcQ;JGUEh^i`02V-$)g62,us?ttNp8p%rT:t9i>]A$.C_Smti<m1.#84
F"O>E^48.n;NgF.5N:(beHHAZgi?_"+pZ3L!W-u&C19(hXN[4ri,'$H03h%HL$:T5n+]ADZU\
&[?cX"OPDU%6WkN(q;;(48c,5u,E%D'0;2QAh@V683gTo5A?$Q;8s8O;+I0<i?!Ib,i5-Lc;
"S;@^(M6=O):E2mMXV>Ln!8[6"B&7;<ioJ43(IA+cOmp%j<'0i;*&-_n+nLSH9j\[dn&;19u
5EtWeA)mH!S&,FQ)MTDZ^"N'ujcqZ!7agD3aO*IG4,pJH&aWJGTb1b+u0EW6o1i:>sK41jJ!
a<GBKL.h/%,;nG5EW`J>g$[=Q^pU/09FPYK5)%"FCXiXj0WHnqpPH^.Aln_TF2V73qIP4h%L
D?o#?'Y[JP,tPk%K?n#b^]Af7dD"!]AGcGB\VJ*_U!:o.)_KU7fMRnO_'\a5F8hbL.>r_r1QQ!
GO8G2)gjUhhG?\?KU=KaJ-BpSdJV<W7M//Uud?@uEXcr-(;,^b"^$,:h<45a\R[k6kVa+_tf
rM!V.`\i,YI4k+GIXa<:(SLi_Y]AmW\p33I^7DQ[ODI.[I5<f#<rri~
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
<WidgetID widgetID="be56ac11-b658-428e-8742-d9ad3dcfc26b"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<![CDATA[1463040,723900,944880,723900,1005840,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[274320,5974080,2590800,3230880,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="3" s="1">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=right($rq, 2) + "月" + $bm + "工时投入"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" rs="4" s="2">
<O t="DSColumn">
<Attributes dsName="指标" columnName="人均投入工时"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="2" s="5">
<O>
<![CDATA[同      比:]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="6">
<O t="DSColumn">
<Attributes dsName="指标" columnName="人均投入工时同比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="0" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="3" s="5">
<O>
<![CDATA[环      比:]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="6">
<O t="DSColumn">
<Attributes dsName="指标" columnName="人均投入工时环比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="0" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="4" s="5">
<O>
<![CDATA[年度累计:]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" s="7">
<O t="DSColumn">
<Attributes dsName="指标" columnName="累计人均投入工时"/>
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
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="0" size="144" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[mC[^Hdq@5jhU\Z$CR#bX5m:\#909Fo&_WAV:3>8=)@OWL[O=ub+p8/pgK86j%83`2+BrS3&4
MGs&cu38Pglp*75f]AbN$1G/JV9+JhqscDT',?#%j\kbhd16uS,.nH(Z)^K\^,[fkFBjYG<#K
o^"\me]A(XYj??fo3NkbO8rsLKmm.%q#Mt['t1&-qcF5Dn+i<<uHNk`;`a=*I\E0Hf!C&V_mp
u]AZTd]A]AjII3'b;]ApLjefQk$t[De%1bB$;X$OJJEn%I63]AQ)s8H1C+HOd<[b^.I*O^I*>mnkB
JWb.!7p>h_'(O*oJGl+TQ#qCY^EK0iR0@/p`j!SGm4O;bj@(H@Rp#jYa$7l#NNG9s:&ZW7!-
kH\"Ki.0=QdD>_HMjV!t_pCB9-X1;8WhYjYYY`e`pgu'l*WLi<s0:WTT8>h7p$55)*&W0fn9
s8&pA*kq7qugdC5G:iYBtT[]ADk58p]AFXo-GO]AodhV('o1SiXg[9-@5(Xklh_"UP.Vs='!Z!t
m1T`D%"[3t?/fk0,Wf:8-^&p;@NuR%&U7N^M/,(/@-;7atM@%n9DQgC;3T[6F?&"++!M=/]Ar
P;1@Hs>Ah+?ObEI&J2jd^fM5;Oi6oE'FB4USHa2:0+"@^t9X71p=C9*:^Pp5j0F*]Ak#i@j;#
?\Vor_Gnj)ZUb1e$*pd)0RD`^++.@M4@^jf*u^[8D6+%.(efX#@Po;p^m"GLhZ,:@nt[`%b:
m-PtjBB#e(mTe*UY!;1dPSD/I?H^Y'c!=CRhIhQh*(s#s.bCa=834+V:@4VC?,!A:NgHtC_7
=Q`B@ln]Ai-)u<7eM"UE"jKZ4j%sR#q!iCmhe0CO6]A'Ca#jM?N>PGNgpr1X[!5Z>X!"le^Xr+
c5:$F;j?LSR9apMDf*M+DhJ0dph\=pYQJ[,g0\El3qi/9O]AKM@#3?r_O.o;f-QMj?59N#KCV
MOd,_"<ffO"Z.RpViX_?&aJ\gpNdY=+qmIo6[]Aua%F8@q_EA[>(G'^m^"WFTP]A&+%uYg$W<j
0O8"hMD$hHGMWocW$7j%8RZAQ/A;0ET9P'i1EgJEcMp:Y&</Jms7G/ddeWG<p-J(RQ3TfMO/
AT?o_UK<,^FaoBqqO\*F'lb1["[N1EOk!e"5`jpV"uBh+gbJ<nopUY)MSY,IEb`-C-L-\_lJ
<)a*sE&ooeJcSH^E@$Nl_1DR.ZRIALrdWiZl'9HuuG*?`r#bFn5^X+0Rs+@aLN)9^^Up#IpU
(NYqM=!Q03d?I0OeiDC-\pAjn(\)8Ft/sI-Z.tMd%lcs+>[%(>td"a[j9LQNH^F7h7aKXb^/
%aq<hiqHt<m@?9hm`%1oK@Z:A5<.Qn+rrOcag*f44k5%1\CtQ>\@l5YE0CbcWnX^^9I;q5Z.
,qk:Y'TM6?fn^84$oaNGgk_H<JcAn%%Tko]Ap=St4%Q46,=Q^R(mKq4!<6"H3ICY0B39&Z0lI
JQ`5m`n&[[fpdHcMfT8]A*Bu/IOI*anA5aOp9jBUE;QUQ+\hS"BUaeG&l0A0D_F'-eES6I75L
TF!E^>C<[C./a-s@HkjVGBG(<Ip_S+OTR)J'T*KrL>K0=7-bUhe'4^de]A2#*XmWQF:pUBFj=
QUq5u&+AF60/j$h)<=!5Pf?gPE`tf<1%O.D>roQ/@:/[It6U]A+DI3^)f2[Vn"Dq=fdaQ*gLe
;_tqUkL$\VE`a3VW3keTR:?o;3ZlJU)b2<PEIb;Om/!AVJ^H2OAJWM)jVBg&43]Ap+XCt_CN8
5?\;QB[j_([(Y)n^Z?P.$!]Am01!"N%]A2+"YY,X=d`>S`!F70MKZSMQTU9^<mRD"PN2W.H,Uo
s+m5V9D*f^Qfh)7GrG5J9$UTB>c"tH,WH0pgG/VQFS0L]AqB7X"K2ag.]A6K@M/dk,(,ThLAnG
!C+rc:lUAV/(e4;o;(3BNF(ada6-DH-IsUm#$?o8<o]A-5tQ%>NgfaF%FbaO"?"mVNT'+bHK<
D<Y9cp-R$9FXVfhFp1Sje4D6KYqY!746DdG=[O`)q+NW&Ppu.HW^Y.BZ=WR7!8RZ)M=Y81"O
`'GeBU3eF"D.*2j-Aq6Uo<YAd5tH863sQ;/:%FX7Mqnu9SaV>T<I>kl036]A;^TK0mQhjpqKV
)?lsXZs?(I:!%9ST75On?2#??W'6`3,pQ7ABY^35Q$BLiT/3?IpQ5a5uW@upKuY=0W.RLX=4
cL3O;>9'W?Z"co]Aq-`rAKdXDLrOWtHg(L!q"Q^(al=<R,h_hAdKg2979<14&c+3:#+"1ZU9O
g]A9(+UX`JCG\4Qa#*cK3U>API5MF]A/]A'L2sS/'9WHNC1p.GX0r2:NSKd`EDRqpGHT;afi>p*
-W[LAM6>A)`q--9\n"-C^CoV%X86hM@md3Y7/(\eoFLmB@B-,*\%mdBT#a"NUUaWD;r'b;*6
/Ei9+GDG!m))k!7rfA%'IO,4'<?n,G/q:u13+u;/XC_CC\Kmbf@bW\RFW2;Z#MGkNf!U!1`3
,:,[O]A(J=r@_I/SWjaIQ>\Wh@S&a8OabcK9%flGug@M2D[`6TME/W17tj5#d@Y+)kqRd=`BE
P;b^b8,/$>lrZm&HWVip866>[>0dK9>RrZEVE;a):(ZF(Cl5H4(MdeO=V)L,\M!EuH&H9s^G
E2bHs'nfUWC0&aUU,7[DA\RAO%q%5`O6a=J2$HVnd:cm?VpX6tqYC:9*pb8.c?2VDWt.W5*B
Ej<-Y\D+Em*4Ms\AM`2'(%KW1>)GP"GjA>BdOmh/R5!^W`%3CP=BO9_j0r[aC/O^NgOsErmg
@X8#&PUlA\)+<J=?]AmI7jaBT.+ZT?7R%4mYuc,T:hU1c=i'/b;r/.";4:*fbmY(aN!/_4l5#
50=FG^4)5<c#BR\-loCf;A+B<XHY"J.I/2pL$[m2?aitd=j=beZ%<j"J684p_&pkN.ZI\hK)
FE5&f=K5'KRPN,2Kl8D$!D/6,be,)Y/(0.j,!qZE\S,Q5pVh!>/a,n09c#j_#qd==:*s*2#[
T]Ag%8/<P`P0VTko<6W+Dl;fr&.duJ_7T>ddbOq,`DU;rB!ej=61#T/r.*6MLH07J?Jn4b^es
MXqGIDq:s1B"$<ETn.natkdLBskOIBMod]AG*="(r*TlR%(QKNMu@L!XXp!FoXbJNY@W!0h$r
/@fH)kbZi<g`5u:Vc7EU-]ASD,(Hk7V2LQGlX6qppp2[-:lG8Egql4u6o_>6_/`IoMln+h5:,
G/Hp+-(`O>r7I^;Yrd9A&`oG$XB)[.qKRAI!#+g7ZY6nL655bI?3[bg_IkMg.<P?1j3Q,j?m
1tD#Aq_d.Y)P$1BkP$sd0hN,f7_I<=^q_5K/Ka`ZaJs\'d_LYOK%]A[fnslV5-o#jj6BXM.A:
!'8MXWbU$')We5b((_%O#:)oB1ja4*7mi4'&ak[)\<_*:QB]Ai//%)adu/8)Rnd6<O^IOBO!Q
7\gFm[eL#umNmNt%Hr&pmi&E,F[@Kd1a'-DRZdd^?6+*o&5T_'fO;.1,JZ/.CdCJX]AoaUKc&
1h4<T0il*?Dl!jDNin(8X`WY-VM$G/k<ARN"qq;#L2m$T[SFGqLA-+s*^;2d;6N5?b*i,W*+
&-oKgio/V1;?fX.*?LH"*]A;$?9u*_8-/mXOXB[A8t`d,b]A&R5mZ!W]A(M``%lj[lHat7H5.cj
/T>R7:=Lb;=`H9-H1[uR,AI/J&YLZYcIU7#e<dmskAo+ImCXF%lH5k?9D-]A^rnC@qUm#6<V"
9'E^K;8IJcZg[-Jag^Xn]A?&&%l&d38[n/an;@BJmfmI?YpL/2j#e"Zp<pIoPbo^h5<L%)A8u
BiUPO"f+Q.V`FCO*S-bfPD^4V6AP&OHd[/tI6s3N-cn^RBb?O=O+-\EqnT:M.,XZ)VdER?^$
lPEO_M/?V+t1c2$Ca;`$GH=Up+GW8Y>Nj)pI&G'Z]A]AfFfM>;R\%qN:22i0b(<D$kfS1@#2k0
YF*HS*'#0uF#ginnrMq>:u;GY0_L>M&K_tR8"hrD?U51b+1J@@0i;'0%^\<ks68&N>2?8+J@
eW3aRZ*W,ZRrkH,Q447:kUDn[/[q#lDX0i,/kT!7K%"p*&APs4R>a5U`TudX?`;fq5,`>h<4
At+RKXOH7[7!p)7\<p=?:o>]APAKC_/mkCSliFE\W96G)*7/@FJSeLk0q7DL#I@,%<_,&g+dF
V;/a03Be\P<G]AthP5ONAta"LE#"_FR3.a3d>""8Hch4@G7&)eBQ[&'C)9S4U&Dc/+dbI^ja"
<2%lGGK+V1)gO0nf[`3!WCtl5LffWJ;#4Whe>G%X9tdMb83eu!B!,g^PR*IkoJ;J.*((]A\J/
SjnK0ASJ?q2RJ$<m7T"V+Hm=NhI0)J!0r,m>oW,c/?e^anLqs(\9s+T`3Nf9W,eQGK6;ph7Y
Y:k-c9>P'W.9]A.e2<4KnJ""f#Am7J#90k+:"ted<"T$SNTes"9+^,9]AV.'lOPWBF:^XPRP?/
>2L&[B'BF(:Y<UU(4I(c:,I^[1X`J<J]AN;]A#%*8j\"saV#lG89f'1<8/q[FT$F_Xb3GF%D,1
8P@^Gmj?<@*,bM%?a.2fb&pC(:&aesRShT'-#b2!S7>BY7HFd^22?D7;)UksQ-.S'&Tu>5hZ
\6.c"=`'!e`qBEOm`9=."LT[oE.a)0kg[=B!YW4^\^EH6Z";TlM.unD;Dp.,h#j"DCf+E>0T
ruh/XTQg<j&$aa,3R0]A\&\=DW^P+V*@BfJ:_tTC<b7NUTup<[S?>8.Ojm-"\4561Qbpm]A,X9
[bb<LQ`Pl29$k+<N\#.qRTMs\;/,ii+:>`U>Wb=l+RGQ1k"+;\fttY0)O$cAC'mC4juNm1lG
P\r)O$AE[@h:LVD%#23:+]AT+SG8"'7[HQ&P_]A7f,cK.J3ZT`Q[UkE)]Abb$<o11Jh"kU&i!,3
%</4fofC$AGq_Z>jKZRb?8b#o>(#qOe0_G'8^QP=4CWYb_G+l*kY4(\cTSijgkC@pX0aLZHj
-:<!*gm3Z3>@q#^UpX$MqOQarp?TX*=IPCIP6ag+=4@LIt)AW,P7BjhBAU%o#<`YJf_$V%%3
@cS,Lu@*j2Xt=TJ#!Nn!(X"(c0OA_3HNA/AQKa$%f&-:9tPlB?A>nJ%ZR^m]AW^"T=&Y1a'Sd
lFnO&_.6(bH&u^EDChY:1JIJ?-LX.C*6'%R)l?,4RK:Yr[5_u0Xei>R*'HRA_eq5=;"pD40F
#U[([.bkf.kJr)@ak>fa9dlb.sG%S5'#Pf[1"7$PUmMLPA\f\TG4^Yj*XXm^VsrS`=q082p3
d>M##2n\A]A54F+Z='[:-@2Z.j'o0E$7?Eg2d'C"Tj!6A'Kh[E]A03OjaPb7tCCpY(hhCa1sQm
@KV"_r'[Zfl(ZrpRT)<7+]A2^4FXX_T$<):EA,?]ACl1oA+)?pXq^F,=&h\g0;\!r$$=TB?[3e
c-*nZ)9E\C4,O.7?b:MH">:SSJh$J$Pibsc#_4m62^mNp3.]A[t+0Sf^%RU[c0@T+,j&O_s=3
HB8=q#+B#,e[?n2f7?LCaj3Ea8c#f=XHELdE$3be<qA8Wrj=KQ'0B?9MGQef%pH?/hBA\J5K
&gh9Or4!q('l9Z,DSPi=?Q2_N^cCJuUboVA'-]A18XV&AG8b7PgF5%=p.4+,31:q&Y<-e'fRX
eUK-4W0D:9E>5.Jgn5L!JFEMLpXYiWR-FY-!81SsdCKVE,=O>96,-"`V72![UM.Ibu2W@?7@
Ma_(Zm&\FK@SD9RYRO*T/(7]A'jOi_Itumo5LK6KFj0uLX+\S?J=4k;CIc2M-`I`IKKNeE?R]A
!bAQdcc@5<D6fB&4&q)#PkQM,L*Wa+OE1;39VSm/8AC]A%#t+_tb`lk.5sqac3W^^i:g:DjtY
C5nXdm:E7G%ut!lVgsA7KD5@8(_J:U$qHQ<0G_V.l:fRd>)mMV,bEe%35N9A1=PD&$V'35VD
@C0GE-b>qV2@r3`;+oMa>Fs[_)P5&.I@@HdQm:fbM!?_(24`-bbKIQmBEBh1;[7r/:0l.opY
tVI%XCc:]Ah)a&b=hW"Sp9YWaY)8+FFjF[9*EjNeS]A%e8EAm6N6Fn<I&"8?I5(m_+5ce0s02A
gYpg&35uZD</;OI@040_UX1kc;,DE-F4%@.]AQm^>u3J=If>->cY!ga9lHto+\>u]Acm5sKF@O
dQ`\GU1im=^bD[<%rKnP6qlZcK/5,/C=B\</76gA#'E/\Np4f(_</NGO*1kTe+RTYF;Fp[s=
<lTgm<9hYn@BsQGpCG*FK<T=GcA`;RnpRmA>&7)MV#+)&;C6?KXA"LTo?$(F:5>R-39A.73G
fJFc]AC@<BAM7mGO,e[Xgt=\@F%8m'MNMb7ce6<naSl#cZW2;7Hd^>f%$=S''<sYBqJ"H3]Ag]A
$k;H$-nueEZcf#HIe/;,PE>7eSDU1L2=\M`o:$s*`+?_(1B=eZ)=0\!'ZW=^$'-BS`qaJi_I
3T<+QD:&\p"$riP]Ae_o>,M0aR;SR.2:+>M6`<b>iK$=e[Du5jl7g4?TrLm@RC>Bh*a@=3)(`
N[VH<r0ZL"%W\:6bBOHEb8;)LGIm^d<f+ZF_T36^OgXh#\jrugF&^5T9I4'GoJIHUm1KX@)Q
:"E)PC>UE'16_bX%_R%27Zji\Y$")T)uUpUTdP#9I[H7%:h#k8XVkO]A@0\f\cT`_W]AI%*uPi
[/8.$k$/[<oj$#nKcRpB436+'LZ]AL<"1(_9-k3$^$dogOkh^-#ne:qL>_^I&&:+4LXjjV+Va
%#/:J)e]AX_NG(,Lfb6,qXEK.C:.DHF/'+t=LGTNt.s+HdVZG__e>N/fSi9d3FM4&Jo>9Ktri
CK5TNo4i5[P"]AGO?HJ7R]AZ?sC`i-,2G9OMk?PlKq:O;4PA@D_b+ZSn^Pf,11+P>3:ZF$@n0@
<\R&k=+FN<Koo"H:_HWcj,7+LBMpZ_36^(f>?(pp%*T'@'VI&!'A%Zj3+iUg/Mfe/N`CMm\Q
.ur+*;5$8YSmhW.ILt"t5E^fA,5HNN;aTM>:,cpYCQl)r^Xm6mQ@soQ$f=t2iQ6P,1nYf8nZ
3e`40&4oHA?1r^Wdf5?%g=a)W3[E`88<p'&*Y+*!dQJkL<R%9.cI(!HWF>U_Y&pN'tV8f$Vt
l]A>MO:PAjb2/p*n$EV3al=l0!l3!-s$/..$&\5ZBblZ4n%TbJjN8p$&c9S=?+cKF4^0\N4)i
kbN40=,Y4%ki9Ucm2]A:]AtXqF,^CJVMgMn=%Vl\I/$&8)cF^C5KA1`Y%^6k:k6uj,H9+qEG$R
CCOm)+`c'`NU\nWaASIu)48)t_>kPEe-r/o-8"N4P,3iLH5Mp@&Lr=BIqf^QP"hX)1DXe%g<
2G]A!GjFVKL_J84ph&iP01(K2R;!Y1R^JL`GM0H7N=3sC;0YZ9uY,Jjig+r!d]A*"kjEq(3@O(
I=_36KhijrZq<>rn_m<d*U:;%c_rki9@O^)Eeb!it>liTstBG*5b`6j4V6]A7hmJFHhXWQ1D_
gps:/VK`Vsmj9n39gF4&pVG!ZO+kU<A5T8H<6eok==QXbBRWb("U6=;M\O#SVqOpBnB[fX+>
/Pm_G&mQ+54e3saLA9A8>dlQ.V@fckOJ^"4u&:f_#.IT(2hKoEap>6C-3s?Upb3B+H"qDR'$
Yfle69I18N5r/c?[#?3cHnc5dK#D_'bUS"P+jm(cRV%?c70Ln"&-:q:;A,#T)9[ppot3"?I>
R)bYdZ/9c"N[=34jsc]Ar,cYm^]A3&FI5)r+NrpaK=:bDRKq*kg';"%r]A+<+d"Np$U'Wg[YZ0c
^lkXH&nm>qnI.UJ5E/W&_/.V0En3("QWjfLN@Ub9u*p_Fc6Mknh2H'ooq4^Qlq.7MV-LL/;/
]Adq5AO[oF'(VYLuFL!FZ_6:sq,+t]AM5=<r"<n7j2la('r>Y$!s!L*AIRYl2&]A+2N*JC%#BME
h51q#U[/Trjkm4L*Arp;V]AdO)CEUCIN+HJ*lFNSeK#4/fr6TP,8%)KrKHgLnmtC!08Bc<$le
5PTpAtbjVu*I2(CkW8KLVRfAFo;"8If[XCd2IFbiWr+5/<]A1Xu,A,[tb"neaMYc9<EN,@T)?
ZNJVrG8,gHmB0`%d"&QR+ZsVXJp_3F_l^Fm;W)BbUNK:Hoq0FfWrrQ@T!M169P[]A"-*qV/`9
gG3m5,=M'`.R)cmqn1^gsdb?t`jUR[fIF.Crj++=,9SD:P$]A*Cut!@G)F68X(uK4'J"lDr<*
e>m(4\/2^ZkY<IVAmMjeTi4_`=<n*Yt`a*-%e$L3i/J)dF$j?\X@B2\#*o[&VdNgPRp8!?%b
.L;Z9Mm#f5m/W]AG1b9ZP)P(9@O*/,&TfnnG*h7/]A"ekUI..+R0I2MkKbKa!h9?/=1(n/!WYc
W0`!&_MC4Wr#I2Z;8(hBt"$K\Sh$SRA^[6KP@Q1*cO!%'@4-Wk-n]A1_R%RRVt>-``[tU]A*$5
$"k3'9O$7lUnWnk7:0[q`rqgYSm6!ZY"3gPF&+K7&p4HPAf1fRh;C[A^bR4bFW4h:k\;p9M'
LRq[[O4(qN`$k$j&c(8uG&p7ce$Sl:i=liM'ODc-$(+,Vi%BXG0B+)@Di`ns7InRksZ&o,K)
%FNSg?dZKE?k&D,N<oqLf4eI,#HM-9DMXV7e%WX^sqt,bbP'*\(Fs;V6AglqD\f";%E/i8jC
<=Z34PV')(dKn+6RMN8.,m)*gLFOrMML63rA-r$+hjXfH[0teSZ%I>P$'%C4M\M-']A0`q=j!
[M;Qjb[33>X`=W[^1Ng2glle/qhOW(,SL<U-m`K0G'42pAM=?R:rIb"6dVf*?lc"AHA[M-Aj
8H<<k/e*p8*L^uqj0P-<''0ke1mp0$R]ALbtK_N4JTsST8VG?PWI2?"4>@POX0Tu36Q>[%sB]A
5%Z)k8l;2se0%#gK<7N4b3t-9;/<U;:AgSfV#kWANSo9#)ok`#Y'[#t&-=H-np>N!#$?hP".
o^,7.uI!CNaUPG:E*#FIq4>S)RQ0_!)ObKgK4s'SHBfKL=T:it14R=71GDfUqla9@\RA1;;[
9E#SI0&^Hp0!PSlA%YEB.su%&]AX?H<<2V`(N*McX@HT5Fr74O)6Y!eK7o08Y;DSHM@)`$7%.
WIGqT]A$Sh,6^AC$s_Gq^*QQ__6r4+SP?IoUHM2Jq)l#A!fod#\c.C$nWe""AH>V3kN?LGo?Q
XN[jN5(Z9gR"m]AIY+dC6Q%TVc*-ZMRNTLn*(3ZjRXQsoJ)/*F<Aolak`/^jt`SkLCUp8KiI+
TRn%5GcK[IU"g:MW>6f;R?\"q:nFee_A@Ulq:Ng%S/n:X1:Wq'+65@UeIMR&=s1a@tBT3:;<
Sn53F&@k`_,Xt0r:B80M5o6dr/Wmf1(%.c-b_i)K7/h*k)F4Jn#[fhOpTCh:%ag$+^m.`FE3
YNPkNd3,c>'[1E6WLKPD?dSQEC]And-&u!r_7ubLJ&L2:8O-VgQteH0j_OG%4R`4lQn=S@`>[
kscYA2-YZj5J&^;M4>2u-O-Mc`AMC<*([Clf)>!,WR5*k^17R'[.F/<Wb0)'8CJrN_WD[ukn
<L;fi`)T^a&:]ATV'cGK(n%Ep7`p?$aG-*,#O\OQgWn4_8l;#0eoq6J-9AT^`iNpdXlK&O03D
gfQZfn;*rT[&8$E0+!fWVt?JsLT,;l#&H/YT7\<u6sQBPX^[J%iOpAE<k'*Fafgl?<S#`O5N
fOt$<pV1N,U9kL`o8GKK*M3;(T@f7OtWc;A!GO\AmbuH%p]A]AtjTp10bql6qiIk4]AAO6lL-!G
ic*e!u,1Qm]AjadhAnH_"nAGYgmT#dnfWtg/cW!!Z/TO4Ustn0.g(gjqIpu'CDLTgi8O%"=%D
Alec>^+6%:d*OjmfUr=bD8eiA>9WbPm,VCqTQf/[a1.s\:WPZ`2>8`^abH$kOuDm9dtTIS6e
(s@Hf%U$[Tkp*RaiVSqIJn?3b*LOg3k&X93Tge#RI6U$p8IZoUFTJL\V$OVsK^luN6QN.QTt
O*Ha_)Y"@J#D?U@>b-C%]AoM(@A-]A/lK:AJb-Rk0MWOKHng0C,]AkArY4-.CCY]A>_>?BpUR,5I
?a0p14=hs5GF4D4`a(-sLa\T+rW,h?<ApJQBK"6]Ampp!]At;E^uh6E'@FNN/k41W)tOa.W2Zq
'QE5%dpqV8tD?^?dR1]A^rMK-d0t>kWLhXF_?IT*Jrjch_8GqgB$R*68g)?T#4XgqB&>3++ip
h&FPH2ZT[9d9pZ'O^a'1ab_&;S85D]A!5meT,YBlE+XF3:bFrV4'h9uMm^^*USQR9[j@:5gjo
$?_iq2aY2@!39?gj=U/cmGZR^4aGmoklj(.g0!jbE.\HmMQs84R0q6&.Kn"%H&"p9>fK1ap+
fq#Z>G]A[RdUJ*5P-_9k<(m1-h\Z=^\Xll3kdbU"h1>\C6ARm>H$;G@SP&.I=WY%-FUCm)GUd
piVrlD2C3M!U$DY7"Y6;2d,&M_3UQ__aPOb=Kt:2r"!Nb*S"E]A.Rp_AY/!`.lnH!je1GqAW>
i.4o^8)HiWFSlA+F=fpkjioF^',F/V7T,u-?mRu.cbW#lWpKI,q@PNHA_aen,m6,#(`P:NNK
TR"0P`qbJdEG3"?L^l,_<s7WZkhn*+b\;B;&a56H,*qS#<q6EJYAM5kB3cW-le$bV+%>GB6$
P1\/*hstVjbjc.&eC/kSh?WtL(RsOmXXS-\7Vlap?^B6p.$I8Mb;;Y=FUX:F1SJ&S.(qEDoY
/V\.W6bLB'([^ga-9888k?*B.6.L0?io"-9HZ-r>DL^(!]A#6`5HcW.GUP]ASaFp=WQ6<!e^ZI
n;GkLe]A)"e:gKD`dm/eLpM@cg$K?Q&($N4FJAu&kFc-fl3:jVDc^uRc8.uK"gSc+!sK]AE730
M/?+;914:p@ZeoVe@]A5-(TW&i"dbHG<Bq'Yoa:RY&.OtG]A%hr]At<NQ,gJEpi*Au$=pC+8591
le<uPoFc0.2B6>Z/b?l&'ud;GfG05`)bhTI>/b*u*IoPO!>UeHi#'XYG)ZTPle$tchP((n^6
'h'=4qt0Q7Dh[uCl/^=DpBN<\h=11K/;V1`a5i%F0jZ\(cr^,*l7kTON2W[:Xu%pHX@Q+44(
WC]Ako`3`*PXS)%p&5a2I[0MJNlV*4,07!"D/e\<O/2kO]AHB?!$Wp;&CuM)$G8s21Hup)jqc>
#Foo5,=L*I,cqGh%2<f1PB%:bC\u<IWrg:2\,sb>cIT+98q7+X_X`)@u-`uZH=3bo[Xh%h>9
dh08oHAfL;6^U0(,`&0O!Z8$im?DZrIS-2:3l=b0U7Mf.p:a0Ue.UID(:Nm4>K/D-Ak9W25M
SYbL#-UHFb%^5Ro*u!4?kgg7"fUMi3pWr4RBG+Hdr8OF7M#rO%siLr"J(0R)RSejGd=#.jM=
=Uu+2bBd!?PL:O3p>=UVBdJ]AIcLkcR:@Z6G@"&F'.-`j<3R3aj:uV_WBUrCOA8,6`CaeaUlW
+T%A8JC/M26^).,,%#ZM_9.R]Acrs5Z^2<O5>73?jdIo-O>,MlnBneF,5*qdnNm_4IU?djH6B
:d:#c_Xf889)0kYh:p\+1e=n^rYH$Xmj,I?N<`:2&p6eAa3/cIg6^kI'pr";<aHN7>la2;Hh
"2-JVJ"J1([\hYT&A!iim4.afrf^+of2XnS=LNQ;2B#7k[sGbR@7:iF=guV3^44\":[e$`Zc
P^SXmD$S[/qaBg?_Q1DmY>D9]A5Jcn14r_jXI`+@Va0:`^ue9Es2FamMWc/9JU/_g$QJ21n8b
L$m^:\MC^QYY?I)CS.PJA6t)_nmFbqP3"1@ki.[*?On%h2,17[T:>NuC&DR?14W"#Z7AqG7-
!.%-AjL&Xu:\SP9]AC^(^rjl%DcXRh18kRo;A!i!_gUoKB!HVG?q>cORCeOn.bIBgosgg%I9m
h&C\XG<R"VHjSF'H[r,SL_V#jJn_r>]AkqeKCMX\E_)qku/iBUMdio]A\9M`%A[$"/a*r=M3TQ
C5)jEu`4pKBY8)5\k<mpBBqN:F:7-[dp%F*FBMg22p+4+>_u2iNBB0o\h48TmU4qM73kn3jW
kdRLNJ#PPLL'[FQ%jWFlCg;B*b)[JG.3SFA'N4f*-rW`a1$d=(D<GQ`Z[>Hpqq.qlseXD(Yb
)8b/sPg^ga>#`@#Vn%*B.jn!@M\I=]AreIhPeFF!RTaAhUQu$$6Sihg>Z\$8,1&anP]A<`a>04
QdDB4qNh@tos\rW?H^T:7l*95;g9>fMAs(qs-V]An@a"=nScO5A<U;2Hnta7@<FIg+nk>qC>E
q9?jquRB[!+Xq?]ASN,F[*<V%T)/L!f8#HYV>46u<#l?Q`tI=V`N-l+)L>E$).5E%^rlMqdq*
(pWA%rn3/92OK=Ao;fKD*qN4M^Co$MpO^?N@ai#(8M/RjJ7W,LYNY9P-Uo),HKa"D:tgRSr(
olD45M8YsRH;$l9@"[Y@Y"$g"c4X<6C!!F^YJjaTU$87e"H0j<@t!K*\Q3d2/(Cn7*rlOtjl
2(W'[>^3:HZ0!'@.j`rlROsajj_TgY(Fr!SK^N&:a0#Iq2rCgq1:rWT/8`.%[/jM$W[B=NMk
f`3c*`cq;UI8:rC=&nS+f1M+Hoff8`HG.%idLJ`u:(IU*7Kmm.F$;caU<#(b'['!m)*WG#Eu
No'HCHp9l?M%7e'2Mi5bAJ6%I^nG6ol=8bn3A6h$M5q7PQM\qrFrY?LrYWNX,>ir4nEmdbui
J5T&f;1E%M#6k*kSIqboTX5rbFO0daRA1gV+&'C#U^?t%>G%aG#eLg_.C`$SrL[9nhtusI^^
Q0"eu3Qh5cTo-/N'!iC!t7__1=(.6>7OZY%$D]A!Vb9f-na(]AZ0ij8oh!ai=KJ%[^Q-Jm%e(M
l&$tDZclN]Ad"UG4WXY!^K_G]A.BR4,]ANZk)&2Y`4TP`Vt@V?BlOi(:GpggG4NQH>K%=,"6)5F
d!c='OuNL:*FqLR7*Z[fS)W8B3^^r=\E7[mMI/o%JdmMOo/AIV=54-NDaV&W<F(-URV$pDg/
a_%Ud?&OK.\B.=4A[n=lt_HJ=eU0"GoKE-fTb?@YZPPkEiBrBt'I+eiX$nZU;+^=7nBUZI:A
c,f3Z?<>+O>h)uGOFsDUaXB(G3R6%8Yre0i&g/LgbX.ZmBd7/,`L)$@Jc?g4'3c65*_'Ul!R
:lPFr1+cWUi[0umU;kY6c<+5+8;*>nW_g)YFgBIlhh,WphX]A&m(Ep"\nkR41id@,21WMCm,j
ktsf*H$.^V-(a_Fqg^*<<tqeF.oMFY,YCTb*GObsC.G&Z2C3RB&Be39!,(^P'*YmVL7q>H*E
@Z.nQQ?J4BSdUCE$cKM.6)O,9$H`.hB-T_r(R18aD'>eVn1h`L"VW(H0'?Pe8jZ#o$R05Dfe
DW-8"nhbC#Y.GlUM,*gY3#\Lh?']AEaul.^.>k;dUGD*tsBN7`+?G\$*qf6j$M6<NB,QA^.=%
tu(eaKp(bJmOjh&h-PcM$Fd>3gP!/^i>cMM6V,..!r]AD0u3md"-slRa27l7$4QL:.,mjdr3,
'\4-"Ff]A-S>Q6=thT\,$+L8E`mUM-UbmK#H9328DWR*q8]A=McIjA1g+Vgi*`j2dBJ*!a]AntC
aJiu+m@%I"k3;NjcHb,'r8Xn9#ML^Sl,/[Lk[[5BB#Sa?NL4/HYLc0\)tZ1/$4:q!X'?^$%S
Xcho>%:X_:LG;0:f=<lXGie\)o61bfZHWlfYB-:,?T&N2lugi)>I0+K"""U0*&'%/S7#O+q:
BW"MOT!:g9njlU;,U.E4U-hR[<n#[geqD\rU<-*@lERk`PAK$HYT$C80D[IkH#Ma1U>ju"6L
?4Pm=&g<mLE^HDh`,%e`k_4;F=e_:O37'n(]AjK>[e&N2dE:V(L?fi0X@48NR*qmap=;!()N3
%?puQ%B9IX_J2E*n\Yg5^N3'1T`ah[Xh<0PZOX(-@<5hu)0rhD7b6%WjS2<U5bS]A;Qp=tH6u
kA;)oIMh59XD9LbZ?T&5Jb.<@mPe*Q`<DOJj8?]AE9=6\sDU<0>@h>fQi`XNJF;SeiTTu*H1]A
Pp[<045)A2bCRE=^J9Y.`UH=j8(n7?G'7cCrW`U0m.1+#rL</%E""RHDHUf?H_6\`HOM-jN>
"YS9T*%cj%ZR^:<=OU.TWKd`d&]ANa72EcR('\>FGP]A.)@W=_pJ3-M\pT_c#o!=WXCs#PM]A:A
dpA0@]A2cg`uu_&/G^I3#sF/S.Hu[<@c"e>W^*:@p\5uiOWpl<1'Yul37@.I/e=k=ib.5:&)A
G6<+AoL%ULD3?ldo7P0p=FJbE95rSo\8l$[jRT`oVAB$@?M[LOY'B#8Q:mH.T-I8F2gR$X(m
`chZ-;-Ia0^DYWj\MN;!c&<(B:5Hn^b[o)Y9NU6XSQO/(r_W@.K2\fHJI*>>[]ATdLSVQf5OR
<t"2gE_;hbo,mTWd[#"`]ARA(t1mr,p\3HPF\GeNV8'h/"V:q9Ijsc>%fO^6.YWk%f\dY_e2u
!apgr1SWu9T!3JF,TaIE=L(ojV3?^s7H!g)^O*Dd'MtrMR]Aaot?&mc!4Jj;9k#@o<+\"qXo+
7[J`jT+2Sq_)ic$oXFhTY!\2C.ugPToN)Gq)fnP#u;)k2UH5_-UY2MoG"t_SN2^kI9bKJqrD
tK&C]A,B&\k%=7.J`A&lC5>)Ns)Ep2)Bn4fu!sjks/i%@H@7]AN(s%8qI;%cTc,PJM,%o:4hL3
CTn[h".n'dB5/H/BS[uV=B!DT?/PD`jqA\PPY+`eK/-8uV,\0SEaE)Bd^D+AAdaS(P)2]A;5'
7i_+S\TBjaV72_E0jDdoMV"ZW[U0Z*>]A[E-@miJN$\r@%uEgs#Q.<IjjO+%^FD_Z17+WL&S=
G_Z,UN7jIsg1FSKn?&ZY?lFFG.>435r)]A#0Z`Z1s+nS=mYF_q%I&&5B&0NF\*!E$\q_TEi#c
=6,0fg\7r*qgViHGiJbWahEm!Ymc(Fk&L',IP(aeYEQL^/J('?]AMFF`YkOkPrP7?So(YK/'p
97QT/UC_W+qfCQF4q'%:QhmpNF5d:T/Xo26QurT63i06<qP!KBR:?^plS\Eq9SZQ.njTN1'6
XXYGq,;R`:!<__+lf2%85GH&K!7/Tb"Rm&>b3\Q(p8XL8!/ZpNLs<U5.?gN/CQT-1\h$ZCUP
'hN&SqC!aGZSH<,J?'P*U)gF_6URCO.T,^jJ;9VHT@6Ha`(3bT`\.dRWn4mM.r(Ts1Vmm7Eu
N]AXG>`434OuEpT@4^%6I=2BK)r^h9>8YCB%3:>U&!?,f2=6LWMN(ST1-&2i'L_7YQh]A^_)tU
/PeoAk>-1<9GF;\>3gsiQ8KkOPTfFNgqY'i(G&XML`MugJT+_nLkC,O;G%d5uVqbY*6?=ClV
XL\3)Da=2YIU)oM@`ge'aon)M?$$09Nl,a"'DJTs.lE`%e;J*M[%?g`XI7.L<MOLKSaR^aHe
\sd.k5c@PO!*,BbHD+_:Hu&cVmG5\j[R9=jn'*8M*gm3_LUdrXg@FQD]A"5gc2Y*%PWYIu8@L
Bh%[]Ae6-D#`S\N`7+[2[TE$i`CU2'X';V]AoZ\JApATK<)MZ%eWm_cV/lS0\:klN7e-MISGqi
:HdJ'nn<:sP51rm"mI='Os$P=dB$5bqd@_IoY%0aY<Gbm.iFtYY:@2:TE=\7/FekUNr<Y6WH
I+QmQI93Iq`rf8?&b/D/YDtej3d3]A+-;h/SjSKE[L5We_%#<%qNmkT-1Ccq(GZ]AE8\`n\\Al
N9j+dCreQ[O:\@3]A3mVAIF0c+3(bB<G3o+^N!/YFB)g!(h:W5rK<=6.If5pjR-.d'q=m$)#-
ju$*A?lHCZN`A#h7*SK\lAjm$ip6kpknOs?WIEH:H$p6@iB@(GUV`VtN'dlO73lW.l5W%]AUP
uHlUp&/U-6fZ'G*:!$)\r(ba3Du]A6d6D(85$WSgOAAupP>D]AF:E,Xm$;AC".smcG^BiXr/sF
%dMQ"diaPjmm)P(87$nDQs1H;I\P)92%@dq.(b('f<Rd"Ws3<b*dTh*$7_Uf?1pC=n_(!7hG
>aI8NZ2Q@iU'_-X+&`.&W*oO@s5H_L6LM6npEEb,i9PR?:.H>kLPt>WE\,k3rkZ9gL'9"KS'
FI94kdLV:n=,lg,k'b)%%'s#d)?Rcmh1EO5!*KbJnV!f6dr?;CtoT\t2P3H;G&8_1WaSG#g5
I)(9M[RGq!q'38R\i>HiDR\B3F%*"%D*\':gNiM2B?u!MM$:CjnJfVcm,)mX+iJEip%p;?Xj
>N"P6I'pp;dQ,1"1bm>kTtNVrVRg_iE4o%JEH"R5NKXcF0J1W2E-sk&29CJ(G1^lL03)_c22
F$/bYc@&\>I.P(NLJQ;Ufkp?7_oO8J3oo*S"+$;rZD0Je'OJ<ArB5H]AP7r#BfLjeEF[F5oWC
f9ILMCtgDgin[*/'EAlbA<GTg]A<W"H(8c4^0H=S]A6sA+`TQJgdFIFH07+)1d.KQBZ=`r#']AO
;,]Armii8D+lJB>\,p?eFV=?>V%"R7`.YPB;*BPUlH-s)iO;Id8O<k\h!ok)Q)(%r6M4/DTDR
`&;NE#Oh<d^uNU.b$j]Aa!aB/Qr>3=FiUGr;p5+EFD@AbB`D0/?)jdgGQ$^,Uk=5,uq*-%PPb
duP[\A?+2:RUo2Hu*?W!D[]AlPCUDs7:SQ..+W26H*]A`M.eugp8]A?6G.>f#qk:m(bdhG_[G\(
XnOPS+\Q[&@D`ji!W0#]Ak/;8J;amS*(0'CT5im+B6IeM/YTV>VqFk7,G:7Ds_rsT<FJBn\XR
2?b5dU0-o6lSp5]AB9e&4q3Lo:FZXK]ART/6-^bM6?`.Qk?RG3W?D$sg:=PJWOag>2&^iVAn\E
rU[:\I5Y&tEL*Z=,.,/b3sN\-lo2m^q6/=2(!GGQq.cY&?'n5lnn>Xsf3SIV.XL,heX<Gt^t
YamVKIsKqgS^,n+R(]A_)dVH6)RgX[G[2U!UD@LX5C`^/f2IFOd7bk^[P(bDaI^j;[W;1ZHs1
P`bFFi2han#*iZN0PP&IPWXV,Tet0lJ^mNp6Epg%L$$O;7iXgLP\koBO3ege,"m/#Va`a"Ao
i):Z1?f"%Q$%$"*E`Z6)oS+<e'6ILha:U"`82Ok:p.[^V5(rce5Ch6]A62VB=%pA*h,ZQ3#RR
UEE`)P9E`RrMg6\4\aD/7Eq[@`'hXi+C^OISR;#emOZ7VlS9@^ih5:G"Wn&SeF0'+@rJI%,C
o/Q<klK=`ncDHT''pLaL->.N>ZpZPeF/!e(R;2TCKqp&%JJ=u%c=$`BO&+'s3$``0IASIaS@
gr;LbP%IAuS77;4A'`d5KU;L(bC_%Fo`\]Adq0#J!^6CBj:Ua[`-L<^Ye3[4E6qBK`A*&+4UZ
sC*R=duarlBgpkgC=&$\#XRYSTr2iOJ"nZ2?,7b&5]Au`e&^I_PoB9fMq7,N)foTfQ@1IJZA*
U:=L_q/T4$$884R5^lg1g<g8XQ7M84-0.O<2UXFrj4$,;SbZK[`[2iuEF?,W;_Tk6XhTV.XU
Bo\KA;dkETR#S</Rrr(&(E)^7QHd#DL92Q(]A8GQ1fl&!VW2B9f#\;C6Y[Q/8G7H6YQ?!j?i.
&VnF;#I!P=`@W?c=6GI)[_CI@SF74@_P'9#@@)p'SZ/4d1WnVK'qZ<F1Q`.M[LOmW!lQB)8I
$<lRPOq"e8Dq^f<?a#ZTi!-0N.?OaqA,iB8XD8:7(uArDJuh]AhRgX\]A)8a[9JPhUePbc`T-e
I&EE*lr_Y\rXf%,poiLqQK2=TUPS+8H\*$dLY/@Rfgq>3l:k6qj#b/@J3KAlK31\Gc'o"(:U
TZIZ0hXW[;=T9r?&_9O4tocTaK>#U5^7/<1IP[aSLGF)>LQL=!mfj+%4j_\4mW2tPAU?hFGR
r"+tT@Z@/]A1'8:j?uFkl2'dbq$;*$d<?YoO]AlS`&-CY6IH4V:/G?AhPSWh-\YkM/8,5')3]A;
am\Xc/*_1X;Q7)mR*4(cKWhUl_+]Ao;ihXi>j+GKh("dB!?^@9-s3dXqtIMLWV7!!&ECm\eHr
g0M=\W#J/`O>I-)ER>jbfp%_b"Vc,tVcc@WloOMt+BJgcZRIslEc!$)0.E=2fr92oNM-2R&e
p-n-W+oV$OJI)AcZGdDURlIXN8SDl_qDXC,X<K'OIT/s#GC?F%$o6l2N'd5,!U]A3_g9(iQJO
+oW5_.r-H9ADie*518<r?Y2=<sfB5-,eRZEKU\T5G)'!5BmES\n;TU6Whi//n2?PkY<1q8+3
VoqBg?NV>N=iN6-p%fR28P8S"DO0=B@/,5/MW2V>_s!&;,7Z+g;8;DnB.@of7(Q7;E7UJ,cf
<jWfb3uAR^]AI>["Dfem0[NkVa7THJ@LgNA3+I$_\07.R)6t*%0\&L'P"slUCN6Ak+(:Bfca7
k9;?K8VPi.QOi<EC8&75@Maf@</#63YRfA=&?u+D5\F0hpB]A2=BXlq2oG`DE7o17XUp<YKeT
CJ\[X6?L/:*=+NATZ8Ca[IaAXcDC'#pi3G$%BsNGX#>-$d*27;K?<e%\QApp]A5A05J)m*>o]A
E\[SKhmVtC?4d.jRD5THQ%'@mXEh[GfZdTd5`K7LQ,PEIC<XT9Mqu?6oj)8j;rm0K)JFu<V1
KUrT-GeH;.!Q`Yfi$=/3Ke0mX#.tnlo]A%KR1t]AjensTo%2E`)b?Vg]AIt+sW60]A,Q4['qB0Pf
ABD(79$C@Lq41oQP8rU$#q^L8J"7)k9M:IQS'I)cJBg:"HQF!fF9oiKJegY)rk0(ZM[+S8Ip
i9ULoasFk&W$c*)R>U.Ue<b=b[f^B2SVH[%RtYMQD'K#77/eQ/jQCJ;8RJaR2S2dg5%iOdao
gcGTu[R?fu;]A5R-`8m4Bd[GEFYVI>XTf]A(6Xd'hd]AK:WpN$1\KhJOrd*bu^C:el*$g9=%G^.
2#3YfpXWgr\mCrtL,E^G^\+`K,/@$V2F"F'e"G`U"JLi&7?=LO`SBDjSl:YtUpm5%NZ@5Fbs
,3ZR/D?W.mb>oB7e-rFT,k/LJ$"2"_b^7r~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="10" y="11" width="232" height="132"/>
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
<WidgetID widgetID="15b9f825-4d39-4502-a3f6-ea2440a14408"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=$bm+"工时投入趋势"]]></Attributes>
</O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="2"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.custom.VanChartCustomPlot">
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
<ConditionAttr name=""/>
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
<Attr position="1" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<OColor colvalue="-15378022"/>
<OColor colvalue="-12080918"/>
<OColor colvalue="-9724467"/>
<OColor colvalue="-1197808"/>
<OColor colvalue="-1222640"/>
<OColor colvalue="-7236949"/>
<OColor colvalue="-8873759"/>
<OColor colvalue="-1071514"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-6715442"/>
<OColor colvalue="-1"/>
<OColor colvalue="-6715442"/>
<OColor colvalue="-1188474"/>
<OColor colvalue="-12080918"/>
<OColor colvalue="-12080918"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<VanChartCustomPlotAttr customStyle="column_line"/>
<CustomPlotList>
<VanChartPlot class="com.fr.plugin.chart.column.VanChartColumnPlot">
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="5"/>
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${CATEGORY}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${CATEGORY}${SERIES}${VALUE}"/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="0" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="20.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="false"/>
</VanChartPlot>
<VanChartPlot class="com.fr.plugin.chart.line.VanChartLinePlot">
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${CATEGORY}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${CATEGORY}${SERIES}${VALUE}"/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
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
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="solid" lineWidth="2.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="AutoMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="1" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
</VanChartPlot>
</CustomPlotList>
</Plot>
<ChartDefinition>
<CustomDefinition>
<DefinitionMapList>
<DefinitionMap key="column">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[月度趋势比对]]></Name>
</TableData>
<CategoryName value="concat(a.month_code,&apos;月&apos;)"/>
<ChartSummaryColumn name="去年人均投入工时" function="com.fr.data.util.function.NoneFunction" customName="去年投入"/>
<ChartSummaryColumn name="今年人均投入工时" function="com.fr.data.util.function.NoneFunction" customName="今年投入"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[月度趋势比对]]></Name>
</TableData>
<CategoryName value="concat(a.month_code,&apos;月&apos;)"/>
<ChartSummaryColumn name="去年投入工时满足率" function="com.fr.data.util.function.NoneFunction" customName="去年满足率"/>
<ChartSummaryColumn name="今年投入工时满足率" function="com.fr.data.util.function.NoneFunction" customName="今年满足率"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="458f8ff3-b8ab-4ca7-8148-017b6ca5e2a5"/>
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
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<WidgetName name="chart0"/>
<WidgetID widgetID="15b9f825-4d39-4502-a3f6-ea2440a14408"/>
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
<Background name="ColorBackground" color="-1"/>
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
<![CDATA[工时投入趋势]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="1" size="112" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="2"/>
</Title>
<Attr4VanChart useHtml="false" floating="false" x="0.0" y="0.0" limitSize="false" maxHeight="15.0"/>
</Title4VanChart>
<Plot class="com.fr.plugin.chart.custom.VanChartCustomPlot">
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
<ConditionAttr name=""/>
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
<Attr position="1" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="2"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
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
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="80" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="80" foreground="-10066330"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<VanChartCustomPlotAttr customStyle="column_line"/>
<CustomPlotList>
<VanChartPlot class="com.fr.plugin.chart.column.VanChartColumnPlot">
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
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
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
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${CATEGORY}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${CATEGORY}${SERIES}${VALUE}"/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<VanChartPlotAttr isAxisRotation="false" categoryNum="2"/>
<GradientStyle>
<Attr gradientType="gradual" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
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
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="80" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="80" foreground="-10066330"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="0" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="20.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="false"/>
</VanChartPlot>
<VanChartPlot class="com.fr.plugin.chart.line.VanChartLinePlot">
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
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="solid" lineWidth="2.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="AutoMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
<AttrTooltip>
<Attr enable="true" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${CATEGORY}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${CATEGORY}${SERIES}${VALUE}"/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.##]]></Format>
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
<VanChartPlotAttr isAxisRotation="false" categoryNum="2"/>
<GradientStyle>
<Attr gradientType="gradual" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="custom" isDefaultIntervalBackground="true"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
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
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="80" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="4"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="80" foreground="-10066330"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="堆积和坐标轴1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="1" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition"/>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</stackAndAxisCondition>
</VanChartPlot>
</CustomPlotList>
</Plot>
<ChartDefinition>
<CustomDefinition>
<DefinitionMapList>
<DefinitionMap key="column">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[月度趋势比对]]></Name>
</TableData>
<CategoryName value="year_code"/>
<TableMoreCate>
<oneMoreCate cateName="concat(right(t1.time_code,2),&apos;月&apos;)"/>
</TableMoreCate>
<ChartSummaryColumn name="去年人均投入工时" function="com.fr.data.util.function.NoneFunction" customName="去年投入"/>
<ChartSummaryColumn name="今年人均投入工时" function="com.fr.data.util.function.NoneFunction" customName="今年投入"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[月度趋势比对]]></Name>
</TableData>
<CategoryName value="year_code"/>
<TableMoreCate>
<oneMoreCate cateName="concat(right(t1.time_code,2),&apos;月&apos;)"/>
</TableMoreCate>
<ChartSummaryColumn name="去年投入工时满足率" function="com.fr.data.util.function.NoneFunction" customName="去年满足率"/>
<ChartSummaryColumn name="今年投入工时满足率" function="com.fr.data.util.function.NoneFunction" customName="今年满足率"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="ae446641-98bf-4c9b-81f0-e651ce09cf82"/>
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
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false"/>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<BoundsAttr x="248" y="11" width="586" height="276"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report3"/>
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
<WidgetName name="report3"/>
<WidgetID widgetID="e3f0b9d1-0616-4907-9d01-e2db1c2dc078"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
</InnerWidget>
<BoundsAttr x="0" y="0" width="250" height="150"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report3"/>
<WidgetID widgetID="e3f0b9d1-0616-4907-9d01-e2db1c2dc078"/>
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
<Background name="ColorBackground" color="-15386770"/>
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
<BoundsAttr x="842" y="11" width="304" height="622"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0"/>
<Widget widgetName="chart0_c"/>
<Widget widgetName="report3"/>
<Widget widgetName="chart0"/>
<Widget widgetName="report6"/>
<Widget widgetName="bm"/>
<Widget widgetName="report0_c"/>
<Widget widgetName="chart0_c_c"/>
<Widget widgetName="report0_c_c"/>
<Widget widgetName="chart7_c_c"/>
<Widget widgetName="rq"/>
<Widget widgetName="chart0_c_c_c"/>
<Widget widgetName="report2"/>
<Widget widgetName="report4"/>
<Widget widgetName="report1"/>
<Widget widgetName="report5"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="540"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="absolute0"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="540"/>
<ResolutionScalingAttr percent="1.2"/>
<BodyLayoutType type="0"/>
</Center>
</Layout>
<DesignerVersion DesignerVersion="KAA"/>
<PreviewType PreviewType="5"/>
<WatermarkAttr class="com.fr.base.iofile.attr.WatermarkAttr">
<WatermarkAttr fontSize="20" color="-6710887" horizontalGap="200" verticalGap="100" valid="false">
<Text>
<![CDATA[]]></Text>
</WatermarkAttr>
</WatermarkAttr>
<StrategyConfigsAttr class="com.fr.esd.core.strategy.persistence.StrategyConfigsAttr" pluginID="com.fr.plugin.esd" plugin-version="1.5.4">
<StrategyConfigs/>
</StrategyConfigsAttr>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="6c527cab-9a05-4e2c-8b0f-72969a83f2a1"/>
</TemplateIdAttMark>
</Form>
