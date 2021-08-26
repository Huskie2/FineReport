<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="飞机架次" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[机务体系数据源_10.33.2.25_me_enter]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
      '机群' 机型,
      count(*) 架次
from dim_sh_aircraft_info_df 
where 1=1 
  and status_name = '运行'
  and substr(ac_op_date,1,10) < date_format(now(),'%Y-%m-%d')
union all
select 
      mp_ac_type 机型,
      count(*) 架次
from dim_sh_aircraft_info_df 
where 1=1 
  and status_name = '运行'
  and substr(ac_op_date,1,10) < date_format(now(),'%Y-%m-%d')
group by mp_ac_type]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="非计划拆换年度" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="jx"/>
<O>
<![CDATA[机群]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[机务体系数据源_10.33.2.25_me_enter]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
      year as 分类, 
      unschswaps 非计划拆换次数,
      unschswaprate 非计划拆换千时率
from dws_sh_me_cm_unscheduledswap_1m_mi_ata
where 1 =1 
  and interval_dim = 'yearly'
  and aircraftdim = 'fleet'
  and componenctdim = ''
  and '${jx}' = "机群"
union all
select 
      year as 分类, 
      unschswaps 非计划拆换次数,
      unschswaprate 非计划拆换千时率
from dws_sh_me_cm_unscheduledswap_1m_mi_ata
where 1 =1 
  and interval_dim = 'yearly' 
  and aircraftdim = 'modelx'
  and aircraftstatis = '${jx}'
  and '${jx}' != "机群"
  and componenctdim = ''
order by 分类]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="非计划拆换月度" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="year"/>
<O>
<![CDATA[2021]]></O>
</Parameter>
<Parameter>
<Attributes name="jx"/>
<O>
<![CDATA[机群]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[机务体系数据源_10.33.2.25_me_enter]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
      concat(t.year,t.interval_info) 时间,
      t.unschswaps 非计划拆换次数,
      t.unschswaps_tm 三月非计划拆换次数,
      t.unschswaprate 非计划拆换千时率,
      a.tq_unschswaprate 同期非计划拆换千时率
from dws_sh_me_cm_unscheduledswap_1m_mi_ata t
left join (
select 
      cast(t.year+1 as char) tq_year,
      t.interval_info tq_month,
      unschswaprate tq_unschswaprate 
from dws_sh_me_cm_unscheduledswap_1m_mi_ata t  
where year = ${year}-1
  and aircraftdim = 'fleet' 
  and '${jx}' = "机群"
  and interval_dim = 'monthly'
  and componenctdim = ''
  and componenstatis = ''
) a on a.tq_year= t.year and a.tq_month = t.interval_info
where concat(year,interval_info) <> date_format(curdate(),'%Y%m')
  and year = ${year}
  and interval_dim = 'monthly'
  and aircraftdim = 'fleet' 
  and '${jx}' = "机群"
  and componenctdim = ''
  and componenstatis = ''
union all
select 
      concat(t.year,t.interval_info) 时间,
      t.unschswaps 非计划拆换次数,
      t.unschswaps_tm 三月非计划拆换次数,
      t.unschswaprate 非计划拆换千时率,
      a.tq_unschswaprate 同期非计划拆换千时率
from dws_sh_me_cm_unscheduledswap_1m_mi_ata t
left join (
select 
      cast(t.year+1 as char) tq_year,
      t.interval_info tq_month,
      unschswaprate tq_unschswaprate 
from dws_sh_me_cm_unscheduledswap_1m_mi_ata t  
where year = ${year}-1
  and aircraftdim = 'modelx' 
  and aircraftstatis = '${jx}'
  and interval_dim = 'monthly'
  and componenctdim = ''
  and componenstatis = ''
  and '${jx}' != "机群"
) a on a.tq_year= t.year and a.tq_month = t.interval_info
where concat(year,interval_info) <> date_format(curdate(),'%Y%m')
  and year = ${year}
  and interval_dim = 'monthly'
  and aircraftdim = 'modelx' 
  and aircraftstatis = '${jx}'
  and componenctdim = ''
  and componenstatis = ''
  and '${jx}' != "机群"
order by 时间]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="故障率年度" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="jx2"/>
<O>
<![CDATA[机群]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[机务体系数据源_10.33.2.25_me_enter]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select * from (
select 
      a.year 年份,
      a.defs 故障数,
      a.defs_rate 故障千次率,
      b.warn_val_01 警戒值 
from ads_sh_me_defect_report a
join (
select year,def_warn_val as warn_val_01 from ads_sh_me_defect_report
where type_code2 = 'FLEET'
and month = '1'
and type_code1 is null
) b
on a.year = b.year
where type_code2 = 'FLEET'
and month is null
and type_code1 is null
and '${jx2}' = '机群'
union all
select 
      a.year 年份,
      a.defs 故障数,
      a.defs_rate 故障千次率,
      b.warn_val_01 警戒值 
from ads_sh_me_defect_report a
join (
select year,def_warn_val as warn_val_01 from ads_sh_me_defect_report
where type_code2 = 'FLEET'
and month = '1'
and type_code1 is null
) b
on a.year = b.year
where type_code2 = 'MODEL'
and month is null
and type_code1 is null
and '${jx2}' != '机群'
and type_val2 = '${jx2}'
) t
order by 年份]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="故障率月度" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="jx2"/>
<O>
<![CDATA[机群]]></O>
</Parameter>
<Parameter>
<Attributes name="year1"/>
<O>
<![CDATA[2021]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[机务体系数据源_10.33.2.25_me_enter]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
      concat(a.year,if(length(a.month)=1,0,""),a.month) 年月,
      a.pilot 机组报告故障数,
      a.gnd 地面报告故障数,
      a.pilot_3 "机组报告故障数(3个月)",
      a.gnd_3 "地面报告故障数(3个月)",
      a.defs_3 故障数,
      a.defs_rate 故障千次率,
      b.warn_val_01 警戒值 
from ads_sh_me_defect_report a
cross join (select def_warn_val as warn_val_01 from ads_sh_me_defect_report
where type_code2 = 'FLEET'
and month = '1'
and year = '${year1}'
and type_code1 is null
) b
where type_code2 = 'FLEET'
and type_code1 is null 
and month is not null
and year = '${year1}'
and '${jx2}' = '机群'
union all
select 
      concat(a.year,if(length(a.month)=1,0,""),a.month) 年月,
      a.pilot 机组报告故障数,
      a.gnd 地面报告故障数,
      a.pilot_3 "机组报告故障数(3个月)",
      a.gnd_3 "地面报告故障数(3个月)",
      a.defs_3 故障数,
      a.defs_rate 故障千次率,
      b.warn_val_01 警戒值 
from ads_sh_me_defect_report a
cross join (select def_warn_val as warn_val_01 from ads_sh_me_defect_report
where '${jx2}' != '机群'
and type_val2 = '${jx2}'
and month = '1'
and year = '${year1}'
and type_code1 is null
) b
where type_code2 = 'MODEL'
and type_code1 is null 
and month is not null
and '${jx2}' != '机群'
and type_val2 = '${jx2}'
and year = '${year1}'
order by 年月]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="明细清单" class="com.fr.data.impl.DBTableData">
<Parameters/>
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
      b.机龄,
      a.defs 故障数,
      a.defs_rate 故障千次率,
      c.故障数 故障保留数,
      d.故障数 故障open数
from ads_sh_me_defect_report a
left join (
select 
      distinct 
      ac_reg,
      mp_ac_type, 
      date_format(factory_date,'%Y-%m-%d') 出厂日期,
      datediff(curdate(),factory_date)/365 机龄
from dim_sh_aircraft_info_df
where status_name = '运行'
) b on a.type_val2=b.ac_reg
left join (
select 
      model 机型,
      ac_reg 机号,
      count(*) 故障数
from dwd_sh_me_defect_info_dtl_df
where date_format(date_found,'%Y') = '2021'
  and date_format(date_found,'%m') = '07'
  and deferred_no is not null
group by model,ac_reg
) c on a.type_val2 = c.机号
left join (
select 
      model 机型,
      ac_reg 机号,
      count(*) 故障数
from dwd_sh_me_defect_info_dtl_df
where date_format(date_found,'%Y') = '2021'
  and date_format(date_found,'%m') = '07'
  and status = 'open'
group by model,ac_reg
) d on a.type_val2 = d.机号
where a.year = '2021'
  and if(length(a.month)=1,concat('0',a.month),a.month) = '07'
  and a.month is not null
  and type_code1 is null 
  and type_code2 = 'ACNO']]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="二位章节号" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="jx2"/>
<O>
<![CDATA[机群]]></O>
</Parameter>
<Parameter>
<Attributes name="year1"/>
<O>
<![CDATA[2021]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[机务体系数据源_10.33.2.25_me_enter]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
      a.年份,
      a.机型,
      case when a.排序 <= 10 then a.二位章节号 else '其他' end 二位章节号,
      case when a.排序 <= 10 then a.排序 else '其他' end 分类,
      sum(故障数) 故障数,
      sum(故障数)/avg(总故障数) 占比
from (
select 
      year 年份,
      '机群' 机型,
      type_val1 二位章节号,
      cast(defs as signed) 故障数,
      t.总故障数,
      @curRank := @curRank + 1 AS 排序
from ads_sh_me_defect_report p,(select @curRank := 0) q
join (
select sum(defs) 总故障数 from ads_sh_me_defect_report where year = '${year1}'
   and month is null
   and type_code1 = 'ATA2'
   and type_code2 = 'FLEET') t
where year = '${year1}'
  and month is null
  and type_code1 = 'ATA2'
  and type_code2 = 'FLEET'
  and '${jx2}' = '机群'
order by 4 desc
) a
where a.排序 < 11
group by a.年份,
      a.机型,
      case when a.排序 <= 10 then a.二位章节号 else '其他' end,
      case when a.排序 <= 10 then a.排序 else '其他' end
union all
select
      a.年份,
      a.机型,
      case when a.排序 <= 10 then a.二位章节号 else '其他' end 二位章节号,
      case when a.排序 <= 10 then a.排序 else '其他' end 分类,
      sum(故障数) 故障数,
      sum(故障数)/avg(总故障数) 占比
from (
select 
      year 年份,
      '机群' 机型,
      type_val1 二位章节号,
      cast(defs as signed) 故障数,
      t.总故障数,
      @curRank := @curRank + 1 AS 排序
from ads_sh_me_defect_report p,(select @curRank := 0) q
join (
select sum(defs) 总故障数 from ads_sh_me_defect_report where year = '${year1}'
   and month is null
   and type_code1 = 'ATA2'
   and type_code2 = 'MODEL'
   and type_val2 = '${jx2}'
   and '${jx2}' != '机群') t
where year = '${year1}'
  and month is null
  and type_code1 = 'ATA2'
  and type_code2 = 'MODEL'
  and type_val2 = '${jx2}'
  and '${jx2}' != '机群'
order by 4 desc
) a
where a.排序 < 11
group by a.年份,
      a.机型,
      case when a.排序 <= 10 then a.二位章节号 else '其他' end,
      case when a.排序 <= 10 then a.排序 else '其他' end
order by case 分类 when 1 then 1  
                    when 2 then 2 
                     when 3 then 3 
                      when 4 then 4 
                       when 5 then 5 
                        when 6 then 6 
                         when 7 then 7 
                          when 8 then 8 
                           when 9 then 9
                            when 10 then 10
                             else 11 end]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="百分比" class="com.fr.data.impl.EmbeddedTableData">
<Parameters/>
<DSName>
<![CDATA[]]></DSName>
<ColumnNames>
<![CDATA[百分比]]></ColumnNames>
<ColumnTypes>
<![CDATA[java.lang.String]]></ColumnTypes>
<RowData ColumnTypes="java.lang.String">
<![CDATA[1Gqu4!!~
]]></RowData>
</TableData>
<TableData name="四位章节号" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="jx2"/>
<O>
<![CDATA[机群]]></O>
</Parameter>
<Parameter>
<Attributes name="year1"/>
<O>
<![CDATA[2021]]></O>
</Parameter>
<Parameter>
<Attributes name="type"/>
<O>
<![CDATA[34]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[机务体系数据源_10.33.2.25_me_enter]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
      a.年份,
      a.机型,
      case when a.排序 <= 10 then a.四位章节号 else '其他' end 四位章节号,
      case when a.排序 <= 10 then a.排序 else '其他' end 分类,
      sum(故障数) 故障数,
      sum(故障数)/avg(总故障数) 占比
from (
select 
      year 年份,
      '机群' 机型,
      type_val1 四位章节号,
      cast(defs as signed) 故障数,
      t.总故障数,
      @curRank := @curRank + 1 AS 排序
from ads_sh_me_defect_report p,(select @curRank := 0) q
join (
select sum(defs) 总故障数 from ads_sh_me_defect_report where year = '${year1}'
   and month is null
   and type_code1 = 'ATA4'
   and type_code2 = 'FLEET'
   and left(type_val1,2) = '${type}' ) t
where year = '${year1}'
  and month is null
  and type_code1 = 'ATA4'
  and type_code2 = 'FLEET'
  and '${jx2}' = '机群'
  and left(type_val1,2) = '${type}' 
order by 4 desc
) a
where a.排序 < 11
group by a.年份,
      a.机型,
      case when a.排序 <= 10 then a.四位章节号 else '其他' end,
      case when a.排序 <= 10 then a.排序 else '其他' end
union all
select
      a.年份,
      a.机型,
      case when a.排序 <= 10 then a.四位章节号 else '其他' end 四位章节号,
      case when a.排序 <= 10 then a.排序 else '其他' end 分类,
      sum(故障数) 故障数,
      sum(故障数)/avg(总故障数) 占比
from (
select 
      year 年份,
      '机群' 机型,
      type_val1 四位章节号,
      cast(defs as signed) 故障数,
      t.总故障数,
      @curRank := @curRank + 1 AS 排序
from ads_sh_me_defect_report p,(select @curRank := 0) q
join (
select sum(defs) 总故障数 from ads_sh_me_defect_report where year = '${year1}'
   and month is null
   and type_code1 = 'ATA4'
   and type_code2 = 'MODEL'
   and type_val2 = '${jx2}'
   and '${jx2}' != '机群'
   and left(type_val1,2) = '${type}' ) t
where year = '${year1}'
  and month is null
  and type_code1 = 'ATA4'
  and type_code2 = 'MODEL'
  and type_val2 = '${jx2}'
  and '${jx2}' != '机群'
  and left(type_val1,2) = '${type}' 
order by 4 desc
) a
where a.排序 < 11
group by a.年份,
      a.机型,
      case when a.排序 <= 10 then a.四位章节号 else '其他' end,
      case when a.排序 <= 10 then a.排序 else '其他' end
order by case 分类 when 1 then 1  
                    when 2 then 2 
                     when 3 then 3 
                      when 4 then 4 
                       when 5 then 5 
                        when 6 then 6 
                         when 7 then 7 
                          when 8 then 8 
                           when 9 then 9
                            when 10 then 10
                             else 11 end]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="ATA2第一" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="jx2"/>
<O>
<![CDATA[机群]]></O>
</Parameter>
<Parameter>
<Attributes name="year1"/>
<O>
<![CDATA[2021]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[机务体系数据源_10.33.2.25_me_enter]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
      a.年份,
      a.机型,
      a.二位章节号
from (
select 
      year 年份,
      '机群' 机型,
      type_val1 二位章节号,
      cast(defs as signed) 故障数,
      @curRank := @curRank + 1 AS 排序
from ads_sh_me_defect_report p,(select @curRank := 0) q
where year = '${year1}'
  and month is null
  and type_code1 = 'ATA2'
  and type_code2 = 'FLEET'
  and '${jx2}' = '机群'
order by 4 desc
) a
where a.排序 = 1
union all
select
      a.年份,
      a.机型,
      a.二位章节号
from (
select 
      year 年份,
      type_val2 机型,
      type_val1 二位章节号,
      cast(defs as signed) 故障数,
      @curRank := @curRank + 1 AS 排序
from ads_sh_me_defect_report p,(select @curRank := 0) q
where year = '${year1}'
  and month is null
  and type_code1 = 'ATA2'
  and type_code2 = 'MODEL'
  and type_val2 = '${jx2}'
  and '${jx2}' != '机群'
order by 4 desc
) a
where a.排序 = 1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
</TableDataMap>
<FormMobileAttr>
<FormMobileAttr refresh="false" isUseHTML="false" isMobileOnly="true" isAdaptivePropertyAutoMatch="true" appearRefresh="false" promptWhenLeaveWithoutSubmit="false" allowDoubleClickOrZoom="false"/>
</FormMobileAttr>
<Parameters>
<Parameter>
<Attributes name="type"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=ATA2第一.value(1,3)]]></Attributes>
</O>
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
<appFormBodyPadding class="com.fr.base.iofile.attr.FormBodyPaddingAttrMark">
<appFormBodyPadding interval="4">
<Margin top="4" left="4" bottom="4" right="4"/>
</appFormBodyPadding>
</appFormBodyPadding>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.cardlayout.WCardMainBorderLayout">
<WidgetName name="tablayout0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="tablayout0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-723724" borderRadius="0" type="1" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Position pos="0"/>
<Background name="ColorBackground" color="-13400848"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<ShowBookmarks showBookmarks="false"/>
<NorthAttr size="25"/>
<North class="com.fr.form.ui.container.cardlayout.WCardTitleLayout">
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
<EastAttr size="25"/>
<East class="com.fr.form.ui.CardAddButton">
<WidgetName name="Add"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<AddTagAttr layoutName="cardlayout0"/>
</East>
<Center class="com.fr.form.ui.container.cardlayout.WCardTagLayout">
<WidgetName name="tabpane0"/>
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
<appFormTabPadding class="com.fr.base.iofile.attr.FormTabPaddingAttrMark">
<appFormTabPadding interval="4">
<Margin top="4" left="4" bottom="4" right="4"/>
</appFormTabPadding>
</appFormTabPadding>
<LCAttr vgap="0" hgap="1" compInterval="0"/>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="57bf116c-f0c0-4c27-a41a-d7764daa062d"/>
<WidgetAttr invisible="true" description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[非计划拆换千时率]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout0"/>
</Widget>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="433e78a1-7ef4-408a-9e48-06f6a7292921"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[故障千次率]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<SwitchTagAttr layoutName="cardlayout0" index="1"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<DisplayPosition type="0"/>
<FLAttr alignment="0"/>
<ColumnWidth defaultValue="80">
<![CDATA[80,80,80,80,80,80,80,80,80,80,80]]></ColumnWidth>
<FRFont name="微软雅黑" style="0" size="80"/>
<TextDirection type="0"/>
<TemplateStyle class="com.fr.general.cardtag.DefaultTemplateStyle"/>
<MobileTemplateStyle class="com.fr.general.cardtag.mobile.UpMenuStyle">
<initialColor color="-855310"/>
<selectColor color="-5318927"/>
<TabCommonConfig showTitle="true" showDotIndicator="false" canSlide="false" dotIndicatorPositionType="0" indicatorInitialColor="-1381654" indicatorSelectColor="-3355444"/>
<extraConfig gapFix="false" titleWidthFix="true" minTabWidth="92"/>
<bottomBorder lineStyle="0" lineColor="-7223378"/>
<underline lineStyle="0" lineColor="-12802576"/>
<tabFontConfig selectFontColor="-15386770">
<FRFont name="微软雅黑" style="0" size="96" foreground="-10258019"/>
</tabFontConfig>
<custom custom="true"/>
</MobileTemplateStyle>
</Center>
<CardTitleLayout layoutName="cardlayout0"/>
</North>
<Center class="com.fr.form.ui.container.WCardLayout">
<WidgetName name="cardlayout0"/>
<WidgetID widgetID="518bdec7-fea3-47c8-a044-869a758aa916"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-855310" borderRadius="0" type="1" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="微软雅黑" style="0" size="80"/>
<Position pos="0"/>
<Background name="ColorBackground" color="-13400848"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="非计划拆换千时率"/>
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
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="absolute0"/>
<WidgetID widgetID="df25b987-cc1c-4603-9db0-06c920116eef"/>
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
<InnerWidget class="com.fr.form.ui.RadioGroup">
<WidgetName name="jx"/>
<WidgetID widgetID="bf4b6fc2-d4cf-448f-9e94-b7d2e4c6d847"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="radioGroup0" frozen="false"/>
<PrivilegeControl/>
<MobileStyle class="com.fr.form.ui.mobile.DefaultMobileStyle" isCustom="true" borderType="0" borderRadius="6.0" iconColor="-14701083">
<Background name="ColorBackground"/>
<FRFont name="SimSun" style="0" size="96" foreground="-15386770"/>
</MobileStyle>
</WidgetAttr>
<Dictionary class="com.fr.data.impl.CustomDictionary">
<CustomDictAttr>
<Dict key="机群" value="机群"/>
<Dict key="B737" value="B737"/>
<Dict key="B747" value="B747"/>
<Dict key="B757" value="B757"/>
<Dict key="B767" value="B767"/>
</CustomDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[机群]]></O>
</widgetValue>
<BGAttr columnsInRow="5"/>
<NotAdaptive/>
<MaxRowsMobileAttr maxShowRows="1"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="450" height="60"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report1_c_c_c"/>
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
<WidgetName name="report1_c_c_c"/>
<WidgetID widgetID="83ed78ec-be24-48ac-9056-12ca3874bbfa"/>
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
<![CDATA[1295400,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,144000,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[  次数]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="1">
<O>
<![CDATA[千时率(‰) ]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" cs="7" rs="15">
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
<Attr position="3" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="5"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
</Attr>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="0" align="9" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="条件属性1">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-10325122"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[非计划拆换次数]]></O>
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
<NameJavaScriptGroup>
<NameJavaScript name="图表超链-联动单元格1">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<Parameters>
<Parameter>
<Attributes name="year"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=CATEGORY]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="500" height="270"/>
<realateName realateValue="A18" animateType="none"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="1" align="9" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
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
<Background name="ColorBackground" color="-4049615"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[非计划拆换千时率]]></O>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<OneValueCDDefinition seriesName="无" valueName="非计划拆换次数" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[非计划拆换年度]]></Name>
</TableData>
<CategoryName value="分类"/>
</OneValueCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<OneValueCDDefinition seriesName="无" valueName="非计划拆换千时率" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[非计划拆换年度]]></Name>
</TableData>
<CategoryName value="分类"/>
</OneValueCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="749307c6-eed4-4032-b54f-451138f58446"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="none"/>
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
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="17" cs="7" rs="15">
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
<Attr position="3" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="flow" customSize="false" maxHeight="30.0" isHighlight="true"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="3"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
</Attr>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="0" align="9" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="条件属性1">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-10325122"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[1]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="条件属性2">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-7223378"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[2]]></O>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="1" align="9" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="条件属性1">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-4049615"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[1]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="条件属性2">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-3504606"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="dashed" lineWidth="2.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[2]]></O>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="true"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[非计划拆换月度]]></Name>
</TableData>
<CategoryName value="时间"/>
<ChartSummaryColumn name="非计划拆换次数" function="com.fr.data.util.function.NoneFunction" customName="非计划拆换次数"/>
<ChartSummaryColumn name="三月非计划拆换次数" function="com.fr.data.util.function.NoneFunction" customName="三月非计划拆换次数"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="true"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[非计划拆换月度]]></Name>
</TableData>
<CategoryName value="时间"/>
<ChartSummaryColumn name="非计划拆换千时率" function="com.fr.data.util.function.NoneFunction" customName="非计划拆换千时率"/>
<ChartSummaryColumn name="同期非计划拆换千时率" function="com.fr.data.util.function.NoneFunction" customName="同期非计划拆换千时率"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="e7710192-2655-4e47-a9f0-c64d413c4ff8"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="none"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[XF+Y_;d%^11DU[XN(Qs/TJFrRK(KURKIBC[I1QtkkobNg(^hNRM+EgKkoBo&2^sk!d]A4La6t
uuR+gcV%E>7P\hY6kq]A[rDj'$o6BmBuA)heV\O!"Ce&"!&=$%1Ncam9;NWBP7m,BkVsFHgE0
Mc$#8S3Xs=qg"SHhlbI#m^NbL%lGf!d>J]Al7Fn-lIKo/`g'#O.0l_S0^25qr:DK'_]Aq1:[-g
F3=cVSdZd7pd87m5N#IpE+cl\U"0m"eulX0">YMH!Un@R;q9:mtYg$("MEt:"QYHg1$LDh)d
Tra>!s@Pr/b+Q<QmPQlV0(c3At;OAjo;VV0R@>9U;,L?j*'gn9>cl<)=.Y<eE/%m!kps)bd`
V?@Vk?TFTTSJN!9B(m!`SXAPg=(P=5"OcN&%=G`jBr?R10>6gS9e-e4_565d^2@b#)kX0JA6
KHQ7^r)<o7EAqWO.o'VG!_u:!Z5aJ;Pra;kcP0Vmu9Io:3u?G!D/h\b'.\5<=dZCHu@EP7#[
mcc#I=]A>Zoo8n0)^g()7.6MYgip"o"MjBRu>b<$M"cVb[pgJ[JPiKM*^-R["d=\S&F:QHjkJ
5$0_1(da,UeSRjJM&%+Yk@&dB[6P_>H"dV:$<d-Rm6S`R#2F(L0fh"lksB_bi;o*lfW[r?d.
U5VY8<+ak_eJEYiJ1VTP;`VHsHY#E)jj7Z7)le8W>:>K<6iR91B-d[9BL[9qGF&na/2MJZB=
o6krU2O#$5`*N"Dm&>kTa]Ailq-/kgP,G8*Ak[7mfi>oKEkMNM#U(K#u91.+U7S5\)+k=PSNW
"$oEaXgqGOSGQLro-:::5j8e[5:Lc9doPQR9s/akl>o7;2/g&/+!qZLd*As/$&$0n:7Zi95i
k[cDs^5AubJ3ik92Qj]ANWs0=F&qf7l5e;mdD_Z)l'kbU$i7RDU8e"lffU_Yf0mVM,,F]A/p#*
M0,imWc(]A8"L%#IbK%&:m2;BBhc:b's[+GKeq^:V$)FB_nRf%)lFRQ;YnV5)<NEeV8#-qOi`
?0V5(Z=_KR'tKgaXCIs!>.IY"Tjp,M0A\e(_!W_$tnEgDRP).oN@lrd&MS.0+7S8tpWoqt#k
4?iW0_jL:FI5hPLgWI,n`Yh(O[f1)W8:G:$_?9^]A([<@WfU-R<[dc<h0-#llf7M!^dZ2IDeo
eZZftstcQ<.I59af.G9+GXQ?AIsZOolpZMiob1B-]AX:`1ZXTn>,0>s'm/3i<;k2go_]A5H#Y,
[.dG67UJGYD><b&S;n'SU:+-j*3^6m*WK+KK$%(I8$K>j`g3r:6J#qppm`4GN^B]AMi(DJGn'
>hMi`YlfUan<tI`7MpBi/braM?ZK7-8DX1h\VmTH8bi=5D)u2eF?<khDts&QT9290@[]A@.21
q3O6/`1/k%+/ZhLoC2;O>MQ\..=pU7MZbRVniJ)0p]AG.cT-EPWGg0WV4E3\eCA?iLt[s"L`#
%BPA,iWC,`"VdkMXu&L<XeOIdM;)%';14N:iO1]A^F_rF"a4J"O2M4'Uoa\,\4XUcfrm=&N3'
&[$7fbV7WEHR!8PmrL\"o<"pH1<NY.jd)Pr`6d[5[mLSJ7i,k(ZcC]AVja2hp>?omJQ,DjXHA
Ahq(Ou0^)m2@U")90"WN,@%'I]AX#u*&b7]A7g.0T>W(>'Oo;VLC(neL":@1C[0n570&^<*_%7
aO3,PeQcIs#sMk0iil$i?Xu4B8T"Yb(Y7AF%%`\PKFSd$qDmApYc:2;)UZ[9L%[s4'cfZ&Fl
+HZ>U2qI&(]A[K;pm*llA^lI"-Xn*Gt-*^(S-_hjjsDm`D]A<6OLV<&QHJ+nSK;fWm[f9GeJ+'
+;a`l>ig5cDN]AE>24:fCQ.qIAbfEXea/#\,DO^ENR4K*0Lk$c32ISXI)oh%RI$LYFMi:>KIb
>\c><aR]A>95`n,F%o?Sb2IJ^5@GJe-goPgj2lWkB*UJ`B"mLW5=Hc)OY5RNZnkE1oNq?"F9Q
c1UVZ2[D'Z5`,A:_N>A-=.G&Z>/jo'sHO]A36r5M7FX3;7W(c1?]ARb%DeLK$it!jsGQ?E(G@a
mlFD-fVQ:*IW"MFpE)i,`_Df@i<:2^PR5^Z;o;0"M]AdH^f?u%+G;\tL\7KE0gbe.r"'Rrp?N
EDD>:]Aop/n%R>`kPb"Uh90;!+#Apra]A!.0%[N/G!-U5-c]A(4>$.U_?DMh"Nd,nEVIrm7R?0A
]AO#;dY*7S0#iiAQ]ABV2QKIJC^OV1VCG91D*ZXeihEZF)WG=6P=(9Bi+IW^33_)b)=7[-rg3I
4rS'lq#&4E=ELf5cH>i-Za5naI4KfirKuIYc76C-B]AH)f:i]A4K%/u7&`M_8nEdVGt:Jae^il
Pms0,1+0=\0W/*>H)L>%\NiIG;!O%+B@$9LC@WSMAH[+'HdjoTq>eD#^/i9#cYnVgc]ASO(;C
6A:c[I=_\=EFf$oGnJ[RF/OLU<kYb0B0$oKSXdUoq&tp-]A^H9CE/"aY-A;X%IaNO_M#7"NW?
H#jQ>,Bf`j(7O)c4CEtPATi?'/"p^Ro[lPY#X>@?k]A&M5&)%$"Xf'ff$TCeWe```ba+V<.(D
jWjn0KlsX_K']A=&U;lf[kscpD"'[AJ*DdYHfoJ^pqU`lFY6;B#02%S?HEQ@JX_<@$Ri)Asr@
=fn\J!k\l]AcmD$=CZd(]A^/D?'rG-P7<[]A!%DiYl%#s7r\$#+#IsKb7eWU.rs=_[)YfqZ^$>k
e_*!sfn^Qhh[g-O<Vlq?4feE??#/'sB\=RO3jb+jSE@9-=BE$qjWbJa,4OQ*dZI-Sc)eY$9>
3pUaqs3ejB[CmP<LODhZOp=u4_IaJn/G*^n!,Q/H2_L25Qk>7<*oVo967g9Wmp+Y`]AlhbU%u
;An@lVdZIL*:RQlB$PIIkWitu)VVlZdk;_T@f`Bh7inSI3_1"+6]A5oQ33MX\%;hV2O?nWU+]A
-;eZ#am_c<;lQ]A7]ABofi6<9.fT.;,'YDO1&npr_HBXuZ8&S-s0N`^#%=:YB7`FrpKdX+u2c(
FB9g0PQgc5A>kC4iGr?W5+;Y57P2p2hXO.K%_g;i+@YK;>D]A`N;\0Y7hB#D-GNS$Edt/F9[1
4RW&%#lH67fKe%aWL$?/%:8[Jnmtsipr`IWoe?SPME=X\G5.Fr%6:8Y[lP(-rh.;L'7/==cq
^(h#q?*T9%j->qbYilO]A\LOSZs>A,'<8A"AR)dX[a?cJL[_\tpU1klJKf1"@G9V*3<06KlI&
WXnr=,$QSU4?X%81;E>k:\Y.Z:_0]A^p=mha4B_sDlqPX91uDAb`nUR0E]Agq->e2mf4M9_Iss
ELj`D/-a?5F*gHEM9uB8DBFe_OD1ZB,OuVi)\88a,&oc:V&^.:%lH$rp+aCDJ@OQKDGU4lQg
V/RCG!]Ae&B_YBq]A^>`QkBKI$;l#_Q'FRMh'JDS<;Id'_"a^q%pc*,GqB_?,&Fgg&*'=V\TSc
30Q[6sgM\o*V_!6?I]A<oD<s;j.DJ@np6>soGIPc>eG52%'_/iUHBka_iFg&jfmeQ&!q<oss!
ss6iIk(L0b4>KCQ@L]A-!Q"?A%g.=n"6s3ojTYLAIXLi'q"gH@ri]A0QMnrV$:i?P-R_P-]AH#e
X5&*i$_#G>c/NIZ1Z;,$uj&&e3k>7&&2SqcD*Q"c;/!$]AF9nUNXbVVH\kn*W!)ds%"I!D(qa
J%(N(/nA/,34I&0h0i<cop)tCdEojm=SJ\HfmsNs4mU"*=(6_8h.k`[:>-9<dcp:G:0I9t&r
IZ`PH1#'k$0rj8_37g!:AXjD2qb#lQCVgWFp,BmL2kWUWErG39QH((ih,`;[#c782?^+&,*L
>mT)GD6^-$(YEp>(kPV.R@;Y#*89[J#\&2MTFk5[@)Ifj?7)QGViPV$i_.qG`=-3+:1G;Dd!
p%-99BiP/_Xqr-;@]APQNZ-N/MP0[5`Pso%i$H!47m5Tq8nT3^I>H6$D:5K/@_LU2B2(61[&*
dq4g"u=pTf@$0U1"TB5<NX2;r7_VH6hj)0O"g;Qf-5[\WQiDU/f`g`M3bX19RX.dla5"En/N
-`hJu]Ag!#J8X)NEAt0?Te9QqTf'AX-RC^^eKU^Z">,)Gm1n]A2?5?aSs.[\D@>8/%Z+=uLDaK
SA2(`=4^H<3'n9lDZ2RN"9R)(CS=S2I6'\4M_0;,u6gZ7=,P(r$UNS.jfk;F0F(/jTs<IWd=
a1T+GY0QV*;Na4I`2&c[8`69@)ETfLAL6?nLYAA9C8PX!2G7J!fi6Ir"!$hNWqGrtnghE]Al9
URb7$R%Io-qnbrA,>:^hc]A)_^m0+[dVsK\rE(VRd]Ag(XRiH(ohqq\4)Q/$I$G^Utm<'Q$W,Q
g69G,%Ln')@R"\V$U0+7"=rUP46oY3F"iV4j,-2S\@p84g_l`S"(iQR?PUiUF_"=SG$!;ESJ
c3(l^:7Ep&9)4NaMD;ne<BgUqoqVF`Hu?3f<]AheKaPBk4/54apn#>6M%Lp_Z_-Ai'i^qgUT'
]AoJpoTeK_O%Nk,:2CX!CHJgiU5#W$@./VmC\)#r%3E*_q<A:7s?am=koN=LcnR:J+ds=7MVA
+C(,#R*dtCR.$haNom,19kY>lWD6>?tq\?7[)9ar#LTqNGeP(WL&!/)6hdT6f82tl6oE=PFo
>%TfpU2BrE!%UEN&!2d<tgVh#nQsl?'))#QNR7gQYmS>@3YA8\:Epcs!GB'o4b:?Bu?qu8$(
qk`SAZ^^C9HkIImiM@eWdYo6,3&_>[%YTAF+5b'8Ek)@O0_nX8:!>GA]A,:9$UrGGNI9DJ=d%
>"3GHNprbe:*Fu`i\+h`WeNb18q@X>Z)bXqg]A4PTqj*^_O"ELu>UdlTm\*NBFZ_s6m!8@UpB
r<Eq*+9g&Hp"o_Mk/)7M;bs5p2q'n*W/-X^nTC#F0r__3<uRMFaJCjAF45;p,3q0RTD\;#YU
ulj%1nD<+!Q.n2BIMIZUmL"O#^Deaqm;n4%$>j(2/?nNI@hu.h/!EcX[WLuWmZ5Tq6kHA`pZ
*!*Wr[GX;IR#sV\imY.?Z]ATR=.514:\!*AUAS:ZIWHZToUs^-IQ^<D7GT`o2sE;P^>Ki"^dN
L_::og@)/eLOq]AR4dVjsSnpr*Fap18p/)6[]Ak1BJPsF%<&3F=C=\XE7t3"%6%DdmMHUS[$AH
qr"%^I&kNL/11+)ojn_,W2Q!#OQ5j9#'thSZ;366.9MD>NKp\kkC1F<R'"5V\$3>AF-Vtu;X
MK47(!5fk'TmkkMk7\^tN<eD\?T4>5.+h-;[TlcHJ#s^Gj(>V07/c"*(_:'"s9Ci8oBTXI^O
#25)>8$Vid84liE%D)G0GIE?YW7-1.C,'"9rm/Bh(e+i1(?`B(K&b.M2m2[(&^?%;q'6a$EW
S;iN5M*.^0?KYS:T.e?O]A5'HeeP\"rY^H\egT2G(HqVC8YdUe<.n#c+$'\<HI",rC3bT#Y=e
Loh?aFnkQd3SeWkekB<1G3`S@BAqhg'l]A)G0Or892/d%-O4dNUsZ,O8MV6YJrf,,r%dMK0D'
dFJ[-M%1#&&m2g(MicgseN4Tr5rY5c\sF+(^+)<q2,q_5in<u&6L2Ue>D!%+jNZBNBo3Yu`7
EE=IT&;u8K'^FC9S,WT3_L:4ZQU-A8]A2`8!#l@jj6)8.(Ji"A\UT%\*RP3&07a@`#0(SKOgU
$fbHZfa8<o8?GThETQk`ooYiVUDLY]AU2_6]AH_WVoUK@Br/IloE1)VrI)b/Vt5:Ie$VF^(Q=5
Fd.Y'p(aHTf[\r*!d+q4jr9%XHh.^d5WPc-ttS<cQ+QbWc[`9(%!`EK%bl(Z>+qCIY=<99#3
W:[Nl"q5Y$a7oA,JeH";G!2K4XYSH^mKEVKKscR(ePYh1gPqTO$Pe2DBK8Zbm4FeMVqfs7Z>
6Q@QLmR#lgPQlWpBH.*1<'D*hEnGD7bgm5M<Q9u0.ooY,V[ll_]A.E7AA$L;!c_lnrcH4pa>9
Z[\&TlOQ*J,F!`3dIm6cd_/`EMu$Rk/r0VpXN.S/oh&FcKZNN>KY$#6eAV=6`2,^.u82cUiu
68s5np]At[GXd1#_G3j.N3bojG>'$RO)F!cKNO&Par(YDRNlW.7K?Ntk7mOrV-`(7GN/X@^kZ
1k&oZ!.Ua**`Bj4/lUG?u+prnJ#8GOfnUBGl(!$(?8iVM[4T:o>6rWOsf/u$$4a0Y&gK%:Em
G'VsHUpq=il*-]A2f6S#<o44%OL[3sb0Do&ci5eM)Kl;8#Dua)`s53GGqFEVXK2EgX.k.3Z2U
6+-oBR*T\/6;iE.O.))Dr8s*gB]Ab2or4_M`?Ed;ZE/FYtqFBJX)P_?\r1g.WSWR`>gh,]Ahpi
$o<%JQVR$JDHroZ,###q3f;*uB:%!ZPn@CK/gM#(,uFqTa'P%IeDB'WFGI-=-=B;8_,J#^cj
>,i(taQ,W+#qAaX7Nj2=<[qL@:"n?de^TPe\-RUHCR"G]AErJTb96:<`.-VYOQ6NfNp2J]ApcB
OQFj\V$\:kD!ZhL._\EOHE3)[2B(F;q4Ei/4g5d$P)rdMoW^9WV8`&@,eZ3W:<"&,*]Ad1>Ml
@,MK!GS28<GV7'Z'QWdV8MZ<<elgL4i2AJ"FaE%(WH$Y_h324b-cRP9Y(m&>d:I$q_ARpfW<
V1Yu4f9]A&*D1kmGQo56N+r!`:!:_spH$b0:UhrsmCW;F)LZ]A7iR0#0'$l.^=`8uEgnWeT0[e
)RIDQ^P8)=BQU(2?'j5G*5s]A!#1Vcf=RTZHt`,Yq"FSnjM7`6IIX]AmkQqU:=WDtU=Fbe(jT7
&,@Re;T$0&,Yl0-9H1As=Fn3&f)!EVQo$68f%V?0ka8j`Tp]A7D$X#QNo8%%dBXn$@*/G2BgB
2:ud%sWV;K0mtG_F<r^Z1C9t1[n+'PR%N4UG0oD!R'U(.g=d@7W7Bq-U,%fM0j!$FX5c;]AqZ
Ue,)(e_Cc$lUH@:IQ;1Iaf;9Ni37InZ<?i\*kd\*3X8f`\fM:Z7I^UDYe[aK$Y,BH3H.q((Z
af4rj2ClL6AGaMbRnC4Y#[&eubO+4gB!cE[gt<9Q.I'tB$/\tFFVJsPFk1\ShAO/S<CRM#N<
X6"E_9A4?!8X?XCFE)[*t;LQo![t$o^p*2(@r44tG>&<4jbgniY7Ai:;u7E0F+.Y$IG$);\S
1Z/L]A!qE:O)()VN'DLa)KhdT&KF(PsM>R43[<t@ioeIY!^%a@C+"6Js0IcU9;/N<IFl11jW?
6GSD2QQa[m;?hLrC21#S7lW'+>3b6[hYiO6c!@FPS!DdDG-CBA(I+O)'ngnWbq+j&K4!Xo!a
-.Vh@$Uc"0q(:FEsH3GsRDr"<$WC9/56OtN#,To2i-%!$W7jg"e`$=cS"`u$e+:nr0%fF*!A
:p<I/l@/cFH:k(H/:P\sL;TI.YS=ne/44"*Qh(=eD$c7B8'uU*P0)J;J,a+81Jm`s6XGc)80
[T722Qs!r@I@!=:3l>L"H5Bbp!^WQ98i_IqM-\NUgFk:'76<FhAh:1_Ss,H[1=GmWgEi:?u)
G>CF$ghd:4>L^fW(MV6e)X71:]A^f9[<aY+YhN9&MG1rdMJ#nN'1WY-hk*7SY)p7g`lIS-cA(
1#b_0[mO2&"\Kbr9:L\!Jj=iG517-<MW<*--+"8LFut&hbCSrB<Y_6'G3OOaQrW\1ors:^M0
k`j?T!nr8!sC=/B$.c#GErM%8lfB+-=_;RUD.O33*U)sri#D@^4c\g-3YgIhTV]AUYnkhe>3B
#iDGLK;<\7I@Hi<WeePqYl9U.a"dRVe^;Cg*9UjYW96r$"F8_GJm0#bnk2crYXji0%8SAZ7O
hGW?p'p\'LYrlb^49f]AiQfmHIJQ,p^8Etkg%pY]A,T28LX&:fS>&GHN>3B/`miOkNU=`Kii:*
6bI[&UBU;C%ABN!l>KOP9_(d?Y.`"4L+QpQM[?T4/@#p7G*m"]AV*2?lR&l4++j*Eb%GXnQQR
n[!sD6<N>7]AbJ/-Io_f2i=-O5#Q6?pnbh'e"*X:Qc*8D8N;S,]A1\bacA[R0.PL1Hb>mAgAUG
S]AnXa9[pHF]AAk9nM_PSCjpPRR?<qX^ua/(IL0-pfRo#rqtX2\`Aj!>.GRcs;X_gN]A97fbbTM
H!mc$0@SGb;s]A5YEbrgZRsW7sQT5)\SqiOr%V,gV6LKc!KHS"l3toY9rm.qopSrnmWF#@^&K
`T`Eh:0Z9X3$Plf5.i=%Y3Qg5_T_kH"k+4Wcf0E!,]ANf0l0m@k*s7SpXKubONp>GbUd\%&qB
X?KHVGHsfK3r%fd-Da.B=B*+KAH[,ch65^#$:=3tSd9f?!FYgZdYOnr.iOS-A@XcifOk*!Iq
/iMAfCt]AVXGp(cncTPb5[hbD.mEI'Eb#Bt5oi*s/mN*?\),RiJu<!l5D;\>GbKK>^2,_$2n`
L[XQMuT"`N5TIUp!8;9DthH[N@G=OG4b5bmc@b1Z9uiZ:\B>R&XTOccqBE&DC8$$#o:\:'?B
cmjmS[*(^_LfH_66c8a(^%e#tj/`o;]A\rFIIJ\\C.0#iSV=D``OCbe@)eTkh(5KR?=.,[B,S
,=_073o3T6N6Fb4J`31U(OaP/)GkO'NC>JW2WK2NIE<9P_(T62lpdcQ>#UB$[VM[PY;nCgBU
T'Fn\o+I]AA!:HX)0A&lYFUWXlAQ?KXQ2`o!hX1<)eN*fbMK2D)W919dT!5143YTTj_)%A0OK
UN941^W+"4V![\'056rFU/"R-:j`(5@)S$7EclIpeaJQEgAUNN_O=\osa_DiNjjG?RMbhnrs
m<SVOXqB?U-AFgOZ<f+oJl*#)Q;8nbU5/\93Jd$8ha`fGY1_@rs*^9Jb;\jlU51Gj1qj14QJ
VHXr%It'i]AguJC(bN=o:30=/`97hDPZ@AK>?L6^5Wse#oJPui2WXt>unkE.kjKY<3iDE(aa3
>g^\"=&[F6OL;"+n^DD9@>[XKFH?[3PX[gu`)C[kYu>>qQ8%<gfEVkK'lK;Yflgk3GX0L!=R
"M,2!Y<G?BL#13$Wn36s#B0hki2O16^kM72NFrF-lM.^HcNA1;h2N8LZ,.hipD$h;'3tC/j[
_L,>BKj4Q[c*823>:q:G0/-^d?o<h-i')L9udfm--O!&;rV6L1>Ah9C:B'jR)8,9\/Gu%+!B
[AbBKHen%hpM%9>dU>TL7+4K/4M074-(kU>_#Sc:J2-c.*IZWq7#mUsJ34(cUDWCW/,_osj<
UA)l2HMt%laCeO<h_Ei0cej59Y-)6YFt&M:@B?WPb(1:%`Z*(?6d2H*rn7"CLJnG.P\8f*+*
;rj7'AW_%E(`iSaPhi.qNVNMk*=bR1YO>%J/f/X[VI'=3CF-:p\9<h^TMVEYZNVD\/d0,@oU
mH[5V!f$odHI?G1L:\O*"OMe;'B#\.?WWk5;%L!gM-fTI@=rA_"DoEKnP]AQfQr,<=jZH-,PC
QP^<?$4toD>@`[gj1\'N[pLrkauKH]AMBZpSjVTS0WDmp]AhsA!"rC4*R/Y_j'u4!2l#%kQ%\B
*[A]A?o>d+2rM-NN3,!U8W&`6W\kBCpRB+'A!d!UWP(rlVdBqQIN0KJhoQMMbfJ4*fo!'jC)!
D\5`f,*]A\6_6fsT/O2:EbqNdU0$]A.<Od<,8II`G8E&dl`Xs4KY!q4R`cT$@lOb%"/lQQZuO6
KXC.IGB07QWr9TF_(h.P'g,F1#;!Y*%Jh.[mt8KV..*4SH*4!G4W9WJ'uY%$8r/b5$)p7_=*
8,(iPHcRb&,81U0ONC+XYkX(?\L`d&Vr/R9p0DH^Q%;sT?Z=&\+p3O1[[UOIsfYKU?&9:Zpn
TZ8iq5HCCh<N01+>+V+L^]A2',+:SjH@q#7J'a&JKl<td1NRBi8"rP%^!E[t22T@o:%#Pp1tO
BE1R'2^72m$j\T#:,U1XlH]AlK_Ko.=%W=]A0)fdNg$8c1`]Aqn-B]A+8GtH^s4_UBcX#F64.EF`
/$83JDXW7lHKhh\=8#JEBhL#/3NqbG)V8$Om_"5!M7Cb-:JUU.9su._CD&jqD2tl-q]Alg$>T
`T9bR>-&=BV0hrbih<i2jq9L5`!'T7.#pO&T.l"j&WXSN3B#;?KD3YbL0Xmf&JkDKQ\>(0TA
Oe<q]AtDg1WVXD#3enQ94^#Lf#2c*>0\Gt0&L&OF!k!kjEd&IQR5*VM79>$7LNMCHn:I0$MMa
YC46%/OOC?Eh$a\9ns4*?T+[?G$-XG%n#7(6"*8J"N_`ifj$FIX^9"/,F<aNl!?_&7.'(*[#
qRXM"S",HTpF<W;/tSRI035/pi<KsPLE.0\^h@\dZdLV1m]AoUW7M&DRH@8)"]At^/O)!(:7u8
r(GGC:$r9b*1%9Ym.,6nPE<]AS69`'U$MMhL<g2G<CO*&4aVO:h+"d`s0'Zm\]Au=:/Pt-!n%W
[Ke46Mr4)i+DRkt)CZ#3AWc=RQ[dQ/cC93#R27ckVh>eiPoC7nIUU!_fSAX_]AChd@=&b=-)P
*X\P[Co'#8%hW$jTF\Zd`WZV&Uio8):\"kl)GO7+<m2P7\hY2U4`,&3jr%0#2*%d(^GJk3*p
c7d49D4JYIEf6?8L`P[iG85/3MopW]AR3GAg'^h<M(]A3uU8B\KNcdZ@O*j&";h"+Z,dT5"?t%
^++^&,6g5.4mV)ddVVe:%rR`6@lK6SrUg'sJBGK`sO8quZ+7e16ZQ)+WR\ci;Pe1>3nnSeik
0FubhnJ#&49^EV:ocM=$$`@\]AnKnr\rNtZ=nJJ="LeuZ)Os9GMVc"PVNK"c?3\5L?ZQ-eG5K
jK^!`[%M8cX@)f]A]AtdBM@V@-F?]AjK#k0)a6c-"G-6,[_toKmLak=9[AmHGFm<IlqN_jmY]ACF
G.[t`_<EoDQ3UPS8dZ-+*,tPl58(s&tK0`/]Aa:,P&o_dP3m29_oMH_0s.fo.7UQX;UU:+@aR
T*(CC_/11["'!?lSlt!H<&_Vj\.l-WPIKRg<KP6`*bcTgAD*Ki<(dI#R6"i65o(aF^6BC1qV
nc.jQq&T.MF2=)IhV4t3q..:bb\h/Njcpql;ZG_C-E@)M`"+:lI^7rlq!j[\=i\+UQ/`39n$
\M#gapI?l(WGBF[]A[BH+'KH@[m'2ql/ZYHOcVflrRJoPQY1>3Ei8>8E&>KGBFQle5GZ%U5/i
^nq?u%&S1"YTK]ARKTjQ`.RNk4bK35'kS<Ir`!i8:PrD[9USC"+k;O?aA=8cPYY?Ch:6neKRj
&m>ZqfP8Lj?0?[,G+[2!3\kLB_ArZhB)!8\kQjp>t.Vsf@LX//pl(Je-kHXE4]A]A3.!cHE?j/
?H32KZ/>c>Xn1Y#W8V+iVd,9iei:sS+n]Aaioa76J[\^$oHRPQmr5@M^!'9d>G%<h'+nG^WBS
u7&0dkj>@d'"l;<s2pTH;F8qSQpgu\`AM_'&uH%&36[1qJ4,^jsBbqsSuWGq1_0&Ba+@%5PE
TKJHi>h4O_-I.KDUTg;Ilf$:ujXRrb>&&cn@*den=;;G(C5bY,)g&r,2Gp90htS1^J,AMM2b
"0#\ZK[dZBb2e:q;aBV&\c.h^u1Urt'Pk4Ud*3Nuk.DmAthM<UaLlM"u1u*$L^\c*rK5Sp@R
W?ASX4G.-I+o@H:%)0I/Ncoi&%;5'?L5R,B4]AkbL.339U\rdfdYUI>=j9h:C.LDIJ4:t;p`X
75FqST>1ihu%>'3sM]A62rkb<A_dKX>j-L8>$<LEbulK,LQXbAiM!1Sbnq,Q(&.5'FPjRbdW$
YplJam;NpZ8Ml)Jq1-hR/A@WCr'7LVD'jD;slgLro[40(*0`N'eD3*'EJ55$XZcV'hWEZ]A#[
^.:IaD_2bs!?N=oD"4Pml&<+`K-TesdT]A)u_2_Nl/u<8`bGJO*fnV>Wr%YrEUb^lS*0<hACQ
9!6R(^1QK;X'NqMHqL=9H*q=ikLB1J_+\Xq8*="+m#+lgj^3HJ4n_;j&#OOn4:I$XMU-jAX(
RNAqf6k*BDop&5Y?HJ.G;hK8NOQe`k;&J+&RZ;?(Vn>[A$kq0@pSI#$Bqe1F$mlEjPO$,G9\
Si:6iZ<+<Y7@24o^5LF360s15K+_I*X]AoF)+0S>htWb6D[Ds,'b`Zhjbets_HJtfQ7p.7A1N
OnTA8naSbP@=(&d!k6CMh70!iE9k-^1eOC4,qP`.FPGA2QXG'ltS;sb<1,hl?Um]A4O_jMcWW
@=dG?B)7&!.j+=U1N)C!`f9!qpf'Gh>*#0*CsW>-<']A[2SN5RT!ldPb2Y;s=?CmsRNm4Up?#
ZsH[Y,[@2+fK$kKCm.ae<J$#S]Asi3'4Pn/S[(!n@#7-Lr"H8.?`.7\skf)N#6nV?hWZnRB0"
.-:X0mR?K@g<Yk?7/P9q23K1h*%$0k%HcE:T;r.j=CU?+LBMM7GQL-+D/A?e!/<H<O[a!G?+
t0+"iba!Ln"ng6N8$mTKfXL,]Ap'rH*h(jrdBiDggim@R`)7fBO5'Q5qr:(84i:b.EHK4g?7L
*>Ys1&"4drFhr=Of#:FtMi7dE`t)PE%a.IF![i:1G_^&m11PF*r7DE)P-IdD8dPBkL/D&MMB
Wh*DiaH*WrakkiLB0e1R)fn%olb<LUcXjdA;2dUi\'e#D\G/gP1Qu<g6!R4\ahhGaU?tiSEl
RhMj@Tq0FM?N)\,"]A$+2;$WOO\CmIpG7uln=*DbV&Sn/tBH.H#Mg4.'\b/e`^P%Yc-oJQ3Kb
mQrMtA!s+P9e.\=!HGkPtGTs;`\N0$mk#RL\b$)U1m5+[unIj.d8(r>sD5J8]A)$AQ:=]AKd^g
9bZ-jE0f.=F(GBfZNJCRDVcFBTb02(TFQ1c9?OBSc*Ggi/KIg<2h6l>?,B\!(FZ8m/-E,'cp
DrApi;_]Adn@#2,f/4,UQ3Qpc5'+RtNH&H94Z&'W[(h6qk[*WSE.;oR=6kAW@%T5_fT%@M??0
Eu3gm2b?Ab'&G3g*4([UU(V"_^$\_rXb1D&Xrl?d.`rju<qFqeHXhm$<S8>'--k-g/P%J5$J
GA4kp7i`rhqh+Lqtf4#eU`OZ6,H6eRa0>_$[1]A:=0tT5@l#Ip/AUpF_00SiH??eHEi!^%21X
T,a7JER+:AQS"0eZ5"D"(QFVD\GlZJO!&pKL`en*6>`7.a,<o7@7D$_bYBoEN#kM!9L-ep_;
6XT$`IhiN9D1>PCrTNR@*+D(K1r*Arp@.!bl!oD'1_["APp!_a0".;\Y]AQdX%h(5qE-f=FTj
7@TOKX8Jslah_m>]Ab*HI8_VCgHb#0g\Af=05rY(gQi84L3+O!g.jITpfbrS9MO?Hi1+pn&bg
3>1MC\+B%&218/-^+:'R;K49o_37B(dHld0;eKYo#a-Bpa"BKcHG%J+,kVGOcHoi&4Pm>><8
(Pn_2bqYrqO)8Jb&WX:!?3`+gF:>$N^n@Vr[h3ZVNg@AOb;6#:FdiZ&bOZ>LDl)f]AqQ2)jLj
EouQC+ei*TL_O6hVE3`uR,q!'ibTkNj=lB2.n*\ed.af\&c@JO9/;Y,`*rUG,>%;W;Fg_fJ)
<Cs/c&tY9a*8e3p:8ddkocaKK^Y_Vo0-(!LhgPnLN'R)pEq2;'GUbLQ18YNS+O2ZUh3tO"t#
FSD_h7G%!__e[Q>lq)lG[u<<0=28s*lZo2+hgU2cLtOs(nGQ>HXn^\1$k`KO$D()6Q9p6WUo
%kf/ZkkWck'iu'%WV<$&9UbYWNiX1N41XD=!7)i\hBBW&`s'Xgj#pd7o!<MC1meT_N0$bCGF
1,nkq`dn[)dG)%$Jhm=<#N]A2Mth6DtV4(]A^4H[4E@PUM\Vebh.B,(;i&V4D19g%NO,kA[!-/
,f["?^B/B1'?!B0HE<mA>:es2WPlm!boaC$B"1PU&19o)`a*h+5+%:M,feA&?A7tc-e`-P_1
I2Mp"Ob::[S)KhqRu/TR0[/*,otMXj3+g:F!JK_l>$2PVV0L,i(g9c::_q;O`*teo<r%NM7:
.d`c=Sl5T.iu\HSrA\]A]AS:Ek"!E]A5PjJ,n\t15/DlBH'd+R40$F2mK&.t`i`gsoih>pRmC?j
Ao?$5ItZ*2h,7$":GIXP2$U-M"e)uF27L+!>^;:W2#K"!71A%N/>04T-\cl>$]AGULj`1S=s$
!hGHL8$Xd/a$W5OlEG&/P\(<r`_@EL3mXE,7fM`m5:)7?".gl/5(q?%!$O;Hf<cg1TG2h&at
&rZZ73V7LJ@S="ol&C;t?oFg#m6`.Xq'7u-t-O&lN73HF&,^c'rBC:Vop!4f"`(n(Xe$id(*
^k3u'2UE]AR*eYVm,FB:2k@'OZk\/#io)qo+m)9Cs3[)>mkn\E\!<genIKDuVd0tooc\Y"`Z]A
la*C)EB$:7KJ:Y`f@p-Z@3)96$d^1&EEFk%)'C8osi>=s'i0-6O`>LC@/'g0NN%RuGASptjO
Oh0Fo6e:/1%hK3C?R0a4P%+!?(lDZ?(jf^%[]A\FY:1[CEOGQ-2c@u%=U3hRt7e2*=]A-U52SF
^416U%.]A>/QS4Mtkull@Gh0:Mm-(_G<!WGu1_G>]A?9_M;j![#)I]ADo#CAfi.d=%4q;dC+FB?
NIr35E8e*`Kq6aVuX4^r0F=ekl#!JhS8VSBX6j)342&6\'_Y!aq_o_j=Fb=%Fa"G:BkT:O&J
Bo!pJR3JH2'h;b2nNBSiXJ_mAcN)_&#Ug7ptlnUfKOl!2glJc]AsgIG5F$HU7g)6TK@o-K6*P
qJ3h\(Vl'A]A$DLlK5N>Js\4L)]AU$7NWqLMN4g$@cX&5BKkj:u>>HpX<T1!A2MO,LOk*ij0SI
$65Em@(A75?.Z..M]AS<"D+ZUn!,cu.J?nb(2eh`)U_mEWQrOIj7-rXi8;G@a>B(ToFLk*<$+
hg=Yi5(mj2l]A\)8c\s^c5tF$oB9A9PBO.7pNSgadr$FfPHm)oYm^aJRlm#O"Kr$(&4dZp_!%
;)&_#R0PfMaIN"]ACItACu_SC*Gp>-e[cu_FE$S0(%^(L_K"CTm]A/S&Wr6TN!Wp#^Q^/5G)MX
8Q$m6TM]A5er&bqgrak^,m,i'kL@Il/'I4-Ej?jBB3r4&Rb?@MH&?kZ5_\:,=Vp2ijjZiE\]A%
#"`?d=PR0U""SkB7W<-CI.,(RJ+>A\,am$YrlJ3N#1#daDk$]A-_MA";W3AV:&t@/MMt2`j:A
VJoTBjjVAVjFBjllpAtdWfndqgUaQA;CInI@'$[9).9'0(oYmkh&=mNOpimTqn??N*C927A=
aRjY>0q!Ag:ima,qht[VinV6l5iQ)#uI/S_K*%*rLSU,A_!,h<+SIoA*Z`Urm-h.s:U?d*>r
SKX=k[XRs9C-L-hmXa4Sh'f_K7k?iG!G0'P;pL^5\DbZ*Z$A"g2hIA!/NtdaRL1,(IT8$Z#@
L0g4f2a?`__`M6"n!FB3Y-IQOkZ02Bs!-TM\OKbP?cFcJjFo)A_GZA-1!^uG.XKBmQQcbIHO
OZ[CV*`nJDTGrWQr>W,uC/Vg@S*U9JHSh&7np7_hunJRa,K4SF.[e1^D(/%+Q=#2"@?k3ZpK
kEf4b6K"TW.lop"duH+AgR"]A@&cKLAgj3p(57Wm$FeE"2gF!,"\j[h+$]A#EMXY._q^eH1k!2
#H&E=.8h!n*./'h\rH;5-+5-aFoVD/'f;'KZJubP0bDeq5=gM.7QMoR0f<Y#o-/'eTFn?Uqp
pMc=*C.+j0tWC)fMSFJY#lDpMll2m-9rCKnmASW&]A(idG,M/)OL0l]A_PDI">DEiB@J-?KI8h
hX/_n%"E"I0XoN&>,M-C:di\Ef"r&m#sM)kcHK##O9%ApK*MeVK7V?CqFlY]A+Gt6ePAG<`3e
+08i?S[_S)erW;rc;._4WAlLN`JgR7Pgr-CWlpD'NKOdakfi>`(4>G,C%]AO3:]AMSBdd[qI/W
_/D+SEQq3",=<O4o'G+<I&5+NOk/,#jt5<YaWSBIIStk"GMPqEX1IOE\%.F#E11oMEWTjK!k
i,Us6rhW;!YtbMq6h*Db^#8Z"1?S%Si7os($SC0b78l?-d!Hs&`'O.27!SEH?/$!chg9UrH@
rrl\7CE\qRTF/CH/+=Dh#eDg2b#(LKGZ>0XA)&;63g[56Jk35I-"Q[u31^64D;!bD)$Rjiu5
roZ_\*pkPgXn$B5>\R7`akKZVs4hm9/ehiP,Ztf$JBW+R>h6_eUV>L%THar)mP6'1S96uqY'
%llQaQ:A^(f6[!*(sKhm!.;97H(!XE=eh[iE8a8*>?Y["A8/skffE1r4WY6'e2I_31i/]A=L:
lLRKs<\M6k(<^&XV_b*ME6"pJY9GDjfRBZf(a14_r*M#VlG8p6$Z;n\=,h#0iK/t'[UV2lbP
INHRmWc8(8(JdpoWXQmj]ALm*^SI/N;=jl97T9A%beSq"h[:kPWTOmVJg6X3O`"]AN.5K*]At55
]A3s7-`cerg<^Esu06MR1#*,L-PG/7?qer6@%'_oI09PBNfnXE8<o!hC:+*a,qh:R4-m]A%&mQ
BBBk+PO`sDQZesJ%n:^<=*kbk@!&EL>VHH'qdmOh7Zn$7$c'sVduPfHk;1a<1Wj?ole-^d"&
g5?Fn:Wl15#">EA*M%?o@/$<YLJQTVWi]AX\>d5XnH[/.r-]A6`Abjg&;D%/;.And@IUL:@dgD
>qj!K^sl*bX;Rg]A3VanSXu[,49dJ8=5f!ek'i^@T=W\opDS&#N*,i]A\]ApH5pI(tSAqG]AA/]Ah
R[p!dT]A`eMeKXBD]AD!]A$*T;8-LZ6:dr(33$HK0Bsr5AOYAg)%Xn"qpJ??0k4jLu!^Ib;F5M_
^KbckbZ^.\S#d;it@t#K,g^NNBaQ*TL<E@C+NEqQ_BT:s9#f_#0i0Vcn\@^n!Q+7b4-q='/2
oMOZHsm;KX^K4ur1Agu&,bYS\OXFUd["5FAUlZJA29$c@fhul>##C"A$#)Bmf72ei`sulKmE
>4Dir8B=Y\7pN;;C0OEX<$b6VlDgGQ:NBd3[?G;kHh(Z-OW]AD1aS:hOupQ%tkn[c;ab.1^_a
F6Rb#;';uiiL?I%OF!8gR6CIDZo4^?duJZU;s%iV+%62)gon#k2pe/>,Q%"=7)I>Gnm.DGLn
M,DPs0B:5*EAb66q5Di,OX8*k&p/ZYb>H=f?&@(]AoHkmY=h7n8AZu5ocUSA4hK#WR9Gb\U]AS
#3/`Tb;-]A0?QfLr>;^uY:F[M8aGN2ldlHN$LQ<P8BljoMRqc;>SBpk:!J?g9<5=gOLXNkk0T
%.uF4FKbm8f(T6:ln'5njUb@hNkh?K2/94:`8/Iq?!7q_JD_2n:ZP35=\m/d/K&-Y%kFG;GZ
(^//L96+5FhfaXsjpC+%+G<5R4q1nr6Y"&I,UbS#P?h9(@shj]A%'iklX6p(jRJc\(e$`D07T
W]A[CopN*;&Gf(l5n[R!;f83Y"&R99r?;3)MO_sN`IeV\mk%5A-WC;=\Q$=Z5gIOd1qYQ2$o_
Gg]AXL*C!.+7-(-MgEn^ddmsAFl-+JCX]A(%PP)(PJt+[a1OS(%-$))hl`H%%$amE+Euu/Fc2q
p92hiPp'$'QAC_<4@Oo*1hU1,-&!0!&g"!>F"%e")=G%ru^"K>J9-5+.Sdsb(T9p")0<a_AS
8N3PAOO?EZ%@piSIYVmKHs;]A*o+iK:-9j)ZE8(m!$Kr^N`2hhiLsS9Z),s?\6)-CRi&\\Fu!
XKeu=#[AfW?8"af!G72qjrP:Lk]ALe]A'U<AZVKIh##iK3P@l7%?^)?B`Us9DW)6*(&DC8*4Dq
Zsm<06Ksa[o5#4cB7ij8dndPQhZZ#0&Zgfn:,Yb1m87nP%qaZ!q-fW_./sG#drQCQI[:[;-C
E.!C'O&"XcEtL+o\StR!m$CWuZ!No9@9c-=?'@&`hZloP+Hb4t"-F%74LH9(hk!n*$i$.VG(
cVG$LL'd?TnoP\;e&3gi(+na)Ts/!2]A<eeN&RiV&N*,%7=.uWGI`!elPlP[kCfX_[SeF<+R`
c>WI[`R%SU?U-BQ`-pHU%b0C0u#,@nS.a=>nituR!6XE%!Cjt]A@CulFMtJT6`nUoYkJis7d0
':Z&lktf#YLXmMT19Nm22]A/!fkKH)JB%W[jmD[d+O_(YWML5W0S[pkNMh7rF6l_QM&=J&W_2
C?i6S8SVuYHlg'_c`E_GVT_!DNm70hN0th?5VBS3UEJ_s=Em`dqcZ&%.!0.'@7R#]A:1TC@,O
8$@cgul#euCKb87<"^0d4iF*ED/HMnC_O<ElP9r8(#SIoSZi/CN-o9)O$tl??!lCPQ1aq*,q
D=&NoI#b7fUgikjr:@J:#U]AP`D+:]AcYSLj)!Pma;K.eAX=F_*j#-A#gl#CELC+&5e>RKh.G9
4l9tpMD[:6j!=NmBr,o6Mr=8onpd#:=:*p,X4#JTTBI*3']AltW>Yf%^^?_;Hd"`rF"#ORdr3
:';oe0\c0T&Y9%>WGnR:Sm/C/RZ&:94',.9t1"b8FhImie0,!,rE:\Zp!m<[5c<EE-1P12@,
8ka$Y(faR-KX[CQfc+TWR]ApTQB74>Mn-ROpcZ\<c+)FnE\E(pD0j!.GX=XSG.4r!ro)>[uHh
fY+&*NkcHsY^6F"%Nqq;hZJB9ssZ%LRGr;P$A%Qb,NS/HI+)l,\\?rgT:1\MM`S!AL4,cHKi
R8p-4+>Z@L;<i"#oIZ*<n`1J_W_L!8N>'!=nAo,>0U,&P-I4+5IDS!+d$5V*5SbN[)2hrfrP
$B8/b;N2Z;^d,DD/tD+@%ZSa:P7rhZkHb/s*76V[Q[NKO6YE3!OQ<29eT_/DZXI=N=!M!nQK
f^R4b8P1Llc,cY0;3kCbgt),Y4;d"VVT$j$sU.)"`"f8oI/lA#&G%052p[fIK1<VG;7XnZHf
e-R_q4'r*"bgrX1dqD6\_;&go)8Q'MeZ+nqj@TY]A4Vm"p>?Weo&bfN9]AF]ALub%Jb:1]AlJW[l
%N'\nB^R&+3JpQ!\shfb!cL&DerpbtS:\NYcLVaCMuRa=QH`D`LXc-V,Z_A$D8[pRHGW@HDj
d+E@30[unlpK>Yf7O>gP)/HO7:RLjq5"^BN>@+d`JiEgN^U><ri$k%bhE&:CW@pqe$Qf9jhJ
)J6S[Cma3mAh4HZ(SM%'"[Rp5fQ_[-k'Z4T_t#:-B0PKI+YZh]A>0Ek6.+uPU"09@!q1/8f_9
7h*)2>cI""2aePU0#58hJnn$B"+>E7/p$RE)$Ebs]A\60#]AGT]A;W@3s$u4MgSfu/2a32YsP^k
(dV)lZ,LQ;/ZGfF2dCkS5H%#I^t0#=&+-.fm4l7]Al$^(63f?(f$5bOLN`ETqC]A)pUhH'_b\o
]AO1bbVdVq-CqiFl7lK*1-K8lZ8[X_#p1/):2:&MLM7>.K$:j#8?s4&D45"%Uk$=\uAt"%';)
V\<dg$(PTd^'7aOIKA;;k7-tW1$^3N+]AB7=`[uWN;@Q_VeMjc".dGliV'$?bFk:1N*9P0k"]A
s<PL.f-?)MmMR%iC<0[:6>Wt/HP>J5idF?mspWF++;#HKYB=mf^*:spHA(NLH%c"D.N@.oYn
QP@g5,N>9:Xc24\$hnVS7_eX@RbHd<7VARc)#KsVu4gN.jLgiF/<:Z25C@L^Dr40tDD/dR:]A
SU'4*SS@NY'O\k?ZPCbtJ_ON^&K?M6e[dY<IJS-@!:lJcL[[YO+c?:t5A,-V#"SPLWu'gO!R
/o@`XS5R)=PC%$d,]A$m.d/B0VNjm<V.:H2pZGi2N`.f!6I=oO+QAL&AiYTkcn9fgB*)3X=Sn
Ur_]A!6k=%UrLfiCXTX5m<+-%Y_lN+RH=9qUjLq=7*pmt;35f`au=c-NL]A@ZfV9QVW!PDgW&7
kPPP,X*>(]Ak,n<f*6#5':PigLq'g)A;K4GH=:7ZTmDgcmNKYi.^OF@O,P#.')41+T]A)C]A7H+
]AHlm$<<.p45*0&KBDn9)p%IR28=B.Jh5OuAbjOZ#BbSoN@lRLgfBZ0V/)%u,Ddj9&$=\pg06
[3CH3B]AaB-dIWEF8s(HPb0j;u->-FW%f"C;S;#d<BGZNo^`)'&J]AI,l<Ood)*VH!?bW$K?9P
b]A)]A>2iNH1)G*;/g!`lKnLW[K/pBFXQXHJ^gbJ"Suf"GO8mgqY08AWE;OM8kqf0M#_gD]AVVY
mY,TOM3<5_YIpHDp,6c$07YcXonk\TS\pmO%-1L(t(XG1'#'SIdcbb4!>A^AIa*#o@"a4UFJ
OYH==B8XZe\8X:QjhF2Ia!YT?@bQ\q*N8CK,J8N`i");0Bi`::;Kg25DWL]A?FKH1n9h?4Eq-
FB%dS/<IAe>QfZ9P@8T!9!%+\IH]AOtRt=LZ%gAI=iJ:CDfT'c(?&mP\cHp/sDXkErla^Bj)/
\%7U4\RX5*&2VbeUnkpf'j?L*jC8!1Ap7o`/u:e]A,:B&ks5uL_UZEk[,VPZ9dCA+*"A)Th/o
RZ@'H%OT55(:0bWSbA`8]A%l-S`+=W>em3>&'1hL)3d\2`K!-)udSO!9ji6il<3K(g*I+!cj'
J5J)9WIEABW`]AWP?^2;2X&pVabjRVa#3$'r;fM-:RQD;&Rb[KB%V6@&K,R)h96RJ5N94Qhc7
W</0UEK5@)7o).RN3t9Z_s^&*URW(NUQUK%:Pr=c*Kq9a5DPT:pU,d.['b_VjaD+*u,ke!u$
3S1^37/*LXF_Tcp2jC3gfRh-hXl1j22gD*QE'@g:?-BQ3tNhkrZm;e-K'0>2RZ3TUKC(mt*m
951<!4j[ubV0."N3:BTX,gC_pN_6Oqc6SbAbm'uobG`,eXlVn7UI!A^`N^nF<U1WT#d\eFbS
5_QG:]AmAa"V-^T:`&=jB.q_Z5thmQk/m]A)n,sBJ6)'o")_NfeQR,dDtuNQ(l=c%`Sdj_fJbe
"\+8e$bf7eq1H4C8eg!,^qL(/W*e(@2O6r"LNk)EGDtI+)cAl%N<5L/a8JI5,2,KRHgEIOGG
=_]ACUljXo[*=Z(A,+mGU=UkcbS>cemaXc2Q4pCEW?MqLELTi\+*Qe&&V2K/TrPFrfeJ"D<Vk
_)Ja'.J(NuEtg0l:k)eLJ>>j8jpOX2RJ;`8+.am$1fC2K6QDUW-'e(#W!XhM333N=LuG)BDR
_eH!-qXh_(_,_2Obo7ZA:ugN!--GZT^Q*I:KsdcFmLrTD*gE_U_q0A:O9E&J"jH653snYeSX
J\=9O'tQo[_]A6fJ)]AWAed^K2q6n6aC>o#BGljDOM72AN>#X`IQguJ7<H`0*Pj0S,qB(p-=8X
u@G@6or?gU5G'H<:[Hm<s20I'q[V!("DAcST+$o_>ntV#WcN:*\.#c#io7O_k2hlB\$>ii1#
S"mo%Bj'SPV:0Xht_(H7-8J&ZIG5lRe]A:T'h*d!p'S\/V)`*8("[2#ZU1kA,]A\*NGj"TdX`V
<*-<Ld!o4VPh2i+603q[2\F,R.'je61kG@MO1[$;aGr!uPR9Egp'k\$\G!8DVJ+B7V$k^.e8
pKbhh9Wn#QbP$`nq\UKc<:jlD#5qV/Xh>$h,E>L!=$DA+R@U%U)9,\#7YXIX,Tj"rTP0]ApSX
P.)AdsQ_*#f#^/<0uelM5`d?['Ymg=Zgpmq>$C`5Y-]A9mj94b`PYFc6mg:W8R'F`QA@tC/3g
Bi"2N^<;`l;$,I$u[4kKZBbkqQV'EuM<ENRFB1!uUK4e>p&+;7NcPE<.)RaP!"mDA:\l3q*<
JoOpXQYJB'hV)RSL+l%8l$-[e3V-BR?h4E5)i*^R8ZTI..-aHO7#f1%d^g<ZSb4ClZcV-!0G
`<C2VhH>Wp\-5<DE>:FhuQoAqS^3re5g[>f`S>"fVLV*$sE/?aL'fsP6*0k.QuB,MPK@"ru8
f;`u`0.XWC,fe42U7%1ZPNV]A#f9t'5ISX:%InOOL<ABibHoQ9!Y/]A&?V9?V7B),*l7J'9Nqt
BT@[4A,(GpR/OjMdS,T8**N;G/E=\)i"sh"Zn^e6D_$LJqr/dfH((6B;5iQ+&L@mG@)F'?IJ
,.Ql3>CPa5M(mQE,]Afaq,'3T_u+W`X&(;@+BnI0;;[8Q&?m*<cJSX-@sJ5*Pq<BM`')mVZ^9
D@6=OpAH5gsa'ePU4@TYV^A6k)n>[KD:NpNg*onk2),tMUK1lamtj'6gIX\`L[(>B>8<*[`:
;f^m%5]A^fd7mF'sk'%fQ6u_;%WI54/s=YAaEjZ1HLo9"=:n\"fAiFHS9Y,G/mIWYN!P]Ab[PR
'Xf<b%[E;)>?AB&W6WQNO(p>[;rhAA,.8,er**K^HF]AEmNh$pTktsB#J-hAS#qr134r&Mb/)
O(iQp,ePf6^T4F\es:4"t]A1XS@*'/sSa\YP>ir,_mGI+"QGu40[H2I%ur!^0mUXp/8r4jkgY
=&(B[^(@9J\.A3.&e.nU>hN$VpO-@3(e^*ngbOqSaE72'^=-/r^&DY5%(!PGRAtIer\dPUl\
tUN:0spe\TiLi)^$?JH9Ju-%&#\Q-k7GA4cRpb&E)3l%3f8/n=*6/1$^V5l?.X2Oro0tIS]Ae
mSq<$C99Pp)7n.[=&=@82Xoc@VmoBVDQOFH`>S5K<i[4dSrqMY2OOWmc5ZA_Ce$Rr\RV4(p4
6=^Nsp1tVi:aAJ';3WqK?NrBnNpi&]A1%q0Cn&pZ,(u+L8XeY@U4O<?dqpWU!kMCRR=l/>sHd
A5PY!44KLY6#mC<mZ8jdub<Ys5[8BCuWJVZ3eRU%(@3Z1.(F[(RV#JAgfKC91RlBXiKaM"9E
k[4hMDecI"eOr\6ba3rF;m\+r/<PBXIUG<_J$n*Ro8l>`$2Si`a'I.@fWrH,J6\<AT$IJ2]A6
0%]A4b0Q?cPDeY<[!+"k\VkUqMX%=dJr?]AocEglQhn^#-WW&Y&qZ%=sRQ(.6/,SJ<qb[6^ZpN
u(]AZlhgXg2.cJ:4mRh3:8XV$e78j^*qbbr>9s\$D>\-^"qCNn`\gAL-"#0?`6h8/ZIQU;dQL
m0=2#AePNbM$f8ApQiR_6ip>CDsQQH1dmS1MJTACYVal+W!?&+RboCllR1re1)f*5;kQ6%mJ
5tAIb:C-X!'*5D0-Fq[DDX:lI,-6k[m;$f4D49cJXHtR2g#Qg1Qs7**T\9e3^r$=`s=XCon]A
sUre:Mm2#FO%0uM1q$"Gus+2Q1_ePd=5Y+PW?=Kjg='9`lQ<\4.;Uss<Q%r-`hRF@a3qacn2
1%3YY>`5FDXo=;W3&]A6d#2TQ+Z&J@#848O.D6)gH/0muD%qj![)[JMH^E'=8hD]AZ=kP;c`Sg
.t_O(uXc#rYqD4eVQ(*pt'6bfP_'[aTIY^-dB,Z]A;mrFt()O]A.tRemL?+43\e/@\s+?ZpYS6
LH/pad)\[Yr3F66Z?a,Uq^@8A4X7p)%#HPS=W(>SK$7$2`lKR0G'Xf_OaF?>'()[e5rbYAE\
pkn6i*,C0&.OZSP2\:^W>hS$1[!-`aN\L#Hr8_fLVj*D)Je2S4S=tK,qASO\&c^qVq!6?#[(
t6DAbK>LBjj+Mmjle`B#OM2V+84(``j`3Z?fh9'`l@2m@qP*++"jLFI$QH%cs\26sY(_0G8R
.Q#p0>cgW4e,bh@W_4KJs95u-Pa[qhk`)WQUB\B1Ham*Y90+SV^IJq_Su=Z(YP:t[o\R2Pq@
Y\kF!#0,RVPpaS6!#9nJBb9$C$:J[F(03=\R<OSqKR"EZbl^6XO(E&+M4q>2I">#4WTnbRD*
'$[FCh-TM,@J!:-"6<tDL!E$(,.Rd2.l'eUo"rhW2'8$A4PL&afW$o#mnBn5GZF'?mF^+Q`S
o`"%3&MB58p9!ka"Y=L[*V)QSrJCE"QDt!&15B0uf&3</eA!O<0q)8:W^HB-%DI`eb2HrAH:
cNRR@]A"Q+"lm&2j0FgC;!0d$^+I#-AqB=Q#'3LKRcl@,bI)1c-bK^@cuW#FRkIU`^*Op=!rf
h820q7JaOkZ^'>`WD$`3gI@cK/^PH,Pl>Jo!]A6"jB/+[,"oM9CqD=g:n[hnci;9_;S:?R!Vp
$hIkTrl_,1>^s1O(3@$5G5rNi`g0/E!gs&o<ekH!50Rm61i*S=R^\rHJTrpSM7s'tRFFVY*(
#+RkTj48\E;hfS5F3S+uc`3IN<)e(#lU^\Imi??c$Ska,C9gsaQ]A-GZn>NiOQ$^9PF1A41Nm
W4+"G5f`8XO`+[kX7cs(c*)=+FML'5Itdla]AtrN%]A9n[Z]A9Ghb+K-rH6K[\0uf&FgMf3nsnk
X4Q0@hNGdRq8k$-5'[;t40#n]A%&ZtR85YO?@qq>F?j,>Ba)6V&jO1>%dGFSeO+W!#A+oB\h5
O4>@;AL+R7mI9Zk/'g%1KI=i:QYY+p4Rl@<tD(=]A9"r38:Ih5)AW,`r1K`QY,s!$MAMts@hP
$:;XOL*,qu+&FR?6;n;uohCkL%.f#1fAG*3`P0L+IEdpmG/f_gnBIEX1'.N*.VAI8kq*cO^l
Uo'mO\jT[3ALD<h+#Fr6/tX<P<W/T8I4?`:F7No'gJ=L[d'laa>5ce*jZfclI@iu:^qWk[UW
Da&'+,6E/]Ag4peB!_#DGtZPlj5!PIJE8#l'm_=Q3$iqH6$$5Eh/Z=:'uYQqAlaJ&,hO%q:]At
sY/bWlaHaU0),b,[kJ#dP-]AlopJr#EJSO/XQTZFUKHjN[tTJ01=cNO?pM!81>368lU=MbZ-4
&8(!i/j21&\k-D[hNh!CW-hEj#1hr'MC)QIM0Ld7F`<S:hYY2!#FRURriQ@E0i1]A7aT[LPD-
l!K]Afa,ioaD("&g\Lk"<EW34:=AJ!\'rKHoZGm\4NR>OT57jR.D[h6&)b`QE$\[g?Nf8c\Wq
Wt2D@YjUCTYJ-Q1G#rfcZ10!AV^CaRaY/+-&r`#trCAD-#4$"mh:tYEB*(+qpH"-.&H;YE6i
krO^V\Sr87pO-O3Ip3Pa]A8p)ZD.ijgF[7VU]A('mO=MT4GXjoq[NU(3X[]AB&!+^50I:SA7HYe
WP#>R,-ebZ*>F!=.:hG0P28NAkQ7h?Ji\f*sq0=_8MVU^4m?U\Pip,Nh^<QqJPV$?d9A.NMP
s<uUHR0*cM2dF"l#ETtUKgoZ`R&:bOKVP_6d`u-jgQh_B4*/TiG"OG:VaG-LctZMYThVe4%1
c_H%eAJGSmoI/LNpW.Ye7T*)\[_qCYY+Q[mGp<-(8L]A%TURe/.&r)A1>g5gFHg_<\sENlr1o
VM-ml*p;\i6Cn%@H`4kI?53ZiL'uVRZlC9V)6l2HKn>[m54"OWBCdg7NJZqP#=fQR(-QS0i!
L>BLC4\q1Fber'4QiNFpNNV_90]A\7&?u:!P'_PkEbh&?DAo`Om*9\W1sAsD%&K><c;J?&kY0
<+:!!3N/jftqIb;gZnsqM+=dPuK6Q;dQ,CF$p;2Dd%e?DDD-WI!aa-2"O$<$;H!U:lPr?Pmi
r,"Vnu0OVQ+qHYW-2-#BHJp%??O2J,Ac*R2.M/`r[O:)8c@d&1(1Y\WN<Ha3bBhBQ_a]A?["2
ZV'.5=RcSlZ(-=qWfdV&%\Ehou1H?gpjGpO,kCkg$B>?am]AegKI-n&@@S!;fleZ]AC"`Sj9BC
Im<+1G.js:VV_l)EW;:oG&t;[))3Ph=qg=h'#q-M&'%elk%t]AgXF%:HC"QP.?nsERI:`efOn
[]Alg;1e2Y@Br0rQF5b&"@c?:"J/D8:S"'csI&BcYGf^l./A@%XMpVH$;:sBNrGR%(WpmQFG8
"6+t/uo:G$=`s?EmD6J#Li-]A4^NK7u>Z`+hg\%$?&'-A'K:Mocb7i8GiXB4<+qB;1%&`c"f`
_\uscu68gfAmL:)k.<'_u(;D,d0cM+'JENd5DJUMrZu<i3W/.TF(S>R/Rn.3sU`\!l`BMB!B
5cg9,QU`_BNMG!D;IDU]AE9R^()iIl!#Sdp=*N>0UO8hsW[@)i0LO2M@A74\sSAN8Z(YWUS5e
.[B.3q0S%[M6LKp`?;Z;2t=<.e75j'@9f/d9'l2/m!EkXia/oKB`bT3]Af+bQWV")#jT#kYKa
0n>lE7SX@-:.maVjR4<*%<cd-]AKOTdIWY'W*I)U$`4js#&N![26-dKfgnq@tM`)Q^;`U]AX_e
0.,DuKlg@R%g3)8A?+gob.'_H$eDb+e.[=rh]Ap;eG=BS#$cR5Wl)C;[d6D@!(1Hm_>mp.aa*
kHG"JcIg]AV10-&-,?KX[`6ZpC'boGU.O#M2r-I3(<eA;IF)c1Ti]AMWYq&hZ`S\>=hE5Jj^;R
9(bK;3tlr-MZ<-$><f:8!1UeTH4^S:gY\FbNJPDJ&o&G]A^,#*;D@R`4EkQ.rp"LDY<%M)fl,
5/u:%28BH>p!0\(M".TnXTt^'d;#>^!*>TOQpR:oK(@)IYsf>-2H.M^;E'X'bjQa'=ut`mA(
ISf=6j%&nC%;UW[VIh3FR<h)j%np65q"`6MaFS*fBfDj07*CN=>AXY]AC2ghfO3G:.Cn5epgX
JmQTYcDIphP84&WgZW@R3T8!ZugoAcL+r^UuBLS!liC$UaQ,%<(lsH`3-Kg0B_Ab*PpN=(gG
2\FEapF]A.h,n=ehE71k\p3G,Z]A*:H!9KbSD/`oTjL?ZYihuCr6i+iWj0f;5,AJ83gYZr+UiL
]A3`/"jT/kNakYt!0c-,0/tA4P$"/0P`pOFC#IDqWBg'=i5q54Bb2(gE(dd3oh;=`NEbe6J#d
0?<q=E/1*`*bd@%KrEuio%l[sinPJ6&d#FL(9T34o'foU!q"`>kNqf%VY#"VbB0+gDk7mAgn
^gu=Q[?58fm#LZAkPb2m'rP?4*#c4KQqBD>e5B0,H8ol/YZT>?3C[=c[40I9@"7,l)a;]A^,r
0Yu`Lt0PT:;O38^NlJa$:OlsSf?V\_K%.]AZ+9Jp1Yr5C3K\Bk;e1=;T=Ke%5hk-;lJ.cj8!#
0Jn4k)Dm5PSWD?+_ek>B9B1qJo%%;/+]AWZZ]Ai_N>:Co=js0htr&:10nWK-@[<<tMBf>eCrHh
H@Elnf\Rhs.7c/:C8NU\N?%_B='I<s*6<$3b`ormrRN]AA2EM6?T]A-'`Gi)tiDo+OX"eT=$c(
2']AUU!aLmS!RL,>$8n__dU'*E]AHo0kmrQtN!B4<%Ht0#+E&c5O4,N&tk\-5rE_47HCo0n6#B
[gW6rBrdoF@?s)RA=+Ut(-<Wn%Y?..iH!\@a"Iq4k0]A^9$]AA+\,J>;rL\Em3i,>&HGgAHX@o
UB_'X!p\FMGXR>B?Tk"BY]Ag9A)-0]AO1-q^n^XDlPE+sFASF7q_EhUkJs_-6Sep<q3J@>gcYK
lNrf,1E<PIRAlM.:Bu1kSnn9L"UOJG$M0PCcOOPQ'[No$FpbA5KWh'!5sI;E$7&!K7V\A1O$
_FiF,]AWA1hnD<m#.+]AJ=)'Xrr;_U%e:O<(b7^[$;@91R'6QTS9/oI.qs)KscNsm11JO?+1H'
?5'paY\Q,7W)6F_rK(YR!nthXHrH'Ca9VEN50dN6!UpF.?>l11*<5_7'Xn0a-V0"E^$aN4o-
n(/G1cf&)(eq5_E>#?7=)K<,,^-O'"PFV$RKE"TP`fFIYIM)[nk+Vh"gQPo3Gun/-Jg)EHS$
3-;H2Ki!7N[`o[$aW!8P?IPDteS0YZtG+RA#7WaB'd0>tHge9(W8_(<nA0S)t(]ANOcDZi`tM
QPb@J0P*Af#uO.E:XI6&*&&7\%f;!p:_%l(hkUG^nQP;LjM2Sf$L";c!oEW-CLq2JH;9(.;+
*2Jbf\2=I9ef_\S4Gb6g^tC-S63/JD>]A^U@pE=/ZW^,W6nn&=ESM5f(5%V@7^@HGt"N\>D+J
*4DWS2\o4jAZUBX?Es-ci9*RIT'=9f<`YI1L/%\;oq,fr'+G<S1k`<VEqaZ-@XR!QebQJ3Du
?@9JlmXJ_F]A2D0B&oe(KMS)%::fnR8NmGb@rXXp[>3g07-]A,72uZ+Q)6O1gn1W"VWUf^c_AS
,iXu@bF2,.JUA&cnA_(Z74iKf'WY6VH0+r"6jS'mZ.\:h<rI@sd`m1JQghEHYjM\sIUAV=,e
UnaoAYnQ1_\-L:A_WQ,g5^hTEA!iI.P11%0&=KPah[o-OU+^'Z\4Z@f<7<hmq["6nk5trqtT
aihE<DLW."\ji5<G;mlrkoU7i`UlYa*0>LNeX<j-YNB+ZbC0"]A*1@1kZihGBp2$AEX+9R5RY
[:@Vqq?@e<o5VK3f*t"=.\9"k%f&Ck?A(+e2b"uE<nms-IQTHi@q<`8n9D#KE/;YE^Jab"i]A
-8d#APUF$<1.7*e?Tsn@mqj>er[RnYC"&H`s;IRm2:kF1?0Y7'D'`'*:I(6:CNuk2tZlXW/&
4U\g?Q05$-Wr<P,dlRAK9Y5uDF;3..%;Ih-BatIL%pkL0!4ER.RkWO\gLgf04<&*"I/?@h0B
N7/3HiqsOq19Je:co4a\-]A=#AY[o&7gZA#'.=H8%P::o3hics]A4M%@V5m/3<)\S?5%VE._kY
nql\sq/R`*1%:=urCWNs4)MTsD3Otrh&`(J73`EYjOkkA(Z]AiVbj#>EfA4@_>F<i6!'G+E#D
\X*V+$lc_RR-O?MU6(7)X@=`c\Z]A'4.CW9%cY5VVUPkS8.q*_u#%Fq%W1R=RrY>?6qT\IZEW
2K`/c9/_Y@EC"?n2"1jHJ\PFd;WH(^B(WmaQ=>ND6I]AHkrR9#e"F;/SceeSY,1cO<T`K1isX
BeLlqip`/D-`\[Gd&D/:rHqPa8Nu)p)Ot!+T"o8'h!D018>>;Zp<9im'pIPVI`a"Z@HhaI%Y
WG7OU9s`SmNT/Y<SglrNK;U:X\XNXS/#oKEY2WrDnj45Sg1p)ks:q.U3`mlNt>Yk^H5fX+-R
kkLiUsG2arD$Hm59EP0+p_q%CICpbu^8:Xr3k3r?Xn*S4dm%?YG_5Fn+2<AlKV2K#+.$3,U-
EdUVXAmBKT5Z;Ie@4oRnLtr<S*)A<?]AH@(0[U:X'?>^2F\?XRY0FIL8*0;nGkTlBSkE^WP'o
:,=CkQInSud%ge;Vc)$m0aVN@OPkj(6mo*E),a0s2TXAC=)YH$f^c,D45M^MWF6)CB@d8-Ah
^^AcH3*<22uk`$3aQ!Mg+f^d>sd.&roogq0uN>[F%onZnG246[JWB*Y'5\'!s^pBW\T)ZTKi
KRPmU(&OrC<fJ"3-Qq/DebR:.^eN3'jh?,D%XpQg8ULuX<DV3?uE.bcl#j$B6tI/TaZ%5W1q
EAB8(kVO=4i&n7Sh-,,4LbH")<@Cd"S>^+6oKK\i&=4iNA1&dngZo6o':La'Ij<]AB6i(F000
]Af-+MBt7!n2Cc@Z<ULs\kSueJd\"#IiB8eil;!jWWi-An[nk:McsrTn`^D#;XNO!UaRKoBp9
sZ4[,b6-8)FIbEWAKgCFu)r7T9G4L\BEL]AUIe8V*uDGXY/\-Clt]AY3;]AIk&.`A`;+shiU67;
m->LZ<M32"=;LU4Z\ambul3p99D&g8e50u@T=)XGT=5.fhJVZ&(o]A$+AIA"#H+$geYcGY=L^
<:Vc'PrG_Z['C/&!@qDlu!(8ajIOcHI<Z6N9GY)^@!KN%,lj%k/R!?\"Hfb&!fZegp5]AEmG.
(Nl:[rk1sg;.^-`i[J"e5>05f13:CuVjVeG4SCs]A:;'VE<[3mjo'0p)!FI(M_'\:bU&FE5-^
c$R[^pmI9X-?*nifA*M'&"iUiYV4BD=KsfD-5*sDT&<aQnBaHmbR1Ooa?G$u@iDng@AGO4]A%
0EBC5c62'j"411T`nmbCTH0KX2S!(8)!^l3T>L,"(9H_5NcQ6\%4RZXho3W')q@:E/RnT;uQ
#U(K,*0H#a]ALA41MD+,e.fhl&s;f8F"]AK7HYBoQa:[dhr@VGq>>UY@4H=0eRqD///R"Q/aTi
u6cK[]AKU$^i]ASJbRh#:725&*\>:5$gFH>eMJqL"/76'<71XI'YA"n5<SU.2\>"*&H"lET%<[
kURTUWR's4'QL%,URNlXC4h$D9E?2Q#Lq<`&(5INuG^6<mek4;<f2XR"\.hVg&8h]AQc^8OMn
h!Nj+Q"fgo/+#0T4[UOI_\A&oZ(at_igXg$=u1pDoNZJ,9gQtfaQMG6BOc"HjE)e5[?%p0RO
(Gog]As:)$`n.lg!d-R2]A!jG"TAXI[$V3?V>#BuRUCO16@o_O+5HNL5!M09OA>?3._9h0MhUc
`;A1:f<QRNqj=ok.Hi3%S:Lmt"BULge^\NIGW.#e4.ISO3f.7&F.eSYeCN&#4D?h`mUdR6j/
?;1!nG`7N*-Y=d[+cEB?Q/h;PY2:SrbW<BP1:pWT*oKG7^nuR>^r9di&!1BF\>es);II8ETs
-t,YkLhFoDLpa%)69@(KJ8LO72bg?Yf@_*B6pp0OO;I\\3202s]A#kjfbA3]ACe"S.p*t<,:=f
3qe)"d+o/QV?'$F#OIR4ZG@pWjk2u<WqNQ02E^GI#%34dBiId9q+HU<C"e#`;72?Q-W<_;?[
8lQ>0"B<m9X\7fUCu*p3#7IAK&KiQ]AEr9VAjDRh\PZFE895\gDj<[ToBB=kBk?1jc4@aBPY>
9\X&)5oXLB2R=lkNb1,1K>QE6='=n_8&;LqQa)*&!p2shN3FDinQ);#$F=r&31&iEC;3T7W@
",d&Yj7rR`]AfA,*?8!K8K[=HXisFmMjNtc5_'lug-c3r;^.$7H=)7RUHt_g:;S5>\OPD=4^1
pe"&E;C>c/gK\>bd`pmDrePrIic06`fZf^8^9KhWD\Nc,YNAYk.dPqgP-29S%K6WI#\%J]A,#
CKQt!D:P=Zf<?G;B8</]A^N_uX7RI""4u;q2ZX_nf*s/M-m,%0crS=g?hqa$^blVs]AMUk8jV_
`*CT[78m*`PiG&g@?,<E4Tu+*cJRW@-V#E`(T%1uCI$-H<NspVGOJj\B8`7TrgbkI+d6aNGo
O:1^EKd4+hjHMYT*DGXY71:ZsTYE$\Q?\m1BU[IXmA#F'LXKCkHK<siafp:'J?I&#akGp(l@
Cr.PZ?&^a6L313B0/h,[n"_fFLKJZUppE;5J8i=naRi]AA+@iQ$:-]A_e'<d\.G"*O++@FR>ku
6a+o5`A`cT3.e4^X!>aRH.j<TL<-^^/_2RJo>f(X_4fe[=elEs(B?"1]A$\_l4&fu<soOIJYY
lLgOs&*Y*g(FSi;7n5:%n^aSPZkb^qEH\r.c]ALX"E<Nq]A(,]A2]APfE3qq2Un(d\a;uqi%YaM+
kL:L-MrLnZCqMJ<dO`bM>fcI$?CLMaI.<lR#8?>R?-d:4%X.4(&E339:qBdAA]A"!`\29?+P%
J9%EmA%S>VR)N[,/g'YVB)Q`NII'\[]Aks0kAe4an)iBcP(G-8KSGM'T@]AT&5Fn%,I9blBrHK
MhTB&olNn_$g5II3GA-mENe>HZaBGP/nkfE`V=d8EqXM<Y%g`rLV*%G`?&KV%n,%14*XIX(l
5Ks$ZIr`7+KI?LdS_1O\bJ2a,2-X#K!e'#;P.]A8#i%Ku3rY8AhSn*b:W7i3OO1RrNX+9lZLC
C!3a(^\pjBBKC8J;=Va@NR]A#>BH`?1>g"0?J#Gs#Q\ZeS%09ZP(<*6D6K:c`mDoNHD<B]AK9f
!.)6b>.1;"S'^j#6:Md@2$FlaNm?\N7Mfa9!.H/6jPI39jG2O.oi.WTf^J#2ma;jh4_t'AJs
$2VVPO3h+rGAG<3Tc<d&8f3]A[>ZC"Bn6k;d6?j5\=+r1L6HPpoFSo6S`I;kS1&t"'prRor*j
ooCeq59UT0GCG-W'Vr=M_<H%!;J?\A'Vsjb>N(Me6IufJA&Y*m\;o-G:e;E&Sh2BZr@Q7ohf
fN1IIG$27Yg,:Q$QW*%d6UoGCn=0ZZMj2e,B!s7!Uf<arm3mi3HXDK^"Gf_p]A?n@ec,T[IC(
)^86aWcb\I^`-W&URlLs-]A6_a/"ljOS:Y)<\6$LKm7C<?Lu7Fa$g567>/[4X6oq8g^31N_<c
ATYJh8H*cX[AOMp,$S?/mWsW$F)k43*f'<dTNh0V216Nsi?k9j6]AM=EMMa=c;us>le0Eig)D
RRNA(>2"41.G<f[>^DEi6[;^[08Wj97SSM`:.jNU"GskfgI01=h":a_?2QsG$3P`>2>K3]Adq
IP$o<<e>'bJArfBAjQ^T"+cOJ(Y!ZeQ&/Fip\?L%#S'`".[C"WH;(26a"Wn>SD!XPQ`2*S35
5=+)&W'pJY[!"m9TT!m,lG64L5s"3ua0hC\o^*!3U_48-/0`I5:Q>9*Ic;3a`V.>XG1(Z">#
HjJCPWE-Y@>.dXiN>AtNL,D((?9mhue9aHG0E-N[qn91uk'=q-*csfXP(HsoH03'S)RLJ(k@
5\1A$F6.h-^6.e'od'`t`n4B5/PuEJZ.<MQ#%1R@X_9&lh#U"`=`uHPl^m,<K;e<kG3/BIL_
+r[ZC$GJ(ZtD#,;<=$VUd7J4M("UN=kn2bYu[[Dh8dg6janlEb15Yd>(J-;q'.jH:l:\O<CM
'$Vd,XX]A,"a[lkIu4>&2A[ljdNKK8$XF\hg,rP^ZR7k;LS:XEo2&Vd0>tZTZU+WT39plPI%p
i?c"dAj7L8@#n)hE'f9NkHZmH9RH7:#CBdQch3]A8m57!3C\'ulPM?doAD"'tr3`fpME3dKlN
V7?9ObWL=B!>]AW(8+UL0@rMXio%,CK^-SW/edXZ4@\*E7iQ11@m^HmVXUGuu-[2Mip$+^]AGo
E>*YR-S>7.u"Y^L(Faj6De+OiMu2#pCH8H+L]AJ^.It"H4L$(ALjF'>2K:maX@9h"]AZ,W#:1I
IFfL*!RhaRM[q$d)-;&_,RN(s+p[+6#h8b^+h6(VPl^+hps5GB(9gYJ/8N(n<:+&<m$h;O)+
ll=6GJ(%E*`T#ld`;G`.pIHcdMA0`I-_(%J5'F]A1),O<)2r]A4]A(k>l$:"rK=G:K;VXfF9gNb
4+3!2=d*:4J4H,\%)JkM('Wf^B3gNl;CW)IIC;([Qbbr$q/NU?#!BLZLXG6Uu$.XWsbZ*EV+
etgZ*l>og/qa$f(m2:a=N8'#?-.W`Q=n?/<nD-aO]AT&V[Ij!c&B.,T\]A^QOZ2s#H825\5MoH
$Y`T53kacB,%i-fl$[ec81]AA@/)fp6?V?=mu\;T;K<T'FA%a0b@^^(p0L;lMC.@d,j]AQcA)_
DMt*&Lb]A9=J9-G2:HrTd73t==X(;+Z)@&EF8bPn0Wf)58iERP0Q7A64Z"F<9s$Qtu#bR@E(,
:pJ/@D&_RRqX[[E?e)#l#CBGgR\pl.;1+CgZe'W<YR0:RYckR>bt?tn\@S@.a..[YGFDB?Z+
%)[nZUOp*8&QP]A8:A!hR#0jbY)t%3>id06PeoF1CY3#bml352HoKom$d0J@N[185Ir2\Bat3
5`f>8hgYG*XKPDG@cRO`TZPY2Kg';,(tB#hS;?LfA,=,H+h7tX[]A.P,='>:3[)P\..clf(k`
Kr;dJqqbLq6qY!XO>Ecj&L]A04"2hGfetR8PYela('ah"@fLH-sugGXF,3QK?T,:hIQ[RE=IO
e!Ek08:P(*@@1pn06,\Q*QVLHR:4S-b>r^R&C\5-M>Pc%Bq"IYKi.?NHHQMQ7qIl[HCD;!$=
e(r&1Tf1_gOA,[D,5E9oR;]Ar'+SesTl8M&+$dc*X:LXBLQBJX?bt>2jXeN\'R*rQZIqEX`@j
1jS5=6:o)"qiZ?;me^0fIaqGf#GeH*2UoIZ3oA4:gpHT4$V97eK/225mLD1=>rjYi^&7HD^4
;rR+8k@E`m'ta+mKc7WV8s!;4AHPRAPteG=jp,WnjE5g/Q.mm-?JP.k]A1fjPk!VRfQis2m96
tNGAOpUaW5P7ihA]A]Aq^RgD0L/4YD1Or0f_,/TE&\T+S7YI729aC`V8`\q[!ArJ6iX2%=c84<
M-&g2J6p/]A]A+cuIc*bn(Hn)drOj)&+pH$(M0;rWc;n<DMO3o8(*$ThRH''Als."/Gp[1Y*:N
'SZ=n58T:Dqt7)_i++q*.qO/!X3]A3Vb=lrkdgZV4Ir7W:?t-3X-"_@#)/=s%7`dH_-"]A4Wff
#^,AXQ=7ip\)b&hL`,G&j>ZS,.,<6fnli+>iW6G'DGede:+2'X+[-39HKrhX>-.h_Z@&H2,V
5@j/q@p3^6b]A1/TG3bM0li!Jf'8cA+AVR6j&s<knANdh0aAZ+-s#/ONJO7<Z9_oAhOfd!#s!
:4C5J2B[I;1dDpq?EHk[K\0E*D_e)@8&9(:AIfL&*J(r$sHYdr-YD&+kOXr=LkKA(KVL/jgW
6=f]AJe+%Z!$^pA%bkCoAfM*)l[EHb8/dN$:gn7e?=;G/:K\ZWbX5'BA-[/7E44(L4!QDQ9^#
UJC"AnbsfD;<<[ZC`#G0B?j1QpC@]AXb<#UbH`C/LV0//b/ffYK,!r7,ms\2WW69.V5\esA?7
h3G1LCO!HKg2qoj`JCPg]A;hH7[QLoXum'XmZAK,<JON?(m;7EkG!!d7=A_9pB6kgK(7T/*!;
p'C<_FCO1eW.aYZ=PUGdkR_Oa,rJeOL5S;78!(@F'a1IXW^mt</VsuBVtat;QP7uTFWtRm_k
*!gIugF8Fs<MI$\)du]AcT:)JYTt3>psR2fQuO\GtYLh0/2W.pJ"V[q`0mgiKNNaTcj%TBs5p
FZ'NWQ#&&d4/W6,`HTrH)<hHnQ*/8>d=RD0*dnc4qmKrSH<s\H%$T95p*9XOY-E=o1\L<-e>
RfRn8pi$K=DlLJ#!Mg#/o&?ZV&G7Mq^>[5>fLd/>5aE,S/*I-`DKUWjlGc=7Qle9fB+Q!6^f
r7eH)+%k`g>1?AMR%PQ=dqIN#<*7ZkprBWl;Vm:gn[CsWBCo?%PGPP+4+0K#HEF`<nq38Iu0
8P[&1(GTX0)i``LS5@'ej`Tf-RKN]A*o=Jclnt'HOg17W0g9HSmQ&tL1Di;0!8p1>fFftlID*
psN3'R2AD+aERjbGDB%9)oRm!;dEqANAoMRAcui6\K4fr)$*TJROA.lX_[Y'suH[9\#A?h)E
M2g]A^D0g,>,S^sc9Hl_s&2-%gN"4.su(f50Z*N*QOZ0\D%'DWO+k]AYMogC(mD^n"tGV\_0E*
>/stBf@i[?4itfM0YBWF,d&R.<\O,\DrbJp6=<`JlH!tFY\Hj&s!kOZ5X5'"h(N5fXAHCmN[
uR5D#dqhgi)f;-?'P:ET>"9_7f`G"a)(JD&N0Bf^H/eop."&@J>d)`b?&^6CjI$gaW_n5-!f
c`DA=oTS]AF3&;*IG#\!ir&2qUVtgGC['I@5=1oPT8q6@=!WiD&C/_IA(RZaM]A?Cs!=@+F^>@
Y<WBIBGdW2jAHgMqN53>bR._!8NQ+bMW]AIp1GKi._%'V]AJ8f@RFh<W='>62oZ[B/Eb!R=*uT
[f'NR!"l8g<J8M]A/V)PkG5tg%-IK9R_-!3#\5\D9#.Sl&9.XGMjOP<@sq)5b'I%GS?e/Jj("
@Sh.UN_6Yl'?;FZAAnf"nC.EM!+O%L55nHAjK8gAE.&G+1Gd%70"QNiAEB-?&hMXX;X/W2^(
@L0tp7qJXf1)[:_AB@+Dpr#IdTBm^6WjYub."GqVP2G!KT\S!od&<s%!]AF,&!(:WAkW4,A9%
g!4`2HM*dX!EsoBDa1IAf+X3]AnR*SMZj`l`A;3p<"-4;c%`/eIp5Pd9IP3uM8(Oc0`^_He'D
oi1H0#RYT-X0GPdm`NlOTBOEZEddhAYf>L;+s*Bf%UR+5K[9Utr3'r!6\-nE=._:BmK^'.S[
aK=)?#%P5eBfc.jI4U&cfmK>(Bm*+L\#2@I*a1b-r"b4.XnIaY_Pcf#m6N0YHR>*>Vo;3ikg
XJ%L8H/qdMe*e#;M@'E%b?O(9^70(ogW);iT"ucnU$r.1'Nt?5T\dJHK]A_cZg$i<DZKSM]A\b
q'hHK4I9Uogp[0NsIh?^\1%kMum'ohrJ\%Cdrc2(;s#`#3Ti8Ae)a;)WbZuFVjD)*g4ciAr;
@h2"2J)V!>\EO:ck`*BIYK.t9>asR)I/jeK;Bdmh+HJX/S&BpQj)6[,*Iu,P\SI;Y'G_Z9"$
RI<#V)hu?T)`>*!2egc.jg9nh)4Oj4D,4(J$uChN_qJ+c9@1#-[V"!aTqK'DK)6;_+'ugdCn
S3[sSGR<tr.Ju;n]A5GX[sU-c*3hYLTFD2^fK6CrXt"P@Y9U?1`h)Y)4mi-KU7&2:U(gPuCG9
Htp9/^$foK(9KFpR:Lo<a>jJ:>VT-aE;]A9!9/"u%N_ubf/0+hUR?\^Z?$#<0*LD6'1i:T,4N
Umlhe6I-IT9cZB1#MPIiHrL,oA#XVP`=9:X,/12r\)%S6ETdJ_t"\Z;fL7g97ORS-^;=rT?d
@_Wo_,!2ol[3VD,\F$K8R_]A.]A('r?$[^UM$R*\j@G-snDmT@<ian6>PD,*ZL*?OuBU$UDghQ
c+GHWi;</I<:Dm@;pJJkHQ@<k)u,dT;Onc)us3h<FDq")l?#-Ur\pX,'J_o0oMFC_dEa.\(O
g[[4U=$Wk$DOsiJR*]AsVfs(#d#1^L0s"T2%"H4M;-&;*]Aq>lTAV9m)_1]AUat!>_8VVJUTPfa
?Nk6X[kKS;Kt6?4RkN.iH/l>!)G:%F-"nj#,W$lnNj[#UTd)..5i/OW#k!1Q9$]A?WA:A'e8G
-e<mj';8eDcIq`u:9gK0,@4O-C*L;#f#W:0L@`#?t=T&_Wbe+XCR0;PY0d2mT'RYDjmPE3^6
b@Ij/+o/?)\3[Zk\4b+1H^TinCA8)'L?p8'M8CLX-29dc/Z97#g?G'PKj7[A"Ot1;Mg`r@5,
WE>%e_DYI-$M>D:e6C)f92lSq!YNS.Sp4,@QW/q6jg=$CR0l^jY\.<u<0ZiloaH:d'A:_W;p
8>h\;X2]Au8FV:&XG7Z!%R_C(+W0!M6jQT_V>\Uh[N9r;#o04NDJA)qOWU$o*A$UBuR!olA&[
`mpC^LW-XljUq,>V+F"9n+%(cK#(]A*P_L3LfE[kJ6%^2fU_H-hT'6)C0Dq;iS(0XpV+q2kY<
AG:+pfQ\B#a6^/qY6ATIrNn)=!,Hu,`593a3.(uR*r3I<c=qp]AHLCV0Pl24:3"\4E$)P^8mb
D5J'oVH%_`1ED1\GX6kG1?p$T0aJm3JXt$Vi[#,WH7dsHe+2@9mn,VZcc\2l,jU`6+b-GW'r
iesaDBk"2rj_,TLAS)-EtOc@!M4Kg/JNe=tF4kHfV\lDkY%76QtN(h4'0TK*\sh+BiC#<#2U
&4=og+3-'Y>,uhtI1%-+_+@bBuBp0"gn>*%Jr]AIqNZu,-r@U#3TV9oE"7ZjeYVBWt1ige3W8
1j*`s2jU%)WGMfG[)Fs5:e8S]A_u?$H^Im,j\Ic(gNsFllLDP;0).>!Ak\p_-'jlTbY\gW1]A\
D9;Yue?2m(1M<>O8h;^4K"`)B&6)16-t/B3n=g4g:.DmmTtR4uMHld545RI4g/Sb1a(R/OCk
#T\m"loIq^Y`J^=EH=bd1"cWJ[I8sh%f5m#r[g(Y?H5[mcumDGG#PHTh:/#_IAlXp[0<+BX-
e)!cnSD-M+]AV^=k7XL-AGRNIW7!c+OW#Y`$q34RPib,O`eeA.$q#>UhL*&aTJ$eS'?j/*ku;
AA2AUdrS&kK0M50.Q4@f6X1Mi?mEjHWCEIeqD"d]Akf-]A,.0?0"aoJ[jcgs7S!/J"=OCYU*sB
q:hS5i$*PMb.=#1lB`-s-/8pYa[26ZsHo&C%_/M9k,!1]AB(<oUt`$?;h7QM?T>SY)RZ]A0[D&
C,q'ARhYtT%_>8cF'm-u6e^*b`@#\hA_Asd$o]AI2fK':d)C'8'DH^2Y6;H^'OpK[$VFf#u4f
(>l^.p&MN"3b`>r0^Pi?Os`;/n.f!2rmpq(5C6S=8D3[t;Fc^!Dc4?Olu;3Za5du"k@Edt$`
6UYE4ag2+?Z]A)U<(lD5?1&g]AW0Mha#?J()s#ib,EJ4=4"2;j'"R8Y;VCf90.ug_/pNPGb>Yk
q.:57#0\74ZqRQR(J1sW=75_L?2Ip$OU1"t^7-[lf>`=_8l_Nj0k)&s0&4RhG/,nUKnD,qs=
128WB.=D1O1PID0b>j#dm44(Y;_?>*90?(!`68B70WFb(7tYgQ1=+I!YoY7=EKU).;V9f)!=
M`qG"p%(/nClLs%4;R8BD`q9(-r_A]Ak%UuW$hWQ,,?@=),9[-0n[1G?^K<"@TJLEY/R5[tJ5
(LPgVp:<9&2,0DW]A0/L,b-O7C2;kJO-%CC#\\'5Xbt`cZEM=>\0Md/efmm\cc_E2uf[>`VeU
$6q<A/KGJf?]AVNu?W'4F:R*7HS"BRCmLMp'dl$GKF(s66T;82BfsO=c%0\)s"J`9%lU?-XbX
p5E&ts'8TSm4Y9NZ.Y?a;euc[qfWjqo+VC$a<:WFC.=@Y:Ej:5fpBG)_1rp*$Z-J$2&2WoZ[
>RYnI(HeX$?r#PF%b[^T#TWI7@,8H-I/iE._X*L/8KKBcI"d.WF/id.-,V]AL^*qG:)gn>r=P
1lOe*66A&99Ed3acpojDY-:e8_L/r$.h5#]AYJ0:B='/4CdgP"QQ`cA/@00BA9>l5td6-KfrY
70\sciN%$j9I+)Y2BO%s_Nbgc\F+?sL)d4'-sZ\e?A,#OP.iuK^[1Z0%e<jp@<oE!>\,$kM*
P0gR*\U$'C)Wnrf->FD>Q9'C[M$e!'\(ji<!AH_="59mdbc8Op1BcIaGW'G8_sQmKPj4?M!F
H+XkQkAr!?L$Y,;N`uIDsd,!b,o@u<hY9ujn2Um#j+Rpm&\8XC'eb'BP$Xu'rGelK.OTh'QJ
gsES5Xed'Bi?&r^)VnK":kh)3BeUELGh!d?X&uXCHu55:K).4Eg)oa#qj`q-+o,t`Go,`&(\
$ag?nca0QcZLDo3\t+ECD1E8f&kCO-OCW0a:E%h)eBfS43?>lS5,hstJ?(\@$oaQkQ18!/d^
lp@$#BBDG-._JclcGYOG%L:FF(2A*=;Q$[K43_6&Z^l/%fbEiBi33EXRf9i]A$A9j<VDZP/iR
B;)13^i_rY7g/\TtT8q$'6%8^H-pD(>;2]ASL(o]Af#1P_I\*ihk=0MaPe=")&eG/nUe^3ds[/
s=C%KM=2"#lU.'J+Lm$<akTr1j-rT6`5%(>f42C2q_c/#`OSb(H[/[`MfmQ$a*s13.4U,"T*
EHf]A46pCgldu16$R[j,j3@HtE8PD_St9U]AI0EZ/p,cEUCAqckjT[Jp>B]A8Viep,uA%+\R6]An
*>_EW155rr7$h*UE5l1D@j9`<M$9!e#GRYh^20ud^\F=#kJH*/nf?B)CE^g8oMKZAK,s!7LB
rl`SI/hFsNDP0[K+NLn2LRH%o,]AFF-cYET?>Ns`>MQ#1t"O&A``C/_3UTq+8+F:3oFDYd_10
JeW'(7(_O82Xb/')-[848OYS;]A<tpK0cRRD8.8%1i<1ht!=[THAk`K45$k$L,7E'$bNMX[NT
)ZLg<dQlj:HD#SXVg<h220PS9%"XpB)8`G6f0HpVIKU)hb_74gX*m-B!^<&MO_EBn3k>lGi)
/5cD).thg<(,Kio4@"qd!t.P\`SlR_k(h[2Ku6;>FcSlXcu2%&@>KLTY!m)Ch\$,(O`g4RCZ
2,7KrOIIs\WVO)UPri1fS"]A1'Hmr.f\Bo<Lm,Lf%F`c#F$E)k6=0X!P3%NY0Xm?OR+NQFKG1
oN$^8[&g@1P6)qZL.\`k/\hApHnlmR?2ApZjb54-C.,)A8#j>,G"Q&n")Z2[%&;HUJfr:G[i
j;(N1T=%i(R+eUQg+r6a[Ug(9ZH"#=7N`]ANAmIW&3ce8E<;6Pm<Bo0IeQP$PpKq4!+FqU$6B
eiKLAa?\%fEq#!\:!Ap`W(m^0Tr\W8aQemsOAjQaNc:X;P$B.01G.uMokg(I^`!L!PKcA'Da
'NUW<Ee$7.hHj^F'@]ATnf<p[:\rWqX3R>Y=*<]Aq^m^a/J#1S5Y2rF).[@2X1NWl_$t@`#rFf
SB_<5[HqUTJA9H:=b>Vos#Le/I*2`D=ZjOmQL%F_=\Pd9aRhV.=UT7U2=APV@5T#3Jm"URGT
HcReWVhpHACu0;3J=S3$R[:c&88>*ZoW-9iKq%Z"rH6FB5f)VGQY-"R#jcRoP-c.]A9&-a!4$
>`=J$"2_DD@t:%9\gtr!?gpd<^>=h("Nqju-s/#qjk2DJSW6\>jK`B4YNsBfil4[7lO3U\Vn
Gh<*hVSSg-?p+X3M<:'(C/6#U@J`/O=NV+Y`ncgU3O-:fH,9l9p@FI@XZH4V3K>X=iB*I"8S
M]AE(f.2p?:o15H340j+%X\c]A)HOuSUM*gXUDJaRjeqBdANnod>chuBO4NE0?fDTfM0%ehMrf
cCQea2!')--N.3XkG,X3@s?1U#Kc9Vc310a,K2TLf?%`eQ2]An7=0(XAQ5%U2_hMa"=M]A%.G.
HAa50N&X3a&H^iWO;**`B7(rKFE,HSRe;7aTl-JsCKNq]AY]A0i//"]A24<VA!42?=XH6L$21oY
I:IZFiTGLU"_aE\O]A)W<Tc6j)S_bgJ,t3L`tc]AnK0>'8nEq#n1PZqUX_D'PAg;oeco#T!6%c
:;EXpVWkr)\N)k890Pk2Qf`u\E98RV8grS#3_^jUcQaF4thLN4R3I(V;IW2XbW6^U8,b_[S[
'2Re]A(<oVUI.)bd)\Oig!T"&,9.aZ`[3?sPn0sUI#,TiMA/1ooN3N+noJ,D-D$:kQ<<;5N_t
TdoZ;]AjY1:4bhNK]At##Re#q=lg!Md8=HT!XlU%CfhEHn>ZK.[tYVr9I+Wc"S]AC)d>t9%m#"Q
T6ZP.ON4dia1(Po(Nel/LOOL\dr]ABp-i)-.nJ:jj*ZLZ++:%&=@Iaj</43BqaG`>bhu2es[.
,^RdWDMV;nM/2L/4n?b'ac-CX+CfNVo!_'uu6l]Ae.fmrb<S[]A8l-)TfObiktL/`K9@:!/%g<
\5NSQNe`Mh;<B'leh5?*E>mMZ8YK3[q:Xomte"bDd7nlN:>!LQ?[dDnA3$tDg2,(>NEM*;2"
_Te9bQfNG4kk/RX?$SVAJ_!<WWG+n=F&d<p2o!QUkj<,QF;j1k-J4PJ5H0,\?8r:_\[7!g"L
"`[`\YE(cL#YQMRKN!(;.:dI`-;?8Ib>K/:eA'c+@Toc,`kE6DkAS::?HY,]AU2$Rnb\EU2qk
C1B;e0KJU%KPP/:F0t;5+1=\Z9N%,Y#AXFG`i$VAUr_>5CegEf.J>nY?8H%Gj-K^5m8O<XS1
uJ8Kc2Xt%\(i%Di6AMs0Q]A9VM(mK?h0j,*VrJ,"b?N3h:k9jlLKHoE>D&p`FUGb8P%iOKoY[
T["?2eO(S(,d>Ehq,onoY>F(%jgAF&/iYL>tHX9HSXFHite)C5u\fFaI)Qr&\+M19h2JT'Ul
E5oDq>H`W^8keT>ZNuc/W!U!kVi*>;*?h'YTP2%]A,-W+0U_kf*;]A"j9JM[L?O\L<MND1PkW+
N2h9#jGZE:`#0K[&WYC-OK=!]A>",cp_H^[Tj7M,rbhAJ=:u6JT_`8sO\Sh9mN\3cp.HFShMK
XVPTcAF"[`G@rS5C8O^YndjeI]AnF6SF2O7C:Z7eI5tI-%PLmcJY&#KtBp`$u4[Hl%Cp)&ORJ
S+lI8e:*Ze*"s?qXYNPG^Q]A?:QrKK$i\>29PQ`3t)K=BUp0._UT/7;F?rQdLu#5HA`(PfcU3
9g'lVWIZCDe"5a&om!iV7FWH&%D9oQO&+&u<r&X?>HSYY-rS]A%V8q/f5%@kBJT6(VQI!BigF
oL1"9H`gj6_)#5r&G]ANfYfT;_4'I1Qp!]A9=]A;68".R'.i81.:>+/gj5=?RgJh%E*r4LO-,0p
$!c&^0eIt+?MbG:0P9h"a%(>.]AE+2/0SI8Ubda?rf.4rH>_[/GF0YJ^gD#BgQ\!S0QK0Aku)
giethS,jY<8q:hXffl9HkTXLnH*3O'l!^pT<eGjjk<RTp_)MYYZo*JLi&E:EZ;ss@,Go*q^V
4c^E%NtASOBQHK:a!)%^[(\j@L^)Yrs*KXj7PFHWN]Ar.kX>1:WR'Y\l,GtVO3q(60au\:;.:
mW+klf%`5%S]A#0/G9@\PS;Oh)&MN8g'WST_=MebGcFb"5f#t`)(f1#\nq]A2XJc<K<)=ZAPE[
`j'gAGF4W:+m--E+jdp>K4q>\mIXuCCW*u_OiFPDK_bC3'cHnp\]A1/$Nm>(?'KF=CRUhqR+1
+(Gb`#WURs</81c78&gCLrhJYo$P"%=qnRkM.\[f6O5+L8V2"WD?6,<=[h/+th+Z_f#pZpC9
09$rh!$_<+A1TU6#^3p?[=3T%r[/6)]AE=-b%i8=_M>L97*<YN[CK(R>)tcFPV5*k5;[BA<I%
r!)I'RRK#Jbug6rTk]AbkB?CK`F:Q>+4VcFDI=G_eu2loQP>I9'*%3PP_a__s+I,)`#37-'%h
d6kQ0F;\X58QF7#`C]A2VsBt'4;;J?c6q6/.W<'#-4W6h1-"GgtUYh06m_X,eG124r]AB<iQn9
/#G?ATJPI^DN(k`A`7=ISIQbZN%U1bLNEF!E6>LV(tT^'"pgS-R70j]AmoNq5D[VsAoi.m@b?
&Z9AN<aMLFI]AZ[q?V;9l>dlPdh2AnS<=^(nHm2UkZQB^N9MDhWmZgZCn\ccggq8mQ"o9c4gP
$m(S/>.@:[>K!COSs>S#%]AqobAQ.oIS/GR6.qt>.kC4nOn)*d7Hb);t$m/WS[:oZ^6e[Aqa>
=r54o28jQPJ3U#Bg-MO8j*fEZ>$F4`*_oLtn:_F]AdRo'AkWQ_um.3be=*B[9W#%r[EWh2`ou
Hl*i!hM)A6[2bd<IXVoK_L__i]A[aEGGF<I6mWHWjHR;YMlFs>T-3_md`i569UMYB'Fh[^AK%
*jo4qo5<Sho_@g9"<f_OlXh03Ul8>5uDjCAG=feY2=%9RB,5"qB76`GCKGBN,0+;s7,JH1U=
`br!.7,-?njuc>NmNY7L:'gHP]A[g&B(S'Qc1S]AtT!l<\1pUjnI6[hrK>_b5\`Ao>\GSSM.k#
!VQ<g^u@:5^qS-DTA[&=Ng`ama'l/bs,BdrJ2&]AP5UY9SQ"fCoJ`*9oLS0A!D4/09#7S7-ql
_#98+?HrIk!onR/`/JK6r%Hs6PK?8;-7(^MWIY0)`kRgiNBn"=LI1(@qK>gOD'W-VfdK]A%MQ
Xq7gIF,;S+ME3P'&47:)1cMhb,i^u=cB=P-XcgM*uqYc2R>f0tkRkTK0d-dDfT^4g+T5Yo[:
=njOn1*d0rc)%7cK:080Kb",f+FkMs,p$+2=6>qbZL^VchU(H^fJs>eL_-[<W/K403NN'QSA
jCRr&,Y$hFgB[D/chIr*XS6]Am7kIhT0G4SXt#*oGi7SLE?-6"P]ARC_N*)(%oc'QYu^"56~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="4" vertical="4" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="100"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report1"/>
<WidgetID widgetID="83ed78ec-be24-48ac-9056-12ca3874bbfa"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-10066330"/>
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
<NameJavaScriptGroup>
<NameJavaScript name="图表超链-联动单元格1">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<Parameters>
<Parameter>
<Attributes name="分类"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=if($分类 = "year"||len($分类) = 0,"concat(year,interval_info)","year")]]></Attributes>
</O>
</Parameter>
<Parameter>
<Attributes name="year"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=CATEGORY]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="500" height="270"/>
<realateName realateValue="A1" animateType="none"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
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
<Attr xAxisIndex="0" yAxisIndex="0" stacked="false" percentStacked="false" stackID="stackID"/>
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
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="AutoMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="solid" lineWidth="2.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
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
<Attr xAxisIndex="0" yAxisIndex="1" stacked="false" percentStacked="false" stackID="stackID"/>
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
<OneValueCDDefinition seriesName="无" valueName="当年非计划拆换次数" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[ds1]]></Name>
</TableData>
<CategoryName value="分类"/>
</OneValueCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<OneValueCDDefinition seriesName="无" valueName="当年非计划拆换千时率" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[ds1]]></Name>
</TableData>
<CategoryName value="分类"/>
</OneValueCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="f3e8373e-0ce5-4e63-b23a-24c433e14ffd"/>
<tools hidden="true" sort="false" export="true" fullScreen="true"/>
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
<![CDATA[be/.!PNgXV5',kF"_M:7RS&[HdE;Ls5tXT\&O\r=dRF;4e0$'ejNKRq&IBpmKT+=^KM4XGJ;
b(re4>c5L<rR;2*fma$-m8R3Kpu(qu+8%/cNl?jM(B%bI+Oen,5B=<gKUiM]A<?)m'G$P2S4(
Ik-NCJ"F^!s(C0^%!WHY;bs)*P5-)54G2\rs`07%aKHQ\6m&CLc/B[c-M0%5\CA31a<k\7O8
bHC4?84R\cVp[_:VS@sgitmH+?A*3q-[(:WM)A>ngT1#_THWj;hM%Sa!\7SSku%U)3KE4:;(
`KFNams,r5>nF\h)+,4!T@,Bj"]AIcQ:=EpWN-?15mo]AfW^b^.+^Nl@*[J0-:hQ5fDno6D?Ep
Y$E9s@"1gd&C]ADBfm4s!r#kG!ip.$5=%R`]A8(]AaajSm>XQH+"ijF-UuhMh%Hr,2X`1`c;eU;
6'O^@fMOr(J)%oB6')6`b2mG,<k"$#UX[S!(_i=EO;TMs[G3q`g5`2N=.jr,6JdJj.$:r$_-
tJ&hV;n3\[W:1X;&,''@fFj#EHiR-o/BiIRNR[PkQZekQKjT95AV_g[.g[RY^?QhSM`(R<P+
K>JUdU80jTQ(Y)SID*&`b%,'.:bNrI?eok_,PJk55]A&pV.VV20>81D*74V\"R?2*IS]Ar$/,b
f%m%u@hKCN#6d+1<JE<7>8q:9#ZD*0FI=#9F(.ql=-qh?R"A4p.s5LE&k;P#DG]A<.EZ/W_*f
hS!MUXMtt_bFYU*EMRJ,/<1[lqOMXYK!ufA9YsslTIdBcA4ICVGk&a:)&O+S(@Lua4?;X;-W
L+PX.qo-o@@c[moFh6=Z,p"O2!=uaD:.og^\4j;3Z[VP8*+Af>M5W\":IgH^>JD4?o@N2AN\
&77H^SPUbW7Z6[HL"p_-k`?H^!bB[t,hi[Z[gnq6JZ00,))T:@&?St8X[8o_J1aC95[O.Ql0
u\(M08H?PPDhX=s%3]Aj$eU)IF_Ej#G_pV<Po)juo#/Q8D4Xp2Ws^%QLr=.H7SM99iJ=m1,9T
O_%,:2-Pj+r@i2KZE\Le<C/h[CEACR5fRKE,Klbm[]A\c_p[n2ul]A1o7hiE^4/KGPtRKa+r:h
\1?:PY_l-/@Y3VNJGnX+rqKl:INrYWrY<r"aE.=?!I!If[c/[-eQEcmbrS'AE9mH%?/s</h@
EEG5k*[fQ4ktVXMoJ]ArMk*_nnDK9pBKmCP!a%>35=m*1DbQ2WcI7bOJ+BOo(GAX%_"\Tik(m
"AUON:Db`@`0=m0X4H3,u^8pMMZR$/FZ3mD<(#1Wgo#b%T3f&]A+mCcRm[n3$pX]AKMU4`05h?
$eK[m:]A-Y`\;8il%?e9p&cee*Fu')BP?hXDq]A%P6Wm#aoQ+=S\(`[jTf`TNo:#la]A*J-:<Fh
Z\h53aii!ckBSh%L4.+i`AO;G\+1i:g4hgGZV&\,IKK&RhB/t4lPU"#.\oCpo65\#8ZH'KYi
#D0Ft#^e6'n@q@#T_oD]A)LboTaT!4+n/)U]A\;^hN3r-rX`c!VEHL`]Ak+8-`PjdVisn]Aq1W0`
:W(n.1k;Ii>LN-ag\_^AnK3Td5@]Ai?e#D#5\TYpU`R;:]ACkdG<\'hSYocq(4PbR'mKteoBTI
br`ASDj_t-"1oWR9noJ`gs+/&&LNdPbn3Pto-P[p]Aa;826T)W`o;Kr\$P*,8bS:@L7E<=_^;
?s`A?.tQ:OQ<VFc\N<+HH9193P^8U!C%P>q/9D*!lNXiIM!^lrOusOqX=.>TBhZ*,)G8)@s-
tts%$4q:?Vqliq&L2GK'9U2l=l_L]A=4tn_`^5ZNL!<_,'it,%s36UOs22mJA6J#KC_;h1Xb<
3U\m:C)I=<C.`(]A[).KE^Dc\h7ISfBE_E:.7g+!gUYS!tp^;fIjI5sT<s?q=Ku(3\D-K\dMc
c_rpHCnbWnY$`jhQlTjh\\&Jn8!27`\Z$H;,9;hCN$em']AUsnnT>>V&O:3SY,(Hk?kBhj!H`
-EmL@u]A+J]Afd2`faG:uM?NZ.M1)iArG'@!af,AsiC6amrm`lCLOfH`8j_oZ!>0VHJp%e:@ZC
EZu$42i_[T^-6kZIr1/cK!(nl%u04ghp>tcF\%3W;iUPmmR8tC@SrL.p$6RD*9*^eEOp0r9N
tPSM&O16bcIM%7B0(AoWu]A78;qT*CjE]Ag>6hUSoNBkK1qMY[1jAk]ARm"8'*inj1(V**$nG3`
d_T<1S@GY-^3L"U;*Sp)74*42)/udm?TrWB&7>1VceL`>h5*g.Z]AEWHUW04of/d!"Ak'+2Hl
U=s0c9j>&Wn6T%F-7snkc5Q4EX#?,W[gCQ_p!0K2Am0O0`a_*sd_e[Z9G_6^-8N*b/"DdU;Z
L:MQJD"Cr*jND,()Dpe#%.Wi5s,)O(bogUV>1M6ne."QbfZqfEp==fr%#`-@(RJW$+jG>dsk
O1..Nr)7a%,+sQ9(GU,3o!9Q+k69-XdbRt3)SR`,]A7-(<'jVQH6<q)N5IH:j+FGQQ/VD7JeU
u0=Rhl%$&=Hmas(_qW#fPGVX*(V5'g&0UBB3O5>q@uU9-g$mBh;kO/+uM(o+=4YTCBBj64-2
Q=$KB8_qW\^\Vn6288CBjjb:^m'tHP+5@UlZ<GZnEH1MHi#n(sB-;,g<j[":=C';]A'Jd+-41
<F"5F1W_BmZ>bb:9c&/,s$LSJF'uHKoT".G4BRD-Kt,lXGYWW)nfhCOF5s;!_bNOQhf_o0W'
,-SK_lDu7ka9ji1rf.cpGl=8)VV<EA%!1c)fhf^Jog@a3!/f!mP86ssc.M1$66:6'S2=u^i,
7B@J426a1lLp(RC55290Z$;h.kB*;(5rf]Aeb'uAkGSt"T<R=U!VfWO0+\IbiI^REML+KdNm0
0Ze"d/7:->mBj)+V0>p)=)']A?IQT?=)S'>rb[!ogrE'cd2bf("M!D&^rNaC//]AWq66PO;2u7
DD>ih1-r3l6fq'GJfd9:M,4lD%;k1h<bqMJB))GNR9(<ECT>@tehAT+JV$q/Ve0%!1tLn#e1
g&ZB^\L+PhCBMa?"\`/+5/JN4<45O@Lg??Mu"iON\-%Y.a1AVV80'BOif?'t/i8A'0'R/r]A0
4[)3Vn`+h%W.cIdBDh9-u<Y_YU6<H2D%Tq=01^4D9LJf""()h2XBmS'0[;\F7+MK1K3Uq?7,
s50)8V5"X",^F[N:DR(hb&UpAaEe"b0;dkOu*u3WH8oe5F[0!o:i+nnDbT.c%FAUcI=k"YUM
CelGiH:rQ;I/>m*/u+6)5N;3g?F;rB2#PrU&L(HdI6``Q*qr%%i<5=o>VW-b&lb5F8?4]A;B@
R4L-:S>&PL$bb)NfU=k,#pbpd.!O8[-Ch/rkm;DXB=oEoQ4c;g$_Fp-B@(e;*aJG5Z_<W6=,
'+:KoV,/]A`2([hZKLU_-a$M]AE1'V9S\nkA\(@e)1tqZ%kLC:oTj3h4"h_9i!X42S(Q^:U6!T
()Xpf)a"b?ChF"8*HNm*e&/S`j3QngaS10@9UBu<\BbPl'^p31iLi7W@B0[5jEZ*("f(bE(0
bo(Xh@Y.+;dDS;RUGoD$fP@uo(#kIT"uuu[)7<dJkKg?$sEOj3P@\E+`W>.^*7Ve:eA)WcQP
FL(M@WbKdE%F)53)so!II%plbL4oB,*MkhH;m';lSf*HGGG=R&.]Ao^*";J6`"S>X=er2O)Em
hhJn[.Q[<E)W6.a$Mq]A^e:\bbI6j.kK7EsXF#Lf$3Bu:PXT0p=oc4''r2V*_,ff$S^oL3<qs
&+t(%7nh&&48>7\<nDWL*#Y!i5UF!_pJfmtm`6*7b]AiOk3"B;`fi=YCWg6AOT;#quskdjbH/
a>6)AiKq0$cr@U$_#s0i5/)S<MJKJ/2L5&DtmTB\595R3YY>AZ7fi(lPj#&4je)Rpbq%k.DA
UI=l=6,YHi)tO\nf&^aN7U)>s.(AaJm*[$h]AM8L.G3,@B>,lFK7qkj8=+C7(\t/I-sYEeRA/
cT)gQgrq8W@Tn^(;uE5CX3h#&-WAp2G\HUl06YMG(#7?q4N@UAQU>7e67\1@@"*PO9Vg\`t(
q5A"J;>PcjpAb$(o.atI8f,]AAR&j-Lg`FX'CA^R,<;s.YORh?0ahn-12Ej>(r80YJ`BI#VoV
N]AtDQ7JqRK5hr$RXT>Nj/)oDe%JQAoghfS9'PFDkX#nbXL6X'SN!qUm9@A$IK$Y8B3KCcFA=
J!C2p)`&7<mV*c.G(4IAhd4E='"iXCUe5XeDX46SiKdlUs6F%J>8t+0$nR!=O2oSU/oYu^V;
.jI6^V9i^=*Fn(lb>[Q:PT&j'iriq%I4R3G)o[@]AI3>"r!6+MFG:!U=hQ&>8Wl^oU*TI>0OK
q_F_bR"K[8%\a_a%fj!Suq.X92"H.J_%G:oQt2T0W^."j?;Gu;'7EH5]A:bVuZN,MLZMqF;-O
Q:r$T?KpKgN6@^(W"I7,gGUQ]ApZRa]Aq=('`QKpHPl)C=U4&eK4Fa%L!bB$6!`ie&jOLblA2Z
J(FaBRQSU1q08fd2Dq"&k"PQnWBH87KU2K'>1jYI;$>jr;^Y/r-"t=@aB*S'2<0#4$01<M`J
IH8>\hR2=Yor!l']ANs9t5qGA74(El!()(D)eI@;&9P*juHa#$J7R;_:WaAV=A6/Jt6!pWTX5
bsB;1a#\<i/m_Pp]AK^na'd#6FjOUFZXEVG(rJ!1[@T#'Jf>:p()9lFUSr1aTnqqRs,'IC,JB
>'OjTnP56CKI4Q>n!<]AqRdgqV98%X/*Ne.r:a@F0d]AJu`)W@htSCM:75p]AV'nO`[?NDkEBn1
Z&bV.KA>r6l:9W1^bb&H9N55u9_#*(nR.rf)fE*M8*f/B_q""0#0`\BaDK=uTmGj-a7k:2a`
dc)Gr+[G04KfP$a'"b%::"lN"2K?Kn_Pt7D2t]AE7DJ5%9_BUmg34WYpAJm.KCl#3^kdQ_-#H
N&]A6jGm/h;<'Db*]Ao^G4oHW#i6;P6ZJA4:&pps%UJJAkTGg82J4+O6U%1Z_"u+0"WW9%a[Oc
F2fTiafn"Yc&jug)ef!2Hs]A<Bm;1!h`er"3m'K2&AZMi5"as+XVhPRc1'"&k5^bu,&4g-<9*
Mi-o3Q''uY1q$5QlbZ-o9-C-^[Y;F%[,O\\s]A&V<EXYq(>i0h\oDKYHApQHL=Z9+gOPgqk'\
$ls8jq3+)-IH1oHV3eqk-7O2/oNi>^\/.WnpNq4EP8Rk=8),.tN,S-="q@Mi;VI67j)Xn.7n
!KcLYqkG4Lmg_Gt%b;]A-`b&hlBL:cp.R%b$_)[XJi*PD.uRNjrZ`3Fl*1<s)8_b?X;;Wfg`5
B?r0AFS)?*$C=pVu##"Y_g-E%[E6s.;l&[&C_:e^OH"HaEo*Sh'X&fB/&&,(9(tn,Y:Ll0j<
.umJ?b/,G;I[8(aF^.6@pE7?!u@"ZqNXnY9J^OGA]A<'GJpY[k).-b:JHBHg;SeGs+t%-a5[X
Di^>/'_n&#>O%K4(0]Ao7m,MjESIj]A'i2AW6uEj0+11[U>%s`k&[G:4*)T4utpHT%;'rK>bU!
.0Aa-[`oQPNUJHB!3N*-K8lV^3hHm%S`@7i%'At(nV#^3jRnXe=$d3PT'1(o^pgWZMLP8a&F
K`SR5ol0pc8r_!,n`fVKL^`/T+uK%W/'NOVK"%kK[#Bo"4dF]AgU?'>EG?oKH'ThlM`3FbmT:
1Z`A,R)$Br2LQWLhJ[:ALN0"8`M*e!AI!s)5knhi)D:M#MfUfLO!@87_,3)XuH;/(j"1K-dB
NU."hL3g@jN.WT"#U[qglh%I-.f*:gGl.^U@]A'>>%jU;P,k4d1B`->r$`"6aKKaKNm1B=Jp@
Jmq88eZ%jl-H$uMgO>Kdji6mQC^D!Ec`cq!uC#ODtK6DKsMBm)+sj6dA'eDm6N%//<rTk2"m
/$X0JMf?QKSBBdDJ1kO6:TjEs,dis5)q_Kg!Bug]AGC*C!6HELo^`4HS>CSH&iI(T79k^ND52
!N(XkFC)TjH:g?-_4$nPik11c.6FOa^.XT6T2%jn.l'6s\^3/CGq!p2*38'lls\5Oo:UZV>B
dq2sBtQ<T$cVMGnR;u#H@NHWhB0DD%3-lq8,AMK_O\'?R4AJ"3?AOX[tkCm<M`:qc<Od_K4f
rPOKcG//'mM;9=,)oe@T6et\Q<u^qf3HjUa,ED>#rCs5.-Tp&^W<a67U==i9$$N,f+?`Y'mI
EA>2M:`2n%\3qn_AlM1Lho./R89l/t&JDts#<jRL@"n>2+#khN(7#"->//[L&1fC^O6gd\u7
5.$mV_ja"fNi21Y[H\O8j\9b%JZuMRb9(]AoiV0__6.]A.pYD?n1CLfF`jmL,pNHudaZmGJ&)A
K[CIb\`.H-_9>iGFO%+s#.qm!(grS1)=iJ!Ir7ofdr(*BHWLkK4MTAkc3V$Db%Rg_'\MC-HJ
Y/\IX"mLm+?7$Se)*,aIN;7pW6U%5/GON/^cB^0]A?LPJa9;<h;/%rpofaWcj7F$2IqkLc@I2
i4h(bEqs,3esV^5i<%.0-u<;a/N4r+t/0*pT#0M+^*(onp7CJ/l^jI]AC4"iD%S:0A4qsP>dI
sVr:<*\WOVnd.Ym[;F:Wob-]AgFO)^39V^WIDL?gLaKfb;(mI2G5RTjcFAP)0g=9k.UeXJtO2
G/u#n6+/"X'7GZtq'Q-:9AqOQ*(?tok7!XZ&5,ZoCijL/_h'KDpGZC_4Jhp*]Aip*Wh4*i[_,
4hMbYU31FW@T\/`1u<;3&Lnpb+)>"u-0l*DQ]ApM$a8XXeqsb,ccQ4>86X=SZ!E,]As5RJ?]AKW
oe5P@FZ+9oH8[#V?,$")gH#*I<R3^*%k.(;.NZo+X4gEnu!%#Am85pF@CVA'S##u(BSU)raR
kB:u-P.73nnDsOEc$VjQSP2MoAHY+$bg<ICB$tT-[T$5V!oof#5lQ$LQuIN,%lIGS;odqpL;
W^fhJA>VNoE_8nScXi?uBr'1u6=6IR^&rjJGo&ZDk%5\0_;,_bs]A\Ch<$o+Bic2n/&KPZ5Zn
EsW@=9$"'u1.n3i;f:O)T>Ze="Q2E4AJ&r?k)"T(!:8V/7e-FQ3]AqG=Dg<-V:LpP:7j@eQ3/
%H,p&!!G4.?7%gJ%tU-nA=qP^Gdu1@G:IH__OYg,b@L<Jt-GZO&1`i'#K:;q*&<EC=1b2ebR
E$.J_u]Ai$UggM7aIi[bMi)(>=%fR9q7OR&4NUc6j6=j%W&N;t9EW.W:'ImB=Sn;Y5GW8BOW7
'?H:J]Ak.gm<lk9F:$'EmRYMYhFPVYSu=dOk1IeAd'<'#AOT9]Aa9!mkB?HlhS^#4(eG,-t-n1
+F8)nPZJ*tD%;3g@[ke(u^kt'4*k4.E'*Mr^UX@MV,bRZe(rSfTLlr(<6D2a`T)00D-"Xq%o
-Q0Wr@KkGe#U3P57*#@*bA*p>-PpAh0U4q67D0ZQ;p,ern6q"c1HY_1^L`bU"`fP0CU:sUA=
@Wrn'0\f7!/fp"@cdKj.EI@-1sXQP*d@P_u=CqBMtkhk;%s%)8APr2>Ts7i?k)S_gAU:(u.N
mD546']Af4o??i=9n@XHY$KrPJfb@@GXQf^*piV[J_lSiT=+'A!3gjt'C1Pg\(0OH2qA,hi3p
(mti5RlD"W#k;gce;#]AH,IHgLe%E#:a1PbADk&%W7`n1SD]Aoq<>6V*$'kjNaDnl$oPTNU<5B
Ir^BXY;phSL'b^/.2N(q:[XS.ZBF,QTGN4KU4=TBo!VK)lQ_F;\'E:$f*@eGG`\f<5>)R$_3
6;UVOFJ0_LE'T)8$W:21"6$Cr*.Ys0>*RJE-K75m%jlTDcWoX%7?obZYKaP[asN0q<l&.a)(
Nc_()Knc^mK"eD4\PL3.Ns4E?rdP\n.l<88O=jZ1l4D&N#I0"\t&7>4J5NkKqEK>Ic_GSYte
DA(s`0WEWQ>$S;P[OZ9Lj^E?]A\j@ZQMXY+-:A[/dd/4SK"!lO9ql/?)uD>,69NKJnbA1g8[g
b0CP)a0>;#k?Wk:^&kZ+&,?!o3gtNL+-4`0@;JMVsl#!FDb?/D5_3:nckA\S\I"cU!/l@nnU
bu=Ma)*3A";?.El3j>oer20c]Agod,lJ[C+h:))X_uXpSdlL5gYG<U33[LN>Bh]A<$9Gs,h/L'
r?5*^rbr.3[d0LB<1k.`D5/TK$+\gDq_]A;c=.Dl\k`p@R9S*:lTk0k5/d/]Aq9VgK*CQH/I0I
&pX$D[8d&$br.f.@SVH=54.I"e/3L76`fkDR6"k<3:_So*h5_:A6@g]AnoVPX0?^^"J]A]AlfY6
BgkjHN_.7rM$G6]A<IE!QID-oNOA5ln`L\D@(VT98=F*'(E:%!Ykl?*ZJ#:Z1SVul&VYQ"45S
?^n&<sq.#'tE0aFV'.gT22D?:5:6QI4<J[JU1;+0B*%+di'AWUR*5[)RoP)Yl\;1:gF_5$"j
GnS[uLX?(TO1LZHZipFt!$lmucq:c_#TE1R*YY55.%WfPTH-J@IoiU9pYqM$3.?@<i<-DB.'
e4E/S*bnHAC$XK^)&L,3G7YpIm]A\4tmZK`s>T*%?+.FjKcG"g5`0'OTF:DoKLb?$>fo.:gM\
nHnHr-sN+tl88*BlD]A"'6Q"eJ%IZS0S;!qOQi"RAKlZd:1^23qKP!DaGp#13.QugAYoZT0ZW
_,S+<,JSAD'.F]AJg$k4(+!Yjo!V"TEIXT@R*KOL!1hgV:Ti00EoW55U@3<GV!-BLN7[VsDO2
sT6Mg<,m%X$""G?_*,@@E*l0#,O%`bWSGKFn<E%fL5!`gIlB&/M<odiHZt;IV6(s8>_pYE^C
4HR%30FQ;EsZ:2Jr(NI$NE=@^._]AC*^;SKLd13qRs+Aj1,&2s9-c^U,t7@XU1608i9@U(jS,
oAhDSbB*ruLoosQ>72WUjA8:,fX+aO<i=2_[I'F%%Ug)[+Id6O6k8-`H.a_5+HHViFng7]A`#
t39@r&X"$E`,=\h&_gV&[%Q=7@bnV1ll]AA*T%Y\1;=E2Rq,R0r>1;"k3fl\\3oaO]A\#1:=>N
Q=9,cF#PKos@kIKMR\%!b%\WtjT`]Ak>e$R%6F)o?8'bUssk;P9t*/uPs0LY4MS$NUDE7`;DL
c;TsfHZ6BATk;L$&Bg8A>"Z?dM"Ud3o<gG#Mf`>p$OjVq=EHF\!E4gMS$X^lp$tG[tR:_>C>
Phjo31`R:Ki?F.C8#`fJL*7/>k`Vil9Og.Fk`ZV`%D3e.dj4LMls<PBN</aaXa7'9EA5BiI6
/3/;$=]AEjRJP(=$)^_P0"sYia]As"I,F.5u)4Rh"N!QuNhS_6FJVli=bO7%F/br20s5d[NVbo
/_9"Y<=.]AA>2TIo!G'O7cN:f)SMFb`+AoGc09;Kj>o[A=K8"r#r=4b-EFg-<]ANi+6-?%@%=r
R2N4iRGt.NgRec7VC#[QK\DO^:g`P32mu/W;qp4O/gN.`,J-(A3-&(Sp9d"K#Z[X\s=WNI]A;
jX%EV[b('bf5LQhR)e`bt$0cYU%+As3P@mZUW;U3eUG-Gm783>LX=Ror7nt)ebn?glf[E=bh
(.CL-"[Fg7cCX2rKY&<K.6XTEjmASdHho/k?n)>oVMi7Ai?9X`gS'6J`tH/1;if+Gh"bJ28]A
HZ:DDIfFh`GDA["j)dB>A+Qd4L)KH88D$7:8SGfm/$;f$:-+nM!dEIg!\tin-QQtp"`qdGcc
un>%sUdr`0+.NCU9#.hY9f5DVF#P?p,(r,<sMcRU($1V6$<cb]AS#dPY>,d"cm<!.l`T$9\5^
j0k(3e=$2S3/GoYU<@(FR#VM3c2-n%@IUC]AhAiTY7h%i(_-%NUp.95aZRh+]AuNJinkL*>\(,
+70t&srf,fbg+P3M9R.Bd(UgO;^[-hf.&^mf=k^NZG[ihS'1n:&,32IrC2D&lObR0[Y"I?(Z
;q6.Z<W"-rupXI(dth'C8%2LQ1Cl_ME#q*s/&JQaV)=G"XPW9?-3b>8><-V<!B"!o!+"/1&2
Y`Qh1OYlb-R1m:pjaSLh<^-V"-05n8SE!S&-Kt\`W)Js#*G_,c0-rs1".\i`s1B.3ja%V'C_
lN;l!<PI[2a7saZS(:O>*PQ4(f`hr:0tkC\"'R@jC_O)$3#NMdW\Dkt@:moc_fE]AfD;gh+,:
QW;3_6YW<\GK0N"&Fb9W`js3#c1F,^g=(<oIc-%hWZEd6"DF:u:!%)C=c"VkY6?VA7E).-GC
Rnp^VNJ5oH3f-i=-jq#oQioS4Amk0!n;Br9f;%gA#JdW*g/A'"V3"`pe7Aq%E=I+/*.!GL*?
sZ@6Hos!`M6udV=,!g;gJMb-t0]AE/F[dSVBa(A<e"7NMl(p(<+im<^0(&^+TMEf/Qc,]A:QU/
P*"H+KIUUM!*4N*qaLJZl@Xn>n5\UOIqaBCP:Z+"RPPO3\j\n<>;T,j"HE`JkdY!8%r-4cr7
a=1R'&^O6?m1c&\"Go#<fdK>s'CNp^]AsPg#WSc)*E*TE+]Adis5@Lpdu8_6QXn49oM?==YM3>
_l^3+bqRJ(RX?$`'F<DK&NjX:@)Qr@Zl<e3rrOi(Q^UX,C=D1igh2+5r<hcL;cFSo;:1$_![
^p>9edqO9O`'1RpeBA6aC/.-Q`>q5UP*g=:mk!qh]AA+qV`3CMBlpuD'?_o<?6B6#P,e<[l>s
@JqpDW?^fTK_Z!dtQ)%%>g>$8W\pEI:9/!B5`W/<tuDUL?O-^[F\7l(dHOn11q`[r)I?2T;N
0P3[n7WSEIoV%puoF2,q=>\'5lp9*$]Asri!nf4h--YGlR!PW\1);2a;M.@XjSBq&6jtCY@'6
Ue@VZ%2V3Ou(m+e;GQ^E_kJjirX8o8)(Rou3^N\81ETYhbCe-#d<l"f)8NE<b%:`-rG%$q,f
t]A`"NbaTnq)H;sgIk%FMk_f"_pDHQhbJ:gr%oJPd_hUgZ4'L?514C*a)!frkL7XQGf5M1=M7
ab7VYUoZtX85mW.'d6eER=qH*m'/=l(Kk%QF:Q7[pPjmnK(lDX&#l&6ke^>:G%U37M\?-Y'l
`P*:>,TFL8]AX#$ip[Jlb5Zd;Q)ED#_K42*E&;UM%/iMuq1O</X5^bhlGB-91;Ba`Q;kLKfut
lek%F#V?''1a5rI\XUAeJnHD]AHn7\-H'b$u=r3DsJ=Z6JMW<CcVN@$3PicfDE-MKs2u;LEo_
Fb"`gaP3qi^giF).pMIbN4uBGeegQl-Djd01HemWE]A;9;NM:S!`6,95oXqYp?+=."g;[K@;`
F*?^_^n5/J<,33a?>e''"NPPXHD/[#1=GbX-AS_Q"Qnd+IP)g"#)2A?]AXh9"JS1)B_$)Ra!J
hlXuCG`mMlFoGC:j_;,>1*iQ>GuJDprIWK`Z7Tb?'?-omg\=R#f</Pg[M8':PT^U3d>d-6Wl
=G<71k"n"%Y-YQBRf]A,4q3OK\2p6;PF:r8CXZj?K$DcbVEhd4h&K)Z@Q_b;5XDSd/U[A`!0k
UCM;p(a(g%@t',UPk]Ak<8bcY#@d%'Q+C=UULa;tqXK"ZD6^NY[-0!FSTjg#(]A3l`#4sWAE<!
Mlm?B1tQNG$bO%%0DAh3LhaiPW.mBVed?VhdaP]AOmSHX+<!J:dmofrIPuubhmA7&Hlg,WMHd
o#%g=$c^FH;877h;C.I*"gkS#YK6&4*j^sTtjm\96kPB>/$'(J;-\SD*'IL&)Ed")ubN,)7F
GBh9nVe$mdO5J8Z:B?!#[LekWF@iji:V99*F.2.)#b`W"XHEuh,oC5-utkAJ2e#$WJA+i[4=
SkYasbMU*]AZA8I^0.D!7smoEC)51HX9@'"4ignSKpV[mEP5Q?5$5[;`aB\lnjA5EQIi?OH8@
G5S?A$L2\[D"<NmAl1`Mp-XDOmbl4=OSC&_e=(3<]AB$4"Yn3g8qi=s,;<MhBce]ArEOuj$pBZ
BDK4;sNO@KW2fq5^j/+!U\I@s=7@Ylg(fdoZJ;;>sN!TRFG$;0('$gEMk7_+6&DCHgS9V5_B
?ZTi:.E7IJGdP[\$Jm9&ACoA[;Kk-/IHra(,Nj")M_"iaWh"R2G3p-QfcZ076&)'gC1rFFUJ
hu"!PlVEc[R94)W#SC+jJ[I(]AhGJg]AB;(q8Q]A_YSjq1&Z#2K^7br\dUXu,LnfJkX;^8KLNAB
aH^=>=$q%G^EI?EEAL>@`U%K3q-k47Os[S$Y0e'C5tH`p=sqC8$oR<cD,GYJO9X!,\kD8?BA
;TX1d@>=m';MXAkGuIHR(Sb]A</9r]A:'n7N+Qm*rfmC=Y@,S0oUSN#-a]Ajml(4>ten!:P7ajO
+BCeG&;Zi>-8^=+:j,&MXISq<'XGe2\JtLM*h`g/Al.W<Xnh\HOJ6==A8KZ4"FerG+YA*#))
k(k(Z5><*P(L<_r4L=n"U^b&Tn1+OC-\$2Sq'Q:`?>5N0V8(e&O=?K"7W^oTP-?,t))r[KHK
MHq/94&cHIEVNi\>gmK]A2O7NVUqQ9q@<@QN'L33i^R93Q=MSCpF>>+0!MG\ZCI6H$=NHj5RM
QTUU5*HCHJ*Go3a_A$&hAsBBcfO2db2I*f*hn%a?n2&hGPp'FN+4\bbMua[<Xuqq!ta;kF0.
D"">39!0P-O!r3BS%-Q:_PInhLDJWplW/)K7=>dci/!i@9ho*-7S]AWV4*c6I4SRFn@DI"Z5_
q8?)Z[+&$X)hj)n:o90(p^^2g@+TBTfar4N,76NLMdU$/#-J2g)@M\V#*\$Qe4m^..C[JPr+
)@VYaUbK3'tgjI]A,-tYarPM"c$'pjZZnb#4hH]A^%*:4CZN$?#aQmGlCJY!f(NN]AK'HTEGnTN
?8Y%hc(43]A.;-;KLE,ii_\lt!9VH:GVODfkO4SJFh]A7O27fc*N`]A2q5EkSF\J]A-+j:#N`a,d
JsJ'n+#<9^(1BWsZ;<$6;u]A*P*hqCcR(FXjaEooh3_lgP%,Man!,W3-b044dq6<WFAA\P^3B
MP0)o88(fK)Z<ZB_ub?^Th5B-<[G::De[#$qgptUg]AO9!ZP\VRgMSJc4eiU\i]A_CNX9_FiMQ
@n7*+ER'"W/f$JE7.ZGoQB/6qk?1bePeld'TVNVOamrq&nR1ScN0HT.%^<L2`'cX!\eo7;uG
S(IO;G82R=C<#i#MG%3*91B'6Ee.DRE(L/sqKX9A*e?'#`N0`D=,5\&jk4=/"bOSB]A1?5\mB
BKZ]AH#SlD1F3U@EN[=7JeBPiAoo6;G3Xq#+n6i&%iMiaFB9AUHX]AoR*2Qs2Nh+kfG<3mPaJ^
H<ii`Hsqko/7k9NZCnLNm#4S<p*1(Q*jJ%gCp*GrF?S*!Pi$]A.JA04$!kS,ZNpL:%&#^6p7S
[]Ah5Dc6.aJ[6[%%Xig=j->LaC/V@]AeY>3CIT'X-:dJe:DE?Q#ji>kM]A=+=5":I7HU7LDYP_P
[U9*g=19lafegm\"=?o^8r?H=qUTi%\Xn#$o(6^i$6"R_4*eC67gPMaHOe`9cX;EUo=CUoTT
>da6A'>XAI-#Jn)B5Dm`d&9)BVh%q2Ym<VV+KoML`q"7O3^f>RfWsBUlP>+Vb#7P:m9O481_
AEMODjlNXC!Fg.M'uV*gT?`_h&ous-aMLK%=C![e1;>EaI.)!_*n<aTp+@.;L%DUhcHsGmW,
VlCK:KG"0hGRVuFDf'ImoNHnjW/R5NV09rf8'9dHa!-VlsBGL7HkZE]ArG!nd]Aqj#,b\JIfKU
r0d'Z7EFp14a#J`K/VWk/+CO-*`4\nA?Rr9:%!q[qnZ?WP&&f`^DuWEND!7P/W.*2*d=cXLu
8uG9CqEnE5=f=Y=(Q(@YtfHk1,^7fHS8pa)r7OReZg:>bdfBc0sb^MQnU;f,sG=9XhG]Al8i0
e*mNK.m?YU?6BSuXS>+nYV%QQ&U*u#lR(2*9(c>K(0_n]A#Yf<hEMNEVi(0[6hq,%Ur7=H=mA
Y(mr.$]A1#S_f9/ICE2/=8>iW?nD^^O/0`0]A7s)0=tAVG!KuKV-A82b:P>(MZqcTeR=o/N?#q
ouA99Tbn_o3ICO9&IDY-f/WG*\'Q:gJ/`!#d0FqVr'6OU(/&O&0KhM:7f.&_r9k'p]AQk7H)G
&;CHfrm4?aa<N5)N%9/NWgk_->[_6VqNSi:/!4h`"n#i@*D0h:<[f*;8VXFG-QcF%L'HrfCQ
Z9N7UT/8,QE$tJ=<GW:*r27F1-fmOh(UX1^n$Gc&Bm`-'+Fr60If\1@$B5`Y8e%TkQ@S17$<
ImMr_>M0q7`_takaIo<;Tn/EKeSOLW'-11K*g4RRXA$'jq>W_0?KtIta0@b2b$bnkApPsjpn
/+Ufe?!ML2gtUKd;J68[J^DSY5Uo_SFkEN`MU_Q_m`2f4c[,MD,'=MI`m5Z[sa[T[+'.OAE;
Q``iX)D2]A)l6HqODP)HQk/%;#6%9u)B%2(DJ^S4h9')==R0Ml;`,8YfaUB0P+c1b^7tlq1>N
0sCNB3/+MbNjuBLcefRc4CY*7;TLK'=P[TKGk"%0qEdu@+j::p*jBa`rO)F%qM+9QV(l1j>2
<n[7Q(l=j_\/M`IHHZNs%p6lTEbRXb_Y&B"RmJAP@6kG*7!QN@un^CCH_ajD?Ut.>k!BqTko
]A$RA%La!#SXJdW%L@]AGLt*oC=+PZHf<Ql(S*6`LA<1(D7UNK2LKbA=a7GUDeB)$.`>>QaH!q
'\Sq"k<2YO5g>6-?H(s2jIq[ANuS\_0bZP@!TbJBbG,Z_@Bg%R35-/<[lo&a,UGiq[Fb1lD0
pR(N:C?F\pF1WV2)tYa/;^r`jT-:\B91#Ot`HC@WTn/tJ0gZr6Jj8L]A\,d^o,qX8+$V+$4.e
rA5nk$ll',=i9CALNN7*=]AB!I5_Fl,oa^t2NA=eB+UFCsr4k5K""rL5bC%MC:RA1Gi^O3<W@
jC;EE[5]A3Fc4AR-l?-Eh<,4RuXANj)6`?2e-U.IMO)&FI"X]AAU(,0rEOhfn7ErLaVc'^&QYg
e\q\>0IEN^!R)TNf>+sQM\G$[gaot:SZ3B]AZ_O,cKhX]Ah->p3%7p.Ym"?"S(Zlb-C^9*.J-&
?GodlS^Zq#XPTG[N@Nu3&DFr]AQ_D'NG\pVN9+ulBo\Cqr1h!jQtG%X.H8ZP($-rmM^0t;eoe
N,,]Aa>B,7kQ-G5q80.#doC13t4t1i[kergj841r5-so<c*U["WT%Y1fa[ND9K_1=+$QJ,ou9
[qdaR=_3j!/)=[Bl%q6D0P5)*HToc<b--%1E6C^0$\1"r[c$\p!pp/SAo)A)TL+p#`Km"H)B
;7U`!fp7;fu+?,1UDfIN?5u@l:tV6qr%>JCZkP;#5K[iSF'[,gA)Bn?oLR[n6`/IY:mb]A3ns
q[83$G.LE&WZgJ\%[I@PH=e`jK=7^RTNW^9s&Ah@:ppS(*<GR$I!2jXlYa<aCHd!*K]A\)2@O
DcF".eM)R^KBWbfhjP'G)&<S?,!,#b`:^mJ"SjqhtNmXe0i@(NfIFC6IW(Y;jqIrKZ%lIQ+A
h;6b@2bc9?;Gb*q3'nEn%Amro_n?m?pNOr\CG>\cg;[0-]A&,DJ6`.Cr0Y;hVX>@<M(,*qtY\
!4''&WJ5j7b!.!Vq;L"0nWDjtq3tH/(7Ae_/P@Y*,J"7cECVI=q=b($pL.#TC@XM8,3TqIpL
CLns0q6nf0G0).+bKXQ[T[dgrMej(L$@#kSDOGN^ee/.m,">@N`E3C3m>%j`aV32a4m%6Q>:
POUHYIhL^N,^qt+F+%F^O.ueE&7)oV5m.mH;6<`WOY[_0aF8[[ke!k8OqQ8#Oo.=aB)TCU,3
4s"$@f-DT$LD_jjo?Ic9YNHER)Qcd4T-P#rWO]AD]AO?kma]AD\NmLZ&e8"[UbCMelGG9V=`fNe
3"6X\0,b.@$=]A7/gfMe)gH^9@#=$kj.;_i?$ad73!"Dh(/qA]AM%ib6m=?!2NF1?t]A+J8!U<S
l-RhUn._Q_iaJ$Q'Qo<f[#sBC_p24G:'uT;]AM[slmj-\S=-Au*JCtg$f*A;p[f'\$2V';FE*
bUl+tL*tS+tJkYU$*2[Cnnb)$N_2<QL?22,L\<#]AcMVrkjfCAueZr8n&XY/SePS#mL93;c=%
8'DTsrOb#,Si]AN;N3Dj93H(_7OHgH?3jH<V&U-oYJ)f"DaZL=gPI@\(>UF>9EFi"?Zr]Amsa'
-Zhn<_(W%B=Dq5`s_rMCD1_UF[D>ZT)Xbc3[[NHb!AM*G2=+S6?nVH(rMcm=,>CDDk`K,1*U
a.p^^N7%+CEDNt)<(W$ag5LCQcAe8J=E-;`a\`m%jJ/"(:(,EoZY`S,Q>04P:]AChhH%1K4a]A
Hb+:]AefpjGY>>N.CTil9XHCKAI@,SlZZh(gm+@pM^f!F,\>O@d_C2F/K2XefS2:+[A@'bE^m
DeXE`Gpf-<XuNB89=H<\MJTDWj1Y!Mq!A%G2s>(DnXW21=>F1`<a@dERjEab>uE7`b#X;(Gj
<$*U$&7pX;AYI;ZAnqM8fcF(/ZlCddt:#DIek]A4kMn9V3Mme_aCfsR2%X'Ho!n8/NU,,U1-Q
RW6\PhrfK9q=usUP+Vc_TkN@?$$0mq+Em9;;aE<k,U_%qkr;g+aKU:]Ab2/VYHL@8`X]AS&_"o
M2@#*tb=&2,!ZkU=7PNB)F9f?biL&+.=&,(%rFBdO,!60t\\M(Sr8sYs>,*O#D'X"IfT"Jot
XBJVfi?:+'?:EbI4)k?;Kf4tbX+M&MDH\#J]AKYEO>n1d<2st@8DVD`J5YCJ*>Y(rOX3R7Fn[
@6C3t-f;3U.S+p,6.2BFd]A04M,pLIfiFUdQ.CCR$L?XQjKYgPeaiJ]A$"Nl8,0]AFi:6!?e*Z=
d`.k#u`-b-$RRU&mm>fnO!dc'<E94;\1K8mR]A';B#Wm/M6b'm,M^tR>Sfps.mJdZE%_@<m,R
OFN>n6bN+'h9?@jQ%T$5eb&0='#!ll&*#'#/@VK+4-Pp;j/rD"4p]AJG?$@8h77>%V\W7n3[#
kor(@9Rr#:80(YVM\B/UiX4p,?2/9/s6Db0omPOAZoM_`GJb5?&X@]AAB:H*#/R5DOG%\s'31
UeWH*4/!.)/*f"^A'?./$6<r,cfFQ'pZ6IRPjn#Bcu(f17]A/\/=(nhYX:ATAr]AQ?%7=CRJjO
2G;qG$j#%u/ffC`LR.n/7[\?@gXp:iX-CYm&3R$c5nL;cnqk:l*E0ge3.IVsr%V,&qjTFsC[
;Qf]Al]AJtib'?TRDn:InFQHr=TP&bK7XF$%Ftm5fA"ah=7Yff7BP<A,_/ROo_;$)5B1`h7)A1
t)YV0iG5ls6()_l5.S!UcQUlg+APIRS"gU1;%it=ICf*I`.@(4(TdiDh!a;pZ5ba.42HpqTn
N/#c`FCbU.c"Tp#]AYT)n7,kNiWL.lq$GSnM;h:YLA99/e5u;c>@fYloRdZM51Xg'd[:mEaY(
Ta493fh..+d4ZjN&)%f8PX&B6R8J^\[t,OS=6)cOER+,nPiEs"cLOW,HLg\o_0s-a<dR6OF-
/p<1:^""O&M0B_AYNF!AiBf8bdjjh5eFR+e`KOQ82^->KNrB5gmROEWKbD6IC>U,]AH_T-JcD
R"oe1-=_;FXhY**Cs1T^[0)`*6VQFU_,\5=SJ;T(57`CqE0phR.c=uMQ+g^E'P+6a6o/V2t]A
'^_k2P?(R.pcnho_]AGSG4KQj$\0&=^9#e28&B2VK6u-[Ym*l-(,3jM1l\.kn//Ra5HMsko2_
%41VY)U9A\]ArRqt'0MioqRqP86&@4Fdu$rYCu@#%@6+)RXt^]AkB`9U"$pPX&["2ILeE_h4\P
"OPl'Qh]A[$5fu[o5m<Jm+G!\+i[^HT3"r>4-7NDm:2h2m`M*XN2#qBVXh``-lde).GOL=,Jn
phYLWD9*WY7C@;Hij3aLG+4YTtRdic[FKoUZ2_A!g.kOBDR+Cc6^%j6V5KO1p]Au-*.8alN6<
I)74!4j/'5!8$-dE,q+>[W>XJ2;XbW'n6Hou2nd4HU#d#a[<9<2B\N,hLYoc,oN0"K"GoDq!
T3a1hsYn_lF*E.@Kl)r/22oBnd!ma/SNd(DceK^Kt[<`Eceq4FVmAj+%g#_I3:JZDAj5`?\.
5/5-G04:(W[\'NkKB9m\+/n+:RgM$Wo&I7D\%5(_l7XUh4m.5WUCj-?,l./h)56*l3;kmQ,,
G#rhlB`c7D8r(:R%e&s2I)[oe<g8JA3)F/q?F\o#k/P[tc:m#n%):,4eh$mM02VtnrbUDU1,
qfp!gB,02ku(fh#rm:oM0451=o*^I,2J.[e!+[bn5<aDl#1j'.X0umGT8MU4-UA]A5kan#bJm
B/ofa<gKtOm3GO<66dnY&k3%Vr@CutL_2WaM&%4k$=9a#an1!0]A:8M<@ThW,T4O0<TpIO;?8
IEHV-,80BS@bm77sPobr;LLrcS4GR5>V4T2Z`.@65ft!GaY4a\/I8ibUo-rW10$+Wj8uR3aQ
n5Q[,&jLV[/+5;a/UMj[kOdZZ!?&^A_6.M3&/;]A]AT#314\a^6QPD>_`H&9@YKZMUc[raVpWI
VA2(**:g4JqMDC?jWVQ[9AdECKB(^mkH#[@[Sm/;Sc&&I@:`7(e+`RMr"e")P]AtILSb6tFI9
hm>>U1)m"igXY^q\4m[oY?d\A-mRC.]AQH8\QY\Ro_MRV3PQ1laY4n8!DKtcPjL5L"ZQ>@hD`
eioE.0qUqst,$FoAJAIDc*SRVE_+ucaF)a"LWX=T64Oj&Z#84)toBIO+[e[Hb+9<:B1q-!-^
/8Q/\s;0WLG8*+j$!M(FWrrC=ed9$9+`o#>\.VCB@"^H6Kf)NhZ.Y/kgMO;,8[!UkNNgMhTk
lc,=qsC/.@rV!&ErPi\.dZDZR\$4>oaH/,dj[B(T3s?d]AL*P,G8Ulni[/p(d#KfOV]ASX+AbA
,hPo)`Hg?-I;]A3+ppM[NkqBU:53r,^FeLJ^Nk`.4A=+Z4!VG*s:20`(Nk8eL2IM)S.]A__sr8
%"05lc$(MA/aT.`m#7j;t$#U5jsk3bN=k%A4%_b6Uhu(qP-@?]A7`:5;hDV6GuPq"[u)@C]A#(
-K;Q=ZW:WG9Z-G+D5*4:*%PqFN,\FaqT8!Rb]A>2&_]AnS,P,XT5b+%!W?%(ZjJG>o;F@t'[G1
r!MaX*qrORC#LRN[Ah"<C,e$RnacgUM7Iek)]A4A8LjaZ3tq@ubL'CBs--\5p9#e]A!F\4U&%0
LLgWen10!6FRlNYmS36n]A/;XA\1%=j++H/ZO4^n0;*d0J!?=0CH9%X]AFR3L6;L$7*7V+nHQ-
X^,QA&A`NB=RS<c"Bi.<;2T7ZiNBSqN*!A#5p8O.nQ<9SnJ-]AAjm:RT`6'fgc5PJ?<P?2qi4
hloSgN-B1#Y#?$<9bK&i<rYUrO^P'`>aKdI$9$Rj7m^+airG&g^==.::,e4i=0fTo<g.@$A\
EduaZ7K20<lKkomC@qKS$4!RPZ]AVl.dhpe<4)1mni;QnA#89g]A860can/'4Xi^>+8kboT(CM
NpA4Zt4[f?kF5C8QCiR'H7aEg7>>'^XaW?4'QA_[,k!/Z9H!eGh!_K1cGDL/'b:=1Zg2G!2"
E43/W$E3PMUc&&%4PZHi/4E^4Em;$(pGWg:</eKC[RfcLEu]A`W=M*mP?>8X-cF20YP3RkP(,
(@rLrBWBnr4Q?FMm**!X`<i*?H'81Z)AY]Ac\L2se5F7ITQTrZS2lnmC@'1*7%7fL`bo[JsWb
TM^:%Sljel#cJ_i8dP=5Z3BFA.K1Y`Bg>EO3jK$CD[I[JMH2:j@n$kEBXlg=K=iA$AK^;ID-
i5e:n7l->3JjSaOm(Co"Jqb6*r)eD0I(J,Xl:1KQ#V(mF\b2lLT6(a<&d`PgMj-=_O8oa1(M
m\P#Q:eY:D,<?X)Nie,UFJ1AgPfU&k2UW.T?)B7DBpL^[-ZZBKf7\tV2KJ#m\i\XJCpE"i]Al
-N1.[pSSmt!kUs?7C:JEKX"I3;44<bY#\fr)q#h!TUH)cIh:C)BK#KA6)=G@1.*%-djhgc?I
TVHYuB\u#hie2-`#m7@*O(CP")$l%<mPH0^P;F6("sEIs#`E_feaZK>`n.&q!(]AY!7*5BZ7-
K.qTe10E;&]AcAJD&RFdXX><i3SZZ^,E,954b'Uki+46/H2%eLujA+o*u7<^-1-bO:]A-!deu;
7;J\i]A(+aZ%V(gHHQ`*0fcsYKEFs*gg!#74fQ%P$EjbYLJW19Ajn0S&J?R3sX#S5`4d+.Q3e
D2+64Ze313WN`2M)pu7E/G:mZPpCjW[5mu,L0WFgoWX0n8:_.KpECorAj0rC7sk-UML<..Ad
Hn,MSbFTJ*/JMOrO@6%jLL%MKiad-1&8O$?d6_Ug+00A0aDn)ItjNW`SW[EGP@Y<?7`?<Mba
f*,t>bO-dlas.'Gm;#(V#rBf,b1;lq8sBgp_BB`@f'BH"44=aN&<[>69g/k/CDL<m3s(u[K%
^6N",[$;i<M-WrI2g5AAKg)5buC>b#dZc6?g^gqRCAsF4$3UR@Sa\@,rEib,Set]A\5&3dU`-
`(>qN6<*C)APXd%H,gAgX4J/d,81_.$IE>&&s'!?/Daf\T(QRBH]A)BkM=J9S%ql]A(-]As$G^1
%^B-n[XZ,e0$u@6nr$Zh<TN1Xa_cIgh!)g5dGt#IqZjJ[5e%bp_%Z3),R^JBiLrZKDIO-PB)
]A=kcrlW6=!,'L0UECKIDUe-6q9m[%@(W$7aKH+FNO^\TIZgbmG7=@^_uin\rZ-b^47fgZ"'[
N?B+)fWD`'D68qDe?+Esp?F^O1lTLo@L*nZ"k^^8KAI]A;'s61*:OLSL'+n(,GcG&P^k_9ocO
fl`9M<k1_:OpJRGT5V_Ma"QL7a>%[ME2.-O/bnH17Kq+h>ag0s5%8O>CqK8X`%LaO:0]AWi".
"X7ajsY7rgqp9M_n)ZQi-9NO>pT6qr5h9#2r4s-`!/j:?ei^AuugquBRUiT5KNj,g8'0.:$?
R3:@?1n<SK6&Jpa:6f'NZ#e9&9M[6JpKdRi,u4MLBEXa`!2jZjc.d7b*g#ZZ'+fk9,d;4m/5
kKUmm4;s(*M'J;Dl5A4o*o7+Pk3WR;RMA>[+5?M&K#*T8WlKY"QjB`(H7k\!ETFf!!&eNh7&
nG;a_om_(XDCAJ4$2%$lH+MI9NDBSE,r(o]A&JI[blY=HVEEkQ<;DRTSnm6nNVNKQ^8O.Xu@g
iP8l`i[2P)if_FkM<2fS`n#f3@Db)_k3]A-1[>ae)^-ODtf^[-oic:&k_"D=C._\#U/b^57-d
5=t)1,oT#NKq!2oOf[/2M0FLa96_qi.TK/9;<u<>6p%c,3"D/Kc5HZZDhZ(_.I-6?=i>\Wmr
-[Pc@54Co\`fS'hP5U4JuF=TH&>Bo)[Mspiit%u.99]Aj)aaBTK\:iE`[*Fahf/15CrMNt=nJ
Y#7S%gJJ+FoiBu:QPPeM8;Z5ja[`c%h:'EVV3i4.?]AAi4-%ao6PTbdC+1\bc]A,%rg".pjg\S
LKTmOO.4mm1IZAkq"#"Fejhe"VtcMT[X01Sn_6`\a&i(CVu@ek6L8-3.&$eIRl-p2>tm)L%q
uS1'Wj(G<q@%)dM=B&rIpllT>@n^-URjG1F("kZs8f."sc^HC6;I+M_Y43%UQ_teT9ql3pIb
FN#F_BhIk&R[>\>j,CRup1!.=Y<dI4YbnlY(WR!S"C7p-t)naSi\s[k-;+kA6,Q3LVMBLWAc
tRON.*o!O]AZl-VEi60d@<e!thq)qm0acnlEIa_XGYRK_1AP+Vf_1+Y\7N*FR?9).lS^`oI1^
,&'`Ce&CnQkRXCS%2Wg%9hk>JIaKfh]A0bZ'u!F!RFVs7SL52;Sn<>,-4_p&!T_#g5"52fi8Q
L,;^=UVAgV>N,P*_0r%*^]A1J$]A)ue<MQMK,9Rf,!bu*XRLT]ASlpDh$\Y0[DP-#6;X7H[W.k'
+KfHa_D,6%G[,9J?#RcM&)ji8O@pk[g*LkD#ul4:8qrG>VXGPY?j0%maHr0LKAKn2/l+>aC2
Ce_Pm.<qcSY>/.Uh3qfi+'l3n-leUo$F1Yq)3_5JTkLPFD:m$ZMn7RdqL^adbZ6P7%AK0CFc
;*RWfl7'4+gLC-Ed3?OoHpu#9T3!U3R6&E_3'pfpGH.b_<u(_aKh3*`Xf$*9pUXjX,c3C682
?f7?gK#kkiWMAht>`C'Q2%BNeNHX=-)O%7[JITu10:%9b.Z/l1q+nQt(2<<[*T;L*ab(k,c)
_V86gh^&2%$'/Lr^o028s!%#bT*Gja\!?s9EW/BQ./1FqGQ4&<Z&.*;Ioe8??I^=!eV)PUc;
k#JP2d=EJ-51T!s60B'YG&S`jLjhU4HM4\m0oX,/#5'XACTa>*]A?ugLK#1=qT_QnP:?_=Y)7
S3bnZ?;t/BG\1/ju^?i*nHtBU2D.ni`g+F6K\`QE<g@?DN\p+0TbQ/rJ]Ai7OBq)?dp(1(.FW
.W^Reo%DF(eJD0N;L1kXWiNn+DsRVD07iWKt9iW8R[cYiMn$.h*5/C.VRa4ZuKsJ^FJhsm-m
ZC>.?k`<BY,-\@e:F4CYUTMO:LWMc-QCkFu\hl6*LKZGiZ-'c6,YfepcH;0!s(m]A*n3J(e>o
h_!<hj59WXAX$WUMPe3PqSo)>fHo"<*,KpFD_\p;)120&N]AZSZYHai,Wh?.$=morcq///'(7
ruF$B@J.%8n]A+BRi<ZD>nQKjZe\f*^PeL![M#ZkJ-O0Z5.HEM:eAP,kkG`.2iDhJB$)Co3#<
h^BcC4AE4H]A$4d@]A2lnsY.PUm0[=/:[;[RoCV=)ZO"s`<:U$Qs<FrPu!n79=^X=#M5)^j)uI
2+aVFc.(m0>gVMiGGC&]A.s:.O7W'APh+r$_suNkUm5g)V&<DNIRLt\q&4'>F^MEIQ6^X[S-K
_@X=d*TJn0cCr<>6jOUB#1HMs]AW2'S>VO&YiC+oeMZSnohJPLC/?0Ohs\O)\F/Z]A7(V,%?2n
&;G^29G@s=8m]AQUA!Y\4n3Dufnu")U'h:@cs0Ze4;,(?\rncm]A>gp&6CH@gW#\<Vb>!#Y(iW
FfqZDs\V?IX(rX3*e-RusA:"<rL187q-RC6@RPSH2\85$BD07Z;jg6:NA6C`j<e!YU[9(kN;
366IG4PB0OHcL=@aVi%mgedZEbce1=*n*g.%^[LoFHUkOu#_P"*Z_0at7RJ\Ah#7WLD+Nr&T
O:1k2]A*U"e.^Y![l5PE;@-mf]ABIrU=.P9+1GNFamGF8W*=&^@B@":HX\gc0pc%1%BLgC$I9u
I/#8,).W,^5[H(N/9d\k5nMlr=.3X<Y/'pX9\?nd\<cJB"!&/(0[%7t-AbUf6f7-$,*EIfFj
5VpOGe76[uq84`K#?W(er"htaMt#J>:QUJO_%qJoVcSO<[$8,AdEYVBnlQf=abQU2*mhl&3E
/VDWZlkP@rj=,I9IWYk$d;Zbh=e_Sn1XCP>`sD3`7-B[LHES=IH#2SqmG<RuP@jJGse2/cZ_
S!'Ja3IYJ&;qqk"C0-lJ-D;bs6::dc]A2XfM8)W`Ld(Ddh9he<tB?WTt4%fIiXqHPlle`9J2A
_CdIB\ZGSZIlGjSrah[l78lbpqZj+WBogGa_?U):a9[KbLMYX=VFhTCfN.l*Ze*XdKjsZ5&d
A/?XKDrOdcV99I:DL%MM*aOhp=nOo&9#Sn1m_%PJr<grsPhdSO^T23``T]Ao0VF;$^>l6rk1h
intbE<!Qc@1GLk75T4<^SC$(,du7SKamB']A'lPAa?,W\#Q:d5"CKB/&F2LU.fOX:9miNYe<)
YL&IRAV*m3F*!#M`JD"J!d[24;%bV%4(g'2ik#JZeNQ+*M^&7;q6gq'YbkT>>prU0rd$K+dY
/*+4a@1/XN;i[P1tQj&IeILV3CHO\>hM]Am@mL<cdRH"Yt&"#iKcU??^)_4:W\(V1BUTF1$-C
_$J._Emi_MTDLZAQb@-ZdXeW4F:#Y"qfoTW>#D8?@Yl'S!q_*qNQb^bFI@!2&,3Z(485D=@L
;P]AiTuu[=Hp1X+Z6M?,dU/;=S>8SoBgUJ"D-rG5SVU2CH<i3_]A7YIGH29AT[;]A'UgFD8`<*F
k1FYu6iRL/ii&A7*/=1.bU`^T>8[!Mq>3h+S%'oh<7@A<]A,uU?Y"`E)-Uo?M9GL,CpL=H_a6
Oh%0l&_65oWKrB>\PhNfoL60$@FX"eAadV2c!^gCH8BMf9:%87e"L*9\J9S^Y<D6s$92+MP+
HEi=U<qi<cOJ+Z2-J2nPp/p,K1g:RJ8Z9DV_"NF',m5Ns?)\SA+qGG2]A&=&L;'=<BUEB"'BU
E$"@TYrUZH/'<Lkm7sig5V$YhbZq+f'!?0_(2A1;c`a7cmS>sYA7GXP1Y"Xpdd*/Y5nt`OuT
?WlD2Znr:?HT2I&Y=;RaU[OaXUNJW`ii>==q@[^JBr2B"1j0eA5_/64oKC+ijdhLq_s8C(0@
A>bs)O^DmO`0leKJQk3KH2E4:9Sol="^$+O2Ls9>Ei>Mc%=nu!CWQQA":^#8;>)I@(%P>YhU
WbE0(*;t?gs%V1+?9]AFh#!5iB=cD$om?+eO%\!g/R;PYAuFB2bp>K@.Ns5rRgP_?\2dL'\"I
C`dTthgR?2qJ+f(Ml+Oe=@Ot+ra9O:97>:ss1MC`i79t$$&sWfcN@]AaQC[Tc8X2I0[/?b*,A
bq:FU;ZIr^B*+"EJ]AH=Y/;5[s!=E8'\58u]AS8;L`or6L@0)WKQI\C?42hXO<ENdYUf5hH"3^
17V4?j,drr%NXY.4?N<PKT9]AH]A@q$jfoWNK.\'!&7>@D(GCldl[:FV?nU=]A`77:YKq`=`/eF
.rl?Gd?Okteeei!/3Ke8_Ij?kKK<krJ.\J'3mr^n3n@Ah/>.p:)JLHp0Ct`m=EY!$a#F23eM
3&MLt7?pp`(M;/bX7E@?k+(NY9f/p3(8?;frbWRW-BSdO9$qa`Q\uDMcMJ1AG3:/*i,dgKG0
5=L61:<^9j]AjHAKo/0AhH@t/HS=-4q9U/L#,e_0er;$@;C#Veh/UIDt$B^4jok&@s]Aj3Q$."
C$8u2P)$]Ae[ImYL`TP^AsV/k-2n2`0Ih$/UD_dg;6J^QDP6gOGaj0GeH\K553)e"3`=DG9$'
-,955.YCr9AJDeSBBUIB?TVU[*#KQ.!@k&?P23hdacAT-N6'+Zj8>$=t\8@MZbL(A.9a:Y:`
_F#f?#>nr*Sm@YZZIrqCX_B.u]AX&FF4),G0SXX9@%RkbNg`frGn^!N^O(;5QAF!NgL9#U'U&
MQme[V.`Ji63g4u2%:Bt<-s&rHGr>,$KR5=*,nX,+a`ar_mMpf&$XBkH2MrOjTQ2*CEnC*Ot
-'?u3O'4GsLFO6ZIHWkWQP$n'=*HJ@J\-eI/D9%"ZZsP,BWRm,j0M*H)(SBY_j'A3ViJu<4]A
S?DPKpI-c]A="'&MKe_-iuJXGKEiD%Fb)b-N^/pf>`EoSL$#X><+E^I_5]A&]AT0+XILO-N#$_]A
^[7<BudQZej0nc4'M>X:.9q9GoG^D"ZNi.LCI5kJcQfn!]A7HVi]AI3d=[%Zcr9H]A7W%_nijdQ
;:%4)::,aP9#;>8>/d*D%E^*dW'>%3.X0@n<f=(L"cNjYHrc127iRZ2`>H_]ASJ#G?F8TpEm:
p(9eMXS%Mbg=bk#CUKAC[#oWmr6A7QE#SoUn;gnpVNcb^.VY#'u$F6f!\Y_5JM#,GDXq2BY3
R;l5AtQNpp:hNr\$Kk,fgK7'R-W^=o=[/5F<`e(nP3p&gFGY-?SG]A^<t=Y=ChWs_!.d#D(3*
;Vn)p@AE:J7!3']A*`]Aa`r*q%&s"dY>?N_`E&$3!PnRE]A`J!9gg1WJmb7Lu<b2`/_Q9iTH<ck
Wp_H`k"Fkt<L!QD2Y<HI&cnWc)A*cj))P\"p#6kDtV)HW8H@lSOo->t0_rp>NmkG3H-qU'.3
%[P6RZs_Q>]A9[k3.m<(RaC@cr]A<<7]Ag0g"C=tp=9(FeFIh9flbh't*bA0mO[4r#B/mO@jX^#
$&[e"Q*q@h@.8(giTJDI8t>):?FXSTmOn3ufQ1<Z[CY[60OBHNWCY9U<&B^inU)j,dq@@dJ0
l-B#n#A#V4W%=udC%B0Q2g2PHU_=i)*rS)N:$02K`MUBFl<_tH(J@>*/2'S.U]AASc0G8n8&g
XSN/pJ,cPG)QKS=Eu0elu[<AE=6WN4:l7g]AFU:m?tpdm=]A0#m>h/M#+54[j2McJ,^(L#/WCP
ns'/Kj;Q>CO4naM(SW+<Krj%8VqP.hY7Kbj&^]A$?S,kZI@g\RbFqX3oHRW_6k(f+u@R%c5:?
CT%rDd;=q6*PmGbL#<7YTZ?\c1f>3,DR;kHe@M>gAhCWC<#m@f]A.0Pk^\1+[o<O6Xq>g]AWEU
Zf\C)SqtS'.DeJ7J6a#)WI0:>C"[5^6+.Z<YN%T$+,U&32KH!#g<#mk;$?_$s@?+K="p!rdF
4X">MV+4Q!Uf(V[UkZM+GD*1Wae19(-m:Co-[):YCV>0gZVSrNI\;mja"420XW]AjiIM&h/0#
8+,t[Wq#r]AYPDsD&RC+-2sSLh91W4GWknsA:o`[2"Dd_e&n@N,6Qb!D2cV-JR:u<AX&#kqJG
o]AAD@,*FbIC?'dd&pU(FHaG=%eN;p8-#YeMsLKBa:ef=hW%'*E+Z*p'!?*m`fu[NDeMoW6:e
LR+8Fi#np_q#$Vio5[ETXk7iUXUX*2P>RFI2F7I;8'No$Z-g=/S7L.SYF_Km[5,ktqg/e-A-
R;H&H/l>P1UoPGt..9\IW82A`+3CBsPZZ@u9%qa'leB[*lOH8&GrY#)GmgJU6q,`/"!mqK57
'+kku(*N_IF]A!jM,8Pacd*0ObcjL:qq9!]A__Xo*TgoW&,fp%1'irJBm8]A=b$dGAHLTQc)2X=
-bJ-UR/I4Xb/7Md8C9Ydn2fZP=q6o0lk$=E!#D>1V'XReM$O?6eaF*]A^dK$_SF,R1"IOe9L/
s((hM7;bJL`8T@b?-Nmt_5'X6T=g<=X17,4geKb_EQ=n72(0?fsITC2*uf/%+')__E@/e0l1
7.+)Dq6>(6LE&u%jCU/bpGa5nh*#*`\Tld4'`i(sHQ'#_c&.1EoC^\#5J%`4Pa:!^CIS-b?a
S$`:I;3&(Gmhb#s'%uCrYEs`UN+@Hd/9_9bkDeS2>G95`=X?PWAZom5@a`0Pm=9"\RS=SDD7
-h7ol%'\?B&4AC^F1Y\A)d(EO)E]A7_`QTbcDr,eh-0$KWA5o<@'hRD+_`-WU"'Pgu[G@E1ZD
"9^]APe-Ro]A!CF&^8CYkPR"okqkSmJ2&:Ib4\>I*6/."&q,^[6PlUpPGS+`e1f&C#aCKSV_Dm
c-pUrd)S?pDOLV/5&IYZdLl\/+OLNW^<Q;C2>:3gS<)u@cRT.sP6M97sFXW.gu^M&cUP%&D8
J@tddq@ds0Ra]AAW-Eh?j%Yk40P.J76G$fVhWWuTl'K($E=Bq5r_NX=j$"rH1oaQV:;G%D6-R
$?RkTkKg:<\b0A[+^IpAW3cV>#Bg&AWM)qCP9SbOj`_Cdcra6#.t+=c*?FH7L:miVX(8U!(f
!CIJ5P0*4es:FoX4,L0nN@Bq7"1$*+r60g"F7g<Et]Ahf2d9(]AB\:?E"3q_a8J+oD&6ZBM.%9
Z&6c^gjaqfN6OLKnDm*ce,g!6e>6L&q_uI#ggIU0QL6ij2.jF;mdTgEMk0l`pQ6OK7>9DdQW
$`c9C%\<V\MNf4_\X@rT&\_Ck!*QgDRXIg.ip/1T"G6LkMr&MCC8i07KFY[3//"!fl)<>A'5
s2)kE3F^u^ji%2pl:E.BEj,=oQ$[;0f,%=\COE"1[,:'"1W]A3UnAm:>[dMPq1Lf!pmt-P)6`
&O;6mV1N;_1l\h[+6aBJQRG;lZLcaYY49@o&k9cT<KB%P!BpNl+;P_#ejQ1Y$Fm&;c-nW4a`
0GPIH:4u4D.UF#]A8B%%O"*#ZAdcrSq<7UguQkPdWnC#gWBjd/C(0+uD`P(Z?-HlOH`^7k7sl
Dkr*L`,jQ`IVTP\/VNYdO0'i?>W+T.$16un.`mFONKs:&U3Ktlgj&]AQ-H0hE%d1SmZcR0rN4
3654%p%-k%9aTR()CPR"WYV4KB&U!=\^((1L,^#rgV(bLUqSXp!l1d[gc9tb)a;s4d%?XcLp
RF]AJXS0*Ql\lM"gG1%,*!eEW9iK_J?99^;UWn=Sr"'HW$M3>5nZU[&Lgj64*1gXF7b_iNtjP
o+k)K;5[.7R:+>"6)I(F<r$Z3F]Akno'7PNk:/u)HeNm0BV$8L8Jp!V[K*[<>Rc7bY@Hu1f,*
B7rUU[J/:/q,p?]A5h8>e^)-JBf7od(FO[uG5LYAcb)!S6m4b^EChb)>?K=PXH+gMFu0dmV3A
jNr')_h+5'/=r.inFKnNM>22,i_f:EEAm?</BJHA@_4"[Id9``;Traa=dgonsT%k2gM_W"@8
d<r/Rd#"VE;Z.TKm^%O6jV[rQ\kn7"eNEXU33L5pSrUc`R,?Tm4%H@L/gq3V!Y!Hunr';:.&
9XRF`MjHgm?c!ltT9;B;6+G3.6DA4U052cP[,rLr=s+DdmV[@1[_-SS%=c=flS9_-.aU!_+D
J\tMFs<i8A$XCKn1c#;)D"r6_5O=h1X0u>Iud<l!hAKSc5_SH[=)OD!BROKQ_$,l\m_H&lCf
AL%t7=UELq!gVPsQK[ja$r/*+$`TI!]AT2E5g2t[p"L(`+W^sX3UDt`T0'm[N_:u[':p_Jj-;
(V3++9q^ifJcHk^>eN04sbCr/;S3,CFVucEZH$M/MEU2?YGp<RQQ',o[6/a>;#55o6'3eX9B
rf::^G_ks:\`NpfK?,Mc^+cY=eR.p)=W5#u;LJu'lE:(7C)Wmd$"<W['+)-l_PS7al%MP(^u
`8LhM:%_CY[?u":8O6KDEPH5%C@g^,+ppF6IqCoB]A:NR'??G?/:ZfDgK8$"gd0f@eD3sej%)
i0H!;:cS*^s,-np,]A]As#h,0Ma8%/psOU#5(37QQPu,@a\-NPjq/0@p3'GbZXZ]ApHs!r>KDUH
sak7]A#T3*V\93RleDTYk7o/0.k0:lJRc=BGXXQ:Xho7%XJj7n,4;Xkr88,'&IZ+.7]AY3K#O=
G#bl-g1$mOra<Q=;#iX_!@T)!g+<8F>Tge2BZaYaq!H5-++s8$.\8WV9%`_/$^?3ChQ\q*Wu
^eeN^SgDVFpdpM+8NX8g?elK=9uO7"r<KVj)U%.s[,BRKJN;AA_,7+gbWM5ggk%%Mdbk`s<"
$4f:U\N$]AuigEk\S4l%8+fAI=b(?B8_EjEiYqnK7p-@."Ar]AAr%X-r]A4\qpLO'B=m'._s5n@
"%X(S[D4LkU+i)L^L!*!]ALhb.CGK$>/G2VcWT;Da=17Lh`i3dQN4?<Z$V8>'<(OaT9R6,:,+
GJqQ["co!+2G^3rUDB\4JRTm%TWIr_2,Rl'=_CL$d"$Y]AGfZ(kI[(i_0:rWJ,\e'[Tc(>&r&
Qo:SDK4X_Adh&qZEb'.-_([sL?fn@N-CtU+dM,>R#pu38A$HmRh/FHEW<sK(X64a_\(tWV[H
VKa7?.9,!FO2]AhR7@pYALa!70_BisbMJHl[(\Y2IQgX@LhNIuY21+8P=7<(:RdH+7)qa_X>?
3hZ#=QrXG>Iemmp0=P0WC+-(HCc8"IJE43bjE+m![_(i79=c'V\:aG+E?tJ[?-/+O"IH`Jm<
;/o7+E2$=)i"G7ReJ`@Q#.T'3!4h]AnjZ-n$)_cc>T>HmB`Rn5_^+Q8b`0@(;"?=]AcF(3(Jfq
[Xfsb-Mq""<>IY)^1Erqe_o:RQrTAg_gYK/HBKMscPY]AHJ%L+PJr="HI0,qug7$=XbY_73S,
Wt3V2o$Y`Z$pKn\EGB`bJRs(]A]A!5[*niaL>.iXEZM]A)rX2UipaI2=EV>!X@XrMI+k3M19'6d
%\Pqci14?%sui.MQieGCQoGs>YK*&FD5EsSN_eiSicQaq&^Lt`[BNXo-i&L2"E/R*9a>^U@8
ijVJH^%Uq&Y#,>*_tiL@1ttW-HN;4gYd^`N52p/uf+H7s,^=H#IV_Q7/OpGTI+rtq+HM09p3
]A>Wp>Fe&?"7#4.&*3niu]AI!erP/ZadW?NM(FCBCC\#Sq71#Pk^27VF`/XWGP&5QV,t"\T`sB
bBC,st]A3G&<@%*GD__-J>XZ_l4P[kBVqI=]A#MqZr.rCS)&gbP.'nk!F(..q!b:2LVmf.HKrh
SYdXVALNt(M<<d,l@"!l'/[SYhL2)h1<HI_u@[=lsYn>]Ad(F8Nc7G65V/FX"bMF4ha3Vn<c\
-I)>7<-hBWTu\7JhOpXU5JKG(BlZcG0r6'2a0f&@T@?oK]AW2Pl&0I"K25@c6=kHLA(q-MSlr
U2^AIgS&(AFYk2KfQ6%:53Y!A#T$__%!jC96%Q015hNQo6`5;FK/mN9d!_`99]AaY*idLlN\m
*^,%i!.O"WY*l&%pd0JXU^(!dDVkZLe:lkoi^Ie%prgk"2cbVSrn-Op\sB":"MR&\E,-`++L
4NcDOF60/fuEP?,HlWWh)hYF[2K0CAnf_YIqlTY=?rr<~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="60" width="450" height="580"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="jx"/>
<Widget widgetName="report1_c_c_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="577"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="absolute0"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0"/>
<AppRelayout appRelayout="true"/>
<Size width="375" height="577"/>
<ResolutionScalingAttr percent="1.2"/>
<tabFitAttr index="0" tabNameIndex="0"/>
</Widget>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="故障千次率"/>
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
<WidgetName name="absolute1"/>
<WidgetID widgetID="4bc5f87a-f6ee-4389-8ca8-cecd3fa6309b"/>
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
<InnerWidget class="com.fr.form.ui.RadioGroup">
<WidgetName name="jx2"/>
<WidgetID widgetID="bf4b6fc2-d4cf-448f-9e94-b7d2e4c6d847"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="radioGroup0" frozen="false"/>
<PrivilegeControl/>
<MobileStyle class="com.fr.form.ui.mobile.DefaultMobileStyle" isCustom="true" borderType="0" borderRadius="6.0" iconColor="-14701083">
<Background name="ColorBackground"/>
<FRFont name="SimSun" style="0" size="96" foreground="-15386770"/>
</MobileStyle>
</WidgetAttr>
<fontSize>
<![CDATA[10]]></fontSize>
<Dictionary class="com.fr.data.impl.CustomDictionary">
<CustomDictAttr>
<Dict key="机群" value="机群"/>
<Dict key="B737" value="B737"/>
<Dict key="B747" value="B747"/>
<Dict key="B757" value="B757"/>
<Dict key="B767" value="B767"/>
</CustomDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[机群]]></O>
</widgetValue>
<BGAttr columnsInRow="5"/>
<NotAdaptive/>
<MaxRowsMobileAttr maxShowRows="1"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="450" height="60"/>
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
<WidgetID widgetID="83ed78ec-be24-48ac-9056-12ca3874bbfa"/>
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
<![CDATA[1295400,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,144000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,144000,864000,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2304000,2304000,2304000,2304000,2304000,2304000,2304000,2304000,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[  故障数]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" cs="2" s="1">
<O>
<![CDATA[千次率(‰) ]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" cs="8" rs="15">
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
<Attr position="3" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0"/>
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
<Attr lineStyle="1" isRoundBorder="false" roundRadius="5"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
</Attr>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="0" align="9" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="条件属性1">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-10325122"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[故障数]]></O>
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
<NameJavaScriptGroup>
<NameJavaScript name="图表超链-联动单元格1">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<Parameters>
<Parameter>
<Attributes name="year1"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=CATEGORY]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="500" height="270"/>
<realateName realateValue="A18" animateType="none"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
<NameJavaScript name="图表超链-联动单元格1">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<Parameters>
<Parameter>
<Attributes name="year1"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=CATEGORY]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="500" height="270"/>
<realateName realateValue="A35" animateType="none"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
<NameJavaScript name="图表超链-联动单元格1">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<Parameters>
<Parameter>
<Attributes name="year1"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=CATEGORY]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="500" height="270"/>
<realateName realateValue="E35" animateType="none"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0"/>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="1" align="9" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
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
<Background name="ColorBackground" color="-4049615"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[2]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="条件属性2">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-3504606"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[1]]></O>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0"/>
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
<OneValueCDDefinition seriesName="无" valueName="故障数" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[故障率年度]]></Name>
</TableData>
<CategoryName value="年份"/>
</OneValueCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[故障率年度]]></Name>
</TableData>
<CategoryName value="年份"/>
<ChartSummaryColumn name="故障千次率" function="com.fr.data.util.function.NoneFunction" customName="故障千次率"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="8c72d9ae-b13f-48b7-84be-8d562e5545c6"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="none"/>
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
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="17" cs="8" rs="15">
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
<Attr position="3" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange maxValue="=roundup(max(故障率月度.select(&quot;故障数&quot;)),-2)"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴3" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="" height=""/>
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
<Attr lineStyle="1" isRoundBorder="false" roundRadius="3"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
</Attr>
<Attr class="com.fr.chart.base.AttrAlpha">
<AttrAlpha>
<Attr alpha="1.0"/>
</AttrAlpha>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="0" align="9" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
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
<ConditionAttrList>
<List index="0">
<ConditionAttr name="系列序号1配色">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-7750940"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[1]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="系列序号2配色">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-4349286"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[2]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="2">
<ConditionAttr name="系列序号3配色">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-14053162"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[3]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="3">
<ConditionAttr name="系列序号4配色">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-9539468"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[4]]></O>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange maxValue="=roundup(max(故障率月度.select(&quot;故障数&quot;)),-2)"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴3" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="" height=""/>
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
<Condition class="com.fr.data.condition.ListCondition">
<JoinCondition join="0">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[0]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[1]]></O>
</Compare>
</Condition>
</JoinCondition>
<JoinCondition join="1">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[0]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[2]]></O>
</Compare>
</Condition>
</JoinCondition>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="堆积和坐标轴2">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="1" stacked="true" percentStacked="false" stackID="堆积和坐标轴2"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition">
<JoinCondition join="0">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[0]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[3]]></O>
</Compare>
</Condition>
</JoinCondition>
<JoinCondition join="1">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[0]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[4]]></O>
</Compare>
</Condition>
</JoinCondition>
</Condition>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="1" align="9" isCustom="false"/>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
<AttrTooltipValueFormat>
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
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
<Background name="ColorBackground" color="-4049615"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[2]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="条件属性2">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-2644903"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[1]]></O>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange maxValue="=roundup(max(故障率月度.select(&quot;故障数&quot;)),-2)"/>
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
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴3" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="" height=""/>
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
<Attr xAxisIndex="0" yAxisIndex="2" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
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
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="true"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[故障率月度]]></Name>
</TableData>
<CategoryName value="年月"/>
<ChartSummaryColumn name="机组报告故障数" function="com.fr.data.util.function.NoneFunction" customName="机组报告故障数"/>
<ChartSummaryColumn name="地面报告故障数" function="com.fr.data.util.function.NoneFunction" customName="地面报告故障数"/>
<ChartSummaryColumn name="机组报告故障数(3个月)" function="com.fr.data.util.function.NoneFunction" customName="机组报告故障数(3个月)"/>
<ChartSummaryColumn name="地面报告故障数(3个月)" function="com.fr.data.util.function.NoneFunction" customName="地面报告故障数(3个月)"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="true"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[故障率月度]]></Name>
</TableData>
<CategoryName value="年月"/>
<ChartSummaryColumn name="故障千次率" function="com.fr.data.util.function.NoneFunction" customName="故障千次率"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="c71f95f5-f41c-458c-856b-f97213a934f4"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="none"/>
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
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="33" cs="8" s="2">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="  分章节号故障数"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="34" cs="4" rs="14">
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${SERIES}${VALUE}"/>
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
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.#%]]></Format>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
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
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
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
<gaugeValueLabel class="com.fr.plugin.chart.base.AttrLabelDetail">
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="0" align="9" isCustom="true"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="80" foreground="-13421773"/>
</Attr>
</TextAttr>
<PieCategoryLabelContent>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="80" foreground="-13421773"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="&lt;p&gt;&lt;font face=&quot;Microsoft YaHei, PingFangSC-Regular&quot; style=&quot;font-size: 13px;&quot;&gt;&lt;b style=&quot;color: rgb(25, 68, 142);&quot;&gt;ATA2&lt;/b&gt;&lt;/font&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${CATEGORY}"/>
<params>
<![CDATA[{}]]></params>
</AttrTooltipRichText>
</richText>
<richTextSummaryValue class="com.fr.plugin.chart.base.format.AttrTooltipSummaryValueFormat">
<AttrTooltipSummaryValueFormat>
<Attr enable="false"/>
</AttrTooltipSummaryValueFormat>
</richTextSummaryValue>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<TableFieldCollection/>
<Attr isCommon="false" isCustom="true" isRichText="true" richTextAlign="center"/>
<summaryValue class="com.fr.plugin.chart.base.format.AttrTooltipSummaryValueFormat">
<AttrTooltipSummaryValueFormat>
<Attr enable="false"/>
</AttrTooltipSummaryValueFormat>
</summaryValue>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</PieCategoryLabelContent>
</gaugeValueLabel>
</AttrLabel>
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
<Background name="ColorBackground" color="-14053162"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;font style=&quot;font-size: 16px;&quot; face=&quot;Microsoft YaHei, PingFangSC-Regular&quot;&gt;&lt;b&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/b&gt;&lt;/font&gt;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;i&gt;&lt;font style=&quot;font-size: 12px;&quot;&gt;&lt;img  alt=&quot;值&quot; data-id=&quot;${VALUE}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:16px;height: 16px; max-width:16px;max-height: 16px; min-width:16px;min-height: 16px&quot; name=&quot;%E5%80%BC&quot; /&gt;&lt;/font&gt;&lt;/i&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[1]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="条件属性2">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-12673829"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;b&gt;&lt;font style=&quot;font-size: 16px;&quot;&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/font&gt;&lt;/b&gt;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;i&gt;&lt;img  alt=&quot;值&quot; data-id=&quot;${VALUE}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:16px;height: 16px; max-width:16px;max-height: 16px; min-width:16px;min-height: 16px&quot; name=&quot;%E5%80%BC&quot; /&gt;&lt;/i&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[2]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="2">
<ConditionAttr name="条件属性3">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-11294753"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;b&gt;&lt;font style=&quot;font-size: 16px;&quot;&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/font&gt;&lt;/b&gt;&lt;br&gt;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;i&gt;&lt;img  alt=&quot;值&quot; data-id=&quot;${VALUE}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:16px;height: 16px; max-width:16px;max-height: 16px; min-width:16px;min-height: 16px&quot; name=&quot;%E5%80%BC&quot; /&gt;&lt;/i&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[3]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="3">
<ConditionAttr name="条件属性4">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-9915676"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;font style=&quot;font-size: 16px;&quot;&gt;&lt;b style=&quot;&quot;&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/b&gt;&lt;/font&gt;&lt;br&gt;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;i&gt;&lt;img  alt=&quot;值&quot; data-id=&quot;${VALUE}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:16px;height: 16px; max-width:16px;max-height: 16px; min-width:16px;min-height: 16px&quot; name=&quot;%E5%80%BC&quot; /&gt;&lt;/i&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[4]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="4">
<ConditionAttr name="条件属性5">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-8536600"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;b&gt;&lt;font style=&quot;font-size: 16px;&quot;&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/font&gt;&lt;/b&gt;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;i&gt;&lt;img  alt=&quot;值&quot; data-id=&quot;${VALUE}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:16px;height: 16px; max-width:16px;max-height: 16px; min-width:16px;min-height: 16px&quot; name=&quot;%E5%80%BC&quot; /&gt;&lt;/i&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[5]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="5">
<ConditionAttr name="条件属性6">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-7157524"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;b&gt;&lt;font style=&quot;font-size: 16px;&quot;&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/font&gt;&lt;/b&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[6]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="6">
<ConditionAttr name="条件属性7">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-5712912"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;b&gt;&lt;font style=&quot;font-size: 16px;&quot;&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/font&gt;&lt;/b&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[7]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="7">
<ConditionAttr name="条件属性8">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-4333836"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;b&gt;&lt;font style=&quot;font-size: 16px;&quot;&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/font&gt;&lt;/b&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[8]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="8">
<ConditionAttr name="条件属性9">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-2889224"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;b&gt;&lt;font style=&quot;font-size: 16px;&quot;&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/font&gt;&lt;/b&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[9]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="9">
<ConditionAttr name="条件属性10">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-1444613"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;b&gt;&lt;font style=&quot;font-size: 16px;&quot;&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/font&gt;&lt;/b&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[10]]></O>
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
<Attr position="4" visible="false" predefinedStyle="false"/>
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
</DataSheet>
<NameJavaScriptGroup>
<NameJavaScript name="图表超链-联动单元格1">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<Parameters>
<Parameter>
<Attributes name="type"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=SERIES]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="500" height="270"/>
<realateName realateValue="E35" animateType="none"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName="现代"/>
<isCustomFillStyle isCustomFillStyle="false"/>
<PredefinedStyle predefinedStyle="false"/>
<ColorList>
<OColor colvalue="-11542529"/>
<OColor colvalue="-12410633"/>
<OColor colvalue="-10850561"/>
<OColor colvalue="-14229339"/>
<OColor colvalue="-16731430"/>
<OColor colvalue="-14126637"/>
<OColor colvalue="-12472"/>
<OColor colvalue="-23741"/>
<OColor colvalue="-7736126"/>
<OColor colvalue="-8858260"/>
<OColor colvalue="-13068454"/>
<OColor colvalue="-7636742"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<GradientStyle>
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<PieAttr4VanChart roseType="normal" startAngle="0.0" endAngle="360.0" innerRadius="25.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
<ChartDefinition>
<OneValueCDDefinition seriesName="二位章节号" valueName="故障数" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[二位章节号]]></Name>
</TableData>
<CategoryName value="无"/>
</OneValueCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="d86426b9-ea32-4be5-b4a5-c7080be10aa4"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="none"/>
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
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="34" cs="4" rs="14">
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
<Attr content="&lt;p style=&quot;text-align: left;&quot;&gt;&lt;img data-id=&quot;${SERIES}&quot;/&gt;&lt;br&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${SERIES}${VALUE}"/>
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
<Attr enable="true"/>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#.#%]]></Format>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
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
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
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
<gaugeValueLabel class="com.fr.plugin.chart.base.AttrLabelDetail">
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="0" align="9" isCustom="true"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="80" foreground="-13421773"/>
</Attr>
</TextAttr>
<PieCategoryLabelContent>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="80" foreground="-13421773"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="&lt;p&gt;&lt;font face=&quot;Microsoft YaHei, PingFangSC-Regular&quot; style=&quot;font-size: 13px;&quot;&gt;&lt;b style=&quot;color: rgb(39, 74, 120);&quot;&gt;ATA4&lt;/b&gt;&lt;/font&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${CATEGORY}"/>
<params>
<![CDATA[{}]]></params>
</AttrTooltipRichText>
</richText>
<richTextSummaryValue class="com.fr.plugin.chart.base.format.AttrTooltipSummaryValueFormat">
<AttrTooltipSummaryValueFormat>
<Attr enable="false"/>
</AttrTooltipSummaryValueFormat>
</richTextSummaryValue>
<richTextCategory class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="true"/>
</AttrToolTipCategoryFormat>
</richTextCategory>
<TableFieldCollection/>
<Attr isCommon="false" isCustom="true" isRichText="true" richTextAlign="center"/>
<summaryValue class="com.fr.plugin.chart.base.format.AttrTooltipSummaryValueFormat">
<AttrTooltipSummaryValueFormat>
<Attr enable="false"/>
</AttrTooltipSummaryValueFormat>
</summaryValue>
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
<AttrToolTipCategoryFormat>
<Attr enable="false"/>
</AttrToolTipCategoryFormat>
</category>
<HtmlLabel customText="" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</PieCategoryLabelContent>
</gaugeValueLabel>
</AttrLabel>
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
<Background name="ColorBackground" color="-14053162"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;b&gt;&lt;font style=&quot;font-size: 14px;&quot;&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/font&gt;&lt;/b&gt;&lt;br&gt;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;i&gt;&lt;img  alt=&quot;值&quot; data-id=&quot;${VALUE}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:16px;height: 16px; max-width:16px;max-height: 16px; min-width:16px;min-height: 16px&quot; name=&quot;%E5%80%BC&quot; /&gt;&lt;/i&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[1]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="条件属性2">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-12673829"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;b&gt;&lt;font style=&quot;font-size: 14px;&quot;&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/font&gt;&lt;/b&gt;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;i&gt;&lt;img  alt=&quot;值&quot; data-id=&quot;${VALUE}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:16px;height: 16px; max-width:16px;max-height: 16px; min-width:16px;min-height: 16px&quot; name=&quot;%E5%80%BC&quot; /&gt;&lt;/i&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[2]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="2">
<ConditionAttr name="条件属性3">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-11294753"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;b&gt;&lt;font style=&quot;font-size: 14px;&quot;&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/font&gt;&lt;/b&gt;&lt;br&gt;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;i&gt;&lt;img  alt=&quot;值&quot; data-id=&quot;${VALUE}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:16px;height: 16px; max-width:16px;max-height: 16px; min-width:16px;min-height: 16px&quot; name=&quot;%E5%80%BC&quot; /&gt;&lt;/i&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[3]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="3">
<ConditionAttr name="条件属性4">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-9915676"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;font style=&quot;font-size: 14px;&quot;&gt;&lt;b style=&quot;&quot;&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/b&gt;&lt;/font&gt;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;i&gt;&lt;img  alt=&quot;值&quot; data-id=&quot;${VALUE}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:16px;height: 16px; max-width:16px;max-height: 16px; min-width:16px;min-height: 16px&quot; name=&quot;%E5%80%BC&quot; /&gt;&lt;/i&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[4]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="4">
<ConditionAttr name="条件属性5">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-8536600"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;font style=&quot;font-size: 14px;&quot;&gt;&lt;b style=&quot;&quot;&gt;&lt;img  alt=&quot;系列名&quot; data-id=&quot;${SERIES}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:40px;height: 16px; max-width:40px;max-height: 16px; min-width:40px;min-height: 16px&quot; name=&quot;%E7%B3%BB%E5%88%97%E5%90%8D&quot; /&gt;&lt;/b&gt;&lt;/font&gt;&lt;br&gt;&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align:center;&quot;&gt;&lt;span style=&quot;color: rgb(39, 74, 120);&quot;&gt;&lt;i&gt;&lt;img  alt=&quot;值&quot; data-id=&quot;${VALUE}&quot; class=&quot;rich-editor-param&quot; style=&quot;background-color: rgba(54, 133, 242, 0.1);vertical-align: middle; margin: 0 1px; width:16px;height: 16px; max-width:16px;max-height: 16px; min-width:16px;min-height: 16px&quot; name=&quot;%E5%80%BC&quot; /&gt;&lt;/i&gt;&lt;/span&gt;&lt;br&gt;&lt;/p&gt;" isAuto="false" initParamsContent="${VALUE}"/>
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
<Attr isCommon="false" isCustom="false" isRichText="true" richTextAlign="center"/>
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
</labelDetail>
</AttrLabel>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[5]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="5">
<ConditionAttr name="条件属性6">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-7157524"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
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
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
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
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[6]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="6">
<ConditionAttr name="条件属性7">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-5712912"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
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
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
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
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[7]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="7">
<ConditionAttr name="条件属性8">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-4333836"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
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
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
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
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[8]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="8">
<ConditionAttr name="条件属性9">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-2889224"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
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
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
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
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[9]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="9">
<ConditionAttr name="条件属性10">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-1444613"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
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
<Attr content="&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img data-id=&quot;${VALUE}&quot;/&gt;&lt;br&gt;&lt;/p&gt;" isAuto="true" initParamsContent="${VALUE}"/>
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
<Attr isCommon="true" isCustom="false" isRichText="false" richTextAlign="center"/>
<value class="com.fr.plugin.chart.base.format.AttrTooltipValueFormat">
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
<category class="com.fr.plugin.chart.base.format.AttrTooltipCategoryFormat">
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
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[2]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_INDEX]]></CNAME>
<Compare op="0">
<O>
<![CDATA[10]]></O>
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
<Attr position="4" visible="false" predefinedStyle="false"/>
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
</DataSheet>
<NameJavaScriptGroup>
<NameJavaScript name="图表超链-联动单元格1">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<Parameters>
<Parameter>
<Attributes name="type"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=SERIES]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="500" height="270"/>
<realateName realateValue="E18" animateType="none"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<DataProcessor class="com.fr.base.chart.chartdata.model.NormalDataModel"/>
<newPlotFillStyle>
<AttrFillStyle>
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName="现代"/>
<isCustomFillStyle isCustomFillStyle="false"/>
<PredefinedStyle predefinedStyle="false"/>
<ColorList>
<OColor colvalue="-11542529"/>
<OColor colvalue="-12410633"/>
<OColor colvalue="-10850561"/>
<OColor colvalue="-14229339"/>
<OColor colvalue="-16731430"/>
<OColor colvalue="-14126637"/>
<OColor colvalue="-12472"/>
<OColor colvalue="-23741"/>
<OColor colvalue="-7736126"/>
<OColor colvalue="-8858260"/>
<OColor colvalue="-13068454"/>
<OColor colvalue="-7636742"/>
</ColorList>
</AttrFillStyle>
</newPlotFillStyle>
<VanChartPlotAttr isAxisRotation="false" categoryNum="1"/>
<GradientStyle>
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<PieAttr4VanChart roseType="normal" startAngle="0.0" endAngle="360.0" innerRadius="25.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
<ChartDefinition>
<OneValueCDDefinition seriesName="四位章节号" valueName="故障数" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[四位章节号]]></Name>
</TableData>
<CategoryName value="无"/>
</OneValueCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="a5503cdc-3f8a-4f8b-93bc-3c6560307465"/>
<tools hidden="true" sort="false" export="false" fullScreen="false"/>
<VanChartZoom>
<zoomAttr zoomVisible="false" zoomGesture="true" zoomResize="true" zoomType="none"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="1" size="80" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m(?t5dqQ9Tb1Hl_;32t67Ss10+G(0#3MN1pMtA43:o#@Y0GG6H8dS+.Jl5&%+ItoP&0V_g"[
XVlhEiTS:sL^ToBuA/RkXa>59J1;F303YV,(<2h<Vf,HChdrdSMsHI#=>KM<X6k>;pYkR.c0
"R.d+6F9)*\a_F?Hdr2>?gGf,]Ao1GP@o8YYMJ%b6a2=;r,e$@O;-c:jl'pjkk\a%et(AI6AW
l*]A5'Z#!scDC#'P_E3f)=HtTid1=qmtZ?N3dp2rqdZemhu@s!13@iZ9rd%5efQdH%M9phgA@
$b'M^^"hd*D1l^8XVDp>!O,VCRV);KX)KrM#<m,qX<PYZ;tDERPf$LT8p?+Wq=2=)0h=An6t
3dT,A'0b1!g^V`*M4^iOHEO>gC<^o]Aoi9XoIeYnhqR!gc8`$Q166=I3G?bk"c5Ru1-R@VY)$
l!l9@Rg-^/,onKsiWas7q4K-&=QB#%m7>1`@G\:!j9`]Au#VYs5sML5EKetf.7UoM22a;(Dej
NK!Z[^O:9W6__/;&JqP`pRRbDX^uF_*qhnInR8oXE`@o,Pg]A363k'dBjE`&*XCGR-M6O9'9*
6YV9Y[:@-&S^_%GoKlgX3UD3mLZK&Acd*[ht^N;EhY_o]Ako;BD"a4Tk+D7?Du%u,B8q_[f!d
?BLe\e+/gM^.%QMKB'&3u_=#B$+6M*^?V[1bZbduW5I@LY^d'`XMXD<.5f+gc&O=cS&6HP44
^-Cs!0_^?f'VaRJqg?-9nLHV\=P!t:fg<_9h(dJ>aK`63m?Y-M?9;#q'j0^$TYe>d7!WN%:3
F(TR#tsEVXU/6Or"IQ#[_%gm^UOMnae?X^L1?rK';5"%#Q"c^18]A?.COM=l/<E^N'!4<_;;Z
Vql'f9hnH]A+p$Og$LMm1)p2?Wdbki\*98fG$`8q_S"S_dMiYTE.((3Ie&>)6%"jHl^5%a`R7
>V0^le6dE!6)kBb(#BgYN`1@35UTn30X`6=*]AE-4&.NjmmkR:>OD6\@rQ:Lb;%%6W>9so31h
G:]AG_Y'k49l1=)aEBDp,<]AIEefDF$rSccN!ji>3]A:-kY6)67*=3I.6/!MEU><Q*7dFpE:+kp
.$J06&*%r_'+L/L]A&>ktlm&5M19`GS$Cn2LVb^f4TT9@7n`Q:%[tXSmaD8Aj_t'7k`Ra_t`b
H,]Al^3rYhDPlO.W/d/<q4)jX<Lk>McV@uTT4pp"@4&=;IfKX/mo.V[;]A0<F7DJsno*jl3G);
FZ8FEWYh%aUaW;9Y3P)Cp4=AW/>.T*WH0FgdV>"G%PIE6e=6R[k8JPj_m\\?lIiC-rrV>?jO
gNan&`Egcf9d<[XFJE5/M[[;Ib!!Y_YTLol:H(3nk)A;%,aP\Sc+DS`SfQ)V<aJgjulG^RrZ
^r)4NIe=aulT^>uP@NDr<SBhS!$1R]AZH"!qD?%0G#PI&l4p,J7YD_o%$'2FH*527rg8J#Fhj
5>GR\HCgWg_e2hG!,Q0($9rK+Rq@TM^@Eo`9(+idUJ$pWi.*o<pQKk=Os+mnQ5iP'c,U8dn1
Dkr_qGpPn0S*=J;aOC<4C;M_r1QM6,ejr57(^_'*&2;`8EfC>UY%8e9Iln"[:jNV*"c4^rSX
LHuqciOr]AnrTuOCeYf!Ht9d(7.SE=.=/\.ItHQCa@n[P5)6!Xm&r_!3Im7cY$S\8h'Ik)t_.
S&jg?9^',1tcm*;_&:/>+eJlM!]Aj5%iPLhimo=C.0Ac)R%nk#("h&sqkH5XXQ,-Mq:u;[N\T
F*2;4.N7jF&.hBo!ti4Q#:T0W5gnVuKaJfrlF$RHWto`"'W7abjR8BI/5jFK6A+cg^-@hcN;
D.:m'"<G=-`%b!mAE#6JqH1/Yg_IIH<9)[3A)$A6*(>%XEW=VReBK""(!:@Fh\f?"`8Q<Q[t
usu^6=U\"Ut-4>X#cpV8W-.q\_tuTMqqjeEBfsg;BJf60oZ.j[O]A2.fKA13*a:?+ASCk)Xs`
_)7S.F,EUK-KmT;V$c<9cjR2]AsNZV;Z8G#Q@Z'udDB9>e/@=3.=*IYCgeb25iE)hf/.rdJI\
IY[!01gHg4\*G:o;]A('V%s\C@gScM1@=%&eELP`:1eF?cKHp>s)!sfbH2^Y.HMMrREVhP=oF
#7a%OZfOVQ^Y(hKQ??Mb15@[_V/)#l3-n%=Mr>0h$!4lFqUrM%FcOP=]A$h$.e8,4^Mn5T."R
rt$&,?_V'C@q!*RPS71L!;eYH?_6H$N*ie=0YGnb\PKA!BUC8CC*"a'?JP+R2#=!;9-Xldhg
V;JX7?MD7-g7g7Q]Ak*9@:bl%]A&\?,J/N#W)W8)rp=u_5%CG2;Pe!\0'.LDidr:QQGu7X_V-5
D`'n>3)eW]A/.]AWA&f/J'Tp=gQmTVaUFoSUD2]A1%q-AUZs+b&-`F<>=QFI]AHK?Y_8m(dMjp%:
rM@bOCQdaEc0WS3X&/Tm3Fj!?7eHe(KUZ:J)siu<Y^f_r'gj;OaK<u!D:HbV,IpI0=M/VG>$
bI?^?VCZP'[ubm:@$gYa`Vb)qh0NMMBR^OkE_T@.>$;HJ8r[BV3oRTEK(GFcf4IFJaR$p`Xn
mctL;_?AFBKdA_MH)TI*Y,ee2a1)2!L&kAkJM(q=91=[3E"$lEmr<V4d\XKpo'+oig?o^Ecl
2MsRPWi*&"lCd8fmfTUpL6_?%R%?`kN#IY8C0J$[Kb[I3&]AhdT59.U(GG(NOeTQ_#jWoY*)%
`F-p(roBJ+uN2*nmZb*[(a./-"c\XZVYU\0J>;#<CPo0MWCd!NT@Ggn>\(g'#dj&0$jJhgsl
1JK-mC6NNr[VXp@rMTCXbJ%X2%I%gh6gUb+(%Sp*1b"@h<-B(Bna6jmj@bic(cKj[I[`qC+'
dGGb!_T0eAEoCW8S$TokXqaM,b%08umSpm8KN7/8=_k^=eWp4MWbcWl93;uCtf,eDUc$[3Wq
$Po&hH26>\g70&\c6[tg7RS>_@_+%K[1@mh4WGa7s$=@_<tj\B4p?=g7DSpWeKlu]AR;7,tY_
)KG5Z`9)<K,i"AJt+m#\JI8"lEY26>-C:H>jggXB6Z[5;%otbB]ABn3BB[u#\5N0>.QBd\4U)
kQb3/'8AF&:?>Q^M]A"L]An%t;-2[j';DcH'tL.#a,GNug!B1ICuYn;3%'DOD)n`PgJ^is]A2tH
l$h=-8np.'JPohE+uthn8^_4NO@`c+t,^D2*!0.=.o&L@K+:-j!^kR/'^\(hu3<"POl;S:W2
>CVCWc.\-Y6VKQ%pKAg"AgG2)LeTO,j$pF<QYAs4O@R,G\`UrOk*&KF044f")1//2oRHs\5u
O"_0lQCPs8P$qumhLK=\3.lU@=#r"dN/:$q*BUBO4kf':FM?\$?S9j1k4UEh.jLhS?C_Rk5X
LF/QcAV':Jrf>mLuo0f"KUHF&;tmk2uc9(qY5>k)/-JdJr?sC?0Rh3n(qn;ePnB*gR$tiDH`
&fq(/llml=,"iG$;?9pR+?_FE&rHf_n1ki#<.a64n3f'E>S##ZUVpPIu'`.h5K5'#1aD:O.p
\mB;,^[dmfpHMNmJhJWa+VoN41UaK4i<6Xa*0\&8$9,1.GFOj,INk)YRqpCojnHu#2hYH1=,
sZPK$.8GL`/ZONTKHDbR4KJG=8Qf#Cl]A6HsE96tLG6I0;jN1"fa9UV@W+VX/-G6VL0Ja&PC.
W(M-/VCjWscV.#nE!=IVGBXbH^o:fDNq67a\S`07WH,*"PNbG,fsAB,0ms\-&1jXN@b-1H:4
8n*=3nTg8"UES4N/GpGsK\sFWhnH#t<P#Lgl9nWug4fN,+g)A=@8>O^^c1$uI(?,dj)H=2;I
mej"Y6f?NU6.gnqXaR9J=BC3&h%MQ.AdH+-ZX&9>*lQg/%1g@8Bf'7QZ?q.58CN]A(;H@Ddq'
3!l%"aP5uV"J"_MJg3iGKj+)GVfL4=MV#W-:KDFUA1/5gss;QB!##_&$Q@kY367"g$+#"I@d
91.D=U[#t[m*gQjEnXkjJ3TBgj.d7FX(IbU&`ZZ_PHH#5&jQrQIKh?i!MG$+5E$2)Hbpr9(s
/%is4_ufh?WhW6]A7X&'Nk,G[?Z7jnu>QWlWh1e[VH)ABMf#eG!M2atM5ua/uX$-<(^8"O^'s
Wh!32ggcEZ*=`N]A\hnG%tZ\,==Pe@Xs&R.sJ?j9f4.1Uf1;QH`;3ZIIUoqMnXP*IM=ZB./^t
"FiFu@NF(+rDj]A5n$X-8r;I0rB3*c='P6hRB7i624+5M&JLYB/.-N1e$_4YbCTlFg\>lo!2C
K1qXOSXhW#5&i\VDj=t-gi?"'TncM4s?Im1+F4DX76hGIDVpZoG\ImCu*p<91-_a.-T=\O7a
`=WdC-40V_[hrY<(N(U>SpJU*5@!hjIc#!8-.5+LeGrqT>dWW+VpG)^=Js8O^9XhZ&OrLHUR
Is(c6__i8mTV/Ln6d:H@@Y^?m\S4DPA:N7bD.M,TEQ=Ig9truAA$G"OC;fVb#=&\%Y#pDGI,
<\ea-i=WbY@j#lrVo&4\SQJ_&r[/\R)4SC@?&[[-F\,?enOZ!9SOe5Y_u*KRk_qZ8-r<q*S0
oFG7QirI\I91?0_tUD(M-4]A'u;cCAl0Ph3,lht]AnDk#VSXQX\0MF(bJ[@eq:B+"OmC*Kd!b?
L8-of+gC_PA:MlEpBo-n68+[2q<B]A;-**KIBLY8N7[aWm?mYm5<%EP[nKIKV&@,OOLaQCH'W
c[LlV_.HaYEg2J%l9)gK;Prr<,DdEo1IkMf$-#-NJ_pN:c>rVMtM?d)]A/K^8:n*m)rj&kMCI
noqlh*o3NTj@[<QjK,;d]Aoc9jH*k4iLp*QG?U=2J[T-=OD&_qtc.-6@e62=o%o1tmLtA-0of
iIS'*pb;/,mH?f)=>eD]AgT+X+id=%Dmtd`ZJT#k?AhBN#4@Bs'Y&e1%U/M7+e,7X8PjL8QcS
HiTaoH?Sa3*]A0LD"c$_'VX;Cj]ApsDP<$cQWEZMH(L!_8;,7U1IY=[6X2MG!7fk[Sr3Pc$G,*
Qgd<+(Ts_9[u+FI.+:@\Ek;PQV`c1k0>%ja\X:ZTqXkhIU(TL:tHcAk-9OSG<Lnl0(p"DA&h
jMK48")/abq<Xt]AgqhcjB'D;_CmHP8G\hbI+()*]ARk0WtJ5f,2h;SM;\s8l#/Kk4Mp7=`)$h
R[Z]A,^gp%^ah4M6<)&WgMGO*8%I!')jPPrn0To2?K#56Z0i#Y*bUSlpK.2>W98^.lMKA;J`k
-O4BULJb-F8WlM==>Zhu=%&4pIMZ:ss2Uq-&kCO8P!<&Z-2,?J+Sh?1g-bV8NG5$mK62]A#_U
/,Eau+b;bR`'FIBV"TZS47h?$]A>3!5?/B3NBri;M9jVI58m+?.1.>CZ<9qtgGh#.g#C34/F'
m:6O`jZ-NL`^B5R;m8<Iea##2<EKN#%84l9hqeV_H1s,=Ok(5>t_;PeV6.E*/_@rna5;M<[.
e@SrP3''.ti`7-]AiuWgqsuKNi.SnJI`i\cR($fqB.H?!O@M-B5R$s#hEG'n[A*SCKlAJK'+\
TD0Bf@dj`6]AjV<+2hUB95?nbm/p:?repZhZ<&PcHW(NO`Q=j26cV-Zo%6O.1+:B%IaMd^L9J
0t1;+%?NcQ]A,NW0\iZ9tFlEb;&hU#ON0/0)@O?lDZHl:(6TpaL/jIU]AMb*D&L1"0Sg"mj$n8
-DZ8+DFAkfKJ]AO%KoMECF[T`ICn\TqDYmeYOMW+6B>]A.?f(r3'S1]ACgU`<iEI0dO;G0hQ'L=
G#F6K<!HK[uhEkgQM/\KKP4hl4FcbEoRlUQEKM<DO+nA)7%YhouqWX=,_G[9Z'Zt:dZ*USh%
[UUg#@GUM2<6RXQJkena^`Jd96<b54+%F@Cn3I/aQ5W4jN^)jjL3B&BB%\X]A:pCX`?X6P87j
ia>9Vn&CN0;r4T_e`u;lp1mk9pJEX\$duo)Hnpb+Q'2mKiZ_u*oYKV@]AQs3g.g>Rq-E%t[dM
*BZ78dQZlnah/M)^h5>9/_P@)ZVgAs*@bWLq/Y]A9]AEqWT?Q%YtdcBlJmDWRrJW*KQnJ\L2([
U'Pl,._G4</j&@K1]A!&;1mOj!Nj".MKcLe*IA:e3Sr1HG'iTohS\$XlRW))e0js>iC=Zi?BI
f8%cJcoP?`AXDXK_f/OEVKY'A>k?9`Z=n4</+!C-]AL-!4o6BU^0+C[RTb]A5T`jd4:-?RUO/Y
>n,g8ufr!$[<9hSk.!%]A!c))#[:N?TpkIm#eo@]AJcj42l8Zd`X7p=Ju+474RZ,)7>_]Ac0-nj
4TEktM]Ai>QL>Z09!ahG]A9-#G7(h@@TZb8hQ?Kn]AA`9';PftBf#1_6KfV>SHfA_GIPf+!RA7i
lr(^+5VYG]A14EVH7ZD^R13b4bYVma[$X4>`;Q)5;rd3C$(;0Uq,fK-fIf`Z-2UZFO)7%9&4W
t>nIX(\BoL#:@>SF.%[hHQ1jo1E9aLnH*Ie*b<p61T"_!iL#8Z5WNjjj,!CB#6SAK+U4t-.*
"tuTA$Ib0bB<Rh92g-QqLe..[(J_\@Y%U97CL'Fj(@A73^.H5W#sPaN#-p)->m%KIdn3d5(s
N0.2nk,]AulEJ1_\2_cXg-sn&p7h`)1&H@T,-6^*PD0-9O9]AgI0A2BCoRJBs^<VC:9j[g(l;Q
?=MAb@<K)-FT%Jqgl48U^Ze99D1-EZ<(NSs=KsjEN@[95OT)b9Zu^46PI^*JqA6oP]A2"Z9I<
RJML"/`'MQjjoe/*rj/\27ZkRTc=3MSK]AHr#dNa\^8HknK%6YD$!0%ig_?V\ue6c4d.M2`1e
Z`8I]Ai(#Y('_*Z\oX5[lr>FVSFli@()p/Y&BNC/aggSq]A+5?GLmbqDodpKAqn,s=>)I#uY;h
gX="ePpF./i,]A+'iCJplM`bi%84Q@,k06($R"+Q7GJ[?;s;*`e#X%Td;eP:3?tjG5$;&:0ZX
F,`T_T8d3h<[bLX<A3EsJ.bAG]A>%e@6qk8EhMTSlcVH`id1,!Hskb#>J[5n1KoDN`$LiN7#G
SApb*b_mqZ3V6l-Y:e`r4VQfV%WKYG&GL*N*e2<A%;p"[S-ub9lFP.hjZ=[$XmOdQH]A-\Xfj
5+\qbqoe%q&86<#Ga8.m$5ZDf(o3M/[fs>^7:"]A!pP@gpX3<dTq94j%NbRgdgl8V[BQo9/Be
fc7?@^N7D#?hsY55(gRb<WN(g\X)@7*qMb_rGNcGo(F'n(Y@J&PA'QD1?9ZGL&`=k_OFdG%]A
kdX>c]A]A4;$C>MrehLb0]AEAkEZ"g]AuGS6eIm?:K%MVFDrGs:p%!nQ7N?poD=Yp=iLFgRQ:Z?N
XB^e8N;)"c6d8<C+d$6#$Sri.j_ICB3C[PO9iB)oT;'u'5&0P??4N@%3jTe@Aq=*jf,J?WCi
*YC.Hft'#E=6P1LhpO#_T.ASAS:o-M7cA-m[KgkT1+&430,\[u(WA&Zp8NKk0g`]AMn2Hg]A)e
3rbcf9.a@GkfU!+r.,I.q)6!'0<I$$+gb3<$fYj.p`X(LnTdQIcb\;-0f++Mnh4EDO?1diDm
^=uPO.7:i>s#N(B>YD$gb\*E#:7ZT:)4CsId+0lI,VB7nC5^p2QFn#^FKXWo+X<tMLYC)@;>
$98_;Y13gd>dG6PcP[\VV\i\(d_&2`ckUkW6kI2rlQWZ,!P/pni)02ofF/%LUr(F"8rZ2hb$
&PF5f4d<0(A04\SB:_:?Zto%+b>PMq8k(T/gWPJ"B%amU&m2,sg'[%K_PZct)iJVtL3n:'(_
Z(OVD2MqC(KCMPLHZLrsW,0[K8In<IcA0-I0Ra_cr[l#^VBTno^3B@\,!$sl^HAKqZ1S#lIe
&;'7;6KYmC;P4=p]AT3dj=\t4'HDY.B&6>aKo,!EPm9i$QdM[o1%=?-2K56I^/;3LXVm6e^8=
NI^g$d&;hWn#1EB()p_Cok0b3N6/qULq7c)2;koN(ThthSbn4Tck(euij4B-0K!O=>lXKi>l
G4ZF:qmq:]Atkq*d6WhlZbDj.AJT=Xh0OH"?_?5FXe3]Au^#7kJ.r3*O+:-D,9J6cKU=7EjLD\
6%HoVRT^-2Zm4a?QsP5A3'e\d.T`gXX;nkm&(LeNYk<,S*gi]AB^:Eh1F1?V:a!p]AL1]AbKuQZ
`Hle;+V&^"VZ2F&jX[#+=8feUSW0_3S[*ZG=kVbXlWP2l@h%M,eZo/q'jC:srj[<g5o$:\K?
>!nr8l.H)6Ld5Y[\>c%[N"$@>Wl;h#)iiP)c54at0Hk!C$%/SsC)Qj'Y5:?$W.]A1NY=,7m9#
k6Dr]A-#["5%adG2\RIAmG3qEa*lBR#k/(;Xg,SXoY<0*p]A;JN,uG.b&j"3Uh?lf1!=SqOsFP
nb8iiUEk"YhnkP57B+<d9]A^B'SWj(0V6W$m.ntT:MB'[r0?Z&P-MbQo-_FP:aSD65M^r_(8!
tl-9[Zl3KeDrHm?r=(p:J3P8\o>3GHi.d6Nf65f$+2C`A?qcHK*Xe`fGqH1dYD+=0o4QT9Xi
+)`NU3;_`+bA.qm2RhK1ILkaQR;X0Ul=L)`69!#kl5aABBg+rm1S"YU#"1'eQT"','$l'Sm%
.muLM;NQi3&u)g@$r)^hkq[(hI.tb[_n8bn4"IHscZ*aAA&6H7j&"#@cNS.CQ)Pf%(O#G@Ht
GnCm/\!IGlnlP"QNZQQ!!qAS%_/R\:FAR4&UDs\3*k@I/u,<g0TiD_CsOg3joo!7qF&=9;sE
$!1_[U?U78-YUYjk`*W9SJds.+`LoZRoP4@PF$B@*ls!@;`(Od#j5Bckb3tR=>s60:Q41$=L
A(!"'oF;^cc@Nid$b@EbE4<A%RTJMZYLBO]A+qf49(o==A#6iP\Go.Q9a31MoURRS2D\h6j,W
/C]A,>!/"g*.rrA=.'L5g!(,hAG@*piN^0N[2VA`;2`iYZ[Hpb!'o<?ImCuj$Cc281J(h1k9J
adUn3fP;A98qe(U;M1]A#XEe1mK*K`7UX;YFh+Y49#-SV3e?jB)[6e9&NX.JsF]AKB:A1u6,9F
4O<cFj3H5rQZTijL)-6]AY]A)/8<;M?mdU>Xpg%ZP5i3Eiu--',c]A;@ZphrXn-'GS8EqbfrXBZ
Z7]A^qKl<TK)ZDC.F!4qq/'%<@SPcs_=UE"/h6]AGGg64n`kJ$W*sk1P:&JqWU3:"ENu'skf)$
Gbk@@f[?)"TGdY<X5$1<)R^6ffS#t.!C6]A:b8>^ioFQ7VEp'!('F$:an>^-RRnG4aN<.'C9;
,WsIg9DVbqjGRuO]AuL_k'5Dd>`mn!(]Ap3ab"5l&?]A9'-L0gC$4e_(!@d\R@]A@abioDooIDl=
@SRXk=]A0=Y"gdISHrPPOW$ts'oGie)D[]AeiAH*<Yq0UBM'0M1tMo`@V`<T:/sq",\*gJ^V<"
NNrtYNc^`::Jq-QX3>=Lm07qm%&p#=%4&$Ft%0sMu;O0?X,e*+ki<n#t%WK(KE-17)94M3tX
5A8dY-6C$&l*</H^S;0P:D$r'/j8:#e0V.*J8VMcLa`rc:jOs8%)Fr9UDY_^N%t$215I_WI^
h@Br);pZ,^ch;]A8C$]A<c6^Q/X(D6_[#'ek@<:?$f\m3%DD<c:.cgim[4PgFI9RH.?c2p0NgI
[)&#L<(_+l43%sK'`V'[j&C<pOaNY1a6k56'Np)scJ6'5gE/(ISIHcOmeQO[2V;)SAW-ESNi
FR0AnuPP@]A/@uOVIgpB"U0/4f;4Ka"TMZhfI2O/cUetDh4+d_[;N@MOYaALOriCbeQhiD)9u
$1<pm'oOQdi=/1?>`6\)+0C`Ak=M,-'5%a8ZDfK%2H/b[5gJpOpc9@:sN;1Y5*M]Ag/+,[sMm
cHq5P89ViaJO-dU6NU4UELi%",tf_P>?)hQ'AnPKbpk=2de)r?>ip5OFl?=Q+5F8(qk-h%T_
Db?F;N^_THTC0RH5'84b0^0F#d*%%<J/rj_p<346i@a!EtA_cfZ`Md1ae\=buTnk/SNFN1$;
FY2jXNBrm]A=.mDcAZdrPh`#%E#4t#QUcc$@19uaRfj9^`D@@'+SJD1\"%b"55L.u00QmVjgu
C;$/'oDg)MtO$7S<F9%GfZR22NHHf5>-R3o:R0U;=Wj:3t`YFhb^W/AQNpD?`q`b\Nr0Xfb0
]AMrO[Go&fCj"5`'_`\t=rRCS@'6aUb(=LE3</mmBb:Ug/EhmIHKE'tMU(:'6fBe<V]A$.\"u?
Z!;J/@3()OfXf:)V8#"YL[/ko:UhHS#CiN]Ac8%2b(4H01QsjR'\AAgY\*p;JCIY,R/O\]AVKp
KED_+\4+$A8okH4LVBBYR.)hgA=o!Y+cdLJ;*VUOd!&W;%*3FK?C'@tA>G.[XHZhF%;<-JT_
;/^6Aqn_U_c4,+d)*s@8WQ4C#=R&E2>8mTi.e+9qZ4fB4"^^&OE1?oH0]Abi(+-OdLEMRi;.Z
UMLk98!V-%1N-M#$@(Z@_2]AK>fGIj2uuCkOu`HEfW7q>_n?V[FNqPacj4B_!5f9X$/&sf'Ek
_'YNV5VT0RmPY'+XZ&.<S@gs>9(g%M/,@_Pt^0m'Sfp7Vk`YU+i9Q;;L0>pYc`(MKRekZeje
r?3=^NWpipj*e$.tHULVDUCr;MI.k)O6Go4pjC:p-=*?&Fp+45_W'89)K/,-TXD0G/h&Zg8j
P[?ZMR9US8eC`%Z*@^+904eh'2ihp!eGS1#9_*/cV?WMjr1O=isi0Bd375X7NXH*icDrl\"T
H7UO#^WsHOY[S?ekT2W=OorN!rfBA!(4,cN*_^>TmQ$DU8'.;,\\O4&Z;EijSZ?mIluik:7%
Y\to<dj9N\JlZ!^Qu\R>Po\0^W4$:urok4iF#b.AM1mQ&8!r#C'P(fm25"H]AaSRQsO.,(K.c
WrQQ2-Bd-VeV3ojm!`2'taS#@_l>D&?>t(pgr@I_&>&g/,'?tq*A6Rf'4_oM3MQhO*TbNXfd
E=,t.j[(fh,nq(i:@MlOO92J+I/KD8k?R=;fg['eO2hEd8rL(cn2s!0sS()Ua;CS1Nn-ArQ@
LiU^2@%2%DA7Qdas$(L>8Mpie?Q.GMPT3R<$_9R1Y=klN57l8Skqg<,[t6@5X:9\>qVm"hgV
**&=4VBDkE@2.l4oUP_MFGP(qQ+P>W2!DDD(G)KBI(CM:<jHQ5\23`X^IOMCX)ul$4lK8b(Z
agYYEF6uSuZbRXMUAQ?IbcoPPi_<4Ep;iNjiINJn,=2Y))'D(-4#5B[UQM3;QlGP2Xlr9YA3
,La/ZlPr$a-]A]A^2Nop=i\TW+F\eUN!UabkSjN1]A>nGFeU\q187i$ul#a_iUn+hT1Z/U*DUbj
@8#ONdTED3rg4g;%tOrlgr)&=A^JLd1.R=#R8AZNZ`#VB=%CX(%JEKe6r:&c7^-$aKa@<A]As
g?-RL4DnASi%Mjk11^A0mmM7;Is**n%ODZ_E&Y]A<Uf?@-o3-JPTR`]AnAEb+c)L&--+nGfF[p
DR34Y/!%VUF.Ok%1E7lJ%uS,sb)AhMA%%C80"Hef_+ssHak&!7WBK,X.&Gne^*6_YQ:F[8OU
.:D8V2R;Lg3bcVtsRKZ>n5/8,tS._W261/>'Z:aF[(-*=]A#ebUUhiP(lg;@;L]AZd*C:G!tf\
HVhK;dDBFeZ'R\-,^@2l>Be2q+P*_(!d,Ye3:R9"P^BOo/Xj%*2%%S$`gmHhLm)K8WgTJ'N&
[`b-Ju4i,>r;*)]A1:.l1/8g;[!0<0D97Z[giRW[MI3NMMUN0arU=^ORFYlWWQEFt6f\SgI"i
<$Mhr`.BBEW`H*<W3+5aVt)#OtC*!kB(6oMCq6[ZRi(Q5``Y^$^&jh3>@gY`gMWO2ijH+goh
TlAA(oPjAt`S@jk7%1F+5\TeP@"1<g,9`.O<W2Nl3,8p%e-ku^+:'*coV4d>,LPXXiKs3[8M
5p5FZMmn,=]A'`B=iPE5^T9kL2cO^qWWe\S1@Nk6C*`f)A7<'5b6uh3o2Y$?GYP'\V39NgKu/
,?Hos^C^S-%2.ot[C+@2Z6aW>goDGrnkAQKn>2#hZo_e0%&D<I-7<jQ6'iD/)AcsVO0.-oPJ
E&alQEo@bI2fbCYBDKp3)A'R+9m%[f,eZ%,/R(cOV2GK_8:"'1VarAU%f$t?stRG.@E(P.O.
bl7Unp3NNT"<^9T/9<9c04M4grcnc_;[7n45a]AoJID+9kqh<0pkPpjIB[+NU#d6kFLlQ$_u(
?jOT!ZQ5':`+l`bW/(lcb;6Zd+*S=(]Au@i+lZj1T*m:#=@n1V_-m+eYS!pM6)D-6C8*E\__G
n9Cm53lur`_DRkFiIp5k^i0HSS![08CT`XNq()j5=:`Rma]AoS7*WHpejP=Z7<.<;6KI#WcLd
"=%#:Yf$8ZTg!70h'b0Sd3MN1\H*uN_f^DkY)p7P8#$[12`:Mf!\V7@J@ZqumbSc:9YM.G<4
2M)+PKQ+_pJ%gU=6?`lUZZ+*:d^3I>D47gKAi;s9;-Q]AE8<f0;<ktFd3c3S5t4E)$gXpOj=K
=!SU-CCq5^BGqaVN1[Xh:%5cQAXY+hheaoes/$gZ-ON$8.@PZ\L\E*^nQfDZg1HTuui`"gp@
-[ek7,.JYe8/&6,%_(T4[ln&o(,jqk)_UdDdg@@hT@m^jHOfW:X4F`"GrK0bWD:,j;ct!0>n
o=TN"!pAgl_0eIeI1`%in1amMpjgBf6<eWnT"8#ObQ0X]AoCsDtVk$*/*k(c%l0"C.Xm\6r+7
qTD_eMs0*f,5FA?W)t,Vc$e_jhXA2&d?B/#jGR"5DjeSQQOu>kR'^uMk0SjkKf?QK]AZ='gt)
Bd\cjbCb;e%kmA6:QVW<S2u,juM7p$_rF8_'jcPeTl`qREJ)\FgJ(H;e;??J=G`E;PfeaS1n
W'%5V?-3kV18-e%fGZ:$+Nq4*Y;SL'l,GEj6("p:;6YY??WW08VFs&%Ji5+:i@gmgQ1-0AF(
>s>p)aF2e#PeXErKY`93BmG1NRbo<pT/!nmE"`-%h?j#&B;CE?fn.OoEl<9ud@`5'eXTkkl-
d??/\!ET<nF<;\%fibnCs%"P,iH=:cY0/3=8MdOCuP[b[RnB33Z<kJ<GUToMKF"j+YN5kEYi
2f!X=)FkR0lQZhM,^]A=q\Fo^,9rD_e?A.JQ#V'_h$Q%e&*H@rIT,6HVCP\m:k/)ST'MnpKa3
HEj,T"#af%'hQL,u^SOf'4Vsg+V^k/F,i.2(?!6mqR>no;(lKOJo3f1X<OK1OoW5`Q(;0%!9
6[7:_a3kn-/G?/GDfm:[:#)R.NClM(>@H"[LdV]A]AA5U%;lXcF&Q)qPcU7j:=Ei7EG.SaA#R`
L@)$soX]AY*K,n7s4ec\"<0<qE:Hl+r#f3ngdCN"+K1_K[/$(t/h]AlBqCJ_[l'uE+a&DWnrNi
mZ95-(@_?9[)8;Ps<32^-8kEJ5951j$COJ*b$7PMCRQ%?M-RlPhE5nJ*/-#KZYs:X&HEe)#P
#I"5A=88a/m=uB<NLNt#=3$1duGrPeF/Xal^?mo[DAE^Vt>d]ADa@nh^kGV.UZ_T6lk$]Aa"^1
_h/8<NPQ,N,:K-[#19<cs^@D$T4b,@p=YBZ-<7F7bP7neZ6"aPtgm4%.s7:L+eYhlZ/nbi!4
WXS>2Qu$O9uj`LOE()SNL#$B&]A-2R&7slH"KR[D`$q`r&p7-mXA86e4+bq-4_;c&Ce#='8KP
1\iE9ouUHZrmD]AAG7&--$_2Gmb3$(gCVtj:7DXE[]Ak!5<0@@K-c(M[@X0KD<7DJB5pa-ltD7
D+Qa<Ifm0@?UFP6ED+jOXVHA:9F!5s`%U,X!Q]A>5EhBY&.DVlhrJEV89/2fiJZG7RA^i+TF(
=p=;ZHGt+P$U/N]As^W+4'T/b_%MVb-A?ngf@&%l,6";o"]AiKA:J7Bnt`]A0Xdh>5b#lXKjOAG
o!b6;7/!r^kZDNI/YCp#?6"kRYpa-=@c,oE)^f2hUb&1gA'r\[\YMJAQQ_h"\uE6/%3aQSPY
6e"0dnFam1ickoI%;%EsX^(k^GI+;]A,BU-^F[ISh8d3G`R)l183<AMkT^9Xr+=B?Z3qg5q)&
6?*//F/SM$,4d6U6OBSlHc2hYJ2@sH4t",`%s=ld/(E#e\hT"m%cnF]A>53<XI;1_=/^!WcII
5nFZ51[.Li.^qc`C$eOArN\[<4*R_K]A<;$4a0b#["!5C3UflQOYA?&/>6QJY:t>j>*e#0%OR
L;(C=rJ%j9$F=;KT!s`!L;ua5)?Z4mJ,$X,P<NP3V2aVS4<8JEh(L_Mj"n8rOeY[moIuN=uT
@"NFG#<UI7"c=SGN"6l#9Q$+2s^IPLo'Fr.&[bD[R]A0s'*$L`(,j-\W!%.aF\ppb;0.6;en\
l!UZLm0^E,&)<r,GT_Nb*IEk;b=K6Ib7Y5>RM7Z3GlWHpWS_UR8nlWJNHQ7@Adj^-d*J>>;E
V9C?ebjC4e`&guI>O6W1[L3*(YqL.'T<9VOI0&g'e#=NK(:GOF\8]AQuKp`h)N8[#liM^'*g,
P!JX[R]AG<abfoWJ%[?m`I(j2%/ij[J=\(?=HDXT1&]A.I`Zp(?CnM?Mj4RsYpMI4W-_Hg51_S
P_+mT)9:YGGC2i(Td7@@"9UDJhH3,X20.N5Cr$#giE'nCqE"d-ml&kf,H/b*alWEMZB:l"jE
@IfQ8U7.OBAkA2GTX*(I_\b=LHY@ZXQ#Prihod<o`8k;6OHB!QdcjYOOW,VY\8Ma1mFNbFk4
;D+F?gYftnG]A?hGD2JfKOY%HWE=,mM7q`BS_0<%\&O[j1>56Z]A);AE_7*p0q<MLKH^n?EU<D
fNa9h=&I>E]ALiV@s3lU7ipea%(O)Gl;#.f/+Z)YPD;$=P5>kAn]AD?&W`"Q'iSqj5d(&NDnWG
8iob-G\D8b;@n>i66nf0JcgpQkTlc+`=0dt47XQT)us)uY%%8HGhIEolBf<QSL?camT#^1]Ap
n$6JRe<aSfMHkJ>+4uThf,g^OF3Ni77UJ!)fZ_]AK,SK&ohI4k<BV7^CmZ]A`b1RVJ$M&Y!NC`
ZGqOimuQGQ8]A^m/i6?$UcF/Cq340&bP)l=$JLSig8mu5B(Wme-L>6iluFn>FMp/RVc\E+3!j
V1QWSE\WU4Tm,Je-j53nY]A@2uWIhta]ArCS#Y%c"d?!<@/%[)!ao))/.b1:p322Emc)6grN_f
p:6)e(4j)_*+W'Q!4,a(&S+b]A@8I<EOEiD1CoJmRC)'r?qL$*9QIpVFbge:*2FHpa3tD0PoV
D'^Y)UCt\*%nTEdc*H+]A;n+SI1%r6h>dYE7A:tJ\?N3nhC/W1P2JZj+3_4>h88c6K(?<6[8g
o7<hAmeQ^9WYJ'aSPu=*HGHP=m'.YM8jYh\H)Opa[7Zr/HPQP4OR_@3-WGY5N?Em0UI#Bu4H
G7,:FDQ.ak3?s0>op!;E(r4HhkOqk,epS.0,OHi)c)`FA11)':!;ncUQ>F(WK542X:Bs$OKs
=VEAifeI/2eV,@`1<2,./BTFY293kX@-Ws2mmrfHm"fX+'&B_[$u^[E2K2f+t=#8#ANkc>l<
\2aFn"$??i&^k[7%%qbI%]A5?S]AF^^o:^XK)7uf+7s456&NQTuP5i\(ZPnhC;D2'gJU$H"gDB
""3J`Y%'@M5-4V4rfrf4@/oTg]Apd4Z+<2oIFM?AOhr6Fn-B83s7jKT?RAWa9OBVF,6*``U]Ai
:5`7`WCtgFfFnX9F8`mGX8[O7BP1CB\SK&$R3,#;lMRtcZeT(bWg=IMI,T%os`TroP$*U'2D
:JuHgK`(SoQ&P$AsHt[qoPDFT?L;ZPAKGll^k9A37kI5Y7=jC'q%(]A:SD)B/WC`eNKEk5=QS
P]A9QUf*BE5r=>]A+;jn\!9NFEQ_s1fE$Ef[p:ucn&^b91/SUSe=,2<tGC1@V(46b-Rj6UfD4n
5rfLAqALj1CB-c*9p4*EF]A#_Rl3-mTL,o.\^=Ir;A8-ItHD3YOZSLH]A?d>\R?M+gddDZk3M;
spef'mnsa3,#a7cuAuFF?hY6d_Tb0fOTBD@R6fETG*_Z_5;DS#Mht&aG"IU#'\b@:m0D(?<5
hj-fEhGO7a(o*[93aB\!??cC1>`n(OimnlH+h4neT$9Gs\9"qdo@ouRS1:3n,L$PV?TiZ'P?
j4g>(&Hmc,1KHhX`YB++V2GM=J*;,+Mb>Fa&aMUdH$u!lEer\U`8O$;N=5q7Dg\h_-ubKl?`
aT:k5n4[A;L$j8u4Po,7,[(BUjuJYmfQD&:t\kQ6N<&=CVEN(C^\LHih<(SYTm^UOQ%[V!EA
lgJ=:FOl$\,Gi>s8>Q(Do3kN]A=+>l*]AhSGN`n^EBf]ADkQ.us!T-TY_D?:!VA)8ph&n>Y6o\Y
@^6q,+K3JXeXQNs"[E0Wo9^`a%S:ZfBFuSX3YnY1Yf/!9Y%HI_TIi^%&s%\edYZL$S]A;='%E
Z<u^F1!>(*e!Oer2Z(*`2`.HmEWHS$ZcUs6hp"%[>%(cMTbSHu`rV7mZ:Q8#h<u5@CH)47<G
6PPO(3-oUq[WPLN45W--;)=QBJb^p0)'\O?sVZn>UL8a(MK]A/K'he=)LQ<YQcBFFcP%3HkZ,
$geqEmFm$9)'"u-M2N&7")n?ksC6KOHXl\9>.__]A#IT7neO"EQ(Gji)1H'ZO%hXd?'@#eBF3
6m<'KQr'-Il3n*Tj_=l0g;?Ucb*Sp<=D0?L;[5+m1mse0RTW3>"elqA"bk)Xj>EAknt`@q>+
POtDR?&+]A,Mb]A%r4:CV$IkbC?W^HFAM?PXT=\WH.s2OW20m$!/%)Vk>t_(Q,Athm'g3K!C5K
3VOmcHEZI]Am8grnnlul/i.fJZJ2LRL>T@9tMmju8WQpI<4"b"G,9+]A'nC4%eF2s+hGI'/inR
2M\johf=K6Z?K?M[A:BD!b\LVP^CKi+h,7\#4A$^CU.0R^T<fLV:`m!m.C"qA'@%<7ha?X?'
qdLA7/hfft%q9]A3jSo!"jI'qbuNj^D[Pl<9!9o##LCMM7uq6D4EJb!.13rroAX.O+)(Di"I+
]A]AtU:r<OFLmHNKMNt--A6#rgOHG*u"`,m9:2X]A\-T4C,Aj1GDg794TtGgD*+(VYa8WXqmT*j
snM]A["#2<u.Tbrq_F3CYW-C-ZEW&:42A@^DY?GV^cn%%.qK_CM+9c<3;<*<c8D=#7d1`4j^I
9$p`rd5d:(7g9=sVQ#IW1K%*"g'paELo'M\ZSQ51ZF*P7VhZ)NAAq)E^OUX+46s?OI4:rA1Q
NBRKEM&XMi7"RX9i3.`FN(EP\bX7W;MU5sJYWi;m1:1RhIJeYi"iMJJUDm8iOA='+#9'o*D*
clL"Wj4eE(>rn%V^in&<='Vr)8=m8_o-/FB9+T\kmp?6&mJWa_IEF.=R[b7U1LQO5q"!]AVs&
?L]AJ1Qb_`)p']A(!hR_Vs.hF<?8rdPZ6-+[[PcItg2qAYf0n'S,7ZN0Vj.G\?*"_2@S>V*ET0
p_VJT?nTBZu&(#Dq-J)qUniR'Ksl]AMt@N6Ys+R`FaXNM'?7(o,%F"PZ26c1@%&s-hG6pVd0:
o&=PGIdN_o\VdZRtN[Q'i8WUZ<j0[,W+1Y;V<"HOi6"rWHYdZ(B!4EU-o0=1$cqjF->!Lu&P
L[Obj4Z+WhMPE>5QpXJj<Cb"QnGFWQIDs:RRn.N>&LZ%s"Lduac+hCi]Aq:JDeJ$@m@/,IE[I
`7]A*Bg.[iWq.S,@pU5<9;8J\OBOE2_MR'.,MrF*=,r_IWk)$'Rp*"!J:DTH"ZZ+DKV5bGl]AX
(5TCL*0L95iPUFiidt4Y^"tBB7fe6CS,Ft^[JUe=XT[P<LIr!YOFnl9_HK!jNCZ0+KD\<$A_
ru%^o7"'fkOuVp:klja!Z@N>o?0f5HeY:H?qRFF89#PqpB#e=CVkKZO$:ASERrNNF@;k_$pi
hoZ"$%UhDU>s,'bV$*2N8-2:mQn!0iuc>7a=icRKp'nii_YrQ:]AjZ=$?*RhK(d+s"*nLt?A3
qO[D#mdX/DUdnd^$dUo9>!.FC;iNPT2*-V_/F5Oj0cGqgF`a(Y<.qWrjQHl5li@sop62<:r'
DtUWAu-=@7TabQq?^+Om\.M3=&<bh)n/-eY5!5SO:*:^iWc+-3>2CCBE0n8%s'ZRD;['/j6_
]A0WiIfI]A4_'bBl#6pYgkTtp%AgOU/AP9N-]Ag;'Euj<8$irK@>&Lk7%fU$bdOqX(5T88:*_`@
1ru39dbO'STGn(tTA7Y(ffC91']A0X>p6'@(6o5#a(rE5J\(n#7-]A$oj:"03E,_rL/g%8S=:D
F'jUpTS_mTeG&QS<6u\s`fC21_H;''?Oimk.C5Z[k]A(N57=]A).sdA!9:Gu`2B2R?0"LJHLmn
Kbi6f7Ffnf8]A*'=LUKTPM1Y@h@Sf17-?T,I99d(-S#b/q0J$NlS9o[]AbhXXQl(49J:TqEfsQ
G6ps@&lYV]ANmWe[]AW;GW1q>pn_Hk&P;q!UeDpZY9[mGP@6dO7C4o]A1`$B[`Ji-BH$4M*I0X7
Rd,)JFB1O?4uWX@F_Fm*lX*p[[k,E7.\8]Aug<`2.Q"mVJk&CQcQ/m2NO17'[(6CHS27!Q:TH
JN=CI<ZjCmuEjK$QGZWG\As\+XCn8qpi(:knY@PSg?\W"PX1a.#W-R]AjB6?6UE,h)ej2YTD`
&#U!F`A%&2+F5&g;1L$?d\1Xf4<27l'qCOJQNsn0.3#tl?,ID9e6122.iMfG)6/e9(:h%n.o
`foN\iCQ9de7s&L(^s-"fT[sNK2bEGt<:AnZYS&8O3'L!NMdm*?foYlnucYCh30:531.LY<\
1TMM&f^gjC,-UH.qa#Mh&;TMjn?YCHA35A1$iMd9<Vo[G-I$A/*i(kFBV-[LeBk$*[<dUDpZ
_]A8V1koq\O-G<Bok*O?#W*)(+L2i^jp8j!E4^>A6o32=pV2i>Gh8=jj6gg(`<aE%t*I=&0T!
jD]AqVq'Ga\s.!MAcH5<)*j$X,oG.Xt(j$C4O_%i""8;]AX]AhPS0i<Rf.l=M'Lft"+a)@2PV+#
r?c1$`eg-\&%q<e`9TTMAgT1,u%=WY'`!dZ51;ne#X^ZCn??Ki^@`-AKG<X%SLG\kZ8:<`Kc
;"&mqEq"T]AK;@Za.Jh46rO\8_2PN,VOlQ%[L.H]A,pf#)/2B9YTEhpM7ge`#:njKs&WS`F5AH
T3cZ8.XGiY'GeP/$#5)TIRO7pTZMK'=F>*'$[VZfh3,bIC`!!quW]AXgiF+lVOV>;M2-2pC53
o`\ckHR6#3:^*Hpc/pP'HKjP1IjiWC+@7V^Zh*F"eE3NU!_*c['qYJ^*Gl+8NZ@c]AaT.+->B
TmXE-ndncfCIFB-3_!gWYqKDqLus+H76%FS1q6JKr7!D7lcgi5fYo=;*7pgF[WkcaZ?IocL>
_#_E-*RsA$ih`o!-IH]AYQMD0,PUS-H2.g$/<,mH*?9eZFrF4R4A>h)@rWqK$?k=m+KKB.[N)
XNC>'"dI:Up8h]A/4/Q%rRCNKKXU8KE4p&tM2i(JPS+FgVORK#1EK9=49T9*3$k,MfW<baKF)
X*)1mM/k>mQk2KAVH*4O!&2C@l)8##1)=SmV2rYR#3(.d>0G0,(N,bt+NKXu@1+]A*#]Aq((OC
/=[p.,Ma'28>"A!"9$&-[,2I-A?1!ANN3m.C6qbZ2K6TMj36NLOIrAu>'!bde#R=QcSO[(op
YF.__s\=`4L=JU>2B6L+6NJE:RK"e#p.WbU'H3`u.KP6Roshj2'l'1[!"cRd[Sp5COfe7'=)
8X%AppjR"EbaI);W!P-B"L8S?rcqNF*Il)oX9UufSoZOKHUq+O5YrT2'7!&<[FNhi[_CO(d?
lo2)<_]A30T-;dgKF]AjG?#nf0R63X4/p3Wac1Q6^.8lL%LQ+XQ`,so!L!S_`RL25->dUmd7Y2
a@T?r25J2m'+4e=%[>eP8gTfi/'Y.YpfmJ!ubR[G$Xe5.NhZ;EHPqOL#oA@CbGZMUtbPi'ht
qd.<'*Pc.l8pbSC[[!mj&=90RCVH5C-V7&ZQX=&q,C[+nkf\ojNpq*>On/i+.T2_J#kc_n2b
+7H(Jf0M^J+fenM:R0#iH'VkcA'.8ohTY@;@I(%H7#O^#>MY!C4(mq9&Gapb4E4GpU-!KL]A?
,pV:kMVl$!J_;C(qA$Ur+i.oC2B!cn^PJ)W)Vh/MBn#.-%%+27ZV($l/YH_j.bIhu`YZR7LJ
QYK8*T#6%"6'92GKXoR6.UXd7cl`^Mb4HBigRX)[aLdDYMZ32>bCs&gcU\.gLl#.PWO_np"P
k<RW*!,;tRlV,^>Fp@T;Ns!/M=W]AHAIW':MG)=5puu*4ZcR]A8c#A%<'lLhUCrN]A"Q`PWsJIH
\GCU[""B^gHI_TafFo<[cC!2/`.EJK@LW*joG:SYF^2\C^4?=4B1MUjIX9q\Fb')eDLTGA39
-Y'cf9%3n7kLhY:fN7M;"sqd7jRMl\=QhdYnhlc,kDqo_NC2Ft"$hW_8WbYQh!MZK^Y."U4k
lTDN>c-4o%KHEG)FPL3]AI_sK6OrbJ-/lG?uIn7UoH\HDpfR\hOEA6Kl@_CRsFGp7.nBG'?[=
PQb)/WjA.@;^3V%Y=sjddIc3d!7h;;Aj_3nMUc(T*82I)?8J+j>36-e7B4ONVosmO3Z*!0,e
%PECRh4F3]AB%qdL;W#QNJUm`EOD>NUX^)V(JV`&,kR`nYdGBo8A8Vi;V3j@lhCb08AOf[2&M
62W?R&L-[EWZc<cn+<B'Wl..'K`Bp*[-7(W7P#GA9F33@cel2SXp4HMWFO5mD2$CaR\VcJq$
ER4j&lC@=d?eT5ei_\0<+7FEN<-n6T5"@B.F%FhXp!=QSQP5Ner66GI0dD7K$#HYC4Vi(J?!
4[Fd('X#sBH?)>!T$o2=/;Dgmm(V:tH6DMI%a!__W!JW^)5=\!NbAK6jTIJh,BmD:acL()uD
o2ZdJE(DU,\rj0hmXLC]AQ*UPaj$rn/'&&J0clNP6mD@Y255(?F]AY,A%ac)VHVuhaRSnrc\da
a#L]AF"<!^e42'\6/+SBq1m":i.kj$?tCqL'/#n;Cj\`p?bNGPdIFZl[feAl:[O?[neY8n>(M
@'bo<C%u5Ci:D'uH<0#.61R0'N]A&B9/B"?s,6$$7YM@4"dsD5M.KP3+D>ful<@#l,N]ApdP"l
\t)V<hMZYQ""PWB-'P>CC3/[8&0OROB/7'*k5(&GikuU<.H4S'*F0L:_X\dOOHTXSMeld(;i
L=R/Ff)kO&>bjk'fNge4CK"JGI1tp[EH+?2Jid!R/Uud1^.Q*S'<_?o+fNh$o-41*7nY:giU
ILK]AM;q(7_qiD=;+:6fS)qc-d`V#k+k.RM/Xc-MVM.["cHg^HR@>W:g9>,[?<79J\$\=&'`u
=9#nV@mPCV$Zl._%<FN=c(rJM]A_@S>6[#s_VGMh,IpCQVZ9<O@;LCAD4V$QP\tYO98s>qQF!
]AM>XY^+WA91+go\fMf9V#8k[k]AeD[Zg%XMaFa7!K9+qmU+e"[d1j.\*B$&'R.`;@^/"gpqLH
#&(hZXWE#d<h!VRD!t6X6(9^9Abo/$7NUK8sXsptMsTeY^7]A(F*nY=*]A69@'N#k5EtJdJd\,
RlbDqSg(1#b-a(`CW\7f,!K=7^OU,M3"-#V+\cI\e\it5'c8HWq?0hNaeSp!"`/bo'TG^eYl
'=-<r[t69en_B=`hK=/^atC4R/bV^ct"]Acf\\pq&Sn7tHG%rs!rj^]A0/!FihRuYI>\qm%nOh
mgU&NopNYT6%R#X-=ZS^gBE.ug2))0X@T3f69Oe8ciSYJQ+SO@coEfVjPI+U,LSqT`1;aPY;
i.j@Ao/7\@r-fB4/<,b\&tj_`F3SBt(X[g_%pp\'ra=Mfrn#c$<,J-1aC"&Q>F_*[U7^b"nn
S,r,.j%Ss5<XRQug"Ro"6uYhVp\7ZA9CK1e`s_o^JG.2"U`n=8?^cPnaglFtr2</L-dWZ<$*
Qdn4Z"H:K-DJP]AYSdhrH;ms3e)Q@h*%*\I\0dt52#:82ZFK1BH3N?Hg41.*^=!?^?U[tkT.-
0]A6$ioDPk0:rc2rH'9L?\?/qVuT;MQ]Ae7)W/7gTn*\Wg91=N(=EugREi#pZVJPk''sVSde3_
Z4lV$e6;a#P2Qh#@ZT5,A#&ehYU-I,5_NZ=ts:(*e'G8i$Bb:Q\::7b']A.37Y'.gq8MA='4V
_d:?NL5Xmmq37[F[$IT2h3$\W,OlTB6tD:2m,masl-+B,5L2/(Q`p9Vg[4N4r,!G9/gQ)O6_
4hk8[qmsV7AX&]An\bt<&c+"5.>EMTlWZf1#r!H66M0]AE<-"`DNIq@+4iFNpD<GkQ*k>S?:B2
!5DsGQr1%!=-^l\ZPi#hOQDX(.EkEg!p.jFr!PI+#?H,L'=\H6Eisrj4M2*(gR\0I`NX1*di
e9,65Q2=fL0Y^H9]A\_02JOFi*.+:dq=PH(V2u8G0:8CTZ5)(@UPRcGp:oUg5L!-K(O$a$IO)
R'H$Jgp6IW.K7:u'oE'[/GT6JJN;B+Qc0h;1B_*FeKoO#[PoT2,J""0\:oU]AN%i_GWdnhB@e
JK=B]Aa4?>C4DR=_^&ELXO7jr\o8OVYS`SoXhS0Vsn(mP4eV,taqG!lQ>@?$%&**P8p+PJm"3
>2@2*P(_(/n;5D(Y^*W4Trn'RREhS!(BI<!)>&%u"aF?scQi5hS2=?E_jGb<JLr>J&P<N?'H
$COV"4O7m;`Ioq!bYU6]AYIJD#p7V5,INf=[e6;^%;PTW]A@;+(O$V+DW;#_;tRPE93L:_?O(F
Hn1Y5R9MDKG[kqU]AqGU"9\e"-9r^LT'/1Ujuj>hhY6nQq#`:RA=']A*\aQrWhI)^PjOkQiXP6
^]AZJ_KO1OmRY(PhGXY`G!NCFsY'2k1N5l)>\>[]ArBB*D5gA#!V<sLb9$s^j-ma*`;;_7\9>A
]A@Dr\qkC3rQG/m#U.p:,E&fFh:9MoLb0_JuHtu8l!!Nc+[TCuUP,RtTYg9k7^ok;i%Xg%XG.
in)MWE`VMre>S2,/L"luAWZ-bF"pI&0+dcYOQ.>e.U7jC8ZPZ*$qVb=n"dpcWjVm0>fMQUqO
/@I>ckN?!cRa$60[me#ebs6XO/3OUGtaIXfIrKb]A/B)d>VfQ_LDf9n\J&2jYsQ_jNEg=;,4h
:M9aMp3'`?JBhjVr-qbIgH&QT2/@e00HddP]A=-'8H-^&?2)7"BB:Li5"n]A`Xa+C*UG"D\Rl=
Gg_p9<.><A=_XH>HJ$J3]A<S2R=:XY6V18k5<G;))%o9bD?$7El^?:QUfim!eQB6ZpuN8aR4a
)JaV>gNHZfjk(+)O[H%7MI1d<R;IJJ*J8J93iD0XN_@sniRKuEE\ob*GlrDHqWD<]A002Y6r7
>Se8a4)ADonP5b`!C69CnQo0;f[2oEg.0I<83!41*",XHc@or4;#g[[f8Kb*jCUD9O3qj7F8
K+hb7oOI7dB;qKc?DL=h.bB#@SF#ChUCQ0'oMNX.TCc7;b06EhH2+U`0%4h!39j2o(LTAnSd
TPHu*lnh5>E5J?9V@%#m"Y;>g`fd.o>%H<Y]AEX@`cTUE/:.9Nh6m@/A0/G`'/?BGgFc`gI$b
tXX*''*p'@(S[^iftQ(PV+B&8N[c*l"@CY0%\?KnYsH;8(\l$R8D*OtsU?!Jaf29O8WXin2_
Zo6!:N`i%84e`JtV]Adu(h`<>A<T4@K88Gs+e$5<a6*:`^Zs]A2p0#+=4Adm5&&=Vns``n<=oL
F(MJb^$Pc:MLVm`EJg+H#,?=?1P6>JJ'+3NpomfdWC%=LibYd`2p6Fi&=aj7HW1G9Z3ds8)m
"k8jgb+ifnH"P2NupCWYAZD'DFCWX?(hSlWJ%t\6%g*f?)]Adk)+J6]A0lRpn.O`<ad6RtBd8A
'_g^.?A)>:qT_VBR\hjh[.NAU7SS]A1.f4%QUl[$ZI_[N1,1go5Ka_CIHsQfjP$T^n^U,^+k/
5C\DO$crs'SroTc@lO(R*47k/k*84%`?=<hPOaEm"u_9+jCm&ECA2@Q]AuPChrW$rTF#L_1L.
n?'"bc3mC1/D+Q-,[EgibGq67/A.2g#YBKFi0CQHg\L4[)d%Vds1Ra#G;PU!oo^$8#&i"Y-E
uUd8N4SM#0q*Y(B(2mEe!%7AQn0cY?r<TMaTeC8VqA8K]ApOLJM["06:Bio?2!i@!hjQXaii7
'")>a/#bU=b>EM>M]Apm%+_Iogb".0)i?2F$-Vqmi1G=Un"X@UFO+TXQW15C+Zr`f()`I,J6O
_0A4IA1>=W$b6e4/C=b*BdAi\Ms:)_e:u5bkC6]A-B`e"HB?::)fCaoKBQ[O74$8RSM*ulQXp
_q*#*Y7Di9a&%bO(P<b1m*V<Z@N]AU3e6pOiEfi]A\;XFRHDY5J+9igR2_F#2*J/>"0'&GS;h(
d9!#4^QHo:;Vbf`MEaNMf3!s\D5!L+HW$?A&P),)A>#'KBhn;?]A_Wt=9sY5<&VRc-.Wdd8oG
mYI`<M'!Ll9S=UnW8/BfnlpB]AMNME_DB/F='c-kt%L1P<kD*kO^c!*[$m;nN<AQ\T-T@Nnk.
;egZ(!E'VKVl9qh79cE?Wrjsp_p<LaR=OjTVbStui[T\mAVN+jr6;VB+aEauVbkcCVAguDW4
ITi<dC3s5Sns3:]AHU]A'I++8j>6PkZMWR;%3Vc[fM<oK+H9qA(<Pa``G@@UNGdpaL@LK/J/5p
fgD?W)Z,]A@ePFn%erQESgo0%=kK.fe!*TtN>l(O$XCoO0]AX?qN,e4riIqhWHAb:->jcnPa/e
`n;YmhWEdcO1E,p&7_Dh,Og8kfCCQk/Os'G4DCO<GhEm`@G]AcH\e*ah124NK@4"02)X=O)1`
YD$<86#LYfk,MJC2]AWD)#?>juk^YpD*A4K)83#,f&BA=)EOD%K)X+?.F#5L="X)O!Y>G>VR?
2QT$H=aB.*5'"3HF"a0(!YJPaP3EU<;_^bjMPr=TPR#%8qZ3+%LcSs"r-f#21W.LJnh_:<"r
6*Cu)hdo_c[(;qp5GN9>/!RkaZ092#m7HcYp+\<W4]AS1/fAXmoqr#]A2\of";u2*"PQBV>^HW
Sr[>*DKP@am2T[uZf:J+$n$%7n[B"Ka$GFMPJ17m-Ac5XFjgtM6)Ds$FEb<D^M;9"7]A,,*"T
Dn+IcO?NOte#Y%FCMLS#l5!@;ki(A,mJT(^;Y6hLAtUCONhe4i4Y"NAjf*!$G_fu-(aN1X:1
]A=4ZV]APIh&^l9G1eT9CG95]A^HO[WM)5-:2f'gPVg1%?eUr6(PJ^Mn`.%8c<fVI?i&Zu\-%B&
F?n!HHma,GMj'("+d`fsW1J+Ud$7/!YJDen&>*:dAW>U@+[7Xhbaebs@A2>4`52?b(E,rAma
6Nn#Wa8)[PR7M"5csR0/%$L=\[&@U/e%:B^HND\nPG9scVZQV7rQiGJBKhoj]A\a]A"r%aiA,>
huh`p5MduU&5%/fg7dF7Id5esnRO*eX-^ef[g1gX(05#Q<'s45Z[h9slPT@bcs+.HQlgc5'h
dXMc%9/guIf4)&iVXtn$DRU_r=TmqE)utPT,mkBr1Yu5**+JI8m6f4]A=@l!*YucMl?[[=BNp
F`G*/\Ii(,8@*D^5I&3I<q=cY2Rqk%dD,ToKk]A+#!.hj=K:U,iE*QbdNX<Z8SRA1eU`=6>h+
TDK5,\iDGnMDgrfPQ-5RAigRMegG(>$p8BLU;R!54oV4l>8bF@]ASq%)sP.;RnM/[=8XWRltL
jt,NH&T_R0-NnKZhE+%!6L\0Lc#Ak,)7%f%)hE`,UgnRG7*=eT/$bcGn\2j`RHfUZ@-UDA]A/
+AH)/"0MBdk1<hZTimc0;p^n0=N?:bRhS[%5Qj`#IG(:)tkqj,L+X_PiRRn-gl,6JRb0d\^0
A#-i+m+_9SC?lt5eON(\2I#Hf:)0h\d9j(.QOa_H=q*--D=nY(\npZkG)%3a:D-DK4Q%QH@E
X7:":-0LkP!Og:Bjm/-Q5rH*]Abo79=i>^hlD+'$JeNEY=WWa*J`47=ICSf\J*bV>b2ajO]A\W
'iMh99kDlrSOnWrJ*pS[2Q"ck[,Lk4;1G4YFLE9YPqseH50q\eBccMMGqP?jH8`?+2U[*d0^
4R&V`d1j5#*\hAl[SR.`n/aLNoql?Fhu,6;`0C:q*E3A7)8iKW9n[r;f(Jr\[AkiZVb8ikg^
*b9aBjfoMBq4eb[u-GFJ;iG.Sd-Qol'<AJ_/Oe6,XP\f!3DK8hiiq>+Q>\>*a^6$1&;P_EUc
Nl:-]A7[X\8.(F)3]A/`1q9\W[O<Q^MVfmp>p+'`)RF[-f"`8l'+e2)R@_oC1g>H/"<YP+SC%S
86=+O8;mCVtAtPfZCMZ#/c.+.p1%]A]Ank!e>*d7a,fIep^**ZW9-:u6%ji=`ob^]Afh,X^&b&4
@/U(R:\`(q0ct5qJ1_;e-'[dbIAu2`Op!Q,_qgInDZHJs%4N=>OrHuEo/bQ%B!,8R)h"Eh;^
%lf(B'mX/cBH8-lc%B.;I%$>An$ToRN%`5CjE)3gIid'h,?X2JEe1ab?'@WGH@Dt,m%,*S"q
"R^cZu<FTBIA:o`0f27U8X<BF#h,hjaSfd4fl!HAe/$;pK)2.FW:=5uc8p!f?Z0+lcEcQL.8
IgR+YgOB,ab7L2TbR$<Lb;6fXc4"Qo),b2H6"9j?*c)FGTe2E+r`-Di:IZQ*kh(A@SYYr^m#
l=pa`,6;.K.@?_E2rIYlFFFP#B#</fhB%R3Q.`).H6d%ICL.#<3TCa>F<N^h``-\iN1dN1S&
\iW%:[6[=U^-92-^K]AqKVFsbl(5LM;`h,]A<eF(,,tK,A5P9q`L@U?h\HqKl[pLS6\n2lUapK
?C^I3'1"E1[ZhPc$ZjPgF"Z&48EPV@31Q%;jlr_DP151M'/;WK^%D=_'Q,2.#<X&rZ;?0*+^
OjQO8T7gID:!cZWF9<nc.)I!3HS*B7^>nCBYU]AMtCO\4YE\E)cZ\h>kLHhH()8&GhZBY9)``
X.@e6T[*7_L0.%GL[A@%76<r<n+0H,\1FJ/'+TE0_#N1BUqQWOAYM?9?3%JorRco#^Mld@Yo
eD\3rWJU^FtMOe+tGU>I]AZ.IFPXk3TPjR5>3JaP;BE!o0phe(+V]An+b]Am5mMU&5jJU-Ke?U/
^/V$+D2-SNj>1IR%"n>#IBX``);1cq3CoCju#dJ.F65Y7b7.:'LLKVpWj,NK&)uiJYI/-_33
Y;mQP^ElU%p?R)c-_K+A\#PTrL&(r9Bc0Fn=jMI-c$aMCgjr.PT=W3md<Z('nin_Ep]A5-!t(
@u7+@92bVl*7g.7@U^Q:,\_GPo'Upa,%k:n+\P8$DVD3"t4EH\EBQG]A%;aAg)_6)pum'oF/'
A&#Fi?-BSBmhq5:5?XYuJ-"%gn9FNU8;k99FZJ@M7)tK7eJBQ7mo^/Uo9mrqHYdB!W9VF3*K
Jgq!9,`ZjmD!JC!a.F3#_;"'+aNQVM#4!$tHW/h`7F/!%[mtp?P(?R$$Yi%22ENL>;jnBAPK
*4_JnG>'-.WY7B<XNn>NtQGZ([#R#f(3hfJThaD^`N3rN-^?n&Xm/><$4QBW7FKuhMDiCe$[
B>9(/cka?'VU6IDOUXI*b`qa<\iX(3)a$J;2MisQ&^1'HV0'E_g+l2'V;DX&)!C\cq'rs"J)
5!^?t'(QM@]A`8`kO.n^cXXLAnAQHRCag@DILY+DWT>q8I.IaE73<IC-Pgo)[_19H#huqetfi
*IGh$`D&[u6OfLV$WiO>G50Lr(#!WD$B8dCScM&O*[%ajK/N2A48?o"Q`0(2hF]AmD\HAK";3
JYk44KD/D.4/eE-PKt94jk[@&G)E#1*=d)a2?gHb728#!H:EHT9Cu^LlZt[SI0!"(--@E"Le
T#52-VMGuRi3:_Y+4&9R<\t,1_/;\EPb#^0Q\1[i^9A2SP-4VnU]A7M^1Htj6XH3R!LSW?J$m
\"Xk*&t*n[1@H\;c=PbW(2XoN)"6ZEg0SFo*<"TqtA4+>gVaXe?VU9s6jP#%F4t9"79I`N"%
[]ATB>81di4'dPf<Z1Q,L@C[X'U0p$Pl6J)!5a$m(ud8bn^!/9,[s70u#*lqb\&o;1b<XdSYJ
EJJSnQ0#Gq%4_"9'Dm")c6EfSJtOB!m4'uSU65VW$mDLcJagENf!=VSd@0?@'$A!c)A$4,NI
gi6!KMX;9C?;R2h$2i_L<2Q+4[#BH++RuSZm!9g<h*q,<Z;M)aq<-pRj%L3g..RO4!ar"k;-
,%Yd$Ml$`rGTLfoX0N3]AmlR#2-H?0s>=<):#nM@X'b8b(("QXYj'O90M0pFs[g\&q#1H^PR&
F9"nF5`uX<h.f_EMFR?Je";XK1_jbPrge[L?20I5Ob:`8Pc`Gfdc:Q`=D+9QQB/:BA0%,F%f
PQ^N2o7T>c$s;e[T95(Z./:,LJA[=;Q^C2.=)!7P6q;;o^"lJXchi\1er06f_jYbaXGN4c2E
-BZJjL\QIa=0??)H>GDT9Ql:E<?0EfB>kgUO);)@!'URs2*Jo:/S<"=?!&Q_1G14Z/VUi*bc
O#F:k;!B>#.H:3r3\X"$3_H_S%`N5j5"o\;F&]AEb)P(lr7IBn!/oMdglGoo)D4#99U"0_mD4
EV1oYFMDc?9`Eqj!3?Z1rkTja^IA!\j]A)c;pG]Ap9b';%VBHoh2Bb!A[#S1eSShsos>0tr0-[
YPG7QcR,bYZ;'M-eX<<[tSh-Sgd92`at>]ADoJ=in/_\LQMb^,-Y-3P6nha6Egc-E#.,VB1s%
&0=)()godL/;G*5dq\!/&OKpN]A4paaa"<q?GtC`P;o`L^G0#mM\'"/gY-!:3dnm*E7u>I'.[
&lOja=gq\)l`/=X@&e2S[72@R?'iSbD[`fa`hHW)V\>4k[n7An?dmWS)p;0lG0s=KV>hV7DW
j'RoFttqouNN*H$FtuHAfD2MiR1^-4:p(e!Oni`lc*M_\5gq5aQ9k"C?KMOlA"I8.*VaIdp6
=0iGoXn9Te5,cnD`E9\XHbJJ4TLg'iG_0/H0pU4dU<'i^RM"J9A^=_.2L]AnXHb>!_rHsQ7Th
ihH`Je"/G6S0CBLM(+57MVJqF]AJa<"t!>e7O?s.8<Z0agNpKF4BMpEbm7U3]A2?S)-#b;+ejo
H;G2q9\m'`H-YIuur0@aQsR'aE3=8*=T:MkeDN\18;p1rXf'Z+I9:/HULebMVW8,Y%j^F'Ii
)X_?qEEA?R,D?bqP&(6(C@r^^Sr=qaK'0NJfUQ7V0BLQ*pm<)YOO]A9V\e:Of$"4&%S!Z2AG*
IoOb`11E=U$V27<V,195Fa!WuhY:-T!b2;.FGA5if4*VJAF>1Wd84Xk8*7\f^#orKuPYbuc^
-)9ol!%mS()_WnVp"4A..<-Ba5J<Xu3Pl$i9X.MA^Z]A>U(]ASWUeT47]A4HfdI+:&u^;`''f=o
(?6uVX`_J.GN8XTn!>%O6S(p9&Lae>r<M2//%r<]AHr/<WqlP3Ps`)Chh"p0nq"4BK:h"-)a-
l5nrUag6=$I^iR8b/*5Oadi-g&&[1gTjYPQ;VTiYg5fg^KaX//e,pWbb#IrH+X($28,!Wi"A
R`d?E<#C!@^Vn*/FsV5mA$jP/mV]A@[i<(,a^T9_m$FB_[g/EShaB#7c;bt`2+*b"pMc0LJh@
!u>=QAK3a6>'M.]AH<hRP]A,"lQ<'Y8e`2G@T[SJ(nCC!JVlu9:%m/;:E&YOBX+:V5JK2K4M'o
k&bBN2G3B\!cdY?aE2ub,WK3b"\tnFJPaZ;W=0&0jWgHub52<WA[PpoZUeM1:8B*,[GWHgUs
/t(NX\@U[T)]Akc52,\<HA/N+m9n7W)L8Ph+[6kG[<g"`<`,5)HgV/gElE.&RUO"Gq=)Rp2[6
4j!D.q![.fHeX@JSOFHNY.'4Tghi@U+C>Xq!"K-fuD'ECR&?LFB*FcUT$f%Gu"DFQ,2')G$%
hHB^8kV'D>WQYT)EQA9n<1b\.BAW@WBhG/jF;&^d0!IjeC_D(Mkg_R:5$Q-K4bX-qV7jp5iF
<XC^O]A+_)/_)YX=?P;/AeVq]AqI:V%/N6>K+A,8m)c4W>EEkQ@aW+T0d:d3>Q#d67rA5!,;f>
P%D:We7E.N'@tiJ2Fme>l_#FKjBs<]AFn2AVIo=?#%Xu\N)8)aF4=`)E`:MqMdOu>e2OJEUm)
@9]ALI(+o+<4i7[\cjaU3co:mq#E^dHjaa=50,@9G<8<#`>]Ah0?;[^'Q"rN#**8?74q[X]AI#G
[,.lEn4>C+2>pX`jhhRe3CZ="B[*/$*>>RMbJCLqbC0qC!sc0mZtm.@2_'X<f1EM]A:61?4?4
1HU(]AB!_\XQbtMEb>t&^;RY%-'D.4l4KOh#h@H*lnV0Q-d30M5$b#Lqh-"ml""sZ%]Ak2D\)H
P]AXG*S[1o_#)k1DtcdFAP_LqYW+`:WES/TQcdDGAJsWO;E%*CQJ61,m?"D]A!"[5^7%bdWG3"
\a,jI4*`t)c6Oggfrgq>6]AI-5X!-JIJH"m4gN"_s_h:-f,Ci$DVbj\tt051)!n#LglQKB]Ag>
MILidOAB?MFOmfdT&P6?#NN<Tl7]An<(IO>+$s?<5_TQA!]A%%0n!NY924:#MF"3Y&7BsM[q(g
%/0@nKeSNC)]A#7\GA7R6THnt3rPhPJ5UIlh^W'?)qqR;B>bS=4[k_LG78fW4YXC[(b$B)H%F
#BrW5,=;;Os,e0kIej3/Q(VpQ*8)4^bP3$b"YB7CriP.JFPYlS%rM*.aI$#6Xblb?7pe;6e)
[[2MuB$i<sd9loJ_lFJp4>3jEtIE*2p$nij/fmFaqP1FC%G*e\6E0\#jap=<bemDkci@0htu
XFIkT(Z:pQ4S9VA'[Qd7k,9.Hu53@kp0\Y-3Kk]A?c+ZI[%dHi7DFe2JWK\dG6WPnX[O^\abE
p+7_Vo:?"9(dIi%5fP7A(LSNLTfGn\5rVdTH;_"%,^CKe@0cF:r!+$]Aqni7P1tOfj+Z*]AA*W
GU"F@'[V7!PP=1YtW\CroMaK!!4U``?U#(Hq6DqPT3>=k[>#3:-;`W`r2T;\R]AHhGD*X`)"(
n-_(m6B<H\kqag%;>4ga:Q1hIU-hdJN9Sco4/q!@XgB80UQXG#iep92`[NF#N4H?U3>A=iZ:
N@kiJue<fP;ot)Jsl]Aj51bnKGkDAqRlX,?jZP/'`j8nV)%l>nGC0[9IlssTO=F.DE[fKl]A(D
4p0>t[,&h3Rc=W7GDt33MQQ3TqqTB=hg!"uO_0+Vs0I3dW3(.OOhr/%J'4\q@+7F-m^qtJ3V
8&K=aXG)S_?6-*`=SFa';dD-`'[IA[Y&nFToKjXNZj4PNWGgA#M<<M06-SLqdZWlo9qE:nr3
)EM%hI7[iuM4kB`o*YaR[S6[OGrHnAq0Zq_)Q\&e''#HQGH-'YMe3ZH-1>/80ZKi4mh8j^%g
-Eo*YU[RJ%?c)<Y,40I%!D<[qn=F[&,\*kHKmMbm[G6-3LS5!PhcQ$+CU's<>OODN4?#l<7d
`bX#]AAarhN#2]AQ6u0ESp33<^]A21='K/u`1W'>nVH%B!FlU]AH`Pme[6h<,PZacd+]A_r.AS]A%Q
J]A;"K`6ifVM%#(k;<1Z"1aJ>@Z.DK0VfWkWrU2fj)4l:/WLqs,1'6_I9MFkhM)I!2pG)?*/O
YT0cgGUXZ"M[\Kjeo*=VV>_aThTT(8c"X1L%AGR^;G[C)O%Ilcc<5%19^%JXjs2l2SMTEAi3
]Ab\Z0jb^nV<fI+;9I_>L7>D)kuk4PEY7m0o4_`'_h.fbi,tW<m&bD9uSbS<tCr6o3u*rSI1<
0W,8BPqnE+[N8GV04/WS"jV-p@n?GXb8h<m^ih#[2`_t!\:09f='-'[n+A4R1U)34nQPOA1'
6$P$WuTI:DqtTj1d!JnDlP^DQ5$b);"_rU8L$f+=:"-TQekp3WYf2En9<VICJT#6U%MNiZfp
?`Y5D7G,BeX^Ar]AN(%Q@,#Lb_<qP^YY8G*5#B+_Gl0p%uLF!%_hTne<1W4gCDi5;qa"b04,c
bF&dn5W7.G>dH,OIBP4.0cUN3h43i2RY!2:uuS0/8*ePi*GLg0lkV^r#Y6K*AVeW=%jLsoYn
=oOQaDaA;%I-3H33o=<Xe0Pd1_0?]Ab8Ih'r5lF&([+WLV2j1T,)rVtJ6Q`f_;SQ#!;^q6:HS
5eZd?=rIqFN[ZWW:qlp3@Hu[tjo`0tV6lqcQq50Z+UZIocDCTj>,.WVaSo2j0Si3V_""JJ?Y
a;]A&1=[JMTbB4aRZq37Yt`o([I7\)X.878E@C++@P<d!F?a.U!;caj[teEem6QC#*?b*XQu&
3R<-0[I?-uK]A43kb)sf[hIA^pZmDRZ=lU3(t1rC9I;[oMI]A]AX>X+.`p#;m$D1Vi4J;d;5t"/
o24/VV;:]A('.C;pR543^#rOQ+qVQ>0bn.kgCT>OP,T=lJ1jC9/e1]A9C6M?X]A]A/onU-`S`g<G
7uV<e/RMM.953Kq+q+j9hDNR,_\I6=?Brs?NOQM(?eXd^NM6+*<;A'9ankR2T5'.3.rK@fin
f?hsoenMF0^d3*iaqim><23F%]Ain+Tpn8Y85=`KC/;:u9q=OOH*>=B:^W,r51ReP6`gX9i[a
Sl%9Ej`LI"icRJQBCs'mI.a#cQt^ftcp\[,F00B;Kk;@hsTejVZQbe:8T5cfT30m,GD?BH/+
:oK%%!`am*2jH==p#s\84CTa/a"(/\2,\=`7c3YC5PtS606Y$^[DJ^tg^Iq*i7kDn+P%%3K\
uNU0-L69DM@%L/[-gFjgiqo#!(o$NHtt,$Cc1P+#HL3qOLT(WRg\E8k7Xt'o(lm,k%59XYX7
k726.kNG-uu]A-lRNR"+FnI?8pX1@8HTF=U78T\a#G6G^`3T0mr!0EZCt[C8B$bnCnO)lZCaJ
cl#k&=(d`I:idm\"TXMnH(4[tLCDD/eYnG9`3-#*cmSK09F)2a7N+U0k*)AYn#9ou26\^Z:#
/Gl19ZnnpAK8S\[:#+XFP9#K!Y]A3F#L.7dCl%:!j(_L?`gC%-g$d7SqfG'30d_Ua%8XMWNWr
b1YTHC+g9Yp?;DHC>P4@iPu[)F(sqiq"Q;QT0UcA$W@'==]AdQaD?#BcQDI7''lj(N^jWVh2Y
!0pLc(:PlSdY7-RgB%+.,u!GX\uj9&iP%c=hSdr\*DI;'rO@eRW(/f>J/e48pD"maB53,f`N
;DL<<sa!.+@W4?6gT)F0Uokj*#R&d'N0c3@#k]ACNcjc?MZb'=W42DubJ==g_D6aD>_+<$T&e
l:6uR!Ou4B!K0oO%Tn(<9+`a)ge:p;A,&?cqPeSVCD_?%-E!a9"1q2NY#Kl2JV/UOM2d]A64)
ifWTuTrNBME&WhW@tmY,9Yp!KM/?7:I_rKK96p)Aun'A,tqC8D:OGldYRX$sICKJ@Y17r7dX
/+nIE9F^<`\AKnQ<dS&nm`FJB^81untfi@\/H<3T[[4[o&q?H1>!"9DFQJ=Ge]A@.V,LB6leC
a_,:j0g&:!jT8:L9h/eEnl96D%+?g-rVfKBSLp"9D,lD0[p%[#%g_4YJ]AYNAdg01pi_L)C;F
+Xp]Ap.8BVidmUsQ;+S'5";Dl\7dUJ,W_m3c!.elsK[VCi`9i<eg]AQa[99-87`ebP;Nh-8n;m
,5,fL@O"<!o\6>Ya4%c%%tXH#S2P?a&X@I\\?g:qC^,Ac]A3l?i,L[b;5F&mOFZM.L1ugsL.L
OQB53s9!nIdJZ0'cQDb=@5E(Id-)b_/^W]An\5SJ[G"f*7S5Cp^&Bj_2Yc@!H';j/g5?7deO9
=A;`sX,+Z?q7u<DKbRLF_\@;G2_Uel30QN!g$12:3CQ>MH=8>ZQIH]ADO-/[i,I!TN2QiR9"O
%3ss<YSZ?YuVUMHmOG^pERoI#IO@c4Q@]Aa<U.0CI?qH9]AX78?+l5W)m7JB0mL*="!:MAYG]AK
[Qg*c990?M^+_Ptfr;+Y,%+PrZ[:USa.m9A2$s+*()1Xiuup,fmGk,5g4i\TL&']AJ9*beSO9
75=b*!QW_\IB*Tq^lIk#X!-d^>MkAifps+6:rp.t6`cdglfo#-`>@<>\[&ug)&P?%hB4-L4p
]AdHmV_J^5JTa+rF?YA^Ud+mnt-lY?j(cM.?6*Jg2X+*1o!J4KH>"E&&8&Do+if=[m5m'h4/D
+,.tFImpY'-X0%()ZX3uC)VFFmod)#2T>N%#ZZR>_8CIGIQK`J:D\./tD[M7(i.>'dU*k.PD
hub.Kj^@<6/Xo7M'F'sX&h?28154KN[/Cc^W#JP?fbe0$k8>XD<m]AVUI=Dt.Cu->J,M*mIW1
t2lGQ=p6Fs+@_W4Nm&8MYmQq,\GIuD;?T%P?]Acs8211Fr`J+a+`[$bUuh\8`u?O2tV$[OU,F
)"?;W[W1/PQ8)e(j^:Grn']AjT2.?ai#sE"2E_+VC\,J8>?W,n5ekkRrE'D:W"_(qHbQmDB[_
ilg1sST*OfT3WR.$())nKW:0I*0pU'F1_!!J_TF(Ot$G>..OL@bipZ/>Kp+6j"D9YgR6H=4G
FO7Uh'3WjR1f1#h#U(Q2t:XT,_WO;=.SVV4:K56OPO^7a.^"&gT$5pHCk]A:ZE+V%h]AHW-Klr
"V<c(VD8l]AD91@ldFu!_hXfkYE[IaaaN5Xa#I,J/e@5-;j`eLR\A3/m(oZ6NI(hV_u@iA.oi
7nANkRJP`s8s5cgnVk93V=D]A'.;=RfSK\]AgHVa)T?.F-!ntJ7GghnI8Xf4lT))-bV]A@.0'bF
bh'!J]A4/+Rq(F2Q;hX]Ar*WK)LFp)3p*p/i>&T>#-Ln?3Y\"AJDDWs&0l>4OWG5u`<^Ms\SLM
FEsQ50a^U5IAmCZU3J-1FS`2kn-f9RdR<V.e$)C)SBi0^ZtOMeTp%1ndrbUT1>A(S.Re+S=1
o%^7P;+WQK\N%O%J&IoiERAUb1g]AIEpLMA2?R.5,Le7g;$q+YptI$UN`A!4HlF;fU;WhA?'$
[+%n\r%Om/$^Z0%pD`<VZ'IYPX04AD3GK6e<,pPl4?$D*E*t((1R3XO&mp.Ql?G_bmiN34.W
dKjFR+2VR"s_IUMY<maY<f$YmB(\mXr8F&c<oHs^Z:V1Em)1!Y%,FOauh-2G[g\'-5-ab.61
=dBS0kbRgfR*$E#N,HU"3*FR-OP.G1V=Ok]An.VsoOJ6[lJf;bkQIu'YJL8ghbgtp?jL!6cDN
63!Nn4^apK@%t1nOuso#;@frG[g3Q6GXR$23Buho-Il8h$"PA83PS3SZ#gV)FR![XQ*uK,>&
?S?O*-c?&Qk39('2-D2CUN9\3eERM:M!<G`V:E0Jcfu9qYdYFQeB4I,0)>cmO1/58V3YATH\
?m/q&/a#;k[%i!*a$ler8.Uk?pc7TX`sB@TEf*ghMf425h%91N7=)o$\&:]A7%PMlVDD=9RC-
a_)oX`_=>)gLS64<^j5XT-c>(]AM(5`?DIl>p7rHtu,CQq5KUWH<9qh(e#U#hCf`fkBjKLVTO
NCQMJ.gD#]Ad*,_!=c.&BD,;]AQ[l,]AQF2fTR?_Ug2JYTQ\G:R%+!Ur0\6=-P%U7<KK%mM]AQm,
'dYPY_^22t-m@8Iej1HO+>2>.oC\g1I<sT!Y*I.hWF?.UK5="J1#_NmCS9,KCNS-+5[r-+KO
,"76@4"OC]AnKl;N#Sq!.Q@M!f988uAg:pY2aAB*ED/tO!FD2NVB<!;,('>R$/B5-k;9GbG-7
_hA:PhpIEj3L+uk3DFbfh0<5YIJ+-G>'X6#5"k#Ifpiki3-hC9)aeT426PBPJiZ?1W2[[16/
ujrgkJUDANtg#nC.>Q$qWQ0#J3gbo?ll%U.MP]A%,t(E^uf^8=8h&)d'_,]AF=S=K51I9;?oM.
#.5K(`=j0@Kn+qmfY#a=)Stq9&GdD%nT]AX:=rQ5LRB?fiCN+6j\CM2f0#-D^cEnBs*]AV]AQn#
40tl/Y>q(aZO=ZY-`IT4hrYNAg@\496"G8k^VZ:.>^;'nZ2ceBj'fdhSUV6$%nY;4(E%*N]AW
+pioT(5p6k*@#(uX@Cf0)=0U9Eho$e*e@o$GD7dMN$Pro#1[a`i%i)PMAB'(2/:uiHECj6R9
fJW-4[K)P#oO1W%6\QkH+IfV-M1u6f"[Yk,*AU;hK*`pI#\5MY/@s,9MB;PZmLPP^P]AcLi'.
0/mhZW&`CQT.`[]A8JaggF&4EG3K,Htg(!'hP.9;h$+I#lifB2jgTf3SBuZ^I</4o/Qq1%6t`
n&*/AT:#7dDpOhJ+WX^q']A,uZ5#HBaVY:fE%\U.0lt>0B4s1o'+m9:?KI8(4Xpl8ha[E<9)M
GN2EWN9h346_i?7MWQ'hsmD.U4jJpYg!89^>7:ri7nEW6u^pM?g:G:E2+B"1rLAQ@+uj\9)S
SroaS7'%,hU3^,N-^;3RB^j@6/,O#Bld^VLHc:fLF7\@h;Z(<:34;=#f/P\]A@a6S(QccdcB]A
1QKFS\m9J9S[("+)T_`[P[%[5P')bP&sVso9`n4T,+.s%$OAMjA`rgq*`c@@'JBDJ0,N^'dJ
?I=>6OtOtqnM23(i9di#HoA5BsAeSD@l`sm9e:CR?#o-A@"ofVqBF)k-iJ*%5cjGto2fhP[/
>16VLPCi#H\oGgBMhu*'qdM):dpe)H5<=U!)'Osg;hCae,"KCh'DU.kK[dJ-O]A:4$ePp]A/==
9^W<YQW54VUo_T,d>9/&E6hQ_?8;b@(!Xj-keXQ'nAbeE$qa.+`oC.P<?QUfoBa;V(8Zd*(]A
/"1q3<m$Us'^m<19;io0)*O+#A2DrH;T/5&aUqDPiD,MVS)<<YM7p]A%Hq=%JAN/>HZ8Cbt7V
qX-<'[LD6NXDP>8m"NT`s3Nq%L.P#/ZAB/M&=cB5#X_iL[1f&jOJ+KJjf'EHt0d7pDUmu6MF
_t<R`Rc8?S5;"akK-]At$Ylq%c,Eoj>mD3_m_qkE42l6Tr<tI!6IDN^'AI>o%(Q!B?k[?I\T)
l[X%tqKbctGQ<1#U.cnZGm5=;(PV.e*3D)h`(q;E=rqfKi4O4BH#^h?J+CLK':5#W+f8F;/'
3M]A>6J1."N0I<rKUVL3Q4gj@<&D)JM>PB5X-tuqA1-RADZ^4d5>E;iXo*`6R>;A)UI[6"(lS
@9FW<TD]A"ECZ<!i^90e)8X`Z&Fl1\E"r0HR.3KD"K5SOi?l:@1\:WOsS?k$%31;$JgW?I*u?
CUIu*ShhCo##G#.;"cfO\GC/K0!=RWTSBfAm1t%JS9:-=@BN#IJk%;Z3Y(cpj4FH=S8jdZHk
G_Pgg]AW_N8Yb8Ct,\3;pR#XFP!"(rP(^>M6DEs#fhu:BPnEq'36V(2bP:eRDF6^.2lMELD16
8$js0S>S>''N)t)q2kl\FD#,(+f-M<oX&:#Ltb.@h^4l>>8jLN]A1@;fTC(5uoG@_7+Vl0"JV
8u4_`%Z-?fe0B^ki32e81)OE)(ar:rQ"37t<:%"Sa_J(;F4<&_Ej73jtu4Z,BsYIITdAo-[M
miP/W`&=>o@-\"-E43.S5Bji=fmS)^iAPP./P?;&b>6'`<-[14;T,3%XGWCRWk)CE[rrHI[2
Z(:`B4e-@@Q1NQ:At9Cbq&;F%(?A.A^I/</9,$UTh?^olXuC.mt9f\=ti\Sd0T6=\(^qR1Cd
n]A!p(lMA"3pe.p#V+-^_U9#LEfFh7A[%cVYkGaIAnjO!l7lYtcGCid$RiqqOKAr?:sa_hKQu
omEJPW]A3Q8Al;At8'0ng;p1ROs0:kN"S7hQjc1o^i^a$@hMNClXYn+<Db6W]A.FmJ:I]ACVSYu
9bXSu2aB,[/n,<76MK=YCD,0Yu8:_mHlBJ'_tD?2DIR6eAp8*tc"eiDCZ5e5Y'ZdR_F?@ToH
qPCHloJD:eMGW^d25:R61i8p>8W-50Aj[7sJ`dG'@#hO12PHqS)BX1&h1VSYGiRV+8W<rfC>
q-3/lM4-\+6p@kBT6U5*FW90$f;ia/\IZ8r4'Y=>[of4rHr<6Vq:hKYbml6Y%I4mo1$')0>(
@Y]A9IXT4p#5skM5n?AmtBn?sTbY?_qPN-Uj,[oTJ?7eNSZYpZ`noaDsG@ZNKkZ;@*,Gr`BuG
c>#KCcuOO6\X=a.buE8kqL!.GZ<[&RJY]AL_$;E5hYM$d5Jg,rFZqT%NjZ?XLO*#`?qGo`KJG
8+&0[\b391p9<VOh3'G]A94Jbsm56mb12@_CFGAjrC;(N-;o4.bCa,9MdBE^QM+52O-l&&$ZR
3<r+NZ9@NRa#&C449Z4Y8q$KdE0?4Rkna>?bFB9kB$2-/?@MfFi_*?7#,oXgnS(/QnbK52qI
"JMegF]ACiV%g>@`MkpH\90-C[m\rXg+W>QbDbW@'l[YaoJ-=Ib9;I>X\'EeGkUm1b00rU]A40
>l^UU.ropiY*:0!,XDmNpUS3]AQ5LBRIVGP"B>"V=I2P)#cq7aWl^LAt+VPoj[,6Ctoj#>(Zs
2G68_SpZ<ZKH!B)^%5m[43UE:o&c(DqGP`hm&-'AS[9&P9pT]A.?*KD<5^I-5r-Y?_2:)kMej
nQtBnKZ1F/H/a;'Z)j0QHlSM<EBC)Z<$8n=FZ$8bJUF_8Qtnh-<T<I1-)hEcO5C8Ed8_!*7q
.,qi6L[h+.>]A@>BC!jde.oi(H-<@rfHc^)Ga(]A)W?=82:NQ_DPkV>CN6m&GWJ.K`l[_7bt^\
u@cA5):=0!f"Dp5i#7,g"?gChQEKYf87WFTS3YQ:&.a1O1?^*gMgkmq?(T.PFkXUWcqoPYG>
j-b&#SrZ?ZGqi3Np(<fAn!iKd*cFM"8MpdKeS'!!m?eP8!uqG:e5GaJ]ALSAP=&C<+iko5?JK
CK+A\fZ[S>d[CE,f1Zi-pRX0PF<usT`KOOK?X)GGS+qgoga4dYiAqRIYQ'r1K>:L_ULCjbGd
JpK1+XW,/?*Hc]ArW8>H+#c-r?ihiM:cdf;h%.N??VLWX'GNt6K*t/5[rZO?73l8l/bI1/Wr/
9V3X_=lc*L>\St_JlSCVPkL&><OM`6f.KWZR<WkX?&/3ZTV;4;8jbKjR?(:F[or"DH$XL7Wr
gP%PgKsmWD[YY_1Gh9!P^l)ks4F4rn(3<n?9qHl=*6R+E(&]AfGY2Omo7J5P6`iPEiJo?32mM
_hRUYnG*pM6[dNeI6YOhKsNAF:mh1RDNhk!!>-8oZN/G/[I5k,IETNC^V=0!gjUSa8gItIW6
<lL#I;7o7Fp(Ta4]AZ<.iWMU+WQ%O;r9`!Cub>Rg\XT)+$`7oZ0\:>qacVm2Xq!?WP9pn1jlr
$$uN#8JN%YT$,&A_*uUS5Lg'k]AiB[2f%u\0/fs_Qa#eLY"itZhNkM.ej(C"u?:T-[K(f;OV2
<'$ZeJlS$k4)4%)5!g#+B0\C+G'k!VKj1pDf:[@)s0C44EF%o0t?pg"2s3e[AK%@$tEY.N&"
!#dI_!5`I:m+4SebCSpC]AB`p@IDus9ppd&^?h<LJ-T<Df+J+`r+.mal9;,X^e75Obdd\N\oS
V74EW&p^a>BinsXe(Z3>h=e\,amn?hnsNaKu^dV[>ORgd#]ArK2_jB<,/9iCV&O&ZTCjA@?So
=&$*;V>3Zd6NQ+A3WYh5BMbM7e+d8%4\[h*)FX#*J2Z8`U@Fj6$gTAIq5rW[EA]AWJEYPXCdq
)p^Xe$Y@('.5eCfSKQoq2r1-_CLqE'HTjq$K4_7dIp[9aoG,#]AeI>1!Df(Mg6h\#k=nYR2]AO
"\*ETWrMR4O>`25TQo.P_R_:"jR@11W^"6M=BV"]AG+HhMrR3mbP<?hFt4Kcdi]A11A90B0_uX
o7P/L4;mn5+Bj^k87q*B0ArmlkJ-hY.EI6/fjoei$uChVa2KZk@_q^rEE=fnW/LLe2]AOE3'"
.0\lVnDU-$77L$@$Sb.t<7Z\P]AJn:-VI>lT'Q@[*]A"54.a($@'7mQ`2L91^!am_-]Ab3At3tt
`J,e]A]As)/<AiGJCCq$K_*UMDplAWpY6b$aP-[G@N9Pi,i.\S1d1QNn^P':PaH)2AS6Yq)c4K
p4q.r^&C)62[3.cE)IWqT\n8"4_>CsY1iZ2j)*aiG\bF/Q__24.O46G@hsRn7"I\"?L4p`mH
g?LDE[[Mds$&5Bc_k3GFD%3UNL8Bsg'<UX[&YGIc\)5EgmP_aC!V:SL^e+nAT+BYjPc0WYj3
,*t'OM(^>"$A/k$T\l2W7/*$Rd-E7,tCjMc7rAb+Mfh)E4KC2XG(K!)N;24U`]Ak*39KZ@\%-
"MSM;PldRjRo0R'+QL"I9hgZ9Bm#F,id[NR"!m3s"*+tfd*A^&eSk(<Y#<6+#sMA4mmmPWsS
iR56MUBQts;BP(b\HOjaW^.<k@@&@p8SN9C;QHsZ2&&b+MWk6XEtFVpiZNJZqK"E_6X3Lc;C
A^(e(n@Lf/jjH\^ns;N=C$>1!'N]A2T/V5Au:;#ln0Lg,Y.TIXY8h#TgQL0DCSSjgK#15pjgj
*D$<[gIhXk5$*J_?EEM+<f[@;bQ;bg/mieEfcd]A%uQCEKUf$VaaKsR1g6<tWjXjV(f_FE$n*
4KP.iMO<c>/8KT852AB\G"eXbAa5h%r:hl&%2Po`e9fS)JL]AcDIAOtW8\0<Ik?S'e7j8Tb6]A
79!8?i?G=LUlg!;dg"NZb[2e7us<P3gpb@L2l_Tf^`WuG'1%s2^Zbs'4iN*<!b!fk(:mAIFQ
o9"N@jQ3_!lQ7*XcR0f"A_`/)=Bn(.<GC??%)iEhck#7U]A^fO<X@)KD$3p"<7[/O2r56jO%5
M\.(p7<DNuQfM?hE!:\(UbO:q3h0Vd"/s6aab%QjU+H>5%e?JlnRp*P9]AjO*u1_%R*2)]AMT=
9*==ETp&^=fZ?lMfdHjLG-'@:%dQ5FpK'VC'BB1O]AK6KnPCP">?BB[9qO;1=1W"`O^G,$KtG
kG7QoS$'fT@NZs2^!QjHG&M6J/`.;BgOF%Qr_O;ap7f7!R):18B+mWA]Al2hrI,hBVL3Eg2<@
N>fC8&g2j:lE([BER-$B53i4&n1Y+H,.^8UEb?'0;0?":rg"?2,(9,R3-?P-,7I65kJ@X6;7
bSV'uXtlDaNXI]A):)V?eN)b3X=&"A$Xm%K1kQG8bRJ*'c>?^uHb,C(j.lbHe;_-oP!sW6cqM
m$K1b'L3#aff=:M0qXST+f76t^.%l$_PG]AY"lWFEfTH39F%g5#qSKIJOsdS/)4Dm5F*@k[oc
Al;K^t7Q&B>,uGY@"ojk%/5%K[bh;Jt-<g9uG<!jq)^i'L_6Ot8na44FK^"hlXtBKO+3<EiY
@)L--Aj$)o\,eWas;<.l<&Af$[#^J5nPA"BHSIlT<,.5fe;TQoR^aUgVC@DJiDqIT>bXt$Oa
.5GL;WL[I=.*&%`Sc^1:V:%3rM$]AW7&nXAIXkY&Fe*1f<\7<<!3OqnnUK#\FWEGf'^ZT.18P
H-*"!*1l8`K`T7Okh-F:$9UQ=VDo+;1.EVtjLoglJLqqIZB!\KgKXnG)X?NZ)!EI2GP$[GKZ
*8]AoW`63LW<6(U\hirbhT>SXLbln-23L:7QGN7RU*3oE>CGCiL4>fD_/FG&O'8f,gCGM[GW'
!iFqd<pOW,?@Xt2=B_DXEe^!s]A2EqEQ>L>MA>Ji\'Ap^I%SOc\]A!LT9_Onb+5T3:i&S#++;V
"SiR[ER[AT25iHmF(<8\6s1\"O=%pfm%-=.%E\K27'u5[Yfs`GiAb).j`(u@'pjb4W(K&_O4
;4O"O.$abIH'RdK)$=5ah1lqrLmXOj<g,$?SC"6)r^L]A`*kPRku`=cYNcRti0&Si)i=\R!S(
To2E&MQ,\=o@!""`U,;"k[18CcFi2nEuO%pR0%rY?Nj+L%Nfl1<1jM[`rK.4G4+[cbsO7%L[
i"0%=Y?&:0o3H8pj!9-2NA@;LJbOHE+_0A(2]Amn.;SR@U]A)XSa2TrR_5]AY3+VMd_cigo4WE4
h*oduO)l80(&_I,T%.l,ab1N[lJ2S&tp(.7t%/G?t_pOtsH%+&M'aUY++s>@?4\qTP5fEfme
:K\#'iQZ!R&!_CFh=l+hX9)Fl(EP?R(7$"l9pUJkIlQ9HJC\k0Vc.i$%UZ$O*fp6)p?'B4W0
NZJq_;UEjA)?-'HNQ$F+@`j@)(DIgKA(/Xc(tf4V9]A8m>VnokDnoVhWqfqDA]A!gaKLON-Se;
od/X#0BTg8md$f.gGS4<rtFd@fr:qa%:5PDMVD:##so1bW/r*LK`5T/6L\l$=@!QM0[\81EB
hEpF-j0tT7OFq-m)uZ-4`83CQ,Ii5TO6fe7RqejPH6Kl""H<Fn@RNp%q7u9Z_F<fXTP0RNc,
sk&:J2/t;3cr=0'W-UZ4XMh+B5-bQoJmadeoB?Z#;N0nH;Vk^(?U"l,@s!Y.bRCabi2mn3KL
Jl0`^R=/p]A!?"jqlh`Q7?BQ3b!1!QY1Xq$U3a7q6BFM"L&R\76;?*LF9Obu\O?F`g\=k6'^I
<kn;uEV2/H2k9P/-r<a6:Phqr@=#nUL0/Va'L)rBUJP)sg'a?\%b<T9@`g]AYt-0)PcCdL0?-
=Eq&9qf^a6pR\)[g%>(OHLXC>KL"8]Aa^JKB51@9Y"Gkqa+I"u`,5T4:b5&79IjW1_lA&n<1[
@dHe^t+T-H;/#WJEJXF1klaiq:L"'.n@HU:k2f-t9!q[ctN_j_iNVr(3dnV<r,AQr1E*\nOK
K3!a5qNFOU*,g!eNSr?X62_u<c<=_*B\8m-N`0#MsaqX]A[S,&ih?'))$d=9;89aBpoe4,E[W
R*9FIT<pbDDMW(C?Se6E7:_kiuZ.996Nor5a7K&*,;;0_X[A*Fo99'/a1D2cbEC@i?UVf:\^
ac3m-ZWhk3EJFLn2UNS!1N7/%jhWU8$_g%$gDnT%WDH=i;1U..u+A5)<$cQ'tHHq:GRj)Bs[
.f^#m^7XIZ0Sn[l(FE?MHdfJ^]An/29U45^n#7fao=0X_u+_UK(S8LO*SU:^MfF[[ss,6UH;l
,XXAmLbBl[;Kn3[B[&!')]A)(gR_D1Hl</6.6jLA8STmO_e7e/5_jVMgP1qs()2@*X;6R.a.!
ZE'?j#YfInKes$WO$"o:PK38?50#RKSk%$@PLqT/k(X1W6r0@3)1fWJ53jkr'@qc-n1g*uC\
blVH[0Hes]ADhr+W*/fUD,mQ$o8ss#e^YaTKC1[o?_I+7;0J^H>n`-S2U`'DEWn=oI'dU]Am)>
RXH2q;=9E8Qb^,(?7?hdL\j%BER?($b[XA\fIKD3/<,6r9ZgB0P'eR`l7d\;?"PA]AH,Ish+5
L^Vm.4#cWP%N$D=Cd_WkJB%[Mo::[;Vl@aEJ([?ZbH6t\kX%J&1Xd<noG9Y8:b/"9HsjM=XW
Lg4Ic.7qjKfg-S"q5mjVLj6aUB@@8)#[&&UV]AWPR>iY_mn=+GC"FCE"G;Hk4I&Q_?@LuoEs$
dO1ee45;'qm&_T2Qp5_3`^rp.gFkM50ZOtSn2B"@8p0"<rWV_Ttkl(A<C,U6H+Id(H`%UD%V
(Qs&Df]A(HId\rLPaZ@m!K.AZ<&r>J(?Z']A1_^I4hqnH%K"tA6-:?s:"H2jH76bFI6/Q0p`Y:
U'%s'eZ%&a_f`g?Rfl.>BC_"eEO!"83]ARRT\bdM'q1mQ*rk*;]ADmk\:@GoS7/d-#M[c\mX\`
#4=K'Jd?SU-p6MjT1SD**H2k6r!e&r'+,<+\+4+/ZMTAnr@QHU.6B@UjnSI1m1qZ4#-L9-?s
6jLf$03\E`PQK#2(t\3UTV$09.meW/BW,=>X.1#)Rn:d#!Jq<QZB6>,uk:`Ao,.l"ee_-+4j
p4(37[or\*dcA:?<]As+:AWj(JZSLFA2()&gk6/G>D'7*6&"H0b;cEe!#@/i1V\@0%]AA4gcIP
0"k4D<TlM%GSJoLHKe1lH@CYrFW3j`X3Z`aT-nUK?bVb^>AZeh;mH%+85^fL7(3kpBAF1.KG
Q2<$;AO3?dn,'C*?<[H`^]AiiROXgh^eHiKQ1WL^Occ;luq,CgOHDa_`uX21q%$.pCN*`2MH0
T^BYNi!-qTXi'q'3idnN'uH?-hQm_B91RS<CO8>$S_^t\$@f'`f-fROhn"Z@I>sLQ6_RJN&A
[W34ZiGoi7;rR%,kTgf1>N$e3![\3s$C5I/f[`*c.2<(Jjat+mOZ78X93d^Weo[a"cT5Yhm*
#XLad&$0'E567G9`Wj)He\RQsoq@E19VH9Vt!FPc$9<l9t(!]A7$4!d/J5gSRW8\EiY(\<eK;
UYqk/bd48%8WtJ%9aK_CC4-e\mUirX6GrYB(1O>BAWYIMu%Xi\V0G()QqRB*i.fk1Zp&lPH>
`^M'=,nd!+_Q,iPOcV>T]A36IRY?+%GgBX0!H$_$5_3Du0*KT)O*dJq<i%2"C.J]AYU*g<i7tc
ES)M=b<=GS5MN$33n:H'3oX<X\%Pi3JVY`_H"iB]A3rVWN6KW/lW7qCWF;ERUm6(+V9JgcDgV
_#U((s]AeYRBL(9XNVuT6rh!.f]AKN&k6T@aa9h19'5`I+q<DmTna*As5O)A;On_V'leT3MKAG
npsPrf&Fs8"_L=IN"570QSU:<JkrTJ&B=A(oj]A5J8TTKIl%#U?:@+O+S=%NI5hL3X0L"?EWU
er;M&_^hfFh3j".fCeR>XbGsgLuN;O?,"]AXnn8D$hpf!1.#jQbS9S:BBi0?b]AY!J$-2WB2#6
1>):bAJW%r8rYS22"\N]AZImT4[^lp1fe\9]AK6gg'u"pKF!V^0ta^%EaSGm>sLroSZ:5Gb)*Y
-VKbtgX`T\TWj,N-J@qq5f\u08IZT)7,#BQoTN$Fhj1eY[i6S=6K"lPF$3UTK\N;4HZ$bXj'
PV-,MTZIB'GQR,]A)N8pDi4bHQ51WGbN.P6sF0obAC0[4$D;(kak((Y&ApOneN5nrO(*1Y@!k
,D"@T!s6pqmgaeD]A:a</Mne^FZaQ[q!T5tt_f8#&:^jl1(3tGJ"h8>&VEB[0;>s0sJ0ciNe4
I$;(Y^?n>\FZ<jocs#U1)&!.I*cH&SrWKpA'5<q.R*h[eR`N.fXMbV)]AO;9KJ0I!0%F=qR64
LuD&Rt-,oNZ=Bq*M4JiA?.kU/,8Q8<EUCbgr*j6@Mc*oQ$%c*H<<aK/]A;b?Xk8m0:l`&VC/X
Y8(tm`.2KW?AN;>1YpC=XHL):Ga:>Oc)"\^^?(c1o_ZPYF-=T:pJr:4hVm4HIldLnp%4"U8&
,*'W(*0';hV3^n`l[3/3j%Q;fbmWEm^n7DIHs^?"O9jG6;&)/@'P:+mVirm\cq"gLXX[c\^d
Ca1u$;9193ZFS\[BWqHGW[9l>KSWCFn<U1>\,o(VC(crC<UZqg@\!HOT`l@>%6$69NKr6`@Y
XrX(AdKeZ[uSHN0@E`2csBeTBY$[>Sf:NM6e%ej4J/jhWgW&=4q>]Amea!s!9R5NPmi"58g9'
[V"^t;qA.fV(:FWjN7@T>EXlr;EIlmTeHq!FgoucjeAS,fBjJRV>#WS[X72l%Go:$;V[I,c_
0F@aYnW3VR^qoadh%%U'0"R'#3"GugCA/?S.0$dFMQ@smU-YiU&Am'h,q7#6#h^0o3qd\eKd
\`Lflu,9Z&bH;8bRR>#@eRi@)hbtIfJRkchkAPs*NVo]AT2"\meaT!n$RPGcZOZNGLTa*[Hd6
N6H&lgSI+1F,=e<8T3!nF)YpT")_P/U2Eduj=r!'u#Z9":<th[j?>f<*#1.HVjV)\f:9joiq
Qk"MlM7Bm),G2K+ij=BZJaHG__t%1UqH\r:pd"AMfnlGbXWu&nR"J)bG7VZ'uVoHTVN!'Reu
Ne`U;LXmZ]A[O@OD<4/*p==ptHUtr-``#l;*B"^)_f''\\Bomn5Ag\$i;ug[B(*77D`C3f,"u
A"H?!+#I:r_r`n5GfHS/3tI&J%mc\%onK^XR,;5rK40W;l#5aB=hLj*QUGS-.pJ&p:FW55E+
SLb*bV)`8pF;rQj(Q0;s$aBhi9CJ0\!C`p02n:n8<-&,Y/=DMGOVn/!q3Z<A)DU4m^$f>f'+
q[q`)0="eTdb0&KQ\DgTG1i.CJ7<I+@#Tj>'NebF`nG@tc\(i12$'kmDe5icl[KKo<\2q"(=
hV(teJ[nENU(7`c`NMVbY[?3\`u^2ZFD;X29*D:;b[G]AM_BO)Q13K+SP:c^E):\,b,(F>/r,
&]AMX13OrT]AuR_pNiqDuQ5as*V<\TX[1*b6s$u'e%D/()TG$eZ*r_(%;lfl)-%ta5#s'?eO5!
q<8n1HoA_N8'cq&LLRd'[_&;Cef&*1?G1^=G0'&<Ggmm1d2VG%a.L=d9N(0+;?qB0jep`!R)
IY6hVK.7'$8*G<XGr:C2[VT7A[+LH>0s[I:HR3bL<\(3ZVCLB7X*u[^:Mirgsel466hAc:PZ
iNOg66A8,h+U9sgg;Y(/]AH)\5Y_e8'\"1Q7d-HW3gTnfoARB7I!0IR^GlafYFa\OsSk<CYZg
Itp]AHNSD<SGp3m;BrMf@Ja9WdDP[c;mh[5QuR?23?n^PlCGK<@T0p/[CK`Df1dF=)IS1eJeu
jFAp8U>:,^Gfp#bM:j]Aj85;0u"qRqo_DeL-u]ASctI`NK,<faG4#\^$"bTm+OQQ341=`V0/h"
6"&(dr:B#PD[G;DM/(8KA]AlpEZMQ0^5]AkR)kP:ZYdncjTX4epilfWXe<VIq!!d"]A'2qn%(FX
%q>op]Ap,)'.IKS7q/qC!j1C/cDmW/pq@L2e(GA,+96k1EBr8AQh1Cku%@'Y*)GgHSA"*Uhb7
Gg@^WnLMGb;\%NHI\iOR[6u/[X`)r4El/T8L5dMKn'.X_<(aC]AS`V+R>M.S!tc-lEaUr=N7p
J1WF/,f9OW1%F5o+_pPU8f?,\UOZR^UPa,UqWN'[($F2n$UChWZ(H3mU#Qip0VKWPe)j5K=P
jma5-7Ep(=PL[_Z!+Q^N;E)?DXC?8VI\QJ(UKDDOEL:?Bj%J#jZ&hmOnHX1J_D?R1*U[6!ON
>f.iarM^X<3<5p)#$bg<>A@'Q:DVU,^?kB97/0l>Iq`HLDr4g9'D\F%UZ>+"V.0oT#EfF/+9
=5+QCBr,:2I\Q,"+?u[6huhs0*S-+_Hlf"iG]A]A&."o^^Kh>P8MLcTl)5TS*dGd3rQG6o1eo1
lge.g4OH]AB_j?*f4FlL=Gh[c3[O3>!W"\J`sS!]AN@5Ar^]AT^ol/o/X3I-1j\MjbXX`"n;4Po
$>V]Aq:<UqAj3fZPVK8]A!r/MU3!&=5\PFZE3:U03YjPX]A5qpi/Xuj5Q`2('Kf5W8/*>),g9`"
dLDCkI#R!b-\,fNLu>elpn:ACCa%H&L'J_D1eFbo'!+.Z*!i:Y1o<OI/?8C2^F1.TKO[f!D=
Gif5c98rM-d\;"J8OKe<$n5fhfuIj8^@fI&p&;KHj$+^k#QpOa=QR20!>;@O-Vdnf-fG%C)`
H%_)<`i_Q%FsVIo]AZ!`'d'2>+=r<V\EHAjP+,>WH&Mb_5eA5DpnnMqYHdSI7)R=dE)a2M?/&
Dh'Mp-b\/>,^,Tm!K6WWU0h&A(Q@8V>1"^)'G-)s'Uo<t5_-\BX7Fps-"iA&\df(b*^KLol;
XDhM5PbFOUjOg^$0QhS*ZL\4Sr,.^%nG&TSO.,!Y6m3\j6N8ZgPZjVUYFV#UJ('3IW=o^O]A&
d3Wi`7a!j/`jmE;-Bq+4@u2e6Ui-iN=IgrbI,2tm%DNt5V&^MEQmH,ZG'$P@f$qe_G_E0g`)
47.PP7E$EhV*1a"f>(08D^6TBYYOEF[Wt0]A,t(b-(1`$_^/!M&.gE:Np#n8)@?t@"VK@VUY%
Z'*\'eam]AU=lLVE,3R,Ola_;67eLKc+<EpICMHlbS=jauU[RcLdMFlY&A=F[>D@IXdBsf**(
MZ5IHs%8.``CeM1pj!qrCR'XR8b,kaen:'E2b0[;Q'4b2C?dn^!=NE-Am[cO#a70sY>$>)Cm
JKTZnTsn@2k(RZg.Fnnnf"i\XR.5=ka@EY'b>*Tm[Aspq>GpZ^J7C(IbaZqr`?h+f*m-$mb7
WN*Dt"@58\]AJ!Rb917DIO")^c=4I-ot-AlE:e`P/^`f$!YP>8r^ZgPn#UBnT?e%l!;_VA)H;
epkSnf<9,_5`=)ENh!MZ?V1<me/LfP+ASApnWlfm?*@Po7$ga<G(NrmAm2>)r1J^-W2VqE9_
!FS;FC6JT!tql*-<)Ufu/;IMG#r$`fE^(r>m;.#'s*d-+8+$IKiklGPf)Ma%MbL9sa^E^JOi
6g0b@jD1(BG]A&]A9+e;S#5/`<)D(Y8m1p<%@6L@Maf<`clXn]AT?3rB!<@FT.7$1@6&s%_3ft3
MFY/7SP4@c>s&B"aTK;$Y,6ZnZjNfjA=HqS7`S^Rf.m/?15j%0WBBhr'A)eJ'$2]A^b#0NJ'a
'<rg><%C!ZnL6N0)f8o?D:*0qN=6'@21*SKHOc<jWAq'kA8]AHoB/V$'%cO3Jhn"On;L&LgR#
<:nMEoY)D8O#J\'kuM-s5Nk-70;2><"]AYLt-0,$.@R]A/6+U?)tGbKG;cK2Eeb9%@BK9LTVWX
A\IK1Nc<UL/V:1Oe/+$m_?G6g\G#DsLQ/%6V+)/+4NLVKS"^V,g@p]AK*]AhqsRd@in2<=GLc`
Zjb?C,eQ>8D>)(MeeggE?>PCBmfIO.Mg\QDHTY9.Tj%JO(;[ReK:]A:G3rd92Mr'BpMU"@C1<
tfL01B$`e'`#!.-TTHRkPWErqG1APT8Y%^*<4A+56r'nJ<HD/k`9_>R'8Z^#;r*EMkutCNDL
@.TlZi?og?\<\i>TAfRf*L%MlbrRuREI3.3kOB's92Zot&)p5j.b0CNmZQG?I&Ke_OY]A?Qup
H?Y)!nUZHY/)P$bdPgL5XAR'%G-,JH@H,BBQgKgM3jJG3,[%,t!#]A@sf?p._l\Q>O:-3F_J^
.86*96t-N_b7kau6_?E(0MGTX_"^hSAmbP]A31RR.Zn%UrObBmK%jm"^q^Xn.^W>0X3_8;Up#
E8LEIDAM,4rZ!m[ol"$TO@Y*73OeAh2_,tF%_hqdm2h*Uc6me*?II>=B^!Yn'r(/EZ8Vo('D
r4qQ[=b)\Dd>*'8rSuS(0N*Be8)9\(gm?>%ucA0S4k/"\*WM#*\ig&qP.YFXK*Y@`J/-&^Kc
/GdP[h`FS:2B#+X8t\osbQb_\Q*<F<=D^>l;6>^+'V\:)I?Y_O_43[i(YOoZ+HI`CJ$(hr%B
4&@uHrN[546D`2`'Kce7k5o5r5mA_E#/I&HRS3M5i0&8Oi4J.Gg$1../H$]AK(/aK*(ZPX-`T
"f(F3USkY&P5B7WDE#=13'qdQth_A<)dgB+$Q]A4s$dmOQd\J!?Y?(6KeD)i/T_C/>UWUTQD\
Y^S=EWB@^Nmi:DO&#n@1M=2k(cr*K8Z3/]APlA]A_`:cIu"O8p`kIP%lV`L<!8C130bD\\htel
Y8[J?qGY'4Y,Hnjmhif'N*InI2tWuS%$tl^rGb)EV))#S`%\\T(0';@m*EUZ0ObMKV2Q$6u7
(c7@]AO9Ah6#qY`<ab7-hJOZ:A@gIep^g'F.<8?)O$njZ%6?!*]A,V9HrAD%.jsJrb+/LD\-oT
hkGgi;9\hVKTCZoY[lm,7uE1S+NsB^l0gf=?86mkR:2E7me5(=EP>FR+4TR0K79P7iWLpt&R
g.er)f%V9\7)"W:ArIB;mu6'c4'td/s"B;tKADdA,sc?6B@k^e#Usge]A[))p/iQJS"+i^fFL
LVOXb`]A\[p!!XWmV_jVYB]AM#eWb)FJrrP?Yq1u%gbBpA+c+rN<'cNWeXG,,cdHstqRNbceSI
\t]Ah)iJYRAY(O[:ki)bp>p,C;;8DUL3uh>e-f"?2E_P$hDrheUm=1r\sVBodUiP9ll$GQQ.;
[8A<-A$DhX)>6ZK7GFq1j>)p30hGh+NcD[@kLT"#k(q>0@1j"\+lrqY1hhcAYOl)atWE[4Y@
Us0;WRd(RKSfQ5tS6!mj>Z+,q#P>[4lXJ4J;Gc^UaG[+@h,4GRS2`#c2G.!1WK(@@P`]Ae<qm
WB\hrEj]A!(scAjSpHDT0<]Ac$5X8'&.W4L;_e3X`1Ub!U2'_E/L?GB7qcPQM=j,G3!\=)fO@:
YI\b"Ec\n,#8DlP]A@7d=>I%?cAG]AK706lG]A.a]A3:dN[$9LBF_=bjhIV,Ek[b+*9k=_%9eG:8
A-7Om(DlS*BA$'j0LcuUJ=A@M6f@2rZWrPj=gAE55_@+,]AVgNn$o=QbEDG>=>l]AY;@$"Pl6F
it=U(9MB73?r]ASo#)]Ap-D,"eA.GE;&A?L%>lHc,fjd5>D3@lR\XuKTL#fC]AF.Zc83A]AoD3on
!`&;`s1>*[2I56)GJEF(Z,<"]Ar[6Lt585.!`V_*;gBg"trQ"[kP87J%s'fr[=m,fLKJU/(r1
Ao0[[S[+*Uk>6Ra9l$i0dr0f$DEX;?N)lpM\i1'["M.:[2(1IrYL:U$FY1XjShbU@'A(/ot*
SM5$-%TM5V\rBd/85:ucFT:B!o36DgQ3@_5rW$k:'gcYRq3)pHO-\<cKX]Ac6ihmgiaBo1dg4
RW5$\lT\o%'EhSJDO-<gN2Rph7#gubQb5;[>q8_9dhR37@2askSSV?$jql]AJ";!0kkclG%c]A
&R;,pl)[ma-[Z#8P4nbE*XaD0cY#:lnrc>5L*[I\oQNor(K5+nKi8_<i2f1^JrYuPMT?AXPb
GHlf?'ba)J'^*a!/XEKpbP#m^ICqQU4k;`gi6'8(5;iJ&>;#0Dd1uG!KJAXLm/iWKHf'j=DH
k@i;*RZR".+=iClF"?c+Q^r!94VlB1(9d:r'-Td,+\RT&V>SG1'dEXb6gV8VYXCU;sL,AdQp
QN<fGd@g'GEOjR9YkfO8c*#.%^SigaDalER6i&6Qr[@$;b>%HSRFq#+0XJaZ2rpEji1H=Sb,
2rq_H&t)q%$sLE+=KoY4jnQogad*Hr+^:4g"+g=]AIAIAi!rKfVFO/UmdoUm!]Ah'kPWIYs%LR
&VHpm,7(iD%s-?EmgoJ_*[f'g<P`TT<QJkeX8mpKE;?MHbJTXTN@iBhYk:2Odtj^4S.VY^2>
[A)^`UMcg5kDam'&IXu<`p_!":%Z?:ZbXVDr*G=Zh\-&Zkct2,kYQ4Ok5q2`+8\THe"!5L%r
XaJLm/S6diX!8A8sCNM4/#LSAr&;"t/qkh1DMFSn75YBUj]AE,(_?p\0t6b=?A3o_loJfC;m-
MK[@k0ntHf`Et(P6hsETpds75s+3?L7oG8AriHF6`b4D$um'rrT;if)#=RAG2Da$>A9amitU
\U=m@a<Bf2;E:Y@<1k?c\03tgPJbmmPh[tF]A6\Y%7-"JI&#)6%0!C_lW".WS0UL[3mPPoo%r
C2+#)@[D<UnBq\a;FWBoHWI#XNhP>@@)I*9m;-$ZR4LJqP"cgZo,XL;0uqXS!iQ&31B!(P.Q
S!.%(^SG.X^&0=$^uciia<oG_]AB[X8`Zh=;WD3d]APh:OSVm9`"G0X;Q?%ii<)a&<[mB63naj
,X7:3;gF!Q[hJFD<5_jkpu,lSd@g3Tg3aDbj<(J&]AU@[@%5gbO4uu"j2@!s1Z$C^\9UA'`'R
ELV7(,Qn0NQF>C`_iVl"&r=tClc^2otP`F*_e2,seJaF,]ADWYJW+Z\*(MogJ;dWkj5oFq<c0
$i@+VB]A.oc:%?=&e4u[iR&t.&NW@M7R'YSQJ-U:U$hc+I@0laC[`KkKPD;aPl>n.ZmOTF:SI
+1h,ek1+4BC'M62U_M6AYUA4.&V(lMd;8\mnlYU(?DqA(N[VW.4G5lr'0N?GRqM^g[:Y]AM87
c_G,4i;Q/\C*E9uja/("KI!5eQDLt=]A,pb1Eig@&bosKa1Q/e9441Bh?i/68n7]Aeg%T,hR]A=
AX[RSUK+EJCVqkFN1o(D@I+?/+Ahh?H2;YSReV<rPD0=pfF[`eO>M-n=$)+t8orS+R6/"7=V
Up;orO"+h&_I&]AI-U%SB^CQBU`?i1S$CJ'pZ(PgW71,HWaBf<AI*X4TFUtTdC.+Ri)W:Z+$q
9>=3UVgF69i\UH2]Ap+">&Cpo2*N.Q#2d4Y1eC'AYb+fi8R9>Vd$*.,.Y:>fIAT,FkAk7#]A3.
SEg6LJ9(*8;+\p/.:[,D'0&sW.YBJ!SI5'bjmU*+Pp@#a(7a]A/<7#19te%p^'`GF&pPLPsi8
#><9Q"Y,:U=EVd'jJ0<`(Sj"H<dcROYDg@t(uE?l:&O\+EQ)&E4>F-:BTGsJBQLF.@?]A\Q(.
8C`\>+!:-HC*Z[)j+1qLrIl!`#c]A%?93scBSWKV?q'-oaTc+??9mr/bA=Cki*PGn;n&=;<%a
[JuSr;s$eN[ea&O[h8.>jf"#\`$))HR:<W@-Fdj)&a!_WRi&1pNqqoL5RVJU;+@_CjQArWJW
aYMTogXLe=N?/?`,VM"4"lV%o[Wk`V_u:?IFZM)Fn=Uh=(NtY'u[Q1G*nY<.k>S!T"fi=^-8
`hRON2/As%GK^EG_33#HPeMnRV0)o3Ym:pLX`8d@"BpYt0?.OG\&b8,8`XX1"E+6l%@>^=^>
4Nef!+W5smipKWAV]A;7FMX6"QQ.<qGkta?+Q]ApKm-D?V(rhXdE%R0:(WbcqKE?4]A=aQlZ-qC
g=.&]A[=MV-_#6DmhuSatV]A:e.7[(?XT3O^K6@i;87dCgO<!d9@nsL)s;o"\-LRqAi<iY5)lH
aY&KOk!Sf%eDBtE>,'9djjWe6;#9'D7N\6k]AXnYGc/*>Wl'$eUCBaZGcQi&"3,`2#nrU-"m@
p/2>eeTU*gA#'Cn?<n!ImXf[dipmr[af3DKi]Ao?K8%.CjIT='%k:F6)jFZeUBN26j<_5ScB=
Z_Vl8Ta$NtE<=%a$X4g`u8-\#1X-hk:2G,.0[mp53ICW-$<A4e&Z<bc1]A,PoEr%"OA<.;&1,
;-FXOdF"N\emY<)obN,FeUs4e&^J>#`L*+q>Sl8]AF7W23j,q]A$?f[SrPP`b(4KT8tN1>/'O7
1=F0"AVQBH(^>Xt$I/'LF5^ng9D7liNtX'h$&>IT#3\/=sMHFL8h:9dHS0JgB.76RAT:WLlD
hknE>#4Nf?0rV=Z+%cO+B1=_kGf^YmJ^^D&sj44Hq%odnGkI'$sS55gbT"DpGj$Q$#kd'UR)
o8c?n/qF46C_"h+jWe[,)GVJ@t:]AhPf-J06bHbuFa1>YMRXo^iA)a#W(?T4&rq%kCOMe$.r\
iKo[mT`o;"fl@[ZB)%7b_0MCZNm.aEJ9]Anm?.S$bOn!"BS#jGGc-R$[Rhl[TkCJK8@h9/onp
NAf5_Hr1p)*24WRFgE&?2;L\)^dl9OdPXi/gP$hCXiO.QOso).Q5!',=Z-$;A+,m;irlXKVp
IQ\<LTQ.*SV#RD_;t]A4D)TRPs-Zff`!=lfK*LiA(rj^"jukXQbn9QktaumVWJNpm?`HX.poj
577]AShg#dIWSetGQb-(N\=KS$.i338+6/Lh6df]A/88OdrXmc;?j5rXI`OSXtDi4*S(G(Q-d"
n82^HeRI-5s65s.9eaB^5-IJn*G6q4hQ1^lAV5Oh#AE-4*&Rcq37@So[O&rUq6X@p-ZCAUc*
$P1q:PJ2!lL^54\bg!@8$EV4Ep&$_o;S]AOiS.R*t*"o5QF`_ckd;=4WT,VR0Wb?TO%q(Zi1P
\B42*Hp&"A.>-p2?[7mF.-qUcfq4TRYqkJr=/JA+j'_=k9qiAhq:3Utb0-:-ZW8jBh)m$+XQ
,afNcoh=QS-7A\O(,U&ZDqBN2I4Ws7:IFq!KU'@f4fb9A-m\$o7QjZ:S;VQDdgVTWoW$s4Jm
!=)pIi'3Nfc\kdD=:@Y`q.j`nZ2:XT3e"/S&f:Auok4-`qLg&?**tNW`U/8"K?/p\0)./DB?
qS\K$:h9R:nA`]A@:d8fE+Z'm\*V;,gUIp=TiSIW.4.k!LPA`6D;s=&&$'[c"J7FjG2Y2@J$#
D?cW<h/8?pRrCt?jRfND59#>#@ZdpTjLh:iJNgiBXY*32oLH9Sd5]Ac<WO^Dj7^-?7*aP_Fp9
)$`%\\IFn$d*i#+%169Z`Z8BLTJSosbT70KS=pP/6S%9Bqb;SCaNr-k3&6&TLgfBs]ACq3ebB
M*MLqQ%8U2QJl>qoJ=&Q'-FN,gD,lE0B009+uL.'7KiP/%KU$49L.3@*+VT3AQ*V?MFJmT+R
1]A$0F'IU@Fo-.[/,>Qb>Vmrj+hoLI9eALN66dAb#8I,H]A_5,TZt6pqQjPnOCtR.&:3o<#*8#
M\4bRh[[_'-G4&(otWR2&rdO_=XhMm3*47,S:t2cZuoGS8OWH[E+6QgX,j!lf+4A(QL6!F9@
ptO>cT)?o)9eH!";(<25I5O'.7^<j6R*9iLTN:+unUV8WXdYoUC=brjpNU/8/>ip!W>MprJ9
kPMF/?PS[-#u]AccFD3@kBV+^Y,4>8(:`#ZhpG.4Lp$C=p.BgVd7[Xb3kJV0FH4N8^m.pj)2=
G[;U`uQ$4_@:Cf=Q:o=bUc\%%!;.P<(!+U4q`YMXAG2fR#9FEp>985kD1a,:ZDSV;ii/;Q2i
.TU$d,%?('kXj(j:]Acj(L/Q$0/#cjAkWSs8"K=?%^Q8W[<TdOTs$9B^T.h1nW79W:@37B*Q3
jAJ87YP[JC3R'%ZA-6>\MG8:`7j;m2iYr^#mISYW6YBbQ#so2W8m;<#L#k^l_8NDahlIr4jZ
f%?n7G(QN&q.6S8otjHm^c-C3Pk,<roj[Ms`tGnGeslJH.l*Xid)*RmXHLYl&`.c$Fg\2e@O
3hrklJOkSFp"=;U&$NFa7S/hR.*SQc%@sGb:pn95J?cajO^%gT6\EiF61#%WR1E1#9LRThE?
aPYVciQ-E;YA>$4`r2ji8m^oh8)M"c=Vt[#^_uUpcZYC^@dL/CSQPOfF[MP;b`6V67DU#/1s
g]A;)_]A$K*l"IMdEY&Z.[Y&_,ebE/3dnm7"5F\+L&3I`^oj3@ls%mI_3g^oFM@B?iR2Puenc^
/<>'>Y;JX$lh*k&Hnq(Is,]AEW3SN>rEs$$rZ\DrXQiOL*(kN3a(oL14)P0s0CB(]A/0Ta0"L9
(K#P.cM*97mIdBXtYj6J]A<aY"7KV3n@f-@]A8$\*4W@:@&S-Cc%Ghj#OhZT/1AVK@QJU$eF`!
6qIre+3`F(0-S6ggW*F5Q:q?DB"I@')TG>qCVEDf\Qu3c?;o.iDh=_d<;PbOHPi(3oscpCM`
Vf`ZrO;c%Omm`p3phe9;7?r"Q'EmeeK_OIT]APsXdoFt]Ao(-@N%N76FVFa22ri[E=6\!Ag.l#
/[8`lp+`ZYdKV%Fs/>b9&1SSp-?f#e;]Au.lo^h6-mBrm\%Jcab#>/`u`Gudi1l.pM<-Gr_.T
dnCi0.4;b:!_NHH=dMYP3KWX'gjile.RQP3%V%'CbjA_DnFUpUUY-n)`<n^2/1HI?-&$-=5#
)2>;W[#Qr(WR$SPI@"UGuET/Ib;kr:ZcW9)=Qa&P_lKZ65@/`nUtren>#"7OgaBl(,_J]A2)"
Am`VRD!BWd7I0cGN1eE)AUbH:dK3>=TD^4(?acMsSN)(+pjH^*Dd=^;@^?_\EZaS(^p_?`Ue
=qpN1%7<;K(qN,t,a4S_$R+949db/pB2d/or'V[Wom#5-lP+Co84O$>Ce]AJ]A0>'2=i\AT9nP
-*K8\cPFLlm(.M?V4o<njG[r/>qGsPi(5K@Va3n]AY.r66hY<:06$pojIO0T9Z.LG0cJ9*C`H
IgM>1SoU*U82=C9fKM;d9>LMK5@YSfm,3?!tI7/C\XJ'5-@R#4DNu&f<E@ENc0*NH@,O35Ia
R^;pJ4SV0g4[_)ZBd`Oe`7=?)f1/25qm/[@A.Wg8?Y_\4Ju'gjDf,J,@ore$F6@uhjf6i[M,
%-V3+dREIQJP42i[R4GPBm&@Oj\VH-rhC_YjHo.0Dcb97`HPCEG'dN(^Z($r$p0en.UMG?rU
ppd]A*UCe&R=%`13q8;4r6Km&:HIj+]A&!e?7,jKKUQn2nq('3Lim[IA+rtS_*0?&"6jBtj#@`
^TC^5^LZ-qo%';1+rH=t.<e(7Nm-1+`X*oq@Qc9!+qil>JR.\H`l2aOq`q8<G$jF1C@pcCs]A
;"(Gjp)rCh]A<*T7ZFeaeCI1Z-Cc56[T+,="EJ4qgFn8JE9<VULc0A'@R)hol0"#r#0u0KTAg
tAm9^l30V>6)-k6#.75,sMDsW28,ol]A)9+otOm+!r%>@b#^h(q=/hUX<^5LjjolAJ3%H6iPq
Cp]Ar?TiI-GoeV:o9l1C#9;+_>2Q>W1`\U,">bCU6_W4r..@*!5.SRN:WdQ"c?6G8V+\YAW/Z
uPt?$>V9]A%?.jl$f]AVe0_c"mGTJtYM;>2[;jEW7@FT<!&p<ClrdIl<ZjB-<]A&^t@2t-lNM6k
I4pJ3\+mE'sM9EQVH;eai-KiE8Q"Y@m?@B[[.+%8>)#u6qZG%,Rs19G*VocW%I%77UIFu\+V
QD2$b)i_HY(gR^?/=/65t5c*Wabk2%K%nH&Yj-:X+Y1e;MhD3cZ+rJ9p/B9mQlU`P1rY"]AXu
Y1i--)g;f=frjD!q^!SPe3(m[+.n_W/ILY=V%%p*oYc.b0Fm!SVPh7)iUDr['Y#=D7HUmU_E
<DYJ0mt>P:jAN:T*-_Zr$QS9+4`Yck!EbR-;mM),]A.aucAH4U2!5J,t!2ctDI;Pa*:dO-U]AX
q`_<S5fmf:JsH(sL5DC[=?<%_s61gXa"`QTRKDL<4P2Vq>AW-?@m/a<-Ab]A-gqX'j,=bmFU:
ZJ)40bW6qp<:lufl>.M7?kY`os@\U8XRP24?`7ll2:MMD\'ps/L&[>VSHkUn1GNQ8MK?^7.$
s\7]A#&O)=Z(cpsep2&F358D3[\E.@2_[SZkLL,2$8abrp,NR`5cl>g/u[C#k:^4l/OObL\fP
"sZH43GCZRg9_I7-f9!pcS@B>a!ZXFYd2C31(.G`5rA?PDdJf]Ao.9T!,aPWh([@=S!g(;[P`
1>*sWQS\MCc<L[Qja1DlAj;V<WhT2<R4a6g*u4\O.FKJQ*&NI!j,KrF/'k`Y-+LBkiXrK74D
Z!7QN<t;2nuY:]AtPo`2<8*h1=1jnb/h=!m<rLpbGP*%'+fO<*Z>aVhU$RtWTT2d&;R>QUZoY
fRU6d17g3:7Oj-r^cPeeZ=^eeLd*'c&?C?$u\\J_"o\`5>M,u4V-2]Ac_0,a/Kp]Arb:9fa.2g
'WLZ9/RGRLm'm5NA#j8<*8kkDoS4A/kHD:[t=)@jOhVDn&e\P`0JtUb",NuGY,JQfdCr[kdS
<FCc.<o1_n7%<Q6PKYC^#4@">Cj6jgihhmaeCD^fJ6I>2Ys)X.'lBY=&XIb-]A(H83:W[:TVc
8Z&>3"ai!Ac?\_k`ITH.N_=WYJ7m82:X:5a(u(Jm"d*p2ObqO(f#lQ4:21\27I:WFWslOior
H))[n)(_9I#T$.E5p/pQK^=$otF<^bjOL0+bYX0-G[H7rRDH9#<l5$VaE7"a9J6LLjG(^2He
fAb"QYrO".cdr0l*%!:Yr?C!3CO`ai<5[;)n?B?+MI&oN4gAs2d7_r8X]AN)tKfCE('d.a`"f
%S8AlDb/-V/r(;a5n^PDrg$/<!Mn4iuB16qK,;k^\Z;#r.IU;J1'"k88,>RTo9U:=sEe^j)U
TW[?ShC@bbJhQS%ktqV,r`4r?KYnZT'[,OoRJbD`D4oqPgKBUhH#jpes*TT8@>%5WV@Te&E%
;KTU(]AP2lH$8KgA(LI6\^&F$;^p#2E//ep*h]A.V,*V6!>e=I99hVNB*52,=QZVpb`BSMWk"R
m8l)Mcp=GtY&nWX6;9;LC=MQD:JY2*EY>9E.8+@0n_oWAq%k]AP=\O+d<"FIlu_3d/06O%\Q1
]A6@(_bd/q8\*:bmPYEmBQhuenkDUsi?oB]AG_=W-oRCd$E[H4q9tPt>bnTL8k,=hW=8\n;I";
op%ESs-O`kj6E-TE?<H.t40)lX*$g]AT<tmEA-@gjX3Jtm#R"3'/+"2GH9Tf_10J*CJ,,'D6K
k;qA@,PAEs4_'aRH0S3A*ZY2lN0P<#Z8%njXXrAiho]AN'*J782*X</^&QiJ`/N8MubJiZM?_
H'@]AOnVRK^'Rdo@/c/1VbH8@Zp?XCS<Pg@f\,JX;.rq[<D36l:!"-\To8/_A-t`0tUo?;E+t
sKG$rQ>2C6Cuk5*2tjrfWG==Im;N#dSO<Jm"ft5:2c8Xi+S!dN1$'3#i%nQXdMHp]AR8/Pap(
C7&Pq[g,Jh_M?R?LnB[*VJ2G)7U(XZTC%D5.r8OXao-SJ01s>6*S.P!ZDAKM_daT<80\3Nf[
rp2tqP3)LA$N'I&6kV__:5-_acFVH8L@a]AFj%9)dp1t@/]AXu?^^S-c</H$L)tPs_c@HMgG1m
nt+ah7YM3#%.;s<CqkNuN%AVG^S8Gq`fZc6D3RAaj5Q"fN12-otpVcaLZc<,lfHH`ZT.AOYU
=ai&lqm+-lFAtFU2^bSE6CK1D&gp$L''gO+]A4ZD<o(</%]A48iBhpA'3oSZ1$p`X^%_;8qmN<
:nP;pe;FGi;ebGD<)R?_iDs(Egf:-bh/6(GHerc]A*aCs#D7RckO(rOK,8m`fYjj^p6uBM/L(
SBf<5fP>beIH&^j'Cp)&6>=6Em()g^B>SplumWei1XJsF'AgTIf<RmdrHSKLpas?u16!_!7`
XQumL]A=/Z73:NN/^%o$A0faH]A+PC*&R)oLC(Jh#3,KtM$MG(0:]Adk&G"*aS&YXN>JQeJc#(P
e4\h7rDVg3b\kL%Rh8dQ^bcbTU%rb_/*`sTA0'bd]A1jY;Tn:RTA%>e]Ak5?91\,lSVC'@.YOW
$QZpp5pe.MO!_I4Y8YOpApLU5!d_9632<NCAca3SY,bHqPDQK_LLoTL)8(uODF5M;Zgdp.V/
XO6i<\']A[f;X)beVb+2dY;$jNc^)oE22Y[_&a1r(6^9PSDKZVE9W9YHhJ1*BXBp+kB!l>_L<
\9m>#PiN^M7lg<dpLRhP%,jM]AER0Fi;P/rc9$c^]AZm9i@p#bB+4UUP/n1M'YUNbid!iq^^C:
u'gdo2755\=PTAJT`/WI__Eg+S&PSq-0f*:2"o.WPDIJ;LBgb8-kQL/<l=Ge1kEdkKLJ'P#p
Z)+E&OSABI"F#mL^GOZPO!f>YOg_?&^!C9VqXW[X#-m^L'M"pOa[WEF"RL?s>CbE+!Mp0qN8
V`<beR$6`c'E=`9nrHrWL()K-!h8!@4W9ItaPbN?<,r)D@8kcS5HKn=Sut\OC`B?YL0_U2_a
/!mbXl:);oh+BLGnt$XfTC#DaD]A?)>u1NXKLc![ktXdPPD.(?Hrt?oKB8&=A835'+4tP$>KM
7KRC?i752WS=;oKeWH:57@s4^[qpm6^\26Yc<]ARDG[!^?6&+34WiDs;mq[:E7MFs/po>BprQ
+l;<UXU0tF#f7jD:cYDEq0Hu@L*e`du8ZoQEiV!'sRb\\p#t=+]AIbpOF@bIq8i,s?9cN5qDZ
-I0ui-Dm#P[VcV-)KenQ6nn1APP5h<(=eHutRYoapU4AW:+?mS0aZr$o<qY/Y3-11P5Ja@a.
'qMbO>-Cm6o)#j)+C?*/jLNg5c2V>ahXl=/RClMggisj7G0\ndM5%D):;9gjU+gj4QI."F6I
/JbAFI7op8!"A^:;13`=tY4J-rb'a&ZVEE[(a[C-PXP[#.Q0\^UjmZ*pAp-<BZ0mr)IDPU!Q
B!Y0*uF<Ebk'gCdA5,3%+^,?dkekgE`AM(_V)Fs/,=,uBDG9NPZGA2"tGNhal,BQ_X<NM_+@
[j1$>d0jSbmdrj#<u:`C1U$V&U;91X+$Gl'XO/\He@gNgTgC0Q1I-J3!WjK[l%`>fG5g9_DG
]A4<1Pu_Z/J%*KdM<+pae+Do!4Qpmf"`_;-#$#CR9-S;&S7'DFZh!lSd8TE*Cn.0s2`J7=`Q,
\p3'GDD=$LQuMk7\N;%lJZ[X3l"_Z,_^;(@%t7>#f_s[aPgfu6On*>;B!J*C+p:pm,\Und<j
C(1=Y1EN#(8Gk]A&PkC@_;$V12BAHd^:tQHtj@1K01LdpV%l:MsqE14m*L<2+Pl=.i3eL0K."
r/O=:p]Ap%8Ekm7(GZk=f!WR(.p4XYE@r-1t`j#+52PX'L%U#hmCIRS7b;MV`K+&6-ioXFBol
A*J9Q23c0Ss\8,=B(@k3RDf[$oIY74C'_C^.D*JYW7FiM'j!t/5HqM5ZmYq<scn.pSjK$"u"
IYj7YDHB;,/k6F`Vh.KAuc$+=:@0GTqAPA(d/P@)fHI)jVNc2lAqhT,MiTJ=Og%EahJr_c,p
+k+rtab8k:2^lHUQ,`8A"n(<aJN"'&E#hR)$RU[)nor<8\`;lRJepAh,n>AeRsX$';snp.h<
(@6<usY=,U<#h(PdE2X7c</glkUDJeOk)+MFdB6Vh&6YC*);GRJXUpgCX;[VW,B^*iFKho`P
?"hHGu\UNQXE'4XNQ=;gg.eX<THU$A6UrYnU3(4H:q=0GSG2#an*?tPmd5)=a[E-e&lCZF8.
?jbu[+_6EAQ@uunq1WTg/Gg5o\M`m\Ad*%j"C#jG&cNB<i35T3S<8_F(]A;D0nth3a)1lN2`)
$FB\i<#bE?DkAE8(oWBHQ5OBDZam'#pCbH`G2p2f(!G7j\uR=.()pX**(CU-_<hW-t!iZ_%#
hq+;-JNm:gF*)CV9S`G#",bl%J95LCjdjEu$UNg2gWs9AZM-D96>k=N7>E4R5V(k08G[%J!g
UYI`f\K7L;1["GJq5V%m[n*p[l.$>*kf+h]ASR46)C8tlNqUomK&[P.H,G"Z*cgIKnoi:_0!/
$G%$37KP,><>:rjt>8K5,#FVH06$c,EeZ06A$FJY&6.<5#.cJd$+\gH%lB:0cUaNg$"u=3rW
LTW0)P0,Yr+mg"RHYDE0XFof30lN(k%8,<f8kF/IS^Z>I268g),o&$#,IDZPQ8Vn"THZX@]AV
fZKLA>,$<:i!"[gZ56M8<hY+Jgf%l/q.EnRK?3Oas6%Xc!=*NGW6)AXC]AMt<%@ES5AOk(55d
BX:A?7obWJ%XkbYI@B?jD[I\Zfq#B\'qqgWlg*Fb=XW,ED_5me3D/niq-dqKqo_W7QGC(`^7
Lu->\&1KXEq<=o&^egUI5FY&_>`QXLAp-eF`oN,=2OFj=SRp%'7c*"jSe%S5rbMjYkgAitS`
F1+Pq$p*57)E2,hCn3.sFc_FfVCe$.hp9EO/TB5g,^=&G`l\/(`$JQ<b5#*S]AX3`ZELg0ltE
$[#L(0m:Xo@SLGnM#2dTq>N)oo&Z;d"ejm+mYkr=gT.2f<)>^K:%SCSD*_hq?7P47Wmi%W:N
&AXe&F6gljRg2:MB_7Z0f<h/,'co1-/o0,GNiF;;>m!0\aB+l+7J2ohT1&)<j[N&<!tFFC%B
Qur(g0d]A`M.I<"I]AN=nJ]AR'@g[a*OBH5*)]AWi!l7=)`/l1hsFCro#:0jJPeLNjJ*$<p/=uq<
0c^M+2'HSSr)Xj.FNFi@_OI+[4%aB]A=9[-(sE.r>TrJT6$(',?T-1]AO$pYGT%WH_1l;P'"AL
E:<,((%_1K'Uu%%_Fe>h,an3MIe/Amj>YV<*Edg%$3ET?:f_MNXhrmu(g$t4e-F>tEf3#bjD
]AsPo`RqjLco6lMM`8#_$<7BD43qmYUWZK'Ma"WP>qG!%bk/Tk79--6Eblfr?Fh&Ue@pm"JrP
r1s/4L5I691`,Z#/6M]A5:T!:?(PN^(@jNP5A&W,%KW95@\4D<H-1020mG01Emf"'hq9*9#<8
aYK22H,p.nTU>&1\f"dA?"5DC4lbU6131aU6/U1p!ZH!,4Q<[jgf*R&;#IpUDhR2\&od6lf9
luQ/,T,>p:s;nUU(-.[4<8ke'K+V_n!dUiYq5I"u2$IS5Hao$0SC2LMkhp[;D2C3+QRN-+)0
PHd4*9D-t_Wg4]A;2"UI6U2Ge3VUGJ4uCN9c1,6ko@O4pR.fucd?GS/f!mTXtu-\s/\`pGA-(
Dm3PfLEZ'6OPr?bE2j"rIJ=DI-:4)<Kg[!5GUh)fW%YLTI's+noOEl\+H^RKL']Am(Ht%.V8b
r)*O[Va<e9\@aT()F3<+VVZ]A.!,_@=@fe'I8@qrTj,e@3:/1u6q?gK#4k_gV$(@GI_r^mBC0
=!om]AGM?p''t3lJdh?nr=4qk/LLG*hP.M3?jQJ*aWS#Be?+SciH"s%LEQ-fjlFK7@qVi0Lf_
g(d-OufS+[egJiG[GKV*njGJf6o(eH'toIa#*b+`e7N^iJu\+u=(UUFWHLDR6S)_7TjKE"]AZ
_`)$QJn6jpYs3.;oa.%5U&TUYakZ=npi6ArK.A\(X$t'V]A-I<P8(X<,.Li/VO^M>MdGKkt]A"
8rALQO=TZdT+6/XeRHoG;_r'p>Wa<9IXV*O/ijE[,fN7SDWV)#5t?m*j+b^/[t%?QI2c>>lf
mT^`FeCT!iIG%5!n-G5EG\1K#'e;RR:Ck*G+4i%j&f#tMZ<Zu.IaYZp!7UA53*ZoUX*F#gQs
bU?suGZ[=_]A/[+uVC7u7RuVJK1D62``+@tbO'B(ZqBDj80UbNXDPcR1gnagWU_ZVG`t='`BB
[CU-.`5=iXrJq]A!!*A[lJI;^(*"K'JEp)_eg.(_k0+O>LO,`^i$MLIFF"Gng3<up'WPGV2Or
D\^u9'>[/HWk7:n-@qfgJ5C/L;n=pIao`q+GNnu4,m258\q;"jWi,IY>^OADHnu[VCCg..H'
R-E.=!,\Ph2Kp7-/7#G0Kt#c2?UC;1u3X#S>?qPnf*u#=kQU@Kg$7aj2>a,@q$:!PC8rUq=^
VA]Aa;UR</F6_[L+@&!QD>pW?=VOf%fP%O`asgEA$:`*IbI>?]AQ$21*)?X>d9[@=]A%&4NuY4)
H_0cSF(``lAY[t'!<Y$1N&6,9ZGnM,M_.ME0$IpKWT6GUDaLP<.T`6`o]A^G+N;M818JUKM^g
7PqUJDH?"^lXa19Y9rqP>lN&8@4rRQAds&/k+VUVH-1kDU,ib1!a2L1.9?$2A0n33oRhjBOf
TmA/I2@>p>V6@"q=MAJI(j;)Wm/.;W1CQD`KiZFS[.&g-mWqJ]A,6_iaq0MbM7V>aP)-^UqJ<
AStq&tphO:J3$<l7D<SB^mY.1F@Y>&9G(,Z-f:d?R`MEL5^lY!"mu-/qJmaP!-3XE]A(kui_8
Z.>6QH.hlXuZ(-]AlR\,lherq7.Lqp]AeK'qFmUN6(+;ppHN0eX?6!kGR:behE,^Nb9*CN.<W?
+hh`B#Z=aN&qTLSNK;nZ&3X7Q[hs6kB?<9o]AL&gE"\cRJ>W-ug?L`T078/[_'m#[Op#:Y$8#
k7^S(rVr(6l*KYpsW_!<1CjH<g1+mCO5nU8IdRpkEI-D$E)H4WQ[BM8Z.`#'L2D"l2AS!L^B
F-VDXp=Z2m0Mu?)#m'#c4PaAn3g-4]A9LnraTkBN]A8@PpVIG)^*@WE(tC>'dJ\XkhX`M"t1'+
!2"m8lTV9I`m-!8fhGm=YXK!\[4CUa=ML-4`;iK&n>^Rfr&ljdfg\RNhm9a-_uKB[iAk06$]A
ROo]A2LC?oig!`K(F"G`(k+77+onnAXUC-q)%qE%V>2(I`CO(FS!N9-)8E+kq/W8Ndm7,@f*Z
iTk`K^9W_d['t&Z)^R:hHi9@(C+Ko@aj).l$m,T#?4?[=g?ar\qb"St<dS`M;-biBnYBgkVi
=Qk*7hRuBsbMP2Z,6D=)o08,[dt]AXh9"jq2B_<&<Jg;M?^NVB/)K9k<=Fe7Q7XQ2R4$N[S$R
uk`!ZY"Z5:$:48.Ina>=jXI\S?LQIr[_<j9,-bQ:YlPq':!8MmMIio9mco5M/iH\m8.!nGW#
jqf]A0>.c#9sg2#3_`r98k`P@StL-Nrcl=A2\CZB^Ym:OWQsd6.2s#Ti)Cfibh7.8T[5`CD>_
u_<nkeq&Y.6K]A*J>cB(=Y`X=(De.6N\P6u^-5;l;7,@8&,.Y8CG=X;*F"GQ/.]AB?=M[a62sf
3aoe2,]A=OD,JN9/QFM)#fb+E*P[)93V^pY/r(C6g"1TqR&QoCIrbcq99b)j(!r?.BD3o!!\C
E[CcO`>9VGa\EP!G*oe.6=@Q+?('4bP6`U\Y>^6DKH?0M7NHV.!/`QHJ*EZ%58cL"<$4W`GB
F^?U9NP!k&SkE1A"s3g9;e.pKJ%5ubUZS(uNq<$DM=L=Eu8mnp8<2qP3#'lh)ptK2/M$A-op
uf$a;?d-^)G7%V[CC,EgEd/[UTl")1*)ujT<1A70*SC8R<o^u5.,UU"K8\na4&G_O0rW?;+5
=G3Ot5o%_1T>Gmn[t6rP'X:23O(`jK&t2G6m%%#:QOM22oOEcj)!G@Ij]A*r#+1(':Sg,\2+s
jb>Ic`jVh&PeW2c=FTWIRQmQ`EU2q)O#@.JC3Z$GbE\EG4l/8O"nNSC[qI5ODI@4&lS?m9oL
`QrZ?'T\e2==@YKlV(3\<UJ?b*2O7O2lI0:*NH[bUs*2]ASkPm/O%W]ALXI*,Q"4`S)?4icg6^
QGi;^c.d\?,LkP@0e=6)S\d=ft2u47_5Rr]A:W;YomKDgAJ]A>=ZQ7jh'dX3J#l=%pr.W</2WF
_FEI+$nAX`[\P90+$)hpc!V\Arn)[p'mSIkD2L/WJ5"`4.="Y4LV!`%b@sqc;NVV5]AMRs6;@
KgH:>5S>S#m#X-`\+R:%B2)Ot0n4G7f\MXL1:!@PFhlrBF[otK9Sj.qg9%6U:NXmk\p2$i2C
M,2G4_oP8JMO(XLg0f:jEkk\QcYT=W52I./#dD4h0%DmLN"be03t`0iNVgB_"A`*6mL1,,*?
N;@<5O@6n\0$h:'V47&h.0d`mIXl<>i0`GKRhV.QFmt&A+c@q+-oLrB7Bl!W;lWEj/3[GhPK
urNG:W6WodnT=iR_j7gVDiN-9&1GO?M.nqPa95I%:LQ_?QMj>0dY[[3n9N$]Ab]Ansk+VpLen5
SWOno'ITkfq-_<OY0WSk$:fq35noeLp"sPrN[ro3BOQgY(ma\I3.j;H>QbSksE8$O(U=/@Hf
iF%Kj8`@UmG%oo5$9XNu(B4[)1.H7BGSPkWPgc2Rh~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="4" vertical="4" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="100"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report1"/>
<WidgetID widgetID="83ed78ec-be24-48ac-9056-12ca3874bbfa"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-10066330"/>
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
<NameJavaScriptGroup>
<NameJavaScript name="图表超链-联动单元格1">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<JavaScript class="com.fr.chart.web.ChartHyperRelateCellLink">
<Parameters>
<Parameter>
<Attributes name="分类"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=if($分类 = "year"||len($分类) = 0,"concat(year,interval_info)","year")]]></Attributes>
</O>
</Parameter>
<Parameter>
<Attributes name="year"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=CATEGORY]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="500" height="270"/>
<realateName realateValue="A1" animateType="none"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
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
<Attr xAxisIndex="0" yAxisIndex="0" stacked="false" percentStacked="false" stackID="stackID"/>
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
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="AutoMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="solid" lineWidth="2.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
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
<Attr xAxisIndex="0" yAxisIndex="1" stacked="false" percentStacked="false" stackID="stackID"/>
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
<OneValueCDDefinition seriesName="无" valueName="当年非计划拆换次数" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[ds1]]></Name>
</TableData>
<CategoryName value="分类"/>
</OneValueCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<OneValueCDDefinition seriesName="无" valueName="当年非计划拆换千时率" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[ds1]]></Name>
</TableData>
<CategoryName value="分类"/>
</OneValueCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="ddd01cf6-54f0-4262-9228-28093a2f66c9"/>
<tools hidden="true" sort="false" export="true" fullScreen="true"/>
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
<![CDATA[be/.!PNgXV5',kF"_M:7RS&[HdE;Ls5tXT\&O\r=dRF;4e0$'ejNKRq&IBpmKT+=^KM4XGJ;
b(re4>c5L<rR;2*fma$-m8R3Kpu(qu+8%/cNl?jM(B%bI+Oen,5B=<gKUiM]A<?)m'G$P2S4(
Ik-NCJ"F^!s(C0^%!WHY;bs)*P5-)54G2\rs`07%aKHQ\6m&CLc/B[c-M0%5\CA31a<k\7O8
bHC4?84R\cVp[_:VS@sgitmH+?A*3q-[(:WM)A>ngT1#_THWj;hM%Sa!\7SSku%U)3KE4:;(
`KFNams,r5>nF\h)+,4!T@,Bj"]AIcQ:=EpWN-?15mo]AfW^b^.+^Nl@*[J0-:hQ5fDno6D?Ep
Y$E9s@"1gd&C]ADBfm4s!r#kG!ip.$5=%R`]A8(]AaajSm>XQH+"ijF-UuhMh%Hr,2X`1`c;eU;
6'O^@fMOr(J)%oB6')6`b2mG,<k"$#UX[S!(_i=EO;TMs[G3q`g5`2N=.jr,6JdJj.$:r$_-
tJ&hV;n3\[W:1X;&,''@fFj#EHiR-o/BiIRNR[PkQZekQKjT95AV_g[.g[RY^?QhSM`(R<P+
K>JUdU80jTQ(Y)SID*&`b%,'.:bNrI?eok_,PJk55]A&pV.VV20>81D*74V\"R?2*IS]Ar$/,b
f%m%u@hKCN#6d+1<JE<7>8q:9#ZD*0FI=#9F(.ql=-qh?R"A4p.s5LE&k;P#DG]A<.EZ/W_*f
hS!MUXMtt_bFYU*EMRJ,/<1[lqOMXYK!ufA9YsslTIdBcA4ICVGk&a:)&O+S(@Lua4?;X;-W
L+PX.qo-o@@c[moFh6=Z,p"O2!=uaD:.og^\4j;3Z[VP8*+Af>M5W\":IgH^>JD4?o@N2AN\
&77H^SPUbW7Z6[HL"p_-k`?H^!bB[t,hi[Z[gnq6JZ00,))T:@&?St8X[8o_J1aC95[O.Ql0
u\(M08H?PPDhX=s%3]Aj$eU)IF_Ej#G_pV<Po)juo#/Q8D4Xp2Ws^%QLr=.H7SM99iJ=m1,9T
O_%,:2-Pj+r@i2KZE\Le<C/h[CEACR5fRKE,Klbm[]A\c_p[n2ul]A1o7hiE^4/KGPtRKa+r:h
\1?:PY_l-/@Y3VNJGnX+rqKl:INrYWrY<r"aE.=?!I!If[c/[-eQEcmbrS'AE9mH%?/s</h@
EEG5k*[fQ4ktVXMoJ]ArMk*_nnDK9pBKmCP!a%>35=m*1DbQ2WcI7bOJ+BOo(GAX%_"\Tik(m
"AUON:Db`@`0=m0X4H3,u^8pMMZR$/FZ3mD<(#1Wgo#b%T3f&]A+mCcRm[n3$pX]AKMU4`05h?
$eK[m:]A-Y`\;8il%?e9p&cee*Fu')BP?hXDq]A%P6Wm#aoQ+=S\(`[jTf`TNo:#la]A*J-:<Fh
Z\h53aii!ckBSh%L4.+i`AO;G\+1i:g4hgGZV&\,IKK&RhB/t4lPU"#.\oCpo65\#8ZH'KYi
#D0Ft#^e6'n@q@#T_oD]A)LboTaT!4+n/)U]A\;^hN3r-rX`c!VEHL`]Ak+8-`PjdVisn]Aq1W0`
:W(n.1k;Ii>LN-ag\_^AnK3Td5@]Ai?e#D#5\TYpU`R;:]ACkdG<\'hSYocq(4PbR'mKteoBTI
br`ASDj_t-"1oWR9noJ`gs+/&&LNdPbn3Pto-P[p]Aa;826T)W`o;Kr\$P*,8bS:@L7E<=_^;
?s`A?.tQ:OQ<VFc\N<+HH9193P^8U!C%P>q/9D*!lNXiIM!^lrOusOqX=.>TBhZ*,)G8)@s-
tts%$4q:?Vqliq&L2GK'9U2l=l_L]A=4tn_`^5ZNL!<_,'it,%s36UOs22mJA6J#KC_;h1Xb<
3U\m:C)I=<C.`(]A[).KE^Dc\h7ISfBE_E:.7g+!gUYS!tp^;fIjI5sT<s?q=Ku(3\D-K\dMc
c_rpHCnbWnY$`jhQlTjh\\&Jn8!27`\Z$H;,9;hCN$em']AUsnnT>>V&O:3SY,(Hk?kBhj!H`
-EmL@u]A+J]Afd2`faG:uM?NZ.M1)iArG'@!af,AsiC6amrm`lCLOfH`8j_oZ!>0VHJp%e:@ZC
EZu$42i_[T^-6kZIr1/cK!(nl%u04ghp>tcF\%3W;iUPmmR8tC@SrL.p$6RD*9*^eEOp0r9N
tPSM&O16bcIM%7B0(AoWu]A78;qT*CjE]Ag>6hUSoNBkK1qMY[1jAk]ARm"8'*inj1(V**$nG3`
d_T<1S@GY-^3L"U;*Sp)74*42)/udm?TrWB&7>1VceL`>h5*g.Z]AEWHUW04of/d!"Ak'+2Hl
U=s0c9j>&Wn6T%F-7snkc5Q4EX#?,W[gCQ_p!0K2Am0O0`a_*sd_e[Z9G_6^-8N*b/"DdU;Z
L:MQJD"Cr*jND,()Dpe#%.Wi5s,)O(bogUV>1M6ne."QbfZqfEp==fr%#`-@(RJW$+jG>dsk
O1..Nr)7a%,+sQ9(GU,3o!9Q+k69-XdbRt3)SR`,]A7-(<'jVQH6<q)N5IH:j+FGQQ/VD7JeU
u0=Rhl%$&=Hmas(_qW#fPGVX*(V5'g&0UBB3O5>q@uU9-g$mBh;kO/+uM(o+=4YTCBBj64-2
Q=$KB8_qW\^\Vn6288CBjjb:^m'tHP+5@UlZ<GZnEH1MHi#n(sB-;,g<j[":=C';]A'Jd+-41
<F"5F1W_BmZ>bb:9c&/,s$LSJF'uHKoT".G4BRD-Kt,lXGYWW)nfhCOF5s;!_bNOQhf_o0W'
,-SK_lDu7ka9ji1rf.cpGl=8)VV<EA%!1c)fhf^Jog@a3!/f!mP86ssc.M1$66:6'S2=u^i,
7B@J426a1lLp(RC55290Z$;h.kB*;(5rf]Aeb'uAkGSt"T<R=U!VfWO0+\IbiI^REML+KdNm0
0Ze"d/7:->mBj)+V0>p)=)']A?IQT?=)S'>rb[!ogrE'cd2bf("M!D&^rNaC//]AWq66PO;2u7
DD>ih1-r3l6fq'GJfd9:M,4lD%;k1h<bqMJB))GNR9(<ECT>@tehAT+JV$q/Ve0%!1tLn#e1
g&ZB^\L+PhCBMa?"\`/+5/JN4<45O@Lg??Mu"iON\-%Y.a1AVV80'BOif?'t/i8A'0'R/r]A0
4[)3Vn`+h%W.cIdBDh9-u<Y_YU6<H2D%Tq=01^4D9LJf""()h2XBmS'0[;\F7+MK1K3Uq?7,
s50)8V5"X",^F[N:DR(hb&UpAaEe"b0;dkOu*u3WH8oe5F[0!o:i+nnDbT.c%FAUcI=k"YUM
CelGiH:rQ;I/>m*/u+6)5N;3g?F;rB2#PrU&L(HdI6``Q*qr%%i<5=o>VW-b&lb5F8?4]A;B@
R4L-:S>&PL$bb)NfU=k,#pbpd.!O8[-Ch/rkm;DXB=oEoQ4c;g$_Fp-B@(e;*aJG5Z_<W6=,
'+:KoV,/]A`2([hZKLU_-a$M]AE1'V9S\nkA\(@e)1tqZ%kLC:oTj3h4"h_9i!X42S(Q^:U6!T
()Xpf)a"b?ChF"8*HNm*e&/S`j3QngaS10@9UBu<\BbPl'^p31iLi7W@B0[5jEZ*("f(bE(0
bo(Xh@Y.+;dDS;RUGoD$fP@uo(#kIT"uuu[)7<dJkKg?$sEOj3P@\E+`W>.^*7Ve:eA)WcQP
FL(M@WbKdE%F)53)so!II%plbL4oB,*MkhH;m';lSf*HGGG=R&.]Ao^*";J6`"S>X=er2O)Em
hhJn[.Q[<E)W6.a$Mq]A^e:\bbI6j.kK7EsXF#Lf$3Bu:PXT0p=oc4''r2V*_,ff$S^oL3<qs
&+t(%7nh&&48>7\<nDWL*#Y!i5UF!_pJfmtm`6*7b]AiOk3"B;`fi=YCWg6AOT;#quskdjbH/
a>6)AiKq0$cr@U$_#s0i5/)S<MJKJ/2L5&DtmTB\595R3YY>AZ7fi(lPj#&4je)Rpbq%k.DA
UI=l=6,YHi)tO\nf&^aN7U)>s.(AaJm*[$h]AM8L.G3,@B>,lFK7qkj8=+C7(\t/I-sYEeRA/
cT)gQgrq8W@Tn^(;uE5CX3h#&-WAp2G\HUl06YMG(#7?q4N@UAQU>7e67\1@@"*PO9Vg\`t(
q5A"J;>PcjpAb$(o.atI8f,]AAR&j-Lg`FX'CA^R,<;s.YORh?0ahn-12Ej>(r80YJ`BI#VoV
N]AtDQ7JqRK5hr$RXT>Nj/)oDe%JQAoghfS9'PFDkX#nbXL6X'SN!qUm9@A$IK$Y8B3KCcFA=
J!C2p)`&7<mV*c.G(4IAhd4E='"iXCUe5XeDX46SiKdlUs6F%J>8t+0$nR!=O2oSU/oYu^V;
.jI6^V9i^=*Fn(lb>[Q:PT&j'iriq%I4R3G)o[@]AI3>"r!6+MFG:!U=hQ&>8Wl^oU*TI>0OK
q_F_bR"K[8%\a_a%fj!Suq.X92"H.J_%G:oQt2T0W^."j?;Gu;'7EH5]A:bVuZN,MLZMqF;-O
Q:r$T?KpKgN6@^(W"I7,gGUQ]ApZRa]Aq=('`QKpHPl)C=U4&eK4Fa%L!bB$6!`ie&jOLblA2Z
J(FaBRQSU1q08fd2Dq"&k"PQnWBH87KU2K'>1jYI;$>jr;^Y/r-"t=@aB*S'2<0#4$01<M`J
IH8>\hR2=Yor!l']ANs9t5qGA74(El!()(D)eI@;&9P*juHa#$J7R;_:WaAV=A6/Jt6!pWTX5
bsB;1a#\<i/m_Pp]AK^na'd#6FjOUFZXEVG(rJ!1[@T#'Jf>:p()9lFUSr1aTnqqRs,'IC,JB
>'OjTnP56CKI4Q>n!<]AqRdgqV98%X/*Ne.r:a@F0d]AJu`)W@htSCM:75p]AV'nO`[?NDkEBn1
Z&bV.KA>r6l:9W1^bb&H9N55u9_#*(nR.rf)fE*M8*f/B_q""0#0`\BaDK=uTmGj-a7k:2a`
dc)Gr+[G04KfP$a'"b%::"lN"2K?Kn_Pt7D2t]AE7DJ5%9_BUmg34WYpAJm.KCl#3^kdQ_-#H
N&]A6jGm/h;<'Db*]Ao^G4oHW#i6;P6ZJA4:&pps%UJJAkTGg82J4+O6U%1Z_"u+0"WW9%a[Oc
F2fTiafn"Yc&jug)ef!2Hs]A<Bm;1!h`er"3m'K2&AZMi5"as+XVhPRc1'"&k5^bu,&4g-<9*
Mi-o3Q''uY1q$5QlbZ-o9-C-^[Y;F%[,O\\s]A&V<EXYq(>i0h\oDKYHApQHL=Z9+gOPgqk'\
$ls8jq3+)-IH1oHV3eqk-7O2/oNi>^\/.WnpNq4EP8Rk=8),.tN,S-="q@Mi;VI67j)Xn.7n
!KcLYqkG4Lmg_Gt%b;]A-`b&hlBL:cp.R%b$_)[XJi*PD.uRNjrZ`3Fl*1<s)8_b?X;;Wfg`5
B?r0AFS)?*$C=pVu##"Y_g-E%[E6s.;l&[&C_:e^OH"HaEo*Sh'X&fB/&&,(9(tn,Y:Ll0j<
.umJ?b/,G;I[8(aF^.6@pE7?!u@"ZqNXnY9J^OGA]A<'GJpY[k).-b:JHBHg;SeGs+t%-a5[X
Di^>/'_n&#>O%K4(0]Ao7m,MjESIj]A'i2AW6uEj0+11[U>%s`k&[G:4*)T4utpHT%;'rK>bU!
.0Aa-[`oQPNUJHB!3N*-K8lV^3hHm%S`@7i%'At(nV#^3jRnXe=$d3PT'1(o^pgWZMLP8a&F
K`SR5ol0pc8r_!,n`fVKL^`/T+uK%W/'NOVK"%kK[#Bo"4dF]AgU?'>EG?oKH'ThlM`3FbmT:
1Z`A,R)$Br2LQWLhJ[:ALN0"8`M*e!AI!s)5knhi)D:M#MfUfLO!@87_,3)XuH;/(j"1K-dB
NU."hL3g@jN.WT"#U[qglh%I-.f*:gGl.^U@]A'>>%jU;P,k4d1B`->r$`"6aKKaKNm1B=Jp@
Jmq88eZ%jl-H$uMgO>Kdji6mQC^D!Ec`cq!uC#ODtK6DKsMBm)+sj6dA'eDm6N%//<rTk2"m
/$X0JMf?QKSBBdDJ1kO6:TjEs,dis5)q_Kg!Bug]AGC*C!6HELo^`4HS>CSH&iI(T79k^ND52
!N(XkFC)TjH:g?-_4$nPik11c.6FOa^.XT6T2%jn.l'6s\^3/CGq!p2*38'lls\5Oo:UZV>B
dq2sBtQ<T$cVMGnR;u#H@NHWhB0DD%3-lq8,AMK_O\'?R4AJ"3?AOX[tkCm<M`:qc<Od_K4f
rPOKcG//'mM;9=,)oe@T6et\Q<u^qf3HjUa,ED>#rCs5.-Tp&^W<a67U==i9$$N,f+?`Y'mI
EA>2M:`2n%\3qn_AlM1Lho./R89l/t&JDts#<jRL@"n>2+#khN(7#"->//[L&1fC^O6gd\u7
5.$mV_ja"fNi21Y[H\O8j\9b%JZuMRb9(]AoiV0__6.]A.pYD?n1CLfF`jmL,pNHudaZmGJ&)A
K[CIb\`.H-_9>iGFO%+s#.qm!(grS1)=iJ!Ir7ofdr(*BHWLkK4MTAkc3V$Db%Rg_'\MC-HJ
Y/\IX"mLm+?7$Se)*,aIN;7pW6U%5/GON/^cB^0]A?LPJa9;<h;/%rpofaWcj7F$2IqkLc@I2
i4h(bEqs,3esV^5i<%.0-u<;a/N4r+t/0*pT#0M+^*(onp7CJ/l^jI]AC4"iD%S:0A4qsP>dI
sVr:<*\WOVnd.Ym[;F:Wob-]AgFO)^39V^WIDL?gLaKfb;(mI2G5RTjcFAP)0g=9k.UeXJtO2
G/u#n6+/"X'7GZtq'Q-:9AqOQ*(?tok7!XZ&5,ZoCijL/_h'KDpGZC_4Jhp*]Aip*Wh4*i[_,
4hMbYU31FW@T\/`1u<;3&Lnpb+)>"u-0l*DQ]ApM$a8XXeqsb,ccQ4>86X=SZ!E,]As5RJ?]AKW
oe5P@FZ+9oH8[#V?,$")gH#*I<R3^*%k.(;.NZo+X4gEnu!%#Am85pF@CVA'S##u(BSU)raR
kB:u-P.73nnDsOEc$VjQSP2MoAHY+$bg<ICB$tT-[T$5V!oof#5lQ$LQuIN,%lIGS;odqpL;
W^fhJA>VNoE_8nScXi?uBr'1u6=6IR^&rjJGo&ZDk%5\0_;,_bs]A\Ch<$o+Bic2n/&KPZ5Zn
EsW@=9$"'u1.n3i;f:O)T>Ze="Q2E4AJ&r?k)"T(!:8V/7e-FQ3]AqG=Dg<-V:LpP:7j@eQ3/
%H,p&!!G4.?7%gJ%tU-nA=qP^Gdu1@G:IH__OYg,b@L<Jt-GZO&1`i'#K:;q*&<EC=1b2ebR
E$.J_u]Ai$UggM7aIi[bMi)(>=%fR9q7OR&4NUc6j6=j%W&N;t9EW.W:'ImB=Sn;Y5GW8BOW7
'?H:J]Ak.gm<lk9F:$'EmRYMYhFPVYSu=dOk1IeAd'<'#AOT9]Aa9!mkB?HlhS^#4(eG,-t-n1
+F8)nPZJ*tD%;3g@[ke(u^kt'4*k4.E'*Mr^UX@MV,bRZe(rSfTLlr(<6D2a`T)00D-"Xq%o
-Q0Wr@KkGe#U3P57*#@*bA*p>-PpAh0U4q67D0ZQ;p,ern6q"c1HY_1^L`bU"`fP0CU:sUA=
@Wrn'0\f7!/fp"@cdKj.EI@-1sXQP*d@P_u=CqBMtkhk;%s%)8APr2>Ts7i?k)S_gAU:(u.N
mD546']Af4o??i=9n@XHY$KrPJfb@@GXQf^*piV[J_lSiT=+'A!3gjt'C1Pg\(0OH2qA,hi3p
(mti5RlD"W#k;gce;#]AH,IHgLe%E#:a1PbADk&%W7`n1SD]Aoq<>6V*$'kjNaDnl$oPTNU<5B
Ir^BXY;phSL'b^/.2N(q:[XS.ZBF,QTGN4KU4=TBo!VK)lQ_F;\'E:$f*@eGG`\f<5>)R$_3
6;UVOFJ0_LE'T)8$W:21"6$Cr*.Ys0>*RJE-K75m%jlTDcWoX%7?obZYKaP[asN0q<l&.a)(
Nc_()Knc^mK"eD4\PL3.Ns4E?rdP\n.l<88O=jZ1l4D&N#I0"\t&7>4J5NkKqEK>Ic_GSYte
DA(s`0WEWQ>$S;P[OZ9Lj^E?]A\j@ZQMXY+-:A[/dd/4SK"!lO9ql/?)uD>,69NKJnbA1g8[g
b0CP)a0>;#k?Wk:^&kZ+&,?!o3gtNL+-4`0@;JMVsl#!FDb?/D5_3:nckA\S\I"cU!/l@nnU
bu=Ma)*3A";?.El3j>oer20c]Agod,lJ[C+h:))X_uXpSdlL5gYG<U33[LN>Bh]A<$9Gs,h/L'
r?5*^rbr.3[d0LB<1k.`D5/TK$+\gDq_]A;c=.Dl\k`p@R9S*:lTk0k5/d/]Aq9VgK*CQH/I0I
&pX$D[8d&$br.f.@SVH=54.I"e/3L76`fkDR6"k<3:_So*h5_:A6@g]AnoVPX0?^^"J]A]AlfY6
BgkjHN_.7rM$G6]A<IE!QID-oNOA5ln`L\D@(VT98=F*'(E:%!Ykl?*ZJ#:Z1SVul&VYQ"45S
?^n&<sq.#'tE0aFV'.gT22D?:5:6QI4<J[JU1;+0B*%+di'AWUR*5[)RoP)Yl\;1:gF_5$"j
GnS[uLX?(TO1LZHZipFt!$lmucq:c_#TE1R*YY55.%WfPTH-J@IoiU9pYqM$3.?@<i<-DB.'
e4E/S*bnHAC$XK^)&L,3G7YpIm]A\4tmZK`s>T*%?+.FjKcG"g5`0'OTF:DoKLb?$>fo.:gM\
nHnHr-sN+tl88*BlD]A"'6Q"eJ%IZS0S;!qOQi"RAKlZd:1^23qKP!DaGp#13.QugAYoZT0ZW
_,S+<,JSAD'.F]AJg$k4(+!Yjo!V"TEIXT@R*KOL!1hgV:Ti00EoW55U@3<GV!-BLN7[VsDO2
sT6Mg<,m%X$""G?_*,@@E*l0#,O%`bWSGKFn<E%fL5!`gIlB&/M<odiHZt;IV6(s8>_pYE^C
4HR%30FQ;EsZ:2Jr(NI$NE=@^._]AC*^;SKLd13qRs+Aj1,&2s9-c^U,t7@XU1608i9@U(jS,
oAhDSbB*ruLoosQ>72WUjA8:,fX+aO<i=2_[I'F%%Ug)[+Id6O6k8-`H.a_5+HHViFng7]A`#
t39@r&X"$E`,=\h&_gV&[%Q=7@bnV1ll]AA*T%Y\1;=E2Rq,R0r>1;"k3fl\\3oaO]A\#1:=>N
Q=9,cF#PKos@kIKMR\%!b%\WtjT`]Ak>e$R%6F)o?8'bUssk;P9t*/uPs0LY4MS$NUDE7`;DL
c;TsfHZ6BATk;L$&Bg8A>"Z?dM"Ud3o<gG#Mf`>p$OjVq=EHF\!E4gMS$X^lp$tG[tR:_>C>
Phjo31`R:Ki?F.C8#`fJL*7/>k`Vil9Og.Fk`ZV`%D3e.dj4LMls<PBN</aaXa7'9EA5BiI6
/3/;$=]AEjRJP(=$)^_P0"sYia]As"I,F.5u)4Rh"N!QuNhS_6FJVli=bO7%F/br20s5d[NVbo
/_9"Y<=.]AA>2TIo!G'O7cN:f)SMFb`+AoGc09;Kj>o[A=K8"r#r=4b-EFg-<]ANi+6-?%@%=r
R2N4iRGt.NgRec7VC#[QK\DO^:g`P32mu/W;qp4O/gN.`,J-(A3-&(Sp9d"K#Z[X\s=WNI]A;
jX%EV[b('bf5LQhR)e`bt$0cYU%+As3P@mZUW;U3eUG-Gm783>LX=Ror7nt)ebn?glf[E=bh
(.CL-"[Fg7cCX2rKY&<K.6XTEjmASdHho/k?n)>oVMi7Ai?9X`gS'6J`tH/1;if+Gh"bJ28]A
HZ:DDIfFh`GDA["j)dB>A+Qd4L)KH88D$7:8SGfm/$;f$:-+nM!dEIg!\tin-QQtp"`qdGcc
un>%sUdr`0+.NCU9#.hY9f5DVF#P?p,(r,<sMcRU($1V6$<cb]AS#dPY>,d"cm<!.l`T$9\5^
j0k(3e=$2S3/GoYU<@(FR#VM3c2-n%@IUC]AhAiTY7h%i(_-%NUp.95aZRh+]AuNJinkL*>\(,
+70t&srf,fbg+P3M9R.Bd(UgO;^[-hf.&^mf=k^NZG[ihS'1n:&,32IrC2D&lObR0[Y"I?(Z
;q6.Z<W"-rupXI(dth'C8%2LQ1Cl_ME#q*s/&JQaV)=G"XPW9?-3b>8><-V<!B"!o!+"/1&2
Y`Qh1OYlb-R1m:pjaSLh<^-V"-05n8SE!S&-Kt\`W)Js#*G_,c0-rs1".\i`s1B.3ja%V'C_
lN;l!<PI[2a7saZS(:O>*PQ4(f`hr:0tkC\"'R@jC_O)$3#NMdW\Dkt@:moc_fE]AfD;gh+,:
QW;3_6YW<\GK0N"&Fb9W`js3#c1F,^g=(<oIc-%hWZEd6"DF:u:!%)C=c"VkY6?VA7E).-GC
Rnp^VNJ5oH3f-i=-jq#oQioS4Amk0!n;Br9f;%gA#JdW*g/A'"V3"`pe7Aq%E=I+/*.!GL*?
sZ@6Hos!`M6udV=,!g;gJMb-t0]AE/F[dSVBa(A<e"7NMl(p(<+im<^0(&^+TMEf/Qc,]A:QU/
P*"H+KIUUM!*4N*qaLJZl@Xn>n5\UOIqaBCP:Z+"RPPO3\j\n<>;T,j"HE`JkdY!8%r-4cr7
a=1R'&^O6?m1c&\"Go#<fdK>s'CNp^]AsPg#WSc)*E*TE+]Adis5@Lpdu8_6QXn49oM?==YM3>
_l^3+bqRJ(RX?$`'F<DK&NjX:@)Qr@Zl<e3rrOi(Q^UX,C=D1igh2+5r<hcL;cFSo;:1$_![
^p>9edqO9O`'1RpeBA6aC/.-Q`>q5UP*g=:mk!qh]AA+qV`3CMBlpuD'?_o<?6B6#P,e<[l>s
@JqpDW?^fTK_Z!dtQ)%%>g>$8W\pEI:9/!B5`W/<tuDUL?O-^[F\7l(dHOn11q`[r)I?2T;N
0P3[n7WSEIoV%puoF2,q=>\'5lp9*$]Asri!nf4h--YGlR!PW\1);2a;M.@XjSBq&6jtCY@'6
Ue@VZ%2V3Ou(m+e;GQ^E_kJjirX8o8)(Rou3^N\81ETYhbCe-#d<l"f)8NE<b%:`-rG%$q,f
t]A`"NbaTnq)H;sgIk%FMk_f"_pDHQhbJ:gr%oJPd_hUgZ4'L?514C*a)!frkL7XQGf5M1=M7
ab7VYUoZtX85mW.'d6eER=qH*m'/=l(Kk%QF:Q7[pPjmnK(lDX&#l&6ke^>:G%U37M\?-Y'l
`P*:>,TFL8]AX#$ip[Jlb5Zd;Q)ED#_K42*E&;UM%/iMuq1O</X5^bhlGB-91;Ba`Q;kLKfut
lek%F#V?''1a5rI\XUAeJnHD]AHn7\-H'b$u=r3DsJ=Z6JMW<CcVN@$3PicfDE-MKs2u;LEo_
Fb"`gaP3qi^giF).pMIbN4uBGeegQl-Djd01HemWE]A;9;NM:S!`6,95oXqYp?+=."g;[K@;`
F*?^_^n5/J<,33a?>e''"NPPXHD/[#1=GbX-AS_Q"Qnd+IP)g"#)2A?]AXh9"JS1)B_$)Ra!J
hlXuCG`mMlFoGC:j_;,>1*iQ>GuJDprIWK`Z7Tb?'?-omg\=R#f</Pg[M8':PT^U3d>d-6Wl
=G<71k"n"%Y-YQBRf]A,4q3OK\2p6;PF:r8CXZj?K$DcbVEhd4h&K)Z@Q_b;5XDSd/U[A`!0k
UCM;p(a(g%@t',UPk]Ak<8bcY#@d%'Q+C=UULa;tqXK"ZD6^NY[-0!FSTjg#(]A3l`#4sWAE<!
Mlm?B1tQNG$bO%%0DAh3LhaiPW.mBVed?VhdaP]AOmSHX+<!J:dmofrIPuubhmA7&Hlg,WMHd
o#%g=$c^FH;877h;C.I*"gkS#YK6&4*j^sTtjm\96kPB>/$'(J;-\SD*'IL&)Ed")ubN,)7F
GBh9nVe$mdO5J8Z:B?!#[LekWF@iji:V99*F.2.)#b`W"XHEuh,oC5-utkAJ2e#$WJA+i[4=
SkYasbMU*]AZA8I^0.D!7smoEC)51HX9@'"4ignSKpV[mEP5Q?5$5[;`aB\lnjA5EQIi?OH8@
G5S?A$L2\[D"<NmAl1`Mp-XDOmbl4=OSC&_e=(3<]AB$4"Yn3g8qi=s,;<MhBce]ArEOuj$pBZ
BDK4;sNO@KW2fq5^j/+!U\I@s=7@Ylg(fdoZJ;;>sN!TRFG$;0('$gEMk7_+6&DCHgS9V5_B
?ZTi:.E7IJGdP[\$Jm9&ACoA[;Kk-/IHra(,Nj")M_"iaWh"R2G3p-QfcZ076&)'gC1rFFUJ
hu"!PlVEc[R94)W#SC+jJ[I(]AhGJg]AB;(q8Q]A_YSjq1&Z#2K^7br\dUXu,LnfJkX;^8KLNAB
aH^=>=$q%G^EI?EEAL>@`U%K3q-k47Os[S$Y0e'C5tH`p=sqC8$oR<cD,GYJO9X!,\kD8?BA
;TX1d@>=m';MXAkGuIHR(Sb]A</9r]A:'n7N+Qm*rfmC=Y@,S0oUSN#-a]Ajml(4>ten!:P7ajO
+BCeG&;Zi>-8^=+:j,&MXISq<'XGe2\JtLM*h`g/Al.W<Xnh\HOJ6==A8KZ4"FerG+YA*#))
k(k(Z5><*P(L<_r4L=n"U^b&Tn1+OC-\$2Sq'Q:`?>5N0V8(e&O=?K"7W^oTP-?,t))r[KHK
MHq/94&cHIEVNi\>gmK]A2O7NVUqQ9q@<@QN'L33i^R93Q=MSCpF>>+0!MG\ZCI6H$=NHj5RM
QTUU5*HCHJ*Go3a_A$&hAsBBcfO2db2I*f*hn%a?n2&hGPp'FN+4\bbMua[<Xuqq!ta;kF0.
D"">39!0P-O!r3BS%-Q:_PInhLDJWplW/)K7=>dci/!i@9ho*-7S]AWV4*c6I4SRFn@DI"Z5_
q8?)Z[+&$X)hj)n:o90(p^^2g@+TBTfar4N,76NLMdU$/#-J2g)@M\V#*\$Qe4m^..C[JPr+
)@VYaUbK3'tgjI]A,-tYarPM"c$'pjZZnb#4hH]A^%*:4CZN$?#aQmGlCJY!f(NN]AK'HTEGnTN
?8Y%hc(43]A.;-;KLE,ii_\lt!9VH:GVODfkO4SJFh]A7O27fc*N`]A2q5EkSF\J]A-+j:#N`a,d
JsJ'n+#<9^(1BWsZ;<$6;u]A*P*hqCcR(FXjaEooh3_lgP%,Man!,W3-b044dq6<WFAA\P^3B
MP0)o88(fK)Z<ZB_ub?^Th5B-<[G::De[#$qgptUg]AO9!ZP\VRgMSJc4eiU\i]A_CNX9_FiMQ
@n7*+ER'"W/f$JE7.ZGoQB/6qk?1bePeld'TVNVOamrq&nR1ScN0HT.%^<L2`'cX!\eo7;uG
S(IO;G82R=C<#i#MG%3*91B'6Ee.DRE(L/sqKX9A*e?'#`N0`D=,5\&jk4=/"bOSB]A1?5\mB
BKZ]AH#SlD1F3U@EN[=7JeBPiAoo6;G3Xq#+n6i&%iMiaFB9AUHX]AoR*2Qs2Nh+kfG<3mPaJ^
H<ii`Hsqko/7k9NZCnLNm#4S<p*1(Q*jJ%gCp*GrF?S*!Pi$]A.JA04$!kS,ZNpL:%&#^6p7S
[]Ah5Dc6.aJ[6[%%Xig=j->LaC/V@]AeY>3CIT'X-:dJe:DE?Q#ji>kM]A=+=5":I7HU7LDYP_P
[U9*g=19lafegm\"=?o^8r?H=qUTi%\Xn#$o(6^i$6"R_4*eC67gPMaHOe`9cX;EUo=CUoTT
>da6A'>XAI-#Jn)B5Dm`d&9)BVh%q2Ym<VV+KoML`q"7O3^f>RfWsBUlP>+Vb#7P:m9O481_
AEMODjlNXC!Fg.M'uV*gT?`_h&ous-aMLK%=C![e1;>EaI.)!_*n<aTp+@.;L%DUhcHsGmW,
VlCK:KG"0hGRVuFDf'ImoNHnjW/R5NV09rf8'9dHa!-VlsBGL7HkZE]ArG!nd]Aqj#,b\JIfKU
r0d'Z7EFp14a#J`K/VWk/+CO-*`4\nA?Rr9:%!q[qnZ?WP&&f`^DuWEND!7P/W.*2*d=cXLu
8uG9CqEnE5=f=Y=(Q(@YtfHk1,^7fHS8pa)r7OReZg:>bdfBc0sb^MQnU;f,sG=9XhG]Al8i0
e*mNK.m?YU?6BSuXS>+nYV%QQ&U*u#lR(2*9(c>K(0_n]A#Yf<hEMNEVi(0[6hq,%Ur7=H=mA
Y(mr.$]A1#S_f9/ICE2/=8>iW?nD^^O/0`0]A7s)0=tAVG!KuKV-A82b:P>(MZqcTeR=o/N?#q
ouA99Tbn_o3ICO9&IDY-f/WG*\'Q:gJ/`!#d0FqVr'6OU(/&O&0KhM:7f.&_r9k'p]AQk7H)G
&;CHfrm4?aa<N5)N%9/NWgk_->[_6VqNSi:/!4h`"n#i@*D0h:<[f*;8VXFG-QcF%L'HrfCQ
Z9N7UT/8,QE$tJ=<GW:*r27F1-fmOh(UX1^n$Gc&Bm`-'+Fr60If\1@$B5`Y8e%TkQ@S17$<
ImMr_>M0q7`_takaIo<;Tn/EKeSOLW'-11K*g4RRXA$'jq>W_0?KtIta0@b2b$bnkApPsjpn
/+Ufe?!ML2gtUKd;J68[J^DSY5Uo_SFkEN`MU_Q_m`2f4c[,MD,'=MI`m5Z[sa[T[+'.OAE;
Q``iX)D2]A)l6HqODP)HQk/%;#6%9u)B%2(DJ^S4h9')==R0Ml;`,8YfaUB0P+c1b^7tlq1>N
0sCNB3/+MbNjuBLcefRc4CY*7;TLK'=P[TKGk"%0qEdu@+j::p*jBa`rO)F%qM+9QV(l1j>2
<n[7Q(l=j_\/M`IHHZNs%p6lTEbRXb_Y&B"RmJAP@6kG*7!QN@un^CCH_ajD?Ut.>k!BqTko
]A$RA%La!#SXJdW%L@]AGLt*oC=+PZHf<Ql(S*6`LA<1(D7UNK2LKbA=a7GUDeB)$.`>>QaH!q
'\Sq"k<2YO5g>6-?H(s2jIq[ANuS\_0bZP@!TbJBbG,Z_@Bg%R35-/<[lo&a,UGiq[Fb1lD0
pR(N:C?F\pF1WV2)tYa/;^r`jT-:\B91#Ot`HC@WTn/tJ0gZr6Jj8L]A\,d^o,qX8+$V+$4.e
rA5nk$ll',=i9CALNN7*=]AB!I5_Fl,oa^t2NA=eB+UFCsr4k5K""rL5bC%MC:RA1Gi^O3<W@
jC;EE[5]A3Fc4AR-l?-Eh<,4RuXANj)6`?2e-U.IMO)&FI"X]AAU(,0rEOhfn7ErLaVc'^&QYg
e\q\>0IEN^!R)TNf>+sQM\G$[gaot:SZ3B]AZ_O,cKhX]Ah->p3%7p.Ym"?"S(Zlb-C^9*.J-&
?GodlS^Zq#XPTG[N@Nu3&DFr]AQ_D'NG\pVN9+ulBo\Cqr1h!jQtG%X.H8ZP($-rmM^0t;eoe
N,,]Aa>B,7kQ-G5q80.#doC13t4t1i[kergj841r5-so<c*U["WT%Y1fa[ND9K_1=+$QJ,ou9
[qdaR=_3j!/)=[Bl%q6D0P5)*HToc<b--%1E6C^0$\1"r[c$\p!pp/SAo)A)TL+p#`Km"H)B
;7U`!fp7;fu+?,1UDfIN?5u@l:tV6qr%>JCZkP;#5K[iSF'[,gA)Bn?oLR[n6`/IY:mb]A3ns
q[83$G.LE&WZgJ\%[I@PH=e`jK=7^RTNW^9s&Ah@:ppS(*<GR$I!2jXlYa<aCHd!*K]A\)2@O
DcF".eM)R^KBWbfhjP'G)&<S?,!,#b`:^mJ"SjqhtNmXe0i@(NfIFC6IW(Y;jqIrKZ%lIQ+A
h;6b@2bc9?;Gb*q3'nEn%Amro_n?m?pNOr\CG>\cg;[0-]A&,DJ6`.Cr0Y;hVX>@<M(,*qtY\
!4''&WJ5j7b!.!Vq;L"0nWDjtq3tH/(7Ae_/P@Y*,J"7cECVI=q=b($pL.#TC@XM8,3TqIpL
CLns0q6nf0G0).+bKXQ[T[dgrMej(L$@#kSDOGN^ee/.m,">@N`E3C3m>%j`aV32a4m%6Q>:
POUHYIhL^N,^qt+F+%F^O.ueE&7)oV5m.mH;6<`WOY[_0aF8[[ke!k8OqQ8#Oo.=aB)TCU,3
4s"$@f-DT$LD_jjo?Ic9YNHER)Qcd4T-P#rWO]AD]AO?kma]AD\NmLZ&e8"[UbCMelGG9V=`fNe
3"6X\0,b.@$=]A7/gfMe)gH^9@#=$kj.;_i?$ad73!"Dh(/qA]AM%ib6m=?!2NF1?t]A+J8!U<S
l-RhUn._Q_iaJ$Q'Qo<f[#sBC_p24G:'uT;]AM[slmj-\S=-Au*JCtg$f*A;p[f'\$2V';FE*
bUl+tL*tS+tJkYU$*2[Cnnb)$N_2<QL?22,L\<#]AcMVrkjfCAueZr8n&XY/SePS#mL93;c=%
8'DTsrOb#,Si]AN;N3Dj93H(_7OHgH?3jH<V&U-oYJ)f"DaZL=gPI@\(>UF>9EFi"?Zr]Amsa'
-Zhn<_(W%B=Dq5`s_rMCD1_UF[D>ZT)Xbc3[[NHb!AM*G2=+S6?nVH(rMcm=,>CDDk`K,1*U
a.p^^N7%+CEDNt)<(W$ag5LCQcAe8J=E-;`a\`m%jJ/"(:(,EoZY`S,Q>04P:]AChhH%1K4a]A
Hb+:]AefpjGY>>N.CTil9XHCKAI@,SlZZh(gm+@pM^f!F,\>O@d_C2F/K2XefS2:+[A@'bE^m
DeXE`Gpf-<XuNB89=H<\MJTDWj1Y!Mq!A%G2s>(DnXW21=>F1`<a@dERjEab>uE7`b#X;(Gj
<$*U$&7pX;AYI;ZAnqM8fcF(/ZlCddt:#DIek]A4kMn9V3Mme_aCfsR2%X'Ho!n8/NU,,U1-Q
RW6\PhrfK9q=usUP+Vc_TkN@?$$0mq+Em9;;aE<k,U_%qkr;g+aKU:]Ab2/VYHL@8`X]AS&_"o
M2@#*tb=&2,!ZkU=7PNB)F9f?biL&+.=&,(%rFBdO,!60t\\M(Sr8sYs>,*O#D'X"IfT"Jot
XBJVfi?:+'?:EbI4)k?;Kf4tbX+M&MDH\#J]AKYEO>n1d<2st@8DVD`J5YCJ*>Y(rOX3R7Fn[
@6C3t-f;3U.S+p,6.2BFd]A04M,pLIfiFUdQ.CCR$L?XQjKYgPeaiJ]A$"Nl8,0]AFi:6!?e*Z=
d`.k#u`-b-$RRU&mm>fnO!dc'<E94;\1K8mR]A';B#Wm/M6b'm,M^tR>Sfps.mJdZE%_@<m,R
OFN>n6bN+'h9?@jQ%T$5eb&0='#!ll&*#'#/@VK+4-Pp;j/rD"4p]AJG?$@8h77>%V\W7n3[#
kor(@9Rr#:80(YVM\B/UiX4p,?2/9/s6Db0omPOAZoM_`GJb5?&X@]AAB:H*#/R5DOG%\s'31
UeWH*4/!.)/*f"^A'?./$6<r,cfFQ'pZ6IRPjn#Bcu(f17]A/\/=(nhYX:ATAr]AQ?%7=CRJjO
2G;qG$j#%u/ffC`LR.n/7[\?@gXp:iX-CYm&3R$c5nL;cnqk:l*E0ge3.IVsr%V,&qjTFsC[
;Qf]Al]AJtib'?TRDn:InFQHr=TP&bK7XF$%Ftm5fA"ah=7Yff7BP<A,_/ROo_;$)5B1`h7)A1
t)YV0iG5ls6()_l5.S!UcQUlg+APIRS"gU1;%it=ICf*I`.@(4(TdiDh!a;pZ5ba.42HpqTn
N/#c`FCbU.c"Tp#]AYT)n7,kNiWL.lq$GSnM;h:YLA99/e5u;c>@fYloRdZM51Xg'd[:mEaY(
Ta493fh..+d4ZjN&)%f8PX&B6R8J^\[t,OS=6)cOER+,nPiEs"cLOW,HLg\o_0s-a<dR6OF-
/p<1:^""O&M0B_AYNF!AiBf8bdjjh5eFR+e`KOQ82^->KNrB5gmROEWKbD6IC>U,]AH_T-JcD
R"oe1-=_;FXhY**Cs1T^[0)`*6VQFU_,\5=SJ;T(57`CqE0phR.c=uMQ+g^E'P+6a6o/V2t]A
'^_k2P?(R.pcnho_]AGSG4KQj$\0&=^9#e28&B2VK6u-[Ym*l-(,3jM1l\.kn//Ra5HMsko2_
%41VY)U9A\]ArRqt'0MioqRqP86&@4Fdu$rYCu@#%@6+)RXt^]AkB`9U"$pPX&["2ILeE_h4\P
"OPl'Qh]A[$5fu[o5m<Jm+G!\+i[^HT3"r>4-7NDm:2h2m`M*XN2#qBVXh``-lde).GOL=,Jn
phYLWD9*WY7C@;Hij3aLG+4YTtRdic[FKoUZ2_A!g.kOBDR+Cc6^%j6V5KO1p]Au-*.8alN6<
I)74!4j/'5!8$-dE,q+>[W>XJ2;XbW'n6Hou2nd4HU#d#a[<9<2B\N,hLYoc,oN0"K"GoDq!
T3a1hsYn_lF*E.@Kl)r/22oBnd!ma/SNd(DceK^Kt[<`Eceq4FVmAj+%g#_I3:JZDAj5`?\.
5/5-G04:(W[\'NkKB9m\+/n+:RgM$Wo&I7D\%5(_l7XUh4m.5WUCj-?,l./h)56*l3;kmQ,,
G#rhlB`c7D8r(:R%e&s2I)[oe<g8JA3)F/q?F\o#k/P[tc:m#n%):,4eh$mM02VtnrbUDU1,
qfp!gB,02ku(fh#rm:oM0451=o*^I,2J.[e!+[bn5<aDl#1j'.X0umGT8MU4-UA]A5kan#bJm
B/ofa<gKtOm3GO<66dnY&k3%Vr@CutL_2WaM&%4k$=9a#an1!0]A:8M<@ThW,T4O0<TpIO;?8
IEHV-,80BS@bm77sPobr;LLrcS4GR5>V4T2Z`.@65ft!GaY4a\/I8ibUo-rW10$+Wj8uR3aQ
n5Q[,&jLV[/+5;a/UMj[kOdZZ!?&^A_6.M3&/;]A]AT#314\a^6QPD>_`H&9@YKZMUc[raVpWI
VA2(**:g4JqMDC?jWVQ[9AdECKB(^mkH#[@[Sm/;Sc&&I@:`7(e+`RMr"e")P]AtILSb6tFI9
hm>>U1)m"igXY^q\4m[oY?d\A-mRC.]AQH8\QY\Ro_MRV3PQ1laY4n8!DKtcPjL5L"ZQ>@hD`
eioE.0qUqst,$FoAJAIDc*SRVE_+ucaF)a"LWX=T64Oj&Z#84)toBIO+[e[Hb+9<:B1q-!-^
/8Q/\s;0WLG8*+j$!M(FWrrC=ed9$9+`o#>\.VCB@"^H6Kf)NhZ.Y/kgMO;,8[!UkNNgMhTk
lc,=qsC/.@rV!&ErPi\.dZDZR\$4>oaH/,dj[B(T3s?d]AL*P,G8Ulni[/p(d#KfOV]ASX+AbA
,hPo)`Hg?-I;]A3+ppM[NkqBU:53r,^FeLJ^Nk`.4A=+Z4!VG*s:20`(Nk8eL2IM)S.]A__sr8
%"05lc$(MA/aT.`m#7j;t$#U5jsk3bN=k%A4%_b6Uhu(qP-@?]A7`:5;hDV6GuPq"[u)@C]A#(
-K;Q=ZW:WG9Z-G+D5*4:*%PqFN,\FaqT8!Rb]A>2&_]AnS,P,XT5b+%!W?%(ZjJG>o;F@t'[G1
r!MaX*qrORC#LRN[Ah"<C,e$RnacgUM7Iek)]A4A8LjaZ3tq@ubL'CBs--\5p9#e]A!F\4U&%0
LLgWen10!6FRlNYmS36n]A/;XA\1%=j++H/ZO4^n0;*d0J!?=0CH9%X]AFR3L6;L$7*7V+nHQ-
X^,QA&A`NB=RS<c"Bi.<;2T7ZiNBSqN*!A#5p8O.nQ<9SnJ-]AAjm:RT`6'fgc5PJ?<P?2qi4
hloSgN-B1#Y#?$<9bK&i<rYUrO^P'`>aKdI$9$Rj7m^+airG&g^==.::,e4i=0fTo<g.@$A\
EduaZ7K20<lKkomC@qKS$4!RPZ]AVl.dhpe<4)1mni;QnA#89g]A860can/'4Xi^>+8kboT(CM
NpA4Zt4[f?kF5C8QCiR'H7aEg7>>'^XaW?4'QA_[,k!/Z9H!eGh!_K1cGDL/'b:=1Zg2G!2"
E43/W$E3PMUc&&%4PZHi/4E^4Em;$(pGWg:</eKC[RfcLEu]A`W=M*mP?>8X-cF20YP3RkP(,
(@rLrBWBnr4Q?FMm**!X`<i*?H'81Z)AY]Ac\L2se5F7ITQTrZS2lnmC@'1*7%7fL`bo[JsWb
TM^:%Sljel#cJ_i8dP=5Z3BFA.K1Y`Bg>EO3jK$CD[I[JMH2:j@n$kEBXlg=K=iA$AK^;ID-
i5e:n7l->3JjSaOm(Co"Jqb6*r)eD0I(J,Xl:1KQ#V(mF\b2lLT6(a<&d`PgMj-=_O8oa1(M
m\P#Q:eY:D,<?X)Nie,UFJ1AgPfU&k2UW.T?)B7DBpL^[-ZZBKf7\tV2KJ#m\i\XJCpE"i]Al
-N1.[pSSmt!kUs?7C:JEKX"I3;44<bY#\fr)q#h!TUH)cIh:C)BK#KA6)=G@1.*%-djhgc?I
TVHYuB\u#hie2-`#m7@*O(CP")$l%<mPH0^P;F6("sEIs#`E_feaZK>`n.&q!(]AY!7*5BZ7-
K.qTe10E;&]AcAJD&RFdXX><i3SZZ^,E,954b'Uki+46/H2%eLujA+o*u7<^-1-bO:]A-!deu;
7;J\i]A(+aZ%V(gHHQ`*0fcsYKEFs*gg!#74fQ%P$EjbYLJW19Ajn0S&J?R3sX#S5`4d+.Q3e
D2+64Ze313WN`2M)pu7E/G:mZPpCjW[5mu,L0WFgoWX0n8:_.KpECorAj0rC7sk-UML<..Ad
Hn,MSbFTJ*/JMOrO@6%jLL%MKiad-1&8O$?d6_Ug+00A0aDn)ItjNW`SW[EGP@Y<?7`?<Mba
f*,t>bO-dlas.'Gm;#(V#rBf,b1;lq8sBgp_BB`@f'BH"44=aN&<[>69g/k/CDL<m3s(u[K%
^6N",[$;i<M-WrI2g5AAKg)5buC>b#dZc6?g^gqRCAsF4$3UR@Sa\@,rEib,Set]A\5&3dU`-
`(>qN6<*C)APXd%H,gAgX4J/d,81_.$IE>&&s'!?/Daf\T(QRBH]A)BkM=J9S%ql]A(-]As$G^1
%^B-n[XZ,e0$u@6nr$Zh<TN1Xa_cIgh!)g5dGt#IqZjJ[5e%bp_%Z3),R^JBiLrZKDIO-PB)
]A=kcrlW6=!,'L0UECKIDUe-6q9m[%@(W$7aKH+FNO^\TIZgbmG7=@^_uin\rZ-b^47fgZ"'[
N?B+)fWD`'D68qDe?+Esp?F^O1lTLo@L*nZ"k^^8KAI]A;'s61*:OLSL'+n(,GcG&P^k_9ocO
fl`9M<k1_:OpJRGT5V_Ma"QL7a>%[ME2.-O/bnH17Kq+h>ag0s5%8O>CqK8X`%LaO:0]AWi".
"X7ajsY7rgqp9M_n)ZQi-9NO>pT6qr5h9#2r4s-`!/j:?ei^AuugquBRUiT5KNj,g8'0.:$?
R3:@?1n<SK6&Jpa:6f'NZ#e9&9M[6JpKdRi,u4MLBEXa`!2jZjc.d7b*g#ZZ'+fk9,d;4m/5
kKUmm4;s(*M'J;Dl5A4o*o7+Pk3WR;RMA>[+5?M&K#*T8WlKY"QjB`(H7k\!ETFf!!&eNh7&
nG;a_om_(XDCAJ4$2%$lH+MI9NDBSE,r(o]A&JI[blY=HVEEkQ<;DRTSnm6nNVNKQ^8O.Xu@g
iP8l`i[2P)if_FkM<2fS`n#f3@Db)_k3]A-1[>ae)^-ODtf^[-oic:&k_"D=C._\#U/b^57-d
5=t)1,oT#NKq!2oOf[/2M0FLa96_qi.TK/9;<u<>6p%c,3"D/Kc5HZZDhZ(_.I-6?=i>\Wmr
-[Pc@54Co\`fS'hP5U4JuF=TH&>Bo)[Mspiit%u.99]Aj)aaBTK\:iE`[*Fahf/15CrMNt=nJ
Y#7S%gJJ+FoiBu:QPPeM8;Z5ja[`c%h:'EVV3i4.?]AAi4-%ao6PTbdC+1\bc]A,%rg".pjg\S
LKTmOO.4mm1IZAkq"#"Fejhe"VtcMT[X01Sn_6`\a&i(CVu@ek6L8-3.&$eIRl-p2>tm)L%q
uS1'Wj(G<q@%)dM=B&rIpllT>@n^-URjG1F("kZs8f."sc^HC6;I+M_Y43%UQ_teT9ql3pIb
FN#F_BhIk&R[>\>j,CRup1!.=Y<dI4YbnlY(WR!S"C7p-t)naSi\s[k-;+kA6,Q3LVMBLWAc
tRON.*o!O]AZl-VEi60d@<e!thq)qm0acnlEIa_XGYRK_1AP+Vf_1+Y\7N*FR?9).lS^`oI1^
,&'`Ce&CnQkRXCS%2Wg%9hk>JIaKfh]A0bZ'u!F!RFVs7SL52;Sn<>,-4_p&!T_#g5"52fi8Q
L,;^=UVAgV>N,P*_0r%*^]A1J$]A)ue<MQMK,9Rf,!bu*XRLT]ASlpDh$\Y0[DP-#6;X7H[W.k'
+KfHa_D,6%G[,9J?#RcM&)ji8O@pk[g*LkD#ul4:8qrG>VXGPY?j0%maHr0LKAKn2/l+>aC2
Ce_Pm.<qcSY>/.Uh3qfi+'l3n-leUo$F1Yq)3_5JTkLPFD:m$ZMn7RdqL^adbZ6P7%AK0CFc
;*RWfl7'4+gLC-Ed3?OoHpu#9T3!U3R6&E_3'pfpGH.b_<u(_aKh3*`Xf$*9pUXjX,c3C682
?f7?gK#kkiWMAht>`C'Q2%BNeNHX=-)O%7[JITu10:%9b.Z/l1q+nQt(2<<[*T;L*ab(k,c)
_V86gh^&2%$'/Lr^o028s!%#bT*Gja\!?s9EW/BQ./1FqGQ4&<Z&.*;Ioe8??I^=!eV)PUc;
k#JP2d=EJ-51T!s60B'YG&S`jLjhU4HM4\m0oX,/#5'XACTa>*]A?ugLK#1=qT_QnP:?_=Y)7
S3bnZ?;t/BG\1/ju^?i*nHtBU2D.ni`g+F6K\`QE<g@?DN\p+0TbQ/rJ]Ai7OBq)?dp(1(.FW
.W^Reo%DF(eJD0N;L1kXWiNn+DsRVD07iWKt9iW8R[cYiMn$.h*5/C.VRa4ZuKsJ^FJhsm-m
ZC>.?k`<BY,-\@e:F4CYUTMO:LWMc-QCkFu\hl6*LKZGiZ-'c6,YfepcH;0!s(m]A*n3J(e>o
h_!<hj59WXAX$WUMPe3PqSo)>fHo"<*,KpFD_\p;)120&N]AZSZYHai,Wh?.$=morcq///'(7
ruF$B@J.%8n]A+BRi<ZD>nQKjZe\f*^PeL![M#ZkJ-O0Z5.HEM:eAP,kkG`.2iDhJB$)Co3#<
h^BcC4AE4H]A$4d@]A2lnsY.PUm0[=/:[;[RoCV=)ZO"s`<:U$Qs<FrPu!n79=^X=#M5)^j)uI
2+aVFc.(m0>gVMiGGC&]A.s:.O7W'APh+r$_suNkUm5g)V&<DNIRLt\q&4'>F^MEIQ6^X[S-K
_@X=d*TJn0cCr<>6jOUB#1HMs]AW2'S>VO&YiC+oeMZSnohJPLC/?0Ohs\O)\F/Z]A7(V,%?2n
&;G^29G@s=8m]AQUA!Y\4n3Dufnu")U'h:@cs0Ze4;,(?\rncm]A>gp&6CH@gW#\<Vb>!#Y(iW
FfqZDs\V?IX(rX3*e-RusA:"<rL187q-RC6@RPSH2\85$BD07Z;jg6:NA6C`j<e!YU[9(kN;
366IG4PB0OHcL=@aVi%mgedZEbce1=*n*g.%^[LoFHUkOu#_P"*Z_0at7RJ\Ah#7WLD+Nr&T
O:1k2]A*U"e.^Y![l5PE;@-mf]ABIrU=.P9+1GNFamGF8W*=&^@B@":HX\gc0pc%1%BLgC$I9u
I/#8,).W,^5[H(N/9d\k5nMlr=.3X<Y/'pX9\?nd\<cJB"!&/(0[%7t-AbUf6f7-$,*EIfFj
5VpOGe76[uq84`K#?W(er"htaMt#J>:QUJO_%qJoVcSO<[$8,AdEYVBnlQf=abQU2*mhl&3E
/VDWZlkP@rj=,I9IWYk$d;Zbh=e_Sn1XCP>`sD3`7-B[LHES=IH#2SqmG<RuP@jJGse2/cZ_
S!'Ja3IYJ&;qqk"C0-lJ-D;bs6::dc]A2XfM8)W`Ld(Ddh9he<tB?WTt4%fIiXqHPlle`9J2A
_CdIB\ZGSZIlGjSrah[l78lbpqZj+WBogGa_?U):a9[KbLMYX=VFhTCfN.l*Ze*XdKjsZ5&d
A/?XKDrOdcV99I:DL%MM*aOhp=nOo&9#Sn1m_%PJr<grsPhdSO^T23``T]Ao0VF;$^>l6rk1h
intbE<!Qc@1GLk75T4<^SC$(,du7SKamB']A'lPAa?,W\#Q:d5"CKB/&F2LU.fOX:9miNYe<)
YL&IRAV*m3F*!#M`JD"J!d[24;%bV%4(g'2ik#JZeNQ+*M^&7;q6gq'YbkT>>prU0rd$K+dY
/*+4a@1/XN;i[P1tQj&IeILV3CHO\>hM]Am@mL<cdRH"Yt&"#iKcU??^)_4:W\(V1BUTF1$-C
_$J._Emi_MTDLZAQb@-ZdXeW4F:#Y"qfoTW>#D8?@Yl'S!q_*qNQb^bFI@!2&,3Z(485D=@L
;P]AiTuu[=Hp1X+Z6M?,dU/;=S>8SoBgUJ"D-rG5SVU2CH<i3_]A7YIGH29AT[;]A'UgFD8`<*F
k1FYu6iRL/ii&A7*/=1.bU`^T>8[!Mq>3h+S%'oh<7@A<]A,uU?Y"`E)-Uo?M9GL,CpL=H_a6
Oh%0l&_65oWKrB>\PhNfoL60$@FX"eAadV2c!^gCH8BMf9:%87e"L*9\J9S^Y<D6s$92+MP+
HEi=U<qi<cOJ+Z2-J2nPp/p,K1g:RJ8Z9DV_"NF',m5Ns?)\SA+qGG2]A&=&L;'=<BUEB"'BU
E$"@TYrUZH/'<Lkm7sig5V$YhbZq+f'!?0_(2A1;c`a7cmS>sYA7GXP1Y"Xpdd*/Y5nt`OuT
?WlD2Znr:?HT2I&Y=;RaU[OaXUNJW`ii>==q@[^JBr2B"1j0eA5_/64oKC+ijdhLq_s8C(0@
A>bs)O^DmO`0leKJQk3KH2E4:9Sol="^$+O2Ls9>Ei>Mc%=nu!CWQQA":^#8;>)I@(%P>YhU
WbE0(*;t?gs%V1+?9]AFh#!5iB=cD$om?+eO%\!g/R;PYAuFB2bp>K@.Ns5rRgP_?\2dL'\"I
C`dTthgR?2qJ+f(Ml+Oe=@Ot+ra9O:97>:ss1MC`i79t$$&sWfcN@]AaQC[Tc8X2I0[/?b*,A
bq:FU;ZIr^B*+"EJ]AH=Y/;5[s!=E8'\58u]AS8;L`or6L@0)WKQI\C?42hXO<ENdYUf5hH"3^
17V4?j,drr%NXY.4?N<PKT9]AH]A@q$jfoWNK.\'!&7>@D(GCldl[:FV?nU=]A`77:YKq`=`/eF
.rl?Gd?Okteeei!/3Ke8_Ij?kKK<krJ.\J'3mr^n3n@Ah/>.p:)JLHp0Ct`m=EY!$a#F23eM
3&MLt7?pp`(M;/bX7E@?k+(NY9f/p3(8?;frbWRW-BSdO9$qa`Q\uDMcMJ1AG3:/*i,dgKG0
5=L61:<^9j]AjHAKo/0AhH@t/HS=-4q9U/L#,e_0er;$@;C#Veh/UIDt$B^4jok&@s]Aj3Q$."
C$8u2P)$]Ae[ImYL`TP^AsV/k-2n2`0Ih$/UD_dg;6J^QDP6gOGaj0GeH\K553)e"3`=DG9$'
-,955.YCr9AJDeSBBUIB?TVU[*#KQ.!@k&?P23hdacAT-N6'+Zj8>$=t\8@MZbL(A.9a:Y:`
_F#f?#>nr*Sm@YZZIrqCX_B.u]AX&FF4),G0SXX9@%RkbNg`frGn^!N^O(;5QAF!NgL9#U'U&
MQme[V.`Ji63g4u2%:Bt<-s&rHGr>,$KR5=*,nX,+a`ar_mMpf&$XBkH2MrOjTQ2*CEnC*Ot
-'?u3O'4GsLFO6ZIHWkWQP$n'=*HJ@J\-eI/D9%"ZZsP,BWRm,j0M*H)(SBY_j'A3ViJu<4]A
S?DPKpI-c]A="'&MKe_-iuJXGKEiD%Fb)b-N^/pf>`EoSL$#X><+E^I_5]A&]AT0+XILO-N#$_]A
^[7<BudQZej0nc4'M>X:.9q9GoG^D"ZNi.LCI5kJcQfn!]A7HVi]AI3d=[%Zcr9H]A7W%_nijdQ
;:%4)::,aP9#;>8>/d*D%E^*dW'>%3.X0@n<f=(L"cNjYHrc127iRZ2`>H_]ASJ#G?F8TpEm:
p(9eMXS%Mbg=bk#CUKAC[#oWmr6A7QE#SoUn;gnpVNcb^.VY#'u$F6f!\Y_5JM#,GDXq2BY3
R;l5AtQNpp:hNr\$Kk,fgK7'R-W^=o=[/5F<`e(nP3p&gFGY-?SG]A^<t=Y=ChWs_!.d#D(3*
;Vn)p@AE:J7!3']A*`]Aa`r*q%&s"dY>?N_`E&$3!PnRE]A`J!9gg1WJmb7Lu<b2`/_Q9iTH<ck
Wp_H`k"Fkt<L!QD2Y<HI&cnWc)A*cj))P\"p#6kDtV)HW8H@lSOo->t0_rp>NmkG3H-qU'.3
%[P6RZs_Q>]A9[k3.m<(RaC@cr]A<<7]Ag0g"C=tp=9(FeFIh9flbh't*bA0mO[4r#B/mO@jX^#
$&[e"Q*q@h@.8(giTJDI8t>):?FXSTmOn3ufQ1<Z[CY[60OBHNWCY9U<&B^inU)j,dq@@dJ0
l-B#n#A#V4W%=udC%B0Q2g2PHU_=i)*rS)N:$02K`MUBFl<_tH(J@>*/2'S.U]AASc0G8n8&g
XSN/pJ,cPG)QKS=Eu0elu[<AE=6WN4:l7g]AFU:m?tpdm=]A0#m>h/M#+54[j2McJ,^(L#/WCP
ns'/Kj;Q>CO4naM(SW+<Krj%8VqP.hY7Kbj&^]A$?S,kZI@g\RbFqX3oHRW_6k(f+u@R%c5:?
CT%rDd;=q6*PmGbL#<7YTZ?\c1f>3,DR;kHe@M>gAhCWC<#m@f]A.0Pk^\1+[o<O6Xq>g]AWEU
Zf\C)SqtS'.DeJ7J6a#)WI0:>C"[5^6+.Z<YN%T$+,U&32KH!#g<#mk;$?_$s@?+K="p!rdF
4X">MV+4Q!Uf(V[UkZM+GD*1Wae19(-m:Co-[):YCV>0gZVSrNI\;mja"420XW]AjiIM&h/0#
8+,t[Wq#r]AYPDsD&RC+-2sSLh91W4GWknsA:o`[2"Dd_e&n@N,6Qb!D2cV-JR:u<AX&#kqJG
o]AAD@,*FbIC?'dd&pU(FHaG=%eN;p8-#YeMsLKBa:ef=hW%'*E+Z*p'!?*m`fu[NDeMoW6:e
LR+8Fi#np_q#$Vio5[ETXk7iUXUX*2P>RFI2F7I;8'No$Z-g=/S7L.SYF_Km[5,ktqg/e-A-
R;H&H/l>P1UoPGt..9\IW82A`+3CBsPZZ@u9%qa'leB[*lOH8&GrY#)GmgJU6q,`/"!mqK57
'+kku(*N_IF]A!jM,8Pacd*0ObcjL:qq9!]A__Xo*TgoW&,fp%1'irJBm8]A=b$dGAHLTQc)2X=
-bJ-UR/I4Xb/7Md8C9Ydn2fZP=q6o0lk$=E!#D>1V'XReM$O?6eaF*]A^dK$_SF,R1"IOe9L/
s((hM7;bJL`8T@b?-Nmt_5'X6T=g<=X17,4geKb_EQ=n72(0?fsITC2*uf/%+')__E@/e0l1
7.+)Dq6>(6LE&u%jCU/bpGa5nh*#*`\Tld4'`i(sHQ'#_c&.1EoC^\#5J%`4Pa:!^CIS-b?a
S$`:I;3&(Gmhb#s'%uCrYEs`UN+@Hd/9_9bkDeS2>G95`=X?PWAZom5@a`0Pm=9"\RS=SDD7
-h7ol%'\?B&4AC^F1Y\A)d(EO)E]A7_`QTbcDr,eh-0$KWA5o<@'hRD+_`-WU"'Pgu[G@E1ZD
"9^]APe-Ro]A!CF&^8CYkPR"okqkSmJ2&:Ib4\>I*6/."&q,^[6PlUpPGS+`e1f&C#aCKSV_Dm
c-pUrd)S?pDOLV/5&IYZdLl\/+OLNW^<Q;C2>:3gS<)u@cRT.sP6M97sFXW.gu^M&cUP%&D8
J@tddq@ds0Ra]AAW-Eh?j%Yk40P.J76G$fVhWWuTl'K($E=Bq5r_NX=j$"rH1oaQV:;G%D6-R
$?RkTkKg:<\b0A[+^IpAW3cV>#Bg&AWM)qCP9SbOj`_Cdcra6#.t+=c*?FH7L:miVX(8U!(f
!CIJ5P0*4es:FoX4,L0nN@Bq7"1$*+r60g"F7g<Et]Ahf2d9(]AB\:?E"3q_a8J+oD&6ZBM.%9
Z&6c^gjaqfN6OLKnDm*ce,g!6e>6L&q_uI#ggIU0QL6ij2.jF;mdTgEMk0l`pQ6OK7>9DdQW
$`c9C%\<V\MNf4_\X@rT&\_Ck!*QgDRXIg.ip/1T"G6LkMr&MCC8i07KFY[3//"!fl)<>A'5
s2)kE3F^u^ji%2pl:E.BEj,=oQ$[;0f,%=\COE"1[,:'"1W]A3UnAm:>[dMPq1Lf!pmt-P)6`
&O;6mV1N;_1l\h[+6aBJQRG;lZLcaYY49@o&k9cT<KB%P!BpNl+;P_#ejQ1Y$Fm&;c-nW4a`
0GPIH:4u4D.UF#]A8B%%O"*#ZAdcrSq<7UguQkPdWnC#gWBjd/C(0+uD`P(Z?-HlOH`^7k7sl
Dkr*L`,jQ`IVTP\/VNYdO0'i?>W+T.$16un.`mFONKs:&U3Ktlgj&]AQ-H0hE%d1SmZcR0rN4
3654%p%-k%9aTR()CPR"WYV4KB&U!=\^((1L,^#rgV(bLUqSXp!l1d[gc9tb)a;s4d%?XcLp
RF]AJXS0*Ql\lM"gG1%,*!eEW9iK_J?99^;UWn=Sr"'HW$M3>5nZU[&Lgj64*1gXF7b_iNtjP
o+k)K;5[.7R:+>"6)I(F<r$Z3F]Akno'7PNk:/u)HeNm0BV$8L8Jp!V[K*[<>Rc7bY@Hu1f,*
B7rUU[J/:/q,p?]A5h8>e^)-JBf7od(FO[uG5LYAcb)!S6m4b^EChb)>?K=PXH+gMFu0dmV3A
jNr')_h+5'/=r.inFKnNM>22,i_f:EEAm?</BJHA@_4"[Id9``;Traa=dgonsT%k2gM_W"@8
d<r/Rd#"VE;Z.TKm^%O6jV[rQ\kn7"eNEXU33L5pSrUc`R,?Tm4%H@L/gq3V!Y!Hunr';:.&
9XRF`MjHgm?c!ltT9;B;6+G3.6DA4U052cP[,rLr=s+DdmV[@1[_-SS%=c=flS9_-.aU!_+D
J\tMFs<i8A$XCKn1c#;)D"r6_5O=h1X0u>Iud<l!hAKSc5_SH[=)OD!BROKQ_$,l\m_H&lCf
AL%t7=UELq!gVPsQK[ja$r/*+$`TI!]AT2E5g2t[p"L(`+W^sX3UDt`T0'm[N_:u[':p_Jj-;
(V3++9q^ifJcHk^>eN04sbCr/;S3,CFVucEZH$M/MEU2?YGp<RQQ',o[6/a>;#55o6'3eX9B
rf::^G_ks:\`NpfK?,Mc^+cY=eR.p)=W5#u;LJu'lE:(7C)Wmd$"<W['+)-l_PS7al%MP(^u
`8LhM:%_CY[?u":8O6KDEPH5%C@g^,+ppF6IqCoB]A:NR'??G?/:ZfDgK8$"gd0f@eD3sej%)
i0H!;:cS*^s,-np,]A]As#h,0Ma8%/psOU#5(37QQPu,@a\-NPjq/0@p3'GbZXZ]ApHs!r>KDUH
sak7]A#T3*V\93RleDTYk7o/0.k0:lJRc=BGXXQ:Xho7%XJj7n,4;Xkr88,'&IZ+.7]AY3K#O=
G#bl-g1$mOra<Q=;#iX_!@T)!g+<8F>Tge2BZaYaq!H5-++s8$.\8WV9%`_/$^?3ChQ\q*Wu
^eeN^SgDVFpdpM+8NX8g?elK=9uO7"r<KVj)U%.s[,BRKJN;AA_,7+gbWM5ggk%%Mdbk`s<"
$4f:U\N$]AuigEk\S4l%8+fAI=b(?B8_EjEiYqnK7p-@."Ar]AAr%X-r]A4\qpLO'B=m'._s5n@
"%X(S[D4LkU+i)L^L!*!]ALhb.CGK$>/G2VcWT;Da=17Lh`i3dQN4?<Z$V8>'<(OaT9R6,:,+
GJqQ["co!+2G^3rUDB\4JRTm%TWIr_2,Rl'=_CL$d"$Y]AGfZ(kI[(i_0:rWJ,\e'[Tc(>&r&
Qo:SDK4X_Adh&qZEb'.-_([sL?fn@N-CtU+dM,>R#pu38A$HmRh/FHEW<sK(X64a_\(tWV[H
VKa7?.9,!FO2]AhR7@pYALa!70_BisbMJHl[(\Y2IQgX@LhNIuY21+8P=7<(:RdH+7)qa_X>?
3hZ#=QrXG>Iemmp0=P0WC+-(HCc8"IJE43bjE+m![_(i79=c'V\:aG+E?tJ[?-/+O"IH`Jm<
;/o7+E2$=)i"G7ReJ`@Q#.T'3!4h]AnjZ-n$)_cc>T>HmB`Rn5_^+Q8b`0@(;"?=]AcF(3(Jfq
[Xfsb-Mq""<>IY)^1Erqe_o:RQrTAg_gYK/HBKMscPY]AHJ%L+PJr="HI0,qug7$=XbY_73S,
Wt3V2o$Y`Z$pKn\EGB`bJRs(]A]A!5[*niaL>.iXEZM]A)rX2UipaI2=EV>!X@XrMI+k3M19'6d
%\Pqci14?%sui.MQieGCQoGs>YK*&FD5EsSN_eiSicQaq&^Lt`[BNXo-i&L2"E/R*9a>^U@8
ijVJH^%Uq&Y#,>*_tiL@1ttW-HN;4gYd^`N52p/uf+H7s,^=H#IV_Q7/OpGTI+rtq+HM09p3
]A>Wp>Fe&?"7#4.&*3niu]AI!erP/ZadW?NM(FCBCC\#Sq71#Pk^27VF`/XWGP&5QV,t"\T`sB
bBC,st]A3G&<@%*GD__-J>XZ_l4P[kBVqI=]A#MqZr.rCS)&gbP.'nk!F(..q!b:2LVmf.HKrh
SYdXVALNt(M<<d,l@"!l'/[SYhL2)h1<HI_u@[=lsYn>]Ad(F8Nc7G65V/FX"bMF4ha3Vn<c\
-I)>7<-hBWTu\7JhOpXU5JKG(BlZcG0r6'2a0f&@T@?oK]AW2Pl&0I"K25@c6=kHLA(q-MSlr
U2^AIgS&(AFYk2KfQ6%:53Y!A#T$__%!jC96%Q015hNQo6`5;FK/mN9d!_`99]AaY*idLlN\m
*^,%i!.O"WY*l&%pd0JXU^(!dDVkZLe:lkoi^Ie%prgk"2cbVSrn-Op\sB":"MR&\E,-`++L
4NcDOF60/fuEP?,HlWWh)hYF[2K0CAnf_YIqlTY=?rr<~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="60" width="450" height="634"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="jx2"/>
<Widget widgetName="report1_c_c_c_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="577"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="absolute1"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0"/>
<AppRelayout appRelayout="true"/>
<Size width="375" height="577"/>
<ResolutionScalingAttr percent="1.2"/>
<tabFitAttr index="1" tabNameIndex="1"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<carouselAttr isCarousel="false" carouselInterval="1.8"/>
</Center>
</InnerWidget>
<BoundsAttr x="0" y="150" width="375" height="599"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="指标卡"/>
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
<WidgetName name="指标卡"/>
<WidgetID widgetID="25cfa4d7-b174-4094-b52a-6856f8369f61"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="2" color="-1" borderRadius="0" type="0" borderStyle="0"/>
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
<![CDATA[432000,838200,838200,838200,838200,432000,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[144000,1152000,2743200,864000,2880000,2880000,576000,2160000,2160000,576000,1152000,144000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="0" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="0" cs="3" s="2">
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
<![CDATA[/数字化平台/HZW/1_Dev/机务可靠性分析/20210728-机务可靠性-明细清单.cpt]]></ReportletName>
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
<C c="11" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" rs="3" s="3">
<O t="XMLable" class="com.fr.general.ImageWithSuffix">
<FineImage fm="png">
<IM>
<![CDATA[e[pSuS*_:U*po_[[b;(GQ4A7BN>aZH6g[SeX/37$]A1$D@WhQMS/TtUQMOH8pX]A\'Y'rr`;,'
HS;p\&ua^]A38@Eu]A3?Eo4F1qtc9CF.V"V8X,?gejUo<-4gH);>]Al.'+ft;&GW:cIh)7Lfg5c
8i;R$L7h<jNV3@f$"51n4HepP+)[0%6Z;C6**uQRmN\YYrLou&FfuVDa-h.$KFiGb6(V3g<f
A'\0=0#[u$F6VR.o]AEu;LNOfeX50U5No_q^$0ZmT!^U/[hn9.iRaFK8nU^Ja.n89Vlk]A/I(O
"X1Ao0CGtuD89U5VFebCQD0VfG,*SKU@#Pqb3Cq5F!&eB^WoiaEtlt*\#e;t]A3Qbm]Am8VX6(
SfR0n5-+<[(,3-)bW*KKlGTLSVd+:Zq&gmK0rDFnQtDQ-hJ599YAYlW2KZX\IIprOIXV=M&u
6:NUdk[TCmj`Gm&>OF47/-raPtdG=RZ'5LQ3@Poh"aDJuYWG)'*BNB.:"Z"P:8q=r'[_R8UN
`N[6*uZ!37`IQ@o0k4\bXA$54l#3Bfa%XDLA<;Y"n'f:m66%!#+TCRFbkB&'sR\rQZn;b8U`
WC?KPbJE=1j!F"Ok(]A#/_uh03:Wqh-<ssl!I^"t+>SC"gR:8'p.V!J%5_kZ0Rn8McrA;)[D(
t]Ao?*Xmd8?8l,n-S=pS>q8^+mZWgFbmo:K*le4mX0PbpRUj$*YO$s7HU-?9MrHGeIs&C.&<\
YC!Y`76uf>`([_@L0,ndi6S\H9!NU-65;QQD&R@(\KMc6*_]A]Aq^)@d>=ZQZM]AI[8\2,<\B<d
Oc:9\S&5hJ!0Q^KB(R\S.;P`PmO<T9>IT5-0k7s(+kN-BEGri*sTl5b7\0hg)nk!gF%pI_ri
K_sLU5cQ>/bfkNn(\),WWE8[$`ap?ra0^/(8?]AMKVRupu\,sTsr7U"MK68pj8kUDN`6+;CTA
F"R:GJ>,KmmfIS@nV6j@#-p/&fgp%p6@bF><1R8RKYChL6m,;7d-PTRg>57li!VLlsca19Ze
+n[4[U^D":8rX/R:TbTQM.(D%Lk:"al(V>bQ?h]ADn]A.<H\@26"6Q1EcSk@-juqn,8O2>DrID
%_8)>[&e.r^6SYEAbIk?A?UCYg[i2iWO!_2B+n9^jjDn>qeX&B"6j&;?YB+Q-H!m?>IhW5%L
aJo[Ea8uH^Sta0Uj6h_R")tFXaPlCnQ>/mlT.t3j$`e*9a#A5i`5<*.\AO[F@PfOZb!ds2_/
n]A+"qX_BWn)M%$%9rtsu,kC_WepaK5-Vd\Z!UUtcgXrG0PN9BG:T5DB#JQiKoKdgBm6''&5l
\[o4`I@?P*;^L?ItXCFda+eD(HF)Xh%G!q/-JlJ\N]A8((D3d[eXc''&#V4t'AVaJ&5FIRb8"
6s%$-E7+SdK_)ooA@-qfbh<A3?Y*l=o^d/p1cjS+BYC0jLB3]AV'qU9K1)S->B+KL+M[AA?)e
4ifRdH,1CE<`f/RVtU7Z$pOG0H,)/.YY`/u25g`_,#gFs(8$H,A!G">4KhMi5I4s_:@qMHjT
*Pc-O;M@J7IX!r58e0\<I&?m[hEM/TE(*C0OJ$_dRPG"a!\dhg\V?+TN"A@uo#5479KT;<t]A
MjAbdK5Rfq#@pAHC7ia;V=AI60[C-3b-IBqKb6.U0;-%lUrN;uXVj9$CQUi8JW$8LE'iOS/o
:RaLrO8Q'KGO)Y)9_=,_1==2`j6--7>;O%W>Ch:6#Ra)?fk3Tl)J0/!^!Tor-)3p8r(&/"Qn
DYe^4'J2?(pCndG/OS4B)1V"3)B)J/S?>\iRt"S8R%BG_cR=;A(\Fp]ACr(#T>UY?+Bsl;e4\
RkNOWQce`u/),FL3fs-j&kTTgopcZp#X8QG&Bk6_4f8LQoW6iMRmXf'U"2q`I\aTH(q-fj?$
eVoJr<.?1W=n1p8hAA0g",;jII<)o]A_V;gS<[Mgt=WbaoGP8nJqFQ()7J+c^Z6D!JX8Vm.";
00H'fX`k<01lFcR*'lSXg[c-onpAih$FEW#NMnSr'0rei]Arq/1(;q_N[/90HJ("q-Vp"pAuI
XcjjC;BK5G=qsEhMt,Lj#&c4bh2P@0`u#cj09@=ZnT#q)!OW5JGnh.R-FZ*Q2CiA06mU@5+N
*;H?jnBRNHJ9Qk7/@M65-GT<&uZefL;LC!$qAdLJY5`TiP84Ru@5_VY@AImZ^Mai+s<kjrAX
7\S5aJLjF5g_,.Eoo"#-cHGNc%LkLpp4G2MjG[tVhWGa:6NSU!+*T?d4ZSO`@1QfJ*pUB7g0
"00OG(I?;Ql&cOu5q."YT1'i&/cl'$5LuX9M^1_l2o)h"KtnB<tY'nYa+sa&#<r!P3:*+HR5
p&)]A2G)b,&#<%*5\#69D#6#e;CG85DW`dp#2J[SIl>5Ig"D[BgM()GJm4P`kfkK+T!Vo+/;X
t`52KT5-hHQM#7</PE*N#g1u7%L#2b'?]ACS>O+ANX%j3A&#1`\ge]AKUA#]AdHeRNuS*blJN2V
s?]A`:[L^HF[!=-i'+Z#)6;&j.j"E7<-2R;_(=S$L"tQAVi\07jP]AV>MQh!/H@2^8(7a3?@1&
>X`sN(hV`]AJfbJLb['9^ni0?sN=Uo%&$2H!2Jq2Xb^1BuY-29q>JDEAN>s1Xikq:mcDj2'19
ZJ0f$Kt!$3gPsd<?214;/K#%A,$p&l+?h-&(c!'bO)1NE&8$='WQ3SlhBjRS(1re5=,AW#sB
cD)iUQ5`f[V'aDHrLn6STDMP<ek.gWCpo0!%?P>)jm\D2SrP.rte'+l]A)4AODTZ_>oJ(bL;W
APpk@E/YH*3K9]AE,tU'pL&b_jm3YV/*<o'+!?j='@dP-JS(Fp#F;a"7.q5pp!k0ObGO6>%B"
eR9rbRA7$Fe"`iM)-\E)P<A^et/@$]AUTIt)T@h[f8S`BC3%bo%!(;98,q*m);(+L2AJ9"^jF
2G;d-#%Zq[^j*tbo#0cY+V3e%G'qoTb'd7>1L^eudrd#0%5iTNXPD3l'7<s<,)96(p#NrfAu
p\I7p!c>h=el8<KQ*WM(#?a`pkh>*dIc0]AEOFl^Scgo4iOe/[-.kS,s'hh1@O*bc)"cape_/
e]Al<k`dcECkZa;p;aN,K*<ZL['8q,bL9DHXc4Zc4m<Jj3_b/+#X43jMMI-lErS$,+TjBqEYB
moU,^p@5NqG]A`GI+%XYRrcilUGM#[3'mLqWT+FtFcI@X5*;!J<Sj3:AN3)a*cW;U%IcMFEr]A
@j,s`/fD;g:(O&70g=7s$U@s7YpDLXjY`T^cc5Mrgjb<qhqZmrB6qur8LDX5\MQVt^c?&>U*
N';^f>BWc;^=6ja,O"&,WP:2V,'.uW]Ao)=*mRh6a-ip"Qc/H'l!i[p&CWT=[B0WNQY?KY__@
XfM806TL_`d"t,6J%@]ATb3%:TJ,0_`/p>2aVs3Oa`aJjco?JkRalkdi,XMMZY+5G_-u!2)Y-
s'U$PECR,7K=T7hc.n!=0*iL8/d-@S<2\]AKeqj]A&)`SCg'aj;A_Ooo!&'Lp#1CbXaa-)W!5>
k.WfCJmP=UCK`:/V_n:YFi6alBM^@Lq<YDWcfDJ3<"36eRiIo]Ao(sAd/f[`,3WUM123+CB'3
0Ja7#Y4;<d=F)fMna2;Xd<TOK_$90%(*P3iabD"Qm5g\93CmsfO?ef0!L^V\_P':b8,gU+"#
gT!U2k;HWu&BX0m2\2eVaQaHVZnuCVL*!iO\U&oGIEP7D6BIc[YDmbDL8H9pT&8=ad/Mggi&
NZ-800>q"q&A.N(hg>rGYBA)/YF!5e+1>hZ*=P\aL_bAouhI4L'tHVOnr2S+aKBjY_Uhl[I0
0jgMNh?WC4lq[6M-@Z=sVVMd"2YN+?'GW>)sK$oB^jo`J)ar<c4IW*_d\.enf/)T0ZXCV7[+
"LIK'.l53X/ure^(*n:6&u5E[-k!]A20d+WF,$(n5Nf1%)a`q,:J&c<.CCn8j`C^MCePfW7f[
,4^@@V%OVcUVlaiqOF=lOU7Vl?N5e"ko6\s(-eEKuY`YAEj)HcJslB^1Y*4Z>Cd*[VY4^6/d
<ak`b[@I:j8;%_QZGgXf;#[a)^oU30(=RQ2C&@@TQ&Wg(cej%(39WZH_FSCY?;`,(oi4Apd3
m9=aD5I?1<AaAceOg]AG1/!#I;q<C(c9oIVeJ5+F3Zo8En4GlXj?7n;kLjk[)]A0Z$-gN`WQXd
T[rZ*5'5JJGWACe4*^4(rfnR'Ke3?O-aV0$lD5;SZSjt*Fj0\GrG=tEk7p^N9N^ID*$LtQ2`
)Rhm3PVA&C)S0mG*IH9=C[pl_>+9rk;A"h5,:`$YAjj)hn=52q6RZ#WGe+7e8cgrY4%PT8"!
6u/T,@39_:`Hr::*HYrJ<:d.eXrKR7Rp-:\j,@]AJ"KGflV-WK=%:HH$ZT(S=%eJ`r<B^g6Y]A
RQ!@ZE,gppNY7pHNXjpXrbGm;!C.BYAMe-2ZSm:e6VWmD*Bq;ZKtN9mW`65['mQGBh"p;=#(
sf25l(2R9BiK$>jKq:huImh%(r9lGMq:c'g-X@BNTp/Ki[S%Li7Ji(D=--%3AD2LPh?\.E>f
*r`=:g4NS"U'_#0=niSD^H18q\7[d1T)#Gq>QSM_&1%']A+Y0`8PBi*SDZ]A%Sk"Vm4-2X0,]AR
u)Bc>#@/M:Vt1g6V?hC1T1Jgb7m;]AO'XnDICRqf!#KV<kXDE)[ZVLJBOfP(Pu<[f]A68EeKhK
2;UASCWZ9VVg*9:X/TrT[\iqm4Kk'o)n]A6F$_#g3Yk9d@?$`IjU%K%DtM]A?SRN(0VA(2a',$
<"jd[?`OsafS4CH_4W7*A6lZLN[iWZT$Ka7HkpW>G[+M]A0*!,V$s=uc8?pg1E`Zm/IWR%),\
818-/u0n?%Qol42%GtCF>%?hVI=hRLtkl:B$e1dl!Q\<-n`t2p'b-cm:@6:O;?W^"FJGo./j
P(+9FZeJ-9*Qti-AM*Q7dgKmh`Rt;#)+q9bNqB;/N3?=t<151X:c6L&i#`olST/RsSel6Hsa
-?+<c6bib:%XCFX@piW%N8AoS=6.U1]Aq<SR1oNmAUe?SY3,IM^4*:VeX--r,F#9$iZdt%Xco
?bXOo4*GAY-\ltnLGTmTE`.=IdG0SI)p=6d1))m?G7ZC9Z=js`B**nGS9C`h,peuma#s!,ht
'<Y)+%NVUQ\e1_AV,6H<)ks6><=SLs:pnK4%FO]Ak8Zm[R.=Lg):/KKWiF5/m'X,\P8_&`+Rb
YN%]A?1.j""-Sp.LNDJA@kKU,/`Ms.a*QEoMpt#U)bW*;D_kS`_Pi`O>ebp7NfcAE+QL<Dd<7
)Q0KR#'(<<oUNMe_IpEd#@).G>bq)>enZQ`s2Go*)-70E99S>?TqL$F'[XX=hD4d/<BYVSnW
j4eb".c!:71P4CJ)Xg\HejHX=b8`<0ik!MFZen*b11Afehb#ePTLKOY9UFoA'`XA*pnaeGU)
160Vl]AugjS@:BU1G2W90On!u:ko?eSi8&A/3DMpaYr%Zq7qiuJAP)b\Ef/_3nIpkaZHmE39Q
7.R0f:<,G/2tsUnNkO\62/9WYC%kIu)5jRjBDfS`"+IcTrk6ST>sJu/m9_M3I`m/cUVZBPn&
M]AO<%8-KeJf!KK0"ZKgmLW=%2+"f8(r#VfNp%SYuceOFl\FaC+AnQ9[Dc]AFPJW:/6BAOO&Lb
6GsbMdU?B[nSb=:QQk'FddK#\hAbOX=0C`j.MJJb3F/%rqc^UK@Y7dNqk:Rqp(CmddNr"hq6
.8)"La$(_!>;Cdna/=p?;_"V(;8)G>OWYg_E:O^A+/6bMoKJgjZ<f*lOG8re`Veo/S*#CG@#
hK5s*[<&o-gDPR1%+m'V,J-]Af=[nLhQaU;XjE@I5eDdYMT0U0jM6OsbcFZ[NS?5N!l>H_;+C
q+''/VT_uT/;N]AD;R<7236GiAjpr3.Gk]ASPSM[NH+!7)8V]A`6g*tdg!fQOWEJb._[8]A/$.=I
8-"DhR,dOQ]A/56n'*fR:L2a6OlT@o7K6(m;N\WRbjtWPQJ(\m$';mA7]A9cpTHp=/O&[.bjE`
jRsrV/er@-!98!os+$(7Z+^_.R!Am.Jd=%K7_F[)8/ZAUT<HkBZqdirX4$uR(4gA=mf`qI-V
qmg>Z,&9^%%og$nihr8Ypg]AU=6o1_pI6NZ7]AaI]A]A%m='R%V^9msBGa:jBC1S$AGUs/$*GIY5
fr9Y'=&LYIl/g$9ZKlq<Uu./tjB^$=oa]A"/WZMe/.4Kp$n-%]ABk'lUo0FYNhLtR&48k(RdrZ
a-,\t]Aj,Ll>5cgmXE5B6'u=/'oC`?5.X:.na6HW3n@-$D([C$SI(c"3Y<qkaj6Fn0-i>jgoQ
G%VXqHY_F6^;*aEI>5o2dCH]A[/,f+T,Xk2DIKnmjHd5`6]At/BA6qu_1P=>74H^YrhDetAU0k
k0le50f_UH]AgQ=&$c+Lfc$m'c9c:BrHH;E+F1HCoG>>:>rK+YNfJ'bf2E%aL]AnjmKa*_Obne
ac>Veq1?p+[JsN>9]ANcI5PNC2neW@*E-++=Rt6PD/#,AlR)1=PJKLjpXaMeHPHTZ7ZJ\D9<R
?X]A$iRm!/l:EaD'm6rp?0uC5M178I'!KHtU&26&FTF5FT9-l"5T%LSV'ElA57hW6V#P_RA&1
HX<Aso_iY5c8&YDMl'XCYY]A%4+1,_??Epu:&4]A0TQ/^9*!m:BTmd,@X'["CirV9Qub<MVkoi
:mu5</+>$_Q*/RI<ftTDiY5HL45MQ*U>IJIlQF@FStnA-aKh^HQ>=[^-g]A\0M3TeJu/JG?"4
tEoKq*[@_qg'5[MsZV<nl.)/\r0tIqT6;g%Pf?ruGZ%)uFE9;[+'[>Ht,\PoZc4nLD4Zn5_N
2l)IjB#CFP62DqnO!h-WNF/$Xjr9nTZWV9'`i:BCN[\lja:ZQreaQ]ADg[BTR0f_/O5o02$rY
Q&'.?:mYeQp;(@"PJe(%G;VpnE1p@2ab1VUkc[\Iok13_R);%T=H8sAK5GmLC75Gse]ArCEPm
+l!"p0]A#$"Ca3:TcQV=88U\J2GVS'ecZD&b2VJZ@cC:['d6pUiA@uAkgY*_?Wu.Vs)dj>\La
\2@COP`@OMAP5#[[F$gh+V_*BSGtk`(E\=!"s>=`6ODQGT#lhKHlsMrU:h[tH$g*ZN')>seP
6m<fPXs!PF$%jn&e8MK[q)a/29\_a32)#5OX[J?^Bjg\4'P=#7nV,AC)Atrsp[Xh`7V#7"T-
PXCobm79@;7.]A!hF+34.ioR[P+N?Cd#n#q,Lg'_qU9RocnH-VfVE8KMos=P'8JFbTC>S![D?
I@Jn_QZ:+[6I]AX#s\@[6hKBj'D'QG^BO:Fi!!RiOn)d]A]Ab3j^@cAUf8b806+1Kg%"aQAYHCT
,B[<mmsDl./_\F8WWUP3;RBH:M,\E6PgI3gR0QmH^,!FJK't^9:n5!*&%AZhQNq'3bEPh(=:
\WE`bYRaj4N#"j+3[js'j9H)i>GH(uZXGT=EZ$V`Q.9[a\AWCs14qE)G:p5!JoQ>BR0q=PN#
Y4-)8(HLkURldF-(chVb732I-@`PODc_[#&08KK%ba/'uX)[aF*Op?92,s1MempE='U#Pu-X
O0gS<\4@j:,e\G%s/WU\/f4cNKpOkG*qaj87n.UHi@4\%oje82-e&L0\3qoR*@?,9$[[:T\M
6]AO\LXkJDp%Ji^EHdMOTab'o"W7)aa?>Ds\p>]AFfjc_,E<QV4,$DCITe@>OL+&U(JV#XMqWC
T,?!\a_g6fg;pWiO#kFoStFo)4NED>\e`fNClnYZ&*d\9[-!G"_X?*V;7YT%<<a^6&ZeQ@p1
qKQl=#:Y;:>r?'Q;*>;?fT/X"^XF./Kb7M')Eb$l4<hdNP,-h:f,<AF+B69Db?O1(;TG>1Y,
!q]A;m=r@iXtRU[s3LFN&d91.g!ep0$/<q=M=$jSYS#oXfCCGqUX]A-Ihrl5hGYXBGRoGO.o#.
qcr2C=9qO/Yu'\S8JU&OZ*?_#NMU)`@T`VeX^/C@n<H1[e>:3V)foo"6@4@SC<4N"&j^O48+
,ll4&T`5IZs&a51?2k<fpu/0P2PeP4q64d$o_3RR:,h)EduJrVUNPq<jB:[cD=kSa[DVRoMN
"kMFUPr->ibdMt359)d,mo:C`^%G0.,Cs+c]Ae/'dGADr/i;%JBAZ>H^X#\WWbnS>;#3`QDnd
UES<Ieh[Fm@`o1!rQW8f0mS:2h&bHS;0(hQll=r0ufT4J;/mq.3^S28_Z'I;$s$hk?m-[[/A
+h\Ke<_YtX7^G+)G%G4m;356]A!Gs<on.#b@EkLfI6<<ZWrMgP/MMqaZq8,e_>r69l=U$>Y+X
PF&lI\kJcA+]A/9&mX:R-7]A]AVJeX!.-;1!p6J.(-mb4JS$_/r]A)O=2=ggMsS6H.D72.i<OdZK
OH'n=+%YrU^<_n]A9ET8pD/A<sK[$o[8Ins^jf6(Zb&k9[(P0#h$pb,f3n2XJXKqk<HH4"I#1
Y;Tp)X&dsIeTUB+I4K3Q<&V5XL'QX&O':G;bebRCSIk[23AT('1=;e2A$5u$F@bmM2i0;B6l
9pe/o9]ApMq25*a0!=f?gs,/"d6V9`-T028hW=e&e[d?bE\%+XR#'s'1k(7m5NghQ\'@8WFlF
K"`Ejs05s7EQ3RfkfQ&1'7u8L3']A7,ia1$\/-H6M7=b1QodC*^VF9\3/<PlVamq6oBHg4F<&
TL?S_O8qkU_Lq[Z`YkLQfEk_Ni/-NfnM1)C"nFp,4P9:$`VMBm<->&^>0`Gm]A.DW!>(VH&M(
tJCpS1oQd1E[YU._Z@p2J4OJM]Ahi5*BB_ql&Xs&_4n>.e!)X^nA2e;0f*3NUl]A.h)1/^kB2Z
dK25F8pFG[1;2Dr+V?>@;Ror(Eee+AS9>DeXgCa)9+t1oDI9)[5i%QHK\W0[r1+N]A["9CUW:
XAij-I@ieR36H6u0ge%q#:khuo-Ij\#KoCJ%N;DZC-.D=*JP<%K"'F/SN/=t.'J8Ec_+A:Im
t5F/W4"E!=An0e87n^YAr1KR#<k*fk>6_cHNPKBQ4J)SoL@D2eY_k$u!Ut0"O2M3c?e#f'fQ
M0>`_))-kc^dTH+DeH[1Ul%]AOb5nN:LAT,g8$t"dHJ2a-&VHZ$G3hXH2WJjG]A+fll=b#]Al="
cXNs%+$.!;Zp^#PC"9QSTtc<2b8?<;u5lS4Id_]A>5*<-pD>?@_uk\><"h+c"q!ZSR]AEr`11u
1-E9oUGH=h>/X,PM)h"&EMl(d8b$1!;"FgUcO*!W5ft';lnM6R1X.:qq>51^YI@\h<gZN>@W
pK1Wk@o:1gARiQuq5Dfls7^IjU$9"?s%aY:I_-%)NJ`cO@kE`bM.ZPN'S5aHF[s_ed=[R+U.
D#!83lC&>V?5u$.)#>-7UXt3P_-dgq00W'p7I3]A!j(WmPTZp-N(dUQm&95l;45b\$V':UG'i
CX26@aTsk,8t_\6D2\:013MjI_6d""3Vc$o(P/JdSnusg_E)Ur]ANe2^PoIKMo,bV1GUnh141
:s)`g+=o@SDcH>-HuHb+3a^*1uV_<'Rtid+gE;L$:GED,?epQe<X_o#Y4F"?]A;Rr6!e<+Xt`
1b/)f0GY9Q2oZpYB>+&,ODIo7:t.YB:c=Fb:Qnu0"rPs.Drkq)9hLG#o7V:OpW+9Uh]A3^oW^
4K2M,kKC@M'\G07tV6Q-f[3FRai)o.:#`mB#<$H,Y&W%*g)2ic]AaEl-lO?^.SYKh^$Hd=EF8
E:/'bZNB$:jIiAAolng+e8u\<9%pmCmN`8<f,1',0qoL@:=V%(#)Q82k8qtKs2XiZpK2740B
8KX3Z/I))C([0>(-VQq7%YuO?J=>_R4QO5raA<@XEL7&#`R;hl2`9>"AD0P7]AAQKrF@=h)*Q
iJU\ZTJ?&G8RX_LocIp<XX2+<"pV^HY9k[LG7_sOFJWj8/bI#r0TV)iOUCKKFfbhYm(8aIlr
:R5"cM,G6.KS`am2VC(PQimrhlcMrk`cTTV<2O0e*O[3gj56!E"I7df"'T*m9pZGfbR)9il/
hnK_5>N;A!KrEb6Md:MTAu.F/KM[?$)]AD#A5i(0(7EP3eJO[a.sLss/Oo*^pJ-;DN?e4rT&c
)^fWmpIHEE]Al4K&E#9#IX1P)_C7r_$AV*b/g;<#rRa/h^0Ss`XjFD('P]Ad\"oO6GoXAbD["A
!nLh*a(Cf6&@A<YH;Vp]A_+5(RV6'&'NGKC4@k]AQ!pR_mPrha@@=0ZfM$+VM1Y*#%]AsAp;qs3
X7dL1-a+_<hB47q_d-gr?!9hM6Q]AYKZ-o45Q%]AP3%$&3b;fVYD.+c;eQlo<34NkhHKEFqliO
0,bu^*AB?ijui;66WJ(Lh:[2Fj?Y,a[Ai@rfJ+2Ok@jkZ1"aEEK^5Y#h@V6V7*ehS`kogAFs
^Sr^,*[kp3QLnRr5[7IU=&6]A2Y5kFFAYn4Qaa%,dH:^]AJ*c'JjkE=7^h#]AG#A!_`(j!^3oQ2
=EeG%ioui-,,j>^`e_n.>[4/u?"'SKj4IiNWrD!%>jdoH6LFh'1L9&rXoYlL%iH"N*K]A#844
c!uq9VWH-@D=[pJ(9lFq]AT\!*JZ.a8rl(uhZ&fHGK[4G\BAG4"fBSgFO/&8O,-.T)3Uo,I:P
(?-rc>ZA*k_iTTc/8PE>@S0bpd!q>2O4VUD?rY)*<_KdsIemB/5K^Jn3J)#"8.]A1@c5qqIi\
%e$[O,*TX]ABOZ*c35,2mIK&IhGc_gTGBDdumIQ=YM->1&k`NVidA=I\eOHI4qP_!Dl"\RL-i
ndC3m8LAJeJ#';K`9C+,(o-(g2lk&i\ipIZTT2cbZoRceHZuBEfe+Yq+%f/_:ie.5daaFeg-
'?rMaE&)VDN)tW#mkZYsKk-\TWq<_DZoF:f#[_^?[<E4hO\So1E]A6[5A)E)2o$-kb]A;p'kX`
f(mMp4p_c15,@7:WT0q3ljm,)6A/kDCTG50h'--63]Agag1(Hs'/6e9!>H&kA*s7C`>7F*]AjJ
TYOIe[$1!ge)gCMTXS-$gf@[Mo5*-b:N-/,ZiPFVipXM<3#NYm4pqXba>N0d.6$;;^(go(I4
!&FH0hs8EA4W;KO^=HSPAUm7Ihl&]AZ>OiqT";u9Vb%Fj_bm62eZSULleM5jq'i;t<RQri+H3
f]A5<'1I.)6DRVJ%Dh@s*TIm:B/2+F0uYVokhHl2Qas1<deY0("QrO:n>+0>HNfb;(m&^`LFF
XT=9&;HVT;(k-R6DlYFC"T:R`L(cM]Ae?=Lm#YT.Z>]AH`[0o%>(h.$P6#?0LpI@OiIeh#\>\>
PXqJBQ"X-XS=HTYt:[ReZ7@@G=V89L&N"qjd^ItBkckeoc[0)htt''B)-aK?,.Eg9bqYS!Mh
e((=q'ljuT7`V;H[SGO^4rq.R#.j@,NK-ScWk!OROJIBOR82R.'(%T1<$&]AH#0+B@?Rs8VhV
(LXZZRdhJSNhrH&Zfp%oF-<+EgM>r.c<,:t<DAM==g5PERgc<9?D<jkKJE.OEc@*>O&_4+.+
+4GjHBq.XLgp_f!&`(;0o'f)Wo!7l)K#<[G3#3EZ&]AIGbIj/iH2X1bVl8=`US"^^qFq#L_7l
1+i[TiM:JI"*iSj!&m7O$lSVVO3i5JW#[H3Wh3_DGEa)Rp:"XM;dn7cK`W]A(S7bN^$F=aV;b
Im&OJ:#*,X8;5:ps4_maZ$)_UG1S:>_W*IDr1Qai`&&`&2t@8pI28I5;(#G\CsXP2h7+Sk&g
4@D/+FQT7/X>X*TX"O/$g<mVAHF.@*k(K703m[m$/)rc%qip0%I,1:=5je-?PhgC)`:*UFNM
$LL:;3q@"r[NNu$"fm\jBi9rq0SE>$92(e'g@;XOq9AeegTtPIn:?#t(9&d&`j2>.1r.r,Lr
/*![Xri=^[/L/Q%L:c-.)e?q394]AZr==@UgV>DAW%r7aO%2N%q&u&Vp)B1EG(Xu6,iVe3nRE
"+f_6VEgr:51>i0'ag%)@F@-Xp?@((DfCc1nR\q,h$SEeW49#6S!QYYYh,l1a3k`,;`n]Ad2Q
b\#4^YY.mX_H!%N.4<ig.[bsiWo)JB`p3@Eu[Vp09VA?.V!E\0]AJZtJYCmNo;>WU&+p[?K06
u$$ep?6*]A(^ldrT;"V4*tg.neJmhPhR9Y4`KEH;jKY72sgKp*.MOf/`2FWklmdlsNLS+SR5t
'di5re6AaDZqH>Okh1`LBs(atpXA+*$,lSY@W0JXD"M6gNVg1+9Ag;.(JCbF'a.j=$$6MEZ=
M'3F'sA1T1\$Ke&Wn_>Q\1O>qM2Dq\"!nkABkZ!6cZ4o3,.l2bE;#;K$02Macl`BA(V[jsX7
QjUG[E*;!KAlMu,.U.*R'm=MBX5)T:j`W-DQA[u=X)dWBo(EUc*&L.*B<WTJ;JBgXMPC>,6c
%KoRVogOq<]AYEYV?)&gj?=tp-soO5FG[?T849-ZjI2q'(C;&*<:9XT"`>KE8#@3A<3p+UQaS
T9p]A:USOl\3!lblN^U2Yr71Z(o/S!eW_BeKHFLL=#WE_!iJaG(g8-<KFm^d52`2Idn6Aa_;C
4I?bfWW0@c<pk=*U3>Bn2#lhT_T2]A>rpNBI\XX.UXC#1Scu+B@+6c*qi!fDg!0!P@fTQtACW
;i>C0`th^3a52IE3/jqP[N.p;*$4"?gVmPPtp`d1uRMBe[9PgJQ6*a]A&4Vs"f_8Mg#/sEc?0
O[@\V/]Aaao3^Rh+8Udb._JC+iBO3/7E$H_kE-qdOA9fFri1R5@o5&ol)E(9r42?4,qp##M84
-LGt?/5%L43TebbgX'jHP*C4bj')"\d.)p:<k-Rhl-d6=^:IiQ$W)J]A$9.-%k<>R%+7<I*o+
&W4q[$!<<eJK<Ne5;d@/RoB>\%g$Ce=G]A=O*_f6I0h<?.l3E?W`aX@V,u%]APs-8AkNu9?mdG
OKdmfJ89M5]A_nT+!/Ih;6bPZj=)bBQqf$r=g9gDrC%!'(^#f)afTVX3$mf@jdsbsE@Pp=o;t
oL3HDJ%DY,'sapG>)pPl`]Ak7l(@P=-H;oHYjbses5(BVqf6^%_A_(7I/NMnX>f5n8C8dV\_s
sHG0gs\K_H3T&tW^6$W>?H]AZ:sOhR/<!F-s5kQ94bk<G?_-m;*m7VT#XltKuS20F&kMeuQGQ
YO2smKG9c$Sr\GjL0E)=af5MGkWl[5@#tYX3'u=RlLe3k$o%$3PYWUD!LpBRR3&tI=M8:7]A@
54Cn%#sr65_YV3qmDnLE;*h?Ts7Yn-![$^>'Q<'T'^:qE#dPf1*@I&RD)[ntL4L"d]AsBnW\[
E@<h,nh=Ij9Y<_uRY=fHEE"#m$YNAOoY"([h6bIW'f4"D6Cit8+GBX:)6([5(To\MoU,Oq#t
p`,fZ_RJM+?qa9E3Z!.4nM</48"b"N`P:hZsWpXa*A+"rS9D$0U>Eho[dOk\Y5S\!co$2;<b
i"J=uB)HYb_!"<hMU!-QD1*pq?_7aK[0Nt[?ZUQoE2;ctai#RmScUC8@MsF=)de^6llsa!Qj
$FA.n'3[*Hm9ImWNascdh/(G]A>-@^K1BLc7(;8(p<E>TjCf8"1qkTnVli,Z2phPel3'3($>[
K6<.o^MI%fQ):!n&RA[MF^@H!"\gttX=;/dCM8E*8_@Y>)[Kj<saCu![Co1`OaHs]AZ`gg?l"
jT)`0$!9)b`E-H6gtg/nJ74i%HI@]A8;8i[ihK61;$)%S9-@1cNLT8D&=o*,ihQlaJ0TE`&X_
_M>?>^"&QSli]Aj2ff$cM.!tY585Wb9KSpguU?\ae6F)gf=i-&t3#rd#1YiC&GAZ?V'RK3*Bo
cl(;_nG<W[YB%g&(5sX`\*qU7u?O97irF4C12fp/q[C=U#>GJXg7$(6@?5m6eCuj^>&[M$%C
7/a/rONOJcUNsTUI0Bhs40Ae?r^GO]A31JAQOPDZ,9s+,=5uZoH/!h1"a8/EK]AIM57DF3hL^(
2F@HLu#IV2e"^G[^EpN1d/%'cLip@)Ae\@,'@<r#h<mdN$/L*sQ`_Eeu,FuIT-:nGue.YIB;
,@g1f3+hi)fM,]Aprf,p%Z4GTT;mX0be=d_d@pSn8,>m?1C,]ACcVc$e]AE$hNn3$t(jS,7dd9:
0E?L)\<`X>['qf;1n*A$LH4:g!Nn<:!Q.D^Ii9h^O&%P/!52ObF8!*PRJMGQ_F0.kN3!Yj!C
+I'lYdo'6F]AU]ARiRgF]AQ&Di9:SDuHLa"buXF5Jul?`!35C?(A5rJgn;eac\#gcCa9Y4r'hcC
n%<%gd_YPIQrK!>hH4;mof^:rA/hdF2;_@'3spR6!<-C<$4Wf`8CfcFhJl'#d>JYmDk*[4Yj
pBj%=p5eK.f@%/7U3UZ2s1PU"hdULUU4fL%ffq(^OmZ<(Q3lYW4Z/>[J)+qiA.]A,)0Vos?.r
nqc`!_=lIOQ4HnhA)C2Y3:15XA<06=FX&5?bV&hI2MgIn`gk>%*^GhjJ3O-<qf6]A:pRnC'b8
Yep%Vc/=/#'nWru@IB7O#2HQ<L&`($r.S9+@-!]A4l<HElKH=K^2Z6pZo//TaDl?)aMG3Hs.X
6_.KN>aE2s3F"$N1%lboo:Ra)M2=QM?RV(Q#gBbMlQEU\1C'FB`qSP0IJ/JM2e[A)hV59n.i
Ffp_fmT3,p\ESBL%s[MdEcct(D.>IlXT$4i76E$O42t\5h-Co!??R<[Qg83^.WC^a!<rP;'0
s!=>Hq9=f/'c3Z'+U,R'jH:(*U":/ggk4VBF!j"3`M"eI^(NBcuLQl%HbJ3lD%K<.B551i6+
SPhY50R?eZOK@Yt-@Q,UYX,E":f40"Ljf*+<9`IC(pRaW55qYYbXfH3[ZO0$a@j-H(V>#aD>
pm6hI?L0=oW59,oaouVRX9N%tU?jdaEoX))ThW@bB@+Ysh;sd!=YD#b-hQ9%J$RFb)i:8(HG
<A"/G2STN]AXg.`@?j$P_WB<P%V;=]Ah(P*4S61gEdNJ!HAVgfe7bZ.Mo'&:pMGO77Mfi4'EuR
f5]As2ta5Qn,7-?4WR)9j]ApnICl3@VW2OFKMieVok6SEn6o[bq%Wj&\IuVLF:Fj&2]AU>KLm36
h_0K!/mc<s;$haCJ6gj]AEU29]AOZN&!8r^e?(DfqUYO"k==<$K\E9[J&7'KRBEo&dD84-169V
aMERn!_>gb)opV?Rt!d9]Ai@ckXn%tcfc&Q''J(:XO*\e0PIq]A\rop\%M@WlFK*enl"DsYY1O
;m`;"a,*-]Alg&Ea[Hm7=\82=Zg;s7KWYs;Id"M$G'a;nF^NFVM8c?<&uon^Msc]AHs?-JSG1:
#!Tgb924)=M5<6cIRC%Q4L%\?37L.Zk\&]A6^<W,2e5V]A,<REQD4I:s@XJ?%G\\Rl4HcCY&@p
0,J&\qjE;]AHITmH22r,cL87m3eSg7K!P3/lETsC3]Ad*-U:ER14htOA2nP#-aO=ooIuNH&.IP
;mDLZuU*+3]AQ'BNjlB*Mc"o(5]A,FlX*<b0#ToVRQArN_cYBVigTu5p9p>`-;c^=p#/Xo@,=7
>'F`^F%#@O:c)+$RK5Yg2s@.!J$GlJB3HEt:FBEg:gf&jCtJ=:q^D5;>?Ja'-RVMODr/+%hI
U3V2^ep`e#OZ>r9TK\$oX<t2eZ''T*&JW"N7W<;)s)RpHT&Ng1fL@]A"5/W:*-&e@'9AD0oMP
McRY,?O[DM#pCJ0*)fYiG(0qc-';.!Bs7HfX4GUtr-k4<C)6X:%6-9.L;?5"f:qV$VN@Pj2j
ZmPdF,Q/]A&c&Mi!EHQ69mX]A8!p#6Lfba7%NRMn2l6A7r8-qjZ"fU,*)d:uAp2Ws;801gYc*K
Jo:2+`Ip2$/Fc4^.J.X!2U!\>B?[RK*RLDRIJkPnc#<R"^+\Y%$d@7N4D&G[,m5Rd47d&i=X
5b0>(jbbf(l08lfBB,uJp$Jpu7L2O;lR:fL!=tRY!bie\SQ%G=A!/.,lRra_S0!F<1i]A&jW`
jDas2+[AiosP8-kqAD.eLC5?92c\5R2T9ri\3TA)[GSrB7dRoX.q#WHB4&0He!['AZmbTIL'
=&PNa&C6'N-Z0/VJH;6(M)?\AA`i!bcV"Rh[16u\5"E8RG\B2^sq\8jb\mkLODJie=qBb&\B
u8c/6p6l=U16M@:2R4Lp`'iQ7;\b'+T^haqKN4OV=hS-pV)@bDl/#TE76d+6(ec)T\sSl8:a
:H'.atm>L%juTgo1^d#TE=)!XD*FK/4]A>6GMFYl`CV_O@O#'SG1VVoP_B[JGC#GC;J:Z`W8Q
*"He49lVTTpGhM_DoT?Tc&O"ZC[cj"mTLuGR5`q$o6gO^ATEQ^c8u6JD;.iW,Z5-QkmXfdT8
^S^[##)XKFm?o9W_k;Z,Sn.;?r"T+2E(#?S[((#MOjHrm'3rhR?e]A*R%SC?sYI2q?Lg<N*JR
Z*Sbf[@*`-kbEI([Rbk?aJ38jT1X&`W?0l)[n94UJ'-d;.-Ed?<CVWTs*l"3J;rR9>UK$V%`
H*/@e.F:@6c8s9G8:'c<hmT\oeOq8*"]AH*?Q5Klp!X*f[=837'3]AEG2Y8\VS!PPdd!cLU\FB
nr8\csb,A=2]AZFOKA)?8CYN810r$fgdnf39,50WEO%4@$cu8J)PW[q?B&LCX+E-Wf$ZpDAM`
ph)K"#Bj98")>KGdO8Uf1U&>RJTY;a4WC&1ecrZrXsLTiBl<;e#Qc=&ZaIW_9Prdk@0@R__Z
LogBpm/0QK7%0%0qFoURc/RKe7g[R<b5G+uuu1E_@XnIoSlr(BeIgap3K$AR<YSQ6XUZQa`Q
nXfP;Ul^o0;HW[Tn43k7^TA!,l=L>&n+@o&,q\&Zk1$%f$V@%gB7h#JX@.S&L<Y1'`pM)Wg,
P#9BKE_"-'u4m*[Vlt9*%Z_9mD=\H*MI+3ZO556T8;diJC:\:Sp(AU6`cr^Yq[P*A]A5["?"\
,1*lRd_#_+_F)bQH-FjfING?86)feN0mX%pFh@cXC):=euBaUr2#lFeKq?-\cmTK$l4oLq9o
B]A)S.2qMR&,,oMpMjfJ6)Yk\U9cB.)C2,?p)$HD1p(N]AGT]A9)BWPP4poSJH`3,,]A23)"2I4T
[\poH8+Q'm?-S1_bRG!]A9YMd3C^!o@)"_O4pYV+!a$pU\JKWg^Hq&m(*.bI&g'RZ\//>0/V)
e%[6tJW4e)Nn@GYf3g6T0V]A,oghHl53%%s(]A5X9;[qrNL`!#btJi1rIu)"^6#!#O#Te@X$KD
M7K5:PUj(V+NbD`[&)K2oUA60#jg(ftkM42pN,"`kNSA9E-s^qP!tGq+K()Od@h.IJ:5;^r@
M)!8%^?+9CU2/Dh;dFXE>+p7t01NBh7):IBD.9cpQuFu`VB4#c"]AI<GDPVDMnF'd4:Tc-JLA
[1sQu_93`6Z24U+X]Asm9-gU)F]A_N'DSCQ0_mKD>9</uPTcK@Je`>Kmr[i;nH49F(UI(qfJ!]A
>-%e7hY2?jcQs:)jC_I6--_2(uB:^L?t5rQ^VM:@b=_CI8LO@FUp'ruV~
]]></IM>
</FineImage>
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
<![CDATA[/数字化平台/HZW/1_Dev/机务可靠性分析/20210729-可靠性明细清单.frm]]></ReportletName>
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
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="7" percent="50" topLeft="true" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="3" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" cs="2" rs="2" s="4">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="机队飞机数量"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="1" s="5">
<O>
<![CDATA[B737]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="1" s="6">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=飞机架次.value(2, 2)]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="1" cs="2" rs="5" s="7">
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
<![CDATA[/数字化平台/HZW/1_Dev/机务可靠性分析/20210729-可靠性明细清单.frm]]></ReportletName>
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
<C c="11" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="2" s="5">
<O>
<![CDATA[B747]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="2" s="6">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=飞机架次.value(3, 2)]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="3" cs="2" rs="2" s="8">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=飞机架次.select(架次, 机型 = "机群")]]></Attributes>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="3" s="5">
<O>
<![CDATA[B757]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="3" s="6">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=飞机架次.value(4, 2)]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="4" s="9">
<O>
<![CDATA[更多详情]]></O>
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
<![CDATA[/数字化平台/HZW/1_Dev/机务可靠性分析/20210729-可靠性明细清单.frm]]></ReportletName>
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
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="7" percent="50" topLeft="false" topRight="false" bottomLeft="true" bottomRight="true"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="3" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="4" s="5">
<O>
<![CDATA[B767]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="4" s="6">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=飞机架次.value(5, 2)]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5" s="0">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="5" s="0">
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
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="4" vertical_alignment="1" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-2171684"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="104" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="88" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="88" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="4" vertical_alignment="3" imageLayout="1">
<FRFont name="SimSun" style="0" size="80" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="160" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="ColorBackground" color="-2171684"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="96" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<f:HdWaGp5.p,\*k!p6O)25dZaGGrjr)lOX"@E@Be*C;i%//:,&*VLbEX)Eelkp_;OL[UP*
pS`-l:r,OBS)C;H1RJU'M#1ru]AhGT)@!o?#=rGs#^"'qUFGM]AW_4Hmd%T:*<'Eb>-hA_ZY%F
K@J8BPX#J=k0bZTX#/p?qA)L^KApjC$N#>^jICB"4YG0JMgI^(V^IFh.a&jV8hn-)c'WjLmN
jSYTo3X"+?*NHfh+_D#&EVA@X"udi-.e=;Z[Vj^SEZlf7i$K>o1$[L*S$*@-hB?7r-a7EEj`
;JT%%n$D+?m83hp\(\6rsp<<6X=Z6O67m7Zl40>jV\/Z$ON_24q"l3FsUMW5FhC/IVp%Ca%1
_hXajl-?qs772[td>'TiT!hs"0#in9e0J#7Bu6i`Y=GPp,U.]A%WN'EVGfpjGc*KjoarB-#FT
TG:rK.Ds2&I)cmF@\f-[*!2\&B?@\j^qQiFaD7MN\VF:qjp@=#fN.Hqp4[0[fBMiZ@OO8\j(
[)=aQJ8^h%LfNkMpIJ1HI.o%krDsh$K,m,5j%TZ8QfcjIq=%?@l)$S_nU%`GI`O<%&Nt\;id
pM66)q+YIUn37PjR%&u**YgE+RjBH&i&cr^"8Y<9ga55H[qho,D_C(0UJt14Ps]AAQLl@s`7N
&kcq@.CLF_h3,fTQq50Tf=2^[H_egK!Z#E8GWSB<bN-)0QWNMi7,>S7\'3U\.5F%OipJ$\]AX
rT+.&`5WG\f"P^eY_%c<O:^MDA+JVp&(`@uS5u5pCq4fgCW0E@@)Z1*1)\4.EJ!u2nWI?U3I
=M,98I&iE;B1QKO^oJT?M3!:u6,Qh+"l%fFsDe1Qros.XJT1g>mj-1cl-sh>MC;16Q1'khU6
MMcIu]A>Qi80'L3&87oagG*QR5JpPLJ;'E!0eoCBFb8`dW\R^[s./YKg^j(o:9'TD?Af/=)uK
aD2lkN<W+b5S7u'>0882=B@[R.%Oo[l(8/q=ZqiHNZP+HHT1n%2eYH_1TP(#ETgEh$`L.1jB
RK]A/`ip(I+*j[*J9fS:[lOp"benT+f/oS;("78_i=BSU4MeA[[DYT#M_;l1[%.raR+F4nIMd
+]AfWQQ^Y"Q(<B!qqKOo,C9[etDctnt&&n['hVW@<WANGbhpCJ2cR?$`pguS\UI+3cm&l2T!;
`!tiKBAcDiDtNms2K\^*S%Vo/4'j+6/s?i7+tA]A!k@m)Bs(jpbn=_%p?:tAD+G['Zca"M54`
L)Z3]ATd?E,3-fdGGXrXjJ<&3kO=B/[/Jp8=-2&C)^]Ar,Y9)XNUtl/i(Umgt\,KS.J3R>r/S(
%SWC?\`;2.W"=s7%0t++C\sfSoo:jfF0-M_="m$Z=%MAmHD9"Pi3T\>S$ji3>=[RqRr^PjBo
npq(=;PH(N1tj"BGfG&6PQ\hfP%_>sU[qh'$u\YLX#([Q>UiKC#W^aO8]AEskf=BWAp:)HXCC
<_W:3..7'UH3*VJgLb3rn5]Ag!4Kq7/2V4<9U@qeE>7s%#$Jad)JKKl4h&;^["0cjic.)DE"W
%XkF+AnW++/QN``tt*=jg@0K<;N*;mq"C]A3Q>:;ZL&iem4l88W=V;2th4/'o*1-DM5i&qHVp
5Ac)!X"\F8,6<U5AjM'=(7j75_:U"*NQrW&uOYa]Arq,^W"@9]ATn..3G_Pqof9dQ2s\CC[BKP
L"Vh#m_F]A-KJ^eS*^r;=HD)nI*QUfLDBro.?k%r_LRd%ZpV_3J--*ocJGc2n61?X.c_eSVnI
85)[09&2fjh84aW(b*1Nt14)hfdkdRJh7]Acak\1dp)Uc1W&Pr-_gNCU`8VM4(:Rl[`2!,hJI
iq\2d"gss:SE+KK';?W9&0<Z7C`U.J1mh@P7?edS!de4>HZ*@t:ADSFHL`-LmU;[G@,<mQ[Y
8@Lo7(+<-"9h0%thn.^Wt0NAoE3b[Us_*8b6hAS+gm&^"7-l'64M+TZA.a=M$#?dQY$PcR6+
1+_Ql(>YN7E6%uO+^nO9+3L&Yt_LK,:b['_^,bG!TX12tqh56[+G5m7[h=3EBM_@#t<,g5!V
9<C!UN3ffMs]AHSji5E3#OjF_:Q+Ca$5Qk3*%kd>9usm=dq5#tFXWEjIJm/8);-!&=5('qN`Q
Ua,Pb&]AU`6a'&>n%n,uSVN'bqeD&Nr=u))G=/]A2aNK87nUK8fTLumt>mhr(',<aF:5hMuu3P
eLMFNaRI<GUH5)aLMZBlfu*+@`rh*g=o4&sP@/$TKC`Qh,@+ihIF-1TrZp"qk%rSW4t2A(T@
M-P.,sfe>g1I!'(9?LnP(\?AM8ZC(We.d1=gurFe@lW!\GsEIos&_q8$B-l[uf0O;mu<ddFH
kZC:LULH7jEAMBHD*c).s&W/9_nAJF#AI+;DWpljW`E\OLgR4-b\dqKYIW%8c)>JsJipjT;?
me="T,uM%I_Xuf#kJU@mUEL@p:dt/lF_keC<p'B#eQAYR7Juh)/H;l$g<L>kd)N:hAu67)c[
2h\$)g6QF^K0!?r.2?3Id&NIhQ6MkG%<2fSBu*eYA%S$atrq0-Po%COuOqPkM9\qG'e.taOQ
h[1IfgEM`ZAtoN>i5UC6i36;KT80=lQ$-O[^,sUP?0?U;il#9DO'XR%@a:6qHtU&EC<[N+3C
d1S[kf$[+DVaRkZFuIYMp3/o&N<USjJ,"I5iUm[\SXTfHjiagbiS;YP*KF&oW[Uk@Q"uniOH
QQ?]A<G#ZYsmr-OJ#+-k;p=^m*K24l6`@,q()hX0k#9a#%66BXbE(jEKp=<b]A0GhaD=`,`NKa
3ng&1]A:'=bDSt/:!PUVZ&J88fY[K>7;m4sKO#i$"'L_t6N9`:0f`LGh::C=*Fl,P>)d_>`(M
TJk#akP`^^sTUrSsqPX!1b;+%c3)uJtoG[283f8f<pL$Zc#;">kaS*8N"(h,J4Po0h_@.&M"
GDiRp('h_UEQ*j5Qo_F_$r\QqW0Q#e/Y[MaW/n^:G<eknqn723omJiXLR%Qb]A[@LlWq)!"\-
;W,8GdDtFEq:bk2%$@e2mTbT<L_\/6n5.MbRtQ`E>V-5`?T:lWM6o.Wrb5ce[Sh)mtu!KreF
\dr>91TeKt3C!;ue<.hhQ+\G@T8Dj3.H<5.b\+13H.GM@2nO%_E5]AqM*W[t[(Q<o&,es*GCX
^3K-J&Y=`cl=f?<AYsj#bkCl*.=mJ_8jgn*.LD'*T4`aSNXOr1S5dC3cHT`o3,IL?G#*_9[4
Aq^9dXiU@OL?d=>==ZQ,GMa1U_P%b9OAS5<>Y2,@/L0_7K'Cg66]A#eSTBm;gIr->9YucQu+s
`VnXT?OX!Q)9Wj=%Z,TF[:Vor;;>%K(g&u7J\KaE[uE5CKU]AkmUWDX[!&k&K[ngfdgc<B^oR
_=4bCtKGLb0Z'i"e[RH'_Q'ngBRNL^l8ZKsW;=s'`&?EWFJ5=l0+f"WIt!@H;X2)j%sYB_(c
d0j[?VNE->V<V[)pX_mfbD-K+H=YB->AYTRk:=&nL7Z;#$@&PQL`ddNI`/9:<P5RQMa*@$lb
tib'5@/dhM%B[j6-qUo3SpgOUi0'Ee)IZdfiEetXN.,1DFsQm8b!=(74WX`'[)ef73Nn>?<;
dH6_LJ#)1rum1G^0?&A!9&0(.+jSZshG]Am=tn[u^C#a"N%K]Ag?0E*!u,iaXWJ/kW+&41Yh%2
^XtURNJst_\=tMALC(0`FPJ50oA%Bu!hMm(S496[NAEk=5#[1YmFqj-KUkV609<t6C,qW)f-
p.Op&B2G8>:cHUniLU6Bio`AAmqAGW/kA+t'CSf;1=7/2'qe-fkrA:m#<jWfK)Ui5p`8ZT&D
js$3"+;UJRlQL$&]AncIVBf)pJ/KoEX^[oR0p(a&`?k\V38+$p0KGuXf,0KHn@.6oNQ+"2fHH
sgW^9"kQLN-=h!%rP$]A6Jn*8gIFSSHstQ#D7/'Y@60l&_g2l.57+Am38&uMlHdH&Xoe6NkcS
(_T$i^Up"XY#Oig6Uq^o%Zeorc?Y0F\1#^KC^H*bj@Kn"!9JYkUb\9jd7<K^(!]AHBh;XlO0,
*I-fCqUQ52O5l&)=Qm<VW)(V()UFj:[Z<LFD>h!C$q]AJ/n#8=)&StZ#n#/Dt[T8EKCal1@/\
gJr&Lh%1Y;BW0OI*K<7O'[hW"B\0oCWC[J&Y(bo$OqACW7HEgket77HqFKC`?QZUhN4jd6)<
\s2/Fld]A"MX>#OOYM<*4\mb"me?<>*5&r!k.2a$E(!'B=i8o*P'i&G6Un#eEmNW?OE>d4E[q
bd=;SmX1ERiWg#57*)%S7[cns+F2BcC[(F2(j%kO?k5ukJX`]APah/jl0XGuU4`I0N1Pu+M)h
Von__KHkph"3&\krMamXW4ab5M;$8^"Ir8KEJR^f3EC$KlH$nJut/-LA?qNS\3g6N6QBGj\h
W1m+1hVeN04b>G%[(1(hGA?A_<=_R4=QP)PJY6I/H+X_F??:<WhG:+/5F_J9CnOjV=X3;3Db
%"`PubO>/f6QH\hVFRUPrJbh7bRD86?]AMl8SEMP3[U6XE(B"_Ue&TR\pRt%["I9YLZ!DP<Ie
s0$ih"W:"E[*c*l:4Q+C&a0afm9h,'WG6S9i-5OlWMrP;*)Nkk-fp's^fuk8=GB5Oq^[b,l3
^tMEO\=RHNehZ)nJtq"M":)<MA&Ldi"a2=\?@gg_T6m1!I'X&8[Uo:eHJ,3l3Q.Qai>1^dZM
=[b^"K7$mnUka[u3dEgkuRE$PeVBDi?fc")Oa8HEb[LboAi87[PPiKt-=UQYJ3ZRltApP_iU
kC/OohQ9ZdTM-LQ[6#GaDb2"CLM-lJbI6<Rbk;^<Zp\mT8"7rNcHRL9D09K;oS,c>m\sgt!6
.D37k1@'HZRtD;(1EhPVdk2lMXSX@6D_enQAj<a,WH8m,F.>K1L"UqDoC5><LJHDT1SeTk"0
0(BX1U<k5>9rU'8k@dmbS4YHAHo^ZefeIR]AVMeJ_GiHV>uqe@Xbb:bC3C\D'Ag#^=8DrJ7#L
;je5f2>P3!-&^"amBZ<VjK!$K$i"8*`oZ=Eh0Y8+jp6N62YVs%Dn6?)&(J&l$q*tH$+-)M2o
@sEl4<H1ktT\=A5[8aYA`0P9)UZiOsif;r$Q5A8+G'Yo+c\/Nrk`0&?PNXAI)g3m(mJMA%Gq
kW#CWHH,)G<"-eQ+B?*_NpGCr,Q>c2htf&YTUaag!gMj8"kp8Y=B2qGU?O)F=nY3)B&Ws>SD
YK%KdaK3n:\dr]A>laU&Lm'hZd>d-h9X'a-NWgB+mbWKLr:mM*\/PCesMPuE\Kro6=dXZIFr=
Mj_KiPO'%K5G<14WHkRsR'-S`>;.Id+$Y*@cMB(K@aVORfVM?uRF]A]At8BtPIK_StQi>'`eeT
*5-sOgN-k<!U"`L#aM\0K]A&q1&3f,Eh_5G[Wjou)@@^[r;]AT#P(ZL7>M53ZCdQ0GU3A_K<0_
DR1j(Vp-/6coVKjXIf!b<HUr)0?I8Pk19n7=nim,4-YBg]A!;BRcC:etucbm%U;?H8"C)U'`q
a>5co'ma"+2Sc\f6c;Su;F<p+9o5ulf%R&K;67sD\k&_urKa[4+"r]AsUaj/.74qs"2MtJAYd
@\GFVLROR88Pdo2/,=[i-\taQ3hh2ee"%N6dq[rB5`0o\tM_^A@NdPc";t,D21N\1(CM-6sQ
#?(eVg*8^'e:O>TQfN>Veq\%]A?(81_h*!8L.7nQE08J["g^i%j\3M"Hk1"lG9?-(E'U(Wfrr
"LV6fGqn#Z+!3.BHHc.8=nhR3UT3=Ig53^pW5jo7*kUL?LD#qJracA*eggo",-Y*U%$!o?k&
6/1>:f+EhoCN*R"pAkc!36''mAUd?Ot!FWG\42F^n8W6(`I-8`3m/m]A7(Ft/2"8DB0p4KZ7u
pu(oWl9OW5nC`m>S%U*R<UYd:fA!s!=+,Sm0`EO5>Xqf-NY]Ap,@q']A;Kh(QgB6!_I(MNh/:?
TjT/81/eN0WPL5m!BBZ8[VL:7S#g:WV!qhQ#V7M>Xc7+cL#<e(qE0*(?$Qr5Lt=?#aOsCiXi
bJc+_drB(:*pIC+UU@8IX7Pag14!uV*N0o\iGImnd77S?-#Z,%Po[AGk\XUl;`2c:FdKFdH,
[BXgK2?;kK-ipk"=73)E`+OK1J,:'BP/]AXpR7?4GnSGK8Ok7p.o419[jq/!IMKV+__+@k<T4
C:n)lo32j_D\RGrUnfOh9LWJ1L>SGn0K1Fd$ul,lTgZ2sfBS_3%sk"hQfVQ9UYYjkXSoaiUe
JEf^h=7G_SF7K@/gAR`)VRjjRl2">FE2MtHL2!`n(Z)At(k`0mjKlB;P+MAT-"/gBN"LtL?`
h9t]AmQQMd7!m?,oErhCXH#TUYS&,dKa[h2H(A]AMLUFeN688C]A(V@!'dV0Dp9HaEVZIkn\SFr
G84WT/`d(7'cc%\V<?7$[G6OCeS3D[)TKTeuYR('eUe8GXZL+5GN[aSPENViY]A\SLMQ1-%fR
gRFa(8s4=i=$atNB,LD3'Yu(`2;RR301LUq`23MWBhQ6ccSX.2In+G*cD[k:E3b7]AU4&dZet
IkHWOWMfGZ\s*R6C)T]AC4H6R.&o!$8^(2aFV?CMLGn`lnQC;-><q9NnA:P8qg'L;iu\4(6n]A
;AgDrF8#Ehp<Y\PJr0^/d(s'h-VJs]AD3qH6aiFtt&+LA^E>&DG#t6'N_g[+u`gJ@o.EaYACC
8dFOaYeTIU77T[Z)MJ)RLdYlH@sHrJ3e9Gh-XR4"e]A:,ZRl$j^ZqF'iUr?%UYsMBr/]A,as+X
U25,NY6Cc>%H`?_3FHI-RC<8T$f_Gb^EX7E)jT]Aq)Ll]AM*8H-/J^Z\spjuhmNME,be1cbZ7;
s/,YK>`YX#ELK:Ot#grQCNP5ifh0UeQOn1.LJ<D[5ST\e85ekP/D]A#/uj@Bjq1=u1b<Pab_/
*T#u)]AXrlSV;:XqR?>aaU@)>Z`/cIWRBX4RsC:DVrOP+Na]AOn+gd.*BJIc#K@Z=L^uSU+Bcs
mckKgngYV_WJu_;/p;E@7?75f2!QF9UiVNnE3Zo$cH<Cs-5fVU\2##D/!Gs1YN*bD6S'@Z%\
b$mr@4(r5G)r8=a#T&StrD,]A3aO\2)2WL-aD$Vo&WuB1GOY\9M);sSdX;hE`&`sQ/)cH?D-<
sI%iRr`7@(6N)>XN(n*bu8S,2qFN=+[2\hLk^[4+qc7Z2EYr0DG5L4AeHD`2Kl*c;6=-cY@6
g-E!Vs7Eq`Z^IEHJY*@1N34S[:[k%?;TJs"GF8M'Fs<OnKreGUt/:e+LTDt>kbk%CJ:mU37f
,WVrJHOVn$N[%d%:P1Sd7A/lT;r#:g_hp-R7'S`\;#6r3,e1*rjFT/[K`R8h`AqP@*3`o`AQ
W>PN7)qMG4:-`gO%7.rE[ZGuU)7FA0qID5PXSEforH1U-Kj`PO#BnXC!Q(uXa<E'RmM^Lp[,
UKaKNh*S*qlHMP/8+q`Ni6uU8,UTA!`2MeQ$%0K;U[C_A2LfO:i-cPCI5"=O"2AECkAWZ:A`
8G7Xo;KKY;rGh`OX1SLaN,JK7?!0W.50fkXQ&Zk2`AB7P+q*C15;O1fNcV#bC4p,5kW\HTBd
<KlScW5ko11s_%=V`?;!@5ZplOS;#A2ij8GY(/Q9@:jW7&]A5NHut>5TV/W`IJS>\`"NJ:CVL
#)6a0)b4me[NPTj#J[RIDQcdXD$qWt19HdgU'n`4(FeVo06ET)bn!Ukt*.P3,f(Ye;UhE?U"
!+?\e?FuU'n<-q3ak%U_b6s=)&ZBtsFI=m)'.^'uf)0liI5#X5OtFBo+4Q7j.QAJ(DT0IBF5
;GIQJ$P2'u@I?Ya3qdURAea8NP"X-e!.ds&Bn(6Q=A@WaIZ-G#aT6oHoC+#EW!K8CN,!\JNE
V,iFGB]A\=;jnRE:+)"H?3YNLfJ@Y!i1TU]A!tVS\CjUCTj.<GbLYj5UUG\g4iZCUM@#Od:p.K
hIrkZ.hPB67NBda-pq$Q&+DT/9uI$J-4jbJ)$YT^*"@pSC=&u2.EtI_$0.B4u=U-Hk%_$gD$
dGn.H5e?+.Et(peB2[,G(hd,e2=dV1!G%WEop/0I61F)f*EPYi3dLAOo6-ecfdETs@)8+eN@
orRJ>`an`/;rt[tO+s=1ph+rk+ULA2mBSdS:)e]A;'Q(\#b:ORA0cXX,c%9Kee"-=#$LqcAi+
D(0T1&P]A7Y1M<);b'a61:%1>RF#"qr.8TZ1/mMb(?L/;Gq=)aJh,6=D'%_c]AUt=U.mQCCaRD
FrKm4IW5dmKX3Th!pUq#PI!Z>._\XQe.U)m\&SDu#rW+7[oaSI`9ZoS.[lbBP]Ae3L($7.nB.
TWYDJTMGO]Aa*9l?_n/H&^Nnh$HO3<(a#OLTs%S\$WuTt3a>'m#T^eMfXqL,DR2@Rm5H:P`BC
OYbh]A$p&mB=kQn7a3fRQQl)8a+c*(m)jMGiu<V*Y3Hj>sdnpO:fEdjV(odJW=)Rh"O$3K"r!
SPo=4`_MiC)@.XnGL/bd-8KKQ.>#7J;\np>!K5m/9DFZ0\,`j<Fh.-CDe&73c49S"P&o,r^6
8kk'-]AQU&0f<X20Wh`UFHU2n`e$=W[qSd"*bZXdS!Y`,g7o=ZmZUW>H#PMe;cr0S,A5)`'9>
0mr6=D1FSfhQDZ9]A%KZTKC/6Oe/c5PF?_Z+JBA/RGN=P2'_gAd%-H?hSjS&\n`HjPU73*7Ok
Rh/:G??W-&hbNSUW8mL/.&NQ592P;T8.lf=S'_)@hm7j%DOj-3E1N5Gp?cs=++=R%DsDKrp(
07WJdVQ`$dc]AI;-"%P2^:jle$AuS&50:-Mn'qqCeRG"1KNR7;P8:*d_#:DCa&#hqaA^&O>nC
Zfg;1@P+>RX4@d.@K*hsMO-p5"qt+V\/&"0$&:*J:O5:&U*>(!,h%TJktR^Ri]A!m-CK%c>m;
\7%5k8CqFOYfT>8g[oHoEq7qVo-#UC#p?%R?7S3&\GBm"9g`5(1O1r(pXY-\?0,&&Q-Y5&>5
#iI1&()iUOsIG0lhbnG"VVpH[;9VK=GpEkjo'g0gNjC365??&?Zr9chXf+"<U9C>TFaNqr%T
Zg_s=#e1D>k#TcTl;B@Wdhe9UGqO-8&U]A.U$er&3!>>FS/+c#Q9R',0YFE$A;O\,at7nB>R%
^Tjpsk(UK->WnaXptKs#OCPh$8gp=IY$jd'hm6KBo9S`(bs_HFi/9^aYW3b_7tLAW<ub"@>k
o?UYpP=h;r&)c:`jRmIS@:f,%l?84rkub>B'lN`K"]A&hM%M]Af3XC[ji:TKU2YU!IP`##m,1?
Y.7!jb_N5p#GrO-0m\@F'-X:(3ntMONq!+>mZtg3X<*4?P+_YtX?Va"$@C2bUo/a-I2/%gD"
Ob.`NT'_'!>6/!L&p7(Z##Qs4k4L7C&&%XSo>O@QkhX(IV;)W1NmRrBse?r-qL'eI3iZJP;B
24N?V$Y</i=NF6`EcV/a-[hV5>7<>N?p?K5OQ$[FY&I1/c+DtBQtBn?D#h<qQ8PpI-RYPjui
JL4'm(u=[:d`J'OCnd;t"O<Gf<+*uO?m9@/fW$`u/$oVSg.R":;Fk:^Ql<_q;m;5]Au<l%8RF
.U=+a(%_:s6ioR9S?m#\s$/i7C=>AHag-_oGO4*FS?D]A_<%f.AV-"S%C&/&3.6AF`W4OpBY=
E47'qZQe[ESZIHJ60t%r0t6J\[SfLqKGAO>Y-@4l>`An+89tD-"%*gl<CP;"NE7[_V,*K[--
R8dA3^@$s>YF8S"!BM!+4CS9Ag9Z+B[jG%IgpA-@4%#&^_PE1dl_>`eDS8(9mlS@Er;Camq\
7R2/Y%6q(UR`q&8%3bUb35\*Q%`A$9s0j8W]A]A)[OADid*KL>o7<(uD/GcBae=EN2ZMN.I6++
;i]AdDft3Tl&IXU4dTRIt#-75Gg,.a3=;S%;/g=]AB6b$86QNrf+U35J$Zjn!nC^ASs!NkW<<b
l[ncP17&m+IE]A-`*B%?SL%T4_\QV@9r2l]A7ABXr$7:Xgibg'eemgHS6$g3a'UOK3.VJth4r$
s56.u?U*4Dp4sA\]A!0WXYTf,MQUH#k.j$ijV1DR_L;9Z%#?@;em]ApA_u-;[@&h8`/,F-(#@^
Z;IckM1e#Y(c1a'&8q[m,klZ?(me"jhGI+"YVhB$H%27<$Xg9b=5<fn8Ej:)?G;dTIGE8KuK
d<Ijd6(q'bs,*E_!T.S@"JNdKY')IVQ9"J)A5,qT8A/r]A21mjOj499VKO=S0BS7iVhFpim+'
!?\NRJqe4a0E`DuGC#0/,8Rq=['=(fdN_&[SYU[<(hdstP=gC_p^#u\8mOee$)T;b;GK[!Y-
6JhPJ9LhA`:?e]AQ=>E'uX]AuPPKXNLu]A[`K``0ZDXF%1gphq4ja'DR(5Ro&j@s(%=?3eI+YQC
OL&oesh[q2XR"kc*RH4cOb:nIGTTmL`T"GZ-ukHAjFbk8c7Z4^f&WI>#;d'T0e6h4n(HMTon
^?NfIeeMVf@b6Y%NGZOHsmpk?QE$^9>'33V,Lltud-_qoLqC/nk2'/EV'@c\[MZm;FG[2"#?
Z=@7=$Sj;V:"I2(tk(`KI&dQs,;;UCo0A`iW8<0.NYUM-l>t8g)1uQLh^E2p*7g*gt^.#2M_
h7/Ws7PW(3KR%6-_'Xl"29=)FQP=:%[BiKQ!H"/?3nUJ@.S\iVcBo#'m=:"EQF0d]ABnVE%5e
>H?&6FmEofpnEb?J</T[(+3nZ;a5uFmtalS([#uGZA+C!(u"j4]A*/+62BO#_W^sk%rrA6HR4
eqh&5jN&9bf%E6ljLQDXkYqI+Dp1@3!fTNrhn5MmZsaNB5!6_M/jJi&EC(='YL+A7:Z*X`Y6
*hf7s<?7>HQ'PSok<(isO6(aCDEO514j3i,&d;>Mq:/us3d5faA"su,54;n93\r=Q,RSC<bT
`&<>'8,Q:n/<B2_Ce!tYHPe7g4t=sI6+3Hai?UaQIR:;jZ2e_ha0%9,k[XO+iAjCY.EqQZb6
26p*q,k5ALGFnPfsX(VN)'kaPNFO:#.N6i!"7"oj%%"_)bYh_`/ALO>dt*AQFB'H[PP#A*=_
G8U'pDSOD?Wg#?o';\LC+7Q6$>>`Nr\"ee_<\]AL[=u&]ASM'FB=0k5%2]A"]A?IP<@,[`BFosjF
$'a?lr@hd([djA+HgfW1]Ag(P+6kbgB75gYK*rF*tQQ3N/[rn#-F6S;h.fJ6Uhjf<;t%35C.A
DO'^2^Ui#U\H%)',kEpc9Su/sJ[qsb\0>(e3e+)YaB/D+,!?\:c9;k3hI)9C$NJS\%DU%9RC
n'ijr/9-;i;RlM7<NJnp,LU_AY%Fk3VF,M&;3:\\W]AcWcar4c+tT,ohoO[_fD)hPdRm4h'ot
I+N;?>Y%\:pID@(/C,SZ3`>&u3NmkW_8n#A[B6h`c>a>9$_CZ:+TH!clhG3_k10nZ#L.G$jD
]Ak*hX]AA]Ah]A`c7CKpnFsPCWCo6\-6T6mFk&QVg=>fpq82$=!FDggr8_s-/kW9h;87cN,qQn!-
UJo++J[a(3/Xu=r;&@pok]A_Z?=,,UVLtI>L&^GG-P`ASSdN9<\-DNe""!j&$0NTc'$2S3'$P
n8)T(,gYD+mEkaAb.RA4dp6E<aY\?_Wg\QCc>O6$8)=cShfsD5(%5ntI!L]AUUHQh!)L&W'Y?
>^YZ`_mK@md!%_p.8Rc`KZrua^M8L_%n$gG@74pQH*d=!BY_:aIc@mRG,[6e%/#O'5J_'g8Q
kK!#\p@$*"3f0")&MD#e$t-ZV5<)qPT*(@PR;Ws`3@L5$ZG_2q@m9?@FHH6?R^C&_K3oVFBG
i,&RnXo2:MK"-)BT(BgrletW)=5/DDqC+eKT!bZ^p5R@$A+sJ_TZfd7DVgD*UtVdk0@?4(6(
:0Dn[aq4"oD]Ab.p?t36JapXrmgn$E"2T%p'TIXGJFkEnC<'FV7&gqN#^j?WrM`VX.e:]A.Z;t
8#%:T#!$Q!ghVJ[V[U^/#kkWP7k+Cc5d3I*(=2CW#<bb([QXSX7:\Ol0*HHFu.s<W:3EqCG_
UPW-`.6<]A.K8Y\<<t[RMeW(9YG1^sgtXSedHEe9,,eZJh>>/k9)BI0^P`Wih+G(BSg'onfPT
P.C`ML`r7g9I/K*=_I?"rnQ[?LCkBbsr$2A2fAUI8jl]AI$qehU[PO19RPfsZ_$?Q",2r[K/+
NbZ&3e0/I9aKQ8X,#A.IC!/UEqfoCu+uDaWEtUuMmRt@99fIC&Re?>M@ra;o@ddb3W_/oij@
KUrl1/KXU&Y'F4@SW+N2Oo*cNCrn:e)H+pj)dGk8k8ZEfh54.X9&;Djc[n@=!^-HjI@Zh6'G
92i.(V8JJ<b)t?!5[YWo@Il6?:a[*]AU0JEak*)ih`QdPDX`TOkeG[*A0F45Q9+^kS&iRLh!"
*p>AfjN%J%.eW%H#`OtR7D2(X9tO;Z@P)F8_sU\D/D/+TCq!&0@?LFGZh6KWCSb"#(_F(9Na
=L8N06SnA7fdro<T90W:K4\RTL*jjfq9?RqAD+B_nDC,aN7PHSPad51TY0)F[\Ikh::<cY1q
V`;&d_-s/V$,nV+K]AsMYC<WCDgP1+7Pt!\762htKhA#J)dK<T?d\b("5/^RT@nCk@k<mO6bh
rfJqOJC7gOFt]AC-0Be6iNCMqF2(734ccqAU(GY@+ZJN0?*g4-0/2kJ"L$`_.=@*CmrUrZsrA
lE;fu`Sq)Mt^`Fl]AkNPS&EfJ1B1b8:`:R%o=!rHgQg^U!.2Mb\#GP;peYC%JZ2MY;j$C$PqN
b#\BI%l_;IUC="C#:!/oD]AG.?@7QdSm57k[;Tsb?KpDK;T7F%6KY.$M`rOQGW*4e0DB!eb:7
+=aACo8Sh"\U.p1M4l2X/Lr4U(ADer=ZH2`]ALU%:)_"F=oDFNZr=DFMe1l/:GdC5<b7nCmu?
ZgQ_gq"8mUU"%m$bo3.6_u5JW=sO$+*"hYofoS)$d5t`_rTun^R?4IeQ'2uNOBVmka'Qul>d
8ae`[>VH#I+'7*r.kLWh9;(=VMt1P*nKAf5e.)2oPAG4+t!3\')Oaj-N791k0E9NZ5FOq"a$
(rVB)q:I6)p;r#bL,<-'>Dti?JlfK+$46'd.J5qEMToAqph^8VEMf<K4W3r$99sFK5d8?!UD
f1fu\oellY'.tTBCm+OEA.D8:V0hYrds?WdGekq(d:/+%(4L)4jRBmmsOu@5!>EY:E&qh/%2
SXpCV-M("e@H2p:^%[eV!FeJe2,PLA:?[h)Y5E'!4#Bl;RJWTrpJ8uKK^!+Z6l)t![kjAmqq
X[q5c*p2?#B1^h53:^4U]A(D:%.a$`g4l%%N7\;!;ktP7>7`EtlLhK\iNZZOA%u(FYAJNKEHL
s4TmMlo0$M/'SO\;T+!p2&b><mm*^)t.G%#@4Mp^etSXQS1kmD9>/<[T0Vi#t8pYT*18-1d@
',O@;'<08d;Hm==Z<HcFpR03eqQW1*]A%#f4Gs%L6!>!!1LWmPF5K]A/7p/,Mmn2Vb9Z45c03f
?^/_5CR=AV,p1O6<F-k?FfhQ!AHmhX=Xkm[SXNWN0N`9``.).8ZUM]AI5>\<D\+Qq[6rRk=[o
(KU2H_ZpP=5+\h\6m2:W,:))gClL1Z'AXssMeNaJ/=B$.PS4J@HKI5MZ\\;IE)CIs8:/.LC_
,ght9rM_9uIg_$+B?IB0"%?;6pieAa(j'@bT%LD0Ln[hdhKp(b/A+e'"DFd)$ZN$O6YpPV#_
Dredh#nIRZP]Aoa85)gi7cGKiTU#k%%1SWQn/hs@#/o9@&sQ;:^T;k*IIW05[!LH?<<3p\I$1
\]Aq>hpPrWZ59G";&+*O/X^bl$*O[gDUfEWL*5t5kskn1roa7To@SeuJu#\HDH$[XaRoTu52)
H-FYblY;/6r$j`4oBdbOE:ef%rk,Z@_V(b`:O'D9<q*-5T,78SqJEMT,mg$>&BbW<?:DC]Ab>
o)o;MX0>ISogs#1M[F]AQ*Q89%L>nP<5'nS_7U!bd#K]AH+If7KH(beekRNN^WD1$jPb.6WCH`
O24X$@hm6HKQH^0'5n2$j7SC9H_%N\2S8_]AR8&Ed:R@%PNa0$neRaU`kbI5dI&[+^o:HE-Z:
_<eihW0p:]AKJ,)#[Y:d'kYUDBoXfF3qf"3R[fL^QY=B`kkdnY"fSV\C!Bf73Cf@$`G1RAP.!
goeIdCd;"?.LSBLX0+AWiUZF:*aJH(4LB-7FX)T+,5j]A!597+Mg!>"6102N5\7`uq]A'(@f*e
n5!?irr665_tQ,oELX7H>67nGf>)O3cp?G6*`3n^,9j7etX>c"iXM0"!R`GkcSL-5;Hr#6UK
Q)-KOYrT.#p3?_PL&jGNVt31&U.&tlOq#"3]AUrQ7/GrX'IT`PF"\'&An)5GKT$JDGPuXth00
G3bQ\]A49<1Mb0a0kmp3jMC(##D*<4;'g?F65?8`uJ*Q9*eL7-A?q,SPp']AKB]AOM4/?#L4tnr
?GlPV%qeiu9D1KTjbg"p3Z_f'RV-RB(i(\tk&'C&fklHGek(]A,)T+0GY)NibaT=>AGabF7la
"7+=o=/i;WT&tOh8bZ71Keq<BV9o=l*d>"4iX`&l=e`R8"Kbc1BP$=!3e\mpEfN9hOjZ25>O
#nR6jXY8:P&6q#5I4.%)OjuhpM6b8C[uSN@*-O3os@BK%9^OPaUZ:167VKV+D`"?l]AEVVpjP
b<1;A:UE7&X2PqbAqfa"*sr[,r#Tb\"i,e=6,;;dVSs7K[PjAEYkQtZ)9h4td<?#qfF<H+1p
Clh>a2-Ila^dV1Rq\l%FO;JCY/DsYs\`]AE=CcIhqg[OV+b=p%5Z;/a<oDcA>9A[i'ToU#X11
i3*EuJZNG;s7@2hgafJW?gAn's<:I&lH)ZlHqA7c+NhH6f6\TsiIl4e04@=p+meG#/s&nG0u
%@281)?Is8?mZCV:F<1l,gs)`K6$1mo72n&8m4ODdh'iHjB*5C.]Ak/Inl#WmKZlF_fK/:4bW
.Iac;$]ASda)nt8MO/ZE^EbcU$Dk^@`-JH4lNUcGOc;CRB\ME9G-!PKCW=X2Qd/[V("+V0/Si
W&_ZO,"`MQe_@tO+Mm,O5\1cke'^'C]AZB&CR%hm!#a\F-\_mcU>HZ"8dgh=Jkp->_,XI:Dg2
Ckt$"ndf.qQi1GW^Z:,#/#`'\>:UhD.uAB_^Zag"pY<:"KDWSfc^R0LEi@?T9N"SAnJ6*PX'
E%<)rlqf-'bHa29$WKmF45"RD0"g&\8;":9+b:q`NUn,#UM1>TP]As[SR<C]AgGZF-&BsTIl/i
b)3f%DR]ApcWnH=:M;JcTrgJ,GsNY-X+rTCB'c4rWMnR3Yt`+DH-r9*IO3F(Z3<7^]AZ+gc';n
EE?t>%>!&FP=0G@Ld,F-K1o!ko5&P`Qf-jhRQg!8]AE%@j2E5J=Y?J87uZ-nk:kMU<9=4-Bg_
Xgi?^V$jTqTKSsPRK#=YJ1M*jHL8=_76$Q(oi#>?iM85o9A+n1"ndp-58o-^<^.eEm"nQlt*
#)NF53JU(mA;nNpVG5#eN<ddsc(!cWr[$&GMi44<J="`WTj/A&HtLFo_:kgDQ;5KgqYrV%$%
eT17FUdW,^)/J>\ib'^Vpmk-n6O"2G&MiRf`55KYK<0/I1]A2c_(Gp'cKkg4Kjbkhl@hi/]A\;
RQ!4ZT6e>_`UY2jh@u6jj%ZVc<kZW*li4bWAcU@rk0d:j)<B^!M:bg.DSJOVd,4*L48t]A4Yq
OS&^<cs@Jg:<0KCtcuepL7-M/lRai.JL$:MJf53*/#tCj2,W)#/&EV\d5/DiYM<^q36<J7!_
<'K9g;s2Cn[-7R'5;bH8Gd-H@hgo?(unE@(kl@AKT."p?/Q;?]Aah&Jg+*]AlZ%2iej*kr%e8M
KKe2r7ol>46$FA!@EGjD._.@"BrpJL!4uT'&hfXo^VDj8A2d/Qh`2=N=i':d$P#7BKR/aC/&
<BbT)-AZ/UM-eS]A2oRF?CFMTIi,bW(&s?BDSFaW8Up]A$#"okQFp1,o*b9]A5nlAg]A6"]A0K!^8
m?^B/\^KDLkpjBof-$]Ac<:siYn[bLb1(nPiN6\e=#k4kZcmr?.,&01u-Hs&)alPmZ4,I+ZXd
g*@<M:%_PC/gP4bBMMPIS*eFD_SJPP,';3HE[^`FBZQ4l$F#$Iqab4N<MnBdpUPbo/lEIjA&
bP\0q@30Q&RC]A#YG74a/sOf1GZ7*o'>T"6%-gl>bM'@mbU?(oD%!h?HT8OV498.t_;(EdZhG
atU<N.J2%U)n/_I`Q,%%b4k'R5R0GF0I=aEs%01/&:nD)U^bNHXOR$m5&i+%Cn)S#c(cthi-
?Ag-:4]AqUhDU[>q/JLlm11$8fH$NkV'qh%3<D%C;TpKdh>>Z">:OkCB"3:XD4eBHNE\BlSm)
0R%sKZ0A?cj^]AdQJJ]AGUB%.lX>61=:#m<'#Tai8a<$;.(Ll^<QNSI0E&QuXu<;ou]AN2!ETs9
BEM2Pl!XL.gqYF4#cf$SS`k>d@`5'++Xr+M_na=r`9=P>tO*!b..PFc^a'Wl&'^=16.]AqB9n
%Acq--Vj,U*/on#qn#oc7AH\%2W=mHGQ/pe=pTPi5:0"N7V]A3LXHM!LZpHrP<N:(I/Q3!Z$r
lHJ\qcJ%'\dQoIB>I[HKV/^rb7&[Q7gqFSiXlr]AIdJTZ>N:Zj@27S3+crTX%RlRQs;1E:BdW
N3K!a)omVi>bbG[fA]A$A^C8e$fB8LmEF!>RXMMd)"i9f@#,)Cudq`JZ[G.DP5^k;T7-&BC$:
e+S9b3CXqD]A!-*<tNnpcg,iKKnC%XXfcO%B-9"DL9%S'A8G.M',oC&e18:=4b.(*eTF@+@.1
DSRi";<9sC;"?g]AFi!N<RWU%(WH;&Td1D7.6a[PqSVJ23QR?o_3);1?/_\0E6k_gLnIruJM@
1/Q>*1n1^RYq[cj2E!?]Aoe-C=0;HS*]AFaY_*1Vq=<`^SaOQd@V"HcI7`/i4op:V.-V,_+X(t
H!%b<I".?SeatW6ZSuJi#GoorP3]A+h]AQAc#U/Lq3:6nBcf5k;t?T,%6>ET)MB)@<PUsV$naU
LiA81HOI<o7@c9-#8[aOQl;12M%HSDF7Y;PRQN\IAc+Q\%/Zdm't.bdmQT.NV0?d\sd0q-AF
*5HN5Hru_hCk&13)P<%IPdBj7tZZd<N7RtQqk?'bP#C99?D$g2gWq=j:S3P`20NBC]AQ&P=Vn
L?m5#.dp5mKsX5#:)VtoM(!hLc(cF+%Yr,o[R(i/3/b=+'CF]AK[AVfpHnYqR;Z3l++U^ent\
%k&VI*19MH<p4aEBG@E?E+)pjH"N_nL._)0gV/ulOs_#Rd!Pm9Ar&WQ)$AA"@Q'qEO^'$dKd
G3[nMFn^OQ^sT<gY#.%:l1V"o8jJ[d:I\''I1McgksSH6mXTD!4c$-5(PTO%%`S>OTU6(!r<
"?b.2q52QI3A['^;6D:J^/F]AdH]A<5)@V[X2koQ7T7_!c+(L(?P9,XiNK1R#7Oqqak^t+n(0q
)'i7^t%:;!F6ip5`F]A(5:V19h]A(t@23n'?6@0Ha0B#iHf"e:me<L;^<.T+:s3B<Ubl;i)NSH
j$g2#TiRq622/=Uu=HdV"%GuU=@QDa5f@GGgd6Ip!ijMJ:&:p4bWi`%I;>UcK+R#KF1n8ktB
W#?:iu2L#'==*FegYJuZVJo`*c30cq'%<,&X/<_EneTgfVMp.\IM?A-44gbH45!F3k_Tp@^>
]AAXj4c)1/=^6Aa+!0`=M("sA'!E>u[&i&Lg8Ki6#g[]A@_qs`sF)Dce?J\U'1r_UiZ-P'!959
9^6l?4hqpXHE(;MVURe"/qji_U&DJi$Es!Wtan!'RUUH&_$:h]A`/7RL4ZqX1>$Gl2poMlgKc
T9#V"+_EEeoJ..OJ9iE3XHY9J<;Spt9f(1:/b=NY$/+qhOnBXPTrs>7"UatY33KK)_MOT]A^4
h%/^ULFZ^-(4Rg@F)Qaf\Yo&[UE0R"pD?MeoPUa)n5&rd8V1.VSuVfom7T&^;$mP>aGG*V&O
kGN4*_iTU4N9;tg.T)`MmRDZ<2aHU3D^l5FmU3nGhNV/&c6lD_,?6C7W@K#C5*[P9":;YA&U
)W(B`F8aiN2+eh)9KmS[?-lHMeN["5i@Y5RM]AMJ-Fd?H8Q-=hD*`a#VYP(X^1dK1Z_o2fKa-
$j%$`A3*4aWOi^'p/2I%5H-/+1_P_^d7kr(cYW"gNrsk,q$g?tuX@IL_D"=KG,dF+8N%MJf-
HBo+!@S*a`#e-q;aK"0oI)sCJ$3`4cqj"X(I@8R0$8n,l:KKPFMJS4>K(olU6nq_upIeb>ml
At-[ce`/,3hJoEKl5;M<U=Z'@%C_P3=LdCcg5GtB^eClH?$?@,tU=@fk^bX-/caN;pX82?:!
c1<"%eh+>&g2$:6.?F\b1a8-PHZkt\[3]AP\kTo[$YV?=_9W/DtRtPD6:B(c3'4U>YDMIrU5s
kgQ`RHWBo*L$*k8o`*7X?\qn8+FI`)klV"jauTgCOK"+=c+Y8.;h?j2]A^V%Je=+pTg[am$S1
8<b/e`86T6NW9G4;D0m[Unr8Tul)kCmZT#WHKi`h_qbE4!F@/bN'_^M'M5KBIUq[akC#8b4K
!%?lllTsMHSs(DW+he/Qt=Io=Bm/I"i~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="4" vertical="4" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="84"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report2"/>
<WidgetID widgetID="25cfa4d7-b174-4094-b52a-6856f8369f61"/>
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
<![CDATA[288000,720000,720000,720000,720000,720000,720000,432000,720000,720000,720000,720000,720000,720000,288000,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[432000,1152000,2743200,864000,2304000,2304000,864000,2160000,2160000,1152000,432000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" s="0">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="1" rs="2" s="1">
<O>
<![CDATA[环比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="1" rs="2" s="2">
<O>
<![CDATA[-]]></O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="1" s="0">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="10" r="1" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="2" rs="4" s="4">
<O t="XMLable" class="com.fr.general.ImageWithSuffix">
<FineImage fm="png">
<IM>
<![CDATA[e[pSuS*_:U*po_[[b;(GQ4A7BN>aZH6g[SeX/37$]A1$D@WhQMS/TtUQMOH8pX]A\'Y'rr`;,'
HS;p\&ua^]A38@Eu]A3?Eo4F1qtc9CF.V"V8X,?gejUo<-4gH);>]Al.'+ft;&GW:cIh)7Lfg5c
8i;R$L7h<jNV3@f$"51n4HepP+)[0%6Z;C6**uQRmN\YYrLou&FfuVDa-h.$KFiGb6(V3g<f
A'\0=0#[u$F6VR.o]AEu;LNOfeX50U5No_q^$0ZmT!^U/[hn9.iRaFK8nU^Ja.n89Vlk]A/I(O
"X1Ao0CGtuD89U5VFebCQD0VfG,*SKU@#Pqb3Cq5F!&eB^WoiaEtlt*\#e;t]A3Qbm]Am8VX6(
SfR0n5-+<[(,3-)bW*KKlGTLSVd+:Zq&gmK0rDFnQtDQ-hJ599YAYlW2KZX\IIprOIXV=M&u
6:NUdk[TCmj`Gm&>OF47/-raPtdG=RZ'5LQ3@Poh"aDJuYWG)'*BNB.:"Z"P:8q=r'[_R8UN
`N[6*uZ!37`IQ@o0k4\bXA$54l#3Bfa%XDLA<;Y"n'f:m66%!#+TCRFbkB&'sR\rQZn;b8U`
WC?KPbJE=1j!F"Ok(]A#/_uh03:Wqh-<ssl!I^"t+>SC"gR:8'p.V!J%5_kZ0Rn8McrA;)[D(
t]Ao?*Xmd8?8l,n-S=pS>q8^+mZWgFbmo:K*le4mX0PbpRUj$*YO$s7HU-?9MrHGeIs&C.&<\
YC!Y`76uf>`([_@L0,ndi6S\H9!NU-65;QQD&R@(\KMc6*_]A]Aq^)@d>=ZQZM]AI[8\2,<\B<d
Oc:9\S&5hJ!0Q^KB(R\S.;P`PmO<T9>IT5-0k7s(+kN-BEGri*sTl5b7\0hg)nk!gF%pI_ri
K_sLU5cQ>/bfkNn(\),WWE8[$`ap?ra0^/(8?]AMKVRupu\,sTsr7U"MK68pj8kUDN`6+;CTA
F"R:GJ>,KmmfIS@nV6j@#-p/&fgp%p6@bF><1R8RKYChL6m,;7d-PTRg>57li!VLlsca19Ze
+n[4[U^D":8rX/R:TbTQM.(D%Lk:"al(V>bQ?h]ADn]A.<H\@26"6Q1EcSk@-juqn,8O2>DrID
%_8)>[&e.r^6SYEAbIk?A?UCYg[i2iWO!_2B+n9^jjDn>qeX&B"6j&;?YB+Q-H!m?>IhW5%L
aJo[Ea8uH^Sta0Uj6h_R")tFXaPlCnQ>/mlT.t3j$`e*9a#A5i`5<*.\AO[F@PfOZb!ds2_/
n]A+"qX_BWn)M%$%9rtsu,kC_WepaK5-Vd\Z!UUtcgXrG0PN9BG:T5DB#JQiKoKdgBm6''&5l
\[o4`I@?P*;^L?ItXCFda+eD(HF)Xh%G!q/-JlJ\N]A8((D3d[eXc''&#V4t'AVaJ&5FIRb8"
6s%$-E7+SdK_)ooA@-qfbh<A3?Y*l=o^d/p1cjS+BYC0jLB3]AV'qU9K1)S->B+KL+M[AA?)e
4ifRdH,1CE<`f/RVtU7Z$pOG0H,)/.YY`/u25g`_,#gFs(8$H,A!G">4KhMi5I4s_:@qMHjT
*Pc-O;M@J7IX!r58e0\<I&?m[hEM/TE(*C0OJ$_dRPG"a!\dhg\V?+TN"A@uo#5479KT;<t]A
MjAbdK5Rfq#@pAHC7ia;V=AI60[C-3b-IBqKb6.U0;-%lUrN;uXVj9$CQUi8JW$8LE'iOS/o
:RaLrO8Q'KGO)Y)9_=,_1==2`j6--7>;O%W>Ch:6#Ra)?fk3Tl)J0/!^!Tor-)3p8r(&/"Qn
DYe^4'J2?(pCndG/OS4B)1V"3)B)J/S?>\iRt"S8R%BG_cR=;A(\Fp]ACr(#T>UY?+Bsl;e4\
RkNOWQce`u/),FL3fs-j&kTTgopcZp#X8QG&Bk6_4f8LQoW6iMRmXf'U"2q`I\aTH(q-fj?$
eVoJr<.?1W=n1p8hAA0g",;jII<)o]A_V;gS<[Mgt=WbaoGP8nJqFQ()7J+c^Z6D!JX8Vm.";
00H'fX`k<01lFcR*'lSXg[c-onpAih$FEW#NMnSr'0rei]Arq/1(;q_N[/90HJ("q-Vp"pAuI
XcjjC;BK5G=qsEhMt,Lj#&c4bh2P@0`u#cj09@=ZnT#q)!OW5JGnh.R-FZ*Q2CiA06mU@5+N
*;H?jnBRNHJ9Qk7/@M65-GT<&uZefL;LC!$qAdLJY5`TiP84Ru@5_VY@AImZ^Mai+s<kjrAX
7\S5aJLjF5g_,.Eoo"#-cHGNc%LkLpp4G2MjG[tVhWGa:6NSU!+*T?d4ZSO`@1QfJ*pUB7g0
"00OG(I?;Ql&cOu5q."YT1'i&/cl'$5LuX9M^1_l2o)h"KtnB<tY'nYa+sa&#<r!P3:*+HR5
p&)]A2G)b,&#<%*5\#69D#6#e;CG85DW`dp#2J[SIl>5Ig"D[BgM()GJm4P`kfkK+T!Vo+/;X
t`52KT5-hHQM#7</PE*N#g1u7%L#2b'?]ACS>O+ANX%j3A&#1`\ge]AKUA#]AdHeRNuS*blJN2V
s?]A`:[L^HF[!=-i'+Z#)6;&j.j"E7<-2R;_(=S$L"tQAVi\07jP]AV>MQh!/H@2^8(7a3?@1&
>X`sN(hV`]AJfbJLb['9^ni0?sN=Uo%&$2H!2Jq2Xb^1BuY-29q>JDEAN>s1Xikq:mcDj2'19
ZJ0f$Kt!$3gPsd<?214;/K#%A,$p&l+?h-&(c!'bO)1NE&8$='WQ3SlhBjRS(1re5=,AW#sB
cD)iUQ5`f[V'aDHrLn6STDMP<ek.gWCpo0!%?P>)jm\D2SrP.rte'+l]A)4AODTZ_>oJ(bL;W
APpk@E/YH*3K9]AE,tU'pL&b_jm3YV/*<o'+!?j='@dP-JS(Fp#F;a"7.q5pp!k0ObGO6>%B"
eR9rbRA7$Fe"`iM)-\E)P<A^et/@$]AUTIt)T@h[f8S`BC3%bo%!(;98,q*m);(+L2AJ9"^jF
2G;d-#%Zq[^j*tbo#0cY+V3e%G'qoTb'd7>1L^eudrd#0%5iTNXPD3l'7<s<,)96(p#NrfAu
p\I7p!c>h=el8<KQ*WM(#?a`pkh>*dIc0]AEOFl^Scgo4iOe/[-.kS,s'hh1@O*bc)"cape_/
e]Al<k`dcECkZa;p;aN,K*<ZL['8q,bL9DHXc4Zc4m<Jj3_b/+#X43jMMI-lErS$,+TjBqEYB
moU,^p@5NqG]A`GI+%XYRrcilUGM#[3'mLqWT+FtFcI@X5*;!J<Sj3:AN3)a*cW;U%IcMFEr]A
@j,s`/fD;g:(O&70g=7s$U@s7YpDLXjY`T^cc5Mrgjb<qhqZmrB6qur8LDX5\MQVt^c?&>U*
N';^f>BWc;^=6ja,O"&,WP:2V,'.uW]Ao)=*mRh6a-ip"Qc/H'l!i[p&CWT=[B0WNQY?KY__@
XfM806TL_`d"t,6J%@]ATb3%:TJ,0_`/p>2aVs3Oa`aJjco?JkRalkdi,XMMZY+5G_-u!2)Y-
s'U$PECR,7K=T7hc.n!=0*iL8/d-@S<2\]AKeqj]A&)`SCg'aj;A_Ooo!&'Lp#1CbXaa-)W!5>
k.WfCJmP=UCK`:/V_n:YFi6alBM^@Lq<YDWcfDJ3<"36eRiIo]Ao(sAd/f[`,3WUM123+CB'3
0Ja7#Y4;<d=F)fMna2;Xd<TOK_$90%(*P3iabD"Qm5g\93CmsfO?ef0!L^V\_P':b8,gU+"#
gT!U2k;HWu&BX0m2\2eVaQaHVZnuCVL*!iO\U&oGIEP7D6BIc[YDmbDL8H9pT&8=ad/Mggi&
NZ-800>q"q&A.N(hg>rGYBA)/YF!5e+1>hZ*=P\aL_bAouhI4L'tHVOnr2S+aKBjY_Uhl[I0
0jgMNh?WC4lq[6M-@Z=sVVMd"2YN+?'GW>)sK$oB^jo`J)ar<c4IW*_d\.enf/)T0ZXCV7[+
"LIK'.l53X/ure^(*n:6&u5E[-k!]A20d+WF,$(n5Nf1%)a`q,:J&c<.CCn8j`C^MCePfW7f[
,4^@@V%OVcUVlaiqOF=lOU7Vl?N5e"ko6\s(-eEKuY`YAEj)HcJslB^1Y*4Z>Cd*[VY4^6/d
<ak`b[@I:j8;%_QZGgXf;#[a)^oU30(=RQ2C&@@TQ&Wg(cej%(39WZH_FSCY?;`,(oi4Apd3
m9=aD5I?1<AaAceOg]AG1/!#I;q<C(c9oIVeJ5+F3Zo8En4GlXj?7n;kLjk[)]A0Z$-gN`WQXd
T[rZ*5'5JJGWACe4*^4(rfnR'Ke3?O-aV0$lD5;SZSjt*Fj0\GrG=tEk7p^N9N^ID*$LtQ2`
)Rhm3PVA&C)S0mG*IH9=C[pl_>+9rk;A"h5,:`$YAjj)hn=52q6RZ#WGe+7e8cgrY4%PT8"!
6u/T,@39_:`Hr::*HYrJ<:d.eXrKR7Rp-:\j,@]AJ"KGflV-WK=%:HH$ZT(S=%eJ`r<B^g6Y]A
RQ!@ZE,gppNY7pHNXjpXrbGm;!C.BYAMe-2ZSm:e6VWmD*Bq;ZKtN9mW`65['mQGBh"p;=#(
sf25l(2R9BiK$>jKq:huImh%(r9lGMq:c'g-X@BNTp/Ki[S%Li7Ji(D=--%3AD2LPh?\.E>f
*r`=:g4NS"U'_#0=niSD^H18q\7[d1T)#Gq>QSM_&1%']A+Y0`8PBi*SDZ]A%Sk"Vm4-2X0,]AR
u)Bc>#@/M:Vt1g6V?hC1T1Jgb7m;]AO'XnDICRqf!#KV<kXDE)[ZVLJBOfP(Pu<[f]A68EeKhK
2;UASCWZ9VVg*9:X/TrT[\iqm4Kk'o)n]A6F$_#g3Yk9d@?$`IjU%K%DtM]A?SRN(0VA(2a',$
<"jd[?`OsafS4CH_4W7*A6lZLN[iWZT$Ka7HkpW>G[+M]A0*!,V$s=uc8?pg1E`Zm/IWR%),\
818-/u0n?%Qol42%GtCF>%?hVI=hRLtkl:B$e1dl!Q\<-n`t2p'b-cm:@6:O;?W^"FJGo./j
P(+9FZeJ-9*Qti-AM*Q7dgKmh`Rt;#)+q9bNqB;/N3?=t<151X:c6L&i#`olST/RsSel6Hsa
-?+<c6bib:%XCFX@piW%N8AoS=6.U1]Aq<SR1oNmAUe?SY3,IM^4*:VeX--r,F#9$iZdt%Xco
?bXOo4*GAY-\ltnLGTmTE`.=IdG0SI)p=6d1))m?G7ZC9Z=js`B**nGS9C`h,peuma#s!,ht
'<Y)+%NVUQ\e1_AV,6H<)ks6><=SLs:pnK4%FO]Ak8Zm[R.=Lg):/KKWiF5/m'X,\P8_&`+Rb
YN%]A?1.j""-Sp.LNDJA@kKU,/`Ms.a*QEoMpt#U)bW*;D_kS`_Pi`O>ebp7NfcAE+QL<Dd<7
)Q0KR#'(<<oUNMe_IpEd#@).G>bq)>enZQ`s2Go*)-70E99S>?TqL$F'[XX=hD4d/<BYVSnW
j4eb".c!:71P4CJ)Xg\HejHX=b8`<0ik!MFZen*b11Afehb#ePTLKOY9UFoA'`XA*pnaeGU)
160Vl]AugjS@:BU1G2W90On!u:ko?eSi8&A/3DMpaYr%Zq7qiuJAP)b\Ef/_3nIpkaZHmE39Q
7.R0f:<,G/2tsUnNkO\62/9WYC%kIu)5jRjBDfS`"+IcTrk6ST>sJu/m9_M3I`m/cUVZBPn&
M]AO<%8-KeJf!KK0"ZKgmLW=%2+"f8(r#VfNp%SYuceOFl\FaC+AnQ9[Dc]AFPJW:/6BAOO&Lb
6GsbMdU?B[nSb=:QQk'FddK#\hAbOX=0C`j.MJJb3F/%rqc^UK@Y7dNqk:Rqp(CmddNr"hq6
.8)"La$(_!>;Cdna/=p?;_"V(;8)G>OWYg_E:O^A+/6bMoKJgjZ<f*lOG8re`Veo/S*#CG@#
hK5s*[<&o-gDPR1%+m'V,J-]Af=[nLhQaU;XjE@I5eDdYMT0U0jM6OsbcFZ[NS?5N!l>H_;+C
q+''/VT_uT/;N]AD;R<7236GiAjpr3.Gk]ASPSM[NH+!7)8V]A`6g*tdg!fQOWEJb._[8]A/$.=I
8-"DhR,dOQ]A/56n'*fR:L2a6OlT@o7K6(m;N\WRbjtWPQJ(\m$';mA7]A9cpTHp=/O&[.bjE`
jRsrV/er@-!98!os+$(7Z+^_.R!Am.Jd=%K7_F[)8/ZAUT<HkBZqdirX4$uR(4gA=mf`qI-V
qmg>Z,&9^%%og$nihr8Ypg]AU=6o1_pI6NZ7]AaI]A]A%m='R%V^9msBGa:jBC1S$AGUs/$*GIY5
fr9Y'=&LYIl/g$9ZKlq<Uu./tjB^$=oa]A"/WZMe/.4Kp$n-%]ABk'lUo0FYNhLtR&48k(RdrZ
a-,\t]Aj,Ll>5cgmXE5B6'u=/'oC`?5.X:.na6HW3n@-$D([C$SI(c"3Y<qkaj6Fn0-i>jgoQ
G%VXqHY_F6^;*aEI>5o2dCH]A[/,f+T,Xk2DIKnmjHd5`6]At/BA6qu_1P=>74H^YrhDetAU0k
k0le50f_UH]AgQ=&$c+Lfc$m'c9c:BrHH;E+F1HCoG>>:>rK+YNfJ'bf2E%aL]AnjmKa*_Obne
ac>Veq1?p+[JsN>9]ANcI5PNC2neW@*E-++=Rt6PD/#,AlR)1=PJKLjpXaMeHPHTZ7ZJ\D9<R
?X]A$iRm!/l:EaD'm6rp?0uC5M178I'!KHtU&26&FTF5FT9-l"5T%LSV'ElA57hW6V#P_RA&1
HX<Aso_iY5c8&YDMl'XCYY]A%4+1,_??Epu:&4]A0TQ/^9*!m:BTmd,@X'["CirV9Qub<MVkoi
:mu5</+>$_Q*/RI<ftTDiY5HL45MQ*U>IJIlQF@FStnA-aKh^HQ>=[^-g]A\0M3TeJu/JG?"4
tEoKq*[@_qg'5[MsZV<nl.)/\r0tIqT6;g%Pf?ruGZ%)uFE9;[+'[>Ht,\PoZc4nLD4Zn5_N
2l)IjB#CFP62DqnO!h-WNF/$Xjr9nTZWV9'`i:BCN[\lja:ZQreaQ]ADg[BTR0f_/O5o02$rY
Q&'.?:mYeQp;(@"PJe(%G;VpnE1p@2ab1VUkc[\Iok13_R);%T=H8sAK5GmLC75Gse]ArCEPm
+l!"p0]A#$"Ca3:TcQV=88U\J2GVS'ecZD&b2VJZ@cC:['d6pUiA@uAkgY*_?Wu.Vs)dj>\La
\2@COP`@OMAP5#[[F$gh+V_*BSGtk`(E\=!"s>=`6ODQGT#lhKHlsMrU:h[tH$g*ZN')>seP
6m<fPXs!PF$%jn&e8MK[q)a/29\_a32)#5OX[J?^Bjg\4'P=#7nV,AC)Atrsp[Xh`7V#7"T-
PXCobm79@;7.]A!hF+34.ioR[P+N?Cd#n#q,Lg'_qU9RocnH-VfVE8KMos=P'8JFbTC>S![D?
I@Jn_QZ:+[6I]AX#s\@[6hKBj'D'QG^BO:Fi!!RiOn)d]A]Ab3j^@cAUf8b806+1Kg%"aQAYHCT
,B[<mmsDl./_\F8WWUP3;RBH:M,\E6PgI3gR0QmH^,!FJK't^9:n5!*&%AZhQNq'3bEPh(=:
\WE`bYRaj4N#"j+3[js'j9H)i>GH(uZXGT=EZ$V`Q.9[a\AWCs14qE)G:p5!JoQ>BR0q=PN#
Y4-)8(HLkURldF-(chVb732I-@`PODc_[#&08KK%ba/'uX)[aF*Op?92,s1MempE='U#Pu-X
O0gS<\4@j:,e\G%s/WU\/f4cNKpOkG*qaj87n.UHi@4\%oje82-e&L0\3qoR*@?,9$[[:T\M
6]AO\LXkJDp%Ji^EHdMOTab'o"W7)aa?>Ds\p>]AFfjc_,E<QV4,$DCITe@>OL+&U(JV#XMqWC
T,?!\a_g6fg;pWiO#kFoStFo)4NED>\e`fNClnYZ&*d\9[-!G"_X?*V;7YT%<<a^6&ZeQ@p1
qKQl=#:Y;:>r?'Q;*>;?fT/X"^XF./Kb7M')Eb$l4<hdNP,-h:f,<AF+B69Db?O1(;TG>1Y,
!q]A;m=r@iXtRU[s3LFN&d91.g!ep0$/<q=M=$jSYS#oXfCCGqUX]A-Ihrl5hGYXBGRoGO.o#.
qcr2C=9qO/Yu'\S8JU&OZ*?_#NMU)`@T`VeX^/C@n<H1[e>:3V)foo"6@4@SC<4N"&j^O48+
,ll4&T`5IZs&a51?2k<fpu/0P2PeP4q64d$o_3RR:,h)EduJrVUNPq<jB:[cD=kSa[DVRoMN
"kMFUPr->ibdMt359)d,mo:C`^%G0.,Cs+c]Ae/'dGADr/i;%JBAZ>H^X#\WWbnS>;#3`QDnd
UES<Ieh[Fm@`o1!rQW8f0mS:2h&bHS;0(hQll=r0ufT4J;/mq.3^S28_Z'I;$s$hk?m-[[/A
+h\Ke<_YtX7^G+)G%G4m;356]A!Gs<on.#b@EkLfI6<<ZWrMgP/MMqaZq8,e_>r69l=U$>Y+X
PF&lI\kJcA+]A/9&mX:R-7]A]AVJeX!.-;1!p6J.(-mb4JS$_/r]A)O=2=ggMsS6H.D72.i<OdZK
OH'n=+%YrU^<_n]A9ET8pD/A<sK[$o[8Ins^jf6(Zb&k9[(P0#h$pb,f3n2XJXKqk<HH4"I#1
Y;Tp)X&dsIeTUB+I4K3Q<&V5XL'QX&O':G;bebRCSIk[23AT('1=;e2A$5u$F@bmM2i0;B6l
9pe/o9]ApMq25*a0!=f?gs,/"d6V9`-T028hW=e&e[d?bE\%+XR#'s'1k(7m5NghQ\'@8WFlF
K"`Ejs05s7EQ3RfkfQ&1'7u8L3']A7,ia1$\/-H6M7=b1QodC*^VF9\3/<PlVamq6oBHg4F<&
TL?S_O8qkU_Lq[Z`YkLQfEk_Ni/-NfnM1)C"nFp,4P9:$`VMBm<->&^>0`Gm]A.DW!>(VH&M(
tJCpS1oQd1E[YU._Z@p2J4OJM]Ahi5*BB_ql&Xs&_4n>.e!)X^nA2e;0f*3NUl]A.h)1/^kB2Z
dK25F8pFG[1;2Dr+V?>@;Ror(Eee+AS9>DeXgCa)9+t1oDI9)[5i%QHK\W0[r1+N]A["9CUW:
XAij-I@ieR36H6u0ge%q#:khuo-Ij\#KoCJ%N;DZC-.D=*JP<%K"'F/SN/=t.'J8Ec_+A:Im
t5F/W4"E!=An0e87n^YAr1KR#<k*fk>6_cHNPKBQ4J)SoL@D2eY_k$u!Ut0"O2M3c?e#f'fQ
M0>`_))-kc^dTH+DeH[1Ul%]AOb5nN:LAT,g8$t"dHJ2a-&VHZ$G3hXH2WJjG]A+fll=b#]Al="
cXNs%+$.!;Zp^#PC"9QSTtc<2b8?<;u5lS4Id_]A>5*<-pD>?@_uk\><"h+c"q!ZSR]AEr`11u
1-E9oUGH=h>/X,PM)h"&EMl(d8b$1!;"FgUcO*!W5ft';lnM6R1X.:qq>51^YI@\h<gZN>@W
pK1Wk@o:1gARiQuq5Dfls7^IjU$9"?s%aY:I_-%)NJ`cO@kE`bM.ZPN'S5aHF[s_ed=[R+U.
D#!83lC&>V?5u$.)#>-7UXt3P_-dgq00W'p7I3]A!j(WmPTZp-N(dUQm&95l;45b\$V':UG'i
CX26@aTsk,8t_\6D2\:013MjI_6d""3Vc$o(P/JdSnusg_E)Ur]ANe2^PoIKMo,bV1GUnh141
:s)`g+=o@SDcH>-HuHb+3a^*1uV_<'Rtid+gE;L$:GED,?epQe<X_o#Y4F"?]A;Rr6!e<+Xt`
1b/)f0GY9Q2oZpYB>+&,ODIo7:t.YB:c=Fb:Qnu0"rPs.Drkq)9hLG#o7V:OpW+9Uh]A3^oW^
4K2M,kKC@M'\G07tV6Q-f[3FRai)o.:#`mB#<$H,Y&W%*g)2ic]AaEl-lO?^.SYKh^$Hd=EF8
E:/'bZNB$:jIiAAolng+e8u\<9%pmCmN`8<f,1',0qoL@:=V%(#)Q82k8qtKs2XiZpK2740B
8KX3Z/I))C([0>(-VQq7%YuO?J=>_R4QO5raA<@XEL7&#`R;hl2`9>"AD0P7]AAQKrF@=h)*Q
iJU\ZTJ?&G8RX_LocIp<XX2+<"pV^HY9k[LG7_sOFJWj8/bI#r0TV)iOUCKKFfbhYm(8aIlr
:R5"cM,G6.KS`am2VC(PQimrhlcMrk`cTTV<2O0e*O[3gj56!E"I7df"'T*m9pZGfbR)9il/
hnK_5>N;A!KrEb6Md:MTAu.F/KM[?$)]AD#A5i(0(7EP3eJO[a.sLss/Oo*^pJ-;DN?e4rT&c
)^fWmpIHEE]Al4K&E#9#IX1P)_C7r_$AV*b/g;<#rRa/h^0Ss`XjFD('P]Ad\"oO6GoXAbD["A
!nLh*a(Cf6&@A<YH;Vp]A_+5(RV6'&'NGKC4@k]AQ!pR_mPrha@@=0ZfM$+VM1Y*#%]AsAp;qs3
X7dL1-a+_<hB47q_d-gr?!9hM6Q]AYKZ-o45Q%]AP3%$&3b;fVYD.+c;eQlo<34NkhHKEFqliO
0,bu^*AB?ijui;66WJ(Lh:[2Fj?Y,a[Ai@rfJ+2Ok@jkZ1"aEEK^5Y#h@V6V7*ehS`kogAFs
^Sr^,*[kp3QLnRr5[7IU=&6]A2Y5kFFAYn4Qaa%,dH:^]AJ*c'JjkE=7^h#]AG#A!_`(j!^3oQ2
=EeG%ioui-,,j>^`e_n.>[4/u?"'SKj4IiNWrD!%>jdoH6LFh'1L9&rXoYlL%iH"N*K]A#844
c!uq9VWH-@D=[pJ(9lFq]AT\!*JZ.a8rl(uhZ&fHGK[4G\BAG4"fBSgFO/&8O,-.T)3Uo,I:P
(?-rc>ZA*k_iTTc/8PE>@S0bpd!q>2O4VUD?rY)*<_KdsIemB/5K^Jn3J)#"8.]A1@c5qqIi\
%e$[O,*TX]ABOZ*c35,2mIK&IhGc_gTGBDdumIQ=YM->1&k`NVidA=I\eOHI4qP_!Dl"\RL-i
ndC3m8LAJeJ#';K`9C+,(o-(g2lk&i\ipIZTT2cbZoRceHZuBEfe+Yq+%f/_:ie.5daaFeg-
'?rMaE&)VDN)tW#mkZYsKk-\TWq<_DZoF:f#[_^?[<E4hO\So1E]A6[5A)E)2o$-kb]A;p'kX`
f(mMp4p_c15,@7:WT0q3ljm,)6A/kDCTG50h'--63]Agag1(Hs'/6e9!>H&kA*s7C`>7F*]AjJ
TYOIe[$1!ge)gCMTXS-$gf@[Mo5*-b:N-/,ZiPFVipXM<3#NYm4pqXba>N0d.6$;;^(go(I4
!&FH0hs8EA4W;KO^=HSPAUm7Ihl&]AZ>OiqT";u9Vb%Fj_bm62eZSULleM5jq'i;t<RQri+H3
f]A5<'1I.)6DRVJ%Dh@s*TIm:B/2+F0uYVokhHl2Qas1<deY0("QrO:n>+0>HNfb;(m&^`LFF
XT=9&;HVT;(k-R6DlYFC"T:R`L(cM]Ae?=Lm#YT.Z>]AH`[0o%>(h.$P6#?0LpI@OiIeh#\>\>
PXqJBQ"X-XS=HTYt:[ReZ7@@G=V89L&N"qjd^ItBkckeoc[0)htt''B)-aK?,.Eg9bqYS!Mh
e((=q'ljuT7`V;H[SGO^4rq.R#.j@,NK-ScWk!OROJIBOR82R.'(%T1<$&]AH#0+B@?Rs8VhV
(LXZZRdhJSNhrH&Zfp%oF-<+EgM>r.c<,:t<DAM==g5PERgc<9?D<jkKJE.OEc@*>O&_4+.+
+4GjHBq.XLgp_f!&`(;0o'f)Wo!7l)K#<[G3#3EZ&]AIGbIj/iH2X1bVl8=`US"^^qFq#L_7l
1+i[TiM:JI"*iSj!&m7O$lSVVO3i5JW#[H3Wh3_DGEa)Rp:"XM;dn7cK`W]A(S7bN^$F=aV;b
Im&OJ:#*,X8;5:ps4_maZ$)_UG1S:>_W*IDr1Qai`&&`&2t@8pI28I5;(#G\CsXP2h7+Sk&g
4@D/+FQT7/X>X*TX"O/$g<mVAHF.@*k(K703m[m$/)rc%qip0%I,1:=5je-?PhgC)`:*UFNM
$LL:;3q@"r[NNu$"fm\jBi9rq0SE>$92(e'g@;XOq9AeegTtPIn:?#t(9&d&`j2>.1r.r,Lr
/*![Xri=^[/L/Q%L:c-.)e?q394]AZr==@UgV>DAW%r7aO%2N%q&u&Vp)B1EG(Xu6,iVe3nRE
"+f_6VEgr:51>i0'ag%)@F@-Xp?@((DfCc1nR\q,h$SEeW49#6S!QYYYh,l1a3k`,;`n]Ad2Q
b\#4^YY.mX_H!%N.4<ig.[bsiWo)JB`p3@Eu[Vp09VA?.V!E\0]AJZtJYCmNo;>WU&+p[?K06
u$$ep?6*]A(^ldrT;"V4*tg.neJmhPhR9Y4`KEH;jKY72sgKp*.MOf/`2FWklmdlsNLS+SR5t
'di5re6AaDZqH>Okh1`LBs(atpXA+*$,lSY@W0JXD"M6gNVg1+9Ag;.(JCbF'a.j=$$6MEZ=
M'3F'sA1T1\$Ke&Wn_>Q\1O>qM2Dq\"!nkABkZ!6cZ4o3,.l2bE;#;K$02Macl`BA(V[jsX7
QjUG[E*;!KAlMu,.U.*R'm=MBX5)T:j`W-DQA[u=X)dWBo(EUc*&L.*B<WTJ;JBgXMPC>,6c
%KoRVogOq<]AYEYV?)&gj?=tp-soO5FG[?T849-ZjI2q'(C;&*<:9XT"`>KE8#@3A<3p+UQaS
T9p]A:USOl\3!lblN^U2Yr71Z(o/S!eW_BeKHFLL=#WE_!iJaG(g8-<KFm^d52`2Idn6Aa_;C
4I?bfWW0@c<pk=*U3>Bn2#lhT_T2]A>rpNBI\XX.UXC#1Scu+B@+6c*qi!fDg!0!P@fTQtACW
;i>C0`th^3a52IE3/jqP[N.p;*$4"?gVmPPtp`d1uRMBe[9PgJQ6*a]A&4Vs"f_8Mg#/sEc?0
O[@\V/]Aaao3^Rh+8Udb._JC+iBO3/7E$H_kE-qdOA9fFri1R5@o5&ol)E(9r42?4,qp##M84
-LGt?/5%L43TebbgX'jHP*C4bj')"\d.)p:<k-Rhl-d6=^:IiQ$W)J]A$9.-%k<>R%+7<I*o+
&W4q[$!<<eJK<Ne5;d@/RoB>\%g$Ce=G]A=O*_f6I0h<?.l3E?W`aX@V,u%]APs-8AkNu9?mdG
OKdmfJ89M5]A_nT+!/Ih;6bPZj=)bBQqf$r=g9gDrC%!'(^#f)afTVX3$mf@jdsbsE@Pp=o;t
oL3HDJ%DY,'sapG>)pPl`]Ak7l(@P=-H;oHYjbses5(BVqf6^%_A_(7I/NMnX>f5n8C8dV\_s
sHG0gs\K_H3T&tW^6$W>?H]AZ:sOhR/<!F-s5kQ94bk<G?_-m;*m7VT#XltKuS20F&kMeuQGQ
YO2smKG9c$Sr\GjL0E)=af5MGkWl[5@#tYX3'u=RlLe3k$o%$3PYWUD!LpBRR3&tI=M8:7]A@
54Cn%#sr65_YV3qmDnLE;*h?Ts7Yn-![$^>'Q<'T'^:qE#dPf1*@I&RD)[ntL4L"d]AsBnW\[
E@<h,nh=Ij9Y<_uRY=fHEE"#m$YNAOoY"([h6bIW'f4"D6Cit8+GBX:)6([5(To\MoU,Oq#t
p`,fZ_RJM+?qa9E3Z!.4nM</48"b"N`P:hZsWpXa*A+"rS9D$0U>Eho[dOk\Y5S\!co$2;<b
i"J=uB)HYb_!"<hMU!-QD1*pq?_7aK[0Nt[?ZUQoE2;ctai#RmScUC8@MsF=)de^6llsa!Qj
$FA.n'3[*Hm9ImWNascdh/(G]A>-@^K1BLc7(;8(p<E>TjCf8"1qkTnVli,Z2phPel3'3($>[
K6<.o^MI%fQ):!n&RA[MF^@H!"\gttX=;/dCM8E*8_@Y>)[Kj<saCu![Co1`OaHs]AZ`gg?l"
jT)`0$!9)b`E-H6gtg/nJ74i%HI@]A8;8i[ihK61;$)%S9-@1cNLT8D&=o*,ihQlaJ0TE`&X_
_M>?>^"&QSli]Aj2ff$cM.!tY585Wb9KSpguU?\ae6F)gf=i-&t3#rd#1YiC&GAZ?V'RK3*Bo
cl(;_nG<W[YB%g&(5sX`\*qU7u?O97irF4C12fp/q[C=U#>GJXg7$(6@?5m6eCuj^>&[M$%C
7/a/rONOJcUNsTUI0Bhs40Ae?r^GO]A31JAQOPDZ,9s+,=5uZoH/!h1"a8/EK]AIM57DF3hL^(
2F@HLu#IV2e"^G[^EpN1d/%'cLip@)Ae\@,'@<r#h<mdN$/L*sQ`_Eeu,FuIT-:nGue.YIB;
,@g1f3+hi)fM,]Aprf,p%Z4GTT;mX0be=d_d@pSn8,>m?1C,]ACcVc$e]AE$hNn3$t(jS,7dd9:
0E?L)\<`X>['qf;1n*A$LH4:g!Nn<:!Q.D^Ii9h^O&%P/!52ObF8!*PRJMGQ_F0.kN3!Yj!C
+I'lYdo'6F]AU]ARiRgF]AQ&Di9:SDuHLa"buXF5Jul?`!35C?(A5rJgn;eac\#gcCa9Y4r'hcC
n%<%gd_YPIQrK!>hH4;mof^:rA/hdF2;_@'3spR6!<-C<$4Wf`8CfcFhJl'#d>JYmDk*[4Yj
pBj%=p5eK.f@%/7U3UZ2s1PU"hdULUU4fL%ffq(^OmZ<(Q3lYW4Z/>[J)+qiA.]A,)0Vos?.r
nqc`!_=lIOQ4HnhA)C2Y3:15XA<06=FX&5?bV&hI2MgIn`gk>%*^GhjJ3O-<qf6]A:pRnC'b8
Yep%Vc/=/#'nWru@IB7O#2HQ<L&`($r.S9+@-!]A4l<HElKH=K^2Z6pZo//TaDl?)aMG3Hs.X
6_.KN>aE2s3F"$N1%lboo:Ra)M2=QM?RV(Q#gBbMlQEU\1C'FB`qSP0IJ/JM2e[A)hV59n.i
Ffp_fmT3,p\ESBL%s[MdEcct(D.>IlXT$4i76E$O42t\5h-Co!??R<[Qg83^.WC^a!<rP;'0
s!=>Hq9=f/'c3Z'+U,R'jH:(*U":/ggk4VBF!j"3`M"eI^(NBcuLQl%HbJ3lD%K<.B551i6+
SPhY50R?eZOK@Yt-@Q,UYX,E":f40"Ljf*+<9`IC(pRaW55qYYbXfH3[ZO0$a@j-H(V>#aD>
pm6hI?L0=oW59,oaouVRX9N%tU?jdaEoX))ThW@bB@+Ysh;sd!=YD#b-hQ9%J$RFb)i:8(HG
<A"/G2STN]AXg.`@?j$P_WB<P%V;=]Ah(P*4S61gEdNJ!HAVgfe7bZ.Mo'&:pMGO77Mfi4'EuR
f5]As2ta5Qn,7-?4WR)9j]ApnICl3@VW2OFKMieVok6SEn6o[bq%Wj&\IuVLF:Fj&2]AU>KLm36
h_0K!/mc<s;$haCJ6gj]AEU29]AOZN&!8r^e?(DfqUYO"k==<$K\E9[J&7'KRBEo&dD84-169V
aMERn!_>gb)opV?Rt!d9]Ai@ckXn%tcfc&Q''J(:XO*\e0PIq]A\rop\%M@WlFK*enl"DsYY1O
;m`;"a,*-]Alg&Ea[Hm7=\82=Zg;s7KWYs;Id"M$G'a;nF^NFVM8c?<&uon^Msc]AHs?-JSG1:
#!Tgb924)=M5<6cIRC%Q4L%\?37L.Zk\&]A6^<W,2e5V]A,<REQD4I:s@XJ?%G\\Rl4HcCY&@p
0,J&\qjE;]AHITmH22r,cL87m3eSg7K!P3/lETsC3]Ad*-U:ER14htOA2nP#-aO=ooIuNH&.IP
;mDLZuU*+3]AQ'BNjlB*Mc"o(5]A,FlX*<b0#ToVRQArN_cYBVigTu5p9p>`-;c^=p#/Xo@,=7
>'F`^F%#@O:c)+$RK5Yg2s@.!J$GlJB3HEt:FBEg:gf&jCtJ=:q^D5;>?Ja'-RVMODr/+%hI
U3V2^ep`e#OZ>r9TK\$oX<t2eZ''T*&JW"N7W<;)s)RpHT&Ng1fL@]A"5/W:*-&e@'9AD0oMP
McRY,?O[DM#pCJ0*)fYiG(0qc-';.!Bs7HfX4GUtr-k4<C)6X:%6-9.L;?5"f:qV$VN@Pj2j
ZmPdF,Q/]A&c&Mi!EHQ69mX]A8!p#6Lfba7%NRMn2l6A7r8-qjZ"fU,*)d:uAp2Ws;801gYc*K
Jo:2+`Ip2$/Fc4^.J.X!2U!\>B?[RK*RLDRIJkPnc#<R"^+\Y%$d@7N4D&G[,m5Rd47d&i=X
5b0>(jbbf(l08lfBB,uJp$Jpu7L2O;lR:fL!=tRY!bie\SQ%G=A!/.,lRra_S0!F<1i]A&jW`
jDas2+[AiosP8-kqAD.eLC5?92c\5R2T9ri\3TA)[GSrB7dRoX.q#WHB4&0He!['AZmbTIL'
=&PNa&C6'N-Z0/VJH;6(M)?\AA`i!bcV"Rh[16u\5"E8RG\B2^sq\8jb\mkLODJie=qBb&\B
u8c/6p6l=U16M@:2R4Lp`'iQ7;\b'+T^haqKN4OV=hS-pV)@bDl/#TE76d+6(ec)T\sSl8:a
:H'.atm>L%juTgo1^d#TE=)!XD*FK/4]A>6GMFYl`CV_O@O#'SG1VVoP_B[JGC#GC;J:Z`W8Q
*"He49lVTTpGhM_DoT?Tc&O"ZC[cj"mTLuGR5`q$o6gO^ATEQ^c8u6JD;.iW,Z5-QkmXfdT8
^S^[##)XKFm?o9W_k;Z,Sn.;?r"T+2E(#?S[((#MOjHrm'3rhR?e]A*R%SC?sYI2q?Lg<N*JR
Z*Sbf[@*`-kbEI([Rbk?aJ38jT1X&`W?0l)[n94UJ'-d;.-Ed?<CVWTs*l"3J;rR9>UK$V%`
H*/@e.F:@6c8s9G8:'c<hmT\oeOq8*"]AH*?Q5Klp!X*f[=837'3]AEG2Y8\VS!PPdd!cLU\FB
nr8\csb,A=2]AZFOKA)?8CYN810r$fgdnf39,50WEO%4@$cu8J)PW[q?B&LCX+E-Wf$ZpDAM`
ph)K"#Bj98")>KGdO8Uf1U&>RJTY;a4WC&1ecrZrXsLTiBl<;e#Qc=&ZaIW_9Prdk@0@R__Z
LogBpm/0QK7%0%0qFoURc/RKe7g[R<b5G+uuu1E_@XnIoSlr(BeIgap3K$AR<YSQ6XUZQa`Q
nXfP;Ul^o0;HW[Tn43k7^TA!,l=L>&n+@o&,q\&Zk1$%f$V@%gB7h#JX@.S&L<Y1'`pM)Wg,
P#9BKE_"-'u4m*[Vlt9*%Z_9mD=\H*MI+3ZO556T8;diJC:\:Sp(AU6`cr^Yq[P*A]A5["?"\
,1*lRd_#_+_F)bQH-FjfING?86)feN0mX%pFh@cXC):=euBaUr2#lFeKq?-\cmTK$l4oLq9o
B]A)S.2qMR&,,oMpMjfJ6)Yk\U9cB.)C2,?p)$HD1p(N]AGT]A9)BWPP4poSJH`3,,]A23)"2I4T
[\poH8+Q'm?-S1_bRG!]A9YMd3C^!o@)"_O4pYV+!a$pU\JKWg^Hq&m(*.bI&g'RZ\//>0/V)
e%[6tJW4e)Nn@GYf3g6T0V]A,oghHl53%%s(]A5X9;[qrNL`!#btJi1rIu)"^6#!#O#Te@X$KD
M7K5:PUj(V+NbD`[&)K2oUA60#jg(ftkM42pN,"`kNSA9E-s^qP!tGq+K()Od@h.IJ:5;^r@
M)!8%^?+9CU2/Dh;dFXE>+p7t01NBh7):IBD.9cpQuFu`VB4#c"]AI<GDPVDMnF'd4:Tc-JLA
[1sQu_93`6Z24U+X]Asm9-gU)F]A_N'DSCQ0_mKD>9</uPTcK@Je`>Kmr[i;nH49F(UI(qfJ!]A
>-%e7hY2?jcQs:)jC_I6--_2(uB:^L?t5rQ^VM:@b=_CI8LO@FUp'ruV~
]]></IM>
</FineImage>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" cs="2" rs="3" s="5">
<O t="DSColumn">
<Attributes dsName="上月航班量汇总" columnName="月度汇总"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="2" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="3" rs="2" s="1">
<O>
<![CDATA[同比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="3" rs="2" s="2">
<O>
<![CDATA[-]]></O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="3" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="5" cs="2" s="6">
<O>
<![CDATA[执行航班量汇总]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="5" rs="2" s="1">
<O>
<![CDATA[昨日]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="5" rs="2" s="2">
<O t="DSColumn">
<Attributes dsName="执行航班量昨日" columnName="执行航班量"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="0" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="9" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="5" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="6" s="0">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="false" bottomLeft="true" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="6" s="0">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="10" r="6" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="7" s="7">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="7" s="7">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="7" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="8" s="0">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="8" rs="2" s="1">
<O>
<![CDATA[环比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="8" rs="2" s="2">
<O>
<![CDATA[-]]></O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="8" s="0">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="10" r="8" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="9" rs="4" s="4">
<O t="XMLable" class="com.fr.general.ImageWithSuffix">
<FineImage fm="png">
<IM>
<![CDATA[eTtk1;esu3l;:MKX=,9#ThEd(P849%J^?JLn.7r%O:DR'G!qE?KG'Ln-%Ii:2/lM;&t0@;<D
[uI&1JbJ0ef*gSp0>oB"iaNf/5@pY5Hq!YI0tpm/9'@IBU=cN.mZCs5A$SH$FT/NGdXZio/Q
X#6%$r%fg8!@ShDrGiV%+h7@;6rbhNn.s'&a@jb[IMbn<e-bIqmd5OK(n'U=+&@BYBrEA]AuW
=HB7Ph[?__XL96a8Pa-s0;U7^>lmcrH-VZfh%SURC]A34R@p-h)CrHLC=.!(b=IqZ9MA,:'En
^:5PrpO6>s1o=N?>NQU=h2(F[6I.tS+PdV#F3p;_7c?Bhf2:faFMY!=`qL98^.N*IBkF(0S3
9s_t4@g`O%7Wrf4/HQ`[*n/AoBeZg1'_WHg>?"+s@k1hhL:U@q>^Uj68sk/sa:h+a\._-?F@
[Rf_.T]A)D#4O?Mq@UZ`M]AWj1ntJU**\m';KZ96,:cn5%UFJY\cUqS.`FH^q"5*p7N92G(uY+
DQfm%If)cA*]A7Qj]A3$.D8jDGYLJPK,[qT.L*]A;M5I7'%a@2d=@*"%1<ueQq[4kQ]AIR]Ap$7jH
T2o3,+pp2j^;uMp)3Fu7GS-mMHBbJ<I?S$k40e-c=/OKQ>Bh8Q31Tgn/b+7&Yr/5U:\5XG)u
;#E/3Dl^_legd;\bC5=_ja(]Am40a$T92q3SH4\*j(Zm#`)(+/koYM+l?Pr$<R'\tjRq%L5b<
b;6b1%27irj%BZt\I@Zs6L`9d!,Ci_R>IIV?+AO?Z[Rco4Ph4Qn*rK8i9fE@-A)4[%(s\/Si
bPAS^$c1+RYcjG8Y8#C;eh4dO?4FQhhD(cI\PobJ,tC=Q0@6o,=<u>m%Re.O8*gmU+r:UqJm
rKi'qnU*@KrVgYt78%X6YR&4_*KHK?%Okb::="<f(U21nY4b`mKH5Hp69V.A]A0!N%cGJ"I>O
?G_@DW1<[r.kC@kP=Ehi:TnRYi7CXb4+n286b]ATBEEoNiW"rW)@+KLPk3dH7^Oh0Ksgc;<"M
]Aq>haoo'@j[,I.iQem7A>[YNHPCmHX4dpY&0(HS$.IP)u3X?2=.LEFlf>A7`j4?`I@1R$8,n
9f*]AVIPr>6X._c/LN'*ZO\XGFc)(cMr:L?(d]A'0KmoZQ+!qIB<Ar[,lf+CH6IC'AQ#N/1W5S
7>UDm0/N/LJH'`1W:VeOgWb1uFVXkFXr>Q17/efA+uL`YI&ISOsFk^#`7@J&FT0?n.>M<!c3
:a?6>;N"OSZs7dsI&uY":_c\NWXXjsnW_H`u$sa?KLD<SFp_Gs<Bb$I("XVSGGRc!"!599ZC
>7oLpFFY%5-RQpN%Urd"F6T3J_?Kbn6]AZpg08c4R'64<c#lG`ji)8D=k!7Im&C=;b_S5mlea
EIf?nF"U3M<@(RGqQQOuCr24eS/<pr,Y.9ShX;!64IpM>k'R$>;N9B_)c_V*aBn$K^p*IS'7
D`dg.0k)ATKYU_6rq>L+R;C15`^J#8O,Y;<M(_+?"i(2(W,sWEGlYIiZOKQ,;D+A+([Y(%9c
!HqVkHL3PH(pbaeO0ld;2?$5<OoImW>_Tc8UE@FjpBXcDU@m"W-A)1*/='bZTc<Vf8XG2h[$
u2,>!YqR:fIF\RkVQ1U%NXj=a:<MJ+D`m9G=pa[J9E\G1pG$?6E?=n;2_U13UHDRs7.]A^gm,
=/:[0ose!mD>.KT:S_KPYWtNcTQg+HdgdCE"q*l.lDGj)+%Za]AT0<+:aHdK3M3HRg`36gJ)'
d[kFcPjGT)rK[:OnZ99[mj#0l&LDq^ZV@i]AqY:smC=]A"(KHV\!c"<Ul7d#n1n^dBbR3R/J(H
3HTCYp>2Gj%=G3@JA!,uk2,h:_>)Q)$Q0hF*EP=&O]ABT&Hjs06bWQ!?_G70Jg*2DuUr?)o9Q
Na+'#2b7n0N`6anegXPCC9r%UHAC1UENU*2I^"NM:U+9X"e@>"g3.D&Pn2LPIGkN/2PB@R89
s9;*]AS`F8D)(:B1PCR*rG]Ae*RE'@H<G@HR<Hatmds8*[R&"uG<4YoUfLD%1.T4\_L+)[eu%N
bC'*B"i&In]A4g]A2+'6.F]A99(2C9<S^7K!9RpV-ncpJ&a]AW\9qJ*:L$J+G6FeO%*-^g=CIp$=
aV[^!WT>cJ7qrp5(QelZT;m#n?]AH*XFjPF6YGZP116q.5@<GRWkt#OSus+t;oEjlnn<o@CZ(
[(BOP]A\5k5_8.4gH!WS<?R@A?LD@>5Z\9:.A(%pD0T=UTZG\t*&"#,r?eA/*BDu;[Wm&I4Wn
=l^).n305:,"OqZ/,`jBEP6P+fba=p0:,l]AlFVj@NQ,aF#-_KX4o6,th),qp$7I@:-Th=/S5
:AHLfm4d!S52l29k0Ln%1:C1<2RGd5PJFWeDVg=]A$E/&.U1PJhp^5Kmqca^X!]A3jQL!nQ\?2
#3mMT#^^Tm_B6^W@^>]AYG@B'-Q%]A(HZ<,&0%I9jV?4oP3FMes*$Dh$Y`?4MR:d[+e[SCi@2C
p*=We,hCUbMj,HUU>6sQ@5?)o?n!@.6g'2/7E^[\l\bt?$96]AP4n^"bh-_J*qOQ'_>f[cX@O
91DM-qt:rdcIE0FVTc+gAt(XkOI4c;Isr8-)QSF1W;0LU+:HkM%,e"I.mDCd`#D72ff*ntZQ
LUi'=KP=R0A1Oh^%Wt+e!3t6>4aD;lmc/!$ORq5N8rd93Ba-(%Ih)a<!HQ+^$WqQD91/aK0&
T,&!(S8^/5[O/Zi;8,X)?WE6:+,V[DP&^!+mJ71aR;g,UFn113uf43N^HG>^I]ABGJb!N@516
ajS&qK[Ad\#Z@_QAqe'ie7)uY_7R,X9N\Z&^UQsrIn[1Kf/E.nd^@*'sq=WYpJ1%;j)VKoV.
nq13ITY:I-:i,UG1H$rn53ol^=l'.g>k*%Kd20%a>X.dW_T[N<&WRl=Gc6_R1\l,R)%G=bZa
Pk$ur(L02C:/HU*>pu\"bB.JeET54E(G)R6=&'I[#D%64\,+8pBe0"IV39r7Y/c/.WjEc[e_
G&``.6oUTU"\:=e:5[T(.@43Y8?2DQ:=bKM>MYi?cW8SW@^5p9DS2VdB/g3f)j,^%PD/]A2$^
+M-P*pCQ)@;C)Ah7X`<g<2s]ADWF$gZX*P=0S;/LjJq3S4j[H8(2P6M=TE"7COOpsRPCRqA!Q
U-2e?@,g&o$MfgVEl6V&>lt>^Gf4UqjD&9]AJW:&_hk2AqrBO3&pL0L/-1H?L,_]A)GE8!>f/p
tB"]AOofNIg$)o3cZm?VQ1urO'QnED>LIXI!))7-U/OFKhNg\Ysq5H`nON8,2d=fMI/WpGSp&
Xq3pp<6l\g,,fcA+dM:(m9!(CVpd!SRV">9oC"NQqP[FQd$,Lr++'k.XNp<&D-l_o/"(E=4Z
efal^g<Snee8:AorV?0RL,>mZdOpW6Qe;X\.%Bn@$,B]AgS^=nWrs<S*qMBaj%bu'q`#JMZp-
beiHpJ>Urt&0f.g[@ad!m9S-^\C+%,/HnHUiUma3M:qO;$<YEsTm1[+^oQ,sQ_HGW=<"QcW<
;)_Jqs3!n8(UB$k>(]Ae`mY9p:`S$"\AfcEp_hU@,uINL8>?H2LNR&mlDue85a-$]AA)hB?Ea"
a:W&;#FQ`qgg$XQB#N".>#RW^5uH4VXI%X0[(S-#``SsQ4Vel-D4aM%H'&1pEk[[/Y*0paXX
Z+\_oe#:@kq22^&2X;>N1^Wkd[`n)13cWAa`0(4(;dnS4k9,Khc3b)l4pnd7$S@?.I$9D3pI
"3DB8!/BbRNhBMOX!f->f5FbT:tP>X7BgMiKq;.%hoHq!!`.PE.sR"!1Z:Rem,=):UqGf#j)
$I["VM#Y27HL.LO;5c`QE$l,1Z6ST:X;e>=U:KkYhfu):7W^OJYi<3eeq\)[BB`YVSFE'/Ta
fB^#"Re]Ab>g`5bQT#5=RPcVro,[5=r]A%D05&/TJGo`,iZA%kM=u7#D_Hf@=^/ce9=MdE]A49j
!mRPcf;!d;Q$I01ig<@>17pIgl.!-oPC![-`L>H3FI97gY3ZF!lAU#j*dDu0$?1N2u-m:=Lq
T[%CgZ<7rr?ER[$_LhLIlJa2qe^_gPX#%gij?Hr]A90MkDN![&7(.TNBMc7t2K<oE')KJSQP,
-WV(UG8K\LB]A.N$^K:WY\Pk@meq=!`/LA-nr>a121go`mUj.EnX>5_r2cu-B<+.`>rM"Pqr5
bp9ts2aLlI_X1[,\]A$d3Omi%_g$#s9A.gt>=Ca;)g,,NpHF2(a;Vb^0dqg#S9,:Io7UKji*Y
qdpt%fg[:;@D3>4FIMcf`Utl%E24LJEQ[B!j?uPBgKK"eNh7/h([D`FV\sVg"8c+dF"tIp3(
,_63!0.,`hn\f7ZC'=eE:(,:uXP*Nko^%6QnfC[u@S-VT:Za_-+)H>1Zr2"hc"?LKUR=XCYZ
.$CV^@-f/Wnn8;MW24c/H#<oa<j9hWCp]AN-Jt/m*Y&QP!J%4oEKMYqse]AP_(g^5]AR'rX.`mt
mj-"WGQalB<mC<toQiId;o4h/OLp>6#Jl^de5HMT:fWXTCu2`3g!Dnsje%D0p_M?24#Wik\f
8"`(1UDs<hh3C6K^+gZ2dPEM8,i")@f`ZEhNFS-i"rSa>^dqt$.(MLuHF`[H.hbsuX,,sQYL
\WRCGHD-2OhNXBZ*9!Z1Ojkqs!(q,$87PG=U0W6GnS]Aj#(Xcj*UjZ[CI%r!!omMTa[\Z&5*^
0F2kNKU4FSD=3-C"N7<-BK&#L>3TW)Lsfn8:Kl+5+)*^,Ji/gRQgM07LB"A2:^%/K*!+]A*s?
Qf$8$I#j!'gft0?JM%c,#<?^a\b[PGasXH1`eXL:r?L.pE>KA]Ac-escd_fl!G9lJU(<%<K&)
g^23fT*&<7F!H<"C`k<--7%!k.kj@<i=t@Gc+nFOD0LX=n.'pQ6M-kQ>tga0+u[ZPnmPqJuh
3#^ZQge^XMdG_X+Z\eUgI9$Km'c[ED^6\,t7,>%Rr]A-74A(qRWNIK\U_9pEoS5gATA)W.hDL
W2$Q'B<j#XX;o.7+9?0!S$1@5q8LXWXWqSZI'fo@L1-,T@%gOprPO;_aqo/.e>Sm"4TYh588
8d+Hf<6AGSQhO"<4+*hN.r:B]A95mKNtt\?j_:N*`mH:CA#LKJ>6XC)PLC2/fgTf$>*d*5&J#
oZT\#hl/.SB!iEnMA;WTMoU1]Ajbfq?+CC14ithT)=G-q0hK=*LqZ0A;"\XW_FtZjRlH(+_;5
Yo<oOnWf;9HBq+V8G@AgN5;-<6nG:<t/4?dHuRI#=E,)=1/mGc1PiC%BJgZ0'2K,06=jhsU%
&]AtD"HHP^5kUrji\W`<L`;&VWE'^k#jkTENGY44-ckCT!iJdR5BoJp\&'.ru+9emV0pU-U97
:q"*KBnFkEpuiE3tXu1^GgXLZmif5H3ne6*1[gj5h[WW-CS^@d*=*Y?,A'uo(dR%-!c5s:B-
/%X'9ls>qt'Sr&CLL#>K3"1?Xs.l`<NW7X-!kd(]AYR.Q!ko?dm%i<!.7WYYi,Flh_qe?ucC>
;`#?#?SThqDT-<9+*,]A1k\sEUf2@o-$eTe<J>kB5J7e,)pn%qBoYb&,"rh;gMf*r_65&#"6N
fE8ni#4'N?70Eh!$C`RHAM<_+j+q!0<Cr+2.u=Q8aD8o[(ulD;@dCg@"b_:Nhit);OM^Ada/
KKWhBXM9sl`H!j//Bmg72k[?<V,.E>41QN%fM?]A=_i'c+J5Kc#!g"W$!@.\k#p:q9Y8,J*:.
ZYJ=F?*7L3B3Kqhs$DGBft+G7'Ur1:M9o>m>*T%,?]A#,WVX,ge'VACTAN"n/FeG5MLGqc52d
l&]A`PuOW2H:NLl=4Ue1WtTp=,+=7I1m\_iW3F5_eu?A$8[Efd,iJi@?=3ZT+mAnb<WMC^C!@
Z8Z6q[rdp;*fRJTk$1KdIAh$`?*<D>n;2nq%@"k\YCr^*JJ<`_$#`q2/Sh."BlbT9Yf=DYHF
ArQ*=$LJ1,"r!o,mrH&e$ie1;HWVQ&P\*b!`AVm'k4.4E0@tAjk6.kT[rg'tmcmKQb&ejsYN
GUC@T!#b4U.3q..ddd&0i1TVE5A_11Q&R,amkBlJ;ZG&Wdb;k(.65![jIqAkoBLT#A%39DdS
1=ZHB[4dj@OSIaT:%)i,nkYPPOX8"lKu^T\jmJnbn0$C``2W&ckXg3ZS;ZhK:Fn1MQ>pCk3.
E9Za<=F1R2g"Rg_qo`pic6RIQag'&2/:GJpLh9i=/"`66cj%Id-?1B%MO_hD6eSgBLs;lse'
[ZTt?h$OB&)+,J5U1$.<duVh0R<51pQ'C:ZeO,>+s.F7m,'gDkASmZE^;o>k]A16OTD]AK6p'Y
;pf8,jJJ.Ru]AaVU^;.)+UslY):cXP>58g#\e(o0lheI.ToE.lR_P9:d&&X$lm;?4W6.mggj=
"Jf+4o$u*D=N_TiU4C!_;ES9b9mNT%I%\i^R%=4iIj[;!rJa)7,<YC6f\5P?OZgTiB[d7`-;
*-L?]A5%<8:Q6_\k!812r^Lr05*dQXHV5#n)'*Fn`rY6(nni;@JdVNc:.A[Crh)+aB4Q5G.FS
Yp-9Z`a:kR:<9_2?1'gj\f:\>HqUj8GtCNR:/RAX`0C(6amG2NNlPaNgF0J4/%+dfU?j0/-g
3&2u*)',`]ARc'E?kclXJZ(UOV,UH<h9VJUG!'A$NPoA^aPt#<nR,VM7G5?FaM$p/_4f5(X_!
6YLO:8Y<(BLIH+>n4Wa4]A`@:<q-FRe?"Rn:7hMRPekg"7)L!$89*pm`oX2>>K)E'tL71Y/S,
5g3((1F51oG7O>4CQA3O/j47fXXmq3PadPl"nr=Fu5#F]Aq4M>;=)puWZHa6-?KDN:@MXO7/h
]A1a'?R"EQ,noo#_N>tqghVOtG]Ad`Gj_(*)f:KSYX&+bh]Aa4TB$B9&!l<(5\BksbU!"%C1+@B
`>X.qcW:FUqnmesN47rcPO=N3FO5iBM.Dq3m(j$<8l#AZdd%Mi6hf_2AA;+4%,qfhX[$foKX
oXo^D@;%D:W<FMkW;BCRT[WES.V6<Q)5!Ko*qer!O7:`e=t>0XA2q!^ooU5a]A_gC@&DLfQJ=
&7&H;Dfa&Ws5fV'D2q7q(1cEuM;.lueB*QCZteR-9MeJgZ[&S$rSlXLt%(5W%9jA;m1i'\K-
ifC@OsA8N/p=pN\X`[PtonJZK<;i`CZG(IsV^qY[#Um/_&p=/pEj*/M9#P2Tg2cQ:RNMTp(e
u/"4A*A-/EMm09&4^gXA6na(774i$1:aSfh$oM"&\hCG#bgJZA`E$SffR1H(ZRq@AsN>%[,&
,">R8>I72-&#f@E*Z[TTUj>('VO]AgY8[G52r#3e&[*2C:hThYp-"cqXk8s!/%a*s3_&VHR,!
iV1l]A>%r&CAu7$QnKGc_NP&'YYtnD`g*9f[J/,[N8d'()m@!+e.?Gkq8mD<),^[=/lK)mAT3
JAW^5VrOSMl`=]Ao8'tTr,2W`TqGZRDpq4X/t?LL%()97n1I*n?ID;NHfa3c#DR<[RE(MaNpp
B6+m1O?"hV^Qon@-\a-%VG4"aF6=C,tVg.!7i[+`Z)`PoG?1f5'lH=E[US@]A<a7,ZQ)Ucn>8
:B;<Xk<lBPlTJH90p!=`%]A[^T!c@h0c$q"auF-+l01&[a]A8jK$^Cd>0"^X$L.-=!I+IJpRrt
ZJipkS!k*4MJ&Fo'Z&A`#S@p"%Da:\<t4!niKn\pW'RK[;gD_G$b"=rtr5BZG*1P796:"Ia2
"19&n[9`W-ooB.;miqMuh-GB,`M[hhT?n6\Y"^Am"n/jpXA1ZB>krS]AeA.%"TG6^>'qeG_Zt
k^#lcT+mE/)P3UQcQ@6ia^B`8#_qE>Yt!DAsZ7Gk^VJ'jH/)J#=Ib7KEo*,1%)1BgD[D[8@,
nN+dda0\#]AR-80OQ@;iXpb+kofTtJW_WR<#[\MlQ0R;97RW]A".qK"+t(#f("=`e61XI*;9e(
VY%ID=;[j9)ZqC8[ci0ne,_I+2ro2R.pd7Q&:2h$i!ICd4_!NU9@()@5#RRP,^o@8t9<-1*G
h&A`#kp`,e6"+&DI#_RF]A_B\2[s+u;s:Rg4g9^!eA,Ms1R?Zlq%bC9m8P:M\7j"R;0GW;--S
?l;>K'aSDts-HPpAT.JiG<*]Aj/js8L2JljlN-Bp18%MedFMrTm[Jgc:qk5]ApfsbX).3i#jEm
3Y+_usd0-[b2UMlSUg.E:PQRJqq#X45fl8"HV#;QkB!k0_rZoaO&n\YUm$BYX-3^Tk1/EZuM
l&=>;=F[P%Akh#2uhlcfFg($\!Sp;#4MS`q>R!\Hl2^T"o'oaE_qZb!7%%PdELP<AC'^SP%X
2<77RXd(:]Anbsd6M;GS7/16i^)q$1Y!qr/6djit^8*u6$'epJL_L+P,r:\L5EIH,Pp7TnDc#
T=#c1170_QSKH?>j'nN(!]AH2-`NWd<k+:uU,@^*lEWiL/4&.iRhk_ueWPl&^ciQ)El!0qFN]A
J'1]AE;@-9,kZnf:6Vr>I2&Stp*6[=3f+sHSg0@j[Fq=Dp%3b:SX5@36.3.snrY6doiLh.h7L
MDkB@?8j(._L.-roVEcV1o&^q$6+W)BHdf0$b0O?d<u.d$(TH!kKh:Gj3K?V&L#0m+,R!K%k
)G:Q5dg_)#0DELl.ac"k%#M*/EL.EJ!qU\MR@;XdrWn4$ERD!5n&eeh.g-8CVDnh,f]A/<@^I
tHW*,\^aa=rKiC/M*>S*c^l=lJNtICVG7^_;o5;f:M8+B$*(LeXN8!F0<J5,7WBW2n>kO>H"
`NW['2M:U1*j49]ABh:jkeOJg3JT>^f_Kl0Q5A>EN@KB23+kY-W54!^7Y5rQ4\!h@iTrIIUc3
@ICKurppZ]AkL#"qo5CkSA!ne@/,Ci1#3N=NpDmqtU9S?0-<ITTHJ]Ab65G36pQrJ2.!9A4,Uf
.Nm!NqWA'M*^:ncoM-hGonP(M?#(YfAYfCZ4$!T:`E4iu`k7jTJ9'KkJtRXSL9GmbPfEQbh/
eSlZH:1^]AK)mt(%VkQ<?1%^C"s$GF^T5!`B^4odg6bZ[fQdDcS:B_3_smN(41<Lo(jI9-KlB
EE.r62_+GT@fKohh:g$`-\kV1Z<@?$0rl@E(-HUOP!/"kb1R)a2LiS_SUr9M!J:eCG>l66`h
j[-dj%-'WguNr/g7#,C\-kI^?t1lm6Tgk3!O51O<Wq$3dkNnIU)tkbM0RD]AXS<+[do)D=LNu
4.Ulr<aQ_lP52'4#qr%A.NWsZn#GmJ]AUo&hf?;IN%@US5W.9T41tbPC`P1@[j\m@91Zr37)H
ig$YeJZMkjrgV082C/FNSLU@/,,A8tl4]A+r)Bq,Qjs[WSD-eK6,A-*PuQ[q-C9"P7M!jMHC"
l43ila]AP7%BF/!YrAAQ"%b-$1jT@TOS.ORQ8cR;-?(]AF/:m"_M+q3rLP7^F8i[hqJBB%6:j>
7+8L:%UZLU2Y7Ii=@t[c1N\SW0R^<q'_^3;OOc\DZ9792-rj[!n1AHH=<+:cgt?H^3HtqCJC
ou=XhWYqsc"+;mm3)In!!0Xml-k8n+`Y))1GE+IqN3$Fk$d#P*Q"r5G-)&KlWnYGL48$CUEn
i*,^(7JUlZN,AEQ(7b^4Np\_$o![!Pa-Rr:V>`bc3R4KmbbkCQ=t'Q8^#0gJ6A'?rp>Uu,lk
Nb8duo8Qe>3bk;Wlb0p$!E:?*#Bcn+!B_DjrNJH".F\X\E/TkCs`[Xlm_<c&[$$\!1hMi(Hk
OWS^@-otIB,F,`AuJ0+;Lh8)aJcUY9QnTP+BpOZ\g-C<V^/=/KXBI<O@!jQ2d_p8.a4M*)1P
au;AG\)/SaXXp?C6OKFdK^J/!k)FnjbYY8&h66%OiGFtC@F'1JcT;VE>5!VHA%JEr"S4]A38A
3]Agg]A)*j)G2o!HDjI=_EB`EG)O;!L"*ZbGl6[hQpu1Y50ToU^]ALT+.@[YjIm&ebBk(T@5+>G
i1Fprg6[:-U``;E=]AY;:ooZ=4CBP;&5P4"X)=Pue-C&[XC[]AAoNg";\]AHhCWU_`_m0:P\J*l
nd((:HG(W>J2ApEF/)5%":!HODcVT,>nFj0]AK)N**I]A>\HEAFIGjeSZ7-Fk2-_"Ju,lR\p&;
QAJtnF2#WPSF1FTtmOhK-s&QRpp-c?ui9A6JbR-]AAY-h_]A.OiO),Fe3hnGq@:*6"n:P,*<!!
/8:JQ.^;20+q)3T8eQ7_#Ru8i'S'j0`9^os8Fd!!o]A?ZHB]AZuRo8@IgDp#i'm9-&RJeNe$b=
/)R&,q<\s5u[k)*JHm?O'^:1(aeWoZPA!]AcrC_Fb3ZiXqo*<5l5AD69W3Ca;4b9KJkbHGhdD
GpC\43ATe$c.D@o5[+mu!&`T+`e*9d$%Un:)>@`jkn9qn&\<9iEu+KU?16UA1^R+BYG[j'5(
,kYSVlrfFF;4(W'&lrN<REgC6j&X]AAGji@X!el/==(@2RY'[oLN&XIPG.an$]A1J(;BE>d`&h
Jm;*i^6jH4B6`Q$^b!]A>3OC$!2SX+3.)t9;"EGqi)?S>QOkT+%PZEZYh)C\=+P,4X\@l3>)Y
FVf>o<lM03)t>&aRH'!Sgr6PkmP]AcHS3J_nnqRPU3$6@H+q6e7fTN8#/&$)RHp!b+H@di>^3
)&7dNaDQ<nHAMuN9X$8cUne>4mp(%I;sjZV[iS9)sPDuL8V"\Xg0[!Fp7Ke<Q/<:mJGZWI:'
_"RdXPIA2aog6?I4S$dKnBZ,D#<;4VYDrJD'5Zj\;W;0L]A&I)P!bC_idJ]A^1ET_`I-7lW8*,
q>YHP-tnF1M(*AW75X\9O]A:@p:D@4loh.I9Aop1)R,f2jq,1=-&AHl-!8$S"qQk-6qZ]A&^O5
fn7'(Qim4qX\3j+blRV?SgC/qm]A:VuE^E+a^@'o@DbO`GP)tgHo),W7<-ltT4+A>\EJFuO"[
cS1K_]A:G(B?RF?I]AoV[M'FiJ<:]AskJ8_^Yj:i:K@HGJ=A4gOtmP"(FH=aX23Qtk]Ab\*HQ]AZ+
[l7`Dbo7s`T&[tnaXE(,>0'ElZ,Qa*B(Q$$2tr)^u\a.<r?R3qQ_bN%XUR>kRJbpgijok5u7
\^J/gpr8b'j`3)n4c2rkrpC$GFZF[fN)l"L41TU>bS-n$]A#]Al=([='=]A/-du?NMP&0WSXj@$
O$Qr17mkSA@Qh[fH>Fej6Ch/HD]AgJ'VZb%5AZYKM^F)#4^oPkm.1*TM8XU@hnJe:q\Tf7%7;
Penh3#Eh9J0:Rj1`:e+`Yr,l_<;.@5`Bd'@Mk]A/fQ4shfJ^01X,6;N>:oO6no,<g0_p2"fcF
O,nWk/J:"9^ULKf;do/SSbk2OK>4Cpu>mp"3R^!%m]Ak*40J=t)(R]ACoQTI:M+R=_%l*M5OXu
="l8a#O'-AFgB"l)Y4.L;1"=C>J[c[#T,>@'=+jFu^JJ=hbNpd5rT[,.NWdER:o<Y'7^i`^D
[n)XG!Y$k%JN3q3k&)eaB6pNkhd>Uq[n"Cd6mJgP<q1YA0?WAIMrki$@OX'_3S(8!4_.h?Q`
pe;hIiL!icBQMWCjo<JHqhUocB7F'><pWqC.A4VTbb"%1F('nhAiJ>,cM*RdY"VL<?fgR;VI
OatDCD+mNas#b#P'os^W=&g$,D(/S29AB=%gU[5J@K(;[c#f\khoZ*XJ-"Qer2XL@.rI%06#
dJkCUm8UFD8#G['M3+P5:h_IUg=3D^$$K2]APU,\7O4R]A!WN7RVlRJOV,ickCIRMZOQY?6?JP
30C/C,Frr@1ba5C\&fL#SPTahH.%[_"MR$jJ-*OdCa)8rAsV7d<O0;!3k*@,TaX\V/t4YAtj
kAKLc0C^6MF[h5A_<MW@N'C9bq]AV1*BM4BL8'c<3g(%S)G/YrP!10f8CG.nf^DU8')/i!$4]A
<,\Dk8tkG2ubDC-o9k?\EMV;$R"TD'@k>JcmY[:./ScM_T0n*LnE'UpM8JM@<3!CZ`>G=7mN
))NK5:$*;Ma]Aj58]A:TVo"OKfjO$@4$b_J2\QWS]A;s!WDLO#0f0%+:F&6q7ui7K$dW6)Pb*"V
#Ir.Thr=`,H^6Lorbq.eYjHR5*fhDC2f^dT.04J$drB2Kb@Fj^c#(D3E+_,8^:CjAC#/]AIOe
S`<t/,1idJ1b.d89nhe"P:F]A<F]A.G\t4Q8J@*aq1*eSp"EhE!Ek9*i9sf5-JWtZ.f6l1k1]AL
NL@Nn0<6=/rdDM&;7p5dn:/lls.=E7rGNQK&G&Rn^5l<U\\P(LMR+OK2fm#5a"57,&Q.8D0s
30<q*QX)R`#49F_KOg36DX5V(LH0jj#4ol]Al*Q@_IGu]A?>&M?C5`Wnb"6=C4+l%HA.u@HFJ1
Y8,O6hUjco/6MM#\&9V4o=7`8`\liEVF*R9%B-<%QUYGBlUlEfp?h2b$fKT^tElWnGi-aIW'
ERNNHM9`fR^%-(6jgPT(sY=t@RbqhS.m'5r0_Jd&iJ9p>K7Ce[lNgHPd)U)C@&Deg9ii`OH>
Z9Cn1VT3N8bq>Gba_%OEMi"5;>GX]AV7L'5"?:VF]A]Air"Tnn?:E_>b:KXK;lGrijFBtsaZCET
)0Y1+`5k:^G:pE[_mr+'kC]AFGd&(QO7"_OA8F]A!Can3d0qRe]A\LZl#VJVP?>a51f1]Ao<#7!U
6uE6.((&]AJ9Gt4pWSAY."Ss#m2?od7]AOVq,@<6Q.:9@!j*r7B.@sZ8fb]A2,cseKlkV6X&0ES
nWM'Y"6mnuRa:Kcb,_2HGOA_HnW)ENZLP00Z04@`*RFbj7P3(D@[kb]A@OKWr+>ZU^PeD<RV`
[QeL:$?bm$GTYqg7M6i_F[,<@jOU`R$2si[l_>L`a4:oZt^W"/d%.WBD,!K@SDNN8W$EBp0B
V@L@8.?eab"8:Q_h>3Fdk"gM:NTMEEE5V5;o+(Y5QOT["]APC4nu*OQ-;J7;V>r+0D(5f!Y)a
i#&-JGj+rq%'1AcX3I+/L(mLsqq"m#NeQ>VnD4)XP&2f`&cAC6302]AO;O1J;(abPcZ%pBj7d
(K93g/mfqSEUW/ZU$kOW6:$*N"Zf>:K,J:]A\'Qm%sN<Bh$P^kg"(p,'51I'Ju..rd8NHcbm+
ALq<=bTK<!G,62+.[t^%,Z3`$Hc.q7*fGlYG2@4B(,Ok2m%f7p6+?.6q?MtQ)\"e-:kqT5F9
+T^Hrc,$`mX_^U*1;<kGT3KfgSO_Yi-H"@C6+s8j_.]A/rHbpn[(t*pqj6A!0WTD5$T\*qs4+
RB[(VcGF62^,]A$FRc%Q2#"$[hX9dji),KCr,##+/-Gl_J%%#7L.8hU^hl@h;[c+P9c44^%+,
pQF??9u,NnQ_0+82SrfVI<D-H@9q*XGOXTjCc[sA-83`6iiaPLC,\LA]AI>3eFnS,oKO5**f#
<"55;fduL!9PPL!"XQ7C(T`Z$!3r&9<AAYoW?:)"<7ZJB+B>5YI\eC;SQbjT"ZHHgnpu:A?Q
**#16ene(shfm,dh(&)"+-CQljCBuaFqpau6nnnBXS[l'glp(JnH\$+_GP7`=kcQ7F2<B"BN
V(J5Q0R4Sr8.J~
]]></IM>
</FineImage>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="9" cs="2" rs="3" s="5">
<O t="DSColumn">
<Attributes dsName="上月在职人数" columnName="在职人数"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="9" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="9" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="10" rs="2" s="1">
<O>
<![CDATA[同比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="10" rs="2" s="2">
<O>
<![CDATA[-]]></O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="10" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="10" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="11" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="11" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="12" cs="2" s="6">
<O>
<![CDATA[全司在职人数]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="12" rs="2" s="1">
<O>
<![CDATA[昨日]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="12" rs="2" s="2">
<O>
<![CDATA[-]]></O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="0" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="9" r="12" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="12" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="13" s="0">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="false" bottomLeft="true" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="13" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="13" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="13" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="13" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="13" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="13" s="0">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="10" r="13" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="14" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="14" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="14" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="14" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="14" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="14" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="14" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="14" s="3">
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
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="96" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="160" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[]AY"PMdchQ,5#YBT=ZTK\Q)<#^9"C1PAr8L4RAa7jRX:ktAnm48,1Ep2(8?HiN[\/BV3m&HAu
15$m\Yf))m8+R-j]AgWBn!C"2<Y"Rn*(feGRiWoId_?Ecb7['4SMUC1>]ANiqtb6Fq.?DDalAJ
$^0(R5k*so`hlddnjl1.1Z#@?jR5$`$o@^pTnT)*hJMoek,5Xg55/ek#q7NHM+S*=ZRn%Bu`
8868Xo9L&_PX`0hjo/bnE->=l[/Og"kG'ghtDKb\&SQg!]A24J/K/K)3aOd1hdCUnmG@P]A0I4
qBE7W@OSM'oCmbC`><#m&qb26:C]AmAIp)7=f?e+]Aig51uD`]A>/ML8D_aT;q//&lcm.,o37XZ
>YNX)*0JsZ+*m4Oi18,-gnDK3*4*R`oJt2AQe4sLU=3M7<a\d4RE\4`cTt=d$F9-n]AM`:V-F
A:$Cc1'<I-o#bF#BMAWr@`'LF$a3Q^6KWcOAh-S-F2@V/DpLrq<N;aoK'P7k["]A+QHG_]ArYN
DSaMd%f:4foV(lmU>-n>mIXuA6lc2k1f<=(L\fmI#>b)3ICi?s@9n$lNoeNII?Q4tSW[+[rF
+<`3%kpFu_u6^t0mU!ZR`+o8nn;p+0`T25R5n.p\o?[o7)p</%5,6]AbNfPW:s_G7Zk8qunIO
"pZRa?'8^F!AZ^e/=6DL%dC9=]A+pkcqrJ=aH:<jZ:Q/9'i&R\L\E^#F2L(M;#KQ\(iT;3LU\
F$D`:MQ]AuC@5Si92q-6"5^0oM?W,+h"P=iiA#sW'VK7:V[bG:IahR!AdpmFr"X.'-(ZcFKS7
UF$/k<^qE+=+gD2]A,K/AW>3O7)*5)i5H%9?u(Mfk8G0>b;5Cq`EI3pRU5qAP]A+hpdt!!A;,I
0R_H"R?_!ZGjA+\P19nr.8uJV7Y/]A9mo[qVN*K&[$>n;<-R)(.;Wo/\KHC^3V"Gpe=msSU3$
"o3`A:i4T5W@l$DiZCNLl<9Q#e(,RBB+@%cHVVE^(R<;Z]AS"+IVF-0@Y0TadbStRm\lkq%!:
5+J%Fj[fUqa\^e(7jF]A;,h)gKRP<1a?JE6Tel<em=#&:#HJ-n2<^m.92h`lN/%Ehm1A\acct
ODPhck%J%.45]AOUk(q(<\u8,4'qaYYG*chUSp="t!MA.t'SIo^q\F31R2OcD_=bh)"a2_*eO
Y3>gXi$u7pgs!"$EMKK"q5/IjtA'^1/6?%l.tMAPeFg@FZ3<>Ce)PPD]AQBh,`?[3Y&+O%7,/
`]A#r+!4.D1gBg%>k&[5s$%M-A[ha.Zt""p>@bok7:g*AH5XZpLt-o-4";g6TB/s3*-+]A!\im
+rYR;1iq=X_uEL/D&I*fDdr?=]Aes3V27ta8]A48Mh;#)#1_D;C$H_mQV"Jk1%aoqVm3>EB^_5
Bt8,?IM8AV2gYOpP"X!+/EMjCZ4`B"cQL'"pIE<>=&X[U!CSh-8g;b4JBZ3%8PNX`g7R10n"
EZS0>QP4([4Jn9paj"!_dFWSI\6tIqg-,tn!9n7.(C`K2S\C#$+DX?Oap+!%/7fC_T%(-VSK
5,s8"pk=F"t)c>%oBsegUR@Qk7=H+`HF+3b;]A!(>3PrN-FNplXg"Pn^B%]AClWm?<!g=P<WY4
'I@J3<mWnf7$rn9ar,&bs2-R'11P4;uAnioBVMRL2%\*Xi[:4C3]AfT&.0!\9LS`]AqX+aI%.#
>OAC$aQg&`W#%!WDPY/q16Cp\8:94qu/!hIrp%rJ[Yt%<9Y7eXS7%`lj/16mNa-7oYc/Kku1
o6*TH[:FaD/5%oF$UrP&u!RP"\Z@)Al[j:@"&n%AIn:MmRBYcR&<b?l&$_@t6t_KmEOVN+R/
mo=XL2boaA-`]Al#eu$_m#q9Yt]A?^:VqNZ7$V_&ZiiY6=[reE$2dq1k7<=uTjdEA7f&,q;9>j
Y[U5IrD&<D9.]Al@6OM`iZ8ke3:"5h9-E"S;o@4ig7Tafd3?m(Y.@Qm<S6rT_KJ[m,HM&6Eth
9pEJ^)4!t%ed=%o@S)l*i(?\JLUC=@hY;`H?fm;9^kU('eG6?8;;,!s<\fC[pK061nr[ZuGO
d=MoIkQ9DLt>r$n,B`$g\1^MfNi\k,=@tcCsU._9f97hPbggG_,0%N?s1I>=/]A07>8L$h>'5
l%%Zq972HCK,+PB'f\KS0F+"R9L2>,`Xf4s;N.#/I^Dk#PL-FA7VZg^&<Q;bqV#ZCYf'p@VR
XOVZV>A<udSI$_Prnn2`,!FbWa`qaA$CU-9U[/dmOiO%N7BKk-DYkfi@`M8*s'Dr@nNQlq@<
8X)\FY:m-Ule^++C7!&1c"l<auhl.N;t^4*&j6@/7gp+.gBU4s\K,P5+\1CDN.-Sgq35SY35
@8&(`ScYAjc[c)7UpEi$[b5ZNCHAe'@alj/m`D)EUY&Z_%ofgdsDdG.m5?%m7c27B6K=*1Po
ZR8?[,kOE:4IWfk?n8":+P1tjK=B:)<:meq,@+T5)+ber8`d1h=tmJ5?*_Q8pP_u%t9QfJ,E
4rOhkqkF8;G?A-B7g\t=uuL$q5BaAu)1b\F<,LDeXlk9ePe4RSbEf%n=B^\ngsKE?#[s8"UU
+g,Ps\O]A^SdbL2aSo"do<jABKq@,kcBfAFG:k_o!(^1<LVEDVij7Lf;NT\W:<,KFi/I5UUFo
2d&G)rEeUJW?#rJl<S`9K(U&J7k3T)M(i//k7fc2+BOB";0,a6gIu1=hd+`S[3"XU:_"Pq$O
#E'$6OSQA&Sr!u$&0`pljGl$m`1l"K9iO]Ab$jR)=\/A[pglGf-kOIAY6RBa]A/M27nX:D5AgD
u[]AOC@`?N$FAVn;HGW+bIdoC;VbhSHgukV2dl[@<&=rL/TG.Ch!<L^itG^n;p[m'@TCI!>t]A
c=4H65KPlSXqa/)Yb]A4-tk?,+FkYP*oq`gC6BkZo#tQu@b(\b<AbdUG4ci4!P6s6HFh+lFNC
]A+ico0`))QKXuL%Cde#PLBu%Xf/c-$XgMTd_6<BJC-!8%)/);41<(72P8lPTaYlYb<<,G>W?
H$0^dm=ts('S[^)tUV6"]Acd0K68bQL#9JlcRQt&)2q$it9!gJqM)L-A:6_^!]A%r*nK]An4+@Y
8=#Nk!L\Ph.;3)ZS[821bo6@!=7/CU?$))5LE0&IF;-K=@T6CNV"u^I*0`DpFC\M$K\:!'^S
Y39F*YMn=CJh3E^8U2>j.:[R2X<(LYWFIWr\pdG.A_UEIb>0Ki4do[=.\jCj8`**-p[gQCk5
'PkFMl.f"T;+.r<2&7jS*3d.&j_/OVrCB('XgYg<@.X"7t?f5fMFgA/n1a-8o*'^Uj"LkJ*o
UHlA"GSf?CZZtgpI(K0'6"Jf\GaBpr1YSg+iq]A>eUPp9oI+,6J+^W8>GideACb8no+cf?Q'Y
k3<kL_na!c<e55js4tQ8gmo1r?C2T[!*2\GR:Rb1S.[*-db-LWoXP\FqktYn0l=S-]Ab"MfIb
=4k`38@MYh55gMKf6pRl+9dq]AZD5"HU]A6%_n6I<!g;.fU*Q"%bjdLn[1Mmg*)%%F\[NSQ0Ll
OWZ,L65j:m;O/jC0hnSELLX31BR_r7aG"t!B4K=Tc\eo9XeD-pV8E]AWUYHCPJ8L$gp+X#[Mq
]ATUa735d^64'G6V6hiS-ad1RK)Xksl!aF_/eA]Ap.:_87g=R3G'r'p-QRBFl^`C?_nReKIFn=
+Qp47b28]A:2PVq>j]A#g6^@s>+rSl.Yld$3QRdr_l6+No1f`kj,\DS(J9kgH>4G-GmY;VKX]A?
JV3Yg.o4T]AM'X4cVJMIIjo`0,C*SmG]AM'&hEP"p;7;S)k_q1+j5/'qBE(mT\d@rjfkcDE',2
?#R$O9l</`!eN&?e\X>Xh3e)e,#sf(hER#GD&.f<THH'5,V<l3dU=Z$l4>RE2"rIb,C%3#86
\=OThcZA#;GBQ8N+l^El$$Xk[K:\/!`B5:,(SN6F#Y4P.@r*`X:?.LZp^pT8):e"Kbs8odHI
SRhPHX.R#lm5lC8l\HiEHD:Z@/a<bPGqg?"_g0!6NCSR%E:gWTe1:s!jjS(B>'Q_&AuW;p,R
WS2:YQHW_$W=`@lq)%D=9+g=_h3ku$^]AFOZ#1c<fBq3F"/nuQ7SV+\B[3!Ri<B6aEGZ@3,dO
:od;%:VO*hRf?KbCacC?!/RGd.Z_DtaI>I\Y1Z(-cd&+G%F<9r1/`)A+?JU`EkZ?!SOm^5B,
cVtEgDS+p*QXQB0egXq&:bo[dn1Gl\]A#5qr@k?5>-$s\e&Wh<KEns,Vjf9&K\dm)CWBaA]AL'
[JZiX&%#`]Ab@rH'.2(8U/C?'BuYtBK`7H.GSg.I>P`g&j%Ia"A?BKpfQl602.I<_#^&/`%Kh
;\&R5\T(':QGXArRkQ2M+T^,+$%)t.5K$E!3=QNT%`-2$FScbA8;4s)i;-*0R(MMbc`R5e/T
En/^3n`iXr.W$hh5,/1@DT%,]AG?^uTnKC^>#l'YIB<:6*W0F5!/":5]ABc\@7BJr^[B$N@fEF
R$]A@6ApY3EKR*LONpJ\%2f7cFCNdU&O.bFXN#*'FetVq/6-]A;&1W*G9\[f"04]A%642Snb]A!&
D4UDOc?%<R@3ST.*o-'QQocj.Wc0(3AmJPo*T;k"<"MiEhW.p%]Ai=JKCUWd*;hVWuNC-@h!7
@oBo8F)>fV'u^tUN^gOOHih55<+d>Nf/=I7s;CM1nen9O.>S33oa`OQpO:<?d,^i(8=gSa2_
[#R4QCEhc276P.u%qnuJ^DV'(6BJR"FY3p[,j8CgQCj,oXHqc!VD]A#W`/;W@=A5/Fm3.5_IR
8qRO2$]AiE*%<r[%F1WM*48Zg#M[(\u#t:UuA[55-8RH4>!TdpgHcfd/T5([+U?kA2Dk6t;@9
;XciE[#iF@O;d=-eC6996<d)be'9fm-iR)QZrQnb5rKro/]AT/e[clm_i^T"VS!k$\JqCOr($
W:3n-$l8CS"PYr?u8e0Jr!@M7[@^35m_1nFik"oP(Mg(ST^PgukraDZP:bqIY><rJNcX&Z";
C421fJ-!&L=g3*5V0mW=E-an/@_/BXK,S4>!+LqX%kW<`H]AYYi%27Tn)7;)-L8f0jA#5k=?D
PppJC@Ea!JgajSkiMo:QN!b-jB[ITG#pCf9DGaF[4rDZ^g^F^CnT(i-HDDd3@5>l)1B:pUY`
?W`=HPOV4+(!)e&9,b6Npl"lONJkW1dgr#NX80s"NT`*Gkt9#DKAohW.RVaJcQtNtRTeE<Ri
R(b-g7MkL>+jZG$9<RJmR@Sk&"7%GdM?@HmGB/LYL5iRq%e"2lIsP+8?mNERlG7PS,7#m6u8
'KtkX>!"'^'6erlN'BdilEn"R:O-g.saA]Aq.@7-.&e41/=mM"F&In]AR8]Aqq@eZ<3qU/LHE-9
c7o1!AO`0_q'i6`j8Z#:0K46,8`lXK//Srh%g.3W_$f3dM?jU2+[s\nH6O6mrsU4@3<UK?^,
gOW,l*B),R(_7D<BpP*A8.JA3YQ)=XS7*Za^dcE:Pd=*7MKc2b%O"&"@Cpcl6Oj-c&9?qOX9
<ZF`9k2I&17eoM^$QMk1QGa;=d-`Uc*'-CK"Yc-7oqutI;%8h-;c?$8jcYZ1<-!bWRUX60Ea
;kH@n9=k>>0enYlq``qkh94IUq^Z#>/^e><%)IlK;#6^L8kNbQ-n7;ct!b)ImZXJ0,'0*<MO
]A3s/hADZ#g,,#56,eFai27Lc<SCHAF#kA.0pEQ,u(]AJJLKDgkBRGp2o(R<f;qXidT;#:uhq$
(\i^YFcKl#mY>u8T?0shA?%pn&"\iG/O(u9p$b'^Q$-:Tf@Wp(:']A+0<#)lq8MkseA:!@6jp
9\0Rhr-oq2'Z?TEJDp#>_h^u[bpPi,D$/$d/[0]AJXt@B`_7R<LbLg#%GiTSrf6pIN_?Z-YR2
>*&Fu]A`GLIInbN/1IT-ok^@[BQ,5k5Ei.#6A;4n6^'8C?"Q^]A5[klsq)EW6;k2dp7S/PY0Ye
@-8Cf(d*(&=8>g6;SOTkE575aG#ENXmi;4p:Q''m%^?6hM6"Ag#U&pNKMq'+!=if2Vo@18f8
^`,t'VCG2\7kQ\8<AQ;_r;@`1#YI"Qm*hHPBT9R2q-t`oeNj-^H&@j*^g<Gp!j]A`<)K9au51
8*LN-X%W1F/`*Wb.8I-nCKSY%eq9Ql\T2MQl1Y-]AFH$lBatf-LfkOL6?$GTeLuhj:tP"o#cQ
p):0D_1"R=o/QN:pKJ4l1YE/;j)C,1*&^"M(%%e":$&,NK-/t*F;Wt(0&,S4:L=3jG)Q-bMq
Z"(GK]Au'PELUCi\Ce?fZfWpqQ+r'Zgj=@=C+<#eUJ[_"nm3%KTn]A`Z3X"/g3b<,g+PjQNJ39
%hiY>>tT9d(5(jkTS]A3.d=tj"CmV,GQRGp!/RMo^k6;L;L'*4"Ks"*;mG>6EE)Da,6&0KQR&
*WlI:'@6Go5qB@HN:%<`dhiAlLC@]AfH/kp3$4W.g-.lUM*!(#N(h:,d7`AFTnn/i\Cc)]A$RW
WWB<2#d[]As"5cSOO925-c$Lq(dIb6Uo>F*6GpOM15?$rA$DFPNtn>5#-J\$jm?Kr;O@KOks*
QYaXp1Y=`X#nNF6u`;Gf;5!p5r>Abm^S&qg#>\CXB;G:H?enECMAR0G:ir`WkI]AdDjp99T:p
QQYZ.mhp)3gC[%BmJS^uHN&Fh7#u7`q3'WpXC0.c4Ut?#N[(p@(s`WQYGDuuM>/\Ko$+d>8+
.226$tLQ#EY7f\'8mu=A/DUdPsPk&Nc6AP>Zd57CVmh2TA"\;DMNN6hFZQCpSek.H/Qn(5C9
hdZ!:?'MF/nFOSkJp3Ho.K=BIIM*6!7l:!i_#o]A83h<21uhCB/Gb`mBX@iuQl[0:0,Gu>S6!
eZXF42f(/.$.BhoN2lJ2iTX_<bK%_h(aMMb`rL:K!o,4YSa`K>WbGB1[f!Ei]A>i1hWPnZ4W3
IZaRc#Q?\_<(^<1uE]A%U>t^@uasMfuUZ`e.n+95I@+>!2479jr?-[-UVp5Dfi>?4_kI(DiG!
A`laGP*B52HMhIa%2`'b-;:A=ok`YP5p&#-P)segk)cW!f6GqlctPNlNY'UN#eo:WOeVqqEZ
K15l(\gbX.462Z+#J^B>kM@^Fbf]A!C'stm<Wd&E?G4ClH3eP5!ajQ]A$-B>A)$.Rb+7sfn5-8
$mabK<nUY>:ft2qLQB]A;4&OW5:CLMERA\ttcQJcGaQ$lWLZDIDLJ_H1M`U@^-eE*XT@4mj`i
:i1i/ObH>VIbI_J(#KL:fGar5r9FGBsUe5;r8A+/bJ^B1Y<dJZ+nQ>.=f]AE##O0fU;3#,R**
Xt-.t7KJag>0.mr]A"T^l&2]AM%$oE!M-=k\X%k"Lab?k9KkUk_OZ<<]AEj9aL]Ah3I/S"SU`fIg
Q\EeaeFWs+Xk*62D*6UG)<T)uS%$aRl8=p1P.TN@g-%_rO$gI(!La-s3W-,F!q\#qG$^aXjS
sq>G,dmfM!nR#gUd/A-D;-*?"eAG<*WU/P]AgsfEu<2o'^mL]ASZ9QRfd*OPLE?2dG@K,NmRUg
:!VB`[-mebROU@]AUZC#a$;7=,=\j-C/jpAZM!<#Si:WY7CmV+L-lWLmha<4Y+dBfMj=k>/ra
N5Y:ct6UAkOBY]Aa'B+T>b`lZ5B13UQd2^8FF@BYcfp.iP66,D0\:(1hHSO%=rP_0#`2up"h1
#AEeneNeq.R;8=3dY`[HmQ_Wj?;)4IL2oHs&cUu37NqUom&mtk#I%[Gtb!g*AJ"Fido'%el\
@,3j\`0>lB,-5Do[p\Xjh?taFj`4dIc^/!6`kg9tRaDl9;n\k\jnaH"/VnU(.ao@X=leibA>
l-hbB;%^S8^cj=NYhYiL:&]A_[B/9R<;DO2)X>ZSK>Rn8mWr]A-3e0KAX"3$M_:[-eAhE=k.7Y
C;?Z#K\6\KSHq&fZn4\H:#hQeZOV+@gJ]A"o^$>-8)BGB#'q@js<id><MfukUI@0F?F?l\=a;
sq^3WuM_qRYH@#\;]A4<fd2goG'%%#dGJ'%rju,MAj'5W]A@b2Qo8PfT,:O?/<E`i;DB>ZU4r[
:0Qeq;tiNe@<WQ0+.fNkZ*rATJ#NDm??P8633]A2Ak2Oo;R@$U$dL8AHBl3fNZ^38tni#u_%a
$ch^O![>do^+?1u!p(!Lk+5bth"Zi*U_dald/\V\-Y*Qr?oQ15TELn8^<u;O9>IZ3H3FZi"p
bS`:Oa=j32O6s_*l:hQbIG<8g/6>3X\]AO...IMZQqIerd$c(Y0MVt5Irg[\,+4biBC]Ahpd%I
OgGl8iiRTTc1bWB1VF@GC^BVlpOl6io;!#s1;@s(Y=^ko_"ZmM`9a]AarrZJSqItM&>(e=_E2
(CKmY1Q$W3Y*Ki:f!U8ouP8g5=Ebb^??RnjR^*dPlmOM0I_n^h;iG)"+$h"LZninM]Ae\1Ff%
s*.b@3j_*pB3O.8'9RrE$2mJYbP&5S%_3ed2(eBm;u8e0ZbRa]A@q&SBKe@HKpT&4HdL66:d:
K3VT+)Tjr]Ap(c>-LNlUk%_i_PRe<Opm1/0>HhaGmhE-N7_6+&#c@!8\6]ABuuf@n5nU=edL"l
-Of.RMJ]A@69T*B@L,VWr&XkZel[QA,=*+2Z8*KVPmcRWeSI]A/cpFs1!i^&]AXPNLZ&6r/S;#4
3+?nCV0IZNj8pB^PQ)7?-!7U6-_@c#dPBa9nWf-T-g_[$c2:)+O\\:e?95lk5pq=@-5gToY=
Wpj1<F$MDR5Fe3LRE`FO5Y!b0W5rKp>C97r*Ci2+]A4>C8@dBB=1ZIK%M8%.c+e<0]A<6[P/`.
Gh*htI2H6QXZL>ibc;GK2I:Fg=kgq4E^l@Z&FpcWj<W`EH_$.F;(S#gB4NG#8@:!B2Rb1$?m
9ld)jZJo`1eZ9c__j_NRbmjAY#/*#U&TkbpXq%A3lhIqp,jp1.E^!t-[]AJs'd+hiFo'&]ARj9
TO1QmFg<SSOtf#c@[0q8H%UkYoK;Gt)N)5R8<KRTE8<(0TqkEEn1!W@TWs@'".g!#F]AF/QcN
fbj3M3of)Kq83I6$oX\+>NKmd63.BgeqfV=#KL0CH]A]A6FCqd[DoHf-fXJR_[=N1TJ#]A+KI63
.o1Ab7r4@id)J,=ONG1;nZrdh"(qD`[UNpodAY5'[mOWS*/)!gn`^W^*^CgFu\k%cD7E1l5j
T#AZUA1C!W[Z#,YW1C^>g\K;0W8*^N566(tW6N(=8c_e0dW7g*!eL)tDFfJC6[]AX$@3)JVUM
"MGFq_"LBni]A4$)LHMKm?'0KTO0Q[q'HqY:aJ@/G<!F%H?EQJZIh(&LZj9KaO=p(C*9Bg*`S
s^;<"kqM@4V1WJaBSL4:eT>3q5IPP>g+#K-s]ASH7?Ja=$I-I15TVYFN\LYaW8*=m4f8l^h,<
VeMIAMpuCdV,-[n-UOQVbF7h[,9shBF5GIH7%9YT^ac-RfRaL>u+gYh%TCf<__T#$PENR\*6
rbTK%GX2!*/Bts't@H@,,X@nHj,/CDmFT!O3'<73W[FLciseie9`_R@A#,C-h6"khO;d;AoS
-L"2Z/Aru(TB.U.B$2S%ECLcn_8@Pb5CiLUdW`_9[8FGoS!TngoKC%rLogX9><hN:mi;NKZ.
PnT2%oKi#qj`7"\8JL$q2uh5RVT&2FP8-_D%2(8/clI;d3]AK?hKl(i(-9`1pf+s6-2-6JkX8
Q8PDI89..*4+kKG>1\gt>uUI5Tep;)&BIJ[5]Ad=s"K5Ri#IOHbP3j<)7%16,<CMDu8>\\]A3S
5`]A284FM"?-g/WpVAj<p2:9F8iZl4b39mP1sI!Y&I@')0i]ABs@q62(Gfn%-LmZNaWR%qhpcS
Q]ACn"*s>jLVkAU[[L-Kl"CeTJHAWT4"PC(C98W@`dmR3Q[<P'U*V;cWalr`Wr*p'f@GsJFp7
$)rY(g'l_TMf1',E5MaN$;<>n.X@,fSR']AEkJb(D>(Dm=p:[_$p_Np'kAfRWH4@QdRd!SlUV
R\@X_+icD"2)d`n4oG55@cGc/l7)_"kB@mJg@-`2N12tC^eb+b?aEK?i\Ok9;.\*@:B^(c;h
XKD)Y]A2/[i8qnGh&T1KBG-CWm7?YT@:hQg<5e5TD+cT@R[gSgcJqT6p.isN3\t;D=)"74%(b
sBq]A@C;aNdAKpk"8,''k+NM=Xqk!$(&Yr0)83>L!%&8#8O!fZpsGfhu,)>_!k<-0nQb-u\5:
E6CPq9QsN:S"t)JR/"nB;'a+KF=?EI<BcB&>tS3V9@Cd8aWFPW>H&\Z^gWhe'SdlBXpU;ctC
j!h'Xt2^T%6$&#W@OPofNT\e;S.(I3_=.V;?0C@XeB?Fs<JHWd:bTdktW_@Wd[\R6?S=,9?A
b5eHC@@#+qorJ%goV``Sc^q0HK9r:J\W^I"S4[aU?D/MoV`sft5M[L_\Dt_^6d+EN?.el]AQ]A
?kOpl08W=]AX=Ye6o_#,8sRrNo",NVieS;7+bVEN.J#[WV7e?q;`9[jb#,u-7XOp4l5Z:I9!V
R@_^6iN<)N6jg3<*B#Wd%L"Y-[onC@F,'%Gf;?pZDIo8NbVn'#"=ECPIGo54mY7L0;2+V1;F
s>"s:E<Kq%E)/R#KVUHLkf<LBb(;O%G6#DL+/r7'5kWt.)Fe-1rb1TBb0G7Vj_I!5rD]AbB2\
_Pf^S?^?."[D2($FB+U)eT;ij<Ufa-.R:nX.*MTV8!.1tiU*F<e\DDZY,\bN@.rSBER'C[0H
DOQbs<&je$dkSKO\`B9dg\@b,.LX`>fM;b6%8,6`FaLM-K&=\qDR&TFhp,O1-Fcn3cXe2=!*
^Ue/l_*eLEofj2LRs:?)EB05!A`>B9)(;SFP3nC@]Ab%1\4QJ#$\dr?Uk5Oi@t3a:0)CT>p4W
_<fGnB)=a'i`8lVe=nW.]ASB*ADFPmRAS9Ho$Gb%$D+g3dJ-\32:gR^1HC^BDu"rK'iMcXcJ(
4c)G.0$Pp:^0/21#k=peG0Z^J@c8O0&6B8-M;fm;3g=>)u\8o%&uafn$D\`Jrh^Yj98&-!#'
5k&qQQa)ArBSc=btA+Se\`7B;[^A*B7k'&6X_LrIch0n#?AQ8QXMSldQk_)jX8IhnB9Sr)=`
:ll[T<E1B2Sd?]AHf4:Q?))/hbiDO%=r5khnS5#iGHd#hnPm5*^@T&?Qd[l%\[ftogI"==AL0
CccTijs+n_AFFl)Kl;=3iF9ScS^)'K%%DC6,S!gU`Yf5b0'J46cUKV22.DhX%nOdaAn?h(_J
tr5.4Z&;+,'E?lJE2#;kJCmiLTgfUmF,#tm^p?HSJBX[*oU@#RUg4qYt)UPr8mkPl;ZI.H"O
F@Xl>_t+0ENuU%J'P:*]A#;u@Ied7BIXO4XIpDo)[9:U2"8UFD@:Dllh.\05bFEocN]A($JV.\
tAcopKcGX9Z_`QRK\IR%%W)PZ2,1nG&OX=")N'-E8a2<u,ES2U/dC#3WDbRIF/C;:#F"#)ld
RtHnsjVFJ#L!^/4>c/n)fm]AA+Ktr8H\2H<Lp$2*X+9e7HbY5edX.$6UM[%Au'q5j5V$^-fVi
=TCqW1'lo@%/j6eq2FV4fA!KcZNKAk5Psg!5n'[q!sEh)A?6-T?g@?XY).m:.D*J@$.tJZXh
$'`[;TT:$f]A-3pD)irak.XUVKUV0oIb[od!>X&(:tJ5u]At6!H.=%Qf_&esAVoc9%h)H=#:QN
_O@-=5dl=lmoX.aU@Qq$]A@<GqYtSPZVne=)tCEGYM"Js2X34u8e,OpKV]A)rSH@^GV=[:,hCA
_b;M+EZ8VJV&?s6<%;<WU]AE#$SXT!S^U-;NH-&pt:8`9N$p+XOd`]AHJ[D/Q_K4m63[rEmP0;
l6ZA\^5Z@q1h3?PIf"9AKAFP@A58.6U+9'U5n8\"j$<N4QD[8J25$X69sk7(j[Q0qd[r:%C'
%k-AIn*5$d!@%F>hrq0D20!)XT(>4iR>-)$[hdgo@o[;d4cKYH'lPN_Br'jGR/@24!)M^"]Aa
0Y\\U,#"DR\np<8sJgG$=@_Y^&U^J:(J8S58M$`b;j[,QArY2ls_E\*pE[BfWDb9Zg3(IVJ@
aX_sh%KK1#k8k!kB,G!D[j;Od)UK(KM'em473!n,iS-m`h+.u&OlMSM#?UkClsV.iZmc)1oY
&4h%`RQ\KQ/BG!tMZ:&?Sp!Ye<^'ha.C-ng20Z4jYP%shTjR0U8DTHN*D.2fm]A.AhT@T`'oP
+#GH!VS,3ociB'rn!c,=5EW4H1Qp)5^&PY7mt%b*1F.]AA99iJ82Vg<(M:Yt7^p=PUaJ%3#H'
M.CkaUnLhgf:gaLWO[!>Bg+AX4]A=B!lIC[54t8DV.b4BrTq"ZW-NDLT/)_Eu"FiaZO&(m-H<
Pn!ub=miDpGR^AZ0:ml&#Y'i:B/%o!elqBf"U'bbD.<EtC?*E7Gk*5o4*H@`<`dVFMl$2Hd7
o,9pY)/dmamgs/rl3=%7(WQ<nbV+"dIC\bckDnX6r?Q2B$=<ql$Io<XVZC_THgrT>ItPPK0`
41dWmB,.:oJmZF9>RBQ$UnY(T&hX[gWbRSGik`pVfQh2[TGd9&o)%7f#WR`Bd1#OX)U]A^I_t
$B0LQ8k(@>(J*dm<ZX%r>s7O7DhLqb;n-b0G,P$YHsHQKXuD0lVP*g4S`0-B<X*O$k@<R`S#
,sJ;UCM@ZR@u[-,U]A#RO<mq_u8N)$t<NW/l<M5T4/_RegR9"^4>m"&UT7[XU]ATaLJ)U9`&3V
Z@Fh9--Q-u@*+*-+<Yp&/bVK>q.]A><o`Mr6rCM@Y]A>r3N[X<hcnqTsVFXI<T_jN>h'=j8iEZ
E/5fJPh4m:q_@GJ%d5]A'4d)V,<RFpU6EUXa$bX%>+"JXgi$u&cXir75)G^,N$?$1jUeoq!f6
162=N5!,?=d`,O"0+<(_2p'B2pZDe5eXL)b*s5K0@MS5$Je6Q5[hJ)Uh1^ClBSiD,&GpLP<-
,u<Bd/_Pp:>h'qAn$^r\FjY21C;6r[R+,Sj;DEQB4l3#Fl/3hpo^q3r`qgE]A8sR8ko63!.5m
eASm_T4c"SP<TSd=&%GJWhZrLk^h'b!/o6d6]AFSbC`kVMc64"cfCc9's1'lIfaAcF=aGN%!T
i/t,]A3C9#QEmGi>H7dht-3ttQ*5eQ(ho1[8a!5.pq_tB#[NXY%H%:kMF+3iV`4C(([o/H;r7
IO_Oi:Tm*r4!G/r\:)"GbeCC[^3noQ[&J'GhePr_\R!hC`a/Kh5-[:/?%Cq95<3AY_9/j9?!
mh(=%t\.+dt)7g>[jV:5S:)+2"17e\hCB^Yc'N\s4rMFXpJ'D(p[&_33JY^*d,*nGG0M&o`c
Z"X*1+F/tbV*8Ek#)iMi4E'/521>J]AFp4iWG=\3$cKqfuj32//a4F=%f!6NlF)l0/(=g:(B,
aftV%[ZY[V0?AQCrV7>EKBhV^U$I!J*#MlKO=&3lL2*$(e1]A)isP7\HSn$j7V;a5Z[iqT9l;
]A+GD.C$B'P=i_Uj=C]AcIgG-krN+[Wk(+CKHqqt.?.cS_92ma/N"iA(i[$fif?&jaTVe4#c<)
q-D/X:PqO-QK.Ukp<m4d,t_h04QWbciNmXTOa6(4'LSc]AM#HKpM0s/cW8I]A4U,InVV`&Tm),
<R6'CEHeb_0W.Y(P%$ut"Id0(+l@:J&J[otOg'SK1R2din`/75'0ob$m2,f^!\JMsA>V-a7H
fmF%R49M`uG.`H@/3KFu1.C=6j53cX5-7T=j^pdEbU<9YbD=BId2ZiJrJh!bP."bG;r\M/d&
9@D7dAa/e_.FEVo.hKJQNZYBlF;p_IBbkiWLMQf_EM94+:dK]AWWG`i\n7ON'2;\IrV^h*$bV
L436X4dAo6k(3F+=:u)nWZ#o.WQ+@031add*Jjh7FK98EikKac5#*L*u:.Th_&=b3?h97.V3
A*5;,&Rc?L8kF`$'3kUC4^`,#r$N&he%j1Zu5G5dr%-0Y;F@PAGKqC(+<<//YpO1IWfs6ct(
GEq9B4=3AhOboi/-O!-aC#W*FjDKkT\N[1[R]AG@VV3D*C+8=Xe[_ZC?[oi,6*q(qV]A]A9Jg`)
+$[&FDii*!*7[KsG;Jo@P(W&1&h+rRfmi<C"QLHm#T^HDF4/cK@UFQbW$@0OaV,$R5oQ&mn,
/]A(Aqup!rX$It("!-@2VX@4#rRMhDpr.0V)Sl6?5m)`5WqF2/ZR;O3!34;homZ'G[Lcjm;Q)
H5^0D8g?_`'eU!so#ZVM;HYl.U^Sbr)-hm0i"BAP1n!GSF=F8f0N&B<XL]AD!lL;fj`/fgT0'
h6CqPG>Ll"CN$1pdnb<PpW/GYjQl&&efH>^mqUm5Z=KO;L'SGWs)0gc^N,3pf(h;%9*F!^Tq
;!r<?uPgi%lkWZ7oYNfhJ/_a,_0]ADQ0%Klpp#L:\fEq[a,bp[_'k"*L3/I516([3/[>]AkaY7
([$"Ke9j40AnP6*^'i7M9A.XDq!e669drC>M_J.X>:9]A@l>_Q92T+/fMaLqKcaY77BkHBJkl
t5t9W<tq2ES`<HJL:ULt.i1i?(*CiuOYnHUEEj1#?M"_PF&P9eb.oW;n]AMj)p\h?V2W=c13,
^@;6;1`p]AW,1SS)tIEekT'd2(2>#@DUl0=0_E@?nq5BL2)+#%(IIK4]ARaas:cRZ/XZCa.lGp
\?$*315)Vehm-T&Q;"m,)-o=W%aWA1oeqc02mM\@gMG,PV/@`cW3',R8T>0D?]ABIH5c_rh*X
@F$?[BT/b5,IatIsTc-q&lhh*Jlo&B7.k4X&,S1h1,C_M/o*aQN^1'@qjCFuE$"jUM65CDnZ
is=F@@dQ"X/b[;]A/@I\/S13P'I,j)[(<q7`co>a1U?_K2'VA.IS9-H@p]APH"+qEU!-:mC;3k
"#,091Q3D7d/q[lTJ210sa0na!8FiN,)0nV>]A0i4K5<QNrTF+S'8p05;duHm[f]A0Hg[\.c2%
^8'PHdLjInHfHElsGNblHLrR6(XMC?XEhhig,;!d!-`9CBDdiD@8OZ?s?q"!hG0$F=]A">tgi
H((-^5Ns"Nc_\l&u'Vf9$e<NX*A)MiXqHH(@e=@SYb.BUG0+%<uB,3('=\-fGBJi'lebu!X-
V\RVu_/aYn_U4$&^0.%<%_Y)iI2U>br$A=`[\hW;00ZsK2i)H),a`XM*]A'4OWD;%&JoC#35Z
TZ#I&$qamC(.&Ark*>H]ATFIYVV._Z-Qi81ABG#HhA/m*WAW/5]ALM3pRf$jB]A!qdX;8>&D1b`
]Aku%k.T5T)HNVUF82/_h(&BY1XOR*0jicbrQB1L7-/b9/YKlqW1\5=ThD?l<n2,Qq.`*N_<N
Q1EmH#_i$=5>r)a'$f-..&k3UDR29)I0uRrZ79]ALDRSdCEpEh]AR<1H%i.,s@E>%/D84JVK2X
rL0[-RUm63TC?H+PAQmhHl=/(uEg.[fUd;>Pc-ZgY,tl3)0f@jI&c_3K;W-k\A96<^2r1-7(
Im)(-nTRQq:4YW3ZBq"4e=$qP9b%3r>n\)<aY2R6Tb\u>8SW?\1WOFe(*T7.lt)n:P!F70!&
Q;gW!S40/$`?aT9p:7$S(GaEW5NRgR?N8'&()dCSTY1<H+PMHlOhLD_"4k5j-P**LLssi+.:
D(tQ)HBd2^LQ4#QAV6noEpap/d6Gs,R.)MR:6Ac[Z#Lf8Z$p_,2qn"]AEPmrmagE$U5id*\>,
lN%%6JQ\r='UJZZ1g/fD-YHTDXBQLC!>q!&=^kPD\n>lg4jcZG6VbSRD[dYrd&\Dn&'/CE%J
MaDam&e+I:L;?"r6?D]A=-$k+'0&?!$oZKmoiFnT`au&a&#nd`/t<0T$lo\g-o*uUNJ\+4WE%
%4:;?(\FqYFDPnUO``h+7;*nK$!^Zk?uodtSAr8bq'%M2IG"bfFBX8[5N&Z4uAUj%H&hIR"2
]AWJuP+LX7\H&qZs]AcM+]A3V]A,N>m.&h&;)6=Ot=R`bOa$P6+De,XcI/Y7Ufo)9-1b@b3`E9/n
.8r7O9K-A$+b?r$M?W&C2G6j1c@E=l\(lYS')/CpNKd*K.d)BGJ.CbFn[7X>6!h3[1i[`9Dr
QK074_XS-5UjY5%!YbtGo,/*-!3joh0,RHdR]A#(2I+Y<uH![AL%WD:c)pB^dgL]A&EH075mV_
$*@RFf?u6_)l]A\5&Wg(6PrcCbpXga,A;JM[AVIFokO$kk?$<h(&Z<EfBj1(=&VDD@B?a2hXp
e0oQWAW7-AN)bNH<Q"eLsJ;D"]A;I^%'&C,XRt:;WE*L!NPA7>S=^dTNS@VqIQT-7s$5.ab]AA
VM;F*/PHqoM%J'Np'fb5>S"5l3#7S''MmR$m5[/WE"RD:/^u<RG,!^3-.KdW!*eeHWH\Uu@9
]A6^dU+u8T/BiZ;4N++_H06gM=d*2>3e*EJ77C-Z%5G<R1qs"iI6sMg`#<nbYe!7fjkOKUgU&
h'[4;g&$/DG;[R1,E]A#_e#IcAq1Jq*09maX/'R2KFD[i)a%+N%3Fo$5/%ct5ZPL_J7E<(/*'
I\+B)rgLj^+"a8]Aubb.o-rM$^iFap^tVlPb\7C(@E#R"r+!ncK7ic`+d@/e%D3'YPU:_*mhh
?=#\<TEi7D=[pDfPUamHM>kN7$6<n3)oA*)-V`Fli@8%FPq&Ia7S(^b63.Js$9<YqGG.u'dJ
k?kFT]ANdH[\cj2S0LefojS+H0:B%r&knMYIB'J0N=mP>`_[:#&h]A-tW;#b8NRg6pQU$`1bQL
`<^+p4?);P*)E'A__QDo1X9F/u?PpgVtU!u\NGB>C:7ZD`@4X7n.YTgc2%LOIcZQ*@RQn-Z6
o;4&]A)>ie?See?Y(/D`#>1p51=)8!a^A-ps`k(.<XaTi%g\$M-Q:nNsDXJW(`;6O#L6g<'WE
Y`3l1$^#O54Y0)W>1I4:j'\_cdp"C+YE]AF>\Usfj/7qJ6r*$1O^@I\]Ag`_),]A^*Z0.jki-M=
H.1u3fSU<td02rN.4hUND?T9NGW&H;:;k3WgGaK2.g:QCZODuZ`tbe#4;N@:,;QV[Neru?L6
E\I3`6Ro\7e`SLNrWc)cMW#Z34#ZepBcaQVb=k5$fT+2f""sUfgX>$^Z39?]AnG^[^P#X0e_C
+h*mFjp9/;'dQ(t(XYjdGk5,6XHd:<S(IWJUO)=V\"'KH#CF5.U>.Ls&3Z4q.r%eKh#_EIA_
6EBH..,qX5,`r);*;X/gW6EfC_O.G>2nCuE"$%HU<c]A>^<4"U#+(-Ig=rGl?<.C/U_Wf=arq
3s0OLm@L/lhk0JWkka5f_BBZ,r$e*T,uiomSg(OWnS0`JQDFM')^@VfAB"I%]A+So"MS7`d'M
.=s6dQR'At+ad9"5-X$M5hf";%sBmYJ;Lm;oWpsUi`F8Q@M>p9jDZf&%Z0<89=DuT3&$o8<,
UlJQdjl,*mNeN")<U1H%*C)j"'m82H0"[^W"L$.4BPrB5hFpGK<NX2JatT[YjeA(*n,EV`k6
mB'/'?&Za?R)YYG`S+IVc6M<)^C2"DE!gdX^+nBBGrm:.+]AEOkkMh@>+!9>H+IP]A'Q)fnL1u
B`q,2ij*6']A,Io@FFYTIoe-ks-3(SUk#jtgii*\E<ru3EabG=b05Sal6F/`PCUk6!Ie[U>\5
k%<[2:UkTb9X@o`E7!#(.=`Hc.g!]A.0)DL?A.fe3`q"Pe4992C_`Ig,sd!tF16?sSnCB_'n,
LAp4peQ"^oIU+/B[Fp0O@]A`HRI09hBPF&@=q_1'%Rg9ikQ)\VG_nB"e3,/j??:IH6G:/0FY(
>Ya&Zhs2g=kQ\9<'k)sfoT\fd>;$2M9:M_DI/&^Meu#\lA,sWC`^qp\ABmPb'd_Ti.s=tnpk
bJ,#U?'q]A$aaWU['2ip"BM[B),'tZ&2tW6\:E5kJ<$,5aUag0pU4VdE@6aQ,:D(PiprlHdK;
jgp<Y%C\.u^gWQUm:J!52[5M`d.0DI=^@-%.*eC[t2>h!^ITH(*o'E!;DU'%9Oe3bWpHX+Hi
Ce*ZA^[egK]A)M\Vh&-R>@Us4-\*H$Ad82t+t4/-IjC(>&`J"TqW0@2CeHI^7)K/r6G;s@Nj,
QK6s3C#5p?db*4#aW/A?6-@RF9LY#l\/$0:F:j-j6F*^<^3R*mtH.EK)*6eEIG<2Td/F>=qH
j*Dje2EknTPb+F^SC@&%2AL[dd-[U,SO$gI,$^%MX/O:g;)-WIYVu.a:>>nfGAK?q2%eB?Ha
;!;oG(/oR+"tq@t,G_Pj7t1;6%BTj%?&&o/M4,C/=ZCR_qa4nVWiJROhE(`lPa-F67tRo7+6
77F;Np20=^8"uN<^K[WUDo43Lr^n&r(Kl)>[ZC>;a7L]AY^e>$j*7s/KZ(Vr5n:Q_llB[h0X1
!jb`Q@i=&.^dU7#q=RJXl'V0Fs_Nf8*Aq%a7j;[VRQudo)sAsqO+6gU))RX5RL8h1KbJe'CW
4,nSp(bIA2/_'(ROijaZ/`r#X8#Jbbb<pdL6p[^L@J2PXo(k4Rl<B'1"m`U,Ud():$bPEe!2
*)6G\Y6&g/m:1Y2l\-r7Zf!s5a"8ZWDqMD;j.B8WdW#<n@;WZJf]Ai\FE2\d'8.=r"iqsPC+n
3#LGB:sj!h-$%;Yla%_j`N49aVrDC7_$*e;s=[H=,D2*'LERho_23clhlmjUJ>.5a[-'mkWL
mS%(*QNH3nJ\WN]Afd1+OO.LFsH!;cOqpT`4a?<eJbp2sG`A.=8SVf`o*qiO(Jqm-geDZd/fo
"#M6VQ!K#O"QnM1=1&h(Zg,2n9[0LR_p*$BUViY1]AT]A-<b:0@BZtu^_.@2i3\]ANpnE.%q!%T
Bh?'IP':M>&A#*n]A\/t^r4OVt"/3?4*#>2gE^O!^_TPuB2OgfXb/RQNg)(W$X9Rd=<s;*(*4
/@Tf\S;d&ql>2#2iGe(bAf9KgQ['r[dHh4fAsf(E):D^S%>579Jgip^U6EUCJ&NE=p.5;dHY
Ln[33aBPE=.oK%t&:f3KnG#\?1GLiq_FJBOfci`OcHUVt4^N"9(3k9;3j]AgZ&b####@&LRM;
%*&euD\C9@[,.]Artji7/&1Dl@6DsKRChh_%X1=AV7BE7SeV4ISX01B"DE_pqel*Ji(SO:N^-
h1fLp;&H)'B]AbJn07BlB/3K%Jm>Ge(o-GS6`%dc^11W?jV;/lQ(WRb+oMd64hi`I:r6NRj)\
W.g?M>j9-U(;^P4S*7WE<4$A&qU!@#""Zk-rM@3]Ad2PX;so(Y/V."PO"$.Kf$J^R>]Ad'%!ES
IJ$K,`tY]AQ3P%CoB9s!&8(g!7otNT#7Q+u_9WNXIg/pH?g42T26JYsTZ:@F`H9lEig5HMg!.
c8r%N6LDK`K8fQZn,m8UUAnp#$r.ZHOdgUJ_YE7^McVH1QsCQiLW%IsY<$;\rrV4:A5$9CfN
ZIAJ(A<O+T$QWC@NBT`E(R57G<e3<Yq1mFX`E)62:ID.[J@r9G^6_%H?!!-4V2ueMT`buc@I
.CJ5FV1Q5;&E*?CGFT`?.Tf7bkBc;'CG.m^>gZY=B431BR,\\*T#n.G.cdHRWD\=JI=i%V.m
5AAc"Y&I]A7JqSHP]A'O5SN.[G]A_MB%d\Kab:0,e`B@<4>A]A9UbNdCR#A#iZOeR$']ARU&/o;7i
j1AUZ9R%X3Rf6^7Io_/#qp/Ne;"G)[E(;'f45I@\Up$$Llf^_DkRHf6-MI3oq,0MA`fg2iO/
]A0+Z]A@UE+N&9DHk%,66q;n7,DV;T=??_P:5=Kr4Qirgc;?tq=^h+mL$:<bYZ5@9dMgc:$D?:
`3!S[c)%XR!M,2L41"ZVakkJ0Uf-CUUo6NMb+"dH4n+*1SSVhW*S8+n2!3?Ue=i-/`L>(B`%
%(6Td%Or0oOd.s<sj&M:Rc_sQ6*ioh&O9aB>XsLL1+_pA=RmjS@45c*N"8JN4ilsTR`LJ3Et
Ee:)U9sI,a[#dl]Au&`Tt9RQLTk!`\ZPoW`bEm:-<:6Q(GbORlVnQOi,HfC&!XLmW?95WQc!Q
o/>n0kH5D$p2!*hc.&Fe&WL!of,T-8J0H=-I+/dFXpn^Z%,KiPMc0hqMf^=Ea&d!P.=<r^mM
F"F`pJj'#@#,'Kum*k$0QNr'75!pQ^LOT[/SbtjC8/IE27*uk[lJO?C5(g"hLLYYUt'$U`Rm
(.$mqo>rE>Ge.>n9eL(02#agC,PZ"iG&_p4k8[3\jnuCLY2le;AonC6G5;:Pd+K;<<Net2DR
ktE/NF5LX6/2V.j.`eiNWA>"YHfI]AJE9Wp+A\$6G@YW*4OPV%%-kHKD<*ZQ-\5u_EHc8ZLM.
Yi<d5\<eQ&u7B$WaCUN=R!;ni;QlJk_m8\TpX-@3<j.4%q7Z,DF`ZXB\Q#%%j]A3Z/V4G+$(L
:\4k."Y):1QV98E-ogu[X-[F(/CbEXf%g\&'/M$hR"MaS;Ntj<@"252iQcK2p[<":VKZ.&lL
_("Ts6oC4_Gd?O,W=6`M;5_AMlh;=5bN=Vgh:CRHUWt8A!bUfCncL"jH)uL5f*,)c4`Al*oD
Qs,qCd%42c`9t83!a.`1=,Bt$#-[DE[[7V`2JFC#,fKW-PRh4.TK_\#57@9g;7HZnhD7nFKH
6Sk7OBp=]A.T+ajhYd&s@VH=K>#uW`#R+:MQog[e14&g7KtFiHTm8.83!eQ4Q_Q;`KhGb4\X%
6q5ca-*F>iL@j@!8p>^G7RYWpo<8%4H?cOfGp6]A]AMm&:HAUrg]Auo1!A1Da('!P:nlABU60TU
9\Klt:*&!VC)9?.gCdc>iiSCUTW-H:MBLB*91j$[;rQ.2W]A&3+npe7aA`[.j*oR?K]AF)T<=S
ko`2MjNP`Is:9Ob#O```^;+<hoXT^;JQWi8qW!@,D_5k!F&[WF5/>p&Jr@1oa04Z7k=S=f!-
l6&7N5O+,i/*,+AajBtg9J'G`$fEjG6'?*9[IWF$#%thS)%-il\=K"Lk`afiOGp?"!%"cr'9
XD)sk1iU4_GlcaQAe"=b_Js'bKNSP=^sad8pR6aY5XYdk^ol).RhA!5(Z44^:0YI3Yl3N-7Q
^$*2X+@6s]A5'ORG1I0+e%H,Z`;1e(JA`4J/`,T(COL00Yp=T+1<>W\)i(UYBL_M[E3<s'/pZ
6T#rHk\$c838O#krjZDl[gPENEKZAFV8!SQ<349OT;Da`$?5#.OPrL\TOj#+E2ApgP_;B,RN
*?pQ'IVIN,b4(_d/_&Wc<=ug)CbQ);<]A-^tLVJ`Z5CFXYSCle9eVQ<1nqOVK'5ZZJc;r('<h
abStRKP(%jQO8^jQia?SYn`!>(36g:M`7@)HL\Nnsf>g*0Qa[XEPp`am0bLLU+riE:o@)43&
9*KN*S,e1*Q6dBG-o(f:=A^p)]A!>HkrLJrrnQT3=3]A,S3dJ\%-+ggY[$Co\X92j26QfF;/3C
F?Dl1=YheG?6567eNbX?+(So;4%JtP8RE,p]AahZp"fp`IWp@@:Wc'fcH/A%340.P5*57E4=m
b%glJITcBh!InY\&?sG!Rh!gG3>[6DC\H]A87FfnoVPm9Xmc[r]A[bt_+[d\g`id:?3M'Qq+!H
.&uSWp)jd/0;O`3f.mDstNl#X3EemZ<e`TbN\+1/=o9OIRrOn89t[bP*I:s%2%L8j$Mak"V4
r`r*[3>M4Em>E?hsp*jZi#Ol(SICZg2@HU6LkIP1p0hYO3X@[=4pf*NeA>i>EnLa/M.=ch:h
`PGe/I3iSq#fsVY,J:(5g`ndka6e(!Vs"tE$cU-`ufM4FS6shP-7e#G[p)CHa9<^Xq\%#;AR
F<N@jOi>j1NZU*Edo]An)_HZc+,"j>GhXkrnLl@gHOF/9t$KTG-GV?Wbs_FeFOXhL@AE<]Age?
!1CQ2:f_?c<(%B@T%%`eSVk9MVJjR9;A"ff'd9B?OR0mf3l;=+m+tJ?98#fKU=JiH';:Xf=o
^q*I4)lUb8QC2R1`n*jHt%38`R-bIrWVhEKeD1n^#tRE`KOqrNbF([#0C,K6Ml1_!VBu1EY>
"T3'\?`QKNd^m+ZZd6u:nfK6UA1dc;hP-814@*D;U)@5>3pt1#*>=5CJ!1gp2L7itH%HcNmK
S>@RmW0VWYfk#Y!AnO#df0alA`WVJU%?`&p_S,]A;=Xt,\ojQ),)u2;F]Ag7_$H?8S0nRMK(<a
VfDe_NXF>9Db)$=d&S=qhk/D>jEHh@X_jWaI!K>kJ,#k4i*ls+jm`U8*Fl;#R9bJk0s(l@kb
<nVPCR>h*P@mePm<k&Ha<gFCiQhTo;jdQ20!&Y:J3d]AcCVMcltrR#XkO`P>ke*[k>H>$23"]A
B;8coq7Y0bTef"1>lRC"NeQL;3AR7Y8GImiZ!""eN2M-n\e=_tNMTBeARR*fn)8HP(g,J:cf
+dnTtRjZT1@It_mLSY:`/hN8>ok*IZTR:(3K,Yu,rr5quu7,f"5#Ua3)9lbpsR[Vg?RcWiSi
!N/Y)LW47H9RQ7gSd3ffC3ZOdo,6[$&=F,3F31hWQ_gVCJ?4gQgPS:=@9p_Q#DKl>Ae?F1cb
gt!Ho%n`j2%;^rVPL4a5iJr-'63^VYs!s-u0ao_9"R]A0D(Ls"=$FC[\jpRQT3q3N&eJfK)c5
L`d[-'LY5Q5X\0/!""MdPnXd-'o<;B6Q'%![8*$B+@Ur_+ufRt6pOdn*/G1M$isLfP!IZ^Q&
tfjDkPek6!e=!k]A]A4?q'5Z]AGi*/hlalN]AILt[>#h%YF@Z3f%O3fFpQ[SN,<4"4KbkC76JKL_
t1J9ha"#"T+Jsu.[#OPfu\)AHKb?uU@bPU&;S%c8s9o#c]ASYo)-rgLR\V%O_9b(srhlZK"Mn
+j'[Ln"E:,TjZb%V+eP*dU0r75c:T@R0k0<r+FD#eIhVA!/2)^q@&mZ<2EEc?5h>W9g(X`;4
"NZKEVmh4'm^`1S\sNf@c4<0n,%$ukTka)t=U]AU,c%r/F".[I+;BUH<&T&#fNBVfb*&S"I+8
hFNETMna=S'@UTtX>/+\`5<=.TgWN(S2n;F"Tb2`op*4WZiVW37epN.e'IHs81#>rj$j8:=+
nmch!DR>\OAk/+;Y/qcWr2YGL>(f>;1`d+4-I@2/oIT!6C6GX0,"QN`LRq0"ruc0,QujI[2"
Lf^mn&$f/c)Lo+HAhs%sfoZZqCqrk]A2`KJd-MREd%j"sOjd9G5ph/r23?B^X06aqf`*T`Q!@
s1APLRknW'hWX)?F/2W!6R*d`:@8MW&`g!7/$5rH'0<a:nY%ImN/MSO1AFWd7@#.[SiQ`38J
#n(#^u8]AHsgK]AE;CQo>d5@_IkB@'qL^D17Y0)><&h`M+QV;-GTfS)Zj@F&6.$@WDj/Be16b&
J]A[gr2RAfED!<Uc6!bHtaaGA3?a?fHBt(EtNOXJO"kdD+m\^5+R5*Y1[oUOR\_TN/Oq"j78C
8Sef#/3&+fR;<_>UMf7pWUk+G(gQ*it;p%SlSr>+rnF.$j/tKj_6"(\ZH'k3[F[15S\>IHlX
0=^!A.U[O:+R$3-,AhME-21;TX;-9;6-64b<[gro';/Y&rRa1GQ'YgHOo?(I-YY05Y4l:1<-
5[)$B=]A.cfJtiK9@ekQ#9&M(lMYG1ViC6bNG%NC%+?D^X[eg4'mXF@<eLI186J8VFDr%KUk-
D1[p4>ZIuEL4>S;ja.AYueYho2P=BSXi@J%uuW2;6r@j'F;`e8g4S0L?*^E`7bHcD26Bhd4S
M2%?Dq-%=i:2&L+2tl$T1'pa3Dl#DW_(o]A+@f0pfj)'^Sgs<UGV&.A!hC]AA)>[#tY*F]AAr!P
(>U+sDWl.U\'3rK4B;4ur=llutFsJ&t/-8<<j*Ngi\4.UXlXL.:[0XaLg^qdP9akm#hs*PYu
IRUuh0=26sVMr`V,BCp=[rRQ#=Op4SUdX]Ae0^MI[FK%fGdo3@VUnl!6D9aJAV".Ac;f$hhEB
>8&9'SBe9FO\[jZl^6kZ(eVXd)m4WV#k3QjoQK%=.DhM#Qd?Ij\83KU`0fIrMn\[?tSDO.GC
bu_$28dQ`3-1c:K?YEkeh'l2+HERdHMD/)>)M8aQs%*aElM-TmiG/)sKO>^Wu'nL!s'6^Z*e
^sr4_B:YQ'(VEO0iM^%0/B(nP;YIq$Z_B]AhjV'?#ad`#[B1nMT#4E&Q-E$i^2)eB'&>QA[VH
3J1qtO#XAmO""&(AVRbt_'\7?`aH*^:W=Ee40ueEVG$$750a(M1WTC:N$K)l;#+*q(aVX$aQ
KN+)$@VC`[lD>,sP)RaO*6ASAt)-_\^qH1liFQu)6/>OnLacHr<TjD%DfQ&1"<H&JW.hHLeR
!h+SJY2RJ.BD<Po#sUmFff>O"+.pd(3sWLDtr^K;k9@]A;lcWa)nr[HYR]A35=X3(M:9dg.-jF
]A"0SJ:s6t0R3:$LJ8K]A7+M2]AQF!)Wl3BmIb3`&;)e+H^*[tDhH0P_QV-Cokg5ep<)S[%'^N>
E,LKK/;A8gji@8)r8Om0"PRXK:BVrn47.I[EO6jm]ALhTcF@8tIOK'1AIpp.WTNIP*Q^FDm<e
Yk+Q7'DoRldoUDL7OZfijQ&h]AZc(?YBfPWuJlOFN,\BK_lg/hMtPd$>E:O8CCm?/1=9NQHI"
LXb]Amn"?1[.SkD%CY=T3SVUpK%%QK_,42ID/a,^)@?-T.r>`Q:ZV]Ak\B\+`nZ,5Fg4U6cJ[2
u/>1\!PP"eq*Xs:pDJJ5dcA"ZM(MhNO"lKF$OPhIZ;A#d*Sa2fP>fZYV3+?Be/:e0k;,4H-b
c5fODtJQi1f>M!"Obhe+]AtiNbY3LXjT?c8=m>08+=006uF7ggc]AfJ$atPiBf<<a8!U:3RXJ]A
Z0NA@XR7l_]A37+`*/<N8bW<e=*Hr8EP8A,?W-'kmP-pbW=u*sRHY11'dVBdr0?#!QRnP[^?b
IuE=*;T?<>tQfYq@Yr?1_4NdNj9<_6;:]A^7rGBhr5%M7M>G9d#U<u0A,MHWS'G1!M8Vhie#P
bWc>IIlWW1_.6ctZ>8rZr9oZlk?+;jP3&p]As]Aq:knnod;))T\`RbMc$ak=B<J47;j>IRCIU2
-9b$bi"3R%J+=F/t@^<^D80NYp_F^i6q?khb640dPUd_aX+1;i0J_pQ76JJ=(mb;4*BY,e!m
_L\;T6hEB>b!<iTt*7&,s4\6b"]AY(l>T8rgOA*p,?')>iO11SQh$mM&%nRcpNu_S!DMbptTZ
RVbdne;qlNMkcn<&%6^;Ue<dS[a[>_]AV8\*^,g")96kPAJ3JI/JHpD5dH@j!I)X2.9ccH2hE
@<h5aj\`H_NII43@(S8X/LNN&e-sM9gYWEA;U/[4OFhhk]A`2N]AEYkF(=qJ:)"^O>L;jr^cB@
4XqGMs6f^t#QJ%g"^m:kO'.8MO)^mU$PpUdB1p/'eU9l%SU/DeS07hNaj95]A.2m4.$R!u(^m
,%Xc[k^7,+5@@)fDPQ%16TarmffumYomM\[mPo+Yd(t?pWUnu_BcX)Dj?8s1<.iE_isqD-D)
=$&8W!]A`\aKhWSgA,N4^hq+.TiMB$m^@m5Qkm7_Nl^PB4G!GZJ!G$H>f6W!R]AODJ]Al0ebaC+
[mN`?C[bjk_K>l,)8sNJmb9'HjGIepO*GSibfSK0RSk3#D:(mEZPehWPUB)B"C/Nn0PZNR/u
sCu#c]AbJ[(4(kp7u'qMT__p00r2-A=q=OWB01S54]A#[IN2cC2@#_^,L!7?/XW5`W@,'ag8o3
8**0b_8=e`p`EE]A0$RB:r!aLHWnReD]A'O".6.U(iAH(LTa0G:7h),=8TgXm&2rH<1Dl71NJ#
-^(Il6b5oG4'sL4KftM2;.pg)!\dG0Ns[F31K:k#i]A*6n&/n&9SB#M+4Q[k!4sfEUb6*'!(1
Z9I[<.G1JSZJl@UauE[FP#H>?8I+#ZuG%`6N^1cV?-]ATr;^STj`3rp+E4<u^gb>=r80W%JLr
0O0od&]Ag;0V+m#rD5Li`3EmdBhApN[A#Ku'SO:a%$2^gXN^6=?eeC1`HNYY&>^u#VE*>WOEk
T-,UGOt4YH#A>U\]A`6m44Ur^;mj6p,4niABil&.PZhSOLWM&Sp.;0G!(#g?RI2%eLA1u>A&K
(gfXCV;XSW+f$#qM1`[u:^SYPuVJiOtk=IU=p?^a^ljpJnW!^^$AP\?_ec[\-NhKeVdcBj1]A
\T_QDpPK@R7WTrpg3h]ARCjjo]AIU`Voq7+7C*6EUV*!I?QOT7i0C]Asu>JGc<Hn/KKQYb\l5u1
?$N>uQVgmoEPbt,I5ZN'7ZgCA.]A=\qYq369O,8PrZ-V14b1`$iG;k:Y!CBI[p8(q/7[$"qL9
=6.qTnWgEkmE;NbD.#2$$;j6m:V/Y)@Fj"rR!I4,=St`AL9P^=VHNbQ`_M#IM(&kC]A=n[@`4
c6Q4ga_5j./,?VoE*lUQRaC#&3gOUV9)@KX@QoPn91n)^o)jprqr[Fk>$thT15&RPEcjoej;
GN+qV49+iVS=VO!knWK8l;jSnY$r7eQ3[<uog.7PkkGQ^lc*8(FC,.q%mq%gO:>%UcDBE"DY
nRsGNemNQ_$Ll:AZ]A*#/I"Qa!H0X[J(>GpT.0T5UZ=)^h24cHrc1YP^U\`k,N9(Ui=.7s$m"
g7P$Gc3e]AFTmd*lB-qCQ5TqZgb5+]A]A:P,.`-fA7?O5@D9>=c<T\[)SnPa<ep&'+cWBWE8'/P
B*1Nc,dC@bBs^T&RpVM0m;c[hlqe?t_rEf8<YmDdj,qnm)Oh*A4End+R^d86SH%`@eL+GSod
s;(,N._H_">nVfd4)?;;-bh'[56U4`)Y8AKYZc&S*QlXN0:AV1.S"e-c_-j1s\M-LpbE%t2p
<2iYI!,aP`p0JTeERZq^oj3cMY!=Z;nRiN3QK]A#%6obka>1IF.V%>nriU8[S9*oeVbAUBphE
!Z8p>*41s?iMCt7]A5++"&fj#[b)BYi0AfBY`Q.mkn0<4o/5poB)NY-VT?4:!OE9d?[!BACV&
Fl3ptHO79$5#T7,Rf<WBNCe8L51-lS"maZ[@jjV#lP(q:c%i>JU&^Nu7gK9p^5\QLP)g@^/d
Hk,gr^5_Ttj1G0,gF@Q"f_3mT"=UH5m\B6b[U=s6#D]A>U5g_`HeomE!jKS'QL7c128/GbpYq
J3G0k)FM+e)"<>pF:IaQV86$U`Z%IX^-U]A_SLuAWZU%U?o?q`j-:jqt4?61=Zi+l["f&rFso
,ntu$2cRAeY@k\hWA>I,7AWO:jd@iWi#m$HOM^]A#^/29C#/6mVA)s_lL2j+!Ja0GY)g%+mdG
qd!e:-Un12fJ)0cahL+991]AhbR=:;8%c2Yg\S-&[?fZl@5eH)AXE(<&(8%X:s7']A:-?7Ang;
Pd)sYdte/+,?GJtmo<SRLO4ph9Ma5MOae^L%od'Min-3"W)R]AFhg?Q=F0X1"Pk8\e,5hQmS`
:e$Z,5X-@gmkV%^Ik%%^U59TYQD(t%MCDdg+gW[?Xl*M!gT[]A%il'W3V?ehGch5\:dH!4J1r
*Wp"A,\Bgr3k4\OnUHj^q;L$)qB#K.V)2N5jZu"-fpA_T<U]AJ1tnlCUk(oEFfb4gR/(I8QW5
-lcD?ZhQ4A4LD!q.B'@E5161'QrGimHH_5J[4?h&V'i0L,df>djQ&c*3q.t%p2%eY3]AAM+-<
)S"fD0K'u'to`'_JVt'TFg*4i[>Ih5j:qIl.Rha>o-UT8+ks2oA3408H.G.<*s7T\9es?Df)
Wh^GNG;+K0>IW;pI$@n))Ooo7WYe:]Arod^0JokQp_5)r%l8j:[48gg*>(<9o*a3)J:ZeNHB1
?LKTL\mCb#d]A`ch+L$j#(G+'Fc\BPrFu%o"TVU(HSRBmmQhu(AS+af?c.S&>W#(dPJM_Nj)t
hg6XGcGLSLKpFFD2)O)+b13"k5&#)DPE9jn@.igm'3;d7Pb"jR7Rg+V>AB)tV#c9npN?!sbE
kD/MhJX3`/7V=:H9(GEs%AP)b([hci$"e?/L*N4f[MqjXM&)&FsUeF8[8m[jg>u9*2'pTI]A[
e'e#Bn=L=%Q*QA`!j\XHm'_AH<:GC;Ig@`)chDVm6gK8f&ip'-G?\2TNXKMV^sSM8g)RQf1%
8:Kg[rD#Z,R'\M6dG3RH9o"9cM*:E\!gB?77fjb6V>$@&/T%ZiIUR5$t!(bjgCBErE).1.\H
+"df&nrkdr!8b]AV$(2JSJD#O:`V,&b[?[q.d:<5EEqA!+'+=^$4RQd1/JnXU21i;Pn<6A\-1
RJ2K1/i30,HQXpBMeE;JNBY,]Ak-8C?Ot2b6M';P1Vtj*#b;$;@pH=95I_Lrk0?)JXI!.rp@C
!+``J`q.s.mM)_/ipB&/D$6Wgd.#-0*#`@/CDeF'>:#J6..XjJK_(T4Bb\b4X!@+3]AAs=%^d
H4[j6Y%NCRG"flhK\ui]Au+nr,N0:[FfC^AAGMQn1;Y'\j5-q$DNq4P*r@QcJCK/OEqc'^,h.
b,R?A''T7i0u(W4R93J(*TSQK2l(VW/;C+W"e]A<uhjSp0q+KTd6J4U6`(BPmLBoSj#Pq-%Ks
Il4<ikn&kFFk'.V13A=NFPt@a4\:qpV_33HN%6^9'@*HF3J1eo%/%"4iM9!bP^Z?"CY`f/Y%
6M(2n*qE/ZUL'JL6WF[Gm?UrtbA2$fsfd^:L:u4a-0(3AK^\E+Kg7bIs1AZ`GlqKp6)$OcJ[
X!In[1Xh+6XZ"8b0F3=/Z2mp>*S..!"a-K[H:q)qq-Ruko;A0hLs*FPMokOEd(-m\"(o[O+3
d^*#`C,!6jUu/bWJ!BS&]A>m:^C+3u%f:tYA/mLd<.YgaS'Q&Ua2L**#BE6ajTDo;1ectHRe.
jFj>na,%daC&Lp[-^s-Eg<&0bt#$.D8$7AK^Ao,;8Zib>6mPq.f(<ClAN<N@tdUR_#3:2Mfg
HaRH,%20"Mjff>9!K%(eEINCXD_-;&GsS^N_tKGOOrUrBRdh=MipEN3Z\39.LP._4'4:,n?g
YgfIAhP)nF#3FKt\AB>PaJ<[:]AX$>M$AfiKdNTf&9"*>`u!Z]A>$r4)t.-t6?es^Ym,93=4?k
PpT:ILLO(glrRnG6_`'74ji3lSh_XJ\PE?$O.Sl@1-1I?Zr$5Y)?,5`RW1T0K@m0-CRVIac.
<56>Hb:"*+r@PmXor<j%"+\9OgtO5j8e$a\SV%AlDu.['5JTF`.\.iG:LKOA\!9"e;i>5f,m
;n2IIKa"5&g;j.?NmR;PHi7s=H@f1'm?n`\*6Xp<tQK`@Q+>UA'?#KcY8i,DCmm_0*+B\(.6
<1-VSNOUQuW+snWi?%4$ZeFaPMFaQReT7a7eY%oFYVr[%mK!sT*VSZ%3=Tlom93>^/r_am)c
l/3bA5o?Mi86<.e\K1mA(VE-B%HHD7Vhr$B9);/jI9\GbeEI3Q9-qV,Ibn95NLM($A%77:&V
^e/[G]Aq4QlJM*Uae9<YAg.^sf0I\a#B1JsE&]A8_ohV\,^=%9Zs^]AVc`:p5B#pd2=cR<ju?EW
8'b*[!i\]AN>Y5bq>5g*P!\JrDKA3ldI/Hb:7,!]A4q%%h\UYgZ^sup4rdO-I`JRNrf1NsUT,D
\oT]A,:=cE^i;3<LL)"@LDPBYnNXr36o9X)V4K@4:'FW/YskAe)/W44`@N=s,qNQ7ngA/m`hk
pId;VS\&\:LqkjWm-nI_:;qP+!5!E+#-$*&/Yi)]Ai2P0MokVI,B"T;P;4Moib"!:WF^dOBA$
4*NW-^aBVFO8)qiKZi'fITOQ^Du:9c!Kd?UMk@5:,^Qd3L=5+c5C_d4P8bB5DiW%TbOA7e0g
D_Ztt3n]AkaX\4Na;oCb6crc3Z^5_In^ZW&HPl7IR5lhldt5)M'r-R%Cedb)Mhh\8p\":':3W
HcDu=P;=I)10""_V08-**DogYlku(9B;W^Gp]ASoH_UNPAUS:]AT5-c5fc[.=de:A<HA,i1.am
1i3N-CEBg\1?^Kq:[;=OVJi6RV1mb<abF^eXO`U$@kk!;?G[5uL9VagU^PuWn\+q[!gTh6`6
.2;ThG1qe"\m6db]A7^q8+VA$*FT!A2[2-u6jTep%o^1NMEq8CQJk6MIc$PQd7bMB2IVpc3R/
`+<kig&MJE"=0J;1b`ZNV'+*D,[/9k5Y5pjju?LU%Ws`[WMeBs5.YCWrK$<'D'-d-W7=Xb<o
%@7DRL.JR/O5>rH.JWU\pZCIo?Z@anJ\K!pq2%I#kmr1c'jkhWm*f#eUl_`PD!!X"9al#P/9
NK?.=Z`E]A[<bqZ*uN8(%['5Dha(C1F((ZXgA@dd47js"K>@kZ]A9a6j@c3slCZF"1B86F]AGIU
G/3\M;.$'MbO\]A0_`Is(%Y::;4`BZ"p<#5(f%O7#.hXD2%B_O%hFBei^s`Np(&=i)>U)jD-V
-`bOEmt(h!g//Rno1dfaHVgurbV2r87t_2h+`02Rgj:_1lAYJ,N:lYa6"-u4_oZg;plN4o''
mc_MZ$b"@NsJA7b^HK`A0FN&%^HN)HfkGO7>^V'"o+9Y0q1R254*HHiR@JDiWahc0*6\B2TQ
.re^&nl9glp2j3S:>)D_f)d44)bP1u=N\hbL!<u9M+\9rO+n#[I\$:!.),pON31aP)-?Lhi\
7$E^_d]AR*cnUJ'>in&K*sg]A*nKuFJMS^R'^F\/L0Z:_2i_@FLXBlJ>]Auj2d!0tPnP;Gcj%(2
56Ii>TlLJ>?@3<:AP/>A`A^L!4C]A1Mit+s]A)I8i?d$$'6j'l^AsLNp\/3()Ft5mUesJ#<gU?
`!Rp6C;2@$EaUPg56HL#ODnMm)VLc2.;Keb;S>DI0##V<.'SF?5THZl[h"N)5"9/J"%!=%d^
qpU`l%u8IQd@Wh%=Q\K!`q!^H.m?5&<,6r"!P$2&6@iA=NT'P$ft.410U,?qZS/W56mH$*uN
dYLe?PRfQ(]ATUXXY/)Zjt0*>YZ%qC>LSU-I#8L/A51o<%q(dEBb?(k<2Sq`Gjcl^H8&h4+25
^i'X@=[VfoF:)^>V/bl#>t!\K_lhl;=NQ>RB,$qN);f6E))a&#_gnMT4Y.h-sEYBpHWhQ\qI
Ba(b?7@[rkAac(OWEmo*q2rdH72ll6HQ2um63$Zk/gLemE^(AmF;p.a<BM*M;_<urVCnAtfi
+3G/I`Rj?G3j=BGZ%37R_%:D.DX#e*>EpPHN0OgIme\l@B)j_*ao//4!WK!"cuD%_&&f'Yi3
CKgeq;d*J?,FIeP_32fKWGAW5s!)9cq!q!.'S<QK-URQ+;+XGB9Efeh%IBn]AWBmXtPQ\D8\>
d'W.[N!V&,b@epP`?5u2k?hgFNMeA(cYmja3bqDR2r8+AZi+Y%OW*SHs.$;Hg8`Y@\kWG"<G
l>b560W#h!oFf'K@[.Tgm>:UTr8O9H*lU'W3"Ac*<+ePm(LpdI'<`..*?[+<aSCai`R9J(Hi
7>Yr#r=`EdF'37Ob@G_-\_)"9;F,AF@1>lc5P;=!Gt5;Obm+;@,c?.sV3Kp-Zo6a0C9rG.)k
0T0BG8J&XcTrlfa#,,)^h/'rX%@Qu'AIP8Jg&!6ar,>,0<F;9rPaP@i`]AntZ)7#4ti./<H^d
g]AtJ8qiSILtfJ_.U[IM3]AR7&_2K.U^?V-+@.G6>7ALA<LVg-ZrG3Z6FV8U&dG+!+;f8c7J>s
9(-Q>'nST?*H`7X(++RNXS!7<8+NTe[-@WD_iK/LM$-Wt317d#"!ALO^902PT"=n:6b&BgKq
'S@3L@g*%$\JRi2$HANKlF#B'@aTV:ginXopeC+X455#g3V)]A]A`1S&@f4q8BI-6&6%H@R4%(
F@&trPgP2I9ran[U4oN:s"NW_L&[1(JS'jhM'l]A(gF%:>c'Q,)M/N8I"hoRF/[oppsBha`FZ
IA)L&%/T\<C*4;-$#GF?DUY6pN&cS*(*XQo;>5:9<..E>E:e`p5Z3D2Jl"n3.Uq7]AG),&Y"\
L-C\BaH&9BO-l%7[B*q?U#ST/Q!pZA65hXknedjrSk<*XHmQ;X.X0gWATr#T</D+.N'IlKeX
?F<o[E.'fl4a3E3l`&rZ:R1:1Q#S`=PY*'(te^lkUE'b<+h3T-R.8Xu8/Yi7$HE9^e1"#uQ3
u$G]AU7i>J%g<FA+)0*k+)Y#-%RAN"Y?/S4>QtaM&a[D?1"<W,1cq5GAk[Hg,&lJ8jrIG:!)C
NY;7q2WnUIj5j5'3sMF:;5?`EIA'Zi4`SnJrj22&%q@!KD>=fUWt%'dj(X#0LH0"_5l9IRZm
-[@WK\XVSGmL/bdVF#8V:W#at"WsSJ;WVE[Fd\?%=`EEi6091O*=+>/H2_c1_LG;.G'o1.:V
,;P/KU6_j$lGP!V-/iH/lt3a=E3gkfYs,TVPN:Esul?"u;4#jU)GGK(\n7DSJ"u&6>s)1TYk
@Zn+KY7:*o;*/ln9la&^L"U0uEkllS9`s]A<4$Vg+&ZBK#VGi6"e6gci@jHbb'$Ml/BKm13ii
;N9j>9GmHD($-o&.,U\:42&`R"-]A;RPRdAV2k'$UQlC2:_f_iX>`c`7`,[Ee/cY)&e,3))=0
jKOpqXXl9lV^Yq<;`fG5r>!flFVHAm@WIN=E$_f?k)=RY%+r3$"IT?QC8C8hA+=n1tLJ;L'2
>sL19^66kd]AD=T^rl`JN7O9(M^DO%V*(NEd/&<p",R/tl@M]AMPm9lhu[e)he;JLAd2AE)U"H
G:.dX1uK?-.(;2p[W5+bD/>.#KDZ>TfPa::]A''@0M=c,nat22@^`+alh:*$N8%XKkkG+_,CA
h(<q+%6/=&V#m!N,'N=HTY)<'@L!?7`/MjF%JPlEZ5F%mH0FhBl]AA(RRC-a:,"EgVB@h-]A_)
QF(_i,B#3F]Adb`>7<mWM2fDCO4HL[-%O^G8a$QVEJBCs6O]Ao\$GIg$EiT3T,Q\nE00c`\`X`
h?N(cCKrq(rX<Q1qWn"D;ke%TF)*!S<ib3r#%2(7>(Jd4V2#oHVL$G_[s[V.c_Ta\n?Sq8e]A
#SIf\=+E\0c%fSo2!So\I>')*q*mr6H-QbQ]Aaf0h%$dA&J`MNHb+T6n21g9<9u\96B)#l,9V
_7pWd"<3GVSr>AI[?_-IG=8;I62aF&N(DebB[Vl="*'F.+OW<,IJ"-k=bD,6nSeB1$?<jq;%
f$L=b<HIFjPcXIc[+ug,e?b!*>6h719U^ANn`5!ZRbj0MtWBSP15)/T<'jb+9DP/o^f[JB_o
M-^T:l1fifK[amg,6Xlf]AdALWX11'mecDV[T*9FAT(+<96T)1iG_koV9TgT)9IN3N!O'L1p:
CJ4:P2`,2s1aU(bt?r6TJ[hD%Lb?)bTL.7[*3P<U7k3LPtUXkR9[0FNZVG0fe+,(W'_gabP]A
lLoi4A=RbaX7-0\PhWMkLBh.!3F+tmKF\8'n=ec,0(Mi=n,mjD.2b`Q6?rB&ns[;hc/?Kp$2
7sf(B!23fr_;Q'[-hME_52q5>R8]A_N)9`M\[aQe#!!CIUG.9^.EW;?%)i/?*E=InYWEX1S@F
SH^eF.=jj/IdDC1<rrW2+gYf=8`nDM`r*K~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="66" width="375" height="84"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="标题"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report1" frozen="true"/>
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
<WidgetID widgetID="e30e9d62-4017-4eae-bd3a-cf519abccd41"/>
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
<![CDATA[722880,722880,722880,722880,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3456000,2743200,2743200,2743200,720000,720000,720000,720000,1440000,2160000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="5" rs="4" s="0">
<O>
<![CDATA[        机务可靠性分析]]></O>
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
<C c="8" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="1" rs="2" s="2">
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
<![CDATA[故障千次率=故障报告次数*1000/正常飞行起落]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="0.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="6" r="1" rs="2" s="3">
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
<![CDATA[故障千次率=故障报告次数*1000/正常飞行起落]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="0.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="7" r="1" rs="2" s="3">
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
<![CDATA[故障千次率=故障报告次数*1000/正常飞行起落]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="0.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="8" r="1" rs="2" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="1" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="2" s="4">
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
<C c="8" r="3" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="3" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="4" cs="3" s="5">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="  统计截至：" + DATEDELTA(TODAY(), -1)]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" cs="7" s="6">
<O>
<![CDATA[* 非完结月/年，数量可能明显少于前续]]></O>
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
<FRFont name="微软雅黑" style="1" size="144" foreground="-15386770"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<j7cP?6><SZ-aD@\m_-#13^Soi"Z$!YJ99Q6ap_AXllNnP\e3'K)Tj6-p0`CMP/m7DbuT;8
Aub81=m\J8e6:7#6_^!nG@L`X(NI`/oZ-POi8NI"J&;[:%bHn+[CpleQp$HU$h!cWY[Nce]A0
=IebW)s"\B@XHtmFj5%tdB$H(TRe=^&s7?rnP?7&]ALM"dl/DU$ggKRVJmWW#Im80AOC7olJ9
Z`;2RU5DhR0#Bi6,21OmkqH'%NjL\1bZ!1gs*$g"Fmf;f"l4B.n6]Af6!ms+9BHiTS,^b!Dlt
(nZ:MB5f+3foLN\tbcAhFf+/*H,pX&+g6^6S`A.!%lPj$I"D_PCI]Ak@_C.Z'K:]AkW83?e^9l
3eqQ&*,*g?R9.dV;"&DM@<4(mMo>]AtZpWrJn1MCP-$[C]Aju!qHcoRf4P2]A'^OV>BT-U$!\fQ
9b18t#iBg1#l#k%CB`_u=@gn5M!U>h,3NjaX?Q4k('>o7iA[rr.Y,]A!EBr/;Gt=QJEb@WA"h
=/63Tsia,i'7_u+rRen[!5)PM"QB%^+9>1pqQ/&-<OfrXA&FJ&r^*c_a>7A2VdbU'tCch#8;
BL.`me/^0Tt3*%laYY[k+FJYCu5aCF.PbbH,!UA><%"6qHZlS%/Ai(86cRNq&%)J?!%$dZD+
daZPN<bfo9%gdUPIm]A+/>Sa#J\!F=jLBg=RFGU=,SfOF4=[2jc@fI$)0p18#>I<YR/:*;a%d
d]A@T<U(?t!j%<]AmFs+K:Z;i+)$8:Z^nd*E?M_?rqU9cgM?2Kp=jB,f!=Wre<\R7BL4=+`.VS
LH(IP4K;Eqk?s%jm:.>eQllGb)Q3(TG#7X<"9W_;.>H`G@Qml%nU\<[IBr1s&$m:$%<#D(G'
TNpdQ1g3X'p5JC9+WnJ4`g2K_Z9%:`:iSKJ*AkTo#/#dtl^3Z?arD9'Cr,+K2hUi@P]A<T/<>
JN1-A+H*@*:s+E:NI?S7o6"Q"D4B)mjDI98$TQk[:d`'+@hPXlW?A(<[27)5riZR01j:]A8:?
7qe=R@T`pZ'JZD`uSqZi6I]A*u93iWcp/SJ^c<jFP+,/\p5Em_Ee(^?^:e$&N0LX/reb[hL'0
JJ\>lG=0keNEdK+rbsXB9ue0Rp=Q%hs*nsKF5*'`q^ob`4In=$i'n[_+Z>80]AP+fGjpBk:_W
2pta(OblKtT/up<eE@fmFZujr<2)LnrGq84i!1j'*r1an2hZ:;f+)fNYUlisVdnQZ(dlAHM#
*c$e*$Ac2(0]A?">K;=b,Zi$#RRm$Y4q<l<1elG'a1o7BMfXG-iE3(N/cE>8EI.OrKQiM)g5A
lom:n6k?@l>)a>"]Ap74/ntN.)6f3W#:<>AV#:HUaP8hK,9,_.aFika\D!$l[=lb@C%cjsADl
k3E==YIL@&q`[[lbCeuH%$4^+3#&]Aq/]A"]AV^'(^CBBTu80l?_Sck*7q\qfR3bc\4+45$`u<d
'BU7O>'#2-FIr_%omQBu5Z_j_<WI\>>Ibj.?cmlXZ4)7fVqP+JY?DBt/G=O:gncQd3J]Aof,R
7^>:1nn5KV0E:N2OEYm/$.@*BMnk/MKuk`-E]A7igNEAV]A)#J-e@upLP5A1^P2os-sg;`(I/G
aO,SR4Ug6u)XnR&d*WCgs<8<l/V(TnRc''EC`EY1ai^ma`f'&'urn"7+2aj"Rf!\/6mi%'`r
+T400#d3#]A<aGFERl$L1#CA6nMfU9G&r$6_NPWJLA8Y;.'#r8j8s:=66tRd&4l;l45W)k=ZJ
EceolP:4Ehu`k+MEJTV/AhhsR3H".YPI$Qh6/l&"OMI2_i,f4=3p:%9^T/LUCb/=j/OG\^d\
g1KR+B'n=?HmRKF%P,$TWq^>[MEaktn0UT'S:88([h$$MqqQo!Oc`Q0BSPP5P>+M*k_7U-6L
,cl5+I;8NWp?]ANMQ]AG`pPKmQu^l,XaKdIrP7UtJPjgG2ekg:n;b6>KasZgV&h7jZCh?0"q6+
?K5.g"^([\L)CT_]AG9*!MhfB"6i,ddC,jC]A%SDfFul$V7ON=EPRI6N(]A.u3#JhuWlMEYNpi)
id1W4BZpLGD=U%>No_),1UkkH4Q0Jr)RYok7h0*(@[.0aqlLnHK>s28ooeFI#m2F7$;+X.U1
H::f\a:5+SlY@_%djKrW#AZ:C$<L+GKqg]As[CD03?8AA,OQZR2t<rpBDGXH5t9\PpV$Z;_^,
0bDHH.4qQpmX()9g8iNA->,&*EWropE*-CPcI$q*R=SC>^j'Pf24W#?*F?&5p1;%K5>eRncJ
TAi;\/X@@"cO?o@cO#Y>9:ml.Fo689J-&[nT?kR&Le5::bOA7#SGJVqi)q1nJJi&mCOX%,kW
NdIt!CA'qf5[J*'\VYFr]Ai0<H0eF&QeZ8@84fkli"[@6\2Lge(%OVih"b0;YOe%r7h>2<Ia2
*$\(G39-7QkCJ]Ae4Hb9-rRC/S(*RMNX\L[a^R4s[4.\*b#EQ6[k;[HrdlfEdH<3Kb>V,FP55
YO;lN$UoEF(=mf3$sR[mm;?5]A,S+Mk!.c9i*B!@j8%U8ZSo%,'!%`Qd)#NA]A)hHEtAQhqP,4
g6TJF:)c<Q=%S?S>F_Ep+-qmnlhJ?D<CXX!\iLR!>lC/&<rgho)`0go%d"./iqWBA%6an&1?
.Z7<&Y-WY#r&lX=ui"eiN"<dW`:hSh/*)"^XRaCbKhp_<A%#&.s`AUa\H57]A]A]AlCK_h7*7T=
Bng1;?UtH(SP\3C1]A!Khq;J'k1+_LJBcJ''EERN94TPUM,rXtZjqo_W2Uo&U."G6j+5A5f>%
DX37qKH8b5e`HM;&C&A-l`:glfP'F2s)QJDa;(jlct[Idtk8-:t[a_7(ZEd?(_=nb,sj7H[7
@-$AhV`qU#^6V0Dt'[Eugi.N:GVJ_Kpjrf4eGC5WfcWX2-(6">kg;V3:+8"UA%)7HoS7MjZt
0//`crMSX5;f-XOh)tID:,T;bU:-i`Q&)YgE"ObN6Qd#<FKjMCQ0n!.?`"/n8oLq2)U9TL&A
F$'AgI5g9Os-ZDSX@dR#nP`ZT6h$Hf;LliMVp_Xjl(-#l`A^aMt#8PO?77Y@2.^D]A@g/6GS"
IM=8tP6EWZ@IO8/c.)qZ:</_H21if0%\%ur=IU.I`U+fE6Lgi]A?-u%mcMs0A=hn3e2_a^SbR
..DDphG!I%V43SeCo'1fa5d@R*%"$MP_,0MAPH(=Q[4(m[:4iICr>;L)5c.E]AopKCTd+mhLY
CVMQ?c]AEQID1V<J0S5,Ro)Z/,(.b/ej=njipPng`K^s")Bb'HVI&Uq-Kd=mYrt"K+a"(KgQ(
pW95_77S0_T7Zs$pP8jZ\P.hV%WY]Aea2NL+-.1G2n#o5QR7a_&m@NGMAXQ*'Vqsn]A"-f[Z!u
,4Va`le2`>qXK8QJUA_=33@9$g@[?L5s8!J*$n$]AA,W*J!;[(jFa'(<IebiY4jVCgdOW"X7Y
qXQ'eHP1h(%l,n0P["WRYm"L-8Se&')j>:q77HJp-[Hh>o'N_+DbL.JA!k#<f`#.U\&j-5^,
.LN6C<nGS%ju?]A<8?>,HT&">d2OF/Pb;bl_>fV&J(noH7)H8iqVsM#K#]A-8Ys#R$/Yi\'X(m
JWOoGY&Y)C=&$):GT+`Hf`,n8$q><Q))kb0;!('.PN]Aod%CBd>QNL/HDD9<BJj*_^nYk6BgA
=[ih:O!&H:]AY-N9ac<@t'?.Q_hWiHSSFC9H`fjCUdbL*V-835:%iPhCb'*#TNFB$MWnfX'B&
E-F7Nar>T6gAO2uojVDJq#n<OBmnl`R,`"^XSme.<*pYa@3bUWa<VNolij@j;SPdCp"CS0e$
PPEH%mOUr3jn026;Wh",OVpZOPNJ?nU'48>g]A0IehdEqBY_ohi4p>t6=?b'.Z*Qmm_$?bE@"
%`pMpZhPI;2AWd:V((6lpE(C_h8RCI3U-AJZA]An@kZ.;mZSG2ICH`#X4:_K?76\?n=W\?6/=
%+FNHpBS\nsE.,9<g%p$+chE4pLiTok\MieX'.fj;th<\C2KcsJPle,LQhW8Gno5qJe6d5qF
WAUC&@IT`[X/Xd#IK$fiC'T*dn=E17`6No*0F]A;mk[pTGK(+-q8,!?.hmTL?J1n(@HuW*=GA
J?SpL"m<&(\7('IHu<:(BuPW;+<(<8gj#%WlDSBG%924I6Ai2tlKij[0V=AX3J+hpg&>^)SU
'LAn-o\HWHq#@P"r+oFj,GK4E.WA_VO.]A+8]A]Ao8mO[Kho$cEZb$mU+JDF&+<nP?J_q.><\V`
#o(*hZ,3qF4D3dYk098QWF;PS!8@+GCKr4`u)^_maj.:nX\OU:fdF_pO:V&$^+?fBQ94'b]Aa
G(5@U\U8e.`t]A7-ZA;<2mHUUtmQ#5H%[IP7O\Tr`YWF2!HXE_h_m^`7*Eb2M5s!kSZZ,">==
.1rs=d"\lo9=hEsZ+7b*oR>^$HE.s_ftcA4G:IM!UAV^i9..oGl,W2);*hQ!naYElNHcS5?>
D:=jBXV7i4M]Ab1faDQ@Ho,#n5P>:Gf$&03L_4`AR7W%,OuQS+VLL(B'7mMD-!A3c4J]A0Ek<[
37dfKQ-F"(S8OAnKmdB:*>;^(Cb0D:n7ai5A8u/04?9pOAd+tOW5iF/pTZ:KEEVQRk17Do`B
]A9TF@D.:[mQR!cFBH-%ee*ncdcP+"[2<ueNO[FqXL;%:L"l*9HOh$/-V)k71nbh):opoAS;3
CP\*3\Q6%oY=-Trc:6dKj1BM1(=Ys0TTEDdree^Gm?C@Hd/J<t.QO4_p-Yr7#CieYD,fj-E2
qpH"fW<1+R!!-!D.lH^s=oc2XNFXHWg\XHn<Z0]A!BiJ\\luj0LeQl;<mE[JH#UB`kbgJpPe#
A#Z[15-(]A%@d07q#Ec6Bm>>\0K=;Yt7s(IGKqT+Tf8EaOmW<c1#_*.(8(P$;2t9)J%069/*S
)kkm>VG;!$c1OC\0m6jCD;^%mG(iN[`aJHW]A?KXe5;55?o+`V:;@0f0[6=apR_l/gC!BfUU:
@cPB"7'c:>>16?;)IadKHX5:?V>n-JD^QijD`&Vq,*%1VVr.lR`5>]AZIhKj\]A)QGTQu,f#(r
@je4L]A7hDi/16Y^!G;ViPFd5>Ar=-&WF]AUI[,d]A+Xsq?Xn9frKeGd2EWc;CVf[`VPmf3+J,,
m\]AB8iU;g"2[[1X\'!=3gP37a"UE;QpD8f<L@XDcH9bW?^6q]A:)j)`DJsN;jQ$eF73Ae2^ar
7_(KkhoWdA*@TGUf/.b())ZG0uK@+-bY5bZaAY>+R1&`'rd-CipMOAuO5.pT2U9*8H#66A>o
!+CCk%,o;]A'4hE-"Q@4U1b+b'lb'i]AZ+k<f`_`!)uCs8H&3OP;W7\loQlRX/[*f1.1UKsHC*
SiiZq<O\R)ASRH?<dbk8VK;E?^R#EKrX?pQU(oMW$lR@?Z@[qY_n@Bj>+qgIqa;;Oi*mSU;\
/Y%kH+Ah^gFBQ2AJW^5`ajF6Nu-Lml$7c-cHc5:dKY_e.rZ?%)7+K(T4#Rae]AUIIQC]ATI<!d
=rVCj4ff2@Bi%c-e"QW#;F&ZK-6R^#VtN]Abn>M.<>mH?FhJ./LQ.3E>V39Mqkg%2jqNTs,(e
e7^j-_I2f&2&keo@cLjlXCDNQD:clO2?t^&f<HTt[Lh2/R>G&Mcl3\#M,n=hIpI<1:j@H)Wk
MECb1c`.6t#Ui*\d9qo=@c&sCN]A@`+d83)')A>AERGTi4]AUG1Qn[!FR$?n.@6.>"l?FiqbH"
*5c*b^]AFb;>.#kN"V:Tc%GrsF#(H6U]Au_IRAOS12kP7qg#50I.kn.g2=,n=>jMYJ[dT%Z1k*
TrLU`srCOQS(naJQH0C@>`SJ%@!nGl'V8QQbtd#hb?F$)f+]Ap2+ZOsnkGk>?DJ>:1':3L3jB
dPs?ZNb:25[<oW[:uJFrBj7UU2%tVT4W'34IjLT0?d[H6MOBH9p/\B`1IB,NC9?pV@(Kc3Gu
qBX_i\K:2.gq?2-t01TMcsBW"Y</ZZq/]AL'NVf6u,2Z1pJ!)N,j0K7oW0?+>(49K0$<a5*qp
ccYPOeZA.<`Ht$+<b6.sgf/A5>pnSCE;@SWVb)T:[Cc-,"iFq7<5[fL$2>\*-m7/W&)(_qcI
Qi3:NF^X+d"d4dJ;%%4@P4rV*26k,(C:L.rpl$6@]AAAa#LODl(bA(\VXol#00DhNiu?oB3NS
HeRYE]A'0:"<ll()n=)dii+R'PMM<V!fX)TBPX9[Xgo7$9(V!p!bSIGN=`).T'k'#A#+Z,7-_
.f#S%/1b;+*j[=g^b'H\&6-'N,p,9,=$k=^it3RG2b?'(\h<OqdAbPT$BW;D05dM!!!)T^/4
*_"ODajI)>-/BH,,ZM;1I2MAT5Cp)Jm5hH[3NaF*dUIJXDZ]A7;<apfB7!pGG2%T#DQOJR3_t
mZ0(aa^.Yd@-L,5Z49'QnJhs7O^?ljlaoM7c1:p[Oqj'^@kV0$l0P<)57C]ASJ4VLfgSXkIn;
RoiGB:!S=+)8OjPVsi+=!3h[GmH%!jhtI,,QW\9e]A@L-`CUC^6@S3AjkV_Ad_na-)N2Au34o
0sJOg6S6m>H)eEGWB2tD7"OQPA]A#M.[/qVTE7p!aDuQ7rkp*E)EeFRQ1kZ>k6L=MdpfZ$-2+
&o4WMjccL(RbDeV9l7-(c=KGk_q*6R'u^!g=n;""pm&]A^n([7r@ZAZ2WUl`3TS%bu9'6`&n+
#K:CWqD(`4]A]A>GqGk]A(f^*&]ApKfm'5<!(!adSS=d0Yi8PcHc2<L5=!/see$&JoN)nPHHY/'X
8A#g=P#SpsQm/TLj/Wcq#%^QU7q/T<RXg=<@b(p.AN\=/irIq<\)d:aT?Og$M(]APM<G"lfmV
WhUg`k&nf#^\_kf2boCC?*9#H30gZ4k;foXP)9<fm-dXL>lGlAan=nprKfTZIcK2G`dO?a"B
?,V/Ol8)<;RCYOt!lWL,3XDdt7%lB=@7Guc&#W0EIEGWOHI'rec55bQ[\)SUu35^Bs]AGZqXU
/)KHSBW/QV`E9lV]A9/cbZ;K$p'ln7fk&/_)<HW$#M9-`9'c`NniMO;^Z\=UuRQh^"Dh\(E=S
O&Yrh7^M7o/FoP$j*]A?c)MF0ZK.GOQJi$!?eB98h\enb-A[Qn$`rsE!!'/?>W<XM)fs9L<^C
Ja@"pa)poOAL-RDth5_h%fc;q5R+mJ6X6oUCml.T&r4jb3C2/OAnFR(5[TuDWQ1o!Me@/u`c
,bVj&tVBI(#2DgH:nY/L^W[BnbX3KfA7M93&H\CN#AZ2U7H#VL(i!g&8=J&eiUAS3>F,Z#PG
WT&jNR-\K)6d`?q]AS06]Aq8NF&F5)i[QH$A9;iUVMj0$Of9F@s"L'/b#)qRH9>ihm37Sc:V9#
5:fl=3/&o#.WBJ[0"'.Cq[0PmmDEtmBZ`b6T()"E&a)F4/k`JOs's%q>Fh$No,`B&PS)&Pa&
qog<58AB?1(RcVRHM43km`Hq[5$9dhKg(]A\2-@jSmra%l`UsA&%Cmj4C)PE]A!/dp=;XHM:55
)Gfu53%m4"ai2<'rM=Gg*W)i7c)#(XkfAqB+/9.5]A.0CD"6i/5EP&<b,.Z(M"LiWB&@fU*0N
#G9GAViQ5h>?BKSI(rm9:gh,Ag6U3UFj=kHS`dbaa/u6Dm2sbYe^IU8FliUStu>&MQ\40)W)
N]AOE(fG_r\pf0n,F!FHUf_M-YHTNX6EI0INBT$YA9TgIB#4dgte^;J=4B5IWEJdg2>,!$LM&
*Z-R!;1j2X.MIk'$/O(N=hhbN2U0f3h!Lk_jbIhDF(I$R.pm_giL-_'0!96_"QE'<r2\:_X9
*D$B6O&IDdq#<:%U-<^L8T,R0kD%![u3R%Pj<OkYc@>gE_K!_sl?^]ANhehNOs\"3<!cDWs`Q
Q-K_3s-Bf2^b&V*YX<g+YV([YC)=/`]A2:G#Z2;MU9qV`HGdQh_QY^F`kc8&#O0l[6VJskh*f
g-fS>2b?tSj"Ku@$bh:]A]A-bm]A84NI'.M;_WRN-Ij>"'c?]AF.5\,h19_)M`SnoVESc-I,u9&p
*fBG+SXUd#`L$24-2:l/k[@l&#pisioG^_^(5"';lkSZ.#'WXD-U'@<0p\o$0pNH9A0_<37t
WTQ"To.uX$IUG#)*_NG?8(Zje]AUu3TR?p<:2")+j8T*Y7L.Ktm0(WQM>&hsj\+Jb"Q^C*s*l
i-#X.Pb6Ia?+7&^Yt92uK+o2:A&0)T+#nWiCnQCC_j8>Z+&eK)kT77H/oN]AB'HC!14$Gbmak
2<\Q*Sj>gl<CBTHhGUqRiK8gN1!!UjP7`>]AgqJ4OF:7mZt4ntusZL7\kTG_-RfHfE<?/3"T2
Wn5RFdhq.[hp=*^e[F%2LdMS3BOY:>3MCQ3@:LBj+UhH!n!4tNSak<5oG@upi6qm<5/_r5;V
#4F`d$'89XQrpA>GeO.;0Rq`OuqbaKe!:fQ^Bhb2:!XNCQtjorI_YEmln<T&bS5(AsG`'Vh]A
<ZUYdQ(#9f5UCSK/MYE=DCd2t@0O8]A7"D;daC>nec6$#2]A.LAq7GF>C^/RoK`m"Z5>FN&cTF
-nG\Fnd)HQ!4S=0<dgH+P2LM5K-"a<p:Ce>dT8J2Z+6C>GuU&;&]Atj3>NF;%olD<tJN^^[rk
#S]A`<Q3]Aq7Rgcf>!7RO::Lt[+.2sflU4^u[]Arb!ADRI"(-Odf-'5b_<Hda;+n#k7`5PF0!nF
15p.ruAWi?rkTt@@K'F6b,BFbl<&JG0MX1op79KpUCnu&%g%%H2;=@W>r/3%\hhlBh[!>Z+3
R?8K3:XUnV*<;K[tLi.QW^&#$)<.+0SA4AN"$%XW+:+Ac<EfM%s9M105Wb)-$j`?g9_=9>s%
T6Hs5r21p4Aqn3u$EBX/XuD`.<=(,f_0@?LB[FHo.^9(u('[Zd!P8D4>\MI[_tYTE6&gZW9P
X^+=Ot8rHoc]APRLrH/)c67.>$SN2Mmph[:T,2p6;T1:f/-48d-7U>-^+9MRBh`..4[SXi&Xp
HTR[Cch-k!t\o/s]AJ0I*,?m"pr*.&,nW<I:1-ma&)?N_gKEJUu]AqSqu0lgZ_qpKSaB-[[K*L
QBm]ABul1P4%7<36?q>^%LO$W\%f:ag9)BFlG#R8EYAkr=7+l:)`V_pU/_clTAG!h<c%jf<3i
3i(HM\If,DGe/QYe0Q5g=9kSk6_%F<@JQ=K0I4AY_p\f`T-C:D'idPYm*W8*4l0oapMZ_cb:
d(7Q6AIlohd,3^$dg.>_V/oYK*3aY@9:=e("=7ptBm.)]A"1K04&n$"2Y9(<a:JkNPURQAeau
qQ+e]AkP[a;lDRc(TYUF[BL4=-"BRS-Ws#R&NLDRkRIc[u4GQIkI%kP/0`FVsK[2fbf,!HRq;
TG[QV=Eme*f10Y+NJs9uP`,%",e_pYl=/G?U5WQIgFlF8XJ\Up;o`P_E6FqB4H_q%mlOhPs0
Z$4RMRNffqA0dBcNr/f7*nLnF&!Jj>^rFgW$X5.B&h=;(R%eQ)B:dY_YtOtJn&&F(@'2.6'$
OmceN"(bc3D4M&#"a#8./&"bAI2!nDqhAmZ9-Lg)!]A#$4R.c(?9MAhqJ%iqb+095(<;[]AZJD
p;oW$fmVQoYpa>Oc=$884^+CjU[_qtlH5p8!pKkB=%e^?p8/2R&$d',R&cmQNf?=!g+8mjM^
o:t2UgN'I;`M9D-9sYOm:n/gd]Ai]A^9Ii1!dCKL=>!>e;ItE1kC,iL$H'"!"lfB^Win6BB1D=
Jr"<l:<)(4V&(^2K`([Ra#`8\gpPAudkPKJ4JJ`S_bY&5]A(ejQ$I%$N-K38^<U8(sPO@i?3W
QgbegHbj"'Y]A[\X2KMhn-?gPAU,&iRg6tW&oEa=;lN.@ZhVBUer)3ZXi]AOXq1C-NS%cad6hU
G[fX)<-kPSoEouit:KO=cV_YAcP%;El@gN0#:0"`_;n=KM:h@'7M9Toq?!(iD/WIUhW)@9N\
]AI0ZIJlJJ-)5M2MTFW]A'4)T1,=Z)5+*Yk[F5Rt'bnGpNPeu0pBrZ6U)b**K)3g1Te.<*nbo?
%`13RJ!HYeI>006XbQ?^A)+;XK(6,IhTYMO%b=9"667lsM&+;X>67.Jp.?0`u:YM7t@Y3f_4
ZN^Qh_4ZGJN5OEK6fHa"$^u%+>C8NKlf^R*7X&g-)n?/hd.MRatpT'_)]Ag!SNkOdAn8gV\>E
dcqO3Ai*e!X./4CC8CHCOSUpN&-7h`7BJ4ajD_8KHN\BC`0op!L)6ZkU57F93S@XP+$e?p<W
+BWdJ2"a30P-?^Mfi&]AG`!r,_M_RFmukR1j$529^)b(10e7QF<he5pBUF;U\El87\lKa9kn9
p;Dfb;\71h&qnUK4OMZ8/+3on=8>_j2G.$Ho`)D$\+dip9Km,/A?I2cI8]A(a5k:4U5Y\Vo3H
di=^WdLCg_4B+2f?DT"<fBPX;WEO-;NtKI=O"gROCjB'OE2P:r)9$j?IJ1R.u(E`%G90URmI
Y=nCk\%OFo?a3TXjBnSPF;k^Rp>U!N;M5kP'gRQ*#TNe59]AOFgq>]A_7ZmEfRh5!e;Oo3#;f?
r@/TOgqpZN-`JmI>[@nW5:8mVEh4;oXg(>:,V\!m-'%haPl+(/h<l"3mCNkSFGR:0b^&M.4Q
p+O31Sj.HR0L5Zmn4#`kNsdNi0b#e+LdAd[D.f.@otFVc?`6;O=IkEHQ\(Q!rMM8Je>e5NO4
L\nlsINZ.ee)BPJ]A\1'\VJr(V6oJX,g'n'&S%SuYHDmRXh71!6a:nM)=!>YnQpm,4_!q.P;-
?>`k2jd]A-cMm&9\%i0@O<FYnDAcaI6+4mC`au9]A$o3E1aBm`(*u(Y[_#SXltj7"A!J2(,?I1
H-a4PIo)5U-NV<#H-$O['b+%M/@,sZeI(Qq+Vm6U;L:\4AI%WYW7_7mge;K0kh]Ak,_^r.t\r
"^iJ_#S%.0%bgCFq6:dKZf_Z9NnN1f@eWNFA,0)fhPRj4mZ&FFQ0[naR\Mk-RK:$]AB\0Fl6I
Jk;pl@T8DU7f8AO1l9LCZXN1L2M%njCQ'`aZ&+/`"[_^[%@QV?NTp$_#r#=H,`Whk$._RL-k
[&#(2#f-_3+Pa.S,(bM+TJ@VBdOgn)Ye4>XYZ!!Y6Pe4OAB9Fn/q,TDiR:kS5H@-O'+HHN)p
!HiUD"r^oCB*=0.:;k/\O@S:'MH*gqjZ%SZsJ1@B=GT"4_(:UAs^gLOB#@SZY7?Y#Tcghhj6
`?&AffNeH?CRRN[q/kqBo,eU2iZmBE?(JICUPKNfkfjo\:H%^2;fV%KW^X&RQAl@4_44\-8m
oGu!$D+U<:)@Q9iPFqt@5@'o0MO=Q5g=,$`:1I`*8Xf8P[oJ9,4*#rEBC0!rrqsO2=?4bOcG
VJ#'D+$eXk1PR:P]AQlon*VW;Lc/`FEq>l+G5h#1`>c`OSoM*/3Sg]AOFA7$RlOXqUcs+W+Y+>
fcAf?^Q)V(ZZQ8LR1Xqp#"<LEh4J4p's_+tES?Sc]At_?9(sN4a/crGjc*A`J4&[UW8cr!NC<
((V+;3XSloB<1nT(ut0Cn)<W&6>u&pIhRpt^urf905L"a<o+2_uit/j2]A:Zs4&7#ak'KQqW(
KJSpUV6QkQr#bpju.u^&Pd/_8PpUs=]A*?>:16Q_lF,(N(X[7->0]A.=^3*_.ri-(rCF5TSNpR
9A/B<!\lZAg/HJApUJ@B94FbM\iM8Upk'-X(FTo;_#Z7I&:q!Ud)oJ'#ZK^iblnu46W<T-'W
Y*!`*-`&'W((aF"V"=L=25KE*Eb<S@LDUB&`nndiFfV4R4o:>:U[]A-6%mEGttI/T496gS%iq
Eo#+'1HbEU#dDEjS#3)Jp^8AAb]A^.eXWNGfn``YJ2Ng17GnX/8Wst02Ma#>IqS;TS/fhaMIB
8H`]A-*.mH\&hKr!8N5%!EMEfj%u_>3dJ2Chks^\JYbSU+-r^eM=5.-[:!E5ZAiXKXmqL%s=K
oLKpJ3]A<?J*FUN=i3hBahr&f=X9pjS'RCnX^WcRr+U]Aa_Z)/GO#"k#!Nid_3*ljM??DjYpCb
?+776VC7FBfj.E$D-oh,u:BBJO_Dn^"1oK@,d$)o.msW`)H+BBCK<\%'Hsf.Vt\dm5FKdb"j
,KCe4MQiq@(]AG;rUp*FM^/SAlqBm@`#W.#_q-FHdHY]A6Hh2QC&k-E1oXd$AKBlq9*3?W"4t4
]A(@uZ5KZ:IXs+C8f:-G-pB.IDC)L"BmVDc>JN@+`[cZLA(8MThpj`;*gB&oCq>RF$2>dVpZ:
F*N_(ndj#qXLHUb55ZR$(.BTEnW""%5[,PNa"!<F#tl[!6ZhnjQr4Q!W\E+F7fakcL3-OCt=
`3j4u=nWN]A9LOFe[@7:(oG04`WXIj"!l's_Tb!/6rlI2mYgFI"Fr^Mof-!RY'<Lr(anj"op4
))*JSj]A1=b5Y3im"qXS-pFt;g[njZRVBd4mQ+9n6b`cJ/Wl:Me?U+XLBq:t[>gZ)R7MIAH-=
a/Q0!.gJnU-eV3AU?MH#@^-W_K=8s:\67aVeR<3e(VS=XX^@5`Wr^E"-L=mn@2]AlY=EA(#Kq
?XqCN\bCaqZVR1A.7uA:+8rladp&"2'-lYc^DCVhF#0MGWDmc'bNGmhGCjLI74$1NEmG#/"E
djoIq1$X=Th'Q2(aai,`Xu/%j)Y+os%=-8msQ*!Yg`:QP$bSCO)pN6ZX^.dhKgE'Pd#$0UH]A
mD3,E,?O-U_:*:qtIB#b]Ae,8*pd!k-Jis1^D5B_sLrl#pT#_+ihUL)Aq\"t(gKp:]As_hNb!b
@0u"Bjr8F9lnJ5(Rj8`Ac_oiXq,fejIP\1r'(~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="66"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report1"/>
<WidgetID widgetID="e30e9d62-4017-4eae-bd3a-cf519abccd41"/>
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
<![CDATA[722880,722880,722880,722880,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3456000,2743200,2743200,2743200,720000,720000,720000,2160000,2160000,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="9" rs="4" s="0">
<O>
<![CDATA[标题]]></O>
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
<FRFont name="微软雅黑" style="1" size="160" foreground="-14540254"/>
<Background name="ColorBackground" color="-5318927"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G'E'3DbgDsQ5f[``O"lXuJ`)u[`"WE!It9_ML=-*cM`Ztg6slY<8$<h]A_U5a&ZXX6u^Y(F
#d`Z[Tjj/8MR!2Y*-7V2.tk`Dii-OXbnn!sp5<1.c*?:'.hd%!Q;d7.agc5f&X?kIfu'hY2<
Qo+$9HO,1"VSt#Q2Ue-bV#_.&@jJ5A2.?c)Ap"hM)MZ%)GhH@iiPP2'`?iBH^ml]A1OZ8h/Lj
.X4)>\n''bmdO,!Im\s'.Xlt4qGhaof(=P^GX8@qYk#F6ef)Vj56r1<;PAd;765!99f<4=6F
L/#labR^WHC"CRl>,^#3eNk0#>6CsX_;M/!'UZ_cjEWWK#m!G^m6e1gsH/SWck2?/[]A-)n6H
gX>,p<VjE%0,1MJ94(-B!11:\@.88Rc0Te[70i.dn&2P3>[C!j@S3D;B]A,tR@-j'lkJ^*S.q
bXsQW3<eLt6V\k0jOsK0mW!<l)-rfaeL-r\j-gC-m@FP.mFU48hnif5%RnNU(nOmd+`QJ-%Z
[%h(!PDS6s6rE0)ccElf-3UamrM`t&/ID0+)E3db-H]Ae<C5\r$-,c?qIlb8>Zn#SWJ*s/[4U
n%mJ\hmjkqXSL?#7'\!ItJK]A]A:".R:9Vg-?BC'*DR'+j4-CJM,eADQrh9H8g7Ju#Ci*mcKP#
TD]AS\5pb;6X#<qN:=DU`H2fS7c$hU2H:iE,6-q?@M0@lR-/@u2h:nZYu".>dLSgXK5*+K)8A
j\^5p>je5`"lNH@TTK!AWiYqU?-U?^B:qE\$UXX[#D@"fXPYn\n2m1-VhW,DOo"!$ltQ2V>7
9H*eL`hQ,.d`(rcGpQ2KStjXc?,:1TCNh=(;,2HAqdVNgiO+;iY,.hd]A>uk-$_8.?GU]ASn?X
ZDeA9A7Pia<Kfa0;l(RC^FXtudJWm9..(p03f]AY>VMn4]AbW-&V/IXU5oCjh!riTo$r&ekh7B
#\!(MCnYAT!@DNX?AT&"obmrViQ4tG(No%LpDUQ_gY6V/D48ABlUMW:^oG<HKE-OT+H3-0N4
E<q#-4;kbVpgWQNIbkU7@>@E@0CBi?O*?r'mXm'iK:JLYLSB*1#,1Nm\`l\tM+p:B&d"k'0t
Dag8T6qn?WB$Y';K\0YJo\=9YEq@:8=`5oQC]A(=VHbL(@Uf5_Nal]ARVQXYVT,os0N)jJqLf"
p9W)hV&7D0tT=F`gXh6^TA5!j=uK=DWutapQC1qD(XI^K/`dH@pWV_]AXuF1N(%oQa\[A$*ho
!U>+quD2k^.b;*1l#7OGUBR.qqXnR]AOVef'gX'1dT0OGE?pq'a5B7ird&H7fKn`2K_Y!8Ac_
t1!:$GOt2Y*tUt,@&2Pl[b+6)_ENB/c;Pj;6@@"h'=I"i&J-XBCiDJl-9\5hgoEM53=0*2lC
KZP2<dR:Y"W?+&ktfl`i0R]AA3E-U7JP3.Kj"GkklM!36L,/dCiAS@>B\u@.(;\I2YRdLr?=(
aVErY03C#R(1PX4*R1\8C/!=N\fc)!(Oj*KK)-#5gcEK!nH*<95r"*U;pLVtFEX"O"FBq+&2
X9KPLe7X_4>/Je,o>k`16YpW"=-8i%9dC]A]A"#L2nulqq9&[SX]A:pA[E=goRNCrF7t,B=DMpK
F;Aep;p"+@-"!Xp=?4Re1F8og`mU,TN0lL*K/:^V7c/%.>Gi$(fjX([_<0^UcM?iCT6a`O)2
%L*(:5Om@*Z_\XS7rj$C:Xu&;`RaTBm#LQOeG>O(13ZI8b'3h#&rsNs7=$8m5N:p::(GC8S^
KQq9MEPdN`E18fr.5eqFqkqm;1/o9%I<!L-`hY:oQh0\BWs&'p]A^;XFpBf%[%3+4RR)-M%)*
pYPUeU7Nh&S.kpBB?mtm`pbN-C$4,3Y3]AY5)P8*I9lSkGjj,3AX7Guno@0`AOd;0V9*SI_J2
;g(I)9^lhHd9bOg6rTE&Uf&cHLj";nBoj6d+cP7(q,,s0rl&B"I/DmeMsTX<RT&@=]AO[gB3P
qd+mt(\1c,!$9delf=m@.CVl,:f>FZc#9V"\B*]A6pNXlAM</B\`-u@ULO(Aed;_Kg!d7Al1o
@q_Qf(L%(iEH8<a-E6IHM'NZ@+0(sD/([WJ(&tUCH+gc+6SZtE/#;ONCV6L")ULne:p$/:f!
;bK]AO=QMY:XLl?*C$>(r'IWHKf;'2rg==q#I(g"!")AT_N:?dD-Ooh$fD2qg51&]A?62.g&HF
P)SQ!)1d>Cf,Y`Df/%5G:-YDG$]AI@]Ap_fE.cnXJ5i,J\C.Z'1f<Mof_@_bp@*JXCXTDf8>R^
'"1'\NE8if9cr(/)UXg9!B_Vug2Ql011K4sA<FVM&I3YEeV6@&[>TpDEnK;Bg"5q=_F87iQ,
2n++A.DMhZdC]A>>h3%6u-gR-`dc<JFVH=0C_2mg5G9"7d*lb&u8)mK(P0LrKVq5gV:6q!u\3
&d=tS&_,s(CUNuS:/Pa&%Qm1$c6LkT5,l-m0MRO*8iUbLDk/L:.neuK(OM>.IAO]A[6hF6@fV
;^+W46-`I3i<9o;^m3XRq&7<e20f1p+5knm*eUV%e:MBrll\MmDFK%Jq80T\I[Il3B)m3q1+
qhpsp56miCM(i53(!1QF["%XEV*6]A70T^n[<6KKQJb[]A3+<2>/^>L;8g:=RGZ+sq\dO:R=H]A
,S!meC'h9,8<lI=D?V,Z19$_-=`bqpNZCV'Bq+C!-ueNI1h,dD9JD>t:-R0.[QN>H@[dDJ$o
miA7?@IYT*4*T1Lp.L[%9RkY#@[?$!O_b.ELhU-,&.ZlW+ApM.NSV2E9*SRP`?$`ob+Bqun8
'`mj'q=C9HPgsN`0i;_\YQuNB.EfrY-r2>fW(k"]A6^#CF8Z;5Crl^oq8;VkY^u!'Q]A'"m5e<
9!EuQ^4fXWNI45!MC;i8lpQ8C\4><dF,(<`N.W-,b5P!9H%J`G%cFIJ;ZCg6Fe5OCnHmuGkr
FS/q'!O+tdb@7-abkN3H=,R,.@).)sEg?pIJb<\p\E^BYe&B3K]AZ9<>.J8L!GEO:E/,Q2HGc
-kN;UL_YmjNI*6iFHG'&?-6<R,3[`s)bEis.4&C$X&;G2kDRB_8>L]A-.\M1(]Adtc!=7ARD7a
kZ]Ar]AKSbjau2oAu#;K'GpqKfboZ]A0JD.&c^<CIEPV>OWWtaJ)Dbml.)?7>YXQ2i+n=Tg$`[o
(K[%)so5+=c+FA[M?!G@ki\b/nL^SMse1&k1U(q[)*@m2na1qk@#p,?BjGSWXbg-1VSV2TX4
Y5p9_N3b?5=B8jD_(!qgi3:/LI>=-&*EcLC?)BZJ1M#5$37#MH:jY4?A7@DOd\lU:_iD?hq\
V;_N7%M3X436F+]AZV@baD)m.8e^H?h+1bJWpiG"rB)5>3BiEIrc/CWk`T9]AW'kqCSLCkaZ7g
h1W]A?F1ad=W&A/Ec%`qq?ETT)fImr(aq]A_OpD,<-psaQZ+6He<_=3EG>>I]A*7dgIFhj8+cWW
gRo:2.HpAfNE7@F\dTl?Oru#V[((N20.`E.aj\D;7KjP$mAlIE-jjTGC*BdgW*;bnFW53`,I
i=EQd3/V=4Rd#?*65ua'2F4m&^=3F1U"$[k-tqZ[7)\XeS"ko"OE>fNt:Z$IH4?D(5nXiCju
?jX_<toWUBR!Jste8ZSp@BiSYua^TGU@;.:Q(Tn$>U3IC_f.*adkZ@7^dDusD*K5V.a<WFcI
%&9b%R:@rOVW(:7T+iuID-FHQP@4RRdiJ:M[9A\@]Aj?U:_78:!*5HZ"m1_Yf>9`KNCVh-jAo
U_MDkcR0$ES)'3LGF=YVJmE-^;(?fErE>rT]AY]AHOqQ7#<Mb?if9!XLBV/FC&[O&YrK,9'R!4
lbqsRm8<o$t#'i8.W9pOPUA[0D;.IU8]AlJ';/[-4f6LEn[U&&P/$M/%t;9;R*&-HdMk2$mH7
j_H`(LteZ`Go7B:+TR;nP#(e2Da-jf`rYu[\,Sb-sXNqd+Z2:E6>OdTGBGtA"VGuE:oiYY-I
R`c#g#G1/;q3k%+?<g"4Ii5?/Qa'F>3DImpK>BibG0qX:<!nVYho7Y!hQ@"?,$d-2D]A>5A2:
O#,0P%KV+!=O3'c3&HXu(jErorh`m9*FSmq"RW*F\+P/tGZZ:NhJ7NV8^YfgP9M!FVD^Pu'H
&P'@gg:u/3RCtU;:E-i=/o8UrTTD5A9*lI*X)E),f7LGgT10SMd->QT7gb!f,2aS<]AGoF0bC
$)j9R-EBXanJ7=]A4VJM]AEnd%h*_>6'5\>)HYRYD@+>Esu1H0djro2mJ:B!_fLRng"g0$"F2n
?,gds)#:cC('jDn^j%EFuXHmGYB1q[XGTn_C;3V-A1U:bM5=p\3lmE5WNS*_(s;]AES!t(CUL
A7CYn:Sd)!PM77@-tfU4o<aBt04Gud.3W@1l7;7=uToU)-H9(G0,XTj]A_+^51L&fr%O1&>qH
0*]ATMSk;Vtm4Q<LDnTp2a]AAZ_IX&)E>&p[V]A\IKYaKuTTeZ_I%YNnfWe#M's%D1,9Y?@Wgb<
gd=Bh=XZQhW*P>k(>YpPT:"XU2sEegg-/YNe"Ep[0nU)Q^8[[]AoAs%^5K\qgb@O5'olI,MI'
@IsAIYas,V94HOb;2qske[5q"[cR`$*>@2`;YFRBRH]A:W<.,'27(a^uCIpFK@qd#3*?=iu&H
c_UseZHDl[^<1Ko/>/hU&uJ2W<-Gr0!u?;r5Y$EimOL@+8jQl;=N'4(KPLVC=%T'NT@VDFb9
%&ihODBQ5XgJ:uZ`iLs3HP&4/O^AZ7W%::SDJSYp^RWdmjWa`uoITkfuXHWgk-mUAjklDssY
K@S]Aa@B)fAnZEKCC?4(P,h>5U_"IeA47V>c\o4E3MMm,ua0B8>()'t>_m#H+&2orq!g!tX74
?f7hi3]Am.JgP34>P=,&kE-6/5GJA%g@B\[U+sMR937up]A)s#LLRj_a8$e_DkquJT]A*S@kd;J
s<:utQ)<q1hg0%4V$]A%<noe1-?,S@Bbj-Xfri9W9B_NR<P\!t+:B%H'5=2[36@26g<d#!,_&
1khCi'/iDShM4K1P5'p/OEM\KH0):2g>oL(G(j8@_bVX66;GpUu1'4g[,%[Uh:40bGfKYaEY
_@;4cR&>I%ctD81S@94WYsS+Ab_EqdHmBM=Z%8<?W!N@\';.TfF)OUOZ!$%YA05[=u9lc4kP
NhQusDSfK0N`pC]ApJejEL8dnI[P]A+ag3,^C\Z6[u_>?LRhHf%&Z7ZtmI:un"4=WekW:N@u5)
3ZFdi9's*tK_j_hnEdl%bdWeNFW#B>.]A$[,*RH6<qnSG*1"%2la,^m1)D-,GT2+D\R%rWGL,
'ZPJB#:3%CfKQNMrZM59Hgp%NpAPTkR$4#gFff]A36C<jB&i')6APZrc:f@X,%Sh/98YNH"Ol
-g]A+Ch<!lA74#=\#?k!DJpnX5t\lr,,\1-FO%>8:`2Z:'pUMS9o.gc;RnDt*./0p"_3CciK;
Pl[X8ZUlZdl?R"Fb_nG@mNhsuIQBu,JP$BOi?;D3n2VS","a_LGW=uaYI^%VVm@8.9P@ica$
o@8]A3mM.c?nOq+d)\"M[a[*mfO\'/6`i"9E;r/s$?MtV,)V>2>Sc:?O-a&-Y^bgm?*@&Kn*'
Fi\3)gq43X7Q8T-gBp6#h``!"cKFnm7;\%;#<sR^FOs>Hdf2W=lED3K_X7Q40Ion-Vc'.I%W
uK[/Gu4#OfS>B_n#fho(u<!B@YH':-irV'tr38XBS&(T:.g)'<sDqk.-kB-&<Q(VQ*0r]AA0T
+$+('Fc%[F;06m-@T!mH`f:)#f4)[N/k#V-e4<HeETinlMo#W[P"!V8#U6(`;]AP(W89Y9]AR6
e\l_?VRU+2"[V6&oDVVV6_DfY&?f$')Pem.YqX_qVLk/HE@.NBMTnc^pXnB9)M"6q'^_JLQ9
:?Y5YDROgLOXfi"6DDr)rQ3[]Apn1P/,Z3+2nk6LGI&J]A'A\7S2RJLIYh6F_Kr'.$%B*V="AB
mc+;A;HEO]AZGUX$1beafs5ZMt+Ja`+qO2!#/N$+VU:b/I[>P2478KS(LD)6+3(I!1u`UcsS6
#(7GE&63@us70X]APcAQ5o_`H`&)e<\mO696jW%KEP^A,,7e1('%$Zm(J*ZoY]AmUb-[E8'OtO
fM7Smf66K!eNebk.A=?S/(;/"%X2=FV<DZaX"2`Oh_8:L=*L=mWNQAXuYA^=q1h,+tZN!EcL
%e#<?-bEqf6D,<kQLObN,BGaq8u4u0M'UhIEikM^i1[Dn4>Z,!k[OG)0m2>FX)i$e'D`itli
iD)8a!c0Z?j]Ad@RARXFO`/UeqGMhXJ-93O&aU&nbdVg\0i0SCP.j'Z"d3rbg-NV/CHd(8\]A[
/[#oWnZM,e?N'F<+Otn.!HKfcp'u?uo:13tk@+E4&7NKUI(m=Pp@4]A[/Jm.h$Ps8IQ[!Z4[D
D;"%Et]AeSdMOVWcd4\S<U>M>Oc/<BAKo0ibRWUM8N"91bc**is0"M@e+C*]A`KMI<FEo\G/ZQ
'3s!cLZ%@"Bn5%M9L")S^QSr$5"7-cZi1B8G(r)b3^\G$i0@aToMT_(Bg-7.Md+;ioY/L/5*
qqm>3!O?[euN6Hr\A/TH8GdCMa\)WW0kFp"63[Ih!TMI<#.K=-D.kJ='Q]A3<Atg^$f'p_2Jh
3VY,(Q:l]AEHncn3\"9S_T.u^J6FTHU2;(c)'DYb$>l&VYRUc6bIEV;.([A^q\*J7mjnf2c)'
`s>rND+(dltUJnuC(0L[QH>n9-S]A5IQWF`EYYe@4_G4ZEp<)(<mOR#t\D289I%fKhPBJGu6*
u.9H(3o\pW$TcGSXWnNMTpXmBq4*b<'QUnf/Oi^L8d#X9J3rnk&,f7aInn:<lMSLM?A)9/,+
mp-ZSV]A^g[7/'X1.;8BO9BG+$WV*,DBm!Q28M$r,E#NgG8!jUTV%=Win[@`;D>0=++9@0'6F
1C$J@e]A*pVB1cb&%h)sc;2b(Q"EF+YR_l^eVC*I,)*##)\`qW?KjejIFlUjBXkXXbu1ULO>o
o!*PbfA/+;S@OcUJE]AJ-fS+LX2#QO,GB2STW'G"?s#aW\_j"/He2,-C')ad);dVP4AN+bPNG
<T&oQ@+Y-$F#*?<=ih(ujklMXP'=cB,.TpH/5h==$L.:?3q-rNe-0L<f<mAn?=o9[aU4%<R4
:33=tTrI&>O5#%+[b=$dg$K69BbX6d&SX+7ISg1?fn4&fm&,gl.n\\@hfg!3-RW_FY(eD?r$
t6-.H.\h=UR@Dk'EuhfEn-&'r"[l+gP-Rd%%sCB'.bV'niD-]AoJ#,h?,i%*DtPElFL,]AnM]A]A
r]A/HUV0bP9r8BBNl^&mA;<7I=-DlkjrFo#o,;@d42@%[#HkX5VsnPos'[F#ihS)cI*en%chG
mfHO7i=PM5X'70b)A@@5s#cel3*UH&#U$E2#4[RZc4Sc(<TOe/$cbjVZ6.N"Br!9p(VSt:5t
>J>B,#*Tj7,qA'fY`A>(O=W!rZ@BKnBGcQ\a$B\ei\/SXP6t"0sD[-&Acjll6dsfP5T/bjT=
9PXVW"1t5-jU!?:-S(Q7^81QU0<gBLPU-`J*QYF-]A\<NPNc)C)3a$$ON*(iS*>=6VK*/n#VP
@fh&1b`;&AS5@&emk^f'F`E/Q"[@m_ca,_MSd.aD/M83NIQ"'V$0mLU4/n6>L<eN?)nt;<tQ
,$'ofDXrJ@VHC(:R6q8rZ\#^h>aDP]A[VgW%$BN\_dmC=mYldaIoCf<^`EU,s>3;SBG?Xk8:c
fQZq@R/\5;i3-MIb7n;c1>jGme:;00i$8LJAhg]A&hK;!q#pC@[#@.3BM>0<<%XP4lXFu]AS&.
l8XV@;cid#JeiIElo@TlM-PkFFNj*Ps3`VNHJP9&VQ3>qUcsn\JaDl7]A^UpHI,;6]AlEh"-\/
c3_H$gkbm-l!<kU;:+)8FDGf0(?RtEjil#5P?*!/dSdNSqf.(gZ1IZ_k//>rC3WrlZf[Zr3E
u`;&:*gkf.=Y)Z/rYfL@i/%U>qHP@]APA.)im1[23ShHBd;]Ani3p[SW7@*cK6LFO43KT4YOu=
5bR/P[;?90W\G-C1N#K\sR5n^RT)%IsZ`->jifN!t"H+-:7*%kT3lWu:V[WZ`c&KQ7-9Q_"u
X[D",_\!kOiRYBU6qfk&#S5"?JVJ1*@[E'E6='BP#NBHn1=1t]A8!SWh6l/#3J9>tg(l6B1L-
B4J(9Hq;MR3pBU"V5*3#Ppa/4YESJ__>MUY(r"__0KfT*E(^"lf;MJ59;=N=ctV>Hqiod".Y
'80AYW+Eeb+,$lXg(]AM^@lB#a0cp8a^l!pI%k(Q@q'GZYC^_=Sl12$\B!'[M2(KZ_7"rcI\?
LTKnd:HJ85kK=D.f0!h/.WK15sdA$]AFr3`/)Z8\J/NU.:E71G1"oj0r\o9tF*+eo.Hh<^5q[
JQGd5gJ;to]A$5ZEMMISSmZ0oDh7lQXFbPi+__VItlJdFVG"UembnAu'2O$*@S9r(-U]Ad<U!8
[$IOu7.[[^fDbOa/tM]Alqb*3B>_`<DF?FT7aFCQ3Xmm/GI8M?%h^,Bg?6Pb--M+hoD/PeX.@
("8M6TS5Ql5kb:Cpj9^!0hV,-I!l,;!9!\C;UkP3A-`fpo\L"&8ZSM&<qP`n_&UUM%2u,3OL
C&g:92RHJaUWu-5DKW9RL^;,Lm^rHN)&%>(kAd]A\2\N328""+6W79AH!fBc76D'PC+k+fQ,)
)80\"8u@J/moMMUG@R\PS#Cp%8=^C/m1RC<YFfB;D;.*DX9k=U,\Xi/je$mj_HOoPH(Eu&F)
:hHMB5.Jg49@pI[?!^-Hdf8rdhU4lQ(9#BA%=Es\%\JL)QZl"p7m&#d[A2>'d"\N:+tXdINX
:M0;e0H%<:-+:1+bYX*Pd)nsh>8X?Q_dY!p%r\#-c#Ct>317to-eM$RCuQ0N`i,UUeV_^3[8
N-gQlQ%>$egB\D(G$-<Dd@6LVWp+Dgq_k&eG=/%[+BQgBT'hmm<,1;EdamaWm%D/<q,6neIg
J#qnq/=sQG"KfI12lS-mGOTPQ@^=j2II_q)3'OF/,oRg9T.+DgB.8ZMl*A[F:C5<n"<8`mGM
u1BA]A<m4G&muUaq!hoOZl_N]Ae?9_HaA7P'@hf/;j+$q7Od7?/hk;9ZG]A9sn.X!6fj5N)_IPS
9A"'=I,Vp:FI$!A+[4Cg8]AFtT0&#dgtE4!`?>_OJTjI$YFVBtQfh",/8j9+o6iU79B>1<Z@>
=_m@%.J)K)5]A<=:"MI<OPR?#J`#.-T6`COtOL\nRLsSo)ebK)KNd`9t"^NCVW?U=i.V'gu<G
IKYm;4bEdjj=.C_XJQ4fS,sU`n/a"!&NE6Q!n5@"2U/(`?3=VJ93.CI5#GVlLB,=9M2S4L?W
`$!/>iO!<udCA/%`G>KdUY$mQYBd@op7%(@Ys%A4&[.*MdaHUg)@.GKK&52)UdZ^PL:k=hS]A
n8urF^7_=4$Xb*7(O;%0,&Qm+@]A,K-CcRU#`3h6nN;&uMN^VJ/do:5<1UD1]A4RkPX*OC%rZ@
e)fUqXj&Z`ZoqtI`%#6~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="66"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="true"/>
<MobileWidgetList>
<Widget widgetName="标题"/>
<Widget widgetName="指标卡"/>
<Widget widgetName="tablayout0"/>
</MobileWidgetList>
<FrozenWidgets>
<Widget widgetName="标题"/>
</FrozenWidgets>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0"/>
<AppRelayout appRelayout="true"/>
<Size width="375" height="749"/>
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
<TemplateCloudInfoAttrMark class="com.fr.plugin.cloud.analytics.attr.TemplateInfoAttrMark" pluginID="com.fr.plugin.cloud.analytics.v10" plugin-version="2.2.0.20210728">
<TemplateCloudInfoAttrMark createTime="1629100442220"/>
</TemplateCloudInfoAttrMark>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="ab5156a9-1ca7-48bf-ad8f-44f779ded4c0"/>
</TemplateIdAttMark>
</Form>
