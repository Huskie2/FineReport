<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="正班-航线满足率-时间维度" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
 t1.R_VERSION_GROUP 季度
,left(t1.R_VERSION_GROUP,4) as 年
,(case when RIGHT(t1.R_VERSION_GROUP, 2)='04' then '夏航季' when RIGHT(t1.R_VERSION_GROUP, 2)='11' then '冬航季' else '其他' end) as 航季
,COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' then t1.id else NULL end) 工作日需求
,COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') then t1.id else NULL end) 周末需求
,COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' then t1.id else NULL end) + COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') then t1.id else NULL end) 总体需求
,COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end) +COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end)  总体已完成
,COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' and t1.R_A_NORMAL_DEMAND = '0' then t1.id else NULL end)+COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') and t1.R_A_NORMAL_DEMAND = '0' then t1.id else NULL end)  总体未完成
,COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end) 工作日已完成
,COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' and t1.R_A_NORMAL_DEMAND = '0' then t1.id else NULL end) 工作日未完成
,COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end) 周末已完成
,COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') and t1.R_A_NORMAL_DEMAND = '0' then t1.id else NULL end) 周末未完成
,COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end)
 /COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' then t1.id else NULL end) 工作日满足率
,COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end)
 /COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') then t1.id else NULL end) 周末满足率 
,(COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end) + COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end))
 /(COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' then t1.id else NULL end) + COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') then t1.id else NULL end)) 总体满足率
 from dwd_foc_ft_nm t1 
where SUBSTR(t1.R_FLIGHT_NO,1,2) = 'O3'
 group by 
t1.R_VERSION_GROUP]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="正班-航线满足率" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="pa"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="pb"/>
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
<![CDATA[select *
from
(select 
 t1.R_VERSION_GROUP 季度
,left(t1.R_VERSION_GROUP,4) as nd
,(case when RIGHT(t1.R_VERSION_GROUP, 2)='04' then '夏航季' when RIGHT(t1.R_VERSION_GROUP, 2)='11' then '冬航季' else '其他' end) as hj
,COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' then t1.id else NULL end) 工作日需求
,COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') then t1.id else NULL end) 周末需求
,COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' then t1.id else NULL end) + COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') then t1.id else NULL end) 总体需求
,COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end) +COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end)  总体已完成
,COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' and t1.R_A_NORMAL_DEMAND = '0' then t1.id else NULL end)+COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') and t1.R_A_NORMAL_DEMAND = '0' then t1.id else NULL end)  总体未完成
,COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end) 工作日已完成
,COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' and t1.R_A_NORMAL_DEMAND = '0' then t1.id else NULL end) 工作日未完成
,COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end) 周末已完成
,COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') and t1.R_A_NORMAL_DEMAND = '0' then t1.id else NULL end) 周末未完成
,COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end)
 /COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' then t1.id else NULL end) 工作日满足率
,COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end)
 /COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') then t1.id else NULL end) 周末满足率 
,(COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end) + COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') and t1.R_A_NORMAL_DEMAND = '1' then t1.id else NULL end))
 /(COUNT(DISTINCT case when t1.R_PLAN_TYPE = 'NORMAL' then t1.id else NULL end) + COUNT(DISTINCT case when t1.R_PLAN_TYPE in ('SUNDAY','SATURDAY') then t1.id else NULL end)) 总体满足率
 from dwd_foc_ft_nm t1 
where SUBSTR(t1.R_FLIGHT_NO,1,2) = 'O3' 
 group by t1.R_VERSION_GROUP
 order by t1.R_VERSION_GROUP desc ) t2
where 1=1
${if(len(pa) == 0,"","and nd in ('" +pa + "')")}
${if(len(pb) == 0,"","and hj in ('" +pb + "')")}

]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="正班-时刻匹配率" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="pa"/>
<O>
<![CDATA[2020]]></O>
</Parameter>
<Parameter>
<Attributes name="pb"/>
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
<![CDATA[select *
from (select t.R_VERSION_GROUP 季度
,left(t.R_VERSION_GROUP,4) as nd
,(case when RIGHT(t.R_VERSION_GROUP, 2)='04' then '夏航季' when RIGHT(t.R_VERSION_GROUP, 2)='11' then '冬航季' else '其他' end) as hj
,t.aa1+t.aa3+t.aa5+t.aa7+t.aa9+t.aa11+t.aa13+t.aa15 总体总和
,t.aa2+t.aa4+t.aa6+t.aa8+t.aa10+t.aa12+t.aa14+t.aa16 工作日总和
,t.aa1 总体完全一致数
,t.aa2 工作日完全一致数
,t.aa3 总体公司早于局批30分钟以上
,t.aa4 工作日公司早于局批30分钟以上
,t.aa5 总体公司早于局批16至30分钟
,t.aa6 工作日公司早于局批16至30分钟
,t.aa7 总体公司早于局批15分钟内
,t.aa8 工作日公司早于局批15分钟内
,t.aa9 总体公司晚于局批15分钟以内
,t.aa10 工作日公司晚于局批15分钟以内
,t.aa11 总体公司晚于局批16至30分钟
,t.aa12 工作日公司晚于局批16至30分钟
,t.aa13 总体公司晚于局批31至90分钟
,t.aa14 工作日公司晚于局批31至90分钟
,t.aa15 总体公司晚于局批91分钟以上
,t.aa16 工作日公司晚于局批91分钟以上
,(t.aa1+t.aa5+t.aa7+t.aa9+t.aa11)/(t.aa1+t.aa3+t.aa5+t.aa7+t.aa9+t.aa11+t.aa13+t.aa15) 总体前后30分钟百分比
,(t.aa2+t.aa6+t.aa8+t.aa10+t.aa12)/(t.aa2+t.aa4+t.aa6+t.aa8+t.aa10+t.aa12+t.aa14+t.aa16) 工作日前后30分钟百分比
from
(
select 
t1.R_VERSION_GROUP 
,count(case when t1.R_A_NORMAL_TIME = 0  then t1.id else NULL end) aa1
,count(case when t1.R_A_NORMAL_TIME = 0 and t1.R_PLAN_TYPE = 'NORMAL' then t1.id else NULL end) aa2
,count(case when t1.R_A_NORMAL_TIME < -30 then t1.id else NULL end) aa3
,count(case when t1.R_A_NORMAL_TIME < -30 and t1.R_PLAN_TYPE = 'NORMAL'  then t1.id else NULL end) aa4
,count(case when t1.R_A_NORMAL_TIME <= -16 and t1.R_A_NORMAL_TIME >= -30 then t1.id else NULL end) aa5
,count(case when t1.R_A_NORMAL_TIME <= -16 and t1.R_A_NORMAL_TIME >= -30 and t1.R_PLAN_TYPE = 'NORMAL'  then t1.id else NULL end) aa6 
,count(case when t1.R_A_NORMAL_TIME < 0 and t1.R_A_NORMAL_TIME >= -15 then t1.id else NULL end) aa7
,count(case when t1.R_A_NORMAL_TIME < 0 and t1.R_A_NORMAL_TIME >= -15 and t1.R_PLAN_TYPE = 'NORMAL' then t1.id else NULL end) aa8 
,count(case when t1.R_A_NORMAL_TIME > 0 and t1.R_A_NORMAL_TIME <= 15 then t1.id else NULL end) aa9 
,count(case when t1.R_A_NORMAL_TIME > 0 and t1.R_A_NORMAL_TIME <= 15 and t1.R_PLAN_TYPE = 'NORMAL'  then t1.id else NULL end) aa10 
,count(case when t1.R_A_NORMAL_TIME >= 16 and t1.R_A_NORMAL_TIME <= 30 then t1.id else NULL end) aa11 
,count(case when t1.R_A_NORMAL_TIME >= 16 and t1.R_A_NORMAL_TIME <= 30 and t1.R_PLAN_TYPE = 'NORMAL'  then t1.id else NULL end) aa12
,count(case when t1.R_A_NORMAL_TIME >= 31 and t1.R_A_NORMAL_TIME <= 90 then t1.id else NULL end) aa13 
,count(case when t1.R_A_NORMAL_TIME >= 31 and t1.R_A_NORMAL_TIME <= 90 and t1.R_PLAN_TYPE = 'NORMAL'  then t1.id else NULL end) aa14 
,count(case when t1.R_A_NORMAL_TIME >= 91 then t1.id else NULL end) aa15 
,count(case when t1.R_A_NORMAL_TIME >= 91 and t1.R_PLAN_TYPE = 'NORMAL'  then t1.id else NULL end) aa16
from dwd_foc_ft_nm t1
where SUBSTR(t1.R_FLIGHT_NO,1,2) = 'O3'
group by 
t1.R_VERSION_GROUP) t

) t2
where 1=1
${if(len(pa) == 0,"","and nd in ('" +pa + "')")}
${if(len(pb) == 0,"","and hj in ('" +pb + "')")}]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="航空执行率" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select * 
from(SELECT DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') AS 月份,
t.flight_no,
t.DEPARTURE_AIRPORT_CNAME ,
t.ARRIVAL_AIRPORT_CNAME,
concat(t.DEPARTURE_AIRPORT_CNAME,'-',t.ARRIVAL_AIRPORT_CNAME,'   ',SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END)) as 航段,
 #条件：FLIGHT_PLAN =1 (标签是字符类型用'1'，数字类型用1)
 #执行率
SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END) AS jhhbl, 
SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) AS 执行航段量, 
SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_DELAY ELSE 0 END) AS 延误航段量
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_CANCEL ELSE 0 END) AS 取消航段量 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_OPERATION_CANCEL ELSE 0 END) AS 营运取消航段量 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_DIVERTED ELSE 0 END) AS 备降次数 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_DIVERTED1+FLIGHT_DIVERTED2 ELSE 0 END) AS 备降航段量 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_RETURN ELSE 0 END) AS 返航次数 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_RETURN1+FLIGHT_RETURN2 ELSE 0 END) AS 返航航段量 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_NORMAL ELSE 0 END) AS 执行正常航段量 
, IFNULL(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0) AS 执行不正常航段量 
, IFNULL(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0) AS 执行不正常可控航段量 
, (IFNULL(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0) - IFNULL(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0)) AS 执行不正常不可控航段量
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.AIR_TIME ELSE 0 END)/60 AS 空中小时 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.BLOCK_TIME ELSE 0 END)/60 AS 空地小时 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FOC_WHEEL_TIME ELSE 0 END)/60 AS 轮档小时 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.LEASE_FLAG ELSE 0 END) AS 湿租航段量 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.DI_CHAPTER_LABEL ELSE 0 END) AS 国内航段量 
,(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.DI_CHAPTER_LABEL ELSE NULL END) - SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.DI_CHAPTER_LABEL ELSE 0 END)) AS 国际航段量
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END)/ SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END) AS cql
,(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END) - SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_CANCEL ELSE 0 END) + SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_OPERATION_CANCEL ELSE 0 END))/ SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END) AS '出勤率(考核)'
,(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0)) / SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) AS '准点率(全口径)'
,(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0)) / SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) AS '准点率(考核)'
FROM DWD_FOC_FT_FPO2 t
where DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')=DATE_FORMAT(date_add(now(),interval -1 month),'%Y/%m')
GROUP BY DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m'),t.flight_no,t.DEPARTURE_AIRPORT_CNAME ,t.ARRIVAL_AIRPORT_CNAME) t2
where cql<=0.85 and jhhbl>15
ORDER BY cql desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="TOP 10 航段" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') AS 月份,
t.DEPARTURE_AIRPORT_CNAME ,
t.ARRIVAL_AIRPORT_CNAME,
concat_ws('-',t.DEPARTURE_AIRPORT_CNAME,t.ARRIVAL_AIRPORT_CNAME) AS 航段
 #条件：FLIGHT_PLAN =1 (标签是字符类型用'1'，数字类型用1)
 #公司范围指标
,SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END) AS 计划航班量
,SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) AS 执行航段量
,SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_DELAY ELSE 0 END) AS 延误航段量
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_CANCEL ELSE 0 END) AS 取消航段量 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_OPERATION_CANCEL ELSE 0 END) AS 营运取消航段量 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_DIVERTED ELSE 0 END) AS 备降次数 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_DIVERTED1+FLIGHT_DIVERTED2 ELSE 0 END) AS 备降航段量 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_RETURN ELSE 0 END) AS 返航次数 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_RETURN1+FLIGHT_RETURN2 ELSE 0 END) AS 返航航段量 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_NORMAL ELSE 0 END) AS 执行正常航段量 
, IFNULL(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0) AS 执行不正常航段量 
, IFNULL(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0) AS 执行不正常可控航段量 
, (IFNULL(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0) - IFNULL(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0)) AS 执行不正常不可控航段量
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.AIR_TIME ELSE 0 END)/60 AS 空中小时 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.BLOCK_TIME ELSE 0 END)/60 AS 空地小时 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FOC_WHEEL_TIME ELSE 0 END)/60 AS 轮档小时 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.LEASE_FLAG ELSE 0 END) AS 湿租航段量 
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.DI_CHAPTER_LABEL ELSE 0 END) AS 国内航段量 
,(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.DI_CHAPTER_LABEL ELSE NULL END) - SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.DI_CHAPTER_LABEL ELSE 0 END)) AS 国际航段量

FROM DWD_FOC_FT_FPO2 t
where DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')=DATE_FORMAT(date_add(now(),interval -1 month),'%Y/%m')
GROUP BY DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m'),t.DEPARTURE_AIRPORT_CNAME ,t.ARRIVAL_AIRPORT_CNAME
ORDER BY SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END)  DESC
limit 10]]></Query>
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
<MobileBookMark useBookMark="false" bookMarkName="form" frozen="false"/>
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
<LCAttr vgap="0" hgap="0" compInterval="15"/>
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
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Position pos="0"/>
<Background name="ColorBackground" color="-1970182"/>
</WidgetTitle>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<ShowBookmarks showBookmarks="false"/>
<NorthAttr size="36"/>
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
<WidgetName name="0"/>
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
<LCAttr vgap="0" hgap="1" compInterval="0"/>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="32a362f0-3512-4183-b933-db8fede0b3de"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[正班计划]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<initial>
<Background name="ColorBackground" color="-10308624"/>
</initial>
<click>
<Background name="ColorBackground" color="-15386770"/>
</click>
<FRFont name="SimSun" style="0" size="72"/>
<isCustomType isCustomType="true"/>
<SwitchTagAttr layoutName="cardlayout0"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<DisplayPosition type="0"/>
<FLAttr alignment="0"/>
<ColumnWidth defaultValue="80">
<![CDATA[80,80,80,80,80,80,80,80,80,80,80]]></ColumnWidth>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<TextDirection type="0"/>
<TemplateStyle class="com.fr.general.cardtag.TrapezoidTemplateStyle"/>
<MobileTemplateStyle class="com.fr.general.cardtag.mobile.DefaultMobileTemplateStyle">
<initialColor color="-13072146"/>
<TabCommonConfig showTitle="true" showDotIndicator="false" canSlide="false" dotIndicatorPositionType="0" indicatorInitialColor="-1381654" indicatorSelectColor="-3355444"/>
<tabFontConfig selectFontColor="-16777216">
<FRFont name="宋体" style="0" size="112"/>
</tabFontConfig>
<custom custom="false"/>
</MobileTemplateStyle>
</Center>
<CardTitleLayout layoutName="cardlayout0"/>
</North>
<Center class="com.fr.form.ui.container.WCardLayout">
<WidgetName name="cardlayout0"/>
<WidgetID widgetID="ccb0723e-b496-478b-a739-6bdab061d5c2"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="0" color="-723724" borderRadius="0" type="1" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[新建标题]]></O>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Position pos="0"/>
<Background name="ColorBackground" color="-15378278"/>
</WidgetTitle>
<Background name="ColorBackground" color="-15378278"/>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="正班"/>
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
<WidgetID widgetID="c2f3b745-b263-4301-9082-6cdd5b22a3dd"/>
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
<WidgetName name="正班定义_c"/>
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
<WidgetName name="正班定义_c"/>
<WidgetID widgetID="93f9e692-63f9-48f3-9245-659a92b25104"/>
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
<![CDATA[1676400,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<CellGUIAttr>
<ToolTipText>
<![CDATA[仅显示计划航班量大于15的航段]]></ToolTipText>
</CellGUIAttr>
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
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ImageBackground" layout="4">
<FineImage fm="png">
<IM>
<![CDATA[!MT^&qh\-E7h#eD$31&+%7s)Y;?-[s3<0$Z7gK;!!!'\dmkb"E"DLFq5u`*!m@#VG.PVKb.k
<-B6rkK^/!3A5AL.s\'sb-NZ4`"%g69T-k+FLN,dJ')gO4"D"3W%#g#V#_0bHM!!gh*>ftZn
8io/kTinUC'$"V*cR3=@s[![=O?EVoG*lo2[j5]A/;Uo4D[Ro\Et%$o)uYQ"Y:-X)ht*<N<CW
uYI>J[,7n_Dn).#DmC"ojiUD$*NoCl]A>Y?@fZF!%/;EQ]AMtaJHis3![Ut[An@qKa]A0;VQm@d
KC#pA[oTW#ff5D@#\H6uXDN'^5Jr=JD-Vk>;q%>oEslY.%G++R5:0aV+85mjs8<VEN^_J6eg
^_8:u'HP/+fOHW<LVIaY&Qkga(Wf`Tl`&hG1G0u_!6&7jK-VO#Gt:m09X(6A8h#,tZQtVL'i
Sd#Kh0dJd5q\uo&,h'B^?'A7F;:LS^6Ib!JKUA&<u$-6c.(]A*b6fc#XC>PYHQ8jDf7`4Hd;j
Zhn\n[1DWG\$p8?4mj:RTeTh$Q$3`gW$-WESC0$Z.&\a_4?q;F_DCfK'-=1@/$$63@[EfEd;
=4;V.X!A38c_M(YCPtoqBd<BW,0r:]AFPWL&[#W*5"Gp^*`IO9N6PE;X\TBT<&WmuQlmb/'9k
c@*gKX&a?M.+<KNUJGef/-)$&jEV\iD;a?hsP0Dg.Es3LlQ4RlVV2$-U8K"6oLpBq"BU4F;"
Di,8d@IdD.WClT=7@D^nnhp^GCmortpg^9p+dIR.h(Zp(AgMa%;/8#ii"oWMS*ctuWIa-<@5
g%d7U#n4$Wkf`Gj22Y4K8cfDl3SG+96:5G?W&JRtt6=U$[rC/P(G)`rO:"5e`C28GLS+Rs,:
AfG>ar:!B!3TiMm2hgb..P;9`?S;:bq4!n."[KJb+Bu2\?]AY3l$NYnQJg]Ap+8D3qRTEd/8dW
<W#mC*7j3EYjlP*KYYYmk!mTbJ.hfT+_4H4*f-.YPH2(!J;0+CBE-79/.kP9e="-nY<Y?67X
$6:YmSo]A%57n69U^3ntAeL8KhIZMgA44]AC,&7S9uFn"jZC>/%?H4o&SY*cI(CP,?(^k7rn0O
Yj7<%etFLAOW[$gY>Q`Fdq!XT]A[RNL7p>Q"ar_->GeY`PCTH\F\d%I-)Co:R?su-mptP?V>=
prM=AegcJd1loga6T\g'.8X8_,BIqk`??De!Vr(SK.&hhJe*omTJtr^HmY2Y$?<!9AR+.[gR
0]AB2E2db,U429EH8..hOMH7s!4_R'im,!e?]AJQoK\7o@?J-4Zm?XP:K4mCEcZhukH"Rn>PQ8
e!rHK!q@"C4[^*?V56bGto[DSdV!IWF=1/W]ASD1N]A?]A?JujXNd7FA\45#_Qe#F`T>nZ0^QSg
+%P03DqmU`-u^r]A!9O??e4@1u-uP7C'_gTSo4HMjnHcG$$)RQg>sfYB^C>+\'7b`E\t6_:-]A
5(O-1+Z!Y`4A0C:!Z<a\lK'ru`t@nJ;!N'$!!!!j78?7R6=>B~
]]></IM>
</FineImage>
</Background>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9>!<;eMQ^[,&.E*^P#$Be;YHa&Ul5]A%"0="O5a<.oX3u)G;SIg=hkh!@co86>i]ADRi)r=X7
6Q@'+mgZ5WWJ=,*4n;&SeCX"bAucG;[>.IE`3H\[f8]ARlHtAp+5sOh<&qr_]APC9m`Tt7pN`C
goDG3;qrA8ZCD1;Do#)b=5s[;6q<d`SK7a)R)\hr&RYUpjqoPbTs8H>$OSHRt=oP.'a0F%kr
le!P#5(Mf,5H#pRLc.,I-B8ocBB1_S<F1\+'\`[6Ou<+*6$0On*3_m6bb()g,;iR@c;C-ot1
&k7DsDJ>&SdojDp`n<`j$uJ;]AJNR?FCXTtHcJbeYh0eYpWI[sZUfo>_@Ka7A=*(PEi-<ZJlI
l2MfGo7JIE8t!s]A1tCV^g:%59Je`-n;a$^Teh`@+`g'V"of/26M&#L_iJCJrNlb#=;<OsGQ;
@05F0O=]AWkocSbb8n27MEDnc"$Q0C3PNE<+OZcgHgeaC,?raXr+5,,IZ1aAT"NTbqF^\4&7/
@.oN_jG`;*0,-\oK>\W)2(4"IkkU_&V,n!2UTmbH,OfRkcZo&;R,SBM`'g=g7/D5,o!tQ=I_
U`>,r4%]Aqj:QEOCDg1M]Ak_0seT0p?N<W6pV+i*T01[.I=Kl8FUT%D'[rB8o&j@#2d+aH6f%T
Q6c`;,p2G9ffN)o%/nRB.(h49,Xq3E9Hhc,5.<9ItbhB%NpZ_JTY8(``?(%&hpZDnhf!4PWC
-V,2GUQEgk*Y6hDD:NWdpO.)kdLg@7k2,^G=Yt54).`[(K3D>uDc;=5ZAiNanqa+">^,bCj;
\dMSm#XYOBPd's)+;52u/J"\jTRG0;u'KoZgJAl&2T*LZl&;@]AsWR"g)&Oo2X]A?e<S$X-5o<
bKI2bCKA85Yk7-fJRs.XgZTL>'_RLM22c`?lNaN$4>r[m`loND+\[eOk[GCNjhgTqFZc8PH@
ns^<?JA25n#k&CmR9L$X6ZbQ%D4Ydr]ADfDb`_4j[E$%FDD6"uI+V4[62YbJp:/T6on':A;s<
JJQKkE?`iR>VJtF(cN`9r.\N)L2UK?C`2n&!*W\3.5&#W_$hnVU7gfAW-k0btUI<Y7\jQ5GG
pYZiO:YC>#:MNs7iaA^Y[bEh1gK:Pc:H9,OYJ#[F,nIR7o[Zc3lBsXpFIC%oWpoj`5;nJfR4
Y-qW>?;@%o\PEm]A.[PRDuqJXN>5rhVVW4HI>VfiD1$=\q)69DFd8nYI%8Qq@?q%b665o2ah0
P2Ef*/L@b3&]Ao-*Ep_A55IS%FuVfHD<\[o>DrZc<O.N$erk,XQNWkL6B19>'+4>'>P1jKi+N
$-htg9%8!K61rsYTaMSG&$s;&&k"qd`H5A6Bi[J:>C6UCn_X$YH_*DY,W&c;#i[q-tu#i_%G
Ecmt&Jh:VGL^HP.L"ST8/[I[KDOW>g0P.YRAFZj3?h2f)+?I5R2-,<8Y'Vc$.O3TgBHqR8f!
]A2pYn:X1/3s+aLq*:qG)Vo6/)0D%k)"&juWVCO.o&E5VB4?,UBr6t:]A*GK2\Y=3c?NQeh6/H
X8+`t5.A9Ud/cWPOVA^n$H4'uDC0l7&G3TaXJSo.8rd/+``r,^!!59kb0^,pCeb/>?Sa+rLB
EgJ@[_,Zto.`AjLD#b-Osne-t/`_`dMYE%,*EWqCTK(2_^l*Xr\L3"i"IcgpH&?oa9U^EH[n
@B8L95#QNG!ao/noJikW*;jJ?r'S:;jccGGl6mI$Qu3?madM#@dfH.7%I"A<cdLk\S(E3hD;
0u:5h0lc.&rB^npY4ES>gL8a]ATHXt<elG=7LUePBU/>uea6NOkP(k_c"QRiTolAs7u?fi0#o
nGY.6XI)%;euoG@@ccZ^XNA(`PiIFq:5Bf.iD5VbP5-h2_Ptj$XRJ9+f+IQO8dV=^:Eqo*HC
u/?+tlAWXa;m\UObI[`ITRXX-+ZjY7n7sRUN*&hVfGHKO'cZrVB!:+tX@#oZT7<-GSt/[7$,
&\=D!SF[S7[qoqTF(/_!*7Rs&g4^@G!r/Mgn7U3+f7`U-nC@%rffL/s)f91H^`=/R#cr'oE1
hRs9_78[1=@Yo#URkY=#(t4\o8Ve[1EbULW:3I0S:g%Z1Z3K[56gV/MlQ-)Tf6VM0o`udZpd
jS^J\hbhj18&_hHBS$cgd$k!iP91A2F^(eFBR`_$[H_O'1%ff@P7&M<"O;^#C@+uAQ41Z?$g
WQMpjs+,Ln)Y`j6^R<M[Y9u3AKkE$L`0_`X<ZB*YPrJC++,r4/Ek\Mh3?npDnn_aPr]As"+(q
L:%s(<\8fd5)b`pBOUHd7Cs<h5PC-eWc=EoG?tGl6N4_^g[&<B"uK6/3QL39#)B\tL#V!mFU
cP8]A2D4OIF!Sd!ij)U:oYpjULI"9!"r1SiooO`Z0JgjffD4:PZ50C(V*IP2G8OAphVGP<)g(
P-3"7Z%pkJe#dsV&+mXZc>GYge(u&T$Z7M94["8G7(Fc7%E.&]Ak;^3Ln4D'e1bJ/+uK0ma2#
EU.\cLamX!774&m:M#i,ItB%u\`HV"^VK<9.=C:1-ebuFc&?dLQ"5-kgSFjK!_5>Lr?C28JD
\cl;b$b%r7T3f%s:D1;'94Ac\,1o]A0SR#:\M-RIcbV'KWahf`,aFRa'%sn>:/6g:2GhrR7fH
R_VVhlUh";s+[14m`)\Xj8ZYQt]AH#VN^=*sqo&EZ+b9m>t"jN/W8[Ii2b^iBs^Zdjn)gkM4M
VeBRr[cqu]A;a@dp%i*e/pf.p6VMA?<!d+=MjDCAfKklX\iXP[7@70Cg]AD&q7I79L;MF5cM:@
7E<$W-JE&jT+P7[\U+U8,A+c)@j*(9lc^OjFAZP[C+G<6']An8HV>m*Q\cW"c!egr:NU)g"uu
'rLN,r&>g/kXHi*m2U%J]A!<sN!^FG(25s3)i<L^Ri/g8QH<"ke+#9QTV`#dH?JDk1diCnRP*
n>;\c,)OqVPU>D7.4#3+^fgetLrii8\5Pn1[pLhCXoV"[H]A$+RY['K.aFiC&QNKI"$fQHff!
48sqi8sQc`OB37+#BZMm<5LKq:1bm$q0E*8G?7CMGEEP_&lO<uS0e;\fNrrA@B.rEs]AF!h@W
WL7Q0[#T*59k\Wji,"j3a=#_;XU:[lm^VGFhcb&Z2/Gnq]A)nq6TCp`BS4T;Xo>4_'brZFF7R
gQ>2dH+aOH4d0mXUrni?6SIB/<]A7NV>cVG`'#OTb!I#;NbVsPmJWPr]AANjTh1TChIAT62#+%
s6.]An]A"#DSL9(<XTbNS6&&i13Nhr(43A1lrr8gVJC\=_0W3\>0Jq'b'8k'$_4L=PsPsXlhIl
Td%rPZ*nR&_4REs.gI&XrH#Mka,3L@AZRB?4B=khZ=(K.n*UPmgee7CW#3f3UJTe%06O1O$c
U.g<%_n00CTACDPCt5=h#P.7hNu5-8c.8^X%LCEO`k*<\5-dS<LC@i"]AkNHZa-_4o%*qL+bl
l^)Z5ZCdO4S>W<;(3Zqu:U^RHnKI7Km;9jnHLj_ht$S^u#+rPmCd:K:d;mf#4;1+&9Uh%nM%
9a"hX^CjP$^!8f2HS$J^KF2&937KNRHLW-/1qAG>k`T]A7A4s]AAf6LFlJ*j&22c/$4Ko0tZal
^&G-@.pH9j5`iE!/^jFC8-#'r*T[K)t*n-&Zp6S,O_HA#9%-AJN]A,.NqYk4DGtp?e<!5St%<
):%X!;VsnYLU)%<SnCuNbuMb8Y79?\#enKef-[h=Gr:DVZm.htB970KdM3-LCI"%-_?[-.aX
m:iMM<.PTW7@&_9B<\BU9r/#Qo_k8-kR0hF`_bC5THNSa*K$@PhtVPcX=_dJ7)jK,hq,1rnE
g1j$H>kD3U^e@4N!Nki@TK<Gl3TOR,OFiA2o\u:o!R%+OX[\r1FUp>NB(sip^H6S,.8G6`M&
2*i;Kf)Kr>M2XJ;,AmWh@o=D%L-F*>&nU)Sp?+f?[W!25&<M%2]A[Fd]AUm]ABdu5k:h>B>3I#D
Xg/Rm\ul]Ap&WdnAor:Rj/?n9iY6C4sX5?=P-H=?E$S(2$G.fl4dnaT<6[kU]Amb>0%t`6N_rs
BTreXY0Jd_?-2BYX,jYB)fN#;X4&`8./+FX)=+XtL2^TBZ8Z\*=CcFBIAaKZ34EOJrCq>-!j
ta/pDg\]AE6k4Y9?Fn_=Lsb4!UNYA1I/ocSi?6XO@;EN)dIG!-oi_c;rtuf;kuk?'ok.B2([2
G(Q"Aur,q#_HuhN1Ng6L*benX!O(0<3h2P"nYofDAO(t>0Ya8g5:FP8SC*t@5,C]AGLa`+gV.
c/@C_o!E4Wm@8mB,3I)Ukd]A[]Ap=kp^t@0J<T%=p!MD-)%-K+pF-'<O!`:h)Fa@77[fpdkit[
mKgKMZ1Mf^KWbT4gqHL&qA\,l:?XZ2e^LQNkA$3]A\J1bhJg*-'V]A(ZQBNj,4qXCch5#*9<Ws
Pm^/!ZAQXX=!=:b'A-R`W?jYieYcn3WVDI(:SsQ:&WdHO`jsKqZ/t&u7i"5`04"#<pHNQ-[V
(N$iS0Vn^Ve1=H+<aH%o7WHo^=6od>>am9*P643GN=O;>.S67:Z/.@PE@]AU;PZRKm/O?[n@e
q/SJVG`mPk"dOttI8f;GOf:]A7]AHP^lO+HCH]Af1)Z$O]AZW(!P^E)?>W8-UVFDn"25\QaPKK/\
JXn'/Mi-teEN)=$BBhjL<7#]A"ODRJB+.hb!1<S.;W4,>bTq3@$G5+T@e+\?fsN'@r4@k]Ar=#
n]ANtm=theZE4!1+r#dqY'&$h7hme[Z*(p98ML`5lD!fHOa^LP7r[I)/u)O[hdN!/kZ]A$r\Rl
jqgaJ*R&F\<G(c%lqCM(ADia7`R)`i4Yu5?M74@3dHDFEQIo!R1Jd*A7+,Rk:GdtXe1Db'p-
!BI4bY*L,^-)VC=?sY$%F/]A(DkkF-t4pQhm;#b[\";[3:]Ak1PX1RorSgc@/eIO42Y%"2rF63
Q0X8=e"msV-b':7t5EgXqkZ^'<`+Zj>VIPn>E"NPEEk]A*04D.hW=4i\b&]AZI/i%0C7^Yl2;)
i(l.8SOX,S<-N\\!XX.qOb]AigPq.7q+cYD"lRSDdlaaJd.*,J*gCtpCm!B)Fm69rIILA%AtB
>.Ms@XiP>&1RPj$OQE<<c\OR_Y@MMX"j>mF!\j?I(oQi8\]A4Dr5G1.aI*V4E:V2KF09@^WU3
pY[^-+.efnX%DRda`MAHX14\Bp^63gUI1;Idqg##V03!A!tU`R.'Vhs36Hgqk2j-D_[c0A/R
ml(>.q=O>XZsB#m2Ad[-)E*`).*EUV[`AZi]AncoanHdjL/B:+ZRSh7Mdr2hZ1"FFRu37"q6Y
ec0h.3M^2Mr/+0+0EJGkY261]A^%X330#'Lpu^b/WY2A_6TX0p>#M\L2'Q-F[+_ZIn:R+cC*=
O1HTQSXrRHQ!))83Xh_mP-V-pS&.@3FK)&+YHa+QZ-V6#rp%:WM(L7d"h$<Cl0O7a(.bZfA&
"TCKfcd2d!>P`*7e3jDA"mAWhbM-Jl;P4h?:`SkKCd1CFL9"^O&dJLV*o]A'(2`SA9H>.mDFP
A1l5hUu_U)QEN.2*=5b;U6l8u4Gh/=P6Me-2?c.0o/:R?F;)to"pYB"ZDG`^rs!,#ES[uO5l
FX#HC\cj;Q2iT"2>*7Vp8;>oX=A5)AZ#09hjb"dD;@KO@LR#WBJBLf7tc=@DALorg4)/O0pR
KQ2]A.R+BJYcRBgBd)0DA;2k505_S@&HfG#>iblj,Y>^n]ARoaR!u/;XpiY-UG/*9`i8+:UC+0
RpTeFL;:>\C9TgKN+j&fro4#@hTG:6&IE!>VNqs6!TKg'k-"+\:F!g>%\Ea%)o&7=X5m-LQ^
eJ/U<\:4I@jC$+&D!SACDYGtNs)F8;mdVBq<a4[E-L'4P"soq[,eg,/DoJB7NW77Lc1ofO24
isD@;_5^AL)sRk^*!&VEiETg=?Oaf:%ssf7c5:%gnki[B]ARRXU'"j\HG]Ac%T6,q\k<FSsGB;
U^>[2UA,%gW9HA:[r?n1C'cH`Y.r"f`+4$m7*G0rM[@\UqGM7>C\AUp_K%ESiLlJ4T_?&a<^
M4/m2>0)$b4X:U#H'<Ikm$c.$l0B,S`%b/fZ.S&)&R-=aXTu/[V6tE.!#Qm6:8_[oARuT+..
nS'D!l6k3P%/M]A>ncEt$j[n>_*cmb[u+;L.\5$,7-Kc5ZNDa2d#;-L:Z1I<N,#IQGtYF6@-2
#M&@b?"'h6UcDf4"MS&(qb<BdbmeB/A3Wl'kSfiASY#Sam%j7m\FFp3/@??ph`o%KGer9/V1
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
<WidgetName name="report0"/>
<WidgetID widgetID="93f9e692-63f9-48f3-9245-659a92b25104"/>
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
<PrivilegeControl/>
<CellGUIAttr>
<ToolTipText>
<![CDATA[定义：运力储备情况]]></ToolTipText>
</CellGUIAttr>
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
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ImageBackground" layout="4">
<FineImage fm="png">
<IM>
<![CDATA[!MT^&qh\-E7h#eD$31&+%7s)Y;?-[s3<0$Z7gK;!!!'\dmkb"E"DLFq5u`*!m@#VG.PVKb.k
<-B6rkK^/!3A5AL.s\'sb-NZ4`"%g69T-k+FLN,dJ')gO4"D"3W%#g#V#_0bHM!!gh*>ftZn
8io/kTinUC'$"V*cR3=@s[![=O?EVoG*lo2[j5]A/;Uo4D[Ro\Et%$o)uYQ"Y:-X)ht*<N<CW
uYI>J[,7n_Dn).#DmC"ojiUD$*NoCl]A>Y?@fZF!%/;EQ]AMtaJHis3![Ut[An@qKa]A0;VQm@d
KC#pA[oTW#ff5D@#\H6uXDN'^5Jr=JD-Vk>;q%>oEslY.%G++R5:0aV+85mjs8<VEN^_J6eg
^_8:u'HP/+fOHW<LVIaY&Qkga(Wf`Tl`&hG1G0u_!6&7jK-VO#Gt:m09X(6A8h#,tZQtVL'i
Sd#Kh0dJd5q\uo&,h'B^?'A7F;:LS^6Ib!JKUA&<u$-6c.(]A*b6fc#XC>PYHQ8jDf7`4Hd;j
Zhn\n[1DWG\$p8?4mj:RTeTh$Q$3`gW$-WESC0$Z.&\a_4?q;F_DCfK'-=1@/$$63@[EfEd;
=4;V.X!A38c_M(YCPtoqBd<BW,0r:]AFPWL&[#W*5"Gp^*`IO9N6PE;X\TBT<&WmuQlmb/'9k
c@*gKX&a?M.+<KNUJGef/-)$&jEV\iD;a?hsP0Dg.Es3LlQ4RlVV2$-U8K"6oLpBq"BU4F;"
Di,8d@IdD.WClT=7@D^nnhp^GCmortpg^9p+dIR.h(Zp(AgMa%;/8#ii"oWMS*ctuWIa-<@5
g%d7U#n4$Wkf`Gj22Y4K8cfDl3SG+96:5G?W&JRtt6=U$[rC/P(G)`rO:"5e`C28GLS+Rs,:
AfG>ar:!B!3TiMm2hgb..P;9`?S;:bq4!n."[KJb+Bu2\?]AY3l$NYnQJg]Ap+8D3qRTEd/8dW
<W#mC*7j3EYjlP*KYYYmk!mTbJ.hfT+_4H4*f-.YPH2(!J;0+CBE-79/.kP9e="-nY<Y?67X
$6:YmSo]A%57n69U^3ntAeL8KhIZMgA44]AC,&7S9uFn"jZC>/%?H4o&SY*cI(CP,?(^k7rn0O
Yj7<%etFLAOW[$gY>Q`Fdq!XT]A[RNL7p>Q"ar_->GeY`PCTH\F\d%I-)Co:R?su-mptP?V>=
prM=AegcJd1loga6T\g'.8X8_,BIqk`??De!Vr(SK.&hhJe*omTJtr^HmY2Y$?<!9AR+.[gR
0]AB2E2db,U429EH8..hOMH7s!4_R'im,!e?]AJQoK\7o@?J-4Zm?XP:K4mCEcZhukH"Rn>PQ8
e!rHK!q@"C4[^*?V56bGto[DSdV!IWF=1/W]ASD1N]A?]A?JujXNd7FA\45#_Qe#F`T>nZ0^QSg
+%P03DqmU`-u^r]A!9O??e4@1u-uP7C'_gTSo4HMjnHcG$$)RQg>sfYB^C>+\'7b`E\t6_:-]A
5(O-1+Z!Y`4A0C:!Z<a\lK'ru`t@nJ;!N'$!!!!j78?7R6=>B~
]]></IM>
</FineImage>
</Background>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!?;cgE*mBkGj2=9d1g*3?$78ZQ2(7"G_W[QM-jeDE';_,D"Yu4r)UIYZ9II1/$/W\O$CE
3_\7`n`7VTRC&aeMp,BLEKK#@\gR82MHB@gJTgON3b&W?(E^Eq\`&FXlPO_=s(u3G7fgf5LV
:C[Dl9leb_i9n)*t-\?r%-GR9Bl)LDL8&Kt2*dQf9a7)n(YUcM2-n';ilUr&/R9S+get'4?d
o,$D;]A^?>H=HDS:OZhr9KXNrX=3;nU_b,!pn<I8Im8.:V:kR^hKZ0_J$:a#\t7Ws&PI>(gXM
fRF(Fpo<jN#'b%[6floJu[1LqX`;;#*CXUUO#[jP:%)(+8>i3NX>?bFL.mf:7A/!M=Ep\r7$
Tatm]A)A;_dZHgb.psf7!7U.Kqgh)dg0%6Y8PfCgG67uR:H%k>elEf$=a0:]AW4IQ[qc)kY;n2
;BGSjAPXZ\9rfWV?/fIb1?/]A]At"cH!R!pNuR!cZ+M!_*H\BKfC:b5o*liua:PURH6M-4S]AEn
#cTnJ@jUq(J5>32`/MJAM\.uDQGdi"WU)NV\ZYH+`(NqZnf;5pN2's\[91m^S:YG=rIK-r!"
c1cR]AK<rZcdhkL-@4-AA15l:Rkm`UUl!h,>7K`2;VQ33#4Z^*;N$@:#e>h1Tui0;ZM`bHqB_
P%.K?m#c'U6"D.h!-aYs#XopPT]AC/:V51.Mf)\^ef#*-A\b6]A\9]AB('F!3TA[FCl[da*R0-7
U-tGR,$O+b[7.&h&c3fVX*'jOJp1q7.(VNokG8XER?k(t3j&,^l8Om8[:LphU"NlB3B9nSj+
dTC-HobQ^U2^>6aI=r[MIQDXaE(uVpmo&TGaLPlFHZmf^#Kfn68A_h^ml<_g=%%`B&8qYFB`
>AN16Ng:TIF`*Rt!6+!*I7Eh8g$+j]ANKT`:;ol2EXm<cEFq<E?6(KD+u2ra_[gWY;uA)ZI5L
8&p?-HG'\1VUJ&o29+*s!D4ThNFD.=C2GiYVW*?W$V(MiTPk./"Q"Pr3]AM"]Asn)M?&Xde2\t
MucmsBN)2bWLLg7igK8R%<L%0#!\gtNneJuA+mc:BJ`if(VEsEE%lh"F>^3[mILdTOXdM8<9
-<5$H7/;_9ci:19?;7lJl^l2!_"YVAcCL\dps'V]Ai`l*(5Bq*BR3R[`7LkY("3ZE_Rt7bmhD
X.\MI68\:;6%lN:FU(e69OXbZct3T"o<Z^YKH</K+DYJG[U6n(]A:Rc6u$<c0dsdhQ@s@<Q5[
;(9,:MCj><qg3:L\^$Y'OODri`'`#24YR#;oGYoLD4b<!f[mA`S_KdR/i=TPIMU!eOO%ATJH
(YN8+Y&LEV;fQ"85$(s`@/qrh%8`7ARU59*3U!';6`=VCp7cP!.[kP=tC6p?BiosGO&N,ls=
&V4ro,V"D/I.=p;&Jq`)1'bK=-Pk&H3^\G`D),23Kea+#pB2H7sdkW"s*VeM^R4$&qW3o>IZ
;))3_H8h;if`Gd2%";^=q]AhQ#h@nidBP**uKrD48POMKY1=r>ngn6C!HtnqmEEu=L#s8ria3
)aL'=DC8#I5m<8(stKa:!7oG.5:S%]AZ1J4*tTq>l$@nOi=&a4oY9-b%%22!Np-r_U=_Jepg:
rc0Cen[3pt%oAU_ON!rcRcn<#ef3]A$`bl4^UZZfG`'$pf=HG`M3[?j@C\\Va3l%R:O&XAOf9
i[\E\p3s8><Q3SXJYj4Bo-!>2=K)OdI.0M2Ou_+;H&@tK_C"n,e`TNK]A07q@A2!j(\P=5&XA
eU&p)0e(2h%mA'`kmWjJQQKr'*8e"#nC@L(tDS(`'S5)\aU0Ke_:H(dY$`QJK5ZMsEUR(iHQ
30Yl>bcEK>C9'keR7p_ba7&eh%^Q0-B<b.(GG'6&_(dg:2dfe\=r)3HJ.0!,e%-R4$kQb?"'
'/<m#%':FZsFi_^t;fXAn"BpO&1i4V@,Be-Yu!AP(!N,?jfu?H2lma?nfu)H2!(LA2cfVt4.
IMa&fCD__%"[lt/YoCHg'$X:%%G]A&L84u3i8n,3jRdm^lC`e%7_[i9RQPh8`PXCgEcb9_=ie
d.^99*Ek&SCbAQ_8,G4e3?PL%L(2!l!bo6o>c\]AKuMCcg3`T%bU/>t(\80)W_dhT@O-h6:T&
SH:@Be1+bmF3MUeB/>jEf.3RDLAQXL5m%&XY1Mo/=.\D\aj>YhQ?Z8;Mt4>u#7r4!L0;G"bs
\*k5DjP/Rua-%$Q%u',SGE-opB\P!Y+7]A%F7%a(kRR-#Qr:]AC7f*Ga'D`m?5mj%L[cUr*D*X
P&A-dEef9)EJ&aKF(u!XgL8H<(p[En&QHI3Uhr*LBFJ1tHSOOo+N=`!4iLb%.A^S4sh4-/YK
cH>6ga\kV+&"17gQ%6O1A*[W^`7I%=Z7_J]A5VnYd85$V*3&mFQAp_nYO^$Rqh<#'n-Qp<CIN
,sFK?Mo^80e88e]A!@h857dJ>i44Q+r,4O_dSHZXIml>:CRW%e3d"XD0o4F0%^VkWA3qg@llE
Kp+Gir<)lVqbMFnE&B1;84L<^]A..jtJ%rr,.ed!o@"m5L0aGW'KNp$^+(&h?b)5`c"'Yr5Ar
-Tg9&]A`KOSb@eS]A/4n@[+6B#,l-C8(%]A=365n'i+P<-A*Rj(,S9Th)5Wn9/f%JLj%3b)gf\H
'4iXm16@*+eOGCk*6m=*;3YNFt_(&#5\/%UJm\?is*HN=jq_)8.g$%A3^<.8"quoRb%X9$"j
eEL*MY(XF"-^<Tgi,-PK[ROKFa9Y?]AWQ(cH.f,km%H')2/qR1iA>6#'epIEk1Tk7lPB#j06l
s[]A.FE#FC"_WkP`7AFTqMSYXFu$%VrG8X8OAotiI<V5#\blb+!c/74K8?WBTEN4HXamkdKFe
/$+i$(K#1hK`R>*K6jU&Vt9rrQT9K#(D.p_XeV1rV>Kf'=7(9>9_G?b,U$qs>&$Vr4dLj`!L
>BI@JijoPo>f;ffIut]Af"6#k1\$1/#Qoo'k1-aSFko0_l$".?^AlKahH>>+">*GRd=]AfMYK-
Cr(eURoj@EH;I&hmjHNrmW3Q[JjWm[dUGp=\X[M#j_:0!neJP$b9CercoV*r=7?rZnuP\'^u
&nZH)qIFm-=V-qh4R)pnu>cYY3[k\KMWj'F$;>t)^21mV-]AW>SK1<'Y#aR:t.=LV2>L6]Aoi>
91om!si9Jdu#I5(X#85h,dnHi-LfhkG\";D.f&qqI^F9^39u8C\OXa;8m,u>"V<O[3Q61e?c
QBJO>mA+jH*-]AZMd2.E4P#Vu+7WGE.Qll\jcdMs0d617lK9]A0FGl3-_=6+<P]A;J/O0_X6^)m
YC)jneoFBIM?@oo#r0=QRoYl%e[UDE@o/%9:ft=*]A;R=R*:5qo="pXddhfu;qn)I9Ni!MVJP
Td9Ba&A\'RKh]AL^#'5qA1XUP8G.bp,7bkrd)TL^2O_J\f*NeS_iP1%HDGSafLr_dP3*LY5l4
aDKrDjR/5&o&_PJahruCgp2bEjB_/%uM,Afs+'K_#X511RZ$P/(@_:/2]A,pO_pd!6_DDp6kf
e<T]Ab>4c'?lWd1;tb:3IG&mui]A*0h#nG%r'-E]A)SX44U>N*"=E3aR9NVRsHAg=R4ga%jm?&4
<^#?DUfas+rN!%o'Cl"V^TBo1P/<C\#[jh_[de!L@!/J,M9MV7%O$oCdU(mAu,f,b]A[N#OOP
,3XqoZjW2H_%,NdRRX=1Z6%G?_)5qBP\sKb;-L7BcrM($[D=;%OK&&@gic.*):@';fo#u$>X
64:(NE2T`;)$JigcU83'ZM6)77M482NBn<qT&4P0@IH/@A'g2BDp!N[),/.P$&=>UEI5,]A^8
)V#A!('Yu&[HkqMuc`!:c*sPn9"0J7a0)A(PS;claa]A."&D$MFLno_^E4VnHI=+<Du/;1Kkr
m8T'/4lK3R(iQ+<1*W[PjuiR<)>dN:>PU5;R?hm6Y,b]A_1(niC+PTC"s;/f6c)rX!stdE#2&
e-U&qb[j-`^iUgo%N#(.-;(l()4E6CcN7aT/jThsZDkbfC-aaKf619<T$M,U*Xf/'EgP''*1
T;68$U<l=+qMeC\AaS)*J`)6$a-I6^h'D96$^p5h2]A1Oj+(?HlC@mECn`2k1aL(A<lTRHJ'k
lq?2"h?'6g"-&4agj9:`5P)l&1kU;1&*Ua;8]A+-IYWt_mLV,R@,oaSFuf%Y[lfF%d]As/!1"b
o7Oe@<8##uC5\76'6@hp!AE(ihG.(mqi9NRXYPW]AS0^sSJ8#rU(_Z'sdMNiAiPb_Kl::TQ'q
%piLFt?Kt/+cG*FKU)(%+</=!RgT\q[n0b7!&H;=O\4+4dfK1+'WI_23O'3U#AslL(5M,=KG
0aFZq]AYckWK+J>ro9GQ-Ka3LhQCJVH=tcqCTZVi&c\_0>#KKO7h^="Dp"B`^$'Y9.n9\p.F)
\AEGQV!W"()-UTs,/[Q9cIF1[6YaGt*Aei;T2hc[LeLgK?QZhai8[1a=P2u@;[`BDUL4#\l9
ClO"_E)Q_(2EirR0D^o_.moAob+B@@9kIP9m_:8KaJDLPB805*;Ndak2[jF1Q%`IJ8I<0"GK
RW1P"I:*K2oWA1[%0Hu&I-6)]A+,(T]Ar'5&%(J=gXk8aUkfBWJrR[[&<*9f?N<X;2`#-D\CP3
$6K6UUflXY+C3?WF:3N&3gu*1UVk&i2bVEdlo-9PAWW46)TP'>0SfhCC.OepcENn=6_.HY1Q
TA4i;D>hij?+?L*kJ`9A7U/+G;_4B'n0d:l@<=@Y]AB.&24%o!Mj&V?]Aq?O&..rq9G0iQ#klq
>SnrV`/\lmfRe.%ifQ!MAI@At>rU?e>@M5uL3&.m7h^%%1iI!"(VjfO3)!ZqQ3hY_@@i^E'J
G6<XbQsk$D?W2Ta=G;&#sk^lH'Q#Vl[!TMKCRGKOFc[RR#MRf%JM\;Z8#gndGLOb)aO(q6!J
K2&A@ja4:^I2lYOq!!8(Mf9X#8:W10I,@$f-QZ2_T&L/A41>NZ69(!)5EZm?M=H76n;E"N))
C-4B+!G(b#0'$4\h-R1FL"KJ/k,RjMc,LZ;$A9h+TtM2HB(#8`L93R5"[BHecsaqi50rTD(\
)^*P8K5X;H%'!!g5(BiF3F"7\Vt2EO_W6@u"YN&'i)@-m\XCjZ4cpBk%*8s+H6=S(UNW]A;0k
XVc@%lt:$(qQpQT$41*+ZWuUr`:G971JuKleM$?k#/@f(5Kd\J@jI3q4F>Med1l(,0.JNt!j
=[$9\\dD!mr(kMD(XtI_MfbW=8'rQjmCJ1bpT[))sG]AF8qZGbTbmRQER"]A=S&oh.)9%UGi%!
k$6#3SQEW>&)*2DW)sX-SjaK;SJaaG=$>'QlFb7-@qsRiC<qY`t_)5^fk$=s73E=pOYtCqr(
t]A_kg#gq`FIr5j&+e<^O)F"G:_Zmbd>Za&.Mi2EHVu^KgB5c?!_PA@UXFQ(VM3>!6V>ho*CQ
b)NRP$&fg<MK`nP]A4pZ:VfaT,ck=N%^c@Wj:Y$U?=QiB#p);sLeS`/B_:g61lV#6;B$6Mjjp
c/c`;Eo@$3KbkIklR`Y.8:_cFml=8Ub_EqpKUP))(D_n=iM?DC,lOfW\VijY]A'iU2LC'^gRq
qYCjq8%`DjkguhZHq0:S5eVV=^/lpU.9?9*Yr^Hqm*/<^=\/=QuI(8oh`T;lpCGA>Jh"e0e\
AotW]AHVbgKq8/40f=@<$,&qu'3*EMfTTjXLh3?DuYb\RX(^&\G"E>#AsXT5[h=M5a(lS%&,k
Z6Ah;+ps/(sf6_-<mgElR`:8V1"?Z4M@qp>>-4K(\-=@p-s!n'B/6#\-D;M5Xo*%ni#!M.PJ
X$N,XoJo237rZM)+sH[Id3XYktc`VBlcmp>DpcM6ntd2SGbcST:6=M0)>NPtX.g,\8J=rrtS
D*80',29RRl*l6TL,qAs3afFKT6d`G(P1U7fi$.a9^jeS^4QZRPU&;W(n0-"?IWBn1TN5Qjo
T#[-]A'iXZdrb6_`H!-h'_S"86NTp6urBuok\<OWf+@fJQA_FCV;!R5+>t0:'Mm"IR!R73Hui
B;.g@5>kX8cZg&U?1LLmYhCo]AdT@EgN&:V=,Cus(Y9E*t(^B"~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="1070" y="229" width="36" height="36"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="chart3"/>
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
<WidgetName name="chart3"/>
<WidgetID widgetID="62f0b579-3343-40d7-9b32-2e9a4c2068d0"/>
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
<![CDATA[航线满足率趋势]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
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
<Attr position="1" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
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
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
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
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="20.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="false"/>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[正班-航线满足率-时间维度]]></Name>
</TableData>
<CategoryName value="年"/>
<TableMoreCate>
<oneMoreCate cateName="航季"/>
</TableMoreCate>
<ChartSummaryColumn name="工作日满足率" function="com.fr.data.util.function.NoneFunction" customName="工作日满足率"/>
<ChartSummaryColumn name="周末满足率" function="com.fr.data.util.function.NoneFunction" customName="周末满足率"/>
<ChartSummaryColumn name="总体满足率" function="com.fr.data.util.function.NoneFunction" customName="总体满足率"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="3a59432f-b734-493e-b77c-4036700fbcc3"/>
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
<WidgetName name="chart3"/>
<WidgetID widgetID="62f0b579-3343-40d7-9b32-2e9a4c2068d0"/>
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
<![CDATA[航线满足率趋势]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
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
<Attr position="1" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
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
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
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
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="20.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="false"/>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[正班-航线满足率-时间维度]]></Name>
</TableData>
<CategoryName value="年"/>
<TableMoreCate>
<oneMoreCate cateName="航季"/>
</TableMoreCate>
<ChartSummaryColumn name="工作日满足率" function="com.fr.data.util.function.NoneFunction" customName="工作日满足率"/>
<ChartSummaryColumn name="周末满足率" function="com.fr.data.util.function.NoneFunction" customName="周末满足率"/>
<ChartSummaryColumn name="总体满足率" function="com.fr.data.util.function.NoneFunction" customName="总体满足率"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="3a59432f-b734-493e-b77c-4036700fbcc3"/>
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
<BoundsAttr x="33" y="50" width="390" height="244"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="正班定义"/>
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
<WidgetName name="正班定义"/>
<WidgetID widgetID="93f9e692-63f9-48f3-9245-659a92b25104"/>
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
<PrivilegeControl/>
<CellGUIAttr>
<ToolTipText>
<![CDATA[正班定义：批复后存在年度换季航班计划中的航班]]></ToolTipText>
</CellGUIAttr>
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
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ImageBackground" layout="4">
<FineImage fm="png">
<IM>
<![CDATA[!MT^&qh\-E7h#eD$31&+%7s)Y;?-[s3<0$Z7gK;!!!'\dmkb"E"DLFq5u`*!m@#VG.PVKb.k
<-B6rkK^/!3A5AL.s\'sb-NZ4`"%g69T-k+FLN,dJ')gO4"D"3W%#g#V#_0bHM!!gh*>ftZn
8io/kTinUC'$"V*cR3=@s[![=O?EVoG*lo2[j5]A/;Uo4D[Ro\Et%$o)uYQ"Y:-X)ht*<N<CW
uYI>J[,7n_Dn).#DmC"ojiUD$*NoCl]A>Y?@fZF!%/;EQ]AMtaJHis3![Ut[An@qKa]A0;VQm@d
KC#pA[oTW#ff5D@#\H6uXDN'^5Jr=JD-Vk>;q%>oEslY.%G++R5:0aV+85mjs8<VEN^_J6eg
^_8:u'HP/+fOHW<LVIaY&Qkga(Wf`Tl`&hG1G0u_!6&7jK-VO#Gt:m09X(6A8h#,tZQtVL'i
Sd#Kh0dJd5q\uo&,h'B^?'A7F;:LS^6Ib!JKUA&<u$-6c.(]A*b6fc#XC>PYHQ8jDf7`4Hd;j
Zhn\n[1DWG\$p8?4mj:RTeTh$Q$3`gW$-WESC0$Z.&\a_4?q;F_DCfK'-=1@/$$63@[EfEd;
=4;V.X!A38c_M(YCPtoqBd<BW,0r:]AFPWL&[#W*5"Gp^*`IO9N6PE;X\TBT<&WmuQlmb/'9k
c@*gKX&a?M.+<KNUJGef/-)$&jEV\iD;a?hsP0Dg.Es3LlQ4RlVV2$-U8K"6oLpBq"BU4F;"
Di,8d@IdD.WClT=7@D^nnhp^GCmortpg^9p+dIR.h(Zp(AgMa%;/8#ii"oWMS*ctuWIa-<@5
g%d7U#n4$Wkf`Gj22Y4K8cfDl3SG+96:5G?W&JRtt6=U$[rC/P(G)`rO:"5e`C28GLS+Rs,:
AfG>ar:!B!3TiMm2hgb..P;9`?S;:bq4!n."[KJb+Bu2\?]AY3l$NYnQJg]Ap+8D3qRTEd/8dW
<W#mC*7j3EYjlP*KYYYmk!mTbJ.hfT+_4H4*f-.YPH2(!J;0+CBE-79/.kP9e="-nY<Y?67X
$6:YmSo]A%57n69U^3ntAeL8KhIZMgA44]AC,&7S9uFn"jZC>/%?H4o&SY*cI(CP,?(^k7rn0O
Yj7<%etFLAOW[$gY>Q`Fdq!XT]A[RNL7p>Q"ar_->GeY`PCTH\F\d%I-)Co:R?su-mptP?V>=
prM=AegcJd1loga6T\g'.8X8_,BIqk`??De!Vr(SK.&hhJe*omTJtr^HmY2Y$?<!9AR+.[gR
0]AB2E2db,U429EH8..hOMH7s!4_R'im,!e?]AJQoK\7o@?J-4Zm?XP:K4mCEcZhukH"Rn>PQ8
e!rHK!q@"C4[^*?V56bGto[DSdV!IWF=1/W]ASD1N]A?]A?JujXNd7FA\45#_Qe#F`T>nZ0^QSg
+%P03DqmU`-u^r]A!9O??e4@1u-uP7C'_gTSo4HMjnHcG$$)RQg>sfYB^C>+\'7b`E\t6_:-]A
5(O-1+Z!Y`4A0C:!Z<a\lK'ru`t@nJ;!N'$!!!!j78?7R6=>B~
]]></IM>
</FineImage>
</Background>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G-?'6gmoVq]ApB<SlDH>7i%7nlg6I274h<J`O4<BLO55[&JtFF]Ak39TM[s@+CoZ'$`@8R[5
LGWN/1(WeT;n6PS2'2^(La8-jYVo7N,aYc^9A>q)'sH@&q?9.J_7NfKR:8&'lucb^AUN]Aq9X
9pN(9D!Gb'hr5TU:5%i02q/<qFg7*0G4@5SpkMc)p4\EBY;;m#<4(h=^YMXTl'm=cb8DiosX
WP2uVLNg&qe9U>c;fAIj(P80s6P77o<J=oHoBu4m6cp_OVaLR)()dCj*2m\<le_dXY$\:GK&
."of(:e-b^5(6j!9A_LXk0GrGiKSCnK_R6/.K]Ai84-&T,\Bc7]AR8ou;lq2P]A:MpI#NC^?SLb
0.lusX3!;hY%[Dac\L2G9FLXS+7??qGcdH84)e*1B7%UY?"3)Y"F:'U\G&Vn(Ybij;L(aS2I
<c\itBrscP?HC,pqMO2ju)NS=[N44EpVAf:/rq4B3^9UuDLHfK`)mH['tGd?s?<_uiC*Up7.
-&BYq+Xj.cdc=CH&c>TH#:7p&P<bI;Ng=/.7-IPZTg76d>Kh[?l,"A*%Er0`j+j[Js4>O+!l
e9QRY_?UC^@SFn-dC98[c@<J?f2B>r`Q(oW(jbQ,1(KWNSP0\m8_cL1:7&OlGOaO[`s*&_VP
6$R3/;M(i6*Yh)m-)n^:&"Sga7f<]A*%FX-,0IDQC0)n4OA37MBQR3[Z@<@;CO=A_$LeS`d?`
+m0[K4?Vool4eIqD_OmL'"L0oK`l_i)WQDI<XX"[O>qb=dluIjigl]AVH"l]AIRj'7%^]A&U\fV
/XB)0.?JKXa5W%IH?/LfiIRMpsbKDt[6#AlMcCL9e/J8Kgt1g?>Zm05MD@Vu7=7;%D!6;S1*
3(D0-<Z;t"hI8Wiln0X<,9$<uoT!n=\40?-C%Jb]AmY9Jsq,+.S+7\Yn;gqrf*LM.Mb:i<\6Q
Z,F.7S%nj/P-]AiBA0CB20E89SBN\"=GG,e02fpU]AOCR-1h)/QGpg"erm.F=7oQ9+F!29B.$%
N#=jC?NXFKdaebDKj/]A=D!kpDJ'qJ>$0k@M6Mc).@fHa(WJ\)D7\a75n5Wo3s;\MUSS#MRA'
lV`[p-WXtF[UT]A$-b8:p3(5nQ7n)T%GpB%#i_6P*53W@A_:<_G$hgT2M7cg8C;M''C7`&%O^
\[6qKCt9Fm-frb*Ym@&APUJMRL?mgUnU+78M,<ST5Nd(uhl*ip_(0!)T%FF\Z(=(@d7(>HU(
q)Rj3iajj3@:p)EHs03O#@<jU9H^QH,5\7I;n-QE2)psp_BZ!REqM3po`,J;ebjh5p$D#RY=
`[p*5&Dk7Ai6VjYd7)^J&AIW(4PkO&e>'&#YMpN(=3U>DIYHB<SEIYd]Aug,$U*A)O!Ad$3eg
LN$cQp')]AOE7m4r[`b#tI=`D$nUEoSbUmOH9EqEN(letK;4A#>5Epicl[aB\nY?XAMYB6qju
O@Kb:r0K_;*`rs+>/LmW&O6E1>)&'E0]AV$o?;Fn#iF:AIDZ0elmcpNTLJj.&k$Mq"3Doe5+n
d::!RlcS:IQC+Khh9e*ZhQ,r/,%NKq^U2`^XCArsFX.K2Ef#=4*ZI7"qCbG(lD(]Ap1PKN&>_
2B^:VRZ\.2]A]AR:kpcupbiNlI!Z#M^e)Mb8h%rgsDNBS:@>L7I4p53Yk>-`B5/\NK8AL<Z&#[
qu"t,uhUQ2<eX$jRHj7F!HVoN\O_ml?Ab(&D@;_H=HIhZ*:g`:tA_ToDh;k<O+j&KdGMUUoq
mLMGfQ>FhigR.Dq^$c6Gg%p3p:Uacd)u94M]Arllbm:qKK+*g[9)tp01"hk8S:lmP-G9]ApTLM
ZkQea-ZPDlC]A@=2?![M?Tk[KdU51aLei[<teJ1dm,Knc;PD^FROL#dEl</a%G5=MVhiriD@r
10,Bn8ioGOJM^+VoG=NgXmg?BX'^pV'eW5GO2qYW*G;QXSo+&0jiIYqCE1_RGGA<cQN\(0R&
84$4>C'K6/._sYiD,EJS:.VosPM'o<;E$nh(kY\=L2bIc"`cfWh)u^+`F*RUM%FR?-d-/@0+
D2'`m/NT/ZSBQ!-oMCU(4%Up@A@D@?Yp:k,7f>G5DVp7I"&k?>9XAh$.o4!oVE_1;'Oa-DXX
R&KTM!7M\TTT7(b+E70cY]AGmSl+\93<M)9P.kCZ$IS6S7.J7?]AIa5%l&gm!(*\)^o4Fnp54C
dgU)18>!/]Ap_"n9@ZQ=W2]A<HQ=,J38d$[EtrKUgu?mGQDNE>8Z?aI>G:@Ckn>'>&7(i]AD/G[
mhUqhB?gkmq:pWC7gpNm(D_f$?upf6aC.jK6>mDSX<jV*p&e@9O:*7>f\u),:DU[g_Zc:X<Q
!*Mm2K2,g+K1_Y)tj@U'2BkKHHc`FE2ekA_OVn?8gTD4dpGij?m?Pn0OYs?(/41In;U5Zur?
LDsb6QZ_hL)daEo5_?Zfh$p.H?M95bGsE"<uM:/V&4cTkW-ON6ePXno=lXp57M66H9K"=A*L
c#MD^!n!Xus"2n]AR6c*r_&[bmeU1l&`!*4)]ApS@C3?k4X-d3mQNR3*p2<@p4fQ$FG"&V(V.5
C@NURi?dEu0RtD$aieHrjrn+Tjo7M@ZG2A6IUH>$r*K8FhlD<LW5Gq&kXr;W\9D%lgF\<<Y_
^G;o=B<e'Uqsl\fU(ZH@)f=I+dfWldSS,-LWr"p3`f1>jm<*%m#og[u,]A2Z+9<SM4@M;61+e
SJaKAoRY/EA_"J;j1+Ue*!"Rm_fu"/`GXjRZXL\#)?2i8en*(A&Zh1SXWqi#a3J\1X9T2(,F
94lFi8"JsWXOWs>!MsU3k3&Z[S(=alOsRaoS1V_/8UUSDB+(VNuhFgF7KRmNPQkT_8p?lN!u
GMQho-f0<KUtBo'-Jn*W51.aU[),JE93Ooe?eN937,g.@KH"r%pA6eTA\$P2)%ELb>aii`JW
"LH#i(jQR5p]AYuj*O8kY.@I==*E_$J@3Dk^KXI9gl:BF3SC9pslK6#3bpgD^_O8q/h)/X[0G
B>`AFRc-2g'>5B,Xag0udRG%g+t5Ws&`VC71-XrD[ML(oK9XE4?+0#BMkPT;DU'kTh=u$,@N
Tgf5SRs%#JI^7/a/LDrpHaQs^2IX)/j[.RSD)aU`iofs?R>Ka/5:5fh2R+TLc$Y8%g7C%GOf
O[hYQThMY3D]Adh-X:118L4aH,',h$^p0W2\4PX(ANj!M'q0%PUb!.>9m/Nf^nE7.YTef6p3O
Wd`<9dmpI0IMIO7>!&SoKO;-3^Setp*HN)'G@C2A[3PF'13YZ`&([Yt?4iX?\R",SMt2R&/&
HqKi'VEL:r2E-6@f3#TVn:'[ri(gtt23UEq+0t4nU)"A_&9VGock6[B;Cctp,4X$T`r5%dHt
g]AhQ>WNF&M@3[ao/LL*,lY9$[%1#q5ETn:bZi8.HF)G;@-l*!l%<\qJ#ESrg?if%79mc]A+H4
C)`*AA0!hPA%;&&?p\!0biXEO*c@]AOJcB'P8-Y't"<5079oc5D2$_QH3$Keqce_gd#TK:ZD$
NE0f8C>HKl?UedJ-$]AYV;Ts-i<@#T[HFt"PKHFZ$5?Y1B4)W]A\lKt-NV4E&-K:Uq[EVr/\Nd
H&kI>RA$T;Yd]AHc6sk)Lp(54CBZ$u@4g?b"K6AGT7Z4?/iX;uVK>r8pTa:oZ`l-.-5a5f6,:
phC0+RM2udiHr7jksi4k':&[J!-$Z:p6OBc?IPGh_tJBhZW61:B_%k]A(7M<G8iQog1Im.N$]A
hJl2QVjG?rn"5kgq$5;Q<(YPVE=MWk*eiYU^'J`[6HL@_Lr^%bS0p?M_eQh1hka<9'aX36&H
FcihdHm1'7g"(!gWR<2dQQs(t^!e_asn"nomVVY;$;mW4=20/kE0pPdU`qLEM,j&)PFG?WH<
RJk1diSa$,C-&geJr]AJ>)dJ84#uBHTV'&+9iZMO]A65EdRXTD110\9MT*fd<X)JO+J`Qr-QPf
`-G`i(eW'Id!K^R<*o"Jj&XcWG:ltDFU\u5:HpD!M+gj5?K*s(5#28iu`N4V[*QC8Ueq+_X*
M,^J@DA"+&Z3]A`D8(^FGUe[$hT_dAD"o50kWE_6U.?'g;P%i'';qtnuC@5P=+4#>sc2!cDUG
I6=&:<CF\L@+n@<U/4RB8>FmlC`MPT@sTlNp,_Pm>C_&SsqM8Sf^U4oS%-.UO4WX+R9):EWL
>[0Vk#EtX<_1%3gKMKk,3g#EK1''L"QQg.E!o-?FR[=XG\M$Gl@XuY4-I8=1\#%1IeW&,Y`-
/bkVq+GKWN/YtfDB4[&E_5>37II#Rc9Yg<k^dC^mJb]AWkpd%9"cj%=gZI^*mC]A=Y^-)"!4P(
W@jXpnc)b'gb='0I+_Z+h/?iZM^:M-u4AKejsER>=IluL%,ORii:PmFAPKdWr<rkG>:0kdpI
EEhoG^KP]Ah'VDl5ju^8:MMl8!S$6V;nq.+:HQGpSchIsd3u\"6IMo@P!7DiphD1%a#$VpR^]A
*Zg(WTPZdPVej[NH.B>BGt]AB7Uodc`oP`dDfIMiB!GY"ROlq-S4)cX@%.DVHaInMrI%\@]A6/
t_V2\t/QTgmB^j00%1t<TZ,V(GT;S'%dUm&sB8,gESr"cslm)15/5WCib&VsQK6"GQeJNX*"
:cL:^),(b="n.IQdd,j*SfDW\)bo<=&LPs<ZpBSljh99Wno$WO-gYiOghX+8KBoi%FNk_)=E
JtQql0HIC]AD8n\@k*UsO#u"HGS]A-%h>jUUrMD"P!TmFLL3jE,/,q=6>m1$eX0C4tQN6oRF\T
GH(egI2D)[N;AkY6-nO3GK1KbAam&::oNUEYRFOI,[a<@(%TS@8%OfiE"PJ<9BktNbqAQ>CG
_]A8;P&IM;El'DfgkT]A-d;-Z5`]A$_lpi-%B'u;O9P7+k(j\?/!G-6KG225%=f]AcQ_rGCD4+p6
0W@denWd8X++A6$/OaMhW82i.*isQfd2O4Y-@U7no5<S!D$2fGWS8U(oUlrGKD`ej*4!Q>AG
+nkR1l2/D\O\^M(!qo4]AnRcqW"b1kZhS>1>d24L0ImJ;B6Goqn?h=HI<dmjFa#5aAd'[P_X:
N/_Sp7XRgaRg8At=DNFQM,d"EWn#32^=g/o)+/-]AIg;o$Dmq``tj=]Ao`a',:GCQpf++4/e.Z
-Fi!6DU^63oVh6o?u[EI8jOF&*PBPMXsOGPXbp8uG18Zm[>@++gt6rCf'CP>^^!5@!:N[&J]A
=q*6"%"i^i%UBB;d]AsF:@d/6=d65W+_)hRG't'"+qYI+U#sgbh79ClHJ>c)aJ,RVa1$WVOtA
5dLPS6.1eUaF&a"_;rE*"H*Kh0Z<r4X!5#K="07G'JG_T6+:SA7V\]A1`dDj5B1;q7OPq/j7N
$u*6&"LVs\kj#6Xo"l,T^^2?RAs:B2_=%@X7!4M!J(>lG6ko,0f\f:>r"*>MPh3SM@OS>,Y\
$\3!"\/+:nsdb!=<LPig!2Gb;q?G^tnfUXZ#*&fC6MN*PudR#FeYW^qMYesC@t+Iru`"8<nt
'nqg&$TR8ia`^tn.gbVNQrDA;'O76:UfL%)3-=D_`Y$\-U5Xj`8G%.j")nk$=<25Ej'kO"KF
<"#:MTAj%C`0g0dT9j+?AnIZ:^BB-oih1!<(+oOUMt`Dau<c5U-SZ"\MA&!<8'*6sb(h9,Pl
@Bbur2FHdB);lih(&f>*snA'j10Ces_QI%U`14D0HEOp`>6:MiZ"YNXtP;%]AqmuZs=g;qc+h
6G,8ER<#ig]A_#ecMSAAH'A2HOe8o4E81kj"ItDhbZ1u:V"9QJOVe=t]AA6+ON<<<)F,n&OM$%
d0:n45*mskg/#_<EmfGLn44MVM4TM[(fM_rM='#@L7JU`u=7P!Pe&!%NX^:dL`FJ0#IUsTO@
3`4Hq,4%cd;"&6mHXrUpj+EIh^q1hU7hut_Fih1c*\mh@;N#+Hdf_0:*0?7!]AAX;Bh@5iF:_
Y>q/sHK3d[B4WJKQBOG7dNoc31<[_H$dTB`%m_5GtL7I#PS9%<0q(,tdA31Y3L,bT=U(6_9M
ah)0t4]As21eCM-uP_k-l3~
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
<WidgetID widgetID="93f9e692-63f9-48f3-9245-659a92b25104"/>
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
<PrivilegeControl/>
<CellGUIAttr>
<ToolTipText>
<![CDATA[定义：运力储备情况]]></ToolTipText>
</CellGUIAttr>
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
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ImageBackground" layout="4">
<FineImage fm="png">
<IM>
<![CDATA[!MT^&qh\-E7h#eD$31&+%7s)Y;?-[s3<0$Z7gK;!!!'\dmkb"E"DLFq5u`*!m@#VG.PVKb.k
<-B6rkK^/!3A5AL.s\'sb-NZ4`"%g69T-k+FLN,dJ')gO4"D"3W%#g#V#_0bHM!!gh*>ftZn
8io/kTinUC'$"V*cR3=@s[![=O?EVoG*lo2[j5]A/;Uo4D[Ro\Et%$o)uYQ"Y:-X)ht*<N<CW
uYI>J[,7n_Dn).#DmC"ojiUD$*NoCl]A>Y?@fZF!%/;EQ]AMtaJHis3![Ut[An@qKa]A0;VQm@d
KC#pA[oTW#ff5D@#\H6uXDN'^5Jr=JD-Vk>;q%>oEslY.%G++R5:0aV+85mjs8<VEN^_J6eg
^_8:u'HP/+fOHW<LVIaY&Qkga(Wf`Tl`&hG1G0u_!6&7jK-VO#Gt:m09X(6A8h#,tZQtVL'i
Sd#Kh0dJd5q\uo&,h'B^?'A7F;:LS^6Ib!JKUA&<u$-6c.(]A*b6fc#XC>PYHQ8jDf7`4Hd;j
Zhn\n[1DWG\$p8?4mj:RTeTh$Q$3`gW$-WESC0$Z.&\a_4?q;F_DCfK'-=1@/$$63@[EfEd;
=4;V.X!A38c_M(YCPtoqBd<BW,0r:]AFPWL&[#W*5"Gp^*`IO9N6PE;X\TBT<&WmuQlmb/'9k
c@*gKX&a?M.+<KNUJGef/-)$&jEV\iD;a?hsP0Dg.Es3LlQ4RlVV2$-U8K"6oLpBq"BU4F;"
Di,8d@IdD.WClT=7@D^nnhp^GCmortpg^9p+dIR.h(Zp(AgMa%;/8#ii"oWMS*ctuWIa-<@5
g%d7U#n4$Wkf`Gj22Y4K8cfDl3SG+96:5G?W&JRtt6=U$[rC/P(G)`rO:"5e`C28GLS+Rs,:
AfG>ar:!B!3TiMm2hgb..P;9`?S;:bq4!n."[KJb+Bu2\?]AY3l$NYnQJg]Ap+8D3qRTEd/8dW
<W#mC*7j3EYjlP*KYYYmk!mTbJ.hfT+_4H4*f-.YPH2(!J;0+CBE-79/.kP9e="-nY<Y?67X
$6:YmSo]A%57n69U^3ntAeL8KhIZMgA44]AC,&7S9uFn"jZC>/%?H4o&SY*cI(CP,?(^k7rn0O
Yj7<%etFLAOW[$gY>Q`Fdq!XT]A[RNL7p>Q"ar_->GeY`PCTH\F\d%I-)Co:R?su-mptP?V>=
prM=AegcJd1loga6T\g'.8X8_,BIqk`??De!Vr(SK.&hhJe*omTJtr^HmY2Y$?<!9AR+.[gR
0]AB2E2db,U429EH8..hOMH7s!4_R'im,!e?]AJQoK\7o@?J-4Zm?XP:K4mCEcZhukH"Rn>PQ8
e!rHK!q@"C4[^*?V56bGto[DSdV!IWF=1/W]ASD1N]A?]A?JujXNd7FA\45#_Qe#F`T>nZ0^QSg
+%P03DqmU`-u^r]A!9O??e4@1u-uP7C'_gTSo4HMjnHcG$$)RQg>sfYB^C>+\'7b`E\t6_:-]A
5(O-1+Z!Y`4A0C:!Z<a\lK'ru`t@nJ;!N'$!!!!j78?7R6=>B~
]]></IM>
</FineImage>
</Background>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!?;cgE*mBkGj2=9d1g*3?$78ZQ2(7"G_W[QM-jeDE';_,D"Yu4r)UIYZ9II1/$/W\O$CE
3_\7`n`7VTRC&aeMp,BLEKK#@\gR82MHB@gJTgON3b&W?(E^Eq\`&FXlPO_=s(u3G7fgf5LV
:C[Dl9leb_i9n)*t-\?r%-GR9Bl)LDL8&Kt2*dQf9a7)n(YUcM2-n';ilUr&/R9S+get'4?d
o,$D;]A^?>H=HDS:OZhr9KXNrX=3;nU_b,!pn<I8Im8.:V:kR^hKZ0_J$:a#\t7Ws&PI>(gXM
fRF(Fpo<jN#'b%[6floJu[1LqX`;;#*CXUUO#[jP:%)(+8>i3NX>?bFL.mf:7A/!M=Ep\r7$
Tatm]A)A;_dZHgb.psf7!7U.Kqgh)dg0%6Y8PfCgG67uR:H%k>elEf$=a0:]AW4IQ[qc)kY;n2
;BGSjAPXZ\9rfWV?/fIb1?/]A]At"cH!R!pNuR!cZ+M!_*H\BKfC:b5o*liua:PURH6M-4S]AEn
#cTnJ@jUq(J5>32`/MJAM\.uDQGdi"WU)NV\ZYH+`(NqZnf;5pN2's\[91m^S:YG=rIK-r!"
c1cR]AK<rZcdhkL-@4-AA15l:Rkm`UUl!h,>7K`2;VQ33#4Z^*;N$@:#e>h1Tui0;ZM`bHqB_
P%.K?m#c'U6"D.h!-aYs#XopPT]AC/:V51.Mf)\^ef#*-A\b6]A\9]AB('F!3TA[FCl[da*R0-7
U-tGR,$O+b[7.&h&c3fVX*'jOJp1q7.(VNokG8XER?k(t3j&,^l8Om8[:LphU"NlB3B9nSj+
dTC-HobQ^U2^>6aI=r[MIQDXaE(uVpmo&TGaLPlFHZmf^#Kfn68A_h^ml<_g=%%`B&8qYFB`
>AN16Ng:TIF`*Rt!6+!*I7Eh8g$+j]ANKT`:;ol2EXm<cEFq<E?6(KD+u2ra_[gWY;uA)ZI5L
8&p?-HG'\1VUJ&o29+*s!D4ThNFD.=C2GiYVW*?W$V(MiTPk./"Q"Pr3]AM"]Asn)M?&Xde2\t
MucmsBN)2bWLLg7igK8R%<L%0#!\gtNneJuA+mc:BJ`if(VEsEE%lh"F>^3[mILdTOXdM8<9
-<5$H7/;_9ci:19?;7lJl^l2!_"YVAcCL\dps'V]Ai`l*(5Bq*BR3R[`7LkY("3ZE_Rt7bmhD
X.\MI68\:;6%lN:FU(e69OXbZct3T"o<Z^YKH</K+DYJG[U6n(]A:Rc6u$<c0dsdhQ@s@<Q5[
;(9,:MCj><qg3:L\^$Y'OODri`'`#24YR#;oGYoLD4b<!f[mA`S_KdR/i=TPIMU!eOO%ATJH
(YN8+Y&LEV;fQ"85$(s`@/qrh%8`7ARU59*3U!';6`=VCp7cP!.[kP=tC6p?BiosGO&N,ls=
&V4ro,V"D/I.=p;&Jq`)1'bK=-Pk&H3^\G`D),23Kea+#pB2H7sdkW"s*VeM^R4$&qW3o>IZ
;))3_H8h;if`Gd2%";^=q]AhQ#h@nidBP**uKrD48POMKY1=r>ngn6C!HtnqmEEu=L#s8ria3
)aL'=DC8#I5m<8(stKa:!7oG.5:S%]AZ1J4*tTq>l$@nOi=&a4oY9-b%%22!Np-r_U=_Jepg:
rc0Cen[3pt%oAU_ON!rcRcn<#ef3]A$`bl4^UZZfG`'$pf=HG`M3[?j@C\\Va3l%R:O&XAOf9
i[\E\p3s8><Q3SXJYj4Bo-!>2=K)OdI.0M2Ou_+;H&@tK_C"n,e`TNK]A07q@A2!j(\P=5&XA
eU&p)0e(2h%mA'`kmWjJQQKr'*8e"#nC@L(tDS(`'S5)\aU0Ke_:H(dY$`QJK5ZMsEUR(iHQ
30Yl>bcEK>C9'keR7p_ba7&eh%^Q0-B<b.(GG'6&_(dg:2dfe\=r)3HJ.0!,e%-R4$kQb?"'
'/<m#%':FZsFi_^t;fXAn"BpO&1i4V@,Be-Yu!AP(!N,?jfu?H2lma?nfu)H2!(LA2cfVt4.
IMa&fCD__%"[lt/YoCHg'$X:%%G]A&L84u3i8n,3jRdm^lC`e%7_[i9RQPh8`PXCgEcb9_=ie
d.^99*Ek&SCbAQ_8,G4e3?PL%L(2!l!bo6o>c\]AKuMCcg3`T%bU/>t(\80)W_dhT@O-h6:T&
SH:@Be1+bmF3MUeB/>jEf.3RDLAQXL5m%&XY1Mo/=.\D\aj>YhQ?Z8;Mt4>u#7r4!L0;G"bs
\*k5DjP/Rua-%$Q%u',SGE-opB\P!Y+7]A%F7%a(kRR-#Qr:]AC7f*Ga'D`m?5mj%L[cUr*D*X
P&A-dEef9)EJ&aKF(u!XgL8H<(p[En&QHI3Uhr*LBFJ1tHSOOo+N=`!4iLb%.A^S4sh4-/YK
cH>6ga\kV+&"17gQ%6O1A*[W^`7I%=Z7_J]A5VnYd85$V*3&mFQAp_nYO^$Rqh<#'n-Qp<CIN
,sFK?Mo^80e88e]A!@h857dJ>i44Q+r,4O_dSHZXIml>:CRW%e3d"XD0o4F0%^VkWA3qg@llE
Kp+Gir<)lVqbMFnE&B1;84L<^]A..jtJ%rr,.ed!o@"m5L0aGW'KNp$^+(&h?b)5`c"'Yr5Ar
-Tg9&]A`KOSb@eS]A/4n@[+6B#,l-C8(%]A=365n'i+P<-A*Rj(,S9Th)5Wn9/f%JLj%3b)gf\H
'4iXm16@*+eOGCk*6m=*;3YNFt_(&#5\/%UJm\?is*HN=jq_)8.g$%A3^<.8"quoRb%X9$"j
eEL*MY(XF"-^<Tgi,-PK[ROKFa9Y?]AWQ(cH.f,km%H')2/qR1iA>6#'epIEk1Tk7lPB#j06l
s[]A.FE#FC"_WkP`7AFTqMSYXFu$%VrG8X8OAotiI<V5#\blb+!c/74K8?WBTEN4HXamkdKFe
/$+i$(K#1hK`R>*K6jU&Vt9rrQT9K#(D.p_XeV1rV>Kf'=7(9>9_G?b,U$qs>&$Vr4dLj`!L
>BI@JijoPo>f;ffIut]Af"6#k1\$1/#Qoo'k1-aSFko0_l$".?^AlKahH>>+">*GRd=]AfMYK-
Cr(eURoj@EH;I&hmjHNrmW3Q[JjWm[dUGp=\X[M#j_:0!neJP$b9CercoV*r=7?rZnuP\'^u
&nZH)qIFm-=V-qh4R)pnu>cYY3[k\KMWj'F$;>t)^21mV-]AW>SK1<'Y#aR:t.=LV2>L6]Aoi>
91om!si9Jdu#I5(X#85h,dnHi-LfhkG\";D.f&qqI^F9^39u8C\OXa;8m,u>"V<O[3Q61e?c
QBJO>mA+jH*-]AZMd2.E4P#Vu+7WGE.Qll\jcdMs0d617lK9]A0FGl3-_=6+<P]A;J/O0_X6^)m
YC)jneoFBIM?@oo#r0=QRoYl%e[UDE@o/%9:ft=*]A;R=R*:5qo="pXddhfu;qn)I9Ni!MVJP
Td9Ba&A\'RKh]AL^#'5qA1XUP8G.bp,7bkrd)TL^2O_J\f*NeS_iP1%HDGSafLr_dP3*LY5l4
aDKrDjR/5&o&_PJahruCgp2bEjB_/%uM,Afs+'K_#X511RZ$P/(@_:/2]A,pO_pd!6_DDp6kf
e<T]Ab>4c'?lWd1;tb:3IG&mui]A*0h#nG%r'-E]A)SX44U>N*"=E3aR9NVRsHAg=R4ga%jm?&4
<^#?DUfas+rN!%o'Cl"V^TBo1P/<C\#[jh_[de!L@!/J,M9MV7%O$oCdU(mAu,f,b]A[N#OOP
,3XqoZjW2H_%,NdRRX=1Z6%G?_)5qBP\sKb;-L7BcrM($[D=;%OK&&@gic.*):@';fo#u$>X
64:(NE2T`;)$JigcU83'ZM6)77M482NBn<qT&4P0@IH/@A'g2BDp!N[),/.P$&=>UEI5,]A^8
)V#A!('Yu&[HkqMuc`!:c*sPn9"0J7a0)A(PS;claa]A."&D$MFLno_^E4VnHI=+<Du/;1Kkr
m8T'/4lK3R(iQ+<1*W[PjuiR<)>dN:>PU5;R?hm6Y,b]A_1(niC+PTC"s;/f6c)rX!stdE#2&
e-U&qb[j-`^iUgo%N#(.-;(l()4E6CcN7aT/jThsZDkbfC-aaKf619<T$M,U*Xf/'EgP''*1
T;68$U<l=+qMeC\AaS)*J`)6$a-I6^h'D96$^p5h2]A1Oj+(?HlC@mECn`2k1aL(A<lTRHJ'k
lq?2"h?'6g"-&4agj9:`5P)l&1kU;1&*Ua;8]A+-IYWt_mLV,R@,oaSFuf%Y[lfF%d]As/!1"b
o7Oe@<8##uC5\76'6@hp!AE(ihG.(mqi9NRXYPW]AS0^sSJ8#rU(_Z'sdMNiAiPb_Kl::TQ'q
%piLFt?Kt/+cG*FKU)(%+</=!RgT\q[n0b7!&H;=O\4+4dfK1+'WI_23O'3U#AslL(5M,=KG
0aFZq]AYckWK+J>ro9GQ-Ka3LhQCJVH=tcqCTZVi&c\_0>#KKO7h^="Dp"B`^$'Y9.n9\p.F)
\AEGQV!W"()-UTs,/[Q9cIF1[6YaGt*Aei;T2hc[LeLgK?QZhai8[1a=P2u@;[`BDUL4#\l9
ClO"_E)Q_(2EirR0D^o_.moAob+B@@9kIP9m_:8KaJDLPB805*;Ndak2[jF1Q%`IJ8I<0"GK
RW1P"I:*K2oWA1[%0Hu&I-6)]A+,(T]Ar'5&%(J=gXk8aUkfBWJrR[[&<*9f?N<X;2`#-D\CP3
$6K6UUflXY+C3?WF:3N&3gu*1UVk&i2bVEdlo-9PAWW46)TP'>0SfhCC.OepcENn=6_.HY1Q
TA4i;D>hij?+?L*kJ`9A7U/+G;_4B'n0d:l@<=@Y]AB.&24%o!Mj&V?]Aq?O&..rq9G0iQ#klq
>SnrV`/\lmfRe.%ifQ!MAI@At>rU?e>@M5uL3&.m7h^%%1iI!"(VjfO3)!ZqQ3hY_@@i^E'J
G6<XbQsk$D?W2Ta=G;&#sk^lH'Q#Vl[!TMKCRGKOFc[RR#MRf%JM\;Z8#gndGLOb)aO(q6!J
K2&A@ja4:^I2lYOq!!8(Mf9X#8:W10I,@$f-QZ2_T&L/A41>NZ69(!)5EZm?M=H76n;E"N))
C-4B+!G(b#0'$4\h-R1FL"KJ/k,RjMc,LZ;$A9h+TtM2HB(#8`L93R5"[BHecsaqi50rTD(\
)^*P8K5X;H%'!!g5(BiF3F"7\Vt2EO_W6@u"YN&'i)@-m\XCjZ4cpBk%*8s+H6=S(UNW]A;0k
XVc@%lt:$(qQpQT$41*+ZWuUr`:G971JuKleM$?k#/@f(5Kd\J@jI3q4F>Med1l(,0.JNt!j
=[$9\\dD!mr(kMD(XtI_MfbW=8'rQjmCJ1bpT[))sG]AF8qZGbTbmRQER"]A=S&oh.)9%UGi%!
k$6#3SQEW>&)*2DW)sX-SjaK;SJaaG=$>'QlFb7-@qsRiC<qY`t_)5^fk$=s73E=pOYtCqr(
t]A_kg#gq`FIr5j&+e<^O)F"G:_Zmbd>Za&.Mi2EHVu^KgB5c?!_PA@UXFQ(VM3>!6V>ho*CQ
b)NRP$&fg<MK`nP]A4pZ:VfaT,ck=N%^c@Wj:Y$U?=QiB#p);sLeS`/B_:g61lV#6;B$6Mjjp
c/c`;Eo@$3KbkIklR`Y.8:_cFml=8Ub_EqpKUP))(D_n=iM?DC,lOfW\VijY]A'iU2LC'^gRq
qYCjq8%`DjkguhZHq0:S5eVV=^/lpU.9?9*Yr^Hqm*/<^=\/=QuI(8oh`T;lpCGA>Jh"e0e\
AotW]AHVbgKq8/40f=@<$,&qu'3*EMfTTjXLh3?DuYb\RX(^&\G"E>#AsXT5[h=M5a(lS%&,k
Z6Ah;+ps/(sf6_-<mgElR`:8V1"?Z4M@qp>>-4K(\-=@p-s!n'B/6#\-D;M5Xo*%ni#!M.PJ
X$N,XoJo237rZM)+sH[Id3XYktc`VBlcmp>DpcM6ntd2SGbcST:6=M0)>NPtX.g,\8J=rrtS
D*80',29RRl*l6TL,qAs3afFKT6d`G(P1U7fi$.a9^jeS^4QZRPU&;W(n0-"?IWBn1TN5Qjo
T#[-]A'iXZdrb6_`H!-h'_S"86NTp6urBuok\<OWf+@fJQA_FCV;!R5+>t0:'Mm"IR!R73Hui
B;.g@5>kX8cZg&U?1LLmYhCo]AdT@EgN&:V=,Cus(Y9E*t(^B"~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="129" y="21" width="59" height="43"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="chart2"/>
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
<WidgetName name="chart2"/>
<WidgetID widgetID="fe0e7cf9-02f9-44d6-bc61-f8c60c3a7192"/>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="9" align="9" isCustom="true"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
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
<Attr isCommon="true" isCustom="true" isRichText="false" richTextAlign="center"/>
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
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
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
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
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
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
</XAxisList>
<YAxisList>
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
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
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
<axisReversed axisReversed="true"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="20.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="true"/>
</Plot>
<ChartDefinition>
<OneValueCDDefinition valueName="执行航段量" function="com.fr.data.util.function.SumFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[TOP 10 航段]]></Name>
</TableData>
<CategoryName value="航段"/>
</OneValueCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="2e5a8f05-9c0a-4b3e-9e17-1a6b10acab17"/>
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
<WidgetName name="chart2"/>
<WidgetID widgetID="fe0e7cf9-02f9-44d6-bc61-f8c60c3a7192"/>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="9" align="9" isCustom="true"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
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
<Attr isCommon="true" isCustom="true" isRichText="false" richTextAlign="center"/>
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
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
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
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
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
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
</XAxisList>
<YAxisList>
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
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
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
<axisReversed axisReversed="true"/>
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="20.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="true"/>
</Plot>
<ChartDefinition>
<OneValueCDDefinition valueName="执行航段量" function="com.fr.data.util.function.SumFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[TOP 10 航段]]></Name>
</TableData>
<CategoryName value="航段"/>
</OneValueCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="2e5a8f05-9c0a-4b3e-9e17-1a6b10acab17"/>
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
<BoundsAttr x="892" y="50" width="243" height="167"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report3_c_c_c"/>
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
<WidgetName name="report3_c_c_c"/>
<WidgetID widgetID="66bfc513-a259-448a-9e5e-c959c35f7de8"/>
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
<![CDATA[1402080,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[8595360,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[上月执行航班量TOP 10]]></O>
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
<FRFont name="微软雅黑" style="1" size="96" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!?;eM]AA9>.]A4>BX8R>gb*iL"_g"W*BDGenS+b9o!:`SRTDn[Fc7O+soQAU?tmYSXS&%'I
fAB%@2,u!Z!(c6=NG4&]ALPr$8a*W-4gbU,Y0'=EqTX.[^sZXj`rUeQSA1>cXY8Bq(?s-pNqD
Yn+WB$^S?tT4hB_%J:N/qM(c(0O+;aNn,WPG?C<SWrT()o6+m:">Q0_omY0Q]AQ1\iuGlJfUY
2)$d8?G,S8mZW9LK/n0qjZVIQ7W#0op8=3]A#BI(MkF]AcL/%J&rr!9Xp&(Yhh[khTZ6O/KQEO
#)A>FIHijhsU]A!ap_Y<43c3]AHrep$^4S\ar8=?I&l"j7GIp.,m(',D4'o[-$*F9<[,pq3V!)
V6hkPm@@olQOtY6Y"5^DQp%P5$+c8nZR)%]ArC<E#7fJTk'c)7(l'lZP7Wr:)WB:I,0MBkY-k
C(6Q*o]Aq=4T=#dN'A+::IW,.VAB64'jkJB!D#mEeLL'UH=.0jNfbUkCeL48UmQld&X@<G/^M
3DS#GL7@RSsJ5EF2<nH!PESO57b-nkLmR3-_AZinfNUO;/qGNg^3MT*5ekU,(-0A21iUj$_K
05.Z:7+0dFf<KkUH8!(HS)A/4H:/>e^lOW,2b,4$Mp#@P7n2uqJ8f#p86N14]A7`'cfefpaX@
G#^%A%5Llpe4=]A)o+JTGD$2Uun%]A?nFYATsX]AU6[U=04Hj+dN'$'g/Ih2T<"MMlaKJ%<PB>`
\MiOE:5*C8F2b07FS]AZe&Ria:Hqo1K[GbqYW[K.;Ei$*d1JK<.HH'u:E!0lHE&^lZR]A@[b2D
dU7DU"MIO7a_]ARdkshJ85+REK1ZWLuV07R_D(Gc>lrqC*lT$,#,tAVRAOHR1.EKVR4?529=p
ID',?Cb!_7^%/K,JH)@WnTf[]Am[D*^[=t`O3AidsocFf]A:?c?tgSje.L<sa6^mr!=.?uqr_l
,c4K1Tmq3ro_+L$Bp'Rd_9/Sa@E.)VE$N@U)`@[^W%a(c$#U;Q"E"2ra03_<qM%V/>iej[K_
F\B@m!^bQi-KG2;0EDaa&+<ac'2Y;K\/r);Rr,a5\"qKCgI`Sn;%F&r=%j`Bn$nC<L,iMK_[
X#FPg9#Y8nBD;CI/$HS@_am'_X:ff!pVFS,]AbnqV5aedSb?XVQY'<-dThKqUl^L"&^^Sdqj"
))?"*)uHZPDqge(*p5g^KhPDm`NgrVncWKu;@cV;e`HZ*r``RT/ZMjU7;+[&*tt?Ad8bk/8-
4nVC>C%fL62nCdQ@`m^fGYV.rj%![1-lBAE^XF-_*O#W%u.`0KEOkpm2c:s(GnJUS;h$-k,q
,(<O,)SN_q(l/SP9b18+iCV@e@4f)Q/.8-p=d<Emg@'[b3QSf[/8$V-k'ep`jk'<$iBKid)R
I&R<^a.3sXWnO$C9=B2cN!r(T)P6j^N28,SD<O+eF72M9f'>N?W>^<)5DBCc6LOg]A7D+;CXQ
%=a.PB(]AN9g,>H8)\(+q9?pPcVUZ$$lGWZIB6#1k5HFWCAg;N=`k'i[jM]A<D0d"i`D7T$#Sk
E`ajMW"`#3-$M_gn1@+nAIdHN\[jOQ8e;3['B9rF:*'7HE1mY/Ea6j/3JZ7TLcm]AULVSQ]AlX
qNuhZ")7O-2XkBF0nH?u(m4SH8O<B0QVN:!X/5dH7RFq0M)bkT0RhILJ^_0h!RG.@:n+\U)Y
_MnF4M!nIeS1K)FJ:`aDUOnh[#1=Qn!>b^m.b_ASVQZO&,<^lCAdm70fZBH`>&R/:CGiAR!Y
[(LYRPMSj?emik,f>+'BZpN6ri6,4UMceA0O+YjU12PdqiB0Y@%:KJnc#-ueciodUC73HK11
'IGAD@;NFpXRGtMS,8Vk#@7`58`lasRL>skJK5IBNR?<iU6NK?Lu%tnR$H.`;lgC.5NtZDa;
eXdHi[#^p8SWDoB<kr=s_=MX"b>':OlYg!.)A7>ZK#GR,(guf*RVq`'n:5^Xq_hfP>&WIkP1
\PT?MJedZmi)u_!n:)Ln9ekqnfLI_AQnU4g52j=]Aqg*UmJVKd$<Q&FuZ!(J_K&K>Me!$aj5^
;OVFSdM%'Gr6ojl6:O0.FU5gNO@Q1l$<Pk5tnR:(P%0d2[[=_lYeJSD,[o0UV>dCcmB<0d@*
t7>smbkY$h4MqeQMVFX7('a,Dmaf5o>bXj<O4HOYY32SMGN1$]A&dpB"_KbnsHF#i1/KlT,F"
H/[Pc^V#KPaV\*(O$Ri1@4*ttNfL3orYcLGG)Ed:TF#9QW/+Toq'p4XH=5cp?hEmI;u5Grbt
?2VG^b:rh9IW*R^)B<f$7I9Ur5R#Ll.:WO,VulMBiggaSJ$u+`H28.WR-Ep&[Hu31c&)aJ?,
]ARPI7pRet2"YTp>$X>U)p/,E5a"2okB#c/QN;<cin3h-KWV^_h1C/]A7/A-%9t7k"K'^(#'7K
]A4B;lVOpB]A6q2b6i`C^qq7sac/4AEdi9)5H.+kV^Z\#Hr'1"u;`j]AH1'2[K"rS6[;0WI(#R4
q\G-_D7Mh<&&-AWOEKuN`t)`UZ4_L.6"-TW,P7*4(i+N;J?U)F:Ep6;)WGg;D-%#&,71^jba
]A4q;`=N6)ZH<ESUd]A/a;+UG"2,4#d/5411)&_]AU0cr,.&K]A[ZIkSRS0m%2BkPgCUcccAXiqn
GCt1k@EQ<A'bD3Q%5P+Tgbe1t;q2rKKf1_*,(0O%72[N$CP$aro0b88d_'1NHKK"#oqd.aZj
C$HC709I<0X7sP/am)u*\k)MXE970e\6QtlNDt*fI'gqnX;@[+P>.b%_PN#n'V2bFU)gA"0f
JOcYc=g$mJ<8k$NsuD\Nt-b\GhsWTG?^^QOJIuC,i,4,`a(,;&U!qt8o*Lse#F-bb39/B^1.
'BO-R.m&nhZO\W&U9G((Sb,?>\qmBc\Ca7''D)mfDXQA5I?`'6A(K2?A@g[$24Vd>i'Wafg<
*/B[>m*lgi!I!@B]AA/UsHOVbTgF8A-0;erESrP8)Gleu6LPfol/jE-L;VIap<`U?Ral:m;6d
?h^DKh_0;G\+:rK/Pjm.\ZU]AR\0S'+FqjJlQX2c#qm7@u!quVje!;&QF+^WB8n<j_*Vda9o)
p9,u%eW83FE550ma;%^QoL:%\_-$0:/0B[7M,,VDG+MZtZR1AEs`flmLgEj`BGI#ukKD+;q3
"(8nN@g\MfQ+o+U_YhRU<=T'`QHtBGSaB1lM5gtgii@m<X@UG$$c8RrrmlLhk<*>n,u/4]AM8
8'IMTK\#68jukms7Q6?:;4La%@$?qO!d)C=d,+W4Zq>Co4=TiHkRksfNq35ODl_V:sBiV%<L
F+drPS`?s9m`tLTWa`Q'"?a0Ga.?'LA)O7o:=I9c&"Mi+l6>A&WNj[1,B[I3pXr?4os,R2<9
kTNPuj_</I/`^QT2jfq>:Yg(O,5XQd;N0q/#e?:L,_&TT4kgC:AO-XH(=nRh\,MF4H26*cCt
%&odG,HJGFZk-3+K$u`F3cZr_(.gB^fkMQe]A2/a:,TXW70^j=VrqI$gf5ae2MC%#XsbDTTF@
6:-)W-D*EaGNXQR%DTY.b^is<CVmhWoVESK*LMP1cA9%K]A([D_YY!ZB045eK2u!Tj<f<fR@J
N^IEYoInaa2tE<*;fXFJH[NIE#\gV*lu7[''OXTOmpWg&_omX?hI^X^T!.Rj'g1^bcXUtTY5
]A;#h$4#!`F/HZ1hM=>kl(TX9f"BJ^GQnud_27ESZM^S^`mYG6%!pJcg=bmW[;I(RM[G(kAp]A
EK</p"Cn#0t1-.Fm>Jq_OECJ_54H=6$e-.sp_KG^jmkcNFgWQWnmsfP9/:+pn.[g,TPQ&5"-
IP+-chYh.G#?6nkc6"(_tnN!HK),5#e`)KLTjX;dMD0L#!NQh>8SCK!eeF5VUP8Uo`KIJ^'6
DtC+aO^BpV[d7^rUX&)GOM!5kHaP?PPWDqib^/S`5]AipB/^PUZ32CnhO0;t$rg9r#UU!em/8
:;(C:djd04QM*YKi35DIqi&11rZG1]ACiD)YZeoGO'8@GQN)6B&RhB\3uX[2]AZFI[`QZ6RQIT
<`cS'/]A@3nPQi8!0IN&d$F$l&UUcS@_Nh"liJV?=XUgfM+Vs$1*U)nHnFP;\;l$3/L`5Ec5D
-E9:cs.,Y>($,LF?Nl?:.DolLplZB+3ouE(FdZ1Qsu=)f,'df(IF-+%QT#!BPO9-jn:C+C9Y
10lrm5Qh\m/42j+B^)'M$6;e;_;cltA.ImM[Uj[b#i-((5Fafp?\OY=MN=8>54tjG.mr.BP#
]A"Rs*XCIIMQku99>GpeI5'O+8@.UBF=;("-G.ga_`aJ%f[1,CgX=^r5.;&\OY?2-_aIC<-G#
5oSg*RD:>.VpUlDl)3hufk]AeL4h[Jp:EJgO+J3<bh9,lK8/QCE;s.m18&f'3i"DZ^EN:>[Lj
ad>sP^Ed<.U(%!@P;VTUXPtjHC1&+LC.nK^oF"^"YHqKB9F2EBh$oDS=dibh[%Je_6oFMt;T
NLM0Drs`fAlHGA7WYWgg*^n\(Hb+lCE>@OEGbA/Tf-,E[r\.bh(\/iB]An\jL=j'-:R'e7$Pk
QW4Ij.37-*C<u#l`Fo^e+muYKW7/:+U?;sJGMah]AuA\`Krd\E,pM#pLJ/Q-UF#/,_L[P,R-[
A?u0B5]A+ca3p^Q"E=>'RA6<M;ja/noWNdZ]AB/1*N=1RD<**.X%<Bc&8,lmKUh?$#2QmNc>WS
-QSITNGN[(CkamnL&_dG-uCD5ks5F]A[rYWGl-ElZMP+/8\P2iNu;8-_lKSs5bTFi4>_.)9<!
?4l"Ws4`-BiCR<PSsOn;@5Xg<n87Nt>I-$BE^:e0mtu&KGp9[/bd>s5m5DP*SFDsS"5@3eW[
'N;:l[qSbl95H@%E%V*A%Mt:I;"oPVO$3@0I]ArW'1t6?='F%7V#+6VY^\1:YTeXDeF>5L1F2
PEcI+!8(1t+1EOW+=*q78E)oj$k>cgtEg%Z$dsVci2>^:&Y\a:>I_$L#9uj3So?)VK!:g0R.
]AN0P)OO%C5@m`7No:,F:kL-o#n;gbRX9^Bj/+a-RM'bK,V(*]AOta5OU6#EQ:h.cXq#ad?9qJ
G]A"?\#mkNCCF(\e'n%VPBRpdG0mV?a8d_ZuAGC5HN'S3r4VL-3;V4';Ys'7D1o42>W!n%nfG
C=15!Lq.(="!S%31ard3s1pi\LHQ",C2$!C'k%A\@e-T*bFX=ghZ+FH;V;Fi+No3b(EfDE_-
=Lgo*Kfk%3I`2b,PKU7OsZh/;X!>q8,nSUH=OLldrV='q_LfC!;3FF)M#&L*(sF93b7u=1re
KL]A7e~
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
<WidgetID widgetID="66bfc513-a259-448a-9e5e-c959c35f7de8"/>
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
<![CDATA[1143000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[5090160,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[航权时刻匹配率]]></O>
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
<FRFont name="微软雅黑" style="1" size="96" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;;eNPZcK[)ba5[#*[B5P%1^-OMpfJ:XOAi3NPgjCO.H5t,[@jH4U4NNlCM(.-dh.a<#Z
Yup9Q.-Q$CE#i)%&sHA3l0q6Vo4$P(=b7'dMdbaQ)'>5&PLK3$2qt[K=H5p`o3SkM,mg^V,,
Dn*f>45J0Eg]A^XU.5s[epj58Lt,:MbIHr/0CIfHHUU7^d6q:oX[cr"i]A[OlF\rI(b++Y2YNm
Xa\:&h2AiI6Dkjo";Kjlj'macCn<tepdS9WVDO'oCgRBNe=cRe#Rs5rop_:T?uTqV87%in\q
jp`2N6af5^-BbV.<k`fk7t7F/q@k@>%Xl)=J1Hg>kt</B`Jj?JGjO#U=3'0=t<UtZ5sMl%2J
M;CfHOO'fL%1*bJkiO*b5#P!>`ZeepG($RGKKO>7Pt:+G%]A!2!l,H8Vq3/Lt*,66^IQP<E[]A
QL(/LnfQLT\<e9-%U^O%ZM/cRM!7be53#F8o1=9-%tlIDZNFB9lk-%"XpK-lGj$G&e(]AFl#&
1$VK.:ocrnbA,j.E`iVhoY#1M_RhOm@h*oS8[,!fRU2]A"WGK/i0?)&e/FS`D2O=$5#;O8B-(
Yh&_35'*LneTnLE8AY-E8Rh0?<>sN?Z!qNGM,6/E%rX)rKlm;lHYuSM\\obg`"fg5+Pl3DC5
*lm_Nf+EqBZ8Qe7_h/L'V%AmXrB+h-iQXn#@;S7Sb4^j&dgrc'M_s(Kl\g9um0W'7aBnET.h
M2VP6!kX%WrN\5oC32-*n?M?"i^Jbo.NMH!4AtT42^iGXeLI>3`TVeuM)mDh$@_CWRoYrpWG
fml9odW-SHQTWm4rUU,H=th4X;qrZjCq\N\nCqhQj%`NiLuHoN<CdX"q^ji"Dtt63d;bj3#(
(.rP!<r[tV$VfO8XJ.'9lPWRW*n-2J%m=!+2U%B1oN"gQoUoT@9M-&961M\RhZ:3)&Um'-W'
<6r4S6Y$?)`>!55gRpl6\c2GCK.l,?:Hp&qN<a+$o\YRZo5\Ap7CgI8.hup&p;iTah5ZQrZ>
.Q2kpX9UT2pB/#&%]A3,_lB^nrfNkOtN4Ch%GUHgf]AFZU`B]A/p'8?F$>S^S.k%do9L4e024TJ
l0h6.<TR&RkdR#lVj$,Ha""bC(Tp!8g^cS3'+#nhREW5-Q6@;QZb+?c+Vq"i?1[X:6JnF&S)
c?MZR.j4aSJ1o?Uc^9T_$)9TKs=6D;trj1\r>BG-d7,8>b2OD]Ag/WlQhEeSj9Gq9b=s_6o\5
HgbcFFUt/]Af8K-3Hc3-E:[TlNdI^;;&Q>UJ!=u8tA#b<7S@^"=H*`DnMj::!>cJ;&rdJ\Q"g
\4#,D7D\J%rD<iocsfD"XG.?6u!GZ%e;07CZ8X(%I9+jj$0$XTmnVH)6KK<>;@f,LKIZgY4[
fqEWe96?[Ke5Jl>mt'"Jc0Ssg`9h*f0>i'61iDbV4lH<ptd:pKKH09\5bFT:mloM5<Un,$%d
n1E9<X48$49hf5IEB.)[YUd1p9!`o[cP8$7Y>"K:+"c6rH?*2t"L3Uh]AiiFEoZEAGP@Fj+:<
ODm?`d>JD'NYb8Qjh^_ci0f55%m&:WKj<9$3Ebam%JOZ':uqZWnLEL9:lf-h67^cF**Bm"[[
>+;7[4rjk0SH>4B0h:Z@[hbTUn`?#4T_5-76s*FD"B[*;60S"Fs5hV3l_H;Jg)U"pu]Ab5>%-
.sG+JEGTN;20>qQCZhS!4cnH+3gu9S>G`;g(Z8r)O@MKRcO]ASd[r!YUB2$C7>c]A!9b9^AM4l
_<,\#E%:&,(<CuPA]Ae\3=Jdr'-^BRbrNfLis2/HfbIH3U%J^Q/,'4m7[Fi`Q(&.%6K,epf`Y
_="3q3Kk'Nol1K*+s8(M7P<jiDo@`u/bS90qA'rPf(mB;->8,d4"$@'7qe("_+o;-!e1_'EO
`*<R+?DHLO:sc[Q=4i//`6.TRDlN)=nH4ZBFVG)N;dTE=XCLk(^bB\K'&r[4*__XNQd-Y"<d
p*arQX&V@nf)$!h@H5L2!Rt1DFZB^^>f4^J!K1UdL4Zl$QTDV5/QH&@E<Jc<bC5eq\]A%)S0K
75:5]A,?6-a[X9%OiFU1dm5Ik\Tg<YH]AUrNTm4.RMd5!:"9iX&%C\sBH2@bQdIB!>Pr"L&U/O
s]A5c8EM!Q9Ad4nCur<f0JElVSZ=qI)]A`U0),=OH8A*e/'@A9YmCUAo9D:XkX>)3-XgJ4p[3b
/U9G?Zi:+FN+B_gl]AUDf35#/U4/O)ta=(8=&ef%?]AQc6B63b$eZKCcj!TVRJGDdcX3BVhI`t
T'L=C?3Ij25lcb)+Qd!<@((Vo3\jJmH`^7)1j>Rg,T>-EUY#iXu8#;n'gZ?9+qR&E$&Wf)d?
bJd+NC&nAc$L%LJA[BFfu)*ju_#TK'<eBn)kJGKrM&F_M0S,dA/YpV1r!;16?S.5Sir;S)X-
mIdo88quc86"FY=#Y8@(!%Wme>7IX/B;LiK1ZU\Zj,"pHF.k%C_\H`\s3p9R493[NU`h7O8r
X6m.aI'b*VI$)LSkq%r*O;p5=2mXHLD?UV\m=riEeLG#)J$CmSkP6o'bV%P"!KeY1(9IZhW7
2g3JhA"d#1/rT%PFN>0J8>&YL;S8r=jLL'"l+lgEB*W,,i4YhLj'^[lcsT\m([tM-2M:]AMpA
X(l$+);&aWPZQJ2NOTXs.a^H>bUYD4XrSi7+aDTRCmMC]Au/-;n;)iM#;R[9m0$<?]AWqNbSab
IFa`9_86$$g(u?4NJp%nGjFY:41-*%F%El>3;I,)1Zu1^qq%1cN3mGMu&XJeF\HrUJm<J!#G
(fXnG0#cGAu4NNO?[M2qE73kMFI[tHlEbs]A6lcsMf"hu?BXHXCbtnH2*_I4$5!8)kXok'!S#
('.pK96RZgbcbsRJg!1mdFKd%N<QM"@c/@in4S(qj'n!>\CEq"=`d$;C=Kf]ApN!=lRNVb%9A
?fT*,Nc]ACI-D_rMM(T<hXT<(m^6DO!O+dN;U4(_)o:Gsh>`<t[BpSlm^.1P.3iIC<^q7sh1+
Hes!&)qjT!EoI'U&#"LnRrb3jnP7fF:k'4j1j81324E9N(d`J#i<SHCpaYhgGK?2g7fJ\<lB
#;R)Ur%NM9*G&Q8j=^uE#m$`2nTKkDXpE`Mo\jgCV>a'"oBnO@anH>*n!S%FIAT%(f=h'Y-n
<GR==[-cRqd'$&TJJlQ*:&^]AmlVV(>Ql$I5@<HnD?jEa7I(Gi&cn7X4^,CG=,;XCjEe\O8Wf
YY1S$P@E#.g4D\sB`*cj>elmIC&R<qY"j,-;.M9>qU\+O%LjpA9(7^u8W/q8ucPd'p&l$s0N
'46<^Y#Ks/0Z`M6))ZRTB358^kK?0cm`-q@K*/&tlqjJUra+-.blK;q\bSfJo+JQ>L0XD8I6
^g7Sq[U\"hZ<!_AD,s=,,^YA)fb_QY"tYW&u1]A!RJ.o#=p$3#WPoKdK.g4#eQj3]AIWKO`dHf
K>ip6K\2ok7^OZ/<;,O7TI%Cad=)>Rn":ja,a@_5M#&6ds3P0\Uc`^_Op07B)4?a9@K'n,M7
C4JSJW>]A%V+F`3i-)P>5au\(!rH_orSIh7g]Adu(KB72<fBp:U=7@>McC>q/S'SkMj]A;6PDnT
HXh]AVIG7Ch#NZs`AmqUt7XGF4*PRsinrEpRsH?d^pq.H&0f@gFnJ=?;'R<VOn=%ZRL(*&D$?
jLtj7jP6e:;Z`<m?j7?2<!m5bk3<+G7-nrm5$L]AC'c_AZf<:#A7rpjHq9?rq5<2;p4]AWb34f
(K;kAp-V)Ams4fdBiI@`J@e&Mb4)O!+*70n'#ED>4<fX<YYY3a_-?hN6rB;.b&8cW[b<&Q9%
n)BFM_+N9tCrlhj@=H`kM:2qpRo/>2!`F4#&;9+o<a+V_#\O>3'B]AM<M]A"62Mh&0=Qj9j@b4
2%9A5i&Yb5DBbI2lrS,:D-M`]ASPMo4u^-.Bs7dFQfT5uIJ=A^bUBp^YYlmXp0aFU=qn>OS>`
8W12q==GOW0OkTN.6`,3r5Zj?en*srl!okWKZ=,/"WBit80;4!1#ecDV[*Nb4e/7WBSB$.^4
-<2?e8<NTbQrNa_;+f94;mr7L+W/5I:d"R,3USpn7%!*!5&U+T_riRD+1`c%<#<klBD+8H;>
:4c;0OHfeuN<]A?):q3P;^tLd*$YUb<O$`#g<8]AbF6n"HHpt)ppIJ.oLm&.^j4QM5Y9a4q/FD
%np2J1F1Zfr6u2bIYn"`iNIZdhX4U=OQW2<?B]AbC^_1#QsQ90n+lV\\dD93;tV@X64b\<pOb
[40d3D;T-*i<m]A"[XQH8c+&>5r_oY"-dZ8UQU1+kph>ro(;KA#"A;:2X;>paAt12W+3QnWKu
.!JRs`fma0n:%%^igQ:513K1nDTRij*afL=DhE)91^M]A*:9%-Y@e(EaVW]A6sYnh[Cim_%LUD
I&M\;iePikV>Nb>9$I)8k6=+M`AZVB6*ao7>hOYkX$B&XaUth=J*^K+K6kLP?)*5X3?H>\OL
riVqe)"0?k!d+#!EdANn<@?KCZsikV9WrJRo4![lZPLT#VO-ku:YDa>"VaqA!3>C:\DX5R_r
cKe4n:e$EBdTZ%lhL*1-HnYK;Qr60=bK&$YSH:.fuPp&hJ&\qT3fk*Z.#Z?5RAR8Fi)eAdST
]A"Rk1p1%Cd5/oMKiQJUV96^_Ud2%NEWOH'`>:LY49YLd%!d7-<g5ZTj]AEjK7tbRgTJBh4b$g
pkJ<L3oO?<Tdj6'#UX@\&1-V,]A'FE*I5b<JD1r5HZr;;<)iU'^7gIG!L&lE>M^GeSGp^=gL/
jp\HB:AMSq_.%S7"(1KS\*O&HHhaUhgo'bSlO1QgkCbOTB5#&t1`(c/NKC);Efq>,4@=V>#P
QBQE-b8s)=%:,QtZ;6P\DHBKJ9\#3CAE[4YRIg:@*.NM&L!1VFL6$*3cqMbINB11R,q%L2q.
\0p<KtbiXp"/k_[aoo#Kt:%!iDGV&MG;;%Cm4i**/OLPk+,=!GeC4a82!<b$r!]ARNgQ^o2+5
Yd0f[;>oHGct;146'srp1S.YSB"$fmT+Sk6Z3"k%Is&#o*aQL;Nf&(aa:.sgC/1jqd8EPQb[
)hdS'q'`#o'pcCB8*bIT;>V`t`FV8'c*5,@pGC]Ac5(17O1u^fs6Zm=E1f8/skmn/]AK'n(6Vu
Z(13!d^X1BgdNU0^OQX5D@5'T/-1ag\N.M2;*"ulLpJ3S9T]A^Q>BX$=f18u;j=U\!**q".W:
B%p=RN==gl<-'Pim\GJ+9_W[I(hHn,E-4!!~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="892" y="12" width="250" height="38"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="chart1"/>
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
<WidgetName name="chart1"/>
<WidgetID widgetID="686d8f82-ce87-45c4-895f-be2a0cbb823a"/>
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
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="9" align="9" isCustom="true"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
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
<Attr isCommon="true" isCustom="true" isRichText="false" richTextAlign="center"/>
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
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
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
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="false"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="1"/>
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
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
</XAxisList>
<YAxisList>
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
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
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
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="30.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="true"/>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[航空执行率]]></Name>
</TableData>
<CategoryName value="航段"/>
<ChartSummaryColumn name="cql" function="com.fr.data.util.function.NoneFunction" customName="执行率"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="65c1d88e-663b-4701-972e-f2c865466a11"/>
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
<WidgetName name="chart1"/>
<WidgetID widgetID="686d8f82-ce87-45c4-895f-be2a0cbb823a"/>
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
<Attr class="com.fr.chart.base.AttrBorder">
<AttrBorder>
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
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
<Attr gradientType="normal" startColor="-12146441" endColor="-9378161"/>
</GradientStyle>
<VanChartRectanglePlotAttr vanChartPlotType="normal" isDefaultIntervalBackground="true"/>
<XAxisList>
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
<Attr alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="3"/>
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
<VanChartAxisAttr mainTickLine="0" secTickLine="0" axisName="X轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
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
</XAxisList>
<YAxisList>
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
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="1" MainGridStyle="1"/>
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
<VanChartAxisAttr mainTickLine="2" secTickLine="0" axisName="Y轴" titleUseHtml="false" labelDisplay="interval" autoLabelGap="true" limitSize="false" maxHeight="15.0" commonValueFormat="true" isRotation="false" isShowAxisTitle="false" gridLineType="NONE"/>
<HtmlLabel customText="function(){ return this; }" useHtml="false" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
<alertList/>
<customBackgroundList/>
</VanChartAxis>
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="20.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="true"/>
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[航空执行率]]></Name>
</TableData>
<CategoryName value="航段"/>
<ChartSummaryColumn name="cql" function="com.fr.data.util.function.NoneFunction" customName="执行率"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="2fd57304-b5b2-4f85-9dce-3e44601b9f0b"/>
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
<BoundsAttr x="885" y="256" width="257" height="346"/>
</Widget>
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
<WidgetID widgetID="66bfc513-a259-448a-9e5e-c959c35f7de8"/>
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
<![CDATA[1402080,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[8595360,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[上月航空执行率(小于85%)]]></O>
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
<FRFont name="微软雅黑" style="1" size="96" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G'A;cfP[CSc2Dgp5biQEO<0!0:.G6^<]A8nlW:KdDBF]A/aaaS&%/B:5tN=)nhFESD6"p>U5
/kR7H)pTWCX"=9*eX(@RQB:;u$\Eg-fBqO=&p2+WkoHBZJXPpW%)^l4Sb7p`oOoS9*#)c[4O
+qto2so%O;q_Im5)f#u6P@JlV\J*5qd1sX;1WOJIeO++D%JDYmDfCnt!f<>.$DMc)gnpX-Pn
Z<L6;IWAaO]Aq"4iTb\9f/]AFHh#,LLBC2V_(s`SUhTr:2jXlPimHK[=q78F5To<:l\?\0=:o3
87,fm":'AI6tQYtWlFIKX5HU,$De1W/3Sp@O6>P*Q,%9eT#)($P>mRf]AAI)bjV`he1aG-[E8
-ljsQ*11VFKCNL85WUZ,D&j5ni7b`4KKsujZZiNDDd#a\W.Lt1NV#2YDdJP7*uV!F@Fj=nM9
OB#c^Om,X_YSJ4D2C0HquCFBBWHc<T]AY<EE@adaX=Xm..Tr0EGF3_5$C?niFltbYjoG`VgU6
"I,bLEkB$5QaY!G)]A#^3W0067.lJ%/c18O4+GH-;O4*0'#oaF$tUI`tG033W6@d^X+c@=>fY
IEhfRCA[<K7:`Vdbbtt;(k!JOCJ!+pV>>gM)\?M^;G669R%e:Hr;B9>kr]A@GWQ_4H(F!/,+1
B1Y'sU+C\4tb8R9\NL\8La.<Q5O?ee#^0I:PqQRUWff.@ECDP8mErPP0'[HMRtWU_#LlN]AbP
Lj&X%3U`h-]A(`tZ<g53TV,?QtM2c1-?$V^@1iGVV.,/:fD<@1QOYceX@i;&\5OTh0VsT;A+>
q/>g`0_6<1BV^m#)1mg!u<TbqH7l;=I"G*VONUH:\@<_u@r6V/U=rP*jXPk%^#7-q^1uqE6n
<DY-fY<WD3BCFA8c%(tQCGk9>N]A,TVU$4V*!h:?=2#kA%c[dO`]A/gdQ[cKVl!ZD(=DAdgM5e
F%PQp3^c5<[?./F6ffN&fH/>-V1YBou+9Yk&W\^Ig(.?9q1_`(H-%*FM3#.?UJ%SSlu#YX$:
$oOfgP7]An<IEP7\JmO"4?*mY`T&J#&P=@"b^)&&9L7&;q+QG'K;%DGq]Ao>$oK5]AF+U]AID1!5
_l'5ds*X,=KR;W$Dt1]AdG%o2=>#+%hc'KkdW4rp?\jLj`Im&/Kage9-Q#"mh4b`J_^VOa7;6
JUL)81"G:b1Z>GheelIiLXH5<5;Ws2@[,U7RiuK)UYZgY%;WgmY=Z]A'fD]AK=t72*5R!5L!12
5X;mdI]AC?#1TsGQ5iPh_!a`C4I`Ng]A%n_Mj>^RPpidVF=gbt#i->qP@<Gn9Pk=/*fGOgqC%U
h\<:ee?hfs'HXZX8RJmfu'leQ"EZ)O]AJoEh=,0[4[NB=paSaRB`<PMk6TgiK5%0(>ab2]An&)
`OOCLt.rog5OD5`:%8F_3-+SI.:MXfN6<W:\tF2*L%5kA=KMSNI;GD:09JD+\ianZ:WQZk1(
D:"%mj46:LYNkP#]Aj49Z3G,RnN?Z^I[D$mkiCj.7/]AE<$n\X,aXBD3$Q+0BC]Au^)f8^&OGF>
KNHhsrtN>o"jTS#!nCp39S[@k?#b=E9h<&aH*M>G3c:>tglG>(@hhM`U1ENmUrfrur+]As31I
s_Kg9'N57F0kbe,uPt_eU\N:f-*9.+rc2F?oUZ;`glSOG^7g"1JY0O5<AGC<$f%k?*_6=*VT
4#S-/3iGL`]AI<"_B*=VjBfgc54GUm@omVe/8T#LgG):?hd5$;_rHEg`"'?DE5lX6MP#TMGjq
]AWm2-<#KIqHAJf>AEYqX1\*@MH7S?oiFD<)".60L)+V4qAJs'iN'=rG%^QQ0M>RPVA5+W"T0
j"u7:<U'HGbaN>!'>FcsFUP+/i$7.d>5I#_M2cn64QC7'aIYq1UBE/0!qlT&nKulH/P>SNGR
8/hh'L%8bVXDV$d;Y/M3/bMa7#l3.,>lG7MBAkNK8t'H!*9@Z#W=%\l@$3MDa%l(d*)HU3?B
O<FE>fm3JZ!D614LJ51)`DAZ(8*O#\S(<Zo&^-\&@6'u"h&uH#sHWRG(]AouFS3\#D-@lr7Mc
n;<\67Q^gSY3=#@T&dB\o\*rE[h[C+hTO`(>b3QB\,*G'-X0HUQ&L/llcDRm?5]A60XV4>bSe
s.)r9:CD-U;90RQ1TO^DLoc9h6p8n!B&DM,g8G!%AWpAqu4:a&@'CG*6@>ptf*_uIl,b[H]A.
HUHcM1lAQ3iAP<bZC("VoOphWm_]AQl?b%m7IVV+_i;]AVfI@c)?IqSc\3tE`n@L=,T=dM)WeW
B!J^((TV`+:CYOP86YC6pr]AG!/poSsrQgSTZF\hV1aZYs,Th[ro2PXdON5*C4Fr"Z1.TI?RW
g3)W&3K4CrL6blOmL%X?X@$ZeM3u\Q4Cco_^Adq4^RaP0<U$(.ubGc'2Q7KjqBUi'V:%%BVP
rL[0Bk;E2"Q>?_E,2:_5WD,'1#3ifADd&]AIJFFH>6tp)!5uA23Ii+COQ^d2:V`=L'B<oh`;o
EL$,Z59W9GkFIc-h!2Zem2+8:c&EGVCN05GcE.($6uL-g5"d(i"rcNe/Dor0eZiV/!`[h@HE
D>dGR"&ste.&O]AAehpWI`+\[S$)ftgPjB4gB1*[>\S3]A6$L(B=i)$t=JIG*nJc-V.K_Lf#LK
)JH[$N5)F"`WN6N<-9&9PB?ZYetR-?WsT9#g:SbS*p,P^(eS]Ag%Jj,'oul%4H&EU;]A28P/`9
F49hI-s)_$YL7Ru+OG$Ak5;%cLN#YjdPZpA+BtEkm3ggq""p@Gn3C,.%2aIGGqCt^R%D[35f
ALQ73f6&6+VMkVfEN'LQV@2"?X[hu4:Wg1:"4IVJ[GXj$j^iDB_-IY.):JO6ujDA,5:&kmJ)
dq9PI,aT_LGC$8Z/O$09XajLG[mqs,2Y8M,%pHC27^r\.q%.-4a^jcCr-Z6>)FUP!U4q6LKC
.[j69pR5_?5*#O#daM1<A=;s>^P>AU3_bilm0.-=TTZOs57\';)`2!S>_7#rCUR#-alVeudT
'+fX?gF]A!jD\sC>dHU[fOcCnS,*L$6f&8eE\)4JF81WXsqK%_%./!ai%`=Z<:$fdm`p96u!^
(4,8DrIcf_Pg+=,AiOY]ADb&D,FK>c/&pq7cH;_)$L0tfYPiNR=rm0$+%8!BLJN<7sWGF$CN&
+8OYK^A6#!LCa,.lW/4Vk/dSRqZt$(-E*R!Lq>m7!J0%Ka*)l?kDOF%au_skC@SdQD%r.O8k
^:@G^5uT(iSlLUTk'FGGJOScLsXA/Wm#qYI;3K5VBdAd5''i%,tqQ/seE)G:T8$l*Jk85e7S
QLBKI0^'0E"FZYHFc[tI=eD[KS;mndbH'$U9nmc_dH3/CmNZ[R[UiCIFnmb]A3*Nhp@g02:,P
6p=U"Oh9UmSMb7"lut/2dY"ZREKda]A_]AhD0<<WaAsht>/UZHN2+LbI34%R7^KUc26rYbIiCJ
+a0!]AbdhtCu=8;o7Z#aRcnDEP-S?56R>i'p^;og-cEnc?eW]AMo9br:Sr+VFbO"L,JR+'2#:Z
/;4P:/l:4J\7g5+:*rt)DNg5e"KHqedr);N&lh"7#,Ud$aP^Ph?]A"?,0-*M`&k:C(=.-_Xf.
c8[BEV6a1hgTq'KHfF,;>+*BEIumU=:P"HJ9c\<-(e+Iel!)$.[FrQH]A6I)9\;O2*W6O&M`h
BQk?JCe)DPU$a90^5,,/FDd(Gq4-X&Xn$Dno=l`1Hfs)Fo"Jr/%XiZdg6UjONY?@,#(?!`C9
5<VZIaPR)-j^.*#9R!1oQ8KLQqD.jdK@@[2`T"$jDodE0/!Q0.aqs)`-1rVX?N):fZ/'[?;u
uHi6!C$cTU@3nCPu&qMhq%>?C\!ue""_P)GcSF#6!qaWFdV&1IO="Vmi2Em:cfdBD_c%WjEH
B4EL9Rho3f4K^Bm>\bF;/B25Jqb1!GLh50D3Hg6RuD)obX[c3'C_9fFC>PL0]ASq:`I45Uqdd
MSoA5WHg'82rE#bRUjt!(QU#P\$Z.>t9IA8rRAghSmFegI57Iq`)jVCo_=V&6/P3_(P`h+Z+
\7\Y;S#LA?-4OtYT4,1=)-#1l.l??U'aGB6?.jq+0qL3D&OR:%]A<#X?<?cKTnQR4<G`0T@]A0
,/k.;[tF[+X=NL+atNA<sT83b`e6:"i@3+Wng]A6uU3A@Ff4R_$C<@Pe_F<8";-F-ql;iGe%F
R([hthT)]A9paDXRK8c,S=H'"!DYW2"7P.$X:A/.1c$1YK5dnf5eD[i/X21,:Y1rG,9fE^(=*
T\49a/llY"(LJm5#`3!2*l/#Fc@.ERb:+J#T5LD_lQ<(VeC*!P@LcW67!j*`$?#UZsSGs83P
40:53;6!`eb@B11n;DR#8#72MdbiW,Qo3Il().Iutc4Uju_NoK[Q"7,2KU+Ysr_G=s5\1^.n
&lnO7f<J0n*>"%2gSYAr]A6EfK/X]A_=cKE&`VI:Pr:Em%Q:Jn*O.\F]AP/>iFJR+=)9PUMVZ5R
a<s\qJ*k!eUUSDD.fkPAOO1#?"h%H=B'_0FT#FFO#i;hVcSX%EE/5F-"gPa!ej1Z28$ZM!$.
%#Wst%NVPN/+n(EO6Z1iF>h<o,PT0cV]AM\Kk-u<\(ILdU2d_1":SFOLM9/*hQ1L^in>c/GD/
c2\jXeOK9?@I1Z_n\u#/KG/9Aat&%e##6u%Dd@W_`UI6>pDY6?;?rFmn3VrD_e>"9;b9>Ck5
DLnL*Dcf2S_Q#,es?e]A]AEG;4@g]Amr%)HP*WZ>9$:arDn5f(iDk3,f4NR!ioDp>Ua(#Hm$RHc
Gn(*:)$@`,4F&Q%419NE%9%UYXp/Ka/6n$h?I]AlLQ-*dG3:AX8<2,Ubh%0n8@OiL$/IZ4E<_
*tLRDR0HA/uuMcEV/Oll?W:=;!4$!#QXgYJAren7l^igK>/!7("Gg32Pjo4<=kW4,>@@K1.G
`Q\3D7d:B(*@Q0NGFSkb&`I2(-#3"nb*O(c6&[LR'5U8?fAjerXPO@CDjY0c*7W1dW'GOnjS
jfpNat@"Q/<$6:0E\l[;[1pCs"PO/EjAq+8-%K8qhHq^RW9OSnZ"(oHEZcn1`XA-dA&'"Er6
`XTU3V?hO!-ciZ(Y"m.*LCi\r-a5QCT2s7dZ~
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
<WidgetID widgetID="66bfc513-a259-448a-9e5e-c959c35f7de8"/>
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
<![CDATA[1143000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[5090160,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[航权时刻匹配率]]></O>
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
<FRFont name="微软雅黑" style="1" size="96" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;;eNPZcK[)ba5[#*[B5P%1^-OMpfJ:XOAi3NPgjCO.H5t,[@jH4U4NNlCM(.-dh.a<#Z
Yup9Q.-Q$CE#i)%&sHA3l0q6Vo4$P(=b7'dMdbaQ)'>5&PLK3$2qt[K=H5p`o3SkM,mg^V,,
Dn*f>45J0Eg]A^XU.5s[epj58Lt,:MbIHr/0CIfHHUU7^d6q:oX[cr"i]A[OlF\rI(b++Y2YNm
Xa\:&h2AiI6Dkjo";Kjlj'macCn<tepdS9WVDO'oCgRBNe=cRe#Rs5rop_:T?uTqV87%in\q
jp`2N6af5^-BbV.<k`fk7t7F/q@k@>%Xl)=J1Hg>kt</B`Jj?JGjO#U=3'0=t<UtZ5sMl%2J
M;CfHOO'fL%1*bJkiO*b5#P!>`ZeepG($RGKKO>7Pt:+G%]A!2!l,H8Vq3/Lt*,66^IQP<E[]A
QL(/LnfQLT\<e9-%U^O%ZM/cRM!7be53#F8o1=9-%tlIDZNFB9lk-%"XpK-lGj$G&e(]AFl#&
1$VK.:ocrnbA,j.E`iVhoY#1M_RhOm@h*oS8[,!fRU2]A"WGK/i0?)&e/FS`D2O=$5#;O8B-(
Yh&_35'*LneTnLE8AY-E8Rh0?<>sN?Z!qNGM,6/E%rX)rKlm;lHYuSM\\obg`"fg5+Pl3DC5
*lm_Nf+EqBZ8Qe7_h/L'V%AmXrB+h-iQXn#@;S7Sb4^j&dgrc'M_s(Kl\g9um0W'7aBnET.h
M2VP6!kX%WrN\5oC32-*n?M?"i^Jbo.NMH!4AtT42^iGXeLI>3`TVeuM)mDh$@_CWRoYrpWG
fml9odW-SHQTWm4rUU,H=th4X;qrZjCq\N\nCqhQj%`NiLuHoN<CdX"q^ji"Dtt63d;bj3#(
(.rP!<r[tV$VfO8XJ.'9lPWRW*n-2J%m=!+2U%B1oN"gQoUoT@9M-&961M\RhZ:3)&Um'-W'
<6r4S6Y$?)`>!55gRpl6\c2GCK.l,?:Hp&qN<a+$o\YRZo5\Ap7CgI8.hup&p;iTah5ZQrZ>
.Q2kpX9UT2pB/#&%]A3,_lB^nrfNkOtN4Ch%GUHgf]AFZU`B]A/p'8?F$>S^S.k%do9L4e024TJ
l0h6.<TR&RkdR#lVj$,Ha""bC(Tp!8g^cS3'+#nhREW5-Q6@;QZb+?c+Vq"i?1[X:6JnF&S)
c?MZR.j4aSJ1o?Uc^9T_$)9TKs=6D;trj1\r>BG-d7,8>b2OD]Ag/WlQhEeSj9Gq9b=s_6o\5
HgbcFFUt/]Af8K-3Hc3-E:[TlNdI^;;&Q>UJ!=u8tA#b<7S@^"=H*`DnMj::!>cJ;&rdJ\Q"g
\4#,D7D\J%rD<iocsfD"XG.?6u!GZ%e;07CZ8X(%I9+jj$0$XTmnVH)6KK<>;@f,LKIZgY4[
fqEWe96?[Ke5Jl>mt'"Jc0Ssg`9h*f0>i'61iDbV4lH<ptd:pKKH09\5bFT:mloM5<Un,$%d
n1E9<X48$49hf5IEB.)[YUd1p9!`o[cP8$7Y>"K:+"c6rH?*2t"L3Uh]AiiFEoZEAGP@Fj+:<
ODm?`d>JD'NYb8Qjh^_ci0f55%m&:WKj<9$3Ebam%JOZ':uqZWnLEL9:lf-h67^cF**Bm"[[
>+;7[4rjk0SH>4B0h:Z@[hbTUn`?#4T_5-76s*FD"B[*;60S"Fs5hV3l_H;Jg)U"pu]Ab5>%-
.sG+JEGTN;20>qQCZhS!4cnH+3gu9S>G`;g(Z8r)O@MKRcO]ASd[r!YUB2$C7>c]A!9b9^AM4l
_<,\#E%:&,(<CuPA]Ae\3=Jdr'-^BRbrNfLis2/HfbIH3U%J^Q/,'4m7[Fi`Q(&.%6K,epf`Y
_="3q3Kk'Nol1K*+s8(M7P<jiDo@`u/bS90qA'rPf(mB;->8,d4"$@'7qe("_+o;-!e1_'EO
`*<R+?DHLO:sc[Q=4i//`6.TRDlN)=nH4ZBFVG)N;dTE=XCLk(^bB\K'&r[4*__XNQd-Y"<d
p*arQX&V@nf)$!h@H5L2!Rt1DFZB^^>f4^J!K1UdL4Zl$QTDV5/QH&@E<Jc<bC5eq\]A%)S0K
75:5]A,?6-a[X9%OiFU1dm5Ik\Tg<YH]AUrNTm4.RMd5!:"9iX&%C\sBH2@bQdIB!>Pr"L&U/O
s]A5c8EM!Q9Ad4nCur<f0JElVSZ=qI)]A`U0),=OH8A*e/'@A9YmCUAo9D:XkX>)3-XgJ4p[3b
/U9G?Zi:+FN+B_gl]AUDf35#/U4/O)ta=(8=&ef%?]AQc6B63b$eZKCcj!TVRJGDdcX3BVhI`t
T'L=C?3Ij25lcb)+Qd!<@((Vo3\jJmH`^7)1j>Rg,T>-EUY#iXu8#;n'gZ?9+qR&E$&Wf)d?
bJd+NC&nAc$L%LJA[BFfu)*ju_#TK'<eBn)kJGKrM&F_M0S,dA/YpV1r!;16?S.5Sir;S)X-
mIdo88quc86"FY=#Y8@(!%Wme>7IX/B;LiK1ZU\Zj,"pHF.k%C_\H`\s3p9R493[NU`h7O8r
X6m.aI'b*VI$)LSkq%r*O;p5=2mXHLD?UV\m=riEeLG#)J$CmSkP6o'bV%P"!KeY1(9IZhW7
2g3JhA"d#1/rT%PFN>0J8>&YL;S8r=jLL'"l+lgEB*W,,i4YhLj'^[lcsT\m([tM-2M:]AMpA
X(l$+);&aWPZQJ2NOTXs.a^H>bUYD4XrSi7+aDTRCmMC]Au/-;n;)iM#;R[9m0$<?]AWqNbSab
IFa`9_86$$g(u?4NJp%nGjFY:41-*%F%El>3;I,)1Zu1^qq%1cN3mGMu&XJeF\HrUJm<J!#G
(fXnG0#cGAu4NNO?[M2qE73kMFI[tHlEbs]A6lcsMf"hu?BXHXCbtnH2*_I4$5!8)kXok'!S#
('.pK96RZgbcbsRJg!1mdFKd%N<QM"@c/@in4S(qj'n!>\CEq"=`d$;C=Kf]ApN!=lRNVb%9A
?fT*,Nc]ACI-D_rMM(T<hXT<(m^6DO!O+dN;U4(_)o:Gsh>`<t[BpSlm^.1P.3iIC<^q7sh1+
Hes!&)qjT!EoI'U&#"LnRrb3jnP7fF:k'4j1j81324E9N(d`J#i<SHCpaYhgGK?2g7fJ\<lB
#;R)Ur%NM9*G&Q8j=^uE#m$`2nTKkDXpE`Mo\jgCV>a'"oBnO@anH>*n!S%FIAT%(f=h'Y-n
<GR==[-cRqd'$&TJJlQ*:&^]AmlVV(>Ql$I5@<HnD?jEa7I(Gi&cn7X4^,CG=,;XCjEe\O8Wf
YY1S$P@E#.g4D\sB`*cj>elmIC&R<qY"j,-;.M9>qU\+O%LjpA9(7^u8W/q8ucPd'p&l$s0N
'46<^Y#Ks/0Z`M6))ZRTB358^kK?0cm`-q@K*/&tlqjJUra+-.blK;q\bSfJo+JQ>L0XD8I6
^g7Sq[U\"hZ<!_AD,s=,,^YA)fb_QY"tYW&u1]A!RJ.o#=p$3#WPoKdK.g4#eQj3]AIWKO`dHf
K>ip6K\2ok7^OZ/<;,O7TI%Cad=)>Rn":ja,a@_5M#&6ds3P0\Uc`^_Op07B)4?a9@K'n,M7
C4JSJW>]A%V+F`3i-)P>5au\(!rH_orSIh7g]Adu(KB72<fBp:U=7@>McC>q/S'SkMj]A;6PDnT
HXh]AVIG7Ch#NZs`AmqUt7XGF4*PRsinrEpRsH?d^pq.H&0f@gFnJ=?;'R<VOn=%ZRL(*&D$?
jLtj7jP6e:;Z`<m?j7?2<!m5bk3<+G7-nrm5$L]AC'c_AZf<:#A7rpjHq9?rq5<2;p4]AWb34f
(K;kAp-V)Ams4fdBiI@`J@e&Mb4)O!+*70n'#ED>4<fX<YYY3a_-?hN6rB;.b&8cW[b<&Q9%
n)BFM_+N9tCrlhj@=H`kM:2qpRo/>2!`F4#&;9+o<a+V_#\O>3'B]AM<M]A"62Mh&0=Qj9j@b4
2%9A5i&Yb5DBbI2lrS,:D-M`]ASPMo4u^-.Bs7dFQfT5uIJ=A^bUBp^YYlmXp0aFU=qn>OS>`
8W12q==GOW0OkTN.6`,3r5Zj?en*srl!okWKZ=,/"WBit80;4!1#ecDV[*Nb4e/7WBSB$.^4
-<2?e8<NTbQrNa_;+f94;mr7L+W/5I:d"R,3USpn7%!*!5&U+T_riRD+1`c%<#<klBD+8H;>
:4c;0OHfeuN<]A?):q3P;^tLd*$YUb<O$`#g<8]AbF6n"HHpt)ppIJ.oLm&.^j4QM5Y9a4q/FD
%np2J1F1Zfr6u2bIYn"`iNIZdhX4U=OQW2<?B]AbC^_1#QsQ90n+lV\\dD93;tV@X64b\<pOb
[40d3D;T-*i<m]A"[XQH8c+&>5r_oY"-dZ8UQU1+kph>ro(;KA#"A;:2X;>paAt12W+3QnWKu
.!JRs`fma0n:%%^igQ:513K1nDTRij*afL=DhE)91^M]A*:9%-Y@e(EaVW]A6sYnh[Cim_%LUD
I&M\;iePikV>Nb>9$I)8k6=+M`AZVB6*ao7>hOYkX$B&XaUth=J*^K+K6kLP?)*5X3?H>\OL
riVqe)"0?k!d+#!EdANn<@?KCZsikV9WrJRo4![lZPLT#VO-ku:YDa>"VaqA!3>C:\DX5R_r
cKe4n:e$EBdTZ%lhL*1-HnYK;Qr60=bK&$YSH:.fuPp&hJ&\qT3fk*Z.#Z?5RAR8Fi)eAdST
]A"Rk1p1%Cd5/oMKiQJUV96^_Ud2%NEWOH'`>:LY49YLd%!d7-<g5ZTj]AEjK7tbRgTJBh4b$g
pkJ<L3oO?<Tdj6'#UX@\&1-V,]A'FE*I5b<JD1r5HZr;;<)iU'^7gIG!L&lE>M^GeSGp^=gL/
jp\HB:AMSq_.%S7"(1KS\*O&HHhaUhgo'bSlO1QgkCbOTB5#&t1`(c/NKC);Efq>,4@=V>#P
QBQE-b8s)=%:,QtZ;6P\DHBKJ9\#3CAE[4YRIg:@*.NM&L!1VFL6$*3cqMbINB11R,q%L2q.
\0p<KtbiXp"/k_[aoo#Kt:%!iDGV&MG;;%Cm4i**/OLPk+,=!GeC4a82!<b$r!]ARNgQ^o2+5
Yd0f[;>oHGct;146'srp1S.YSB"$fmT+Sk6Z3"k%Is&#o*aQL;Nf&(aa:.sgC/1jqd8EPQb[
)hdS'q'`#o'pcCB8*bIT;>V`t`FV8'c*5,@pGC]Ac5(17O1u^fs6Zm=E1f8/skmn/]AK'n(6Vu
Z(13!d^X1BgdNU0^OQX5D@5'T/-1ag\N.M2;*"ulLpJ3S9T]A^Q>BX$=f18u;j=U\!**q".W:
B%p=RN==gl<-'Pim\GJ+9_W[I(hHn,E-4!!~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="892" y="222" width="250" height="38"/>
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
<WidgetID widgetID="66bfc513-a259-448a-9e5e-c959c35f7de8"/>
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
<![CDATA[1143000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[4785360,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[正班航线满足率]]></O>
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
<FRFont name="微软雅黑" style="1" size="96" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!?;eMPsgR6T[DIM=<*u,(GXQs7m>O%JH,hWZB>+@$D1IF6;U.*=K!"m+;b\bAFe'o.h[t
n'-70\TY0r%]A(N4Ecj(iGcJ#SEdk[7LW8oLK%:PM=b(g7@LmE'Bjf>t*`p5*'[\^A#:tHhk@
ipH@EJe2M*fr]A'hr+X&#T^@D'b[mEE18.#ZKqNnPg)>hPTP5j;Y&s?Jj`p21>]A?:FtXl#92U
KsA@hgOr[h!r*__uJG[p*4XC-f^(:,lB;k4hk"0qER\8DpKD=aA_`lpSrLlG;!88I;S6#_cF
8[FYH\KdB#.b7V>4Y'g'P6JbIcSLkOEn*ITlMNW28=d?`J4CT&%9SH_egqt9fZ=ift,T=F@)
gpka;eR!X9K\Ai+2X,7UipA\24KhWUrpS`mqs_a[!pOaSG#OcVc@hZlCH-[L5,i.CCkQ32kg
PAHq*8.^;F)F2rG2/[qqN8e\4PP;X?k1g.Q\;dklnai.[f_*B/aW87J/`hj'0Ff,6FF[R\aj
k#-QJ?g6!m312RPb<L:Iq]AZ0J8Kj&E)^rk^YdAAX-_ccmMauZRc45Ujn\p7M`]AnTL)U24d"b
>YsGak43)Pq2OWqq(0kTO7*a)6;Y9iNsA8V#3S.CDMt6?K^OBT.W-(Y:n:FpS\FZBN^S70e6
uYS^`e:h6)C/3uRtPV*9<FQiEWU=J&)Tf?5o==t$WaPkZ1u2;>LJ6?cr3I!qU/m^a:.%aAS<
\G;RGf"`Cb.tTYBrd$;r&opaY!)\ZK8V/Q`j<=Xs9jqHX@JJL'q+cP&m%$gN5M&5m*NRht4O
;&\A\!0E8RPSXA=lM)%<1nlW+*,>a?Xa9mQ+5sS*U*pBA3(IWcP&epq0-1b12NdmkI]Ad?XR[
"g![.5[RhYmGQ,%sj#+E5qcEs\$BpQS2YYg+'f,.cf.SVdm`hV<m.G-6L/!nS#:@-b2Y9Y;b
Bp5_%bg.7'-sm+QharaH`bKNelh>1H+([,Z9boJ/">5>OF'C=([c+H9qoI#ECEVHIEr5s?]A0
0jGu@F63G,jH`oV8sI7\Bfb0Rb?5ur!^dJ\phB&!UVl1tuumKIGG.uSULlT\OENl:3)9^P;a
)6o;L_)2DbU\5.+k4*cD$PLCgAeT>O@P+CN`#9"3l*b.,Pj8*-IVr5Rs,>q)4VI,5H>?T+\G
mZ\M%mjsP-^2E9JU3(9'DYliS4n*Rp&[c@`7bonMMg<Zt03!H4E=AZPid;"D1E$jA+W`-($i
_2R$`E2Vn>hUOu+#/;79W"ej\Rr6t`T:rBr)i[(&`^WO%"!dXAGD2k@f_D-domS?fF$2ll9b
Ru6UMPCuh<,IYAD,O6n?`lFk5P.=`lq'S_9Pn*hSS(O<d>9)@7L$<Gg0ElM(AE_eHRFr/9OI
WndPdEURGKrfL9H6q,>$r%k,T.GDEN:]AJ"><L4gqi`#EsnGXoB_ad;%fM=YORb>$*pn<.\'q
=Y.1*V.LVbIjp1$<CFMk+<g[`%9?4KrD5YT+ApW]AKT\doq!o!$3:i<t\#Z!NG5U"(G4%u[$c
E>TrLYr([b;Pdgi=<P[%^acFa6+b%c^C7;8Jh[<!AD.lasCbnMG3U$]A"VN517,tGUFK:]A)Ls
;M4rJpCFsn"d^)9:_bm[+:*df]A[EK!n^J$LY%[a[oP4a']AX#S!8NW[uFjpl9&_Ga-B7HT7)I
et1TZg;<P9d<nUQ$l_dB8,Qh4E3i7_ZuCb5*]AtmCbuW93kHnp?Fh]AgJZ0\G8NCfrU=HE6'LF
jDdMcho_eB_5]A,'Gk/rY!RS!I(0EY`R\6%:&Knh*1BjDL."d%Ju]A,?s^!dM'TW%_tH!j-afC
B_!l:La(H,)^/G'425j,Go8\9U.OqqT@fLM_H^?^RArj;(egVZ?7AhIc2eeni?eU?'hsYeoa
[Wlej6!=cW7\aM$`f;[TM*m4M<inR,6W%&cgnLnrUi$_*no^o'f%I%sPiHO<ZsM6R"Wt$SAD
jW[2ERRIqm+n;?3O]Aj86G4As?J4ArXVDI`IjIRDHjMOR^1[iK.c3f"aJ6,KYW"(Sr,c'+T3l
g[YLh`3NV$eidD9@tG$b=^@++2L#ZM<emr^>3^!W0EaGnHAF<HVQ-W!Mn=T;ODo)+^mJ^>ZI
q3CO$k\4ntQKJd,S/\sdke$*!G7Su't*PJ!a6r2"X1AaW-P-S;,8_p_9d^?2L5@nQR(KrckN
Tts4*nnLJi28,cWIG!\('P^_Iq7_f\\J_"0,_pai]A[)ck2SOba"/5gPQd=cAau-ri!3g4@rp
ilim38D.&462@W>MQ`rr]AF_L5CnmX7(R$NBfh!",JL/+_ARl9?mKgMZCF;"oLC=h5@_60Ius
*^/*LfG/\n/EAZLYmn%[&ODSAP=Oq4!>QL]A2p$h5b5bPOm_o/:j(M089!#h>A\c%UIdhj;:S
)-+2A@XEDC-GX*h,k\H+,md/2miEQ`^q<5_iT,D`NEPOUhJ&D2Ao3N"cY*bU5Cu;5He-7=ZE
AC(hfBYn+M9l"U5sIBG3\F3C(%?&YJGLXmGUPqL/'Dgp!OD8N(7$)4OgZYgN1O(a8#(F#i>\
5Y*#KM%i"i2$sHPfd[]A_/?Ml"'BFr7,d'5.bphCeT?6WorsiKAb)@tALENR*PU#TVO#Act^#
]A4N974XEQ[$0KNU"ofP&=*;U?F`m4:g\B5Tp!?+5<,59]Ad]Ab`a"G9QEMnlkJB+oo\)K)qj9'
&m.ZmBjjjnZUk@\"debMMH0iaTl_!)J!G!@Fr[RfJ,#lQ&*g)(M5DKgoCM\$G*[L<hM4c9nG
R'aYa%/nd&!&]A$RFCu?R<TrY9$FY?U=N[D^]AKG[Hl6r.KKcQA1N=>&F?WJ:kfHIHoE;b=UDp
ue_2.Vk+IXI:i:sbufqA$]AE[gJFGnAfdW33Q^"1BJ#"&>?-Cm-<=VnU:SD+ku+D4Wi&)gU<N
JZqdrG9<8W,1esO,f:pi?V@+a0kG*!Cst1dJL2$L;Z[UJ:u..Rd$)[:-gV)r*2#1dR9:%@n,
3n%bNOsZ_IVZJ9.;Ds![5P+LZA4=l1PQP=;?Kh'>Z//9Qnkg%cbUQ1q'%1X#%tBYjqiD9O"5
_";5_^IiK^KZ*1qMPCLUnG9W3;.&I/>'5gej.aG:?$+.#J]A<9$qIS*<k$/((a\aOYs1!&(o9
W2Nh;q2WIi#6,i6se+k36DD'9.<dVeIt5$08Q.+;Y_]Ao@B$dQfAl="g"V&1MZ]A@9JOWC#Edi
n""k!M#4WBCf<[BQN<P7U&?5F(1A:ptq[q5oh.lJ9Ki3Sn\196+-H%HE/ZW3B_j6`tfT,gM'
On0TKE.O-Cc6m+U:`r9m01T\9kU7=1=/_m8N6K%1lh5RB5%GkMYXb_GkjtXA@<*"B5TWG#eB
%VC%i!#<O>;OD)i4MF8X;bJbNXdEZfD?lcI.?=@f1NX^:;VcLZ%sW%!I\A3j<r^<tuKt#'F<
Wa"onP;@uG]ARn9:m?+ruD-"$ii(8,KS8`K:ZF2tO)DSAGPL;L6K'B_/gik3/nEULc\<)5#gq
\69!1;h<Kn:?;6mI;+.+&B(R>Eum"/c_.EBH&MqoXSNuMAIf=S"-a6RK4G0K>?kMgBKN'rj@
me-O$F]A=2@%0Z\$u`9]ANRkNc/N)3%A8]AW,`C>ZbOmJ4R[k%V_4&ed!EVfY<TE4T9dH$RO*>K
R*6)]AA[(u#[4EXDJ-EJY^\?D8FL<*TP)(;J=q9Tt2Mj=(:HG5J\%`'DE$liK^DT(330bKApS
5@,\XX2@?E:$3$p9^#?=d29"^?PaN1&4:55Su;$Do:So(2S<JT+H#Yb,^i!7MD<-'O-k+.1^
s[`BIY-`%k@Pn.FG&5;QW`*ah[s596Kj5]AI2#3uuCPO>i>)0>1NHKr$@GoYI*&/,?Xr1Au/[
Q\HL1t8LHf3MSn6sT4D9HdTnU/Ujt9Z:Ys2B*7(&H:Ta;ih!NGm*V:s",fnk$>pEq$p#1cl>
%;/]A6nh&,BnS(]A4"EXJ)iKr;7p\XinDEo?0m(lDmE==A1_NqTZj5*J+lp6\lL4e>s(i(,sX^
_SdXjg0_8&Ju@N@*mITLnL"q+nRl)J6*ZrCY]Ae?LK5(+Q"cN4YH"KL.MO*2":#[[?iQ0)^qs
X$_,Y!o,eh2sg9@F?[U5`\/T^Ms31!LAp67LjhbhP&d+M$d*m9I-@0/0Bd_#>lp`J#kgp>*A
G.RrJj$Y<$5*!:\@9S*R('1bQ-E8,f"E)G_0(k-fQ^PA#8+D4r\>QFCm!R4Mu9!DQ"L6mfN-
!Aq3*NG?mItbN#5\$DSZ:8$S3fWHQK=fO"U.ouBC-I)Ye&OlVQrbfn0[_boOb4i)Ug2%b^*)
okqd(ks%PVj"oCH%oqOBf$%Z;cU<dpob3mWEe=\(^?\4>='2.+Ar72P*Eb.FXtVf>jjh,8rj
G?@jn0FdcW'q##t3s&(&)kUM]A/EesTHB$AZ[,8`f&j<@RMQ30Xd(dqi.f6L)7Hiob]A]A?W[3R
m`W@>aC9C#$bs[I:O]A-PO2,@SfB'1"]ABFkP+!qQ0E63.'n4,WOKReJoirr5LR.'2*%D500R[
aN1AR&TS/;g!R@/SY=f0Q0a_L2o$TldO$F55Y\8M9de>f.%92)PJu,'N*J^&Uoe7YG>,JMF<
jltL8np8_ddRmf!k0feoYNq'MlhPkc3HM1gD#3f0s.\tq#2BG3p(-G5'h`NUWmT^qU.>ROJl
+I>60NJ\@'U]AB/6sLS=l)Kg9Xg[h+glne?bf11Cpa&<e>A5UW>:D7K&g=!SHp^n*A/f,+YN7
p0`Mnq2G=.Qa4b`R24kn@[f^;ZJ:i:AsAI^$SZ2hlZdO%=pF7>">mV1QR#`!P0B(lahhRXan
J`@j='JoWUU8t/A(3#?K3e;HBVT=l$Io+]A**(PCt(Cs*-+1A_#8>N1V4;F*,f8+.Z:r05dg7
'1/3()F1'l^Z=2c/&$B[I[A6K$lbu2ummFk9i*PO_+>=k]A8AI0@HS&_cpPV%bkStm.JT_U<^
,&%kR@u7=6g6-+\qj[&_a;!9+u>0C&2HpXMaGU#i4:.b2gcU)G_k84,O*^AC`CS!M%V-c;6(
u9XonB8VU%5U-ifeC-t/QO9kQ:\.=tj*'+a^agLg.qjZWX*(gjaG##1qZ@Z)`TFsVap(;km,
KBP,$Ui;]Ag7N<=`b@)C+F&=gpK\Zn7CES0['cB,A#Nc.=H;k:5qh/[C9IQaY]AA,.S#tgf'Mi
A+o>GcNJ1<=K1c>p%-\6ba.4Y/6L7$Bq0;b/&ciBIUDU(t0U,`2`rrbeC.Mgk=15G#&+G&5"
@UM1VnPZ21OlR.nc-'A!!S;#XIYnY%FICba5CtK*u75,rk-JC-I'n@4_;^t5m;rmEA!'C#e-
?VI\oj8&u[M9TP$!V695kK8Uf[8XD!B)VbXY[A%!-dFT=R4@:4Sn\K]AXi6nSU3FcYWm'-H#r
YHT5WT`hZ~
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
<WidgetID widgetID="66bfc513-a259-448a-9e5e-c959c35f7de8"/>
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
<![CDATA[1143000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[5090160,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[航权时刻匹配率]]></O>
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
<FRFont name="微软雅黑" style="1" size="96" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;;eNPZcK[)ba5[#*[B5P%1^-OMpfJ:XOAi3NPgjCO.H5t,[@jH4U4NNlCM(.-dh.a<#Z
Yup9Q.-Q$CE#i)%&sHA3l0q6Vo4$P(=b7'dMdbaQ)'>5&PLK3$2qt[K=H5p`o3SkM,mg^V,,
Dn*f>45J0Eg]A^XU.5s[epj58Lt,:MbIHr/0CIfHHUU7^d6q:oX[cr"i]A[OlF\rI(b++Y2YNm
Xa\:&h2AiI6Dkjo";Kjlj'macCn<tepdS9WVDO'oCgRBNe=cRe#Rs5rop_:T?uTqV87%in\q
jp`2N6af5^-BbV.<k`fk7t7F/q@k@>%Xl)=J1Hg>kt</B`Jj?JGjO#U=3'0=t<UtZ5sMl%2J
M;CfHOO'fL%1*bJkiO*b5#P!>`ZeepG($RGKKO>7Pt:+G%]A!2!l,H8Vq3/Lt*,66^IQP<E[]A
QL(/LnfQLT\<e9-%U^O%ZM/cRM!7be53#F8o1=9-%tlIDZNFB9lk-%"XpK-lGj$G&e(]AFl#&
1$VK.:ocrnbA,j.E`iVhoY#1M_RhOm@h*oS8[,!fRU2]A"WGK/i0?)&e/FS`D2O=$5#;O8B-(
Yh&_35'*LneTnLE8AY-E8Rh0?<>sN?Z!qNGM,6/E%rX)rKlm;lHYuSM\\obg`"fg5+Pl3DC5
*lm_Nf+EqBZ8Qe7_h/L'V%AmXrB+h-iQXn#@;S7Sb4^j&dgrc'M_s(Kl\g9um0W'7aBnET.h
M2VP6!kX%WrN\5oC32-*n?M?"i^Jbo.NMH!4AtT42^iGXeLI>3`TVeuM)mDh$@_CWRoYrpWG
fml9odW-SHQTWm4rUU,H=th4X;qrZjCq\N\nCqhQj%`NiLuHoN<CdX"q^ji"Dtt63d;bj3#(
(.rP!<r[tV$VfO8XJ.'9lPWRW*n-2J%m=!+2U%B1oN"gQoUoT@9M-&961M\RhZ:3)&Um'-W'
<6r4S6Y$?)`>!55gRpl6\c2GCK.l,?:Hp&qN<a+$o\YRZo5\Ap7CgI8.hup&p;iTah5ZQrZ>
.Q2kpX9UT2pB/#&%]A3,_lB^nrfNkOtN4Ch%GUHgf]AFZU`B]A/p'8?F$>S^S.k%do9L4e024TJ
l0h6.<TR&RkdR#lVj$,Ha""bC(Tp!8g^cS3'+#nhREW5-Q6@;QZb+?c+Vq"i?1[X:6JnF&S)
c?MZR.j4aSJ1o?Uc^9T_$)9TKs=6D;trj1\r>BG-d7,8>b2OD]Ag/WlQhEeSj9Gq9b=s_6o\5
HgbcFFUt/]Af8K-3Hc3-E:[TlNdI^;;&Q>UJ!=u8tA#b<7S@^"=H*`DnMj::!>cJ;&rdJ\Q"g
\4#,D7D\J%rD<iocsfD"XG.?6u!GZ%e;07CZ8X(%I9+jj$0$XTmnVH)6KK<>;@f,LKIZgY4[
fqEWe96?[Ke5Jl>mt'"Jc0Ssg`9h*f0>i'61iDbV4lH<ptd:pKKH09\5bFT:mloM5<Un,$%d
n1E9<X48$49hf5IEB.)[YUd1p9!`o[cP8$7Y>"K:+"c6rH?*2t"L3Uh]AiiFEoZEAGP@Fj+:<
ODm?`d>JD'NYb8Qjh^_ci0f55%m&:WKj<9$3Ebam%JOZ':uqZWnLEL9:lf-h67^cF**Bm"[[
>+;7[4rjk0SH>4B0h:Z@[hbTUn`?#4T_5-76s*FD"B[*;60S"Fs5hV3l_H;Jg)U"pu]Ab5>%-
.sG+JEGTN;20>qQCZhS!4cnH+3gu9S>G`;g(Z8r)O@MKRcO]ASd[r!YUB2$C7>c]A!9b9^AM4l
_<,\#E%:&,(<CuPA]Ae\3=Jdr'-^BRbrNfLis2/HfbIH3U%J^Q/,'4m7[Fi`Q(&.%6K,epf`Y
_="3q3Kk'Nol1K*+s8(M7P<jiDo@`u/bS90qA'rPf(mB;->8,d4"$@'7qe("_+o;-!e1_'EO
`*<R+?DHLO:sc[Q=4i//`6.TRDlN)=nH4ZBFVG)N;dTE=XCLk(^bB\K'&r[4*__XNQd-Y"<d
p*arQX&V@nf)$!h@H5L2!Rt1DFZB^^>f4^J!K1UdL4Zl$QTDV5/QH&@E<Jc<bC5eq\]A%)S0K
75:5]A,?6-a[X9%OiFU1dm5Ik\Tg<YH]AUrNTm4.RMd5!:"9iX&%C\sBH2@bQdIB!>Pr"L&U/O
s]A5c8EM!Q9Ad4nCur<f0JElVSZ=qI)]A`U0),=OH8A*e/'@A9YmCUAo9D:XkX>)3-XgJ4p[3b
/U9G?Zi:+FN+B_gl]AUDf35#/U4/O)ta=(8=&ef%?]AQc6B63b$eZKCcj!TVRJGDdcX3BVhI`t
T'L=C?3Ij25lcb)+Qd!<@((Vo3\jJmH`^7)1j>Rg,T>-EUY#iXu8#;n'gZ?9+qR&E$&Wf)d?
bJd+NC&nAc$L%LJA[BFfu)*ju_#TK'<eBn)kJGKrM&F_M0S,dA/YpV1r!;16?S.5Sir;S)X-
mIdo88quc86"FY=#Y8@(!%Wme>7IX/B;LiK1ZU\Zj,"pHF.k%C_\H`\s3p9R493[NU`h7O8r
X6m.aI'b*VI$)LSkq%r*O;p5=2mXHLD?UV\m=riEeLG#)J$CmSkP6o'bV%P"!KeY1(9IZhW7
2g3JhA"d#1/rT%PFN>0J8>&YL;S8r=jLL'"l+lgEB*W,,i4YhLj'^[lcsT\m([tM-2M:]AMpA
X(l$+);&aWPZQJ2NOTXs.a^H>bUYD4XrSi7+aDTRCmMC]Au/-;n;)iM#;R[9m0$<?]AWqNbSab
IFa`9_86$$g(u?4NJp%nGjFY:41-*%F%El>3;I,)1Zu1^qq%1cN3mGMu&XJeF\HrUJm<J!#G
(fXnG0#cGAu4NNO?[M2qE73kMFI[tHlEbs]A6lcsMf"hu?BXHXCbtnH2*_I4$5!8)kXok'!S#
('.pK96RZgbcbsRJg!1mdFKd%N<QM"@c/@in4S(qj'n!>\CEq"=`d$;C=Kf]ApN!=lRNVb%9A
?fT*,Nc]ACI-D_rMM(T<hXT<(m^6DO!O+dN;U4(_)o:Gsh>`<t[BpSlm^.1P.3iIC<^q7sh1+
Hes!&)qjT!EoI'U&#"LnRrb3jnP7fF:k'4j1j81324E9N(d`J#i<SHCpaYhgGK?2g7fJ\<lB
#;R)Ur%NM9*G&Q8j=^uE#m$`2nTKkDXpE`Mo\jgCV>a'"oBnO@anH>*n!S%FIAT%(f=h'Y-n
<GR==[-cRqd'$&TJJlQ*:&^]AmlVV(>Ql$I5@<HnD?jEa7I(Gi&cn7X4^,CG=,;XCjEe\O8Wf
YY1S$P@E#.g4D\sB`*cj>elmIC&R<qY"j,-;.M9>qU\+O%LjpA9(7^u8W/q8ucPd'p&l$s0N
'46<^Y#Ks/0Z`M6))ZRTB358^kK?0cm`-q@K*/&tlqjJUra+-.blK;q\bSfJo+JQ>L0XD8I6
^g7Sq[U\"hZ<!_AD,s=,,^YA)fb_QY"tYW&u1]A!RJ.o#=p$3#WPoKdK.g4#eQj3]AIWKO`dHf
K>ip6K\2ok7^OZ/<;,O7TI%Cad=)>Rn":ja,a@_5M#&6ds3P0\Uc`^_Op07B)4?a9@K'n,M7
C4JSJW>]A%V+F`3i-)P>5au\(!rH_orSIh7g]Adu(KB72<fBp:U=7@>McC>q/S'SkMj]A;6PDnT
HXh]AVIG7Ch#NZs`AmqUt7XGF4*PRsinrEpRsH?d^pq.H&0f@gFnJ=?;'R<VOn=%ZRL(*&D$?
jLtj7jP6e:;Z`<m?j7?2<!m5bk3<+G7-nrm5$L]AC'c_AZf<:#A7rpjHq9?rq5<2;p4]AWb34f
(K;kAp-V)Ams4fdBiI@`J@e&Mb4)O!+*70n'#ED>4<fX<YYY3a_-?hN6rB;.b&8cW[b<&Q9%
n)BFM_+N9tCrlhj@=H`kM:2qpRo/>2!`F4#&;9+o<a+V_#\O>3'B]AM<M]A"62Mh&0=Qj9j@b4
2%9A5i&Yb5DBbI2lrS,:D-M`]ASPMo4u^-.Bs7dFQfT5uIJ=A^bUBp^YYlmXp0aFU=qn>OS>`
8W12q==GOW0OkTN.6`,3r5Zj?en*srl!okWKZ=,/"WBit80;4!1#ecDV[*Nb4e/7WBSB$.^4
-<2?e8<NTbQrNa_;+f94;mr7L+W/5I:d"R,3USpn7%!*!5&U+T_riRD+1`c%<#<klBD+8H;>
:4c;0OHfeuN<]A?):q3P;^tLd*$YUb<O$`#g<8]AbF6n"HHpt)ppIJ.oLm&.^j4QM5Y9a4q/FD
%np2J1F1Zfr6u2bIYn"`iNIZdhX4U=OQW2<?B]AbC^_1#QsQ90n+lV\\dD93;tV@X64b\<pOb
[40d3D;T-*i<m]A"[XQH8c+&>5r_oY"-dZ8UQU1+kph>ro(;KA#"A;:2X;>paAt12W+3QnWKu
.!JRs`fma0n:%%^igQ:513K1nDTRij*afL=DhE)91^M]A*:9%-Y@e(EaVW]A6sYnh[Cim_%LUD
I&M\;iePikV>Nb>9$I)8k6=+M`AZVB6*ao7>hOYkX$B&XaUth=J*^K+K6kLP?)*5X3?H>\OL
riVqe)"0?k!d+#!EdANn<@?KCZsikV9WrJRo4![lZPLT#VO-ku:YDa>"VaqA!3>C:\DX5R_r
cKe4n:e$EBdTZ%lhL*1-HnYK;Qr60=bK&$YSH:.fuPp&hJ&\qT3fk*Z.#Z?5RAR8Fi)eAdST
]A"Rk1p1%Cd5/oMKiQJUV96^_Ud2%NEWOH'`>:LY49YLd%!d7-<g5ZTj]AEjK7tbRgTJBh4b$g
pkJ<L3oO?<Tdj6'#UX@\&1-V,]A'FE*I5b<JD1r5HZr;;<)iU'^7gIG!L&lE>M^GeSGp^=gL/
jp\HB:AMSq_.%S7"(1KS\*O&HHhaUhgo'bSlO1QgkCbOTB5#&t1`(c/NKC);Efq>,4@=V>#P
QBQE-b8s)=%:,QtZ;6P\DHBKJ9\#3CAE[4YRIg:@*.NM&L!1VFL6$*3cqMbINB11R,q%L2q.
\0p<KtbiXp"/k_[aoo#Kt:%!iDGV&MG;;%Cm4i**/OLPk+,=!GeC4a82!<b$r!]ARNgQ^o2+5
Yd0f[;>oHGct;146'srp1S.YSB"$fmT+Sk6Z3"k%Is&#o*aQL;Nf&(aa:.sgC/1jqd8EPQb[
)hdS'q'`#o'pcCB8*bIT;>V`t`FV8'c*5,@pGC]Ac5(17O1u^fs6Zm=E1f8/skmn/]AK'n(6Vu
Z(13!d^X1BgdNU0^OQX5D@5'T/-1ag\N.M2;*"ulLpJ3S9T]A^Q>BX$=f18u;j=U\!**q".W:
B%p=RN==gl<-'Pim\GJ+9_W[I(hHn,E-4!!~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="33" y="18" width="120" height="34"/>
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
<WidgetID widgetID="66bfc513-a259-448a-9e5e-c959c35f7de8"/>
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
<![CDATA[1143000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[5090160,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[航权时刻匹配率]]></O>
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
<FRFont name="微软雅黑" style="1" size="96" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;;eNPZcK[)ba5[#*[B5P%1^-OMpfJ:XOAi3NPgjCO.H5t,[@jH4U4NNlCM(.-dh.a<#Z
Yup9Q.-Q$CE#i)%&sHA3l0q6Vo4$P(=b7'dMdbaQ)'>5&PLK3$2qt[K=H5p`o3SkM,mg^V,,
Dn*f>45J0Eg]A^XU.5s[epj58Lt,:MbIHr/0CIfHHUU7^d6q:oX[cr"i]A[OlF\rI(b++Y2YNm
Xa\:&h2AiI6Dkjo";Kjlj'macCn<tepdS9WVDO'oCgRBNe=cRe#Rs5rop_:T?uTqV87%in\q
jp`2N6af5^-BbV.<k`fk7t7F/q@k@>%Xl)=J1Hg>kt</B`Jj?JGjO#U=3'0=t<UtZ5sMl%2J
M;CfHOO'fL%1*bJkiO*b5#P!>`ZeepG($RGKKO>7Pt:+G%]A!2!l,H8Vq3/Lt*,66^IQP<E[]A
QL(/LnfQLT\<e9-%U^O%ZM/cRM!7be53#F8o1=9-%tlIDZNFB9lk-%"XpK-lGj$G&e(]AFl#&
1$VK.:ocrnbA,j.E`iVhoY#1M_RhOm@h*oS8[,!fRU2]A"WGK/i0?)&e/FS`D2O=$5#;O8B-(
Yh&_35'*LneTnLE8AY-E8Rh0?<>sN?Z!qNGM,6/E%rX)rKlm;lHYuSM\\obg`"fg5+Pl3DC5
*lm_Nf+EqBZ8Qe7_h/L'V%AmXrB+h-iQXn#@;S7Sb4^j&dgrc'M_s(Kl\g9um0W'7aBnET.h
M2VP6!kX%WrN\5oC32-*n?M?"i^Jbo.NMH!4AtT42^iGXeLI>3`TVeuM)mDh$@_CWRoYrpWG
fml9odW-SHQTWm4rUU,H=th4X;qrZjCq\N\nCqhQj%`NiLuHoN<CdX"q^ji"Dtt63d;bj3#(
(.rP!<r[tV$VfO8XJ.'9lPWRW*n-2J%m=!+2U%B1oN"gQoUoT@9M-&961M\RhZ:3)&Um'-W'
<6r4S6Y$?)`>!55gRpl6\c2GCK.l,?:Hp&qN<a+$o\YRZo5\Ap7CgI8.hup&p;iTah5ZQrZ>
.Q2kpX9UT2pB/#&%]A3,_lB^nrfNkOtN4Ch%GUHgf]AFZU`B]A/p'8?F$>S^S.k%do9L4e024TJ
l0h6.<TR&RkdR#lVj$,Ha""bC(Tp!8g^cS3'+#nhREW5-Q6@;QZb+?c+Vq"i?1[X:6JnF&S)
c?MZR.j4aSJ1o?Uc^9T_$)9TKs=6D;trj1\r>BG-d7,8>b2OD]Ag/WlQhEeSj9Gq9b=s_6o\5
HgbcFFUt/]Af8K-3Hc3-E:[TlNdI^;;&Q>UJ!=u8tA#b<7S@^"=H*`DnMj::!>cJ;&rdJ\Q"g
\4#,D7D\J%rD<iocsfD"XG.?6u!GZ%e;07CZ8X(%I9+jj$0$XTmnVH)6KK<>;@f,LKIZgY4[
fqEWe96?[Ke5Jl>mt'"Jc0Ssg`9h*f0>i'61iDbV4lH<ptd:pKKH09\5bFT:mloM5<Un,$%d
n1E9<X48$49hf5IEB.)[YUd1p9!`o[cP8$7Y>"K:+"c6rH?*2t"L3Uh]AiiFEoZEAGP@Fj+:<
ODm?`d>JD'NYb8Qjh^_ci0f55%m&:WKj<9$3Ebam%JOZ':uqZWnLEL9:lf-h67^cF**Bm"[[
>+;7[4rjk0SH>4B0h:Z@[hbTUn`?#4T_5-76s*FD"B[*;60S"Fs5hV3l_H;Jg)U"pu]Ab5>%-
.sG+JEGTN;20>qQCZhS!4cnH+3gu9S>G`;g(Z8r)O@MKRcO]ASd[r!YUB2$C7>c]A!9b9^AM4l
_<,\#E%:&,(<CuPA]Ae\3=Jdr'-^BRbrNfLis2/HfbIH3U%J^Q/,'4m7[Fi`Q(&.%6K,epf`Y
_="3q3Kk'Nol1K*+s8(M7P<jiDo@`u/bS90qA'rPf(mB;->8,d4"$@'7qe("_+o;-!e1_'EO
`*<R+?DHLO:sc[Q=4i//`6.TRDlN)=nH4ZBFVG)N;dTE=XCLk(^bB\K'&r[4*__XNQd-Y"<d
p*arQX&V@nf)$!h@H5L2!Rt1DFZB^^>f4^J!K1UdL4Zl$QTDV5/QH&@E<Jc<bC5eq\]A%)S0K
75:5]A,?6-a[X9%OiFU1dm5Ik\Tg<YH]AUrNTm4.RMd5!:"9iX&%C\sBH2@bQdIB!>Pr"L&U/O
s]A5c8EM!Q9Ad4nCur<f0JElVSZ=qI)]A`U0),=OH8A*e/'@A9YmCUAo9D:XkX>)3-XgJ4p[3b
/U9G?Zi:+FN+B_gl]AUDf35#/U4/O)ta=(8=&ef%?]AQc6B63b$eZKCcj!TVRJGDdcX3BVhI`t
T'L=C?3Ij25lcb)+Qd!<@((Vo3\jJmH`^7)1j>Rg,T>-EUY#iXu8#;n'gZ?9+qR&E$&Wf)d?
bJd+NC&nAc$L%LJA[BFfu)*ju_#TK'<eBn)kJGKrM&F_M0S,dA/YpV1r!;16?S.5Sir;S)X-
mIdo88quc86"FY=#Y8@(!%Wme>7IX/B;LiK1ZU\Zj,"pHF.k%C_\H`\s3p9R493[NU`h7O8r
X6m.aI'b*VI$)LSkq%r*O;p5=2mXHLD?UV\m=riEeLG#)J$CmSkP6o'bV%P"!KeY1(9IZhW7
2g3JhA"d#1/rT%PFN>0J8>&YL;S8r=jLL'"l+lgEB*W,,i4YhLj'^[lcsT\m([tM-2M:]AMpA
X(l$+);&aWPZQJ2NOTXs.a^H>bUYD4XrSi7+aDTRCmMC]Au/-;n;)iM#;R[9m0$<?]AWqNbSab
IFa`9_86$$g(u?4NJp%nGjFY:41-*%F%El>3;I,)1Zu1^qq%1cN3mGMu&XJeF\HrUJm<J!#G
(fXnG0#cGAu4NNO?[M2qE73kMFI[tHlEbs]A6lcsMf"hu?BXHXCbtnH2*_I4$5!8)kXok'!S#
('.pK96RZgbcbsRJg!1mdFKd%N<QM"@c/@in4S(qj'n!>\CEq"=`d$;C=Kf]ApN!=lRNVb%9A
?fT*,Nc]ACI-D_rMM(T<hXT<(m^6DO!O+dN;U4(_)o:Gsh>`<t[BpSlm^.1P.3iIC<^q7sh1+
Hes!&)qjT!EoI'U&#"LnRrb3jnP7fF:k'4j1j81324E9N(d`J#i<SHCpaYhgGK?2g7fJ\<lB
#;R)Ur%NM9*G&Q8j=^uE#m$`2nTKkDXpE`Mo\jgCV>a'"oBnO@anH>*n!S%FIAT%(f=h'Y-n
<GR==[-cRqd'$&TJJlQ*:&^]AmlVV(>Ql$I5@<HnD?jEa7I(Gi&cn7X4^,CG=,;XCjEe\O8Wf
YY1S$P@E#.g4D\sB`*cj>elmIC&R<qY"j,-;.M9>qU\+O%LjpA9(7^u8W/q8ucPd'p&l$s0N
'46<^Y#Ks/0Z`M6))ZRTB358^kK?0cm`-q@K*/&tlqjJUra+-.blK;q\bSfJo+JQ>L0XD8I6
^g7Sq[U\"hZ<!_AD,s=,,^YA)fb_QY"tYW&u1]A!RJ.o#=p$3#WPoKdK.g4#eQj3]AIWKO`dHf
K>ip6K\2ok7^OZ/<;,O7TI%Cad=)>Rn":ja,a@_5M#&6ds3P0\Uc`^_Op07B)4?a9@K'n,M7
C4JSJW>]A%V+F`3i-)P>5au\(!rH_orSIh7g]Adu(KB72<fBp:U=7@>McC>q/S'SkMj]A;6PDnT
HXh]AVIG7Ch#NZs`AmqUt7XGF4*PRsinrEpRsH?d^pq.H&0f@gFnJ=?;'R<VOn=%ZRL(*&D$?
jLtj7jP6e:;Z`<m?j7?2<!m5bk3<+G7-nrm5$L]AC'c_AZf<:#A7rpjHq9?rq5<2;p4]AWb34f
(K;kAp-V)Ams4fdBiI@`J@e&Mb4)O!+*70n'#ED>4<fX<YYY3a_-?hN6rB;.b&8cW[b<&Q9%
n)BFM_+N9tCrlhj@=H`kM:2qpRo/>2!`F4#&;9+o<a+V_#\O>3'B]AM<M]A"62Mh&0=Qj9j@b4
2%9A5i&Yb5DBbI2lrS,:D-M`]ASPMo4u^-.Bs7dFQfT5uIJ=A^bUBp^YYlmXp0aFU=qn>OS>`
8W12q==GOW0OkTN.6`,3r5Zj?en*srl!okWKZ=,/"WBit80;4!1#ecDV[*Nb4e/7WBSB$.^4
-<2?e8<NTbQrNa_;+f94;mr7L+W/5I:d"R,3USpn7%!*!5&U+T_riRD+1`c%<#<klBD+8H;>
:4c;0OHfeuN<]A?):q3P;^tLd*$YUb<O$`#g<8]AbF6n"HHpt)ppIJ.oLm&.^j4QM5Y9a4q/FD
%np2J1F1Zfr6u2bIYn"`iNIZdhX4U=OQW2<?B]AbC^_1#QsQ90n+lV\\dD93;tV@X64b\<pOb
[40d3D;T-*i<m]A"[XQH8c+&>5r_oY"-dZ8UQU1+kph>ro(;KA#"A;:2X;>paAt12W+3QnWKu
.!JRs`fma0n:%%^igQ:513K1nDTRij*afL=DhE)91^M]A*:9%-Y@e(EaVW]A6sYnh[Cim_%LUD
I&M\;iePikV>Nb>9$I)8k6=+M`AZVB6*ao7>hOYkX$B&XaUth=J*^K+K6kLP?)*5X3?H>\OL
riVqe)"0?k!d+#!EdANn<@?KCZsikV9WrJRo4![lZPLT#VO-ku:YDa>"VaqA!3>C:\DX5R_r
cKe4n:e$EBdTZ%lhL*1-HnYK;Qr60=bK&$YSH:.fuPp&hJ&\qT3fk*Z.#Z?5RAR8Fi)eAdST
]A"Rk1p1%Cd5/oMKiQJUV96^_Ud2%NEWOH'`>:LY49YLd%!d7-<g5ZTj]AEjK7tbRgTJBh4b$g
pkJ<L3oO?<Tdj6'#UX@\&1-V,]A'FE*I5b<JD1r5HZr;;<)iU'^7gIG!L&lE>M^GeSGp^=gL/
jp\HB:AMSq_.%S7"(1KS\*O&HHhaUhgo'bSlO1QgkCbOTB5#&t1`(c/NKC);Efq>,4@=V>#P
QBQE-b8s)=%:,QtZ;6P\DHBKJ9\#3CAE[4YRIg:@*.NM&L!1VFL6$*3cqMbINB11R,q%L2q.
\0p<KtbiXp"/k_[aoo#Kt:%!iDGV&MG;;%Cm4i**/OLPk+,=!GeC4a82!<b$r!]ARNgQ^o2+5
Yd0f[;>oHGct;146'srp1S.YSB"$fmT+Sk6Z3"k%Is&#o*aQL;Nf&(aa:.sgC/1jqd8EPQb[
)hdS'q'`#o'pcCB8*bIT;>V`t`FV8'c*5,@pGC]Ac5(17O1u^fs6Zm=E1f8/skmn/]AK'n(6Vu
Z(13!d^X1BgdNU0^OQX5D@5'T/-1ag\N.M2;*"ulLpJ3S9T]A^Q>BX$=f18u;j=U\!**q".W:
B%p=RN==gl<-'Pim\GJ+9_W[I(hHn,E-4!!~
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
<WidgetID widgetID="66bfc513-a259-448a-9e5e-c959c35f7de8"/>
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
<![CDATA[1143000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[5090160,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[航权时刻匹配率]]></O>
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
<FRFont name="微软雅黑" style="1" size="96" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;;eNPZcK[)ba5[#*[B5P%1^-OMpfJ:XOAi3NPgjCO.H5t,[@jH4U4NNlCM(.-dh.a<#Z
Yup9Q.-Q$CE#i)%&sHA3l0q6Vo4$P(=b7'dMdbaQ)'>5&PLK3$2qt[K=H5p`o3SkM,mg^V,,
Dn*f>45J0Eg]A^XU.5s[epj58Lt,:MbIHr/0CIfHHUU7^d6q:oX[cr"i]A[OlF\rI(b++Y2YNm
Xa\:&h2AiI6Dkjo";Kjlj'macCn<tepdS9WVDO'oCgRBNe=cRe#Rs5rop_:T?uTqV87%in\q
jp`2N6af5^-BbV.<k`fk7t7F/q@k@>%Xl)=J1Hg>kt</B`Jj?JGjO#U=3'0=t<UtZ5sMl%2J
M;CfHOO'fL%1*bJkiO*b5#P!>`ZeepG($RGKKO>7Pt:+G%]A!2!l,H8Vq3/Lt*,66^IQP<E[]A
QL(/LnfQLT\<e9-%U^O%ZM/cRM!7be53#F8o1=9-%tlIDZNFB9lk-%"XpK-lGj$G&e(]AFl#&
1$VK.:ocrnbA,j.E`iVhoY#1M_RhOm@h*oS8[,!fRU2]A"WGK/i0?)&e/FS`D2O=$5#;O8B-(
Yh&_35'*LneTnLE8AY-E8Rh0?<>sN?Z!qNGM,6/E%rX)rKlm;lHYuSM\\obg`"fg5+Pl3DC5
*lm_Nf+EqBZ8Qe7_h/L'V%AmXrB+h-iQXn#@;S7Sb4^j&dgrc'M_s(Kl\g9um0W'7aBnET.h
M2VP6!kX%WrN\5oC32-*n?M?"i^Jbo.NMH!4AtT42^iGXeLI>3`TVeuM)mDh$@_CWRoYrpWG
fml9odW-SHQTWm4rUU,H=th4X;qrZjCq\N\nCqhQj%`NiLuHoN<CdX"q^ji"Dtt63d;bj3#(
(.rP!<r[tV$VfO8XJ.'9lPWRW*n-2J%m=!+2U%B1oN"gQoUoT@9M-&961M\RhZ:3)&Um'-W'
<6r4S6Y$?)`>!55gRpl6\c2GCK.l,?:Hp&qN<a+$o\YRZo5\Ap7CgI8.hup&p;iTah5ZQrZ>
.Q2kpX9UT2pB/#&%]A3,_lB^nrfNkOtN4Ch%GUHgf]AFZU`B]A/p'8?F$>S^S.k%do9L4e024TJ
l0h6.<TR&RkdR#lVj$,Ha""bC(Tp!8g^cS3'+#nhREW5-Q6@;QZb+?c+Vq"i?1[X:6JnF&S)
c?MZR.j4aSJ1o?Uc^9T_$)9TKs=6D;trj1\r>BG-d7,8>b2OD]Ag/WlQhEeSj9Gq9b=s_6o\5
HgbcFFUt/]Af8K-3Hc3-E:[TlNdI^;;&Q>UJ!=u8tA#b<7S@^"=H*`DnMj::!>cJ;&rdJ\Q"g
\4#,D7D\J%rD<iocsfD"XG.?6u!GZ%e;07CZ8X(%I9+jj$0$XTmnVH)6KK<>;@f,LKIZgY4[
fqEWe96?[Ke5Jl>mt'"Jc0Ssg`9h*f0>i'61iDbV4lH<ptd:pKKH09\5bFT:mloM5<Un,$%d
n1E9<X48$49hf5IEB.)[YUd1p9!`o[cP8$7Y>"K:+"c6rH?*2t"L3Uh]AiiFEoZEAGP@Fj+:<
ODm?`d>JD'NYb8Qjh^_ci0f55%m&:WKj<9$3Ebam%JOZ':uqZWnLEL9:lf-h67^cF**Bm"[[
>+;7[4rjk0SH>4B0h:Z@[hbTUn`?#4T_5-76s*FD"B[*;60S"Fs5hV3l_H;Jg)U"pu]Ab5>%-
.sG+JEGTN;20>qQCZhS!4cnH+3gu9S>G`;g(Z8r)O@MKRcO]ASd[r!YUB2$C7>c]A!9b9^AM4l
_<,\#E%:&,(<CuPA]Ae\3=Jdr'-^BRbrNfLis2/HfbIH3U%J^Q/,'4m7[Fi`Q(&.%6K,epf`Y
_="3q3Kk'Nol1K*+s8(M7P<jiDo@`u/bS90qA'rPf(mB;->8,d4"$@'7qe("_+o;-!e1_'EO
`*<R+?DHLO:sc[Q=4i//`6.TRDlN)=nH4ZBFVG)N;dTE=XCLk(^bB\K'&r[4*__XNQd-Y"<d
p*arQX&V@nf)$!h@H5L2!Rt1DFZB^^>f4^J!K1UdL4Zl$QTDV5/QH&@E<Jc<bC5eq\]A%)S0K
75:5]A,?6-a[X9%OiFU1dm5Ik\Tg<YH]AUrNTm4.RMd5!:"9iX&%C\sBH2@bQdIB!>Pr"L&U/O
s]A5c8EM!Q9Ad4nCur<f0JElVSZ=qI)]A`U0),=OH8A*e/'@A9YmCUAo9D:XkX>)3-XgJ4p[3b
/U9G?Zi:+FN+B_gl]AUDf35#/U4/O)ta=(8=&ef%?]AQc6B63b$eZKCcj!TVRJGDdcX3BVhI`t
T'L=C?3Ij25lcb)+Qd!<@((Vo3\jJmH`^7)1j>Rg,T>-EUY#iXu8#;n'gZ?9+qR&E$&Wf)d?
bJd+NC&nAc$L%LJA[BFfu)*ju_#TK'<eBn)kJGKrM&F_M0S,dA/YpV1r!;16?S.5Sir;S)X-
mIdo88quc86"FY=#Y8@(!%Wme>7IX/B;LiK1ZU\Zj,"pHF.k%C_\H`\s3p9R493[NU`h7O8r
X6m.aI'b*VI$)LSkq%r*O;p5=2mXHLD?UV\m=riEeLG#)J$CmSkP6o'bV%P"!KeY1(9IZhW7
2g3JhA"d#1/rT%PFN>0J8>&YL;S8r=jLL'"l+lgEB*W,,i4YhLj'^[lcsT\m([tM-2M:]AMpA
X(l$+);&aWPZQJ2NOTXs.a^H>bUYD4XrSi7+aDTRCmMC]Au/-;n;)iM#;R[9m0$<?]AWqNbSab
IFa`9_86$$g(u?4NJp%nGjFY:41-*%F%El>3;I,)1Zu1^qq%1cN3mGMu&XJeF\HrUJm<J!#G
(fXnG0#cGAu4NNO?[M2qE73kMFI[tHlEbs]A6lcsMf"hu?BXHXCbtnH2*_I4$5!8)kXok'!S#
('.pK96RZgbcbsRJg!1mdFKd%N<QM"@c/@in4S(qj'n!>\CEq"=`d$;C=Kf]ApN!=lRNVb%9A
?fT*,Nc]ACI-D_rMM(T<hXT<(m^6DO!O+dN;U4(_)o:Gsh>`<t[BpSlm^.1P.3iIC<^q7sh1+
Hes!&)qjT!EoI'U&#"LnRrb3jnP7fF:k'4j1j81324E9N(d`J#i<SHCpaYhgGK?2g7fJ\<lB
#;R)Ur%NM9*G&Q8j=^uE#m$`2nTKkDXpE`Mo\jgCV>a'"oBnO@anH>*n!S%FIAT%(f=h'Y-n
<GR==[-cRqd'$&TJJlQ*:&^]AmlVV(>Ql$I5@<HnD?jEa7I(Gi&cn7X4^,CG=,;XCjEe\O8Wf
YY1S$P@E#.g4D\sB`*cj>elmIC&R<qY"j,-;.M9>qU\+O%LjpA9(7^u8W/q8ucPd'p&l$s0N
'46<^Y#Ks/0Z`M6))ZRTB358^kK?0cm`-q@K*/&tlqjJUra+-.blK;q\bSfJo+JQ>L0XD8I6
^g7Sq[U\"hZ<!_AD,s=,,^YA)fb_QY"tYW&u1]A!RJ.o#=p$3#WPoKdK.g4#eQj3]AIWKO`dHf
K>ip6K\2ok7^OZ/<;,O7TI%Cad=)>Rn":ja,a@_5M#&6ds3P0\Uc`^_Op07B)4?a9@K'n,M7
C4JSJW>]A%V+F`3i-)P>5au\(!rH_orSIh7g]Adu(KB72<fBp:U=7@>McC>q/S'SkMj]A;6PDnT
HXh]AVIG7Ch#NZs`AmqUt7XGF4*PRsinrEpRsH?d^pq.H&0f@gFnJ=?;'R<VOn=%ZRL(*&D$?
jLtj7jP6e:;Z`<m?j7?2<!m5bk3<+G7-nrm5$L]AC'c_AZf<:#A7rpjHq9?rq5<2;p4]AWb34f
(K;kAp-V)Ams4fdBiI@`J@e&Mb4)O!+*70n'#ED>4<fX<YYY3a_-?hN6rB;.b&8cW[b<&Q9%
n)BFM_+N9tCrlhj@=H`kM:2qpRo/>2!`F4#&;9+o<a+V_#\O>3'B]AM<M]A"62Mh&0=Qj9j@b4
2%9A5i&Yb5DBbI2lrS,:D-M`]ASPMo4u^-.Bs7dFQfT5uIJ=A^bUBp^YYlmXp0aFU=qn>OS>`
8W12q==GOW0OkTN.6`,3r5Zj?en*srl!okWKZ=,/"WBit80;4!1#ecDV[*Nb4e/7WBSB$.^4
-<2?e8<NTbQrNa_;+f94;mr7L+W/5I:d"R,3USpn7%!*!5&U+T_riRD+1`c%<#<klBD+8H;>
:4c;0OHfeuN<]A?):q3P;^tLd*$YUb<O$`#g<8]AbF6n"HHpt)ppIJ.oLm&.^j4QM5Y9a4q/FD
%np2J1F1Zfr6u2bIYn"`iNIZdhX4U=OQW2<?B]AbC^_1#QsQ90n+lV\\dD93;tV@X64b\<pOb
[40d3D;T-*i<m]A"[XQH8c+&>5r_oY"-dZ8UQU1+kph>ro(;KA#"A;:2X;>paAt12W+3QnWKu
.!JRs`fma0n:%%^igQ:513K1nDTRij*afL=DhE)91^M]A*:9%-Y@e(EaVW]A6sYnh[Cim_%LUD
I&M\;iePikV>Nb>9$I)8k6=+M`AZVB6*ao7>hOYkX$B&XaUth=J*^K+K6kLP?)*5X3?H>\OL
riVqe)"0?k!d+#!EdANn<@?KCZsikV9WrJRo4![lZPLT#VO-ku:YDa>"VaqA!3>C:\DX5R_r
cKe4n:e$EBdTZ%lhL*1-HnYK;Qr60=bK&$YSH:.fuPp&hJ&\qT3fk*Z.#Z?5RAR8Fi)eAdST
]A"Rk1p1%Cd5/oMKiQJUV96^_Ud2%NEWOH'`>:LY49YLd%!d7-<g5ZTj]AEjK7tbRgTJBh4b$g
pkJ<L3oO?<Tdj6'#UX@\&1-V,]A'FE*I5b<JD1r5HZr;;<)iU'^7gIG!L&lE>M^GeSGp^=gL/
jp\HB:AMSq_.%S7"(1KS\*O&HHhaUhgo'bSlO1QgkCbOTB5#&t1`(c/NKC);Efq>,4@=V>#P
QBQE-b8s)=%:,QtZ;6P\DHBKJ9\#3CAE[4YRIg:@*.NM&L!1VFL6$*3cqMbINB11R,q%L2q.
\0p<KtbiXp"/k_[aoo#Kt:%!iDGV&MG;;%Cm4i**/OLPk+,=!GeC4a82!<b$r!]ARNgQ^o2+5
Yd0f[;>oHGct;146'srp1S.YSB"$fmT+Sk6Z3"k%Is&#o*aQL;Nf&(aa:.sgC/1jqd8EPQb[
)hdS'q'`#o'pcCB8*bIT;>V`t`FV8'c*5,@pGC]Ac5(17O1u^fs6Zm=E1f8/skmn/]AK'n(6Vu
Z(13!d^X1BgdNU0^OQX5D@5'T/-1ag\N.M2;*"ulLpJ3S9T]A^Q>BX$=f18u;j=U\!**q".W:
B%p=RN==gl<-'Pim\GJ+9_W[I(hHn,E-4!!~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="33" y="339" width="250" height="34"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ComboCheckBox">
<WidgetName name="pb"/>
<WidgetID widgetID="f500d96f-28ea-49ac-82ac-1af73a604130"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="comboCheckBox1" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Dictionary class="com.fr.data.impl.CustomDictionary">
<CustomDictAttr>
<Dict key="冬航季" value="冬航季"/>
<Dict key="夏航季" value="夏航季"/>
</CustomDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[]]></O>
</widgetValue>
<RAAttr delimiter="&apos;,&apos;" isArray="false"/>
</InnerWidget>
<BoundsAttr x="711" y="64" width="80" height="21"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ComboCheckBox">
<WidgetName name="pa"/>
<WidgetID widgetID="2ced9826-b681-4749-aabe-117cc5a4b1d5"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="comboCheckBox0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Dictionary class="com.fr.data.impl.TableDataDictionary">
<FormulaDictAttr kiName="年" viName="年"/>
<TableDataDictAttr>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[正班-航线满足率-时间维度]]></Name>
</TableData>
</TableDataDictAttr>
</Dictionary>
<widgetValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=YEAR(today())]]></Attributes>
</O>
</widgetValue>
<RAAttr delimiter="&apos;,&apos;" isArray="false"/>
</InnerWidget>
<BoundsAttr x="590" y="64" width="80" height="21"/>
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
<WidgetID widgetID="18a8add0-fea6-48b1-9b76-7a3e90961fc8"/>
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
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,1249680,1280160,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" rs="2" s="0">
<O>
<![CDATA[年度]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" rs="2" s="0">
<O>
<![CDATA[分类航季]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" rs="2" s="0">
<O>
<![CDATA[分类]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" rs="2" s="0">
<O>
<![CDATA[总数]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" rs="2" s="0">
<O>
<![CDATA[一致]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" cs="3" s="1">
<O>
<![CDATA[早于局批(min)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="0" cs="4" s="1">
<O>
<![CDATA[晚于局批(min)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="0" rs="2" s="0">
<O>
<![CDATA[前后三十分钟百分比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="1" s="2">
<O>
<![CDATA[≤15]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="1" s="2">
<O>
<![CDATA[16-30]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="1" s="2">
<O>
<![CDATA[≥31]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="1" s="2">
<O>
<![CDATA[≤15]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="1" s="2">
<O>
<![CDATA[16-30]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="1" s="2">
<O>
<![CDATA[31-90]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="1" s="2">
<O>
<![CDATA[≥91]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" rs="2" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="nd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="1" r="2" rs="2" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="hj"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="2" s="4">
<O>
<![CDATA[工作日]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日总和"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日完全一致数"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日公司早于局批15分钟内"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日公司早于局批16至30分钟"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="7" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日公司早于局批30分钟以上"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日公司晚于局批15分钟以内"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日公司晚于局批16至30分钟"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="10" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日公司晚于局批31至90分钟"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日公司晚于局批91分钟以上"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="12" r="2" s="5">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日前后30分钟百分比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="3" s="3">
<O>
<![CDATA[总体]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体总和"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体完全一致数"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体公司早于局批15分钟内"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体公司早于局批16至30分钟"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="7" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体公司早于局批30分钟以上"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体公司晚于局批15分钟以内"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体公司晚于局批16至30分钟"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="10" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体公司晚于局批31至90分钟"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体公司晚于局批91分钟以上"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="12" r="3" s="6">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体前后30分钟百分比"/>
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
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border>
<Top style="1" color="-1"/>
<Bottom color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border>
<Top color="-1"/>
<Bottom style="1" color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border>
<Top color="-1"/>
<Bottom style="1" color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border>
<Top color="-1"/>
<Bottom color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border>
<Top color="-1"/>
<Bottom color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border>
<Top color="-1"/>
<Bottom style="1" color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m99s#;cgE9j%Q#p;5WAQ`[YN#78!e?%SCsm;ludedR(&H+K;3#;O%M"6HH4Y#Ak2ROb,nB>)
O9#&iE:;GuZFa";2Fq6:.CnE57RR&<`.L9sAeE7rl,3hROY"4qHp=S$U^MHi7aYC[I\=hd.$
Vl,?_1*&hcjUufeV8fBYVG<t9/NF2MYk<4#Im%1?t2fAB]AbMRX;h0`CU=)@Dhb^r3N><B:-Q
W&)V[Wh>;gA^T#$(q3jop+]A)i]Ad*ABM-\DNF2,Rh<O.HFS14r5MA_VmXmIt554Nprnr[GhfG
c%3[s3`=+loY0,\H;4U'9PJ0LKnU=P3BCCi()'nu`rm=+-]ABs:K?J:%9a5W58kT?tA+=So]A(
%k6=X\$33Q/J$I$6CCOG)_I5`i+H+JO94e[g`Wf_b#l'ohkCdQQL'(ElPl%j-frht4;C383B
JE2Ibru^m7!VIXJDq.DX5T-*O?MdkX`kLGGbUOoB:>.oPA5Vk3S2l^r%g]Ab=_L+!A0m)l&i$
Fk*m93I+X0rk23At>$%0h@0@@6q</P+'H4?Uie?MNE?BUD'\B8q/ertCPt^.B:E&H_lg(6OW
YsBU@ET:U7*o":l+:b&R_E:1\k:j`&I,$]AfWN`u[OLM:0F]A10EL%,6&TE=^hLF/Ij1JDqF`8
Xg6CIT8]AHBjKR9jYUqXMmE\_J+'ITZ5Uh03\eN-Y=ZKah8drK)W/DnsQ1_PXd`$q#qe^`NR0
>%O29d`>e!gi)7@?s3D+dHLCNNFYD#NEW*b+T;2*Ck.V(I0#s"Z)N+o"Mn^,*j(K?NK$ok&S
BA$`<uhnN^'a:6bj&h!('d`$_D7oMtmsP'P4,s1[Kph+/SndjS]A8@%Q<n/\p3bPKVhp).nG0
V"gPR:IU8<$Z;gQHBR7R?q2&S(7g,hoeo'^qA&Q@8Bkt-aiad^ZjDtC%CbRbF\6`mek5Q2>S
.j*I#VjEF;9FJ"kho!R8.[^*#Z4WtD@aN#KpDn.?6Zf5EgMT]A[G9eZ+^oJa)jj)uUcsb(F;"
q8[R.sg',[Y?`'#;E@(Ad<[Th6L]AmI'E_<^A?c'H#bl;JkRkHrZ8*b/=Dp&I`.jKC[7-H6op
;t2\^r<?P[<KX;rM3lm0ErA_5_W-E0)_Dq<W*!(jMq/Fh#["n]A%3\5L;)Os;cRUN^2C=u/:)
ZZa9[44R=HNBc*ZIR>VYLs74H![-(L+a>_I.\'OV!h/_1DQX-mD;jYQ<@B1f.IYC<7XKQ1fF
!^9p/=RU2b,XNH_R+4"ueX0<#H$.rEtjBE@a`]ADR?7/?,JY%ioQLhZT3YE<YV#]A.nd:]AeCkZ
Ce=3$Tu.V<=B4.^o??`ZZ\m%eRgg?.Q?HieYmPqR[J&NGND%EL-'3$_T/:S(`;JO!QnnZ$!Q
6JE?,?M,Y1`%L!Um%A"-NSnCYYLItKCgNI##<a_T'_J"k56iX@-gmr+%\`E&ZWa=VC9PcatC
8Z__Nnne-Z)@mfe%EThP[RXqsSh:Ka9hO;i0X=eYol'\clBbYY'U+5K5^""gFLM_>1A&rfbb
rHCp3dt36C/Hf9m>Jj7(M,I<t?UsI>L^s;_/^&e4C@$+TP@*>5'cT6RoWg4hWQolTf5U0!2i
AqaB(AnR7\[+<*^/]A0$a@a0Rcm>:$,]Ae^aXKK;[n/egBUu.VGLXWndae575]A0>-YLeG0q"-B
TW6N0l>/c_\\!/pNnc;Mo]A7aK$9m3R/J&\^d$/dZM5s6L4;1n9hYi>[MPB^eZ`u/g^HhD<fE
b;9#(i,2[9\&B]Aa0V3tV[r>V#q1$#DM(,Gj/,TEr!?%dSXL>]A@$6@PJ7Ldk"6,[Vq(.1JK%_
LaNkq#sq%h/*8SP9-GK&DcI<)(o>S0P+de7RaQ%7FJkArQ,'BG`4h58jK.@&>;B4OL3sc.Lc
;nBri]A]AP2^kUE>'A4Nl!<N&\Dl9bXhe2HjL-@^.^i.i2l3FJ7P.GB4sj`&E#)K6qUJ4[\.)e
G<S3UFHiXHBIXf34!Nm!mqM2C]AZGgC5S@G=YW\Z_a-\jY`(5U(b"t>g8'LaNj30;uS-S;S_f
+0$aJ2?L`A+Fd^g%K3*R\LrQ"Q'o0*?=u23-*bLe:OatAG-F9a'rVQgtc%,AJs>f($kUJ&H5
P@eV]AM@b1Fd.d[R^\[U0_&(6I>WA-lW$-tL<4m:oM,b)dc@)E>>Yjib_gVZfOC9X!GlX.r8o
`FX)H8qA02YA,E3"oF9eFk&L(3,.;?q6Kp')%K[:+</aSV8RN"f#N[NI^81*k]Al[VL#1MipQ
YAhXL/TC3RpphWnDrBCIIug(`C801+K@?CF2=G.3)$RIt,X'pKb35;sr6hL2;-!YJW,o[:&u
URY9[7P6Q>uI;@5//#s;O`]A%\eb"F:MUM::F_c?c"j\gPh,!,NIq:8uYp*L6)G-k!qYZ)mBl
h!WL(XlguYD[DpA)9.X-%+.q/BpRaRboWZ&T91:#7+l=2c;E_nmLaZ0H_Vh5Z7p\(rGQ?QQ'
b3-DDh\2;<9;.:jHt=+:]A7UBo]A4`_N=7]Al/4<TU<m2mW&Og=`qt28>iRT<0QnoPNLIg$6i`O
NL)%GHad_f-MlVXVc.#FWe*7A&?bG/8T?B7jl#>Xp`)^A)c9\Zl]AK3aa-,dNka*@.,ohXL>[
pDYCJ(^U:lFjj`V$Lu>`3'q+QI56GS:KK1NfYkCgm!`IG8U9?8olQ'TB6Ibk($S6dm7>Qk,K
2-+;I6K_N'1oE(pK-c"GWEBEKG3WC-S!DR@sK\uQgp*N0+M2B@!Z"KACi=$@;:4lF7/WgWuh
O0?Ehs"!n"h>Z8-s^%go:EL!_jOe2]AlZbjf-TtPZB@ffB,6u)&p)Mc:nr2*DC4HrI5F8i8d^
I$P-?"tMce_8OUhatfEfZD>7ZhaaDK8/r1co+Jts6D$n:^LY%io/2aW&p;Q*rL2RYTs"%R1R
)i7/j:D.u^1hI]AlF=HV2DZQ/eA=#6&"$Ku\UZ%%,A!0`aHhS5kq>8o`Rdp9>g4DZn6hY'L/?
Li"T7j^La`LCBW02heAopY!co2[1?8M2R<T]A,2aS(7LK31^Egh#Q4Q!e]ATpOmcNd2ZTKDAD=
4L`^$(=j`J\duJ`59f6V%5`Bj^icCPgp1Y0ifr.\[H.1Dp-g]AAdL7D1iFmpo'6e>lWZSfA4K
[\#$4#P%hUdS.c*F!>=m5nmZdu8g[laSU,X-o<kFT+*[%do/s(I\q%nD)lW3k!oTR/]AfO!O;
gAPS]Amg[s%J0q;(Ou*>\oV<K4$0_tL,oc@!LQm!J>.:5_o+M.5J"_&SI#N:Xi>>or.I8i:f=
:(@_a<TQ8S7mQmH0cS0.]A&keY+h<KcqpF6T:S<[]AV[VZ_:.\t,Ol(Ao-DsbC2DKd@[t50TBG
J()-iSj@*>^U]AAm)erGBM*@5WZLX##4+;Q[W$'(7I/0DA058@XClbTpVqCM'pWQ!=/oCb"B1
$QNp.MWmd?grBtg-'m$Y5XI#OuQg_q9i^I4Pm$4`]AbD-[c'9Yp/pR9j:.;+4SIhq3>3RooBJ
`OqH5tZ0[9pIYFXqRbTV`7%qgI58/@s9ra1A^$4FchJt3P52?G@'#fVXarrYR)6/#N+6XZi.
GHr<W/>'\[W*QN4b*.Ip7+?b#SpoC_OP3U[(LiR'8t!e%Lc)YtAWbfGkf`T3qFL"ul&4%o[8
,L&hDP<\gspY8THi>b"baa1W&[oB\137IMfGX'!<)Cu8ZMl"cS/Y%7:P<d;QE+[(jU@bI<iH
,]Apbb=@Ea*-3IP6Y3s+"T#\m(g+N_<qCUed'WD(jr`EKR-LNIiI"(HrCY<A[<Cdd8S8*OoIk
oe4fm)Sc?l3`")dkgstDJ1eVMG-1<_p=I`Khm$KVPY/PP)U=nPsB6PX73i8QQQY4rZLM<0>^
i^T._"LsLMfU[8,N(QOH1DYQH!5T'_)3@/]AVH)f<OXLAF2,aG2]A^d,WFZc\FucX.GS(]AcdXW
F91Q'qZm_0u8Y&W>XKiB0cS]AQ[=5m[3[mR!i)EDSbF!0T8c]Af=HBdjs[2"jLJ'STW7uN:^_a
b%S7k#o+H=IGs-?iMu_`Hfp0@$lj)qWU_rCSMY;$r)IQYM0j$a,%)n3W_,Xk=/)tcPt'LMUF
Afk/,u%c5a@$Xg`9.hP:A<LhSJKgSKWOE5d5?QUuctQd?onE]A-FE&[Fu&1o!1UC%HgA@7/-L
PCq*Z+g$5e.0uCgM#&!AcY^T?CaL6XXM*st:%*9jV:Y>sOlL(#,P`tk7m#mV(e-fXR$PeA^D
cbBIXbE-q*QcA6HWM.*L=G,<@RmlZ9``P]Acp3/&p:QbHm8Ptt/.Jf4;3t)>":.OKRli5/6*f
h@0]AhI"Fbt46'RF#Wgl8?uAh0fY2br[hOb8Pu\`&P=/C1??cfjmO8^I<nVQ_0W=ulR#23pYG
Z&q2KGDY]A*5T;keTA.l%DE.c4n()O"$_/K>[%TC=s$F&B<>CPjXeV*m9QApX;n[3bR[B\1'"
Bf9V(`Yr8"Y</6S\T=:j*YP\l'ulAQi(p2k$lq>hif'RdFkGZpJb^i?>#;%jPK8=a/ubF$@W
>!KO&@@"Fa:l:Pu/MnBSE&]A[oI<Ll=O?bsc.S1m]AdK=QaDg!cld`s8K[#7<CGWg9`ETJXg[S
UU`T:MB=j./k7]AYRk_-51b0/`PJGg<,!RY#mDu<S)$\@5_Z,]A.f<Eir/fXP$j%jWk8Eb\Nag
(;i;0,sqqrLGeE@3rhO^sW&itMZomQ,UPI9<1b`8@3U/&BTmh7I7\lEQ@*u2emX,65S"4$.p
lr=a'<Il075j/M2dsoRlhJ8Jj"$u#p'E#n/3nM[09M[I57+("T4,LECU&)),X3j+,AnbkT?d
#iH7gTdL"5P/4FV`##.W*/\Eu@rZRN>M3rh;9Ok<8(SfWJu-LYU@FD;!8$fg3)nIZpo#^`hW
q3^ta@RBI<2b>sLX?GQ80pHs)6H#D5&r5m"CNQ_^KDdMNSdZi3E6muC1VCGHl[p4mcVgNErT
=e'RfWUKEmt]A3I^Se#@Cnek&R:O]AD.8E7B7a"SaY<MX,>4%3E']Ab^#q*f\#q;#X7B%^c^`na
7W>[a2:*olZQ&qL)kAD/22e8[Bo.J#IFmmfG(\Zj,5LIFm[J[r*bH3n">VmC'#i:]A_s5;E4*
L,=2a#/9WAdcFl0HDD,JrCg??Xtq48fnm<_!?CtP!EZLLFD0mC6TUWa.TMdR"YrA6np#qF\$
(iofK=&6Jbe_-G%IT+:Ig]A<FQi;apYRs0]A"HcC7;*G@+nE5>"FLdge&Ip1Uf<^cGJ9FBEt>N
^T&-1dc+n`ECu'm/C[DA:jo>VScNe47l\GFNJ=mIPb]Ad1B88c<M5Uo%I_th<&7d>p7MNH_`i
I$fB\V26m'j^$IDT?7>n\(PsFbcKZ-`AM/(LZP"'h!Z3\@m(Vd,nCXZ+Ds8R-^^B/E,j%PMu
\^\]A^B1'$$TU"/``]Af:HC/k/-Sodcq*"V7N&^8]AMPH#dFL+O^35n?+IH&A:9S<VR=.mN3-*/
TPLt7)'PFo.b_6BO.^k+&-RkAXi$F[?uARfY6r9Rkla=EK8#>qo9t.qe%(@jRtE_fjo$cDQr
SE1Y?+V80Vi'9Z1!Y"f)8[a$<!/I&ef67gX<Cdn3V,Le%A>b*VT@*$i]AHCpNW(<.YCGCNM,1
32_85kTmS'7FN0A=cYGOW[k4LKTPbR<i9Ul&@-lVaT-F[\1?5Vp+B<Yb^>F0o>Wf]AEqO75Do
mg>pLYmKJor/NT3EAVqk'(rOA^Wrn3bmWR:\%(-M#B24k2Bt/)NTK]ALNmE'M^N]A&kIH5#ZUl
>r*Zc7nU(^An[1PWhm:r6ch<Mu("6la_[6;GabqGF.is)sU;U5&IGdp."O;oJ'OIJ7Od%V`!
o+>-D>5MA^^^eta70S/F2PnE5CWg';QH8b:@HC[,1Q0b]A3X1#=:(r"j!lb,Knf(3fSm6!O&?
SE=fel$m=D*9k`J%['H4"uiWro^521NUS4m?B`1cpS4X*Cse,/?cM4kE`XM@2pKrE=`qEck]A
>6kJ-4(c>U!*K"6+nT9<I&Oi%d+U]AhK/t]A5UH6bhl+P&574Pl&m`Cuu9c$gA>WsbX5nnrF[R
UG?meMhT/cfcJ&l[unf#j'K,A<mX&?35shS:C'&s%<l'G&%WW]A(]ABj9t!"QBBj9uob4/=jdS
Rg=/<K\V`+u1Hk#%lo+7N^R"BNaqKZqXbF0d=#P`YC'G$I50.riFD%dCn+:Bk>c8`9NijQ_S
fII/eZUsEsZQh3AG;M/`:!$Orb6=NIEiCT)4SR"7&dW4I(MhB3_AC.(iR)Q\(s.^Y_I5l*Zk
,IN)CG5PX<9B-(90Leoelt4Fia4^esK)u78[B!iMTur9;Me;S94nl.Tb&FFV/Scqj8'2bKe:
p%scf1I4[>nTd7BdVCmui-KT%D&o+BkO_7N'RY&\o6qrZ09g)33&UAL\MsD/tjHl_KU:`5,;
mbP,MlnFuGo3/(.M5\TXCilm#nRR6o:,'X.ke)22iiaOC3*,iCmIb\jTZE(j^)uqD!2/5'G;
fqmF,&-fg3`S,-gMCMijQtjtsJ8L'HVTVcCb4bn?TlX,go^'4[99cE3-D=CW^,6L@k+IAJ%u
:3pYSPGb@KpKD5ApL/a6S243Op5=\iE7(=2N)eJNc?Qqt,$4W(N9oG.Kb!OKgcj9D^-g9p.?
2I=/r8S!<<*GfRfU,L/TlI(FJJu"g?E9@lt=>U*;'lHH/OG>A9FW%jh4I!=-VooIQX\8%1Ro
0F?`T!J,W<+Qgu1)E:>L+g!G4p_GYp^gc?LWpU:,<2-kD/3[eZ"hrcoLg6]AMZ_67Z!Pqe@e;
af2nmf*&uMX"fcQ&AS(rsHQaorMWE6qZ3((YdS7'"h'2M2##:Jeh=05:@GPC(DT@`etoc_hu
dZ&<_O02S65R/1$uoBi39@quS5n:&c*F>B@D(EN\U_(DE?%E:6:VPZj#[$"(_a.l(ss<CXkY
)';1XQ^;*QDHVt1AuUrfhcHR:*/:5Ok/e7)+IE]A)#f69d)eHg(qn4(p55V:ij[Xs,!A=1rXf
U(lp.5d7@DLlJH?tTOZRu>#R]A1geQ;;fqbCpG1bGI0CO&#bSi^g94h=<_KaPgf$O#8p<9T#B
L@6-E;5MU"H1$:@DP8d6T%G'<B%Xtn@,$RoO)O&bpRn)Zd(U`JS3*f^8[0r%PI^G0%eP1.U/
"DPX$/FCbMdpdK]A,9G,b^l5ookK\/<D27P[F:@aHUZmbl&dpIU=n=(#XNPi:&js>o3Nt!/=s
R)1--pc_Vrmrge!V(lM%OPk3ee?`lKn@?Z@p>SUXPr$tP"o-"8]AZ8g_/!(7cVme5*+XOs^pa
c;r1_R(Ng(E8U''#Y?Z(/A>P-A*Z)KmUgbuOA1L=J+L?tiOp;]Ah0A#'GS&XMKA?qsSJh6r,C
9;*5GY-p[\"=OmDP*GQ.$K*8;j`i48#er/BX-WUfIDYCX*]ABDT(bEL*Pb7>30RG-=eJ#_<jb
4"l`o?\#q22@H-"KmX)scnca5<fmh>)IIqC5?Q5s,Aq#W^40!0.0]A`dJZa2-i1.XJiPW%OY8
)r]A:%nm]A=>?ThfpEa>L_BAm)4fUncB;s.:cKQA+Us^936/7fk,i/(UUS!Jc?KTj/Gj)j2:nG
]Ako\O7#?Bu0E%c8,kWdOe]A&-CKk?BU\CW"^Q>+@gh*pRKH'NQW!(ZqJo2H^\:1+*bo:gs?+,
SL6JqSsWMY;D!]AYq%j!<ae"VBU(,^VoDUS@J[2sq=-PSm[h7TM'hqTjrkXJT0\$i;2<J&fRL
g!V*=pqSnF#G1(88W@M++pC6DO^V\EsunM[Hs%>S`4IWLu<>'IOUqgboPuq7g7q,2et3?$)2
_7S(1^-FCjEqBMTH]A(Pc7S6N<q8G2E?7Ug^JL:;L%>ods07.LGf3k)Y'0kBVsabO'WU"9saW
MIQ`608(K,>^,DI2V'O6h^g)aV7+uh[,5"LljI7_j,5;.n:$/AIl#W?i"d)A!TBNN>lrgs/Z
d_rYfo`g\r,aGG('93meW/%urV_$Lk7l*B?$)2m^quY)aCfoc8N<K/oIJcBcnUq$c?&JYX8P
8.`AKkF;[5FpV8k3\h]Ar0D8*pi:[m[=S0R<`1:D@1FC&d5h+DULd7W;_ed$IRq0CI!s_Q9Z2
0l:[O6_9.$]A'CnpPI6mr%t$]A+A;CaC$]A@fT2rS;pPN)&A5@-HkLPO"MK4=@)8C&n3t&[>Cqk
g=P8B%D'T'_W!nUoZbjLGK&aDT$\QeMTDG<fFe*Tj608)7XQrdr!^X-c!Pg%%o<&7VInANZh
t*THOLX[M=53IONCJA)F\eY(i#uFR_fGsO-U1?IPV<9p)jn=@CBgkLA@860p5.tmAu*7273`
1P1pKA*h3E39?Q2#6#fpQr=44Um-^1&\nN"$_[<1I8A@8Ni>F;P9Oaf3nV,<'21UG&7`RB6[
]AEZ'PrHh:\p(<?AY8bJ!1Hd]A1qD`gXko85K!Tjh1?k,"!<k]A(MR6;qjEnk;80D5A_.k*Ydg9
1S*K\2l<]Ao<IXK%SYSY48qqMo"O]AP,PH4V>3=Z',0-2(rFEBcK"hfkR;1.LqlGk/b"?K(uMf
sr_)MuIlZgU'$e.1T-%sfN1?`3oGY,/[NL4`o^/k"l,=F4U-Ga81bAI?()59uq@Bgc4.hO@,
<J]A<m<^Q5rcH`1Qo'E73`+[KHb=#pr3Igto/'1XYZXIkU*s,1;`OXl8r"Hgl9-<G9'b7mdJA
3O`)7>?3<E<4`mH$E-[8,_lMlI8S=$,34IoP:"m.+.rk5lFgd_=OM9PSOJ2I/eZ]AV2Y!Xif_
c;&]APW_p"9ZQ%uH\#NR9BNo+9Aj2n5-7Y-cYc(FN\e4>f^/uuF5H1KAa^G'KA,'C1"i"XR3!
Pm["E4?AGmOK.70)_#!%_+?JB=@l"aoAP"UVQ!o!1G=@oRd^k/`f4;71o8j(iLJ8`m4REV$C
p>s:"7+dfo,R&Um24eWsfn;%lV(1DDGJ-=GT@gXE06ao6+cu-oD"o_'L;[=uT%D-up&jcA/N
`;bQ(`]AuaPQnnlZ'7)2OrfAACYjIASaq^\?rqql)XHc!_a[#l->U:9^b#\5UTjcU5QpQA@^H
$J[$/UI7M-I-cDr9k49[M;MhiAa^+\9!kC!(=I/Lr#,p(etGj$.198NfUmM$pLQWjmdo#;%b
n('Cq:.$]Ahn?F"tGgIHfDu6$_khH=/R4)BUbf6(%l_A,o#d:WW"6WmK44;QE;:JKbpi^`)X#
WWlNur3V9kqXiWdY1:rI7<;"W&?p7CH@$'ulc376dJc4h7q47),YHB\V\JVP]A9rF3$3p2M%'
Z*@VG3HUR*(7FimP'QIgq+IrVg-PPPGp[uX1^8"-IP?SD(%H:`1D&EeZ]A=o_#r.XUt,ZsGY*
uo7G$<LplVj#5S*a\-;oUf)Np]A0rmU#/c[!g4<0O4Cg/$d%+Di,uM9f#t"t@f',>+aFH2'P0
<fq0GraHQXVa6BdYZ.]A#l0NHfMBN_rbVJd%Q^I=.@A0R/f9XHS4+<uKN0m)V'9%t[MIV;E6'
nB5LGNtK07%KS,bW3h[G^q%epfGE>K@StgFZI/<N%[N(9A4%MG5WSoU:B^4O2ptUX945OSOJ
D$toaC!J>VDfYO_Y.jd<D9ghWoQ4)W>1RDH)#OXPLeW*!2@@o;Dp8Bof3X*aL^^G.4kD/1<5
.3bL8e$Q3;Z1S4YULr5"u6+1Ya%A.!Pkt-q3kllH_YT0($Zc`#-4Jml*jqt?B,Bc9rG'nK^'
Z#e\X;FC$DQ0>:k"(JX06hWh/O`]A(Kfu:rjX#kIf22L0elZC47@Q2T=[LRuhe$G9R>SNNX;j
n6(#j4'I69`UU4^4DAi@.1ESbV%kpam%'#+,t36R*/YEkg(O"m]ABUDRcR!Ih0mo[n`"+e`VT
:se_S3PjWjgsn%IP/`i:kB#Xl@l;Y9:%ZVCMS$#<%?rWV-A&_2%nfRW(/<n(MQrrXg*d:Q0,
'#"Z70,7TFN$n+[,T9f$O,'"^hkU7=h!'btmW"7UC)efN2&o2W!R"dAs;OP$it4>OX,^P4^R
_oMn,R6gup-NdARU4>k+``8#/m+^s9K/!%@BMGo$"dk.IN(R?]AQ'C=g@hn!9h%s`TST()qCq
>2JRDK4&V0pGkY/H2rbAGWa9?MRUH@I.ILrCL#<UL=,5dC9H17r1!<>8YsKl)47t)45m*-rU
=SHZMK.[2i+;]ABli6'E.F8o0"kJ1G<QZi4t77`C%['/KXHPYaWNWKd/eTgmD1Y&EGe@j!`R0
W9F#l73b"QQ5-\WY;BkSLlZoECO>qca8^V,a&b:!Y?K1S4-f6ZJbWeg4T(QkohYMBNct^,kg
RbW,O1]A3HioQ?8pO]AF_E9tN^Gc,_>i4!rOAgja!H,M5Y4)c!e:@Tf<4p(cR5G>,/7/HU.Mt?
,&b89H;=LOZXD:!g7(KJ/dN)L7\9)Oqnc6u&b.KNoq%#.m3R/9dKT4n7p"Elt#1-e(c\D%"P
QLT@'l#INq'3+!kf-WK7+?I%!s=Ll-CNGt8^AVS/hTV2pF20`rpbC7+0GL=\>Kn(0dMMMaJC
+\N8D%7;95*[4b'kkq^^@2(a_)n@_mW^9i^pWTnM#W9S1qUMV+TbCCP_91$Y*T%:3Vqat+*W
]A,Mf9^#e4N+0,\HFlX`C"$6]Aoa)el6g+'(Nh'eH:bPH`jl$V)oE;7Q7Rb#!&bY]AVp61TQcc8
?3'mFtf@jql7`<(/M(9i,@dh;aDdVL[j0CDp#9ksZ?=_Ho#*4ik<"QtHP%@gm94%+!_0B7_e
H+7fl)?a7SHI@[_>$*i3EMhag9*>Pa[bsHN$qXo&Q$@T[,TJ0$Z2s3fKFhgfjC:]A<YW[*8KI
l=g:.<MXt)FN!RZ<fT4Ui=`>e1(D<8&8em_t*1GobpZ4"&:?!oCbf7!p:<fPW!K.W&J*Ke`F
G(MQqk<8CrM46$'hmF[R,Z"S4c-O]Ak'd+KjbaFhUL+MOnh=r>hhYc\Q3_"XLRnLsi87[f/hb
i'>hrUDO%kYfCJ119EC[WVpR5+n%A(6e%[W#0d=(cqPPqNe.O7m&sX4gfa&>i+UYGbh#q`K+
%HII#l1Kk#mS.6^3HQ^3^WU_j,#)OmuSg"]AW'628q;F_1p>>K7l:>&ig;Ya,i05X@JDlGF:.
`:iHUErPC=8TAJNBX9\DSpV#1\pI<\!cpS,L#Lc9fi2!H%9nP-?)&^()q1$rZ@o=^!n<Bp)B
Rl,n:VWe'8Z]A1UWdaN37tROapuG^gDZs\k1;eMn?MA2eif6=G`&#ohK8fHgiYAi7PI&1$XCb
8a<mV"2D")R_Y/Orn"VYbIlZ*\j-M;#i>6H4`9*GU_U;[iP++?c?k[-oa!B%*:_dM+P-@]A"N
j@eCejY'Z@U_%Lb"1iG<;cSZ92MUQtJoAiP2%eh9m_DtuPn'&,gXAmmm[]AkD5p<'IF>:TMo"
tT+UK!bts5f\:^9teZF%guPEq6u?AO3\mSK\Ao6S2OSp@)RiiI3)/!AuPT2I;Nb7M,XL.(3X
of/+$G0;Fqk1Z1IZ1i/"ag>X'Gbt$8]AC8RnN\aEB&Ie".V'!VlR6=]AkX(l\1?oDu/\q4lV`1
Q0oR)e1bR=H2sV)G0,A#)j`X2;aZ?;,Q,ohRE$Mo.t\X0HE92To`2E7(_24n*5Dn203-rl]AR
=o>Xhrh?,3aN&\UkGT-tf#mOpum8q'78dMS&BJ)PB>f2198FZ;o8o?KUVkU_Q]A!80,jkt?kc
qRBBC<"]AbVFIWEWM/JNTL&t/A#l``&A@bs%>>FSn)a!%5G/W>UE5]ASVL*-L.n</N06A6N3Wa
mQmNVO:B6[i;s^cF.;3#mh!KYh<C?k,^thQE#=4rue2pC)-g.>@=(`,!!p$cdNVbEo;VX*2n
fTDf?~
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
<WidgetID widgetID="18a8add0-fea6-48b1-9b76-7a3e90961fc8"/>
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
<HR/>
<FR/>
<HC/>
<FC/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[723900,723900,1249680,1280160,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" rs="2" s="0">
<O>
<![CDATA[年度]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" rs="2" s="0">
<O>
<![CDATA[分类航季]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" rs="2" s="0">
<O>
<![CDATA[分类]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" rs="2" s="0">
<O>
<![CDATA[总数]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" rs="2" s="0">
<O>
<![CDATA[一致]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" cs="3" s="1">
<O>
<![CDATA[早于局批(min)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="0" cs="4" s="1">
<O>
<![CDATA[晚于局批(min)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="0" rs="2" s="0">
<O>
<![CDATA[前后三十分钟百分比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="1" s="2">
<O>
<![CDATA[＜15]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="1" s="2">
<O>
<![CDATA[16-30]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="1" s="2">
<O>
<![CDATA[＞30]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="1" s="2">
<O>
<![CDATA[＜15]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="1" s="2">
<O>
<![CDATA[16-30]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="1" s="2">
<O>
<![CDATA[31-90]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="1" s="2">
<O>
<![CDATA[＞90]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" rs="2" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="nd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="1" r="2" rs="2" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="hj"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="2" s="4">
<O>
<![CDATA[工作日]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日总和"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日完全一致数"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日公司早于局批15分钟内"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日公司早于局批16至30分钟"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="7" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日公司早于局批30分钟以上"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日公司晚于局批15分钟以内"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日公司晚于局批16至30分钟"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="10" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日公司晚于局批31至90分钟"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日公司晚于局批91分钟以上"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="12" r="2" s="5">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="工作日前后30分钟百分比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="3" s="3">
<O>
<![CDATA[总体]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体总和"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体完全一致数"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体公司早于局批15分钟内"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体公司早于局批16至30分钟"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="7" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体公司早于局批30分钟以上"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体公司晚于局批15分钟以内"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体公司晚于局批16至30分钟"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="10" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体公司晚于局批31至90分钟"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="11" r="3" s="3">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体公司晚于局批91分钟以上"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="12" r="3" s="6">
<O t="DSColumn">
<Attributes dsName="正班-时刻匹配率" columnName="总体前后30分钟百分比"/>
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
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border>
<Top style="1" color="-1"/>
<Bottom color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border>
<Top color="-1"/>
<Bottom style="1" color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border>
<Top color="-1"/>
<Bottom style="1" color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border>
<Top color="-1"/>
<Bottom color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border>
<Top color="-1"/>
<Bottom color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border>
<Top color="-1"/>
<Bottom style="1" color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m99s'PNDf4SEcJePff5Jb;)L404^M*0&%g1'N.\n9`hcIK^cjs!H[UN.ZFdHM3EW%Q78Q&TV
0NF/h+Z-aJP]A+DX8)sGepWoGhL)]AGPMc^F;*O05BT"um,REPch%.mkP79eoDAL#^[LW:r:8a
g,/ukC_NU$Co#USPMr0J=jH7L]A*dQhoV,.$,e["I]A0ARk6AA,\;c.Ck/bjB-gHrWe`ppTd`c
T6:B4W?H%16&0[#s4`.Nc;<'hd:F?I6*(bT2qsRr@Vdc-@,?kh2s?Qj4SThs0i4o-;mL\n'.
B2Fl*k,pBN`.X&A$hcOfW*B7U@ZqPT&#]A/@unjs"F[cga;(-l61'i"o/pkj/duf#CYXgiWGc
+KS*nd:nb'QoM8e;M0/!cI2R]AkOZMq5C_s.0#_WVSfSR^3VV'4qMbmHnm+,$G(]A7TZ1>Q_m!
gA(B8ure"3R`Ia43S*1U`u$io<fbMmY4gk!P9GGQ]A:sl*TF6`7#H,:[c$.hHt5FA%V6Y0-14
^-osuVP(.R3Fc5"S;)u0\R*UH;/@5(=7`e7p8dZgbS0DmG*Q,Qr'?4Z=hb+cLFjsB1P(oDK%
U:CE!g)%;=*t7<ks_jB2H6Lh4V-%-@>"S4Rfh5Gea:(r\]AT5c61^JY.Q/O"X'+loD#M(8We8
bKY!p%2;f`)_MV;ZYK^i;f!]Aog#(JSX/:Q]AQ0D`<A-MU4Vf.1@4`m#tWh>)omgpbrWlVs+&E
2:i@V#af'pSmoD*=HWo^-@IA.maQub@B'#ZYuKWf-KqBR8H_SThgXGYFcT'G$8T=+'Yn-j@'
<EA4OblT5+4*i*b-:)X#=)2b,B)?XdnKciHcGiVGW0?4@sUeCO4f4aD7q^g)3;hgl%*F.#q,
%e'olKh1gJ)DW"MY"6FmPMEbR7=a_$VQJ47JPbuV!phR-snoHP!X(*@`BXCsLUt<*&G]A<`02
)^omL#aJu7_>^pnXK>^G^Y-A_@QJ!E_E>J\8"t_P$9uGj`8OJHF2JdZbFeRC.S%7(aYJL-g%
N[WIh[kQHMW/*phHj9;ATOWj*<kLE0.Ip)eL>0/RPP,%2*u`-,56lP]AnkiY"O"83J,fOT]AQ'
>Lc)q)]A0l2[7/4ZSKXha]AX+T.G4lkQ;PVF^"rI0FlVfE>P!k?X&b"p.pC]AcdfXT#s,7RYI09
3A+Yu.eO'3iFYn$WYWK>A]AYnHPtS.+#BuEKYk#i0l@8AHdjK(Tgbu%Hle0C-Das?Fi-[JOh0
>>M=dW]A$@Tr"k]AR9&[gtL8bji`"ul>s_d#E9niZQ;bp`CiN@a,+Z#X3VkSMgQb(db=,'('GJ
jFRe7Ss_i\aklZK4b%b3YESh\(Q+"mPNOfcH?]AQdA[WS4u<9M)&pAU3I<&q02c$?GtRVRZ[N
j^bRN>c0<mYG99rX8-?A;EGs3nEia*IJlG"K6.CIL(:<\8[i*fpLWTu:.G5VA(mZR2.-=[XK
ku<7:B=:3=Kg.[aQ1_rl1-c#l.Kr,Rf"uDf.jb.A"VZJROC1"M(=a$;m8b`u@3mg7Os.ifbk
'/3j"&#Tq*`CVo(9j]AF9Vi2<oBp@%-SicrT6F>'!m@pOPGZBZ?[Sode$<(I$Mo3$cHMEN<GA
"irL)&Z5!4u*@4_D3&#lQUKDFPkFe$2bi(Y()&4On3Z>ER7'LB0^r`IF*?ha%SO(1jF]AXB0]A
mSTP"[SaJ)&1MhcY>QH6-[A@S^Q!t1/*eHVck`qU+KtTQbn%&"NlpA#1W&h,"sENAiNs:Jtl
)=J<sbj1ENJiq_G9<+d?^>cF,<TX0C:c6H5A1+6bRanA^t!JJ?q;=hW#egb(2*6OfkeB>oSL
oFcp7=0lbpN'\OSZW\<?K]Ahk,@NT*]A>;qVu"atbZ^4IAok)2.N?<\.[IU_Q]A.X(_[5pUjKd)
2[HTAp`)2#1s_POT&[ZOqG;BdG2S%/K-(iTKib(J`"\jBeoQR$11]A2?ui0$m2&W(j9ASajWD
WbsC"Q.Q5QH,Zr?MOKurOCn#T*VRNm1(:1"#^/[8kC%\l]AO2eo^/?rC:Cf(b-FF-1g@sF:gB
^5#>R+5!8C23I+k-W9Z[YB,SgWU&IS7dZgS$;9Z(^m@q1l@4!ab<_JP02^uEjZ,h9^:soiis
-Y#j;FA<MDK^$I'1XGO^"d-`HU'hTI4'YFY;'Lu3X$M0M?F/U$[]AO`I)kL5Ot:j!#@hnd]AZ\
D.(.O[h`@U<h]ADD;%ZJl1f;`13<LtEgXRto(L]AEKl(cSj:4K1rX@^)7]ApWf$;D^Q((M`brGj
uXRG\[C/fB=W)g#K@'2=/Zs+boD\ET/1#@.'-Y`A'D,g(d([(EQ5drRdIA(fWgI6W-L$SQH#
;St@-OW\+G;+ZaM/'ZsTNZ]AiOkQb20OR6]A`o)Y.IF]A)<9bUf.71khJF1iWRY_7Wd,mYe!90Z
"uT7><:@HX0JMD:-1(Yf3L'fFhpkEbgqtrlIIm3(XN:HL#<.ZZ^#eG3ioNt7Xi"lP(aN15CK
[=(FF6Q?*@ZtPWbFG-_d4T1pEN^CmEP_`ipspSdmhu!^i\QTW[BdX4Y;_k"*fP)Z6#.p4;7t
e*>5:9.-#c]ACk:H(EDa,_0Pqb_5eZ13<Q+S:X,^f]A!9ta1bF;cR&]A!o6s$W\e`e(*+S,/J;`
l$K,NA((7mr,YF)c^T1YtYI[@U[/lg?5laVN]A.L*0D=i:BOK]A)EiJ1>b#m!5EQ7DJ\%EVouE
O64,2+XR@TtY\,bkG?:rcWDW/RPRZ<PB)<>.-9/(pe/5DNX0?]AS+!1lj"n\*bHdnPc57^>2?
LI```Fm4Kg/ZQbTA>ce"2ol_BtZ^-0NUA\N<r--]AHhn0q/Vk^#.T*.:A5H<bslJ\9#&(s`0q
uZ<259Tj-)/gA\HoG]AgAq\03=%Ic1Xe6E6?mg"#/e]AS_8c2mlMbFG^G_u+MN-`PI\QD@_pRN
;S$WX[CcaR:XnBf?G78R$r*[1CPpb.^gC'=gNmHB85f86_-esM-FpRbL<0F)HEVk^?Aao"o6
(aKX`i#l\9Ar:]AiaSjdKLU?9;U:1q%P,MHGd#kIXXaP1Z:RRN,:F.Y(h;m2l!S:H_9#pkYKS
U_=j'u)R<*ED.0Q6a3S_[XoS=(/S"TSMf2'g']A:Xbfq0e[Tq&DD^o"d")8bbdic;$n-A*@*V
`rpHdd:cmSLG[a4t5BN6A_pRo6H&N(_!+pYkJSsW&e?A2ff&"N8ubRq']A>$!n4<1'Lts>Ck?
8>_Kdr5POk#+(rO0[(0,`[NgWriL.YO2HUHM%rY&,SF>RCgfJ7hQHLthSoTN$2qV-0r-5:ka
@<5:!b?5MWKP_%BaPAhNod[!6_u7CaEZE=\m>;PNR!6;$%]A+FZbf22uQJLbCP-2P6?>?uZok
i#,er"HO6ee7T&TN+5rIdk?#WE82<W#?F_o*K.n@Q2Ii(@*/A@6h"&`r$_6Z%s=I'_a]A4MBD
dKPh:+H,i@2*A<df^"0QAXoM7cDo&&l<hmo8oict!i&9CLBU#a2AmYrAD'R<>n4l6g;uJ.n3
BD0"ZDWkUf(,,2:EEmITkqp5@t@S1/.46nF/=/C;C+i:6Y-,1.pjc$IaqcH`O7@of<SGMq&/
Jh@cL0SNQl?A7<p<il\o1#m!XfR*;Q1/n!@8!+,i`@$K]AZV,UN8U`/OV)*bj1`k]A9@F36i@a
.B#6k)7g<0*!Kl6^9UVqMMc\EA\_e`0djGbG>j?0T#4=\R5_!rFp[%6MW[+iTfQ;Nh/aNo+'
SoT?p5?DY]Au`lT:G89@ITdDZ-4Q+,!El(6_iMa7<P0?b,)g*8GHMth_WoO)*(<Y+pCH(2n^V
8gd*Xr>;kjZbPZ$hWqr!(h4Pf-RgQ8:E%OS75G`-%0-DFdQ\sZ<a-:a1",8<9<eS9&$S1QTa
>[g5"iXXhK25+S/p/-9BSRVq%4`2bi8[rK'eM>=Q?B$"#pfcHdMUS,3>@/^a0_<\S)a"/kmG
;>FSe[Y#ZbDq(Y"T#\C?6*Wl1O,1n=>30mQHbW`TXJ"W%;a/!@\U?F=sl%"!Y:c_pk;!J!rr
ei(".mpqm!V%+=X`:e8O6=-/Kq>"m.=3*gOr<T,acC02g=g^jMC:r&CD.ba";lG@mGXD=QCR
^[".idf01LhY:=D_1?e%p<grgjaASU>-X&/L(u$[+;MUc/^L-.$@2,ehlW]A/4H6ZJg/)8$T2
$\bMD=FIp1Z<>h\WpK*,?[u2Ym,b"'N,6,i+j_rc#kpbe#RmG"`1(lpmWX/fEM&'mq22WCiM
mE7TMD@g*kWDoH.CI[rG?a(i#gsNW\+@>^i![$?j*Q@;=)Z8Pb8#_rP\m\=Og7IFlDXm+ZA;
!1eHTn*=-;_YL?#_hk?f%?g^0/i6:UhGbn;4BlrpaJEtpb'7$DoZIsAZ1Ziq$"1SnTd[FXFg
%?FuTCEb52OKVDTC=#*R2f,^_K''j6ZfmgcF7LTdBVQ3(;8b;:mgQ!d38g3hJ<_eL('Ff<VV
G(?&Tm0OgEU%_KDPmp-;U-(9B[C82/^*'Fc92lN)$nU>[ibNI^.e8/(Zc$&&;4'Q$kT\Md;l
_3qb=R2+m"^V86e;pII&6d,,`kibTgq^q>bg7;CcpncgHq0PS"SC1Z3+Z,,U`3P+.j$jMahC
cUc&$n43#29.&ApNOYi(JYE1K:\-e.Ia[=q]Ae/Y6^;PX*lOQj>k*A;a#n=::".=$+qdhY1@&
A7N)*^:S`*tPhprHA3USSt]A.ng)\Sl]A+$3(\t?bQ,`jnA*BXI?Mja]At<(Zn?oR@$r%e`'-H6
U?8oT%\#IV`^)?D-ef'gGWt(/%(#`]AKfi;[gcNue/l=r<lhQ`SJb#<(lGo.a(O`=h%']A;ko;
Eg_BN,0?)dqX;<B5.qCGp#$@#?o&f0*4XEF;AN5GdD^$=a(J=%QA-?eDq?)gdKTgTqtI/?tu
uS#&3)Af7f%SrgnR&""\T95L(`X'%U?07)`3_\pGI3S=)[<2V0;o=GG``5V&I8[h<3.Q..Pq
rQ,+]Ag2ct;[&s`TniE1M"7#lNuqFE8-bhuE&g.hmm\a.MsV)n4S1?Fq!l`.=nA"K@+GN+p7l
LH_cakZUTl1NCTI6_jF@o54"nZ3goN78P=gX+/AP0\Y4."q^17]AmLfS)PYsSaoj$378kZlLk
OSZH!,Ke33b`*8%$uMYZ0<W7/NMnlhZ,J3jXiFNq"XVFl9cGi<^UCOe+M@[C,`qlXr@F+igW
^@[hfT9$29tp5p)`.I'1m^V__1b3,s/h_:e.:_W4DgOh6rW]APeXM^X.sfB.C"\)pP6uFO,Nk
q1Ck\f>ZV$O)dp<NV1,A_8,@tA&u1YY[k@>La*!HPY$<Fd,@$oU,%t!2-/@u>hZ4=cTI-<^X
`W.d)*rqiA!@X6W1:_'8lq4Z(`!92+\_3r_MgHi127]AgP='mDCVJ9\L7R*G,/1JDjV3\#P?P
?-3Yr-^!4VD*_qTUUmFgln=(=P@.7&N$^FOo()0L\FBMO.D`QFt(GLVoN*)fOfP+B+H&uiIf
<<O"J9Y+3G>[1:iYmG<M+McQB+u"@ZPXA1l(\Jf\ATN+Jlo+)jj!4'NG5NT^-8cgM!&!#"LX
pG[h5\]ANpZubLqL#Ykis'IJ.),Wu33\(8:cKI>MW7/CO_DiC5=(K(Pu(Z5$EiG/1m+j-Gua9
dH3Mc=9julE]AfR4tUCiPeIL;W:XR8ah@bP0[;h1<Hj'Gu(q%B>AWeeMV@6WH$!!),g7*$+\p
LpdRZ-C3_+k]A\GM+BBkaX1TT9d/8>$i-_oV"Mh>[:`WV&?dU,l^A#t#X0cBX)=H47AHb[GJ5
VpH[03-&SYhG-Yok)7'T:5_4]A#"(0nm>4?]A>,3FoWgK>Bh;EGD',@.`bb`[TL`R*I@9I6bHD
gA",q.5)JK5MZe?J;>W,Nhm[Lao6m\01(lb;2@$(e9d]ArpQooPpf^eGb9&ZZD$hdd]A`O$`hl
>[1rm%cO2'CP*eZ;s)oQCNZPtk5Lr0SE_:opL>?q"f/f(PGk()C90)e>H\B!K`Gp@DI)*/RY
tPqsP(B:V..;I"XlZHnJXdrnmYfMh>TCec4>B3Kq@/m.=AHhE`e^\KVlI.2E,ju\>?-%+%C0
,rP/=<u2-BN%!Y2.^4c@grCs%WkcL1XruW]Ac$ep9/'d?@6<j[$Uo+c<W,?`%<SJW+URTjJ2d
0iCrE]AEjAr>MgXmj1AaB4G82&[BjG:Qa/DsT]AUtb6=Ib4\pZX-30P-OR'CrsCBU;HfaJrGsF
JHW&#gLB-#/$Gqq?GVqgiJ[jIhA`[M@h]AbFW%*;W)JIZ.Bg["p1E(RaX$a%f*Nk(\93dm0H6
Ei/?B4\1Z%p<W]A(N=@Nc`[oEN+nkP_"3Bh_fPf<t2ZdWfNek^)#1%XQY/7i=;'V*\Q"N`\!%
1V;-u`.@G%NB@&iq/2-'C<j_]A=D0B0Y&-^n!F"R\Y)p4dP>5nLbMbufYDN+mapG[(""#3Je@
'pV.k355hC/X.cB85A+jb]ASB6'=KpbF;Ae1)WS_LkN%5H*+jS[`+_VU2)W(7A`Y+@ZW[4CZ3
ilI@T,9O6*`U<V5pSn5'M09\(cPRk*Pbgfu!k?J:#.B+&k6kuO)OZ^dOW?B5WJ9M$9^OUu!7
lnW-erpl<;/CZFe&O^M#1<]A*4`i<V#k(@(4IU8r!&h2R.2io6&p?-f?D$C1#Q!8))cQ-5?(+
K0FrR&Q1o65a(o;$Q1a4O553#S"PgA*-n"b$r*9GG$2cG^'2iic.ER@l;)1\-m/B;k]A]AWToP
$$=c^@#--FX(<5u0MDc5<LL<:-g#!"SH2nApiD'8TR;:"j!Oq8V79B:Qa^Tb(5qAJ[g)"]AYT
dQsG.LrEN88(`2h'KXt%$=rqe'L,HI/N!TeIB+q=.JV$j;O"3($-Xq:9l;,RBWk;YADgHMH=
(.[M3M")MX%gHDUS;Oe1W+/RND$W&_"mMe@Q<_@CFp2IQmS1%<bYG^hR7rk*lOedkJfN%7bg
q=`#YWTQg:Q5XEXMshgn2,0O.1a`S?I!KT&(,]AraV"49]Ahtdaeeg)<%B)*RZdJ@]A7<+"h:aT
j*QfIsS,a/fig@F14*L75kibQF3@k<`"t2iR]A3U;)5m<Qj!Qj5_*d8O-hp4m+p>8+qq'/93G
'_06NR+6k_<(2HEKB:qS3"hX.u#/_kX11,<`&8Vpu=,/,.hD*2$UPO'V,UnAb#<V[H"qb!7I
A\aWD/S:eU-"7>9%JPn<3><XDTIK><%c-J=g'FWOB]Ag:'bt=8M7*`\q=[1JiR/^:oUp(B^e-
0rLB3Ks&d36Mkgad%\"8J!S1qI^&#_hnlp2J,Yd4+U]A#2jc]A-UGCSWfF&jjAKU"4I`>lcqa1
$g+Wk1bnkfc5p0LFg]AS9b>WGeec-kB:uKe$AZ)G@c*!#s9@?4IqY_+mAks"e90I>N^#1;XPT
;t_^2tPG))[-J,E]AUqkfC?U>GgPI.C[seWaMm;c]AXiqMJQ2>QKT8"BD"LT<cuDCYT]A[Ud183
%.)=M6:9Z\+j=;H2Q<kebKSpOcT*jAS@#b(=Ie&L#Ja"'3M.>nTh2'c2\bo\$r^=(odIL!n#
3WUZ^-u&o':H[tb(2]AY7'A!VFi.q5e:botR6Q,uK*(n[IbTdgU;0gg.Y#9DmOpU>C_/DnEq=
<E?Q58UTSu&O)qNHr',qYIJt=L)2_qCf[dX='Zi/$l`VYP#CR566#:l8Gf#(K?(.*<)k'Z5c
Z-W-5j+gi_g1kbYA9b)?>Gp<J)/[QLoLu5l$h('0UKst_cg_,'I^.e5L7Q:e;^M<#49!<'&?
O+!obE5c+t?e11MCS8)"g@[AG/uC"E3HdagfF&chu4->n'D-88+:u*[@5CcK0m81qrUt=f6]A
7Io+O3:FoZhZO*Af\njP"JP/dA-G/FQEeS-C9c:8Ds$4EQ83@Z-H\)OtACO+>AKEn#blb(G?
;W_/ie60dDlNSNX`$Fb[6YE6f%GofE'P%k$&`f3=p[<h'uchiDf?2ZSD?)-\^P0^E4rp01lA
Oq:4%I+a9`Ot/IX\_Enk=?gZVb;JOos'Re-@HPN5(9deOGCY&(%UC7I2$0>ql\QqW:T$"oBg
^`KPqg#JcF>*uNk+b<8d+.CXBE"3"!Qo5,3k)_Y$CFYli3]A"Y[pV7nZ#Ftq>csX1->O6*b`$
hm35a9t0itI^/q*[3IrT%8Q]ATM0O$Xfd]A=pC,YkBLCePq0,%-"?1tXg<%[q:/1-$CpMH3V8p
4mVB_Bg-%RX(>u`SKX^Ua*7+4hmL>RNNjFdfO0aPb5P2L944N1+;fE>5rW7nV3,8T$cShdY^
Z=:^K9RnT`XMBg[DR^U<K_^fQa2SI92l&AG60(cG.9g!)E<A5>9D=p/f=8Ghb,;Pl>Q(UqoB
lX$DQTBIqsar3cUdA+F%ko6d^<l)+fSKU*R(CcLFQ-Ih2\\O@@:)B$Bf*Hg\tuSZd<(Fu3me
pRlR(:/5]AOC4Gk,UmZ>^<b@si)V.i/@Jd-7!;a`V8HaO#iU*;E&RRXkDS!J`E>L(mqsp]A0?U
Ud.lY\S."DadbY:n*ZTf!S_!.I9O9pSm\iiW#W+o3Ef7F6FQ]A]AfPWFiJ_iC<A6M/Vsk^^W-_
cYK"1jEeG%H]A&K%1UpDS@f:AcI+,O:1UH1<=C?`jE@?\Yl%7>9]A@Iiu_L?'M`3m>bj(`I+>L
)Pg7l&;\HmF'p`LsAKXNFA%>3t4oFJZ^E;=kNT1E%<ruE/4:MgeYA^R(ho^U,'CT'=e.o0pb
Fno'Be_k@05d`>tr0o5^OeHV-P,Bh5++V!pm0N&WP-0BW]A)f[qq0-iVkinqXFX>@/ri)b(t/
-X:t8osT/=GQ1jFM3KS1H+E)Hle6PAD0V6'XpkhH\+lRG0uu&DUSA._h!*\LW?X&T:Uj#NJ#
fO=)t(_L=\g3NA4DW[F=P$*=n6=OV-6&bO"`?$Y?QL)A9/WF?Fk&s8YUbcONmG:=_VZh>2D-
TB_.#3iSQm,`a*Bf(mFlM'5a4?OSV&Kn/ij7X@Ec76O.!YdTZB!!Qe*1lVTFcjP59^_l&gg)
Mn(UG`?+$N.^KS^W0Z2`9.m$:VVp8j,^sQa@\j1D>d2UCLGnTgOJ9"M=\n3%W(nLPe^*"$"i
'!Gr"BN6VG)W>8Cr#fs9KX4e_S=OlH9Y5E">h7<UA+\,P!^JshOm09<k?q!D`u2O]As1Lo7c2
1;L$!m.`&1_OGG>A]AQhhLc_Qa@>G?6g'+c^2WmA:rt0H[)>:/lrYu3HoT$9t3Ea!sb?)1c8e
u[PR$(<j)Khs)mR/+<-R,mj6*[+hK^;U8QBr&#TjiqW`=;R:%otR6ru#8QSk]AGqg&rg_l]A>B
XNiVdH%14D2P!nHhc/=?.?hf`gSPP4E;m;>?---p4H97=]A7!'MMK,jM<eZlL6:dZ5BGJHg@(
=2bsXPsZ9JD'Gdh@"3]A:bjDOn^+(RG;&f33M.nuJ`tU5ds1Ge6=c0lG"]A*KWC[Egp6#b2jiI
<?_>ak6bVIm2o9!UJ#_SHJkDqb)G?I=?n%&R2^`j';TkgN-0-M.TZO%Z>Q]AX@?p7qQd2`tP@
\QC-R6KJd*bN0ooo'k"2l6n)"c/O2=/<5fmX@5c9aLp\:n_ck$YQ!9q`Y5WSh?Y+`eGJ*k7q
\:_o^'PS@8FT*.;_:iCJ;RJB8<6n\VI#S:\M9kV=jGni=ekH$eDDD8VFaHXN<"B@m^]AG4SBa
]A.g1e.Y#sEgcLq>P]Ag1[=<ikC,i)F$#%I#RPAhO(89Te6@:h4^mVI^&*L_Iul3f6Y,f^ohnM
C(*3+]A:8a=D<+X&j-!@cYRVHqt!MNVmp`s!,LoO>EFWK[Ee=N/(&6%3#1T:JrTlm"&9j,h2G
5UMMdb2Tc$QFPt\^WYT0['<YX>k-r@"rE(O%;1*>-f<u7G[eao`XH"]A,De?f(I"i6\`!NZ:9
0H0UIKT^B*&eCYV'>_/`LiJRJ?[H1m%gQM=Sk="!FYcK&'QPg_7g[Tl#X*td.?:r+OCf8.U`
F)hT11e_fp,cN]A<VApYV`h)&&6*:F6=:PA^63Tr/sN5HfA&EgAZebY7F9sW\Y%%bS7Mo^%_J
]A*7_6rht7erWe7C+ENUCe8F=LYn<E+8maSgLW;)ir7]AAIlEB%u1PUq=FnU8A#KN$U9.+r?l(
`>)m495:tF)!OVMfn*T#D615J*N)7alrK/nC?TNFnF'".Hn`8_P1o!\'=c-?k'CS5XH_C9Os
b/JE>t+PQ%JFSg=%%X'&sl/rc<DjUV0;6LGM]Aj6Y.$.4R9D;]AdqWMa;P7;k2mGYaU[8:lKk0
4-="YTr(?#/f$**:2#\IhAW`t+XuE1\dtMJX?dOM&i]AYs-#O\MN>XiRg*(#err!dH171hD+5
`9)f>BY?7&)eThtp,(^O"'p4n(bmm+s1.?_:J)-Tf7WrGC?#Za[Y%@\H[Q$MKRu_9_6'$b_,
odo&5+(PWjnhZ,YK10hcW#hetp\,T-@ocC%4<D>48hQ-Uq:HS?.i3<Yj]Aoc%TX%!fhI&C%YY
j6LMbnC#(AB?'pC9,rG&'EoWW`Q`44(['rK@<MOOG+5BqK)K+Xn&";XC5JJ)TENgpj!;J3]AM
)!E(Hen)oKBb9:;?:_%,9Vm->/3apo>+[S%?/!@qs%r-LYq9E*K?G0QgF1#arqJ#E%?5Q1^o
_]AmV[HpWgH:S&T,SM]AnV*Waps<fYXHfc/c`L1ig`b/_hALNg7:O:C*PLrQ;(B0sC07esQ?jH
$BO!4/F`g0l<NCSq=5XYif8na<T#h]AaWaUI?F?<?On+//_@-;+.[NLVro^7"B!XET#*"mlOR
HJl;/97#bQg^eiKdXZchN6,lQ\>,RVbCIERfRo]Am;?dR"!;h'3t#5R9?]Abam+9)3!#="40,8
c%.qCp+K+ScXFO01'jC6)ZQL0o<`cBb$olh1uLU[CLe2ADc5krsDe<2="ZdcaaADOdp[bB1<
j?,$9N.^l1sqYU)_IQKp)>J5uDHQ3fVeGihMPmcVsceWr5s*4"D?!WEdCGDAX*2mNs7E-8[l
#U<Q-lrb=kh]AcT@Og1o2*AO6-oVr[/3QmD-@+1daLW$5_1H]Ak:4DLJlLUc;N(9XffN0NVO@&
naYYNeIP:d-[`r/acHTq9jr;\2-5GLl7K$QcHG6Cn9dZFi-MM002Z.`lU@Q=qY,ntf3%qLA(
4)pOP38n@?4SB2%@aDeprT'e1!9QlM]AauI`D,S\$rK:Ge:<m^\`A._SW>%Cd&DZr*Bc,lN4l
rY'H3OrH@Mj6]AO+okSTLnA8>c&c%nhdCn`W80gM=[YOAm'd1$HG7+cfd63^AUb.EKM5QS7\e
J&f<H=XF/QqGT8]A_0Xntr0l"3/q`!ucb,_?XiRg-=fE1T<A3pE\u(AVDRT`/h>3T8.rWcT>@
BY6<Fc,+IoZ*`3=05tG*M9HV"hI[iTZ"R/jJSZTt]A.r>CcPlJXT6h@13P[:l,6RS>ULp&C4.
([]ALj$d3B@G;bWZ[Z9F.!,OAKJoa=[VF*^j?t8fuX1tQ+gjeA2Q,Q)CtYI8,:V@M*HP<Wa#D
CjZQ2sfSX$C"Wh2NF;gE'1)BR)g2--D#F^@i2gpE'R?`@?[EfQ"54YYVMmnNOLglcg>;_[;F
X%RMAYhBO&OH@=YnfSuGP49)K4[a9q0P=7=SUL`)WV'FjY2(Y^00i(27[iuO*XFeFWCi-$kP
?-(g&,+qYEf(7-%k2]Airfi%?n1%Om-hhBi$JVk"IV;9,U0QAu(%V@"N#G&WJ;"T:LZiS!r#j
XhUH&r]A*Rd@QNl&J.e,(I!>S'+'frY(\&?\"m5XW&c'Ri&N&FcO_en!/Q'$dZ5FC8Ch&M)Wk
I,?,J.XD42!]A>E>Nc^*,uU+s'NI&W+ttG]A4L=*Y2;jt[7o4]AEU1[TegQr%7lf!G8,@c]A=WHQ
D2dg>oO7$J<`5tP3+EYrT'KKu`)h]AO\)^DdQ8&c25YMV-K7okM`Xa:qVCO.+JRaGad@"6ti`
p#.7kWJX%T[IKppHQd[LeO9.SP97n6tW=(C\8-q=;6d7W_8Aj$s9C<F\rGN>Kf@X]A:8sU%YY
=^4T'8&8T_/=At$Z"5C1:WoSUQdreeT9%'ahTaHS#<(4g3UpZUe!]AU6H"Gpk1S!^c!;1m>`u
C.7+YN,04q7Gcmra.=-]AH2$J4+?&T\nQdgEeFmK:iqb60[-Z&C2a7$/rr<~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="33" y="388" width="779" height="183"/>
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
<WidgetID widgetID="14d880ce-835f-4ba0-b0b9-cad3ef376682"/>
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
<![CDATA[1219200,1036320,1097280,1188720,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2468880,2468880,2468880,2468880,2468880,2468880,2468880,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[年度]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[换季航季]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[分类]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[需求]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[已完成]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[未完成]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="0">
<O>
<![CDATA[满足率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" rs="3" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="nd"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Result>
<![CDATA[$$$]]></Result>
<Parameters/>
</O>
<PrivilegeControl/>
<Present class="com.fr.base.present.DictPresent">
<Dictionary class="com.fr.data.impl.CustomDictionary">
<CustomDictAttr>
<Dict key="0" value="国际"/>
<Dict key="1" value="国内"/>
</CustomDictAttr>
</Dictionary>
</Present>
<Expand dir="0"/>
</C>
<C c="1" r="1" rs="3" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="hj"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Result>
<![CDATA[$$$]]></Result>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" s="1">
<O>
<![CDATA[工作日]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="工作日需求"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.SummaryGrouper">
<FN>
<![CDATA[com.fr.data.util.function.AverageFunction]]></FN>
</RG>
<Result>
<![CDATA[$$$]]></Result>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="工作日已完成"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.SummaryGrouper">
<FN>
<![CDATA[com.fr.data.util.function.AverageFunction]]></FN>
</RG>
<Result>
<![CDATA[$$$]]></Result>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="工作日未完成"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.SummaryGrouper">
<FN>
<![CDATA[com.fr.data.util.function.AverageFunction]]></FN>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="工作日满足率"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.SummaryGrouper">
<FN>
<![CDATA[com.fr.data.util.function.AverageFunction]]></FN>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="2" s="1">
<O>
<![CDATA[周末]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="周末需求"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.SummaryGrouper">
<FN>
<![CDATA[com.fr.data.util.function.AverageFunction]]></FN>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="周末已完成"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.SummaryGrouper">
<FN>
<![CDATA[com.fr.data.util.function.AverageFunction]]></FN>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="2" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="周末未完成"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.SummaryGrouper">
<FN>
<![CDATA[com.fr.data.util.function.AverageFunction]]></FN>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="2" s="2">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="周末满足率"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.SummaryGrouper">
<FN>
<![CDATA[com.fr.data.util.function.AverageFunction]]></FN>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="3" s="1">
<O>
<![CDATA[总体]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="总体需求"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.SummaryGrouper">
<FN>
<![CDATA[com.fr.data.util.function.AverageFunction]]></FN>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="3" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="总体已完成"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.SummaryGrouper">
<FN>
<![CDATA[com.fr.data.util.function.AverageFunction]]></FN>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="3" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="总体未完成"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.SummaryGrouper">
<FN>
<![CDATA[com.fr.data.util.function.AverageFunction]]></FN>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="3" s="2">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="总体满足率"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.SummaryGrouper">
<FN>
<![CDATA[com.fr.data.util.function.AverageFunction]]></FN>
</RG>
<Parameters/>
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
<FRFont name="微软雅黑" style="1" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border>
<Top style="1" color="-15378278"/>
<Bottom style="1" color="-15378278"/>
<Left color="-15378278"/>
<Right color="-15378278"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border>
<Top style="1" color="-15378278"/>
<Bottom style="1" color="-15378278"/>
<Left color="-15378278"/>
<Right color="-15378278"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border>
<Top style="1" color="-15378278"/>
<Bottom style="1" color="-15378278"/>
<Left color="-15378278"/>
<Right color="-15378278"/>
</Border>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!C;cfR"Fh7""7:rI(@\o6UD,Y!rTZ)cq,ZC6_2,L52;_*ns9,/$b;NtgW4097OnW?S8'!
6o<`K3+rUS<K5aK;:j)3lTN;Zr9'"@<N9aZDGBHT0;cX0p2\fC!HTncp6n-hj/&42:7Qp\fM
i-bT=sE^J,+B)c>_PUSmK?i5?;PUVY)VbENTd_Gd>s*rUdLRP)6q(mBZn"9VinY)YjKm?1/8
o&H;T"dU+T6\$-lI5UELZsPBpYKh(f2(X[q"6crIkLbBrimtZQ$\hb>L<B2P,\;J=.ZJITCc
slKt51MZG2eKVJ`"FrQLJEf&2O[?R5Zl#g6cpV',<<'uJmgZ\$-<;919-Zc_m3TGj,@#>Nt.
Rm,Cm>[jj4$eg7.U!$oRk7.,kBfK@j'=J]A;@5Ej(EG(m2S75!UQXSXRKK5YA6):\ke2]AS]AKb
i,]A^!AZ%HA/'jX,kRS#)A2_;U$^,Z#uhbg9_0n$>%)3+StrkP-'B2ra>"/Y#bb:705g]A:!gt
H2DobL:"tUg"`2j#`L4"k!g=Lij1:]A3C`(6-A'7E;#\$E]A%'k3t6`dCAl5Z(2O#BrMR$f_[k
g+i*BPr06XO,ZPdS*Aaisip'Bn?gO-_7GTHadiKC[QA3nQ""7o]ALV?fXpc$1,VoM14BT'[W;
fU&eTJS]Ai%bSAMh,LRd4NK;*eU8=k*8Qs&e:+.u!hbaYt*YBj#D\M1L&'D=.l=ZT:=QV_-TC
Ye9'rL[u*WB#^hXIC7h79JY)gG2:$>nY[0FeJ-s:9Z,UOII/uUTKag3ZY!^$TiG0KF';T\^N
X7'/[A<c9G;d$^629Jb"jX7c0uRbUHA.5osB-YZI.Ek7_usq\[ErQAO.bZ6S)HA,1Y]A-f4)P
bM"ZXl39+01<Rp[m:8@E\8p_m5-3*,m9SD;[WcOP\6e>0-]A<s(H))n(tVhoSY]A#+7T`7RZlU
.FZB[B(L0/^sAbb@A`D-tsCgB>(,nl%hl'QY;XIk1ZcnPQkp&iW+b;FH`$?>+6U,(NcCBk<E
a2/64IGD,4U7.mN[\\Z-bAGVUM":iM;H<BBV`!_n3`]A?ijmB^5@:pBcldob!O>*^jWnnnqaW
\;jfEX*VZkY7eQepcc$%$1C("AO,`>TcPp8a]AFNBdhT./4"+&i.le6qOmW/Kh+(XEN7>T6Yd
W+#fACJ'^UU?CQ;%m8?I7pYBc5g6N%ThALU2?n\.$QYL'H%4Qo;SRg:4IXq+mfJ*U:*a,!<&
In^"U"5J6&H^<:H?Z64J"Xu=9aeJju^6kNsRBh$/,cVbI\//]AM_[<e7<bg!LX20T:@>FM]Ag[
%14nKV1"jn-/YK12$%-^W=,BI\&[C5T5a2\P)nXq%ue`)mp.D9^o[FfPZYZ-.;MWM/67#DFr
acreRp2aj:sO:E`FkpcU,roJKr)3RcXBWc:-Lg[^9u]A$Y84Mm<+t\R`O4FRf(;6QN,>DT)mr
"5Ws!kZK!61:jHP?VY;&N:m(TC?ZR[%Zt@A/tT4]Aci"''s,4_Ub<gV[3t38YLM#pVf]AoRV(l
N9Wra0;Lm<O(eUfm504o?@jp#T7@EDQCHok-K/*W94>B#OHtp"&H<7>gJXY>W6s`g/BohZ+V
*Fg=08inJ)9Nu.*-IIi,19m9fH)Ro>:[2<u6Wt_X.K6p!sXT(#9$?CuNLaNNO<g'_r'n7Gah
+dYnS53dX(0i`l#WQFlLLmp1mL$8'^C`D\+KoFN&X$E4WVT\%b[kTRhDZ?;J7,.,'LskFfPk
eIB%90ajl,&8`?'@hbB=N,bth,^h0V$o@n<T=Z9Dic_iWu/.gph^PZ/?t*8P1Hd'-q)b]A6oM
4UM8O_JgP8G;EZ'bi!B&GorX0FN6SYOd-o2I_eQ2p>uNunC'4hI-2qkl)=:GZuo7;M.A"p,j
I1cJW3kj<,Yp)V`?JJ*n=4>4f^_U0YZXsDRpQP$UeNg]A=081DA\tuInI;o7A\u&g";%eDoeW
Xg`W&hq;u=>\0dLiR,,Ic#X&,TUc4:dR:!VY+,5GPR]Af.&<r>%&fkZu[n`kmM=*oGKc<$9\a
.6^JY4l$bnF]A=fs3;-)VR[$/1H"SLQ3O$h2m&(j2#:gVTgjZ=U[5K#p3MVS851`1Tuh\a>ST
Je&:]AC6>,-RSX=PP74Cle(CG":)WN(HY/7%3jiE`Duo<=7</a,iC;+t&LZ6Q$+SZKL@6fOga
42b4U1FkJlZ"KVrh-gl?)Etsq<BZCe"J8_!<pZ5dEi'OJDg/ti]Ac(ghV'4R4@_V4$9m\CEa&
,6XPA_MuUtP+?Y?gN(^0UtkjSU]AX/qbu:-b/#k)W0as/@0QP.4[DU&Ndn'TW7e]A(VRCcWq)X
X7%qE.7A&T<=cg)rp*K;i]AK%]AD5#`0jp@4?-VY*K>QX"CgF]AV'4ZS%D3QM>>+?)0d$F'.&NA
5a<1GabLQBB&Zed$ADY7VA[u8\%:<^;-5(^Tmf@44idAP:r/;6s[3p\kLqGpS/F-YB>KlU5?
oV9!0HU[Z2'0T.M)/bp>s@N[io_A2]AAB.h_-4S`+&Vqbd6>lpA'-n$#j#Q.1bj=q:$s\Epb[
^0Tr'IQ6WGijoEAKepY_aGJVV,!*@[*-K(o]AoQ1A96P[Ori<m*a%&ogF!k)AXJMlmqYGM:/R
k,./KM!M-GloFM"OCG*KlD8b^TfA5H>S*ho)T"0UZLVZ5>HF9mkZi9_?5HBQ!LH"s[*Yg)tC
gHreqJHt0l"*R^%_7dDKd!R@;tO?f`mJ/-b"QuTU<T8%,_WM6>V?]ArMp'1%pM@6#-.hP@otU
UH[?Hac_tr^Cn/FQ;>sb:sqTGPSq]A=mI"J(%*jB#essoHdH8X_GM!rp0KsSULHEHms=[\1-4
95M@+5/*;b"$kB(uq#)-eIdUBjd:M/<"WA#PPV0t/R\p?;GG!2Y`d8,hsmVJZ=1He4>kLr5h
-Y&WBQ2#Aa,[oOZ,<D4XZ@qrE?H[P$>A;B\6YO/eYk`tfA-2]AZa&uQe&\HTW-&pRZi@a+gZA
]AZh=k]AUg7(K1fKni*]AQr5N^L4i^_%+7Gs@!\Sn=5=m:[$C&MOt2.UW_+?0CT`.sd[mgq@G:<
*M)-P*]ATJ-,\t0p!hAGZ]A*FmlL/lA40_3QXt0^qc'Br[W"r]A/P8pO_<7d;I\n=29dp4M0m[l
Y;o47lgrtbI6$d<Ptn#Iqfp'_)cF0%#1IM4KR&[.DSGS:jLV5qJ5dfK1YV^[PB=CZ\hUVF%.
)\Iie&0Vpe;bXh?8t]AXtcb^T>6$E@'-_4aBd(jGqj;%P!$IGP%Orq3jhu4bpW%e[tNh13m2/
J#\3h9U""0-&e%W]A\^_>Sc]As4I@,8[Me]A@n=Zr(@GJm-TRm*kDrk66)bM.rK75'f7CS+Pl:E
M8#]A8RN/$9@AXrDR<lG0N[aHi<QeSYGjG8IPc]Aa&o`MQT_5k.\>lgJ<Zm<_^qj&"P`DWg?i*
+O?uZ04.rOnXVX+Bmq*K(m\,2nP`&X4U?80Gf^r+=DFY;T`mhgGbKtO'@T-E9^8kC)NuIcQp
aH+Hek-MhYG;Ale#h-d'?l&LF!@4hGE&1cPRGQWOXlHXnZf:t/;dbsiPdstc-'_7R'rPTD-F
S_EH7Yojlmnor'c4tPbhT>>(c,cBbV2\Kcc!h2oKu)/tT$[S'l:H#]A<5AF9qOX>T"cR>rE[C
&T4.cTe6%^I,qioHmETkj^.+C%t4auScQB=@bbd7g.s=>(sl!h&Y)bRFNn-^gN"i]A[q5q>mE
*"-[ObjC96(O'G=0[$lBpgc$/qg@]A5!#qC5&uE"_['=G[$&H%Qht*)<VU'MDTrZT]A)Z8:qTr
=]AQ80R@Y,g2YZKQcPMAn@JQ=u?3j[_A2C6HT\+hk+bucFFXP*/-EGm8uNO=(e]Ai,_9X[=]AVf
eL[>WF`3`Etqr7j%\?O(aAS2ro@r(,4L4]A=0AAZ*$,"!C.u#Pf04]A3?EBNkjgE,7rlaKN>S?
roNS0`pkYoP`XF,Z;8q4\V\Y3[UhLF+O7Zr.!6*r\U<.?4q0$S4SApnF]ANFU+TLYu0L.K&>i
88_N5)\.^cIhFWBAb!!L=B*T6@HQ7jMH,+o5U1%K_E8Tp>,d)jmZS9Lp_ib"QgW(SRh;(WqK
[L@Ce!=XCl7RIB:7eVQ)$(N:X_*K/G&46$L*c:,#>O,B=gE0]A"iN=lF"1=;K<J6QJX`b:,l/
)VNnO?0MT`MWp%-lJQ_tsDA>pA0%iCP:9V-4NgX5-s-Du9fs1XR(UEXjN^7qN-1^/Ha?#<;e
2Z^Q?+U#4.h-*SB#)^?I;H?JcIANWM]A(r-oHI]AJp-pCq-/gu6k@FU-ltKoM>ba5l)EdJWPB-
(RR^(LJ\TE6ZC)c/5T\!X%4@*14O2E<W9P4:CD/qG+a'DtL]Ao#3<jLKOrS_D;!S0.@%grn^8
FofJL+&_j9c_jdnVE^F+s-SP7l\:r82RK+(I,JfNPo2(nM0^@<&TL7$CJQc)W(fenK]AlCY)5
XIDKZ/l^r[5'0#7GO^iYQrK47"SK#UKW&V=o?@[NPuFcR9cgKcs#<=i/p'q$AZ@qkh"KqcD"
)CMg*<b7&U,"q:rP7CqO#E1,+BSWMO7hn/^SZ?)oJN$aM*)YI-mR:d9h)c&/H%lr(!\#"jXZ
Xf6n]AJgN5?'5J-hUeeB[=tuilPfF$<J5kYYmU:dA!,BK="#klKW5U=Vi:UCYdQ;No*.!pQ.+
h?5mm8(NbN%EdC,u60q)ZPm1"^W?WF&Kp.)"c0gaGgqPQM=etO_\AD-1=8!B.*>f=-Cm.j8I
hKT8YehF-8P0*BnVa#A7*,LRD/T@?*?5$+_R;$!W8C%i?A0-(k\q^-dpl.cSPX01Dk?TiZ^)
W\La)(Z/GP*0EFT]AofT]AY>s<&BL9D=#cO<_N+rX/"g??OKAZ"K4gA\ER%p9Lm5m@T^Vr%!0]A
c)MWQ[aSG%!>+.KNlfg'LNmX]A9!?$IpE;=1*_;+?=/0`Cip3PZm^X3l<\`%5JiS./EPo3/HS
p:;dOF(h!Xh,8."I@Z</8J$(Dd+nreM]AC52(,":qe]AcBPf\b/+s\7uXFP\-ght)>6=bZ0]AtN
O45t/+M(A6h>.o1QUm#-p..jBcYLI1+E/c9P,IIWli1Bpc0lQ8W&&9+<.!6;YI6A9SQmu)o"
Qu\ZeS(r$s10g1?e@3WT-<gH*l;3ru0:U(WlWuRDeJ#ZcoXhOZ1ics,eco<@ht0LL]AR?[a:2
o7eQNp]AOs'uo#o(MhHk17$;jko)e\%Wk%'RC#5g3N#=GAbp!C)Im,Z+`gj)t6.?F2H>ls+Yu
Ir^bOPo%e.Es,;hNZOKt>*qY"[T,YYHjJWOn4GAan]Am8,)pJ,e+1BO"CpG[)::3_!'/X@5V[
,j@^m=8$:4NSVt'[U6'b,Rh8.?;"s]A-#eMJ8:QK%'Fjer9s%_+g'pR[;>tCZbc;gZDcAff3i
_/>A"\@Btu%NirNt^eWF46IjhORo9Q4O_L=FXd<ij?p6LAu'GWW$jqH2G5,e-2QdPR<j76t+
+iU1kZ,CPHWT6GMN[+Rl\2$L*bmM,Wke":mkR0+q;]ALT?&u[6"\U[M`pDAb?PBoh\),'B4ci
9;jm2O6VI:)^hef=<I#PX8Q*#?s/fq;_QI'cWSLj>2hjIS+prY_EDYE(>a4n*OXs.3t6rROb
fmW-.1''0iINX/uf#rp]A=8e*rDYEbXQJ4GhmV3'gbb4c(pT=.Ms=Ajm%Dr)WKM`Y6IUX*cZ"
oCm+]A_;hc_AIlC35.f'n$.7iZ4#W2aBk32j?*QT4j`2>'o$I00mj0G'T3a8p3q1#9fms7iGP
qd>qcoap>5@mD!DJe[;ni)]A))<I`mj?Cq:&.3-XZ;`.@u`I0n?N5QZ!UQGLT,*5A\Tkl"BeQ
.d^C'&">(fIV7VUC;g^"oIG:d1DZ1>2V.#!5$,jo',36DF)6rJAS]AE^k:J-,H]A>c,lF*e3B9
f78H7K*mgYQ5fP?U`8I_aV3>p=Uk=@)fKa2<h21F2o`:l3/pp<t,Q0W&o,U:_+LoE/So$G?"
(fp'pOjQpW3<U4QQ,nYT,qGTDkYPm^197C7K^.QKTF"6d(5O]AZKH(dEhN7j0[#4/J*k_524U
DkEgo%Zp.Wq38PbPrekd?h([7DkfR6k/\HU?oIn5@dN'B6U@eb3V5gl,b--[$*)`rrIWE7t?
`lKmNWZ)>A0rEbmoO)&Zj_j^p(%.7%-jDM(,sk52G[@frX[1lBL3F<NAZs2DdQ@a/(KWS>gD
"Yf<U&KQ0!TV\Gtc>pDLAR[]A<)<mit[Ua4Va]A$eY0(hF7=n6`\I>+Qg*s:g>KpPI>r7UUU79
:P#ZN'hM+KsFEX9u'(*C%_Y>[D;>^O$dgUJ"Y_>I8SM^`3=BSF<uJKc!hM]A#Y,.!CoQkU%,b
;9:[51p=o_=?sV1t@gi(b*G;p&Isqr2^;$%NC2-W\lim4J`8rbYL1M;.K8/I*25TIkP4.s55
RU/!-4j:6IgYE<-cB`jNDrOS!HQqp$D;It,,TLKF[8(p&78L*%tG3=*P\EmVlBuUd\K:AB_M
\\r25s$(>UQ0N$-P2^WrU&aTj`O(bXV98AS1(=$pM&JQ^?:)[8+H+*5pp-H*@i*XVc\,[$I;
QE9cr/ce2+aH%GJJ+Oj/?ojRImUQ)+7`^SnoO\Y6UcICImgX=U/@3%OY7^s7GVh.,=SC2Sa@
V33fD?YU"u\RDg66e)R]A%rl7br9Zfj<Bh>F8Q/gn&0j3;t'24:'&R?qf.\6@'fE#%U'>b#Ab
lm-;!GKbNr6D:6+*J;)5hL[l%*+p#7`9P9]Au.5DWOe9rOR([$RK/Sm2K<7(]AL]A-[FB.@E'Hr
O^#p`_%1)I_jVO2Gac\"_&[3K(M#<U>f%$<2Ql(f_uf<HDAi!,STr,)-?\2"S@8r0$W<DE#.
i_V9&!Gpl>GKpBSBl*Ub!4"n,O;W6prChA=ZNbd5(O'R?Q/^*PZ(YF)sPFGieNPs?BL]A,)Ah
YF\R2C,iD<ZC"+#?/cCU"&;\+eCqn%<6>!>#$g5_]A4^tGPoTI)NG&AEY9TB3#`(0dE0PZuB\
&A._1]AJa+HKH#'SZRPmSc2uD&@R;73+7@Q57Lr3?oJ.JNgu<Zk@J!,/6dLDeY\:$jHJe)ql4
e*Ona]A]ATLB>7L-)sfEkI:PYH8Pf#VRgD@,Y3FOFns1XKn2gXWGu70024oJ,_[OgPhCQO[&:'
G5CoakK^tT[4EJ'^#S)Qpa>tJ_\D<2guX[$%VKqE:g`]Aq1q*$L>+(R,"\_K//-sNpJ:LNm$R
c3<&Z.]ALl><l:HAfDE<7S%9VLd^@5bU:,l;F$cWq3rg;9h91('PmR,LMEcPup6*4oIH(O/Ef
@G@4V_B&,Rp8aT&TkIZ`9ChXF]Al$`Oqk*1s.S,V3Ymh9Y&KIOr/k_t\aM<C`C+7Ugh0%JdhO
SE?m*\Q+$(PbC,^QsFoi0kQb"9u+\b#g1O"dOPr'0KOS$OPXTPr_aBLmZCoQHp7_SS=KG/&i
.p^tI3K&&);_n3*IMJn\$qCt9H`AQpm@K":WX+(!p]APQ'BSf=:6(A"-o@)i"@)tVZEqWc8-b
l$-?O5t'KD<C(g7U[#IH[B-TBtl+$W?Fe&aom"J0C"uVX7[R=[s<S%JB_3k*!O@I5F2sA$[@
reqI^ou!H@j*3iqWr,$`h6\2L^^H3A;\(-h='>e308pbX7bE:iq4K#"iJ[.?P3ZO5bPeKDUu
!;Xl'OP`/$$5.@K'UB!Q).K/6EuVl>_$3*%+KF-m#a5/S',11=64.4dRk3u?Jd7SF:.bE7qW
s(I@Obmn3VO.o=X%'eJL_?uTZd)R6R>MLWRcCr:(7XBd)AX,1-sh<"c;koW]A<HVT\$T(l`F5
rKhfuQPK;L\q^/R)M5At2j;F\!gt;[8K'5>H4Qt3YjOc]A>/F/<$Sf'>eZID1E)`4]A%iS)MnG
Z8&f4'#Lqbu[sIC7/DpnA/5*$+RDEKZgSE:`1tUm,JYIh3np`1,`1oWQh)=JS,"B5heQZl0b
+JeXthI#althJA\gC!uXUs)Q;>kbt\8HPj[C6IhF*.Xk)g^Y.A8a0[S:I,X7uLa*Z:L#/l:I
d9s.4Q7/+6`agn0ri7Q_,YI,S\Mt#9^P3&S-2mNp^i<[E#:f=fJPntOBc`^=CW:7D_T72Wi4
p=/hS(q#-dWfj9=\AaY>%kNU=sngdap.<+r7!,`L2JC!<@>9R)i'.(i`t\iC$r@@Y.i>j0',
917(3B_*7cV3-*%Pag#i'=(+GR<AM,A*pqK[+:[qELk0[>:_jU@$>L0>!K\>*Xg7.]ASt8+Wp
(mM->`K9*gApi/E!KeK2V[Af_]AH5dknQuUGi7nSYGqkQlg@sN.ZapbJ!an#'Gneu6erX`kl3
b'LCh*oi9ONglL<Vr8)8*,J=bds:FuCWPmMut:;3VMO&S$=)i4[a!0&9K)!%6b#')_-o913"
`)qO@Yp'B$"qecMKZHi-]Anpbm"kDXr9IN33gKHHof(3eq@#b:@Ij%ad?UN2]A4<TrX7j&/-ZR
joGO:?R7jaYK<%MDkh\>0F$LNXraSUc"K&-Ybk#Qjk:\MCZjWk3'Fje$MI?kP(aOOH(KQXO:
@J+3uA)feQ%2h^JMpOQ;!HNFde';[(tgN;TEM25#,#1m(lc&9@=*s+nJ3L2u`.FN\GUdKUdA
0ZG;k2C_RV62oRBn&Pt"Nh'jo=uWPRq-Y+"]Af7[i.^l]A+D^2--2i'#G\I+><3fH;##pe!\Wc
,L#fh9*oYCKX!mtD@!&a[*/6T[ka!;<r+:,J.m_Mcd-M,cKQ`nt:U&KnB$LKSLM&&(J.#TKk
QNQE%;j>iAMb?I%rM7PadU[8S?uNK5NVBN[p]A)%*Jm>R!+!1I!1([F)1^L/tpcp[%81s3Adp
mo:L@$W<q]A?qG<J;#n->p9_4na$G?bbk_emskeTNDs;,(;b1eF=cNaBq7IfPQ5a&g+?Z0j@[
]Al;m-#Lqug9!B**,K&M9?/7ET*jI5%QJA4P=V[@W`-M$j3^m>5-`=a=b0GY-4'1g$-#T?Aof
g;-D+l1^9Ecc(H-\<Mt<ATT?$9r,raNnb<=CRX__)"RB!bW/us/ms4<>$4t+UqQ891QKu+-R
q:o9:)==Fu2)8gWV?^oU,PHW'J75J5n#l8<KSOQ-K%4eH6N*07.>"e`PeE#B,g4=N:^6B-JW
AI%Tim8sr&^9UpH7):R?S;hL#os%oX@M2\)W;=8!eSo\9!jGU%[0%Z?r+05SS0Q?B`W'-;LZ
I>7?bYs1rrr~
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
<WidgetID widgetID="14d880ce-835f-4ba0-b0b9-cad3ef376682"/>
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
<![CDATA[1143000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[年度]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[分类]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[分类]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[需求]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[已完成]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[未完成]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="0">
<O>
<![CDATA[满足率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" rs="3" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="nd"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="1" r="1" rs="3" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="hj"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="2">
<O>
<![CDATA[工作日]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="工作日需求"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="工作日已完成"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="工作日未完成"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="1" s="3">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="工作日满足率"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="2" s="2">
<O>
<![CDATA[周末]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="2">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="周末需求"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="2" s="2">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="周末已完成"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="2" s="2">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="周末未完成"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="2" s="3">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="周末满足率"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="3" s="1">
<O>
<![CDATA[总体]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="总体需求"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="3" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="总体已完成"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="3" s="1">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="总体未完成"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="3" s="4">
<O t="DSColumn">
<Attributes dsName="正班-航线满足率" columnName="总体满足率"/>
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
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border>
<Top color="-1"/>
<Bottom style="1" color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border>
<Top color="-1"/>
<Bottom color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border>
<Top color="-1"/>
<Bottom color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border>
<Top color="-1"/>
<Bottom style="1" color="-1"/>
<Left color="-1"/>
<Right color="-1"/>
</Border>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m99s#;cgDNg02NpMq0Dc<Cq$r7?#_tjdD'2X+gs+NlDu/C))jTKK"RsDX/NI'M==[@N]A0G19
H8/-kQbW'bM$$(</f^8.5eE0gHk4KTO6b!QAe(fpPX6[jq3fo80!^hJ97,rjDa5p<MO0#H\j
;b$2'.)Du9bWg+ZZN#FS-IFP23=9%r)gM]A"=RB.GeMCN!+_30;DE8$d67,oJTrjbM.<jX;5B
oM/-2n*@JLk!#bqhF%2[bR4h9b-KWosa`<>FB\9^"XE<Wl';OZ1n%$@$<U@qW!@)JYrUfpO8
T.ls*Q9aP`f>WE+i]A7dFq@Y*&:0*Zna3GAMABj/%pPnIqT6[AtZqS1B5]Ad8hQPg;02K0QX>8
imYWp4!#Iupa"Ig;E.1Z(D$I=rCc+#<Qk+fJ.<#OgFbPYaC!epm-_s]A><=r>Y/I[Sl@tmkq@
ne3^KD?:meUNI#Q*)c-[RCJcoGrVMLgm%?PMV$hC1[j_[J[9'F[RKr@%q?Y)XrCD;';C>2(j
Ngi]A4YX1T+>Do^G?ZC,f%1>NLBB^*J=<g>2H3k=?`K;rfeRhB6Yh8_HFlCW($ZI@W43W*_OL
NS_7NMWH@NaR'-Z.P5.MMjnLd6so'MVA=&l2kn,1lh8A:,!.uj]A!aJb2R=SNeXu]AjLKQ9h$8
-AXA_.^<i'KJ$9)MsM-+2&4;>Q,k4!ul>&oQ1!sM^KcalJJE4US+MerE`OYMbf#JMd'5XftL
ip\<-dXA]APL<7C!EkW?&erGcW'FDu9)7LT2R;F63'hs8e8tp5@)cItCE=&r;H/Z0j2i3ALV,
O.@?9_fP9)^BI[^(.)R6-WTa=0*\*'tE:ZL(b&]AGe?E6GjtDCXE(qVd)?p.(i_i3E]AmC:6'n
beHI8;RKgsYcm0*N41S:/W4;lrOtF1'<:M1.>$O1iGe"aW6gV6>s8-F=s-NDeSL^8k0$ggP4
)m27pUqS3OjXGMQ`XSd,;.o`$C=*`DoT8T3SeNrIdp(A?01@X,pB02,DGs4Xcsj7Z#R'2T.4
`ijR@)jkD4uF\-6oBcIHraMaA=Go+deq'(;@T!Ws.#VTXU'(O&i?+q&CI.)%7eZp'9F50$1#
<No#,o,%=e]AWI?h.D\k=`g\RaHrW8q=@?\>Y]AO5LhH"fk8fF%o=toPZSH$B:I'2LWX>k)G6S
leJpr)3n8<H@,TRt(tI>Zlgk.!Tg\T#IIePJ!gZts\"dfFobLJ`3l<o((MD2rYNA\,`:#EH]A
?/R;mCS\_mOI:<hWL4BUp-N7O,6aI<bLs+j+h76.@;\#MZjOk3L`QaW_n]AAaI21:,R<oQ_Q'
5]AW`9Z=sVH_rJVM#'6_JV!2;k<BRl2VVuuGukb?$[V8&p;.1H+`Wn\_YUL]AaDT7^B-oo8r+c
1u!cMP`Ifb]A_B%j<E[@ZFH4Z0h_Gf0;`!BmZ]AYrY:BW?YNAU<-X5cb',Jma_fXq:N@'DqP%Z
bUu*a0=R1n\%b0&Iro_Wc#iUJ#:#4FObOFLaD-5a]A6V:T3m:<QVs*$uq!]A%/4pZ6G1N[*Qlh
^.dN?d:u.dmV*WuE`aX1_Tj>kZo#U"m6ZI[HM9`M6k(@es^"hl=3di4SqJT%It&SQuJE4W$q
+GiLK!k6G;d^*f*TDuS38Pkdu4&J5G.l$[s3Ci89:I8',J<dSuuo-EA4?k0Ts6DL\]A7'Tc+@
'(#L[0ECc@^?t>S!@I3!kIdRTZ^Ai=N#XB;M2DY6bum^!"5&Wdh$0Okl",+a?YF5G\psJJ>d
qd24n]A#Mqm$\P?Url4Y7khel$^iQ9^,MZLo-G88-7&`mLnd8_@]AI-W5!G>t3J00;bB11A%NA
,*CNP:$rg=:\/[UZ+H9CaVHWaY.Eij:srb30duGU09ghFa+@)V+!+Y"44*5X<tLGaYGn6=\g
b-eDCTKZSo4!o/#sq#lT%\lRo![U,YULj/X4=E'L']AF8U'LGR%+auNPc&P]A(R\Y?!GUPU^+4
\Q+RG1c_M8di&5'(BNcY9mfP)YYYba)r3I_?97kDF&Y[EXTG]A>'F*3HcO=rtVqE8RL"SrZ]Ah
\/uqs2A_6Qm\`J>Cp1C.CZa(;iBS`Mb1:o)C2c5hm/o@*JRTj5J-t?[t\f>]Ar3-3WH4Df29E
dtP=!UIFV(\2oaq)aQ.,-WMnS=`QQJ6+,-1AOS[=J)BL/^FQ>jO,fPH3'UI:d)LM121GC8O=
o$9FBk'2_(_rT($d_OnD,?k9&:@c7<8=dBHdlfAHOuIKHSY<tAqIO8SXs[+GnnCd?D(oME;a
hQrfk`u1/HF1`piT3cF=:=9Sn7=KM;X@RFECk09G]A&&rqFp;I$RUKnt/"7ItgC+1S3e=L`gm
[4m86U>@bI:`;07i9=GFW/deW(%MX\qaBs_$DYgE0:l([M:`MMW0k-EN=gDlQ(*eaLdJ5D]AT
ul=\8-8h'>4H?cAU>8Y0.nr$I"*RX\ld7EgHp9N4i%rcc%UYoWoY$&Ek"Y-SE!p:K/:2hg4K
Eb<9<@>n=+A\dDO%mm-:X.^!TY;-amt-Mb4NEm@Q5-_!C<-`HK3ikD4.rEfgW2U-DO,,]Ar1C
o^,^U\`3Rs?VH[[s'cC,\e@"D-Z"/tFDai!Dg\^<V)!Nt__YhDXf4d`Te4E+<_60/@q_`a>3
T8F8m]AEOh5[$K(EVfhXWcD_GIl>*)JYd*rTI<b2A%s3pe<=K?B(.I0bO;B\NcVH=(TfO7SCk
#35"%6=44]AV=AK[8'gm\IQ9f9##%O^5M1PCD).?7qlYW$m`emJ,P3%J;BNW`-[?coW3=L%sK
mSoUl"q*2nj:r)qi.^UXpJ!,]A"r!(iA^bC!4S3S`K/_BY7d/S]A!]AfJhAl!sGBQeYFA=T>6T:
$<m8JCu+m40N.pWfd6ml`^Goc#dW[pqiY/-J4a"!$(\.i[1=XHT6"k3>?od4H<Cq5O2b)7#?
'=g%_4q"OTce6E5rTTP^m^?.c##uU]AlSckBBpE=B<as+dg=VA:i^\YP)jBfe_3YYPKJ`mAe,
5CCY=Y&;N1(WShpR%!Ris,HFJbm<07qBj[b0)MK"!p5)!4-L2Meq"d/5n2i,Mm[0&Pa%pUgl
PrpF"k2]AYfBU\-"B9S!u&Ek20JqV,>cP_Q.JAro'W?4A0;Ouu99B8fo[[_G#-leP;Jne#2>9
58)eIdVo4gLQ8RPaqU%emh"4U\-H4aUceK.l*pPX$7ZVM8*X-ok5nQE6mZ9\Q]Ah@EO<j:7t.
$ul!;mbNn0#K<*CA$gkgs):JpXXkYY&[P_+N-qRMVkA9D<i1SptdW"r/?H#4,?;toHbQ_R2V
rhXW5a[[Vh'RJN-1YdGj&Z08:<^#'7<C>U4Rd`fJ^t=O0$PV\@h#aVm,@-##c`JOK$d,\&Qi
P#Z_nN0]AX&$'CS^\ro%Ck38;7loX5]AuZ5fgb@3D\:\.ko@W7=(A87Y"D7?@VVusbf+ZB9XU=
&oWPB3nRVZlN8HMC/'ZXHKPL:[cZLh8IY1sAMhK8X\3Wm!1kf-_$D1I10#)lHK.-"X,^5e;Z
oom_l;lZD^Hb0/;oQf/*+Fe&o.4b9=39uF;_EO!nCEh0,"51]A(#MP*"Q-M^9'1W6!93_\_]Ah
d6(V;+;h2P2#*DK"OSk=c<Kr/2(/?1n)*us%c[++pU*1s*EX7[s#WA@G%N!u$PBJblM"U$^s
eooF4$";'ag&eeAGllfrd*o+]AYN.HBbL5ebfN>]AAUN<U.g8=I8AXh-rP^^?&6M:?>7G;Trh#
*s).'WOZNr;2Y_>j-WgLhbq);/_1d>@^X$R+laJ6lDIK=:_TLaE;!]An5nklAL!%,C5X@iq('
:G)"mIBIbg_7;_G@*_I#iI@8Bia9d3qjoM-EB/f)aTtYl0E`$[q,_mL/EaPAqgq\>r&fQAZJ
B:6f[[0Yqp%XRG.,\K1XX8jeg8\&[PE*eoSC4qOEZg_%Y2#H16[@5(fRF'l`Z$GU1Z*j:^2R
^I*2:\&FWTob,L_P).I-cWk*%a''hU%o2G#r%Y_tnR/J_,2\ojW3X/C&Ebg<?LXoBH_`ZqUF
[hqrBTIXM4(:K`K7U6:VCO-,"i\F(D`[(?]A"6VY'rt!oY^#c%Q]A#;Ca?n==i$SfR!7eo\Rff
1D&QV48"7sL-$2:g"+LZql</oAB<8q.YV1iXQ_c/*:h,?41t(2DLeI--`%CQYglZ)c/ge9:j
5XGZSk?nT<O:&AtY+Sh@Q]AnJ&5R@!jL`aG?&L:VVK5LDAUA(c->Y[/`OkMe1>@]A.XU8sIJR(
HjH+i*'!*HO4%Bn+UU_Z^I(?bq3a`d*0acGr30.BldV0Z=rc6m:\SeQr,]Anp4lU-R&<!Agj:
3=8#L0.W:9(kM^.-.oq5p[lJFNZRXq6,*?M"l@kT;P(n'=P?"M!-*K,^>HuI>;+6MZJ.b?aI
jX?;pX%8:rs+$#8OmZ]A19`CP"1T.2,L)i7\]Au/#M:c/T>54/Fco!Vu&)@FuF<B+'Wc,ft']AF
s5S9C"o>VqGEUmGj4KL[:LGJ6=&tX$3t1MT)=U#<^h[00c&iD+IfD=0hqkg)%[3gIqQX+bgO
fn[1=qMLBmXlgqaHj4fMH\C'3rf8@f+C-UF2aND,9aN"]A6lG8d_pQhHpFpoV^$E--V@A`eam
,R;-8XkUCBbol!2#=Ar7b#]A?\*p1)r&i"WqsN@B9V5"+\FVD9.gCIR2TFPLXd4;(amTqpbMA
R`c9K;-\Cu_uN=[[Q!ic%F\;O!$DHQmMAfKb[A.WaJ>(G3pGdJoqnOgE<%=NX&n@,l<%QhL7
X?+1-q$1l"6S-NPp+7C9k6#]Ab!j3,S4V3YZ^pPsooqQpG4Hd[bgjM:\Fj9?Y+oR1O$P/<?c-
"7>0!LBdhF7o'oRi-jgAU^WRd*1*AMK,0Y?BG[#8eVpC`k/-E$M:AW<sChhL<!7qNRb13ITG
tI&6GV]A>tR0^/j2tq!biBT2Y_R6AU2?''!hX:\$\gdg)85CrR,2GA;hr^C\&Jj:F+kD&hF3(
5HL$(P?a?3sLLCg"b)MWWr@?2Mch/+'S&[-/d5CP^4g'0"d+3]A4n2BgqAgJ)"A4%+[_Z-=DH
=SB+VrTD4X?3dl6.r?gcb!h)8W0<MA-SZZ2C]A]A<@E!i-=LN?bdmf#Hi*5k=u54[]AZ,B?>2Xh
pNAt+lT:ccaa<GHD1IVS0=8^a"?#NuT6VKpCL:.e4g^rlqs=LWIYCYb_SW4f_uBuc#3_'@']A
G1q,;EOgI$*G$M$('kkb^8@8,RV.)gF7Gn3'NLi)I,G:Z8Cd%c$0f:I(nW_lo`F=,>kaa$f9
D!&s_YcO2<,qnnE0Rm^-$&`>jgpZ%LXG8s4=@+F%cALi=;\NnfQ&W@Xd<+'EVkm$':deEJ`0
7:e)R1W%LXK14rUh&pU6HO-3l#s:n"qF^)fM"JD(E!Y#<f#jU0q8DK&b=d?dO_9@^;2Y*I<q
\6F*2W`Z5lK>%b5,d#?JW,0Ur_g.SVe>\aENM]As/kSM0Vk#!qp@[S&m))5f?Nq&bno$Dc[W0
k>`oT74=l43:M#[4r";J"<.j(/t$MnmCTW58f772-K4D<mWeYKns"fCB*=+CDnb5kG5MAuG+
!FIcuVOi^d@PQ\iV^J&_]A^R(eib"Ysg+2r:(_'."a\p*7RWRNYld<:Gl#K@Vh9T/HVj2VNu>
`p(@4]Ai9*E(+OI.&id/Gei-ncHXs,R%;F7/$^gh/a)">Y*N=\YaRX]As&CC7/#FCA4%S)YF@;
+EYf1gN45k^^\=GX>'?"Ck4A)kUUQJ.n/h/m3-%3,A^^,PV;!%E2de=tA7c9%cls@=Y8(?[2
JhUZb&0S=6S]An9jC'h[B6T5ecN=&KWl_U]A1lq&6b?3aN8UUa.5cSjGW#q:thka%Q(Rf"&3XJ
KsG6bHSD^\`L-u5J[UPnFGBk`J?peV/fUmJrf5KZi^b')473DY;FLCW3RYS^l!E7C+"%9)fB
#+LPQrO0KZ70iNP<9h?2b=U((*4\M%90rCRjLn!c\!>9^l`eE=W9S9#))3>/1Sci1Ze5H`Wa
g7WKk9ctt4Df*S&e.L-Xh7Hs,Re%H-cI.]Aa^H6`D@m.6BlJ3o(;Zi$`FV-iKT&=7)T^s;-Y4
c,*g7o?+FBiSO\*9".*X`pr/44%drA+aqdJFcnDKabKFEs*YFo'gr!#rEbs(bt*E.NeOCn]AP
&2WR&`[Srn@)+<bET*[GZFhm?")5RuN\<d-*kVXC@D\.=.5&RHhiqZQ<qfRP7"2N@?ae02KS
hMsk!Ps?B?M/n_cIfcOh:IdrETIAqD@qNCRap/E4pA58(]ARK!g/6E0E.)tX32!mnZ<'JD)2W
`*=a*,S_=o&:3AXkQLY6)']AUgOa2g+3_u@J[-ea1fYPdU!c)00Fr*DH_IE2Ob9l%&?'2>:IK
:_t=MH\MlS#*F+Q#R*L;]A)ba%A%^t#8dQ,1>,DFN9@5R&QkA5k"C\$%m52e;:=kup$S@;`<8
>I%c!>jal#$'c_XU)!h$k*+=geo(f!?AIjG;Pn=,Ytfi;"ASWC.n=]Ai,l4F,SXHpE8[`;[d8
=""#l%-P"T7i$>$q2K;2]ABecWSQ>/[<$"VF!Cbftdtq*#Fi.K(#%`5<Ch6%P<s,$OUWOoq%]A
9!an$RUqZb:)E")5U"SVNPm%V:f[eilZ!'md3E1ii=&i$!V$#'i&XaJ3Xd*%BP64o-h,B[B)
u@?3n]AVfcAh0$f.?9T0,lMA1t1-10g0i+d!?)qeI@$.ct/0-@fA-bG$N='ho,oL[i;N;*0";
0m2>c>S:i/Rs/od;heq4g]A6tIZYJ\)g??5=W_]A%q;@:(+9hf?*fQtk?ZYEqPAQ\M]AB=uPa54
gbN<f;:>A_nNSX_C9,t]ACYNqI2BNjU'!*TBKgtUoo`V9['/,I#@_'kaG_Y.4S7m@YH\&640K
aGD<\:.#7O:)qmdrK\ksneL0Zm1[GU^1*`M1ej@gJ/f:9Ee`-GjQ7.YE@'i4]ArO^!I<Y`:,?
1CgOd8:gh;8_6@Acp(B$j8I6*da*_N&`l?hcfes(rbC3d%p'S>htL0E=8a!F%-=[kP'6%62$
06Ai\LGpp>*@Hq\7;"@sdYO0`9u[N3FD$Sd"tmW&KKGGV'"D/6d!6K;<XS`0?jdWc::7Oc5)
5('h(F-&7n>:M)IFJ>tA%fkC]A`=LOU2AHZ!XW;76/)-6''7o7afHRhN0:M9Mek-bl$q5RpXj
rIC6Alh9.bI[*G^DTu+PO20/7DIY.M^0.BJT]A<eA#sNd37.V<W@WojIAM\Kps&D_-9b:%2k/
KtPa)W25"/pYrh"^<r>EtXX$<KH82?_^o;EF=!15g4V_q,U-m912l86mX+P?da5a8dHU@7Nc
Jl<R,>HpNd25Ng\F'pO[6)R0/RcUlo4rd6S@Th8BX(2MJ2*I7!iS(dMq_0:jo.4C%dQJhHA^
kpk1:V9C_E$V)%at5fSs*Uh>dU<4"AR8frG<`sNk]A=lI<h?.qZtL3Yf1PiVE-sFV(8R/AQ+Q
k0NrJ!QcY]Ap4l%,L!,XgF>aG:bJ"PR,OLgsO"K=7oicYCp&Lt0p336bY1!sCZ4-67.O>VWkh
]A]A%e7lPi#jub)."Nb"K+P:W8lt=rc<EP#;#WTAM0jhgTT*/4BK%\_D-/*D/i`\gY<CMQ]A.,&
LfPK78?#)d1gmLlP=j9JGJL:M$jbp2o18H&2<lUj-95on8oC?k1)R=Lp*RHb!GZBI#jp:#Z^
]Aj>bH1<"Yr?rae?DNd`t%1CHh&s>,4UiW9lHB!<ij-/Lf7=EN+2'C7b$d,U>g<c`\?KUd*j;
O\BD&e:0g-k7GW1/__nD&5tA_&@s=Fj%1JVIae.([rJ&u^^8o#JiLI'&,^g45HKES4eSpr.@
;7/I":03YEAWG,=.6[jRD&R^%`DMI'Qqq@972\Vbp`.6mKPcmC%XOU;Mj+iCR%?Oubo77a_B
=G"j-C%b`n`.`L^um>%feU;Q:h33GfZ-$.Ljk_)5]AUjc(XYF0Y),5R?\t;n[\W0O&\r8fHgT
k9B9G+38K(*Zh"YQV-%D^[)QAjJXc\c'7*Po@dZTO0D(9AMXC,:Ud*LEI)BEKaCJWhg8n!C$
F$9Mo))Gs8>@eu`c<e&+(UPSm.pJ`b,2C$sE;J=ekAD9]A8g@L's$&#RW?4\^q1'\7OX6r@"\
dYXXQ-G'Ni>VkC31$FlSY7D1`DmKOC8l`b#V(8_"N=j;E+Bka!\\Jc%P9SMSh[t]A%qQL=ON:
5Pb*.t#eA1YOXKtp%g6`P#^"X`edNE[["X86TIN2s?AahKf)fsdN'q$18T1RBdn;G5$h'_8R
Q/DbK7Eo`2t)&$=GLeNn]A"Ok#MK60UK:*4e;C7SnA12a$&O2A'a@PHm.Lp.*'Jja4s(88")U
2IA-L;1)bfJ$fdQFNj2m\PT16oW;aBL'0m*`JQ($EZfqWAU<Qg"Y-sZVj(]AO^~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="446" y="102" width="408" height="164"/>
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
<WidgetID widgetID="7a52cd62-87ef-47f3-ba93-e74524af1310"/>
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
<WidgetName name="report2"/>
<WidgetID widgetID="7a52cd62-87ef-47f3-ba93-e74524af1310"/>
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
<BoundsAttr x="4" y="321" width="865" height="285"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="航空执行率"/>
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
<WidgetName name="航空执行率"/>
<WidgetID widgetID="76e1a71a-20c2-419b-8d79-b80629440cd3"/>
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
<WidgetName name="航空执行率"/>
<WidgetID widgetID="76e1a71a-20c2-419b-8d79-b80629440cd3"/>
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
<BoundsAttr x="875" y="5" width="267" height="601"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="航线满足率"/>
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
<WidgetName name="航线满足率"/>
<WidgetID widgetID="163e4760-a333-4bff-9d97-166ed8d55934"/>
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
<WidgetName name="航线满足率"/>
<WidgetID widgetID="163e4760-a333-4bff-9d97-166ed8d55934"/>
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
<BoundsAttr x="4" y="6" width="865" height="299"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="航空执行率"/>
<Widget widgetName="航线满足率"/>
<Widget widgetName="report3_c_c_c"/>
<Widget widgetName="report3_c"/>
<Widget widgetName="正班定义"/>
<Widget widgetName="chart3"/>
<Widget widgetName="chart2"/>
<Widget widgetName="pa"/>
<Widget widgetName="pb"/>
<Widget widgetName="report0"/>
<Widget widgetName="report3_c_c"/>
<Widget widgetName="正班定义_c"/>
<Widget widgetName="chart1"/>
<Widget widgetName="report2"/>
<Widget widgetName="report3"/>
<Widget widgetName="report1"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="510"/>
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
<Size width="960" height="510"/>
<ResolutionScalingAttr percent="1.2"/>
<tabFitAttr index="0" tabNameIndex="0">
<initial>
<Background name="ColorBackground" color="-10308624"/>
</initial>
<isCustomStyle isCustomStyle="true"/>
</tabFitAttr>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<carouselAttr isCarousel="false" carouselInterval="1.8"/>
</Center>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="540"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="tablayout0"/>
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
<TemplateIdAttMark TemplateId="523ea4fa-aba6-4d8a-b7b7-1a937f774f3e"/>
</TemplateIdAttMark>
</Form>
