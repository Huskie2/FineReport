<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="截至日期" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT MAX(max_busi_date) 日期
FROM diap.ads_sh_ops_goods_space_air_season_df]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="Embedded1" class="com.fr.data.impl.EmbeddedTableData">
<Parameters/>
<DSName>
<![CDATA[]]></DSName>
<ColumnNames>
<![CDATA[航段,,.,,主舱利用率,,.,,载运率,,.,,航班量,,.,,机型]]></ColumnNames>
<ColumnTypes>
<![CDATA[java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String]]></ColumnTypes>
<RowData ColumnTypes="java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String">
<![CDATA[Ha\@_dlEn?TCts.Z>0oIJLVLV3ggqVF$5.J/Qqmcb>PE>:NghCgU\E;Y$RV&5+B1Xl1TC)V-
\9<j-"`"Y4:3-7G&'>^>S+;Kik0X[eDuAeV7@2a+Tf(HVpR=~
]]></RowData>
</TableData>
<TableData name="Embedded2" class="com.fr.data.impl.EmbeddedTableData">
<Parameters/>
<DSName>
<![CDATA[]]></DSName>
<ColumnNames>
<![CDATA[起始地,,.,,起始地经度,,.,,起始地纬度,,.,,目的地,,.,,目的地经度,,.,,目的地纬度,,.,,主舱利用率,,.,,载运率]]></ColumnNames>
<ColumnTypes>
<![CDATA[java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Double,java.lang.Double]]></ColumnTypes>
<RowData ColumnTypes="java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Double,java.lang.Double">
<![CDATA[Kp,;M;aCi3fB*dK=BaaiB07EA`;s-cTbNcj&u^ddW4E#7T[5$c;@68So4CC.JK:TANq?Aurq
ZHhBA/-!l/;jY'eCMo9#)$+(?G[I2;9_65`npR<+QWX6H!+PTL*nNStXp'+dPu]A;\J#GPpd2
*blbW9bq3`d`=SkX"jWK.e<1ft"8q'.a7f*--krbG3FlM`()>,Tf)\(k^[H@cCRn9QaJM]ALf
a>99M'MVuZeaB<W=&p<,,QD8BoXg)hSJgYos]ABck/f/Y!n/3o7:L8LN:8LPD0'FR"&c"$g$r
028?Qj0"+51EQKu51aI+GCN0pCdo%pF+nAW#RQs9"k2&Mf:,a03E]ABu#7mGk;(I+hq4blXWJ
1*3aMn'g+X\1bU$"Xo8M"tY^:aB'C;X$2pm5+CGe+psWF$"M6Ig'%<K0-D2d]A@h"5Q1lC$oY
4IUj_r2:@/ES/CZ)*u4$T25*.]AH<7:3`Rm4UitiD!J1)X>@%D>r`J0bpiE4[mIfi2MGO3%-#
X7sm)toR:M7I-)R&M>I8P~
]]></RowData>
</TableData>
<TableData name="Embedded3" class="com.fr.data.impl.EmbeddedTableData">
<Parameters/>
<DSName>
<![CDATA[]]></DSName>
<ColumnNames>
<![CDATA[航段,,.,,总固定闲置可用舱位,,.,,固定闲置可用舱位,,.,,航班量,,.,,机型]]></ColumnNames>
<ColumnTypes>
<![CDATA[java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String]]></ColumnTypes>
<RowData ColumnTypes="java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String">
<![CDATA[Ha\+NZ]A1Ne0:0q2[UVIuZ'bWjT`L87F>>d5kB_k4B`sPT!__f<R@Ad61N[2o#+Uu%F]A_<[:W
gP)dfP;h\H/Tg%On&Hb]A$+@)K;/)O>8QK1kA4!!!~
]]></RowData>
</TableData>
<TableData name="航季" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT distinct air_season_full 航季
FROM diap.ads_sh_ops_goods_space_air_season_df
where air_season_full != '夏秋 2020-03-29 to 2020-10-24']]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="默认航季" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT DISTINCT air_season_full 航季
FROM diap.ads_sh_ops_goods_space_air_season_df
WHERE max_busi_date = (
        SELECT MAX(max_busi_date)
        FROM diap.ads_sh_ops_goods_space_air_season_df)]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="指标卡" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="air_season"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=]]></Attributes>
</O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT 
      load_ratio 载运率,
      ac_main_space_usage_ratio 主舱利用率, 
      main_usage_ratio_last20prct as "主舱利用率末位20%" 
FROM diap.ads_sh_ops_goods_space_air_season_df
WHERE air_season_full = '${air_season}' 
  and statistical_dimension_info = "company&air_season"]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="往返低主舱利用率航段" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="area1"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="air_season"/>
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
      a.*
from (
SELECT 
      flight_sect_cname 航段, 
      case 
          when depart_area_type ='国际' or arr_area_type ='国际' then '国际'
          when depart_area_type ='地区' or arr_area_type ='地区' then '地区'
          when depart_area_type ='国内' and arr_area_type ='国内' then '国内' 
      end 划分,
      if(load_ratio=0,0,ac_main_space_usage_ratio) 主舱利用率,
      load_ratio 载运率,
      number_of_flights 航班量,
      ac_type 机型
FROM diap.ads_sh_ops_goods_space_air_season_df
WHERE air_season_full = '${air_season}' 
  and statistical_dimension_info = "flight_leg&air_season"
  and main_usage_ratio_below_last20prct_rt = 'Y'
) a
where a.划分 = '${area1}'
order by 3
limit 10]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="航段固定闲置可用舱位" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="area2"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="air_season"/>
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
<![CDATA[select a.*
from (
SELECT 
      flight_sect_cname 航段, 
      case 
          when depart_area_type ='国际' or arr_area_type ='国际' then '国际'
          when depart_area_type ='地区' or arr_area_type ='地区' then '地区'
          when depart_area_type ='国内' and arr_area_type ='国内' then '国内' 
      end 划分,
      main_usage_ratio_below_last20prct_rt 往返主舱利用率是否低于阈值,
      cast(ttl_reg_ava_space as signed) 总固定闲置可用舱位,
      reg_ava_space 固定闲置可用舱位,
      number_of_flights 航班量,
      ac_type 机型
FROM diap.ads_sh_ops_goods_space_air_season_df
WHERE air_season_full = '${air_season}' 
  and statistical_dimension_info = "flight_leg&air_season"
  and reg_ava_space > 0
) a
where a.划分 = '${area2}'
order by case 划分 when "国内" then 1 when "国际" then 2 when "地区" then 3 end,4 desc
limit 10]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="地图" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="qy"/>
<O>
<![CDATA[华东]]></O>
</Parameter>
<Parameter>
<Attributes name="air_season"/>
<O>
<![CDATA[夏秋 2021-03-28 to 2021-10-29]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select * from (
SELECT 
      case when departure_airport_cname = '巴彦淖尔' then '华北' else departure_airport_area end 始发区域,
      flight_sect_cname 航段, 
      departure_airport_cname 起始地,
      if(length(departure_airport_long)=10,concat(substring(departure_airport_long,2,3),".",right(departure_airport_long,6)),
         concat(substring(departure_airport_long,2,3),".",right(departure_airport_long,6))) 起始地经度,
      if(length(departure_airport_lat)=10,concat(substring(departure_airport_lat,2,3),".",right(departure_airport_lat,6)),
         concat(substring(departure_airport_lat,2,2),".",right(departure_airport_lat,6))) 起始地纬度,
      arrival_airport_cname 目的地,
      if(length(arrival_airport_long)=10,concat(substring(arrival_airport_long,2,3),".",right(arrival_airport_long,6)),
         concat(substring(arrival_airport_long,2,3),".",right(arrival_airport_long,6))) 目的地经度,
      if(length(arrival_airport_lat)=10,concat(substring(arrival_airport_lat,2,3),".",right(arrival_airport_lat,6)),
         concat(substring(arrival_airport_lat,2,2),".",right(arrival_airport_lat,6))) 目的地纬度,
      ac_main_space_usage_ratio 主舱利用率,
      load_ratio 载运率,
      b.main_usage_ratio_last20prct 阈值
FROM diap.ads_sh_ops_goods_space_air_season_df a
cross join (
SELECT 
      main_usage_ratio_last20prct
FROM diap.ads_sh_ops_goods_space_air_season_df
WHERE air_season_full = '${air_season}'
  and statistical_dimension_info = "company&air_season"
) b 
WHERE air_season_full = '${air_season}'
  and statistical_dimension_info = "flight_leg&air_season"
  and depart_area_type ='国内' 
  and arr_area_type ='国内'
  #and a.ac_main_space_usage_ratio < b.main_usage_ratio_last20prct
) t
where 1=1
${if(or(len(qy)=0,qy='全国'),"","and 始发区域 = '"+qy+"'")}
order by 1,3]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="地图最大值" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="air_season"/>
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
<![CDATA[SELECT 
      main_usage_ratio_last20prct "主舱利用率后20%阈值"
FROM diap.ads_sh_ops_goods_space_air_season_df
WHERE air_season_full = '${air_season}'
  and statistical_dimension_info = "company&air_season"]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="地图-点" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="qy"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="air_season"/>
<O>
<![CDATA[夏秋 2021-03-28 to 2021-10-29]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
distinct 始发区域,航站,经度,纬度,阈值,颜色
from (
SELECT 
      case when departure_airport_cname = '巴彦淖尔' then '华北' else departure_airport_area end 始发区域,
      departure_airport_cname 航站,
      if(length(departure_airport_long)=10,concat(substring(departure_airport_long,2,3),".",right(departure_airport_long,6)),
         concat(substring(departure_airport_long,2,3),".",right(departure_airport_long,6))) 经度,
      if(length(departure_airport_lat)=10,concat(substring(departure_airport_lat,2,3),".",right(departure_airport_lat,6)),
         concat(substring(departure_airport_lat,2,2),".",right(departure_airport_lat,6))) 纬度,
      b.main_usage_ratio_last20prct 阈值,
      1 颜色
FROM diap.ads_sh_ops_goods_space_air_season_df a
cross join (
SELECT 
      main_usage_ratio_last20prct
FROM diap.ads_sh_ops_goods_space_air_season_df
WHERE air_season_full = '${air_season}' 
  and statistical_dimension_info = "company&air_season"
) b 
WHERE air_season_full = '${air_season}' 
  and statistical_dimension_info = "flight_leg&air_season"
  and depart_area_type ='国内' 
  and arr_area_type ='国内'
  #and a.ac_main_space_usage_ratio < b.main_usage_ratio_last20prct
union all
SELECT 
      case when departure_airport_cname = '巴彦淖尔' then '华北' else departure_airport_area end 始发区域,
      arrival_airport_cname 航站,
      if(length(arrival_airport_long)=10,concat(substring(arrival_airport_long,2,3),".",right(arrival_airport_long,6)),
         concat(substring(arrival_airport_long,2,3),".",right(arrival_airport_long,6))) 经度,
      if(length(arrival_airport_lat)=10,concat(substring(arrival_airport_lat,2,3),".",right(arrival_airport_lat,6)),
         concat(substring(arrival_airport_lat,2,2),".",right(arrival_airport_lat,6))) 纬度,
      b.main_usage_ratio_last20prct 阈值,
      1 颜色
FROM diap.ads_sh_ops_goods_space_air_season_df a
cross join (
SELECT 
      main_usage_ratio_last20prct
FROM diap.ads_sh_ops_goods_space_air_season_df
WHERE air_season_full = '${air_season}' 
  and statistical_dimension_info = "company&air_season"
) b 
WHERE air_season_full = '${air_season}' 
  and statistical_dimension_info = "flight_leg&air_season"
  and depart_area_type ='国内' 
  and arr_area_type ='国内'
  #and a.ac_main_space_usage_ratio < b.main_usage_ratio_last20prct
) t
where 1 =1 
  ${if(or(len(qy)=0,qy='全国'),"","and 始发区域 = '"+qy+"'")}
union all
select null,"西",73.33,39.15,null,null from dual
union all
select null,"东",135.05,48.27,null,null from dual]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="始发区域" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="air_season"/>
<O>
<![CDATA[夏秋 2021-03-28 to 2021-10-29]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select distinct 始发区域 from (
SELECT 
      case when departure_airport_cname = '巴彦淖尔' then '华北' else departure_airport_area end 始发区域,
      flight_sect_cname 航段, 
      departure_airport_cname 起始地,
      if(length(departure_airport_long)=10,concat(substring(departure_airport_long,2,3),".",right(departure_airport_long,6)),
         concat(substring(departure_airport_long,2,3),".",right(departure_airport_long,6))) 起始地经度,
      if(length(departure_airport_lat)=10,concat(substring(departure_airport_lat,2,3),".",right(departure_airport_lat,6)),
         concat(substring(departure_airport_lat,2,2),".",right(departure_airport_lat,6))) 起始地纬度,
      arrival_airport_cname 目的地,
      if(length(arrival_airport_long)=10,concat(substring(arrival_airport_long,2,3),".",right(arrival_airport_long,6)),
         concat(substring(arrival_airport_long,2,3),".",right(arrival_airport_long,6))) 目的地经度,
      if(length(arrival_airport_lat)=10,concat(substring(arrival_airport_lat,2,3),".",right(arrival_airport_lat,6)),
         concat(substring(arrival_airport_lat,2,2),".",right(arrival_airport_lat,6))) 目的地纬度,
      ac_main_space_usage_ratio 主舱利用率,
      load_ratio 载运率,
      b.main_usage_ratio_last20prct 阈值
FROM diap.ads_sh_ops_goods_space_air_season_df a
cross join (
SELECT 
      main_usage_ratio_last20prct
FROM diap.ads_sh_ops_goods_space_air_season_df
WHERE air_season_full = '${air_season}'
  and statistical_dimension_info = "company&air_season"
) b 
WHERE air_season_full = '${air_season}'
  and statistical_dimension_info = "flight_leg&air_season"
  and depart_area_type ='国内' 
  and arr_area_type ='国内'
  #and a.ac_main_space_usage_ratio < b.main_usage_ratio_last20prct
) t
union all 
select "全国" 始发区域 from dual
order by case 始发区域
                      when '全国' then 1
			        when '中南' then 2 
			         when '华北' then 3 
			          when '华东' then 4 
			           when '西南' then 5
			            when '东北' then 6
			             when '西北' then 7
			              else 8 end]]></Query>
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
<appFormBodyPadding class="com.fr.base.iofile.attr.FormBodyPaddingAttrMark">
<appFormBodyPadding interval="4">
<Margin top="4" left="4" bottom="4" right="4"/>
</appFormBodyPadding>
</appFormBodyPadding>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="地图"/>
<WidgetID widgetID="e618b81c-20e7-4353-94fb-c4e718ff556b"/>
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
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="label0"/>
<WidgetID widgetID="ac74d21c-6ef2-4756-a53c-72472476dbae"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="label0" frozen="false"/>
<PrivilegeControl/>
<MobileStyle class="com.fr.form.ui.mobile.DefaultMobileStyle" isCustom="true" borderType="0" borderRadius="2.0" iconColor="-14701083">
<Background name="ColorBackground"/>
<FRFont name="SimSun" style="0" size="96"/>
</MobileStyle>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[起飞区域]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="4" autoline="true"/>
<FRFont name="微软雅黑" style="0" size="72"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="225" y="36" width="90" height="30"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report1_c_c_c_c_c"/>
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
<WidgetName name="report1_c_c_c_c_c"/>
<WidgetID widgetID="a74dc66f-60d3-489a-91d5-6a28f00d98d2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[往返低主舱利用率航段]]></O>
<FRFont name="微软雅黑" style="0" size="80"/>
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
<![CDATA[434880,576000,434880,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3600000,3456000,0,2743200,2743200,2743200,864000,0,439200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="2" rs="3" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="  主舱利用率流向图"]]></Attributes>
</O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="0" s="1">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="移动端弹窗1">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[若某航段及其反向航段在本航季的主舱利用率均低于主舱利用率末位20%阈值，则为往返低主舱利用率航段]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="6.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="3" r="0" rs="3" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" cs="2" rs="3" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" rs="3" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="3">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="600" height="400"/>
<ReportletName showPI="true">
<![CDATA[/数字化平台/HZW/1_Dev/闲置舱位分析/往返低主舱利用率航段明细.frm]]></ReportletName>
<Attr>
<DialogAttr class="com.fr.js.ReportletHyperlinkDialogAttr">
<O>
<![CDATA[往返低主舱利用率航段明细]]></O>
<Location center="true"/>
</DialogAttr>
</Attr>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="8" r="0" rs="3" s="2">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="1" s="3">
<O t="Image">
<IM>
<![CDATA[!DN[%r/"6F7h#eD$31&+%7s)Y;?-[s3<0$Z3=#fh!!%rpK7s:*!u+<p5u`*!m96]A;e3FQt!e
J32^gSo6`0jpiBhZof/.,70l[OFP@JCKIQ$=8YM87VLagDX#-L<\#PA^(P[m-&JdU^,e^A$?
nm-K,/fpUMbNfF_b&qIQrmt"JA5.VBdKhd$8h]ALRu?C7S1.aO_g=aj*[i`h\)J)DXe[>k+_p
0'=Kg,QI"*RLfsiX=Bb-Br<W[L]AL$0M@Q$C3:WR#k<b]Af@g'`.0%#Cf7!karuXLRVL@>R>0X
tVN\9h$.%\fbOgL!LMk=!M]AEN;W\)"?;bi:Tsn\]A*Gbo:+N$F:KS_^$qZ0.m(a2`j";m0"AE
&%4&oi0+$V6JKb\QIVa1"%NdqP`jNY[T0GjNunccd3:uI&[W,t.i-LP7X]AUZ:c^.Lr[H$g5%
AjZRooI:9,qHm,.Y_K#r9#E4DrQ]A-R[4g5>j\PQZelHYD_D*;llG>$qBSrPXo!nK8A\/-\'s
=TIho[P5[Pim?^L&QKflTZl5+:7EY]AWBLu8HUqN+O?_DFIHO<o6pUh<Go6^_A4LfI7CS+NsW
VgIe%?9p<nsCrk\Vb%%+",BAK3d*8?t2XOh#=;<W4fslPK4ah7cO.oUF7%]A>6uYdkOl,m"[b
_a5A#K)-*Cr`BH\H@hJ7'Q0TYV2L4/B'6U.HaB<QL$,"-Ho@>+B5hMO-4!e[LLcm/<e0Z98k
_lF-N<B3%`pJRj'ib[EN._#T'6j@cQ6E?_(Z6rH[&DOWXK+K,91PtJ6=Fl6DY-SR7$T*8nE)
D1!X;$8]APZa*'Ul$cu.Sif3A2?3NXQoq60t\mqSp:FXg&cScFc=rSrO-[l;oifa(m0r9jt=%
<4kjTmZ*jiu1]At#M%iZo=)M)PY3HMrB'Bnu=0NjNd>EWjDDY?'aEmPC(Z8"gAOtf@G=ZP.lQ
$jUp2"%Mgd)jriMk'DAT:qi=01$p<qhMC:>`[@CXiQ==l1>)7O`q"A+VO#9MG(jd^>`V>/72
F5Ym?IQB);Yg50WRt:_S`uR?3LAN;m2%Uomj2gqs*l!!#SZ:.26O@"J~
]]></IM>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="移动端弹窗1">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[若某航段及其反向航段在本航季的主舱利用率均低于主舱利用率末位20%阈值，则为往返低主舱利用率航段]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="6.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<CellGUIAttr showAsDefault="true"/>
<CellPageAttr/>
<Expand/>
</C>
<C c="7" r="1" s="3">
<O t="Image">
<IM>
<![CDATA[!=]A,$rJ=?G7h#eD$31&+%7s)Y;?-[s*rl9@)[HWJ!!%[:<%e4O!Rs\/5u`*!^"+o/"#1Joi$
'Wc"VDOu7@h@c5sYVo'uAS>8K94ed(H/u]Apl*eKAbZ1\EKTlP='>/:_[/VE"JQ+,jJ2l*K!J
TTApsA6>M?]A!ft]AD\M&7&hPIKEV3/l13jV.(\4#(S.51AWaKSo%f:#]ASg6H\!fEL7B;:0pul
kp&77&.8s^jL`Y&$ai-KGZKHqS(j>)]AiID:\Cr\\2FDD"7SdDE5b[h`@)cYJEWX4r(Tf:@2o
db9ZkgR3#9#6*"Iaj:A6^&\I^!J_!'MR4T##e]A9`"M'%g,t4KN_%p<FhM_d':_4Xl_W_arlO
i"+]A#RHJkO_1I?-`O-=cImm)=)hhQ@<jBP\hXOGeO_FWu0VTk@=2qma(9Zq>^mfIr7jK+q))
d(e9C4P5K30pMj+$#uZ3r,*#;FQ'X43jY(ocgg$?$f2n^H_o/$OI_!%dX2IIN)JXMDV`_Oe_
ojel"i<a]Ag1YZHl_CiLsZYY<E=HlrE,M&b'%`jh;Vpa`-a7i@?QoJ0\"Bt"006IH%VBeJ[;Z
NB/H*7QRY4^<g0goVS^-]AmV+:A'TqR95"B>foRnEF-CDXhf;`ScZR*%h,Km`\69tJm`InALI
NY!!#SZ:.26O@"J~
]]></IM>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="600" height="400"/>
<ReportletName showPI="true">
<![CDATA[/数字化平台/HZW/1_Dev/闲置舱位分析/往返低主舱利用率航段明细.frm]]></ReportletName>
<Attr>
<DialogAttr class="com.fr.js.ReportletHyperlinkDialogAttr">
<O>
<![CDATA[往返低主舱利用率航段明细]]></O>
<Location center="true"/>
</DialogAttr>
</Attr>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="2" r="2" s="1">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="移动端弹窗1">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[若某航段及其反向航段在本航季的主舱利用率均低于主舱利用率末位20%阈值，则为往返低主舱利用率航段]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="6.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="7" r="2" s="1">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="600" height="400"/>
<ReportletName showPI="true">
<![CDATA[/数字化平台/HZW/1_Dev/闲置舱位分析/往返低主舱利用率航段明细.frm]]></ReportletName>
<Attr>
<DialogAttr class="com.fr.js.ReportletHyperlinkDialogAttr">
<O>
<![CDATA[往返低主舱利用率航段明细]]></O>
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
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9>!DP3:]ArS;u:.o$itgYKq6iZ^$Cu1T/*)/)&-*]Afl'u5e1INV,Jii7@%iW7?UY$RQB*Cd]A
HOi.l.n`=$]AQ?P`#9/MsQa##siilkGFT"F<e8KXn+YNJ,&hmQhPo6fC/V6rk?/9Fg:P1$SeD
HHB3/fE>e`6]AFPdi\@<_f>_[Nb(_2#Cjmr+E(RK!@++>nZBmSaO[TQ0*dK9a+FM7A(n]A>?aQ
S?8%l@7r>qCO:jEKcW+UO:hO8UpR0lK2Yrf%uk1GT>EcQ3)ORdp;ZMXf>Fk[c6F[mJRMt3Bo
mH27AlbjC6VMa*YEq9X7H#PV.##F-X:qOVJ!iKrPTnl/[4k%'pd$/@#-I<IIi?BsCga1]Ap=4
)Wf:_*HugJCe\CH3285-A5il[<PiZ*H0Pnfop$/;hlUF+4J&G$hJ;rbFot"Z/OsDImJ$)TJ$
O'2J334,7Jc0HON0+d]Ar:(b&9ABXKMca*<HA*:q%E5LJZ+';0`[k_.L1tU7ou\a6tU9b&F"R
lg4K_D!]AO:V#'!]A]A`E\Wfm!eQGkj1PLWTaLsJ6uA`<8(b[LtOoA[nO$Ig[AL$b70_6&[RmVV
DQufZ+@eI,""q<>3#ebAe?s2'sX,t7!#`X'hAPjhn#]AU2&C=[!pc(0,.F4pa]A;[;UKsG6Ca-
?d[c$gmX17F,@MeP0aa"9c)M*q<H'jg(-qrom-r2<uX5;W<l`W+oBd3c7M?c@)#gD3`.C>Qh
a9tj.@X?-Yrid>md?cijS=ZId7:&1>Vbse^79cKu(B?18fB+j=C6G[!N*obJOV0;mqd]A58!:
06Zo!9&Yl+?P)N?C`^j47dc7KL:d!5K*29p^k_1OMiLMfc)^)@bO_P#m=JC:`KWJ]AZf\o%'3
'Re-qQK)"Yp8XQFZ*Ld5P.b+3KTY^5JCu.$Wa+FW3j3CRuh%:WP9DBtPr4k)X%@GItWSaEsl
O";?cJI@-Qf3GFJ'F:k=k>;*(3H'i<W=;R-[/,Y!m;J^,8nPK-diNP;?LJ0+Qo:Qb`#ZG/;f
f8JGiP\h-^&Rg^hrt?+XASW(P/5?Qm"eY=M)C,TpM./MCL*X9P<2Lil5bULhG6_7ZQQj=f7B
?0P_A^a's6n9[a&.[DdkK[%h3.YZ&S^Z2a!!`c'"G$VQ9aeMG'c0]AjYK$i@V1(TFWMYqq'"^
dJQ.f%&c)+2,QCpuO>/RoM.f*u2'(:-Hm]A7GC@<gM>Re$qr8ma@J(q)<94m^u_Ura#>\jtdD
:Xoc)q`@rKK1[4$XH.VJ9dE=@9#Xh@Smt58*1Jm5h'/<D8:$"-[O'cVB,ptg7pY%@XR\l'()
=d3$N!t)6a)Q,t[8C=L_\#akpICi[`2u9nI)Mi$Ic5WAfUu`(f%U=ZW6?6P%8QYuAWb6mA!8
X<`+q.[5?"c1`H4_^nua"qeJ&R&PBCknMo\b:[WZh7cBP`G!N2+,n%g[]A;PK-)&st]AGo4o+8
?3Mt[Obd4:UG.#)Tg@kR)uSTP;D@rK)ors3X/de=#c+/]A_?@TRA.KqS/OtikCD38L;5MV*gG
lO;;]A.lmMEi8fc!<EW"`Y7fc$WC9QRYE.):rs]A1`kQnBbYV48q.$Wh]A6#IH=(m"Kg6+/+l]AJ
pR.%MRHf\kIJjIo"Dj$bfk7?uXB%CY2?2[W`p]AX79W\bF0kn@d2C`-h`-$(CKC19W*EWd62#
CirtftHNKpq2+fs%a*rrM4&&_WM<\iVp_GIhd#X^1Me!,VNBLU[]A\<:\1Ao>_OMFp)9-lMpC
4?VkD:&%kc"8U/<[g?0l\\"V'ipd<GMkTSlM_<QdtqE[6\8+b!OaY*@;%",.N,GreUb09<oM
%Q6jk@Xh"hRb'DRMSZ*NSNec9EQn]AUfhd51T]Aj#O\aEI2F6e!0$g@Q%>A5q9,j.P)dA@W9P7
BGgpmo\HRqA+?W1]A"BWp`TfSE8:Y1FVf/@Vt`2Q::WC-@X>VT6H_Xr;iX;#c5hu1m3Wk'0Kr
5;]Ai6P4-4ScD\U;'`)1L2C[RgUiqcL\`)7%`8AY>+:"X%&aMN(#)os1/<,?D7^&3#'aYa06Z
VIQcX8$;5hP_*F[JZ>lQBV'd()dk*TBhp1.`m@-"Ep$bkY3`W$DI]AU+SWFg4cKj"Y6#8^)e$
likf6Uo5.RP]A1.#fU@)Zu?k'eTE=H\T_]As8h?J>$&9=H2AYWgNW]A-Rt/5B3f?.*ueUf3362q
>q\:$8MQDh+fXIN[mm@G.$Z#WXXc4mM>[S7\4SeS$.IuLgj.9T%)\om&?h\@-"JLGIkE_M2'
r$((>7&-(NsLJC=9_jk5in&AgtQhS70hs]Ahc[$17:[le_;q2g?Z"JE4DqW:MP/[R)U9.)QL<
8]A<nsX`cp6an[i(b*8lfiE0]A?sb@SotcKL/7laC64h.h4U:JVAPMol36,I5P@Ag>9j9ajMY=
*%i5.*D(<a%i-\Qo<beF3Gt?nn6,-<(1Shp.&2@\Fq+F:noS@ijR$-$(&GP01Y0*WNHm6VeA
SEH7/Lk%Z/'kMBR7:=*[XHb_bC5@1G^BQ&EscYg="plrtgSf"HY;\ZE:u>(-J'W"bWk,,=j9
5U?=^TM/<s=L0?f0C3gRk"!)dG9/]AR73)2Z8Q'R['JE)mJ/JuR0mOH'd.VLYimSf?l;-ZPHP
IP]AkA+j/b/@$.C1;V"U/g?A7G4N+,6*10g2IdrHWcFbRO;X61K)`bA-&_6:TReQn4[>cb4JE
F?W^jt_$"s7du2rR1Lm.V,U`7:Q-s.s/!9gf;\A[?]A^-=CgVlr92d\i#H;QEmlF<;T/N&u(q
&G8Xh^G8?datM8D;j@=;#q[1hB(7e>LKu5,TQTQHpR6ME<X2JqoD6Qm)KO_/laacP#0lN0-X
(tKKE[_bnlPX61'AfEWu6.'L#WTak,9f_qdmF@tOK!a4IJW%3,.364g>Xe_dT3+ZZMBOt\T\
,-b"lZ;f[p3.3AG(FJW#>W!"&eoT,)r@HNX`0,LL#n'D"M<IWTh!;NQYZT^!!Kmg<^?4eUS`
9Yn^B(Uhn/t-ilJRB\]A2X#m2`%m#]A"4WEa]A1*-5*sIJC:LbKDj5@cIWp"-]A=]AhX<O5po_IsK
oZ[<V0mjNoS)9>(eMI#tandJs8,)B6o3M`%*gJI.^*<muUIWbfT@4FU'<;7G^)W:k7!QF#nM
Tln#hbHHClArRKcsC(!ZRFZ;RQE0Q?AtJ%hF.499q=0mX)sq!VSoT)101cjl+Eu=5kCMs>-r
SPPW&_D&PTNVIOpX\R#&p_['I1^o%pXEO<`j)_TqsT#'tV)3*lI%)NEgEA'BeLo0CmXh<0=@
=#dt8i&KprZulObi`77A/31Wm(EEM:UPoDffuPfkA8^qRiBBg\bILqY1cIoVlO#u*_Z%@B6-
\U_9Huq\pLYp:%'_<J!<#okV1f$qQj5h;RWY7!Up$iH#anlTP&KjFClgam(nTf7\QL(7"538
4U'-*Jg4JJ`99_%&(V0-njn/dnh[IQK]A+[qSl5IcCj(d)C4#Q3-(&,`:6jLJ@2JG(]Ao71)^8
l$0#Yjm1jY?m1,L1[srYIq%kBOS6"cr1O.W+?/E9Jj/]Ap;fChmRVQYq76^OBOh;q?Ml0^jf%
l<L_VB\a[ot^Le"57ebnnq.^mhXF6Cr7j&53LmoQ.Hq1otBk"Pl/1sLs]A_3(C&rT+NO%qab#
gf_46&00cWaY`^f$VKH@qtQ51/d?,RP.!U)4M6:jrcfoR*Bt8N63A;F9b]A"4ZKs_H84K)+fM
1@XjjkMI#lBJIC&L.JD;:f=]A".@uTb`0:>a12'?aC[YfVe,uQgGHq_\u)Del?`6g#ZqjJCHK
`Cr]AWX!+t-)1m$WW'Og/GUu;i-2%>%eLu4X`ck%9aHTh,Ag*edjpd'&Y,#;tNm3=?/.O@[8e
(Z('k,6c]A-km]ACoq\nmLe]AOP$:8.2m10@iI%>edT)[)&ap=Cl$P.J[%<X0be"+eJXlrbcAsZ
!VU"/a!/&cU38T3S,@dGO?2%a&dp%T-4E<Quq#G3sr/F,+Z5)`LKg%$l-qO>4XOE#PQb/q8(
q0:iL]At;_`kOft)Y,"<_F(JbLWdp.?W+UjmM&Iiq^B`.kaioO)I5*=g#ZD\XB3EIi1-3A11\
WhmXp:Zspo3t@WUE@Bc)6aV+5<ppboeOL]Ab6"JUQNe3@gs:`5n'\PR#0BE!oNs%?3+#r$OEl
=>#!jF_Bs@AUq$LAUt%?eR1@iN"u:&Pr6245MV-cVp,d/[pQf`'Mo&%)+<q_11\9@=g%mVMa
7^YK=Ke'm\)@,jE@!B@D^4fb?PVZsZ$I&k<M"o&7EtnY3hCMg">[knro%PN/Jch_4@WrYGQk
Cb-6d0^oreIKjCgjq9QZU86Up0`[UN/?YI<H1L%UR0Xe#h:l=4/MjKR"n0iesp6Y633$5mK>
E67)":ofBI4V1rqOSR%bNnl',7%jgkH^<i+I0s+7P.-IClct\"*Nh@!.pPhALgt+FmE\:=FE
9:a$BM*CVBW#ncR02O"<J.:n6.s\k9eVDGFj=@qGFRi]AU!"qVVTjT)Zn\`hOPg$<&j\e:%@p
Ka(C5P5mZ7gPt7`eYf,=f%9n:cRN!Lt@Q1kS6cK@^O`N?749X%b#mS7`lY1t92(?)bdI+tR'
/F.9_is8lCpO16)`@n@@56CtBDO!nZe(93f20jLc&#4'Lu"c\VPCi.(3R:qUX6[#3j!dS:3#
BtHk=l,P_G]A.-J@REc$&8?aiGi#BfdY$c4l89eiSL`@BmIn_-jT<NqgJS0:bq"@pBlpWk.X;
Hidpuc%ui)CRVC&kg5/.Na@&F%#r.C)FHU=hW'd/p9`^eUdp"\gN^t?nQoj0YWGTu3&S^Q#2
7TrD#p>L7+"i\B"K_uI]AjJ4e's(EVLpj7#=J\<d/"W@Fnd/bOnp;LWa_Bsd&\[P!bW)9!5(,
/*J^EH"p/Orf3(`F._&<7NF'4sHg^;&\!9u6ot3:g1=,!:UN1=j3@hO<0(pbeqIg]A_lo+7`@
$Q[(ZtS4UHOi4d.t\9F*h!(\3)ZusEnF7\#gdkc>&@bj[B<M">$^aS90f[=4(QBap`gLu+*\
1B+d9W,2c_?/\Lq]A($R[cN]AfW#1_iCki?Os=@Fk2/tdP+'#JqeCNl#tV)?;E&cjO*+3rSt^K
!&TlS:I3q3B)2QgI:mfs*1\II'F)-_#:D[^9.u'50N]Aptns.9VQ-ZVs]AE1F#qgQ&U.P7Xp(n
ML6I:(Gc:=2VM_eGa!b4/HS17Z!5"'$(KiF3nr+JX@FY3a63_uNECNDbC@$[lEf:#@_5oF,B
3;41TnQ\%NY[I+X(/O-t-G`'+?S:GijqZgH>ainnj&S!c>AVBU4W9i)TMuu.D6/r)Y6^S=J6
*;SQE.qsJY'luZdq-`)XPD:WZgE&BNOoZq<GOIP'uE9::q13Apd+kSa^\_^HeSBr0+n3(?l#
%sE[t?k<q=f8W4qN)eJU,&09?)qEW1[fkU]Aq\$#,7Ja!0I\dfk\ejEa,aGQ"QB1f5RZO>oBH
&J!UKg)/TO)oE:,md3J^.Qi9FGsS86DA34)O#I$(."B:iph-o.F,&S``I&*k]A"4f!5s&c_;u
"([VF_bjdoX)UKGIkn-6.VlPUYPIX!WNcHV*Uo>U;[L1b@^m/J_d-ck1q/S5mL3fp6nr>_U)
`XAbSM`=7YprrRrscnfnp"#.%*6Cno#rUfkpOKZ9;ed?9Z]A0mO`CG1dp4)#RaDUU60??D11r
jOU5A1JRq:OP=/=?,XqdGsFrJ5H<)KIaADdWhtsFGbPjW-@D*kVImj@)r3h^.+=^.ich\$*t
BBb`$c(,[o#$iK7WRXfb6VF1Cctb(]A(<]A/m;9L'*rp_Yd_>8N9:WFk>+rek/'aa@SiZS2Tj3
C<I"9qF&;)@BJ:iOoTACgjgc`?a)QI[gtM2)7a_O\$EVV*Zil8P&SKcST:r@V;3#dEJG@@8j
XP]A5FCY&<`s(f'8L4n_dW69GAJgrTqj7ZnC]ACrO7!lSbaA[PHOBpLo2EakO8.OTZW/gSk[qt
1k7C\=$\.k[JQm]AE,6+K9P239I"gs8S(5/@*GPLYh;\7(3Do/$D>:_UYT]AAHkS@PMjk;6g%%
M#?r[?-">-cjL+\$t.Z9!8;T8R5d'f5BbrZ]AG@RT\,)d*qU?L@hCMVpa;g6L"HpPW3oj;5MT
71kY'j$]ANB.J`bcUr?PIW=+-(dNAOLj2o,GskHe<L%k]A^Ic4RSU@V[63V*"B'tkC,8/qcD'*
iZGr=m`4LO0ja&?P\>&sY^U<AZO4qeBc/=%+IZ-Ja\<6NXZl=W)b^Pt).DR>fN/k^%Qg7sap
XJgQb.-9LfUOgT:@Oe-0$i)Fe'7]A4#==k-g^_9.t!<?KASi8$'6t1_P+_$$gR4LO/!'b1@jV
G-LRGh;LSna>H'0jBc%Xa@(Q1GU)>_P"eO4aK)q#(&!iLBBQG]A*6\7%O$u]A,`QA55GVQ'1rV
tu^4E/nXLG9,F*nD*5Nikbo#,GEIu:Z"tDO+B!T$%]A=/2u8<3q2$Lu5+K?KfE\:mr/3U1K_'
)Z#aWk&Nl"Rs$01;WE%iI]AkV]ARHps@tjcK3b)ZkZ.3I1AD>UGioQ-.SeEJ:l\-)GM\V?NH&u
CotXBj-GJFobD0L%Q30mXL(,^s82:<b3J\TFZJJg?npK4QsnRQ2CcR[DN3AtEQV`l8Ko(<!9
\$0frE`X4mb(]A(i:;6=S9\Vrq85AaNT))E^M>hjoni&F]AM5J9RqlJ5?&1L,?Vt:2rSVkrt<d
lTW\I29ZVrG+mfc=lAN7n:1uMAPMf`o^A%=!Z6O/,L-d7j$A)h4Df8D)g%eYnhdP$J_S;>=#
\Llc3U%j(h/NGWq7VLSl):[6<WZnV""%7"EK)XH%aNn%s8R8h9DInIII95VGTSKASr]AKJj(g
l36[a1b,/dSTLVn7S^"u^hd+IPB]A&2G9B#S=ffHd#qInG4(A&h=r@)j/ak"4BXfWetid"NVG
jOX;?-0.fpp7d9AA^%08i=rUVr6eALN,tksp_$q!GFBq+^98Y5j,a\h\A%2mQ>%ul1ads+)+
*6+1B*TA39r7o@bc5Tk%(OA`e!,p@dA_B8PSO0S5";5KWZZ9)/mu#g:c"%glpGDTsqYh\I@f
9,PW7tnYaM4'N22D]A<V41cB15G_d0G)IVQ5=-8.f_BR?E;.S10^J(3:DgjSJe^h22Ci_.)=c
K]AO%#Z9,rXpNd0V0'(**u=dtF$dOJA'ph'YI\Sb`V*PDEs0=o'YB,&o/^l1dYO!XZ.6a#GWH
YY8JR[qVBS,F>2h/U=W6G#NCW+Uk"IR,R.O,;m6bd[s1Rqf@BKpElt9C$5I]A=Da>h`9X/r2&
nXd$^:<;eV4A6A7c$K0UBuhe9@V=`7ID[>.`9!P(80"rTGdpPi7T!$lO,tLX.@s,kY&-XEr+
he[+lJ+H-:C"VrA1:WD(0D:W%e>lPFH.7hJPCh!>H1@a_)_j,.#<)bC?Z_Ug7&^i>pU)IMc8
Z;*gXr[@H_(j67c:nf.Vafl%u"_=V0!;3&Xup5&kt\Y"0\"A3s<iD6=.!Kd@*0PC$3,(ks?,
9DI8ge8"?S12F;TpF_'2/edn)Y`T9QupmBqiJG`Den"NSh<QbLq$>??<FR*@?M)_aVl7\?Ul
NGJ`%Rk]A`C>k&ijH>_0]AqV_h;ATI'+;9iPF^6=K1OiSX]A;'Y1_4>8/6VEl&E4TPGt+^rmaaK
&68G:O2I+Gc_\Z]A1*=s/.-`Vp54R%,NKFJn\]AnmMM0G&mDs2Bfnp*/SQ,)Nk.-b1::Z3Y]A=H
mOOLA96$==rl'"J=F<F_JggZV3D)YV.U&%Z'`o:<PX,hMe'%!;8\D1-m1;r]A%Q=5G?$8[-F/
ZaJ9:_-<Y/u?RVich/AOkrC8tq-&AL&:.UApT+Fu*LX\\#oCeF.(AFT*$rr^eS+/5'k[<qSD
;9b)S^R;&`]AEHd^Rjc@6db[H1++!^d5>!0jd*TF!QUU3SL?q3Y5_2^,euC(ca_A%;6bcO(=[
YlZuiIb`FcRIj74@.1\b@+)DXr;kC,mkZ-<lI9m5R]AX3CDs3+Dsql_"t%jDR[/%S8;CKXd(L
e/5"b@#6<\;YbVHi,;\VVODkV3Q-]As^Ufc&o;$O`mjd'?+uPTB0GLI>60MTm%kGNb8UBMc1`
:s%m[rRK83Fj0qNcLPIgS2#XOf+mU:"OlG;-60B>)F,`G_Ft7ai?:$h='><k_frL6pNuV`I,
+I6+/>.As[I:9f0XX:H<p"V`u:BO+Uh*!@c,YmYr:@XbOR9ZTo6.F(:A7]AT@CjCfleeb"X`r
fH-C4=tF:P\-D$EWWob'Z*/upAg?XN*DX@%pjZQ'[Y?:F[C++,PXpcgl"5L1n496*%O\'kI'
XRW"dqqnCMX%&NfTYWcQI.0fQ!2%XR@?4Ztq/80i)V6gj=Sf4aTo7o;^1*<G9m2FS9r2HMPG
#`"%@X_(1FIl;gXJc-J7.:Xn/ZGX]AeNE2og@bZP+s1iq(0aSu54[CL]A3`'BO+c!AC@**$Hkf
6F`O>"j[3^]AnV^qMM&!uS\b^bnK2G!QL^i^Q8n*35;3k\5]AfVeT]AXW6lj+dBaf=Z,D\a?g:0
BO+K)5o2=sbLC"'[=0LI2@.u8la)pQAeEkKtA1(:N5Z&M;F)=JMW,lg#7+jfEp3_Ut["[SL,
&RT,:=$E69m4>0bpMPO"pOA5[VndC[r3i<B]A(jcHNG.a3<Z4eL3tV7!_pC.>D,J<$>ob]ACnT
t6ZhCDR#jBS>@MfO.hj&HqoIZ"Y.g`kAbgFW$[caCi7kOo9E%p57,_^@;>e9o*hbt4Q:l,4"
dV/+>178,C)qGb9?oW(Y_aoR@6a+sNlc2U<4$8pW5H;M0W.P1/dftE_MYhBQP//7FoaNHfV.
[G;,fd5?l<D:,E1WS6(b^Qo]A>(kcpQI/eg*CY)"+)c`?(7(.HB&Jug'@0h0#oRmpK@p#?(h!
i(qTcG]A\"qr`X>Rf`=@CG6.uKt7>0R9r6)T;<VF;NS`W4AiNV:oa#_;`'&4s?e0$-CB/hNU!
krntC&_r<&m0%[3$0K@(sOu]AnU#)Zge+*$kVC]AJhNn\d9+Db#Eu4fmj7hVZ\/8;&'`/i=cD@
^fChDTmNQ,1HA_b[4Oi*TK[(E+COlO9O,n=.l^.:XWotF=+eV-Tj5^2&O>UHQ6Tdc=C:U/VW
D!DusS?]An;ZJ(@]AqXn282"2r<&n+n@0=]A3kB=:$j1bGNsRO@8afNrDR=8'LGd6L2@UR]Ai$J[
N&3osuPTf5)-kT7eFq93;G2nI*E-D,nYK=E[p+PY&b<;]AXU=XFiKoeYg3g2*fBDNB6nYXc7l
_#uJmJ-*SaW@[g?3be>Q&iu"@]AkifB=_Hm$&i*^H-N'0]ANLA:*Ji!]A$ZF(S3GK,)aiOUr/F.
K/6kU>eUFXNr5$oG7=L4q*AdA,;gmg)g^"S<5_a*'J_NRq/kC">rdLW+'VBe>>[C$Y,)(j;>
l`Q3W8B!]A".C9@sn<Gk;j5qPC2_"=qImI5,Hu)`jAB]A^oB=(qe!"5Z<UgjlNL&<g^YM(%j,0
Ag%%/"@hZtNH*eeWa1:dB3eJZ?JN:i;$j.9NRil.VVsbopdD4m6rcp#c$Cltr>bNqZ3s'J+-
9loU6&K6H\Ir#4s[;!8K4BC1IH'"ofG0^N:r.t!@pB9^Q^0+<S:TA9i%;YT.l"fH#Zd&XBsY
^13R^`ML8:/Id,00GbuL[ha(L+39FVW0*9WX$QSh^l#+eWDR#`q'oma1Ce;=j\QNg5?KiU"`
g=Q>a>+TYon(;+c[$/G"e"Hn,V@1Zn-Ib(7j3sWVt0kMD2iB/2h.4Vik9-!*$3ep7J\\EW*F
_c5WdE./TQG/-VpL^8DkHk?pX%12kRIFX1d)>@sgG8=%n6h!Tm7mTg\.r_#ncZANgXEP[Ed&
qk3Do6m<!;FM7(C0dIX8Qed_10Y-$:iJCrcg^*`L$^g^63/=T7IKj_Od8ZqU,0ha%h)r*D!F
,mMfg(l;f]AMq@5j16]A4h+=ORj8>9,.mC;HPE>FgTq)tXIHt73U*Q*'@lWG*QTtJTs[FG@*AU
@)XZC;J81gS/WC#`KH[V8[!\'tSqPNL:P73@I>JIsP_QhKj<S4ECG@]Aurd&H/c(Xg_&W&2_o
_f;U#MOruY>j\\pcH.)j,]A:#51[,MpU7t1G*H_?&JttmM`0O1[EUT5f0oH4O_?uQoSMj6[s7
#,IQ?(qk?+NJO9cg)D+jAA[7/.&FS$M#DkC2MFaB\HVC6jUTb%=h?49Ar(^_=MLSGd&UcMB#
,k>l*AW@.5duZ!6HZV8p?Tak%_hi:Li8-98+;jb9:fKo9,S86Y+[.4"#kOpu2?9MeE:T:&%\
jF,n&%-n5<(BeOSqB~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="4" vertical="4" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
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
<WidgetName name="report1"/>
<WidgetID widgetID="a74dc66f-60d3-489a-91d5-6a28f00d98d2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[往返低主舱利用率航段]]></O>
<FRFont name="微软雅黑" style="0" size="80"/>
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
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="7" s="0">
<O>
<![CDATA[往返低主舱利用率航段]]></O>
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
<FRFont name="微软雅黑" style="0" size="80"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[j^!4<;cfQ7gJ@-1R6nBp'rN8?@qoY2Q\pA/8343%FAV3qVa\`Q[T6<pLk$BdYHb6AAl1?)CE
a:QZ)f\r-!JfK"O]AmgC4KNa(a2-k`"9g2+UR4TPO+:_=V?nS!t@eFr<$7e3VV<M^;'.*qg4k
.k;P=G4Scq%:FoVPi5mp,oD7nl/9hT0@)8U6s6J^dT?%nXCDJIomWmjc?iQgm@\doG,>E=QR
*;.4J+&5j3<L3qI!/oZ2YOO;s*!e/W8BhKB)/?s1pf`KKgqoWY5"=]A6IkeU9AV#h%B7N-IoR
9`EW=Iciei:hko!-5n)r8ARCl.[!'0BS#GL9&eoJ6_J[G\ZF,[D+W+FV@S5W"M<N=@79Zno#
cQ-h"0b1)8Pn**H\q1-dp6'"[8E"e`!erbmXk[;+bk1Mr)($T:Xru9gX<I#gjHbr+AT[m)"0
U\,Yh=:=O`5"Qs"*P/E\R1CUkY6]AK#4+eY2_E\U?WU'\USl(4+`OR)%TbQEEsKLIDU-^WMK)
kTe:Ot+L)jBb]AYVE,Cr4!^I)O=qSmY_B@TKE<cd*r&mcCK4fIr.U_&ibMbZmXlT.ek\]Ae/_7
tHA9=:!GP#c0J%>*USdS5m&Q\Jmi$/)#cs[6-!#k<^nhS6[YbP'?g_A@JEF?*IS80VjZa^=0
tjmWj`>fj,4T*cjED')>,s$q_ec7TLD@<Pi#$(,"-Vo>:R.^YtI[q9<:[UaD2lk5PnE;r.H!
(Y;0>LQEl3j2Y0cSVsVcP'8c\H:o0=3T":G`_XP.:9A=Pf1M5QD]AO+]AI!;X%T\Rpo'<=+oM(
:R''cb=W'qF.n)u:lF0++8R/\=/j'@171O*A@XLc<6`02uMELMNrb/<hG[_lZ"J.+g@i]AbJ4
/#$Lj&`mm5/S5)KXHfQa-5B6g.<OVI[iV`ak-mM6#KD)Z>faTB4)M<^V>h@UUbVKru4#`JZ^
1?lCQu+Ql&inrE.CNkRLOr#Cc6eWQq<+cp'?EQ:kBQ=7W`l!hk-3fK!lOMe:oB9c$&=XW-#t
5R+o/8\mN'Le$a)VCgE1mbE/QtDAGCn@'Q:L`jEIhd7aFEfT"FjcnJDKc.k._NSuU\Mi[.;2
3Vt2-4?e/+^[nddDj9b4aQ]Aj89@2hp$proj$+m:5k;A2rH0H3%TWhEo")/6_[M<Y:E,PJP:*
RBVaQ7F)+ng5BbnrgLXa5b=*E9kHSoshEZR3B/]Ad(Xs,tlq[Nh1dpn^8Gm%GXBiE*CA.GQ2u
LjNr.,15osM734a,FrJ3o&I9Gl<IC1pKZ/]AY<7oi7\GTV+CP^5+@,mim%#<o/gTMc]A?6+)!J
V>=qo_rW7Z"$j)Dl/EL&_+n*8qt:I`!pLA2j)W$M8.tWgEA&snEl!!l8o%oEp/r"Q9>u&PYl
\INHjafqC8S0Zs_sq$qm%#3<"(F7j"4.\=#pa)@Y'Kc9E#)c`s_>efA;%B#k;.T#!!ReFk$b
rJjT^4iU.Hm.lY]AmcHG2LfL"emVr>q+m2s#pnpt\;E9^p%GYlQb<dqZ>n;oo+JhF(U/D!_*6
VP%Df$f6iYYI3HuO$.nim@\,V)k8V"JAhI^.>sGOge`rmD<tO&&oETLYoF3[!Z1jAYoO#8+R
-,,js9lb4dm3g#M![WcJ"%_.C6;e49m1(9YTD\i0Q`aCcd0t]Akc%\T0`SY4_*H6O@Ve+?pDP
3F0]A@NW=A2_'bEM\odbcmbgd_Mn[]A%u599P3@UC<hdBY73'^RjuSrG`AA5OaO+@W7IQT'1u!
slFLBV9QA3:?VT,G&SBU@*<t(BJ70']ARSmQtTb.AoS)9(q&aeH*Q?>sUuChO+Qh5Arb,<92G
rdG=$09#N3j>?mZADdXa#aAsFg\KIZbS4P%L2KrOl1Jh78q@)!aHq,@cVZ+E,!j45f_.(dUI
(\V5UOl^_p.-E=>ME>P`+c!@0(.4b:t1i'LOF,gD#QNpi\dkL_UsD#s2XLLuHt&qc4MLhU0m
JT/c%\Ssi329.<M`\&W*mnU#ZpX;_YBZfP7X=TWCH1S`@o"fn#XNm64=Vr,uB.'SUdNab\A,
M$mV<KS;V0'eJ;adSP>G'W>`1bIn/'L8IPKN2#P]AJ*"lo8e.\3aV6X0CCP2>WtM=:H9(-$7X
$</8&0HJVS4Z1P(GQ>tS@cWKu86f>5JDX#_i%Qd4:Ub,?o\-\WmY&73GP%s"n+4ud"Ci5ZEJ
8mK-UU^J,R1(^D&+7]Ac(2Nb4h5`>Q)VnqkhYtRWok#482Gs`@Q/2`,g`;0^kIRskc*>;_NW>
0iRC+)]A"m_9Goe]A$p`$qZr-,]A'\3W0*B"F;30AV*=#)D,L</fr_C(3$s9ed6<r\AmH4U;e^Z
b(`]A>DrMtQ_R,G86_F:!N'Y'^AB_0EAHAL$aC6/c\A,C*I2$`#!Tobo%-J-fSoM?\n<;SLIE
!e8A(0:gl<I9F/P5Wqk>Y!SmaQZ:X/\2G1FH#bHT8QC_JdUP:jdM$is!T=."U/LW!oKah()#
]Aa2b1E#]A.-;^6Gg#Q(,F_jKkHM)Cc_r#p_P=m1M$IDS97f;#oBXr+mlD3FH"`,V@Z41f#-6;
>8.W;`@9TCg_u3(m#<ppNP<m,U/`ec2",o)i]A-(Pc#IpE_"#(mKmhRV$s,gTI)F8FS$B=,H$
-55>E#o?3adZHi=[FhrQS`_Om%>'<B,tqn9P9[9;<EoHsDqsVk/NC@X)9Z`t>nRp%!!Ji>/@
<(),XTjfODX=^5`):Z5sPU06n>A#!47*KC_.D@Kiu8cGt]AhG*bU[e-q@5^aqH,S\nOjBR8pe
gPb3Q;23F6]A>A!'H=(S7D^:SO!M"('T4?__CELhDk:Gn=DBa$R478i?_H[jTu$O7=d?dIF^T
#jHBmGCEk$9N/+<[.C/$UiCT4udM8Ad3n?DJ[gNXX=g/,)W2_!Z@ZT/C8L(V4f,8)XTQ3\**
2tNCF!n#YbVj+5A1:hn#/A!Kq/dNWgCX3R-ASoBKETUR>SX,`rNt=9C)A[D30hM=Z*<Z25-;
)IOCUiYP%Je#h)GU(/9nd2Cq.pSYK?XFW>uJdNLrmFgNtOEV$bgkVh"E.i*CJ#b9]A;K?=BZb
b0]Ar-BL&@t'A1(fT."+'Z,<_@jJjK(u([/(Ero+E;lu1u^M,6f?H1eHa!G>?ApW&2Q1Us:!+
sH>sC[R#c*6kiBjcV*kWUkX&M/Lf,(Xc6r>`/.%RL0RfqL3/D*#R4AXSV'2S!XHM[^%Sb\D=
%7^MOYXaEb5/I3<QErcPL;+Er6Rbbg!a<SU$@"YeVE$,:`gB/L4'Z*TjJ6"lsOiKY0"'."c=
WJ)N_Pb$kF0qA!_<9`/roNWZ_X5NpfRG_1OIZ_.G!Q4S>#<Nth7tTsb5*+#eWg\W5&>PsMn@
).o=icGn2")J+^?7CY(?]A>9K,a^9W$e+,oU)m?bL+Zhp?XmDnCUHj)^[S>qGpni&uA*tIVdH
1PEGteM[%</iDif),nq"PC"q?`k@8J&'Z/Bl&#c>kCnDV9&G/J^AM;-V(lni_-8S^OVHc>C6
Km:.fL=P]A$U#iL;`?Rcq#7aj3Y^6cP(7L=;BobHNlukiY;^A\,0r:.FkCo`/YJj-d.Q29kD>
R%R>87#lloj7\*!@<!UPtE9=\$a\j]AQLJ/h6:9le3CHc'BYW2;LJn=%W0O$Vn)P<P7`NUd'4
rV^uOrV7A0/o9OeKOU)JO5E>$elKEP\BA%[gP)s@8gLoPJVqG<PdCm`Af#_t;A;;A."(.8I"
j-o4DZBcaIUM]A'NkJ/8=h=W4<0Is460>6(b#P%\7(cE;2YnN+Q_uCgS4_RFN,7>:m&'BHe*:
GH_l0C=2nHJKuT<ik0trA>TKSGoR4@1jO;B+n5C`6\`'d^*ujcbBW0g+^A\'Id2l)dJ]A0>:X
-NjX8FOMVi^/:80^.S$*rTa1a\%9BH5"7agtj5mf-q7-_:b4B?PU)<aj;<-R]A$"f?Fq/4=5u
c.<hPGo\4G;TPZp4GhEi[/gg2jd82"ddL$l77N&EKW9T#r."[:F=bi#]A[0u\91'k2&!4@_uL
4o6@d[phn2c\\2QDpA@X*bc5idMn<60X\K_:^t:hLa0XD9\?fiAQ$"FH/[52M+bbI%5-)Qb6
d`pDL=mg2IXrTkdk]A(iV,7Nr1Ve36ef1irjqVt"p7lo1ulGdXq'cQG`TCXcYP-9*f$r<I(e6
*b/VuN$Mfd.bC)Ks46lGjcfq"20:3cjjdAeFN+-Jh/+)j,.-57rs17fP)tS@fX7^"E!S:&sH
9=Mh"-_-If4IOn(POW5b'b.8RE:G`4Z]A^i(S\@.pEq+;_s4*]A4EIQP/>O-DNTV.c+Ek]A&$Gb
TZEI%PopG/Vq[eJ!gQIY^Sa/oQ9g@[J%LCIF;BkfHK"f=6'qX,@hA.o]A/M6K]A*EXUM^HTi'+
Ai$kE!f^F74[3j'$nhhS&oM>F;l0b^4$__&b*)^S[_c\Bf6=eO$%o&hdI%,H4H#kVcs##%bF
Q^XIQn2q6LUIH+Ea0.]Asl=OL`-[NDI1qXX'Xa7!^1I4Xm1WLIRMKT47"3MnH"m@oQPFs?f[/
A(omn7`^8/%B%Ou@]AKkZP<V(XDgiBLC/`rY(I[u#u%]AII=WJBc9.!F-H>6?E0oEXIIIb3_B1
Hh[@DrQ,)@Z0P;0AK\DlZ=F]A5lA_UP"`B(NFsmc9N*JIZ2_@gWgi[+N(`30-BlUM8cG?f^;D
_sUGQ.;hk1;hqj!(mM57)CVS*_D+Frkhc?OPY^I;?;!,/2i('B`un/[Sdb]At:%p(pc+j54.+
@BmHJK_ka8*`)ofh?Ep33r(jXf!cWkbM9Rf`(,9j\R78km8Rd08Ab#Ej4\QYp_Q-P)^Z1`&f
RSAQ]A2(#gfd^T=;eVNgdJaa+s3IiD@dA/cQPhFVCAm2Bfku@.\@@RYJaN_8aN!d+9e/[R`/Z
C4&oc,jh301ODGcGq2t@d"5;t-8b;kc:`g#@Y%tE-7<!EAC3X]A9#7tXM=cCjd=+Ggb@JdA&/
C;Ie\<Of38e:>@lBtI3etNe4a$4;*SOK'p@CYWCROJQTL$`Md:HhV)2FadK;0LO7:`%?LiRZ
UZpuD6n`S@:^-;`7fH:W%M?V;jY)\!u5oq0961hJO?i\!7.=Y$;BLKLgqb2b&&MTUY?Hurlb
*ksD!ka0(>S$4\?Fo[a/I8j4:GpR*,oti^_@Xs9c9X,sGlK.4-]Aqco)0Gm>I(*\=k\[oJb^V
c1WJFl5Xh^2ca"l%;!]AtT>sH5e;Q[dsj:"?i?[ekk@dY66XGKq-8A/HaD?Lgd3EU+bi?USuJ
pPjS4l&H2dsk5Ub\+nZ+IBt:c$Xnbm<EolK7>tEuphqncuD6V;.AK.nJBcGDi[6i`+_tbkH^
c+bEj4j7*8YDl6)MlPn#1D"1,+k<QEHN=u&UY?_c@ZN+e:n6f^d(\I`&k96J5Rbh^AH%8JMQ
-Z+[m\1>n@"/e=Ab]A)+d)IFE=mXaWOX\J3*--NgUXlB+Z'lV$pfJHC=\9-@cEH.;jPM=T2DX
>P\+713d279WnCAW$och0<iM`71;b&Y+&6/"q(PQ.D8.j.qV&fZe@XZhFl,[ps<#SHXZ6?X%
=EWpO(.;\5X0Wj6ONKDGcDVk\IU>Qp76X^o9_$#c=Ms9>"k\=c3d\BTsJjfe=_3m?q)b,SR,
@l./]AfS!el@r.<>MV:7etIQVP.fJBQ[c=+fXdA=?3j,JIig;X$U5+ZO1\OorVhQuB8;Xfb0#
)/tQH)eu2[PlqNRE,5tQS=K#S3a3T7u01sEr]AAFWb+#F0FZ<nY9/Y@$nINlnsDud0ko^MM-I
VL$rDg8%_hJio_$8[--*YtBcg6.hCM_\OM_G5%m=0u(hNdh?<SSJZ$2btiZim#$4i[_DE&]AO
(o083c!p10LHo8([]AmHs;MIR?G>Ufd:4'#q$dYSEQCqkZ'QS8`V&lQt>:dIpHrfYBb]A83A91
AfH-HfaAoM4K?qB&?@,!U!?g?'O>9dk>l^o=.&4i`Qg9VPIkT.dhe6C+5oj<lZI(9t4/\K]A.
Kr%;^bFal^NFZ8RNKpQha]A*;==Ah"+5!k.!d:B3r=-&#hOAAe7/l<\ILr*-Lk"e=u>m^-0oe
FN[_+>+0J.Tt$:nt"nl/JB2YZ>3E_o"\;+Xis;K;,N/!^%dsN@<*@$#20hjbR4ji!0UDYUpI
UV&4AQn4V]AX&%\PVJ[/R1p>7,DIdCsPZoPm(Lf=QM(`'.+6kJVYugVRhK:u;PV>1/r)-aZuV
K,@%L8=3#9ecXGgSTfWbO#0LEUrDPlT:]A2o-WekOjIoo*)LRd2@t,KG4.i2uFqCD;%=:M#2l
B$i)#N(SV*B7d(M,MLnpP.Wg5l3sr_I9<F#Od\.pr7T,k@k=S%)gRE;Dje;5^7udu;oHe:jR
X?HerB0+65VDePe&dOk\Gm2Q[C>7P+&gX5W(#.rGKE?jU0qb,+o-!H-9fH7OF7^3uP.,$qF+
qd&l&.O_;5b07J>S%.>U65]AP&+Y%=5ufs+!Lge:!\P4G9q!mg_IK`MR33,7"CW-B($Z)O-Mo
0Wr'hr2U*[qR]A?#,?$U6ntpAgZ[&&>BjT.j?P3dQoR"kD6?"K[#V!&AIUKsJ>#1=l-+4@<5S
F'caU^?ZI%c)j,o'!"hX%T2*GIsT[SKj63S_#J_Un@6XU?LImk"JS(Jq?D9\J^`dY\%33;re
a4B*6o!k8,OhA8&&.&HtKr;j:OP3j^25<-=/eYY<hQmPo7S&53dsBE)>THk.p[M(pb*<>mCB
$$u1gU'K#&mq495aVdVC@V9%]A]A%.qut]AaW.Ao*iLMVfXR(8.ImY4q#gR9(mKYr1n2th6,*p\
q8.!W%/3(Y!!o:.@CSMonL=tL&A\jq98Ga[gR,m2+TdH2=t?WP3*K,6Y*pMed*t5IdB<F"'\
El*1eu2_fM?@Mo9S>4P-9un`EudGUY'iS./XZ+SR@`mH)#Qhd2C00H**P_)!hhDK>Wh9rWl5
U)1#U!K't-S7_7UjG^5@5/[[rC9>qE+>0-`hJ>>80WML_]A*$!a&s4l!doR#5F(2p[MeYMh4@
]A8PC+u%H'UO*,aUl+>Y+0$O"IcL0iO/g6p^P4,[1*1]Al/E`LC:`>O&@2:4L_nB"0q$K<=%R$
jNjSV-.CN"+CcsE7AJRY#rZj/9%(?;V<qX/Bm'*-kI0]Aho6!fhu2W)alF">XlmaqtOa77&^&
AF.!aBC*f:fgf[q5d"US8.<=Bk,L?_]Akd3`nL/2ONV.mA)'D&RFCG+`cK:"Rp81*2#glNkrW
Fb/g3qr3QO,R86!i5as;[N(u.@J9iWX6?TaBSE,!oAL^Od9\K-JBC!WjeZIAQ]AB/VUI1h@bG
m_4"tEUS'_&AW/?/#C4F7n(9EoU?7aO[::Cb^*P<mh/\L$hC7:5^7`9"o0\V>aM+)o)25u16
(eS=Z1+S"b7[J2.G'LORO\9b.l_T6V1DBRdK\@iX3TU:>'4hhT^t*'=UL+/*'h52e>=5Xk_u
:X?@PGBA=]A%*rqW/=mL6m:*,u^*cY3l()Q3bT"LGUg"GR%17qHWdq.lH_.oYc@B\_'90WKJ)
mG/.3V360S:[R4%Pckfn;Nj?odkd]Aq0@+7^RH3>ZJTf/J5d+Yr9ekXM"3t']Ab''d$_'M&_fl
VZ&o`(LZ$j!)[#dR%&U$T)4+%(_.dpZEIq&Bs[bEWF&k+F(V;kU<8D$GiJ"OI\22p15Plu2m
FHROqf3.09#,4FD*2%@JbD<.eTXqhRH_EtY7NY^%lp!50"+`BMFTE1l]A<IaA"k'cb$P^,,q'
EBJaUV<YHe_4)E^hr\U(>ggMYN^,!!(<SpJ%h754Gj6E7R6=4VX&"-FcSY2!(mY/>Pd$VTJ>
YZOGoEKa4bm^B<\J&Je`;]A&o;6fhKY7$/:XAP66<SA3_.X-r7j(%2XerkgQP[PmYDs<-4o#\
)*d,p+R,%N40.jW:EY.E.6@''6?UQ4psFKqf,_(7SH/&UdRd)Is/-S^'d!:(Xb/t#?WHWG=-
!BCg_qS>'9HQW?#i!7'+UP>bY'Aq)AkhQA4N3S^rTL@<`\_>f3=DJ8mMqEB#,9Z5t:QM5/0r
]A*LlVfHVgm!7TPD[iM.:W`p=Jd8pqT%$E+sNl?C2qYhWuCL?,7*S]AN9.g;*XMPJG)F]AV(uRZ
*e&3+Hu]A68A8ed(]Ai9,:7;C1"-NZ';ahPMn.(kI\0Pm?aJ9?DrU.6`Pg%)L]AYVlnJNFoe,fe
1^<5ffBhn.fdpY$W?.)Np0q70!#H'C%K<[:!#rI=PlPr>,%b>":Y)Mh;CbP+^Z1pdH!&#_IS
R2XAKA%J1EM^%.UB+b,Vbh)RT/ouNpp;@/+]AlCUFJAuIO4]Ad]AJ30=i`oR(>^V"S.2VC&C;Zn
`4`E5Xs,Qa(7AgR<n"/"Ol1kD8Q5e4NjHtB6l\!#o$P#5@`Ecn[bi#%9_B[S.%L32#PEKAVK
<$:qV_D?N,V[\Ogjhp:g:ZVGBT_&m.V)8?c)DCg[E*<Z_]AD2Hcl1!&i>+HO5Z#j>5Ntm1U':
?_fEtlc\W9*bm%!C'?&P[Ys+SP>QOR`L95Qm/a06(p9nn9?^K'`433]A-"4X$C4;Dkp<FNHp<
J?hNIhDT8]Ai1UhZO?kpb1?KMG4p+)8qU!U6#[EV$r%SrIQJi$9>a+*?B+S=)&W70IU]A9j!m,
+:b^P]Aq]A/30]AI)C:i%u.c`OQd9rDLYj7OE$F0bX#02Iu]A;kDo=HI-"(7h[><j4dB3J\b=H[G
aY6ScmiFAfGGT,e?iGKhWr-FVF,")?8eO5YjG$H(d8I$.D6k6BHf3p^Gl?=MN8F+GS)B-O#`
p"sc#RI,b4!D?;g&;suh]A4Qb3J.R1u4&ql?3uX^2NStD_Z,VW>6eCL,gf0AcbHW2U3PS(iRl
fUG+MZc8\*<RS[9Gik*r~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="468" height="34"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ComboBox">
<WidgetName name="qy"/>
<WidgetID widgetID="0ba693d7-7393-46b9-9e2a-761b06bef2d3"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="comboBox0" frozen="false"/>
<PrivilegeControl/>
<MobileStyle class="com.fr.form.ui.mobile.DefaultMobileStyle" isCustom="true" borderType="1" borderRadius="6.0" borderColor="-855310" iconColor="-14701083">
<Background name="ColorBackground" color="-1"/>
<FRFont name="SimSun" style="0" size="96"/>
</MobileStyle>
</WidgetAttr>
<DirectEdit>
<![CDATA[false]]></DirectEdit>
<CustomData>
<![CDATA[false]]></CustomData>
<Dictionary class="com.fr.data.impl.CustomDictionary">
<CustomDictAttr>
<Dict key="全国" value="全国"/>
<Dict key="中南" value="中南"/>
<Dict key="华北" value="华北"/>
<Dict key="华东" value="华东"/>
<Dict key="西南" value="西南"/>
<Dict key="东北" value="东北"/>
<Dict key="西北" value="西北"/>
</CustomDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[全国]]></O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="318" y="36" width="120" height="30"/>
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
<WidgetID widgetID="79e8e040-61a6-489f-aa14-e5410dcd96f8"/>
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
<![CDATA[723900,144000,288000,144000,167900,311900,167900,167900,311900,167900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[144000,288000,144000,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="5" s="0">
<O>
<![CDATA[ 主舱利用率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" rs="3" s="1">
<O>
<![CDATA[0.8-1]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" rs="3" s="1">
<O>
<![CDATA[0.6-0.8]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="7" rs="3" s="1">
<O>
<![CDATA[0-0.6]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="8" s="4">
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
<FRFont name="微软雅黑" style="1" size="64" foreground="-6908266"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="64" foreground="-6908266"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-8265558"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-16091223"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-4043734"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!C;cgDNDLYT'CFsV^WJDt5IAE;^&1n55OEB36P,Qm_(+>6nL.<gdPb=BVP2:@3[=F2j-7
Y'MMilbn2$0%u5Z4FF;]Anr9!eue7!YI-i&g2k?mKlj]AjFhU8K%A6&ro*=tS=R@>g3]AspIHt*
!*.E>5k/EB7H[NY]A"cGaV]ALH#-i/bq_$Qe!pmuIOBloO2kY[@K3(@p0dhDgmP7s=,fA3]AbUh
(]AOKdt)&X@)@mn'MC?uI.$)0<?HX7[\]A:QGk>4t5A_9c-2s?Or[4<`[?NgtH2-T=LLX!V&cO
R2k!gc=Aa!%aS,[VuDK(RVVgYb6<U4aP(R,Pe\ID7N+!t^VFf&35.5PGjG*@q3cK"^/ZrVTM
Gu]A,\]AXYb*UL.d,Xj3u2+4U0(#U9M!\]A&+Tg6^'[jR>q9'^Mq_++/lg\qH?@'^5"$o9o!=?)
ZSNaHc1e7i]A9gG>L8:)."Sg5=TZO]ACc7aZ_!7V3im#0qL<mH[5=+3NM0!4."BGU`hE%11qBX
^Jg]A!cOrcb@*&U".SCa)%N1<LJYA><r,eSe3H53gSDa.'IUF\:b@+Ta"`oTL2AR5+$5,mD:-
Lm0W\"NKV.EPTTkELXG6"F,5iM\O/l\LPaj9sZlCo6hs9*qATMQ2Qjl=!N#`NsgsMGe^cOq`
5<_+]A:,qGp<T;V+C\^[Ba1N_^#9R36Lql*r`uMPk;p1j6jE^pVPX7U#\Yb0^Z]AJa-Pnm2Ca"
M%^.imR-eC?V.fE;^@'/B16X$Zl`r`#1NV8G12GX`,]Aj`>GU?#%a1'MnTV"bitLo+nZIG,9e
CZLB>]A$HQEOmnZrd%(RW@_1j`ln,nR><*+f-4ljU,*dU,iMr&5RfBLTL`_AYZP0?YeQ$^YuN
6E*3,m0R)2!?5YE)JWQ$l;=iV1bnF[BGM1s_=s7(b$6586R;?K?2_qk8!3gWX_j.R\f=g2@C
#]AtfGRQY7CuRG7K)hB4a+PPt\/CI!>P(:SOrH6dGYt5`<2Or@fJc\H?'Zu(e_]APUZC.h.A3t
`5iH!PUTP(C=j(6>\]ApV^^j(.>%Gr[p6Yj$mb='X*V:OZTW)G09$a,T%H*D9LGJc=Nrl*#33
:K2M-)X'<RV=r_ci9^0X1pqgP7U5/dbQkg<^-;qS0jIX$36Chr!ke6V>e.6kaY3)S7_6[q#2
3;@lZnA*"s8mX9T6u:*%5Gg2.WJE?0h%'Y9P5;/c,)(UtUM$RLM*"TkJ4-7=8Rh$(eS9[;5^
-+Hk04)\@LWG3ADW"`=,T_ZI$^dff'hA']A/&Y1EEb9b&%FnW!47%8E\#r/CC]A;Y!UY\T3(IT
_?V>emmV:X*6M1;sUWWT(;o+>"\eA?cQ@@"Mhlulp:aq6:1Kl*)&qE)CD(Tl3K!#\F%"abFM
/gXj.C?W2`$k*S1#UgA7YAVE^Et/>$Ut]AsO#g]Asdo.j9bJg_/i3E=$On_a/o.aoENaqM<h/7
F"(&2=as^6V#00>CP`O8mFUnsmWrSnNa8TD]AnHq.s2*?5H.MUqGHq*^<hA>#9X6j7>+X545<
-a+?ms_ag1rINVEV:sN9lms.l/[@Us41"XQbu'KmkV[Jm<!W,+fA[?PBTlC8Xu>0=K0bh8?s
8))&^41cJ'sYLP,@KREm^niW&.)U4P9bc9+M974`UU`,5o=EHt<]AR\^;\(R:D+I&DD`)H-mH
QAfe44%ktEt38Y]A"Dc8Z$]AgANPqj(QjcUiZ3SJ-;'Qrjjhf#lkIJMWLS_&bF1m[HF7l(N+5^
gAT9a#dHm;#+`\8n<NK"B?ME2iMcElIhhgC293)%\HY'P<U)G_\Dc6RT?9JnB]A#WFmtN%T?^
@kellD`9;m&duqtL2OXpeMD*-+GAi'@ic`*JoM%iHLaQV)k:R)NII]Ad7EXi'M%R8#g5PQg"r
ilhAtjY9U>nr>`QtonBmU';Ej\Lt9J!593:i!$=Z^+K%k_E^/Re5-7oee1.RUO6Q<3S+12I0
N''(YZ]AKrU[OO_?;"J]A,Q0\e#DBhmV9AC?([W2d@qSb@^;#9;*qF2=F(:ZY't<mp]A;<?4b";
9(Jgr#A2)-kmhh<V8;o9S:`ZYi/f9(9RPP.EmThW]A84V!YnJ[")O$E\5ua1D+H8$;_^CJnkZ
=.N/2G6.f=N1k8<7HXV^Y?.a>>cm]ApsFLTrKF09V"%-(pQL/l6n>,1V<OJHr^p\R@\YNShmY
a_8(s>lRqiY`d6/3fU^pAM)0RhK.Yn=O-O^3:ZkqStZ8]AZUpUT,pJ$Hd`hq4Y@fhAINgOH%2
-'-Oum!9`kU;sIWG'p]ASPm?/+5@"nqQj-c4$9@G2bruX.N-sB=i,MS!+@Z/e^($l='YO%4&J
qPd:,?);=k@d4!Be1N3:/[D::47Bt<Qn4-b^B<?Y>8%5D&l7ZULZ!SttaQ&'Ws$QDLG`c_5n
qo+XI=/!*Vl.+p0lE.T^PD#VV`\\p^a8It;9@uW*6K:lM!UG<^dBoK:I#tY%lob(FT(=mb%o
`OK::%ij2O>;S,1]A]A<mh2/6X"m&`?+]ALl+r:CNXY&jXKhK4R=a1BH#R$V]A0Xfb%#3nCAV$-H
Tp;,EjBD_EbVD+"WKmQ5:btFA;fBpbI7ml\&i;s=48lnU`*AT+I(jQt`FH*l033XF$=tGL(M
XgTjK/Z[Z"mFfoFZX+m-/"9&Tgrb)3FlHiOE.=b\'emB)6W*MGH<]A^eua[17K5m(pV;=dGB_
^8i>te)RqMj!K6XeGI0jaN1j+d4csF,U#JZ0VG,dDHnGh?Q<4P^DF'gSTUaOM]AnIN4c90P-(
E2T7Jsnm+lI-p#'>p5+?`\N$D^F3r]AW'6#$Q1,Pf#Ot]A$+>`!2*f4qp/T-O8'uSskm2rEa_+
#Sio,aR7c:r@Bbi;R$gDh[RY3#c[Q7ekr>omQANVb*/D*(@-8'RN\pC4.4FF[5kO,7T*NP;h
1"R*'p>,?D?n^bD&2`br%I&/o`L@PVK&Y7l(Q+lY=S!Q:]A<U\^('8Q!k$^Dc36[XSR\>@tNb
(>jK:K7171PMP:+_Ct^gn/@Ojg?\GV9I6c'X?i#%Qb[I?tjF.`,N^nFikI#fd/N>*c:\Fo]A:
8]A,a'!/5K]AV4OtlVpL[<@'2m7@]ATEKg(Njad8p[[MYjoBm<Z_r-,$>,PS0>-k%Roc'G\?UFS
%P3<(hTm(q*oh:Mk7WWFuMWN^fm)g%@ljQ%$qF6;m.#AiWDHbK%=U7A3Ds`[2VQj2XS?+W.U
?dAO@`jo;m(Nk-8>#%ZoV&7.15$n>%V<!t2d1M<"7haaaPcR`]AD+;i]AX<8SG(KB`;k\.K*K9
eEYjL&BtdhHkV;aoX?NncV$',=3%dm?6!P&N83F%ET2U3PmhreUo'LC%1'tlL,>uO(WCFXB,
(t.fK1o]AW%c>`HF\,ONZmQJaXn_h%AOm.AJI4h-6(*W0f_jW'3R.oF'BMn4JRJPXNnD)N1Gs
$G8SBdaP/;Ane!28m4DV@+_e8$9/HBs7akj2!"O';T`".0Y;7SgJWEhLND&DE8:0I@ec.(o)
okm3#LaOh)*;q)A!Pb+U$&a7C_m&AiV-/JlHK-)g!!A;/48l2Wf5d_0_Me2?8ca?L>L5pH@u
M9@Z8IkhTrcP=T!9V+!;mBnJ#4:H3qKfDaQ1h5iMu9H".>qNVS70&WB@D,!H^1$^kWHTM?.@
NZ7WipPQ1?N$-8Fc;S8q#;jcf!'W=4Qi(T$JblnB;P$4FZBnF2d!30oCo2$H=6Tp>b5'EVd<
=A-is5[2;)imh+.C6!BR$!DZF4t-gLV5iM!JAXaTo[i2rJ<FFXM84fJA':WoI9YX8e.JHs/K
JG9(OrPU!1;^7dn*!TJ<c7B9\B8R.J'J$2d!C)VJ$1ZEkkAjir.aM"fr3dZC&5N%KPFG;K$_
HuI#mL_:]Aq%R/B@k(DF`(/`p-ItpX"_A;-.$/N1>2MhmT^O$cGTh-QME`/PR=J(u7W&e(q&Z
fE%q3j!RrCO,I_VU\]ALkD%eR8H22a/`FrC`5ls#F+0:U/c+<;d'`[2Du3>+.8f(\?V0Z0Q*]A
.s<u.FU.epWJOV[R>'TBYKsu!ar_[h<o^qLaA)2.*S*?YDid.hf4Y)c=5#'%gSBXfa4['daV
p`/qVkf0JYO^!*YlSk[Z#D))[.L;csHMcci+&a(:XX6kf.L)[$_QA4:LEMUr730lAV25A-%#
#TC6BQ>3><>6R[70;3N.lp;thHP[WG34N2b_3!8Ys@Ff"TAk7X6L=aq8)_bqY`^CdM5_!2V9
!@0U*Ob&o:A3-Dih9W/^LGI-!R<&O9-c%+=[KOi.IEtO>&O"SPa2q_''*qghEb/<qrFf<*tL
7)QQ<=?Hmb.eKV04Flp>f?)75'*]AfJ:l<CJ(mm::9H^BqR9^uE:Q+>JiYq\@TAh/*Rgd9QTk
=*4ko46B)/E.a_iF^5*e*<EEID2&Ff:#qr71lMWlD3&D=h&nDaf&p/_IVC5#c^<)gl0@GchF
JI7A!t:#1GF^gdA-,mP6'aZP]ANQ(+&^Z[8GQ+"@#Z4N"ImN,5;D7qSX6H46gja3D;5slj9F_
Sr"3qr$kZ(a(hn-m770o8kiQXuQWQ)hR>5"G:r:9e-Y;u6fMS0,UG4bH[C\Vh(Y^ot/l(=U!
\\Rm$hi(C83,o4$a"EspJfJ3FNV+9AJ;`b)A/D[)h8U^E=T?aEnA@8-oM>/'K@nT?&&s4gmu
8nY#&0D>lPeT2WI0*q`I_4j$RUJE=;d=@AVo_\9tU\^,&4n]A@8a$3g"LKlsdmF(>aqg@E.U)
?Xgd,`/-G+AiIa]A?#l-jU;(5TG>[L7R$Zf$<KQfATgW[4&(sNp[,!]ASQ/>6figDR"UZ"tj.G
NrM#='30-6p2''4ESh>f6cir`4h"r$hn>osQdqbg#GZb[%Zh*XdCX0TP'ZaIgXffMo[+-KRY
)po8,S4N,9=5Z4lL*%NrAf.ZL@WLU5-OiNt3c/(d",[aq!`gP=aG=3PbqZfqXKg"D:Q&7#^8
ECX!L\4[nc6G(UUDn[5hCUuqEWd21(CcmcQqG7>F#=cHi7tBr3P9#Qj1Pe#IMS0)4jWq0oKU
W"6p]AM:8\S-`cXp(JdahLjN:aLWW%q>7dZjC?9+a-L1/p)9?]AC;gU&83b3?[X.P*aF;-G/^V
#1,5rc:fnWo5kR?EmI,HkZLJb#2(PH*'?N&LYWLh=:"/c%U1VG/-;.pF%sd8qbbj)TD`se77
o]AEj+He&Z'Nq5`*d&J^#g^TV.]AAdOU3iu.MgRl.r>[!!E--3H#BeQe\XE8/rT:QR\Tk*RN,9
*ksuuHp19a:l0[M)ALU;(cOs+5W539^Ec/$nb;l\6COO[#`ggRXe'b5LV<X7m]AGK"5^/.PtF
&[%d-f@A3k0;ZD#.T#<o&`$gjLiTCL77haIrH:4cc+hH4'U!fU9A"\aj_(6ar:X9hN7>@79O
cE!_Cqj'2f8<!&?k:cP@"s)A.ga5sVu.Y^dIUcO&BW(U\+4fZm*A0;Q3b<sq^h#2DY!Acc`"
Rs\6Z#<K7P39L5s[=:rK<k%p&G-6`9$.%JAOL\[JL_HU<_Jh@W:;f/2Q]Ao6(jfQN0il"Wa8>
6P%3)MH*!8aVC;55;jXIl0E&M'Ljg^B<WX^Ugr!@J`[f3i:;:kbS<ood8A0O3jSS##)GD\m+
H"R[:ZD[c%"72??JM-b&(nY]Ap]Ais*YO:!&Zl6"OKcf!h=Zf'+m(`T">Be-rJl\.A4Aqcb1tk
Qri#'mpK:Y^0)Yp&NJ3`EZ@Q.hSQ66$@G=[)3P)l:3El'*X0+ZV4F2),mla@VKSb?_UZoe$O
.3X^2&KYQT=fZc80c)+Q3f:!g8Z-l\EV^d-nDL'>Ti^B^+WouEK>Zor@b%5sB#U5"!K75`E*
$$)'JMWM`o=>ejr'g:KF'RXV-QD@u]A?-0@Y^DeN]A4ZL%t`/-7504m$/4A>S24ok1rTTj5Y_p
G@JChCSJ>Y,.eHb0O`%=Z$WcpH)am"\+QBR)]Ac=$Fc*lm0a@rR(uk4/hnENV/sPcI-hb;UuV
kI8L.pV.$mN7VJ9(7ipet]A%dN\Z"YC0=9HL>c4_kJ@iq8!QK2=KG'GaZ[>]ASA89p;ZP*>!]A%
&H-g!@,0]A!U*>d?YqGY3O)H!;r@iQm*Q-Yg-cXBQG[irh@^aH9!0T1V7Z@=BO^T$HjO+MH*'
nlf"^`bT3n!er<ZIM[-e;'&b$gO=m#4!eg9I9mSged>!OgebZ^BadbB)S'<d8.GsoB$):^[!
_fuW,`HY\&1I\c,e\2Cnp5AG=."18WehD_*(ToVo\7M`[BF.EGKL?YlG`)H=Z<gp&M4!0"E>
aZ]AK-Y/[(]A?.&-$qdkXasWt??\c7j2btG#?3a.KG198FFNuNl^-OD&0,p72W4_2@t%]Ak(a`h
m5_<]A[!dVL*(I<Y8#q"*&A\I@YPfDjF6ptM@`l5$4RcnoiZCj.]AgA[q=>c\%%LH%$R"`%ftc
9kjRYD(TB7bqYOFn<`!@%qG^anth*N'6A3D,pt_8K*t2U<(;%0"0BJA"5DhXPE/UBSLdaN9C
FTe6@l.&O>nr";r(2Ji70HEtJghI$:)#AP*pDeqp@ZVu\SN3fJ-si82M4lDV2"`>FBuNKXc-
Ocq?Q"Z,&RelVVeK@#$8GIU:Zi8492?:YR#WIj\n16fA:c/e%RR6iqE^re"C:+ddGT!C=mJQ
*61^5)#f!ZV]AKWGV`&"PqT2@#/U^mQAd2K;g\JOpb!B4d#ZgT^6op$A:$d$n(cMHfLi:Di8U
O$TS5c:^l1;T)AMq4rp^(]A29bpkiOt;@dF7=6Ei*;S!,Q$8qYB)FQnuemgM`Z@*2SeLig9$2
IO[1241p>l;ti3"_eRo^69'3TkGEXs-;%q`@0eP?+9[aPu$7(93%4:UCZiei+)t@TOIP43kZ
HR56eY9&"9*Gn)DC0[60p#DG:=oO8Wu-l]A9d8s6%024E-GY_-VJm<]AJSaSSG^/Zb((d,K;_7
Xf4(r1sX"1NLZ8'i1rK^Z"UUnV<A>CAY%Xqe$hP_//M?l,@,M["WH16EA>d)h/01nJsT\M0.
)4]AmbrMC<=PE^#Sdg<+=.FpYb1La6RJJN2:$l>1<35fje&gnp(\(I__]AKJQOd;U$L[?D*`Q-
6LZ*c=i?fV.cVrK=>u#-NTYAOdZIEu+3u58"#enBSot(XJhGQ-G1)nMMO(_JpVdZAZlCH6fc
uMD\F9r.N4.SuoV.JIQQKIQ!^]APA,mPbrnIs'%$iuRU#1'*6T(sG[c(UYjc[6i-RP7]AJk[',
.\5[c0ODDGF+8H-GF`FV#Vi@4[@M*?LTp\_qtU7TV2PsX@_gX<K._^!;smt&c0LqDDppRn*_
-`9k6KGH?bni!)'H^Jt@O`e/L&-e`AnbVhF:(DiM9c&$]AN;t@!n'r2k?N3/mapK^"P]Ag9#$X
5L(MW+<,8*>2DUg]ANJ]A6e)H_T5;1#MacNL+po%cqrmiG(J\PV)_IQjL=uO5@eu`mR&J<)aY=
Gq?XpNUX\V91#ZQu8h\#)RpX0P&X6U`Y[1K+M!l:&5p#PF)!34ADc<Jbb']A*!s6`)UrTP,!6
>_$F5n5[maq94mlCi5pd0h4hs$pGOIF)Dd=,CbfLm8,=*#q8G=K)"!K6mnSLO$HU.i;^,Koo
sl)^/OamtBC$jpk,/TCf6j,)I&E`(#U-8m^'P[H^Yc]A>O5Z1Dsg`\;k5S8M$<sXfWU2%SWi*
=Hk5BXEZpaakm4]AkJS]A3Mo"uO.QtVfL`N>J5n9G-3D^G@"W<%lgI$k#9=MCC0j(4\YfP(X3]A
A<Ccdjr1)M_j3bXrr3A[`rrp_9&=h4S^<S!e,W"p=p'%t\h!n<R&ZMfL+kp$iC<hHp@TlsIR
<`ML3KnQqcg*NMShc'R,D?fW6U6!4sSHI1!k3D:m,8QX^u+mZbHR?DEK%f-ejB%_6a$#O-0Z
f);H72DpEH7M=u*Z!!(/hW*"hZ,qC"c;9;m7nERD?k57<3b^<>6C9U%&XhPFU2@hg8+J[k3p
Yrg"a([VRAOuF0K7Ab)#pr$C&f#^c@EGI[U\5c@C<>GSr^Tau[+5?b7Ih07lj!oD<oQ3sZ`)
,ZU--c(!u6bCN)NM@ujO,dKt7^GW0+#^tTdGo$s/[a6f=`CDd9K1.'LGWinH7b0oB20Ve*VB
Da6qLoCZ$!&8=*+Kn?/#g/\<\s#IR:DQmBE4B?E!d2LCcT3s'+X,ME3B"@5G)M#gh/$dEGM$
%JE%O"P<:O)Qk]Ao10rr_C.>DK\R$.-r8G\&b"U1n\Je&XU?WDb7kW/>h!W#0R5dh+;l2D1W>
56>d/q'4R:DS7A-0=;aV\L"!N[o\lRDq!?'AIS9i%8mn/(pF#2cguceS,=&BgY5pj^cD;!J`
Rs-o\?<cREh21s`'*LShBY[\6EENk<lQ*_3-U1\`i-bXhjOE-Y6AU58@''HcZ+V@f1k6YY8.
io#pc&'2>"BuP_EX`.WP11RFkc,L*;1OX3Z5:D".M,mJtIqn>:nCQY^ZCo;;;<,UI"lX0>,S
>'!8LgcQ/Fb%e0'iD.*"7Ig$bHGP!ZGB"W%(I5;9kjeQ8=CdW8GZVJWtqk17]AXiqra_`o1dc
:[0qJD.S[md@-r6'1W[sM)K'!Yi<3!"4:j%)4#B74TPB#!H@ENTP#e@qJ>?p3TfBB0Zep3Kp
pZiqW-"_CkllCD5Xe`E3E(\t%-7U'a4T;G2[i<.$3jQPWgNg=!qNQ[Y=rIEa,L`eGNH-;^B.
qTZfR%Cd_E6Y_5_+o?rU2np8`be4lC]ANGL_Y^$RfMp"Vu-4EGr'P$2*JJf\&qEWQ-Q&(s$$$
aBY\#%(PkPQ)t-uNDTtc*L08!Mj=c#'"j)jougbX[c!.TXpJY>*-H9VIGnM.8;&V!1'j><_A
1WJUEPto]Ab'[PU!MXP,ShU=KQW:)9ub).mW.qglHJHIVK1Il_>Y^Gii`ju*asX2S>@7c$Zpo
<cR0*h/3U\k>Tl$fKEo".n8q#i/-Ib*l]A6&5pHlsFS.W:l::?&FGn1OUA]A79j`#(>`BL6\PU
T-3nFOef?@BVtLs+CD-Q,KEaJSJk@X@2?0f*1JHS+&cXO$Rn^!A;L'(CK>2YBk^&%J\8>J,r
,YX7$u#j!f+R]Abd?aO$Qe\Q,R;rCeLAQ]ABR6+gkiA=WlfS`*FU/0bi#X-@i$!?]A/c)?10H7=
8:VJJX9$6Y*bI4V7!8S6?G:oS^6S^>;#96>(8cY?A'>99%k\i1N9tn613g7D"V2hW_^D=GXb
GVkh]AR4dG"M'B8t>d91(UrN>*?hh`-@i>HSO`D%SR2q=Yo7BcMU;G9()f"Hs:d$nB"!uBY>=
Bd^Lt7hnb!T;'$6>@tCVG(-t9fiO%SG,G7J]AdU.[qMRHMeI[F+<c[378YCt2XH:CTYhVqk1j
DS%4)n:'5Ce,iUl#.)1JUZP!.OVAi1$5KY.R?->qUnQfU$oO(j"e-M6,Y._,NU#bBP2m^od]A
aK!5T<l+qp8U:al8#QIW152KI>%!8oT?aj8oeJ29omPHiBZnhP?<mg!44RDN@-PkenIpR.5i
F@QP*X$Q%A>da<]Ams3r*O]AM7$Z6_kOJSX]AT%ZN`H(UL>"BEBhCkUp.FV8pAVb.7>Gh0)eR1X
.&!'dtn1,Si7C$[\T/.,@_66ZW:nDh0=BP/Wh5/[fuT6#-^DL@H*Z[q8D4i6[trGHlU4f1=(
n,.L&:C9jO[11H:1"\?MSfFfB[;Zl/dYki4eJpNFL%bF^d$"".tZ37[9ME=/1n9[:X!*j^]AK
,\@Ji@Y]ABTS<bXL6Q=;(Ja+CNV8!p<&m2t9%6=bV%HaN4%+g3D+A<lRe;&cHt%(Cm"GTI6/q
u)keZ,-RU7AM5.X;4TPW*U+Jj"\`>kjf-.;g7aJb_JK4`[Y?b[1moae64I-m]AL%PIh]A$e_oc
[<&Oao?mR>~
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
<WidgetID widgetID="79e8e040-61a6-489f-aa14-e5410dcd96f8"/>
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
<CellElementList/>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
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
<BoundsAttr x="10" y="351" width="150" height="75"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="地图模块"/>
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
<WidgetName name="地图模块"/>
<WidgetID widgetID="4cb36a94-72d2-4001-a13d-5aa2d473aec2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-1" borderRadius="10" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[=\"  主舱利用率流向图\"]]></O>
<FRFont name="微软雅黑" style="0" size="80"/>
<Position pos="2"/>
<Background name="ColorBackground" color="-855310"/>
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
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="7" rs="20">
<O t="CC">
<LayoutAttr selectedIndex="0"/>
<ChangeAttr enable="false" changeType="button" timeInterval="5" buttonColor="-6710887" carouselColor="-8421505" showArrow="true">
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="PingFangSC-Regular" style="0" size="96" foreground="-1"/>
</Attr>
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
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
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
<![CDATA[主舱利用率流向图]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="2"/>
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
<Attr alpha="0.5"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrMarkerAlpha">
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapTooltip">
<AttrMapTooltip>
<areaTooltip class="com.fr.plugin.chart.base.AttrTooltip">
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${NAME}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}${SIZE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${NAME}${SERIES}${VALUE}${SIZE}"/>
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
<TableFieldCollection/>
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="left"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipMapValueFormat">
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
<Attr enable="false" duration="4" followMouse="false" showMutiSeries="true" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${NAME}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}${SIZE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${NAME}${SERIES}${VALUE}${SIZE}"/>
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
<TableFieldCollection/>
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
<HtmlLabel customText="function(){ return this.name+this.seriesName+this.value;}" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${FROM.NAME}${TO.NAME}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${FROM.NAME}${TO.NAME}${SERIES}${VALUE}"/>
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
<Attr class="com.fr.plugin.chart.base.AttrBorderWithAlpha">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AlphaAttr alpha="1.0"/>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrEffect">
<AttrEffect>
<attr enabled="true" period="3.2"/>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
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
<attr enabled="false" period="15.0"/>
<lineEffectAttr animationType="default"/>
<marker>
<VanAttrMarker>
<Attr isCommon="false" anchorSize="22.0" markerType="NullMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="ImageBackground" layout="2"/>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${NAME}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${NAME}"/>
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
<TableFieldCollection/>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="5" align="9" isCustom="true"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${NAME}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${NAME}"/>
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
<TableFieldCollection/>
<Attr isCommon="true" isCustom="true" isRichText="false" richTextAlign="center"/>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="5" align="9" isCustom="true"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${NAME}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${NAME}"/>
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
<TableFieldCollection/>
<Attr isCommon="true" isCustom="true" isRichText="false" richTextAlign="center"/>
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
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-3355444" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.9"/>
</AttrAlpha>
</GI>
<Attr position="-1" visible="false" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="64" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="true" x="85.0" y="68.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
<Attr4VanChartScatter>
<Type rangeLegendType="2"/>
<SectionLegend>
<MapHotAreaColor>
<MC_Attr minValue="100.0" maxValue="200.0" useType="1" areaNumber="3" mainColor="-14374913"/>
<ColorList>
<AreaColor>
<AC_Attr minValue="=1" maxValue="=0.8" color="-8265558"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=0.8" maxValue="=0.6" color="-14125914"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=0.6" maxValue="=0" color="-3456203"/>
</AreaColor>
</ColorList>
</MapHotAreaColor>
<LegendLabelFormat>
<IsCommon commonValueFormat="true"/>
</LegendLabelFormat>
</SectionLegend>
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
<VanChartMapPlotAttr mapType="custom" geourl="assets/map/geographic/world/中国.json" zoomlevel="0" mapmarkertype="1" markerTypeKey="scatter" autoNullValue="false" nullvaluecolor="-3355444"/>
<lineMapDataProcessor>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
</lineMapDataProcessor>
<GisLayer>
<Attr gislayer="null" layerName="无"/>
</GisLayer>
<ViewCenter auto="true" longitude="0.0" latitude="0.0"/>
<pointConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
<ConditionAttrList>
<List index="0">
<ConditionAttr name="条件属性1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="0.0" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${NAME}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${NAME}"/>
<params>
<![CDATA[{}]]></params>
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
<TableFieldCollection/>
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
<Attr enable="false"/>
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
<Condition class="com.fr.data.condition.ListCondition">
<JoinCondition join="0">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[1]]></CNUMBER>
<CNAME>
<![CDATA[AREA_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[西]]></O>
</Compare>
</Condition>
</JoinCondition>
<JoinCondition join="1">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[1]]></CNUMBER>
<CNAME>
<![CDATA[AREA_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[东]]></O>
</Compare>
</Condition>
</JoinCondition>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="条件属性2">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-6908266"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[VALUE]]></CNAME>
<Compare op="0">
<O>
<![CDATA[1]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</pointConditionCollection>
<lineConditionCollection>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
<ConditionAttrList>
<List index="0">
<ConditionAttr name="条件属性1">
<AttrList>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrCurve">
<AttrCurve>
<attr lineWidth="0.5" bending="30.0" alpha="100.0"/>
</AttrCurve>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[4]]></CNUMBER>
<CNAME>
<![CDATA[VALUE]]></CNAME>
<Compare op="3">
<O>
<![CDATA[0.8]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="条件属性2">
<AttrList>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrCurve">
<AttrCurve>
<attr lineWidth="1.0" bending="30.0" alpha="100.0"/>
</AttrCurve>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition">
<JoinCondition join="0">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[4]]></CNUMBER>
<CNAME>
<![CDATA[VALUE]]></CNAME>
<Compare op="3">
<O>
<![CDATA[0.7]]></O>
</Compare>
</Condition>
</JoinCondition>
<JoinCondition join="0">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[4]]></CNUMBER>
<CNAME>
<![CDATA[VALUE]]></CNAME>
<Compare op="4">
<O>
<![CDATA[0.8]]></O>
</Compare>
</Condition>
</JoinCondition>
</Condition>
</ConditionAttr>
</List>
<List index="2">
<ConditionAttr name="条件属性3">
<AttrList>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrCurve">
<AttrCurve>
<attr lineWidth="1.0" bending="30.0" alpha="100.0"/>
</AttrCurve>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition">
<JoinCondition join="0">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[4]]></CNUMBER>
<CNAME>
<![CDATA[VALUE]]></CNAME>
<Compare op="3">
<O>
<![CDATA[0.6]]></O>
</Compare>
</Condition>
</JoinCondition>
<JoinCondition join="0">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[4]]></CNUMBER>
<CNAME>
<![CDATA[VALUE]]></CNAME>
<Compare op="4">
<O>
<![CDATA[0.7]]></O>
</Compare>
</Condition>
</JoinCondition>
</Condition>
</ConditionAttr>
</List>
<List index="3">
<ConditionAttr name="条件属性4">
<AttrList>
<Attr class="com.fr.plugin.chart.map.line.condition.AttrCurve">
<AttrCurve>
<attr lineWidth="1.5" bending="30.0" alpha="100.0"/>
</AttrCurve>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[4]]></CNUMBER>
<CNAME>
<![CDATA[VALUE]]></CNAME>
<Compare op="4">
<O>
<![CDATA[0.6]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
</ConditionAttrList>
</ConditionCollection>
</lineConditionCollection>
<matchResult/>
</Plot>
<ChartDefinition>
<VanMapDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<areaDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[Embedded2]]></Name>
</TableData>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
<matchResult/>
</areaDefinition>
<pointDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[地图-点]]></Name>
</TableData>
<CategoryName value="航站"/>
<ChartSummaryColumn name="颜色" function="com.fr.plugin.chart.base.FirstFunction" customName="颜色"/>
</MoreNameCDDefinition>
<attr longitude="经度" latitude="纬度" endLongitude="" endLatitude="" useAreaName="false" endAreaName=""/>
<matchResult/>
</pointDefinition>
<lineDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[地图]]></Name>
</TableData>
<CategoryName value="起始地"/>
<ChartSummaryColumn name="主舱利用率" function="com.fr.data.util.function.NoneFunction" customName="主舱利用率"/>
</MoreNameCDDefinition>
<attr longitude="起始地经度" latitude="起始地纬度" endLongitude="目的地经度" endLatitude="目的地纬度" useAreaName="false" endAreaName="目的地"/>
<matchResult/>
</lineDefinition>
</VanMapDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="aa83a9e2-4882-4ac0-8ca1-3c010ea62f5b"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="false" zoomResize="true" zoomType="xy"/>
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
<StyleList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[[(L$R;pi$+*'g;jYotSk'VpRp!U3TM:a$)f8dSr/_#VnM&t2cM-j#9(6rY:k"GIC0KIS0tKG
L<h,TnD?&8D9"EcI^ucT->jj8T%*rt[_4NB-/Mms)lTA*"cYhF:CjY;cL^OL./ll2gr.X9nq
5SJU+pnK4r&\Hr8oPEkMa$g7#\8YTGSVWRMdRE-2um0=4NM=F6UVl#M9*L_.Nq#NMsgS`dB\
*Z4/G&rg@]AGVScW?>]A4R^qgBilHAe\aG=oS:tm+`bNT:F\4JD2t6V%6^!(0m`^i2s)CsnZ)*
4SZDQLKUcegrer*\crc&75?97ssEPcc[9J0k&:j+rAqHP0&1K3ZNBlQRQg44I]Ab4GYhqZ!.-
Y4oA@8W*>a%=<,:2jk0$4Y<0N9h7)p+&3apLhIUL4oUMcHu[UUG,Cc.8)2,?V\5^IhHU#.(R
`'AjaV+;^[K`YR59g!-[?YtKs@HK<,$p`518o3*=$U6Hi@1)`hcAI_6aKqIo='Fnb)2@IK(R
2itBm,kGu>X\^h\4AE4LHF[:Fi@=_+:ZnW1<dRqT>$p"cV,3:%DmZS,'NB`TsiK#m?f>=CPI
nn4EI`,`k0GqidN"#-L-RV*@%_t$k3u]Al[V"c?C$GX'A$"hJSa[t_MN@-GVX&jJtNqOd]As44
LTY8Nt2P[AK;i/%*r%>bTeMoKb4I%NQFa`!b=A6@/Tp3uVIGm\=CS&r"FcA0krGNRUMrHPrZ
<(0('N^c.`:cpsaC[Z1m-ApGH1VruXitpAGjm%-0$&6\er'\]AOSm5($Z)5_`]AMI!Qbi$kS<q
ccslRjGo-s5oh_fsiZ'cll^c`(Q#G>13QYc4MbL<'I*]A<16OVn#YR8A*R:gh2_5&Y>%t0VaZ
-[V5RWIl>oUZd?kTm6C%NreZuG+Zb*_Mdi^&qpUMS/6gPd)t#1$DQM5Gi>A9`NT(c]A6(#;m+
':FMdCaI$X>,L"T2>9C]AkOJNn,;D5G9ZeK2POXgdkOVmk,DUT*d,pVUu>'YV'bYXe(h%\28i
AbLHd<kead*gSAf6gWp%?-F$;J'j)\K>SInJ)AnRZY6kj^^-O7<*$q6*RP>L]As\NQ!CTP2@T
VeE[ISBWNWMs*:7qnpkmK&iYQP$/+mM''6#q<]Ac?n.X@\n.R(LQ+8A@r0IAb[c?.5%l<Fk6O
W/uIQd6NE\L-coqd("oeD?LU3?RS&uI*&C`h+N`2UJ0K&sG;hI^A4[:1MI%Y]ABXSZP??#Odf
cpfo<"EF!6S2a,pHQV$mJ4Ia)fD4G'F<3Tf=:WR-F;s_!JG=c$]A<mB#kc,I,*(8"^8Sq.Ddb
2;"D$ebOj:@GN/htr%T]A(\el>Q0,3cY.#mp<`Z1ft,rC\,hQWXtP.)C]A1uKe#8[<4%85!IJ`
tET_9dE/2niMp0Su<fs4$qC1[?!0T+%Uj#O2^g$:V_kiIZojjS+nb_,uA6W;(Bg(iI*O0cD/
0oY1!>0Ad-Tl$l8?G2Z:2U!<%.lD+/#!J_T"#ddleRA@1ih%@;;0]AuQ#7a-Tin$]Ab)@4K^$d
I0VKf47:!200i47ANhqAAoP/W[cJ8b%2HA`9E9gplIc_F_H2W<T"mQ*u,@N_%XR5VM;u[OPC
(q$+&(JFADKSnlPN,ZsJ?jEb<.m;ehOdS:SM//u-]A^*lrKB8,dj0+m6Z\'F@/HI&-^Y6QH^!
*lM9oL*uuOp;8nc%^koY$NV?id?J5P'>/W`_c$s^LGmd4I't%04@+Sr7$"fODXaSVl1MDl=S
BjZm:diBeqRD$RSdhW+akIV&?T;`n#VAG2"+:fZ>-VSMtS>S4(1coLPm3G*^:g2G<^:VZcmO
J&-BS%K$ca3SLsEC9Jn0Ju&K%#?gL2>ieDX.Rculk#U@MfB$WH=@0$cVe:DBe(5]AN&se?YcM
gD=&Hk).=VgX17*u;JV&"HEX>WUjhIim,E9)Q@\&j;V!!!#Y[*Yb33tFq0dZ,C,B-h3&L4_L
@T!J#=J3'L'E6PVWF--dd7=LkEccqlfiiRBUJEh_=U*j`X0/6BcXf]AZBc"lpckF20ac3doeR
orJeScSmkrl1WK=L&W5L%dON'fg%7WtHY2!P@gIdI(D7`lY?+,L1R1FlNB`OZ(u+<>>Lm]A^p
"ZqX(!(!ESR@4ia]A".1*Q#,1`gU%5#dg(RZ`+dW[Wrq,oO9lC7ji3mSc>.sGj@ekSOh=,)b`
0Kmi_D>'f+kNJIX@NJ^qE>Y!Jk:$#"BE@DJkGp`n<lGR>bk[jS@(2be-4IQbm8t!gI<>o_8%
a"fN_r6cJrYkV+3I$44!0R;a&ePs%q4/.`HI%aUj@DhBL4Yk=Vbt%P@hbP[pe`,Mc!b;CA`3
hYgk>N&nI'/HKVml)Oe9JXg2&I)_8G*lY=$p+Js5MS'lW7!e_;38E^FOd9[otbs/.\DSqnt0
^jV\`"ZL-H)Tl&W#'=nTh.,I/.m@LlI&H,i$._"A"SSJGTJg6Cu4eG!'k^tVXP]Ar#usb@%VC
qUa<u/o-mom0h!XO2G*#1ioiX'Pbkf>_WMVWT^q.<ZI>P<3JdgB!Z1GuEO@q6Gc2G8Jl:'*%
"Fd+[qt'r@Z+<tDUmtJV86:&AB.U>_!&/O58p?>dIbP9_=*V=hg"i`0="$MUDOGgE-p->Om5
=cP22/ahs*AbnL1:(1bJ5sq%8r&V:>ob0D-:qhX-Im7*S.(ien9R8A"#*7[`69IQJl1MOU&5
'ArTUo#/ln-B=Vln07JHD5.)6k:lE"\P0"j89("N!bcQQ3bRs#rBL@<ejo#,k"5=Bn_BDA>a
:T0-S]A.<]AcumeNjhE?r3RRi;Y4J5+?A/qu163AWW`I9&(?Z'T/HV\q@[U#2$2X]A&e8'(*P&V
,F?Q-2cL%qkA+FbN(BV\n%f-L*O%I.O.>AHEmY>-7HZV@#2q:55_-qDjfObgrnSGse0Rilh>
_"pYhD4&uj!2+aXE+[FYn9k"Picob(Qh"]A3e^ENo?Qa?"H$O[rAW&sUFRt/;ql2L21**`.It
UO##283FS&gTC`S,5ONf`08n)s:sNns*YEGiCZ@KDF5ou:nhGHNP*!S";I7%24*La9/UV$BO
3qYM_MF;*es*f$>Q"IMjN^9OC\SALG=l*f=-LVu^RI1/TnBUNI(]AT>M\??cS6?E"rPPFRZoG
/rlOK2PO[N&a=#XS3q%k[0Lp7^B@:)(ZX9o0auq".m9'F6aNg5dshufsaU9jUi7]A:"TOM1iZ
G>RsgVFaKf)ADZjmP(0g6h;q-@8!5N,%;J@n;j7/eRd^KUTCilfb>g#.&?DPf<8u8FDo7JaG
'*Tk2.bU?r%4+h9@GUgn9[5,52>iWV=>Qj%aXm>nH13f.4Tn<T520gB[pe#M\':C_!.ZTg:A
^Y+j_H;t<%GjK3J/<@40NE7M'O^E]Ao?A[U(]AU6do3g5K^PU=Qj*T,kWQa3`lcMf55%.oC::Y
#_?*7K4`1WLU`dRcMXiL9l7hq3U*TcC\5H4Kh@-*2"N9X-p[(;$chgU]A\2/OH19QLD.ZY2E[
/elKq\R3Ning5Z`hUS2.40SRf$"u^]Ae<0@KWIR^=UbSaHiC<eS#`R<*I>%9?mK%qr12Xpjr#
?44br3:>I4oIDKhEHPHR&a^NK.>$e7ZK@Qg4D9Fk<qeY[H4FI^]AgaYuQJk#[/c"u9\*q$UkL
lffsX5s]Aref5i*tb="6DI7B_2>M&9DqBrq%iI-:%`%"ZA@4T>G$Z+s-J1b4,\oo"n1V]A'uS_
5!(ZkMZFYc1bIB_F9Sd]AC`15\mW/9^%`!M"*onE9Dp6MGBLf[]AeGchj_4HVa+VbYPMQW5.1)
_[VW3DeaNXfBOC!/q$[j#M(hPaD*`B.>-5NoI]A0eX;K]Ah7cp*?\T#*=@Bp@^lX&&B5h^Ci;a
T?X`d(.,1:48_0kT\O.lhX%VF9b0g_R)5Uof)]AZKR]Ap"#CEoXF>_.?lY<N!MLW=8Gm'tf%[E
AFa>JAMGbs#MB%PA2+P&`+XglfuK!'k\lE9OOW6iL+oHF$oVJ8tq\b2n@]ArC3]AJUX"]AWSF9/
&W_<4Bpb'VV/"KTT[<#knu2cMYlaI^pc\X`P,,Oe:VJ9l!L55C<8.FUIQcX\p2PHR7:.HHBZ
c2r^A)BNSc<CNOKCI`?UiBCaR-MR"VptMdZa6po&>Ut\HRRHqH`>.PileQ^n%1L02.mAA&53
g/Sd?WrcGF9$!fh>>jlmqTniRj"fSgE+;IRDU;#=g[ReV?kHrLBOYVD!'Ti6<:[_T4"%UCek
&mJiJV'*B'+:K]AT(`@_e%(<"Ig!C<SDp*8Y4(;p=,che$OL'd%B/Di9'M-VP87#$[n.sco-H
UhMU/H5Ga36P)l9n&hc!'XVNi`IgCM/$5d7f5fQ8GY>KKuO$8?NLQlZ=C2pB;BM)$WNO-9QN
r"<(ZAhfNkH1kk,)olP1N!U==Qib57=J)`$YpX]Ag=Z!`!"L>pk/#/e4;d?Yo+2mc]Ar,FRQ-#
hFOXNr#dEr*0l?s:.g4o-jIJ'ZNA^19PiDLZfq&(Hm[^2P^-\u005/-7/@flVGMjRcSj\M\A
5a&0FKU_+?__[VR<0JlQ+8^dC!@RY"NB?3t;`_+oT$0LBn!\Z0KI#-dR`35K>K=PtpG.lHXm
"#gY1[fMX[u,u^>!2c7-/IDU/b:ihQ/e6nLkRCCE25h*CX>6<"HbU[Q]A:@3b-R6BC(0`aSk5
h.>mm"()jg:b?XK0><SFS>9TF/=cA:H>fC7_-DjX>(g"REo!cA<]A_!+t,-Nmb4&@#g^\_#BP
Up!+<dm6R&!N0(b-teBhr"L8*aZ,[]Ak.$(^-bO-W+RW^?@2Yq7+C%hl:9GcC#=:/PU[jgDr6
cag87*qN'K'27Ea>5#NtXmr>QL^m]AY+@]A00>S+j!SFg3sc8NdoUG^jlL8mcjUPYZM*l!%q>V
X6XVgC,&//lVsNZQ]AT[2(UpK\8J:IBikmO>FPdT'0g(bYrl)`(]Am<m*USBLM5$Nj&n2:d<Fl
@f=;&gOhY/#*[8lD6R\49q:r-$l'9Buj_Z^RScBSgaDX;CND0pt0u;X8/3H=(W$:G;,ekf9.
TiS:rV',STZ)@IlT2`lc-'AW9JTFQanO$^M'67s+?-"jV5Z>iYO<\qf&!L=G9'VLC;E<bTl2
&]AF1ci71EW/Ei!D?fZcV+%_N;*/uKRW.[+>`s1Z?JBo:N9cc\YNRrra\;ts6h"-9"jns.?D9
W]AKO?5<VQD^HrH+,L&1Ve6&aa8BYR16XHWNFFP0r+O\*!;<;`qo<M,OUL.QL/tSTfXuO=`)d
Zm*[QGCtBtpBF=qHYl07L=g7iMI:!/)^$CoU19QP0F(L@\rqoM3FLE-6'A_3LqM5"WfW5O<N
,Ca+h!]Aa0)933BX:&"p5F9,tV;@(',85=\OHg(N7/^N#Di_[E6*#loU68Zm1A-Dcn>!@d7&k
Gf(9Sk1V)2+PlRf5HcefriT?p6W!3"0P1K<_3WkIc%4dt;S@rI?M#3GGP+9s"%7Q]ATbFHCtb
HVDcB(8D>g(3>9PTU't'IZ\l",)XfT@!))NI%_fb4#%iRQdsEdm7$>G&>!&*mqG`a!'<=Q*K
V^Tpi-RfRrP>,_Z/Ou3ctenfpcKYkA+<&a`TYk+*!TZP+ET/S66#3n!Dn;G5UUWO]A)TIFG9b
l/E^,NM-G\`qYBSQh(E?+Zb!;OJU./IRBBp6'cFR,XsV0391QWh9C.0ti$Op>VV159S([>Zn
3RJ&WeCqJ(ZX7PaEo/A_7M+"m2F97"_.\*'?mqp^RcDCh7<^OG"2a'p$lfXF!k$<r-KSIT<r
?1ZO`lX*cA,^EDA>e)%[<=*/UVV4@mt904;HJ`c(BcH#FVI=LLVeMi'O5>i)Vt\PLH3G>DUi
Y%4i*R0jgrhS!)R7Po`,h?SX3!fH@>R@V(@Y1u>iDoh:NYX>qqVPh4"FNUJ9pY$>pDS8#Y_(
8u.)H]A',]A\jZB2Esan1@;(84,PHor!NH9@$'#qXB/K3k5[CMF@SBd?hD=Z$VV2(&UaPZTPYr
7XP2I$*Ei%L#JBP5orfJ$F:i'h*t=JfF2Zl&#u#7u1&6C$.pNl>oA(eY>-3%Sbe#Shf[0XZM
n?<5N2[RU\i@EJ?H7QgHq+F.A&(lU<a5FS+<!HN#6Y*>M-00.E[+B><Q4^SU`-&b6M#BgXfC
ZfG.l07V2mTeA"l=*`[fqU'DZ2df\7Rj7ZI/QNes)[^%`MRLH*7OMHX^$/TEd(<:W_`;.[5,
FJJl\,SseNmiLlU;C-njRY@%!<m6;<-c(dB_Yg[lrqV48:42'Q.\WjD]ACXZgDKTbG3*d%WVg
1m7>sYFJb<uT*%61PuCXd=/n(iQBlKP*mOL!2sd$4)up0.2PR>VnibpcJ_<2:K5i.6<0@5MI
j'mjecoCU4=ZH8pE7(Q<'9?&e"CTmn]AF)fi46uLRX]A=03>bhYe_rSB90'-"#[(1"HQa1N:;[
K`;d^..Bo43&Gk!@&q2C9R!E1-8gS#+!=U.)%p.A!7_M^:LI6*OcT2\+\EQYu0OE-=9#//12
N8o'JUc^fIL2jZJrUcBmkB!f0<-!T&h?cHOtcarg4;`@D.InS-bd)V5OP;DTKgAKI3O7%WW,
2C_scN)bj=rjj*!,9.7lb;IPEbi%B`QL5m6#mACq[sQ#=OR0u/8DDt1$ug0)c"no`7JuEAn,
&:eN0f@34s?Yo,:4K)i?39?q+(?=A7.B>K+]A-5DHls1:IaR,O.uam#B+bK\<]Af]A8ZK'?")M=
/^>AGrRqWH+/\A;o@@o21p%UdddM'L<;LAiB2Sk-g_bMk7j_b!XXZ""eiEO/^10`tfYIVU1_
`QC7ndSfJNb9iS6*.;ZcNi+??3@-]AS?75cTh=IIK)`>fP;:[*HD-+ei&7pQC.AG6=T9ZA3tZ
)\Z"qH6ZoZH2b\<0lEqWq&/`ToR#.`%AeZ>F4_antXpGhbM$7eVMd.gh_P6pF+dU(VWe[`a!
YZb5iPPiA>B-RJ$^\t`'"l.t4[JD`U?XD=_6P\:.E>1b=L8r(,>Da9F^-FT(a.p/'Y?S,!/f
@6sW`,(0.7+:(FZiFTYo)>S9tZs%f*Is!P?0F`4^/BHL]A335^P4NV0RWq5kSA78*:VU0D_RK
eA_5,17TXWFlXSSMk^?kY,]A*?>U20dCg*PTcruQdppdOQ0L&9o:q1m0nN^i\^mhhH1o.Tia@
uMNRb6'[RiZc:!*$gbCD_DB6pMTb(!.+5b2SsOYY\kES>SB`n@$:Jo>Y)COC!I\aE/S=\!!T
E@j_qgc_bQq,-7aS9:RANLIh8sN:[KnldjmW?X?kJ-X.M%PQkriI[!QY%\dK^%A#VBl>4JkU
o!YFNi_9MRbB15@G.SZ'4,Xb54]AInR6Q4FGJ)U$^]A7,W%Va")<pH^J[a(P2Xbi7r[)j74=mN
u@W%T8G?QHd2@654Jq8R]A3E#p/)+.mL=Bhg(EPLcc3Dr2H2Z"%\^J6drkdYX@hZlBf;6q?:l
-:-C1U]Ag1aj_!eTKVp7"H(ZXb")H(>dEWH%$mY\3=c.==2</Fkb[0>\8BAB&Y6N]A:,'b4rIm
Au[g'^WhQeh4`^UhZ%Lc?WEY(bbJ'Q.669M9RD">:THEe?pr]AgSQ:PYEKVQ6CB2c=E60nGRn
_LWJV^`R(7M7)6V)>C49+YmVGo2XF,m&>1\Mp1b!-P_ede-)FlK+C[nC?KmXNp#%(KG?P&iU
g_j-OG=d\TbbV&51)6AGU2SgYq74#amT@94o>\8*aO;]ARQ#8h\gYq"aMdf(,?1Zid1.m?g[,
r6J1HP,mG#c-hhB7eAUm"aQ)<[hr9**+o1\Ck.hLn(@UPjt:07C=<DXNlr0rS=5\_4h5P!+q
CR@hqKVgj`8,Acf/*9EKR+!lft#G:OIl@Ll@!,!h^kZJ)KWZ]Agri0eP(<`Xeo$/M.`aRCnY:
4$.U8?%UYP_o[0S1Jd9LH?AO-'[m%Fb:b%)8;3a4?9rkX`[q*/Z"__3c!Ec/EBao,("h^@;;
;/20U)[c,(I4Prc/r-Q-\2M$<bJ<8Q`b:KD7cZbsR[*U\qcf_&!id>ML`Ek["s,rT;.s!Z?!
_gn2@$At+,dHWFTcrLHPX+D2iVLE55.l<M>JtUY1GF.7@POlA']A*+/!^,#<U]AhF=Q=^[6P]Ag
7LIa=:]AnH2ta5b"*(bY;>S*F5`YdVP<%8l=9Q[]A#IJ=MA?B@W334O-;`jdIF"r5PlHkAfXPa
"W"@<kZ-YeZB%'n5$DA`T_d^^j\Ka'7P?;%NgUVW-EQkEba$aCcpknm5SsnQ6d:0(6I4E/W)
*7>ri[LFkYd(g-Ri-Kg<%pq`C_019Xt(-=:0G#Q!<(%0Q1idR*)1KLl5,XE"?:2ak0rfbBAR
!kmZOmV7I#1u__b#5lPY3@4YD0pqqND+nU,BCd^Hf^TV/6NK)TpA4)FK[S^2L_RkNpA3c\Pg
\f/c2<:K_LAf49XG5l(1m%-GQf@cs!PjsfEC//SlYr[TX??T[r^/%0DeNru?nK$EWR!hN_W0
NakauqAT3n)$IV/o7Pc*PO9XO8^9GRXPK9i^%JYJa^0jsm\4Z;tc<e6W$2-;MHh]A'R]AY5&Tf
DNjrk3VLn'*(\bGsOXeT@&@pb6hebCJp$9]A.QW@nR;OU$4U?p;MUJ04<"fui<YV"E;Iiu,S/
8o".gM\ID%)%[`<$f<9ShG4BBu\`c#[Y&&MR*j"p3HYtA.kuOG):O.odj0^fIEluIcrD5#_"
ZdQ"[N@5]AgPJb?Q1<DTfC^<#'%+G8-KqZ?RV+lR6o[I_f[?i2be4.JUeWQ;L&#:mFnoWTaR'
`O+hJE_ZChb:Q-jV4?prYDrNpoB=7U(<ik`KanO6+J0ICc]AeU]AH)9'K8Xm.3<_"*C?H2Ej?k
eVf8>TV=dRcs8$!etq<^N?X>>HPZER-,`SLe!$!Y\@XXDCs^D#)+*6R%i$3lV&Qb`>%JS,*Z
a`"Xe=<Yh:`c;'MXEXBUkEB3ic4fc6kbtKG3Afi&R\rO=O0PIb*"nC(riWiC??S5BB!L=Q\<
^1T1Z44Xq3uIt?jOJus>(="kimmVeMj"j[TlmrdV(aoQ*NsG4-2e,`CD9Il.T9*#=-4,O>_>
#MXcO@#k&O03lH.Fc=E.-#TbRlC$El&[8UTgg+-XJrEE/LP?H%A98DT8GY@aj_VVQYqVEt-j
:dS.3%GL%T9OZ76d^J8F0ChP0Xet"@&Y$Kd+?3D]Ak_A@B-.=cn*aA<0%Y)W8_*o<qf"@d8Is
4_B6LXGns,=T,NOC1<-<r2.'=ec80tsGO#s8=Y+dC:<Y8oiTD'M'pr)$9;0\))Y,8?bBYtu5
=GI6h;W7G0thOlN9!HC-AK,I01ImJB%Q0<pn$-+c-&?6Xji:]A5"07b3Trs0e,l:#'hMB&6<e
%$cKisp%Z:fPt\$T:im.DsS\3%o;(-\&#jnb@'AM%(2sp\\8q+WcsZ(.fNNhhD]A!:?TZ>OqU
a6S\oRjMsG'?3:W"LU#S(<3m:4<X"X7+oFsiFWU<;WoJDGKQ5Pm(/&)72s'RjZl.)iu_W(4U
l%_4&9lb8+erQj;[HJ?C[VVZ;0hSV2>pJ$<QjZhg+7%ONm<B0IW,>R`C*kuYf7Ac;rcgUG.C
C7i(kMo(N1Cd>U(1DX&QX3GmaKi!fLeHO@Y\d%6TuGm56",rMuh4!9MDZLf^WL8q5giGVPoB
=<i_k+^h':^06EMr6fX4D_B(O]A$/:bp]A`+I`$TfX`NM66(f(eW8%=MI)gNQYaV)E)dqg[Dsa
eVo"mRjnM.VY@f*CNn!+*Jq3WZ/%df\UglRE&k_0Qc>bO7$^&=#fk^3,L2**&#H(B5HLm<&e
*pG2BSSparT-jEA95Ij6el)]AfKf*P/HPU@adIOEQ:BGZ-Z0Q24\ARi4?+bm:cJAXm.7Td_=b
[uRqj4*gH]A&T;kfD0*/ADW_)t@rGU&mFn:@h9heY=UMJ>E_r00?7M-@QmF\Fb=1ENoskN=9k
r@4F'jB19<$@.WO[G'`:j%91-(KiG`FHu)m4`_MTGh@]AA)5[Dst&^@miE*SYuYp\Zj!:GPAs
/mtGnH;2ema`Q3R0ImRt]AdA^-<IX"C8FsOWRmj3a^E/_JP'DWHt&O),!Gq*s6cDm<#[[_\U>
3g9ulFOr%EE24lB't5fKARQn,]AT[?2)=]A$\/SDW*;`-^Hh(kCdeMb)SR^Z=*HoQns'/06hcE
=VW.2"#.o8IZ2-]AeG^m#p_cWrHa/=1l\MNj;Gi#iQ*&(=;N@-6YM0j-M^fl7s]ADr^CY%JVM?
8('<[DpB<=WJ=RMdEN&'JoJG3NH)=:"bc]A.cLnMYb(/#TBo4K1&B;mN<@E^/fP`,+2!6o%;h
H-rZ0DtZG*T_2@KLNG%3$tj#JIfjM-\0;bW/2lGCF2qcH)CpN\c'7a]A[OB[d"&=MJF\KrXe=
$)*)q&ba:/7XNeHWC&#MY2[!$s-HTW\mYu2!]AV26r5LX8]AhM6hOD0Njn`SG`5l9+--l:YAsB
DdQp]AJOU@McamkM-`[ign==aKJV[XbH6TqS-_4\K"OtPRF(^Ts,Mi#9&>X4T7TPJs&5[*&jK
Jtq";>(cIg_-KVmh/H]AbdcC>\?2KFbDEMj!UD!@5Apb'X9Jk4q_ubcYI.FBkDW+dBqa?guWG
ouKVD<^h#On!U'TK6HdaC&fW6::uXE/5o:bgNK:'d6f5g-hC45IMXj)D==`9<%N1ElUu#"/#
OYufFt=u;\Q7b3o%&u[GSf]ARuT;W[is_%JLZXHF9D<Bp52t\W1j5r"`C?MpXQ=>qiVn+aPM3
8i+hf50etH2,ZhWT@30ml<g2?n!Rs]A'<.FhGX.iO03K/JfTK!49#1_?pfA\AXH9D&O*`r/##
D]An%0.ioUcPTlFgqLgmXYP1Rgf-<5p:qr[h!tM=02XmO8gBeWQ(mBXFI^srim:o)#P;,&9@l
5jR6W>5IIa\na7Lm@=6jnULVs0Af,.]AKbQ)3UD18pIC[T<Zj:q)Bcc5"6:$-d:Wp-VA;R<\k
[t6a-R--jF,(ho`,=D+DA5]A#L9O><kJZWcPT'POj(ht7CPs*d-*;INaR:t3S4C:YJiN^<PBO
2rKAe%"Q2er$BE7E9N"@[c9kK/P<of9f=e]A!Q`DPs2qCVW0V>U$:*rHa'rg\FY\PqKMrQV)A
;XanlK"bERrKi^c$9hS8g/.I-7fS%'OjdnE1I_WV$\MZ>$ED5>MQ/H.d]AuP=d)be-C]AE4i[6
Z`]AHl\`EG/meRM0dH;!.Wpmh6JTI)BL<DB033/*>iIZ^O31]A52X4Ebk?pP$6s'1[XIl?D9<=
$A=]AL(d[-^bM@IC9(`DL_ET*]A::LCPKjYi,.so(2Z[o)7G#AFB/)p"Aj]AaHs6)@&U4o:TRhp
efX_6L8#2;4NK.uSqLOWa%2.pAS,aO/1gak,3M,\fpl`d(F^A&NOl>T^J%2@BA@Cb3dX=6-B
A?-p^N:GREbB)hn)[MT)=0J^]AreMfT4@]ANE9C;jQu$dBGQj4A;06ZjO@P>G%-nGSds<uEj;N
F907X]AXBn)ke\\mJ1NP"q(!DNoqLqtp0J':.!S/-HA.Z2qAm?p9lT<_3?fPI3@5C".mFNTqU
raM@/)mo$DTK^A68\\$P"e1/U>aVlrPJ<B8&h&OQL!B'&R5hZ[JGOtT_Z]AB_N$Ym<U<=/e!I
8[hr!9Q2pNn^HB"PU`Wk2%M4k;N4(s/d'X=n>]A:O=%g/Ku&S"K'sq`0CL?Z:A,&2\s#'0%:h
3$Q!=g0Z["qdjQT<X3XpS)g6daC,ns7)-<X;H@H6Sb=F9U*%3GW9"\_n7g017h!3leT75Z3a
tF&22K#M8/4Yl6slnr83[gbbD9n*+q=W6I\\[$*UL3d;bH.uX>"MnF.]A*g)S(KJ74O$dNKUn
88t<c:GOtZMk,l79&_Y2bMt^BG=enf!-ZV31Lu9D]AhC-0/oUsgH^BA/uHE4:@:/cEK%g.`NX
qr5>N\?pO$\>4*r61XM9<O4`&hL:Wk`q_%>4T(HRJJkL_4-9.<(7=U`:_>UR%8n7R[g%oA/"
"1_@Q6V#jLR0;f2^K$6S!II`oDRqo]AcI?DGd/fX:#3\Yu.f^SYqX*^)H9a(bm,KB']AZ1$<Pa
ZV)"RZaD36>cg'X?UfT]ACMKRHnl-ZZTpC)'#<+)6YjAESJGOoZ;WM@S8kQu3]AoXF+Da\VQ?]A
B4i=r`9@G(N,j@8MZrX!!E/gVY0$KH\7@eg#N7TEr="-Y]AT<WHpR+?]A;0c;@X+"D%od8gL%*
@<?o3m^\N1N;G"dW0O-dU:E*%7d7ed7Faf+]A<!Mh/3J4Yaim$J2W53!(;IAk<8B3d6+;(Z(&
s3<gk%bT3;CYSkf$_"r1K?X85iP_A>Ob%S,0m8?]A:o,Y2B0+cJWeXp3Q6%pmsMKA9HmM57^'
1^GRQoLEHBOY&sJHaPE)u]A&T:fUjln2,eY)so[jF!ar+$i308$SS'r?#=>o`n4D002L^W%>S
j_k8BLD77-h>J7?kHM'F.F>q\,nl_k^^g'i^[aRbooSeh);=J"J+hDc1Fm&ZV#au<@hW$[]Al
IbogKB-hc]A'0EZc-<519U,YW2ME*b?T3t]A5Gq#B2K(E=Y)Eb#&OnqOpD.HW(plejpsCcE0q4
Gj&.+kHT#.cO]At_S+b9A]AN4uVq.&K@%n";!`'\_fu.WH'4YpE9'ga`iYg2j]AL_#`QRVi\u7K
nDCKAi'TcXV1@AmpJ[]A7le)VgrU6QTC<pkT?!+7C_`[XEfu"mr@AJ'12oPNgZQ,/S=)1UDk]A
?WZ%YKh"GAT@EqN>->Gb^d":8eN-"2M<XPRE:hd6dG?^OV98-Y5pbJ9o:r#&"\dGRUM:Y$&R
Q>tki4-"cL9q]AcT,t?s^I[Mh2Y(PaA#R`%f#<EK,V(Un<om=_6'/L5gL,J^3BgjM3X^VY9(J
<oep"/7WAgn^[0%YjJ4EP_=[.*O;Y]A-q[mJLVRT.>Y^+n,P3AtKfV]AZ3?bR<HlLje4]AZB[.G
%WX\Z3d%mH`CL:kTmil#*/+f,`5!eMc?M)O4A##@^1S_EHr\?q!SY,8ceuL%\T5Y/g_7ort*
IE`&c@CJeQ)RUD-qe0SCeidcB9EiR(DX#ILV)S^U61?.i:s7a+,M2-[c,)Q6W$3PnSh4%4UH
QrA`n!+Klif*Zo##G8l-HFW"+"IAY1#e.PgYg]ACO,$BQg/>_u'n;jE,2gSU'W([C#0I@H@p]A
(W)eD.c<XGm-97BjpuE]Ag3&nN^]AfA,IRLS^3U)P>^6k`>=[E:@JN=)JOR(BTb&PXaJ[?[WJp
,X9o&-Uan<fsHf!*V)W]AXmQANH+n'ePfF#Y!M/9=RmW@t6k7pamaOmd-p"7.-b&dH&0S=!Qj
Kn(oaGhR>[[B/bh3ES\=-;rut^nQ)1`1^=U7m07B9oJKkEVG>1".cd?6jBSB*(nH;/3QRMXR
0u"=`_,C$ZR$]AciC]AW)4l)bpe:+hjlEKCOpNe;TU%N/TcVo-7dlL$apTlJk_SjP(:N'eon]Ab
bIo/<SaVbH7,VPeLE.JpMT@C/)MJTKJSF3k9OgM'h[Y,Yt6PP59n"rG23]A+2oO,Z/%0V=$*r
bPs[u+^"[m87kZd"52W?"JM)cq'[`XUb'F$fqapm\_jOG]A4\`/JJF:U5$V@t;o8P9Y"g0<6*
oVje<Q!.O&Go=/B"DE-OCB!!c[sVoPG5Nq@''14cc:4;9MG6NDqs^#EI]An+iB6`#t/5E@jk2
Q@YNAs#I`>4U\KuV'-fue1ZB1U]AEO;$Ej''3'ZRUL$V8X/e>ahi\i-$+f[X;J!54[=ZjjSY)
RqFphNj3Mf?#2q:BS'G3>5'mr"ZYB?3='/LC_Ii4GpYb\iFj`[CSmk47rUt_QruZ:1*4BJtS
%3=")'9au9!jhn6JZ-0!+_e29i`TD\D@lnEK,lIQOL``\5?%9W8DZek)iSAcF#T\\69b0Q8U
!nLHBDWRHYG-g7tMm#!P&EpX@f5FRb_llh\h9/5krQ_3)s8<J#Ga3?tjfsj=mp]A&qOCY)\kb
'urWf5FG3oLN\`]Ab36s1Pd(GbYE8#4_ePBgGjRk2@e@T6#/>%uLeXjl<\dhG_*ACejLiA`n6
r((YKd;ebj,A>iildRD!K8JtSm!t6r#Sq^FW>iNe2:E3!TiqQ0m2`"7+q!'1(ntrSHjEW\Ic
p2ZVp'TFl6&@HH\p.WO2Qi<P.6jp?QZCrLQ?AYBPeumlOLM1R^qC)k!p[/QVuuqflmQclL2V
/.C%RMa>*Ec:bLeOl0t^oF4]AN^06G'8.YF4j<RZi&o`.%-OV]A5P*]AM1[#42$n#Eg`2!Rj']Al
R`;<-]A-h92h?DbhGblb@+0SqN3KKm1]A<M\I&]A<]Ag6_N`p4oB>h_(N@ign44.+TZn\Gs$'CpJ
I?:'.+*/,^;#E,l@l"8(u5,r)r"?pHbhaO4.JHIEac`j<m!99<A^,['c]AgbM+n(%HMk?b(o:
#T'X&;eZ&HU*+.@PYPnP1>-mYQAuPtE`1CuWXi`[1p`.?Ce6mEDq1T2p>d2(0*hYRUjmW&kd
4@DZk,JeL;7/fM4qJCNq'kpbLA"Iii=6-'PgBF`5>D/iR&&_!'[3c*OY"JULQ-TtpY;#+bPl
K5M&r2#^_-/)4E/1$JesAd^QT]AJj[gn8(=tu-R'n6`Ak\#]AFX!IRl*'ZZHHYpkpru:oUkc+:
Gm^"i6q)d@^ffN8/_lSTL:?6PIU-F#3!\tpc3TAIU]A_MhL<.#$aLT^4)T7s\[XgC1]A>+*C_T
*79<B=W_.Y\e>,9MX3R"mm<3Khp\ZX\:&.EU%s1Wu$oS:G%GV?n;3@_D#S71(R"XimaiS&n\
2jk#mERst'H7^?c$7Bl`f:-(V!b_7TPSq-T4k`h.?m+QeC?A^&*?kDbnUi9.(*_Uo/:lUTdm
T9.3?-&4K^SX\\S+aQXHRg`4luARu/[#JmPkX!F[qCmphDP",_FXZjehUOq]AfZl7Ec#=_%X$
(FWIJ%c-MDfUoFNm@!g2BTB1*ufh8L$@]A)9dQTjVba4Q18ZV.q6t'Vb;Oe#ou.AG;]AKi&)$S
$8KNg_3Db$a@Vt$PkurGRXVc/JP.C[Ym+d^]AV*@,_r/>+)87]AcUssX!dM9:(9[*F:'J9!lK4
+XM]A.RoD0Jn4QUK&DUYa9O@0YpX3gJ%N;.N:O[ct86"\r4,\[(shuIeJ*ePRP1_Uf&Z)".6N
0@H5Q43<u-'5]Aam=i*W^.R^7ufjo&]A&c,W<$k(J0)2<FL`"]ADb67rRDQVkFnGR@s)8Bqj&sh
G9Ga*sR]A0ht/?lo%(BFT0m)KDoMOSp:1dJa*"(o^"AIEj%eqR#uT7.GCT8)enO?'a`*U:]A+'
(TM5ckAB0_<l_t'=unP?%$8@m-bZ"VXl^)J,<DuA@H2N+/K*hq=Ih7I1Aj3fhBX!kBo6r?%:
ZhgMqIZC&sVKUYK00b!0'g((Gg*@7EfX-WC&Z>moD`Rt47q)%2T5jc!p!<0N8pVI?T*=P%:@
[8[VS5TeHnMHE5_M\h/q$kPE<h<^CuM9F$8>#pU2.5eg)3d#?:MNR5At]Aak*;_iVGP#d(*,!
u4aX/X"?"TaY3F%$9:-jni#pqg(Mgtcb1p:+2e*2o(;'@$B41mW<i6:`IdXERO)6V"?[QgE\
T?pWfq?3aHZ'@d1lo]A<FN`m_G>]AO[=pAKrAE@D)IDAMeRAdhSWs%Nj`FI<5;2/dJ8"CI!V_k
5ZlKZ:CB#NgmrYHr-X/Ys:n85/S0Vn[B]A4?$D@mYh9&aI/GL&$YJ6R^'N?D0IrpNr9SkbLQH
V_,%q"2_VA0f]AqRg>Vjh@GU[Z5$Y7LV(I$jJMmD"UE#\MeiSRR'`mQTn09IOa3m^RI6t^f\e
GA@DO&:0htI!/!\4I]A3E;./`]A(UUl8SPZ>2Ai26+`:-$l[4>_,0\Z_.r7`Lm\+_Xn?1W"B9e
#p?'SXYP-I.\u>,iQZNf`l"YtZ57Met]Al=bVd=10cS:6*rA$ZJ8d\^5FR<Pq#NbB^k_U,DQP
4Hfb?*ONYUPO3[?MWCk#/fOK:!msP7,nH5',Y+o&C!$MOaGO2a/glDJ=i;[mSCIVkWRD^[ls
UJp'%0>bWU'V./%`Bd?MoQV,Y-*ni^dWG,a9eINA>TlN"FE.YI(lV.AL(I!q]Alk$_Db6eU64
qX(@a/t*.Y%TBt*c`]Al3g7jH8KJg6\*0ClZ(`:C-hTe\,Ba))hS8E]APZ1tIXmCQ#%U`gU,R^
B05ec;&mrqW*MMeqMu+f-1P=)J#-P0\AL*jJM*Pf3$Ep[,Ve5)&#@WT(kR?aDjn^u5^k))P^
R/O*nQ4mX(tFAb_HDQ^[8oZ/2I"SYo8+l`#2A5(6me=a0K[3`;G2rK#\K;MBll%9VMpf(!W&
scWR*Ta8I_R%paVJuFr93&l7;,n#'<Me\g((m5S8gOirCc.>]AlJ[Un3g2)L5<,Ppp>gVUh.E
m6W_[C(9-`Tpl7HDbK*.@GT_:F%%<R+US@mG@Q*7VSh4&fQ),-Hbb0Mtd>M6qJ[mmp/_mt@\
VtAZ]AYC\BAglN*9<Z'X@5%ecbJVgNq`I0Yg_]Ac4f;"aR(X'`t5@HBW$`:rEc/5LUtB,#Nsat
K<fG0%/B=:YtdG?Y%@O%q5G:Ub'nP239j>\/8DIRmn(jfsRO"OWdu6L_&;QY($N9McI16?Ob
7L%$TJ1kcV-b0-Z?oEA/N9G'n_q.3;3!+l2pX,N+aQ7$)Rc$j=j"DkO`D$JDGmf0d^JP%/#H
i#'o+kY0Z[:mLk?Rd@U)QX0o8EmDbi,V2G3;D)Plm?K?(BD3tSg'l^PR\%hRcI/5BF*(B"Ra
JlK"8ClEN^uXO0q/l^U2^ll:"eDc$.0Y]A>IBknmh9%@a.2&LY!8(#2Z5=4BN/]An-^.DI+npC
.93P#^m'cu`#p>EM`-q]A3,FWhHqn'-`m#>;HJS_Nqau(0&lJ1:LF%OJ<nW\:F0Q+ePR9"K<U
Sc]Ae+3@YaQfbf0.^g6.h>;-MgXb,2_-cCfa\((r0?'P6aP]A?_h1MYXVIZAU,dGOT<b4.B9#l
iVEELfVsk5pD_dC\#c)$)f^>b3^CN!EgeLnBlaJ1t%p;Aj>RLGG#4^dOBhR,77l5,i1mdC(C
7mLc#=cIg72W?>Q*(LU3omujGY$``#E)u4S9a.W:rfF^2!&MCQC1MrkIY>R-?skA5;anWXWa
^paV->OH8KO\%j%kVOK=jnCd%Ni1KrqKio<+[I@l""NuaU(<@`.+[[2`>.G"u,&?VXT=*'b4
cN8=YC/nlM/C4+=0$(.+=t'p2Ip'n3;I-%F1T5TS8*p@pXRA`t@)VgNU#uS^C/U+pQZS\;UJ
MN?kS-f;3+=Q,BnN7X;1M[NOYN?_[gjX\EidaIphc/l8JussJAa-j?3mZRc]AfC-a%;UYVHJq
F/ZN^#7!q*%gEYDFLZFjEf=.56!,&oc"I&#F9fbtkk"[;EZF_jY8Df(\FGrS/!;1Bb&f"*PK
R=L4*WE)4-KJ)5Q5d>)KR2sVjEEEc)8#d`%FS(8M\biEDYr\k1<o/KS[U!D2XaD0+7BCEnpX
J<0un[p4r31F^72,ePt"JpRNB[\^/Y5a)6N5o%$`;h!73&ejE",W1'<.Or,B5TMeWnDFP<N"
qFU9DpnMBe/U_IBQ?tc^2T\Lb1)r5&X(e5*<*AP'rRJaI7.I1^>4D)/-4G1C6Y=H,`a\,"W6
I\5dlRc"p`="-?+I4\GRSdqh^h`4rI(Z:_a)4p#It6%5"mjOCpHA^N/S,uSEjlS\rt!`^PtV
%Hg9^R$W^THb\7ks'uF$kjCQmXIYkDPau4>[!AbgR$@-QRF'pM2!;N6I/50DfB3VdRN5s?JM
Y^Xf=#$#^>u4o@rStWs+O-#52lYr%E)W*W+tb+96A_?$RoV-$+T"FG*47Phd>`GZQrGNNcj%
4$VC<<h&pqFPLgo<b#l9/VrVeeiLooBWg<$oY0;,;I=OrOYOXsaCI;u0im!g-P7D%rIV88tg
O)59kFW^g@nk*DQ*iVo"[p0fO0Y6ICQcl<JbbNU-LVks0g`MIpmn5"9S\PbILei#jN_-3>4p
#;Q/<M0k:!<R?6/[;#==nIA!HpaR:$#fL#`NLPZ3MRi]A2t'Dn'>/E6"X)7$)YQs4;1WV=PmN
"AGJfL*ugB&DX.Mrn7/,gicfb-_b%td"DZJS9H'ULg7@,FRII3W)UTu5EINuXm3tlp[9\CeU
]A=U,-9lPB@IIW?G*J-A/k/c6)2!r)_RFn!S331ne8#_6FY&:Z*82lU/oF3j3A=Ta]AZh^NJHr
@[VLGYKlo5@GXr4F'5#D*iSJlUKX*J)0p;D![G$[8<2bGF%P;BnR)$'c39o7&OLTE]A"Y)^GR
YnjQ-8R^Br-W-nSP5IBj`eq!?)p+SJr=02*cl!WNqZ@sDlQFfMLL>N`?`*:Y7S17O_Z+Q\2,
5TnH7JZ]A=&@$l?l;epmh)]Au[:I(SC3Ih))+eoLdY:K$nTp?l9KLk"46[nb_/-@0H_mp#?(a,
ZUt>!(r(?`5[su4n:Bj#;RnCZZm!t["OIrSK\6n4t@;k+#Q7out7eL-J)e?6tVRY=(VYPiSl
B0!d,_V.l$6c1Kd7G[e?@@8RK4AXbET"Z5h4dpLU^iEa9tMTU9kobg15TLM?>Q<Ol!Fjl'=c
R+5O.G,-&eA3Bl@8T+X&@,r.&Xo-n7..KT[CYp<t<2KOrbgBR>h?Ys/5'>)R1YG"aV*Zl8Gu
J^B'dLA-(7N?fL#+%EAUhDQbsmG@!.S[/Ci^LSNSMYW1Lm4.'!<MO$R,Mf;EG#SKD4u_Zc"_
]A7eLQ']AF_YU"/3jd%blg+irj8]ACn,.j/li`@eEF<6BFJco_-er\;oI`%s37t6#%l5J@LE7aQ
)"[6GCJS_Mio5`d/*s*eogGf\X7[qnFE6?nuKjaH*;\prRcJ7O;GA+XKF)]A4==:4i"S5.&%G
\jU1^D!Y*d,Dm^6MuETT/Ygl]Af=$eAng"6[.R1Y^(94iHRNkP3)ElKR%A9%B61Mgic;6%5=U
N/G+QeMkqt`8&!27o>QcitT<_&qVK7_0HH*Jo9YCRIIQr$S9t2mXOnWJFo.7Fg+jAc!^5OEq
*<S]A@p(N1srT(NBMZgX7\60"+nE7$DQhbp1bE#u^Vr9m]ApWdEV[A9^ZZ&m`$"p:?_'8"[GHk
V3uWplRNl3^UJ&jY(9j@!kOaR/7PS=aF$njb]ABK2Y\QH4%RC=O:T'c6i#9j;QCieY>C*F;QD
BCLb4n-q/S"B%`tb-0H7uj\j`1!.W`V"#%ko]Asiq1;%1dUb)\R5-r"`5S*W]AR[n6Kms0-]AU0
?Z=8MH"Kfd3D*a"<&^tBs&\%7GOmFX=f[!IUX#ijXn['KG6TD5%Y^;Nk"Do:!s]A8]AE:?Yb6Y
;5ib,5FWtn8&!FUfAMGKBt7T_77'EF<ta86U8fF<f""+eO&jHg2X`T$abo5PH1F=dR8*#P$*
_ol75]Au2e'fiT><$#P\&7T.!E/$aO0%`NhR=+o\&VX5WIPlRYsTf?X^CnfdgbP#4jZL#@qSn
;,%'8:nGbGn5diKD]A(qrXm\nYtGer)Z0g2brTP,@pK[W:$pGr1Ilo*>qY0rISgnO]A3'5%/,j
EJ%EAW%-k7,E\hBH'e['9oX96oCCcQepNEcRo*Js7%I[:NG%#?q2f1*jjSi6G\A`!?>n!9HP
\o)t4`jPp=n+<*!po4,ThEt2Wp"[F*Q>!$qu_1JOQfJ8XOQ%37OCjlK0ibpKC2rlrboR:i]AM
M]AB#8\5o\?o-F'kLNBbLeP\DG@Z41V0<d$2hK6Z:CF,C1fl;r00D.*WuDRh@KD3Y04)IqFst
e%BeU\E=1Mi6>NMK>DN+;o3/eh##lO#d3^8)XD$qp)]A5_Ck[&r:R;%oQ%Q.qDB:^1IW]A"gN%
)h[LQoXB6_T3^81c]A(0'?u^9I88tB2j8A2B.`FCAL,MQAs[l(@da#;<omc'!363]A*/X5meb]A
EMjU0,b*;>]A]A*23k]A@;aaV*3M]AjbA29U!0!p\aG.?,*kP*&Q>n^M:L%o5Vl(=VYCsIG/`ZrV
DW(O-gN9G]Ah"4/6n]AuOK2u(Hq(\-Vo)E^3U%KApGqh?X=;58C-@Be[1Dj>43$(+\Sp/jAA-T
SGqCGT=S6Y[!!2X4R#jgk!)(I[ZB>g6(#GXFUkQ6g5.m5.KiRkYb75;!?*)T.WNu70o;[0Wd
cRY6-nlg,=^onCcbde\GN60\$pSZ8Kq6:T3[b4f$:HBlr7fGmqkaW`9-qHUD4Xt"Q#+%.P4C
=(d`.]Af>e"g"lVkJ%A^9n^WOuF,\oH5J_.$%MIonCoC?<m$2PND\I.RQB>KK=2?d[H#2DR\_
A&8%S?_-:SL'd[kh\NF5Jesqsc/rERE"CihUDC3/;h]A3&I<-BQMJ&"0*5M$7dcd(&aO5PD$1
'gntn<^X40)8E]A8H5OU^<!:mC4@Ng\%lDYC(70,rkKIHB%XQ90`>C\JXXG.]AZ"&]A[&g1$;US
FV-$b0T#!Ff*g9LUA>3k3m$HZK5cF%-0DDfIYLV3KYr>ipTY/p&)60auD6,^q@I1pQs!N3I&
CPZkJOrBp4$CS4?!D/6.>5@Gb,T0,$&4'i`?k__Q/@unCV8+,OM)&tV/%79_<du\IH!fAc;\
24co#2RQ/0Pc1*;0AmQTMs+NE\@82"%Kf%[\:"?,?(YO3Jngr@'Nq<Ur#2jAIO>N3Mf;a`sA
?<sZO1FSgR6O_\X15"diXl)gdE2Ma*!8QmFe)s@&B`T:1%kW*d3m^a)KQ=64($#O-K.SC_]AF
E$iI,qeAB\d(^G/75an&otcuQ`9G@_T-t$I\^st-?"^eY%!),\5tD6SllFZWBi)L0..6b9#2
*16!am[aJW-=R+@4_R_r)XLST"hG[j0?o3>2b8*5X[IPUACZ@?kOfR\F@"44mrZCYqe5'odb
.iYF(E7!*Ar4Tc/R!1Gj8tG1X;?2Ci&\2DG?r&:;'ekBZ$dV2fo7]A!13sqh[U$L":2eNVe!J
"Y4lf-5N&0Y*I'.a>n9FJF)VJX_i6(1*-Y?#h<)qW>19U4VC3P%T`0^/mk(ZW:]A4apee*M5A
JSpjs1F)Z$AC#9ll1Z]AtUl/;BfcLQ7@:icOXhW5@R6SE%LVEQ.#H__=7Wu(^:\skqDZ$qJ\#
!cn:q96.`dHE@dft$c<kS1Zn)175hFXsqj"I>QtpQtd4OFE+i3=5L^>M*b\SWr!1gBBSFFq@
<KdG%FAc0^%JmCMY>Br/#6ebSa3"QHGmnMhA,f=jcBOeHPISX)9E`81!Q!)LI(T,+Pm-EZ03
0L1mqgPN^Sa+t1GQe^m7,(6Ob95-J#a!Sun4+]AaA\Hck;MG9mhq-o?Gmp(\SgnYG<[)H$g8s
JGNnO29d0o6flIk2=hqK?.t2n`RN%2mst;3Im.I^L@Kbi_>&XG$*uPhn="1T\*_]Akg?28n6'
6dU7%n6F(N&'gEHS/b+2C.Ehp(npf9HWE1-W\SUJnjH$L*(MZBK1HW!6qN]A.$CmPAZMkaAN\
r\nK;$Tkh83''i-i`5Y"uDH#]Au)*AT%]A9JnCd8X3seaVUAip$&J5D/l?Pa(JmSkpT+?f78<T
2S<.%kUQ$d`1cP*$94.+X=Gm-Q!K:2tUVt;K8T^KD'ONO8@&:DY$Yf>*=4,'%LiBd;JVjs6j
D[+s0Gs(]A`I]A@YqV#>?a=6oJ[d4.2H]A?G='XkePW-jTbps13G_\om7<*o@cFh$L(LCEtu^_Z
h12Tm''-VnFaE90-kGDAgK89&"0'@@FJq.kAe"<(a&^CKtnEb1+S^E\A5.">!99R`*Dr9-Hg
KP*F)m'nOMAW*F;`85RB4DuiO-:_7lVT)$&U$0o`Qk'?+b]AWZh/kL8qnI*]A@llb;fQ^<baT1
#-9+!![<Sr]AjnoarqXm%N,TA*.%ZWS>XD@-]A_tYUmgo+]AT-!@fOr3"qT4@up\^2#46`UiSP-
j^_i'@b_d2TR<8n?RCeII:33)k@"[$T3J+0=roYmRs$Bc^TTbh>'20^64FFqI:1siIRM*3^1
"Q(@bl1"OekKtdIp*^`UcE=gFk=.69D6oHrTlYV0L!-nZQJJ;6RgNb+:*]A(l_n%dH#ME-?fQ
Re422Ci[U::.nVtIV`IFQ4U,2k)o)*Wt)Pocnh1X&!>A$gI<RU#S#<mTI3=rk+`hf.LT($tq
@0+A<_B'p</#OUdJXUh%\.B.m@&k]A=j&YYVcLG:`QU@U[Vq>O.0a8#sWm0>L,!t49JF>R2<o
.jo>0efBb+3*jUO2kOLd_Q87![P7D?'0\MQoSsZParaL&(;V#",@BZc^8:Hl,kJ@+mI2cG)P
]AuQ$j&/DEFZN);`<PHBjpYFJK90<TAokNL2E]A`uJ6oHrdnd%)"\A3.#Hf93<sQf\usUp3^;T
Vs>OZ(O`E!E5bR;.KW.'SR?+ZiM65CKe1.cV".0@B"KU"4X4E5_;jBQob#?.VDJh+e4G3HiI
lui1/i(lI^eY$Q&;9NWn_RgaqO`1AJV)S=i5WWoPQ>:jB`u+;;;cFNVgL2#]Adbn*u5h-:pBq
JD6#;CEn+KH8^qfTO8aNpR6T3F_/#,*U6:r3L?@5@l&V:M;mGG/O>T`-qKH$VYB_m>Rb6GbO
FD@JjR\Nn?124F%b;n52%2@2?+#FAStb+j:Dn4SGu0DMDQ46P$\ZPdap"Z.';aQs3XW0+-Mg
lfq;p<gP[-)EBU2Rq"qMU@iSKNnj2U7DTH&`a<LeSW8<[cof5,'21,SuVB:$M@]AsN.+*\d93
0am<%?PDQ@LP3fC!o6r9j3C@po$nj%og;`,BdqV5((TY[gok;@M`EUH$=\r7f14,.1YcW'ET
JLJh5(oKIlO\';E+MY8Q<t&pIq"knj(!GmcTTt,L##E_tTqgF"BR&]A/H.H9QK==6<tr.c!31
dgXe7S6<p+%]A'8r\FZ/"=_&j/SQ9bk$c#8%5h8Eu7TWXQ^*W\/Oc.pVcbpbZZ0ZT9o5/#YCF
u*Nh)d*[.$9>RM\Rc=5_tZ,3'+>,G/aQ.Y71FUe34*Su:Bo,cc=b%IW).1+FWss'G?4b5WZ.
PXmfnK-NB^X^0\'1kQlQ^F+7I[NqdF'5=E@NS;k<!;F\Wh^0>(HcnF7RYrTm--.puK]AJAsuq
U>G_^3bL&+K(@Y-efGh`ek=fl`V%LH.Z\TE<b6]AtkqKRnJa_i\A\%QoeO>kBGoFQCSO=f_SQ
_NM_4*YOa]A2p\<N\\PE;#T)[6=%EXU37:&K+eb8JBjJK'C7dCiR>cJ<>r*3[+n"R2%Z_58N)
,&E#n5XgC.c6ZMu0LS$A8##H=qRTQaE!56"Z<,Pqm1M=g.D<U-$45!I.nKjLmX$$190:ND!K
S20j%H#\YcM;XefiAM$EKo@&5%f%!&A3u=WC&_P^n--+lNIbI:CW@DcXY!;G+><DL%ea`MMQ
L1"suhJDjoH&49<SDC_UJ+;s:b<.hAr^.Q>L.4p7jg`FT>@Z]A7m/@'/OogpNA\+]AMJINCN7,
MK^'4\Da@E]Ao*oM1\ib;Q77&"oC*NhR`<-d0J[6O?H"?[_/2DQhjD>NGi1[$gB$?$-`?WM?e
ATLZ9d-1Q(\R?A]A'8u,Zjgm-_<$*`)QqGc*PK`rVD-:9OG6X*%mC94";n*aio2aG3&G!Xg,i
>G[A\nL1nncqB\I?a",=ka8AUuVrKA.^+UMZ%B1Ym_REq<qW.kVIU8_PO["UTla<l-H^Vo$q
[SggqGf5f[P]A+&1A\tT;_uq4/,f1(qg)KFAlZo9)ZY30_mh$U*h!2e`G<&_H)VVZHB\;8s"M
Qm9Wb#UDXcC%kUep8jD/ajZe"54%%^$DecX>\$g<@7j""%jM^)<9hYC^G6^Z%\?"/Doe><)d
1kbA,]A$`t%nNfJ4f?De*4k1-!F_kLqmqkg@&#9#a+`9eB*d"eF#p(RfE"DqZO+l[m=k\,%]AC
q/55k\K57b`O2]AWWP(AX8D?j/q(AA'6sWhFZ"igp:TY(eoI=/pM&]AN`(9[)Q[;CQaeBQ,0b>
/aqL[L94=L$9?27qmnW%Qoa<c`P(i</j5R1D/s9i>*CB.(FLKXl$nqLGAh98rI^GR0LE.nTB
/NZ*XO6>sFtV_#NGu[r$<PpC(mQ4NAZ7LI,"kS#6"`Ae@m2]ATMTBbdF@d<5o\,cni*9?RiUN
,Y,#;jRoG'^nmhH\ElWOWQ!`\So.)s9I!9W_"SCK!_[kRspd@gb!@+3Bj9%=pdm@<84(aNaP
SSC]AJRPWm40#OGSGcdt'U>osm(?"cB5fQ^!8fFo5&[s%q]ApR]A!1kg/Y]A,0et`uY'!;<\k=GM
"&9mZZY>o\PnDUrZN+!ubdTBb9U<1\73.fR]A17Ds'<(?jQoSO,,=WMKJY\2&@[4VpFZiHBbY
XcdU7K33#'?R,=_X&>N:-%#<7ulQ_a"]Aq!\9Agg`o7sXfDT,<$LeTJN\a>fP"Y5bH%!HBh-*
-\9QG:9sQY;-mn'C:glD%LFm:V\hTj8i(qfO.+tm7B(1`r">"1Pii*)7XnQ(1#0GdTa[/>>s
9[<cVCs3o"[;EB&m5ce8U8goG-EFD]A_>1L3F4gi7P$Y>ed,&/R,)rPP^0f=Cqm@OgT"('V.D
k!hD_FhOiLp2'gpm[q*,Md&rf=L,8iICdn:&jj^#\n&:cCm)N[id*rOgq*6,XL@pH3^8te*D
SOLe_HQQ2rb1EfUZdC(E0Dm(C7q.a6t-,1gH>:a_^)]AZ-Y*f\%0'-LjGG/ma$[s:H9,A/o'q
`M!2d*82"+KmpTT2I(W>)5CTW^e,1hB',GBR+M;Vc60Z"]A_jiDe\98Xm572o*LK[E=[Y#M0:
QeJ&3:tbD)%@0^Q@NgE=Cb8UKNdtWjgXY7\+i<[f_QaGY!O=$!]A0nW`5&,-[;MnY/**?KG"9
&gI#-[&DOtn![-l\Mk:Z]A/R@NH*Yr_TF_/4sXae]AOMp8=;C[[cQtD`3^6%%#7C0CICn42se2
"SD@Yb&^i`j.CYe9!k3T%=M!C8X,W*o9nTM\N%XMS#V'aB6#Zk\3qlJ?^Z($7Fr%^*qB$hbS
ARtPr9O_fA[cU^Y,3RDr[%WmaSUA[\SMb&a)WVQs]A22gUYa6G!s[6J_nuBQtDNZ)Y@]AJ'[?-
XIIQ%&2[9$>+Pte,-KJAF*6XuSBS_HZd>q4^$o67AgJNPZ5s7:0]A./aY-0?7C&2dg_@lD@?k
YJPaRHWRa)h;6Hf<8L^JKQ_n`qtM+"]AF7u7b5DXlP/6i@lpDf%@dfK]AL9tljneTYrML)*Npi
SC*.H$/O>!sLH;;'n%lR[s,X=.i&AjpE?*KY-J9/OiXN6gE!Co*.<?A\l7i,nT/.<fYYjgVh
!k"c_4'orXYLDDZ.7k%-1C^m+Kq/cec-'@LNamcHrSF)'1k?Ini!li"2",iU1MSok<Rh6)<b
*547et/S70R!%dA>Nm`'_kj\G,@^SaC^k/*/j2@i)qm03DMkCfk0.8\]AL2c<s[T5m1o"XC<5
aN%T?cnt;,+1FU`G(h*h2RMNI.ZdTA@M;j+Nf2]A"Q`5V<\;n7mM:A5RpI,>4&CCFIUNBlrsQ
V`V-T&CZO`VFKYpEYpuFhH85%g;VA1?AHa%XE'nHS(<<V`ED$</*Vd+R_'dkH;@\,H6AHT[O
2d`V8\C0<DU7gL.jo9q.1(@&U65#u@_3K2kl\/E%ASeLX[aX>MnDP#lRJZSS!TI-^JWFs0"h
7oeDP'r9Q>q2R?DPblN-AcW9$hhpW"Kl,FO\d0N66%U(iVjDNYoW*qZ.#KLD27cca^nt[Mp7
<($[M=pP0h4'pn,qqs3jaTrR&\A2QF"Ufdn*jefTL\_lfJem0k]AF6]AFk#&HZj;Rp]AVTE&mGn
7)>/,EftPBZ;PdT:@fnLMQG[u$X\aQkHp4b'=XD"]A2pB=X<QDh,ndWea4.k8j_R1Wjj0K]AaE
C@gW-*"_9HG)AQDF>V'\[@27R6tjr.d+R%[n:8c([9RF*iK`a'jtZ-;OrNPOHI:-,P]AVkQLd
:+?;5UZ4qcsLk8*<F%K<K4>#@d+Y&Qll+69$*o.G7;,M^r+,H'Cu?_p&:FWFk]AHN(FQ+);nC
DYb[:1i<S"":O9S!e-6$*o6A*0B\U<>DsYH.MgiBQ(2j-`4BT9?U31r_H"]A(AP4*V)?%f6[k
I@N`&lLs:]Ajg;@"*-MT>smJg3`t8P<[j`8*<B_,Jam_BT6[KDCbB4II"F,a03]A6&h2LA+G4,
EFodq9XOd4$E`bq1;;+9jCY9H$TJ1=FEQ=Yk*4c(YcT.l_\[l09e3aoC]A+i.\?RUq`:i@TlM
(PoZ4O5R$AdsqmhYQZ%j^%ifaIRNnpg0^W<?eFq(DB^keM77BdQg&3^.g1?W3OQX\3)0`Dt&
@9%)u-0fUX,6*92H59(s^8;j-.'K"jPtoQO^=%heGpRC^Ye,8#e)2!44u<t<YF[X)0^7l.Qi
R@Pdc[YNNs[4V=<r\3$)djJ!$g'`LdAl_NO$!)g@q`RuAIDVi=9I6Zk=K]AJ#,Ks]AMd*'qPP_
pg:nQQ6Qm`m1*S^/bX4#FJ,bu2CV$`KqeRA[DY9eQs&&ZsUqL!3OsK,lQobcTENj.iC-.i*\
;Cs=W\?c-_T-lf5!cK("-KSfNV0)>lFE5N`qEJm_t8P.XK+^eA]A]A*,.F0]A7&*plN7YWuo)6o
D)IL#:^[3Y!S<Ao((<=?AE<bPO_BcTtP'qq)I6G5i_-sh&*F;$Dab&'5LefA3usAmm6bH7NO
FqUR)F2)e2oD&pB+#R3-OUV1Ou3]Ae4aBQVa1+q-D;?"p3`dMppK;m"[HR[m[I>)lYn!15OTS
+uj@'s+U5'J"I";gZKLefP2rQpR;atke)5Yh4tn_,\PR9GCO='k8H9ALY^l$5nk/kc/YcL05
>ieWmVKgDhe2VCCPaW!YC>sG/2rJk.#mgc3kcVWAV(b7CqF[$\]A@'(+ALg6oO`or-#7MZ*SJ
DcaX4"X3OuCoAX>J97`qJ,V"AIg!Lf\&A(GbfXfM:Q)F`'@+El]Ab]AC31JFgM.LN.]Aj$4;\@5
0F;=O?>=@pqE-b+Jp683o@D]A;Pe&23nkr>o'Q=p`iW=HnS=(-HRo";Y$2<XSQ0CU@0C"E61Z
,6'+<t\\>qHMC=,J8XbQ*@\./(#.)'boDH+U&eoEW@>X:f1[Ufd'_?MJm:m&&Yl=)7AG0shn
Q"Rf*]A17lI_WkA.A-F!]AD%(PEbmcmFnMih]ArIZ8ifkjV60DneiWS:b5_;_]ALmh5R\bgt,R$6
;!b6&up(,=CMJ<:QFZ:)g?kZ97%/:@c*V9c^DW#@F(Kg%Sk\fAMJ-H17/DoWDGfBqg+=IUjW
]A,=ek&]AD$D]ALt:.X#PH53E"5+W:Vn0J68MYDouoE/`<*gGQu)Eh]AnuPOC!1_7UtsrOpTfFj-
$[,J;82qsh_s:Xa4>N>r%.*g<N:pJJDa,Vb6A,&'mW^=-O^LKcOF1d<coYpIC>9%Z5RboOT=
0!/&T3=R;9WuG>Q1O/S7(jS>b*"QU@S(-^%'8c[PLTEuRIl$"''_H[XcM%R6W$W&F0Gdu!F:
A4p^?!sY+i%HE:G6SG`?6Hu3$/Xo@6kN2RWpqC;H(Fq_Lorj@[<QT7FFhr5NT'BX([eAGb!s
W;rUj:idRhs:G_\]A^%GNV-%\'AFD0*TB;e)2J!/=rR3732kV?<cCG1&3!t]AI%g,9562)2J2q
ObF2GEY9#FE4#n-o=qD=%T#l1bF52OAaB_FJoKjH]A4l,VRU$OpO1*^nKcKuhA"1U?tQ559O?
d@rQjPub^kl(VFbtY\7me!#bi\H3+0<CEXIYN4Dp3B@p`:Is1`<<rQ0X\8B+LjE.)m3APg7r
M3G4SB_Z[DC8Hd)B(Na=S"40CaR/8f58XjDer[oH.U<@q3k5=BC:IG`Q:S`]AZsn-W_$(4_FL
@nWSbo5RK5VfpbUFd%34Z0nW0gLV_aq?/\&k,Xb$\gfI44Z&GUpTD;,Y=6K!(g*28RW0H6c4
U`.,6TZ4Le0BKb&<mO+sq8"/QI-HHN'1mlBJa]A73k/&A$G1L_3kf:q%-rM>$-92k%19kos?0
<#?;d*5KWUcGo]A2Xs*X[tX\6I>JREBj*'q_bRV(##(Xp5G`EftOB@H5V,B=Y2[C!D>(+mA$H
BLL(2'XpcEp>RC;<RYQ<t?H'.%=k;lVs%=[:PMKDhtU)^LohV30YQm1VdMH3V3>m>4#<OC`:
m\f9n!e506S5,cobEb'$5W75Kk4Jj-3(7Q(',7.ZYtMX[htNJ%s4Rl\t$!?6Z\6N"-DJtsW*
(lLX)&K>j(e^K<H9&7JHQ@6paN3+A[Z&pGoC1UP/cYu"6eW,&:cl+,&fnUZ:=XUVcR@/i#6L
24nk4Z$aL2YGmG&#)k>d#WD$qVn6B,Ok"ih;+=]A;a`.p!B_E[ZEi7=aqX$9Gq2A*aN\7#H:M
.75X$j%4WsH;e%FtgGY`YrE,&%)3Lr5JLb!JU/nloC.9@!-:%VnG^al3Ypt=IcMrhalM"-;k
fnK6a!GX5FL@69f[q:2]AT#.W>FQ_`ORc=LFO^P1U>c*K?[a'6W;@O6,i'1JB8`"'59?3YNu/
+(p@n<F3DZ34Q(AkY=0"(h9)["rK\kIZ[LsZ(']A=QH><DIaJ(=b0Xq-kIJ$iFlHrL";ER_ji
Y'c)^VK%nE<bpIcZ8?d.0C<OL`B)k)ZcPDcX!PI[53>(g.;;]A]A2l+A\;1Wu9d8oc<nM-lII2
Jh=j+ODl9s_db;S=K+]A7KbY7`;;G^]A_B`@2@jlL!/]Ap-A?qTFgI4Y]A;Jn:nEm_C.7l<:Wcf\
J3HXV54us&dpO1S/47O=K8#*j2$<1sHHnI[&^i85$>sqYQ+Vi-$hH&@8!#XuuXlS?P$Rn6;!
a[.>6_iC9&lX5fJ24Y27=us]A+;_4]A$+X\QqP.3;.jGd0lq;.pQ-$nuc0=*QM]AGZ9:8*hqfN$
8Ia@AbjH8gTL)P`*h:HL52;a5Z7"=gcpBhN*[$8)b=H?HYDR4i&^SQQl%d#41<>Mpe!p<GN&
C$=PUf</0H)S-7J!t"mCACJ9>M"Ra9+n2OXCRiAQ5P/<+WR?/VC3nU?kW8oml"^nc=7[\`rf
Z8A]A<%2YnX$H>-D?a@m"6r$/l_Ah'kB^o4/"e^V6?CS31$Ar/]A>?(5!M!>oV(,JQ,"Rb'7HQ
7*'pVg"l@r@*IV.TCVeF*n(6U*f?nr]A1F?UYr3!4J2p<]AE'!'Q25>YO(Td\IpKJsG6$dg\bn
;FFD_M<R3BF2D<=%m*@[@;8*b`glE//JHGYC"8>`<G/!cHUdW2CTqYn*K-c4XK&3B:dP1FUp
B@rk`b1X#[R.o8ME!aQX8\P1NI8A-.eqc??(V)=<!NSu3)c[em^M8t:Hu2.gD]A*k6]AB)2a9Y
eK-/Y6!IJck)?E8??"]Ac=%Jmf_G?0P-JC.Yl:QKSpECi=YqMCYgNYKfY.&lARDgf0.!XrOFj
A2`&<%?8k'N3]A[Rn3Hj+=b=!'PgJk@2!P^VXOH.u6*!W*PB\2-g*/7_n3nH?ATEOc'7qLCAg
qZkZ5o(A#en&(\'kYcPhU5F3l$Vgbp`(j#LR]A*a")&W>1P)9.[8i-5fmT[U^S-nE7)Y#L]Akl
:5I;X%O%CIC2hRmljWR..lo9DBtX7XVA,XIFVDpgWbJ[]AcjV81Y;tS.'luGrSeT6L[#8*b*P
?%,X>4jh^A'a?ki0.p*sgWB"4;,:2&<3hK?IZF5=fN)uVTjI\[_<@=o?sb9!#gbBd(@#M$YG
b>0tC*7%n!M6*la7'1Md\3G1shdh70]A7$d0GroDMk5o!KFN?Ra0P$Dc;KRSA(r]A_,Dm>Lq#Q
\/.C$`:c:f>dLe%SoCEX;t`)8c6q!dFjtR6g)T3u7Ek$RRkr4X22#oAFZ^3Y(;hXc72Toarj
AJp2EE59#orD",Yb,*4c.k?Gm"Lg%CI:^6W/2u;VP!`P8N#qVO]AocSjrmrrR@08rORT&_f(R
)T;Q]A%5)76YkOe4[Nq32po]AIHQM!F,poX$r`FYFrfI0\V"cPH;*8k6!>Z1[&H/]AZ;72uYHP4
@+QgM2=Mh1S;geV1<0Za@_)7deW\6^h=WkQ<;\N`2@@?*@IAUk#J[GGk0fun-p)<kD@iF;QK
d7.-^0@0kr@VO(EYBhr$9AH<VfC/_87LKP`;SlekHPXU.dHnGV[[>0br\VY\fB)6[^Kir)/N
U;t8IGR]An5WaU1O*SDpNMgTeY<$^]AYH0\(ou3:/NkoP3hW/<4sDZ?eWX"hbU;N13lo\&h<rD
i!6($!d7^bnEj"29Q^Gg#?Re3ZDM>Q&9Q)G\I\3[3J5.F4%mr>emP?/V+P0B&YI,%H[Rr`YY
)BJSIDPb51TiO^gW[nYg%j45)Bunr*f*gBdKYf"]ALHe/m;J;2l3taI5:W9e(EBdcnm7irQTo
+qggJ<J\;+X[Y$F!5+*c2[&)Zi2lE+<^'oXq)3Y"tU#._etH%?S!_;OPaLJpjP3rI2N3?Pt<
[t!`k1Ec_>4A/Fu1?Yad>CsaTL9AsC@Q()/<Ni#Vj8H^??!irCfB<ncYR@lK=2<<Dm,<X+IV
B.EjMTg"kD*:WW/2-L)S`aSR/&t?+d36/_sm>hS[<bB13IDlBX-g59)FBIi>2RnZV;uN%kL:
ZBDW\5m!!Sa`?g+%_A.jCfk54Udb;5V1pFTgY&$`HT-2I<&t"Yqi@mZh_M!@[S/<j4ZlM[o*
c=H/I/62P\;bqX8^Ad5!2Jl]A0P?bl#;g\C?`L45>jS_MZ\oi24$W>sGR(f?R7Z7eA6;?3,Zj
'F2R^`EPrDUm>3LiN!J:,E3(.WX*VM:naG5cd6=cP<Ks.W2p\+Ng^Y[deUMdHSJOL3)kXc9:
)N23Xg]AhKJmSOImZ;=WTo6"U9]AnSkAq=@=bYCo&V+u10<73)[D(;Ej+Q"YVY&gfCr-f(=WOC
6#=0t&)>ALXK;p5^chD4DK"$u33b$H8mWT[b,]AW%2:p5SOV8fiokg-+8DA?Im+JRgZ;Jb6kN
R2!3eg5eEN1cKs+-$nDA>4D;<e.5L-[JW*`^FN%m27),EBRWAjJc^trp&<dOL=OO[jV[s+Ip
HPC'S-PJp"hk\f)Mi&q&l-M6GT1Y/AY%/+=`%erR-^##c`Y4NN;Mhf+BR`<lKHc;mdmst)FX
I<#?;1!KU7\f<d41`%2nKT<)97@o9,gOR._7k!=5#=811<4V1f=L82B?n`3kB,1OnHW6FgMU
_LNm9GI>]A/G#,D#q7Vij$shGU=PV3j8n\)*o>?MRjd%8fZ5=b*Mcupo6:]ApO)Lt_^Hjck^ZI
Q7WCNt%;h,4sN_^^u]AGNh&aJ,&09lE@D:$LtFmZ*?0@MA!5TKA*03eMRHo:]A0e2&tb,</=@W
?b\]AfpoU65.+H(AF#-pngNdQ"qbq2BHn0Gh\"8lpXakI/r6IEkWm1Tf2eV,EPVM*J.MlYRJ6
;`%AeT)b<0ElDg_BW7<l$E>V1L9t^o4G-ij6_P5$udd"'!b^G2A.J4aB(2lbZMQ2[8[TKq13
tj!s`B.kU";^E6*F.RjsXA[Zq0Y-$-FVF8-?>01Ura"1X_rA+R#GCFtcc:O1@U#sc3k83eq=
%uLbW)'^6s!%"-OSc_LUKhP0BYBuFF84$5:>baaH[sp:$c5g[f_rZf%j>N*f7)A$dGXF`eg\
/:$d3g@ll4F`\(2[$3gc@b3(\NceNijacm%E(k,;U+d'6>TC)Vdi2b'\WF,rrDDJ6PQaimI;
IQiu1!G#f,(Uh;uLaL/4aVpGn@:"_9=>-SYR.;$Tn&,8E/64*D?^eb5?!-4i,flA]Aa'osc%H
2TPUm3\BlYTO(;<MfdT,DP]AFBY:9WM(-#YaADTjbJosem_cVO*,M4YELFB<:Kb8AOGJc6j7J
Ci9;>scfLdil<TXC.QJaAFKB(%A_DgkZ3Xt<85ssnaQgHt08<t?>.1^gGbR,m$%[7bdS!WMS
KmhJL(#bVc)]A=+T:61Chp,l:RF[U$=06+B+8_tfWRd,5<T(]Ao"Q?rW"XQ=H$`a]A3<C!0u/\u
sC!,XERZ+_,bkV8C;TRu#]AnRPi\uWD+7A6.b'[gWLciD1/,4bbW."X:ldQqg0FXo::,5EpFa
%+FbqQ'r%[.&oDFUEkA&J@,J88R?j.^KadD^C<ONLfJ(.5TP]A$7qH+aPCn\]A+O-q?MOcAmAU
NdQ"-sn.uaZ\*D;TQT"_toKY+%AZ*5b5=C<+1?3LVL1U`E*cN!1'qsNRW1"?2-\9c6M=J0&t
O0D?k`b_C7dlc@]Aedbt`PCgOQ'dL<a[m'XVciE`T[4lMu<"["%R5BLrCnf^+VRN1l%pp;(d(
W;JuM[Z^/;!.$>=8\1^!#C4(4H'i87H6`!<q>1?5*6OBFdil4[S!e:fCAtLZ'Z=T^<p-cL-o
*e)R?0gg0riX?SmaY,Jp)Pca5J2@\8e2j?+%DO:!fQens3/t+2a2?aS-ON+@(r9XO%O?6jS$
5=R3c.pQVn)GgFTVn=GGB;$$=p)gbbn1;XYG'W1rj$5q>mF7)Rh[u]Ar<'H,$$,aO@e+:6dR2
4YS[.%X"YNHc]A#=*T[oE/'ci/qYppV3BTW./""@q?<n`?BV\`qDaU-]AZ$dVi(JEAdLWm!a`%
cc&g\L?Zj^a3J/,5"#Aa9OZ^KT;39JoPnmQlcj71tLhUuF\1.kd1JIqFHiS)j2"OBOQ_J<ao
B1&b=9$.mFgh*I=C(b0Cc<;\pX4Cu=]AS_H#QAXII$j*D!L<2Oc9VPM)&fQAW`Bug6CkRb9$e
aYXWJnHJar1T(9\nm>7-"7P,kJ*e8@#m'-S^?L7BQLAaq1':NFX(q2T#/MGKF(sf1!Ds7r5c
gCokkIN"]ApL)Bf>R]A*p7!:f#$'DG\W=A-9Of'(#2^Q71c<[q_g^[JclZ]ALMgAi3tX\dZn?As
!sMs*-NRWTdUHWdM+JlTJPHIVrCFe0.'?hBE6>7RK==*E7WMo4SkAJ:mU&l&1W?L'qPY^>Fq
&MNd!I<Nblh!6>Brlb0t._p18FVm!1:VN1,1+jJp<`Q.*%8+kPlm/2K'U,^\UA9M4>X#rhhP
<Y2Kdj%!*9D;M8B:6U.N!Pi7TQB'fLL1>-R'J!Cfnc&%AB7`2`jTC3_2-lE)LdFZ0W%:N0"6
h:fF/;q%K3UH'%q^W9jsWT)F[N%93JipWM%F'0W]A)A]A4=\IoaN+V&*L8Km22CE;L!Rld;*<u
SYL=UT4'PJ/ksQU#P$VS%:D`h!Y&UI%,"8FJbC\A$To#JbgPcO7o7(.mHho1B\?W;Yi@W"OK
h;tmYL+5[)j-cMibbbJYo,pnE$5jY.=$-<SVE:%(`1=GPc1\UAo!4dfWFk0#Yr:;_$79"]Aq\
DI;\>OFU*4E1lFufI#t5-!:nBLEG7Z3frF/>0,#Zq)`Rs<a_h;*qU2rDDf^b+QTh,LMhAf]AV
3'?o0D;bh5=YF(O=GN.h0kBR.7`diM=_MM`[63,[;s8EkQ,!rR/JhkH*M=TaU@t\rkO<JZ\T
3<naI_n>+a)PV_b/ero-K;3`@)a#SV0?jjXl*7o2;7dG9I5K=QBQ>0c#Z^6DTeg"FpJaEf1Z
M(LH[tGgu0T'I.m-c/AstqN9/5rOh5VJop!S'mZmAC/ZX<WIKmrYQ!b\S([/PUs/N_Tt1`K,
9I+rmep0/.87BNojp5Fds,BFGfgtE;\!1Gjf:P(MYN"t(8Z#g,dpdGY&J:Ja!lGTZ3W0/#pK
n.4\>^6p%4n`.Z(?i*m9`-"gKVH3g#pEZB.F6l(+[c`T"H3l^o;HDfUgPJX9qc8#iN/O;'X6
8#r<%#F.]ANhME"mD(ZMQ)Np)fGo;40\08@(d?kJ5Y[e56:fe*dQmG\>1_SBhOI-A"[i]A(gEu
[IS*TYD`8+j[J2/b5a"j"1XOeYu%LSBGF1RBI&:o5'SjatiWGm%#\'U]A)3Bc!$bG=64T]A1t+
]AC4)eEXjA%=;SY7oFssb`4=JGg>"P=Mg$72IGB:c&JYb\>WI`^<_oJ>.mHoc*UTF)"8+Hgo-
qT!?e^^0BV>0sE9,\=Rq-%O1LcP9aETD,mIc\rO=G>7>i4il&iVYY\qH@`_c[U&:+%%E`"X"
bZjiUV']AA?M!5_#l'lV3b]A;Bdm%Yh<7EX\^!,-:^QqRYgu`c,Kbm^<qD-RGB`#Cj:;n9H"3$
l.d;:(5qD,O/1cf5I0Zk80?kHN)A#^;^dVj_o@!jBDMD)rD<pXBPh8V$1]AB!Ki@4B@L7>tj%
ei;82UsG85N@?@A.H5#mj4=,@9pX8,K(A'j!Lr3keE`gl@MRL-W#gKmu6HWiH5e8fkP&;cqt
q7g0OJVdq!,F!#>QBlN.&2reCfN;<2IRZ4U2_nUDqIg`C"Mq$.j_*Jif:&FRM@^7o?eYDDWK
9MOLHr"hZ+.`R1Pb*QW5^ch.\42=H`$ZgZH9s>[GC[9:Lc0FK0WM@D`?l_qk'WUB8Ki@<ATo
g``C)YNoMb)`L(u%"Jn9.mEQCY&MadYh*quEP[0Iq@r@1ntE_g.^*1cji`kPj8-b&Q)$.^nA
O^o]A30.b%KSJcp8GU1,hOHH@:A'nd2quE*C`%fF1q"sH3Tj_ff7+)=UP;>CM%J^G_6fAu#?D
b#Xo05FaZY[qe[8kdr5Q'&V*T&:@n:0HUb3qOdnBdHW=Uh[P)#iAu0DGB^P_>k.eDH9F*c:'
U.\2F50n0/0I+:2^4]AG7k)7P=OlLc^:jo!&PIS7ZK:CV:/#DPB)GCGT2DVO!^9@9]AQWH5@,b
/gBBT9%_B)n6MTrLM@2m[f2&!q,:@`j'e,s-`DPq1_oH4em5Tec,3q%nu@abV<;9VfP*Oru)
7`0]ACjabo`[0DZZLe4c(PK>bA'::A&f]AaZ`kLs6Z998MhnWRLhf?<5ki&c2R+A/"I`jNOJbF
-:)-r<RVd?4S`[G'GK!D>Gf>i9#d7V\A&"ls([&dF[&b+9VNaj0F&:Rrf?t/]A[%DALtDLI_g
ad"5'qT<nSGM"'QAOa2?BM2;d"Gk\>Bk+UV5Sbate'V/&.-n+<hEm]A@gl`I;U&(F52M2.7g8
D=LUYGMCA7IR0paM)G]AP0A$cUj(2-JIl-Y_j+8$o?FO37`HO"J23+T/e$_>DU1*0><\0Pe*T
V(7^>\rC+K"eSu7[i7`d$X+bn"tKtF,YM!]Ajj[cS2r(uNe!QRWrJpPqBHV;p'-6pd<.=#Z?b
L1./B^Vq6LAeYQ?%#-P*/4\=4$?IgU"agH7IKs5,Ss$/n$"J-K-GQuFMb1Ne#$*ls9'?P(>U
)5VhKpD*HikVW'(`cR[]ASJ,*6+upc!T57UTM^q`f]AGfR[+P8qTAs2[`Cso06g+ikYVf-`eo)
.:(=Wc<Af=F/0#Do@4*N?H*76!/I`btr25<\+,';@dfr60XJ(k6D";e!4al5d7tO"*qKR=Bu
Gq\t^t?fRCXL^0]A<-jVCar=4`J%7%UN);m\!B^l5Zec%5R2d.nqp0BiXB#n[S)NO%3i,h_BW
k:?8qc3u*&5J]AidV]A4K%qa"8e&^2%]A;8c'CWuH`=/O>j!,5'g1rSM56b34'8N&<Q@KY!jT?W
uh24:(2+BfKYO3H,f<;]A,qr\a?1.=!d1nr-p$#H9sj4!ASmW._<u*[XI-iXaF]AOqXP<.#4\N
^MEu9EJ8qd^eZ=KjIp3SoGVQ8,]AE]AF,:`c]AGS?lG2UggM_C;dlm(ggCjF2N`fZ>S:f4hI?MA
e8$A(U`F,qa[SXaU+]A5/UY*)8&pQ\,GjFk"i)J:SI.42AI50<+L)TUca,=VObJV4Zu4jp=)M
==faj1$t;m^0M-]A=,5O+!O^QP4PLF(Pp3dh>J4RJ8S>qY[K%JQ6H\NeYm%,Ebr]Ai/WCF.2a;
i>#mR;U$/[GN((h3$I$rk[^<fH=7S_Ot':^AcW[jI+_)MQ+Y9lSZFli+G]A>aSi=0"T:2aq)+
<%-c>ha1eujT\?bIH#kA-u.V.D+174l@SHdJ-D:=>&e_./MG6Qf`$1GV4ISSF"UG2fH8cm<C
c7>J]A91A2W7hQ.L-F?_d[?Tb2a-91JVXnVnk@+7ePOj:*iqhDPjJO)-%Ie:EOM@IYpqN0LIn
kBQ6n+Z/(YNGS@j88D'J9KB<V!Bc,K!mf2,sqcG,g=KB/`Sf)QBrl;%]AqIq:q=cW7ftI?([r
H-&qm\GcT<^7o\,0qRDMCFe9<i[4n.4)uc=3qu:g#5>tWeOQ!U>#L>fb4dYIql]A,FMo#X,QD
OZ`h#k6)]AI?j1."F!I8fB"jA;ElkJV;\bb:uK:^9skPH/1.u=c8<rf=r`8?=WjW.PY<OTikI
V*r`g>3(;rOu7<^#UT)!K`MW-JFN;.EUEOg?hLah8s.=;(nF5('3USa]AR5\j(b.dWQ;J3gbm
/GQ?1m#D13F"$L\kf[.QHVZ#QpTSM^^i.V0"ab:iIA64LBi'tf`R8r'C5D]A"s&"K(N>"4rVG
)Z/h08meZM0EL.(\h.AYP7qkNP`?']AM8C8^b?OaB-hW?9`<0:1l_-3pk'o*tNt]AVWq;Xi5\%
c6%J1mXUkVO3nebi?6/%/U$A`<8\XD\\m@eI3TY2#=&U=(0+qWAP;N3`S]ALR2aif0#.`9)?P
m"A=erq36lA+#;M#-g@Xj02*ajF&s1X,"_Y+XVmld7+64#N"WLiNAEMG+@dl&@1FO&OEB-hj
C6m.gJf7FGP,)ua&FNmg8k^LJqocZnR'Q6R(rad>hADBu'"\g?$C^T:\q0MjuFDkSMij%`FG
JBK@2ggn@<6DB9ShjP#kj^PS@q\So"9RWoRM)]A')NEs2Hn6(ge9-F5'p+H=heX<=hSM$jeXC
sg91%F2&Ji:H[G+9qOnPHTX9R[tMSFPE7gVW$lk)a7t8TApo<9G.X6D0nt@S?1QVa;^cgN_!
fpe=8m<WYTTH>!sN*Yb[\lZq+b\g%INk@3\j\?S0hELfm4a!tl^IIhpk@ci=G*rd&Xr1B=2R
Gq[<),`Peg19R#+Ept#/fDr=Q9Cc?:'aUc=sSDF%t]AWAe(F',^iOQNl_eJS[bABI+sbW.V2^
#Pp<T6($I3`NiAMNE3;YtdkB-aJ8c1fukVCKkUTqKWU/cX%=/Xa>Z2_8JlI^gj!r~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="4" vertical="4" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="true" allowDoubleClickOrZoom="true" functionalWhenUnactivated="true"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="36" width="375" height="144"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report1"/>
<WidgetID widgetID="4cb36a94-72d2-4001-a13d-5aa2d473aec2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-855310" borderRadius="10" type="1" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[=\"  主舱利用率流向图\"]]></O>
<FRFont name="微软雅黑" style="0" size="80"/>
<Position pos="2"/>
<Background name="ColorBackground" color="-855310"/>
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
<C c="0" r="0" cs="7" rs="20">
<O t="CC">
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
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
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
<![CDATA[主舱利用率流向图]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="false" position="2"/>
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
<Attr alpha="0.5"/>
</AttrAlpha>
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
<TableFieldCollection/>
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
<TableFieldCollection/>
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
<Attr class="com.fr.plugin.chart.base.AttrMarkerAlpha">
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
</Attr>
<Attr class="com.fr.plugin.chart.map.attr.AttrMapTooltip">
<AttrMapTooltip>
<areaTooltip class="com.fr.plugin.chart.base.AttrTooltip">
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${NAME}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}${SIZE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${NAME}${SERIES}${VALUE}${SIZE}"/>
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
<TableFieldCollection/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${NAME}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}${SIZE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${NAME}${SERIES}${VALUE}${SIZE}"/>
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
<TableFieldCollection/>
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
<HtmlLabel customText="function(){ return this.name+this.seriesName+this.value;}" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${FROM.NAME}${TO.NAME}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${FROM.NAME}${TO.NAME}${SERIES}${VALUE}"/>
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
<Attr class="com.fr.plugin.chart.base.AttrBorderWithAlpha">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AlphaAttr alpha="1.0"/>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrEffect">
<AttrEffect>
<attr enabled="true" period="3.2"/>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
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
<Attr isCommon="false" anchorSize="22.0" markerType="NullMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="ImageBackground" layout="2"/>
</VanAttrMarker>
</marker>
</AttrEffect>
</Attr>
<Attr class="com.fr.plugin.chart.base.AttrLabel">
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
<TableFieldCollection/>
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
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="2"/>
<newColor borderColor="-3355444" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
<AttrAlpha>
<Attr alpha="0.9"/>
</AttrAlpha>
</GI>
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="Microsoft YaHei" style="0" size="88" foreground="-10066330"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="false" maxHeight="30.0" isHighlight="true"/>
<Attr4VanChartScatter>
<Type rangeLegendType="2"/>
<SectionLegend>
<MapHotAreaColor>
<MC_Attr minValue="100.0" maxValue="200.0" useType="1" areaNumber="6" mainColor="-14374913"/>
<ColorList>
<AreaColor>
<AC_Attr minValue="=0.94" maxValue="=0.90" color="-16724941"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=0.90" maxValue="=0.86" color="-10027162"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=0.86" maxValue="=0.82" color="-3342388"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=0.82" maxValue="=0.78" color="-13108"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=0.78" maxValue="=0.74" color="-39322"/>
</AreaColor>
<AreaColor>
<AC_Attr minValue="=0.74" maxValue="=0.7" color="-65485"/>
</AreaColor>
</ColorList>
</MapHotAreaColor>
<LegendLabelFormat>
<IsCommon commonValueFormat="true"/>
</LegendLabelFormat>
</SectionLegend>
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
<VanChartMapPlotAttr mapType="custom" geourl="assets/map/geographic/world/中国.json" zoomlevel="0" mapmarkertype="1" markerTypeKey="scatter" autoNullValue="false" nullvaluecolor="-3355444"/>
<lineMapDataProcessor>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
</lineMapDataProcessor>
<GisLayer>
<Attr gislayer="predefined_layer" layerName="高德地图"/>
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
<areaDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[Embedded2]]></Name>
</TableData>
</MoreNameCDDefinition>
<attr longitude="" latitude="" endLongitude="" endLatitude="" useAreaName="true" endAreaName=""/>
<matchResult/>
</areaDefinition>
<pointDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[Embedded2]]></Name>
</TableData>
<CategoryName value="目的地"/>
<ChartSummaryColumn name="主舱利用率" function="com.fr.data.util.function.NoneFunction" customName="载运率"/>
</MoreNameCDDefinition>
<attr longitude="目的地经度" latitude="目的地纬度" endLongitude="" endLatitude="" useAreaName="false" endAreaName=""/>
<matchResult/>
</pointDefinition>
<lineDefinition class="com.fr.plugin.chart.map.data.VanMapMoreNameCDDefinition">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[Embedded2]]></Name>
</TableData>
<CategoryName value="起始地"/>
<ChartSummaryColumn name="主舱利用率" function="com.fr.data.util.function.NoneFunction" customName="主舱利用率"/>
</MoreNameCDDefinition>
<attr longitude="起始地经度" latitude="起始地纬度" endLongitude="目的地经度" endLatitude="目的地纬度" useAreaName="false" endAreaName="目的地"/>
<matchResult/>
</lineDefinition>
</VanMapDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="7e943be8-5ef3-4918-a497-6144aaf11001"/>
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
<StyleList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[jLf,);d[!tWcXLM,(`c+"f3FT3f!qj'N'1s8.D8koHm"',bQ>%6q!-"&6_C.2+")H#QY"#KH
c'\M@^npIt$iHpPsUH3A6mUpX:-mO$+>,YkDC=brMEl4EIWi[uUsjfM;%/5&oQbg\lJC*hPF
.-ue/KrAbW?g(Tbj(A/=g%D(ubd4ksK>&Mu<:9_g,>9k_>!+b3)j8dK6i;LBV^8C%i1.oY)0
@o"1e^]A'pF\ug5e*k+4`S`7SEd!02o,50hd6Hl&0sEd7#ZLjif"@GD]AHjFq&5!7Xr`CAsP1h
f5Kkd.jeb\HTUArM0;:l?J,PGP:c%!?J.;9[%7XKDT5'%3VI!<r+6I@hYqL>uUpM9_<15!<@
Ab4esF*ti`$&mX=Iqt.0+$n91+4S#\fag!=_h]A7[So*QPC+Piii0ZS"&l3qMW--_FKL+q,dh
<Cs]A2,VD[4P@t5J^:EbpHF`-(0K@'O>$,<Hh/h::RM^5-A&$qbG39djh"m+mnfn*<UMkOYJM
5"G_i.N7m$d-U5JKTlJ?$kAl<sk1B0mb>6cOXQ*gP1,&Mqd,i>gXA-b8cjTZ#&_+Dh8B"d_0
!:IBiZ(b9jgBoSp;1SgIh--:c6[mqCY"CD<rG1cK$da)?5(g@aX;mKiRG`Mgl#^EI,F;j1O]A
]As='-Q)p;ngOGA"IV9s3.),s8^>R&T-WM/0lSrLINXP^c]AgO1+%p+^_t+9:X:IE%ni>%5I.G
NV0YD*k/JtH1$JV\ieT`4Vu&[]AfVD0ju%E?Q)-9E7:F2nP0qqeNk=o_n_TZr9'S=A98jkU&/
+a!/!?D!22B9gg3@8o\KSu4gZM/%:8V+"m[A*4?h9:RTu.:%FuU#Er0_m&mSk70kO(dPIi_e
f2kp<I4DhB_4p7DU@$G:$+b9:E_oS<2cdbrgeT'ca0.]AT)NKOB:Y(_86lr,NV::SY.5-FSU)
b1YWR['I`DFZ'd?S87Eia0R/qfTG/ZO^aYV@6XC@:'VN5%b\4@Pmi45dJf&)/D@b@7Q3Tl,E
8or7D7L%oP7UE]AH@p@Wki/natf'lMk=D38P$(ZtWM;B4`j#f=c$s)0PiV_^+5"%Hb$0;tNNS
C1pc>?0XXDG[hEhR,R>@(\5It9C)"ecCOQFP<n4)pJ&tL4o.ub_>T\^(V4ggo-c```j\0;?8
\>6Q#:7j.k)`:(UDBl.=\@b-)?e7qp.P/47.f%&G^AVp07P*iR.+j^9=T8'KUm6j4a/[7Q5#
[8XkN$njC]AnB[sWt@7RFbacLS0hi^&#ECQ^B:6Y9Q?"(%$ENS4Y,*1%hdY:XgYqY%#U09<k^
J:"AX,5SGXIsjuf89j&QV'g0?!\PBD^+pVRICX`2tSP-$&RDZ@\E\sjo6,$`O12>4m_9]A(_&
^$Z?R\]A&P0Y76!ES=R^Z;q1]A78%&o"i'2<4__)otML;\$/Fi,>I'.\sWgJ(o`r-NEC-g9hui
o??ph#7?NJAVu[_8nDS!NCq5]AZ[[V5en5,A%3,,>^Ou&o7FS-%;*.O/hN8GW3rE/'#2d1XPY
=ZOHpQUV3&VfF95\S4D15:4%U,eHDV3JW![ZmnW\rC<(9mT$?'nS-4($8^F9r,cf(F86a#^I
il8l)_LDbPNhd;rpHHM*\mPa@@q@[SmkCdFGb72'H/#721[7$,BhY_h,Vj$>9VE-]Asf@k%F&
_;TBa!`u'WZUB,[=:2)=Ei@q?l69j()V9F0R0;jK[/<bXlYC)qdf*)7cENZlqQKE$h/oM=W!
H<o5.8l\7'\9Qol+a$%GX=57$'*SS/@55[^U-aa,0gLmT,Cjn/="8*[PWJ%=+<J,^7GB-Tj9
#(hNlWqET>0;b2"Lom:-@:l+!Vsj/jN/*TM6mhd+cTlBE?BgE"mpY14l4"5qQ/6B@i(qS=%`
j]Ag1KT5"R7dn(-gDGO^3of)6>+@Ye$Cb.m>VY=@($l,+[Jpi:?H6ks2UthO2R4]A>;'YK:rmp
IcLa.te6frgGHYqfs/fGG?;<?pR[kLqIj/P5s%>:]AiJ"RYaU/PL9$.0Jd?&k6PE25tpH>rM/
S("/,<%+FZAQ7mfcNF9!t,g_SfV44Nl5F#Pj1:r[9Lmhd>BfoQLs*bG*'35asP`Q5:QBK]An`
'EYKE&a5ug6X<-dL7(;`dORPc07=)<8f8[.roK-\k342EUr3ATA'PdW.3M;K3AgOH^Vb[BB^
6LJ@Dn[LIB^,@mfXeOR(i9L76hq_[WqDlK-\XCo$O%q@T>,FS;'4DX4XnhS+gt,rERWVnWrs
t-89"-Ki;4H_%)39.\J_a@_LWlXV.:K6A[Jr=pWLE\HV!&adrtDN=+lo3FX*q2K-).>A>h3Q
hUf05?/D\hsOQ]ALTH&#XBKiJZTF\bjQ3S_ct\jIB>g+oiE96ONOfA:q_AC?V>NDh;\M$e1js
$1F3J2PMS*Gr+6rWq%SM<**U!R82nmI:^.XZQ,f?.2mk:<o?$5:^'MF`5S.dFY-oP+S(L:7O
NWSB?r>+6*pbQq[I!oF*%o-HF(p$bXAW3^aq&Mo8M@i24-[VOSXpXV=SNB[O;kB,[J6't3ZD
HqMhm'hJ8OrI7HtepDZe3rAe.@P>?G^Vie8[%!6uFFe.*lBC(JM^Ds%K_k")365fb\a8Jb,t
1_??`5H5GYOa9,FA77Kl!F)T8F:.56G#^<,93KPDo2@-Rg'%:$7Qqrlk&/qmZ58':t8m>P[E
VMuESYdPqe&27GdUDjRPT+/_f!j&k3<VD[pdP/\kJTDRmL;I"EGYsOYN.*0A*?Y]AV4`b=[`+
3'!5,9.l+Ygl6?dect>,*P`0S!DkB9BoPVnDY#M;8:`bLc*TNK$%28qZBG@:*$^Z%>X/k;tH
#,\2oulab$ljKMMeBod;8&NT6EAPfYR<@V0t[mN$B9nrncs0>`E)7tWCk7a_ei^o8?H#ns.o
#<t")X=ZAiO2a[n#l<RebI'fNK/'YBm5D"9&GXEGaX\94VC-b2H/nO`/I_q.BQk'N\=\]AW&V
R-[#&J\f@FI6WD7/[a\qEAdV@/]A:9!$o&Hg]AhGYs+<Eic#o=oXEp^qLbB0eM.e_IG6C!9-<=
2-c#'s6gu29DJF#%GrAtb'N1Q&/JbR,LK_%-qVB$h$5n<['g2CQ[ejX>]AaIa8BT1K"aP6RoO
i9+8m>hi.ZHkPf4AuFH4m*ucV3GMO:P,28[ElE=`"01n08An8Kg556V0*d,q]A'VGr/0!ODO&
L4*)f0HoBhF:A=n,*K7GViN'Hol-sDlQj[F>@$*jp5bZstiUfej;,p=t?8"L&[BNPRGR=6g^
I3m?l")*mfa3$]A+Xsdb-^,4EcJif[@omTMue\B;ff<g1Sq*O$n/N.`c5r@.m\VCs*m/7eJ,$
*6i!(rg>DbSm;>kATG5`tPGrQ0"kD_$n27e8sJ*RE!ajm?TC?A-3XG5.4D]AJ9hm`i`t(@jcK
rPO[A"#'`o,oKTPKr[&qJS"9%?0hqFM[,d!j^_0qT&:69rpI,tuAS2,Dj!F=I93m-6m37V1n
?n9%nJAPDo,j\=MNF%aeqh"TTtrAO^qHc*5POok(;'dq_"nM+d(j-&!ST(XE'ruV+O-R'/'!
P10Rl!"*;Db1]AqF7VppCP`pg`mMJR-]AYDt$C$`(PIOjNC;9q!l8F.RAG_DJZ+/FW;"MRIbe]A
p8`mH9)[ZtG"FhBkYH@WY-nWm]A*E>?<tWml%]A*Fe7(OHB.KO@3#a;FfPsFZ[3T>;5=-\u;[f
CtJ??2Cp#=(Vuh.t@j`pA)?4,<,2fM#8Q;=TMaC9)T`Y=\7DD`Ge)E$)2T6Ug%^+H)4c0<JA
c^5d>"+]Ac+hQftP?^V^*!?eOW$7NIF,Ir!3:'3GBhH+`:WrP(::eV,'nCKFU9JML^ReM51f#
5%DH;,O'RL,7:?0NCnRp)-fJcJN]A\^Ei]A6CLP^lEd'tSElNn#ka[fg)"okU\jii$Jm%&tE[J
^'1@]AT,=F?uBp$dPQ1jJAT*a2m#=E]At1#D0;mKD80j,`[?48-G#Df&geLe'12aIVRa:3-QsP
l/3)A\5u&G4tYIW#?'PCF[PYM->I_.@*`7'ND^+E<G<(mZLK[A-FUUleMp7&<,'+B0j@_KEq
=a;q.MV'SD;#dAG(IZq\dAj\sP>=>,tZi#P"4lhiQk:I(XN#J_49V4SK-k$[/d)U,7SMRIYL
IM-/13nr)GpY^C7Bmbf'df*]A3-8XRWI*BYq3ZiKu7/G%,%%kp=P&?!qJ%ohg7]AE(HE12-:;L
VUeoB,a'aL:H=$SQdsi-M<UWSVIgsQmp%q^:3etmCf,$[\(&7l1GoW%hJ\C5M+dKJPu+0h@.
#8-"0X[;I]A\8!8m&Yr\MQ6%A^PN7F[4b3Zbf^]A)aROOYO8K"r2g;VTM5PAIClgfJhYK%;LS,
h]AODkS2lco)Y5D-FCE>>+dA;ZM&lU[rqhkA*fkIRr+#]AgQ'tp"4[')_8^#J$kIaak9p6NeLc
O_*MTh?eaWNF&db`HY*c;I2!Y1%-N>+3oJR/tpQ'g_b<nd>j06`&X[p#4\`=4?s0<M$KdV>:
=hgXE*A6R($;j]AkK#--J*o4NIq[!lV0N;p4B$75p(E/*>hrj%<=;i2[R&fNXsn$C?a6#$T-K
IZ/`fqsNb,@\kU/e*I7Z4S2'gRm'k-+JkYr0W-W["SWY9B_eDkaiBq*,tqec6C4iSe^BdD-p
m]ACUY.J\&bo79H>c@%CQXo=ms&=4l9K:@p[Nb6[^l!RZd"An'tdiV?H5W;ChbU&.S,CVpUJc
7L=njIG_NBrDoe#N#)*uQMtYp764P4c!9F=/QXd@Sb$^sA\HXW7jC<+ZZ1lGMUC:aKfP\^F]A
E+:bBI[1%4NE&pJC$@[-YG-8Cg'nB?l-aL#`A\I"*FRrd<XB9G7#O>6rc!WW)<28m,[YB_lr
OCTtl!LQdYNo2/V!(6&]Ai*jfHkE:BU\P9'*UqH);s1sCI+Wr\.9Tnni%F$qJ<%>T-7`LObsI
@3qCYRHU3)%r#WZ.@c1f#.Df;O$QET'=pTVpSUY%Q$`t*@A4Eo_n/?1&A@P[8jT64XG*iY#9
Du.f0X%+u=akOH7Z6&rZ\0Huf(YpU\AfqNa/78iD`n+]AV,=X??GaaS+M'gu1P>oc`SY5GA3D
D59\NZQK-u9K'nrWP^r)rX9J=FE_1WHcP'WBTNT)96qJ_4L]A5fibMjr!V(%fk;Inan4L4)4M
n&NkBUp[QmhbL?9pZQqQB)3$T`RI+>_3g;e=")rHBs,SR==SI]A`GdU>ds1ZQZ#$0@BX]A0j8u
>Sp'*0#;\j\_pdftYtHpSFL`cc$6(2d+D\f_<MAA2Z@0:d-Vbu3G:Arn`#6Ui@dMSf`^cuPI
9L>94C7D_(bQe8C;>uFI[9O\F<_4od9`q/%GPZPFrZSs5!^E8c?0jrNOcpdYAqtYgo5je3JH
<./>h4oEsEa"<`L9tr\<n?:B-Akm"RCHYdHVO#\r:Qd[c8AFi/0Uf81Z&p[$r4(&H#+$u]ADJ
ZntFTi/,9&T?o=PDQ]AshBe%:PcH,Y;Z@mP,3_n2o<i95:e$;lf?=nWe2PX+t43/pc!htV\+@
0NbKCU:]AI62]AK9f=ZpEAc^la*0i!J!A0X?><1oX/CN^XLcDOf4`6nJ+SMP"J\4t<+h+V8X5H
>lD"ZDD[6e/C&DX$(T6M-p5;Mi1r;(n3S8]A-POrY`-.7i-7UgOJ"/'b:lp33HHSV[,EuTl;^
E7uHR$U:%/fLI+@H=,F:p/[6/mJ*a5QDP63bFT&Bi7rdHXJn[OW8k[cn(P!M1-Y(W#ZZ]AmRn
f@S0i_'YZ$`pCq4QoAKWF(%T1H,<F(GYSl\@WBuT5FpOOHYh&C8_X3aCV$6AS'#/T<_i.);#
rb)6'ff:&@bqojo8sgs\?/+4q_LgHJE1Bn[o_=Um3'=EYT5NdqPpu.rH:ag1/2OGGZ#AtB5;
GRBe>2$g@rBcT68O6TE&u94$E77fcIlZjFbtlo?"oX4ZbZ:C&o?OWP.UCBM`,kBL!ioSIG>8
(gF/9G8dbUFUr7^`[qKT[Cui\cq2.&cqgmY%T@]A6bIe9S2f,q)C#HfBbe_rlC_3dF(mRP.@'
$Ga<3;'h0f\d:g>0e&a1\ZWJJLYT(DC\6mk:BCY7_^Nkrt,V#="1juT+19C?:)_cN+.jqd1W
f3kc_rk2d?_,eGhdZENcEO]A#WjqQCaFJj''Y.Fsf0PA9qap`ULM>U>Z$o=]A.4j!1Nd36Fu[;
1O?ghVfaZ05YRWA#]Ag']AO'VAVF(*ETHoS$.o")KV<F,o5cnr&!7%3dNhS<?=Q#MuQqp'C3l&
+C+dZ#L,/1$>*?kjV2p5M]A"$*I#]A$O>GL&nIp*0*jj2[%=L[;k;"96g7#J2TPqiGjmPc'L+*
!+bR#65O=f%feN;.S1Qjd_J]A44oX17qhQXCNbY&_TFFMAs>:NbFR#HShk[&]A*&,;g*W&;9^-
sL8'q!ULWWK\#oeNh*XVEN+&dTUJEW@C-!(2&(AGK)@bk;Mg4i:)`[N]AOYdh8Sh_88CtVqor
e=kI<+9$%BcT7nHhEn6ZN_/iqjiTg)oZg*R$\OLH?MV<mfVrJ0\P*>M;:j^8ZZgl$7C8s7)K
Ztf]Acp:DNbKkfe^Y"c#3`mBKp2m3uRp!0`61JX`&cs^0prGJI$r6H;JXmNJGf'>8%_E+oam5
!T6dj%7;fYju9h+^`<Pp5G_f3M3OQ8N[RcN&a/61U2pkd!5*_a^>"AX+M&eH*QM&Q(^6CD.s
q3Bu!D8f5)mkM+_X0GX(:;>DP;@T9UuM73mg85*C!?@W[PiCNGr>C7B&FECik1jb%Oe(^#"#
g4Bs6V_n]A-eef>kJ2\)+"&HCB4BN+jQa`gGN6@P=uaP@NOF.19,U=gF$9$r+njPiVH":!ZAF
i_d=GroD0L7b`jTA-blRtWTabU4Di/[3"D@EAL<1p0(';u8NuK>d"0Wt"XgiR(<XLbIV(;ci
SaZN3pFWN/,X/GV_B@A]AP#mq)HLO[325$:Fjq%-r!$YW@Ig]A\-YFW0P<pg8$eZqYc4=Q@V;6
Y/%I!MO[h4$B8L)2H1+cO.QOHsMa>)Mr\^%Rk"qM\4$%MH#dSR?II?9-Dt\:_4r'uGCB(bnm
`bj<s=TuYA98#I-j<D!e.n5m2.Q&Xg)BhpcN(_h'F3CoH[B6Y\%j#76dklR8b9'9Af/$DRCa
BU!*RRu4ZGot6hhBHf^G0]AjI-Qo78q),P,@$_/Gl^sbc",5L(U5CPq.^ncar*:oZbItIN4h;
MB\SX^"4l!*h&]AMf55%N]Aj1JVP2O,,U"nP@PD,egWu1+/P7Doo^InTKZqB6K6NHX&U_(G?rC
rH@CbV,LeL\h!qr9Ou-q\C@upNj65RY#=Vas6@K;*sg:CgmV6uJ7XQ7ra\"Ur'V\Ib5'$COJ
F3cA6^b_m@4o7e]AYE\E%8Y)gQrHFjHg$c*Zq:oCe:\U7Y\:>2,`UP]A_BR1gC$)\%p<bJT7Z1
`0D<Qc'hmMj4&JY_;fW`bK.6dX_;dnE/`4UhEK)tA+TJc$Oc+'?'.+&j@UAXM\+:@(&*?'/6
;`<sgK:&h:$aK6eQ2'EMu^^^)gQ@LjVui6^mcUFIp)Za2DsKPUR:1tQ`oj=9T?8A]A12QBdMD
`6C[_R49!&p<DG1F<I)KTaleqI_:K)rLqE4b97tO9NI[JGT]A2*FQr9#;fR"jo!j9@&:*lFnW
?0.'U>[6csiJiLC^\>3X?(c_Y1VLo`Yk]A?5\W&'e(u;8/2U!At@g.E&^6mCXllZAZLWp]A"r4
j/^8%'J(Mc<X=^:2]A_SrXF3AddMk%Mr`''639V1(VBh/3A-]AbT&_1f0UA_id!%<!8M0jiSmn
]Aq""="jrNL,MuQ/Ta>',BH]A=i[n\YY>iChb>=Zp1d`!Y/@o`A'/MC@;Q(=>,KW-tuM7H&l\=
lqX0jc\5<YB0kO-0%nV]AZQGm-9A4e2QB`_@NgH<cn-s]ADcVU[8W=#[m+'A&K=,jB.:1WqQ+I
HCL053FPra+&IFeFu0ejb#-r?2MTa/Z"'"e2pYKA/W>_Xh<dUMTiX]ArJt\N5305!&O-+?<:A
!*i#;Tsks<.qY#`>uSnN&M-u[`guUP5h6G&phfKj_,Rl!a0j%9,q2&Si^-VV<S@?0d$H?)MI
0<qo&PYYKKLcd$JA3V?1G3:TH`]AE-Mh.LUjiA(;OR<d\EP-.Jpp3tk'kcJVrp@aj`$m"6T1\
f1PKt4f%t3pW['su_^P&O,hEY0q7gCV)aZHrbZ!-+;:S0h^[]Af2EYdp;dND9*LRtN0YK;<QV
GeC_5/3c6kk24P-K-F+Jg:IY'b@a2B2.\-hW7L*H1/9a`g\F$"HCU7Vs-8da6>cPPauiH%?o
?c[/tuVTuWj5`s+U(3m]A(f%1M@$*+0p"jk;2GpYX:gH!hZ5?_6"#DYCo%#rW]AE7K>`(%Ms#/
+ksaTp5Pfh.(rZhk)Xb5Na\SE;qnW!>`9!8ATTSjot2:jNZ^WSJ,TkbJ#3RmD9^EQ]A.WNRB)
\0dc9pKjAkjUBs$e'JC'`5k41;*+_Z*E"ZpqIa?7Xpf9J^`;0Irrq&\ung)_4AV#l`<6r^bo
NcE@j*.A0D++ld]A["[Nq#O#c-^I@if"X#[22a)KBIliQ*PL!@WNkj=eUino7AeLS"u(A01Vj
/2p/jEFL.ma)8AgcKeiYe7(URTI__FOF[3]AiFd`qCT4qE\!N5$)fuRd:;s]A;)HM#JaM9eKpt
R/,71e<9D;qu,(j'7CDp$?XEBb::@<i(s1Q*4^"emp-^&\R58Ft)BE'-c8p.NrYg+Q#[BQ&4
%@!>!Mh(k/ZXVs8:Lb149K/2?]A+&ZBnWuG!6WhnY_gXg4AkJ[N-FCEEVT"&dThClXhKEf[n^
[FY#Mt>o'>Plt,71d+7NB`G=t\o9BiHMochW-1;Nr52iT%Rjq-Jl)W;RaVKUN,71co&^IRB0
NGLes21kMu/IT_s2Ugm,'`G`>]AoGF'dW\Di9Z?H`*E[?!PAmOpB?h>XpMWK',62%-1n7S;Gr
Olj.p_/7OR6us8m"6WBeJ43B$HlobjMTf%NUoAd"X<MFG!AOS%@XtG3UAoXS,5,P/Dn+:$8@
AKpW4E#OL9:9B)-I9L$2a,db+U-hKdiG\PHT!%;XTncC+[k3CA5%@e4DOg[,j(E.*8@Z(T1r
op\-&NI!G2d&GI#ToGl7T?"`ILWEAtdU_*1hdn8oFBVL<9[_L_8"F3B#(2DcWg0V01Ypi)VT
ADc5ZI8D:n3nAc:"XD?$_^EG:#F'?qnpWgqfKQ<bQSe3Vp3_4:/LdX'p31eF[-Ldn@,hP$'d
MeN;N9jg1F<Y_#prN@:*UhBoGt:i(f/JOQS)MHirn;^4Vm;C:#0%Wn)[I6CZ*<#9d[7Rj(ZU
"!91\u]AplB:+AN5kA1;k.o'n<527@Z7gOC.G&"._V(VQQ^9eE"ZPhVkAl>rY`OXg"Y]A:L;K,
L,EkFTgAEHc@>rV%'Z?ri_oF!R!/1.1kVWDZ%%pY6F$=>C\TbVV%!E@$BE60<RdTsj\Tm^C!
Fgm^Tme#e9hZO=:Gc=E!3:+s;:<1#M(;bOrQr,8LX21B@TRS/JU0eR8rEDOFjbbc?\7&&0(L
I@mWCSOT?QUPq(EJF8j)hq]A7US:G5TK4,K>1^Olh))`WAt`N(RF2b4/!Z24;=f;8)?=Y#Y;2
p,h).%>["48.!L0%c]AT&FMC^k&^"C&oEc@lJA"(Q#"<RfjJ3Qh2?0QJ78lT7(>o,3qcLYP8%
lh%q29V>p!q]A>Z>DC]A4#jOAE2!/K7I5K^0WPm_'^7K(UqS=3$on'pW^"D)nC9FXMWh7tP0=W
qLlQ/6,>`LkR]A3Z-aO8]AQgL'-\7>kF9%D>2FSEm-#cdV2M^#OMQY=!Vkr"hR;i1%;RoB3oNf
k%?9[\":!7e;srhFJ7^;3$Y:@Jbsja^/92V.o1N[0kAn.ZP\%2Q>H33nr8G6^BY"?R`lOrcX
[ZbrQt`2\;qufRqO7Sg1A)4.b7'*%NU&h?ElHX5O<`f=H78PgCUq9onAUp("q28C`[=]Aj)DJ
gY.@de(U'IEnO8P_I]A8jn#%F="GsR[gjTW8akB)DD.jo/E-Co4iU$sM@rFN%F"Uuf#>=2]AFL
"X;"E,2KE<rST)[p[ZIfH&dLo5MCS^t7"*b#/tK9Zq:''&CL5,RB=7_/;Uj,"+Y2$]A0)o7h+
F59F6p8NKWJOhc.6UVaJ6c]A/k'b?b$BKfoGa"&c25lY:pGRiYl$aa'K4@d:"pV-WZeR:Knd=
WWcOZ;I@1K&`hGNMG9P6j:u?03JRiN]A!J.rAiNGb5FlhYjP\5pEW&a9>^03A[3o=7BV^B<Io
=s&.M)0aiF'jf[H89[kOolCFS2t^-'bRG@G(d2-8k!@9-/,NKYlss4&_AbO]A/;5A&?sd^CRT
'Nr)8g:2[GG4(?"%db#A9/JQ1+;X244c6?)Q'ks"CWYgB&lc]A?;&`D0Kr2TYiiM0RXqR/&Q:
"]A*b*q/KY$[<_k0<^@sirhebV-`Sl>40,XZJ@Wt<MH!k=O*_VHEY2LE$H*m2*'J+gRVjSX'l
J"T5[dgK:Y^G=l(cB=)p/be1g4A^UE[ZXsc(E&=F0fWC_J#Y>P@29H[Z+rp=IXH_VPSgD/;B
<?V=U5S]AR'*+b8bB9uGBfAueWSic5@(o>V3B@jjslu(_7'Y^DV_W,p:^K.W#)\K*=`L%m!h`
;^7YT-p&o:72lq[teA&.*e\ZX)R#:M#UK?FrD9#%\9N[+T5&Q1r>"Y`sY+I7eU"^ZsQI3)Sn
7!9[A#'OoFUIWX[3"Ua7tQ48TIX%ki1P0[Td]ACh[or\RM=1qKflpj5ei^Q!BrkK=L4rBZ%^3
0!GW'kjcR1NC/]A>Z*mH+[0fj0pHhB@EN\`i,^MH9b.0?o#H?$m;))D&=<?eR!%U#BN8uAU5-
i)YL,)@JLHC\]A&7_5?)ABV->7k4<4Mr8)%,&cc]AP<l!qb2bYgL$QPl2N=$-$)#pTrajl2/Jc
]ADo;kB0JX"$,XE`=f<?0Lc@_b!tMXkpr*D`?Hbip3?qK_=9;l\GSVt&_`*%\c+4!Oegro%rc
SNL(H*#$IEac3-T(l]An"Xj^J(7,k=+cM6@fjq75#C=>hr\AkGI-K9Z1kO&*pbX7:VLA2+fjq
L:-Q9pjX/Xt!0e&2L<9MEDS*Ud-Pp/sHJ;*bZ(hLNpKDg2A9%";]ADF!G!?C=,CsQ?pmgl>5)
r4<==BfLbgj@5G$Ar&dS@$jr`k(KSgp`Y@e,A[q:1E(:p;&nQs*($i7)l0@kgD52G=fu'!6s
HC9Aa]A0Ab)uB*3:QZ&uAu'5kf-8VgO?21KEb?320dpErR?OVJgqW#sf9$aE)9OB;:m$#q(:D
+=cA27bGVuDB`D?&_VIc&e<t*9Jd*&_Z?taT8'LpP=XMuY\C;#QY;%u&oXNE?CUZ;f9"G_KT
7;/NW3.5k(#?/)uc%XU7DY!3eQhu3\4h=@e^:#*fSK<;Fs(\=hB<o#6:A$FauguF_U!\Sn\>
NQqMO-<S.1r-dsJZFg+#bjj78^07fh+$KbdlH4GCC1?!.?s(:sR*mX0.\oW:*Ap\%4nes^WU
h3Bk@%eJG%LpObqSd5KmurUeU`2DJr%up#cBrRao>hYfA+#$CK(`j>%*k8@Nch\r'ZY_)^.J
'jG,9FJG8#`,#%9H>7m_3:^HHO9A(,iO2.*hsF1'VQX1^grejG1V6I_&fKKH&A,oO,9dFV2D
gU([n:#1UTo3#5gFVYt=g$0(?[]Ae;t/a$Cc4\Ml6=.mp9r_P]Abe"P[%bYVGfn7DpQ5'/Z`eB
Z/T,m@*7kWQFM5?JY9mR75JCI_G;?l*nQjE!2[A1dDBRe65>r%/]A5VS<"8`TEN"lnuJFn]AOp
<Qg04$IR'>X-3/;&/rs(tITZ*+X.fSGNo$4<($%`.#C`pj2V`=.CL9V%<@`s=o8S:fWX)I4B
%n\WFf>Q(K:nERS(0ll9(P,(rNV!RgQC<?f7ek;S&=3s<)2Q8S9EPuaDC,[*#MT1FpEes!3r
4lc<4Y0"MUS5(2/!ar]AOKm*<mF_JA<.0]A!/XTOe!X`=nDF[R_[Auoil<Ta2kuS>p)*e6+LtU
lgc87N;/_+%;)d?[M)!U9%=S5Duu%gLe@.I$F+[*/.<NdkP55Z@ad^6>:#.73ENIl4Bm+D5d
d?oKu:ZM@FP8AiIq'SDNrm(P@PLB3X3ieD_BrG=Ua9m!-I,_,hm4La;g^BdL_;c&Z@)83&\A
?s(o_6[@\4rN%!77n\4?%%42:(?Seo1TCJ!h]ApEpP?_Ycn-LrFs<jf]Ap-'E,D`D4Z'G(6K4F
Y7ih,%_HCQI`!-Qm8UO>EiGQo>#?H?]A;(3WpTc^pX1o^K9pgPTHtU.FYu,u+KqYn(l^Eq,U*
ClSjrQgi@a_&;;Wrn'b.79k[QNQDq^&bDI^u-"^!CrL5,`nhHA]ADbY`<G=p7smRVtU8>H%EF
/IZ9q=<@bC\lQF7+p?4$ns)+YMVce#?.Q+3T?W)j-EA/Ann=9HLtqA!;\G`0g\[(*hsaA+]At
`g;l8X\BG`D2lj-N#4rM#%j#bZcSObQ;Sggj0'Q%"\raY&S"/9#49$YIsD<ifoMf,eT-STsa
4JBGoM!.OMdVh[bQmiA'3?WfS6fCL"Kn2Y9N;)FMqWJU\%>8'Y8g^5#\<Z]A_oiR\?R_j\N^j
oM7bjS78K/35(7#K9%c_V6MP51!q9kW#<oidS*&L:of[IDKOo05[<U!\`b4WHcOKcGKlHV`?
"lRETka^/?oIqYukeRi2mCaggRk[##X%>0jPG&s<oJW.GK$p'&u]A1\4M8kqKb`i7YGHf*@CP
kD13XEZ-aXQ'ge(m=fGc.GN*!d)4E"hK"qp!6iOkf^oo]A(`\d/,8dX$jgc<R3gL76?)g9b&1
?)0Q"tJVFus[(0R[Z)Whqn3>(GNJo]AV!o4tC?9J=4$DbE@2j[HrJ,2hC=7"\iTH&t9&&k7I?
$k<8#tWt8e/J7WL>W^9FN67rf[2]AkWeE1#%G`"`a$.CS*nWp+6"n@gqp=%c*0fRZh%B#">fD
^q)$YsC;-&V$>72'5-:X0>Q)9%Xuti.J^L^/3s2<TgP@`F1Fu"2oVjiQdH:7U58%Q&:4q>-&
P2L->/6O"F^M'le[pF/t[q0u[o0o(%pCFm6E'"Pe7'_p::1(Nt0Q[[i;Q8_FCJX8I'h^naB,
GOm2!V%9hh/R%N1L%1fA`$leEYa$3H!kn-0DdS)X^>uhS=<P=@$tG4haeu#q8*pg*<NaOnL2
RFM5Sa&i=75X6**u7l7!Hib_>Hj!GZ-l1XgdegKqG#UU[4q.VqG$Qj3`eC$4::Z4fJgKG)'J
^j95!IHjHfK&aLgk?ML291e8-SRXQW5Gg-%_%.;OoW0=6':_8L]A4@$8)fQU"d`5C\HGeUQ'm
pu^$eJ>H36`[%Ucsq)<p:@!>iop@t9''+.?>[.13o#@qZ':lUB[K$-HVX?X[F*qigs-_=fYl
X"]A0;au'E/]AG@KrIc:RR(ESis&HB=jLYjlIN$FeJu=Q!`q^2EA2LGj$4D:8q3UD.ObHid@kP
DP+o`0-%kddRUtfD&Y\1h`?TmX#kspNabl@H^$I@fdqs#ZW3>j#lkGI?1!Hcf.-?RR\10SmK
$t0/tV-]Aa06]A"U@]A3R+#`jH]A9'p4=LX#oI$'j&*hDJmf']AV+XERi5A!oVW@t"6*c*"%r-Pm/
0[gF\g"&\AM2R0ck[2Ce#)*\N2%ujPiWuErY2[3ANj'ulV."+78)bl+-'O6AUEkf^dn=Voh[
Y5XB-$gW$N?^EKn)N&5h2M%gFW'1C(5Gs=Bk'8CJ+on0k3/jP_d@61lCKXa<l@U;mOe>P^o&
>8U\[C"U"7N:<ahlf.%I5.'iCG,>o*)Q([UbG^6#N*LN!qZAg,+*.0O`-&)gRU^$an\"dc2L
V?_'rP7?2oHg&X%4FPIbTAJ`*=Ad2Y`p6-r:g+tYcg`Uf%a't#/T>o?WTa?2%.K-'Ni(FhQV
4";3gh=(^<[tr46gdiO)9Mb=sWG7CBPotMj!.!\a0o[%jCC#fcqE("=Lg"lgF/((5Y-MXiTa
F#e%'QdklUL*X5eFY5$UaZ6:I:07i;0ZV$-3TC/'*UWZ`2ZT`NcV3k!U.0[o.5046.G'iG)5
h;]AS(C!\MV$,)\9<W75ML*SM.qM;>*t%0Nb*[@Qg'TodoFCVbJi/4fgG]AlaT<E,77:T,W<g+
W1R&)#i6sk5D_Ki4\P"_ZtX[u=*)Q,j>C?EmDD]A\S:-DrFDOr`9U\@"LSia:56GB9eR11'2t
^:<XT8Z&[ag3)UYU`QPG6:r%hMUQFnT^7eOFMhj=Cm2.%2N#H3dfS7mRbU7&g"QWLmSZ5I_S
bcHWSr4":6@,`HTlpG!s:A?Y&MgCf`qRs[>15FB&($2cr:d`eBl,\^d4fer+b!*8U^Q6>W)+
J_YtFMYUqHfN'+;df[Pm5)PbO>q_+G($n#0>c@-XR?u25[G)%PV06WD1Gm?3OVm?^(X*M^>8
Y)9>2iW,-AAR0HNk@r:Z:QPSeWiYBfV7IK[3#[ZT3LM(O6%q_.l1.r]AJA:40IUIB$IH-KDBV
L;e&4@CJZB?HIM-nW,r`3ZI&4UgK)W2>o`[/X-415a>B@i7kq`_sp"OPsp\s-8\F@o<h&[KE
J/Di5d)I105e8[`AR(dV5W:C*/Aul7c]AF)dT_?`CH<J"Nkh"DbK7l"*?D.H[nc2#Ynft&H_V
os9_3<+^BSF+<[-MSbHG;S01M]AfXE:o3-1si=bLL)VrP=+-b]AB+]A<@p$ie%.DSjDnjW*48:p
IDLKth<<':'1\rOuZWa%W^"ONUf6WUdO4\Ut34I$#bMstBkD(sn66Xo![p1-oHff*bRQec@F
@2i)eQX:?W2i<@7f0;O*&oJKf"aRK;sUMf_9U[D9<8pL:dD4>oO0=9Ts`CkS6S[3ZLaSW:%[
Q-<#Kc@03('p&dXb+^hsE.cVo<ml#?t`\a\04:#re7fe+UP587,1o;;em`gIh([-d'"+lHkD
[n!GL5:+6nj^81+]A:iKh\SU.nf=)MhL=-A'W;#)*`W0t_'Ic^I]AVDkP>\0("B,gs%34b%P-d
Aj+kFQ1T(+E#R(k'(/<LM$'-]A`Ta0%oa.(g2X:O^*W:"pbFa[njOZa^M?"Sg(`]A^N15T>KW=
R%8AJ*]A^9b]A$n\qImX&ph.,k'UguYsp?PM_G7-a\P2IP+H]A)8uqT=c1Jb%">8B]AbZ/>coDdR
XrBRmpU<%DVhIr@.PN!Kg`(rA9COmb9G9$`_IjV"rrd=IC[j@_p!R8r$._8l:$Igg^\BReXP
:4U*!F)&Ipau)/eY]AP#cOhB.8j#Sdq@?WnHE_MrEVT$1l98e"Ml.a_Q12'SucM*.g1_?/'=A
Fm=D:n46Q).IQ^pkbln>;U3o"*N0rh&$[K%n-5rgAepB3$T%Yi=b!B:>T'+in]AC5YF4_X.o6
`bHeio*;hn/MFJ:%r5no]Alb<'IuSljNEWljZV",\=Zc@;j_W^CR%c2^MZPQK=hnWP'V!BKBg
Vho,qtV@>"mZJB]An8:-!ej5<"oS8ZXun9'=Y7!,Lu?DAP:3,b?$grj`W7l:]ABnd#HHl'Z5R[
ST[+?gm.QX,T]AURS6jT*Fn'.m!1eYZTAZ#hmU?11CJ*BG-*OajM?;>mu4B/3TE;M6BHLaVPb
XiJt-klCk*7n"0Q:$@9HZYT>G1F[rZf,IAnbklp)BJ5G07`it7dZ_^Y9!_67qTcYP&Uqrg<Y
]A6--T[hkBe%67fNl&X'9;ciNt7Q`K`anX9CH_2mT30[B9>/7)ug'1M)[bca^]A`EZ5,P]AWG@7
pGa;8-kBd#g(iU;Kc5+dTe'[C)Y,Rsj9>+ioIH2tF$WJ$6lKp,JCY77lLSOH4k[0a'1nB@Rg
bB;.X*HJ8"aLBJ94!T1&ndO0'@2EEU1S7Kq6N8FIfnCd#)[;MZOp/?/\:+&8?f+2+.AASreh
#=032WgPe[=N]A\W]AZE:]A(Nr5445r.2VGF(kZJ6\V(P[oq+19IPXconWa54"]AT1KiHDTh-(1(
LlRoc+SH+&)]A,$$CiM_RH2S3-J+_!@&6/ErQ&0#.<MH6i8$pGIGZ.Ch.m:;*jcC-O6H^,kSi
mM(T1o_"o/k=9AgiDsBuXim)n3&k?ga>LF#l[[mAX8U1'M@'2lVRP(4Q#cH;Mk2$NdT)Yh8!
u\"1f3P'!*8@UGM%:U756;oX2.W(m?8KYE]A['NXRlqXgL7BXlVa&MI\_=@<Uhknbi/)`!5$`
HL'.nf<rE/Fpni>=]A]A[Z%bmc8-eeZ-r<`Dp]AemZJ/eJjfqS-#%jn!JumIH/!4<J`A1U_S<fQ
9'uqjbj\0l1nf2GOeA%m^NfDbpsRkbJ0ol<E@s,)Q%^3h2cbA0aJX?)Q?B35J"XZ?U1GIJ(K
HWqVs9fhJH1q4>lq)6"fuuOqt3g&YpDg=^3)ilXJ[O5*-6^<@R/ZI\+c>;d`<MQR:TYJC/4V
&/K!aDbO-:U;VCQ=1`YMHGdRO)^g<N#O!sRAlu;!LY=ageO$nIh*,%P'VJZNaWQ:?,);B`))
7K3H*q"JOCYNLb/+`Z)J!8_;eBbc\N\6Sj.dOao9/hYZ>6:SY`]A_Pc`3@2mH\8#/=kX<V,]A8
/W)F"0RuO8"'%+e4(#a&_H`2p!dKYY?E9+L76$"]AjX5E@4iic&%aVY:VeZVH`0925(a:a`XC
F;-Q1M2*b[9I*WVdD)9V??OnPUjMQ@cSeVb\c`KC]AYqEe?rYC%BP-"ftNe[&<fXegBD3_4i!
VfK,K`11eG+T&p(Kn'XSJN%F#qO\knc@ojWR[?2Kji6D;@/,Q4okhnhq8d^_;WkJ5`PFXQ!*
;$g+J<4_HG!D]A&f*$*/]A[b2>Z^bk0Hc6ZZ&7H[!gl&DX<9'CrV:c_*_a'\\t`iV;Sco8Uh?U
o&c3ABjPlI*1LS:,4%*ALT^8q^#PL3l9SccsC\r+c8j:;to@^Z%9T(KAV%X"-+tX1<sTJRYi
YCCOk)0_8nes1h0mHKBV,:SPf1!hp+Sj3t#-V4..C'@tLHaN=GS1?Xi&n3]AX4gTO%W0Y?lNe
)E#M[DOAV\DL)G*3F"PkrQ\\8-5dEZ_9r-Ehhi1G==#64!#,VQ6l?-&VLmhQ`jfDk.rhsB5X
VDA.:;GDE-t&?UokF]A[2J!#C@,V),$jq@pNL(Vi"PQQB/6O2X._36%B[[EIjAEL,?L=HK4DN
i'NZa6m,Y1QLXMI5c@<m>.M,i(/n(40g8hPQ8%I9/g)*!R<&f0(s_Lq+NET53SRj-ChOef\M
O"(+)j:'Jr>`GDn!AE_=^a#XjTFLC]AjDm5W0d84/8hG*9)7sB*?T%kIH%OF*.g,%NG*?BZk_
\;>OKCmf(7FrAqX\MVd?JMS+3WcTBB?G:2,%O&oEZd;/>I2Ut`@j98l/cbak_*Ib\98d+N;;
mUVKGLY?'A^[0sf!W<<kIj<a,J>^jXC/e5]AW*/SlVhTDKQ4t3qN8H6@6jY&d9Be7HUZ)9,Cb
We=&>A68rW8+VR<RPO,"bYGIV*M%"TONX*FD8qd*c("RqWF.'hKL4GL12ine(1oh([kr@5p(
%/e5HpB,s)'(me-@I!9&@.%`Pe'A&erC4AfTe<bMPT3>C"[_`2osFY%:gWA7$jA[TY'X:96S
rae]A>s7a^Sb_8TQPSMmr!,*G!<snZ>Ap2[u6Os;X0=!l+'88Phh3e,]A>KWp1E)5D_?Whj[^g
@k3:9kR=&fs]Aqn=]AgIKKm0mkJ<nr`,.NKI!D3@gtu1H81rSA0D<6HL3eRX,Ura)D82Y\Qqd:
<o>$gGEo0IU20Z.U67M[pT#[0mP=o+kD'$l?R?DhdV;&p)pPcPkSPo.^R8ZDl-"_HMa$:r$0
`EVS=Z#09JUD4N0HY"AZW=db(m>r4>@i]AK>KS<jsFQrp<]A52VE[OoKS&A(Gtf8)&'TA>L(ZT
aO<+r]A&Gom,)XN"f=@R<@'cLe]A'<jt\7d_/iq42qHAVE$F4Y-+CCK$c2$NONO-*[hAdeI6H^
gBCE[E:/m#%tT51#"j-Rlj;NBgr!Rbi3fVM+Js.)bUGf@s28&=.bTU[.P9fFY$@8eutuG,N\
M_[$>$d8]ALSG`/2oG6elhDVS"=jgP1g*@`bV((!n7$JYHlSo;@6K7ir4T1Nh++:E"6:_4d2l
nr+d6[Z`#kJflea04-Ea:TGN3K7;@g(7p0>MS(2=oteXZ3ZgR-6?CWd5[)<d0RlCnqZ,__O5
U5lff>?!frWp#9T:6391H/XHc-@/AoF]A?;CNtS*s!j:U)tUW^sCFO`ak?nnqNZf6Z[r0$l)g
M1Fp.IA%7m:+XX*/<#3k(N-W@iQS3Em>mS37:Gphh[pk?H!o17pJU/"5@]ADLiG-FmE^#(b%n
6iBB$+`<_V%"0h[E`\([_^Nq%nS3HhVr?a0d'<DZd/L"7/8L4kKCd7"TWH%DtH21=i]A;Y,m[
+&1XBR@0@nH0\75P!9K0kWKqKiRe'KQ2mS^T8b.@THu^Nf>=C%NGNfMf^["u41$?APOtj+U4
g.b\9VrNg%7'T^rQ;5RWiM0JCI0'0a!r`llUj&J2?-0_lc%2<r?k#1H(bu;9%[tSN%a8f_VR
!=r_iEA6j"ae!8Cge/4\HioVhJ<LY3f[B!"BP5tskF^s4%98,+.:edIAU5J-IB3AZ8k=6hps
bE/CVo?lee=$kTB\.^@7frX6'1=s9fnR&R9IAIIE3`?Tkb]AMd)C-^CW[I*<?\P,cI$3?Arqs
fPJTD%..cJ_""/HF4WAmcm^KLDn%Gl^"<3*@JkfmN9'E0hKsM6ib+Zs;90>U]Aj6-2M^U;[_L
<[=AfB0bD$iNn3,+SGPsFC@(q92J^fMhdf37i\[MFj*dVTJ>CXM<GCVOXS=^GDpN3[o!Yp<9
5<&akcPRUP=a\CqO56_$tL4t@.3uXZ-36\ImIr<eL?A&F?:@>fUZS[c7#r6B-NB1;:q"\(KZ
NMZ@t,p>I*aRg.O/"ZnujsFd_&7(i#sp+52!kVi5F[UCfom'Y[EmekORC$H\"@<"#VV2'qH8
$TCaH%Me[g/C6T;8_ktOkT,5md,=D`I_J3<2u5Z-Uc,#U\+J</>q\TqWt\E-kg<ZX2oKBBS$
Kuh=eQl2cJ>>X;I^_3QOogW#4?fpYR>8.Wqa$<pVI0E9aUR+i:hijCn'_dRIiMd\s"[ur^L[
IeeBC_F.f(R_,ihC[5\iFQ<jR*R;$u5O4>ljPdhY54KUu$#qKVPq:r*O2%8D?p1Dk'IR3)@(
#<UZXMm7sNRX@iV8XE[&JaHQIBr]A'lpGd7/89d2pNigsS#(:[eY181=*bpBqh=X76na0FWEZ
q\j%n!EPq7noTe;hi_%?o&%_9F_ch6m@r.j5qgOL9?EJ$d_7=;U),hINnj<3Z'8UT;<'7Z^L
$L8-IMuL)VOd`Jm5*h[uAr_P%<I"t8.i<[f37-_ZRb8C5V"_CDdISgo3QkqTUV>[Zr8LkA"W
*A^*ADf%d>+P"]AX`EB&5\eefiWR4@NJk8s80"\7H=A+SaBGLX'aQQ.r=Rri_81fV`8'09=(,
3;6IFK7Q3mA)df[WA32"?HHh20:E.;':P_Rbi7aX]AD:mVh7<n=EVZk@:*d)Md?U+=Y;+@Hr^
0HZ2bgIAH57>2MEoUG'cr."po%iG:n\c<JDc?5`*eHP;pRjqU,A@24ag+'Xck6o"la\`5VRO
g=X(&e/G1b-+<U>@]AAlb/aP\\28&XE,XG8jI&??$MSM@"o3Tdi)slS3*tP^HYB@atMKg)Qnh
kCg^YUj.iGQii?mp_1]APGe<q;+;+UX.%_%lH1.cokjO\P.G\Yl&*V1U702eo<t"P2q7%Sc$k
Qps@+En4`u/UM58Bc&HmPWr+!6n=!6^F,Mt-UUf01Ke68#(1a8Id;`WMSDa/6.a;.!A-AgA=
,?0G/VXX<Df09qe#ao)C`*:nV?9]A\n;W%?H?o$\TEZ6J!"H]AL?G&I]AXXeoCeq&\c8lra>UbT
:GKA(1n!q(6JjnVQ#!)UK#]Af'eqUq)@Wt4OFpQm4C.VF'D:>?e9TntOsb/!=+PEn%.Tb[J$B
sr,um%AdcX9i(XT>q>mkD[E2gW%0;qsNDp)M*)';Y_lmoT6K.o7N`?X[RZ1QQ0\1X`nIesgC
kP\_H@_TM+L8dhFe.hI[0n1Z_/kl@O4aOZj6?h]A6dbQ#9X#ELu,oSH\<:Bm4M3SAfNVcI#:D
k5Ncn[21]AZeqN8nSuWBe1E8I+K,-k1r$_X+`DIp!_:=>*_#H[kl]A[$Rr-SpH/9sSj2#f$a7b
75H1cuI]AsBtkM3pPDa"b&Y1f;tg,s=XrZ\gBBTQ%')K1j)F3sN*l-\#SGBcldfCrnQn>#:q:
N1gh+G=IB)oJdE3Y+bq]A^g`;Qsj;iq/8@m='ME84D+M?6^-ER[ficD)I^bVl[:0A8@hXi>e0
$[Z2o^gZ,X>E['`'#o;>nEKW<jN./fj_S;Zi$`*6:q(>p&m.]AZ9\[6ZE`YqZ"+HJ8pm57<dO
644F,T/l+6B<l;SEl-GVkqJ5aO8_G+UAeA7\80*#0kP`a.i.S4B4jeG9L@JC*sU4-Y+AS(m!
\cLCU[^eVG&fY+bVap(,Ds\/<)'coF(nE(!lPX,U9a@1<1i<*k3?)N_:pIdjB_p4Z0qA>bdA
k2_k--_IdO&1A9Mi1DRcM!d[NH6nQ$V)p6n9dsg^C#FMCe_UB@5Nha5=@KGpf^3nW7?r1=kH
`),E*8egt4PD@?K+,>aAgJ@4?!YKGKhs;.SjhD"g%'3'^NY$1I".YfhjJ`NJrAc>Q'rQLrJ&
fJ,jFE:eG@B?O[bYD8NG3.He%'[o.>$=Hg`:S=Tu[oE8$]A.!i(Fr8,X1D6lr:3/;_/uDWs5b
c`R^S3?uJEEoEt1E9E1;bbhga+N:o##qW5l:L%u>"QNH$1[@u([*?4ZB;1ukFJ,ZC6La(?I:
,ul!H:S['gc\9;3id4]A;[cu_c7.g`mXusFYsI+b@K5FU97Ln8HH9`j<WMpJLFDl9@r,L2FkA
kY>Y(enV6cY'jbnKB8J_h.q]A%&[b@`?RQ89*&P?8C*c`L<4"tJ<$&s_3&N`%D(ib@kFZ`02!
-3C)K+PBmgQ["e-.8n2+\IOh2OM\p^$Mj[,*^W9(O1,%$:odq>7d@).R"otUo`Itf+0S!f?.
g):r%;M!o=RNf!\8I,h>,1N?LZ3EA`+:@@QO$Wc%psHO!8R46\gC`P#E^nUXVS.0cE,M<6=3
6&:hu<W]A&J`l(?pc6mhUKXMC]Amf=9'88#D7h_shljK8;=GE[qlmITXJH<^Fs0j]AgOeQ4H"+P
hRO\5qIJRRLW,-=;=ka0L-5FaRTW0^ii=.b@88$s[!OLgLG?dr*mFKVZLFEIIN53BZMpKVKk
1m)*'R=:Y_\iAX$lQVZsb0%asE8>07jL1+=PA`,:!WL5V"`pb>?HLOD>TiNSAZM3$<5g;pM_
)?lhgN9[O@[01\0TkC->QPIWh%7Y/^)%@\X-^r_''f(l9P,mk"%EdA/8f_m+?`4sE)SnS[oq
^Y/omc1_oBt"C]A=nimi;pO(TraX0"Qj,)*JSZ9/+bIO<R)WkU!!J&p;\86l?U?;+?@:o\P>=
kTs[TUPt!iH5k]A1mdKLj^2qU!]A_em8^R7;uXnCKDF^Nb.me*s3%aOCBPt=`ZCHF#X#e9]Ar3=
*'`d@-]AV)-/FKT?!3[YAgHK65eIQeIp)E?(S!rF,j)9qYE+u$3.(P7/C8k8AOVt!'1kGmAdb
Q5/_NsMFrHZ-n/MN9NDZQT=o<rPW[e2`B1]A@Q?t1O+-8"8=iS@42lK3YV$":'SRjJ2dJIDE@
Ge&UMUs8kQd`*j#Mh3JoN'+k?Pp(@!hD.uUh9e>$Fisto;\),e.:'T'HQ3*ib\4l,7$A,[\`
W<,;Dtb4r(U76N79LEnhVtfs<KW`9L(^JO8>eKg4^$F6<iXm9)$?Vq<OHP\YaXAL*aai^F&q
;S$F+$Z&f8('4Rf4Wrfb)\l''cc'OBCeHuOcu(c/"DZ4:9[\[7%2puJl#F^'ZV0[H(Y7.I1K
Z]AD$qkErk\5"pd]A6p*'IN#4;N9?QOjca'F$Zg6h`tIGZrnp[LqgmeLNsGGEa(6O^-L_2^ZTX
P:V52%f&m`-:sD;'ULpdg7I)UjkM#]A)Y`T@gs0JVD0hZH!hE"/UPVf\=oeD,X[oQV;4$`Z?o
rM8$qf(-3ihY^U9kg3X:P"<2Yb17JoNuLC@^s%C94^T0f/=S>_!ZrC;GiEZ-@6B(o"o\I\Pb
'WiJgM)pnbm!<`em)!B=t&nI=gVgG[J=>;kMe3'E2!kMm\b!SbA@:-`SU:e08SIiY@^Nrb$'
O*mOF`.TGead1ojP(L*KiW=M7o778bd-Tn)GCD5hDBLcUok;4GmDH;63ArXpRV,$6XU1*[=h
Fl7I8]A@n-0t\m7uP$9obFl9;%I/$P35&^2`_D^d^/rODXsL;(CjPGH]A:?[0Btsu*Y1KYki3(
%:m?#M'QT'o*MOiSpmC+`K/]A*&`((MrbJ&)ZJ+%SRSCnAhUub8mM5qY`kC68B&SkLNle4QVa
m.\N!L-?n(-ip7Ko;[c`1_;Fj,jr65AsA3W=TARPFPX6CAlG"f[AH/)4Y2oU3C<L_r-D?Fq:
EIT!R7^o?hXSVZ3^m\?AOFH6[5EPkSg.H($_DTZS;B(HWa>o)//oo^bf_=7Mq+\:(L-K)AkH
&#YoT_9K[M^-g#rV!OihMBEUiH1L*abPcJ"gM^T>^f0.\Q*Q<(jW5`u<ptBQ<8eSZrS;V:A<
@SA3g"1iA;m$1cb+X@iXIRn=DXFXNJ;#Gee%1gq!mnuSPge+#;^@Yc*,C,)ilS&.F_lAGtlR
/qZjdPB7kRTC)16P\<;C<Uc\esZ]AlE(c\eY+]Akg<]A1KMIYfFK!K30@XJaD?7b8gYaE7c&3]A^
S8L7]A;qmr;@SDIUFTdhjBF`R"d%H%mS;&.]Aq3mE4#Nrr72V#lhdlZ4Si*I=1f^>U0=a`Q*G^
k'T;ra7H3cCB6eg"*>#'K-R0:Z"!nHYLY0\Dm@tSL>q'q+-B2@F)*fQHO>NGu.>HDMJrm>I[
;u.VW#-enPki</Qp`;1llR1gUd2fGVK8Yf!%+?GZrD`Lq2K3#[B,tH'(d$oNbN2't:g'DiHW
Z=Cqs^\`eq&j>V`&YWD1J&pkonGgBFW,pIVQB;Men5aWcGF#f:M+tL"+]A8/L"Q"/`/nXa-c!
K*[]AP<!mM@]Aj,7;s%LXEH&c0M83n;QVUf^Ur@jB&g!J'*h;96Tj0(Yr3bu2%ggN>\*)b@ehf
?/dM8hg1Qjbb]AoKG!U.CeAb*LO(qc1M*,5qk%%37Fp8E8jaRG0AX0gY^2<YeG>A.,uJcRrp]A
e$]A'kRoC=ig>G`jKG)[X(q;[\1@WRN+ROAZ@>5I]AI:rGAaAW.O960h`ST4LXI.G&4Gneugu[
N9]Ak,.k\LeeY?L!XY\%/Ego\?,MON)P6lEYkDDdU!mT0gOk9ahrr'1=.aCQW\%7S0<Ak0_1k
&dko=`-=n4N;<?$FbT!f5b9Ii6q=+G0m\C0n9b4-D6,I8I6fEd+SIGmG)XV_f3\dG_@?0L,-
?mW8&]AA5a!*=E##T1T*;;G/$l!4rH<!qjiVXk_i[bKk*p2)*:mB.$(usiP$:8jeZ'RQ=$F)1
]AemULapX\Gr")Qeu]A_DC+AU*EG"^$qmb@$I8DpAPO?]A8Q)B<O+5\d`H\a-lp"V[k[9\77U#r
9]A;BmnJ=@5bn(9"7[7J8eL*:UrW3e]AcKST_/HA!M'hR^Xf5F_l?37[19/;T)`@bI:^E\'/^[
@YKbC0U<9MP2'?@:%G^R0<&&TR;JSZ9o<eV<4Iehf'C8jMZX;?B6U2njPYF6%:^auc#V9R^@
"81lD3Ve_^X[>$eH8a"p7R@V_H.@/DWd:s&;F,<RF1n==+2%J^Y.+^C;PJ$`"V(<^#YdcRYF
$/:YGK'"5Fu;V)*)*lFq]A(qCcVSR903/aiRohXmf]AK4T5bg[s'9K;/248#^DjrUX'N)UU\d3
\X\fW[_e^+tWEp=KWfSYRZ'm[k9f=FVmM=E'%`XWP?G0>0'9YnIasu$Ptm^$Y&>hpGV8A0dB
,l*\Q5(["j71J5`jZs'AQY6p^<0SO>'NCilA]A*qBut:l/\L2?MM&0hRs\[Fcc8^[_d4*n'C]A
PA*W<?G%9.%a*uurV`G?1U[R_)$Ofm664Qt9nnM+Wde]A=d'iNAP't439(TY@G$JPHlL_k^ok
D*U`Y&h+at0@iW:SP,k9f$rWn$u_De+.TPU40#mb/PPIEK'TGb,]Age<A>;UEffB*g99U7Tgc
(EM*#uL;i1FqWh"*c8<eL_02cDYq-\5E;6+US*a(^'6a&tWkoi2*r)+LBD_tE$kabT>CN_>q
Y?,Sjei)_:m6^4m*^H)m=k3af@uHP28mp0Na\2r#l*Jl8_:j1CaVV]AImV/1-8c2G$Lo\U7`-
Q2!cOoq3ug6r'V>0]A>!Vd1%gL)C$2mIWoJu09[sd$`f66;&P9m8cDtm/h&M)0gB"0r0c!i,'
7(LdBpuD^n'\C]A%I\L,j>/O2KYD//L<#:OY>'Y@\!%0?SPZ'5:^mY"u&"X@WQaT%0@#W/36H
EPIb;:tGp6-d\^@"l(IgnmsIQ*8P4CsE8n:cqD?^q:ukqCDn=.eAGXe^f6kR(nNU+SJH6OCX
IgE!j4MXHtLQL7L.ZOGm7U")I-]AeL3,_$SA$RQ&GQmiQYuAUhWN:XsK#`LPZn]A1P?>"Xi*+S
T2BTTT^1d-E.YPV8N!-LYjOq(!ieM4RpthZC25JX#gW&%$2DY?j,0<^]A)2+So"/W<0QNLS%m
"ll2?A`o]Ac+ZRR]AK7lXnD0&@AceY8s%NA=KpA#NXt)SRXZ-h]Atl3Wsauh$h8"LSQom6=_"WN
q<GDt,@lHic!&NV5Em''B\9a!@:XQhl\NV;`ath+B^qS0_mRD=Q65hppH[57jE]AJ);o"^CdV
.3tE1>PLDm/*KS#HDU/q%"IZ""'lf"XeH8^<HQTesXPG)?=d_[lC"9s%bs@A=XDfSqM-B7&D
tfRl]ADo(L'qdhIf24#"''Q"R;<WE4#ZfIGskIR@jL*FW'Okhut'\doNXgCWX6%=$<=q%)ihF
[;7=Vc8b0bI7d2A)Ih%W18J[3ac`9<*$iD3L7LY:B!$s7>UNQC_k":&9KBQ/pDJYr#)\_-&s
D(5^f,Kd;p,<o7r[E`H+AqlPJa45t:N'QR@^"'d$Vg1-$$ro9YIAq_2l=2=/eo;bd*j"2Hd5
Lc3-(7C53?_)(.V@anjU4P]AQ((8BX-fiYiMDH+A.:*+51^@3C\WAlhJ4fnR\4auF(\\Kn&0B
XPn6Zs4@U9")/BPX"Rag>gu0nl/tn+jJ*?`e8hXm)nD&369U)Jm5sel9%hGP^NHH=csMdfFK
GMS\Am_8ia[<P]A^EIrC"$:#$N\I:3g?4aUTc4$Gq=CT=qD_640>K7!eN:G.rQF*Be@%_n,q*
(^gh"3o'idsEODgsIml[/3EfqX3QHqB%B,]A'X<>KJL)MBML/75JQjH]A=F,BY<]AINc"ZkI+Z[
%/b\U`kbPIMKa3Wl`6KH-DHtZX>\>Y5s@AGT1:t?0b0Qc6bojZFBC>s<A/$Y:=5?\S^bp%8J
6.0:P]AFbGlp&B<H8?"V'm-?cf6dn4ri&=<6oDXf!_[i;7"[_(SNnQ^'S'&*RQ+rS&]AnBo5l'
2&DIQIG0,o08UICefdJg8r"csTk8)L-OTVp1G06s=u9mHgQ_.YM:Fms7!<olI1.]APpA]A)$Q'
_g3Zrf(2-;/RVXdW"t&[+G.7pa/m=\3j+jNAnpbrU\.(D/2O+2`UoC/SX:eNPFMb=FKg<IK5
inun?g^[B8-coXJV'IgJ?\IeGJB[]AGpu7tb_Mue2-i]A9p3#VUQJOH*cZPXa>N:eKX]A*sj,*s
7Q[N!/i-s6*1jU'o_I&As&g$"5l0-!Ih<SU8?2S2LY%+rJc=q_UWa;_NAJsNQ\TX?VK>Dp-Z
_HmW3Y:_gQ`"W7<*&[`:gM&4`G0B[8(!]Aj$]A;0>_hp^Ca*:u(9dmSQ?.E@Kur6otbf@(llI*
M-FdV54%&^l'=+WNti:JKaFPpKh=*]A7%t"@U[[1`d]AJC,1Q[$'?"/T%gkCk6K0`"<Q$9cHAm
7@;ITUU+]A:W0=NsnEM`d6(P`BdL3#H=Q[AM\WZ8cr\CdT(>P"8.?6!bH=d;OY.5QcAAm567/
L`-fEfGgbD*GIsYLfnbS9.Mh6HP)D^7iH<9IpKVjn99Qh]AKI<g5Wktl?W3PTPES,>E0HSIZ+
"7F$O#4!@rD;5ZXsiel4jf3IGWWP@M7*J<G'i?eUo7?`o;ncAVKZ)Z0V!s7N^p'M^lSCs$XI
*3EPu$C]ArgQM[r.;)Z?6(19)(L7N-AYqSdC0&<SkG?[!:1@]A-FcXF2l&a2Xu<jdiCDmN]Ail8
Yd8P'==[K'g"u@;@kfY`:*el<3ZW;7FM=#'s%\F]AiM0-5s=I_)ot^Dlq&u'<:;oU>+I7M*I)
C<B3;G%F]A]AF'+*3i3A>Dm*!`Z-;2%='0TZ7/n=n$M&[,S*=3F^`3@;SbfQ3s!?CioCbbW4(_
>Im2!^Wc%TStFnL8?kIU*KrU<:6nsl\$p<(W^oKm)7pRV=gTfiC#?1%=acp__cBt!GgMZn0p
@;S/[JuV4C4J#baXJO;@TIq@pX#hVE?bQ><&5D]A_q3K,e*9a`Yn:SaOYcN#luG*KTU>A>[.d
hR&jQ@PnHaTDL(b@_06Q*^KhV\R)ec:"DKMCs5+KMiC^\T:a_=I)0cGWn-#0RcTRt["E<k.n
!mh0FF8&;''>K;Y'\NLoI+6m%as2?ZZR0r9Lf+ZeiR*!"5$=k5g=SfQ[GG3?IK"6mf_GcRfh
Xp1A'<1b]A/Fk+;#5q?CO+GcH)sfJm5iUWt3M4ec=q#,Zp.?F+B0]APl;mD,5_'T-]Ar()^,]A"-
AIgLO3J,:i+P9Y[)YYq!e#G8km#M5[B?]AK[$5^6)OkZE^U-);;JpG8Y%]AE`a#Y`7T@$?ffEh
%&gf<TFPq#j?=/\'iSegG'GN`0]AH^,POq4!p'+']A4?g=SdW><1N(;aNK78`RoUok2@1W<djO
0sD!g*u!HK0(Pt`?Z%'7Q#g/OF:(s;CR-Gc.!@6$1>rGTFBf%=;W]AN\\cc>X8YFIk&%USu)D
l\7m:PYJ\(Q:Vf68Dul1EuV8as/A!6lh1aTrI-Er%]Ab+HBjGe\oEa'XQ/t4mN52oaEluIr5b
6qt(p)TpCF@NZd?,]A`E#[s"Fq^Uf8=F:P?aX8`;9"9crUL+hi1r2l\X?NsS<8%Br1"I80+9h
C_A_A^^)@4B%).kJi::M'[k/-8OcS,.@TZCJXD0/5Dh-TX>#I>o$WYm?u_^p_t_(oJGG<lPF
A86jQt:8=_4"%O/O$RqX*1jq>;,K!udWL%XUK54C4.hu+=k/5>tQO.n_P:BZ/b.2B/8eWbaZ
-oX1>OP9D$hJ0LDQettq4acCqa+j60W!Lc3Afp*3G9<2U;`-1egjn"*'._&Z+Z(E]AZNG-72<
PT4I]AtZ\(E-(pjc%VYYH3aGkT=[W/aY]Ac)NH>j97"OP(7q^Sq:6'gO`Igb(L[i4T&`?)`_ZZ
S^9cagc'r-Q/P"30RWXK>D5Cu[mVQl6-No?MSMJrqnX'42_h1GK;Xp<"Bm7Vt9r1O</0s$&>
11IB)bYnA%@8uRWQI2&WO4"3Q-uegaNjGklVP&nk;dq>O"B1U\Yg,#CWSg;"Xjq+cV9[&j?o
\`X]Ah-&dh(-kpMJDn=$q-eE5<n3YClc3AOG@1Y29sK+U\=M!ZRn_762&37JQE`pB8!.Zg]A_@
P]A(83Us7QM"hc,c.0i?67kLSYGKVON["RM(rfWEF*]AJK"kSB7d5'l3/jBJh<r`lj&Mk&5k!'
E#\<pbe8gIJ1l^@0Q\&=eXC0s'>Zh"r=,_%M5d&Q5c'$jH_kWed$TO4?gpa-]A-05Ush1p0,S
qqX=)n2mR4uh]A'_lC<$H>;/.(=&gu;3=DO.J2U)0qbDg\a[-UL=UeTn<60TU)D&f1&a*q;WY
H%7ZHog"Oc@Sm4DP+G?^8$sua%lI7<,I9MUO"MNAM0bmP;PtWa;&R^dB)\[Ws1QJfkIQn2$$
MN)PXc\<+#&t^TB:qb3bnLq"N=>0`ID+BUM)2@t*9eVt>d(F:Yq<Wc8,GOjf(oZ[=lQdn:$Q
:,0bHOUb!hE[6ScI&i2Qg9VdUTQ4#D\.A+I-S3&o"&j3rUL'&bmObS2-1_GD><Y8g91L'[fb
(Xl#Q^P=CkS+4*S!19fFfb-@GP]ATS4TFG26>(F(HQH9_)F^HU-3=:Ps`?_f=/?=A)QcnMLc^
2Co_iC2fNXG@V;n2LF?jGLd?N#pH*DDTYBfmh^pO)O!e.;++9:gH%8i#lYHl"P#)@mQ.p/<s
&`R8pX.RfjB(^eAstXtqqDmMG!Vol#j\:bp)7B&7B:`id5I?O=qii@Em<EO_g,'=,IAr7;P'
/-BL,m(M0(kgG/NNiN3#@N5Uh6?_agn?pp3[f4B+<cib@Q<AK4S-2FOFG%Lg2oOQV@9%MQ(N
NB*oNK>o\"(bR`$(?71=*F@U9*N-_CgpF9V>N0d9bsf4dlm[QECTSkM99;k-#3NS87!$P>[@
6s[``@GsG]ATrj/sp3ND*-iL#Q:WhH/4M*:2RVmg.1oJD]Agsd'DQL4oQ5s-6(=;*F:5i+mU$+
Q<4cbtU!C>Q^qK[EV;IXrf>%dI&S%V*e<TG,Ou?k-ZO;;8=mOZqC7@/odX:k>V)@^$[#E0ch
'lRjHN)3fAmYmr_s^H%2Z&AA:i;W6D1_jTfhMV.kNua!>?YWN[tTORrAebjb[WQd3)fQ)*n;
1b2aY%3<oQ#oH"S0&IJ+bB1tTAF%]A7DDcgFQ\n2iqejV<:%Dk'`qQqPflq&K3^c6:1qL>/AQ
kGk39m_`,,OW.SB=]A[B?fi1G9k2R5j;uHO,8$T`5EpB36*/U%GB+F1qg$#I0:qHPK0WCsjc8
6LZhJ,Xm>AlFD#,&qb1kTLkc?[1]A>&74:N)\MWHSLf9pMfH2\%b'umI]AHaU8tm#eef.V(^76
%Y);W96^2?9m%;+8l]Ah0H.Jp@=:p`ZK"fl8rKt*[FKJWIhms<rQE[]AFb9jJ#@$c7_,QY@A-e
KbED.QubO#B"pIZm/MU,?sXqq>-0dYu*'gUT8.S;>]Ae5DXdgT;=51LSko="X?r#^5AU28bPE
\+5;L'i=Igsr2;4Bfg5!+@J(Ml/h)TSe1Ucd#_&L@V[ZD_n0o(u!2U)E89u+tY@CA_dP%+ul
APNj9WH[`83ME0j'[7sc.6nPF4B7J:!e!DW-J%MW50XMJ&eW);ctT[68:sb<)`u(Z4$l0H!8
!Ju$&Y+ShD[&e*"ZLPSl#jrqu,7g&WnlDO"!kGfuEDu:.,BdYBn.BI&]A%aV@dom.[[o-&ng@
""W:c2dDlUCS#ZW]A1R_[fh2S>Sn6Jq6+</G;pPMfX`]AFcR@T5bU5GUOY1_gd2?`8CKBC8U09
T@C8i!&ZkaVRe.-@oUMRt!6\'k_(uKr0R%VkQ:F6RQPsSfnJ[M#s_QN?.`MbpD8L-.j!a[Jo
DmNPdk;3MS@1/(/e*K<D;pEJMNdP<qXc\tV5O8b%SDrL8.90.TI\OGiV9k5u\5kNs73NcU)H
?)F2kM'N4JM\pVJq&/C=s0RsHGCBU*g#ttj\QVCg.QMJHXrD@GJ)43c;,^N-n=]A!_[2k/Zq1
%fLrMa*e2d,a+eElNpmMR78):K5`p6OrV1b*b=]A'*,N=Kup8i^/m%'gJ;2Sg&m>&?`dp=$*/
8cu5^+4Ou%M.h6E%S-T(VA>bsIcUe$WbZ_eBBZf_/^&oul_b1YQ?_^u+2Sfd&Zp\pH5.^"LK
I#3A#23BfeC(PScKLJB\8Ua`L%[a!*g%@'A7gLL'%4^H@]A6t'T!>UF(^ttd[T]A5o9MU[*<dN
#Ll>`4d;fjr+YeQ]A%I@HIB'`j0CZgDJt[\:@f0gFC+;H:AqA)oHB$oQ'DB3_hhZeC@)d@Z3!
m:%r-G";!uCOtJZr\:m%oo=]AD=jR!8Arc>LWf+g^WoGcPA.=%7:M+>,cn4hj)1.b2$Up:-0Y
(dAmD_gpRViA)fsnu4V,'0`@HmUq`.bJWFa%ssPVqK4"Y_?[')>>>_CP9cp%3i=1SA&E/6P;
Z*JY$4CbQiq`QoZ[/*UND6_)UibVn1c[,$%r2D%oTW,[hZk$h^0',*1J.rK0>>lQ73fl]Ak%1
9S"@.%F'"%@Hb6g(4d%-5#+J7rCY<="4-t4)Pk8S&?%,:@%9fdh)VOk=t@jI"no3SU!1WIJV
a\M"%;fVr;6!Agdtk_Z$'JcnjM@rk5'B@f-Ata$a&=]A]A'M/cT+5bhVkj7bMoiZF#/?e=;C<0
0_rsA4't>(`CdRJj%>j28P\pX1G#uHR!p<JPT^kNG7SrR8rOb6/G<!ThHCa/#HW;$Vl-_f50
6,[-_XVMas>lnXI]A)J)^2[GI2baFLtnD//LQG:e*1h4Bu`YK_uX<W8!o]A+6P!c342"5/frM"
ujS*1e.N:nWJn#qSlcl(8<Y03#0;gh)knSqKF-%?Wpr`EnL,UjsF10Jlro9J>058]AS^\@XmV
u#G4EsgT1DE\F_0@+"8p"i*k(&;mk6\>r[KC-#WAYL@XD85r:&k,c%I(m3?3#ME6m<2g+V=R
-+JD8o:>-X#Fc_h@&nq:X\#o.rhVf-s-')[XFMg,XJ1<P_6/6qI?;W/gnBl1Vhi/DFU.j$Ps
U>f%Fe6)6-qOJcBF;P[8BE5mJNIBpXDt4X)dEHE"Y(2<"7kJ0mM,Y"XX*@=5=o\AY>/]AN^U:
LZO))ZC>cU@h&^Q"GVq7W`Sn^@^Y&+JAeQ'CdEoAeCbNlrYsI[Sm[mfc5&jgg_SQa"ZH`;uC
MF**r_cJJ^G0q#FL[nJ-"r!dJk=58]AQDM(*p.mLP*F^#A;h\VRY9&*mZ/?g)T0\ogFF$BFGk
l(N>A/sYQ7"-7mFfSGf;h6.GNZsp3!<[KOY\<Y691rJCJOe=N6?pShLub6pkDJ`@^[gX::i5
@)G!OBK')[8!9f$LN,>HiV7F.b'KZoPjZ(m@aLi`$:"QRO<#QF-qKI%*$<Rse>>;Pmf"c+"r
fU`l.gpUOq<u'O)FXl!P>/:?#CYfE;H%0Ie#bKd5Q]Ai=:[6BC,gY\g70tcUi[[F3LZ*eOiBC
9fBm@sWp3U#CqiKE::+k*<=cCe^-1V.K\F0[r?Ie_#h6Q:2rQjM/:EF^s8;L"G(Ck9n+%SAZ
HanVlD;nbaB.]A)G02`kt9I'OOhYHSjT1$orA,'5U6.d5n=X!E!_X-sF>$1XF3p%<4G@=/^/2
-;)/l#mYRbl-PVD)%8b5C5Q,3V.l#mS]A+Ld@,"A;=kWe`_)!JFWX6;/$QJ-fUgVfD`&jdB5-
FIB)$6O8_0!O`k:skZ9mScpOaoPFaY,HDGPngY.*Ab_IL&^7;?pR"3Z8Z#"p3aKo$N=q#Oij
HQ*:*fU@fl4*L&_^j0KM_aA`W_F$[.CM,/<EJhNK?[^OC5j\k'98!9EQ(%_5r0_u7Ji/(^Qq
ppdIgeRi.iF5#0CLC7aq9UeVF(#,agAr-gd<>A/Tq+F8=MgjMNs%1!=@;XT(Z30C[DYY*OT^
%9@Qr?^$s9)bLR0V[>/DM%?6^#KJ`nEI6MciK[A4e$+pAMI>)H$Y9C\nXofmSeRcRld'B;Xq
-0MMh3HbE,X(R3i\HUT&u73-*$K]ATemtqX\2UQZWtM]Al*7UMH(N?q-*jQ?R=&%9?j1g/5X!.
L%7:IYOeH9`Q!WifK(E2]AJe(YQmiC\h6_/EA4R7t[7@-9ItTDROiK<4-@nr_pj50NWEiX\P[
7bPaJf3]AjC[dhn\`n6T'41)ob..QbDq:%M\$j-@jpLdiN>]AoYVSe"2:EOjRa/[L!"5*oKWm#
lKFrKi;WA_[FDZNut+QTJE<-YaU@Hl2lQj%gr9%1`]AbEKK<+lbT>dH"=fLEqRJ*"3Zcf*#Xj
Jg6[)CEu0)AATV;a>R\id&L(QVh^n&-(pu2:K(W7far%Ct8IS='P<.tl2*a`:)+fam/_[e@.
2aM;'u2POQeF?W;0tpkg&'l2q.fl>p<uDe(E[?ol&Ch&[S8LfF3!Z.imr1"5@$SdHFgR=@c_
3/V9'='3alU+hg%2>^TBM8f:#+J*6AXE0)kBpoo"U\-?R!NIDu<9gt\XA1.e#UOVXq),Ed,[
Iq+\((j19T@P#CBSQ?ogEj:E?=YtH5Y?r^BW=dW2Q[(.6LElk+XYkMZP9^"PpTC"*RqkC\Wf
2iOJ@6`,asTdHXa[`]A5EQA.J3'D!EJ%Q3H\A&q-*<eg`Ec'Y0.qGW59^pXp%lY)Ec^grIO*1
qA%(#I"1p;2N:<(K'g>jQXsh4)7M!7!9fF-Ih_L"0Uooc5n`A>eKi3Ym!rO?NU.O4L.t`d__
`X[r!MmetH)Uch:9en9;,-Z&fA5P/nBk59%\/^4AGW`Z)L1G[$JGeg3T1pi?#EGk`85NbpeG
kd.D:(3[5Au/5(9eZYSS3!UnN2I71NCsIX;_R>a?uAMO3kJ_3'0=2kt$3dc[63I:S14IE<*i
8u/?-\K[:%K:aHUf-9,A^A+Tcnc2cN"P#l27QXIbgT@j?pL]A]AD2Q[b-_r+1i\dgf9@5/"]Ank
&4qC:ZE>pDl=G#&uMC)Gcbs.UVEW&QoZkcf3I`T&+-W;JQQq5-ir9^7Wd%A6/RME3AOMcf4D
"BOe6lXnlrH';XXG^-*_-`uHYuA_sic5h?ZuDIYCN:uL1OU?C-c]A#Y8MrZBZGop`=5R"k0>4
YsH8T??rg5`:puER,),<tpd\W3;Jf)jGAPZFhe3!q,3C,-l[rIkE#3i>_iW?iolo46U=h:RM
$]ApnD/4Faq:E?dd$hCBr0uX6:-;7^YsZl.3.uA#o,^LepW<8#L3oS;!jA#=s"Mg2L/T.OI%f
(CNL#54.[7$Hq[8mD>\tC_N]A\>9gis/g"WhI-Ylur4Dr+JS[(SpL0g\pgdtt6jlNZH5CnM6E
if$nRoGT&:ij6-[%OVIWJ*P1!6eUD,L;b>FSG\OrUuS?6NI:_/P]A8`3u'(kKk^k&"n'b:<Ee
j&ckA]A=_ZJe#a$kAL.!a*oI040XGBm<qY<t(gGaFA&d<ucEDGp%/&Wt\q*_Xc1dLu^-=Te$:
"W_W675#kHY7Jm8T<1I7`>=@oPC>lgmpUFOn*2UPA$RW49/eM@64h$8E)C`mBLt_K%:%&CD9
=9#2-SZ/]A),GgQ/Nfhbe.d0YUY%ESPSSlmRT,a<<JU)tnEXnfM?OjpZ%]A9+La7QI$W(pdRTh
gaON^>T'hdIo`We(NarmQ;mWrg5<s-CeD^^PekZ\DAIZ[Q/sWI(E'3(_LOi9qn"JA!MD[%k3
S7=>F2K38s0_?CEoPS=:=#15)Vh$T7=@*N-bi;H[h^H:5d>\T&sVLq4Wsta_`14(V`3b#F-<
pF(/-5C38EtQZ@M7=MTP_8_c@^7=tG+a'\1t_.GJAl`<j]Ar+VH7f%ZPrr&PkWE_Z[0Gld:i1
i.#A4*@O\b.2'PQ\cc5.Tp(.q'jtHF&dV@;V&!?LjZE'DiZAl+U`G>+(bDk>nfd^._`<`+WJ
0e%PP<'m-\#-Z&[?"3DAmgV]AXa17Kt-CS<%>Gh&lZ&/!*T@G=W`P+s5h(Y$@E_Yja8ZZZ+6i
D<X2,SHhNYoB4MUGLMs%gn.^b!`kqT17$)$kPD>'d)A=DhiIgM&@oRjQHWR@S(SsMCVFc^;5
V!<Gs^TOomp,*V]A2>b?+ri<m@jg??);((%sPU<Y,bbY&gUYDX3DhmS?V6aIB/eX[1L/j&Z`c
=qr^sZ;qk"inZsHs^10AJB7I!GJ\93:,?.kAJG_uZa-n!ZIn+ssQ;J8_MTbh=&defLbo<)he
fPrTbrms54IpZH\<n;Q\Ed[V[DM)g#AaT_Jk.KN\f(;D6-lc2YtXH7!kX+B_B$nc->3UfHWJ
_3Z1.GBD\cr;0Z!W0C.H$DqoZ:i;dn(/oYg2E<-1:S<;8f)Q<ko-8HBg8WRO[eF,%U.[OWHA
iN"pr>2oqN;>/o@.[&)&iVC[J&,sei[sBZGYdU*G?jB7r7Nn*TiR[kMTI+1jgU9A(ZorblA,
(Y1+76p%^=a)#9J?!bju_@oPtV1c-iFqTAH;Nf(``.dJIm[[\JDE[goRSppAB2@.+oD)n@GB
8NCmpZ\J5.;Zd7I/#7d[!JUp>jm&?("Sp\W*MlkXA$kg9Qif^^.Q9tsVJo]Aip1aamG':6M@'
8<'.bu1H"aFRpPjLP7g_;eV$O@#hcd(Bdcs*T3D)-XS<"97[\j['Jmkh@=_@e:gh'a%meH8Q
u1PO?/-j)iJ]AP\caD9m9Ns8s)r,k%CX497+g+8[hnS9OBaFB'Y&NVO4&MZb11-@K2Y5T8e^)
b;[/6S^pVY'0$Z_j><_V1'XtQErcI*/r[4[Ade$pY!;,tEBM):dPmE9<U+q:jlGr1[Ce1D:L
<0IE8Lq:!$aC%UT[;DL+QrQcrTR=a`FKr5N]AC-)q!Q>+^u(N*Q.YIFK*:!mH9,&2\4=e"*5O
Hl+_I6B$2l5Q@W6(i(rnrgYi[gTtZ5J;ESFf7$!A+%+TI\+GSGbrsN9&0h@4H'!fYs!L9ICp
F?djZpVKRH,Z7X80^atFS1:N.k,Z\jT?=NFieHoWo6g$.^-^804*;G4`lE^Cak_W==G5I#M4
2':#Q97I%.j,p%e#-!3OQmI]Am_.JE?p0A,-KgiqS<T)^9;O*N#%)J_/@bTOlW1+6aqPT)B*E
0V8`c?2ofsC0@,.hsi2%UJ6.0haGf@;"%g(3KVpV&TAC+b".p+(r3j^<2/<(.7I``mu</A3+
Ru[d4)=[.>"RVQu,9L_96NZi<TdCYB=tBk]Aj!;$[_Eg\uS_rqTTSk!7/K'@nDTU%)W>[eFe1
e7.8:T%#WC<&CXcl5[T)-W!IIAq#5\FX;sXtZK@.)ZNW<.4rSVqM^N&oV"!)0D?@THBms(%p
,j(?b/\.]AL>o>-7]AASmiHjuD6%hIk?KXC6/RQusXD]AtkbnGuNao9R7cp"Pdr%#<,en[VN_1C
m`15Em+*gJk`K"72r<r&im%C^'T]AAN`"rRrKT\krC$7e%5tDZR9LTpUD/qeaeKFgb4"mfuk%
E5/G9k@G1?OMj4u-?mqoh_.0=IVO>$C$EY;:QL!K(I4'K%@,W8F>ph8S\Oc\-_M=E'+PtsY_
KIdgrU$mUii#Q_n1:pKD2lW':0aQ+X7:MH[r63JO$?^Y*F:oN1HD:FrIqfJ<GJ"GsF>fn!5U
=d[f$-^\uL7E;Io:(KKA:#-!\s@1e+h7b8oI]A)Y^.,=#'4=ELb0Bf*^QYP@IVrAd7j-7PbBk
A!'6B1b'b1R-U43aN3"(PcI&2RA0>cel!7@=<ES9^ge)5s1Qklmt&9>cAYM:SHm`@U=Xb,OQ
7\B),uQ0m;t8:"jc-(>E$1.loh"X3lSs'mX1F2BkLJUKtqVa*M'm:^PH_*csp@q52lj1`aC7
Tr^2f0LqF"pJQ*ZaM(#YIKI&H!&*DUU,">?mSS<5#6+fT]A&P=;W/qe=2/n4^H,1.0ph6bg"G
PXGnl\=l2h1erISJslJaB&+T[1\`ZZfh8m9sF(&-@"fZ>R:Fh1AWG)-#lre#*b5qMCQ*L,hR
c6FD_Ws2W<\F4F7TZMYRH!trC4!7^>SJLHjjqM@ckjGR.*O,9ApD[):rlh0"o$ib#KNR9!2r
7n=[1bZjOdR>MVA=I3W53q*U]A5LJ=(&n]Aio/-a$VF?kV2i/I=HUQHFACi(+!<O(_<EE/UQNR
(1^_#MleA9IZ:C`6f;`e6C5<-%Z;M'QN=;S%3hS)d+ikUP4I>5B2r_KniC4B"J6GdVmc6chn
W'1IFMkUb8k27*PKL2lmpR4=m9=c[!^M,Bi*J-[J8MO/(0cA.:7l*<uibRWXqBk>C^-<-%Ht
(^X:BQ2u]AG)h@20kp^Y9_SUiiO!,q(?3olLNEYThbK,,iT<e:sdn4?D/!%Dtu[INW_*/p?Wk
/W!33^"[r#II?VRX$8r.D)KokA'Nj):*oqfj5&g#mGBR<SRZBN/]A1GX(AM1\4(NcqC"\b`$F
1t[Dn:455.Yn#sb?$GNidX_!C$3m*8c6$>!4rGZMfZQUJF<US=\/o1Lh:kKgUoU=8N4H?eTE
^<!f"RM8%r%d9Ktf6rd,,CF%%Hk%l_kY>H:ZFV'q2nH0oW:C8X^j&X7_D*^&iF[6<D/8@8DT
($G^c#0U[XSAq$'iVR[oS[&3'oVe_Wcs7.##V%I(pt%mYo*I_mDNg0j[G^G<!h(e?.i!KYPI
4TMMHX=kHK*7S%$r@02dNQWHB?_X3hM#=A$&e*EjC-J1agb:"GI^olYIW=)S*dDl4A@j%\Cn
ujWhS[lpr72dseF(>Xabi-UJd()nC=nPH4iE(YkSHeG>@o.ADePorjHcqb?fI0<j1I`=hKBL
.k?Fh5OU)KHS/.F1gl[BdNGr+s^SMRM$J&7dhZj"hHZ1CRRCEC1.uBQ+fZZLc*EQDj0ir*,@
I:;NP&e.:XUKdD99^%0[YG$'G,bb%a"o/]A*ba3N+"/>-H>&6m%]A[o8F%8E,,H8T_sQmYfD^L
%_eJh6[C1--1k\b\bS*ngA'9kc=>_DSGRK9b8#2NDj3qd_[+"c5mB<,PA)]AnlNr<m=(m5,qc
Is:PokA6Zg>"6,YYqU,4u^2H$#_0-6%%e+YD+!&\K5!B;V*h:.kbYG*'912'7\q2E9H]AGU7\
.?_3;GMnFq@T_#:BIt')H5f;3+#5NYd,K0#R[aKI6Q8h2k?8fBb9h;)l!S+c&UMksPJQ9l?#
q<1O`]AdO7b`kO9ng3[u3fCKaZCuBBhZn]A1r))=iK[@R2nU1R$lqq%b+JW`d4n`;I&;Gl9MA%
5L7j=^Bh<'Ja\E)X90%f`.ehWGN=U3>dZMAJ-Uc#)QQHpo%:kXA:Y>r*:,aqi<pJrT#9Rqj-
nMaJlc[6P(q(IG!nlA]A006u.c+(OZ:KJf?HN8[6CrGL\Y=7&k]A,P;H-nJp(45$Fj^c(l\E2=
k<Dc0=SH4E*#L%O;:7>cc&u@OE$]AWIJ>$#JG?A5om)N0IbM-"'PKSd30p:=\dk;kBUL\#!FC
'H6R-<+3sJK-WH%A`ROTl<`6L]Ahjj[c?btARnJQNA7l+Xh1%6WXFKgo)hZGN@h6,_)k7`GIm
8Jf.04qeRK#)?[2+ia_/BD-6@O:=>E9RQLs(.?U%b`rCD7`Xd!\V7&e@`CUgj2#q+`"TM2DI
nKEcKKX]A)6Vq\o`D+W;a!kq+Bb1c+j4jlRNLY_8]A.pIBr4nC_eGS,NCJ&fE*\QW`Dc!MbgT)
A<*u,)=XFu;M0q@Y(8QgX3?3mZNENTMh65mksLj`$n_a>Bl1Uo?nI^GpViWcq`.g_?OA+WEe
'sB1Nf0?"aDWN99K:;':WG3k@=NO*YHEWs0q$>a3TtY/0,a)IrYBf<VB/hQlM#)@1%SNBeEW
I!Wd2]Abf7]AK3/HK//6*prdX/7@eTJ5hi?1ifMA$j_UYA%$Q#?YE2Th93mHbo"Jclu#\%FYIB
M6.,;]A@l-%:Su%U2[09]A8$B95i0q50]Ab"#g9i*rr[eA7>T,pSN8:<A_r[b(IP"3qo"[_83a(
:%eYH5OJ[J&t]A"XhS_qaCtkmh;JJFX9]AAImrO3nb3;9LsWBLKaM4##:e9F&QNm!t-?ghheCl
ZOLjGpVW1HMno8RgB)0Jm.;)I)SjpT>"QjR_^Ik:NEpo':OkLtD=B)&5TME[aE>()fLd;6<g
Y=b'NEUaN9JGdgc<#S[\YtTJsc38E(p/_US>MV5j"GMZBM8#900E#NY*!6Mo*kMX&Hm:-t4;
^e(o3P>?^E7M*De[We2*g:.RffjKYB#g>g.3g-!+Ts59eMmZ@5>UWJ4\9j2rD=7cds1?83Z;
cojf^%&+6AhOTdL;HANcF8uRlQti@Ut)$D+-cd1N^nF,(Cc9prhJW3b,-D2`=N&qfK=@PN-J
>kJ/+N8)T6Kog\72/n8Gk-,^(K0gR$"@D:^`ba3CU&nb*?h[MTT,:G@#t_Hl0`(sTf"'/>_D
9s_]AYe!F3!\UfBr8']AEh2TWpLYaI,m'O-il*O%W5Rb?\'$\`uJh6J$rReS`al%'*P:u.^.SO
CudS/j='h</66%PkX&qH845d[#Y>$eMMJs7o/,:@M*"j=,#tqBNC(^p_.p<lT2bVk5VWA.S9
ShE:LqcG$V>f%3`PGtQ4KCUC1LD==nh]A:.UC<EkFG)7EA[*)meC@(PN<+"-X9fVG^[JL[g!9
[[)+VF"[J?]AZSbkI@'D,W=WR535BD1$DF1VtU.bp$3CP4JAC`!!`T)rLqo@5f"g)Z;!\R8n4
-f"9A;TTD23#Uu\=*8a"Aj/8NE/Q3ra^,UR(IZ8Eh;4f44?=d,#'7Y_]AC&>&j?_g,#.Ei]A7<
adJog9)t6_TH[@E!WB+QNdpUFqYq7QF<GS#8*U`hQm_%;k.'2u;0cO7X=]Acn%2BI*BgSihQh
4hc6t\0e\FY^YN;KL#k/sNbecbR^/$j,oH[sN#]AUW=K"QW`fZ/h*lr?,ZOoKsZ)\id$Zs29N
,0W-Akfd#!KO65ObJo_2Q-`"__BTY/ufB0pLRaCW_.4):<hb+!%:L\C2i5*2sh-o>&cO1?Ee
0OtY-jV9r+3C^N_1YQ1LB\\ma9B[l03+/6d&"TLR6NZL&c'"D@et#CFQ:aA^[8-LLMWct"n8
qeJ"/?3Q"bmd_em=p310f>PsLJ"^O8d"L>orIRg1/&5nd`(XT'=4lGl<KS=kRJc]A-Nd<bd-@
*F,]A&13osn7U;r)oU&Z&O7@<ga0td/V*#:HG,AMIVJKMpo$VqB,1WAc3Us"'Am_C*8T#&"BJ
>6<Q&cCmBJ<Ns,sK5^`;iT(#?.5`nq;P,rlmq[j]AU`04<]AGC,!28EI@mdKUsu8[p.V26f_Rt
[9H7mWP:V'JW`2_Lr_N?%Z9pf#+@*!2\$*%d18?e$#s?Z>@^hLDN9hs9Lfog&b\Ba$6Ol.&C
30i<,DbM7V?a]Au0cCaVcb9"t=.WmeS$//#_J[WeQ8Ma^5LmY%7[[g\LH\urQ5ZlW(*/M1Z,.
Ooe5U1N>bPPG?p_g2De%3A![)]Aco4`d:Z:mWcIqZ4`C_f]AjaK,SINI8&X#o<t]AIU8DBc6LV-
^lCBOb+nEFPB1Im%"!s8P&9A;Wk\-]Agq:g0!iB9!7'mQ_DALDhTJ"tPG2URPLbt2GRJ9;9(]A
=`8B-LnlDLiEeV4<'8_ANa`mt_R/15HbBmOuF;7@B_Z"d-pXSAg':rV7J8VBOK9m/=C^k6@3
^EoBAb"tlQ7_V6Y'nb!8sTj[AsV2-:O"]A&//r70IhVh"`IF1T_:*ANm%Kt'O)09ai2`N3=n:
n9LRH!rW]ARtoABCbuP-V:.5(N?d/IJ!slYor((QCEZ=N+l&KjPKqPISOHSuE8(]ADNNUT;\9+
,Ve>G%!V:3DBp)X57a41'nGDab62[CHP5u1XNTnFD"M!.g!jau0Q_=lnn.oB/G?&&Xfh-m@)
!V)Eb9k?O%*tj,1%sq+.:EBpA3iN+pjbZI)<)?5oV-F\Q1Bgr2S+/6gEhN$4SHZM65!#25Fj
rnd2+WFKq>/eJ(=[cWG"69SmLD8n^Ok(,)1KK(p`\M&TLd1O?ean;6Sa9MT)G$ZhNA4A'IES
b,k2P>6HG(>&^)uuYQQY7@Ql<#aWd:rnHFW]Aq+=6Ip1%d<,TWrk6%O"9_rldXXO_bR[DNb_Y
_D;Ke4,/7-b1S$7$(kAR-$K,Ja=!98lc(F04_nri7^0#9aZ$PaIrg<kI[Upm3,eE=$i$JnC<
nu*g_Pt(*t^<FC2'51^dsncOE_A`/Sf)ZGG]A#kG%*(.4Q_)GUFTNR+Fe`nc@;^<`1?\Tm>R8
*R>$tp5d5Sh7p#CL-uIFdQ]A>5bp&=N_\X>1:QpCeaj[u]AS'i0F!$ksU3Jc!03d<C;!K*Sbpa
)F2ALhid.n$fRp+q0J@JEnJlXQj_lbWA\gr8E&bWI]ARk$bOq+JcQ=1pj"'N?H2VWkX"<iY?b
,=?BhGlX%^ghdtYT/uhF*39<)s8U7&fP2G2M0!i06qmE`k>J5u9E2ur\d=5)YK#<\rgUc[XU
IUfl"H!)3Lls=J_s,U7HLqf@[f3JeFWV?ArB2#Bno%Hso=e>bJ8%07@-,+6,$f+6g/32W,80
_iO0DaC&tsRZm3VQ9-AXH>>\F=C')YU+\-uVX\NGM$g]A0t1?QVEe#VfbsFX]A(p-WRr\IFtDJ
&mpthMDi`jg?gDT,,G\\ZOoWGrNSpd2%):l/:oXYAD$"gGV:J3/YIEmaFT_WrFu5MHVH<LRb
:XXH'tDFWE(fB!7L=V>.1TN]A[HUD>k<QYl[n9u,qh^<F7J_#f&MnDEO:HtgXc!\TB=)mYc0Y
5]A5D9&j\KgVRW[fH/(Fr<NH,/Rd/RHY%Prd@^N%,U_.I2VJVtt-<"e/=Z$Qug0.*Lb]AZ>MGd
.p.h\cgr'RH!>I)aYh#^Cl#ir2A:cW@f%qcloU'kjfIsSXf":B\:BH5Fu"dkRa#B!#31oc=1
PrLcE4kj2&'1nJBRb#D"0+UE"Bd@t5D?!]ASp?P)mS;!-u<nU`hqJFTLKt&mQC:Vc3XKMn*XL
a]Ar\@a4_8"><4C2:0T"XB/ndqcMX<?r,>MX:8eXrK]AGd_>b%9Hjj=Ra$.(XokhL#pOHspfT'
*9;]A%l\do,URZqV-D@U!`,SI3Gt4U?RlP!&=-!^C(51j2YM_V5D2>TAOU0"?^.Nq4YLRpN2g
RV'P&"N^"!<c9QVHV`qUWeb+UZ?5k/5>?UI..Leg>pbBLL1ok'H,5f_e*aTHWeQD*AEtI3=%
;bNghT*ln7d=m"..&!aD&:HsP7NDlA.eds2FcPe$@bc65GK&=2lLr[G^:^dj2OqD4g/bX,id
k&Ra8U+mp)GkN6hi:8B=n@0)r:lmZ2i@W:[jHq6mW#&6e3!6M8fl^\%\<!LGcO73pdOd<OCS
\5N,uEe:\FHtQU0lib?XZcnQg^8P?QT[\D#[9U>!>tM&b]A6m,B^eG;D^><EfZ%J\qZd@.rO2
i?jV7/$E^CXI)/1":gOkh/qV?<rS]AQO9;86!oLp0f#!!6BjH"(G.<WAr!haNJL_449[@3R^F
T^(U=,<md-#;p0%4"ohbZckc,^52aSS4Hb'jEs#c2fWt(A"bBkUm654g/T]A1*F3/Qh99nAJk
OR,</c%=//[P7dK;#HlApHUa.jFNB_Qqojd`47rIp+jY%D$`;cM*2DKB]AZgbecO0"=*E`!;/
j-=6(+MCGNn_Nh*/L,A#j-]A9CU-]ALTT@kHe0tlk7okGqpOk+`ihq"I]A=CaYV+H0#&:miH.`m
(Jbct[Hf>4hT9OkCA$cL\aR,cDUD#r>[5Y$F#,'"%;@up#I107p]Ata5L?%u>7c_-SYS9@VC0
b-_Q3JSPrqT1&;28,TMV6b\id:JKK9jm_X?G\";n5E`<W^.J4,4J"0L,JGbnpj[1fP^]A^DKm
mq>T,KK#>N"Rim2sinn'7X#S=\GR?'/./7!CftE*\/e7,`4kn<OKVYh;k7ACU\)H'14A$JmX
;Ok!BH]A5443eIu\3m,lQ2nE%PolR\\aFR#2%Ff?G9I?"AGH7]AJc(q*'D^VCB8>/igEI-ui<t
S/bEp8OX)bAFBt[8BiF)]AObuM/%Xi^>*m.?#!-"\cXFS-peS4d3)_&E1'2CgECCC?bW[Cu7r
RG&D5gk",Rgo>nhkDAEDfoJ;^7/KbNH,Q+8O%(`kIjG2(H;H=Z*SZ:;k"<_38[=)+XOb9H:h
kN9"FUFM>h'm2+G-]Al8n')f4C>jejT4::h?pp7("6KWa\tQ,]A:[rn_EhSM.7[)%K975#+U'"
WII9kPoUY^tXWBk'!+`rAp""!o2-u$n7+*!k^*8+<\ifX""HgH>&ij7<5U=^K/`C.K*Ap,$'
/##>qi6NkW3I]ADZDkN\bKJ_3Z.(SuUV3cpcT#hRTaK]ApHKQP>UpWsf9C^cQNiY3aS'UJ\q'3
kgE+5cuoempC&TE@Odkn1G@Kn^#8hHQQnjU9N.AhbH2&]Al&]Ap6ecr;.?kC>50!kA!RoR6?.,
$$cXp3R<1#;[9At^?QCWSPrnT_6S-N3=kKgeI0&k.s9G6j8QBt(ODgVT,[,@$h/nU4\SYSdG
`_r>e[=BHn0YnZfV;bCOKUh`%o0G_r-6?IQ&_Wb<,B>n"t;5R#U&dBeYRAnst\lN1P/LTg)-
Oagp6=WHH%JAO1bK*Sok^Fj1#8@M#dXZ"iI)@P(Qs<t`eaaibhT]A0.<S4dBst^Cc=[5rT6gB
c%n9/[t'mS')4W,u*l0mA)&_%OlG:OTWE's+?N<cQmE*$YuSKL"$3KT'Ue7YXXI)BoBOu`)+
E:_#O%'7!Zf%-C=9U[_'_`2s_>\Wni;dB&45jOF.pKrtHTWJ14.a=N!Oh2B/ZT2ib/m\TP28
p7`6kN8E@<Pq9G2[+e8PdkQqrq]At"-k)6a=;SiC6haIL/cbY3N7*HtMrKf/IV^YAC!tMZr5o
8PT[t=G&Z,%#t'7Us[AV?9tJp(a[k$)WmFL2a,(<8(h!jH>!&51Gh$b(\t9tW]AVSBd]As>n/.
RT>tG@iG>Tpo1T6mW^4]ALMq]ABBIbnLqj/[*dfW4SF6u0CJ+NNa0cObc/I]AkF"qm1PO??#&^b
5GTse"'(M3odJIB9Sc4roP`XV96p>;Z#<MmSXR\lXu<C#)<3CJSIZQPnG6#ch`VUVJj4II4E
@0?;cBl?')RQ8GePCmiqe^LJe?2H=P]A2]A_KbmnFe`jNaqF>GDV(ZiGI60G^:<#?SR=WErM?4
VhO>UW&Nc:Bh)H54mK_UR'LsI9%m#-h^Ru05o%f'a`(Ne.P-koRb%c3(SXUqkfTEWE;%uPZV
p_pIkgZJ;,P*U]ABBYXTR_P0`#o>K+tX34Jq0X&dZQuLcjbUUTYQX%P)?&W2hT&qh)R1+d+q&
o^\=mXeiIHGUVHL$0n7D3T==NCp9UC)hckAG4;m"]A<:XV++Xjmu.%;O`=np,;`biG0Vqm"$5
,a1fl`Z-,jI\s(_c!(5irZ?s5$Ij&%q`O`&$^B;W0Hp&$FTi$7o^N*48i_rV&YG?J17Y7!Y9
;AqGH;G!K'F3AMEW=BP6[`Ip.Mm@eUcf7>7U^<tR3H2ns2Y*3ap8`IYHE&$eJ8b:5Hj**]AK,
$.0m"NZjdZ.u/Du8FJKgG"Mr8<&BC`8%H4o6(!/S]AHR?-[8DYBnE%JP;['=V7r<Z?1\]AmLa@
6E4RB/\(D\R;;Z#kiK_c$5-E:f&>M%es^RlQ4cpW[-Ka1Mnh-Ghk32BV'9jM>#MJ@IZN5i&j
j<o(1epH%*O`&^n:"&1WSSr*#p%nM]An+>c`HnI_6$4JH/)_n[kcE0L%G5#R&m?VPgRaVD<&o
Jc+.@Mi&rT*,_Aj@#Rm2f-*dekig1lt1Z-*"UZ>6W*lS)`PP;CZnEIqJL&EK-=\A=8!ubX9Q
?t<k<mFm]A0[!XJqj=5#[AO4oEg_Hi1I.7]A'N'a*c>m8"U-i_l7>_hNLS,Q9.n<3$Zp!UUE45
"?T@@HVuSA1^$Q:V^fEdRA#HJ[itr*f\ND6IdLbCrTnq]AAbPWI$G4FLc;Ib6=uWV^RR5SG@/
dE]ADJ/=U5A7PF&EN/u7eag>e__XbB_+@n59%3a+^DOAq-b$jT/c%LQb\4ddRaM57IkI=Dl5H
!,tE-p<9g+7'/`dRXE@3f%F=Z1a-KS@%H\O<b?=s:<4^mWBVs#(b<XX,/ei%,]AKAr7H&p1+h
$i`YH&,7!-YbI;eDLR9PcDr"US7g5jZ-0.kAIr9c)treVd':p]Aq^1$^A_p+cpro]AgmPeINjV
OiW=^1a-X<q9e^dA`PJYZMj#Z;qMq2-oBR82XMh`JVnqOR)!$k%!pF_rdkA.]A0kMC$NT/VT`
mT!L[;bhq(7'\n:L(?j_!+Fh$Wh`X;A<Tuuk--ptnn!sabITtlPP"Zc'>LF,A43r7]A\)"?#J
$XY]ASaQ2W8J*NmUi$/R,^p(\'sDs?:T!j!4Qb1n.>6f[B]A74C<OkTVif$E'3N31#q(]ATF)%i
,;kJ8"(_aY!2ki^JWe"rh#X;"bs$e<7K[`h%S!c!^@siV:DS)RLb!aTYiG500@X<+;8j\q0d
*(+&Km)9MH9VoS*2OO)8&4LfO:S$FS_HOX8/>@1K9KsH'S@.Y%ro)T;@K>U6P0>:h1RsYTPp
3kMg&daccGQ#d28hfWkgEW:84%Bk&N/;N^6>'m_:Z2.t4Jk'=(:=iqbMoiT=WiIB07@T,j:>
s$i$SJ,S:`(h\!YX*<&T)\90='+kE8G4!\p3tbVP&%D,6l7WgnV[#C'j?*MD@\.b%2<E%m>8
(ebo3RjF94p,J^;U#T)Q3X1Y^FLIbZUA_Cbg`i7L[_=`rftf7lpYp9l>ik[:'r>o\.Gin/H8
X6q/TGZgp,iE62GtH<T<b3H:W"[:o>E,Q6$aD0_0e?/oQY4?Ac48h!*smnR#]Ar2m]A7\7,c<X
,#F7`cS9O['G8Or,uhIIjT6]AXt`^8rh1Y&FAkri5Us%@H[i&^Na&+S+agOWH^k(UrcdRU4)P
@F?cOU4q#"joUao[>KIA1>B/mCf==ma3U0EtBpG!,28ha^S&qB@\U(qX&@sbq#Ia/a;d+.s@
6f"ASG`@^AF0&@gOW!k:<VOL6HBYB?G#oFFcBB#kno;>D_IGfA9p@>k0*H6/a=U96kg2Nt?*
l']Alb/8)9ED6e!R$LY=jr[H<RE]A,VV*a_O,#&2:X*"I,%f`lU"kh@,COn[h31:ZT)[W\RGfT
NEA&Rj(sS-,XBHXJIhNCda&FsMP@^-N;S\tg"]Aj4X.jb6sYb507n>]Alq/YY4A@<sj3(siHM<
B2_"`&bqM1(U#^\Dq/1K\04[*_"2>A6jK$MrHDFQ?JCh%gk;,:2I*4;@Q$#%qSS=9cSrdXIY
BTfaTc9r"Q(mCWqAg?pN??mE4I_NrRC$4TQ^(6j6^Rs!-"DZ+4W3/N\RFZt_hg4@1`F\H7b=
=3;0<Y%GGj!c6ZB<'7[dRGm:<@o+Eu*"l%$gIpDu`pT!/C&;sf:Z-a^c[;s@X;@4\$/qO,=b
pG[7@3?QiMuX)LIEu2<NPkrl^<%&+s#aVRqQ?6)jmOl)+ch]Ap>TX,oBp'8^D@I/(4Mjg'&Hp
p=;1q5(u:i.R+8sD(c0_?42DLX1MqMEp"M4:8B8;O?Rr;nO+P*LX[=c:2sphFrPm$sL0BK(n
%@5Lf=i8f*i/[P2iGHo@<Za@V.fY!cL&f*PD]A>^EqTUW;b59$BklinZQ6\M@1jq^I.'3BReZ
E,jRr&I`MNHj<aYS*+/Rk3I,OPZe:@VI<IN*bhWhLl;\(=WnZb*^gCm[6rSLC?*=\aPP80`5
#/^;^O*ur!/(]AG;q.rRHm;c,hW1*g\DSP0Eou1TU0[PP;Sjr@]A-3sJc9hL;`k;T#-;qJa,c4
,RSoNnkS#W46VB?PW*aonOFLY&KlDRo4,p6!jP\?tn>%;4hDa,h4s$@tt#F5gi*99)'m?Oc$
d/2cMqM]A:)NdYKPOXS#,FcOtjZnI-oj/T6+r2$2%s]AFI2h"GlaKIn85]AL[?i>rGC8Vi))h[[
#:VYk[n>J)UD^&09V?-PrNS-q'`C6"D0aQ;5'oHj2=Q8F"mnrR$0,=+>d_"4`Ipo(B_?'M_0
d9DjQ+@NVq0sh>:-_a0dr:,-"BeXiFJ]Aq*[Q&B#Ot+6s*96&)bWS%iJm9Z"$=g8^iaRl5N<&
o)YXUJ%*bnkL)=%5+F=_U[c>NaGrt*mVNrhAMtH;Y.O+?";k8I>f_jink&a"=S9HakUfZX,j
Li<qFfJBaOu$$k$kSDcM5C7J0DVRj.tdO^>EKp*WI`IUp9%0DKqe'*L,lc'%L`dN=e"'4"U#
COfEj\5Dej"2M:o0a4/CiMoF[-@/+AAMk%Q>>%pSFCF:[04@KBIbYoP5le.0jQfpQWI'J$d2
@=n'"(3V_iL<khRKn/$,+/Hr_!:[jCj[SMO96R]A'6GX6_C@Co77&6N[pG0m:m/l5d"HEln*X
_hrgFccRi.H7,h%VIBXlB'W*CN"#,$lh%#>'0i%a^6DrX5O]AMk`ML-SPCRfk.D;7:Vm$.j$;
YWFLu4Pf</qZ"^WIKpJs0\7650#Kad1Nl-0e:!!_ONn6c^DN;P>/[fbfjKP'rt:qaf?CcR*N
+r^9#KMrDiQmPc'<$uM8it]AGN6dZ2o]Af+kJ-V>FDkd`o+st[!/Aq*llX/o-rYh[^U<a^VIVj
T.B>e>D)s#@3DrHCom]A.6<1Cr^Z3`88f/Q7"kK^H9O)m9&HQ4$&#uDT<YRD>SAVGJG:'u$d/
@;VBiGuW0"G_^42-Dr7,/1\*LghB/P-pBl449plD6op"&,3^>%%[jR`$A8mi>Rrg/2NQLF3e
-*EC8q#>P,&KV`*E2W86P_f3Mb.dsY'g30rU\?tP7PQAI>h]A?@82?"Usdj(Llol&2XRMY?o8
"h@^Km[pp]AT"TB]AFL*(1p=U>(Fn]AojYu:t`%Mq,aGi@h,)EP;#HJ*Q5Ebk)Xl$Dd-B=huk)V
U^aMc8b6]A.dQ]A9A/$9m5m:12lJ->nT.8i3ii6CIXd69J4G?fGa)?$ffYI5j\3B0UG!jCJPA5
TA!n%o06Rt*afX(YE!;[X9]A'@p7YtM1QK?F[.AsN,%dc+Qr10&.F:r-Rr.eo3e8l`lD=^'Vc
`>U,:!Vfq/uk04Fm]A^1X67Mir!([fhg_9Fbt33qi'YmdcKX)I3K./?FPP)Wk'Nk_Nb#.#hG#
kkgI_`QPc(<;oq"#YC_-5H&m"QrMaNmbO\`YdGE9W_X6gMh&k-S@#i;F43;-t0igY8Z@T:dX
9"P!Rfn(GF)`c]AD$WssZ<B0(md/!C,Ei)PSq7&6@Y6ZXPbPZDD,0B>[9UHFo?$@_$^lsY*bm
Cpi9=6n),>?/nOI`DFLosi0?=@TdYMBj72>>AsP621H^79s(DE;-0KQh,!)4`k:i03aEZHQ*
gf;Nk>@4e'4>3S*t,<Nl]A/!/N;a]As7./qo';UcbUqLTr&Wp:.NrKT,(;%c^o?jCVG(7b?JZ$
B#*T8-e`6E,hA&_f`iZmk6IMpkIVdVk4beCF'caeX3:gD!BS!),seN%SYWMI,>=X+?p-Focb
>!;fHT-Z_*_H!L5n/4m.59\%*^>#J>?"D,FrGkH`f$A'RnQYLg%/_P;nU`\F2m`XGKu.hoTD
R*RoiGufITXbp)>*^SOV0pAb>YBRP_p@#i57eOGHB@i?Y'`4@;!M7op,u/(I$<oWgOFZZmOt
oM6cAfm/6c4FQe=p;O&eV3.Qn%l\jkQbCHA@Y#h;eVPr4;'?\89/1Y*ef^p,Fb5-hmSNWZTL
TP<o#KG=u9>cghcM[:h:-%6\LrBH<Le)O0a2)ZT_qJXV(J)?9,g+$,h=St6IWQ4AP6hEig=[
5-PHPn5JJK1?sWBAu!E&W2Rb7m;_Q0t3q5QTDi'#ZLE?DVA"/VJZCf:K^<T\^BtAdWHbed8k
mX&">9'k7rE!c47*aNGUEC*c)80V_6_I*5=J3FI9ZAE?",2(2(ZQ6#s/a6uEl9C9=J"mnaA)
[N*.O+6<?kj(:[G\i;a?^:c%fCb_7fCV-bIl0e6!,>qMSa@n&E%6("L8d-W63nc59Gm;oB]A"
-l9P)I?e%+M`jADe'W\<aVR:.MUf<@9ts0:B`-SgDe#If0';2]AXSV%ECFLI>tNo2QB=Aco$i
U6+*kW#b^]AJI'ULKEM'^u#l4"XG=CE0;q5?;fK,EnG]AklC1ig;Q-uq#W#CO]A'#i#Uk`B$dU7
&Gr#jXR/_R*>!B)lElk5/SZ$lFRH#XZBiIht(nnKe#?WfpiD'X5.^U+C>gsd@R[7?(W40hi9
%#(g-)0]A1u&35k;i"ds."%VTrjNgMBT!nO2Y1IKP%RFQP/<p<_*ZH)0-;;1UukdO7:pEFPke
W<97[=^PiX@h\;d2s_%qhFGi";P\Fg%Qi6Yj(igfBWn`_SZq&>NCf(#3Gf,Pc*d#J^si2VP=
ngp+-Q%MONUGS#0:U9]AQRPo'6LtG3\#@HaC:_W9he#q]Anb0Co?f^hrOlluHQIk1q)]AncJr_%
/$Q`JF"M<33S'ra9;W'\=#s9?;2D#AV!gar-g*WT*9o,7^fp]AI.Ps#*.G6pWjB%jnBgKd)@^
,#"7NBZ213t`+k&"lp.(V/0X?;S+]A/@-Lfq*2mq/-iri[-QgMDLhER?a4Frp=3<"bTC(`]A1r
Z7N/tE8Dt.b38loZGoBrUh(r0(\H>W6fTL\Uu#s;'o!h/pfGhI55E@k^O:45-!*gmJQ!R2$\
Ag5g(b`7/E_n3T()*L_qf$1#hN]A%m\"'7LOptZ%6Wr70m4u<2!pP"B>NL-fTY)epq:NY(E+7
_V#Zj+7si_f<_3+`P"D,iP!-?g]A+^^M+[MHJAdOo*ep#lYqL5?-Ku^8In=+l!G2qtTYbp95&
$AUue8/3iQNEgRoAdf#O_STcjG.uhrR_J=<7RJZ=(K2B:M9M.GN+ED<FD":R;o1hMSPU@ouL
d5aMiSeP"p[Y*Cq:^$E5Qnh]Alg8&_10%Quk0ek@Eoq>-gHENlnSaq>5Q_#go=).[c]AlXJp_g
4o>.VNA7UJa!k*79eDTc*_&NCES>JN0HW@R=oSmSdiCeeAJn>4u#b\eUg![3VV4VoEWlKQ5*
p=o*K#2._sMO,-iTq%IZj).Ac8(N;WJ`8nZTVjuk_9_!@CTZ>PMqYn:f@_9Tdh(9/e12iMUS
cu[K3Y2EF5nFoP)`Q.O2u`lX4*o/Su'eXr7d'CSne6l@1d?S)[q4FO`kes<Vs,ED`5m9Is8P
nY$$nX\AZ&HDE-?$'Qi\--uVm?7imDX(l+^NmgjVXH2Q=`H0Seem@LsZ@T"=Hn):Nkkc;uiH
]Ajn]A*th,_lUE/e]AJ?$E6BG^EWGY,A?N59oFPU&3&r.borc1?prsSe^h2/!V"C%\\e30+K$:!
?[E?r@Da%OHo>Op2j87j[f@e9&Fmpm(#mTa&:OKT'RCoa(s>(Bj!O$=;sCbj)A`-@>.de.4u
mofIM3!.[7o(7]Aa^LqB&*!%3JAYW<S"n8T9X#LM=W97gFRjGm/W4r9H;J!1<H-g"M12T/?bs
j;!fd^G+W=aC7iO-2D#aq?Qmq+nXnGK'`Oo*C.o^H"YO/.-/o:K#SflK@Oqd[hNle97jKCkZ
dgYaQ(X<ggpF4*1YHb3rNS&B(4M&kJ(71Zb&<K5%44%=+rQ^'+u0\rH7&$ii-M&o8ghn;KdY
/Kj8"tleAlDW96]AGnA#X4aci%S=$-!2:0>/Y(C<`>CN2QabM)V#HPlP/Q\Y@[Guep_2N`>tL
E=Um1#Rc"Xfe&Z>\(I!46S0H[tLWhKJfI_7%oYTtAnpRG<"qnTj!iL?M.c++FEB3<UNeGYGi
NN6je>eK!rnW6N:&huME<=gE*KMlUU>ZIV!X,.W:G2cLIC@hFY\FnRk"N,=M;[',mCOG;Cc^
'se0H,GaM#iC^3<jV"@DPuNUl6jm:hnXrf<H@:eqi<Lk>r'4<\#(a[.#;$7G2Sl>c^>HHtgs
brGkA@;BGY>.s)7Z/fDk6W&pG9O$[@uMo!DqgdTU[R0WS11NA_1(65BiEkbW?eq()*PLp\.8
=OU)m^>C5]AD[X.nl%%\=V*1e'Z@Z>b7L$rSO%E/%?uF9Fe#&[!XldB]A2J9D8/@OI*dI=0<0s
am2)@H!OHL4f%WI&UT@NaunXA6EHrJ<ip5!^br]A#QfI,:\Y?;$uKI*Jsb^_`*C7(0(A+*Jnc
G?uTd!/V%p\5)%V;L?!a'#7^)UmGhR1/69>N>W7J!-$th!?Z^dEKN9!(Gk))St;tM0_6"$#n
eAZ>2gL;3nNk`J5pOK9*guXMlUd^.o,otX$JR]AhQ%j##Oj5)n*Ku/*Mu%<naspT+WHUgjdqY
Jj8VU'6us4)j=H5OjN#-YK_R#R?M#4Rlb:SG07]ANrHYF74Y>:P*'bgQQ)^:.ceRTAABod<@K
.mO[O4jPd`#ck$8su&a0>XO5S;Q:r%C0Nlp;;t%lP3)kZenW`CJ,h1'R;K0_X6Yd%g$r86`O
hEJ[UE/Ib3WuK$dG"ff*(Bi$4=BaZ?`!4(Ql@TXQG2?i\RDd\8Dg*BW2&QgJt*k1%"J<.:jo
`>-ijg/&H/l&l&]A*5"h=J'_1<.:893nNeb$ALtSCbJ0eg_]A8u=`m>3pL*3iAKI%a+Wr6^G]AA
G_jmQeDL``m5?'6b?W.MPmp>$]A*dk4"p%WA"HP@#Xj3@nB`g"<TGiKC!c0Zk%)-oB?($'sad
-TrhPKDM-t?&YJ:D]AP6Z:+r"B1>l0Oo>RQe8VO\d&rd^$2a<86;X3d]Aj662N:5H+#*+Lb6=P
tX;SA1VV=?pD/WAghb!aPO-V6D$,n3U>O;Eg,I98bD*Q5k.a45liI,Z]ArNS;kf^?o3M9g<eA
9(/HgdY"Yp+N[)''SOGOi5?g`4T\t^g)%A)$iP=U1BK&#mdlHOMn"(+l$8cb?4b;c4R^12_:
-F]A!CHD2p-)\PFmnM3h8LH/.nmp-K*OR#`3l:%,DN-bfQih8")*c7$A6"XT-688=K`CR]ADk9
X[O-'VM]Ad&:9FCMgk)V'oP3T#)n!&#I),40n>ec.%pn=B(20'DJOFiZk^((&"Q%6,:$Re]AVe
e/=YXY+7?#O3*U7pe_"&.lFRQ=8Lkjm<%bWHrpek?M!@BYGJ5mq\X>%`"$pcNfS>>aM21dhF
=ZuS#UI46A^e(1r^$oS=s(9Nnh-BEl+RWFQoU$KqC5&Rnc[OArqH:pc8"bc^,3#h8`8kX04o
hk=qD5;nR01['BkY(K=-@)YnkYMVQg.O+I2KciK[<X-o:TjD[*je0%'Ba%sh/!8a%S]AiV[Z6
!,aPG:G.b;A+c_LJ;f#g?0OL36J$;+^iLJu-IN1#3%l+dH;%EO'iD>eB3&E1+`*^o=3DPEQ'
`:.NqH0WQUf`RQF\u'2>ZSh5^1l@R-JC(IbA+[hq38^A.$1ir)40F,EV@]A%qf4g7L'(#.sJi
O*3I;V:Yi"<b^6Wu_B$I'ZMPYko;k^JHk\fX2*F-_bj%.S<n?H6AWJeqH6%%`Cl47V+r_U:O
S(9W/`ISWcaeZ^FEsSX<_2h,%:Sp`YPD[6/quT2c0e>0'D3&QoJDH[qdC\Y(V^%?HT9,?[n.
-_B8.h2Z5:d%B_I_j4\n5\-T(h)q(j([_TZ[S`kIrr$>a7P$ijnd=sd5H9JXZFM'(lW]A_!i#
YOVQXr#oS$*(i-$:h6k-^*0)VFFX+d;b#_q<`Qqq:3n@Cq?+;@>on#-O.5l/15l')9Fo7\j>
lpWRfLNMd_l%r!f6F7q-T*=C<]A,U*5rq^HFI-N?J)T93A%m%e,''2MSj.N9>DREgaLOPb&er
&F69RFRr"-keh"9.HR[ilXc'uhm=P\tc=OD-7%njI)?J01QN7H`1;XAZc',go*lfksIcC>.q
XL;Uo52A8._S/u/#hJD;AA9mYuDg[[eh<Jo-6#h+o0L=UQfckK,Iog":aANh]A"r]A#(\3^61h
s`f::fr^?g(oVUG\`[l!C;Rf/gqI^$$_;-fYVVVpa>JYB46Y6Q6k9]A+5[$?G;Spq:#ch!]AZ1
NlBh`_UbjtDW4mfp)9.b(5gFb?<h1c;j[=s#3X<%\tD$k"]ANn&/?ms4Fc.,be::)Bm8MSB^A
M4tHoak?a%k*'>2K"U]AX+b[AipCrh?h"]A#a-sakVGlR+F6G-&;TB0,th!W^upBBga@c.F::<
,>BD*N*ku!]AXX@%a$dCo/Q0C-1`(U>)H3aHhQ2J?*Ag%]Arq'(qo:]A"?kS%3eP:WQ5/P15=d]A
#oK+r<G7Q)fKMcde4Oi"=+B[]AGZgM)bgCj=_S#c!\)<qAZ@Fgi9-oam5P[SN]A*k.]ABC-a8^L
kNblCR[H8?Sis2NjbSCG-tCYO`%ad&$O'!;h>^rl$8]AOt<4*)8L7)1Ku-?+N6eLhNh#<pSs$
GR8V()m&q-M&Rd#k*$`,1f9i-0\%Vi>i2]ATWH->!X\;Bp`\iqoO;=I[qmIm.b"^\oFno/(j?
AB;ZGb"c]A$E;fpC.i_k9!SK&p16#YfdA\1aq:@akfYN2Ys>,quBoSa?H-0,f>'dhX0PB\EsH
OLD7VthObXpN)4YC=efB)gPP_I1h)/d!RRY&1g:?CEgtH(91EsD"1g#`k!PhBmj#`AeqBLDq
$?'1l@l9'*VQDT@_)`,$i)7]AL1;fs'\1*/UR05`i7('Vl)X%qk]AJZ\]A;N>teK<`<V!GKE':l
%4nZ@1'PH*lrkED_.j3;Lr"@glP5UP!!JOfa3k*r,7f7)RS,_.\;1Mi8hnF^e8kL[EYV!Zs?
$?Imm3LGYIgF\hH-[>f:_a^^-E_'>@KPC.9Y%:1DpLnfaMD?<28b6n$ZtbalaN)e@<oXb``a
+!dL.`bG!5_]AMI.X(.5M0$dLjp@!/.q(K1'>8oa8usIa3?3UJ>YoBEg[>LLQ;^+KL*%/BC_*
XMNKkm[!i(F&gfkk*g11Q]A<i@'_7Sl!Vc7&S4Z$^[1)KsP+.h'WB"FJhOUai'8@f[+/585q9
urDjraVO[T;sf>1f*76Ps&CWiERI1FN5s]AB?7>TAJ!>]A+/dL7YDlt*1Tgj;rd(a5Q8DEg(VR
I^b"$.7-uj4=3Qs>B*oo5tk",H.hf2<!>H#lCnVtgMc&n+6@Ip*i[]AMiL?;scQb(YiDDfu#;
-m]Am5-'u&Gn#n82mm3kbL$EcCeRdYOW@8=4Vfu#5mPQQhkV+2=d/W+29$Nb-^lo7,._NOCbW
Xf;1j-er$3;8`b%SrBmtj`$Tr4a5BIqD(@j3n9#"FT9)4q((7_h6pB,Rg6#F&-B9SaHWM.U,
>h!:,PjZ]AEep&dm#im]AaDb,22VP8_)KoA-*<rZOgZq/DE1j^b2EYk:qH+0!E$262`ooEE!&D
u*uOGB'`"KZS?l-k.1h1<>m$<\l'_rT+AD>LZ/5&!kbFa:$;`OlA[NpUS8:)T2T!\^i?Oi^^
>IUjd]A.M438s"MAaX3)2S%4:%OgP0fCdk3AUnaRT?T:qbI3+KSjS?u!Zt`pj2#&G2?6,XpaF
Dfo?ET8m?hP=Ghr=)pUOkP!_F>6M?Snn2^fO3@"1+etWnQHi#\HYcgG\C&]Ako@o)TdWq(i'R
8@Dq#'pHAU]AnP@gm(ZO460FeX[*UT[!+WXe&]AD;X`XVicb1qbB]AdinF2>(TbmcEKH6t==3P6
RM9^YrM`#SH!1qR/<O*QQn>,4(Th--MH!V9dqcPp2!M]A8`rCJhg+\sqko\Edq^R</p_?;^GA
Qo]Ah_6m8k:[6[tlUq4c(N1=qXA0Og(\B(8[2!(+s66cqY)^IkD-nOnIF?aNE:,hI*3-sl4j>
V&mPFr1PdJnQ\4=BuYe.f[/M?;[Jh#t2$Y6&j9;fmu`lE#_9=O&.hM%\1>sN(u'Lke<[X"4>
'[%DsFKg6>@[%D>n7'TBY`>D6"Hh)1]A+G\#*%gd9Su"SmlmmWPJ0MQ_i#gJuW98BCR-ts*Cp
.r7`!<Pkq2sY]A4M%TUHRU5=:47?.^iJ6G!*Log5EnmAPA()pcD<5idMI+n.UbW44mMEM8]A2.
2X:E4.dol4l]A$4JS"8Uk@\:,ihP%>!i"o\ghMbk$^n2ljmHNkPW;<Le(ERLlS!8GL`jWs,Bn
d$\sAPE1mJ5fiQ(>IFj,6/P]A;W#CYV#FrG;jL80%QZKG-9XQ(D=HV&-8]A=;9`0q4iAZ,[+Yq
1#l]Ag>s0,\aZ$e5u9.R(WKOZUX[@s0a6@f(M!$.,@eLYI'PIq6Br#S8m#b#f+FZjB=^IB:CD
]AKDj1jr!LJ+.rq[""dTUd;d*)qGULEOj'Xq@Sa=@2:W4X"kiY0+MV6uaY&[.6(LK[![:*@Dm
UbNkp.QJdM3C20FP"%HMG\OcFBia0RcgEpA4:(O6*.,=-uY=A9:>eER<M02'8::POkX#PW!*
#3l8F3ID;AOl@_.$)In%eLaG\iif/D<!c)VXB_I-(3`s"e/^Wb+GC]A+M&lP7s5H+&hkh@q^9
-@4o5H*ZRlKbAX2XrJg"E?5+S2^&DF(.>&>?Vgcd@PTpb=XZ]AAnK3HE'O^,a'IM_%,L(9!2j
jP+GYZc8kQrC^A[?*VUg7"SEmp]As,rDGf]A-Z0P*]AZa/iSn[RrcYD.3a$<V*"!b<\9Ktrb`AD
F;84Vf\bBhRd)PEr,2PS'Dh!7nYp,riU/CZn[Se?o0qRMi$)3]A?iB5QhQdHm?LZdZVZOFfrT
2&Ef0mHAh\^r!5!T'M'Qainlr4-32CW,"7?/3Z8,?bhiau,;D+2ZJIm?68?HQ%G,Yk"'!;U,
mKV/_*<0'Y*LB/AY<fQ>pj8=ETUm:uf-3<:L$B&.4O7WRIJI1MUB7pAKi&_QFfn#Lj#QKmY+
#G?4<:SiaR]A(M7,37e4r9!dXBZRh3D#6FTY1^'mDgSB[?"bpWcOoQ+XM;HVGgNiZ[LC,&lI^
,a9P/qqrk2F_l5M2;cO<_HkOgK]A\M(VS4iV]AU;gku"=\8=^Jt$$JSZJ=6s&`7j<JaeO5Gt+'
W6/m-TI@Joe;D`)k-s(l8N?;&f*-IUFiZCoB)1$6[Og-3bU!.V4D=(ujF$o,nD=G(GpHq6qh
e44nY.-Ur:]AVM)W.HF<Nb2^gIPsM#us>Pk7.f=]A!2Ce\"D7LF^qD:j71CeO/b_M<;MTYN&q8
Ql;`'56q?a\Y"Ttu[<dT@CU;&E!:2k*Z:K6`@WTPSY6\9'%2H/?p4%VFr,c[AZ]A4rijf2nh5
rsut!6sM&)XFQI+<=7_(igYMALY*W!LF:R'O)GO3>XBcHuIL%=l?,VH%7rtfUdJsrDUXK&Ho
A?@jiL^f\N@6%m]A'U/qIVUaKgM+P6M*,iSPlE:I4+fV^j%%RPTEqI:)S9>R._^pSXfrp-SpG
_OZnQ)VLmN2o47X7WDd1ISD'`j(^E5Ph>&pY[0j+2Z1aB*oAAlZ3?[0WtXCRn&bah^R;?4bS
MHAE3@sHHGPXEj??1XP(LZ&A$3o`1l(m+>ku\'>Um1b"XP"$?=^W_S+`KY\8mM`k"'jI0IK#
B[WC#14FW4LTn/s:'pke0WN]AOa7TNW`bhkPr5FRr`P_TA/UY!WocY0q.aHp<=fMCnC>q"K`8
03>r:Dr>\)HJ6b\:fs.hF<:j1qf%\G)ae_"$>2`<!AFTE3"Y"3)=D4a(%e3M<bB?5IN,#$1Q
ee@;sRrrC*TH<4j]A*&,PuSZLE-fO2Xh[i`9fhIQ_qEiIZP?5m8VH@cF<:\5%HT-ZJX]Agj[bu
p#X=51%;lJ!s;P;$qpQ=iFaW&]A'Zij=:&;R?2g(NlWmm0`qJk*UO3DIiQq4c[+-I`Xs*H^0V
$n"RgprMa^fhYF78g@Q#[*oDINgaA/\k?#Hk5=j9D^sNOiEL/(\X?"OC?p3AKA3?mqlD#9SQ
Sl_-/@XF)/0[Xki[cGme.*Hk9,MrYtD[AOB]A5X)usm=BZ:;Kos4NgZTb5+JZaHK>a+M(X<,!
TPRU:il3,Vbm(FAXi-A4GkSL,JUQ5Q[Vt[+2ZZc,NmnG"`S5IcpVZb_e2@T&+RFrmL8KF9.O
JHELN:4oS0s-g,iQ7!;5<c]AoK7-6'W_T<G:P006nn#_Bl'U%/OLhQ\)%^[Oc7"9P)'8JUPj.
hAl"kd*57&b/9YE9gY;q*$/okZnOL`#rTo#kt$kXh'5=&Y\Ggd+G\%`mZ+dGKhJ%#h0CXHdt
=uO/j1>hWBbM<ObV!#d7cI"nV1O[*quZ3*2'?cdJtHk.X5a_RP0&*6Xl8%VgK8:4Im?'-2(Z
2$`I6<f'VsPM&n^S[<3[kJ(ABn=,9AK,.CjA<_M]AAd[?='8--kkrIpYueaFJNe>3Aa$$1oJD
0KN1q2._se6b@L3<2JZ+M.RXHpK4%35@[8Or-Z)JtEb2=8F22."dU*^>*<]A^$oGP4Q<fAj+8
]A;'?"qW+YGB1lJPN)c!r8kU)K!L9kWNpa2b]Atc*0BW.)_8I3&T?SD$!qQ]A6HYA#$f:75[Vf]A
46m4Y/aChG)7K=gN\q(.ihN)URPtBIJRa_WY]ApLW9`Z&fOd?FST`pW=W+\a-Vim&b9BXip)*
#NhoH/n@?h8a>.*S=1B65Fq:3,=UrZH2#7(\PjQI]A$k=C7u>pZk[C`E&7[/[qXHc/M[Gk4I5
/]A`aWEI$c(C<9^$Q_!jSBn1bP\%b<=l>Qc[_IX,Z\JWufh5^V4kL%i7l.qO7FT$dFm7iaC&/
ZSjomB1@\"0,'C-Qe.L7eB-)'-e5kaqgT!OMW77ePDoE2I[?mC3iF5Kl'?RF54lU2T/D4V]AZ
%L.(Xa,7tCU)d9p7n8<5>G[BueBUDY/+(HL7r?$LER/qK/:domq#cE:h`nK8PaP;&99SS>[$
)THe9TFu34>@`b%3dE1kC;o#U'U75g.f$Jp8O-@5(j]Ae_'V>$;f'7R.dRVa/n2Kb/gmiHCDM
X\7op)j85X;ml)N2X?4hus2\0Cs')ja0$gg"b4KCXIdoF@2aB4I;i4G=<o,3tBBD8M:+Mno!
->I;i(PgYC0!-,[(jeQ:M-*Lqo%)FX?+UsVWKfluRe&b7eD+g5YGVf^"&s-2,YA"1eqJ7[#[
fgned=#QS9D9Qaddh_grtEu?mPP",oYo*K]A(YnIrLA+0N['?iL8astR[,AGQq33a5.(23Tep
n(&p,-R1VM3?#a5R)*MV>9FeJl:$$RdK5D>+[$;KN-2Z3qi/ONr`oaK?=%lY)YesP=?`#]A-7
#8O^cWL]A0g;q`=r8(K!G8s;(Jal>85Gf3M8]ArlAd)q2<4na4/I!PFhh3@S&cWdhLJ\-"'_R)
V)ap#>!*dV3_i3?aSA`CBncTqS"'&,<)tokN3u(UL4)1c8.;RR8"NIIBd#bO]Ad1J6R\co?'T
s.>K>EK$IVqp`8:%>RI$\4g>MX<'.3Sae057GHJX3YTO#)io6[W[!hUNUdTBU7Le^$7;BQs5
MXOhIt=&R/CIn.I=B[,i;?_2Gbd[dq\]A*DlO0+Y_RqR_5'DtOa)NApMict7n)EZ9rCVd^KjB
H4IG9]AbQL#`$5s1M*oU=m7B)P$4U8fp&h-#1PT1kf[FMY[-foBlFJ;:Xus'>lJ0^Ib36gWLT
j4><"fDC^o"c&ai!^ufJb44sD8q;IsL4:bpqD`i-:Y<jP^-Z19l?7+AU>V.[p/8ui.&.*B/q
Mq[8S)(/<_11k(LKWY!t(QWcjp1&F--WjO"NeSC^<\Lf>/f:AE5@JjGYpgpj4V,1/qh'5W!e
WS`M3,bdKrtg/'WSa/@G$`n;!S-.eSDHe3jSBYrA9^pGOf59U1_HUQL=\U5/.d55f#@rnOn2
,QXsY.M]A'Y35Uhnah&m`nPGA7dHd6aVqp.dOGjt'eAuJ@m2#sRDIQ(pE0*8dr-ctE]A^<2g3V
j9#cTni#L2>a!=<tl$Uuq]A'713ELF^J^cR;10_35!Y$2kUZ*teMU5+Zt_/_G@an\B!d0M4;:
9sC4(TM[,c>Ns(hg5WmO:;h![q[[3N$Pr*KZHSUp>U7pp8SDSk4C-A)p77/Rm<6:DT5-9+"^
DE)_c[SYViLpF7.e8B>EX&BpYVIU8XZ*Ij"(m)*%B<C),!O/5[2iQ7?1Te5X1YP\<I>ic2f[
,imkAWQHP&_%D?9]A([-)D1=#S)PWV7nMqY[-.q%aAR=/%k9%'VDAUm+Q;'\X2M:c#GQ?!Gde
!]A'N/YcL_+#Yc?BaB=hqns$Z6Q\*^!<5Qi]Au%6%k/4L+mmpghd.g_4pbu>?7(Z7'$=>#j`!:
0+a63[OQd2Y/#<@-GJ^hu-45S)eXf&0*7TD$X,$"8^jEcW:)R$@NQ,%,SE=[.Cc%W:*`_9H2
`2Ui,A(6]Ad1*++.!=Gade_N?;Xe&\"Wc0VP0_Gh<COm^g>A.fKnla1,je_@hVuHG5^]A;bDWQ
J"dV[K$/j7-3Xg)3$F_KUd7b"o2#WEV]AH[Cs/cJ,d8)AYH^If)CfbG\J5\e.g=ZR<*hs/88'
i/$JPU:Ktfm0;?[c,SgbP+`'!R+&p7K*#WBb2CqT!L>V=-CBR3Qf!&T-#k,3b8m*I4(j`73X
1!&UTI%rg,8mqE?d%7.W#u:<o1&\IW9Wbf>>U]A3dO5@sc#9=nibURh[cnph5("I5eE#>I7YT
*WaOh'^BGoTQ>A$0SUpB2W'$Lp0PdM+'%NP=k,J80^n9cfoJH1g1pfBe)=qP&@#aKYO=sVqK
h:tLY:onsfGA69'iXJ;hN>K\lUhaGj)1HljW)08D0m/+[UG_EGjZ@F0.%C*G2uClnhD3e.k8
J!fEr+_"I&\A"-;s1"]Ao[9R"<.9QpNiD2p%\r'8JQVZ=d-FA@g-9-/G7jbs-e2dHcta'3'b*
UfT08c[J`73q[6#kk0r1W?jb&B)L4gl@3a!*7'QZdboNC_1mclbj%W0RVr"^4+b?AooC`01k
uHmce\]AA1cffJQVK<\Z=T2;%_Ee0k]A/R\MAGYAOHn_\$mAkFE(KW`FVli_2EKNT5#"i%QkiA
b8btEbkXBU8)j'l'%oc@I?<H&%,<1C;fGNaR<L#'LF`?4(/15QH5bE<4hm]ALK7j7i[*`FFrL
<'5A#J30R?!;r'ro'pejCK9PBVX?KD6Qc2:j8Dm#[nQo^.&N:H#c@E\'^!c+K?F]A0JaSBSM_
:WYjd'.'6->*8EON?+&)85+]A40"/eJK!I7/EaLN_>u5HCjq>'u']ABXthYN;7$LC#U/qu4gpE
]A9g]Ar6?+^3hNgV8,#GTnV[0<^Mc0n`RRWaiamBL,T:o_n!9KCpj6i^=[6&1-;>K!+te@tBpB
osq(pU7LT^C8::T,g]AV",F)X-UFB;Siu@CaEAl?I#h17H<Lb$s/gS/Y4q[*,Q)glqY7a[=rJ
r<\[r-oD+AAq-Hp/P&bAO+ko.r7;-t7<L'R`8K<@M-1bm;mM6@9V+Pca3$2o)ET'jra\Nb,1
:X60Fn=PtdZIaK\P)k*`(%649W\c\K8[@YN<FW7,?^#=]A3e-hTS#]A.@[utnq%'J5oL4:IhkD
29q.IACA2`^FJeknor$r@kJ2->)A\S6&`05&_]A^GLBg,C$&AbnK&+hW$2/]AdrUbSD:>,cH.g
Hrr<=MKm3tZf?-LLc+I)h&7ReObGp8b-CV_UC&$h#jF.`r?tI\Vl$oN@'F5;JYD34K371=lM
Ml/E/L\6lj[(Y<D.Tl%?8\oTgi,bP[fH>T14HePBa+2Y$,Q_oIJ<WfOjnUF!AUOQemi/2Q6E
ma0(lQn[plLabXo-`9-D81DlJS?DU*o[!,I"']AD&/"Pd'O5UcbY/MB(ph,/Vrp=L.Ctq^fjj
LuW;'Z#s]A)+H!3$cqj2^R@j40YCr(L>$e+;^q?K5#%ZVJ3g2SF]A`.A%\=Ei_b\.JUfB+H9rq
sF_D1FKIY<&3@/\%Wkp?p)7q4=C\Uo/'KDqut[`3$n*/jga`m;BNq3_ZA%97CikUf(UI;9j1
j1]ALUNcg*HfM1[a?`-:H#4DW^2Tq5iR<dbo?5;b=K6[f?%%(`DPiB8L@lOW4<08BdXlei]A2^
ju#mBQUc<CMoK7a7B'MVOrDRentAd]ALF3^?G7iNN3e31A:E:sc;8Sl42-bR$"E<o[EGQn\WU
't26+U_@]AoP%d>L,?%p'N>Ipa#<OFQm`j+S@S]AQ2W>f0c'rS_!WtAn&'SbKiDTO/jcgeR^;'
.ciabM;cujA_,=-`(9\Kc1\ujhUIp<p0b4/Y^%cbjb"6>S`#I?&Q$EqUl'Jj>ts8TE58f88@
Kc4q:\=E9pDnL2cmQ*4K0eZ.)s!tD,A2&7FPq-9(VC=M@*B9[WQmJKB@;^5sXX?@#9+(g"bG
%?h[@"kt'=4Ngb/d1,WU:l)'o-lCYPC"GhA51%#H_Y+X+XInc*md8`A7OHH8h_YM>P*VL38G
Dq.c@G>O73G)G*bjT]A5lP=ffk@?8<1Gd]AU_$0nY_9sBlnktGJHD<A>Hh((WhL4*Um=]ACu=%4
8E/HJJ\1e2EN9)-.>o?nYdDE:JtHmt>lp0rJAi',W\J"plPFL8BuP9,4*`P.`1@W\&.!bbm<
d\).geBMtt17h27+5,>O@-,a,L4A(m[o`")83Upp$3@uhZuF8B7fq=uL[:.u'/_A#hqNR<(f
9Q5Cr8*L(KWF3U610#!$l;;q[5YTj]A?plPYQP^jtIVhOX0,*qF4W,W6GVt:OpBB@7q$V?>a'
N(3L7t0`AAgI%*US@55IT;[dH9-49caE?I+T;[FQ,`s*DmbbOBjqkYja,So_&$jm<Ya)H*$C
7a@WB=UKBp@ftk]AkY0Z2N:jP#G'@m#S;._Is8KRB^,oUJio$Ee't+n'V8h8[&]A8+@.O.W0fa
1u@9PY^4#!Df5/ZLB=c-_m4Jp`%Y*:H9%cY&5H/2Pj<!a`Og+(u@<iN.4hc2<'kr9`bj&j`U
`J.<lS(T1;WdH:Y4%_)N]ANm]ANC+GTnJ]AsIFEW]AnOHr[dk&%e2@iN>bjj7SBGYd+W(c*(T+%^
Q";(9`peq>dDOF7@h7mCJ=t#r<AD]AF,AQ0@"E&]AUm"G$oq+*0]Aj.*[S72i+Z#=2lh,/aIhBe
.eSDh/e8GdA=VNs2;bRUkeGAJp;V<M0C[&BZPlO%XQ5cQQ4!(<Wg/ku#[5ge5`Qg7<k##WTU
]Aih/5:u@;5W$&0*p.ukL1fb<\.Og0]Ak).Lf_((/`T9U':YK_(6-2/lnD$C1@6EZ*HguFF#a[
'GW>):e*tj_rY^gH1#50'Te@@KGY)MU$g?iNJ\F2=,j9$-tG.;W#52^kQ_g*9ZkluPmp1@.P
FrgapJ(<9PeJXY$mX:^:kETi9)dD)ka0T%=j$f(`77u@30hB$ngNkBj&57B82nnr]A1,'*/'E
Qpq<%<k&./`c>=FcE@F5!6A7OH(GR3($OTLlcV'8*na)JBO+ObF.6H6uPL\\]A$p+n$/C$cQ[
WUr^nq)lJUfaK(_LXmrN]AqHeY<q'oSTj#Mu54^h0.`\"eS]ApV]AVRTLM3:N&?,\5Bg$,f"m[`
%u&h?^R:).FC`NAOB9h"Vc51;=Ytm8b[=tSEJ5\kl.=hHBRlrTph3r!%B26)f1D8)ss9)EjY
7U1PU;A97tNA^1$k0$+N&B&:VUR5[!qka<P<D1BlZn\'`0)pY)\r2f"#FoN%Oh`0]AbgZCTC/
OIGHQnt6)j\YgRk*ChWL\d.SL&!92d?7ED_6Di9dDlqm=8(t_0nq.R]Aip-^@>A_H+*f+Eur0
c*Ic<YusLH(7:8#14e^NpmJ;=!299HH=T56g$qqkQ4:WgR5U0M7MkM)_>7i8d31))FkAbL@P
]AT*;fCWOsq+oj5X:fZJX.W%KN,`6!BgBWLa$1;q97n4W(*"<u`ekN&UZIcd3O-sG@1V'R2m[
0K)(s-0h#i9J_DYSaT`4'rO"qh;S5*H+!\#D+$Qj.W&[s.]Amm-++2M^o^?Y,irOrHWBJ:NRP
RkMcJ;hKPL]A3>tgC4lg8je+fKqEM#3sh>6*N^`er)Zf4&_<2Bd^%\-Cmin<6@_Mt0A5I<:g0
Z@YKsDh&9?L#&MoG_X#LQhZB>ebDoj?>7H!C>X%r$:o;Pmo:(9-I[?1iY$6o^;'9jS=#?m]A(
TK,Wh@EW?3Xu_;%ucp#a32r=VG('[@Oui`*P2=b4k1+!)6P?Y-X[i2P5)`nIEZ%Ar=D9&j6#
[b(57*R?jl2&1$@3Gk"&_^Xp)t2A>O8W*KcO8/?\H]A32Vdof_R3p)\9*GT?)4BF!J\H/]A##Q
sneAIVP*tk!qJM]AIV';mKk`H[>]Aqfhd,sg7p?'*'3h[`\m&Rds/ah";?.L>R*l]ABN3eMVBn%
!-R6a_C4H+:ZniJ:H#nf^5)>eU#4BcU-+!Od1=E"loCV*U*IaXZsCU!d@FK_!7]Aa(T=Pp-Cq
@J2E"=+Q*4`3oSlLYm5&=oFZ%jCcW>?=BQ*#;U&:(5FP(Z.h=#DUslYF+RNQk1F#RL^ECQlU
X8^As5>I96@sPlYGJ[-?-G]Am/JK!BdN_a`.Dr?4?+W]AJF`meMu`h0LLFan#e$"933_45*Do?
aqLPju--#)kcD#-'/A-$\7k>=,gHOUlQ%.pj"3^GrBZthmkPi;ukG::$j)@I[\c)&1-%8%qY
t(gMPI$\MeE1CO=Q_g`r,n5XP0\$gX5n;GODCrqc9hoH\2*N?GF"O.aI(]Ams7&i'=i:t!V(l
[g!co;lW<PRMp6^'**$!FWG%T,R/[$P/#O6d__?6&Zdm)u2+uj=YZ^"#M7[6cSTkU=/T\:3/
Kl^u3*<34nn'H\L>\9Et3m2<_T(FM,oD6,Yf.g>Q^80NA!puH8;[U#-Wkd4sTdH\8$EPHqG'
LB'fH'W0qoV?lSP#L$;<gts\]A<OA(WW6Qs%7^%#@Tk?'?l,D5>`+Lh9!"8c653*$-]AJ(HRl5
Y]A$JNmRH?2QJS@uL:P'C'hbPts9jHb;akujn;6?_rE!73n4&%g_dce$,C=j`s^D72Bbo3QEe
$E]A9@7XT`q_D?&S3#HQ&&3>,-$ScHanA1akuD)$&.m5S\;oMrXn+.96*;PPT3;QJX,7n7b$8
a]A8(W,<9`D#Zq<trWIGK'ujl$Pc$*J5qWB5_,QX=loT'7ENrB'K$EX>E0;J)!TVA"@Pc:,cO
rq#>J813FEN+I%mW$l3u;TJXrf=VQl?P6`;"WC'!QBp&:1.idH+43!/?h(S@5PeE(G-GbAYk
__i;C,Z(kFO)_/#,XR#.oS^=Bj2pTNcr\M!ttJ;<ikTNkKg2Th<<L_lNIQ_*amog3?q>Qc7l
=-b(?]AWVIVVDOlFMU\QkgL(Lb=5%Vgm`?\iaL]Ars[..l.jmaG%.\a6!eq,X8$N#mN\A>"->7
=[=2ou:`J/O$59T"s:RRbY;af$W;=B7>%%$hN]AFHef8:?a7D>&+RcimtGD,RGTfheMT%;X!q
6J>L"]A2&DM<i)jg5PT&E"\Q54?j77u]A\jpq-oKung1!X-.o%MlW;4I&._#+BTZ43hA<)CPa_
jpF>11,dm0T[stVM+`e4<p?&_E%V(]Ad9PS2A%?^Q(LK3S+E6'?/6`lcf+d0aA%Cc/4&b;'pW
*[SfQAcD$VP=TC&YQk,MDh+NP\<08.q.QNMHO<iNVoOP*L2Jq+nGsZ^OTcQ1j/<i7ZTpC?<_
d8/kns.!9/7Z=D#jASa$<9nBii+3caRR6Gr&onibt8<p,6kdj/V'oCm9j\.Xl>jQC;CuQLX[
_7fQGi+o/V+\F0"R>_9o<,U[>PW-MG?1\mEOo86fHLVs4n^kg8RZth&E$Yrn,9hoUfQ,]AB/$
e_`!9pY+L#SRW%^ScnA15tAsj"cPr^8JD6`\D&d5\iWJklPKYP0k1P?UYZWV\C@DQ@I^C>&Y
5IMVA^jbIDd:QSVin(o/NtJaoS;00jIJdtk^HZtM>lnh+XD"GgOK?'-kSR&?l>;S391h@D.P
P6/p8mU9"hU0"LmEq@8mLc#TC&=lU@ljW7H52`gtD[L'hKZR5PpuD^J!e"L,b+dUu&l]AD&`O
N>sG[!n2\(jgte?8=XZb<0>8`A$_/>8V3*T!.^7'C[P<O%fQ#YW*f0%Ojr$4\iB;`glSI[H2
jr<H4eloaL_t6QocH*qAs&`KP]A.f-:N=&IgF+)QE0G)ggFfIXD$Ad!1`R`SYur&Ob8t^AE/X
KZq"WMobbXoA)Y1+6VsbQ`<*VSPpQh?cN#QLFc+1d`?1f]AU$b+XpFk`D$=D,<!oSA4K<6(fD
lfm.Rs#nQeN)'N$4mrf2&jNj1]A9^%!QU;_joM9bR$_#L+aN8)W718QP%;mX3NT,Gj:8fcn>1
p@W4NoTZg2WdXe<HCW5Q-#7L"[6MGq9s'X4Om;*bFT$ZaD^UIsAIF]AqaiRG&i#8`(?2/*46=
I(tm0S/n]A!_<#*%AmH<f]AMeufbO15d[`gM0+9h#"f:90BeUfpQmrm0BE^-)lpfdrfiOsA0J^
t7EZ]A7LNL0fC7-PF)Kk5!0-<_QVGHV=-=?m(AFYV1:St2':sD3DF@qX0Pg#lMW?'n]A(%1I;Q
3_+]A,qP3&&_6;oN,)E$*p6Ia^QuG]A3Xf&&)<7DqN]AHCG`X$..%N=7nLI*X!VTOZcgh3mnR+`
0isKP=8Q]AuD^340Np?N8Ooq8M`kH8%jY((kg60Y22]A#QorI*eZ-Yo19WTS<rIP70Ll-;lIr'
0#M$!<Bmg-.\V?2S;DV)-C"O?gA`dgF"nKn*='[Rr,U?!1]A8U-o\$@?Di]Al"H2W+DG*eaHA$
BJrh2RRLpgK2NS1V&D7I(0J!Mb#pBUHI^(]AdpK%]Ajkq`4O^Mba.Mi7<mmlBRAn,'Yfk<pIO)
E_X3#psscp=FO_+NG^Z5;Kg_%hmX?@9oF0<]A*B;*4YHX5%lA3g$?L?fr\4i?<Y`3OAGo+\"L
"9=`hP>1-*h_:MCSMbS!B3e!un/huR[_r,bR6E#F#[&Q4paGfVZ@;/3G$LV8(WAD:7+"7`%2
^L3?B?jE0?i&9<?1Mo#MTgr(47\P58AkH8dNrEEj6"R_fVLdNH1B2Or8U]A4Oh@ffjQu3j&6R
ilur]Ar9XcVcheC<qM6K?=M%p>pu?O3WW#h<YRNWjQTV=,r3'oQQA\AMDn`<)&q]A%7]A-uR<pd
gUW87T:*0YS7Q>noQ14\la<et0j>Jeu:Dt#_SA?Xln]ApHX#h[(K:f'#gX"S4*R<0#DM=6dm4
rh.!b'E.?$R^??LoAXj]AcN`T,8c7G"%uD-$$++@@S'>g=XfYC+tW-h-/DUlM_b)`GOhVS,N$
<0_p1rAb9h.<Mj+<PCp8ZuiLBNe\+fJdqF."-9(Xm`,QJ$k2Yp)u!2b)0ZG'nRrr-Drrr'hK
AI*_rB-E9lZ,_j7+tDnG;M[D1fNJ^hUIkDYXUtlG#`V-(+o,ZuE4g#G)S1M#VXLDD+ip?TKQ
qI6jKppq([t<8oo+<f&"R"7mReUm#iio5Ge[tp59A0GeMS?Lj.*#i90ijOJMkBiPWF'QQqDK
lOZ6jW^W\eW;7]Ao?E!fq@HZPJfW(&u:,tX1\SA3YjRXD46RTl=uCj]A\6$6kGm9X9F=kK1cun
IOlSnrWQla4n&&Z1D9/q&ef*,Z\cJrmn90DpYhs#hG]AXYGPa^)acsH?9X0"bLb=W2J+l3OsL
Zs;?N[m[h*%^"*n1-I_R:L.''.&A2k,1@.R`@cqd5rDjtT[Gk9=a,f?B^fJh8`'&VIu_:R-!
3<+O@Nj!03?q@&)8KoV.bB7g$A+Nh^9("U*@V,@a&9]A#2#%cI'Psdl/L)tJ:\#_mob/-<?W2
<'*"LrSt&dq'%R`&U&M_0%N@\RZ&31ZNYU#%[>1[/OFD2E4#Q+6XqjK;c1##6T[f]A.IT9GcI
MK,/i&1[4qBDnneuM7?Y"(gooO1@cmGlKJWB`:ouZ:@%SJ;?fYAU)%>R*RIt<-4!n(FJ??,h
J]A![1RhDo7`R+P$Q95&Q`HMQR`Er@R059S,+k-lZe(D^#X=)njUEIi"Q_ji2&d"LlNDBFM>1
9bOnW/;o^^,toAfOFZQ;7n<T>_E$sCbhoft=c#2U+,5_.^pabmfD]A!*57Vd2F9'TD*JOA&!t
6\PmV3B?WGGE8+X@-L5[*+4LSZO'O(#c2Inl.*sFU$c\>H2`n3iM&`b3Ul<d#B=YS=tLmV2Z
H7A77N@8M15,3H@Lo\EC)B=*p$&D.o+[;q-(3sTl='d.0N>5FO_br`mZ<uhss1L?J7S&c<[l
."WA'TCb//1rH8UK928:.YB3o2,21&01#.U8e&+m<gkAEP<[<N8T%r_`HugPJ>I-dArP;G\=
l<&%ogI%e?qT=sXS#dIjqNZ:[JgH35m*.,F:q.#6]ApQOd*-UWe`#F\B[/5o$M/pp'Cn*6=.d
,]AoD=!124.R<(ni:5cADrC>.#X!nT>X;<Bl4$oVMJ,l)_5N1`fAJC8-3?'lpJ+KaoSn4"2#9
AVE9jROK7tK@lItmj3C?:Ai>"PUiZ`JE`!P6%sG6al%uj:R5Wh?^OD@*LoQJ:9oKd!=Os8;m
ElK,\,SkNa<=/3[,a`$HT]Ao[7Inon6ZOYakN"Df`AR>WbG12(`gaUR&0mq$)c[01a?W'OZ$$
#Fpq&Af(>OjKpEPF'DhT`k_`<:$J-N?-g#.U*g)_>h`@:333@c)!D.XEWIos0Lm7a'(E6;91
eT:k37lS2^LbW--@Y8Gn,X/WF[Loe9.:L1qWn=&:7#?\)]Ad[l'>f,l<^="aKpmi3]Ak-88NAM
FSr9hG]ACI`dh%mPE+-jYFE#EGp)j?!N:KS\2hSp1Xkj1'V`2X!Bfb7iO[iV![0d@'t.4YTUP
W#EHmP"^Bc9NU7E.>8JK;cX>q\=Oof*\:$d-r*Z6g,:43<tk=-1*qR?..Q>a5+N8#9a4RF1P
jN3dFcT7PQ81l<]ATEY.l-3oA0bu2Dg=]A3Z5"0.q_l!qhNoBf$M@F8?B\'o``WQ$<q&%S)-$H
30FCraFn\l4[-D-iC=V\^'XAY9%/99EXcN`S<E+_]A&?U..Q,NO(Pa9n/%Dn-?s#"@%KGK0=S
Tk[+:1klh'DCTGrQ#&:9]AK59M5?!.OeDh4%N@]A]A0ADh&)gN6TRQ@n!KC-.59rjl/TOGVMfs9
;m,W?3AC$rUO/"[sIPN&)M2bUY(oWQ`2qMnYN\9Z:GFdDY5e*n)h4[fTB=JgA4+[%;/SiXTW
)j<iU^j[,::Xo[1YNJAfDAK[4Zfi)L]Ak306n3`O_RY3X!<ZTTA5i*Mj%Dcm54c4@adnT>u%m
O&!,1pa:f-rd)qG.J30.R3#+<[kp(B<!PlR"L8>[&\'PpMV1b'=*j@X(sDH1-cK0Nph4h'h+
k>rD/2.CG?]AhirAZ"<6Q:M0!3+JF.8fdn$]A]AG@F2C[[,LW08\3H`ADHRm3IKR5atYk*Ng?^o
!pWDfQr$:e5^3i3G*.:Vt$(W?SM6/V@.qg$)KtR-J@:nUa(<D_tE_AlcT?a]A/:+3)FL_Rm]Ah
(,La!Bn''=%omYW8:,XK"6qR/(bV<E&I4=I,._;hDb!F,isJ?bZ4"DaSo2<^DJI`X-6&ilpe
*9Jkq^tT/M&:j9Ka4uOg*V^.p'UdB[jp;^Im,1qjd.Jetos&)18u[dCA@WE0a;GqE`5B8AGI
>?7%A"fRa/0!`[p9uG33J<HpajJ3JR.%GfkQjJPI78ro7P79pu/N^B\p21M<ctC*[U4ipmFe
82<rO(BeWPepl[Xd\jW4rr6,0:OGM)ObPh`Tl4J504NX(pYuHbNCU#T71-g`B"ZfHRal?OjT
$o<6ji^g'.c)nU7L_jsQIY#sCQfp^7Z5`>#l2,8I*42gA+Ph1D2q'kFX\$[ZYdJ5G@X]A_*ng
llA,*4%O*:'g)(eLE`k/BWjhc>K@-Os9=Yo8nLQ\@*CU]Agk0T<.re*f4ck:;\h<+Wn$\nFeh
G4i.RaQ\Rne\(.TIR,%@TO$tRh[HcaXM:+iEQ$JJUceiHG3'9;?2P33+MeBf<%NbcMB9r2[=
%XWGs@A+2ZQej@\5!07Bkl,5?:u'i$9lRkQ.;BSYOhH8K&hraUVm9'KOH=%EFS@FnbQpbrgg
3d>341CDtmjSTYQ.kgBa8,^`4nL`'!nlI;S,_Bp$8L>=:LK9\fVf@sqKFWGJ.\5)@YBM<'dd
*+`dY]AOemXp\)-2sdroZ!?C:fU[ll5_V?j=@f:KfJfs',`;;T/#<cEks!.g,[JR<2E$I1-SX
"Ri\6;('sf2b6"(I=UNgL-F*`$g[/J]AMg=QF.8AtL1iotTHDkd6jZ=l&nP,"'-P,LMqL_hdt
;TV+re8qcc]A6Y"dI7[kUj;7A:9)[&j84LRi;NB<Jc\1Nefk[KHQS<t.m'AKo@Ub:%:=WiU:N
[mIZKh'q?cO$bFBZ!)(eL=-Y/@^0;km(k?=k/L"e$,#f#^48ZN@o.Xq-SH^008[fGCh"fc7I
-q9?k7\qVIpP_osQ8Ah+';VLH+[h4(=!7nESI:jp_h$CnA/P5N<97p)X>J\N6o28S?O-u7k.
8ZP),$",MrXRf6\DtEBT+^Gm]A7`I.D<(2:d,Uui0,eq&j2?E%b:,5AR$`="+G<uk:/8p^@WS
+,+aIk!N$^LikVX_05#8`mG9S$:4)hf#IB<YrS>XV1b4QudB`?pa54#"E'fV@n%aiiHS/0e;
)6Rk:[=_kjRR0C:juK_6pD2sdNI=qBP`Bf2]A,n=$"`:ZJgHZ\si35]A\=hU;OiI^R/A1>J_9,
277.Ku\$+?3ktF\@lmIR^WmbRi;T4HFN,S*WVSo\8t+49f_s09!ih,r[=mrJ?DW<g+Vom2o2
iEEg3o`Cs!u+RU8P+O!$4a&F:Fe]A<jePj3"%-f#.11c%[orcCX_;ApY0gotEjS$Z<#CgT8d0
\EAAb(C/iG.X?T@$"L&Eu35(H&1`I(+9Y4]AUQ-M0_rPe<`?$=3XH5D4qaUV9g9P($RokL=B\
h<Hp;#?b1We8?Wn?hB'SEMf,^rNRGQbSb]A)>aWGJW"pbp\`Wob4dZp?bCdX?5QfV>mg<Qs:-
'o]A]AbTL_1T+4D9ZQd^=JGam/38DWYk/FDn0fWu]ABnZeqAI+i%FSj4;D2]AVD,fd19,o]A0Nl1<
N+@X9uY0O\eEMom0AZI*scqcWQaC)beLA1kiTY`D4K0?btH&SsX:a/11Rle>,Jj1o(Ht9D7%
&mK8t=AX:!L==S02kWGdr%bB%>$hlhhUJFdql2kjp3_n+<1oMn:eH%"@*H!T<eKR,,UiEQWg
0$2]Apc$"O1cYG>O70Mc$b%<a^PW;9TGD^=;06M+8t#uHmsXHDZV-e[dW+gmEf(dE81P&Y6o]A
+Q\+m+@Y4L?4P?GV7]At5_9e>>K(f=WkiZpp,N(DJ1ik1J:JY$WQU55RB4:>KndSN%dsD.;a_
f%J*>GB-<4+i3[N)n6X;GU=0cFHc98.sp0+C!;GcRu5\\MNL1>oa*f<6RZK!F8\.l#kU8RV.
i]Ac(o97-RCS@V:j;qO21P*A3]Ae_s[<Q!,klT9tGTGru'@&^RCt.cnHaLnX2`(M!D!brW@UW>
jMf3AmU'in8,\+<=e^rH*aaM>]A_'#Co,YN2h8pB1UU0h"/Vd,FQdt@C7.4=[!g6970,LJR5I
lh!_4-#r(jmdEP[T0\6Np/?GZq^7$n#\m:lPJL#'Mi%oFQnm-Dg\(X>'^8d:0t;=^Lc4b?m;
T(a3n_Jbs=LI$%dNU<jrYt*.iMsL:&mg\sVXfcE'e5`6_*\(O2Agq8;GC"?:,:ll;CmXOlR6
J5$2l9VSTU"4q8/bdu:<XX``5]AIp'VHE8lIOkF\MD^i9#JscIRL);8&*0U?9[kjdIb$bhS98
?5:gS?Sq8\_el]AW<cVG!1Y2Q&uVk?`:g':<udZDTqpl]A/UV_[j+$83`7:1#[=&I@&U$L]Au#f
Uoi$'?hI9h[or+6!E\/->2gFu,Rf#,YT^a2qr]A21NHNY[jgLpr(q3aWmI9XFTQ`YtG:UNTPo
_U;-o"?1UdeIotREFWl_L3j&TX>dC5eWmp9\*'cZ@#UFnZdu;T-kr"NbdGn*a[h6CZ_9Ro]AP
Q`#]ATHa=,D\H)D"W*Ts0&3?D*]A,FfIWil#@Fg0N7,q:MQh#;e<nQC(c,q_0hn4B'aKiIc,>C
"KsQ^3hX-IYEXM7V"kYk=t$Pf84I5gR-1u--Of<8=VeaY0C`$)Vs3Tg+/Yt#DGFF2'Xu*qh_
p!;r]A+5OH+..JSN58(Xn<sFn&FPbC(Q:O6?p^p)em6D0Hcie+LOY^#n&u$DZ,`>FZLrjQi(!
qi:F6>i"S<N/-1#pd\;f'e#DiDm+F!7Ek#pX80(;hNhh<,*;@oD-Kh^C)%En)fVEfI.IgB*3
^u=8"d%1B:jP-!IhJLW#T)(K1EW;NQ1$;"`O9[_:6@fjpjI2101A/FBBN6c]A<OM-2reD4=I;
O8cNXDlc*Y@f9_FqbYt78!1%usnk.%8.9nX)GQ0d\A*"Y)@M1MCZ*5UgU<JaJ+rEX'bKqE!V
8Nc\5ZK')_TlYVbM1VG2/1p0pet4dYn+6RkMdVRspplijfBlR[p+9^L,$cV7>dAMkY[Bm))Y
j1k_O0[UQZq89[/Df<>_HT5;tK,q]AK4?Tp<TQY#e#"EK(#`ekt/#<^sO9<50?m2JRANbNab-
RmosB`\S:![XQo#n/n+:[,:?bJl4ZJUee@B&=r3'(D`ROI>g9eRZFAUVGq5_VTblj_['m<Vp
.:aW4=<F#2PlQ<q`^^`MbUs"$F=Kbh?GKSUson?#NNT=3PFaenO"(YUP6+l#%YS0AWe%m9@J
_mm-E1b>"eiDLP!8d>qebZm'NIpNT`=nh=\=;<lN@,80>qC]AU7$o*?cRlk>b9`4"O()4_kbP
8,NtcN!gl#YM*u9:"bu<_c66ca)Vg,.ukWXCPgNSOc?4Jqe]A`)C^_(e$Sd=+Pu2nP5a=;)rW
MCrHI>Ri1qkOECMd,hX$:8uk]AbmhOHbrr/S#6Pl6t>3@:3qMnq(>a4$?4?XDPgt0E_[8D=-H
Kh:>Wi*LHr7V3]AP]A-ZkTe7rci2UX5H_=RAa0KHAe*StT52?^.1TD24Br8]Arrn[&Zl+Qk^DY0
;eCTN]AfnO:P:*\bes]A0VC73=s3":;=HKJd4]Ak_e@5d#cRmrE9`mlgmH56^F'8?#jTToaa81W
bd8a-YO`5[[['sfh"h4\e)bISb@_*q'-,SmC5g'HuDluYhk<tsY!_'fAkGOi+]A#XdG0fG^<;
ci<HKLi<Q;KFeM]A@"0jnHA:sE!Ui'/345XZ*JFAkWj:^nh5i.jXna:t'W4iX[s5D70XD1%!h
5e&r.dJ45"L1<D0fDNb\(p]A;dl\kl)He@U<2_?;H-@7.td2.)KYIL&)`1,PrT66mk(0^Cp[R
'pgo$%`Xk#:.368d$\r]AH^gD<.>tp=q%K>=/qjEN9g;-mR/`;]AflDPHUcC_aJm?^s2Z+t#Ar
BFf.T_hjT^^AqnbZ>;.=pd':g%m[(4toC<._FIlT62C.i,$hL*c.8g;(2=>DTpBSZP*,&-3q
]A6>qh,ZN`3ID[*e'h<.iEa+-PTB[l0Br\dOf0nor.L-_]Ab5Y=R7;HTG4-3O8qXDHbPH>:rMA
\2&;l`Zd`X8mV\@fm`&lga$=0+6TY.T&:W]AIAjT\9Z&8u(#/SmAJHi_nHV0_E5-3i?$8>E]A(
S<j0g3XV/%Om%_YGM&!?J;7Yk'lB["f367URl*3Q25<cu6f/-5!!E/luic!c!_*0]AJs7"WX'
__ARHJ/:II`D[CTs7Q\FrkL0,rKFN7Cc]A@JO1d,rhqH+MQ;m9_sF\ES@n6M%Zd8Y+,&)=mf#
#4TlTCJicZ!)(R+YIY0(\<"$&=*,nf(60p2]A<[n>CC;IkS`5)q>I5"['<5[mju%Nf+REBQOJ
3P_-V`J8_Kn)U(+hGgrdo4!=(ZjA9.6)fXLTt\VQ5??q0fJQGHq4+!s`."RZ\QGsb`:I7O/j
@`DU`N`+8a#=,-/l'f@p^WtdBN[-VCjsS?<%&I,22;Jj*8C]ASq`5K-j0)2G#R'O9cV2#QF5i
k;uGdbG>:Y<3Xabi52b6n10\hke'h']AAYJ4\1B-[@1mFqWgQ\<Z?=1p[\(aMJcLH'#KMe3,*
HMRD:>UrU;2RVRm(X#8']Akpel6%V#;qYrglO>*(@'N(lhOIFl[jf:16S1LK2[B^>$88n/i+%
JT^3Y!"]AWHO+$RQTR%V@#Khc>ue+/)q,LE/fW@U+s3pEO5/;B#h(A4"6W)+:s\qtYWM>IKqA
a`G;E,!7e-i4U:CiS:_k3Y\6gnlll9!;'LiRSA(&i%9gE<!?&k2f7a=03^Tf*LWPTPjhLfAA
$si-525G4!GS/c-OU\st[Mu+Mar\f-E+[KeH9fZY3:P>Y>%Z]AoTpCF5SUi59[+cnX5.2Ju't
3h$#"OhRRq1V/<L.TEZ+KuDq?Q"&%/$+7G32U_r*:'T_e+)fP6cJX\7tjV@Te(kD1j8BnGA^
b]AJ&+t)u")LnlK.h%$QfqqfCQNbS!dc+U.;e$Ds]AZTOH*m,Hg*[o7^->AV^fmGn`8P$P332D
"^%(!Lrs3hs\3Z9:Vm_(CYQ@W[B&fXCskJSJgUrhg=_WE'&-B#gmBX\*'7$RF-l'9g(V-f=Q
&2"%QY?(P<)dqIuR'3UC6ce(<QWphfP5,_WYCpVf%=a5ZR/WK"u+Hn;9u`[id<q':cmNH4FC
"`B'N(qXQ;-f9;3R@uas]Ao>g:D)r!WZ.(N@dGai`29$*3N12i@Rt]AI1\AalJ0KpVfr&<<:O"
?M+Vb9c8l1=u;csQ1U73ABlHqBe?0%N2pqHS/"o%Sso%gK0g!]A%(L0c!79#AC4KT"*0@I"n[
U?TZ.0L'nXi]A]Aa8#G-8Ag^gFccnT2X`4#\gBWHj+Z1&%7G.ei"W,bnm:BUVErZ'Q"X24K!5#
$=nKJ,o6_Bn:?#o*7@QV-9U[adF;_,"d#X-rj^PV)p(b^Tnc52U''qT$*48iH+#>Mscg5_]AY
hV*Po?-1RNcQ:)0eINVe$69rQ(8]AWM8)iDr#rGDb5?[[7Xr#&ThH1Sck3ll2:15u)Sc]AI):1
oI)VIkY^bu$aJ%GSJV\ZkW*R.EXF(0c\f(_CTdd?,Hurq0U=W!+#ead5B`">%AlOE9c2iLdQ
8821_W,<aShjj+g9t/?:`C?Sg/nQ7/'UA[RTM629d;]A"dDH;o@UAKkLcZb[GtO>>n;Ta]A@fJ
D7HE[W]AS-bcGbL`UKflY"QfpY&d[:En"&"dt5mW)g>D5+qkCCKH4lnII"D3l$gMK96%mAT9p
/QPp1U]An4gWb`tB/d\fLab/?D6^eDG*BdH&&`@m;-&`?a0-ErO4+pXGV/Zco_fK4TU!Z]A_dP
>An0uod.+Gfg*ap5*H6I55h:f@.C7:.<Y#qkmDc65%%ueDD1jsTdosK*SRD7SGK7_\;fYo1!
aL#]A5>2^ng`H.<)c$*@*F#Y3Lp]AOK]Ak;^7T6p0nA.CFISULlYs(KrZ:f;_;O%bY!46e9iM]A@
(rA(>8h@R8<FAX('E!XFi1j!B4=DDRDBG'@-sA-f7JQj5_TUL?HQ@Y*(N.Ar>&62uUXdS2*'
)E)JPRNO>qB!C_6:M<K$^AP-7q=VI,nHX@)'o0[J>\*m?fO/*KRA[1t]A?h-Y1b1uV%g=eRTb
?tJMnu[$E[Yr+b(.)%p8u++_/4&G9A0Wue#<lEOo1>`u5.<hkP5M_qQso,uh24TofcW(5'c8
SZKAsFDRBlD'olm`<PADCp_3<U7r2Crn>W'^!*7-kR.Y>\hC)/6#nXQIZ?#AmKKkj/!FQV`A
@abVNP.Am*2-([ZBKtrZ@Edr.@:K/i^Cq)bOfr\(<f]A:5iDa9nB8XC.IYnl2\]AY*E]A>##X=,
qDNjg.gfR;gREQsGU++jE^4f-"IV_8EtoRXW]AH.8.Yl+IH"A=\iN7;R%[fLBspLqi;u-X&/<
L_bb<h7IV[emHq9ERLhl$8UOa\o(';;R;)]Ab3fdD&V`jpZ_-,s,02'X;,D7\%!'#Ujco@]AQ+
5NCn+)%DAqmfk;OYF'Z$Qj`f!I\7)If-K]A&f$/Xcbj6BaDD5jBsG/+C\P6o4XioINn1"WPE*
=:1,WiuS#OlFnNE"omssFee(*n,I&M$nG=I7_]A;QN=:>a_%8?-^9;bfmjloo&@1q?f?o26dE
@.L$#Od26d4`PWlq=`6Y)(1tbW"^fBXEiM$T73aH\B9_EjZWq@DjaLm6E[ih^%.NngYWM,`k
nXaZHa>?05iYi8Atdbo/1.,!l$InjDV[4SCt8?rI"@@OBQt5E!_dri<;7\D@1@6eR$adBChl
FB&iQK&Q.=T/>Rkt7CoA.V^b>7P.0?+2Lfb-4To<6nID`sLHjBZbMRub@.1!m[OdJnLIE[3K
,kAcR2l8c8<D^Xp<]Ac_]AFTd'YDas6,5<P=rY?E;Ip`Yh-N%d)5]ABpNEO3E;->P4;Di0,^"GI
4)R:cu#39c(K&$+k7//U6C-5:Rdm9e<Q+$?`V/Tshr_s;h=p_f@r"rTD?NN`nQ2G@<q:e!i(
P'f=MHu:-cY)BOA\Q7T\rjGkZ1YeKbF>&S8T'35'I"^%OI;fn>6B5'&X&r%2\9I4$AUQs>[&
;$_D0WI*VPE6,VHOu^T;(r)C4q2@;QQ7kf=OHdh_mT]Ae_+mqB9C'p$ggS%.X&"u`Tp3s%8in
Fq9JbsLQ2qoa5&lpSMP0+M&LJaW*h&DhqBWNLj5+"Q"a"ao,O`[hs[/IH<5E!jQA4_e/W"%(
jn9.P12f>B(@iZ0Gmjh)f_cteV)b;f7p004*c\)nZDZ9nN>eQCLWU+O0(16Dr_OMW$n^t.LJ
bEG_"&m;1`iqAu%4Q.;6Y>P(ZOL*n<o.O#1HPb-qnV^3WQ.g1X(nAnT7&rTt`EeF%*o4*qA5
=KQAq<kEf<=WN.mHui^VKN#>iG1+Wu:*Os!D8_i[^jNB2^d2l8ICCJ/fVdA-6]A5+j7QQN=[V
M=M?J\j^P,P#NJFr-E;>1F:\[LI?8KouHS*J.Sn_?[M_lg.<=n8Q@L.-`K'cAhh%UH)[hb^W
oLgu:?p?YZHW#8@p/X&/T!K@P3*R?H&!\h%E@V<rF%[$OF:JlI"J*Qlh^iZ#UYFMh6/LbZ'+
2-%J571N2@KqS#o*n:iMs:Jjd<U_&5Ja94IsKr$mL#d:90#`8@DUZmWhV@c5%mNU$Q%o8dtu
9phD?.A2D#EF/Ou`6UWM^/4;hsJJXEX.A*6OSO&iq+egp`-DJ]Ak*:e!g(hm6C.&2]A91)$)[5
`gs@KE78ONF=VPX@sh+PrJT)o?Y(-USTsWVd?T]AC#]A3e3,]APZ$r'W3n5/(;A?.j+r:,A0Zn>
6HBD,L)kh+a@++'-R:?&o4lh(6*p6")7bg1=i#>8c#c,^.6;G9.b9'g+F/FtUjW$"A.R3;S8
7Bk!d%CU<n0M$hPPW&Ihd\%6W,[8!NRe86HZOl.,q=MK4d8+sH,^X;3o[;8&m.2uUn&IVG:[
nicb#UHY4resUeDqG\3UT@'Nfc-e*k%C[J1Q+4DTL,D5j^@aBIo5u0bndBg.<PEr52f3moau
4IR[LWpgY:OY@knOYl"8j<IkeHD:eDUS:-Gh'-`7;n.hLc:#9EK_F8R4=.@X">!/F*>$c8t_
d=K/W5k3un8&JH\7(qeD8p&0XUh&Y#5,#E=d'JWQEJa8_9&+$u_Ur'J@@)(shoJCeCU^BQ;+
\uB]A!nu$]A]A!j%9\dR4TPd_RU?N#Y9!\B^h>'IJp5X2]A9Fg#A;'&P'#KfuM@abnW_XLZK]AOsF
MN5_5Kg00SdW!-A=bsscmUUtIE?T9Y:d)b[G\K@ZtX63u#gf?:(E@i$EmL6b\HrK'Zqd=rlS
s63cD):=*PR-)o('BqpcTY:7Oi)@>mfuDP`BoKqF(>#l([g!nDN';a&6K$S]ABV]AMAN^"QW_^
sZ/Y53C1bl7>ZVRkVp&6,o@JNEWB^>"`_X&8i#?s7Z*[ZY21&eHR\W,2S!Z4(Vq$C\>9(V[c
RqWChf,NRobq8o&:4k9>YI*$EfHY;j=9oGBBs;fn-mni-!XYZBZbfb4HaNWD:&;Cto6R$>VC
C?L9\D!EM[B7lg?*i00AR3ar2kUYWPkP>crr?TG*d@7.Tl<T#4Kr\:2B=9+DlAicplg"Ff5B
U[`qI*KV\AS5Zj+:;f%NNSXg0*h<%>M1ZX4l_7,V*UQgkf,dQ>&gG+,PGCZ9iMAcu&9;jp*,
kDeYgFR?\N]AjJ&16#+k%hS?Lj.=_"MgU\Z,@!%_e^<BDOdi8WkQ:A(HA[F.3#^MuY`[o.`$Q
;J>YC5]A^8i-MBcP8&bW1Qokf79/+iJL`i]AdoIrmiNG68j3%,Lm#D5`R_5L9hedq6j7#kM;F&
n9]Apm2;/)_J8B4lXMJ6H;&QdhF3RcA1&OK%CEZV)YqE`=EHW@AkN6r7jl:F5fec#E(9(u=4X
uRPH+@qQnQaL"\"d8+rQZ7;GPE%^Ph[%a]AnRSM7g^;#nRGgX_'.,hh_$g@5[;(5DL(LAZdru
gs6BMJCjISc>qZ,+^Wi%MB%=^Hk=TWq_JN";FmV+`7i-q;]AJsnVlOW10(u>-IjQ6Xra&o=#"
%[IXC42k]AVjTTrnTC!,6[#BA/R(:6_Zere"\D)=l=gYe;=s3c=1o$QBjr2GmLiu3[`d\Hi=j
T:*sVCn+g-fZ-tU#L]A/_#)[C5(,bi7UE?R:U!O\O[5[a!4qY<BR>kbcX*2f04M;s]A2LMZX!(
Sj@cI_L]A-^q>OUqk1$`L_E[gH?)q,1"6GO^@D;cEh(de':KsVh^=%5j#C7>tg=N3B?Q9Ou'c
Zl=$d_X]AIL6u!Jt-Hlb96O.C$1r0pU@;Q?f8Ga#SlE6YgNL1#S%>(66)WS,MDqDLCn^F*M8q
%.CEAn`#A"d\\K\70U/9e7`<lfI5Ue+_W(9Ic?O#jOgJLdO.?/p$uHtr<mGiqlcGio(%ki*Q
be#F.&/I;@cpl-Z+f:aq<s7JFa2%`:O3+[mg;Oc0b^r0eI0\O2JOlRHWTj5YrA!u/[escf<3
V=,9WMrhJ,`3S"bsG@CfNUG!:Q+=M_,3U:)9I!Pqjfq>W>DI>7!sk_GPRRJll:Oajj6S9u[?
aNh!h"#O<*0B;bKQ0Wc!QH:T?X%h"b<oRofq_u*Vq7cb^;YJpSO?E+/8nFOh&=^!EeU8op6,
MQ.M7XH6pP]AB#())'Mps[/;_Did%DK+\'KEiNNpP_X/,SOQ%5!a_'I.8g.7Z:hm"3qd\rJWJ
Q;Xb$&VArh?F(4)mU:#r4*h4hZ)&kfEHpWH4s,A./"F=8HYJs\!CZ1/]Aj,B1<,:WRiUt7Tk4
Qq<RH0<*AQnHB)s4g(',flFSB`\=0V\c/?A%$]AT/P3p]AnYT:"0hN2-(6DIa&gor;?9E5*W:e
((U5t;oVSP>SMWVTGc5UQX`]AL$YX>4:,Kbr#Xq2A-f%+[l$rp;6,lVH$t?WM-t+PHBPhr@N/
Va(%Mqtq!_E3fYL"<RK!(#2V8DT1DUNT9<hQs2TDeRQ$s]A7,V`I:Aa2>]ALI;3NGp]Ac`]An,CO
$`^p&HnsRpVB"'X-m$E=lME8Il5ZfNd3JS1F1CZG-j`q?R6R_nLA'FrK,7r?YD-hWbo<4%ht
d-asp`J'SDKT*>>.PUGNme/GD#!1)r2?Wt:Qs,?"6<@`r6?J:B[74YfGp29o19O/HDG;CK".
<5jaD'ZW`n=eeHK[d:O;liiEPc%tBN:UVGok?b\EV\:UTl5qL6ZesO_FCRaY%7L&'5]An3cha
`N`-c_%["`*TW@8h+K,7VSaVqXT.=FKOej9=[r6t[nhSg[#Ik_?N8$/EI7SbhV'3u\c,iC8]A
F[gP:XJ8&KVWji>+qA!t*7P?)h?%W#hm``3k#G47+QkOMik//cgiXJ;4Mr>q-2?b-P[8t=Wp
1'5>F-:B;8k"A''S6E69Q:`s&37**is"<`W(=GB&\8'(\8"nelKh9[(m(T.h7mt)U4-3J=X5
arnR;keNm=_6\ko,2YV!fNIl?RG.r6&TlD"MKEtoZ=<h`bTHH.0UFUB,>!9Pa"I7^YEak)lm
G5#Y4!P('C\/[-oC`,EWVGN0V_\Duhgt1i/*Qg/Tha'/Hi'<K;^^qF5Qj%#M"UA+NZT;CI46
9_R\TJR7QmtZRqW=RI:#4;h`%D&X,X?Dd/o!":K1-IS$oVlp1op)5Go"k1bu-YA3XjUqO,Hu
E@go'1;[4KG5s-9>&_g+./E<"GZ;PhLYt-]A,eTB_n%bRHg-[r))e1Z4KiYIuKmM*s9)PB1X>
/0Ghc0I6EG_4_LpF?smN["l*<-08dpZQR-gTshPP1=B01!'EV2'mj7!N;eS?37q6&E4n&J-1
X$/QQjnToUUhk+BKNE!_tEo#V<*ujMgfY4$:4ej]A@*/*@ug3*c:?%NI+5<*7[CXe(;mEH>Rj
&,0Ic$oMMY7Z6'b44X_eQVMC2ieu.nWrC",J2:PYZ8)Ml1gaaSuYluCR>Q$K5rngI_1S]Aep&
f0kbs4S@nhUkY;F;UpF%]A4))6"K\s(L]AZWVQUZGtP0$Xd^Gn.?n93c6:(m:>;!-LCgU/+F0M
$R+qJj#Y)@17OoB`qhQ=0#'m+C`LerZ4?mK[qX4!esqfs;tE=cTe]AK-9(:K$XEhk=SrEC<iB
@go8-AkPHPkX]A!n[86)l5D%0'g!,Q4ZU3p(@tm1G>'2A<p6+;9*ss9)OZ1#l59>WBYI3Ynf)
ml<]A6KpN`bRejdM:f2/Tl;f=QL>,(TrN@@oYr>c9=%/ICr`$h$tC(E!kYV#tX6cRKlN?LQC4
l)*??<]AbiN6;0dCYZCWVS=q/b*CTI2U9W*_B[hkH6&V`jBCHf_#Io:;4Zg6c=X1Flpi,/rIk
+>YQ(mZr>Y#X)<!^U8,8pf)C[nV2>.\F&HBr\NoJ,(QLhk4k4W_b62t0>o61,qIP2otgQR+8
>`\XT;(\n-&:5/'8_?=Jdl4XNq`$>BoXhkEe4R1KrRtlIC[7[4#C.#2@Cg+JD]A\s-38J0?S,
R.MdRCMZUXY'+-K<4d=8^-@5HJ4:e?DMk7`an$m=tZ:0lLHG0dMGRQG<1Dmou>T>qmjINXUG
iJ?GfAXGMtqrbs]AeK)gDXbga&Z,[6'RrrnTAAsfhX%%8Kf\%;]ASRpe,Qq,\EFZ1FA2J%hc36
LnY;-W6tCNXk]A/C31"@[JZa&pN0B<1*oD*^cd$[X4Sj=MLR+cjJcL`@UmM1[c2`f3mAI/oO(
Jdll[jO(J_b-`,<j1_TR3_bc@oq.B.2nq2np#8eX]AJUL+]A<SS/,0KsokDP^MFM2h"!OEH:UJ
%OlDbYlF=nWW<XsU5nSVpLq;R+I=_&a3OD<&\@Wg$p%mc#qgY&m?<#U>X'.!^BDc'!thagJ$
%hIi6I3#&N&W4ot]A4OdJT8^3EOX,KqV;%m#Q+W?MQL_=mWI>JZ1f4+7?W\_S5Yrcid9'Sf0a
cE,V!jq#oG@Qu8]A/C$&Ck7F,VoZhg^G_03n]AO-)JD0Y6*!=`CIVTNLmW_ig%?%]ASSZO@s>?,
EjA%Es8bLT\^2$EN\A2`WaBc99(YDFG2LJn5]AW83Nt&9[H:NW2ni)D1fXTaD>b"B4+p36K;+
Q9W*If0'rg.60`1kDJ9ZbLH=/D/VE@9FdW0DFrARNVXZBQo#P"Xlqkp`D9-=Pe6>tU3/&sk]A
L:CNO3ZgB`a.^NoNC%Jkh7!h`Y461s7S%83hWNYWf!H7L"uE)Z?#?LSkVhsh&\DLVA:6J=D/
cOSQr3`Y1k&\I6,g@KLaL#aT,"?k=3%=<5[,\n+J=5^`]Aq.oC`?dXN(cu`pg8POUK7'_pu.O
/`9pm%dMRe;=`h)h`feD5!q'%#82=JYaRcAte;NEL3e\Pdn.N7o"oEX%WAX_VMl3<WNKVq*I
YY:Wg;GE>71\(Y=$Ph\S4e-,/ZPN3`NO5&X(.]A_G4?BbqCh5hs0&KtWnZlW#@U.in*.pL>E#
fkS1K4BP^lj2)&)6H0KM999NCfc*-#M2)WZ!]A;6#`0pVKOTSq')4hI%;?T:*Zb'+eY,'PKZ9
QnAunE:-1=SFTgm&RqsG%'Zi&?b]A'G:ssU4D)fm^"0?QGmgjUR'FA"D=a_oD$#._qm&&).W)
ak"X]AO-0]A''`8`6;K65%=Rfq#g1@<$qAnRt"rCZYP?j7oe:SSbdg~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="68" width="468" height="358"/>
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
<WidgetID widgetID="ea0a0929-309c-4fa6-8084-3c6c086f2399"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-658188" borderRadius="10" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
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
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList/>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
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
<WidgetName name="report2"/>
<WidgetID widgetID="ea0a0929-309c-4fa6-8084-3c6c086f2399"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-658188" borderRadius="10" type="0" borderStyle="0"/>
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
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
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
<BoundsAttr x="0" y="0" width="468" height="426"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report2_c"/>
<Widget widgetName="label0"/>
<Widget widgetName="qy"/>
<Widget widgetName="地图模块"/>
<Widget widgetName="report1_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="255" width="375" height="355"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="闲置舱位"/>
<WidgetID widgetID="ab461ac8-9534-402a-94f4-7a122d3715d0"/>
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
<WidgetName name="report3_c_c_c_c"/>
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
<WidgetName name="report3_c_c_c_c"/>
<WidgetID widgetID="ab4fa3b4-82d6-4adc-afef-754433f2f52c"/>
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
<![CDATA[1440000,288000,648000,288000,288000,648000,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[4320000,936000,288000,0,2743200,936000,1879200,2743200,2743200,2592000,0,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="3" s="0">
<O>
<![CDATA[航段]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[总固定闲置\\n可用舱位 ]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" cs="2" s="0">
<O>
<![CDATA[固定闲置\\n可用舱位]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="0">
<O>
<![CDATA[航班量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="0" cs="2" s="0">
<O>
<![CDATA[机型]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" rs="3" s="1">
<O t="DSColumn">
<Attributes dsName="航段固定闲置可用舱位" columnName="航段"/>
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
<![CDATA[K2 = MAX(K2[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="1" r="1" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" rs="3">
<O t="DSColumn">
<Attributes dsName="航段固定闲置可用舱位" columnName="往返主舱利用率是否低于阈值"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="1" rs="3" s="1">
<O t="DSColumn">
<Attributes dsName="航段固定闲置可用舱位" columnName="总固定闲置可用舱位"/>
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
<![CDATA[K2 = MAX(K2[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="5" r="1" cs="2" rs="3" s="1">
<O t="DSColumn">
<Attributes dsName="航段固定闲置可用舱位" columnName="固定闲置可用舱位"/>
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
<![CDATA[K2 = MAX(K2[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="7" r="1" rs="3" s="1">
<O t="DSColumn">
<Attributes dsName="航段固定闲置可用舱位" columnName="航班量"/>
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
<![CDATA[K2 = MAX(K2[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="8" r="1" cs="2" rs="3" s="1">
<O t="DSColumn">
<Attributes dsName="航段固定闲置可用舱位" columnName="机型"/>
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
<![CDATA[K2 = MAX(K2[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="10" r="1" rs="3">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=seq()]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="3">
<O t="XMLable" class="com.fr.general.ImageWithSuffix">
<FineImage fm="png">
<IM>
<![CDATA[<;Uf?eDL!`J:b.!MKF%eh&nBoNJN,'J92:Gd%Psu%7@UX-m7@%SO5>.GB_o3pZMFcpUPeC4>
1=)bW.c9?>H/r@3="Vj1HXeM1gP8USJ1jLkPDp$3&D/M%5"]A3[e59$+YgX#pAi]A1ZP,3,6am
6=Lp'=GGHHNJ?6it%;*TsOMQMMAGEl)0U:2+)3pk`1/Lq\jFM6VA6:M&")2<`=hhH.gj^EZ?
Fc=b5'Z5T9Dntj[?jat:u`/LSTR&%;06A[=";oNg+1s)aqAZ#(LTKF#,%#UA0_R>l-@#Q7q)
=F^W2*`2Z:D"Eo`q;s7b//:-[\+^INgRFe$#3ruUEMWtd/6s7[@#Wm<Z.p4!I`idr4*s50:&
M3Yl[s)1WB#fQ;2+&@Olc@n1Z*m:._T=1@6Z8Vk,@\,H<cQ?2[+'4X.DF+G-"0OcgFB?*JTC
2lRO1hk/g3k$/M'\2ND^c`"!Zq1>rqr#gaPL74qH*2lk>uhsXlr4h6%%nf!0j)Qr:bL*P"_U
#P!A:3=2<Xqn=.JkHf)-CgAUWSm,\$klL!uEkI\#Cj2YkDD5T;6j%&BFpo_'h&8+Z[;H.4*j
H>?b/S8aYA!BWc^H>Nu1Gtd/N(1F1j#X_V-s-/Fi`YB!)ih$q>]A96Q'oUg[@"b39Z=aC*K]A:
_^rVEkFZT?D?EH9HBB?#M?;hm7]AM=85<&n.[;/0Q$lYb.p$XU+p(Y_2+Cl/uDMiM6"'m_ino
SYtN2a0mp"0u:Ft$AQRLJ=AUGCm`o@,Y'68Eu%$KE^i7M:D3Lid9tPJ/qAXp"(J'?m@V)Ze+
/DG*id:XI9L^2mj56qS$OdI+tFj#&o7asF9i^&>Cp13oA\^]AcjKZB$YY[_bu88h9.92TG/P:
/!',<(?5qr8g-$Z=E9F"cdU41'TY]A7Kj*@kg"?fa126.LEp(Duj-HG8r<h<Bb('>sG!YBk+"
kusdB(1\_cJG^3e.u%X%M##*-_n\Ia?%!8jAJ3T4kK)Y=)X/ZW5E+1Q0H'):dSd4b!dJ(DTG
(*\J-*+m7jU]A)Zm#PWN3]A[;YYp1.Do8n[s=RkG_X?B*r!u-<-T%XZFgMc2HZd.@\fVY]AlnE_
#>st94rgt8YIMdX4VAPOgKKou-Ik!npIdMgNW%WOc3?:`l<5i6c:/fPX*cRYNOaLLK(VQN2r
]AUs=>E(I?MrkUb_m5eU@d<aff[T0p:XbcQI<Hu03!5PHCk=I\ETZ$9PSW(qoS5KfLed%C,Or
&jmQ90U``pIhlY3P?$JL#.@gL#O6b3QV&=.a8sdS2f4/:eIpAR_\!+(BR`c.G#+.<pL3RrbJ
aV6Q'#(LB7nmP*-_\tYdZ;!Y6P2G_TA*riC#Em378Qq9@SWt\9>ErhR5N9cG2fdb3gl7=:UY
UUYKBDWO,""4meiSC#$,&$0IpS*Oh!1)MU7r3oi9a6o(,BOqo.*]A=X0Q%k(g::bn(L4<p;\J
%(jdEdrh."fY8inQ-W(pq56lg@jSsEd$LtE:K^i3hm!hH<sutPE2-S.;0d,t&+=_So3PV8G0
Vr(/2"q$hnH`*h4j(l0'<dAS$/DpWl6)[Kj0TTkQX+Q\SeMgQ@=:e=Rk,-EX]AHb*6N`#cVB/
Vo<[bb`q-A*oV2!<Ubl/gdrp8hb%\6'eFg'8Wpf$o2J;hI4f8dsrF;FfWK.hd(<Ij'5!K^'f
S`BAD>!6fC'O/#bD_/;c/\8al]Ate1m_!FbA$,S\@IIo\D0XkqPsa=Hn<8GF>O.Tk"q>PCmlB
!<BDDs"?EY8GHYp]AlD8^38ANrCqD^O`fYrT8LDIL[m4]AKT0K._g\H&/*RZ/hcWR1XE2.#S'c
?FI>6iLc4pOkH81KQ5$0ZIUap?6$`:1\JWNI`[@>`^!=>g9g]AYgAH'%cd5Danbn/"]Ao%>e(Q
L2I?"nqfSjUCBHYRNh'*>4hg?s'TM]AN).+-^Y7T%Aq!m[qgaT8)e!8N^^I$%QU]Ae5%T3:UAC
(W"RN7D*u?f?L?<\pQ!RTD'c5V:O)l4gT+D`FkVL#2es#:B?aKcG0(uGX3LA-UKWUJ??:j!\
gWGR->3kf9K(>>i^LOpfZku'8D\Vb&\@i:FRB(]AjHGf1?\1289_<Ld8fl%@iW!9_FKGF?1hD
iL#ZOsm55pNT67HE8*Un/tp,<7qL6[Vb"X\M'JGBS':mb0qh28ZFgjl6;8c:`J&R7@*--'>%
4tD:5O*K"NU_<g4O.Us3_TuGeOg-rUHe.>%9Jog6P,@18PVIJ[c@8^e*Wg5?P*eA4n]A+#K6F
dW%*j&ELnK^Sqs!kVe<Mmud/'R(sNuIb*IUD)l+++oMX*MoR-;gTNc9UR-*[SJ.($&Qf,c7f
4L[s<bWCi9\NZNfP6P#UGf3dXS!3hI]A/uR/4=>JD-`5%#:[`:b%diOZ_Gg\K]AGcla7%u(&ZZ
CU5WRX`jVoAl\PWgOo]A,7/=>1N(9L/+j^P?9]A/ij(t#XNM/Q(djV\`R*gg\"e2CEG-:Y>DPC
le%tW%)m?;&U[=dM<X80bahDeHX;[fXhYEbY33>)I-53LTXTCuG>K'Kk7Na$p"rs#2+P-j';
\Ejt08obperKUBk?e3es-.i/TrAFP9r>2qsP9l8oC_h7a2.u\k[J;u3G]At/XrK(N)'D>>hC<
gYEBD(+0MYQ39RPT?uDQ8)iEdf"h!)Xk7\H"Up"V4.]A`(W(k/+R&90TAZfW4<0M0:NIGj73r
+jCY%%;%q!1[Z<)r]A_t<`hK^Ns4W)55NiD?^Sj<;.kFLfb;7mUjGlB'V(6`LM>iLOh>,!s*K
/esbN]Ac#(,.=@FTD*H^MVbm/UL1j<6rDb>8ekl*eqoA7BSl4ZcMs\:_lq/43fI=p)OC0'>!@
q'n-p&BjuGFh;@EHLof2dUHI$`F+TI&ha(U'!fS]A1Bf]AqCaXf_Ka2\/#.*M&Q!Ig*l+#f%C4
YpSF2Z%*?HTa#05?c"bANN[bXiSI9tE0+t5GDBePg:DGd@m6D1HP:hcq%#?uML$1\-i($H)h
/)R*c$mqj2T=hK-Dq2%<T_0)$<C%d%Yqgjf$i2<5QmC4;mj'Oa+XGJd5*j`tKDuXbYGb`_EN
2pCEju55Fl+M/`V(eqGT?SoF9mUY[VNH+Dmu)#3%hYYJ,_:7^-W+#n/DT(LR(4O,qaT08"9:
E2,6R4FPC?S@JiCLR7-e)k\E*A(l,(03KF#ErSLZQ=!PFJ9n3's5tFdm\o'E"Rk`%Fg7KQeA
WG0_lI`N8+sGs1O&O,HXYP/9l^!R`WH<?%VlB7IhkCF!cKq3&r#,`JJ]A!hZoP9_fh16Q2lJE
#?AjBr7-5F5+c:X$jFX:X5<_"m_4jF(R*S:?ho<T6:-pXd@^cf]AXi.SdlGF@<LX!o?'KRYY!
RBEs$^lF?6ni!oa6/="-G0:d/J&;<hO_Y)p.@rp`KI-JfH-2i"<USOZ.s;R@;7\OL"7pQgB/
2F+>m@U@b1.9[rSM3EKaAh!nA;dqdQ(BeNHX;&b`XCo-CRI,CZcLlakt`eAB6cZ&bNS+W)Nc
Z6YS4h9MC#f.c+YY**[A?N)odJfL3^O;>naX.R!7l55ebtq>>/'*eRIY$q/o8FciqGDf,e:&
2f(HA9e6+@mgM.0k6JYnC?#0o!k'.Ta6m\W3I-CG7Z3r9q`8EIN]AbqO'5emC>cLCieOG51Is
pWKTDpZNV=[-06DH[DcuB[G(l`9f_]An*NGt)7iRI8pHkJB,KPjUAiJ/JY\]A2RObI?:3>7Y!u
58PRkLC+UWBR:!u\jsdOgF@k2]AI&GT/JoaRDKqF'>S4$Fq@ueZh@B3q-n#1Vn&l*L==]AM3Z\
-N_eEpM*)*&k4\#6FB,Fl1cq(,9:Zq&"Ho;piFu>9c".!XKbV1pY-.3]A1`-O)6iW']A>$D5ao
;BohQJG!KO/6iS,f[P5@#?)L+#3T:88*#XTP@1tn%2A1GRL<r6'8G0N]A&'Ub?0`7%e0eJN+E
.gICl%lrsgR8,-L:!k^?p&?=/HB(qEFXDo*Md6.[%>AW@QE:n$T><MR;;M;2SfljEUXF5+I+
Z\m4XbEHlNe,Z#:pD1E*M-F_=6V^<P^i5srEEl`Q0:)D$aO(\f;%M@n(_d-eMZM+FFbG[K/V
gbqj3Y0S"6N'Dl&5eMHfc4X@k*nNa@m*?P`dQPcbl%.m/M\<M_!*X/>L=/k?:>V(A%ED;_5c
hUQf463GfXAH@c,2;P\%a!GBZF69:[uF/,J?0W0D\hA<Ej\i)2sbK#rRO8Y)sJX*U0RRplWE
R#c"\H5b3SVmh=9bZRQnnh!k9l7pf_+gFeCH$V!%up/olaeNk?\6#<nu2)C9:0FI/sFC)Or-
7%eFYIP&StoVGk1#mT>H/U!s&(e.FO8[CX,[]AkRa(-LY/NF""WWq4+i0/M!Z@uDJ3[r6R<Vl
93YpAK`oT0+I`LC:3+eJN4pC'T"F'60"[N#7Xg,PH41J;455LTR*Y3i0W$huh.R*n;a<PeHj
=%9TQFPmY=EZt)L5IBghrr):SPq.RO^hp-s20Ega">_P567k9U=W>M(O/^OqK<Sd.inGHN";
?/gabmJH&7[EMCkhrGUa*k.k@/BF&=.*CD%WUOk="V)!Hh<`^oD\>;--S`<:^i6T!nMrF+LU
CJU!A/(c''E[:c!RHhGRFI!hCi^PT+7"[ZQDso!l1ZKC8*YEBFkV?>@T%j!kGZ3HlE^p8o)M
_!?$1-AnB`(M'bT+l?S+)oP8LD3s/Zd[MC=@&+`VmYS@q4cVW_;/\IK1++!b.]AElX98heeC<
]A:td6=s'pZO,P2U+9-;+U24u'(LG\2&R)CTU*I=#Y2`uH>S,IQr8.,rQTMVdm(R,eZ[[?HL-
oP.UJb0m_VL;L)=VT[Z0HO=d[F88Vc"D^Tb<]ALh2:U%@aC3!I<;^?b=lRr6d]AmEXp)HnLS]A"
YGrH`P559Ya6sI.GQU4^Dc@=Dt&61^eIVHDbCZ(2TU#rWflUa;)Va<CjMZ`]A`pHq5n"_P!g7
13qH%Rg;B;qY:\/r!WG,LV0c]AQa^>SQ+`&XlH/8BiYi)V!3baiV9nQS_0G1r;5N_2Q.e]A&V?
b$(qP_Y==3_h7#3Q%@d4Z:_&;<[d-POBA"hPGV-*o@(3[@&]A@f*;bEFYp\=e(/%PVM3/W$I[
8G6fEL$eXUhK*^,RHo[PCa5eNgcYCnI1>M>75+c!QOEahETA]A\+?&>O'HL]ASq/`0??&lCLSZ
5P"&p4iA5.<BDbJe%pN=(]Akl<cS'rh70LOA5I2?dUb6ad:p"<X:C?8r-=oHI63Jh4VS(@S'6
mVtoW>Y!lES^Q^q1=Vo[MA/)5AL=\;mXijIkU]Ab7+c)#9h'4;aU?W*VLN@X*g#n.Z(RTU=u5
<!qtBc:JA6r)O!a1t_M]Aer@U)rFN'o[D@#l>^KbaI^lDmua_G+CZTQP=rEek/3k=q>@]AE#V-
,1jU-,"UM&d1I?iM$Y9Bb*J).ImI2hD#_20u&FP+sEPm?LQYL]A:8;qN"5eNL=VH,_7!&uXYU
rqThIfXPj7^(7$$QqR:O7M@Skg<cG?olqAg@-GtI>G.%244#5P2.YuV)Rl@;4qp5u,uRm;bE
P39P@L_,HCFOT=%:.!,%j*WRYhD?qICD6FRpWO6egYO)-k?2)*aZ<-U,&!W#2DG2YD'cmc0$
mO_g4Z^V?'2cOq?!B8Ka(am_@sAOEZ_:CPiP:G0Z!6%qr'iX<Skp/g9pG_ttU@YOM-QSTD25
EjOVK.%/RMWjD8`%-^_;1Qi338'lK,Aq5"3KWuI8ANX>mr^#?kJB0\^7]AGD2ea^X43p$\Z6)
Y^Ct02:[fdeS'H#!Z`k)9bhUeRc+Q>-9IfVi>cc]ArJ?P>D!HQosTp7cd(?-u4Tc,5SNn%HT_
f@`(_4g3*u3s.)+QaO-eFBbkF3D3FdIl:L@Et<;X*VnX+c&/kS8e5YnMJJUHB!+#f"j@*,Zb
T!X[Go5,^*-6'$f$'Un_Ed*4Mt.:5@oef]A"[I\H#2MNgW&'pq#B`7_QACPG=tqajS%bc_\C0
-6Bb+Cc8&*LMik)(W1HttL_?4d`TF3"!#0]A#:XS"%Q0eK1\`\#Q(-F-NG:$KVoFd;b]AZ_4U'
OAAGXEi$&?[SYfMd:n3Bn^u[[*E8F$6CR"^,]AHl.W#(IVUJ=S-j3%U0#TN^K>IkE,aL`(9tg
f-q5=iTJ<S5PTEV=/+`W,Q>Tr7UEC-",9,uCUU9I;&Kj'J89FQOc>(KY#X_,^[X7,o)YW06i
Rs,PO$B/*2V4sNG)J'^5&\1-).]At'0`_\4]A>5X$7j8^^+)pEq%AHpujN*gJ9Voi$sYMImW'e
s.pZtZ&;qQM9I?0&@.`fd,E]A^,iiA\kZ;(3hW+:C\YM[trdX?[YXXaO!i4o]A^ql)8&Kk(oJ2
gS\eoi/cG>re1Z-V@A]AJJict(?::MY=_d^=GRL^D/VA4Bl6,QAmrP`^FFO64%+)Y(JF>AMKd
mWJWlELB"GSsB*]Ac91ef+de=S97.Tp74kR#CM\3+^7F\)H&FqNdmPt*!QtST:Z5!ZFMfmo(;
-kXWY-W*8^L2.JTBH)VdtK7m#Y![da-8?/A]Af>ZkcB[@R"h,`hb=nS^=XO)j/Mh0eaE$SM.-
W$J]Ap)6WuWr=r=M@Z5Ne>Ri+Hq]A4>pK*joq%H=(jp)s^1VXLTUP`.UH[f8i*cEkq<k1jg866
`M"88Z&;MAc$q;[fTug6C[^Gp*_qE)Z!sS\;L,D'TNQ/Z!2X\F\DE,f"._A"cAq-e0\>cb7<
BVJ71F4>He"UogQ`m]AI@36n"\7j?E$WpGsNTKcI>L"I\"K\?=CIL!:%^pc.$#l;OQMb@Jkdn
jI]AGKKIUhm_N`eLXD@A'/:7W=PI'm<L,VYn9Euud#6dW<0#FL0qgA`It+Dt@fWOVpB.)r%9V
'!O`GD%`P:Dn.5tC\^Ghs$Q)RIeY=8:,iM@gPr(=CI@'9"`gdm'7JX4k"T"d'+rq9aPZ)BXc
i4eI8"flj^\2pUZZB]A,aleQMcjs-jVpMf$O-Q;G;bJb:WV+l^KC5%-<Ia@L_apA2D_>XG>hm
-M5Tlqon*JP5#^'1(-,_U!m+]A,05lN<lbZBa[Z6Cq<L;HuH]AdY@g/>pa9uXXUbpbG0"ZU:E6
UW]AtMa4X-\j@*:6c9BK(-p[X"_^]A"n,TAR>X,>/&TQ;:l7IKnG'IsiBK4Q:;Hr/89G1Ceibh
R8I-\lO(bL*O62VS@ne#B)r7Zk-PmA(o#+IKB#"\aI^Q]AY847W(Ao@D\-D;FG%\>`(455Nda
QafR1G]A>fs!lg\uKYAJfq=enJDNJVC4tW>,ekj[>N^5$kG$2)[%sN_+-^O;MV4TH#nSBXLLX
(/KjsD)\B:=Rr4PJR!SJnZh44Jsu:60Pr:BehkCLgBchp>VOUPG%b(=U-hk9=QEht7lVD\]Aj
eBZX_aK3kuKBrgE?.thnK<4$mEji::7!k_YdnWqcO,-6G8H<*JI!e8t-TsC^9+CONSMo1'Ic
tN'G5D'oCLpLrKo^J:mm-V*a%l*rP]ADX)Yo(i+gqTF`7!QU^M+L@Bc)3Yc=:,nPso-pC2X*R
F[H4fS]AG=&hc%XDP5p4jB"G>I>30]A1U?N@MLhGg(!lP$5pWqOh-\9L0iF"L(<8#Y.i-5l0Uq
iWZYN4L8I%`UHAlr]A[$JWG?0BI'4<9Vj7t!d)>$sD[J>_hqn.M7HRBj9aO+n)9]AH"HJ,JkTQ
eWDVoDrd:T8<,[brKU[bGUU5iH`k[a[<P]A0S]AI[Ar^rUNY/M&??W#*Uc0*BR%+fYqN;3Y]AF\
/)6CLJm7C/rWcHm<6B>rq:,`2H^,*HiIs)\(N]AW-S]ASCmTRBf7<9.=k`)T%f.C&6[ZP3mT>p
7K]AoF9cC%-ir<X]Alk>Pa5W*nq3eQ7koM=tW.'@ILT..8(UR5HaE[[]AZGT>(]A2n>h7[:Vhl<N
iHHq!aa!(XQppNc'>!NbG1qEDO(\Yfm3'2BW,s-gL0-Ke71O-?L+Js`7dpkZ)J0""lUKVo+B
m8mj+IVT#2GEW@7jD\&ALlI8h8;1i#IX]AmghD8&^WKBK$Cr=oi4q8ZikNQb&aKoY-G,n>@eH
P*,5jT?&?7pcb6]AQ_h#iVB^DLLR=I.T\7>LbjrX?OC[g@>3hG4CD"[F\jd.mn`.1"*m=!*HU
!*DS-NsjX30\Nb_.fS,n]A8]Af5^$a?_@3:DnqpeP3&+D";fRWOo1uU9o$+\e*D[=]AMW`oX1b9
#>k:fie9<K>#i!PUgCrXNg3V+'<O>`8YU^d`'pffGGf0:+R:`KRWUaa;Or7_5TfDAWT@_/FS
`M8%%lIDKcBMr<hQ?4'khE(UeU56EH[B>m2HB&/9U0S4I]Ag(J@WLE>-VqspBO@S_\sjeV-T:
m=3F'L2=X#-:qg\MAM`)i!.b63Kb';[JF"ju-MT>`R64f#>[$Z6R#5k]AQ-f/1#Cu>dbX3r/c
Vt:m8]A&3EH^&RJ%2`a0nnC>(#JhE&pl6cFLc7DH>0AeXrVp<j<Q,1WeQXf.M,ROI#k6`6:1n
?$>V]AmCJ5$l7@?(\K"O2Tmh_e_fe*,"cte>^37Jj7<C21XD+<-14\=-e%BH>^UDcJVpO<U'O
X3i"!rdsMk5DBT*2q!(clIF55A17L39?Sttu$2)4MC8cmR#8ZF9h7$K2$n>b3@qK,S7=Nnq*
3iV0fNd_8m;5m;l%$g<&U)h%"o315M5Y^_QZib1N8H(W^a"I?b^Vk?:>lH96AU:,LYb\,dLc
?&JdmiW>f()<Q.\7)WdO!NV@Eh!LXtdWZKQQ:>m:s9;<+':rSJrOKGk4,>P9M`a>-8\--l@F
UiR2pRV$ZUNupr\Kt&"Lb,$_t45ISV93#Lj8(!B[hj'2V:k6"30>$nZmQs-!B5\C8ml;aPCd
;!:o4NE,?t07WIq/D5YcXd<!.9`@V:Bo/O1d%d2]Al=+/*V6i)SL&4Nk=MGI,c;L5-LB8PPq`
%1'@hR6OTDT%3b>pQ]AH)[?U+b+(QtLaJ%%5`G@"/<jeD4LJQ8a5@L0g#fIQhq:>d[]A"0QTnb
G$VX4X&$=5IfiA%,@a6No"l:oK+0F)?'IV]A5NqHSMCL!OtG%f1&O,/':*'q(F<%Fme?9VQIf
.eqrV0#c-qFj'NhqcXaQGH.]Aag!oQp%JA`a.<n#\I$e;`F]A=IR(MgjcHt@cKu5bF!f7T+ugR
,_Vo5BHkBnUl8_'`1M<WYJ^*]AWT/)R)2G?WG!"Fq7@Q9=:M88SceThZmLGtBa!NI$$m%&?U[
./U<!DJV.tTemXF"%K[Og)YG5Ca%pN+6kak2Pl^ggPG(l9Ep"<8`u+IB%E?MTuk[Q1ra.2]A$
gL6G:*;-^XYd&YA@qK4<FdZ;!bdk1rrKj`b)!6=Zo[&\%Nk9X!]A_+u8p9?APsn(d%WOq[A5s
.[$HFc4T]A;<0UQ9+%*[_.lDFVfnukQ0Pb`eW_@,)gN7ro?bB!q6B[$q=9,Q4p5jnJhs&*8%`
(OCW7Bc)/m.rpscZW3ZTr5S^J<i*a(U4idY?*;bU*B\3p\QNZLFQ@?"2rAB$6aM"$:9M#I%b
I7EZAV,KI]A2GKQSd(.WTYqgBX!KOsPPi&]Al4[CXu@b[<TkmSAH!sBE'M]AmFO6Jd>9_Th:B2'
Q!N+(a2p\8qu4<F[lIopin_;ubu1PkOuIETfdYmug]AHX</@!b=3J?RHE%!fb,]ApRSr>?$tp>
X<!GVP\T*+)Z4eWnpk87!s5K$-S=%9E:I1eq\JKSD6HXsp20X/jdI[b7Bs'-9)clfAjO'3V$
G\0Bb-W@em7S$-Qc`q&T<sj&Qh6;4GhkN@"X4&g4Ys?Io.Ld>7p[$SQE&g=(p?DqMd1eB@b<
4]A/nIQ.'O=$G/MNh9<A3?s4@';WcPlZrcW>7+/Rj<d!KWS!.6l((Fh0+kc,T.Of+ZA^H%/.a
(8Jmk)[,:&"`?nXbI^:]AE2TMuG.W\=c@1XJ@TRl)(jg_i+t;lP5*[.RXb;JJE8\5WZbGsd[9
^V]AoEIe7#/%Ygj]AUV"gQR948prcTH"$mu@S/0bj\o'4qN%La`Hc+HkRY"E7QIE&M#oQh-F?]A
:I34+Cnag[r:.]AusSDPYFnMoL3D(uFji/3XV;d<@n5FnhAXAHMiON@;P)(Wp132NX64mZl:G
ABf%%fWI-U89-LJjYSXn))Q5o`NJ2+k3cF_Nk/(;H&[J+Wq%(2saM`<"=_i4I;dN_gVZj%l:
\j/i!M'03!O5BmuK[&(LHe[gMY8$pZhVI9O_-eKYBT*$E\"DIi+R+?ZY"dc>kjnX\O*ESc0P
f'N$'$d")BNY+F`YF7gY\IQLZ*nG%;O'`&U)P-6ss(q-&QXh9%Z^mKXAprX,%&g;ABK3VQ:U
f*UjprUt^,\6M=q-1`Jg?JANJm<#aa$19s"@upE\;X`REYOHT\FQoq2o)E+?17rKJ5g#euef
GJ<W-aLC@O<XneX`m7krCg0/j^cGeg:bIN,8,_X0,<HbGX0cXcLPn-$t%m>fe!\YoMBd>5=]A
1;g'$qZglm*DKBJh<b*=+>4_jsPYZEV)IkG<`S+GfM).9Q)e8,mFT`jaXeX[```e'=er1/Fs
XacY(@:SFDD!X*@5@(/qGodWa,]A6Jc(>*J-g[OhkO0oc59d_[Tm=D.(lLn/SuG(fSlO68S<c
)MArq$FV&M9"PfYK_\NsZq;U15^oC?Y'dDO.?:\SfQi:)-fG2!U]A"pK3S,6U_[g#o0P";(bm
.5`L`#)uT[O%.6Df&\2/NR'hOQc4r?BUe9MbI4,,=%Uhm5abKM>7sFL0)u4+[DuZUN^X_")B
J,BC6LBt\.$/P-Vl0jirs1]A]AK0[ANJn_Fc\^(uSXhfQc99\7K>AGh"LojsHLg7>7;;(+'O8/
WQu<h&fK'[.2,2"cVV*7SCqc`G8"%r+S>6AD!1neEd()3PJ>M_Z!9<,YOk/(8,*B;Dk4fQZt
\DmV(HN-;qh*[nKCRq,5&:A1]A:QFH@d0PHk/TVG#5Sh+q#A[`'OR;.]A@BE=Q"-r-RJ$KA;IA
h:TEnCaFLK,F1.8Jj@sqBl!3hP7&+#,N,.RBs,IH>\u[o:/:"HO_=HuROJ&TokM50(\='/!#
B\N`e=oc/BG%?S/Y`PpATluI%$7l=3tR,WhS]A5G70"!E!lau@W?D2-e60LN??_B(d?rdk)kA
5\RNAo;\,%O&?K.F?"L'I$HM:d,DD$3S?\rNRGT,/3b@&.[gm5&ke?uk\j$]A*0hnD*FL8eqs
+[3^Ah^oekXKleLZF<%*6r*F&D^$!\R+usNMHgq+taEYX6]A!Z)[J28ed%g=>fSu0SN>-)Mt]A
X_Fub6E_Fj:hRdS[Ib_=FP9Z>USo><*#V1,+h&@]AiUJ>hbi@knbA4K;k8!]A;CYdtss$%h3u$
b"G1,3hJo!XR8fD>ORVffMMCjG[b+3[GJOR)A`3ATu)()mV9H]A;9:lNZ_l?P!PcoJe@KoSo8
b3W9jen!fBt6%*skt>C0GltOdp!T_l=5r8O(oS$E'iS:,7ggJBu-D`<`05-]A5_"V6ZCc&_A?
'DU5^EQ9caf6Z"=$KP.S3a0?CGSs^AEc-Mm*mjT`)dRI=_KjI")3c$$%q\=4:WH<UIfC?A;F
l'1eDg:G!4(m9\7A/Ktm[FKn%d2bmQ#L%hMd:)lpKElp3@Lc=55N\Pnm`-F_eHrel.B"L9H)
ILH,/:BKTYU`pA40-fkgqsr;;c+_[upRDu?&o/J?Y!+-YN/e(^)V,`.?i[fU1mc,?gb70ic!
Ya6PiLb-brJ(FTQG5%b9`cTDEMBl'<9s1c]AUYAJm4$2&F1*SJ/>"I]A%kOmj6F';<JFm,970?
k(PC-S]A6P(&#P6A70W^[+KIUTR]AEas:MZ-(EC"+4%kDQREj=F7qY,$liJ$qro=LX^,$Ua2N9
Fhki!+0j9+7@YJ.&@6#I4fjXW0R"PB'Sr4]AF:AO@So9?o2N`Vf]A\CX,]AjK5K'k&e'"D]A^1&(
Lb]A`afRZ;;HC;iS\,m,$g"j%l,c$g[mQWFU!uNY35_)j"W#LZF1j6ZPtD2$H&$!mh<j`,2!a
e@%F>tdlJ[KQpGsP&))#;RZ^-.6\1$*o"sEbA?B:GZn,#a8=('G0d,f/_0&lS,^%Th[X>+P9
as!oS*nA]ApKrXfZnJTo]AhqYJ>R'l]A&;Z'Il.O)Q!P76:/R7osf);U.G!DPds4;8VT/c!&i9M
J<"^SCM?.6Z[VXd^Zp3$6PWEW%tn5<ljR1sDf$.pHB5pY9^(F8bVL)Ak#D5K$^$H@'$GD,Ar
.e>QVd^Iu8mZrj<6l5%=2^r0S/DY8RNP_oB8%oE@mlS,M(Qb.S/Ee08g4VZP'ilV`\c1^!EN
;KL)2fINm%L;&mJq6-c@i<OR="`/<cifNf7"hGPZEj=2e/&l$im-X5M9E).n&0M[D:od<d@j
nIn"35CSl&nWja0VPZml\,kf1IVO]AiG^,-P`_L%VW&TK9u*iI'"9"<PQJMYBX=b_Uf[I>Mk4
+!a8o6Z,Vkms;18P0#KjY/Q&:OM9+D*;_j2KF@8BJ*f$rN0hhrRf2>2a#1cr3kK9VI]AV:<Ik
M$cG&UiEAKGG^l<JB+5STJ?Re8uHc:!a*aWV/9(S3KjCD':h,N]Ao>mS^Feben6=H+7-#GX/^
Kh:5B(.QVjrN<*l9/dq6m:%W_Hnb\1#jb,%!AcNmm_&Mo,q7LiV>H[j8+bO#<L2k(Y6lJaIF
euA$O^S.m&L<f/]A0C%NA2<p:X9(B&+N'dr[m-0R8s@'H^&9simHLomel9(o`.Xh@k34.5BJ\
=D.RLrfCrV@:D[5;<pPQ%;`(V_["Ir'59WoXM:k%m_?V`<"r+p%[VCY@0DOC#^H+a]AP24^T9
_WU*^!S]A[N!K\egEV"Gg)Y)u4[E:bh_Ol06h18Ocg[K<'EZ"fE_L#J,?s7Q#7Hu_rCd>nQP$
#nW:Fhq5rh)mDp>VDqOMpa#"6*e.[RQ4V"A`jsa$L3Bg7:e`Q&]AoM?0KeH(Z+]AUp"Q6A\4S?
m`X;3+#(d5TK:YGr?U(HL[9NUi5FoQGo[TpOpgbKpYa&sgV8"k5PR`OSSQDP%9I"LT@YPq_W
[b_e,<bYT8>D75W0-IG&MqQYq4q4s0\['\`0cDO0/F!Qc.a#\'7%/lhf%?q([Fk$:-.=&8\#
oX=c_&g,dmPmYE$DPPhO:*,T<7D`3kNl-AO;pc#*LX61NL[;1aje:^XEI-m$7X`/apEkT\9.
N#U.&fJCDlSPt5n1^G=n.Gn:"@R'k2OT+TF&eFDMU2n*H(EAt,e;<;D>kqg6A32`%RiO5B`K
f?YGdUZ/a'(!0]Alk%T&#W.@"1KaB/Y<mP3"O_\7iZ@rE1p5t50?']AQQ"B>\ZI[5(@92@l.)A
Oq8Xbf"KefhC&DoKh+?K@,DM:$=+/JmYd;6e^>iLRZ"/8(&BkUiV#p\bOX9QF"<*Y\]AI?I)*
Y3T7gK4%",$V*92A*Fa>V?l5ndlUCqE-GI:e/R2`r)n$G_M!>.cEJBTMU\E>GpB_')T.u0HO
i_>(sh;d?&N"&C==*;1Vree?m/,`>b#9KJ;.Nel\u02:J33;c1)IV-GU]AIl999nk-r6%M5Ut
#Lq.8&LbHpU'MC)[]A0BS&A-GOMX;dAC?Gs=P[_T)I]A#moCq:-seKl@++se9`-50=LmUk3GoA
NY\oabf3!@E/$/:F!DK@P>"q_;.jH>ML*j034:MOL/]Am`*+,'RkoKm\^m4C-SZ'T$\T[A*k+
EkH:AJVfdtl]A'lbsn+B:^gFd+IMUf^58;o`&M]A^K5LHODb8K5V[TTX>+n+`?KI7Wb5Fu"]A1Z
LP[^1&oe`5kZ7g]AD`0D\,42.W*t%Vk"SE3@uK1S+fi)p%T=7>)db=uItt++Lj$Om"87ni8p5
lmRe7I.L+.iAF)hX:G%Q'%kXA/#m@<:rq>KHW*g[VCRD)j]AhR0N^H5NSe.IR%Bj%&X+=8.rt
C*0Vj*@7A3dPD!ZQOMM'Q7R2fdr%I_/Mc@%.>!VCa2Yik4j'.#q6IGT:385GKTRTiQAdh%1e
eMO)S=Q3R]Atc_qRF;_qT,uTcf2?e2'Z-6F.dPZ'U%W7l5=uug`_(6<oK%>IU;X4hn6:sNQOT
/F#WkJ"dcCo-s/V9kmmPEK'=,794=b'WoRZJ911@*k]AgQ@eKJo4(UL8_^YKJX>/_$0XVm5jL
!5JW$Kj4a'uAA)Y(pV`h_ta/'Fc';%eW*igjbf&-#&:pA4ftLra>X7GLk8q,<u,c**"6nW11
6W1`0[gYL#"V0/;A@\[-\Mn$,P8A'7nFbCis%C_e8+a%\.f!BGhF%Z!QIn!&lJqdMV7c>)Bn
/TRe8X<LVbiJ.1a3-me<\9?OeP$LqiWS]A1GX#:GIi6[u^*uDmU4%:>5F6D6IkLRtW]AC0uke\
rfmMbbVcF2$.AIB_Hb*#.e`?Wl6o;<W<'$<pm94hGZds*1#l'(?J]A^7BC_ldIPqD3pnFTu0`
e[JB")cX"D=3>Sed]A.!Q4c:9CL"j<oNh4LJ@AiFWu?&fl.X(#>Pa#of,G=ZK\;e)DHO#i:<i
f"P11,B6>,CtKrQcSF64H=.HCb$0W1K0Lqr:9f*fXqKZ!hnF>FBCQR\.\S'F>*HsSR>KaX+3
Y")u@-:$Ff+;%CeOe5DsRSc1=*l=Y8M'b`0+3rL(_rr[#cpl1[Z+1L$R2qY6O=LOq=?rO\^#
Im#E*6c5rZnD?WH(-E#sZ7dqXm"E.HTeu/#%?MXl8cU:9/fmen[XfJ)T@\<<)68*n:&5)$hG
\/E.E<@=NG#mOVT"KCOmZGl2_4/N1EA=ZbUr8Z.A,F6W`\P6L_BBTXS$I,HYCJU;2sB_da$?
N[P/Gj#S,UAG#ZOE8I,PAoT!_9%f$>)'hU>\7bG&fr@\,k%i4+'=k)@A$#+q"&.mXFE=JL\#
M(Xc;TX,Q<O4M2*H\2q;#XcuW"*PZ,.8BP*o)HOk=jVBP!uHG/A%rtetSQSNf*.LS5N-n&@$
]AFPZN>4EN&k[VQNqrO\kM$[ME8Oj@WOkK]AC_+:FJ*)?u945h0!ks(kLtoM<\A0-:LU!*>$TQ
QNK8PV0u`=G=CBfmWrkL25ZRp#pnLCZc_jEFO,6QUD??;f8LPsi)V0'U&S\5L`NrcWrqQN!A
i)tT=0qkB(f<`'l2@dg4(6`L5qec]AXG+!Dtl=_W1kiEcYLnd9uQ\,@ahf'G&fO/eBRkt#g(r
@i8mZ&&!-8N`X=/ZJ%PpX%?Lu+6oVsbSISoERn+^e9I>o<Gj\AU84khWr>dJE'eaRag(j<Qe
nsr@P+@TJDj$q=oF>g(Q(jF*!OiH3qGeC*[o(qo2:Gl2r!`MOYaJI,L;NZ$`i7$o9QW@K?1,
nP?\rtRDo@\'8]A9o/aF.Pn)gRkFjX"qMrEAu!9poA1.%]AE'n:Jog4b&k2.<Vr0)[6AuQ5D(^
hJgms#<U&\Bp1:bhGGrl1Y<bamslp:2+i+ihSD8gO7US#/UXBk3GRehPT)"gs&UB&T'26b=[
.Q98sD9=c`aIS$P:FsO$,pf(e81o;X1CVB:R;DMlhGb&UK*F$Y1SlB[t$Tj2E%fW_b?8"k(&
&G4P_o.a#rF/?kQakYES_.B?&qrXn-T3m:mk8=S$,H:rOb*T#']Al<N1?W:EN#)_mdc]AAgN=(
QA!i6Yue9oUY,"mI$K9YX6P>k6Eb0-X8_+XS3,u94nmF>!t>>i-C7FkLXr>)gI1ID:F8?HhT
l;\;dQ1B#%isf6r=3pEbrQE8RUl.%Zl,0$684lr!9]A"sKsSZL$=SX21+f'a#qC\VJ<P70d4,
jO9AiZNeTX6\8IeK/2gq]A0Wd`And&[&2m(QkLr_(%C`D3bZ;EOn97-R\7tI5).Pb;<?,`o%*
6[u@]AF+-"ijJuAbT=W3jh(&0i7'e6h:BE$jK6V%YcEpO:Wn@R`!iCYLo4Lp`M(s(YREq!lUU
&pHjQ),dBp8j+gs8FXJltn*URjmEs\Hq`CnR'LH$-kr#OEOBp]AKbi`'3l0Fg-#o5ZcE]AWT)5
..<<`+Q)k\!CWRmB7'WA`sAfM=<E*;h=UGb46csq"'\h#`e,C=Y*f0Buj7_s".)3o8DNFl4-
l,6/i\_L<'lOZ"1Vl,[@sHL`0#<$9J,CM'QA]A=+!m`:7&0H,&u1[KO!?D\u`re>`sEM*'Ukm
dAKhmL0[NTeH3qA%o"M.WnCDfWE%c$>\>[C'0'^VIaFePMuRL4;P41_7D6fr6N6PUPH"U/LW
gOSXh,5+Q93I>;5AtMSC\;<oP9]A`;[b94RA#%M13I?tYAsfk,G"beYu=,JY\W$VS/lFG?<>2
c\tMH`P[u!bMYjpEVD<P`N_S*cV`f#C2/!H&7qjh*aHomj<o(N7;Z62[7Q*5*#a\8,eQ0a'^
SFXii/:rh.Le__M#@Ah%Tt;_M?f+S(O+W*I'2H)-Wh(V_%m*Nk5ST`c>cEDY6UJC;MQA#S:e
_Gq`r>Q1PiN;^uPLb`RF_d6!n#BYOa<3<M3nI@NoJo;Cd#*pU66-pd5n#A"Wh!EYME*04+[e
dSA.@5md(P%cs=n:ENMlbecDpHY5HEcSO$\3n"biHkAO5ei#c"A?H^&A!k!-"M3H(dk,#oH0
qQuEX4*CiA01jq?'OVl(dIWiE=FC,^Wi%1&IrR/4,J8kX'=*lLBgIH;r^-[&,7@Ue^mNnE#\
c=(#F&C9p<LO7./uKJrC[]A:5PQYl$16HeN&M,(_/i#n6$1Nu_R&S\M0WMZNK!6D,>P\m/AO9
H,u)Ef[,1"ZNeY/o9=_7DqlX&G6jgY=m%'\]A(7m=a?jOKd#./+`:'3q@@@0I<,$!s6ar`Jl8
#:<%R&CUe[_k(g]AVuUW>M0jc?$]ACVZ1C"B(_@$`EH.2<h=STa0j^NTQ[4$tE7DUcJmGl%]Ae+
%I>qa,G&USQ(D649i[`P;PSioYH@SDdO9U&#MBTLP\o$YFeV]AMA'IhfOeZmpf1k5E]AGaH>6b
7"%"7WBXbW9"M`joKBm8l+Wg>l3XD57M*Q;-;M\<foAFHZ/*VI=0#ITmE'\Et=b:L&/+N4<p
WNaYGAs"k[5)bnja4mjMfA8-4U(Y>ta9HL'K+8dFeEg>9&X?eIaeo?gKD[j=r!d@@<=NM2@Y
uLjQhJLu)Sl*n-!]AY8d5U6)h.5LiUX9$!)=K`97<Mb`2M4X6q3U]AmK1hE:&$R[!'f:7HbnXB
nFi\<WJ2q$bt_/!I11MYf.U1BYVJa7aP&Z7DGh]A5U1h.Gnf"j/B+iLXh/_mj;nWqarU7L5o)
NJKml[,1T7,Yiq]A1I><+bGKp-`g8BG\5[JrgpmhYRn@!Cn]AT)G0,!P1FK!;i:n`-uRh!*E:>
,Ph/eeMrC#Lj&U0ttj`HNF:1G37u>SN"=@BH)lkm;33<0UDC!a4?(=I4R6"`b%86_7/&"lLo
M"T+tOJ-68nXGT'5[.=-:*?u\KOp3'<bm5dAehe\[?p8_2p]A-\0[=[tQVZoR(qlh>^CNJg=A
<s(q-E<_AMEbl6]AAjtH+rXoc_P]A+U&>nH1Q3oGn7%>nA=b^4%pRAgT:r8P@pnBc.qhU@?Cp`
aE=GHfaOYnac*[BXtDmZGc_1g9pqbAoN;aqf<jgN%2!<ahmNNH,(i,3S(4;&+2c+ndLmU550
OtBI/5J'VU8T2#pZ(O5#2U.Y7101`Bb[?hVrA@-mm=9M+qOjmq]A/J,@GMaUgD4$QP%ZI+o**
V=-*[RmtCi'+VE`7'pnMN(C)'5b:\bRJb.I@fYBM#3$4Ce'cJ,$dg7L*k77IZO&n:4$WG+H!
&iM&c-B7Ir/mnY+['Y)%@&h1<;hDT7ToK?uCEb5+9&!OQ(aBXrAW$L"]A_$4f&7!(G_qmK`kB
R)E3lF*pQ)NLH)d?JK,$d_[f(=T6cd*12*m`06QI`'KAKLYF++dl)je@^[+EJNgn.G%l4!i]A
?eRr(-*f(+R_7Y+o(j>\jP2##ro6Nf8.gZp`cLH[d59_Qgb0[uOW%#j%m$Rt+Cc]ABFgB]AXo)
?E8)ao&Qr7PK^Wl>6jXGr+f]AOWLVAFS(="an[t4DqLqh,os<-^I\^d,Us8$WIM@Z?)'#@)b]A
9!S7/Mb^nE($_D3u^ir!.Ouqj-a]A3$BoJ4+s"]A!$I[A-ZkKVo67hfe9"eCGW&bGH=boB<Q1Z
3&hrD)C"TAVX,rq!/STOg>!MMC=);S=B^lW-%:ENLKhi#iLZt;ah:sI,5gXg!CKale%Zp:!7
,\/\iV=eo"9W`NQc+6$A77Q$U1;_+bU!ldB'(^WHW\4t0>Ejl"ue'M&>NRu05JpRcKruKZ4^
qSB"!N4Rs?Zh0lt.aoFNs!FX^IOgGGaf3=_dKKpZ'b\stW9Nj'M>^T8-1>jng<>/]AkC\8git
COk*cUgmCEacMY-E0s9(>h\h$r[a4U?d;u<*1q`"oDN[\0NeDiV,pu%&2.#bA!"\6G.SX<g.
@Ce0ds]A@IM$6-+0G%s?QU$8oSdG#-p<r^/#MBk(Dg3O>\K5_m7q";QA53gJ%kAU>=YhsI@pa
,DuZ/a#T/g>1?o==IJoc)5fhM1ADg@e/Q]AgooWka]ACWJ'2>26Omqhi+Eb=4o8(UJ=UaaP#h;
$->,/br"%eoIoH^8_<]AF^pt&[l8Vo2.PI,gG;=8<Vn0@05ke0@^]Am^*b\r=IH7#+-RuH99)^
72;5HJ9P1BYMl!YD>pSRnbNBDV_f[QKTAh:tog.F%R;+7)S<-1$h\4&fC\%MV(GZVKBU(7a<
gAU7;N-cm`dG0%,^.#Z>Q6J/U,\Md6;"UDiTReD=Y`WegF/J+HJ=,Y_Ghl#_1U3JnH7TCeLm
AVJ+j^ZF^L(Jg<BI[j;Rr_;Yio)4W0i`7=g#Yh9otLdJWk>:0=>*aqqe"R]AgR"A-IrRi9YaK
s-l[HYMs2qNGah:Z"$b5sH';()U/J10p\`QYO?1*p2Q@_^Du[Mf?gM9k'BW[EYgFW26,_[<r
`-7ClHk$*^%gM0,6rMS'#2;6(AoCu.TG:$-jt?qNY=F#pUMPd3Q0:dN)=:uB]A#qd.kMI!S,"
5bSkVa.U)9sf_Q_n-Vqik)S\BS*U<^jX6<!/l"C'`dWaOo^Tnk]AUI3F2@M]A`:FCf68ULH[T=
C<;=BhWRb>+b>3>WHPTr+uGg,`6_,`jOG53$qdO=X($!X$D./7>=Kd!L0JF"1Q&3:gY\C!mK
l:&Pr.bQ19Yfho_mWfb6eEa?(7<N2XGO0Gh9ahD=2s"Uoj_irL;,8@m(qn"s#n0'EA-PYOnd
pk3Fs4/;/S>kO*'MkL-$.JX-'5qYK<pgR7LL:FDjaJ&n$JC@W\dVI[ULqREZ-?=0uL#,2%7X
tWN+kigWS]AX-kcg&:_kRG<,YZZ834>_dp'Gj[A(7@>\CAVBbY"9skg@*T3'Affi4OA4g+8))
_`\FFd4n"R:h=?d+?!Y(e%mF&nsI,5,2!@Y)2Xc=9KQq?(4pNOKb+4S"P*=S:Y)-o&^Y17,u
jrT'VJr0p5Ir)qH.b,eth+5#2fit%L'4>k,o\'R'$Ok:/.EINB'1@glC5oG"B_+%-G%ek`HF
[o:7.Oel:/Ga_pCPkY/G,J0T0%JFoRV\BhXn'oL8$/-jH5%"o3<a]Apgi2@o$"Y?gpt&c]ARE#
TGh3(M8cZZ;?^J/r@ZpAsk7;N7$F?&k%QjJgJ(;jV1PHJk6Ta46&@ckPHkZIbhhE.9kd*\*n
%R]A0!%Ns9am5e'_7?uBG+\Y)c]AhY=oi,;.$^'qiZGB$,O79cYYZW_+^.->!99(^2Y3!O@0Ae
)R[WFUIB/@m$GHcCX=e(;3O*=mQ*GCO3;66/:ecfdjM+!NGCq>m+""5T<4AG3DXjMHB(ssD(
qnfoFZpJ^2/UTRI>_nne+C9,e[t04b)q'\B>)Of*)L3mG>LY6W.H3`X+)<[s[<g`]A]A^7gb;G
'9'/$t7]Ac'+W(UK9U6QaL,k4o(0$#[UG`lIGR<^dKrkX@YSVF@"5Q`$H,4h\<"N\c@!MmG>$
h$PgYtAWMgoM0d[AohT%Om\cldUdI`:f7'\!q%H!@peR7\k-O$e^\O@X%<n;L6>oLR*)'YPQ
n._-4=[F@-h6$Z=Qs`NMKrAX5#,>3_=Z^W0=%<</m(XH4HdG6*NSsmr5+qjf9AW"Y/eAn_MM
!T_XLhucN%_=\=2pXVbF_T^m=;Pj-!Qle.l));FskTAAs]AT;g@!,]AH@]A"d:J,LaD3k9G@*ug
gYjcK6$2IEFa^B$UMb5QF6.l>8Ai<FOF;t-5(0K`YU"UM8r@1%FEbj<[o)>2^GKakc9Y\\7#
^LtjF6j'?:VqANp`6&bBW@iG.92haqmb."+k$Ff5X$)S)0Z26aP<0M%STnnSLh(;\PQCeTFQ
kDTV(O`BC-]ApTV:IpNSMM\1.>JD(#a>^_+0+rK[qn/KA6<dEFbgg$3<tE>b#o9;5S/ncF0J&
E&Q3ITA(R(U^p^?iZ(dNFpSmEkQBACX?[/N*faoA6'S:`Rgj=K;9,kkTLSFP=iMq7b$enf!e
+T\1N96R<'p\0.*F;KbniMa`"+R#emk&$TOUY*k8/s2R_@cJGTHSNWQh/5=Y.*^4OR.]AFfXB
3%l>\aR\%7%&/@-<QHOtA;>OLUqDm2&#H!WM\b(X-#ThKrqYuo.9XFAi`C<r@.ch95St$hhA
Z[J&=3M#`7--B)bHFrn7N"=OPGrjE/*#\8B$&bT`"L1*GUf2?8qp>U58%$3db[uDTKDU/:/Z
aR4n;oZbW9VK2@0.;ai+k'jr5m*T]A?I("op,q4]A"k\3?C5fL/]Ap.hfd)G+-PLO]AflQ>eG/Wf
bPTAe7J;GjH*jDVRO>&Qg^<4-R[nU89/(RY?"p8n-L?]A::ff)K<SoPnM!=r="FqB9=4R[kW&
96ZjfFWpg!I"!'h;H8@;'+TVjS_V\J$:JTHp"6ROf5)AQ?M\ROYbHpGsD@ui@3O5;`C`A%?F
%]A91Wl"PV+6GYds/D,hu)n8lHa+Jg:h[hHfICaQ[UFVdu+tUlHD8Dr-=jZ,N1V%=o0#TAPO`
Y!C@_Qr.6:O[[PdKdpUKI$_aZg*p3Km9V/@d4$o1+Q2b8Ndr7AE9"UX;2kdHigP:HD9,pIOV
+(gkHZnW3_!IIZ,U)(Rj9Qir85dg^rDVVjg71%=WB&)C4YC+c)h[Q:ECDg.TT2F\i.:C7<^+
+<,l<WIr3LJDT&W<]AYOVa^WGHoe9j36T_-;F,V<pP5UQ]AKl#,GHA-rgFO7$fgM]A]Am*+FT`QS
pO4-24?%(GFJ_dM+>3`'>=eXd*A/OWpJARW4F-uAYEmCao10tPY-hroGG$)tRDnX3,*c/@7&
+"c8#=#l_rT,*Ek`=gVb()bqPBV_OlM?W_&4>g<r2<f2Zr$aTQQX6V)(R45SmDE,spK@4`GP
a\/;W/*k[e['3jq=Ul(>8$J"YMU+W=jVEN%du4pJ!(jg,r8/"_"]A1c7'2fl6CC,gfgf(VS5A
8W>ege0rR7M7%p&G9HKfQ.5E[=!^a6,[SkFD*;ta0]APWt05\)e@<S#I@NWXdLr&;lG"]Apa(S
74Q8>#%,`P;Ra>?>iT;n8O@Y?5lKTF4ggKia4=FDJ^-JLoI+e+@?UnMAkCOIqUn/\14!2mn4
#9+l08BGBYNgF=>tiTqkmRV-COid,!Lt>.RoV"J0\jhr"%?]AKFg6cKo1UBAR\Q?uhU4VXabA
\ULREaDlpG+j&rmJEZjk:;S@oTZ]A"2b*j.8'G`0_)#,'YeADQ4qQC.K?jbL1V(OfNmG#H)*D
^>>U;,dLk<aDMB"cH7OW7c!0#Jo5Kc4\a+r<?cos'2)_jfp>`RQ_dQDBK-2h'Dl#rpDLA0SU
gT>/<NiE7lcC&lr/O7<`@@8iWYY?I2k=K*\),WOge'@pO#Gjjq6mP)\1+FW;@PS2*PZQI1Q+
p(hW8M>"?55sfmbAAKD21]A>pDqi-.lSn]A#4:HVg%X'nGGn#?pX>ES<Ao+V*6%56:a\$FIX)7
fM[W4's7_XF'QbuOSClBdS?2"Z'P6+FJ9P"s;_f/TMEms/i0"Y?<R\<VSLFOoFWu)"<Fgo`n
i]A=h#l$<&%^R&OA)>OZNAT*+,cU?^LjE5N?gXNd;FDENK;6lPpbkD@;j./2m.4=Agm59C,j[
_7pWuZVJZZpfPI4N?EI.NbDp=rcKBV/>F[FGE1k4&Gr!N<Tn,%#RJ[D%X$cS]A5#f(G$o:"^g
K%nB&0h0?:11r9JLrO<af%7"@\PAo7$EPt7,6=;1[r/Ie@iWrh,gc/@NQ,rJ+5J+?1[dAd=N
2K0OMBA*tYS.'W&nlo7E9/JWH`hh!\LpiTs&ilFQYF*=<?^^7bu]ApGAob7^FI?,]Aj/,VmJsH
"6Ob*JU>.*hiEN%;FoX-6V!5YZE]Ad3)S*'6Gn:Yk"fPuD_b,@t^5Yt_X9CK=P).J>:QMqrka
8t*9.:<m->"5fLPAW$^__pJ;#F7Ug&qR>"tMd("Om%a=L!<`T1_D\h^VZ4fp,Ok6fhU_g_dW
2k4:_Ip8fOhn?]AAnQ__E$4\[^JoW1>t*q]AA\-CL#.1-l'ctm5Dq=flY0&$bOnThfD%_:^bJD
FVd<8d#;(ih26qTN%m>?D\_QcI&5kRC&/b^bZ9WT&bIPZ3-C;6+/ph_#_m8^`h/O5RQ$`9QA
Tu>K<QcY_2E[%tY-TD'PA1OTA7Bp\B]AF`SSLV`1C&)_TA!>>ub<e6urH99.&d[bIN*?.f#D*
5,EBtf',#Z2@(P15pk;o5_IdVEMa+V!@s1!qZMp&@f%5n\gSUEU`NTK30j,@<4PiaQjf$j>t
%O`d7a]A`t;",e7g;0g/#RIudG`]AUAFij>]A[n',`khL5K"U&Jq"@oU5dRq\D3iM>`3M'Ri($^
[KnDN'5%qK$;nV0e4o;8e%0&pdV__>qQ:1*>Kdhj`<#U7+SeqPDCI[]Ae?=!d``2H>;s?UWU9
:=6,=$]A/KN\_[`FPiOPjs[,%"YHY&"MePQnERPmP4p>LCfMl6]Alr+qH0iD%#q$(!EIrYG:3]A
ujQTYUf"07"G3r+4,nIX8'9j0E"d_]AIQdH2_s3F;0,A)mNe]AIAnBlc5Sie:?cYBRic]A)AabV
B]A.rJ7^%IE;L;4GmB>NGqN2`*T<^Y3EQbC%4OJ'fW,V_SdlAj/CBD-T$X%J;RNqS@r"6a`)i
d2i\N&]A7raKnif7S"V?qs'l_]AYdf@O=A%oM>_U!dTs`YkHTMoF*M5I^br[50`L>uEQ!Y+S/]A
BbrI4R_6@3Wnd>25rc1'/FPfY%P&BouUOh,4%!7enJ0?:_!r8j!bPn\?kN9Mfr>nGYjtFt\?
NPRH-)dqZ`Z,JldcECQN`8XA/D*\geG]A>]A(NEmWh$`,oqa`Gthh?rYdHe4H>WAZ?[?\A_na+
1D/b*D^aVe2#T5UjXHYM@a!$,PqE(\-=8k7"7;Fn=HU:*?+e8T1S)K7igG;+tL]Ap?>9-AZ7"
#WTIfEVoqV&[<bFZ\q`HXA!j8&go[RMO%_2"O[R0^%e,^.4G-'d;L*\,4J:>]ArB(G\Zn%f5?
NSVBka7:3DNqR!F5@dH*f%BZY"=sMp)k44@rZlkI(R@9NCu;*NM6[Z&&kM-(O4V_X<H.g4\n
]A1:18DX@VV_@[@tbL5&5I:0;5^M),N@S_]ApO'50)sGAO9OY@,!m==I@u(M^,$G0>]AP!\Lihe
4jQ]Ah5+.fQ&LmCBcJ;UQ'bs1S's'CS&W?t9=15j*3H^oIte-oKGY/Ql]AHM%rDL%?5@k/(X.L
qePBW2#VDq,rMK@"'ABc@j?SC$R/,Lre&%RVTj[c#XZC>:`d%,1epuUn:;Pnd`3("a4?$Xiq
NZ9!]A4WQnhhOg/=<,^=VN,6G8P0/m^Bf.!+FKQi_h4@&bL`)15=51<7SU$Y$&s-@aQmg?]A?i
.>SJd&^3ecAK(BY1'k7M@C;Ep9e1Cho4PYuB8]A\oin2,&/(\'!ij]AG8i4l^P\c$aFK+l/-&^
_/?+_+m<7iNF)R2rb7g`CU,Be)rSQATO$o0<6h:ia!H\B$q?+EFFBX_[794H`i"@/eT"2'Fs
%^Rq4.TA>R+>E23:kg9^Fk#fH,_0,q\N4IZBY'T!.K-FMf9("g1&HbWe&9p2P]A??k>81./9S
C-fkO]Am"!Ps#N>WEF"bNS/@J3U?0$BG1/g&UWVeo78K+Y]A+qam1X3?`f@-8h=4h?[cm:Y;QV
'n_hDtJZ/fI8$Shup[P*p\7J[[p5)T]A`9s4j"paO)8]AMg]AZ>[7_%$PGPAK_,h&d0KGX#+&qG
PHA"CU+c-EeDPR7efgZQ7O]Ah\B.VYa2/qiZd99HlKaYB'@u?9t&["N3hkfON?*,NjGqL,4-\
gg>I7VjAKp+^0F^GkZM+HS^ng[,,0HaaFQ()qbff>:tqo[KrO6JR1nu!@eF(=XX_'K:IQUD'
XB>naLmF1Qj5Og*Ndffh6dd^UU;s5<&XE:2*B?f]A&3FN:l:,Z-'A37D>?rinuNc*Q#IP@B_#
l_Vpc^)P4rYRB^DTuo+Xe_\/#^'!BQl6BU<^L40<jL5WA"6Gg<UI9=bD?7EV%^k?!tlk9@-5
t;/#r3.B_^bl\g!Y4T#Jk%)uQ+3jc!TJo'MA[##;T4=UKD*Up%?2A=j;$TAm5J7g[*Z6?a<q
+?njtiEBg)g`lVNJ^._u9lJ.'3:p1%Bj0'D\65J>fQ%gCM%HY1rZ,G.c5T2cR/<U;O$#>^1P
\19F?Q+e-WC[LBcs4_Z>/YO+Vf*2NXH6-ea6ZQP#q<$><,S>+'n0-9(7MWd9pktQ^mZXoeg!
QZ38q@oK794@AmDIOk-F0'sGZ$rKMA,Bo+aHd)PVSS'2m\*<%1=gV8M\!=n,-!RAIe<4C>MB
So/$7O=Quq>@DIfT^[/?JfIa(-LD?nT[1S\ib9#*a'fW;mS+OEkcI.4!peB%5m]A8N^[In,sS
,$67gF]A/'M^i_oFS2E>b[ILK#S`3."4VTD?4<c#@R(e.G(`n[6"]A]A0?95D3XtSe62BlQ9^G\
O2B2T&r(dGU+"!2KF9j-nB7>XK:g7%/Nssr=0k/3DC/VicFE*(5O&;t.U;6s"[\R)E#QG&@V
fBuZ\TH8hoklR>!FB4G`]A\$mrb:7]A6rK3-g0[(8T:9<7R6.OGQ./O?^0+1@79]A3CY4*rqOif
TjQM,&^;7qX*u/@)''Dr4GRFY#Q=-kJoD/;]Ar4(TY3n>io?/-tJZMlWOnQ<)44Y>J!8S0A!.
TT*a=i.J`I(l;l;8@$i8G&$jAnbK[I7OZ7c1;!?b<j=!geG`+3QKH$ji>r@gIItJ#&ZMFB!/
hiB`YdG9agRTD?mN<kt+*K]A'K&e=VZjt/bgh]A=u&<9ZfGPZ!@>#?M(3$u$N#:8Fi_oRf*XW7
Cd,"<Ka`6uKG8iGfFN9X^WN2sP70`uLiOf("4<-?>le*FUP@qRdjhf23U-d:m)"Do"[mAnFL
@#&nS96EVE5T&U_nsd15CB-1^04[,Q@-R$nZR0mReucLE0dk*$_XuCb'M`WtJf7)CK91J"^t
RdRUJi?(XP:oC(+u[4mM,eqX+K^^7k-dFpOlZmAZ+(5%R\%kqA8!Bi,;$*Jc5knd*6]A<U[L:
PB;NMBT_c*9,Qg.qoA-B[(AMBn_<5rR[[(WPnfpK:Jto<c91b&oAPXZ'*bl^N9Fk9RkMtcZT
5fX4m82QSlO3:m[.l:$\Vuk3@h,]A'W@g&JaJIi6\/:[/0:J_iu9Nk8mS[`NEP@75-qmUG.VA
Pb+*ojANrn@U&GfS6e^l))3*[(nuiEq7>\8-MFsKQ@o%XWU&5CN?u]Al6!`^Ap_"@O@M#ncf-
$*UFtgpspr+GU91Ru&Ar*,@Y'Ab[CI\J014JU!9S4bLAC$k=iHEZHbScrN_-6P9h(;6?6>UR
<@dc&jj&j`aa`Z:B-n.a:^gkF\kTa/raY1^5b:#LI<U:+0lRBr]AKki,6M'CI&`\*Pu`dNjT0
QP=2,qHN?,$pAm[F/'<VHrb)b]ABg)Upn6JP\Sqh4tfJmQlj3l``-ffO.8k1Dc$+1=b^uSUim
P:kmM._"r\GJ_L0K`r\R7;i`/4M,X#O5m'5uY\%Tc[2o[kG#VaS@)OAU1;EgUTTt"0;b1/\t
p+bVMbH3N[P\ZQS=2#u#&<",]A;62oO5`O$O$Q0Z>WFt*(b1H*s_l"[i*MnSDV[^'"gKGYBdt
'QOZF,+R2A\@[O_uT]AecEdA4b`6>L)g,cY"an_/^15[P-'!aF(h*A9hQU)=4%fMcTf[@mS;X
uQ,AfAdnsdTZA?'SPS?5/3SC7D&?#Er+nr$>5#TI\V?1^'Zn^9sr39I?P[:I3'<FU7,T.$P)
![oQWk+4\h1"TI:J>>Db2+O^5(IM.pX.rUQ,k<3=^<qEEK&0d@Yd3"9cg]AaHc06<[#R\#g*S
,+ILDk3ki1XVX?(g3)P*UAK'AAmBsej+/@)DYCF&:";L.=h`T"LhT\X;0"b^YtBL(hi`i:a'
CG:pF>rcD'cWb+/2s*HR%]A3Dr)JHaOcn.llP#58Pa(sIZ1$?-^4jD0jij5FH6.e59@#U%k%*
+p4`t$uHF<@OL-tAl$8;KR9Y/s!/gTMtT)2.TQW!;cB7=1#7,s$7C>V[<lAa;/m`25@0Y<sW
"QdR3Wn4Dbb;U^6MKZ1)Ml!2=:r<b?T#N?S_7uR0]AM0f,cHbI5S-.hj(PD+(-*m[u#hMQFCJ
QqkB-5l#-D,)OGi^0m$79nCRm[gA)!\YCT$(b_>rFsiM,Urg>NF1"6_"I#s<@=k^1tf:tT>p
;%[qLZ0QQ5AIgGSFHIm')iQS*MA4[C`2b7)#1+VN'e(B9qs%6qC;UVMgI:+l+>UPbm`CYP9&
f(.DCH(4&>kZ'C(PV!ZQ&g[6nUa!&b8%9F?lT`a>gI`@#;`3)2?="nSg^iF)np\?*[2Si<b9
6&3C#*ngKiX7REAgaS/D5aO#*N[5%Zrcood&,*<c=+9X@rOBAPp?6N(njdKn@#(TO5\\6m'c
mEP,V*b!g[>eb01q7eh<Jj4ebNcM2+h#G^<5X<I0oJf3_!U20d\NA/eX^/6lW#efH>n54TM@
UN/+6<JmdJA%ab/U,LS6/K308b`FFH:9*fq&HYIKQ>Ol/</@Q+?i7/Vu8b5A%Ne^/sBGO%i)
jbP.JrZ0.q]A.Yg=FdK?oh>/,i8tH-H:u1Do"AS-1LQiclrN[q=5tf6Nn@\eg\HcVg-#H"1<;
Cf05VJcfRs@6`_trP7QsCi<Fua'hNg>1f9^U5Muc./qP(g><SJaZu'M1(7>mKJY/u$pi\5h'
+]AR$QflJfpH_aQ%_SKUf+]Aer8cVL":]AI`h'mBZ_W(N;MT=d7%j[=a.)1m7iMC:qY%e43D[,0
Zb^L0>T$_-k;-ZkfEYRYT0AN6X_^o5o'U+rc"4*.?1kgmC!_(th>,+cs18#hYnhsgY8]AuuTa
a"l+RXDV2ie>aO8gt,HBreEi"pBXU.oIj=22jTh=EWD@po)XG>aAPX]A`D"Ud$LRK]AN@38DPD
`7#Z+#Uk:i1SIdRu_LPDh*/^p)S>/&<AA`_b0g*[mPSRd#<Vfih%I&Tp\,h?\-T4MG6C@u]A@
TCMCQR1tI+`)M"]A\u]AiJptguA=83F#MF/A>HLqblCWE"ZN5.Eu3>VL+LHEf"%D@*u(JhnI:`
HO#[/R>QkOiQ&l>(\H-#STA?Ft7FMK!;n:?A9_CX5adZ1fs>0.(?8B\`OVG\kX4:u$)YcaQk
MaTF[2JpD_0OG%?NXPN&6$t$+CTrTmlja9>qQp<ZnH(':gRfb*0bG[A\c?2Ff;%It;".V]Api
JW9.4=o<B!j2G!,hgQAm(YgU'7a8&+_56'bN).*>jYJ\[h]AfKD]AX^BmGObn*%JmuI8^et#h'
t,Vm.M//*7Jb6BJfH_c]ApaUFd![s(T;n]A'UR%E9V]A]A87!p]A2-o_Mn+]A80-NDp!VfW3L]Ar;H[
Cp>FR`k58TM/@8)Z]AS)W]AM?;?:nd^t^bfZgAt%10MYqL-]A`&`W0q!q&Lj-H26up%HNd8BtM=
!8g,H58^ZT7V6<4g:]A/uL/,\<;QE"g+8u54SEnOb!-(*uQ_Wh.@1IODuGhQhWG]A2en]AuC6'5
Z5L4R.7/o8dB?@N[>dN>9gQr6-bM$cD@sPu<o<+%8`q&0smf?"=S)tKd^7W"KEH0kJT9sGn5
>P_Q/'!RAeVcj_:7cu='T2K7=9DaprkhE!RS4tZM/OMWRu4"jrduN`T#=XRZe6[J7>3M-o+(
YYgjtJ@CR7tq)#@WQe/l3:dVbU"W4DrG:AXh%4ZNki]A\O-Ecp"<Vgog6Y*CmVA#A0C/,1Z>R
Nf7@tf'/<&`Hn205^-hN-+[0Po;8i8qbkJL^S@RLPJXt:^1FCVn-d/4#9dm'O2=)rafV+k0=
:4p:Q&75q-g=2hTtf\&_Y"UmuUnfH`Khc=mt%)%j#H_[ljjZB@X]AZ]A4oi]A,m'Ap7/C]Asq>J&
Y<<NlbS48q0A$V@>Qkkl[0T=k/a6;t_X:EZa6c3T#34GS"\t_*m>/=%Mc`'ZJSg9+^Fd"#\.
aUFBc%+E%3'Ua3A%UCabAOgJld(3lY)1X7DHtEqlN?e*MX82.o.&<>K@5q+kYX9:)?=BBcR#
ga,>VWgc>jCEg\A^40n0"3#k:I'MOcBB_OlSi[qM,W&Ql7q<lH1MZg(\r*`dqD'-!e.Eambs
\\JC3DLMgcUKg)hB;iOmBN_q9Q*5Y;?,u_d=m,]A9en^#4=[<0?LuH9W;Ydb'+pXqM47E&L+Y
K.67epGGpDIdmX>X]A??A=h!/.Re@f:S>>iPfb_@)]A'aj7Od"gFTl&bp<#=rr:Dq>LAS:R_0i
+Ot_l7WJdtFI.=9D'AX"j*[r\Ae<+COHk<4+83g9*e=+96guk%$G`7uZJ%+_@M4'F2-[JOq"
F7b+4CmgtBe7/9jF\oN6<CtK'B`n!,/r1[[lD,"pN]A*p]AP[I=^Tn^KjMD7BctKQX6N>a&P'O
K"d&PS^D"l&FIVMLY?TrpURe7]A<X1Q:fFKpAoG(i4%[RTR"T0EFaC)pW7Ro4pf%RM?rSsi)H
c(jd\nsJ6%KUn#_6F4^`QQp$apa#]A`Sb=id3AoS.n[N#)O27><a)it;2gQLZj!)"?)uKoB[L
>OQDcPe#0>!ZEq!fL,pou61VD@E_`eQ\KZH'HT2pcdtjQ?Os1%RXGEIG?TMF&ob#).-GHZ!S
?\TR5!YSB-]ASW?9Po;JW1PsF._JiYEkOF:WHTMu*AMD<C-0a[B/L$p>%Y:;U5:9;p%D<(O88
IZp/ISY2X(rAI!X:9C@I\$+\q.D]A6]AY*u\4!W!Kj!)b_=1$C_";V7Q_.WakC2F&)12;BTPBB
J4/sgQ`(,GlZ]A:+3(GW`YA@tgci&KK5Z.X$N)pSrWSrYi\c"8N^dNFPRVijB\@nH/<1mk2B(
Y!2VFmu]AR/EU[TWKlKM2cTQ0QJuYN#l@N"5g+0_sW[#%uVCp>)P,]A$<GO=_tE^X?4UUEujg1
NWAWp,?ZNUGrf#l@n:f4.9,h6oV]A@]AD)S^Gs;5DZV:;_&;0.^P"11&%\![?[\=(L56c/6T.#
tc56SDhl4cfWm,V[(!,O/F8#B-91NcU!>=^dGe#iqRA%C`-0VAdH2W2Bf.'qh9<jJ+-YF8jU
G*Ql%`!]AND*;_a"07ZY_Uf1Ci=MkOG9COLoF?ha.>$HV_41Zn]A-ATU^B<"qWe0Ze?8\]AGe!"
r8f!bBW9+8IWWOUKeeDP4Y9GEliI")&&*<@Je^jVj@ir=]A+Pbt1cG6'Su\KPFVR4+Y<MZWnQ
bQT6N42&7l"X+.)/75toM^<4E\Mh&UlMa8n%5#]Al<t0#q*B2^'^p@HiIG0#`.9GosV)QA#c%
M,,fi>M8L@*o\X1nQhpr>!ll(/Y@=Rkk<d9lH=.kWUI>pe^/E)Rnia[Wp<9WAEue]AGIYD?U#
6Sq"W*:\`D?nkSl$<_0F"!jJ0sk^+eW7'/t4F3iLT5ISGnXXLH+IeA*@Z\@o;>rCD>=*j`J@
G+/c&&S'UKPITo9)I8,KAP!f5M^'BQM0V^l?M!LRe1P7Nu\S4]A[=?0j7KoloV,S8m'-]Ai+6d
1p6#]A:M$[*:MTCVlC4K"+CI9N]Al-sAlTdoMUrE-nX:>0QoD;iRfY&uU.*`=hm2!.n4I<2gKN
6uS;BI@l(]A&DkD,pl.Tp%t_F`'`RII#LbK_2grtm78q=(4YkpT\hj/>Lr3$V4?6!F*@Xi0Ba
J]AVAK]A3irT"7r+5b(#UFM>[c?d`7qtdmLgI:EP)?9dj^Z!*&X_Y"#Nc#>^\qr?_/8m=PMV]AR
XIFqc689l(;EMt%Ze%s<5Im?F"?+B/S4mAA]AN,N.!8_am;F.N><nX?,tbnQbH<0c7]A/(%p-K
'Rmo)L_)YkGDO7P1\g8eN!"GOH(YVP`oA2O5,*ZN=K;[##Xde!]AH!O&Aqh$NK=ZKmK(k6T1[
/g#34;[dZIk"CZBeiM_;!gp$:5!]AICR`kUh5KI:Ff1U.<c_G4M\i]A_8"chN\p?:7@i^pKC^^
i@;/075B#JrmpV"3u-Z=jDs%<RM9c<pY2QQ$ZmblWbFUR&kDlj*+(1-L&Vq:Y;u,B"Z\Y>Ao
DRlANoKE8f<f/kGF=jTc).g[ZTf-4Vn[]A:\"(_hae-h_[ja@eR6Qj*s35]AqI->$2a:*bWKs9
a^&/K3(nT#7I@10]AH#.RH<(nt`L[G"=--!dG6X\A;<u'A`!4Pru=g6:to0"h"hjD_BUf/>(P
OH;E8s/C.&h[098#983`X%:IbBurDI,EThW\4<bBr(fGqARJ+17M'HN]AdpPNNQG`PNU!+)B<
HN=G[4&>f[+7c<\Zt\qb*^+aq\l$[Qq5NWXt+`lZ5]A!1ISS)BTlG5%YN_7JYPlK?4a.*IWRt
CG=+J]A$(R7E^k..eREjf%=#gpmH*_NZrbg&;KjP*WYYY#<NqrSlabm,H8lDcIqKAH7U.R'#H
io*Hpb8X/Z`,$%+F"TJ'n\gJQ4i.QDp0_r_<)>(7)[e41R-a%9lSjh"T\PG]A=#;n8&*T9f?g
u#hh18i_uOAXL;i0.FLA.XZ2!+$oD%A_U!8lMSNLYf7-:nabNGc^ns"t;Up1XW4<16f5.R1n
Uh*$KJ(4<O,EO%RkeB-h&&KP>k'a0g<\DJ8&A[>_bn'fKCMQ"e-@"&ai)Xem_kD$>IKL,2ir
:rP;e#n2u;^h[]AI;(dUP\K@/<4jpOi(WSHntLaNob'B!K.,Qb-#MjMWDlfgMh`N2a+iLYjPK
W:W:"hkIV(`QTshBnqLD4NRhPGA4D'\RWq<hR=TprcjtiBd51a7%U>R7H,?t:b;"rCnkA(ZM
HK:^5G:P2U]AMeVQm)R[Bo]A,G1XYC,t%\8qBu+SRM7>*hblG`d_6<C1J##Pn2*%`BrM#L\q%'
H=C/`IG6:.P%ajpO0W6t:^IK[dpN2(nMCJFBY,G;s[<!Mi&=,3]AZ0P-!\OZuZ70H=klZpMaj
J`<lT8r7a;ge%^NSj&rED2'EN-,0OVQ5^!*$;_(m>Aoe>:Sl>*Ddu:eId;<5AHg49aLmOVK)
U1'u?363Q14,j&12%qCucaeM)FWAF:E9]A:ku!^.0IWV?jNN@+'/T+ZN>"YACg.;7NeuMc'Na
q,0Zqhoq=m;`\+&lL8U)K@#_4nQ4TBFlr*[17SH.js/8'8_%1L-goK@JS32<ffp,*`S>1DR"
eRE&M,L=9X^YE91]APBJo.>@m[O1n69Bc@F[:,B:b*r(Z2L53[8_"/UJ80hUS;*E=#WRfPbnT
5[aF0_b0o7$OYn\UTk3rk&,E1=acoalP$;c#6e>P)ci5.d!.:c&_d/^Xqb7=cHhnHd.uq-WB
L$j03)nW"0AR!$K1u6RP@/['^d+)(Q8Jn'>s:!%$1"lCfK(ocfsY<?"+@4]A7Jb7')q/g1pt5
FM]AD+SS&($!&5O3I86/nbQ>f'p7?lYP0;Ahl,\_<E?hKP'njct8Ur=>IUDsP:c:YcB.aWL/`
n,;ZAQ(A-a&t:3M_28RCj#t<Pfm6em7jT01&\qc\,o-a`-K'0%16gjXD1.f.ZA\VrIQPIuY#
ioF^UgGO(Nk>Z^Gk;q%eX_FXrZITjQI2qSm'`,q0Uu6p?)R,XGAEsdD>6s&,=74fFPPlH*b@
8e\+I(-:!toj1CH#B-UlEBihe*5B#k!<fJ;jXYdSE*#B!]AJRd;i&g2&M*lg_/1*t3dDr/95a
U)['W=Y+P62*4p]Ac=\2a1>sAq-9@CNEUHLYc@LF/T-PR+rtkDe\XM1h*I"*<@@?8`!op._.D
/:E#rRCP=ABNSs+4oK"*:nne'D&>M$46d'<V!*QaSms*_,mgr7j7_bj!f#(QKTg&dt\:$W/f
T-^d+O!TpJKAA@)nXI,eBcA]AX6tftYY-ergK1d,\09F7U]A_Ri(kK+>#rjK(15FcEY<pT]A-Mp
!<ee:8eMXK*[)q2Bj-=)CkpcEf%2rh/g9?fdK9[LDN731H_\72Rr`iF`@`i01Ydji==B;p]A?
tm:b5EerPfM-Ft;iIGQ0cA^501aLE.@]A^tcZ6aBI[_R5)u+cCL]A"aQ.jS,Q9)g%=O9YptQt-
i>/RZ;pCiE+tfMFW/R_S2Qe/oqYWnGq[EgUo^R`B+f)YZSfuT-N&A*C_TCp(C\"YJG8*r&-K
,bO!s\geUP2GrpP@"#C,ahonN@&bbpRn8*<3YgPuNVQ%B9bN`ojR?[6>%d*[@^ebR+-]A5X3m
-]AM6>V+`T#Ggr4r7A.o'q$*QDX/"lXIbL#olOEX&qef1[IFK,$d+=1PdCD8TX?Y&6<*B%/]AY
\`%:gtM"cpg"jSpCKQmW&YQktQ`=4S)rb[PI4M&pg9CKn9+=7GF;1Z<h-C3D_%Z@)$?3>NM!
m7^-'3=T`^+]A,Q;</9blIL26b.:7Dn@`1he3)tT!:(\SioEQSK(m/AcA9GOBiCVZ!+>>;gsJ
+=:In>gonD`L4%XLQXh2^`/f'>%9RZPc$AFV%fr#e(cYi)Tif4/jMm\]A=j?W6u)H<9QWMT_V
9Q2EWn[[<<_LW^YC@>RrNuKbFsBbB]A>N$_u,1T7^.1GnNno'<*9&"T&^(9.p>UWd0>oN%H&N
rlYT(%SChd3)P@i-P0jkN"`O&*B0tI0=ZfNG/Qi?Vo?JM'ho!Mci1?0Js3/D0[YLqJF**(Q5
0smEoFcmeYh,"OIHQRKURi;3iWS,HP84F)2=UK_?7e:^d&._g"Y5SKXQm3HUXgn,#D.rf(l[
r1m8k-*htq08&,t0)a8J'cFrkaE/HjgQ=Bn^Fm(EFHd7+Hiof1]A?B!/-hRW#Z9aC)hM%O)]AH
na!'qm=4C&nVW3Z43CIES*W;SD*+d>*^Srah4hWRpXV[>G(I$m"f0=c[lq5%mg);V/8cX-4^
I&s,YV4^kV+a8+ag$M$ZWZZ+&[riJ6pmnbQ6]AW30F7?-uGu<cAfQh8I`EE2t0u8Uu@Fk:UR]A
/K2cRhEK[fn>lsr:%-GeQ6[a9V"sXq_:dX`Wh9>sUTcG%Cu-+j-s<'i(:ekV%jIAhp>l?1)`
K2Zi'Jl.V/Hf:0,WAd=8cD*5/1mq><5oV_p2aAr1<r`lsH2$r"C[+H_,3K^2Ru)?+/Tq[]AZX
OjJdD3\sDj5[srI3r\Mu2$<*S7A`4hC\:cM>NXS;MH:k*&J/1#r'PhY\9"u%NO3M]AQZ3YjK3
*?e6i9gVt?QI"-5<P\Jd*Fus,kj2>9h??M<;Z.A^1\7$\52fQi!<0@hLUT!FG;NMRL'[6r8G
3GA\*rGKr$bk0rkh`T/h3iUs1a8X10n<XiRtX'2iA3#V3K.N2GX=%\,b<2]As#[7'j(pfAAn8
c"G%ci>h41dkM6cns8/`k@[ZO:1P3V9P,YRQqU\hbetL5(CsU,p`8?bCnK(NW)"GZPb+jc5H
7eXf/lTI^)_EC'<#5MTASFu>0Z:hl1IP@jRlqZ1Wll5:^ItV'M*jboF<5<"<3>iC*[=q#;bi
O(V<Nk_!eL>a4!ifde]Ag-]A7CeC>/28KG:"q-imIJKlh0VB?hain\Jh<J5T>+6jQit^F:S\#=
1h!^=!,3'=n:if]A29-KaFa$mIIE20J1J8pAJ5&tA!>JuF3kGB@uQR_I<."!@`fjL2dCW0Eo)
2*(\-]AWMS[!5gCps(>ailjRK.tmPOL3G2UsXp"TPe:BO/D:l>5Ab5lH6'T7FI(oL<pUF.79u
:C0c2DfsQ4/WWMq&;aCREM9c<DhJNQejW$g@HU0`793uFEn84BVB<!84Sc/Yh"rEYq?pe5S!
,AXZ>kimaKNm=]A4nE)3I]A,cejPKN"p.o=]AQ[5W0+<"BBIdrC+9]AHSCI<k-Rl=XoR$M\Uf8%j
W7r?eV*%0('F*"QA)I?tHXXpa]A4WV$61nY>l6-auoR<'Db#,R1q6K>39^F"'qYF2^N,af&iM
/FiPNPJejGme>X0]A8*^V_5nu+(gp7V[_@BO9tCQj88\c$\6Y7msFPbHI09<'q-e%:c(2GeZR
-9o6q!L)?_0Q0\+</!&Op'dpb0A"s?:i[nB/OjDXY<3A:sHh2!KH1mQ_NOin(S@1L%;=om_q
RSf+F3YG1$aMR`W'*?BjeeZe!g5K!:3Yr"saq'MKMTdo(:aUP)LP)<SNeWhR\b*#j]AA!Kp'3
bH93E%T7?0_pFS@#DQm>YQWn@l.7ogN51q_.+9)qXi[rrZqCZSU,feXJ&c+(0:cK,jS@h&p`
32#+H[YQ(adJ"rCCe6G'6puB0u_T%Gg1&[s++QF,qSaFdVbl,d(HMA7^Q/N#NO>cKf/(V[Pd
#A[-R#10YUW1]A/E^<j<(O^Q!_2IFcb)5HfZ<.K)#B&kj2sfmiI(Zn\e]A@#/\2:H+[>#a78^L
1^MPi>9JpSL7^HLH!&$k9Q/l;k!aA*_m#A<+"N.r'mX5?99O8=n5MT#<Y58XK,nacb+$9)rh
orXqNiU8#.Q;Nt!\V#d?U55_45IV)(XWqlUOe2lgm&QS_n0rak#QNHaBZ/Y'5KZp?U<&%nf"
PF21brp%-`+,5=p/sRR28=OB7dB?K@Zid:U8,%6F(62b@K&0;+e.]A4!%qBg9bpGT"@+*-g7=
<q*5uucL0'6Bq@mkoY75prYQXFHu/TCWU9S1,HDHjF\'tZf0]A]AGjuUTA!)G=M(rdu]A@dO,ad
kf"p;Bg`h-%AG2&N&ZV?9b4#*WP#U0@u'%pBNQXEN6p<Z8UESgUh3PLFAUA=6"0hlh^3U/^u
V@^M7H^#,oGOgZ5R+cSh0J>^AVk4IAN"'$YnXHugAm6I;GsM!AsLB/oJ#C3.1<_tbrM`Vq7D
)g2/Y%-LM$.Bb1mWgIaBEJI(tSA:5"28:8T+MnF[I?#+thFe+sCW`-5MdDAB9!8VH>`#Ai>1
NdM>Pqo5]A3nJK.iO^HIiRdWQO9+4XW1aZmN-n(Bu<4`(fYSf/b`H]AUB(5_2hDH8F&`0-c*>s
WIY1QiQpq>CYT:tVqjrd0gToeaNFEu;"NVuJ`741amq:1<\NdLrD2%23q1Z_dW@p@tbBsTTk
Sg$S?$9it5m'at4*S#h6KRRS<;P%e+?**d`^6!F;.HK>-3LuLkBIS\i?\UiVSu)(f/Zk!0?D
V>pge9lWHbDF)brW70JfBq<`dWfp82c16_M7CHi(Q.5c\)"*_W-)75Bk8m9'BNXoFE.f`WY=
af)rD<93ORC.SdTL?JNW3oMInfdiY42LhUV,kR8J-RDh+3%P&;AVi\B>\+<rH>Z(L/LlKfLV
8W9<5j'AkaF@,"e9ZG6Zrr*ba'YO(h7j!KQ-%Z!BlH+WO$=aEOs!k:QN,mo6f*(([0grQYUd
5]ASs-lr10p!<UcT>hHtuI:c]A+r;Ab4[e1L\1Q(@qOE)qlbZh8m/n59K:XU)=bGB.4qj??:'&
[Uf",r&P$;e*&NA)\V,PH'u/As1GIAb2Xd/Q:M/]AVnKt&CE"5hIsl8iOo)/hZKKX#+gT?s2:
d[k5Sn>qr&JqJMjN+[eb-*8$uN)eqS.n38c%D2`o&=>9mZl`Qa0^!ibV.mLe1nnbP.&"I_]Al
nL)^dQqTG*)Z>0?+De<aldgYC;U`.C%Q/k9g7(SughJWEk[MrUl`%I;C=*=c\<q&5PG4V>=O
'OAqI-;Oc+D6<X/GuW&>Ht(9!'p_M,6KO)".Fs$ruF)6s;5=R*tk=VVaJ,dV=M:abKOn^f/3
VAWoph=N<ToJr"Io%7)U%%=os4cr`h#^XHb]AVU]AORHQa!J:qKPDS_cTdr?083HEl+pf3g<3E
N;+DAGPXQ@T!4*OL@YV/K,HDpA"WeIEQJ+ld@lb_l[!ek(a&5U/c8+Bg9W@AY'NN7,kfDm5/
jt>%2)t[\5S`Rau2YOD+&*r!VXXHJ6EU#oZ8QYj'9;E]APBD#(I[8OSq2QT07DD"Jub,bKVc<
:mT9&DYeDu1mn"2IQM/XK$#"2qop\%-E76DopiG(n"OV1cG(EJj&_&?jh#eno$ICQ21k_gT7
`JlZX9<f5M)f>"p0$H`_kjol0p3JX8DZQkXT1^C(]ARQJOCE#cB"!_b,]A,H9uL3F>sVQPipg.
6Ca>]ACa$J/6qli\5[4$Oi<fgk1RUKO!*64H>$1&qpG%=6Kf51Kt-<R6:V]A'=)V/LhkZI'gl]A
jEA69=Z(OBI$,r(0LX5-/k(T,^4cS+?;!T<#1GtVI?SZ(N0f<aFlb>g-KW0p`bDC[Q[:tllc
&pR:`O*`'pr?pnQL($?Q@QB+A<"We/K3LjkFbHor.;+.f*\\e6Y-"pK(6/]At.k:@Z/IT,<b*
CQHc_.B_rr2Y?Ctc(>Q8%`ZQ%dBP-'Mm<!/(okN83lGWe[YR,Lb`G'7niHXYV,YUAhW)B'Qo
`;+FYZ3PUbm5V\(#oa\F-[2FZs?&hbNU.<<05`kDt>8HlS;LHR&oM7a9A)d8TqHQbMrC4d;2
.R>GMH?*O*+Ni&Wc__t?l1&TaUhC/$M^S,/Bb-p\Xi%'_4+-u75"jUKF]AFOZN8Z.cYJI9pB#
*5b8Kl-^/Zatl"?6;O-jDc?/k+-`IbM_`UCr<A1KDP7,\&'b/<U8PJAq"F5-NabVI0g9VJtO
5:Y+aS1W;,t+N0!g67)E9<'.8k#Ko*c4#7ei,a-SM/2$YHK"uOj)a4#>dgjE:p.ZV<GO3?!!
IC,ikHY<oPPE>'%^2Z1dnor?VjdHr'-/$#:b2ki+\g4Yse"U$MA*9)ChjDC?Kl6YAY1O[#Nd
UR$mA67e4MZ(eB"qReJLrXOA<\Y$[*tj%m+X5Hp[0)EbqiW_B\O"BfA'7'4qO[9JQC,/Yu@a
)g)CGW':)Ni5QlJB.k9gnVj2jP5JA,E86d=;I<)Ff9D,ho5coDfdEVbmWO7J%0Q`b]AbGsRL3
uSAcCFMBEnrB'O:ZJ=!B-93>pbreZ:=G3Y8A[-<gI)Gn,1IY%i2(3\7FWR$"Q#7+G^b%]AR9^
+6\^#'^&A(jtI0!59+&aIM8jpeG3BNpieN6un.6b'hl0=F)]A(9]A0-%rV+J>6I?_tK(!.@4kC
F%*91-e7$,IXc`_fm=Zd;S(/&PA@G3i/s9EY,?_hD1j4L;RD>,`Aq2DlH*7g1MF666>T_^';
Yg)_&*2*"=4,X)@5,*GXj!#'=?PsCn2CNa8':bn`%(t,!!L\.W?]A$$=n',f^/GSKm1I&R7!\
S0fduhNVj%!lD?q;&DVbqs7bcVX=Dr;79>EK$^-:F>fH7,cf"V2G=6b=*@dt`IQ"b@EVB>oO
ISrkUh0D[:OP`';eF\k?@r!AHh*LT$RC'G]Aq@+!Tt4dl\di@V9!PbhKeqP6<*E>f9:6nZaIV
2i?/S/oV'nHC9_uC5>b*iNBWS&mU!["sC,s-"(W<:oINL&MLcE*GAprF4Q#lNJOMST8Mt%ba
0CN9U(X_4WkjV(-o\J*6s#l#4N>+`sYeP+K-2HdfW)NBPfAPpX2tXc=en%qP=C(d[4Ln8Ged
Fprpm:FN.]A4Kba:6Ua@^tupApLW&f^HUH?G_[='VjQKmk0_XA95J0ma(DEDE8@7#M%`[Xs(d
ArPdn%NCM""EsCP?&L'p0P&sc&.?rXYll+J@Y(+sq+?VAeCD.T*Do%@V;2`hq-TYa^Xl)iJR
b!?Ro.&,6a?.PM+Yp0Id,OdrV^_/F;&2>AN88t.lgKD18pT2^WsO*MOE7&+<mq?:L>iMr,po
[f_,s%ee,-*tgM,J![Hmhbr\U_aKG::OJT]AJV#J$P)Qb7puX:U!sI,Y\0#hH]AXB'"N0,Ao&S
gk'Z^2UJk,E770k?IS"L63n;3j?e^6@//Tu&f+G""fE_+Ab)pqRpeHmD=?Mnb<;G=k`uIoh)
CiBj]A?3s,sb\'H[:&C4&Ti;BKLL/S`Y?\/L9@d,)-$m?%Cc9j@dLXYTJ>_"aQ7TZ!ub1Ba=X
A6UYl]A?%NUs^Is(V'752Lm6.;gHc5+]A$&>?cR,B1spVhF.`.h9idBCcjH!^->4J'K/l($QaP
NT%q[A1hD;?IH'8UI531hs)EVhc22c#Roi]APX6q9D4/nB#-r1UDI^%4A^Rhl2SaY7/ArgHL$
i]A4U]APp>5lUb-AG7N.c\+RI&+)RR;7`8VRXEt'lE?:(g56k1X:I5\4eXsP2*sE6,$Ij9c=-D
!&QJL#li8YWkh\DSK3KA1Kp=t!Aq>!`XR=.JD:)VcI#7hT!F2@3-T$]APpCadlJ-#EED)e'Ig
n\`RUUOilF-9T9,ui[0frMP2k-;\9#5*!1:MX2gg>'dee&o8C0MO/"`+'/1)Z-@Qc8ebj6`E
]A@pKaDOqm"?XXG6O)J_3+6@/!2nS?J\&\W]A7)B=aLX?V>]A`)WY?9r%r=KLgM(HbFpSJar99!
2Kj)\R8ZJ_JFEISbFZTcI)B(m2Y?:YiXkMZ)LsAm8u?GUVg#lCrR^YPhMQ?4Dt>am6oj\h`6
`2o@7$&ld/b?G5cQoq+G!cXJYV`p-t%Rb=IBh&%rJi)]AApqq*7t!*?HD/B.(2W@8>0.<10<U
KWUIf5W-2q_pYlC]AklZ@/U\nnopYnER`N/7g#BUM\GB"`^If^?62SqE>q1#f9td\KCIcYUNl
NS6$VKgV0Z!A!V:]Am0O-RTPO=uVl15@)Z4O9OkP:V-a.O/R=a934'HrC@[0;]AjN2<X]ArVdIZ
s[)!^$nuS->od]A`k59(dA=aa7ZW!c'*nfWN^r'lG8idk3Hm0"pEQ7cfYI@<X%Ojl/;gh[A?i
tBH:i8&IZT@:!1]AST8i,7>S\FU)btetGUUC(jha76;q,N=J[@1-q`YSG'Zn[mCN(-X?RD>OO
tqlBcEtZm8MF9bXJ8ZqI3I1qW8U-9#G)PNoJY[)lK@1m."H`d'u;PJ-mI-ACu,;0WdQD)G)!
Y1,;#j80k_SM=V&/MLD&nsnSZ)ufS9Cj0cRMD<6iK:j^IW42org66Z&-V!pq0-QupMVMmEQM
!P@\<N/7a4hMJjMt&AC@Q*!M2ekqU:5Uh7qug^euPC4eS4)R.4D\SElFU!"),QVV(gm*&96g
leNX:lc6:0U,0+30`'s)jHjfT<1Q`$seB;N2+",hrIruQQSHM6;1u0uo:Na<FKaG4_MiQ)K)
9:$ppO;H:i[B#m8<<i_CKm8_SLbY0:D#mb'#&7!`9Rr/BG`,b%dTpI\EW,MQQDm^r;'ZVWLV
@b+G:!\!i@t;/Z?c:lZ/.1RuoHPs$.e"o*^:orXO3^X+ltdhW@Q%.$3SRn]A%a=LqCt+Zf@im
4h:4rMqV!1pskVY<XeQ<&\u!t14K7h+-ZLA)_h@7R'b<n97e6'ZjA!&+:a\$s7XnWiH8Zs#X
SG@SO!%p`E]A<a5A,[el?`5q4%#=8Y$$=;,c,*3=Z:Ueo"\i9VpbsiLC9#Pnpgg4>@Ya]A1?PA
e[J&C9_U1`]ADTI2N9+\Y]A8CZ[3-okTG`ej)W*bBXM;t$RZ+6ZJpAeR3]A@SSoM:UC(%rc91<a
4BRAr"QbmnF"`@oLI+%>%$QK1Bq]AZOBq6->sDb9G`^fb-$C*\f`NKp?QNNg#ARn:akC@+')1
"!]A/^]AV9AE;W_n-%3\fiF@0c=cq5rO8PaZ`V"dLKP+4i$n&oHQ$4\5UtI3)a,i\2&`IogJCB
Re^L&::LI_I<"g;.Oc:X$gmH9)bW&JUeTtPORHaGH"fnICe`DJ<\8_&blX.`RCb2KmY4Kd.p
6LflA!Pr7@H(540hr.Ci&D+UdW,uKMQ3_d']A/"HFminPW<c8d2`'#+[JG?or<V@'pE$=@%m2
R7`'o.h9:!\5,RhuMn5Kd$X9k_jN1j0X!Y/%r'(ui?TjTTB$QqA2?s,ah<2Ys/,/Hn9&9"fJ
^d4HLsKVpo;V\,8q?($1%edGL&X*YQ;\.;!$]AT\batIG7B<0UX@;tXaSYN(08VP@h=\8<.%q
YpLgC6m7umY3IGGh'(oHtcT5$$!-Hi]AA,h+(Ac9Cq2QtLb)X:C\LP(M(bmQ@K$QSs53o7W&-
,%j_,mUGKG4BYl[=<A'Y]AT)^%Wtgm]A+2$Xt5hd.M#$irr`ZMX4eBP'kn>cLBB^RNY5`pA1V.
:9.2h%F98g44i\8J^.Agj[/E7Du90`O\CMR$DW.5-d@W5r+U8Zk)H>966r@25tAa;l3Q&F:q
0mf69%epmc_1(29=,tNWg/^IV30of5^+K8GsXUQD"IKVLIVWoh-T3i@OHVmMt3NP;MA30?*c
\oM$9LddTGYQttEOInQ]A-O&hG!TLX?qp2\;M,'?QqSAY%)!BH$4eud*2SF)NbEH"/+H4$WMH
Dq""-o"ftlIdfuKFt,`q'%nk.cHb<g@RL")?ehr]A(`:ft*KW]A<9d98pIA(;]AX`rA%E&%@:3]A
.\Ic&E<.3"_<TO1CrU#0K/W#GO%m"6]Ah#g#I7RSsd%JtZ9`*^DoD.p$Vt/bu<*hK6>JK`t!@
$5b**Zk5o&#Se8c6NZ&5^R&bmeY*O47d%eEdbRI=/s%[f*'`'"#2=L\h[p\Qb1/=Y'[f5?nN
<3N`dqXK0Le\>3s-Gs\^f117'-@lK.gkB\S8e89f"0Y@)Y22/5S6/,Y/71U*^9-3tuMRW=Vd
l]A_]AaFkh-nA\V(C\Yo4>c,&Y!-:n-;^*,mEtHscl/PYuq;c%X650pm2%A.C-ORl"LDt:$5"E
uJasSjI_;Rq=7,J*h+#=meod2LcWV**E*+&RXW&_H>n\V6B87)3jPQ7$7fK^jLR2]AOo!=,kQ
HIn9-Vi!$5rI/[8j2tUJ1qh2<_R1EYG6c3LT@OF68`04YC"OAhS(e?4GM&::(G%,9P6#/LNi
IHRbNq82p@@pf!tASY<*+21Y+d7__Y`&5PrkaE,N$0s9_o[KPWBa)'+-GdL1?!cpkP&5^V2h
@Q)gG;Im:@4jKMsOeTZWh_pjGZj,3SE47@DlctGP[=]A%k$0(4buMb<p!n"g8V>VgdFs.E4g[
[&ZS5.hL`O982janADQWW"rm1%$?a_>cT:s(N2aGS0tK?[WWQMNFbt%Ql5r5W(^',<b]Aq0r_
`ZSlu[6[I"5V\d\MZ9V]A47\;2nMdW1Ec!P3/G+$l^pO-`d3fV'h<p@4)/kQ`cs<"++rYRXY[
CE?%l9-gZXpL#NYT=8,),ca(%=B8,kYiF,EPJ;aBB<=WkLbqB/ma-m#bGS(B%i_4DUR]A">c6
R$fDC,Ku<K5A=S(eZAklS0g>ErZ08XJ+62'qXf]A<Glj$bj;L$rOG<A%mF+ZIS9b`fK0pRMqX
@./0'X?[B=cfIGTO.+)F0TeF()<'<K[LAH=Po$="06/ST37%iH.jpjhcI$)U.MW-L:B1+Mn1
E_[]AU*YH_LaCg=naOU1%\;Qq*UnFQ2DL9R>"r]AoZ6N0e?tkYDlR#5TO]A&4!::<GhAOU/l?b]A
]A%,b2d0PN5m5V.Ji4T+2FeQZkQNgM>"K.PjOsOAHH#GhRDQ^<E-":Z2nh=G5nl\)3,aR(9SD
+j9Xu0@CQLj]AM)0Q6ta*%%$8G6*$R76N-_aG4)+s=1hKc?rJKehC$i*+=e%q77i-3^nBM_f9
oC2232[m$^tnNU$+Y28D!<m`n+:qFm7/mY)SYH_=Ta2`M#nA-0p2LN-]AE94pD^U4fBE_FId.
C-kq=&kgN<%\Ka=IeD6/S$hd[fJ"]A:jD=R_Li+#Ti!K.!"@F4g5^2iV;79L'!?HNlLHlQ"db
i)Z![2s=JiB_BZY8S$,GKji32.$s^cf&c4YkB"t!LO*@=M732,>gJb?1<MWU<-X+hT>0;H&&
W2.jh,NAZQQN08d\+RI,.JC^#e)=@:Z)ZfasYPheTP'!X:%D4d!O(GK'D<)kJTFJc@l;&2A%
,ke_7^Z,^TY-0oP,H7'(kQg6b6klLg<h^ilRi/A"5t9<l=CO'SH"\#S;_.RPUX?S$fhL_:Lc
]AQ^jm=fh^OVq'FPppB$#f*kOp^FY9'9n'PI:Rd[iO6Yd2gpqX/GsgA#>8$2L<p_0)d"dD4(a
Cb$s_e<;/clA"f2J6(1?$)F>e->gs!a[ZuZS/g0'@I&,Hk&Y]AplJP7p\Y6qFXl;YK2$,`1RK
1q6/T%Bf3O^16>\`8.rWP$=q&_C;a34W>1SiqM/ZZeYA3LKFL%tTkXN.^!k1l_hf`TXjNY@V
@,9DMFJ&N`/ujf`ea+aBRqU@CT[re,/\R:ZsEdLHu_[9W?sN#pWCYqk1=)ZDH4q3^$GrtKFH
?oH%N;fN)UN01\ipe,rc*Fl^;;B-"j2RK_Q">`d$[LL]A^-XJ.;>L[:UkI]A;f"\TBMDQd=:B-
Au501HFrTpo*7^a$T;9*HBi7`G[<-0R+C&PD2k<(7f0*_tnoK+9.F8C_d6\s]AS(Y66kV;F4P
*f6piqmSrALHDQG.(SE-X,#d\XSTHqjY6Ls+GI0LB4%.6Tb^U%fOHRZ)L8K5oX7N^3-@fT$P
*QWBLNFtbTUT\m?fh1R,`SS;7)ZKWF=KK()\R>?O`rZN\k^/MAO,"5$0V'oU?YDZZY_fA+X2
J,AB0hBKja\0o)86JgW$#/j/OTUP3FWt0bQ+=<:qb@5*-dfiKfSN]A-Nk,H.@F-Y$bD#pV$V>
poNjt@Z,F-3<rX>gBg#5NeS$n<NX8*,c,,rFm!DS*8OYBVAq(jei=:f9"5j5:;>_Mof*>of[
ADjq4+50U3q<F-ZF]A"_$5_7&kM\r6nYmcoUR9Y2k8i/E7bj[n5ds$VV[h'8%OolHLA5KX_*=
fU3Uc41D?m3p-Et7K0r`]AaV7>1@P4JN;kmiG,g7X,iuV9>JJZN0Y[*Rq[$p;LpKL@bk..FmP
Zp5#)@rieJqu#)\BgS"/I5U2>/.["7k7K?64&tk%HL"%p4ZU)``3p,KJX/#q>O==LH=@)FDm
Qn1l#i(V:"SuqCk/#N6S)AlgCh*Li_4-Nci<BI@l:#de&tD.8"\f5?-XI'g@,d>*OM>25gPg
H`dbQRQt:6.7]AePY"0),#,:9ph/OesElJ'RkpmaBI)!-j&4AcUWI]A/iKQIJj2b6K+_!%rK+<
`FIZucW&h;+iIFH)USQI+N\chDkf!SF"@ffA6,cP7qc+FfPTO2`&F5Ad,;h(-"%52h3I-:5r
6BG7a%:$G,P9&eQ"@1KFl_qt"F.C(p/&qCAbI_)J1'>3<:`/sDBq4Ca[Qdg!),/ocMe>OhrV
SSj9q>tua5`</Ec4P5`?N>6qkc;16:A;1YePfrnn[S3cG*MRmWO4;3$@b45<')c_>u_(O/hP
a/;A?YUTro1\#:V]A<m\^c.c#3qb[^1\0Ndks0'#_bJTg#H5'B:^Kr.di&/]A=#p#+Rn)8[tVP
_qt4Dk+aXODtD@5SP9c/e`'A)#K6;/5P+,"oYWXE.PoFRmRC'kl"FjnkpHAH\0[:@S/Cn:P@
dS>dZJ(J"//*$PL*J<gV_eqf>C6q=Z0'`)iW*"hOW"#<Qq.9nqd9Y.']A0[gO&L-O=;UWE;S5
U9>K"#i803^>G4C&]Aejc\V*#psl%7P\le5;MGLUn1I#pUV;E)L#Z,S\,6^BmEf=ebD$d1^+r
RZZ:p_nb<6l86E&N\,[gXZ3108G`NEgF4-&GEJ'.Quqk8P.%T(Jj40`F(u;O1PIPRh+iA[5D
+M%4C*mq7SZ#2;*j"6_@SDG#RW@gfZ71<pCG<_2ur%Ii-f?dd<mb`\je^q2J8SBMl(re1L)Z
2_Co1*\?gm=Wbs7bI-:l'XA%m+:+N%=aC__-XgHX57KPt3=Fi;ib]AD(.'-8\F$?.CXnG8%dY
T+oM+'02<1I6>43SOQ:&h]A%"C^`2ho[qR-8ah7n;EC0\Jn]A"UDTF$9/J9?:3]AdE@;/.,\!s0
*&4T[iVtV\[!Z3tQD?%cW+85Hc)?#\I_c<%P+MA_9L0<[9(1cYaIufC5_$kL_/:]Ae%adUE-I
@f5+MqP@KG]Amu37.3eqTR$kLh>j0-'>+C5mkY!ETuV,^Z"94V%S=)?PLid?rTWXV.q!NLXE2
D10o-rB>(5P'!maKf^VCAg*tu@PcuosVVs!KF2Ec<u[rdWUn-9.51Y36qhpf+`aP.UA:>@2g
Baksogb7Wfm(lPdgpYIfhN<R9Q^gZh[#Ee;28W.fE7sK`0OKpo7cO(EgH6N5>Q.#;6-E[;2n
.#ofMb#'@TlZHqg2J;kY9tQ1\ql))-3mkes;\TKN!e/^&&Umd#40Yq/B_=r3!+EH\kOI:U0Z
$TY4$$7m[M[la-9iE%@&N>`oJ`)kXcf3c9"JOT)^)\0O.<ITPA]A;0h_T2$qmnG3P0/M5;FD-
sFuhr]AZJ,X$2A_k^pI&S`0D3<gl(Q=^95h-a&4UH,]AVj7b#E^ZZ.8?%rP,2^Xob1-Z2j]A/il
Uk^9Y$*G-<kfPSq]AcW7Sh/H1j;;m0uQhfKaj`6p-M8i5Fr*T"5R'f&&q&Rab-@jefU0Adddu
Ij*c)G\N^3$u$,rSNn"o:/p8EoYL9c3-dDus#f]A;j@/,.AKVtY9iJ+!$pZgO>k"4f(mls"7%
_G>jRUr.7d24eiI,YRpQn?Y)='K:6/B"4^.3iQ^Q;tqOtX/kL[:B#>6;NlM2#>;[6;HSY2hB
G#=rDHL;3:UC8&X28cAR0h5=JV%W,rWs32Au5n-.fLe\WfqQ&Z1T1mKgh[R70CT$c%m2&MHJ
+PO$KV8uf]AY[K[gYWdWDVP?(ToC+ZC<e]AI^YHm$XU?eQ-oh$/KHojKOd`_jlP1SUCn*3`WUm
>D$kV#4S[N`^k^Y^Y;`@:n`no_nXgQo<j_m^o"=8gu<ZG/(a*J'*<^)7/pZt%^+jbCpbPnLL
A1$>9C2HQd:Z"Rh"I&b*e"@#c4akKk:YVUm<tocl%kk3N/U1t'[t7^2dM48@eG5*%$h</*[H
qj'LaG%\)CqL5@c*TNnD-Q$Xcj)sZ4'gSbB`./*X2J/Fbi&a:.&i9QXD)(3OR$'%'?OL_jBb
hM1Pj<1H<dj4TV(GYL=)-^dqQJ$D.2k:`9;'cmbYYn3uWaQtQbPgWd>&U0To.K@MrQ0\"r))
BW.o+$ZXPYE[16g2o7Jm_]A.//[8&!I</uXKPQgP;7&X<NIC-SN:dJ&/;kAT*e^81mq%?CK*n
/\p,q-r3J*=.7M^]AidY`9gluB`\gZepfJj'.'lhASkNs`=iH"jr_"<G+7]AA3lOlccR.G[5;9
^J#3P+rF^Y%5No='la5RB&P*E]A=2Pa]Ah-p-N,[aI4.H[DjJO\':=g8F&eh_9Vc8pR9$aRTp5
@8P1OVdm]AV^scUNjlG=39L&Tng;*1+7ZWN_4DnMh!qBS%[[^"K]A_u,79V[@dKZ;Anh^(kJ-L
8S1$O]ARjljdAL\a&JkjQlQaBnAOE'6!Xf$<#+ER2t-ZPmOeh(.8=CYKrQ%(3tpFc:!onn72W
C-g8'HpGKgKM&J1h]AJ-2g4daq=M3WjGuRiCLE5T!n9<_)_aH6hW1^_*!IQIPEWE/8_?<Dn^#
mD/s8,XPjLgf`'4>UN8mldb5+H/i`NsD]Ael-Pl`iBks'GE.p!mdN4pkN@bQ>?Aen=TQbdcop
:RY,?;\:^Z;:,9tkc-0gkF-W+L)`ZPJeL.5I`Ktbio)Ya0'kjOiQjld\1:\9n'@l%qC&aLd&
*b1_Iej_UPrC/X-6[H9#?hGjaYO[aP2$lGaTY'%Hk8K-S&WJoVoD.T9,#A\*n]A:Eq#K:>LS[
(LJ>X^\ueHblpm5*jN;UD6i[X0'$dM&=>e$_Hcnb8[/+N:Nn:VhS&O/=T3RbdGsPTfCRZ67q
W5WjCN=%,kqo$=!OL6"BjD/-XbO@.]AbTb>q;md,0<3]Ai!:.\X_^uBJWp/9D!\7Npo!PXn?ss
>bEpmc",1HCqLZE\-`14$B/X(f-4,OLAo4(:kNeCh0%16.j4MDUr*DPN^_GF'-d\LPNR_<qC
[Wa89)N.bKp3ArDWFB,g!"dGu;a!VMH8g,BV)UXrb:+&lTtoI<1q#R?'r3O*$$.PP>Yrp20)
.il'X06%f]A>RTJ297sBSTGbqVsZFVKjHEl"cd@lALH#>t?1!4G22n<'2dJ]AR]A<^FUPr.7-(R
<\-7R-M-aTkq(7Vn(R(I^eG;/)4J-0-<5==?Q.SZ46Z`Je5-Q?P55`)U2Nl>3SZRf=Sn9Q`$
qT&X:2@*R%Kh%m*?P="=C'.^PDiIPOGhgq[-TK7k%(pXC]Ag1[>aXO]A<R'AaTPJVq3.)mgG="
Lnb_#6\l,2h`g7KMJ;MX_^br^iCP]A^7U9S4;!K7^$q50?=2#:OY-GheKI&N7sqXVd862H&7>
[P<GbE1E#!fi(^V3ml%ZV[6<Ei2;B1[K\\ZPGUJ]AOkGX9n9/LBZSao.s7^mB;/k$[p1PM\H6
*%/ATJCmXH8]AC*eG5.mFpCunQ*=jn>L8-)O$B6["(:XrO@2@GFT1,=PW1C+8G/U@Urb3F6=I
[i_SDlX;]AOT%ttmbb5`Ig25b`LKI'EI<u57+:0(PoU!lo"Cl)[>MLDZNb/0hp:1"lsA<%!Q*
SC,$cKZ@"_c7B)VX4/RhiDPI&\%e`Y^r20,%KL5TOFO^,JB.Bh(.$XJb+Cc-k%d-f)$MoPHB
pj\d-TIn&Hn>U0k%>=gf:>RN`e7D`N7)#fmX2[/YJ4-?1Bk_s>=GWF\9FFfkoV\:/e$=jV?J
HMiDM?CtsdKKhc$b4BGC1I(D)78AFmB'7-OlnVL/gEi.lW"#NV9n`3dWgip&g.JXG?K]Ap1l-
@^o9WS>VM%#P<rtY?Ek_>&*G%hm-e'I#]An=0I]A*I\'!&#IZaAAg<h&W3$M.&/:I!V.%BH6;_
L;[f8sX$h/ng"1:YeNeFs^s&\(\fYFp]A$5*Gi8rZn`engIZ$Oae30g8m&cL2*W%qAgNL7cY$
*WgX90rum2YMW[:?'H+lHa'9'/YI(q0Y!2EC3A<7*coh7@[Z@e:GGQaYgc>^EUPgT:$D"K\1
\@UMkn(Qc),t_Ho>,ZVRFCIJd[efGP*1RK.s"1nYDmBJ&cJpdX@n:t\e7T'eN.`cTI?S@<cn
;ru(I(XK4EGX-G^@2^V&Ipa@VKJ1a0r`*q*'ZXha>\:pSRbGcjNM/OuQ+&m7N'Cq)@A7LMht
S.#=a>8b'ip`h!ZO",DS"#i5Yj=*RKZ*mINprTe_LgICA,4Q)lNHBG4DpN'BVZ\5NIh#R2aT
FVFho88b2E2=XmZ"O8\@5rr'M<%s:5lN_e<G:"g4HlT-rO`XKH1d>+1%TnLrTeOr3Ac:'2[L
XDHj7nrl5=l06\n7T'/=.kaKh*-//80C+@Xt/49AVU\8)"*KS(SCQY47&VqZmBORH4^#Rj2p
&Bs,fJ#6nZ9]A(d)'J7us6)Z@)(i\%%UJ97EOliQIYKoa\9#aSgYkiHU.[V.LDM\X[hd_nk1L
;Z"[O<dKCc7,P5$24b@X?KCXYppeft+cC6ab*kik`a%.rNE.>Y1*Ho:U)n=#@?/(s4J&Q16+
r#?W[Yb):nFJ>+\_s\?jiAMdE&!bl$:?k#m)RFV;2&J882TfKL_drXbD:_J/,nP9mQ&K"sse
FrhhEZUQ+j0h5WCX7R^;.22oE:S*h"i=bV]A9V/-M`E$J$.9A46\'`2YJ:9GcN(2Cs>VrN':M
#5E[=T#+D\%9`BCZ5fp_HN&S`!4!$Gqg9_P$2_nKnmE\D*:>R`7L"<7/Q$\0Im2+h+&DbNG4
k4<>g%diJ9,Pc<ZBV/)3<4c?5!T6Y2^4Z2[N@A30$fdlbrKEAQk:Hr]A26<Rhjko*[lLD`d!n
D!c?Iao1b$)jg%3q"rWlosOT%iM_uVkN%K^VjC9`ilFk5hQD,D-I1o+*K8E1`?JI+ROo#Ypf
i[@Cg<T>q;>BX#F8+$M&#1s<jUJ5O`3f*K%aK-(r5DlQQtdX[&=?l\!qR*chUI>J`3hB=4X+
Q-a(tPfH&-KmQprP:[*1hgC:Kq;%/?4]APM=HmSAYWQq(<N@n!63&7$gno&R]AG\3VbcA!1f.H
q-+VTQ:9^_.*9`6*lGu[<(A/S#"AnpVDa4'f<ISnoXY,Ql,cp.+ld@/58UBgC<WZm2FPBH@B
>-1,rju>A:[$_igLd:)KI6b)5SmdaI[r3-gtmq)_X8:k$#hC%*5nWu?AT_kMl8b3DbEgiiR9
-)KZj%,YQB(c#(@H6_@$L.DTZ2'a:fMSrfrLDi2+7^P1]ApjDJBI?F$URN51%Si*r0bBj"Chu
M2dY`Qd>:*^cWq^BB1m7R;Ibg6d!bQ7(W=RK[CV>2Go#Q!BGo9q,@=#(IBE!tuY9Yt-^qDDF
*l_nfm\1c@JG@,8,d*(,D40V>9:uY23r0Q^^X]ADM*p*M>nW%!X0>WsR.HblNhXe+Zs7X`$lV
g/6H-`VSF]ATF6b'cZHLcrT0PJo9&;79X5Hk+R^D).Krh4QUVU@PQuhg;P[8N*_[U$;G4gqKn
O\PF9YCqjq#iTKG(HdA9Gj3d.g"TPXb4,$b`:EJk&kY==A)Ake]AgpT"`Dg#_@Qr(kG33RuVE
"4"V??G>`t,<Q41'a(@G+0DqT)0HbXBBW7ih5j=d[@R9kDg)*Lrp[H2iNR?FC<ea^K#g8'k5
bd@Fnk9c3ZP"[ZMD[+%AnRn8G8)?]AUNu&<@R*kQNI%W[q>'`de:Gbh`UDWpj(!]AJKC5ZVf]AY
&4aXd]AoW4Kq=bY5kotR!1O.%0jSjj0C$t-;/\tn6INh4it,j1GJ64H/jS@`%oar7jD4XjJ^\
.gUX"",cN22&D?Rd?VK6RCDcU)KT.F^=g:%j\D9JiDjF0'mV0qn^sD.qJWYh!N-6kK9.#qrM
#J/LTPUbIqO#kh'^W5SA0U0=f?js71I=oqQ2b04!%s+rHF?:9@6_R0Hn[nE6Sskn5&*c_g/U
8cJJt8dSoAFH09g,lc"TW07BB/!X.pH]A5_+d,@RLW/pIGgs"n/DFVnN=u*9E_(i(r'"J&AS=
5We;XMsF@@?aH;=PT-bNQD*XpJ2,"n)#^1j6?78`+Ae1#>q%o4LK6)I#VDLc2Z/T,K0F96KK
D(c#BQB-9;F86,\LmhO`/0qlt#:GTdN&IL&uk?e!*g).LrY^icq]A#-affjBD1ffTM=#kB5P8
PW\_rPi$HqfS>Sc,AZXlG;U;68%+0r1(c.g<di7Y2urX9^.,tG6Tb4hP-I;5&8uE#pj1SV1"
)#:pX:D?h5=(F9T9]A7S3QRNNp%=hI2"SXDL84%6oF$<6S,tb63FnG%XF:0TZh$hf;VAn6Zaa
#_(,pg=XO8Iuq^>;BiY`Rl*hRZmUIBs6Y=(R_h3H<"u0#hcT=$,$\(qMP/"bDSJ972Zc80bB
8M1d(I`A.-VNl[s$4Ab)Pu6KrpH<hVQ4s1V_:Tlka>0)H)QRdJ06U;Nso!s-/Jf?,Xe[b=4Z
'<B8(mZs538-tpmm5:L.R(C'HD+i2Vb841-'JWUDl"R`r?$FHC4+cF>,/,t6=F<dA1NaIe.`
cYZL4+4r_nS2*sribb':.@sABEBMuNV\Q6pN/brX=`8c%I^ALDnT]AG$*.VIm_\>\<&"n/V*n
kL,PKNjX@)CX^g04Z*0AprS.f'#I#[tKlVK6OX.,Wh:H@WY?*\'eEM\Mm3@+Vnb^o0mo?n]AH
Pl5M_W+fD.26Zq=^s?jmN,NnSe:[R*S'B%ZGb"()/f:lZ#'kO`2p5YOS06PBE%gfNgYa2DO!
lk/*Vl^IA74BRC6#",Mp(juhM31^I$Mf,F^jU-G]A/:oH^k`qU<B$9h\OO"pTg8C@R#;Wi!K=
H@:;n/4[$Wuqa!]ANP2&jcT8%^5%nPj;!s3'$gE3TlcA(!)mH$uiQ^@fV3AO[:_;ei9h^b;jN
CfVlBR2qj]Ac`j&iL;htpY>noAr-_D2G[tXs6.fFhQaSh&VGY-+O&Ij=P'=G.FfTg*A<)@MbB
lR,>\WAh'SXb>/%p)hLkMIIrsX>VosZf[N:=LRYkW%W*S1NX`6tEJ,LgR,0$:K@Ue5c&.M5/
[_M0WI!B]AV%<M40[(T1"SUcW?4QZKU?:j=NY$=e8Z_:*P3COdg9f*-7#PLm+i-!]Ak<hnn7L)
0(24OD*9ADp::$N>^0BB:MKad8K]Aq$2qW\f2`fi=X5!]A[G:ZQ*-HW7[72<U%<LXr9g'[j.sK
-;e+P5p]A`>-!1?B$g_m)OrAq^DkN*(#"T*OC4jE@t^;R*\nTp4@%!p4o*SgGR`Z:KG7ad2J!
h'F7.;@B*A)NY^)BhIZ5`Z:r.HtItNnMX/1WEO+RO$*rXNCK]AN=%K.\9sLCHAeEQnn7ihC&^
<ea+oSpDiZYZ-ffT6h9SUdfW0[TiI-`oKrCIP@iA*n&164Z;l;:Q/TsZq+Tb`NUhgL@JZ;P_
b8%Vjg$?!IBD'D$c5nCB@5/"Qbf*N'cR/pR3p+PS-?pk_\O:jabh7!hP`/p4"=>SJgbZ+8a&
(p7,;?u/UP.sKYF)6b:5@<F(i[)g#=+Y+%0c5%3F;Lq-Y"l@;+uUf79pTi\<_WO_8"W1?C/E
B6Q:YE<i3BKhaKR0H)EoKZid.NV17:p&VooSImqrG-Wm%gO1CHmLI;?A[VIs'L53n4A\!<VJ
n5FnaD*L!7jg?F\+5k'#<%TI#[^]A_MFY+%Qt[TK_l\%Z?B9QWVeW]A`.a66jj=E@gn_ZL3EJ5
tFP9DR44@AB>>9_+<C]A+L=I/=".c]A'P-THqc2&ti6!7dqA^)kl#+`X_HoS91D5L$<(o8.P0T
[u94a=/'Il0KS;;]AoUqtKSE_bY5F!`D5XuZQY)a"7!_?9/(6/!gM'tFeU_9uK33HG*6K#;L=
^b`]Ac7Xi/&o]A1D9om<J1P$^LQ(E!S*Fo\$AYT;+R%2Q;Ss6Hj4jp(Ipc8'4m%_thPIk-?,d8
A+=crkeHW2(P^<hN(,<,"]AqcerR^C)aVNU)*39k2[_DoWc+kCsf!K9%J\U2dYZ;hukLKWQIc
BT_`H=K>X639jXG(tPnj'*4^?>M0.R-DYI0_5j\%*K5?TO5/b#$igk<dd]AZg2?EYDkYX-g_Q
B+l33[$+G<A`kC<b/]A34KKa/)r[i%,VUa_o35pF^>r#KML&4bKq^%"9O@"$Yk:M/Clr@l">W
86WRlm#/BtHglF8ll@-UCZn[7#UV*]ARjn(&p[/HIOQd=oS;\9ejAStQc3A9Em1J<]A?t2F)YF
7BY8DaGI+<P\7clS;ene>9./ik0j?VNtG5oL+O9e&2<#=!N&R:9%&m.C"8_Y4,#E[hqKi=\'
@4]A?>>UA>^\*-7Q"*)/&MQ_ANuHoYgXjX))<PbL6".n(D@,TKV6+K&WnkOWu'A#uT;G#!\4>
>@C;iisijK>;9FNRu,UpLK$A!rJW&41HN!aklL7Dm*&U^j_mhr3!%UJ%R'7@^F9:Yl+;khNf
.VD4KE:rG2".QY:`iVP_>uZMX]A(;b)bJ(SaO=K2m`V-J'AsWsr^9*o4RX9V\t7"RjT@h]A%PJ
>M<\sRU7I>T.'kZ&;[t=S]AbLRnI(fa!=In3V).ku-[X!Qb(k(=YJ!#4:<`%5a!F!\c^n>q::
^#/J<j-fAf/2i7[;hcO8Z&t2u?%'F3rkcL27/T@aSq*^=G0>E@$K2NE"9,<F=/`'B/Aq3tAh
j<\D(jgYP&!s&&f:jeMlb&qp-Sdc'TeR%RN4om8\ol&"akXadcW'rlG-3(%(^7P_p$kfI#Y:
\u`F#M5H^Os#dJ@rsWbX1(\@VQk4>=kSh`e4fAuX5>67,A:Rqe_?(hVNmnU0gaX9'd5FDLmL
W2e.fsge`qG=[n^p6mCEYs@i4!jfC8EUhBJ.@3%/f,W<Yn<WnP2./"<gLSkY1I&PR;^A+Dfh
]A^ML7X:=!s!*lKVVp#$Rk>paUn-@)Qr.6aY?>eVlOho6._!\R=j"b:7.j.G0JID^6N-/8#Qh
2Z$ldTp8D9U&B$_A2<qHGFjCnt`Oj_pjF5A$([\8"#!i`BJuplug7m@3KXs5*1-m%Os)R!j1
SKpq2TB&p8kn!9]A1F#WtFlg;;Y'C6E]ADXWkV\I.S3_YZZ8?,hQ$9)r2'7$k&@!=.&X+/1[q2
p1!H6T2rO%Can7UYD*Jp>,/?/o8g-elM*P`E:BsBN8+Q8VC,Bds(#MKI1T0Y?g,L=CnLbk$L
bB!)Ei#<$A,40B0#]A6glYD3p28_g4&[g.2S,h<J/l1ruR61#6'Eu/p[;;N1>mVF$7m60=3I"
Y8PBX!bhVPl-i$`]A#Wd&XEkf)Vs"j0(8E'ue?De<$(:Z^T2[$lH21C"Ogf-]A[\GUrACu?+l6
'bf/:C4>lh'su1<aOBL"Tp&3(j/-Z:"M)?C1PHDg`PQ*A#r(*TF)0,iR2%cu5Q-5c?l)a<.0
#/8mP45Fooel?J8j$hL;.3-e%Ub1'V`\6cdgRZ&u2&=:!OY,ocl,P[Y!'Z&CE$7!2t=`,\4Z
*3!>cQCg&*N`a"[df=1pUIohAa!0Vj%(&O8VU!c6jm"njL4TPH3,UF/`XHq$`tb7JL]A1f3/2
on-=(2$DlR#ng4oe=I]AC\SoH!fTe]ARIm>Z69)@868VPq=r'<g'g'hp,3q\O#iLQi5uhHJnW1
f+DQe?@7k:>=m-:VX&fe%PI(AECa]Ad`78)<K@*8L6-]AfnheK3Xj/8*&.ZhLO:=O$bo?UD?R9
bOP3H%#$8]A^KeHSFNQV8n'`:;cErV3\//3O4aEQ1p4>4ER,VXf.XP^5>D%#5r$h>H@kqgLk)
H/M6Z/PN'CJlilHD.eE=ADR@1mYB+`9m0Rt6G2iXArbh86(RDJ!%IO7inUZU)Ui,$Oe[i,2k
3W`sGIq'anT6B!Z7+(!i-pQ_j)WP*&Bduoqn^Y-/LIO@hV"fKGrP;j\&ACreX%RWN7Tm\HT(
1c$YMfGjEs\$%r8[&s2^BR?Iu(sS5Co0Su/tVh&I^Z5]Alj[Ed!:mG:LPF)i0$sQFTa%O707f
*>34ZUP,h<X-`NMck5a_OW3fbRQ7i;<J/k:ldU$,NR+6SM<oBC#\%ibNgh(Ym!ams8Qq/+Ur
>@gKmM8`jng:jN'%f7.`Vr4#E]Ag`T.&,Wep]A2EV;LXS\$,#6kcpe2]Afj8TCG3Ljb%?hTGn+U
c,&^m/&NlAb\Els.ej@J+5ji'`lMH:-.;$V)`Ch"0ge<T6#@.Ra`a84RG1iaG;iqW[RC^'R,
bZU<dod5K$tAOeL8Q+AIQ,g<f.gqr:)-%t]Atd6b4@[G_H((I\)2mJ61!l$9amc.i]A[-Jj3rN
geJqmE;eku4FUK(qblSM<mlrUu$#mi!.YOdKrST`>n67&s$/]AI9_ae7UYB'(1&S3r_ldA(0t
ouq`C'L+niBhBGi^=L;f%6U?:m0;!qOD_B/dr4g+e5DUQM`="0CT2Xck8_a%j+j"1iOJ9D"1
Mai+A-*?Ug)LAj+.r+%9W/rk_F2^%2duqP=p(j%83>]A2K&&U?.e6CD=^U+Mp=Z5Lt%/06Q<K
E\'Q!Mp8+;Al'"_k]AG7jO%>O&N:PKo4&0e?.)V@Z,q;^MY(jMmLAWe"dCBdZkGRWl_bsiLuf
%k;Or(:0u=QU8ki3m2(,E<I2gKo\)e:d0Qm@2tl\V/nEntL>!dNXA(R3gOGHis-+]A4IO'p1?
Ya,TYI'@nt$ijLO`UB^bE9a0YhJ<2a+"hokS"Cpo'L=XrQ>Y(J*4'NJrY0V+IL*Kc!pM3%9F
&M'=')oqn+14bhGhIcpaM/lYZ$hL0S&NR1(6@!6uo.Y-X%-[:\bj"G#lP\PLKodUY5382I_r
iD.'HjAlcPQbR7]A"TqY.s@?Hn)uh@(TE/Ml[)In(a%Tgti+qJ+pq\i,N/<1u4YOiJh/BB:-5
\obBd97&W'*2COBfa(rWhlD2/m_9RWgX,/Db@+-]A+Q@94:l,.VD(EEb)`bP;96N0b5S6s0ih
Qj'A+d@0Hm+i!\3IaWQ,b0KeqrhUBq/?l9j,M\;&Df2*j9t$_"#>1c0r)B^1#e^.Xl15?L8Y
aX?K<ppd9)@@D:JW]A)?"pO`tp"d"=#4!gl.:NY>X+A[Xtbn$m5a<@\E:7'!pbR!4<OcAhDSU
BKc%`W]ASX\G.a3eO/cr4Loo?rbeKcW1/`N-O222;NP*pj0Kti*T=rq69q%.W;S5q0_'"l4bF
5]A\"^/%04aUOCJ8'H`pAi=o8]A<!f?crEDn/hmg745\*DH<9Q^`GAlJ7Pd[QO18_C?eA*dY>5
K9`11O?H5+GE\9l8X!3X7$="e0a'Y<3Y5_VN5ncZ4?0E$Cs)RP`PZ3^Xou0d]Ak,uPun86hcE
R]A4k@h]AqJC1-/Y'@&g6Hb-A=7Km-Wh/_E(4uZ),+UJUriL^(O5^*qegCP&Lq7[Rdq%[T.47t
R7293r0Cs6S@,"@sAKf@/CO)uVh"o^&u:uo-TmKbIkp/WKbQ?:-k*aK)Vj2cFt-6DEXSsd5/
<4("&7l1DQo+(?[8MKkXnr*>Q=D+c3hQ2E[f^:<\ZCXPEs!?r4".DQa@LuR[o)-d2<kMNtL.
O3_X8J-;\t(O`^,p>%NmZQQ^bUb_48Y**D)Wf.2]AGU>6e-^9D-@@3o!;V5%roqSA+<k'J38F
-#l"_a3W7\q=$6-Sjnd_,T"'"9^O9aZ^,QX>b[<8F"`lOK]AO`r]AlOcsM\@D_8L<:mtfa!ck-
4@ZD=-n-31>dG_8D<kb#>+M@<6nn\f]A-Y:f$6M>[6S@G<9'kM0TaQjR@fP,)O!e6:2/bUo;3
L[SP/g.rD%35H+R-O,)6r(pp<DX!$kkA-6*tjRHl%_)cI<e^"$l>B<Ik_50ME*+QnSlhm-?#
/[<WYh>c[4E#m+Q,>JQi#`:$<BtKa/?m&dZ*(r'S5?=&Ce0nb'l"CX%p<Ku+f:6.e4Ok3JiZ
R1;CO%EY]Ah0b3SEKD==.F<YJ&JIpNU$mr:3dHJ3^Q&0mo9;6#%%Z%.uu/A`Q(&d5k7HGWg+A
dk4?,?N*VnAOZDr>ADSVJ^3;NR/Xg+]A8A:-(Wgk@X]A&L2$-Pajp@0$s.me:8H213+B=+nXW4
=<6aL#,h2-i&4LZ+=21RK4aT&dEZ4^blB\p+>38k([V(>"iXjie<>uPbL[-B7oYDhGBeP[Z5
0Oah7$9D@bn$qBm<[DM-..Gu5db+cpjZU">e3b_G06"ed!TlQG2s4t-b)X\dLK#tZS]AF&6C%
St3C4(A\XBOb?7qC_L@DAhZ[&+pYZr6bFA)7Si&Zper'H[0k58SptSWWNV9JrlVE+(K&Qb>o
a^[WdlGEZLDtF:T:i#N,JMCD?tpI8j,J+*eUP.atcq"./8q(VfXdTb^k3k:FT;-*1;f<de^7
qk^koF#F7jaLfLa'>t0(Ub=G!oJ:kk`99ZYY&gp=oNqin?Ki>!\7-]A?09$Nn6;rPsL9YlRD"
54I,V#2T8S#]Abm%YhF_g2I'e6Qu'4'G1H^&I.67e$elk@o]A$EJ"1pd8)REapL?W(@h"_(2Q-
8)r"X/RQGFnO1<g+_B\i8"@)frYmu7N8Y1#sQQ(Zr8g/["rnLH2><R,X(P$aTBh7.h`;"X[#
_U+8D;m&#J0I]AsUpFtCdhW/^q_67$]A,D']Am^'9;#Z_R3L)P,5\ika?N<8>ZeCfMT:neTKDT>
k,0=B&"Dmo;-7=0,GH`6G3TJ1Ojko6H_a>E[IM60Z,q'>7VrChkSE?"tADRpn:P*I<\/g70>
jUC`]AO91<sLTC=]A-";[3c&$Z"j&U6NaDP[)j&.6_r:OY-dPFaaCe;p:Ff7,;k^#[&g=%-ref
iuA7pm(Fb`c<i0k?q+@Xf83!>e93"P:!i7l9jQ,6WqE\Wh2,0=I[l+jf(b07g_T,Ut=fmeNX
]A'#Z.jp>A=Fc\;a4=@Jn:38PaihbZ+8g*-1hm:*G,c]Ai\@^T-oG87%rODm*@Pqk?hES=HBcN
GA?7t^pGTY#<)Nsf8gfZUTfrQ;E+]A)]AY;nW<%ggJNNqs]A=-jcno9$]A$k3XF)lKOusn;?Zj\*
ea(k*%VM+-N:Ld=4R?c(,PY))P=sYsK[aE;XQWic&h_J$j$Xnm^kb[Q*6gq`5r!5^nQ^K=B3
k[W8Xreh`08YO.mVqnqMH43UWq=^TU=T!pCtbhg*u>!g2BZa@'J_^*2!hnq>KDn;Ni[ThE_A
E?jL+Oj1!anR,!3R,$([NE9NBI,\_)U1);_&2>*PJqkG$#o5$X?'ER$\M\DR%YJ(bi2.j0sO
(#<iuj2m_>7%AuW!P'5Pht3e)UFVC[_Hpc^Op+N5u`I4Bf)]Al>hdHPXW*P"2fp-pE6Hr,E:c
j1mHfWnfES*F/UTrt'SJ.fRA3q&)!&TqJ7Z]ANJ]AeJ?ubkDp<V_hl$n4B1\Rl=g.(R[l,TmU)
oR=E@6)P"clljZ*%[<GPJPM8?\,nlYKDL6'4@J7"'[BNe1$!Csc[BRNfMMLL:7In$b)\0BAM
0p=Kae)C^c's+I1:N2bLndpS`-7FRa^P0F3YP_590mbEVjs&?-;GU>_n?H=[H.i>#(F`9f>J
"Oacb<NS*4Q`;N^6lu+1(%O[St[k`Asg3[9#&U.B,_8hjb-Q*E.VgT@\RM>%^`q3P@-'NNgo
"9\D&YrZ\$`paM2;qU3U4NrF@2F0MM".NssP9E1UhY4e.>A7a6D*[[G&K2q%#ne//JRPI(9*
\5/XoP(C3ZAEFmn)Er%UitgY&d/W'Fg<f^n_oH7/2bCKT`i/qj=mg(WQ^sO#_ZtIqY>MU44Y
D;0fYB*(I-LJfBBI&?E*@&U)FRmuSYE6$rQ)`=!\7*1?Q"#N7\)"h.a#Oe.^ZdmBlQL[dcbV
3(;-Tqp:^MW$u:CC_u;Ybla,AX,sGj6*.lTr)uCrpBC%k_Z\W.`Tu7s)NY20,"A9.+/"Q7,'
.2#<c8(s5qc?WkrhP(($%03o-_DXK3.j-&$`_fGl.O8?gE%_mQ&+?a7CRYRV$%H[Me<_e+]AM
,^hLENRe*/FV,7srT)j]Ar=WS4"5[Rd,Whj$;[10d0YbPqJC"tO2JG9D01jjK6mA_Jp_a\Wia
Rk/'P'Zh3^,<8Z8`lB5.Q^;tBTMk+QD_uWLp8.r[@s5sl[@2sD?7(^P6QEuC$=X;1NZCTI5R
f-oor0jV1Tf'+C_pl3WbYmX>8c-_;V%XU,?X,[>?&BdQuY8hXJSi)LPZ2drLMLj-uqJW0J;[
'q`ahq_PCJ]A?s=aI1AA!qC:\LA<]AV2LG9J!-pMYM@lP4*l7c,]AbSo4&H^64\QBTh0:.2tnoo
Qh+:lQt:gU/V"RK:nTdj9uU5`,hanVD14O3Lcmk?5)J=`#X"sn]AMq\k<l1c^Sqf_doO@JHH`
$b]A0tmTUc=#ER%q&Lh\o!D(^i`R)sl+3Z*HjcQ&L`-6^2T**fgTYF?P*i0,H66IM+;ZmZ>X2
A'#J##sYINA'RU[0)cF<:mV56Ng`U#O;BJ\'mTRM\Utm)=q67qQn3fr/->sX+&@&-mFuB1i[
BF5'dT@-Sc5SHQW"/(Irbi'O6ZDkG>C7)72(NT(@Xk.%e]AYpNa&[radQ*%BRb<E:H4W`DU9Z
<j*?,C^[Jb<g$_c/p4o]AfEmi0mkJLP:PA.<[Pl<Vt<(6U#?:A20]AD4fH+_WGdleuI8`'7p/6
;p*f=V7+p%IH+CD5E3UW"2\r@-*f[%M-bY\W"VW9:L+`=taU1dl=$"C2>'6`Z$pB4_W[2YnH
NlOZ/-!!^b5IdEE&BbWiC>R8KE^@`\f\6G[_MFM_:abV?I+<pmHlEf0uS=_<pJEqS_LXD\pA
p\_`e8+O\*Gm%sZ<fc_c"#M>^#%NHJ/]A.FDH9_A?:,f"NQ=Ie`/@,Cp8B"#kS(/X8.Whal+S
?N7s6h-*3lmh/Aqne]A6K3\rb^jY>,fJ"^"#gl#[fflYOJg:JfcHnVB7&!U*G$d!7Q%N*.r0L
81kf;tW,l9sUHXV*A'",)r.LeMU9l3?L/gej;&%Y48ROBZ%eXM0BU^W`9"cK^Zb#VhHbVE`I
m.)KW3r8m.@G$sOtm]Al*f5J`)Us0neb6d1J_A"(fVh5nVtoG9dGHEB9!B3goVG+n))CH_We9
(88Nj&^,_^+5ne(0I.5Fs8iV(t67KJCc+kZe8nceCcp?7=9U]Ai(gnt96(p6LSL8kP85_:<au
H_(%?>iOE@X$Tee`bV-:P-!o"G4MoE#4;[P/cG+jBE?]At'Wf3[;\s>p0E8h2B&JNEdiLpND@
C.WT^m\N3\B(9)dF<[]A/5r\&2@g50.l<ZJYTT%*m/*tA$/[>gku?!-AELV<Anm@DldMARAVS
3n\5$`ohq`*_Oqd8b.N9]A'j]A,KQ-Y`\fGBMnDDdjtjF)&*=mkdD7$D&Po-+jt9e(GV-,eILc
O@m+7sVl]A)3]AG1egPqM-)5n]AD[#RjMaV2%,@2'XeLOJ<<0!AI<jJ-`"e0)R9fU/?[r3OH%6,
[7bGe&2PAmYUArM[rTNlf2_3NKd%pU%`&K]A(*6r:Y$#-R(l"47K7J<+tX43N@B*hfk2S%#di
P2q'+.@m/EmM=:;p8%@]A&H.j;]AI86p0u'D$G)E*i:M&WafWCu)isp#O@!3S`r.CXM&XT^Dh?
/DX@-`E)UHBL=L[EWaIdcE?[1%\!5p[<ZLOUPbZQnqBK3h-ThVKX[fh*jJ"i;8+n:W7k244;
P.`@[_6;$Er>b\9u/A9,KV^QB+%i9`aNj\_^r-a`rT?^6qG(?#hiLU8Xf>:;hj!J`@Mp'kf/
cjF-03#X\n8$"9^5lEgA-2H<=[AgS4ll";Vas\]AXK6Cl,nc8e<k3q&,Bu]Ae&mFP<)Z*?]A]AHh
&2[)8DV[Y7Y5T;7F1C@UXr#7i)Q-HA`p;`Km@*N8?2rn>.phcis(^44/q5`u$]AMhq;u@o@o*
!&rC"7R]AL@@P8pgCAli_Palg]AcI*/qDYutU2ek]A+;q=?,0(>3plQhZ:#7%T7B\?JY`,EIE74
"MMft=%@%:lOlf?<"r&!Y[$/K+*VF#S.V4<K&LoC=Dki"/C)cR[rcp?JA,<4\1q.G<?DDIfp
?>iT?q#5"5?ANC)?IrI4,L.aX'M+iUq[Mt-C"?';pp=f=V*@6*@ZP9[WUVpJX*]APNI/tFt[c
;9'Y9Nj\>c[^0'L^U$0b@%,gj@2<9R(&bG]A]A@Lphp6`sBrkH>&rUo$>H[p"co[unqFjeIRPc
_,PZNI&"Mnc7I;tG',@SGgQ]A/hf*j&M8lqIpJNPYPD92IB'd4_mf6UH^tEdQOHjfVS9Lu*je
[dXgPJ>Ho-m6kF<782uOC>8/8#]A3[jH[&6boMHVq)PjX/k+^Y_o"j$k+.Thafe#6U\q%i?S2
S<(:!eUM=F35mk^&JPX^lK_Ze#XY-XSeU-'9HM4JmD[X?gi!\Lc]A_Ci/s`[ejrQf1"r]A.&mY
s.GC%(7U/u`)OslPC/jS)Zq(Q_TRLl+1=Rk--Io\[UkI)>dX#ttlot7k@$0W'53$Tjh_\Q(D
<RM1!F+r3l;)WG#'#!.$UcH/G(3gFbf,R%mG,6Z'E0;C%$Gc+D4/(^5iI]Ae+HS<b<5XoApLV
\+0(AK`=eF3bDc"Q:`_6"bi,\*p91"YqmC[DEA20OM%NGg0#tYEQ^RMspbnbH7*5o#KS:[0g
AcO\9V_Ib'+bA$_3XaIJO+3bX65U$&SIub9><FfsC?"##:9jUZqXR=>Bb?t.q;u`Emj8b$21
UX]A!WGEd6h@r*kp.RXL&qj(aY&*j6Ct/1b#@#,K3[<9h)ZG]AKBQmN9beL.h-@>Q.BRMqUW0;
=9Er@IK:+ZfU4CAtRZI<)[GW",/&uE\&46>T;8$:TJtk%f`7IX/NW_qRhm(gEW?AM7ErQ2:?
o*,4'9e;"q/ArhTf93TEK16iF:B-T,1iA=E`pI,K,ldm1@a6H]A#>Z5b$OcnbY9MV4,_:0$)I
c?kt"KK^5prUMHKL3!9=lF$2h^llf=,>WNpu2K#H+hTWuE'AoEMr*gO4j=pqtk%$clu.[W#r
<V9sf-i?F/5gsH^Pa*e$#.&?MQpt#G65K++Ith7+_"aZiLsm_jUdf&3n@b#D?/c7n)R\Ku<m
Z'.Ie+K$;E-7Kl^Me"_Z2%D%8Q8>(;ae2JT=7p7&C![QCLZ.B7bPdPa'3FO2Xg\=ij'8lq+,
$FNL&AeC&S=TK%T1nO'<1*S'F0VeK(UP7NhmHndS(]Ai#E4L?#_SUT/9P;3Jb6CImdU*or;d^
uM"p2JmDl<"Yu(;C+AT>qS"8PDLnD%E7)p$A*a#Gs`1m\DX`E]ANTh@,"p34<qS7fb)=CK.:>
(S^o4UAJkBV_1lO?#SJf#MY>k[REh<fjX&ESX?>dt,W.gVXP3O_1<@A(afM.Q&;s#-f<cgJ`
lamCdIuhMO"9GeBJ"-:)_g]A&Z4bW!I3t>:4'SaLXd\=P.#gV>(^YM,$SKkkIb90;N(l(,he7
[CR1W,De]AakCI2V%$9;Z?Dgl[ojDVPH`k/n0.K+UQOc,R8T\?';7`3r\D16\+ME_c"u]A!!Ab
lW]A8,=Nq!&UO6r/mlZ26gm:%&so*5)=B&^%mb35%MGIZR*POKS-o%L1>TZ:XLmRa%l<MetMY
A*ed5_2E$h&Vs;HN(\2,lHThDg).Ijc9ogWdIBE"r?(Yo*8JcfC*U)pN92AmidU4=obUpnf]A
r9(Y(QOK6"]AN^YEZGi^'(6*Ktc[&F^<g6d2Z#a(<j.hW_C-f1k?eJP)@^'/2\iab&kj+5(c!
6ja]ATSbA.qUAk%mE6e^EM3C&mU"b!dC3'j"@8Vc.N)l'bE80)Sd8IL+?%m44`m8#++!BO(4m
[0io;a,bB-JYtpiT/66*(Y1@X=Qj3.a`1;,=(J-gFs5An8.BHK/o]AX4f%?2d-l+l-8auS*[g
l\#6Eu3W;s"!Pq#qW-:e:Otj6P';<p*ftQ4&/:0ZX(X5Tj8aRq5T\ho\C!gCm]A#B;M<n;Z*@
$Ldn`Yj3a+NQ[Hn=IX_J*,:-1Vh-7/:9&5^5U6I,2n\7M/<DH)VBN9V=g;6LUC<F<u3/aJ'T
%V>KuQBTgps6J+AWk-##@XG;NGq*PP8jS,@fV#OnNr0(L-7ns*>a:qtss@0Y%I3[n%l-H_pa
X9$PQBiI[MbpJ?3BGuBjA0.USEaoVr(D6Pi&N>2LO_MZM8N?5.c``[cfN2d'#nOg=:DEphN*
D+q>uIA*?b3gq+!WiU$@Bp[m]A';:0_IQJ")Yh)*OE\olr9sf;psaoqs6)''D$MY(Al0`/dkA
rA5.f1.N_^Ehi"6>1?KT;ju2UdfF,KB^#S,pV)6<4b!GlQkQuAfprdp.$L5UO[B`.odZh:XY
U_quDSZ00d-Uf:10Njn9dNCWB5PhbV>?C/h-UJglO!60K\H9-\5N2Ph=We>U?4[g&:ZPa_\^
61Gl2XU?i/aZp-Ep*5=NV,q/1+m&l-:-Dt<CWDuL:E7Tr9*$aYF'n[D*M[iT=1a/P6/#V,,k
p`CL#_M$;A8UQck`Km:8HlP,ip,K]AP'gn1gTchb8m?U,H(]A7DTVcld=k%UQh>fo60S?o/Ne^
85;6gN86`tRthFRUmr#FPq&A5EV]AU3F!=i<\>`5m4H<"V`fKO;pQs5X#81_dPMBUQ2gbXS$>
%8i(&^VGo!o)YR%-Y=$a68>X'0S)r78C'RDe6qI9^=7LlFU4K[UOKRR2>%0M(f+)^$!7T6^m
;/!P/F5-cheQOK-t:O^"11D2oZ9Y`hF[:#FHI>AEr+p#4hfFCloG%?$f?2.#=PoWMSoNHF.c
d\NaU!LJctIY_5K1/,!MrFB35gY59$3t?e*LD@)-WU>eKWqX\=h_k/Tb@7P1X'e-MXfTG7Rj
Gsclec5ha#qFV5aFT/qCVOX31H6oJfK:AIEAM,lQmG!kHe8D;rKS0K'jGXa3853Bjgq@.!0p
_dVA-6/V*7^JD!QWD;H?Kc<;M8<U8@0j/K1YfmccoX,c]A9`]AQSTaC#s$'2]AWuF:1jb0uZ=NB
gl-5UEadck]Agp:@Sg*W>N3iDu\90r"js33!a2U347SbV#9AfdZ.n[ngc.6!F*K76GEs%2Dg:
2#l/aOg(P<.mWM5"*gE=r!"&r+Lp$'&%_G.MKfU!LVE(U7_p+h\20l!]Aoc3`SM.]AY%E&K$Ds
TlIt-)#/N<0K8N`pn"V\j<5%6b9P/]A[mGRAj<SpB1RnJR\,%]AlUU(\R5D8p.RIpH5PfeTcT]A
e31U]A2W"WW-VttI26Xq7!jB]A)@ajak2ud`/^2dVZ1C-dP+bKDD(\9bjpH%FST5XBMo_TlbpA
]A4L^d90uJTH>,7OqAsiZU`knYNsO^/=p2Ml#=B''2KIYC&JOs#OTlS-\E*jjcP1oh93q,_Se
$:ff.MIco&VfJ541Q,W)t.JSLW:d&3niJV!Dp=K,<YtjTda206H4H4):qN,ZD4co1T3&.h:<
)SXNAmF+bSq8TA1ajU%4q\ZWhI:uHafp;r!:;^J&)=NK0#l<bp4t1Y#$d.u>Cap%_.7u.j;1
%tIO$h:'J.P3Tmf`9P)uf=O*Z8)ILf_3U,5QemWIKZCl-SiRp&G6*Va+Cn;8Q_Kb&gP\#E:r
gJiSEc+^;4i0_RZp1!K&,H;_;*``bfq7Xb[pPGIR%=-I;j*bV$G1lEs29:0J?ZK1dZ4bE3pC
jDf9l\`ql*/=:Cj4f.)meQ8^K^1Cft4h#htdG"?V+b+J"sK!`AaO5U,+XB-,RK=o5+DH?#*<
SKcIXL1]A$*S?2"4ZOBrI9ItJc=Gm-ZeCb'.#h81$rnEaAdCFF^KD3-65/Hoo]AUfQ\P)-ljq2
:\W-e<aDHdn&$W;6>2e`,auB#]AE.,l&5G*pX77LJiGIn&lU"ATT\CV10&O"M[h"+(k[#uM@_
iaM))=R7H?*]AYB'SL+W%L^RY''J,Qrlc3"b=U9n@H`F;a4`bKLcLZT#GP20\T*eh^^CPU5a4
oslGjr,,)_Q"+Z#c[cfpZc2l<>4s=l1B9YDV6(l3'$)VCU3%iGWhYL;;&EWZoIBXkk/0cj5f
t)r:YTtfcRH7,3(PtIb:tKY>(("jGFu);O-7f:n;3q0\SSZV%4tkGND&5dD:YjK42?DGXaB,
dB7g%&.D%DCOF8cX]A(+S)%"_uC9OsAf'QAl(=^Z0uU>ib_h4m15ol+,Ul?h'0/&p6._fl^cn
U:p#4Q^.G.+RM%De(t=Cr(L(c-SfLH*T2^1sj2W:\PmF<p!V,Pc.#.,RjpC8kCAY+\N&LM/"
bdYL[9RpAb.Q3*\]Akp$'/rB@Q=!KNIRt_7L>F?FSm\:/lcl-%<DN@=U)FGEr9D7_RD)RPNZX
31TRKQL>Oj=mAI-?c6#b^eDA*FfGuh!t%#4(TT]A=I"DCs\k.sNJK"b?Wt*j'X,ot))gQI]A7r
]A0cK[?b0%/!>2HP8L&\/i#h3Kr\L>)#)C]AXQYm/=U(n`V%b>.\GoZY[$C]A=gB6Uo&p8S_245
Qej;WjZ\I=lbV&nEo<eYDBRoNP$\#X=0e?rN8c0B)'3&8NmLH6]A`D@mGG(s)^:o@%uj7)gb1
B;I3@Jf\Lk=6:o2G(&XA&?j#Dke1%Zo8Q.KO"B.Y]Ai]Afooe"7Uf*:U`SRLFEN=s3HUYmbaV1
M9PL_,>8'$\@lfCPco^C^+C?'T:<\,G;>V9pNAB0JS9MH%F_m4!,en%nRh@O[:iaSS=W'g#c
Wq)43\LmjhVsZ_s<VocM7^BE$Y-^[CXe-s4o9dUiXbF!FF5O);/JFG`akSjMZaH^O+fo/qe`
%7B_Q^k?I(n\iRK*7sR^K5`kYr)(LG$Q'"c4Q8\>]AQnFF'I683nZ2IHjpIH2A@>YlGo<_i!j
uhbN%nKe9[Z2aSh(Zh1!Zh]A\&>]Ap.guXGch'I(a+;m;uA$ab(`agu@W?HGZ=GK%^a40a?&Ze
2V1+\GO)f8t:M/Hn.D2i,N@\o)bb-Olk;P,r2>[6:7(Y6Nr8n<@ch*\c-RJ)%ca*/]AX+T\[6
?,L!lX\=8f9\CQ*'4?Hg5iZS6M*:TF-+s7?]AXlttJBJ`'\&TnkIH2(4`TDuqJ.7)<d[4gKVo
jK]AuW\MORs'tsrD\uuri>$.Y#2aa$jn/[M'IKj<9A7NmKGI^ig-XK`WinTWXY]AI;CF5*DrK9
X7j:YFc/e>'V+Vi=:=:7D/&,>UOBY\[aPFU:#`'ZDr7P%$ohlG+T%B5_6K`M(9lZ7InQB2$#
\J>Pg#F40k'_r_r1>G)[MV2u5k8=F$1h`VtVIk5X!_2,=#RCJ>W^nJo2#aogmYNT"nqK4-j?
kAKr1)"(7]APj/IYX]A&3@6qp!gLV;Hm6]AQE1Z-b11]AP%tmJICC"<@)E<dV2Rg^OVYp&IN(['2
o`^.IOW-[Zk0G6p2!'YQu>!p*'6.N#`@Ul'^?i9Bj<O"3.kEi9<cD%NGKqQ#NeP]Afh>Fm(PA
lkPJ"qT/FLUV;j7Oa6A"eK7HB32N>mp@]A7jNT!$!g/HN-3QQ`GaN\H2+<09a&*AdLJRnmES0
!BRgdFNqqd@3NR(aFfq#Pu2a[j9o_rGthKCEBNs5-&[^u[b?T@ZA?hZTfI$n3*cP?5mD9q/!
!l+sQnk!Mn&<TQ]A`2srpB<88a,i7%QpQBm.s[OP:c#-CS`oJKG-b?SkG=G0Z0UNnYC68]A'9*
j?TOi2#[i*;qGih4At:.l#S!1iTe%!@6,OFuK<0Xi5lk'H'<S.9hiM'(sdYmuEiFRF.0ESA9
?W`2'QPTA))q@\T)^07tY69`j!oJD.#:d@n5gm#mr!pV4J7e'I0lChl=#$&D=ZKf3<pY$[?Z
C$4;Clr<ra$[ftA<VZ@.Io#c&;L9g[I[If%HGt$+OptoiG.YiQdjQeU]Ank=CZ>[+r&#P3:M2
\tWa!Q1^H7lQG7L/FD@9+^G7X-'mUl&ER%TQ]AaQ,7q!-^j1.P&TXJQ0A7/Wilbc@p?O)5p/^
["Et'+i9h4_j7qODg_gA9+BWRg5m%E7SABd^(^>1)>_3LSrc`G/rU0V+Gi5EFHLKQfX(k_<F
[d7^Rb&4uNB,JY-B+3q@e$OB@r3VAIP(GmfpE5T@t^nr/_g%8=Mi_8cLl.i3\9tR4IYfmjq^
mD1Hm;3c$rC+lVUib1t#gknp#<s2aRO#&HQd9O7\A.J-<oCKRrUugc:t5;jE4mp=a^/qHbca
&(Bu`7$3ONr!d[b&YShF$Lr!D('n#A?jko",nOKt%[D2+*4g!O/gZE-=7/2sB6"/N<4h<eiN
Zd"goNqP4XX>'UCc2=opC$'=e_mY;4tfKaG9b[Kn`g^,<j4"Fk`O/AJfSN_?>.&_`&hqJnMn
[aguQE63,,*YV).fRS-T]A*oZ6Zhjp,Po)\Vk=Hd4FdC1,7mN@VA?5l0%q4L@'#WV,\YJuR+0
2ulh@IrR44(_[9Lf\K1UdP5a3j8M@]A8NoE!'bg0N,t=b*GJ[4XiM:m]A.(Tas4oh?'10\6!CO
/5^`e=)-0p]A@6!T88r%C8YRF,;]Ag'MCs---r^@kVlP0eE.lE]AGQ0Nb5H7T$0R@m3#o5&toPK
5RCY]ABpUPQ1BFX[$?-Tk;H$f:17-f\D$t6WOjqg6bW16Rj7EkMVL'ct50&)t[Dj6!fKudf5o
$m*SRrigm&Z0_.W8'\Mnq]A/g=BYrXt;pUSR(8%%*W#:$umtf/'lU##r9KH)JuXlhK-F*.3o0
d&1.f+[b"C'"m5%O#L5knI!UN(0'*S=G#S)r>0/gcj]A7L.<j,=_(WcOLMq8_`G$0rW^H=0l"
f7iMfT$lRcPmT.LdO?uC;<2$c`]AlEIiKl3(nO]AZ`USm#bZXCd['&hD*@s<M&9&l>K?uKPJc0
Xm9'CQ;hl"XajC7qg6CK1%"W)=9]A%K%=5VbFXC</?dKLO0In5!pO8DjZc-</S5PF&mN'eF]AL
Y+!6tc9>t+IEY:rE\[a-0joIu3^HA",.3=tOnsQ'GM?g(b?oB!&qrkJ`_9aef:'2TN#VQhJO
r#neXksciE.i7P^SJOOK&<82UA!++O('<EA>NHD,)VFRNgS.\%UPa!ESm7n!1?/Ge=-kJ_c;
I"k3::13^ulY=QB.R9:NXILAd?ME)-:TigtT`b9p>NS1nFnR3TW+r9%HbqN<RVKZ7:K5`K_^
d#k'Af<s*%kdbO9CKRHXOsSgYqM##<gktHAotKj+QjjUJU6am1?H!eYfar"eP\#LR.:m\.:l
AEUV8ho9M%l>OWF`n;kPTl[Hl=X0u2&&-:H=!.m,`D`gWn+Zm%o`(7cT+*2k.SqA`JU.5,Z+
YPaF+MiC.QI6Z^7Tb>o[9Ec+,AkUcLrnNY/a):`u4RK/=>r7C_:)TYQ!$`]A%^O\i/6WYOZHk
DRp.OCppqhOX$:sb_q[BGjJDX;h3!b</Zg9G3/.Aji4E5"12(*(j5WX`VOmdSTaG/^0LFQ(A
5f;m@8%a8YUlg0sY$sZsCn4<qMGZDJF&nu`ebaONcg<QnJHO2Lg=)`*(nR]A/V4K.'YhXk03F
NW)&Z[/2ijXo%R?l[AkHresq=95=#/6rM!p`pGL(P4nk2.*Q=[a/8t\XH!;`^O@PD*gr>[A'
fu)Y3HCBpc3K/JW7S@aIUU;+i9!h`NDYeFW3a=+:eGQb%pf?Dj$Y#S3jWB&Z[A:Nold<gCqB
BWd7mO:\/b^t0q'.oRdtZX0efUE\$5(ZLg0jVlH5T%=.S&'7@S1POI"ogbELq6Ut2PR=]A4r*
K.RE[-kQ\BmS#Y<HPZs21\&*fFtCN6]AX5[eoDB<?gJhD3R7W\*,I+YZkVbOt),uYt\XVHk0-
U')G\oH/Uilj2C4)!n*$r6kP&sq8fcP*3F/IF@nK`pJMc-@4NQTq^l.!1Ze_?kDn%jIA^C4?
>VP`ka.Vc\CTs,3,_02Wl%]As\b!,Oc$fIG<h)R/^sT]AA*kCQ^qN3(NM'>\\Ko3/-CGR:5M&h
\4VfN:fQ`eH!lB*d/gKod(bQ&O'qouE1nIb#@@_>;aA,l(?J<c)MSnC[N!JN-3o\/h4+rtnY
`G:L*7LS"=4JaLLHrZg4XdS4?2ME?sk>+u$m(SGgr!AK?1*R+bY`AR.FgdDC()^/\2ZSU_<M
,EWSc(6lNW(&oK-!VWfW+AI($Vq[H?HQi[ML$&#blT),K).hK^99HcYX0N<RYSK5D<GpnO>"
DK^9&;f5O9,`YC[_4\#[6I59$!r5UORL"+7hZCiLfn"tWX-e5$SO'+Kn$?jBZ.%*Tg]ARiMN+
;4ZG2m6p@#V#>UpFbEoY%'uuI/Q[;a-YIlVDa.=XG.qj0nYbPdQd$S%ul,i]A*BP>044ljL6c
RL'N3JN-D\O"m'@H@jVFsP1]AWf*;=?^LY$1q6lrRp&Sl.;ceh/;N7@X]A!47c*D;W\b[IQQdE
!B\/uTjqG65(;[@*Xs)0HiPQ?hPFTajc'LD8.'-qoJi0lHC5t4L/u'V3Ku9+o=YWrH3(N/5K
@D1mh(M9*&3!e)oHl)NYOEls1;(^S<HL2*:D,`GKka9CaW#mQta@tq<']A;ArAnaX?6-;+B8o
7rAu:m,`bMf)nS/'([H\'fb'<XXk.7UTECG,!B\b.m_`hZ=n7i73?:G\S&(RV5%A,*qE36\*
0q@E7rTOQimu<K5VF2i<(oT:Y=:hH4Rq54I+;/e.I+eJhLZf=bb\o;G-J<%"9=%b-Bo8b0k@
p.e>@npF%4:g\+2OD*0TL?=mBE@iYO[.3:ffbq/Z"#?b3k9F)pG\cErjf-[W<cJTpL6AR;V1
-XWAs@$6JndF`+fL@,1lKhaehF2)KBWMTh$\1H@0lIoWs%`r5qEtlh_1aq'h4qG0fij870l^
<=cofgP7m@c7/?jFk0W8Yl>@0UB)`fZ<dSF2W%6LPfU$e-,o3(Fo[7AGikJN`LBDs0RWS"Ie
&a>=#ZE'`odi=pTaG>j@IE^eS`]A!?I.`Kb0K-9qJ5'(5A4776OF!n^'$g";5b9uBcrcf=/K"
a#'2kJ6Tm2k:aH;Z,sE)a?uSTPq;76*CV6(=J0.Z^5fUNu/'uO'6(SUqQ6%"grKI'1AAFfk'
/Q`-i.FB2=W"Es8RY3ZUXK?Z<sPnf1@aogKGLD56Ffqo:2S3FFR<-MuH.bLf2S8Ubi>U0"8%
TYi[8EG$s>-Ld)-jVI"qF:?pmc-"-jOGArXAYcai%ZSDo_8'SD#,ecBX4f0N_\RMR=(6YDi1
oae_87KjYFENmahI>,G9bRY9]AOtoR.o<K]A!!Z%6cGDiO7@t<J/Rgb</g)+D#Rb"pn!I>g0)O
igKOGZM21GS<85.dp">]AW!KmMLTMYV)q"jm8kh`_4FO0C4U$17UarIO-+,[d!'8=2F.(A[%,
O,ZCW8$b#o7A_"^RCOK90q4j&e+g<!4_3X;Ji!f0]AF8e<RkC:ZBn\iqY#j#=H%g!,*Dn<!3=
27j***ah]A@4'p<9KrT(2$m2!cgMm98X.(902Ofb()&,TAga8Q:3OW>[lc0bN.BnOS;\VYkSk
\H;j=;A]ASF.]Ag.jSr]A^LKI;C!CW#+I'c]A=3Q.L*#.IB,W?Ic-d8+cQ>6720UHH$ii*XG83pC
%MCFV!IC7#;KY;p#W6i?nW`M*]ADfZeEjc-`4@2$ENf(7^YEBI]A1IHn^LYAQRE&D8a9,YZD,q
*7HQ(\'0Dg4Cl8.F>=;qXi1ZiVlWta,-+\BWee*'JW:(#;#.Yp4"K5*uE7X2j-!G;LJ%M9!:
q/t7US*2F4H>U)f@(7[#_VR$>DXD7c7c9K^)<Gu%g3b-",:0mLTDKZ7BO[TritHI6r\Tr!Ys
Bl'e[D?!g3n)BSO_/g[#WHI#5Z7N&Bq:3O=.ES#A7DWd(;m&'\G;rurumN[pCi+s/mQ(^Y9'
`i9&`9c/^lf`lN_b"]A'C8\-_Yp+?hq,RQh#aPL-Pg&>&"9he"[_!cPL6u5&`M'Xsr_AJiZ$E
U9n9&?jRl<B`SRei8X2B?m^gPshA+4.Fj+qZ)8<ir%/'U^K\4,i>iDo&BT;ie,9>%hSGll;D
OXFJ^(I@;J0kehl<joE16caMrDTpp-tFlP312=#On/KQG"?,$h*Ws-.Oac@"+*55QOR@"N/F
58s,"f%O+iM1&O0HFIYB*_/o'j)P(_'HSi;!)+YG5eh-*Mlt@kC1@bZfnbU!KnGEiQM@rOZK
)h"=HgN#f?poUOlK2<r2XR.gR.$:IboGL*Y]A!PqKdZbaW?rP<_m:K]A;cMOX0oZ_EOSNT3qP;
G<iV2(6rg#(lGq`oki-U]Au;(#.DP%]A0"gV&K>OGfge!L[99IKi_)7d=FZ*(-%?l$>_aq&->T
3'pH*s2,,5n"EWIIoX0_M96fTWlBrSX3V+a4sD(;*J0o;Cfk?/ptL"WqEQ\NnH:&HJhlA&E0
Uknm9p>R#rC!%u@u7D!&*gV`+PH!3e)!DL@4Aa%BhU/a9LnE`jUY[@7cj#6HN'uWB/Y'()B2
*RFk;2PE-1G<8+m)EHX%e?qfCMk@i&=f?lWkRitr6hQ1+NNYt*`o7dR/YlU7V!*5+(&+``*2
fV=A%3M#u!j><*<MPf$SEGb4O.Ug]As4'kg:M@2n&!o_qW4iOH,Qbe!7:0KFe9Ioa*sPj=tHI
K"5=;j-c4cGd:S"%eDI`28Cm*/EKU.f[C0a!smNmoAP;>k(CMU+_St)NV?;2\,tck%>*iJW*
bJ]AGg,*Pj`@ih,:n'98q`W+PakZfedFeilJ2S8%V29/md=/r6Mn[J%D,0R<d,:'Z=sDS"C(R
se#S*(/;:QU.EL.(JLL.#`*+7-KaiD=Il`f4',pgKC>>(/ZCeU%<+)8`N#G\MnqrYc`iNuQh
"iq5jCS8I>4&$kJugbL@QRj6TGM_E,u0Zb,tuYk6bMH:r7X[CFWMC4`V&<5QlW4nI.`8E*a%
TgL=KeQ!14bIK7cM<U[gDA1Mmb+]A9XQu'ZCK2OE(X!88678fH&4#BH"N$N<Am,@J4jbIn"n)
CnS?KNpl.'*M9f;&h25le^9C$/cFi^0j;E[rq:5ZSS#<a:h!ho!,P3SS4'U-n[B>J2.RYu(0
8[BCD$`B(I>EbX'e"NB0PDiY.<l=LX##4I9o>i45ANr!BjlX]A+HQ*g2<$IO*#:slnEFRPc_1
qG*<@;4t3b.VAt*I;uF;(i'M;XQ#G<1T4g\2oq%dBs4g?ZeWOVM]A>QF0G2qTmFGs\S*U-tX'
'gSp-=Q7]A]AfF1*%(-T,S1F$##'iZ<I6E6(`+29VFEO.8K?m\k?^FnEEcp"iE+sci/Zm;jn&b
@+;+2,I04U-NkGKGD>5OTFM/0?A__gHs4h]AQI0c,1!=-PF/9>hY-96d_>Qh'D>$&pCD[s[0$
L?ABtKE-7$"Jp5O[q`B\SSg83fc3O#,C#H0lgK#OJnBdm[;+"@%CueWFUAg*s5&(,c_Zm2<"
BtR`["hK;*C"e(&'D+5->B`k$N/:8:-m8p=$/d2dUi"bAmb+JXk,r2/CltUn=OI_:H!:[?j)
'3b1^0R,@``j4DqNC*$DF6apIq`YA0O82tjS7H1[!;WX1oc&]AcQqt[8kG_YcDRccU;#T\MKd
$><td*077@h.T^@%NHoW=idj@Md**nQ9WDYXM;SFhVus@jGD/KcZ=9Xof!ro=Mb'G,'3.`Y2
K/%_W*f=DNi.=g29;KqYe;T%4jTIW,WVK^D7:?CAJfZNe>T@/%A3;Ok`C;5H"+/">%k`cXCj
,mH2S6G^*TqK9A5NS&=2i\Q=?AQ`_lQg5XM0?bIE<,a\I3s^_4#*)&PdJc+ZLtjuWP-gFA7+
]A.ED286?V9ACgA`06R%p5I@`.8nUL$YW)h'#r<lgk[9F8-=Qb;Y&["QLKY]A:l@gJ&_FNhWDC
NrEOPs*)k+W*.F"%kF$aL!`G5&JgDO)(+DBA.XJ-V#EHXOeU8tJFt.AH6g]ATBi+#Qi1$o1!b
%-M1WgEtMrS!$Ap6Z)@*t5sDNeTHri2@[;Xe\KLCUlI[fUkl#G[Ab34+@QE7e'7B-h95J7/e
@1.0b1oBB4gp5U6^@S#*sC(3"@cp8EB6NUlt9S$=PNoe0a4!+Z\:;tG_`8Hst>;;0P\FPHoI
]ALK3dos?AJqg@&$jf`KJ32gOS$bbBS%HgOF3;G,7Lo<5#S-do-6jV-a=?BKS^2cIm$%]Ae`8'
=&;.!rtAeLLG!.0\nY07YQqeF]A*N"j/@qE6_L;?kU4dl14*ShJL9kG]Atqa7shcrIrj;0W>7@
jTY$#f:DWRW9ln-r6MTYL^9hQF-;'Og[q(uN?YViN8O)lObDQ=o.toQjm@K7pq2;YhY\KFD7
aM)#C=!/7G`_2qe^TLSl9]A&%T,<<U1F-aKk6fV\gAgdl/,(W<keZKLgC7T*=i7q/7e1IaQb(
*39&:]AlarL*"+[KM8=mKt:G;84WVA]A)/KOFF%Xc2+uNHK5W%pb^9jhUdp8IPM'OYZ5f1rBfk
5k">30)WiiW1Ko!PjonAj7M2dPd@peN>Hs-OZjT$+5f__a)29.k$Nr5Q%t==KF:9-Z!lQcrZ
o'o]AI/-Z+rNA_GB_?U>#+3%qMam_Q_/=)o0A+Jg?<">MhJQ86(V5;4HPS#>OHE-5`,*@C[k&
IkJ;g0^LakQK4>5uA9'j5gI3aP'-h'KfknMJY_Rs4aqWboG`)aG7\mZ/*ZFWXi!N\R]A2`dIW
$bgm29G)\>4<*Q]AuVl#g9_do+E<F!iT8!oNa%5iEeI9(`.^..c[,"DrcN,j"XYH$:Wqkuj4E
GU[_"]AlmgKr1FMrG`QAMOr?C3p44maF<X_VPTFXHpS^h0jmYdW*1MU1dtMXKpls1;!fbT!SY
FT@4OM!?DB%6dQs2kYC&p.p9gKhi>HAqI68b8*cDF%&F+<;4BB>W5nidJV]A)D'5sj2$I9VcY
8`[0]AF$@lXrdqrtUl<.R(%^(8;SGHHQZN@@Q$2pUNJk,ddH@lj8XiXI:S%,2f[;%2GK2'g-u
>,NqMY!>9a]A+&1I/PQnZi^Pj*h7o71A]AkJES+rs'qd1IT1.FHt9?d%\Kfng]A;bU4:Z[Ps91+
DT$rKu3$:ZEDqT*_oW,L*c"'9gg.&9u*WJ4HiD&^*atI,&mdLXoFAn2[Ekm#cm'6c$Ln*9qc
d'jrmN;h+KPL>!6-u0M>A,P(?QSj")h\Gd!s(+:9hZ?ln'>'Fj>c6JRQ`)ngm;ODNOA"a-:F
O;6sl.jiYOCZHraj*DsBQn-/HHm+_AO4sTZD5M7K,"?f_a7_A.,EN+D.Ug3_eB81Q0a#UV#*
Ak';sj^)_d*)-\#0PtZ!!22b0f^JMR0"8E=7`Hf`!A)dnAtVg-5&uYM6gb,cKHRAPLF_L;oC
?NTVY<,)<R*P_C,R$tF8Db;hM/[/ondFE`>DoQS(8k.Sq(iaWiN1;\o8V6I/4"_fgRrB^EXi
VdYcHuL8r!=QI;J^03@_W.p$3]AHbkFB@kkdA4dA*jgg13Rds>;*r7-a4$_`5<3M=q2Cng^,t
RSjN/Lkd'&eE`VX*HKg=qk\bQPc8u10<Z1<ugGEbtDP<HeE7[X`h9&*J1=4sJN6VNe*jg<ni
TE-BO?.i\X,R_Zjbd]AOU5Ol!q$cYioF&Bs)i/N2!@(`3KlSiEi9p=KpQ^boM>tYa@-hI3V_[
6#+ZT*u[H=1WsAs:tL*K9`=MskZFZo]AiDf-tt%6sk_RLYt15#JJj=jhYV$QI3d/USotTS&Dc
gXQLB9<DLFY?Y:,PlF/u#qR1s_r)Kg4eNYq:.f4&`8EQ_8C[W-bD4<M$"0'!Q.7]A\[-rh6?/
!)70L7#[r]Ak)2jD0b9;MIC$25:/GDI:!PX7c1ePHcLr3Q;U=V`]A,;dD*okC9O5J^T%dF*_i(
ZNn`pM6[6A#e?eC4rBBGAR_Ynb`@*Bcq/T3[02Nt:W89/9s6hObX8[bn=U/Db<R>;bkBud-k
Y\?r7Smd))T<+0NR&XgYpjiG)cLAU[U"6i&a[a?0jucB3"','sL@%1T37[0Ub+#`kBWg0Se?
*=fkRrW&\>SEUA3A%jQ$[>CH0Rp_GA_g6P]A.Hj;&Q)>YLD$Xf]A+P&`0'6fnqlCi]A`hrJF\Y;
X-W9`#\NZ6g$:p$gS>T.fpP1\=WUd2\*'+tZohq7@/FhbQ)$<WHpm6.QdZr3odgd)(+k2e5>
iO]A&g`8u*r#QLP9@t]A-arR29.4=6=TP_jJBgGH9>P%Rk<nR:u"0l?daECkBgT1Fr+:lV/dNq
X>%TTR.l.jlQ[?=^A"j<EcXtYet^@IT6[5JVt]AOEj;$G9k;Qi'2!`9mF2[tfMB#']ALYaq78k
\i7)4(^Diu7Gk]A=%ql5*CfP;`#o&]AHUh')q/I-XAJ$H04,L0@g,#,UGAke^HV>(cC.@h(?e^
n0>ZaM:>SCf6N8p,a&Wo,agAkM?oCS`5E5Kr=+B=l9Q&t[Tjo'D&Jq8Y,>;)UJYh)2S(4m#G
If#J]A1PUGmk_T?Gs)^jOj.nM>JacWS2pU]APm.pT`0C>,@^EZeU[_Ed`&1r_ei'V0%+Kd[/g,
`jKl80bIGVrgPMK[WYS\Z^em18i==P;$!f8sA.QF<[Sa$$_aG"[\)=WI8bu<OUC/Zug6F"*0
WG@6lYKiAd5P)Eq!D-*s2=&JUi8::lqC+1Mk$QNEQ]A4Q$0>'6u/u!ShA0mu6]AF,Gc1,2HV/3
52scu'/#WNTD5*RIShAj;+$urbj%[UdhU%'^b%/9%M<@JC`I@GT(SNF91\"$6c*$]A,K3Z/M=
eF\Lh,&rqMP-X`Aq\n+)/c]Ahb+1(Nqg"ncF2J"QU0c)h.uK8<`5(S9FY!iUg%k=K1$3R2G4p
rcQjd1ib,;0,N&\]A)j&0kD_2D?25\dn[_o#9Bcaa1K'L[JrX]A@7qo:RP;+,2<!k?\n=bF7;.
SS*0VKsV8oYg!:1.d9#ctm.'rAZROS))Lu9MH38,F*++5?Wr(Y@)>$jo6^.R-HZLd#0LY\E=
aEnN4q/G#Ksp!DO=F"4;[6^7U+-iM6t"5(+T>",%*\*N(+Y[@Gt2?g;r0*8_^cX'3)E7g?o)
pb6OI?8+FIi!I'&.]APC*jDunG[s,p\H^X^]A)1H$RG$R?3]A"QG+!6CQ$iBr>%D\n8ad!T.%bX
A]AZ;Co4f$l6#^4cmhf=Je]Ab3R>g,_D6P),,Ib3rA"G$/s)O?O_MMqWjG((l,eoXRM)F=.Gd6
XH'K^'6e&2%B:6c4<,;_SM2W(e0='0S)5G:p-1$A#p$(,Z=+GNuS6IpB>i]APd)!$%WMXBWeX
+U!NhqmB)&I=X!ks[[DV"6l61X"`>'=)Gb8*u3m`A"l6`9u@e)YXO]A[m7?]AX'UYjM293H6Dk
lo1V`djZ@g%Nq5L5m2):SdUH3SW8ceb"YL$2QZH3G',adK:g1E>pD9%,pj>Y>WNMZn8K*F[W
[W_s5"rjV]A[=?Y1Z_$`5;.VDBSR8[Bm+%FX)%TVegjNd<5[-M,S&[;;bZ,D6dt=1U/q+*M>4
bn62%p8+]A[6d(Rn4a,2Vro<-kI#ab)a\MNLX&&5g3X`D6(+<d1Ja^:%C]AQBIAZLZA+O[;4U6
qqT/P&inD)dCgMl)?2MYNQ(nJ]A50qi-'cN>fTtb$"2H=[aLYZQk=S^,Q9d>)eBlmjsXgP&+=
2MS$r:m7SI:gK>j\$(N;]ABc9hQeT)/>rp9j?Wtm>B/u]AJ[Z"FKfDXJ"X6LC064BZP>Ru:&Nd
uR^X8iUT9r*,#D0^ck]A&n"/,+<de5,T%dF:9n\(/&FmS'R6bO#ho2O:C;';VlT!JOT,!LQXH
da,KQ>8VJ^/[eW`I*_4=U,=m[E;;j)V0))4biZ^]AGTith7+9tD2oXJ9mjJu?iV'u!!UgcRnk
rH;M6#FKjFO?@d6PtBCZS!I?.sNs/.Q\`Y6_"?G#>*Th_ZbQbV4?>L8Np1'n,1oka1mY?l?s
8::MfS"28Od)\K`.QYd'rQk>DHH4@]AT;H)>hNo3aKhKqZejb<G2H#7?EE+Ot#@"(9cXPmKfj
YsLj)u^NqfHZGmK12"GnU)UE/dOIGGG.d4p!:<gEOMNdEtrcpG`4M<\Bh9qbB3&r9[BL'JGI
`0dn>-_=6#4P'0Mh()EkZ2e:#DBP-EC$cTAfH>T(2%<m#Ha9.)S"d\"KlKt`BE^KXOSDoJ=5
XADW5(L^94ETo<Z">bM[8toho)Mh7f9YCQ\0%7Fa479>]A]AI<!uH1u4mAA'Xl@.B)E@-91kh<
T.YNR>T)mQ?/<*e%K$4#H`N$V^4EVd7:L_83DK+fF8E>#oS)$(rC*57jdP5);L3Gn@`db4nT
XV2PBPduL"u%q!mQpcu/Q\gFe#S[l`E#:]A85Q45d_U:hS<^$J4$+UBWl8>So@A)=d3[rY>&S
2Xi6N<8H#`AI?28SHaU`Ii$<qJ^>r7F=SU,$ZhDN?3QM]AA+k^LB29(ES$.9([iE%\.YVZJ.[
bfARFuoN3/2NBl1f4lJ5fdDb7L+4DQqI?DB2@AEu1,^-VCQKAYKs?U*>:C&2"^%3S`cq;!6+
q07b7`5^#n<Q,$+S2lOfZ[FeWPq!o!"Cgjg0[)c'm1N%CO`etF1OVcK)ljf:YeI]AqI0Q\V`n
o$S6&6AO^ujsISD4<:VoZ,'V8*ucA,,X2NQ/;e4gFKn,-Qfg'NP;2PM=1of%g5PY8-Mh'::r
*82NT$%<omaJ#S:ViHXS\2U[eXo'_P>$Re4D(*Fj_,.I%@EaecpOdKf6Eh:e=7NBi"))LZ4d
3A?tn41+:[ml0.=N#4\cKSiX]AD0$O.S0)6&bI;a_=g65#'k:1&Ir:J%*<l)Vr\[]A?XsHu!ea
I4jIS%t0us%d#snK+q@YPoQhGDZEIC(=g2gU"O+iEb\5j"p8&VhKAL<mZ(`+@*`>KlL8N-Jr
naPkH^%e.QHVpo`noq@I!=V.Z/ek,%^]A)(j\f@0T(8kCM8jC$k/*WS6"Hm=X_hWQq/5+KUoG
F-+_PPo#MmROe*@]A.IiK'gln]An%!`tIijC_YD8rT5[[+&l]AA*>Wu7jAKl&:Hgs[-_8i;@I?T
la'1NAKm%uh^,:ND?QT9GLYs@_4PNHEZ>W\d8WI1(p4[Q8Dh9;#"b%oJ0c9=FIXrZDblV<Mg
fGcoo\1Nfj6B=TgUd>i&^iTYBHqE[?>)_0<k[p9\p/hAUcW-I3t$=^-`H^D=*mu[hsO\E\p9
]Af<hO:"++F_:M,%2T]AhS49mq'Uf&nB.ZCAJ`G%MjQ&OGbAB,U#MR>@j$?4R;DJZ$9-mAGL8X
7D_cj;0dkFnsktc7e,OD!?b2/%1u0K]AK4fgCA`+tiU4<D53&`-8=H4B?/3Uda3eE)k.[AVCn
L6hf+03+++dAGj%R2]A&Ui^e1$GNb\^+)0qqFcI6>U-Xh88!hf:'MnV[0j.m@Sb,3:or8a7Td
=R=o-o+Yo8/-HEGa:mY)c\$4B9Y@CnF%P7r;:Ublqps1G)bic]AiMq8aAQ-GA8e>XYlc7U`FG
;=j&@]A3J0LqOAF(1j*b"22(KDQjfB*Kg0D`-G&H\rQ5c%fI5o6DR!BeH'KTVm5%'Y7,Lc<bL
L&rFKD2BRe@(g\VI,r^k_WNh\n7[;S0sDlIUJN6RqPm^F_&PX#kier/79-SPFJ-#ld9CA,CV
?HWI!$HSN^s(Qq34;<S4nMBoLa/p%2#R#9Q'h5Ar`f328R5OT+s5!*u`6.#_"`UJ)=NB)G@G
9LU2H"JEE[=<4G#8\4A6^j(o@da\!TYDMf$>(<:cTX(Z[=]A51Et@KDXm!CP59\F6_OG<Y7dV
j,61;a`U"3gpU<bnGkk"9*a;-*EO\\m\sS:U\f35MqDVI+liG9GLL4O97s^,SZIo9eWHV2S'
Rba*N%I;4h!To(n2Xog9')o%iOeC(eYpH33h-?u3j(f#O2K+hC+gu&dA*K_'nukBIVYo(>;n
\eZ3dO^'Ca48]A-1'^L4O]A%9dQQ]A2n9b7o!VU*H_,OH5R:1I/bW[-7diNZ(k]AXnMH>BFAYcTA
"\d-Bs/7n9'0YIJ[_Ef$/"[?Jr8us%#'DM6\D4I?a@UANU2Mm7r6UZ"^1R-(XqIhIkYSe;=8
iZp]AW-[[#@S)SfTnZ5hfuEef[s%CG&.h@l<lk8)jL1*E*K0>Z/M0)aXs?Zlu8JZq?"6]Aj=e8
=1h-p:HA,ReJtQH32#F*-1NB8eXp)ase0GE_BGL<&-k]AWkHa;#!U_3NcpecEF;TqOI_]AcFG/
@>uL,th.!,^>1u(]A/We(;kDArA)Lam)YM+F@aa7fYr)MVDL%7,GK@^83Di(Ssq0FO;>N[1kZ
WN?SKprXE$t753gOU0"1c+mP?JNG-?A)D>A]Ae!,ZM8TFLCBgi/I%REtZ^[M-j0.7dUoU61#R
kLNj^BX"5oCs1"<?.+C?l:U7r?N[!_R0g=hTjrfG2E;>N+Z!$o3LHugUMQ5e*?NnS9HcA541
7mFMBn(;L>A;Jgp?E&pBE,X,,JRR[_mgs?Ih]AZ?e8p:OF*fnSjl2cPh;)Deqedu_:iLYOAg.
`SjMtgKBFMVkUsU!a8J`Ai;&Ga21I5:'4`QE0\*_L6iB2O;MHELK7k:]A-r+H=OeS.$=EHTP-
r/&/mO22/K&_:K3sltqCbQ4ZqnbN+il9HhlK?r^O)V>\?o1Q.PU'Y%6ak-_/M!FR4&N#QV]Al
GRX_o$>bW+!&lMr2l:_D:P&si(('Q#r[oXu':GMJa%MBrS6m9W8.#?9-SI+8!Y'H=%I3k0f>
d4XNrlRSibAWZIH*usB#D8@bTZuV0qj'rE3!uA`s6A0(Ng:>,L=QPHtL&`RJ6Nrg@#R`#8PU
I7&,'.UcZ7>,pkjpss8Ij^kgH\ZAhMf?Ld'3Ouqq\&jR;0]A]AP1;Kq@7al7/(t(/<Z479f#EV
2dgs^^?Q]A_abq<1+fDBZ(A2-tK:Su%!*r>*LW'uUB@Eet8g7H::$Pc2j`Q\XAgR5FES3;U)N
-CWefWc*MGRLFi%RF)5IcZc5,Uod;b$/F\%a/\q48/8TF]Ac?7(]A>aoNChOnI'ZEI*+s(\H^?
Co's#M;M:]AqV&pO$7bZQ;OQtWq6oh#6cSNWie<VWH`PHgX6[+fs8'fiQ2fU4H?AAG,'mqPD5
leF$8E@9.NYQCZjgqm<u44=!KA+4,4NuO044HB=K%\'TSlN?<2]Ak\*%]AKX:5(1+m.a(cQi(G
%7!lcMpI&T8l/<M0=.iT_k$?:&ZL4n&bekPa-/KQQ^fi9K7SG[%8s3^<)kg1S\<-\f\1YGY>
."C!=,kRg5Q'qs-hHdPfR+<S<a'JQAX;]AmT4n[KM%F>g:]A(\MPGofe:FE]At*4[V@%@GrkE?d
El!u</3E]Al+JlR4bj3kWM_3kO*!.@V50>C%e9tALE^Ln'ci:/iHW2OJTg3(P`LQEl:M^X;PU
btX&*EMlS6QK:U(d-h]AYFiE[ikEg[Ys:;H!r4WK*NFH,:d@?u_ehD75*A5,tm15*ZO(>NB/[
+`CL_Jr,JA^/(H59RIk)/)SP7IKs^GD7^3$#2UsLd0PNq*`Nk5?Fa-APe]Ah]Aqc)B3s)!gkC:
7`hjp3SSW3LH&75JR4`1S?$_PKZ1QaCSl4r/,<:n68s7FZn*Ph)C\J?)@]A0d+)Qb_/t>g);W
IT"6kCL!*(SO.M@(_RB%%;M>k[mig=e#YO$7J8Mi+kNF\Mn8R`$1*3p.J*)sVbT2/>W,+"A)
;DkGS-*Tka8+(9W7CLS$"Xe3iEsrE3)#0ALPPjbhphJE'ZL_Z.L"=ch3i/Kc(lWg7;C+A"#6
+$#&(biciKlMe:;DY_+ptlcV3l=+uE*50Om.L[;d%QncTB`-mmC]A2Hm4D"k'M:A\ro*53EPZ
E:+QCKPeLZ]Ao0<5m9nFQ.q#95g?[SFJ=Se5CLK@Q,lRjbGQXm@fGB:InoGURkRbBYKh"2k_'
Mg2T?l@ImA3"Os#M'U,G=qTfndq`b6kEqUIPn:6j&tK5=pV_dIX\:l@j=Q?;%dEm*oP^dj-X
q+(6+G.]A*akFg>0Jn"pS(0#dHZ8>jTNM%$dG/)9sODdbO&m`UDU6H?ne.rd%pd@o>'kZ+gdY
-BFHMkA(0T>tLeLM`TO>#0>J9<'>[hcdcVj]An\t7Z@sQ.H.oUbei?^R]ApS:R)7VIMFG\8GK>
P!>tN5l-f?B8H?W5]AB[$?V-a'BN-!dGXV"pbKM1<BuhqpVO:DM!T^9V3t$Ys7]A=+,md8]AM$a
A?B"bN(qVp:+g^XoHMr&"Re9G7_UK4JQ.fbDX>Z<P@W0rdGkWh@pWd,?+,Np'm\L!';nI7GO
2,OmWC(/Asap7Gc8;:pkh@/B:Z*)a!?+<p4Y/gY6/R>&7O_kCn0,L8XO[heS)p\O[+Oghs-V
qY0=J6X5KW\9C3J.U<V;6#qcfI[5(3s5^ke$cuq[]A4f1CA2IfuRiAao5UgaQg+@:"-gUs6PM
oWXn`+`^S"?'.FneZ4_QdmYUQMmD!]ATV1<6K/2\QM$*d%X3n^C)/.W%"NXh?bTe[8bce+]A3-
kSg-O#C4?oV)B27C`"%+FQ7jN8j7VpgRd;2[5:P@1e/)Z9eVkNSr6@jUb;!:S:`Pe8U2`g_?
Mh)=rc-4AMIYY,WQ;K&7%2(&uBrWnPJVWMu>oa$maO'$f7"[=fcmZ-#L#b!4o*n%gG%MBh,c
E0=h)J/6Z-Ab;J;Mh&h+Un\$R35*KY=K`DgN!-H;40$C5J3a9Gm)u*FBe4f$M0_jRY,#I'ca
paY"#d?HeXX;uPE>ZFRo*U*#,$1jY5*WihUd^J5Vr\,#U%?KJ='lR1tHk!))M9K1ch`aln"?
N'(dq[KqI]Akdg6bD)dt9lp1\_LCicLFpDo'En)7'>C_W$#</ErIng*7sY/Oa;AKa.Wp*0F=l
Fi7Q`7YAMV-@7msPI0fogS+?9%N<LNS;iC=tPUK2r(\Fkb3f?R^Vnf:Ld`I#stSK2bD0.0:4
G6/Y-'hd-!DhH9I,d=3FI^Fst!`,qd9*PT1+.G0`TX7o7r3%?3jZ14[1/Zi.LK0tV,HAPko8
*ul??tJbj!oJN8+ZhFImO`j+(pHJnmqH1[&OcgCIH:_g0e^?-@)fFiWNJ=`oUMTT0WiAs$*\
Al<mE+TMUijB2.%#NQ3?Ccmt/4GM<k2Y_SU*IcW@^*CVk+L)g0F7Abaf3/B4/JsF`PUd<;W;
X7V>`UC`RXCjAa;'TE*odmB?_=1"/^Rp82XU-KUP=_C!%,/4c)IY6n\^H*(q'&8e^g#9eJbZ
Nd6CKPhq9IF9f#eP>#B1qbm>T]A]AP@i6triQ<ep36Ubn\BubenB+qLNL[YWM\Z_QcFQ9J3LZh
98Q=)mE]Atn9]APs</r$[696Sm,daT@rmRUCF+t<D"SEn4gFL;q6&<&!]A`[[`(7F[o:(]A%>;72
Uqh)("Ce%TTbr,td`,a%\/F7_nB&lV)F]A8bNgOGYD!^]AuB,<o/:4pbVcjED6.:QM@C8h]A@QD
g,_IQ'8pu.'n"Ph;:,rb0X*q7G<&:W187q+;..Y?%-.;,%>HJ@Ie4_Et,L8Vgedm;dF"3jI:
i1.tYDa^lAu&naR*Pa,aW.4HIa_K_Z-fVL201@UBB,_CqSSk@J"<XFd$ChZq"I*S4PSZA3;s
rh\#cE@>6UbuL\TZogQua'h5Mh@8'7[[2W;tFmh9,klF@dMHRQcm%ObS;JFf/d#Hf^=-?jU$
kFQ/UW$oh@Bmd!HY_.KKBo@"N1P-K`k($IR`Nf6k_WktD_E_k>1ZZ!$^dQ-.Z<GZN*?muB>%
AXFBuat_ObgcN76:XOo+)D"EQ\nWka0S%MV%UJrmlS/gV8,kDh0'O"4W=[^b+J;[@+>R'VDC
%JgW'.KBkZ6mV@6K01.T4V)R"mkMlm8?t^Z3Xe)u8giUpp[bp#Alr,N&c?rMg>]A8cQ\6C"Q@
Vo(>mssR=XlU^KNES#59.#+c-MN;$NHH$/IgCe007d)rd0c_HCL^_>CNt-DpuQLWS4@IiDUo
&$7@mh"B2sCcf0W<lLKZ$:3eX?<1,l;"Y`lF60jh-R8I-)4(pL:@3C?gT;L]APbfl.@c@<gc*
Q:33r9X)>br3'O+p$soO#:3r,!jTO-<gW;$?t`<k>tAuA37`.Xb8S='!ujU<`r+!8_sEo;ii
W#G/J0(aE`(3&&p4kl$12F\i0s:fn@qiqFQiJNDD@JOLDrk%9(Ks`Zgg5&=[OVaAKmC`dFrm
<.R'8k2$0j%-;It<7(bs/<ce(l#p4XH@*2=h&:4D$lbeeI'AZaK]A=uo^?BCM8fWMma'VD[!T
&sO[orYH8&e*kts04:n.Q@oj"eD=4:=K.R[]A6;c&TfORAa<LD/(eb/RpKiZWk?hk:6MO'#a7
fA/h)]AE.llHFATsh+)e*h/d!fl%oMILAKCr]A5)D"eQB`&%FSf-d]A`NPUa?Xs=H]AD2QPTkQ9Z
Jf@<k&q;F%NSI#lek1c#;G)Ob\D\4$&B;$D(^*`5.+g5H7LUGoD9OiJY2$d/3Q%q7':<MG-f
AO`=?3]Ac\e/XFG2!j[!A*+:6oU^>kDM3=X>);)(\cUDnbqckWEJ1\0\/kEjkXdGCQE.81]ATm
HZfm7Ch6#hQcamYG@"\TMU,c+GE>j/%k=VG;>%PG[#lb@A$Ss0r=GfGXgChq6L1Qr)e+gi)=
4+'>c%0H8VV-c]A$eNC>kZ[9B@5Rfu[)C__pI5cT77J)G`lCS$g&7l-N5."m4ApEV8$d'2N&`
Oq8MElQi#5H0OPFe>A4s3=\kH@D#hBa,?>7G9Je$O-S5^tig=8Di+8u'C"kjEAU`m-EYq'NP
%3YJVdW-5m5U#Y+5LQT@#R#V3j5pYAf=HpGQpfDrg=[^d;O\M<=l3J_7d3#g0XdDT/#ak5TR
;Au@(Z_Vp%qL:o9]A8APMW[brk?5tk_JUZH!oC&i"s3pVV4GfGIR*[l2-%4PFH=jOl2Tl"V;E
/l<NEKZJ-_MV,CKm:Zd:C[lQ(Pd1;+$Tu2Gh7A-X>1N[HX77!DT5KG]A<.dGs1<k&/gP6YF7R
CE^m]ALfVm$>5PbmF@Gh8+[mo-]Am:2Cb<PRJL"5QF+-*>#q"Kr\g^5"*PP+VWNf88ECngA/q8
L@3ES!sk(!5Rr=NH]AhBWERNjkFT3/DTpo*4&QiOJRR`jJ(PrY("PgP\O)LnHOk=OS-[iak7N
Ht0a+d:o8lP$Vs\gNGYP&iTR?N=#48/lp,^3K+']AcNXpW*"jc]A@rZIBk\<=rr]AKC(;+mJ_,5
_U?@G?Nq5\5JJ:>I"7)fSj3]A@k,'Q!g!S5)NW"3[#LtA3lD6>:Yo_rY6a"350BTZ565oPpYX
26Ksn*'RqX`e:tHW!8!$U!T2N0NY:.C%(om:TZI["DDNBgs0_BSd>$p=!dEr_,/3NFRL$L#j
i_;S>YH?9BliC`b417Df=e<rDsK(M]A';jF&T;X$Wo]A=0>6"Q\Sb=7Jh(fY2G,S2#``$q;HE*
/LOR-SYG*Ib(fU509PG\kBW:N::Qa>5$aA1"N]AkLIunD,B7)2!U,bR0rlpHaCfI'@V%(uOum
S9!spV#eZ8K.hDprrQ6Gs(G-LG1!/YrD!BHs*qKS`sckW&,a7>GX"3R$$F&7?ZR0JPE1+2S8
;ER`csbrW._tJHPkB*Yk1;fGO7hU;!oue5JJ9BNEcrP/S-sH3Qg;Vf3BUW]AEMoeUq4pJf=`P
1Bj*D0,C)DbJf-)83%,32)DO,pH2N.uC_/`m5\K>$W^_0:0@mIP2LT)ZGEIsI(EU\9JLsJ]A0
.!8tHQ=[18Bb(8-:?=ta<KkjS6nX[(u-Wpi`g6EO211%$<i"d]A.\YJ-9H]A/Z-"U,5K%!Hr8J
V-HL\g&*\ZLDR**O#I>A=;MU-adC=6R43SBF`@RcYO.s'7;BDioJfR5L4IKUeIV\>(DaU\*E
Z%"6V4Z$VqB_4kZ+A1/I*99Ved[:Z[AuZ:R=XSeX[$R?I+^Eu9+H`skl!3T[+-k-X[TN<POi
>'VEmb`;&R@FQ%SH9%(Bu]A;A8uj*[qIR:WQS*GU0^s2V&qlZ&YLI`IV="51%s]A9Y)jPJ!"/@
X!.U2u4Uo#/IZmS((A<G_;T_`Y)UGm-QTXj9hEPC;L%Cf3pW-=aRg@A_=o<]A(Fn2JMpH*?H[
sWtnQmV<gLOd$2hg(obFsVb?-/]AW=EYfs)o6"@3L@e@Zb458IIo%.e<@=]A6N1k*^AYI$oIGR
J*HF5(2.MJ.Caeo70hr=[f3S8Y"'MXVq.ZG@B9(q+=n2[a'Y-7K)j/06K77/ct,OPm,hrpI'
58;^3W%f6CB`A.j-ok5soP`04?dj;ccGeL1T0/3s,P<1#Xcu>h4"kIf/9u^E\=?Zn9rNE2qO
,JX`/@d#$Fng)\7&8Q[Rh`3s5cdrh=]Aedi8&kt!Udn3\Gk\0.Pc?T5(1!aM-n"$i8:"Lch*)
[ROg3D9T(S-ET1aKIU1'6D!aBKZ(NAaK7-SVde0*en;6&B#K-ocS?1*?CD5#j>8EJRr;7.g?
5AbT6l63^RnU5d*\m>o>!"+fUWk-'TQlZ37QA0EKf<ND&+73ic1=hhU(IBV8oeEef2)$!P=H
-9<eZNRGdmUKLZfY*S!8#F@OTsZ;@^G\P><A(8N!6Xq8tEU<LY2mIV)FZ8>Y)@X=Igt;4'cD
C.OsY`aIeWJ<pDd-K`#GW:^I'Juohic)b,'N^RiI\o%GTEqaaSme,4#Q;92^Rg/G@&`J_$[l
o82/F6O.IGi4%nT45OT/^QeKE'N6,?'R]A\%!n'DSUa]A-%8T(PB8ia$V)J7I-OZAoJ!c52;K-
XmP$!A]APGYS[Z(%S6NWMl0<HGk@%^LsFnXIG\kRr@r'b$GBF;(/`p$7A6OudbaqQU?Z.i$nJ
!b)%>Q#pg<lUm^[)nac,GVWm&5&)j?5kr32_,\N0rgct]ANIGJBr2TnH=BR%o_Xcade_7UVKT
GgM.7o)$pZ_E`1]A]A4co[7%7`#0\+N4fg&^aRp#a>;[;C8q;o!)i)\GsLgUDTrN'<QpHG&.=u
O,?`:<+dEf#(N(?24&"A'9$936q6,<\)+hpor:..p4lMAarNi0[V7L/RaRh#.Gc^7*NT]A!YE
WB9?XM'XCq:n@\<_u=;9'Hb7N;[c-Y.a;\B:h#`Z-[D7X!i(qda-mZdJe-O/qNgX!@A/+5LT
feH<gK-k5"Q&Eug)V2r:QQ'ICAl/6mIa4hs.8Mp;fM(=S-3/`:%EScE<a'p_p.sKAHbilToH
B&7=GYJ`,9G:Cc3IGdZe/_`X!;Sf(o3_M@ncm/OKVQ]AOlimW7c3^o5g%T(7ga89?%T/.6OTT
o2pX>s`9%p]AbT;K(sWVJ36KIZA=(Y_S&Nn[Z)-S;@q;5S>t,)A]ARD>QV22t_+o3WFR\6(l+R
?,WD&H\SMuV$BL\;+*V,]AT2)1MnEQ:WYeA,nS`NbC-%*?3u,pRL<Y,nG8_0tf>56.3$Q0<I&
a5FR>bl3qLi&^8-)K;oC@g2p!PF,&L@?k"jAApkPO(=_0LkN2,>/)Fb:!RFhQnH+g846^OId
R2[YO#?3&O)ZRc'/1u1KWB%%=T_/$#N(.CQXif?_u@m`G8LB1F]Ak!%sT57]A%75S+)ee,AUW<
T2'#,i,%s>P&b^E:o!q\-;)"UDWX!UPANUf9Gs#H.T\C3uh;kmT#6O6o=ni,DF=u-&3k#K?&
c+G+KTA'p6NoCCWZTMaA":Oq&.8NE:mf:O?LjM_<B/IhN#oTsj/VdViV1EaqeOmI?Q(hF>G]A
Vh&[k_Vhg7-l-Ofi0S"#oe.NhgKt/7$\22I?P)t#Ps<dln5!4D4*HI_>ZJ)+mN:%7.loHQL:
n<k(m\TRd.Wb(mm>tQU'nC$'Q&S+Sj?.)<[@=j9)dT`;:i'us4uuH2$/"4I3bDqHICXT1Y7d
o.+t-;//$J&6h-?^_M?$ID`A>p;M@]AtArt2(a=U-X*4/jLS9eLpn9XM\]As_*!Q[^S:fgK4u3
k(lG<elI[9qV:"7G)V[$J7l*qW%Ek9V2D"?TDWulU]AiS=#[_sl&^$G^3-`d"n,o=c2(s&I]AV
t(lWq-2.n#L2D)Se.R/bcS0jLB-]AbV&i0E_[l+D)dY>/6\&^M#GKI(fJ(@H6/jNrTHEf*CAN
$UHNb/=Gp+m?H!cTg=-S]AAFOX0A<mI!/NZ;?LDjL'6VJn^nG:Ts#q6>_esH:`>"eIfqh=?O/
iDtj7l,3WEt/rd]ANn/Zp7pcj&-;.MgF$rh&2:@\.&82#F.MRf:(l/^dD&_>96DlkRhOeYa)t
D5XhB3S0uFiN*!"^;a6/BrpX"KU4MM9[CQ6C,R'3]AOjP\koiH;uYHFpUl9ub"G9d<bDapkuE
M@,2fs.mD!'1!^(JrB:<76>"<fI*#q9IkEC\kRE?(^AU^?A1g1akTLKJ$bNM'fum*ttX1D^1
1SC3)O&mIQaN\nsTUYZk&uh[`&D6jR2`:e9&Yj=Rn?aXDQ4nT.#paPuPi(d[`[@4!O>hp^;&
L<t.j$VF`-@$N?mdnpA3U^tYs/dm>6;Om<@m2DujIUQf";BhX_DpnYF*C_(k-dac*o_F2NR7
+&u\;W^2J.U_3e^)>Ze*iI)<m;qrs"m`0;u`>ID)M'sJQUo$Y[!jJ9r&$sN$!=0B#L8$MgYC
kH76E!'L&H3^CL#e2Uk[VL7L*)X-5sl2m4Zc[Q&G);&Z?MY,q;\0uhu"b6;IjH0dDhl0I7M^
2;[YEZJt#p9&k/H?m'g_h!t%1PF0t6STU#S)nX2CtKOk*Rq-gXYTN>"bY7\dqfG(-eiB#GT&
NKH<3f/s*u&-eB&tHR]AVslN4!0OZmeJ>_2G5iLsl09J$5T\^MmJ$.+$CUb<J?'0LX\KWutB$
lp@@n96W\,Q67)iF23bp*MWR377K-),99ip2I[R/;Vk+K$d"X\6PdKRgNN>kgCYU=<Tg+[Bn
]A(E4+iC@'dN"ia`Y-%h(rQTLUP?>H:tfPKk9eepe'-9i'NqDHRD+Sj3I<b3\>DsCM"jSp,km
4r:ekfOt`?4noa,#+BJtnR3[R=r9O$5cW-"'O-/2AW#"^Dkmr,3AHhtpLb&5NP;dC0_Ipo]Ap
0F<CZ0pRS:>/Qlm[<X20mum?*r38(.s\lc:&_<YjNF]A5S9<%9IZI2pR';2h'"`$M!W^?Vmj-
Q@qg,FN3,u7'roa$=?\CVROZWo6^%#^H^;bk2<mTq<Cpd/k>ZUkEf[Mlc>MTph6IGSPUKG*[
Q<+=m,/%c?^s.0^eR/66IG$UqGRs%(->"D_Zu91j/3Y3Q$j3SqFWq,_$/,%1P&/MQ\=kkEIS
jXqaK2:^JoR<uEup*.HDt'?k6,:jkSk/H2TA#kGYQ-R/1a8ib/<\b-S#h]A=pHomjVK41?9J/
rAY[*m-@lk+o*f7Y[km1X[[`e8'YtFR?WXm5m1^no+igUs00&6IICaM%JrjF[T8VOTXa\j<@
el"Zro.!;:V?%K(:gt`rU8kRPrT2d!RW>rKfMJOAl?Hb;>8<q^:F7I@#U*5o)YWt:ksO[l9a
2'a5QJbg;W"Mq4/\MB'/rP%=;CiCE"gG?36.XIFDKc)h2nBVf0QXWqt?ODFGa_MS"`0h#W[#
Xp("1/r37Vs6ehY:&VYEdA;?Skd&r8WaSu<.n<o]AM#q#sU@k^DKia835$ma/Q!09L%$*(uo.
5i'nI"$/k)BET0NG6eA;/L$NNGCTXEFTl=X^<+b#?nINEb$k9Q;P\5WPjc9T.+uJO5Zec,[.
SNRjkV]A;liI6F@1#ib%Zo]A65^Ya)OZ(3uA/h#DRH0AIsi!KD#ro3U]A891'ck=2i;EUjof!E2
I/f3^u!ZUqNLXV`;#1K>OVcmqF-e<1R?gZ^4.*ms8:UQ''OBj+E,EO:,Wk_Ij:o0oT/OjlDA
*j`sA(W"X6nnCQb^DVH1Vm+F%;jbZro!kn9k(7%a@TF>p$rYPN,k&EdZ/J*Kq_Li6!sD)!*0
GdJS:1WHCVm,1=RH8&hs_GbT>D\Fs-!AhXLP[B*p#]Af7bXS<'^55n=`E*=7(pe^+G5QRmD9\
bgk8!f51>dX;H-q"VT^u8-(hBo&R;1kL%(a`EMc5mHI#p#paq2V.=FmPu$aANaR[@?K2=<L*
joYk:moS6B>"ndoU#?R;IH87ImR[G,Q+eOTifDYs=IcQ(?/7PNd6U`6!Aq_J.]A4*N=24Ku$i
HWKMo#oGD&a7R3XDR"-Ch;GXiK<^TT2CnD-hK]A(Dq%0MXrPeN/E8)fK3\H6CD&b%\C,Y1YWg
fgP-d2o""F<KS*rE00dikYS9i['c[)"S&2E^ZX<pOV.ccm2`kLiekeIIo=g9VknjA=QktNUV
P0]AS:3*<<B=K'fk'1m=&^dr(5q9O8P=m%AkpYq?tmg@?dm_9Q(QUp#\$=*`o4)0QtBtC%hIX
(#T;>&L[;23oXY_o)q8U#e"dbW_+4b1F(FGE4SWdkN6/KcA$cs=Kg!n&g1$qNu]A8q(jQI.')
Aq%rkcb^Jqqn$T@4p0+!$SE)'+dapZ6o,.I2%OK]A#TCX&S2.aq8_>\l_6^EBH+Qaguq2+uCd
*B1?91@cgJVh42M&:4G'bj6[.3Lquhh-B&b&h^%Y5bn^FkB(&`*V.F1HZq`HW@<R08<0#WlZ
@9)K7fQ=Gi-$DZ`85l,$@Q]A-X'UVHLLdrUSe5HnZ[(6>'3aS9P71QMn"3:(KNIlZ6e_NYQbd
V9:$I$iri(1du?k9%X1[YPI)FqFs@5[5<6:ZTYM3qt[an,/5"gs5e%Ln)?#4Qi4uok'.*3mq
jAbeDj]A#;\FqckVf5P4_T02hm$bWW+;O=T3?-?>Ct/kpaK?L)/rhqI6$U1_TOd[dN&4_g'kn
V!;\\@:toLnF!,[4KfO[7[=C>78k;N)9!uk8Fu(r4lqP^#LK!&(%6C.n=7Lb^Rc(sM[UKnV'
Q]AAoJ0/?j+P1q.9t%[Ke&TO*rgk^HTN87F]A_Jn:F/*$7UY!8es3>X?cbIC;kFMZqoq_4Cmq0
Z1p7<k)'8MoAVSR,Xl=,_PrKLtN.#V607V%hCr5fMKD_:i+30N_\T[.Y=alZdRC"8aHpk=M5
m\EgM@eC9'S$f).eA_luVi/e<(/89i:(k4A7q7__?Qa\XUt^DIeCZY=bPuu*S4lcJK,K\?3b
\td@i+6NPJeX?S'/p(Ma)ru-aO;bHM2<9!l?O]A$q?!X`-:'i$u-6+T6.=\1WfSE%Q.\7F1^#
cpR!5tc#L4)"tcQ3N?(k>K_+j9SjFEqRhaa4$#^SfkZa>g\.rr0omW;+.ngWIg]AaDNP?G67[
V57T3E9,!O3`4/C_b<4ijpq7=0X2&1Z_Z:_Gqb(lmQV]A")(?p<>(b;(M70ZU#Q*)Ec@Demc&
NXao,EI.rla>hDl'0j?u!7J7%<)HcVrdbqRPEMHk^lA2IcL"A5%C.Gq,>`BAecq=BSn]A#Oc-
RI92*LmDp6m9:U&j1bZtVam?^X"tmk$Vs.W_IRicH;E)Uh,J,BrskPCPqtgtU#&OO<\DO*ZQ
]A2g9Vn@_q`j$oA'$,6]Aq4XgED'BXL93k2G=M1Xellihc']ABK*]A&gjXN%4qQ=0QIl5)>5MN5Q
P-nD7s-DrYp;"$iForYecB89JVpA_m3"dUYE,OTl>1B;emo@pZ;)YrYf\4(61K(o"tE01YIB
>66-Opgfeq.a9a@+g1@IAcCuj#tf,9:Ai_B?6.P\DN!qA]AFWH3s9Mi"NeW5iT9*0@,jp=jGB
b"pd]A8(EdmV/VSGh`2_3P6Y:shT2uj;mT$[r/@5-B5;Vl<Va,QtRqjGjJ%FJcOCIpd4Zh/bH
ngrA0:B/3T6O(:G`+8PFS7r]AbiuH<'aYPlJD<4InN_2QB9`aiWn,0Nj=MK,(@7$N8G%ec82K
nneC)(S-,s#$7Qk<o=mm>\+/#%hi6ic%nal!D_7M"rG/SKAVm+9XE.d^\o\Um@]A3J]A5f+1B]A
a5MZ:,00B^9H)YDC$KO3^TC_KH"B\u!Y"JVa\),2c=o`_G!>7SD8]A0;>Dsdn.%;0XePe/sph
ZD.Y_!6%!)b%^FMHV"HNTir$UPn<X*FM='aouhQ`!.(2iY@B2q>VH9BA]A($r^F&"*?Lhk<sk
UuOVi$u7pM=V5n,N%m;K.&.t;&LL3Y336NP\'?*EqkqQ\YmW-Jf?2o^N7LMGGiCs_Bq2u;HN
/?$s,gp-,H,TTmM"-r)Q@+r(X_&Bn1BeqKZc-1XK]AUk`KJ$e>ZY)@":;\us`f/mQI%MR5hDr
V=tn&j#VD`fl^D+nko]AQpYuWYn-UH&+"DIFQaK2oc[mYH++O^PJG?cphAaZdCq93`m(,B3[D
=Oulkh1CEj1L&G?%?Z>QiRsN+1>9mnb-p?I*!VZ`^Aj?0rs5;1dM4l'(d;F`,5ahpQ*%`1Xa
rYbN\Zg57C\i)O^5+$fbD@SYC(Jb4RRXKU;O8=`*&JKJ`Yr)QQ=Aq#Ma^qj]AfVgE<(jc@VAD
n.Q/l"QjOf=Ds4]AT`!V.'?S\2Mi]A+HQ``r=k^aWH32TnK=g#B$pprWEHBBCri=2g4]A[Wn=9K
k5#/Z:#=^aV?KJ-6.j8Ji!/<#;lS[Q@a-V<hrg\`dq=1;)SZJ*6XD<P=-^MgK\*)PbaEi;Ed
RG7X6*HBo_p5H]As6T`_@=45[4^k-H;+$ehTNHs?iLJ39`^-'^?S@L2B"2YMk)$S06[^7@B&-
q6W`aD;E4p\bPVYK4@OL:&kJ*#![oFOk2h>MUZM[TIO(Ql-o>#WW@.ZWdo8:/0iX56mGc*<M
#/5$JJK!hOZaX5Wj`F9b\XpE%seZg>*!".n-T@Z4cP*,rPjer/[(JohC-d#:?ua(fW!B'`bQ
s6I@ZfC,jDM*b:2d`1\tqn;V$?P+F>l-O836nGb]A%]AP\f>=G7FR"D!V+KMl5l)(hcX3YOg`?
h=>;"\;/E-%!-ks$UET]AoguH&a?m-Qnf=Z$o9g]AC/;c6hp]A1]AML#C=6X8,#*`FRcHULr0_MR
Cub'?O<gFI]AUX=U;L9Ll%/sN'>>0+9)un_B:7cUEOq^%,/69+f66UK8"c0'_7osg."W+S$p]A
Rjigaf&Joe]A\,;Riotr1^>1p(.G+%hmF[Ujdou!+nV-aeFi=+c*"-6,+C8X`PJI\N.Gl"1Cf
kPth?deu0bP\nP,>pC7lL&%&U.$jg<`,oYFos?;DNem.;>0&EGMMYGIZP,BW%R=@<m9QY7/M
DQq/CnL75)Z_WKoG:S,4N!_?=kS5K]AS42<uQm1[TR*A7&6-FU4lWL*ge*-tNB,9asqpX6.'e
lLE)q]A<qP6$E-\C^c-BXO,@[JWO4BmbSZeZokXZXM,a_@<S>*rn.[4s>iNeV1s5((G*&:R$D
i3=8s3;r?UZ@)i!*8`glR?;n':#&8(mX-F(RDG!;ULJXNe>B3sI==?>9@67+O*:UB)\MDrrY
KZ&^d5;-1fMYko;kOmYMh2noq*_bjmL`D)`4Trj^/UF2@@>88>4-o/&nhQnO9U"Wkd'bLF&<
e(K^[_?CK&GKjp\?;Bf^O^h-P2;[2+PX>rX[L;mLm`3-gmp(>Mn&Q>L[6;BctdVbQL]Al`l@Z
'uq"*p*TfCb4hn,b,*>4:GcjLBgJX^CRcj0t98I:<r:6>j<cE&/W(Z!'&ge[]A!:RV>eX5!)$
Y4J\V4WckMcEa7LGob$uVod]A+;`+m.^Asm"g!+kWg6D]Akc[11600aL_M;o'-;niO&:AlTp"A
;6I>r*9X*X<L`9/.b<FGgtDTKVOV9]AQd##n)8Gf_K&h_!>#0baZO50=0D]Aq^H,9AlCQG6eP@
m6D!rW\4Dls#n?+@NO$pPhKlI^1_",3\9f#.%Jt`Woh2/"F>i+niIW-L(\:FGciEX@#?I]AZ*
>nP-d>*GHp69C2Xjig#g3`rV&@)_cbDXjlGOC=DeZEW#bp!;'dJ)+@dJ5<tPP['K2CWoU5p:
be;j0U+dFBkQ*+PElbJJ&@ZlSn.r_H[78=DF-GffEH"%pc&DN.jr.HdPoQ=V/tcn64'=<0k!
*3HpbEu9lEUrjOCi>BX%]A:`E_YAQji.5YC$+q=h1\q<ad=mt6s]A@4la?g?:caXe(^i?%g#2R
V)W=)LR4lr_c[A8/ZCDosEg<+#Xi#T-Wj]Ac:)$[ds'>VN!UG+WB4Q;I!G[664A"g$)r2;a+T
6iX8V^dWWmP1[4!s!*KufA9f%Lk4$CZ[9YcLZG?h@kWK-B;]A7\d1Y3OEBg]A#@P(mE9Fi%;#m
AM!"R+Q6^o*%o9U9fal;s20&RW6$h6N*FnN-`MNp'8gYc(VXRPJ3F)d,6Z1J)_W[pj$ms,.D
sd^$c9(d46]AkQ8E[DTm^Xc_#agW9QK7iO!T%^3\e*'&p[C.XTWSCeHff$Lo%YCqW!Weg8+]A=
do)D[nh]AC#Q&nIKiNDTH9S?#15<o.uR'luCbAXk0c.pnSE&2sJ3AaZJ)b%Qg5,OhBIdD\!X4
_H_hL4nKX)Nob4W)kAO&WbW:Js4ro7:5anP>>u1=h4EimkORhgoc7VmiE_dqFV3b5q1O7U;d
)e`,_Q(V>)hQ3H%m?%_"Aj6eKIlJk5K8rJO7c[=J()sqPAc\[*MN!OW'jA^e"&49%VnIIs0S
=BNqi$gG=G8k*2M-%*Uh1b!N>#u/0(\DNPZHQ3(qF+(W)[.+qYC^iEO=)IOE;uc'?VpetklG
9($,^nZ#/(EnpcdGV,>?oEh6(R4Mg^L78HU-Zc-,-3%djsLL.d_$kpMi'r*-55CVscGpnqfZ
)9^EA-e7.khR]A2A3j6(oPiu2!(3GT$/Uu7S0:O42WNQ=?1qI,Oq-3DmDo^1RR"hgH0O@br3T
ibaRLfb=&7VmPg0*p:F5dHLH^2OI5TiGTHleruhPB0p[$-IuB!(dPHT\>`@UC7QZ!4I@J&J[
Q5Q;Zbpc7qX^0B,@%r",/nb5LabgIG,j"1bN6o1\'Hqmb$p>OaE[7T>Z>S?M_[I!7+K)Q(<c
9N4#>*']A_::'\TN_WRVbViX"je'8!IJ>Ps+XBQs]ACqR*%p($"\*eY*m:TIU%Gh,gXpYrdQ^$
X+)0DPRSZ04NODdL*)@`l')Ao^XXT=NAR.OP-RNCA^S)qU&FET0H$iJKq;pG-4\3A>)iLd-&
Aedh(f;M0!@GeH8jGh@NI/En#N7#,e0F4*B\nr<&F\q5mntgYZ7.-QBq_=R&6M&bWTH=djO\
Bh?`FX,?n?!G=j=P_,#)t*J`j@&neg0gcgGD2bbc(&u&ue\,q7t/WXCmoMiaZW`mtPG+J*/k
HRim6`Th.LL]A'n=h'[F<iMD:4XF?b7u<ZguW)8ahXOdC1_]A']A!bo\.un'V*k4.I#GIK)#XQ.
T]A!_?*'SgBD^ZahkWLU_+eMPn"M82#2WB<KW0_gZX6+B"ppFD9L6>`-.`dMmXJ'mg\V6/kiT
a'X#?pS(QSIiE_oR.c`75qEF%6SdYp9/-WXi.FiB4js6oH2i(NM=1J&E.o#&\BSre5nA#SB\
+W3H:c'gm?Ns\OD!/YQTP$6N=`,LN^euYu1NMRBoL#6;d2&2hgiE=>,3.W+Mh@tF:o,)9SDT
!Dm<=Zt*guJU<2Z5Bo6Q9[C_7]Al=poqVAdhRe=eH<Q2rI2u'jNMg!*5]A/afdW&h-.`QL?mgJ
L=Ti%OVhO`:PJ"aCb0/_@07Z\q,[mc:r/>8k.$Q@(F\]Asr*Hrd]A9E.o`GiE:MoZPX\:*Oi:V
9%C:ECtY5#"EPb>YF^IfThl+A(4Ui7:*3CBF3]Af3io-SD2]A--q`qbLD/<]AW(]AF'eYO\'9&g"
JO^,OQd0=PLca#)4YS[-'PUHEL$nKGk6Ir!UmT`iIBkea#sjY#qQF^R;nFp_kuAlXDROYGg1
qgX`C)6"B7"g$Dd:RFhmPn!V6JUu3Nkec?,W6KFP`V?DI.jc^l^%5PICe.QI&j+>tq!%=YPG
MjT@dt./FAD+h;4Y]A"A\InV]A3TO$*SC6>N6,<MMhI)\C?&NR7s3YX4[skf(W`MY&UX;,(<]AX
WTp6pAMc@4SPY,o,/CaP=U[Nh&RKWc;@V1Y<0-"0CH.%$!\/;HR9X$kN8YCg%ED@@=o?ZT_p
UWeBgKF5R0BUR2*q?N1`!u92qFW)QF#uOmj^<VM@sYllMjUu[5Hb:B+r24oi"[]A8WHBZ7dH&
XG.:k4'@"Eq566l*r5FFja>O]A+JFXcFY;D-+sN<5Z3;6!R\!'g+!H=Gl1?Md+:TnY/i-K`q*
ksYLB<D!0]AlZKX`mrL4K4+;e/0ZeO^HYAa[,5j`DAcc3'M`[oE]ApNK$IQh"!4adVECriTl/t
<VNo0^9EQOAg,*Vn0%e&.M9UdhBV_?H7fhIB9\;N]A+J4.YGr.lRbI4CjM?Iu6\+8+,"@]APE`
j.Xq!Z1lL(GZjsZ%S$8O!Ufr#(qWoahjF0"4f`Ll^AmT"mnCXn.II"di*7`#q)k[#,WO/g/h
+Ee7D>8Q(f[FJMRmFF[Wi\olJb`%VKFK^&H^l%*m!&Q=!2G/gV!u:FnP_-B+@Y0?2O2rdF,]A
&F<:4ml`".]Atn5tS6+,4VcL+p;h%M,Btn$07+R'KG7Z-adX2k'u?M5<tU%pJRHA]A=OGCG'a9
[Dqo]AG@Nbs`+>hRmho7G#HAh:7a!BP/<.qB!8.HBT2^U`AUY=T5C(nrCm.dc`4YD[_T2m*]A$
%pC*LuPj4K"6I-EMl0e1U__",i#!]Ano@edV@,-&9V;BKDQnh]Am]ALF\OIGE,#1RQ_eeAC5,"@
EM0Mgdq69C"f&;kA'3@G=E9aLlK9o^6ZB:Z:iTr]AJ"*#l7Y?ocAYJ[QYQsij@"^9XKE=55L*
:V?n'm!f4F%dh"l>Y<G*:V/tD:UgL4ZjqN8rDP;?tRP1Fi$Vkf8fIWAmn07/n``MY\!P&X\q
)]A._`tQ'R)4I+YZcq;,XV.QkQGSl+J@Gc9_5=c=sj8?DZ'Tmn4OYN8NuWan(O(MG:%SUWNm+
A%2g:%!nfq+0Og-noGQ'/GeA1##Jb^O<-JJK;K&?/WKQPYMmce]AJerQJ2D.]AB;Es?-))1UN(
$3CV.G(lDcD.\qd@k(o!gU)U0SL,5l5?B_./MHD9[%tKN1\jmjDdH72M/e9/%#E2/H?[9.^R
omqY4HI?/.eRKS&FW(Y60k#?=>"!IWURu=,cJ;^ra"(6@;lur+PeM0u<hM24]AeV0ife1R6W]A
R]AUuU:!Et;qDqGU,PJOjNM0!Be:q=oM%k#_eNQ00#A]A_`(kT=dbEVZ/&a0s@"lnW"`!!)2LW
OW2G,K&>7VL5GcnHuT=m('@>)(3B<$Y,\:gV"2iQ.bYaW<59:^F\.gKeRhNo$QG8oR,EOPii
9-CAqK,4O*F/c;$I,DP3ph)t/9QPk3V\8#SSVaCO%L.r-EkN6%fiLd%NP9r)#uVo'`@n#Un>
!>92F#3Wi^u[bqqj<3J6uYo'a@$lHAX"j9P*F1'+!rM^pQ1.IS-d7G3BN[.K;R69H=+DW1?&
ef6oIkje*%]A[bNnjg7]AI:bK3;M:Fp^%WQD/[]AnJ5BX[!.AO!!*+K`;>r1=6S&HZ67A*f-INX
NB5h'7[lZ,2=T(8@k#$ZRia+juH'p]A]AJ]ADf[sR#0G(J7I"'D.EpOE/nqMuupp<*$X]A+T.87a
d([8,^kPt#>KBcU$&gC!Un(VW.Ha^Z10!k!^<DjO6V@^ojIdlD>uNEo_K[4"EKZ$H"+`NuYH
dY7&V0EZ>!'c@$&<="hBSHk1BRP8iFqgbR>$T_J&,*ikFhc>B:QeCs*ZuCo\6V2>-Ls[j7'f
-#Z(0KW=D*6k06k1;_9Hga?HMHm1STJ@^\d+jYD$f[$C'GT5$NcX&a+lZ6/b%-B:F"dr&I5'
&Cji@k5j6g:hmY[<DYht*.%GfILcBrIp*P9($W@1D-pp,2&("6Dg9?l-*gT(/s!-X6htb&!E
#5JW1s#dq=o<1=Gm!,W=A"D1%_Bb,2:)!uD_AiS#<UJRPe#4$HeboNNq&^sr7or/`*oA+=!c
)S7IaKV9"?u\(B[><"(:7SqO"\nV`^1ZU3(<N5TBWk<q.c=s"=%PH?T]AQ)NT73-ol^!qW;S`
)E.Ns7l@;!.UhXXnl$_d.8DgT1(>/BrOeV)s,l^j!-Q@\0PB?\MbF&A-A)7!i+55o]A8plQgZ
W2MH)-l`84Pb0H:=a9P2@WBrmQ.B%bg5'I(2rA?XAl;]AKQs'7nN/3!sq(B[GX]A)(J/Of,)-e
6HqC`%8c=#eVu%9Egmr4h\r;D?.//OOi\>^3j*.j[l7R?Y%u#2H!.T(C9[pP6c_cT=6d\PZ$
),dOT%)OWqiiG9\b8Uu%8+PmNKQASCDSVTUFr*cruFM2f#OH]A]A+:Oj77C&3<Z%/<@gU&MZ</
d[M=%[3Ts5e^:9t6UnAQj_%OCCNB8u8i>V_&D/]A)Q=dcGWpX+N8=E=!0[7o-!V?OFRCKto[p
RT7fL\*/&gEq$-!XOd.m"#Rg<I2T?&=d6g2jAjlZ@WLrfl$`rQpJ?);hV=BE*7R6:P'Yr%c;
KK+a20K!<n061H0eK+?2`*@>iGFrZaG&;m!Roh.-#K4:mEdocR8^BEj+[R=$OA*46fGpW+Wp
+*b/)@MbTlAlGK19qDma$GiOm?a"u-%4[d>JBTHX2*O6mt!liD8U[GT!?ISF,^L?UeXPOOW]A
guOk#oMuJ+PTW4Sga8qMKQ[cj-^4m$,40BNq`@^VN%[Od\KoC#cF%)[^2G5Q*Ok)RfCn1\AJ
jPmIjIkFE:Ij$#.7QMRQs+'uj.5SS5+g;?foIL:K\-'t/Da^(oJ=QHjM2C9;nDG.,*VL(iZN
NIH0!R8i7EZERCP%$_ACh"lT:j4tZj>6JZ/RBV"&(p<-'J0Xf&nit%7m>e=d'nuucg^6n6h5
+^nQN#^0cAl@jXIq7:P*3G\>C_VHQMc^hM70;aO'3ufG,D:5b,ADO?^C[nS*2[j&'`Dg!/%J
SMYVnCC97!XEBWQ,'$D2l-SbgrOW/0Ho!5n@l-Qh'GHZ2&N.BaMJ9>m]Am,CO4#K(#)Lji0Nh
4FEQA`i/O+aP##Kj8kfTG6`lEQ`K?0IQ<kaBN?.[LL)83%(E^D^0E>R3hELft1^_YBdg@^%8
tK(ZLU9M4Hh9PQanIL\q1dEAX#TaNDQ-F`mh(Puli\XRY+ghd1<QfhY?aRF1$WQ"Q_93V!7,
Wii:#>%aAt2N->,&.2">UQS9F$ABegFb77Q?i/XiVMgklOf8`W/V=O`3M<%LR7d%;"L[EAK9
lTDOVYU^O!%#hn[VG%SjlI2of?e@ECYfAS]AS&eZ0Y.XV279tX;amAC0`]As&9kIW]AeXm/JnM8
[dGW9gT6^NVHa0O=,lpKL-aHrN#."3Q2a?=7:mN3UlkP+np34:1L2^o4X`>dX$u_2,jYe!Rp
I+h[*2+4n)Ft#r2L&<Rh.jSgL<7!r"7iL8c0##QaMK^<[B1-g$%>NfND)%@.96E&/\#<R5(;
d5O=CC4hfUa2lU$YQ<S\\^i8I/OV!t^88Wt2[q48@sD8:`;`-4m)AB\!GO[@o,eF^CNmjE,U
m\FN^!UIHi]AsfNa')K[?qr`BOJgJBVWIJ<l)X>2m)Cm`1,`P9N:k!b:58t<ho]AX:nSZ'"uho
H4cL0_kA.u@(kCO";Jg+Gp"G:mWr)mM=X$>*s`i'C8V1C\7HkYg`Fk:fGplnJ/#02>P6G^QH
n:2,=US(p?s4p3@(4U%O4S9E,BcQ<\8*k8)JD.oWCmbJ5XWp6+/qW'_ON2(52kHuI[goLW]AK
IHP=XFC1RcOlgkd^'dZ=0)?4J2.;W`:qhG.QWTcns9SG'uYQO;q7+,O8MQ3A99&umnF'Fkka
"kW,KPmCFLfI1QTn-&GnlSeK5qAYP2kQ$<sI>J5CUdp<r8AY9AHM<.DM0*)P38jgWiblWJ0%
.=.pXT$P*)APZY6*-T(1)oUn9a<5DXfi.0S(DMjtn9;c5CaVD?O69iZA<Va;[Egj^;(:Bb(g
#`UN<%d.Y^n<ZE?[U<jhd/CdF'a_E**DJB;@i"CqssCIR<nMUj,3JeQF\$PPliAFL7\EnT8u
+_t'-J66A!Vj32dMiclL0@K`\*Q(YZ!rtM?^HU5OGmqKS7XKr/LEK)`PW1db*ror\&;=D=hV
(&cWE5i'p1oso'*<9FAr.Wu&<FU[0.c-S5D\.p%@_T^qk>7nn;9E:%NF,n7oLm?$4a(AVFU-
O[#hMNme/GG>?Xet`e*;!%m^aDNe1l0CK&$[tUW+S&KCh8G?>Bu%X]A2$+G_guQg^/6\9N`qZ
Hh[D'E52Mt%"?B*S:/$A::i3n9:XU\KLIt9#ho7+d;*t=f#jS>a>Y+rLFn2X?p1;lU[ZQePj
T#pC@(Bc'sde-e,/_5)V1NZ"&l,>;XT_TB!N5M,sp;Oq:3>s<Z.+3%qDhbNcS0^TpZG]A7E(q
2(/'Nj^_k^pWRW,/8$-f#1!3tq1k=PRR1`=ZLiX[jRf@cfb&^@GZ_q[Si86.;ikc]AaLTQdTo
U&dE*siap>+Q88"MAjQeqq:q=P_bAmVc1E>,)q*Sf_9)-;7M!Qefnsp$dYGAZI.j#M!dXN;-
A;b#5q)_l%tL^<"SM!XQap&KjWl^J>&_&BuCMjmCoSl%+bkoC<*%0[P2oojVb4@PpHD^RM5F
k8_?#S2s#HM'EWN$0_u_`D'[8AI&7<$b3dPG1pP1"<S84^=8.a&n@^8lkelr[4HXl>]AgL#Ed
e0_^Jl0=)-Sp/_r3U3-gij*@49M=g>I\&mqF*(Ic;3cB>OPNchZW(n=.7S$a5#>PTA##$/+R
k%P,G8MSV^l/mALa(aAns:2Obj<!B,/:p176\?mMp4OgR`J8J=KSqpsI9SmQ&b;&+^S@rFPo
nhX^Gl-j@GCbpb+/pUZ"2N0A%^@5eBOP1*Ii0.s-faKdql"#id,<`iAcpR$Tf6$HEP&>7Z)-
fh\$9s4n'8nb;X'Y!Ik^(VjN>R\[.3LC;C.:QigWI;9&^?0oVXbka(&$N8mA#e;3+og[q5ho
:'l,$WN1.,psm#tLs5-sB(`k_`,$g5NdMq#06G`W^2g[Zp=#Mma;uii_Qp4m'GN!ZeLH$Hi"
-t)]Aj]AG9I(.+5>RO.DnJo+fLG(FH#bDb%MqZ`^`ei>FbMXo_6A5)b/\mEr+)<"WBR^u[7^&>
m_ECog;jNTu<CM<2Li0C<U4%;EL)05mcShiSe/2BQIOHO-,c"%g.$*,Nnd1^cf>Jl^N!H\5n
h*B=+XVAgmc4iK`b]AA4:0G.T/::=;)D#W$IGch'G^dn2\8Q^LY<QZGK1]A,YhKD02-/09%.L%
S6HP0EI8+e"jHD19F^D\+B#)Mj6'F%V\47@mJ?rq.g`hCoN4h5&/-E^;Kl(G:Y@VI"3V9o@`
e4sa+BM.4W^$Y&p$0]Ac3-KUNE5KABtW_2`*[pJ!iQS4q*bed_W0/(!J)1!si8/tRbX'hq^HY
5.P(X;oX'ZZ3ZKm/;\;E\FfM<F0-p#Z0=,4HIk9]AiHKo60Y;`6#0R9j=QOZ*qYUXc"`bcMW9
nN,tc1E/U#r[?M1k<2:,Or_*9;[sKMtb91pE1cVij`A"tY<fY>^ChBPDTj_l(KQnF(Y]Ap38G
S_!88VI=S.=9hT:;;\bcA=_ur6@7Z^Xd1aQ;SR$*k`IbV\n+imX(rPgrhOC<rls.U5LG$V*T
(Feh?XS]Ab27p6B06lVfK$f[KT*!*\C<C=M&ZcPl;/fC/psGkp7D3H+t$WbR,&5KtlD^5_`b\
OF8Ksi!ukB4hD;bQea*2BF#5e;"(mJBZ&9bmJ^,$0iZC:h/Mh?$pQ0*bh+9.[?./uU&HP=PP
Bh@WUZ`6%0B9B9UTYN.&A:-G/_>iM%b;W,P9.+JIPU#8A(O6+J)<#]AReL%+IOoW=0K\SGf\:
8]A<i:HGoVt[XRjrJ(E%I)LXN(-]A8"&_B-0%tlmG,>"_a$p:#5sg&AE-1D)i?cd$C;Y:?jqeW
'nQ"hMC[odC=WO0MbhcIW/,6_HoqKl_UKdT#$cJrF/e!7/E#qO,@YY)@e45nl`TpT7eeNPD9
?T=p[>Ji(-&6\a:8H%^L?:O&cJ(jKfJh(]AAGg=!XFSHGD+t[<?iAqU.nZ%>2#=,?.FZqpfI-
i<RRk?K/2f9eOL^fJo8ec#hOqio5=*qG2/[\-'CS6+dP%YG0g3Q=VM1Q7p\9I)1u=Y;ocL;)
c^O7>SeRo50>RQ+&7[kUdN5ip#V_X>cWLh:m'+[C>B^m`L0,K#Rb!3f-tQKAhG&^%Dr"L;pb
#;n.p5cPbF93.n6-bp\K$$H;TPVkpTi,#aJ-Od6@T<_<fUIb9mBoPYIr>hZAV=T(:0.HODtK
A;7fa#!kgM'U5jTu8oNgu8p^$n=W=p[9O7cZR51?D=LgG5qL!p1h)`b1gp9pN_+G'bR+62L0
_UBAn\j9Khu?&qI61*7!HV_RE6tUQ%oMT35&DQ(*6<6#I.6ho.2ulY6.PHiYXo*-Yd&+!DAD
/Oc5BTnL!MOkl=KcB:*['Uf1_^@C=;%&Q2n=RWA<$!nMICSIL[f.kY.8Lml5TLh_V^H]A1XgB
.cr'W6biX)mqia@J"_@S=t(dSf$XP7<T)O'?+!4Y^IDTWO".TMOEn)-klm8?1q$C96\2RQd.
N\U)9PYhQeH*\mV5]A<`9iV85VHddH?OFg`8nR\2$.EX!E9&(,HLOE/i:(\2eGnL'E:GPkLN8
JCpQ&asrS]AD*-6AI_]A9s6d=e0(u5S3X-S#AS3%1oJ1P9$"@UP]Au_S:*BRC6-)Or+6UX5iL>J
))"9r6*F(.(khA:hTU\j^fBBo>%'NQMK&Ej*W;o8r6^4kI:g9e&!;7Hme1q3BW^Gou!DDrjt
(8CHqLl]A5aA=9WElfO^KQ0?:(j*'\j9:tiG*3cq_adkUf+d\[=2G7DN5P4?":4`sdZjg(e(%
kX=,sBBokJkc\<T3Y?1+l`HVU>T!CaVmiltQYdcpU(XC.@Eu[<`iUo<uCHlF`#"gcf*:buiM
p3khsBSV8?Qiq]A\.L-'0-=F:nWhoH8=Pnp#gLrGscSdm`'Rc,K#XU.)Eppi0$bnG(]AIX&0`J
B"#VeIpOF2]A3Q<M_YNdD>V\VQ'sQKIh`K+aD1Wu--`]AHO*f;&,:]AG"KeGMK_5D;f<,J^E_c5
;_GBt=(475_Fq2:!M_J7_I]AA-5$WU*CY2^*ecF[BHaSJ\YcR,S.o7dq'aZ#fr;\@;q3`0.1+
mOr8;(:n;SKd=Nj=Of_p(>!L/h0RtQCGJdt'&ffOa(Q.DY@)CBKdX43WEV-V-t`V<',"WaMO
$^[=9&8V.D_.=$@2(o_,k\1P<=HKr_n/:"Ksu-?a6!A(PPH!*?A@F*F7#sMfFo\Y;Pc,3K36
L]A_[Q.-<0A5**`K0pqH?N(A(h9Q-_]A,Y-Jqj*hk::$:2]AI\pdMQW_Rt4kKGGR7ic1`6pnBPe
.1'[>'0K-*IXUFN]Aj0LL&G]Ar@Sk,^lrDS5bBDkD43`LXo6JL]A1RF%3Js@r/hN;:CBFZ:o#4I
mkDVr4$7]ADHkW)`96;aoc1J>dY^[K86\`b9N&1RoOKX$FY*hDiX.&Ur`I/TVXbj(e!,GI*l`
DZ6EMVrp$EIegZ=f;!rD$&&EH*)2B-.st(,X_Qa_62qTsOtGS[^F7D8T2.+1YO9efWe%AL:%
]AU>-GYD@d^UA_l;$kJ1)+D:AH3Kr,hFhZ/ca,k!=^^=]A-WAg]ATcDYn+L<E[*QO*Oe"5?\H*J
+:@qV=<ZICl>QJ:E;&jLUNiak`<E]Abmg/"0E)#DBY&!1na_Fe:jM]A3VLrI&14pJ?+4,hm?K;
BusgHuu`fBI"<ihK)HGMJUu',^;g?A%E_>M]A\<[dj91HpH$AZS;'1*csaNlOe!/TF*pPnB8q
E6kuh+N?PEW9fNdo9_fc@.\LTEbLFq[`=fdh-r02HHJQHq]A\*Gtf>u\mgW#&[+?m[B[2Y]A?+
R,46ni)=^3d;KD\ggcV@T99,(ODkiZ(?^PkS1lVBmtL!BlR]A4$?+C.X?G*%X0!(<L9,u7iTj
!Q3]AL'(0Z11FR-JP;B`-gMBbA?WM]A:Qc!`.;RDP#\NSPbpqAc^P:"h-L;j"P#&qRdt*W=mKO
@VK\#AYYQ?AZ(CL)s%s5R2u21s25V*DBArL\X(6oW.egE5m?StY0.p7_l'&ae7VpD32V6YZA
RC`_f`e3[$T!XBXch</p`Pt3HCk*egFg'8e5.K,6`luLcl)<_2rOWSdAbD$'f:B'NuS+D+sh
Dqr]A]AO4,qnFS5IFs+qTF3#!g+[DFu4+W1*-:V/X4hI[n6lT5Ia"TKg<=LbVWgWd+FHZO(J5N
.IZ)JQ-*+o7TOL[m*[WAiS_aVd4iMi,tVtIr+Q8hRb'st=2NiN15oA41f;l@#2*4.I=Bca)b
fj=fHu8';mKJ&X(fnTNH]AdYAY?pIX$7J+W#Sn9gW$/4QhHCi/78EeNa8<tb%&=%%([hbM8G:
db9-#^G,@"8^TtsX)5TDc@o?9CC]AR@e\#Z)If,EAVI(-?<Z^t/(YjW3\\1hh,\gel!R\9"$e
0M%YNog,)<K$CB4e1#dC=YKb4-%Q1qPPU>]A!cOth$9#/_&5&UDUAV#N%k@`c`;D/GRHC]A@)G
(/]AE&W$G)/CjQ&.snlt-j@=5=3QHeC:^FPV[Q:9k?E(2OlL@`4o7OK5&XaQ'ZB$ZeJ]A1>3Sq
&"uVP+=!pXgH1im7\gH2m8(jO+#Z^r*:S$.Yp9HPU9,$Aj4c'qL&R/>\a%bO;Na:9.*-3i9&
FuOi7[YFGg:G+9b5/%W1<:b/%I[eS^3Ans0s!"*SC!i.f#-3Z"bd]AIk&b3iegdl`)HOMcLr(
c1ie3SZBr"GDU;R(e4p!(Z@fnNlCsO2f);95.PV:M2rU(r.iNO-E@[V1_JT/+2ImDldAa+om
Qp^(<<`7YgY$_\"4W1T4]A2,,.FG=R;.b'G=RRjiXr)`d&HBQp'5>llp^)Of<Or)&_aE\?8?k
Ca(/t&bIiG)MhPLh\qdiRd?bQUp65Qs39CF^1PT'eZO]A4A;UL.s*Og8il)K9i>4`,Z>9<Lmt
5iU7HDC=99-m4RM0I.LWZZ6(#h0Hc`>9C2>,5TFuh.J=-haCO"JLV`[k'cq/iQ$ZGJW.BC@W
dMt9hfWH2BU'46_3H_-+FT^rKtX<q)+$(EFQN@$,69SXNfpbg9A3W*1t%ENN;S"hu?7>lTPE
[/0ef>n&HY)Y-na!Ss.,5B:(Jp@6K+qGPXC=4")2cMJ0sfIN^]As34bB,]AoUI_79;5n=topRq
mrV(\u5Um&3AXI.p3OIB!G,jMreP:$9or`Pt^3"nkcr^:.efedTFDULpC<K;rX!c,`Qn>cVN
e@SJ:&Fk:+'i57DE]A3IIcsB%\ZHf^tY4j[([moBm]AlHSD\2S5CX&W#d]ApQfocHf(4AHaRj@e
UpOK4a//N$5%n^&dF"'W/)P!(`6S&?:3WX%*Vs=$A*UHIAP9Nd2-ruDgE!NDXpE1nXmfXD'^
+CJ-a0"Y)V2KF=+Xo"Kk3#cd#YQebIE6`3(hm>\$CTdE.G)oA5g5/G7'hM;#@$=kH/TOOMC]A
r-h37iP\tM9(/6L%<GHXZF!R8cQ2_*>$6gUhT>10gQs2K6F3(^Em8heehI>1qK'Q]Ai3o^$HO
$==;s+UV)06c<^5G9fMEC=/3h]ALkPTU-DC[J<j?Q"t7)@rc5/7/Yk&niplGqLXFYjArmLdpi
+;-Hj*Op7%5-;nXqTdCA<9[JUcj+L\/nLQE3M.UjulbgB7>ms[S+b+]A4]AE;;nfmek]A*Y1]A;P
W'>/q:^VD%.Nc0&ERg]AK?!n&^Kdi[E,.bn''1;$c;`i`a(ec#9`l?@?6qBdWaZJ:ENcIo-/9
FKR%IiCGS7d;ACRtC`c`?Q@C1N\Yh\i!_"hM#^+G"U8rjt/c+>Q"$8djlF%Pc0H=K:Z'H]Af4
ogV3@4V.GBooO5lp$6(#Re!ZURBVi/JWgP&_"RCHd_6,7f1TZHR-frKk]AG#Y!q.cYEWsnT:'
RrTs@o0V;3X$D"o[:e-QW]A@n[@k0=3#WtF?/0&9Kt:4,W0c:Tp'`h>%>k]A(C\SXLE4?W&%?g
12;pV47rIFm0b03l5/ml6bECf%"Ih54?3l$[5\J;j@ACD*nfn<1?+?>6rihrfS@"TLq*hp3e
Y(?bH5kol\aRQq1hiNa^Ud,k-%8$(UNXCep#UPW`p0EYVs3W#=m)3o;8qKE/LPXY<Zb,mXX0
eOQ:m8+"<^pogO<6[/*+1`P[q2iGd;2s_<H\+=\2OZ9a4(F&_;JYuU@38K%&8%c>E.WKplqe
5`)'h;BN.mtEDB3=\Z+dLeXA5MeFVWso;BsFmD,G]A-MalO;@rZ]A#JqLjb0jX%O!bB86H!(0R
a%J0]Am9R/e<Io?IDlLbWQt2]As4DFe=$da9'imaM7d'K9Zo*WZ4C98na'iC@runNF8E:?7i^I
keXoCH;6hI.jpLWcuYi((Do[?-2NLJ,/$qfOs9`b/#=c/cI9Yi/!";0tJGD&G82H^K=p5?NW
*T+f==lK,WHbK6Y@nuYAI_@,86mLP0c">r1Ago4=ls@)EDc8aFXl]AhdbDV/S\lK3`$]A9AC;n
!`uD_N<\m`u!Y*thgQ+TUT#bQ1e*a`jWjL-iBqK[LrBqitrM?d;4h[Y]A=BQC?t1i6^+\T_Aj
(56!H#%A2=-eTb&*[mm';RWM7?]ANBP1H]As5,HP>^IJ(W;UTNf_t*H[E6(pO$N+jO)*H(k[0f
@8eV4C3R]AZ]A_ZjXs*MII_kmf8sETnHB^YO',A-tK1XYqc\/A+`a4Tu,@>"rfm6*1&=.(MRj5
k_a,sghhV1FOZV?Oh:StiTS/n9QIXa'`\'J`Bbtcqn%Bs9gQfH)me<M?u'7!2q0!+u:H3c_1
(1=RqoN@N2;(Wg?MI&5/XSe"Y=;/FAZ>U%WTb2#'fM;$UI\]AnBg^=lOV=aA/UA:ZTIE6uQFU
OWkCVp($m+H:soc>iS=DCR:N9oMZrk!&Y\3DDNc(79f)P.RtVkjR/+J*67Lq4&dY8de`]AV6\
ZMVL@e+\<stTC4$p)3.M!N]AKslNuZ[=Gh]AA.B52>RL/[.YRj(HhF2=A+RjhXnmgX1STi^C.h
MGgMhmJ"5qOlmTP%S\:aV6^TTY/!105moS/P8!$e%>o*-LZS+<#6;l6`K4D7``[r8*R4S,+3
ZW9\oS+,.G;hSST(=,(2FT3U'Ah62O0:rdf':Bqj8LmhicX@;idh$R`1>hquV82Y\(V,JQ3T
?5P+Q6@PaZ"52ARbQE:(Daa6q9?<+2njHfEki^LMV$N'd:^'<G8ueSCQG]A>ljd6Q5)5kbn>g
oW;=bZ5Mp<Jrf4gV7l>JobB7nV3[+G+S.GS3VQ[And6;1n6X,=fJbPl"T.?+gBKa*`\uRHnF
Q^bCV#T_;s"*quaJ3o'/Y4GM$Ih0ZcC+[-$P\K1X_LT-eE4LoP&o7jjN>YDf>Nf9F4pBAO'i
/,kCkiKslG("e'pgSkcf>I%L9Fj9X.,22!l\Vb&<<;JsYA[U9.kpJo;X&)KYGe%cS0Wq"g$%
:cLgB-;rg=m2So??)%r`'^`]A(*`S=?)G!u-/2X/Fj??1_'ed:i#RAW_n8_7t7g!VRS$*5=Or
H47Tl`"";\?ZorhkJnAFeblcd'8Q/#_sp<Vj9#Un?YcWh`odB!Kr/iCmL&W8VCBM?,KW.Vb&
4=84i_2bP9KU;<'3'HpNI0[`o_=;W]AR4[TN?B1-E8G^4Z'i.(r&L]Ap=O+>o6qRT@#Yp-`46-
1V7J&Tm'L2&XRA4L_VoTj\"k+3%[YaV"+d@5\dXJ%>>UrK"_MZSU"DrafRm+_VO3dg[#9g6F
=WL0+-Fua:1FLsL1O0(J1V`;:dQmSpFo;1,"USSna%L&kMuBjlC=pO3E6H>39(Hoi"iA<O;O
G_lrU5AD)bOiV9`Y(P^m+58d$-/WgprZbL)#-US$58[#AHpe3pM!]AD1`iWVO"cI'0iSn.4F*
:^hPG(PFQp&<8L\C[3[O?_YAY6`K)-_ZgX90b:MT.;]AfjdjY!D$Y\8f2#ZcM;F65HQr\)b#Y
Rfp)p`a.r54p81I1j]A)ajk!E^Pm.>A&\4F0QUY31m2]AP)7?tOXGfsi!fTrHRidb6+nHDNt)1
C1.G'(bZHn]A($PVj3t&3@Kum]A93HtrLnWj7A'">@EI=*k``snAo)C"S!r$?OL;X@,o7O/'im
n4h"/\_5A+EC>-m^ulHp6e>p\[c>*d_NP9DH6G)2bons;]ANd\N'hcQkLt3RdG7BR$Q%E@a04
@hHpCh6L/1oLmKBL1ZX@=Q"CrI#jC>7MM[(%FG+loK9l-i3BY%>hmo9YYAC5=6D!,.'K,.A?
>t/Pgc]AX.M,q+o^2c"2u*CAC=Kb[Yt;I=OFV70l,3Sb,Neo9[E8S%]AS:,2IqEil@iCj&SXlr
)-.4+;quM<2B@1[J4'W"XY&G(R";-mZ%$6ee"L>+*>@IL<7pA=KDXbMm@XpQGtMqM+k&b"i&
h^9'S+Z1*G!If#oTW0O\Hf-0,"UJG6:Ikj(Oe$Sr!=$QHWea]Aa:?<VS%#)?bdS&(:ieX1eCf
en3j'5NT@heNcDpJa-k\(d2R!FIi[*>F=@[su\SFUG3X__W\;.%=6,gGW(`PD=Bgnh-Ms6gJ
bf<sj<-K4u1(M5'U27'd\A@F!^BFl=]A+oJ'Q4)/VbRhTA70Yi#"B#!/G,s)@re\o=MKdk3]A+
cf'O!B=5CW*O'0X;iM8>geGZ=HB'o(nI<<n68h3ib+8uPl-FNH=MH+I%#%;jMI39Ya-BE/Xs
KQd6L)p/_9@.$;;'2+.e<))*EpXja1DS<cCDtOh#QZZBkOo-[tf!]A"?B,*J9q;S)K=YU!cp%
_A.u/X6\n(Q'!KrW@Pm0:IgU(aS.4=RGG;9`0<>*i9h#dUob)W>g@s&P(\0*d3(:2_[ed4d@
u[)HnH9`?Q[*R(3nGo/&Zb'i(q"<=`3knU<AK>@Xb/$QeQ1"f*T=)-Q/RI%8Jb^CG7;[dJkU
CZO,>j>VY-8^i6-uAcRc,IhhW.Nc0`@"ikh\<hre=X=K0!q"rXh@K'VN<?$7Kl>'"[(+-DLG
%73s1pu7a#AQ^X#J7T/%o4O*]AolQ!Rg7RQZ-s"(GQmo<1B1#+-*[)\SJ&6uHX!Dn!'l6#[Nk
@2`QqRX9VBh>T?[23aUa1ODZ7'9t,)bdtNli4%1<aTsT6u?=&eo<H\UqA4r;Z&XS,N=IrHpC
h;u(Vd"(=[R0KR&nI_dEGqHJl=<BQ.6%=]A:0p"(_'48(@"]A*X\.M3(o4kk7/^fKt\G(^WCXp
'nbi#?gfZdJ;%en3-UVl11?HEE>ZrTS/jR+'m@\_K?CYhj$N_A&muQMc#M[);;mF11I:*G^1
QfI?6Y4=,")5@'mX/d\NXbQ-FT5`?rPJ^o-lfOn>F9jr'[XC?\f^5%'u]Aq[mbd*JTO0gf)VD
pQ+2&)GtmDFDlRsVFr3oc)i1^/'-C"UTG=Q2&3Ss/.#s2_f>)XJ=HZW:d'!bgW73gDT2A_rI
G(\37gcm$0^GQM@@>#FC&J8Q-E<pm0&J%gAlb=PL*+p,'h#Ab@t`F.3Tq4ojZ>357?'F_'^L
jO#RF#mZq_e=SZfQl\7&td;rl#(c*jG,EJCJ,#mE;qb2D$2*d@^>*7tfb'Ds.8=JK;RjZ*-A
`EB1V?G8rXAqE$5`F(mV%p)B%R;4c:!/67=#:+,!dZ!\B,b+<_LSr[a8h,?I`>-M'f9QMA)u
FTp*(h.e_P7"U"hCfljk=i-e%a;fF(7eW*t)1QVO&@K7^j:)!9I47dD,9Bs8iH3%NtacVmF@
?LT:c/)E"V/_^g1n0X1fNcD'BVo&`iMCbU:CeHN?Dj4E3BDYZhS>*Qh0re52Yd21GFF0F?-6
_TRNb9WAk#>O\KKK=0:oP@)!A*os?QDoMi+%0I1K\Tu5b#H#?UKWooFj7B3Z>&@W8TSgS%29
S9q#./9>&?Bp.HQN8Q^,1]A4n.bpT#Wdq:`RTYl)c-)WUsmo6<?cIBP@#'_SDp^%m%Gb<>kQI
(8(^c!Qqun1imiauu"/gFK_W.CFTchFR=[`h\_PH-HqV"6AMD5OfL]A1+>'4aiGP<i7U'P@qX
7mi,ek?1jKU:P+,hdWNXIO8S5aL>8,Dm>b]AsY=m@W66"&if5#ToX?ZE]A]AU6fbu2j6<'#>hcI
H`,EY4cUg*Qg-!(MgNR(6Xp$d*13[UH*8sUj7J6loQB#7gdB=6km\r!^=QV#&\BSY^.cJFa$
<_cFnKPYQ*%=l:IC./de,`?J$2NVo4+@e01T2NJi@*Vog?^U/*eF$ltmV:f^hn>Fic0Mle0-
d&_4`Fi5_qmP;@]A[fJ$79\((DVRnH6BR6#_dNl&5+,0[oR1%$2,Vr:2e^G++_PKgX0eks:c?
39n5V`Cc']AdiI;X<>"A_ku;>[,8]Amnlqu=7K,kF[qhdc7bb:fDA$K+.WJe3R9PQjZp7.okU$
::>l@]A9n;i[m,-"7mrmXK>T!2a[Ek2p6B5/q9?3WGa#(#io4@05,U.EVq0]A7MBj3j\R)GR)'
iP9NCbH6SJ;.Chkc""6A>::O'lFX2;i&:hQ4.]AD')A!YGH!&jiqSS3u;hRiG2i.!#WeSK!30
`+sp!.fXg/nOV[4>F3nIL]A**KnCn#0$h<FF!mMJZ<Gp?D8n2>4gCmPq&keLtEa/$l[Oka3cL
/+/XrTFejhtM4`\HTJN_+em)Hqb0ocKQsVD9[Mc7-TA)Ern-E%?Z)ZkuG]AE&2EFF':e]A@5tL
dg(p.WCOsi/3uZ<s6o54@bd79q+0f;urD<,Thm\@]A+PuVQG=MTPoDF<CjaRA-S(QddC^S238
AG=>_dYo3noG)4n)/e[SYL2Q"*G567Rp^FWY(eb_+;PmK0(mZQ[7khDAh";*:lq1Db1q$VfY
psaa(":YFdldVi@oafs;pZlm@[-n,Bc;l+u4bc?6EFU)UP#Bo;8#G+)[R"n_hY`_8_;=h"8K
"l\qjJ8_\]A$`tH)slG-[A$j-@X`%K4]A4`mB,lfUN*[oGM5$rq6+C8mn!YRnEN$Ea#g1tfd'g
hm6:M^<QfAX`8dtY6t?=IAaS(#dX]A2EHWIu7bH.>@dniG*>c$.?X0'1Mj]A5%ld)fS^Tp@=^K
VcA9Qk[,]Ae%qP&/E'(]A"t.bd9)E0#ahk05Y--YW/<nHGTo7.AYt[]A000/HXj9K&-q,ZflDUj
>?k'&DNA>/ms1BYd8I@WS\Ma3es\8g4HYZ9t!`l_)gUOr83"jHs^H>V0KN21CL?05u'4)kW*
:8AB'%\'Rs0/&@7mBJ]A\2R2HXRu"7/o8mZ)jeS,(hoIIdR\=jP4%Su"3j.4,kdlcrGfucG!]A
F8[ZmFuOJ5)N]Ao(p<Pp4)u90a:D/cIOQ"K,c9edSsgsUL-Q9AY5SFQega!M,qXD2FUmdr,J\
Y>=4GTYNaX=M:395ke1ET5hGc.5LMg<)[%#rgD2-t?8mmb/K*%uIf2bYEjD.,DZK"n\5>E>j
3`"6K'H3bOX<j$7IHp(;j'3f?F=0I/Or(C&QZA6"Wr=+-7,7:8Z*%#0=cn-.6._64I\8#(tr
0)rj,#9<#hSuf>/A'EI*A"WQYjbr[62'`X.eZ]ARD%3Lgu6gdu9/"kU$>d4#<)EdsM3DU]AK`5
)O`_;<[DN'(!bNuP7^:`))Q]A7Bkh!Qn.gj`jr;DDZ2E^mHK/W]A;".ETmD5@)LPlKoWrBSI[&
=UF3D]ArepqWJD'IQllAQP+mos'.B6Li$drGV:3SY$]A;anPZsoP)j\Rl*?h/#ra=A,b[J@$ji
rr/&Z7f@_m"A1aT<SD,ak8B[LF*;8^L7?t)h=me:QSrO-mc6@Sc-@#70-#%gI6C2<`qQ?ejl
g$)qS?6MTBfBV&J6<VTf-D=Tf92c52;d#d_Lg_><R'_`!'A_ACoWLVq&^u=C<0Ai"S.\H^OY
.j*ns1P<RD:-PgtbLZb"C!a\fOe7GdK[5;dB2aKL&N\!LK_>,r8qM4\!/&i-Si*ku[gN(jcI
*I=;IkY4FIXadU1UMh\2R8\nr3Ftf2Z!9X*)T![t4V0S$MQ`VCI00b&O5*_8j6'm@7,G&+V=
2MJmErj(U0\uV`!'(b2;&nY=`78Njt>(4?\lq6$NSBG.%;4'X^6LFA.4=jFi)OjXS5BKdlW-
:[Vm-:WN6s<I]A*-$k\ZV+WW"eB"UrlL`[qDI#KJpV_^?Z*K;+Kl]AFUQ\G;8(Eh3m`BJlhTH$
&dl@KOU;D:2taT@tkJ2r^s1LUcED3;<8S;=+=O=5Znc28m50qp_@l6I=LE_Y]AAUMpoRs/<j)
%*dqqLk7+9mM*7aL-r27g\"8Z>@=12K%(pJY2'D;>hP-0B[b,u,0["O+\h;'V*%FV@&Xjhs,
FG$q%96Z^F+Pg<I/\0B:F@_0Ddbd7WpCHuc^%\%bqja'_!g>ZH*]A.fRoXUi>7AUr]AUqF7Yie
gft_H4^ikel1sU]A5&m:$_a*?I"P$lb+o3"P*9^3r@UE%j[,g'?jH<a=q\bp=E:7heIu.2H?=
p]Ar`7J>JX"F'Mjb-jk0bM]AS(D""",2n9K.<YpO;4O<J(V<-(%MnBCYTHBGhqpe"92Vs6,QiD
WA&3h!r0?=Y:`O;MZm+M,:5cNOPagrHu;:"E/MD@fI3pHgXeR'1pj'hJ)R0B]A8@U%t<q^P-]A
(<5$"&P$cA1Kbo*dQg_11eJ(!m,._N#tGldmRTW#/^m@6*#]AY?te8:%%i/+.#[CAB5LE9mgk
2mc8DG[O0(ID2Z!7!'8j,%');\,P`:[3]AV(buCk&0NXfk4EIpp3<&tYa-I"`gSDjm?CW.6@l
+H^SR2p.D`<+,;-nHsj]A-SU+IqGXg/ID*8ldlo=Z^q_0_P4-[3Cr%2lFR+n,G2Ms7nCp7Om/
#8\s3Q,G>,\p0ThsV#@CnP^UDuKQ.P0,oP]AZ0HhFA\7SA_:@on5qKVs]A,%17iP0dmkej_CFJ
g$&KoXs.%4Zh]AB_GnubA]AYqQ&^%q82_@$tM@-[b[51Ah<juNsj;d/N<2rrf#B3:8kJKa=Pt-
p^*1JO#TfjRHCI$s+bY'[6=Y6Ha)*`s[`)kOb[/'3HbEE,62*"ErOH8Wt$q9Hl;B>ct#$-0/
j:mR)(Ml3J)#,J2=&i21lQrF[X%7L*GKil4jNh0&/MQ,GF*BCtRm8*J&%76'2ki3VLIi:$,o
\Bk[;cE^PjJWRYC'#\rq24k6n#8&(Hu1gR?l=V:qm_k>/0>#cb0AUo6bNUntOhicM4c[5ec'
%\o->hWa[%6.mOeU(p6JkWXq=*"6;&",25n+C/jH3CE)]A=\UJN\XE$PADj6@sKkns9fu3X)"
!1^JXBra9I/2Tf2.E8=H1$uo?AU8cED(i6YT`QqppLq&pE@hSBJIar+e]AWagY!H,aH5Imbd5
njQ9XuS?t%K]AP`ebr?V]A(U[R"nT*cY>5gOZAI]AiD((A";a*eJBgFMP?(F"aNhQXG]A;P7)f6Y
*l(_+B^+3[FI1>@@?[lo$eVSXW7O@W7=Z["(Q!PU+eC-K)&)n2)OB4CUfg'mQ5o`m9LKgJ>?
I$_)((ZZJ<%,hm7ZBoipbD$"`rE0Z6rIWKI&TAW\SWYc2LA#XBQ"B5(I/Qh[6j(6fh4jqE_6
`Bj$S^?B:G5O*Vpj+I^H`>[*(2''An=Y@m[Df`i0o$.AL]A?V!EZgCT/G9Y(-1Shm<Oi]Ae=90
B%Nr5nPM2W<L.VDQGj)k!K@kl*?OR*M[OcI@5qbO&`7c*tObOQ7(bGC]A^^OgO`N3oq]A'pWEk
Fc>2c>'s"$M&G""i.gAM/+L_D+mpWl6IU)?%r3rZhq*c(!*N'5)G,uNmX1hpA(eAiR(PlK>(
hlg]AC"[#seB;1SG4Ub>*Ok16WQ.sjc5Bk,mJ*Zn>N,c:,N!PCmjEB2LN,U;[Q[Z-^PA@s8fl
[E[>uS@0aNachkY\VPXKR+QG0Egdho8UjXA_DH&B;Z`68<c(>UGrbTahcpqHikOWiRmh0gd7
JNUI$ObJ;W<h\sdqSO50k@Qi]Ar99FHS)Br,Q@A*L)Ed/HqF.m:JmZ?CPEJA<_-`.G4*-OefG
5randWg2A)9oD2nQ&Y;F"N`,N"GrB>^sD0=IJ/qdsR/'F;+7UjSbTM'2<O0[Z'((*H9rRL\R
h"UEbi8r$SC1+Mt)n7rEsXN%FiX]A7i#(+pLWqIl8$#]A>_L4X<YSbA6a''/5D<XQ`o<b:DPi*
H,f9!fDpD5Y[H@qU^Cli<r@pZ'okLDRJg*STeZ$M)H0(4eE)$P&mFIOk>WW4=DS$PMoV'9QL
iN50@pUg-!<+mE"N$i#:5ES;<Rf5d=BENRLUD/lSa4CjJ$@=YH;qGIIi-n/muHsP*H-[%"4V
:J[Moj;\A6Kj)qA-BI^YX<cA[*n>L$Rb$`NZ]Ab'SWn8Smj8O.+g.O)sh(&(U%VBh9D;RMfsg
p"A$ifKk]Ard@qHV<8p>B#KW0\_ij$,e)XkURp5"kW:^@B^\6+9C7$.B1i!KaKtsU*cnPUB$N
!6'-"/9Rbtl_;bMs[d$&FD\!nkqi+0^F2ES.uRkMMcY*G?bo'-;Uqs]Al9^X;80s&n6hPU_Co
h*G8bR)kI8SqoRcS$&+NIbR#R?pPhtN]A?A&D#^!\)'njCR6hYcnTgqcJUu^=^hHjS#XU]Ack!
k_k=8%%\lhGrq`_YO0-Dd[WOq^'XmWf"0*iW`(QQZ&-L2VPmeW8N46AIGZjnKMif$(h)!h1_
d&isS3dCZ$_3s)#g?d&tr`+q@6'@E<$M)0pgGFJ2l4\JL2o(pf0PXG1%HRmDq]AMn\TPUjl%6
5^N\*KH4%bB0V=gdFD\jG0u#2Ni[iPD:J%oIB%bIocBqa*84B=7Vu]A3hQT'e7WYn&Atednri
H\W4UDPZ;SK1XEn$?Ha[IG)9'5gbY[S">?gFF21aat9(OMfI6L5V:aK^&s8OR+5B/s*03_th
qMRjfq["l+#ON!A0YloE#n4S('hFgBQ>SN=."8n&.a'3n-Zq[f^ERZ;jqbpVoRO!(qXqU^NC
_KjftODNI_nEh\\qtnU8<rTk)'KPRT(pSS:Y_(eO2!gP02(>]AudODVp=dC2PVA)[J1Q?UXe"
1$#&X9QI=c]A$D)&L!mY,qhV6h\+9;<P))\olf(+_qhJ:!AEh`LI@qOaqb'rk=Y6G*tg1eoJL
"_7ATkQ#gO@?sqZIA$mJ?KtXC:/c[rQ=Np#1#Ef)b8JUfRq2(&&)2mFd@lr1B.K!?>l)d0)P
#(`@K??7qO9&j,?OI"?If'`I[BpU[E.D"ZQlur#ZE4<O$WL0'RT^+q]AtKT21b-k'M`c_i$ER
'c:0.(&Vh0NH$;i'05"o$Ddj?p-%/Of`7,"Fkf`^lgG*%D\icNBpqIa$/kG:*lgV4RO]ARR:N
TAloU[MB4fkc8d<45t`WA8l7he+nhqPAO-]Aqg-p`U]Afhc]AHf-O398fF+m+''YAp68s)\=1d?
'96[:kY=QTeGRun3cIm^W#u/-e/8!g8R=-*A<"J`gqlZE4%:eDp007b]Ae"R0um5@'QFS7\QN
P%rol.c<)1kP/e^<m:CiAP(keRoG((\ot&56inRPso^]AiqNsG2`VlGq?^p<4^8<>e5)7#[,W
.p7:PL;YHVj"m#rLrRgjj8<(RqF2QtO=UCFr#IEDN;c*:G48?rJUD[6[K3Uo\IqFM@7*Zdf:
hqZGbo8OcANj2hbUW1f@ZNWCb?N7#H`9:O"s$Dt^FW">spAjYgNNE.(&l*q63\:8mN4H/0g#
^kEdJ@ZRbjT?\M2bZKJH+n")u*Ui@4nK9<UZcEGLVOek,Bih\LSpp&==K81#0WY3nr*S=;q`
K1bT;4.WEEK@aE,n5#8Z50`]AGRX[MT?X$.=d>UG]A+F"R5-:$F!rl]AAo^Wq1HjD9=PkH'PhBd
Rfc==+-\C3f6'G52>Z4chf<u$ZQBIH[\^5%o^RDe]Au^^%Ia/pVHO:N]A[mU2I!iFu9r,ZbM/)
&]A<Doju:.LQa\;n,.rcLoG_^:tW0/-tNr]A2P"X2=bEN"0CsH&'%P$rI&@>U&)U/qPd4iJ"%B
fJ@N7-upc'WKApgTLAn>Eo)(l\dV_iX'4sF(Wl^gFsJ8[Gh\f`GVSl%D.2PBULqFUq59GlVA
PV&Eo78g4AnKb/8(TfIAGZqdSsX0Gi51SeBIp4c_n?,a9r<uL>-haXfmCeKh"FMNOAdL/bG6
efS-5j<[R;Gr`/"GGRMG(pL0pe3D=)[$TIUO$8d@50j,rILm534Z&.5(>m,oK1g/a-'"<YW/
<tadf5gmEhk0><nY?mV`#Fi[.k30fIr/,hbuFC#]A1IqnmbV/cHiH?#f:3eX-]Atdj0-Bu<.<@
j9(eo/_f`B7rRlF\?FcY#%OQVmZL+o7Q#[*3fPpd\!HdesJ]A6H-[#H0etS0u-GSg0uC"c?U(
[;eIa&VPm5`kj:TT&!p)d*P1\a\HW/T+8tLBU.f^e)">p2OkHCIU+L!\So%,%S6\Lc-(!KR3
SI'oA;+0=:DlPd;Zjr\jMnT%[0B2l>iE`Td@C,M:`#sr;8J&#euQedP='oksc\c1d0pH6#C6
%V!X"5!63Zl`8,DXec-JnpCm4Fq,-I,V.gP#0/Y8oDXq/$0I>G>hDj^P6rlL`T("G)7E3apR
)dM!Fjt4YCWi_Rg.S%Q<@ujN$`NEHmm"EjEU(@j"*>8W>-6<ZiC3!?.-15-rU0]ARjui)Q&%L
AeA^9!+H+[3ZV$EYS0k!OM,3f"8''CNNTjh-1(VeHB@="$f(+4(.0F=*@,.uAtXAoboBjEb0
V2An&"c1b*:1!(`I5@D!aH&_AXY:3g^ZHDYb-O]A=EmAB8lQaFQ<a7\n'?0n/,qUIQ!*I,>Z!
[>XEDXC(+10r&,'Ua1U.HI,7.#oG#.+LJ:B0i/9I_EXL<UDWP,FK'&ndgODmUTn/Prf]Ah]Ag^
!,<g;AB%-gD^_^-8-003p$tJ;1O+3+S6L[I$TaI@o'n(_4!)YC+Rf]Al05Q`lb0BH;O";;6Oh
@]AsM4;C/R4RrE?HOJO#0j./Y'$3!ugI&7rYtSCB<+lZU.T7:+)"P1b3@/*4d69L0T9rb*-OL
1-cN=FOT_5o4]ADrV>R9JUpNNHoKJ+"n\MrYe%>:Rl7=D./S4DPOTH_%W9S-!4f>q_.f<1XtP
k@FbR^rM1*n7$p_ELn\6T5uR`]A4S)!rCiK+_]A2,T@Gmg%dQ-[LnF\L6'"M(4MFbCc)pX8K3K
m#rORB?>(P;[Zh5r,gasfn/j0Ti_hWrJE<#IDtM5dWO8"g?q5)Nm_TaZ4@rasn6/.jXdK+4+
GDp(e,Q#,W$;<Dd7=6j/:h^0U@4>=Is?0q?9>`20foKV1SqOl5bI5q$7[9i-BM($+&Tmb:J=
^L1`ARZ9^%,[c>FIlB'=V=u"VrFicqTiLfp_#7_9UR)EM63G<'Wt(0e0"/H1_XG"bEu"m=N]A
gmc.(^1[CLth4N7$q"3M*0$&H&!+\iG"lCE)Y8?[0u4=7!c.jIETG5m!?-k!)$o]Am!^3@BBH
augTg"rbL:otiU4>=j)iD,a*k(gZp+<5NH=:rR.kU*,VXXEI^@Og]A^hj'lp.GYb[tb'I:`lE
-0.;1c2-.A:CX4Q2qDj-MTO]A&q+W'!\>_'\PUPX?HGr;I=8hNmI*3XNiO7">-PN64'RUL0d>
./c41+0+H@6n`YVSXWfAd0K]AOTPQqWb`pW9s_HQV?jV",EQR"0!L_R$"+he\H[R2ahC#*Ke^
Ena8J@Y,eTAeZ7$o"]A-oI.j$[b'%oVrcR<*<%hWq!T!!eZS%)ns"<h6ou_iEJIU*@3uW'Q=4
iQ@Q3EGNZ-/1QaQig;S;SD0]A!@q&jZZ\6PLTm04I_Se+W_uXD<+*c2%,c8JOQMkDC'^?Qp)K
RM^kjnli;+\kb?IW.D0uPjq'22?i7#/dA*nC'[Lc74elFc]A:i\E'aujrj8iU?pT_J)T[FFP6
]A/Bb_$Ufq'-_PD?5fd@3&MRn=Q'**u:5L4qk3)WHA.)Z!Qq'cAH"7X;#jA:KQ2ZLIeR1pHK-
jf+4UBTVtH:eQc6VaHm<JIB2E"*Rc6i^(5kR=Ya,e-S+1,X)g**VN%$c'snf5gI(I=Snjr"D
m)XKIs^?=m055\R/2`>X?;IiZ:(K.fr1&\qujtCdC!]A6V+F-%cG8BcSgFofN[,f;:R$YR&fE
OAo1<Rm-BDJ[b*n4>'T;!u$mWG@k=-:)k/MptGVL!/F29m86e$jnS2r(_=!\D]AfXb-fVCM.2
nnPGTg)K(`Nu<pJP>`^7Ibcg=LX?K-kqZ089@k7IWH_L!Esf_p*Y2E)gs7SY\m"GBP\FcZ,7
d,(O%;rL/h8[P1ldO%_qCarma]Ap3!XhiA%G=m>\Gh=ddOVA7[=se;EgbRKQe/N3%tL`)8s*G
[#JN(mem,n$QI/Wgs01H2%%h:DC=$7a2QTP'4q:U'$m03OVmE[J]A_b&-;8aqsIem$Mj2,f8!
1rr(P:OT`#c`O=P$<sjQ6mtQMt`^=]ARN!%FXANX(aU1r]A%$2F&;KWF<TXVnKr%L,`B2VgUBE
FJ0k?hMQL:D;k'[2Z"kGB[]Au=TnY@=hV+7DqiG=($VYKqC+rmN20*]AXEeW%\#9k1-omV0Vsh
c*@#mR<6(sDQJ<)pqGAEcp$234r$^'&Ps=X.BFIY(SdJ1O[/5%jlQ>84CY9Xqj^i*2;aRdkg
=$+k[1+t_$)EAM&i^<8-Y&1'SX7qk-(.b$$]Asb7T]AI<1&(,5%SLCD/p'XMahMGcqP_`CL(a#
WTH(1`Fh_,N,S`#7E_()o\9Ds_DPM'RKSe0elEn?H#-faO'#N)h>bA\BF)OLWa<+C&KTeV@_
)bNhdE;"dbauWQ&kTd5+QO@Ybn.o5QQ>_g9qXueSk)`qaq_?"c<Wm:c@G:s4g>pSI*g-"2,f
u>j(;=c]A'26_5020[k3*>EWf$e(4e'>b$V%)p_iBR?#MV@nQfS(C9,li).q!-WituaIO<Db>
0'C)N.B!iJh&@2D'!#Z;3oDOMl.cf0fMhFhe'JHhrI[ki)14D/'-#!A`dd]A'>iqaOnc!I,3b
L8WSKEu&?%YL.;[l:\,>&8VbKQ&.oj(U2rLIjIcWpOp?:RJa.%,Y$h>_6HXsuYunQ(Xgj6K?
$2?O$^D?@/&-N9uQ?V;g,J@k3A[dP@9a`,hWC8qCo(AJXGpr-O!q^9>pA!-eOl6$+&-3U*a3
-DA=.L\?MgpmF5^XbX#SPQ7kJJRYi,At/,`_4dLm>fT(`RV">Vr;a(<-Rp[d<SYiXIiWPN#g
.LOc9Ef8Eg=/?d%`R$L"f.#aG!,g[9l*Tt/NYD\3;YcsH_...+TeVB-S6?CCed"c\!$-!_!/
0<i1`/-Tg\IY?V@>?EJ3?uJd7jD5o?=/&P.LQYQ&Nd<R3gaV0Z_&"0^Mt"CVYP"+"Aqe?Q*&
Hu7!^D7;\(^8@"T">^#,dD%O$(%s!;Cfor[;g/0Q^3LLJXH`P.Kf5+Kl<j(=)BUR#(#o:R'c
Gk.&D!HQ1(]A5AQR/S+URNYXBnBMt4QX]AVoAb+]A7q%*lX3m$'Pj?"(LK(-cH]AHHs/NZ)38#>.
O=;&:BY>*#qSX]Anj4_Ndo<gg<g2Ye)X*f[&qsbC\D%MI]ARN\#U44Y;$4/<9;tMH7*m*o5ku;
ZR\6HU]A3[l41hA!+1N"4L$OYY-@&Yo\tO(u11,J<1[0[2A3Hhilb!6UbJB(E;SWMhglgMLLr
(jWesLW:d3QLW2AJ&f3k^Bc.uPSk(IG8J2,,mnq3JX6]ABH"Jk8;Jr@'4Q$r9.R\!BAW^G8>;
H#0mUg$RT6B&b"KQ<^D?W`t8,:FqNNUMn)3mc(?k\_Q2#1lkH3,?.1F+9#8`.1#d1FEN$?e'
oCfJc0"p%)U[!PhA[eRc[cXng*Y+fPd56D9qK-b;cVR3-\!,M*qs,&$m"%PfVkq,nS_3Nqc2
6UQg1mFAQr<HN\YKZeY@K[^I"U"HF0%s`HI>jqqNpBs[g>d\)]A,^i$+]A5cJWQdI?J&8BH+nD
;X+OU8e#g7t[\t1jA9qF2]A[41S,+8i`@WmP.:1,,Aq.T<j9M.*ZGiQB0fOY[<<%>eM'^*%KZ
qEt"AdD1HlDu^'*Y?^jB/_aQOV0.7O\`:Z3KB@m8]A8gmKX1c3p4n0i=\afP!^V@JjX/-03q(
tACAZqMSra+fU30d$aAQ@QRpt$O;estSJ`.C1"Pb)C]AgDq23=c\u;VkQ;S7&Y"&D24*?KJUS
EAs\([$#`:Ln+E`#*Ck3ueM1N3%D_37RiTR&UisF\dSpe#S3^\uC>jFL?`oce'uSBAd&ZG<Y
7Ok4*1XU$mA+5X).q9S+cagB/I5dY#8`G=m0Si4B6kZU4<Vs"E=\0j<QNfqs%=7rZERuJjOR
Hp4t&W<ZBJ.J"JY4SU.Uq!^.X$`,k'J]AM8<!J%q[a54p<GLrMOu42BH"E_,#s9kmKd%[YS6G
q&j$7NEjND=E,^\IeATEIRS_X)G<!F;BGHbG!8DJf*##OTrM`h^C5Sn_q3dU1\j2[RuhA)q0
<i@KkO(]A<>Sm!E+\fpD,m`j$MF#%Ebrh<q$i`sfa&VN_1EtOCq19,C=IZ7n8gG^SoW7C]A?N_
?ho#IIK[DJ_k,MJ"#3aI[<bA(51i]A$]A/[MJM[D##No$S-!Gh/O"If5TEb5C\.F%n-n$/&/uB
RL<F:.\a?.7X>3d`6g9n!-o1&2D7l?Xp?sT!Q@$MJYf=^:tm+>@8;&m6"Zd`Aj+9VW>#YUe3
iZbsljSDt5"@4>02SASpF6d"r.nZk#Ge5drJt]Au9Xc;R$`E,FC:'C-4**G:^#,pRGGi2Cof3
EUDj=i0n:,dMp&&fOa(]ABZn=]Ap)UbgN1Cd99hS(pgK1N3/nb4r/S@$T"l!A<cLdIC3%LgQ,S
t5fhq*2WZf'^UKYFK/Qejf,KJpi'&P$n(mR,+mh%fEaW\3l@Wu1$fai!JPaa8C&L0/N-,RNg
CKS^R!g&mQ6h-u$#gJ!=:X`OCfBj`EOngH$Rfk`19[^!s-mtUQ&,,@L:cLkMW!ecZk_GluR^
1j=Fi"2BU;FZ:/G8N&Z&0;sf80Ifu@FGQZ1kouo5GKfg*d7te7r"La[ZS?>AL<_a<k/Z@cnD
-7/>jS.A`70mD:'/8LTTT7[n0GUG05tcX=')-1!l2:"+/,s>sFo6n;Hr+3,Ml8."kolQaeCK
\HCb>Y+[3Q%QX*AJGE![0.Dh'3eA1\;&^?q)S6u#jgsjU]ACj-Urf?eTZr?<\0'eDDTq!04/B
CH#[AJ#u@roC+aif<heZD$*p;>\nKd"ik]A)qtaGR!_^s2JE2M5UYjGX:LbCXGgP".,_O\>'/
64mXQsJhnZ[Y4UbS9XiGdo]AOkbI$;EGHkWr2)b\AmnqK/=,d;0n_W@Q2>B8??i%l^tWjQW$)
Xp9U;IgZ"i^5)!i?CX5%/L9'BdHtf"m$7.o$<LY:t@NF=ne0hJhfrHk4K@QG1#&\hC&R`)NF
EZ%s'Zq.Q]A9G-\(hslrZm;]A=Hso(sW93j1F[UpG51.F-j&Aodf4-k>BHt%Itj/a%G1S9R=i8
a#1WGMmuokgt9sM[IIk&]APlCnlM9-\kKH#]AeulVZhVen9ceDS,5t<jJWp2F>nfA)9f>I@ml:
jnm7P-Li^*Y@8B;j*.)N-oP+17oIs!/H2ZXZ5Oo128b@SY<0cT3n!G>:9IPh]A]AfL*GEnE$d;
SgMqX*D?LP]A)&Q4Gg@!FaR[V0n1D)oGnn.hr-$@o<j.n?*hi):nq(W_Crn%h&[5$di?G<q5%
M<cK+.)%CRP/E#6h,JFe[XMe:IH'7AJ@L$q_sqsHG1R6V6NA*))pO-,,!7k_EBV<\CjL;l(5
iV"JoEPB?!=o0QUq*'#V2XRn+)E:Pl8<YtdFNDfK'`Dm5q7<6Q3HX)'jQ1oB&BJ).[3SY8s%
]Aj7@0IU3f9A46m+@"'Z=aB'XeceeN)HAL\:GtLHbjlG#(boZ#I,Y[V'c3ZB-'(u$2_QCT9e@
gl:Dlmj^=:<V`gIH*5D:oiWaa9Q%OQ[poR*KL(CEbEr\;.aW9>Egr'P3PlVG]A'5KM&U<gq,G
0D%mX-<K8CHo3;</+Ku+N<Oord+S:,<l0/;"D^X>6"K/lZ\0jVI5ZidQ*oKH_H@GOW6*T`#0
6H92Ka9a3jHfp9UnrU)O<7c;mg59T6YT]Ab4BM,hn4#m!M+G.:k#K8Q3+TbTl!=W]AfPrF-UJ,
ED@kmh&B0Q!XY@:NFi^,UR9`cR75Z-B&qMa8Y8l9Ud&@F`j3n3t\_K9I,ACN-mMJBH[_^BPI
l-.U/&aV,A[@6*ehq-Bb.1$Xt1`tJCU`c\rR2k7?"6lj\(UHT1(9rY)o.<$b7^iaHIaZG.d'
^ZEQC*WJKWsMt,a=[K[-e\E-B6EH2ACc!7WnUC@>`rHL)@Ws.eUfh=D%k)+9/Q;ZWkZ.lXIX
HQb^?G`lWIE?Q_7Bn75R^HcEns]AYcf^q;A,e6.kCeAF`R9Q"&3RGVpgeF&(lhos;&#(5]AZ`S
kQp,CdT=O`M49B1r@9e7TS7_Feru@$]A-3#F*s#W^>f7^F$m]AlCdq2p[W^dG6$l[[eA&C0-Vt
=[lJij3^Xq:X[H;LLV1C#XQ]ACB)e'Ke7PmtllL9cW^FTRRI)4N'EQ""N9Lbf&$R72uXr]A)ft
PILjTX@F?-*"O)lDJNTN6$AMF>B>#okR/3%JkM>sp;nh"[<!@?lg\@@@3]A@2l"<':mfh#Lf"
&n(Z<jc%b_U)74gF%3`X,1/hK6>1-_PYK_b;/C$`!CH+.E;:=LXBZh?_&Z]AM'g2T8_9r/\YI
3[JaCnWh5CM&BC0X##/G5pT_,Z41e:i.Wu%/`gKXUMjXo,4'$Q8N:IKU9d,o\k=3k>GqK>fp
SXFXhP&8XS_2b-im#D"0SKKr=J\oRXSD'BJj]A0rP58HE/*_7_Oh=)<(5ZYrQ$<Momo(8O;RE
<^CN21G?V+!+`VJ_41Gu":U#S8e8BbfM7VZ+gs3L/lA-'KOhI*b=(#[2Gk]AR[MH6kCrV7P0E
k-"1LYD*mVs/UJU4e@C)LTD&%_T,hU/0;@"W+)]A=n'd]All5BW/FbUMT%`lSV4Fr6gMPWg27_
.H,s&IgkVb5O#BHP)kc-R\AS2G?R&<I1><7NStB2T=#IO7&d*fZ>5!?#W1^eV0EZ,$-JMWa0
Zppj6mF?8>I'foi"g\aAV(CKg\+Li8gs54*.rAm7tKsZfUMTp5HD+&Kb<3jp0W?<NIN-Ph_)
m;Bp+g!*>U:C9+"Kq2qJ[s*6,?;/2OgK\QXQ:Kj-MqZcaD2$7ob-&j0\/Xm`&A1UOgE!m\X0
Ta3\rc:>bCM0#hW."GduVs(5i0IeSEZ;C?&;DU9d;k+Q$a%\B0L,kR^!`?8;&UnSm$F=T6<,
"&H4B/*.u!jJG:l>Yc[9T:iS7HYI-Jqs>B*b@]ApX;,-@]A57dUQ`V(2PH<["ncbFFO\s2I`lR
Y>!Q)'"bQM[_t:FrAp[j#2>">'Ek[1qBjnC,.e/UXTU9G(Nc;n5'1o-#Io:#EkqIeAPKT4;>
8Epms78<=[dL)p[\(G)tI?Pt'="?15k(]AJPW-S)!m[24t"Et1Xh9h"c?4#]A\lF;S[-:r5F*n
I3f$,lfCTBl<Rq#<'@q]A&a&qq7ZnrLW37+eU-^MS&`\2(MC4]A=T>khSDV.&QDkX,[r@:SFph
ZLG)tWh5CHXr(jI%.W)n,5G.N0G8eL\M/_7W$.>2pF<=Cr8Bdj)D"Y`oCi,$)^&$JD=OfB5'
9B`)7=eAk3M$UOUHge[H%XZ6cQkel-;)VrF>Prr"AA@P,V/Ugg?R>:"f_Mq]AHhSB7V'AnN9d
KBHV%kRH'X\u%R6Zk?mCO3.p,k81qrk&;Rh@%<:'?]A#d6+Qp&$Qq8I_;//T@]AP[=.IGYiO3P
\TKb[!.Ge/Fn/\7G?Rlftogg96Nf*kS&f0,?-;;E;iL&:j>[\1iXZugZVlf[ObTR+RKbp1q)
QF0Z5Ns7Q)5(8<oXe9F"bp2OABMuFT;^jg9(Y4>k_sp8.G=G1MC3bMXN(U)edZ2shufOXrt0
6IfGNeY?KJ(A&SR$]A0K-(OaFF'Bh@a.)T;Jq+SmK>4@*;[uR7V9_3DG5KJ-=(F>NXg1=OJQs
XR#]AX/E)/#GsL;3#4V.fh^(<M;e92ERYV$(>M1#SDoC-f&Po:RXGoUU`dMU`MT*c[9Q)aYOh
[,UDE9>.&ba*q+sF%3ANUXdO1h@q`\NsGfY\]AgDA?*=Xd/>cSu%e&ZkHAJ1dRG7'pf0JIKu)
m/>j/]AYWg:@\%r?VB5Ep]A>N!03XUB;sgCig7r%3-+Fha(qEI?b]A_C.3ujVpUf;E]AFsESeq1D
P_85VNe/I\4Rq6otU<=^cd]At"h>lK*d@a+-Kd+R<UH]AYYYNX4C5hX=7'b9UdmpaYPulJBdLO
uR?h^j1SE\os8CAEc]AS:T3pM6K[;/:JGL5u8(D<[,[+LK&^ks-D\A*Fk<dbHF\?@BMP.8l]A'
@<hJZoskVf<+8+)!H&h991/H0Z@QB9+E)st4@7G4s*G"`7O!kdAO[`sd:?,X3dl+bldc?RF1
-$%T&U)PIrg3Z%52F)F<:mEq-Rfj<<%`+^;`2)8-/(qn(R&l.R%e9?Hj^'+=6jdf3K@'cWIM
]AA6V^'A)m"'Q*/,?1II\W(N-*g3Y5!U2&:8*ls_7ooj*]AU<WpJt(f3@t^&tu&$7t\;GXlXQi
j\O&dq$n/[s2_GkPR6DDg:I!9;qL"6p-:Tr^/Sf`$UGDL7.73T!t#L>d'<`&4^eRh3VRj0Fe
XJ,EuuracB-[%,6W94KOcui+f:`o"]ANWb-e#Upn.2@3aOEuG4C'$$WF!IBQ[YAV^*]AbK#2hE
i_?Xj,9ML/_qK?on/i\3MFsS>g%c_mJ%s=FiG$SqHP>8haH@t9!;js/ZI%s_Sh,]A2"cVMF$.
YNo-k2*4pa<.X7Y,$XkK!FU$m>pA@Q=[6eXobQSF6G6BPKt;A$>ku!2JD(h<;`Pjp?!_+Tm2
o%*VEIF\!,iHgf3@:/<I6E)-:T6<d"[P+(bI2lX&\[rZRaRWn_WHo$8:*J3^KVZ1Ps8*1Zeg
[)\IMfBu2YEjUe<k_*ffN'`9B8o.4Y<6R81C<r@?0*:[BE+@G`AF@[L1kM%@r4e$91t/qcMY
I^A+j8JL#lf"P7A!WS;UCTrNA.Y1Qd'tbTPjC6HoW3jBGIfLf\Bje[;G0F@;m*_6U%[Gg-c)
1O,M+$`*E*[^^4-J8ddI0O::683:3[l@C"@2tNlf_=UEY8^l40'))lTP0#T\Xo^=8WA5RZq>
s8k&e1,1_OXS^.e^(::YghY5V?[*o?M#[TRC#$\mrdNU(=RU[!WsB>?NhbnAn+-$"*Z(oa8e
^K\MMjp[oE3lcJ2E]A(m(S]AWABFH8")47d[`gj*_D9lH5mG4E,I<iaX0.(`pY-;XNh3\_J^9E
WDgbjLjsdq)R-!LF;9bX>X:Hnl<@:giEE3K;P8ZFNYmGRT=^$l-NUSIHVMUFG,)!qPJlM$(?
1XB?f6M1RLT"K@]A_umbn2g]A)TKudED\)@tf%UU3W'\^0.q5rn-P/1XF_fT1pbSF)SG\S-9D?
!9e@Hbqd5-?8O:C4b#A!f8G/m;qg9++l%4F8L\ZI=Y_-%@pp%%!p.X-qR%pi<(%S_mN4WboJ
q+b^DU3T#r\FFR#K7G6i6L[cn3l!"(>au:R^,<?jb@&hT2-#h12Jim<_>6PbsU)-Iq`XTFZG
FCZ4EjF0B6CgrJ@N;$K0^R`$?8%2)8&`erd/1">3=rA"ZLFU$:7'DU9iYa$t[iR%R.WHkoNn
'UTQS!a[pTV&"l8P>54Q[+_Fc0EN_9fl7D'&GB/V!<*4';$"-,2jV[2:I8WE%)5.D=Q943E-
]Ae*(;66-4A4=VB8ua`m#UXZS_"DZ5g46k?T]A<QE+%!qRF9lrTHC4,?K2!,Q%\I8ViK;l>`cg
Y+o'Nbr1Jjn(0a6.=2g!1?CtPp7DidIUL#7oU/(1!j\I7L'\-HdW`8N%hg3043-^M)%AXoDH
e"m.cH,S\`;/kRsDXV0.D&nf,CSjM,+#p#G[-rf=+Q)r%ZNeG9k8WA6k%q(c8+97iLPa#J+-
)$8aZ:pRGO.SK$rB96+N4QXMr6)H_j.qA[Vn1JNr-Zm-i@>9[#'7EET3RRn)VO*J6Rnd1);E
2o!C2Dbh9nK2P]A0M/NHK4]A(T781=&piAqI_sX-77.cTY5t8Ql7F`h(s*Df2"KE]A%N$r&aY,d
S1po$=3d>\/IK&E*7;FPDA7c.t4U,mPPpePJ>m*d=5q%tGQjlI<YW,efu,c\a=%Pche9TAns
6osD#3&%M2-JdA)eU?2q*nmcB&ZP:jM:V-4(1bI.c>?0@XiI*Ll(P#KaIZ9+]Agqel-b62CY3
SqTOoTD-%.Yu+M.uj*qfZF&8W;!uU9loiT^-F:>r#B5dGT'-O7T^s#ea7cS+FhEB)[!gk7sB
]AI$^F@_U9;maCPtTkDa24[[Z0C[Lsn1j:8kAa2OIqf?S%,iE-Uhm'GCG`89Rb+DAn=;_u`LO
g-#Xf7SNq91s+^WSfFsmpqXrBSa2V&3GtJD"Y@s50>M":.1:+.QL,9>C.B=_U^#VK'XiT_d,
G-aT71M%$W7Ul4,An`9Jk_=X)'-=BK$m2l)S3-Sh*09JPIK@HD^VQ@u0n4UVH@EbA3fpak9m
d()qA=k_+0TF^PeFY]A?G8W8+r7R+dmp0YtSUEqT;H%P_e$Yc_4OV;-:MIsM_,5Oa2QBE!6lZ
-4#PA#\/OP*,r.7R_P>'0$15Mfa-o!BM=g&d"]A%+rVeZdY+.>c;4Q)$n-p#Aqp#Bthsm:%2S
Y9?!ET:rLS'`$8tdTb_:slU.R-.bQD+(X;i\J5+kS()oo$TmW<YU0=%c[!NcYie;(qc3pO;p
a:B[Zno!#3'_/VHk0s]Ahe5Tq)_9Uen`jm4o\1Ol"411+?QP__K>$%;MWKL0r/7k*oD!JR+qU
CAUqO6=`Sd>]A%F*Y&*TJTn)&:ln<i2Vo+S@&7&_j<?IR3:79)#C+Gp75(Jj0LD>!29NQ_.Fu
&\ar9dtOcuL*Vca[odhc#LP&(c5?-AToi__@LF$*6Rk@7r<)5.l6AX]A6F+tD+5E[cifR06'e
.G@'0AQg"N(NR5*nMEX*a@5c7";35'nhIQJ>A]ABZ$r<pO*i/rj4/&Pl;ZBelg:U,n>T&le\5
dCAF8#87Z4loj$MOVtj9g^m_&D3U(SDl+R)bJC#QhB./Vm."&A;T@tLa$+X8W^g'5&Fi_>Co
1?>ebu]A\L!:c6eGldV@E]A]ASGm,cD^e3V'!d[M/oM^Rl%kcA;K-e?6/089gu=>m&*+t#2g)bo
99G"-@7Jm:dZ6i1]AB=VeZ1P$b%T@1J!!nAU&r^@):P;2Z!*aF'Q!?[56CpZ@%Hh.cC'.!E8j
W,9To27RT+H)b3dNGmtI(St[!D;5luN+r&L7Fl?gIK'4J:">B=K'/6e1!3X8>J`IK+PA=%!F
rU1$M,N(]AD#WZluRk'*?(sK0p"$<:MSk_]A)(]AliU_so*#P/U*UUP'r?i4MEV#@GO]ASZ^\2-L
,fj=!k;=:;Mh=G-61-"ruo<SsFAoRsAf,E`@k!_<TR[QeoFTUIMpNMO:*J"&&E3A(EHNGclQ
F!>[MGIT54tL1.<EnX]A&p4Yope?X/Y7_F[\HZ!)c-aGDNS"9YOXVZ-$K9"_NcgU<Y`?t9VRg
_c`0*\Rb'Ko1$Ul[.7K7j#Zm:l`%h>#??<enjQj;mk'u_D#19Cas^k<4#.q%k<nX@D3&d!'L
4u^<X<NucB'M?/%Q$[elS[A[o;f)cI_^XqU>QdnTSQctT)8LW9e=Fcr_[t@ih1/s@V8[4kO)
M!RA1O'%k"8dSPBS&%3PHA?Y$46.\(qsNA'ZIqaAE-u\:4buK!p07;M)u-q+$SgY`ADe`'Rk
KOj@Rs1e_QCpfI1YpR5O\R5tEW7dpG2R>ft[0<0TDL*bWHc=*#")*5_<FjQ(4NQKlPr7BC5:
&QO6bjB31+?V]AlB-&9Zdcnf=j,\EE)\f5tBCV:Z@"LEKSYl@[!f*m+ndjd,.94[FEQ^dh&*b
?KfegX$<"lJpI,:.u2jcn[#4t_r@pVJ6+j,Q&r>-/T(2FrMKOcQZPk?IpRi?o4Vb(6Iig4[,
]ACVVX#)?#M=KUQ*!?^XRRHaa[^^<PGj4H;K_JnPHhX^'hJBf_'=cQVcA]AOE4L).H\nP%rNc4
o7a,e`89]AM:>-;5"MTZ*i$0Ld-4iaair%CkJ-2bF$BUkYkBg7?TVFjPB,=GZZYk/Sbq$iI6-
\>W9#Cin:I4<jBC_^@s@r-qO>Z09?GI;BL(*%tcFd@XTpiL2je(`OC6i<1"Y&cuZmkqa#`Yp
[bAAJau4L$sYdrPunUPS7mYR;VIWDc;^"3?*1)&#=YOb`lT'3cDf3iYG)+*&,\#`p/7!b$h>
<7CoI:/W.R)ak=QX^#nr2>-+(a<]A^:#]A,;9uC(tgna"aM\I#8\5W<Y9aJ/doKHDDAI^S"1%l
$;E]A\'Yu2iEKXW[qC8fbrTqOS!u,4Gos3.$H,/p<c',:XZ>^"=V;X0MN;4jLZ6(=$7XQ:e18
r[5RSTSW.>L`&A@eHPrfXM&S8);Ei4YPKak\qC%riGM3#ft(ZVouMi>hdI)X%BIe`TWi:=6?
jOeb+]A2+sMk*Qg%(4lZ4$<D<T6g+NgRpY1V3B/9GeM[<$8Yoq0\17pu.!5p&oY?UXp)X#\hr
nR!g(RV(;Nui,bAUW7*6pu[k?rHrgN_:d,LIbssJ]A$;9om/PGLB0]ASPt)6'7)>\I(9dgf8*l
79-<X#D*Mem'9!,%)rrMrZSdJs=L#`'>O+^^"a-hl3</B.'DR)72DcGo,ai[W"7VPmk03^7g
obg[JP3&^YRC1K.\V3nk.(d?&PJ2G"#9kS/OW?%E/p&@Jk/lKgd6?uc.L/RKWm"Hq%="Ym`U
.tL3A_uB/q)S!s%oqeBOGcVd(8bfiRQmgS*0:aZ\t8CMnXcDQU@q_]AphB5r$]ARF(e5eY!sr[
?9`0uPMB8(9CsQ[9[/XeI0T*W1(P6Q5>5$ZhnOpYLi=$8-Wo0]A@0V>:%1;XjR+91[dZG/+h!
JLYFj(:@M@2JmE^m_D7DE*S9$+1.bO1b<QmN?]ApI?5U4]AcIbGq+8)NX3Yu6X?YiELIseWj.Q
?eN)MWM"8063kWQ,$8^D1RV^$]A/M\;e<1.6cT&[I#/(u1M_q&cUJ]AfP/`"W1aq\%-D/3)]Ap=
-V"&Y^4h]A2&lsI[I=O_qI9P`FRL9k09Q.pkk2+plA2QEAGt8aS`7ARa#<V(c91RfReg>7KAr
8g5s%DgRaL*nWe(W@.=Oqdun1PnN)4to2lV&.&o9emg4!p!L_8eA>p,9$X?tQtKJmUdJ&$NB
[j2NlYqMh7rOuiK;94G)?;CR%#aJ+m2lYlLVUebCR[;UE2>G)?$0MMDKaktn3q5$'_X8[Ni-
kJoi.Em+40ZkEjZ*g;#.R&jX-3LMUL/8_e,V9Oa25*F=52r=PY/Nt><U9hmo1:7>V,PT+=^]A
[cG.fCufe7`m!'a,chY`9[W?_o/?p1Y"b22B47=WOA=1uj;T&uO)<(SJejsKT0OF.k0^4F9&
rWAlkMl4<SM%/B0]AVqVGH<8F`psse6JA58`e<Y[79+&nq@Jp@hl^*J@R(B'@DK>(:7]Ab+Ko_
@<ddr^/!,egTR?K4/k[.;6`[XSK%;WDh'f27qhU_h%)V4,.b.3nk(HkCK$6[81t'-^8!1!JC
&!6Gi@9fo%\^c$&>T7WR*SM\F)?60_*>u5GX75Qc,/%&<c0320.gL:5`l2*X<@F8>jdODc\q
39m"h<tuN.G9tPLW,[iL"N'OloX.]AHg?$Qk"Y@-0H3(A"24cfEY/#qi*c=ZlAs/u%\1AJ"9!
i'"sZgI4uL\ggKC\onYq?DE4L;mFgq.3h2nk0,`#*'I^sRo@YkGtVt3A,eGc8)P]AuH=l^D5r
Gjg*)h6C1KR=Rs,\U);Wrb#E8CGriQe"5c]AZ3$fsX<*#N5_^_o7mJ@r(&Y\bI+:Z;U-^PCr3
fpaARa;dEAW7\S84629G;^#4G-G+b-^=?F&&`ZGr_ZWZ?U_U?dUGFV!5d--aN)MdA"*+"b`R
6lg@,7eMk7m]AB>1pIF`<q\N``/c$/7b`F45K=>A1oRrG`8q9O`i)_nnYiJ*s'hpKC3`'il>1
O=LbjBZL0s+1-opaAl$:j1jE.LLl;X*]AC+>ibCWH1t8:cScE1O'DQ1*K)0#/e"e+[;!",6<D
gZ<O)-JOL+9SUfDf=^\r<)DX(arb@ghmK,-At6,Q*t6L:$o1Uf(\["-\:2K:gXIL[cHIAo8P
`CGIQ?$._s_(VZT^[^H9?g3Y)Wi6l45-cLtRHAQeWEuO,+DUTD_:O##=RM&tG_8">h,T_5*,
l'2Oem`M"pB$qqU+dg93O&'0ptn=rV!2Wlg"=QnCH\r6*(/":WdT>/50<f/f;qS0ipQ`GsVd
Z^i(E`8:0@?GUV]A`ZL,iRdEKke8WJcta\a?R/:37#18=']AC<B*&o<gAo.F!=LXACO&a(,>b@
?HkFc\pP4]AgT2+FhpfE3c'?@;isfGSEXZa@l_Ctd=]A1*9h!Sa\*Kt%S]A/-LiASC`H;VHCK'g
Ba*4Ii>J;9PBOl.Bm^M2)l)L,!EVZAS-VuH7R*UsKd+OhII,_(Mh15#OrqeXTQl;_,#_e%kT
@\`2;rZP9k0U4CZSYD,Y@3K&Ag=7-tBsmnb7>6?H/s^A5:E\YNU6]AIe0$k-J;_$bG?M;&&TW
6kH=?NA?9e64Ws#m.[dgpU"'M-@\BSSna#6JTiMs#.gR7\hZ]AblhW84QLW4)$&'p@c+A.Q.4
LUBL8RS!;c^=QY?p#%SOU5\r)$HB7Y;/O_c1#"C(phM=:RqFQ]A&Vs*4=D')Rt9-A3BgeV7$G
hRnh+]Aib(IaAr&4cb1+"Y(?iOL6rpqW!rUVk@@1/Xf9SC'u%'9bNpZW:JI_1D/9-oqpLp[f=
F7j:qor19HQ"J#9i22oti)>b>GGRJn'8[&2Ja:\Lqq1CsJ6HDPjgK8;ooXLAPDRl4AKc7>i[
bBB,akW!jp@GL,!''Zn*nsLXP@V:*UD0WQ;gr^8Pq^Bl[FkgHV0"QK+S$S!qE7jVoWQF]ATh<
f>Hj&G@rBR]AVsFOt_;;dUPb6!gD_)ahdI#.#RA$S;:m.*:j%W5i:`Aa<Z:rY8[VK]As@:-c<3
0AWV*3L]AsKGrmL6:Oj'*I\+pa!qXJTK2<6bn@?bIOR!Kr5T'PIGWq0ikFfYXY)t=3'FR)`X"
T0DeU(<%@9k]A8NYIufsg]A$%"Gq0?)=C@n_*RIrHO;;qnBJ:^M5i(F:&'Yh>7a8tg>q0`ed4j
rjXsAjBJ9QFthn=e\]Au4)ZW*g_c@-_?RQC%,O]AM.1i_TMHVPbt,jo2I",WlOf;Q7K/u?0+ST
Y0K_)hnhZk22%`u?&"`03iIdgPH3^kF&D#ZL?2]A=s&MK(>4UpA8,a1sjS*N!=+@MNPUl<#2=
^GE9HC\5%*cC8ZVhE;d.H%+9pS@u)qF$'(j,VRs7)Z?g/h1-PRmcF[9G0,"4UAHeJY"U'Pm)
XR6`<k1EaF,n=@#Xau=$:eHaQF/N/qtV/B@bnb/iS%8LU7:?-IB4q?.)eo=@+Tmj".CZ\=Sa
:\XDP\;\:h*nk;*<RHb5)d9T5F<EOf5@+4dORJ-0!u`:!?HMos3*onQl>T-(BbqTXh,>q:\i
I5E10'&Y*F_e9`ucjImH^AQFL+?ND.8c9VVE@9.hI@,PenVVC:a/f,`8<&M]AF=nn=osAS0JP
^#\PLS#4)`P:J%[j26:r;97X3cBC(l&sm$>^NCs*.P\D`#k%Z<m!<<km5&aW1#I0$id&4o?t
.)_$+th&R`.:7?O#j:LAG+Uh4qRBFdpB_W*Q-']APe,^rY9VY"m<4ZC3YJ@V-6D&R4@Xr)bgi
\Bj405?LSUc(4o%NOqpu!5&gGZ[AP+Of#o(3p4ZNmbpn!13RIX>ZgWGSgp1U)G;/mcPFbBiE
f+*A<pMKN6M8m7Ds@UNiCIJT3OHEQ;Y:hcBQUC!@P>:3%JD<nPb3D(,^LWi!up%e-V'0Ob-q
0Mpik#t[HW[;#LqI.Mu;9&2?WTb8[Ib@M=J:&*'T/Vjn;.b9k.%hH5s0A3<Vu\GX.W^296GH
\7;cp%NC()eb.j!j3I/:(L`U*P*@GN)B3agDtGO\OjNIM#`Mmo'XKYST>4r/m,5gTZH9YJiL
A$P&(.blP:3KsB`*VM0KAXQRYr0F1tJ2Nig;nBY4X9.K?2!!lq8W^f^i:hB>R`]Ao`5Bibf+e
KU:LH+LFRYgbBY-QP-1%T&+Xk]A&#t!Q<=9h=jqC>qPc\c=9!Xo6\0IeuTM^i#=LMuZ8P-KoD
2b&s9n_9B-rd#NDIG^6gTi/H$_kLNIulq5Zf1F-PR\]AMPi9bFgZX5P"FTl,(I%m$D0ifR:o/
u`0*kq.hm?\nE8$a7nFaZhq;_OCP-Uisfr*&+QbMAE9-SSp:*?.\dF0@.POK(.>OU?mh#9e`
rk/#.0,56pEm-.24TE$))]AE@G^c>e[U[LDA5X^eEE#`o36s,Z<%YLDO$7bU+)\m@_20KuD4t
(JN@b2ZRhepcE)<^!]A\3d]A]A*K816eF1!F[N,<'AEn.?mH)fcahlN9q=ZZI'aA>H1NZiYo064
2F4g3?V&OJ37V#aX[6[IVX/+HCHfN5N-!mt]A[RrjfkEFaYL0_)YD=6=h"7`,9=GcISq_X=t9
o+_ZoSAG!)2pZ3P'i&7.h4/%`0%/uoScSgqFU5!Y"W_5$.aRF^)^)W3"^.+q0jeL5(AA/6@`
b&F;r(^mCrX=\m2EQlkQ,3X?3#O$gRs4B7"TNn;#0o%BU9Ih1[>YJ_'go>?!#!I9OI,A&dO*
c,'uo1K9,N7CoWZcM#D\;MrD.MhLG.Aa&`:/2m>kRqS$gDu<[!6A+[)\SKslj`(c5\Gm\oU+
X9td!)#'+D7P?SLG]A<<n0iG8PKR.@8ATm\rAB0Ru`6i1D(+W-'3%p*f5$9*;ZIMG5stN9lDP
FIi2>Q3)Zsp;73#\hh:D-"?,7*r/;FaV/fI`N,JO6TDg<t^ghqRfZD`D8%0BMRpT4A@?kd@?
-+Hn7!Wl&Z@kF9F16t#l>o7PD.t%hW8=Mn_R$9Y(q(]APT/?5BZtLIe)'59dGBJ#,CP='agQ-
`^cCDrKNa>Zij;o-Z^rlRu&1(6LQ(O_Bqf[Lpkf/AOVoGqFB4l'Fl+^LkHU?;]ANb-,/WZ5!C
lCh_hn(!Gi@&)3<A$^#UA2DsKjs)QT8&-0:m,7pM!!I,PC:]A!Ze^<I(<#'uF+Kf^5LWg>r,$
b/p>Yd^B"$PaR&sJq<4Y)XFnLO'ggWi3IRr!n=Bm_63=79<q0K/)C?936$IX)Sad(iY[;)%G
;6RoS1Xhb,aEHF[U04M/62A8Is^K[iB<J^(Mp=SO_1CYL`Dodi74JpNL-TZ?5OP.>pA+RhT^
dh5/B$E%';-+Nh=^58%ampp[<i,_-`u$p"'lWID1`P^`k,V9?>e-_GjGR/I5:s@QbNp%`!"2
DfI!?-,;_m(o`$8)U&R]Aonr_/#+nX3OP#L4_F&^G#CIGMYo;_!Ln.kqJ-:e6D:-?1'+1S5;5
m8Ek^[@A)KhqhTDcC7K9EePIEC6WD\U$ha/X"l+H0gCpshGN851V&I^drM:UesHor0YD\>f9
54TP\a[Zkg9Iui]AlU1kk9tS^`a+%BcQr3lB!*"9&jAT-SZrG)9T_[GM(Q;M!4&BSJ?SV-*%8
@o*T"!PoVlGS%XJ]A#7Vt1%K.3+g:V.$fa16edi+A&M0)!7Z-+uZpWD?nrTO\q'&mQFPZ@*bN
H*E$OFu<$@A(A4oOqo$.DrJ<O?.=Q'%WR)pX^`3WbhY,:V7#=og/"`%/E[Fq3uZTq@sD"gTP
Z5%[T1]A?b=6=Akupq?9.;#OmkdB'`O$hQ0E?Dfm6BSYVk,m'lc]AHDAl#mp2B8<T+;ZF)S\&V
<1<bu:.VS=Q^Vb0-;2`mib$7lbC9$uBP#2KX)n=0QaEjB$ch<s3T)6@mbl,.@O`DumF!;JOH
u$N%'#aTO8Z8]ApC)iKqn@iL&0a^`M,';_Kr@?M6lS!,U6f8HhFg6IK$d)l+X@ZIN@nE,1-23
)(+"9Fs1(A/n+BqH=19!cgh37cce@Q`]Ap@KBeROdRC#LMAoPA.^IZ>]A@.4E:ZM6D4A'3G/K_
R%;BO7-p8<K%uSS]AdN+@;&sn'$qft8GAA#/aYe53c2%DfmLNcMd*D,_7Lgpn?&mtpmiO`N7:
+lA73>_Ah4EfND;BeeH06]AafLV/!i%<eWRXOg3;Ii0f)PHTS]A3-jVbJ(7J,H>&G(P#'gHhIi
5c!ej/`BZE>mhk;[fZ3DXts.d2EVm=SeQUN45`k>IqiHuj5"D&]A@uAR-kh>LcQ04u[#\"J*G
#4bO\`0fWZHef`_QFpI#1*:6AL#r\)qiQDU3;-O@'f.>q[k?heqn!aQH3.mu/YlbF6B[l;6M
+m]A>,S]Ae'L#!&Wss#LfcQ8@s01455+\(\5:bfp&c>]A#NRccZ9$X(.6cX7>;_#%Zb7,8=O3Ge
YoAVNT/T)meIemaD1r!Xu"sImjksX<cOF4-/gWL2sj`ff8a+nC3IO54OidR]A8^pC%rotUZn?
0Y?TB$Mc0&Ndjr1GTp0jrOfj>OohR8R,#fG:XKjb6]ADLVa?EE9e9;/X+HfD)!_0=kMYKt&Ba
CjRVg3IA)(YAMO\_qt+:20/V>(mLU2bZ$/K:qQ/Z6=V.FSGZLE7CSb*(f+NOkgClc&82e#$K
3Du"<A,pZW8CJjRS[YJLdKrP^28sg#+\25NO&17S^O?WP:XpG=]ARh:SGHl(MFT[+VWb36k'a
@;*Z'WI(u$%B7OJ)&Am+L*'/rO)R\D[r!W88'dT'T,PuptJ-A='rUf\Po8fSV8*'BE'i11l@
1[S!&bAT=AEpd@@snm^kUuYQ(FKhhY6LN3q7o?Gn'MkmfOT-HRFS,^ZW2?cVJNbg7@?2]ARp\
8pq<PA"IP=I'<7["CW]A]A6N:nhM_k,09"PUP+>1K_595&J995j?HiT2]AM8]Aba>^L<&1+U>#.m
P(2^*6$Goj]AiYuRaM`GU&QnV-(2;ck<41nCIr75L#!W:YT!,aQr<Cl+$j>kRmOZq)mb:YR4H
0"&Q_$n-5PdMt>LU9)2Ea*MHlPf@Vjb,$2&SH@7;dT_B!-(47NQ[7GZ@'u,7#L3niaBf0h<,
iJ_P!h+jY`kM\j+n_1lqGQJ<njPOV?BokM/@1A)Xe.W,&*,uSuAd$NO1"8TThLpo02>.Pr,4
]A=\`_c9d#WPbYh33rqEk<R(n4V(oN^Cn-gQ/kYSpQUgZpo.P--<.Q9?mdI3,adHg;0<1Z<DT
kHn$]A&i9htUA^N68>TsFH:Xj+sE8,848^TehO&9]A1sH[4ojOHYfd5;"@s\J'#Fq0\0)k-jgu
/g2?jN:_K6Df"%OG8;X;?:GrY?Lbs<7g1>1LfoZlosh_Qd2Ke,(12Y7/3+6+AU@NWh*6NsS;
uF4*7*(jGS,EUX&%T$%UTD3_d/%_fS-ellQ,[`BlR'=(ugNoq`;Y7-]A66d%>aHH>f8OU"^dn
lH^h`apO!$>*E)`UH4ngWQiANj=f_:0"sD1l>\soL^:h'f]Ak_N25?>H`B%"4so>AFMhi)X_j
4n,(_8m:*e2,m8aHKgp6OI2OQdp\_[8qsq9`#g(!N&-q=\EUI-Gp6ohD,d!Kk\jp#Md0N+Kr
?%'`(jP)O9tQ$nX=#T?R"<jJr)-=?2Y^TV):b-C]Ag;/*_-L-VE(nE*jR6fYHhApB]A<jr$9'W
pb5\4C6?kj5,tqIM)F?#0\Ln3a=of)l??itg8UO<R'dd5-#r#d=<Ji511;(nhp[Ob]ALU6A"5
ePWV^N9=-&UJ?P[>8@1/)1Pd`m?k*(A#,dl4Luj3:"BoXRpDBDS'"Z/GsRI+A04Xu?T>ZaP1
^9F:(pm*iW-B@ATI)pWd;&3m@$,Mh!6CacFKM&GX.8I,p*o(-/+OKct#)%P!1U@K?Xo,#(Y*
7Tl-KOD\3#QK^sH03-.7Tg\-_(_E`Hjls-C=lRG346s0B&0)r\eQ1@3?Q&k5Rt[.?q==+9&X
QB68$6`%s"/0jG:82J=9KaUH/rf99cP9IFHF6@1)d)<A`)e;ga6LW%>3nAiI5,N78[i;E3!'
>%^M86N#*JB!6Y:#Nj#G9Z(nXGYdQE<,M%RO'KHhpMr5hQ=GahPs"V(X\@!q"0uWh_p=UErD
$uiUea'122IesR.jMOep.`(.#M&h*I?Cg.(5+d1F&lT8L*G\]ATI+OqfU,]AoaF[A*?ra`W`%g
]A>q@IZf[rPjE.k\5r+an9_3JjA?+b<d=HI@!?t)EdV@rp^)iH_A+d/s8S#i2jS8L8`7K3iD-
Qgq+_2KYMdp<^@Tfc#_X%eqM.jJJ\2aIs]Aj-eTI+[?\:/m#a\LG8N[;\);,>!5/rO)@,SPT>
i)$OX7-6!(sRBdN8F8=2Or489"Qh?EbgiU'E_li>r"[@@M/Y/F4GD9OPa:-]A[HlX$ZN*XcFR
D5B6=%Reb/8!&RVnQj$h6r)dg/Ofac3>RA\P;bt`U%%G-b6qYC2%dmZ;q(fdQ;p"f4Y96"I,
7N+^\Ug#!FYC+WUnZC`-n6nKeJBB:NfTW44n8rY1X.*Tog$tmp]Aq1L)LG2gB7nYTG<!M'BOP
/CVO!.;67,W[`#9RTEk(LS9;T>a-YY\io\:JD>tl6BIj%mqm&C7S#j0]ApHakZ`1Q48I%t*tc
U8&a4trP`*gcXpNWq5uh%`fDW%QHo=Aea*Aojm9Ep1Rk;-)D#3=:qX<RTAVkrKq)i=GnlTt.
;n[a)EmlE"U8c>=H2^utefG.biAQ)+_'j*I#Jqca^X>`-jWUijGqULjJ2T-9Op[=p\%oh#3U
7<.C+=;iJE+V+iFU9PrBmu^qR@APK79jLR,MoQ6jb3=hJR6LO9?DsgO+0fZqEd:On&H-M>b)
_gRI!;:YcOi6?LBDp$6)o0A,OuOVj.J%-=HG?,4H>LZX*@R+B]ABu,fC]A8SrP/euWjq%ll?=3
5<I*B+@tL>;'8As+c#Pob3EDM!%e@g49C5IZU'=8f%8"<!s,nb-nK>(^1,3g\:b.4oQkALN"
@`K]ApGp_lE-2+AqV&mb:&EJlMK$&Bkg;]AP[ttY.#4\D6/^iS`#NC&\OS"7;2itm2]At*,8PT2
KbFD.1He-5<>eo$5j^oe*+6AsJcMlihWN>jk*+8/+-Csjujg1eAT!u^bX3rC%llJ""I]AqEsG
`cr_`a&eVm')QOkj<]Ail3_bH76diF'`nG>h>O\95>u!%KXL*t!5Q6oGX<iaM/u<-EH["-u6#
r]Asj&B1W.)P0D(o-Z^6c?;\NX5FhKnNDja:J,Pm$f_ArH@_qbu_M+A3YQJ(fsV'5_kM1jcT>
pl[-#1QK7m+-A<?#F2aNmEnDSm2CK#$MUiUD=0nF&fS$;6U(;Cb[(p!1Vrd]APa=c?^$^\Y+`
NX]Ad/9\^.Yrq14WBj_8f$bMa/m7U6:<gbj]A_Dg)!iE:(+bL\?KTb<k$K_CYZML9#(E0c_50m
'-Lpl[N(QR<EY@4ql`833mm\NIOP,Fm'+O@>OqY%<[?rT%S^6^3iD;Frb3]Ab!Md;"*hjJ?8?
^2G5X_SIc,fKahua+#PqVm.i'E6raS.`r)pa"tTYs,/D/Lo+<GJHFWCKP$PKT%Ud\-=to`oW
+2@VIu*aD@UhQ8Oabb9-_-8^C4XC;_cIik1V\AP3V'2MV`.Pl<jc^B.b^g8R]A7ik6?.\T8RL
7h1'sHNF*T:Loj(1ASUC@00%eOc,gPQZ6m:,9M]A&KZ-Qp6>ouO2%X)bpiBN0o/2D[I&.8u[#
2I,>R\Zfq_0@qH.._EWhS3B`\ukq@R@i(U,XRUn0^d9=+AI1\c??Au.G7@[7@7d<\Zbfbb9;
ub?Y8@gPd,Lh\P'/?!&kJqG=a.?E/]Ant\%=fHYB!=kQ:1"Q0<Y2`fAoEM/Cg(`?';#k3K$od
QSXi8GTd_hqrhA>DW><8>(qJ6?HqBSZ&h0K$5/qa?%)'#<!eDHQ<X,0h7iT`mCb?)3neT&F#
)i-)162uE'S/e`i56U_V'&&.6:<?ER`I4D"BAnN0"Yr.-g/^NE`m"-&RBL8NFIRV&!4H5(5l
B8fXc/N+\(D\KkYoGD=Qg!]A4ZMV#f<ec?I]A0mH,Ts,'!Jml"AX:hWB*J\EtL(\(?3bhoWj*^
u:N9.\Ilu5@7NoB*7N+PT3&hWI,O?;CC]AT2@^KdC:KXR,kDQYgC&:"HNCZN^l1C5:@lTQiR4
9P-o%4-ATqY=j!jaK3s`).b0QkW\]AONAU1hMdP=ij=.e0&fV[,WT@J:,E0!Sem89``AID]AY7
,>05Z$uQJhm%ND]A6dZhJ?QV5?&)KmG2.`n6G9$l5+k?X1:1]AJF__@/JXnW=)8);,r3.t_>aG
K@Je80&AHal_%+L>s(>t6adT-/+NOs^%t17e2GaWaX37#6gW(e8E?SjqSG\QP5GMY\pQb\Wd
If+)I=7[K%AQ[8F4m<>j^X$e^)aM@Fi=;r:W&T?D,19EgW(fe`F!8DggJOAgK4nl4*SK9*NX
7N3::1O._6JY]A4M9hhIZ\T.+3TU27lbVu4d>VjDBb8H'EV;%J#ZqE<+;M%rUB^]AZHcW1InF0
?,+.P`JrL1&@$q_VDC\/iAaPE#.-]A"7lWdOd(1B:u55H\Wg.#R%-An"csT78kbQ$>aH,ptOP
'?A?>Z9KZsm[g*V`ZsuLVsI@Rr`?_'2#@[?leAEV^MWg>bl]A`k5%kBJ5hFbEdPqj+q4YnSK'
rA'Z$[<F3_a[^QDZNL\uUh$4C?F/`5f@Q"Xksk%^<tt\2nA2I)KBjZUC]Au!ZR`aM>#LN%$>f
cUiAV6m;i3WcT7#M1H=AkR6:/C$n""p9rami@f0W$;FfDC@mWC1BR'k]A:+-<C_3HC3$hICTd
^H%\a5*<7\<rQ4*N.+k,lcKEU93L-:Dl*\;B'`lVsu,r.CoCua.lJK4]Ae8,OQ[d,(%/k;4*!
E0b9A'6:+),]AoNgfIIE*,sCT0dDk\/N\%USpK)9gio)gh%TiCf``PWc$2lk`Gn2Y!i%=YC<6
j^iD*>_j!iaobC[m#.p-J>O5,Ygm^,]AA0AD3S\WHpFbNE&=I.WDUK(9P?;mRJ^(Ma@3))+^!
W#Mr'V6n:PZZ+Z9A'`0]ACl!7B*2l_oET6bqlW-ieU_+=c*0dm19Iu6pf)TdqaM+GjJB]A7iZd
5k"Qfo@0>fIk,pTK![iJS#+2IbJ1pN`?I-Ji!4UUgg;hsq7?X.(n?^*%TPEJP71UNtnf[;nF
+bj;+,oHOfE4qTNg-H7k+6uEKDoZBRPqdb4(t3j!]A[k*..jjI;b<l<ad'6H%o@U,q+,Ik#OE
ZT6&Va]Ae9S&\!MX+.mo;sVaL@>,2F,@Xq[Mn[h$LkjIH>1Gk`P9\#q1bt;Hgc$p0<W8E1`Nr
0L#qE#Ss[B;6[WAW;<e[A-CQi$<j/bWgQLG^Uk?\hi)'E-bU`-rBJ'JInlC\CE!Z6Fc%^=SJ
kPQ,_DNRAS</EgCiR4/HKKN\:gB#&J]ATG`[T50BJ,4)98U*3o$NL!pTN(Nh$p45>3JQ)RA`B
aIA@U=s%1qJa1gPY0@FU8Um/\=oYpugqJS=-o"!Y,*b_J*[B/fQ>AEAt$0?ft-9iIMK`*1#5
kTI76BO4_F=F/*N5ps]AgE8ro_V;6*1'ODscFpD_/G?h)>Z<l,j^G+aQ'j@M2Jsbp[*j'K.rq
?KmuMRQds:stW_)1Dm4MQZp)!XY@CWm\WbYR,QP8L9_LU8AFa<dl#]A2E#[YD8lZ<K[\1K-,4
n)Kmr5?d,@<Lf]AS)2OW/rfbMK/u(&;Cs;1ZqSj.m)VFa/2KB($O%F=J?=m$TMh1dfD*2Z;A!
]A5X'"%#O@"*<C2"J3kb/H#DDa398c'UH#N\JVlCk]AM<;t?/g<6pnep5<okh3rQ<Zc0CH>LNS
p5qH;D'Qjf5VuGch,.0ilLeDr=n3fP?U(Ut[r>c>$qX!_8RJM"N+R#8SHol\g$.51]A#*$?Dk
WiSrp4Nm,R:G+WB]A#RC[*_a!FF%TM9/:"#10L2DAZ$O-pN4[_R/7T/fj+o5=3FA_^dTZ7F!F
GKS0n``H&]Ap'A3rVDT)'L([XURs9&jpchaH)Nou\02p\YJfcftcc-u#bETAB0mN6BkN+rDb/
jq0t<UW6Uo$i4d:$cYaD"og_8QTC[WI=2B7M4t#V*0CeW1:Vl7E3tM[c8OI"5D6;1b_U;;Dj
sIPJDA"Qb<8Y7dBdO<]Au,^6:6B!8!-92b2K@tn7H_\'e7Z,#q>8m<$`p+(,\oJ&R't)9rj-\
/KeY(`Fl,,6>N,$BTAY5?J2*QsF`@t-2PbEH+k8?E:+ZSeA9<.Si<emn54DG?Yb^&b'6tA#Z
siW]AAU/Rg_)0VaBGV7'P)R,cgmtoi4C:GXgh7VD)T<]AQk;Ma4)W.&ji`@iYq6=(SKk]A^jB'!
&Ec#^0/2p:&^VPJBWLdNB*56=7=R=Mm2a!Ck8g7t!Ifij/CZF5.prbb2%CBJ0te->[.k<$R!
6&U2uTDn@U*nXuj3r^Zm\rQu/9U4_Oe.O]AN)\;:5-Sp2FI&_ma2_Z`8adc3+PbC9uDS?]A.TR
<#G4Ul@6/<D&p-s`pYQ)43H\QVG.U7:U'(j&;ADDY_2>;WP9:bUAR+FiB*,Z"4e*Y$nq/9(h
HP6A_5()0@Lr]A,G:4gCD'[:+]ALHs1Ke*Nb7N6+#=eQuqph]A[58j4K2k1`OE$'+O@)58U,U>+
!20uk^%1::!Uo8SZVK%2`TH_i/]AeHD0GA4$gRV%j%Y[8c6r4)m(/e>hk_Ep?N"@!$29XKHu&
YV4h#[m)4%"p'X#[h6u'._3KP0kS(-'S['FjJYWbV)dg<WpcUbT8/8jEaXRT^>GKj=V/eV'N
<r-IPSiLt6]AeO*l4`AM"&_]A`poFBF;5Z+.EmkJ6Sf\Q)326^KehfIYcX8^sgeV7WA99*3?mI
LgnpJtC/WSj"!Y+E7t-PD^\aNA:D1572I[TFL=:"3lN;?f5;=;@?t3]A5f3T6h\0TdGk3a?Ih
Cm$Xn[#(4<&PFk9V3>"ltN^#na(LL#b,>YPRgt\@<i]A3-V.@B"Mm<cR5M>]AZ8J**F,.@F\Ki
p%/32p!i_0f(]A:l<quH,'G5+#jqu[J,RGng@k>08l95fVBZj<U1\4H#u)3VUMq:..>Q+9nR"
88O:-pdHbN7)96]A#?N)RRh$RO%:k;.'k(#jkbX5VT\PO*2'[Y89"APs>63_fH6V=kKbEO0L%
ZF_15+e&s1G'ai)Pi&9L\7YrnmE1]AaM/oVK^HM_eLh]A"a1<M!+EYK/H/i>5QUrP*sWKQ58pK
e1bCCE=*]A^oJS.N(1+Ic%Al'+nQ7(%>?#?)s[iFU+^>K;Wce7p5M9$Z,?LRb/+1;[9+l:W("
5HQrfU$lP\JQY53Wo(d>rE(T_/G155X:qRL82!l';fLpF)S=K,:[RUiW4uIouDfg,;?S>(.R
-W#$<qB)p(S2O"%hW\?:1*t$V5.9F+4X=^jPe'@"\tK*5V'$!X@+fFcp(%A5=X0_g^E\5ohL
D*oCAK^`PYqIDO,tgV)WXeF%O_B\r.A.JL*D`4Dd31i5qJ>_Q>\B`>-;5(=E6@\Q&iQAI&je
&_?l3hLd#tC4WbV@l@%rfJg"klFX^%$.jBqGk6G=R`$dGY`^hXGJNYM[C-_JqEJ$)n:H7-qR
FM7j'PbH($hfbi@d\TCFOi$DKNcY)DXN%EP<'(YqX]A'e:5L$k'W^W^-JF3H]A1\'J8>2.8Rpa
ud!B0kfW!u>>_W/\//3IDdtfjGXke0*/oN3<Hp:ak4pd)S<`*pEH>Cl)9h9_ekU:"3T)j]AL-
e1%2&'WsYb[g`+jOiF9EO5LaK-DZk"sokQd3K-C?>[VV#-'7=?V,A,!\2L10/a3b6'#@;qIC
*ka.Zjc[4]AGJj02g*DG:)2Y3Pd[`Kl2p'L<N]Al)5X^AgA26?/:5pZcq:P_%\4#+JSfj:+.DY
Vi-[n%-aaK<O.&1rS(]AYP^\X#M;&-H>>;cQm>;KuoO@#_j.i0BZZa&>5\]Ad/0RLCh:&qaHlS
VogmhSWr;F#[j_]A0>7gFr@]AGAZHkr37ALl9`<s8,`$;a:P"P^l'\_Baii/Bp8Lcn3%KAoJB(
;&ToA\?Td#JIJVe2U.@eTos)j9_i/Z7DQIV/!s/hlf.0mF]A1Zj:XO:&$71YW\9A@]AjNZEk+f
)u\eYX_#NAJ[.S)YBgS1\7Do;f:Y<@bC#\.6Y!RA?"PG^=tbSAhiM(]AVq4/qAr;iEB%^JDD4
l@`UGa/"F9I)HiGER2Co?Dgr**NA;dSgXq\WrT,8(:(sDoknGXm)/D8Hmr,-l*W?j>U7I2F;
><dG!T5Z00Y>LWq''MQbqd<+0UuG7n;@qp;Updb_Nbj/dAYb5WTa*q;dAl>U$G[dTYLqbi6P
n/,K6YncZK=uE/O724'YJID70JVu1Tgh"qsBS!IAt^E0@E$E]Aih9>$X$[(J><(F&7;t+\\W;
WqPmQK\8Vi3A%>[)]Ab);j`dK*/:2@l`U*:loAYqi3?j'[EJom_5:F=XZBH9'5Oq>H8*s[RhT
0;B)'\up5MX8>`ribIrMY5Y`6W,g3Le=oUJ)^8Z>\SI0btC=&,Yk7o12)RF'dZ/umY@[_fen
:=1Bg5+,.GUF+hf#Y7Z>?\cH[O*1%te%k^)N0`8B<!BQ$BJp03YM*Xs_B8.4IGR$:go1U5^#
c/sZLVV$d+@VpG[NM$4!qF6%IDm0!$"cgFJ')f@,Q1;+2R\']ANAoQL]Ar!iKdO"OQ8'dBLS?b
gq_m,i,p2f&u&^-6#LZj<d1V+`%.9sk_)(sO%1YB.:MG\A2fdB&Za/MG!IWH9V@d1[DS,W1n
,9V'[jXO7ONaYduE$ENAiX7jU+5?]ASZAju\m+"O>bnQ#oS<uRoBpm*]A^?G3(AHj'3*CH*5mP
FVV+n!h&W]ABbIU:DD1]A)r<BuFB$t;`GAJ*^aFI_:E78iV_P8F-V9uc_=>i.Rn>/C3NZ9D5R0
mAcig<K>EXEb,[<OT$!UR\pU"Og\N[+f"_scK@9;1*WXdL@>LDU,;_b"JHEu1[7))#Lkq9pP
l16NYSBkto*go3&,S-F&WC(uP=4Mlq5o]A/F\3A#gTSM\17St)tCH\HhlW/CZ9'1I<9V(H[Gm
ZU&=MV.^LoBP[a(_=H9gB@6X8**%aD.^HO/0u+HG:IW.f-5?-XM;pUOnP5*)1uhra]AW`SjJH
^8QKSNgXdIh.t8k"42k_Q#"'iTU_5Y9:PsI=1K6n?C*;2b*^?%U#psp?1#UpWH5&C@hS/oT[
6$joPF%5^>(jVT$k^<1SNOYFnfPY+MJiE*h,sCtRMs@sr6\LGWtnjHjM3"Q&fd!X.ps83f^1
T7[]Aeie=^R%P]AOuNZi>d'UqiUd'K=-HklL&nWIf[$;$&I[(2@B=.aWdXR!)+*\Z/XJHbBmYO
D>WL%+#r%8Fk/NEbs(_3d?Ntep*X^L=id[rO>dp70Dfmr#[W;?U\t<PBq#@CYl`WiR?b()54
#aW63*cik:4qs*%r+ZlE7ZZ/+4U#<Q&Uj%n4_1'jIRHHY./l%P1p+fCeku0_<m,6HX!]Ai'pn
g$FlAV-,7Vda)^;uIr=T2YP:7:^,!O4ADa.s,FF$nJ!d[J?Mia\O41tu1:sll3bec2m[-@DE
UGX^%AKITk%.56_BL5AD.p`Fbia%&Bt=)Z%h%nO<!X>0FC32+8L4"uQ^j<iW)P_jm$;Rq\Ka
l*GiCgVFmL\Tl;W`boqap+?DJ+2?tPRl+Ulo<GH7H=<k3i3X9h1W1LsIN;?&6Lq`R2fO5dGd
Mk''JY>;$B7H]A1R#>\Ln\+Csl9(1cr.u9:Sr?NcK:X-n),O%.hCR;(d-,TpR4i16C]AWlHGPh
M@jJTMJt(2o6*@<X3b,&i6\K+ALjYKC:qI5jrpC6(Ze`u(#;']A^j]AAbHYO]A<,V]A^+J*8>+^l
o\N6@IEHe\FTOI782*--Bn;)0[:<K?s10+9o"A>i(?`rb?B1c[7J+^F5CZ4'f*!4gG$smj05
6Mcf5KmYB2TYn2HeqB7XGiPC2n#soU,A<m3b,t.D\u2m&r"3ps'!N@U38:?e"/6ng?FMVWc"
:JnZG\2VXEHm%;'j%k+_t#4eFCY!HRtS.^+<urMHgl[l1_LEI$m&\9)?/jT'Au'K)[=H'l%k
@$iQu@Kdo%5;cbbQ[@9iT(:bJ`sfi[>pr?P]A,>_<9F:Y]A2B1g003B/u'+91BacY`*;3ZD+9@
12"D<4<=p,2VsJ04j0G\U@1)l<!1a\MEQm8%&$/VBg8Em+[D83UqYb=Iu5Gn#2k[U<RVn`ld
VrVdGVVuZMoFD8O^=STp".C1:0d*D'PY_CaSG-USI-&GYXd$2YWogl+I`7,pe(_E"X3jfU$<
.0>*"'Wh[UWD^(gPB@^F\8tA2b%:@p%sH!6;/!k\?-%XW2*=5/.sbMGO\R'(4ie\Je9c[Sb]A
j>.>.iNdB?-mL$ZEhr)'C.4^=l:#pd3"+$Zg-[!$,k52Vk)rR6_'@<tT]A>!@hI`HNf_Y#"6V
R\Xnlhp8Ie:+LRZHcL'2_*K!eD_)-BCYR.?%#jFNEB(sMN5gPp^uWO+S@9jFI*6B]An0Da.bm
!k0c*H^AJ06Mpfh>'C5<kiu;Sf8TH]Arb/PSYGDo*THh%4uS$;":fMGRC@`3L,c&$jMr\7I:l
m9<kgins&p)nJ@N5:AME8mE!Ol/5YcR]A3e:<9rXp-><+U+Rm]AIJ:+UD+=?;3#`>j[F6t>LTW
gPW5Yq_5Qe;ka\SlhdO+pnIp:e5+.QR9),_;j'635>'_O08l-bfYF:%Fq5:gS5Y2jm[l16)`
2)6p1m>FAh'GHd.WY-rM1`9srNSBLO>P^PY6os'hH4NHk9T?LAaNnZBR:nt#R+XNco6/[aY\
?IG!k'7FW,4mY*&3+`Sg6@XpL?6,o`^OB<9eA2hFrU_6N>_(+<c4a8;%&q0D]A+Sa"Mb\j%E-
PEi&84hppHh;8YJT#3gQX4(qW,(O9Qs9[`4UBpNj\eEbdQ1GEN1f*_[t=_aGL18dS_fLcB?@
MEQ"*4%qfl'f<Z12:+*`spTaN0<[?gKo@Vc?3#7CG_QA3"l/N&l<EfMjhAH-*L`9HBZD>3eP
F(c3Tc3I(,=QC'+3KHP@R5JgE]A-.4;+]AL$/diDO<)5;/J`*K0#k@A-jA;Sp7X=Ttn_Ug\>Ok
od_DU]AN2gH"Rl"ciD-Qj?9Fc1e(JTo9o82Pa4Y>:?^_6Z)eR;SHeDF?XHjoh2jrR)iV7"Pm_
V[inc@#4\1A>K3`*<@>[c/p@NP)TRAGG#q78HceM?9Xq;=s(Mu8,F9g]AK$N#.18YY"lj`J*C
'tt2Lelrh)d@^hC_`Km:$Ds=G-q`1UYeBJSp.Y<9,saO"7G+WkQWhW@un[?.'Xnc*9`$WEh>
#85j-n4gmWk9g't%SkhG)Ma`6*qPuj<DC(=F\dL2Y\[lVNl=8YN;OKH?(n8H-Yp23s6s@Th0
!li?SV9,J55f.>n[lK):F>(^""UUq=+55Ir17`K23n`Ba3:%Ta3ORT%L+[/K(;UNDjr1JbDW
X?k2DdUG&9;7;%5@M,+V2KD\nHJK="@rR>!ntq!N'%e;1^2'?L>A.B9*Zp6B>ma@/Q9]ACYD1
M"r`8orc?%XkbVe[Z<q$HbbR?'of&FJ:tl$>5[=rTY4>?'\%;&/TZ)Q^f2I6QLfOT1HWoLp3
ePnV^?l^6t$qBKu\`^$&uS&-nmgE>8=XQ8UX)pieE&a1)@\X]AWHrJmJ(k"jE,#,_=]AK^+X)$
!5>*SZc+=aTA*'P$653kdHA!:!Vol6UT"*&A(>dB:n=BaPm'#C):Go,SK5C]Ajc07g@@Bo^Z*
T".lr:*REH4hS=k+BOt?L>//8);ik=_A`AWhN+$mU2t0Go9S6ZP_[NgO/E2l]A>tWTR>q_k6b
A0j0,O>$`1[>G9IFCZn^]Apbip2f'#q9c5,j+<0l3/92-QBo<8o\W\5B[4'25l&SL,t"h,$tn
T5+i)fW"=_KcrD^GYrkjm9H?$6ru-i)b\ENM_@fsmKb?gTl)S`J\T4,e46i8<D</nls(2_Na
7be"Zl*=BoMi"LpQ\'Y;HLm[oA\GeUm+A$8?#m\Qa]Ak;m'S#-s2$#8&g1XV3(D-k8,1+0>VM
DSr;B/^^i<V9`;utUD>.++%J:jNXFNrVX"n5<Z(oMh,Qp-`eD=b+kGXjYpLH01.H1YQY8?E!
kCSuC98`@MUOD3(h90L6"+WFd%KJK=/!>Ss.4orm>(*SiNOlHg`kg_W#D,&XO@W#U_RrDQ8Y
33k"WsC=*,XDM[*LldHom<_OVYkQ/H67cYWuQ4XX+%@?n""V&CA:M&[liScL\Ee("*nE,"\i
1sQuc1Oq-d"Og0\;bSto?@W?P2Z3N>Y6jAT=m>QHYu>5IOpa:eJZRV"6Hur_9u/U?p`S)PVb
@DX;d\cT7]AHYB(TtPO3sP/E?q*OS59AO@7uY:nNGYU/HrW+l2,to<*j'_Y#e$W1Dn(biVMI9
RI?TkZ@)gbTdOLq3,gYZWE+r;&qGKfl]AltqX]AEST<D[qR"5".uJOjJmmf)G?u>-FF"$M]Aso)
RsbTmqF@&(c9DE.MoAO<&2b/LIq=\2>0c:YI!a+k#>bg>F454S@[W]AGO`/iVBS^V9[uCMQAP
!alQupEEanl_2.'r@'e=Hh.eT/tI-%]AqK1[\pWa%*6Qlk)84^6P($$mXW(<+/5H+Y6Jl+niu
Y'*r;#6G%HG?747g:+3?XFL'_(WdArGrO+JSdM_D"f$rKeX:+TS)L!Jb,V!7Fjijem<.q(We
L$oOmadcL01I>)+;(WrqCo;*/H(K)XcnjaU]A85=S-'+FT;=GA>E2q,n=J0':uuMFZWs6dA#-
lXFpD]A]ATH\FP3c-1H4i,6mjSS;Qp*"Mpp8=EQQ5C$S3j1eWAeEOBf:'2CCdSZM1i%mqRiQRG
13ikf+JtT9n7g]AXc]A4mlSWc4"mLJ7#ZA993u(bnrsYp>BegqhUtWtK=`(5HkSVscW52qb16'
)snVVNFo#1k^"1rs7d5Bm3m<fd8eYC=>8$;Qbj+s$M8gX@sZ]A9TD0a=D.F^c:+'%h&pmHTaS
m-G,MTdm*$`ZbI;UO,N!W!8X@8'.Q4ZQu(c?5%B_6b:E7Al?bOI2D7]AJWgLF1VJ#Ep=&okDt
gkAe@1ffk/f#3L^8lAji;rI5fA8#U*p4NSSTF<=mL$0T*sfGkktHTDd_\M@=J;bHic&7n,u'
#jT-mEruTq+R"<Wh*p(UR8/UFf*guiITn#kaIt(.g#QF`e-PBhGrU1sG."Fs`s8*q)Lg-Ak&
:rUD:`7Lum#R=B\m4d+pOW>T~
]]></IM>
</FineImage>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[D3 = 'N']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="2" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="3" s="4">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[K2 = MAX(K2[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="2" r="3" s="4">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[K2 = MAX(K2[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="5" r="5" s="3">
<O t="Image">
<IM>
<![CDATA[<;Uf?eDL!`J:b.!MKF%eh&nBoNJN,'J92:Gd%Psu%7@UX-m7@%SO5>.GB_o3pZMFcpUPeC4>
1=)bW.c9?>H/r@3="Vj1HXeM1gP8USJ1jLkPDp$3&D/M%5"]A3[e59$+YgX#pAi]A1ZP,3,6am
6=Lp'=GGHHNJ?6it%;*TsOMQMMAGEl)0U:2+)3pk`1/Lq\jFM6VA6:M&")2<`=hhH.gj^EZ?
Fc=b5'Z5T9Dntj[?jat:u`/LSTR&%;06A[=";oNg+1s)aqAZ#(LTKF#,%#UA0_R>l-@#Q7q)
=F^W2*`2Z:D"Eo`q;s7b//:-[\+^INgRFe$#3ruUEMWtd/6s7[@#Wm<Z.p4!I`idr4*s50:&
M3Yl[s)1WB#fQ;2+&@Olc@n1Z*m:._T=1@6Z8Vk,@\,H<cQ?2[+'4X.DF+G-"0OcgFB?*JTC
2lRO1hk/g3k$/M'\2ND^c`"!Zq1>rqr#gaPL74qH*2lk>uhsXlr4h6%%nf!0j)Qr:bL*P"_U
#P!A:3=2<Xqn=.JkHf)-CgAUWSm,\$klL!uEkI\#Cj2YkDD5T;6j%&BFpo_'h&8+Z[;H.4*j
H>?b/S8aYA!BWc^H>Nu1Gtd/N(1F1j#X_V-s-/Fi`YB!)ih$q>]A96Q'oUg[@"b39Z=aC*K]A:
_^rVEkFZT?D?EH9HBB?#M?;hm7]AM=85<&n.[;/0Q$lYb.p$XU+p(Y_2+Cl/uDMiM6"'m_ino
SYtN2a0mp"0u:Ft$AQRLJ=AUGCm`o@,Y'68Eu%$KE^i7M:D3Lid9tPJ/qAXp"(J'?m@V)Ze+
/DG*id:XI9L^2mj56qS$OdI+tFj#&o7asF9i^&>Cp13oA\^]AcjKZB$YY[_bu88h9.92TG/P:
/!',<(?5qr8g-$Z=E9F"cdU41'TY]A7Kj*@kg"?fa126.LEp(Duj-HG8r<h<Bb('>sG!YBk+"
kusdB(1\_cJG^3e.u%X%M##*-_n\Ia?%!8jAJ3T4kK)Y=)X/ZW5E+1Q0H'):dSd4b!dJ(DTG
(*\J-*+m7jU]A)Zm#PWN3]A[;YYp1.Do8n[s=RkG_X?B*r!u-<-T%XZFgMc2HZd.@\fVY]AlnE_
#>st94rgt8YIMdX4VAPOgKKou-Ik!npIdMgNW%WOc3?:`l<5i6c:/fPX*cRYNOaLLK(VQN2r
]AUs=>E(I?MrkUb_m5eU@d<aff[T0p:XbcQI<Hu03!5PHCk=I\ETZ$9PSW(qoS5KfLed%C,Or
&jmQ90U``pIhlY3P?$JL#.@gL#O6b3QV&=.a8sdS2f4/:eIpAR_\!+(BR`c.G#+.<pL3RrbJ
aV6Q'#(LB7nmP*-_\tYdZ;!Y6P2G_TA*riC#Em378Qq9@SWt\9>ErhR5N9cG2fdb3gl7=:UY
UUYKBDWO,""4meiSC#$,&$0IpS*Oh!1)MU7r3oi9a6o(,BOqo.*]A=X0Q%k(g::bn(L4<p;\J
%(jdEdrh."fY8inQ-W(pq56lg@jSsEd$LtE:K^i3hm!hH<sutPE2-S.;0d,t&+=_So3PV8G0
Vr(/2"q$hnH`*h4j(l0'<dAS$/DpWl6)[Kj0TTkQX+Q\SeMgQ@=:e=Rk,-EX]AHb*6N`#cVB/
Vo<[bb`q-A*oV2!<Ubl/gdrp8hb%\6'eFg'8Wpf$o2J;hI4f8dsrF;FfWK.hd(<Ij'5!K^'f
S`BAD>!6fC'O/#bD_/;c/\8al]Ate1m_!FbA$,S\@IIo\D0XkqPsa=Hn<8GF>O.Tk"q>PCmlB
!<BDDs"?EY8GHYp]AlD8^38ANrCqD^O`fYrT8LDIL[m4]AKT0K._g\H&/*RZ/hcWR1XE2.#S'c
?FI>6iLc4pOkH81KQ5$0ZIUap?6$`:1\JWNI`[@>`^!=>g9g]AYgAH'%cd5Danbn/"]Ao%>e(Q
L2I?"nqfSjUCBHYRNh'*>4hg?s'TM]AN).+-^Y7T%Aq!m[qgaT8)e!8N^^I$%QU]Ae5%T3:UAC
(W"RN7D*u?f?L?<\pQ!RTD'c5V:O)l4gT+D`FkVL#2es#:B?aKcG0(uGX3LA-UKWUJ??:j!\
gWGR->3kf9K(>>i^LOpfZku'8D\Vb&\@i:FRB(]AjHGf1?\1289_<Ld8fl%@iW!9_FKGF?1hD
iL#ZOsm55pNT67HE8*Un/tp,<7qL6[Vb"X\M'JGBS':mb0qh28ZFgjl6;8c:`J&R7@*--'>%
4tD:5O*K"NU_<g4O.Us3_TuGeOg-rUHe.>%9Jog6P,@18PVIJ[c@8^e*Wg5?P*eA4n]A+#K6F
dW%*j&ELnK^Sqs!kVe<Mmud/'R(sNuIb*IUD)l+++oMX*MoR-;gTNc9UR-*[SJ.($&Qf,c7f
4L[s<bWCi9\NZNfP6P#UGf3dXS!3hI]A/uR/4=>JD-`5%#:[`:b%diOZ_Gg\K]AGcla7%u(&ZZ
CU5WRX`jVoAl\PWgOo]A,7/=>1N(9L/+j^P?9]A/ij(t#XNM/Q(djV\`R*gg\"e2CEG-:Y>DPC
le%tW%)m?;&U[=dM<X80bahDeHX;[fXhYEbY33>)I-53LTXTCuG>K'Kk7Na$p"rs#2+P-j';
\Ejt08obperKUBk?e3es-.i/TrAFP9r>2qsP9l8oC_h7a2.u\k[J;u3G]At/XrK(N)'D>>hC<
gYEBD(+0MYQ39RPT?uDQ8)iEdf"h!)Xk7\H"Up"V4.]A`(W(k/+R&90TAZfW4<0M0:NIGj73r
+jCY%%;%q!1[Z<)r]A_t<`hK^Ns4W)55NiD?^Sj<;.kFLfb;7mUjGlB'V(6`LM>iLOh>,!s*K
/esbN]Ac#(,.=@FTD*H^MVbm/UL1j<6rDb>8ekl*eqoA7BSl4ZcMs\:_lq/43fI=p)OC0'>!@
q'n-p&BjuGFh;@EHLof2dUHI$`F+TI&ha(U'!fS]A1Bf]AqCaXf_Ka2\/#.*M&Q!Ig*l+#f%C4
YpSF2Z%*?HTa#05?c"bANN[bXiSI9tE0+t5GDBePg:DGd@m6D1HP:hcq%#?uML$1\-i($H)h
/)R*c$mqj2T=hK-Dq2%<T_0)$<C%d%Yqgjf$i2<5QmC4;mj'Oa+XGJd5*j`tKDuXbYGb`_EN
2pCEju55Fl+M/`V(eqGT?SoF9mUY[VNH+Dmu)#3%hYYJ,_:7^-W+#n/DT(LR(4O,qaT08"9:
E2,6R4FPC?S@JiCLR7-e)k\E*A(l,(03KF#ErSLZQ=!PFJ9n3's5tFdm\o'E"Rk`%Fg7KQeA
WG0_lI`N8+sGs1O&O,HXYP/9l^!R`WH<?%VlB7IhkCF!cKq3&r#,`JJ]A!hZoP9_fh16Q2lJE
#?AjBr7-5F5+c:X$jFX:X5<_"m_4jF(R*S:?ho<T6:-pXd@^cf]AXi.SdlGF@<LX!o?'KRYY!
RBEs$^lF?6ni!oa6/="-G0:d/J&;<hO_Y)p.@rp`KI-JfH-2i"<USOZ.s;R@;7\OL"7pQgB/
2F+>m@U@b1.9[rSM3EKaAh!nA;dqdQ(BeNHX;&b`XCo-CRI,CZcLlakt`eAB6cZ&bNS+W)Nc
Z6YS4h9MC#f.c+YY**[A?N)odJfL3^O;>naX.R!7l55ebtq>>/'*eRIY$q/o8FciqGDf,e:&
2f(HA9e6+@mgM.0k6JYnC?#0o!k'.Ta6m\W3I-CG7Z3r9q`8EIN]AbqO'5emC>cLCieOG51Is
pWKTDpZNV=[-06DH[DcuB[G(l`9f_]An*NGt)7iRI8pHkJB,KPjUAiJ/JY\]A2RObI?:3>7Y!u
58PRkLC+UWBR:!u\jsdOgF@k2]AI&GT/JoaRDKqF'>S4$Fq@ueZh@B3q-n#1Vn&l*L==]AM3Z\
-N_eEpM*)*&k4\#6FB,Fl1cq(,9:Zq&"Ho;piFu>9c".!XKbV1pY-.3]A1`-O)6iW']A>$D5ao
;BohQJG!KO/6iS,f[P5@#?)L+#3T:88*#XTP@1tn%2A1GRL<r6'8G0N]A&'Ub?0`7%e0eJN+E
.gICl%lrsgR8,-L:!k^?p&?=/HB(qEFXDo*Md6.[%>AW@QE:n$T><MR;;M;2SfljEUXF5+I+
Z\m4XbEHlNe,Z#:pD1E*M-F_=6V^<P^i5srEEl`Q0:)D$aO(\f;%M@n(_d-eMZM+FFbG[K/V
gbqj3Y0S"6N'Dl&5eMHfc4X@k*nNa@m*?P`dQPcbl%.m/M\<M_!*X/>L=/k?:>V(A%ED;_5c
hUQf463GfXAH@c,2;P\%a!GBZF69:[uF/,J?0W0D\hA<Ej\i)2sbK#rRO8Y)sJX*U0RRplWE
R#c"\H5b3SVmh=9bZRQnnh!k9l7pf_+gFeCH$V!%up/olaeNk?\6#<nu2)C9:0FI/sFC)Or-
7%eFYIP&StoVGk1#mT>H/U!s&(e.FO8[CX,[]AkRa(-LY/NF""WWq4+i0/M!Z@uDJ3[r6R<Vl
93YpAK`oT0+I`LC:3+eJN4pC'T"F'60"[N#7Xg,PH41J;455LTR*Y3i0W$huh.R*n;a<PeHj
=%9TQFPmY=EZt)L5IBghrr):SPq.RO^hp-s20Ega">_P567k9U=W>M(O/^OqK<Sd.inGHN";
?/gabmJH&7[EMCkhrGUa*k.k@/BF&=.*CD%WUOk="V)!Hh<`^oD\>;--S`<:^i6T!nMrF+LU
CJU!A/(c''E[:c!RHhGRFI!hCi^PT+7"[ZQDso!l1ZKC8*YEBFkV?>@T%j!kGZ3HlE^p8o)M
_!?$1-AnB`(M'bT+l?S+)oP8LD3s/Zd[MC=@&+`VmYS@q4cVW_;/\IK1++!b.]AElX98heeC<
]A:td6=s'pZO,P2U+9-;+U24u'(LG\2&R)CTU*I=#Y2`uH>S,IQr8.,rQTMVdm(R,eZ[[?HL-
oP.UJb0m_VL;L)=VT[Z0HO=d[F88Vc"D^Tb<]ALh2:U%@aC3!I<;^?b=lRr6d]AmEXp)HnLS]A"
YGrH`P559Ya6sI.GQU4^Dc@=Dt&61^eIVHDbCZ(2TU#rWflUa;)Va<CjMZ`]A`pHq5n"_P!g7
13qH%Rg;B;qY:\/r!WG,LV0c]AQa^>SQ+`&XlH/8BiYi)V!3baiV9nQS_0G1r;5N_2Q.e]A&V?
b$(qP_Y==3_h7#3Q%@d4Z:_&;<[d-POBA"hPGV-*o@(3[@&]A@f*;bEFYp\=e(/%PVM3/W$I[
8G6fEL$eXUhK*^,RHo[PCa5eNgcYCnI1>M>75+c!QOEahETA]A\+?&>O'HL]ASq/`0??&lCLSZ
5P"&p4iA5.<BDbJe%pN=(]Akl<cS'rh70LOA5I2?dUb6ad:p"<X:C?8r-=oHI63Jh4VS(@S'6
mVtoW>Y!lES^Q^q1=Vo[MA/)5AL=\;mXijIkU]Ab7+c)#9h'4;aU?W*VLN@X*g#n.Z(RTU=u5
<!qtBc:JA6r)O!a1t_M]Aer@U)rFN'o[D@#l>^KbaI^lDmua_G+CZTQP=rEek/3k=q>@]AE#V-
,1jU-,"UM&d1I?iM$Y9Bb*J).ImI2hD#_20u&FP+sEPm?LQYL]A:8;qN"5eNL=VH,_7!&uXYU
rqThIfXPj7^(7$$QqR:O7M@Skg<cG?olqAg@-GtI>G.%244#5P2.YuV)Rl@;4qp5u,uRm;bE
P39P@L_,HCFOT=%:.!,%j*WRYhD?qICD6FRpWO6egYO)-k?2)*aZ<-U,&!W#2DG2YD'cmc0$
mO_g4Z^V?'2cOq?!B8Ka(am_@sAOEZ_:CPiP:G0Z!6%qr'iX<Skp/g9pG_ttU@YOM-QSTD25
EjOVK.%/RMWjD8`%-^_;1Qi338'lK,Aq5"3KWuI8ANX>mr^#?kJB0\^7]AGD2ea^X43p$\Z6)
Y^Ct02:[fdeS'H#!Z`k)9bhUeRc+Q>-9IfVi>cc]ArJ?P>D!HQosTp7cd(?-u4Tc,5SNn%HT_
f@`(_4g3*u3s.)+QaO-eFBbkF3D3FdIl:L@Et<;X*VnX+c&/kS8e5YnMJJUHB!+#f"j@*,Zb
T!X[Go5,^*-6'$f$'Un_Ed*4Mt.:5@oef]A"[I\H#2MNgW&'pq#B`7_QACPG=tqajS%bc_\C0
-6Bb+Cc8&*LMik)(W1HttL_?4d`TF3"!#0]A#:XS"%Q0eK1\`\#Q(-F-NG:$KVoFd;b]AZ_4U'
OAAGXEi$&?[SYfMd:n3Bn^u[[*E8F$6CR"^,]AHl.W#(IVUJ=S-j3%U0#TN^K>IkE,aL`(9tg
f-q5=iTJ<S5PTEV=/+`W,Q>Tr7UEC-",9,uCUU9I;&Kj'J89FQOc>(KY#X_,^[X7,o)YW06i
Rs,PO$B/*2V4sNG)J'^5&\1-).]At'0`_\4]A>5X$7j8^^+)pEq%AHpujN*gJ9Voi$sYMImW'e
s.pZtZ&;qQM9I?0&@.`fd,E]A^,iiA\kZ;(3hW+:C\YM[trdX?[YXXaO!i4o]A^ql)8&Kk(oJ2
gS\eoi/cG>re1Z-V@A]AJJict(?::MY=_d^=GRL^D/VA4Bl6,QAmrP`^FFO64%+)Y(JF>AMKd
mWJWlELB"GSsB*]Ac91ef+de=S97.Tp74kR#CM\3+^7F\)H&FqNdmPt*!QtST:Z5!ZFMfmo(;
-kXWY-W*8^L2.JTBH)VdtK7m#Y![da-8?/A]Af>ZkcB[@R"h,`hb=nS^=XO)j/Mh0eaE$SM.-
W$J]Ap)6WuWr=r=M@Z5Ne>Ri+Hq]A4>pK*joq%H=(jp)s^1VXLTUP`.UH[f8i*cEkq<k1jg866
`M"88Z&;MAc$q;[fTug6C[^Gp*_qE)Z!sS\;L,D'TNQ/Z!2X\F\DE,f"._A"cAq-e0\>cb7<
BVJ71F4>He"UogQ`m]AI@36n"\7j?E$WpGsNTKcI>L"I\"K\?=CIL!:%^pc.$#l;OQMb@Jkdn
jI]AGKKIUhm_N`eLXD@A'/:7W=PI'm<L,VYn9Euud#6dW<0#FL0qgA`It+Dt@fWOVpB.)r%9V
'!O`GD%`P:Dn.5tC\^Ghs$Q)RIeY=8:,iM@gPr(=CI@'9"`gdm'7JX4k"T"d'+rq9aPZ)BXc
i4eI8"flj^\2pUZZB]A,aleQMcjs-jVpMf$O-Q;G;bJb:WV+l^KC5%-<Ia@L_apA2D_>XG>hm
-M5Tlqon*JP5#^'1(-,_U!m+]A,05lN<lbZBa[Z6Cq<L;HuH]AdY@g/>pa9uXXUbpbG0"ZU:E6
UW]AtMa4X-\j@*:6c9BK(-p[X"_^]A"n,TAR>X,>/&TQ;:l7IKnG'IsiBK4Q:;Hr/89G1Ceibh
R8I-\lO(bL*O62VS@ne#B)r7Zk-PmA(o#+IKB#"\aI^Q]AY847W(Ao@D\-D;FG%\>`(455Nda
QafR1G]A>fs!lg\uKYAJfq=enJDNJVC4tW>,ekj[>N^5$kG$2)[%sN_+-^O;MV4TH#nSBXLLX
(/KjsD)\B:=Rr4PJR!SJnZh44Jsu:60Pr:BehkCLgBchp>VOUPG%b(=U-hk9=QEht7lVD\]Aj
eBZX_aK3kuKBrgE?.thnK<4$mEji::7!k_YdnWqcO,-6G8H<*JI!e8t-TsC^9+CONSMo1'Ic
tN'G5D'oCLpLrKo^J:mm-V*a%l*rP]ADX)Yo(i+gqTF`7!QU^M+L@Bc)3Yc=:,nPso-pC2X*R
F[H4fS]AG=&hc%XDP5p4jB"G>I>30]A1U?N@MLhGg(!lP$5pWqOh-\9L0iF"L(<8#Y.i-5l0Uq
iWZYN4L8I%`UHAlr]A[$JWG?0BI'4<9Vj7t!d)>$sD[J>_hqn.M7HRBj9aO+n)9]AH"HJ,JkTQ
eWDVoDrd:T8<,[brKU[bGUU5iH`k[a[<P]A0S]AI[Ar^rUNY/M&??W#*Uc0*BR%+fYqN;3Y]AF\
/)6CLJm7C/rWcHm<6B>rq:,`2H^,*HiIs)\(N]AW-S]ASCmTRBf7<9.=k`)T%f.C&6[ZP3mT>p
7K]AoF9cC%-ir<X]Alk>Pa5W*nq3eQ7koM=tW.'@ILT..8(UR5HaE[[]AZGT>(]A2n>h7[:Vhl<N
iHHq!aa!(XQppNc'>!NbG1qEDO(\Yfm3'2BW,s-gL0-Ke71O-?L+Js`7dpkZ)J0""lUKVo+B
m8mj+IVT#2GEW@7jD\&ALlI8h8;1i#IX]AmghD8&^WKBK$Cr=oi4q8ZikNQb&aKoY-G,n>@eH
P*,5jT?&?7pcb6]AQ_h#iVB^DLLR=I.T\7>LbjrX?OC[g@>3hG4CD"[F\jd.mn`.1"*m=!*HU
!*DS-NsjX30\Nb_.fS,n]A8]Af5^$a?_@3:DnqpeP3&+D";fRWOo1uU9o$+\e*D[=]AMW`oX1b9
#>k:fie9<K>#i!PUgCrXNg3V+'<O>`8YU^d`'pffGGf0:+R:`KRWUaa;Or7_5TfDAWT@_/FS
`M8%%lIDKcBMr<hQ?4'khE(UeU56EH[B>m2HB&/9U0S4I]Ag(J@WLE>-VqspBO@S_\sjeV-T:
m=3F'L2=X#-:qg\MAM`)i!.b63Kb';[JF"ju-MT>`R64f#>[$Z6R#5k]AQ-f/1#Cu>dbX3r/c
Vt:m8]A&3EH^&RJ%2`a0nnC>(#JhE&pl6cFLc7DH>0AeXrVp<j<Q,1WeQXf.M,ROI#k6`6:1n
?$>V]AmCJ5$l7@?(\K"O2Tmh_e_fe*,"cte>^37Jj7<C21XD+<-14\=-e%BH>^UDcJVpO<U'O
X3i"!rdsMk5DBT*2q!(clIF55A17L39?Sttu$2)4MC8cmR#8ZF9h7$K2$n>b3@qK,S7=Nnq*
3iV0fNd_8m;5m;l%$g<&U)h%"o315M5Y^_QZib1N8H(W^a"I?b^Vk?:>lH96AU:,LYb\,dLc
?&JdmiW>f()<Q.\7)WdO!NV@Eh!LXtdWZKQQ:>m:s9;<+':rSJrOKGk4,>P9M`a>-8\--l@F
UiR2pRV$ZUNupr\Kt&"Lb,$_t45ISV93#Lj8(!B[hj'2V:k6"30>$nZmQs-!B5\C8ml;aPCd
;!:o4NE,?t07WIq/D5YcXd<!.9`@V:Bo/O1d%d2]Al=+/*V6i)SL&4Nk=MGI,c;L5-LB8PPq`
%1'@hR6OTDT%3b>pQ]AH)[?U+b+(QtLaJ%%5`G@"/<jeD4LJQ8a5@L0g#fIQhq:>d[]A"0QTnb
G$VX4X&$=5IfiA%,@a6No"l:oK+0F)?'IV]A5NqHSMCL!OtG%f1&O,/':*'q(F<%Fme?9VQIf
.eqrV0#c-qFj'NhqcXaQGH.]Aag!oQp%JA`a.<n#\I$e;`F]A=IR(MgjcHt@cKu5bF!f7T+ugR
,_Vo5BHkBnUl8_'`1M<WYJ^*]AWT/)R)2G?WG!"Fq7@Q9=:M88SceThZmLGtBa!NI$$m%&?U[
./U<!DJV.tTemXF"%K[Og)YG5Ca%pN+6kak2Pl^ggPG(l9Ep"<8`u+IB%E?MTuk[Q1ra.2]A$
gL6G:*;-^XYd&YA@qK4<FdZ;!bdk1rrKj`b)!6=Zo[&\%Nk9X!]A_+u8p9?APsn(d%WOq[A5s
.[$HFc4T]A;<0UQ9+%*[_.lDFVfnukQ0Pb`eW_@,)gN7ro?bB!q6B[$q=9,Q4p5jnJhs&*8%`
(OCW7Bc)/m.rpscZW3ZTr5S^J<i*a(U4idY?*;bU*B\3p\QNZLFQ@?"2rAB$6aM"$:9M#I%b
I7EZAV,KI]A2GKQSd(.WTYqgBX!KOsPPi&]Al4[CXu@b[<TkmSAH!sBE'M]AmFO6Jd>9_Th:B2'
Q!N+(a2p\8qu4<F[lIopin_;ubu1PkOuIETfdYmug]AHX</@!b=3J?RHE%!fb,]ApRSr>?$tp>
X<!GVP\T*+)Z4eWnpk87!s5K$-S=%9E:I1eq\JKSD6HXsp20X/jdI[b7Bs'-9)clfAjO'3V$
G\0Bb-W@em7S$-Qc`q&T<sj&Qh6;4GhkN@"X4&g4Ys?Io.Ld>7p[$SQE&g=(p?DqMd1eB@b<
4]A/nIQ.'O=$G/MNh9<A3?s4@';WcPlZrcW>7+/Rj<d!KWS!.6l((Fh0+kc,T.Of+ZA^H%/.a
(8Jmk)[,:&"`?nXbI^:]AE2TMuG.W\=c@1XJ@TRl)(jg_i+t;lP5*[.RXb;JJE8\5WZbGsd[9
^V]AoEIe7#/%Ygj]AUV"gQR948prcTH"$mu@S/0bj\o'4qN%La`Hc+HkRY"E7QIE&M#oQh-F?]A
:I34+Cnag[r:.]AusSDPYFnMoL3D(uFji/3XV;d<@n5FnhAXAHMiON@;P)(Wp132NX64mZl:G
ABf%%fWI-U89-LJjYSXn))Q5o`NJ2+k3cF_Nk/(;H&[J+Wq%(2saM`<"=_i4I;dN_gVZj%l:
\j/i!M'03!O5BmuK[&(LHe[gMY8$pZhVI9O_-eKYBT*$E\"DIi+R+?ZY"dc>kjnX\O*ESc0P
f'N$'$d")BNY+F`YF7gY\IQLZ*nG%;O'`&U)P-6ss(q-&QXh9%Z^mKXAprX,%&g;ABK3VQ:U
f*UjprUt^,\6M=q-1`Jg?JANJm<#aa$19s"@upE\;X`REYOHT\FQoq2o)E+?17rKJ5g#euef
GJ<W-aLC@O<XneX`m7krCg0/j^cGeg:bIN,8,_X0,<HbGX0cXcLPn-$t%m>fe!\YoMBd>5=]A
1;g'$qZglm*DKBJh<b*=+>4_jsPYZEV)IkG<`S+GfM).9Q)e8,mFT`jaXeX[```e'=er1/Fs
XacY(@:SFDD!X*@5@(/qGodWa,]A6Jc(>*J-g[OhkO0oc59d_[Tm=D.(lLn/SuG(fSlO68S<c
)MArq$FV&M9"PfYK_\NsZq;U15^oC?Y'dDO.?:\SfQi:)-fG2!U]A"pK3S,6U_[g#o0P";(bm
.5`L`#)uT[O%.6Df&\2/NR'hOQc4r?BUe9MbI4,,=%Uhm5abKM>7sFL0)u4+[DuZUN^X_")B
J,BC6LBt\.$/P-Vl0jirs1]A]AK0[ANJn_Fc\^(uSXhfQc99\7K>AGh"LojsHLg7>7;;(+'O8/
WQu<h&fK'[.2,2"cVV*7SCqc`G8"%r+S>6AD!1neEd()3PJ>M_Z!9<,YOk/(8,*B;Dk4fQZt
\DmV(HN-;qh*[nKCRq,5&:A1]A:QFH@d0PHk/TVG#5Sh+q#A[`'OR;.]A@BE=Q"-r-RJ$KA;IA
h:TEnCaFLK,F1.8Jj@sqBl!3hP7&+#,N,.RBs,IH>\u[o:/:"HO_=HuROJ&TokM50(\='/!#
B\N`e=oc/BG%?S/Y`PpATluI%$7l=3tR,WhS]A5G70"!E!lau@W?D2-e60LN??_B(d?rdk)kA
5\RNAo;\,%O&?K.F?"L'I$HM:d,DD$3S?\rNRGT,/3b@&.[gm5&ke?uk\j$]A*0hnD*FL8eqs
+[3^Ah^oekXKleLZF<%*6r*F&D^$!\R+usNMHgq+taEYX6]A!Z)[J28ed%g=>fSu0SN>-)Mt]A
X_Fub6E_Fj:hRdS[Ib_=FP9Z>USo><*#V1,+h&@]AiUJ>hbi@knbA4K;k8!]A;CYdtss$%h3u$
b"G1,3hJo!XR8fD>ORVffMMCjG[b+3[GJOR)A`3ATu)()mV9H]A;9:lNZ_l?P!PcoJe@KoSo8
b3W9jen!fBt6%*skt>C0GltOdp!T_l=5r8O(oS$E'iS:,7ggJBu-D`<`05-]A5_"V6ZCc&_A?
'DU5^EQ9caf6Z"=$KP.S3a0?CGSs^AEc-Mm*mjT`)dRI=_KjI")3c$$%q\=4:WH<UIfC?A;F
l'1eDg:G!4(m9\7A/Ktm[FKn%d2bmQ#L%hMd:)lpKElp3@Lc=55N\Pnm`-F_eHrel.B"L9H)
ILH,/:BKTYU`pA40-fkgqsr;;c+_[upRDu?&o/J?Y!+-YN/e(^)V,`.?i[fU1mc,?gb70ic!
Ya6PiLb-brJ(FTQG5%b9`cTDEMBl'<9s1c]AUYAJm4$2&F1*SJ/>"I]A%kOmj6F';<JFm,970?
k(PC-S]A6P(&#P6A70W^[+KIUTR]AEas:MZ-(EC"+4%kDQREj=F7qY,$liJ$qro=LX^,$Ua2N9
Fhki!+0j9+7@YJ.&@6#I4fjXW0R"PB'Sr4]AF:AO@So9?o2N`Vf]A\CX,]AjK5K'k&e'"D]A^1&(
Lb]A`afRZ;;HC;iS\,m,$g"j%l,c$g[mQWFU!uNY35_)j"W#LZF1j6ZPtD2$H&$!mh<j`,2!a
e@%F>tdlJ[KQpGsP&))#;RZ^-.6\1$*o"sEbA?B:GZn,#a8=('G0d,f/_0&lS,^%Th[X>+P9
as!oS*nA]ApKrXfZnJTo]AhqYJ>R'l]A&;Z'Il.O)Q!P76:/R7osf);U.G!DPds4;8VT/c!&i9M
J<"^SCM?.6Z[VXd^Zp3$6PWEW%tn5<ljR1sDf$.pHB5pY9^(F8bVL)Ak#D5K$^$H@'$GD,Ar
.e>QVd^Iu8mZrj<6l5%=2^r0S/DY8RNP_oB8%oE@mlS,M(Qb.S/Ee08g4VZP'ilV`\c1^!EN
;KL)2fINm%L;&mJq6-c@i<OR="`/<cifNf7"hGPZEj=2e/&l$im-X5M9E).n&0M[D:od<d@j
nIn"35CSl&nWja0VPZml\,kf1IVO]AiG^,-P`_L%VW&TK9u*iI'"9"<PQJMYBX=b_Uf[I>Mk4
+!a8o6Z,Vkms;18P0#KjY/Q&:OM9+D*;_j2KF@8BJ*f$rN0hhrRf2>2a#1cr3kK9VI]AV:<Ik
M$cG&UiEAKGG^l<JB+5STJ?Re8uHc:!a*aWV/9(S3KjCD':h,N]Ao>mS^Feben6=H+7-#GX/^
Kh:5B(.QVjrN<*l9/dq6m:%W_Hnb\1#jb,%!AcNmm_&Mo,q7LiV>H[j8+bO#<L2k(Y6lJaIF
euA$O^S.m&L<f/]A0C%NA2<p:X9(B&+N'dr[m-0R8s@'H^&9simHLomel9(o`.Xh@k34.5BJ\
=D.RLrfCrV@:D[5;<pPQ%;`(V_["Ir'59WoXM:k%m_?V`<"r+p%[VCY@0DOC#^H+a]AP24^T9
_WU*^!S]A[N!K\egEV"Gg)Y)u4[E:bh_Ol06h18Ocg[K<'EZ"fE_L#J,?s7Q#7Hu_rCd>nQP$
#nW:Fhq5rh)mDp>VDqOMpa#"6*e.[RQ4V"A`jsa$L3Bg7:e`Q&]AoM?0KeH(Z+]AUp"Q6A\4S?
m`X;3+#(d5TK:YGr?U(HL[9NUi5FoQGo[TpOpgbKpYa&sgV8"k5PR`OSSQDP%9I"LT@YPq_W
[b_e,<bYT8>D75W0-IG&MqQYq4q4s0\['\`0cDO0/F!Qc.a#\'7%/lhf%?q([Fk$:-.=&8\#
oX=c_&g,dmPmYE$DPPhO:*,T<7D`3kNl-AO;pc#*LX61NL[;1aje:^XEI-m$7X`/apEkT\9.
N#U.&fJCDlSPt5n1^G=n.Gn:"@R'k2OT+TF&eFDMU2n*H(EAt,e;<;D>kqg6A32`%RiO5B`K
f?YGdUZ/a'(!0]Alk%T&#W.@"1KaB/Y<mP3"O_\7iZ@rE1p5t50?']AQQ"B>\ZI[5(@92@l.)A
Oq8Xbf"KefhC&DoKh+?K@,DM:$=+/JmYd;6e^>iLRZ"/8(&BkUiV#p\bOX9QF"<*Y\]AI?I)*
Y3T7gK4%",$V*92A*Fa>V?l5ndlUCqE-GI:e/R2`r)n$G_M!>.cEJBTMU\E>GpB_')T.u0HO
i_>(sh;d?&N"&C==*;1Vree?m/,`>b#9KJ;.Nel\u02:J33;c1)IV-GU]AIl999nk-r6%M5Ut
#Lq.8&LbHpU'MC)[]A0BS&A-GOMX;dAC?Gs=P[_T)I]A#moCq:-seKl@++se9`-50=LmUk3GoA
NY\oabf3!@E/$/:F!DK@P>"q_;.jH>ML*j034:MOL/]Am`*+,'RkoKm\^m4C-SZ'T$\T[A*k+
EkH:AJVfdtl]A'lbsn+B:^gFd+IMUf^58;o`&M]A^K5LHODb8K5V[TTX>+n+`?KI7Wb5Fu"]A1Z
LP[^1&oe`5kZ7g]AD`0D\,42.W*t%Vk"SE3@uK1S+fi)p%T=7>)db=uItt++Lj$Om"87ni8p5
lmRe7I.L+.iAF)hX:G%Q'%kXA/#m@<:rq>KHW*g[VCRD)j]AhR0N^H5NSe.IR%Bj%&X+=8.rt
C*0Vj*@7A3dPD!ZQOMM'Q7R2fdr%I_/Mc@%.>!VCa2Yik4j'.#q6IGT:385GKTRTiQAdh%1e
eMO)S=Q3R]Atc_qRF;_qT,uTcf2?e2'Z-6F.dPZ'U%W7l5=uug`_(6<oK%>IU;X4hn6:sNQOT
/F#WkJ"dcCo-s/V9kmmPEK'=,794=b'WoRZJ911@*k]AgQ@eKJo4(UL8_^YKJX>/_$0XVm5jL
!5JW$Kj4a'uAA)Y(pV`h_ta/'Fc';%eW*igjbf&-#&:pA4ftLra>X7GLk8q,<u,c**"6nW11
6W1`0[gYL#"V0/;A@\[-\Mn$,P8A'7nFbCis%C_e8+a%\.f!BGhF%Z!QIn!&lJqdMV7c>)Bn
/TRe8X<LVbiJ.1a3-me<\9?OeP$LqiWS]A1GX#:GIi6[u^*uDmU4%:>5F6D6IkLRtW]AC0uke\
rfmMbbVcF2$.AIB_Hb*#.e`?Wl6o;<W<'$<pm94hGZds*1#l'(?J]A^7BC_ldIPqD3pnFTu0`
e[JB")cX"D=3>Sed]A.!Q4c:9CL"j<oNh4LJ@AiFWu?&fl.X(#>Pa#of,G=ZK\;e)DHO#i:<i
f"P11,B6>,CtKrQcSF64H=.HCb$0W1K0Lqr:9f*fXqKZ!hnF>FBCQR\.\S'F>*HsSR>KaX+3
Y")u@-:$Ff+;%CeOe5DsRSc1=*l=Y8M'b`0+3rL(_rr[#cpl1[Z+1L$R2qY6O=LOq=?rO\^#
Im#E*6c5rZnD?WH(-E#sZ7dqXm"E.HTeu/#%?MXl8cU:9/fmen[XfJ)T@\<<)68*n:&5)$hG
\/E.E<@=NG#mOVT"KCOmZGl2_4/N1EA=ZbUr8Z.A,F6W`\P6L_BBTXS$I,HYCJU;2sB_da$?
N[P/Gj#S,UAG#ZOE8I,PAoT!_9%f$>)'hU>\7bG&fr@\,k%i4+'=k)@A$#+q"&.mXFE=JL\#
M(Xc;TX,Q<O4M2*H\2q;#XcuW"*PZ,.8BP*o)HOk=jVBP!uHG/A%rtetSQSNf*.LS5N-n&@$
]AFPZN>4EN&k[VQNqrO\kM$[ME8Oj@WOkK]AC_+:FJ*)?u945h0!ks(kLtoM<\A0-:LU!*>$TQ
QNK8PV0u`=G=CBfmWrkL25ZRp#pnLCZc_jEFO,6QUD??;f8LPsi)V0'U&S\5L`NrcWrqQN!A
i)tT=0qkB(f<`'l2@dg4(6`L5qec]AXG+!Dtl=_W1kiEcYLnd9uQ\,@ahf'G&fO/eBRkt#g(r
@i8mZ&&!-8N`X=/ZJ%PpX%?Lu+6oVsbSISoERn+^e9I>o<Gj\AU84khWr>dJE'eaRag(j<Qe
nsr@P+@TJDj$q=oF>g(Q(jF*!OiH3qGeC*[o(qo2:Gl2r!`MOYaJI,L;NZ$`i7$o9QW@K?1,
nP?\rtRDo@\'8]A9o/aF.Pn)gRkFjX"qMrEAu!9poA1.%]AE'n:Jog4b&k2.<Vr0)[6AuQ5D(^
hJgms#<U&\Bp1:bhGGrl1Y<bamslp:2+i+ihSD8gO7US#/UXBk3GRehPT)"gs&UB&T'26b=[
.Q98sD9=c`aIS$P:FsO$,pf(e81o;X1CVB:R;DMlhGb&UK*F$Y1SlB[t$Tj2E%fW_b?8"k(&
&G4P_o.a#rF/?kQakYES_.B?&qrXn-T3m:mk8=S$,H:rOb*T#']Al<N1?W:EN#)_mdc]AAgN=(
QA!i6Yue9oUY,"mI$K9YX6P>k6Eb0-X8_+XS3,u94nmF>!t>>i-C7FkLXr>)gI1ID:F8?HhT
l;\;dQ1B#%isf6r=3pEbrQE8RUl.%Zl,0$684lr!9]A"sKsSZL$=SX21+f'a#qC\VJ<P70d4,
jO9AiZNeTX6\8IeK/2gq]A0Wd`And&[&2m(QkLr_(%C`D3bZ;EOn97-R\7tI5).Pb;<?,`o%*
6[u@]AF+-"ijJuAbT=W3jh(&0i7'e6h:BE$jK6V%YcEpO:Wn@R`!iCYLo4Lp`M(s(YREq!lUU
&pHjQ),dBp8j+gs8FXJltn*URjmEs\Hq`CnR'LH$-kr#OEOBp]AKbi`'3l0Fg-#o5ZcE]AWT)5
..<<`+Q)k\!CWRmB7'WA`sAfM=<E*;h=UGb46csq"'\h#`e,C=Y*f0Buj7_s".)3o8DNFl4-
l,6/i\_L<'lOZ"1Vl,[@sHL`0#<$9J,CM'QA]A=+!m`:7&0H,&u1[KO!?D\u`re>`sEM*'Ukm
dAKhmL0[NTeH3qA%o"M.WnCDfWE%c$>\>[C'0'^VIaFePMuRL4;P41_7D6fr6N6PUPH"U/LW
gOSXh,5+Q93I>;5AtMSC\;<oP9]A`;[b94RA#%M13I?tYAsfk,G"beYu=,JY\W$VS/lFG?<>2
c\tMH`P[u!bMYjpEVD<P`N_S*cV`f#C2/!H&7qjh*aHomj<o(N7;Z62[7Q*5*#a\8,eQ0a'^
SFXii/:rh.Le__M#@Ah%Tt;_M?f+S(O+W*I'2H)-Wh(V_%m*Nk5ST`c>cEDY6UJC;MQA#S:e
_Gq`r>Q1PiN;^uPLb`RF_d6!n#BYOa<3<M3nI@NoJo;Cd#*pU66-pd5n#A"Wh!EYME*04+[e
dSA.@5md(P%cs=n:ENMlbecDpHY5HEcSO$\3n"biHkAO5ei#c"A?H^&A!k!-"M3H(dk,#oH0
qQuEX4*CiA01jq?'OVl(dIWiE=FC,^Wi%1&IrR/4,J8kX'=*lLBgIH;r^-[&,7@Ue^mNnE#\
c=(#F&C9p<LO7./uKJrC[]A:5PQYl$16HeN&M,(_/i#n6$1Nu_R&S\M0WMZNK!6D,>P\m/AO9
H,u)Ef[,1"ZNeY/o9=_7DqlX&G6jgY=m%'\]A(7m=a?jOKd#./+`:'3q@@@0I<,$!s6ar`Jl8
#:<%R&CUe[_k(g]AVuUW>M0jc?$]ACVZ1C"B(_@$`EH.2<h=STa0j^NTQ[4$tE7DUcJmGl%]Ae+
%I>qa,G&USQ(D649i[`P;PSioYH@SDdO9U&#MBTLP\o$YFeV]AMA'IhfOeZmpf1k5E]AGaH>6b
7"%"7WBXbW9"M`joKBm8l+Wg>l3XD57M*Q;-;M\<foAFHZ/*VI=0#ITmE'\Et=b:L&/+N4<p
WNaYGAs"k[5)bnja4mjMfA8-4U(Y>ta9HL'K+8dFeEg>9&X?eIaeo?gKD[j=r!d@@<=NM2@Y
uLjQhJLu)Sl*n-!]AY8d5U6)h.5LiUX9$!)=K`97<Mb`2M4X6q3U]AmK1hE:&$R[!'f:7HbnXB
nFi\<WJ2q$bt_/!I11MYf.U1BYVJa7aP&Z7DGh]A5U1h.Gnf"j/B+iLXh/_mj;nWqarU7L5o)
NJKml[,1T7,Yiq]A1I><+bGKp-`g8BG\5[JrgpmhYRn@!Cn]AT)G0,!P1FK!;i:n`-uRh!*E:>
,Ph/eeMrC#Lj&U0ttj`HNF:1G37u>SN"=@BH)lkm;33<0UDC!a4?(=I4R6"`b%86_7/&"lLo
M"T+tOJ-68nXGT'5[.=-:*?u\KOp3'<bm5dAehe\[?p8_2p]A-\0[=[tQVZoR(qlh>^CNJg=A
<s(q-E<_AMEbl6]AAjtH+rXoc_P]A+U&>nH1Q3oGn7%>nA=b^4%pRAgT:r8P@pnBc.qhU@?Cp`
aE=GHfaOYnac*[BXtDmZGc_1g9pqbAoN;aqf<jgN%2!<ahmNNH,(i,3S(4;&+2c+ndLmU550
OtBI/5J'VU8T2#pZ(O5#2U.Y7101`Bb[?hVrA@-mm=9M+qOjmq]A/J,@GMaUgD4$QP%ZI+o**
V=-*[RmtCi'+VE`7'pnMN(C)'5b:\bRJb.I@fYBM#3$4Ce'cJ,$dg7L*k77IZO&n:4$WG+H!
&iM&c-B7Ir/mnY+['Y)%@&h1<;hDT7ToK?uCEb5+9&!OQ(aBXrAW$L"]A_$4f&7!(G_qmK`kB
R)E3lF*pQ)NLH)d?JK,$d_[f(=T6cd*12*m`06QI`'KAKLYF++dl)je@^[+EJNgn.G%l4!i]A
?eRr(-*f(+R_7Y+o(j>\jP2##ro6Nf8.gZp`cLH[d59_Qgb0[uOW%#j%m$Rt+Cc]ABFgB]AXo)
?E8)ao&Qr7PK^Wl>6jXGr+f]AOWLVAFS(="an[t4DqLqh,os<-^I\^d,Us8$WIM@Z?)'#@)b]A
9!S7/Mb^nE($_D3u^ir!.Ouqj-a]A3$BoJ4+s"]A!$I[A-ZkKVo67hfe9"eCGW&bGH=boB<Q1Z
3&hrD)C"TAVX,rq!/STOg>!MMC=);S=B^lW-%:ENLKhi#iLZt;ah:sI,5gXg!CKale%Zp:!7
,\/\iV=eo"9W`NQc+6$A77Q$U1;_+bU!ldB'(^WHW\4t0>Ejl"ue'M&>NRu05JpRcKruKZ4^
qSB"!N4Rs?Zh0lt.aoFNs!FX^IOgGGaf3=_dKKpZ'b\stW9Nj'M>^T8-1>jng<>/]AkC\8git
COk*cUgmCEacMY-E0s9(>h\h$r[a4U?d;u<*1q`"oDN[\0NeDiV,pu%&2.#bA!"\6G.SX<g.
@Ce0ds]A@IM$6-+0G%s?QU$8oSdG#-p<r^/#MBk(Dg3O>\K5_m7q";QA53gJ%kAU>=YhsI@pa
,DuZ/a#T/g>1?o==IJoc)5fhM1ADg@e/Q]AgooWka]ACWJ'2>26Omqhi+Eb=4o8(UJ=UaaP#h;
$->,/br"%eoIoH^8_<]AF^pt&[l8Vo2.PI,gG;=8<Vn0@05ke0@^]Am^*b\r=IH7#+-RuH99)^
72;5HJ9P1BYMl!YD>pSRnbNBDV_f[QKTAh:tog.F%R;+7)S<-1$h\4&fC\%MV(GZVKBU(7a<
gAU7;N-cm`dG0%,^.#Z>Q6J/U,\Md6;"UDiTReD=Y`WegF/J+HJ=,Y_Ghl#_1U3JnH7TCeLm
AVJ+j^ZF^L(Jg<BI[j;Rr_;Yio)4W0i`7=g#Yh9otLdJWk>:0=>*aqqe"R]AgR"A-IrRi9YaK
s-l[HYMs2qNGah:Z"$b5sH';()U/J10p\`QYO?1*p2Q@_^Du[Mf?gM9k'BW[EYgFW26,_[<r
`-7ClHk$*^%gM0,6rMS'#2;6(AoCu.TG:$-jt?qNY=F#pUMPd3Q0:dN)=:uB]A#qd.kMI!S,"
5bSkVa.U)9sf_Q_n-Vqik)S\BS*U<^jX6<!/l"C'`dWaOo^Tnk]AUI3F2@M]A`:FCf68ULH[T=
C<;=BhWRb>+b>3>WHPTr+uGg,`6_,`jOG53$qdO=X($!X$D./7>=Kd!L0JF"1Q&3:gY\C!mK
l:&Pr.bQ19Yfho_mWfb6eEa?(7<N2XGO0Gh9ahD=2s"Uoj_irL;,8@m(qn"s#n0'EA-PYOnd
pk3Fs4/;/S>kO*'MkL-$.JX-'5qYK<pgR7LL:FDjaJ&n$JC@W\dVI[ULqREZ-?=0uL#,2%7X
tWN+kigWS]AX-kcg&:_kRG<,YZZ834>_dp'Gj[A(7@>\CAVBbY"9skg@*T3'Affi4OA4g+8))
_`\FFd4n"R:h=?d+?!Y(e%mF&nsI,5,2!@Y)2Xc=9KQq?(4pNOKb+4S"P*=S:Y)-o&^Y17,u
jrT'VJr0p5Ir)qH.b,eth+5#2fit%L'4>k,o\'R'$Ok:/.EINB'1@glC5oG"B_+%-G%ek`HF
[o:7.Oel:/Ga_pCPkY/G,J0T0%JFoRV\BhXn'oL8$/-jH5%"o3<a]Apgi2@o$"Y?gpt&c]ARE#
TGh3(M8cZZ;?^J/r@ZpAsk7;N7$F?&k%QjJgJ(;jV1PHJk6Ta46&@ckPHkZIbhhE.9kd*\*n
%R]A0!%Ns9am5e'_7?uBG+\Y)c]AhY=oi,;.$^'qiZGB$,O79cYYZW_+^.->!99(^2Y3!O@0Ae
)R[WFUIB/@m$GHcCX=e(;3O*=mQ*GCO3;66/:ecfdjM+!NGCq>m+""5T<4AG3DXjMHB(ssD(
qnfoFZpJ^2/UTRI>_nne+C9,e[t04b)q'\B>)Of*)L3mG>LY6W.H3`X+)<[s[<g`]A]A^7gb;G
'9'/$t7]Ac'+W(UK9U6QaL,k4o(0$#[UG`lIGR<^dKrkX@YSVF@"5Q`$H,4h\<"N\c@!MmG>$
h$PgYtAWMgoM0d[AohT%Om\cldUdI`:f7'\!q%H!@peR7\k-O$e^\O@X%<n;L6>oLR*)'YPQ
n._-4=[F@-h6$Z=Qs`NMKrAX5#,>3_=Z^W0=%<</m(XH4HdG6*NSsmr5+qjf9AW"Y/eAn_MM
!T_XLhucN%_=\=2pXVbF_T^m=;Pj-!Qle.l));FskTAAs]AT;g@!,]AH@]A"d:J,LaD3k9G@*ug
gYjcK6$2IEFa^B$UMb5QF6.l>8Ai<FOF;t-5(0K`YU"UM8r@1%FEbj<[o)>2^GKakc9Y\\7#
^LtjF6j'?:VqANp`6&bBW@iG.92haqmb."+k$Ff5X$)S)0Z26aP<0M%STnnSLh(;\PQCeTFQ
kDTV(O`BC-]ApTV:IpNSMM\1.>JD(#a>^_+0+rK[qn/KA6<dEFbgg$3<tE>b#o9;5S/ncF0J&
E&Q3ITA(R(U^p^?iZ(dNFpSmEkQBACX?[/N*faoA6'S:`Rgj=K;9,kkTLSFP=iMq7b$enf!e
+T\1N96R<'p\0.*F;KbniMa`"+R#emk&$TOUY*k8/s2R_@cJGTHSNWQh/5=Y.*^4OR.]AFfXB
3%l>\aR\%7%&/@-<QHOtA;>OLUqDm2&#H!WM\b(X-#ThKrqYuo.9XFAi`C<r@.ch95St$hhA
Z[J&=3M#`7--B)bHFrn7N"=OPGrjE/*#\8B$&bT`"L1*GUf2?8qp>U58%$3db[uDTKDU/:/Z
aR4n;oZbW9VK2@0.;ai+k'jr5m*T]A?I("op,q4]A"k\3?C5fL/]Ap.hfd)G+-PLO]AflQ>eG/Wf
bPTAe7J;GjH*jDVRO>&Qg^<4-R[nU89/(RY?"p8n-L?]A::ff)K<SoPnM!=r="FqB9=4R[kW&
96ZjfFWpg!I"!'h;H8@;'+TVjS_V\J$:JTHp"6ROf5)AQ?M\ROYbHpGsD@ui@3O5;`C`A%?F
%]A91Wl"PV+6GYds/D,hu)n8lHa+Jg:h[hHfICaQ[UFVdu+tUlHD8Dr-=jZ,N1V%=o0#TAPO`
Y!C@_Qr.6:O[[PdKdpUKI$_aZg*p3Km9V/@d4$o1+Q2b8Ndr7AE9"UX;2kdHigP:HD9,pIOV
+(gkHZnW3_!IIZ,U)(Rj9Qir85dg^rDVVjg71%=WB&)C4YC+c)h[Q:ECDg.TT2F\i.:C7<^+
+<,l<WIr3LJDT&W<]AYOVa^WGHoe9j36T_-;F,V<pP5UQ]AKl#,GHA-rgFO7$fgM]A]Am*+FT`QS
pO4-24?%(GFJ_dM+>3`'>=eXd*A/OWpJARW4F-uAYEmCao10tPY-hroGG$)tRDnX3,*c/@7&
+"c8#=#l_rT,*Ek`=gVb()bqPBV_OlM?W_&4>g<r2<f2Zr$aTQQX6V)(R45SmDE,spK@4`GP
a\/;W/*k[e['3jq=Ul(>8$J"YMU+W=jVEN%du4pJ!(jg,r8/"_"]A1c7'2fl6CC,gfgf(VS5A
8W>ege0rR7M7%p&G9HKfQ.5E[=!^a6,[SkFD*;ta0]APWt05\)e@<S#I@NWXdLr&;lG"]Apa(S
74Q8>#%,`P;Ra>?>iT;n8O@Y?5lKTF4ggKia4=FDJ^-JLoI+e+@?UnMAkCOIqUn/\14!2mn4
#9+l08BGBYNgF=>tiTqkmRV-COid,!Lt>.RoV"J0\jhr"%?]AKFg6cKo1UBAR\Q?uhU4VXabA
\ULREaDlpG+j&rmJEZjk:;S@oTZ]A"2b*j.8'G`0_)#,'YeADQ4qQC.K?jbL1V(OfNmG#H)*D
^>>U;,dLk<aDMB"cH7OW7c!0#Jo5Kc4\a+r<?cos'2)_jfp>`RQ_dQDBK-2h'Dl#rpDLA0SU
gT>/<NiE7lcC&lr/O7<`@@8iWYY?I2k=K*\),WOge'@pO#Gjjq6mP)\1+FW;@PS2*PZQI1Q+
p(hW8M>"?55sfmbAAKD21]A>pDqi-.lSn]A#4:HVg%X'nGGn#?pX>ES<Ao+V*6%56:a\$FIX)7
fM[W4's7_XF'QbuOSClBdS?2"Z'P6+FJ9P"s;_f/TMEms/i0"Y?<R\<VSLFOoFWu)"<Fgo`n
i]A=h#l$<&%^R&OA)>OZNAT*+,cU?^LjE5N?gXNd;FDENK;6lPpbkD@;j./2m.4=Agm59C,j[
_7pWuZVJZZpfPI4N?EI.NbDp=rcKBV/>F[FGE1k4&Gr!N<Tn,%#RJ[D%X$cS]A5#f(G$o:"^g
K%nB&0h0?:11r9JLrO<af%7"@\PAo7$EPt7,6=;1[r/Ie@iWrh,gc/@NQ,rJ+5J+?1[dAd=N
2K0OMBA*tYS.'W&nlo7E9/JWH`hh!\LpiTs&ilFQYF*=<?^^7bu]ApGAob7^FI?,]Aj/,VmJsH
"6Ob*JU>.*hiEN%;FoX-6V!5YZE]Ad3)S*'6Gn:Yk"fPuD_b,@t^5Yt_X9CK=P).J>:QMqrka
8t*9.:<m->"5fLPAW$^__pJ;#F7Ug&qR>"tMd("Om%a=L!<`T1_D\h^VZ4fp,Ok6fhU_g_dW
2k4:_Ip8fOhn?]AAnQ__E$4\[^JoW1>t*q]AA\-CL#.1-l'ctm5Dq=flY0&$bOnThfD%_:^bJD
FVd<8d#;(ih26qTN%m>?D\_QcI&5kRC&/b^bZ9WT&bIPZ3-C;6+/ph_#_m8^`h/O5RQ$`9QA
Tu>K<QcY_2E[%tY-TD'PA1OTA7Bp\B]AF`SSLV`1C&)_TA!>>ub<e6urH99.&d[bIN*?.f#D*
5,EBtf',#Z2@(P15pk;o5_IdVEMa+V!@s1!qZMp&@f%5n\gSUEU`NTK30j,@<4PiaQjf$j>t
%O`d7a]A`t;",e7g;0g/#RIudG`]AUAFij>]A[n',`khL5K"U&Jq"@oU5dRq\D3iM>`3M'Ri($^
[KnDN'5%qK$;nV0e4o;8e%0&pdV__>qQ:1*>Kdhj`<#U7+SeqPDCI[]Ae?=!d``2H>;s?UWU9
:=6,=$]A/KN\_[`FPiOPjs[,%"YHY&"MePQnERPmP4p>LCfMl6]Alr+qH0iD%#q$(!EIrYG:3]A
ujQTYUf"07"G3r+4,nIX8'9j0E"d_]AIQdH2_s3F;0,A)mNe]AIAnBlc5Sie:?cYBRic]A)AabV
B]A.rJ7^%IE;L;4GmB>NGqN2`*T<^Y3EQbC%4OJ'fW,V_SdlAj/CBD-T$X%J;RNqS@r"6a`)i
d2i\N&]A7raKnif7S"V?qs'l_]AYdf@O=A%oM>_U!dTs`YkHTMoF*M5I^br[50`L>uEQ!Y+S/]A
BbrI4R_6@3Wnd>25rc1'/FPfY%P&BouUOh,4%!7enJ0?:_!r8j!bPn\?kN9Mfr>nGYjtFt\?
NPRH-)dqZ`Z,JldcECQN`8XA/D*\geG]A>]A(NEmWh$`,oqa`Gthh?rYdHe4H>WAZ?[?\A_na+
1D/b*D^aVe2#T5UjXHYM@a!$,PqE(\-=8k7"7;Fn=HU:*?+e8T1S)K7igG;+tL]Ap?>9-AZ7"
#WTIfEVoqV&[<bFZ\q`HXA!j8&go[RMO%_2"O[R0^%e,^.4G-'d;L*\,4J:>]ArB(G\Zn%f5?
NSVBka7:3DNqR!F5@dH*f%BZY"=sMp)k44@rZlkI(R@9NCu;*NM6[Z&&kM-(O4V_X<H.g4\n
]A1:18DX@VV_@[@tbL5&5I:0;5^M),N@S_]ApO'50)sGAO9OY@,!m==I@u(M^,$G0>]AP!\Lihe
4jQ]Ah5+.fQ&LmCBcJ;UQ'bs1S's'CS&W?t9=15j*3H^oIte-oKGY/Ql]AHM%rDL%?5@k/(X.L
qePBW2#VDq,rMK@"'ABc@j?SC$R/,Lre&%RVTj[c#XZC>:`d%,1epuUn:;Pnd`3("a4?$Xiq
NZ9!]A4WQnhhOg/=<,^=VN,6G8P0/m^Bf.!+FKQi_h4@&bL`)15=51<7SU$Y$&s-@aQmg?]A?i
.>SJd&^3ecAK(BY1'k7M@C;Ep9e1Cho4PYuB8]A\oin2,&/(\'!ij]AG8i4l^P\c$aFK+l/-&^
_/?+_+m<7iNF)R2rb7g`CU,Be)rSQATO$o0<6h:ia!H\B$q?+EFFBX_[794H`i"@/eT"2'Fs
%^Rq4.TA>R+>E23:kg9^Fk#fH,_0,q\N4IZBY'T!.K-FMf9("g1&HbWe&9p2P]A??k>81./9S
C-fkO]Am"!Ps#N>WEF"bNS/@J3U?0$BG1/g&UWVeo78K+Y]A+qam1X3?`f@-8h=4h?[cm:Y;QV
'n_hDtJZ/fI8$Shup[P*p\7J[[p5)T]A`9s4j"paO)8]AMg]AZ>[7_%$PGPAK_,h&d0KGX#+&qG
PHA"CU+c-EeDPR7efgZQ7O]Ah\B.VYa2/qiZd99HlKaYB'@u?9t&["N3hkfON?*,NjGqL,4-\
gg>I7VjAKp+^0F^GkZM+HS^ng[,,0HaaFQ()qbff>:tqo[KrO6JR1nu!@eF(=XX_'K:IQUD'
XB>naLmF1Qj5Og*Ndffh6dd^UU;s5<&XE:2*B?f]A&3FN:l:,Z-'A37D>?rinuNc*Q#IP@B_#
l_Vpc^)P4rYRB^DTuo+Xe_\/#^'!BQl6BU<^L40<jL5WA"6Gg<UI9=bD?7EV%^k?!tlk9@-5
t;/#r3.B_^bl\g!Y4T#Jk%)uQ+3jc!TJo'MA[##;T4=UKD*Up%?2A=j;$TAm5J7g[*Z6?a<q
+?njtiEBg)g`lVNJ^._u9lJ.'3:p1%Bj0'D\65J>fQ%gCM%HY1rZ,G.c5T2cR/<U;O$#>^1P
\19F?Q+e-WC[LBcs4_Z>/YO+Vf*2NXH6-ea6ZQP#q<$><,S>+'n0-9(7MWd9pktQ^mZXoeg!
QZ38q@oK794@AmDIOk-F0'sGZ$rKMA,Bo+aHd)PVSS'2m\*<%1=gV8M\!=n,-!RAIe<4C>MB
So/$7O=Quq>@DIfT^[/?JfIa(-LD?nT[1S\ib9#*a'fW;mS+OEkcI.4!peB%5m]A8N^[In,sS
,$67gF]A/'M^i_oFS2E>b[ILK#S`3."4VTD?4<c#@R(e.G(`n[6"]A]A0?95D3XtSe62BlQ9^G\
O2B2T&r(dGU+"!2KF9j-nB7>XK:g7%/Nssr=0k/3DC/VicFE*(5O&;t.U;6s"[\R)E#QG&@V
fBuZ\TH8hoklR>!FB4G`]A\$mrb:7]A6rK3-g0[(8T:9<7R6.OGQ./O?^0+1@79]A3CY4*rqOif
TjQM,&^;7qX*u/@)''Dr4GRFY#Q=-kJoD/;]Ar4(TY3n>io?/-tJZMlWOnQ<)44Y>J!8S0A!.
TT*a=i.J`I(l;l;8@$i8G&$jAnbK[I7OZ7c1;!?b<j=!geG`+3QKH$ji>r@gIItJ#&ZMFB!/
hiB`YdG9agRTD?mN<kt+*K]A'K&e=VZjt/bgh]A=u&<9ZfGPZ!@>#?M(3$u$N#:8Fi_oRf*XW7
Cd,"<Ka`6uKG8iGfFN9X^WN2sP70`uLiOf("4<-?>le*FUP@qRdjhf23U-d:m)"Do"[mAnFL
@#&nS96EVE5T&U_nsd15CB-1^04[,Q@-R$nZR0mReucLE0dk*$_XuCb'M`WtJf7)CK91J"^t
RdRUJi?(XP:oC(+u[4mM,eqX+K^^7k-dFpOlZmAZ+(5%R\%kqA8!Bi,;$*Jc5knd*6]A<U[L:
PB;NMBT_c*9,Qg.qoA-B[(AMBn_<5rR[[(WPnfpK:Jto<c91b&oAPXZ'*bl^N9Fk9RkMtcZT
5fX4m82QSlO3:m[.l:$\Vuk3@h,]A'W@g&JaJIi6\/:[/0:J_iu9Nk8mS[`NEP@75-qmUG.VA
Pb+*ojANrn@U&GfS6e^l))3*[(nuiEq7>\8-MFsKQ@o%XWU&5CN?u]Al6!`^Ap_"@O@M#ncf-
$*UFtgpspr+GU91Ru&Ar*,@Y'Ab[CI\J014JU!9S4bLAC$k=iHEZHbScrN_-6P9h(;6?6>UR
<@dc&jj&j`aa`Z:B-n.a:^gkF\kTa/raY1^5b:#LI<U:+0lRBr]AKki,6M'CI&`\*Pu`dNjT0
QP=2,qHN?,$pAm[F/'<VHrb)b]ABg)Upn6JP\Sqh4tfJmQlj3l``-ffO.8k1Dc$+1=b^uSUim
P:kmM._"r\GJ_L0K`r\R7;i`/4M,X#O5m'5uY\%Tc[2o[kG#VaS@)OAU1;EgUTTt"0;b1/\t
p+bVMbH3N[P\ZQS=2#u#&<",]A;62oO5`O$O$Q0Z>WFt*(b1H*s_l"[i*MnSDV[^'"gKGYBdt
'QOZF,+R2A\@[O_uT]AecEdA4b`6>L)g,cY"an_/^15[P-'!aF(h*A9hQU)=4%fMcTf[@mS;X
uQ,AfAdnsdTZA?'SPS?5/3SC7D&?#Er+nr$>5#TI\V?1^'Zn^9sr39I?P[:I3'<FU7,T.$P)
![oQWk+4\h1"TI:J>>Db2+O^5(IM.pX.rUQ,k<3=^<qEEK&0d@Yd3"9cg]AaHc06<[#R\#g*S
,+ILDk3ki1XVX?(g3)P*UAK'AAmBsej+/@)DYCF&:";L.=h`T"LhT\X;0"b^YtBL(hi`i:a'
CG:pF>rcD'cWb+/2s*HR%]A3Dr)JHaOcn.llP#58Pa(sIZ1$?-^4jD0jij5FH6.e59@#U%k%*
+p4`t$uHF<@OL-tAl$8;KR9Y/s!/gTMtT)2.TQW!;cB7=1#7,s$7C>V[<lAa;/m`25@0Y<sW
"QdR3Wn4Dbb;U^6MKZ1)Ml!2=:r<b?T#N?S_7uR0]AM0f,cHbI5S-.hj(PD+(-*m[u#hMQFCJ
QqkB-5l#-D,)OGi^0m$79nCRm[gA)!\YCT$(b_>rFsiM,Urg>NF1"6_"I#s<@=k^1tf:tT>p
;%[qLZ0QQ5AIgGSFHIm')iQS*MA4[C`2b7)#1+VN'e(B9qs%6qC;UVMgI:+l+>UPbm`CYP9&
f(.DCH(4&>kZ'C(PV!ZQ&g[6nUa!&b8%9F?lT`a>gI`@#;`3)2?="nSg^iF)np\?*[2Si<b9
6&3C#*ngKiX7REAgaS/D5aO#*N[5%Zrcood&,*<c=+9X@rOBAPp?6N(njdKn@#(TO5\\6m'c
mEP,V*b!g[>eb01q7eh<Jj4ebNcM2+h#G^<5X<I0oJf3_!U20d\NA/eX^/6lW#efH>n54TM@
UN/+6<JmdJA%ab/U,LS6/K308b`FFH:9*fq&HYIKQ>Ol/</@Q+?i7/Vu8b5A%Ne^/sBGO%i)
jbP.JrZ0.q]A.Yg=FdK?oh>/,i8tH-H:u1Do"AS-1LQiclrN[q=5tf6Nn@\eg\HcVg-#H"1<;
Cf05VJcfRs@6`_trP7QsCi<Fua'hNg>1f9^U5Muc./qP(g><SJaZu'M1(7>mKJY/u$pi\5h'
+]AR$QflJfpH_aQ%_SKUf+]Aer8cVL":]AI`h'mBZ_W(N;MT=d7%j[=a.)1m7iMC:qY%e43D[,0
Zb^L0>T$_-k;-ZkfEYRYT0AN6X_^o5o'U+rc"4*.?1kgmC!_(th>,+cs18#hYnhsgY8]AuuTa
a"l+RXDV2ie>aO8gt,HBreEi"pBXU.oIj=22jTh=EWD@po)XG>aAPX]A`D"Ud$LRK]AN@38DPD
`7#Z+#Uk:i1SIdRu_LPDh*/^p)S>/&<AA`_b0g*[mPSRd#<Vfih%I&Tp\,h?\-T4MG6C@u]A@
TCMCQR1tI+`)M"]A\u]AiJptguA=83F#MF/A>HLqblCWE"ZN5.Eu3>VL+LHEf"%D@*u(JhnI:`
HO#[/R>QkOiQ&l>(\H-#STA?Ft7FMK!;n:?A9_CX5adZ1fs>0.(?8B\`OVG\kX4:u$)YcaQk
MaTF[2JpD_0OG%?NXPN&6$t$+CTrTmlja9>qQp<ZnH(':gRfb*0bG[A\c?2Ff;%It;".V]Api
JW9.4=o<B!j2G!,hgQAm(YgU'7a8&+_56'bN).*>jYJ\[h]AfKD]AX^BmGObn*%JmuI8^et#h'
t,Vm.M//*7Jb6BJfH_c]ApaUFd![s(T;n]A'UR%E9V]A]A87!p]A2-o_Mn+]A80-NDp!VfW3L]Ar;H[
Cp>FR`k58TM/@8)Z]AS)W]AM?;?:nd^t^bfZgAt%10MYqL-]A`&`W0q!q&Lj-H26up%HNd8BtM=
!8g,H58^ZT7V6<4g:]A/uL/,\<;QE"g+8u54SEnOb!-(*uQ_Wh.@1IODuGhQhWG]A2en]AuC6'5
Z5L4R.7/o8dB?@N[>dN>9gQr6-bM$cD@sPu<o<+%8`q&0smf?"=S)tKd^7W"KEH0kJT9sGn5
>P_Q/'!RAeVcj_:7cu='T2K7=9DaprkhE!RS4tZM/OMWRu4"jrduN`T#=XRZe6[J7>3M-o+(
YYgjtJ@CR7tq)#@WQe/l3:dVbU"W4DrG:AXh%4ZNki]A\O-Ecp"<Vgog6Y*CmVA#A0C/,1Z>R
Nf7@tf'/<&`Hn205^-hN-+[0Po;8i8qbkJL^S@RLPJXt:^1FCVn-d/4#9dm'O2=)rafV+k0=
:4p:Q&75q-g=2hTtf\&_Y"UmuUnfH`Khc=mt%)%j#H_[ljjZB@X]AZ]A4oi]A,m'Ap7/C]Asq>J&
Y<<NlbS48q0A$V@>Qkkl[0T=k/a6;t_X:EZa6c3T#34GS"\t_*m>/=%Mc`'ZJSg9+^Fd"#\.
aUFBc%+E%3'Ua3A%UCabAOgJld(3lY)1X7DHtEqlN?e*MX82.o.&<>K@5q+kYX9:)?=BBcR#
ga,>VWgc>jCEg\A^40n0"3#k:I'MOcBB_OlSi[qM,W&Ql7q<lH1MZg(\r*`dqD'-!e.Eambs
\\JC3DLMgcUKg)hB;iOmBN_q9Q*5Y;?,u_d=m,]A9en^#4=[<0?LuH9W;Ydb'+pXqM47E&L+Y
K.67epGGpDIdmX>X]A??A=h!/.Re@f:S>>iPfb_@)]A'aj7Od"gFTl&bp<#=rr:Dq>LAS:R_0i
+Ot_l7WJdtFI.=9D'AX"j*[r\Ae<+COHk<4+83g9*e=+96guk%$G`7uZJ%+_@M4'F2-[JOq"
F7b+4CmgtBe7/9jF\oN6<CtK'B`n!,/r1[[lD,"pN]A*p]AP[I=^Tn^KjMD7BctKQX6N>a&P'O
K"d&PS^D"l&FIVMLY?TrpURe7]A<X1Q:fFKpAoG(i4%[RTR"T0EFaC)pW7Ro4pf%RM?rSsi)H
c(jd\nsJ6%KUn#_6F4^`QQp$apa#]A`Sb=id3AoS.n[N#)O27><a)it;2gQLZj!)"?)uKoB[L
>OQDcPe#0>!ZEq!fL,pou61VD@E_`eQ\KZH'HT2pcdtjQ?Os1%RXGEIG?TMF&ob#).-GHZ!S
?\TR5!YSB-]ASW?9Po;JW1PsF._JiYEkOF:WHTMu*AMD<C-0a[B/L$p>%Y:;U5:9;p%D<(O88
IZp/ISY2X(rAI!X:9C@I\$+\q.D]A6]AY*u\4!W!Kj!)b_=1$C_";V7Q_.WakC2F&)12;BTPBB
J4/sgQ`(,GlZ]A:+3(GW`YA@tgci&KK5Z.X$N)pSrWSrYi\c"8N^dNFPRVijB\@nH/<1mk2B(
Y!2VFmu]AR/EU[TWKlKM2cTQ0QJuYN#l@N"5g+0_sW[#%uVCp>)P,]A$<GO=_tE^X?4UUEujg1
NWAWp,?ZNUGrf#l@n:f4.9,h6oV]A@]AD)S^Gs;5DZV:;_&;0.^P"11&%\![?[\=(L56c/6T.#
tc56SDhl4cfWm,V[(!,O/F8#B-91NcU!>=^dGe#iqRA%C`-0VAdH2W2Bf.'qh9<jJ+-YF8jU
G*Ql%`!]AND*;_a"07ZY_Uf1Ci=MkOG9COLoF?ha.>$HV_41Zn]A-ATU^B<"qWe0Ze?8\]AGe!"
r8f!bBW9+8IWWOUKeeDP4Y9GEliI")&&*<@Je^jVj@ir=]A+Pbt1cG6'Su\KPFVR4+Y<MZWnQ
bQT6N42&7l"X+.)/75toM^<4E\Mh&UlMa8n%5#]Al<t0#q*B2^'^p@HiIG0#`.9GosV)QA#c%
M,,fi>M8L@*o\X1nQhpr>!ll(/Y@=Rkk<d9lH=.kWUI>pe^/E)Rnia[Wp<9WAEue]AGIYD?U#
6Sq"W*:\`D?nkSl$<_0F"!jJ0sk^+eW7'/t4F3iLT5ISGnXXLH+IeA*@Z\@o;>rCD>=*j`J@
G+/c&&S'UKPITo9)I8,KAP!f5M^'BQM0V^l?M!LRe1P7Nu\S4]A[=?0j7KoloV,S8m'-]Ai+6d
1p6#]A:M$[*:MTCVlC4K"+CI9N]Al-sAlTdoMUrE-nX:>0QoD;iRfY&uU.*`=hm2!.n4I<2gKN
6uS;BI@l(]A&DkD,pl.Tp%t_F`'`RII#LbK_2grtm78q=(4YkpT\hj/>Lr3$V4?6!F*@Xi0Ba
J]AVAK]A3irT"7r+5b(#UFM>[c?d`7qtdmLgI:EP)?9dj^Z!*&X_Y"#Nc#>^\qr?_/8m=PMV]AR
XIFqc689l(;EMt%Ze%s<5Im?F"?+B/S4mAA]AN,N.!8_am;F.N><nX?,tbnQbH<0c7]A/(%p-K
'Rmo)L_)YkGDO7P1\g8eN!"GOH(YVP`oA2O5,*ZN=K;[##Xde!]AH!O&Aqh$NK=ZKmK(k6T1[
/g#34;[dZIk"CZBeiM_;!gp$:5!]AICR`kUh5KI:Ff1U.<c_G4M\i]A_8"chN\p?:7@i^pKC^^
i@;/075B#JrmpV"3u-Z=jDs%<RM9c<pY2QQ$ZmblWbFUR&kDlj*+(1-L&Vq:Y;u,B"Z\Y>Ao
DRlANoKE8f<f/kGF=jTc).g[ZTf-4Vn[]A:\"(_hae-h_[ja@eR6Qj*s35]AqI->$2a:*bWKs9
a^&/K3(nT#7I@10]AH#.RH<(nt`L[G"=--!dG6X\A;<u'A`!4Pru=g6:to0"h"hjD_BUf/>(P
OH;E8s/C.&h[098#983`X%:IbBurDI,EThW\4<bBr(fGqARJ+17M'HN]AdpPNNQG`PNU!+)B<
HN=G[4&>f[+7c<\Zt\qb*^+aq\l$[Qq5NWXt+`lZ5]A!1ISS)BTlG5%YN_7JYPlK?4a.*IWRt
CG=+J]A$(R7E^k..eREjf%=#gpmH*_NZrbg&;KjP*WYYY#<NqrSlabm,H8lDcIqKAH7U.R'#H
io*Hpb8X/Z`,$%+F"TJ'n\gJQ4i.QDp0_r_<)>(7)[e41R-a%9lSjh"T\PG]A=#;n8&*T9f?g
u#hh18i_uOAXL;i0.FLA.XZ2!+$oD%A_U!8lMSNLYf7-:nabNGc^ns"t;Up1XW4<16f5.R1n
Uh*$KJ(4<O,EO%RkeB-h&&KP>k'a0g<\DJ8&A[>_bn'fKCMQ"e-@"&ai)Xem_kD$>IKL,2ir
:rP;e#n2u;^h[]AI;(dUP\K@/<4jpOi(WSHntLaNob'B!K.,Qb-#MjMWDlfgMh`N2a+iLYjPK
W:W:"hkIV(`QTshBnqLD4NRhPGA4D'\RWq<hR=TprcjtiBd51a7%U>R7H,?t:b;"rCnkA(ZM
HK:^5G:P2U]AMeVQm)R[Bo]A,G1XYC,t%\8qBu+SRM7>*hblG`d_6<C1J##Pn2*%`BrM#L\q%'
H=C/`IG6:.P%ajpO0W6t:^IK[dpN2(nMCJFBY,G;s[<!Mi&=,3]AZ0P-!\OZuZ70H=klZpMaj
J`<lT8r7a;ge%^NSj&rED2'EN-,0OVQ5^!*$;_(m>Aoe>:Sl>*Ddu:eId;<5AHg49aLmOVK)
U1'u?363Q14,j&12%qCucaeM)FWAF:E9]A:ku!^.0IWV?jNN@+'/T+ZN>"YACg.;7NeuMc'Na
q,0Zqhoq=m;`\+&lL8U)K@#_4nQ4TBFlr*[17SH.js/8'8_%1L-goK@JS32<ffp,*`S>1DR"
eRE&M,L=9X^YE91]APBJo.>@m[O1n69Bc@F[:,B:b*r(Z2L53[8_"/UJ80hUS;*E=#WRfPbnT
5[aF0_b0o7$OYn\UTk3rk&,E1=acoalP$;c#6e>P)ci5.d!.:c&_d/^Xqb7=cHhnHd.uq-WB
L$j03)nW"0AR!$K1u6RP@/['^d+)(Q8Jn'>s:!%$1"lCfK(ocfsY<?"+@4]A7Jb7')q/g1pt5
FM]AD+SS&($!&5O3I86/nbQ>f'p7?lYP0;Ahl,\_<E?hKP'njct8Ur=>IUDsP:c:YcB.aWL/`
n,;ZAQ(A-a&t:3M_28RCj#t<Pfm6em7jT01&\qc\,o-a`-K'0%16gjXD1.f.ZA\VrIQPIuY#
ioF^UgGO(Nk>Z^Gk;q%eX_FXrZITjQI2qSm'`,q0Uu6p?)R,XGAEsdD>6s&,=74fFPPlH*b@
8e\+I(-:!toj1CH#B-UlEBihe*5B#k!<fJ;jXYdSE*#B!]AJRd;i&g2&M*lg_/1*t3dDr/95a
U)['W=Y+P62*4p]Ac=\2a1>sAq-9@CNEUHLYc@LF/T-PR+rtkDe\XM1h*I"*<@@?8`!op._.D
/:E#rRCP=ABNSs+4oK"*:nne'D&>M$46d'<V!*QaSms*_,mgr7j7_bj!f#(QKTg&dt\:$W/f
T-^d+O!TpJKAA@)nXI,eBcA]AX6tftYY-ergK1d,\09F7U]A_Ri(kK+>#rjK(15FcEY<pT]A-Mp
!<ee:8eMXK*[)q2Bj-=)CkpcEf%2rh/g9?fdK9[LDN731H_\72Rr`iF`@`i01Ydji==B;p]A?
tm:b5EerPfM-Ft;iIGQ0cA^501aLE.@]A^tcZ6aBI[_R5)u+cCL]A"aQ.jS,Q9)g%=O9YptQt-
i>/RZ;pCiE+tfMFW/R_S2Qe/oqYWnGq[EgUo^R`B+f)YZSfuT-N&A*C_TCp(C\"YJG8*r&-K
,bO!s\geUP2GrpP@"#C,ahonN@&bbpRn8*<3YgPuNVQ%B9bN`ojR?[6>%d*[@^ebR+-]A5X3m
-]AM6>V+`T#Ggr4r7A.o'q$*QDX/"lXIbL#olOEX&qef1[IFK,$d+=1PdCD8TX?Y&6<*B%/]AY
\`%:gtM"cpg"jSpCKQmW&YQktQ`=4S)rb[PI4M&pg9CKn9+=7GF;1Z<h-C3D_%Z@)$?3>NM!
m7^-'3=T`^+]A,Q;</9blIL26b.:7Dn@`1he3)tT!:(\SioEQSK(m/AcA9GOBiCVZ!+>>;gsJ
+=:In>gonD`L4%XLQXh2^`/f'>%9RZPc$AFV%fr#e(cYi)Tif4/jMm\]A=j?W6u)H<9QWMT_V
9Q2EWn[[<<_LW^YC@>RrNuKbFsBbB]A>N$_u,1T7^.1GnNno'<*9&"T&^(9.p>UWd0>oN%H&N
rlYT(%SChd3)P@i-P0jkN"`O&*B0tI0=ZfNG/Qi?Vo?JM'ho!Mci1?0Js3/D0[YLqJF**(Q5
0smEoFcmeYh,"OIHQRKURi;3iWS,HP84F)2=UK_?7e:^d&._g"Y5SKXQm3HUXgn,#D.rf(l[
r1m8k-*htq08&,t0)a8J'cFrkaE/HjgQ=Bn^Fm(EFHd7+Hiof1]A?B!/-hRW#Z9aC)hM%O)]AH
na!'qm=4C&nVW3Z43CIES*W;SD*+d>*^Srah4hWRpXV[>G(I$m"f0=c[lq5%mg);V/8cX-4^
I&s,YV4^kV+a8+ag$M$ZWZZ+&[riJ6pmnbQ6]AW30F7?-uGu<cAfQh8I`EE2t0u8Uu@Fk:UR]A
/K2cRhEK[fn>lsr:%-GeQ6[a9V"sXq_:dX`Wh9>sUTcG%Cu-+j-s<'i(:ekV%jIAhp>l?1)`
K2Zi'Jl.V/Hf:0,WAd=8cD*5/1mq><5oV_p2aAr1<r`lsH2$r"C[+H_,3K^2Ru)?+/Tq[]AZX
OjJdD3\sDj5[srI3r\Mu2$<*S7A`4hC\:cM>NXS;MH:k*&J/1#r'PhY\9"u%NO3M]AQZ3YjK3
*?e6i9gVt?QI"-5<P\Jd*Fus,kj2>9h??M<;Z.A^1\7$\52fQi!<0@hLUT!FG;NMRL'[6r8G
3GA\*rGKr$bk0rkh`T/h3iUs1a8X10n<XiRtX'2iA3#V3K.N2GX=%\,b<2]As#[7'j(pfAAn8
c"G%ci>h41dkM6cns8/`k@[ZO:1P3V9P,YRQqU\hbetL5(CsU,p`8?bCnK(NW)"GZPb+jc5H
7eXf/lTI^)_EC'<#5MTASFu>0Z:hl1IP@jRlqZ1Wll5:^ItV'M*jboF<5<"<3>iC*[=q#;bi
O(V<Nk_!eL>a4!ifde]Ag-]A7CeC>/28KG:"q-imIJKlh0VB?hain\Jh<J5T>+6jQit^F:S\#=
1h!^=!,3'=n:if]A29-KaFa$mIIE20J1J8pAJ5&tA!>JuF3kGB@uQR_I<."!@`fjL2dCW0Eo)
2*(\-]AWMS[!5gCps(>ailjRK.tmPOL3G2UsXp"TPe:BO/D:l>5Ab5lH6'T7FI(oL<pUF.79u
:C0c2DfsQ4/WWMq&;aCREM9c<DhJNQejW$g@HU0`793uFEn84BVB<!84Sc/Yh"rEYq?pe5S!
,AXZ>kimaKNm=]A4nE)3I]A,cejPKN"p.o=]AQ[5W0+<"BBIdrC+9]AHSCI<k-Rl=XoR$M\Uf8%j
W7r?eV*%0('F*"QA)I?tHXXpa]A4WV$61nY>l6-auoR<'Db#,R1q6K>39^F"'qYF2^N,af&iM
/FiPNPJejGme>X0]A8*^V_5nu+(gp7V[_@BO9tCQj88\c$\6Y7msFPbHI09<'q-e%:c(2GeZR
-9o6q!L)?_0Q0\+</!&Op'dpb0A"s?:i[nB/OjDXY<3A:sHh2!KH1mQ_NOin(S@1L%;=om_q
RSf+F3YG1$aMR`W'*?BjeeZe!g5K!:3Yr"saq'MKMTdo(:aUP)LP)<SNeWhR\b*#j]AA!Kp'3
bH93E%T7?0_pFS@#DQm>YQWn@l.7ogN51q_.+9)qXi[rrZqCZSU,feXJ&c+(0:cK,jS@h&p`
32#+H[YQ(adJ"rCCe6G'6puB0u_T%Gg1&[s++QF,qSaFdVbl,d(HMA7^Q/N#NO>cKf/(V[Pd
#A[-R#10YUW1]A/E^<j<(O^Q!_2IFcb)5HfZ<.K)#B&kj2sfmiI(Zn\e]A@#/\2:H+[>#a78^L
1^MPi>9JpSL7^HLH!&$k9Q/l;k!aA*_m#A<+"N.r'mX5?99O8=n5MT#<Y58XK,nacb+$9)rh
orXqNiU8#.Q;Nt!\V#d?U55_45IV)(XWqlUOe2lgm&QS_n0rak#QNHaBZ/Y'5KZp?U<&%nf"
PF21brp%-`+,5=p/sRR28=OB7dB?K@Zid:U8,%6F(62b@K&0;+e.]A4!%qBg9bpGT"@+*-g7=
<q*5uucL0'6Bq@mkoY75prYQXFHu/TCWU9S1,HDHjF\'tZf0]A]AGjuUTA!)G=M(rdu]A@dO,ad
kf"p;Bg`h-%AG2&N&ZV?9b4#*WP#U0@u'%pBNQXEN6p<Z8UESgUh3PLFAUA=6"0hlh^3U/^u
V@^M7H^#,oGOgZ5R+cSh0J>^AVk4IAN"'$YnXHugAm6I;GsM!AsLB/oJ#C3.1<_tbrM`Vq7D
)g2/Y%-LM$.Bb1mWgIaBEJI(tSA:5"28:8T+MnF[I?#+thFe+sCW`-5MdDAB9!8VH>`#Ai>1
NdM>Pqo5]A3nJK.iO^HIiRdWQO9+4XW1aZmN-n(Bu<4`(fYSf/b`H]AUB(5_2hDH8F&`0-c*>s
WIY1QiQpq>CYT:tVqjrd0gToeaNFEu;"NVuJ`741amq:1<\NdLrD2%23q1Z_dW@p@tbBsTTk
Sg$S?$9it5m'at4*S#h6KRRS<;P%e+?**d`^6!F;.HK>-3LuLkBIS\i?\UiVSu)(f/Zk!0?D
V>pge9lWHbDF)brW70JfBq<`dWfp82c16_M7CHi(Q.5c\)"*_W-)75Bk8m9'BNXoFE.f`WY=
af)rD<93ORC.SdTL?JNW3oMInfdiY42LhUV,kR8J-RDh+3%P&;AVi\B>\+<rH>Z(L/LlKfLV
8W9<5j'AkaF@,"e9ZG6Zrr*ba'YO(h7j!KQ-%Z!BlH+WO$=aEOs!k:QN,mo6f*(([0grQYUd
5]ASs-lr10p!<UcT>hHtuI:c]A+r;Ab4[e1L\1Q(@qOE)qlbZh8m/n59K:XU)=bGB.4qj??:'&
[Uf",r&P$;e*&NA)\V,PH'u/As1GIAb2Xd/Q:M/]AVnKt&CE"5hIsl8iOo)/hZKKX#+gT?s2:
d[k5Sn>qr&JqJMjN+[eb-*8$uN)eqS.n38c%D2`o&=>9mZl`Qa0^!ibV.mLe1nnbP.&"I_]Al
nL)^dQqTG*)Z>0?+De<aldgYC;U`.C%Q/k9g7(SughJWEk[MrUl`%I;C=*=c\<q&5PG4V>=O
'OAqI-;Oc+D6<X/GuW&>Ht(9!'p_M,6KO)".Fs$ruF)6s;5=R*tk=VVaJ,dV=M:abKOn^f/3
VAWoph=N<ToJr"Io%7)U%%=os4cr`h#^XHb]AVU]AORHQa!J:qKPDS_cTdr?083HEl+pf3g<3E
N;+DAGPXQ@T!4*OL@YV/K,HDpA"WeIEQJ+ld@lb_l[!ek(a&5U/c8+Bg9W@AY'NN7,kfDm5/
jt>%2)t[\5S`Rau2YOD+&*r!VXXHJ6EU#oZ8QYj'9;E]APBD#(I[8OSq2QT07DD"Jub,bKVc<
:mT9&DYeDu1mn"2IQM/XK$#"2qop\%-E76DopiG(n"OV1cG(EJj&_&?jh#eno$ICQ21k_gT7
`JlZX9<f5M)f>"p0$H`_kjol0p3JX8DZQkXT1^C(]ARQJOCE#cB"!_b,]A,H9uL3F>sVQPipg.
6Ca>]ACa$J/6qli\5[4$Oi<fgk1RUKO!*64H>$1&qpG%=6Kf51Kt-<R6:V]A'=)V/LhkZI'gl]A
jEA69=Z(OBI$,r(0LX5-/k(T,^4cS+?;!T<#1GtVI?SZ(N0f<aFlb>g-KW0p`bDC[Q[:tllc
&pR:`O*`'pr?pnQL($?Q@QB+A<"We/K3LjkFbHor.;+.f*\\e6Y-"pK(6/]At.k:@Z/IT,<b*
CQHc_.B_rr2Y?Ctc(>Q8%`ZQ%dBP-'Mm<!/(okN83lGWe[YR,Lb`G'7niHXYV,YUAhW)B'Qo
`;+FYZ3PUbm5V\(#oa\F-[2FZs?&hbNU.<<05`kDt>8HlS;LHR&oM7a9A)d8TqHQbMrC4d;2
.R>GMH?*O*+Ni&Wc__t?l1&TaUhC/$M^S,/Bb-p\Xi%'_4+-u75"jUKF]AFOZN8Z.cYJI9pB#
*5b8Kl-^/Zatl"?6;O-jDc?/k+-`IbM_`UCr<A1KDP7,\&'b/<U8PJAq"F5-NabVI0g9VJtO
5:Y+aS1W;,t+N0!g67)E9<'.8k#Ko*c4#7ei,a-SM/2$YHK"uOj)a4#>dgjE:p.ZV<GO3?!!
IC,ikHY<oPPE>'%^2Z1dnor?VjdHr'-/$#:b2ki+\g4Yse"U$MA*9)ChjDC?Kl6YAY1O[#Nd
UR$mA67e4MZ(eB"qReJLrXOA<\Y$[*tj%m+X5Hp[0)EbqiW_B\O"BfA'7'4qO[9JQC,/Yu@a
)g)CGW':)Ni5QlJB.k9gnVj2jP5JA,E86d=;I<)Ff9D,ho5coDfdEVbmWO7J%0Q`b]AbGsRL3
uSAcCFMBEnrB'O:ZJ=!B-93>pbreZ:=G3Y8A[-<gI)Gn,1IY%i2(3\7FWR$"Q#7+G^b%]AR9^
+6\^#'^&A(jtI0!59+&aIM8jpeG3BNpieN6un.6b'hl0=F)]A(9]A0-%rV+J>6I?_tK(!.@4kC
F%*91-e7$,IXc`_fm=Zd;S(/&PA@G3i/s9EY,?_hD1j4L;RD>,`Aq2DlH*7g1MF666>T_^';
Yg)_&*2*"=4,X)@5,*GXj!#'=?PsCn2CNa8':bn`%(t,!!L\.W?]A$$=n',f^/GSKm1I&R7!\
S0fduhNVj%!lD?q;&DVbqs7bcVX=Dr;79>EK$^-:F>fH7,cf"V2G=6b=*@dt`IQ"b@EVB>oO
ISrkUh0D[:OP`';eF\k?@r!AHh*LT$RC'G]Aq@+!Tt4dl\di@V9!PbhKeqP6<*E>f9:6nZaIV
2i?/S/oV'nHC9_uC5>b*iNBWS&mU!["sC,s-"(W<:oINL&MLcE*GAprF4Q#lNJOMST8Mt%ba
0CN9U(X_4WkjV(-o\J*6s#l#4N>+`sYeP+K-2HdfW)NBPfAPpX2tXc=en%qP=C(d[4Ln8Ged
Fprpm:FN.]A4Kba:6Ua@^tupApLW&f^HUH?G_[='VjQKmk0_XA95J0ma(DEDE8@7#M%`[Xs(d
ArPdn%NCM""EsCP?&L'p0P&sc&.?rXYll+J@Y(+sq+?VAeCD.T*Do%@V;2`hq-TYa^Xl)iJR
b!?Ro.&,6a?.PM+Yp0Id,OdrV^_/F;&2>AN88t.lgKD18pT2^WsO*MOE7&+<mq?:L>iMr,po
[f_,s%ee,-*tgM,J![Hmhbr\U_aKG::OJT]AJV#J$P)Qb7puX:U!sI,Y\0#hH]AXB'"N0,Ao&S
gk'Z^2UJk,E770k?IS"L63n;3j?e^6@//Tu&f+G""fE_+Ab)pqRpeHmD=?Mnb<;G=k`uIoh)
CiBj]A?3s,sb\'H[:&C4&Ti;BKLL/S`Y?\/L9@d,)-$m?%Cc9j@dLXYTJ>_"aQ7TZ!ub1Ba=X
A6UYl]A?%NUs^Is(V'752Lm6.;gHc5+]A$&>?cR,B1spVhF.`.h9idBCcjH!^->4J'K/l($QaP
NT%q[A1hD;?IH'8UI531hs)EVhc22c#Roi]APX6q9D4/nB#-r1UDI^%4A^Rhl2SaY7/ArgHL$
i]A4U]APp>5lUb-AG7N.c\+RI&+)RR;7`8VRXEt'lE?:(g56k1X:I5\4eXsP2*sE6,$Ij9c=-D
!&QJL#li8YWkh\DSK3KA1Kp=t!Aq>!`XR=.JD:)VcI#7hT!F2@3-T$]APpCadlJ-#EED)e'Ig
n\`RUUOilF-9T9,ui[0frMP2k-;\9#5*!1:MX2gg>'dee&o8C0MO/"`+'/1)Z-@Qc8ebj6`E
]A@pKaDOqm"?XXG6O)J_3+6@/!2nS?J\&\W]A7)B=aLX?V>]A`)WY?9r%r=KLgM(HbFpSJar99!
2Kj)\R8ZJ_JFEISbFZTcI)B(m2Y?:YiXkMZ)LsAm8u?GUVg#lCrR^YPhMQ?4Dt>am6oj\h`6
`2o@7$&ld/b?G5cQoq+G!cXJYV`p-t%Rb=IBh&%rJi)]AApqq*7t!*?HD/B.(2W@8>0.<10<U
KWUIf5W-2q_pYlC]AklZ@/U\nnopYnER`N/7g#BUM\GB"`^If^?62SqE>q1#f9td\KCIcYUNl
NS6$VKgV0Z!A!V:]Am0O-RTPO=uVl15@)Z4O9OkP:V-a.O/R=a934'HrC@[0;]AjN2<X]ArVdIZ
s[)!^$nuS->od]A`k59(dA=aa7ZW!c'*nfWN^r'lG8idk3Hm0"pEQ7cfYI@<X%Ojl/;gh[A?i
tBH:i8&IZT@:!1]AST8i,7>S\FU)btetGUUC(jha76;q,N=J[@1-q`YSG'Zn[mCN(-X?RD>OO
tqlBcEtZm8MF9bXJ8ZqI3I1qW8U-9#G)PNoJY[)lK@1m."H`d'u;PJ-mI-ACu,;0WdQD)G)!
Y1,;#j80k_SM=V&/MLD&nsnSZ)ufS9Cj0cRMD<6iK:j^IW42org66Z&-V!pq0-QupMVMmEQM
!P@\<N/7a4hMJjMt&AC@Q*!M2ekqU:5Uh7qug^euPC4eS4)R.4D\SElFU!"),QVV(gm*&96g
leNX:lc6:0U,0+30`'s)jHjfT<1Q`$seB;N2+",hrIruQQSHM6;1u0uo:Na<FKaG4_MiQ)K)
9:$ppO;H:i[B#m8<<i_CKm8_SLbY0:D#mb'#&7!`9Rr/BG`,b%dTpI\EW,MQQDm^r;'ZVWLV
@b+G:!\!i@t;/Z?c:lZ/.1RuoHPs$.e"o*^:orXO3^X+ltdhW@Q%.$3SRn]A%a=LqCt+Zf@im
4h:4rMqV!1pskVY<XeQ<&\u!t14K7h+-ZLA)_h@7R'b<n97e6'ZjA!&+:a\$s7XnWiH8Zs#X
SG@SO!%p`E]A<a5A,[el?`5q4%#=8Y$$=;,c,*3=Z:Ueo"\i9VpbsiLC9#Pnpgg4>@Ya]A1?PA
e[J&C9_U1`]ADTI2N9+\Y]A8CZ[3-okTG`ej)W*bBXM;t$RZ+6ZJpAeR3]A@SSoM:UC(%rc91<a
4BRAr"QbmnF"`@oLI+%>%$QK1Bq]AZOBq6->sDb9G`^fb-$C*\f`NKp?QNNg#ARn:akC@+')1
"!]A/^]AV9AE;W_n-%3\fiF@0c=cq5rO8PaZ`V"dLKP+4i$n&oHQ$4\5UtI3)a,i\2&`IogJCB
Re^L&::LI_I<"g;.Oc:X$gmH9)bW&JUeTtPORHaGH"fnICe`DJ<\8_&blX.`RCb2KmY4Kd.p
6LflA!Pr7@H(540hr.Ci&D+UdW,uKMQ3_d']A/"HFminPW<c8d2`'#+[JG?or<V@'pE$=@%m2
R7`'o.h9:!\5,RhuMn5Kd$X9k_jN1j0X!Y/%r'(ui?TjTTB$QqA2?s,ah<2Ys/,/Hn9&9"fJ
^d4HLsKVpo;V\,8q?($1%edGL&X*YQ;\.;!$]AT\batIG7B<0UX@;tXaSYN(08VP@h=\8<.%q
YpLgC6m7umY3IGGh'(oHtcT5$$!-Hi]AA,h+(Ac9Cq2QtLb)X:C\LP(M(bmQ@K$QSs53o7W&-
,%j_,mUGKG4BYl[=<A'Y]AT)^%Wtgm]A+2$Xt5hd.M#$irr`ZMX4eBP'kn>cLBB^RNY5`pA1V.
:9.2h%F98g44i\8J^.Agj[/E7Du90`O\CMR$DW.5-d@W5r+U8Zk)H>966r@25tAa;l3Q&F:q
0mf69%epmc_1(29=,tNWg/^IV30of5^+K8GsXUQD"IKVLIVWoh-T3i@OHVmMt3NP;MA30?*c
\oM$9LddTGYQttEOInQ]A-O&hG!TLX?qp2\;M,'?QqSAY%)!BH$4eud*2SF)NbEH"/+H4$WMH
Dq""-o"ftlIdfuKFt,`q'%nk.cHb<g@RL")?ehr]A(`:ft*KW]A<9d98pIA(;]AX`rA%E&%@:3]A
.\Ic&E<.3"_<TO1CrU#0K/W#GO%m"6]Ah#g#I7RSsd%JtZ9`*^DoD.p$Vt/bu<*hK6>JK`t!@
$5b**Zk5o&#Se8c6NZ&5^R&bmeY*O47d%eEdbRI=/s%[f*'`'"#2=L\h[p\Qb1/=Y'[f5?nN
<3N`dqXK0Le\>3s-Gs\^f117'-@lK.gkB\S8e89f"0Y@)Y22/5S6/,Y/71U*^9-3tuMRW=Vd
l]A_]AaFkh-nA\V(C\Yo4>c,&Y!-:n-;^*,mEtHscl/PYuq;c%X650pm2%A.C-ORl"LDt:$5"E
uJasSjI_;Rq=7,J*h+#=meod2LcWV**E*+&RXW&_H>n\V6B87)3jPQ7$7fK^jLR2]AOo!=,kQ
HIn9-Vi!$5rI/[8j2tUJ1qh2<_R1EYG6c3LT@OF68`04YC"OAhS(e?4GM&::(G%,9P6#/LNi
IHRbNq82p@@pf!tASY<*+21Y+d7__Y`&5PrkaE,N$0s9_o[KPWBa)'+-GdL1?!cpkP&5^V2h
@Q)gG;Im:@4jKMsOeTZWh_pjGZj,3SE47@DlctGP[=]A%k$0(4buMb<p!n"g8V>VgdFs.E4g[
[&ZS5.hL`O982janADQWW"rm1%$?a_>cT:s(N2aGS0tK?[WWQMNFbt%Ql5r5W(^',<b]Aq0r_
`ZSlu[6[I"5V\d\MZ9V]A47\;2nMdW1Ec!P3/G+$l^pO-`d3fV'h<p@4)/kQ`cs<"++rYRXY[
CE?%l9-gZXpL#NYT=8,),ca(%=B8,kYiF,EPJ;aBB<=WkLbqB/ma-m#bGS(B%i_4DUR]A">c6
R$fDC,Ku<K5A=S(eZAklS0g>ErZ08XJ+62'qXf]A<Glj$bj;L$rOG<A%mF+ZIS9b`fK0pRMqX
@./0'X?[B=cfIGTO.+)F0TeF()<'<K[LAH=Po$="06/ST37%iH.jpjhcI$)U.MW-L:B1+Mn1
E_[]AU*YH_LaCg=naOU1%\;Qq*UnFQ2DL9R>"r]AoZ6N0e?tkYDlR#5TO]A&4!::<GhAOU/l?b]A
]A%,b2d0PN5m5V.Ji4T+2FeQZkQNgM>"K.PjOsOAHH#GhRDQ^<E-":Z2nh=G5nl\)3,aR(9SD
+j9Xu0@CQLj]AM)0Q6ta*%%$8G6*$R76N-_aG4)+s=1hKc?rJKehC$i*+=e%q77i-3^nBM_f9
oC2232[m$^tnNU$+Y28D!<m`n+:qFm7/mY)SYH_=Ta2`M#nA-0p2LN-]AE94pD^U4fBE_FId.
C-kq=&kgN<%\Ka=IeD6/S$hd[fJ"]A:jD=R_Li+#Ti!K.!"@F4g5^2iV;79L'!?HNlLHlQ"db
i)Z![2s=JiB_BZY8S$,GKji32.$s^cf&c4YkB"t!LO*@=M732,>gJb?1<MWU<-X+hT>0;H&&
W2.jh,NAZQQN08d\+RI,.JC^#e)=@:Z)ZfasYPheTP'!X:%D4d!O(GK'D<)kJTFJc@l;&2A%
,ke_7^Z,^TY-0oP,H7'(kQg6b6klLg<h^ilRi/A"5t9<l=CO'SH"\#S;_.RPUX?S$fhL_:Lc
]AQ^jm=fh^OVq'FPppB$#f*kOp^FY9'9n'PI:Rd[iO6Yd2gpqX/GsgA#>8$2L<p_0)d"dD4(a
Cb$s_e<;/clA"f2J6(1?$)F>e->gs!a[ZuZS/g0'@I&,Hk&Y]AplJP7p\Y6qFXl;YK2$,`1RK
1q6/T%Bf3O^16>\`8.rWP$=q&_C;a34W>1SiqM/ZZeYA3LKFL%tTkXN.^!k1l_hf`TXjNY@V
@,9DMFJ&N`/ujf`ea+aBRqU@CT[re,/\R:ZsEdLHu_[9W?sN#pWCYqk1=)ZDH4q3^$GrtKFH
?oH%N;fN)UN01\ipe,rc*Fl^;;B-"j2RK_Q">`d$[LL]A^-XJ.;>L[:UkI]A;f"\TBMDQd=:B-
Au501HFrTpo*7^a$T;9*HBi7`G[<-0R+C&PD2k<(7f0*_tnoK+9.F8C_d6\s]AS(Y66kV;F4P
*f6piqmSrALHDQG.(SE-X,#d\XSTHqjY6Ls+GI0LB4%.6Tb^U%fOHRZ)L8K5oX7N^3-@fT$P
*QWBLNFtbTUT\m?fh1R,`SS;7)ZKWF=KK()\R>?O`rZN\k^/MAO,"5$0V'oU?YDZZY_fA+X2
J,AB0hBKja\0o)86JgW$#/j/OTUP3FWt0bQ+=<:qb@5*-dfiKfSN]A-Nk,H.@F-Y$bD#pV$V>
poNjt@Z,F-3<rX>gBg#5NeS$n<NX8*,c,,rFm!DS*8OYBVAq(jei=:f9"5j5:;>_Mof*>of[
ADjq4+50U3q<F-ZF]A"_$5_7&kM\r6nYmcoUR9Y2k8i/E7bj[n5ds$VV[h'8%OolHLA5KX_*=
fU3Uc41D?m3p-Et7K0r`]AaV7>1@P4JN;kmiG,g7X,iuV9>JJZN0Y[*Rq[$p;LpKL@bk..FmP
Zp5#)@rieJqu#)\BgS"/I5U2>/.["7k7K?64&tk%HL"%p4ZU)``3p,KJX/#q>O==LH=@)FDm
Qn1l#i(V:"SuqCk/#N6S)AlgCh*Li_4-Nci<BI@l:#de&tD.8"\f5?-XI'g@,d>*OM>25gPg
H`dbQRQt:6.7]AePY"0),#,:9ph/OesElJ'RkpmaBI)!-j&4AcUWI]A/iKQIJj2b6K+_!%rK+<
`FIZucW&h;+iIFH)USQI+N\chDkf!SF"@ffA6,cP7qc+FfPTO2`&F5Ad,;h(-"%52h3I-:5r
6BG7a%:$G,P9&eQ"@1KFl_qt"F.C(p/&qCAbI_)J1'>3<:`/sDBq4Ca[Qdg!),/ocMe>OhrV
SSj9q>tua5`</Ec4P5`?N>6qkc;16:A;1YePfrnn[S3cG*MRmWO4;3$@b45<')c_>u_(O/hP
a/;A?YUTro1\#:V]A<m\^c.c#3qb[^1\0Ndks0'#_bJTg#H5'B:^Kr.di&/]A=#p#+Rn)8[tVP
_qt4Dk+aXODtD@5SP9c/e`'A)#K6;/5P+,"oYWXE.PoFRmRC'kl"FjnkpHAH\0[:@S/Cn:P@
dS>dZJ(J"//*$PL*J<gV_eqf>C6q=Z0'`)iW*"hOW"#<Qq.9nqd9Y.']A0[gO&L-O=;UWE;S5
U9>K"#i803^>G4C&]Aejc\V*#psl%7P\le5;MGLUn1I#pUV;E)L#Z,S\,6^BmEf=ebD$d1^+r
RZZ:p_nb<6l86E&N\,[gXZ3108G`NEgF4-&GEJ'.Quqk8P.%T(Jj40`F(u;O1PIPRh+iA[5D
+M%4C*mq7SZ#2;*j"6_@SDG#RW@gfZ71<pCG<_2ur%Ii-f?dd<mb`\je^q2J8SBMl(re1L)Z
2_Co1*\?gm=Wbs7bI-:l'XA%m+:+N%=aC__-XgHX57KPt3=Fi;ib]AD(.'-8\F$?.CXnG8%dY
T+oM+'02<1I6>43SOQ:&h]A%"C^`2ho[qR-8ah7n;EC0\Jn]A"UDTF$9/J9?:3]AdE@;/.,\!s0
*&4T[iVtV\[!Z3tQD?%cW+85Hc)?#\I_c<%P+MA_9L0<[9(1cYaIufC5_$kL_/:]Ae%adUE-I
@f5+MqP@KG]Amu37.3eqTR$kLh>j0-'>+C5mkY!ETuV,^Z"94V%S=)?PLid?rTWXV.q!NLXE2
D10o-rB>(5P'!maKf^VCAg*tu@PcuosVVs!KF2Ec<u[rdWUn-9.51Y36qhpf+`aP.UA:>@2g
Baksogb7Wfm(lPdgpYIfhN<R9Q^gZh[#Ee;28W.fE7sK`0OKpo7cO(EgH6N5>Q.#;6-E[;2n
.#ofMb#'@TlZHqg2J;kY9tQ1\ql))-3mkes;\TKN!e/^&&Umd#40Yq/B_=r3!+EH\kOI:U0Z
$TY4$$7m[M[la-9iE%@&N>`oJ`)kXcf3c9"JOT)^)\0O.<ITPA]A;0h_T2$qmnG3P0/M5;FD-
sFuhr]AZJ,X$2A_k^pI&S`0D3<gl(Q=^95h-a&4UH,]AVj7b#E^ZZ.8?%rP,2^Xob1-Z2j]A/il
Uk^9Y$*G-<kfPSq]AcW7Sh/H1j;;m0uQhfKaj`6p-M8i5Fr*T"5R'f&&q&Rab-@jefU0Adddu
Ij*c)G\N^3$u$,rSNn"o:/p8EoYL9c3-dDus#f]A;j@/,.AKVtY9iJ+!$pZgO>k"4f(mls"7%
_G>jRUr.7d24eiI,YRpQn?Y)='K:6/B"4^.3iQ^Q;tqOtX/kL[:B#>6;NlM2#>;[6;HSY2hB
G#=rDHL;3:UC8&X28cAR0h5=JV%W,rWs32Au5n-.fLe\WfqQ&Z1T1mKgh[R70CT$c%m2&MHJ
+PO$KV8uf]AY[K[gYWdWDVP?(ToC+ZC<e]AI^YHm$XU?eQ-oh$/KHojKOd`_jlP1SUCn*3`WUm
>D$kV#4S[N`^k^Y^Y;`@:n`no_nXgQo<j_m^o"=8gu<ZG/(a*J'*<^)7/pZt%^+jbCpbPnLL
A1$>9C2HQd:Z"Rh"I&b*e"@#c4akKk:YVUm<tocl%kk3N/U1t'[t7^2dM48@eG5*%$h</*[H
qj'LaG%\)CqL5@c*TNnD-Q$Xcj)sZ4'gSbB`./*X2J/Fbi&a:.&i9QXD)(3OR$'%'?OL_jBb
hM1Pj<1H<dj4TV(GYL=)-^dqQJ$D.2k:`9;'cmbYYn3uWaQtQbPgWd>&U0To.K@MrQ0\"r))
BW.o+$ZXPYE[16g2o7Jm_]A.//[8&!I</uXKPQgP;7&X<NIC-SN:dJ&/;kAT*e^81mq%?CK*n
/\p,q-r3J*=.7M^]AidY`9gluB`\gZepfJj'.'lhASkNs`=iH"jr_"<G+7]AA3lOlccR.G[5;9
^J#3P+rF^Y%5No='la5RB&P*E]A=2Pa]Ah-p-N,[aI4.H[DjJO\':=g8F&eh_9Vc8pR9$aRTp5
@8P1OVdm]AV^scUNjlG=39L&Tng;*1+7ZWN_4DnMh!qBS%[[^"K]A_u,79V[@dKZ;Anh^(kJ-L
8S1$O]ARjljdAL\a&JkjQlQaBnAOE'6!Xf$<#+ER2t-ZPmOeh(.8=CYKrQ%(3tpFc:!onn72W
C-g8'HpGKgKM&J1h]AJ-2g4daq=M3WjGuRiCLE5T!n9<_)_aH6hW1^_*!IQIPEWE/8_?<Dn^#
mD/s8,XPjLgf`'4>UN8mldb5+H/i`NsD]Ael-Pl`iBks'GE.p!mdN4pkN@bQ>?Aen=TQbdcop
:RY,?;\:^Z;:,9tkc-0gkF-W+L)`ZPJeL.5I`Ktbio)Ya0'kjOiQjld\1:\9n'@l%qC&aLd&
*b1_Iej_UPrC/X-6[H9#?hGjaYO[aP2$lGaTY'%Hk8K-S&WJoVoD.T9,#A\*n]A:Eq#K:>LS[
(LJ>X^\ueHblpm5*jN;UD6i[X0'$dM&=>e$_Hcnb8[/+N:Nn:VhS&O/=T3RbdGsPTfCRZ67q
W5WjCN=%,kqo$=!OL6"BjD/-XbO@.]AbTb>q;md,0<3]Ai!:.\X_^uBJWp/9D!\7Npo!PXn?ss
>bEpmc",1HCqLZE\-`14$B/X(f-4,OLAo4(:kNeCh0%16.j4MDUr*DPN^_GF'-d\LPNR_<qC
[Wa89)N.bKp3ArDWFB,g!"dGu;a!VMH8g,BV)UXrb:+&lTtoI<1q#R?'r3O*$$.PP>Yrp20)
.il'X06%f]A>RTJ297sBSTGbqVsZFVKjHEl"cd@lALH#>t?1!4G22n<'2dJ]AR]A<^FUPr.7-(R
<\-7R-M-aTkq(7Vn(R(I^eG;/)4J-0-<5==?Q.SZ46Z`Je5-Q?P55`)U2Nl>3SZRf=Sn9Q`$
qT&X:2@*R%Kh%m*?P="=C'.^PDiIPOGhgq[-TK7k%(pXC]Ag1[>aXO]A<R'AaTPJVq3.)mgG="
Lnb_#6\l,2h`g7KMJ;MX_^br^iCP]A^7U9S4;!K7^$q50?=2#:OY-GheKI&N7sqXVd862H&7>
[P<GbE1E#!fi(^V3ml%ZV[6<Ei2;B1[K\\ZPGUJ]AOkGX9n9/LBZSao.s7^mB;/k$[p1PM\H6
*%/ATJCmXH8]AC*eG5.mFpCunQ*=jn>L8-)O$B6["(:XrO@2@GFT1,=PW1C+8G/U@Urb3F6=I
[i_SDlX;]AOT%ttmbb5`Ig25b`LKI'EI<u57+:0(PoU!lo"Cl)[>MLDZNb/0hp:1"lsA<%!Q*
SC,$cKZ@"_c7B)VX4/RhiDPI&\%e`Y^r20,%KL5TOFO^,JB.Bh(.$XJb+Cc-k%d-f)$MoPHB
pj\d-TIn&Hn>U0k%>=gf:>RN`e7D`N7)#fmX2[/YJ4-?1Bk_s>=GWF\9FFfkoV\:/e$=jV?J
HMiDM?CtsdKKhc$b4BGC1I(D)78AFmB'7-OlnVL/gEi.lW"#NV9n`3dWgip&g.JXG?K]Ap1l-
@^o9WS>VM%#P<rtY?Ek_>&*G%hm-e'I#]An=0I]A*I\'!&#IZaAAg<h&W3$M.&/:I!V.%BH6;_
L;[f8sX$h/ng"1:YeNeFs^s&\(\fYFp]A$5*Gi8rZn`engIZ$Oae30g8m&cL2*W%qAgNL7cY$
*WgX90rum2YMW[:?'H+lHa'9'/YI(q0Y!2EC3A<7*coh7@[Z@e:GGQaYgc>^EUPgT:$D"K\1
\@UMkn(Qc),t_Ho>,ZVRFCIJd[efGP*1RK.s"1nYDmBJ&cJpdX@n:t\e7T'eN.`cTI?S@<cn
;ru(I(XK4EGX-G^@2^V&Ipa@VKJ1a0r`*q*'ZXha>\:pSRbGcjNM/OuQ+&m7N'Cq)@A7LMht
S.#=a>8b'ip`h!ZO",DS"#i5Yj=*RKZ*mINprTe_LgICA,4Q)lNHBG4DpN'BVZ\5NIh#R2aT
FVFho88b2E2=XmZ"O8\@5rr'M<%s:5lN_e<G:"g4HlT-rO`XKH1d>+1%TnLrTeOr3Ac:'2[L
XDHj7nrl5=l06\n7T'/=.kaKh*-//80C+@Xt/49AVU\8)"*KS(SCQY47&VqZmBORH4^#Rj2p
&Bs,fJ#6nZ9]A(d)'J7us6)Z@)(i\%%UJ97EOliQIYKoa\9#aSgYkiHU.[V.LDM\X[hd_nk1L
;Z"[O<dKCc7,P5$24b@X?KCXYppeft+cC6ab*kik`a%.rNE.>Y1*Ho:U)n=#@?/(s4J&Q16+
r#?W[Yb):nFJ>+\_s\?jiAMdE&!bl$:?k#m)RFV;2&J882TfKL_drXbD:_J/,nP9mQ&K"sse
FrhhEZUQ+j0h5WCX7R^;.22oE:S*h"i=bV]A9V/-M`E$J$.9A46\'`2YJ:9GcN(2Cs>VrN':M
#5E[=T#+D\%9`BCZ5fp_HN&S`!4!$Gqg9_P$2_nKnmE\D*:>R`7L"<7/Q$\0Im2+h+&DbNG4
k4<>g%diJ9,Pc<ZBV/)3<4c?5!T6Y2^4Z2[N@A30$fdlbrKEAQk:Hr]A26<Rhjko*[lLD`d!n
D!c?Iao1b$)jg%3q"rWlosOT%iM_uVkN%K^VjC9`ilFk5hQD,D-I1o+*K8E1`?JI+ROo#Ypf
i[@Cg<T>q;>BX#F8+$M&#1s<jUJ5O`3f*K%aK-(r5DlQQtdX[&=?l\!qR*chUI>J`3hB=4X+
Q-a(tPfH&-KmQprP:[*1hgC:Kq;%/?4]APM=HmSAYWQq(<N@n!63&7$gno&R]AG\3VbcA!1f.H
q-+VTQ:9^_.*9`6*lGu[<(A/S#"AnpVDa4'f<ISnoXY,Ql,cp.+ld@/58UBgC<WZm2FPBH@B
>-1,rju>A:[$_igLd:)KI6b)5SmdaI[r3-gtmq)_X8:k$#hC%*5nWu?AT_kMl8b3DbEgiiR9
-)KZj%,YQB(c#(@H6_@$L.DTZ2'a:fMSrfrLDi2+7^P1]ApjDJBI?F$URN51%Si*r0bBj"Chu
M2dY`Qd>:*^cWq^BB1m7R;Ibg6d!bQ7(W=RK[CV>2Go#Q!BGo9q,@=#(IBE!tuY9Yt-^qDDF
*l_nfm\1c@JG@,8,d*(,D40V>9:uY23r0Q^^X]ADM*p*M>nW%!X0>WsR.HblNhXe+Zs7X`$lV
g/6H-`VSF]ATF6b'cZHLcrT0PJo9&;79X5Hk+R^D).Krh4QUVU@PQuhg;P[8N*_[U$;G4gqKn
O\PF9YCqjq#iTKG(HdA9Gj3d.g"TPXb4,$b`:EJk&kY==A)Ake]AgpT"`Dg#_@Qr(kG33RuVE
"4"V??G>`t,<Q41'a(@G+0DqT)0HbXBBW7ih5j=d[@R9kDg)*Lrp[H2iNR?FC<ea^K#g8'k5
bd@Fnk9c3ZP"[ZMD[+%AnRn8G8)?]AUNu&<@R*kQNI%W[q>'`de:Gbh`UDWpj(!]AJKC5ZVf]AY
&4aXd]AoW4Kq=bY5kotR!1O.%0jSjj0C$t-;/\tn6INh4it,j1GJ64H/jS@`%oar7jD4XjJ^\
.gUX"",cN22&D?Rd?VK6RCDcU)KT.F^=g:%j\D9JiDjF0'mV0qn^sD.qJWYh!N-6kK9.#qrM
#J/LTPUbIqO#kh'^W5SA0U0=f?js71I=oqQ2b04!%s+rHF?:9@6_R0Hn[nE6Sskn5&*c_g/U
8cJJt8dSoAFH09g,lc"TW07BB/!X.pH]A5_+d,@RLW/pIGgs"n/DFVnN=u*9E_(i(r'"J&AS=
5We;XMsF@@?aH;=PT-bNQD*XpJ2,"n)#^1j6?78`+Ae1#>q%o4LK6)I#VDLc2Z/T,K0F96KK
D(c#BQB-9;F86,\LmhO`/0qlt#:GTdN&IL&uk?e!*g).LrY^icq]A#-affjBD1ffTM=#kB5P8
PW\_rPi$HqfS>Sc,AZXlG;U;68%+0r1(c.g<di7Y2urX9^.,tG6Tb4hP-I;5&8uE#pj1SV1"
)#:pX:D?h5=(F9T9]A7S3QRNNp%=hI2"SXDL84%6oF$<6S,tb63FnG%XF:0TZh$hf;VAn6Zaa
#_(,pg=XO8Iuq^>;BiY`Rl*hRZmUIBs6Y=(R_h3H<"u0#hcT=$,$\(qMP/"bDSJ972Zc80bB
8M1d(I`A.-VNl[s$4Ab)Pu6KrpH<hVQ4s1V_:Tlka>0)H)QRdJ06U;Nso!s-/Jf?,Xe[b=4Z
'<B8(mZs538-tpmm5:L.R(C'HD+i2Vb841-'JWUDl"R`r?$FHC4+cF>,/,t6=F<dA1NaIe.`
cYZL4+4r_nS2*sribb':.@sABEBMuNV\Q6pN/brX=`8c%I^ALDnT]AG$*.VIm_\>\<&"n/V*n
kL,PKNjX@)CX^g04Z*0AprS.f'#I#[tKlVK6OX.,Wh:H@WY?*\'eEM\Mm3@+Vnb^o0mo?n]AH
Pl5M_W+fD.26Zq=^s?jmN,NnSe:[R*S'B%ZGb"()/f:lZ#'kO`2p5YOS06PBE%gfNgYa2DO!
lk/*Vl^IA74BRC6#",Mp(juhM31^I$Mf,F^jU-G]A/:oH^k`qU<B$9h\OO"pTg8C@R#;Wi!K=
H@:;n/4[$Wuqa!]ANP2&jcT8%^5%nPj;!s3'$gE3TlcA(!)mH$uiQ^@fV3AO[:_;ei9h^b;jN
CfVlBR2qj]Ac`j&iL;htpY>noAr-_D2G[tXs6.fFhQaSh&VGY-+O&Ij=P'=G.FfTg*A<)@MbB
lR,>\WAh'SXb>/%p)hLkMIIrsX>VosZf[N:=LRYkW%W*S1NX`6tEJ,LgR,0$:K@Ue5c&.M5/
[_M0WI!B]AV%<M40[(T1"SUcW?4QZKU?:j=NY$=e8Z_:*P3COdg9f*-7#PLm+i-!]Ak<hnn7L)
0(24OD*9ADp::$N>^0BB:MKad8K]Aq$2qW\f2`fi=X5!]A[G:ZQ*-HW7[72<U%<LXr9g'[j.sK
-;e+P5p]A`>-!1?B$g_m)OrAq^DkN*(#"T*OC4jE@t^;R*\nTp4@%!p4o*SgGR`Z:KG7ad2J!
h'F7.;@B*A)NY^)BhIZ5`Z:r.HtItNnMX/1WEO+RO$*rXNCK]AN=%K.\9sLCHAeEQnn7ihC&^
<ea+oSpDiZYZ-ffT6h9SUdfW0[TiI-`oKrCIP@iA*n&164Z;l;:Q/TsZq+Tb`NUhgL@JZ;P_
b8%Vjg$?!IBD'D$c5nCB@5/"Qbf*N'cR/pR3p+PS-?pk_\O:jabh7!hP`/p4"=>SJgbZ+8a&
(p7,;?u/UP.sKYF)6b:5@<F(i[)g#=+Y+%0c5%3F;Lq-Y"l@;+uUf79pTi\<_WO_8"W1?C/E
B6Q:YE<i3BKhaKR0H)EoKZid.NV17:p&VooSImqrG-Wm%gO1CHmLI;?A[VIs'L53n4A\!<VJ
n5FnaD*L!7jg?F\+5k'#<%TI#[^]A_MFY+%Qt[TK_l\%Z?B9QWVeW]A`.a66jj=E@gn_ZL3EJ5
tFP9DR44@AB>>9_+<C]A+L=I/=".c]A'P-THqc2&ti6!7dqA^)kl#+`X_HoS91D5L$<(o8.P0T
[u94a=/'Il0KS;;]AoUqtKSE_bY5F!`D5XuZQY)a"7!_?9/(6/!gM'tFeU_9uK33HG*6K#;L=
^b`]Ac7Xi/&o]A1D9om<J1P$^LQ(E!S*Fo\$AYT;+R%2Q;Ss6Hj4jp(Ipc8'4m%_thPIk-?,d8
A+=crkeHW2(P^<hN(,<,"]AqcerR^C)aVNU)*39k2[_DoWc+kCsf!K9%J\U2dYZ;hukLKWQIc
BT_`H=K>X639jXG(tPnj'*4^?>M0.R-DYI0_5j\%*K5?TO5/b#$igk<dd]AZg2?EYDkYX-g_Q
B+l33[$+G<A`kC<b/]A34KKa/)r[i%,VUa_o35pF^>r#KML&4bKq^%"9O@"$Yk:M/Clr@l">W
86WRlm#/BtHglF8ll@-UCZn[7#UV*]ARjn(&p[/HIOQd=oS;\9ejAStQc3A9Em1J<]A?t2F)YF
7BY8DaGI+<P\7clS;ene>9./ik0j?VNtG5oL+O9e&2<#=!N&R:9%&m.C"8_Y4,#E[hqKi=\'
@4]A?>>UA>^\*-7Q"*)/&MQ_ANuHoYgXjX))<PbL6".n(D@,TKV6+K&WnkOWu'A#uT;G#!\4>
>@C;iisijK>;9FNRu,UpLK$A!rJW&41HN!aklL7Dm*&U^j_mhr3!%UJ%R'7@^F9:Yl+;khNf
.VD4KE:rG2".QY:`iVP_>uZMX]A(;b)bJ(SaO=K2m`V-J'AsWsr^9*o4RX9V\t7"RjT@h]A%PJ
>M<\sRU7I>T.'kZ&;[t=S]AbLRnI(fa!=In3V).ku-[X!Qb(k(=YJ!#4:<`%5a!F!\c^n>q::
^#/J<j-fAf/2i7[;hcO8Z&t2u?%'F3rkcL27/T@aSq*^=G0>E@$K2NE"9,<F=/`'B/Aq3tAh
j<\D(jgYP&!s&&f:jeMlb&qp-Sdc'TeR%RN4om8\ol&"akXadcW'rlG-3(%(^7P_p$kfI#Y:
\u`F#M5H^Os#dJ@rsWbX1(\@VQk4>=kSh`e4fAuX5>67,A:Rqe_?(hVNmnU0gaX9'd5FDLmL
W2e.fsge`qG=[n^p6mCEYs@i4!jfC8EUhBJ.@3%/f,W<Yn<WnP2./"<gLSkY1I&PR;^A+Dfh
]A^ML7X:=!s!*lKVVp#$Rk>paUn-@)Qr.6aY?>eVlOho6._!\R=j"b:7.j.G0JID^6N-/8#Qh
2Z$ldTp8D9U&B$_A2<qHGFjCnt`Oj_pjF5A$([\8"#!i`BJuplug7m@3KXs5*1-m%Os)R!j1
SKpq2TB&p8kn!9]A1F#WtFlg;;Y'C6E]ADXWkV\I.S3_YZZ8?,hQ$9)r2'7$k&@!=.&X+/1[q2
p1!H6T2rO%Can7UYD*Jp>,/?/o8g-elM*P`E:BsBN8+Q8VC,Bds(#MKI1T0Y?g,L=CnLbk$L
bB!)Ei#<$A,40B0#]A6glYD3p28_g4&[g.2S,h<J/l1ruR61#6'Eu/p[;;N1>mVF$7m60=3I"
Y8PBX!bhVPl-i$`]A#Wd&XEkf)Vs"j0(8E'ue?De<$(:Z^T2[$lH21C"Ogf-]A[\GUrACu?+l6
'bf/:C4>lh'su1<aOBL"Tp&3(j/-Z:"M)?C1PHDg`PQ*A#r(*TF)0,iR2%cu5Q-5c?l)a<.0
#/8mP45Fooel?J8j$hL;.3-e%Ub1'V`\6cdgRZ&u2&=:!OY,ocl,P[Y!'Z&CE$7!2t=`,\4Z
*3!>cQCg&*N`a"[df=1pUIohAa!0Vj%(&O8VU!c6jm"njL4TPH3,UF/`XHq$`tb7JL]A1f3/2
on-=(2$DlR#ng4oe=I]AC\SoH!fTe]ARIm>Z69)@868VPq=r'<g'g'hp,3q\O#iLQi5uhHJnW1
f+DQe?@7k:>=m-:VX&fe%PI(AECa]Ad`78)<K@*8L6-]AfnheK3Xj/8*&.ZhLO:=O$bo?UD?R9
bOP3H%#$8]A^KeHSFNQV8n'`:;cErV3\//3O4aEQ1p4>4ER,VXf.XP^5>D%#5r$h>H@kqgLk)
H/M6Z/PN'CJlilHD.eE=ADR@1mYB+`9m0Rt6G2iXArbh86(RDJ!%IO7inUZU)Ui,$Oe[i,2k
3W`sGIq'anT6B!Z7+(!i-pQ_j)WP*&Bduoqn^Y-/LIO@hV"fKGrP;j\&ACreX%RWN7Tm\HT(
1c$YMfGjEs\$%r8[&s2^BR?Iu(sS5Co0Su/tVh&I^Z5]Alj[Ed!:mG:LPF)i0$sQFTa%O707f
*>34ZUP,h<X-`NMck5a_OW3fbRQ7i;<J/k:ldU$,NR+6SM<oBC#\%ibNgh(Ym!ams8Qq/+Ur
>@gKmM8`jng:jN'%f7.`Vr4#E]Ag`T.&,Wep]A2EV;LXS\$,#6kcpe2]Afj8TCG3Ljb%?hTGn+U
c,&^m/&NlAb\Els.ej@J+5ji'`lMH:-.;$V)`Ch"0ge<T6#@.Ra`a84RG1iaG;iqW[RC^'R,
bZU<dod5K$tAOeL8Q+AIQ,g<f.gqr:)-%t]Atd6b4@[G_H((I\)2mJ61!l$9amc.i]A[-Jj3rN
geJqmE;eku4FUK(qblSM<mlrUu$#mi!.YOdKrST`>n67&s$/]AI9_ae7UYB'(1&S3r_ldA(0t
ouq`C'L+niBhBGi^=L;f%6U?:m0;!qOD_B/dr4g+e5DUQM`="0CT2Xck8_a%j+j"1iOJ9D"1
Mai+A-*?Ug)LAj+.r+%9W/rk_F2^%2duqP=p(j%83>]A2K&&U?.e6CD=^U+Mp=Z5Lt%/06Q<K
E\'Q!Mp8+;Al'"_k]AG7jO%>O&N:PKo4&0e?.)V@Z,q;^MY(jMmLAWe"dCBdZkGRWl_bsiLuf
%k;Or(:0u=QU8ki3m2(,E<I2gKo\)e:d0Qm@2tl\V/nEntL>!dNXA(R3gOGHis-+]A4IO'p1?
Ya,TYI'@nt$ijLO`UB^bE9a0YhJ<2a+"hokS"Cpo'L=XrQ>Y(J*4'NJrY0V+IL*Kc!pM3%9F
&M'=')oqn+14bhGhIcpaM/lYZ$hL0S&NR1(6@!6uo.Y-X%-[:\bj"G#lP\PLKodUY5382I_r
iD.'HjAlcPQbR7]A"TqY.s@?Hn)uh@(TE/Ml[)In(a%Tgti+qJ+pq\i,N/<1u4YOiJh/BB:-5
\obBd97&W'*2COBfa(rWhlD2/m_9RWgX,/Db@+-]A+Q@94:l,.VD(EEb)`bP;96N0b5S6s0ih
Qj'A+d@0Hm+i!\3IaWQ,b0KeqrhUBq/?l9j,M\;&Df2*j9t$_"#>1c0r)B^1#e^.Xl15?L8Y
aX?K<ppd9)@@D:JW]A)?"pO`tp"d"=#4!gl.:NY>X+A[Xtbn$m5a<@\E:7'!pbR!4<OcAhDSU
BKc%`W]ASX\G.a3eO/cr4Loo?rbeKcW1/`N-O222;NP*pj0Kti*T=rq69q%.W;S5q0_'"l4bF
5]A\"^/%04aUOCJ8'H`pAi=o8]A<!f?crEDn/hmg745\*DH<9Q^`GAlJ7Pd[QO18_C?eA*dY>5
K9`11O?H5+GE\9l8X!3X7$="e0a'Y<3Y5_VN5ncZ4?0E$Cs)RP`PZ3^Xou0d]Ak,uPun86hcE
R]A4k@h]AqJC1-/Y'@&g6Hb-A=7Km-Wh/_E(4uZ),+UJUriL^(O5^*qegCP&Lq7[Rdq%[T.47t
R7293r0Cs6S@,"@sAKf@/CO)uVh"o^&u:uo-TmKbIkp/WKbQ?:-k*aK)Vj2cFt-6DEXSsd5/
<4("&7l1DQo+(?[8MKkXnr*>Q=D+c3hQ2E[f^:<\ZCXPEs!?r4".DQa@LuR[o)-d2<kMNtL.
O3_X8J-;\t(O`^,p>%NmZQQ^bUb_48Y**D)Wf.2]AGU>6e-^9D-@@3o!;V5%roqSA+<k'J38F
-#l"_a3W7\q=$6-Sjnd_,T"'"9^O9aZ^,QX>b[<8F"`lOK]AO`r]AlOcsM\@D_8L<:mtfa!ck-
4@ZD=-n-31>dG_8D<kb#>+M@<6nn\f]A-Y:f$6M>[6S@G<9'kM0TaQjR@fP,)O!e6:2/bUo;3
L[SP/g.rD%35H+R-O,)6r(pp<DX!$kkA-6*tjRHl%_)cI<e^"$l>B<Ik_50ME*+QnSlhm-?#
/[<WYh>c[4E#m+Q,>JQi#`:$<BtKa/?m&dZ*(r'S5?=&Ce0nb'l"CX%p<Ku+f:6.e4Ok3JiZ
R1;CO%EY]Ah0b3SEKD==.F<YJ&JIpNU$mr:3dHJ3^Q&0mo9;6#%%Z%.uu/A`Q(&d5k7HGWg+A
dk4?,?N*VnAOZDr>ADSVJ^3;NR/Xg+]A8A:-(Wgk@X]A&L2$-Pajp@0$s.me:8H213+B=+nXW4
=<6aL#,h2-i&4LZ+=21RK4aT&dEZ4^blB\p+>38k([V(>"iXjie<>uPbL[-B7oYDhGBeP[Z5
0Oah7$9D@bn$qBm<[DM-..Gu5db+cpjZU">e3b_G06"ed!TlQG2s4t-b)X\dLK#tZS]AF&6C%
St3C4(A\XBOb?7qC_L@DAhZ[&+pYZr6bFA)7Si&Zper'H[0k58SptSWWNV9JrlVE+(K&Qb>o
a^[WdlGEZLDtF:T:i#N,JMCD?tpI8j,J+*eUP.atcq"./8q(VfXdTb^k3k:FT;-*1;f<de^7
qk^koF#F7jaLfLa'>t0(Ub=G!oJ:kk`99ZYY&gp=oNqin?Ki>!\7-]A?09$Nn6;rPsL9YlRD"
54I,V#2T8S#]Abm%YhF_g2I'e6Qu'4'G1H^&I.67e$elk@o]A$EJ"1pd8)REapL?W(@h"_(2Q-
8)r"X/RQGFnO1<g+_B\i8"@)frYmu7N8Y1#sQQ(Zr8g/["rnLH2><R,X(P$aTBh7.h`;"X[#
_U+8D;m&#J0I]AsUpFtCdhW/^q_67$]A,D']Am^'9;#Z_R3L)P,5\ika?N<8>ZeCfMT:neTKDT>
k,0=B&"Dmo;-7=0,GH`6G3TJ1Ojko6H_a>E[IM60Z,q'>7VrChkSE?"tADRpn:P*I<\/g70>
jUC`]AO91<sLTC=]A-";[3c&$Z"j&U6NaDP[)j&.6_r:OY-dPFaaCe;p:Ff7,;k^#[&g=%-ref
iuA7pm(Fb`c<i0k?q+@Xf83!>e93"P:!i7l9jQ,6WqE\Wh2,0=I[l+jf(b07g_T,Ut=fmeNX
]A'#Z.jp>A=Fc\;a4=@Jn:38PaihbZ+8g*-1hm:*G,c]Ai\@^T-oG87%rODm*@Pqk?hES=HBcN
GA?7t^pGTY#<)Nsf8gfZUTfrQ;E+]A)]AY;nW<%ggJNNqs]A=-jcno9$]A$k3XF)lKOusn;?Zj\*
ea(k*%VM+-N:Ld=4R?c(,PY))P=sYsK[aE;XQWic&h_J$j$Xnm^kb[Q*6gq`5r!5^nQ^K=B3
k[W8Xreh`08YO.mVqnqMH43UWq=^TU=T!pCtbhg*u>!g2BZa@'J_^*2!hnq>KDn;Ni[ThE_A
E?jL+Oj1!anR,!3R,$([NE9NBI,\_)U1);_&2>*PJqkG$#o5$X?'ER$\M\DR%YJ(bi2.j0sO
(#<iuj2m_>7%AuW!P'5Pht3e)UFVC[_Hpc^Op+N5u`I4Bf)]Al>hdHPXW*P"2fp-pE6Hr,E:c
j1mHfWnfES*F/UTrt'SJ.fRA3q&)!&TqJ7Z]ANJ]AeJ?ubkDp<V_hl$n4B1\Rl=g.(R[l,TmU)
oR=E@6)P"clljZ*%[<GPJPM8?\,nlYKDL6'4@J7"'[BNe1$!Csc[BRNfMMLL:7In$b)\0BAM
0p=Kae)C^c's+I1:N2bLndpS`-7FRa^P0F3YP_590mbEVjs&?-;GU>_n?H=[H.i>#(F`9f>J
"Oacb<NS*4Q`;N^6lu+1(%O[St[k`Asg3[9#&U.B,_8hjb-Q*E.VgT@\RM>%^`q3P@-'NNgo
"9\D&YrZ\$`paM2;qU3U4NrF@2F0MM".NssP9E1UhY4e.>A7a6D*[[G&K2q%#ne//JRPI(9*
\5/XoP(C3ZAEFmn)Er%UitgY&d/W'Fg<f^n_oH7/2bCKT`i/qj=mg(WQ^sO#_ZtIqY>MU44Y
D;0fYB*(I-LJfBBI&?E*@&U)FRmuSYE6$rQ)`=!\7*1?Q"#N7\)"h.a#Oe.^ZdmBlQL[dcbV
3(;-Tqp:^MW$u:CC_u;Ybla,AX,sGj6*.lTr)uCrpBC%k_Z\W.`Tu7s)NY20,"A9.+/"Q7,'
.2#<c8(s5qc?WkrhP(($%03o-_DXK3.j-&$`_fGl.O8?gE%_mQ&+?a7CRYRV$%H[Me<_e+]AM
,^hLENRe*/FV,7srT)j]Ar=WS4"5[Rd,Whj$;[10d0YbPqJC"tO2JG9D01jjK6mA_Jp_a\Wia
Rk/'P'Zh3^,<8Z8`lB5.Q^;tBTMk+QD_uWLp8.r[@s5sl[@2sD?7(^P6QEuC$=X;1NZCTI5R
f-oor0jV1Tf'+C_pl3WbYmX>8c-_;V%XU,?X,[>?&BdQuY8hXJSi)LPZ2drLMLj-uqJW0J;[
'q`ahq_PCJ]A?s=aI1AA!qC:\LA<]AV2LG9J!-pMYM@lP4*l7c,]AbSo4&H^64\QBTh0:.2tnoo
Qh+:lQt:gU/V"RK:nTdj9uU5`,hanVD14O3Lcmk?5)J=`#X"sn]AMq\k<l1c^Sqf_doO@JHH`
$b]A0tmTUc=#ER%q&Lh\o!D(^i`R)sl+3Z*HjcQ&L`-6^2T**fgTYF?P*i0,H66IM+;ZmZ>X2
A'#J##sYINA'RU[0)cF<:mV56Ng`U#O;BJ\'mTRM\Utm)=q67qQn3fr/->sX+&@&-mFuB1i[
BF5'dT@-Sc5SHQW"/(Irbi'O6ZDkG>C7)72(NT(@Xk.%e]AYpNa&[radQ*%BRb<E:H4W`DU9Z
<j*?,C^[Jb<g$_c/p4o]AfEmi0mkJLP:PA.<[Pl<Vt<(6U#?:A20]AD4fH+_WGdleuI8`'7p/6
;p*f=V7+p%IH+CD5E3UW"2\r@-*f[%M-bY\W"VW9:L+`=taU1dl=$"C2>'6`Z$pB4_W[2YnH
NlOZ/-!!^b5IdEE&BbWiC>R8KE^@`\f\6G[_MFM_:abV?I+<pmHlEf0uS=_<pJEqS_LXD\pA
p\_`e8+O\*Gm%sZ<fc_c"#M>^#%NHJ/]A.FDH9_A?:,f"NQ=Ie`/@,Cp8B"#kS(/X8.Whal+S
?N7s6h-*3lmh/Aqne]A6K3\rb^jY>,fJ"^"#gl#[fflYOJg:JfcHnVB7&!U*G$d!7Q%N*.r0L
81kf;tW,l9sUHXV*A'",)r.LeMU9l3?L/gej;&%Y48ROBZ%eXM0BU^W`9"cK^Zb#VhHbVE`I
m.)KW3r8m.@G$sOtm]Al*f5J`)Us0neb6d1J_A"(fVh5nVtoG9dGHEB9!B3goVG+n))CH_We9
(88Nj&^,_^+5ne(0I.5Fs8iV(t67KJCc+kZe8nceCcp?7=9U]Ai(gnt96(p6LSL8kP85_:<au
H_(%?>iOE@X$Tee`bV-:P-!o"G4MoE#4;[P/cG+jBE?]At'Wf3[;\s>p0E8h2B&JNEdiLpND@
C.WT^m\N3\B(9)dF<[]A/5r\&2@g50.l<ZJYTT%*m/*tA$/[>gku?!-AELV<Anm@DldMARAVS
3n\5$`ohq`*_Oqd8b.N9]A'j]A,KQ-Y`\fGBMnDDdjtjF)&*=mkdD7$D&Po-+jt9e(GV-,eILc
O@m+7sVl]A)3]AG1egPqM-)5n]AD[#RjMaV2%,@2'XeLOJ<<0!AI<jJ-`"e0)R9fU/?[r3OH%6,
[7bGe&2PAmYUArM[rTNlf2_3NKd%pU%`&K]A(*6r:Y$#-R(l"47K7J<+tX43N@B*hfk2S%#di
P2q'+.@m/EmM=:;p8%@]A&H.j;]AI86p0u'D$G)E*i:M&WafWCu)isp#O@!3S`r.CXM&XT^Dh?
/DX@-`E)UHBL=L[EWaIdcE?[1%\!5p[<ZLOUPbZQnqBK3h-ThVKX[fh*jJ"i;8+n:W7k244;
P.`@[_6;$Er>b\9u/A9,KV^QB+%i9`aNj\_^r-a`rT?^6qG(?#hiLU8Xf>:;hj!J`@Mp'kf/
cjF-03#X\n8$"9^5lEgA-2H<=[AgS4ll";Vas\]AXK6Cl,nc8e<k3q&,Bu]Ae&mFP<)Z*?]A]AHh
&2[)8DV[Y7Y5T;7F1C@UXr#7i)Q-HA`p;`Km@*N8?2rn>.phcis(^44/q5`u$]AMhq;u@o@o*
!&rC"7R]AL@@P8pgCAli_Palg]AcI*/qDYutU2ek]A+;q=?,0(>3plQhZ:#7%T7B\?JY`,EIE74
"MMft=%@%:lOlf?<"r&!Y[$/K+*VF#S.V4<K&LoC=Dki"/C)cR[rcp?JA,<4\1q.G<?DDIfp
?>iT?q#5"5?ANC)?IrI4,L.aX'M+iUq[Mt-C"?';pp=f=V*@6*@ZP9[WUVpJX*]APNI/tFt[c
;9'Y9Nj\>c[^0'L^U$0b@%,gj@2<9R(&bG]A]A@Lphp6`sBrkH>&rUo$>H[p"co[unqFjeIRPc
_,PZNI&"Mnc7I;tG',@SGgQ]A/hf*j&M8lqIpJNPYPD92IB'd4_mf6UH^tEdQOHjfVS9Lu*je
[dXgPJ>Ho-m6kF<782uOC>8/8#]A3[jH[&6boMHVq)PjX/k+^Y_o"j$k+.Thafe#6U\q%i?S2
S<(:!eUM=F35mk^&JPX^lK_Ze#XY-XSeU-'9HM4JmD[X?gi!\Lc]A_Ci/s`[ejrQf1"r]A.&mY
s.GC%(7U/u`)OslPC/jS)Zq(Q_TRLl+1=Rk--Io\[UkI)>dX#ttlot7k@$0W'53$Tjh_\Q(D
<RM1!F+r3l;)WG#'#!.$UcH/G(3gFbf,R%mG,6Z'E0;C%$Gc+D4/(^5iI]Ae+HS<b<5XoApLV
\+0(AK`=eF3bDc"Q:`_6"bi,\*p91"YqmC[DEA20OM%NGg0#tYEQ^RMspbnbH7*5o#KS:[0g
AcO\9V_Ib'+bA$_3XaIJO+3bX65U$&SIub9><FfsC?"##:9jUZqXR=>Bb?t.q;u`Emj8b$21
UX]A!WGEd6h@r*kp.RXL&qj(aY&*j6Ct/1b#@#,K3[<9h)ZG]AKBQmN9beL.h-@>Q.BRMqUW0;
=9Er@IK:+ZfU4CAtRZI<)[GW",/&uE\&46>T;8$:TJtk%f`7IX/NW_qRhm(gEW?AM7ErQ2:?
o*,4'9e;"q/ArhTf93TEK16iF:B-T,1iA=E`pI,K,ldm1@a6H]A#>Z5b$OcnbY9MV4,_:0$)I
c?kt"KK^5prUMHKL3!9=lF$2h^llf=,>WNpu2K#H+hTWuE'AoEMr*gO4j=pqtk%$clu.[W#r
<V9sf-i?F/5gsH^Pa*e$#.&?MQpt#G65K++Ith7+_"aZiLsm_jUdf&3n@b#D?/c7n)R\Ku<m
Z'.Ie+K$;E-7Kl^Me"_Z2%D%8Q8>(;ae2JT=7p7&C![QCLZ.B7bPdPa'3FO2Xg\=ij'8lq+,
$FNL&AeC&S=TK%T1nO'<1*S'F0VeK(UP7NhmHndS(]Ai#E4L?#_SUT/9P;3Jb6CImdU*or;d^
uM"p2JmDl<"Yu(;C+AT>qS"8PDLnD%E7)p$A*a#Gs`1m\DX`E]ANTh@,"p34<qS7fb)=CK.:>
(S^o4UAJkBV_1lO?#SJf#MY>k[REh<fjX&ESX?>dt,W.gVXP3O_1<@A(afM.Q&;s#-f<cgJ`
lamCdIuhMO"9GeBJ"-:)_g]A&Z4bW!I3t>:4'SaLXd\=P.#gV>(^YM,$SKkkIb90;N(l(,he7
[CR1W,De]AakCI2V%$9;Z?Dgl[ojDVPH`k/n0.K+UQOc,R8T\?';7`3r\D16\+ME_c"u]A!!Ab
lW]A8,=Nq!&UO6r/mlZ26gm:%&so*5)=B&^%mb35%MGIZR*POKS-o%L1>TZ:XLmRa%l<MetMY
A*ed5_2E$h&Vs;HN(\2,lHThDg).Ijc9ogWdIBE"r?(Yo*8JcfC*U)pN92AmidU4=obUpnf]A
r9(Y(QOK6"]AN^YEZGi^'(6*Ktc[&F^<g6d2Z#a(<j.hW_C-f1k?eJP)@^'/2\iab&kj+5(c!
6ja]ATSbA.qUAk%mE6e^EM3C&mU"b!dC3'j"@8Vc.N)l'bE80)Sd8IL+?%m44`m8#++!BO(4m
[0io;a,bB-JYtpiT/66*(Y1@X=Qj3.a`1;,=(J-gFs5An8.BHK/o]AX4f%?2d-l+l-8auS*[g
l\#6Eu3W;s"!Pq#qW-:e:Otj6P';<p*ftQ4&/:0ZX(X5Tj8aRq5T\ho\C!gCm]A#B;M<n;Z*@
$Ldn`Yj3a+NQ[Hn=IX_J*,:-1Vh-7/:9&5^5U6I,2n\7M/<DH)VBN9V=g;6LUC<F<u3/aJ'T
%V>KuQBTgps6J+AWk-##@XG;NGq*PP8jS,@fV#OnNr0(L-7ns*>a:qtss@0Y%I3[n%l-H_pa
X9$PQBiI[MbpJ?3BGuBjA0.USEaoVr(D6Pi&N>2LO_MZM8N?5.c``[cfN2d'#nOg=:DEphN*
D+q>uIA*?b3gq+!WiU$@Bp[m]A';:0_IQJ")Yh)*OE\olr9sf;psaoqs6)''D$MY(Al0`/dkA
rA5.f1.N_^Ehi"6>1?KT;ju2UdfF,KB^#S,pV)6<4b!GlQkQuAfprdp.$L5UO[B`.odZh:XY
U_quDSZ00d-Uf:10Njn9dNCWB5PhbV>?C/h-UJglO!60K\H9-\5N2Ph=We>U?4[g&:ZPa_\^
61Gl2XU?i/aZp-Ep*5=NV,q/1+m&l-:-Dt<CWDuL:E7Tr9*$aYF'n[D*M[iT=1a/P6/#V,,k
p`CL#_M$;A8UQck`Km:8HlP,ip,K]AP'gn1gTchb8m?U,H(]A7DTVcld=k%UQh>fo60S?o/Ne^
85;6gN86`tRthFRUmr#FPq&A5EV]AU3F!=i<\>`5m4H<"V`fKO;pQs5X#81_dPMBUQ2gbXS$>
%8i(&^VGo!o)YR%-Y=$a68>X'0S)r78C'RDe6qI9^=7LlFU4K[UOKRR2>%0M(f+)^$!7T6^m
;/!P/F5-cheQOK-t:O^"11D2oZ9Y`hF[:#FHI>AEr+p#4hfFCloG%?$f?2.#=PoWMSoNHF.c
d\NaU!LJctIY_5K1/,!MrFB35gY59$3t?e*LD@)-WU>eKWqX\=h_k/Tb@7P1X'e-MXfTG7Rj
Gsclec5ha#qFV5aFT/qCVOX31H6oJfK:AIEAM,lQmG!kHe8D;rKS0K'jGXa3853Bjgq@.!0p
_dVA-6/V*7^JD!QWD;H?Kc<;M8<U8@0j/K1YfmccoX,c]A9`]AQSTaC#s$'2]AWuF:1jb0uZ=NB
gl-5UEadck]Agp:@Sg*W>N3iDu\90r"js33!a2U347SbV#9AfdZ.n[ngc.6!F*K76GEs%2Dg:
2#l/aOg(P<.mWM5"*gE=r!"&r+Lp$'&%_G.MKfU!LVE(U7_p+h\20l!]Aoc3`SM.]AY%E&K$Ds
TlIt-)#/N<0K8N`pn"V\j<5%6b9P/]A[mGRAj<SpB1RnJR\,%]AlUU(\R5D8p.RIpH5PfeTcT]A
e31U]A2W"WW-VttI26Xq7!jB]A)@ajak2ud`/^2dVZ1C-dP+bKDD(\9bjpH%FST5XBMo_TlbpA
]A4L^d90uJTH>,7OqAsiZU`knYNsO^/=p2Ml#=B''2KIYC&JOs#OTlS-\E*jjcP1oh93q,_Se
$:ff.MIco&VfJ541Q,W)t.JSLW:d&3niJV!Dp=K,<YtjTda206H4H4):qN,ZD4co1T3&.h:<
)SXNAmF+bSq8TA1ajU%4q\ZWhI:uHafp;r!:;^J&)=NK0#l<bp4t1Y#$d.u>Cap%_.7u.j;1
%tIO$h:'J.P3Tmf`9P)uf=O*Z8)ILf_3U,5QemWIKZCl-SiRp&G6*Va+Cn;8Q_Kb&gP\#E:r
gJiSEc+^;4i0_RZp1!K&,H;_;*``bfq7Xb[pPGIR%=-I;j*bV$G1lEs29:0J?ZK1dZ4bE3pC
jDf9l\`ql*/=:Cj4f.)meQ8^K^1Cft4h#htdG"?V+b+J"sK!`AaO5U,+XB-,RK=o5+DH?#*<
SKcIXL1]A$*S?2"4ZOBrI9ItJc=Gm-ZeCb'.#h81$rnEaAdCFF^KD3-65/Hoo]AUfQ\P)-ljq2
:\W-e<aDHdn&$W;6>2e`,auB#]AE.,l&5G*pX77LJiGIn&lU"ATT\CV10&O"M[h"+(k[#uM@_
iaM))=R7H?*]AYB'SL+W%L^RY''J,Qrlc3"b=U9n@H`F;a4`bKLcLZT#GP20\T*eh^^CPU5a4
oslGjr,,)_Q"+Z#c[cfpZc2l<>4s=l1B9YDV6(l3'$)VCU3%iGWhYL;;&EWZoIBXkk/0cj5f
t)r:YTtfcRH7,3(PtIb:tKY>(("jGFu);O-7f:n;3q0\SSZV%4tkGND&5dD:YjK42?DGXaB,
dB7g%&.D%DCOF8cX]A(+S)%"_uC9OsAf'QAl(=^Z0uU>ib_h4m15ol+,Ul?h'0/&p6._fl^cn
U:p#4Q^.G.+RM%De(t=Cr(L(c-SfLH*T2^1sj2W:\PmF<p!V,Pc.#.,RjpC8kCAY+\N&LM/"
bdYL[9RpAb.Q3*\]Akp$'/rB@Q=!KNIRt_7L>F?FSm\:/lcl-%<DN@=U)FGEr9D7_RD)RPNZX
31TRKQL>Oj=mAI-?c6#b^eDA*FfGuh!t%#4(TT]A=I"DCs\k.sNJK"b?Wt*j'X,ot))gQI]A7r
]A0cK[?b0%/!>2HP8L&\/i#h3Kr\L>)#)C]AXQYm/=U(n`V%b>.\GoZY[$C]A=gB6Uo&p8S_245
Qej;WjZ\I=lbV&nEo<eYDBRoNP$\#X=0e?rN8c0B)'3&8NmLH6]A`D@mGG(s)^:o@%uj7)gb1
B;I3@Jf\Lk=6:o2G(&XA&?j#Dke1%Zo8Q.KO"B.Y]Ai]Afooe"7Uf*:U`SRLFEN=s3HUYmbaV1
M9PL_,>8'$\@lfCPco^C^+C?'T:<\,G;>V9pNAB0JS9MH%F_m4!,en%nRh@O[:iaSS=W'g#c
Wq)43\LmjhVsZ_s<VocM7^BE$Y-^[CXe-s4o9dUiXbF!FF5O);/JFG`akSjMZaH^O+fo/qe`
%7B_Q^k?I(n\iRK*7sR^K5`kYr)(LG$Q'"c4Q8\>]AQnFF'I683nZ2IHjpIH2A@>YlGo<_i!j
uhbN%nKe9[Z2aSh(Zh1!Zh]A\&>]Ap.guXGch'I(a+;m;uA$ab(`agu@W?HGZ=GK%^a40a?&Ze
2V1+\GO)f8t:M/Hn.D2i,N@\o)bb-Olk;P,r2>[6:7(Y6Nr8n<@ch*\c-RJ)%ca*/]AX+T\[6
?,L!lX\=8f9\CQ*'4?Hg5iZS6M*:TF-+s7?]AXlttJBJ`'\&TnkIH2(4`TDuqJ.7)<d[4gKVo
jK]AuW\MORs'tsrD\uuri>$.Y#2aa$jn/[M'IKj<9A7NmKGI^ig-XK`WinTWXY]AI;CF5*DrK9
X7j:YFc/e>'V+Vi=:=:7D/&,>UOBY\[aPFU:#`'ZDr7P%$ohlG+T%B5_6K`M(9lZ7InQB2$#
\J>Pg#F40k'_r_r1>G)[MV2u5k8=F$1h`VtVIk5X!_2,=#RCJ>W^nJo2#aogmYNT"nqK4-j?
kAKr1)"(7]APj/IYX]A&3@6qp!gLV;Hm6]AQE1Z-b11]AP%tmJICC"<@)E<dV2Rg^OVYp&IN(['2
o`^.IOW-[Zk0G6p2!'YQu>!p*'6.N#`@Ul'^?i9Bj<O"3.kEi9<cD%NGKqQ#NeP]Afh>Fm(PA
lkPJ"qT/FLUV;j7Oa6A"eK7HB32N>mp@]A7jNT!$!g/HN-3QQ`GaN\H2+<09a&*AdLJRnmES0
!BRgdFNqqd@3NR(aFfq#Pu2a[j9o_rGthKCEBNs5-&[^u[b?T@ZA?hZTfI$n3*cP?5mD9q/!
!l+sQnk!Mn&<TQ]A`2srpB<88a,i7%QpQBm.s[OP:c#-CS`oJKG-b?SkG=G0Z0UNnYC68]A'9*
j?TOi2#[i*;qGih4At:.l#S!1iTe%!@6,OFuK<0Xi5lk'H'<S.9hiM'(sdYmuEiFRF.0ESA9
?W`2'QPTA))q@\T)^07tY69`j!oJD.#:d@n5gm#mr!pV4J7e'I0lChl=#$&D=ZKf3<pY$[?Z
C$4;Clr<ra$[ftA<VZ@.Io#c&;L9g[I[If%HGt$+OptoiG.YiQdjQeU]Ank=CZ>[+r&#P3:M2
\tWa!Q1^H7lQG7L/FD@9+^G7X-'mUl&ER%TQ]AaQ,7q!-^j1.P&TXJQ0A7/Wilbc@p?O)5p/^
["Et'+i9h4_j7qODg_gA9+BWRg5m%E7SABd^(^>1)>_3LSrc`G/rU0V+Gi5EFHLKQfX(k_<F
[d7^Rb&4uNB,JY-B+3q@e$OB@r3VAIP(GmfpE5T@t^nr/_g%8=Mi_8cLl.i3\9tR4IYfmjq^
mD1Hm;3c$rC+lVUib1t#gknp#<s2aRO#&HQd9O7\A.J-<oCKRrUugc:t5;jE4mp=a^/qHbca
&(Bu`7$3ONr!d[b&YShF$Lr!D('n#A?jko",nOKt%[D2+*4g!O/gZE-=7/2sB6"/N<4h<eiN
Zd"goNqP4XX>'UCc2=opC$'=e_mY;4tfKaG9b[Kn`g^,<j4"Fk`O/AJfSN_?>.&_`&hqJnMn
[aguQE63,,*YV).fRS-T]A*oZ6Zhjp,Po)\Vk=Hd4FdC1,7mN@VA?5l0%q4L@'#WV,\YJuR+0
2ulh@IrR44(_[9Lf\K1UdP5a3j8M@]A8NoE!'bg0N,t=b*GJ[4XiM:m]A.(Tas4oh?'10\6!CO
/5^`e=)-0p]A@6!T88r%C8YRF,;]Ag'MCs---r^@kVlP0eE.lE]AGQ0Nb5H7T$0R@m3#o5&toPK
5RCY]ABpUPQ1BFX[$?-Tk;H$f:17-f\D$t6WOjqg6bW16Rj7EkMVL'ct50&)t[Dj6!fKudf5o
$m*SRrigm&Z0_.W8'\Mnq]A/g=BYrXt;pUSR(8%%*W#:$umtf/'lU##r9KH)JuXlhK-F*.3o0
d&1.f+[b"C'"m5%O#L5knI!UN(0'*S=G#S)r>0/gcj]A7L.<j,=_(WcOLMq8_`G$0rW^H=0l"
f7iMfT$lRcPmT.LdO?uC;<2$c`]AlEIiKl3(nO]AZ`USm#bZXCd['&hD*@s<M&9&l>K?uKPJc0
Xm9'CQ;hl"XajC7qg6CK1%"W)=9]A%K%=5VbFXC</?dKLO0In5!pO8DjZc-</S5PF&mN'eF]AL
Y+!6tc9>t+IEY:rE\[a-0joIu3^HA",.3=tOnsQ'GM?g(b?oB!&qrkJ`_9aef:'2TN#VQhJO
r#neXksciE.i7P^SJOOK&<82UA!++O('<EA>NHD,)VFRNgS.\%UPa!ESm7n!1?/Ge=-kJ_c;
I"k3::13^ulY=QB.R9:NXILAd?ME)-:TigtT`b9p>NS1nFnR3TW+r9%HbqN<RVKZ7:K5`K_^
d#k'Af<s*%kdbO9CKRHXOsSgYqM##<gktHAotKj+QjjUJU6am1?H!eYfar"eP\#LR.:m\.:l
AEUV8ho9M%l>OWF`n;kPTl[Hl=X0u2&&-:H=!.m,`D`gWn+Zm%o`(7cT+*2k.SqA`JU.5,Z+
YPaF+MiC.QI6Z^7Tb>o[9Ec+,AkUcLrnNY/a):`u4RK/=>r7C_:)TYQ!$`]A%^O\i/6WYOZHk
DRp.OCppqhOX$:sb_q[BGjJDX;h3!b</Zg9G3/.Aji4E5"12(*(j5WX`VOmdSTaG/^0LFQ(A
5f;m@8%a8YUlg0sY$sZsCn4<qMGZDJF&nu`ebaONcg<QnJHO2Lg=)`*(nR]A/V4K.'YhXk03F
NW)&Z[/2ijXo%R?l[AkHresq=95=#/6rM!p`pGL(P4nk2.*Q=[a/8t\XH!;`^O@PD*gr>[A'
fu)Y3HCBpc3K/JW7S@aIUU;+i9!h`NDYeFW3a=+:eGQb%pf?Dj$Y#S3jWB&Z[A:Nold<gCqB
BWd7mO:\/b^t0q'.oRdtZX0efUE\$5(ZLg0jVlH5T%=.S&'7@S1POI"ogbELq6Ut2PR=]A4r*
K.RE[-kQ\BmS#Y<HPZs21\&*fFtCN6]AX5[eoDB<?gJhD3R7W\*,I+YZkVbOt),uYt\XVHk0-
U')G\oH/Uilj2C4)!n*$r6kP&sq8fcP*3F/IF@nK`pJMc-@4NQTq^l.!1Ze_?kDn%jIA^C4?
>VP`ka.Vc\CTs,3,_02Wl%]As\b!,Oc$fIG<h)R/^sT]AA*kCQ^qN3(NM'>\\Ko3/-CGR:5M&h
\4VfN:fQ`eH!lB*d/gKod(bQ&O'qouE1nIb#@@_>;aA,l(?J<c)MSnC[N!JN-3o\/h4+rtnY
`G:L*7LS"=4JaLLHrZg4XdS4?2ME?sk>+u$m(SGgr!AK?1*R+bY`AR.FgdDC()^/\2ZSU_<M
,EWSc(6lNW(&oK-!VWfW+AI($Vq[H?HQi[ML$&#blT),K).hK^99HcYX0N<RYSK5D<GpnO>"
DK^9&;f5O9,`YC[_4\#[6I59$!r5UORL"+7hZCiLfn"tWX-e5$SO'+Kn$?jBZ.%*Tg]ARiMN+
;4ZG2m6p@#V#>UpFbEoY%'uuI/Q[;a-YIlVDa.=XG.qj0nYbPdQd$S%ul,i]A*BP>044ljL6c
RL'N3JN-D\O"m'@H@jVFsP1]AWf*;=?^LY$1q6lrRp&Sl.;ceh/;N7@X]A!47c*D;W\b[IQQdE
!B\/uTjqG65(;[@*Xs)0HiPQ?hPFTajc'LD8.'-qoJi0lHC5t4L/u'V3Ku9+o=YWrH3(N/5K
@D1mh(M9*&3!e)oHl)NYOEls1;(^S<HL2*:D,`GKka9CaW#mQta@tq<']A;ArAnaX?6-;+B8o
7rAu:m,`bMf)nS/'([H\'fb'<XXk.7UTECG,!B\b.m_`hZ=n7i73?:G\S&(RV5%A,*qE36\*
0q@E7rTOQimu<K5VF2i<(oT:Y=:hH4Rq54I+;/e.I+eJhLZf=bb\o;G-J<%"9=%b-Bo8b0k@
p.e>@npF%4:g\+2OD*0TL?=mBE@iYO[.3:ffbq/Z"#?b3k9F)pG\cErjf-[W<cJTpL6AR;V1
-XWAs@$6JndF`+fL@,1lKhaehF2)KBWMTh$\1H@0lIoWs%`r5qEtlh_1aq'h4qG0fij870l^
<=cofgP7m@c7/?jFk0W8Yl>@0UB)`fZ<dSF2W%6LPfU$e-,o3(Fo[7AGikJN`LBDs0RWS"Ie
&a>=#ZE'`odi=pTaG>j@IE^eS`]A!?I.`Kb0K-9qJ5'(5A4776OF!n^'$g";5b9uBcrcf=/K"
a#'2kJ6Tm2k:aH;Z,sE)a?uSTPq;76*CV6(=J0.Z^5fUNu/'uO'6(SUqQ6%"grKI'1AAFfk'
/Q`-i.FB2=W"Es8RY3ZUXK?Z<sPnf1@aogKGLD56Ffqo:2S3FFR<-MuH.bLf2S8Ubi>U0"8%
TYi[8EG$s>-Ld)-jVI"qF:?pmc-"-jOGArXAYcai%ZSDo_8'SD#,ecBX4f0N_\RMR=(6YDi1
oae_87KjYFENmahI>,G9bRY9]AOtoR.o<K]A!!Z%6cGDiO7@t<J/Rgb</g)+D#Rb"pn!I>g0)O
igKOGZM21GS<85.dp">]AW!KmMLTMYV)q"jm8kh`_4FO0C4U$17UarIO-+,[d!'8=2F.(A[%,
O,ZCW8$b#o7A_"^RCOK90q4j&e+g<!4_3X;Ji!f0]AF8e<RkC:ZBn\iqY#j#=H%g!,*Dn<!3=
27j***ah]A@4'p<9KrT(2$m2!cgMm98X.(902Ofb()&,TAga8Q:3OW>[lc0bN.BnOS;\VYkSk
\H;j=;A]ASF.]Ag.jSr]A^LKI;C!CW#+I'c]A=3Q.L*#.IB,W?Ic-d8+cQ>6720UHH$ii*XG83pC
%MCFV!IC7#;KY;p#W6i?nW`M*]ADfZeEjc-`4@2$ENf(7^YEBI]A1IHn^LYAQRE&D8a9,YZD,q
*7HQ(\'0Dg4Cl8.F>=;qXi1ZiVlWta,-+\BWee*'JW:(#;#.Yp4"K5*uE7X2j-!G;LJ%M9!:
q/t7US*2F4H>U)f@(7[#_VR$>DXD7c7c9K^)<Gu%g3b-",:0mLTDKZ7BO[TritHI6r\Tr!Ys
Bl'e[D?!g3n)BSO_/g[#WHI#5Z7N&Bq:3O=.ES#A7DWd(;m&'\G;rurumN[pCi+s/mQ(^Y9'
`i9&`9c/^lf`lN_b"]A'C8\-_Yp+?hq,RQh#aPL-Pg&>&"9he"[_!cPL6u5&`M'Xsr_AJiZ$E
U9n9&?jRl<B`SRei8X2B?m^gPshA+4.Fj+qZ)8<ir%/'U^K\4,i>iDo&BT;ie,9>%hSGll;D
OXFJ^(I@;J0kehl<joE16caMrDTpp-tFlP312=#On/KQG"?,$h*Ws-.Oac@"+*55QOR@"N/F
58s,"f%O+iM1&O0HFIYB*_/o'j)P(_'HSi;!)+YG5eh-*Mlt@kC1@bZfnbU!KnGEiQM@rOZK
)h"=HgN#f?poUOlK2<r2XR.gR.$:IboGL*Y]A!PqKdZbaW?rP<_m:K]A;cMOX0oZ_EOSNT3qP;
G<iV2(6rg#(lGq`oki-U]Au;(#.DP%]A0"gV&K>OGfge!L[99IKi_)7d=FZ*(-%?l$>_aq&->T
3'pH*s2,,5n"EWIIoX0_M96fTWlBrSX3V+a4sD(;*J0o;Cfk?/ptL"WqEQ\NnH:&HJhlA&E0
Uknm9p>R#rC!%u@u7D!&*gV`+PH!3e)!DL@4Aa%BhU/a9LnE`jUY[@7cj#6HN'uWB/Y'()B2
*RFk;2PE-1G<8+m)EHX%e?qfCMk@i&=f?lWkRitr6hQ1+NNYt*`o7dR/YlU7V!*5+(&+``*2
fV=A%3M#u!j><*<MPf$SEGb4O.Ug]As4'kg:M@2n&!o_qW4iOH,Qbe!7:0KFe9Ioa*sPj=tHI
K"5=;j-c4cGd:S"%eDI`28Cm*/EKU.f[C0a!smNmoAP;>k(CMU+_St)NV?;2\,tck%>*iJW*
bJ]AGg,*Pj`@ih,:n'98q`W+PakZfedFeilJ2S8%V29/md=/r6Mn[J%D,0R<d,:'Z=sDS"C(R
se#S*(/;:QU.EL.(JLL.#`*+7-KaiD=Il`f4',pgKC>>(/ZCeU%<+)8`N#G\MnqrYc`iNuQh
"iq5jCS8I>4&$kJugbL@QRj6TGM_E,u0Zb,tuYk6bMH:r7X[CFWMC4`V&<5QlW4nI.`8E*a%
TgL=KeQ!14bIK7cM<U[gDA1Mmb+]A9XQu'ZCK2OE(X!88678fH&4#BH"N$N<Am,@J4jbIn"n)
CnS?KNpl.'*M9f;&h25le^9C$/cFi^0j;E[rq:5ZSS#<a:h!ho!,P3SS4'U-n[B>J2.RYu(0
8[BCD$`B(I>EbX'e"NB0PDiY.<l=LX##4I9o>i45ANr!BjlX]A+HQ*g2<$IO*#:slnEFRPc_1
qG*<@;4t3b.VAt*I;uF;(i'M;XQ#G<1T4g\2oq%dBs4g?ZeWOVM]A>QF0G2qTmFGs\S*U-tX'
'gSp-=Q7]A]AfF1*%(-T,S1F$##'iZ<I6E6(`+29VFEO.8K?m\k?^FnEEcp"iE+sci/Zm;jn&b
@+;+2,I04U-NkGKGD>5OTFM/0?A__gHs4h]AQI0c,1!=-PF/9>hY-96d_>Qh'D>$&pCD[s[0$
L?ABtKE-7$"Jp5O[q`B\SSg83fc3O#,C#H0lgK#OJnBdm[;+"@%CueWFUAg*s5&(,c_Zm2<"
BtR`["hK;*C"e(&'D+5->B`k$N/:8:-m8p=$/d2dUi"bAmb+JXk,r2/CltUn=OI_:H!:[?j)
'3b1^0R,@``j4DqNC*$DF6apIq`YA0O82tjS7H1[!;WX1oc&]AcQqt[8kG_YcDRccU;#T\MKd
$><td*077@h.T^@%NHoW=idj@Md**nQ9WDYXM;SFhVus@jGD/KcZ=9Xof!ro=Mb'G,'3.`Y2
K/%_W*f=DNi.=g29;KqYe;T%4jTIW,WVK^D7:?CAJfZNe>T@/%A3;Ok`C;5H"+/">%k`cXCj
,mH2S6G^*TqK9A5NS&=2i\Q=?AQ`_lQg5XM0?bIE<,a\I3s^_4#*)&PdJc+ZLtjuWP-gFA7+
]A.ED286?V9ACgA`06R%p5I@`.8nUL$YW)h'#r<lgk[9F8-=Qb;Y&["QLKY]A:l@gJ&_FNhWDC
NrEOPs*)k+W*.F"%kF$aL!`G5&JgDO)(+DBA.XJ-V#EHXOeU8tJFt.AH6g]ATBi+#Qi1$o1!b
%-M1WgEtMrS!$Ap6Z)@*t5sDNeTHri2@[;Xe\KLCUlI[fUkl#G[Ab34+@QE7e'7B-h95J7/e
@1.0b1oBB4gp5U6^@S#*sC(3"@cp8EB6NUlt9S$=PNoe0a4!+Z\:;tG_`8Hst>;;0P\FPHoI
]ALK3dos?AJqg@&$jf`KJ32gOS$bbBS%HgOF3;G,7Lo<5#S-do-6jV-a=?BKS^2cIm$%]Ae`8'
=&;.!rtAeLLG!.0\nY07YQqeF]A*N"j/@qE6_L;?kU4dl14*ShJL9kG]Atqa7shcrIrj;0W>7@
jTY$#f:DWRW9ln-r6MTYL^9hQF-;'Og[q(uN?YViN8O)lObDQ=o.toQjm@K7pq2;YhY\KFD7
aM)#C=!/7G`_2qe^TLSl9]A&%T,<<U1F-aKk6fV\gAgdl/,(W<keZKLgC7T*=i7q/7e1IaQb(
*39&:]AlarL*"+[KM8=mKt:G;84WVA]A)/KOFF%Xc2+uNHK5W%pb^9jhUdp8IPM'OYZ5f1rBfk
5k">30)WiiW1Ko!PjonAj7M2dPd@peN>Hs-OZjT$+5f__a)29.k$Nr5Q%t==KF:9-Z!lQcrZ
o'o]AI/-Z+rNA_GB_?U>#+3%qMam_Q_/=)o0A+Jg?<">MhJQ86(V5;4HPS#>OHE-5`,*@C[k&
IkJ;g0^LakQK4>5uA9'j5gI3aP'-h'KfknMJY_Rs4aqWboG`)aG7\mZ/*ZFWXi!N\R]A2`dIW
$bgm29G)\>4<*Q]AuVl#g9_do+E<F!iT8!oNa%5iEeI9(`.^..c[,"DrcN,j"XYH$:Wqkuj4E
GU[_"]AlmgKr1FMrG`QAMOr?C3p44maF<X_VPTFXHpS^h0jmYdW*1MU1dtMXKpls1;!fbT!SY
FT@4OM!?DB%6dQs2kYC&p.p9gKhi>HAqI68b8*cDF%&F+<;4BB>W5nidJV]A)D'5sj2$I9VcY
8`[0]AF$@lXrdqrtUl<.R(%^(8;SGHHQZN@@Q$2pUNJk,ddH@lj8XiXI:S%,2f[;%2GK2'g-u
>,NqMY!>9a]A+&1I/PQnZi^Pj*h7o71A]AkJES+rs'qd1IT1.FHt9?d%\Kfng]A;bU4:Z[Ps91+
DT$rKu3$:ZEDqT*_oW,L*c"'9gg.&9u*WJ4HiD&^*atI,&mdLXoFAn2[Ekm#cm'6c$Ln*9qc
d'jrmN;h+KPL>!6-u0M>A,P(?QSj")h\Gd!s(+:9hZ?ln'>'Fj>c6JRQ`)ngm;ODNOA"a-:F
O;6sl.jiYOCZHraj*DsBQn-/HHm+_AO4sTZD5M7K,"?f_a7_A.,EN+D.Ug3_eB81Q0a#UV#*
Ak';sj^)_d*)-\#0PtZ!!22b0f^JMR0"8E=7`Hf`!A)dnAtVg-5&uYM6gb,cKHRAPLF_L;oC
?NTVY<,)<R*P_C,R$tF8Db;hM/[/ondFE`>DoQS(8k.Sq(iaWiN1;\o8V6I/4"_fgRrB^EXi
VdYcHuL8r!=QI;J^03@_W.p$3]AHbkFB@kkdA4dA*jgg13Rds>;*r7-a4$_`5<3M=q2Cng^,t
RSjN/Lkd'&eE`VX*HKg=qk\bQPc8u10<Z1<ugGEbtDP<HeE7[X`h9&*J1=4sJN6VNe*jg<ni
TE-BO?.i\X,R_Zjbd]AOU5Ol!q$cYioF&Bs)i/N2!@(`3KlSiEi9p=KpQ^boM>tYa@-hI3V_[
6#+ZT*u[H=1WsAs:tL*K9`=MskZFZo]AiDf-tt%6sk_RLYt15#JJj=jhYV$QI3d/USotTS&Dc
gXQLB9<DLFY?Y:,PlF/u#qR1s_r)Kg4eNYq:.f4&`8EQ_8C[W-bD4<M$"0'!Q.7]A\[-rh6?/
!)70L7#[r]Ak)2jD0b9;MIC$25:/GDI:!PX7c1ePHcLr3Q;U=V`]A,;dD*okC9O5J^T%dF*_i(
ZNn`pM6[6A#e?eC4rBBGAR_Ynb`@*Bcq/T3[02Nt:W89/9s6hObX8[bn=U/Db<R>;bkBud-k
Y\?r7Smd))T<+0NR&XgYpjiG)cLAU[U"6i&a[a?0jucB3"','sL@%1T37[0Ub+#`kBWg0Se?
*=fkRrW&\>SEUA3A%jQ$[>CH0Rp_GA_g6P]A.Hj;&Q)>YLD$Xf]A+P&`0'6fnqlCi]A`hrJF\Y;
X-W9`#\NZ6g$:p$gS>T.fpP1\=WUd2\*'+tZohq7@/FhbQ)$<WHpm6.QdZr3odgd)(+k2e5>
iO]A&g`8u*r#QLP9@t]A-arR29.4=6=TP_jJBgGH9>P%Rk<nR:u"0l?daECkBgT1Fr+:lV/dNq
X>%TTR.l.jlQ[?=^A"j<EcXtYet^@IT6[5JVt]AOEj;$G9k;Qi'2!`9mF2[tfMB#']ALYaq78k
\i7)4(^Diu7Gk]A=%ql5*CfP;`#o&]AHUh')q/I-XAJ$H04,L0@g,#,UGAke^HV>(cC.@h(?e^
n0>ZaM:>SCf6N8p,a&Wo,agAkM?oCS`5E5Kr=+B=l9Q&t[Tjo'D&Jq8Y,>;)UJYh)2S(4m#G
If#J]A1PUGmk_T?Gs)^jOj.nM>JacWS2pU]APm.pT`0C>,@^EZeU[_Ed`&1r_ei'V0%+Kd[/g,
`jKl80bIGVrgPMK[WYS\Z^em18i==P;$!f8sA.QF<[Sa$$_aG"[\)=WI8bu<OUC/Zug6F"*0
WG@6lYKiAd5P)Eq!D-*s2=&JUi8::lqC+1Mk$QNEQ]A4Q$0>'6u/u!ShA0mu6]AF,Gc1,2HV/3
52scu'/#WNTD5*RIShAj;+$urbj%[UdhU%'^b%/9%M<@JC`I@GT(SNF91\"$6c*$]A,K3Z/M=
eF\Lh,&rqMP-X`Aq\n+)/c]Ahb+1(Nqg"ncF2J"QU0c)h.uK8<`5(S9FY!iUg%k=K1$3R2G4p
rcQjd1ib,;0,N&\]A)j&0kD_2D?25\dn[_o#9Bcaa1K'L[JrX]A@7qo:RP;+,2<!k?\n=bF7;.
SS*0VKsV8oYg!:1.d9#ctm.'rAZROS))Lu9MH38,F*++5?Wr(Y@)>$jo6^.R-HZLd#0LY\E=
aEnN4q/G#Ksp!DO=F"4;[6^7U+-iM6t"5(+T>",%*\*N(+Y[@Gt2?g;r0*8_^cX'3)E7g?o)
pb6OI?8+FIi!I'&.]APC*jDunG[s,p\H^X^]A)1H$RG$R?3]A"QG+!6CQ$iBr>%D\n8ad!T.%bX
A]AZ;Co4f$l6#^4cmhf=Je]Ab3R>g,_D6P),,Ib3rA"G$/s)O?O_MMqWjG((l,eoXRM)F=.Gd6
XH'K^'6e&2%B:6c4<,;_SM2W(e0='0S)5G:p-1$A#p$(,Z=+GNuS6IpB>i]APd)!$%WMXBWeX
+U!NhqmB)&I=X!ks[[DV"6l61X"`>'=)Gb8*u3m`A"l6`9u@e)YXO]A[m7?]AX'UYjM293H6Dk
lo1V`djZ@g%Nq5L5m2):SdUH3SW8ceb"YL$2QZH3G',adK:g1E>pD9%,pj>Y>WNMZn8K*F[W
[W_s5"rjV]A[=?Y1Z_$`5;.VDBSR8[Bm+%FX)%TVegjNd<5[-M,S&[;;bZ,D6dt=1U/q+*M>4
bn62%p8+]A[6d(Rn4a,2Vro<-kI#ab)a\MNLX&&5g3X`D6(+<d1Ja^:%C]AQBIAZLZA+O[;4U6
qqT/P&inD)dCgMl)?2MYNQ(nJ]A50qi-'cN>fTtb$"2H=[aLYZQk=S^,Q9d>)eBlmjsXgP&+=
2MS$r:m7SI:gK>j\$(N;]ABc9hQeT)/>rp9j?Wtm>B/u]AJ[Z"FKfDXJ"X6LC064BZP>Ru:&Nd
uR^X8iUT9r*,#D0^ck]A&n"/,+<de5,T%dF:9n\(/&FmS'R6bO#ho2O:C;';VlT!JOT,!LQXH
da,KQ>8VJ^/[eW`I*_4=U,=m[E;;j)V0))4biZ^]AGTith7+9tD2oXJ9mjJu?iV'u!!UgcRnk
rH;M6#FKjFO?@d6PtBCZS!I?.sNs/.Q\`Y6_"?G#>*Th_ZbQbV4?>L8Np1'n,1oka1mY?l?s
8::MfS"28Od)\K`.QYd'rQk>DHH4@]AT;H)>hNo3aKhKqZejb<G2H#7?EE+Ot#@"(9cXPmKfj
YsLj)u^NqfHZGmK12"GnU)UE/dOIGGG.d4p!:<gEOMNdEtrcpG`4M<\Bh9qbB3&r9[BL'JGI
`0dn>-_=6#4P'0Mh()EkZ2e:#DBP-EC$cTAfH>T(2%<m#Ha9.)S"d\"KlKt`BE^KXOSDoJ=5
XADW5(L^94ETo<Z">bM[8toho)Mh7f9YCQ\0%7Fa479>]A]AI<!uH1u4mAA'Xl@.B)E@-91kh<
T.YNR>T)mQ?/<*e%K$4#H`N$V^4EVd7:L_83DK+fF8E>#oS)$(rC*57jdP5);L3Gn@`db4nT
XV2PBPduL"u%q!mQpcu/Q\gFe#S[l`E#:]A85Q45d_U:hS<^$J4$+UBWl8>So@A)=d3[rY>&S
2Xi6N<8H#`AI?28SHaU`Ii$<qJ^>r7F=SU,$ZhDN?3QM]AA+k^LB29(ES$.9([iE%\.YVZJ.[
bfARFuoN3/2NBl1f4lJ5fdDb7L+4DQqI?DB2@AEu1,^-VCQKAYKs?U*>:C&2"^%3S`cq;!6+
q07b7`5^#n<Q,$+S2lOfZ[FeWPq!o!"Cgjg0[)c'm1N%CO`etF1OVcK)ljf:YeI]AqI0Q\V`n
o$S6&6AO^ujsISD4<:VoZ,'V8*ucA,,X2NQ/;e4gFKn,-Qfg'NP;2PM=1of%g5PY8-Mh'::r
*82NT$%<omaJ#S:ViHXS\2U[eXo'_P>$Re4D(*Fj_,.I%@EaecpOdKf6Eh:e=7NBi"))LZ4d
3A?tn41+:[ml0.=N#4\cKSiX]AD0$O.S0)6&bI;a_=g65#'k:1&Ir:J%*<l)Vr\[]A?XsHu!ea
I4jIS%t0us%d#snK+q@YPoQhGDZEIC(=g2gU"O+iEb\5j"p8&VhKAL<mZ(`+@*`>KlL8N-Jr
naPkH^%e.QHVpo`noq@I!=V.Z/ek,%^]A)(j\f@0T(8kCM8jC$k/*WS6"Hm=X_hWQq/5+KUoG
F-+_PPo#MmROe*@]A.IiK'gln]An%!`tIijC_YD8rT5[[+&l]AA*>Wu7jAKl&:Hgs[-_8i;@I?T
la'1NAKm%uh^,:ND?QT9GLYs@_4PNHEZ>W\d8WI1(p4[Q8Dh9;#"b%oJ0c9=FIXrZDblV<Mg
fGcoo\1Nfj6B=TgUd>i&^iTYBHqE[?>)_0<k[p9\p/hAUcW-I3t$=^-`H^D=*mu[hsO\E\p9
]Af<hO:"++F_:M,%2T]AhS49mq'Uf&nB.ZCAJ`G%MjQ&OGbAB,U#MR>@j$?4R;DJZ$9-mAGL8X
7D_cj;0dkFnsktc7e,OD!?b2/%1u0K]AK4fgCA`+tiU4<D53&`-8=H4B?/3Uda3eE)k.[AVCn
L6hf+03+++dAGj%R2]A&Ui^e1$GNb\^+)0qqFcI6>U-Xh88!hf:'MnV[0j.m@Sb,3:or8a7Td
=R=o-o+Yo8/-HEGa:mY)c\$4B9Y@CnF%P7r;:Ublqps1G)bic]AiMq8aAQ-GA8e>XYlc7U`FG
;=j&@]A3J0LqOAF(1j*b"22(KDQjfB*Kg0D`-G&H\rQ5c%fI5o6DR!BeH'KTVm5%'Y7,Lc<bL
L&rFKD2BRe@(g\VI,r^k_WNh\n7[;S0sDlIUJN6RqPm^F_&PX#kier/79-SPFJ-#ld9CA,CV
?HWI!$HSN^s(Qq34;<S4nMBoLa/p%2#R#9Q'h5Ar`f328R5OT+s5!*u`6.#_"`UJ)=NB)G@G
9LU2H"JEE[=<4G#8\4A6^j(o@da\!TYDMf$>(<:cTX(Z[=]A51Et@KDXm!CP59\F6_OG<Y7dV
j,61;a`U"3gpU<bnGkk"9*a;-*EO\\m\sS:U\f35MqDVI+liG9GLL4O97s^,SZIo9eWHV2S'
Rba*N%I;4h!To(n2Xog9')o%iOeC(eYpH33h-?u3j(f#O2K+hC+gu&dA*K_'nukBIVYo(>;n
\eZ3dO^'Ca48]A-1'^L4O]A%9dQQ]A2n9b7o!VU*H_,OH5R:1I/bW[-7diNZ(k]AXnMH>BFAYcTA
"\d-Bs/7n9'0YIJ[_Ef$/"[?Jr8us%#'DM6\D4I?a@UANU2Mm7r6UZ"^1R-(XqIhIkYSe;=8
iZp]AW-[[#@S)SfTnZ5hfuEef[s%CG&.h@l<lk8)jL1*E*K0>Z/M0)aXs?Zlu8JZq?"6]Aj=e8
=1h-p:HA,ReJtQH32#F*-1NB8eXp)ase0GE_BGL<&-k]AWkHa;#!U_3NcpecEF;TqOI_]AcFG/
@>uL,th.!,^>1u(]A/We(;kDArA)Lam)YM+F@aa7fYr)MVDL%7,GK@^83Di(Ssq0FO;>N[1kZ
WN?SKprXE$t753gOU0"1c+mP?JNG-?A)D>A]Ae!,ZM8TFLCBgi/I%REtZ^[M-j0.7dUoU61#R
kLNj^BX"5oCs1"<?.+C?l:U7r?N[!_R0g=hTjrfG2E;>N+Z!$o3LHugUMQ5e*?NnS9HcA541
7mFMBn(;L>A;Jgp?E&pBE,X,,JRR[_mgs?Ih]AZ?e8p:OF*fnSjl2cPh;)Deqedu_:iLYOAg.
`SjMtgKBFMVkUsU!a8J`Ai;&Ga21I5:'4`QE0\*_L6iB2O;MHELK7k:]A-r+H=OeS.$=EHTP-
r/&/mO22/K&_:K3sltqCbQ4ZqnbN+il9HhlK?r^O)V>\?o1Q.PU'Y%6ak-_/M!FR4&N#QV]Al
GRX_o$>bW+!&lMr2l:_D:P&si(('Q#r[oXu':GMJa%MBrS6m9W8.#?9-SI+8!Y'H=%I3k0f>
d4XNrlRSibAWZIH*usB#D8@bTZuV0qj'rE3!uA`s6A0(Ng:>,L=QPHtL&`RJ6Nrg@#R`#8PU
I7&,'.UcZ7>,pkjpss8Ij^kgH\ZAhMf?Ld'3Ouqq\&jR;0]A]AP1;Kq@7al7/(t(/<Z479f#EV
2dgs^^?Q]A_abq<1+fDBZ(A2-tK:Su%!*r>*LW'uUB@Eet8g7H::$Pc2j`Q\XAgR5FES3;U)N
-CWefWc*MGRLFi%RF)5IcZc5,Uod;b$/F\%a/\q48/8TF]Ac?7(]A>aoNChOnI'ZEI*+s(\H^?
Co's#M;M:]AqV&pO$7bZQ;OQtWq6oh#6cSNWie<VWH`PHgX6[+fs8'fiQ2fU4H?AAG,'mqPD5
leF$8E@9.NYQCZjgqm<u44=!KA+4,4NuO044HB=K%\'TSlN?<2]Ak\*%]AKX:5(1+m.a(cQi(G
%7!lcMpI&T8l/<M0=.iT_k$?:&ZL4n&bekPa-/KQQ^fi9K7SG[%8s3^<)kg1S\<-\f\1YGY>
."C!=,kRg5Q'qs-hHdPfR+<S<a'JQAX;]AmT4n[KM%F>g:]A(\MPGofe:FE]At*4[V@%@GrkE?d
El!u</3E]Al+JlR4bj3kWM_3kO*!.@V50>C%e9tALE^Ln'ci:/iHW2OJTg3(P`LQEl:M^X;PU
btX&*EMlS6QK:U(d-h]AYFiE[ikEg[Ys:;H!r4WK*NFH,:d@?u_ehD75*A5,tm15*ZO(>NB/[
+`CL_Jr,JA^/(H59RIk)/)SP7IKs^GD7^3$#2UsLd0PNq*`Nk5?Fa-APe]Ah]Aqc)B3s)!gkC:
7`hjp3SSW3LH&75JR4`1S?$_PKZ1QaCSl4r/,<:n68s7FZn*Ph)C\J?)@]A0d+)Qb_/t>g);W
IT"6kCL!*(SO.M@(_RB%%;M>k[mig=e#YO$7J8Mi+kNF\Mn8R`$1*3p.J*)sVbT2/>W,+"A)
;DkGS-*Tka8+(9W7CLS$"Xe3iEsrE3)#0ALPPjbhphJE'ZL_Z.L"=ch3i/Kc(lWg7;C+A"#6
+$#&(biciKlMe:;DY_+ptlcV3l=+uE*50Om.L[;d%QncTB`-mmC]A2Hm4D"k'M:A\ro*53EPZ
E:+QCKPeLZ]Ao0<5m9nFQ.q#95g?[SFJ=Se5CLK@Q,lRjbGQXm@fGB:InoGURkRbBYKh"2k_'
Mg2T?l@ImA3"Os#M'U,G=qTfndq`b6kEqUIPn:6j&tK5=pV_dIX\:l@j=Q?;%dEm*oP^dj-X
q+(6+G.]A*akFg>0Jn"pS(0#dHZ8>jTNM%$dG/)9sODdbO&m`UDU6H?ne.rd%pd@o>'kZ+gdY
-BFHMkA(0T>tLeLM`TO>#0>J9<'>[hcdcVj]An\t7Z@sQ.H.oUbei?^R]ApS:R)7VIMFG\8GK>
P!>tN5l-f?B8H?W5]AB[$?V-a'BN-!dGXV"pbKM1<BuhqpVO:DM!T^9V3t$Ys7]A=+,md8]AM$a
A?B"bN(qVp:+g^XoHMr&"Re9G7_UK4JQ.fbDX>Z<P@W0rdGkWh@pWd,?+,Np'm\L!';nI7GO
2,OmWC(/Asap7Gc8;:pkh@/B:Z*)a!?+<p4Y/gY6/R>&7O_kCn0,L8XO[heS)p\O[+Oghs-V
qY0=J6X5KW\9C3J.U<V;6#qcfI[5(3s5^ke$cuq[]A4f1CA2IfuRiAao5UgaQg+@:"-gUs6PM
oWXn`+`^S"?'.FneZ4_QdmYUQMmD!]ATV1<6K/2\QM$*d%X3n^C)/.W%"NXh?bTe[8bce+]A3-
kSg-O#C4?oV)B27C`"%+FQ7jN8j7VpgRd;2[5:P@1e/)Z9eVkNSr6@jUb;!:S:`Pe8U2`g_?
Mh)=rc-4AMIYY,WQ;K&7%2(&uBrWnPJVWMu>oa$maO'$f7"[=fcmZ-#L#b!4o*n%gG%MBh,c
E0=h)J/6Z-Ab;J;Mh&h+Un\$R35*KY=K`DgN!-H;40$C5J3a9Gm)u*FBe4f$M0_jRY,#I'ca
paY"#d?HeXX;uPE>ZFRo*U*#,$1jY5*WihUd^J5Vr\,#U%?KJ='lR1tHk!))M9K1ch`aln"?
N'(dq[KqI]Akdg6bD)dt9lp1\_LCicLFpDo'En)7'>C_W$#</ErIng*7sY/Oa;AKa.Wp*0F=l
Fi7Q`7YAMV-@7msPI0fogS+?9%N<LNS;iC=tPUK2r(\Fkb3f?R^Vnf:Ld`I#stSK2bD0.0:4
G6/Y-'hd-!DhH9I,d=3FI^Fst!`,qd9*PT1+.G0`TX7o7r3%?3jZ14[1/Zi.LK0tV,HAPko8
*ul??tJbj!oJN8+ZhFImO`j+(pHJnmqH1[&OcgCIH:_g0e^?-@)fFiWNJ=`oUMTT0WiAs$*\
Al<mE+TMUijB2.%#NQ3?Ccmt/4GM<k2Y_SU*IcW@^*CVk+L)g0F7Abaf3/B4/JsF`PUd<;W;
X7V>`UC`RXCjAa;'TE*odmB?_=1"/^Rp82XU-KUP=_C!%,/4c)IY6n\^H*(q'&8e^g#9eJbZ
Nd6CKPhq9IF9f#eP>#B1qbm>T]A]AP@i6triQ<ep36Ubn\BubenB+qLNL[YWM\Z_QcFQ9J3LZh
98Q=)mE]Atn9]APs</r$[696Sm,daT@rmRUCF+t<D"SEn4gFL;q6&<&!]A`[[`(7F[o:(]A%>;72
Uqh)("Ce%TTbr,td`,a%\/F7_nB&lV)F]A8bNgOGYD!^]AuB,<o/:4pbVcjED6.:QM@C8h]A@QD
g,_IQ'8pu.'n"Ph;:,rb0X*q7G<&:W187q+;..Y?%-.;,%>HJ@Ie4_Et,L8Vgedm;dF"3jI:
i1.tYDa^lAu&naR*Pa,aW.4HIa_K_Z-fVL201@UBB,_CqSSk@J"<XFd$ChZq"I*S4PSZA3;s
rh\#cE@>6UbuL\TZogQua'h5Mh@8'7[[2W;tFmh9,klF@dMHRQcm%ObS;JFf/d#Hf^=-?jU$
kFQ/UW$oh@Bmd!HY_.KKBo@"N1P-K`k($IR`Nf6k_WktD_E_k>1ZZ!$^dQ-.Z<GZN*?muB>%
AXFBuat_ObgcN76:XOo+)D"EQ\nWka0S%MV%UJrmlS/gV8,kDh0'O"4W=[^b+J;[@+>R'VDC
%JgW'.KBkZ6mV@6K01.T4V)R"mkMlm8?t^Z3Xe)u8giUpp[bp#Alr,N&c?rMg>]A8cQ\6C"Q@
Vo(>mssR=XlU^KNES#59.#+c-MN;$NHH$/IgCe007d)rd0c_HCL^_>CNt-DpuQLWS4@IiDUo
&$7@mh"B2sCcf0W<lLKZ$:3eX?<1,l;"Y`lF60jh-R8I-)4(pL:@3C?gT;L]APbfl.@c@<gc*
Q:33r9X)>br3'O+p$soO#:3r,!jTO-<gW;$?t`<k>tAuA37`.Xb8S='!ujU<`r+!8_sEo;ii
W#G/J0(aE`(3&&p4kl$12F\i0s:fn@qiqFQiJNDD@JOLDrk%9(Ks`Zgg5&=[OVaAKmC`dFrm
<.R'8k2$0j%-;It<7(bs/<ce(l#p4XH@*2=h&:4D$lbeeI'AZaK]A=uo^?BCM8fWMma'VD[!T
&sO[orYH8&e*kts04:n.Q@oj"eD=4:=K.R[]A6;c&TfORAa<LD/(eb/RpKiZWk?hk:6MO'#a7
fA/h)]AE.llHFATsh+)e*h/d!fl%oMILAKCr]A5)D"eQB`&%FSf-d]A`NPUa?Xs=H]AD2QPTkQ9Z
Jf@<k&q;F%NSI#lek1c#;G)Ob\D\4$&B;$D(^*`5.+g5H7LUGoD9OiJY2$d/3Q%q7':<MG-f
AO`=?3]Ac\e/XFG2!j[!A*+:6oU^>kDM3=X>);)(\cUDnbqckWEJ1\0\/kEjkXdGCQE.81]ATm
HZfm7Ch6#hQcamYG@"\TMU,c+GE>j/%k=VG;>%PG[#lb@A$Ss0r=GfGXgChq6L1Qr)e+gi)=
4+'>c%0H8VV-c]A$eNC>kZ[9B@5Rfu[)C__pI5cT77J)G`lCS$g&7l-N5."m4ApEV8$d'2N&`
Oq8MElQi#5H0OPFe>A4s3=\kH@D#hBa,?>7G9Je$O-S5^tig=8Di+8u'C"kjEAU`m-EYq'NP
%3YJVdW-5m5U#Y+5LQT@#R#V3j5pYAf=HpGQpfDrg=[^d;O\M<=l3J_7d3#g0XdDT/#ak5TR
;Au@(Z_Vp%qL:o9]A8APMW[brk?5tk_JUZH!oC&i"s3pVV4GfGIR*[l2-%4PFH=jOl2Tl"V;E
/l<NEKZJ-_MV,CKm:Zd:C[lQ(Pd1;+$Tu2Gh7A-X>1N[HX77!DT5KG]A<.dGs1<k&/gP6YF7R
CE^m]ALfVm$>5PbmF@Gh8+[mo-]Am:2Cb<PRJL"5QF+-*>#q"Kr\g^5"*PP+VWNf88ECngA/q8
L@3ES!sk(!5Rr=NH]AhBWERNjkFT3/DTpo*4&QiOJRR`jJ(PrY("PgP\O)LnHOk=OS-[iak7N
Ht0a+d:o8lP$Vs\gNGYP&iTR?N=#48/lp,^3K+']AcNXpW*"jc]A@rZIBk\<=rr]AKC(;+mJ_,5
_U?@G?Nq5\5JJ:>I"7)fSj3]A@k,'Q!g!S5)NW"3[#LtA3lD6>:Yo_rY6a"350BTZ565oPpYX
26Ksn*'RqX`e:tHW!8!$U!T2N0NY:.C%(om:TZI["DDNBgs0_BSd>$p=!dEr_,/3NFRL$L#j
i_;S>YH?9BliC`b417Df=e<rDsK(M]A';jF&T;X$Wo]A=0>6"Q\Sb=7Jh(fY2G,S2#``$q;HE*
/LOR-SYG*Ib(fU509PG\kBW:N::Qa>5$aA1"N]AkLIunD,B7)2!U,bR0rlpHaCfI'@V%(uOum
S9!spV#eZ8K.hDprrQ6Gs(G-LG1!/YrD!BHs*qKS`sckW&,a7>GX"3R$$F&7?ZR0JPE1+2S8
;ER`csbrW._tJHPkB*Yk1;fGO7hU;!oue5JJ9BNEcrP/S-sH3Qg;Vf3BUW]AEMoeUq4pJf=`P
1Bj*D0,C)DbJf-)83%,32)DO,pH2N.uC_/`m5\K>$W^_0:0@mIP2LT)ZGEIsI(EU\9JLsJ]A0
.!8tHQ=[18Bb(8-:?=ta<KkjS6nX[(u-Wpi`g6EO211%$<i"d]A.\YJ-9H]A/Z-"U,5K%!Hr8J
V-HL\g&*\ZLDR**O#I>A=;MU-adC=6R43SBF`@RcYO.s'7;BDioJfR5L4IKUeIV\>(DaU\*E
Z%"6V4Z$VqB_4kZ+A1/I*99Ved[:Z[AuZ:R=XSeX[$R?I+^Eu9+H`skl!3T[+-k-X[TN<POi
>'VEmb`;&R@FQ%SH9%(Bu]A;A8uj*[qIR:WQS*GU0^s2V&qlZ&YLI`IV="51%s]A9Y)jPJ!"/@
X!.U2u4Uo#/IZmS((A<G_;T_`Y)UGm-QTXj9hEPC;L%Cf3pW-=aRg@A_=o<]A(Fn2JMpH*?H[
sWtnQmV<gLOd$2hg(obFsVb?-/]AW=EYfs)o6"@3L@e@Zb458IIo%.e<@=]A6N1k*^AYI$oIGR
J*HF5(2.MJ.Caeo70hr=[f3S8Y"'MXVq.ZG@B9(q+=n2[a'Y-7K)j/06K77/ct,OPm,hrpI'
58;^3W%f6CB`A.j-ok5soP`04?dj;ccGeL1T0/3s,P<1#Xcu>h4"kIf/9u^E\=?Zn9rNE2qO
,JX`/@d#$Fng)\7&8Q[Rh`3s5cdrh=]Aedi8&kt!Udn3\Gk\0.Pc?T5(1!aM-n"$i8:"Lch*)
[ROg3D9T(S-ET1aKIU1'6D!aBKZ(NAaK7-SVde0*en;6&B#K-ocS?1*?CD5#j>8EJRr;7.g?
5AbT6l63^RnU5d*\m>o>!"+fUWk-'TQlZ37QA0EKf<ND&+73ic1=hhU(IBV8oeEef2)$!P=H
-9<eZNRGdmUKLZfY*S!8#F@OTsZ;@^G\P><A(8N!6Xq8tEU<LY2mIV)FZ8>Y)@X=Igt;4'cD
C.OsY`aIeWJ<pDd-K`#GW:^I'Juohic)b,'N^RiI\o%GTEqaaSme,4#Q;92^Rg/G@&`J_$[l
o82/F6O.IGi4%nT45OT/^QeKE'N6,?'R]A\%!n'DSUa]A-%8T(PB8ia$V)J7I-OZAoJ!c52;K-
XmP$!A]APGYS[Z(%S6NWMl0<HGk@%^LsFnXIG\kRr@r'b$GBF;(/`p$7A6OudbaqQU?Z.i$nJ
!b)%>Q#pg<lUm^[)nac,GVWm&5&)j?5kr32_,\N0rgct]ANIGJBr2TnH=BR%o_Xcade_7UVKT
GgM.7o)$pZ_E`1]A]A4co[7%7`#0\+N4fg&^aRp#a>;[;C8q;o!)i)\GsLgUDTrN'<QpHG&.=u
O,?`:<+dEf#(N(?24&"A'9$936q6,<\)+hpor:..p4lMAarNi0[V7L/RaRh#.Gc^7*NT]A!YE
WB9?XM'XCq:n@\<_u=;9'Hb7N;[c-Y.a;\B:h#`Z-[D7X!i(qda-mZdJe-O/qNgX!@A/+5LT
feH<gK-k5"Q&Eug)V2r:QQ'ICAl/6mIa4hs.8Mp;fM(=S-3/`:%EScE<a'p_p.sKAHbilToH
B&7=GYJ`,9G:Cc3IGdZe/_`X!;Sf(o3_M@ncm/OKVQ]AOlimW7c3^o5g%T(7ga89?%T/.6OTT
o2pX>s`9%p]AbT;K(sWVJ36KIZA=(Y_S&Nn[Z)-S;@q;5S>t,)A]ARD>QV22t_+o3WFR\6(l+R
?,WD&H\SMuV$BL\;+*V,]AT2)1MnEQ:WYeA,nS`NbC-%*?3u,pRL<Y,nG8_0tf>56.3$Q0<I&
a5FR>bl3qLi&^8-)K;oC@g2p!PF,&L@?k"jAApkPO(=_0LkN2,>/)Fb:!RFhQnH+g846^OId
R2[YO#?3&O)ZRc'/1u1KWB%%=T_/$#N(.CQXif?_u@m`G8LB1F]Ak!%sT57]A%75S+)ee,AUW<
T2'#,i,%s>P&b^E:o!q\-;)"UDWX!UPANUf9Gs#H.T\C3uh;kmT#6O6o=ni,DF=u-&3k#K?&
c+G+KTA'p6NoCCWZTMaA":Oq&.8NE:mf:O?LjM_<B/IhN#oTsj/VdViV1EaqeOmI?Q(hF>G]A
Vh&[k_Vhg7-l-Ofi0S"#oe.NhgKt/7$\22I?P)t#Ps<dln5!4D4*HI_>ZJ)+mN:%7.loHQL:
n<k(m\TRd.Wb(mm>tQU'nC$'Q&S+Sj?.)<[@=j9)dT`;:i'us4uuH2$/"4I3bDqHICXT1Y7d
o.+t-;//$J&6h-?^_M?$ID`A>p;M@]AtArt2(a=U-X*4/jLS9eLpn9XM\]As_*!Q[^S:fgK4u3
k(lG<elI[9qV:"7G)V[$J7l*qW%Ek9V2D"?TDWulU]AiS=#[_sl&^$G^3-`d"n,o=c2(s&I]AV
t(lWq-2.n#L2D)Se.R/bcS0jLB-]AbV&i0E_[l+D)dY>/6\&^M#GKI(fJ(@H6/jNrTHEf*CAN
$UHNb/=Gp+m?H!cTg=-S]AAFOX0A<mI!/NZ;?LDjL'6VJn^nG:Ts#q6>_esH:`>"eIfqh=?O/
iDtj7l,3WEt/rd]ANn/Zp7pcj&-;.MgF$rh&2:@\.&82#F.MRf:(l/^dD&_>96DlkRhOeYa)t
D5XhB3S0uFiN*!"^;a6/BrpX"KU4MM9[CQ6C,R'3]AOjP\koiH;uYHFpUl9ub"G9d<bDapkuE
M@,2fs.mD!'1!^(JrB:<76>"<fI*#q9IkEC\kRE?(^AU^?A1g1akTLKJ$bNM'fum*ttX1D^1
1SC3)O&mIQaN\nsTUYZk&uh[`&D6jR2`:e9&Yj=Rn?aXDQ4nT.#paPuPi(d[`[@4!O>hp^;&
L<t.j$VF`-@$N?mdnpA3U^tYs/dm>6;Om<@m2DujIUQf";BhX_DpnYF*C_(k-dac*o_F2NR7
+&u\;W^2J.U_3e^)>Ze*iI)<m;qrs"m`0;u`>ID)M'sJQUo$Y[!jJ9r&$sN$!=0B#L8$MgYC
kH76E!'L&H3^CL#e2Uk[VL7L*)X-5sl2m4Zc[Q&G);&Z?MY,q;\0uhu"b6;IjH0dDhl0I7M^
2;[YEZJt#p9&k/H?m'g_h!t%1PF0t6STU#S)nX2CtKOk*Rq-gXYTN>"bY7\dqfG(-eiB#GT&
NKH<3f/s*u&-eB&tHR]AVslN4!0OZmeJ>_2G5iLsl09J$5T\^MmJ$.+$CUb<J?'0LX\KWutB$
lp@@n96W\,Q67)iF23bp*MWR377K-),99ip2I[R/;Vk+K$d"X\6PdKRgNN>kgCYU=<Tg+[Bn
]A(E4+iC@'dN"ia`Y-%h(rQTLUP?>H:tfPKk9eepe'-9i'NqDHRD+Sj3I<b3\>DsCM"jSp,km
4r:ekfOt`?4noa,#+BJtnR3[R=r9O$5cW-"'O-/2AW#"^Dkmr,3AHhtpLb&5NP;dC0_Ipo]Ap
0F<CZ0pRS:>/Qlm[<X20mum?*r38(.s\lc:&_<YjNF]A5S9<%9IZI2pR';2h'"`$M!W^?Vmj-
Q@qg,FN3,u7'roa$=?\CVROZWo6^%#^H^;bk2<mTq<Cpd/k>ZUkEf[Mlc>MTph6IGSPUKG*[
Q<+=m,/%c?^s.0^eR/66IG$UqGRs%(->"D_Zu91j/3Y3Q$j3SqFWq,_$/,%1P&/MQ\=kkEIS
jXqaK2:^JoR<uEup*.HDt'?k6,:jkSk/H2TA#kGYQ-R/1a8ib/<\b-S#h]A=pHomjVK41?9J/
rAY[*m-@lk+o*f7Y[km1X[[`e8'YtFR?WXm5m1^no+igUs00&6IICaM%JrjF[T8VOTXa\j<@
el"Zro.!;:V?%K(:gt`rU8kRPrT2d!RW>rKfMJOAl?Hb;>8<q^:F7I@#U*5o)YWt:ksO[l9a
2'a5QJbg;W"Mq4/\MB'/rP%=;CiCE"gG?36.XIFDKc)h2nBVf0QXWqt?ODFGa_MS"`0h#W[#
Xp("1/r37Vs6ehY:&VYEdA;?Skd&r8WaSu<.n<o]AM#q#sU@k^DKia835$ma/Q!09L%$*(uo.
5i'nI"$/k)BET0NG6eA;/L$NNGCTXEFTl=X^<+b#?nINEb$k9Q;P\5WPjc9T.+uJO5Zec,[.
SNRjkV]A;liI6F@1#ib%Zo]A65^Ya)OZ(3uA/h#DRH0AIsi!KD#ro3U]A891'ck=2i;EUjof!E2
I/f3^u!ZUqNLXV`;#1K>OVcmqF-e<1R?gZ^4.*ms8:UQ''OBj+E,EO:,Wk_Ij:o0oT/OjlDA
*j`sA(W"X6nnCQb^DVH1Vm+F%;jbZro!kn9k(7%a@TF>p$rYPN,k&EdZ/J*Kq_Li6!sD)!*0
GdJS:1WHCVm,1=RH8&hs_GbT>D\Fs-!AhXLP[B*p#]Af7bXS<'^55n=`E*=7(pe^+G5QRmD9\
bgk8!f51>dX;H-q"VT^u8-(hBo&R;1kL%(a`EMc5mHI#p#paq2V.=FmPu$aANaR[@?K2=<L*
joYk:moS6B>"ndoU#?R;IH87ImR[G,Q+eOTifDYs=IcQ(?/7PNd6U`6!Aq_J.]A4*N=24Ku$i
HWKMo#oGD&a7R3XDR"-Ch;GXiK<^TT2CnD-hK]A(Dq%0MXrPeN/E8)fK3\H6CD&b%\C,Y1YWg
fgP-d2o""F<KS*rE00dikYS9i['c[)"S&2E^ZX<pOV.ccm2`kLiekeIIo=g9VknjA=QktNUV
P0]AS:3*<<B=K'fk'1m=&^dr(5q9O8P=m%AkpYq?tmg@?dm_9Q(QUp#\$=*`o4)0QtBtC%hIX
(#T;>&L[;23oXY_o)q8U#e"dbW_+4b1F(FGE4SWdkN6/KcA$cs=Kg!n&g1$qNu]A8q(jQI.')
Aq%rkcb^Jqqn$T@4p0+!$SE)'+dapZ6o,.I2%OK]A#TCX&S2.aq8_>\l_6^EBH+Qaguq2+uCd
*B1?91@cgJVh42M&:4G'bj6[.3Lquhh-B&b&h^%Y5bn^FkB(&`*V.F1HZq`HW@<R08<0#WlZ
@9)K7fQ=Gi-$DZ`85l,$@Q]A-X'UVHLLdrUSe5HnZ[(6>'3aS9P71QMn"3:(KNIlZ6e_NYQbd
V9:$I$iri(1du?k9%X1[YPI)FqFs@5[5<6:ZTYM3qt[an,/5"gs5e%Ln)?#4Qi4uok'.*3mq
jAbeDj]A#;\FqckVf5P4_T02hm$bWW+;O=T3?-?>Ct/kpaK?L)/rhqI6$U1_TOd[dN&4_g'kn
V!;\\@:toLnF!,[4KfO[7[=C>78k;N)9!uk8Fu(r4lqP^#LK!&(%6C.n=7Lb^Rc(sM[UKnV'
Q]AAoJ0/?j+P1q.9t%[Ke&TO*rgk^HTN87F]A_Jn:F/*$7UY!8es3>X?cbIC;kFMZqoq_4Cmq0
Z1p7<k)'8MoAVSR,Xl=,_PrKLtN.#V607V%hCr5fMKD_:i+30N_\T[.Y=alZdRC"8aHpk=M5
m\EgM@eC9'S$f).eA_luVi/e<(/89i:(k4A7q7__?Qa\XUt^DIeCZY=bPuu*S4lcJK,K\?3b
\td@i+6NPJeX?S'/p(Ma)ru-aO;bHM2<9!l?O]A$q?!X`-:'i$u-6+T6.=\1WfSE%Q.\7F1^#
cpR!5tc#L4)"tcQ3N?(k>K_+j9SjFEqRhaa4$#^SfkZa>g\.rr0omW;+.ngWIg]AaDNP?G67[
V57T3E9,!O3`4/C_b<4ijpq7=0X2&1Z_Z:_Gqb(lmQV]A")(?p<>(b;(M70ZU#Q*)Ec@Demc&
NXao,EI.rla>hDl'0j?u!7J7%<)HcVrdbqRPEMHk^lA2IcL"A5%C.Gq,>`BAecq=BSn]A#Oc-
RI92*LmDp6m9:U&j1bZtVam?^X"tmk$Vs.W_IRicH;E)Uh,J,BrskPCPqtgtU#&OO<\DO*ZQ
]A2g9Vn@_q`j$oA'$,6]Aq4XgED'BXL93k2G=M1Xellihc']ABK*]A&gjXN%4qQ=0QIl5)>5MN5Q
P-nD7s-DrYp;"$iForYecB89JVpA_m3"dUYE,OTl>1B;emo@pZ;)YrYf\4(61K(o"tE01YIB
>66-Opgfeq.a9a@+g1@IAcCuj#tf,9:Ai_B?6.P\DN!qA]AFWH3s9Mi"NeW5iT9*0@,jp=jGB
b"pd]A8(EdmV/VSGh`2_3P6Y:shT2uj;mT$[r/@5-B5;Vl<Va,QtRqjGjJ%FJcOCIpd4Zh/bH
ngrA0:B/3T6O(:G`+8PFS7r]AbiuH<'aYPlJD<4InN_2QB9`aiWn,0Nj=MK,(@7$N8G%ec82K
nneC)(S-,s#$7Qk<o=mm>\+/#%hi6ic%nal!D_7M"rG/SKAVm+9XE.d^\o\Um@]A3J]A5f+1B]A
a5MZ:,00B^9H)YDC$KO3^TC_KH"B\u!Y"JVa\),2c=o`_G!>7SD8]A0;>Dsdn.%;0XePe/sph
ZD.Y_!6%!)b%^FMHV"HNTir$UPn<X*FM='aouhQ`!.(2iY@B2q>VH9BA]A($r^F&"*?Lhk<sk
UuOVi$u7pM=V5n,N%m;K.&.t;&LL3Y336NP\'?*EqkqQ\YmW-Jf?2o^N7LMGGiCs_Bq2u;HN
/?$s,gp-,H,TTmM"-r)Q@+r(X_&Bn1BeqKZc-1XK]AUk`KJ$e>ZY)@":;\us`f/mQI%MR5hDr
V=tn&j#VD`fl^D+nko]AQpYuWYn-UH&+"DIFQaK2oc[mYH++O^PJG?cphAaZdCq93`m(,B3[D
=Oulkh1CEj1L&G?%?Z>QiRsN+1>9mnb-p?I*!VZ`^Aj?0rs5;1dM4l'(d;F`,5ahpQ*%`1Xa
rYbN\Zg57C\i)O^5+$fbD@SYC(Jb4RRXKU;O8=`*&JKJ`Yr)QQ=Aq#Ma^qj]AfVgE<(jc@VAD
n.Q/l"QjOf=Ds4]AT`!V.'?S\2Mi]A+HQ``r=k^aWH32TnK=g#B$pprWEHBBCri=2g4]A[Wn=9K
k5#/Z:#=^aV?KJ-6.j8Ji!/<#;lS[Q@a-V<hrg\`dq=1;)SZJ*6XD<P=-^MgK\*)PbaEi;Ed
RG7X6*HBo_p5H]As6T`_@=45[4^k-H;+$ehTNHs?iLJ39`^-'^?S@L2B"2YMk)$S06[^7@B&-
q6W`aD;E4p\bPVYK4@OL:&kJ*#![oFOk2h>MUZM[TIO(Ql-o>#WW@.ZWdo8:/0iX56mGc*<M
#/5$JJK!hOZaX5Wj`F9b\XpE%seZg>*!".n-T@Z4cP*,rPjer/[(JohC-d#:?ua(fW!B'`bQ
s6I@ZfC,jDM*b:2d`1\tqn;V$?P+F>l-O836nGb]A%]AP\f>=G7FR"D!V+KMl5l)(hcX3YOg`?
h=>;"\;/E-%!-ks$UET]AoguH&a?m-Qnf=Z$o9g]AC/;c6hp]A1]AML#C=6X8,#*`FRcHULr0_MR
Cub'?O<gFI]AUX=U;L9Ll%/sN'>>0+9)un_B:7cUEOq^%,/69+f66UK8"c0'_7osg."W+S$p]A
Rjigaf&Joe]A\,;Riotr1^>1p(.G+%hmF[Ujdou!+nV-aeFi=+c*"-6,+C8X`PJI\N.Gl"1Cf
kPth?deu0bP\nP,>pC7lL&%&U.$jg<`,oYFos?;DNem.;>0&EGMMYGIZP,BW%R=@<m9QY7/M
DQq/CnL75)Z_WKoG:S,4N!_?=kS5K]AS42<uQm1[TR*A7&6-FU4lWL*ge*-tNB,9asqpX6.'e
lLE)q]A<qP6$E-\C^c-BXO,@[JWO4BmbSZeZokXZXM,a_@<S>*rn.[4s>iNeV1s5((G*&:R$D
i3=8s3;r?UZ@)i!*8`glR?;n':#&8(mX-F(RDG!;ULJXNe>B3sI==?>9@67+O*:UB)\MDrrY
KZ&^d5;-1fMYko;kOmYMh2noq*_bjmL`D)`4Trj^/UF2@@>88>4-o/&nhQnO9U"Wkd'bLF&<
e(K^[_?CK&GKjp\?;Bf^O^h-P2;[2+PX>rX[L;mLm`3-gmp(>Mn&Q>L[6;BctdVbQL]Al`l@Z
'uq"*p*TfCb4hn,b,*>4:GcjLBgJX^CRcj0t98I:<r:6>j<cE&/W(Z!'&ge[]A!:RV>eX5!)$
Y4J\V4WckMcEa7LGob$uVod]A+;`+m.^Asm"g!+kWg6D]Akc[11600aL_M;o'-;niO&:AlTp"A
;6I>r*9X*X<L`9/.b<FGgtDTKVOV9]AQd##n)8Gf_K&h_!>#0baZO50=0D]Aq^H,9AlCQG6eP@
m6D!rW\4Dls#n?+@NO$pPhKlI^1_",3\9f#.%Jt`Woh2/"F>i+niIW-L(\:FGciEX@#?I]AZ*
>nP-d>*GHp69C2Xjig#g3`rV&@)_cbDXjlGOC=DeZEW#bp!;'dJ)+@dJ5<tPP['K2CWoU5p:
be;j0U+dFBkQ*+PElbJJ&@ZlSn.r_H[78=DF-GffEH"%pc&DN.jr.HdPoQ=V/tcn64'=<0k!
*3HpbEu9lEUrjOCi>BX%]A:`E_YAQji.5YC$+q=h1\q<ad=mt6s]A@4la?g?:caXe(^i?%g#2R
V)W=)LR4lr_c[A8/ZCDosEg<+#Xi#T-Wj]Ac:)$[ds'>VN!UG+WB4Q;I!G[664A"g$)r2;a+T
6iX8V^dWWmP1[4!s!*KufA9f%Lk4$CZ[9YcLZG?h@kWK-B;]A7\d1Y3OEBg]A#@P(mE9Fi%;#m
AM!"R+Q6^o*%o9U9fal;s20&RW6$h6N*FnN-`MNp'8gYc(VXRPJ3F)d,6Z1J)_W[pj$ms,.D
sd^$c9(d46]AkQ8E[DTm^Xc_#agW9QK7iO!T%^3\e*'&p[C.XTWSCeHff$Lo%YCqW!Weg8+]A=
do)D[nh]AC#Q&nIKiNDTH9S?#15<o.uR'luCbAXk0c.pnSE&2sJ3AaZJ)b%Qg5,OhBIdD\!X4
_H_hL4nKX)Nob4W)kAO&WbW:Js4ro7:5anP>>u1=h4EimkORhgoc7VmiE_dqFV3b5q1O7U;d
)e`,_Q(V>)hQ3H%m?%_"Aj6eKIlJk5K8rJO7c[=J()sqPAc\[*MN!OW'jA^e"&49%VnIIs0S
=BNqi$gG=G8k*2M-%*Uh1b!N>#u/0(\DNPZHQ3(qF+(W)[.+qYC^iEO=)IOE;uc'?VpetklG
9($,^nZ#/(EnpcdGV,>?oEh6(R4Mg^L78HU-Zc-,-3%djsLL.d_$kpMi'r*-55CVscGpnqfZ
)9^EA-e7.khR]A2A3j6(oPiu2!(3GT$/Uu7S0:O42WNQ=?1qI,Oq-3DmDo^1RR"hgH0O@br3T
ibaRLfb=&7VmPg0*p:F5dHLH^2OI5TiGTHleruhPB0p[$-IuB!(dPHT\>`@UC7QZ!4I@J&J[
Q5Q;Zbpc7qX^0B,@%r",/nb5LabgIG,j"1bN6o1\'Hqmb$p>OaE[7T>Z>S?M_[I!7+K)Q(<c
9N4#>*']A_::'\TN_WRVbViX"je'8!IJ>Ps+XBQs]ACqR*%p($"\*eY*m:TIU%Gh,gXpYrdQ^$
X+)0DPRSZ04NODdL*)@`l')Ao^XXT=NAR.OP-RNCA^S)qU&FET0H$iJKq;pG-4\3A>)iLd-&
Aedh(f;M0!@GeH8jGh@NI/En#N7#,e0F4*B\nr<&F\q5mntgYZ7.-QBq_=R&6M&bWTH=djO\
Bh?`FX,?n?!G=j=P_,#)t*J`j@&neg0gcgGD2bbc(&u&ue\,q7t/WXCmoMiaZW`mtPG+J*/k
HRim6`Th.LL]A'n=h'[F<iMD:4XF?b7u<ZguW)8ahXOdC1_]A']A!bo\.un'V*k4.I#GIK)#XQ.
T]A!_?*'SgBD^ZahkWLU_+eMPn"M82#2WB<KW0_gZX6+B"ppFD9L6>`-.`dMmXJ'mg\V6/kiT
a'X#?pS(QSIiE_oR.c`75qEF%6SdYp9/-WXi.FiB4js6oH2i(NM=1J&E.o#&\BSre5nA#SB\
+W3H:c'gm?Ns\OD!/YQTP$6N=`,LN^euYu1NMRBoL#6;d2&2hgiE=>,3.W+Mh@tF:o,)9SDT
!Dm<=Zt*guJU<2Z5Bo6Q9[C_7]Al=poqVAdhRe=eH<Q2rI2u'jNMg!*5]A/afdW&h-.`QL?mgJ
L=Ti%OVhO`:PJ"aCb0/_@07Z\q,[mc:r/>8k.$Q@(F\]Asr*Hrd]A9E.o`GiE:MoZPX\:*Oi:V
9%C:ECtY5#"EPb>YF^IfThl+A(4Ui7:*3CBF3]Af3io-SD2]A--q`qbLD/<]AW(]AF'eYO\'9&g"
JO^,OQd0=PLca#)4YS[-'PUHEL$nKGk6Ir!UmT`iIBkea#sjY#qQF^R;nFp_kuAlXDROYGg1
qgX`C)6"B7"g$Dd:RFhmPn!V6JUu3Nkec?,W6KFP`V?DI.jc^l^%5PICe.QI&j+>tq!%=YPG
MjT@dt./FAD+h;4Y]A"A\InV]A3TO$*SC6>N6,<MMhI)\C?&NR7s3YX4[skf(W`MY&UX;,(<]AX
WTp6pAMc@4SPY,o,/CaP=U[Nh&RKWc;@V1Y<0-"0CH.%$!\/;HR9X$kN8YCg%ED@@=o?ZT_p
UWeBgKF5R0BUR2*q?N1`!u92qFW)QF#uOmj^<VM@sYllMjUu[5Hb:B+r24oi"[]A8WHBZ7dH&
XG.:k4'@"Eq566l*r5FFja>O]A+JFXcFY;D-+sN<5Z3;6!R\!'g+!H=Gl1?Md+:TnY/i-K`q*
ksYLB<D!0]AlZKX`mrL4K4+;e/0ZeO^HYAa[,5j`DAcc3'M`[oE]ApNK$IQh"!4adVECriTl/t
<VNo0^9EQOAg,*Vn0%e&.M9UdhBV_?H7fhIB9\;N]A+J4.YGr.lRbI4CjM?Iu6\+8+,"@]APE`
j.Xq!Z1lL(GZjsZ%S$8O!Ufr#(qWoahjF0"4f`Ll^AmT"mnCXn.II"di*7`#q)k[#,WO/g/h
+Ee7D>8Q(f[FJMRmFF[Wi\olJb`%VKFK^&H^l%*m!&Q=!2G/gV!u:FnP_-B+@Y0?2O2rdF,]A
&F<:4ml`".]Atn5tS6+,4VcL+p;h%M,Btn$07+R'KG7Z-adX2k'u?M5<tU%pJRHA]A=OGCG'a9
[Dqo]AG@Nbs`+>hRmho7G#HAh:7a!BP/<.qB!8.HBT2^U`AUY=T5C(nrCm.dc`4YD[_T2m*]A$
%pC*LuPj4K"6I-EMl0e1U__",i#!]Ano@edV@,-&9V;BKDQnh]Am]ALF\OIGE,#1RQ_eeAC5,"@
EM0Mgdq69C"f&;kA'3@G=E9aLlK9o^6ZB:Z:iTr]AJ"*#l7Y?ocAYJ[QYQsij@"^9XKE=55L*
:V?n'm!f4F%dh"l>Y<G*:V/tD:UgL4ZjqN8rDP;?tRP1Fi$Vkf8fIWAmn07/n``MY\!P&X\q
)]A._`tQ'R)4I+YZcq;,XV.QkQGSl+J@Gc9_5=c=sj8?DZ'Tmn4OYN8NuWan(O(MG:%SUWNm+
A%2g:%!nfq+0Og-noGQ'/GeA1##Jb^O<-JJK;K&?/WKQPYMmce]AJerQJ2D.]AB;Es?-))1UN(
$3CV.G(lDcD.\qd@k(o!gU)U0SL,5l5?B_./MHD9[%tKN1\jmjDdH72M/e9/%#E2/H?[9.^R
omqY4HI?/.eRKS&FW(Y60k#?=>"!IWURu=,cJ;^ra"(6@;lur+PeM0u<hM24]AeV0ife1R6W]A
R]AUuU:!Et;qDqGU,PJOjNM0!Be:q=oM%k#_eNQ00#A]A_`(kT=dbEVZ/&a0s@"lnW"`!!)2LW
OW2G,K&>7VL5GcnHuT=m('@>)(3B<$Y,\:gV"2iQ.bYaW<59:^F\.gKeRhNo$QG8oR,EOPii
9-CAqK,4O*F/c;$I,DP3ph)t/9QPk3V\8#SSVaCO%L.r-EkN6%fiLd%NP9r)#uVo'`@n#Un>
!>92F#3Wi^u[bqqj<3J6uYo'a@$lHAX"j9P*F1'+!rM^pQ1.IS-d7G3BN[.K;R69H=+DW1?&
ef6oIkje*%]A[bNnjg7]AI:bK3;M:Fp^%WQD/[]AnJ5BX[!.AO!!*+K`;>r1=6S&HZ67A*f-INX
NB5h'7[lZ,2=T(8@k#$ZRia+juH'p]A]AJ]ADf[sR#0G(J7I"'D.EpOE/nqMuupp<*$X]A+T.87a
d([8,^kPt#>KBcU$&gC!Un(VW.Ha^Z10!k!^<DjO6V@^ojIdlD>uNEo_K[4"EKZ$H"+`NuYH
dY7&V0EZ>!'c@$&<="hBSHk1BRP8iFqgbR>$T_J&,*ikFhc>B:QeCs*ZuCo\6V2>-Ls[j7'f
-#Z(0KW=D*6k06k1;_9Hga?HMHm1STJ@^\d+jYD$f[$C'GT5$NcX&a+lZ6/b%-B:F"dr&I5'
&Cji@k5j6g:hmY[<DYht*.%GfILcBrIp*P9($W@1D-pp,2&("6Dg9?l-*gT(/s!-X6htb&!E
#5JW1s#dq=o<1=Gm!,W=A"D1%_Bb,2:)!uD_AiS#<UJRPe#4$HeboNNq&^sr7or/`*oA+=!c
)S7IaKV9"?u\(B[><"(:7SqO"\nV`^1ZU3(<N5TBWk<q.c=s"=%PH?T]AQ)NT73-ol^!qW;S`
)E.Ns7l@;!.UhXXnl$_d.8DgT1(>/BrOeV)s,l^j!-Q@\0PB?\MbF&A-A)7!i+55o]A8plQgZ
W2MH)-l`84Pb0H:=a9P2@WBrmQ.B%bg5'I(2rA?XAl;]AKQs'7nN/3!sq(B[GX]A)(J/Of,)-e
6HqC`%8c=#eVu%9Egmr4h\r;D?.//OOi\>^3j*.j[l7R?Y%u#2H!.T(C9[pP6c_cT=6d\PZ$
),dOT%)OWqiiG9\b8Uu%8+PmNKQASCDSVTUFr*cruFM2f#OH]A]A+:Oj77C&3<Z%/<@gU&MZ</
d[M=%[3Ts5e^:9t6UnAQj_%OCCNB8u8i>V_&D/]A)Q=dcGWpX+N8=E=!0[7o-!V?OFRCKto[p
RT7fL\*/&gEq$-!XOd.m"#Rg<I2T?&=d6g2jAjlZ@WLrfl$`rQpJ?);hV=BE*7R6:P'Yr%c;
KK+a20K!<n061H0eK+?2`*@>iGFrZaG&;m!Roh.-#K4:mEdocR8^BEj+[R=$OA*46fGpW+Wp
+*b/)@MbTlAlGK19qDma$GiOm?a"u-%4[d>JBTHX2*O6mt!liD8U[GT!?ISF,^L?UeXPOOW]A
guOk#oMuJ+PTW4Sga8qMKQ[cj-^4m$,40BNq`@^VN%[Od\KoC#cF%)[^2G5Q*Ok)RfCn1\AJ
jPmIjIkFE:Ij$#.7QMRQs+'uj.5SS5+g;?foIL:K\-'t/Da^(oJ=QHjM2C9;nDG.,*VL(iZN
NIH0!R8i7EZERCP%$_ACh"lT:j4tZj>6JZ/RBV"&(p<-'J0Xf&nit%7m>e=d'nuucg^6n6h5
+^nQN#^0cAl@jXIq7:P*3G\>C_VHQMc^hM70;aO'3ufG,D:5b,ADO?^C[nS*2[j&'`Dg!/%J
SMYVnCC97!XEBWQ,'$D2l-SbgrOW/0Ho!5n@l-Qh'GHZ2&N.BaMJ9>m]Am,CO4#K(#)Lji0Nh
4FEQA`i/O+aP##Kj8kfTG6`lEQ`K?0IQ<kaBN?.[LL)83%(E^D^0E>R3hELft1^_YBdg@^%8
tK(ZLU9M4Hh9PQanIL\q1dEAX#TaNDQ-F`mh(Puli\XRY+ghd1<QfhY?aRF1$WQ"Q_93V!7,
Wii:#>%aAt2N->,&.2">UQS9F$ABegFb77Q?i/XiVMgklOf8`W/V=O`3M<%LR7d%;"L[EAK9
lTDOVYU^O!%#hn[VG%SjlI2of?e@ECYfAS]AS&eZ0Y.XV279tX;amAC0`]As&9kIW]AeXm/JnM8
[dGW9gT6^NVHa0O=,lpKL-aHrN#."3Q2a?=7:mN3UlkP+np34:1L2^o4X`>dX$u_2,jYe!Rp
I+h[*2+4n)Ft#r2L&<Rh.jSgL<7!r"7iL8c0##QaMK^<[B1-g$%>NfND)%@.96E&/\#<R5(;
d5O=CC4hfUa2lU$YQ<S\\^i8I/OV!t^88Wt2[q48@sD8:`;`-4m)AB\!GO[@o,eF^CNmjE,U
m\FN^!UIHi]AsfNa')K[?qr`BOJgJBVWIJ<l)X>2m)Cm`1,`P9N:k!b:58t<ho]AX:nSZ'"uho
H4cL0_kA.u@(kCO";Jg+Gp"G:mWr)mM=X$>*s`i'C8V1C\7HkYg`Fk:fGplnJ/#02>P6G^QH
n:2,=US(p?s4p3@(4U%O4S9E,BcQ<\8*k8)JD.oWCmbJ5XWp6+/qW'_ON2(52kHuI[goLW]AK
IHP=XFC1RcOlgkd^'dZ=0)?4J2.;W`:qhG.QWTcns9SG'uYQO;q7+,O8MQ3A99&umnF'Fkka
"kW,KPmCFLfI1QTn-&GnlSeK5qAYP2kQ$<sI>J5CUdp<r8AY9AHM<.DM0*)P38jgWiblWJ0%
.=.pXT$P*)APZY6*-T(1)oUn9a<5DXfi.0S(DMjtn9;c5CaVD?O69iZA<Va;[Egj^;(:Bb(g
#`UN<%d.Y^n<ZE?[U<jhd/CdF'a_E**DJB;@i"CqssCIR<nMUj,3JeQF\$PPliAFL7\EnT8u
+_t'-J66A!Vj32dMiclL0@K`\*Q(YZ!rtM?^HU5OGmqKS7XKr/LEK)`PW1db*ror\&;=D=hV
(&cWE5i'p1oso'*<9FAr.Wu&<FU[0.c-S5D\.p%@_T^qk>7nn;9E:%NF,n7oLm?$4a(AVFU-
O[#hMNme/GG>?Xet`e*;!%m^aDNe1l0CK&$[tUW+S&KCh8G?>Bu%X]A2$+G_guQg^/6\9N`qZ
Hh[D'E52Mt%"?B*S:/$A::i3n9:XU\KLIt9#ho7+d;*t=f#jS>a>Y+rLFn2X?p1;lU[ZQePj
T#pC@(Bc'sde-e,/_5)V1NZ"&l,>;XT_TB!N5M,sp;Oq:3>s<Z.+3%qDhbNcS0^TpZG]A7E(q
2(/'Nj^_k^pWRW,/8$-f#1!3tq1k=PRR1`=ZLiX[jRf@cfb&^@GZ_q[Si86.;ikc]AaLTQdTo
U&dE*siap>+Q88"MAjQeqq:q=P_bAmVc1E>,)q*Sf_9)-;7M!Qefnsp$dYGAZI.j#M!dXN;-
A;b#5q)_l%tL^<"SM!XQap&KjWl^J>&_&BuCMjmCoSl%+bkoC<*%0[P2oojVb4@PpHD^RM5F
k8_?#S2s#HM'EWN$0_u_`D'[8AI&7<$b3dPG1pP1"<S84^=8.a&n@^8lkelr[4HXl>]AgL#Ed
e0_^Jl0=)-Sp/_r3U3-gij*@49M=g>I\&mqF*(Ic;3cB>OPNchZW(n=.7S$a5#>PTA##$/+R
k%P,G8MSV^l/mALa(aAns:2Obj<!B,/:p176\?mMp4OgR`J8J=KSqpsI9SmQ&b;&+^S@rFPo
nhX^Gl-j@GCbpb+/pUZ"2N0A%^@5eBOP1*Ii0.s-faKdql"#id,<`iAcpR$Tf6$HEP&>7Z)-
fh\$9s4n'8nb;X'Y!Ik^(VjN>R\[.3LC;C.:QigWI;9&^?0oVXbka(&$N8mA#e;3+og[q5ho
:'l,$WN1.,psm#tLs5-sB(`k_`,$g5NdMq#06G`W^2g[Zp=#Mma;uii_Qp4m'GN!ZeLH$Hi"
-t)]Aj]AG9I(.+5>RO.DnJo+fLG(FH#bDb%MqZ`^`ei>FbMXo_6A5)b/\mEr+)<"WBR^u[7^&>
m_ECog;jNTu<CM<2Li0C<U4%;EL)05mcShiSe/2BQIOHO-,c"%g.$*,Nnd1^cf>Jl^N!H\5n
h*B=+XVAgmc4iK`b]AA4:0G.T/::=;)D#W$IGch'G^dn2\8Q^LY<QZGK1]A,YhKD02-/09%.L%
S6HP0EI8+e"jHD19F^D\+B#)Mj6'F%V\47@mJ?rq.g`hCoN4h5&/-E^;Kl(G:Y@VI"3V9o@`
e4sa+BM.4W^$Y&p$0]Ac3-KUNE5KABtW_2`*[pJ!iQS4q*bed_W0/(!J)1!si8/tRbX'hq^HY
5.P(X;oX'ZZ3ZKm/;\;E\FfM<F0-p#Z0=,4HIk9]AiHKo60Y;`6#0R9j=QOZ*qYUXc"`bcMW9
nN,tc1E/U#r[?M1k<2:,Or_*9;[sKMtb91pE1cVij`A"tY<fY>^ChBPDTj_l(KQnF(Y]Ap38G
S_!88VI=S.=9hT:;;\bcA=_ur6@7Z^Xd1aQ;SR$*k`IbV\n+imX(rPgrhOC<rls.U5LG$V*T
(Feh?XS]Ab27p6B06lVfK$f[KT*!*\C<C=M&ZcPl;/fC/psGkp7D3H+t$WbR,&5KtlD^5_`b\
OF8Ksi!ukB4hD;bQea*2BF#5e;"(mJBZ&9bmJ^,$0iZC:h/Mh?$pQ0*bh+9.[?./uU&HP=PP
Bh@WUZ`6%0B9B9UTYN.&A:-G/_>iM%b;W,P9.+JIPU#8A(O6+J)<#]AReL%+IOoW=0K\SGf\:
8]A<i:HGoVt[XRjrJ(E%I)LXN(-]A8"&_B-0%tlmG,>"_a$p:#5sg&AE-1D)i?cd$C;Y:?jqeW
'nQ"hMC[odC=WO0MbhcIW/,6_HoqKl_UKdT#$cJrF/e!7/E#qO,@YY)@e45nl`TpT7eeNPD9
?T=p[>Ji(-&6\a:8H%^L?:O&cJ(jKfJh(]AAGg=!XFSHGD+t[<?iAqU.nZ%>2#=,?.FZqpfI-
i<RRk?K/2f9eOL^fJo8ec#hOqio5=*qG2/[\-'CS6+dP%YG0g3Q=VM1Q7p\9I)1u=Y;ocL;)
c^O7>SeRo50>RQ+&7[kUdN5ip#V_X>cWLh:m'+[C>B^m`L0,K#Rb!3f-tQKAhG&^%Dr"L;pb
#;n.p5cPbF93.n6-bp\K$$H;TPVkpTi,#aJ-Od6@T<_<fUIb9mBoPYIr>hZAV=T(:0.HODtK
A;7fa#!kgM'U5jTu8oNgu8p^$n=W=p[9O7cZR51?D=LgG5qL!p1h)`b1gp9pN_+G'bR+62L0
_UBAn\j9Khu?&qI61*7!HV_RE6tUQ%oMT35&DQ(*6<6#I.6ho.2ulY6.PHiYXo*-Yd&+!DAD
/Oc5BTnL!MOkl=KcB:*['Uf1_^@C=;%&Q2n=RWA<$!nMICSIL[f.kY.8Lml5TLh_V^H]A1XgB
.cr'W6biX)mqia@J"_@S=t(dSf$XP7<T)O'?+!4Y^IDTWO".TMOEn)-klm8?1q$C96\2RQd.
N\U)9PYhQeH*\mV5]A<`9iV85VHddH?OFg`8nR\2$.EX!E9&(,HLOE/i:(\2eGnL'E:GPkLN8
JCpQ&asrS]AD*-6AI_]A9s6d=e0(u5S3X-S#AS3%1oJ1P9$"@UP]Au_S:*BRC6-)Or+6UX5iL>J
))"9r6*F(.(khA:hTU\j^fBBo>%'NQMK&Ej*W;o8r6^4kI:g9e&!;7Hme1q3BW^Gou!DDrjt
(8CHqLl]A5aA=9WElfO^KQ0?:(j*'\j9:tiG*3cq_adkUf+d\[=2G7DN5P4?":4`sdZjg(e(%
kX=,sBBokJkc\<T3Y?1+l`HVU>T!CaVmiltQYdcpU(XC.@Eu[<`iUo<uCHlF`#"gcf*:buiM
p3khsBSV8?Qiq]A\.L-'0-=F:nWhoH8=Pnp#gLrGscSdm`'Rc,K#XU.)Eppi0$bnG(]AIX&0`J
B"#VeIpOF2]A3Q<M_YNdD>V\VQ'sQKIh`K+aD1Wu--`]AHO*f;&,:]AG"KeGMK_5D;f<,J^E_c5
;_GBt=(475_Fq2:!M_J7_I]AA-5$WU*CY2^*ecF[BHaSJ\YcR,S.o7dq'aZ#fr;\@;q3`0.1+
mOr8;(:n;SKd=Nj=Of_p(>!L/h0RtQCGJdt'&ffOa(Q.DY@)CBKdX43WEV-V-t`V<',"WaMO
$^[=9&8V.D_.=$@2(o_,k\1P<=HKr_n/:"Ksu-?a6!A(PPH!*?A@F*F7#sMfFo\Y;Pc,3K36
L]A_[Q.-<0A5**`K0pqH?N(A(h9Q-_]A,Y-Jqj*hk::$:2]AI\pdMQW_Rt4kKGGR7ic1`6pnBPe
.1'[>'0K-*IXUFN]Aj0LL&G]Ar@Sk,^lrDS5bBDkD43`LXo6JL]A1RF%3Js@r/hN;:CBFZ:o#4I
mkDVr4$7]ADHkW)`96;aoc1J>dY^[K86\`b9N&1RoOKX$FY*hDiX.&Ur`I/TVXbj(e!,GI*l`
DZ6EMVrp$EIegZ=f;!rD$&&EH*)2B-.st(,X_Qa_62qTsOtGS[^F7D8T2.+1YO9efWe%AL:%
]AU>-GYD@d^UA_l;$kJ1)+D:AH3Kr,hFhZ/ca,k!=^^=]A-WAg]ATcDYn+L<E[*QO*Oe"5?\H*J
+:@qV=<ZICl>QJ:E;&jLUNiak`<E]Abmg/"0E)#DBY&!1na_Fe:jM]A3VLrI&14pJ?+4,hm?K;
BusgHuu`fBI"<ihK)HGMJUu',^;g?A%E_>M]A\<[dj91HpH$AZS;'1*csaNlOe!/TF*pPnB8q
E6kuh+N?PEW9fNdo9_fc@.\LTEbLFq[`=fdh-r02HHJQHq]A\*Gtf>u\mgW#&[+?m[B[2Y]A?+
R,46ni)=^3d;KD\ggcV@T99,(ODkiZ(?^PkS1lVBmtL!BlR]A4$?+C.X?G*%X0!(<L9,u7iTj
!Q3]AL'(0Z11FR-JP;B`-gMBbA?WM]A:Qc!`.;RDP#\NSPbpqAc^P:"h-L;j"P#&qRdt*W=mKO
@VK\#AYYQ?AZ(CL)s%s5R2u21s25V*DBArL\X(6oW.egE5m?StY0.p7_l'&ae7VpD32V6YZA
RC`_f`e3[$T!XBXch</p`Pt3HCk*egFg'8e5.K,6`luLcl)<_2rOWSdAbD$'f:B'NuS+D+sh
Dqr]A]AO4,qnFS5IFs+qTF3#!g+[DFu4+W1*-:V/X4hI[n6lT5Ia"TKg<=LbVWgWd+FHZO(J5N
.IZ)JQ-*+o7TOL[m*[WAiS_aVd4iMi,tVtIr+Q8hRb'st=2NiN15oA41f;l@#2*4.I=Bca)b
fj=fHu8';mKJ&X(fnTNH]AdYAY?pIX$7J+W#Sn9gW$/4QhHCi/78EeNa8<tb%&=%%([hbM8G:
db9-#^G,@"8^TtsX)5TDc@o?9CC]AR@e\#Z)If,EAVI(-?<Z^t/(YjW3\\1hh,\gel!R\9"$e
0M%YNog,)<K$CB4e1#dC=YKb4-%Q1qPPU>]A!cOth$9#/_&5&UDUAV#N%k@`c`;D/GRHC]A@)G
(/]AE&W$G)/CjQ&.snlt-j@=5=3QHeC:^FPV[Q:9k?E(2OlL@`4o7OK5&XaQ'ZB$ZeJ]A1>3Sq
&"uVP+=!pXgH1im7\gH2m8(jO+#Z^r*:S$.Yp9HPU9,$Aj4c'qL&R/>\a%bO;Na:9.*-3i9&
FuOi7[YFGg:G+9b5/%W1<:b/%I[eS^3Ans0s!"*SC!i.f#-3Z"bd]AIk&b3iegdl`)HOMcLr(
c1ie3SZBr"GDU;R(e4p!(Z@fnNlCsO2f);95.PV:M2rU(r.iNO-E@[V1_JT/+2ImDldAa+om
Qp^(<<`7YgY$_\"4W1T4]A2,,.FG=R;.b'G=RRjiXr)`d&HBQp'5>llp^)Of<Or)&_aE\?8?k
Ca(/t&bIiG)MhPLh\qdiRd?bQUp65Qs39CF^1PT'eZO]A4A;UL.s*Og8il)K9i>4`,Z>9<Lmt
5iU7HDC=99-m4RM0I.LWZZ6(#h0Hc`>9C2>,5TFuh.J=-haCO"JLV`[k'cq/iQ$ZGJW.BC@W
dMt9hfWH2BU'46_3H_-+FT^rKtX<q)+$(EFQN@$,69SXNfpbg9A3W*1t%ENN;S"hu?7>lTPE
[/0ef>n&HY)Y-na!Ss.,5B:(Jp@6K+qGPXC=4")2cMJ0sfIN^]As34bB,]AoUI_79;5n=topRq
mrV(\u5Um&3AXI.p3OIB!G,jMreP:$9or`Pt^3"nkcr^:.efedTFDULpC<K;rX!c,`Qn>cVN
e@SJ:&Fk:+'i57DE]A3IIcsB%\ZHf^tY4j[([moBm]AlHSD\2S5CX&W#d]ApQfocHf(4AHaRj@e
UpOK4a//N$5%n^&dF"'W/)P!(`6S&?:3WX%*Vs=$A*UHIAP9Nd2-ruDgE!NDXpE1nXmfXD'^
+CJ-a0"Y)V2KF=+Xo"Kk3#cd#YQebIE6`3(hm>\$CTdE.G)oA5g5/G7'hM;#@$=kH/TOOMC]A
r-h37iP\tM9(/6L%<GHXZF!R8cQ2_*>$6gUhT>10gQs2K6F3(^Em8heehI>1qK'Q]Ai3o^$HO
$==;s+UV)06c<^5G9fMEC=/3h]ALkPTU-DC[J<j?Q"t7)@rc5/7/Yk&niplGqLXFYjArmLdpi
+;-Hj*Op7%5-;nXqTdCA<9[JUcj+L\/nLQE3M.UjulbgB7>ms[S+b+]A4]AE;;nfmek]A*Y1]A;P
W'>/q:^VD%.Nc0&ERg]AK?!n&^Kdi[E,.bn''1;$c;`i`a(ec#9`l?@?6qBdWaZJ:ENcIo-/9
FKR%IiCGS7d;ACRtC`c`?Q@C1N\Yh\i!_"hM#^+G"U8rjt/c+>Q"$8djlF%Pc0H=K:Z'H]Af4
ogV3@4V.GBooO5lp$6(#Re!ZURBVi/JWgP&_"RCHd_6,7f1TZHR-frKk]AG#Y!q.cYEWsnT:'
RrTs@o0V;3X$D"o[:e-QW]A@n[@k0=3#WtF?/0&9Kt:4,W0c:Tp'`h>%>k]A(C\SXLE4?W&%?g
12;pV47rIFm0b03l5/ml6bECf%"Ih54?3l$[5\J;j@ACD*nfn<1?+?>6rihrfS@"TLq*hp3e
Y(?bH5kol\aRQq1hiNa^Ud,k-%8$(UNXCep#UPW`p0EYVs3W#=m)3o;8qKE/LPXY<Zb,mXX0
eOQ:m8+"<^pogO<6[/*+1`P[q2iGd;2s_<H\+=\2OZ9a4(F&_;JYuU@38K%&8%c>E.WKplqe
5`)'h;BN.mtEDB3=\Z+dLeXA5MeFVWso;BsFmD,G]A-MalO;@rZ]A#JqLjb0jX%O!bB86H!(0R
a%J0]Am9R/e<Io?IDlLbWQt2]As4DFe=$da9'imaM7d'K9Zo*WZ4C98na'iC@runNF8E:?7i^I
keXoCH;6hI.jpLWcuYi((Do[?-2NLJ,/$qfOs9`b/#=c/cI9Yi/!";0tJGD&G82H^K=p5?NW
*T+f==lK,WHbK6Y@nuYAI_@,86mLP0c">r1Ago4=ls@)EDc8aFXl]AhdbDV/S\lK3`$]A9AC;n
!`uD_N<\m`u!Y*thgQ+TUT#bQ1e*a`jWjL-iBqK[LrBqitrM?d;4h[Y]A=BQC?t1i6^+\T_Aj
(56!H#%A2=-eTb&*[mm';RWM7?]ANBP1H]As5,HP>^IJ(W;UTNf_t*H[E6(pO$N+jO)*H(k[0f
@8eV4C3R]AZ]A_ZjXs*MII_kmf8sETnHB^YO',A-tK1XYqc\/A+`a4Tu,@>"rfm6*1&=.(MRj5
k_a,sghhV1FOZV?Oh:StiTS/n9QIXa'`\'J`Bbtcqn%Bs9gQfH)me<M?u'7!2q0!+u:H3c_1
(1=RqoN@N2;(Wg?MI&5/XSe"Y=;/FAZ>U%WTb2#'fM;$UI\]AnBg^=lOV=aA/UA:ZTIE6uQFU
OWkCVp($m+H:soc>iS=DCR:N9oMZrk!&Y\3DDNc(79f)P.RtVkjR/+J*67Lq4&dY8de`]AV6\
ZMVL@e+\<stTC4$p)3.M!N]AKslNuZ[=Gh]AA.B52>RL/[.YRj(HhF2=A+RjhXnmgX1STi^C.h
MGgMhmJ"5qOlmTP%S\:aV6^TTY/!105moS/P8!$e%>o*-LZS+<#6;l6`K4D7``[r8*R4S,+3
ZW9\oS+,.G;hSST(=,(2FT3U'Ah62O0:rdf':Bqj8LmhicX@;idh$R`1>hquV82Y\(V,JQ3T
?5P+Q6@PaZ"52ARbQE:(Daa6q9?<+2njHfEki^LMV$N'd:^'<G8ueSCQG]A>ljd6Q5)5kbn>g
oW;=bZ5Mp<Jrf4gV7l>JobB7nV3[+G+S.GS3VQ[And6;1n6X,=fJbPl"T.?+gBKa*`\uRHnF
Q^bCV#T_;s"*quaJ3o'/Y4GM$Ih0ZcC+[-$P\K1X_LT-eE4LoP&o7jjN>YDf>Nf9F4pBAO'i
/,kCkiKslG("e'pgSkcf>I%L9Fj9X.,22!l\Vb&<<;JsYA[U9.kpJo;X&)KYGe%cS0Wq"g$%
:cLgB-;rg=m2So??)%r`'^`]A(*`S=?)G!u-/2X/Fj??1_'ed:i#RAW_n8_7t7g!VRS$*5=Or
H47Tl`"";\?ZorhkJnAFeblcd'8Q/#_sp<Vj9#Un?YcWh`odB!Kr/iCmL&W8VCBM?,KW.Vb&
4=84i_2bP9KU;<'3'HpNI0[`o_=;W]AR4[TN?B1-E8G^4Z'i.(r&L]Ap=O+>o6qRT@#Yp-`46-
1V7J&Tm'L2&XRA4L_VoTj\"k+3%[YaV"+d@5\dXJ%>>UrK"_MZSU"DrafRm+_VO3dg[#9g6F
=WL0+-Fua:1FLsL1O0(J1V`;:dQmSpFo;1,"USSna%L&kMuBjlC=pO3E6H>39(Hoi"iA<O;O
G_lrU5AD)bOiV9`Y(P^m+58d$-/WgprZbL)#-US$58[#AHpe3pM!]AD1`iWVO"cI'0iSn.4F*
:^hPG(PFQp&<8L\C[3[O?_YAY6`K)-_ZgX90b:MT.;]AfjdjY!D$Y\8f2#ZcM;F65HQr\)b#Y
Rfp)p`a.r54p81I1j]A)ajk!E^Pm.>A&\4F0QUY31m2]AP)7?tOXGfsi!fTrHRidb6+nHDNt)1
C1.G'(bZHn]A($PVj3t&3@Kum]A93HtrLnWj7A'">@EI=*k``snAo)C"S!r$?OL;X@,o7O/'im
n4h"/\_5A+EC>-m^ulHp6e>p\[c>*d_NP9DH6G)2bons;]ANd\N'hcQkLt3RdG7BR$Q%E@a04
@hHpCh6L/1oLmKBL1ZX@=Q"CrI#jC>7MM[(%FG+loK9l-i3BY%>hmo9YYAC5=6D!,.'K,.A?
>t/Pgc]AX.M,q+o^2c"2u*CAC=Kb[Yt;I=OFV70l,3Sb,Neo9[E8S%]AS:,2IqEil@iCj&SXlr
)-.4+;quM<2B@1[J4'W"XY&G(R";-mZ%$6ee"L>+*>@IL<7pA=KDXbMm@XpQGtMqM+k&b"i&
h^9'S+Z1*G!If#oTW0O\Hf-0,"UJG6:Ikj(Oe$Sr!=$QHWea]Aa:?<VS%#)?bdS&(:ieX1eCf
en3j'5NT@heNcDpJa-k\(d2R!FIi[*>F=@[su\SFUG3X__W\;.%=6,gGW(`PD=Bgnh-Ms6gJ
bf<sj<-K4u1(M5'U27'd\A@F!^BFl=]A+oJ'Q4)/VbRhTA70Yi#"B#!/G,s)@re\o=MKdk3]A+
cf'O!B=5CW*O'0X;iM8>geGZ=HB'o(nI<<n68h3ib+8uPl-FNH=MH+I%#%;jMI39Ya-BE/Xs
KQd6L)p/_9@.$;;'2+.e<))*EpXja1DS<cCDtOh#QZZBkOo-[tf!]A"?B,*J9q;S)K=YU!cp%
_A.u/X6\n(Q'!KrW@Pm0:IgU(aS.4=RGG;9`0<>*i9h#dUob)W>g@s&P(\0*d3(:2_[ed4d@
u[)HnH9`?Q[*R(3nGo/&Zb'i(q"<=`3knU<AK>@Xb/$QeQ1"f*T=)-Q/RI%8Jb^CG7;[dJkU
CZO,>j>VY-8^i6-uAcRc,IhhW.Nc0`@"ikh\<hre=X=K0!q"rXh@K'VN<?$7Kl>'"[(+-DLG
%73s1pu7a#AQ^X#J7T/%o4O*]AolQ!Rg7RQZ-s"(GQmo<1B1#+-*[)\SJ&6uHX!Dn!'l6#[Nk
@2`QqRX9VBh>T?[23aUa1ODZ7'9t,)bdtNli4%1<aTsT6u?=&eo<H\UqA4r;Z&XS,N=IrHpC
h;u(Vd"(=[R0KR&nI_dEGqHJl=<BQ.6%=]A:0p"(_'48(@"]A*X\.M3(o4kk7/^fKt\G(^WCXp
'nbi#?gfZdJ;%en3-UVl11?HEE>ZrTS/jR+'m@\_K?CYhj$N_A&muQMc#M[);;mF11I:*G^1
QfI?6Y4=,")5@'mX/d\NXbQ-FT5`?rPJ^o-lfOn>F9jr'[XC?\f^5%'u]Aq[mbd*JTO0gf)VD
pQ+2&)GtmDFDlRsVFr3oc)i1^/'-C"UTG=Q2&3Ss/.#s2_f>)XJ=HZW:d'!bgW73gDT2A_rI
G(\37gcm$0^GQM@@>#FC&J8Q-E<pm0&J%gAlb=PL*+p,'h#Ab@t`F.3Tq4ojZ>357?'F_'^L
jO#RF#mZq_e=SZfQl\7&td;rl#(c*jG,EJCJ,#mE;qb2D$2*d@^>*7tfb'Ds.8=JK;RjZ*-A
`EB1V?G8rXAqE$5`F(mV%p)B%R;4c:!/67=#:+,!dZ!\B,b+<_LSr[a8h,?I`>-M'f9QMA)u
FTp*(h.e_P7"U"hCfljk=i-e%a;fF(7eW*t)1QVO&@K7^j:)!9I47dD,9Bs8iH3%NtacVmF@
?LT:c/)E"V/_^g1n0X1fNcD'BVo&`iMCbU:CeHN?Dj4E3BDYZhS>*Qh0re52Yd21GFF0F?-6
_TRNb9WAk#>O\KKK=0:oP@)!A*os?QDoMi+%0I1K\Tu5b#H#?UKWooFj7B3Z>&@W8TSgS%29
S9q#./9>&?Bp.HQN8Q^,1]A4n.bpT#Wdq:`RTYl)c-)WUsmo6<?cIBP@#'_SDp^%m%Gb<>kQI
(8(^c!Qqun1imiauu"/gFK_W.CFTchFR=[`h\_PH-HqV"6AMD5OfL]A1+>'4aiGP<i7U'P@qX
7mi,ek?1jKU:P+,hdWNXIO8S5aL>8,Dm>b]AsY=m@W66"&if5#ToX?ZE]A]AU6fbu2j6<'#>hcI
H`,EY4cUg*Qg-!(MgNR(6Xp$d*13[UH*8sUj7J6loQB#7gdB=6km\r!^=QV#&\BSY^.cJFa$
<_cFnKPYQ*%=l:IC./de,`?J$2NVo4+@e01T2NJi@*Vog?^U/*eF$ltmV:f^hn>Fic0Mle0-
d&_4`Fi5_qmP;@]A[fJ$79\((DVRnH6BR6#_dNl&5+,0[oR1%$2,Vr:2e^G++_PKgX0eks:c?
39n5V`Cc']AdiI;X<>"A_ku;>[,8]Amnlqu=7K,kF[qhdc7bb:fDA$K+.WJe3R9PQjZp7.okU$
::>l@]A9n;i[m,-"7mrmXK>T!2a[Ek2p6B5/q9?3WGa#(#io4@05,U.EVq0]A7MBj3j\R)GR)'
iP9NCbH6SJ;.Chkc""6A>::O'lFX2;i&:hQ4.]AD')A!YGH!&jiqSS3u;hRiG2i.!#WeSK!30
`+sp!.fXg/nOV[4>F3nIL]A**KnCn#0$h<FF!mMJZ<Gp?D8n2>4gCmPq&keLtEa/$l[Oka3cL
/+/XrTFejhtM4`\HTJN_+em)Hqb0ocKQsVD9[Mc7-TA)Ern-E%?Z)ZkuG]AE&2EFF':e]A@5tL
dg(p.WCOsi/3uZ<s6o54@bd79q+0f;urD<,Thm\@]A+PuVQG=MTPoDF<CjaRA-S(QddC^S238
AG=>_dYo3noG)4n)/e[SYL2Q"*G567Rp^FWY(eb_+;PmK0(mZQ[7khDAh";*:lq1Db1q$VfY
psaa(":YFdldVi@oafs;pZlm@[-n,Bc;l+u4bc?6EFU)UP#Bo;8#G+)[R"n_hY`_8_;=h"8K
"l\qjJ8_\]A$`tH)slG-[A$j-@X`%K4]A4`mB,lfUN*[oGM5$rq6+C8mn!YRnEN$Ea#g1tfd'g
hm6:M^<QfAX`8dtY6t?=IAaS(#dX]A2EHWIu7bH.>@dniG*>c$.?X0'1Mj]A5%ld)fS^Tp@=^K
VcA9Qk[,]Ae%qP&/E'(]A"t.bd9)E0#ahk05Y--YW/<nHGTo7.AYt[]A000/HXj9K&-q,ZflDUj
>?k'&DNA>/ms1BYd8I@WS\Ma3es\8g4HYZ9t!`l_)gUOr83"jHs^H>V0KN21CL?05u'4)kW*
:8AB'%\'Rs0/&@7mBJ]A\2R2HXRu"7/o8mZ)jeS,(hoIIdR\=jP4%Su"3j.4,kdlcrGfucG!]A
F8[ZmFuOJ5)N]Ao(p<Pp4)u90a:D/cIOQ"K,c9edSsgsUL-Q9AY5SFQega!M,qXD2FUmdr,J\
Y>=4GTYNaX=M:395ke1ET5hGc.5LMg<)[%#rgD2-t?8mmb/K*%uIf2bYEjD.,DZK"n\5>E>j
3`"6K'H3bOX<j$7IHp(;j'3f?F=0I/Or(C&QZA6"Wr=+-7,7:8Z*%#0=cn-.6._64I\8#(tr
0)rj,#9<#hSuf>/A'EI*A"WQYjbr[62'`X.eZ]ARD%3Lgu6gdu9/"kU$>d4#<)EdsM3DU]AK`5
)O`_;<[DN'(!bNuP7^:`))Q]A7Bkh!Qn.gj`jr;DDZ2E^mHK/W]A;".ETmD5@)LPlKoWrBSI[&
=UF3D]ArepqWJD'IQllAQP+mos'.B6Li$drGV:3SY$]A;anPZsoP)j\Rl*?h/#ra=A,b[J@$ji
rr/&Z7f@_m"A1aT<SD,ak8B[LF*;8^L7?t)h=me:QSrO-mc6@Sc-@#70-#%gI6C2<`qQ?ejl
g$)qS?6MTBfBV&J6<VTf-D=Tf92c52;d#d_Lg_><R'_`!'A_ACoWLVq&^u=C<0Ai"S.\H^OY
.j*ns1P<RD:-PgtbLZb"C!a\fOe7GdK[5;dB2aKL&N\!LK_>,r8qM4\!/&i-Si*ku[gN(jcI
*I=;IkY4FIXadU1UMh\2R8\nr3Ftf2Z!9X*)T![t4V0S$MQ`VCI00b&O5*_8j6'm@7,G&+V=
2MJmErj(U0\uV`!'(b2;&nY=`78Njt>(4?\lq6$NSBG.%;4'X^6LFA.4=jFi)OjXS5BKdlW-
:[Vm-:WN6s<I]A*-$k\ZV+WW"eB"UrlL`[qDI#KJpV_^?Z*K;+Kl]AFUQ\G;8(Eh3m`BJlhTH$
&dl@KOU;D:2taT@tkJ2r^s1LUcED3;<8S;=+=O=5Znc28m50qp_@l6I=LE_Y]AAUMpoRs/<j)
%*dqqLk7+9mM*7aL-r27g\"8Z>@=12K%(pJY2'D;>hP-0B[b,u,0["O+\h;'V*%FV@&Xjhs,
FG$q%96Z^F+Pg<I/\0B:F@_0Ddbd7WpCHuc^%\%bqja'_!g>ZH*]A.fRoXUi>7AUr]AUqF7Yie
gft_H4^ikel1sU]A5&m:$_a*?I"P$lb+o3"P*9^3r@UE%j[,g'?jH<a=q\bp=E:7heIu.2H?=
p]Ar`7J>JX"F'Mjb-jk0bM]AS(D""",2n9K.<YpO;4O<J(V<-(%MnBCYTHBGhqpe"92Vs6,QiD
WA&3h!r0?=Y:`O;MZm+M,:5cNOPagrHu;:"E/MD@fI3pHgXeR'1pj'hJ)R0B]A8@U%t<q^P-]A
(<5$"&P$cA1Kbo*dQg_11eJ(!m,._N#tGldmRTW#/^m@6*#]AY?te8:%%i/+.#[CAB5LE9mgk
2mc8DG[O0(ID2Z!7!'8j,%');\,P`:[3]AV(buCk&0NXfk4EIpp3<&tYa-I"`gSDjm?CW.6@l
+H^SR2p.D`<+,;-nHsj]A-SU+IqGXg/ID*8ldlo=Z^q_0_P4-[3Cr%2lFR+n,G2Ms7nCp7Om/
#8\s3Q,G>,\p0ThsV#@CnP^UDuKQ.P0,oP]AZ0HhFA\7SA_:@on5qKVs]A,%17iP0dmkej_CFJ
g$&KoXs.%4Zh]AB_GnubA]AYqQ&^%q82_@$tM@-[b[51Ah<juNsj;d/N<2rrf#B3:8kJKa=Pt-
p^*1JO#TfjRHCI$s+bY'[6=Y6Ha)*`s[`)kOb[/'3HbEE,62*"ErOH8Wt$q9Hl;B>ct#$-0/
j:mR)(Ml3J)#,J2=&i21lQrF[X%7L*GKil4jNh0&/MQ,GF*BCtRm8*J&%76'2ki3VLIi:$,o
\Bk[;cE^PjJWRYC'#\rq24k6n#8&(Hu1gR?l=V:qm_k>/0>#cb0AUo6bNUntOhicM4c[5ec'
%\o->hWa[%6.mOeU(p6JkWXq=*"6;&",25n+C/jH3CE)]A=\UJN\XE$PADj6@sKkns9fu3X)"
!1^JXBra9I/2Tf2.E8=H1$uo?AU8cED(i6YT`QqppLq&pE@hSBJIar+e]AWagY!H,aH5Imbd5
njQ9XuS?t%K]AP`ebr?V]A(U[R"nT*cY>5gOZAI]AiD((A";a*eJBgFMP?(F"aNhQXG]A;P7)f6Y
*l(_+B^+3[FI1>@@?[lo$eVSXW7O@W7=Z["(Q!PU+eC-K)&)n2)OB4CUfg'mQ5o`m9LKgJ>?
I$_)((ZZJ<%,hm7ZBoipbD$"`rE0Z6rIWKI&TAW\SWYc2LA#XBQ"B5(I/Qh[6j(6fh4jqE_6
`Bj$S^?B:G5O*Vpj+I^H`>[*(2''An=Y@m[Df`i0o$.AL]A?V!EZgCT/G9Y(-1Shm<Oi]Ae=90
B%Nr5nPM2W<L.VDQGj)k!K@kl*?OR*M[OcI@5qbO&`7c*tObOQ7(bGC]A^^OgO`N3oq]A'pWEk
Fc>2c>'s"$M&G""i.gAM/+L_D+mpWl6IU)?%r3rZhq*c(!*N'5)G,uNmX1hpA(eAiR(PlK>(
hlg]AC"[#seB;1SG4Ub>*Ok16WQ.sjc5Bk,mJ*Zn>N,c:,N!PCmjEB2LN,U;[Q[Z-^PA@s8fl
[E[>uS@0aNachkY\VPXKR+QG0Egdho8UjXA_DH&B;Z`68<c(>UGrbTahcpqHikOWiRmh0gd7
JNUI$ObJ;W<h\sdqSO50k@Qi]Ar99FHS)Br,Q@A*L)Ed/HqF.m:JmZ?CPEJA<_-`.G4*-OefG
5randWg2A)9oD2nQ&Y;F"N`,N"GrB>^sD0=IJ/qdsR/'F;+7UjSbTM'2<O0[Z'((*H9rRL\R
h"UEbi8r$SC1+Mt)n7rEsXN%FiX]A7i#(+pLWqIl8$#]A>_L4X<YSbA6a''/5D<XQ`o<b:DPi*
H,f9!fDpD5Y[H@qU^Cli<r@pZ'okLDRJg*STeZ$M)H0(4eE)$P&mFIOk>WW4=DS$PMoV'9QL
iN50@pUg-!<+mE"N$i#:5ES;<Rf5d=BENRLUD/lSa4CjJ$@=YH;qGIIi-n/muHsP*H-[%"4V
:J[Moj;\A6Kj)qA-BI^YX<cA[*n>L$Rb$`NZ]Ab'SWn8Smj8O.+g.O)sh(&(U%VBh9D;RMfsg
p"A$ifKk]Ard@qHV<8p>B#KW0\_ij$,e)XkURp5"kW:^@B^\6+9C7$.B1i!KaKtsU*cnPUB$N
!6'-"/9Rbtl_;bMs[d$&FD\!nkqi+0^F2ES.uRkMMcY*G?bo'-;Uqs]Al9^X;80s&n6hPU_Co
h*G8bR)kI8SqoRcS$&+NIbR#R?pPhtN]A?A&D#^!\)'njCR6hYcnTgqcJUu^=^hHjS#XU]Ack!
k_k=8%%\lhGrq`_YO0-Dd[WOq^'XmWf"0*iW`(QQZ&-L2VPmeW8N46AIGZjnKMif$(h)!h1_
d&isS3dCZ$_3s)#g?d&tr`+q@6'@E<$M)0pgGFJ2l4\JL2o(pf0PXG1%HRmDq]AMn\TPUjl%6
5^N\*KH4%bB0V=gdFD\jG0u#2Ni[iPD:J%oIB%bIocBqa*84B=7Vu]A3hQT'e7WYn&Atednri
H\W4UDPZ;SK1XEn$?Ha[IG)9'5gbY[S">?gFF21aat9(OMfI6L5V:aK^&s8OR+5B/s*03_th
qMRjfq["l+#ON!A0YloE#n4S('hFgBQ>SN=."8n&.a'3n-Zq[f^ERZ;jqbpVoRO!(qXqU^NC
_KjftODNI_nEh\\qtnU8<rTk)'KPRT(pSS:Y_(eO2!gP02(>]AudODVp=dC2PVA)[J1Q?UXe"
1$#&X9QI=c]A$D)&L!mY,qhV6h\+9;<P))\olf(+_qhJ:!AEh`LI@qOaqb'rk=Y6G*tg1eoJL
"_7ATkQ#gO@?sqZIA$mJ?KtXC:/c[rQ=Np#1#Ef)b8JUfRq2(&&)2mFd@lr1B.K!?>l)d0)P
#(`@K??7qO9&j,?OI"?If'`I[BpU[E.D"ZQlur#ZE4<O$WL0'RT^+q]AtKT21b-k'M`c_i$ER
'c:0.(&Vh0NH$;i'05"o$Ddj?p-%/Of`7,"Fkf`^lgG*%D\icNBpqIa$/kG:*lgV4RO]ARR:N
TAloU[MB4fkc8d<45t`WA8l7he+nhqPAO-]Aqg-p`U]Afhc]AHf-O398fF+m+''YAp68s)\=1d?
'96[:kY=QTeGRun3cIm^W#u/-e/8!g8R=-*A<"J`gqlZE4%:eDp007b]Ae"R0um5@'QFS7\QN
P%rol.c<)1kP/e^<m:CiAP(keRoG((\ot&56inRPso^]AiqNsG2`VlGq?^p<4^8<>e5)7#[,W
.p7:PL;YHVj"m#rLrRgjj8<(RqF2QtO=UCFr#IEDN;c*:G48?rJUD[6[K3Uo\IqFM@7*Zdf:
hqZGbo8OcANj2hbUW1f@ZNWCb?N7#H`9:O"s$Dt^FW">spAjYgNNE.(&l*q63\:8mN4H/0g#
^kEdJ@ZRbjT?\M2bZKJH+n")u*Ui@4nK9<UZcEGLVOek,Bih\LSpp&==K81#0WY3nr*S=;q`
K1bT;4.WEEK@aE,n5#8Z50`]AGRX[MT?X$.=d>UG]A+F"R5-:$F!rl]AAo^Wq1HjD9=PkH'PhBd
Rfc==+-\C3f6'G52>Z4chf<u$ZQBIH[\^5%o^RDe]Au^^%Ia/pVHO:N]A[mU2I!iFu9r,ZbM/)
&]A<Doju:.LQa\;n,.rcLoG_^:tW0/-tNr]A2P"X2=bEN"0CsH&'%P$rI&@>U&)U/qPd4iJ"%B
fJ@N7-upc'WKApgTLAn>Eo)(l\dV_iX'4sF(Wl^gFsJ8[Gh\f`GVSl%D.2PBULqFUq59GlVA
PV&Eo78g4AnKb/8(TfIAGZqdSsX0Gi51SeBIp4c_n?,a9r<uL>-haXfmCeKh"FMNOAdL/bG6
efS-5j<[R;Gr`/"GGRMG(pL0pe3D=)[$TIUO$8d@50j,rILm534Z&.5(>m,oK1g/a-'"<YW/
<tadf5gmEhk0><nY?mV`#Fi[.k30fIr/,hbuFC#]A1IqnmbV/cHiH?#f:3eX-]Atdj0-Bu<.<@
j9(eo/_f`B7rRlF\?FcY#%OQVmZL+o7Q#[*3fPpd\!HdesJ]A6H-[#H0etS0u-GSg0uC"c?U(
[;eIa&VPm5`kj:TT&!p)d*P1\a\HW/T+8tLBU.f^e)">p2OkHCIU+L!\So%,%S6\Lc-(!KR3
SI'oA;+0=:DlPd;Zjr\jMnT%[0B2l>iE`Td@C,M:`#sr;8J&#euQedP='oksc\c1d0pH6#C6
%V!X"5!63Zl`8,DXec-JnpCm4Fq,-I,V.gP#0/Y8oDXq/$0I>G>hDj^P6rlL`T("G)7E3apR
)dM!Fjt4YCWi_Rg.S%Q<@ujN$`NEHmm"EjEU(@j"*>8W>-6<ZiC3!?.-15-rU0]ARjui)Q&%L
AeA^9!+H+[3ZV$EYS0k!OM,3f"8''CNNTjh-1(VeHB@="$f(+4(.0F=*@,.uAtXAoboBjEb0
V2An&"c1b*:1!(`I5@D!aH&_AXY:3g^ZHDYb-O]A=EmAB8lQaFQ<a7\n'?0n/,qUIQ!*I,>Z!
[>XEDXC(+10r&,'Ua1U.HI,7.#oG#.+LJ:B0i/9I_EXL<UDWP,FK'&ndgODmUTn/Prf]Ah]Ag^
!,<g;AB%-gD^_^-8-003p$tJ;1O+3+S6L[I$TaI@o'n(_4!)YC+Rf]Al05Q`lb0BH;O";;6Oh
@]AsM4;C/R4RrE?HOJO#0j./Y'$3!ugI&7rYtSCB<+lZU.T7:+)"P1b3@/*4d69L0T9rb*-OL
1-cN=FOT_5o4]ADrV>R9JUpNNHoKJ+"n\MrYe%>:Rl7=D./S4DPOTH_%W9S-!4f>q_.f<1XtP
k@FbR^rM1*n7$p_ELn\6T5uR`]A4S)!rCiK+_]A2,T@Gmg%dQ-[LnF\L6'"M(4MFbCc)pX8K3K
m#rORB?>(P;[Zh5r,gasfn/j0Ti_hWrJE<#IDtM5dWO8"g?q5)Nm_TaZ4@rasn6/.jXdK+4+
GDp(e,Q#,W$;<Dd7=6j/:h^0U@4>=Is?0q?9>`20foKV1SqOl5bI5q$7[9i-BM($+&Tmb:J=
^L1`ARZ9^%,[c>FIlB'=V=u"VrFicqTiLfp_#7_9UR)EM63G<'Wt(0e0"/H1_XG"bEu"m=N]A
gmc.(^1[CLth4N7$q"3M*0$&H&!+\iG"lCE)Y8?[0u4=7!c.jIETG5m!?-k!)$o]Am!^3@BBH
augTg"rbL:otiU4>=j)iD,a*k(gZp+<5NH=:rR.kU*,VXXEI^@Og]A^hj'lp.GYb[tb'I:`lE
-0.;1c2-.A:CX4Q2qDj-MTO]A&q+W'!\>_'\PUPX?HGr;I=8hNmI*3XNiO7">-PN64'RUL0d>
./c41+0+H@6n`YVSXWfAd0K]AOTPQqWb`pW9s_HQV?jV",EQR"0!L_R$"+he\H[R2ahC#*Ke^
Ena8J@Y,eTAeZ7$o"]A-oI.j$[b'%oVrcR<*<%hWq!T!!eZS%)ns"<h6ou_iEJIU*@3uW'Q=4
iQ@Q3EGNZ-/1QaQig;S;SD0]A!@q&jZZ\6PLTm04I_Se+W_uXD<+*c2%,c8JOQMkDC'^?Qp)K
RM^kjnli;+\kb?IW.D0uPjq'22?i7#/dA*nC'[Lc74elFc]A:i\E'aujrj8iU?pT_J)T[FFP6
]A/Bb_$Ufq'-_PD?5fd@3&MRn=Q'**u:5L4qk3)WHA.)Z!Qq'cAH"7X;#jA:KQ2ZLIeR1pHK-
jf+4UBTVtH:eQc6VaHm<JIB2E"*Rc6i^(5kR=Ya,e-S+1,X)g**VN%$c'snf5gI(I=Snjr"D
m)XKIs^?=m055\R/2`>X?;IiZ:(K.fr1&\qujtCdC!]A6V+F-%cG8BcSgFofN[,f;:R$YR&fE
OAo1<Rm-BDJ[b*n4>'T;!u$mWG@k=-:)k/MptGVL!/F29m86e$jnS2r(_=!\D]AfXb-fVCM.2
nnPGTg)K(`Nu<pJP>`^7Ibcg=LX?K-kqZ089@k7IWH_L!Esf_p*Y2E)gs7SY\m"GBP\FcZ,7
d,(O%;rL/h8[P1ldO%_qCarma]Ap3!XhiA%G=m>\Gh=ddOVA7[=se;EgbRKQe/N3%tL`)8s*G
[#JN(mem,n$QI/Wgs01H2%%h:DC=$7a2QTP'4q:U'$m03OVmE[J]A_b&-;8aqsIem$Mj2,f8!
1rr(P:OT`#c`O=P$<sjQ6mtQMt`^=]ARN!%FXANX(aU1r]A%$2F&;KWF<TXVnKr%L,`B2VgUBE
FJ0k?hMQL:D;k'[2Z"kGB[]Au=TnY@=hV+7DqiG=($VYKqC+rmN20*]AXEeW%\#9k1-omV0Vsh
c*@#mR<6(sDQJ<)pqGAEcp$234r$^'&Ps=X.BFIY(SdJ1O[/5%jlQ>84CY9Xqj^i*2;aRdkg
=$+k[1+t_$)EAM&i^<8-Y&1'SX7qk-(.b$$]Asb7T]AI<1&(,5%SLCD/p'XMahMGcqP_`CL(a#
WTH(1`Fh_,N,S`#7E_()o\9Ds_DPM'RKSe0elEn?H#-faO'#N)h>bA\BF)OLWa<+C&KTeV@_
)bNhdE;"dbauWQ&kTd5+QO@Ybn.o5QQ>_g9qXueSk)`qaq_?"c<Wm:c@G:s4g>pSI*g-"2,f
u>j(;=c]A'26_5020[k3*>EWf$e(4e'>b$V%)p_iBR?#MV@nQfS(C9,li).q!-WituaIO<Db>
0'C)N.B!iJh&@2D'!#Z;3oDOMl.cf0fMhFhe'JHhrI[ki)14D/'-#!A`dd]A'>iqaOnc!I,3b
L8WSKEu&?%YL.;[l:\,>&8VbKQ&.oj(U2rLIjIcWpOp?:RJa.%,Y$h>_6HXsuYunQ(Xgj6K?
$2?O$^D?@/&-N9uQ?V;g,J@k3A[dP@9a`,hWC8qCo(AJXGpr-O!q^9>pA!-eOl6$+&-3U*a3
-DA=.L\?MgpmF5^XbX#SPQ7kJJRYi,At/,`_4dLm>fT(`RV">Vr;a(<-Rp[d<SYiXIiWPN#g
.LOc9Ef8Eg=/?d%`R$L"f.#aG!,g[9l*Tt/NYD\3;YcsH_...+TeVB-S6?CCed"c\!$-!_!/
0<i1`/-Tg\IY?V@>?EJ3?uJd7jD5o?=/&P.LQYQ&Nd<R3gaV0Z_&"0^Mt"CVYP"+"Aqe?Q*&
Hu7!^D7;\(^8@"T">^#,dD%O$(%s!;Cfor[;g/0Q^3LLJXH`P.Kf5+Kl<j(=)BUR#(#o:R'c
Gk.&D!HQ1(]A5AQR/S+URNYXBnBMt4QX]AVoAb+]A7q%*lX3m$'Pj?"(LK(-cH]AHHs/NZ)38#>.
O=;&:BY>*#qSX]Anj4_Ndo<gg<g2Ye)X*f[&qsbC\D%MI]ARN\#U44Y;$4/<9;tMH7*m*o5ku;
ZR\6HU]A3[l41hA!+1N"4L$OYY-@&Yo\tO(u11,J<1[0[2A3Hhilb!6UbJB(E;SWMhglgMLLr
(jWesLW:d3QLW2AJ&f3k^Bc.uPSk(IG8J2,,mnq3JX6]ABH"Jk8;Jr@'4Q$r9.R\!BAW^G8>;
H#0mUg$RT6B&b"KQ<^D?W`t8,:FqNNUMn)3mc(?k\_Q2#1lkH3,?.1F+9#8`.1#d1FEN$?e'
oCfJc0"p%)U[!PhA[eRc[cXng*Y+fPd56D9qK-b;cVR3-\!,M*qs,&$m"%PfVkq,nS_3Nqc2
6UQg1mFAQr<HN\YKZeY@K[^I"U"HF0%s`HI>jqqNpBs[g>d\)]A,^i$+]A5cJWQdI?J&8BH+nD
;X+OU8e#g7t[\t1jA9qF2]A[41S,+8i`@WmP.:1,,Aq.T<j9M.*ZGiQB0fOY[<<%>eM'^*%KZ
qEt"AdD1HlDu^'*Y?^jB/_aQOV0.7O\`:Z3KB@m8]A8gmKX1c3p4n0i=\afP!^V@JjX/-03q(
tACAZqMSra+fU30d$aAQ@QRpt$O;estSJ`.C1"Pb)C]AgDq23=c\u;VkQ;S7&Y"&D24*?KJUS
EAs\([$#`:Ln+E`#*Ck3ueM1N3%D_37RiTR&UisF\dSpe#S3^\uC>jFL?`oce'uSBAd&ZG<Y
7Ok4*1XU$mA+5X).q9S+cagB/I5dY#8`G=m0Si4B6kZU4<Vs"E=\0j<QNfqs%=7rZERuJjOR
Hp4t&W<ZBJ.J"JY4SU.Uq!^.X$`,k'J]AM8<!J%q[a54p<GLrMOu42BH"E_,#s9kmKd%[YS6G
q&j$7NEjND=E,^\IeATEIRS_X)G<!F;BGHbG!8DJf*##OTrM`h^C5Sn_q3dU1\j2[RuhA)q0
<i@KkO(]A<>Sm!E+\fpD,m`j$MF#%Ebrh<q$i`sfa&VN_1EtOCq19,C=IZ7n8gG^SoW7C]A?N_
?ho#IIK[DJ_k,MJ"#3aI[<bA(51i]A$]A/[MJM[D##No$S-!Gh/O"If5TEb5C\.F%n-n$/&/uB
RL<F:.\a?.7X>3d`6g9n!-o1&2D7l?Xp?sT!Q@$MJYf=^:tm+>@8;&m6"Zd`Aj+9VW>#YUe3
iZbsljSDt5"@4>02SASpF6d"r.nZk#Ge5drJt]Au9Xc;R$`E,FC:'C-4**G:^#,pRGGi2Cof3
EUDj=i0n:,dMp&&fOa(]ABZn=]Ap)UbgN1Cd99hS(pgK1N3/nb4r/S@$T"l!A<cLdIC3%LgQ,S
t5fhq*2WZf'^UKYFK/Qejf,KJpi'&P$n(mR,+mh%fEaW\3l@Wu1$fai!JPaa8C&L0/N-,RNg
CKS^R!g&mQ6h-u$#gJ!=:X`OCfBj`EOngH$Rfk`19[^!s-mtUQ&,,@L:cLkMW!ecZk_GluR^
1j=Fi"2BU;FZ:/G8N&Z&0;sf80Ifu@FGQZ1kouo5GKfg*d7te7r"La[ZS?>AL<_a<k/Z@cnD
-7/>jS.A`70mD:'/8LTTT7[n0GUG05tcX=')-1!l2:"+/,s>sFo6n;Hr+3,Ml8."kolQaeCK
\HCb>Y+[3Q%QX*AJGE![0.Dh'3eA1\;&^?q)S6u#jgsjU]ACj-Urf?eTZr?<\0'eDDTq!04/B
CH#[AJ#u@roC+aif<heZD$*p;>\nKd"ik]A)qtaGR!_^s2JE2M5UYjGX:LbCXGgP".,_O\>'/
64mXQsJhnZ[Y4UbS9XiGdo]AOkbI$;EGHkWr2)b\AmnqK/=,d;0n_W@Q2>B8??i%l^tWjQW$)
Xp9U;IgZ"i^5)!i?CX5%/L9'BdHtf"m$7.o$<LY:t@NF=ne0hJhfrHk4K@QG1#&\hC&R`)NF
EZ%s'Zq.Q]A9G-\(hslrZm;]A=Hso(sW93j1F[UpG51.F-j&Aodf4-k>BHt%Itj/a%G1S9R=i8
a#1WGMmuokgt9sM[IIk&]APlCnlM9-\kKH#]AeulVZhVen9ceDS,5t<jJWp2F>nfA)9f>I@ml:
jnm7P-Li^*Y@8B;j*.)N-oP+17oIs!/H2ZXZ5Oo128b@SY<0cT3n!G>:9IPh]A]AfL*GEnE$d;
SgMqX*D?LP]A)&Q4Gg@!FaR[V0n1D)oGnn.hr-$@o<j.n?*hi):nq(W_Crn%h&[5$di?G<q5%
M<cK+.)%CRP/E#6h,JFe[XMe:IH'7AJ@L$q_sqsHG1R6V6NA*))pO-,,!7k_EBV<\CjL;l(5
iV"JoEPB?!=o0QUq*'#V2XRn+)E:Pl8<YtdFNDfK'`Dm5q7<6Q3HX)'jQ1oB&BJ).[3SY8s%
]Aj7@0IU3f9A46m+@"'Z=aB'XeceeN)HAL\:GtLHbjlG#(boZ#I,Y[V'c3ZB-'(u$2_QCT9e@
gl:Dlmj^=:<V`gIH*5D:oiWaa9Q%OQ[poR*KL(CEbEr\;.aW9>Egr'P3PlVG]A'5KM&U<gq,G
0D%mX-<K8CHo3;</+Ku+N<Oord+S:,<l0/;"D^X>6"K/lZ\0jVI5ZidQ*oKH_H@GOW6*T`#0
6H92Ka9a3jHfp9UnrU)O<7c;mg59T6YT]Ab4BM,hn4#m!M+G.:k#K8Q3+TbTl!=W]AfPrF-UJ,
ED@kmh&B0Q!XY@:NFi^,UR9`cR75Z-B&qMa8Y8l9Ud&@F`j3n3t\_K9I,ACN-mMJBH[_^BPI
l-.U/&aV,A[@6*ehq-Bb.1$Xt1`tJCU`c\rR2k7?"6lj\(UHT1(9rY)o.<$b7^iaHIaZG.d'
^ZEQC*WJKWsMt,a=[K[-e\E-B6EH2ACc!7WnUC@>`rHL)@Ws.eUfh=D%k)+9/Q;ZWkZ.lXIX
HQb^?G`lWIE?Q_7Bn75R^HcEns]AYcf^q;A,e6.kCeAF`R9Q"&3RGVpgeF&(lhos;&#(5]AZ`S
kQp,CdT=O`M49B1r@9e7TS7_Feru@$]A-3#F*s#W^>f7^F$m]AlCdq2p[W^dG6$l[[eA&C0-Vt
=[lJij3^Xq:X[H;LLV1C#XQ]ACB)e'Ke7PmtllL9cW^FTRRI)4N'EQ""N9Lbf&$R72uXr]A)ft
PILjTX@F?-*"O)lDJNTN6$AMF>B>#okR/3%JkM>sp;nh"[<!@?lg\@@@3]A@2l"<':mfh#Lf"
&n(Z<jc%b_U)74gF%3`X,1/hK6>1-_PYK_b;/C$`!CH+.E;:=LXBZh?_&Z]AM'g2T8_9r/\YI
3[JaCnWh5CM&BC0X##/G5pT_,Z41e:i.Wu%/`gKXUMjXo,4'$Q8N:IKU9d,o\k=3k>GqK>fp
SXFXhP&8XS_2b-im#D"0SKKr=J\oRXSD'BJj]A0rP58HE/*_7_Oh=)<(5ZYrQ$<Momo(8O;RE
<^CN21G?V+!+`VJ_41Gu":U#S8e8BbfM7VZ+gs3L/lA-'KOhI*b=(#[2Gk]AR[MH6kCrV7P0E
k-"1LYD*mVs/UJU4e@C)LTD&%_T,hU/0;@"W+)]A=n'd]All5BW/FbUMT%`lSV4Fr6gMPWg27_
.H,s&IgkVb5O#BHP)kc-R\AS2G?R&<I1><7NStB2T=#IO7&d*fZ>5!?#W1^eV0EZ,$-JMWa0
Zppj6mF?8>I'foi"g\aAV(CKg\+Li8gs54*.rAm7tKsZfUMTp5HD+&Kb<3jp0W?<NIN-Ph_)
m;Bp+g!*>U:C9+"Kq2qJ[s*6,?;/2OgK\QXQ:Kj-MqZcaD2$7ob-&j0\/Xm`&A1UOgE!m\X0
Ta3\rc:>bCM0#hW."GduVs(5i0IeSEZ;C?&;DU9d;k+Q$a%\B0L,kR^!`?8;&UnSm$F=T6<,
"&H4B/*.u!jJG:l>Yc[9T:iS7HYI-Jqs>B*b@]ApX;,-@]A57dUQ`V(2PH<["ncbFFO\s2I`lR
Y>!Q)'"bQM[_t:FrAp[j#2>">'Ek[1qBjnC,.e/UXTU9G(Nc;n5'1o-#Io:#EkqIeAPKT4;>
8Epms78<=[dL)p[\(G)tI?Pt'="?15k(]AJPW-S)!m[24t"Et1Xh9h"c?4#]A\lF;S[-:r5F*n
I3f$,lfCTBl<Rq#<'@q]A&a&qq7ZnrLW37+eU-^MS&`\2(MC4]A=T>khSDV.&QDkX,[r@:SFph
ZLG)tWh5CHXr(jI%.W)n,5G.N0G8eL\M/_7W$.>2pF<=Cr8Bdj)D"Y`oCi,$)^&$JD=OfB5'
9B`)7=eAk3M$UOUHge[H%XZ6cQkel-;)VrF>Prr"AA@P,V/Ugg?R>:"f_Mq]AHhSB7V'AnN9d
KBHV%kRH'X\u%R6Zk?mCO3.p,k81qrk&;Rh@%<:'?]A#d6+Qp&$Qq8I_;//T@]AP[=.IGYiO3P
\TKb[!.Ge/Fn/\7G?Rlftogg96Nf*kS&f0,?-;;E;iL&:j>[\1iXZugZVlf[ObTR+RKbp1q)
QF0Z5Ns7Q)5(8<oXe9F"bp2OABMuFT;^jg9(Y4>k_sp8.G=G1MC3bMXN(U)edZ2shufOXrt0
6IfGNeY?KJ(A&SR$]A0K-(OaFF'Bh@a.)T;Jq+SmK>4@*;[uR7V9_3DG5KJ-=(F>NXg1=OJQs
XR#]AX/E)/#GsL;3#4V.fh^(<M;e92ERYV$(>M1#SDoC-f&Po:RXGoUU`dMU`MT*c[9Q)aYOh
[,UDE9>.&ba*q+sF%3ANUXdO1h@q`\NsGfY\]AgDA?*=Xd/>cSu%e&ZkHAJ1dRG7'pf0JIKu)
m/>j/]AYWg:@\%r?VB5Ep]A>N!03XUB;sgCig7r%3-+Fha(qEI?b]A_C.3ujVpUf;E]AFsESeq1D
P_85VNe/I\4Rq6otU<=^cd]At"h>lK*d@a+-Kd+R<UH]AYYYNX4C5hX=7'b9UdmpaYPulJBdLO
uR?h^j1SE\os8CAEc]AS:T3pM6K[;/:JGL5u8(D<[,[+LK&^ks-D\A*Fk<dbHF\?@BMP.8l]A'
@<hJZoskVf<+8+)!H&h991/H0Z@QB9+E)st4@7G4s*G"`7O!kdAO[`sd:?,X3dl+bldc?RF1
-$%T&U)PIrg3Z%52F)F<:mEq-Rfj<<%`+^;`2)8-/(qn(R&l.R%e9?Hj^'+=6jdf3K@'cWIM
]AA6V^'A)m"'Q*/,?1II\W(N-*g3Y5!U2&:8*ls_7ooj*]AU<WpJt(f3@t^&tu&$7t\;GXlXQi
j\O&dq$n/[s2_GkPR6DDg:I!9;qL"6p-:Tr^/Sf`$UGDL7.73T!t#L>d'<`&4^eRh3VRj0Fe
XJ,EuuracB-[%,6W94KOcui+f:`o"]ANWb-e#Upn.2@3aOEuG4C'$$WF!IBQ[YAV^*]AbK#2hE
i_?Xj,9ML/_qK?on/i\3MFsS>g%c_mJ%s=FiG$SqHP>8haH@t9!;js/ZI%s_Sh,]A2"cVMF$.
YNo-k2*4pa<.X7Y,$XkK!FU$m>pA@Q=[6eXobQSF6G6BPKt;A$>ku!2JD(h<;`Pjp?!_+Tm2
o%*VEIF\!,iHgf3@:/<I6E)-:T6<d"[P+(bI2lX&\[rZRaRWn_WHo$8:*J3^KVZ1Ps8*1Zeg
[)\IMfBu2YEjUe<k_*ffN'`9B8o.4Y<6R81C<r@?0*:[BE+@G`AF@[L1kM%@r4e$91t/qcMY
I^A+j8JL#lf"P7A!WS;UCTrNA.Y1Qd'tbTPjC6HoW3jBGIfLf\Bje[;G0F@;m*_6U%[Gg-c)
1O,M+$`*E*[^^4-J8ddI0O::683:3[l@C"@2tNlf_=UEY8^l40'))lTP0#T\Xo^=8WA5RZq>
s8k&e1,1_OXS^.e^(::YghY5V?[*o?M#[TRC#$\mrdNU(=RU[!WsB>?NhbnAn+-$"*Z(oa8e
^K\MMjp[oE3lcJ2E]A(m(S]AWABFH8")47d[`gj*_D9lH5mG4E,I<iaX0.(`pY-;XNh3\_J^9E
WDgbjLjsdq)R-!LF;9bX>X:Hnl<@:giEE3K;P8ZFNYmGRT=^$l-NUSIHVMUFG,)!qPJlM$(?
1XB?f6M1RLT"K@]A_umbn2g]A)TKudED\)@tf%UU3W'\^0.q5rn-P/1XF_fT1pbSF)SG\S-9D?
!9e@Hbqd5-?8O:C4b#A!f8G/m;qg9++l%4F8L\ZI=Y_-%@pp%%!p.X-qR%pi<(%S_mN4WboJ
q+b^DU3T#r\FFR#K7G6i6L[cn3l!"(>au:R^,<?jb@&hT2-#h12Jim<_>6PbsU)-Iq`XTFZG
FCZ4EjF0B6CgrJ@N;$K0^R`$?8%2)8&`erd/1">3=rA"ZLFU$:7'DU9iYa$t[iR%R.WHkoNn
'UTQS!a[pTV&"l8P>54Q[+_Fc0EN_9fl7D'&GB/V!<*4';$"-,2jV[2:I8WE%)5.D=Q943E-
]Ae*(;66-4A4=VB8ua`m#UXZS_"DZ5g46k?T]A<QE+%!qRF9lrTHC4,?K2!,Q%\I8ViK;l>`cg
Y+o'Nbr1Jjn(0a6.=2g!1?CtPp7DidIUL#7oU/(1!j\I7L'\-HdW`8N%hg3043-^M)%AXoDH
e"m.cH,S\`;/kRsDXV0.D&nf,CSjM,+#p#G[-rf=+Q)r%ZNeG9k8WA6k%q(c8+97iLPa#J+-
)$8aZ:pRGO.SK$rB96+N4QXMr6)H_j.qA[Vn1JNr-Zm-i@>9[#'7EET3RRn)VO*J6Rnd1);E
2o!C2Dbh9nK2P]A0M/NHK4]A(T781=&piAqI_sX-77.cTY5t8Ql7F`h(s*Df2"KE]A%N$r&aY,d
S1po$=3d>\/IK&E*7;FPDA7c.t4U,mPPpePJ>m*d=5q%tGQjlI<YW,efu,c\a=%Pche9TAns
6osD#3&%M2-JdA)eU?2q*nmcB&ZP:jM:V-4(1bI.c>?0@XiI*Ll(P#KaIZ9+]Agqel-b62CY3
SqTOoTD-%.Yu+M.uj*qfZF&8W;!uU9loiT^-F:>r#B5dGT'-O7T^s#ea7cS+FhEB)[!gk7sB
]AI$^F@_U9;maCPtTkDa24[[Z0C[Lsn1j:8kAa2OIqf?S%,iE-Uhm'GCG`89Rb+DAn=;_u`LO
g-#Xf7SNq91s+^WSfFsmpqXrBSa2V&3GtJD"Y@s50>M":.1:+.QL,9>C.B=_U^#VK'XiT_d,
G-aT71M%$W7Ul4,An`9Jk_=X)'-=BK$m2l)S3-Sh*09JPIK@HD^VQ@u0n4UVH@EbA3fpak9m
d()qA=k_+0TF^PeFY]A?G8W8+r7R+dmp0YtSUEqT;H%P_e$Yc_4OV;-:MIsM_,5Oa2QBE!6lZ
-4#PA#\/OP*,r.7R_P>'0$15Mfa-o!BM=g&d"]A%+rVeZdY+.>c;4Q)$n-p#Aqp#Bthsm:%2S
Y9?!ET:rLS'`$8tdTb_:slU.R-.bQD+(X;i\J5+kS()oo$TmW<YU0=%c[!NcYie;(qc3pO;p
a:B[Zno!#3'_/VHk0s]Ahe5Tq)_9Uen`jm4o\1Ol"411+?QP__K>$%;MWKL0r/7k*oD!JR+qU
CAUqO6=`Sd>]A%F*Y&*TJTn)&:ln<i2Vo+S@&7&_j<?IR3:79)#C+Gp75(Jj0LD>!29NQ_.Fu
&\ar9dtOcuL*Vca[odhc#LP&(c5?-AToi__@LF$*6Rk@7r<)5.l6AX]A6F+tD+5E[cifR06'e
.G@'0AQg"N(NR5*nMEX*a@5c7";35'nhIQJ>A]ABZ$r<pO*i/rj4/&Pl;ZBelg:U,n>T&le\5
dCAF8#87Z4loj$MOVtj9g^m_&D3U(SDl+R)bJC#QhB./Vm."&A;T@tLa$+X8W^g'5&Fi_>Co
1?>ebu]A\L!:c6eGldV@E]A]ASGm,cD^e3V'!d[M/oM^Rl%kcA;K-e?6/089gu=>m&*+t#2g)bo
99G"-@7Jm:dZ6i1]AB=VeZ1P$b%T@1J!!nAU&r^@):P;2Z!*aF'Q!?[56CpZ@%Hh.cC'.!E8j
W,9To27RT+H)b3dNGmtI(St[!D;5luN+r&L7Fl?gIK'4J:">B=K'/6e1!3X8>J`IK+PA=%!F
rU1$M,N(]AD#WZluRk'*?(sK0p"$<:MSk_]A)(]AliU_so*#P/U*UUP'r?i4MEV#@GO]ASZ^\2-L
,fj=!k;=:;Mh=G-61-"ruo<SsFAoRsAf,E`@k!_<TR[QeoFTUIMpNMO:*J"&&E3A(EHNGclQ
F!>[MGIT54tL1.<EnX]A&p4Yope?X/Y7_F[\HZ!)c-aGDNS"9YOXVZ-$K9"_NcgU<Y`?t9VRg
_c`0*\Rb'Ko1$Ul[.7K7j#Zm:l`%h>#??<enjQj;mk'u_D#19Cas^k<4#.q%k<nX@D3&d!'L
4u^<X<NucB'M?/%Q$[elS[A[o;f)cI_^XqU>QdnTSQctT)8LW9e=Fcr_[t@ih1/s@V8[4kO)
M!RA1O'%k"8dSPBS&%3PHA?Y$46.\(qsNA'ZIqaAE-u\:4buK!p07;M)u-q+$SgY`ADe`'Rk
KOj@Rs1e_QCpfI1YpR5O\R5tEW7dpG2R>ft[0<0TDL*bWHc=*#")*5_<FjQ(4NQKlPr7BC5:
&QO6bjB31+?V]AlB-&9Zdcnf=j,\EE)\f5tBCV:Z@"LEKSYl@[!f*m+ndjd,.94[FEQ^dh&*b
?KfegX$<"lJpI,:.u2jcn[#4t_r@pVJ6+j,Q&r>-/T(2FrMKOcQZPk?IpRi?o4Vb(6Iig4[,
]ACVVX#)?#M=KUQ*!?^XRRHaa[^^<PGj4H;K_JnPHhX^'hJBf_'=cQVcA]AOE4L).H\nP%rNc4
o7a,e`89]AM:>-;5"MTZ*i$0Ld-4iaair%CkJ-2bF$BUkYkBg7?TVFjPB,=GZZYk/Sbq$iI6-
\>W9#Cin:I4<jBC_^@s@r-qO>Z09?GI;BL(*%tcFd@XTpiL2je(`OC6i<1"Y&cuZmkqa#`Yp
[bAAJau4L$sYdrPunUPS7mYR;VIWDc;^"3?*1)&#=YOb`lT'3cDf3iYG)+*&,\#`p/7!b$h>
<7CoI:/W.R)ak=QX^#nr2>-+(a<]A^:#]A,;9uC(tgna"aM\I#8\5W<Y9aJ/doKHDDAI^S"1%l
$;E]A\'Yu2iEKXW[qC8fbrTqOS!u,4Gos3.$H,/p<c',:XZ>^"=V;X0MN;4jLZ6(=$7XQ:e18
r[5RSTSW.>L`&A@eHPrfXM&S8);Ei4YPKak\qC%riGM3#ft(ZVouMi>hdI)X%BIe`TWi:=6?
jOeb+]A2+sMk*Qg%(4lZ4$<D<T6g+NgRpY1V3B/9GeM[<$8Yoq0\17pu.!5p&oY?UXp)X#\hr
nR!g(RV(;Nui,bAUW7*6pu[k?rHrgN_:d,LIbssJ]A$;9om/PGLB0]ASPt)6'7)>\I(9dgf8*l
79-<X#D*Mem'9!,%)rrMrZSdJs=L#`'>O+^^"a-hl3</B.'DR)72DcGo,ai[W"7VPmk03^7g
obg[JP3&^YRC1K.\V3nk.(d?&PJ2G"#9kS/OW?%E/p&@Jk/lKgd6?uc.L/RKWm"Hq%="Ym`U
.tL3A_uB/q)S!s%oqeBOGcVd(8bfiRQmgS*0:aZ\t8CMnXcDQU@q_]AphB5r$]ARF(e5eY!sr[
?9`0uPMB8(9CsQ[9[/XeI0T*W1(P6Q5>5$ZhnOpYLi=$8-Wo0]A@0V>:%1;XjR+91[dZG/+h!
JLYFj(:@M@2JmE^m_D7DE*S9$+1.bO1b<QmN?]ApI?5U4]AcIbGq+8)NX3Yu6X?YiELIseWj.Q
?eN)MWM"8063kWQ,$8^D1RV^$]A/M\;e<1.6cT&[I#/(u1M_q&cUJ]AfP/`"W1aq\%-D/3)]Ap=
-V"&Y^4h]A2&lsI[I=O_qI9P`FRL9k09Q.pkk2+plA2QEAGt8aS`7ARa#<V(c91RfReg>7KAr
8g5s%DgRaL*nWe(W@.=Oqdun1PnN)4to2lV&.&o9emg4!p!L_8eA>p,9$X?tQtKJmUdJ&$NB
[j2NlYqMh7rOuiK;94G)?;CR%#aJ+m2lYlLVUebCR[;UE2>G)?$0MMDKaktn3q5$'_X8[Ni-
kJoi.Em+40ZkEjZ*g;#.R&jX-3LMUL/8_e,V9Oa25*F=52r=PY/Nt><U9hmo1:7>V,PT+=^]A
[cG.fCufe7`m!'a,chY`9[W?_o/?p1Y"b22B47=WOA=1uj;T&uO)<(SJejsKT0OF.k0^4F9&
rWAlkMl4<SM%/B0]AVqVGH<8F`psse6JA58`e<Y[79+&nq@Jp@hl^*J@R(B'@DK>(:7]Ab+Ko_
@<ddr^/!,egTR?K4/k[.;6`[XSK%;WDh'f27qhU_h%)V4,.b.3nk(HkCK$6[81t'-^8!1!JC
&!6Gi@9fo%\^c$&>T7WR*SM\F)?60_*>u5GX75Qc,/%&<c0320.gL:5`l2*X<@F8>jdODc\q
39m"h<tuN.G9tPLW,[iL"N'OloX.]AHg?$Qk"Y@-0H3(A"24cfEY/#qi*c=ZlAs/u%\1AJ"9!
i'"sZgI4uL\ggKC\onYq?DE4L;mFgq.3h2nk0,`#*'I^sRo@YkGtVt3A,eGc8)P]AuH=l^D5r
Gjg*)h6C1KR=Rs,\U);Wrb#E8CGriQe"5c]AZ3$fsX<*#N5_^_o7mJ@r(&Y\bI+:Z;U-^PCr3
fpaARa;dEAW7\S84629G;^#4G-G+b-^=?F&&`ZGr_ZWZ?U_U?dUGFV!5d--aN)MdA"*+"b`R
6lg@,7eMk7m]AB>1pIF`<q\N``/c$/7b`F45K=>A1oRrG`8q9O`i)_nnYiJ*s'hpKC3`'il>1
O=LbjBZL0s+1-opaAl$:j1jE.LLl;X*]AC+>ibCWH1t8:cScE1O'DQ1*K)0#/e"e+[;!",6<D
gZ<O)-JOL+9SUfDf=^\r<)DX(arb@ghmK,-At6,Q*t6L:$o1Uf(\["-\:2K:gXIL[cHIAo8P
`CGIQ?$._s_(VZT^[^H9?g3Y)Wi6l45-cLtRHAQeWEuO,+DUTD_:O##=RM&tG_8">h,T_5*,
l'2Oem`M"pB$qqU+dg93O&'0ptn=rV!2Wlg"=QnCH\r6*(/":WdT>/50<f/f;qS0ipQ`GsVd
Z^i(E`8:0@?GUV]A`ZL,iRdEKke8WJcta\a?R/:37#18=']AC<B*&o<gAo.F!=LXACO&a(,>b@
?HkFc\pP4]AgT2+FhpfE3c'?@;isfGSEXZa@l_Ctd=]A1*9h!Sa\*Kt%S]A/-LiASC`H;VHCK'g
Ba*4Ii>J;9PBOl.Bm^M2)l)L,!EVZAS-VuH7R*UsKd+OhII,_(Mh15#OrqeXTQl;_,#_e%kT
@\`2;rZP9k0U4CZSYD,Y@3K&Ag=7-tBsmnb7>6?H/s^A5:E\YNU6]AIe0$k-J;_$bG?M;&&TW
6kH=?NA?9e64Ws#m.[dgpU"'M-@\BSSna#6JTiMs#.gR7\hZ]AblhW84QLW4)$&'p@c+A.Q.4
LUBL8RS!;c^=QY?p#%SOU5\r)$HB7Y;/O_c1#"C(phM=:RqFQ]A&Vs*4=D')Rt9-A3BgeV7$G
hRnh+]Aib(IaAr&4cb1+"Y(?iOL6rpqW!rUVk@@1/Xf9SC'u%'9bNpZW:JI_1D/9-oqpLp[f=
F7j:qor19HQ"J#9i22oti)>b>GGRJn'8[&2Ja:\Lqq1CsJ6HDPjgK8;ooXLAPDRl4AKc7>i[
bBB,akW!jp@GL,!''Zn*nsLXP@V:*UD0WQ;gr^8Pq^Bl[FkgHV0"QK+S$S!qE7jVoWQF]ATh<
f>Hj&G@rBR]AVsFOt_;;dUPb6!gD_)ahdI#.#RA$S;:m.*:j%W5i:`Aa<Z:rY8[VK]As@:-c<3
0AWV*3L]AsKGrmL6:Oj'*I\+pa!qXJTK2<6bn@?bIOR!Kr5T'PIGWq0ikFfYXY)t=3'FR)`X"
T0DeU(<%@9k]A8NYIufsg]A$%"Gq0?)=C@n_*RIrHO;;qnBJ:^M5i(F:&'Yh>7a8tg>q0`ed4j
rjXsAjBJ9QFthn=e\]Au4)ZW*g_c@-_?RQC%,O]AM.1i_TMHVPbt,jo2I",WlOf;Q7K/u?0+ST
Y0K_)hnhZk22%`u?&"`03iIdgPH3^kF&D#ZL?2]A=s&MK(>4UpA8,a1sjS*N!=+@MNPUl<#2=
^GE9HC\5%*cC8ZVhE;d.H%+9pS@u)qF$'(j,VRs7)Z?g/h1-PRmcF[9G0,"4UAHeJY"U'Pm)
XR6`<k1EaF,n=@#Xau=$:eHaQF/N/qtV/B@bnb/iS%8LU7:?-IB4q?.)eo=@+Tmj".CZ\=Sa
:\XDP\;\:h*nk;*<RHb5)d9T5F<EOf5@+4dORJ-0!u`:!?HMos3*onQl>T-(BbqTXh,>q:\i
I5E10'&Y*F_e9`ucjImH^AQFL+?ND.8c9VVE@9.hI@,PenVVC:a/f,`8<&M]AF=nn=osAS0JP
^#\PLS#4)`P:J%[j26:r;97X3cBC(l&sm$>^NCs*.P\D`#k%Z<m!<<km5&aW1#I0$id&4o?t
.)_$+th&R`.:7?O#j:LAG+Uh4qRBFdpB_W*Q-']APe,^rY9VY"m<4ZC3YJ@V-6D&R4@Xr)bgi
\Bj405?LSUc(4o%NOqpu!5&gGZ[AP+Of#o(3p4ZNmbpn!13RIX>ZgWGSgp1U)G;/mcPFbBiE
f+*A<pMKN6M8m7Ds@UNiCIJT3OHEQ;Y:hcBQUC!@P>:3%JD<nPb3D(,^LWi!up%e-V'0Ob-q
0Mpik#t[HW[;#LqI.Mu;9&2?WTb8[Ib@M=J:&*'T/Vjn;.b9k.%hH5s0A3<Vu\GX.W^296GH
\7;cp%NC()eb.j!j3I/:(L`U*P*@GN)B3agDtGO\OjNIM#`Mmo'XKYST>4r/m,5gTZH9YJiL
A$P&(.blP:3KsB`*VM0KAXQRYr0F1tJ2Nig;nBY4X9.K?2!!lq8W^f^i:hB>R`]Ao`5Bibf+e
KU:LH+LFRYgbBY-QP-1%T&+Xk]A&#t!Q<=9h=jqC>qPc\c=9!Xo6\0IeuTM^i#=LMuZ8P-KoD
2b&s9n_9B-rd#NDIG^6gTi/H$_kLNIulq5Zf1F-PR\]AMPi9bFgZX5P"FTl,(I%m$D0ifR:o/
u`0*kq.hm?\nE8$a7nFaZhq;_OCP-Uisfr*&+QbMAE9-SSp:*?.\dF0@.POK(.>OU?mh#9e`
rk/#.0,56pEm-.24TE$))]AE@G^c>e[U[LDA5X^eEE#`o36s,Z<%YLDO$7bU+)\m@_20KuD4t
(JN@b2ZRhepcE)<^!]A\3d]A]A*K816eF1!F[N,<'AEn.?mH)fcahlN9q=ZZI'aA>H1NZiYo064
2F4g3?V&OJ37V#aX[6[IVX/+HCHfN5N-!mt]A[RrjfkEFaYL0_)YD=6=h"7`,9=GcISq_X=t9
o+_ZoSAG!)2pZ3P'i&7.h4/%`0%/uoScSgqFU5!Y"W_5$.aRF^)^)W3"^.+q0jeL5(AA/6@`
b&F;r(^mCrX=\m2EQlkQ,3X?3#O$gRs4B7"TNn;#0o%BU9Ih1[>YJ_'go>?!#!I9OI,A&dO*
c,'uo1K9,N7CoWZcM#D\;MrD.MhLG.Aa&`:/2m>kRqS$gDu<[!6A+[)\SKslj`(c5\Gm\oU+
X9td!)#'+D7P?SLG]A<<n0iG8PKR.@8ATm\rAB0Ru`6i1D(+W-'3%p*f5$9*;ZIMG5stN9lDP
FIi2>Q3)Zsp;73#\hh:D-"?,7*r/;FaV/fI`N,JO6TDg<t^ghqRfZD`D8%0BMRpT4A@?kd@?
-+Hn7!Wl&Z@kF9F16t#l>o7PD.t%hW8=Mn_R$9Y(q(]APT/?5BZtLIe)'59dGBJ#,CP='agQ-
`^cCDrKNa>Zij;o-Z^rlRu&1(6LQ(O_Bqf[Lpkf/AOVoGqFB4l'Fl+^LkHU?;]ANb-,/WZ5!C
lCh_hn(!Gi@&)3<A$^#UA2DsKjs)QT8&-0:m,7pM!!I,PC:]A!Ze^<I(<#'uF+Kf^5LWg>r,$
b/p>Yd^B"$PaR&sJq<4Y)XFnLO'ggWi3IRr!n=Bm_63=79<q0K/)C?936$IX)Sad(iY[;)%G
;6RoS1Xhb,aEHF[U04M/62A8Is^K[iB<J^(Mp=SO_1CYL`Dodi74JpNL-TZ?5OP.>pA+RhT^
dh5/B$E%';-+Nh=^58%ampp[<i,_-`u$p"'lWID1`P^`k,V9?>e-_GjGR/I5:s@QbNp%`!"2
DfI!?-,;_m(o`$8)U&R]Aonr_/#+nX3OP#L4_F&^G#CIGMYo;_!Ln.kqJ-:e6D:-?1'+1S5;5
m8Ek^[@A)KhqhTDcC7K9EePIEC6WD\U$ha/X"l+H0gCpshGN851V&I^drM:UesHor0YD\>f9
54TP\a[Zkg9Iui]AlU1kk9tS^`a+%BcQr3lB!*"9&jAT-SZrG)9T_[GM(Q;M!4&BSJ?SV-*%8
@o*T"!PoVlGS%XJ]A#7Vt1%K.3+g:V.$fa16edi+A&M0)!7Z-+uZpWD?nrTO\q'&mQFPZ@*bN
H*E$OFu<$@A(A4oOqo$.DrJ<O?.=Q'%WR)pX^`3WbhY,:V7#=og/"`%/E[Fq3uZTq@sD"gTP
Z5%[T1]A?b=6=Akupq?9.;#OmkdB'`O$hQ0E?Dfm6BSYVk,m'lc]AHDAl#mp2B8<T+;ZF)S\&V
<1<bu:.VS=Q^Vb0-;2`mib$7lbC9$uBP#2KX)n=0QaEjB$ch<s3T)6@mbl,.@O`DumF!;JOH
u$N%'#aTO8Z8]ApC)iKqn@iL&0a^`M,';_Kr@?M6lS!,U6f8HhFg6IK$d)l+X@ZIN@nE,1-23
)(+"9Fs1(A/n+BqH=19!cgh37cce@Q`]Ap@KBeROdRC#LMAoPA.^IZ>]A@.4E:ZM6D4A'3G/K_
R%;BO7-p8<K%uSS]AdN+@;&sn'$qft8GAA#/aYe53c2%DfmLNcMd*D,_7Lgpn?&mtpmiO`N7:
+lA73>_Ah4EfND;BeeH06]AafLV/!i%<eWRXOg3;Ii0f)PHTS]A3-jVbJ(7J,H>&G(P#'gHhIi
5c!ej/`BZE>mhk;[fZ3DXts.d2EVm=SeQUN45`k>IqiHuj5"D&]A@uAR-kh>LcQ04u[#\"J*G
#4bO\`0fWZHef`_QFpI#1*:6AL#r\)qiQDU3;-O@'f.>q[k?heqn!aQH3.mu/YlbF6B[l;6M
+m]A>,S]Ae'L#!&Wss#LfcQ8@s01455+\(\5:bfp&c>]A#NRccZ9$X(.6cX7>;_#%Zb7,8=O3Ge
YoAVNT/T)meIemaD1r!Xu"sImjksX<cOF4-/gWL2sj`ff8a+nC3IO54OidR]A8^pC%rotUZn?
0Y?TB$Mc0&Ndjr1GTp0jrOfj>OohR8R,#fG:XKjb6]ADLVa?EE9e9;/X+HfD)!_0=kMYKt&Ba
CjRVg3IA)(YAMO\_qt+:20/V>(mLU2bZ$/K:qQ/Z6=V.FSGZLE7CSb*(f+NOkgClc&82e#$K
3Du"<A,pZW8CJjRS[YJLdKrP^28sg#+\25NO&17S^O?WP:XpG=]ARh:SGHl(MFT[+VWb36k'a
@;*Z'WI(u$%B7OJ)&Am+L*'/rO)R\D[r!W88'dT'T,PuptJ-A='rUf\Po8fSV8*'BE'i11l@
1[S!&bAT=AEpd@@snm^kUuYQ(FKhhY6LN3q7o?Gn'MkmfOT-HRFS,^ZW2?cVJNbg7@?2]ARp\
8pq<PA"IP=I'<7["CW]A]A6N:nhM_k,09"PUP+>1K_595&J995j?HiT2]AM8]Aba>^L<&1+U>#.m
P(2^*6$Goj]AiYuRaM`GU&QnV-(2;ck<41nCIr75L#!W:YT!,aQr<Cl+$j>kRmOZq)mb:YR4H
0"&Q_$n-5PdMt>LU9)2Ea*MHlPf@Vjb,$2&SH@7;dT_B!-(47NQ[7GZ@'u,7#L3niaBf0h<,
iJ_P!h+jY`kM\j+n_1lqGQJ<njPOV?BokM/@1A)Xe.W,&*,uSuAd$NO1"8TThLpo02>.Pr,4
]A=\`_c9d#WPbYh33rqEk<R(n4V(oN^Cn-gQ/kYSpQUgZpo.P--<.Q9?mdI3,adHg;0<1Z<DT
kHn$]A&i9htUA^N68>TsFH:Xj+sE8,848^TehO&9]A1sH[4ojOHYfd5;"@s\J'#Fq0\0)k-jgu
/g2?jN:_K6Df"%OG8;X;?:GrY?Lbs<7g1>1LfoZlosh_Qd2Ke,(12Y7/3+6+AU@NWh*6NsS;
uF4*7*(jGS,EUX&%T$%UTD3_d/%_fS-ellQ,[`BlR'=(ugNoq`;Y7-]A66d%>aHH>f8OU"^dn
lH^h`apO!$>*E)`UH4ngWQiANj=f_:0"sD1l>\soL^:h'f]Ak_N25?>H`B%"4so>AFMhi)X_j
4n,(_8m:*e2,m8aHKgp6OI2OQdp\_[8qsq9`#g(!N&-q=\EUI-Gp6ohD,d!Kk\jp#Md0N+Kr
?%'`(jP)O9tQ$nX=#T?R"<jJr)-=?2Y^TV):b-C]Ag;/*_-L-VE(nE*jR6fYHhApB]A<jr$9'W
pb5\4C6?kj5,tqIM)F?#0\Ln3a=of)l??itg8UO<R'dd5-#r#d=<Ji511;(nhp[Ob]ALU6A"5
ePWV^N9=-&UJ?P[>8@1/)1Pd`m?k*(A#,dl4Luj3:"BoXRpDBDS'"Z/GsRI+A04Xu?T>ZaP1
^9F:(pm*iW-B@ATI)pWd;&3m@$,Mh!6CacFKM&GX.8I,p*o(-/+OKct#)%P!1U@K?Xo,#(Y*
7Tl-KOD\3#QK^sH03-.7Tg\-_(_E`Hjls-C=lRG346s0B&0)r\eQ1@3?Q&k5Rt[.?q==+9&X
QB68$6`%s"/0jG:82J=9KaUH/rf99cP9IFHF6@1)d)<A`)e;ga6LW%>3nAiI5,N78[i;E3!'
>%^M86N#*JB!6Y:#Nj#G9Z(nXGYdQE<,M%RO'KHhpMr5hQ=GahPs"V(X\@!q"0uWh_p=UErD
$uiUea'122IesR.jMOep.`(.#M&h*I?Cg.(5+d1F&lT8L*G\]ATI+OqfU,]AoaF[A*?ra`W`%g
]A>q@IZf[rPjE.k\5r+an9_3JjA?+b<d=HI@!?t)EdV@rp^)iH_A+d/s8S#i2jS8L8`7K3iD-
Qgq+_2KYMdp<^@Tfc#_X%eqM.jJJ\2aIs]Aj-eTI+[?\:/m#a\LG8N[;\);,>!5/rO)@,SPT>
i)$OX7-6!(sRBdN8F8=2Or489"Qh?EbgiU'E_li>r"[@@M/Y/F4GD9OPa:-]A[HlX$ZN*XcFR
D5B6=%Reb/8!&RVnQj$h6r)dg/Ofac3>RA\P;bt`U%%G-b6qYC2%dmZ;q(fdQ;p"f4Y96"I,
7N+^\Ug#!FYC+WUnZC`-n6nKeJBB:NfTW44n8rY1X.*Tog$tmp]Aq1L)LG2gB7nYTG<!M'BOP
/CVO!.;67,W[`#9RTEk(LS9;T>a-YY\io\:JD>tl6BIj%mqm&C7S#j0]ApHakZ`1Q48I%t*tc
U8&a4trP`*gcXpNWq5uh%`fDW%QHo=Aea*Aojm9Ep1Rk;-)D#3=:qX<RTAVkrKq)i=GnlTt.
;n[a)EmlE"U8c>=H2^utefG.biAQ)+_'j*I#Jqca^X>`-jWUijGqULjJ2T-9Op[=p\%oh#3U
7<.C+=;iJE+V+iFU9PrBmu^qR@APK79jLR,MoQ6jb3=hJR6LO9?DsgO+0fZqEd:On&H-M>b)
_gRI!;:YcOi6?LBDp$6)o0A,OuOVj.J%-=HG?,4H>LZX*@R+B]ABu,fC]A8SrP/euWjq%ll?=3
5<I*B+@tL>;'8As+c#Pob3EDM!%e@g49C5IZU'=8f%8"<!s,nb-nK>(^1,3g\:b.4oQkALN"
@`K]ApGp_lE-2+AqV&mb:&EJlMK$&Bkg;]AP[ttY.#4\D6/^iS`#NC&\OS"7;2itm2]At*,8PT2
KbFD.1He-5<>eo$5j^oe*+6AsJcMlihWN>jk*+8/+-Csjujg1eAT!u^bX3rC%llJ""I]AqEsG
`cr_`a&eVm')QOkj<]Ail3_bH76diF'`nG>h>O\95>u!%KXL*t!5Q6oGX<iaM/u<-EH["-u6#
r]Asj&B1W.)P0D(o-Z^6c?;\NX5FhKnNDja:J,Pm$f_ArH@_qbu_M+A3YQJ(fsV'5_kM1jcT>
pl[-#1QK7m+-A<?#F2aNmEnDSm2CK#$MUiUD=0nF&fS$;6U(;Cb[(p!1Vrd]APa=c?^$^\Y+`
NX]Ad/9\^.Yrq14WBj_8f$bMa/m7U6:<gbj]A_Dg)!iE:(+bL\?KTb<k$K_CYZML9#(E0c_50m
'-Lpl[N(QR<EY@4ql`833mm\NIOP,Fm'+O@>OqY%<[?rT%S^6^3iD;Frb3]Ab!Md;"*hjJ?8?
^2G5X_SIc,fKahua+#PqVm.i'E6raS.`r)pa"tTYs,/D/Lo+<GJHFWCKP$PKT%Ud\-=to`oW
+2@VIu*aD@UhQ8Oabb9-_-8^C4XC;_cIik1V\AP3V'2MV`.Pl<jc^B.b^g8R]A7ik6?.\T8RL
7h1'sHNF*T:Loj(1ASUC@00%eOc,gPQZ6m:,9M]A&KZ-Qp6>ouO2%X)bpiBN0o/2D[I&.8u[#
2I,>R\Zfq_0@qH.._EWhS3B`\ukq@R@i(U,XRUn0^d9=+AI1\c??Au.G7@[7@7d<\Zbfbb9;
ub?Y8@gPd,Lh\P'/?!&kJqG=a.?E/]Ant\%=fHYB!=kQ:1"Q0<Y2`fAoEM/Cg(`?';#k3K$od
QSXi8GTd_hqrhA>DW><8>(qJ6?HqBSZ&h0K$5/qa?%)'#<!eDHQ<X,0h7iT`mCb?)3neT&F#
)i-)162uE'S/e`i56U_V'&&.6:<?ER`I4D"BAnN0"Yr.-g/^NE`m"-&RBL8NFIRV&!4H5(5l
B8fXc/N+\(D\KkYoGD=Qg!]A4ZMV#f<ec?I]A0mH,Ts,'!Jml"AX:hWB*J\EtL(\(?3bhoWj*^
u:N9.\Ilu5@7NoB*7N+PT3&hWI,O?;CC]AT2@^KdC:KXR,kDQYgC&:"HNCZN^l1C5:@lTQiR4
9P-o%4-ATqY=j!jaK3s`).b0QkW\]AONAU1hMdP=ij=.e0&fV[,WT@J:,E0!Sem89``AID]AY7
,>05Z$uQJhm%ND]A6dZhJ?QV5?&)KmG2.`n6G9$l5+k?X1:1]AJF__@/JXnW=)8);,r3.t_>aG
K@Je80&AHal_%+L>s(>t6adT-/+NOs^%t17e2GaWaX37#6gW(e8E?SjqSG\QP5GMY\pQb\Wd
If+)I=7[K%AQ[8F4m<>j^X$e^)aM@Fi=;r:W&T?D,19EgW(fe`F!8DggJOAgK4nl4*SK9*NX
7N3::1O._6JY]A4M9hhIZ\T.+3TU27lbVu4d>VjDBb8H'EV;%J#ZqE<+;M%rUB^]AZHcW1InF0
?,+.P`JrL1&@$q_VDC\/iAaPE#.-]A"7lWdOd(1B:u55H\Wg.#R%-An"csT78kbQ$>aH,ptOP
'?A?>Z9KZsm[g*V`ZsuLVsI@Rr`?_'2#@[?leAEV^MWg>bl]A`k5%kBJ5hFbEdPqj+q4YnSK'
rA'Z$[<F3_a[^QDZNL\uUh$4C?F/`5f@Q"Xksk%^<tt\2nA2I)KBjZUC]Au!ZR`aM>#LN%$>f
cUiAV6m;i3WcT7#M1H=AkR6:/C$n""p9rami@f0W$;FfDC@mWC1BR'k]A:+-<C_3HC3$hICTd
^H%\a5*<7\<rQ4*N.+k,lcKEU93L-:Dl*\;B'`lVsu,r.CoCua.lJK4]Ae8,OQ[d,(%/k;4*!
E0b9A'6:+),]AoNgfIIE*,sCT0dDk\/N\%USpK)9gio)gh%TiCf``PWc$2lk`Gn2Y!i%=YC<6
j^iD*>_j!iaobC[m#.p-J>O5,Ygm^,]AA0AD3S\WHpFbNE&=I.WDUK(9P?;mRJ^(Ma@3))+^!
W#Mr'V6n:PZZ+Z9A'`0]ACl!7B*2l_oET6bqlW-ieU_+=c*0dm19Iu6pf)TdqaM+GjJB]A7iZd
5k"Qfo@0>fIk,pTK![iJS#+2IbJ1pN`?I-Ji!4UUgg;hsq7?X.(n?^*%TPEJP71UNtnf[;nF
+bj;+,oHOfE4qTNg-H7k+6uEKDoZBRPqdb4(t3j!]A[k*..jjI;b<l<ad'6H%o@U,q+,Ik#OE
ZT6&Va]Ae9S&\!MX+.mo;sVaL@>,2F,@Xq[Mn[h$LkjIH>1Gk`P9\#q1bt;Hgc$p0<W8E1`Nr
0L#qE#Ss[B;6[WAW;<e[A-CQi$<j/bWgQLG^Uk?\hi)'E-bU`-rBJ'JInlC\CE!Z6Fc%^=SJ
kPQ,_DNRAS</EgCiR4/HKKN\:gB#&J]ATG`[T50BJ,4)98U*3o$NL!pTN(Nh$p45>3JQ)RA`B
aIA@U=s%1qJa1gPY0@FU8Um/\=oYpugqJS=-o"!Y,*b_J*[B/fQ>AEAt$0?ft-9iIMK`*1#5
kTI76BO4_F=F/*N5ps]AgE8ro_V;6*1'ODscFpD_/G?h)>Z<l,j^G+aQ'j@M2Jsbp[*j'K.rq
?KmuMRQds:stW_)1Dm4MQZp)!XY@CWm\WbYR,QP8L9_LU8AFa<dl#]A2E#[YD8lZ<K[\1K-,4
n)Kmr5?d,@<Lf]AS)2OW/rfbMK/u(&;Cs;1ZqSj.m)VFa/2KB($O%F=J?=m$TMh1dfD*2Z;A!
]A5X'"%#O@"*<C2"J3kb/H#DDa398c'UH#N\JVlCk]AM<;t?/g<6pnep5<okh3rQ<Zc0CH>LNS
p5qH;D'Qjf5VuGch,.0ilLeDr=n3fP?U(Ut[r>c>$qX!_8RJM"N+R#8SHol\g$.51]A#*$?Dk
WiSrp4Nm,R:G+WB]A#RC[*_a!FF%TM9/:"#10L2DAZ$O-pN4[_R/7T/fj+o5=3FA_^dTZ7F!F
GKS0n``H&]Ap'A3rVDT)'L([XURs9&jpchaH)Nou\02p\YJfcftcc-u#bETAB0mN6BkN+rDb/
jq0t<UW6Uo$i4d:$cYaD"og_8QTC[WI=2B7M4t#V*0CeW1:Vl7E3tM[c8OI"5D6;1b_U;;Dj
sIPJDA"Qb<8Y7dBdO<]Au,^6:6B!8!-92b2K@tn7H_\'e7Z,#q>8m<$`p+(,\oJ&R't)9rj-\
/KeY(`Fl,,6>N,$BTAY5?J2*QsF`@t-2PbEH+k8?E:+ZSeA9<.Si<emn54DG?Yb^&b'6tA#Z
siW]AAU/Rg_)0VaBGV7'P)R,cgmtoi4C:GXgh7VD)T<]AQk;Ma4)W.&ji`@iYq6=(SKk]A^jB'!
&Ec#^0/2p:&^VPJBWLdNB*56=7=R=Mm2a!Ck8g7t!Ifij/CZF5.prbb2%CBJ0te->[.k<$R!
6&U2uTDn@U*nXuj3r^Zm\rQu/9U4_Oe.O]AN)\;:5-Sp2FI&_ma2_Z`8adc3+PbC9uDS?]A.TR
<#G4Ul@6/<D&p-s`pYQ)43H\QVG.U7:U'(j&;ADDY_2>;WP9:bUAR+FiB*,Z"4e*Y$nq/9(h
HP6A_5()0@Lr]A,G:4gCD'[:+]ALHs1Ke*Nb7N6+#=eQuqph]A[58j4K2k1`OE$'+O@)58U,U>+
!20uk^%1::!Uo8SZVK%2`TH_i/]AeHD0GA4$gRV%j%Y[8c6r4)m(/e>hk_Ep?N"@!$29XKHu&
YV4h#[m)4%"p'X#[h6u'._3KP0kS(-'S['FjJYWbV)dg<WpcUbT8/8jEaXRT^>GKj=V/eV'N
<r-IPSiLt6]AeO*l4`AM"&_]A`poFBF;5Z+.EmkJ6Sf\Q)326^KehfIYcX8^sgeV7WA99*3?mI
LgnpJtC/WSj"!Y+E7t-PD^\aNA:D1572I[TFL=:"3lN;?f5;=;@?t3]A5f3T6h\0TdGk3a?Ih
Cm$Xn[#(4<&PFk9V3>"ltN^#na(LL#b,>YPRgt\@<i]A3-V.@B"Mm<cR5M>]AZ8J**F,.@F\Ki
p%/32p!i_0f(]A:l<quH,'G5+#jqu[J,RGng@k>08l95fVBZj<U1\4H#u)3VUMq:..>Q+9nR"
88O:-pdHbN7)96]A#?N)RRh$RO%:k;.'k(#jkbX5VT\PO*2'[Y89"APs>63_fH6V=kKbEO0L%
ZF_15+e&s1G'ai)Pi&9L\7YrnmE1]AaM/oVK^HM_eLh]A"a1<M!+EYK/H/i>5QUrP*sWKQ58pK
e1bCCE=*]A^oJS.N(1+Ic%Al'+nQ7(%>?#?)s[iFU+^>K;Wce7p5M9$Z,?LRb/+1;[9+l:W("
5HQrfU$lP\JQY53Wo(d>rE(T_/G155X:qRL82!l';fLpF)S=K,:[RUiW4uIouDfg,;?S>(.R
-W#$<qB)p(S2O"%hW\?:1*t$V5.9F+4X=^jPe'@"\tK*5V'$!X@+fFcp(%A5=X0_g^E\5ohL
D*oCAK^`PYqIDO,tgV)WXeF%O_B\r.A.JL*D`4Dd31i5qJ>_Q>\B`>-;5(=E6@\Q&iQAI&je
&_?l3hLd#tC4WbV@l@%rfJg"klFX^%$.jBqGk6G=R`$dGY`^hXGJNYM[C-_JqEJ$)n:H7-qR
FM7j'PbH($hfbi@d\TCFOi$DKNcY)DXN%EP<'(YqX]A'e:5L$k'W^W^-JF3H]A1\'J8>2.8Rpa
ud!B0kfW!u>>_W/\//3IDdtfjGXke0*/oN3<Hp:ak4pd)S<`*pEH>Cl)9h9_ekU:"3T)j]AL-
e1%2&'WsYb[g`+jOiF9EO5LaK-DZk"sokQd3K-C?>[VV#-'7=?V,A,!\2L10/a3b6'#@;qIC
*ka.Zjc[4]AGJj02g*DG:)2Y3Pd[`Kl2p'L<N]Al)5X^AgA26?/:5pZcq:P_%\4#+JSfj:+.DY
Vi-[n%-aaK<O.&1rS(]AYP^\X#M;&-H>>;cQm>;KuoO@#_j.i0BZZa&>5\]Ad/0RLCh:&qaHlS
VogmhSWr;F#[j_]A0>7gFr@]AGAZHkr37ALl9`<s8,`$;a:P"P^l'\_Baii/Bp8Lcn3%KAoJB(
;&ToA\?Td#JIJVe2U.@eTos)j9_i/Z7DQIV/!s/hlf.0mF]A1Zj:XO:&$71YW\9A@]AjNZEk+f
)u\eYX_#NAJ[.S)YBgS1\7Do;f:Y<@bC#\.6Y!RA?"PG^=tbSAhiM(]AVq4/qAr;iEB%^JDD4
l@`UGa/"F9I)HiGER2Co?Dgr**NA;dSgXq\WrT,8(:(sDoknGXm)/D8Hmr,-l*W?j>U7I2F;
><dG!T5Z00Y>LWq''MQbqd<+0UuG7n;@qp;Updb_Nbj/dAYb5WTa*q;dAl>U$G[dTYLqbi6P
n/,K6YncZK=uE/O724'YJID70JVu1Tgh"qsBS!IAt^E0@E$E]Aih9>$X$[(J><(F&7;t+\\W;
WqPmQK\8Vi3A%>[)]Ab);j`dK*/:2@l`U*:loAYqi3?j'[EJom_5:F=XZBH9'5Oq>H8*s[RhT
0;B)'\up5MX8>`ribIrMY5Y`6W,g3Le=oUJ)^8Z>\SI0btC=&,Yk7o12)RF'dZ/umY@[_fen
:=1Bg5+,.GUF+hf#Y7Z>?\cH[O*1%te%k^)N0`8B<!BQ$BJp03YM*Xs_B8.4IGR$:go1U5^#
c/sZLVV$d+@VpG[NM$4!qF6%IDm0!$"cgFJ')f@,Q1;+2R\']ANAoQL]Ar!iKdO"OQ8'dBLS?b
gq_m,i,p2f&u&^-6#LZj<d1V+`%.9sk_)(sO%1YB.:MG\A2fdB&Za/MG!IWH9V@d1[DS,W1n
,9V'[jXO7ONaYduE$ENAiX7jU+5?]ASZAju\m+"O>bnQ#oS<uRoBpm*]A^?G3(AHj'3*CH*5mP
FVV+n!h&W]ABbIU:DD1]A)r<BuFB$t;`GAJ*^aFI_:E78iV_P8F-V9uc_=>i.Rn>/C3NZ9D5R0
mAcig<K>EXEb,[<OT$!UR\pU"Og\N[+f"_scK@9;1*WXdL@>LDU,;_b"JHEu1[7))#Lkq9pP
l16NYSBkto*go3&,S-F&WC(uP=4Mlq5o]A/F\3A#gTSM\17St)tCH\HhlW/CZ9'1I<9V(H[Gm
ZU&=MV.^LoBP[a(_=H9gB@6X8**%aD.^HO/0u+HG:IW.f-5?-XM;pUOnP5*)1uhra]AW`SjJH
^8QKSNgXdIh.t8k"42k_Q#"'iTU_5Y9:PsI=1K6n?C*;2b*^?%U#psp?1#UpWH5&C@hS/oT[
6$joPF%5^>(jVT$k^<1SNOYFnfPY+MJiE*h,sCtRMs@sr6\LGWtnjHjM3"Q&fd!X.ps83f^1
T7[]Aeie=^R%P]AOuNZi>d'UqiUd'K=-HklL&nWIf[$;$&I[(2@B=.aWdXR!)+*\Z/XJHbBmYO
D>WL%+#r%8Fk/NEbs(_3d?Ntep*X^L=id[rO>dp70Dfmr#[W;?U\t<PBq#@CYl`WiR?b()54
#aW63*cik:4qs*%r+ZlE7ZZ/+4U#<Q&Uj%n4_1'jIRHHY./l%P1p+fCeku0_<m,6HX!]Ai'pn
g$FlAV-,7Vda)^;uIr=T2YP:7:^,!O4ADa.s,FF$nJ!d[J?Mia\O41tu1:sll3bec2m[-@DE
UGX^%AKITk%.56_BL5AD.p`Fbia%&Bt=)Z%h%nO<!X>0FC32+8L4"uQ^j<iW)P_jm$;Rq\Ka
l*GiCgVFmL\Tl;W`boqap+?DJ+2?tPRl+Ulo<GH7H=<k3i3X9h1W1LsIN;?&6Lq`R2fO5dGd
Mk''JY>;$B7H]A1R#>\Ln\+Csl9(1cr.u9:Sr?NcK:X-n),O%.hCR;(d-,TpR4i16C]AWlHGPh
M@jJTMJt(2o6*@<X3b,&i6\K+ALjYKC:qI5jrpC6(Ze`u(#;']A^j]AAbHYO]A<,V]A^+J*8>+^l
o\N6@IEHe\FTOI782*--Bn;)0[:<K?s10+9o"A>i(?`rb?B1c[7J+^F5CZ4'f*!4gG$smj05
6Mcf5KmYB2TYn2HeqB7XGiPC2n#soU,A<m3b,t.D\u2m&r"3ps'!N@U38:?e"/6ng?FMVWc"
:JnZG\2VXEHm%;'j%k+_t#4eFCY!HRtS.^+<urMHgl[l1_LEI$m&\9)?/jT'Au'K)[=H'l%k
@$iQu@Kdo%5;cbbQ[@9iT(:bJ`sfi[>pr?P]A,>_<9F:Y]A2B1g003B/u'+91BacY`*;3ZD+9@
12"D<4<=p,2VsJ04j0G\U@1)l<!1a\MEQm8%&$/VBg8Em+[D83UqYb=Iu5Gn#2k[U<RVn`ld
VrVdGVVuZMoFD8O^=STp".C1:0d*D'PY_CaSG-USI-&GYXd$2YWogl+I`7,pe(_E"X3jfU$<
.0>*"'Wh[UWD^(gPB@^F\8tA2b%:@p%sH!6;/!k\?-%XW2*=5/.sbMGO\R'(4ie\Je9c[Sb]A
j>.>.iNdB?-mL$ZEhr)'C.4^=l:#pd3"+$Zg-[!$,k52Vk)rR6_'@<tT]A>!@hI`HNf_Y#"6V
R\Xnlhp8Ie:+LRZHcL'2_*K!eD_)-BCYR.?%#jFNEB(sMN5gPp^uWO+S@9jFI*6B]An0Da.bm
!k0c*H^AJ06Mpfh>'C5<kiu;Sf8TH]Arb/PSYGDo*THh%4uS$;":fMGRC@`3L,c&$jMr\7I:l
m9<kgins&p)nJ@N5:AME8mE!Ol/5YcR]A3e:<9rXp-><+U+Rm]AIJ:+UD+=?;3#`>j[F6t>LTW
gPW5Yq_5Qe;ka\SlhdO+pnIp:e5+.QR9),_;j'635>'_O08l-bfYF:%Fq5:gS5Y2jm[l16)`
2)6p1m>FAh'GHd.WY-rM1`9srNSBLO>P^PY6os'hH4NHk9T?LAaNnZBR:nt#R+XNco6/[aY\
?IG!k'7FW,4mY*&3+`Sg6@XpL?6,o`^OB<9eA2hFrU_6N>_(+<c4a8;%&q0D]A+Sa"Mb\j%E-
PEi&84hppHh;8YJT#3gQX4(qW,(O9Qs9[`4UBpNj\eEbdQ1GEN1f*_[t=_aGL18dS_fLcB?@
MEQ"*4%qfl'f<Z12:+*`spTaN0<[?gKo@Vc?3#7CG_QA3"l/N&l<EfMjhAH-*L`9HBZD>3eP
F(c3Tc3I(,=QC'+3KHP@R5JgE]A-.4;+]AL$/diDO<)5;/J`*K0#k@A-jA;Sp7X=Ttn_Ug\>Ok
od_DU]AN2gH"Rl"ciD-Qj?9Fc1e(JTo9o82Pa4Y>:?^_6Z)eR;SHeDF?XHjoh2jrR)iV7"Pm_
V[inc@#4\1A>K3`*<@>[c/p@NP)TRAGG#q78HceM?9Xq;=s(Mu8,F9g]AK$N#.18YY"lj`J*C
'tt2Lelrh)d@^hC_`Km:$Ds=G-q`1UYeBJSp.Y<9,saO"7G+WkQWhW@un[?.'Xnc*9`$WEh>
#85j-n4gmWk9g't%SkhG)Ma`6*qPuj<DC(=F\dL2Y\[lVNl=8YN;OKH?(n8H-Yp23s6s@Th0
!li?SV9,J55f.>n[lK):F>(^""UUq=+55Ir17`K23n`Ba3:%Ta3ORT%L+[/K(;UNDjr1JbDW
X?k2DdUG&9;7;%5@M,+V2KD\nHJK="@rR>!ntq!N'%e;1^2'?L>A.B9*Zp6B>ma@/Q9]ACYD1
M"r`8orc?%XkbVe[Z<q$HbbR?'of&FJ:tl$>5[=rTY4>?'\%;&/TZ)Q^f2I6QLfOT1HWoLp3
ePnV^?l^6t$qBKu\`^$&uS&-nmgE>8=XQ8UX)pieE&a1)@\X]AWHrJmJ(k"jE,#,_=]AK^+X)$
!5>*SZc+=aTA*'P$653kdHA!:!Vol6UT"*&A(>dB:n=BaPm'#C):Go,SK5C]Ajc07g@@Bo^Z*
T".lr:*REH4hS=k+BOt?L>//8);ik=_A`AWhN+$mU2t0Go9S6ZP_[NgO/E2l]A>tWTR>q_k6b
A0j0,O>$`1[>G9IFCZn^]Apbip2f'#q9c5,j+<0l3/92-QBo<8o\W\5B[4'25l&SL,t"h,$tn
T5+i)fW"=_KcrD^GYrkjm9H?$6ru-i)b\ENM_@fsmKb?gTl)S`J\T4,e46i8<D</nls(2_Na
7be"Zl*=BoMi"LpQ\'Y;HLm[oA\GeUm+A$8?#m\Qa]Ak;m'S#-s2$#8&g1XV3(D-k8,1+0>VM
DSr;B/^^i<V9`;utUD>.++%J:jNXFNrVX"n5<Z(oMh,Qp-`eD=b+kGXjYpLH01.H1YQY8?E!
kCSuC98`@MUOD3(h90L6"+WFd%KJK=/!>Ss.4orm>(*SiNOlHg`kg_W#D,&XO@W#U_RrDQ8Y
33k"WsC=*,XDM[*LldHom<_OVYkQ/H67cYWuQ4XX+%@?n""V&CA:M&[liScL\Ee("*nE,"\i
1sQuc1Oq-d"Og0\;bSto?@W?P2Z3N>Y6jAT=m>QHYu>5IOpa:eJZRV"6Hur_9u/U?p`S)PVb
@DX;d\cT7]AHYB(TtPO3sP/E?q*OS59AO@7uY:nNGYU/HrW+l2,to<*j'_Y#e$W1Dn(biVMI9
RI?TkZ@)gbTdOLq3,gYZWE+r;&qGKfl]AltqX]AEST<D[qR"5".uJOjJmmf)G?u>-FF"$M]Aso)
RsbTmqF@&(c9DE.MoAO<&2b/LIq=\2>0c:YI!a+k#>bg>F454S@[W]AGO`/iVBS^V9[uCMQAP
!alQupEEanl_2.'r@'e=Hh.eT/tI-%]AqK1[\pWa%*6Qlk)84^6P($$mXW(<+/5H+Y6Jl+niu
Y'*r;#6G%HG?747g:+3?XFL'_(WdArGrO+JSdM_D"f$rKeX:+TS)L!Jb,V!7Fjijem<.q(We
L$oOmadcL01I>)+;(WrqCo;*/H(K)XcnjaU]A85=S-'+FT;=GA>E2q,n=J0':uuMFZWs6dA#-
lXFpD]A]ATH\FP3c-1H4i,6mjSS;Qp*"Mpp8=EQQ5C$S3j1eWAeEOBf:'2CCdSZM1i%mqRiQRG
13ikf+JtT9n7g]AXc]A4mlSWc4"mLJ7#ZA993u(bnrsYp>BegqhUtWtK=`(5HkSVscW52qb16'
)snVVNFo#1k^"1rs7d5Bm3m<fd8eYC=>8$;Qbj+s$M8gX@sZ]A9TD0a=D.F^c:+'%h&pmHTaS
m-G,MTdm*$`ZbI;UO,N!W!8X@8'.Q4ZQu(c?5%B_6b:E7Al?bOI2D7]AJWgLF1VJ#Ep=&okDt
gkAe@1ffk/f#3L^8lAji;rI5fA8#U*p4NSSTF<=mL$0T*sfGkktHTDd_\M@=J;bHic&7n,u'
#jT-mEruTq+R"<Wh*p(UR8/UFf*guiITn#kaIt(.g#QF`e-PBhGrU1sG."Fs`s8*q)Lg-Ak&
:rUD:`7Lum#R=B\m4d+pOW>T~
]]></IM>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="5" cs="4" s="5">
<O>
<![CDATA[若航段为往返低主舱利用率航段，则标注有该图标。]]></O>
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
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-13732426"/>
<Background name="ColorBackground" color="-2167817"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="NullBackground"/>
<Border>
<Top color="-855310"/>
<Bottom style="1" color="-855310"/>
<Left color="-855310"/>
<Right color="-855310"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="NullBackground"/>
<Border>
<Top color="-855310"/>
<Bottom color="-855310"/>
<Left color="-855310"/>
<Right color="-855310"/>
</Border>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="NullBackground"/>
<Border>
<Top color="-855310"/>
<Bottom color="-855310"/>
<Left color="-855310"/>
<Right color="-855310"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="NullBackground"/>
<Border>
<Top color="-855310"/>
<Bottom style="1" color="-855310"/>
<Left color="-855310"/>
<Right color="-855310"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<j+_P@sW=>88Y4Zm#ZbfrCa%1/qeJ3iXA)>#>;<!<FXT"@P^%Z!sO>5`JB<M,lH57M(6o85
c6#"%&4e=c(?&+Tr&rAH.88^+-D-f"SQ\n*;A$7%`9/\^,]ALFfmMA:O_?6I?EME`=G0-@$09
*Xh-dl?ln6Y&*>j!X<@J2;n"@iIdk1uDS*$?G/n-Qi(PhQmBHh+W@L1sVIn+r.`CPI5PYV/e
5p[*W,KFO=*Rtje]AK*Ic`-VeZkMrrc!Rgo*b0(6-2V8?FrXfNIe>57`^f4i1em;j1Ej`?.o5
?eL2Wjkfr0jP+*O=p7bA!-m)eFn3Nn$d9ul%G&hs[O9`P"l#j4KC8-d+cpsZnflu;'o`aU3;
T88Nm]A[SVfiU^H[AqlE>9k:*1!tX!2,+"n1"s13^pSWSSo!1)Wh$n2GY!Y=UprkS%@LmnS7H
@DoAKAY6(pO+(\%lVSi3ONnQj>S[XP"8rgtt(SEm;GG,In9OX)/]AY(k6%Y[rJ(GS*KUa-Qel
GC\)F+PrneAXnOlfC\&S/hJDQH\5p%>SbMq0mmcai^uU-k!=CVUInhJrb#*3tqYigH?c0"<_
`RE@_er01d;bMQ<[Ll/<;AN_r[.B*o)X\k"pL!-oFjf!^>JXM\joVA%CqTECD6(L'($<'):,
e,*,o@5=TQ7gj4aE:$LjC)U&\7mJ1JE0Y<:QG]A!NJU09JZ\AJ-OtgBj=Ad+kFmU^G\=#g]AC@
fhFXH+*0Jq7TUb?=;!*u@&pGceGr",#1:]A'R@JTUe4FE_1.!=AEX-&QOPFOj>aflTi8N1JcO
j?H8A7@PTF.jNA>J+;_st$m*dJGhp9IEsE]ANlihZe@ra5h\Z6tMQh+'!:2K>MnArc:b]A.1o)
nH5Bk;?P6TrnL[>M4-$ciUYG:M1?g^0/plWe>Jp]A7aZ@I54rP2G[b!g?R18Ai.Hq&9\7+6Va
(-_53`(X4HZGl;3og!+i"qkg2D6_OA4)R]AgrEh?B&YFq!)i8o<kCLS2>c*LmN]A0#BXF@j'J9
Kidf:s%V(BSrFK.[IK?mTqS;i2\"=OZ#PR=3qcLl6VrNt?QFiQqoM\XjW,;>Tr2X?q\%T2aI
P>R3K7hCVJMIc7VJo?OCU7+9P+"^j[=GTk.\b4I:oXJ(paJDK/eqO^iR^O7rF9,[i[Ge^[)?
<l49:=Bckc?BBm,1k)Fom>&WCN','LWO`(0@<>gD`R3D';&*Uh8MXOa?.m>YHThK#7g?>Fr<
YXQF7"Q:!e3[p6$*.r12>]Af7u!Y2`[mS:]ArE#S'MCl]AE?S'kV!t7*m__[CGB__9r$p+WX6P7
j]A/k1HMskFPWMd'.KqoD&g"?hl-`LK$f1/bHT>9I0@W#04]AmD"M?XIHBj5CV8?q)oAPdi2,?
(Fh?/=JKZHZmeB-F+81QnL,a#JK&rDs(`<4Sh]AGDgQ6.n]A3/CDbuTXa=44.EiTl!@df<IKp"
e2V&3_H1.\I3otRp08stB5]AF$8dEXn$E)Xs9!?uYMMFWamRlr;3b497F>bdFnes[@Y=d<<)9
$TA@`^'"S=VKCEWNWsG$#IEKSN4NJQ6dMNhi.f;!j7c\3!iMbAph().a7=3L(:9!b;=^gE9d
?=fp:3GNB7QLAA=kF_k1C?KX22MP`c7_>,mBD*@mB_kc.q13Oo%G0fGtNZGb_P4PrhMa.14d
rV7\lo;8+"eug7WLN^RC8oLFYi:HA+Um_Gf<cie-2JK<)6Z]Ar;Nj<!8T+2.$<&>$%(aq!QeD
;Nic@)h<,sL,'W5/uL1KraWIfnpLYCI7Q@d\iFBER&g[E5Y*5%.emNpo'=#l9,KIj+3n,(PQ
I0O:YjIG"15PPkQC4c/ehA\*-6CY[Jn>U40CWjS1!C8LH41jJ+T9oP[K'2o/fC!Ae.1qW9JQ
BW'0N9gi!YeH##bpSN8O-.DXu:C'M%-NT:Cn!r.Dn,%1cLMiZ-/T%b8H6u/_B"UADT-ZBIt3
Z8\2Ma&jMa;H-#HQ7YsNg^REU?(,<F0!Wk7G-I?Pm@49_7"t=[E(.\MCcnV&n%[bU/K@88[^
=H88UjM$cE/4lR-*\E.N/<'Y*"Q5&!LZ.SbZc!p?9.L:KKmH&7=_d3^/H(m?KtjTWiu1AVQs
&0C^DRc"39[tW1f7nDF,>">&L3@PRN;#!s*UaGE^!A+>f`Zn-eb@AKSIqE[8LcN7JqrZ_Xk9
AB'4EA:3'Xk'($V*[pqRnrVnFmYQ5J4%bfD:JO=,;<\IW2U7@S>TOmK:[`k[/O2/eF/X=9bN
5_#<[l_$rfH[62adAbC@dTmejCrfMH]A1\G0ZqVf]A7qW$/&6Z(8442Zs)jCI7no[HmFl<]AIAi
W3HBaM1`>*.Eqcs[mj6[<^jG;_c[LaG(o+MZcY"_/h_rGMP.AE\Su<M4mhpocX>0RC?J'mig
n<ts_9A)&T*PAfc$EM>H7r9:/mKE$[XT%"F#?6GNm!c\W0D$V[I4_`T>+=b4@%<dlL0U[mTO
Ls\H0R7TcfG*rWQ$N!(2i[dU(.lVA'FtXht`A/SYe0Q:ha1_2o^=FSH'+,ndRI2?-dek%d\;
.F9TJVQYZC*_0d3@[*<t`D:@CFuIN%4!hTT]A[3Q>A'^4]A\Jk+.ZRl7[db\@OH*O+ka"tk_Up
`hk'7iP`!MPlT3r$n-#gSueQEGJ"8:W2LTSGUm`hP_3EWMFh[0QdlpP0WE=SrDE6Bs<(^2G!
k-.ul^;qUE+gV+=-'l&EU.!VLc6brYblm&&P`Z[Z`.PSeB`;nhFV!Qfb<3Y;gng`m=(7aoFm
,\"XR(DRpI!:^mk"$g%\U/[dKAuQY`j9S1?#c!GpUPfXHep<R6>MRG,,R,9CqKoH;/o/aYJe
eA4<:c,qJo`X.\lpbmZsWe`9>_o:$Yh"Pd(!\,_CY!Lj!l;1o*=@N2c>W(h+kROD#G'Ljfau
HWdO.G,V%i;sS36^@V[)ef\Yu5(0'V5/SH8/uj051F3RfiMmFIp:qlugp#g_H:!gm'%**PQ(
7P%2h/#Hm7A14m(/A;5O<!1@UX/p5^XD$QeT`'n8'R`V3g8'>`&nI!C>F<K8:j8jCRC]AEE$`
^MmJ_(!OM<u8U$_R+j'e:RE3MZ=tdTg0TKH3R*+$;0HcjnQm8m>#md@6(Lb,l@e;MHS.`Ucc
&<c<e=5;,%UWCY4&[9+F&`$_L[of]AhX8o/2tgg-3$<&K)OK99$]APdNMeg3sY76_RmV"ns*Td
8bZBn/1K,Qg>=YkbMD4)qpF)h;,mIS@>:nsJ:,/_L!XWGKe'>T<VH!WObHdgbnmg+-*Yg;o\
Qo5ai8',K):ub[(A;nF5o`>0%?d6%UA4BR+81pG_p_GX'ZYcoo*4Wg:.6,-F)h$UV>*WRtJ-
SO<9?&hG6.?5f^s^n".Pt0^o\-d_Crt6B?,k?oBP,R*>63b?G'II,#"7gPFRAeh\\:N6hD&f
8g3N/h7-Bls/]A>%$!4;-@[,Lp;(Bo%qXnR)Y.&-,RNRAE99$4_k4+QFY#S2`4Eqf(dH@CgBY
:f0Md^E63M$7DGkYsKgo]A-]A86tTi#k9c@>Q@^aFBQMae5ktBhR!#324,Hf_RMH\:dMheN.!u
J/r2ZL(Go01R6R6tRYg@HI&5N_)j5HRLk-]AX`Xe_u#g$L#28r>'ldR21GAn1Fp)S^21\mg_R
DVg3<XtI@.p;sH3BGuTYGP0[>@Vd:/D)`\'(Tmri)m#^n,<R.\Z5WBBX,Nd$^u0gl(gNAo7b
`79h)KR'm1EbU#[\_G:4eIlmLItJ=oKUq*lc.8`.tR-Xt0II___bp\\P9B^,)=_EA$"+k+mO
4R)RJPH8_#DW<nV>a)Ifc7nWn!S8i"!H2(q<Q?aZh]AZ[7%<DIX#*e,V\nT_Ya>RpqDbcb+FU
1;c.!*g.8_p0$GJafVje`]A/)gS.=_^Qg[HC/7-+h/km/:m,EA_ef2W3eR,eUnGr/U(^+WKB@
>.J7E_#lTNdmDAj*NFfjoUM;0*TkmuSQ.M"0%I>=<$gL,@sTAf0WR!K,li4pe)L_<Ei:G+M)
#3_n*NC=%Uk'0=%?/Yi70TbCoeX`a4VWbpb=@XQqY_.)Cd4sG1nJ>l_FKq4`gS@;<SZ_Nn`g
2_!r?%&j==h$LNAMm;\hmpJiL[#IP_5CcheqP18L_fRkRd*tmiU>YHU70C:<YW)(QNYt>,hk
,:bN9;E1LXB%e;)f(`f#J(&!IgV3-?]Ake<<nfh/'48L194k![bl:!!b3?J6MTGAXMX$XB,H.
OS57dR^d=m,HXIRLTl!)j]A.i8Ssu+2g/i%-7hr4l\XD([RL4T)`XN#O5?h1-.0,lkF6XrT^C
qV,1%g2HY3E?Z/Z*gO@7&UHh"Yuq?62t^5OP^L%p%Xd%h"Ja%ePbhTBlr'@4cu,<k[ii4fKp
>@N&+=>q&-J'ULNO+;Jq^(F9DC@=)PWc_+i$HLK)S>Ru)]A<6SD+'R.DWHb8@jabE2^hfiOG\
u=LZm!Qg>(M$j!BCX;`2c$pWZQTI!Q-^g=OGC1p50.0[=Q[l)d;Cu3o@4ZOV]A]Ah=7R-KN+n-
dj8:$OX[W8W`\L%[(Ik##>.(^sW5-EHo>$mGDnQ8)\i:-rr')YLh9]AI.p=aoUL/h:WmN/?/Z
[d4pIQ5A2[T-/BDM1XL-Mb#M^MAtYj#1PB9V[),Z&1P(Hh8:WhTEdMUY8HE;*ui(UEYqgUa!
hS')X;6J%0,D3R4R)fLftB`_G1Q6bJmR=OQ#oEHJ"0@]A>(8<B8<)2/)*\Pb?E2(npZDL*0)m
MQ'uaf,Mh3X"D0VX!>hl>T"bngIWL_GdKKaou*-haKJ2Dca1X[Xea=hqWA(@#h01s"n]Ak-+>
3c,q5]AM%@#\P!"[CPeWTY6tnK[E4HGR_fp<6aW;gDUTKIb3lT?/(#?HZqRa@>H-*DenNiQT/
$V>GL'G$;j7<2X#<cg@;Z'3aFSkBbt'5*tEedGX;+KK:Gp3a8WF%U-OF`oWTrW9'<QmfOO=T
[qdNEGMcl08fE-$&qpG?UQ7b(M%C$F:&qVFKglK<G'DJ*P%<+/R@M^1Y\nROeGH-(5=n#0Qi
C+I?PfW3FP#bn#&ttAUSs8FKT!D_r8TJALF[3_mm<;`e%[nNHYkpYoGcXdhe8ckH^51H:Z#q
T?Sh=<7isU^F1LKdJ`BT$gi!_Y&>pq3TD[;+I\NNMuJNr<cXr0B+N"P)W*]A$H\qQm3CT^JeW
aVP#CAZQ=h-Z$U8mY)h2GU(qtE-4,.bLS?A;_E8HVu^%GU#V-R)sL+4lap^m`(Umm-jBOke=
e(7r/(%GI89eCM_MoWQAM?Z30>&E#i!)]AFioj'I!5Vk01!b(<d[['6!$^".Y5o[!#<_;ZTH9
E$`>CVp5YJ;WDZ@1?=@UJ9BDkG>uqooq36'l;NT=e!K$/lG'>[NWjJ3W>13XB,SY$7W^CHJV
CNgIq;(<\+6Dj4a$X-]AkU*A_W\JY(>*D<5]A:,2Q'/;Z,+"dSRWoXEoZR@:Ea6.#mVLeO'Km`
.XW]A15>BmaC]A)D2L)K5*/EJQ+WYRHXK@r"DSlFO^2:sf6Ar]ANU!4>WinQ;c@>tD*)WiQm]A<E
GPnKb7S-<9u-T]A=TiG+lLX9]Am(K($&te4@2%p1B+#.4'6WC5g5'us./Ts7\GZq;M'9bnc6o8
0=d,&]A>S!LC-!bD!IV##,?4NI6.7UA2F#5NmS!o,_27jTgLBbULjBpB_elpQZ)81Yc_,f2'6
OSNR\t5hYhGHn>r!!ZJZ-C<$a:GQs%8W(@n<5>2C;M20icoplHCN;hdA/-'/+ZTW.=)BdAAM
@j,8G\,1g)oNp[CsjbGr>+V)Tnb*=9D\GG!_/\\3NpQdXVM))rcP2rU;m59F#8Enl^2>2KB>
3b'C+Q&NV8,L93m@<meC6!S_#I^BZe!X46PK</Q%#'GLe'@S[&,HWd8-$,b=R7NIM2l]A)ka]A
+j</hEEtU.P#g[//WRP@W0,;rdXh-G2&2A06X?ih7I.:3r:Gec<\eQHpF[O&h;9?*oetV?1J
CKH#*J?H5TZBQ-$rl#\CW)$%*W7%P`(ndlk;+fX#J4hZeaFqDa2$7N]A01lNB/dK*QlXqbEB)
^ae$R!YAsT:B!ZP!dHT^BaAgHI`Dc@"QLhK_j535'09kg)s$HAfORm^t9.^I1kTH(>K)u^^G
'3BN!!,Eqh#M2_Q)20dYC0E*XtaR,-!V>N.&$(U$Hii/fT[&Wh0oXJ2j*<X0eofV?Y51fnPu
4l"g;52P2L67:5Z"L?=)!CFKRb'tGH0O@(V$Cf]AXn4r%\%pWJl[hK:dJn6C0SiXsn,nnQ`@?
`?+UW+W&Ub0)@rj>h4AY3Z_W791pGM'*=*RhLXi(6kt)lnoS9<E)7k%M%]A\@oS2)@g&c+*rl
fqCt-7&:^cuCtjnBdmatI`:FaH-]A'SrQ%WWOoNWU?3^0B1GB-#!>7r5Y?8E+<VcU!"!P[X&r
Z5U$(m.p4*4LKIMF;31*:>_pBRmtqEQ..D3:$!7_FBdOO`a;Qau2/=S"=Hl*0YjLU.n0Lk[M
_[>X:VbO>_kq`rY)O+*#)KYJnqjgu$b2BI^Y+.fsued\i!YU.-^jciS#l;+-tm"m%)#AgS)p
KWTZ+rlZf62O(((KHJ)eO(XA@cmKo7nFeCf;CuJ74mpcWe-#KMo.4VdmU(@[qV#V2q"[:cT3
@qAH-!OVe9R7cdV#G:SF0]AU@I`KG6Z>c[:/abB)'PA"TKlU]A7SZ!S_dFQqF-B=<b]A*0rRi&2
g&>1KV$F'3g]Ak'&S^..INGK<t'[DT!kQkbr(5uKb+&?*af"YV5r<iF_)aja;XQKu+iA?^jB!
_oSb$dt)3WMZDHZu"fG;mQWB1&R?OSE$R.;Z\JNAY64&DS#S\culs8rY,QKis)""K1/Ip'U'
O<:kD)#OG[\U;ZY2&EGTbB7bpmC.*\%*nXhmZ-i_<uWrSm2I"r5n[Uh);*g$`+<]ARF<[Pijq
UD1r]AO`fi\A13F?V;>G,o`^'GrFFs$5&=9aOeUp#RIf$<FtRpk!,r@NZDb;o3IH"+?BBFps7
*n.V'r*1Qkkf3FjG?/n#G3)Oi$+)2:]A6r9U]ApNc%ZNcBSMOmTo25(1KJ]Aa39D\N',MFc#d@0
LRJPat80SGBc[nKm9q$.G`YuPB--;6&Tr)b`Sqf45KE5=W.]Alk6LTdU5rA9&>cQtrg7h0F.O
Q&[9#SC,[\4rM)'D!8^m>6O)]AsQB3Lf:&FB#@*-LX1^lF<uN8T;_YDmS66;RNUfi.N5Oj>d0
3j+S8iE)Am3d[Osnais;mRLC5iVJLJ_jqfDYig<%u@DK<IB<9=ZVGr:kn5.iM@B6*#j$G>s!
1@A7D^ce>/-uLn$5t5URI>h,p+ps*K='P&Z@R;pj0s-7[(53"]ADM[J*[s4\6>*J12Jj9Jr3Z
FkPYh/f)LN_(]AbA>=)pYq"cERI1\VI=WsB,t;@:@au9BmXNH-o_YOmcPR%ipkJ\Vq4"!?<@>
<ZL(W`;Ss7MVC[J5qni*Zj:H_XX%C"mM0@R4ETXNk?0#@rM2"jn(bBGbf/d8!gNAc]AMb5Jep
?fJohWMY@*C..C!(9BY!B$T_oY<@850N2n%P1p+[u[VZ_[Y&sXC@q:oe$AT[I[rTIRFu'aC#
-s`l&tO;]AD"6V:@PG`NchND;D%7:+#BHa0Y:<DT3IKG8)EJ/T7,>!)*)$Vn8TZLtguI?!:L]A
G6st5=D?ctPLNBMl!/]A+\U&#uUJ'jm'NVOI7q<SYXEST!X/mG\mM`2B:#!T)lW\[$!XG044?
@_qfP&,.>c=Qu01oaIWdkDAIL#b"\Z)HoW]Am=)Sr%p'Z9*FC"glLM@.@-mS_M5anj7=0U!d2
h1G%`b7'Bs[A\<geH8ri_3_&s&iKrfrYfZ9#+H.0@G$!*^QaYrkAR1l!/7Z!779WV#Q8hAR[
aH6_0?$)nd[i1/Ab`FAgttgf/L4FcZKM+IoF&W!+T=n!0.Qh-e5VhiL)9:g4VrGomQ.E6``R
InIpX%WSQQDf9S%a[<^oV^CeCPLF0;<fO4&&1HKhKhX)^'a/*WT$>uFEtXmP.[+Q]Aiflh>oC
VHVchM6/GM>&X.-7E-Bd\/`kmJjq,2<%,F0#_%#BBVJecWjH7]AfQ7bMe_7dT$<Mcr2=,ECp_
)&q\O=3YGdKZB@B#K7>n`a=f[1(pqoWJTpMP(*qr,XLj0F5akL1Cgp]ADQ)a;(*0A8B?g.JH_
5Zr<X"d!1t8HCF&QYF0]A%'6V^R._pTJ*gs[OG4^;fof!J6qu)N'';%p7^bL4V\*#;c<Q[10f
jQLSPRN<;qV,n0p!Q!]AR;9q--s$LmZI]AVuEDGKX0#($Q_OrEr.lSZZ`!I>DQ[qUBrl.8p4C<
L*.ILTV9Ir<?hqMZKTFhg\.q?-GICE0X<%T+>%?*gHdPJqT]A=R=/1TN%G\##r'[?.(HQ9>de
;i-.UIG?)aYLW%fht$B9<IN>V*AaQgQ>0L<K`Up?*j_M;69t:4&_DX+n8@r*o'k!2d@r]AioP
Hj$ChMI@St6E#>!taKK5RXBMf&(+o.WTS&Y\,^&!,AE7\I?]A?qUC8E66Pl?+o=qKt'V>_/;^
Lp@HaoAR=e<gbD^j8!,h>d-7h'^b8*G6@ar9!j:nN'^7Db(3NNlRA@_t<aDK7)TF`]A[&UVtZ
92Qp0OY(0;X?.%2mUW:/cV1RIsA=uUam>7e_ASlL*'2<mCA$Fi%.k5g$/p#^;:26@5-2?,F[
t%2e\(PWm/4H:PnDBQGR/GRWagOiZsbCeV\2s-Eqrr;5./XFIj\,aWOK#Huo=@"[=&1NNfj1
Ca*3S]Ae0'(<b4J=;="=p,1&M<gXm]A3Wr1()kA:KKX&/_sErU\2P%ATWhkNTH6-+130$A4P=X
(LudCPd0^(;Dp)C>u?GpiaX=_kTD6A/K-V7:s^9#2EiEq2_'Um&Y\bQA$hGq^[Cq%Rp[\m-e
\?Z==]AGW9gXDs6^99obCd9"Rc9iPt-!1;pGtQ&2S<Q!O[=7J#K#W_X&IO^8uD/2CZ]A"u"b#M
dcf./=+OFV/Bn?\h?M@O=jr0>\u)]AE"M,;$p]AcU$53!WC7R=[&2D(?Gt4BC+W_6arj<THYOe
R<VUEJmQ-_3F>jb8.[ba*c*BH37eDsB\jJ&.PL8C\mI2V=W>?8JIa/:%5I./e&3l0YMU=EeM
aZN]Aif!,LbSYDDVA0)B@-?^%V?9T^T&`ZOc>(Y?/:$<=b9rZ6%C2dh%L6(L,37]AMRg^&H$lG
0i"k<'iT+)]A68/qTjOI:K7>ku=Bu=d!;?*meiZi?cVj0eS6k"dT.K]A."fT(`^6Hhi6V87WY#
ue(5hGYCWF\*e+AD*G1O,07&U((3=dWCAS9brt6\LN:fWUA8sU#'If#e4i-X![k[-hX;elWe
Q3Q`9eT'!gmq9Sl<o@TaE'Mbp/qH3aI]AVm_1d@VN_`t3LkK&k)fV_F>ME2B@!jd^A'pY&I^%
Hh6;8pSFX#"HA,[C&_bk'l"\P3:Nnsp;$,M@k$N\X"N#&BpS^8:iX2MfU"8)O1:,l+0a)tV:
<0[]A0iOuoO/O0n%4)*t*lEn80B\g$je]AWb!*9/?A-FrS^oS2R;DRF)cA+so%+%jY0UVBNCiI
\j>,ND0KJCl#>6(=;P$bZ19i2n%q4n.sJ%"X)5%InS^pR.J=#-aE6q]AB+Y1s9BnH-OoDKht'
d%.Scj36aJL*PoU>n\jas%o,,@)/b@`l:lmt+Ln=F1e8aQ1R%q$Yl2OV&Kp%2+,OLUdJhH)m
R=Z32)pM;6oCOK@%]AM6Y1P9WQ?U;>Fb%N2aJOCo3Om6Q>15F`]A23X[O:g,F*7,T4@>^h9iZA
%r\>m%*014OY;#`GFs+f$eIur3&F=Q6X+i]A3YaXXl'Q67ZtO7!R*4QmY<pPa23-$_*(;X4fV
DNjjoF/854!*C/3lMWL9KW[\\qsE8Efm"g6!,^ugZXCZi>H7OKXUfL&q]AuiNh&.'SoILAhE`
e]AOe;!jn)O=Z:'aCp%NYU([7A80NkF5u(5,37n(C4N37MbMaii@QRaggo;,`'8JPcs"7RO$>
%+=;Q4O.S]A'P5@HFW]AM.Er5NQ5D0i%P5N+P/;Jt,bgJm=6-aB"SN*>%E#M%8'70+H%)<Tug_
d$*1k,_#W:df+L/mE<]AC%=8K'.p'$S:nQu,`_>;FT"b94ZPT610PffVF<-pW)Mp$:i(*^G>#
lf6'!c$O?'07^_hmGiWl\Z/8)I]A#Q;3_D3n;?.QD_2D_ec*mI8tQ(7/R(Q/g+mpM*adjrMk*
4@lQ`P6)[4Ca&hi.(B:6eI(^R%d`Z[Y(k$c4"+E%m.NP,G1"H-%6mBKU.c\DD#tAFjV,H3NW
Hp!`tt1^Vr[C.i[=0V^kOI<d`*<id<e<!@_q,c2Ju,V!cC8\EubDiO"L%CTcZ>;29%#"&Y(/
k9u^bhOd^V_!3"C%AP*_!C1;<@<q4'0:8`6)*cB#O%qW8-NfY8_=fDCCV+bkHS8>Ed0?S5A^
YRfHh->36pVYE5_Z#?[Od*PIMH='FR`!Nd_g1B1XR"H.fFWXu5L!r1)q?,Ts7fQb3Q.Vt;lc
3sd![LUDPi&#p,6#G_um!0=&Jo<^-VjYX82rnVk9c95MRqH\`&m^QAp_FF"`f?J]A%4'.?]AQ[
;pOMP(,ps]A:Q(F@*g$j-en?LTE$Cgh#1<5j;e;bh!.t+"J*aJ#19=WoNt\gk=<823aP!3)(5
X@D:)GDF]A*FRkqJb"h)g2=IELs*^[BVN)(#^X@M&ncfASj&L_[Ps"dU(GODaAs?bE!%<G%[q
a%puE>&DD[tn;n[M)CKf@Obet''1j3g@<b"L(:42`a/WKe@]AtS2*8Zii'hLm+'o,%02Nb8b/
/,Z#*_$3%YJI#BA,U?Ud*AFO+AKGUP-OOEFo7i[7aFP;ne?#V:o^QrK.eS*5Ru;11':<GgAZ
J;0@=4*?C&#?4c<<V6sMEaS>-V:p`-2P0W-50BkE;&8,=utg>l>Ca9+M+M9>sq3]ABT2MN"[u
/P:DYSNT&"cMUt<%9qh6Rs3re?Ct[(FhYkk<t')G0"Fnrkkb`Gok18q9cJlV"A6/!:IpcA1A
uK%(L=[:DRmO2qAeq#jP,uobG>$#=Y%:Q?ImEN$N.*jFEY#K.1ISNZQ_U[F/H-QQmrR?IpPf
V]AXYS_qbkV3en5XhmEnd2I5l,pZYqdD4f&"bEs@1WB!aAWdrVXHC/u[U2SJMeCLY7YCB>+i8
eO3a'1d]A'nTb%PDAtaM,c]Am_0CjH4.qDq9Eh_C:j2E/2J/Q14_$]AgR&6R:S+s0Qc$9Iii*g+
'O(A44qYQDK-QBWei80nPQ=9+\kPu17"OUH_iYq"qWqqL,Jr+::ccEBFOqV"6U87;f5GN.$?
R7]A`j:qL?SqQQ2HcYu?C,&*q$3l@UJCcPs:GC>1fH7)gj334XO>0;7i[%6!EP-A5$]AI1(oNr
p(B[#breePqoi.AMH[fQs:5/\\@]ANfH$?(*dKC)n/P%ln5P8$F6p#PNj9!X/7p4\NKRD!B$\
ImVjOnT/iLab`5%VQT_^u*/Zh^^G;oH3K=sZ!oRm2!f"61LKlFLCWW=*W:`]A3#Y5fWd*^cPD
4CS(1ljUHF\&l$=m`oGdVp7t^kE>oZ[S0]Al\`;i^+$'!mDDPq*2s)_<,/2?r'@[2@*F5JlZZ
,AIUK9ej1#7]AYO#KbZ%\(/UK<htYm!n!X#I?LI]Alim*4IONIDPZ*;>S//]Ad&Ko*?-j#`_;r7
E&Nu58To6)Q;5nR9[]A4"Xi@V7"FBh+=?n=5Ti\"Kg9qH[r?tq6plA^*Ro"nE_P;DsiMF+O"i
\/H>rF,K;TUtKSLmrnUnheT190h3'l3&MRnB^'3@s:28_lN4;$Xp,_J?g38XTt<bEJed8dBJ
#SA^00\(i7':^[[P9.eX\Pr>77X6Me-hcDTL*89;!lHl1GbfP1uRAd'jg^1F:pQ*A9e_YkN/
HZT=e*Z!(NV@5$P=Mt2<_g(l?H.Eq&i6!llh2U.rHb@$H7s=hb<rqP^eYYlpGG672</d\_Mq
UN;_`lPoBg/*bpMuB^_?$Mg]AkA7"Wd@9;@Bg$_BuJOB$WP?>o8$C:QI8X&6j&[0Z)V';`[1o
7WCfoQQOfK[[qE9pNc-oOCoqadoS8KI]A.`iM:A15@]At4l%J:fV]A@YsrPT;LZcc)c)`$lGeGT
sJ@TV#qCI0qH#`$:r\q>pm*)_R292R/(43;PZbR8^"_O68a1rU'p12!r^t15?iRIq'`ZpE[m
SBMOO6k8mC`?04$'h21OG>1l9pS`P_]AoAS5,7G+*-DfBQ_5N?+!YqaAp9at.!I8jk5JJTErC
t]AOL\lm"ake*K"Y;Pbs)84TL>6e53'Pq$!12&6"@t7EB@D$(*ce]A7fq]Ae(]Aj-Omf9?)Nr%")
5oSXPm:g\g8+U3OWS.pSkg\uLf3.$CJ"oE<;'<0gB&83$EBG-4t$1ncf#F%#,\M-JaE+%IYl
>$B`d:LsJtqXU^_=o#a*?U2RWYK$On4iV&1(NZTs.M\aUi]A>JDdn='QJZT\?L%1X/e<L;Ts8
B!sF6VMAQ[9-Z8Ko2BSMI^#h;r`6(c&mf>q[&$7f"5cWZdYq74Xq*<a%$SW$aL2W?LQ,qK@A
:LA=LNlnU;98"7-+r$!E#ZXSk2.(MiY+E<P.N+4+cMlK/+TQ=$,#;fJZML@J-i+rHG/QB6o4
7EjB=0XZ`.60XcC45PEO62+(,!J#<K$B0Se0Q4II-"%a6`Tm"I7.,H.b>L\jAQ?2n_9h_WkM
+@g.$@-mRh3J54#4=^UWHK<F,VXj5Fa*A'NhE\SI?2&1q?[PM3PITB<$$<U"8f82S4<5:.o/
3%C><_gCAs,h8#lD#nFi*^`EtFdn0i<5JS/"[!g"FbrI_FR,W@ZLf]AC%2=s(&H-\D=L2DV1U
Bbt3h:hF^.._$gr>ZFJsDmV<2Y<Okuk>m4(YE[H/0<!FV_HRRD;s3[OMZl/8o'ZoK)C[?Hje
6`,$m-9d9r@fn*7h1d^C]AU8>Z]A(.`L27Z'N&U/3:j(ph&#c!U$(VD``\Phara#PLAkSK1^U5
3PgR<YD\!9U"/)FLP@.`QO8F(X:L--Ta(!!75/t2Ul7sQg)f+0fh12N"hZ%Rd]AjH3H//:?=a
2Gk^Fe;o[*ESN?19LO):js\V$k=h@T?i,aI5*XTQoPQ-5nJ:Qal7F4O0A6[)=gi:LjNWe>M]A
JR./_qhpH#BA=#S`oZ5+ju>cfQ%IF*FG)!>G-))16AiHuQ^bF>&TR!HF-5ZWfQ`C%VUV\OJk
qlTVjBXER`fi:,d:bml+ICmWEDgd:(gG%`[+d1jUFlGI9CusJ*#IZ`&e0[Udq;S&p#-S)Ni:
O6$Sci065CZOnskGDHWb``qb"Ne>M"f.r1R%h!UR*`8JrR=o4r9q?o@5S1=$_=i&_*r`3V?B
hTP6#36&,W:lQ)A+nkEXPFu:RX!cYgl/O(N6LNZ9?=?M-s6.:(1Be"GLXu.ji3]A&jOM0H(+C
tr!(geQ92VfL8up3'As/aBcEsd$r8r,)hq;CD_XCFM\#9#>$e&lD?;SZfhjL";'B=WN>?FGa
\F>/_,-g)D.6:=jV)T!6B*g!*nT0qaM1o!<,i1$Kk%#R/5&2fh0^+_SI%.MMLFRjg8AG9+T#
G5m"+j=g5a0YO.?8S_>rRH88lK?%\FA4Ah@lg:i1@+2,DU/o%fO0cE=Ph.T-0ou#$b*gSQSd
nPX[&4!fUK`$=W$#h!#2&jhl@"T&jA(_asQiJ>tdXkkOCO`j\H9\Rsp2gW\-oJo%K:Y5[)k@
(BZS/@;#4m5KE$XSU&E,@NW8TX$bE';V8`(9KQ9\!NHnUD19o>L?UdTXuNAjO"'(#FgXPZL]A
QBU]AbR9iMQ=q<q;0QA6o70/BtRD;(]A)8QO"tk'a[Y2':B4/A/$:5RUc5ck?q3M>kf)@!6Q1]A
/l-JJi0V`<m=M9(]ANkk;U_FA4p3nuJ<6-]A^@Y2)]ADPY'^kW5FcnJn$9E<0k@8g`h^a9=(FYk
ob")$$06U:Eq2WO,j=gM8InTjTTbcIq^al]AcPn=K<,1mI9RKRM@?%37KV/RB)[dpI"$oaK"=
)*M(d!/A<`p/r]Ab&g\FK[Hih%:<GtWmWI[eWB'N42UANOt'sg'37"kTe&Rg'-Wo6p/"V'49X
56Gn/DtM)rCTT;c)QI%%Si$Y]A$+In1`;aH[#%!-n7)RJ(;K#"\qSSNchpV!?cB,)g#fuKa*>
UbWqnil\oi8sW9j[q)]A<sthm;\8XmJ"&kGu\IATOEn\aZc)1;R$\<rN[/$R7&P1JI'mj7s^f
I2Y(DdKLt4a<[7X'>b6JQt*j%>TX00[#Tanffq1n8h'sm$O3#'1%$.jK8n-2*W!u;[&`i>*P
!s\J*F-l',okU]A&?dD<2kk4NC<m$<Y0Xh<I\f*koXi9@O92k99]AG.HDOlde(d9<,?0O8`-mp
t*T"E:qJ"s6AnA?^DRPG*$8sQEnC$n8b4ADO3NqRIH1I$4h+4$p"!+SlrN"4!3V2U5,_iG#n
8a!QlooTkjG^aAA.b[4n8aE`Qa<d2[B`?i$Ce@jkbX8jbM2`)RjC^/o$GLEOm1&P;=6hkI)'
Q!MT$VH6Zf.fo#Y5R=BM@Sq_oi-^V]A29c@t5L#W1,QY+.)LeG<M%CFn6,5sBN@>er\0>co0i
IhC2P7I1GXS/H9*qi8#$^REAMc74aVlQqeZ7W3e4f`K63[t>K/nIBiRIn_D07dugg]As>m`$*
a'`G0F1CmHa^2U*f'TnE8nt^Y,0pT[j(nRYCZKjq<'%J@>j=2p8Wd=c5qdfg>U*H2m+oq0sW
uGp7%UL<F/t@5BPL`h/c8QHFo#SDBlg"Z)"'1uh`]AoCA._H13r&#BGb!^;UJJBE&q;qmV$5R
Hr>-k*dDrb<.bN3rdmBgk+/SIX',[ImkC+EE:Oq[Zpe$I"1i.;(U@JLGT$+PcqN"3NP4pI<t
CGdIk6m6=i0a1'!5KaIXi\aE>j'N(KKaG3s&jRB>cLQC;;UJGr2^#m62kc2I"AC^M@:0)X,g
1+3NKJ7e_'&00BE+cDN^eX6:oLa`GaT!pb8'nTb$!LHL3\4HSWko8$Hrr`Z-X"jJn,]AGLY_Z
Z*%r\0Z($;Ppe/=9`X\N7HFP%u7+(0&<)jAb5_B"Vc2pQtf1^*gK6WON#3KDIq6KIBO,BYEc
1s.rlWhr#'Lp>(2p"M#:=`>WSt+&j0Lm[QPN=M=B9)ZN^IP[@*jO4f.@UFSW`/AS!nS5"#9*
4GJuUC.<rdiOeedB>hF=[K[s@jq'fJQPqV.(7+$N!S94s$,-85CWY3`IE&jGJnIUjt>NocS+
?;3-BJjNNr"C)KDTi.%"^9c`4!FmVhaS($Zn`E9ok\@!GeLgrV8,'&b!ae\?hjb:"A?B@??O
aaIQ968H[^22@Hje!h'a.b4:*I@[.$3cNcOMCbRu5JAeKR-t.9s$t,%rbI0/q99umrn.m<?K
2k$LNHm(@2Q>sUo^18^Z"d=BAPl:h^b<#/,$`)q_O]APV[BoTMe,dCE;JO`Qg_*(YN>XI4i'X
;NqG%R,/&UU5o<`KQ3]AR5fnZ/2ebfIFcg*6FhEfiP,s\t5!F[WkC5`--lUoh5p="(us"f0!U
(PF37^X1.>U/%aC#3b2#;#D31RlHhpb:_el*[M.fDFFd!+hUe`gc5@Dp,/q)'WN58e7^JG!e
s[bXh_[b=]AT["Fo3b*Mrgt==]A;!;0D$&=0ROOp3OR#pD^RfI$hTD2bdQG]Aut2L]AN\+$Z:hPT
;j2El4]AQqD6rd"F0c9s,p\`MBKbl4nM55%C,!c0@EaC5E2*rgq.d)DB^1I"Vo&-SJisa?6QX
kf6+f:+$n&+fi/BnuW.-1Zgc7"4@M*=sPKeZKFV5_(Wn>3=h0p7!Ls7@8JRk/hkK+*q`%>;i
2H8Too)flWp$@`MDi+s);BQ<*+2m>^=$'(0,K?ni5l<hTHqj?W*om%.HFP"m85=1Rs1V?dKj
jAig+S?LpDE)eD@kKJ?,`IV@+7F\+ZbB7dW3kM5Nul5A&0n:9NT?g#\?u\524XEQ1&,*"*El
jKT*9g.Qem=9ljdACdi$c^QCTYLCeVD#,<F_VRn;Q,*drqL+P-c2QY`Sg+P4L5h@U0JT"JhT
)p"H7c]AfE_arC1X]Ag[R*-Ib0I=51._i\pP;s'+/@.^A%PS)AO;)TT,r$D2_c?MtpW(NNT&=L
Ii%KlN?datBb^d#e$KI2f_dF-VP=%6pXh'+KGAbQ"'aR_I@,-p@AV'mNBijR,jt"CnlP>irk
b[;4lo>2ls69Y0X#r&_It<nSKZT\?f'Fjf4:-m8G/V9$E9V>odPjM.BX>L<2;JZh,Na"_!';
b+0:nQYVmV\_c_N.#??J'C_P]A0BEHQN:UKakr#<^HjXA*PkEbqWI!bT(NpbQ_lB^ji[1/_US
a,;5SX5o6]Aq3N0HbfhX8@s(O#I*q>Yt"r@P[t;T]AC<0Q07dpD96ufm</l#e?Mpp"]AmVN8QQl
JZf**+^1&aU)0RLm,)eMk7>aqZ3H+>qiUID./pF9n9`c<=]A+TM5o"W/qpr(9^Gg-$mYeO'Mj
a#Ilf7@k[YS[BI(-coRCU.L-B2Qa_409nog>;@P7up"+Ad\]AE)qF^NF.\/S7'%L%`?S'7d"<
/YKT#pd97JH`r]A++LA\e@PFP11s69Q_iR_hUY,tHt>F5*Us+N/C-(:A2@3n,'2XYQ6gV9fP:
&m;XXn5WSF:"3GP5]AqNm$>F0dFeEi>CPHfZQpnV::kWYDYDp:iZ2oRDW`<q\:D+?Z4HJ@%DZ
J?l![f%:Q\G[VPVu)d)""_AQL((Dm5F%`j#4K6p1Cc'R%`q\fb)4NjbX.I%AR!)j(j!F7I=d
^Zs4+^\qULrSB/Q1scILF[e@3@(@l$6n*e\/S[nLZFTSJR9hSsq2f6[6or^1o%Wa`)Nq9]A.)
R.:ag&'I_He=/rjPIBp^[;#>">o"mZVK_fbN,8s2rmoBHFuR>B!HJoF.';@Jg;qi[m1@/(+1
(3?s<-'3%:GS'-DZa-1XB1f-/.N3N@O[*Mp%_[F=Rf='!P#bs\1DH)diU\cUAY<UkA71CT+^
bg6:-iKK0llsGsIB+u%>,%lge7aSY0lkb1(M#]AL\gC%n+ftJld+,2nc!k>gdYh`e(FZrqb0c
*I=%9WuloJ$n$U<N"DRe.p\eU*?gf@PIJuH/IgO.:N]ANMll#eu*Y.@J']A;U&HZ5a'qghQ&Tq
eF`WMcc"h>![W3pMA6Xa0kF'k90Z_ad<)i85sVJ[5Q-KI"u!r55hM1CX(@!X2&VKC=4%JK9k
@DYZ-_%KYLnr\9kTs5?dW"%,5?00$`@qa*\f!Q9dO,e%aAK`,pP":*Me"U>C\VlKYCTuZgHH
RZn=VNh#HK".`3'&FM.PmcrF''5]APU:RG3TjW+dfa4>BLS_"JS1S_9V8nJ"`X9s\5(Q7MEeS
5tVIL51W<O@ptt:$&m+HcjsE$^m!\PT_$iHke\=d(AhL/O*=?V"r3-'VMDZ9N$WXFi\c+(ls
@^@L1s?3?O;J#cDW?5q(Er2bWsTP.G/oBgehlZ)bd.]AgLQLZ`s@F>tV!/RtJYSYk_)0=gJJ!
<e,;#<V1eB!W2GAn5A=/_Q+M*;`&US$PrYD0:l_W12e;q"bjWr/6ur<42_r'ei=5S#K('27;
M:k-^MIAaMLgSnU06.m9gc64qEbDoO,BJJ7`B9^Y0Qt1i#fl\(PT$4jK6nlkC7R=G-.+f?=%
/@IhhWYh09_'_#\/P:TTg'@L6gPhEi)ju=Mp.f:BF.">m:QB+FiHcZDqQu5>cos&f-e<L^r&
3=+C&kA!GoD-cn]A^L+R6=^(F!n-VEQ_8**rZ05ET>>>Lk[!0BLQcgG/VR4NVn^TSrmba=E>:
hHONBUtEtAYk\h?;M,OCWG_t_Y#k'nljlDu0i*g[(RiQ.=W=bsfHo!m:^&hT[cHt#e?Oi-l>
BI5hk72oVHnn+QCeH*Gu_F3blEq5M+8^V,F#a%erPX06e64!RSc7,BX8>b&WJqVakolYZuQ@
Jd2_LOHV;AQBN4d_"7^5Sj;KY[>J)8@QcVqMFXZoon!B8QES)I6EM%q[m8/!aKpX70D+?1ot
]ALQLmbV5^mCM'rqE#!/.]A=,+m;cF_?<&ssC$3LRT:45(#<$,.',O[MrJ/^8!O'*<3MkYWLic
[m(l-+Wh):qOKs6"W,9X+ZdBh'Z9KB)Rd1Q$3VcF;:I0GkqM+)`LauL,%eeiHrQnM7mGe(aC
JdrsQf>=fu5p\J-HgiUS=s:.D-a$1pE;7$oLRF_.cr(r&,U<ht'Jd8q_l.0"q`/;*+iKCE-K
SMZho3Q_FK9U'OcHkcVZWW2m?CMU\5"C/AnquJJ*MLCW<nZO5fIpQ-)SuRUe<!Q<$/d#gLf9
L_p)!7dR"#)E8/3qSc"M%[IK^CQ]AJ:?bY2AA9"a%XpP-5WX^*H7oZ%&HFtZfN>_9tF/E)b!C
`a8L>mkWjBt9GP\dWoY]A?d?A5_hI-\=LQ]Aml*^g]A9,U,b=FfXPao[jsD,/NRQkL0q@=#cO"d
>"kBW.Z1_ncdBRbc*;`'ncl"2ciaiL1p_q'AMR./Y#IJ]A7f'a*[nX%2p8\WBf-Oo[hD>O'@"
L1?ift<QodUXGES0RFSea.\-rd>c;k'AJ0N**?/Fb-NL\K1-l+R?0K`R8dJ>Cb6^ZY8@pXjW
qg%=0+XQ#p%BRisN0*mn"'YX:\amM4bl2t?%Hd3:jXgO8TT!TNgRsa/>krbA::._>K_M?53:
E'SGHiTr&oiZM1>-JNR3CRA%%6MPfkfiNj5ManZMNN8>4$gppmQ%Q2"?/g3D5A3[\D'>1hau
j*=S.9ZWY5`Q_SZ("T$h_qgXU+qutuMbufG@[1hDk'uY^\NFuqo*`6UiEmene%<$uMZW)AtL
hY$$XA\k/i:2aXK*7J2o):m:QK]AZ_0;[UCnl"tV.,`'<Q99J==pZR4gKikc(0Cm3obT+:mmS
`#%OISb]ARTg_B]ANjR3dUG^!uGY'5Mn<mG;4EroE$pjr^.CC!">olZPa/48eYFgrD^EH.45:k
JFS[CEf/p+O/]Ao$ic?7ukL4%r9`ji\,GL-c\nFcY5d&ZqaquH@SX1ZH2#_:#NiWk='DHDuOo
H*"lqaB:9ZX!U,k5u-8`$d-c#%)*I3t[7<\_pPG-oM0]A3s%T_r0-n;N.).Xn_e3.@"7lEKrb
'$`C#h":5V%gFoa1f1C]A"=1@g?Qh0_o`_XBR#<A6m1MlI7obA`H.YLn.8o?Zk'HZGB=_[Db0
6o.J#<4_n71cF.aGHPh[U/=4WI"TJ&X%?!c80(VlSYu0r5"K)N1@N'#pG9p5ed/+=(soA9@,
;:8gR4t+6_eZ;UMtIGkn4>=GV3fr&uGn=80OUhW=;l:'1h.f#p&Rp9YSYJWdeOpPHBCOM@s+
ofq&8q>801hMVU.qb5.^Df*&C`L#GU[=q=8Vjeg7Ok0X!:rY>CnZX_s:_)]AW2!.YXgGms2G_
U-cR\Tfk9,1#TA%AWO6HDcfjgLR@[Gh-Go@n>C=g]Au!&4&736kchs4KFTe9uTc3.4DkQ^7SX
+nd/tVmr.[ZT.d$(SI&*8P.Z8#9NH$*=h>S:7@#t(-#9MJ&!UV6=rql?RVr(CJe#-h9k_^I/
4U;"-YUF=nkH+.6u<?JKq+\^TO]AU;Ms&/Gk;'`$I?eqi;B%5qHi:Vr$.jJFg-]A[^R!=JrV"(
*MN0an081s59YC-8+hS8jSGQ,4&-A^RcnK/71af)/^<6-c)[P0ET-Mg2<P"Q?=B_"/j/+7hQ
^fllUdkMJTMB.X(heS`9>7bn6!F./<X/Zf8$6`[".<?s8J\]A]AS#eoJ)\,T'Yl[NfLnaEMqs-
lR%h_e\+Yq:E_f/OU=A1:H/8@\)+O]A@<n`dBK0Jt\]A0,L*C1r9^>DKZfQWhQ8?TgRi`J7c"%
EX8FmmB-a5=Ab*O)+lO`pbWunJnc7X?EOp#mPbBfWF!t9/a8(Y"U49TZXLg^)k0#isk+E6\J
*ammgfgr8qq1oN~
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
<WidgetID widgetID="ab4fa3b4-82d6-4adc-afef-754433f2f52c"/>
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
<![CDATA[1440000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="2" s="0">
<O>
<![CDATA[航段]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[总固定闲置\\n可用舱位]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[固定闲置\\n可用舱位]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[航班量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" cs="2" s="0">
<O>
<![CDATA[机型]]></O>
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
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-13732426"/>
<Background name="ColorBackground" color="-2167817"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9P'@;eM\FlFQC>[P2lsb#jeMCj1#G"k&]Ao`]Au;[XgF"Tfl^Ie!qA$<&KqFF"NY.9Nma5UCk
jGO\R[a[AYpk)7>XQ+g/:U%OpDXD\"jSP0n^*)+N_`J:XJN>+Rshod*Br5LHapgmsLJrp\s%
,ji$nC^*DU)+$T_B7>hpEo>^+"ro^"E9/)8>/UmE^rYG;K%B"4+U.+E!DnPpb^S"Yg&'@-3V
69aIODq>u&,k:US6g?ug8]AAgqOW.I+u:J2e)12cB1l"&r:9\c?gW8Fp\q':'Ar`P4\Ffpf5D
VcBpC?kIS)^eEK`%:d[lM(%dD[m,WVckk]A(iVG&>2PV`PQ:bS#NCO^1E.cMN9jW7<>oe*X=m
cO_jQGdVB0)r%@^`#U!/#=\8qfD>#bj:fVTHD,1,dtJJ,5D,(j<g/7#h9T<bm'gai"T*H3)D
SpDZgYEk]A\$hV<YH+JHAh_q@0CXp;@BXl&srF!n$l.a'a'VuUJ&M'FlJVTaF)i9*L0^2eP.u
Ma!kc4:E4m<*A81M;qe5bmd<e-&k5L-m5n(@=CZ2U%"-ab5K;S.YF1q\:.Uj(Y)Sl+DE>J\5
pd9#$DL/op"I[UCJuRN/fdu)l\73.PhENe2V!Yb>A&8'CZ;7=1FcQ[]AfTS/>1CoKeojufl+H
GImI`*Og%ZFi<U6b=]A]A6-!I9UsY20Rp^5tp]AT&lZdc/hJn:Ejlh@cM^EJSPXRC;;tGk63]A#R
egDPL7:Kr`VC$Z07VZH#%V1N5$SUh,aEk&U)OEcg8aEKHhXUAN\A"NTeEcuE0ks<-C&8CXa2
lqGMT#14j2Z1O,u7mil[PsupE.m#<I`.!P1]AqPkW"LZ=!NX[abdLbW#'2I$h]ALeZ$'c]AIJj#
nHsZa3YbUHSWHehfBD)%F\S?M8Ep/a!Ijd+9P@_0iRinYD0G5UJa(&!O<"fLUKrlBPK4W2+)
?-_=[bKSCd)A]A>U:\l@/bYd)enNpAS_P.E:i7R(5P4YR]A0!(\j.-eUh#u7OQsQWVbUd9AE^)
&uaQ/bh4P)Xb(C%e>/1T,so6)P2Eq9:ocI=?@pn(=o`2<m&3k93*f7^;4JS_?C93>@WQ?/`8
q'4o$QV^6P:&(95bMh=7STXJO\BcX/AQ-(-in*3Cc9>a/HSB=o;[Lj[SoY_7^j89q+`LT$!m
?Q[;S;*,,j_Tb0JpkO\+3d)*-)j6'c*7pEGN-;?-lnU8r;XV[$Q*]AdZqg$XuVN8Td"rsJKaB
I12W3*oNQ3ngl/I=Wk/GUa):'hS#I*G/K%C06Jm6F=sGtB[GNm/&IQk&,Nu,u,2:GOnsB=Kc
D4M&YsOdlP8?r;f'hGm@H>b2AXlS*G0>!R`GUR]AjFuc0b*L<'/nFK^r.@s\--q.4=/X2icFq
91-,g^.,Es:)YlAO1IOZ/MU2eS_j/peTe!bOBq.>#+V(3QHE_AN8TNl\YW23-bQ'=j?n+*2P
)8"B+=X=.)`\ENX+uC#'^GDYg?9e&0%UN'GTs42Y*4!rds0_&SjN7lPaP$_FJ%5QV\skDDmH
hid=d&&Dj2Jh$MA:3Pfe6TA'!N2]AcD)V1>$ef2irc#N(h1,+%fF?D_f(u&OZ9)&rA1X*kl!5
F"$)GA@Jd<T%s&eX9#OJkkP8A`e#)hDG%TMbHcbMK3s+GE\6Z_`chbq_E4#'WRlFg/:rX)`B
,ti\_kDK'KJLgrA`H)3Pg8Kd]A/;^[`T\kL3!>>s1Gl7V6fL)O6n"qd,K13`):fud_.-rP3Zn
X_m4-O_Ucc(aD`4nk&im4'lnKAlAj*4\4p+$e'\V$6BCb7a\3/&c>$6HEE@HU3p$mE=Y3DK;
P#>0q]Aa>_O!n"?gk\U9u,s>MZ"=^Ta=0uj8(mR2J_!Kuk;:lmkO2*4'?lBm-/";2Jc>BVMf/
"[NVP^EHBYf]A(7,Bq1O;4$G@+tH=cJCVYK=l;3T'.P^_n)^n6Smk;%?jE1,SeKXG!.^VmE4d
sii%&;.B@a*)G\$*^8EG6dqWQ1`UsRC9#591gM0@[W_)Vo>-U`q:5^tS5'l_f:CHB/;b(tU#
5rg5N4L)L;o5GmdH-&0XVc+$@T]A$s`R6/!fR'Hk3[#+\:ml!O`ZOaV;t='([AcQY6$!O)X^[
4@UqC4r$#U/WK[Prt9uZ#a>0VO0Uepd3RAlHOOb;&!F0tG<Xj>'^^$X8<Z(dG!Q,mJ-NDGHq
+(N<gHF+SVf20+ig[h@V)K?26_#4G1CgKT*5U"G%G8Y5;<dWaKD6GC#R<['>62G;0%@<jH>\
"k98Y:Hg^KN,O?R*9AY^*qb:MA6:Vr9hkA[UNW2THXK<paFZ5B/]AIMKk^K=Ah1'L#r=3^Dqt
opl[MQfULHG]A'Z':%k0%&Y9b30lc`!]A`LjS]AI7c2_ltUSncSOB6@A#VddUE_;?40D_<!.1,r
sl8,a\j"X?r.*OXY:i`4LL0XV^+C+=EupD=GDkNL![1Z)c7kQ2@aZYm`m0Z11J6%+q-Qt2^n
p.Y8%^TQAGe0\u&o(KR0f'd*fQj=iBJK:7AROY,@0Ei8he07-lj7V`!"1c=ei$<nc@&1+3a/
m&=%cJ78J=&1(bO`EX]A51=(@LX/TI^#FpI0Y:SBAZFVOVc"Q7j+WZ8bRCk8;X=Aab<+]A'N6?
Fa,f$\fIVj6DG_?skG3#VJ$k5WFKm:E*mg9(+jr^h+d'4nSedLE4Mo2+.9!FF!:-aVdtf-t:
o\F/k(n'AYUKWEXBH"q\r!mA#Kgi`iu:FbChEV9P92<1/>#5D7eH@/^B9;KFZ2:]A!XMR.?up
qM5tr?aj-%XkM-3^[o!qm85*KIJ(D=gRn@8;qOgT_mZTP]A95>jIrVD0E':qfp?X+PdOb_:&N
,Yps>/pdrbBPl(ic!A^nmdX(d6DS/mu\dp+UrCc:t!CpOau'D;u82u#PP,H6?P(!']A^@?63t
D]A,%oE5NTuWmC:+hN!MCJ]A'\t&NiQ4aFFD541R#sa8,:,[Bc*ACGgZV[M#L9)H8J9O+<!5@N
gQPX,]A7VDe-f&NB*)T)pmf065mN7/H2<`OoL/-d;P.9e/pPY.M#87]AZOa0jEF^=+HPf&f9fP
.cd!NrLj#c!da^,&VNsYe<J6se@E#gAglhebW#Kp3^8<ooeX2*JOq::^7"KCD6[g.6$#RE+R
TK->-k&OTY]AEi6r;Pf+CSDK>Hdd4n@_QKtC=[,J4HF>m,iiu#[=nc'J&Ne(4/Yd8bm-=I3D$
[<X84ZP`-bB[N5q#6.q6QLo(s88k\4kmH_pKG!p+XVOjPIC\'E-:.euQR3W/?tFF<Jp^pk0_
B9sb4XlMu\#%?6qfI\hM2+_-o3=>5PrK6/e>,A_>F#(IK1/%k`_jutmm';h4'45+rC7q;n0U
dniZhG2tj2_B=lJFJJE&mb:/>ioj@G.V*;D'DqHV.(gHE,1:-6ZjS3a-BXnG(Wb>,':n@X^L
CV,f&P8lL(dTdJhY75H*4?Rhb*6<SX@eK.t,1kqfPfos5\JZ&eu1"6QnE6bb7Sj*j?H*K8iX
#XV(OGGXOn%<)GKJcDgop^l)MA,QM/Oq!'_OKGFoYQ(pY7m_;Nn)ucL9?1oO"5a-q@r9&>r&
#4Br36E\S]ApD2!Z0*YtMh^;.X)29?NX.S(E,E88hrkRXaCQjkA#t_T?+ZD;)]AYE@L&N9^a&0
j3AB!gF%$DML&dTcZYBV/5I3Cllr87b@\<jMeeM=T3&mg1eho'UEi^2385cmoCpX]A2F2-(Zf
'KS_2AKXf.4*H/@V5/bZ%Q4]AF02TR;1\HHe7Nq[7eQ#pF$Cs?D"d$(K?eZ.pG`m'k2qiD/@l
s^G3e9#S.hofk8G\0jZSPi2;e^pG=<0IK.aYjF2I)Y\&.4.]AEm;$/]Ai#B5D+]A1-l0B(U&qQj
$&V*Y#?Og]A?e<;e3d*]AM]A&n,p^roBOk*VL^YEQ[Rg&U=G=F%jT*1ZO8Zkjo%g[DrQ=]A/TMR\
#U^@MFN4,Rn$:aOe"=4<Iq22VCs)0@\Eo-_O^4srF^8aigY^-lp#`Sti46lP<BT!V2J^RtrF
r_3,ZAMr:PQ=GX3D,q]ARk0.PJ\4E1lUO.%HC.Bk:8pAulXFHl-2<qsmeiGOGY;0njFMm/+Ph
]Acn(.At/a5,'ZTr4ku,/e^bcX*RD9]Adn0Q.lU,61dg%BMW1HrU_&Vb#I>8[]A06:4?7:j8op]A
2.g:JuMd5`YWZW!*F%2rcj4pIQ=/okG-J^OgP`jsU8>LA%`:sh9k4kDhM2c,P#>Qo682$Ei)
Ak7n&3_YombG_pFe`hXP4L/tfO&[#]A!!`##kn]A'lg?:t<C;lThL%YbpqEX=+^L*r#a5(\-]Ah
'k/t#`3PhZ=O9ac^EJ,.UtL3))E:%LFgmRI>7dqTUXR1PMWqT:nY`:^J4"k.b-1FIY;rCN8T
n+(:hi.^%sDt7rZViWWml*EbT5:]A(=W!oT[oCofW>"u*BDpIF?HTk_@*T;HjGXD`&05-6WGO
sMj\Z@T9*(KH]A%la^LWgnQJo$MSKD6I5*3q3i#@U@89c`?g=@l61"R.R^*,qUJG&+oU<5=<+
8\hl=[J&]Al9HbY[X"&Ssii=#dUPr!A4/BhIcO#lGoM%^'M?I.9d]A>-1^^I&]Aq`F+WiqbAG:b
MOf"A:5G:_fnn_9c^P]A@)=qUkAMi1<jVgtJ'7k8gI#>QU56^f`o)_,GlqWfC%O1cfsUh"GE?
\c:,'cDmeIER&.A<Yd@E`ic_,i0cJFaMQK/j7'jOKG5.i/-F7lKi"q&H"'PgC$+hITN*+,*/
R=:,Q^Uq6E$DZaV/V"UjBf4OKp\apP]A.s<1mZQ8DoHQ(*Aq*AeT<"Eq5_O,E/!J?"n2c`Iej
/d!lOrMd<'V*]A9*[G;3@bK>9Ll!>TKPmnrbVKbHfMhHmj2bcqBE%RN;qu[82kjV:uG[T1n,G
'7"75cp3Rk;a>gJu.uqQ$.8U"(k@*t;HH@b(TQ8!%!PmC3RJTZr__r+\h=V-4Ll5T!TUC/QR
#$`ZLGd:Fh6is@VqS"A9N;!m<cMjn]A14KucQLLNWC^0cH5#nJhRFBX-:9p4Cq^/,YrM,EE%\
S/lCkJ+\'.d]AL$XLJ,<9s,U#,bGSa>K3%LgUK>k,X^,1)35Cu-fa!DLshJJ#r$=27>WK6^p'
O"Xf@&1WbtiYV75`35:3DFS-[?%Yl/`W0BS5kLF.Pqt$H(dulUWr<$-BF-^no5,SWq&W,s]A]A
p_$H4ktJ.U\6h%mQ-5GI7BDgXOUgjk`(Dme+foG685R!s#JM8CKEX_fXX>=>Omr8?Bh.i$q\
"mO!aoW,AKC&>o&MLgO@28.cN_>Y-I^6ZMb^6"YM.g<p+SfK$0<.XT.,GCZk+fm5Du^5aWB,
nB;LRA7>8YGh((s#?n#VLq+WI4rJW3`7b#UloW<nN0-eaJ4mnE*b."Yi:@)jF^5AJ5MA4cIk
bF><+>Jnp_sAo]AEH4m/Xj`f:'7ON+5OLj5?6Up\FX(+DN'5>7Ou,h8Tttj(B-0:&ml;I/B^2
@=A7ROj]A.nF\d6"Vb[0!GB4mE8_*PQV!6$W^9J#oGY$IZ8[AO"99&24FA]AJ#m0C-D`V"fs/F
"(b0+&IuT(7D6cZsB"Y>9MX0pDXFo4gWI`->`daO*q1#^H&%o9C[-h+%a@SnLUR_:<o58Wu2
6c9^YV!VLb;O(n@*2AWk2W5iDP/mI#!R*@i8G-r7T&O6gU<1J$`-S)gU:^%/[HjTU$TOXo&I
u-u*8H@qjFC"$u723Bc$6[#SapQ*WrKukj%KOV..aB#:Z-[3aTK2JKr9t=sMs*L9E*CQkb%3
4O4$ROl+#GYV:Rs)5,Og<<&6%,tl;7PsZZOaLD8.iKrRTK=VnD@H/HY#0-QXc@K4bq(nHQVs
.F%d=qPP,#jLQNHWdfsV.PMu0GrcB]A.kfJ.MXr<]Ak6*C9)&/dFBRdZ7+;Plk&b^`c4M4)uJQ
()*1hdtsPDn<#'P!uN^*l2V1fEEdk6QV5pIIU-N,H`P*C$CYGtTrT<%4R"[KWRh)Ph^=:Ch/
ST`j%ElY$*1cf=#j%g>_]A`>L9m=fVt"@a.NaOY:(qkj1C"<=Y`/YHBBJ>]AqE]A8DF3`B:n0<7
b@mA?Er@-+VR#(M[s"A@7"2)<$k!l`noqfqSZqO4P3+gV+Y%T1&s0jLD^o:;#W`5BYXAk+B@
nPHl=+p$ZN_Q+)ORm+).</%>a>Y'C?ToMs[W.JO1daA[BLE;9#<\"t)u#.$Z3*aTPHUHL$;k
-;j[KfHU&$ZJa:PJ9Z@ATL^c!oa[e^7qKh7laH0g_VL7q,(/YPY"h!QH=GN5kd2).@TNgL(0
8B6Oaq.Mg0TSp"VV3_+AFtk88-F!"-&hQhE)dQU>[2IUU,Zm<N(VCGf+*EePl`Nko%@nHKE!
7SGk$%%oZ*mgOnM7^N::HVt9*$=Vb$^4Pm<B3FA8X)]AkTpO>J$^$0q!CD\>,>[cO42KJtPn9
g&R/+]Ae[$c;Y^kTNfT.L(HDL"DO"!;!2E,[b)^IISs2PLY<lVbZ5DKcmF]Am.YcQ,6o0>S.?]A
CfSdl$I2Mr*Sm:9H($1(3=38YBTm:Jmb83irn/D"-V+'<Fh;W%;!7:D1eF<u.MWA9Kpg%gEg
6Pd`b?P")GKu@PPnpTiGH^#XfoV8k$`Pl]AleIYiJ6C;iY_Hu2[3>^oMBPJB[O3c=O8*-4#Xc
Wu1F!4l6d(#N)Wc<.[Ikp)g'$l"1_#3i^_o<ru#L@0'W*2N4(oGK9,[YrpO0mtj7`IGGEBQj
)VfZ!r;RNEF-;(f_khQ5RnshE3M8s'9eGh6Qqb*nJ!(Ds)$mG'L:Qs'S9DF2PGq^Fbcc."i,
pkTg+S&;pO).F6&]A>6dU+t/r<DaV+<cgJY\i;:bF[iFr8(U='oI.*1b;dui1moADO[EEo6',
T6F2mZRR+1"<`0eC0fDAl2fE+%;;Q6HDjV^Y]AFC?q\GMT[c4\4;0i),YE:Be:G0<aX`--4RN
Z1"[_>T;'Z_ZkR7I0t6Y5no1t-Gs2T/"N\)K=&L_e%DZH"HXs_#D2j4$@qj?a.-Z75/0Yh7/
[Y^(Y<[f7=nmJIN4k!TXe3LD5_Bp8O86D$7$+Y98?5g!ID)b5VHZYIXCadLL!H_nGJ#Rs5rK
'4eABM>I*bl^:c&s=LVebQD0kYTDqG3h&l%\_rd=LW+ok#7Soq;O^n52g;2sf[^]Ag",ZnE/R
a#dWg(BTmY;otmV-%1,>l=X."?3!cHB+M6jO%M]AB2sti-X8,=ADcMK;'Uf`aL_*JCDV.KLco
jQV_&,RP"Vb&>h*R_bT34LB%EZGJ`fk3+Y-O+U1E+LS%nMe<ig\9DH4_YK[\;SLlm>"b/(d"
>;JB@<#R<O=^U%".T)p`G<*Aen+XJqeKgl[6BYP"WC(b;^D!/$jLLQlI&X"BhM>g4J*$$qC@
aTeJB[_:+6e?.PSeL;&'?^h0V))/4Aa@5VtgBWJ&nh5i6jsQ)kK\I-5/d/:q+TiJ8I2q<hi.
g>/?>p_opM;gEolg0.:!oqABoLmfJ&cSXtS<aZo0.BmrL:<"7Sc4<6ZkN1?=/f/7=u'_L*2<
LeCS`6NT(_CL^_XT/s]ALX=58-@!OAQJq72o[RRc@I9`%GUM\<FD7oSn=t73?nm5\8`f1#U]Am
,toRu+\r^^&Dd0$8pN>Zak5/u3$#>iOZ>e9.FFJlH__^]A#.HY@aVMg^)P6&u8<%E^2s$hd=s
TsHC_3>!M*/=&o<[o(HoOpu-:O%Fc47"FPg1kmY]AGL?b7*'0`Dp`a(/Hj"Q:\aN$B(^uJ"-5
nCAR*A"0cf</-/Y;E/1hpKBE25h<JkSOKaa.'UGSOS]A\MF*23i.4nYFtObC7*L)eGGL;^'qg
*q<@CFr;^jd1@nXoFl%4mT""skl2?@1DJOX"bM<QE]ANLJY\[7AGdsCXFl((hE?-4Q(V$7Y\b
m['aUO'-aKVsMVffn:,=D/+qOM4s$.BRVQ1n1?;Y&[LUiJ@Rt_!M:uj*Sc@0A6oWlJk#@f)]A
?]Ak(.IQp,NPDM#@Q'Le1E@Onc(5(*L=A':DS%0[:[+$UDB-.NE_q]AURhcM;DorBGWNgkh5C9
>5p(Q9PcWS@XDDanS$"kRH$E2FqFT]A)/(17"?jhk"]A*A>]Ac8,^rkDJ5\-8!5WI[+Q*nZ<4m"
.j+'$Uf&5%5K=@b(IA%;@lVQ]AcYPq?q"?`peiMGG[ke)<e:ke-\nf$,XoB.&S.+"JL2'S04>
3YR3dOaSUtUCEt>N08/0lOT3HiX_@or_&&JbrrUV!5f*G&I$$q4(ZF@!F=o2!ZL`*2*i$2Sn
.^1d;Ns=Z@IJnec_AkDCjJO@6kF3([4`fdS2$"GF3#1@j?@,,)5,jYp]A)AJPii]A\o3QqhSFQ
dO^hK(@AWk6<K-90ZOT?X#M?#s1UsjEf.Np.5!\>s;Ji.[\,Pk)).'@PX+BG$k01lPt.EmBM
";#+)0=_:$b^'LnQ$_\@eAUZ!bL5rDceRol'sm(nV^cV(iLIs*9G7E*q,$e#m^UYag,^?'\s
"f>Gi6J(bs)=:m[m.eGo8"ne!`AOTXT*<3]A9m_!\J/&p?4KC%R_*(KXl2Z>15Q\FQSf#,i<+
i6if\'O#:Ak&B#d$$C<GN%<X#\7Ug%^1&gt=HQ^c;=^1q]A8ILZNC-V2g4V&qg5ZZhnUVc]AtO
+>13<7PujV@\0GTkXs6fI*X'82?*o,FWNG/g,KT?Xu,\>#bX2<%58]A3<l;%=_b:",Z&=\Y8/
Cr(9e;i##K_6A$!H5$qc'%*fT&(X,84da@+BCpr;BS4YpKaVo9J&<BL_R@n';Oeh*k2Nn`YS
(4sO(Ij*s2)"b>MU.o+Q<#l_!KJ_nhf7("!RpI0Nd:%U[ZH@fngE.r?^DF!Z#Y)-E,B@E:GT
`5CnO69n#E?AEO?/tt(?,p5V*"RP9ZMZ-7a%uNZl36[&9mmJrI5mlJ<//'WAg\l21t+#QK(B
W/nO^!!'20W:rNrkqZ]AmO\h2E@T!(M/nd.(D;W`0_+$I%*J`?`=T[tYS^2Ju<GB'3eJ8&^.T
YWWNp<9346&mV)XanAa/rr;9FU'@KK=#'mh7dS:s3M6OAI<12$th3(CRlPT53Y03=K4H--MW
#Q9R%uMc/SnKUQcY6AS%CB@B9E7W\l,*e*WiF0(@tLs1I,caq7Ell2c3/bYs]A$3AjCCcVMJ[
iZ'XS9lrucA6Q-S4Q48)bX3(eSob4cg_`tWIE8G&qm$e"OHfTbG%<(p4@k*;2r>o[qTMDH:`
:n=(g]Ar8f*L;4VH0uhk'\D9Y5mcERHY^Wjs5Rm"uU1rF35cC&I]AK!UTfKUK8-T*d%jC#TS@:
de-:8$_[-=$4Ra0qLH^n!1cqI#X-jOVrN@$]A<fX@qkpYZkha@5`Xh>^MFg!ehc;1t7s7HLSA
nN"%Led25SW\:Vg,C>(%5K"K7\^K"8'T2:N)#D@XS0Z$W%Od9kl'si(*EYW#f:dl%XdR*IAm
%CA3j-4$`1]AB2*=NT5-kfCq'>^:MnTKas!H12@(>IB8D[KK\=06>!l<]A-Drgs&`p,^?H86G8
BiaTuWn_IqZ09Vn[Q;]A<I+F)o,QprS:MbN"Og<=G*,K]AMh>'nBm+3PQW>u81>T<*'F19m\ig
Yl($NW"ZcY==fN]AFk2`O]A@ZU2_o;^EI;O[m!Kn#l4/5CHGk)hn8\brrW~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="6" y="78" width="438" height="330"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.RadioGroup">
<WidgetName name="area2"/>
<WidgetID widgetID="e5932a73-bed8-4707-b36a-568231aa304e"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="radioGroup0" frozen="false"/>
<PrivilegeControl/>
<MobileStyle class="com.fr.form.ui.mobile.DefaultMobileStyle" isCustom="true" borderType="0" borderRadius="2.0" iconColor="-14701083">
<Background name="ColorBackground"/>
<FRFont name="SimSun" style="0" size="96"/>
</MobileStyle>
</WidgetAttr>
<allowBlank>
<![CDATA[false]]></allowBlank>
<fontSize>
<![CDATA[8]]></fontSize>
<Dictionary class="com.fr.data.impl.CustomDictionary">
<CustomDictAttr>
<Dict key="国内" value="国内"/>
<Dict key="国际" value="国际"/>
<Dict key="地区" value="地区"/>
</CustomDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[国内]]></O>
</widgetValue>
<MaxRowsMobileAttr maxShowRows="1"/>
</InnerWidget>
<BoundsAttr x="169" y="30" width="274" height="66"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report1_c_c_c_c"/>
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
<WidgetName name="report1_c_c_c_c"/>
<WidgetID widgetID="a74dc66f-60d3-489a-91d5-6a28f00d98d2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[往返低主舱利用率航段]]></O>
<FRFont name="微软雅黑" style="0" size="80"/>
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
<![CDATA[434880,576000,434880,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3600000,3456000,720000,2743200,2743200,2743200,864000,1440000,439200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="2" rs="3" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="  航段固定闲置可用舱位"]]></Attributes>
</O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="0" s="1">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="移动端弹窗1">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[【固定闲置可用舱位】：若某航段在本航季内所有航班均有N个及以上的闲置可用主舱舱位，则该航段的固定闲置可用舱位为N \\n【总固定闲置可用舱位】：固定闲置可用舱位*航班量]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="0.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="3" r="0" rs="3" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" cs="2" rs="3" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" rs="3" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="3">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="600" height="400"/>
<ReportletName showPI="true">
<![CDATA[/数字化平台/HZW/1_Dev/闲置舱位分析/航段固定闲置可用舱位明细.frm]]></ReportletName>
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
<C c="8" r="0" rs="3" s="2">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="1" s="3">
<O t="Image">
<IM>
<![CDATA[!DN[%r/"6F7h#eD$31&+%7s)Y;?-[s3<0$Z3=#fh!!%rpK7s:*!u+<p5u`*!m96]A;e3FQt!e
J32^gSo6`0jpiBhZof/.,70l[OFP@JCKIQ$=8YM87VLagDX#-L<\#PA^(P[m-&JdU^,e^A$?
nm-K,/fpUMbNfF_b&qIQrmt"JA5.VBdKhd$8h]ALRu?C7S1.aO_g=aj*[i`h\)J)DXe[>k+_p
0'=Kg,QI"*RLfsiX=Bb-Br<W[L]AL$0M@Q$C3:WR#k<b]Af@g'`.0%#Cf7!karuXLRVL@>R>0X
tVN\9h$.%\fbOgL!LMk=!M]AEN;W\)"?;bi:Tsn\]A*Gbo:+N$F:KS_^$qZ0.m(a2`j";m0"AE
&%4&oi0+$V6JKb\QIVa1"%NdqP`jNY[T0GjNunccd3:uI&[W,t.i-LP7X]AUZ:c^.Lr[H$g5%
AjZRooI:9,qHm,.Y_K#r9#E4DrQ]A-R[4g5>j\PQZelHYD_D*;llG>$qBSrPXo!nK8A\/-\'s
=TIho[P5[Pim?^L&QKflTZl5+:7EY]AWBLu8HUqN+O?_DFIHO<o6pUh<Go6^_A4LfI7CS+NsW
VgIe%?9p<nsCrk\Vb%%+",BAK3d*8?t2XOh#=;<W4fslPK4ah7cO.oUF7%]A>6uYdkOl,m"[b
_a5A#K)-*Cr`BH\H@hJ7'Q0TYV2L4/B'6U.HaB<QL$,"-Ho@>+B5hMO-4!e[LLcm/<e0Z98k
_lF-N<B3%`pJRj'ib[EN._#T'6j@cQ6E?_(Z6rH[&DOWXK+K,91PtJ6=Fl6DY-SR7$T*8nE)
D1!X;$8]APZa*'Ul$cu.Sif3A2?3NXQoq60t\mqSp:FXg&cScFc=rSrO-[l;oifa(m0r9jt=%
<4kjTmZ*jiu1]At#M%iZo=)M)PY3HMrB'Bnu=0NjNd>EWjDDY?'aEmPC(Z8"gAOtf@G=ZP.lQ
$jUp2"%Mgd)jriMk'DAT:qi=01$p<qhMC:>`[@CXiQ==l1>)7O`q"A+VO#9MG(jd^>`V>/72
F5Ym?IQB);Yg50WRt:_S`uR?3LAN;m2%Uomj2gqs*l!!#SZ:.26O@"J~
]]></IM>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="移动端弹窗1">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[【固定闲置可用舱位】：若某航段在本航季内所有航班均有N个及以上的闲置可用主舱舱位，则该航段的固定闲置可用舱位为N \\n【总固定闲置可用舱位】：固定闲置可用舱位*航班量]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="0.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<CellGUIAttr showAsDefault="true"/>
<CellPageAttr/>
<Expand/>
</C>
<C c="7" r="1" s="3">
<O t="Image">
<IM>
<![CDATA[!=]A,$rJ=?G7h#eD$31&+%7s)Y;?-[s*rl9@)[HWJ!!%[:<%e4O!Rs\/5u`*!^"+o/"#1Joi$
'Wc"VDOu7@h@c5sYVo'uAS>8K94ed(H/u]Apl*eKAbZ1\EKTlP='>/:_[/VE"JQ+,jJ2l*K!J
TTApsA6>M?]A!ft]AD\M&7&hPIKEV3/l13jV.(\4#(S.51AWaKSo%f:#]ASg6H\!fEL7B;:0pul
kp&77&.8s^jL`Y&$ai-KGZKHqS(j>)]AiID:\Cr\\2FDD"7SdDE5b[h`@)cYJEWX4r(Tf:@2o
db9ZkgR3#9#6*"Iaj:A6^&\I^!J_!'MR4T##e]A9`"M'%g,t4KN_%p<FhM_d':_4Xl_W_arlO
i"+]A#RHJkO_1I?-`O-=cImm)=)hhQ@<jBP\hXOGeO_FWu0VTk@=2qma(9Zq>^mfIr7jK+q))
d(e9C4P5K30pMj+$#uZ3r,*#;FQ'X43jY(ocgg$?$f2n^H_o/$OI_!%dX2IIN)JXMDV`_Oe_
ojel"i<a]Ag1YZHl_CiLsZYY<E=HlrE,M&b'%`jh;Vpa`-a7i@?QoJ0\"Bt"006IH%VBeJ[;Z
NB/H*7QRY4^<g0goVS^-]AmV+:A'TqR95"B>foRnEF-CDXhf;`ScZR*%h,Km`\69tJm`InALI
NY!!#SZ:.26O@"J~
]]></IM>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="600" height="400"/>
<ReportletName showPI="true">
<![CDATA[/数字化平台/HZW/1_Dev/闲置舱位分析/航段固定闲置可用舱位明细.frm]]></ReportletName>
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
<C c="2" r="2" s="1">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="移动端弹窗1">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[【固定闲置可用舱位】：若某航段在本航季内所有航班均有N个及以上的闲置可用主舱舱位，则该航段的固定闲置可用舱位为N \\n【总固定闲置可用舱位】：固定闲置可用舱位*航班量]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="0.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="7" r="2" s="1">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="600" height="400"/>
<ReportletName showPI="true">
<![CDATA[/数字化平台/HZW/1_Dev/闲置舱位分析/航段固定闲置可用舱位明细.frm]]></ReportletName>
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
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<o:?;ePs@o:pmFRW]AYrDFEfhXc*nY!_>kZDR?g?BcY$I-L&km.k4Fr#UHs5<2kDDell6G15
[Z5"\^Kl-m8W=6q)r_&Qr&B@K:rjP*#Y!rs`#L"B)uH[!'`>EfLNOq3L2lhWJ1Y\F4@:"3-:
g3,7*M@:S/CCYAU&L(206)s/tsKJW<TS\o(>A_=6*`4))Hq=j*[NeTKV:=SWr/'P'gdb\GdK
^_&5SPb76RtYhjn\oR.nNVF?rmD`!?/^sGh%s._h=Ctj`:VJ0TBCXU<qrNWg7/,2E8r$lDuH
]A1?>^`[l$[=$0#c@/rUL]AtNm(ZY<0=V=)_=qMUmR(k7a4DgI8nNNCJ$1p4GosBXo=?g"6/E!
GdB8$L`P-iBnI4?5a+V4lLK@cXehX.(U+F6=7La4<b8^>Bg+C$GE%"aObo$1@n3ut;OB4)Vl
Qe.<sA)8eY09$k7pb]A]ADZVe:%n1n+HkUL3^P_37-(FThSb9Gd)lSXI<9Jm7u[;Q$4Had0"Ii
G@F9Oc<u>"9luV[d7p.L:mKB`UFt%M(9L!L<9"sps_jFtInTPn`Th^u*O,C31g,?qP@ekl$+
,*uO]Ai&*3Q!lFbknLR;858i"2b,l>`'qnWS\bI%M?"Ht*4<jb<k8V2+.F5b'bpk^cKD=)jf7
:\:.am!q^Y*%\$!;X\rSJ-4Vq.R*[.GEH`M?V7V1td3`r+N1]A;Et34e,Ybqq*:%3g(%O'^hV
mYpe/^im,?_Ips2=UWe&PEp%Ak`L9ld>#fq?QI*,X7<lsjJ`6jSmB2@JYIh*+nLNSS;U78Or
n8qb%/r#=gtFlUu4@q0i*lL(XWkBS4a?1:s@k'PIeU]A3pse]Akcop&<2uG8fH%B=dG9,PrQ&k
LhP%i_F%Zd60G@k8m6-q(VQ3FK"X9oC_/H_8.S'+ZXlW5uP,<(sXJc*2`o_\$Va=tdRe(R`4
aG_QaTIH5ASF@g\Y%)IW[fB(etkNVOm^'a+@j"'YVh)";LY(>2Z'@^S6>6j/CS!`9UA[5F)J
fAh2J.P`sr:c`T)hdl'"QLfQ/hfJ'rV<`2S\Ur//kEnm%sJZo$)tS5VBJYOa!1mWQ@.);(O-
gs(Yq9BQu;5FK)BHr'_mO5)%7^*..OgptHb7!A+MbThuU?@V`LCp`s.ElKB*f@.(%mqgN.ft
:"@P3:H?*0+n*%rN"t]AZccAaW@a#d@PMt=Hi7`lMR!0k.cCB'%dQWUeFQ0>[9+SmElhT4)1g
(\ae+XU:'VQp#0'2A>QJpA65C-6nAjYh]AR8@@FM4kD(qlgqEsR0g`?2kE)'R6j2:hE-8u1ae
1>b#k.E!&Vsjd.1-6fW=Af]AMFj+iDP9@2)=d4tWT'(d3Dg1>EWht&%MuC[A;c.[Dc5jkE0)s
rpA7r1$Cfn>M7L@(HlFZKFeIYLcdhj"sI3A78D@n2D+Qk1;30k8V\oNlS&q7'h(Tt`#/MU5H
+((fM$Z6U>Yc**n\aO1PN#PH'"D=RgF4%W)Grr#OEAg>sm)"\"qWP[I+F4l*ef>%mB6JLa<G
[@[>Bau0deNN&5sN(Ni;^;IbAof/a!JC+Fd"PI11Vmt2(DR3Q\[to&e(spD=F&f4)5XH,-6;
j$_r+0js!"]AaSN@-OZeo+EcZ,R0!lOaZhUIhK01ta[u.t=V"<.QMBj%5@BV?Om!fc=5[6_>&
Ftj9a^CC5'-M]Ai$LErXs+N70Nbb]AWQ:+E4=?gL\AlkbTm8"&8<B`q=.B2R5l-U5B]ASo&5;2m
_"Bh=me=Nr;cA=%&eVSmk*\3F>3^k*Ui*h/Um2^Rl#2suW5oLDp[fl+p>HRuPQ>8K^>qH9V"
jEa?%F5>4Oc=1Ac6*X6aHjBP9L]A:n3@qOKn$fAq&,Qs58m6+?\_TCL1;qW4k6:3D8$;FhuiL
l_WD\;/n]Ap81I(\/<n'iFOJaCL_-TiUY7b\@ZH'%/Y:a%9?uHcnF22AXufLNR8J`O$ZQj?j'
dh2"XI`>!K!ojjs3Jl@KZrQ5ZE,eD)/Vu!XSf\MtlU%8(YRGu-P94+cQX.!/7STRi?VWgG3-
CmRqiFo&u?3$Fcn=dEKY0/b1&Of7bhSJ/]Ab;mt=4!I^f"j]AJX;WR?K>XdCHPNG\HJjd5A-R=
Q)e)f`0dTAf4BhDe6(F$*2,9Nr"Wp!_ZD%<tTO!PZlpqG$_bXV"0J<pV<'<DI[oiT'%p]AD8Y
;-d=(kbrUf\fu=dGA'L95*2C+142_3'BA3E)V:6I9t4lf;5W8a$$NAlMT@pa<7g,'@=!Z,lb
RZ_=4nouTANFCs-[qtT-qb=WXjk=3^OZfOT2BGkCOVT([J.$V'5-WVX?]A<Q(gjQ%<R1tdWKb
kUK)e$*3%#V*W6I:63V<"W'&o,IDYr=S-$(PYdKmNEdVE2?fbW2h0n%J9b6:`3Wdl"%!11S/
?`/S44OX4^kjE-k7TgRKO]At;;=sgdP`;sJ@'FP#mD5J*mXiC+VBQe.FZ%@5-VQWID`5)Iiks
$9`(Dda,Y.:!ZZRjTNd4(:g;A0%UrL((BMAU]AdPY1D="IbR6[)"XMmtfR1Ati+fD11I(NHCX
;Q7IN9aJ7l.bq.@/MLF2lV2F_&9T6G8':;!e%6q'^.]AaaL$c-5RcYQ3g"n;UYi*>QOs'cuql
+#)\;Gg'EgPBt(9=Y$^BI&ChI;GsY^"PgM"u4lRdah5iOF/0B;fV$/4i]AjWOol9o2X-V(q3H
Ylb<cNVT6b]A("9Nk7*6AMbs*%Z;85/Y68"<t!0our^A7B&@SJ\3Kg37ss%:N,cf]AfG[qHE[M
/_9BYsb^;%AhM9kmth6e9pYCiV`#CH`]Atm9^=7TUi8jgKIM-qBl>9i>!Aq>XT$=D+^s58QH:
SlW3UXkU:XXQPs(k-fPU"s._-*`KdhXV+rPRYNkK:1`gn7?]A[KR&:IR>^Aodu=332:Or]A$Kh
-Qa?Tjt"W\.!Im.NJf2Hd!Q\)"]ADG[%l]Aji5N`SSSu%1nJFXk[P)Y:7<E]Ao$GGJuT^MeUske
p`[PluZrSm-4ahpT)Z&!&p#crte6=WA&p-^$C-n56lu7qq<m84M%B0"mZ[l\QETd!bI]AOUKA
\<&L@[<^GEh37VubO6Z(7.Zs`$&_I'+hdp*O`r!`$e?"BaBIm[$Q_Wsm9:ZPMcqRs-^"S><,
GMq*lDLhueYC%he-Mk^!KL*dAW;6P'mqR%r175kqZgj*orX\QD-gmQKUHu5'2QFBM^pjU'g@
8n%uJ=bH.(<oZ,s>*j[lflI<T.cPlD>20enB_r!GCL>2RCPFQAP)-p)]AD<VpaOPb0_T4JYVf
+jD;0UCD6R0K(iLkkD,5qt'-q3*"X2mDfX1)4j:,eKZTqlOTlOS7KR1/7uH70]AuJ%UU[PH'+
Yrq$-M_2miC+TLFcC[[_CS2gH5'iKbeLl@^9W,Ml!Z;!2PNp&PM2=4nUj*2BVp5QAV#J$.?r
o&@k(WKb+FA9GbX[>``U+$?`qd\C>^7Of[lMn1qpaL7]AI$6Mt=2/G#jrW.dXb_H4iX-51>l\
nH;@rl]A6#`E0la*hnY62Nb;"CM8?11iNLq:$&,4S`"lVe@q-1W85X0#[6\\NW-,#F_,PBDf4
&&r";U]AK4U!GS4_LjQAH%,8k;T?!oTX5?!]A8id8Efh)oBoBNj6u79JN?;4]Aud)3?fC6k%8*f
lWPI&M!(T[VC!ZlHb>Rq4PZnaBtLS0l(]A+AD.'\<O]Ag*-iH8X7lu7!hTr.:W8'!akQagP6-q
)jV%,CB$6+D9l4$2TSHEi4B-R5s9<5%H@:IeUOq-0_no:.J[Rbg^`VAm.^*?EMFG8<hDRm\Z
u*c775o7a?h37Q;s!S(,oUG@]AUPX"]A7D4Rf5i1;&I:/rV!nm!fr=f@#]A2ksP/W]AJ!G6?_87o
FH=m;2?3E0Sr,fOGgY]Ap[GS$j7q3&pgDDFm\BQ'%igq^*Y-NSTC=Xkq5ZT\Q?k/_VC[Z`]AG8
n069fpc`!PUH)SDFXFGgAr7<:8bVpK2NZE3SL0e!.MS,blhY'$em*^6S]ATnq-Ee-e-%E>1qX
.[CmDC'q!7[`#DRX;o=[[PfX/oSnj6G5?lupW>5ihdu#Rj.A5o@1f(IgrqQ]AeZ5[p!>',9VG
86-F<-L".++Xn/5BM-g8dT'DDe3rJ2I#ar.28tNf)i[[Xq5@6>:HT8^P*!0!luJ11c._4`Vg
J$dt?g3>T$/3&Q1eg1Y34'<FS@PmqDg8F<<BFVIJ\O<J40ndYHF,Q0#LM0ue/18:MQ[Jo/cA
]AZt:K[@!e;9Wr&lW7Rl>?QF"$&6r`U0(C_6(Zf%k\,d@j2r!NJ8%,[UpF0SUf"d&o;oEnEe9
cis+53`DO2UIhkY:M*(Y`f(NH=J\CH@@*[Hn6L,(ElkofX,Us3^T?qW.3k,:`+A8lU*5)<U6
.7b,kD"`(.=RimoD\0CC%6-)bh92Db.A<O;Ll:+"B2<aU(EUmWX$qj0A;'5#^SM\%nlam=4S
CBgLEgSPOsO\E*/s;N>X\dT\Jk"2Y`<M_L+N2K;CUEAk)8aH3Qj8t1.rar@;SnoZEU"-3m<-
jGnBVGYG#hM@RAIA(bR@+Oc$`.*4+pm-L;1cMbM<$S03T>e&*;X:BIEiddkYKaK%F'Bn7<l1
8(rXFI/X:U4,H"OSn+XHC:[X7YqG5)+!Q)]A=LCb?B[u)64p#tZl;4Mk/uA'oB[`mS.gh;BW)
^6Ks-[d*%nufXAdY^LFl,)Hl0fa>@MR%Oo;pJ[Q-F?`C_-JF5&4F6<mK^4uQ"nLsgq,)'+Dh
q=/[r3$%=RXN\qIN0P)I,;H5(,4TH9(9>UiTfo_8L%*s.BLmaL1"^(+HI@e.ad@sAeO3$+o#
qGHfT+]AMc=/?u3+%@'5'SODn3G8mm37k&E0pCm"+'@loH1iK@?3XAa,O$&cgBG``8aSeJUQG
p(NDd'f3"p^_/WHm^27^rH**lE:Cd*AO)h1%:1DpX=VRuR6:qn8rap&+I09!W]A2/<t=%_ngG
sn@uG'W6b-eNCQ^B22]AH[E$3+i0)O_VB8K'-LL0ET,^0BlhJPTD6tg<h^q^#sOIN2T1R),aa
gd"iSAg"=Mj/V6dmU*\grb?8V_<IY5]A$'Q%t?\/Siu:QJ"IpL40lJF)c`+B-n4WDn!f6j!DB
KL-b,r(A_D*fM3`W-%c7@P/:>#fauD9(b?N+<U3tDlGe[\LjAhL"MSMF,\e[Q:a`,>Okg_8M
I1%dUU[;,o[d8ank#,1DB8#VfYVAJO7NJ9dD86ZejdX17rf/X\q</T\S!X3i6\u\eVj#=o8S
993.fsD6#h,hB6uih5/-O'c#A,Y/rV[mfXCtZYg87(jiq^0ooG.J_`0aIjFGU:(/f>=FVt83
\H]AqLKD]AXGOQls5$[Fr5@N(9)M9iE"#0TJBY=50A7b[Kn#rKP@0:=LHI6uCCD$jJ2]AnO;<k`
8+!++N*)'eG7L[Q>#So\gWP[kcSbi.\o95aM[oisSJ[\l?R@]AE1!9)Z<s(r4:41iKqgM3kh:
[U/buaR.RXU8_f>6Sh?9D'O,^,!<*%gaFf=eE3suD^DMEjL?*(SZP]A#n4I]A:RL@OT7TofcZh
_OVZ'Lo;rd81ikm;sJK>Gn<PJ/WbPYXpH\M&;lboZ0Rk7Q^UJ$sfjlKI3rl8Gs?S",4\lQ&E
0H#!fP`WF!EJPfr:M+(/__-/UDaZqkRa'c?p=ZkX)=d-7SXmd@_Teo"/>d\t=!9=hT-935_+
j"'uZtld$:@QDgS14L.c8dQp)A]A<R*+AHO7>.8T!A.Ms4ER+?"ZHAC/*U_&bN87/`<G<M_r!
]APFcAUlmLEVQ#4E"N"<eM,T#*3HI3,cI"_SIZj?8]ANqcP)7g["0o>g77_q8EC<;V8)^28SI!
afTdZ#!OGV@$9XI6Pe0]A%$"Y"`21;<*p#1a&rd%p6J*7nC%aq;cJ1r7dba6&%n>=!/&Dg9-i
hW>#fS*:Z&bE_@<b;^m9[04('ri+.k7BT+uIU3N$SgN:F:T/[BaqX%B%ui?!6t)nREB'@r+K
o8>d3pTg+K;=rc?Iq=th6:i7K)9!%BNqf.uUa*L7c/6(2c8tO4U/ct.6r1a@["nr/B16':K4
ZL(oQRkGPOauN+6^9_GPHb&g;'hY_bql;/+F>(p-EmU2+DEo,*BJ's4lMgf@?=CI;>,0$=!-
(1'gs7j2")7IVl7_mTKZn'WMsHa@<^3*CHolrIEsM:HsrE>WV4N/IqOjFC0a0ea:eL#a2W=A
.BRd/l)&7*1q+K!=df9"*WEm``PGsNcD^q#eEM@R3BbVb4*4<Jjmc`gnqIoSZR(%O(Fb/f`W
<l]AB5'&2CJP]AU-$;`A\:e!+35luU\4Vr*3f_A;Z(^@,bA;jVF"l"9el^p"I!$cdk[=]Aa3SB,
njLa:[/;K8k&Nrfc"dfm',W3<Y[UTS55l34rs"G<T`9g!$Ccd!Y\)tW%ki4(<;+/Gq8X%#dg
t-`(*#S!Sdn#C'9fK'&!*qaS1H`Q5KC`>9aNuEbf6F>eX@1=$pJc@4K]Auki+-(/?@N,B^:s$
Qp3`Qni(X=")1?DA*eG?.AW('o%SN\F20\gtgCt:8Q3Q@WC984j_"lokSeC2(%6P_*%#sK66
J>>7`((C-t8BG40p0LoiJW`<NKr:+c%b90LJsEO91Hig#N0rnr2f"0n-o0ibqMX5TGdJ,OO$
4SE<)B6!ET"*q@dKfEgd1%PC>r3:Jq"V1d;:NA.L:Db]A'7EhWd69..+>Xmjb^Gs*]AVAR(U_P
fPSul.[_]A/bCu/_N30O">W-Y/mD)i.%@$s,`2&Qh5f0[O:Gct<CDbFK0?gm;\e<+.V3C5asZ
H_qLD;&W!%e^e9"c#/:L!9p4Ic67Vl43dgKZFk#XO)\6h#1S.39ID]A$.>L`o84CqcTjF>B`o
?2(mCbp"i1Us86'fOAZ#qVP=YaOeuV<?DYA>Cr^<Ff>l-'>k3&DC+8.uOh/6^,&\UlSDX1Ln
bAMM->;'hU,sBf:`STN$d!E:eALJdV5rsfX_DY>gE1-b<eqPd$h&jJB`haM>\U]A([f8ga4/D
`C?.IO_fGQN2h\6pqN1Z:,lX@,<^Z\cLJVo2=6__&;8oiZbog)[HgW>re`"+pdaPu98MnU2k
/C'L@@l>Uf%e3m2Q0[Y8tW>[$S4SrGugIq(%A7oODQiE;7@'-eHG!?jfR;Ta"kqH?+S[gKKC
b.FE%^\Y'39o,;qbu[a5=h2FM!qo<^H+$u!iP]Ak$GfnfZG!TMo<H\us,b\Ffm!iBCTmL!/<k
8:T=6\liA-:KSPt`\FqdG:7Hn>f*qoFITNb`D&Vi>'T7=2A\A7pFNMXr#f0XZV5V!XL@9$A&
X$C9a&L=[5_I`j4pd-f)T]A(m=1#2CsrYfBBbAZR_gM%dW+TBN.[5u;/ip!oo_dettVH#bO5^
T$(ID&P%`j9[EKg7^u;%l>3p5U!T1#&[abR$5O6)^9+%CHsX2"Be?!FBXkY<L<-SlCh!nu90
$X"4(d_Z]Ag)KblI+O;ZY+mAnW9i=!>+k-t61p@<9`$AR<=)gp1Ms1:9GX7MdsSnoKL]AAF:"@
[`E&8Z"F''H-*Z)tO7IS1Z^:BtcAUV,Z`P(($ko?fS8W4R!T"g2@HFdYoh2)eoPBiBASK<Np
4$i,^L15BVPg%p<\gCXj^;q+Guf8'WSWCmMnGgP4tF1FkFGY,VIk2GjU7ANTaJioPJ*'pcl5
GT_'CI`aJ&`\'EDhk%G_[usR9MCt=q@T42!2S36lA$%t3T?K$*rWF438t7P+.%Kj\YCPGK61
:*j[60War9=%t#1Yt_m8/#URM4KTqjbWN+PhC=VQYL_H?R@Mg<L0uUU+fDHM#=%e?uYiH[jk
ChcH!>5;3433bAY'9ki(-7JNE,U:V\Dq&(_'=CBnIit0f;D^du<i3(fjiu^eThq<EN[pJ)*<
&aG=;nD<fG(XTi*Qh'7D8GYfVgNHK\j<s*hkZ/0[%^*+dD$1Z"RMSe#Ihf3Ma%uWKE24D8^?
=\aEb#`51/dSL`lo&A2Aq8?.>kcqA]AGAfTZ*F]A[R>>_!TK^>&sA&*o*B\:?,2PJ>qqdj<HjH
B&ApF?6-o]AXiR?0mZ(V^!2qo"Yob]AKd\";`U'A[1eO;ORKY\/Qe)g,">LH+<l4Y:C3aX)a?\
6f&!]AIgKPKnP1RhG,KC"$V`h%lJ5AT2/qb:ie&RmgimcT_F]AWHj`98>XueL'bML;n,)H5gAg
YeK$7Wm+Uen2hOoI#uARed>]ABM@fQ[Z7tO!FQfgRHXO4U'=6'F4O.,+E(8Rd/YF026[;1hDf
^GBr3F_2IL-/23l?M0/RG6"X4J$K-5P,mghLJb`s6^P><_8OiKp8GgS*'f$Lt-Q2Q`R]A51oq
Q]A&sO=/Y0:.U/GoK"ouR:aTDLWuK"HG=mO0\lCmsLOg2Cj=ah:&E'&BAa1Zbg2i2SXK-kT"G
Gsdh"T-C([5'`Lpb4@lN;sKu08:n`R9dGDobQmL=[K?.=;iV-q3DNShP6uDb0'9U&6!Eo\ID
XNC1M]AMK^.>77k3?"KAIpOuAK$QKVk*lJlN,t_CFJ/#%0o2MNtmjfac-F4M>nT_qgBKOHZ*_
@6N0UWZo+f8Y!'kB;eNXJb_2J2&26ZcOQ:@&PDhkElj=O=O4`75h7"^V,7^fT>SB.nb+'%FB
%"@cBr`iJo=09*Vh1Is`PRZ(X+AdH29c%_h<\n8cfk]AUK(aB$Q?Q`V`f*VNTY5.@(321P_fa
+Zg2Edf/>GO-&-'Pe?'Y8HkfSQ1$e^*Vie*N_PdlO67h<9$YO)#?6ZK+>4*]ACG*Z7jgN3og]A
]AkQs$GTrBlh"DjWWA2pbMkeWhL1J".:J%/N]Ad[fEE8cG0_c,"4%3e^rdj:ebRi^,+0Wu3]A^O
JP,@H<Q=mj_4O["h3?)oVBP]A-:OE,9IfE7O?O>*i@Vneoso5JgWc2Z$*'u"ouW_$kc#I(pc?
?HO*D(!.mA)i4%I^fJYkE<tCKtet;V!BISs"`P+uA1ffe`V+6AiWQs*um/*H+I7M*q!+G7hM
tKacZX+H%NY),i4SJ6k=qNKV-&QE'/[H^;JmO%J:Rk^VQhs5NMIfV3"SK#I9?>H[Q6/Z\>U`
<7?(AlTT"H3F(2l<dh,%?1lcEY(N$h_bQ=FET*hQ_ii9Ytu91(Tjl.4Z11*G>F!./$\UO$gm
#u/36htd#D=pb,6:,'9:)MpGP_5'2h(uJEI9.Q0CA[$:)7n6CPUrF&5-Mm_+(Yb;2bqaIl=p
c^X;*[CT\sM^7`]A[*&;VNW[^ni'm*'h?+8k?XMXSuasM\0I&Mk![/T.UJTh(_Um$qr/,Z:dX
TWRTI.P"bpU,t#QeXM$O3j1s0P\(4&"2^WO1a+OQQI.$0&"DQ.X68S;>X\W2&[UGU@SUCSGl
C"S,SAChNf:;oGpXq0.WM36;I+;gCQp2S[lLl"m9O!]A&,a<dSmU@k([<3qf)(Bt6R:J6N/fW
L!?Ra`6X2BpnYH"L;@AUrk:$/0PYYF_%/Q<V]ALa=5PG<c$@Zi?3o,P3@([!>Ol2iu-)[#7hF
]AQ]A8HT"#K?<6qG#BbeSjh>lttEjnKU;F2T?%hNVS7j]AP*/Vo=E"*FlG?Qt8aJ]A\_oC+j8Z1a
#/3Q:f(-JS3A!W7doW(-26-l+KR*,,3Eu]A)CTS3e_l.qqT]A^RbFLMFOjXhY"kdD(KQNmCjZ8
^hJP'tY?->N.7ZJhcosdM*%hf7DkABGSpe5>!+Zm2g/*-SYbB+DP/7AVLXAg^b&s/X@fOKH7
d-fk&2qP"V)4kX$cf1g;U-+S,TACe?&Z<uom'gTItXr+3I8%UCF#;+%&k<K<*L-57A1D!V$G
b?"3[*aGjB]A#575m4og]A1"C[t.rd-6Oghl^J8<8uYX9l#l6kgmSD1(IB7UA'eU/:]AIoP3DDM
BCdRUK'3smNbCX+.aa0O+-0?S!XZB&XF7?[5):h]A371df3$LPeLF>N\SD\<N<.m`d?toP0i,
jL-%lqHDoKA`$lAT[9(L(F9I;U!\J]A[:&FX2uLL+e;n,duh4n>OCp@Bq(Oin(Z#!U"Vh35;h
d\$6Lm.;H8b&GMlmo4_Mu\.4-#.IOrH:jg<M:C"_Gs+V-.rJ=]Ap!14+FQIco<F'F3/>]Ar\)h
m8,p\,pJdce+rPd$CN8eK=qMYdkWPH8SH<;mPfcj#7TBK@8<j$_l4o4f*3,ClYt#-ldoieYg
eDrRUC*`\u1IXW<n$09Tum]A%G.35[qG!:q-:nH4e;&Ydi*3A/o&?`[G%L-=o26P!t\ZT4q'M
8-,[G;`UYA(:7p-Xik1""Us#oD8DcUq=CN1eeXi;#6&+>d.@.O3#E`b`Xl6EFBnM3C8J'!\!
@gML!UD6a<QHHQ+!?*c=5XN!3"7uL]A8HE:TnCW:t@+'?D;A'F2;t0Om3'>d67fJ(kSoT"bEW
n9W<##,/'ZnM+=sX5Y(+?-YOJ*k<)JAA2#J/rkW[E1bU.1iLsg"^2mg$?t&=.P"l1&>ZhodA
'_(tdLAZqS)&+PU@8^8/f5^YFtCM:p'#]A'>a&YJ_>Jq@AbK:'J]A8o76[97!%94+!`FpC"CT[
*1?LO5V>@FX"!9ApKTYfM-Bo2!pI+ik#:hA]A5]A\G:Bd?d,Ck=5,q-tQ%a@paBU'Y/0!g*P"U
%nYnI;]AC.rC&Y)K0KT"@J*&Ym7HF"J,m5W.8qY.RkaUj3q/I!gT_+30&h<8!lfHE$2Lm#h0+
/\rCHT.a;9o?K"efM/3*,k&?bhU;;=i[s[!s22^t@P=^bM5q_!LQF&YbZBj&*atPu#[A["rZ
WL+N40+([FS)a@>cp"q,LHs[SoE%&h`2VJ"dLZi2kWc_TtUu.0N]AC$==.+1!LAMF'V'ceV6O
hZFf(+bg_'"r%""+.8Bir\DldA]AJ]Ac;>mJ3KMhcp(J#u]A=K6f$EK9CR'7g+?AAIWePeF7lPC
uZ>pf9UL=9Ofd%Nf+/Llqp]AgVlMoriTHh29BR]A!i+lrgFiAGSA1lJ`CH"3a75sh;;=4i!%!Y
R8HA4UADfI&10nir3pLCc]A794W:A'\=;6&4B%2jHE]A^nll=8!8M23tCpgiU9&GHC`d68AbK@
PBdldUtZ^'[kI%^5dq:.*oi$^rWR\k?p$^WW@aZfh(:GX1q\"c.:mqmhj30V0\M$^;LS9#/e
(\uF<I'PCC:@)=4\ZS4_V-NQn\=Zo1X4eC-7k6ms"+AZ<qWN@C4'XA&te%E2H"mFKl4I[U:]A
#G["H%5nnJ'"SFYkgQ9ZLk>g6e;>"#DYG`QH^4_lOT"ZNdQ[Q[l3*,jiTHqThA:Fn$W3n)TE
`p-'H.dlIX>U]AXr:$*'oR`*h.W]Ajj=m&;q02I<n&P#h!XJ)cQr;Q\R@NF@Qf;:*;U(n6\d?\
`q<DbL8+Ff#SAbrf$q7@-<$'-3\Hr\rj=ZiW3lg;&sUkG,`]A0%TfNM`5%Utdh7!cd*O<*nq(
gJKf7>5\Y6BpGElJr3kZf9-T*c%\2&rFWru7aNT<_\#bjP^%o8jlZClMHiZkcb;0P`ZSSJaY
]AAg[JeERLX.+>Im9B1__BL7(&$jL0IDCVf@oGfUa*j`FqD9'pX"DgT#^-`5^IdEbkd3%DDLL
o&R/"lCE#?)>WD3sLkMqCT:(ISY_BL:4)#!S^Gk,jQ@[h&UrC^eQ$U?**p$c[8feb6.([fJ&
Jo@[Zd9%)QFKDL5=55*UK^6ec67h!c(D4K;m7NUst)9*1H1%6!#E:I20uEd</+"(i4V\KaDq
RN7;HC>\k@4:C]A=1pEcO`:gY5<i;I\n-&'`*o3WZVJ<cM%a62'.,q'uYVZFbluc'BOjY7$h2
7u2\lC_]A_!V?k5qIp<2OaW6WYC]A2$/u5#2SX.l_p/(p'On=R"E@EVIZp"H&dgVIKXqRbf`&d
Z7DjTnLAcFFq<DOhQS<U_If~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="4" vertical="4" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
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
<WidgetName name="report1"/>
<WidgetID widgetID="a74dc66f-60d3-489a-91d5-6a28f00d98d2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[往返低主舱利用率航段]]></O>
<FRFont name="微软雅黑" style="0" size="80"/>
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
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="7" s="0">
<O>
<![CDATA[往返低主舱利用率航段]]></O>
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
<FRFont name="微软雅黑" style="0" size="80"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[j^!4<;cfQ7gJ@-1R6nBp'rN8?@qoY2Q\pA/8343%FAV3qVa\`Q[T6<pLk$BdYHb6AAl1?)CE
a:QZ)f\r-!JfK"O]AmgC4KNa(a2-k`"9g2+UR4TPO+:_=V?nS!t@eFr<$7e3VV<M^;'.*qg4k
.k;P=G4Scq%:FoVPi5mp,oD7nl/9hT0@)8U6s6J^dT?%nXCDJIomWmjc?iQgm@\doG,>E=QR
*;.4J+&5j3<L3qI!/oZ2YOO;s*!e/W8BhKB)/?s1pf`KKgqoWY5"=]A6IkeU9AV#h%B7N-IoR
9`EW=Iciei:hko!-5n)r8ARCl.[!'0BS#GL9&eoJ6_J[G\ZF,[D+W+FV@S5W"M<N=@79Zno#
cQ-h"0b1)8Pn**H\q1-dp6'"[8E"e`!erbmXk[;+bk1Mr)($T:Xru9gX<I#gjHbr+AT[m)"0
U\,Yh=:=O`5"Qs"*P/E\R1CUkY6]AK#4+eY2_E\U?WU'\USl(4+`OR)%TbQEEsKLIDU-^WMK)
kTe:Ot+L)jBb]AYVE,Cr4!^I)O=qSmY_B@TKE<cd*r&mcCK4fIr.U_&ibMbZmXlT.ek\]Ae/_7
tHA9=:!GP#c0J%>*USdS5m&Q\Jmi$/)#cs[6-!#k<^nhS6[YbP'?g_A@JEF?*IS80VjZa^=0
tjmWj`>fj,4T*cjED')>,s$q_ec7TLD@<Pi#$(,"-Vo>:R.^YtI[q9<:[UaD2lk5PnE;r.H!
(Y;0>LQEl3j2Y0cSVsVcP'8c\H:o0=3T":G`_XP.:9A=Pf1M5QD]AO+]AI!;X%T\Rpo'<=+oM(
:R''cb=W'qF.n)u:lF0++8R/\=/j'@171O*A@XLc<6`02uMELMNrb/<hG[_lZ"J.+g@i]AbJ4
/#$Lj&`mm5/S5)KXHfQa-5B6g.<OVI[iV`ak-mM6#KD)Z>faTB4)M<^V>h@UUbVKru4#`JZ^
1?lCQu+Ql&inrE.CNkRLOr#Cc6eWQq<+cp'?EQ:kBQ=7W`l!hk-3fK!lOMe:oB9c$&=XW-#t
5R+o/8\mN'Le$a)VCgE1mbE/QtDAGCn@'Q:L`jEIhd7aFEfT"FjcnJDKc.k._NSuU\Mi[.;2
3Vt2-4?e/+^[nddDj9b4aQ]Aj89@2hp$proj$+m:5k;A2rH0H3%TWhEo")/6_[M<Y:E,PJP:*
RBVaQ7F)+ng5BbnrgLXa5b=*E9kHSoshEZR3B/]Ad(Xs,tlq[Nh1dpn^8Gm%GXBiE*CA.GQ2u
LjNr.,15osM734a,FrJ3o&I9Gl<IC1pKZ/]AY<7oi7\GTV+CP^5+@,mim%#<o/gTMc]A?6+)!J
V>=qo_rW7Z"$j)Dl/EL&_+n*8qt:I`!pLA2j)W$M8.tWgEA&snEl!!l8o%oEp/r"Q9>u&PYl
\INHjafqC8S0Zs_sq$qm%#3<"(F7j"4.\=#pa)@Y'Kc9E#)c`s_>efA;%B#k;.T#!!ReFk$b
rJjT^4iU.Hm.lY]AmcHG2LfL"emVr>q+m2s#pnpt\;E9^p%GYlQb<dqZ>n;oo+JhF(U/D!_*6
VP%Df$f6iYYI3HuO$.nim@\,V)k8V"JAhI^.>sGOge`rmD<tO&&oETLYoF3[!Z1jAYoO#8+R
-,,js9lb4dm3g#M![WcJ"%_.C6;e49m1(9YTD\i0Q`aCcd0t]Akc%\T0`SY4_*H6O@Ve+?pDP
3F0]A@NW=A2_'bEM\odbcmbgd_Mn[]A%u599P3@UC<hdBY73'^RjuSrG`AA5OaO+@W7IQT'1u!
slFLBV9QA3:?VT,G&SBU@*<t(BJ70']ARSmQtTb.AoS)9(q&aeH*Q?>sUuChO+Qh5Arb,<92G
rdG=$09#N3j>?mZADdXa#aAsFg\KIZbS4P%L2KrOl1Jh78q@)!aHq,@cVZ+E,!j45f_.(dUI
(\V5UOl^_p.-E=>ME>P`+c!@0(.4b:t1i'LOF,gD#QNpi\dkL_UsD#s2XLLuHt&qc4MLhU0m
JT/c%\Ssi329.<M`\&W*mnU#ZpX;_YBZfP7X=TWCH1S`@o"fn#XNm64=Vr,uB.'SUdNab\A,
M$mV<KS;V0'eJ;adSP>G'W>`1bIn/'L8IPKN2#P]AJ*"lo8e.\3aV6X0CCP2>WtM=:H9(-$7X
$</8&0HJVS4Z1P(GQ>tS@cWKu86f>5JDX#_i%Qd4:Ub,?o\-\WmY&73GP%s"n+4ud"Ci5ZEJ
8mK-UU^J,R1(^D&+7]Ac(2Nb4h5`>Q)VnqkhYtRWok#482Gs`@Q/2`,g`;0^kIRskc*>;_NW>
0iRC+)]A"m_9Goe]A$p`$qZr-,]A'\3W0*B"F;30AV*=#)D,L</fr_C(3$s9ed6<r\AmH4U;e^Z
b(`]A>DrMtQ_R,G86_F:!N'Y'^AB_0EAHAL$aC6/c\A,C*I2$`#!Tobo%-J-fSoM?\n<;SLIE
!e8A(0:gl<I9F/P5Wqk>Y!SmaQZ:X/\2G1FH#bHT8QC_JdUP:jdM$is!T=."U/LW!oKah()#
]Aa2b1E#]A.-;^6Gg#Q(,F_jKkHM)Cc_r#p_P=m1M$IDS97f;#oBXr+mlD3FH"`,V@Z41f#-6;
>8.W;`@9TCg_u3(m#<ppNP<m,U/`ec2",o)i]A-(Pc#IpE_"#(mKmhRV$s,gTI)F8FS$B=,H$
-55>E#o?3adZHi=[FhrQS`_Om%>'<B,tqn9P9[9;<EoHsDqsVk/NC@X)9Z`t>nRp%!!Ji>/@
<(),XTjfODX=^5`):Z5sPU06n>A#!47*KC_.D@Kiu8cGt]AhG*bU[e-q@5^aqH,S\nOjBR8pe
gPb3Q;23F6]A>A!'H=(S7D^:SO!M"('T4?__CELhDk:Gn=DBa$R478i?_H[jTu$O7=d?dIF^T
#jHBmGCEk$9N/+<[.C/$UiCT4udM8Ad3n?DJ[gNXX=g/,)W2_!Z@ZT/C8L(V4f,8)XTQ3\**
2tNCF!n#YbVj+5A1:hn#/A!Kq/dNWgCX3R-ASoBKETUR>SX,`rNt=9C)A[D30hM=Z*<Z25-;
)IOCUiYP%Je#h)GU(/9nd2Cq.pSYK?XFW>uJdNLrmFgNtOEV$bgkVh"E.i*CJ#b9]A;K?=BZb
b0]Ar-BL&@t'A1(fT."+'Z,<_@jJjK(u([/(Ero+E;lu1u^M,6f?H1eHa!G>?ApW&2Q1Us:!+
sH>sC[R#c*6kiBjcV*kWUkX&M/Lf,(Xc6r>`/.%RL0RfqL3/D*#R4AXSV'2S!XHM[^%Sb\D=
%7^MOYXaEb5/I3<QErcPL;+Er6Rbbg!a<SU$@"YeVE$,:`gB/L4'Z*TjJ6"lsOiKY0"'."c=
WJ)N_Pb$kF0qA!_<9`/roNWZ_X5NpfRG_1OIZ_.G!Q4S>#<Nth7tTsb5*+#eWg\W5&>PsMn@
).o=icGn2")J+^?7CY(?]A>9K,a^9W$e+,oU)m?bL+Zhp?XmDnCUHj)^[S>qGpni&uA*tIVdH
1PEGteM[%</iDif),nq"PC"q?`k@8J&'Z/Bl&#c>kCnDV9&G/J^AM;-V(lni_-8S^OVHc>C6
Km:.fL=P]A$U#iL;`?Rcq#7aj3Y^6cP(7L=;BobHNlukiY;^A\,0r:.FkCo`/YJj-d.Q29kD>
R%R>87#lloj7\*!@<!UPtE9=\$a\j]AQLJ/h6:9le3CHc'BYW2;LJn=%W0O$Vn)P<P7`NUd'4
rV^uOrV7A0/o9OeKOU)JO5E>$elKEP\BA%[gP)s@8gLoPJVqG<PdCm`Af#_t;A;;A."(.8I"
j-o4DZBcaIUM]A'NkJ/8=h=W4<0Is460>6(b#P%\7(cE;2YnN+Q_uCgS4_RFN,7>:m&'BHe*:
GH_l0C=2nHJKuT<ik0trA>TKSGoR4@1jO;B+n5C`6\`'d^*ujcbBW0g+^A\'Id2l)dJ]A0>:X
-NjX8FOMVi^/:80^.S$*rTa1a\%9BH5"7agtj5mf-q7-_:b4B?PU)<aj;<-R]A$"f?Fq/4=5u
c.<hPGo\4G;TPZp4GhEi[/gg2jd82"ddL$l77N&EKW9T#r."[:F=bi#]A[0u\91'k2&!4@_uL
4o6@d[phn2c\\2QDpA@X*bc5idMn<60X\K_:^t:hLa0XD9\?fiAQ$"FH/[52M+bbI%5-)Qb6
d`pDL=mg2IXrTkdk]A(iV,7Nr1Ve36ef1irjqVt"p7lo1ulGdXq'cQG`TCXcYP-9*f$r<I(e6
*b/VuN$Mfd.bC)Ks46lGjcfq"20:3cjjdAeFN+-Jh/+)j,.-57rs17fP)tS@fX7^"E!S:&sH
9=Mh"-_-If4IOn(POW5b'b.8RE:G`4Z]A^i(S\@.pEq+;_s4*]A4EIQP/>O-DNTV.c+Ek]A&$Gb
TZEI%PopG/Vq[eJ!gQIY^Sa/oQ9g@[J%LCIF;BkfHK"f=6'qX,@hA.o]A/M6K]A*EXUM^HTi'+
Ai$kE!f^F74[3j'$nhhS&oM>F;l0b^4$__&b*)^S[_c\Bf6=eO$%o&hdI%,H4H#kVcs##%bF
Q^XIQn2q6LUIH+Ea0.]Asl=OL`-[NDI1qXX'Xa7!^1I4Xm1WLIRMKT47"3MnH"m@oQPFs?f[/
A(omn7`^8/%B%Ou@]AKkZP<V(XDgiBLC/`rY(I[u#u%]AII=WJBc9.!F-H>6?E0oEXIIIb3_B1
Hh[@DrQ,)@Z0P;0AK\DlZ=F]A5lA_UP"`B(NFsmc9N*JIZ2_@gWgi[+N(`30-BlUM8cG?f^;D
_sUGQ.;hk1;hqj!(mM57)CVS*_D+Frkhc?OPY^I;?;!,/2i('B`un/[Sdb]At:%p(pc+j54.+
@BmHJK_ka8*`)ofh?Ep33r(jXf!cWkbM9Rf`(,9j\R78km8Rd08Ab#Ej4\QYp_Q-P)^Z1`&f
RSAQ]A2(#gfd^T=;eVNgdJaa+s3IiD@dA/cQPhFVCAm2Bfku@.\@@RYJaN_8aN!d+9e/[R`/Z
C4&oc,jh301ODGcGq2t@d"5;t-8b;kc:`g#@Y%tE-7<!EAC3X]A9#7tXM=cCjd=+Ggb@JdA&/
C;Ie\<Of38e:>@lBtI3etNe4a$4;*SOK'p@CYWCROJQTL$`Md:HhV)2FadK;0LO7:`%?LiRZ
UZpuD6n`S@:^-;`7fH:W%M?V;jY)\!u5oq0961hJO?i\!7.=Y$;BLKLgqb2b&&MTUY?Hurlb
*ksD!ka0(>S$4\?Fo[a/I8j4:GpR*,oti^_@Xs9c9X,sGlK.4-]Aqco)0Gm>I(*\=k\[oJb^V
c1WJFl5Xh^2ca"l%;!]AtT>sH5e;Q[dsj:"?i?[ekk@dY66XGKq-8A/HaD?Lgd3EU+bi?USuJ
pPjS4l&H2dsk5Ub\+nZ+IBt:c$Xnbm<EolK7>tEuphqncuD6V;.AK.nJBcGDi[6i`+_tbkH^
c+bEj4j7*8YDl6)MlPn#1D"1,+k<QEHN=u&UY?_c@ZN+e:n6f^d(\I`&k96J5Rbh^AH%8JMQ
-Z+[m\1>n@"/e=Ab]A)+d)IFE=mXaWOX\J3*--NgUXlB+Z'lV$pfJHC=\9-@cEH.;jPM=T2DX
>P\+713d279WnCAW$och0<iM`71;b&Y+&6/"q(PQ.D8.j.qV&fZe@XZhFl,[ps<#SHXZ6?X%
=EWpO(.;\5X0Wj6ONKDGcDVk\IU>Qp76X^o9_$#c=Ms9>"k\=c3d\BTsJjfe=_3m?q)b,SR,
@l./]AfS!el@r.<>MV:7etIQVP.fJBQ[c=+fXdA=?3j,JIig;X$U5+ZO1\OorVhQuB8;Xfb0#
)/tQH)eu2[PlqNRE,5tQS=K#S3a3T7u01sEr]AAFWb+#F0FZ<nY9/Y@$nINlnsDud0ko^MM-I
VL$rDg8%_hJio_$8[--*YtBcg6.hCM_\OM_G5%m=0u(hNdh?<SSJZ$2btiZim#$4i[_DE&]AO
(o083c!p10LHo8([]AmHs;MIR?G>Ufd:4'#q$dYSEQCqkZ'QS8`V&lQt>:dIpHrfYBb]A83A91
AfH-HfaAoM4K?qB&?@,!U!?g?'O>9dk>l^o=.&4i`Qg9VPIkT.dhe6C+5oj<lZI(9t4/\K]A.
Kr%;^bFal^NFZ8RNKpQha]A*;==Ah"+5!k.!d:B3r=-&#hOAAe7/l<\ILr*-Lk"e=u>m^-0oe
FN[_+>+0J.Tt$:nt"nl/JB2YZ>3E_o"\;+Xis;K;,N/!^%dsN@<*@$#20hjbR4ji!0UDYUpI
UV&4AQn4V]AX&%\PVJ[/R1p>7,DIdCsPZoPm(Lf=QM(`'.+6kJVYugVRhK:u;PV>1/r)-aZuV
K,@%L8=3#9ecXGgSTfWbO#0LEUrDPlT:]A2o-WekOjIoo*)LRd2@t,KG4.i2uFqCD;%=:M#2l
B$i)#N(SV*B7d(M,MLnpP.Wg5l3sr_I9<F#Od\.pr7T,k@k=S%)gRE;Dje;5^7udu;oHe:jR
X?HerB0+65VDePe&dOk\Gm2Q[C>7P+&gX5W(#.rGKE?jU0qb,+o-!H-9fH7OF7^3uP.,$qF+
qd&l&.O_;5b07J>S%.>U65]AP&+Y%=5ufs+!Lge:!\P4G9q!mg_IK`MR33,7"CW-B($Z)O-Mo
0Wr'hr2U*[qR]A?#,?$U6ntpAgZ[&&>BjT.j?P3dQoR"kD6?"K[#V!&AIUKsJ>#1=l-+4@<5S
F'caU^?ZI%c)j,o'!"hX%T2*GIsT[SKj63S_#J_Un@6XU?LImk"JS(Jq?D9\J^`dY\%33;re
a4B*6o!k8,OhA8&&.&HtKr;j:OP3j^25<-=/eYY<hQmPo7S&53dsBE)>THk.p[M(pb*<>mCB
$$u1gU'K#&mq495aVdVC@V9%]A]A%.qut]AaW.Ao*iLMVfXR(8.ImY4q#gR9(mKYr1n2th6,*p\
q8.!W%/3(Y!!o:.@CSMonL=tL&A\jq98Ga[gR,m2+TdH2=t?WP3*K,6Y*pMed*t5IdB<F"'\
El*1eu2_fM?@Mo9S>4P-9un`EudGUY'iS./XZ+SR@`mH)#Qhd2C00H**P_)!hhDK>Wh9rWl5
U)1#U!K't-S7_7UjG^5@5/[[rC9>qE+>0-`hJ>>80WML_]A*$!a&s4l!doR#5F(2p[MeYMh4@
]A8PC+u%H'UO*,aUl+>Y+0$O"IcL0iO/g6p^P4,[1*1]Al/E`LC:`>O&@2:4L_nB"0q$K<=%R$
jNjSV-.CN"+CcsE7AJRY#rZj/9%(?;V<qX/Bm'*-kI0]Aho6!fhu2W)alF">XlmaqtOa77&^&
AF.!aBC*f:fgf[q5d"US8.<=Bk,L?_]Akd3`nL/2ONV.mA)'D&RFCG+`cK:"Rp81*2#glNkrW
Fb/g3qr3QO,R86!i5as;[N(u.@J9iWX6?TaBSE,!oAL^Od9\K-JBC!WjeZIAQ]AB/VUI1h@bG
m_4"tEUS'_&AW/?/#C4F7n(9EoU?7aO[::Cb^*P<mh/\L$hC7:5^7`9"o0\V>aM+)o)25u16
(eS=Z1+S"b7[J2.G'LORO\9b.l_T6V1DBRdK\@iX3TU:>'4hhT^t*'=UL+/*'h52e>=5Xk_u
:X?@PGBA=]A%*rqW/=mL6m:*,u^*cY3l()Q3bT"LGUg"GR%17qHWdq.lH_.oYc@B\_'90WKJ)
mG/.3V360S:[R4%Pckfn;Nj?odkd]Aq0@+7^RH3>ZJTf/J5d+Yr9ekXM"3t']Ab''d$_'M&_fl
VZ&o`(LZ$j!)[#dR%&U$T)4+%(_.dpZEIq&Bs[bEWF&k+F(V;kU<8D$GiJ"OI\22p15Plu2m
FHROqf3.09#,4FD*2%@JbD<.eTXqhRH_EtY7NY^%lp!50"+`BMFTE1l]A<IaA"k'cb$P^,,q'
EBJaUV<YHe_4)E^hr\U(>ggMYN^,!!(<SpJ%h754Gj6E7R6=4VX&"-FcSY2!(mY/>Pd$VTJ>
YZOGoEKa4bm^B<\J&Je`;]A&o;6fhKY7$/:XAP66<SA3_.X-r7j(%2XerkgQP[PmYDs<-4o#\
)*d,p+R,%N40.jW:EY.E.6@''6?UQ4psFKqf,_(7SH/&UdRd)Is/-S^'d!:(Xb/t#?WHWG=-
!BCg_qS>'9HQW?#i!7'+UP>bY'Aq)AkhQA4N3S^rTL@<`\_>f3=DJ8mMqEB#,9Z5t:QM5/0r
]A*LlVfHVgm!7TPD[iM.:W`p=Jd8pqT%$E+sNl?C2qYhWuCL?,7*S]AN9.g;*XMPJG)F]AV(uRZ
*e&3+Hu]A68A8ed(]Ai9,:7;C1"-NZ';ahPMn.(kI\0Pm?aJ9?DrU.6`Pg%)L]AYVlnJNFoe,fe
1^<5ffBhn.fdpY$W?.)Np0q70!#H'C%K<[:!#rI=PlPr>,%b>":Y)Mh;CbP+^Z1pdH!&#_IS
R2XAKA%J1EM^%.UB+b,Vbh)RT/ouNpp;@/+]AlCUFJAuIO4]Ad]AJ30=i`oR(>^V"S.2VC&C;Zn
`4`E5Xs,Qa(7AgR<n"/"Ol1kD8Q5e4NjHtB6l\!#o$P#5@`Ecn[bi#%9_B[S.%L32#PEKAVK
<$:qV_D?N,V[\Ogjhp:g:ZVGBT_&m.V)8?c)DCg[E*<Z_]AD2Hcl1!&i>+HO5Z#j>5Ntm1U':
?_fEtlc\W9*bm%!C'?&P[Ys+SP>QOR`L95Qm/a06(p9nn9?^K'`433]A-"4X$C4;Dkp<FNHp<
J?hNIhDT8]Ai1UhZO?kpb1?KMG4p+)8qU!U6#[EV$r%SrIQJi$9>a+*?B+S=)&W70IU]A9j!m,
+:b^P]Aq]A/30]AI)C:i%u.c`OQd9rDLYj7OE$F0bX#02Iu]A;kDo=HI-"(7h[><j4dB3J\b=H[G
aY6ScmiFAfGGT,e?iGKhWr-FVF,")?8eO5YjG$H(d8I$.D6k6BHf3p^Gl?=MN8F+GS)B-O#`
p"sc#RI,b4!D?;g&;suh]A4Qb3J.R1u4&ql?3uX^2NStD_Z,VW>6eCL,gf0AcbHW2U3PS(iRl
fUG+MZc8\*<RS[9Gik*r~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="450" height="38"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report2_c_c"/>
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
<WidgetName name="report2_c_c"/>
<WidgetID widgetID="ea0a0929-309c-4fa6-8084-3c6c086f2399"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-658188" borderRadius="10" type="0" borderStyle="0"/>
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
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList/>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;;cg\V<l\5[`HAAjJu'(19ZPkB6)gTP?o$<A9LZq#*JEoYYm."c=HnRdjGl)QD)&E,Xa
gJNQAZG+7HG*m,cdW%Yri(3;BV&m",)F@@gIW2,kj^3_hmQ$2OL.Sa$4Z7%f>V5p\X[YqgNn
T_eiVk(I%6YoUIp_(;BInf=0(o1RBq2c4g4@mn*;(k*=3_S22Oqnu^M&m#9,tg%k>mQ\/bmm
ub8mU[HGueuh4aD?#qmp[d4es(gB+-NsN@E\8+]A<Rek[h4I;K`XW3>2L(IRrcb#*4#EXEdtF
)9\@jaF:>$EHXD`/tJ+H4@ILYHS(%JQBR(?13rm%U=R17+O=N)iOI-X;"IVdU(U'+;eE*=OX
M0qA8cRg6j(8UH*H&<PC5IZ$q1)MJOPF&gEI!>K.q-6:BbiG(Q32*q)@`QOdRlkVTZ+M]Ao1G
`r-.aLUq0@errml_a"ANKKCa7O*&Jd,LVhn1"r95TbY<ig.&,C+Jfa4(mDkfqH'#F]A`E0geA
nn1To5#&f8E;*@X?[I?CVEM<jp9C@at()VFJBQ"M@FoBCk?c0S68-M(QI6FtZ2fFAG;M.=\F
.Ws\C(uTUeAB(_5]A3LJ..&laFafb*gWVdDYr54Tg*7[iKDTgtEQs'pd,8]Ad0,i.&K6p]Ags/[
oO0D^u4_XT`N?G$B?N]AId$YE1/*l0oW]A0!Hg*(RnZ>qEjorK",DcZ[tR8Z/o9^Z1>,.<b2A9
//YtGSI^dsaD7oZ3^paV0nr&6Eof8SBsagKE1hJ,-`2-`$UJT26"1V3]A#5;(%A]A@TKi+iq[h
/Aj(CAb80`qY4F.g_t)G@X;!AtK2Hso=<Bi"OokQ;`I\0J182\U'nU=dM?9,2PT@`,P+e(0i
:!fr:b;;f3b;m=.p."u4>-JH+YaXsKsJ,.+&=[@'Wg'D72$&!fe]ACBi9p[LsSkscK\mRn1KV
Am,'"8C*7_S&*&_QWp<3f4SLFK_S\'kE+\E#X7YX-qN\H_:N0MI7fKO$%;NkU.g.,5-`na2j
0m2"9M?boREp4\Ms>%UE#)8$5c@pUT70lP.6n>RJgTO*Oh*4@dOa*R4f(#hgjPX0&M'jXFG_
`(M,H4e7[IgDS*;W$;D%Bk-5<=eT]A5GMl;QILLjA,q*@*T%g(bN!f@SAY)-K8:$U$WT$a$JL
%8b6BFCX!5\]A%id&7$W\>N$bI3T14\=/!TP'#uQ%_[0ViH3Y2A:O2!s7jWNJuGL5HT+e`;GS
mi_KHs;4TG!P>s8N&flqH%^l;uZW^#g9-4^[qVlI=--.>4G,Ut+7Ku-5'dUl<XG4r]Ac=oW:K
W8WUBUuB!"=4fI@opJgP20kjHE<?1IDFA38L8_mCmadCdX,hUEouT\)>B>K,c$[T*TBlZ=uS
8sroE-5r@)NIBUhrn#uABO%fV-$mq9;[kX77f,1s??>U!O&Ku[,ji8A+R'5k"@Cnum[?A%p8
S\Ce^o+VH(^u8S(JttFjHIU,NZFL^Ge!g/8k?sJ42'QD:-"0/Ac@_P:H;k`_l+0Y3-S'B,p4
"ash`#_#0#+T2c;)Vtle%iA'+0%Ci9S\eaLCW)s+pAnSgR+>RWq)*gEHM$#Q@:WTKA/UM9UK
JJ32`F2GoZ8ZaWN%G+1Ne8Mt9[Yb\h3+#U%`r%C]A)%e;Qu$l\O:7l?,GD@q?UFsf9C9B,V3o
CGlo4<"W4NVSH-hEO1!lfHY54D=K0>Aa^l1I;$B5qJo2r)7\G?!mhRT(;1MEN]AssjAXd9(SS
MUB%JP3>/p\h5#3?u.Cp[^33m#9CXDqohfh>7ql?@ShP_n&nc;kiGn&6$3.$+WCf(_R7Haj4
d++/:C)&h?);qXE")$D"DWJO2n;7b2N(*t+r;uNSZZFaqi(gb&0I=4PgZhYcNonKi<Zth1'a
>1`BJNie:9tg[3*WKeO^C>%InQ&l<L:7&dJPXLn/a7Jh*q.jZo%S2fG"%O8@U6?D8N;/=FC,
<PRaE$MUfd&#p4Xr?L/;*i%B2j1X/E3^^lVc[]AuU=G*sO;7fe,q9n@2W5K2^-_:a^TP"D!]Ao
K'YI'FopqeMO/J39V0LnDB00d\M"W&1$RG:#`&0"fO)@G25WmNa2G;1N%@>Oed0)_]AW9fS9F
s&E>gE\cVk7n^:PV+Q4tdkWXl[8H*c#G31Rg`d)k[24DpC54FDeB>4.$7KmEXnkcJ-+""5Kt
4GZ%B3@DC!OTDZd[")J<8oA@X&rG,Cpe,-0%R@DdigUaCMeXT,e0uJ4GgHlUfu*GXXkH*$Eq
8aP.hL8YKo*iI-Q'k:P#F(.VPs/rUi;-<oPatBKgfNMMI9'gf^>3haHsG5Is]A.rGm/ejOHi_
ZR.l41\I\bJXJ?dr8iaquiU!<G07N$UB-]A%:"((V3R6FSQD/KlX!e(f%[ZT3/eI^76Z(gFr<
LF7^d:\3pXii8'R.=ed`m@X4_V=*+b:=d0Ym=^_?PbTIcZ(,`YZj[3)G16"\k-PsQ*QA7D)+
8PX!N@A$k(!/I)'Jdnp/=E4[b_`(*WBu4(hkrC9'Ud_J&_JlP;$mD]AgjVK1Q?MTdPe"UREXf
fVfZ9M9$Jt<?6*%9.r=<No?FkQkR5)$:bL:d%<OhJA_O>FRk1IZ,?I@Z;`AVTG\!`<cA%P"s
YaO+Hr'mZ3k-3q5%#s*<A-PApj3E*^@E7C\q\uB;Rno&!JY55^E"?JNY-fcg9(2R)*pCba'=
KHhY.N^%5=]AP1Wpd"BNcTGYp^TD7(HObe'UnE!)3;?H)4\"(01@Is((aF.F2D>Gbcc%<HeQJ
FpQCqUrAHQ93<j*0obH,KG<E;YD6DK`Ui,0*9G_a_O!d_&V'"g2Oprhf)n-Zd^o!B<RO9h91
V>`sk$K=!U&Y&cd+Rm+LY0T.:3k+f>;c^fHjc9KlK3boHmlbfmA7X:,qUDpjq&;j=4I<WaYG
O'3pWFMG7%QI2a81NDkq8raZ<&!D.4<./`daXa:l^KMbpYd:WW=/C'a!lY"o[@,3&bModHa1
7Hc?]A*j1:OrN<DN,'T^1Yod!b_e3OmaH=J$PusncucP2!DLLYXmTq=L1t=a@H=$j.o>"kq@/
so[f0-Nj3Y9<)kjXq8.`dm1]AMa:q$Glq?c_t5$e[pW[Vn,dX2K,72PB3`Hj%A%39)>f&u6%h
mh+7$;1(aRq#6ac^mTpD8s.R(`-5.>u:(6\b,Zd)ANBpKZhhL[OQS_*@WJNeso1dS'+EJ<pB
[ORFs$MlW"";8/=lZihKL2ipPd12Cjj]Ao<OQpN33.0n;Am#-^1O[lI\;U7[jdB+<0#ZK)p^4
2)Rh(KA9ljeZ*fMjmoinWGQg8:qJQJ[Cm5j*BNe;QbJFEhAZfbjX`'<htnSQnIO?J6D2d=<J
QbP9&0geGH5R+D_j[a(db-f1@WEBi#jZ-!S5@*(;$%:!Bkf,J@mB\H'i18^b*#@-A_"d%_&d
i"k"gm<#/NZTG&lDTekIJlBuufXmPp(Lk[LW^!/(dmspZe:Qbk%)B;i-c`,>YT![!b$lYV3B
M(!i8T%Vi)F,O>&*QSo+<?e!F9+s<0$L=Oq5^nj0K)^oZm-Rj+P'DT=hqi0C"/L='G>r`*l`
?lm`g9>\rYVjg^$6O?5i,J,*nl;k-U&r$sUe2.5A)bUVG2rNcQ0pEqJF/AC9gDdk2P%#2*1!
YcNbKjl*mi$=VO4>La5NHmm@=fWHNJU_p1]A&P*GQQ`q[[N+iO1?.T-pi*0c3&nq/qE>Gl2$X
6-N^-N=RcJV\hRqZUIP-"&pZErfi4Vm4^J:^.73M7p8_a0OR&R>TGL$9W&^r?opS0[Ea+mA7
4`'5.&14-tmh^APio=&NBo"55tc-'0*!$ns)4B?$*"H53sH?E^9p>M&,9nsfR;LsEI[ZL9$c
o)Moo7r_i[;T,j[AJNgoF)'^W8#&pf5cC:dYE09S#8f4Hi]A+sZE!0tM5D%2$a[H6<$9g[e&M
kr"$)CV!CLDmQZ<_sY0S8Jml%NSl!UJZ@.3t^-%!Th(HNf\<D!$[4,[7]A+M?:$6'O"uWW7o*
)%XBb/l'fo"<sHB:isIkTQKG!OKjFu>@1I[8nGWQH=QjF=sB$Z@HrX#&3f]A<6fEB'TV:a5OM
q/U]At0O(;emP?r5V-c`J.=*b#'`.kW00$,;UtbpP-n2e3YLM81&>?E0jSQR8h()1.$M%^6e@
-5(dVX#H>c7'Ktr=XTo_DZYYc9?1)o"`4;Pu"PckP\Qbj^99;Y*O.4oj(9d^j]AOY.na*\NXf
J?'Ym]A9b<VYe$BbVOP&(QU'D#W2Rhc9QDaR(B0(:'VJqcDCd)"I\ab5b)350nDmOoXi?J1HN
\rrh\L_S8hTk8kK]AjE#P=3$24P'F*Y<#-*V@1#c;\]AA//m1DTj^?+pV.rII#qo_PP%A.#*A_
PuZk6IcZ=(ZjQE!>nkaPE3Cj4O"1Q:F9#`KcDo*ETN*ZGjsscQ]AZM^$YhbEcHTQ"$]A&m\e-H
(Airn!(Chfdfu40pX9j/4m.Sp^G)4)Gf6Gud5"QhEA,F8[l^.kfuBCO.EpSl1WAVr0H8"]ADo
ETmeJDCT]A2e1*<\gO3T%Nf>T29pZ,hf:AI1%3a:&7-sbsFOnpd"H:R^rZ:`fh/9WB.?.sGAr
NZp8BKl8Em[]AhrT?mclGP&<8MXV((\>RZmf9+9%gstK"Qgf7uIJMO?\)-bR<)"t#Y!c%eLBK
a#b:u"p5=eVH!sD%,85Phr%goSI<@@<9'(=Vj1#J'*q%`%GGI:270\QofR4PEBFu=`r?ladJ
Di84n47WP-a+TU&7LD(t?U3X5;n4q/Q)es04RpJL:It$sP@q+YW-^s@]ACQKHF&4pfckc[aQ^
mt%Z!-OTl[3cjl^H'o&B(Pr!'$<A"YBA(.8L)A1,Z^S8eMN$R)gfS(aiPsOaE0GqD_k".',8
jEUAFVTmZ8KUIOH"i$jDkP?qe'MWB]A^%#0AgO0;CHd>VJr3jefb_!?7>-`S8Rp'Qu.Y\NK7'
)<C]ARK.ke=-?./B`QLS/PYg0Fk:OuSB&L>l'bg8FjEZRVC$g&-shBTN</iRWnt\WhV1^r(+2
^<k(I)Bi$fA9M9aYm>m6u1/!(@hc4.pa4b26=AmCu?),6A^8(L&X`uYtC;mFKFpuCb%PfKSd
TlN0)7#rP%3.@g$d9Kt-\@7bHAjGZXJNuBgJ,4Rl:TOY]A,WBVSG9KXDjuKj=GR_(MQrUPkf@
Miq#/XOn\,)auV#ktOSAibb$\`pnkZTdr+[SY0&]AdEPUh[0)l?+4E26QWn+#E1VnOfe2@BJY
b:`K'k(ag?$4^Lh<P3Y(Ih4o6*"Cm3Rj,3SZ,EZdh>hW_@,bf\I=anop#qEYknmrFZ=^`Pq'
G:-'Y@)4=`Rtd=c/lrXq$`(>A:4$[KS;G*S#`Rl60ogtjtii12ER%2Y)JCH3WZH%Z.i[>rop
qeD^OM`W'fKdkVIh#UGZ["J;lk"Y+7ro2t&l7Q@sBHXH[kkba=ei#lm8cKtR<-J*/8.n:>88
.2/+3J>e$UJ.[rIV*@(]A)?dX7%OM3Ed9'+DdA'IuW)R1?\'%/.jcms.C!S3iK.O"([LX<;0X
.c$d\T/Z_Qi`MjEDg@H2t+-PcODFM0pJ\BC9=eW>Y&%"=2u#L(iE-2;+-,X"gCDY:G`QQ$q;
MC[FF@)J8qENnXZ;PV1JO#`gUY`%]AZ.[!>n)>?J.S)FfV;bUu'@"dG7;ZftiCh3SVWfNsodA
"0h3pfmRbl&u3=8>QGN7?8k5o#45,PUf^g[Dcjh[*15?I(W,XoW7FE2Td$ZAP`J`MH[i$Jlp
W\J'V!-dgm-/mM+[<'06G&mRX,U8HTbaaj9VtTUr$83,*mgol;BF-Y'I8Qdc7i!3pPQMYR7A
U4%\b-.^liJDaLB"qA`!BYo=M-^Mm=DHX;HZN1`K+A0_l9s0CsjgW8p"[W[",f6_PJfl1>%]A
gje"Kbcl$Glas&iarcL$e(?+=5DdS%/eT:UC/XPN_#gWl)"5X[=/45tuWlB'OL=i6U[$s*DA
A#=@.^?siuF@<[Ds'1=1$jPnp19S-EW9+"_K[%rX*J%#3F8rQO>/17:L=4P66Q=ejH/TUbT\
ck;-L1lG&F`!'O!'0!W[/aB[V/O)X(&'W5W69&i?PI2So]AE[:W71q/D4l'nB(#C\f[_r2D>A
>eUJa<5O>s"FZ/3qp3cHZLdaN3#VapftYMLEP.bmU"%AK!_'1M0eAZUm"rSYW`A>F-qSqKVV
gR.F*Kui`*69X,T_6mMU!m#"d:u%JH$kpeuZs<skgFAaFmX,'!$>a8d]AR=P5&l9)4-AZ"5$5
ls4UkE9IbWds:jqm$+mn67g.r[U9$R1#>?Z%%X$ZWqr3%)+g1bfJ<(POS-1"bj[o;3(t\F^j
bjY8fm0QS^>W>1&b*"1sN#m>e'rD71_BM!]Afn(Q#Onj6m_186rOCsKF=:O(Z]A]AOESG?/%'<>
0WI$R:jN&[#k[rP"!qmO-GtKA<W@8`]A_:A]AKY4RPuN)HGAihR.Q0qb5:D(kT"Q\>PIM^-^)r
a+A`\ZA1[cX@a;4q>>kMO3Ea!5&Hh]A-(:T#$:/C^6[RkRRb\.MR@EMrWS8I[<DYY+2/Ijo$N
0J,W`Dq&$9*7cQb,KNI2E[0`NUd9fVU-tfk^USngeo6YK139h-Ug.Hs@G&++OT`e7JEX2#+\
k,C*0=)Yh5.Su7PsuK[rO_Dg3/lD?e^:ImB)'/E-Cq03)W[]Ab[RnCP)h(%?6H;8't(irnRM#
k0h>uj:QGm/5(HOr@ZuMikTVpT9EqMAAl7Z"@n2l9I!^=&Gd3T_N/G4\"]AMA&93l5&?k@fso
CVkV+c+coYX4T=`s'/Q/Em:YnhQ^ie%/e6Cf]A$-R0pIfE-^508R?j:%Z&#6ra!H4oR5[OP*g
=K5B"6?p%<61gO8_o!<~
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
<WidgetID widgetID="ea0a0929-309c-4fa6-8084-3c6c086f2399"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-658188" borderRadius="10" type="0" borderStyle="0"/>
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
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
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
<BoundsAttr x="0" y="0" width="450" height="408"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report2_c_c"/>
<Widget widgetName="area2"/>
<Widget widgetName="report3_c_c_c_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="955" width="375" height="345"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="主舱利用率"/>
<WidgetID widgetID="45bb9678-332d-4554-ba87-7bb74ce675e1"/>
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
<WidgetName name="report3_c_c"/>
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
<WidgetName name="report3_c_c"/>
<WidgetID widgetID="ab4fa3b4-82d6-4adc-afef-754433f2f52c"/>
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
<![CDATA[1440000,1224000,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,0,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="2" s="0">
<O>
<![CDATA[航段]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[主舱利用率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[载运率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[航班量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" cs="2" s="0">
<O>
<![CDATA[机型]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="往返低主舱利用率航段" columnName="航段"/>
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
<![CDATA[H2 = MAX(h2[!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="往返低主舱利用率航段" columnName="主舱利用率"/>
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
<![CDATA[H2 = MAX(h2[!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="3" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="往返低主舱利用率航段" columnName="载运率"/>
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
<![CDATA[H2 = MAX(h2[!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="4" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="往返低主舱利用率航段" columnName="航班量"/>
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
<![CDATA[H2 = MAX(h2[!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="5" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="往返低主舱利用率航段" columnName="机型"/>
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
<![CDATA[H2 = MAX(h2[!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="7" r="1">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=seq()]]></Attributes>
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
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-13732426"/>
<Background name="ColorBackground" color="-2167817"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="NullBackground"/>
<Border>
<Top color="-855310"/>
<Bottom style="1" color="-855310"/>
<Left color="-855310"/>
<Right color="-855310"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="NullBackground"/>
<Border>
<Top color="-855310"/>
<Bottom style="1" color="-855310"/>
<Left color="-855310"/>
<Right color="-855310"/>
</Border>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<j1a;camG9,ZGq$=b(_X[&nWekQs3iW9aU/oD\7\kE>D,Z1RTfu-i'+A7EnfFhcFas'J^&S
Of@/[E:tY*"9K=ft$C'-]AoUKI%ceO?N=GCASkWk12iQRIBG`rV[Y[4ngMRqjchthK/Si]A:7D
:p[!gacBp?H\T]As5H%3gB46IJ;B#"-5+3_J.cZjl[N#A8Zhc]AR5hl3#2,!p<H7-mXhoS2gHQ
ZdZRNAAp@HX2'^r6`6*AmO5$&p7:Dgq*<b]Anf;8qu#1C%A3XYbMeL`rTU<M=)Ro8^:A\o)uB
`q]A7K*ZZ:8tUk,Q-s3rY9C0J9h"Xl"So\:kCM]A&QHsVI<,)?%5U)?IrOhT<9se!<\%gk7G9U
4/R'Zr=",g4)[c5^9h%N:Nrd8O4sqIJTXAj92oC[e;J&p&LY.c4IQADTsk6`MMPEpS?_Y!7j
`P<:uRsIo?0ASTr5A\hKdTE*MLBSFJfE(0CJ_JdEg.?PDAYN&-$irm):7g"p*1\5%e+cW/Xm
No^!Prn!)'X1p#Oon,jgB+9W/ipT=nj05ao13*_uc:)>0+*e-@gQ(HjT+I6=XAbm#@0-89W3
kqul/[j_?SP*U.H:M*j?3"'ZR3+D*IakE.HYSkYWoFjGlKibRrAbqi+f'u&:=r/;i'D*f@#f
GbJ(s=cF&Ci9T.eFi2b_G43$jCi=,_q'jHg[L7(FlVgfI`cZ7\sW/DfcDXL(.?^\!7'?EoG`
KO!%dTJ)SkCaD)I8ac9S6#Q$d<NGJ2a,V[(7f6(qSPe3GHitNNE3U<73*,lS=;\aDVfh>lh=
hZamV7'K0j_-UQd1/K3_u=hlT!q-\k(fiPrJ[er9In*`naC*-:[>hJ4.?X/ghgR(4@>7E9)=
)?%BN#2r__8@!%G+=QfPu2N\Qn/kMm#Z._7-<ZUr5V;ma()\"7-n4"e]A<mT\eHtp+#=1;D=G
6ZkSCT3/OSpdM4_2cs9p7fb5$q[08T-*T?>H9CSgLL#eZ#+KQ;[aoLU@4)#D4\S?VcW^!L0Z
j"%h)o`/8Yh*/%kstL;L]ABERJ]A/63<'P\fC.QBftD@A0ne($!=a7Zmc\MYNKIBDNGO\,,>SW
q:#47EPpq`E$&lQ`KmS5*%7f+#JNb':f"`[[o)q\!V=2+E;ia*a7c%pWp#jFV6.?s;=l0[fO
>I'N:6e_I76ZZ&\NVq7GN/=DN-8,WWNljpuNengZYJCW&tYFg45lpW&gBk]A1D&^h2IW)gaEt
2C"&[#Y[aM(!kSnI"4)I=Vc0Gc@.ukkAZnjZjo&-M^j`S?;j."go7&70+C6&*(kY<.8@VE+T
:dLmFo8[+7H^sk]A:Rla*<SU(pqVqDQ/KO[/GTctYYJbrJqQA.8'@-*Md%F>3X/WmSN<tFWLW
q7iiJ!e@YY(Y^!o=*L!t;"KoZ?/]AEq]A3022uW)Z6PlQl0$\4\BPk#3C7@RK?dZWlF]AKHDs]Au
G0e7ndL.>Z&+5cF#-%jhOdBt`-2>\m;?H^s-29a/=:D4l\Y'9$Ku_to[WQ7-A84L,m?]ABa:U
MiGI?>ef@Q2dcY=^OY<&KE]Aj28*Y;OeD9;hd_KDdopJFWJN0ms%D@2WI`T7Sp3$&58)/+fqL
tc67'B);Y;GD-.=cok=HIPS5%!(=A5,r@TZN0Brf2/QN-g:U@tn5pgq6bjS^?s5Cb#+/%5fS
nBr-hs9X=?-%ERr+iiDG\lh@^P3%)$Rtag@R[5i?:o(GIu\eYk#Wh_j`IH6$"fc%mc`Ej=kX
-$%f4qD)Up(fDgV@9G=**Y\RJ[7^bT;l"%-*^0NC]A##!INFW[GSf*Fa.E)jVtXYS#p8<-"D]A
NT(?+6#hjrei&e21uI)iO'noLLgA&g3hmLBWJT2-8`12r&3G1D`"]A$p93%49;3ZKf\^4'Q>V
D4-_$Yf*-Ppn!.ac`YN*ZABHnnFK0,7Qe-.4]A^2Q?i,EcUJ=fZiR1&R8@O=pLjr7`5M`q4]A%
",666V68MhHkRC1Lk)n2_ql?_kmt)#%H>9!JBBgDTLE6\j=SUh/\]A7Cih1"6R#k2T0#F4g(]A
/^,=ETnqGMu:?27s1_eMZZISM!]A*L[N*X7$B<ON'*S:P<AdI)@CU4,E0/e`p8Tf1Rb8:jX7J
4e9@A42DGW9sEQ+VHY;IsQN#KItL>A=-T5UL0K(VtUC@-.kOX:b1ZfhK_H8ZXsdOE5Q>M%R*
puN_5+#C*;:B?kLfh>3c0-bnpcnBjc,M,NjEeATl/3=f_"s0U+kf(e:L4mk`BWe@h>q?s5b*
TfQ\q2KVD)4':;2`!8Om_oamSBa,3(##iWpH5Dnc"WiTn_o`61iX3Th[k%??V;I^i#oaAfE5
_UKK>b&'P`*>>;"IE@0*OhGI;u"Pe[1O[^AuAC>rE?[F"X>I:glMX=HEG78H"99tcpU7Glb%
3hglhl+/%g,EZ7$h]ACBmgjEFr3mL'pYK_F^UXDG'Blld:/h1''(+<&Q9bL-@\b?%7@[hEJkf
^LC$*6[hs*um#L+W2n%(::Ap3<AMJ)"Aj'Z)oYB*g,5,3_QG'E@VV-EUGJ#T9K37\Q3[.a3l
!.C*83WrI3bg":r`VODcl@NZ,UsFg%rl-Vdp5m<Bi``0[E#bW,fMa-V;o`Ig7@6K?)Q'Y!IM
,_mGVh`^10!-&-Eh4S"3#gbL+@FoT?2"KW1nbYl\F^4K?pT<KN,0mR,'<4ZtIC%<u:6XGrW'
,AO3[hh\X4o2FnlMnsNcSemVEWT]A^lFlYBWL4?:iSom+Zk3"tJ$-i-P(lt/r(q?N=@Z0GAbh
/F@[=)isND@"tag#*osLiTkriiDBm[dfO]AM%R(UIK3a>So\09&Ub>IT.K$H@@K[/=9c#C863
BWD<X224U/C8A[D?#B0b]A1[lCkuckm'A\9s,Af8u8D8icU5s7^9QQrYHZ??.q0;S=RQ1iLk.
rUlo>:95W)'L?VVAN@$<2Mm0<6Ik-:WKMnHOW%S%>Vp#hY?KW1/M.Qa/G!k9S65J-5r1&hUW
*"n`SgPIeUf,&I[l=YM`I+)Dn8]A5dp!j6?jo-1Q6/^O>D"GTc0qsD^o>i@F?V1/&XdbXQ@rZ
J%ds9Z.$gL?g/kC4]AGQhA%^CS>m]A:2;o4jaKDqPpYK9'*nj%cDQZjqj,</pDl.?jA&dDQDbX
?A%'ICE<R_D+/FrJSD.Fdh!a0^bm>XV,$1S2171)q:b_-qm)['`Pe:`:3bOinE%j0>/l3NCZ
!L`3ArIRsal$VY*A*C$!rU,P>@,^*kk--(l6\2g2#9!p).q_Ei2YUf%J-A?7>VkN)h80NmGr
a)"\U#aJJIc?la`o'GmhQ@!)gfm:f%L9;S<d;[5JYt5BD\%p^%Dp,^^^Wn"PRRc]A&mS$;W$)
0&0h99jgF7uGFjQa\:Eq_6-$)Qd@E`&S\!@KA;(F[fP_jS:nZa`$mRJ\o.5MlRH;[*!je,k#
[2UfT=04%7"/$P3_B)u15j??&DVAo4M@aGNnl;hfZH8F;X?Vn*&F\qdpp`g"Z`9i>K3p\-"=
W\r!A#"2:=S^6/5=-igQ0=i8VKg7NiMIf=4n)I:JfTA!NJpnM_++I_G)70-B^_lX<,ONnou(
BUj^IqLKYaH@?6<=ZS$*^Cd;]AMFE8*O^\YiCob)j^!+-nZT[0K1[jkes"3o:h?R_W;\CFVZS
EY5`bir7-Rgp:*,"&@!L0cb\qJIuW8"%^bHhnOT(Qbs9SRu"*f:H(KVKus)?TCkGSTBdM[j'
rlNT1Za;#s6Y,8mI<p^R"U)mN-7`]A<"'91eM0\?$b5oJrE):L/_"[10g]A;]AbeYo<SR=(RiO4
YE$A4E_^od3C%WdJ9-i@aeq9Q$Y^opS&WX]Ah@,u:gh6>5N*gCjtMhb4p"8lV[.oUjlB4JYX"
eV?r#`L4]AH\nquNKtH81pjJ+'fO"cB\F\th72f/1pjb^<fpEu;Z7hD3%*id*ORfq3O(t4\GM
h!C1pg'lI(cqgR%'<D8Ujt$JjuMBjP0VfM6h/_,!$C2I`&X"ph(qVk3AFd2(@*5BsT]A:W8P/
?B+$5?7'n.C8Vb2Nf_^+D8PVgqP#RDPts%XaDFPH<G'a,SLVIqf7CZN8qc$)Xf`Y8>W:03BL
WQj(`o/,TqV_Lj<`)W;k2e3MP\^Z$2n+6s7K?CA9inK1nhsVG.D]AYZ#16`Yn9p);>D?^:$sg
t$8p.)U=s^06H>S7]A[5k=,K4h>$NOJK4R<[)$U05*mn\="aDW.J!8\7!O,YS8d5:4V53]A0=/
gfPfTUUZtJ&8!d+GJu4B61f*>8R^<rH-&eph38qlj0iQ%_DQ/KmuiDV3P%9;PqKX$MgPs+<W
GH)N@dbN&;MgkMmD6hB$An<)jW&0FfE:&eipSF?L5n@/RID#TiZiqqK:uZ2"AukDQmI`Z'&C
HC]Ar1TF-ZCWC#_&1'<SMPS08Yqo"ch8q@tN#Krk&n.C7i;\4uI.p'7U%HN$pdH(nklLsL$W*
n@Z6*M3l$jJ;W=1iO-leMk``Dr.8!<$OmDWMH7V7U9,>?L5h2FB&f/4L`#U9>gt>?,[.Putg
RGX$ofXCo[U@3F@]AN+u-ZP"6CX?E1'n,#U&Y,I1#pW=dapC]A#^s*[Z%<,_bmbidM6\)f>jHj
GobO2cYfk`hdblLWELTRg5=p-\+Z>ST;saA5@rK[T%OFkE%Ma9RR17ItpJAGKL<>,l#)V)>m
L#Y[ptVn7hNmq</52<gEtU?0mJh5dj2-Ari-@`A!od@@/qOPL9prL^<>.Je.DmM+em?Vjk?q
Y^I3bHkfSqb#qm6^./sRR`QD=cP)Dd-0*NCb$_AA7k:^ECC?]Aun::`1cH3_l+W<<&[^)eZ$Q
+_[aj?dI6u-"lCDAUd6_3JR81`6H;H,O.$#;s_kH@Kt&P!i)R]AtTPU8"#"l60WH9J$<PQ>2B
tmg9nap#AKA+W%X4&R>HH8a=fNMH)KOH3P7=oP?l?f]AYa72Z8cp>mT_ND[e0XJ0&-'BZ$W*\
N@5Gc;gJn*h]A's`m0Old=R8'rc+1)39(BsiIKXpCVCm-p)#q\;.fs:pZe"&+c#\<oYj5=Ub4
:ADsO$$`!a5:C/3bN)$;e-/d('5,6cNMW>5,T\'-4PaZ\N9LGqD@KV"V'JZbURioN0l7A/A1
1B^>m1tRUrn^3\AT&ErDM+ar9[d.e=P7">.!&Lmk#QpG&r%>gG=!<XA>I2=fK3^RA\G6<8$E
LT&T]A.*%,$)=+WWs[6=lZ0(\aeST[C>Jg`lo*X,`Tt*1hpSVl8YKRhN8ub:-g?@(mmDER[rJ
2f;T"E!HD<lOY&MOBjI2M>bTLO4,N=rC:.l]A&*:$=o\'g"]A:SHU#2-XJ#n91M`"5FL%)qVC7
\kt70kMsW!eh"G5[W/1\NnUtd.L9KhENu$eYNL!q$i0K7j;S>$i8;CmZtF:4#f#kULn&V_0m
ag6_3Am@g$,&`ZW/tZt*hPL+X-*IYSVLSVp6OdM\/36,-l5"CGZ'*GZ<@+<,R[`#bO:fu1,b
=bli_8fN#Q!cW`L'-P[XR7>1kMWOs_#F!/d8"S0]ATULr)K0:=UN@f$(U(g(1Ho8h%K%-_:=U
m+cW_i\IqWcNt=PZ+#\tmS\fk.[#\/.aP/PsS.)X!LJEBTf>Aran33^)6YRV=pU$13F;[!K?
XU,^Nf?u3V9L$N(^Te?t^fC1V,E[n)Q\p%BJ'o&=*jTbJ$rY8oUi-*<uM(s?f)a!]AWm,0B']A
NNZW7ITQ@Z!S0oTpsu/+utUA6Pm\bjJk^0d,7VOs!.>NELa^k4C@<A*]A;.Y-IXHsACY8KUZS
7\)N2T'TS[KZHE8@jU@ki^)rnjLHQ6U=m,6"@@O]Ae>Woi=u1AK)9*Afg$Ig/'G0S+iK+?=bT
2rL9jh]A?Zc1Pjk+L$uH6O3^-U8FZW;.XSSXX6MJ=0jr$^#*/Ol@KidfLjh4@UVXuuF'Ak.9H
"^P=^+\PT@iZ+,5UON2>)4&e4Y2qX%JH5U+>b[*DJn%CNKc8Puo/i`CIgY-1tpe(Xdd6?.=]A
OA:$?6&!)c(d3UjMqs(Q.J<i7g$Yc+K6BPa,W6V-@BM.I%[Fp2.2Jn=m">f95>",Am5ES1-_
]Ab[tJT<FV6M74MRZ#OZlm^8l!m?=EZIWt*$.*&4)l$Gq;d2/Rc;G,n=#E>#o^3:^nq"&UD33
JDrID#i/oY8WYC4Hi)+1Ot<dh9;8!uAZmoYP8),s)(XLWKr2.teEn#GOi[TJABW"1*BG'!BJ
YJ#GSmlNb#l=W"'[4MnA:34(B[J-cYbPo6ri(KRr^nM'(RLsqZ(Kno]A5PlG4QO."In,BokCA
^N&iSt.i_MRAQEDEUo2FkQ17.Xe>2MPU#?m%*(Uu)Z+-[el1(QcUr&oI'j<):<O(^&33mtN`
Zp=q`h8"TZS)5R`ba<lp!]Ag50SO^,mGOGCHt@5/V9(1:BIR`OiUgVn+"L7ku[#:HZJiftl>:
(f8a(ZJ9rSEoBmqTN']AjD:K-?T2NfiJL\T%9QAYF"KmR^@:=Z.)U".G$L?Ro+%=5P=AKo(J&
k-MZR6+`r8E(O)A1J`cQlgk@<3cYlnuNg?-%KEAmt0=_cMM;+.k)F-k`k\=EN5BtM;d/8Rso
'HJ<%hJ/#:dIsANX04"6oQO@IRb4Au]A7'DAT1Q)-h)(Tg@uSG`Ptn9a*<>_SMS7_C%Q<Lf@l
b?4Wh@i2_,iOiY*K6:<gFJOju'961ITeV^aN@0HR$q)Dnt5tcT7krMkcZ7J#]AX9j^15F)F'h
&ZskT#Iiu#OD0\'6h$@'b^,1M6bIAbKJY=lum$X@@s%UdZ0EY>U)$ION6ncRoN:hBAa#-Z\Y
gpiEZ8ONq0g!*h>N0m4^*YbjAVeE>&Are11S7Xmg@[r^"<!68T2=5s7#/f-hV1hCC[QYPIj_
lh(Gg)E;4BniYt;E&'8n#8QC\qImH/3\#JJ&RCP=64hB"&O(i:'Zna&Dco>MoU+!KM`K(a'9
?fejX;?'XuA$cO8"0koA,t?EiHiJS)`hEbQ3jk]A\#Wu+oM6PBi!-cSs"S/F7`QacqU%6Gf;n
649k@L&@r%^9mmtm+_gTPm(OA'i!`bGA3:e]AuL!OlQpWTfEmH]A!,!Z!<THh]Aedk&hB9dB2d@
]A0&7lbWKXl;S`'p)G-%\!N=k4gbgBAb<8P6sR!robR$g0!UaL0o8VV[f.SGt(XpmDi;2fo*0
WN<PqW2^.[>i@U#1j@Z,e[L_G+\CYVOC!jD]Ab8s?X<A'-Z^VM&N\Q>_pOo@]ACfPI`=N_R\0W
Rt`Y6&e^LA%Z]A^i-@W_sikQ4:SGVrbG;l$_f@CK8'H#g2,V4+p;P#k'WhWqYoQ[JXX$,>T^c
d=".-s5N.5s6ACU;(<*`23qX>Q7AL1<`M7D&ctn1.L<=3;3]A^`0C_)3%bNt*h^eb+b5mb[&4
bfDa#"o]A&Wp@=bs.65-FR'Hpj?H6Jtl3,,)hsr'ukXi!^,dE?N.tYNRdr!MX'liU6p3bdH`5
g\,rCH]A11#H[;Rn3UJ9e)(j,iPW2_TE*VQ!1=qK>'Q6!TA@e&idXt4ku@'O"Ye1]A=4<Ri-.<
6i(CR`!qsSDjh*-<)9L%m)qNGDn5C6Ku_Z-FL]A%I&bHik[sPdiK$`YFqA!i;J$u_kZnZ+kh1
2$%ToeRn2_MBWp'eF@qaV*&;J-Z]A[oid#JK,u:jS'iV6-$X5t#sVGg)[cH/77(rlY[nCF40J
N-Mo'Pm:afTKR[KlG*@hV+0pfmt[8DWI9N_<g)IZNV>SsWd27:K'3G&GAJ,]AF3:bsaI/o=II
Q0Dg77B\[FP43n'>&#j"K7NQ7S\5FF!N_'$^0b8T43*$!B8Do*T*!fdtE\6\-b'n\[9E*f,8
mfLAQ=Q"4b$5OrW,.D'!<&M?IN\Zhh+fahk7Sg]A<gfm)OnM_#qjZ`h4-i/1+b%?EE"&:XG\W
W.G9iWDnfkZ)/?fe'D<<rt5YMrc0."f4HE_0c(uOS;j(o=,`jo`=bt_=+\bp>><tRAH(pMDT
0fiIA.T-XTee]AA&VOHS4S$<))'EHYaKbB%U?Mle![MUA&"VWB7.41LqaS47&?rI&q3EFe7)0
#=0H+eknO[?12RF]AB4$K(,Elqce'bY:CO=gfZIrr3O82!(`p&(k-:c_(XXDHIK*NfM@@lS#1
tl<rO3t!9_IZK)<r8lH_rZ2Tijf7VJG4Vh^*.On$7?0'Y#W>2:eIu/8#mH8a&O'^R),aFPkE
eL"L_=K-rTJ2fOK;fq!BFO%q7,%J;<#b7j3(O,h84AZs[Ef[1e\oq]A3em\hR1Yga$OUq[#6n
/JBf$d:VpGhVHFOHo?nIn]A.VlKYQnGP579)n$'l!BWjik#FXhGa^Be!YI0QV";G!+]A;FQ]A%q
:7-eYiSh%n^t`pn^Ria\E&Wg2]A[%Z#gd#eljF:&7S=2l``CCk#5ZYH5!nEV6J8K6G\$SGm:B
E<ZV<Q]AHH*,<E5b.S,tRGo-oT;kZMK.O)u2HDDsd1ABC1U2Oo<)5U'MZS&,PM\dg9>4^dJlM
i+Lh=,O8-l#FJoqE>AHbN:"@YFiCG;Vop"Da/#nO9`K97DYUV?Ejan*Tf9lQ"*_[$<QaFum0
Bk='5lFrUOSOheeM@0M6G'L#*AAgc4X8WJ8fCWCo&&n"5!12TL[FlA+S&c:u2H?.l?'A.^V/
C.)>.8RISU\E!!3*<J;_s^Dt=PXQ:gTCP/JuXr^r@XF8NIY9L&%eu:Ec8Mcf0!1G<IP18/m0
)><m_Z212QEtMHXpsjbW]AgC2k_dZ\:?BTW-/gn)jMUOmR9?fs8NqKNP.UdI3Kt+.6o++M6?&
+s\hp6n$7J7mbT.hY&R+_c',n-L#(,gr%F!:I$\^[PdgFV'?W9ku!`4U9Xo>^kqEnf,K['9L
RGO-n98)[!oat20mN>%XiNh"HkG+g$W!V`8>W#8s`:.o46<^7Qf8_(Eok?MkYdml_='<]A.ug
p&S"QbEHOA"aOG!R&>bZR$,8"/+tF0,NP40o5gOuuN!;Zc49\hMM:E2ln)J9goe]A%gA9I$A^
RB[mc'a"Xnu:FU:4h#q3DE:$i:13d5)Hc(g:V@3n:c&c<fsq_NtBui]A[^_I$\NSZM[5Q''s=
,p5.l<H86_72Urrb>EtM]ADMl8(DXgVa\U0(-!-R__bl>m:S,^,d/Qupj!cA4P6%7(]A[6K8%P
akBL^XIan.4^IL"1_EdGLZ]A^]A$BZ&*,h]A8)3fYV%)$1oIeGQA;=)R,/0_5m4d?k\N<gc7/7+
)mE=`+V,.rA;k*MuQUPEkZt8N`TVm=m1r)aO.CIeJr-)ugS)Y4S`L2#s/b3RDNpHEWLgMP8f
qU-;Gl\KZ!<S[D*faq6Kn.`TO]A:@X*&E;sf@37OceE&Sh_3:&Fg&%APuF\olkNst-5)e\Z>e
uhg)+(sYN]AC!ki1,e[=h*Rl>NfK,g\eV04_>^'VLUMW=K'm&a-DsZtq[QOL5Mlh7iD]A[dbUN
=[]AgN&VEDHJoa+iS4_K8(lb(>E:,8fIJG8%TS``VaRII]AoqpnF>?!.qXAS\rD?4Z"EOjaEgh
ZETjM&'q*C:9*`Cl)EhKh/[*&LYgAN;_RR6_;nFJlHat)KP[h>$Q:X5m)N6r_>Rtj)LGgub2
,<k6g6MBAG9BKZ]A-.bC%A(P*o&F/j-?9I!jfr[hRti)*/5Ic>n(rEs3VUNo0Af`L>Fhb<.2T
;<KAlPoC-]Ao`lqUpe51W_5hoQfm3/C&AU(-[&^/?g]AZG@rX=LPP`S9R[0-F\$W6\4Z*l(!,9
m)>Fm]A?e^-YT(<\sHRcO5X3?a=]A9I$PF""W^h&6*k@MN+nP.;m.]A!ugHSR,rp_7If%mTO;J+
_S>UacNHlWg/T8$7(l3X;_TZr:o(uABm/jsu;=h":1d7*]A^DWpL.'pGL]APY<E4(.Rf:=juDH
>VAVZ<IG>5.<9aqgYBaIIimeHiQ3KCQ#@i(ZR8??.5#;$pR#H7bEQ8M.<e6N[D'pT`Wn7tl\
GhL+S!ITmeT)DH3M-#@q?%O`[_T'+ID<7R\jQI1cZc&&ZINc&D-F7)gCdVY?Ha1Lm9$#,4bJ
hge#DOl95gQTI4=5;PPqo"-G?@<92DmE\s%I$V/.WLop<YcQP9uKMT$UHn)oQapr24>@)=Fh
n5'AHh.j^l1$2>Fh.uOlQD.f9P?8hgbdDjou+g6"Ss=>-!l^#`#q*<=t#uE7<0Ycde2RgSA[
@CqN64PdLD`A1&ultoa$ZS%rMDMRZ-u?8_R(YDhmf%I\jjh=:_l.jE_A*QH]Al,"609;$rc<\
AP7`D=189%0-K6IM0R6-En4!k$pi>f?BEG;<O:HB[Dt#-B=9u.6-E3*)G.NS"AtjpApW`\8F
BA".X_.tVf<\/UT?+.p@=\/egb*?g)H<\,e<k.ksSsWFK+/iTf;a^[\`>WU?DJ/`?E^3VpQ?
'Qq'>X&I@WaB56]AR^.*A]As'mr+"?h=[qn#^sZr3rgR^'3!fg\^o\L20,5fUaRGhG'Lo@2C&$
'N#oV4g.Z[Hc3BRsdVuZCBR:*gf37G6KodQJ8F?8Em"bI-S64Zufo1Xe;`qr@.I8Kgr_7*T&
+ia&2OPS@t,iU%CQK$(+r^:Snc3,']A=5:p'*p3u(:_PQAub\,E3H%WW;U6_\-.Mack9RRY,c
NE]A/lmhI?.ZJ!HPOg[5Z,&/m/2Pt;&gN6YP_Q\l+JirX9$\P::C'b_-4T,7@rN-bp*f(!c_"
^WC?5,fso"4_/c/p";YBSpjX^d9YB,<I#b:'&hDF-Y/e!Lfb2SKO"!/Een^RISZK#9?[N4+2
ZbAr\FSh\!o=&.ap)7sC^I/%YLe#^;)YD=(CSON`cSl%t_m*^3u+p$eh`&>r1gn.'G4kU*C,
^25>OXT-.0\.BnnaLJ+[M9r0E(1"fVjD$@@Sf"8GMkgD;3golgDD#hr4N&tRME9X.'1);43f
,AbL[lqmt&Z*Or&!'1HWYk%sH$*M!!U>TQjX<"p/8@)M<WKc*,\c=eZnc6WrKJ-9feXqq`]AF
oETf/k?Y;2k"jDT8gikA:VP9n%;[gP8%Q6na7R):Lm_Pl9n;@R(:2hfgMB`FE]ApEl!$H"."D
&:E*-5Qug6.+/d@VmYrt:KTN6"#G)<t@=M9'A^i6#No`/*o0J591;41bd7`5Vt@H1jN^%%)m
1Di_#nSYTg.F;&`OhjWE,+S.bhAfqsmh.(TV0u[(W?2V1)pt'J2k)MEb.,>LMes.l.Pnr_<B
:+G:U(HMh,[;&=l.!<DS9uO_k3mW!8+_0R`NuerVE!Y`YLa9%=5ou>\)GupKm>qQ3@8UbHuj
mC+:hG>K-K!W*iCl"*g49d3lau"Mr\\H_jig>H#__B:RPqr4m<%"9Th"fX1?]ATE'gA;X=sDp
j<8l3$u%2n8R61-Q<ONga/XWDqH$%:#e5*5G0e<:#fJ@aOuk;aj2UcT?jGGlU!#"Gj[>]Ac=H
"Z!*VL#0'lL@6M5doYj[ajr3a6$)?+3pQ>/i\[o]ApLW[8M.;:3sk=JP'O`ch]ARI35"[<)3>A
k/l,1XoVO8[*q_cTj'8?n%V[?`K4T02[Y5rJ^geB="9Na1,5rltS`PQS)4!l>fU@YCa(8[c%
`0A%&!:mf_T8(03*Se+e_#g+NfG^noDjK<8i]AN61l\OV&KF`-cn&"-cj([\r7cP@V>X[ZCg)
faB8V7FmZrsONn[-9!<93V;+@f+=cR(]ADbnL(Lj2ClQ(2q']A`0G8IGQ)5f)a9F?q%5eUFNrO
LQK,u(UpGb/h>0.(sTodZiXf#Ac4Kl"nL'!Z6#ponsBr5:]ARo&6!rj?45Uom,;4&6^sCj.c'
]A_7bHYSRS+oIGa/2GZ=mb@_SO?m699/8eV'F^+TPi@T/+A#[+Q]ARZHoUet'8r8n1UTX$'\hG
qJV;&<k[R0S:a9SQV["EjU<>me[KP(ZXD:C6O-u5=>)-Ati&f'XI'Q)hH<;U2g+fA._<:6AU
9-&H)A2StG8Pa;k:N!0=nH'O@787VR[ch4IN=/^JOFRd.4i[U!-=s#ADl11d3LpVam#++V<k
]A`/pRV9)`:j2?#c-'7JO@A6O4K@Qsr9sjb2M\P!;5p,0@>:h:qk\80$e:P*WND4j$n7X&Vs]A
cmFSKNY3m1OO?Uar=crm(i0SgdoX86P(Q78+=tV5$uq;>+QH`+rs3iK>SYt6I*iV6liiHNqI
F_6#P_8'ejrt0+WH:2S3$[bEUKtM!"uXCRuUg\PJl/*e>2PshpNTHXgTekL]Afna%,q-bN4Um
0r4u8V"l*sRla9m1!omHu2=ss<22*fj/#(PhEFkP=2o^HfmfC)(mL]ArI8%7cU@/d^U_`9`Fi
7E1!0GHgh!pol%"M#p(/>SVK\3p\HZ)J?_DP<$&[hj,&jD0)Qk=uh[+kJ'7Ao5ubCMDU,&!e
'GLlXs?4NU:A_D_3-eR"Hj&]Al="lRphb3/!@aecLV[X!C<("onWi,93eeRU"I7auH%k7c=*7
:G-N[AQk#e*N-VjZE0j(5K"#BB53;?]AhjVXr$Im8lbWG[<(%8PmN(LB7`aIR^YJg$C(As`!T
Vsgkt8ahaX';rhf/F.bhlO;Z\(BrLc8%B`F0nI3sk(KaFh)>HiXLPI#U[!R__bYCYTJ,+]AQd
M,.g<PegQu<Z,B/JNqJ_T)c!+ZI73Dg:/U?[`$H':me-o+r`a=7UnT4/HL4(Yn%a#E00:L!R
OC?\$OO?;Q]Ac%'DX*8*DJF61^r5?>8@g]A9c=I%11_l1V6a\R+3Ec.=;m_b&Jdj";16BHAD%U
,!\In,A<fGs;msk4/Q,e0E4Mlc75'^*jDa&PS<]AMN(E5rDmY?u8o9)sRO29<9d<US3Fq3NB5
V+Za).q6Id6mm[S0pcI;3Jl5F<<20/ZNUb&JBBI+cX=\ARFK4AD-&PEpE@&an3g27Mh9:$U*
\VCq_p;3+*3G9Z/2SlY4S8qJPU8+]Au"u(N`9lM3o2Vd*t_2h19FV2]AD)R#m0G@Nc,rIo1#U/
cDU\7j`05?ArWB(U%*e>[C>Il-A7+bLR$fnpMhB"k&`LHj3u_1p^1!5O]A?CLFnlp[:VB*,:[
D>;W(mm#nkF@UKjh\Gg'0.Bb=1&pcPGpT#P"V&R&5R`gcmegl&8:AHrMiLp/6@#kmSj'ZI2%
c7rI[;CEu9+?LA@Hceo"emp_G=Xrr<~
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
<WidgetID widgetID="ab4fa3b4-82d6-4adc-afef-754433f2f52c"/>
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
<![CDATA[1440000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="2" s="0">
<O>
<![CDATA[航段]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[总固定闲置\\n可用舱位]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[固定闲置\\n可用舱位]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[航班量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" cs="2" s="0">
<O>
<![CDATA[机型]]></O>
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
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-13732426"/>
<Background name="ColorBackground" color="-2167817"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9P'@;eM\FlFQC>[P2lsb#jeMCj1#G"k&]Ao`]Au;[XgF"Tfl^Ie!qA$<&KqFF"NY.9Nma5UCk
jGO\R[a[AYpk)7>XQ+g/:U%OpDXD\"jSP0n^*)+N_`J:XJN>+Rshod*Br5LHapgmsLJrp\s%
,ji$nC^*DU)+$T_B7>hpEo>^+"ro^"E9/)8>/UmE^rYG;K%B"4+U.+E!DnPpb^S"Yg&'@-3V
69aIODq>u&,k:US6g?ug8]AAgqOW.I+u:J2e)12cB1l"&r:9\c?gW8Fp\q':'Ar`P4\Ffpf5D
VcBpC?kIS)^eEK`%:d[lM(%dD[m,WVckk]A(iVG&>2PV`PQ:bS#NCO^1E.cMN9jW7<>oe*X=m
cO_jQGdVB0)r%@^`#U!/#=\8qfD>#bj:fVTHD,1,dtJJ,5D,(j<g/7#h9T<bm'gai"T*H3)D
SpDZgYEk]A\$hV<YH+JHAh_q@0CXp;@BXl&srF!n$l.a'a'VuUJ&M'FlJVTaF)i9*L0^2eP.u
Ma!kc4:E4m<*A81M;qe5bmd<e-&k5L-m5n(@=CZ2U%"-ab5K;S.YF1q\:.Uj(Y)Sl+DE>J\5
pd9#$DL/op"I[UCJuRN/fdu)l\73.PhENe2V!Yb>A&8'CZ;7=1FcQ[]AfTS/>1CoKeojufl+H
GImI`*Og%ZFi<U6b=]A]A6-!I9UsY20Rp^5tp]AT&lZdc/hJn:Ejlh@cM^EJSPXRC;;tGk63]A#R
egDPL7:Kr`VC$Z07VZH#%V1N5$SUh,aEk&U)OEcg8aEKHhXUAN\A"NTeEcuE0ks<-C&8CXa2
lqGMT#14j2Z1O,u7mil[PsupE.m#<I`.!P1]AqPkW"LZ=!NX[abdLbW#'2I$h]ALeZ$'c]AIJj#
nHsZa3YbUHSWHehfBD)%F\S?M8Ep/a!Ijd+9P@_0iRinYD0G5UJa(&!O<"fLUKrlBPK4W2+)
?-_=[bKSCd)A]A>U:\l@/bYd)enNpAS_P.E:i7R(5P4YR]A0!(\j.-eUh#u7OQsQWVbUd9AE^)
&uaQ/bh4P)Xb(C%e>/1T,so6)P2Eq9:ocI=?@pn(=o`2<m&3k93*f7^;4JS_?C93>@WQ?/`8
q'4o$QV^6P:&(95bMh=7STXJO\BcX/AQ-(-in*3Cc9>a/HSB=o;[Lj[SoY_7^j89q+`LT$!m
?Q[;S;*,,j_Tb0JpkO\+3d)*-)j6'c*7pEGN-;?-lnU8r;XV[$Q*]AdZqg$XuVN8Td"rsJKaB
I12W3*oNQ3ngl/I=Wk/GUa):'hS#I*G/K%C06Jm6F=sGtB[GNm/&IQk&,Nu,u,2:GOnsB=Kc
D4M&YsOdlP8?r;f'hGm@H>b2AXlS*G0>!R`GUR]AjFuc0b*L<'/nFK^r.@s\--q.4=/X2icFq
91-,g^.,Es:)YlAO1IOZ/MU2eS_j/peTe!bOBq.>#+V(3QHE_AN8TNl\YW23-bQ'=j?n+*2P
)8"B+=X=.)`\ENX+uC#'^GDYg?9e&0%UN'GTs42Y*4!rds0_&SjN7lPaP$_FJ%5QV\skDDmH
hid=d&&Dj2Jh$MA:3Pfe6TA'!N2]AcD)V1>$ef2irc#N(h1,+%fF?D_f(u&OZ9)&rA1X*kl!5
F"$)GA@Jd<T%s&eX9#OJkkP8A`e#)hDG%TMbHcbMK3s+GE\6Z_`chbq_E4#'WRlFg/:rX)`B
,ti\_kDK'KJLgrA`H)3Pg8Kd]A/;^[`T\kL3!>>s1Gl7V6fL)O6n"qd,K13`):fud_.-rP3Zn
X_m4-O_Ucc(aD`4nk&im4'lnKAlAj*4\4p+$e'\V$6BCb7a\3/&c>$6HEE@HU3p$mE=Y3DK;
P#>0q]Aa>_O!n"?gk\U9u,s>MZ"=^Ta=0uj8(mR2J_!Kuk;:lmkO2*4'?lBm-/";2Jc>BVMf/
"[NVP^EHBYf]A(7,Bq1O;4$G@+tH=cJCVYK=l;3T'.P^_n)^n6Smk;%?jE1,SeKXG!.^VmE4d
sii%&;.B@a*)G\$*^8EG6dqWQ1`UsRC9#591gM0@[W_)Vo>-U`q:5^tS5'l_f:CHB/;b(tU#
5rg5N4L)L;o5GmdH-&0XVc+$@T]A$s`R6/!fR'Hk3[#+\:ml!O`ZOaV;t='([AcQY6$!O)X^[
4@UqC4r$#U/WK[Prt9uZ#a>0VO0Uepd3RAlHOOb;&!F0tG<Xj>'^^$X8<Z(dG!Q,mJ-NDGHq
+(N<gHF+SVf20+ig[h@V)K?26_#4G1CgKT*5U"G%G8Y5;<dWaKD6GC#R<['>62G;0%@<jH>\
"k98Y:Hg^KN,O?R*9AY^*qb:MA6:Vr9hkA[UNW2THXK<paFZ5B/]AIMKk^K=Ah1'L#r=3^Dqt
opl[MQfULHG]A'Z':%k0%&Y9b30lc`!]A`LjS]AI7c2_ltUSncSOB6@A#VddUE_;?40D_<!.1,r
sl8,a\j"X?r.*OXY:i`4LL0XV^+C+=EupD=GDkNL![1Z)c7kQ2@aZYm`m0Z11J6%+q-Qt2^n
p.Y8%^TQAGe0\u&o(KR0f'd*fQj=iBJK:7AROY,@0Ei8he07-lj7V`!"1c=ei$<nc@&1+3a/
m&=%cJ78J=&1(bO`EX]A51=(@LX/TI^#FpI0Y:SBAZFVOVc"Q7j+WZ8bRCk8;X=Aab<+]A'N6?
Fa,f$\fIVj6DG_?skG3#VJ$k5WFKm:E*mg9(+jr^h+d'4nSedLE4Mo2+.9!FF!:-aVdtf-t:
o\F/k(n'AYUKWEXBH"q\r!mA#Kgi`iu:FbChEV9P92<1/>#5D7eH@/^B9;KFZ2:]A!XMR.?up
qM5tr?aj-%XkM-3^[o!qm85*KIJ(D=gRn@8;qOgT_mZTP]A95>jIrVD0E':qfp?X+PdOb_:&N
,Yps>/pdrbBPl(ic!A^nmdX(d6DS/mu\dp+UrCc:t!CpOau'D;u82u#PP,H6?P(!']A^@?63t
D]A,%oE5NTuWmC:+hN!MCJ]A'\t&NiQ4aFFD541R#sa8,:,[Bc*ACGgZV[M#L9)H8J9O+<!5@N
gQPX,]A7VDe-f&NB*)T)pmf065mN7/H2<`OoL/-d;P.9e/pPY.M#87]AZOa0jEF^=+HPf&f9fP
.cd!NrLj#c!da^,&VNsYe<J6se@E#gAglhebW#Kp3^8<ooeX2*JOq::^7"KCD6[g.6$#RE+R
TK->-k&OTY]AEi6r;Pf+CSDK>Hdd4n@_QKtC=[,J4HF>m,iiu#[=nc'J&Ne(4/Yd8bm-=I3D$
[<X84ZP`-bB[N5q#6.q6QLo(s88k\4kmH_pKG!p+XVOjPIC\'E-:.euQR3W/?tFF<Jp^pk0_
B9sb4XlMu\#%?6qfI\hM2+_-o3=>5PrK6/e>,A_>F#(IK1/%k`_jutmm';h4'45+rC7q;n0U
dniZhG2tj2_B=lJFJJE&mb:/>ioj@G.V*;D'DqHV.(gHE,1:-6ZjS3a-BXnG(Wb>,':n@X^L
CV,f&P8lL(dTdJhY75H*4?Rhb*6<SX@eK.t,1kqfPfos5\JZ&eu1"6QnE6bb7Sj*j?H*K8iX
#XV(OGGXOn%<)GKJcDgop^l)MA,QM/Oq!'_OKGFoYQ(pY7m_;Nn)ucL9?1oO"5a-q@r9&>r&
#4Br36E\S]ApD2!Z0*YtMh^;.X)29?NX.S(E,E88hrkRXaCQjkA#t_T?+ZD;)]AYE@L&N9^a&0
j3AB!gF%$DML&dTcZYBV/5I3Cllr87b@\<jMeeM=T3&mg1eho'UEi^2385cmoCpX]A2F2-(Zf
'KS_2AKXf.4*H/@V5/bZ%Q4]AF02TR;1\HHe7Nq[7eQ#pF$Cs?D"d$(K?eZ.pG`m'k2qiD/@l
s^G3e9#S.hofk8G\0jZSPi2;e^pG=<0IK.aYjF2I)Y\&.4.]AEm;$/]Ai#B5D+]A1-l0B(U&qQj
$&V*Y#?Og]A?e<;e3d*]AM]A&n,p^roBOk*VL^YEQ[Rg&U=G=F%jT*1ZO8Zkjo%g[DrQ=]A/TMR\
#U^@MFN4,Rn$:aOe"=4<Iq22VCs)0@\Eo-_O^4srF^8aigY^-lp#`Sti46lP<BT!V2J^RtrF
r_3,ZAMr:PQ=GX3D,q]ARk0.PJ\4E1lUO.%HC.Bk:8pAulXFHl-2<qsmeiGOGY;0njFMm/+Ph
]Acn(.At/a5,'ZTr4ku,/e^bcX*RD9]Adn0Q.lU,61dg%BMW1HrU_&Vb#I>8[]A06:4?7:j8op]A
2.g:JuMd5`YWZW!*F%2rcj4pIQ=/okG-J^OgP`jsU8>LA%`:sh9k4kDhM2c,P#>Qo682$Ei)
Ak7n&3_YombG_pFe`hXP4L/tfO&[#]A!!`##kn]A'lg?:t<C;lThL%YbpqEX=+^L*r#a5(\-]Ah
'k/t#`3PhZ=O9ac^EJ,.UtL3))E:%LFgmRI>7dqTUXR1PMWqT:nY`:^J4"k.b-1FIY;rCN8T
n+(:hi.^%sDt7rZViWWml*EbT5:]A(=W!oT[oCofW>"u*BDpIF?HTk_@*T;HjGXD`&05-6WGO
sMj\Z@T9*(KH]A%la^LWgnQJo$MSKD6I5*3q3i#@U@89c`?g=@l61"R.R^*,qUJG&+oU<5=<+
8\hl=[J&]Al9HbY[X"&Ssii=#dUPr!A4/BhIcO#lGoM%^'M?I.9d]A>-1^^I&]Aq`F+WiqbAG:b
MOf"A:5G:_fnn_9c^P]A@)=qUkAMi1<jVgtJ'7k8gI#>QU56^f`o)_,GlqWfC%O1cfsUh"GE?
\c:,'cDmeIER&.A<Yd@E`ic_,i0cJFaMQK/j7'jOKG5.i/-F7lKi"q&H"'PgC$+hITN*+,*/
R=:,Q^Uq6E$DZaV/V"UjBf4OKp\apP]A.s<1mZQ8DoHQ(*Aq*AeT<"Eq5_O,E/!J?"n2c`Iej
/d!lOrMd<'V*]A9*[G;3@bK>9Ll!>TKPmnrbVKbHfMhHmj2bcqBE%RN;qu[82kjV:uG[T1n,G
'7"75cp3Rk;a>gJu.uqQ$.8U"(k@*t;HH@b(TQ8!%!PmC3RJTZr__r+\h=V-4Ll5T!TUC/QR
#$`ZLGd:Fh6is@VqS"A9N;!m<cMjn]A14KucQLLNWC^0cH5#nJhRFBX-:9p4Cq^/,YrM,EE%\
S/lCkJ+\'.d]AL$XLJ,<9s,U#,bGSa>K3%LgUK>k,X^,1)35Cu-fa!DLshJJ#r$=27>WK6^p'
O"Xf@&1WbtiYV75`35:3DFS-[?%Yl/`W0BS5kLF.Pqt$H(dulUWr<$-BF-^no5,SWq&W,s]A]A
p_$H4ktJ.U\6h%mQ-5GI7BDgXOUgjk`(Dme+foG685R!s#JM8CKEX_fXX>=>Omr8?Bh.i$q\
"mO!aoW,AKC&>o&MLgO@28.cN_>Y-I^6ZMb^6"YM.g<p+SfK$0<.XT.,GCZk+fm5Du^5aWB,
nB;LRA7>8YGh((s#?n#VLq+WI4rJW3`7b#UloW<nN0-eaJ4mnE*b."Yi:@)jF^5AJ5MA4cIk
bF><+>Jnp_sAo]AEH4m/Xj`f:'7ON+5OLj5?6Up\FX(+DN'5>7Ou,h8Tttj(B-0:&ml;I/B^2
@=A7ROj]A.nF\d6"Vb[0!GB4mE8_*PQV!6$W^9J#oGY$IZ8[AO"99&24FA]AJ#m0C-D`V"fs/F
"(b0+&IuT(7D6cZsB"Y>9MX0pDXFo4gWI`->`daO*q1#^H&%o9C[-h+%a@SnLUR_:<o58Wu2
6c9^YV!VLb;O(n@*2AWk2W5iDP/mI#!R*@i8G-r7T&O6gU<1J$`-S)gU:^%/[HjTU$TOXo&I
u-u*8H@qjFC"$u723Bc$6[#SapQ*WrKukj%KOV..aB#:Z-[3aTK2JKr9t=sMs*L9E*CQkb%3
4O4$ROl+#GYV:Rs)5,Og<<&6%,tl;7PsZZOaLD8.iKrRTK=VnD@H/HY#0-QXc@K4bq(nHQVs
.F%d=qPP,#jLQNHWdfsV.PMu0GrcB]A.kfJ.MXr<]Ak6*C9)&/dFBRdZ7+;Plk&b^`c4M4)uJQ
()*1hdtsPDn<#'P!uN^*l2V1fEEdk6QV5pIIU-N,H`P*C$CYGtTrT<%4R"[KWRh)Ph^=:Ch/
ST`j%ElY$*1cf=#j%g>_]A`>L9m=fVt"@a.NaOY:(qkj1C"<=Y`/YHBBJ>]AqE]A8DF3`B:n0<7
b@mA?Er@-+VR#(M[s"A@7"2)<$k!l`noqfqSZqO4P3+gV+Y%T1&s0jLD^o:;#W`5BYXAk+B@
nPHl=+p$ZN_Q+)ORm+).</%>a>Y'C?ToMs[W.JO1daA[BLE;9#<\"t)u#.$Z3*aTPHUHL$;k
-;j[KfHU&$ZJa:PJ9Z@ATL^c!oa[e^7qKh7laH0g_VL7q,(/YPY"h!QH=GN5kd2).@TNgL(0
8B6Oaq.Mg0TSp"VV3_+AFtk88-F!"-&hQhE)dQU>[2IUU,Zm<N(VCGf+*EePl`Nko%@nHKE!
7SGk$%%oZ*mgOnM7^N::HVt9*$=Vb$^4Pm<B3FA8X)]AkTpO>J$^$0q!CD\>,>[cO42KJtPn9
g&R/+]Ae[$c;Y^kTNfT.L(HDL"DO"!;!2E,[b)^IISs2PLY<lVbZ5DKcmF]Am.YcQ,6o0>S.?]A
CfSdl$I2Mr*Sm:9H($1(3=38YBTm:Jmb83irn/D"-V+'<Fh;W%;!7:D1eF<u.MWA9Kpg%gEg
6Pd`b?P")GKu@PPnpTiGH^#XfoV8k$`Pl]AleIYiJ6C;iY_Hu2[3>^oMBPJB[O3c=O8*-4#Xc
Wu1F!4l6d(#N)Wc<.[Ikp)g'$l"1_#3i^_o<ru#L@0'W*2N4(oGK9,[YrpO0mtj7`IGGEBQj
)VfZ!r;RNEF-;(f_khQ5RnshE3M8s'9eGh6Qqb*nJ!(Ds)$mG'L:Qs'S9DF2PGq^Fbcc."i,
pkTg+S&;pO).F6&]A>6dU+t/r<DaV+<cgJY\i;:bF[iFr8(U='oI.*1b;dui1moADO[EEo6',
T6F2mZRR+1"<`0eC0fDAl2fE+%;;Q6HDjV^Y]AFC?q\GMT[c4\4;0i),YE:Be:G0<aX`--4RN
Z1"[_>T;'Z_ZkR7I0t6Y5no1t-Gs2T/"N\)K=&L_e%DZH"HXs_#D2j4$@qj?a.-Z75/0Yh7/
[Y^(Y<[f7=nmJIN4k!TXe3LD5_Bp8O86D$7$+Y98?5g!ID)b5VHZYIXCadLL!H_nGJ#Rs5rK
'4eABM>I*bl^:c&s=LVebQD0kYTDqG3h&l%\_rd=LW+ok#7Soq;O^n52g;2sf[^]Ag",ZnE/R
a#dWg(BTmY;otmV-%1,>l=X."?3!cHB+M6jO%M]AB2sti-X8,=ADcMK;'Uf`aL_*JCDV.KLco
jQV_&,RP"Vb&>h*R_bT34LB%EZGJ`fk3+Y-O+U1E+LS%nMe<ig\9DH4_YK[\;SLlm>"b/(d"
>;JB@<#R<O=^U%".T)p`G<*Aen+XJqeKgl[6BYP"WC(b;^D!/$jLLQlI&X"BhM>g4J*$$qC@
aTeJB[_:+6e?.PSeL;&'?^h0V))/4Aa@5VtgBWJ&nh5i6jsQ)kK\I-5/d/:q+TiJ8I2q<hi.
g>/?>p_opM;gEolg0.:!oqABoLmfJ&cSXtS<aZo0.BmrL:<"7Sc4<6ZkN1?=/f/7=u'_L*2<
LeCS`6NT(_CL^_XT/s]ALX=58-@!OAQJq72o[RRc@I9`%GUM\<FD7oSn=t73?nm5\8`f1#U]Am
,toRu+\r^^&Dd0$8pN>Zak5/u3$#>iOZ>e9.FFJlH__^]A#.HY@aVMg^)P6&u8<%E^2s$hd=s
TsHC_3>!M*/=&o<[o(HoOpu-:O%Fc47"FPg1kmY]AGL?b7*'0`Dp`a(/Hj"Q:\aN$B(^uJ"-5
nCAR*A"0cf</-/Y;E/1hpKBE25h<JkSOKaa.'UGSOS]A\MF*23i.4nYFtObC7*L)eGGL;^'qg
*q<@CFr;^jd1@nXoFl%4mT""skl2?@1DJOX"bM<QE]ANLJY\[7AGdsCXFl((hE?-4Q(V$7Y\b
m['aUO'-aKVsMVffn:,=D/+qOM4s$.BRVQ1n1?;Y&[LUiJ@Rt_!M:uj*Sc@0A6oWlJk#@f)]A
?]Ak(.IQp,NPDM#@Q'Le1E@Onc(5(*L=A':DS%0[:[+$UDB-.NE_q]AURhcM;DorBGWNgkh5C9
>5p(Q9PcWS@XDDanS$"kRH$E2FqFT]A)/(17"?jhk"]A*A>]Ac8,^rkDJ5\-8!5WI[+Q*nZ<4m"
.j+'$Uf&5%5K=@b(IA%;@lVQ]AcYPq?q"?`peiMGG[ke)<e:ke-\nf$,XoB.&S.+"JL2'S04>
3YR3dOaSUtUCEt>N08/0lOT3HiX_@or_&&JbrrUV!5f*G&I$$q4(ZF@!F=o2!ZL`*2*i$2Sn
.^1d;Ns=Z@IJnec_AkDCjJO@6kF3([4`fdS2$"GF3#1@j?@,,)5,jYp]A)AJPii]A\o3QqhSFQ
dO^hK(@AWk6<K-90ZOT?X#M?#s1UsjEf.Np.5!\>s;Ji.[\,Pk)).'@PX+BG$k01lPt.EmBM
";#+)0=_:$b^'LnQ$_\@eAUZ!bL5rDceRol'sm(nV^cV(iLIs*9G7E*q,$e#m^UYag,^?'\s
"f>Gi6J(bs)=:m[m.eGo8"ne!`AOTXT*<3]A9m_!\J/&p?4KC%R_*(KXl2Z>15Q\FQSf#,i<+
i6if\'O#:Ak&B#d$$C<GN%<X#\7Ug%^1&gt=HQ^c;=^1q]A8ILZNC-V2g4V&qg5ZZhnUVc]AtO
+>13<7PujV@\0GTkXs6fI*X'82?*o,FWNG/g,KT?Xu,\>#bX2<%58]A3<l;%=_b:",Z&=\Y8/
Cr(9e;i##K_6A$!H5$qc'%*fT&(X,84da@+BCpr;BS4YpKaVo9J&<BL_R@n';Oeh*k2Nn`YS
(4sO(Ij*s2)"b>MU.o+Q<#l_!KJ_nhf7("!RpI0Nd:%U[ZH@fngE.r?^DF!Z#Y)-E,B@E:GT
`5CnO69n#E?AEO?/tt(?,p5V*"RP9ZMZ-7a%uNZl36[&9mmJrI5mlJ<//'WAg\l21t+#QK(B
W/nO^!!'20W:rNrkqZ]AmO\h2E@T!(M/nd.(D;W`0_+$I%*J`?`=T[tYS^2Ju<GB'3eJ8&^.T
YWWNp<9346&mV)XanAa/rr;9FU'@KK=#'mh7dS:s3M6OAI<12$th3(CRlPT53Y03=K4H--MW
#Q9R%uMc/SnKUQcY6AS%CB@B9E7W\l,*e*WiF0(@tLs1I,caq7Ell2c3/bYs]A$3AjCCcVMJ[
iZ'XS9lrucA6Q-S4Q48)bX3(eSob4cg_`tWIE8G&qm$e"OHfTbG%<(p4@k*;2r>o[qTMDH:`
:n=(g]Ar8f*L;4VH0uhk'\D9Y5mcERHY^Wjs5Rm"uU1rF35cC&I]AK!UTfKUK8-T*d%jC#TS@:
de-:8$_[-=$4Ra0qLH^n!1cqI#X-jOVrN@$]A<fX@qkpYZkha@5`Xh>^MFg!ehc;1t7s7HLSA
nN"%Led25SW\:Vg,C>(%5K"K7\^K"8'T2:N)#D@XS0Z$W%Od9kl'si(*EYW#f:dl%XdR*IAm
%CA3j-4$`1]AB2*=NT5-kfCq'>^:MnTKas!H12@(>IB8D[KK\=06>!l<]A-Drgs&`p,^?H86G8
BiaTuWn_IqZ09Vn[Q;]A<I+F)o,QprS:MbN"Og<=G*,K]AMh>'nBm+3PQW>u81>T<*'F19m\ig
Yl($NW"ZcY==fN]AFk2`O]A@ZU2_o;^EI;O[m!Kn#l4/5CHGk)hn8\brrW~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="5" y="83" width="438" height="314"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.RadioGroup">
<WidgetName name="area1"/>
<WidgetID widgetID="e5932a73-bed8-4707-b36a-568231aa304e"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="radioGroup0" frozen="false"/>
<PrivilegeControl/>
<MobileStyle class="com.fr.form.ui.mobile.DefaultMobileStyle" isCustom="true" borderType="0" borderRadius="2.0" iconColor="-14701083">
<Background name="ColorBackground"/>
<FRFont name="SimSun" style="0" size="96"/>
</MobileStyle>
</WidgetAttr>
<allowBlank>
<![CDATA[false]]></allowBlank>
<fontSize>
<![CDATA[8]]></fontSize>
<Dictionary class="com.fr.data.impl.CustomDictionary">
<CustomDictAttr>
<Dict key="国内" value="国内"/>
<Dict key="国际" value="国际"/>
<Dict key="地区" value="地区"/>
</CustomDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[国内]]></O>
</widgetValue>
<MaxRowsMobileAttr maxShowRows="1"/>
</InnerWidget>
<BoundsAttr x="169" y="34" width="274" height="66"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report1_c_c"/>
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
<WidgetName name="report1_c_c"/>
<WidgetID widgetID="a74dc66f-60d3-489a-91d5-6a28f00d98d2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[往返低主舱利用率航段]]></O>
<FRFont name="微软雅黑" style="0" size="80"/>
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
<![CDATA[434880,576000,434880,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3600000,3456000,720000,2743200,2743200,2743200,864000,1440000,439200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="2" rs="3" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="  往返低主舱利用率航段"]]></Attributes>
</O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="0" s="1">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="移动端弹窗1">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[若某航段及其反向航段在本航季的主舱利用率均低于主舱利用率末位20%阈值，则为往返低主舱利用率航段]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="6.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="3" r="0" rs="3" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" cs="2" rs="3" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" rs="3" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="3">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="600" height="400"/>
<ReportletName showPI="true">
<![CDATA[/数字化平台/HZW/1_Dev/闲置舱位分析/往返低主舱利用率航段明细.frm]]></ReportletName>
<Attr>
<DialogAttr class="com.fr.js.ReportletHyperlinkDialogAttr">
<O>
<![CDATA[往返低主舱利用率航段明细]]></O>
<Location center="true"/>
</DialogAttr>
</Attr>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="8" r="0" rs="3" s="2">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="1" s="3">
<O t="Image">
<IM>
<![CDATA[!DN[%r/"6F7h#eD$31&+%7s)Y;?-[s3<0$Z3=#fh!!%rpK7s:*!u+<p5u`*!m96]A;e3FQt!e
J32^gSo6`0jpiBhZof/.,70l[OFP@JCKIQ$=8YM87VLagDX#-L<\#PA^(P[m-&JdU^,e^A$?
nm-K,/fpUMbNfF_b&qIQrmt"JA5.VBdKhd$8h]ALRu?C7S1.aO_g=aj*[i`h\)J)DXe[>k+_p
0'=Kg,QI"*RLfsiX=Bb-Br<W[L]AL$0M@Q$C3:WR#k<b]Af@g'`.0%#Cf7!karuXLRVL@>R>0X
tVN\9h$.%\fbOgL!LMk=!M]AEN;W\)"?;bi:Tsn\]A*Gbo:+N$F:KS_^$qZ0.m(a2`j";m0"AE
&%4&oi0+$V6JKb\QIVa1"%NdqP`jNY[T0GjNunccd3:uI&[W,t.i-LP7X]AUZ:c^.Lr[H$g5%
AjZRooI:9,qHm,.Y_K#r9#E4DrQ]A-R[4g5>j\PQZelHYD_D*;llG>$qBSrPXo!nK8A\/-\'s
=TIho[P5[Pim?^L&QKflTZl5+:7EY]AWBLu8HUqN+O?_DFIHO<o6pUh<Go6^_A4LfI7CS+NsW
VgIe%?9p<nsCrk\Vb%%+",BAK3d*8?t2XOh#=;<W4fslPK4ah7cO.oUF7%]A>6uYdkOl,m"[b
_a5A#K)-*Cr`BH\H@hJ7'Q0TYV2L4/B'6U.HaB<QL$,"-Ho@>+B5hMO-4!e[LLcm/<e0Z98k
_lF-N<B3%`pJRj'ib[EN._#T'6j@cQ6E?_(Z6rH[&DOWXK+K,91PtJ6=Fl6DY-SR7$T*8nE)
D1!X;$8]APZa*'Ul$cu.Sif3A2?3NXQoq60t\mqSp:FXg&cScFc=rSrO-[l;oifa(m0r9jt=%
<4kjTmZ*jiu1]At#M%iZo=)M)PY3HMrB'Bnu=0NjNd>EWjDDY?'aEmPC(Z8"gAOtf@G=ZP.lQ
$jUp2"%Mgd)jriMk'DAT:qi=01$p<qhMC:>`[@CXiQ==l1>)7O`q"A+VO#9MG(jd^>`V>/72
F5Ym?IQB);Yg50WRt:_S`uR?3LAN;m2%Uomj2gqs*l!!#SZ:.26O@"J~
]]></IM>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="移动端弹窗1">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[若某航段及其反向航段在本航季的主舱利用率均低于主舱利用率末位20%阈值，则为往返低主舱利用率航段]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="6.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<CellGUIAttr showAsDefault="true"/>
<CellPageAttr/>
<Expand/>
</C>
<C c="7" r="1" s="3">
<O t="Image">
<IM>
<![CDATA[!=]A,$rJ=?G7h#eD$31&+%7s)Y;?-[s*rl9@)[HWJ!!%[:<%e4O!Rs\/5u`*!^"+o/"#1Joi$
'Wc"VDOu7@h@c5sYVo'uAS>8K94ed(H/u]Apl*eKAbZ1\EKTlP='>/:_[/VE"JQ+,jJ2l*K!J
TTApsA6>M?]A!ft]AD\M&7&hPIKEV3/l13jV.(\4#(S.51AWaKSo%f:#]ASg6H\!fEL7B;:0pul
kp&77&.8s^jL`Y&$ai-KGZKHqS(j>)]AiID:\Cr\\2FDD"7SdDE5b[h`@)cYJEWX4r(Tf:@2o
db9ZkgR3#9#6*"Iaj:A6^&\I^!J_!'MR4T##e]A9`"M'%g,t4KN_%p<FhM_d':_4Xl_W_arlO
i"+]A#RHJkO_1I?-`O-=cImm)=)hhQ@<jBP\hXOGeO_FWu0VTk@=2qma(9Zq>^mfIr7jK+q))
d(e9C4P5K30pMj+$#uZ3r,*#;FQ'X43jY(ocgg$?$f2n^H_o/$OI_!%dX2IIN)JXMDV`_Oe_
ojel"i<a]Ag1YZHl_CiLsZYY<E=HlrE,M&b'%`jh;Vpa`-a7i@?QoJ0\"Bt"006IH%VBeJ[;Z
NB/H*7QRY4^<g0goVS^-]AmV+:A'TqR95"B>foRnEF-CDXhf;`ScZR*%h,Km`\69tJm`InALI
NY!!#SZ:.26O@"J~
]]></IM>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="600" height="400"/>
<ReportletName showPI="true">
<![CDATA[/数字化平台/HZW/1_Dev/闲置舱位分析/往返低主舱利用率航段明细.frm]]></ReportletName>
<Attr>
<DialogAttr class="com.fr.js.ReportletHyperlinkDialogAttr">
<O>
<![CDATA[往返低主舱利用率航段明细]]></O>
<Location center="true"/>
</DialogAttr>
</Attr>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="2" r="2" s="1">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="移动端弹窗1">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[若某航段及其反向航段在本航季的主舱利用率均低于主舱利用率末位20%阈值，则为往返低主舱利用率航段]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="6.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="7" r="2" s="1">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="600" height="400"/>
<ReportletName showPI="true">
<![CDATA[/数字化平台/HZW/1_Dev/闲置舱位分析/往返低主舱利用率航段明细.frm]]></ReportletName>
<Attr>
<DialogAttr class="com.fr.js.ReportletHyperlinkDialogAttr">
<O>
<![CDATA[往返低主舱利用率航段明细]]></O>
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
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9>!DP3:]ArS;u:.o$itgYKq6iZ^$Cu1T/*)/)&-*]Afl'u5e1INV,Jii7@%iW7?UY$RQB*Cd]A
HOi.l.n`=$]AQ?P`#9/MsQa##siilkGFT"F<e8KXn+YNJ,&hmQhPo6fC/V6rk?/9Fg:P1$SeD
HHB3/fE>e`6]AFPdi\@<_f>_[Nb(_2#Cjmr+E(RK!@++>nZBmSaO[TQ0*dK9a+FM7A(n]A>?aQ
S?8%l@7r>qCO:jEKcW+UO:hO8UpR0lK2Yrf%uk1GT>EcQ3)ORdp;ZMXf>Fk[c6F[mJRMt3Bo
mH27AlbjC6VMa*YEq9X7H#PV.##F-X:qOVJ!iKrPTnl/[4k%'pd$/@#-I<IIi?BsCga1]Ap=4
)Wf:_*HugJCe\CH3285-A5il[<PiZ*H0Pnfop$/;hlUF+4J&G$hJ;rbFot"Z/OsDImJ$)TJ$
O'2J334,7Jc0HON0+d]Ar:(b&9ABXKMca*<HA*:q%E5LJZ+';0`[k_.L1tU7ou\a6tU9b&F"R
lg4K_D!]AO:V#'!]A]A`E\Wfm!eQGkj1PLWTaLsJ6uA`<8(b[LtOoA[nO$Ig[AL$b70_6&[RmVV
DQufZ+@eI,""q<>3#ebAe?s2'sX,t7!#`X'hAPjhn#]AU2&C=[!pc(0,.F4pa]A;[;UKsG6Ca-
?d[c$gmX17F,@MeP0aa"9c)M*q<H'jg(-qrom-r2<uX5;W<l`W+oBd3c7M?c@)#gD3`.C>Qh
a9tj.@X?-Yrid>md?cijS=ZId7:&1>Vbse^79cKu(B?18fB+j=C6G[!N*obJOV0;mqd]A58!:
06Zo!9&Yl+?P)N?C`^j47dc7KL:d!5K*29p^k_1OMiLMfc)^)@bO_P#m=JC:`KWJ]AZf\o%'3
'Re-qQK)"Yp8XQFZ*Ld5P.b+3KTY^5JCu.$Wa+FW3j3CRuh%:WP9DBtPr4k)X%@GItWSaEsl
O";?cJI@-Qf3GFJ'F:k=k>;*(3H'i<W=;R-[/,Y!m;J^,8nPK-diNP;?LJ0+Qo:Qb`#ZG/;f
f8JGiP\h-^&Rg^hrt?+XASW(P/5?Qm"eY=M)C,TpM./MCL*X9P<2Lil5bULhG6_7ZQQj=f7B
?0P_A^a's6n9[a&.[DdkK[%h3.YZ&S^Z2a!!`c'"G$VQ9aeMG'c0]AjYK$i@V1(TFWMYqq'"^
dJQ.f%&c)+2,QCpuO>/RoM.f*u2'(:-Hm]A7GC@<gM>Re$qr8ma@J(q)<94m^u_Ura#>\jtdD
:Xoc)q`@rKK1[4$XH.VJ9dE=@9#Xh@Smt58*1Jm5h'/<D8:$"-[O'cVB,ptg7pY%@XR\l'()
=d3$N!t)6a)Q,t[8C=L_\#akpICi[`2u9nI)Mi$Ic5WAfUu`(f%U=ZW6?6P%8QYuAWb6mA!8
X<`+q.[5?"c1`H4_^nua"qeJ&R&PBCknMo\b:[WZh7cBP`G!N2+,n%g[]A;PK-)&st]AGo4o+8
?3Mt[Obd4:UG.#)Tg@kR)uSTP;D@rK)ors3X/de=#c+/]A_?@TRA.KqS/OtikCD38L;5MV*gG
lO;;]A.lmMEi8fc!<EW"`Y7fc$WC9QRYE.):rs]A1`kQnBbYV48q.$Wh]A6#IH=(m"Kg6+/+l]AJ
pR.%MRHf\kIJjIo"Dj$bfk7?uXB%CY2?2[W`p]AX79W\bF0kn@d2C`-h`-$(CKC19W*EWd62#
CirtftHNKpq2+fs%a*rrM4&&_WM<\iVp_GIhd#X^1Me!,VNBLU[]A\<:\1Ao>_OMFp)9-lMpC
4?VkD:&%kc"8U/<[g?0l\\"V'ipd<GMkTSlM_<QdtqE[6\8+b!OaY*@;%",.N,GreUb09<oM
%Q6jk@Xh"hRb'DRMSZ*NSNec9EQn]AUfhd51T]Aj#O\aEI2F6e!0$g@Q%>A5q9,j.P)dA@W9P7
BGgpmo\HRqA+?W1]A"BWp`TfSE8:Y1FVf/@Vt`2Q::WC-@X>VT6H_Xr;iX;#c5hu1m3Wk'0Kr
5;]Ai6P4-4ScD\U;'`)1L2C[RgUiqcL\`)7%`8AY>+:"X%&aMN(#)os1/<,?D7^&3#'aYa06Z
VIQcX8$;5hP_*F[JZ>lQBV'd()dk*TBhp1.`m@-"Ep$bkY3`W$DI]AU+SWFg4cKj"Y6#8^)e$
likf6Uo5.RP]A1.#fU@)Zu?k'eTE=H\T_]As8h?J>$&9=H2AYWgNW]A-Rt/5B3f?.*ueUf3362q
>q\:$8MQDh+fXIN[mm@G.$Z#WXXc4mM>[S7\4SeS$.IuLgj.9T%)\om&?h\@-"JLGIkE_M2'
r$((>7&-(NsLJC=9_jk5in&AgtQhS70hs]Ahc[$17:[le_;q2g?Z"JE4DqW:MP/[R)U9.)QL<
8]A<nsX`cp6an[i(b*8lfiE0]A?sb@SotcKL/7laC64h.h4U:JVAPMol36,I5P@Ag>9j9ajMY=
*%i5.*D(<a%i-\Qo<beF3Gt?nn6,-<(1Shp.&2@\Fq+F:noS@ijR$-$(&GP01Y0*WNHm6VeA
SEH7/Lk%Z/'kMBR7:=*[XHb_bC5@1G^BQ&EscYg="plrtgSf"HY;\ZE:u>(-J'W"bWk,,=j9
5U?=^TM/<s=L0?f0C3gRk"!)dG9/]AR73)2Z8Q'R['JE)mJ/JuR0mOH'd.VLYimSf?l;-ZPHP
IP]AkA+j/b/@$.C1;V"U/g?A7G4N+,6*10g2IdrHWcFbRO;X61K)`bA-&_6:TReQn4[>cb4JE
F?W^jt_$"s7du2rR1Lm.V,U`7:Q-s.s/!9gf;\A[?]A^-=CgVlr92d\i#H;QEmlF<;T/N&u(q
&G8Xh^G8?datM8D;j@=;#q[1hB(7e>LKu5,TQTQHpR6ME<X2JqoD6Qm)KO_/laacP#0lN0-X
(tKKE[_bnlPX61'AfEWu6.'L#WTak,9f_qdmF@tOK!a4IJW%3,.364g>Xe_dT3+ZZMBOt\T\
,-b"lZ;f[p3.3AG(FJW#>W!"&eoT,)r@HNX`0,LL#n'D"M<IWTh!;NQYZT^!!Kmg<^?4eUS`
9Yn^B(Uhn/t-ilJRB\]A2X#m2`%m#]A"4WEa]A1*-5*sIJC:LbKDj5@cIWp"-]A=]AhX<O5po_IsK
oZ[<V0mjNoS)9>(eMI#tandJs8,)B6o3M`%*gJI.^*<muUIWbfT@4FU'<;7G^)W:k7!QF#nM
Tln#hbHHClArRKcsC(!ZRFZ;RQE0Q?AtJ%hF.499q=0mX)sq!VSoT)101cjl+Eu=5kCMs>-r
SPPW&_D&PTNVIOpX\R#&p_['I1^o%pXEO<`j)_TqsT#'tV)3*lI%)NEgEA'BeLo0CmXh<0=@
=#dt8i&KprZulObi`77A/31Wm(EEM:UPoDffuPfkA8^qRiBBg\bILqY1cIoVlO#u*_Z%@B6-
\U_9Huq\pLYp:%'_<J!<#okV1f$qQj5h;RWY7!Up$iH#anlTP&KjFClgam(nTf7\QL(7"538
4U'-*Jg4JJ`99_%&(V0-njn/dnh[IQK]A+[qSl5IcCj(d)C4#Q3-(&,`:6jLJ@2JG(]Ao71)^8
l$0#Yjm1jY?m1,L1[srYIq%kBOS6"cr1O.W+?/E9Jj/]Ap;fChmRVQYq76^OBOh;q?Ml0^jf%
l<L_VB\a[ot^Le"57ebnnq.^mhXF6Cr7j&53LmoQ.Hq1otBk"Pl/1sLs]A_3(C&rT+NO%qab#
gf_46&00cWaY`^f$VKH@qtQ51/d?,RP.!U)4M6:jrcfoR*Bt8N63A;F9b]A"4ZKs_H84K)+fM
1@XjjkMI#lBJIC&L.JD;:f=]A".@uTb`0:>a12'?aC[YfVe,uQgGHq_\u)Del?`6g#ZqjJCHK
`Cr]AWX!+t-)1m$WW'Og/GUu;i-2%>%eLu4X`ck%9aHTh,Ag*edjpd'&Y,#;tNm3=?/.O@[8e
(Z('k,6c]A-km]ACoq\nmLe]AOP$:8.2m10@iI%>edT)[)&ap=Cl$P.J[%<X0be"+eJXlrbcAsZ
!VU"/a!/&cU38T3S,@dGO?2%a&dp%T-4E<Quq#G3sr/F,+Z5)`LKg%$l-qO>4XOE#PQb/q8(
q0:iL]At;_`kOft)Y,"<_F(JbLWdp.?W+UjmM&Iiq^B`.kaioO)I5*=g#ZD\XB3EIi1-3A11\
WhmXp:Zspo3t@WUE@Bc)6aV+5<ppboeOL]Ab6"JUQNe3@gs:`5n'\PR#0BE!oNs%?3+#r$OEl
=>#!jF_Bs@AUq$LAUt%?eR1@iN"u:&Pr6245MV-cVp,d/[pQf`'Mo&%)+<q_11\9@=g%mVMa
7^YK=Ke'm\)@,jE@!B@D^4fb?PVZsZ$I&k<M"o&7EtnY3hCMg">[knro%PN/Jch_4@WrYGQk
Cb-6d0^oreIKjCgjq9QZU86Up0`[UN/?YI<H1L%UR0Xe#h:l=4/MjKR"n0iesp6Y633$5mK>
E67)":ofBI4V1rqOSR%bNnl',7%jgkH^<i+I0s+7P.-IClct\"*Nh@!.pPhALgt+FmE\:=FE
9:a$BM*CVBW#ncR02O"<J.:n6.s\k9eVDGFj=@qGFRi]AU!"qVVTjT)Zn\`hOPg$<&j\e:%@p
Ka(C5P5mZ7gPt7`eYf,=f%9n:cRN!Lt@Q1kS6cK@^O`N?749X%b#mS7`lY1t92(?)bdI+tR'
/F.9_is8lCpO16)`@n@@56CtBDO!nZe(93f20jLc&#4'Lu"c\VPCi.(3R:qUX6[#3j!dS:3#
BtHk=l,P_G]A.-J@REc$&8?aiGi#BfdY$c4l89eiSL`@BmIn_-jT<NqgJS0:bq"@pBlpWk.X;
Hidpuc%ui)CRVC&kg5/.Na@&F%#r.C)FHU=hW'd/p9`^eUdp"\gN^t?nQoj0YWGTu3&S^Q#2
7TrD#p>L7+"i\B"K_uI]AjJ4e's(EVLpj7#=J\<d/"W@Fnd/bOnp;LWa_Bsd&\[P!bW)9!5(,
/*J^EH"p/Orf3(`F._&<7NF'4sHg^;&\!9u6ot3:g1=,!:UN1=j3@hO<0(pbeqIg]A_lo+7`@
$Q[(ZtS4UHOi4d.t\9F*h!(\3)ZusEnF7\#gdkc>&@bj[B<M">$^aS90f[=4(QBap`gLu+*\
1B+d9W,2c_?/\Lq]A($R[cN]AfW#1_iCki?Os=@Fk2/tdP+'#JqeCNl#tV)?;E&cjO*+3rSt^K
!&TlS:I3q3B)2QgI:mfs*1\II'F)-_#:D[^9.u'50N]Aptns.9VQ-ZVs]AE1F#qgQ&U.P7Xp(n
ML6I:(Gc:=2VM_eGa!b4/HS17Z!5"'$(KiF3nr+JX@FY3a63_uNECNDbC@$[lEf:#@_5oF,B
3;41TnQ\%NY[I+X(/O-t-G`'+?S:GijqZgH>ainnj&S!c>AVBU4W9i)TMuu.D6/r)Y6^S=J6
*;SQE.qsJY'luZdq-`)XPD:WZgE&BNOoZq<GOIP'uE9::q13Apd+kSa^\_^HeSBr0+n3(?l#
%sE[t?k<q=f8W4qN)eJU,&09?)qEW1[fkU]Aq\$#,7Ja!0I\dfk\ejEa,aGQ"QB1f5RZO>oBH
&J!UKg)/TO)oE:,md3J^.Qi9FGsS86DA34)O#I$(."B:iph-o.F,&S``I&*k]A"4f!5s&c_;u
"([VF_bjdoX)UKGIkn-6.VlPUYPIX!WNcHV*Uo>U;[L1b@^m/J_d-ck1q/S5mL3fp6nr>_U)
`XAbSM`=7YprrRrscnfnp"#.%*6Cno#rUfkpOKZ9;ed?9Z]A0mO`CG1dp4)#RaDUU60??D11r
jOU5A1JRq:OP=/=?,XqdGsFrJ5H<)KIaADdWhtsFGbPjW-@D*kVImj@)r3h^.+=^.ich\$*t
BBb`$c(,[o#$iK7WRXfb6VF1Cctb(]A(<]A/m;9L'*rp_Yd_>8N9:WFk>+rek/'aa@SiZS2Tj3
C<I"9qF&;)@BJ:iOoTACgjgc`?a)QI[gtM2)7a_O\$EVV*Zil8P&SKcST:r@V;3#dEJG@@8j
XP]A5FCY&<`s(f'8L4n_dW69GAJgrTqj7ZnC]ACrO7!lSbaA[PHOBpLo2EakO8.OTZW/gSk[qt
1k7C\=$\.k[JQm]AE,6+K9P239I"gs8S(5/@*GPLYh;\7(3Do/$D>:_UYT]AAHkS@PMjk;6g%%
M#?r[?-">-cjL+\$t.Z9!8;T8R5d'f5BbrZ]AG@RT\,)d*qU?L@hCMVpa;g6L"HpPW3oj;5MT
71kY'j$]ANB.J`bcUr?PIW=+-(dNAOLj2o,GskHe<L%k]A^Ic4RSU@V[63V*"B'tkC,8/qcD'*
iZGr=m`4LO0ja&?P\>&sY^U<AZO4qeBc/=%+IZ-Ja\<6NXZl=W)b^Pt).DR>fN/k^%Qg7sap
XJgQb.-9LfUOgT:@Oe-0$i)Fe'7]A4#==k-g^_9.t!<?KASi8$'6t1_P+_$$gR4LO/!'b1@jV
G-LRGh;LSna>H'0jBc%Xa@(Q1GU)>_P"eO4aK)q#(&!iLBBQG]A*6\7%O$u]A,`QA55GVQ'1rV
tu^4E/nXLG9,F*nD*5Nikbo#,GEIu:Z"tDO+B!T$%]A=/2u8<3q2$Lu5+K?KfE\:mr/3U1K_'
)Z#aWk&Nl"Rs$01;WE%iI]AkV]ARHps@tjcK3b)ZkZ.3I1AD>UGioQ-.SeEJ:l\-)GM\V?NH&u
CotXBj-GJFobD0L%Q30mXL(,^s82:<b3J\TFZJJg?npK4QsnRQ2CcR[DN3AtEQV`l8Ko(<!9
\$0frE`X4mb(]A(i:;6=S9\Vrq85AaNT))E^M>hjoni&F]AM5J9RqlJ5?&1L,?Vt:2rSVkrt<d
lTW\I29ZVrG+mfc=lAN7n:1uMAPMf`o^A%=!Z6O/,L-d7j$A)h4Df8D)g%eYnhdP$J_S;>=#
\Llc3U%j(h/NGWq7VLSl):[6<WZnV""%7"EK)XH%aNn%s8R8h9DInIII95VGTSKASr]AKJj(g
l36[a1b,/dSTLVn7S^"u^hd+IPB]A&2G9B#S=ffHd#qInG4(A&h=r@)j/ak"4BXfWetid"NVG
jOX;?-0.fpp7d9AA^%08i=rUVr6eALN,tksp_$q!GFBq+^98Y5j,a\h\A%2mQ>%ul1ads+)+
*6+1B*TA39r7o@bc5Tk%(OA`e!,p@dA_B8PSO0S5";5KWZZ9)/mu#g:c"%glpGDTsqYh\I@f
9,PW7tnYaM4'N22D]A<V41cB15G_d0G)IVQ5=-8.f_BR?E;.S10^J(3:DgjSJe^h22Ci_.)=c
K]AO%#Z9,rXpNd0V0'(**u=dtF$dOJA'ph'YI\Sb`V*PDEs0=o'YB,&o/^l1dYO!XZ.6a#GWH
YY8JR[qVBS,F>2h/U=W6G#NCW+Uk"IR,R.O,;m6bd[s1Rqf@BKpElt9C$5I]A=Da>h`9X/r2&
nXd$^:<;eV4A6A7c$K0UBuhe9@V=`7ID[>.`9!P(80"rTGdpPi7T!$lO,tLX.@s,kY&-XEr+
he[+lJ+H-:C"VrA1:WD(0D:W%e>lPFH.7hJPCh!>H1@a_)_j,.#<)bC?Z_Ug7&^i>pU)IMc8
Z;*gXr[@H_(j67c:nf.Vafl%u"_=V0!;3&Xup5&kt\Y"0\"A3s<iD6=.!Kd@*0PC$3,(ks?,
9DI8ge8"?S12F;TpF_'2/edn)Y`T9QupmBqiJG`Den"NSh<QbLq$>??<FR*@?M)_aVl7\?Ul
NGJ`%Rk]A`C>k&ijH>_0]AqV_h;ATI'+;9iPF^6=K1OiSX]A;'Y1_4>8/6VEl&E4TPGt+^rmaaK
&68G:O2I+Gc_\Z]A1*=s/.-`Vp54R%,NKFJn\]AnmMM0G&mDs2Bfnp*/SQ,)Nk.-b1::Z3Y]A=H
mOOLA96$==rl'"J=F<F_JggZV3D)YV.U&%Z'`o:<PX,hMe'%!;8\D1-m1;r]A%Q=5G?$8[-F/
ZaJ9:_-<Y/u?RVich/AOkrC8tq-&AL&:.UApT+Fu*LX\\#oCeF.(AFT*$rr^eS+/5'k[<qSD
;9b)S^R;&`]AEHd^Rjc@6db[H1++!^d5>!0jd*TF!QUU3SL?q3Y5_2^,euC(ca_A%;6bcO(=[
YlZuiIb`FcRIj74@.1\b@+)DXr;kC,mkZ-<lI9m5R]AX3CDs3+Dsql_"t%jDR[/%S8;CKXd(L
e/5"b@#6<\;YbVHi,;\VVODkV3Q-]As^Ufc&o;$O`mjd'?+uPTB0GLI>60MTm%kGNb8UBMc1`
:s%m[rRK83Fj0qNcLPIgS2#XOf+mU:"OlG;-60B>)F,`G_Ft7ai?:$h='><k_frL6pNuV`I,
+I6+/>.As[I:9f0XX:H<p"V`u:BO+Uh*!@c,YmYr:@XbOR9ZTo6.F(:A7]AT@CjCfleeb"X`r
fH-C4=tF:P\-D$EWWob'Z*/upAg?XN*DX@%pjZQ'[Y?:F[C++,PXpcgl"5L1n496*%O\'kI'
XRW"dqqnCMX%&NfTYWcQI.0fQ!2%XR@?4Ztq/80i)V6gj=Sf4aTo7o;^1*<G9m2FS9r2HMPG
#`"%@X_(1FIl;gXJc-J7.:Xn/ZGX]AeNE2og@bZP+s1iq(0aSu54[CL]A3`'BO+c!AC@**$Hkf
6F`O>"j[3^]AnV^qMM&!uS\b^bnK2G!QL^i^Q8n*35;3k\5]AfVeT]AXW6lj+dBaf=Z,D\a?g:0
BO+K)5o2=sbLC"'[=0LI2@.u8la)pQAeEkKtA1(:N5Z&M;F)=JMW,lg#7+jfEp3_Ut["[SL,
&RT,:=$E69m4>0bpMPO"pOA5[VndC[r3i<B]A(jcHNG.a3<Z4eL3tV7!_pC.>D,J<$>ob]ACnT
t6ZhCDR#jBS>@MfO.hj&HqoIZ"Y.g`kAbgFW$[caCi7kOo9E%p57,_^@;>e9o*hbt4Q:l,4"
dV/+>178,C)qGb9?oW(Y_aoR@6a+sNlc2U<4$8pW5H;M0W.P1/dftE_MYhBQP//7FoaNHfV.
[G;,fd5?l<D:,E1WS6(b^Qo]A>(kcpQI/eg*CY)"+)c`?(7(.HB&Jug'@0h0#oRmpK@p#?(h!
i(qTcG]A\"qr`X>Rf`=@CG6.uKt7>0R9r6)T;<VF;NS`W4AiNV:oa#_;`'&4s?e0$-CB/hNU!
krntC&_r<&m0%[3$0K@(sOu]AnU#)Zge+*$kVC]AJhNn\d9+Db#Eu4fmj7hVZ\/8;&'`/i=cD@
^fChDTmNQ,1HA_b[4Oi*TK[(E+COlO9O,n=.l^.:XWotF=+eV-Tj5^2&O>UHQ6Tdc=C:U/VW
D!DusS?]An;ZJ(@]AqXn282"2r<&n+n@0=]A3kB=:$j1bGNsRO@8afNrDR=8'LGd6L2@UR]Ai$J[
N&3osuPTf5)-kT7eFq93;G2nI*E-D,nYK=E[p+PY&b<;]AXU=XFiKoeYg3g2*fBDNB6nYXc7l
_#uJmJ-*SaW@[g?3be>Q&iu"@]AkifB=_Hm$&i*^H-N'0]ANLA:*Ji!]A$ZF(S3GK,)aiOUr/F.
K/6kU>eUFXNr5$oG7=L4q*AdA,;gmg)g^"S<5_a*'J_NRq/kC">rdLW+'VBe>>[C$Y,)(j;>
l`Q3W8B!]A".C9@sn<Gk;j5qPC2_"=qImI5,Hu)`jAB]A^oB=(qe!"5Z<UgjlNL&<g^YM(%j,0
Ag%%/"@hZtNH*eeWa1:dB3eJZ?JN:i;$j.9NRil.VVsbopdD4m6rcp#c$Cltr>bNqZ3s'J+-
9loU6&K6H\Ir#4s[;!8K4BC1IH'"ofG0^N:r.t!@pB9^Q^0+<S:TA9i%;YT.l"fH#Zd&XBsY
^13R^`ML8:/Id,00GbuL[ha(L+39FVW0*9WX$QSh^l#+eWDR#`q'oma1Ce;=j\QNg5?KiU"`
g=Q>a>+TYon(;+c[$/G"e"Hn,V@1Zn-Ib(7j3sWVt0kMD2iB/2h.4Vik9-!*$3ep7J\\EW*F
_c5WdE./TQG/-VpL^8DkHk?pX%12kRIFX1d)>@sgG8=%n6h!Tm7mTg\.r_#ncZANgXEP[Ed&
qk3Do6m<!;FM7(C0dIX8Qed_10Y-$:iJCrcg^*`L$^g^63/=T7IKj_Od8ZqU,0ha%h)r*D!F
,mMfg(l;f]AMq@5j16]A4h+=ORj8>9,.mC;HPE>FgTq)tXIHt73U*Q*'@lWG*QTtJTs[FG@*AU
@)XZC;J81gS/WC#`KH[V8[!\'tSqPNL:P73@I>JIsP_QhKj<S4ECG@]Aurd&H/c(Xg_&W&2_o
_f;U#MOruY>j\\pcH.)j,]A:#51[,MpU7t1G*H_?&JttmM`0O1[EUT5f0oH4O_?uQoSMj6[s7
#,IQ?(qk?+NJO9cg)D+jAA[7/.&FS$M#DkC2MFaB\HVC6jUTb%=h?49Ar(^_=MLSGd&UcMB#
,k>l*AW@.5duZ!6HZV8p?Tak%_hi:Li8-98+;jb9:fKo9,S86Y+[.4"#kOpu2?9MeE:T:&%\
jF,n&%-n5<(BeOSqB~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="4" vertical="4" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
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
<WidgetName name="report1"/>
<WidgetID widgetID="a74dc66f-60d3-489a-91d5-6a28f00d98d2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[往返低主舱利用率航段]]></O>
<FRFont name="微软雅黑" style="0" size="80"/>
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
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="7" s="0">
<O>
<![CDATA[往返低主舱利用率航段]]></O>
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
<FRFont name="微软雅黑" style="0" size="80"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[j^!4<;cfQ7gJ@-1R6nBp'rN8?@qoY2Q\pA/8343%FAV3qVa\`Q[T6<pLk$BdYHb6AAl1?)CE
a:QZ)f\r-!JfK"O]AmgC4KNa(a2-k`"9g2+UR4TPO+:_=V?nS!t@eFr<$7e3VV<M^;'.*qg4k
.k;P=G4Scq%:FoVPi5mp,oD7nl/9hT0@)8U6s6J^dT?%nXCDJIomWmjc?iQgm@\doG,>E=QR
*;.4J+&5j3<L3qI!/oZ2YOO;s*!e/W8BhKB)/?s1pf`KKgqoWY5"=]A6IkeU9AV#h%B7N-IoR
9`EW=Iciei:hko!-5n)r8ARCl.[!'0BS#GL9&eoJ6_J[G\ZF,[D+W+FV@S5W"M<N=@79Zno#
cQ-h"0b1)8Pn**H\q1-dp6'"[8E"e`!erbmXk[;+bk1Mr)($T:Xru9gX<I#gjHbr+AT[m)"0
U\,Yh=:=O`5"Qs"*P/E\R1CUkY6]AK#4+eY2_E\U?WU'\USl(4+`OR)%TbQEEsKLIDU-^WMK)
kTe:Ot+L)jBb]AYVE,Cr4!^I)O=qSmY_B@TKE<cd*r&mcCK4fIr.U_&ibMbZmXlT.ek\]Ae/_7
tHA9=:!GP#c0J%>*USdS5m&Q\Jmi$/)#cs[6-!#k<^nhS6[YbP'?g_A@JEF?*IS80VjZa^=0
tjmWj`>fj,4T*cjED')>,s$q_ec7TLD@<Pi#$(,"-Vo>:R.^YtI[q9<:[UaD2lk5PnE;r.H!
(Y;0>LQEl3j2Y0cSVsVcP'8c\H:o0=3T":G`_XP.:9A=Pf1M5QD]AO+]AI!;X%T\Rpo'<=+oM(
:R''cb=W'qF.n)u:lF0++8R/\=/j'@171O*A@XLc<6`02uMELMNrb/<hG[_lZ"J.+g@i]AbJ4
/#$Lj&`mm5/S5)KXHfQa-5B6g.<OVI[iV`ak-mM6#KD)Z>faTB4)M<^V>h@UUbVKru4#`JZ^
1?lCQu+Ql&inrE.CNkRLOr#Cc6eWQq<+cp'?EQ:kBQ=7W`l!hk-3fK!lOMe:oB9c$&=XW-#t
5R+o/8\mN'Le$a)VCgE1mbE/QtDAGCn@'Q:L`jEIhd7aFEfT"FjcnJDKc.k._NSuU\Mi[.;2
3Vt2-4?e/+^[nddDj9b4aQ]Aj89@2hp$proj$+m:5k;A2rH0H3%TWhEo")/6_[M<Y:E,PJP:*
RBVaQ7F)+ng5BbnrgLXa5b=*E9kHSoshEZR3B/]Ad(Xs,tlq[Nh1dpn^8Gm%GXBiE*CA.GQ2u
LjNr.,15osM734a,FrJ3o&I9Gl<IC1pKZ/]AY<7oi7\GTV+CP^5+@,mim%#<o/gTMc]A?6+)!J
V>=qo_rW7Z"$j)Dl/EL&_+n*8qt:I`!pLA2j)W$M8.tWgEA&snEl!!l8o%oEp/r"Q9>u&PYl
\INHjafqC8S0Zs_sq$qm%#3<"(F7j"4.\=#pa)@Y'Kc9E#)c`s_>efA;%B#k;.T#!!ReFk$b
rJjT^4iU.Hm.lY]AmcHG2LfL"emVr>q+m2s#pnpt\;E9^p%GYlQb<dqZ>n;oo+JhF(U/D!_*6
VP%Df$f6iYYI3HuO$.nim@\,V)k8V"JAhI^.>sGOge`rmD<tO&&oETLYoF3[!Z1jAYoO#8+R
-,,js9lb4dm3g#M![WcJ"%_.C6;e49m1(9YTD\i0Q`aCcd0t]Akc%\T0`SY4_*H6O@Ve+?pDP
3F0]A@NW=A2_'bEM\odbcmbgd_Mn[]A%u599P3@UC<hdBY73'^RjuSrG`AA5OaO+@W7IQT'1u!
slFLBV9QA3:?VT,G&SBU@*<t(BJ70']ARSmQtTb.AoS)9(q&aeH*Q?>sUuChO+Qh5Arb,<92G
rdG=$09#N3j>?mZADdXa#aAsFg\KIZbS4P%L2KrOl1Jh78q@)!aHq,@cVZ+E,!j45f_.(dUI
(\V5UOl^_p.-E=>ME>P`+c!@0(.4b:t1i'LOF,gD#QNpi\dkL_UsD#s2XLLuHt&qc4MLhU0m
JT/c%\Ssi329.<M`\&W*mnU#ZpX;_YBZfP7X=TWCH1S`@o"fn#XNm64=Vr,uB.'SUdNab\A,
M$mV<KS;V0'eJ;adSP>G'W>`1bIn/'L8IPKN2#P]AJ*"lo8e.\3aV6X0CCP2>WtM=:H9(-$7X
$</8&0HJVS4Z1P(GQ>tS@cWKu86f>5JDX#_i%Qd4:Ub,?o\-\WmY&73GP%s"n+4ud"Ci5ZEJ
8mK-UU^J,R1(^D&+7]Ac(2Nb4h5`>Q)VnqkhYtRWok#482Gs`@Q/2`,g`;0^kIRskc*>;_NW>
0iRC+)]A"m_9Goe]A$p`$qZr-,]A'\3W0*B"F;30AV*=#)D,L</fr_C(3$s9ed6<r\AmH4U;e^Z
b(`]A>DrMtQ_R,G86_F:!N'Y'^AB_0EAHAL$aC6/c\A,C*I2$`#!Tobo%-J-fSoM?\n<;SLIE
!e8A(0:gl<I9F/P5Wqk>Y!SmaQZ:X/\2G1FH#bHT8QC_JdUP:jdM$is!T=."U/LW!oKah()#
]Aa2b1E#]A.-;^6Gg#Q(,F_jKkHM)Cc_r#p_P=m1M$IDS97f;#oBXr+mlD3FH"`,V@Z41f#-6;
>8.W;`@9TCg_u3(m#<ppNP<m,U/`ec2",o)i]A-(Pc#IpE_"#(mKmhRV$s,gTI)F8FS$B=,H$
-55>E#o?3adZHi=[FhrQS`_Om%>'<B,tqn9P9[9;<EoHsDqsVk/NC@X)9Z`t>nRp%!!Ji>/@
<(),XTjfODX=^5`):Z5sPU06n>A#!47*KC_.D@Kiu8cGt]AhG*bU[e-q@5^aqH,S\nOjBR8pe
gPb3Q;23F6]A>A!'H=(S7D^:SO!M"('T4?__CELhDk:Gn=DBa$R478i?_H[jTu$O7=d?dIF^T
#jHBmGCEk$9N/+<[.C/$UiCT4udM8Ad3n?DJ[gNXX=g/,)W2_!Z@ZT/C8L(V4f,8)XTQ3\**
2tNCF!n#YbVj+5A1:hn#/A!Kq/dNWgCX3R-ASoBKETUR>SX,`rNt=9C)A[D30hM=Z*<Z25-;
)IOCUiYP%Je#h)GU(/9nd2Cq.pSYK?XFW>uJdNLrmFgNtOEV$bgkVh"E.i*CJ#b9]A;K?=BZb
b0]Ar-BL&@t'A1(fT."+'Z,<_@jJjK(u([/(Ero+E;lu1u^M,6f?H1eHa!G>?ApW&2Q1Us:!+
sH>sC[R#c*6kiBjcV*kWUkX&M/Lf,(Xc6r>`/.%RL0RfqL3/D*#R4AXSV'2S!XHM[^%Sb\D=
%7^MOYXaEb5/I3<QErcPL;+Er6Rbbg!a<SU$@"YeVE$,:`gB/L4'Z*TjJ6"lsOiKY0"'."c=
WJ)N_Pb$kF0qA!_<9`/roNWZ_X5NpfRG_1OIZ_.G!Q4S>#<Nth7tTsb5*+#eWg\W5&>PsMn@
).o=icGn2")J+^?7CY(?]A>9K,a^9W$e+,oU)m?bL+Zhp?XmDnCUHj)^[S>qGpni&uA*tIVdH
1PEGteM[%</iDif),nq"PC"q?`k@8J&'Z/Bl&#c>kCnDV9&G/J^AM;-V(lni_-8S^OVHc>C6
Km:.fL=P]A$U#iL;`?Rcq#7aj3Y^6cP(7L=;BobHNlukiY;^A\,0r:.FkCo`/YJj-d.Q29kD>
R%R>87#lloj7\*!@<!UPtE9=\$a\j]AQLJ/h6:9le3CHc'BYW2;LJn=%W0O$Vn)P<P7`NUd'4
rV^uOrV7A0/o9OeKOU)JO5E>$elKEP\BA%[gP)s@8gLoPJVqG<PdCm`Af#_t;A;;A."(.8I"
j-o4DZBcaIUM]A'NkJ/8=h=W4<0Is460>6(b#P%\7(cE;2YnN+Q_uCgS4_RFN,7>:m&'BHe*:
GH_l0C=2nHJKuT<ik0trA>TKSGoR4@1jO;B+n5C`6\`'d^*ujcbBW0g+^A\'Id2l)dJ]A0>:X
-NjX8FOMVi^/:80^.S$*rTa1a\%9BH5"7agtj5mf-q7-_:b4B?PU)<aj;<-R]A$"f?Fq/4=5u
c.<hPGo\4G;TPZp4GhEi[/gg2jd82"ddL$l77N&EKW9T#r."[:F=bi#]A[0u\91'k2&!4@_uL
4o6@d[phn2c\\2QDpA@X*bc5idMn<60X\K_:^t:hLa0XD9\?fiAQ$"FH/[52M+bbI%5-)Qb6
d`pDL=mg2IXrTkdk]A(iV,7Nr1Ve36ef1irjqVt"p7lo1ulGdXq'cQG`TCXcYP-9*f$r<I(e6
*b/VuN$Mfd.bC)Ks46lGjcfq"20:3cjjdAeFN+-Jh/+)j,.-57rs17fP)tS@fX7^"E!S:&sH
9=Mh"-_-If4IOn(POW5b'b.8RE:G`4Z]A^i(S\@.pEq+;_s4*]A4EIQP/>O-DNTV.c+Ek]A&$Gb
TZEI%PopG/Vq[eJ!gQIY^Sa/oQ9g@[J%LCIF;BkfHK"f=6'qX,@hA.o]A/M6K]A*EXUM^HTi'+
Ai$kE!f^F74[3j'$nhhS&oM>F;l0b^4$__&b*)^S[_c\Bf6=eO$%o&hdI%,H4H#kVcs##%bF
Q^XIQn2q6LUIH+Ea0.]Asl=OL`-[NDI1qXX'Xa7!^1I4Xm1WLIRMKT47"3MnH"m@oQPFs?f[/
A(omn7`^8/%B%Ou@]AKkZP<V(XDgiBLC/`rY(I[u#u%]AII=WJBc9.!F-H>6?E0oEXIIIb3_B1
Hh[@DrQ,)@Z0P;0AK\DlZ=F]A5lA_UP"`B(NFsmc9N*JIZ2_@gWgi[+N(`30-BlUM8cG?f^;D
_sUGQ.;hk1;hqj!(mM57)CVS*_D+Frkhc?OPY^I;?;!,/2i('B`un/[Sdb]At:%p(pc+j54.+
@BmHJK_ka8*`)ofh?Ep33r(jXf!cWkbM9Rf`(,9j\R78km8Rd08Ab#Ej4\QYp_Q-P)^Z1`&f
RSAQ]A2(#gfd^T=;eVNgdJaa+s3IiD@dA/cQPhFVCAm2Bfku@.\@@RYJaN_8aN!d+9e/[R`/Z
C4&oc,jh301ODGcGq2t@d"5;t-8b;kc:`g#@Y%tE-7<!EAC3X]A9#7tXM=cCjd=+Ggb@JdA&/
C;Ie\<Of38e:>@lBtI3etNe4a$4;*SOK'p@CYWCROJQTL$`Md:HhV)2FadK;0LO7:`%?LiRZ
UZpuD6n`S@:^-;`7fH:W%M?V;jY)\!u5oq0961hJO?i\!7.=Y$;BLKLgqb2b&&MTUY?Hurlb
*ksD!ka0(>S$4\?Fo[a/I8j4:GpR*,oti^_@Xs9c9X,sGlK.4-]Aqco)0Gm>I(*\=k\[oJb^V
c1WJFl5Xh^2ca"l%;!]AtT>sH5e;Q[dsj:"?i?[ekk@dY66XGKq-8A/HaD?Lgd3EU+bi?USuJ
pPjS4l&H2dsk5Ub\+nZ+IBt:c$Xnbm<EolK7>tEuphqncuD6V;.AK.nJBcGDi[6i`+_tbkH^
c+bEj4j7*8YDl6)MlPn#1D"1,+k<QEHN=u&UY?_c@ZN+e:n6f^d(\I`&k96J5Rbh^AH%8JMQ
-Z+[m\1>n@"/e=Ab]A)+d)IFE=mXaWOX\J3*--NgUXlB+Z'lV$pfJHC=\9-@cEH.;jPM=T2DX
>P\+713d279WnCAW$och0<iM`71;b&Y+&6/"q(PQ.D8.j.qV&fZe@XZhFl,[ps<#SHXZ6?X%
=EWpO(.;\5X0Wj6ONKDGcDVk\IU>Qp76X^o9_$#c=Ms9>"k\=c3d\BTsJjfe=_3m?q)b,SR,
@l./]AfS!el@r.<>MV:7etIQVP.fJBQ[c=+fXdA=?3j,JIig;X$U5+ZO1\OorVhQuB8;Xfb0#
)/tQH)eu2[PlqNRE,5tQS=K#S3a3T7u01sEr]AAFWb+#F0FZ<nY9/Y@$nINlnsDud0ko^MM-I
VL$rDg8%_hJio_$8[--*YtBcg6.hCM_\OM_G5%m=0u(hNdh?<SSJZ$2btiZim#$4i[_DE&]AO
(o083c!p10LHo8([]AmHs;MIR?G>Ufd:4'#q$dYSEQCqkZ'QS8`V&lQt>:dIpHrfYBb]A83A91
AfH-HfaAoM4K?qB&?@,!U!?g?'O>9dk>l^o=.&4i`Qg9VPIkT.dhe6C+5oj<lZI(9t4/\K]A.
Kr%;^bFal^NFZ8RNKpQha]A*;==Ah"+5!k.!d:B3r=-&#hOAAe7/l<\ILr*-Lk"e=u>m^-0oe
FN[_+>+0J.Tt$:nt"nl/JB2YZ>3E_o"\;+Xis;K;,N/!^%dsN@<*@$#20hjbR4ji!0UDYUpI
UV&4AQn4V]AX&%\PVJ[/R1p>7,DIdCsPZoPm(Lf=QM(`'.+6kJVYugVRhK:u;PV>1/r)-aZuV
K,@%L8=3#9ecXGgSTfWbO#0LEUrDPlT:]A2o-WekOjIoo*)LRd2@t,KG4.i2uFqCD;%=:M#2l
B$i)#N(SV*B7d(M,MLnpP.Wg5l3sr_I9<F#Od\.pr7T,k@k=S%)gRE;Dje;5^7udu;oHe:jR
X?HerB0+65VDePe&dOk\Gm2Q[C>7P+&gX5W(#.rGKE?jU0qb,+o-!H-9fH7OF7^3uP.,$qF+
qd&l&.O_;5b07J>S%.>U65]AP&+Y%=5ufs+!Lge:!\P4G9q!mg_IK`MR33,7"CW-B($Z)O-Mo
0Wr'hr2U*[qR]A?#,?$U6ntpAgZ[&&>BjT.j?P3dQoR"kD6?"K[#V!&AIUKsJ>#1=l-+4@<5S
F'caU^?ZI%c)j,o'!"hX%T2*GIsT[SKj63S_#J_Un@6XU?LImk"JS(Jq?D9\J^`dY\%33;re
a4B*6o!k8,OhA8&&.&HtKr;j:OP3j^25<-=/eYY<hQmPo7S&53dsBE)>THk.p[M(pb*<>mCB
$$u1gU'K#&mq495aVdVC@V9%]A]A%.qut]AaW.Ao*iLMVfXR(8.ImY4q#gR9(mKYr1n2th6,*p\
q8.!W%/3(Y!!o:.@CSMonL=tL&A\jq98Ga[gR,m2+TdH2=t?WP3*K,6Y*pMed*t5IdB<F"'\
El*1eu2_fM?@Mo9S>4P-9un`EudGUY'iS./XZ+SR@`mH)#Qhd2C00H**P_)!hhDK>Wh9rWl5
U)1#U!K't-S7_7UjG^5@5/[[rC9>qE+>0-`hJ>>80WML_]A*$!a&s4l!doR#5F(2p[MeYMh4@
]A8PC+u%H'UO*,aUl+>Y+0$O"IcL0iO/g6p^P4,[1*1]Al/E`LC:`>O&@2:4L_nB"0q$K<=%R$
jNjSV-.CN"+CcsE7AJRY#rZj/9%(?;V<qX/Bm'*-kI0]Aho6!fhu2W)alF">XlmaqtOa77&^&
AF.!aBC*f:fgf[q5d"US8.<=Bk,L?_]Akd3`nL/2ONV.mA)'D&RFCG+`cK:"Rp81*2#glNkrW
Fb/g3qr3QO,R86!i5as;[N(u.@J9iWX6?TaBSE,!oAL^Od9\K-JBC!WjeZIAQ]AB/VUI1h@bG
m_4"tEUS'_&AW/?/#C4F7n(9EoU?7aO[::Cb^*P<mh/\L$hC7:5^7`9"o0\V>aM+)o)25u16
(eS=Z1+S"b7[J2.G'LORO\9b.l_T6V1DBRdK\@iX3TU:>'4hhT^t*'=UL+/*'h52e>=5Xk_u
:X?@PGBA=]A%*rqW/=mL6m:*,u^*cY3l()Q3bT"LGUg"GR%17qHWdq.lH_.oYc@B\_'90WKJ)
mG/.3V360S:[R4%Pckfn;Nj?odkd]Aq0@+7^RH3>ZJTf/J5d+Yr9ekXM"3t']Ab''d$_'M&_fl
VZ&o`(LZ$j!)[#dR%&U$T)4+%(_.dpZEIq&Bs[bEWF&k+F(V;kU<8D$GiJ"OI\22p15Plu2m
FHROqf3.09#,4FD*2%@JbD<.eTXqhRH_EtY7NY^%lp!50"+`BMFTE1l]A<IaA"k'cb$P^,,q'
EBJaUV<YHe_4)E^hr\U(>ggMYN^,!!(<SpJ%h754Gj6E7R6=4VX&"-FcSY2!(mY/>Pd$VTJ>
YZOGoEKa4bm^B<\J&Je`;]A&o;6fhKY7$/:XAP66<SA3_.X-r7j(%2XerkgQP[PmYDs<-4o#\
)*d,p+R,%N40.jW:EY.E.6@''6?UQ4psFKqf,_(7SH/&UdRd)Is/-S^'d!:(Xb/t#?WHWG=-
!BCg_qS>'9HQW?#i!7'+UP>bY'Aq)AkhQA4N3S^rTL@<`\_>f3=DJ8mMqEB#,9Z5t:QM5/0r
]A*LlVfHVgm!7TPD[iM.:W`p=Jd8pqT%$E+sNl?C2qYhWuCL?,7*S]AN9.g;*XMPJG)F]AV(uRZ
*e&3+Hu]A68A8ed(]Ai9,:7;C1"-NZ';ahPMn.(kI\0Pm?aJ9?DrU.6`Pg%)L]AYVlnJNFoe,fe
1^<5ffBhn.fdpY$W?.)Np0q70!#H'C%K<[:!#rI=PlPr>,%b>":Y)Mh;CbP+^Z1pdH!&#_IS
R2XAKA%J1EM^%.UB+b,Vbh)RT/ouNpp;@/+]AlCUFJAuIO4]Ad]AJ30=i`oR(>^V"S.2VC&C;Zn
`4`E5Xs,Qa(7AgR<n"/"Ol1kD8Q5e4NjHtB6l\!#o$P#5@`Ecn[bi#%9_B[S.%L32#PEKAVK
<$:qV_D?N,V[\Ogjhp:g:ZVGBT_&m.V)8?c)DCg[E*<Z_]AD2Hcl1!&i>+HO5Z#j>5Ntm1U':
?_fEtlc\W9*bm%!C'?&P[Ys+SP>QOR`L95Qm/a06(p9nn9?^K'`433]A-"4X$C4;Dkp<FNHp<
J?hNIhDT8]Ai1UhZO?kpb1?KMG4p+)8qU!U6#[EV$r%SrIQJi$9>a+*?B+S=)&W70IU]A9j!m,
+:b^P]Aq]A/30]AI)C:i%u.c`OQd9rDLYj7OE$F0bX#02Iu]A;kDo=HI-"(7h[><j4dB3J\b=H[G
aY6ScmiFAfGGT,e?iGKhWr-FVF,")?8eO5YjG$H(d8I$.D6k6BHf3p^Gl?=MN8F+GS)B-O#`
p"sc#RI,b4!D?;g&;suh]A4Qb3J.R1u4&ql?3uX^2NStD_Z,VW>6eCL,gf0AcbHW2U3PS(iRl
fUG+MZc8\*<RS[9Gik*r~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="450" height="34"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
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
<WidgetID widgetID="ea0a0929-309c-4fa6-8084-3c6c086f2399"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-658188" borderRadius="10" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
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
<![CDATA[723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList/>
<ReportAttrSet>
<ReportSettings headerHeight="0" footerHeight="0">
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
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
<WidgetName name="report2"/>
<WidgetID widgetID="ea0a0929-309c-4fa6-8084-3c6c086f2399"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-658188" borderRadius="10" type="0" borderStyle="0"/>
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
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
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
<BoundsAttr x="0" y="0" width="450" height="414"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report2"/>
<Widget widgetName="area1"/>
<Widget widgetName="report3_c_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="610" width="375" height="345"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="指标卡"/>
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
<WidgetName name="指标卡"/>
<WidgetID widgetID="a27d4a00-9d7a-43ab-b5ca-4b080cd59105"/>
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
<![CDATA[694080,694080,694080,694080,694080,694080,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[288000,1270080,2880000,694080,1152000,72000,72000,982080,3600000,694080,720000,72000,72000,694080,3888000,694080,720000,288000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" rs="3" s="0">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="0" rs="3" s="1">
<O>
<![CDATA[载运率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="2">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="货量定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[载运率：出港货物净重/标准业载(由短机型及航段为国内or国际决定）。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="4" r="0" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" rs="3" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="0" rs="3" s="6">
<O>
<![CDATA[主舱利用率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="0" s="7">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="件量定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[主舱利用率=主舱载货板箱量/主舱总舱位量。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="10" r="0" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="0" rs="3" s="9">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="0" rs="3" s="10">
<O>
<![CDATA[主舱利用率\\n末位20%阈值]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="0" s="11">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="吨公里定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[主舱利用率末位20% ：将范围内航班的主舱利用率由低到高排序，排在20%分位的主舱利用率。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="16" r="0" s="12">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="0" r="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="13">
<O t="Image">
<IM>
<![CDATA[!DN[%r/"6F7h#eD$31&+%7s)Y;?-[s3<0$Z3=#fh!!%rpK7s:*!u+<p5u`*!m96]A;e3FQt!e
J32^gSo6`0jpiBhZof/.,70l[OFP@JCKIQ$=8YM87VLagDX#-L<\#PA^(P[m-&JdU^,e^A$?
nm-K,/fpUMbNfF_b&qIQrmt"JA5.VBdKhd$8h]ALRu?C7S1.aO_g=aj*[i`h\)J)DXe[>k+_p
0'=Kg,QI"*RLfsiX=Bb-Br<W[L]AL$0M@Q$C3:WR#k<b]Af@g'`.0%#Cf7!karuXLRVL@>R>0X
tVN\9h$.%\fbOgL!LMk=!M]AEN;W\)"?;bi:Tsn\]A*Gbo:+N$F:KS_^$qZ0.m(a2`j";m0"AE
&%4&oi0+$V6JKb\QIVa1"%NdqP`jNY[T0GjNunccd3:uI&[W,t.i-LP7X]AUZ:c^.Lr[H$g5%
AjZRooI:9,qHm,.Y_K#r9#E4DrQ]A-R[4g5>j\PQZelHYD_D*;llG>$qBSrPXo!nK8A\/-\'s
=TIho[P5[Pim?^L&QKflTZl5+:7EY]AWBLu8HUqN+O?_DFIHO<o6pUh<Go6^_A4LfI7CS+NsW
VgIe%?9p<nsCrk\Vb%%+",BAK3d*8?t2XOh#=;<W4fslPK4ah7cO.oUF7%]A>6uYdkOl,m"[b
_a5A#K)-*Cr`BH\H@hJ7'Q0TYV2L4/B'6U.HaB<QL$,"-Ho@>+B5hMO-4!e[LLcm/<e0Z98k
_lF-N<B3%`pJRj'ib[EN._#T'6j@cQ6E?_(Z6rH[&DOWXK+K,91PtJ6=Fl6DY-SR7$T*8nE)
D1!X;$8]APZa*'Ul$cu.Sif3A2?3NXQoq60t\mqSp:FXg&cScFc=rSrO-[l;oifa(m0r9jt=%
<4kjTmZ*jiu1]At#M%iZo=)M)PY3HMrB'Bnu=0NjNd>EWjDDY?'aEmPC(Z8"gAOtf@G=ZP.lQ
$jUp2"%Mgd)jriMk'DAT:qi=01$p<qhMC:>`[@CXiQ==l1>)7O`q"A+VO#9MG(jd^>`V>/72
F5Ym?IQB);Yg50WRt:_S`uR?3LAN;m2%Uomj2gqs*l!!#SZ:.26O@"J~
]]></IM>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="货量定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[载运率：出港货物净重/标准业载(由短机型及航段为国内or国际决定）。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<CellGUIAttr showAsDefault="true"/>
<CellPageAttr/>
<Expand/>
</C>
<C c="4" r="1" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="1" s="14">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="1" s="15">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="1" s="16">
<O t="Image">
<IM>
<![CDATA[!DN[%r/"6F7h#eD$31&+%7s)Y;?-[s3<0$Z3=#fh!!%rpK7s:*!u+<p5u`*!m96]A;e3FQt!e
J32^gSo6`0jpiBhZof/.,70l[OFP@JCKIQ$=8YM87VLagDX#-L<\#PA^(P[m-&JdU^,e^A$?
nm-K,/fpUMbNfF_b&qIQrmt"JA5.VBdKhd$8h]ALRu?C7S1.aO_g=aj*[i`h\)J)DXe[>k+_p
0'=Kg,QI"*RLfsiX=Bb-Br<W[L]AL$0M@Q$C3:WR#k<b]Af@g'`.0%#Cf7!karuXLRVL@>R>0X
tVN\9h$.%\fbOgL!LMk=!M]AEN;W\)"?;bi:Tsn\]A*Gbo:+N$F:KS_^$qZ0.m(a2`j";m0"AE
&%4&oi0+$V6JKb\QIVa1"%NdqP`jNY[T0GjNunccd3:uI&[W,t.i-LP7X]AUZ:c^.Lr[H$g5%
AjZRooI:9,qHm,.Y_K#r9#E4DrQ]A-R[4g5>j\PQZelHYD_D*;llG>$qBSrPXo!nK8A\/-\'s
=TIho[P5[Pim?^L&QKflTZl5+:7EY]AWBLu8HUqN+O?_DFIHO<o6pUh<Go6^_A4LfI7CS+NsW
VgIe%?9p<nsCrk\Vb%%+",BAK3d*8?t2XOh#=;<W4fslPK4ah7cO.oUF7%]A>6uYdkOl,m"[b
_a5A#K)-*Cr`BH\H@hJ7'Q0TYV2L4/B'6U.HaB<QL$,"-Ho@>+B5hMO-4!e[LLcm/<e0Z98k
_lF-N<B3%`pJRj'ib[EN._#T'6j@cQ6E?_(Z6rH[&DOWXK+K,91PtJ6=Fl6DY-SR7$T*8nE)
D1!X;$8]APZa*'Ul$cu.Sif3A2?3NXQoq60t\mqSp:FXg&cScFc=rSrO-[l;oifa(m0r9jt=%
<4kjTmZ*jiu1]At#M%iZo=)M)PY3HMrB'Bnu=0NjNd>EWjDDY?'aEmPC(Z8"gAOtf@G=ZP.lQ
$jUp2"%Mgd)jriMk'DAT:qi=01$p<qhMC:>`[@CXiQ==l1>)7O`q"A+VO#9MG(jd^>`V>/72
F5Ym?IQB);Yg50WRt:_S`uR?3LAN;m2%Uomj2gqs*l!!#SZ:.26O@"J~
]]></IM>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="件量定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[主舱利用率=主舱载货板箱量/主舱总舱位量。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="10" r="1" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="1" s="17">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="1" s="15">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="1" s="18">
<O t="Image">
<IM>
<![CDATA[!DN[%r/"6F7h#eD$31&+%7s)Y;?-[s3<0$Z3=#fh!!%rpK7s:*!u+<p5u`*!m96]A;e3FQt!e
J32^gSo6`0jpiBhZof/.,70l[OFP@JCKIQ$=8YM87VLagDX#-L<\#PA^(P[m-&JdU^,e^A$?
nm-K,/fpUMbNfF_b&qIQrmt"JA5.VBdKhd$8h]ALRu?C7S1.aO_g=aj*[i`h\)J)DXe[>k+_p
0'=Kg,QI"*RLfsiX=Bb-Br<W[L]AL$0M@Q$C3:WR#k<b]Af@g'`.0%#Cf7!karuXLRVL@>R>0X
tVN\9h$.%\fbOgL!LMk=!M]AEN;W\)"?;bi:Tsn\]A*Gbo:+N$F:KS_^$qZ0.m(a2`j";m0"AE
&%4&oi0+$V6JKb\QIVa1"%NdqP`jNY[T0GjNunccd3:uI&[W,t.i-LP7X]AUZ:c^.Lr[H$g5%
AjZRooI:9,qHm,.Y_K#r9#E4DrQ]A-R[4g5>j\PQZelHYD_D*;llG>$qBSrPXo!nK8A\/-\'s
=TIho[P5[Pim?^L&QKflTZl5+:7EY]AWBLu8HUqN+O?_DFIHO<o6pUh<Go6^_A4LfI7CS+NsW
VgIe%?9p<nsCrk\Vb%%+",BAK3d*8?t2XOh#=;<W4fslPK4ah7cO.oUF7%]A>6uYdkOl,m"[b
_a5A#K)-*Cr`BH\H@hJ7'Q0TYV2L4/B'6U.HaB<QL$,"-Ho@>+B5hMO-4!e[LLcm/<e0Z98k
_lF-N<B3%`pJRj'ib[EN._#T'6j@cQ6E?_(Z6rH[&DOWXK+K,91PtJ6=Fl6DY-SR7$T*8nE)
D1!X;$8]APZa*'Ul$cu.Sif3A2?3NXQoq60t\mqSp:FXg&cScFc=rSrO-[l;oifa(m0r9jt=%
<4kjTmZ*jiu1]At#M%iZo=)M)PY3HMrB'Bnu=0NjNd>EWjDDY?'aEmPC(Z8"gAOtf@G=ZP.lQ
$jUp2"%Mgd)jriMk'DAT:qi=01$p<qhMC:>`[@CXiQ==l1>)7O`q"A+VO#9MG(jd^>`V>/72
F5Ym?IQB);Yg50WRt:_S`uR?3LAN;m2%Uomj2gqs*l!!#SZ:.26O@"J~
]]></IM>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="吨公里定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[主舱利用率末位20% ：将范围内航班的主舱利用率由低到高排序，排在20%分位的主舱利用率。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="16" r="1" s="12">
<PrivilegeControl/>
<Expand/>
</C>
<C c="17" r="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="2">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="货量定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[载运率：出港货物净重/标准业载(由短机型及航段为国内or国际决定）。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="4" r="2" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="2" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="2" s="7">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="件量定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[主舱利用率=主舱载货板箱量/主舱总舱位量。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="10" r="2" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="2" s="11">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="吨公里定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[主舱利用率末位20% ：将范围内航班的主舱利用率由低到高排序，排在20%分位的主舱利用率。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="16" r="2" s="12">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="3" cs="4" rs="2" s="19">
<O t="DSColumn">
<Attributes dsName="指标卡" columnName="载运率"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="0" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="7" r="3" cs="4" rs="2" s="20">
<O t="DSColumn">
<Attributes dsName="指标卡" columnName="主舱利用率"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="13" r="3" cs="4" rs="2" s="21">
<O t="DSColumn">
<Attributes dsName="指标卡" columnName="主舱利用率末位20%"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="1" r="5" s="22">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="true" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="5" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5" s="22">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="5" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="5" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="5" s="23">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="5" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="5" s="23">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="5" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="16" r="5" s="12">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
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
<FRFont name="微软雅黑" style="0" size="112"/>
<Background name="ColorBackground" color="-133122"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="104"/>
<Background name="ColorBackground" color="-133122"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-133122"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-133122"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="104"/>
<Background name="ColorBackground" color="-920577"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="104"/>
<Background name="ColorBackground" color="-920577"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-920577"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-920577"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="104"/>
<Background name="ColorBackground" color="-723465"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96"/>
<Background name="ColorBackground" color="-723465"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-723465"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-723465"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-133122"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-920577"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-723465"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="144" foreground="-11642267"/>
<Background name="ColorBackground" color="-133122"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="144" foreground="-11642267"/>
<Background name="ColorBackground" color="-920577"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="144" foreground="-11642267"/>
<Background name="ColorBackground" color="-723465"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96"/>
<Background name="ColorBackground" color="-133122"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96"/>
<Background name="ColorBackground" color="-920577"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<f.@P@sX(!<Eo\ejVtPDQ>2(JODrd?7<1TU,!@=Ll*rU$nJ*I7O<qe)@$liPp.Fq1.+ST)F
O]A2AB7;pJ;aIO#UEs[hdG3Be\iQoVdJ3Is7OOb9A@,Jo/u1rj$*2t-YL3#gGjMDnYfm6L5k'
&C#/Jk_fR$=L1qTfcisDAkHK7'LCME^h7RXuNki^G)Q.O?ea43\4Jm#I`O_K:Mk`)3hqb_Ok
00`/.r+C:>hZh+Q?=4DDibsM0^lC?E8L3jQGdL8SIH?0^NP(Odtd&Hj)!m`5"4u7gkn;"kAn
?^pLPjafR9%.;S=&O;@dmoah_!G)'m6<g%SgD0omg;]A]AbnJ,M3j4]AW8-[7p\TO*KE:SYbdV1
Xkc"X]A:%f6Q3N_]Aj(j8Y_DH<uKA]A:]A?&]A^f*OIuu9#9VPJJ9d^AbHKaTbJIUh1-VW+YoG;Xk
+`coiY.S:R#q5!<fuLQJG>C23t2YdG('>Zrq,7r9BT@i\r';TP+m\DX/AcSI:#5p:Ap`Kn#_
>YR7"MI`lE=!MoG:;nm@#ZDe809@P9-h"fbmbgmUF"7h>R?t\N2b_Ih)XJPM>ZPTAHa,S@$V
TfJ9AO9eEYc&5MI9X6!q#nce'f9dJfl>7qO,o%Frqs@>(n[>&`PcLJKNAM(B,k:^Nr&.tK8Y
`;-%[i$gV</B@$=u#SeEJ%mX`5t/BfHN\+T6U#Mr5"/N8i17i)]AcR"+Rs;qW7U+;FHpe\BZ]A
EgKi":[<[4YOS0`(@o.D>;!PJg6.Y4U*=C0?1)7T%)f%:\L7)P0+4_"jsAMX3_SU%0=#,sdr
J)f='o7>L/GYDL'5a'ECJJ<00d-U\eVPglEcXTkHXu^i07/,MUTG.l-I)Y8UePT[`Dc@o3,"
tNr`n"kDh(+5B9"'0[hX'@[f$MT>m$FlQ;L0#-gCKBS4>/j?20YDCYI%6>A]AbC]A`"iQBqC(i
K1c8C7@k8?+aQZ+1k8k9L):Ra1uVL`nX[;RG9X#WH'j8NlhjI?.NIjn7,^1F+V%I&t(qqF;k
7-I5iG%h*+%h#(\As#8t^\2t%8f<d;'l\P-@uqD]A"8C!PD<=3&+Ngi8NdM7=b-GV;4Sf<0o5
UENWm6fR[oe7#DsK(OJ5#cp!"5&pY3Er?;be2mKC$b5si+"r/:oj6Lu]AJ""M/[=i,Hg,q0nT
rO#?Iru]A>'ARE5!IrgI3S:p"$U.3P^aphZR0U_\.Z`>Pt59BPLI=:oAAnO8ag-6%4K*jSN##
0Gt?_8q4,X6a8<>XmU3iD'p[.(_:rh@MqBR/^XUY/\N1'S_gPXY5sB)HG3Q:/R;K,-SU#Dgq
i93K5C%O.rJTL@hZ8'bH1kl,M#ZfX[`EDD8G`'UnC]A)s.t_s!'btsXC?i(8q"iu]A]A3qsfM(;
(_N<qBG2Z&iQrM$b#HL:&&;t'6:-h\]A'&CdN]AZ1kV-rlF=SdsDGlak1r+EEbmt8kO*W/D`.n
a!@$rS,n;0[MXoq(^V?6DD)$uAbH^<dl(\hBD4`#hD7tKS+cJ+SGCCClot+OpA0$PP_7i9[n
C@G[:KKB>*<Xedj7SX>#Fi/a#UC-nND^*?l/1HSAi'-ldDntc8!4nWSYGfDu1e-:4X_*WP"'
(Qsf41*-!cjO7c+53D\KCUJ'smrTpj"\=As&.s6]AVUEJZf"TH&r2($)0Bp7JtpedeB"'.R18
,)fkH[Q2E>s'2R_#%9LR3\[O?Y#]Ak]Ar,`fh<B'ZCXn&)"f#th%\Lc.7'8f2kDI:V`!2TMdM'
;hU)i7aY79sA^Q@cclbS_-2!iE?7lqn:j1Nekd2fR&Y.?0FO9%C$V%)`RV5Z-BL[>t0>U.96
F:Z#33^01HCeK!J,o[fKjk+,`7]A#i1mYA3W<9A"`e^`=+h]At/=OQ@c';:B7"+!9O6,mWd&VY
=J*N++B[@9<$bIXJ\"&ocG#'mG+!i\KsN0!8h6Y[/dRb';S*C\`I!TYL<1Wuu;KWt4[!0maN
aD<G'i6]Ah1;Z'tc)1rOk9n%MLE[ElfF]AE<>'o^qLtD,ag#OWB2Y4W2e^AmMpC9C-F?/4;'U=
mQ"2$Nc7NBX@1dLL\BMH"#B?$qpI]A[c'-ch<?EEgDEs/%;"KknUg;GpOWt0GgjBHosPT14uA
<`f0&b+DKnPqE"aKFj^47%:MVV3i95UUr6%u@#MNKZ^ZCiT+A'/U]AZPu_S-+J"dH,pm6.W1R
Q#6Ws4.4`0>nOU`m'6#KRbH3l/p-N!8au0oq0+!7II%$U+r<,ip%fX*EQa!;f\QU+ob3/9ad
h\Y!k`.ti/1n""`=cqRl:11,ekC@N\8]Aepd0JJ:T92obPLZ/L\+u1P.J&6r__ak":+?SD3h"
',>dCs@^"gVK9B;$E*.c#h(8\6/d6b&"<_m(=V1>i,#gH)mZA')i<eWH+SJA\S,(K@"g*H=T
86(-L[(6i"h5]A':eu&q)9CX6!JYo0!:bWomGU3sE<HVRf1oTq=<Fe_d3$=`(je#5I(UiSGM4
T)>M@qVaq89g823H^deX;[XME8"YOfl08KfiFA2U6d#lI&>@B.l_`70L5^(lIh0N@6HN/WP,
gP>M[PZ1'2GNCrT5"7$5!p.#u$1t3WC`B@T-`-)fKg&<FrM.P%Tg"aELqkJQB;Z.7]Ar4C\4n
\IuN"!u+2*lgRC)(AM_A$i&iRGmq+&k6&#T3\:S?'o7,rek9[;W&k3/rIXdtI*Xq]A0;f`]A;k
XeiSF#*VL3'(%uJ1OtOH./n_8]AeC[bb;D]A2^%(==!ghBhtlf:#!An:u]Am<0:,,V<`_V8\<tj
_Kk`SQL<sI"<a.jS]AF;IjYe/o&HUSe/7qDO:n>Ja4ndlr^sZeN85pl9)OiK;r_YPY1.bRAD8
"l$cj@"oKjBX'@39VEc:!\+2#S>,o*o9[?KU>ZLt[E`HTfP@^N:\KrD`PGjMutRZ#=P?2^*Z
1%4-U*@f]A.DrB(GKGR4-[N6$seo,m`J&fTKEB03:>gahWE?/r+CUiaa'YAg7:Kn,SnaI1!C@
5+WMKMj3"hujPm^p%uVX=>T5&RPo<V,AD.[hF1'f+,W!UcD_bW.SfpTbo-O,.*7_l'Lkkhed
(nUB4>_:UZ.O"5ElXK`)f"EG;R]Aq23IBC!^H_=C$sP/>C+JRDNFOIY7a+b"o3\AEsVj_/e,'
%7[d<3#trl8"1.C_ib8*H[/&i0a:iMG%Ykk]AR/8:2?69\cUkT'h/da6t4(`(+.UV#Kf;:h[5
FEY/"2b.4>3KVXrok41`AU4%$[-]Ao6]AdU[PY=bj79Am._/(lICfWC^bDtNi\gu-eZOg%g/EY
j&`J9[0mk(S(h.km\O.R)auLZeIpA?D3^U"%MfBs<81]A792T\(HM]AF8O7@#r5If'CZCoWdNB
(AL'aYJ:=V[8MXu[Yj&PYdU'RB6Ro+Va[?)pe*`bel7+:iP+0V$5)#iE;9:DKVlcWL@Qc/^V
J'VX3R7t`O1U%<U4H!INt!T9Wp!9j?ta+L"Q?(!&C6kIs:hV0#kV3Kko't!M+0`2V?c:?N'K
OiO7mlB.`fl9j4H[RA4d>dj9@qO@a)UbDIb35gfd[6=Zo$%(l$\U8IAF!n7?#e_q,=f\XE0M
(L&>K/ERB3`$Lq"m[Z]ASRLBmF+6i@8<i8,0GZPIkk$N]A?ADfG6e"D`dmRdjI6S5Y0)-_+/ZB
8Zs:"8\cD8T\H!T-P&F1WH[$W%>ApJ:3pIC;!?Ju&iP,9BNi)2M!G+FL47V''*?q6\=S@)cG
[-<hSa56X>Y[;CU6WLA-H8OUdGZJLXbq]A!;fS,FIf=%crY47!ks>J5"rq'#4*'p=$m^`T*uE
rSJOPe*KE+ZU_@IU'P4s3;VWi8*_1qhRtPtM'e2t^.A5\4*r,5GqTB5FHts\c)j0>r9sMk^p
k[&fJ;sSj8?4hdV_uqLWlnoi[ML;[;NZhDJhHRCa;nR5c";Ecdc&&mWh\UaFkS6'WhY:gEhG
*(J'%Vi9lOBXHt[neKqcUsb9Rp_X"Mh[dpi,i9150V-d%*F'>h9g+7B3tj`[aB2'[IjmMt$k
'+*k0kgi?JH$=oB`2n,Xef*Fk;b_@`S/#b(gZ\3C6u>Fr[Y#>g^bMs@-X6Go2?2g`)JoDeT1
+(9,p=qp3YumpiEE=;;,8cp'5bkUCS(rp*!lYtR(-a"flELcOWI@a0/oDQP*0bl6O`<VS_#/
_;B%T<6/6mX!pO:PFegU&\,AeLO^:ul8V\$`+^6ct:*A.tqAjQ4@1#cH6A-n41R5_nq]AQ%$p
9(bZ(pf>--<6Qd?i:a`GcO"R2QPh,4jQ"IT)U"!oGP[f4B@Tjmo"6M'aSOWNrQ1.7F<a#2$.
7UP&"Y(NDPQ+B#7]Amh59po$[i:(GL!0d9RN"Vk/JQIheBe5ioZF>U!!iZ9gqbH8f>7T,YELd
jDKjomo(5@[mOU&%5*''fghYlAo*#'6%35-6jXghmD&t#&,*cBNQIM,L7"<I!YB`1*t;5]AVq
j,P(t.n@ZV[>]A_IoY\I'>LZ2T4f_+_AI^]A[`TYpc'g/<ZE_KKCRDBHe61f>&d`.UCUDd[T'`
``G_[B$iLs]A/NAnl6T@/Cao$6IT]At*<Sa0?J9@blVfWr5s3H4P4dO9pi=)`je>HC*Ej-CTY)
@]AiN)Y<#Iife<Vp3JFNht2jcI<QAL?\#eOd45aj(>c?^PgiI&4>]A?1X-ZDk4h0TqjLCt>_ED
T'1N+jZ/K-.c<q'\5qMg@:glC&6M?-tZ0HI0\K8V_r\7hX7&3<N`N7feQO3.Zr`p>JHVn^9o
KAXn"OU/)3d,U#9=1Co&=,BT\+,d7q>@Ej-9YG^;:8cg/&`O'b1%q^TWN[jl>U"Y.2*"AFP&
)M`p3OHX&<bW9:PE$"HDM0eM*/G)6O-DM'L#?C`-Z_nPBi!0-TR0>Zuk-+eg$KN?q?"u.tkV
MR[Q2JVSg7hp),GC?@+hF%_(1>gu#6A"u#2'T-K*s#"fTu\5^2$:6Cmpq^A83e-JL052(u(3
(GD^9'<K4OYd\;k>8TJqcY]A0VCl@[f#\=K!G?abSd.S8Q=2,o6C%X]A!GqT6*NA8p+mWDFk-n
5&cc@(BF,]AU:0%3h%gq+3u;PskTno@N[]ATk.J;;Jjf-ou>f9TLPr0'11L#U$?V'YKZ0iKHu9
_Z:#oC(/<K-tA048&2LO'YM4$ee)K-dVmh9>hS1t%Jueso?K(iS4O#K3d+XE.am1=[:\DO@>
+l@JXTjCYrH6.!>%s0ZrgEN:>JP&Ho$&4Sprb7P>JbO]A5K!K08AqT%7C^,>)[l%g/+M:m&$K
h$6pNkZr25QDl_q"=Po;I<EojjA0,BjlHN;eVuRVRa3SUn<CWoP@]Ab?b8C[(qXqo-?%Ae<an
JfV16<R^MfH)!2M;0%rlo9T0*oi]AskU:tN/L$o72"OGp+\@A%q/O?Xct4>f@g0BSK3.I-Cbk
W$?ESFAXj&mW=_%Um/YndKcHDPSr+N.Uo(t=\.B6lpZ&roDKRg+gAP:Ce'FQh+cp&#G,)]AA!
T\(@)h+/@NlcD$)0WJ[jT]AgnIC`BUMkVbrba/O,7"g1E?E=>/&/?UNm]Aj.E1<*HBQL*-%R>h
JO:I0^qL@`GC4[<C@`,K(J=BX'<[XR'3EFW?q0NOB5;UKM]Aj!\JM8(7]A2f!!&W*H\I9i;Nq:
Cp,pK&-hcQ86_>/9B#$oq&r'9*2Yu/',[7(sPUM_5O]AT9Faf?&U7C)@PJ5hu<kTXB'.W>N0n
m5,7/.d"88$kK:'JLWV>>JPaSkm2S+J;s)>'W/V_/NlPbVi6U2J1Sg2`@>&N[sL=DK7%hAIl
qoG90C&ZCU1EB>#oVRm%W"i6tfR5c:?3?7^S?Hf"l1@lTUSd0Rh/j#1&ZBr8he'F^\h5SIcl
9?4O'2O=tkqAhL9VZbt%\t_dh2>"(3mFJM&!V\\./+PCp[(V*VM,2,S0<?ZQVVqa$2\hXjVI
Cj5mDaAOBGL-oWc&:p(@P<iS!$Q6PR%fN42b4b&f(B.EG=ff^8]A\1NWKVk,EO%<aHYWYkF$S
0$tJ2gbDl)5gh=0r3lK!FQe4tpDDL);@"=(tUo"#a(t/$V6W=rt+T_-lAZY6(*r*C0S=M,"T
lU",=mT"<M#A00!0CdO"o<OW&8J[mG.TEcs(-9Y-YAa<kfu&rd*&I\)gN>-BK4DZ.qTHn[a?
fiS5Ybb_U4I.aY3_d]A9>-A0PLt9#>!d#P=TG,n3I7`aLIX1g0::=KZ\>/oqtQ+3LNhK0i$M%
cG>@>FGUO\61<k#o4.T%m")&)(/XZD"Imukk_Q+_Kl)n!.!qVsT%pJ48gHKJ))C*\98A>h-3
1*Um"2JsMDicG%ZYo8M[hmem0uk-(KIIi[&7mXC\;bLN8>\@H2Vi7,82tiE\]Ati,u:*?_sE-
PV76A=Ru#5<T7g$34LRo!#Qh/$-8g"5ME$f-;9MduU\NG_M6]AXt\p>:"'b,4M>\BtFAe=O4d
u(X6;RE/]A/<#\^`"[C^@TU#MJ`V[;41TG<cJ7$6=$TFHWIR=a"Dfn5BhXI3*9gEnYGNO^9*[
it0"I%;_e`CdY5r/$g\HM=@g&YVPi-S<[h'^Sm"'1trMaa_>l&G/V=&!eNkdN25fgQ4jRdc@
HkWq4.=QWBWH^8&-0=J57#W27V/I:(a%"_6PsQ;YB]AQn;M>X;j=,LmG\F4i-?V^riKmdkV2%
KeC($c#!KAPG&qa%qJ"rtS?>N>7Vdo"OW$i.Cn$\OU[-;34bC%-[rD$ddA-sa9j51st@JaFp
;kk*oaC3LYr-A411-%[G@km0X>#u6;_1)+;"=W2foZsJGloR!>*hL"FtEid+2]AX%NT!BA/a+
!5uSHXH0B3Xan'md'!jR7A^T[hQSR:JDbgqCO0P\E5s@=Qjc$ZP^9XDtP,qc:d]An_HW7C@/U
gnV;-7c#HfMbYA(9>?b<C+$[o5OE+I)4MMp*?g^eNc^Vkdb#`miWHA6_+!dVo1!6"JJ?)"R?
7;Rs4H//CH:6SBmTI6>,NK1meVu52#3E&?PitbOGfGLh@9';`*7pqOg%Wnb&/6A5^`MP9(2f
]A%sTV?$"Z(tYH>NSa*lZb#Q@K]AG(G>Bc;nu9<`95GjgS1^n]A.)MQ]A4A.*hL=?A_WccT0SW[`
N.b`k[/'pL=+u+YJR#G"[27,/;",o9Al9fAX"T!$(Xe5@SnY+-0)m[7Rml=uNddUpBFs[o8W
]ArF;S+V1eI)8!UfK5?)r2G[')_;J)cp"AO5Cge1#=j*l',"V!b;,]A$D0R+`E'/RLAs'Y%Si0
5>(b`7`p21Vt@]A*qWmRSh=;2uOG@WCX@@7nJ;0^d\e+DQ`k9.mut9T(n/;cpdn-8Zm>CRR\<
=.%#]Ae620$8!l"^d1C=Ec%/J7jPKuXR>D`O@&h$OfttN_]AUomfFa]Ad9c).Bt\2$O@)&)!<,B
U).)-td.SPJ@Rfe6I(bqE!]A>e.mZ8Xrqtlun[d8F(^<(jl*/S$[i-MYF4_pV/^L8%e3\&@dd
#m1#fpY$&q'ot+KW,ohuA[S0>]AD0#Jp#WQc6"L^H)DP/<*/o.0XGL,?t@"(ZRWu8O]A8jtVJm
00J$J@C7OWl<+&&P29MW"/AcWS$<_L`:u*ETCG;,RqN0/W>ZD^LED7[p.^`8"/\@9>k(Bk5,
%^N`nCl[!tNdY%cK5<]AN>1NoX,99Y;La;96tJd0"LG_hUk4"Vq.WV0<7'V-:nYo+l5NW8EU%
$A>8q93`+3L%eg-/oC^qh([J4.D3roN;1MiHX3\a)+5)=2cRjq+TtWK)5QtoCA7N16-45s+`
_'.JCgs[Hduj4m'pWPf&3^C$VU&^\MnJ3bM&q6IHFgoFAC,KO0Th3:h#n`+Dli;SU1Dh_,@s
7\2MMlYET01VuE9JR0_fdSlMR&2qC^$ECXDEi7sp\6VP=pg]AI:sW)S\^0d<^_!GN47RF_KMD
\Mk:="d"3c/p"tM12EbTff_(`.dZ!*k03-AeY2kfl[A%$RIWK64X3VA=40F6geud10qhhgJ7
Qb?hp,>D*&L#:YH#USKsPBBfjX)3HrshpKWK\M0^B!75ZUl?,5,@+._O@Lg0&Y)K0HTo!hHB
-*fPEj&eTSC3t)jkA8-:V5QGN/>K]A#B*##6HYg&]AoA'_1->df"*=_'cE019rUKIAp*<7E#Ca
jJLfK3u_lZC2\Fau+7'7G9gS6-Zu@d'?>Y@R5T<RBk23%4!cpFD)+-[c9_\\=LoGm7rU`$-&
B8h1l2V7ia8<gbSFo@b8mk<iRKB]Aqn+&1P!6OP4su:pdgP,?FmV[K\H3"8S5^rkI7XTW;mP'
OE%F$$/?#<fc:%m!LgN77(GghSm0h?ht&U0;cf34mmo4pDmELGJ7AOD*r>d_E?\/>UN-I9$O
i]A55fQG$o5lF9\+YbrC9pKpZ9":;Sa1MSpFZGZ2i`*<.)Dp,I@M>,Ublk`FJM1Z=GJ$?0Wrd
_7qC$kDB#U"ha4DN85)mWKU:PbhEhTr'u+7)dU,!L+@]A.EQVS!]ANo?UlSHLl&"*?8(X+QWf8
3mBagBE,"fo'L']AX_?UF`q_f;SoW;QlQ2N!&`U"q[@kFTU>.jS4;O5QX6kLp,<0+f0HiHpol
I6gJV`5E6<LU;q7m5seTYc>`moe),oH@Z+PLoM`IoM"_u*-?`9RI>$QkBp\sA7gl41PKC'J8
+C>4O^U[AA9mc>CjSBML34LAGW,^LKX<Uk8m/^!15@3=DfegipNCucW13jQ*>REX)5cH>Mre
!Nq/:,$r2AZ2&^J(k.S63H2V?G6KYG<q3$1ELq.+34n3r4]AB55*n3HVes7d4s4n]AN$5gUQr8
eMR)%Ag_V"?#Tf!&;q;>:T2OkHsPCZQdab36$[[AO7p6UNEX/H.)D!76,6n>`-=LDL^Q[ALe
cCM@^urkGk+UFOnK",!19A3igUs>'uX4)B0V_R%V-hIYj?>EFn?heZl.t/X9O,=?Rg.]A(d\4
&P_g>,e!H^O"Y8$;f6kGhbt6Q:<hZ*qJ%MpRM^9=nrFBjb>#0WA1q?#8aM]A/]AW6@..+J.$@c
EQHb7a//_AUPmakCshKIcE\B(A@)B]A\h"nhBMNRaY6(-n,=mZ1Uo+lf*KKa'hGWgQqL`<1]A`
e#lmQ=KW$qk/OdB5X_f"=j;a)ObSoALs%ai+P,8^-/lEh*Hkin8M(K[B"o[of>W;LN"7N.Z9
oF'mu(JfQ-0%\omf"-&>,UP07L,fHc5G+!&$QiV2gIT+?]A\eX_8lDG;KSG5?Q,/i8p+6eRQ-
SI42m<\%<WJ/d;!a&\.5Z2fJ'9O]AGiclWG%1"J8:KqO]Aj+sSUA*DaM:(5*T7q<g'P?$1<+Xk
Nk5SC_Q;7f8R`D]A:ECHieh.>hajQ)Mc\G1X.+RZ`!D+?o`IC-/^?'^?)8lmi6mM0uWUn%&2`
dhP4/4,h)lckfKJFTkcb&XAJp]AfK8]AoTFt_.dHVY*8aXP7Gi119M6AWjdCnWPp@?5_;>E]A7K
hd0f,F8BpX(o3=sDLiK1>-\\i_#m1inR_SV<=R[dI1ST*$!Ce`&TM0tf9RMG?MKn37H2p?$8
F.GDtes2?U*+\Rj#AP\=F>em,l,9;Vd"DKJ>u%.;F$n1j.aPdhgmE_8+MBOhlX.T=$oj=BgC
-kJ(`!W7mDu_1k&2f6/L'El*EKZ$$TA.V:Js4*8><+,Zo8dBn"`I\2=2jA3QM%MrY45X:]AN=
.bC@Vn=;TDq8@BJIgV@YI3mBt;Vrc8:=]AGp8hLUPk^YHQZm:\c.J_?t_qN>5Ie=SS(W\Sd)q
.^,hH.qgM!]A%^-0t"NDhp>^c!G4MN+`!>bjBUseR%;F5Xbg=17DjrpdK[G4^$B^&f\Q;DMdp
7)L5omTKahWXG1i->A1Qtd#)h+`nDTe.F1jI+j>clUhti)WHb;HHib%b&i;mdYF-!t-E/i0h
L)s%0XHQ\:\1W_M1WPl-;tOSCJFnO/k1>V&O*S#lcA5p<_fBP?8#FcK\5g_+8N6P\;:ZCN(o
CB*g@=M+kg(5`mSnj$NeSZ2SV[[@&msn[(=T,8[BAns^#tiTN54'P6qLYF_lhdR/iJac(<&3
Y/rj_R)d.RUoG+.KOH$%F<G]A7^(YU$0ig<*@p"4GaDB/Ok.2oi"M]A+T%/>T!!jbrJp&rZb=-
'?jc)"=X%N.1SJK&j&;:6VM4X+<3+4;B/Z['bEn'"I??os`RPok#>0p<!3WkJc8e)It9bG'G
$\#F4<INpZB&PYD>iEuRS3pX1?CX58bc8';lnJpUEL7,0Krel$AC!YV-TJ7>@Bj2T<2F!Q(3
O.u"ZGRhkaW;*=ncV3UY!U&k'lYj3``%g'Z6=$0@b-)%ZU(\dq(#).9rTY)_@.N-La6bc$\L
@I!Qq_6dFNBSjVGke;d5gNE$a@feTfUo.k<1D9pDr/@M-M\'eRJ>'WiSQ`kIl*c=`kmH2D/`
j4mbR;C&lm68@EU/Tq8N+_(,&lUeJGY&Vd,e&iRdd%%n5imo@P]Aq=@;lQGE_Tk8EO?mIhk%a
.G)+$ta$$*FYLiIL?rDG@tIY2pCl.hn;+UHY2k0]AssE?GKldd8'g2nk*a;+^t9bS\G=3;F:l
]Afg`P"]AEr\V6qJ@iZ4$U2h'(BP<iuX!R]AY(I/EuhB,HRp2r1>kg2*DU]AikVi%Kq0mRspK`IC
=g,Y*1K>AYM\hoP>!6qemX>DIpSTU&hG1=.J=O]A;a'T2.=X1[aASjE>`OsRIgHWTMYdn$`\Y
cbXZm]AbU'BrrqoerZ3>fJ-ikP)`'*1iKo"2=A'45959%BGW'(sd9d*PiJ9jfDs&*4sp2kAWY
;Q?.-2hmH=jj"XAt+chD7cdq.=l2@uSY^:pRYn()g_l4=;:$9`dFg=/F`_#mqIIu;5P7(_hg
aS,^RIb\dmq7!*<^QH&]A";#s)E2O-/J'k!cusmud?_G*[M3:N=ar'sVOqdi()T)RnM_gn-c$
E_Y1mf%AFsbg4kQ:!,%GC:V+,D`/s!taH_$(:2E1gZ@_b>e$?Q#cH93euQ$ULK6!T?-N(6#X
!?G\)r,mkq+;g_#/%ih[T?@P?0"u*/KQklIMk+SORM)dlnPB>*YQsTlDop#'ZEVS_hacUL1#
CY)-%.SkEG&8C"deHj5W@ENF/(%QYH.SDLs4/H^q]A=4D&-,O`.DU&]ARCqB,A'%>\%^=#Tmp8
`cj<oHYUMn?-j`YeqdnRVA&',Nf=G:]ATq/@bP1u$U4/Bc2HB?npGchi-HEHAs18;D6PJjf,`
u8g[S(=tCk5Ye30^Nd/Gl'7/(WX0>#Lhjo>#+NA]AqCqXV+3qrbK2(`PEm0(9UufJ1:$fl/P=
C!1@8c<I/?Ps!!jU2Z9jm1.XPqLiR2"+\B#rNW_:E:@/qIPDQP?5J>#-\[3#AA:.M585W7oq
<\5+Z@YPPam[$[28?lJS[R#%L^GJ/"/kba#DX4479a4B<J?:St!mo*7]Ah0T%Tf,UUL@:&*^?
AEV3l0O'P.#KI,X4LH8L=uM2Xi_]AiRDq]Ai04c'X(RlT5O"/5"WIR'1R[eFVJg_/`O]A!N%VCe
.QRo-o.TF'.j-9fRe"7GeK!o&fbX0Ruhr/K<N(ij%Snr\V\ik!62[QBErU!H`>t(je3RF?dL
8Ee1WX[Y<M[?K);67C?^(Tk<,lIrJKJkuA0bqVYY?EhV`s[-'C8X.jFur(`N9#kubQe]AuX8H
kYq'.'(^qS;"68iiNP#8FZUW-f:VYqJjYS:CkLC`]AQ'+;<u_R-23SOCTX]A1hnAIeTuMPgI--
d&Q'C[8:HM8hJi5Vo=P4o--Kg7_>kXqC.FW6:D*F$2-)/)UCUn?c0s4[&4TZ0N-E:oR`d<Z(
-E2FC>9L4!]A=-9LCIOKUiV#Ip2I*@BggL_4.(\I![TJ@nl7@2)=9_7`EX'hCp.]Anhf3QB-6F
(=^-V.e27ZQ4Tb"2R^?@>^*bGs8>ouV6c<`T_"&daJA&U4=751teM6H""b9+%^M*\9p3Q1<X
l>ld@68+kK?0Fqd6R8XH!ZlMjdB*lY<>TVR>_pr0dS6si=WZ>$8n&m3JcGRHOp0K0aa@Y*B1
Ib./l7\/7fTAl*?fmK"qI]A%GTdjI>;/fcttlH6H[T!YduECli9).hH?RGqAJR]A4$m'7*,O%2
jC!B9?M1@1L;7V9r.a81Bo(h=IccE$S^(jF:smWDX":V'f.Y%Ajg<U^!^bEe7c4[2$:b:_4&
WL2K$5rq^ER$C"Z8:\cV5pX">dO7,mXP5i\3GUNo5BUBQUCP9-<Kolk,FqHQVc/`:*hl[`iJ
Kb0D><=,Z1ub/jeEI<,XI/sPL'Va0nu*#jMnq*tE)W?s&idpg;Gb"BK0X3!'-H7(pu<1Q4$^
U_/!(hQB%$&L]Aol#(7mZB5LpYu?Vc+RVnV32('dU<q_M0-@RTY'nQZmF\hN?[:p,J<G%a'me
@g!"NM2"2(-SAD&oT#pUTJ]A/mFoiT@6t+lH6OYWuIeW)m%>hSt/WEd:JVitD`kK&KbV.Z5Y'
+8bSAqU'gpnnm*rXt[L`HV\3mfrS;2(uj,RmT'+"<92n8WsV;^0L$4r`H#H7aB[hO3\3ae.$
:kFS1F'&,D5jln1H"r;bcLV*s4jsfXBEehM[gt/1'UN'QuKI!%UU<A8H(.mBpE_Y2Y>o/Hmr
s")TN#+7Z<Dd`2'Bd>`\%F9m+9P0#(qOlb+UHIQ&!,&LWTE^gg^DsuGP*tGsplH\Ut3T[*V.
cC4AZHeJrk3gge4=1!)]A(a>;K5Y4@M!sAi<7Q]AuFm[IfSlJf$Wg&e+dj#_jgaWWRpCPVm*XB
$8)qN7ng7C>oh[BM1&t;M3!XXsD@B[DW)$2=[U(;nu2/<%PUO(Zm<o5DZ<[K1`nkGtPCt_Q^
Ud"*id9&*shV3sk_E-EGWlc#_F:p1Vp(aPkkb+(sYagE)P[LeiDFGUBD1Q5\b,l!R@YEk.)*
3Ef2F2:(mg&Bs+SV29]Af'X`5LAF%&CZ;q@u.deKkEr,.mBP#&HG`'3jE+XTfik/h$g),FXBY
fFg,fCjZD\m729R<^@MdWiuDLiL6!]A3ha=os%\-N05Hpl-RY;Q''rLRLeNitpAEnk.s-:XIA
.iP%]A,^nbMNW&]A69oc`Xq$8W<:@9;dP.ZXoQ3mLh1^Pkkmp&ICPlA=F,gJ^h)%UF'mGXS3D6
<V`f2CgR^35Nl+]A^AjM69f7ROVVf8ca@mTPAcf\5S/^Bthu=p1oCg=cJ\dLs1*[shBJ3%uXL
4shbprc)"hB<lLVNK#E5U$k;&*D+;/n:ESFdoOG!DFLIR\9WePWZC?ehh5gP9:/HFhiZ1bVr
OSM7'9k7:NWTe".jhUgY(#(#Q$1WSoRS&#3#hNCY3V2Nok8f2XJ9\42c;\3lh[5EF4dLnuK"
o4pZDtbBYXC4X,(O_-pMW*Gr%]ASfp2tphlAPeg'cZ3P-.RKPa]AH[`7.6c0_J412&<&BZK4pb
Rdm+mI_%J@ZaHj_As5P(tk$XV9GjmF%opQZSOXnnFQ3J`m'T`]AU,<cpfCo4$VFZk0ujjH#On
h+i$Zle-:YF/#g;!eg>((5e0&`f`,jP:MRmca6JrjEXY+eL/n:@UP(@o)8t.?+AP#T6]A>YSG
e?rrg*;mJ=6!#\o0T,O5jXblK-J@fBp=_oYqk%[O_MT_j1OD$#SE9XZ;Cd8\3pp9eAZ.9n!c
Mbu^YEaRoX9!M>E)`KR<284Rh[jS+@8\;=p[4Abl7!Z#4m]AZT6R;udljfBKio@ZB$aW4E219
m6)ItqLWe`)kI,+Fa3Rn7d@f^Qk.r;lJN5fP[KuQEgI8eU$:_;5lG?.8-[r7XK!^'nIAr7<`
6*a"g\^7ca%G3po%G4uQ>Upt^AeAN1b2ss)EL,RHUD'#Vn5e4:NQ'&LD%Q+rXJ!9'c`qb5SB
SXlB5<flH.:1V3>CB5Q&%29R?lFZ<;%=R2:j;dco80IH(eId[NC>q@K9F]AjJAC*iJC!6tIT9
O"6\$Mc39]A1\pkBDc:l!f*>A:a!l:;#q,nL]A:q9-?>$)P2nndJG3\*K1Y-`O6fc#Y^RHpDTF
T![5bJdG>/9r]A-aJ%B=Z'#Rb9Z7b:^HlE_`$H/i<BsGD4(?CQ&83,NR,57^k0lRX&ZEZlJ@D
hN7M-Cf7ln:56JH?H2sB@N`.*&Pn_OSQg%!We_VBR>M;I^i#PoeX@iF5:$:h.h!RT9q75%r<
NH6_X4#pjI:R'7M(]AV?1rP.>cQ;sVPU2RG%.2.=FCRQa(D&(f0!D[[&&e[bVuaP4hR3GIb_N
h`TK'I5'8fMZmL)#SE]A&G0E?qE-CeIQS)';6-;Q:3e-5J5/O[GX0E8?euM`.&,*HXnAmB\FU
mR0&&1iM'rpYdUa`Ff*)@2:a\PIBDe'Us4O7!f70`>550KP/ZS]AXB9[gSuW-N,%/Zdi1(Jk<
/mA(?uq@^0"j<@\i)50/I=;5>8>!)Ou-f=M#Nb!koM*<&%?-h=$qVGp:=Xo)7$N5_PI.-UbI
1/BAjI>X"J14ach&_o+lho!Vm193)R`U.kJ=]AFs<t";s]As=W\Y+!&-.u>(#n`:EJ4C%e0d/M
lPUDodLpZOXm%DW17qp8h&C5cY=a3Ud'7\UNI+:-o4%Ie3ggt*+3EscBj-n"4'//-#IYM/5>
i8:3'o[U!ND^aR6rRijrJe))i#M$r.n71<b5D>e%qiQPkTbpur(1fjBM`/e3mJX`)Fn+_O:H
gJOe*]A4L"5!`IbMM;GW0M[EVo?YC0sb5'd9egbF4.MpcCgG@*+fJ:R>!AA_@rkcR606D.iF6
p*JS5T[55Jo_0=dCVq5Ashb9k;$Ja[[`T[&@X@@qU?CO7Oi&]A,iHEbj:OCLq(VK>s`J2WS1<
NP.5rM2!o!hB`3i#:7$d'>'#sQe;iG'Y+0WCF[XAQ^f5*PR6`0b/:R?P'pgTmh/6q`[4X1@+
EAFtiD^Vd<=87=!8C[(W>p-Ym&!auYke$2q=^]AN!cE5\-]A`,`q:M\7p^Ah!oD:OXp:dZiV__
=5\tWNi]A7"E4JQ-uu%n<_e9VbC/RP"&QeE:uC9*e:`6hoS^<8Aib=2T[R4em[Iq%(PJc-bu%
)$&TM7Yh!T7l8lJLJXfK8d+j2EJ8((4EgQ5AU*'c%06?81@`>:5uS[gJ6!+*<;QW%!h)`kob
SM6B.OV0b3RY']Af'T++\CQD0HltX>/TX]A]AQK3GMlMoW@Ms%9,W-E72%HXs"qGZPI6!A"EXsk
(c%dq<;igXB"B#Fu,]AH;0q\f^1JJif'1L!`=TRT;f^4OH7*n^KHp+r@/-(J!VFIt)a&2/P?2
%]AKef_JTNJst'aCGk3ESF`CXoJ9"7pTW+JaFb.d2ePRF9/=s\bZ8(rl?=PVH.7S`aq9%Cq0\
%7E%2dEIJmQ#]Ahl@hK6ZPF]A:)0RXWq<+4EX_m?ElN&=gO+!oo7[u&ioproLj8%s)R\]Afr?EV
fjoTtS-+O/?"4D,-TKemY&)D#OfGJ_d+#J+OM;(Dr@]AT!a^F`EYuG$YhQP+FX"D*Y-]ARL*jH
+#g/ooIoQ5mhhFai9#FAi:gqZS.`hb`67%o:?jn)_/=ed5j9`T>Es%<J"X(b0Y%h^N#`I8BC
:DN#rqQ9.p:6i:VB6$[C2KiJH4_TiO2f/T*jo9N^!f+F?=82%VpVD:0Q4E9VhMO=DKJak&'&
DS+7=5Q<-\0CPEN*?$P>W?0'WC."hR9$B7`mocR[BdF!5.5;DK""lm8G_-VQoXQp4O"K-:.E
5bq:;u)f2$.)"a2nPgkC5)E(7#![D-6e\+DN?<q)#R%40`TQnh"7-iQ.tq17f/&ua!<-5"Ab
B>oul%CRio7Ck/SGrE9a!Ss^]A7s1%;j)aS=It1o$O(=[PQhIHqd=pTE%qch362,()Q`7fDj&
=7ANY,7>o-#fWq&4LBTD.J[]APGpMDB<M1YdibB7=utXF2'm@j;+Ed%@`g>)Tb]Ak'CKi6Se-&
>b0YcFhD<JrFG\rFIl),qf]A)r(]A.n$7rhR`qLY$LqCbV(g2tM3t--,V>P_qkAP(2t>5Nd:eY
Do%O$-iT+h#mD7pPo-&+\L/c?]AWAd?PTR?9q1<LF^[hSLY7f?lC\672uT3/2eb:p7!7$rp5q
[.2G?!BX>#8<euNm^l7qNu&GIrj:W%tGiUF3+V%\ZU)JFSSBRV"/i:aX;NaG#ur0s2EkHsJH
ALm%)F[;A8]AkUA>cX20/@nMu*b]AhnnkE*+m)A?\[*_ddV)<SA?<nX+f!-[T=]Al;gX4k,hIA,
oOu/)NAZ-\0,<9j,fgeVIQC0:B!0q=m%JYlB9EnKSVDgS_6%#X$_rZJ,!U+o4ZF<ik\@/:Lq
+;=c9coeCWfc7j7%@;-Z<GUguNQ:Mr#q%M91GD#j#[koe&7p7H:dcSZ?`Q'u0AK07Q1_["Nl
/KRl/`p.2:&cA6pb0l:5Pu#fjU1n^$[s1O$\JPN5EM`@"'J]AZ3V@tRY>hj.k"'Y%/]A$!`bgc
7(It&2$=`k@fDZ)N2Y_bK<i;D>Mbo*'N!+I7rj7>.WaI`nb,eI(VPW8<g1jEo+_j/WblSf@1
]AUV>:\pY/En]ArD&4p'/EoIN=PS]A92iL\m:L&9e#A)Y32<2YD-bpbUh0jS=eQ[)QW]A`'V_k+M
0&#-)e_j1b^L=D-Z@m:rd)EKrO)KL!P6[h<^'QmcXNG^YenXh]Aa7e*p?RFb*gng)hbSg$Q?V
N\+>*:\'DRW^JH_,1p;</;.Yg]AQSYY_:p@6]AV83g,FGO7*%<LVO'\%Od=@9!_1uCm<AVJM^1
c.bdcl6aWn'1[sTNhH&H151qH`/YV#S1jE4UJH&5X&LA46ut6GK5,\M;)+/LaEm35HP'XBc;
LrPM>CtoZ*"nhM4R3Z-B14m^3u"D856mro4DD.sQ]AR=ao+9*>$I'C$+%s48q8[rYO`I=7g\G
9>.QJ>P`mph!(Be\]A5=@%mQ\V(;MNc8!!CJrAH$C_kk85IV5<l%Z-N[DVAnO5I<))Be/W]AK"
qesR:^fO^En)K0`hXrJ@)g='2&<3qm04Mq9m)dT.+4.rSC:i/SJBRYRd_X=qPZYQl,jCTQ_S
tWPosoWdOBNLr[QXAUMP:o^F6C[r[Tn8=ooMerQDRZcEkDqZ'm':kHVcj[`\!De(<h8r@;%C
WW'$ci!`Q.7#ol[G,'G:&o8OMmG'$$h#Ocd3YN2:B<l)p(5_6.h91?]AP%-4(,lH1gOQS*E%g
i<"iQt;MZ?uoHB5HKcYHpW78ZV;+*[\&KOP@JH66_oq\LcT0b"I+*A7\?6AU&_J>K-gGQ#Xt
h\)4!C^62/?ln1q&B%koht+r5"C2BR-2K0HN5H`#"nr]Aan/CTk\-EkFBSFZ0RmllB6jBD0,s
`h958J5A\:2#2_EmmW2coG>1rK[h#qHc"nVKp'B<q4s@-iN<m&182MtF8$!I#/+ih3)<L#c:
,mE7U$0)q(mMdI2BY:YT$r\-(,iT_d\H7/E6^BjG1#`s)rJcs>i!G`52FLY3>(!L=s5A<+h:
pLHJ1\W""_*J>+IFZ^kC6s$\R:u,"Nl2dSFpe9i5p5Db=c&f/UQA)-'PAM_K7Dgf*p9bSV@9
VD'3@V?Q`'A-FEo'BJ7auhn\c^r"eMp=.GOi>67Kq_,),QZ\0Mp6,k/2$j1t,#hGiG;L2fhi
8t@%-7';hlcVHs=OZbkJAJ)Op,?D(s!(+HoM(G!dXBS_OrD?Q*MQPR=p!Nq,n"qTl0fjH/3l
hRX<oKi@>:0d1*_bXkS<BS'$3=s9@:2K1Lm%0HWYTHY)l^Ub_E"'R%p1QSLlf]A2RQb?c_p[:
nS.t>C4Xr+B7kQ:h=;HG*jlnrJXcq6te<_Yu8:%2nU'r/jW]A$cpBrMIcC0['n0N-D%o$6:US
S2iqq+.%84Wd0Y8osfaM\ZO6U'Fa@Lj-g$P18W5'Okg,ZV^S*M_%N?4sR8N'e`k^eV3Q_P[(
Oc4N$>$NqjqBh@-u)L+X'@3)mNJZ_q<"m"ji_,!aq`U&'LkKf)L!7_o[OiYZKlKo8P.NOF5U
+KFg>\*)IfS6S;sL)T[+F!F!XpQVBjW\tG'UKKo77sWK(?VREq:%hWYVo%"0E[Xae3dD87l$
SbB0&DM7DQ?CdFQl1fT[2N;m/Gh6g0^*TmHKHNs7Ycs<I8f(#327eT@fj/dk?ndEDeCP<M%5
G*L&`D\UiBtm@^+)T$eUbam/>3IX_h5o4:7ob(-97Jd2W1$=l3QNJ^oP^h0MM0c:GZaF1EuP
+foLbcSMhjp"O$+kquAo\:d>aMt)jU9@9=PHYpY-.lWZ29!"U#$dOg=5g,r6+%"o'40V=M/?
N!iMR+7gKDnT6X\OM6hLp-Ar>k]AR@7fm-:3,0"NmRf'a$c`16ZSSJS4DH!4mfE)>or<dOL$*
M"bBpE,r!Z85l&q;%khd7KL&66"B:5mL`U&0Lt)Spd+KS[T4PA>*u=Kc<j%"CmHW.Vb`X2k)
lg=;KXZN$HnDHQU`+qNGL?mX.b9.AQ,DNdGGimYAVFYVp&X<q81P%'+Zf(0naKk_MQ(RKR8K
c1V0r:I&4eKrN@$j^/.X,M\.d=lTSaG,Wm23fHYj75bb'/l4'>gUqJE.Mr#nF;<V=W/>]A.0r
W^JcPYUL\3F"c3'%!kZs,CG&3Zs&iP5"':a5oTW:S93lRY3p0+InE0Vi'7$EP4!`noMLRLV,
_G3@FVX8N6\kq!(Bg_##=E*iNPWZI_`R0+6FRgK9F8s4>'-C@.A&q?rE]A)@#EJWh-W$2udaW
7)K9X(JDh/L#a_eo>;\iV-LYI,qUeGD%bJ/LnmWNCe>#"`HM&JYR2GdL;`%&VW.HQ`"R+$Z=
UF>#'W:cp`HDU^C1:B-Cu5hLcVLHG%CfB02_AfcnqiS\%NN21"-jm=d$R!_iX@2`T:TW1dn^
EXW3Su'Q\)J`dA1Q3'<:Pc]A&MR1K;W`RJ8qe5S`he3FYUs_r3F`R"0OFM</j7;t6sf%@RtsR
ME$K1jhc`MYn,9)ekoUTo]AZ,WbU/;$td#T^*='6T?;C[5]A6Ou*RU4q/3X^Wj>UGtMP'JTcS\
[Y5kGslo\CU"nrPMXlN$_nZBqKkl?Adod\do;)QLjYRh`V&cPIN%[kLc+N&6b@#X#m.9\1]AC
V/`T$iZ4c3SqFO>hF9r3`a5iZc:J1Bh*WVOf:Y9<s&D)85K%$GDBbf-`C!5oq(Pu=KN'"d.B
Z+c3JfG]A=37@U:=*YY=1E%pcR;-:^ei^l6YD\SJrSJ['bVUUb5>6[=*:Tk#&`0'%3R?kWR0a
]A.#KiKc$\3ied-P.X,k84W0XCY.rqhs=e#>b!*"U3kRqmp8\`Lq,QQu*F>BQ%.#85`&Iom1F
-6*J@.jt$jEp-N-$Kol[g#e#S?QN5]AZ<<fnP`I#,m6,=Y]A-YR$;o9u!3%VIaDogbheI*k$(A
[J3a6D+Te#,/!TrN$<+ki]A(]AI#NB&>K\:U?-H+*pQSh!&N)SIWGu`X!"]AjOf"eGoF&or/Jqg
01p'\:;"."N.StG>H64$h3M%k0#^COB[WE(pA'GqKZX#sXA>m1L*fm*W&oFqCIYV,JXgO8;E
!L,S2+&7d]Ah^]Af-fjSSsJT3"*Utok`p-0KtK/"F?!7.\P/4@p_Ts\rr%+?S4lsM=3+_?*WLB
&T(gPed4a$Tp$\$`4O*bJCo"p0#*=E76Ns:6@uT6R#rO3ET[Yt&1*&n3's]A61eQ0)GZ/61Y'
PS'-YdMD=]A[dh@dNI9B@]AVm+9dH5&s0o-0YH`?96?s(#VXo<4@'#gJ)u+S$E.]A0--(;-/h8i
5kT8Npk6gmb_P_6Ih+)JB5kZG0<b1Fk6W9GN<9rFX&=_KN$:=%$P&&%./;!@M1-Kb5-^t:;-
Z@'kErUu)GU^sF7qtDRDI2S_8i<?X1/&?iI:Og5Fktk<(.rI,$m5ag)H-.H;a/uUIEJ+opep
m`QGBt0ij%tUL\.4on/E,ZIUA=]AKCSK_^\Fj<,`3=IK2(?BD\N*f9OX.m96Sqpr8BF`T'cX0
OAcJm6orgpA5&#6;m=V)APsY<k>o\>ATa]ALeVE@Q@MrmRkFID:QRcPaHg[7h,Jt`fJe30naD
i)%AjP_cf%(Z>5D*aqpd[E#O@,rnePdH]AOf;/4?j03hV6@R<Q>=E*orEPF\T!2OpbG>[DnBL
2B^;-,T5CqC]AbN1;q"h$FYqI+D&Q(A*Q_EZS<Lfg;B5L0!:c<!`PPBtCGBnS*9ZT12l\-d3h
`!SkAN#ick<$d;%ThEd,ffWDidY8I6QuGk(gJ`9/c9O3DDcB7aN3.XDhCF9L4L#WSs5\Y=`F
#gBq!/R#?WE>*>u!f]AqG?Iklia8G/Q?h,3bB1cb70\T38hn<9c+Wu'<lWr\:Fk_n+Js&n7@o
f&[&/kg#3*\(]A^>u^(+lJB5-:N\?JV,6O&;kgo\4Be@tR9TKN7p"9/ZKpbT6;+.AKP)NkI;L
S:.nks+HV]AK\Y'lDFP!-;".E5q&A3\(:l)p)5]AudR2VZeW<l4H`>JDHIVV[//0sVq.oNm3F?
bq6iQ/ioeq1=j4<,lhAQtsrA\%8a)-Y;%L-eZ__qf]ARK,osI2beeZW1gBc>h9oKi?\TAMpWW
Z;KZM@I+!RaceAfZYJYA^.a7CmkUL6[h?iM.5=2r!5/.te5,7,Q>"^A-LI?POA-I+A?n$0\@
[uS-JeAPBSOjb,Bng=cY:hBKTI(Wpp`EE+E%/)#Lhe35OhTF77/_!i<>BY>TmAiV<Ki(>nC'
LTlEs)b>_@=P#Ui/k+pluPuURHmJ-XK6MZOU<8.1N:o^]Ar<4,g,nq8_&\J3d;_Ueo6.pM4L1
"!4srEi'G\Fjn^'N:kIX'.b/]A^/o);=MPF3_&.,QWHDb6>Nf'BHTYf6f*p6g0]A%%hiC>+><a
=*!9_VZ?QmTp_ArjYZ['7?]A#6J)'E8R~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="55"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0"/>
<WidgetID widgetID="a27d4a00-9d7a-43ab-b5ca-4b080cd59105"/>
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
<![CDATA[288000,501640,806920,444040,720000,914400,432000,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[288000,1270080,2880000,694080,1152000,72000,72000,982080,3600000,694080,720000,72000,72000,982080,3600000,694080,720000,288000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="17" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" rs="3" s="2">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="1" rs="3" s="3">
<O>
<![CDATA[载运率]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="货量定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[货量： 出港货物净重，货物范围限制为由顺丰航空运输的客户货物。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="3" r="1" s="4">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="货量定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[1]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="4" r="1" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="1" s="6">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="1" rs="3" s="7">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="1" rs="3" s="8">
<O>
<![CDATA[主舱利用率]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="件量定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[件量：由顺丰航空运输的客户货物的运单数量（目前暂未包括国际航班的票件量）。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="9" r="1" s="9">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="件量定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[1]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="10" r="1" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="1" rs="3" s="11">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="1" rs="3" s="12">
<O>
<![CDATA[主舱利用率\\n后20%阈值]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="吨公里定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[吨公里：实际吨公里，即出港货物净重*航段距离。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="15" r="1" s="13">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="吨公里定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[1]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="16" r="1" s="14">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="0" r="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="15">
<O t="Image">
<IM>
<![CDATA[!DN[%r/"6F7h#eD$31&+%7s)Y;?-[s3<0$Z3=#fh!!%rpK7s:*!u+<p5u`*!m96]A;e3FQt!e
J32^gSo6`0jpiBhZof/.,70l[OFP@JCKIQ$=8YM87VLagDX#-L<\#PA^(P[m-&JdU^,e^A$?
nm-K,/fpUMbNfF_b&qIQrmt"JA5.VBdKhd$8h]ALRu?C7S1.aO_g=aj*[i`h\)J)DXe[>k+_p
0'=Kg,QI"*RLfsiX=Bb-Br<W[L]AL$0M@Q$C3:WR#k<b]Af@g'`.0%#Cf7!karuXLRVL@>R>0X
tVN\9h$.%\fbOgL!LMk=!M]AEN;W\)"?;bi:Tsn\]A*Gbo:+N$F:KS_^$qZ0.m(a2`j";m0"AE
&%4&oi0+$V6JKb\QIVa1"%NdqP`jNY[T0GjNunccd3:uI&[W,t.i-LP7X]AUZ:c^.Lr[H$g5%
AjZRooI:9,qHm,.Y_K#r9#E4DrQ]A-R[4g5>j\PQZelHYD_D*;llG>$qBSrPXo!nK8A\/-\'s
=TIho[P5[Pim?^L&QKflTZl5+:7EY]AWBLu8HUqN+O?_DFIHO<o6pUh<Go6^_A4LfI7CS+NsW
VgIe%?9p<nsCrk\Vb%%+",BAK3d*8?t2XOh#=;<W4fslPK4ah7cO.oUF7%]A>6uYdkOl,m"[b
_a5A#K)-*Cr`BH\H@hJ7'Q0TYV2L4/B'6U.HaB<QL$,"-Ho@>+B5hMO-4!e[LLcm/<e0Z98k
_lF-N<B3%`pJRj'ib[EN._#T'6j@cQ6E?_(Z6rH[&DOWXK+K,91PtJ6=Fl6DY-SR7$T*8nE)
D1!X;$8]APZa*'Ul$cu.Sif3A2?3NXQoq60t\mqSp:FXg&cScFc=rSrO-[l;oifa(m0r9jt=%
<4kjTmZ*jiu1]At#M%iZo=)M)PY3HMrB'Bnu=0NjNd>EWjDDY?'aEmPC(Z8"gAOtf@G=ZP.lQ
$jUp2"%Mgd)jriMk'DAT:qi=01$p<qhMC:>`[@CXiQ==l1>)7O`q"A+VO#9MG(jd^>`V>/72
F5Ym?IQB);Yg50WRt:_S`uR?3LAN;m2%Uomj2gqs*l!!#SZ:.26O@"J~
]]></IM>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="货量定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[1]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<CellGUIAttr showAsDefault="true"/>
<CellPageAttr/>
<Expand/>
</C>
<C c="4" r="2" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="2" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="2" s="16">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="2" s="17">
<O t="Image">
<IM>
<![CDATA[!DN[%r/"6F7h#eD$31&+%7s)Y;?-[s3<0$Z3=#fh!!%rpK7s:*!u+<p5u`*!m96]A;e3FQt!e
J32^gSo6`0jpiBhZof/.,70l[OFP@JCKIQ$=8YM87VLagDX#-L<\#PA^(P[m-&JdU^,e^A$?
nm-K,/fpUMbNfF_b&qIQrmt"JA5.VBdKhd$8h]ALRu?C7S1.aO_g=aj*[i`h\)J)DXe[>k+_p
0'=Kg,QI"*RLfsiX=Bb-Br<W[L]AL$0M@Q$C3:WR#k<b]Af@g'`.0%#Cf7!karuXLRVL@>R>0X
tVN\9h$.%\fbOgL!LMk=!M]AEN;W\)"?;bi:Tsn\]A*Gbo:+N$F:KS_^$qZ0.m(a2`j";m0"AE
&%4&oi0+$V6JKb\QIVa1"%NdqP`jNY[T0GjNunccd3:uI&[W,t.i-LP7X]AUZ:c^.Lr[H$g5%
AjZRooI:9,qHm,.Y_K#r9#E4DrQ]A-R[4g5>j\PQZelHYD_D*;llG>$qBSrPXo!nK8A\/-\'s
=TIho[P5[Pim?^L&QKflTZl5+:7EY]AWBLu8HUqN+O?_DFIHO<o6pUh<Go6^_A4LfI7CS+NsW
VgIe%?9p<nsCrk\Vb%%+",BAK3d*8?t2XOh#=;<W4fslPK4ah7cO.oUF7%]A>6uYdkOl,m"[b
_a5A#K)-*Cr`BH\H@hJ7'Q0TYV2L4/B'6U.HaB<QL$,"-Ho@>+B5hMO-4!e[LLcm/<e0Z98k
_lF-N<B3%`pJRj'ib[EN._#T'6j@cQ6E?_(Z6rH[&DOWXK+K,91PtJ6=Fl6DY-SR7$T*8nE)
D1!X;$8]APZa*'Ul$cu.Sif3A2?3NXQoq60t\mqSp:FXg&cScFc=rSrO-[l;oifa(m0r9jt=%
<4kjTmZ*jiu1]At#M%iZo=)M)PY3HMrB'Bnu=0NjNd>EWjDDY?'aEmPC(Z8"gAOtf@G=ZP.lQ
$jUp2"%Mgd)jriMk'DAT:qi=01$p<qhMC:>`[@CXiQ==l1>)7O`q"A+VO#9MG(jd^>`V>/72
F5Ym?IQB);Yg50WRt:_S`uR?3LAN;m2%Uomj2gqs*l!!#SZ:.26O@"J~
]]></IM>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="件量定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[1]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="10" r="2" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="2" s="16">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="2" s="18">
<O t="Image">
<IM>
<![CDATA[!DN[%r/"6F7h#eD$31&+%7s)Y;?-[s3<0$Z3=#fh!!%rpK7s:*!u+<p5u`*!m96]A;e3FQt!e
J32^gSo6`0jpiBhZof/.,70l[OFP@JCKIQ$=8YM87VLagDX#-L<\#PA^(P[m-&JdU^,e^A$?
nm-K,/fpUMbNfF_b&qIQrmt"JA5.VBdKhd$8h]ALRu?C7S1.aO_g=aj*[i`h\)J)DXe[>k+_p
0'=Kg,QI"*RLfsiX=Bb-Br<W[L]AL$0M@Q$C3:WR#k<b]Af@g'`.0%#Cf7!karuXLRVL@>R>0X
tVN\9h$.%\fbOgL!LMk=!M]AEN;W\)"?;bi:Tsn\]A*Gbo:+N$F:KS_^$qZ0.m(a2`j";m0"AE
&%4&oi0+$V6JKb\QIVa1"%NdqP`jNY[T0GjNunccd3:uI&[W,t.i-LP7X]AUZ:c^.Lr[H$g5%
AjZRooI:9,qHm,.Y_K#r9#E4DrQ]A-R[4g5>j\PQZelHYD_D*;llG>$qBSrPXo!nK8A\/-\'s
=TIho[P5[Pim?^L&QKflTZl5+:7EY]AWBLu8HUqN+O?_DFIHO<o6pUh<Go6^_A4LfI7CS+NsW
VgIe%?9p<nsCrk\Vb%%+",BAK3d*8?t2XOh#=;<W4fslPK4ah7cO.oUF7%]A>6uYdkOl,m"[b
_a5A#K)-*Cr`BH\H@hJ7'Q0TYV2L4/B'6U.HaB<QL$,"-Ho@>+B5hMO-4!e[LLcm/<e0Z98k
_lF-N<B3%`pJRj'ib[EN._#T'6j@cQ6E?_(Z6rH[&DOWXK+K,91PtJ6=Fl6DY-SR7$T*8nE)
D1!X;$8]APZa*'Ul$cu.Sif3A2?3NXQoq60t\mqSp:FXg&cScFc=rSrO-[l;oifa(m0r9jt=%
<4kjTmZ*jiu1]At#M%iZo=)M)PY3HMrB'Bnu=0NjNd>EWjDDY?'aEmPC(Z8"gAOtf@G=ZP.lQ
$jUp2"%Mgd)jriMk'DAT:qi=01$p<qhMC:>`[@CXiQ==l1>)7O`q"A+VO#9MG(jd^>`V>/72
F5Ym?IQB);Yg50WRt:_S`uR?3LAN;m2%Uomj2gqs*l!!#SZ:.26O@"J~
]]></IM>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="吨公里定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[1]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="16" r="2" s="14">
<PrivilegeControl/>
<Expand/>
</C>
<C c="17" r="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="4">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="货量定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[1]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="4" r="3" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="3" s="6">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="3" s="9">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="件量定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[1]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="10" r="3" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="3" s="13">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="吨公里定义">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[1]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="75.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="75.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="16" r="3" s="14">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="4" cs="4" rs="2" s="19">
<O t="BigDecimal">
<![CDATA[0.6652]]></O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="0" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="7" r="4" cs="4" rs="2" s="20">
<O t="BigDecimal">
<![CDATA[0.8560]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="4" cs="4" rs="2" s="21">
<O t="BigDecimal">
<![CDATA[0.7809]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="6" s="22">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="true" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="6" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="6" s="22">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="6" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="6" s="6">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="6" s="23">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="6" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="6" s="23">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="6" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="6" s="24">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="6" s="24">
<PrivilegeControl/>
<Expand/>
</C>
<C c="15" r="6" s="24">
<PrivilegeControl/>
<Expand/>
</C>
<C c="16" r="6" s="14">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
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
<FRFont name="微软雅黑" style="0" size="80"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="112"/>
<Background name="ColorBackground" color="-133122"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="104" foreground="-11642267"/>
<Background name="ColorBackground" color="-133122"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-133122"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-133122"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="104"/>
<Background name="ColorBackground" color="-920577"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="104" foreground="-11642267"/>
<Background name="ColorBackground" color="-920577"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-920577"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-920577"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="104"/>
<Background name="ColorBackground" color="-723465"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="104" foreground="-11642267"/>
<Background name="ColorBackground" color="-723465"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-723465"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-723465"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-133122"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-920577"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-723465"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="144" foreground="-11642267"/>
<Background name="ColorBackground" color="-133122"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="144" foreground="-11642267"/>
<Background name="ColorBackground" color="-920577"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="144" foreground="-11642267"/>
<Background name="ColorBackground" color="-723465"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96"/>
<Background name="ColorBackground" color="-133122"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96"/>
<Background name="ColorBackground" color="-920577"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96"/>
<Background name="ColorBackground" color="-723465"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<a7De*I%KW'mBW_GI-TV`QAn8[HQ"3Me-e&lq#j'k'`DZ`P5q3iC1NeTAlQ<"@&1P+1-!.B
=[mB]ANdS@Mi<*1H+!:Dj8`80R`6Yq0jFCa7&qKidJMtfCc_HYNPNQH<ll0Fuh]A[dl#S(d*S/
gp"QZU2)HY21c2RO:72OgA4jZP3t2XHo[^3)m1)eSCt(b!aUDPC2iuU?7V[&kX/ce\F4%1@6
l)D%'2Y)5;g/"_TBhMMQQS5YSCg%bJ+CKBbCG+9b?M]AK;fqTnRlAYWhDj\0g!;cbT&#96P"@
G_Sic78QuiKM=`$K&.Pk(tRlTP!O'AFd,]AXt2jHT)*./-Y^g#.Nh39'>Fh0!PG(Mnc49d"kU
d!'uI&q/MU#-YZ_kHa*7R>/^K]AD[U(YmX;R:;+^[h-TsK?K!En$H04!M$0\!4X7FO&n+eB]An
XN[(5UXOdpqQ'\KT^,9q':KgGiV5U<N<'5+MFG?!8-biL5dOmbPG<COOWWreFekL$&Z>H@s<
<*DACdAo;L(e;E<Mj?.@FpPEg15mI9%PLNo-Gq/nI@+/)\lh*3f+?H>jG1"o;6"4.WjXnZr<
VAf.MPY#DRr+V<'[sDie)^qXU?@oaM8B!F*I5>]A\=(*)R.J&&0_i2".omlUktU#U;pT/5Q,4
E[F'&(MFuDWN@OnA:`0@([0VZue%k[S:8nrLs8tdQ6Uehp*bSmiQ_SG`8rJ(2nT_FB=rGa?V
:nFU@=h'[!I9+fo6Y#R22!%n/gZ,8XDVoB5%Xg,:A0@&\"]AqY*&GJdk^_O;BRqiSY)\"FmRa
)+!j0$VVA:FEpi's:Rpf&@Sni,"p3FRBTh,Xb>H.sL"q<WY`]APm]AF965Hh/*s^+ja&&@:Xa>
PP14)N2d3SP\Ck[9i[f7gaI6CY$oBfT^=1(59qT!)cTO7k_@8F7%^o'EoK#"3>AAXpB\9'"/
>oBp9ogk,?H`Yfe75)iF19qRZKamI"HAVC"YJn!Ef@'C%]Arol31Gu5mtH:F119NEluhB;R`q
P^\@n?TG&e=^Q@.#k#'4Z<o5q[SL;n.c/8L@FN%qQpHe'i-mC%$.('RAW[+%VFe<7,;WmiT_
dRl=E6hP%H4_>iLmPkY$T9.3_TqQJ*V%)mO'BL^*m@&HhdV$Rk-bdt/am&]A7EZTSB2LXi]ASX
ZVoL`(a^-iBb0\*#2a:gHQ`FJmCX)XdMQC\gX.jA^+IEOG@G?B:?,+Kb-67[oV5KN)Gh1Ff*
]A^)dF5oL:=kqYC[rYU='I<F94!.ESKS)%rGD0`/suS?UnWe%YE/LP))ei*CHFbRfrIFeR7&%
0$Ak\?bOZ"ANK6rN^)6$VK\069t31Bb3HcKA'n00EoRXjE:Jp>+k<MlSHdbQDl,G?+2Dr5'L
pAYpaqfs":g!/'lB2-.VBLk?J,gOoEBE<X1Ha6fTF)fG1J9Qebf((93D-(/+DH.*]AK7^:H6J
Y>L;lqLb6p+W\>I/"Vjo_BHe.<TMWgelmPD&5rfj6">HRBDqopVi9)'H'Fm\]Ah+nYTK$_g41
p"laEK[I;e';m@hiMQV;3ri<M8'4FkV#`"Im751+M_9".(W*9[l&4!UkAUeai>c/<bb54DKL
UQm4LgoXS<8YX4l9`0iBj@]A"nK?Is,._!LCJCu0$,G9SfPn(e]AnB(d6uI>QjG*QHtT>Za:`#
rq8-g;+L+bPlX69dLu]AenJ(C^\6(`hn@c<3eI']AK@i-cHY%tl,?`lc)X8tA&UJ:4-JI"fJ+^
f2b#4jE<9Bj'k6B'LPgaH%G&VCh^+@Pr6fUEE6Ze`IFOgK_A).$1F?g%BHd^f>b="\Y6p`SX
=m/R]A0sGkMg"U9,H8V,^-PCsCZ*?`6Yd:)U_>@-S&N>9'iP8nIpKm;JL;s,U%HdQ*`7a'TLJ
llk<.KBe?F/7*%ok*#C-5uk99<9%iru./@Ei'ZC'kiRpdWt@Aei/m;ksom,8IhdInmBY;+[Q
dHt+Zf)mf)m`b\"E^b`^HDl)*6q%R*7-<#YCX`$9+S2QKP.9X6J%-6$VRKjTpPSNSnX7Xa;Z
hB:m[]AIeEpNHor&n1^8Ja]AE6M$ToH"$'G4If;JWQ;aH_<_gArH$!J!%q@OGXCuj,E`7R$H6?
e[Xf/4e2j-+NB?q+<Naa#F%!baDDsHO"4KGg9*7:`Hf"75907>$LPnr`hj+M[f^LJ-*a`s@/
aFubI(@FK_G!in_rfHV/Q_/%1'6UeModW`I\7ce>Y,(WO6q\(1+N)Tj4@pq`#fNn/h:Ml:;S
hK#./G&'h^>^:-I::QVP)1]A?s+$lRCO"A(?d`^f]A%6elSTsaoA3;24+F`KZgg"`i:u_X'j!.
Y?%R*'F5ma*hhKUQonc3o`.7i&kbT%ZO;)EE<)T()+Wg.GJN-X7T.bfg*I<-XSL1]A.Ma=9X5
Jm<G-P?J50ljLFYI=Q?Mq)9/f>0&0$g,,2h,oHE7Bp4KRRQ"+G$sn1mBmcUElfO00kMoV-#N
upLS8KU%1*'ROn!jEDQ=g!,7Wrabm6,.Sd'84(4$tc6A)V3[<D(29OZi<ZNKMn)B_/OIE#YQ
2V%Je3&[r1cTP184Bq5k[kZ>7]AAckp_M%,!SIkn<g:^/%Wm3:$?a@Edc81GLRi5GU#O==Q7-
dSae)n?,m/*Wm0$6nHM>_V2%AMh%A9RA:18GoX!J=g<AM6*Uq&!RWclL)N5<FPM.K<i5=gBq
MWO_K&+X'sGq(:8o-4Pt.[0,Kb4.!S(1*,*nBoFM.S-I.9Tk)D8H.ue)-d2hEM$=1lfO<d'$
0P@G;,+faEQPZHI5UTSJI!t^31:eSW=%,(cm[EFO`Wk$$\&QJ*OE<-1Vj4Hi@E$T"W5\d85=
_u=ATeS:NE:d'_VfY^TC3';H1$lMp$4b6GZ-aB7YjI9jibsKuM]AW.J?)E:F@ZbV!9CppJ*$0
JhSs/1Ds5'ckMe+Q40uo!pEr3>=]AF`P>]AU_fJW/(A;M-,T3h^lTh&hu5t%G$QWUfW(i1:l6`
@MP7_Rqc(>8J-:>.sR%_Li>>$+e=ccbS\b!;FCClVt-d$c<Voq78c>ObrBSX-+KS/+d.3KN@
+ruGt1#H7mD;`PXn1bh,fo'piFcr?*K_u8o)9F6C]AdFEQYp(^]AhID^f&?l%CDfea8Ih$8#j<
HiH(PC-Lg&'mrpSHtr*b6B69UL+`a$:V&9l?mc)`4btgR\7FFJnY3/.=X^/>K'Ghbm&crrMk
Z$)!,g2,>[uYPOqjH>%<g4c5_sGcf9m/hd7N;+CpaMUG$.5"P:%#QW[1TW$7@S'hZ&-Og!r?
6nXC6Qj+`rPkPjkE7S1.Rs8G/(:-o(MB9;)%8*FX;U3p^SX@I;OO4/)g5T>ngf"JZ[LCK1bf
DN.fP6g,Lr%S.Tl]Am2n(kkmrEQ4NU_"!Fi-J]A,*CW(>P\:j.b^2]AaR\78TT5l9nWSLIO/>`i
gc4tGn+\`,/boE%?*&(j6J"L%]A4Td,cX>,Z6BHYrMEUb%OEg.rmAZDTe&,3/E23@;k,c[JnH
g7`WBCd_>$@$%g8Qd9H=q0gborEsc0tfJ]AIe#b]AUDg*]A6H,PuMUA.MR8CZg5XP%\!aU8\G&/
K1fs?ta70Rps!_j(V0DF';0Fd`.eJ80iTl<MY8mI8!5\4R200::iUa2A^(JjM(b\G:kk96og
P:>mH!5ei"#]Ac>$!5au+1<>MT@%2u]AZ0cGBGoq:14Q=le'',S%aga$]ABr%O,dW_l!rRut\'S
Qo"ILsAOo^+s;F.Mg7)rCXg.@:52@_of5Ps+GP0.>=5Uu,POLtu2<$R)Jf%>r<\rHk>_::Nc
$nQR6(8E*2h&m\ffkk857l)1c?P6]A7Y9#tnp6Baioj`ZOn(-=TdJ]A7>>8D)(:3VH[SJfHijG
qOEb_54dHS,uu+Q.2Jj$sU7I27PWMl:^CG=YB&/*4rsG7,rqG))LbcoLPG_"&9:<?bL\1D%G
+r,b5Vmf.=DMF$gfK_W)XGre*kXBcDRb%W^50Ka\UFs%LsTBnf@Ofr!s<U5)Y?"3\.290"TX
B##2.(uA`L^3tMEM1;,KIN?-l:qcL5_mHhQ$#Mb=D5SJtZ>?csW/crEh6G9pc<7&]A8H^/pm2
lmd5V/1"[&hP!Lb8gLh',hKaj)Zj>d+SJ8\8-R>tMB/DeUq/P^0J=V4o$WI6of!&cLbBr#B>
Z(_iN0kFF*cO^ZGu/2-1h"11I:3ArZtAC]A1D$<=HTnXp5g5kL^)&1:j5LCW]Aj&0T/E@T_%b:
=q3NT1PaS(oiop=J+oLD^P?+a>+(P0E.Qem%l=B<pX_>Q7M!6`X"-4D_mIuLUk4#M*WNO\_o
g9rCg<!O]AWJ,<Jo]AU_RiWZKRr\:WrJ?<-?J3op4@\4<'SuZEeS?:ie>5dAJsMQV0>p*li4a<
8c`)#2Bu_:JSj@T)mnsjjSPrNCL`idgisW=OaWrPT,)>82/U-`e]AdFM-e[sDq'c*m1^h6VD4
J>@B\ure!Lc^=VH9;!Z\cQuj"L+3b!\.P5sT*t<i7cP.d<&t;@k4gRsS5Kr_#A?Va=i$,rOo
C`Q&2:1'.&K$%qT<Hr3]APPGERPo-\CJcu)Ko8LG,X(C9#sAEDnOg_p!-,mL;SV=D`XpOKG_q
D$P0l:i`]Apsk*F]ALu5/q6,o[DgF.BH68A"?O.PUq?jL_@Rsk8idINX--]AVCB0'-[fB.g,_U,
+Ur/F7PW-@.p-n&B6nacC^_MD;VHMq=;d0=)I`DhqS_<HB-\V%4&P;0a*\0am&PX_pUL`SRn
DF0TjBH0buWJUJsP2<Ce5NrN"3ejT<r:67YJl;sh02Pe):sf)l7@F@m_-jmMYc9sF@9OQT-P
8,An)"i/'bm4(os90b:S!9)1]Aka;TeO`qi<g0$=jk9`b6(Tc$8,Q_X%@u)ML)AbA:giUT&fe
68p[EaL4"T/PI*sI@a-S`A`$.fYS!q/(hC%?$ZBcsHg;N8'j^FloHeB4nD?/2PIXW!q"9+'e
!Xnk#%#I3=lA.`J*sfR%c-]A]A"!%DLSQ-QTTWGcgPV1!t4-!>D1H`\&'g7G*2'dD=[Bge1m-o
,mJ4e+g-fYEF7u?rG4-P's^?1)SAKZW#fei>UhT@:ddlO5*d[M/@jiAPe&)YY_Ns_?<-E]AHp
laCkcMRs_a"c\di5S>#VOcln0/1N/;#Q"4IQVpq@V,@Y;_I>hY^T'STL-/7CltQs.-RWi+Y"
r>)#j93hfL]A@WU.=en>>WJ3PQ;,o5Tt2jGqQa6`e4@Q5?(?6h./W*YG$WB$bKb]A*I<2(V2VV
!26k/BS\^"0Sdi0Eeu_#]AIZ]A5Na9e0ne[2R?/!E60+M'==:suYS7Zo.IS&sPsqHoC\OJi8_`
i;WR[IVI2-\ul`/]A"2Ab=RB*V3.gt'bEOmL,F`f,!\S-mZ-Pj(orGig]A^]Agg1c`WP_JMD%-4
JqX=o&`Z\sL!9)*BI0XU%C,>s"H!N%EBKSf0?N`J6GK12aTN=UR$@L=D5PsP'!^,-V1csF/O
o=NpUQcDF1@M"s7"k&0'K`Y4;^_Ih"fd_QRYk%cLA?sl\0fa+a@FL<HY;@MtF?o@X&XB]AN4k
Sc^E+tQT_(2lJ&>Ti"2TV"ta4kjeTOOJVNYTO(d'!siba=`&Z=u?B&#,gk"RF!,f!+N&@b,V
19pVG8+gUD[S#jRcK?aK>p/d^7OGdiD-OEa7\(<2^IY"`'*g&Uhf0j%>W"cPTAh>/'R%oI_f
_K$c".kE[mq7t0H0@CFFA!YTc:i#KGVV`(+&\RIEV_5jWCQ8o'!oR_qh8ACOrP2^P7/"Y(TF
Z8<7U"N7k`9qi<Cnj<_^C`da368!tn?6'-QPF`=6M0.>1W5"[gddo3p\$?lh3YQ09[qTrb+D
p<et%MlBAM!Nnbg(bi9,;c^AkUmauB=3N[k-5D+;B1Xf[=+Y<i7K<V!4lF'8#?NLoF8N\$:<
f>l08NC(`5U>MI6HSd+ebLk,ht!<Ho1D+'MJ\g<[!^]A[ghVC*)un[OAf!:_1gkUjPikDI?l4
d$o",-=7R(:fH`46MF^WnWCV1SHKY[I/W+J/8Zi%WrMHGLLb3`,,Wnl2#*EB!,mG.pVgp<:N
0!QgX[N$oh#9jn-Fh\u7OY:k;7HaFV$GfiqGljVIRh"EYMeKCMTEkX"[nQRV+olT'ngY(#8S
F#f'c,9c$WOjrL\3<`,\7uHogd&1q6PLBc&T5XR&"nED&*_MbABC[(]A.(e03!^<LD%q!AUWg
csLmf-P!G?ZD976'WJ0aVQn)l<`s%@`?f,1,hSo6A7_U1gWo("h=5>&]A9q)Q:l%b5K*d_I'K
Ao`hcK7C.13f/?54efUuG`FO+OKD_`WRr('KP4jP:l:E1E:FkcVr@l'hk(G\:EX,fKlG`cu2
drk22Hb!jtnUQi%$;pa>[lie;Y+fYO0HHK_>f>af\B-apRro'#eO:eDBHbE1Wa\2e1P#@%sa
+W<V4P(:HGkoF<1?=`L#$'>#D:K#40.PaN`MLmX:30Qm(uX3BVatGeaC_P[$4I@>\8Mm`C?'
rCbHFP8caYe<I3P0P"Q_7kO3+N.=MQlcLE)#s2.4/cQ!$gYj:J&I9):9.W9U\joJJ%-SuS]A*
!=hBm_4_8_\"392F+_b">t54Iod/0B5Um-:.usqmB^Ua=N"&6`51/`T<QYgS_W@[\,d8$/W.
$bp3MaE&hotar'h=/SNE,!2`s.3=[^Yf>lrI[?JCN*TckQ$0ab7T;,7icXG4NVcVI4soc7;&
T]A;!%)X^f9X4F/'7XR,@lY=ZqRF[.A-LQCVt_Ro?n#;"Ma+BjrR$16"5#('V1Rrk+2;nf$5D
'o9J3CAOI$FTHph2W1iYd0To)5nHej[Erc2=<\2gdnhU=Y\5R1.NrQa)a&@Oo5BD^,-A+W25
E%.sX'24@6@KQks%4FW;'`b#kM?-<m%JQrg]Asm%4tuJ5P.ckKXTY@(\g%:0p+dn]A3aoNUaOX
',W6sUnoCOD1`jBOU]AFVYRj8(L1^ChL*ANPTl5VY5]ABNuXDl?.BbTQ2<"-LKLTsHa^=:1@UA
WOXhmQ1AkmiPdn;cSMAQ]A0b";I0<cf"t+&qKYOa1T'o?mNkN0sUVPk[Ou4`FXdK#InC(Am-"
O9,l4'TdE8C&qtHA0oEJgW6MnS5'tti8Ru)!Up-@qhu(/&U0)&g(uMmu@8UnY['(!*64C*[C
^LWj"Vf!'eH`D<0W)/*6cC!bG=XnUmVNUBE'dbgi1;gn\#+AY*q./aU=\\SY:BE:LpcWld:2
YlYN@_5E,m%"IlXm\'$F)3>O3R*rU(F;_7?l%*Ba*X?')mO4sNmd:#r@RiBc'(0Qgjdjm[^R
f-d^/]Ano!H02VT#53r>t(eAk6l8M<PT.5)B,-u>H@u`KIG9k4@QMjQ&eH*sN>g<l050#m,S@
AIRRNII\A^?&,<*mpeT_84_@S4OK_GO2<,DU+VIcZtTa@>_-cm(G#G\n!-c@ZhD1FM(hT)&H
Df6FFAB#"'uN$s-O&LeJlC_>5H"F;>mB>*rFeG^Wo3ThpHlK2UN0DVe>!7PrTE5;Q$RB0=V,
7pRA3_"*5Rq(SGO=(."CGXr"`m[1-bS@l&!f0O"51AeCZ71#Q$1LKCZ?/)]AbQ)f-ZJigP!.*
#r),Q^/d-YO(1)I*fc!'_a]AE\7N-65C1&\Fn-WHd=doRk\QS6+%$.<=HTQuk&,&f\kb+Vi^h
7K&Q_d$Eo[Vb[+]Ah7%/SgZ_^,_C-L$Qnl$QhDKFin>=cj;4HJ>-TaCphsY`D"6QaWS.nTidl
rpr6G?d4A0R^r;]AJ0S_r"V#S.Ci5K<9@a<f-TCTXZD4JUG.F2)TT\gu)r'7%?Bm#U2Rb8L7Z
nTR<kF?W-K%CIEd[:c^0#EZ=FsU_ec=,*@!p\Ok%SSng^f4AK'ec+hW[W'kJs+oVh,_$WIKH
!_gULHT1(>%qXD2]Ao7l1e;i^b?j_+_ScKZjd;)dk%\%ciV@f0;kQ%",n5gOER&cM>D!^=[&'
.16NVIm8i0C4j)"5949dR*1V\@BK3U(bK]AaCfFU19=6"(dYmZ(Ii?T%:#*%Wf+ma*ALZhT8J
J[6+jWEA4I@Q,.*#0K\)N\6T>YZ&p,U2*5N=hfA.,'#C^a\@sJ4*^9s%o)1!^a26XMM_26R)
l$/[0Dh)B_E';JqItD[Ra<D_U9Vh!4ISMr18B%7oGqXd3=71ko9Ko>I+Oua%<M]A2THgQDnHu
HCRkJ(6]A]AmR9FA<O;+WX0q\IRcor$Xmo;pASe*Q*t$+%J694j,D+WW[hccIjb")24d=HF2nJ
5DeSTj=gj%U?`%aB"/kEXIK_43Fr@#6(h1T?9EJ1"p/=RI(<2p(skt2#J1k.,UtQ`>^pdF&O
@0C.bbJ96n6==W;%2_.$E@M/aSYMGj^UX6Y_q8ECnoTcFDX#0P@3d`G%[drfqWA!9j&[58Lq
7!]AT`#u_-(:+=UGOh7DJdCka4:ClaXNTjjJ=l9X[E`6Le.pn&*?&WIDGp2C"P46=oG/#P_Ob
8Sk0!r>_F#U=mn)hMY+.?>qiLY#/UnY-5PVBucpcR]AeX4HZ3-,5X1r\!p0c4=\e>J(d)Or3q
;3q^J&ig@5"hrfceritq-1'#lu!s>n:R>;m$9toqqQ`NL@_0MD2FWKfbE)(__hlP*-SfqNH!
36jPdpr*d60Kk=7dDtXms[[EXr9sGYO.hHE"=ism*9YjqF+0-S(VBfc3.dm)#hK\kMc"4`u6
Vhl)ruP$s.lsn>Uk>^sf!p^UQ+9W)gFJ&9W.;"89_fr?&4LXA,WYlqVWPFEFDh%kN(6T>1E;
%%j!I4oC5(2f2qFWHPBlI/aR<:BAh/N:Mm;#'.&Em0\cGP+f"hWbm-<gPLs]A\n`%&B]A"+tZF
n[2QeC2KU7$0RU24#Z.enU"`#uXu7VkU#0Ue'i47G;0pLP%$(O)6:m?XTBN9X'Cd7s:d/OQM
C+g#aP<N#EX1+5[A&b(Dt2Xm3QNlq9tJuX_)A>se;:YX7`Vt):bBHR4=(IZ?Q,-3EiW3@-&A
0gfe6?V!m5V:4rg=P'+XGUh%aYoH0mdW4oa-9CaO[)N.YtatH`D$h/p"'4><5ChM=8$(!;--
0;RL^n0<BI>GIA[H^qLK<M<0PG&TLc8?Lk39L1pW<;[Er]AV\!*KU1,?O/=%*E6\!*C)fY\$-
bs;9m+3?[b.^FV3L=-K(Mq9D9cp'4g;o!1HR)fXiRp(.$$]AVH66/:F2odafS+si!@j2mse,@
NtQ,`GY%?1U&LW832;>;tWKD]A@I&'R>CS&d.CpE8?ZjG)&*9jui%0P'a52@Ua039*6OfgX/Z
?=^*A*!5-l$7&2#Lhd%>Im!?9*&GUE8/6n8ZK.dRjM+Jt>7s6DTUU+,&ErSSt:!Z=K3QKkh,
K"RS)De@VUk6/`&%;0/N5cWXg*D:F??&+1#mY1\%lX5s@cY?qkrL(pZUAcU`A]AjObS1U,5.r
m)=5!/[Ni3b9$6:q)0sn6b!>>(:"!&;""%l7u>c7.QcWq>$`TiR4]A^EhUEKeinijfL<1@E0*
:sQZ*71uXAaUs4tk`eO;V(*:-_e3U*j@5.X;#=]AS'G`SeNNpY*:&8O9i5d4QdY5YOQ)6&COh
N<EP_h<T(-(P8e_8B)GU+]A_=,6!S"YbkK?H`qj52YMKP*mjeFM_WVqO:5YF,f;:0"R^6Q*5J
Jl13NG-R!Nprd37tdq416A"j\WOiu(&FSftN*,dNu-ASnjeIcj$UG2(mN)!Acq;nsU'+P>XQ
^7LRWg$6^(Ha]AdW&LhL_=!-CQaI<Mp#W_X>u2GF!.]ATpa#rIkNLIZ(RJ.F>q(?pc\#/;Dc7@
M_guFs(phU>EX%fs-g=tdE\j3C%ZBLN9TSQ_J9@E1ec;Rcu9PCT=HqoT5/"F1B3f2bp#@"XH
!q*_k9b)g=Fp;&D1Ssg;D1q=aJcOIU'";a3m;fe(O!X<.a)-S5!@ioamV&Z/gQ,IiB*W[mfu
NbECcEuZam;;2@\5V_4`2qd"%u!cQI,!YOh_g^Ae$dWe/*G>hUXV)G;NEHo.G//>du\h_R3h
/E^:uE.^)n,OS#K%2cJWE0"g>25)Ffqp]Akq61IM&jb[oQRh;?SMI7\-t(<A164EosWn"M?+3
tFt+<DfQkSMA5]A72I0''[d(hYE/Of'o6^A;3qd$:08*HFfHmcX6_#\V>8lU'416mqaXRk.FU
V8I/LGd?):`KXpgMR4*6aGIIn[7$Wjj'Pif&8DYqS"a\<>#aaNAl@N@NPQs.3>'D('HBa"R6
"%oU(I=`Z+W;[bjBRYZj4,0.R^VEXh5&l\J)RNIX8D(Zm1&#)EEnV.mo;3J,&=sm2og":Qb%
(PWk-DPqPkVUU!t[1Dg/m3R]A's7>N7U[j!,-E`<3QN*Z3%@#>I-B<l-?rg-'D)"RiZYDa?^:
sYOH@q>sfWLH\'kV!:9b/.Lpu0q#nU%k6c'B,F:qNp_A+E-4rj.2'S%p=G.tp#?OT7PIZnbU
]ATrTq..]A`"qig'[Z,$Ml#LhL"*piiju@n)I<b@q>]A23+$7GVeYt;li+I0Vak/hcep`r2Z_D`
jh5ZU^jLT/";#^l9tMeRUqdTsh0YAIVc.F>O"PC1[_]A&l?lSYo642uBOI$.eig2_GB#.J2_H
Y2FVoHufT1.$KLj6Fn6!"kA8c+%VeE^'C-u_$(ZaM=PuGXJc1C4q?)BP9NF+ggW$)iKVWp1l
i"REr8T1*.PJXfi/cV?!q-ke,hQ_>Yjk7TE`_*r93tj#9`Y?nDRA,\QloL^0m6-W%)Yt_2gl
q;TB"*M51D*ZcA;,dbOW/5R;T=lIlnE,^\[K`TR:AqeXlNLa9=@`ejRFQXr`34!KQ%r=6Q<1
u>gI[R6`?p1FWf*V6=k_4PjBR\BB)CiHBLS"S-'PLi(NXr/LL,EI9C>j'hSZShDagG%Wjq*$
1Djk'98iZ=s\#X+k9q3U2(daeUp2CeRR/+&+<OR#>B+[CHuFV?fB?a$nX\Le)CX1.S1(>b'2
MYC,qCu1:nC"d+^`++K:hE3B%A*tV?+!)em)Kg2OP("kl\oo?&GY55T_a?OVPb3dA\8j;gU\
"A\ob6W(Z+]Auk"uB,ln?OQ>UotmC]A/sn)GNFM.!]A"9b&61EFq[-^Jh8;LgC?28'q5:O(!l@1
YQX7@T+lEd3Y&3F97qLG_4QHBNi7T08XN6s((B'`5YGlNp@F3RS9+W&&^?)Ta5]AFFD-^L;MZ
@pB08ip5VTNjbgA0EZB?4E9mjf^2*D7*F58!CAI(*`BsB(Kg.>_\PW"FM=-VcY$QXP4J)2Xn
q@'5/,BgjQ<,b;=A2_"KD=dC9pmeL@#c1fp"m+>(ZeLg>74@8fj.=Y)%J8u#Z,U6Aq[>UO?D
b/$g7p/2^$B[>d_+nHB2HK]A3-$\diqnX@[]A/iduC>fWjI2e-V5SDM_]Ab9bjKE=8<#Z@dp3+[
"l%PPNUlo@WbG,TuR-iOeR&#<QGplu<NY\!Z(2U"Ho%hML*P]A2W.4.D7Jl,\6f"_)t?YZ8RU
Q1`)hZggI3=?<70)+CQ4+Q-(+JY[lcW!fYft30bq]A).0=tAm_`:HnkPB2o2jILpJ^$3u5"WG
k!8'I6UQJ;WV6k/2&tdcEQXS9PfKKVA)a:1I+A+?G5oXp"MIa]Ao',%C"ar71moer<u?R\V`7
3Jei33)S.;9!LnNBZg?r;K"cQ(%lg.^?jhX1:p#:MH_'!%*NIcflm!q"GNn]Ag#_t\W<>qjZC
.S.'\GRg1dY$Z2L\,9fA@d'A[#*K;SR`m)nmS&->Zn)2lR1dGQiYJlO]A5'6k?JjHR<Q$6_"B
KEQPiIuOk5K[9Eq@9Q[S-62YX`lD5&8o!2]AX:]AeiANQ/5%0eT)(ah#jh(AVZku.W_(1FI@R9
tD8W]Ah\&+3`4o42p&+*ogr8a)>Z^#Z<dkN*mmmkC#.jKL!BFh#Lg:X<C4/_fnnIBu/P?$aME
5n#iR+Ir^dt+-\%mN8A<LLnb5]AmcR]AgEU#Dj;2Ti0`-f%keCYca0%7IGrYFG;<[[>)s27eeX
(tjVQf]A`k*PmSO%+=q)jm?TZ\8).9F8LgCdAu@8J"$qni2Ep<?Vr9k@L%[XR1*EbG4(;H>n[
7OK88fiKB1,jC[ZhO,P%#N-ZOS)5__r`4#YRnK(HmF'E1>k:g"7;]Ah]AXT8^R"@"idX=g(N2R
U<a)KLVU=>bB2Z;gJmi5O[0?)(`\M)!*,rO8h*E)!4sHZtD/Ea=b3bSR;Aotj.R#(+MAI>!c
W"e\2IYBQZ]A)gN3K2-Au-\[D6A8gRV]Ah-6Z4#%p!#n[H(jps4k/%.fkPLklRJ3m3^6m+=3Q+
%HDE;d$Eb*q$Jsr0$Xo5BP-X5pB$S'4tE>q*R*`=s15+e)FCHCF6R!Ni;LA3n[2;Ze%!og8`
8>h\YhK^Sj]Aq-&7/.p8HR/>pGt%Zja(C#If.jRH,XB7DDrTfT(,t]AH?R]Afipb3q"Dk_q9r8f
k@s[Rf1c9G-!/DX2U)G5b-dZl=B;prn=/o;]A'VmPReb-RL"FE!C""o,[k0q\:9p9UB^'UW4A
7p'rY-.DGi.1'+;^sQVh2Cp%_<KQ,TLsk3"6AG"dQ'Vm*iK8F$mG4Giq.XS&eb!0uDte99L7
Pi5n5l^@hUAHfjtWhS`"L]A`s/ME0"r,GCp\ca&o7I/B;r,Rk'1+9!c:&0sAG6Es`O6*IIsP^
?B-JHciAI7IWu@rV[AIE]A?`+E2BPpV5)!PeLY]A;0'38eB7\E6)/]A@O!Q)-j=m+0\`i?2D-8T
o.D9URd6aqnbNO-8J6e@WFf1ko[K[p6GNJ"EAgns%R6=/jFkeWa>O&GCjh!1WAf;k]A(fl=TP
@AACjZRMm^fEMEM;VLQKTfjF1Abb@h]A/f^UG5r?Ql#7R(dl-1Q3M%UZq<?qM8&q.8%SuhjH"
Om6(MPY*5$th_1m[Lfe7O[Ha5Z"C8u@4*kIa"[;^8d15i_t]AJrFP.g*?^emPQ(MNfFrnWIN1
@:3KV*l+FD[7KKB[U)%irpmN^3IGtZ@)Vt7=?>b=sF$)#*(irIqCMkD+FPaPaH7Ei(?<Bi42
^+B?l)jfC1;ffeM0\'DG=R*,8B$m=PUY1u$AJ3KLE#"LVJ4fN#m=]AcKuTM$3!Ab0=JKfe%7#
T%AiW_*p5\`Y.n[g/c`io4q<9$0gL7`^04sg."t!s;4isfobQcs-nLq5f%YNC[T+K/-\(ggA
2_`o"14-Dm#5`8`2`lIfLQA=1jM[[)^]A3ptkqkG:<&saQq&t)L@WJ%NC?j-L9L_eGr&5+`b]A
6f&e0nq2^MO;J?\$8]A5j2R:WFI((QhB/a:S&U\fZ$"MH)/+.R9^pL48`^PpOuf(95=Hu7+ul
B$nTB;,ukLt7W&b8;YJl)H_W:B8C@duD#?I0M)Sm90Dl4;pV$pFF7u@$hAfaJ:UD/E\UGUM0
0m+$Xe\U*M"6X_?._&9\*5VT;h@+&P+'5eJkgcZ7$$MareAA"B,NS>FVe\!G0N(HSk8)1TDH
)P:-L9?&!NHs66+b[5*-tKC`f8@*,enLMncN#^!m:`=amF&Kou71<k3V\X8Z9S)`@>Y&o>VM
nC70oeg33H$b<s`ki>*jo>Z[lWlM9\EV*',9CNn@Hbjt3Ag,BfjnCkB&Lm:C"+G,+oqi5#CX
F(fS3m;0ZQ<&1Y7b:i/Qe4s'JiluZ$&9\4V2oC*)--7!5EOO9^shIpk2Z$^B2^n!@##;0l:@
j^r_q_8kC*MVsSlP\o5RkQ#4XA62P'3\$8<m4A!%=p'5&FS4]A$Ld6DbScs1qXrFl=#he8i;@
l#LVoCEgks5!>B?`V/[f4*kf10k6.,0)B5,HMZM[<0_4!bQ1P%QRp_3cmMB,U?FUJEgcqoV<
-p^k'#WLgr&I3]AS:E+eaAPipgQFr"UET4"n&0bcar7fn0m0)10!1W]A5)Eg(un!ef8,d+41_r
<uh7]A.FQ&+^N8_adfoRIBB?EVM#"5VS6;JnDaF""b$icC3;M8[lI%jRoB2?t8AXGl7sX=%Du
Epl86RjQ%BCW>k']ACa`g5qCGZ`%3mi!F\,?6RX(6cn^=Y]A%k5BVH@6a&)!nYQ.*"Q=SOqIeq
PTPb+o-38UPo;H_[nDp1EUi8iIBVGF+PWWsl4F?<P/Ci6a%H@3Ybo'=34[@r"CIL>)p(?3?\
Og?MWT,E,+I]A3[l9?$a><M$nQDI0dpN2f9]A#GFR'9)fT`.f$,,B`2,q_rGnk)Q$Q4#`eD_8P
spF7:d[p]A^XkNg5t(#:XUsD$sOR!i.n>+.@Sic@+Kf#6;\!Cr!Q.8-U<%,2E%8e'$(j^^<-]A
Sce'=PEucLIp0aP?N*la3U4bfcS<8NK),,$Bs[R3Ku.\.Yf!X>e^"$8kFq76/eo:Z.>5Ys#\
("gKQff`"d7&;F[&G_rYl<8&#i3^eoV$BrqY%<*LooA,`ZtZ]Aj+:]AV+u"%B4Md.qrE?t2LtR
OriZsl#OC+$qhB#CQX45\?H7"IEs>Sn)qH#.2q$\aQ(9lD'I.;%/Shk9I,#4UQ<>L_4',"9Y
jmU:Er3\ZO#nFd,GKErYc\m1?)A"h7=)$+WXn#q!X=k0&D^@p4j1e)#[>Esl5h1s18_+O\j!
U,qH3Y)3j0ch_&n0`p8QdDiCs\)E)n*;T"]Akg2KK;E2WEiG*ci;:EbfsK)?9Mu]AQ;Sm6g^@,
$7!95!iUl\Bl:camN:2b`g"3C[m1oPZQohAL4H':+&;3jZYV\>W?nI(>LXB'_R<-D[AQTgV_
J$A3o4c[8tI<@nD-)5_A/<oF+NAdGIdTLJn2PE.[ejQFpO<ncn@s$fF;+2BN\6N<R^[;n#^,
BOMBP,\2i.dd7Et?[Q8n::W[:V!oJPec.f>'%Y?mV38bj?]At.8khTeB&?#)Q7h:J'7Lj`'i(
\?lc=_/)D?`Z^9M]AYM&8TMp0F_B[<P6hR@R3uDW%f@jR-Aj\.A!k`kbnD>4s(SV"ru.Gfm3+
-)+@"3cAU_P0E?c*C>+I;=AhB#!>aeS?>kIRK.-MNKZBlm"2.MuDhg<R5knncG]A=UGK*-n&R
BqR(#RU2]A(XnMBH[3-DTU3sb*>XRgJ%p\sn?(lc4bYm(Rd$uRVaP41Jfn_%0\aE-5QOuH'bO
:X#jh''9kD<\tJ+@'u#um!?j3UlbJUgHn96DT><Z9X[SR7<41WSI5!HE>_&p9p2f<dl(k$#m
!,]AleP!_QGP2>U#REdOia?LgjDBip_Bm7s)u[d<e1M`%,-d#TL!DdXD+qs7kgWI:*Dm<q0@J
)L&X-QN;i<(ei<mbcsjY3O,;j?U_4eSbklQp+)9Ir0t=Hfn?aF\`!:kZ2[)1`G8cF7:2Kg*r
'si)^kYMiDsio3N;Fr%hlrY@.5C3;AMfRTg6"kd]A"Z#61f0)#nC;jF=:-0dt2lp+4aPl0@V7
fAKd=-o$`pq6`9.*9S"M!974#f.5lHmJb7R98d9Y=f2,YMZ5AdI7-0=aB>5QK`sfJ-M*7$@?
q:'UGciCU2-jBXm4O8n(I`%m82R2HC>aTs%hIKq9U)1D&J-"g1mZAN+9/^g`Pm1=K<oPa+JQ
!#]AAo<=K_<>g2:dG9o;I9`[YuBJ:ch0aO5(saaA#='JE6#jo"KJ&3+^ljo<rTs/kV9j*Z1J0
#EW_Qn27o_XS#qF_9&7VY^1oKAOtH2=AF3S+`TKBA#iInSGs?U6/jKge!0LT?$_9T;nKG>#T
b&>kb7#Kr^cA=Fk`3Fn!"<\)\argF]A!qIsue4Y5-]A$*!2;c?ep>tZCT$:Y/'tLF`5CQRG'c9
fYL0C9kKt#qTGa(q_^;^pAl`9U't*IU+>?1$rQGZqA!(^W#JJWpq-0I>7?0";ZXh=g/<hX02
bA)VLY=700'KW`%Guf'_HhjG9:\(W(VH<";7o=SmD2NIJ&pcS%nkM.QEEX%A/UB^5.Qg'UJL
/K3-4sN31(r15qaLK>AsDk7:>nB0keuM41m5elh'#2)KIX#lfqjpS=l/St`Mt,-PMbDq6!I3
bTRrl%2am2[@SNU#@_YK=eH(0Cjel1arj"@0Pb"OXgU:DJQK:95:uTZ`,sdHnZVV10,E_B!E
)8A-_1Pob7rf\as&COJ_Ro!#WHQi-gVFJ,aCpPt.s!'Ed%]AaRgi/+L@?*Ff;e@*1-j"Q;>89
OX@DTbQ+AeSSt]AI8>`ApbBCm<8&rBZSQ2KV8"BW]A<!-C`&)KA0:0r]AV^[fGoI"+%5TS`2]A!9
epIpsVM8@>b\ZA<'%`!&f/9!9&Y2!siDKK<K*)_ACIUgb:?#nG?m=j4*Xc")6Q@6>u;XP\W&
K]Aar<[b1?$-!P\+Lijfn^/:ZD69;*f12kJ"dqW$;*0Ai8CA`YZ0_`/*bX,@R9UYpX_6^l5_r
u=/,'",@F!_UM5qW1dFN,K4*.FU^&%*oZirG#HM.kHBA+)]A5R;0iu'V+SI[U]AjL&B!W5DfZ?
6`&S.Lh3tU)rBe8TQ]ALBu63#;.!K6oi+d#j:1.q=D1hYR$[/b6De#&AA260@C)^9>7$Q78rj
*Hp68kT%nn.\jOrLMu\;A+-VAbc#7^3Ob0;RSGY=.?+Y/J4Gf;%gVI(?ONO><XTH]Ao<BFcgW
`2Up'-M/^KfD+XFuj6+)g]ABWh"#LPAsSWV*1H^KlS5-#fY24"/CUP@lJlTU4N17O&P=I9Er9
/LskV8U9S9(3(5lFi$M&=VngG)3M<"?XYp+:1#00(5oVZlQ685@09)AeDr^d.6e/*la@:k%K
!>[/RN^r8#?i4nIQko4IeZ@9YlrJ'f"FB"ELVNl1DX&e5!l2;VC>8CV3ZL1Y:*F"8f\^g;h`
TilLcte86,A0oVd`4ii'Y>9>`hNo1',:>Lce:[#5'^Ws07Q7FQu@k!-su##]A4.VK.5$LI3>7
62$USq.Q$=:"Gli<%&Gi=$WO4JREhd!GJc&MkhD[jk=$A9GhR3Ll//Rr8N&uT*1Dn-u!2gS/
Z)[daFU>=8RY#gt^0JUMnfkI<Drn^Kc)jp^>$UnhJQUms)k<AMjSe`r\fBh5;ebc[JUS;\_-
<S/%;h^[@@*S"5E_@pMGk:FFAKmDJN)+p"Mrao&nB*,gV4#%S(4&G8.nkW6t+/7oNG_R_c:_
"ErOP//i*Z`m^gV#/hc1:2d,P#Ph.;ZD3`,To=/,?>'^`N:5M"='BjqUc>N=lTnp9K*gr_I\
&?<8W_B"_hib;L]A:$a=Bb8k^Qa<oZ`n]A`3F:ABaFE0FPMVI-X2NYRNse!g/OlMApuPd+OG0I
@_`>k?8?i[0uEf;Bh[dZd@K$Jq#Yq^5+N^k&sUOse>:Ch9aL_[0`%0Q,JYd%J*Gik:pZ+?qj
PtmVVQ8aq\db]A)C]AA)(jfsj67iT9%@at7(BbhlXr+HL]Aut/lc,X#4E)?Qj:;:3KgHN!6XU`(
6C<V(KDPZ&?2K&+%>RBu@=:aN*bSd5[qcmHT"Q;>A67J5Sn^e5@fI`rK1ms@&Dn7`+]AUP>pG
Hoem*nhpT,uh*>*G(KJ4;qLs2kX7BiL9L4JiW[8+6k/=FP6uhXC^,3j:q$R8gSVE7"7^AIql
tKoX1YF&]AAG^*AniRF!b6O(L.P:Q47%VX2Im1h/%&L`Nc"r<sfP%4jM8_j#F+VFB<D)e]A6tO
-SN]A&`1:S@)NG04Fl+c5e>(=u+"PIcp?l\Jr=b]AkqOrE-X1[gob6GQN#C5p+[li!/*J>$QQ+
LJWkB9`l,Imu<+FILA!p\p8;Ql/Cp:o,ne?\4"EAWn0B`&4h1X,4/-DcU&b]A"Z-^i23!7#2h
Pk1U><QIT7,8QgH1T*Z`hP41qGqFq6+XD3Y3hGl(3]Af=f0ZOGokZ.Vn%)73FV9F*NuA*[irN
9U?foZu+T)MsMAba4LVm!\\Rh`VdAoT*(tIM.\BQ#Qbe"TONWQOdr8X[W`?nhTo;]A+p@dFKK
l@XGWO]A\d8W%J6g0B>mi2(3u^lj6@Fc9\>&Aa7l^ng8JYgoj`s6&(Y>;BLZcOpg/J6Fm^hDM
?,+,cLH4ob<COAnj4"&rdEA`iDen]Ap[\*Q%Z>\FASj&a2)s@0fXR;<QXA@-":D.U7aTNH@g&
<(VSUKSDd2sBC?(o.l_Ub6I!of1CRYu%oEaagWO9IG[jq:J##sjc#q;Z^["C9J[Vh-N>#B`p
S`AGWNIoBYQ*In'n!\<]A[M`gQTm:Yk%I<tLf\PE[hNDt4c.n`T4Sb6CNeENM=^^H10Z(/t/l
1`92`BduGKCIp%^iA[pO&OKQl+=tKdsd-!A^u92Ulnt;je&$55%a;?;^/e9?p-dcp.8#[n_h
O7F5f*EAd['$"Yi_qPg8d>Z,1CS.^Ma2=Z9q[!:Xh#.]Ac#DefC5RDTr42\eW6MFI$PN>::.G
Wim3saRe+KE*$R_7To@Fa(#-rT6)@M0nT7'\+A(;`;^:,)L\gp\]A$/\"&A"LLc9dK2fnep+E
qu!#5Bk=1NE/VbLG/_9%)-QLD\%A`/jKD!.Q>f3i`IR/Tr6[FMS_&GlLnE_<^@[lp,&&qGKW
;VAOoLNF"_B@um`[]A6sn)IFsCrH\d#qOg!2J]AX-8:fPLFQV&iLK*HU57j#j\]AWaQCQCp>rjB
]AKA#PP)Ff6\1<=IoJ3Rc0YO;>9CW$Aul6K9aIaM3=^I0*B!Y/Rmo"*#Me5$(ZMt4nm8nDCX"
hPP4q;D07;!gP>=1aqdfa#^B%6tNV0X6!0SN@W`r-H5\XBTcgh14?%$/=W%i1?63jkl*uf+g
8j#$I7p"=%#;B4H0d:%Z1Icrq?`fU0QJI3oWg6,,nP5"/fQKa)_T"+CTn!&n]AH5MR]ANYL5Ds
K@-?Y=4>nAG8.~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="200" width="375" height="55"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="航季"/>
<WidgetID widgetID="8d350c69-5395-4dfe-b9e9-e8011a725485"/>
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
<WidgetName name="air_season"/>
<WidgetID widgetID="9d8ca4b4-40e5-441f-b307-c2b8b09e191b"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="comboBox0" frozen="false"/>
<PrivilegeControl/>
<MobileStyle class="com.fr.form.ui.mobile.DefaultMobileStyle" isCustom="true" borderType="1" borderRadius="5.0" iconColor="-14701083">
<Background name="ColorBackground"/>
<FRFont name="SimSun" style="0" size="96"/>
</MobileStyle>
</WidgetAttr>
<allowBlank>
<![CDATA[false]]></allowBlank>
<Dictionary class="com.fr.data.impl.TableDataDictionary">
<FormulaDictAttr kiName="航季" viName="航季"/>
<TableDataDictAttr>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[航季]]></Name>
</TableData>
</TableDataDictAttr>
</Dictionary>
<widgetValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=默认航季.select(航季)]]></Attributes>
</O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="60" y="5" width="390" height="38"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="航季标签"/>
<WidgetID widgetID="ac7593a3-f6f3-472e-bdcf-99d322e1864c"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="label0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[航季]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="微软雅黑" style="0" size="80"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="0" y="5" width="60" height="38"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="航季标签"/>
<Widget widgetName="air_season"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="160" width="375" height="40"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="标题"/>
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
<WidgetName name="标题"/>
<WidgetID widgetID="e38e2eb9-7f31-421a-8b5b-85fec13214bb"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-5318927" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
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
<![CDATA[722880,722880,722880,722880,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3456000,2743200,2743200,2743200,720000,720000,720000,2160000,2160000,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="4" rs="4" s="0">
<O>
<![CDATA[        闲置舱位分析]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" rs="2" s="2">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="移动端弹窗1">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[【统计口径】同时满足下面4项条件的计算在内：\\n1）自有航班，即航班承运飞机为我司自有飞机；\\n2）生产航班，即航班性质排除训练，试飞，急救，验证飞行和调机；\\n3）航班状态排除备降1，备降2，返航1，返航2和取消这五个状态；\\n4) 计划性航班, 即航班在计划模块中，并且非临时航班。\\n【时间划定】用航班计划起飞时间以自然日来做切割。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="0.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="80.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="80.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="5" r="1" rs="2" s="3">
<O t="Image">
<IM>
<![CDATA[!U'Y&qh\-E7h#eD$31&+%7s)Y;?-[s>Q=a(>R1N6!!)'JdT?JL"KtBb5u`*!m@>h-*'k-j7j
&?K6rFa3JV]Ass&VsBi&J9SM6m*Zb&I8N)66Hh!6psF26j*RB5X\!_+sISS#Qt4FcUh`SG?:9
YmS<NKa7RU3>Le>*]ABeltqdt1=p2J<E<hJjY*jWhi54mR]AHZJ:Z:/Img[^Z>*?c_#Q0c(rk#
BAjW*.slQ$bNKkXqnZmco$A]A.LC4Ei(L-9)#2lK8&Yd\XLEpdmEf!j&C-T$'E08K'a@ET;3T
GlM`K^b(tVDSJ-3H-bd5)X!o4YW,mX*N9*O-O.X8@+YeaHGh,Of,n[oJ:=qV:%=6ONp%(_il
'P&@ge<M[)p/D@o/uq&eA\<a)1Tn(GNH?R/)ggje_qUKdpYOb%rdH'T1MB2dHKJW]A^c]ASpV>
g-P]A^9uk`#4@H#Oo7J#Wm,b#8kN,n8Gu,4/OV:aTCoe"7/k3^GoVF^u)b9(a;V38I!h&gn9#
0?TNpgN!LBDLGDV>`*mkER8m_/TV3,0>e.H?[:$J:5<'j/<^s/lDd;V^YZoI-W55fZ;Qap0%
FW#Sf%Wu=kMEpu]ACpE7#^qI@4:<[YlJ=jXq<73g/:VTmhCao:`J9aF?HUfH"b:USRb8ufcQJ
iEnSq)kK#C?f\lSnT_MjW*!JU8s#5EHd-^2\I&bn6a`#=9#TPK'2d\J:JRj.3lP6_//#LUs<
!;J"n$(@JAnFHp9G>*I_3fEdFU,oLgr+cGN-Bk($U)air!BY8_V:WCOo%\$GOC<ho0LOse%L
O5pm6KZ$N.,BE!.;d@"7X(q\^"=FRU$mF'a7iNO-4X0VFN+'8e?fT!T;BE]Ak8mHoBS.5q`C.
>"`WW_!7f>;URl\fiPljC]A(N7P_r_NI&p.b<9;.F(NTE$K9jYJI$du#=%"-kg`urZ4ZU&s@J
_U9T^_otN^gB.<.Nf9^hg%Ig-h'h?d+i.*<4)a6@Y@H^P3l1b^lOjjT1B+k!a\]A-LqY>3^tt
=bYc9mW#Wd&^.3$\`br'Ilm,T-Jq=EW&bnY3LF<.&6(U)mCbo?0=@KC?M\olr^GC3;156C^7
GAnsjKa]AKP,J_9ECT(&<$`W^$q>B,^Jnn-/AprCdqRI<?_W-6?>VeNUH$4tCg4>_l$0M\s;$
j.5X-+lM"44qa`]A'*NAU+4FMj$BW1+4n6j&J9fgqiM&!!S5'bA`_:f>8R,q+Ht)=BV_G87IV
S]AFItYS.&Ho$QsE6-RVC&c3SF_1hM!`JFbu$*Fu:pJ\_";@M**[%/So!<=?>3Do7GfJUY*Ao
\P;&(2WNL:kaZZkX"$]A:H7J`^1XFf!VnUYnWV;3def03WA"ft>&ThkPN*Sl^<2>NMl79Zjo'
@4![o)#R9UC-=o?o*74A8&;!jY?>5_Za%EpU&'[U!;b`j5%JPQH?p&:0oE),m:crjdu-6Nc4
mA%#i):C8d)%$'XO?6HZD\gT[>T`kXj,>3Af26N8SC>^"DJAY0*HS0dC+g?E=4Y2h"1g!ui2
[%;PsdQ^Kfg0Eq]As_;o`:XgaC@j,XiK:^4.i\T!8\Yj=lg<PV>pSr!(fUS7'8jaJc~
]]></IM>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="移动端弹窗1">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[【统计口径】同时满足下面4项条件的计算在内：\\n1）自有航班，即航班承运飞机为我司自有飞机；\\n2）生产航班，即航班性质排除训练，试飞，急救，验证飞行和调机；\\n3）航班状态排除备降1，备降2，返航1，返航2和取消这五个状态；\\n4) 计划性航班, 即航班在计划模块中，并且非临时航班。\\n【时间划定】用航班计划起飞时间以自然日来做切割。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="0.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="80.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="80.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="6" r="1" rs="2" s="3">
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="移动端弹窗1">
<JavaScript class="com.fr.plugin.mobile.popup.js.MobilePopupHyperlink" pluginID="com.fr.plugin.mobile.popup" plugin-version="10.4.976">
<Parameters/>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<PopupTarget>
<![CDATA[text]]></PopupTarget>
<O>
<![CDATA[【统计口径】同时满足下面4项条件的计算在内：\\n1）自有航班，即航班承运飞机为我司自有飞机；\\n2）生产航班，即航班性质排除训练，试飞，急救，验证飞行和调机；\\n3）航班状态排除备降1，备降2，返航1，返航2和取消这五个状态；\\n4) 计划性航班, 即航班在计划模块中，并且非临时航班。\\n【时间划定】用航班计划起飞时间以自然日来做切割。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="0.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="80.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="80.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="7" r="1" rs="2" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="1" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="2" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="3" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="3" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="3" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="3" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="3" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="4" cs="3" s="5">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="  统计截至："+format(截至日期.select(日期),'yyyy-MM-dd')]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" cs="6" s="6">
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
<FRFont name="微软雅黑" style="1" size="160" foreground="-14540254"/>
<Background name="ColorBackground" color="-5318927"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-5318927"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-5318927"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-5318927"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-5318927"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="ColorBackground" color="-5318927"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="ColorBackground" color="-5318927"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<o@E;eNPIe"5'gREDlW+gs:CSYI6]A94Fl#"HlfdBMgdfFp%r2=L;a=,"<k%[n`HZ<hcQS&h
cf0+u0oW.NfiWR<T$QO9d6_[hJptL`qG)gb3:FZsL%jS&*kZ5Go#f+/=14qn&qRXnQ+:mI:(
(09:?p_HR\nN>qWGP/X&@2JsKC0lGdiDuKYMi,:I4rXpo&gqN\4T7$Ps-2UHlab&R&oNt><2
m^am#ak(8'&jF?Ie27=CF&!p-QOJHIrbFU;*V7JrYT]A(M"C5=S9L8Ms,XYhla*ci>aVbdgQ\
9e0,N54-+DHIV#O=1Q.C-@YDO'!gOGV=G?"*\_X88@aqSi)/WE_+>Q!*#Onj/R#of2u<3kkl
RdC\Y%"fkM\l@0-[V8k=oT_$aF"W?JDD80$I_[q!?,f)IeWB8!=D"qql:9V#>m=C*L6XB7b2
o5T>V&*kJ#Ol&$i:O51t""ZIH2ID8!n>mrJ/bHirTg(M?Q<?s8BFM!t]A2<k4RlZ<HUk8V<tY
IXcnu2OIHbC1*#fR91aCr>qCkaj^Rrk#2A)Y_5/(!%l01`><dX2&+?O+p?8K1"8"nnIbZDHM
Duj[Ol>(;@kiC9[PUJCjgjs-j=8VO=4sR]AnBUbk(5(-?_51UVJ_7Q9aJ%>Nb9>5T(FjF^Q8)
HFg:85*q^Chih9t0<MRpQ4=0r5P<JFJXnHOJY@7+r7=W2iLj,pW0(4NZEdMjeqnJbf:S\:XT
TAM?Y9&J">5END,RdJV=HIR24IbfDNp@SaeV*2XU=%_$BX/_6U1:r7oG&>Wretn<h3`/5c5Y
kA3AdJ_$1)'6iq2X^9fiM0");)A=nnk[+a_WM&fk<AeNQDJn6o/4CRb`"os$,!lNm*:r^VW#
XmD-,P?gsCU2k2/A%uUb,_oAaW'i'+'[p7d*[oClHq:k8;(9U=#Wc4YS,2l>@=)DUkpnit(q
j,9%3DD@+hm%OWQeilEYPV"Tb[WR8%3QOBAL5;`H7Q`\aVf,D:&Wr(m5#X/Z.-#VNCa@^AHX
+]AC!Gse]AZQoIbr$%2Z[4QbEB)g\gSnQ)kPMq18qe_O&\XZ>Ehg9_BLQUZoUtk5$jR^&XPu/i
g7-r2/%iq<2&]Ajp>n!Ud,Zk"Y6dC06;[762Abb7@rqF;\JLT4IINga^2P/h*.V&5[)o"?8b[
]AYTSjWm]A)h)s%k0>s6$+dQk;fg)oeZUa*&+73+.]AGL]AkNi'YJqTM5Qr</W_!-=f5LkpS.?o>
OVY.I8pQp]A"?WYd^Ha`?*39AN;C-KCHR@U.?qu_j8<,>ZZk[i31Fu-5[>4f!)qVf-ap<gR2'
9R224o$d<ft93RVG)C,8P8ag*u<!SLNY.=69,%Hl^^4$jMRVNl2pqVdXtV$s,&l^aHoj"Se:
ZlOG5MST"D]A\<TBFBFWdR-!R<k_Orlk)Z>h!tYbEW_QQ/XmNeC'+*O3h+I`%>DiCa[3=8T\C
nb*o;k+gk_-Aua,c"l=KnS_U//H'>T#/CM`EI1b=lQQ9X`pkT`q:=e7WN.?,*LRNqaWK0<Xg
6n5M-ns<>e<PmLcIM0M0IXZZ$h1BBq1]Ai0p.10<UuM"^u4u&CZn[150anoC6P]A4LTI%Iihu^
/kc^>Q5:Dc"0/.gA-a.KcZ"GhFB7F&rUCDZ,T7:\;`9E#<rQXZjUKj[rATi&H)Yb;9a":MSI
fD@IOCS+OXD.]AW=*>:3rP@Eg3XN%"^S,`/.fO`q)ADoGdm=!KG%uJD1"Jre18Y_2X8K^*jg8
^Y"7qhS<>b(7Vc2nr7jN+eq;e&%/P+Jo'03Cp^uq1:\umFWo-qns/re&sg,Z4Gpb9s\[_\m+
i4K,?CAjZIIa9?B`R76shmR&0Hr2)C]A(Tga^eoLMmGlDZE,#'ICHr[-<as>4Ut\g>[nDe5hG
,ODDTMY;6Vl=(4%n:"I56F40C\"4T^`&=S[3!bNb&QY%BZIeI?OHT9on-#M8LH)RnaS\OPWQ
WguG@Ec14U7-iWY"7+P[Lqq)':_4cD$UB^#$rjLe5#ZQu'g0lCgP[51+(b@h1>N&(X+dfrc,
q^""W;hoW*d31C:6:dlga69sSCkot]A8<o*J*)=LTeAon+KH!B\TfO9n5s["nE'g/IK0\>lSu
6!Eh:3Gg[o;fJO"&9^Nf@?h\PJUdeadl7_^A;i4(?X0Q6n1h1QprS`kBT-?'QGPj;AP-tFsi
:Mj;bG/\a.3CT.qStr#+g_G,r,C.u$lgf1]A)^'M'J_TlKoLfiYQW5nLMfiud3EP(MkQ0jU^o
I*`b-*C5^\4`5/'/&bp^kT%**DV0N7`G4$>]A+#_&DO!48[1-cBu=K/:AG[dc&(^f]Asb?dDRA
k]A`[X_a`<K1c?"U,RODeZ)J?PMMb'fd`<=dXPc3"ZG8d_9H^iH/.>mBVLe^;1.dRU(VR[OV]A
i:*3.]Agq]A-#>`G7@ib37rWWQ-9lAo[#8bVQ=CW^T%$&J:Q8[\s+Q3g<0M9CC<;O%gQq^_OfE
.(`,^?qOLMHB[b06$-sS9r=LJ&dA55sgp1-n-WLT&=anS>jV<DcL.;,,$H0W$=&tZd@#/8-s
R3D>o<Pi?"R=J_3&8>oi.I#-4[;F$3h>;U&b'EdSG3*'kq-7-*H:IOBcJ(oH`(`;s(QZIul;
NF,g4rmVcP]Auq,0;43oDPV3%sa8A%`S.Q\0G'g2)AcS`I]A:;%9l>*T-i>-b'[D4+Y1e(I0Y2
32K5<;Q@@IXbE!?Y=dlIgf0n@'=>'Ea1InrB[l6>q-be2;G_m-HY+6o5ckZ@$4,<;W!-R%$a
0'2PXpmKHZ6@n4/4!:R_F@N31!F4qDc65HX$X.6Za-;-f+Y*Z*GQm$'-1E??uedE(qfjs91a
[:c:jO$_(_WiLKKj8;jd8t<7>3e_9R;ULK^sj@\%%8hs;]A;XhJ%,g?Q7d]Ake_'GcQL\ZG^k-
*p0D'Fnm_NB)&\S7o^KQG.&_u(`KgCAQ\4%EMYXegX0977pH_o93(e"$3K)l6lacTkSGJ[4A
a<g3$JoRV)ZR%/le(l_0nss<=tU2(5FYKo+d/^qDU8$ZA:c!4NL;`\ZW*^cD(#dq$/%PK[L]A
=]AC'=fA8^rAml#CmYe^=XQ!i,C\2:aCDc@-DRDI2Z6FcIUT@O41B[/37(A47Clq`pn6,hdUc
Vru6*9^:b.aI9^9o3:9CB%\3$)Wr(f%%h>(o>qAH+g#/PCF(d5<#4PF^FQ-!2bkhQg3Q0m)?
/(UIrai;/\7;$P6tV'*+"I)WU22.<eO&9?rbl@4,408Be!G55pOFVG5V=Chi=JV+qFJ_h=G(
\T22dM3r^K(hU@,JP=dSF]At#T7prmD3>9(ce1WK24NH%Ghd?pTp=u'eZWRW+]A1$)pnlq`>bH
n9S&d(@n$up\8/.SQag<[^lFgD?bC[@UA4iWhm:M+1L1id45a^t!`h.Bpo\=g<2!`:@hF&"/
]A\.(I^X!Y&UEe<mXkOo`>\`K-k1A[c9J=ErHCFs-;2TO7l,BGGk^]A'nCrc`SP*aMBKF)W;*!
]A>bI__>;r./)]A^]A5$r3B<B%p;lVd%M'Z<X9qq1#MWci8/P$@I2#c)o]AJ$#D^]A0OD;5S;G12s
ZS!oD<:b\(ZDkZ&?%)Lg5$SG(/t_(3AZn[ZT"J</&]AKdBgbQGF;bS0hks05FW&;_*hp2I.rD
:1f#\A-sBq*#tK$6A?2Y5#06,(')o5$;<7^Fj3c49^:sSoh-[dSb>]Amh:[aZY-f5^`-.#shd
87;b:IpS<Me\iT%Hg4isbo2NQ_/g'=MR]AdU4cWQ]Ai$ZekikKX=::Vlm-:GWVK55R-gcffr)%
l$:UamN2S8rWZ\N)Vh.Ik9Ob#`%2EGI8;q)cq>ct85+gX0XeY\=G+MUp^G&:Hdlg:L.TE[Qn
O8)TS,:G<n4jqGU@MeSgUYF3+k`i1nWFjJiu^1cU?$QqiOsI26?Za;.Lcq4*Kr5aNMha4Hko
[tqj;Dp+mcFeiN8'3WcVNXoLe11\tUi;!@'AbgS\dGeVW.W>]AFD"*%&_Wq(#WoI02P$Q^MeA
M8`QmXLt?oR%)d?#(imNX*:d*-c0EAgN,b:l]AE^Jn?YfW+aI4o6G-#ZYu@l%@^Z]AQ.<rNO-L
s8lf-%u1(>uNAXYH1R6+lb'G$R@h.dIHWG!i0j@%+nJT$d0X*sH1cMaBk[%2SP<Ps*]A_ODRV
`/Gr9j,unL)`JO@q\tAjl]A9LEJR>E2r:?"YIC@'PD71#>$Hg=[>4&et?bCPS\LVO]APKtZN+W
ZI\-g+q-E1dcG;\$d_Pgm<cMee`Rji;Bn3++^c\!%'0_1$*'aq#XqWj*C1g,@-2nonLY0AR+
*+Hr<@p2Ns;e@WCfe'.pS7XZ21JHl[uZi4tSX^UcfflWf&pZWQWPbJ]A5;-qE"aCZDBmd%'1t
.7VuOpQ8S_]AanOQ4N=AjiOXD=(1+A0Xg9D'27BJ.l]AO:nhsU`-EA`HIraqde@uB-cl&%A8T\
cF440=iRcLNKA@0(j'=\`Mt#e#:6^EF+/J2dZI02;Lo"m>CUE\5Uob5)/eS8D5K2,jQ+^h56
:BV3GO-Vqr;j@sEV[H%?#ca*(A1g4*&Lqpu96o(+&ebDK@;-)i!O/WVt%Y_7HT&VS5d\b1H.
MZJ#ANrt[:QaagMGpAfcLjXSI:=ok6'FjEn+Ut?kNU57AUb$r:bF+0VQH1]A_H(&+]A38k*>lE
V85s.WdI(SNQ;$*:kEhoPhfL+d?m*01&JZ.ho<!hYcX1e,LdgEm-^L%F7+%`m^X7PH&;W`N8
k,uLG?V^>ins.Phlm9ka8gl:eo*NCS0Li)mCMhO7Hd<ScbaKk+XXWHE,R\5!N2s:M/L0I3?!
dUlK+R23`'@\DUO;/(04^q*,7%/SYZ]AW.$A@56L3[A1SM#m`d^ti!GI5ZXhkF>iP)pnA7Nn6
26mG+c^UMe5e]AZA+H36$!nR^O#fK)CYbp;-lZ7i*uhE/?B]A)DHh!//""7pg]A"Q\&=3>Oq*W\
r<E;(2O1^oTlp/l?o^#Fk5H(X<Iu\F6-C(\l,!20fkJcArNJGYcd0,PZ>U._hYh[>Jt1s38M
kAG+hoA$M_'6Z9O#3Caei@^9$TVofe\3$<(ggOg-7RA:cBbW*KR.CtEe9GtnA-m4NpJ%0j!;
a*i\]As0SR;^o[KA-<YfQ'6-HAJ05tG1J$eMEas,*-P!c8MC7.3[E7#tf1X>)#C?.D1D$6kGh
3qT'@@X/h6dfeH2DHd!gZ8^TQk$8HdZC<gorA$pP3+$/4"\L"Pc*u\Y9:[#3]A3?5PS?[j]A20
&5pO<KlQI?fp7n'Q\QV=fRlbCf7YT6CloINYrkLNpFaL=8YD4ZFr#?R'+45,``:EYq4,"*Po
'Y@9!JDTU-=B?GP64,L"2nn;/.%s4@,B2?h]A;=FJ9#OF/GdF'!iK,KroM3^^%n0O#Fu1c;TP
"BTY%iWmWhi=H)r\6Z/(Fdk:G><a(TGY_Ic2F?eAY"0Q(&."A7!9&Ij9%Y/ttUZMcao[7HG7
_SRBNk)eQO#2b\LK>H+\GY^K#e0ZHpL[#G?=1[%lLgoOqq3h>O_>RU?os-gAD`@(BhoPW@Qk
*JXP<H?6c:5o,R3bk78G#>q:LL"A=]A%74p1eOKX\?MiYM^CQ)*$f]A.%K+FEu:rT[PF/O_^)\
b7^4dRVOboYq'6:=.KWQ#_.>W11<":=jT:<Wcmp)^*8R^9\[MCn*+`T7cK&[19..[('!jVs_
ho?n:,5PNVN;ZsEY"%u>.S"92Tqp(]A/<2c<LYK$<CA[+=ZNDl^nU$fE(3\KB*-NBKLJJ:?cZ
'R<5?EdnJ0!(JA]AQU>L?1:b0F(S/.OHb'nN_qoIotjK#2L=jbM0#ZJV\X=^S+G>_G;rB8Pj\
7ru)%YFkuIA8SP$g"MbWX[\k0&>2UkYe`VhGnsX'Bi;2$p<W_=k%,<mr?U5)ErtF7GdB0"ZP
!I\Q_"kS]A<*=s/CA$/IT%cg=.Em::/0#6ZEuOo#K'Ya&RgaLg,UTHWE0&Fm]Alg\P\UBW5!_e
p9B3*EWV;/K0Tuau7TL/hmVNsaPSKt_F[f(F?;1+ol-Qjm[8DCF-q&"H>qT%udAMTuosIfE"
$&GY"0:t!V=GT]Ar.NKH?g#XRk7Z3]A`uQ>qdcLRWI!c]ASbh+&3#bj%uAq@N>$_L5;F0)O>PYa
]A;.^&7<$l#gZ&sm"pf.t;C+gLS4oW>6@A3?tUOAm>P+ke@e)]A_k:Hcr:\%Vmhs>rRVPdfQ(m
@[D/r-*^B]Ao4,5]As/FLJ//QJk\>5,0Eh1isEiC5s.s0;u>C!^"L?&WYCn7kX>H:okMlJgRgd
+Ks;`P4j3^U]A+PM:`.-C08fVmjW5qDFsc^8Bc:(Wsg7aXbQQQbAl;!,(_<+P>3k7;tJ+oAB2
/Qho:72JW[!LpgM4!YC#/S*l9m26he&TDJY7G`!/@glid0'F"8h=iXB>3t2'k(:BqcS?,$PD
G.j=2"bs[J.kBscrC=1#23PI*)"UIQb[knMKcbU&<6nK/(PGE:\u4*,kH]AtdfH;m3`Y!9^!"
a:R^BP=/RZkrfM[1HlfP8"0%nr;95$_dl9"]A.CD\A90Y;Jr.k%ctQAuSJAL0=s)'Pm3<DgKK
I).qbI(bO-,E;80k2H<GVfU;&<,n$hoWuD[-J6gd^c(aXDW]A]AU7tJ:(n?)riPh>`8f"h+j9@
(>[&VB&:$.l&a634uGfk!-5ImYsB[]A,8<ofqGJc,$\mgQRP_0]A`J*1+i)c+^E/?H^@`QX_M5
V8%t!4A*`DQ=Y;q)XtBg"h%X>M:&7FiW]A2^Z9X@sYf*oi^`k5<Af`@DLg1Y-bG*@X[8rkjV9
E#g7lG">#7%ogqP<bbr-9Kt'G/alTXZ(qD;cWrTUso$=&JZFZG&']A=4J2ud(A#N51*El5TL/
2KaKZt0p52Zn7r2,^*$*^[;3aT7o0ip@c;:X1TcXiub*>h//H)L^aT\2UnfL-7:D=r8)gjY*
H;(^qo-h^6(7f`b+e$Y0<5!rp7.tL$3+*9a,pZF$.crTR`S:GQW;UfL+pts9!k?;UY/mfaB:
2jqb1E<?lrcO%&-nDWDSeH=#?AR<Xn#!dgecHtJ@#0hK8]AUFpm!&*/dBrLkpC>]ADn,tl6&Fo
S/&,dt[hNk.U",#(g=?:I.0.fg.;3^D7oR'L]Ael@WAno_ccDXUL1]Ai_U/6g?-[:c7;ND-qdV
*AgS(cK]A0"F*$Ln5V+BjBCRXZ1V:f5Tn>WI'D$\_5j6__e4>(Y/^bc2etBP%E'`tlQg]AmjU,
6B&37AKrOMdUg&2\_p=Lq1CC6_2`3T7pd4BWWUA.`+51t?ghp!F=VLr4b#,f?OiuCflhP2]At
ZBP_q:>M)m*dsEZPe-Z1.$&IOld`+TcjnNiYM<[goQ@9O-!5#t^;Bih@<uqlG#Gu**X>RMoA
tYf%F'!^'`;uW?>d0@Xp8eDpf-ASj0Bg`!79QO62eg9-r=8fDI8FT?Q=R0V<?h%(,873St,k
rOga1<<X4_WdoM7`;_U+5fQol,p#.1uUo-K:npGs`![^(Z&3k)n)r&7EBpF<L^aJr1Zk0<n9
?T`HRU;ga4R@5"GE^g99^-\Fffm`*#NJ%k(<9iuF._qCY*#)/BY/=q]AkG'!kp$k^G30Mp?"N
[O)fK&NEeE0=n!]A'ArU[CYF^EL-SdPZh#O#^eF3KJ)(Z!a&*^7Wq<M?i39<9fBb"8,IiU\q_
.F&c^7?t?eR]AG,@Y<T<c^7:182Xru8,4QmkMoI2HK"&auTigb^^`)bX0oW7l2c-]AkHu%aeZX
mC#"Ec!XoR3cuH/A-&0A`N#S7:bQakXS;m_:nA/H5^@HX#%[JN%!/*k![tY\V^uS-=u_3#:!
;%nHd='3f*9!ns!(neD^ei;)kI0A`%-c<mZ_m"':E(P2E'O?#QbZS=Q7P!a[<!lK"(,GMX,G
EW&hFIsi!?ppk[b]A*'^6PeO2JL602c8,G.O7k>0S1OpY2#kNT95neXZAg*^J,_G_=kLOYF<<
h2,gC[TB`iZ]AMIie%Wk4$Mo=-"VI6D]A]ANlLQ0HE?8,Kl#4*TlIDo#Opm7Tqfu`DT3/O9fG``
9jm3IG*=?s\a_u!!t[>l"#8Tl1Wq[F5`Ga?d/5AWpu1`fG[kq,W;QBch68&X+mYcMA)/-_,g
Z8iNKU#)nTL-#9Q'Hp?-eO6G0r"E4LeG<!dle;Hs;/-fZ[)Z6F/6'eS%X:9jqL[,hr\\G$L%
hK!KbuGoP`F!2?DOqu:E0\LVS2)dbSWG`)f:E[kD&5p'?((48'mIRD\$o8GG2DCP^*MEKeWV
"T+41N:PsT-HnX6"OXNlU233O-,tt%Gu%#+_isEm.2opdR8WpZ:^TNil-g9?;C@EOE23qqe'
"-,Q*":3$7(tc&RXH\Z:T`>el>a'NWr?]A)&q2,)1TugVt\(+`m&\?0bHq4]Ae>1$FD>_T&uRe
/9q9(mjRhM`Vd]A&B&.'A[8mMmdVL^.@oBnP%F99:8:\p%mO-L`rEnHC17VLh]A;"cQTWM=V//
j(PPSm9R$V<!0&g5AmD'kXU6EAsP509iZ5n4e>IN2A=G63Q6d?E(*:S^Fk):]A=4>N3rK-8YN
+ID.54K8,tr3"4[;%EB.WhMCEBeA/ja4m29nVW>(2Ubpl=m>IV<0>)AF&[$@aM";m[s*iK@F
J7>7+L[:Z:%74DJ<p6k)WKnE3P5/'mKTa/)(21(DMesprJ>3n(-4Lb2$#\,Ft;5l*/1B9'G,
t(W]A%r?B`K@AR>(]At>i5Qq";s!7#a@1XSH*\<B"]A[0LM4=U?qfL(SdHA[G.LJ4bs1\kbWjnE
E=@r%A=-L1^?S1hn%AktZWG:Z^m\?tcmL"Y8&l<H^5t[)KPgd4AF>@$S@Bp'80*Dip.#[]A2=
/g?Y*CjbE2f"CR[=O]A:P<L1EN7-$a8tN-rmWEr;gAn`[VP=DaSD&W(/,$4hK`^%M#bWhqVOk
DHW(G_jjE6nYj#;1A?;bq8i._a9FS2leZF/]A@E"d+J=hl9J"6pL%#9%$ic+//;.kkMU3/`IB
=Vf^3:0Y+)+K80Sc77OXY9o,UaFQ*+`s=27Z`l'K.9=1Pc+1@/&m[hIb#Bj(Gk78:+<RH"_=
9>#=_#YgY?^XI8@,kI5qj3j<Y[Q[]AU3:Cje?T:,<P9NGG/hJIE\\63@fk:RG+k#osPD"q=N.
';QTDS.h\@h&"FdW#+.W1tl1%2ft[=q>CO0F?B\U00-^?Nhr#%J-sZkK'/Vp*ciX#\]Ap2!:H
1)JC"^o>]AnA,9LL@T53.h.H-o?>WTSSQ,Ft<43;?Bd_&h]AKRQG<25F?$>7["Og[&CM!@*0W@
%'cnlPQC*3h)=G8pQSEs6"516;1%Mdi',..9E,p\DZ^:T[2p@8GTGo$UeZi&N6edmo^j:ea.
t!@_:d110WQC81(#)Z8Tdik-J-.rGs30PG,unEghP?fC3i=*MGT`RUjV?SSl,)C8V\sEE)mO
g*N9tFWUNptJeWE$-1!BcaF]A@D5gS*ekdh4>pEDo:qGoZ+1Ug/]A^.d$p7+:"KWDCD.=",o8Y
R`&=eb:0b*+d]Agl$]A)k!M?2&ukRA(j3B3/penbtc.>.&=Ssf-eX,D4e[FHP&qVOZ$gq;ZAR?
'(jrIT2O\LXJ)rb1j;ciU2U]A2IFd#T'R'>.B?&)QW%r>r3/2n5DK.8_ujgLe-Fu'4dM<C!.%
pNJYB>@&T?m'3Y]A2?0s)-7WLAo(&U\fM1c&bcF*.%G=#W/m$+u2c6HoOR_pa.bGm#VY+jmhR
L#7+96$S"XtlQuhCSYaJ@NE5g'%8SK*mAGa.d\T7b4IB_6h]AY'Aa^eC!V;Ul4k$YOR(Da'R?
ur[H2LbqmC!s(C9Ku`g]A*!8_AjC,15Q851<pjHeH"0$^YGX[Lft@mU;a6q__VTRaKZ;XR4E4
Jp^j5he?P%_Ri@*4teQ*VR4m!4A/qm$j8tbfld9"("B8ba;KBU(8t.E&VVNhmgGEU$17RhZl
"q&_p(S#g3=12Z2icG5ka<\o,fsGn,S/^PP`U%0mOWRl2XL")THmpT7j4BisC%T\]AKm$'_%9
.5.OH(E"A`UQCK,R0_mZO4a,*ErV6PrFX$"-'^gDh<-"I.qfo(qA8?l!]A>5sLX%L0InjkkN:
9+j%Fle0F'i!H-h>ct[&,L`]AkS30KaJ]A=updY:$ZC:2G0EH:Eh-W9gO'I,U.A>^IX*A"KE_N
M[2sb6I,OWZo;<%nqS12MG8Ts09C45X7nD1&?l8r<@2d#C(\&O7[R'Iq)$\u8"ks6-+gjIgI
_r+Tj:!YXiJbU-M)adN;[_eO<?0tXt0$4689J5t?>_\<HM.t"W12:_r,Tt5]A+3jd-#MqhgH"
LO*>U+PE,3.((`W#/VeIlpb=#)>FMWGs1Cnu"KH*i"m3N"+A8f3)r8%,<(^>EH[LI3s"G9e^
9r&@=("MK66O!AV6!GN3&]ASG(J8D7?">?:,/\&7I!1&V@*V'!aM]A5T"eV"N`PA&Z/(e85),;
5nprr)0lM*p#*or4j9TcC/r#i^hMrTsY-?ZFT_aVT3tJ$Kr+D4s<D*4nY*;7p0s#[(MnP=og
DO0#GCh2*:jNEV8;L>?%:=5,%6O$,\T_+4>k.8"6bUULcI,rpt^Q$9m(@\a=U4%-[u'AIn6(
j:0Q_P7_s"D.GZu6%C`R5#BsG?T5Q5bG\m$fIQ%aHVIVIdI"-X2PdScVW@<e9^t@brWhQ??-
9^0E%Xg5B"k]AhkgM.qX.D(Qq8RC)n1lo(4S]AdfE;K@J(9hiq\PjWS5($f>kYL5D.mV>Y:d$(
.-mf:6688NAH->V#05Xi@6`SNU#5*/8#J?US4XkdG5=!)KR]AY&,ZJ0/Y>g,M/XcS=I51N-K#
BB,d?]ALG=JT:`6D9=)9`=nPNj=ZJuC#XM#,Zi/VD%e.1>RAaURT,ldo:^3W#ceCY@%::b-O]A
,[LIFI3[=p!()tc21mqRa-hl._]A")j]A^i&b0XU1+/QNK)A8DO;g]AGo0>fB^5F0^2'SN^*?(;
?%3r7%"I>Y(q:H0*\\/9_7'=M>Bf]AG&#k]A-V'm>,_<dm'hlTYE;Or]AC+lQ=bj/jatT;GRhW,
r]ALdtSsVO3tG9l1:2d?n4u6/:<M\A[q@$Du@5709`;bejuA[T#N8q[1PBeM\Iaj2^e@Yq(aQ
kJo6$6*(K!mfVK1<X`2Q&X8mWO`]A[d&$u38m$I__#(2Vo,>i=q.f:[j/eg21@I=aH?@n<pd-
'jp:ara6+N#4^.k_-:i17bTs_k>\>QfnS*q`Y1=m`j:Ud0Q&o5%r]AKd]AnS36e,!8&?`k19m=
FLb,Gk>n:k!WD6,]AU[-gaDU$atmQP8'D,V@_++G3/fOM([--F&s3#B\OYB:+DXB1Q5PB(O_/
NW"`>5k/g\hON%DQnflVJdGNP:b1?-elW3EJcHP@Z-Y*PM"[En9^L9ub_I"^MH.k'8Y?U0PY
!ElY*aoQN$:77eO^;5'A_i]ALbMX9*\7>Zb*a[hjX]A.C!^mE0TZMgZ9r_H!V5H-=)NO'KA?Yj
bTfk.S34M?M4CBfunasP**jV3sa2'L$<l\c7jl7M%-T$SREa72KF758TZ<[4N4c&mf>!#2mK
$j#cUn:tTG[pDHO)\rcF0A(1P>o*j.T`$&rf?V2-u_m?9r*^1dVW0O9Nj]A3GZ0l3g[G`37Y*
&c[L.'bA-V>>i<R't"HY[#!<e3S_6.VWCs"ADHR/c'9si)`dmFUjMo7mf(_KO/E_Q&^PMU,e
W\Y:&glkJs3uS?P8<K!IfBJd3d5fbHc1a3Scqb8[dIZ?($Q&p=_Ute3"Se'$$h-Kca5UgG/>
jPd<4;afU`qO]A(IfR<:k=gV<RFeXJH=<)1e0T6alP.hRgad/f`^r1qOPiRa<AHlHcYBj@VUC
GVRX;O4E%21+OE47##_h\@pcl3@1SeFdd]A8Nch$.5OQd7-.PWGR!ehbUldpD8#S$a^eio9ge
.[[WIaXXM0j:V>&lfaVf.-.\*DdDE]AKcU;eR'6VJolf2$=nSAZ4k\hgN?tF8^)f%ifU<\Rt[
uf-,_c[EtH]A8g`D;r;Z6l!rZ7eeZ+\E@3tB)kIt2_@O@K("K7XtQ4TIKWi<Q6RB7ui&rq+]A]A
F(;Qo%pJ_^c^h:`8bq1sMc91jqF3^o=JEWi8W4tN4sM)5E/$omLZb#gkMX:fT^)B]AE%*_]Aa.
U/^PQ#jf:2&C+,r"EbLfT=$-s1t6I]A+o=,VQ0Go$U`,%1P$H]AM0E(:cP#T!4g/SMrNTeq444
(%&eI2!nn#NnOV.-p9P4--,pJi;C($s9cR#:$J[;>ci5pAV&*eDh"#[i9uf;Op(g;^!jD2l"
'uWQ)ZY?H\'O.m,t1je-mp[68@oaZ,e8QU"kg*[oIrJ6\tG1kK5"+fB/='\+l/dkiMV`hOR.
SO0mu4G*'r,G5M+'`r[#_^pNZZn1+U^fJuH#6+F`DnP5;,om<?`>gXbp_>DHm9jqc%7UM#gX
*eP+E+Xr<^*u>t6>:e,iDo-4_IGM.FSG5#7j:gPe+J*rdm:)J*BCLE%Tm#Ta;q7<h/^]A#;%)
OI,h%8bm+]AtU5?a_,O6!E6;L5%<rm_R#2L)/aB+fA*95Jus\&4=dg[(PtrJ#dJZ*7G4Uh2F;
26SGFLdg<[8?HAX<C\ODrn>a^CMcn'D9^&b`m?SJ5gr8iV+[)LqSL7e/#<XWGKAhZqlSR;qB
$'4j3?G^sDg`8E-4kGq`JgMS3YIqRK'?n\JZO3Cc`/TOUk)8MCr=t#+Lu3)8pm#NELilg7f[
4j=BmJ#OPh2QHuB="!etDk^(;on6BpKTM,J6gV,=HcL%0<YW*1$+RRfQlG#Ji->oBW'R.Jd=
VN656c,7`tmTk_CXLaG"%/><4\S'AfFcXmhR7=*KBN,.:)r^C3Vl`5^0?Eepc!&Wbe&:Tacn
6Ai.J_VqN'ZY?SMa`QE8#4sbq;=_%Q5Q#HBOZo0sk8K:`sr$J[@"f%R3a_Vf%G2Lo6!"0h9@
K=se;<(RVJW:mPDu4\=Rl7Wk?f*:c@Jl71l%!cA`B1^]Ai<a3iln3"uaAdiSE6Kot^a.h0D_9
!!g5bo*sG,G(lR0A#n-,oQ9IL92T<G\'P@:UjDSZ+eI3L>!=BNhmPos3e54os^PiDV@7$'\s
pFN7^2tL8AP7@/CXm*9s;_?#Hq>,\^PQ*RN"!pY+gFkdL^ha<:rt7a<&>57_et9kUt)&]A11P
XZ5X/#k6j.8[S#uYQqq0mKpD^._D1rBh+</*u7C\!(VA.s5iK7PG`c1Q/s_Z)+OIB\:g,R$E
bU]A#uK'jq1M%p7(JYS$n/%Ff&aoSM`B_56&GZZm8$u2dkAh9C/!q]AWSH2%ZWJuL$[!8Q=WT0
-c`Ii>2+0Y$cI3T76#cJ,"_Y:OEdR"(R6/N$?AGPc6*o>&S$GbeDZGGBJOD'odP)l#<pU+R5
h?^-;agL+50aAG;,5o7k;5mO%@9^SD0NF-,B3KV\<U\-W3M8$!ZpAY>C'$CE[<9T*Ja:3qA>
0t\*;LkngGK2e>7F6-"%VY(GN?aV^lO.AnT!H>Sf11Ua"e%:iqP^\_CA58p;.nUJMLgOd4o&
.)QpDqU/Z\g2QE;?[a_=c^^:lGC:.sd'!p!l2;g(qfe)g]A[ko&]A8#`'/qDZp$g^"[.T[WZ%I
bf;K`AeA1e(W)#MaAr@Pl:%562h%G44n>@=>oBo"IUSmeegi%"6_[REL)s.9^r;b2l`MJXq[
P(@nh#]A9__+J\;!`*qd,)N^-S#m^+9aWCo$[#n>lUIE"E(--0j5hA^)YW#IaS^Q_]A3SE#/"Q
7Q;?8^Vo0qgSV~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="4" vertical="4" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="160"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0"/>
<WidgetID widgetID="e38e2eb9-7f31-421a-8b5b-85fec13214bb"/>
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
<![CDATA[701040,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[4693920,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[货量动态追踪]]></O>
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
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="64"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[j]Am.;'5+mg:Hc+'J&8ea*a9du?&`<;D<dibLe2bkD+Y/@PjQ%f/^`:04Xa/m!HW%]Aohm<n,0
-Vf;iODOg8LqaJOGA1Z3V&H,.Brc0E_Z4";5aG1D/r9Mt;cke@'kfpZlo^o3IsNI@o\N^L?;
4QdR8\Elp%`I!d8q]As7>a+.rQ[q"Qrbn_CJ7PuZT:]A6o!h:PCD"oA<FUFuMo:XFU'E,O2:F[
VpH,cGo:`5FpRlZ/j`uV:cL"TtfjfgUNH^Iq@37_L;.8Wo3/fZ);cXYkQSi#n>D'D.FhT:dX
9K0+M)-`6)7(+53*gOW@%dMXP5i<cBI,&\P5\@^c<`KmhQIX"6T,(btVRrq*GYX%/E;fJTgU
%K13HN`;ifXP(/!5AP?$I32N4<V(u+H[)q]A@I=Z9F(%imR;mb]AVM<Vd;7f'.EFJNEZ1P95bM
hT>_O2Gdi4'?TfcB_DhL/h\%uj(A%<Yn*m]A^MQ+9Bk<m2Bt1^Doa/2X,R8:Krbs/r0@oeY#5
'OM!X4W4otCPb?#q^7.OBE6d8F-)K4\(;l,9l4%OVl`%#Ul`K8*&UMJ&bHk?R436!M8YOQ?(
%hOfI8Z?L?P6"uOo=N"6"Lb62Eo,5r+&t:!uAV_8V4;()bIJOJ.hEK\8p#<r:)njJ%+W([jN
S.^fdXY]AKV`*T40Qd=/nhn(!<iI46qJ[Wis,b8]An.*[ksr6^[,3p'T_*3WKEX.?D9_rH5A[%
>ZK@^$e2XpOlXt102#p*e_NOaWV,CKW?R_&NEo`]A#$od`muVuH0PoR4QrujbB5*51AQa_ED3
4e9CmK7bHAKdq/#/K&(IR&2/$$oT!N5SW4&-*bRs*/79@IgH^.PT.O#l#6<,c[TK?$PBA/Uj
*pl_RPr2HhXl0>!!nqloPCHFLl=9801;1*#]A'&g7RaRgFNM3i/-41c*^q<9htWh=0?O08<Zh
D&/a1e,?YlZN,?KuF[&'@97t<7%RXU*T"gl\+L[WN.1lHCX))eS\6I+\.E2R4F7R"oYXg4NN
K+nHkW^iA,;_BkgA,mUF7S<eHL[)2Bhs["!/+"0C#^eE#pqoXJfP>MmLK\N\$9IHAb;R@5<!
oShiq&g<dV5,6E.O+AW^p3^t6eL!Y-@d=9'kWJN$GZlKthBTTs7<b(K\7#]Ad-Ln&1kr2MeV'
R#bf93\2X6A.2NLs1dMUoPZN=1]A%Xe!o-6<;ZUg4RaH=R$=BNTc,d%#T3B#"s`UMBc+"3`o,
)jLB`2Y3&uLh*XIeSt8$$'LXij(:@9s;P\9WQ'YO$?I6!<(tW;,^ZP<X3UI&L#6i2A1c#*(#
6/'+CZJF^NVg<WTB%F:=#uroa1cQ^&m_r*lc_^9iLMetgq?@TpIhKg;<8<73V.^4<#Tn&($#
u;A<hBFg%$'0CD+u*<M-iHQ\Gq"$>E%dR)q'e@56B89+g^k+lq^-GpIl.0>t9`e7,OdIfa?3
.P4&fh'c:S97-LbC3)7)>M2>9%'MHQl$FcNH-DC@dL5R:Edi<=PKKe/?U%jt<`U!ZQfZ68Ms
B6+WHr!PP."Z%9TYCKp"$&;3b;));m05'Zmq3RaZNTK'<s!uoX1oNZ?9)dH]AN1&U`\dM&la?
a5&><&*7sqB<6!QTg\]AT.MClHYpYDM7j.Ol^'fGjY`Ra\f[D/)UM/A>QP?1rB==2e+bj*p;I
)4B'R\^eF-1\0d[pOl'8>;9aO;R;PpKJ>WRkPV+)30eC^?G=Tn$Jrs,#a(8:ZL3s#g]ASBCi0
'.`aA@Pj'$nnB6%hL61ouKc85=c/&(!J"=[4#E*bHGO]AP[FJen0r6$a-?/Do\(BVD4>Rj<VP
WM/KM-"U8,i2s-Kf':!*Z*-gMkClbip<J4&F;`umT\8jPnT@LXSA+jX:a@n#ef-h*l=k%0($
DS(KNV35<(9VNfGC-mD`1^2hOfAfPIG5?$_]Au_BrBdQbMtUk+B'edDuI_qiW)V'&\h0"qN8=
?rATQV>c,!"/Lq%!@epC*I5+d6S':d#Wns+XD>Ttub.0JSek/m-Hh%a)hKCeSBid7Io\)+Vh
C="(:DQX^F-&kd*Mst]A4C+7h^IY6':tTf#rrjV\k&?r0V,cJ\&G%,X[>2-c>.iX/?`l'kl&Y
Wa=/8a_:Ig;bg4W/bE=;,Wb@DFTmHAo@QaJMQ`_90p9$Z+!RYSY1F"P8"?:7'`d;Bs9WTKoO
C&bh.QHq9N"3)`p=c':j^G&*fi.%^S+hE8'c#W]A3Yur89&^Rr29BI3FZ;?j:o&K3U0]AmSkVI
@s@f*6B:!IP6lcMab^D%=itAIFOWHrQpYWG"iOZLhFMS1g&ZhBqE$q'?dO&H8ji`7+t4Mlg#
d'B\j>D<f-P^_qSSk]A\!?E\p:UM+C")mq*>R5ujM`_\E"]ATCT#<.]AYorQR[^eR."ilAP5a!9
8/I]AoO"_Nd1*B`^9'Pl>%Qp3jY9fmU#"Jo9P\oPi`0UeVm(*Pgm<r_q,1^HBa*n#FplRcrQO
rY?:rUq/Y3Jea'X=&.^,s6/'#WuMrn3l7,>@k1!q)ac$UUG3-j`%,/kifqHa$gVJA$7+Pb2q
L:%2j?['8+mns/%hr$VOc'e#r(cI'>N/8d=i:oB[Z>JEfh2ZSs<O7G(kcmu)\`1b)M3Ue9rn
j"7W>jiO]Ad.6VCO"#99n2bVm(H%21=or1e86X?V?'jl&"7P-b5\7m%p@BGon-U`NAutnVPQ-
TG3?5.g%4''r3-?IM^t"KI>Jj:4)mgdda)I:@=./\5WJ.igOke`J+85SPpjFo#'86CCO+K4O
j:0$&1<c`Y>s#gSSrR>PPlDh&[V>9E5Uu@/>e25p,u\.9KX@SVd=naA0h.6nuN^p1Eun>(bi
`m+rIIZgg`lh>o=$89=']A8O]A-IR%UKG_&L:Sh`_RK4J\.#lK?J:==V*de8[WFq&?O(t?^P&:
jiG1(1+\Ommg:V.E5#ja5,/7T#/=_S=-0L#'/cYjl)/#:Q,RAjTbZq%2T7&/@Y7H332p,!Rp
MUHh,o\kTh6SR^h)Y7`\:3pV03i";qfNQ$j&h:2o'CZXH*cFOUo@m2r-HF:\S*e5^.Re=J3l
p%q4LZ?ThQ<dndNpRXLKlm>)fMCe5B7Q8_!01GSpBmFj/0I:aHcApef;!Ft^0gP2Rg(^_Z68
+_7HNF1ApRY)uK&`tU)3ZG0WhO9'Oq<`,trVlfENKG'oW\cH:45AW^m7`I`eIpjuAksRCeJg
arn)5kndDi_\T?5>o$LA:7,X__&gk=P;Mr)Qr^=,F^%9Z5g<FP:M0%B6h4sHG5]A]A-;'mY.LT
,*dW)KA:]AUUoN(7WJU`E,F+`%>[6S<^PdO!@6H]AC2Vaj@W3n).*3eb`H.^Sga+Ynl\W"Z5nQ
^:e1\Y2p?39U);N3,D\u%b,J[G[eEJ3/FAb,Qdi^A8i>gPH8X2.*/%3OBHerVrQQm@oM1Fb=
r%]A]AdJR#mLEA';V_P/Wm3q0E!KA'9>1#:cj>\rZ4D%j3Fdd2k-#4G?[p\7JngjVg'GGi6P(2
G@u)l&3uHApjVBc&;,/I`397:fQG`*'7WR<%5$ec@2n]A/<3Ol_G1/QOQp4WT=_pO,fm7^SnZ
nQ?mZ,FIR]AWb]AN:.=f&2!N]ATgj7E+.WXl1\*8'`#g(lFl^,n\@Xr)gX7R'\!Zd``TrK#29<t
8r.Ys\G]Aq)KBP^MeMGH8BJ%+6ME+i+%feL6N2UR=WQ/1TlQIF0N2BA=/-^/\h5H.T(d9#89\
>BdR@P.%lm99qd?uq,*n7._k']AI<(aJb)VAss"#6%^s.7>5G3Grl:i65Um6pI66dH$Aa3&,=
k>I.>gV/J&9rHp+YB$+@k-iOs+aODhE3RbTNq8@P(&$p*:C<b(1?M-OjGGrn'ImKl..(9[@V
=*qWk@KlBK`r',K+sN5fqeD,D/S/nB9me.@M[e?4nJS20#/A#UgbU7fV@/b\^4HUh=!HQ2Zt
"?lb/OL`OR5Va[="@;/"15Z9!>IF3.Ng'Sg<Z4PT+,<u^$Zf@>FO:V/(J9+n/Zo"NPp)2Q]Au
#WG/'MSp,`Kb2Ah*$:_DhBJ[l!j3Vk1.go$BA&p3m&W[ibn+3!mA$WVNfGE2oE0R_+\?#h==
L/42bQ%N0ER^a4T2)DK$m[Xhd-E'h[*t^3_2_#4*k>WbH0IqB9J_jkuTg\^0eYg?57EC=gYP
P5c/o!>B8"_B]A#>8,8fg!6_#Q,ZS:+t"Y%K@MY.9Pn#DI%X&Fg8C5f>;!,OSiJ+d)OTH&`">
0J-BOk)l,N?'1q+0guQ6RU::Y7ZdJYB)(DLErmtT*FGD-VmN$KJaSc`<AN+LE.52V\sWreLX
T5(kW_hj:/T?8lOVRR%2%@b*`Kbr^G$mk3.ql"1:i-PIqu>1M@B"Nr&9repoup2?)-O+?=,X
=%;L(5hJ/C"T'K2HqdOWU3&$WW=RrnT")N.83Qt.T;A[eTCd\q6#f2*H-XdD[7M$uRjnZc&/
)]A&LV-GmKS^<!UFF"^Z"X2S3iIuhVYS6T=SiZqAQJb\*emH?`DhJ[l<G)m?G%R>XCinm-fAX
ZR&?T,2WfmOB+-QO@))K>cFsG2%:mHU-=>7@\%O>bV^ZRnKEm0qato5:<B5S]AZq.$R9@%9t*
qMo@ScBo;BL_k/M]AUX%1PkO:cm5RF/BmdKFO]AG/fuu-qVCDd3bIZI-a!.Z-ohir<<G=]A#Wbr
el#!#XdL%(N'I!^J)O+;D.[=(VR;fuH"nIHc&F!n6:EIOD_GE!Fhns.%!<<^WF;[<QeZ.juf
bT]ACp0^?!*JYMGg80tHt96bu,4c5^!=F3):=++U^jtULG8CIDQ%%qT<GFW#,^6knk8HCa;ZN
MeHjFpR/JaJd.6k@`^/rRXA0*M]AnhPcm#r.:?h*i:/Qh:Cf>+*H<jWD0jn*nKqf2\F"p+:Y$
ddCWb>ft5jb7KnO&T,E-M$C(gqdu9[Uet+9q;oQcn`"XUA>UkOZ;K['aaXENP4;>tpdDa?5(
YsTk]A9Fpp'6!R;_ZQ#!=TV1)4[+mPp_h<)_T>Fn@"m[>=B<VkdKC:%N@XHs"g6,ij0AZ`qNf
;KNH+V#:)7BU0tuh\R^p653`#cu8l+oK!g8-FXDeAq#rk6P*W%r(;7U9?TN[*(/hr=gCnFbh
H\k^H(R8cMRTdU@,Xd[giQAECK`:`U_"-t<pJP*hm9$.6Q4-c`j'9?jM,_LpjLuH5iZT1HP/
I9#Ta+bGnE92fDC06S1YSs$_1s7Ld5=c=m.W6B*=G@[VG8fH96A<.Og7$>XT2UN$Y@9?]A0NM
@'l=jsM1)=d\OS%S?OLQ1S(_"p)WAdrO.VO3XLRmZkd$=hJuMYD1.X&bm29@]A(fVO>I(QRrW
pZ*R]A#Mqb,*EEC!Q#'C'9Rq6P2oE%10&nX4RX0F>\'?0n29\fA[Lm<R*8+j_q(HJS.M'cTn$
6:i]AhL/AB.B9ecR,A+*/2SYG99uV;m=L38_C8EejqpU%=Il#fKpX$BkT1NCYGc5b`Al:&lQt
A]A.kB6+S&@SmTt_!rR]AtP`]AJ'f)]AB2dQ@E=of_!\7^\Y5>"gC&"KZ@5CuVDYEjEJfnurudQE
HXkI]A.916ZOkXC<1ZU^O@6i"4chbB5>0=^1VBhq__/R8RrOZTmfnK_8eN:aKZ`gJjrF.UEo<
dFENFkM@fPl8Va(lQfRp:AejOV*$>/s!EauKCg*MS8-FA27c["\N"Z!g;#!:C%2"&>*;n7sH
-X[*]A>k-0kN9u,jafXm]Ae:[E>Tr2AV38Wi`IdUK_hm+OMc@lfr(=d!<;I^#18@"[olP`i_t!
)&fN/V/WPg?%=aT#n.kVRU3m0,d>GgLfX"<<rK;uGBYlCYX1fkF49YM_Y&Z)5skkpCsro1lt
Hh,mmFgk_uVu<Hem?OJ\gd^1@iQ&DJ/%A:Qok^r6IFdNBF]A2)#0&[aRo<bUn&d%KnMN:aLOa
!IS3?dY]A-YG7CWn6\mFOiG`n_C>XO)ZULSoK9u)@!(oT&9sD//0jh`);6.:h"g4Jbq7Dojr*
5;>tq;`M%<q;>a>'9SD>YW+W+M4Q\K;_.+^=J]Af$=Q>+'c(#uOl_>3nEqh`aAdf!&/[Qp$^N
n$;.&hCM,'[!NtpkFrTG1MVX1Dh(Vd=7^M\tR2q!^lLW(Vm:^-iWi!VCtdkoIe_CnP\3r1@>
WnH("ODXh@@uFk"9\m.oP>(1>FQAg7s#"-Vh0:Y/u6`$,BLGMMD@jS(@U<<93IJR7V!L.=i\
Qa@EW.\)jomjPs_[LZQdp=-O'mnF[Cdd:d!-e\lq7BV*k'aF*L4@4"6)4poP;S(&jc+7oH2.
8paCT/U?JK*[,R_/uAiL9!"o[T=BWLS7?@XFjki`iQ#Jfs9_2Ql9[AOkndK0m@o-*7D+\%L(
9MA<9Jl]A8U[I!7"80pD7Cpfg$>J'<m.WKjef]A+RtQ@T4bMiBk+l\Wg-ibu?Q1o%YKLYPV#%E
V,pNHT92kX'@R;<C)U"R+s[`P)&K)<4-<uF+4M\Yt'kq&\pBG$&8G?fK%.N`q!X:!m7__ZLY
s$[ZWg79kdYZJP^udK1q8L^P3R!Zsj*@o=G]A2ee^GDf'mYIY,tmamV<riYRSn0?GVR>]AYVKg
F=;g9o>P=G3LQQp2aq:'@jur#S"def9I3D\0RB\EXhP^),7*YXGQ1\Qad"P_NuY8tS>*Vc(5
TE\3JB8r4]A"d9_9al9[i\Hg"b6^;LGGfSAt+^OEJnq#q&N"@gT-KgQs+gq[PVB<jF"c7n</f
TQG"Zo"lD_73m:FO0f;R;NPIOnK2P'iI,o?V^*E3tRR'_r!oi7-,TdRqIt@_t@N!5CEettNL
6u@Ed/HB+q*h;m3NM"P`6\_.Fd;'d-=brO8Ll^sb6#^VB$&-HEi`hRHm#m]A#]AuP+e`I@nA3k
r(;54T%#Gk-.s6iRq4eirI`u]Ai:5VCVSbGo/7s5hQ^dYKGS8p/'J=gl:IV%7*cijP2[+XO)0
!+N>\s3UZH6DP3hS6DY/%FolI`ud+e?GaocPFE@la"LiaT#CgOSBK5YSX1.6Z]A\BucF$fNC0
P+b%L/anVB,L6P]A"/kmk+`bc`07*$$=!+CZWF,eE2DJ)0CNo6mmC`?\Gb0Mi`5Kh0u5Ha?;_
VBd^t1>ntr7BaYe5p3d`RJs9brN9.2?0(.AHNAANefXVlB^0fAQ82PT9$ZEg(4IYX-kW/[!4
cZGW;(XMS-9j.p?ZC6,T#bC[a#7e=^^pnJMAW;:XSjeo(JehA\@<"BW.q49R/>Ihr@ljF&2C
K3j8K2YM94!m/Ge&8nMk9CHq8C/X"'0Q$Y]AF=\sYKI[i"%7@e*h,4_.jpZ'Q(F!YjLhgqq.]A
\`91O$h^BB5\.-u,r+K"$B'$[cn@o;8j^?37:DUjSgLEf`9[MIYo!hS)t)N+%=_<R[8K(*<5
PuZW.]A4hQ6*L&/rA<QV\A$ZLSt\FII4_GY22)!m4H[#U38M_H%>)"jg^ZCQ)JES]AVEP]A!XEh
'QW?4f]A$&d7]ACVgW.(-,BS>5:qH1Vf>Ha$jD!]A2)@I:>TA*k2(Wl-n<$om-o3#.%=eAV'k7n
Zr`j+/[q'(IRd2qN?o,&YN_"M:2(3=Y!;7dc+R)Qj4?kJlWNSnR<FU$3@<@2Y(s97Stj1[De
6,3=*49L"OAK3b>0gJ#EkP<[Njr+M!)B4.N\uHFEo[S"="ajA12kUBP-JpsQkD9fhI']A0@G?
es"tBJ+O*:8&p*cr[Q?;!/Rd$P0!HBbp'9J+`c1`\^3qg+Z1$7>itah2@=sT<'?(G>70Tc1[
tUhAmOSi*8SL6`(XnLA35hAE(X1eh41$5jH&+)C5Y1`bcorqHgqbCTg5s<^A,\Qr?lF'd`(,
AAS'Tq!r~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="160"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="true"/>
<MobileWidgetList>
<Widget widgetName="标题"/>
<Widget widgetName="航季"/>
<Widget widgetName="指标卡"/>
<Widget widgetName="地图"/>
<Widget widgetName="主舱利用率"/>
<Widget widgetName="闲置舱位"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="1"/>
<AppRelayout appRelayout="true"/>
<Size width="375" height="1300"/>
<ResolutionScalingAttr percent="1.2"/>
<BodyLayoutType type="0"/>
</Center>
</Layout>
<DesignerVersion DesignerVersion="KAA"/>
<PreviewType PreviewType="4"/>
<WatermarkAttr class="com.fr.base.iofile.attr.WatermarkAttr">
<WatermarkAttr fontSize="20" color="-6710887" horizontalGap="200" verticalGap="100" valid="false">
<Text>
<![CDATA[]]></Text>
</WatermarkAttr>
</WatermarkAttr>
<MobileOnlyTemplateAttrMark class="com.fr.base.iofile.attr.MobileOnlyTemplateAttrMark"/>
<StrategyConfigsAttr class="com.fr.esd.core.strategy.persistence.StrategyConfigsAttr" pluginID="com.fr.plugin.esd" plugin-version="1.5.4">
<StrategyConfigs/>
</StrategyConfigsAttr>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="029b9d0a-8b22-4ab3-b00c-9a56c797685b"/>
</TemplateIdAttMark>
<TemplateCloudInfoAttrMark class="com.fr.plugin.cloud.analytics.attr.TemplateInfoAttrMark" pluginID="com.fr.plugin.cloud.analytics.v10" plugin-version="2.2.0.20210728">
<TemplateCloudInfoAttrMark createTime="1627870624150"/>
</TemplateCloudInfoAttrMark>
</Form>
