<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="分月" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
      a.年份,
      a.月份,
      concat(a.年份,a.月份) 年月,
      f.月度汇总 航班量月度汇总,
      f.月度最高 航班量月度最高,
      f.月度平均 航班量月度平均,
      a.在职人数 全司在职人数,
      b.在职人数 地服体系（三地）,
      c.在职人数 机务工程部,
      d.在职人数 运行控制部,
      e.在职人数 飞行部
from (
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'在职人数' 关键岗位
,sum(cast(zz_num as signed)) 在职人数
from air_szh_fact_ry_rc_month
where type_code='全司' 
  and month > DATE_FORMAT(date_sub(date_sub(curdate(),interval 1 day),interval 12 month), '%Y%m')
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
group by left(month,4),right(month,2)
) a 
left join (
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'地服' 关键岗位
,sum(cast(zz_num as signed)) 在职人数

from air_szh_fact_ry_rc_month
where type_code='部门' 
  and month > DATE_FORMAT(date_sub(date_sub(curdate(),interval 1 day),interval 12 month), '%Y%m')
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
  and stext_lv1 in ('北京基地管理部','地面保障服务部','杭州基地管理部')
group by left(month,4),right(month,2)
) b on a.年份 = b.年份 and a.月份 = b.月份
left join (
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'机务' 关键岗位
,sum(cast(zz_num as signed)) 在职人数

from air_szh_fact_ry_rc_month
where type_code='部门' 
  and month > DATE_FORMAT(date_sub(date_sub(curdate(),interval 1 day),interval 12 month), '%Y%m')
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
  and stext_lv1 = '机务工程部'
group by left(month,4),right(month,2)
) c on a.年份 = c.年份 and a.月份 = c.月份
left join (
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'运控' 关键岗位
,sum(cast(zz_num as signed)) 在职人数

from air_szh_fact_ry_rc_month
where type_code='部门' 
  and month > DATE_FORMAT(date_sub(date_sub(curdate(),interval 1 day),interval 12 month), '%Y%m')
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
  and stext_lv1 = '运行控制部'
group by left(month,4),right(month,2)
) d on a.年份 = d.年份 and a.月份 = d.月份
left join (
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'飞行' 关键岗位
,sum(cast(zz_num as signed)) 在职人数

from air_szh_fact_ry_rc_month
where type_code='部门' 
  and month > DATE_FORMAT(date_sub(date_sub(curdate(),interval 1 day),interval 12 month), '%Y%m')
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
  and stext_lv1 = '飞行部'
group by left(month,4),right(month,2)
) e on a.年份 = e.年份 and a.月份 = e.月份
left join (
select
      substr(运行日期,1,4) 年份,
      substr(运行日期,6,2) 月份,
      sum(cast(总执行航班量 as signed)) 月度汇总,
      max(cast(总执行航班量 as signed)) 月度最高,
      avg(cast(总执行航班量 as signed)) 月度平均
from (
select 
      date_format(reportdate,'%Y%m%d') 简报日期,
      date_sub(date_format(reportdate,'%Y%m%d'),interval 1 day) 运行日期,
      planflightallcount 总执行航班量
from rpt_flightruninfo
where date_format(reportdate,'%Y%m%d') > DATE_FORMAT(last_day(date_sub(date_sub(curdate(),interval 1 day),interval 12 month)), '%Y%m%d')
  and date_format(reportdate,'%Y%m%d') <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m%d')
) t
where 运行日期 >= '2020-10-01'
  and 运行日期 <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y-%m-%d')
group by substr(运行日期,1,4),substr(运行日期,6,2)
) f on a.年份 = f.年份 and a.月份 = f.月份
order by 3]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="当月在职人数" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
      a.年份,
      a.月份,
      a.关键岗位,
      a.在职人数,
      date_sub(date_format(a.更新时间,'%Y-%m-%d'),interval 1 day) 截至时间,
      a.在职人数-b.在职人数 环比,
      a.在职人数-c.在职人数 同比
from (
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,load_tm 更新时间
,'在职人数' 关键岗位
,sum(cast(zz_num as signed)) 在职人数
from air_szh_fact_ry_rc_month
where type_code='全司' 
  and month = DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
group by left(month,4),right(month,2),load_tm
) a
cross join (
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'在职人数' 关键岗位
,sum(cast(zz_num as signed)) 在职人数
from air_szh_fact_ry_rc_month
where type_code='全司' 
  and month = DATE_FORMAT(date_sub(date_sub(curdate(),interval 1 day),interval 1 month), '%Y%m')
group by left(month,4),right(month,2)
) b
cross join (
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'在职人数' 关键岗位
,sum(cast(zz_num as signed)) 在职人数
from air_szh_fact_ry_rc_month
where type_code='全司' 
  and month = DATE_FORMAT(date_sub(date_sub(curdate(),interval 1 day),interval 12 month), '%Y%m')
group by left(month,4),right(month,2)
) c]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="当月航班量汇总" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
      a.年份,
      a.月份,
      a.月度汇总,
      a.月度汇总-b.月度汇总 环比
from (
select
      substr(运行日期,1,4) 年份,
      substr(运行日期,6,2) 月份,
      sum(cast(总执行航班量 as signed)) 月度汇总
from (
select 
      date_format(reportdate,'%Y%m%d') 简报日期,
      date_sub(date_format(reportdate,'%Y%m%d'),interval 1 day) 运行日期,
      planflightallcount 总执行航班量
from rpt_flightruninfo
where date_format(reportdate,'%Y%m%d') > DATE_FORMAT(last_day(date_sub(date_sub(curdate(),interval 1 day),interval 1 month)), '%Y%m%d')
  and date_format(reportdate,'%Y%m%d') <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m%d')
) t
where 运行日期 > DATE_FORMAT(last_day(date_sub(date_sub(curdate(),interval 1 day),interval 1 month)), '%Y-%m-%d')
  and 运行日期 <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y-%m-%d')
group by substr(运行日期,1,4),substr(运行日期,6,2)
) a
cross join (
select
      substr(运行日期,1,4) 年份,
      substr(运行日期,6,2) 月份,
      sum(cast(总执行航班量 as signed)) 月度汇总
from (
select 
      date_format(reportdate,'%Y%m%d') 简报日期,
      date_sub(date_format(reportdate,'%Y%m%d'),interval 1 day) 运行日期,
      planflightallcount 总执行航班量
from rpt_flightruninfo
where date_format(reportdate,'%Y%m%d') > DATE_FORMAT(last_day(date_sub(date_sub(curdate(),interval 1 day),interval 2 month)), '%Y%m%d')
  and date_format(reportdate,'%Y%m%d') <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 1 day),interval 1 month), '%Y%m%d')
) t
where 运行日期 > DATE_FORMAT(last_day(date_sub(date_sub(curdate(),interval 1 day),interval 2 month)), '%Y-%m-%d')
  and 运行日期 <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 1 day),interval 1 month), '%Y-%m-%d')
group by substr(运行日期,1,4),substr(运行日期,6,2)
) b
]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="简报航班量昨日" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
      date_format(reportdate,'%Y%m%d') 简报日期,
      date_sub(date_format(reportdate,'%Y%m%d'),interval 1 day) 运行日期,
      planflightallcount 总执行航班量
from rpt_flightruninfo
where date_format(reportdate,'%Y%m%d') = DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m%d')]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="每月运营飞机数" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
      a.月份,count(*) 运营飞机数
from (
select 
distinct month 月份
from air_szh_fact_ry_rc_month
) a
left join (
select 
      ac_id 主键, 
      ac_op_date 运营日期,
      date_format(ac_op_date,'%Y%m') 年月
from dim_sh_aircraft_info_df
where status=3
) b on a.月份 >= b.年月
group by a.月份]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="222" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="dept"/>
<O>
<![CDATA[全司]]></O>
</Parameter>
<Parameter>
<Attributes name="start_month"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="end_month"/>
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
      a.*,
      concat(a.年份,a.月份) 年月,
      b.月度平均,
      b.月度最高,
      a.在职人数/b.月度平均 人航班比平均,
      a.在职人数/b.月度最高 人航班比最低,
      a.在职人数/b.月度最低 人航班比最高,
      case when a.关键岗位 = '机务工程部' then a.在职人数/c.运营飞机数 else null end 人机比
from (
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'全司' 关键岗位
,sum(cast(zz_num as signed)) 在职人数
from air_szh_fact_ry_rc_month
where type_code='全司' 
  and month >= '202001'
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
group by left(month,4),right(month,2)
union all
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'机务工程部' 关键岗位
,sum(cast(zz_num as signed)) 在职人数

from air_szh_fact_ry_rc_month
where type_code='部门' 
  and month >= '202001'
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
  and stext_lv1 = '机务工程部'
group by left(month,4),right(month,2)
union all
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'地服体系(三地)' 关键岗位
,sum(cast(zz_num as signed)) 在职人数

from air_szh_fact_ry_rc_month
where type_code='部门' 
  and month >= '202001'
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
  and stext_lv1 in ('北京基地管理部','地面保障服务部','杭州基地管理部')
group by left(month,4),right(month,2)
union all
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'飞行部' 关键岗位
,sum(cast(zz_num as signed)) 在职人数

from air_szh_fact_ry_rc_month
where type_code='部门' 
  and month >= '202001'
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
  and stext_lv1 = '飞行部'
group by left(month,4),right(month,2)
union all
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'运行控制部' 关键岗位
,sum(cast(zz_num as signed)) 在职人数

from air_szh_fact_ry_rc_month
where type_code='部门' 
  and month >= '202001'
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
  and stext_lv1 = '运行控制部'
group by left(month,4),right(month,2)
) a
left join (
select
      substr(运行日期,1,4) 年份,
      substr(运行日期,6,2) 月份,
      sum(cast(总执行航班量 as signed)) 月度汇总,
      max(cast(总执行航班量 as signed)) 月度最高,
      min(cast(总执行航班量 as signed)) 月度最低,
      avg(cast(总执行航班量 as signed)) 月度平均
from (
select 
      date_format(reportdate,'%Y%m%d') 简报日期,
      date_sub(date_format(reportdate,'%Y%m%d'),interval 1 day) 运行日期,
      planflightallcount 总执行航班量
from rpt_flightruninfo
where date_format(reportdate,'%Y%m%d') > DATE_FORMAT(last_day(date_sub(date_sub(curdate(),interval 1 day),interval 12 month)), '%Y%m%d')
  and date_format(reportdate,'%Y%m%d') <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m%d')
) t
where 运行日期 >= '2020-10-01'
  and 运行日期 <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y-%m-%d')
group by substr(运行日期,1,4),substr(运行日期,6,2)
) b on a.年份 = b.年份 and a.月份 = b.月份
left join (
select
      a.月份,count(*) 运营飞机数
from (
select 
distinct month 月份
from air_szh_fact_ry_rc_month
) a
left join (
select 
      ac_id 主键, 
      ac_op_date 运营日期,
      date_format(ac_op_date,'%Y%m') 年月
from dim_sh_aircraft_info_df
where status=3
) b on a.月份 >= b.年月
group by a.月份
) c on a.年份 = left(c.月份,4) and a.月份 = right(c.月份,2)
where a.关键岗位 = '${dept}' 
  and concat(a.年份,a.月份) >= '${start_month}' 
  and concat(a.年份,a.月份) <= '${end_month}'
order by 1,2]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="起始时间" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select distinct month
from air_szh_fact_ry_rc_month
where type_code='全司' 
  and month >= '202001'
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
order by 1 desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="结束时间" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="start_month"/>
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
<![CDATA[select distinct month
from air_szh_fact_ry_rc_month
where type_code='全司' 
  and month >= '${start_month}'
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
order by 1 desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="人航班比人机比" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="start_month"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="dept"/>
<O>
<![CDATA[全司]]></O>
</Parameter>
<Parameter>
<Attributes name="end_month"/>
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
      a.*,
      concat(a.年份,a.月份) 年月,
      b.月度平均,
      b.月度最高,
      b.月度平均/a.在职人数 人航班比平均,
      b.月度最高/a.在职人数 人航班比最高,
      b.月度最低/a.在职人数 人航班比最低,
      case when a.关键岗位 = '机务工程部' then c.运营飞机数/a.在职人数 else null end 人机比
from (
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'全司' 关键岗位
,sum(cast(zz_num as signed)) 在职人数
from air_szh_fact_ry_rc_month
where type_code='全司' 
  and month >= '202001'
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
group by left(month,4),right(month,2)
union all
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'机务工程部' 关键岗位
,sum(cast(zz_num as signed)) 在职人数

from air_szh_fact_ry_rc_month
where type_code='部门' 
  and month >= '202001'
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
  and stext_lv1 = '机务工程部'
group by left(month,4),right(month,2)
union all
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'地服体系(三地)' 关键岗位
,sum(cast(zz_num as signed)) 在职人数

from air_szh_fact_ry_rc_month
where type_code='部门' 
  and month >= '202001'
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
  and stext_lv1 in ('北京基地管理部','地面保障服务部','杭州基地管理部')
group by left(month,4),right(month,2)
union all
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'飞行部' 关键岗位
,sum(cast(zz_num as signed)) 在职人数

from air_szh_fact_ry_rc_month
where type_code='部门' 
  and month >= '202001'
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
  and stext_lv1 = '飞行部'
group by left(month,4),right(month,2)
union all
select 
left(month,4) as '年份'
,right(month,2) as '月份'
,'运行控制部' 关键岗位
,sum(cast(zz_num as signed)) 在职人数

from air_szh_fact_ry_rc_month
where type_code='部门' 
  and month >= '202001'
  and month <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m')
  and stext_lv1 = '运行控制部'
group by left(month,4),right(month,2)
) a
left join (
select
      substr(运行日期,1,4) 年份,
      substr(运行日期,6,2) 月份,
      sum(cast(总执行航班量 as signed)) 月度汇总,
      max(cast(总执行航班量 as signed)) 月度最高,
      min(cast(总执行航班量 as signed)) 月度最低,
      avg(cast(总执行航班量 as signed)) 月度平均
from (
select 
      date_format(reportdate,'%Y%m%d') 简报日期,
      date_sub(date_format(reportdate,'%Y%m%d'),interval 1 day) 运行日期,
      planflightallcount 总执行航班量
from rpt_flightruninfo
where date_format(reportdate,'%Y%m%d') > DATE_FORMAT(last_day(date_sub(date_sub(curdate(),interval 1 day),interval 12 month)), '%Y%m%d')
  and date_format(reportdate,'%Y%m%d') <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y%m%d')
) t
where 运行日期 >= '2020-10-01'
  and 运行日期 <= DATE_FORMAT(date_sub(curdate(),interval 1 day), '%Y-%m-%d')
group by substr(运行日期,1,4),substr(运行日期,6,2)
) b on a.年份 = b.年份 and a.月份 = b.月份
left join (
select
      a.月份,count(*) 运营飞机数
from (
select 
distinct month 月份
from air_szh_fact_ry_rc_month
) a
left join (
select 
      ac_id 主键, 
      ac_op_date 运营日期,
      date_format(ac_op_date,'%Y%m') 年月
from dim_sh_aircraft_info_df
where status=3
) b on a.月份 >= b.年月
group by a.月份
) c on a.年份 = left(c.月份,4) and a.月份 = right(c.月份,2)
where a.关键岗位 = '${dept}' 
  and concat(a.年份,a.月份) >= '${start_month}' 
  and concat(a.年份,a.月份) <= '${end_month}'
order by 1,2]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
</TableDataMap>
<FormMobileAttr>
<FormMobileAttr refresh="false" isUseHTML="false" isMobileOnly="true" isAdaptivePropertyAutoMatch="true" appearRefresh="false" promptWhenLeaveWithoutSubmit="false" allowDoubleClickOrZoom="true"/>
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
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="absolute0"/>
<WidgetID widgetID="7a51c686-21eb-4853-8aa8-befb940e7cf0"/>
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
<WidgetName name="部门筛选"/>
<WidgetID widgetID="2ee9a67a-6fcb-4a62-ad0a-6a8674daa919"/>
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
<![CDATA[部门筛选:]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="2" autoline="true"/>
<FRFont name="微软雅黑" style="0" size="72"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="6" y="42" width="72" height="26"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ComboBox">
<WidgetName name="dept"/>
<WidgetID widgetID="af6ea96d-be70-4b7a-83c5-5bfefbd779f6"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="comboBox0" frozen="false"/>
<PrivilegeControl/>
<MobileStyle class="com.fr.form.ui.mobile.DefaultMobileStyle" isCustom="true" borderType="1" borderRadius="5.0" iconColor="-14701083">
<Background name="ColorBackground" color="-1"/>
<FRFont name="SimSun" style="0" size="96"/>
</MobileStyle>
</WidgetAttr>
<allowBlank>
<![CDATA[false]]></allowBlank>
<fontSize>
<![CDATA[10]]></fontSize>
<Dictionary class="com.fr.data.impl.CustomDictionary">
<CustomDictAttr>
<Dict key="全司" value="全司"/>
<Dict key="机务工程部" value="机务工程部"/>
<Dict key="地服体系(三地)" value="地服体系(三地)"/>
<Dict key="飞行部" value="飞行部"/>
<Dict key="运行控制部" value="运行控制部"/>
</CustomDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[全司]]></O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="78" y="40" width="222" height="32"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="开始时间"/>
<WidgetID widgetID="2ee9a67a-6fcb-4a62-ad0a-6a8674daa919"/>
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
<![CDATA[开始时间:]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="2" autoline="true"/>
<FRFont name="微软雅黑" style="0" size="72"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="6" y="80" width="72" height="26"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ComboBox">
<Listener event="afteredit">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[null]]></Content>
</JavaScript>
</Listener>
<WidgetName name="start_month"/>
<WidgetID widgetID="df9596c8-4138-427c-9015-d5f5faa19563"/>
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
<FormulaDictAttr kiName="month" viName="month"/>
<TableDataDictAttr>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[起始时间]]></Name>
</TableData>
</TableDataDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[202010]]></O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="78" y="80" width="144" height="26"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="结束时间"/>
<WidgetID widgetID="2dc79a56-ad16-483c-a8da-502002f37763"/>
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
<![CDATA[结束时间:]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="微软雅黑" style="0" size="72"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="228" y="80" width="72" height="26"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ComboBox">
<WidgetName name="end_month"/>
<WidgetID widgetID="b57511ed-da13-4a65-a9b9-e9509abe520f"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="comboBox1" frozen="false"/>
<PrivilegeControl/>
<MobileStyle class="com.fr.form.ui.mobile.DefaultMobileStyle" isCustom="true" borderType="1" borderRadius="5.0" iconColor="-14701083">
<Background name="ColorBackground"/>
<FRFont name="SimSun" style="0" size="96"/>
</MobileStyle>
</WidgetAttr>
<allowBlank>
<![CDATA[false]]></allowBlank>
<Dictionary class="com.fr.data.impl.TableDataDictionary">
<FormulaDictAttr kiName="month" viName="month"/>
<TableDataDictAttr>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[结束时间]]></Name>
</TableData>
</TableDataDictAttr>
</Dictionary>
<widgetValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=format(datedelta(today(),-1),"yyyyMM")]]></Attributes>
</O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="300" y="80" width="144" height="26"/>
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
<WidgetID widgetID="09e9f3ac-4811-4bf7-a4ee-115b4d4c6645"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-855310" borderRadius="0" type="0" borderStyle="0"/>
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
<C c="0" r="0" cs="7" rs="2" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=if($dept = "机务工程部","   "+"人机比/人航班比","   "+"人航班比")]]></Attributes>
</O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="true" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="1" r="4">
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
<FRFont name="微软雅黑" style="1" size="96" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<s=d'6h%%h:?^M]A%ZOt7#aOFh:8n:,&2`9,hl@>/Lmmr="cgJ`AAc97'p3>ZaLk-8k_Ba$-
FR[;OY0K;M'F(P-cW/BnQbj0bBLWK]A/@2E[00r'<HOO9U_)5CX;hPLOK:\hjO;SchkB$H^XZ
fCKi^pDYBgX1M4l+h8[43gH&ia9Z2l-O$E<,?UI%dJ'$A'A&c+s2QhDkNJsTo*q&j6_<T@1H
F>8[,1No.<D+UR2j^=FH8fd9U-l,44CdM8[sHou/RCR1LXfaS]AlEoEO4Nq%"Pi8J/(6n8rUk
3ch`i#S?l=8,Qi'Fk"iiHJjT&slKAuZ['OCTj5`-`?/5oh8C0jUpKAOiK/@La*fVqM!?e@o3
0B(^iomAjJ.VS5g4]A-WunWp\LJMn%'MU@*;]AWtr/0^#e5bWAY$n+RgK-f3>_9HI@`5-<S/jQ
F2LC.d*Uk^7]Ap`>rs,"boS>jImf49;?ZR]Afbs9a%<4N%(pUUaGi,5ru!\>D$J]AlZnXJRk3CH
k*%,SE8sEY0ce#Yjc_Q2^5Z!Z?Z>"&67']A\?1G1dHkW!k4OmqAr$pk<?+PSiA@d&-MJmu7`2
jV]AjG:cCY(d;-R<S:7j=E/nOAlnel#1C5K6plIIf<LF4UK<>a[^!1rq0QA!1o<*%(Oe0#$2l
)KK)DA[EmV/:n]A'k&Im:IZ72gc,$:O+_UE.Z\KI.`!&S3?"d!=B=oCUDoV-KS2pr2I-Q?,p7
8n);2U11Wl1n[Q\'-D')+2B>-\QK=5En0Mqm$Hh`-\WtG4]A=Rc<a:eF;CTnEQKX3979-f!h#
gZb9*'q/lb(V__mR4,Z'78')uG_]A/^3l5:+_o6Plk0l[Q(AS"E^')qGo1`\;8\++,o+c,7k/
_jJp.P,]A;q0n1+JJcjeTi@jtG_#9gYI3od;ej;TZ<eI,(C/CMmRBNJf.P+`C3$gB)3JTP=@i
LMAJ@HWd@!1%3daB=6UXcW?>s-oG4ndq5J"sJ\<\4VR:1>E!NgInhAbJbc5"53jgE3Q%)>rG
SY&sQc.XrBEPh6@86%G--dd.&+Z`efc6j6EIpclQ[@8GfH]Ac-<GVm$us3_d:JD>SW^m7['s3
r_R,SR]Ah-4Y70ST:jJ3:@abfY?XZCfD^McsdA3IN+e#co@Sd&aXX1SK7pA#JR#2g6B8N7iA>
EH]ALMe-94HNA=T?@5coA$;0Y#e_d,>5#4IPom`LDA#g75V'7Y%n8KU_m-r7]AP*Zk*6&iW,u1
n:9EZ5XFor+UI!<&kIZKajmP2PZRp)7"=SVCEbmaXKs*M*&,l5YYohM`;jSUIYi3atF\KjbD
dr:JqG_4FE"tI'1gFUpFI8SHSY9j6mg!<o1$[U[*(suJrU!H@@otHnj"/Vd)O9eDFtL)?Er3
u+13"2!51e.)/DbguKiW1+Z9lN]A3RB'r=$RN%P&6jQ&KAu[39Wc^:10?E8($knf^;gC>jM]AR
*?b6gWucf(`;keGjl/60;>*_*QNJ[\cW`9ZdP9Vg&Hs?+%oq2J6UrmZ)+u=\2J$k\A39Z<[.
`'9O^Lbn@q/(2GKJ+7T4a]ADjg3UVCHs7;'+BC)I!bU>`8"2.TG=-QfqAJf#6D@\4bWrB)ERD
Ij&9I6+_gDbq3$*g7XI:j%dFeeSJAllJWcc4>Ahd%LMV"k:j*iu_mB%UBlWi(]APNc8")>hs!
psLXKaO<HD_B;Sg7Ad`BLWo;:Rj9s4<\0ap(VIT*2&u7$8cKaViD%`!3oQfS#NWmGcUIL[-;
1[AX$b%2'gXAVVZD'fJT"]AWS0qX4`&MK(^+[c$VObE?H?`/mD9:4\IH1aV)-5E30PAH(kbF/
eEoEcGL'%!_^AWqC*YQM$W7P?o80DlU32Mr-h'nT'ul&%Pg-d3b@#_8?dR<5lI3m[8umZA?H
h:,J?>.N,HRdt[R">Sh54JCQF&HsC.cLZ=*NjaC`Te.BVi?a&h"RI+*i557dAofD*/iK82P,
YEr9T2F803>Wm-2Sfk:H/IVD:GVp"Yj#$a+!C)F,o>d#3=.4JJND=CVqNgYd1CrpaIN/C5:,
[+2FrM@&ESRm.8-OgN.+bN?6K88S'Bq);l;2'Hd,^!Xnc"7B1q4tm+<-,C3[@8Ff-6f<5mqk
XF=KVClWMHfFBM#XEnuY'78s8QdX`4L$`<G#+35m#`f_<Dep'D-Zl'sbg`<,(QX"9TV]AZ-u!
NmkB!5etfbqlr9nfS/=IN2eNFdYu]A5^;IKten:%F0]AsK'oT\Ah8Tpe"Y[hK/?E*aqY*1Y^Ro
T!QjiHa5J-5#h$5N7h+VN"qg!,i#lBidp%??1B[^H$S=FhFBLs::B)/lpq7]A@]ASb/Z*BC3q0
3f4"-r)Kg:9Z!SZ2cdOZ8&"9G(@SpnU$C)3.R-87.du59k=8V!N\<1dr.#/Y]A?\$.5.7$/,"
W'n$+G^0<rgbV$#@VXe`f:3:m!,iB(RVVZ,,qco1m))q;1r,A3LU8I,c!F[n[q$%fH\(CZUW
J`Z<.k7LZT,*]A?GRnVSp:5nM$^`BuW/fei$,(=eQDcDpDNhQ[MZZD;\K0Zm6>D'?TQVmd*#T
)p+&APuh\$I8tZ!VrE(0@Mn"@a)7`B3-Ce/YD0Pp8AZ]AWj]A?S7LNOR,l.>T/P&VV,VcP6BUt
3T:dL84'cD"IlMR7\=,]A:B01L4P(*R%U[q_-G`q]A$efppn1c\hdOM[jsrp1]AU5:99ipMQ<X"
#EiB*'CcE32qCf"C2O=Xd@$arIo?81K([:tQ3)>s_O5&"?Q(KnGg4mhT#Y%brg\1[Hkbs5:8
$jb8:C'$,JcZT^kcRl^I/P5R5SO:AXmP;(?cMkJ1BoE;W2n?G#9M9KHK%6^/hkHa[?.)b1.5
!"?&]AI3"K.ZI`Z$FF0*:FA=\mbQKEMq&;8`IGEo,aJ%tDE30;6c>k]AO@YM?FQEBg+h$_V-+C
o>jhj1m+Feqi^4==nuX55NfY'bDJ*HF'"_I^E8:,M\re[p5+NJ[kL$Ya8C?$0%tJ9,`(ERK9
)tk%:fo*[heq^ZRW<S\sfp/R_cTUA[R`K$S<Z^oDqUFo',V&(bB5G=M$Jf1,j9i@f9&kXtD'
O"pul"hq<$#e6SsJFQnoRg-6p1NI^4K&M';dh.n.s9Q/e$CItfZjD%o0\`V314eFt\AA#`U=
oUI]A[:g1rmRbJ4$V9K&(ZiQ'%U*m/$.YZMok-F)'/D;n^8k9]Ao3%#tj\Vkd46f3W.:>5uBGk
9#mE4h')`P&U2&hD5VBodt*Y@I`Z^[S=1Y=L5]A<rVOZBsbs$O)X2Zn=peB`s$aH#0UWBk3%T
:mLnV`n7,q='Yn;iAO3T\T3WGY5=N[knfWV20brH!KWGXCLV/l6En3#\05-=0kdgm#]A8C,`o
pEtO@EA^$q@#q00L2/dUg-Lp3"Xc,=giu$R(.<]A7/;>'2U>peQBSP;K!(9d%4e$dIFhF`SB%
AEdVMrGV3iMK;Fcq\fDp<<Ifa-8;H8kCcZgl<E4r1Z(c(;9q#U!Xr2hi<:jFt9Y/-6>tp8OG
k5;EMPh8=4u\j0pBo9c!H,.kTN/(CG#iIp4I3pfrf,$q!HmE_0<h0"?Z[Lnj`kA_%TPj7nT1
):BFFeq+HUYhpm(5KMB*G]AH'6P#VNoeK<MnLqZhQYQ$>V@B8+N6*F=\qQd@P)3`N>(H0tO_$
27Nj"Ufn]Ag*n#)R(,-Q!UB;N^/Zo/(WBPBr9b:Qp@jFNI(CCoAqDLV\7b]Afd)_r1/@[A>$7L
dY8`Wu00[S-0U_T>On2J^co^5uQo&E%\=@\\l6.acQ.0#NU:NE7%=UE[KZ.W31LImObu!:5X
Bd!gCkVG'#O)9hqI0Wp'?P'B1#Am?Y7?G\?3?0G6<U-N:2Itda-Wk&j35a5a/chb=LGp6HiN
UJ\QWVr?1P9%mM`=#(cm\NdYAM:Y&'ikL!83RXdWSN<Ts#&E6LAOrFl0L4LBW>eNBs=enBWX
_Wm%5DS2@C!ON!"G5Qd@>YogFW>ocbu<UV2FaZ@sD*G>t"c>a?brogeOAbbml5aYEfNoCrN*
1%H1-\p$+8rVbZd7fOO#5,$7WU8oiMci"M0W3AuRe>U:O\eZM[;Rd-&.ZZfo#$2*jRMrXP"t
[A_=OZZ,aiHd9Kk'7L>6M4<2@;2E%BcF*muANY<6]Ah(WA:&cat@EMiT'W1Hct9Jc)9U#k'-T
mNh$plZs%=+8ALtN]AqB<81R#$bJPfLkkO(<2-;SN32@\0r]A9m!.;U2qF@PaYFq%&C^Vhe-Gf
B.!`nS;erCK[tH$Bb/J2Il-8P1U%?3\_c#3iC?_YGKn&*:.As#%'*)J<!h`&RI$^qbZX/FZ]A
:*Fc^^4QeQbLRFF922!RCB=aYc;['PJKS$O_;Fr=&oL>1Sg3l'>WBo7e+nm^$!#K(6gq9\k>
IX5@_eOjBiH]Afpm.b("0"&1o]A^<O[5OY7(?q$&]A%::_N#Z5`V!&K:8BSJ8E4@R*M^bu0)8aK
_=(7KZt"*cWS6&I:!U='J*ef#Lp6SLC4s]A(=$sqEdosqQXR"ics(_@_/hSe:NV@p(>(#On@c
6EaqMt[G)>T+"1/?\%bg<obZ&T,^m]Ah`Q7>TK[I'"<:e]A`qkXr@>(&-ufXLlQjUoRAYc$6;:
DO4fJRg#-P>DrN[[`Oj=MT7o?O@,"[%o9IHHrh@G9la2Zm)oX9u,"rr2r;5<!Mm!>EPF(h$4
s,OQ-pX6;G.&`OU(d9Z<C3Ht'l8:X0Y&MK[cQjD'`r+ruM:E(S'nRLhk<Ap%H4bq/M]A&#"Q)
!_]A*J&b?HuE9)V3TW;$`4E=1;'S:SAaa8C/9g0.,QfpFT"X@^Cc9R>j6t*L$i2g)cB^QS2J9
j**T2$W#0&_ChTL52Hlg^*>3Jsh9Lk.iR1CsXlfV!@`JjqAIcIHBU(JgXgR9O_&l&:]Am%PG0
4HJ=n-Ht5E(`rsM1d,ZleAt)<bM:=[(l8Z2/(`Dm$6OW^t+!_1;T'bc^4EBJ\`tO;+YU'Dq@
KF9Sdu'K(,dh0]AMsOm5Wt)(AXe%Hd;M41t9S-16$EaU17-=&Ta78VChV,5;QcZ@!U22EN[?Y
MkIKb$=PC35Z'!!-K1Y4p=#Ki@<^;#=16;297Z%i[MFu/3R$&c..%`J#^kguAd:(P6s\JJ5q
GC[jUKcXU[rc(oG*!S/Er!R''j@0l<8%qr@d,&oMJojhM"4a-U[NWEK-6Z-OF5@[h>8u79C[
Jg\99u_`hEU*cJ<_=0AIZXbQJ=Ua7\JP4B.2rDjL0EAA0E<XFNS`X&;Ai`HYceUN8HJR&gBW
Vp"gBhKgc/u4F]A+`3YCVFi4JEH%$DaC'kkmdU3UI%5B`u8>nf6,MkeD,pNJ6A@@qWAIne/\Y
gC.a-3E-jj[ZGZ0!>K7Q5L(-S=NGo2;S-D'?:HK^"l\ZV+mVi]AEn<Cd.&@T2(9b37@sf0=;s
BjKj3$;]ArI"(!h\a/Ea*YA1Zc9?.+E>tU6,TP.No'^qq7c$<.kK"[UXbL$1Pk`G!Rk]A`0>EA
gYAMNaOr,7b&FP_Xs+L,"DE#VbfYK]A,@Y)CGDeH53+mXg?CCLs#/6RZ?eg!Z8.P.oqB.aG9p
9NQ8&!Y(SV[#T8+"i93ZE+a`SOj@@eGgaGY'P"Nt@Q0!A@6L*TLhe:W)\k+J64*%TLO!leiH
*W:&@P;t9XkoVNSj&2tF.dCdK5`Hr@\_LUal,u1I(EQ&sP*_DJShi,]Aj8//mZ%_(f`E\Y'#X
P/@8^cm5^g&UYG0/P-G&OiUmGe`j,l)FsXf:ZoFHF6EiqAB;?KkC8(2;MB]A/bl=MUC]A-3Pgu
ERl:U7hYBW-H1U=BB8.M$X47Z`;9c%*LUL%&Q=3G:k'BAn&+!`jg\iP+s88t-iboHsc`R!%W
5<T8LrV<F9/G>?Q\[@F?P>0ZI%Q5>kD\?Ygrj3fn)]A>JDqT&$_9%1$HGO?5s7A9Ho]Ab9Zhec
9@QV9IOG/8l%$,q$+5^LoP[l(2($/,+r)5eA\^?+q]AepZcE+Jed<G$]A#11b;Xk1PZBqTJpim
6a0`>2LHI/<_G4.FkTojb_%dU>=>N3oA\UcVfktFEE2s$a08.LYqd4s6=$H1dQY"OiHo>:/#
IIOU>MAG.1Q*;;`TdAfmM9H,lC@3"8f$U=^Bf5U:<W3FR^2=pQ+r@m#T1`uPHMI6RuC6gki1
c@g7Eq.&lnn]A2>hr7h#::t%'"u%O2t5#f437".Eu_XkY,"ur"'X:e?C@GoLY7Qml_:Eir4Z'
%qUbh*gfQ=\lH5@ZfAbO!G@h2+!aS4C$R=Rp)\NC[:k1#\%3+@#Ngj@Eu@9%QSlrmIQ0O4g8
pV.F0;us^a:O>q$q%Gm3+YYM-V!YLPMXR*!M89;!/DO+oCW`5!*\D;f1r":_#2Kp2K!g;htS
]AU?_$"NCSMr?Jo@_#Y&LRlY_UMCQ?<*_jkT1?87NJE%3!EMt=Z@]A&U!f:*a+TcHg'"mJjRKF
D?fgrEchIpfe,rlP_r[m\au/3.-jk`fS<1U@?@,mm>^Tk5_ER/::MtS9Faq-I!CHD`.+,qdH
FW(4,FRB/>^rAW-[]A3&N/<,7%7.87=BKl"98O>?t^nb+G/l+(UIWcME!?EkfRnc2E=Rs6ug@
X&('t;7@O5W)Li>_Vj/&2.IX[CMkiES"4,IH]AYORe3oXdZhjunl;eCWW2'5t`I9C/,<q:uM_
/-8T1Z/7Fl[^05oC(=NTlZrqSATEKAm%*KqU>*Vkd/4<l"6]A#F!P1GF?)A_jgc5_G.]ABZ,]A0
okCan^YQlDSVn7m=*ehjbI,^<6$'=TW$hs>S]A^<%no097OOq5EnV8[P2eI3gT'),2QmrH&j`
J[a1ipZq!b'^9uC,>?LGeE']A3sgVdR7=pc&8O-WQK`mHcP\Y\Q>*^5&i+6\?J..a6Z?a$;!4
fRhP'NB)a32C.a#:)?hWeomQ,CB=3lUP<RkB/,nF3daM*me\ba7"k3?ff.'-66N3jD[Q,C=-
OrOolSM6[B_=i=h2)2BRQCt0KP%KM#Q>D:SNP,3]A;gF"FO)uShCUc;DpoV^T4ZjMW$#,e<(&
-$=$im!5f=L.rQr:O9(0iZ=%OI[;(hdfA`PnH<+CJ4`L7#.pi/(Z.#9(YR=fR4aQ-^[u.J6^
u874k6W4OkD,h^oNMKdD%GE3^RMtsM?q,7FkcX4VCA_D^gjmi!ICTOhkK;W-UGDomMB4)^:<
s#/]A6;X!Eqno1R-64%B>7?:!-bbR#[gZ#7*G]A^Q'd^S-.N[H46#P(M1UiOc!f8j$!j.>I8bZ
T6s7o:qcD(1@Hl&_q11)K&#?;W3ck>[EUrh,6\Q9&QK@P\oJ$laq-):s.nbZ]AP'a[Jbs..]AE
j?]AY"6bQe[NUFdg9hFu;!oOAEK/&)X#)i*/qp*1l;W@gAQFVQ+q;F?-oI5Hq!*rKl?d;VD=N
.q7KM@B(W\q2R@#E47ls&S&X?nlLT/k:7/J<<SdiM>DEOoP=4ZL'*)cg^,26-<K.jC$P2bMZ
2p#;+\<&[62pP[m8<<VNFE6Q5=p`Q9Oe<<_@:qW"KCg!-TD]AQjrXIcCc@+Mre_!WN+ZANqj\
Smksbguo)H2[bsdYRA3oc>s0+V*pgq:6IZebWo\C3VhYn\GTfJVqpj8WePpP.qcfb_+j[Ngb
?cBKZdW%.qlW/2N&C+6dKKgIOY>/X\63]A!!*lUIrI9\->&(!UU`_>l)gE%U:B2*XdB]APGp0/
p:@9H?Ut^1EU0(g^F]AXN.XL"]A1=ap17cK`"fI+7Z2=AnBp@+d^8(5;)jV"Sr"^)6+h;0;+)!
fo0cI%;l\#[`!X<<o1%_VU>'dQ1h&dAb\hB1N!J)(NC,3PZF*Q!E\0:pbNmW0C';HA4ELigu
<KR9p4eVnVjYGBmu^c31^\87I5OR0Ft=\=\EY'H_B!F)rb&lsFpcLb3ej5*Vord>*\1]Aq?[3
\8N@la7?b1M&$/s,=MgZFB;BM#N`-IG3@S#\#FWeClfW+^\--3r-^(o3+HLX^@LeK;^;PU?f
iQ#^%5mSMbcYGF\D;pn*%@:,j=$!Q(n&g"fB!1D:EUX-WM+p')RbL,;9$LcXS//Csc!s0hRQ
)oCa2UM]A8PbO9ku:"NV,?\Z@AX`!n/m0Nf+jjT>u_oeX@(tik)3jHc<92)G?^i*<]A@ftfc;,
uJEo2E9@INIc-1-"5T%$",j_XWI_?@B[I@5Zdq!SO$1b0jK)82".EIX%j98lE)W>t;NY"5F:
C_#8-=E'FW'-K0*8gDl3(ZH3r$Z$io4FM$/6E9`(tnUCnM&Z$.>hem=R5IaUG=5"AaoEt&=M
liH"2P8rUW-_&VNgmQLLQdhBp^_:=(=.?)J&H_?Pc.d>*:K0m3u-2%Ad--;0SBoolC3>?_:1
,9kb%*?CGjhS]A]AFO=*eX*!(e(ibE6.[cdH.(pVD7=Pg:"S)8)NoqqFigqeYq,KVs7qN$M'^i
e)(5E3BcVZ<Sm=6T.C(uD9KH:Z8dDGm5a9eFV!UbOtVl\YERB#SV8G]A:RJlN7TP:oa`ng2-`
f#6S%cuCVj^/RHT`#;6(KlP#E$"9)gL'6.a:LI?C<p@W/eKT)pj$OCq72.NS8`^>H:loi]A<,
%?,MOBBJc>OPD@cHWCA51`M$7S`"1C@:nI4Hn9P&W1t(^GB!9rApA@VhS0$PF6@A2MK+3YG5
Cmbj%f8SO^'Y@>DC`A!b$IW\263p,-hIfLKhgRT<l5IZ+h4GuNj`sb02D=Kk"BS*Kif6Z.6T
-n8A)McU^@3TJb8?6Ft89]AXh`V6*sK*-'gTiN.KsW^46Y0ZimT*Bch3BV(W+83mrK?WX:&h,
1>.F$:0eRC<soa9?qL"--K1S8f`5He&rt8b$:TP"Or:KsNk9P0IU=<N6:Y:\.f1T"WL18q^\
^?ml$1#l$Cg&(Jeu($Bcrg]Am8PJl_dQr.;J5K5!a#hkVU'FJlAl!V_]AVQ:W?&DI`G$]A_ro^,
M>a*E$TmJ2\b$Yo[>J8)'BuE(,Da**EUZ\p7O_M7BSW2e*kjY2>!Po.uc)5!C*0/4^;@'+Xf
D,jDaf6Qdc-%\YQ7MBka<Af`c8_j9ce,rZ"naRtK3'N=gJm)/,*369<c61JP_%[[2ANlSRGt
iSq^2^@&$Ac%lDT&<UiSs0r>>-IO4pbPDuuB(5e?>N!p:c56,dV$;"b%\PEShU3O26Z:;2Pc
&)ZESh9q.X]ApIEr&I:+V!#+9g@2[8^)h%%uNU[7QK:N/@h:X@`V?DoR+/UR*=G@QOP4KNCBQ
6-=:2+N;D)S3.l`"ea]A7VJ^X&ojCI,83_Lki9<C4$gfU\6k['C.I)l@53-9>uHE60V'S]ADaf
M:n;3iq/]AUY>Z4>E935*j+1e7O21:lK0mA-Ho7@a\-4q]AVBt=M#M`j1AX_pe8B'ClY_[:jI!
R$'@]APX;8-(]AjTC-_il=J.$ea5f!_<?DL!1IF*/=Kq5]AG&`_jZA:6-0'8_IJl<*-)BuJ8,i0
SSg?+W*C)d"bLb`2e%h*@=CA'iuMY@!%PDM9q,<=m9#s?.D;9q>g7\G"S[1P2`!i'tZ'1HH$
04'/Cp_L%l@%V*E<3aBGDDj_O:-8A[W,kf+TMS<<6fHQbma/M+]AdSsOViY5Ca^5&n.R"Crs!
dLTSj7RG%/gk1cfrsemnkJSLeLn*,i+t"/'T$jdQ=2iJCWoV*K:I*p7T&aCKXcJ;2pXl[DL]A
Gi-YEg_-5QrpVY'`VEn'4D0h;g`.qM7`-Q_o`(+rF.,p7Vha/"Or0;6r/Y'F)U[c5ZAgp5k'
GdR^Pil%S%?Xm(8!togEdVSpd<kmW&0oHH]Aamp/"OV876[bZmcC3GbYSkC9"A-C@(jmm(O,`
/11cF/k7h*Q71GJ*b^+8sS8B:q>E!hQ8-uRLuilMqCCY&)Rh=7E'I"N\pQG+.F+fAnVa"mXU
$CYF&6=A4>IAE8#P[$#WdMmg-,TFrjpKtp[$X+nFWC/]AJ.bc]Ae4g*%'pSHnIKaR4k)i^Gd$N
EoR9ce8/GF<d6_6BhsRJl8HE-h!4_;_?ciu1WT?9&EaI:no'gWFX,"O-MkN'O6\ltF`:hB=0
R[KnRa^Z]A+!44BF=/Y?A.'our*QP\DXqd@L&gRjJY:CWW8/6*@c&`*\cSB>.=-U9k!V$GTiX
O3H0%H-'GMrf`)^ceOdi%GH*iUqq^#'dP[cA6:Fi<L,Qj+Qn*==:>H"SL^E5mSIbl\&ZjfLT
_3(u5ZL5Kd[O00&!/g165;^2udn-FgR^q[R=HqJ;of=]A\9uQVO;is7"/WdoXIs+WrLs,CoTR
h^6NB4t%'9d!g48Y$Za!;(]As4!>*0>X-SS.DYdp'D'+h5jj8_;?Od`W:%9t;lloQe2r[9RJY
c>A2e5GTW]A$15dM;5>%g"RRd5hhi!!Bm[d-bT<NII<#EW6.FnMAG953S\5O+fp0,hI=7\,CR
5Gnup,O]A^>@^Z0"%]AY8q2O$_aQic2.K+SFOr>,:Ec7Be,c4#i\X_s+DB$Uij@C_eud$8%`oV
&S2I1>V7A$fN0]AI"*'2@=M)Q;2L?QiKS4`cdr=Fd_Xi>+O"OK0'lL,:o@p&5E:o;?TKp8CDm
@-nM#`#Kk7aIDcOYo%G<kSs+gEq&UjN/3#a&@^M&a[+6.Kb6D0j5]AJ(/*<0V[!pL=%\K;5,b
h52af`5P+)`cp9o+l"#RIa%\Ep`iXh\?E>:k0H8&_ZFJlc[?AG;B=01JGs@i^Lc6sQZjPODZ
~
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
<WidgetID widgetID="09e9f3ac-4811-4bf7-a4ee-115b4d4c6645"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="2" color="-855310" borderRadius="0" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="宋体" style="0" size="72"/>
<Position pos="0"/>
</WidgetTitle>
<Background name="ColorBackground" color="-855310"/>
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
<C c="0" r="0" cs="7" rs="2" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=if($dept = "机务工程部","   "+"人机比/人航班比","   "+"人航班比")]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="4">
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
<FRFont name="微软雅黑" style="1" size="96" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[ja;D[;eO[aB6nCka_5T.XAS3G9_CC,,(g"186Xb_/L"2le]AK0fL3SOtVA^R&RF+<:25]Atb,U
f!YWMY]ABBEE3%UM)D@OGHbD\>:#cK\JBhE_lD^62MZ)M0ZM-I)".FqMT^8\+Qh84_q0DoBd>
EQ;3u+F3::MPGTu0m#tG5-;?s(Re5%oYJ,tn_E#kF2JLUs.*FgMkV!fBrU%FsGg51h[b3[Lo
kuEs]A.9J\@R4)Ud=uAAWoraDAWun.=_Znbg6ZHu`9\,l4k5Cl/q!9@hhD%%j&OGFm(Rs]AD>E
5TB3n?6^OIo"3[li=D!f[%W<G14XA#!I*GSpG8(EBa';,QBGldRD-AHpm<lWP.L,POEQ;N(.
Z27tA&m!R;p6YOLCd$n3:kH?1]AZ$a?IS@r"E:(K:s6n4"hIK(:T)Ib0RHp]AG9T6N[</Mi(%u
ZJ:EILY-RkoG`fQQdW9<[QL\p7g_!]AreKGW]AB`F$lGgb\PRX^MMO\S:"Pm1GU@cH?cCQ]A!mS
4qkM6ecX/@2pLfM&D+L@,DGJmOjo!m8C<M[*Hq$NcRX!QqIAD.!d!jC_._dOTq7.`;D6)<:Z
&ik&TNgob2A;9Ebg+:3A"Oo94FMtXqqOFKhlQ30,:u1j*0hkYp6SEFAnq)p7_S!oc!Nm;MR$
fK7fC0=8ZB/uMQ_;+IsJB(\Hq#mY,X!9S4r/nR8m+n\$G<8[!^*S;n"QHQ]A%P>iV6OR2>)`@
EP:0"lPXPX8Vo#gIP&a^["!hsl`c?;g'SUJEh7u1L!k<t@k;bkrmmqhWn"N]AR?I=`EY)KHTo
USm2:p]Am-?NH*$rIZ%:Rm]As^tJ0:%f:@>Co['dQ:)02ig<U>n82a,,YB/NK/QqH;"_<cQ:ZL
a.@06IA5+%SMQLG@N(A=I8eKCP;gdpZ(A=jq%3R`9j.3-WYf0&t^AIsFp.d=e0SO:%J"Wqr"
gJi"/R(R+/a$O.1_%44WE8]Aq<POP5qgM0pHdAGh;_4/AA-_s*,Ko3_CE%O^ePS/ZF=n@SOmX
c'@[lLIUss4!74&O6:+C#RG4L9Z.km2>V,Cp3H3h)^P0]Anj;`&@8eZGUe:\af<`'tdG8#7,X
,48F[;#%R'FX**'L0kdc6`HdrMBWr#+\D)rVV:56>=L8[:iqTa)HD83R7TiUHW'9Il/+V!TX
/3Cb*MUU[/:[2g6O#&W[Gc2;8_A%j%J]Am'WPY+ldDa.'W8X'9Z&"a%%OteTHIb,E(&]ArJH<e
Bf@5,R3?dc[-AJS[Etla_W:D/CCf<0dF.C$Jr=/G21ku"@8BJOfchTM?i92FD,f`i"2*6rLH
0'U^=2:dG7UC_Mn'#LFiZ($I98FVYf-JGm(6'<b.6hg-Gp1`mXGAC/)ueR"7XnWJ-L2DC[h-
\nC$uspVKS5lMsNY$W8#^9'"2:Gh,&?%aMsl^r@L>S?)56<DM-]A++4JbI[^IY]Ac)((%jlfbo
4f!/i-'THVSK5-Q+R%PTX5!</l<[t7AGU'EY0VI9F*tiSH)niA2V:tfS/D_$KF$RL-TF5Kiq
k6?jjek:ZInu`(cM49'<di?Gj?mHhP_%_@:CcVbEW"\N]AKCK,.?uqRY=g?,]Aj^Uc3b?48B1:
(/HWH%n\5<\L"XGUL3h\PiD744r6US7&@r\<bo4KC]A(ULUXFmXFOV.SH==6d@GVrk;f=b*KZ
n_g9:+aaTP\F#5K=ff1\m5f8NBmV=K8L+R?Z)b\d.CQ03Wkj`+i?[eMPdBH;^@pCN[_crmG4
Rb7s'K:5.sBme_QL#Y]A_U$?uPRflgO-jdPQOcLQ(?XisXV/g'T9NKjD(kj%#p\E8`tm:KtM+
\NKQKkbF:NZ5@\Am.dL,ju7VsIX96c(7*CF&\-PG1l4Gn5&%R#.,*hk:9Z[YZ/UZ)Wn_R:1p
HWl1LqLiDpt\rE,:n9(F3]AWN:3cSiln_IpLb!*[,!c1Z9O3u\Y]AXX/,DGd!4B,?AONjob9Y`
<fut4]APai1'_SL9hfmJN:`gj?PCCH-iW[Cto2-[/oq\nAXc1kL4pMS&uWNRR;6sbMSlRN-Z?
>n`^53]AjK]A(J5nbO7Bt]AJoVhnAO3#pDFC>0'-'<YHQ1ln,:"1E<`S]AE4u#[%U6*sqS1?=P.7
qF!NPD<HG9Rf62/mYW4+81n7L`lDi)Y6nDQ^85Qu(a8G\seiI6nGkY!g'UpMKVMA97*mB5LO
T3rb<(.!DH51k7S=IXV"/8oW<Ms2P0H.pQhc5NN'6iS47l.b1oMbRLONt.baW@&UJ`54>Q[W
4W2W=3$*2]A65F`XR<=d$D$Ar@DNWc9eutkccPHaAUi+S?@UhM,n]AJm%>Hb[KO&;1dNZ<7ITX
>Fnp?+]ACGpbjX#L4*4hpA>a9#p7I@G65`N>iLar,*80(KQDH"Dt@V!DTYu%mDP9mrC(@P1A<
r14"MD[T'=Q\bs@Rb61Z^c;0L4cKX4Z*6gC$f!%X0_WMHq#Z8:oiIBc<E7oI(kse:,`<uBU7
B[rYkX8>>iNj\\Q2l"T;:g`X/Nfp(H29_n%cbSY2-9'F!'6.s4p(<Vu6bUJ"C&'cHb$'M>l.
f7d#?`#-6lQ?g6HW`4)C^DrOb/B>cf/u%"D;bEA":;kNa"t>OPHe&,J6@gU#'oP/Mm?>sM;'
N9l-b:b`S8()_X-Qs(<rL<"PHX<fA]A[f5l[#]A#kEf,SA38Pd=#<$B1Vd$ljBPV)KRQGG`Bko
.19M/rUE.?4540EdlP(61npf4Ll+G4tq$bj4T>D8V8OR6"Xa0]AThWlY-'&)2V9r'BfYNZT0C
UpJCE(Xb$JrmFX>-"5k>kLJ_B$GLE0nW+Nh9W("U=g4<FAqBbJpL!]ADUqHN;>J&,DBf:Lj3;
ubjmfPmMl^9lP(FgWWldBc9<QB_B62a2[]A1kENQa`%C9,<W^c,nIm:HA.M*?V\9m=:kLahY5
Z&mn/RlC.Q_*7WjfV,==PQdf[5BE5_TcYJX%H"47^(^<NlRcB_S<X-X:Q+Dq0QIjX8t(6D2/
<4#11piUrDBi$b$65u*0I>P>A./?Sa=U.@^1dCCLLfXFT+OjWmCOJNnd]A0Oo'tFF*7gAWl^^
rp1iS2KAZ^;)`]A[dbXDF4/W6:*d-+(J/P,eagaVP-U)7JX'=S1*Z$!.]A<EJu6V>B$%b0,]Ab7
i5[BEU!/*<!p3a\"%\(;]AfoGe4SuX"k]AoEpZl9]AC&4AXpiMZNI96L:Xl1X=MPLS>0mc^7kOP
M@ancP5;l*XLJ<,`H4=+"9epc,IM,Pr%Fn%:TCV1eH^mlLO81>>,\IQS7LDj'U1IalhYSaqG
?Sjij%cUJI3UuT%`1:Xl4rAMNQVc@TSs[2UVi;i8iWMp<)-353[&_4kPHmVi`58>3fi7rJAR
000:7FAJY86sj@VBo9jIbIj"VkfJ[&78]AbgmO!Ygq+R`m`_^H_1`uV"Nt?Jtb0XAjn"Q=-re
dEc6`!:n^Nc$AMtQMcXV'IgBg[*1OiT0gt#n#K/q2FlmX>J=tpN.7HPN\(B)Gl#g&\Q<2bnP
L;5['X2@\e+K/p\,lO;K/GHsMHHod@/&F,@GH6^PK)A)'sfrXC.J0E8gKC:WM--2=H%K$NLX
UM`@gs,A[&Zn<k5E3/,IQu)2o>6blq>e0tUSZ>>hW$f]A;O@Z6H(Ba0[iAf>[sTZOs-n7c,K*
p)YC*<kk8cp'hW<f"KHZ'/A__T.ZK,d-4]A$U792ahpG#NHW4DSV`IMF./KTSTX[l25Y:7VlZ
OBidc-3UMJ7VVb1W2kG&C-)oT4fULlCc#-Y?GnCAEWGJ/,0ZM9e$"&]A5"H/^8;a+3liadR@,
6#)r38K<1F_A-;2/?36\mKFcNE^g]AhCYF$Bo=oN3`*FT/%<)DR]ADAH,_iEf6Q`dM3O2;EbWF
@25B_)i?pKnYq3n72@3qVg*2Nn">#WF)ESEBhn_4(?rmUGT!G:YfSSY(e5h$FIHO/N^",I>=
&tltr8$2-ZaIqEYQ&W=>fIG-1RB+\(BYB$\KR,/A]A?S"U\1F&kVZRu`hFg$e7lC(TO`o2t.o
gu<%O7u3<`5)6-bhpBK/XURR$/QjVdMR+Cr$b'E,OemV\'u"GSrh2He<5Ei?.3:4a8oE_[Hc
U3N<NE*TJ?\EMC!QJ^KgiZaMqFrUcM_BtS\.K)/[e0-bLCKHH=,Hu$6"m]Apml8'R(>Va2=iZ
,]AY=A,I6[>OU]A&]A.V=<Nj[%F5:J.a:1<)t,J$]A0$8Ut5FF0+"@DJd)akU'-$sXAA[(Qa+N2i
*O+nVPZ<B7-IO=P/&pIp4^pCVd\=ffY/j'5U*SQ\jrKF^Y#-(:ib)c6ObOYljqfqY;Ka^Qb[
K1X-)X6fh*mP0<UGc?k0e::aOP1D&;mtU1O=(7>H"CDlFSOVl;7T3[00X&,+#Vjd$MV;AC&O
dq4Gj!UL#)!,T-i?A2TKh*niIjk]A6;5G/M?NAJi'o9f[mCGiHP[7;&^M9oM6>"M8]Af/9dAOu
fUd_BqlRZ2hX;h^aE+I;&&3dd8j:k"9ctYht477/C=@A4#ZF4]A>(c,ZhQ'J-M#JkGolY_`TL
dUA-.XL!4VV"c,oJP%]A-pHSKdVV/Bhm/%,<ITOc$="2Wg8#:!(#M!Vc)GSaNX9]AYa3ZYjK'A
-?=,NR6LER.sS"S:`WRSm=OtZ)4P'DXl(SlU\gNMcs6lA]AKBT"5TceH:=nN@I8\fS409=j$%
h1YtD'$.:0DbO\rfpQI*0VA@^Bk*trf!:p;F*DX9,\`G>t6U4o]AnS0&aeA)UZ)(/D="'Hm;#
XaCN`Etstkbr=jjVA2b5WZ&Cs`.`A&gWrVSi)lj`]A).JQ'5P_77PeA9jqlEGAK8!l;&FH,JQ
S4$gL7MD/+.W62g*#GiduL;L"?"*S*TJ8&1$>#(K]A3F,DVa;GHYU8Td]A",Ke[omQZ(ZVaOkV
m6^MX5B9\Drl%&YJ2Bb@>;]A:4=]A7s)'a9O`+:rj#@Qs8\jV!TU]A/4UPZh27Z95ee:S7+PrGb
\^/fnJhoI-8Y.kSU'm`gD5jLdBj.PkaA%R$1,Q5lsSqU]AFgZXOPQ1Dr/do-GHPd'5r99",)9
4NBR-cT7ZMtKH]AbL6f]AmcE^)/=dh'II?V11SXR21sTp3e'kD8a%u,YunF_qIP`jj=<>@::FW
gb`@!nhFo)j3T<jHdjpiV*$>51,aUsn^<%3=c0DdmoS/V-^&/GC0g]AYGrJ03]A?"R?]A\sGVI#
UUr`tnChBuBY0g'.;2[&'OQ(ql!IHj7Va8F\m2[itG.@icXNj:e&Kn`]Ai&Y5ZrX2f$fD1P]A0
V2qZ3n'K^0AHg6>13`l!pKL\gF/F9g*SIq!;)r+0[?`ohl:s&Q#Z^QO^a2_nhr[8kLRrgQ<m
75?lWTeR"1cgrD;"X;KOn-TXE.?APm)onNhIm^c3cU#"_fXa8'CU<.elAR0as0jVM+#\:pI>
sE[]A`>cefa6@iZ3N5o&+$E0liB:!7Yf]AQ\YZ9N0#4GrDL;.p%l1#0J!4CoJqGH>dR#*%T`2/
)9?F`HJ2$t,:hC["OR7KG(jq&q[GXr2AAQP/cVt'a4$RSj5uQc"s\8g9HD')_K-))Wl)2uZj
(rEpA5)pW5-E/E1Wtpd:@:JRg=C`C4,S3H(dm.))[gTpr/&C%<9Ei+MiA.O6gl;)kllc@KuJ
0#;6s;QF`E8>oa&&CM#R.qIWNh@E51WXpP@%39NYM\H.In#lkel9W@5AVTe`*>[ba;D9eMmZ
e8u&Fk>E<XJd[pAFt895^^r5Mc.;BF5YYglSPm9-M-4!%Diol)Hu$g#/;&N9E=J.2PV&dZmK
reNdEA$@nFmU_%kQa0WOt;;l=e_1BN!N<9#)RY4J#u!*bZ5-s:$.HXsue7HO$\)ri>j!*"K[
qb3n=mUTU\;n-O.?!cG=L(CGY12;(J!P(IOH]A=#YB4afS00>DHUZb5N07>g*rWB=k:MY$CB+
RHgN0EaWC<N0`X#`KD-!'up.$K>Og[$CjFlQJ%I``,#)?W+B[D<A#K.*#'_M/&2n<4+GEUrk
]AU&d;kT<AJ[MPj=/'1m=/9*@HS0MODT_d''mLG!]Aj]A<cc:G[@kgk9NrKk`TQKPpi7B!)s9!M
DAcRH[M]ARs298,c(RC]AQI,heK6H\T3EM`.)<-L>2S!/B_hn\5hrY"OX,%66)c[NK<O`I$!,:
,bc%$4dp:BVTM]A/bGlT3WN$]AduOhne2V1nE_#S9tlRQVok:=hD[#?h=(^Sp$dI;s9MoP0kQk
D((J]A5Vt3\$)Ed+JlN!"V_SkJ(?C.@/"FX5V/S#RG:G?P,rlF/P3sOpP'Lq6NnX@l3K:Jd3L
m[H\/#BA$"T:TAaV!ln[*K4K,bB3'N;7hd\%ledI)pY(f/Bmj+ldS^oHF[rZPt+CgL+mTn;4
o.\h(`d>ZS=)&ebY7+Mi3X6o%6gKK^r#$O@<qC$dY2I0*`CH6M$a+F)XB9CY+bC%,Tl2)4>g
"(8^1ZFa6.9NUMM33N;bB'(K9q_R(2`B2Z)DI^tZefXZS@`OU=Cu^ucGeS;_]AXM6;+mu2IP2
Rl":7-=jgHa+aluO&,,5GIN?]Ajtr[?TKScjI1"WRC(2"cdPZCDcDJ/Odp[dS"dN/)qmTZGEk
5qYm&psk@1T!lo0?[`jj!r47%l?N&V/+m#VC15't[<c*uQms+%euIhQ5tm7J6:EWQgH:[,`4
0CRKD<m!I@9U*WGp*SG5Q_XkKrgd+klJ^!#Z,/O'nJ]A%:Cr0%(>]A+?I?=hfN'Dm4>22E^06H
Kl,jR<\^Pmagr]A;"!+eS)XqNulW%RiO(P)c>O75">+c#kN]A"V^&oE7/[`MBC]AN*2`b2G&S%H
!p',c`"(Vj8g;ejY"HU#S\oB;`C!n#ZqV1ng7TF_7;N(:oQ:/r5]APq'gWNGqpam[*1s]A\g$B
G=)?Is\8E.gWTKo0SMf)U,J/&_u@i=DR@-ngI_dGEaS%R;Eb)']AJClci/e?#n2XENRR;>YMG
D#1M912[/Xcp=D9;lTU:ZjW8R_27<*5j;?:h5Z1ii,n!r=[EB"'BcKhUA"R]AKWQA/7sX_/7"
>Yr]A`:lk85J/D;6e/75l<<W=S>Yn$Fb*sb]A5S<;\jR$.-aXP<p(ml&s/3'GP%(8nm?di`m0Q
T$R4oeZSp$TKXEQ.kM%F&^QQCW%ru4X^MT(PEe$a`G7RuZ_V`a5e#KPO'l=udNi*Cm"\RR]An
Z"B/mlX%>q3g(b(_PO%CXMfR4k[<^G-cTrDXl^Z@2#nRnuO@9B9VHmeJ'RYmb`C-=H.Q2fo!
b'!d,[r`=/DtFcc[ujk?;uQ)j&t%^d9Ii]AFPogdlui_Zr1E1?pl#_Od-b]A9A^FVf):PrH6T_
T-dg8aUO/?*T'&jiQf..S>m9bHIc?hFG[%JTGua)-_h9"$Q+s$btY?MPJXiN;f4p,MsesbJ_
YP9N^39ZR5'6"TZWtCB]A@^'WUiFRfYtP$kEft8%--JBcNLt2qAWs'U+A>Ahq=N7155l[!$;H
cBCr0*j)bli,U<8,d-&#<`9re":5O[/`Li$Ann*sE9[r/,9*&AL#>g::Kqa0tD*72\cgK%eE
(GWPdBUrU-FrViJ:?oBWe<P6f*/p<LGg`OiV6O?I.oX1K)=8F"R<`.P9W\p+m6/4aAO&iJm4
kO]Ac?QR'cXXU_ibR]A.PAT=,o4u,+N,1NqDbpJL@mB46Ml_;[=9*kIbiY![IW,f0m@da:h"sj
*O6.#"mK_)U12YigdI5+W3q_9!%=sC^bWgf04L!*i`5m_TX"Un!+Dn_)XijWHmTfNH3nHF-1
USFM1Q4ucS[0E#s#9!m#.P@]AlMGU2ei'YcHuO,4[@Q8;e`G!U`q8/3`B`e_QA9=N?B#Ln1)Z
lYhaNU-F99`kS)sfKSfV$f[D%h!HcV";,%(?=MbnBlfbH.V)O,.Gk\D^9JCYc]A?:/do%MqNT
<0`n(\k.2IsCLIYOf5=I,=#A*!;#dG&L_UjHpH2$XW5"%'1,!Kr<kFjrXspGgt`b>peqbeSt
ttO5:94'n#AqcNBm*B2dt]A.Z?/H*E40LFcm&XNgTdIVna'@-`@_@&IIQ5=*\8K.,<U,#il!X
Bk6pZd\B)caW5)nJ<9J5J3$pbLuT1qQ9-:ug`VSQH]APDG?u)cEfM:>q5j`YD;6eF<b]AQ;,D'
5Vp"sDnl4M*uuJ4ij,ajj8m`'pJ^a(C*C>GpaLD%?Z``1u`bfd1)&#G<47!\q=>F'.8?fmY*
>bkY,&OCYb*,*Zp<ceEEij7bn7-O1=Gga$6)fY$W$SrThh/eQrnOhCX0:Z:ap:YYag94H<A.
irs_aE8+T5b?uJ;R[Xu"N#^5!0Z8sdH)]Au18S639pPpPE57qiDp)eC^q\=4+KWM,SlcQeFHc
;2!`[Fa@i0lo>$1p'\u.t#*?9cU2s)&_dA`[Xa0&or,`I'.WSLU'Z=uJpJGEhjrc`diXN`gU
?ojRGg?S4Mm#N'si.(:(ms>+SUog"MO9_FtV2matj&0S7kJ`2^6cBHpe+4SJgPY[LXtp[R)C
U4$[&.9$:/Z4GjP)KS81Q@LTR;!<`FKPB4Z@aPq(UXZDRcdq'OMb\EX*g`_#E#Tpfp`eG[9+
A[IZ+E'`dS>'S'WtK<T(5/DmD'T&^j_>Q@+R6X(ce[Sd+q5Vh^Z341W9_0ts&#qso<EH;7TH
8ZgM^Vlo%mSF`:/euk9SQ;Vapl_uP:'A!0$6X)KY0Wgp-LH#g3c7l%FaDY6QJDbl*-fn?>dH
'0a^'nIBk:PH*]AtBQ+8e%tQ\MtF`rs*W@BkBt5WT.>KMG.8/-(74q9nf&T;n?1#^o06^tSl<
GhSom)V7u0Z-VO\ej4Q+Pm#E%<ej@]Ag[1s_%.$gUR9!Mtd(j@I\,p<B4qSVNKIHfO3$f=iMK
cY="o4-Uk\`E]A.@rU$:;ck:]A-?a_Z-H'P/M/lR9msNikpW=;X;G\)gtQpjNEcg@EY+S^m#=7
RHA1WE=`l!_,o_Ut3lr*q9S>t.eT-.P(#g:hUJk"@fKmg):YeBErSI\0+L#m#?De5(+gQ5+d
?Db<nOpHCM]AcC'j.NPpp^\M3gc+a@Aa<+c&HJ>/e1NL^(W'\:k?6cWQZu]At]A#SVX*0F0'pao
/ePi;`6c%9:8$X'(U\h_=`&rlqp\.fTilX0Keg5EuGZdcfdK)A]A/>OC.(+?"Y.Xp?f,?(P(m
?#IaM2ZEkIh,XbKY+:&X3+Q"5^n&8HEKR/Y!WXI.`N$*(1[$C9hmST8C9;nC"\?U8%&(B91R
MhR%YI%>.J(b">^70M@X;nD"]A'Pk(P&(mkr_VZP4f\">!Pf6Zd[R'b,Ai`HarT=%XAC;ljXd
i&cYA`7M#smL5HcPpk_:7/HjuJ76`4%DL.:HocZA0?b"e=#dV%Pd.BW#4JQ^k[[qI@U_q1U:
sL"-nb,)o2Q,oI5T*aV<t,KXG"-TcA+"E=BKu;H9s$WC-H@[:U&cF'Pf;>D8t`]AA[E<c1d.O
r@n$RA`]A-04q..Ee!>t,Nd0!SucJ1R!n7^V<O%QF\>2[Vtn[''h82Y)CD0pnHMKm8,7HEHT4
hZ9J2Zf1K4+Fh31b&_+WhiN=O<NU5A6?,_1*,)o/ohRhe*fE.7i5a7JFZRR(`fj`l*sT699+
OoXmqsJImB\rC3og[!>imI`b0/&=5i^<eI'0;32t_fCX)fHs2`9qr6b(*Y#`.@p`KsOYQ^ai
I%'C!Adrp%B3fJa$4s9+Go,gWD6GZQ\<jE[J$;9R-!`D,`;t>pu6-Q>qB?fcU^Bf1AfB>/E1
c@#Bld^ADWj1fo3a+i<]AFId,*5?O_3!gIdd;$+&WnX&X$DP?S0@1`[!U&!ZA'H*G#[%q*,:_
J]AOj^R,_*H8*-V,t=&P)sP+1cTiMD'aV]AStm>ENQicJ6Yo"]AYoS'7Q3,/3_UI)bM^S`DQYqr
IpP'ZefEU@cM!]AV<(]AO=9VC8>$>B9%mfQ6RDjpj'^1WFBA\,DS>8ro;XW2pq#>5%XUsZG\qp
hMjk5nWJ`I=X"LtN2t4kI8h]A6i%#!G'1)YT*ad\R3,\.RBmnl;8\hoFX)+!HMY7*ld!O$JMD
^Kfqi:]Al#[^?2p1FM$s(?EfkB#:bAcI@pW]Ad-Z*s/6=^_U$^"E6p2AsA.u]ABKh@Qd0+o!(Pl
+c$^OIu'F)b]A_HG^EWc>I@cV,W&2NZWk$*OOhEOdW))p1#).GReG(4>k7NE(kWFMdlYDs*dg
;=8;]AnJg//BK*UXc@=s><qLdCqg[UWWJl5s<=IGBaHd`KUffFX-V4O&A??ub"Y:I(C^$r]A8W
e>Giegh9rr%;=(e7;^gH9Bm.d_J&FdLK='039d=g-golb+C<Fnfk5`tdVY]A)jbXeMH83)Dm'
JVO0N+c.jGSBijAANkn[)e14>,0;6[d^R;HfLrkQZ?^5!tb]A-j0i0%eB$fK%s4Z9q<KIr5hq
`e)f^qYqLe4q#6JDL0Y%Mn\^&Z]A%Keqg8:gUUcnX^p/]A<aG0t/#So@<@V)dPR64q6c'rt:9?
=LkV^<Q:^JlIElT"%l%=da>!J,4!:;65_K^D:Z^oN]A!eD,dLQlhjV!TZ7V-jaT"G!L7sl-5g
ht3@\$S#fthV!F4`<-\hDL-pg$ngSZLh`F#pU^=&[f4JR;?B$hmb^La%?puLf$Fh@Z,~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="450" height="30"/>
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
<WidgetID widgetID="0443a23c-a38c-4741-b1a6-c5c3577b00d3"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-855310" borderRadius="10" type="0" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[=if($dept = \"机务工程部\",\"   \"+\"人机比/人航班比\",\"   \"+\"人航班比\")]]></O>
<FRFont name="微软雅黑" style="1" size="80" foreground="-15386770"/>
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
<Plot class="com.fr.plugin.chart.line.VanChartLinePlot">
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
<![CDATA[#0.000]]></Format>
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
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
<ConditionAttr name="人机比">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-7223378"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[人机比]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="人机比最低">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-4217443"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[人机比最低]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="2">
<ConditionAttr name="人航班比最高">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-4049615"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[人航班比最高]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="3">
<ConditionAttr name="人航班比平均">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-3504606"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[人航班比平均]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="4">
<ConditionAttr name="人航班比最低">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-12890274"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[人航班比最低]]></O>
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
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<PredefinedStyle predefinedStyle="false"/>
<ColorList>
<OColor colvalue="-4049615"/>
<OColor colvalue="-12890274"/>
<OColor colvalue="-7223378"/>
<OColor colvalue="-4349286"/>
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
<Attr rotation="-60" alignText="0" predefinedStyle="false">
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
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
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="true" isDiscardNullSeries="true"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[人航班比人机比]]></Name>
</TableData>
<CategoryName value="年月"/>
<ChartSummaryColumn name="人机比" function="com.fr.data.util.function.NoneFunction" customName="人机比"/>
<ChartSummaryColumn name="人航班比最高" function="com.fr.data.util.function.NoneFunction" customName="人航班比最高"/>
<ChartSummaryColumn name="人航班比平均" function="com.fr.data.util.function.NoneFunction" customName="人航班比平均"/>
<ChartSummaryColumn name="人航班比最低" function="com.fr.data.util.function.NoneFunction" customName="人航班比最低"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="7cf5302d-393b-4373-902e-f360a6554760"/>
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
<![CDATA[mC[-uP@rGNgjW"0AlRtf>>`8cerI++5Z@fjf$\"BOX_QrP))ts2'RAi8NTnN`B^O?<.q372+
#s5Rab5%'d7B:5Y*(AKHrek+UKD>q4:ub;%!o&Bfkdrhtur=<6]AJ;k<A&if6-NQjMIf"pMTc
4_4P(\l(njd55FF39/!s[H0M._YPrMnn2H&F.egXK;U1X+52(''iPnhQ0)Go;k6t;FWtapQ(
\CFM,0+$64ttrABFbUQV88;52g=)jq<lub4u,*G'4UJ(7,sk+n)RV7W6[VHn/2*00q_!e^mB
"fBiW1+1UdUt20P5#&*>iTgJC'c-+1uK\p/EZ8LlRC;nWF60@+Gh6^U]A@/tt9R[S$_#=p@kT
oFN?R&*&T0Q:XD$[PXK?j$rPnCH`7<1JnRf3CuRF01"E;5Pa)U%pnI8$Uh(Kh73T.afYZ!8!
k^)HU#Wt2gd[O1S=Z&5?;+\MIlg:iiS67[\`'oKm_Kl=SJG'prB;iQ:)/jr*;N<T@"B1NEBB
&oWFdYpN3!4n^!iA,e"3n^RJ9Q'6^s%Bo`OIS3]A]Ar[jfYl:\3hOT:cXe[1?JiH.LNdQ?H<f@
?7HQG5puget>&Eps*SJ.aG4US7aoPCcaL^CMiI(]AHLj#YH3+@O!)@O&%)^d_:R7mK]A/WUPo^
:OHN"M@Gr'brn#g._`ns*FnM'*\&:%W*boqmj)tF+Q1F.,0Fj$(h;qGlbY4;!;W4D$Kc>;-5
IEM_eN[NW9J.A-Mg&[<aT3<]Au0cM#=bVANFeUl7PpIAQYg.XX8o0Y`MfO?e+CuACZ+[>e8\@
&nmT4Pt%=Lf0l)/`L*P_qAr$Lq1c$I]AL:AG$`e81_+6cQPs)mg\PsbE$VY6RAWBpi5(c+!C\
Ke44X"lRn-8c]Aj-bM6-)mG47NJ[%WPJnnK.d/o'<Z:h!aJf6Jb"[%9>OZ-<u!cg)/+_9jbmn
l9m:e>C6lft]AmA58i#m]Aspo'&IJB[9rEf:V9$E*]A&Bh[@ma"<iigs;"+R7LqHI#;HU'o&9N#
jRL=!5a/[opm$nM1SDe3mX6]ArT*]A;FUsb]AT^b8Vg^pF=tKf""HIR/okkOl7[7?R+c85c;]ASN
KY5JZkifRFiRXL_A0&MTkpc[^L%T"<72UISCr(aL)DE>T4sH5?hT8q;iCsbDF<,,@bMRhV<:
-a_M`O1+%-<Os4+.M.&2#u+I(d1q3b#D(^c5f'Wp*><Wi!WX]A,EZfD91RcUCk^ek3BN`&NnC
r!fIL"I*^YQf*G\9FjD6*IoqOG3-O2&g]A$&]AXj,D*BX7j+:gXNJ]AUBiu"$=rT;GMQY0m,MIU
l")+JOalC!Y;F/$Ll#=k310c^AM4'^p!_]AF23GVL?r5p@\LaEheTX"E&uo2mb-4THHnU[@r%
]Aq$lEnn?-OGOa(ES-'2'B!.A>;;!QLT"*U7PVik+=&`J9iODddMp`AZZePYo'PgRs8.Q0sb2
:rtGWqD%7+g:>IL;397Epi5coebPfPAu:4LR%r7_X#<r?B6_=q+r'^DV_p)6*9%#>+V\liS=
ChYNm*D,4H7$NI#Q1Pc&1n=q>0dA[K_0a4VLha0sOtqJ$@s_6\OV*NhPN9j\0tl8]AedmPN9c
VQY:h7)9!6Zm&dh*2ncl:!h<&'QY^e+\f>0sJ3Yh%P5;,D(]A@-8JV`WaAD]A1J(<hYd;7H&;X
k^\W32sOV#*/ao>`'E/]A!Wo!LX%[0o!JsOOGnP8.?7ELLCE3/kogAL]ApFbGF^CT=WPRd"O&+
J`+*]AAJkI$OcG.M5eUp-Mb5@S"aD/Yp\A[&.19\TY^.dn\(:3Z!NOeesS.+3BB+/<2W>I0R0
Z0`VB*LJhc@\S+LR+BeS7<R/B[SWs`/Q=R`r(%$;[eos1Y+Hf$I'*kA?/\qIYd3b;J#>klEh
1=72O``^jRq_m;S3BFAs:?%X]A(2snDW^K9sCkf[=2MTQ6Db9G)PWP9SS6M%0?@L56)nkm>.m
ljhFK!Kp!4O443PXP:\9RU"3$+9S7[jL3KneOpb`^SbJEOEc"&.(@[t<a?dBuiD=rpO-KfJr
2FRY,#%Qn7>d96>TlE*3nGa)4aCA<o%l"=S3j%7_$2bL2;S<03h7E.(kVboLgTC5J>7pK`s>
jfU&*Jq]A?@I:qLs!aNj5&'fH$1@63Q_CT*/;gpQO!%V\%HWQiHbP;Y""27Z/cN]A[=HYO.e-Z
%i?Sj]A,'\79@1koQXq1mJ2-ckr#/51G7;6+rApRS)9TO,AcJWUg-Qfe6Tqe7IE=+=DSKfB4(
fQWBLiS?WGiF??94.jdkri-R.=W;aN?]Aoq=138l'S;W8-Cs"A$YU#%iKVq]A_::*^p14=;c<K
n2XBLZcSc@m/qtnTI8B%8n70dXnN&^Gl%!7oVi7;Ifiu-H5BKudPL8R]A;g5@*#(Xo+$ubmbb
1?U=q!hs\L8E>_R\<(H6%%hGH!Iu,`Otku:Y[91"L.ck78FD^%PhtD^a-6WA#tq[,J((D"[^
\,&sW]A;&uK,QWaeTk^.1Jt/,F&q0P+k5<4=m$_V(nMG!]A/q7L]A)2,RCuoThnnE>d!5%_Ltkd
e*%Jq[@U?Z7Z=:t_?a_L.;Nq5Hq(7<C>2i,1LPP<bSfU`'5$PTf')$!8JJAhM"]AJ$S2^$o>K
QomPNFI*Qc1u.]A#mItk2VEV+0;aZr`XX]A_OL.r8BN]A%KK#Xb.N6SpY2TsD&6]AtE+:_'1)d`H
H-J)#Qqrif<H\:DB0*W68o\lD+bs::RrGDqYLF03</1Ht'[H<\16D1U5ShOLkD")0?qrGHf/
,=.#c5hp"3a'*//N_f7Tl[plL=NAk@2O38M)1?Tf1#VVr6[3*Z^%*Y8MGmi7b>0W^D8CN;SO
E1P_*#(H=A!_!8(>u'(`(XZo:H04(DtUQZ$:nnWTkb8\pH$-_jk8;?9_1.Ho#L9"e?g8(*1e
U-S53U4Xds$p>(?ZSW`qC0'ihq=hQ_hNT9LMdL:q.mlhJ9Z?WBHflUf<[DIY$2sXYGNS/l26
8.5ShuW>mg)E`g7Q%<>itC4$4mo(UkkW5$KGE[##M6)>U`bDD6d_-:2JVALQY4bPLB7-=4D3
"L/9]A8&*h'1)m<>))_1!Q6U(^-G/V[igT8:/cgkK!0iV3U^R]A%NU/mi6.iIAZ)5F'@3?B%LW
J9Y'o\#*GjA.t06Hu0Y5mH.g*`jS3WE_JMEfP57jrcK[c=*knS<@H"1DLAW47$/2JB^Z@AnC
4?f_`-C2V_A?&c[8bG7.Cld49Jn>a.)-,XM<%nBJ<-gbAE\r(JJaA!2]A?ktaNhZ:O::2j2Og
c'[$k[)89;GT^$APL7PBg(1LAn&unGXJ3Kb[C?cB+!/I4e^mu]Ap8L:MR35Aea!GrAf:auoG.
mcYgBIgH&e0.?e%u.7MPsVS=rBhX_&-\@+Z6Nd6Vs>%HpG^89q<]AK@cO\COWVoY]AD&Ue3OW$
VFT1JTpZBdh[oYGm"csal"ib>[N4t8oLjg^jbS<&"_o\sXLEjg9P@TYlU0[mskpp(j4%#:")
_Yj6U#!Dp&G<KZ"j!<P8M03-T/&+g;''k5_-]AN2akVQf*pl:Bc,1-RVMh^A4PD:DC0`?ZM-l
b'S3kK/TtElEgF*%thXpAfjJ<`h*>ZY>1NGe2C.`5OEV?:4S?G@[F/mVA"4L8S^jlb`Es%_X
R22J6*/(P$]A:KHblM&djj?(;=a50BX@OAU3`q'%"nsM65VYm?!,R3lKdQ)om]AI^!q7sr;RF_
Un2r.$0#o&Qe3fD_4XG]A]AB-UG[0eIZP]A$M#4h%S96m<^_p?M3Vt)6?bQu<s%S82oo[Z3#"H$
I#K_p"pbZMOB-[ih4BJc0F*iF"f+[:<YEAJ?#RT,<4lT?m9%kQGrPYqTJu0Ug7tU;!f&s(ba
[>UL#]AqVLBC0"3:4S7\Mc0W`3HhaJQ$tB(UcAOu*>5`1)tCVVK;I]AG^n?*QF-FN%T;PNI>ur
o,9btC-%m[;Y6>o'JF`?bfYc1nU?#n,gK>ATEH@8sPp8DUbM-dHR'U*jJc,SG#791O!Yoi_C
I/N_8OI?qd,Fo69rt_?8EerQI=EM@ui!*Lo]At)6N@3#,4S$M#IaTY+@oNC@t"<&sb[b9fE)&
;-S",Tmn$V-*@f&j7`0YhDW.Cno1$RS.a./%N>fK*R@g+P%U(Ul%+3'35mm*@N5d]Am`+)bZ^
H6qm[<*u3I02B(/AZRV6$O?TbEg&`pu04]A#)Wa%qGnTD6fOfS,BTT0ar7'WC^m/eB"FG.RN2
PGhlpsX?l$MGh]A?sAt#*5Pp]AP#iEE>a"V8WNH8b]Ai_Mk0_Z>"<07[DL\K=/2>p6%M:W,9Wd;
!,)qOB+90^A#'p(VAl#,(uTY1B@>]ApA-VlAmn#>=Lh=rJ@B2+1jc:BIbd&;S,[X@%BO*T[[E
SN>%YQJ4CV\JL5dF-/\OTH'5Y59IiVi3AOGjI&NcbcchoW=2T?H7a+!VI]A,hgb=#;#Gm`KJi
MaQ;KJu]A+I(o%g>p^GDHkb4YBEb#l`5hSgdMM0R9X&fY_0'YFmkMJm7l/$:('CQRCo1oI5kY
4c)M]A_0E>;`4g,5Jm:?MHRR7Q<TiAtcI932Jm$AgV]A!O2V[+U5(khWKG[b&;P[uhaP.m"D,l
-1A@D,L047q9JTYMu_82%[8?p(Q9$i/loMRMH/Jf2.j?)<<nd#WP@JA+Du/'*D$pH\3=e>h`
gV;oj9LX-U//JQ_5+i*eC+HqJiMpj6/5521\%&U<5u^hbfIS&H?9e?VtKXO2P4T]A9h%c,q;e
Z!K<nSB,T`1?1[EH(5'iP0Fq\_4k??,Y@/CnG%2J*s`tG>M%#re/2ng<53Vc5b1rqm4\TTDX
Abk$@<;TTMTgG.D/V0Hl_(X?fQrXLc:jR`s:`S1Io?oCDa*$Y*s:>AJdocdSgJm/"RU3'K(>
=<&6N[!%h_D5aqd.(U,N=K[mc_hTFJj&_R#X;S=_Mc3)MW[NKMMQ!]AhB6W7t6Q_6lnA(%J!S
[R!;ZM0=*UXND_T*)s\01,HRht%`C&:fPm!DnA?0N\ET^ft^t4pA#d(>ahIhV:JBC$Q'eL'-
"Pkf2Q9al'<_JAob0`[F+us*8,<"<cm&90(?!4YD4[!3bP13FIN`1Ssf8,VR*:TRJl-5I`KL
U*+aFoqW^>^2Xk[M0&BLSP.At2%9OSQeJ%(2reQG%)=1cJKm>QSSSLtlqQuklti,kX*/rS'\
>eq%6N_2B^9DZDm5I?T0eN4dX*"+<^m*A/OWjs)e=6.@?^sIp$c2meOQ)ia52]Au9`[tFJB!?
3f1YRmP!''a`iR-J,H$)h@Vn_0`CUF1/R_1E[i)!]A=sZ4"Z<ouAMSo37RmTejg*UY??8rOA=
_-aBcAO'?qNust]AXq3fl+&fjcK8F2ZLD_U)d0VB2Xqdlcm)jE4H1V6"7?a&R&'-+N#0cBBp]A
&sMnB(*&+dl5r^f^_9.QcMUZTD))N(rZ^r&I$%"nkN&#.i_b:CZ?ds,AgQZD_]ANf%1p(P^!P
AFFBN'*F[KUsEb%1pS<;)D1;=`dp&H*H7q_;LOBk?DeB"[Q+[=.f`#cf@T0uq$<'u0BG+7h.
7"LE3WP>,J^RS"b<NRnk+pNII^p#J-JH^bk>`n8\GW.J4L`!MBHFiiMY9H"<1hi!7r<N"a,6
!H,>m=3"ltJ&P!0#+c2oPFa+IB0%">pjCdT&+GD$0m+B?BU71@WJ-/&lr98?bcpqBWbd.T:j
,BZ]AeN"M`%$'Id[T*?c\RqPTKgerFM/uVKZOT2MYF(,D!$Q'Z]Ad\bPF4bB;lE7!n!T:mFYgU
#^1u7T,Ii9H"D;;fRX<s+d=a=]AMjSU5'4sorD$/,r)C&`3if?LKVZ>jpK)!+`7k3I,"^.!*\
'G.4n)kc'=C`i]AOaW&Jji2B]AuLd7#^S:bc+kd&HK<AVVaKUlgr]AgZ;fOpkuF#5Qbh]A0rE&S+
d!`j6!DO.6A*WX#[j4,VSoX5tLDje,Jt?7=EO[H)g-eHEY$M5KBQT30(nG^S)nPAC6nbeIO5
)>DZ^\?k5SLPi!/*I24)?922)Xr@J_E?t'Q!<V]AR17L;!CKEm:K<\Jp3FF-B3*;"$,I<^Dq[
M1@L7\-8R4;p9in#_E^8Xj?V$X`C5`5VcrYo/^Cha@n?o*&4\,]AY,7fs]A0O7eb*B>"'?taD+
Tq,Y6XJ@/ZS?[]A!DfKrfNe*lK#ZcOXfIK=Y#qnhiFKT*?b9T&=YkDk1)#)X)S`hDO3o+;0?F
p<HV&>?(2Y0S*2F!J&BL&kT$joYM'b62?jT-9kk)9G"@t]AP@Z_!4%JUWdr^#,"1"YKr2C/o$
5]AYB=`cY!81MiE`QYRJi6&iPb&H:*,%#aX:jX)X>^j!A0nD-^#5+Gf-)T5bs+0e8odD=0&5#
l]A0f.mMn;*A'ISuchL)%k]AAk5(fjCh*QqfJ,^!n"aBH%ZE%g5"EEcIUC.bG,[U:g%J(g8?<.
*;5@bbEBFG\l?rk\2lG>_\^3:u9rJik*"2@D>8SJa>d"D'NtXaEXCnf3eW%Yn06L@!_&FK+m
^_g.73J2_H.nBn=+(3Vf<gU<=H#/7ka30W3=WE>0Or,Rf)Hb=iWm@+JS'8;DBm(W(CB]AQ8(<
?Igjuk`@ad4#_aKrQEp`-%>G@UYT7:N<i;2RT<@MOLID%fQ)3MTB>0Ujpo<6:;@(tm6kt5iD
$F#Fu,.a:K'YL(+@B37-eZ>=#XEF4**Y9>?H8,qNLZ#j9ET$P'\"`JiJtfG*9FD`gq9HY"Tu
52gS]A+06A4C^d,5M=g>mq>4Pf["qo+[R69=arUB)=45<Jb[^5GmqFVsl!&U,Ek`r>D)iakM/
`UR')7fVpI9fPHk$>M(quu$.V4]Aa^IF_CnT:J)LG!.pA#qXm%9?#Cc4s(>&hWfg6CmPU7$Z>
L1c1iN_*jD@oZk=sb[(Ih1==0k&8l0ED&>*cj!Kn01lt6et0^$TR6:4BO!0KLVo@%/WQ8cta
HL6c;XX#R704B=+Ss(O=J`dO\P'<_rb;,rZp&Rg+F"(s=Y[%V/R_-U0GZq3sGUf22H0j?EHW
+obaX78c3H*^YiW5WeDV*BXf1I.,T#R"ok'I?^kbHU$Y?__O?I)`D;[<[#-mB`7Gahrm@kr%
N.i*:EQg0gs1TJ1RnA;`H`<.QR=U[nI]Ad"NSS=T'g'D/M&)GMbWFSg3:GNKTeZOHslh'C9)3
L.VGFDkj-/9%(VAhi/UT^o_t0KCq0!K<E3\%$DTlGbo460DVk`R:G4QegFVDnsgK)LGfIeq%
-8%%b'+h0tdl*FZ8b-RJ$siaMjbO%<#a6nL&VVj5XkYhfAj/^rR+09ZYs2@t*$$d:U.^j?(H
!FZk-Zg._2\Z7.5A,*eW/\Kt5pZ6@o8\A$t"8r31a5_4eY"#RerYjjqkF/K>HY!!R^p:D)7O
NX0G.`TaIJm9;VXgu-kC!n[ao7)&IK<NXV!;g38c&;,g3,AG,3=.`+Cd8sMGTu2r1%@T7t]A!
1g]A<!mX:GSL'+PcuKBc_*P>.E%D[`l%an]A]APb.W-=?l0kU$I3%rKX5nG\8-Qkd^@I3eOhN<V
$Dh]A?otXNoMpTekapk_3=)1gV6HaSbMg_7^6Mr;OmK@ATFIb)%=L4]A_O1fL]Aa4OZYj^!\iSP
L<5B$nuM+&p.-N#l1l-X2j`]A.i0_Lm:;XqtFl*pFaI]Ag(S-!d2VHQf\>Vae6$NVK.k(,MNNa
N5Yr#&,1[R.Ml]A[AURA,+l#J*RZ4'.XM^'o./2NlJ#3S>?6^,&=U]A8'K']Au?C:JlR&<7ilS.
Vd0/Q$Ok]ARP\rd49,:,hX1$kcd1D\OX/2^,^3@!5s0?,C)j(]ALFZm0H+`CAIl$GpgU:aMC=h
?ZX-0;fB3-UMI1.L9o.RTW[ZrVa;)Qf3*fC00%irFLS?)f!oPR:2ORuqnr@hgH:`aR]AdOWXW
41PefZbV`0&ONbIScj@Z>*!JWNWb&S-QggXknFfH+l.=Z\833p1I$On$fE/:g2W5M4o"UO1N
np)R/2/jn*#-dN:^9!KWjm!n-edpEC+l`TFFj^@UcdT>=_s(\N?NjI536EFf";6R_O=]ABagS
QEl$\gZTM^%V#g2(Wc3^Yn#^1r1LZK/E#:k:m\Ao<9XL8k9WkeX2pj*bnaj/`As%\@Cu-<L.
$kD]AQl]A>5k]AC_DKtI*A9l[61*@RY,@?\2'=hZk<rA4;VM>7d1R-]APK?^]AVK-H+nd/N=Bbo==
tlq,[s,"7dF`48'$B%"isDN"Q&)@Ctc0s\_mKouA!$+LR[pZ"Z(2(nu@aX:4kh19&`j`=j%p
1qB!Kj=e6VH8;?JE1UCdkYL$E!JC+Q_8j0)c$J(KTeF!e)aH5%^D`0,lVK&nI3HmI":ORPp^
Vj,U&)E&hhlo3m0(rd5U4t,SWRn.heKE&F^BTEkreN65hN`R.>%rCnP-6D)e=?Q$[!E0RDPa
QjN/7!"qkA.I.T(6A9/\YOlo*.LH,Og#$9D"u*jL(m_''UdKZG/LbIQZZ5Eh]AF0pJ18qV*5r
oBlBIPedc<-/U^=5$m<@dkpHKCnW'h%]AY6;6/)`*%PH'1]AaKL!u%,AI2[QB=$O:i\_ENimCS
9BccR[#Bo]A4I0d5C8IJ>r'(ST[[,]A#BD<K0B5kWr;=P=CbO@CuVRoo=t"HUu3k@\i`Pm#%MR
FXO1!UP&X7;uK^]Ai6J?Jc/,g/6)Z_Y=('FmVQealfj6r\!/bJH>HP>?;(H75q-"M;k'$Fk?/
qu]AE=C=MB,-aWV:%YN1kHH`p]AKs@X3dfNL_@)cs092hV^"jMO69?9gEYMOmb%N8Be[q=m0GG
:,nA!X?It&ji5!/PK&hq%NF(K]An/a,Hs]Aa>)RgZeR$]AYYoQ;Spp:_jh9VRB;r\GQc2;@6n+Z
1ZT*=7R1h/oZ8,lcE2qT'\O!FD$&F;sI!U'9UMO)\&i0ma]A)cTRSbnYD)gWcB'[bi;DB9*_4
L3//uA)j-=fe[^9o+):0,)M[Ko3IO/:UHmein++qAn)P:RVUgW//18f%lHkk7r"A99W%9B,B
"*h+fO+\5*<HX"4*.jOa3V:)PK^?[m/an^g@USV=5Us:@Na9,P)Y$P$SH3?.Jg4\P]AHA%Y!Q
ec+FVETd)pPE_1^bA.6$'A"D.i>1Piijd#H[[$<j$,1H6@[9"$7?"'eP<?5D7JQF4]A3X)a!;
Kud'&j[,=Va/jk4Hp[VJ<AVE]AU<B`[$2KSGGKDX<?qi8,^p2<5)$0/%.C_ffY+3etHY4-+S:
rtIT3P&gl14S.3)6;n$^s_>SYmLL$eI9bFp^]AH_O$)>J/25JTS1oGq:rRVed3Y2[]Ae&C#-0h
maQ\-Y,_KF!Q]A&/T$ga^W11R4"eOadK*&j-Ynrk->-CG^p-h3p7SD*7Un[F:B*i?u+q0D2,V
2R)fn+X;1VW8<ON3GN1/AC7+>*+X<nec#_%Vq]Atd47>.ZUZ\mbso3?/[Ho21$60Gg<oXOlc?
g2-ir+[#\/cWk$5_OSG\8'dGoN5[LE\PQS_-nMcCe`*XCn>]AE*6R'+s*>2Yt.K>po@Z=VmF$
Ad.MTEQ306kAI=`O*\9QnU3S$Na$O!3+<[0SQMUUKAX:&$;f25kmq0#_j>.Ke6jk,[c)tQ5!
>Q,3M+9:PN??F7]Aq,t^#u(#5(D#kK..R:UoZ_WWI5oedG43$/AfC)`;D8*)_GTh$V^O]Ab[`9
&$)VaCLT>)pk6`fnL:6Q(Y>*?#7!gl]A5]A>P.A<Fmn9J+BeI?]A3_CT9K$,"NcC6/:$Y"=*DLq
L7Cmji/CHrSp#jHW!&WoKQHSpEQk1_M\%J/fsJm=]A$n4FG/&Z^5M"$bjAd/itZ&YOH9``n2.
>F=sHHPUo,t9=Y@:Mj]Aiue<%X>a%W'_LRG8X=De6EB)8+f^Frm1q<Ll*9(B.8q)YRKdM_"4K
(`f8^j@7@+"J3[$jYCV'g]AcVaY'R+Ua06/hAi^(.FBHDUW#_M9FKX:b8s8Q]AZOgRK%K-Bj=%
Er-l=s^53Zb)88W\gFT/QO5m]Aj_8@1</n/i'm%LqbE2e'QNTH]A0-t:UDlSG(&oIeP9rF*PF+
`.E&&E\G!6HSH6a=Vsij.hJ7jhJ6b\O!YH%.n(VL"N5MmBJN8dZK2*2F)Sd7ll4JGa/#-`oQ
C_Lt-O:I-88;]AM2D!7P)K0DiKo'Yr.eR#ujg'MHMR0c_B>Z&:1hOpVgjO4N\>:uu_3t3\:/p
heoRT:&O:dGlf'g8^>;V\tasaeQ&=M#,a;G\I*M1C8#(&YaC>u4td+Eo\-s3%?<;*$&KJr5m
FjlF;C?(hW\(:m7AB>PBBqTU=)fK?W)7q^2b^6i)iZ/o;ZX*-QQ"1qu&]Ao+2!*XhNi,-tnR2
-r:jt'g/Ri?m$KoZ*TEH;&rRO)*^BIN(<SS`Jq,\O#aPec:sO3]AD:@WgmcJ2/t-#GYp/(H"l
d_OG<-jRqXkH8]AA^-4343MC>dLcWaKr31[M,9ZLaVBr?nSm+2NicnSAfD<RsJ4If17%<-]A;J
jNS\&XLQ5'>q>u3.+@+U:LHgQ'\IE?U^?db$HRN?iV>VQ/Bgsm8$^Ti:+V?"Bh4\A(K(km$f
H`k!]A1t]Ap,*/0;Q;R>:F?-h&a$Lf;8O5ej$LqdFQjO,isu1WAh2Wf]AH;tNocVq@K_rOf>$;W
OVH2o:Qd>@Bq?8NOQj`IJTOuS#4.lk\p"tg0KJpe9i6A"a[S8=2/*,Y,J[Pm!8>EE0X!=51f
F?cK)mBI61AN<UjDq=cT7fSRqAgD38G:0%8bpg>GkUtRKCjSS[+$F%bg7<1b*03[k0JHktKr
1r1bLAnt*anRd`Ak9RJ>@Rqio3':sF"b1B_i<_5^Rb!YOEe[u.F.W9'AAc4>fYq%bQ3p-XSf
#<=8M'2&1**J)[WrW+d[Bb_UUuEXA7!3nrPu"^sn&%;[,M7LB(Z:r802F!nQb&i-K,?H(<*o
D9mg4p+M22Cer?1,52]AH*YRck-.<A(<03oLpHE-"W(-1T3uaGVUC!`.tF-[o;&h?/g(lo]A>@
.4ee)1WR7GeW@sl_R'Wo,B?%BMam#a8Wf;U4S;odM1Uip"fCu5ca97Z?NJVuK2,Jd0:Et(n/
iVTk/q3nLm8(a_Q[lb]Asn==?qrob4L$La[WEFY2N)@q*u/U8eP#A6RJkNs(/N5[0U=WuHp%d
(=aoB?/NX<\>_>M47\6oNZ/[?BiIkD&#N(Mq*=;f8%e::gj4;5Q2;ah\*0>!N>>p-OC>&iT3
SU!5LB,#)!T",[3nM9OH>VhhieO!aU(3C;Yrb5*"%!/iNj"L<8FFa/71V<p[I,:upFa7Q*)V
hNGU%HIe`QaNS^MFbmCpAEg>.>-M^#MWPM:L3$%-+Np%\FfE.k,/k8nM]A5A"s8#T!;&dlq>L
@Q%mAI`KHV$#<.PYed&3dAZ;9(]ASC2)#)'J/8&(NjGid^X'KlU;EPmrMmfn7agnpa'LYX.^+
MnOY_5l@$U!jbb1=]Ao2pbbaHbotO!AGZGJug'9;-!\;%c6od;)Y$aliQVU(@%C-'+\Cl_i)>
L\i&*7r.R#-c1*"u+D0.t;P1`0"T.(J`HccUY&S&IQ62!%:)%?eHo;Ju@P`%B&*h@>IfZN!?
IeDtO:Nm!'dPR&#*.O;quiVm34ViYXeDi06!k5qh16.XZEYC=NEJMS`GPa(bCQU+AI9B%0]Ai
sshTQZukaQB0d?fG%p!MODI,1jJ*F(V6B\nj/^Bl1[LM'B\dF!.'q2QtL!"dii:ZIdo:u&l&
C>`88YipD&Z=1Ib(I.0W9UH&`o'kqX>"j*<9"`PXO@;sI3T5M[N=K<2[KIVKr9&Un@Y8t[Wu
NI75ToWX4;YJ;W4Vf%dYJk$mC%PO?Toc`[2tE-@("#!r*=^Db6T88D9gPnnj>IM.H1=JZ`oo
[D$SKHG@G$Tk_Hc,NNJ7l/Gmg0*.]A/u#G]A4rE>?+<J.nZU!IF"^?4sR'kK=Fp[:BIlW9A&,g
oYkZXWQl*DajdfMVYuuQOO1oCc?St:I)kBc@f#+(k>p9W&"tHq37F>n_dE\aP90OU!&]A15d4
,?lUc*dWdp,o!A@i`qGlZm6:HdAHcDKhXc/f5c"rRs_+aTR0[S0;bUm04,O!irmc--U39rcU
oLi]A3?4:[siMK^Z8.J,YC5U040D&QS6t_]A/RN+C-G+h1!XkJgaV=3_.KCnkKDpu?E\Ql!,3_
E.+dTcTt7c\pWbT\0!m$l<`Y0q<8\-+$u3Zn9K8UQ$_@i^'jSeT,i.C!j!5=Z"+]A3)9IH\>D
o@`O-Hh9pP0*m8?;`_`HAZM2M`[0ZoqRO@[dh196%'d.mln;K?BMrQW'3+Cid^mBUghlq*c_
9_\^KZZ8J9S6Rc/;n]Arb9aHaOlPGiB0%*JNEGNDV"\DgOb1(rGb`&,6n:Pca".j^4@Im/Viq
o)D4F6,oK"72o[=S,qu*An'V63j\8*sNa5`shqYu'Uqc)!%VrBh[WdPNRV<FEX!Qj(/gFg4N
k:O`q!H-Lp$Y+SVf/pDB#I?F[rA/V^Jm9?rQA'7`%_on!>pQrSZJb$)]AZ(S]ACe!P(oQ6?M;I
-$UG8E&o%BH6"Sb7-cA&4US.oUF!-'Z/7G'K/2.6JN]AOYW[KI_*,?Bsu;)'NS0hGoH0elG38
+Lc]A##_)jT%6SW6"<^a\X3_Q5IW'?HhV76B/94UR!E!&Vb!1E!"RZGG'd7\5qTm[&rfY\g^o
Q:Wc<q$=hhAPb"GmS6_]AS`as&f-NW;T6)Nq5%j6mI8arRQfOY.K+03=n:lR;u*e.UY?$fm'p
hB6W>`,oYi^OI0E/:*?<8Bo;\(^7+3GTK?WXr%#pd(fh1htRBJ[h8-$3]AUgTUWHM5BaIS-2\
"#+H%\i_IW/Y?:@"Lo=1^2(O`ArfJ,p#)c1g6uU#F8+p@le".QQg]AI<Je6@sZM#IF9ll:bm<
C'%ZS%DB1HB!t(n8IS=V3MiHA/l2s))_+]A_,[m3YMp`W(I18D_t^:Wf."2o7g]AIbPRRQY+Dl
cReX%Th$!7F7cg/r&I/"\KY$3G*pIhi>W\.\)(NUiOoJTV4tDl,$<e>6Xk@;.3T^R6*WmEjl
a3E'_o61;A)[mD\E4-S.j.\)?InoV:#XN[kcGmD?CIa(Q#,ZkdJ^:6JAUjLlHQm=[e%Nr9id
131\/Z32ba/-h$L+M8)=eLCqK2IaN1fqc3k;PD<l3C^;p'9.&\(&6Jk9Z[o_[Mgq0cnIB6/]A
gjlBsRD^)fFep7C^5oE1U8pfKhk]A$>^1'SEZhUm$WcC49DXfr6'+CtWdc0pH6b%ZnDjWWNlU
uLj0g#&:C`F[V[7@gA5P;E(B%"qp5;)N[b#)upSpo/RpmG%gMsVFqA%s-\q&a;HT'[okQel?
.CW_dGDb?B"!U4H)39okkSju$a5K`(I*sqG;o8cbSmO#QBhC8g^"r4:hT0lO0>@ott1a-5TR
7u202+]AkOb>K/FH!4)U"ZX^P`Zh-D>l$=]AF<m7$ET"#pkj9/3pZCi,\//BXYb'5=Jum%\)66
.Jheq-:2Q`sQC?P>8FKX/(V&b0_P#auEl"i@j(!;F%QaM^AE-C]Ad*(^6hBsD?8f"fe=-%9uA
cCeg#I.R]ARP\&toO04H%#a6$LUKBJr#<lSsd_DAkFJDVZnQT*"+-idlae3#*jk@17jPNN1FY
7eBnZ2re6O&m*h*MkFand5!NR9RK]AIsQ>Ks]A6ZNfTpF]A.,,!J!/C&/Qp.,`Za4i:EH`gnA4)
9Da6GSb^bc2CYf9ap+QoKl1b`07<4HZcaZ+PB*8['!UF_aK4NGSLYl2e0WR#-[RaJPU)ON5>
d;io7t(KYc`%HP9c)fTWZn3i6Upo!##H[t?XH$,"8:0kUHjKoBEV&-FPM6Hpb<nfd^-W$(.S
B/E\tQQ>6FA9)j!"c9GR<$0]A;IfaV>o>9i57L"2J(nY;VKj=^,fA$>KX/__+(4j]A)K8M/.l6
=dpJ@%hH]AF/UgOY;+J9.RpoD5[,ti+Eos7]AXhS#T+YS-FBNs&b#89kB?s$;MYZWX+Mc`@1g=
\K<]As0eMWRi%*=Tj&)^Ze7pBRRp&?+mlf++_6WiX\U:]Aa</GoI$^,f0Ypd7m(Y"p$slT^<h%
=3]ApNeD"bq#.4HbOIB>9imf<nn>dT'K=)8-*^(1t[n:&R[FAkWaO^uLq&j(&1DV>oV[IdKg9
i25s,\W2,`WmP[Usbg3D^5CXXtf1ShUTbF`cB1(,A:q`)kMf$"3(f>#0ANQ:gJ^U"m=?V+mk
,<:)Rin=GHnAm7!@laNf,AQ,(/g""%?Pci[[ZUuWZNg\W9:fBMj`JDB4Rn^4R:JK97\i9%rY
><]Aq1>*d"/KF))]AI$2MEhQ;b*8kQ0M)bJIr4hUnG.H.nAWWI%iHW"*3DBAHPKhao.Kf1(FAD
tE4RMV5VpT5q6`eFVbGB)G>.=GCJEZn6Es'B"lafC[e5=_AB+5g9<Q\;MKm1nGapV-Pio[qS
"m([oqg$Y?[?:+pFQ2]AL(JR_oO:*l9rO9W7_I;S8k)jr#.?uHZfSp\(@U[p?P)/J2sHoeU%4
u&VnML"b*DM]AtkorXLN71I`QX3U7I]Aq+p*In*_\nL#t1QT0,i(.;pmAJL9K75E'I:Q:knIBr
^AYJ"!6*g/;]A[\n$R-j2[b<4R";NDPlfN;iXmDRHZL\X7bZD#5,#c2ajWO#>Y7N_Lsp$BS&s
]A]A_E7'btBq%e]AGlf&T&K99JdB=td,>>Hn:=L+?,4lYsc3dQYM8E/1Ih=Gc12=ZHE&41"Bj2!
"<p"HTdJqQ\r9rM-b)q@V:,1Csec,P*I0LYjQ29.2-9'HZ\<(:4facc4:#'b_D_*YW>b$2nO
SV&-Im5$;X1E\pd`5imL!c5?[qXJFI=-?T-9F;_UL\2O*V't\IcU@K9C!<Ct1G.TU/PaNUGX
k'0@asnUo@*b"j)F8LOr[5J-AbG88p<*PY[_7dN]AY%/*L?Zd_Lk5QUo[?PJlH!YkVN4f(D3h
(pN5S>=i/1ffoOrVO&5kr5Nc1'smZ$tXmS50tpDo,*4%f?6*uk^tBoFXN7'b(Yku$Q)Z'.DD
&B.tg%=V<##QD-nMKI]AmBI7G3VjG!R'N2r4]AGVmX#M;->GL5D3!M^WjYtbqN8LWjaQt/,,ng
e0h7t3=A!*]AbC9PH&tfE7.[/=r)O;^;n8=@XZr_p'GWp53<p\f9?TD;8^d)3H^uGel@5N"pr
>k\+1iV&':sU?m7eAWn]A-65$RTaT]A(mbnh9a_Ykomftj[06"lkNqsXc`ae88;(JgIU4MYn"i
4k3^MsHfC0`kht8d3Ui5no7H+]Ad1GfZIT<V83oSj=P'mF#?X:(6.82&\q&Zdad-$4DXGl]ABr
WH.DLj2)FVV>[<Je>0di]ABPk*a!i_^6FI.b,mo/QU,Y$%2]A2s&s,G_p1<TJTV$3D+DZi(e0#
S.d62$b,m(\H5,PP@K:]ATsTq3(7a@>h9X4a^_G$(%?5h.Vf1`.V8O+B-9AT^9jeH:artSs@o
nHs$5ZRM+S8'_:JIA=m#<\[BtmhCaFs[GCSC1[?W/782bBl`Zr8n89P8%qSk#LmfQ$<p95L5
1q%#to=O@H9SVDNg5PgT\%lgDYQfc;7RV1>"ZojAXZ<sa*dqmrM4b86[:[Pr-\Q,3Q4Q*Sb2
lJbs$M$T1<&,jtOfIcL:WEmnfk'D23*M/I4uRu8bNDaH@=I[<R<.soFVo?"[qaVo(WS:OAOY
u+ME/K8)5Z'Qkg<T=TH%n0L=/c70GEoo/BHHL7l#K57GJ;uRE'D*?d,k(N@t[IChA=.ZbZl`
VZ>7F`g/j'TXjlBJmn;O@8,1\)q1.Fns8/;#(L"l;S0]A45Kl)kjZU/J[mVLE&&Z3W&EG,o\;
H"m*)\6+5oT:c+K:iSfnK;^gU!FUli0"KiN3n$^Y8.)UfkN,EEU1Tb%k%<'TWU<;i6W.L_85
;";^uf4riPE?VIZ??Ba.qGfrm7JIdLe*K:'4@2eo;i#.r9AblAj#UQ.[l%>ImC_jJDn_Ne%E
;g9Y[ei<T)@.haC<Xll`^9B@ZG3sXo,"sk8VW@LmO_DRDYEgOs+ubXhpre.<s)f%*NOS$Lj?
)AKb\TLdr3?ngq1%%<i`)sSP116hIJ`5H9rkp$?`;]A!oQ,5V@1%;^F/.'<1Erf4<`:^1nIsR
Er,FeXLFYT4?Li$E8mEBC9b:60t9+Ca:Nutr\qPN$I\5pH_3pnQU`>5P9jm[Brj_UaB$T?9<
c\LOco,>97+/MmQk8,^+:?uC*R+hPpA@1d7]AfK<NtPEg/(CY-*ZBtIaH$kpSc*g3Q=(blteE
>XLD@q2O;liGU4"=%!f/7W2RK-JbIal9tnWso>76?^&/X=Mk`<5!?ckg$8:#D74+2Im/&e_R
hf?3"71nd.a?^>WWaYbMI8/$?\Y#;VNnNf(SbO(6?q2pdgEL)8qMPTc<PSGYK#VEad6a@1L^
NTi-C'\Iu<nXH,!U(H(b;Q-^5`:D5J0pm$+`eK"\40M2O\tV\"ELKuk0gMT[:_$1W4=1;*.:
rGkPl.GbM9_dZ&tZQg+mJUR1_M!'eMdaj<HCq0EUAJ?qc?A13cf$3`Q8tKan,f:h3S`F&^3*
Z2uljTN9ap9@c_j8ju-jDVA^\@J\B7"-upah;mW(F'`NaQ^Dn?<e/d!^gF*%o61-.6&f6r'O
ORTaB;_GK-@IuCR)b+D0m=;sJ]A9NTTtR;Ji&hrcec3>=bT:NNQ(T8J:WlUW%eJbqs(Qk@/C[
/s.f6`ttPFJ;W"SiM$27k&G$C`qB(Gli$@,+^=XV?n'V6oCD27l;6\[f-jI-T'3KD?4@\4DI
s+R31>89gE1:.Bkkt_jd8)i`/bPhIOmRDJE2VV?C/GJF"6pnqDu3;dLr--a:__'MZL'9Ni6"
Q;^2c8i`,pMs1.c8c+Sl-p%t$s56kM*95M$SOY6oRW<"j1dT42A-G3[e$/-=$Tm"6c[^PPW4
YQobG9.bU+qX0)Y"M"H)naCgnLU,:5$4E_qT""3;D.i4#LZe#\Ioi^at?NoK(jUp)-SUW9^e
XUt*1UDBE]A!c?IgB/GjA]AcG6=u^mZqR\lTb6i.J[kA;LIWROb"h%XJTZ+5lCa>KV&sk*rF\k
3H<>#-1j#:0s4;4P;AiiFLpHc_JJY)P'2;#NrKkeWf2coJ\Ljlg11lE?BXTci3KqK#_6`_#E
iFO[&;\U[.F;j.c4Us#PVpla&WfGJ3h6T#2c"`ui<eA;+&Ji2P^hNm,K6ohP8p_XR2*eP*7k
GdkmI?5E'=/6=E$@Y`;C95ODJB1-/k_7Or,/FbLXlL9T(!fu2)?LM-THl)Xj;oE+WHb4&Ue3
KNX!FP1*k1h(:8Wt(_=P;PU2(o+P,GhZqp@(Ks-;c**asUhUP!Y9DUX2js.H6&]AJXKC]A(*RJ
308RY/7&u9FD%KnE>g&n%97skVA$4#GE,ns&AbX_5CQ:I+A;38%DDHm:oq3R&Bc*O?72):38
g?7GSS;%2Yi9af9#r%dW_B-d%1A7rW^T-pQqS]A/A;ShM.JW_=E=Tf7,@\Wkr9&7n&bt49H[\
EG&DR?U5nZX1DWJk\H"0?[i!VN5'E!$[H4)jG(U',2(C"Io=Ja5E1fQU*f.?ld_GMY<PLS\$
Dp%(AV+n'SduEK>d4N;pkm+*dU;O-8N&"gD-TJ!*d6]A-Af^,1pH&'N+N`X\__EU(P1IpsKPp
.F70s)%Z^q_Ef9gTYD@LPb_;*>hVO%1N'$T%;l&B7BcBW_dtoq)!*8+^o?XceS2>n_^5J>l?
6fk!9#Lhmk"?tn8=97-fo<\]Ar;3\+^pOO).uRO$?/-l$j"7HhDo!qup`lNUG:jN0-&7!/`)b
o,]AQ>]A#+*ijeFI^pE?ugQK3q+*nk/GAL>qrb*4(m*&=)j"YTV#5]A=)!Pp^had\G]AT5R^d/kU
uaOYDe^'IHdAf#Kk%0V66an@02*/5&.-AB&+#/J*c`i==W!J1jOC`18YUL#QO1PBr?7`/a(n
@OVXfn_tfqR#-;%@6=b&iLoUI<MrZAH>l'cfqCTW;<glA/n.h_>h.USNi.ZIdt:,k+p5"iCu
OZY#2tKh1N9WVO#W+H-dO0V(@<oB_Si'WMHi<g[O`CeAWK>A.Gu2]AJ__^oXO7O1`7t)'c:X(
%nVhmHf_FJp2L]A)>]A?u/9(m*H4W7pha]AM@-#J5M4A:(%6N1'0n\M5NJU40&_<1Ff,lVGo*J3
6`2.)XF:,]AR\hP1>\mW"DOc^@?ltbi_76"NQo[tBYaW?iT)9;1b4Kj0Z3Hn9>VSr$\EOZEl*
m40''HBl6S*PdBMo`d4$<J6nam91p=cR8"?&Nc/U[pm4F4&3eX)#iahUb#,OW5.SDrXS'alh
Oce/b/UKq/)'NUZVM[9dhk13i*5U&),'2VK)0+&]A\d@mLE#<P,g>aM[2I:[&;'M">DP"$Z-4
<LU8P0r"7R]AJX_`<!O$[07=MqeA42D8HWM+qKN<3asKACP\'ZjT%hSPpkql>S278]A:09^7!Q
m8mX;R5;5ArLiJX_"l)jZ_dLZ4>d`"@US?$>3")7"MMW\@ik^WW=Qr4;[8PM]AchTieX_6&**
=jaI30gDp#V>W*+2YnsJrGZ,3+Om8%\<mKih3@YG<klc?1scSIEk@=q9`g['>j57&H.p7h"`
I$jZdquB5-lsJ65k%X+Q5E"SR$d>=i,H%TD;Jh8c(d'FgZ<TQCk,i\g$:K=KCpc&#A%)1_O6
1[R&;Vi%r5\(@8L`VJ_-KCYTb9tK>KVHGkrGC\)o]ARdUMD5-LAX1PM*UVk2j97&(o#(mb#9(
CjTa(\bHaNDs$1<*tjKp;7h3A#:EKqU6k@j0$.2Z1pc@@Wb$7.n`p$a$1]AfuUH/QCPRoF?U^
DfFR<o%@[;%%Xs9s0uSH)f6>dC1!r%NY9o-Z'IK*Rm_>-I?jSQ)I<H'S_1N&`\^,1fj"ZA+\
uX/E_oB]A#rKkpilf-c4d*Ma-1\7tP-PgnX@nQ]A4(=H&_Z.o)@Meb@9!<9uV@Xqlqp"mWFY4p
,@2S=kUhb'JAGcpoMZ*e`L_j*F^:Bj*R:n1<%IUKnf8,g&qqU:8BLd"9LaEU@U15HkucG+dB
N:?1bl28&,)1+hG?afMM95j:*HIe'V0LV@NQ08ncZX!qh4K9*p$l).A0;!L:COWg!3bOG[(.
7p`/IGMr.c]A%2M.cf>nUgqkR,q.%m?sl("p]A%I3mo`2F?/B<VkfIF*J84@Q>kipZ8,$=\\$r
"S&FpJSEK%&kkqnQd%m5dqTRGhiSg=\)F>,0;-)#%^($7=H;H0YO8dKDTs*j9^Ca1`C?=k&N
W$<[$ORDloccZ(B)-"%$J;^I(n0df/d`e:H.I3n>BMJJ1O8TNKV*-P+eOgdjmBsV>&sa'+jh
bb23'l%h3R?DS"(eqpU'L4k;+8b7/74'V"\HADfj^J!Wo]A\8b%dKSPB>,B[?(<b/+b?)kN`#
eM`nbkN@\/2HX9NmS)DV#PpcGT0fV#^WUrN$^7]A3El4-&q:i6E0Ftn0qB@loV-fhe>G<VB*E
iS7di:V/n;T*rV>.Btb8l+%_dV<04X1Pe`:L%`#B4qBGcQs%C2.r9QjoXsH`-.o9Usu,ebl]A
f5FB6ID-q_8Vc;g4ld>%6%%u9RR>Nrp6;T5*JUT8eptpkmg7Z9&E2Cf5pJ-^I`)h)Vq#[]AWW
+JX_-e#iWL-Z<pT34=NAnU+$iI4V$)loR*In]Aj0:snOj7pS<^YVsADVBWBe2%<dY'6&qjUU=
MWreoBIIVN^drc1(X3duECQ"X_$+>1Rm^G,Jgs!S6R=*a\Ki:0.R>4s4kULDFXeu9b7=q$Ul
<K-Pd4NQL+K&mX#Aa_k,/Do$T?jG0/[,JmU`*E9*BHLcV;m7#tIs7Zu"6i`L_s4@!mWEukTj
5&9@e,X>/>c4)q>?W'K.u6KSp8uM:'fWg<E;sM^[f;6dISlYmlqa%:\C_ZYK"7=_PHQu\pEb
i[@8mAr4f<eINtP\bqOj,CmI.Bmlr>R?"ic#Q!:q`D3q_p.Im(Qo1_PDU_XO.E-a4s_XkUJ4
Opst0iHE/\JZcmYPQYGg;eVHlWgt?XUSdkpj,h.V'o.J(8Z=BocsT1ki/W1[":2AhI,3)_cN
I#OPcIAs)qkT4u"[He2T1:0R2U99E3+6eQ)RgJG=isXuZ#j(M[RV#@cSJ\r%W9e3d9j\B[83
&`qn>7q=CR%':A-ATPA6Ce-([r7IgJ3juZG7N6Kog6Cq#^+Y^eYW@[L2L2]AF4O!B-2VqJ!%m
[O%TVIb[CF#p=K"7OSNJ@L`mfde22fKIJoUH@B;AdHaJNiR^[m0(6q0bO,\'m+U/]Abg2,)\B
=SG7i$Ta_#d(qD9:I$6hTWC:Yk/)gUA!<CAAX.sP[m(F?tQb.=1k8;B("5r(a1Y0mq9TVU$0
:9r*cJ:sMldUZOd-/F"?SKlW(8q1<XQ<1c::"Q8=(R'_e$UhUb/ZRCAc;DY<Khlk&iDnD>5q
.*;VYjG%u>@-Pk&$1Lr]AtY=Fob8Q+[ZC\lg)G>baa4nB)7VBc$E4X1FoN+Y/lrIp$hqhJ`(l
6"@mP@p8Gg5%_MTHC]A`f5OIRIB8Jr:]A!D7-r[3=q>6X:gYT,6%Sub>=<4mfr`nZ(CHrm7mq^
:PK+&"@l?._gEO/SHAjq,&uWkf\jr*,#cKF]A-*4q\uB;JBPL[Ds;`=pgUGPDB1McM2b]AoL)6
*l=DK-_RW0CjSu=9C,(Z]A(/CQYFad.Q$ojq\H2A`N]Aj]A'M#pNO2`in.(U6^=ZJ(ibf6^r*7i
8SsK77=UbZ#9=qX#"9*^D]A6]A/(A;]AO08C7+u[Lr2m>]Ab/bq?1qg[7N[Gh_CnWU#-er!C9Hu-
q=&>'Nmm/O,dK.j%6hP0+>jIY$bjgcH8/J==M[?=5aTXAXLpreT2'p:fZ4Wc('<L`<G,*H0Y
o66lYG`E_U0S-F(?\SZ?oYE%WXZS?BT^>pfCCf'EL/(.!.KCjFlK6Tc@NP<J?\eW`If+]A'XP
sG*%asVP*<<J.Lrp(-e*?np6AtTI5tkNb?&1s@U)L((LF<A-K)Q.`k>tX(7%[aj?*Cc!N'qR
goJJ\nq1b@<Xh?:/0'MKd8Z<HmT*!Ka"$<SQh;r"YN]A2EppNO;(!5);(iTTu%1.Jm]A!!)^"r
P/9i[W;Vp+hI53Rf470??g3;m,N3Y:5oid04e7[K?#J.%GS9oo*":h4t5I,>qPJ!Wto$M.YP
LfNNg(%7uYqVlEdk-*:R%4anjVWapK-Y5H$uBDe8atd3j/Vs#N[Gm?Hh<\5<7,Mm%@-1^!d!
&>QDXfDhtpMQI<0O4L?)!0_V)h;HR[[A[tX;]AiWPpLQd<ntoDu\RtuYC9n,co2]Ae\@\L3X2u
gq!.)0uhg!@pP^T<)A5On0[r%m;U'@`IoVUYoIe(f[E/?Q:DR[Rsugu%ORNf[h5@5'$QXM*j
*8dij;I*=,sJ"@l:$X>`QDb^]AHL"TX_%,g:Tm;j#GjO(i.XadhBQ/@B,r7dd:0D;NL3H8"-q
:Y!gO=sFs>Z]AMVNZJ?h7SR%"UDl?rUO_*7c,u;c?a^5oQH$:Ig0Gfg*uXkKgo7QE<K/!]AQbY
9Aa^TI0dp'6PR[T&hoc%QaQlI5#(p%lqd3j&P!7rOsIt^=DFufSN=14bqrKf[W.l2=MDhGQp
beJ%J&7&>SeZ*doA00E522D+]AV9fRpWbm="cmcRg(eV5@SVbsInZQ;[rC6I:?U5t:YIX;/D_
(Qh1k)p).TjC+W`&K4H_2$L[ZfE3Zr@N6?`7ut?W.lE%W?Y=8^XO^RYCRqJ5Uhr$dUZ;3EO:
N+3jC-P%et^9VCU&r[r?2hi?XpJ(3GD`B8QiLlg(jY#YaAoj0mrj>s!r)]A@eXmFlYiBE-?L2
S^_;^J,1A6F6G%9e@]AAok"qIGa!INVKSuKgT#,!O`"f`T48qc8%Jt^ara$O0^XbXlL4=oX,_
u8YcNc,A[//VFt9^J26$@O_4bEiS"GD51$8]A`3rGUe*F;e3X4LUu]AlIhj;rh.9!C-HF558".
LWBGorrN~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="true" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
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
<WidgetID widgetID="0443a23c-a38c-4741-b1a6-c5c3577b00d3"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="2" color="-855310" borderRadius="10" type="1" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[=$dept+\"人航班比\"]]></O>
<FRFont name="微软雅黑" style="1" size="72" foreground="-15386770"/>
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
<C c="0" r="0" cs="7" rs="17">
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
<Plot class="com.fr.plugin.chart.line.VanChartLinePlot">
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
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName=""/>
<isCustomFillStyle isCustomFillStyle="true"/>
<PredefinedStyle predefinedStyle="false"/>
<ColorList>
<OColor colvalue="-4049615"/>
<OColor colvalue="-12890274"/>
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
<Attr rotation="-60" alignText="0" predefinedStyle="false">
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
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[人航班比]]></Name>
</TableData>
<CategoryName value="年月"/>
<ChartSummaryColumn name="人航班比平均" function="com.fr.data.util.function.NoneFunction" customName="人航班比平均"/>
<ChartSummaryColumn name="人航班比最低" function="com.fr.data.util.function.NoneFunction" customName="人航班比最低"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="26db09d4-ca1d-4763-93ad-828746c2175a"/>
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
<![CDATA[]AmL,g;s1T4:O?=",=9`,arldlXJ2ZO`!f3h'iY<(![o0?+As)BH,sr..b#Z869o*[OXYem&A
f.0MMMB9'gdF9BF#bH#_@X?6Df5;D+gUJHg^:sqm:bmpAW&h]A^&khqfXTaE3rjLGO</[pYL8
_Nun,njEp?DJ:?t#p\d;T#^DNEdFdp$p\_cgqXl"FD!h`2EWXb`/iHK`-"8G:cl8?O$58gl>
CQJHJ,]A5Zm=C>55>Jl^oQ-LO^%]AWu?2a?Ss8)AlNeb$@\dk?a3C[c;&,!-E86U=ai30l[[1#
-?$50/:<H)IB1:s6Nn>uoL%jW',#KHu``.Fl7&=T?,M`rr!pEgFK\(%AW/@cG&S/j4?@e>ed
egsju,A-i\XS=0s#El.;rBO/o<sl!lL>'K72r$Ud4SYc@X8W4C(SUdTj9%&93TUe9;sbK)R`
i`I,AIIdbdlBb,'ke$&gM>/17[rMS$t&kbTNhuQl:4Gn&4(uffJ\MG/TAJ>K/M!gn#tS*R[8
mh7BurH`%ZL/Al@^4E&+"O8%rrD9WkXC)u^e_?8+"LddHTREHY\7/)Q@?a?(]A43F(.)Qqd.I
!Iq6I'T+8(gK'BSTFdeF+YrWB1YaZj3%B<:!BAgGFT;q72NDTf>aH*pjcY[?R'r5_p^C<_iB
QI)iTVBkq_<`F5ulHF.CK*e59Lf!nV:c2o_No<+;"!2Wm<,E_7b(NG%nLQ^B==>lcl$TBBa4
TGLBGmjn6I$2D,@D8sa3Tf4_#Br+blf`MH#oD-GVpWS9=AnOJ+_JHdq6^nsA]A1Tk:OafZ$h,
2,e5(/]A8pn[BAg#2=>)kl;?qH#ff]Ap?\T3Ng/l_B6sFZ&cGo&K-H3&'D7.aGh8`.)@u,iknn
:/t5;0[KVR;>e'L+\__G<`NP5eqH$t.J')'r0;,R5Lf8ITS9=C+=/jK/AA[n=T?`)\OL[_>b
N""TgVN7+n7f7:61.)f.3]Abn(o(\TY^-uMc5ksD7K3K9nOrqR=NV,G%XQJHV@;ZeT7RkT+"P
E\<orCE)/e!FM#=fiaQ`:/_p?R&T8`O5a9M@hp<^1AkZVD;3bh;]Ar5[+3/<'4s,@Z''2'p;W
@*uCk]A+#"B+u]ANhZu+_C7I2a94O;,S[MT'F.M6ur>K[!QJXI#Z1oM.=Bo'86AnjMm"DjGln/
K#,oRSY!h,h$d^ck(K5*u?VW(NUe>&i^a1Ttq9:604@A[@:Y3b[QfQ$tM,-&\)nf4P%q(H?/
=+I\H"5j>GSY#.]AjA*7`>0`Ao@OL"4cIAjt;$mnf:g&6Oteo-c=>i&1(KeGtnjVZ56Vj!rYk
]Aa=^S)YbJ7Le$RX51eZ[3O?>@5+'ifY[T$akj3aWtpB6DMa.+UY%/4"UT1Nf>[s*@Qjn=kam
(FKY"bGi[bN%Z'50jr%196WhZCJ74At4FBYP,YX:%kRU0S_C7k)O6L6J"9hIrrbt7A570(dF
-0V'V=tT)j[BGU8B[WTj*p;")?ir^OXkdm2(,+jmYGQgu9YiBQ&QkgUm)$:kSGFQZ[O56p]AO
24cKq4f)1t.B7qTZ\["dXXVNS)7%#`Ip!4$@W;TH^(*k+?ks"q<o@Yk(c)HVATYp<5kMjN=J
fX&jEUMM/oa]AK[D3cn'@W[N/sYi8X#oOt)?O.r$K&,PI8Sf'S>L7NuQiM-N4'^fslHi@Tntd
i,qHD!/u<I`'t8<dA(9;(aQiU:6]A.N]AR0I>u^-`;ki[cTYQINlKTPVV80%*R4*bp!#rfaZMo
9s*joQ14[/b[8J_iKCA$bTW[;Mk\lRgh0(KV+]AhC,Q.i=G;J_]AAtr?^d?;.7LiqXfT'Hs)#V
ebusUS-Ql;B^FXTC0=!+=.FFB(oL#(<4_9-h+[VP'!6BN">b4[Y>gD?1Ij%!f(sQUF2Nu);t
>Y.Je]Agj)JU+;_EtuYA1&[?YZDmPb#U0-0TB0k\MB,;U<1Ka[eSHFl&3Dt\8V%NafGA?a$Gn
m;ZM=AjHRbVr,BdsIIY]A#qq#9G`^YWA>\8tf^TjC0^<R_RB2%dhb"+MRr]A&TnNTF0s@CfHlW
Y1.AgrWn7mYAO0i+<DKWCJHP>uTd**<stoEo+/R<t7^BVcnJRg!2$=(QIbS5))Jd7BWWDOh;
G;;A>@!d)"a%.B0]A>g5:LQ$3V?59.m<S:+)=VDNREdX?6S#A?%=@'"U3g%LAiS4:2Ce[D!u$
3=hI:H#D1;JJ)E9\?'O>XlGrPPFI$N>fZd8B.N`GQ8^_%q``(n>/eR$s!IGRd/BPO?DX]A2jf
G9Zif5'6?[XSQU1LVLXcCjXh"P-WaQ%DseO!^,c?pEOC=L[)4NkfM+#Y[]A5Mo<'ku7luSc2(
)+fbg%Ll\=W>rMH;:/pn0@*;tN=Q*82f0oN&G(Y=IOgl]A`GuH*3#po--A9Pit6A,euOc@5EK
.`anB:367iW[Mfb<`3J70IEFYhH$^J3Vl&p^<:J4us[5G9ABFR>$oYAZ_UBoNC-*=I<-D+3S
biH@\%W4HsEl=qNgZ1W'`k?LpkBKV,PEF:>#<<2[t`F\iXL^0GQW,+:U;qZcLfE_qAa2T#EP
MP?UY]A9Stb@8nt#)EbomOP+&]AnRt*qL=Qb(6rqIB-VQ[0[#TAdcE?FL-_jHecE+&r38%3KLn
un1Fa7qirD&al21^PWc/hD!fb/8DW3U:pgqtYn&&Ii7^;AVFBuR8egjU3TAQp"e:,S9nLgRH
]A1N=PZ$*eTVrD>UnL2_a51+6bVNNr!fa/]ABfo^8(WC!(t:LRP"P0>omR)Tn1EUN7QDYdC>"P
k:42R$O;AB)5HG'5$Qk<Yq'=0+-j4g'Cf\B<Yt.:*H\KK<[Dt3")ts30&q)5:DJ"?j+h(T-W
n)NHLgt!%dUaLj=Bq;X:J4ieuFmEFi1s#`9QU:Q?(d"Mr]ATa9)m<n1Cl^]ArK_6MoFA+X=[W4
,X/UhQlFP#7Sud.)^1q'qXIh4(HLmC7I*6B*6Xhp6Q[=tZPduHE^YT;=M3_XWc>?7O)LCK]A?
7g)k/Mu>-2O<c/e@WYL8"&mjYU'L6<us2KDKFOf-&D8nOpllNTthq)rdQe6ONf#6MgaBC0X/
N;,>R^LRsS"S"P_(mpUl]AJ;\U2YIhgtZc%hp%S@j:\e,5X1b]Ah^*o4Ru2[eXX(Xhm_i#Vco7
t!*GV=f:N\Xj([ggWri=R6Mu)p[N<C<,+0ZKQfqY;]A,]AeP4PSg(b@;";(<oW?@O`=`cHd(-V
NOB=3uANYkO("NCKPn\BVq@:;4TI0%Bf<m_]A".$Cpb@Y#Y)Apj[47),j=7,7j/O_-Agae]Aj?
`@5V-;6$NaqtNs_[LlR/'XmSSlEq_d>6k@4@l1f?Irh\)^]AAZ_4PtFVBKUX3>_]ANH;&9Rf,8
mRGIc8,+-Y'NBJdbbAK`O""GI.9VT7I3Dn7;7bA8P87,t4AZD;\,8B2pf[Y,YiPdJ]AN<b^G_
F>jkDOPY#"_V#XHKPp7\:Qo'!X1?A[u^mf/]A\el6jfJF(2`&u-\BF3n:d;3Z?;r%.E#tS<BR
Up<VB)2\VHjWY1C(10h]AR]AI]A=[p4n^fSK@cD61Rh/T@`j;idj6O2Vr3m0p5NNe2U60?R:D_C
a^X/r9a6F`PTYcSqdG!qq,5UjZ*BkQAE/Tp6uf2:22"=R]AC.#@jh2?Z_q!J6b[C)^*K2N#6d
dsXSG4oR%"7Co8p`n-d+_>?t\\C_N6p171!ofE,ID5k<(>IRMY%ZUb4/^8[f`O\HOXq)2Y!:
/:RcLAb7)KQ_=B\&km42L;XF'%=L*H.ll/JSO2k8:\X"XZep#Z<"*ed3'aBl(CO4;/N1(T,_
AQLf4gctRP5<cAMQPSYZ/TGm:[T6oP]Ap"-9oqdGRld5a5fk>_#Gdr>F)aE+e5\=.K)M`h`Mf
mIc?8p65)bnQ/$9CTWPe?-K8mQt:=p`;1S3?]At-9IlUP[QbXN6MG:&ee&1qJcKf-2`DGMD-?
6-[rUu[K;O&ZG-r$LN!#@,[q`a)TRq$N3u1VeFjRbUoEg9=8ju2#7T8=_D#Bmf[HpE0=?)md
+baDDJ>IBb9%>U6UI3?b1]A9;,N_!q3p)Ye5!7+t2Qe<;ggRh*?5?#@fYBq?17d[<2c5n"J(W
SmC3`KLmX((J;3$gTiYaD,Wo(g8m7@Od'd9od($o]A0U^q"*bpTA\X,-@3$hf2dX+Tn%9#ZHC
6O3Oek\0$0&,X)5GM7r0;.&+T9WuK?*i<Gk>,#-PS_[pflKXK^[U6PI\1(a.p1MAs@,gk5_/
Qk#[NgQbhFsR]A[+<<-F5ZI^cG.$D$69JkHH4d9cduK,MO4]A;p)#,*Xli?u3*`!X5B>SsLBG*
LM"U[C,G6d?JL>=L3d4X51I)K`fFnuFO?h'%/BR+hEBjFhpOU;3(a7;8B`NVUa@o2O['qWpB
AepQ;rH:,t*W`kO'X0_7&BmjdjU%lD779Q673hisTGJ$bC8;?Jo,$p*&<926O#q@E2Lc8HTD
%6LVU2\ti\W07MOgoU89H;fH)rAg"\Fp*NDll`V8"^sb//ZD;X[qomG2YJ4bC&\00XZ9gEZ3
T[79Qt)OD<gDkI@k'=hRGD$TcR[ZWg*TLfHrR&X?3o;Q_MYENdOC*(/,5nND!f?*)a-fh!4e
lX@M;+$OrNXoSja2ujm<7t_HWaJd`F=?Ds0\9e">lPS3'99C#'5r(`7$rFP.^e'f"F4;>O[Z
N(Ba5V,[pH@-hMGA.@MdS//<(M@lRM*iI^Jj-ef0*Wh9W:<pJAr>F!D5IL&BB<7tE%d"IT?N
kXD;![a.:hS;qNNoJrO%)BD53m^mZUB!:?&&+0V6Tqa*8"+)l).Lj]AkRdXqY%m,g,F/sf-=\
I!FKCK4G)9XDQI;^C3o*q(*b!tn(fU5!L.(_\g2-m%H%pgA:U,4dVk6@QsEnSGRB*9kkCi]Am
7d6Ner=fZZLGfFkB^1>!Rg"E.(93<'UHbR-Zgq*mY!'um5T$^D<Z<ZX74#_c@hQoNO%1>c:7
g#q/c^F^;%'+:_eqG@OX6_HL?AE)c_^dr\<7YR^-<@2rH%-P7"B?N/f/X@Pob":K^>u<iXE8
N9lqtRu9Trd<4DR!^qCstcV.tK5MatcA=HJ6$;X.7n!B?=8'%?_8,n(J,4XmM]AaWeM=b"qPA
<DT"1k.mSDj<b7eD"8S:$H^L9IQ!;2db5O7+F_F<ge)?1/]A/X3c&m>_6+HN'UTWoS)Mbl.pG
dK^)n%P)ZDG21FBWt%.0V^FV-[OK;;fHU_3k0f^?T!r+&,7Xbea4jJ-hSg+A"rZ-dokVT3^D
7./9(8JXrpF[NVtV<FAJ%(S'`+a3^,;@6i`PGU8pV;!)B]AD-&Im24_3>na#T*C)rbG_pSYMB
)1Uu\TX:f8gHXhLnUJ`p]A9]A*S<6#H(olG"G0.5:Y2'`T-jnrumfL@cRBT^L,s.>0ej/Bg?3C
:`_[8-T&J3[p"^t>r!nmRo(MY@3KdHT^aOb6K!K6c4ol_j=O:e2G34`T8/1k'=O:kGXP2ZD$
O;'\*@ld0(G#Z'FARUrQLF14LUrd'IE'cZ$LZCCSPOAhnS9qM[IiC)SHAe_F$&_a.1?tq1&I
eY)5)FLCk+8E0UL'lVd6@3Sacs_;dsA>5p>A1OH/`&We(O/_T*7=`djLqG%Q8g.Y+FSJ;CS7
4"hd]A'EA!0MB+>3>4IrD$0_RA:qt')Q3Dh`%DbZ:XFi%l8Wd?[31_N:F8Z#MA4M%X5[dEpsa
$D)LAC>FZp)o>cRsXig,h_.KXlV?:KV[L+2E*SA7u"$?<;b(dhB>;+5>0XCN)?YeFM6IW@+7
THcd0+pA@l,.XSKj7:pK`rQ(j:2(o=SDCi;ulqOi!7"$-]A9OR'\f.J)n(s3>%:pQu%]A&gePS
3tAR##%H0cTbF>&etTopP]ABJ<s&#7s3cYJgU:NBK'Y3\h3<A^1*HA3='5Yh.TJ^2f$Yk_j:>
Psa`&F(dG"mB0YtH>@;J0tpN%-js+:g9QaZ<PI,.Yba$USj*GDi`(1c\hQ"5;9HNH7;3JtlZ
a-<s0oC"JQgLW%e;]Ap^(VJRn\#ZVigBoP*-nA9bd:0O[64a+6e/[0o.Vdm;I)VB!ZPa0^ubY
RaH`oe[.l_N6JYk%:`:Wglkl7C&?&0`Tf$r+R4OI=dfird3)\>RSj.s#t[78ZkkMgrX;L19.
iqP<T9YjIpXINA;n@aQ#d_O(%]Ah(O3<*KhdDaNmYCi/[\HS.MhIVGKYEgSbr3Y\dRd%Rb9Oh
X=b%bcMAhg-9J#iSPc&l;hZqt,QiU'/P2(Y(pARO2OBe=,L):=&/b+fLRYT9DgbD6-5_>#Gd
lVIQthBFp:?00;,aA$Z%RA?a^,IoW7k3D4F5<21W59B`bT6o,PK!bNh.]A$S]AY#k@HuFJ6W9G
m%[DT6*9_#4gr&rB^&+A'N9i1J"1&5DYU-q,m%serMlL0[iOQWn$/8[d1I[>\#+R06a2rBoG
:ZDOo(^88SNANT*midt0A]Am;+o\cCB=e"nq9S_Gp^I3i)jnFYn'1G>P;Bh=5$^@]AP7kmbi,K
4co^t'4b:-Vo@8_C\\)Ag]Ar*$.#Y9_N6&4j`m@oeRNEpW_KRS,AdG^fXs4hCE%gr5?)3;,:t
iuc:r(OZ[,YB%\@j[f"e332SZ/P5B.f+XZ`q1Eb;j^j*o03*<Uib>]A>hK%Wf&.+rq)<F.AMN
r82MpO`JK;XLih%+;bV`l$7I_oN.k*Kk;C>e.8F"F\o,K(u`DrHBQo,U:8EVdQ+a^:q[R=4e
Mgg9RDK-nE4gGl_T*s4,(kMDQ%/bV6R\W[Ka*VYu:cp<J=El4Z0RV842;]A/n[R1;2#4+0M88
D@?=T3k7V\e#Xs>IUq04.C?(3Gp1,]AA;J$@Vk9"Y8+@N:BJJ68'i[^bhWHbP364j8?ae?`b.
3$I4I04+%UF=WN$A5Gi4,)dqApC&/K^$#!8LhC98"9\W4m::GZP_`]AHFdb?uJ2RomDY"&>a-
*?ig,[Gi=u0IssWF)LoD.:c4eI<5AH8GEM[Th0j7nY"=;d@5%S<WFgk]ApKJ#F+GVR)ZZMO(K
1LV+Q3EHp.^7f">S9-fV+4`e"YP\YUE4d7lVWm1%JkEYRqg*^/mY)f$;4ADpLZl/=)N2d1SA
q+aHCY!16ppf$9Pp)!L'UM0P\W=h"k%,W21)TN(S#q8Vj73rNXf1(hZ?3Kl(04n0>6[K]As]A0
uQt@'+,n25Rr<(8no`=4!r1["scG+L7$]A,p1d23hNRUnLaWN"*SB&=!qC;1X:k-4``^6ge4<
>RJb5&(q8An,DPgmcOna*0Rj*NF7brcS(J4j8hahGNJ`^;NB#.'_ZUHI8>hS?mn.7V&b:SiL
bu<lB\g/d@W.keHj0j@ekB3VPZ4KiU(j>PI)KCe+=b_&qXPs:u2rpn>;=^r,2HcWb!Eg*MLm
cDf)UIDT+XFDSi!$KZCXDnRA8[a5M7K>&F!L%U62-XA8#5Q:,rU'T$t&Ls^SaN.rIW?KS`V9
g#,\[_QuON?<RsSj]AoK/:g/7T;$rJ9&ipX(f?W?LK0nV26:YH;L?"*-GUk?Is!RL9=lZrNcI
dnbNS[`$'ZM39q`@7*1g?'?)XBYTqLCh'4i3S!gJ:j0OA7gmCV!jpae+YeBMU^$K/D>XaBC,
QbX'alL'?t2l\%Ouj4T6!RNVGG2SWCotgD=^!119@6id#:rbkKVGE6<Ao]A%NY7,?WH5+:E9+
dsL=rp0joYDd*>nlPN=gr0E[Hcm7bQiYJMgP!+9XWG=pCC4linSQM*u1:OE4n;iq!]At2%sD*
mfEDj(YSB;b?KgM&O(KF_NM?g[tnHZqNnnu4YWh5rAk(,^*HNl@d.D3o%i!]Aqp8!,NR#s7?@
_*aQ)FD30'Lo]Ae?C66UZTG\oIHV-rcCI7jXUB4o(V-QqDgC1e;Md>^,2V.CR'b>A[';,fL-2
Cm>'54W"''RXVba]A)&Ds3g28Rk6_^Pp:-&Mi;S7("#8(l)"=[@+7ZXShk^[T>@#^3K+jdCaG
[<D18RNbF7nWs73_lc2O(k&5dbo):N8aFruaraWrP)9i#aW?pf53h8ei%l6&p:c1uGDKdOiS
He^?!LhH*rd)7!G/"^[oJ[W\-:F_Q&`"BnnV^r5hJmqq(U[%"Q)adbEG)EoO_O+?G`R,1m%k
J/M-rJ=C!kQUbZR(59eIuGY`'bt5,A>9@\_&K+.?lE30)05(/0ceL/EJ3qD<&.P)Lr&DDi'I
.OP8RB%kJKF_#<:AJ3g[@JK-+O<e`i*pVbr#V06Poa.$lN=7)#&]A+5FYX,<(*NBMX4%Ykin[
6J\.@T*_:@fE3SepRY[WkJ:>P`>dRaZA`Q8^&Jont!=pr_Wkb=)\$4emuefk,&&&Iu.uiO&d
t"+1E)UflS&'cK%)1g5S!<qo,-6MM60l)1(tGHVZdn.;t6F0B%pN3GN@GjG#LUKTDFAppLoU
h*\^0COIun1q*,@l)PcR,(VkUk^[At[\.t+g%lhg_;%q1O/&;.3X@Xf!?!Fedoo]A!PFYE<7h
7HVgdS9s^fX+_4oSmb,MocXFfaV&IbCSn`H*K&+Z4/R:H6rj8"Y%21e(>6iK68`[@?KP#K9S
jg9rFHR+!dM,;iFN;pE%^S.m.t2_t5]AO;7!@#2q,g2)W6D0%,#%]AiM^6=Jju,iD/uARO7]Ai+
(mb@HueNW7Faiq;f/!fI/]AG&TB7^+`HrL`@-\nWgOi"kNg$XW3@=1Wj,Gdam*o'aACChX<1_
`PBRM(jZ9o@2Vi=rBGA%N0M+/H;R`)Q$)h":-THlf>E!_knCA3p7HN>;*SbK6gIe(9:Bd-dT
d70<ro3kOu33(lHCfrlhW03/BP$`AQiJ(8?NS6*'"?$doK,aR24n;8,)H9qN^N$2T<k/1PA&
kC:b#_*5:NBkIb=31a:$RF@_;/L^F'4_m4<;CK98H`^*S@(pNNciWKg?OjF^;ZX0LcXfEg+*
BkD=WJ4kPf.jG0nfc9BaN+_gB4"uTil<NiD%ie\oic6ibu'IRO`>WQD["1r3]AYJ!!VIE@iuF
ZrK]A5b"fQ31!X)qKn@i';%5*;j]AqgF_p#BMjRGY-tQe1l^jN0Ebn;iQ5uCB6^eR^W.t9<3l&
W9MX.9UTK1Mg-Os)cEj!<M%+AAuMsJ@?dGB;G\YcGXGu]A3]A>WK0l*QL&H,;\.+*KYV%LQj8m
i9]As$-hq]AP[1o5HL>uK7!*_XjPqCpMY+F&NDRJUPc96-Mb[.E_0=9*u%2jpE;:+N?+FJ9#Uc
ljdQF%>:HVN?,?<SJpX3.CsG#9aAe5_2bGBNV2Ac=CK+99i--E@3j-d@c9A@k=UKi?os(Q$Z
_ScM<g_a3F@&-F)dW:A=L>AUB<dCHPA.HL1-'`2$1+I3R/9BBA^++^!B3RS)s_LUjjEll4NY
BWNu'Is_)OjIb]A3O-/!aO^:Ge1'!U>)TrZa(^9*h-O)]A0Pi&O?;;_g0*[t$8VlEW0nJO8H"m
]A>->R_"X;;j`Ic0(*>#C0so?W`TBo+A0+(W\'=!\JZdT_6$4P[EZUk=1CSL^V.MtOe<*TYGY
Vo8;3?+U:d,t/O;ma`)g]Ap<-++nKmHipq;BQ!odQF>gLm;LdiCgp`qN;f>0@ZtbXkO=IMg?m
mi1!=(Y-?Sj`T<S-F'OQqQ^%(]AGQY#HGQo&h&4*:FQd"%bH7b33iF*K)@g%I0aJ0%Gr'?k9#
t$bZ@/%Lp^jiCp=LU2'cZi]A_B+IsuQ'"I<i$@]AP1"m%1LRkk)u0;((.t3O_<naP8-r>WMlU1
HN4ZM(4bqfI(U:b-$X&ATjoD*nL+5JRcZJgn:"@"i)i!,F0qOB)l,%Q`a:oa[qeb/a3ZE7(Z
c8b9o3uEMo,99\Hh\d18O$R)EHfoCMTaUF3h-@"#1I4;XjsI^.dl1D4n3Hn3W=2,*`ipt>4G
aDPBkh/@fLJ.d^s*BBDAGr9Qg2?%3<\#@j9*7Nr,MU_&C`V<#qi^9X(&q[/%hOP>ilup6hh;
dU]Ak;2\XR_+QO.M93)k#W1r#:D?M[/jUGBOl6=mdpe50P"lNi$F+SV./URa5Bgdf_\.D;[1I
&ctk0\"m02=Vs+l'GE%IiU]A^FQg-_^um&9-\4gSgl*<tItMT3d4KH;@u`SKeTKMA8Nag[jFp
u<mg[juW_C6-38j'&H&lPn$V%RTe2Q<]A;AZ$T,-@"9.]AX06DCf5q+AaFWHE#OHi4+2Etb2Z`
Ycp)H><,F2KXBC8W&[.JL@modB=;"UJ&T^)-tpEaQBPFPM2pt/CO+OOY'UVlVi,rn.+.\.ni
>]AlQj$u%cM/d7f!3B9,]A%0lr5"YLbslsg'?$/eaA:aNsW4EW`p^lK.dPfaA`OY)_@lil*aMr
RFRn[k-C)YS2@A]A90FkJ#gUYk.5Tc5[gMPd`9$H5$>^r:AIOH2#H%P4j!!$NjF4@edSB7+TD
kX[Z.=P>/K37nkI8FHc=SH*\m>fhri$R%>W$[b"e')C"&l<s75HfZm5>$-^<o)9X)J"GPJlQ
qA'!3<JD1I_%q^$5Y6`E`lS.3=/hO\0geUnZ@R$<3(r5#s4o*-s'q]A[q?%)W2E,"AasArg8>
UMIsiI?*4[t3C"pI$-Pf4A12rhk[GpGrFb!h6KZ/\ZS3o+t]AP%hc)7rqK4CYL`fbpTr-1t`"
Dj4',0\Ca<%TnkT<M@)uTMi[3Cb+sO@>qP5aY"J4!<j!hK3h!>HT^)(b=D`j)URuJNIm4.7Z
U@t*of/E,m,%Jk%+<.]AoVMhf:$[4,e\9E>@(t_S--J!8.Z&['`!1lD_@!5c<LGAhS)?9Y;r<
MW#Xhjk0/CacQnT]A#?Wi+I=`LHXB7]Ac:0BTCB/WB95i.-+i8G'^g`Ad<mDupGh=Qp-@bQ!.9
!i3kM2A4SRV\&<g>!GW1a%"j$[;0i"ol_<8s^Tb9$#Bum_pc4pDm)%C7UV>mFh^fq0fU^f^X
qU+;n/Fc_pW&-N#o8e[fC91PM<tiV/Z2nmH]A0+b)6uM<VB0B'#_[BYrT-RftCU3+u:t2(#R(
<7TK\:1ih@j-"6PD/JaX>)SB^$#M%ul-V4!'?<3)=n6NdFGRdcHOi(*5*q2[;pgGHEskVc@n
#^I4$eOr`F$X'r5#HU9*:.RhJLfI/HDi-7!_e$/,="n(?&#^1$QZ!a>]A.m>`)`DOVlF%Q9=1
"coq]A6.'C7FINdO>:S6i"O`j2YO$'+:Vlkdl%EC4pGm2q.`>4*D&-,`?Z[Y3l<9pk[UV(A8i
(o"#4@i+T'AUs,LV3sN4KcPgMj=3FeW0ggS9N6'[K1e`&_3e,/PPh?WTj`IPWSh;iG2J,gY!
'QOF5.ILH<*/.=eg%R#dj$>/W6Or#-*gSI_@W@B[mhXe,'4Smk+gWU;td0;7mm3mBhIX"]Ak#
')k!OCtY5j(G9ts0/"tI9oEL710W-c6e$I%_(?Q1Re_`:K7GL2s4%]A$1ttI`/r:G>RAIT5Nd
-%PGu(^MlP"iE>Hp"2qU8icbR@AFG(LbS$\/mUcI$`+oJT%lTt:#lloEsuA_=mt%8'rd+<NW
RZ!:(09FbCK<3;(GkdLa_>AaBZ_"@8Gn8.>FG85Vn]AUmQ>Kn]At1_iN9:;Qqat-\c\[3CHNa4
cF=@f;!m#]A-q':FQ%]A!G"6inV-OlhSA&9[Q(PZp4QrY;O_:ZU4UnsSC_QRmC49j-6iY)[s*E
a/pB+Iel:B2;XUpUh%Ib\&B"<_oL\orc?H5'`Zu-S%C]A2UiHZfVTdc)u;M&mVY:M^tP:/0-]A
o8-0F69Q=E#=)-UbUEt\4mX^%YoL\n3BJWp_dbX(*NRD$Z#C^AMoWVWh=R#odfbZI[[Y!Mb3
Tt\i)@#SC&*2=9oI[HQjaen2f:U75LWbn:VI<3#s>)`qEUsW'7k_:+`lHJ<ZD'kp7L\1j)tY
s\uCnELERiC`92koS0bK)?cB@=>9:r;+5KVK*RlFmmJ<dV$MaS)[T\]A"@&/"J+!T!.#2lnN=
FkC.TkN6=KPS?;NH=PhL=1(N^;Z,2)lc&M\Li^RRi!]Ah*^B[=h^*+h2M,/>[113\;a^]A(AZ<
m.%og>;p`]AI^P1_q+&s[!4mN*/G\iKnkqfl3oiKkoM+-"Ed#l1<OaZa&WrBiB5A[^5C!X)ba
]AtY6-6ARUN"F4StlY<Mq:b`B4/q.BPi(i*_Z=fePh&Moo*5TDuBXI';O8NI"".![rdgH.FN7
_!Y.1?Hb%NpO0\"RGP!H&Adc9\%bRPit3+Zm`l!kCV"%[Dp?4-QXeN2.h)E!JrhIoe8X!5l%
io4BLQHRQoHB/&I?ofnFW^%e.I/CS&._L6Z]A"@"!3,j))n!-u,L&8F:!Fl_E]APSI4\=mU*M2
86Na%L(nal.]A$9dLU9QNF:P5P.u:DFOR/f:`0J4V6lC%JL?US6_+d80Gk=fOu^)=An!I''FP
$*nq0.7AAq4)6.F'C$mcWlY&>EGd7*(eo%=qY'\tJ`]AG9W9=m9%u\teQN;Qm"-,GBkA^_8u%
[iN80%)uh##_)In5T`sdfeLJj:LGl-h+Cb"_HRX[3]AC;G)7f"6,7i+WO/`n&0G>0nUr4u]ApS
GAlfNe5^@<Kge1#pnV*!aP>U]AUgRi@.f.D>fG<U##Y"EH]Ap,W<[s8&%tq7`F]AVJf]A<1X!L@t
8.>N3m^T!Z(Tig`m-,94I;Rdu!+/RXO\oQn!<6"J?eCE+<m:Y^:K8VoshTbnE@pnBcp>8Zkn
Km`6YT!8mbUnAd9n0@6r\PUG;(p^/Oq>sHW?g,-a:=PH0GZI%[c@#_+X&J28sF@ACmJDs';:
$C=YU':]AlHmZe#KdO%i[NWB<-E,Y@XP;\or/JaOA\)jO=-0\ll+e2JPN?0LI#K(k*u:F/@?C
(/s%9iJIbUDW`+Ba,oKu*l=PkV)STVo(VR&K>:S;GZ9XKM`?i:0#(pJ;E/mq^t9bRG)8Y0YY
.Or#^lu^TTk>SB)I4'BC;W/Ks]ABRVDDH-]AUp9's+knH[/a5\^"k6<VN`-g^nP+?'.Qk%K6n)
t.OmAgDt>EUqO$Q7+8gZR5:R&Dnbah8aU4Y7?&H,fZ8?NRhdb)61c_8::PrfU3&g/qlfP,,f
+UriZ>6:hkAVA1FHh=COdE3J!rAYY)]A'0+iK^R7!J$=%mpE$m"*ET_^?^FEd'U?q(_"/D!>m
PhfgOi8%FY0C?"YMa\A6H!e;Q2SJ"mj0XG_s!=0P862,aZ48r!8F<uk`V'2sA&CX]Ac1IR2%9
<8CXo@X0Y#m.!rno9jV2OSlM9*Z$I>Q#kLAY]AaAB1Gp8@VNW0Mgd3T1M(LpV\o7uek1p\Xe3
&?RAj!TO^`&$":Nhfubg.!18]AL&\q'e1pHTRqrd(Y:"C74NQ\Q2+o:`5k/Cf!Fq*.f-Z8XeZ
nA6uptSaGSGU2@aq7]A9p2N1OQf8Q`CGV%(s;Isui$bpW\VWT;&WTk:ct>/+5J0WQjEaZhVSN
h$Uo$4FKqo^@`elVhS1@`E^U,"`1rj)K*_P:L)1(ThpE%<D09.B23/4^U7W'W5Y@Z>T4.U8X
p-/#:--"9L5lY0>?Ff\%?]AI8e#N;SW@R<=8ZFa"g_P=?Ns@dtM1V,hNsA3jJI"O_%a,\s!Fu
:X-?W]A?aG>%mS.s?(blkUC#q<9Br"OaLO9Jd'H#h+Fi";%Uj$B8:YLt]A0ctK8I(WNNcjE9m9
foC\XdtY!>hMC$l0+XeBui"0Yat?MT`IIaC-Mr2OZ:5d#_;\,>q#G!`Q#05$qUL@rB)@(VNZ
&!t\#Eh\.A7bq6G;k"FC`dD6gYr"<)eT@IsdHuM:sUcE!59)u_S9R"BS9q10Wm9u^>cGQqVj
u>B%4:#c.00n]A`m(rms5-c5ZY!pFU%5!?kn&#*%cpoEE.-4Dl#GX5U/XY9I,4mn:bn=O?YJ9
'Qf<O-+eW^=N>ek)DSuF@Ls"qIph+3[cS;);HT2D'[:g'F;4e0]A(ZRaLq52.'JG8,mP(m"qu
n6m_4R>shDX3tZ(6W=Vk'[`@=2P3H$F4S32BEh[1Q7\(#$.+c1UefDtZ1Id=MY4L,4\A<`BS
UdO,gm;JTb70jDa1kP;V.5i.\ODmbtd;3eB?+3Fql8\&ebI.%9;h7DCi]AagmTL@DV"(&gh2\
/F+^nM3i^mS,;G*2<hB)R]A"u&n":C.WcG?)fS-u/.kd`F7?[S3WYdX)4i%B;.%k5T'GE]AlI)
B1`Aqs9cG49Zb'jr^t%3]AYq*:T/i0o7WDnT<;5O\^,-kGsI2"aFOU9Q3\I9""GUs(nQgOh%6
Z2[j["*ff,iJ8YmTMQKB+5)A1MgE_fB+W+8O>_o\V"p9Y(a]AO)BTo+g6fe"rNOLQ9eKk<O.`
W.-?B1fImgSiri)N?3T74`Ahtq_4WGUW.a+1hPScfbD5sR/DJ,8sID-rSRF.Y'$W8\._PjK/
W"#^Ti/:id#4EVd]A.DO,:`USo[_YkmUq/Z.qpD-N/7bf>b=cQf^TYR2J-Zb^Jh$jlH7lPd@b
e:oAD@>Hp$dJ#O0*T)o+E?*t[69(!qeUdWg2_Td^1FlnQAp6Ccb;qC0#_93.aM.B/kDY'XoD
*[7Kert<hL(Prk:+O4'0EpC[#!442(Ti42)#D<p!1HTM_P24Ki4go6a2p8]A<lR?&`n3)6U,J
c\KU9e&Zt?op'1f6tjWG3n?"0@\dsL7j]A6bD,dol8^EI>]A_cul51^1UrBHt!O6-2R?paln,M
Pc`.F",HqDL:btfcdhMcm`2f,3>?8YgdfXaPg=&@Tf=F5<9O4#6-VH5'bSD_,m?V;'Vj!]AhU
u@<;'st;\1]A[M*f/\pg6YW-akMtT8>OapN]A(s0"b[A.Km$3SO:G#6d)5>p/(Dl:N+N2o/?sp
@%%Fnjk25dH_:KWGk9p*b0Pi)dneth.C=rN5gFBNk1pM"1'D$cCH&NtK5^8pqrJ[k!3F*Y;:
oC@(O%_DA`3l/U,AbSAbHHs5>J?;rPs(p$BB5obPrJED^NGGfUU[OFFOV3I4:kLD5.-(2V8_
,Q@J9m)WhHAXZQX3\K6o(P(BSX6p?;Y%bWu1#g/9:&c`h>/k8\V3bdR%AIbKlHqZYr8:+^$n
==?RYgRK@^\#q6NOo!q*2cgebf6G:;G$)52=B2EG=rO#fa,bKO-V1%R+lYf36TUP5g`KUn8S
p>$G-IraVk``Jb-"S*<,HhTa&'WT+T9S]A;1RtW3jRlLEo&'QL+h\b_+%j6-_%Zp(YiA'nR)+
3*[WFMpSl>N/Z`JEpa]A+W`2KS`Ae\_:<C)JE2N.:FL^,I=E^Qramgl9RokYfg'-**>k22Ucm
E(A$egLccqQ[m*`nGCs=gARufeon0VHI(A=,^>#D:UtL7K"$icWC'Z`Ji[gs'F?WWYu)5npS
c]AjCPDqDefY&bGYaNUg?>m8"92\?a`Ys`9D\#MiBmZ)p<^l8"]A*m550<[=)1?>B\[kud3T?]A
NZu3n-u%j\P4Q*,p.%:-ad6:s4udA%l<XkKlQKh5e[h,uP^:l*ei5Cd5eF+P6VeC1qW""d;B
Aj3.cKtk68B^%*be:m:1#t(=aJ".jMi3B#Qft@\9Y%o!.iOo\8O=f'1h+*Bof/?Kl>Xb**I!
)*fs?XP,..A^Z:+2k%fM%ZG>DI_8?k-(JcT):?1)>a9WWR7k551A1X0f+KidQf=#g'GZ(hr;
LoK]A_JXEYV^IDTTiN5jBa9Hi;*=UX_m;h1&Xe[19.a1V@_^;`>f'<XqBaYi_=2(,`E3\SO*m
]AVg,#)XSUR83Sc+@Go8&1>,U0s^M]AVHoija'Y?q<XRVrIDMT9\PZCga?X#)T_]Ajp*u",/@@)
Eh$G`W9l(]A!5U6LRR\-r[Mjd?NMrqh:$R;,9gr&sMAe\JBjpe-!c2Z:9Q]AM2`;7F#Ob#qe_n
%+*K7nt#ksXr2]AJhU02<5u[[]A3-JK2k*Q@^,Vdobj!RpKGuTouaC!RB6VJ^/2]ANo;j?GFI8F
A4:m<9-B,X^PM_QE-h$s+(%OoP'N]ArO_XYm3)Om6%fDW5j)ZSEbpl>Oc82Vs2<ZgV/Hk`N,X
Z4#`<P%jiXJ[:JI`j3=Htqc$b?AiGMXWp&*7X>tB7pG,B&5l)U[mk=Vrsol1Zr6j.585d_X1
1%)pSmoPCL"pE:&Wtr?>o*_Wkt_W"H[61kh1g4"^*934"LZPI1PX/0jTl_PaM_%*MiP$m9Nh
OOUQB!PG#T,9e6mF:e9d9CZGPjZ?*u;5+aqF*5s[p`t/*L(-gTauN"J7DCas;WQI46kE`C6&
VO)a.WkTV!#aP89l'<Lnmt#,!I*ad#g5.))`e>G;MsY;lS2o*EDo)=[AWA/S4ko'.<-b0DR%
Bfru5U6W+..[D*D%oQ1E811mAY%5?3n+I5UlUgL0is,m48_Bhb_mFF&9[7coqih&<!=[79_:
S#U%R&YSV/+;pBTu_%RSr`05KZPAOU-9ILCNCmc!\45i@t&6-c[&Nu`N9aCAh.XB0(sZCD&g
$V1otfCki'tdA&Ut;N2=+JF]A*mW`D0rkBsE0@[E:unQq!H>a3GNPW2CqBD5G'pRHR!.lo@8e
%7H;;B92*&h]A-KKq>>c1*mO4-OL!Vb\^<FF5^FLNSh]A3?nTqJaHtJ+tOI@4G'QG5/,q%GHB.
"8X_s?A[`^gnK)m"-Fk>!-V%5c5#6Fn9DA2!$l0s:W:mA;l>Y$uY\Yg]A98a(\;Ic"JI=gVP'
Af'FRA9kXYd9#1mb03Q+`l-Qg,]A9W#hD@G-<aka68=YMR6djs`Efg<[.c*f\AWG/J'[.Xs=-
Gm3hiG^mZs+4Kf0P3@4aW^QYjBoVZB8>q#\/Se'[&uVPDi*l;6m*b&gPnp8Af.@XO?kgMKHS
r36u\FhK;Mo:L4R`m1+Z,jY)4IJ$(5j$nHf$g(#o/QNk5IF[543q*L&H*M=je>d-.(SSnG@V
Rq4(EfnGWD+)#a3R&]A%b"mPCU4W0Is"s`&MiD/d6KE0E'G6P6X(%U+[d`$Ys+RrY59YE]A;X,
Xc;[S&K7l!om_>^,@3cK]A><VV`$r:%W\U,1b;@[houD!_-<#)!,F''nt*Z=<_a!"_@fM^u=3
i?7%a'g+m"\:s8R%%cccs/-e1]A27`o`,9P@%DS[)9V&\/.EHZ/3_6eif-Qh9Mq2G8oRf'DH*
"k`,&)dOeWj+s-VfkASf,o?n0M3t-haD)\Q2(d]An\3IAo<dBF:&3OUs)Wu&i7q:fc,pEChj^
H&i3?JZT0`D>0.64arUr<!YEop>_e2k1#BbNg5:M&Xkr5]Al>f[l96Q@?i[o^;l^2ROrnKNM(
fW>eTathZInqmcsJB`q^Btl]A$3/uW,NCH,-m2%:'a!CuOKdZSo?`No"="E?K[VeN!^/@*b7K
2g5.mO$iG6LL_2G=&E4dStEGU#/!N`a]Ap^G6Y&1CMmE9;h\f#uapV)IZ(NBiP<r\nU$$7ECa
5"UFn!>0>AL1D'MlegO]Ad3Wlp511B\tL"6++C":8#$i*2jn*4Pd)VOqi=6_KDQ?`CR.H^j#L
(&#mFc8YFQ4rQUhkVc`&fOCQ!K+4#UU1!`iT3:Oo9Pr[^.GZmXkS5]A7fIZ.Rg#pLAZjZ9m8E
jR=<[r*ECU#bXt[pZ$)SFA\[(L<OO>-Gs3K9d`YJobcS)a+?KN,q1.n+<,&/<K[FV^g'is<!
$#:'X:tV\6_&nR?U+4(E!d*t=2.WGor)GBNqWJ.+iU@7$`<Xs*p'R/N&Lj^RO3nI(/Z]A`aV%
JW5<khf6b$)Wg6e*j\pDf2hIYWh4^9?Ta$BATn)#X)oBgh@'^u?*qq=VFehRUN(<_m)LZLsh
"3oN]A:!kdj(68,@^.THLSFoT1`eGY,q^WSjiN]Aj);[0J#!R+&9N^qnMrhM".E!;]Ar-Qk*J+;
hsi225#/aphhg'Z?0^)>"ul-:MfJ7L7`r#L7I.:@??SF0]AtLrhVUK_XKb'T`1Nnha(g))"pl
mGBq*<1?>H!MkJ:H`2=:/ZT^`Ks;)Z)_9C\Ic4.c#deX3$=6pAuWQB-P=Cr7\`XseY_<>q/&
Ia*U)*W9:8rN@Hu8?")]A#9(9<%"Ga"_:gmtC<3m3O-GaiO"U!N-4`[R^U>(_CSUV8ScU'Or>
M+aCMqL`C1l]AOp0dQ7p`7'**<I?.gE`*c93K$,V3F&WM)l_=%rP^kg4:g\j*I--C\pI'WH@8
YAQ\rXg<7,#GBCSc]ADhL<Uisok=8=NF[$Db'X9[B^1=bK`i\D,TrkHL\<B(Ns9p5JR[!=r`b
WCcZ_UcJ4b>Afu8Wg7U3CoM2mPLBhYCfqd]ArYDd7X!N@:4D:(o=JM0]Al)uihJ'!7c$)(uN+T
h@Dk\[X\j+mhG:Tb<s#2X`W3>ki0o,dG./EfS(+nXD4DEGtL"Jm"BQi1,2>XVq!h2h`H.-2`
S\OW#'"\&niRH9p3r+7aU(?r8p^ur[.L/G>W8i_V:*u@EQ\#n`B6BFB;RZ[o2V"Y_i7`F=gO
m'O#rPs$er1'*,+W4eN0b(+YSD[TO#RoNr0u7?.o$#h1(7_i>jXkmjo%b?o'A-BF0C/<)GE5
BPnD/grp0-IT'n='?aTB`J/!aIDf')/V`<s;*$I%56X>D.25Yg$aM)OOT9]AmF2ajepA%@1.)
GsZs!%PXIf`JYdT<7tL*D6]Am^0J/:f_]A[14,k=!jUsgJf:3(:fOsi:Elu$GejPn7L:BI9]ADP
/mmC2,O<fNi=?i&5>QXLE8]A(2F?-o%GuVc?'MIiS7Ys&X5df$p?M@r@VZU-]AKTVp(G@1'kZ2
,Xs63b]AOQqa7"gNmmq4hV\6=Ds.t`JI0V$.a\+u,a*44L3*>[XKgBn1g/2bKM(anR&`'IobV
p0ESq7,e1qn)a4omoR_BgKbr_M_(n$9hqT>[iuM`5/%s4(Z:fQK8`Q-95TJn^s)_H;4t85SB
RKBJ<FTn\iKB2oFj!DrDMl"mTnYjQ>a!Y((fAM&O-"*@d'ZRCc]A-Tjh5?Q%8G6s9OS`79>rS
"#Mi`n6Q1I.=\*LBW@75C'bQ^$^^bRJgg$(ai3qpNOfLm@\auqt!V3.\(fXVL#EW-_ptZ\%i
IW-DXP?T9?/]AkEfQS?0l[K+@jrYl>Pj?cX/n9luW_PGi\NbH,IMa#0<i7>3L)^?U"Z3G*N9X
^2@K)q#7Bo$se"9CS8rWjKhe%FkSL_qA7@[Eb'RhHgBNQ7L]A)2<#E@Dc0'!rl1ZMs/)&33./
7Z0iJ/-$F\,ocdHKA9s2M(.g7Br*:0/"On"UCZ$b:8h_,=.c2_FY`VJf\c,!cme!A?XC$%(u
-0[@OYI7`UqLAC!mDg!aVapEj3BW'T?p8rY\ZaF,IaO<VIMQ^)Q'j0<`asH41e[MR)A>HR6V
X"W?Z[&Sa*K1HU`tUH)T?t66EW+b6j=JgX5#-2U5]AlaEK?3GbC2kuCnMWCEIaMK%F8W5hHrm
<!e[Off'H/IMi*L6Yc!0MQ^G1lK:R>$)I`lF:WpT3=??>0mW-&"e;TqA8W`NG6rpQ:bPemTL
7n:b@>&.hm38p4;#3eRW7WogmIbh51)iaOII>-m_i$]AqUjm[63QGFLSe\kQA'X-'C:=21@r?
G.R.8o3_><?+6Ie_LIPbe:CMIuI/"!]AQinuN&SS45Gaol#&)hItTs[@KAC#?>",giWDjs4.>
)_@d)P!ur^7/scZqYDiqK@7U1K@;C+qP13O7&MP=5GcGgjZ?+gh\#YquW;=K]AEgT-BZ/ET*?
*-&NaD(WC'+HBq9:^H;B8E!I&X*oj:H71u,rp..55A63.C3SFY@T87Q/7cooQudt/&Y231kZ
YRbP]AU)dWd_*@gl=_hs0;6s+.[Hr8fTZ]A-<F9d1)0rHdpoP3sOKg^*_&_R!ulG@q-lf^Bs5l
?)85Lii[@Xhq(ae>e87pOF-9[$6qS>72ldagl6dfci.li!-[?0o4:L/]Ap(/(&5J6UY%8kus.
tbUO6TorQ@A;rE(_?5*'_k]A7F>MUJqH1/C:pZB<urR0dl<3b&;(>cbqZXZCSDL"2WA)Oi8W!
p$KMdK(Cq+W.EH*F2?)1,TIamuA"a1^[h@Nu\L<."Q"OmO?bdd"kZI!%6`j!"EO9-%&mb)+h
rA*b[d`<CKCh6@/VtU@CVt$@K,Jaf!?Fd5nX%F$d3r$'<f'1!CV!4Km+/CuhhSODfV\]AiJ#m
2HZM4OY5j7=EI8qhC&,>>O@E5S?J+_(\rso~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="116" width="450" height="352"/>
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
<WidgetID widgetID="935c7a8e-101e-4bcf-96b6-ebb2a3eca8f9"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="2" color="-855310" borderRadius="10" type="0" borderStyle="0"/>
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
<WidgetID widgetID="935c7a8e-101e-4bcf-96b6-ebb2a3eca8f9"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="2" color="-855310" borderRadius="10" type="0" borderStyle="0"/>
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
<BoundsAttr x="0" y="0" width="450" height="469"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report4"/>
<Widget widgetName="dept"/>
<Widget widgetName="部门筛选"/>
<Widget widgetName="开始时间"/>
<Widget widgetName="start_month"/>
<Widget widgetName="结束时间"/>
<Widget widgetName="end_month"/>
<Widget widgetName="report3"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="329" width="375" height="391"/>
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
<![CDATA[723900,288000,720000,720000,720000,720000,720000,720000,432000,720000,720000,720000,720000,720000,720000,288000,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[432000,1152000,2743200,864000,2880000,2880000,864000,2160000,2160000,1152000,432000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="9" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="统计截至："+DATEDELTA(TODAY(),-1)]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="1">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="2" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="2" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="2" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="2" rs="2" s="2">
<O>
<![CDATA[环比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="2" rs="2" s="3">
<O t="DSColumn">
<Attributes dsName="当月航班量汇总" columnName="环比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="2" s="1">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="10" r="2" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="3" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="3" rs="4" s="5">
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
<C c="3" r="3" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="3" cs="2" rs="3" s="6">
<O t="DSColumn">
<Attributes dsName="当月航班量汇总" columnName="月度汇总"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="3" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="3" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="3" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="4" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="4" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="4" rs="2" s="2">
<O>
<![CDATA[同比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="4" rs="2" s="3">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="-"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="4" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="4" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="5" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="6" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="6" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="6" cs="2" s="7">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=format(当月航班量汇总.select(月份), "#,##0") + "月执行航班量汇总"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="6" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="6" rs="2" s="2">
<O>
<![CDATA[昨日]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="6" rs="2" s="3">
<O t="DSColumn">
<Attributes dsName="简报航班量昨日" columnName="总执行航班量"/>
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
<C c="9" r="6" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="6" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="7" s="1">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="false" bottomLeft="true" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="7" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="7" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="7" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="7" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="7" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="7" s="1">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="10" r="7" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="8" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="8" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="8" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="9" s="1">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="9" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="9" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="9" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="9" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="9" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="9" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="9" s="3">
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="9" s="1">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="10" r="9" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="10" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="10" rs="4" s="5">
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
<C c="3" r="10" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="10" cs="2" rs="3" s="6">
<O t="DSColumn">
<Attributes dsName="当月在职人数" columnName="在职人数"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="10" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="10" rs="2" s="2">
<O>
<![CDATA[环比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="10" rs="2" s="3">
<O t="DSColumn">
<Attributes dsName="当月在职人数" columnName="环比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="10" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="10" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="11" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="11" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="11" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="11" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="11" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="12" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="12" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="12" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="12" rs="2" s="2">
<O>
<![CDATA[同比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="12" rs="2" s="3">
<O t="DSColumn">
<Attributes dsName="当月在职人数" columnName="同比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="12" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="12" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="13" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="13" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="13" cs="2" s="7">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=format(当月在职人数.select(月份), "#,##0") + "月全司在职人数"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="13" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="13" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="13" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="14" s="1">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="false" bottomLeft="true" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="14" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="14" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="14" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="14" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="14" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="14" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="14" s="3">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="0" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<Expand dir="0"/>
</C>
<C c="9" r="14" s="1">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="10" r="14" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="15" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="15" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="15" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="15" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="15" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="15" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="15" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="15" s="4">
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
<![CDATA[jLbdUPjSK8?;CtbQ;gPtOuA"2A4m4$Zr#Imf`p.(/;#[PgdUa$:U9G+atAX$\.c0.a>t/2$o
,ac(s@F$I$WskI%*=GpRM9ZS_lHBF67Sc\Zb>1hs9V,^0^8RI-p2&Y2+]AAGO3tuFm7nr)`r5
I6?__J"^u'A]A-GkT3+g3kV@/a9C#8DTS??ttkl4PKRm\:^9DSG0Wlh5\EsDs=,7`R;%cAO@n
&:P5cp_'ZC#<FrN?^4H$D4u34:C&O?*\u3KEs%C`;Sh]AI+l1ilt0+>baLi&s&-Jc%3<LUfD(
kp^]AUrpm,<+X;L='`J/^L]Ai!j77,YUZt5Dl=OCdq9ZG3k#%==1=jalpKQT5%U$pis]AQR$^ee
PE.#*^GE`iH>)$t/"_SL!2<`N;h+UOFC@Ip5-hS.YuP+P#khI;4/D"`&3(P(]A:?g2[YDbi,p
*>R"[@<rnH4S8d\"2OJ+\pSP=Tmi?dY^K%<N;)(/:Nm>P%(TR.Q,2G33Ej`%;#88Yb&g?s\L
)KC8T>S7Q9si@n1LN;i,#_aV%BZu3]A@b0j\`fNR0FWF]A(eMP<U0mm\17c:.^54CQqgpt(GVr
[mR8f/=\/*,!ZTDQA$T@&SNA8a2&^X>QrS?C52ujh3<<P_?;$rnsh:Q"h'[HA*95M*cEbh[8
M"QIUoK6l;%^5M-3hF$GC_V>^+%&D1T,K.6)-[G.?h9r&Za,Tis^;-_Xr&XqarY+un_c1R*r
euUdHkVolVcu-*'&'U+U?f1U[lnqhuYbue=P[4gdK.Ir=G`2@Lp#^ebq;6!F&Npi]A068/Q8A
s-0bc/u[TRN4NS>6c#0"8t.HTE7'h5V+7556TN:.f=k$mo!;]AoTGl0N\o+/!=Je77i7h[LcY
ck5b0-5>'LqX.eeEND,15L.Nu`37Y;bIQ(LnJDG?BZ[`\7fHNC)ii()>[l%_IpSaq63`Jjd)
GU]A.:/E;TcfEBM-ji?;QX94;J*LeGrkVD:1(P-'#-duXEd5AtNj<>GJ!5-6!@+_WD&LL%>+"
i?<(=MQ#*B!2$:3SgG&8>NFpn.A$OY;TN`slO[2<kE-=hH-rT`1U(LbZ%hK?c'\$2Ncmu')/
MWS2__hN3UO_f0#@rKR\lIidAV(pitbK!%$5rXHm?jS=fRpLht>F@<6^oSRa6A'4BUS.lE`<
Da0qaa,LkE54knj</[&[=IV<EV&A#/25-@O9K]A3=J?7PoSu'Y!;]A-o]ASJuJ>uEUb$[B)D?O&
RE\Ic@'n&9R122_uh4?cj:eo0Pohi$'bRVL_A0E-YA,upRHue?9n9K1.4!\VZ'MGu;A\pF0O
k/?$$q\[9,``e"XlRf+p!hUX2oD7Cb\JJWC+(UpGA6U^bR;\#k0IUh\L..>54"cIHecL!RSh
)I4&9:eh2m0kp6.#=:V`Wo^Cq$&WFkj.[a/$?$8SR]A*TWgG.SRlDIVo7QZr':fU7q1L!kM/i
:Ir.,^9S'YIr2mdje]AY=1^V/6d`V+u(<r39P*b^:%?B/3p/nH-B8i2?`.ijUa%e'P[taC+bT
d60Z.A@X2]A.8hCbE^7aPJ+=E)T`*/CNgkN7P+$nRG\gZ@%Zqlh7Y<_$GidI,"LMATs:3PdY>
HDh?aD/I$hg=68lQOg+;+lG;p(]A1!q)2DKmRbl?#P"TS&1s-Z@q\0/_k_"CRPIHRg&4+HA'&
,pE@`;LLm6ao9u2nNaO1W#HV)po9tef?gn4isWHCW0X[5?Hjqp>]A8XNF:YK"*'\KP44PCq*C
+[Smh^;GtV6Id3I2FoYVom]AgTGEW[p;2D<^8D;=D9+l."D::b74Spem-EFWHt$QY_*uo9D?@
PY6q_=,3^iYmKAhrV_Y?[T+-L&6j3)l24h<@mXunFtE%g!c<_YoR7W=GlUS6LMTBT?r=gfpK
U$@>?Ge#4]Af0Un;;)ar#"b5c#/jSjTCFSPjfeIHEs^EKX9iORFFX@.c>_I;fW>>P-4Q;PXr'
JJ46l'Db;*0%O2NE=K/gm]A3+p0a2pNl^sV6.7/<C9Gbre/bXn(,djro5cfg^sIn4=q\%u=O4
LsK$03"'4#qPcqbrE!0b<(bs+l-]A[i1.2qQ)k&!,"=uu6Sq7m3o<WQ^*RL_cO6`4O*uhp`+C
h&^a]A*9E=d`'[rC/f<;JAbf[e84D5<JYO?"Q65F)LIGfCM0f@6kh@?H:,S/9=-I2*PW&@(tO
KQ'548^Z!j`;GKB:N9dO?)PlkZNmq(#M8aEnqr#Ul0`r-#iF(YabSK5je1[IB5M2J1i/mm]A>
RO@%).s!jg%<VTr^=GKi!SE0&HYLo%k?Ne(=8tU<aR"Ti\/8PE=CZFKdmZ;'phhbJ=YXqj*n
tXh3&??:@86.JY]AXQsr&HHb="N9c)(qqcJB7%o6+&dmCc1fn;Ss0CMo5Bu"CV5fc\n77>"GV
1NV.+)]As[_K9>aZIc8?7$2hFjQf!3d(^no&d%FE[IXo18c/',3!dasAjiTCd]AZ;>(Rue`[F[
=M<4PsrnAj$g7OUo!&(hJWDN*uUh/8M=IqFjk]Atg>Yhu&72ah&<mpD[9Wc^1'H$'#qr[^3rQ
a[/'Mp.A(4`@Ph3"i1%8$+H=`lc:u!70(2\ZLH*t[.UAVDO)D%RR8OqFDJ_s\QgHHcG=nCHB
f9$NjF[t-M:lQ,VKM%\ugq:(0tjB<I@Vj)54-V+`VGRCIqA(/hjPr[j?#Jiaq[jM*aMZRkq_
N>>HW,Tc*Y3-b3hO34CP<a-Bif&-U.T5pT5Z[p5=tZgD#eG\DEaon;n]A<-<r"K1(3fp<Tg*B
*_iI@Abm1/Qb*Me,QL54!_f#42&"PB\hg.il.6T&u+Dq&:m8uA[eOJPs;$Lk'P#kMUIUScD2
t,^j5L1[!Le`$3]Adr)khP\k9/6(oN3#tFl%;Jl?[R]Aa6E:`b[_h,fcA?fk'5\!2$1.,PM3TQ
c`nQ$D08%6?f!tVoI4O.ZSpZ"b-s^mU]As3sQejcBXKpp)iq#i--$#&Zo?EJQ2mL-dg[UR]A/E
.@"D\Fsf.WJEg?=:9IU@C&"f=q,;Cd(6I.i5B/5eXRb;M!>Y+"3qo66`4LZ3$N'qMSHq$Q56
+e:Q^(IAfbiSqp^CkD:[F\O1@#07tWkj:\9fa9SNqr(7uY=4UqrS+9AA\5*QsriR%=oZl=Po
e39N0<"COqrR'u#_6d4o['0Ks/rFH"N9hi8lY0%FB5O!j2B[(/Ap=f$@:3eM$W,A,]AB^(W1*
/<5rDlrk@ZGkQjd3SJaE0/`RM')L[?uSjqdITW6K,Z=:`tDm>=Ai$r9WQApI904sf<(1eC82
rC'rsmP`g\N`lGn[@3@f8[(KdAgF#7\!Gm'aR8o2f>$LClaHr56ic0`-2tVIJ3H2^+]Aq:*S>
<>,>HMAA,;`WM'R$'[Q@jL<Z.A[<*JM)jF7iBG(H9pAo%3C?9[p.\P.g2%YBQV5`6W>n@>A9
(lG-C_&qRjM7"kk#hr]At9rkEB86)=C$H.MOmp%9Cur#[#;XPGo06RWR:C#POk<W9*'XLgp0P
aSJYeG8ZO6O+9g,"I'%I=&Phd2:#@E9f<aLKV0r/`'c6;Wk+VXr<Y+#9/BnR,k^9IRWn1A#D
4TK(grXOT4k#fsZkARIc4USfa@T(_M]ApjKX+i$GCX?n\#_CR_Oo81H0K3`CB`'djPg5Y8QS2
-eue>b?<lK>/"r_@I&5f@'X:L'`+T2g8R86RW`sL]AT)!YP`qnE&Vm-D:MVVRl<eO=Jt/]A^b!
mI>Ehr_.-IEQ!pSkl%gW@0\ROU'CY`-ug=4D:lj]AZPL0&p2-/CJ2E!Qli]A04`2BH,`/N(1?/
DPI/HY]A\:35)_=n)cX0IN5C.0R]AHlIqKYQXZlT;Z4ZbQp`"Uoi!,X29F5,aVYH%c'bUIFdV%
\5=+>M_`<lFi,<XlG&j[Jlk]A(a7ruQqAfRaq"scm,+e;CbrU+ZT?Ls;L-1A,]AQe<K3"mM0fS
FPB9&+)#sk/:&a(Qt^GoM0Sn#DF'>aG95A17P.q*oCrViOc,:-'JZHDO?o45B&MgFI^g?g$0
O%nZT5o"iO(SP[8(QE&A(1i.fkc32YEV2\Abti38co:V'Q0',b5sFN'Xrk]AjGJ[1ekJ$523Q
l0pm6RG]ALVq6qrpH<1O$fi]AlZ'C4?Ssil)EH"me-c%>6eR?;6pG?Xrt=_UfY/X.nO=\L^[mt
P:/0uB+E0C*Qtu-C+E6uS;`0SKAl"-)55j)1^76W1JZ&>NCa^)4Z]A&m)<Y*G,'L$`[F$h9cf
qk)RS)rFs\^[cc7SVj^D58JWdp:;#;qpJ=CcgJ\2d%_%R]A@7ZR6__S_@p*r[4V`4fO@Q>#+J
Y&ZJ<&eCIF?);\]AQuf8@abbpYV#67b1)EhI?ZRHmMML'dM$r%E:`5h!U+fK1(SW-4dk_Pfae
.Y$]AC)d>MD0*`]Au3'ZkcXp+;M1uProl:4lp9(@0XdN(!GI.+K"GPc^<6d19O."mY;rX<aZBP
DAa_ZY<6^R`HpL.K,m5Cs%h&>E%WBbmQ#JOYl&)>.7QI:SqJqe5he*BgSQA3Eua0?`g=7&K6
3E7>C"5?D6iRd1Hf!"L=>_5k!i-%>(Bb$PK,O_)(]ArPsLHlNKPL`mBcd4r9UOHYpo_&b2`Bl
D4?Oo_`/B_mao$T?q14Ru70D#E`sH8B5P)5T<(7!T6d\0bRGg$.;3N<aS@]AW2Sc<b?SYH"`s
,J<rZ?ARa3=7Onbh04U"76fXn`S'LG>hS4ej"YX83ZiPaMf)`7MNHp,p@o:F6)fdT`,A\mus
2<Rr0_%@9*YE_7e8dOYLZ2\f'XFilQqMU/``]AiXGoSCW-m5e\g!J:89R4[r1'N5D-`sG,Y*1
5F*$Cn<i:"\9*U&?t!3]AU&:(@Bm-#[]AdU-&4^U^Qa5fmZEhroj\JokPRP#/c5>LO;f5>nV54
jK.FMh6U*"gZ83e5^YC-A+6fpZ0_Aed2Alt6[hSF?9$$(g]Ae3O0gn\d]AJF#MofXY!:f_"NR5
_ZnWb/1Id]Ai!Vii6\Q2>ZthH$S^%3)4ct,R72C8?f`<l;8^\dSD=[tNiL/n]A/45JTc#dJfHG
u3jMe"Xh-L(`W+7?eE^^g[qr,1_G;l73q0F2U,&cR?nBZ`+!P8pgKc"oqFd??;EC9!p#4jAN
=+pKV&[Btu>g&*#c"jpnQJI'ZE'Xk0o"?_^eh3]A[l.Nh%WW-O@(?!b^qje;'h*`+o4L/h^=.
c#q?>)P\aFHee:<LeT`e\luoA@WOqjW7h?N#ca;:ho,3ld7Q*uiKV1c15>GiW(cPc'b55o,9
(2g(K"Y7;St(ap9>>5Xr!4"_`D6PT5Z>7D\FkOn1T&I=EVJjbn;mqV59i<."NG=q5iDGN0mT
nSKC+)#e3SYO<!Y9u\f-I+DF.TQRg1TCA-'Z?^Vn]Aq+[R.C]AbW:1I*7h0Tfjab^%@Xf4N^2Q
GENaG1&#O]A?34VDQij5)$dVK/qR/fmeF6RZHBcWBO:#S%l!9gKu_WTW,8[4[!/\]A)J[Z$-AF
,-E[qa)^FN(fm"$[k:0:ln7j/VD-tg!?r9l_u_J,VQiZ`4O;L6#@19;fZ/t]AfET^T:[n,AZ)
rkGWta)rLSQ#Z5K!Md&)(282<aZRes>0@\FS5uV'e*eXp(iJg;-/a*c4F6qMOPSeQQa1$-[#
_(^P<[B<c#Bm*+);-]AiDN%M":R6(2]A3N=K6HVpO5[eg7bNrP>1+4)N1hiW]Af*NNQB>$=sErK
+aKEC62<WYcT\"^!PuCR7L6OSZ&eTjY+kCT!,NO/e.eO\aU(/SRLEPHFs$A!;AH'JA7E;r9,
]A+`tWMJ!\A%*WQH)\Ji0V"1EmU`1*-n4%7@^:,sL1lO[;T4aA1[<O.M?=6,Z[:$2e0:nu2oQ
&QKc`<^%fkO]A/!4?tYeJoLGoMGcfk/gD,-,fht[kYP.":*GLPE7<&aZ0bD,"=KSa#3q)S^(m
M27kHaW(GEFmPfqgNaLT?JN)[*0o0KJ&)<aZN*QlC>cH(mR@UGI@8jKJ_1<X?YX"Qi6EqnO5
3qmuqm]Aqm=9!R7a>K=L8$X6QOH/2"lmo`poGQoDc)o,RKiZ$&<q4src8s+W>9eWI9t_<K2J"
ME8?Kq?[(Z?^<cq1)7Gkt9jO6cBP2]AB)AZ^ai#^8XK@WZK?ZB8,YN-KV<0'?G=P2A`'CcrhN
M.OD8pe',nSAEJ;'7)->mqd4EJTau%;PfC:tt<mpCT)jPddnn^3*VirrBZEBdjeFFknoO<$L
EVnO.'jGtXT&Rckl"E.FH.[BM@<=!"48>$R3s8ZrqVVQB(%n!b2dC%s`HS8m/*!B,r)N\]AUQ
W0J+%I%,)Rb^\+efJK=.=:u1l"8%8?ogR`WHn^>[JNOFBD<QO2!d-BhOqP33>O/'hPgi%4O4
FGa/G+!oW6EK'(NZ(4_\<l6oPf0-\CoNM$LZTXMd\U3XV7XRbc(*rOq3ngPR(p#?V!$Z2Hjk
s<20Zs:A-Xo"eA1T.<$?uo<jN2Je63F!EWr&Q/p3#H=d:9mXg)isi1B9jAO_p_Y:+.r?4@Kl
jLcs<\<@/c1]A*P3S(1"8_7.hctu+h@s3>UPBUr*N=N\0h&q6TV.t6OO>&kPk!#HiYq#ga>Cm
C$&C!j4Z20#h0nSX=BFnfSl-$E5?Iq,s4rUU::fpXWu=pr?AcFjAu+n%+?WS1VC&/TBa.ZG?
-s/^Np'^LRe1HlIl9n=5^p?!4As%QfEd!@eIt,K(2jHJ44as:_F/)F1a2[hh"$1"\^Ld,d^O
*;%&9$X"oSTHbh*"'W3OtcS,"s;Z"!'Q$]A&>\X2#/V=NJ]A_5,*K5&GiDMP`kFg:G&1PT-P5O
M\Dl'NfLI&7`(E=Qs;"#C?%CoP2+Ygks/;^_<"//A14Fs&u%1q=1ZucgAY&WfrTU)+Al<[rm
8bf,o4>Se--3A/NXf&8mGtFSU%1OkBfD?*p#ZO*(:(]Ah5!QXE[R_mjiE&h^n*=BO)?W!TMPt
SN?8EgMc[%\FpJ\#Rk)Zc;inP"P*tr`XuF3h9SB_Tc->R^,S?gG4X.*-(%guE`eD0R,ittbh
akTY'9R*pE1Qi:E#/5D8N(o=j0X<>DV4L]A51p\D"6i_;s#!2$#%81W]A2!=Y_$S2=HFkWF0)3
[S.j?8_+8/)ed21b"u7=Zp\bO#+YW=I6M9Mg-q=\'a]A+fRd6T\<\.62%Ii.qB3]ASNfM%l%Ub
gU1G#5Ei0DZGk"`unf2;U3_GOFg)"cQKG903]A5)/(!n@3cDn^j9@ggntpJBDK/?HmWjXDZcY
/o-/1r!.Q&Jp/rXmOPN3L8*rDmY`)ZSkDd1!V'P*n,1g(!nO'5/Aoc1!G5Iekp(Tsae1Oh/5
/]A0bWPGY5+m4+:4r/Cg<=]A6(EB^Xd5"81ndW0n;eWm\6<@;mR9D>=71$9*Fq#E_IS1SrpDPr
lG:A*bgX`ZGQG@e]A.f+BM1QUt8qUY)F"?A)^jXD3VC6cJDb6co@6Ho2L$d4TB@1fuE^XrI+9
7E2_r]Apo*o"9GSaC=FX1JO+IadhkNJmmIp)1id`;Yrj_H=g^`1DL-FB8Vf[bH`sR"[V.[,?$
Kh1D:XQuN3(EE/@#07d>p(c>h#CqeIZMQgWi-e<\<=F/:>%QJcU#<26rQeI<I]A_Iq3WXW]A-Q
k3dZI@c"EH9/1LO^,e!sF\#1+V=7OfsIrUbf:=+d(6k!#+C',Be<@<sI)hRZ]A4#/9-_MMM5.
BJ)i-:p?B]A/uW)EPhq/pKuT'<IE.CEc43^jSdj?+i!HOeE\$:=gJ\Hd_l2\Ha2<(OZTq#Rb1
:n5*JIA$P[Z,2S0U5BLo0_E(@15\XB.d(IG?@">Y3[$ntb4VR4YBI!u?M6#Q44Th7FEa=i0Z
q(7>JA-TRP*V;)Y;Z2DfRcj0]A"2\SC0CfeZ7P!A>03&i"H"c!k1G#`ht<hD2db[0Z'2CCO@N
(YNXD4oM+_JXFIb#:k`aqQ(X2*#gP4)?8Z[gCR9hpY"!l\`^BSS#%q?S&&">\H\q\Xl\;oM&
1+-Vf@l<PQ545E4*)6FIVY]A%":5=ob#3D3S^i>1h^M0`%U?H!?pOmY6G`3qK2).f5^2fAp,<
+bTSW9Ghna>0A)A1`On"cg;U*-/ofA<R05_R;9?QGthqO6]AW#7,[KgIlUu9u&EL=UgG0hLVl
lhn^)BuI/OQpK-IC(iDllu[8@C]A:C3j;J,Xp)`kH#REAT:[2&OXmjXkI#Y]AbI/3n')^m8AMm
bC\sIn(FuPVmDj;/&rVb7gMKEr6mCg%POlOV!7u!9Hi3h^f+i4L&b;Q9^.d]A$j+'fl]Aq2O<0
48E8=!mlRG/u;NZi,TAY:Yb#aK(_EIdk(2V;1MG_TB]AE%dBGnB+[F*pGN00GNs??Qk[kO*9Y
Nqb;F;448oMRpJ+&_*i[dF&T<h6U1B;/;`8dtfIA[s!3;PZGEXV@PW):2p9u9M"XbWe4`*e*
"d-MWJCdh8#I&#Qq\c9[:&\t@k@_bYrBUutq&UMT+e'8AN)J87#n3@Kp>S#%j'Q]Ad$GknrMU
>AU4Q;b6djt/hT%^u*eJFZ#UM(]A#$E-u0aK%RKPhk!fr*-n/Xm:`iS1h##dD)!$r?atk3.Xs
(-/D[(=X>E%k)FP-/-%a+J$L@]A6:%F*5s'+VP\OYrX.>e?=!oot/E/7f]A<uGeTNS_D\WT.?@
jt=[G:c+/U\(?>,Uc^I-O4O8(SI_dj4VD(ndMuD7MAsi1h*B)?R',7o?3[QVf\E'm7N*cV=`
YM\=V"NkSo&^@3]AF)!GmUfc'p+j8lDS(Xe40S:UlG1TFi]A=@^\4I4si_cQ=W8FBAra!"pTp%
<@D2faiIAG.Ro"-T(;^$<uteT[3k&sFLDn:enX4!/8HV>O'8/#[kt.V=3tR\`W-R?)QbhVl*
ARP:go,-0^U#Uq492!oJK&Hpj^V+C1@J$A\ID.(<"rqWap!9e,s'sJ:bucjHD,>R<7^parTA
%1Q4)D;Fsg%(qc2+l$]AN/Sk@/7-4E\pkn!Y*]A+Ca5>b<V&Y0TNJjPbu/]A#rBnNb*"=d-(QjS
4SIp0O=6Re+_*I\cXPj,G,]Am&u"uf@)dr;IH7dS-7uGE0So,V6>O-.eP7/Fn"B+tk/lW!p$m
]Ap&DE<Iqb#<!nn$.dcZ['ogc*ObDH?nZ\&$Kp$n7<eM#ip*!a:pd$`QdUT"ZH/Dh!ts[1<qI
-;=o<XVDs%WosO4CJrp!Ej=J@IZ3K8SPACm\j8+UpK.RN>a;Gs5VK2k#qr+sY2Zl;;/X3g3?
,;c;EQ2a$G4XNdXd\Hd:@bl,K,Hmbgtu(6s_HdLHXtZ_PNYjWN8gTL_=]Al;`)qR/!\N>'P]A%
>9b7iI7#r^Ee$<2S6p`!?b]Aii>FY;(&K/-FhYh\&*Fs:$DTPj?q]Aun:4cndI($[(D;gqrj6n
0^*$3`b$*Dca8TM%lps54Ok#@A?:06Ll7>Fe``IQKp6R6pJ&"Y-9-@E-[OIjQ+mp6[b.P"/"
kTQ'8MW@)n,_PQACX"ng+TNTPHhe1p?'!s`Jr^,.fMam,$ZCR.b00sn_a#'A*`[HhoV95/.s
[IWQ9JI=&hh,mR4_[,Q\lRT^:0-EdA)6>H2;Mn3%E:.gtl[F2K]A"Hmj)q_f_VWH5"Nko&pA]A
,3e'RLV$Ppn_+bS4G_o&;+%1S)TI,0;BE>e/6`R+BT5l7:!5RWkt-Y'1Ds7nIkGd7h@b[*&:
>3>b4:]Ae-/?Wa]AZf;Gsi]ArN>,_f.p5JG"o_[7+;s[nkq<d-)Y9aq8h0>YhoN5-Litcp$SEi+
<Q<r`JnHjp21e&hIqeDR#U!9gIuN%HJl,NJ,.$\12i`e:I:nh$A;G8S_n(>VrG[biGQpDXoi
jbaY2Xp@YrcWBN\N?WZ`"HabO%?8CU.7r!.2tVa*BeTh4+oe+u'/@b84aGA^V+!YUsZgQ8Tk
(4,BuIMnh35D_[KRmk72PH]AU=fFNp-:XLga3%#;VMrnVZMjS!B7\$8GV>q="PsP&.,/_HaR\
M4>H*0UffkH\#A/s9P@3j(XftI3i1e2ASQeqBcgD1faCr7;E(Y+AJ[QX&`b&B=0k17S[_LE9
%=4VYj[N`@:&SFdHb]A'`-e(r3r:&&U?hRe_[*4P[Bd3k7WG-Rk9n[k@phPc,"'Wd;bR3(dmU
71"keQjpV6Zla!%8H$,q:ubZ&K^V1[pN[&K,C6P,N?fqG'D:-/0QTiI2brf,`oGm'cC=ELum
#d5?5R4+/G<e*EkM^_[j/o=h_N&bQqc:'@n:#/uD4$;hVV)Xc.hY8l\p,L./[P(bp:WiohV=
B,IW5Un?JGdj0U#W^Y&q0GgSai>Lh8["bT_NNtWah4d@Hn%U\H*"g1b:M&:9BN_it=2m2`.E
WAEW+H7N2K99[_#DMN4$94lr.=`PU'=;8=3\,.heS5ic/+B?U6u7(,[&FHU0$uHT."?I#(,C
#8%51Y&nsCNh2d"MQ'NWLcEKT%ECh!qSAQ$_i;NZBVstP3":Q=NgUEaDaJY&d<j'F)eK=tcX
?c4aO-8jYUjF%XL0jS"apI2u5MkQ]A@*t&17>&.<#0[/i+uDu,KCk56Lk>kAl\/@0fS@qo_ek
M44DKe`hBO,14mjcEaA3/4rK^#D0]A7p*+%p^G38t>#6sC5$9b`lCM4!D(&]A0HM!1EO=L)K(]A
?&`p1)Gp),nC6&:aMZm/@P:PrF8)]Al0#IqWj!%h-/.T?J5hM9#/j#I+BrXL6lO.SHIo.AX\2
?^Mi$959dXK39-XF-_\.G';MV,i;7f.C%^ii@9rfYJq*)LLRI^Yap_W"^['%U=#42Xc\O`\U
jDl<#AA':b_E:L2ZdV,Tik?J(U8i2S@b4!O=*LoUL[<n[>^S@_LQef6i:tqFR^YKG;aoMCFb
1oK]A,cr<1r6A^.(@[>r?0im\dp"e7H\?g\QXJ`AjtObK-bcTV2(S6gl4Rt?rR=L)W?UUlU<i
6u)Sj24Ck0q@o;bq8qD4TXb:n2#lA(feN<0;c'+H$iPFFn[>hj`A[b-aWf]Ah3#,2'GD&c/el
Ji*9l5;R3`\L.XRV(^(P\T*BU-+eY/D&<kk_'MA7DlqMbNK5HCl3<eZ'i4c1lWrNCS]AZ[O4,
><"p=Me'D5$[`^s*%Ri(VPpp$Dk(4MQih_LTP83H9C!g7V_D24QGNOf&jcVb<cpgl5D,kq(/
T+S0]A%N76ZWZi:IClGs/\-pC]AjnPL,aoqc&)h$c0FG,Nf@->sJu8NO2cmPMXOgkpQ2_5Djof
$dR,$X<pO`i4N?$ELaX$tgQ?ZSRXNfUR1X5bqe,12C\>O4-9>-X6Dj'KeCt$96U[T2,8]AW,Q
=gm6Z_?nQ5]Ao/$f><2)h"t)b4>OID5nZfY3_adT="/#tsnfp+QYKYp;e9Xe<b!.L^;,&P2G.
>oI?Xhl66Ys4=<D,?j99KEB:q`h)LW7g'#qT:tp>NS!Z5.'W4Y_"eup-u2c2"0NZH3^"X&p*
<mog3>^FSjk,ioL<UTA3gU)&1_i>1+X^4=6C^>9nL0KWkE,ms-qpLiKsGR)3W"`eJ^@,%5BO
=U0),c#O?hCcFKkGn-UD=*RR9D]A7"4#"]ACXH-F4NO'%9Vck0c=`/0\->Pa1!"lXE:\(N:(&X
`bVgNHk'nrNsS4]AWX!deng&630al,\)Fe4#3s)*e&DL*o*ADnb05!.?j)@Md^_F8ZaAH%[>n
PQ\Ug-NMQP-kBAgRk>H96=k>Dhj;]AkZIn$XoVr614m6D(tMieB[k[&=tg2UP?J@JtY%<Y-Z6
Cn=$#GH($:bB[l9d@4#,hCSpO=ul1f9Kb=S0=5Nl0!XeVV8K`;L?tc4KnID$bEORjBh'\kK?
KO'K]AIrNRM\2!9<h&^O1<2&bPmjYo`>qr:;a^I'HAIN1R_+ZG%Cu9)WMjh@0unlJ)gL2A0]Aq
-%`+TTkqhNj*:(nm'.0#.dY_)dPI^g7^P*Fqj[,an;1RUUO\7/X01+d4_4[4,Vuo""7*c)&d
.>!qhm5G+I#cP9#&_eK/=$eM,ojh6L)dMgW222`S-W`3e6MsR>qs;Di%Pse9b?S3Z:>3u4S5
X]A`:>.5*E'UootcXV2/MJRf[m]AA!G30jVqSsNbE%ifLB=sKR<pe^H,Ghi3_)K:_c(_i4eJN.
8r1Y$!F33mKn/A,.kp#4R.YT:MTa(1_2;tDCRl:+&p!#>V)$MHT=/#M0#\c"3B"`S`hfaG:U
b4:7i;fZ>nAHM>?tgipJ0L1b!!]A3:*PE,'O"Cd,u2X,T0l:[O5Z1G*+Tgml+]A/9(e*g0hq?N
08NdsITIQkp9(]AJr\IV-&?5Vcb?P'2ln(G]AuKBd*Y!]A,+>gmZsSJNEGg?[A[M+o+CM%8l-<m
Fl"'RoFU6+93"h!*%:!#[Igk.`Hpt"?3uFUk,N3oVJ-SX2B1j?H%l&l::@Vhpt?rTc#e;k'm
=\gN68?-#f=aFQ7%K@S$&uT@U@<c(qt27r(.-<Ga;E/"M--'%p"D%uS`d,dct@E>r6$Yj2\K
AMN1J'*$>ZD:kkqf!i5dT<\ImO^?Qq=9*X5g&A!'igiSb>W^_5L'PI/WM.iW@nc>Dj9Z6e/3
`Z:<I7#HrD$(=%/6W4W+-SfCrcIK^\RJ*]A]ArcI$lCL`UDQh>5>]AbSgooKM2r/Ctgp_HV0ach
0.>r``Dn,-=OW33TQX2`aTKM5Ik$jBl-Kqt$n5[pjPjsDarlt^^f27`UWXjQqf(``6]A+g38\
Ai-7-#[U$IXSNF9IVuO8./DP34/uPURF\6PJ>5u3QS$5n*/D5V'roA8d`++n<R[kSutDLMm.
Q#qdjZi-.4Yke7]A6Y=7q0"@8g6tEa)-0)gU\3,JZ;%q]A5kaHZA:P&3.B#$fLGrf6bNJP^_<T
">0MVg6qHKW;L[`nB^<.pWjgYhi@]A^Db;O;-bA=U'q8-CG-UAP?YZB@.s3\OYQ,!(JVVCn]A(
:ZV=luA?!aXJhK!>=CC3#1?X;UD+V?'KTO-3WndQZ.#b7\H!#&mPfjh;A%T(YZI`6(XCLXD%
'(3:uG$miT9Joi+5YZlLI'Zk[pg=:Nr?Bi?J7Z0nEO"g5mH#JAL\-=DkR>2M@@t\8L93M;3"
W?5]A)1<Ba[QmM[h2eNPB>M/'@Nf&gFmM_Ok\?4AJ1@6s&j_3.Hl-lq=Y`J\qafi@S,7O7X#%
$.W-*hj2HalS#7'p.F+_`-4<l5,2qdri[G"(S<2J,1&GkP'Q/Ji]ArnP?h>fHfJN1$Tt`=4,4
-t",Vj;auK8T3^"/$M_"/XX<`l(E!Z(9BWCnC'RDiSM:HqLGG-['`R7hqbXF]AB-TNli%d*kY
##T%$_r=,C6i-ffDg1gn7/u_%NelbJO+6?1,"2jKb1Vl7!<Fh)n@NoI>W/mta2VT7TCZ?IcU
iIkW2hj5s!#po4N(3>rWM33NcPpI&L@UQDg'-c=BV2GJa]AGRhfjXRam<(%YZioM*i@Lf?L7H
N<<,#QU3pjDdK\g=$Se^-fm%CRdH&]ASZDY(i$k*aoS2C(P;_$#^`W)DcU^0>YP70>X;cUe`N
*`@+<BMft*X;;ZZJ_?OH!%kiGc$'t*_]Ai32/O?##S\,Zl:If'[f`1f`a(%n,?/KP4OO7O$b8
]Ad\+J0XC?(pX?n/<8F&TiCbQ`#/9%\4uk:;a./^F%]AKVLGOl6$FYf3OM]AGNV.qDCGkH#CJm2
8G-8%5[jlN-1Jpl?:-Ga`Q1Q<d8rr.`%E/`&3Q#Tqe#.X)A27D1oGZ6B6]A-'(/JU_l("W"@m
PahZNFTrK^1!W#M8BJoS=WW^B'3CN4gnY"d1&?)-(2.?,+dN(RMhj?%-C66^@1ltc3E`U'E]A
JXD<d`40)E7fV]A5p]A</&6O*?f$.k<);#7G("_O):i<XHkcDg1olF'AP58,q,:O97(Smg0b0A
Nqd`02A'.?$7^gt#)`m"5u.q$8EY^u>I,DTEP"cf437tCU"[1sC-fkJkn-*q#rrmjmcf%c.>
FgW8f)akkOLO[YGc9tFjL*TnddsgYH3b@lbGB/2G)D)^)SWAh!lkS2"<Q-QLL.`OUeAJ^qNe
Qtff/lJNEUB_9;A29]AW!F&O]Ae[D1&LbAH;#Ud/#RFR7^NE3HETT%#)$/3G+K;)iSuY.4Rr`(
=TD'%)ds8%s;%&</KgWa0_L<STJ^"!l8eY]A6VQt18dY6e,IOdC?`W56,e.s)lbS#Z%^/+=]Ad
@tPo`l<!#XfWDr$L+hr2<OY2RceJOo)cl(6>cNU/eKouiWaGNiBO">50;Mja9D"`NrUsuTo'
)Jre$?L%m*s+Hd5'17q+8I132XL"#F^F]Au[Va]A+\8hi@Jb1RPY1tBXi^.9\5oC&!>?05%4p$
*2qDGarLc>IF+Kdp6/7Q5b.^aL(6@0!6ss';W'he76tN*S*;*$.\?St&[<%nEKd>m,jjA7,!
bUqLS;!Z-`7krcl3_T"9Bd.BCeF"5EqbH`N5b0a7J4cgK#V#_c/L2$heM/&.E42o+Pf[RK-;
mNkP<m11832e0Oq#9%5mE[Y$6k[o6ULkR3d3+c1_:h@Q1TiLGuTbT<XO^OMiu";/g75B"p8E
Yu5Ukmk/;DqkYuk9eN$#'VTg5snWT3!&O=/:hU25b;UW4]A3tU/Qe.L&ZpViLsR^@>;mq"L,D
?R(oN3hfh*6!8K($^7lUMK@!;@j`W!Fk_Zt$iMT^<2D60\S(M',lR.OOlQLuA9:$\j5O6`0h
OE=PjeTJgKjBToD`OFBSAF%(OHCl\(fCc5bd#TePK%#a$^K75`)7!Kn.>8r$-f=A7*"6STo7
q.@$R\1_*F^n.>*>5Pa`0`CaU_tYq]AFF"EA55?e+N`@=UJTYV_@%j_\LeI,K<\7-/HGSMA3?
[4Hlsr@I84*R';VHNX>=XWa`sqdZ6V5eh+[a6m4kWJCLdKb(JjE\0''`Ht%OdqsW;1k:Zlt]A
cWeLb+8"MLJsESSocgk<$]AOK@%b!/pGN$H=6tZK):@,lJ[[7'Qi!DG?5$94lI_oa/]AQCFe`^
P2+!C"LO:QZLCpQ+7jkDobb.uS$2C?\-3cYK]AYD2G>;8s?1P$EWV6K;O&$o60.+p(0,]A(>n2
C[;T@q?N:0^JjsoHK=q[j-kZO+=F;+ZW/<_Hq\q[Xb&h4>g'lNg2a32YQ)lS]Ap2#`r2TdaIO
h#oaL[n\oSs(-VOmSJ4@7`\:QJZj?/DSI3^tFlm$u97Zf-g&;Peq1+L[^f)b<m6R`3=l#Hb>
JE#DeMIHM]A$G+FN5c!L&ZH]Ap@.*+iq%/X'QlA@$mFk"Mh/V6;j:m)a(#VhEjU.0'.bgNGDJg
NN3VB`DInR$fl(M5fkC<Lu_Vqu08DDKKo>OJt85<!WBh,jEgO2'SC36?)(0$A#^@Y[:oA!#O
CG_h#".8S=W^RK%)?mDo7JVum"(r"W8JgE0T'%a>e*&&%FZ*O9lBoCB?7qL9-ta,5c.r1URQ
+3-@]Aa9R.q21EIEpN&@j70I:k]A4H*Q_9_>G5MW[U6mad["all[:C@?j04/2F:8nj%T*4]A(m]A
M(6^@W>n"Y_f1Iq1+h=%P<`S!Ra+q*fX'*;9?Bei9Gp^r^9Sf8!&a2d^_qdSKiiMjn^j\oCh
nKmLD'q^Lfl]AnVN_;=eop*]A.qi\R5uYc13pcB@_0(G?7!AiTJX/\mV"aUsu1AiII!nIdWDL'
lAj/oN6!W>5sBJ\Z--TGH8L=ec2<_)43%Ea0a'G2M>K>9'P$DKLONLOmsh9"?"ZkdO/&O+jo
!=De"-]AM_K"Inc#>1JU21O1,"Alm]AKTY"961>gj6)]AI)l?)6p[Ql/8?/V^l59$-iQ,&d:hI@
"t<?mgo/]AU*i0E&eH^J$eM%m[3`8sqj28@@m/1i<*e7gWW:mhpn`E!eq3OC8"o"5<mP1i8IP
<aEi)dea?-Q>WbA^2l.Ed(+Nbtr`ku=tEj"X`\):Ph=5FXiLr?W@ZXfl,>gsJDl./5bt&(Z6
3Yg?u9FmjhM#kFEHO%U)ZO-r3D*6ICeP%3*N`5N5^IpeHf9!J:mVdbF5l)W^$.)T:%2SB=lk
Ch,>2qDm4flAQ+_9]A`LoV]AnLrF2EMZS4K<G#?82ojihEf"A"6p$Y_\s6M3F-AQ$Tf`/(+3?4
RAm#CgThs,^8oLLDtFYfpb-^tg!3iDm?p>QSaI?mT0%?>Td$*puWN.h"S`E\0qU2U"Nn539c
[CiC*9bM&LU_%Y86e.)E7de?/psFqJVFc1Knb1;eZ,<X=KAb,Q?cHipTc(`FhhYf[Y`&</$,
_jjn%j,>j?:$K05]Aa-'c8s'Gqf$><09Ih3VgE2Do0"ErM29\R<s4JEu-0i+g?Ru&==U3SnuS
%296IrLg9u-q_REhT[3W2qX8@n,967bSc&N]AqEGbd'BTkaYHo*rqE387KMCWl01pB$8X[R9B
&E#]A/\SFZcFA[dO07=*mAAUU<4RG3'NJX4K%Os?$EO2:]A\koh-s(/OJB,fOr&9N`'$bh-!d*
u(SL9"SJ,M+/hfcnKEfXc&ZbltR$:LJO7HNMK1RH?`%6XlcBJh<1Ld[N_J$loUnVN+#IuI0>
?Xk+QU)du@?9=j*[ZUfeIC,3X4_O=7g'M%T/^<<n=H<Aj#S07-Qko_s*No<a1PNNJP%'s7Ae
$'7+l_BpmZ67CkCnA^-alTf6"5N<>Fh62a2g['W3`,&SY,V9I?-80XuuDFqa-lGCg1q_<Li_
u>?ZsPl5n&W>%'E1*pS2bV/MUD]A%&sj0$1>W%U*F"`9U<X'*$%:@M>T99j#%Q@Y4#,W30,<b
^A?7&RG6F#m*3./$C.C#eNkVo@8;NG+3,Q4UR^2?[aWo'2)K>Q%!Mh1IG7/gC3JES[bm!,(k
2$6_gHajS;o$#Tt-gJQ7ZbSul4Z%Mc&,@KC49=lkL4E:7,o4_7_9PGG>SL[Snr)"ete^s'sf
Kn_7+8aJJ#I/mG??[eC9H@YYg'Lt8:pY6#AA:3().5WU899M/akjtCa)$I,1deK5'16rBRm-
OP%SQ.J/\o?Ns<W\YGY&Lot(k7PhY),:HmZp'dOuhKkjTYCogNfQfj4WV(q\`'>`oHMeF?,M
V?-%6Lhdj;ens'1:C3T7Q;2jG8l4M=)p9U)fJ\c,IkBI_\pU"[Z33O,,5_,Bqku,-E=-eh/^
[/r*gW7ubbPD+'JR;^O)'4Mi\"9*lIR17<=]ANWQjZdet]A@<f:r[j=[l@Q6anEM>pmj30:LNo
QJk$n0bG'WKb^L<ou@Ua)ocmSj[+HRZFFfVn^4jL`#ZItt[XKnY7eA)N^EZ[B=J0]AseEE/:f
Yg38_g(Au)j)J<NR(3"+>rX82natOgr,%Ze;1P#W@ir@o%;U_C!6V-KqH)l.oeJ!t-fX&l2K
!"HP`9&l@MAsf7B+DU4;VEWb\Xmh+s6g-GbkZaYqdet'#S2CeCAKD9\iT/?uRIE"uG)IOM=N
Oi"L;`:Jpc\'R\$m\4>'%,:3TL&Fg;"q:)pC+HA?%@cJTH9Lb51]A%jMLb(aqcbE#QTK$8"8O
7_a=PX-j0"T#/\E:o.NkEug3`+@FC#=;5%FO?`12LTpe=R:uV9^h9-JZ0tK=a*l8oH+V-a"2
U_JnG*hX&$,[[M1]Ai'_M8Rqi=$nA\/J-SOiM.[2&/I05;XF3tN@nmr4]AmU11>3qgPD<53UNL
.TYJ/KTXN4A`Wdj>sP``c)fH5N=WVODa=-RH]AGVjL"JI%,li@g7Xe*[%jLsJ`^m*&&)-S@D:
,a/Zf+IL\X6<'.eAKm<h;f45U<*u:I)?'o3O2efQ@\OZQo\KETWij8?n&hmI.q-F>jLk\UTa
>oQRpQFZZ+El..8ZTQCB#B3BeS_&ueL=[^Ah:-A+$LS(gAc38b.LL>rj6@eCN_]A_Lm@^'J)9
=P0jLc$"00@PU)NJfLHnVM\MXZ)Qhp1"Er&+A?A9:[0!chnO]Ac:anTks%mr;SJdA@>S.=K"s
=)8bFhLOR@=6.R.G#(f,rbNRG?[l+Mi'a'8]AC//nq$:!Ao26Hpm+HTiO(\+M6)!4%.fVtWQR
-a2:<6ZWd8I;G"Ao682#>'G']A,3T+Hnr%.TIkhN)k<Y($4O+AG7R7$/Aa2M@LT^Gg[2soWB,
\)VIQO0rU#&QB>IK66#"a<55?&UYH1^C,ro<S*Xg\(<>HMW>"OF^/-=g3%$Ig1T$GF,^p&k=
]ALdo.e5u'l+qDQ5UAc:pJT(<Bm$/\ld%7cZrW\u8)g[:TS&CL2n.ckQG53`DND=6H^&s6_mY
WT8^WZ=/EgLH8"<DCD/_:8$ON??.nfApW"RhXKk]A-:^\Pb2qSZnS4rMN.Z7X*^PK`GSn_%Wn
E8/EoFJQOOCRB'c5Ynup4#(bC3-PVg*4eX[ho3SQ[_F),9A/Nlk#:f2FKkt@6-eu"o^Q+A_C
O=X"l_^)j_#C,IFhZ!MJX70bcf-E3p8:9_\5\Y=ZV^L#,I!"VcK2>Q+<''"oU:do>RNphLJ.
kk5kn;>@0d#*Clnub'qYe_o.)VGiDh22d,EE)IB,'Wb4M-R);-h2tn_6IHIPc39pIQfaa&R#
WCSTJ1Vt]AgA`DqUq=m+R%n+t`V]A?ilYnB(UVTi^@"/Ym4D^d'Ic<hPd'A+?OD9*mlGfnY2>7
k=8dg<mBXOTgrYrU%+HA;EcW_OTU>"IQR.OlD6p2R5P&cufR*]A10Te[?%B`R/NBI4!_>ZM@h
n*\>8Yp/UI:J3EuXop'5J(NWVE/Vq?766Nf!FX$qInV1pQ,lqHNmZR?;6e[lG6\R\rPNiU$m
W^\<Cl1sC%g@=uUd]A!Wkh\#3n2FEqg5EVK(p1Q(Zcep"PFc)nM.9Aqeb;;p@2GM:g/1VOj3(
sWm+(sGuqh&Q4!N&bL;:G>ai`(nUDkj`i7Ah[j935G<o^U4aDYXbf#0`^C_/.@bn3$a%Bie7
!6M+,/:drXQc%s,$juq"'QZkI^.0K9/5>Ff43>-ngb)q?MYF8+I0lhK$fYu@i:/*;aIoCkhN
SS+GHI#q.88/\80N724'1;3XWVtLo#.t>l,as7jgU@u,:tL9()Bi(p8cr8coVC&)]A8g)sh\J
3ud%OHn>W07Z<_ed&R'Jb",EihBSThJCKdR&a,Bkl.N't2K3;)]A?JN^2iGHa]AkKqFH&0l*>c
8]AlG7=aX$nDSMOo!)AFkOs$Gc-g/0V+&Ss[-r\'@FcF3Hb]AsO.C]AJoBGCk_2JS<E.3>XG&ZE
Fb4(tKI04QoS6j'*-eMD=7)?0_kI>8#dhMh&>d'l&F,<.MlI!@>bLJK%N^Jm8kRN=@?Fn<15
Pjt<(l1^Laa#o-7b_%Nao.NoXkYZ:fTX5a5bc'oQdNBWp`;:KQNraokb'W)gY(r6Eh//8Gi4
<jUZ2s(>[AAC&P3:oUQ:^Kab7LW;DP-A_m23]AAY55k$/0-kJbgD(P`aKl[AN9o:\qf/gTf=%
l#pg,nOl(.pND,qWK,E3<(L<g;cE_c@Ik]A7"il^R.QU`f9!h8!Gt0@n9QRY5^&Bbk\aA_]AJi
A>gs*KqPP$UjABJQ]AGAX.]A_B?2,C/)a7rM<cBeLU`N/V6=".pN3]A;m,WP:&4Fd-U.g<jtYjF
%r0'Eh<i>=gA3PG\*PLr:L8>a=7Q$^I"Kdr![tB,c_",.#q`-V??>6Y60n=,?.sn(E.d#Y(p
h6De^(qUK^'R'Z1!jJ`AC.gu2h0D#d'mQTudBZ3WF]AL!mn#/*#4%,>3#57DTs#g;3JkMe-r=
]AZDpl"VKB]A"ML4[,ulU#Fo9j<0.'E!K=`7E%9H`AUV6u6_1I+FWR>Ybghu>5M4.$9O+V1SWP
cdS[2OF.@MO.ceI&7n'>M3fj\!g&[5,3eNNO8k1)KXV/>eu#/)LcLJYg;Q`IIU?r6trI0ugo
#P#6b$dutA^NE.WK$-E"\O>_cM62og2Sf]AgUKn9PYIeqlG#AsNHo*pMDI<CLgH91m3O_\r^l
>28@>U&Drqt+(_Q&MNZ:<@V56=WRn!i1HiHN2OCOBT(a'7?Y_IPPdgbf@M(.(lujf#sndrG(
)#O-llg,3fiY^fmGb$I-L;4)Do,PR^PNEf?(McG)`""TH:i1-eThT?sORKNBfa0."LghO<A2
m>;MC):QH"c'gcj@h'045Gj:.Bg+kYe\3_D;E0I5fY2ko]A(J3n>O_B%S)o+AR1lS[Pl6,WV"
e:j]A7@M#krPJ2)du*X)'C%d4!iC,bM>(]A/2"JgEJ=<AaF[Z>d?K#Tq".Wc]ABUZBL#L.CZQ=F
A'M3B]AI.79;p.psEGDdn.tr]A@&IIK_198F&IQNHW*R2?cN?4l7&YS`WaZb+7W^I(\GC.P5S2
kJDo@G((L;dV*MB+i2!&24uMcf@h_g8HqZfu>WN:5;tGZmD)GY)RDdVb!*>+2<-jHrEb78te
KnRO_@nfu0JY;g*4C]A)Nu$TGPChJ1700J)Pg^"/cB7h7`o'tLl`)0@I%H$sV#+Tcn$b()hi"
U:U&4"l"<nLV*YJYZB8Aj?hd)CEH*CGLrX+B6J2e8d)#^0sY##k^d'q<&>+CN'6XU"!DI5Ir
9GM;[)(P:b\13PMOjm?`j2DJ-Th.g$4o`]A,bA["fLn73q>Lbll)5)CCsu]A_Vok[7S92)Wd0$
kaoa$>p`ORid;POCHq3op>arNjdCR$ci0g_/sRC!oXu/CgN-_uA93o2D^gaeqJ=44%:87XI/
[t5n'U>5!]AjRdKf>Q[Iu!e^XEbdp3T<,2+5o-S`XD^XdrnW,lPhS'o]AJ/#i3!m.+b:"-P0[#
1mP\dG')e+WMaN<7@o:3h8[L/Z.0&gb27A4T!`/CF0Fm:4LDh=OXF9Mb,,9URTGF4[*J/YW>
-r,a[@?X_U#B,Hh':2Yl!!l[1scK`8fF@6embA=kpPRgPtq:jjHB'sHOE782,P5^VIe\#fub
Z`XF#>5V/"oqot8(pX<6\LbW(Xn:5ukqFRGsNr*kG?G^]AIkhWbTIosfLD_K[/egJG\u`tUFM
,I#]A0*-/b+;P45RV"ftn2G7BriBAe:II.mWPS(o-R=.T\T6e5>[gX.NT\b-2?Q'D>\@KiY9U
jm;gfI$807G6L;RbgDRm$&#@OgZRfij5<3\jLN@>eB38c!f5:m=(&Q4'F/\rmirG'i'?%68_
.C;<S#+&VqnK%]AV,PC5#?m]AuK$HkE$\)Grb>7NT)8mn&@2"4hAU4O.XlAQQ`dLg/uhn5m6!(
^ih<:n,6/'kHaY^$Y2IO8!HBD5AUe8ME)of(Ub#STq\O9at0(Pb)kF69Q:lfQcCrnS<(6ql7
(uW#i--,]AVs7`h_Vr.5GNl4+;\J_Y.&%Kj8:-1#'W./8Y6OG.0UF_'/mPfmg4r6QZmj/S2>j
ZJ1ld?_/8^MY/WbRq!*@341:J+#e6GT/7)r(=a+E:tA@+ESTabC:r$>r+<]A#m-^5+P4202E0
[D*^In<L;1F=Z$kcg87/F3)2]A]A=[VI/Y35=O]APs(#g+3\,aH2F#Hl_>n/l"'l>F@u6b;jQ&6
6(?&Dbrq9bu?.$Xk":@oCQY4TQ`07hj8&HNOJi39$_f>[C4ME*F*b9`_oR1?1D31Vdi9#V[A
BNJ>Lg>BS>,,LKfrV^gmoCAW=_GH+AW_#P]AXVuj5'WsnG3)oZ=%mr"?&tDdZ%6p)3J&1:[e3
OnUg#ss-;OG^1o[H,r.;Wo(B3'u@%oiOJ4;o4,]A*HmD6WIGT:ZkfGs2'\r:FD^!]A;Yc6,h#r
SP3D1fU2P3Ed8-Z<'!WWmECiMdoWr&>Qc4#T%_W!hGVZ*ZB;\(YS`M"2I!lV20.?&"h9ij]Ab
Tc:VK.[1%h&9GrUj8K>)+'\!euT\2^Ou`F7)d:ocA6?:&E#%'?I,Sc\&4MjYQmB/,1L]A'V06
HrqA;WV9=9[j,@(MK?'<?G,Ecgdg:Sp:0&l$NDWHqee)Y7peCe(G0\e(2[tf0DUAM;*1*WRV
Hucu"1RLJ$gS0P9<`rs0r7E:%pF_t+r2t#b;P.m39BhdaWW^fbf2_.q*nNrH6?KfA%TjM+1S
2E8aBRe!qZ);#4ruD<9<i=#Dr32[nG*Jja;'_r\N]A=f'V=gV(TKo4h_anbK-32G0,1bH"9Bp
)3gU3Nfh%jV-RfplLu`8AU#Mr7a\]A<jtT/3X6q^Ga&lh`,jQ`^B2#&c@";ncRIQNd`=I*%fO
>IF$db[[BgCX$[qFPJ/0D18f<2Y6h^D*HhA8=\lKtW\9^qcMDm2D.K>*GQl+8^3JTK,e!D`[
BY%1;IMukgf<X]AdYGW#Qb4G7Ia1^YT/J*gKf>YOtjB/`2HA@"+MZ>6QgC/VW61KnQs+hK?MC
6TE<.7Q0P]A,bXk`)858e?W65-C$odq&ZMW1D/G!;cM1V\k[<2^R6W[>B@eE?Y+Z[p[su)o'/
o@oD*djcguUWkP[LUO^.pXF6rGbS6]A,ZFrf"o7O/msjP9E!OnYVF%[Pu>Od<S,jgOfqN.+8u
Z4]AO?_g&ZXBkB?>^`moV.'\PUIVX_Qi=c*jm&hXK>>IYq+5ZMN<,*d,"H/+Oq;aX5D<YA+75
DB9cf&QPRH"]A&*kh/&I,=[$+7;H[WO+d5>MuJclYgi2]Am9@Mrp_1`c7mdNgj.R>ptYY/B;Ij
&iajl^Mmkh[E[-BQLeGr[3XN9:fC#_\p0#c.$Wp=t4]AbR?,2DqN?JZDX59TQfZ+.r6AidCj[
"(sC.?$8S8o`K'+&"5-kdff5h-%(9-[LrZZmFH0GG-5SDH1g_o@(nYN^AZ*/RA6'P0E.!]A-G
E+7XEh?OOacu:3llS3\egQb!OsTEW&jth;a*p%GU-6$:m@_4OCda@>E%Scs<>+ea]A*%&Tq`.
Jre0+L<h$.p75'a:MmhEbMK&"SGer>3To)*?aAfGX,-AZdG-6GXDu7,cZ0?n"TSrOm?KcM6u
?a_lI!s^1Ab$LV)(bGkIg!mD<hLEIs-$E9o5Ik-i@T*q5iR\/[e0F+k,I@lCLFnr.^un%UPX
_njB1@6`\r78&a50f:D,rk1=OA'mo]AFa'g<eqLk-':;o+3$LuHn/F3,3\t\a*G#EbFKsAE3m
]A$iFX7-A"cHX`Ha%5tD67qpfO<XspKupqn^iTW'[M]Ap66BcY1\8!2W3,q3dSZ^(JT=8c_XF3
Rjp9LIP[=R,210RAic%BoRK/*#O:6U"2DLlt2Yq3(UM``jtm#+mFlFaG5Vg@K;4jS?Cfbder
q1\6W*K\2I4Afq%`T\r&4*m_96-Zn0NhJJTdk,iPHr^o%L-thq)Gj?gqpLoXDcW+M!@NVT[j
3E$esGK'J8^>"?0^;>oWU_P%sohcP&C$HE=kjG=eF"k1C0s5hrG7GWrJ@O6'l99C.ji9ijEV
Vo;oYbpa`?a;Z(&!bl^O=HOB3t>:@O7!Eb>Bh(7EVT8JWPobOu>?p#Bl`3!dolgH_$k/HfF3
iW,+l-CiNh/$WH57=%Z:/>&>71Y?^Uh"`jfFm@m]AuhiTnM\M?,&.5:]A]A;DD(]ALKOmeHF-/,:
o#L4R`(j=&GE(tW?3+WS/&%$)X":qAhFRcboo#$IYr09/$eSPhPU?7iH`f7%l"P^+pnei+KD
>AnZnZ$,cR\SL7$06-UUYS/#KQk#7fRSR[XMQ>BOrVPpYESuf!n-Vn8k`[9ae=C3L/(lgreY
=aUj/+H"i3'BbanE@3`Uhp@kAAXs0^6=)h-4diV\XiZ$=@V5qAe3a67tP-E!cKMVZ3nNAmM`
;jE.SEj)LHnT,>&#<IgjgbGpq4b%TcN\-n._`rK!BVoO#LGcX'%Xqs<2fmI;EbZ-#KS+ke;`
piETc?4Oa0:(VDQ9"i5f8U+ULFH]A:[BOGj=!d#O^n2A4g5CFD?i4qTS@*#7Xr('n.6R*gjj&
+AB,4!uli9`4ighui8\.4bNM]AEMbF0B]AP2Y?5=p=,/4`]A>+DfYRG9,<aCp@dBMS.9R57!%C,
\(dc+q.jAu#%53AIGur1'$]Aq"7k+DRq&+Ui1ZGE%$nM"j!0(1Rp\$71dd=Xi5%3eEd;4oNUE
ncu4kamWU\=d/YDH1?[\eT4`gs)H#h3iV=fFGb>8=Jq9=2Yk3_I9<GCG.7@Z_?Y?)3=:D`sA
*/KQ03V6.INM>Ynq-BW_?0HiK`XOtZ>_>On9I@lhYlT$otPIH:!"t?;4)BNs>Mg[Q>Eahmgc
'd?2Z_5TKTH46UQH5#t^8J]AY@o2&;EY^6_Qi!_YfWs98k>>i6qI@.XDImuXml[$,.Ia#^?9r
@c^Dh:FJBCV'8Gtc-bI<5)@Bos#Uf6;FS[VeG25h!&`sKUiEb^2YSF"@6M-HaQMgJsm_D&[K
I(_G4i0j%!O(=ksq_\Sm+nDl/`P2,ZT0?S2]AdcC*_cF*eoK0Mf[I^C)7sO`;i0t*]A;+rQ3EW
4LL1@oX`C<P/PC@1\6i`sB/ZVReGFeZd*H4<p7ot&i(#IZR-;T2nsFHkj-KS3-"s7\XfM:gY
,\KrXG16^["Zg3JJ'hVJB^=SFKXn&(^3\ktJou8RG*(/NKcLnA_!6RE_XZ!IZjaSYo(6f>>*
ijIcdU+1&8_U\F`.,O&^R!P+Ye$QjZ/87&4-s%VJ8HH>(lrN%>J);O,\SR.XN>W3=!l:JT40
$(K@T7S+LTF+ICN:#%JL`H/`#-KgQZh-aWangb\[5a&mk7oO2f/ZYLgM[7r7h#H`&Vd&e&d!
NpZ_lGPchRH2bt_$"b-*hhZJab^n%\q)TfZs+/C6[u'Zk<\\9s>8mW!e,>>Gdt6sfP,CGpR1
DuI7kJ\n-#2T7I0HtB0n@m%;f'qcl3%+SMb`/jc9K+JD8'?C++>RaLK<$#L9ZY?=OWIDl=de
;iPFi04ET.g'h#Ju7$:V+H>'rqr>)nPhWa:<OcM$6k>PrA^SO/ln<sROP]A=$.#'i^-`EK**%
V0BL8)/?FqSMnD#+0f^jhsFt'9Xo0:HnU&QWN24=a)CZ!i7t["]A1Oe%<_*2Mq"0!'<n'EE]Ah
7r$KmaPgprF3>!3pJoV7e[!'%7Q=,3X/I!7W`>24CuF4&!IR'QZ;]A%H<HG^^SQ8"[:6:D93)
5:'/r[oPMtg>`_):Y0S^H;RVGW9LCg]AtA$H>t)#ErWll=^%D/\,a3Sb$+:>rcVeJak>rU&B@
XtmhqaE?9u(Z$]A%:Y[TBV@[%$6raoO9B0+7&KJ&_(W8M(<IH=MDL]AG?S;/qT-,2[R"!IfjFY
c_mHN)3Y\q>O2pmp+6>Vr+mqXNR6`O-9qK5W^1Hrk;XEt2<<L]Ad]A'i'm%,2Hm8/=V*HSHg2Q
.O]Alo=)T4JVO:h-Xr96D(^j;WLal?rUV:.>l@h%Q0:80,s-oecr+ek:Wc5iH900'UF*1]A<uq
VPJ,O2X4?'QuDZ:Cr*Q!0$N%1jr[fB":W`oEo\R[!id(#8b]AVqGW"ouM"gu;ut]AdW]AL*`MOc
^uX'VAf4I#9Q@knd5Kn^fSCEc+K\X&goiSZW]A4\.L$n:;od(-$%Ze3UYNrmdXRTauDqpVgd)
<qi5\s\SX(\j+<bo`T'-ERPb/9MHLWnfjn@+kkB9MQro8h5lEogYE`L@h5[bNP=pBYYV%s3B
&([LQ@9$2"o?8m`!?T*c9f:P3%2Uq8T<6$!736#@/j'&c]A[N??]APBpDTDH_*D!5;"N%/6:FZ
7HW7ZF7boT$*^oCH>*<<&%qo_(NuBMD5>Rgi^(Y5+hm*5gLjGm+%s=F1G=pm\:kjN<,V=HQN
F+(8fno94*<1TAm*8:3sfCCWP;OIX(JShVuk=&t<m[#'YOk1bQ/hbBZi[N+[I)1VUm$aHU$`
Se_!lo<cVrKtQo?p!ZYho=Qhb"jhuWQ1)7#EEEtIPl=1OVHpf2,mf'%QV$W?f:5*Be!SH+68
c0T\]A%Fk4pUMV$',"nb4>1Uo,/!##pJ17Cj1F(!h:@=Fgo3%Xt<j<StY,EYGG5-.adn&,#Hc
Vg*n?Vnk#apQt@kg':TG*\ATtX(k\9OjEiMlata@pUYQ)b.Y&>KjGW"X7]A3</fr$V2[^X&gC
bg1/XsRSX.coZ%#J;*ls7aoHV%4P6O*:s!lq[0,?AHS($G8B19^1<.9X0t1AVhql0TMa<\74
:`X?0^X)me40[2TJt6@0'i?`[W3_Y9Rg8leUOh3h=s[DtqEG?.'pcYpifN6S<S<4K_<8)T;2
PLZ8=XjZgH[6qW'_tLF_6Z\tonlE594hEpf&+nW.Z!2;/c/umgYPhBH/O0)!%NQ3uCEJ=#76
?i:dFBge>Lb=08d_tPnI9qW`g7k"7a8]AQ>\#pndr`fqd(lLr:?su`CRJl6c+:P0,2;hao\lZ
=.$U>Airs_%(tX<'ppK86J=jCuO]A0TXp*!9SSm-Wl[r\r3PI#nK/m6B^M:7CbeeA*hpj()oE
?:A3Sk\54-B-jSbM-m[q5`(8]A;F0_\4h$PD?4d*IQF*"EVleL2BQk`$mU0r#<anag;l&Z:\T
p\n!+(6@&R1W>gsPX[c,>Hg/2GRR'FD/'"9q"=S[qnh@@`!;FBH[BoC1ao,,kPLICn!/[isq
CmpXoEk\)-9m:AM=)?ICB0Bc&We1"QB,<P_L^L3_c#Vd(hSD3h)/8JZi^bG'9n&.!)P<Nqdd
k#qhW._7d8:#T8:kIZ"t+4\HI99tHKNC"r@K5a2$<W,?'TEnq/!`J48mbT^$9VKHtD3ChA54
DE^SB*g>d'JH+uEiadXcCp^M><-APq_<1;H<0JIqqVPZu]A5`_U3X=b='A]AS04GYJ"jjplRjk
I<G@+SFl>j`;gCih*8CO+]A%j!Mu!BM\pXab,)$N1f(W/AH\0h^Sq20ZBLMI(=U3>PZWmKIWM
p203/b0A"o'M5"a0qnAh&?*[LY`^9G*`7[l0R@@eD:A_;?Z`Y9Bi]Ajo*OTPJ)EY6%lX5?cW3
]AW8=\EcLQ,dY!74=]ANYZj)(4SHjue@EQ4/SCPbBAT_!ieZoHgG.kP>G]AAu2.S=S#i`@b(fg<
r<u;K$UmMp.(L17%;,NM$7H.rRP$!MUh]AGF`pQ="6k4+_'#pDQIub[jAUq!*7;_?i&q!;mBX
kNP"L#7i)cmq&N;q\k(^D:Ff#r<%J%eZjbWK]AR!Ig50K)1gj:Sg9;KbnaG%i#6Tm^?KIKNa2
t2[Laq,Qo\XhJW<k3Cd#LW0ug>kMm1j!#Y%Q!*6G($)Pm,1<grWi`hAq^.Z1%R$Q]A=G&Y=/(
/?f$+#AQC[$EZhg>D1K^k*0P>J#f7UPI-iQT#YO2%5h)TkVAtLZEm8Fk_N3@WgZ]ASQTp^Dbu
ET4-m$8-bmdocFC\s1R$E8nWK.RS%D8`!?76Q0*pg`5.C062^C\!67LWiui)k03'S7`Te!Rj
SVM1?!pCSpu]A1F_GlZDYj1,YKm7MH(epQLBaAi$-=Qs3Vq$^/fJYW3Cm'EL8e[HR`mQlUD^A
L-H[R0-p2$M>]A&6?.sOr,YgN3I)_tb@"%egqn0'9p.dT`.Q)01[a^<Y!U@TXSnkc8apQB'3A
4'7N7@==0*!(3r0BVf3k5BF6rFQl>Z>\?5gDW-f"EiOa!Lb8ai;%Iup*lXCiBrNBi\m+Q!o.
8=?T0pdm.O<T+]Ah0I!e;TEJ`AtTZuTB<O8/SLkF:3>9&=W&."k<sE8hr9_aNmQ['>QD6n;(5
SW4@*6$3`ZRl09XI39L#%PX^>%N$\9WoYF*g$[n7=WK(<SM`@>.Ck<Z_Y[XM!50g%Es>o!*&
b_$_IJ!rq\!$-`g:0i2*1J=9LcI-(nb0j[;YuTS4EGE+D85p&mj;3g>\/#'!!m#Skpo9J=tn
u>^kGHBbtslophK#\ICpX7VIjYj%OD+]Ag;)g@tY^3#8A"(8&@WIV^aY]A6JJ;\s'aJ`#(T[p4
DU[4k;HjT3BnpYA%/uB39s-:\80HFGg^;f4QJY0b-2_h^`bXrh`);FS%aB]A+S*A?T/P0ON]A6
QqcBj1M]AVE\ZeNrI&!0ho5aKbo4,D_I#cD+Zjo?E:D?>TKb!X<'(CY.NCg8kr=m^M)b_Y#g*
A/N.m8;5fQ$D;(X"7E\L0gq^L>aHtK]AFYg"49P*N#G#+s'QV_5aEQ`0j-Ut$OdVHh(m#s\Zq
4OlbH'ORfMnITs'cFfc,PPZdf(/J:D6eM_fA1X/'@+d6mb;lbmPNE#3%-$RF2FaqqIj+@5c&
e.D.MOedQkuVe<lq56*K'/>uRelq*aNONtL']AjF$[N$QMR7<-^j-ec:[B-tN$KB5C$%'p>Hs
-8?`6W!*@PBCBV@aQnOKa%i):?KA1%qpCSLeo&%Mm?Ok7!slVdPQQB-,#FQ`+MD]A,K.mU"oo
f`'l>LQL=#ZV'"T*_47R\*1*^ESq*jH!DM"CMWJD$:8f'#&-4$q%']AU"\NR*Bk:M/i?[W([U
/H5tc$KHt,(_f.Md/"ffP6d%+OLY1`_K1sZYb1]AmZlanT2t:=N8%<W*\Y@AB&@&._Oq9U"lk
O%ig0QfT?psMM&3G2Oi@#SseNept-=o[l=5'\,W5,sn(0BjNBoj(PXclV=Ic5A97U8tIX6qm
q]A.$Xj5#eD.j9XIY\DHL)!7W5k-.9Ya]A"@(ZZs9[AJ6]A'tb+B`\ok'=,2Ya8TD-',%3j]A_)P
CXmWmhor!/K]A=NXhp9cKm<F3(",L9=Q#(^**5@fJSR>=,!Zq`.U4#7c0K!#`"eiE9MHja37N
qDjY5(ZB/q<.=@A9\1BC">dqrXC*tsq^^d1DtiK-E6Za!!ndkpW%TC^.ZRA\t:GcaC(!^CLk
U%6q)3?T]A>`XJ_&C27((`Dd(+mds!I!V4>c,ZI^;h[Z(Km3[UD&%7!.rn)f7TW<%'V23XC,k
R]Ar(OaD6l,IYM5KqD=p:s&K?O<PaS2pfZdi$[H%J9jY(gq:o#tN.DHAsXU?Sh6XhSrc.(e'1
hBR*+Pi[!65%4tP&GHc"5r@)sc)k>mn`oZ^S]Arm1]Ae8hEC\.KII9Gc^,J^=385\<!u=G2MM)
1rWM"!AI!(!$s0DYh4'9SS!\>_YDZ"=Gh1RrBI(H,H$oH/qLD6?L7J5G7UJm13@0Xg0X$8@8
X3+L9gXKS<&=NVF0KL<Ya3^&<iUj042Rn'5R$_9ED1V7uq.]A>Gpl@K()iUO5t;%di_g<hYKk
)2DBt_WNJL1lFdfPrt,F!)sE4<")dSa?/kr#fs6Kd%J1o<ruH>H);p:0hP]A%*3/)J>o&Ge5Y
/9>LG*I\<Y\@5\5(,:Ya78n,SO%gpP>*D:`4F5q0p1;XHYAOmC,aV>5K-2V=M(9W/M-[8*Ff
V,gEq4!,>UCLVlrT5\#:SfA\d7Ze%&?4uS">;B$QkJea2Gl52F80HjOg^hjNI8$%SY!SA^0A
oH+'/j`KJY:[NRC=6-8>Z(jQa@?FBmSP:nL?:q`*e6t\_EAGh(80*nV-]A/FilU.OUqUbhTt.
Q<ZDb(-S0;?nIf_C1fg*OuNkNpj8UK;>.0rmFIj`<68j0$`Hc9oCLi:J4MBQTa6%+u^/lM,E
Wa*q`&nOIMqKTM\V_YYV?aqE_p*5h=8\.\e0L^)Ja^M#;<@%Z,]A9UQ]A6u/fiP\2$*=`H5q+G
Gg.s-HS'fo54cB^qa&XP#,C?7=H@d%M:;3jqX.)C'aiGFB,9:,G?;5VK+#.k`3BPLDot"o%9
rS%T=N<rYgc%W;C`2@:?FXbfH7s2_&2PgoS=i?Y`9eC.kZ9<P34d>3oIoDp6^-+`hMBj9^I&
@tK2ZM`qlIBcW%!kemWW`\%(d]AYY"LWa&qVh+GJGUcra.pRlLE1-1SWSg+GOfR3Yo;<MA&mL
?p;NrJSGllM*[u!^B)4qcLl!FNQJOlOr$p^X)V$tnt_*('**MHI0Gt11Nnr/r4*s7?K@!Lm2
H4j>'!HT^90I$;dhjoAa0I`>Y.)@qQZu1]AdmIfXg"e=EY0)Z+j+Mu*!+,Jq?(&\Q-HM*u59Z
t%)o'\kBLoRT^Qgmq)^HLlBd1Y;kUs_q2B4SX$1O4YZ$['+VjTH`;N/ARO\'T-SSt7Z)mIA"
TZUm41BGRo%g@*n)(d7=nJ,4@:CgMVFYJ]AV\i,JAgp#!Y20BskZLk01i@53ba6]AFI-2Q!"a6
<REp@B]A==o,SAIG,1e*'^o2@@hJ%M3D:mU7Z\%?;k.P_'eqbpaDO9H8h%7j<[nZ6:oW&,Cj-
pmA1;MUW(cq>Ln.!diA6.Hp:/:h),X]Aec[1u05H#+_rMO85HB[b`_Yh<-p!a'Y$N&0mrN8Cr
ltF>mU7cKQRUYI\24Z(lVSRPJ5TF7acunj\cH2^c8RZan)IieWYZ*$-E*rNVTNE@>.!'&72X
-L(`qPFN9B?'CgONYIO"-8+U<_"S-/g5hV+ct\M$t1&aKnhXpFq@<+dL-u0%$pN3/SJlT=E\
(_Alj(1ont%0\!+Fl4M5]A)!^KdGj&Is`gMoB%4s/n'3.)AI.(Tr91%dJ+(f8n"fPblrFXoA-
(cof]A&-J<_Zoj6JQH*A[10:[cYuKB<Drb!42p8\7;.DuN?Co)660e(U7eP0L]A&rk#Z5jR>$/
]ApJ$KHZK4UQ=/Es%SgdE=N%V0PuXTBfe:rNp)h*oMl(`EcB9l5#Q,dR5r?oU7fK.8,Fs3<\U
.IK9(m2TH?NKPQ?e.$mpLorI)mY'cd5aF2?p_%hT,ru+!o:Be[A?5uO$-S&8;+^%@3pK'nOM
%9\*,Imbjj:Y_Ui*^*Y)&ufaPpu-o=Ob.r!hocs*&u5No$O;Oq1!`N7R`R-BXC(60Ra'3X4$
o9*>f+6e+pJFdi<XB/)c!/o5nYF-')82LZROaTsoJap088BFKA1jX$"peGh4l.es5n,Ai:E5
KorP5*QS*7`IZ%Ls:F;()=Qb&$'<*q++F(`UFlt)/rWtDM3mS9kV=+ORK.?#i#\)AQo4;]AD,
`Gn,VP:?l#fpB/JO&n,2ons5M$":W&p#bqq`4Ij-aMer0lY=geVq3WWXg!b>1A':`08+"AMK
q8aPe>^FdkV=L([g5,&,ScHhEqcfa,R`R^#*trcYZ.oL`A?&LP2*XHVW/IiuC"*[K]AtLV6%:
!W.",<Xs@tS60q9*p9X7@A]A%II\]ALSR]A5B[61FGL0,oA<jGkSTQ18fO[@F43e;]A-QlB.b"e>
iB]A:l@!E`j]AE[G$"KumFp!`D#"g%toO`"d-Q^-DV4LY\6jNkSKP(e?jfH0tgZ>!L)?^!HVA.
b::f$bkrEJ+qUTKH<GB8F:X:U@?"B#bt7R''Ip*m_ubgjXjM\T<\]AWO'/1XjNU/G4ECH%,]A"
&9YN+_=ii`X#o6)qBn`jYe'XeqE@N!%e!a"TSdi7\0b#`'TJ4?<PjslTZp.eoPE>IS/\uKk1
jARAS+c:>R'sc^=FHs.<6M(a=7#?;$*6!$H>6IkW.t2VL*X?G..\HAiSJLjp)p<PMASi1V=A
bZ0_dkFj@*hQfY3g%ZeU%^t#?<UbU^O?=fkmhgTcsI^'@ACJ&=/Q1^VVKI_pY?io?okt<G&s
Fh]ABK]A"[Vu&,ounqK6?,5QTXT,@S'l'i2Xf?=,KH]A!P[>>Ib.0J_7-b4]A%8J91&RJ>'e:SA:
9mM_m3rDm03lZfWd<-M/)Rko5u.Dm:;UZ:D<RRt$^-OESt&uG@T@JbPjI:ObLV')r&#qarr<
~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="142"/>
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
<BoundsAttr x="0" y="24" width="375" height="159"/>
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
<![CDATA[722880,722880,722880,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3456000,2743200,2743200,2743200,720000,720000,720000,2160000,2160000,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="9" rs="3" s="0">
<O>
<![CDATA[航班保障趋势表]]></O>
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
<FRFont name="微软雅黑" style="1" size="160" foreground="-15386770"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9FpA;eOZn``h,sA\*^k-.@n%8S)UOQ'!A\C)nh0A-Uc6KdF-A;[4TuBFH/sD/Ej]Af[=43Pp
NgVBu_N"e,Tf3QE#oM;5cqm,Z4[E!sr+$Ec\]AC!UFE^I_!@HbKT,kr-leXpRZ`go/u1rkIg?
RInj**risS+"U,'h?hF21M*XG&M*XG&hK\*ipV3f^2T64AP\4:og8f.0.HtP0S[#qTpTADuR
$C0B]AjE\Zip*ZQLGgTB9GmHZ]A(o8unTi-A^>julrhW`gb/Gl$%TYgiFm1Eq++1;P1$@p"Vg"
a>/%bd#p=ia;7(LS]A7(E5W`0Y-mrK8!jdcY3e7*oUGE_nWD$/Y'MS6ma1E!\@CEU#t,Ybu2D
ENWh82``E=UT<Kce_\OGqJ?ZH=lmE;g&Y<iA.!9j(WH/^]AkC+U)BG@gcR[gQ?^k4j/tI%[-[
#jk=*4\mO5t0l^DLg<B@lIpBQOtG_R`S(GQ$@,[N4i9PUMJm^AsXgh*"F-nYKgbIA]AThV[L#
;pT3[JNmMYr)VgdpR^=EY<I9iXBFE_S&.Q9,Mg[GI(G).L?'KVkYV"*WNk$A"$CJOtO]AS;c#
ftV,><Xr%h=gcFXL)R/Hh,N"D2jK+A+rt[d$kfKot3SFCmR3;,#SQQ4hka8oreul9Z+Fjgg*
n'FZ=uOXiYS\`;"Z:e!2hsZ%4COVt\3^o^a#F9VGeq@>C&MeR)4r4&rpG<Rk6;r+q5*0fs8a
AF$jf*iY-i+^'1,123=TMAD"$K@//i[B)<ui/8>Thgce+b_Tk*\(Ah>>(9LG&g,1=P<9?D,c
%s-lLMa&.B@WnEQf&!fh4qqYL(bkH8IH62*9'E*^[p@=I0C*X"JReQsJ8>nu%^d.B6EOdrJW
1Cq\T3OId?X-T^?f<%Q9uH@n5D:@F6tm(H#9IU,"A[I1u+5L,VhT\?=#NRt@*/`066`Z9es6
?6`F'"==JXqu*DkGV!PY-g.Ak(jKteeP;IJGcEa<MEed/QjlXF4kp1%'$%QD-1m&lQj5XBmc
@-07m;iA?etFQ(FdNVAKL=UqEPla44dN_c,iR*f_Ro\YD9G.'RHUbBZ+nfeWF2F\67L]AD2-k
_E!2f\a%2XouAMr/QmHGFosf^IC]A?HTD'*,=.L!\klRPr-@r0nc"4'Q]A<uY0@De-8qSVEa!3
1n%\ZsO=4*I['^H$Z=]A!UN=lA-eMr9lPWOW%9+\0pt_^Ho'1*:IurALZotNNl_?3KRh@<Jrh
N#0GjLrOI95aL+UZeIJ\I`M@19+o6kWD-57:Y\$XngJj;UHP5eOWc+Eo$H"Rp3.'I#mZX2Q%
N`5,)EN0'm.$:@2nIV(RZI$9A@GJArlRM_hK56pg:A:$,O7$p>`ET`k.@)$h=042?)e]A(!J)
e_Tf=%;7]AIY<J6]A_b4R9b[KIspshJehRm9P^rM9">TN"iB(/)Kd$d&OUd4YSCF8AA+JO0PJ_
@N@\1">sL4Pq&!Z[Ul`p%Ep^g)2mN(c=ljjF3`+;PgJ0=K$u1dbH8l9QGfUG(Tj*cY#l:>Di
G'khHtF@P_'E/'lDBHYg9oF:",En6;f7L3i^FtFupq$j*p?h9@q,+i]AE6d,-fFZUGn>8nnB,
FX^lEqD!=/=[Hm*_TR=Lns'3c4X;>4s*LehQ2AVAqj1c4YXQU9Hq^25tiF]A7Kd]A:>,HhY:u6
KBhpBJ.jh8!g=4rmKJVedHQ00fH&ioL.#4G=BN>:eMC4khMBd=qDCTV<f/D^($8pbIelT/a1
^.G=g&-HVShUbHHPomh?Or^F(*/@[<u'h*GL/(/Yf@=<`t$B[A3Yg%6e=E9nomU?215a8$5L
>u0(s:7m$Jmk"j(Jq>haI]A_njRP?h)@ZD60#JIn56K57.YC2FVG-ACOH&971G5\g1%]A0[&<m
sq_5PB?KWH>i*51toM7)>r87g8QkoDVi/nQ/"j0+kLYHsQDNOfaJ%_6_^N$(WV!dbU<%PS/L
]AR#[TX.BThZR*l&*ZY+*04$(]AuO1d8lMbK5*`s`6*MHK#%+GiZCb%1!Ni=f=Z[5_9+Ujn,!'
KHW&.`ak?Gs#/,'5F@n:KKS#-3[iBCLLPAFVK7jE)j$,Y?-o/V-hH5A%hQ&7?2IJ_%JbAhf=
%dnp*bainus5^']A#61RYn)"2-K_bM=*DHOTA(_U+QPks18/U;`q_A&>FkIc0S;/;&oHN_ja&
<_VJD%=ntjBM2RA[81)0SQ^X+CLJV]AN\\Ia.!`1Rat)DOQIn<m$>^HF0\H^,@DjV/BBOZ?9X
;#Cc3XdjOfR&_+jQ;U`Inod5J5ISp'J@aObl*6QKEuC;qO26_?,hS@KJ@8'j!HTHTfR-H]AAh
9IO.4\iMiQ'@UU'O#$j3082tHJ_dDbZ(LjeWc>Y?uXKKJ3cBT,)+hAScc4l]A%1UUhr9d;sF0
S?N%[,a%6`6-p!MDir9e'"oX^LFU94W?[d0jhe$UYMiG.K?A35SIsu:uo;#S+9p,p:DMPp,/
K'2QE9j$RRt6U+\\_92*,:+LD'(&s9b>_BM=f4GY;!7A:*o%e)=@LK6$#PF`DjTer;ZD,A@M
YZX:Q6jYU&HHckQl`rs9olWbQ[<nH-B^ocVb&AEb]A3/9o=oE`)ZbX-oHQm.Xgi+H3<:41ZQ.
s,<B4Ha7'sV!V>P8=R?#Xpu8plA@1g>=eq!6I9WU'6,L9ZF9E_^NVi2BAWW%7*!>!eW@$*''
hN`"!BC6inc5,h4l9Ipb,`qV^$0[\W#n-AJ4:$T"5C;/20.$^WH(-eo*%!L=c1DE]AY7eq1C>
!1,R/Y<DRBEn!#+Jl=Z5#r!C,-KDt2qV(uI14YSPW=tLDJs=j#J%R-Y"3@C1M_nLqE6i.1KW
C>.ZfJ&Mk<L3paNo;b0D"?_;>g)jErAMUnn%HGu:(tE>Xe/=bR%U]A^Im$>M>=-QIb2Wk8Yd7
*Rbk>+j/kF9?5a]AO)CXG[.@+HF`h=GE"[QI-BY?\jUJ&>hlTCYJYTSoa/`(8AmY5jP)khHAU
N-E4@*@i(Q$g6)E4DW4o34@gk<>D8jhh4)3dkB/=C*#h9dY#2'ZnYM]Ab_f$q8lfC]AN=oW.Zf
o!S;j3+AGXV3"srXAbe\3[),FVBqhWg?/3F;n'EZBlLIWAZJ:m\YZNQ<2DL6_+%l-:eanVnP
3WZ[]AI%(u3G`QNZ:DF.7b7(*o'6o:r+tFkIOo"c0N$R+br=>$L9n6`bgpQPlUTM`T(A3g8Gf
n:B(2sW:L]A%uE+fbLD972?mS&tJ=08CAX`3k*Js1S,,@PH?Q8'%rSI4oQ"g#'r9`6_+Y<[K*
hnl?l>Y;ARH)JXt'eg2f>cp-5O(I2[F""??F-a9o+XN7jKOjtkU4RE\>#;JYo]AV"$r+pZf[.
aob<Y?`5g`up97Q?f/-q;2r/BL`pFW"2&[l0@&WY&85@A<F>n=QcX7f?,7p+`.1'C&V^&k\0
YSKi@lD>C[fWUP^or-.pgi+gX75tnN6>V=P!B(f"=Rn-hlAQNjDROp]A3hH&%A4.qK79Q8G#^
p4o!k,IYl`0R`PiC&IZ3dcmdTWA5PqTH-\8T#;:/(8Zb[;L0g2$1puLiH,SZ`m*jl>5@f;8S
Z'Teo'LS?m<1RO^2A,d4P4Mm/Af1ZbAYV=!fLAPWZ?IH]AJQ[c#:V6<<7>ZQ'`=5>_V4DG5aW
jD*]Af!I5+k>UPpa[j>5O0"C2t[E8fTFcn[4dTL1_Q<4l&926jc&*YNb.u+89.KqR1U2[D*3\
O3%Z\7XH^al<e7@P9#/ilJfr,TsQ%e'$)Yro`Onp/'V>u-fCR_-&CAjdCb(6Y`6a]A&FDerWO
HZfA?9[,94;g,iM=<V"JdEiK:;[(K?hr%Udt]AVS?H"=hA_Gj]A50dFt#3ilbf8)GNt+H^'14_
0Tma0j%fXNFLTS$K1-m'nQ5gDg[I;ZNOd;fbP=TZq3?./Ea>2h0!#4M52GO"aqiBV=W]A,o;.
J)LR#LV\sm3\0?]A)jfP=8Egjrl3\=:Rtfb6;2Z\V;tX3fReSFs!+X6F0_f`$7jlAJ*:,YK_*
f8(4Cfhq,n8&tpi$@CTQQ6oP-FiBsm7`-%pKbJcRnC1f`.Ii]AT$;-J:L6T!X`/VqM^ffm)8G
$^2)ql5[ORkJfC*W?LZ#@$RE7,a@C#A@)q7=*Q1npZDBQp#r`&YTW6Ye_B79GQ_H*]A0E/\6;
M%;#F<oLu4\3X+dCMKrC>C4dH,dW`B,p#(dJU7g3lLNEdg0,,0=b-u&h8Y<>"L\iAR_hl3M0
%:)u$]A=p'*(FJaThqk]A78=MWgG\19c_B1[q]A.:QYq%([T%jUF8e0W"MbNG?=85phA9g/>/^O
9.PYXKs614%9B'^`,,2$<0Z;ekJ[aX0[s"$YqMidM-dVoeD-&Ja-8P#h2^ea5@O"ciI5=e+S
e-;B+f<B+iM0$qpS6IB>7&]AEFXqY#beWLp?H4j>O@laU.FD"-^$hD=n!N#+qMF14t#E($5cU
E.bGL@WQiEMdSrB9(PV&QtaLfqAl$_0%gHc>gO,eG*RQ8V:EqCp1r?_).tJLku6>BqE<?Km.
-&9Akq=f;uAaO8@W<Ql4uk>PooS+h0Q)M%m7.u^Ff$++Y1)FMG(^SA30`KA^S7>D5X7FXe1h
*D,kQ/MMprJ]A75BNj[gBkTt/0)9kmhV]A27'^bOR;iVfm3cq.mG\)&"djLA"&psF2"Dso.jK0
`53Hf1.6]AsO/,0k9@dEudC0(n(Km87NNr:`S;_Ab5,+F(Lp<s7nC@(ZN9rI_^DGa,7s86,:.
J"9A)TRtBIgU_i(=doCSNiarbTC^G;5;&<(>l9g$s4u16@Z-)02NG7gW>d(efe[_SW=#MZEu
:qSdN(fng/$C0U8:FdT2AQ!>QmpbLP1_LK^HIhKJ,+lZf9.^1n4j(MfS*J+U&L8bGLLkFZ$Q
)'MKApHU#!m^IEQN6Ms\Ph%s=?+P2faKoBt[4sd;jdXldaOtll>"?i?h`Af1iK8(*ZbHYgoC
Salq!aFfa`0:(EeTF[AMBSgJ&NQ<:P\BlC'h*<>:l_+Zak4neg:e6Xo%3_Hjik-d'D;lPp9p
r7Ec!)L"LtPXQADC*(LWV\)E04AW;jr:<a09@)E/ZX*W>$=H'JV[([Ku7]A=E6'/JCJ,<3]A4a
Wa`$_jH;.oU(#o=*V5QRGAmFX<i&`!:"\GIW()2P`Ut6!ft[.Yf&MA"MaLe!3q>!B4_E-Te,
=hof1IuMj]A7?ThE5F0,<A/,XBB_[Q2Ys\$5.UKVnOSH\ijgdCKtHb!.V307u*BE$^S$%>)k=
ll.drE>o@.HRuAoF6_RRJZG8(L-H.6+[N/SS>=hi]Aa@0T\aX>_d^LU*!]A'imfj?,*-M\2S)m
-7iba@a!>6N.%&QX&W4g6tbJ^cBXoFU*!Y`4bV]AeO:#Mc?7.1ad$3XTU*4hFH0j[`Z2Np,Qm
Fhg6`T"M[d(I4k:(39ij?Z(@6:S82_qrnjAG64:R4FV"RsS:lsmKcCZ`qoBO@32Wpk)Kj`JX
oPb>Z0HClj=&f@8YLN@pF,!)S,'?"sUc$Po;=8+[;L@5GkUFa`a2Qi*=Qs"6*`]AJ,GMmdXh7
'p`"VTbS*%`L10TAHDS.1KMVUmhD0A4T`-q1lqR^[j@Xf96\"si=KEN%?(]A8Z#>juM>V><ek
pa?GHk8ml/Tp2XQIm!C1iM'C-UU>5PU\]AC8iDbq0N5NXeJeF?2&A&kS&K-.dJ7B;%bPui*#D
0`466<plY+`c,2K5u9YB.EtM0PfhmCLa/Pi#cNaD:o5XgT,41"B]A#%N^pLE&n>0KncqDa6C:
]Ae6lhX.d(kI-"6Z%*ZQpCGOoZsJ5X?tM0#fFn!`gd@,X;eX4/LqZ)+lq=E4\4B3<Z"T@]A[ne
N2a9n+EZ%/n2/tn;e?=kR0<SX/Ka"TkpUokjK1EHZ.u&Vm6rHYcj@PMY,hiCW=3ZARp0VWKY
;tgKl(Z<gp2kdb&;"GU@.fi:(K4!6m84!`L0dq'c>^AQnhL&JG"*n:sS<+j@$HmCE6FH.<ti
n]A;kRFf(m8(?-6%Fe/-:?O!->7^g6pWd`R_[T_(p&Pu+i7@34<W=[Z*eV?3urWq@mDDA`W@(
`SI$fW.R0m]A&%lA-@4:QH&Nl'`a<D%-o?G\4I1N@SS5e!D/UmeMr`>g_m@o_;XFB!kf4k(g*
ZaQM&t=q(l4ORk(RR7Dm7U"p.f0NABl90:]A,.SVg,h*Qo&D?cG!.Bk'hjOAs/0FPB$SlOf%(
Y#ehk'.i?`B!F:E`b=Uj`b;!3>eal0[l`_lqV1(sIVRBUmp96;56lXTY?)`"fb5@RT8rKo3p
4i\$N!me_88CrWF'[1nnofcoQi\]AkLZ+(62=3g47<`PS:!hm5!r>S9H*>0pFCN@nm+1)TV#T
`0AqlJ1]A[2YGaq&O%OV`SmN+U$B/b-/Y:6&U*;<rl7qod>E(!q.4?mY$gGH7/a+@Y.m($n'X
LfY\?@VDRPntW?ZIni.>e:5"DuJ;4*XS2%'^k]AXm_VZ7&`k\EW`3FWY[o3k(9_B=]AP6\c%_"
a\^[*$^L1I0l7b8&"qL3>,He^7&J;5JsibDA4$t*RUf>%mF)s3(P<IWLUG3'a.$#-dt0sM7*
=lFA<Vs,a8Vb4b0G9="d-6?q-e%J0AZQ!rj4ubObLgF`Ge4<heZSQ'ABC>C]A_0k:PT$NrJCg
34WQb!'(<I#VV>i"EBT,J\QA6nM((-a/^(k5>j.YD)IHkX&=Zp6Wo+BRtLm*QkmDA(eI8-:$
Lc0X[QEcQ&DDfAC6:`Pf_fk6uLGZF.H7sBXIlqij<kN#V"_(_J=APQbOI8O+^b`>omq8H!ZS
`DXCjja*MNfl;+g1E6,hjA*Ah;EDqS;V<1^J@7$I$mn-OO*5l\FgG[B/%c@SY$.5G5n8oC3+
tnHmXr!Wa1W^O-0Ztp016h4NG%u0jpj>*N#[D]A]Ai^*dC+d[#NmPI^!%9fbOn%)2jN\t?@9BT
LVTLs[8dZhjuT59,t[D-g[<M#iC(7mg]A7#;j`Ht*DB6=2G]AQ'ZVF"Wn0O@?FiZ+MugHDZ.G]A
o_k.`A[DY^&??]A_@)rf1C2gTA4R^c&5[jC<jlM9I("E^&d9[M1^(B"\PMQ1E?*/A8i]A=dNa=
\[/U[fhOR]A7H%?d#l;$n1akfheFS!1@e:d#?&*D8$4:a%O]A^h`nr%f=uf?q0D]AIbgs]A9@3%4
A_9torYONFL;7Gq<l7\<W<jbDuQ]A(qG2$Jk\X/4Y$YRF5A'[6eKO+Fi;sT4]ACEBAr3FtEf&F
9u13P<)-da<%`J$d-LPG[UbRZ`.Ti)uZ-TAbC;C/Q]AZh0RCpcnO2D@NRL/_3Z-*'5=+6oU.V
*J#<I9Ij=;!`)i,Kh;6Ur!]AaoUjrTn$$\R*0S'F`U_l]A&*la.!,eJP,WsP[gr?j4)lJ*pb\n
12a(qS6_o8dZOApBc+G;Y`D#?t1ih<5hqDQVo*[g$00IH=iD'o,o7[No%j_:!+HpDagnPT=,
IBi)P7Ue`n[kCHh(_JBh%UE,(]AbJT`CL0+c\gmT_gE3P_\f<6?KNJnYY&P:5[h=>+<Apl]AN)
0CCCLcTh&P5B,D_BJKp9fVjdIZ+MleQm)2_7[3skoV5\%2qEMb/@5am2,&H)##oFSEo3CXfU
ALWf:_@AOqph0?1tDY(J1$opH>D*lYOPcT-<&m:PLmd(?.P<lG$Em4rL@@*$AH6u7gLPe$=J
:tM7b8DE(#9[dq)R-\r>Rk>^tZ%gcVfGh\TBn!"&WLt``H"4h'19O'fQQcDm*ga`$]AQHW@;u
_MD[j"W.'%lt\h@OP:a-%-4g@\B(%pLPppa%@1p\B["#DV(4Cm?O)aGTnO#+.;up'@7AE?W$
53$Ebp^eMTJ&[8VB:J^V3ltUNGp5CB!+=QCPiJ=h3AneM6Zu]A%*@i5AN/;ktol>F5TXL\"5m
FOs!@/l1:^m-60&3AaP[Y&V"MHjJa91[/sogP;;)1"PNQM-Chm1G6#_88&\@,46\0RU]A_0TX
G3i%ofQ!FR&lqFO-43eAaHs+g7fI,`6n_qL4Kg%qUN-Jg(Y1X<tpdSI?d/hsZ-qS9tQ20]AE2
WDUuihH-$>2EWV\F!oMNF8P%Z)0f+s)4[peWXtd1Lt^#e1+lN+Co62a]Af@?]ApXiJjWjD\ri+
dW[.9DR\`-r.3oPE>u(4D\gacXsBq##(6I:3GB.eipX,7H"_hY\O70>1r_O]AHE3*OmcPc[Vc
n23\m'5Wpa1f1]AK2Y1,@2"q!cC0QGe-*CU.mY"kT>"$TR&iNi-b52W="F(0+Ldsklk3*^^>k
:I>V(TW7Idi1iC",LK'8dYqM\IT2P<+baZkclInjP>KOh.l#>4mP\t<TQm(3l\KcmZ-p`rK$
c!(?[ieo.!0q`MIVnng)PpRIu+eg**/m='NN(9F5s!?q)EhKUrb?eCOd+Dd5>[:!S4i8+3pW
R2L78dFBKh\>flm,]AHLi?p\0$m$p(P/[5QVL6i]A]ADuOGGbl?2Q*`(hb^Z!;p70S"[\Ls@DDk
6*m%=OOt[f5,cp_aND@IR!Lrb`g&;Wr1HifjkN`VI$,\<9q-?U+\iETgMq:mZi8i=WA]A"C0s
r%n<7mJq\GalH>OY*KT0(TmJA!8$pB`D^s!:A8mHFX2jHFAD95Ebn8(s!nS,3Pe.U?pljC0N
QL#rL9of;PfmC'J4KDae)F[,??'ht3s\nM2oat<!JN',J5-GoWaTV,DRrfmUtEOgGR&WF[i]A
ei2qgP.6H@dfHa1ctWhP<^FV'9!D#[uWG56X!KG`.^dTW?iR(P!O0H"C#'Y#N1E+.6D7:B-4
M/lq<poi&+fF!LhLo6Ag:ZDC`Ve<q'L*nX[`kG2J"QkDQ(G-fKQY;+n^AX_Ck0U9ugir.hDY
;*DWGr8I$$0#:0/R0ei3k<79^>L:/s-cB7B0k:09;I=i;faIRlc(p.jL3JJFkBTpYu-XhAKc
Yc'&o;'>EsH`O6pb/g#ai__BB$L,?HRmlFk<bc(D(]AGf6?&YPTLB:lsa0Crc<>Jii";-+(<l
T$]A<E2#6In@jJfI&Sa/&l2nBAg!!H\L<j1>N,Eo!J,Uu`t_R7bdBZd,:*lmCYuBR$CK:]Am!9
Q%=RGFQs-Q(k^9[.@Y$jDD/Yi4L,#'#='iP5[;t75I>$`mXp`^eGEZZ1IQNR3M50nFF=S-UT
Ie'XKH3k%1%[YIY)q4X7iqBQ(TUhRr8j9/rPT8":!Xnt$!dt6jnC%sFmo7"GLrKCs]A8U$P(7
Y5R[_X@_SVNuu*#"U8Vk0(PaMk>@0#Y#d&Pcj;aD^PnUhaD1L/36UZ$/$;-Zj@p$9qO`T-W`
W,E2<(roL>_MbYo"MaO'tB2rtEfDNrrb_nZ7W4HH;IH%_Q6MSOKgRXTm"[^#I!+n3?`X_mEQ
t,#qXi2<VdQ93$B^64k5T0in?AEF0T]A;!Nd]A?W9ku$)WRa>#/<RCD^#43T$brd'`BeNH.&rL
2S/F9kkXp&MfBh9E@AsBeM$1'AdYO]A?WSKLcT(+^H17G\%&\-(uR_*C%2]Ap_WLU=U9rO&$<V
AF$nbc8ukT:`"iBN7tkURZ7_P;eL\@7_7+[!e>5NUna[hl;K6$_n/m/5rZP#%?&N:i[m)$]A4
I1T$&[4ekiMK6>$7nmgNNq$ja3PXGP$Ng8;c;MS[Gs!+tpS$]AVT=*i<!o]A*0te,UD4Q_hUE'
i+ZY/ZGluf^3Vnig=1mP8O$ULrLMN$S]A=^QPI+i,e.FLC(;gQ-.Rk.6W&0[J-,WSX!%IPq^T
&9me%bn,D2"X$FiOd1]A=Pf3:*XCr[^r(`jF['6Ilua2;Ve<mTU+i,]Al9eK^!3\<r!=*^@.a%
?HR.`OQDD`Nm7#"qSI:;C]AaQ5kCkKfcD"H$bTd'DeF9HK'Amihi'&;&)cS>0$HF.%Y>i%N00
`Uk]A3p2eOr1RLgR+X4$'g^.A@!AA%SNEEt\+H-0:*=&<_C@sCIEo5gL3G!6S$^qB/#e7tEE'
uo:/Y7o/8A%_fnNG8h-!qQ3MHG3S\R$Vu?PRp#WDH1lRJRqMBn;e+"5%l:U"HQJ$>iq=GE]Ak
LL_Npu:hNZ1@U)2%&L^Weic',n%A!Mj?qgHK7RL_ZR_+u37rj`a]ANSEfR:Zm<9!.Y\mB'3%^
KaA9*K^GQQR*Yf6Y;A^Ko@"H%HF_h_Bb$Bg>s.3b(Til)@f`K5NjqOB=;R`$[bk1OG!ho[C^
r#rqgXY2D/r\abKUf1McOOG]AZhkOkLjZ?,c22J_T]AC>#/1a,8d"WmI=:7lSVaq_M;7k,^-CS
`@%iI,iXWriEJ-Jd4F<eAsIC.6h28t`<_sk+*kLlDq%,<JQ/MY0Fk`$LD7Fkb*_TLB*1bKIq
=jPUR(h>>hPT!8"2`^';i<lN;sRoUKYmModGh2i3T27gqg<I`<&0%3f\D*l&(m(ELH$Oi`V:
j<I@Pj.a]AFM>UfYfacbWb4`_LWR6YO40uk@<.uPR*&@`k*qj%*_Ofr+]AXp4L&g=?YnbB^CQR
QJ9.%65)>0nm[ST9fYtXlo_:(:e6Q7Wn-A#M>k(o0nM^aUp;"!E/rJ,'&Q6cGWS.!E)*dNd^
O\*`]AhsCbP_g"mpoq5ZZqnT2Dp1]AA1BjKYUIN!G]A/Y=ZhT$99otM@Qo_RCjn2IFeVR.@Km<V
?\cUKmR(^+7H;:QHq&.=<e`UDqO.3L_'UkWZC^-p^sD%>XT'(j>?Z!\PL*T!2?E8/(]A"S7-?
,+8XiCK5Q*'FLk*(:IcXU,j%_,tt-%S./KP<DL0\s98,AL-XkBDL/`aq8b'n<<Si[YgnjaXa
"U_PMZ5VY7*AU,Q0=95r(-9U*fEb[]AT/P!W'GdK^FS9/;O7*(0:)DNu1L"DeYV"pll8]A?(P5
m0PD"7DJ!*OsuQrS9&%]A:3J69YuS"cmeOLLAR-ml^e*GrO"kFg/Sp:W]A\tA*foloiVj%8<1I
u9L$E%@rdR6TWG:j.'=E(Xi28$f#7S>*q7nU,,CIT3S<GJ0oM<;e7Y3'0\GNYCN_fuagDjk[
7@4ofad5e'W#O!Y]A%<ngD86Wq-uc0"Sc1MR<+cE:eHaIQCZ%L%_<Ja&--o8=LK'(YK;VF:W>
QYb=;X&P22oN=&/T=0Zs=pgQ&)UShTaU%WtR);caOfh<I;rl8<m4[B4C(4n?MEO"QS>G@mA#
RFcdZWoD9Y*LVF_#0?Y!`\LRN&$GP2#,XsR)('"pI"_n/P5T&,.91&e5"VZV9=o:)u/9r+;n
8T=\S]A8nN6*4T[.(9iWnbn2lXa<-]AIF&5i?Gk*u&_pR6:G2,i>t'G@0iUdOIfWW,b$^C-K%R
oTZSn&riR4bW"'-&giOb'mia&SQQ/`M:*a^o11YBgQoD565j%,#hT)U*_-j.cRWf)U/$kC=K
Ttqh_*<%T74;^uSDC^eF,\'^p`\gP?GredGA'Po8`F[34d9cP=T4kn'eNUsC5G"TZ?PUo&ir
Ms%$tC*pGsscVF]A./@5i!G_P@VVsbIa6^r7'e:'*WN0kLj>M^W;#89#HLQp?+)s!HGE@>Kh+
A7W's.#De"2^?Y^`1Z-AqW??ekjaHIk"W[B<`c;5%h(h_S6_D0EgB>eH?)*G>/0OQ3h'W4@U
0f"`6)J(*Q-$YHiR#*+kn9fi<#Y`uZM6_r<,f&00FWGgHiU`a_[]A;.hTm3[h_qm?pOg&+jn*
oea5:0C>*Y`Pkl6P,8Ibu8;AGFuJL0qK/I?M%T>bGqW3APDJ4i#"rK5W<=1\<$4>Pb&<JG[E
G75(12K4#T6a6*Pb#gcr21e2P#9KZ7I*p8]A9X+kC1%=I1Ujl>c"COs?BCUA"Nq1XjTKWoM27
7?YG70cP*7n+dK8FN970J-kQPn(G'd=\sMISj9<j>U$1k,DQBqAAP-08cW"0f#ALsU%^pM1[
72'msP+SVKs$PHc-1@OT@rtb~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="22"/>
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
<BoundsAttr x="0" y="0" width="375" height="24"/>
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
<WidgetID widgetID="518e8ba9-b8b3-49e8-b643-cdbba8fc6d57"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="2" color="-855310" borderRadius="10" type="1" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[=\"   \"+\"航班量及关键岗位在职人数趋势\"]]></O>
<FRFont name="微软雅黑" style="1" size="80" foreground="-15386770"/>
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
<C c="0" r="0" s="0">
<O>
<![CDATA[人员]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="1">
<O>
<![CDATA[航班量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" cs="7" rs="19">
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
<![CDATA[本月航班量及关键岗位在职人数]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="96" foreground="-13421773"/>
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
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-15386770" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr rotation="-60" alignText="0" predefinedStyle="false">
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
<![CDATA[人员]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
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
<![CDATA[航班量]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange maxValue="=500"/>
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
<FRFont name="宋体" style="0" size="72"/>
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
<newLineColor lineColor="-15386770" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr rotation="-60" alignText="0" predefinedStyle="false">
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
<![CDATA[人员]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
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
<![CDATA[航班量]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange maxValue="=500"/>
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
<Attr enable="true" duration="4" followMouse="true" showMutiSeries="true" isCustom="false"/>
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
<Attr isCommon="true" anchorSize="22.0" markerType="AutoMarker" radius="2.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
</ConditionAttr>
</DefaultAttr>
<ConditionAttrList>
<List index="0">
<ConditionAttr name="配色-机务工程部">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-7223378"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[机务工程部]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="配色-地服">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-4349286"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[地服体系（三地）]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="2">
<ConditionAttr name="配色-飞行部">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-3504606"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[飞行部]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="3">
<ConditionAttr name="配色-运行控制部">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-9539468"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
<Background name="NullBackground"/>
</VanAttrMarker>
</Attr>
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[运行控制部]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="4">
<ConditionAttr name="配色-航班量Max">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-4049615"/>
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
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[航班量Max]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="5">
<ConditionAttr name="配色-航班量平均">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-13679276"/>
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
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[航班量平均]]></O>
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
<FRFont name="宋体" style="0" size="72"/>
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
<newLineColor lineColor="-15386770" predefinedStyle="false"/>
<AxisPosition value="3"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr rotation="-60" alignText="0" predefinedStyle="false">
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
<![CDATA[人员]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
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
<![CDATA[航班量]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-15386770"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange maxValue="=500"/>
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
<Condition class="com.fr.data.condition.ListCondition">
<JoinCondition join="0">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[1]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[地服体系（三地）]]></O>
</Compare>
</Condition>
</JoinCondition>
<JoinCondition join="1">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[1]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[机务工程部]]></O>
</Compare>
</Condition>
</JoinCondition>
<JoinCondition join="1">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[1]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[飞行部]]></O>
</Compare>
</Condition>
</JoinCondition>
<JoinCondition join="1">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[1]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[运行控制部]]></O>
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
<Attr xAxisIndex="0" yAxisIndex="1" stacked="false" percentStacked="false" stackID="堆积和坐标轴2"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition">
<JoinCondition join="0">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[1]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[航班量Max]]></O>
</Compare>
</Condition>
</JoinCondition>
<JoinCondition join="1">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[1]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[航班量平均]]></O>
</Compare>
</Condition>
</JoinCondition>
</Condition>
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
<![CDATA[分月]]></Name>
</TableData>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[分月]]></Name>
</TableData>
<CategoryName value="年月"/>
<ChartSummaryColumn name="机务工程部" function="com.fr.data.util.function.NoneFunction" customName="机务工程部"/>
<ChartSummaryColumn name="地服体系（三地）" function="com.fr.data.util.function.NoneFunction" customName="地服体系（三地）"/>
<ChartSummaryColumn name="飞行部" function="com.fr.data.util.function.NoneFunction" customName="飞行部"/>
<ChartSummaryColumn name="运行控制部" function="com.fr.data.util.function.NoneFunction" customName="运行控制部"/>
<ChartSummaryColumn name="航班量月度最高" function="com.fr.data.util.function.NoneFunction" customName="航班量Max"/>
<ChartSummaryColumn name="航班量月度平均" function="com.fr.data.util.function.NoneFunction" customName="航班量平均"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="1a509a25-17f4-48fc-86c8-19b82cea19b3"/>
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
<StyleList>
<Style imageLayout="1">
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
<![CDATA[e@g-4;q\T3>._q3W!+)=C_/uJ&5a!9)JPq=63'=94$aEHklp;[8[]A8*&-Ya@"GE_(LpYSTKG
6^?H5.Uq1"&W,!e^\C]A!m:gS?pO*gJIY#Hf+;dWrAr![FU^dN&em:^+nbTZ_B+A)?.?ac_b&
uq;lh1d92B7IT[3Xjd4lC`&7Vq`[fuIk:aU2'B*TM=G8r0+b2n\a=.i-Jjo[ngQAgS+[k/U]A
WSJeg<l'DP$:O"V9JT2/]A).YbjKZdb\=QRqM]AQDSugC^$')GV]AYf%EpMfuj:=SSrY6'CUDi\
Cn@h0e41Sm`op+FgS"=qC,c_R^r/_<Xgk&Ar8/8$l<7`bRh3jJVIX5Q;AGdJ(V)te`9HH+X_
\GU:7,j*3"C$sT4^jG4Co>a&-=U3^!]AePjV+1L4$IRp+AJL$ktgUe<0#fT<TEjKp^6qEgFlZ
9obo3\8sa6rs,95onAI$lkMBDZt3j(qE#HhVFeY8\jX9Bm_9AukZfEN/_dIG%sBX>P$"i6C"
QT9m,Qi0`V5<o1oQI%EWm==dRO=W,bZn$b2S>g<ehLJQ5'meh[Ui`@T]ApKPOU23!1eG#Cb%E
>^qnW!ontPPillnA23-0km2kI1Q,t>om_j]AXW&bQ6ms.9!A`=]A7N2S_dZs#W7f,5)"h[IQ>r
Z&d3U[/kni\Li'"P\Su3GlJm0b>A0+j,IW0#CgdTihC&d.IiRhqehlG5Oq`-.-LFKNg5+*'>
'>h)r'qcJgo2LF-$;?]A'hp2G(.Y]AguRt4]A[jt>g<%C8$5&siE><V"YRD#I),6X^L1\R!XiGd
i-5&E4I)%en?[QLLo&a:9mP$@$/^#n#^eW&^.^4lg82XOFB5#.)#m`+,"'-?.R>"=?7HImFe
Q==iA?-n[`>*/VTLCF/1$AneP9=^Rp`3P/fY:e's2fD%#IJ75.WMCZ4\$.tt*goSm40Knh?J
T&!IbEjS?gg$p?RC`mM)MKY+@<[9X^F;#=H8%MtrroVcO+>.1D<J&`F=GJ-g!\C&bS+;9Z"1
!u<F5&?UJ^5qo*SC)*-YrIlN?UoSUj^iq3qg8r0[CBR,WGE,UYMRORQh6(=USApAf]AsfGU']A
Uf%#c_^LEfTtf`qiK(Eg07nBd^jDo;1YaM_/5.sqVJMa.7h;eYrCs4WoNcj[i7FLUD5b"n]Ae
Dl'+LcXtn4C\2f\M57dB$3!ps_tfmMmSn?N.d>?39Dlb!hk#kb]A&ahLt`*;(EHo*l]AHd.TQX
(nr.HQ>3V&D/<Df-2E,d`]ASc\s`PI/R_!B.Y-V.m22Z\D3[%oXaS=8Hj=i0;pDXMuU3#VRUq
->N=M*'GW/`nXAi.F,8JVhiBNpM9ZihuaD]ABkuGP:rip4l+E.RZ``HLHk_uemcpF;*[W,Wc#
NLcfj;)kM.*XC5BKW[o1k)(O12J5@K=DU0tj$d3\JsVi;2u^'-p`c1_\ES&#%[!4b%1J;#qq
,4nCENW0#P3a2ZGr6GAEO*_rlqnF=72Z]A\r5kCCaEgX!*G>@4dV&o\dLrj'@:N(2&3`2DE/,
U(!q3e6ur;-,:)t@62lGA?.#S?M$2o%_1_*3JN4cHI+@rhni1Oi*"Cu)js]A"W.MZ5l4*k\U(
fkeA-6_3bqqZGcn]A2KAn'/rOqbA&/QO0]Aj5)h8sFFT^6sISWoDJE7-a3:acTg':B;RPPuM?Y
Pnful`u(W*]Ak/+%UYg"oL]Ahi,\*c8"Cl@ZAPNlp"pR0^jsfb'jZqj-(_M%Dj1AR:cADX=0u$
`<gr?S=[UX?A0O]A;@0oq(:N!R0rHBFU)%)qM@@c\2Bg(Z.Ak5?M3#_`lBXZ&NF/ue'K_&bDY
K=]Ad-e)Yle@uaB6A@1EK[i@;a;C38R25fX`[28Yk_"<G$X%2<U$;Ge4@Z?`$7)\&QA*TAmAb
L4ITAQm2IJDu*dtrp-OTD:2[WJnc:qpJebO%G+%4DW>S9("LH,$Y@ihD=F]AaYf`7NZOB0^?k
<keH<er/fkiSqZWJq/Z]AQ(M3Eh$b#X-M2Pua&NTY;o)^NHc2^E:^@D`%J8#GJ[Edafs%'mLp
#Z?:HRg,G#7!RsIJ6q[[Wn-,`+bEbkN+Y9TWSXJ+V:?..uB?:nO$@W-5!g.^l8?c`)hammNN
JVkatitC7,_h_Eb^^C-%odI,t-=i5?-FqnRDmd/FWJ>6V11;uNR2'pm=f6AO0%g"d>=d'`,W
f]A":!527+Wq:%:HS<r\;l`uXIZ@3-r)WR<!GrDMIi1Np?Rd0f*@bR^6,*#hea6Js]A%VEuks6
j.UBJS_ZhgXnjnL/=ZW7]A;5(>%sEc8h-^IqG7`=;_qr?W/*^L5:@2I"a:(GdIB!E+LVX;R\3
u+'u9[DKY0h#Z4-<WZN%<N<^5FP-TgZQp7*e787<cCeQJ\+ccQ:l&bpP`lE"!7k.0(r(#,"6
X=o\r,@(4DH,U[VOA#U,/9u8RF_DW)#QUpEg[SCI*3;++-/&NM=RSjA($6=EVbTCpjbmEp?D
FBrWSE!`qhG/_B^<4eJnKSp5N7HPFTsI&SOi9.^V>!YuAeA)aAk$$VH_*Ic=gC.ajZA+DjaV
h9B$=Lte4kaPVg\gY"qEb.AokY?2[%Q`D1UdOp+:FAW+=FF'jrfOh:skXN=aKYK;i3Klk;Q-
=2(g5C61O.po_2L!t.4KrBkL(gaQdITA1T@*pb$M$7C!Y$Bk;EqhkD8P*!gp#5BfTf;#DSl_
1U(k?=Aq%P0m>#VtXrA.nqVL!fQ7lTGpX7:6&KFq,0"78lhP'=;^#Ej4aAPQ`K/?42G[`'V&
^uOrZh),TT2I=u^2FNVH[5Tfc8aKlD5NWlY,stYKN;@t8?$P*SMP[rD9YVWYRlkb*=SA%=>4
0.4kM(gcmMLXS=$fa1h%Y@#*2+:e=b1?RO2/3Wi*Ltp8`VIik-df<.M-#e&\6K%U9Xm5^l.#
cA:PA1p$_B.t:a?QZ3qKf;7>20?jmXWT5u]A/)\t,9*HiJc/,BA2%C[q;i2?4-'.)N!@@&l=&
]A4sRD6MsZ%hlP+o@HX+hai09/%0F0,%Yt6pq-NP5\-cV?qc;8WFWG-D@t;o/"Q=Bmh-69;Qk
We"/S*lE$nPms8\$mAmAeSAl.j/Wr3,J7Ah>m^-\gIVGnJNjBGra\@JZ=eWg*ioo+"6pd+Q\
7]AGBL,#YuAZ1kia4J#)P@a.E:6RII.i!c@?&&<r:?RH)I;32lI9*'dU#,lg[oWW'mA-7E\kq
I)5#*#hSf!ko?Zgq<Pk*lZRW_]AJT0_-SflW7b`\=<2F!=N+cV1ge[klp]A\,i9%[X(h04!H6u
9p!mu>pM0dpn>kA=38##Sm4mDs#4![9sgY(Xh]A/IiO]Alf-U/Ja/[ncLch-4WNM[fi.)FMh*T
>3sPf>#'/'lWNo9cJ7ONPsa02cU#ATsbW%.4#JeS'DNr-2dqVR4Vh*-.hIRLt3H/#H\Dd97U
"B'o2EXqa+iF`%&s^^?In\P_X/%+`S*PBl,R.d:<HG6>-.es?9NJ#Ftd_,j]At-sn67EAtO[n
)pCUR`XD,Q]ARmA^(lcChAbIHS9kt"E$ad>Rf3N7(Y[nj.Hpb[Nd-_g%="f3#5aJ056]A>$-W9
*=o!,BTp8i[4ec:lT^5)N$*jU+8ca!(rXlEpoZ"SNc)A",uXu]A)N]ApS"oIHPk>hTja=>r1n5
Or>^?'8sjf^I<$FMUPEK^2t,tlWjT+>Yu]Abeon^.-t]AN60BmBdqIO2Sk5M:(f-p=*U($4((p
n;##3X6-3OkC:FIYMLa=(r#[lm6nV4O^+g,ELdOqjAJgOR+h\X+t&?42,+]Ad"j_2JOC?0KS,
XQ(i[-S'fAAcfdRIF?S(/g?=U#6*q3N,`:I*T38@g?541fr[r!Snf^SZ=JsS[BPGiLID=4==
p6`)?VLLrFY6dsC4`$dJ!G&O<?tStk=!J.5e<ROXgt8&MhI\a^gcKU%,%AGpH<]AJ;dIo6ZGQ
D%FhkZ&(c0lAoL4P\B=/Fd[)GnYSq7(?mCeq@;g@0dnIg#UUjhempBtKgfN6gh^5ujX+t#d2
)o7Lb9V#76Y7*:'Sp=[(,oHY<6>`6/0#gpdHSl?ipBsJrI^dCM57o[RaQSHJHYhIR&ipak+;
hVuFo3/#n9lD]AIm5")p?hf88%bV$cUI,rZm\M69ofuSE9"03<gCQhd)nqnPWC>OSrpOYG-np
]AMBY5b(hYA6k/?B&Lur>Mk0C;#TiG*<7>rB&D2Pt=9MJu?Shhjb(lSI!,GVE@0#DlCG#$Ud=
*%8M`gZmu\A7ae]Ajl8.'.fpH$D4TjF,YPInh!52;#^[Z7`'T$jMj,4,UeHg[p,V]AoKHlEI$E
Y;q)PU'C!Rp'jRNM>mX0HirTiBG*qM+%%4nQ=-:D.5h3Fm)go'\a>N>Qr"*_SDQ]A/G:+ssO@
f3Vp4iteRuoOI<qa$__MLF^Hu%]AA*QpG4+kg<dS1[Fl;lgTD_R\1ddki0k*?0O8O,fBX#e'3
BEj*CIjMCs[Q]ADU<^]Ad)Fk,e.8kp^abH>DuM\""02]AM/%N*51BJOYNTcd!040<$ASqAs@=P3
Ko(Lb\rA,ms$0jTf;KThJ=.J%*!G#XFn#j;pS4b>E5A"]AT)Xgu$eT!ACp5Wlq3UrQ>>2IYI8
3_5JWd1<lZ0qa(HN.*s)XE*B$C(1O*[_2GZTOY"$4GTd>pSJFjXF(+[i5#O7b&^19j*9iY5p
@F*Rn=`U:tY7?k4,:nSQ+Br"(fWQ-*]AV`EF\!HO!f/98Mrcj?iEuD?,9^1=53Q??FZ6]Ajq!>
o?;[3eIOfR"/EcY[bEk6hh66QLg'_G23?3i=$P/'TnA7ROpnO`$3#DZD+rbhP5^:iQ$DcM;b
q>m;2EoZ7FR>9b34nbVD*b`$d1_na'8.)o>Khr(S<7(MFMBERB./(T'>8Nm2>+/nn6:[-[Q5
k)>CHr!pRk+;Y!,%/YoIc-Wif:l#%?If+O&0bsc).Y4H\ebVIu6`9O=B[(<\)8f)PQ%H4r%6
[a?)g.Q<iF@9U^JR@_AN15G_;/KQn;t+,Gj52I+&Y[VgUr+IlaBkJBglCtl'`h!<[mTHJV'i
`-^W>7[.B[SLr-;\Zo^H9D'f3U(Qd*p)75m\o]A7=#eQe5I'\,.bKs"sK7b=/;KgX;>t5Uq\@
h"XFkr`lY#kirLmd4D?<(W'=#6:r&(V#/-dbVrhIZs;0UGUO#m]Aq7C0%qG[K=<ecr0/S%qap
;jbZ7gkk^#Fh-4.OfW1AWS,o#*M'oE*qU>`!U%hAX/e&UWZYQ9=tpU8[kI$UDOmG]A.IVh.)t
Vs&N#S5!pBd&DK(hq5<"r,F[,Vl,=0j"elcNbJQi7%_"uFr-%94X>`mgRXY\?`aSa`GaY&J#
I#G<'fOfCVc[<9%Rs),s&oPo9%nY244j4P,^Gp8716<kY?>9bot)9iJdE6BM\7EB'QN2gpeU
D?7+`CMZ4f/o7r:M:@Y#/p6-ktCXahq"K\@i38N7mK:e.j,6n_`N4b0--[U7i=qt).RkB*2c
[nR:Q=a)9*d<WPH'=4#/=DY0SM`l'pcF`<B]A0:J8Ht+W1(GE/kp"cVGq:dV9%6C)5EM@'Lnc
C!d@JXC0fhg7AI@%BKS`&>VN/+$!/)UAf7)pH,B?]AfoSPNKa4LIofAku.&1oqM)e0SLGV-_$
laboLI!YshKnk_c:J/O.:n>d:/:bV"'i/B=ZAW@=1b=Ip,=t?G_aS39=P^]A)j8$@:Ms4j`n%
VIe4s.XocW.XDDd9bWGm<NEVS,3>=8;jiTJF]A&ZR'c(`#/m&+bAd^sVd+-$1HH9EU1P/<U_D
uP9n5Sn5qY1)%<Zm0cAR#ef`p)%LOGQ.Om"n)bXGKMPjtd1jC%.#3Q0M%G!C2F%/1Hkm>/N3
`tRfbda7.n(-YOg\(%_,6U(PgIG`&o@e@Jq*U.(Uh:Rc=%Y%_i]A2:VKSWb8gnk5dWh[.slmm
i@?&k&j$A.[:-/2.)\eG1GFCA]ALd@suNj5pnNqlFuA%K%`<JYVVu(PP<bl>AHW-^R)d!h%>o
*AZ[Bok?JOS2[f[!gY_[rMVCiihW.OEZS+5O/]AC.fP,K&jm]A_.saC7?RKERLd_ke%>/gJcQh
5US:iLsu<igT#\K%6%ES!I$:N7DL(WeMln2iCeDe7*JGoNH2Vfk!3#dH$K1/QZ!6rl8l#<>E
9eJq$!mDM=G01>mK,FkK?m:\1Q`%^@43GA$>ep;O=rgItDVoP,bmE]Anr%ToKcF3F7'E?c5UO
J6*eqjBp0V'2o#W74$F)8aJ0fZkM(]AK$U*Z]A,qHD$43@'n"joqF$$Kc9'<dm*;(+>nIoq1D&
[?^<guXco(_8Ljrr.CDfT`&on1E#\_ugt^BF%W40$.7h%9s(l8r`-ENPSRmF$c>f+s@Gd7JD
Q[gj.87c"6(Z5&%S*'`W?>P`@$NY-^+"1,c]Aj"c:pkpL+0(AEYTMR.9HB:,QO29C,9V:H@GG
5(7c8L@7`/p4ekW1'9%q%j/n5;UP;896L/\pO!I2l>Gt")>g5R>ngOMW[Rd[r,^!"[]A0fhO]A
pj\nnHD=X.ENC)oNQV.^Y!^-sG*Rsu@>XBbDkn\p#,_^\dB^5g8[GpV.gJcZZ`;'Fkd?MX'V
ehl$/D@:HKaIY-rAT^SC%`>"GrUDajH/iF?^po,Fl*Q+CM'_1s?i<G)(StIUR*I+I99!.)\[
An^.DpHFWE@!EcQs%t0uVOoFKG4,^;)9m."U<ebpKr[?=QDb#A@Umlo.k-VWpV^A,;2<+d7_
\9JtSSSTgK<pD&VElgqGh3J$6Xq:ZH%94"Q/IacHX&N'Q#ZGfijgVN8NGIa=Pr!D!!L<`1X)
<3b@MGd\;pDM`-,q%G3QS,D`kQPtW7iF>f=lVuZR*OJge*N"ilr.*.eMBP%KSC'cRp8&Ds(S
^b2iq%c0KugJhn<F0/Masi5h.$-LhS!CDR;*X9_Ja/e,8i,VJP!6e`geeK,V$!<]A8.6TG=re
CKD"jPDi(h4KhP7Gnl*VFFo5P]A6pkP#G*ur0pl`E)PC#g)9m<5g@SLehi1i6HsCm$W.7&b0E
cs4MReL8gS5+RFckMU3>5+Z8r!aUTIk0^AEU,^0u^q=g3Cfbp$DX0#j?6Hh[F@dcc;7`;/<N
nK%%9L;0.6J0[$r&pEt^*T$1Rt1&&Os5$>+7V"CYAhLa/:RI1rCIg;`s)RphIP55VD)E)`^P
rcEWjoI$e9^b8<]A4$lFRY,_d#e.r0rXP3/[RC$VJls/PZTo`M9MtXQ2HSH\kSg6f)&"XJQ92
1+r-U%=lM9+%X5\$mR9OhS[IhYM*iKJ0WiHqC3.Tn-ob&s$#&EiRV'9U-mjDKKC&La:6NY%%
2MhL6$C<q<3ln\,]A,k.VTejDaAuT(qbtTVZf!dZO>G8I<r?h>IG*_:-B%*S1PtBm*$88Ie3g
6#^D(QPk0u(G,EA6C&)LZ>L4jU2&fV`iZgh]A?i*s!VbD1?i\mHm`@EG=r+e]A_*.Qd,BSWIbW
(do9I-il`'1;bYH*#KJNKYD^PM&6Xu$jK]A8nd1<+/?h\db'R+!EaY!@fEVnf53M=)fP/Uct=
(M"G2XZR!:UPG.S\6q@=7#p\pHnR5JcCb"\q#Vkeisi5UW5;O>Q\uM:@M)'Nt^hBK(?kXT$[
gUa/-"df:[I\'K$qK,$r<*!t;(14#]A7oRN7'k&8DB$bpeUcS,%\bZFrNM>AfF_>@W((p0\bU
JEC1/QEr'sUQ+^g@RAe,mO)s?qHlOo`+"pgVb29fn+tr8Q#@9/gOV)`*9pIJ]AU"+B88-l$6m
%@Lre_0\UGdc%9B;VqCV\+//-KG=]AkJQi;HFR3OGQ80N`pH4T9h)B'!fDtbi:#1[O=+:B\!?
\(Z'WSDB94@K?jbF97&mhg3kTrE@Vr\(qF#50<D.q(U'"oiZGGnc^Yeq6<GXn&Q?CS4(Hn5;
^ZO'C9S!nOIT87;MRA2'-=*rkq_mE=3u0C%L_%b!!:Y\=gj:O`U#%bK:QfH,C1I!0::?,*,1
C8P#?esk@fnO?t7b/B5JXKhg5lin^#\7Q#A1U>#WWELdRq5Z-"W+aq21?G%@^$di(?l*Y#jg
,B7u`,Gff<-r(-(r=qb!#1hZ-!%O`jTB2oGLF?N/$+VePPX'f=r.TE"Jn6p?Htl<f!4?@VP"
"t,L[0HSCc6QHdV9*<5X8m@ZbsN>F`CV!c[7\\-l1g4d%?a$R'g28R,fHB\u[;,V6Qp(bH;8
QHhB3tVn/5HXj"rg;MDN\WkHSf3Sm^&@fc>tr,H_5&r45j0-(%MNhGQu5g;;'Vp:X;RR-%L\
X2X<O[h.rkm@rr_MS7P,=Th2;';i;TsH_(@Ks)-/jJ,O:!>m@rO9*LE&XF$<#a7JEHg_]A'[!
Se-M,=-J^@g@q1J&mA`$h^(;P6jg-b!<:tO(A.f4UIZb.ROT9t7s#+t1L^=q,kE=P<e!>\(O
1K&Qj7k5j+9L-crBa<e\fB^%o@hD\CaO*jqr%!=&fUC3tk]A1:/cLj*i[.kdJksJK/YNP0kDT
sO2M9N\5]AAP.3j3mQp&U9@XJq#K*kDW__GSCm6M(!rHd;LbeF?1Zaictc1:#]AsRk$D/+SQ.g
Q%-`/0^%i>/nMY2Sj;'c$$>q]A<Qu!]AtDP!?44W#1j-C!3_^#At)]AM8%8_E*tf:i@r=bh-`i]A
Ehh0%D>lUdhI3:r7W'Q00`sDs86ARf>A;@8[-)'d8"ehi"UaOluQhB"/nic!,7qdHV)`DF!?
@lGX_M"X#AI-RuU^g-#]AfjXXRPk264pFK2HVp[Q>[I^ThMaM]A#:"4E6L;5,XU*MSpP%*<4d7
N3LTqS:Iq3H&qS>cN-R5M!V5#47>YV`ENN$*]AG]A91l)o,JH7tS9Z#<U>3h*d?%/iU?;[htL[
S<UZ.7WtUSFagA<31E-atkrpSqa^p++976D&une\(Sd%=?DqjU-^u?_[Y9.ha+tDC=4+1X4d
n77Xl?lDYF4:2me"/JI.MJYT(W<O6#i0kf2kJ%qY.4A%A:PG.,WmsFIhknJ^O%gcJ>l<U[I3
u`3i/Z7n12#7,S1<.;pD),OK=<g\9c;AZ)+Jp@cYE?]AX^3Hb8jXgI2%cJS\qW+ui[JXb.C^>
6Ncg\ZoRuFbhmidrcS:/.`/c4]AF,[s_a2<9P:2*_$79m&kEZiW'u[O;"X(Z6kAY#2auYM0ge
c@*EV,<BZ)NH=@WSdM3#W6[#qAN!X)khTRH\ttrFXpF=(i%0oI[2c/u6071i)?8Cf.73mBN\
nbiR%%]Ac?*7$_-IK\k<U`ng3D6MK$-`NK-NPR/hn!R(0@8,RW]AU2=>ubaNi852%R!7\\eek8
bV<48k-_'*<9m*Kl@0C2QQYjeHBVUDI`ScmB`ZNBheGN3!hZ@2`&DpS^^VdVD8\82j;W=^LW
0G]A(hsm8_0mA#>Uf>X.ZqW'30II1uh(oX#PpJP_,EN!#f!2O$Ell<HmC]AqeHKKM#jUUIpF0Q
5_po\=Pe"Z`lq"UkYf64YJ4U'U$gtd@">KW?\n7@&7p.PTU_c]ARh)$o:Bjtrju(B*RFHeQQ:
nEc4\eU)kK!]AMm7%9K%F\(DUUH_eo`9K7VYiMQaX(T4/;fXZ&S5-8`M,'o`l=QBl&c).7g&+
>cQf^L:=hVRJ+:Jm(b`3J,,KTYImMj_dBH7da28*,Et2lV/^Ik-^[Urp8ge$(k=;-lm*+@E-
A>r0+oM%ZCjEm3\Bke+h;s1.mUbm>Rkk!.-IR3!o?gYM+hUI!,VC94W=c2EB0WPqnXn`7Ic[
S)X<N=/E56TGChYQ,3G%".88*c?rprI)`3Hdk"3QMccK)Q.HOjW'pDIe:ql[7'f6,l8@pWu3
;oN1Q'lM0Y1e32n(0[NXD]Aa>W'%9W#c@:kP8Xjlg)\S[81SI@=RZ!HT=o,8(ts:lNJJ+XB2q
]ACi\[=5ScR!eD%oR1,@ul_tce&k?i2D"8uPfC@0,Z:i260231@2f5kV(qB`94h4\PT4I@p\]A
-'P<p3;$B.JZS`nn(BZK5Eg!DEPYHj>oQ233nC21I8DfAAQR><tAYBhW8X;CR$a=?TU:7j[E
GI;_bp)(q:+a-$h]A38gX&&\c%ppi`(aQ.u,"RJb0d=1ZZDZ$*0?*n42bc:&DHMgbedq]A;_Df
IcSa\EE=,86Zb$bQ/&U=1M/:i2hVCM\^Z]Ad\Q+KOh7rBMBGM>4`*[):O6^R%8T:C",:49Z(_
YEl:*hgkc6m%+"eta^@]A?Jd_^4ehV@nh(a'^kDmf(CpIrD^Ah(7SCu83a&r7<6g_'H%5A)pi
S2k24EaHY8gQR;g,CbIp2&X1s"/dcV?lV!!+V5PTa-e+A"-0:i%-<8j;?Vp2m&[iX9[hVq-p
Tj)nTMCgd`EHghUXe;emlUVbO.L&j*:SSQTas'@NXiZnNu"3[>>N))2p=T@gX<^`L"$d/YX:
O?(Jr]AOtb+m:",?'N,V\)mk#1(+naRE9$AIP@VcX<33Kg@'+=6Q[H%i-B2W:aT&pu."K-0lh
Kn95hGN\`QI.8?OjPe1oI66koo?Z]A.`(kn*Q:;)!NMUpkjqF5Z$^M-G[TJs0JNTlj.+tq1'R
G&Mhe[$50,'D>_CXn9Wd)#!bog)gjOI&>l^\gG"?HPC3!Mc$io(:eA_5Pf(/tW1;cO:ZCt@V
0&NE&B'F:PXfg\BR-ukA"5bsVPfG7l("HO(B./E19FKY[o+SL.5<-t4:PV8Rdd8N"jNs0T=0
]Ahb_`aPOV%pZ3f.ub!EUYFI]A@^JgE%S[!L+Lh9nq!a+*OJ1=cPTR@rND,./Y45WQIEkMCNV^
G+"4QT+bdZrh@+2Y3]AmBEiri`8K5A(&8&>9:0WSrgmriR=Q:%7rFOr%J2OK_fOriOo`VRRBh
Jn*[Xq]AQ_%#=Qu@S]AZ(ApfFLJ=MoWn;'kUS5]AD.Q)NL`q8!7PNS!sN#-Q)I,8$-Y@G_p.-p,
8e0J)iH35D)R<FasDQc-Y7lUf:`G/.pH[>a%WKJiDdaf,j+U9HS6\*:ZQp4P&<QL'eh5Yc<B
bf8IY1GA@*Q#qIqI>;(7C^g$i(f7<$S;^)9_Z0"OUS26#"pk#p5HWXW^V,os<rApg2\@9)Qe
'%D(>H%d7H%Mda/0l@0O\T\K<FkU#3J@Hr1k-6_liTC^WpWmSV+s93kr?:Q6A$,!ar;:p(sl
eT>m?pqSo=6;9l0)"Kr`bZ3%e%[>'HkZ_kCpk/3,jU06A`N,P#T8)Xo!p2Dsm.?7_rKe2(CT
Br&+aXoP]Aoc0+uR0i_8O0\PO>lnVpX?NS0rMdY\LpkH[aHrk[B5*jYA*DU6LdeWU.&s<g41@
cM847.Ra-Q=t[6[VLW,%M$R"Se<4'rAs*ajR3l3hb_`Rer3##VnD."@Gt^'QWGA1q;e)fkO]A
)UoKJ:km7!L4G6arLKF,:'ODG^-50go_CR]A?eXqbm2/uIQXbV2D0QD*3[C`RG%8Lj^-^YjKi
*^h%FsDIJG6R=I6lhMIoRSlP]A^G9$i;FDfOFEtH[-lU(Cb_-[&?WtL;c\Ws"$sk*6A#b@=Vr
nd;V(;Mk1Ebh?cD+F;VsS"SiPt4_@IqSV%KceioT''&,X`#4e#,gNMFc]AX4r#0/7R)UH1_$f
QesaRk/X@q#!XVUDrW/X&LEF+Cfc3dWh@&<6#1b+F\FU3IjQ3KFIkG=aeocBPXiX[l9JJe>h
*%.q\9Wp1TnfXTkpG*Enjm'NN?q8U'Hq]AW[R-f5%rJT+u?-'@KAM1fm]A#m&WdZ3XRVK*V'=_
;-YeHjKSep*8[`#5%hScc]A7YD"R?`(b*'"""3I.o-eRhtJ%K*ALqX9=G3W.X?\%P^MHnWI#4
Ps^@'u5-7"MNm$*5hb,TH4]A1jS/A$&Mkf><\L"d<#2RDIAoooq1[oH#I)Be)!JBep,L,XA)?
TIkj7dGiFnaJFj<L;t)\]A1$aM]A1qrV@7Bcr_FmA-q:HLME6qiiKDisrrB=*BPArduSCf=((Y
JiVB]A"rF<,[QU&^\n;^F?8+s*#W0Y6>@RN*Tm0n(bcAOFfI??a:m9[<Y1["'TWM-bl/>OW9^
*bm+sJUL(:`:<WVqXS[13+USJo4U@*5\`?\EQ@k/Vqq]ABhWZBPggV?\Q8PJ]Adf-AG*Zk@3:K
)q6m:_LQH<Ads*03Z]A'KRf=O4pZ&3Kp^+J=i&o)R>-10b;WQ":@\k8^?o+#sng(@I3(^1>-0
4$a^>Wf5f-T+$OjfI/$&>2'ce5K5gFU,T;T>Li8CBB%MB_&tS`[GZ>r\8^9CCbME2<Licm>@
%Y1$]A*%OaZDbo^X[3KT&baFoRP<7dM"1$Q3b5QV-l>XTjON;M\e%(>p@mGu::_26X($\o1TP
`mkK(%t0,ruo?L.Y8@#Lj_MNj$s/DOM#XGhj[+SDnO3]AN\ZP23%@sM#ondFJ/DTIDeu95P=m
ftOCTf:-1]AYoV_YH5IegV.iZ[Zn!g/BA+DG'O#ZL$;\!mbKj6eeh8?j'uDbNDYi&qs$H"%3b
D[KFI`B_lB'id$ES@h"jU0l^-U^6NG-J9i\NjLUC(`8/,p]A@aTH<LqCn_s*<cO7YXP6L]Ajr;
gCj40g:H<VaY10?t5g+p\?$&QA;5cqP3n1c(G&fjTtnk!oh,_&hrIFJ/=ag^*miE*>cm(4k<
:k[SFK_$lBg<HW#cTJ*=T&$Pc$:\W2Io#UHd9r'*3@*tVJ?+e5[/8kV#?:c^f+;]Aj*eiuu>g
muoD]AjVW?G\D.:0BIoDnAb$YWD9GBdl<S3?_/r*Z66"JOI<YC2_0e+EsWkQ+rq4EKO#S"+";
C+6:K./L?1[lS3XdJXum5AHkV>a=m<d:c_iFOk'OdpGcN)t*(AJQ-<m.m=o!X3]ACPWt9A_3:
.PUfFIH1)-5jQH"-;q\Eg^L:uk\Eme="gU?>nPC+K;)ONC<+h$g+g3n30tmTE3Ren8^((0\/
&5cP(@t$%3)JdbpGUulUagKrZbVHF\`I6Np?h.G+9jkq?E*I]AN=sLB.9t::flC`qVqi=Z89N
Mhb.5]A1so`FdRLkV7'#O4\Er!QO6Z]AU7Vf6F^bqRsP5tB\Kk=od'>()NUqBY4#t*H%cZ]Ai`'
ot+3S)01W:TJ#t6b9@Udgtj)<OYsK^6r!Z4V3<.KjeiA@5m)n8YqFV7WaHYGRdl(4B-9-nC=
1rXBDVN=T1'8C$AT@a0^h=&OYVSMehs+@+"2`aIV#]A9rfFA-:^j))XGRAQL39aJ[R3onB`6C
i.D\(FRQRB.4I6K;XBp&ft2e*W]A/"39uE$)bpk9(C,Vr,!J&*]AMND4X6IK`?9&tAZW!O'Qb$
KA@E1Bi8Ol!M3`pt(>"O'FWm8NnAq%I2ncu,X]A'`L"r,i-=9i^?E6([eqM?3A[_1&219<+T/
(+<F(Ca4:Ci7h>THYp>i.9L.ec]AWC?@!T9KRP[;%aUB.m^/fXp9ZZ+R-TuU#e7*^rKKq='jq
`;g4&^:e?Kia-1L`mAg0lA9Ri-%n\9%,t@f(Xg.IcsH'm6^/Y3,d?S>.'f+Jh(ZH9u6hP.G$
QBlW_(FTUf]Aact,8@ekWKNPI/3<qOT_qDG3[+Xt2k&CIZs2aP>-tIm6KYM*Vt*=,7[]A`XB?B
QR*S0OWIoe"Ed]AWIeX+ioi_'4Ai/?(-'":!M0NW!]A.9M(d0g5&I8sZd]A<,Pfj"CRHf6faRWU
Jc1&g(n.E9I[*-,nI/]A3^MfXcX3nneD@>/C;^.d-#C[Q<V=<gO4?Z&!_jE@V7GC=u6Z<%-%=
OF<*&On$1s>'h`S"WdQX21.Q\WoQLE%)7!O!!Ag_%F-ne3"Oq]Al(ohjsTd;nE9V_+@"ts*)p
Vj2M#jcKqSh\l/o.KoB+"O&b[gT8hY\]A,p:;K[>I4-tFRi[E5e8@VL,k^CjSVh++IU<BqP(l
"+>&kZdc.r8mlcH[pS_+WpK[?k-A_;'[W@"b:J52O4?*)CcM[`*em'm1Wp&[)^.CLs'<eGN)
hA`\mLtI(?=n>^,Ed$K#a)lKm"UjS0e<-*mgri2H6[Cf$h3c\.#d>fT'<Jt4K6'<M)B+f%43
VjGW[(h.iFm3hb3)Ih&\qVpF0::'(ZOZL4[b9&iK"me<pHE&7W-'LGl+'F#!_-0-!M%peNoq
OqaH#<Kk3R@h1L+UWkL2?[E'g2iiQE+F_7Ls_4>Wc7hk$b8gM`Z>+(Is923^E+eLOUXVQFo]A
O[Qg(YPSc"J8Kl7D6d.PR+nE*(&pc!`Vs^ff35XYVR,(YOF$Lga!;tdW[Xh<Og!4-DWEE:@[
?hY!lRiZAq;SWQ\81G<l4\m`B-g=J.>Jd#CT?659k6A.n:#k5)QD&^FG%+]AkN\g@%@B4"ru_
-k\S8^*I,lM[`]AOL_Q=c-%TJ)72XD44rYt]A0EfG_CF,o"c)f>4QRGKK=rM<I#PjoQb!&&7;?
Y59/g'X`eh`Ras5't7F.r3$8Jr]AV+:<8phs?%qpaFPW5epB]A:>h.[6@R@3.P3qp5^7q^=Ne?
YhZq#i29S?mh4Up>=]AoYb'M$q_"j?dRG5k_S</+<TC"jV7S6F]A"\Bo#l@e4/feqj"NfU-D$(
k-,Y$)M7@mS+rR9?[mZJ;!A>Jj/Xp[b4Wu-sqT6QkBEe$0mNM(;PlhBauaf_Bf,(U!Qm7`kn
gl(MC>^+T.;Dn5+SEo[=_jdKaj;cH9+u_L-@$(MhR[?^cTNM&>NhO^K<:]A9^f9+O\>,!@2!n
aD'EmQlch^Gu-4-"0a9p^@EsTpC,hP;KNQ.A4!kSpMQdC/+*mpR8FiKD=rnk!NSSf43h)62]A
&;H\kl34Q6/p.8>/@nd]AF<aMc2/i9W8h#IXp>bp:XMlMq9o=a'npp?R8gX\r'2oU]A%Cgmf<7
11skY29t4Eq7nKJgWmr]AahJScAL%eoZKg/.pSWG;$'*bTM*pW$A+Ed.cO3m=Fkj[:K/0*;"G
/OXbma^2kro'j/@V*rlHFjU_d1U>`[Xp+!RfH(G31[RT0Cj)p%??ER;<7_-./tW<cI<BFr@E
%qqX""4*roF.D`\'i-")Z&KrT\:1$=H7'/9?pT4TqoI?h=UjHgo7,]ARl=g>^e'5P^82g/[o6
.=hn^pS$FVbZt5nf474ROgm1R=UDW=o49'*C@LjAqD9EX)5FA,$qR!\5W.=q0&&hVA3V"e^V
MSs3\G"eHRE2E>Z7uf!,$(;!U$GkXSpnU8)MNgL6=62<5!a2!2r4i7tKsc`sRZ$U$`Ht]Ae]AS
!L=Frn)oo=:gR3UV)65reP"iY3m%Sk6>`j$]AQt0IS/IT@USL7YuU^k#tCK>YW(/_d9Ak5*WW
>+Y_mSrn_[W9BT1e[&2"H37?o&Dtue9/IoBI6kX`jgIQ0dj63TcQhnUtmI;)M(fPCcP^2H5l
N2MP_,Y[h*KXB?b:m_]AG@Mo1_bSLIp$:`[#iWrMuITY"*h_7*)ST>L%Za*7d^@E=6HTpq>p8
L#I@?LGjkMp<?L?F/.t#X$MFJSHKeegZ4+OGLmO:+5L4diu[=KC;nKg#*p`T[YYeHfrUpX"a
Hm&VdX-ESlP5V!nF(X%X,R"$s:lHpIE;fNc0XResY,C4'PX/+C.e?"QApB0a/N-XJ/5YX(t4
!8DK<3Y;>L(p#l?INB3:1F`kFYP]AATKE!jYeZNWfp=$DgVfZXV$fsE$clV&S*$Gkr/5IS&)^
7(09hbUa_p?TknD1+@;_u)-DXtbVt/8-XUEQFK-$OaQe>/pO=#I^#q:)W-#RC(DldK'<ojJu
?)D50Rf\gl(Q_]AB0d1<([).d=g.`a(tr6s;WG&Lg@Fa3eo-i_e3^4Z5Cm$o,/H2#$qa^\[kS
2s0L)U7b\q1?2P*?s;G]A.Z]A$)UI=*:mY+Pb=Q!^7/+Yo'8skqX1$TrmnjiDX!D3Dg`gG>^TQ
5h7,JK(!mV,dQm08<?dVm5_IT#o#OWd:A=4rn[ea5.Ig79N_L$C-lVBu$o[NYE]AjDg.tPidU
>E''j1+on@>),dsMXPb8Kj]A^Q]Acu_lA.f$9<SO=f5_Pl3mSi`iqb;r9\8.n7<nf_L)h9`ClV
'W+[-l7NShoH]A'3HX*.6C$8+gCp`0VLmcqm-iQ[&!Ic^2a/(B')o;c9@qiaZaRShVWs>=p@(
9Cg#cl^p&=P%d:7sDYns+g4f!*TPW69**+[&L/h$,_g4a+q*(nHUPWGo,8ESM;hTUA<WBM":
%/@`pclqFa#j/gV6u8P.#@rE#:'Rgi[H=J^\ara<95nh[`%!'Tq7&>AWP``%-i?#t\_"KI:5
<u;*h!#PlE*4ZUVIE&.@msJTd.)IBo<kAGBhj(+]A:=rPQDTU9pcjt'EVX=NZ)3e;`tMQCH&I
6J)MJZf33u1=RM4qWG[cDrqA_G\%@\Va_CB"bnK3&-'0lj1M2V),G7OIJ04HR,rL9ML3`NUk
ILZ_-XVM`=>[VJ=^Ac:@c:-K.&8p&f3=f&$Ak"kQHjHA5hfQ'b;hXrL98>M/]A"ME^r(*:_7r
X!%&"Uui*$%J9XlX1O;VQ3+`:0d^pCp2iUR*DOehai:t0QF_52UWXa&_DIukagIV8(1)%h<'
M#WT*9FX$gKlKt9c&2)hpV6n?b*[i-:S_R/ouH!<N.j,VaE%<W=kt:)3,Q..T:j$qXsQ*N,'
[q;)kU9_k%c1q4f"00N(Lf!,\+DJ183`]AF.s%.@5i1s\';M9SX7..eW@Ugo>Le1NHRJ/7#d2
*SQUY7]A>Q^n,ITL,WhE>]A$UA%m6H6oq@<_*R=,oHB/7$;2lYe*8<>O1@O`Bb@9O%!-i=:$b4
]ApS'[&?$"?NHr3FrkN+lU1&"H:pHi,\QGI/Bq,D<S3&MJp7r(LHG-N*ok7L)QZJ?ET,kgPtp
e"j':*0RDh0B0-N['3!0c9U]A)7#ZHXk\M&<ZBL3dXR=%Y4S7l+OHA3uLN#h6n*U]A98Z@=F3)
lW7O,Nc@.T,)fG.+?FYcYZ?gsqPSO(T1>$))XF/JIOtoVQ,WjI&"F.=Ld/)1U.qo-j4k,0B!
t8[9l]AS@!>Vg[BpXLR3k,V\WZ%)\\^SF%cGp1n>?B/Nd_\<V4X)@k>B!@`p))YUEsT-`raj[
=L8Aj''LA7%OGA`Q=<8WTbVV)^UlN_.%AI&7/ATRFRH@>rQfa/2XT-IO=jf7HK8<_sX_J!rj
X">K/Are3&#/@9iHA$2dMa[.6aX7EhE"<Vo2tf5F3L3H;:p!sp=m8Jb:lN`]ALa':[1K(=pZV
PAd5:LR1XX>"+%l2`J3Pc@="X)LQuH))n[MWAD)n<;!6;^@;Yg\n++=5nS6Id/L#m^$goG?4
Q[HL2##G4\)!d!Q.BF<%Y(/m<kF;Rig]A2eUnM[X:F(VOhPBPN1oU@a3Y-rfd8d4eQ-STE4pg
K8;b2kjN?4g\m,;ans#(;U[AY3*C:m@'')V;5t8*Y"#>6B*-<M=FC0DN[*@!TTCTIVOiAW*<
MGLI=1.V,tL>JITS%<;-*-0Zal?k:GM.LZGT]ARV=X!H\>K`80b^m)R+[)pb@OJ#+#c"&L--O
`"r.mLI>Z0")X1J[.:[h_-(2o4:0QNo3'WYB+o$*Nabk\NLJUMdZK:hhBaCO/cf%rEiou,rJ
Uk++ROaJP<?c8gRaWP/Te]A!InLf^',sN,@]A4T"p$%lG"+:[lJZ>6;SWg(/:cLch%aK3f*mgd
\2,3@KDd2KZ:h=rR.,Ehn@#,tJssc&[oK[lX14[Q3IadDl:Ojl>SgA1&U"CL7'(VccA*W$M+
.b:@[6Us(i0t*p]A/%k4V?3?'#O=6!`nTUE2?qd=/t6mr.u*n!&^!QR,[0;Q$Uco2.>7#WmZs
j23eO%?tLT0HH8r_e&ta9A:C\R_gDqK]At.T1']Ane3SF&fB9Wh.tqugn3"DU[p@?`$FI(1qYG
U".q[sL^ihH%DZ9Y:T5!j3uJ88iH,lJia^f?)UEn/LKf0rkbT@un\7?Y2_JNQW%0%W>[8U!s
2g!"QY:4t`13m,M03j90_cN`&H%Uf)`\5M-ZL84,ePb><geYTJK61i$2pbP)Oa_Gm;"YI;q$
(1t0"'9Y'1(rIXlT['kj76DFqOo'H1_=6=7#p@?YalIHM`_t$a00C[4C2k?*#%)iB?;@['+m
fHO<3R(O#+a+Z_DTHXj,*_3rnWo@>u(JmaZC01,B`VkrFfePo#@":s-QW:,P\,.kqtPS65<-
ra/ap:<QG^+/GK56l`M&t]ApM,SdG=&MJC+bN(>VG0]AD_FtIr`1SBZ+.&lD6rkjf8?$2a?<[J
7OS,ajORJF8l;?dpWh2_So.p,R&H>PuYA,cBSV?mmC,Db2-G1)>#olC/)<+7p']A;OZ8l3\B-
L+7io+-NjBiULm:#>O!BD[/;X-_fU[?J4lJ`/f\\$4+RSL'm57tQ)#Z00r<FfIb[(:;l9p,+
ZOo^nDnbIWAs\HoXR=o4`d^6G>P4!OjdP%n`oNAsN?0aYV-MSBR]ADBdi0MTTRc?9e$ImBHZk
r]Ao(X?]A[l(i\EIFEV]A@CNqpQ_b(s?iJmajJW/T,OgacFV[RMf\j"i8D0OWA(pD[OZfDhVr"8
GGE)%EjTL1Q>G8AV0.b`1-uY7\*J=B3KJ*_m??2G:d'N2:jA#ghHfP6om_AJUNe_13DL[Y^4
W@e#KD1Z[je2n[YUc2igHC5G\js\=-n.1mi)=]AVE[j7'-&4e`$=hUG\pu1MO?c7+V'CtKE`K
5c+,EgPMlOb?M>=4QRH-AVNBPY`k(?!s]A0^X0TbtZd>s_mI@4(]ALZ*W(5M)1A<aA<_(f*'a>
>,_6aBsqDPP^hU__@L4M;4A=fO+IKZBOVoqiVb-6'Yh]A+</0E^`7P\F'4qM&^Y;V0CB!jo/L
sR:)=)e,9oIKa<uFqt7WH_ZL?=TgEMaI1k-a^afQb>HgL\^5CM]Ad\ClcY3`qZ7iHs"&Ljsc<
\d=lASI`-m$K/f;]AZEJSJEXE0[)?aGOnY_.ApEa<)A2V<s`&qRQMs=i.Pt)m&Q&f,r,ncHZW
=KP4FXeRY)-`VK(i+D-[F=/qngRl'F/R#fS)R=fNq\sL9,5b.=$kOlpPZVMVKBE6O_te$^mi
T>+n_9ZGmn^g.A^'aT`LH+lROM^j"h?&8&,!r"/J(>OsburZ_F?W<8-u-D/']A\LMV!$D9rl(
;cROrIh>ot/*^)6WF7>d(;=QMG_P>8_r"jRn.L6LZUTAmi<+"K89)8&/JcSTELoE"_#+dOdN
EoU&bBlRe5b"9i#+[an/uq9O^FpRfqk7eM;0t_rr:(,Z[_*9]ADoNf6o^k"^UY"LhoO1[=NmD
nW;BZ9&DeBC^GEZ@jY?XCBZjZWHA:$V!_c)P.dHc9DOf0M'OGl.4K2L<)YJ@8l5-4+ohmWY@
A4:WV'h=f^WEaCbkXi6EAI5_8$(B$i\JbgS4nW7lW3dZ=mVe:d5N$bS&^%,g*Q#Z'#c0LhZa
I#P5XmRl3+um]AIt]A!W=oZA,TfE]AV8QYTl5\$Oog.m*.TDrG&'2&$]AtoCr0='$lct2%DLVKc`
7X:%neJQcTWgfndKHDal2`79ge<!)DbkocmD!";d2r\#p#qoPbAYG3@5U0+S$4?7q.u3S:0'
4`.V.:3.)i\H,)69BaESjre*qK>NiL+)44j]APP=$G_K>mtUTfjea]Ar%c^f=MdQXs2C7s'EWT
!$_M&qOD!82SG%9]A<\AGBWNA]AKHgp9j"J-u(GD]A?!WK)6!'j!L1EJ-Cd`B:+PC+&VG$0aSE$
B9+E]Ac<7tC[$)44.ttM2,$,(kauAS1=!qJpT.?OnW6uRZE-SK1#/B?^ng5S`G)#,$(TVV=SO
?nqlgd/XA.XX>GCg2JR+k<+T.P.S,BkZ26"4'qEDeiV5ePH,Qu>Xqn<cOAFWhK86=Gq.os$9
8HB3#fZgZo$KE%[o1\ph&djC?>E8*RXF$R9;T0/[iWu_J@/_&"?ZL))Zms+[+qY&Yp8L2PSb
*)PX=h&/Dg/#Y]A8]AXi(,F:4[+((K;H@-]AX=0XT0bVU3)\e14Qc<Udb_aJT\"1;L(-jktS2?n
)G98E?,Ek/GqBddqAc9!39[FoWq-rhu%!@:EiKE>$']A`(rWF&Yn8o^Y"CKYCh=4hsjOhR;Yo
Cjc]A35<s1fAe?%fT&[]Ao;igLKYV.t<Y(hZ<`F?91^@0=1OfGSdnSqDndKHt,iNC&eYpN-(K'
lYGsN_@2I$"i)o>Hp45S6ukm,VAH*JW:2h>[<e?0b$1l?VO[Z\Q@E&j*Pj?udOHMi'bOq"UK
KJG,J.-Y:3\gZEWb**"bo-/7er"EsKC\VQ'\!`i0;AY\/[QHG3%r]Al,\ib"'Z_uJ4"[%YOiI
7LW*`'"0$Ar*J;I)CC.0;jYI.*O!RMk`1H[Vju0*m$VoOdr@$\?tY0euL!0n/%cBd"WT]Ag'%
oC+^gTkbS52;tK'j9r6C%8o2!:!%=bQV[d&9MXnXrp,!aW#kLcaMsV4$posOVN<eq`1DS;;O
\*i)NPk&r6*9Nu4,^3$+"B\'\d.Ao-!#?5l4o^-BUI#?9D@\IBQsdW+kr2Gc3ji:,]AppbNe#
SngS[;V.RNA+8mU%mh1)c#iDfp:rfU!i^E8Y734Ce3Fu4]ASS^/,QI(?L4H.H0XTe#YUJ+M2<
(OPZ7#NE*ej4AqIL&QjGeAVllq/#f196K%80ti/_o'o#d5t<&WFlPpAk().OPTP$O/&XsJp$
Q_>\J!$=a?UA/2j7[+ng19L<$QrAIBj%4i;/@"'&G)bH?FRgpt!3:Hcf6&aTb$Op=(+)Uh*2
UXPnj4mflJ[6!"H=gK.`7:ak;A9V^Qjh"*hh#k[T[>L4'$WgS4sW2,j'mr=QcF_gYX#W5@4/
3F"P)"qF4>'QV#K1t55lG=LP=f%Cgf77O.F&?.6MY$SS"oMXYZc;3]A:RlI9)EP^O)pM%&.mp
E#7b<?"17pJb9W+d_jjYRF1k/*r?5^mt!RGtX0;&^e6K'>5&>+tP8C?<eKa`q\hZ)l&e0V$!
gT9g'S]A1O*Dng1KDgc;FHN-%2XhODA^2rcpMh:+cflp4AlgZaIF?7;4*S7u^_G/Ah*B$=W&2
GCslnWLY<fu@S&(]ADi2VrWb-1S*ZbUBh7,B[(%Z>9!mapDUYh?EgMo<+Skha`Vl,D,a9,A]A[
%(]AiO?mA-DALAV5mbq)=1dJuYn0UcTNg*6mU$6(^!JUbb?GV@TE)T:0G9MY2H?Ih"!9KG^eQ
#p>6Qj(S.-h6KJ48T?h6I^(J*i.ZP]ATY1ME1Sk^@$@O'$M"ZOM9,S"5TI>]A0*iMk%.bl(eSb
j4%Y+DP+)c&0Ed7CAj)#mLXYct;X<JGK0cbe#cR@_i@0WO7Y7(A.8(V24,(2GDV,mRN0?j[F
6YN,/58_gGhOI!9!PE:F$9_KHAH(5`Gs"fPiI0B<UL7W,n*QbV`hV'"/5q+IgkbeS3sb"$\Y
9BON^rXOY^Z"!--@2#qpJ633nBCo*aS?M$\F+0O$g',O.i&kasqO8qJ'E5BMR`@`k#!l7R%6
8E"h]A"^QVOAgA\uL!tgIJ>$r4jlFF+<s(3D8rYenK#G\%cY;31@9t"ZUm$V4*;c<t:mj;A]AH
&;P1M=7L9QrfYDQ%)72#_Gm,O*Gd,/3\_%gVf^+Y$BK$s5sPl&[fDS=7GQpC2&q%#*-9P!)4
h]A5bi.4(LP>RMg6"[4bGu:;@9FS<I-DL@:RULQP//ROZ:'.A#_<^#32jHC3$b>s0YCP\E*6p
M>k,ZTQ`NFKg!%5A@rDQcuI9$ok5od&kIX#dcM&76iWXQ.qKj!1s#-<o?)l7*L[as7P*Y,5R
EnK<eYqHi1c8j@J!aY+HN7KSp![<+FP(*iDj;$b*<nnqZ7m$hP?N''E=OkP?ma;>+lKJD=%A
t)ho-\fiKJ9EaTZn^4VumkJtgk]AnSE687.)iN"66Q9\9V'gX94aatT0X,Zn2&90l8_ZdLEU"
gpIM:JI&0Qj<U4/dBsl(cD$Y6(8B_$Osg6GL6W$A;JG_itJA*=sp577@p0j#1q6:iWm\![K<
8,hZ-ZUP<8%AMO^=2E1&6DW1^4C(CRaL["$LVMYcpqWY]ANgVngTK$Lnc2DR2Z!*Cl)CeZ%"U
:j7aq<4CjGbI]ARgaXR0F.o6mQT1#$#d9KN9C^O+Tm@WBYbKo3(c;2?gfTsT88CQKPRqDI)(2
h9K9+1:P2phr%@CkB<*1A6$@/J_ii>NV:l2$[0pQ[jQH4GEMMMl'V_#0g(q>IXto7-2mbJp@
NSBi+$p8l+Qk`o<B@@ej4el3gN]AS:Dc2$0onOjgQR;D_UX2lq=-I=OO\9'\UC/QdcFR(HNnX
PhMo/]AWF`eT#Ej"Rn\N]A*Q@c;IB47m)-qBH;""l$M]AFNGD'ns1./J@l*?Q-ffHlk7!G("`JB
BZ^WiY&jSp+<7#V",e\!)Z/rZ+@H5/QN1Q8Y:.JP)`[[cRIfBqqh#6$p@a:mO:;aZU4p2/`U
P,@d3'lapZ(Z+YkLGS86!jO35TDVK\dk<(XCsrnmk;bm2DP(uhW">!C&'@q<F6T^Vrdf!<Q0
;lK</?@Mp9qCIMnkqoEXQnS9s)p@rUF,I8EEq-cT2"7:XVEb4oX*beu!iCOOPC[/*7!70B'c
\I.UtZp!qRAC;0Uf!Zf!BFer8OX7MFp+$r=!lZuQ^=4BjqN'n'SmD6>L@o>[J8kH5^s0D.og
Y1U2$q[:lV<P;>pk-mk;Yh;\rhL$Kp=)-kQ1EJg,'8>2S-^,1r.ciZs49.\jJme)XW"S9Vh%
tIlJV7XU&'SlM4^UO`X=!aj5Z3W*Hg_:^pHinNFOC3J',=uW$\YuY"MuY[8O8qT&o9?TPP-C
UX_7kOR-_o!P_`t]AAal_W3oO49%6fG68I:QQ>NV*67F*njIinD>,&;@fS#+$77m`8XZ!$W`e
Y1,&cr4,29F';TKRu_ELt7,B06.Un`J[)Id_K1pV&`AnD7X"7P)fC,c>ZGr[%<9eB_fh&CtB
`3?MM#mQp;iLVpR$)lk72Ad`LL43`mnJ[!hcRq,G4a3/dH8>0!N</Di6\/=H\Mpja''fO[ZQ
CI86O_mJ;I`-M8A;:^Blo:41[EGW=-XIU7Q.*5WB;7l.>FH/`cuU^?d?#+%lFo*`/3OVRk=T
du\f`G>C$BJk1H8*_l5CKkW%XJ2he8H*2]AZkN.phZ!muT1RpMG-T3qON^a9]An0-4<#^\7\^J
a]AfWR2dDt+n#NKu6Zs&h0th`VEllmeUt;!<-=7V=2i.L1g&#A,Em^L+\+'aI\q7=Cj(MSrr.
]AZAO_;fc;*UfcK<_<IIM'$!CM00t>pJbgj.($'TR)kC^$=o['7rJZFO$*iDA_@:Q=C[]A^k*N
++oKY')Jq\S`dl9]AX?Ak^G11RBm!\"5lSOb&pK]Al0P'G;F+iK7XMrPhcV8Xoes&D_!RE`0IW
b3r,lDrR-ghh)t2knO)B&%Z3Y*%[afJ6DD[a[ftf%,`^cE!5e;5X@u^gVk#[h>t2g6<\XKb)
Nt8"0J"^\]A)D#?b+>p51/&Uk(kX1<d5>lA`6R$n):E1G'P+87m4W1<R*Uop]A?+.jEVUqHV6o
_pT\g^7c@Jj:s;\ORDmmh0%,pns;KA7Cj:PB`F;9Z8aTc/QX?@W1)B:Y%]AF,D=HD`&YIQ\`g
+'!T8$R%7K!&I;#AOCJb_m-&Jj==D/-+)5&UC1f*tJscT9j[&Nm$U/aoi\_f95-[p;\"'Xn!
[&b2e?[M@!.r@SosF^Ghc$_,eo<k6$q`t<=&Z<]A)tT4ei+nTd4CEjWerSYJSI@V9lP%Y646V
:(%`m5\ZMXeL7BNl<K!A[Zu+e7TXYUW`0T*$q?A,'q70;`Pl%?-f%LD,,F;c!(:"]AnK$IKIL
7uA%.%fP0b8K_:`FNRV`U^7Z8'TR:6Z+[)g"`EC0&2j49.]A`@]AArLeukUL5\p;bdM+-4EG)J
m"62lgjc?\:ZOd1:_D9#)ilVtg7BP5>0WOBOZ2o\MtoRCUN;+C(gH#C*+?(V#&`O:f[<`Lb>
#HAMe$P&U_P5[-B:G@kt]AY=B>U.S[UJ`RYZ]Ak9XPnYaTlkpY56r3]A92DsBf!k)\;5<W:-YUO
(dZb1M?&$8-Ofk+<>!6=^SIs;WpP#q<Nq4?8'[_=PMWNgg)I:0IY<D;.4h;9-/L`hK'hJ%>'
)&7s9;pi@.J2'(R%g,m8NNK?aO]AurAAO,fJYcZBkVM=(ihZej"+JnlW6qu07c1Q/mDkhXNb-
/I0D=37U?&Of%Kt.QHGYS'jG'">PSeVGWOsNl,S$HXIg<"+L=?d>Yc_l!\R>sI5_>2COI.1g
Bm.W\AW>i]ASju;*YMNZhE;ECl2>bjC>A`-:1:Nqb<3'ffb<BX<*-``RZcTJ>jI#cR0rFrs\T
GZM&MC<4J5Fs2>H5#@iCe*,E-&h[&cS^YKX4gJ;5hXIX5`tpUIbC4(%cR#;F-Q\?mtd3.Aas
YPXGHIcRYSVkG($Zj9Sc/L]A"qZpbn#?RLJ&d>6IF3S/9MCV"@^u<[95<3k9-\8$6L_f[Ebu`
dh.R.9:]A%BlL893\h0F\2K/>W.'h\#1#]AS.S?Jl-K9dH3'Paj,4!l:AF^"uf9Pd-,cF34]Acj
\+?&IO)3gZAnR4CCPcPiaDV"+gPSNULC&M/f^A>cZkn.9Y]AK_6ZaX&t6669L)DM]A9QSKc75B
)p#l=jIKl!!\0831YOZ<ei#,^fP.fPOo\(`QC5JqRF`kW@ilZ\HV;=LZGS\^X_#!?Y2ZkJn+
NtgGPhd]Ag0:DSrc'QOl3OZa<Jom(82>\tC4iqE[q[H_cYa5@ORXslYJIk@!Hceud"qmZ#9$:
%U`ertHSj1XE18fRbQpdZVC`WU*'9(t_jA6#]AfiNrY3+*6KiG2Z"?IoPag_=6_&gM[:aRe94
uBr1O)1$Xqe&0oY[>5kepSQ+#UAIi.:J.H^%jj9_J/!o:k^*[FQmDpM;a.d/_AmjLh>U)*U<
VS#hfa]AWoY@s0H\'_6^p5<Hdqp-/uIK%s2T[>Ik6ghRU,*>C-S(q.dY/L"4XJ_Y[`G?"jS>U
0fd/I56g%BJAehBL.5Y8bdqGIE=cUk85Rl=od3.&l*=Y)f%q<[`kdp1FQ=o@L[/GpH`:`SMg
-a5lba]ANr+W0-E$ZK,aBlIZ"D\.k0,Rp">&N24!`;jDb)jj=co*S(0+ktG="o$4N;;4"fLoA
jf#A/[/e]A2N4`E=c&q:Pb4.dWT4lb=oV*8HmjBt1-?QVL[.:NkV*j#DZUM0u7.UdekaHT/lp
/k5KU9eZ[/=A<=YX36@M`XmlcBF`P@tQjXPPt7LSDc/r[fTqhK%Ce6rq*onj3R*61^*o'=N'
Psp.5UcjC<(G]AG2i1(c-tCMJag'&%>Y/.NrlQA"*,RK4K=k0CG-^VAqH7c8E<C,))5?iJtjX
/(m4&+gNCn;QB*^OJlq[l"N"F(%6!8D=&kT@!5YjW\@W?7f[Z&/9lAU8T'2WdR!/W^noi^0"
ZR,M;Y!5193Yg42Md$E"b$g"-S52'0!>JI'!<Yah^7Dj*DPVE8Ht\k_Bu7O!4XT"?K%Q1EUD
#%oA$X[QKOK[j!^b4`I8W8<,U#*tm+J4rZn2PR:/BAhSQjAMl_>3RK]A%o"i!o]A\U:5rW:I)2
:r=N'LD4#E&nno:V&>L[ERPRXW/EhpRm;^b`XBH'`!VJR5LD#Ku;T!oIqU2$TP02kFuCHE[$
=E/Ea$E84r"WJ0[&E!7VTEN?>16"d$Y8lD<NX+pB@u_D`Ch'uPBX&n=<rmjmY0b]A5f-O/[LE
D6>fui:[^H-diVD\-k>E!o0Bc6Bsltc^DpRFIo5F_(8]A>oZ(9]A1@lH?CM@fi<*j"WO0I&VKu
eY?Yt1[c9pQ3\o?\FT@FT[plWi?D'p'CAK+9S$,iNDBH9??=d!Fa1PKMF0O-u)s5YKNmRP7m
$.DXGs#]AtV3%hmCHDN/gL-P%MY)rg8c>24/@C4_A9HScfLd):X&JZ5PTbVUk\ra2TS*V[Dk-
6aDm>Yrg.U-(Z;C4*=N3O^1nH7dY<I1^b%2ee[-kqkd4Aag1@,%X<@>DD?-(R84e@b&3&"lG
)KG812H+A8jKQYm"cl.pDh%O:fblI-h=An<dUrbJ2Pmr(>t-I*`GR[t9K4dVek3_K7?jLUf7
1`k0)dH5rMPI]AT;%!FK3m([3n[&Y9geQV8'auGTNG_/U6PO9cW\oTUtSA12+3'!buq$5uO$T
<sR61gfb*eM>`aEkP^TQgq-fE?O\c/RM+!eM<gILND.DC1H^$+>I:_)+'4XXg)1D70.-=Tqn
P_"B/:dg.YQf;q?u55;)BO,:p>hI^4K+[WFWCl0jN*AA&*d2<L`./,uWV/37Gh0Kr45f[)+p
oE-^5IU:h&pb*:i<$E_dmi>^qk^Xm$XV9T2c;>gmN*"TG[*5`"8RsW-ciMAq;@IbPo2W6@:[
To\BI]Aa*`1EPGSL@\`.VNqk$!8t$lk1PWW?0ClFmd^Cam#N80dNOV37*?W4#CtS)4:L3iPp7
(US*d5"LHp10`+o`t+?I$ZZOlNg,?lGJ=8,S[B4od5Yb6q(K=\nd*ds0Xd:bSGEFfQCI*:!`
gjK:Gm#'e'ZeuTNiQ&F8SDj>g5;3D^99.F>KcjQ6"/tf-iq"l2V+t[uE+lp[Gd;;PDaDO;O1
pm6s>VCJqcJrdQCIj5'Ja3^q?[Bm"2RnPF?D&>N`[T)a^\<th=gdTn^(!1Z!,r^jXKI4^$>,
#6'rJBOlHLZ+\+<KNGe$X,$gWl./HWP+0Gm&TE6d`',TlgBVA_a+,]ABc/=E-K18?qA#UpfZf
T!89sQ>[2paA2>u^Ejc\pp,[D_aVScF]AhI!s'$`8:UTV"H6V)UiA&+:3O&BSuZkhIP9oEMa5
),!9K)Z[1W$20!%bp.:6EX3>p:kV=jA*/!M:G'g\G&U/rM%*-b4MKX^O)QF\j/nc[.1L!62/
,>;#$5fLm-5pHV?l*<8_69&g(b7n$t\m!+H8&AfhT(Pi=B:1,&]Af3mB-U*GXbXq^u74#dnf[
9$RW!/8:G@E9DH$V_22icbmN%9&ro'WUlBHiJ3fVVfQ]AS^gJ9i)99!H()D"/T7('V8!bf,&C
F,'Y.O=R\]A+4%"9\+&G5J-g$r"e`aO>]A_#A]AF"T+n>(tmXG)#/PWGK]Au]Am2T-fX8Ns?(-?M*
r72lRku3%,E4%sh?8D"]ACBSGfm!+:VGZP&0^l^!ZsoJp]A_JmgGVt:'>A4gG(#oR6f27jNJo6
8T]AKpVJmFoNr97E'R`:Al7NX>VNgU0#Z#"\Z@b!U5UcAU%Rfdg2;dY;YE"<JWj_:8W[Yk"qp
q2pbEd#Aqu6W~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="true" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="36" width="375" height="94"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="Title_report0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="   "+"航班量及关键岗位在职人数趋势"]]></Attributes>
</O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="2" autoline="true"/>
<FRFont name="微软雅黑" style="1" size="80" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<border style="2" color="-855310"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="36"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<title class="com.fr.form.ui.Label">
<WidgetName name="Title_report0"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[本月航班量及关键岗位在职人数]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="微软雅黑" style="1" size="72"/>
<Background name="ColorBackground" color="-855310"/>
<border style="1" color="-855310"/>
</title>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0"/>
<WidgetID widgetID="518e8ba9-b8b3-49e8-b643-cdbba8fc6d57"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-855310" borderRadius="5" type="1" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[本月航班量及关键岗位在职人数]]></O>
<FRFont name="微软雅黑" style="1" size="72"/>
<Position pos="0"/>
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
<C c="0" r="0" cs="7" rs="17">
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
<![CDATA[本月航班量及关键岗位在职人数]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="96" foreground="-13421773"/>
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
<Attr position="3" visible="true" predefinedStyle="false"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-10066330"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange maxValue="=7000"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=-250" maxValue="=250"/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList>
<VanChartAlert class="com.fr.plugin.chart.attr.axis.VanChartAlertValue">
<ChartAlertValue>
<Attr name="警戒线2" alertPosition="4" alertLineAlpha="1.0" alertContent="警戒" formula="=ds2.select(bq_avg)"/>
<AttrColor>
<Attr color="-7236949"/>
</AttrColor>
<AttrLineStyle>
<newAttr lineWidth="1.0" lineType="dashed"/>
</AttrLineStyle>
<FRFont name="微软雅黑" style="0" size="72" foreground="-7236949"/>
</ChartAlertValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=ds2.select(bq_avg)]]></Attributes>
</O>
</VanChartAlert>
</alertList>
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
<FRFont name="宋体" style="0" size="72"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-10066330"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange maxValue="=7000"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=-250" maxValue="=250"/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList>
<VanChartAlert class="com.fr.plugin.chart.attr.axis.VanChartAlertValue">
<ChartAlertValue>
<Attr name="警戒线2" alertPosition="4" alertLineAlpha="1.0" alertContent="警戒" formula="=ds2.select(bq_avg)"/>
<AttrColor>
<Attr color="-7236949"/>
</AttrColor>
<AttrLineStyle>
<newAttr lineWidth="1.0" lineType="dashed"/>
</AttrLineStyle>
<FRFont name="微软雅黑" style="0" size="72" foreground="-7236949"/>
</ChartAlertValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=ds2.select(bq_avg)]]></Attributes>
</O>
</VanChartAlert>
</alertList>
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
<Attr lineType="solid" lineWidth="2.0" lineStyle="2" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="NullMarker" radius="2.5" width="30.0" height="30.0"/>
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
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="9" align="9" isCustom="false"/>
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
<Attr class="com.fr.plugin.chart.base.AttrEffect">
<AttrEffect>
<attr enabled="true" period="0.0"/>
</AttrEffect>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition">
<JoinCondition join="0">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[本期航班量]]></O>
</Compare>
</Condition>
</JoinCondition>
<JoinCondition join="0">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[1]]></CNUMBER>
<CNAME>
<![CDATA[CATEGORY_NAME]]></CNAME>
<Compare op="12">
<SimpleDSColumn dsName="bq_max" columnName="time"/>
</Compare>
</Condition>
</JoinCondition>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="CopyOf条件属性1">
<AttrList>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="9" align="9" isCustom="false"/>
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
<Attr class="com.fr.plugin.chart.base.AttrEffect">
<AttrEffect>
<attr enabled="true" period="2.0"/>
</AttrEffect>
</Attr>
</AttrList>
<Condition class="com.fr.data.condition.ListCondition">
<JoinCondition join="0">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[环期航班量]]></O>
</Compare>
</Condition>
</JoinCondition>
<JoinCondition join="0">
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[1]]></CNUMBER>
<CNAME>
<![CDATA[CATEGORY_NAME]]></CNAME>
<Compare op="12">
<SimpleDSColumn dsName="hq_max" columnName="time"/>
</Compare>
</Condition>
</JoinCondition>
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
<FRFont name="宋体" style="0" size="72"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-10066330"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange maxValue="=7000"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=-250" maxValue="=250"/>
<AxisUnit201106 isCustomMainUnit="false" isCustomSecUnit="false" mainUnit="=0" secUnit="=0"/>
<ZoomAxisAttr isZoom="false"/>
<axisReversed axisReversed="false"/>
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="Y轴2" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList>
<VanChartAlert class="com.fr.plugin.chart.attr.axis.VanChartAlertValue">
<ChartAlertValue>
<Attr name="警戒线2" alertPosition="4" alertLineAlpha="1.0" alertContent="警戒" formula="=ds2.select(bq_avg)"/>
<AttrColor>
<Attr color="-7236949"/>
</AttrColor>
<AttrLineStyle>
<newAttr lineWidth="1.0" lineType="dashed"/>
</AttrLineStyle>
<FRFont name="微软雅黑" style="0" size="72" foreground="-7236949"/>
</ChartAlertValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=ds2.select(bq_avg)]]></Attributes>
</O>
</VanChartAlert>
</alertList>
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
<CategoryName value="日期"/>
<ChartSummaryColumn name="飞行员" function="com.fr.data.util.function.NoneFunction" customName="飞行员"/>
<ChartSummaryColumn name="机务" function="com.fr.data.util.function.NoneFunction" customName="机务"/>
<ChartSummaryColumn name="签派" function="com.fr.data.util.function.NoneFunction" customName="签派"/>
<ChartSummaryColumn name="地服" function="com.fr.data.util.function.NoneFunction" customName="地服"/>
<ChartSummaryColumn name="其他" function="com.fr.data.util.function.NoneFunction" customName="其他"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[Embedded1]]></Name>
</TableData>
<CategoryName value="日期"/>
<ChartSummaryColumn name="本期航班量" function="com.fr.data.util.function.NoneFunction" customName="本期航班量"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="ba851fdd-0d9f-40ea-82ae-dc99744dfd8e"/>
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
<![CDATA[h-:7kdc^Y.[9r@kB^<.OPI5EORT@_X$Ylh<>M6!DB?R&*`P;jMW4@#>V=UiPaNU_ZWQYc(E`
T%_R&8pFA;Y%+.&;YAr4gnXs-J+mg92O3s'C'F;SN_Qcgs0RTD.N!T=/TZd.g0+,7"FHiOJ-
A*>$<,N$+58><\DVr+06**X;cBBs$DSlZYd0&()'[*aq'F\WfoNn+.(5^U_&CkLj3!7NOWGn
3Q'%j%urJD0f8)NSCr=B3N4!X%i1%0@2e(FRI#b$Q!P;;@oY9/iV&/g'TK71.LZJEiJ`FP-^
F?5MU+A0]Ail$RT%r;G[t.0'cLC2NO.h#5a;UPI#mUm<E6RX!ZMT0K:1eRH(Ei0D'!O70T_i\
MPKA`Ib8Pa2INZ5L<CGF1+YX8>(.m<WlOI_98Q;5\.RGT:<oLD.1^H+XSqNTO.&/=+kJ4c#R
ql:mR,a6]Ar4l5ZK>,'.Z/!KKYFgC*bqH>NeW\)mpJ&oQ@I*lRR'=27W%toc1(t6P_:!2*`n=
Aqe'j9TP4OgHuc=^OC[ni%AS`Qa/_W$/%JeI!(+@:j'%%hk8q"-7f1QLMhCBkoqan,2f+;WU
InR8gI_l*%VnS$15&bne8X:=qmoPR&3O7#[0(E):rc8!LeD0ZeqB\?iSi,qMlIfOeqiL9Grp
\VTr+LlC\ri^&>/Yl0";IV\rpF8E_C>m.'IV0Oup-a>71\,:D6bp@jth:El*E4M8nqO7[<-q
k9Q:N)Ecct5*o)Nq5ApqnjH';k9]A/Y8m<CDMAG2jo_q)a-MibZnWN21$YgYWM>!Q&5B;l_H*
tLMD5^AE7B+RD:G2F*gKet5ON$qMOqQS.KHPC%0<JeCp7<7bctd'XecbrLTj+m@,.>*elT+W
F$)/AAKSH,fqpFsZ:J>&8)9('$7Z$gF=R&@[Sb=1b-fCUb_rp*"gcQ*KhF+o/Nol[EaL'Olj
OcREUMS;#O19kk`d+V?'r,$O$;0o;'D)(S(H<^1ju;2*<;.Bt^=th_MITMo^hI_[BY']Aa_Mo
r']Ad&+mn>PY+>N+Mi+'QnG7K^(]A9J<&`)OUFAGh!#E_5acGm]Aq;f6&u2Ti0-_<!a;kh#B`u=
SJl6&)Q''fG<W5!gshlJ%!Is<k0g:L;2j)IU>8d-6<1B_>R\hJ0YPT_&O<X,?-s^":_L>dmD
5g0DI!LFi8K#q';j88d=PuSXumPfii0C3l8MqQVNh2J5I(392f7W_h:cdfGAsFf)Zc1tDWG!
/Cr'fUAMh'<Og4Z^?o]AgW^_k\m>g_rsPhNj5-HS-/BA8N?9PrW)b1k)o"eP+*l_=SP;^Fp64
8ZPDYdh4p?Q2g_#`j#&`58mU"jQ/a$7$%KL@_#-'2:h'_\2?X!qnk<T/=6G=.4dr]AAI'd;k+
k?6=>"Yd#=b_Xj$l,g'?B8U:IUOb^ln;%R'jc*:+/^$V(;bhp$(YH03$tBsk6ZX65il)E>Bo
q"\O1#90d&1i[XV*!&+M$DfSo=K;->5E6ACo'uBL8f2OE&hPlZ8u0i45[B9eHc'0J_d8LK^G
#P&HeS^!']Ae>*"8o_:=n2N>TCep)MIb8/$pQ]A/s+G1H%jjg`1N=L%+EUd+W\a#&jSubLn:Ln
;L\Ds)5I59)QV?01nBqgjl\sk%FN19.+llSC;&=@"o-(dB9?4f7=.6T8!\%I6jSp(r.`qtJ4
$k':=/A'iMGq)="ENP7V5O(0Q!eGEjM9Ri;u>eqI^ndVP]Ad2^n0mukJc*r6p?WI(f&_W]A)9:
#)k?*N*T_V:e1P97r.uf8I=G*1587'm%$=Sas3Y_3UhO/Z<jIA=2X=I<BbJ6[,q;Ih\ca[]A)
N'=_lW6if+(-'E1MXnGf*5jZjFTtES>?rVG-4;u7pE6.?\E-CR2j1ft2QZ)nj-L>PZom5*0H
1igeT:B:Q"YVh`3ZTmIPYZUg7S&]Aa?p2GcGZ*FNj>80#5*iJ"9-5+MG#;goeiO'aX/<:Z"dI
YK4Br+H+k;)DD)F)h'I-ie@Ce#g:eUYlZFOaGp0P_oR0HeHk[c?rqU'8n!dO#EI<Z$4DPI]Ag
*cVFX$,)Zc,8\aCu:LqFfFgsHoQ%U1"e"[)@]A6DZgnRX5K0IpC+`OlI""3!H.bEML7/XUCB6
ifEs0E+fp=,1%Kb)S7F[<k>$03?GErG0F8IU*k3e4jk<q!b4<iut9sq6@9.C2t5es'TC+1lB
#EY6)QX3g4'g6^Wec4R75HVl1.6e+S2-Q2R'=!:,.t$i>'-eC$!8b]A*8Fkk+&@5P<dsP&%$N
9n^ElOf9lESW<>.bV-QrbNkm1s99n+.?4Bq3;VRp2HBo^3ss#-e:CT?4/Qrq5:q*`UUmSo2)
T#"WN9<ToB#<1e*k=n1$e9subhNCLBSe^]Ah/H!)s"`\2('9ZY@^<KSM%gUb8t%!jfOLM`f$]A
`(nqEX3q,hhFM2$;O/pF@jfB,Mb)Rf>4RAoJRh.6EWJW\=fLf8@r%1l^dfDpJ?iZ#Iq<KqZ*
p^?)17Ha[<5W&kieA90A"^cY=Fcg`o/C#(,bplZ/'HH]AY::Ibk+?3FUMsrFLHa<LSD<`ig6\
EOUZ7*[_Wu1M^HgGkB-0DtsO<LfZ%$fOSto.SHieLS%P-&=jF>j8]A4>JJRK0)6OE/9,tU+FU
#g^=HLYcVA84KaHpa[oo1GEDY-X3'EUk>Zqo>R2VhZ)a/*=8HKscSX_mF(MpJEaf0m(Oq)uH
W%_V2.CqtTC%=aeDoa9EGJ=pS1'9en,juYOVb&MH)s)DnZ4^hV>\(5S0+HULjgK*LX=ah3/p
6F[LCDi8L%)$d>H7?H"Uu`N)Ca;Ts^(,G/=3QN"&a%T_YU"fF]A_&_F]A*J/<+[/F>[THKh%a9
CP]Aab)22:nkEkB^(,am;(lltB6nYb'u^ncf4#%jr*MAjKI$ff,GJALr:ZlrDDWf%\_dQR9DP
"SU3;.e6,7:u/4NSe:TM*qf'0R8:Laf80RAP1?+VQhE"NV6A;HgiULB$^t-R\#kQ>@P,9#go
Udkh$9VDTub_q[9$='r-=E%65P4fdq30EO6.%47-P$FBjK]AQ:5a*e]A!:Q/]A`?u9Z"M83crUs
'8:c5NRQq;+ogkYq"S+)D"B/gUpC1V19%Og[nR/_'fqFp+7tME`5rKt+cXad3"(0>]AnM<0#g
!:oY08%IjMGmMRl)TZAL,3e'@Uk6Pq$!>T9Or#:K?WC0Tk?0u",O1%,F?!Dae("UjrRXi2CE
)$WNYmAR08N/jRn3X:rG*8)!PMeO<2#JMCKf9,l#,/m!/ZRH,E.)^c@!f=Iu+:i`/Pm,jsn@
UEuK]A8DH;fTC57m2MhY-LC]AJ`_i&.n*`oF<1PrR9h#O&jcRZG.]A4:Nki"kcX>f='ff+5'[R4
=/hWnoH+8d>sIY3=<^?b>l0N$=FJEa^[;D)&"k6$!D!*<;/#Bj>jM`1qD5;V75(^_1,VR3JN
]AMA;_HViLfl"oS/?Wrh=2(==A>Km2Z>T9.@&d^H9l>Tne"!:I:X35+65U?&!hlA8-O%M5\TP
aE5t'tB"Nc"<:KPZi\O$h!%t,+.Q0Yff%CF:&<hMn:JapeO#8o<J8p%9X-L#DlAn5ahRV#=G
k:aDpWk\2g_sPioM;3*?@A]A?XfZ`b4?T.SMViK'1*g)B9)o/d=%'i@ZNW@2Pp3g[,q^/6;eq
Y2I+#ToN0%/*-NRR+.CN0)E6+-Eh;s7#I)C"P6?@jN@9I+C8?'X`ql)[h@NP`K94)6>lH@I6
1oI<-V,Z"sNB3pQ+:kXjZcdL101Rlu[FDi6`iZAsTl!;!W1B4?q<EbJ6NcV,Gm/gJ(QueD57
h'q7Q8a671rp\504f8aH-NK:c*YEm<E[n;--UKC'MZ4D]AETqf3KI`a,eaiYjR&>Xsb[A3lY$
O*Z#rAbZMB*`#5S?&m,Q7!^[nM8Cn:R9jc'QQp?\4;;I]A,3P%'Y::jp^O_ZSu]Aa'1&MNC_8U
cuqk`#/bFhG(:sYSmG^$j/)'kCAVrUWOl4uSFDiIo1[_,Zmg@C)2#(J<<$;PMW&n*$Ug?s9(
bR#8'ct;S-(ISIOKHrL,6Gm1cg""SmM.otJ<742rA;K@He8N'hGrXFdlZ7@DdQI!6RYaN0@E
hC6V1*@FKV,K\@t.EE!eMV!p>3hc/.!T!rcf'U3%cphMe'QqqDJ5[nZcame'2dr5`oW,B,;Y
>&1\bOD43<!76EZ_)d\\,1LAEM8<E3T$<uU4g!ucu#5W#.Xk^[3QESifCY@DnGJ,o"JoQe9E
uVS9q)+'Sb]A(tm(A>7aTl6TZR\3i@LJ;AF&?rq:c-`8!,Z[Ij:,=K]AjT8k-E[Etr0^gC,c0-
;UW\&U?5GY#->CK:p6+t;$E(OhZCdRGK%8]Ak#.a:BMiH9:<e)g-Kd5Sp><t]A6:/3ak.IRoiZ
cp*nbK0.0$69g;ac9/ui<IQfS8lRGc:3Ws]AA`cH(@;+mgT#:E'Q1b*UhNCE*asRE;N_LX6XG
FBGqt_)K2?;#fG=g:C@E3I3rm<TC.qV1A(1M4L1lcECjC/V.0'&+o_a7FJ^]A2O.oLj8^G@-2
;K'jueB8s`N/^!B@n)0l)FT&P=\6iA6'G=+1CDHKpKCni<>Jbg@Tt:ppmIjQCIu)NsX16\9p
U\BUrK#<Z#L6A%+jDt>N_lUf9;@aQq6MT;\i"Y_$*?"LRESo5?$9f&=j6L$r2kF_85`Y`VaY
_m0UB9+Y8J8sKp#/9lX3RAp"/!k_#h^A[[-d\NifD&<[N"\lGC:2km>3?H92t?cf&qWHi$@6
;'U\i$'1lV8X-Ci,kcd`o2EJ-&4!P]A;SLDrr*,[N:Fg\fa:NCad*;Pe(?pLC)9^Q7N,NGkSg
q[MC-J!qbFM<ZA/sB.`U3ZD"9t=?2LISHc4.imfOsdAlU]AJd8D,?i6B<g7%6PuADP80BHSM*
(*Q-6mGM0ALHh('"]AD'h`l:^`=6077O%,^?[AnTm*q=qYajOmV6-8DV5ImK&/R?R9;Gnf?5*
99&u_g+S_[na@iP4eWnN,L!h<,^d1ZEFAcb)-QPS?&EKWl;Znp*GCWM52I;BQf]A?DZ=McL5e
h]AfTG\Y4&$baY5^B*ful#EP.1e\L1;5FYQ9IBSQuK_\s`C#CXY3MZ'!r;PdA'qZ^IciKrgAQ
DPe^H8OR1jA;C[\hp''gAQRmSVFC=j;9p<i@s@47iCH^[_']AkkBf#>;JQA>NXrNQs*dj<7Wl
9u4a:Z<dS]A:WOP6h$>h$k[nd(ONV-SF)_At2^%S\M38%*':#O`?<Nk9SgL84;0'1\$:BA*:9
fj]AK>DlC?PgO#+2s*moORnU=,"j-T9#F$fhQp66\2K5dn4biDAuH9MD15V[GU]A[Y`1,9pne_
-j%>IoO@X]AR&-I'U71-!iWQKb[ph0%d*hu*!@$;@2Z\\qhBM2nqOVU6=(^;ID,.eK"@ba"Nb
HD@G5tU_+V!(Cd/u:G$2>1`@NKC;'W[()U!<Sc(&oAB/jDY!TN:sFV6.:"*Xkn0`[PUb]A7^e
iDY_K/+dVZ\D+>l+-!KGc/O(Mbf,tSVP?%q8]AD!ZfA4b[P,UG&?LX,/c<q<dgqcfLRdOomr7
s$lEZ0_:k\kHroh2H%oC7uU7&>f:9fbua'!`l;:+dJ1baD`[a<m+p'#qET+&$$`(`+uO]A_6$
,reA^f6?si#UitGg4(K!u([p,W!G6WsJ+X$o]AWUM9/qoY$COFVKEa@Sd?X8-9qE4>e8/HDak
]ApO9QJcbF->f,b&fA/0DdelCj23diiB:;s%35tVW">YbW9[Sb'a$%dOUi"S9B'@Xfu_JV?o_
[gD+MI;Q"Taphu@7l>e8fmO2UAV_qWrZCJ=)M*3&@'^4T37n+5)_qHbXBk.k=C0)`e[]AXofH
[i5'i&+L(3do+'*^B>uib._K)-;<e`?s9M>'PcRN)+A,JBIk@Zh`Nfa(6deQJlMs(,L?6bdt
CLl7[`j&Om?8Q":VtGiU4Vk#d&)g"HFqpO;-5&=id?l.o2PBdS*q.k$//l,8NYeOLtAA?;Us
kH=O#%^;&iZ<`M-n-Zk/MhrjI44!Xb8)=<f$>TR.*U)Mb,>FsnOZ>cX5S0ni&I"NXRllqJY,
(@m^X66N9lLEf_au\d6:EgjEl\k]Ar/]A+Qp6LR*3-+h#I9Y*::Zt">iI%p#r]A,,[\<[km"HsC
Fr/rDlNL8Rt9f%%/B@3/k/g.LZ_'0Qa41MZYq-0R78GARsDDM6\%ln$q,@2$KK#jXN0>A[+q
\$IW)R+>I)N"FTWfNiOKmb-3aYg1LI,Wq8_>j"AOL74#hL5bZ&AA=mLJ9.<dr>nlug&T0HXZ
U"Xi29-`pPM=]ATu2Vq/#t"m!#3K)O*gJ>(YCM6"*1+#)UN/+]Ak`"#?0sg7i<&u9)i_PSP)?*
G^$$uJ,FQD.bt>+@9K@/k4_TtS8C&`[Vl)8Q&'-oZ-k_>KU<T/d]ACPK%2&g_Tibj`m8or8qn
%>7m)pUg2,iG`(]A(IEV+#boc6UO%%?5%^q+LS!q(E5'P`q3I*f>o[6e[>/hBsEt_Wn3;dn(_
t$-d4M&P'NM;K:VW,2gE;1q"[<3nMM)V4:bL0*CC^8bVW:k)dc[%4HF?bGJ=]Ano^qjgX<1hB
'g&p19XWB%NBau/dh<t#dqhPBbU^O78'5b+<i"Z[APEo*5I0.8McguKV9RK716XohcA4Pb\q
_V^&h6SANs5t6i(_h-1UaC;Vjdh.+kfJi$:K:b57PCE<5#X.+km'.Ms`cUoa6k%=0R4.(0mp
-2:0hqb9PI+p5/7!L4ft_+)k^3kQ0GfNKO]Ad_FO(P9<YDF$bj$0?=+<uEfOa\&NO1+UqQWB'
b99M+6rC0Jn9QYm4Vm",6U"cVuKj!dm/>hf/QpX]Ak08Hi8n^`X]AAe9f3d[+GY7hfRBe^:NZT
1Z6I4XjA,9C^irWV`-hcer#BFPJl6&+9N1deU6s?:uS31Me0r;p-VI-EhrYSD3#kq(eZA2n6
(_jHgd*dH2^5u>B8(WQrE0<09i?B01>ao-$Q'fr^g=K+P\?^G:$7^/Wfq_kd->:>SaB"5@`5
Tdh6#1kaG%i:+c09d;nL8p6`p`.8Y"W46n/9c]A_Y#4=io4h\bHtF0LrW"+EclBjqhg_p>+,$
u"VfZ9Gm$!BpL0e-dO47Bd1!cgDRgsXUu<ChpI$h*Z^IMD?_:5cTr>K#JSXJfM!R9-"IP;u$
/:g50ZWj[f>4j9fjh7!]A3mB)R(tV)DRo]AEl2G*>K0t-u]Al$l4pqHM=9MO*mrFAd_eYS69.E:
5XX@I>L9-:i\ZbFRHmasHXc:LV#)Xou,*PRDn&!^$MCDc.=Dq%$nh?ml.1jtLn>uQ5_N%]AMH
q02\AM"J]Atjnd`f@)#`Y-Qti=!/M4r0<VsBoP./LY`O=]A4u0>K#i[tC"Ou%o[tp^''id%Q+,
:hYTmYu`k7^$2r4VurieO"MP:i595?nDb?+/PII=e$O(%2[B-0_QU]A^4Fgf<D=\f-*6I(+80
iq"j/,FL1h/TY=*0@/q6;6f;Gr4^h?e,sa+In<Z$#k0S..D^#N!*]A:V<RPtqM@RL'JcjRt[V
&HrDloSM".0BH-ks;3EjF#OhooBC3htq@WBk:pN-6Cu9Cu,5VoD4UhXe7L(SI!g:K-!MD?3G
Z;NPW6IKB4<K-?EG2^nMd'ZNPXL7_b#2fiXAGqhPTJo;tbpI=Aa*&)6KTfZV0I+[u3daX+%F
DH;4#n!nKI<.Ea#Jts7TT/*AeHUXLKjm24l+&md;-JO[C_<OLQ,5%Zfen.'W?=Cn-)b)?%!r
%9baHQE_S?j8@Wj<`F*S5PEd_dQ'b:0B13Q_H+i3$tTkXmaUYdEEei6lE8B<>f(/i"aeBB)H
CY9sd<IA:;C=E1D/@B+/;SC#`X@6=quL4$C>n+"$.I]Ac4)D*bG<SsI$e]A"\qS+$[^1D%CY6[
42g0=IM2=;rPbVnQDnH#,g+`0qCV=no^<f8>u1iJBZ<Qq%Ms2*'6/.fip48)4T^cX%QV.(+t
%S*Lk[HcS!?MNTn%h0aF^i8n^T/>$!@Z;)iLUU[7!j5Nn/7)bML2A2!t)IM-<)ZGBB.E3m!*
k.J]A[UrF42`j>-8*a%jWQ>ZVKjtRdLNdmDu6'^kmH$LZ!2N\M=j3YW[CE)RgjSd9hgQ:m16_
7EE8!uPf,4$)@f=#g`q*297<uT@Ve"i-21$>\LJ<DF5D<.fHIbo#uaZjk*qk75950B8#:M0\
>QZ^#m%1gG42m)fL<n!f6eqKc&F4+25%BUk+(*=J(Qa2ZP9epF-:3!^)BR>p#qh&TSH<TjlX
RBPGc!nO&;pE6;'<$YR_q'blUWd67O9+@[=K3Dp12>J(S9cIV?U&'"Xg\uqF%P.on,-1bLP9
S4c19P%A[-5G(hn-6/BFer3_gRCs3$tMXEG_%p$IRDCX!]Aeqg>M,5DJqMlRr@@059;ZM[3\K
U\lM*9?Hk(0n#Z\*h.bI@B\9/RM:s[_QC2VMZV+k,^H^=jrmN<+7j,DEgfT_/*GjW@O=F6it
7r,/=T#^cYei*YD!t0)oh1jp+'gm`+2M6MpKPpT_4tOMo`)LM9krTg7EJ6OGP>B&mes`jO9`
EQg6W!IL/p.>,Tpl;Q%?^PlrZbScW[j)f1.,`/"TCS2W$eBnmjXAOM>_6[F[(UNT)DlWW4a8
[a6J:S)\H.o)j=E<"gu<nriK+]AgmAS1Ee/^`-[]A&^6^CjuiNr\/OkNbh5E&R@.2`_3Mt[V#e
l?^AH%4E2GD-%/"egcq-I+FE!G<*sC#>Q&Mnt5`0K2io^`60gjVM'dhbEN!b%fs1`u-nf85!
]AYim\]A,?g"Buo6R2[dFldbd*klG*cTl9VdTY3T%rnBKP7Vlm[GOM?d^Vaq3n=3h]A#*M<emBq
a\j-\@!$d4^d7"=^nbE00f^?VWpIYJ*0kTbIn,Anj`Ik1Nt"0"oUDR-26WpspNF[WgB.rGuW
-fNS>4'O!Z3fs=l0:/M+=2r!hu<elEJFbgak95";[8S?9CW?F0Ea58W<`---3)I!';+'&]A<i
V$3S<`,1A11K#+[iT8[6f($,p8!KN(Q@&:X%J5]A$I5&A26F!Sbb[+TX]AQ,,`']A0pH/2MJ!n4
c%dJ]AtYBp(2g+HOUhFV+f5R;&&PEDS[/4khSMSA%]AOgf)fmO'kujC/jiaoKfkZZ75Z5/2gVU
A!0CHT&\NDAIiZMmObb`\6`M<@OgtAZ)OI-CiZo,r[tM;5*11<.p?^Y^plmsNY>+9NG@0V8U
iSH;-Jd)G,_^:%d,lr0!RKM"'J\Fa%ktBO<tof):b!Q314lgq6q,]AN5VK*)fdD]A>aT#T]A$O:
ikUIRn:\(MTFJdo67_KT=3GQ.WAlf_FUp?Oq(H6I^n,\S+H$rGDl;8?3[u@1eP<64?gR<KD!
-0ukSVPA/a=-!^`\B7c/[h14'M&:.Jm9dShWenpd=%hi$0Rt&$]AOskpFJkSJOcr]AU%h)0CZe
S2_6q5A?l3r0B[0Y@f/M>cW2A1Y3R^s&#64Q$N]AmSOI6"Ja<XZ?ZJ\G2cjN+[#f%fjOSb$aD
L9012O[XmspB+LgZms`3a2.(3It_.%!P(HR(4f0l!Ns]ADTg,q(f!J0@Uc-eh\rbQnA'%%7f_
[c:j@'%"Q683gSDA$VDLPiR*Z`8VL5c%ZZn1^^n+)6M1^BS/=fuGWT#JFO1VYNo56[(Kga[4
mVeLTt=[AYu*WujT>E[FGT3ZpCB_`H>TY/!s$ZUA2$[^9ubpY@j-iY@"H7R;9#LW?!'Ukk47
/jF4J\L9c/F!l[eY7i-+Wij-;TbV`<RC`ppa4%\JJg/gh\h'GjM#N/1d35L`=Pg3*EZ-rajY
<Bc@HC;K:s_%jeSq"/?p=q$4\$:VT7Oh00`TJ?*8uThu2@cl+gTOWqU;Rqm@FF`M"5d.)1c3
hqW.Xj0'Y@Ir:j0DU%e?^a)q`^#7eU+RbV,i0:0U)a%.aULn]Ag9FWL2_nj?$ia3*cRt:@#_q
Y%74=qf(JN8guL5M!XRAjgfk\/4W2,3c%Y-L=H'1/BK4rB)P@%=R9@Ue]A`qXZ,n*?QtrJ#lq
-SUA(7aeG:HhXuPs(gEh^TUOR[5d6bW=5UsF"%u#n;<Rg]AVYJ)4/OgGP\Gr-A66?lYN"K2Pg
Q(("/;]AFi59`/!+'eVgk*@ft!ein,eZ,V5M:67$=WG+5;BOg$i2C_h?Qm9591u42]AUjZHL?6
F2"g$O!F+)e2+Gtf`_`EQjXG#n3CW=Ph(Y5`..>1J,?H1H$bS;!k9ge6scS,X44b/to%llLr
Io2ATajo[BiIH6cA`=+YjO(p-Y+7=?6r!!sTXF4YfR!YoR.0(^RMa-aqfpAk$H+,B@s\OADh
##Sp?qXi")'N;jfRt.ap,Itr*,=A45s09&AO:j\9guig<Uc<VRacl2af^:m<Z4cJMRpmUWlR
7$%PCtY,`LDl2h<i.PQ5Q/:chWr"]A:JY.[cO.)((D@PT!@p+`bSE@S7fJ5q*R[NW2=N+`_+`
#KM#!Hc,`W!Iq[ol?Rk[flZ"_g_\%!Dto<aO']AXrY^7qB*#u+J%2;;=4%Ni8lUa5"QK542$q
J/mRKYK#ToF4eR(.#W-4m?ghRHl.,@o<(3=BIc<cS'qHfV0ht/)1^77#XG22t0%N&28mu'u(
M"h7ZaI_G(bF8L#5!h%F\GMkI+@D_Ki^PcSH\j&PHSN]A%KhNg0"f'B;4h\fR'[=\D1.adT[u
OKY7g&Im;$6@Q`4B$'@Kqo*&Wbco(:%61CWLdL'PK,^mcD(;G3JE:f+n7JB/j1Jd0tZj?<+T
NJ=X2UI%D;PnG$u*-UnrtP9]AD?dkDuf-i*1/K%jRW#kYHG+5<T:m+jbr)3`n#bkrasQdA&Np
R\[\!m?8:5b"Ks#1uH4Wik&7SF[T/TPm((Um9GU'0M)O"meSbBq7n-:r$Jf3C,%S1,/h]AZTq
WjRBSRC8gZWDF1,@-5%?%VqO(EO>?'k+Wgfi?GkC#NoIlZLU7l`!RNI9UDA+#Ap,XM*5C.Xc
PL>W%JQ8#B)he8Yr4oKkoI!70TcQ-,2P"Ch@_2!5nXEJM">JQ<!kO?c!?5uP*u#Qh!cEEm7%
9VS[K\7:DOU*Z;'e)C]AW)[g1+O=U::!C_!uf.TcRCG(%NL\tng#ouGeU/N(dN"Hf.36>YBUt
tLjU/=QuX9E-fK"m+:]A/[U+(=HInRgPprT4[/B+O;L.=$k;HEg"(BQ'UC"X!";rjlm1<mH@0
r4+ufCmh*>JpN0s-]AtHMG&ilZ1-.9kGEfc&_&=;?/FVVC<r#8o[eimkWshh9nEYk&NV",j/:
$%>tCG(7E4'.1TWj`B((Qs.!c`T,(bAXYHdE+lO/RO`^f;N/AHd0HaF&\q'Z8Fh,02?`kb5u
/Zlobm8WFSWW0ee#MZ2@,>#D__,V^!&VjX:HV[g_e:^Z(Xiprbk8`eGku]AsFH3.ZM+/]Ai*iW
W2"m;0d8_mu=T[M&c=?/tZ0&%W=^:OtV)Tid<=rU'$/C?l&L.c&+W`$d29_,u@8;;P3Tfi>X
@-7DfE`s<SuBk&Z>#?-mJ_j/tMq'8lhDL#W95$-;;Q0i>p$;AUm.?B,A#+G.@]AS67BOaR=,K
IT:J"c)2*m8:h0M@nj[$f<3XX)7ql`b+VAQh[1RPETpkIe4dDqb&ER@CGui4);e5=_dM18`?
<N(,a*#i1`TQTl4b+abMn4XK&RcN-._A?&#k@'id#A-E)ML7<N\:(8\JnGG(j,a=E;c$aqRs
&6_1PBUM'XI8kA5*a:qs9shG[4]AT$tgh@ZWMDpJTYW8\Q"!!(Wonc1j6mhG@-Z,G_6km.nDO
0CU!2G.e6q(O_[f55(iLhtZCA>YR)9kf-]ACZHM1N@*EE[G$LhV0kZo7i<%e>bh-X*!-TpkYq
s)P=siUhmOVQA<=M\pYd3=_I<I7urT6AD<i^Mh*8FnVX=f]A;Xlp'l`m<_,aVs[_q&:D/Au4+
X2[$DN6XI9HN]AY]A(sIF)D*1MAm1O1TY/i[K)'W3dk]A6Wj-+$0n::IFe?.]A)ZphE_b7S`6hLq
o%MjULp*[^d.=XSJf?m@miQ&F!RY.Sa;#i/,f8-JZRrKtZhl[i,R9khJ(=FN*5EZt]AnlFtl^
.e:ZIe@a%u'"H#b%C'YORY`_Y_MTVn=Z(5eUXW7UU5Lk]A<SLbPoq1UC\qJIt!b&*mZ/k12n=
$D9n"VFJ'4X/ritYX3Fa[KP,XUNg+7<F0`m<FF]Ao'_URM*q!X8<LnX&[Y+;+C#PE`0G14593
0>k'G'0Ap_#b8m18:.fHWQ]A?E!+61P:`+hFo"A:$?05DL&\VY;cAgG4IUHC1&fQL,[==AI'+
"DP@OlVpUlmWJO$!>VMp2KIT]A_Fe.`\CBscDXi0V>%gTZKe^h(3qXre18&Q_p>:aq/0)/[j'
%e8rnP`*E>%4\VGM,1*6J+@K$i$78@G-BTo^BaETf.["U+!EO3FGX_N<EA<'#a)@=5m<+j=s
eN\WPU0-6!W7T"Qb=%9L\U_pKEE:t&ddR"sR;E;s]A8mUA]A-@=Mh8e:uW]A,l#ljf"o"a'c_YH
Cc[kA$uA@sS1/)c8J50.<^Pe"VXV#'a83ZNs'lje]A#n(h-iq]A&c@]Ahh:_l9BI4+VPU2qg0Wn
e0>_iEK:_7gpiJgi7GL=m?$TGX.hH$siE5<#Wb.5B_VmO-K(X0adTKA0(HK^%B;OG62YFQp-
./k55$gm9!b`GA0@+eb&9D[/r"OP\[fVeKZA13jK69:/To4+1DCr$PZJfioPOgQKVZGdr?Kf
np>?gmsc\scj+ee,6jKS2Ks*RbCSW%R@o4ImuKX6jKhU6K)^*Ra!aE\:+.Dd9UgbXXak,J:h
$SLnPUecBZeY<?L]A3^I"lgk+hCL_1/H?ml+fCY1>T+C582`NeW/rp^QbDHphZ4)DuIX;8&H'
SJ\d7D]A3M[GXlA_dXZ$!2MA6l#jpBpu'<j:lg'm7bn!HI!X$\QB[ZQgS?s/\6J*C>T8eO+.Z
tdXF,;0K[<%U;WVb'chte'UQ"[@)bS?!V]AqG(RW=JpJ<_]AST%Q5KMTI%VN/[imm'SQLb=7h<
"T,cJ\`(R(]A:8CG"k&hmE,dgl6]Akig<WB.R_0/6e@&6;:3o^6[nMld<$%e?2I975"^u?VODB
>Wai"H<GI_D\]A3lue-V;bTg[_F2b6u/(Y^MD_mTmp<r&d$@1k<.aJ<G?MpRn#`g[.oIg8I#$
Hn=X?>hm%O?IM/@]Arg+pXW3/]ArJR?.qtE[9l2rZ-_OjWDKdqr_5+B^Lo(lP>#aRI/R-!2a,Q
<lDfB(A/R5sV\mn+Zm/IrE`W<>7EMU\LR#oI-uLUtV7*=A7RcABnAj;H_0/1;o;L>taphGm5
a*/"Vo;q9Vi4tlC"-(&N++S$"qTq=W%2qgPLO.7%<bd-3`g0_*Qh8JCI]AoJ$#P""*m`A\`So
6sl+]A)XY?6,eRcD6MktE99-q2"/G\O9l\[Pf'>rfF>i:/TfPN-A<M*-=:(,:Rh=m!69nQS7-
=j&=d,G-tnU5dC9L6PB>@GZZ-Y43*lK:HfC.,\.X4pV<nCm;/UXLhQ"1hi_se;YR\n+;74*V
BK-ZN/K<qlebH,i$Lf=ta0Z!J$r^]AA<@9`fkrelpRdn"%CREP!9/S'aGs9^XF+`*ccEA"/)-
!CZ=_g)E)-07eS7/[)76!ma*;'RY?n@3UnL^$8&T7"O@VTT5\/7XQG'K,D?:#=8A"]At2j4Sd
;J!)sVg\=/I?)p1GDopSJj!_QFb0C(:]Ag+WbI#N-BI*4Nm,P[YAF`4PF@CFN8Eqh2#dsG5u6
.=07*n%LH!;GIt=LeR-D24LaZ#V]AK62tQnU(>?"Ns>`nJlr]AYn"-AP$_25^q/-'5mg3Ne"iU
Vj+$O<PW.!D,*"GajaCXBi`U+T`O*`bP^?E/[jr58`q!dCJ`qjMiXe%K]Aq#b0R.D+fKDoF*T
KKoFCW6)jnF/c9_;eE2ceQ^s&\l)bXok">nFY;2S+ARr>AK`b@H?ul8Xid9iCY=+^W**D;XS
jpeTSZf:o[kpV\S$&\#GAEW=uZ-Z4d'66h=Z+"V-6LoV[SgDabh4l9Vi!f2>`+cp't"I%knF
!D+dV1;Ob4q4_(t[=e9Q_e2NNFIX:Z-<;.-Le02n4("<YnnS)^H"'JU!R&ddRY4K,gZ<dVTk
`cmtmilf&EI.FbCA_Z<8i$="N`N2^lUE#SNq;qf$[t1.km'!tpttQ$H-Lru\CL>WrnWi2)3.
U;*5EAjE`MN!LTZ?8:=C:jQ%SE1$+^\WUuU"VjRaN.[D#p:VE-lIb<:m7$9-F`poWl2?p4;-
K9,92O`o3T#g2e.qoT-?QCdL^SRsj8L/*Sj\,me4J+^DniW,199mc'.&amD?4UhBg?<$%T/5
s*CU.;RRFqZt)9#<*F"SgdECTpV+9`cP<V@E%od5PBqjtTqk2O*s0J>@>fHHh'!`tEkuTh2)
uoDmCWCPFUT@.B*jis@iblEkBTri<e^LX^dR*IlghhaD]AXL]AAaE<'&;d;^[rh>LM=?4#%UYE
Im6f[LKFkrR:iJ,UcCb"MC,s$#CPe4KZI+Jf2Ee%SjT1m>`[JA]A1DJ_%b@26a'86Y=s;9"BO
sAKman/KO%3.PlXc[XA=s,]A83bMbG?H=VFO7&;T>o>r`H:@([@d(2cre>*bHi/<kG*bFV$*i
,PXB3f*A;D-QI.Z^$FcIE]AQ7imGeB91gkC8T8X"C$^U+R2<V,(]AfadK&bGgrqgRsH-K_#eG$
OL@[1!KckZ7UncbB,U,pR!mn%Zh=1ii5i?[<\^3Vd+/$DYf_*s7"[BC5+t3qHisb:c5$VKmP
Pj5\MED[-b*,Q@3'j.>q0)XLQ"^dcMfV:J19m=Qceh-7*j2G#_[_G0NJVLAn;iB6K9j6(jVd
'(3>M3/k@ouG^oX<T"bV).T?3ad#]Ad470.g^ki\]AeoFBXiZ%fnu%p<Fs'"s=VQ@C;W&Tk?J#
^'CI/c%r'Q)'lks?;pqs*o+hdYbnV4c*)ZOnMEkpA;;WdK%XQ^oOKa*>n)A`eX^3sRJ![X,i
)/_/&YP1(T?N6>DM6g=c"?2Uh`&:*_lJQ5SYqqi;6N#i7*<Jh,7#1S#;h=cR,5FqBnMka_FQ
(ch#4)9?fM+iXF?c4s^8kt'f2>s5L+Z%\S!K!WDVD:5/g6kP[nPS7;k*WcF?aBk.?odj[%Qm
:)'=J<6V6]AaD>psuQ2eBC<5K9H.1(s8BuJCsf5GT`2h/M61?g,fDen#/4$'(_rC`28S_)arI
UF%^6PV';CHHKDqH_A0DA/dMYmLkk=-lrV#S/Po8pJ%SZ4"&i`2WOR6bdN[4f2\&->BA#!f+
2Iq1?1QKiuq@oSEQ6"Xr23=Yh`\"f_@Cs+"&HkFkJh#!,`ZK<d_Hem$!=,?=kslbk9BHV<5P
QN*X5=uE`:@=rSoJ25omJo(h27S^LWkpqO*N//Zks$H4:,C5!]AWc=JuaYVo)NrmU;V:q?5=i
^F-.YS+=:j.SJ$>g'me^Jq78]A4LmKG,n_1A=.QoUOMW-p)m!"(+#A)QaoH[,g,8<On`b-YZR
#I!a-:<CU(DJ]AgQWo<dcd2%N]A4gmSJnAcn:*n4=74e\+oP#ZC`W#"c',dWhKr'gb*@QV53l4
Cn3ugRKNdlc0b&R_NcFf3/Z!5kUs#JHO^Q^F]AMJ_&-DIof.g0?gi-'p^c7Q=f_UTZb5T<Y*k
CRG@:0VAQXWV,+/\O@j>p4$dSt,DH=0R4>V[@M[!59X'/ZA:TGt'I*Ut+STZ<@YilM^3^3qJ
+G?a_V!ue&c/^<LJPr[Ya[=TO2M.,+1L+?1+%n\&i2cEP0::m9ITlGkQ1n1O9:Me49H9JZVi
bK,Ygf5s7pakb-7"%Od1"tIQL!^GcV>1FHlY]AY2@@W.!NYmiBsnGeaYHu$MS85#:S!g3:kVj
A1M[*/LZ5uf.','sG-$?uhroZKFQLj14@S*C@CiuM0=+N/c?lGt:uh$Nn)'[[F!^SBD3rJ"s
%.[_3fpn%)]AqmC;Dn;PImSkq2)R.QlXFq0iAgl%>RJDP>t-*SNjRhJ(pX*.%*&hZ=kJV.dl.
>L:VI,lk.?p"857V8'ZDN]A$h(hrYZ5oq?5E&8,SPMT%J0Lq:&)*^%4[`\:IKq8Y5"&Pr;Z@2
.ijh5Lk244g+qc$;@*]AdguL"FQn#L+8/uW>7M_M^_5bSn?]AY>h'LZL'Q9V,i`/]Ao"aOHu*\t
cbJC9UV77+hpc]AH!4cMo*<j7/inK,g0'7>6\d&pc!Ki_&QL`o=#-b0]AEO8)BRA_e1.)]AOg=3
D]A'u#&D29OKX";WQ8uiS!-J.TP)SSCFlL@pT8gR^@EtXX#_,?[03/j)h:#;O)PlSPnk<[bm6
H]A?*_U=o$IjfaGohF^#bH]Ao>(%i9O3(%i6`:S)5nH`CMqiYj`Wu>j-7&mLbG^[pYF;\e"o&\
rNR&u6j/for\cE6f4<gfJOSAG7CZan62:8/NamEAQk$"f_-7.lPs3bEmVIK*O;QS\6O[rK$p
+Fa8L8eLgYYZUXQeflbP36GF44[nF%#(@b6`:5?XHQ6b';iSTF<csth/7qm<*pY*H:,PlPHk
%kq79aJ%jbebr'hG;BW,GY),VtdD/)d9[D\,/K3?:RA2Z>e]AR/^-#3NYmIgHRM@`qYTI0>1)
#pP35Omu4MD0X9UH8/S\E[&WI_bju.QGERW8$Z%^'Tae3*#8!"p*Xos*1bCEh:r/9jcduB!]A
h0#.%[C@Tk(dekd!7bmBP"%pg$R9oe\+M@1a5>1$2!]A.']A),a5RC9177gIq+uV4Ps.&E3!gE
`b^F2/C!D!/cZ8,5u;mNohnt4+g-RX2%!`T@Hea8sQhWiEI:Ic\?S'sJd3RJ=BL(51CkH&RS
JXiJ:<YS<k/D&V9Pc-&sZ1r$5UD8IgC7_G99F>:h`dUr/a6R\Zmm&RV:>P6NL*?OPS!.c`Pi
!?&fH^cZJg0t:L_X8^X0GXS@jbf4GL/+G//=*S+C'SPmS9#<Y8,WUj4dIP_pI!!9%0eZ;e8%
52IqihOg4X"7b"5Seu=U?>,9S_e[4n>MnXZ^$iD4VqL@[.j]AE&s<n7VMiJ&Wf8k5kTq<;hG(
RGJL=SYFf7;l)bX"JhGl&s@i@=GG)!I=6kZ,+8?inQK&Z(_q#EYc$3/SJ?$iiKG=!L6OHWWW
2a[&X$G&!d(d%l)K-s&16,ST%$^0L^NY7H_1,Oo4'DTW&RFHeshkMHMn[_""k3icsG`g5X42
0mseu8_NpRC,f.78PeWU\Uc2)&M!Sf#fmRMTu%%Q&@Ak?-3WHDn`3Ffo1FH667=3Nrs=AJY8
L"/6g;OiR9)Td:Ym6CP\X%mk$L?%IbH6@ru.7".mhi0:l9iLO\`:#]A[1T8OFYsfcm`)HRg_J
lb)$aci8M%j8JrRR$i6m:>K7Ff,-Su_R!4\#`!0ke!=2D!-NhFfZP,?+KcS)fh6t%U@CCYZ@
IXdG@/gpkpcAh@;j5.KrA:6>W&u3'b_$X=MM\Q,9QmA+ShOZcm<,..:u)p?B(_0^1K%%!5Y/
n;G*5:^+'N7kY6$Q>H_%BcLGpWGbBh_&h9k$#2ku)2M6G2d4&O;&\C%Miq<\D/s(`LIQoitO
jP2,/S:<!N]A&ur*jIah3qWG8R3G!S_jVosA^sr]AM)*R<E)]A5Mt:$E,;Up+`a#]A*m98bb'$Zd
Zin<>BRQFW+k6[-.r[EnKN<"b#ZSOIK;B';+H`#ld/FlOP6sEemYs2<9,*g)LCfTAt[.hirN
UoDS[h~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="183" width="375" height="146"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report1"/>
<Widget widgetName="report2"/>
<Widget widgetName="report0"/>
<Widget widgetName="absolute0"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="1"/>
<AppRelayout appRelayout="true"/>
<Size width="375" height="720"/>
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
<TemplateIdAttMark TemplateId="f08738c7-6b97-45ef-b7ec-55ef29386b7f"/>
</TemplateIdAttMark>
</Form>
