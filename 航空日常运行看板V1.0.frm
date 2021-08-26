<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="01准点率-同环比" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select a.year_code as 年,a.data_code as 日期,a.cql 准点率,b.cql 上一周期,c.cql 上一年, a.cql/b.cql-1 as 环比 ,a.cql/c.cql-1 as 同比
from
(SELECT 
DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') AS year_code,
DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') AS data_code,
(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0)) / SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END)  AS cql
FROM DWD_FOC_FT_FPO2 t

where  DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')=
DATE_FORMAT(date_add(now(),interval -1 month),'%Y/%m')
GROUP BY DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') ,DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')
ORDER BY DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') DESC ,DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') DESC) a
left join 
(SELECT 
DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') AS year_code,
DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') AS data_code,

(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0)) / SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END)  AS cql
FROM DWD_FOC_FT_FPO2 t

where  DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')=
DATE_FORMAT(date_add(now(),interval -2 month),'%Y/%m')

GROUP BY DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') ,DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')
ORDER BY DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') DESC ,DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') DESC) b

on 1 = 1
left join 
(SELECT 
DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') AS year_code,
DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') AS data_code,

(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0)) / SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END)  AS cql
FROM DWD_FOC_FT_FPO2 t

where   DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')=
DATE_FORMAT(date_add(now(),interval -13 month),'%Y/%m')

GROUP BY DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') ,DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')
ORDER BY DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') DESC ,DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') DESC) c

on 1 = 1


]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="02运行指标-时间维度" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
<O>
<![CDATA[日]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT 
DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') AS 年,
DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), 
(case when '${p}'='日' then '%Y/%m/%d' 
when '${p}'='周' then '%Y-%u' 
when '${p}'='月' then '%Y/%m'
else '%Y/%m/%d' end )

) AS 日期,
 
SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END) AS 计划航班量, 
SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) AS 执行航班量, 
SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_DELAY ELSE 0 END) AS 延误航班量
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_CANCEL ELSE 0 END) AS 取消航班量 

, SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END)/ SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END) AS '出勤率(全口径)'
,(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END) - SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_CANCEL ELSE 0 END) + SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_OPERATION_CANCEL ELSE 0 END))/ SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END) AS '出勤率(考核)'
,(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0)) / SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) AS '准点率(全口径)'
,(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0)) / SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) AS '准点率(考核)'


FROM DWD_FOC_FT_FPO2 t
where DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')>= '2020/06'
and DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m/%d')<=DATE_FORMAT(date_sub(curdate(),interval 1 day),'%Y/%m/%d')

GROUP BY DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') ,DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), 
(case when '${p}'='日' then '%Y/%m/%d' 
when '${p}'='周' then '%Y-%u' 
when '${p}'='月' then '%Y/%m'
else '%Y/%m/%d' end )
)

ORDER BY DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') DESC ,DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), 
(case when '${p}'='日' then '%Y/%m/%d' 
when '${p}'='周' then '%Y-%u' 
when '${p}'='月' then '%Y/%m'
else '%Y/%m/%d' end )
) DESC
limit 12]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="03运行指标-机型维度" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
<O>
<![CDATA[日]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT
mp_fleet
,SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END) AS 计划航班量 
,SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) AS 执行航班量
,SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_DELAY ELSE 0 END) AS 延误航班量
,SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END)/ SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END) AS '出勤率(全口径)'

,(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0)) / SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) AS '准点率(全口径)'
,(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0)) / SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) AS '准点率(考核)'


FROM DWD_FOC_FT_FPO2 t
where 

DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'),
(case when '${p}'='日' then '%Y/%m/%d' 
when '${p}'='周' then '%Y-%u' 
when '${p}'='月' then '%Y/%m'
else '%Y/%m/%d' end )
)=
(case when '${p}'='日' then DATE_FORMAT(date_sub(curdate(),interval 1 day),'%Y/%m/%d')
when '${p}'='周'  then concat_ws('-',left(yearweek(now())-1,4),substring(yearweek(now())-1,5,2))
when '${p}'='月'  then DATE_FORMAT(date_add(now(),interval -1 month),'%Y/%m')
else DATE_FORMAT(now(),'%Y') end)

GROUP BY mp_fleet]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="05运行指标-国际国内" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') AS 月份



,SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.ACT_FLIGHT ELSE 0 END) as 国内执行航段量
,SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.FLIGHT_PLAN ELSE 0 END) as 国内计划航段量
,SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1'  THEN t.FLIGHT_CANCEL ELSE 0 END) as 国内取消航段量
,SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.FLIGHT_OPERATION_CANCEL ELSE 0 END) as 国内营运取消航段量
,IFNULL(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0) as 国内执行不正常航段量
,IFNULL(SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0) as 国内执行不正常可控航段量
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.ACT_FLIGHT ELSE 0 END)/ SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.FLIGHT_PLAN ELSE 0 END) AS '国内出勤率(全口径)'
,(SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.FLIGHT_PLAN ELSE 0 END) - SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1'  THEN t.FLIGHT_CANCEL ELSE 0 END) + SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.FLIGHT_OPERATION_CANCEL ELSE 0 END))/ SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.FLIGHT_PLAN ELSE 0 END) AS '国内出勤率(考核)'

,(SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0)) / SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.ACT_FLIGHT ELSE 0 END) AS '国内准点率(全口径)'
,(SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0)) / SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='1'  THEN t.ACT_FLIGHT ELSE 0 END) AS '国内准点率(考核)'


,SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.ACT_FLIGHT ELSE 0 END) as 国际执行航段量
,SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.FLIGHT_PLAN ELSE 0 END) as 国际计划航段量
,SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0'  THEN t.FLIGHT_CANCEL ELSE 0 END) as 国际取消航段量
,SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.FLIGHT_OPERATION_CANCEL ELSE 0 END) as 国际营运取消航段量
,IFNULL(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0) as 国际执行不正常航段量
,IFNULL(SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0) as 国际执行不正常可控航段量
, SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.ACT_FLIGHT ELSE 0 END)/ SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.FLIGHT_PLAN ELSE 0 END) AS '国际出勤率(全口径)'
,(SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.FLIGHT_PLAN ELSE 0 END) - SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0'  THEN t.FLIGHT_CANCEL ELSE 0 END) + SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.FLIGHT_OPERATION_CANCEL ELSE 0 END))/ SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.FLIGHT_PLAN ELSE 0 END) AS '国际出勤率(考核)'

,(SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(COUNT(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0)) / SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.ACT_FLIGHT ELSE 0 END) AS '国际准点率(全口径)'
,(SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0)) / SUM(CASE WHEN t.FLIGHT_PLAN = '1' and DI_CHAPTER_LABEL='0'  THEN t.ACT_FLIGHT ELSE 0 END) AS '国际准点率(考核)'

FROM DWD_FOC_FT_FPO2 t
where DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')= DATE_FORMAT(date_add(now(),interval -1 month),'%Y/%m')
group by DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="04运行指标-O和IBU线" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[SELECT DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') AS 月份


,SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_PLAN ELSE 0 END) AS 集团包机计划航班量
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.ACT_FLIGHT ELSE 0 END) AS 集团包机执行航段量
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_DELAY ELSE 0 END) AS 集团包机延误航段量
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_CANCEL ELSE 0 END) AS 集团包机取消航段量 
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_OPERATION_CANCEL ELSE 0 END) AS 集团包机营运取消航段量 
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_DIVERTED ELSE 0 END) AS 集团包机备降次数 
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_DIVERTED1+FLIGHT_DIVERTED2 ELSE 0 END) AS 集团包机备降航段量 
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_RETURN ELSE 0 END) AS 集团包机返航次数 
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_RETURN1+FLIGHT_RETURN2 ELSE 0 END) AS 集团包机返航航段量 
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_NORMAL ELSE 0 END) AS 集团包机执行正常航段量 
, IFNULL(COUNT(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0) AS 集团包机执行不正常航段量 
, IFNULL(SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0) AS 集团包机执行不正常可控航段量 
, IFNULL(COUNT(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0) - IFNULL(SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0) AS 集团包机执行不正常不可控航段量
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.AIR_TIME ELSE 0 END)/60 AS 集团包机空中小时 
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.BLOCK_TIME ELSE 0 END)/60 AS 集团包机空地小时 
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FOC_WHEEL_TIME ELSE 0 END)/60 AS 集团包机轮档小时 
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.LEASE_FLAG ELSE 0 END) AS 集团包机湿租航段量 
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.DI_CHAPTER_LABEL ELSE 0 END) AS 集团包机国内航段量 
,(COUNT(CASE WHEN t.ASSESS_FLAG = '1' THEN t.DI_CHAPTER_LABEL ELSE NULL END) - SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.DI_CHAPTER_LABEL ELSE 0 END)) AS 集团包机国际航段量
, SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.ACT_FLIGHT ELSE 0 END)/ SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_PLAN ELSE 0 END) AS '集团包机出勤率(全口径)'
,(SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_PLAN ELSE 0 END) - SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_CANCEL ELSE 0 END) + SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_OPERATION_CANCEL ELSE 0 END))/ SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_PLAN ELSE 0 END) AS '集团包机出勤率(考核)'
,(SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(COUNT(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0)) / SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.ACT_FLIGHT ELSE 0 END) AS '集团包机准点率(全口径)'
,(SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0)) / SUM(CASE WHEN t.ASSESS_FLAG = '1' THEN t.ACT_FLIGHT ELSE 0 END) AS '集团包机准点率(考核)'

,SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_PLAN ELSE 0 END) AS 外部包机计划航班量
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.ACT_FLIGHT ELSE 0 END) AS 外部包机执行航段量
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_DELAY ELSE 0 END) AS 外部包机延误航段量
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_CANCEL ELSE 0 END) AS 外部包机取消航段量 
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_OPERATION_CANCEL ELSE 0 END) AS 外部包机营运取消航段量 
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_DIVERTED ELSE 0 END) AS 外部包机备降次数 
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_DIVERTED1+FLIGHT_DIVERTED2 ELSE 0 END) AS 外部包机备降航段量 
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_RETURN ELSE 0 END) AS 外部包机返航次数 
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_RETURN1+FLIGHT_RETURN2 ELSE 0 END) AS 外部包机返航航段量 
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_NORMAL ELSE 0 END) AS 外部包机执行正常航段量 
, ifnull(COUNT(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0) AS 外部包机执行不正常航段量 
, IFNULL(SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0) AS 外部包机执行不正常可控航段量 
, (IFNULL(COUNT(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0) - IFNULL(SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0)) AS 外部包机执行不正常不可控航段量
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.AIR_TIME ELSE 0 END)/60 AS 外部包机空中小时 
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.BLOCK_TIME ELSE 0 END)/60 AS 外部包机空地小时 
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FOC_WHEEL_TIME ELSE 0 END)/60 AS 外部包机轮档小时 
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.LEASE_FLAG ELSE 0 END) AS 外部包机湿租航段量 
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.DI_CHAPTER_LABEL ELSE 0 END) AS 外部包机国内航段量 
,(COUNT(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.DI_CHAPTER_LABEL ELSE NULL END) - SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.DI_CHAPTER_LABEL ELSE 0 END)) AS 外部包机国际航段量
, SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.ACT_FLIGHT ELSE 0 END)/ SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_PLAN ELSE 0 END) AS '外部包机出勤率(全口径)'
,(SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_PLAN ELSE 0 END) - SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_CANCEL ELSE 0 END) + SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_OPERATION_CANCEL ELSE 0 END))/ SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_PLAN ELSE 0 END) AS '外部包机出勤率(考核)'
,(SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(COUNT(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_UNNORMAL_CONTROL ELSE NULL END),0)) / SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.ACT_FLIGHT ELSE 0 END) AS '外部包机准点率(全口径)'
,(SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.ACT_FLIGHT ELSE 0 END) - IFNULL(SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.FLIGHT_UNNORMAL_CONTROL ELSE 0 END),0)) / SUM(CASE WHEN t.ASSESS_FLAG !=1 AND t.FLIGHT_PLAN =1 THEN t.ACT_FLIGHT ELSE 0 END) AS '外部包机准点率(考核)' 

FROM DWD_FOC_FT_FPO2 t
where DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')= DATE_FORMAT(date_add(now(),interval -1 month),'%Y/%m')
group by DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="06出勤率-同环比" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select a.year_code as 年,a.data_code as 日期,计划航班量,执行航段量,延误航段量,a.cql 出勤率,b.cql 上一周期,c.cql 上一年, a.cql/b.cql-1 as 环比 ,a.cql/c.cql-1 as 同比
from
(SELECT 

SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END) AS 计划航班量, 
SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END) AS 执行航段量, 
SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_DELAY ELSE 0 END) AS 延误航段量,
DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') AS year_code,
DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') AS data_code,
 SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END)/ SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END)  AS cql
FROM DWD_FOC_FT_FPO2 t

where  DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')=
DATE_FORMAT(date_add(now(),interval -1 month),'%Y/%m')
GROUP BY DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') ,DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')
ORDER BY DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') DESC ,DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') DESC) a
left join 
(SELECT 
DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') AS year_code,
DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') AS data_code,

 SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END)/ SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END)  AS cql
FROM DWD_FOC_FT_FPO2 t

where  DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')=
DATE_FORMAT(date_add(now(),interval -2 month),'%Y/%m')

GROUP BY DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') ,DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')
ORDER BY DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') DESC ,DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') DESC) b

on 1 = 1
left join 
(SELECT 
DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') AS year_code,
DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') AS data_code,

 SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.ACT_FLIGHT ELSE 0 END)/ SUM(CASE WHEN t.FLIGHT_PLAN = '1' THEN t.FLIGHT_PLAN ELSE 0 END)  AS cql
FROM DWD_FOC_FT_FPO2 t

where   DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')=
DATE_FORMAT(date_add(now(),interval -13 month),'%Y/%m')

GROUP BY DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') ,DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m')
ORDER BY DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y') DESC ,DATE_FORMAT(STR_TO_DATE (DATE_STD_FORMAT, '%Y/%m/%d'), '%Y/%m') DESC) c

on 1 = 1


]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="08延误-明细表" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
<O>
<![CDATA[日]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
FLIGHT_ID                       as 航班ID              
,ID                             as 新航班ID      
,(case flight_status when '1' then '正常'
 when '2' then '取消'
 when '3' then '备降'
 when '4' then '备降1'
 when '5' then '备降2'
 when '6' then '延误'
 when '7' then '返航'
 when '8' then '返航1'
 when '9' then '返航2'
 else null end) as 航班状态
,FLIGHT_NO                      as 航班号                                           
,FLIGHT_DATE                    as 航班日期        
,FLIGHT_TYPE                    as 航班性质            
,AC_REG                         as 飞机号   
, CAST(ARRIVAL_DELAY_TIME AS SIGNED)            as  到达延误
,(case when ARRIVAL_DELAY_TIME  >0 and ARRIVAL_DELAY_TIME<=5 then '(0,5]A'
 when ARRIVAL_DELAY_TIME  >5 and ARRIVAL_DELAY_TIME<=15 then '(5,15]A'
  when ARRIVAL_DELAY_TIME  >15 and ARRIVAL_DELAY_TIME<=30 then '(15,30]A'
  when ARRIVAL_DELAY_TIME  >30 and ARRIVAL_DELAY_TIME<=60 then '(30,60]A'
  when ARRIVAL_DELAY_TIME  >60 and ARRIVAL_DELAY_TIME<=120 then '(60,120]A'
  when ARRIVAL_DELAY_TIME  >120 and ARRIVAL_DELAY_TIME<=240 then '(120,240]A'
  when ARRIVAL_DELAY_TIME  >240 and ARRIVAL_DELAY_TIME<=480 then '(240,480]A'
  when ARRIVAL_DELAY_TIME  >480 then '(480,-]A'
  else null end) as 延误区间分布
,DEPARTURE_AIRPORT_3CODE        as 实际起飞机场三字码     
,DEPARTURE_AIRPORT_CNAME        as 实际起飞机场         
,ARRIVAL_AIRPORT_3CODE          as 实际降落机场三字码  
,ARRIVAL_AIRPORT_CNAME          as 实际降落机场        
,AC_TYPE_SHORT                  as 短机型              
,AIRCRAFT_TYPE_NAME             as 长机型              
,MP_FLEET                       as 方案机型            
,ABNORMAL_CODE                  as 不正常原因维度主键  
,ABNORMAL_TYPE                  as 不正常原因归类代码  
,ABNORMAL_CH_NAME               as 不正常原因名称      
,DEPT_NAME                      as 不正常原因责任部门  
,IF_CONTROL                     as 不正常原因是否可控  
,IF_POSTPONED                   as 不正常原因是否顺延  
,ABNORMAL_NAME                  as 不正常原因大类原因  
,ABNORMAL_REMARK                as 不正常原因备注信息  
,DELAY_TYPE                     as 延误类型  
,FLIGHT_DELAY                   as 延误标签
,COMPANY_LABEL                  as 集团外部标签 #0 为集团 1 为外部
,1 as 数量
from  dwd_foc_ft_fpo2 t
where t.ARRIVAL_DELAY_TIME>0 and FLIGHT_DELAY=1
and DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'),
(case when '${p}'='日' then '%Y/%m/%d' 
when '${p}'='周' then '%Y-%u' 
when '${p}'='月' then '%Y/%m'
else '%Y/%m/%d' end )
)=
(case when '${p}'='日' then DATE_FORMAT(date_sub(curdate(),interval 1 day),'%Y/%m/%d')
when '${p}'='周'  then concat_ws('-',left(yearweek(now())-1,4),substring(yearweek(now())-1,5,2))
when '${p}'='月'  then DATE_FORMAT(date_add(now(),interval -1 month),'%Y/%m')
else DATE_FORMAT(now(),'%Y') end)
and CAST(ARRIVAL_DELAY_TIME AS SIGNED)>480

order by  CAST(ARRIVAL_DELAY_TIME AS SIGNED) desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="07延误-时间分布" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
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
(case when t1.延误区间分布='(0,5]A' then 1
when t1.延误区间分布='(5,15]A' then 2
when t1.延误区间分布='(15,30]A' then 3
when t1.延误区间分布='(30,60]A' then 4
when t1.延误区间分布='(60,120]A'then 5
when t1.延误区间分布='(120,240]A'then 6
when t1.延误区间分布='(240,480]A'then 7
when t1.延误区间分布='(480,-]A'then 8
else 9 end) as 序号

,t1.延误区间分布
,sum(t1.数量) as 数量
from
(select
 FLIGHT_DATE,
(case when ARRIVAL_DELAY_TIME  >0 and ARRIVAL_DELAY_TIME<=5 then '(0,5]A'
 when ARRIVAL_DELAY_TIME  >5 and ARRIVAL_DELAY_TIME<=15 then '(5,15]A'
  when ARRIVAL_DELAY_TIME  >15 and ARRIVAL_DELAY_TIME<=30 then '(15,30]A'
  when ARRIVAL_DELAY_TIME  >30 and ARRIVAL_DELAY_TIME<=60 then '(30,60]A'
  when ARRIVAL_DELAY_TIME  >60 and ARRIVAL_DELAY_TIME<=120 then '(60,120]A'
  when ARRIVAL_DELAY_TIME  >120 and ARRIVAL_DELAY_TIME<=240 then '(120,240]A'
  when ARRIVAL_DELAY_TIME  >240 and ARRIVAL_DELAY_TIME<=480 then '(240,480]A'
  when ARRIVAL_DELAY_TIME  >480 then '(480,-]A'
  else null end) as 延误区间分布
,1 as 数量
from  dwd_foc_ft_fpo2 t
where  t.ARRIVAL_DELAY_TIME>0 and FLIGHT_DELAY=1
and 

DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'),
(case when '${p}'='日' then '%Y/%m/%d' 
when '${p}'='周' then '%Y-%u' 
when '${p}'='月' then '%Y/%m'
else '%Y/%m/%d' end )
)=
(case when '${p}'='日' then DATE_FORMAT(date_sub(curdate(),interval 1 day),'%Y/%m/%d')
when '${p}'='周'  then concat_ws('-',left(yearweek(now())-1,4),substring(yearweek(now())-1,5,2))
when '${p}'='月'  then DATE_FORMAT(date_add(now(),interval -1 month),'%Y/%m')
else DATE_FORMAT(now(),'%Y') end)



) t1
group by t1.延误区间分布
order by 序号
  ]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="09延误-不正常原因" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
<O>
<![CDATA[月]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
case when ABNORMAL_NAME is null then '/' else ABNORMAL_NAME end  as 不正常原因大类原因  
,count(FLIGHT_ID)                       as 数量             

from  dwd_foc_ft_fpo2 t
where t.ARRIVAL_DELAY_TIME>0 and FLIGHT_DELAY=1
and DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'),
(case when '${p}'='日' then '%Y/%m/%d' 
when '${p}'='周' then '%Y-%u' 
when '${p}'='月' then '%Y/%m'
else '%Y/%m/%d' end )
)=
(case when '${p}'='日' then DATE_FORMAT(date_sub(curdate(),interval 1 day),'%Y/%m/%d')
when '${p}'='周'  then concat_ws('-',left(yearweek(now())-1,4),substring(yearweek(now())-1,5,2))
when '${p}'='月'  then DATE_FORMAT(date_add(now(),interval -1 month),'%Y/%m')
else DATE_FORMAT(now(),'%Y') end)
group by ABNORMAL_NAME 
order by 数量 desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="10延误-航班对象" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
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
(case when COMPANY_LABEL=0 then 'O线'
when COMPANY_LABEL=1 then 'IBU线'
else '其他' end) as 集团外部标签
 
,count(FLIGHT_ID)                       as 数量             

from  dwd_foc_ft_fpo2 t
where   t.ARRIVAL_DELAY_TIME>0 and FLIGHT_DELAY=1
and DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'),
(case when '${p}'='日' then '%Y/%m/%d' 
when '${p}'='周' then '%Y-%u' 
when '${p}'='月' then '%Y/%m'
else '%Y/%m/%d' end )
)=
(case when '${p}'='日' then DATE_FORMAT(date_sub(curdate(),interval 1 day),'%Y/%m/%d')
when '${p}'='周'  then concat_ws('-',left(yearweek(now())-1,4),substring(yearweek(now())-1,5,2))
when '${p}'='月'  then DATE_FORMAT(date_add(now(),interval -1 month),'%Y/%m')
else DATE_FORMAT(now(),'%Y') end)

group by 集团外部标签
order by 数量 desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="11延误-机型维度" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
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
MP_FLEET                       as 方案机型  
,count(FLIGHT_ID)                       as 数量             

from  dwd_foc_ft_fpo2 t
where t.ARRIVAL_DELAY_TIME>0 and FLIGHT_DELAY=1
and DATE_FORMAT(STR_TO_DATE(DATE_STD_FORMAT, '%Y/%m/%d'),
(case when '${p}'='日' then '%Y/%m/%d' 
when '${p}'='周' then '%Y-%u' 
when '${p}'='月' then '%Y/%m'
else '%Y/%m/%d' end )
)=
(case when '${p}'='日' then DATE_FORMAT(date_sub(curdate(),interval 1 day),'%Y/%m/%d')
when '${p}'='周'  then concat_ws('-',left(yearweek(now())-1,4),substring(yearweek(now())-1,5,2))
when '${p}'='月'  then DATE_FORMAT(date_add(now(),interval -1 month),'%Y/%m')
else DATE_FORMAT(now(),'%Y') end)

group by MP_FLEET
order by 数量 desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="ds1" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
<O>
<![CDATA[周]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
date_time 	as '日期'
,range_time	as '日期类型'
,type_list		as '包机类型'
,area_list	as '国内国际'
,zhundian_per_tb '包机准点率(全口径)同比'
,zhundian_per_hb	as '包机准点率(全口径)环比'
,zhundian_per	as '包机准点率(全口径)'

,lease_flag	      as '包机湿租航段量' 
,foc_wheel_time	as 包机轮档小时 
,flight_unnormal_control_2	as '包机执行不正常可控航段量' 
,flight_unnormal_control_12	as '包机执行不正常不可控航段量'
,flight_unnormal_control_1	as '包机执行不正常航段量 '
,flight_return12		as '包机返航航段量 '
,flight_return		as '包机返航次数 '
,flight_plan_tb	as '包机计划航班量同比'
,flight_plan_hb	as '包机计划航班量环比'
,flight_plan	as '包机计划航班量'
,flight_operation_cancel	as '包机营运取消航段量' 
,flight_normal	as '包机执行正常航段量 '
,flight_diverted12	as '包机备降航段量' 
,flight_diverted	as '包机备降次数 '
,flight_delay	as '包机延误航段量'
,flight_cancel	as '包机取消航段量' 
,di_chapter_label_internal	as '包机国际航段量'
,di_chapter_label	as '包机国内航段量 '
,chuqin_per_tb	as '包机出勤率(全口径)同比'
,chuqin_per_hb	as '包机出勤率(全口径)环比'
,chuqin_per	as '包机出勤率(全口径)'
,block_time	as '包机空地小时 '
,assess_zhundian_per_tb	as '包机准点率(考核)同比'
,assess_zhundian_per_hb	as '包机准点率(考核)环比'
,assess_zhundian_per	as '包机准点率(考核)'
,assess_chuqin_per_tb	as '包机出勤率(考核)同比'
,assess_chuqin_per_hb	as '包机出勤率(考核)环比'
,assess_chuqin_per	as '包机出勤率(考核)'
,air_time	as '包机空中小时 '
,act_flight_tb	as '包机执行航段量同比'
,act_flight_hb	as '包机执行航段量环比'
,act_flight	   as '包机执行航段量'

from ads_szh_flight_yunxing

where type_list='公司' and range_time=
(case when '${p}'='日' then '日' 
when '${p}'='周' then '周' 
when '${p}'='月' then '月'
else '月' end )
order by date_time desc
limit 12]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="运行指标-上个月/周/日" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
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
date_time 	as '日期'
,range_time	as '日期类型'
,type_list		as '包机类型'
,area_list	as '国内国际'
,zhundian_per_tb '包机准点率(全口径)同比'
,zhundian_per_hb	as '包机准点率(全口径)环比'
,zhundian_per	as '包机准点率(全口径)'
,zhundian_per_total as '累计包机准点率(全口径)'
,lease_flag	      as '包机湿租航段量' 
,foc_wheel_time	as 包机轮档小时 
,flight_unnormal_control_2	as '包机执行不正常可控航段量' 
,flight_unnormal_control_12	as '包机执行不正常不可控航段量'
,flight_unnormal_control_1	as '包机执行不正常航段量 '
,flight_return12		as '包机返航航段量 '
,flight_return		as '包机返航次数 '
,flight_plan_tb	as '包机计划航班量同比'
,flight_plan_hb	as '包机计划航班量环比'
,flight_plan	as '包机计划航班量'
,flight_operation_cancel	as '包机营运取消航段量' 
,flight_normal	as '包机执行正常航段量 '
,flight_diverted12	as '包机备降航段量' 
,flight_diverted	as '包机备降次数 '
,flight_delay	as '包机延误航段量'
,flight_cancel	as '包机取消航段量' 
,di_chapter_label_internal	as '包机国际航段量'
,di_chapter_label	as '包机国内航段量 '
,chuqin_per_tb	as '包机出勤率(全口径)同比'
,chuqin_per_hb	as '包机出勤率(全口径)环比'
,chuqin_per	as '包机出勤率(全口径)'
,chuqin_per_total as '累计包机出勤率(全口径)'
,block_time	as '包机空地小时 '
,assess_zhundian_per_tb	as '包机准点率(考核)同比'
,assess_zhundian_per_hb	as '包机准点率(考核)环比'
,assess_zhundian_per	as '包机准点率(考核)'
,assess_zhundian_per_total as '累计包机准点率(考核)'
,assess_chuqin_per_tb	as '包机出勤率(考核)同比'
,assess_chuqin_per_hb	as '包机出勤率(考核)环比'
,assess_chuqin_per	as '包机出勤率(考核)'
,assess_chuqin_per_total  as '累计包机出勤率(考核)'
,air_time	as '包机空中小时 '
,act_flight_tb	as '包机执行航段量同比'
,act_flight_hb	as '包机执行航段量环比'
,act_flight	   as '包机执行航段量'

from ads_szh_flight_yunxing
where type_list='公司' and range_time=
(case when '${p}'='日' then '日' 
when '${p}'='周' then '周' 
when '${p}'='月' then '月'
else '月' end )
order by date_time desc
limit 1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="O线" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
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
date_time 	as '日期'
,range_time	as '日期类型'
,type_list		as '包机类型'

,zhundian_per	as '包机准点率(全口径)'

,chuqin_per	as '包机出勤率(全口径)'

,assess_zhundian_per	as '包机准点率(考核)'


from ads_szh_flight_yunxing
where type_list='O线' and range_time=
(case when '${p}'='日' then '日' 
when '${p}'='周' then '周' 
when '${p}'='月' then '月'
else '月' end )
order by date_time desc
limit 1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="IBU线" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
<O>
<![CDATA[月]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
date_time 	as '日期'
,range_time	as '日期类型'
,type_list		as '包机类型'

,zhundian_per	as '包机准点率(全口径)'

,chuqin_per	as '包机出勤率(全口径)'

,assess_zhundian_per	as '包机准点率(考核)'


from ads_szh_flight_yunxing
where type_list='IBU线' and range_time=
(case when '${p}'='日' then '日' 
when '${p}'='周' then '周' 
when '${p}'='月' then '月'
else '月' end )
order by date_time desc
limit 1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="国际" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
<O>
<![CDATA[月]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
date_time 	as '日期'
,range_time	as '日期类型'
,area_list		as '国际国内'
,zhundian_per	as '包机准点率(全口径)'
,chuqin_per	as '包机出勤率(全口径)'
,assess_zhundian_per	as '包机准点率(考核)'
from ads_szh_flight_yunxing
where area_list='国际' and range_time=
(case when '${p}'='日' then '日' 
when '${p}'='周' then '周' 
when '${p}'='月' then '月'
else '月' end )
order by date_time desc
limit 1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="国内" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
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
date_time 	as '日期'
,range_time	as '日期类型'
,area_list		as '国际国内'
,zhundian_per	as '包机准点率(全口径)'
,chuqin_per	as '包机出勤率(全口径)'
,assess_zhundian_per	as '包机准点率(考核)'
from ads_szh_flight_yunxing
where area_list='国内' and range_time=
(case when '${p}'='日' then '日' 
when '${p}'='周' then '周' 
when '${p}'='月' then '月'
else '月' end )
order by date_time desc
limit 1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="时间维度" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
<O>
<![CDATA[周]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
date_time 	as '日期'
,range_time	as '日期类型'
,type_list		as '包机类型'
,zhundian_per	as '准点率(全口径)'
,chuqin_per	as '出勤率(全口径)'
,assess_zhundian_per	as '准点率(考核)'
,flight_plan	as '计划航班量'
,flight_delay	as '延误航班量'
,flight_cancel	as '取消航班量' 
,act_flight	   as '执行航班量'

from ads_szh_flight_yunxing
where type_list='公司' and range_time=
(case when '${p}'='日' then '日' 
when '${p}'='周' then '周' 
when '${p}'='月' then '月'
else '月' end )
order by date_time desc
limit 12]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="时间维度-优化" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="p"/>
<O>
<![CDATA[日]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select * from
(select 
* from (
select
 a.range_time   as "日期类型"
,concat(a.year_code,"年")  as "年"
,a.month_code 
,concat(a.month_code,'月') date_time
,c.flight_plan as "计划航班量"
,c.flight_delay as "延误航段量"
,c.flight_cancel  as "取消航段量"
,c.act_flight  as "执行航段量"
,c.zhundian_per as "准点率(全口径)"
,d.zhundian_per as "去年准点率(全口径)"
,c.chuqin_per as "出勤率(全口径)"
,d.chuqin_per as "去年出勤率(全口径)"
,c.assess_zhundian_per as "准点率(考核)"
,d.assess_zhundian_per as "去年准点率(考核)"
from 
(select a1.month_code,a2.year_code,a2.range_time,a2.type_list from dim_rz_kq_month a1
inner join (select max(substr(date_time,1,4)) as year_code,range_time,type_list  from ads_szh_flight_yunxing  
            where type_list = '公司' and range_time='月' and range_time='${p}' group by range_time,type_list) a2
on 1 = 1) a
left join ads_szh_flight_yunxing c
on a.year_code = substr(c.date_time,1,4)
and a.month_code = cast(substr(c.date_time,5,2) as signed)
and a.type_list = c.type_list
and a.range_time = c.range_time
left join ads_szh_flight_yunxing d
on a.year_code = cast(substr(d.date_time,1,4) as signed)+1
and a.month_code = cast(substr(d.date_time,5,2) as signed)
and a.type_list = d.type_list
and a.range_time = d.range_time
order by a.month_code
) t1
union all
select * from
(select 
 a.range_time
,concat(b.year_code,"年")  as "年"
,substr(a.date_time,5,4) month_code
,case when a.range_time = '日' then concat(substr(a.date_time,5,4),'日') when a.range_time = '周' then concat(substr(a.date_time,5,2),'周') end date_time
,a.flight_plan
,a.flight_delay
,a.flight_cancel
,a.act_flight
,a.zhundian_per
,d.zhundian_per zhundian_per_1year
,a.chuqin_per
,d.chuqin_per chuqin_per_1year
,a.assess_zhundian_per
,d.assess_zhundian_per assess_zhundian_per_1year
from  ads_szh_flight_yunxing a
inner join (select max(substr(date_time,1,4)) as year_code,range_time,type_list  from ads_szh_flight_yunxing  
            where type_list = '公司' and range_time in ('日','周') and range_time='${p}' group by range_time,type_list) b
on substr(a.date_time,1,4) = b.year_code
left join ads_szh_flight_yunxing d
on cast(substr(a.date_time,1,4) as signed) = cast(substr(d.date_time,1,4) as signed)+1
and case when a.range_time = '日' then substr(a.date_time,5,4)
         when a.range_time = '周' then substr(a.date_time,5,2) end=case when d.range_time = '日' then substr(d.date_time,5,4)
         when d.range_time = '周' then substr(d.date_time,5,2) end
and a.type_list = d.type_list
and a.range_time = d.range_time
where a.type_list = '公司' and a.range_time in ('日','周') and a.range_time='${p}'
order by substr(a.date_time,5,4) desc 
limit 12) t
) k
 order by cast(k.month_code as signed)  asc]]></Query>
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
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteBodyLayout">
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
<FRFont name="微软雅黑" style="0" size="80" foreground="-15378278"/>
<Position pos="0"/>
<Background name="ColorBackground" color="-15378278"/>
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
<LCAttr vgap="0" hgap="1" compInterval="0"/>
<Widget class="com.fr.form.ui.CardSwitchButton">
<WidgetName name="8ebaf142-d59e-4025-945d-673f719c3556"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[运行情况]]></Text>
<Hotkeys>
<![CDATA[]]></Hotkeys>
<initial>
<Background name="ColorBackground" color="-15386770"/>
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
<WidgetID widgetID="b8a11379-ca74-4a6d-8f4d-8f012e0105cc"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
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
<Background name="ColorBackground" color="-15378278"/>
</WidgetTitle>
<Background name="ColorBackground" color="-15378278"/>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.cardlayout.WTabFitLayout">
<WidgetName name="运行情况"/>
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
<WidgetName name="绝对画布1"/>
<WidgetID widgetID="f426dc3d-1921-4422-9441-7aa088857e08"/>
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
<WidgetName name="准点率-同环比"/>
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
<WidgetName name="准点率-同环比"/>
<WidgetID widgetID="8386eab8-e26e-4065-b320-54d97316abc0"/>
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
<![CDATA[762000,723900,762000,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3870960,2315520,2164080,2315520,1645920,2315520,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[全口径准点率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="1">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="包机准点率(全口径)"/>
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
<C c="2" r="0" s="0">
<O>
<![CDATA[环比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="2">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="包机准点率(全口径)环比"/>
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
<C c="4" r="0" s="0">
<O>
<![CDATA[同比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="3">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="包机准点率(全口径)同比"/>
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
<C c="0" r="1" s="4">
<O>
<![CDATA[年度值]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" s="5">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="累计包机准点率(全口径)"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.ObjectCondition">
<Compare op="4">
<O>
<![CDATA[0.903]]></O>
</Compare>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-486008"/>
</HighlightAction>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="微软雅黑" style="1" size="80" foreground="-486008"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="4">
<O>
<![CDATA[目标值]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="4">
<O>
<![CDATA[90.3%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="0">
<O>
<![CDATA[考核准点率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" s="1">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="包机准点率(考核)"/>
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
<C c="2" r="2" s="0">
<O>
<![CDATA[环比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="2">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="包机准点率(考核)环比"/>
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
<C c="4" r="2" s="0">
<O>
<![CDATA[同比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="2" s="3">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="包机准点率(考核)同比"/>
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
<C c="0" r="3" s="4">
<O>
<![CDATA[年度值]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="3" s="5">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="累计包机准点率(考核)"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.ObjectCondition">
<Compare op="4">
<O>
<![CDATA[0.965]]></O>
</Compare>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-486008"/>
</HighlightAction>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="微软雅黑" style="1" size="80" foreground="-486008"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="2" r="3" s="4">
<O>
<![CDATA[目标值]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="4">
<O>
<![CDATA[96.5%]]></O>
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
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="80" foreground="-1"/>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[!?h[(q2%pC7h#eD$31&+%7s)Y;?-[seGoRL;[<R-!!!;(6:LqT"mANG5u`*!mG1QS'NH+Xn1
@H>5tsEs]A+l9@VAc4!%111r+>GVG%qB/4c'Bgt[*a,[K2E:>X$OY&P%sCXpP+:NGd'[J.%2!
J-7!>gK*Un?!=hAr#,>klTDEohDXGT4mdBH0DeAioaX7Oanp<%em<`bphFoELXO^%HBhtp.q
t^UhkonfZ0-$UEg58YY^Ac%?ocufiBYmgH2#f\XT<1KY)&q_af$fpT)]Aa-1A^`j+NGb;)hf:
);%s$jiFVOd*5Obm2d00J3;##\2%Wk8)U8DN0k7I%A^DoJ\%k']A"5M:DNg#*Y1S5dujFb=k/
Pm4,c1.Vos^c^hek_@8$?-G+RP?d1Yr'19^L\LEcm;Dn1knq[Pp8toiQ[,2r%h(]AO8tWLSnt
krBZ@0:hq^+iJV2$ii,:`oV1tf`=]Ak>:h!2'@;3I&L5pT/+9SoVA1]ARSWeh/Rs7Z5*=GAa.p
G"H&OnmmqX>TK-\UpK;8NQmc;3.K-i*7ff'6-]Ap3.2Lfj:,/m3hB;@Tp+G'8hhq*:;AS$MkU
cSc'Ci%A)IEUmgW&BuCo<Rh_#]ApD=PcZ>U5#K#C>.ETO!Z_>u!_ZC7W(c_bnjVe<!(74n;Y0
n1EJ#m6ErmaWdJGdhC9iNqF\o_qJB/Y_<)o_FT/Ok/%1lr?J!\lN>>juB`RERMnY-&Yc3k]A4
/-Sj?k"B-(Km`l&b1C.O`<*u3SYa@Z(b,'`,O$BQikufM0pC"TTsB+#.pXDcgfPW".iYEFQS
.=JSWbZ;+EitZb0NsXD\k&:+GO]A$^QuRdekre]A\i>5MiaCSB&ua"BV2MVN"/m7'B<WX\3%kF
Hg<#MYJ@s:pO$HPBYu^Fg(n?uqVuog[4I%==F=E5p!/+u8rRTJIb+j+-`;h08U9BLPWCOmb!
D!2pdI2dI'qDFnV2G@FMR4I9bafGd9,@Yk'H*N\29Wa1V$d;p$<mZ`AR7JM>mN\nfY63Np/E
E8$NWd*>L<g-]AM]AH:IX%aDQ,4?P!;45ceJi+tqFA+.JE.h.1Y$F7K`EBOU>=sDg,%`B!$m8m
SLO/J;t30SP![Rf-</l[(BT[<:RTt%5);HI!/Y*Tn8)^:]AQ>:s8Wi_!)pQ'GcUeoSO;-jQRH
B[D-X@!C1=5gG+[n?ROtR"^rcj%kGl"Zuk'^3Rq`I,go\-B:51>;X"TcPG>3Yos5Oo[^l2eb
B#<HH`AW?bK(Bb:^M@PueSKO8'`(RmEie7EO'sI>R]A_+Vsie7EOPjQlPo0R#$K=drf",J1C;
gS7@P]A"Po_=K,VWlLfZl23d]AQ[lf!7Cka7=Aeq`p8toIc;:pZZl7!N!NMf+s."Y/2-Z&t(CC
]AeQ:DnW%9:F&F+\S.!&=#c]ARdq9"]A.3`l.[Zt<Q<YBoA8acl(S3Qb++j&3)KY"<n&L&3'\/m
*^K#q>uc[&g:ZS]ArWO[G3rfgL*3*8oJL\+8Y9/ko!'mp<Yr1;0/ZUm2VE%6Za`dkQSpC:5j5
k1d'e%Nlh7hu5h&VXG&:cTAl0Y/H<G_TVY2L8aXE:??Ut@lu/Uu5cLh<XEG$[s>89YP/^k#H
<[FR33`TARhEGlsN,WnF7b4LXoBLneRNV?M8,?V08I(AO92m%f=Wn@)2gOc7E,T0B!#9A"rA
Q&Y1ChYbK#;0=J&ojR6;XWbsV?Uc^=P^krENm0?*X%">0]A,6cm7lE?nl=GU2YCFq_<R@.&:c
IYHeQ]AK-daXH^SO*,Sr4PO*ZT^1n.pakV]A?5YA0/=mUPit(oK#/V(EY2Y$^b8c%;'nje'bM#
XE!MW7GV5D2q!<`0Uo3:C%Ltl%X6QfN_,4IZGl(Z2fiV<jk8suoROfq<-\8F\M7@:SRP[n)U
g$;19S?S41U'Ch-K1(jO?jma8+WUU^%t#Xmd3+FMci2c(D%tbTY`J+7uqPq<Q85Um[kIIf\-
;;S'Xa!D3=l!!#SZ:.26O@"J~
]]></IM>
</FineImage>
</Background>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="80" foreground="-1"/>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[!@e<(q2%pC7h#eD$31&+%7s)Y;?-[seGoRL;[<R-!!!;(6:LqT"n>/P5u`*!mG1u[**!g\n8
54,_$ege6+g2/*t!nh6Nuf;79U$20>Rn@B$[P5$@._j>,h^R'H^<(;A>%kJjaAIS;h;M[+8+
di_*9JWO?8)'!pcF-:Vi(B)KB6DA0@elt0o)S!j0br+M_>GD>qVS=,m--^/7CleW5DRFA!Tb
1Ib2]AC"[0BAE7(\7)6$EVb.bcj[XLpjVf/^=)]A_:YXK$_*4UajdS@/K,*dbf3?riqgUUrRF6
KtUtqWI^@XjLV2OcX&Z+<Q.do:c06l_t1u(2V]AUCnO!X5PKI5(b7U2V-J;/AmL^Ul`l.grf+
#0Rh2Yknc]Al%J\_"/s*s9c'GX]A^P(;db1U64C=p-4c5@.P)*^M8!NO*1-r-<3_Pa(/!_fc0^
Y4@0EB@lC#OCg5C/o7T]Ai*<DOTurl&,QR'cOIiX1WplqpRsNUo3$LkmIL<$N+X&>O_)q>Ft]A
fK&tt7#l2aJZjMdps3bCOXt>4q[!bHU_Z4PKm?Z<LMPkjA^+A,4J2YRdgqt_c'M\CpQL5`C"
M4>'dYP:Sg-?Oj6b6b-U9pCdq9eLP#uj[sCQrgMnP0)j;oTm<orLjkWj`hHV!"["l-9:I"V!
.IRL0eS-(gOl"@1aQNSV+S5gfKA$Y'3LU$YX8:BQ5W)9j6f'e^UNVYJW;L,.k)s'Fra!TM@q
kSg[,e.np$eV*fh^1`%adr'M<Tun*BpPTgqO8q*@r28;Z/*B]A-ALWf>>.RgdUeo(EZ+qdLek
6ecO=9'[Mn)&g%!Ojl6(n8bP1-jdej+M-bH%lI*^Ja62dafe9(b^k#EVnA>-4nIWO+0J(C#t
/choFmO8"^*M^:ppMl2Lq3+J2i$4;<\BKMV6NaFR74JhF\i^Ekn*1n0(2,`D&.=gPppL5FF]A
T4m&[h(1u+R-934Bt=K9C'NS!D!=[-MmE>B4OuUUr8/l8."/%,nljp-!q'G)Q:;uB85Q"]A;,
f88.RqSWLSqt?3ieWn7G6+.eeR;+TQ4Rfttt^mT8X>!)c2=GBs&J`!ZT:$"[p:K8$Z4Onsag
r_:D*&:g"LqtZXp6G="]APgHSS,Lu8BK`Ip%dd@3dVE-24#XE^gSJ3R?o*5gA5%L6P2(2`95\
ff)g\C%M+?GdkJ!I978f%Pj(:h9P:"]A(A+A."(X"nG:>pWe_5RPl>mmstS96b42Libo_8Z/q
BJ,0pl7_0^mj=<AJIEUfUnc]A%>)fMH-4]AL$+(Bfh9[a`tPXI.`9R86Z/p1O3<!"qoY?+$SZ)
#L=X@/rlqD.cSAZGt]AQ?5Pp_rUjR'FFHr_:;'gq*.n:n&k-O3G&<mI^Taq<8J_Yo1c-'*12!
P3pAAnZ%P%OXT/,h=T&n37Wpk^rHV:qHJ>?#qn!Z13Pnt3gj_JOiGZ)+TJ@M@Wh2dh"53ci'
7OrumeMTs!gZAP:C/;IVV2GP6/#D'GFcTGL7]AUCSK`f7o_7ub=5]AQ*A"tM]Anil)#<$p@8NDE
(JCVXj.5lsL2T7;6O#4hQ*gTrJ5'-S5Ci7K^o4V?4_rQa?:_gX;VnOJ[t`WTcZJS'$du7R-B
$ktV7MU&4j4%5;E`(+O5"+X?sDZ?570g5TIl4nR^c7?IeSgA(7NH;H[Uh+<-?i>ER&37a6X<
?"0$i=Ei1'QB^cg9,:,TW0SFE9erTA($nPBGLNT0W4k,D$a1LAIIo1RVNt.mQ<c,lql/\Mcs
r_2WGTPYWe5b#QW91"$:`bO[u.FXfjB[*e#i&"1]ASc_Dg6C!RWUGCgDb"CT4P!V(W<Dj6TP?
l<QG<Za\*>0n'?jj;jDu:]ALm.qm4;u.NP#T>.?TU"tKI*q$RE]ANOG&C90YZ0AhA"@r-A:@B<
EEJ$OTOnFpF7T]AtEE$3YRW6T!r<kh+/Q6Ne0/SSc+_toV'S0.=TYfnb><-qoK67X$-+D2J#L
)<=WJRA,?d[1b0/sJB,q8!!!!j78?7R6=>B~
]]></IM>
</FineImage>
</Background>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="80" foreground="-1"/>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[!@%g(q2%pC7h#eD$31&+%7s)Y;?-[seGoRL;[<R-!!!;(6:LqT"mSZI5u`*!mG2Vm>?)LFn@
1D92\?aHkSP]AtU7sD>qaGH0iX761<>d"'Zm[-$,j4#"Q)dRr1>4i<X51qNV@u2(O+,`O_Bp`
@Zuc0W>g?&:9:`9rX%[VQp_'3_RbG9Y9lcF[pYPl[r)a/5IEj/=Soa>S8L.Kh3X,g)42,T25
/"b?3Bhl1J'TR=O#r*AnE0j<]Ap,_Ho(V>NJ%(@lFGN0Mi6SU*]AO'o8qc:)hHf"DG3Sq(njjT
tES.?U7J!N:f0L+7+EPV;%?g+K:^6R-WW2nUgGpM+bSbQ(YJ-&Eb!W.M!aa`NAbjEh=WN()Q
HS4G'obE8A&0*rcg!LV0%9ImbcU-78063a"ncoMp7YZ)1R[u%+F#;FWW)Yr8I49VQ!.lnHME
NDZVhAh@%q+2rZ!qB:EbP(8eu,KD3036tNq`VTBEB5'L=FU&=0sMS?GTj=%&Kd^%a\10`k$5
ZlWXuMrdjNrG8Qu1-<.^':%K!/VgLu.L7k:A/]A4p#PA6JfD+^Zb:atW=!_?/%*c:ZjbOtO\d
N&E$Ab9DLFP"s\"DWTjo+:\\Gc(P;)8.nHT^862`B/OF3s-$,Y#"?bKh@cWCXSaR#ao&b?=.
j:H`k2+:&sJ:g"T$)-`VFfSG#Sl%hMd@]AY:kP9W<F9+mG^%6Hs3$46S8rHBdFJm9B+T!CDj=
`@(o:5k^qV4[VEr-tP&P8J_aG'e6,RRl+.BO4pCf"Gd]AfR"ucAAtJi:]Ai2L5J>h_Td;9U#jc
0aS`)FG"dKK\?%rIqIl::1%MZ\d2?RsuLWsjCrK&Qd).@7TK/5Y16!uGA1#>dW+PkrST;g;U
U+K/d]AB*"8n3WqkP6sA9%@dqSU5]AA09IX6#tQ1^I$&J'Br0`'U7W9f3gnR;K-5T)^e$rtG\S
rkW0+:`W6om?4>"fLYql!aYPU3hPG:FKSb-X@!C>U3&?NeCp+F6Q!ki^2bT:Y9G^7_0.]A(ti
<#;10O<63-#]AkZ@/(M:b]A?TL"giRhE7#$d_G/Z(_"u^(>hI(pIeUha1-F5V1Pn7W#)!8f%O?
+10Ejs2O+-!Jh!4V_3=c;HC@?J@KQ>qB\4$m?9.*+>3""T']Aju>GV]A.Ll55mDRMLR]A$c94`.
`VhB#;[Ua/'.ELl$u1-\(NDM=SUc_uP3Dq::nSrMZst4@!k(:Z%PtP7SE2&8?#g5<M).GbcB
'T[[Z4b,J4j7t@ED!f/VDV/Q1Ae-k+7*j(Gq(BtFNG.(Id/"Q(UK`OT,b4i'<[$Ar8dY.]AiP
+f.<>EjF=]Ag[0Q"[G67olC0l2$Gi/VL3ppdD9Ut^\H,T1PX$mU"+D#*h[h&#LXIlp"sGZpIH
)-&/?[uf?P86j=oC8>pqr`(cj?`TJ0OM<)8q+S^iKFhg6TGn5&;C!CFuV^8_98C<EFqn\P=D
aNth%aAhQ#3r7-Ur#Zmlmf5W:OB6Lr8hFW<&bun:KSSA0`uEjB[-ga*7kC:@8Tt:[%.*\_Y0
#H3-r@?pNqY*b?k#\O#XBH5%ihNGlhYMBFhB[q-/U-O)9V06'lTNMdbK6H0'2E*d[^JR24gf
7m2-gFgsA<OR`\PjmL=jFK\'(VP!b_*2^M:sk*Yf4#StVh4>Zl'QTg`m2,I5fo(?L[$::g3g
@&VM<jX,KV5A9T2bm[E//d1/A\BBA%90<LRGOtbT=tn%#QP<AY=%")9uG<Je_4@'p%c`X/U]A
kaK!>-ZfuK[P_t<uKKs`p1+-o)M!&^0L_JEo>.J'47]As),m-bb5N2(j?^!+oZ;HE9=kgjb`6
DQ7G0or_*V\G.;s#7mJdTbI.e8):nn<&uE"2.#dK9_qdrF1oO5b)%3:R$[0oQgKdk.::sWG#
kdqN<>KjAZg(?2(kX_rO^\NOlB?fkgRrb*[6WZ6h\3Yp?$;mIXPrQZK9cf;b:?R@$`1Ar2Tc
!LNREP00ClVz8OZBBY!QNJ~
]]></IM>
</FineImage>
</Background>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-8988015"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-8988015"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<j=IdeDI>4.U(u;quQB?;.3HW>8Oc9[-XZY2!ii'h+rc:!M+N`-aiReoB0@(Te+J9[V([9I
S-s'j+VQ?qP-jMFsb%MMe-Y]AKb%lcInN&ms4>mh.PR:7j;2cq>RPSpN'W4lZ6A,U[M5:e+YE
MRl+uIkuV5@Z$k3)G9O;)c/(4r8H6ou;]A?4jR[%U]AeJB:2\4a_F*iVG19UeKZqP"f?X*meA8
`m*;?gp5Xp@S7;7<;4B33ampdU1nB43P'WNT?jq/Ji<>IIeKJ2.tNZmt591DuAki-Z_K/S8d
VGKoN#%IXEO6`eR.K^.:<^l1Q'+0sT.(lfA:;Q`dC=5$\=QB[;EkqdY&[FOq]AH>'Kj4O$E$R
gGu8"0dDsE5.,(R'%D>\n-9S+OD]AY$&)?!Zm]A[9X5JaMDc<:d#T^BVqOJI@ifX+(lU*n?:lD
\`P4j1UP99@W`+n4[UFf4[-asN'n6Zmc95ONaad6@Us!kNK?40c-7c3`QS>2_AZc-7cW;Ks^
0UMRQCMr!m?Rs%ek-NAC"9VdU[[Z.lCnn/'X<DoPM>gE1FDEVcXYQ@n-_`Ueu?$RiCKG]A\2_
t]AVjX+c%Ki/qBF6Cu)`c,qG8]A=7*2LG\VOD\pULjj[JPnW;XEIJQ6*:/d(jQH_,_G4Qb;Bp`
9[`LC]A#]A*B;1"V7ne;"C*X:Hqr'n#I#P&esOFD23mS[(NJV5W_3%)RTPL$<`9pJ2pA:&=T4*
mjae"`0!OE!.niU"prh_lYD1JR^B&rAV.6=o-\!lq5"@8iE[<KC$?\GE9[!J,BmTpDVZ+h[=
.,+O^5^^PkeVFCmV*m[b(eF?m2ROL,WO[kp?sZ(&OF0[p!=aoXR==&P=V1P9'3q$_)S^D94l
Z8X(AVhf@K0pQ:A>q@h)tgWZnH,1kZ.LmCNRKLUNJ_J@Sh0QiuX]AA&n$eFX8K'k,XPh+F`IN
4(-W]Ao?WqTR6A:@q%Eq]AfS)qEnYfq=cKm+30F4n-VudZ;$im7fN!.gQdKh$s/>V?4QFF.-"U
*(`4d=O17hlYg\+lW)M>PiIl,0SY!%C,pW\<s+iZpg[L4S>RsiWO8kmi;-k-@7S]Au6,ms;%=
mA'oe8bZB&--98f[_7j,,hu-ZYTh881Lj)%bq"d1q9f8X]Au%B'q:T)DpkXI1U&V4]AX7Amr]Ai
,QsE?L&PbZZg+D4JC[M2k.)QWkB)MKhtmoZf,*@E&9#[VR=?Z`:`3J)ur^c^+LO1Ph`oqet>
0gjK!(,EF(j[mt`PO3R*LMiI6I/E.K0hN`4]An)S5]A&,AIcnHalI>'hmVMZNOaf'MIZLWoXsR
G#[N#bs"(HXGq^nm>2\>?N6>BQ?"(Di=WF91-J+HS=j=F.Yks/eG3elU%O\'CG\7FBu,'o(g
r@5uRA.Bo\?\G+:(t[!>5'4OrZkOXWGkbHi:s]Ak='(#Hb8iL\-Tebdc*"mG,/`1N;qj,7*;)
mJMOd7p7V$R$a_8P\W%OU3,jZs6OQ>i`F46iXl?;/#PPq:e@#CP/S<YSV<UF49Tc)E@W7skX
So/:;72JQdL]A@H^tBFB*<XJ`D(91Rsp[PS*sC>d>%H/lB;,PUV]AuFYa]AQ[f9gfBZuC*V\]A2R
ag</4bXXHO:SN_%4Obs(Xi4k@a#qI[\D5>?f*Ec5m:=IDuAo=/Tgrql%Uu05TOT/Ch*q:6jd
S?G!TCQ'hHt:URG\GORU)T'N;4HR(BC3GAAMFEtArn<D)G:a8;(k2`rE'$r7n:P`bLE6]Ag(1
d'oTg'.+3ZeIQKoA[9aakXVfNnVZLAd%_?-YoVjuttigso'a%:T3`9PAXf=3kaO)6$u\4P[@
eZD/8Qt'VR%WS3;$"QoBWf=APpsTU:/FTV<J:I$pDYJ\9L>cA3&P'KOT2#+R"hmlMCY@S*pu
(NQY0UHA`(e1=agPF!'P<+ef;k\dp8e!?ARF0Tm&KKXlbojBCp-5KP':!upC&[5HIA:HkX3`
TA,!B>[n(.lejH,j=k/u>N6n@[N^b@N(P41+-m+2J&gSEV1fE`&b"Q*5aJJ*DfFVX8H,2;lW
!euu9<:-)^$!I\_CSkDjBfc>1al('!Sh)g-a@0$pB6@Bhi!sB)Tk"I-+SJDBd0X0_44tKpD%
4doAV?):PQ]A$9HYV2]As'gA"fa(>WI#Q&juB&XnhbXq]Ac0>#0#t84.gl*0HQsIVkaAD2mEbu-
,AEqhk\`4R,7eMl(#[!=RjcmANsTg>+j%_O#dTVZ1_FlCmhBJ<NHiY\qj=MDY"g=$W<f)1U\
eAfL_F3EO]A8$A14pg:r@T_(Ci,"2X#a>)-t%0-&0#L5Z@u[eH$m9E52.(s/<h7FY&JKpia6-
)X4r]AOPb4m*.G%;5j=&Le2(Z>E,;CDYn"pBta.Mo:'nA1$;i'JM1Sgc4!TC,\rZbpJG5U1o`
c@CVD?Q&CN<@3P0cPa"^.s:,%>rFBh%An*,S.`94+;sRAJ8U*GLa@oW<&i$XRSMI7@R/Redp
*B@HkeM*>G8i,ZVV*0&(LqOQ=hBS$Wd$7m/TKedX/-`B$\?lIXT,BO%c`HW:Q%2imKKbtP+E
gk)>YS:.T;O*F]Aof\#Lb#^M(@.7.&&Wk9nI^Wp/KFICMAW+5=`@o)YHTo8iX+BIi[%_.No`#
<3,ZRa'hSs^64iB+0nIV]Abh%S,c%+Vmecdh=5$Y#BWP,=sGuJP+U+Hf5&G#`<ZYop\aB9umJ
7Obp!,D)7dl&-S8OpAur)-<<JK,DA%A"JKfp/Wf;5bpd(sl._uCqY5AnlH8TV%me)XEUDcBp
d\7'YnY=mFY!1[G&4"iF0I=;DUJ\o>@tR/WKjlYVoYQe/$(5sO0a2M15rAlr*'&B[0lBNDnQ
]ArcJs:,OcfKEfTK4..q$KpX1>]AOf3IJS<'&YbEYUQ)Y&UXeQL0ZHMPLueE8)CN.n8"[LJ-*5
lt*WP2Yh]AHWXgF=F@.$0]APe&J.sb`?s-;FHpp>ridQB=7!,fZ3miL@%kHsda#0.5.1&KgfLa
Akl/aQDip<0RI/)jpAX_;&hP8.-&lOT#sQ?T%Yb"jIAfX5"4WYHEThdC="=bQ3p^l`[=X-hb
mJque^KB]A,NiD8D$9qtniaQ]AY/^IZ@>8#eO!=d[3()c>+Y2XW]A`1UF1uK(u)KV(KVA'eH.RT
-`T'=4a*?X^+(>gJ6$p\up7)OXVK_?)+2HJ0@1!\DeJeCQ"GF]A;kk5TB)9\qPs:T*-knRlUR
lC?%k_G:6t&%7`724>&M5fpbiK:"7*PDP*%/2W&Q-DCoKR?pH[&0M'ialdVgV[Z25>QLLJRq
iMWkcHa!WG6^H6U5WBQlU70L'g`1Fo_#!Tr1FeUj@:`7&9X)^'P3@/6$7Z69e<5A1SSN0gGK
tEh>)DIlqD$r8V@Z8sf--Ro$Fj\)%$;P`%;ln=>tSY"b3ckqg,R4f@&'@TTI1Y<[M&G%Oi,C
l_)44C!7(Gh_O8:n`C!K#kfC?1Pua@u5bK#T14mji$&:O)LCZ8Vlm:97k9&>tE$3HfA>c88$
C0;D^!o[u+8*>:rQH)#a[%;QUobT_l:imVqtgNn-CU'EPKuS2YgM;IFMrh]AUkXUlRJsl(Fkb
2N'*@4peOUVp7EIXpmN>%ps$BfpMUcS6AIAHFaL[S#QA>!&;5Qk`E$?66$-Tc(aedZU:8%S`
ZF73*_-S)>4(qC%;ZBLM7cr?NU&8s$e?\`T'-DB4>4rm!.H@#(2D,t6-J_$4Y@RX7Z$K93*)
]A_tOUm5L-GEToe5kLA+<.fKMQlb'^+u##n1QJHR,QObhA(udE[4*M?>+Z7s0r,8Un-f0pfPG
8PuBj7Z$T57+HH5+@Zk[=q7(Df'IVr@ju'O7[Fr=0%Mu_ZXNQduK)PUth@cj]Ap'<i+_!/k8^
"pi4Wj45$VpR!I&:;1MM54.QX]AC-Zr5tZ\I&?J6V.FCD2oMUFln1mo;>#$iIYq?Kj/2chfCe
2sbc1HASnCtV'@Mcu?3/dp,*nIhYA+,#qo/=sr"5CjC/A@S-bRkjq"pdqI<Y?]A0$JeZ1p;Y"
8`fD_*BMImaH61T1A\S"0$;"@['f28rZbA,C=/&ID&-J^>Jds%Ws,7g+qlF?b('_B'XF/.<c
@;k0p3OH]AgfQM@E/)jX\H+EY8S!s:h-&jm?c8)mN$,'a\;F?`35":\nD-!b30U'BfXdhEJXB
T`nY>t']A"1`/M,E'8K+5+"2<f3f_(2AAe+":&7#`2>:/&XB$%I"/&m3X\iM#^T!iuW'FLb1o
-'&/efj`,(5nu/rfFIC.p)Rl\b>@.1R!P6+hBAY\>h&>;-<1fb=@E,o54%=FCRL$qVKPuPk/
up7Ns'?+r"`qWMo#9:))R92B]ACo#%JZqk0qLlQWnqb6`_aU/b]A[72u=P[g5=N&I1XLkrf.!i
ZYcY00k36dPqeH:GABY4]AQ>q"Y1PmA10ND;AM/=5Ti7pepN#[l/]A3;5Rl>,I)6'_4UUF<b1G
5G1kt%VU'`X1@'"^=\YkkqGf%PAnP`U$mLjSjhY\40=-L79jCF3`=@c`i[oMa^6Id[[Rf+\:
09t5W,^FJbE(S_/g7dFhe%KDm]AU?V2,:?]A^H;W29*VEBp^-`ps\0Se)LSfL,GUjh(fK:=M6%
eAOscM#3e7]A:TcE9X\B[Ks!?cic*N#&?pCV*3E3DU"[(4Y'2L[Q6Vh93AdBm`Lhr`#cJb",+
dT2rK4%gqojD;>q^MUgCa-C"`)ei>^OI)<)T^Y*e\@VL.#[,]A.2egD$['XTZ)R#D$8V%VH7@
U$rsV#_,VdTsJm<7-')dZ%j%:;(9^p&"S_a_*FOQ)Cd$pHRef2G/Xd,!q`e]Ao"h60)3=0E\W
5QN,d!8VjuC5?fJ1KER+R1UPn/H`Dh7A50Pbd^8EX.9,K8bFb9AtO#Z!lrRpPhF,%cA1I5b/
CH61,t$jYI@NjpfYb(QOU:sYr#"lfJJOU1&N9?UqRLs/oodHabtZo$@I?V-[kp<*tI57Gk_a
c/:>]A-f/rgET4[QJdQb]Au#':MaYUo<H2<S4o269#6C:.3O.'q,I-OKW#rXS,?pVM8(HIPFa%
?;TYbak_-76`@)j1,i\=3[%RQ?Y-r00lB/(c#Vj10)g`(\&mb78da/$#3Q%"R\=Z0hX<Q<H#
;\u[q^&1'=="W^N@WQb$Yse]ANJLTaV.F!\o8Tu,o\*te3=^#s7bst<Zjg(#&GH>'CNN=F5lK
g[_Y_5u\>[t(VA77"q$r=Mp,(/$`]A&ZoJ','-HUta>4E@hU`GE:2j(t8`h(qXsG!,Vm,q"o9
lJ0hMWi+Z50jHZ"d!\G/4N4q)mldCih<;LnK[]A*n7+>4_>%5VC[_LbU;k/9s>i^2UQ??k?Z:
7%.Vd3UYTLn+r397o;d1)l#G8G$"k-ad'-aH-lFqQ3hTR$ZQ&m!jT*YN=l=Z0U./]AAY6Bl@p
oPBEd_aa(LZaL:Pn'AlX%L[6@4G5TNKk+Z@W`%-#c^O60VKNoX'I[K^0c(#)(_W.49c$<>bf
O#^K1fK`mj3#%+43bLNE;T+WrI!E+0UO23ZGU]A?iMacFn0\e,NaQ!)>E*,'Y_4A!AlhAF_iE
7MU\onh)=/I6g&jn.\&jgs^>iD(a\Xj?(V9JWm[q\]A6l'-/:Q+G43M6Fk$5&::o\lcP*/YT*
V?l+a!h<O_&8`g3B73qa#g6]AV6]A?3jajaJc@n%%Ue"g-eV67jKt^H@6K<aH;lD8!iZ5@cO=M
OU/BpeF?Ii^^Oa,>2)"`$<eWo92$SH^2<=8YY&YKiX/P.pT39%e^q_)qc$Qh0cjkX#Hi_3n)
dsgVmulh=hIC+[o0qh*L9Ro4)t2^<c%Ko$X95L>;m4&.dq<58O&?EO*aR-UEQ*oK,1J4I#fG
,t5biJQ_2.4mBSh;dhsCnAhpAqI1f2BV[?&g%@N"nq8%X+/Qo8-E0_nR:dbF4Tmp\6#(%U?#
(-4O&3)YrQss'Qe[Ka4fp_T[CuISFCs<Z`K']A[3u$H#CJIiOgLJgE9pR:jO7P]AU.-+-==LS2
ue1`ff6p@)Ri)GWP+FD._5%^8c8JN=64_)("'k;U>CREY)G@TM8lQ3Jb'N#mP+'s6OpCMVBe
`RVOf9V4c9k_Xq<0S^K1Y^'qkeg93(u,FSm,gQ_WR:TI&rh]AnL/kc":Dr]As.$OL?>'@%e3R5
>S]A7S"L%io[342n?3Ldq3s`k7e5aS%/+[5lO"s!!FO!C:C<I9!j<)@i7krA<0o$`ml0!/2be
?\$$l:@XuGEK3qR$f6U(3Ye',pY"cE#jah^B`_7M"!P3V3*P)S?1:Dg?gEI*a^mdnF4X5u7?
6"XHUN+8L?H;K\6[a5eHTK+:!Yjc<>#0)^%jO+pAeEBkM0KoTc&tl8Ybid`uI/.4WRe`WH@1
`TSL1\]A(ir-Qr,i%))Yk"4t-;Jlfi).jAo2l8,f"iE>7N5NFF#T8IE-WiG]Aeo8m_8?aR?^B+
U>-0s2!@?gs>Ta?t#6dZLo\N%Oj!V(tDjc(rU7O0/cU:2pF[g\sP?_63J9?Xg0'1/i,Q9Wr_
6Z*k97&W9p`55F8-WoI:.+"4J6//id9f0q=iP]AI_H<1JK#)93-\:Jc&$t\'c>:1+l4Oo^Q[q
c=Cna.h\S#FOX,(XP7%cR0`UDo2VF8E[m46TW`CiYJ*%:=*k'+,&K)*,d1HkB-Q*_$s`E2GA
NCk/8C(lhnPoTa`Y/R2qf2HZ05=G1ne/M9#-cD$Do\s_C+3IC8`L(@Jg-.XNE?:QRZ8HP7^1
1?BX`&3IKL0:*PZOSi>`_ZhKkcLr'<ga-VG;nem[rP8>0(&G+*F>]Ad.]AN/s1hQ[=*9W?ad[_
9pc9pLYB9Z+>\;Wr'3P<5'8WW6]ANFjVcBV-E1#4<9*^t3k$OWJdBJr9;aeI99pl?1j/l*DSX
M>\C@#<fl`8HV"GqbmV-G3@-4o8p4+=sIf?Vlgo#*h65+6D)j\#.&:>%qDJJar'ARL(YOTFj
iiNm@)H-=rWp[_ORr>urE_G'X_J=?[DtlRkkA.K!dR<LUP%$Dga*LLUU9l".Qlm^5$A^E),F
H/W,mPg!C)LKBM@`_b0$DN=.TGkrU9\l0@.>N>^_"N;jZZ^,iWq1o6O#4kT*j#*rt0r<U?g!
N/pMV]AqoY<uZ-$CGj\p<5AE+?E\8Z/_<*1S4"mo8C/rMe_f%VVS+<*%8)^M#1M3YXpbH)2ba
%hTbOZ71aZ<JKC,aBkG5t.jXH",@-NnYIRV&;lgN4-#sWGUhbntA=fFUOo1qSd.G?P_ZH)0b
-h&oK4(8R8!3;#Oj2$?NKr2WeBC)V0[/Dk7`VmV64=Pn>sQVHR/l73&CLR$bk%M&1C9U)Ti&
b&1ETj,g^9GH?;2&Zk:?$8Y'IHW)3f,V(d%7EWj9Zb*5MDHB>(<s\C51FkM0dI%?c?.S&h:6
OXR8Ih3Fnu[SjdIn"%R3o66LXV]ApNX3*gCN#KuO/4"pTYH5$1V0^Ec7blS=.2D^r(TD0ar<l
1&-qC95[bDsAICMT4*dQ;9KcSpEB:5aZr3h2a7qMuqQe`l[Ztahl`PS,Ct\`6EV[f=hZR)Ak
o=pdgq2+\3E;p$ndq,8R,`P6O0^VM+fY'oCJXKNE]Ae&\D+'WbgEZEZr#e_Z6lCcpi$\XWWTG
2PZNpN$R/=TfbMI@V73/D(p)8E^=D+s>A=QYPdl->^F>SbLk>KEeo]AqY^EX+K9``m>%&u,M@
4R?*$jN7Wu/#OM>1CIJ1NCl4*c2unk8dU=--l=Jj4M+1r9!kU)S6!;?M!4'E>*=82jO"pdVj
H9[pCinmcH\ln2>CrY:W\7,f6?OuNl2?5["0K$""[2G:jZ#cp5k5eeLr93<Y*$!#7haFe\+C
O]A<7R*6=ku,NWlkIFs&Ol50-2H<'1KA*oUJe1g%b5dC?A^fT@;[9.m%"`JJl^V_Y:??(=dC$
c/r'<@K";M^_=g*X_7W\C,D8CSeY9o\)Ai.qiRC(s<'4/Jll6.K\Bn1J4)H*V<TElQ)0rFH!
R4\olUO>]AarBW0ds59"%l5B"!5eHRQuM5%LUi[q.m17ljg,*H2iFZrn#7@)^VVq7hQ=X"DeR
V"7kZ7Yt%>\m`tm_ROU%X0fY")9&P<2uQiZYj9hT'A<'IoI-hZf6C=ZG)>6\/tC)HIb-U[nD
&i=d%`L>=lqR%<BnZA6AO;j8dJYdE\K@2.5,k'M/aMVU]A-7e[V]AU=kP0U6UEbd=N26:dl^B)
h(!^(Rb-bMp0k+;<>g,Zg;oq_5lX1;hFRB+0C.HgPKdcnO8P+3<]Ad%=>;+K1nQ"X/s9#]Am=O
'nS.cq@[Xh!2A%7@9HgH.MKYp[pa6OrtL\KU/k^oh9/_beY?17-s#4Bgu`^*BP%(0!R:Z,\`
MK:-5FqcsU?m<$oc>M5c=B>NCI`bBgfjK"e3$UnWf#PaFbtOhOR#r)\`(P"RIN"]AGYrs$+YL
eMlD?$BioW-,YUdL']A%f:6*WrN9iSc?=eSgC111qSn*(mApT=(\!=YK:aj="1XMV-o4bL?3T
dK"TRDAbg0FfpTq-!Ir8tCJO*o<4[IKao.F05'oH]A20s!8\@N>C;;LLNZVTO*C*T'R%qThR:
^8%g!;[8:+QkZ7tq4#?1q]Ad:6V6:F;tcQ\n+!C83Lf=F9=1e5u4^H+:K6nb`p.u%.rD\Q#jX
TXJ1-oEcDV(,C"m><Q$DZYO=`g,`2mhhTQ2C:I_,O$i[QM_"8*^3?-J`teoMF/E$VDoj%I8-
-%ft?CX4VJ4&5(!!Y/]A&LTf-_=O'ibda8,>ZZk,II/-$&pNf:a'lh6b,KiNDHj;4S*>pZ$tR
Us?g>nl2:j?khY>!m3BKW?ho()R/<Rau.--rA1pa8/e^-d7]AmU2p.aM-)aBc3Z;&HO;J$/TO
^h_#Ltr00#InN@SjU_6D8);Qp92\1hHE0d#>#BajO!Ce`'[b.(`fbc<rD@7*<%MFVQ`+(g:P
r6E7S:ODJk22&p,-?Q9/+a_k-?&elV%X@YQ2@W3K<m$DSAdbEk-;!FY-hhN(rZ)_&KERJPQY
DBI/CrYNroVc&54]Af(]ATE/hQH$d/TmDH>fWm'Fp4h@OfmF2,F1TZ8`?$4IsKQPfU4_>[VIPH
:XpCJSsVsZSZ(AGZ1htN=-;4*@=pJ,b9&*>$jVnQsmnWsL<H%f5kF%;VcW]AItRTs$@$Ecil(
TgT!$HJYlA`4P,Q:8(.s<*(,%KYL.$K#'nPjOquuJ*8),L!dV]A39%<kGdm"9B6RsP6@*[0+/
n8437'Ea4AJ@GY_TU-;NaG9Q3"I;_\OZ^SG'rVfIfigZnBe1Um<L&Cpti-Ot*#eHe/TH8QA&
rg$\WKl/[9Is,qO04QN$@47e=]A"dbOgo46+2CZ)r]ASp+Gu81[%U=rHAT*f<*))l0dZ`_KpP,
ASKm2sFp!6UH454sO./gQj+/e_j"G.[MO]A^3Qj:c.J64dDg1<T_4`5elSu-Vi!>&.Z/]AC<`]A
QF:4sV,q%&Y,\ARInj*%e[Qg^g8?;@XR\\7o^lM(K@/0qC:HG4e/,K^peNL"/"Y4eB6H1l"5
jQ214E<go_X?T0fp4sCAnKW_,'oD:8>HuP2'H>,0;FQ/fK\i\s_T$OQN.n]A_`k=G`i4;TC!>
FBLe`KDo4o;$*#<b<8da=n.Jt-J;]AP=t]AF$a4l*j"'CS@TUK0A]A=JNgfu=7=`fsVS!VDS$Mj
oXeXparF\)qC"Zftcap]Ad%QkeEC:X76jo)4!2/uJ`S8*FkiI?JLV4Msh%]AN7J:*qK[9d+QW/
MWGL`FJEU.Mb@ug4$F6]Ar=+eo8'X=gqoir20X;1QR.]A_/."E:3AqGhj<-F[l41!UOAlg'!f=
>Ih3SX7Xr9kf-<BB:`R0#lg5s]A<0<\[+3rUS<=]AKd&\[q3;-$B5=\9X?E_JMtYcoqMl-Z'4O
-*f[J$8?Y$5Dr1;[%O4IjXj<Ch#@M+FHc__3qe6>jltFnA"d1:C$@$?G&K(5\ks1t3rTKZK0
,P394Z5b!N+'6,4j0EoZ'$Aj@[G^nA*M8pVmCg/YcjiGBjdSXYt76WcHd9h%<=BZ:WNdEOI:
ifgI=\K&qLtT(2k"/&[re5F2%9U\645D><L0$s*D2W=d1E'qfKXAp7iR/&k2QI2nudPQ1;%`
VIW!4\+]ABdRTqC4nd'HkgBgSF]ARK#2F`uAAQ3,69H.tFEj",8M#XS2o\5acF,g`p^/O&`cB[
SHbYPVRPq@N;9Ta\5#VfW5IX@!Affd![cX8ZWkUn`_e#+2A/7dkPr/i@:BO'eqhF3Qq92=c8
5a>%0-D&]A"mmI&93;p--&a`5(=Mh/IlFg0\!r(>[XcH`H2@;Jh<*b2.:;C-`-oing._W0&-8
BB]A$=XfIfi$M:AA$AjZ(MrC1pCW\3)9AP,%_reBgW7WQ?Kj_[brR7SqW,Ppp0e8'ZCjT0\3/
7Y=D&'Ua>/Im8&GR;EB1jXK0GK8!75T?[.2`;1CX$.P=BJ\E!ceh12SN>@Ks;s+0%C]A*F+d*
1qr7N\2#pN6!MUpX9S*;O*7/,rrM$$!UF$5("XjgG0"dka,X"aI+,hUl"5?1bscLpi"%QWr7
58IiK'J*>JHZCp(:,<X,dp0+9NB&2Gl5LYhV\-76K$qYQdL4rgf[ICS&:nigfif_Vlm7bZbX
,Vucurj5Gu:kNs?6IkE7/>tR?FJ8hS&Rj702-VWMD%ng^aCC=:kb3d:8[l7[.-JX%'CS(u\3
$EQIX=gjVReV3.^jT4-FE]A^+W^")Y1UHhZ,2=,")]Ainm>`TO@U2H]AZ7=taNd+"@T]A;c)eqe5
+*_uFghELOHR=rt*%eXEUM6;0X[9CGQaTm3an8@tr`L:EiT,-*:>buc<''/t4^IOfK[37)54
B_jH'oC*`F2.8$A+;CG`KO*jEqI-T7-7(@n*c19e5^L+[0]A@L&s=S;^EUK"I_;g:)<NhU1MK
-]A=W3R\@3M^nPJ?4-X0N6"V2/Arr'j!.2l)>Ug'(3BYLLkM-.J#C"0$?g!(J:u]A^nCc_t3E,
QX'K3)\+[9Ljcf/jk[.8/NK!+<F1Bep9&IC*,D=ODVW#$qB]A3Cr#J>MQ<,J[p/tEMaN4u=B9
to!+;ks&?T1M6Z>jc26piHa+6oh>@7S\i/_PCmr"ZojoAS/^5.=/\'0]AgU);O(P;9ieeO&)+
WV@V;10\B7_>QFM659-Q-+C=Lk]AHif$1'V2IFrZTjUrU02H/"5Wm#ZtbBGR.3H[DV2OtC)0E
Dm+ekt/lX^BLS8LFO;S"F34u#ifj1T;IB?$m2P`1PkG`eZ66OAtM.&hVJ8`=GlXZ<E7mfW_p
[3m%FOW0]ARD_'F:M8LD.?uRU,A$2SAS8&3qdb/)l1(40)]A:SN/snU@_Pn"i-rWa:dudBZ]A#X
op_8un*Bg(^>q6b$pHZij*PXfS*_R7UkNJ9B`4[E='qHt!iSh1k!VJTs231(LDOcFFe9oBH[
RWf0DSj%TSW/o]A6Z3sl@4f.l'^$$O0-(-IK*Le$_51*:UA]ApP(#M9(AlFOVTG=eeZWZlA$%.
%qo&:k8Qini+M6thikIBQ-_(8%`<D..'_X,4II.^a1ehC'=ohORKs1ihjaKchCK]A8)b:/;7<
Z]AG$\>%i![Zsr+763A9U@2-8GNIo1=H/pL=9(&I@gN/>V[m9*EaX@-(SSrO]AtRtR2=dD)4?d
Sf-RXk44bfV(c0bmeO&t!a.N(/%E(8[s@SD0QpPnk[^d;c:%,jF0Y8tN<ltZU;+O-:`UT2n/
jk^N(psqVV^@d!0E5iI2T,^--a]A!20kXN6GnNILC^A.q1?Dt&:qG00E=]Ag1JHd[fnnO%*p:e
(FH!a5Ikq[$A4Gk`/eZL#6tFH[P(!JIoSp3?qpS@iD&ANF/L#"Wp.rfZ<62:enk<T$_d9/j0
__gl4K*X_`3eo/,JoTn+CejNo?kI!%kTIGWf@P8i5[4[SiD1>nF&f>#CoH!Za-=-r,8?(f#Q
+@#oLuqgU>"r%N!Ra3I@pWi]A"Gi#.k)q@uF2;:id`m)R$3<!uE&SO'2M&S:T`;>)ZqYVQ8)>
/M![o3E2hMeiSOpi]A*Wdi&D'4:2H87,(YTH(g-?^nt4TEcu]AHkRB0QW>GDHPQ*'<B6`fW);$
3o>Dpf=,_t+,&sXKN]A^r<<AQVrijgmM-O!-$4,M!dsli+a^P7cp(/Y6QEX1>J7:GBXU[-6G1
7@pIN6G"L]AThYT!882OFEE8[]A:9MoAMqm>.kOYqrg8N,P4JB(]A]A;]Ais^5_eCb"]Am.BFuF)1*
>kB=TPEd=B,J<R(^R:N)")IS6,i\DG)'N&]AZ575c#)^sc=HcXKFL-L"cm#Et2d&]A[k7R/\'7
cCBZ"__:cUr7c;=0Aa1/c8Z)rEgc:ISHa]A;rnZrPlT9Hn=fYQ>)"E?WM8kZ\*]A#-%i,2?aH&
ISBmA#1!2_&_Rf$7fVBq7F.S"Nf07Ag0;FZ=7Ae-=b24SU6D'2%E!q)]AV"ML@EpuCNVJpfA9
[oA9d`2C,s!-,BJf!&2=:TRsUmfVc5D@CE5L&mHHJ6f_"QF6HtGPoiZR*M6a4MNY#>GStb;V
t_Rl*Lmf%r9(O9pHf^&ol#j?b2Um"'0LFRW82=l(L"T!EInS.p=b/.J(+uFj8a$r7]ASa5L+,
mb'j:f\oAeZE9*cG5'39@_S6efr@'++aS.b<Q(90Zb#=\WBUZ=?7!*"$aq'bDD7FPEEKquAb
HPr/4;os$q2#$J[Qupin-Nj#/e*Y:Tt88\T<C'C%U1UilEWuC_U8`Qf;*PGRmXYqg?l[n_/W
Pqg]A,RMfo_HUQ1)8j@Mhnp("RBh6:]A[)7E"6'?Q&e>N_#-_IA3(#Xs%<m>Z$j)DIJ[sEt/nb
E-mKQ73)Z1?5&ZDV#FuBkr2S.H4&q>IPP1o%*PQq5.pFO&US3lD4ouLlV6,`M4[aMJcB`+co
/r5Y`tUM>A2u^F;4dWTbJsBB)nH4$,N//Ze=+7&c#,V'IF0JRhL$eD>!g6r_nIsGV/$cC#"V
MD`cX;EhC9n?&&C)NO_o;"XTapXf?EfHF:M=2SB/f5tt(5\6Ye=!BJ2iPM)Ij1aGg`1qWXmT
sK-"gpbOi9cQr&<q?Es!'o[k\u1&h8coZD(qNqbWsE&?;91/+ci\p9cr^kfW@kF7DrdqQH^j
mS5!ePn8"W'Em_Y/+:M#n*$&p)h=UK[0O5ke\ko'Q3HrG[.?SWS>-`APd=RP)F)j+p:'C;-4
B>Y/6l!)F"\V@54I-^@[7%80fY,&P9=.UO%M3T/F$o3&]A5t$=t-TX6q?;jYH!-gku*lM4s&^
WNRP:,tslLuh("YCN26E\H`.Ofh1TtcN$7jBJe^3&NkSRE.$K1jdJRhZeD(EaZnBiE[/"K2B
X'AfJT/NWo&F:K[3OO1br),.:1Sq<&m3\"(O:>WJ(&<,2X,bH!.g.3cRP&^akR7T9+#F!j1P
]AIR)pgcGXC6V+Y!")@70FAAhn5T`-Uf+]Aa!*=m?ZaT3XH0NXgF4^i:_Wf&fqUN_!IYGr?'.m
-3hNV6!\CoGpAA_G>SkE"?ha![rqIFbaC+?u/!n\CA-V]AcSEgBU;!rs='!ac+*f>U>^^lWhd
00S7.KIRr95iBbi>(Z?LC',l"MKH1g^#p;%E[uVY?!6S%@+"/qe?b)_+J@>fc/JcneXnRnhh
ib]AAXXN4k(LhI=1AWc#k)ned&RVP;jT$c!*4"fR@%#`gthLj+[.!0BO_4n\UKR*nNk*H#HpQ
T;X#^A]AR8&%8:qN&%n&hF6@bJ=cSpS$<Da$p$'Cn>mfoHR9Ok4OG,mC;>?bt>ao\,J!'%uf.
S^,(Hkdm+<0F#<S%Rlb$1U-c3YmH6AOmVpEHV@jok.7:JCl""@JGKYFZ,"('='G=!48cs-s8
\f9>N">7b/u(?W3mF^Ves+BM$1LH3't*h.X)Y/jqAr9[N0me/[!gF[+uZIFmDR8bJUA3U0gm
*.ZclG]A5ir>91d=&PjG6e/Af-VTI]AG_/H!kW?P+=9ao!b?UBA5rAndN/bJJ;2\ZSQ#)@U9>6
3+_s,8kbH!l#I*4lTOA21$\C*-%R3inR=!s3(a-eN+L4M`-Oh!5>?]AZfZ2^7o-=8YIDX$3b2
T,Qko]AbWa^,f3?DoQIc%LBs!2ajT2CZIdW3*kUHj'"A@-amC+8TLkHJfb**rNR:nUb'Ug-Eg
(Om:ek&[A5h$r?5VYn$EZh6B>R<nT_<4IBCuGh8\8U'dCLF>K<#ng#3kSeH_F5q\%j09`NYH
E1Z@R-384'[eU6C?eo?NdDDNgk+W^jpVZnRD?H"^nKOQ?3WE5R&g,84ugb."&A;hL78F5*Kj
&:cV(BpK=/b84@PZ)1cVaHYtMGqOO&+9rX<obSt'%QPGnOm8.`:a(UEjT=H#DsPNSp#LV/Sr
@)mWBaQh;m)pl[h"KE!)d!bH$g1n;DE]A,8C7?$"#.pIj78XJP'X6qiIdDh-dXEYO.nd8;?AO
q8\J4S!!?):CceaV=2L/RTr:G\g&>@'e?)02&sN2D%(U<OBFFmA2mn]ANR6XeK9hi0\1qX0>?
m>`KjBA*DgbLJ_1fI3R<GG]A`,V;97U\`cC<;Zml%g+(GZSi3TFHOEDU/PdOOn<e#:-o?>nI7
8Sm=;k.22r[VVqJF;_sf-mYHU;9?2SKZobWWm&cDe@\L+?hAD$1,jUN/?6nfJ%$5&/;8mkpq
W684(^qg^JhF;nY<WEtg;m`@?W?.h%#0Ejh[,NM=o]A[C,BK7b8V[hL@W<&1<e5eu.#1&%01*
mp!'HdKsHs8PDXW.;hlGi!)@;+%2JC`S!G>[r6%BSear?p#l:H^jXdZZ2G@5/P!@4L,oYJ)#
arGRXuhU$#=!7m!s-%-ptIK"j$3LG-LIguGie\d:ZI"D`"@SiH^=%mBn>Fg>4]A"k[J<$5OXB
n9SB;0Ds)lI8VU0>q`/2R&s%/C&XtE.$DZr9lH^6]Ae;S^(pu'6TDujQuCMaQ7h=43Whph,tc
/BM$T3H@VSEG=FfQ0l=+0o.ffMV[[tHqJ2@h`k]A8)$[`>L^L$kLPV=PTAiKla7o`)YZ\Fg6P
kPP8KIfK~
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
<WidgetName name="准点率-同环比"/>
<WidgetID widgetID="8386eab8-e26e-4065-b320-54d97316abc0"/>
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
<![CDATA[914400,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2315520,1859280,2316480,1645920,2315520,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[上月准点率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="1">
<O t="DSColumn">
<Attributes dsName="01准点率-同环比" columnName="准点率"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[环比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="2">
<O t="DSColumn">
<Attributes dsName="01准点率-同环比" columnName="环比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[同比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="3">
<O t="DSColumn">
<Attributes dsName="01准点率-同环比" columnName="同比"/>
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
<FRFont name="微软雅黑" style="1" size="64" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="64" foreground="-1"/>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[!?h[(q2%pC7h#eD$31&+%7s)Y;?-[seGoRL;[<R-!!!;(6:LqT"mANG5u`*!mG1QS'NH+Xn1
@H>5tsEs]A+l9@VAc4!%111r+>GVG%qB/4c'Bgt[*a,[K2E:>X$OY&P%sCXpP+:NGd'[J.%2!
J-7!>gK*Un?!=hAr#,>klTDEohDXGT4mdBH0DeAioaX7Oanp<%em<`bphFoELXO^%HBhtp.q
t^UhkonfZ0-$UEg58YY^Ac%?ocufiBYmgH2#f\XT<1KY)&q_af$fpT)]Aa-1A^`j+NGb;)hf:
);%s$jiFVOd*5Obm2d00J3;##\2%Wk8)U8DN0k7I%A^DoJ\%k']A"5M:DNg#*Y1S5dujFb=k/
Pm4,c1.Vos^c^hek_@8$?-G+RP?d1Yr'19^L\LEcm;Dn1knq[Pp8toiQ[,2r%h(]AO8tWLSnt
krBZ@0:hq^+iJV2$ii,:`oV1tf`=]Ak>:h!2'@;3I&L5pT/+9SoVA1]ARSWeh/Rs7Z5*=GAa.p
G"H&OnmmqX>TK-\UpK;8NQmc;3.K-i*7ff'6-]Ap3.2Lfj:,/m3hB;@Tp+G'8hhq*:;AS$MkU
cSc'Ci%A)IEUmgW&BuCo<Rh_#]ApD=PcZ>U5#K#C>.ETO!Z_>u!_ZC7W(c_bnjVe<!(74n;Y0
n1EJ#m6ErmaWdJGdhC9iNqF\o_qJB/Y_<)o_FT/Ok/%1lr?J!\lN>>juB`RERMnY-&Yc3k]A4
/-Sj?k"B-(Km`l&b1C.O`<*u3SYa@Z(b,'`,O$BQikufM0pC"TTsB+#.pXDcgfPW".iYEFQS
.=JSWbZ;+EitZb0NsXD\k&:+GO]A$^QuRdekre]A\i>5MiaCSB&ua"BV2MVN"/m7'B<WX\3%kF
Hg<#MYJ@s:pO$HPBYu^Fg(n?uqVuog[4I%==F=E5p!/+u8rRTJIb+j+-`;h08U9BLPWCOmb!
D!2pdI2dI'qDFnV2G@FMR4I9bafGd9,@Yk'H*N\29Wa1V$d;p$<mZ`AR7JM>mN\nfY63Np/E
E8$NWd*>L<g-]AM]AH:IX%aDQ,4?P!;45ceJi+tqFA+.JE.h.1Y$F7K`EBOU>=sDg,%`B!$m8m
SLO/J;t30SP![Rf-</l[(BT[<:RTt%5);HI!/Y*Tn8)^:]AQ>:s8Wi_!)pQ'GcUeoSO;-jQRH
B[D-X@!C1=5gG+[n?ROtR"^rcj%kGl"Zuk'^3Rq`I,go\-B:51>;X"TcPG>3Yos5Oo[^l2eb
B#<HH`AW?bK(Bb:^M@PueSKO8'`(RmEie7EO'sI>R]A_+Vsie7EOPjQlPo0R#$K=drf",J1C;
gS7@P]A"Po_=K,VWlLfZl23d]AQ[lf!7Cka7=Aeq`p8toIc;:pZZl7!N!NMf+s."Y/2-Z&t(CC
]AeQ:DnW%9:F&F+\S.!&=#c]ARdq9"]A.3`l.[Zt<Q<YBoA8acl(S3Qb++j&3)KY"<n&L&3'\/m
*^K#q>uc[&g:ZS]ArWO[G3rfgL*3*8oJL\+8Y9/ko!'mp<Yr1;0/ZUm2VE%6Za`dkQSpC:5j5
k1d'e%Nlh7hu5h&VXG&:cTAl0Y/H<G_TVY2L8aXE:??Ut@lu/Uu5cLh<XEG$[s>89YP/^k#H
<[FR33`TARhEGlsN,WnF7b4LXoBLneRNV?M8,?V08I(AO92m%f=Wn@)2gOc7E,T0B!#9A"rA
Q&Y1ChYbK#;0=J&ojR6;XWbsV?Uc^=P^krENm0?*X%">0]A,6cm7lE?nl=GU2YCFq_<R@.&:c
IYHeQ]AK-daXH^SO*,Sr4PO*ZT^1n.pakV]A?5YA0/=mUPit(oK#/V(EY2Y$^b8c%;'nje'bM#
XE!MW7GV5D2q!<`0Uo3:C%Ltl%X6QfN_,4IZGl(Z2fiV<jk8suoROfq<-\8F\M7@:SRP[n)U
g$;19S?S41U'Ch-K1(jO?jma8+WUU^%t#Xmd3+FMci2c(D%tbTY`J+7uqPq<Q85Um[kIIf\-
;;S'Xa!D3=l!!#SZ:.26O@"J~
]]></IM>
</FineImage>
</Background>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="64" foreground="-1"/>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[!@%g(q2%pC7h#eD$31&+%7s)Y;?-[seGoRL;[<R-!!!;(6:LqT"mSZI5u`*!mG2Vm>?)LFn@
1D92\?aHkSP]AtU7sD>qaGH0iX761<>d"'Zm[-$,j4#"Q)dRr1>4i<X51qNV@u2(O+,`O_Bp`
@Zuc0W>g?&:9:`9rX%[VQp_'3_RbG9Y9lcF[pYPl[r)a/5IEj/=Soa>S8L.Kh3X,g)42,T25
/"b?3Bhl1J'TR=O#r*AnE0j<]Ap,_Ho(V>NJ%(@lFGN0Mi6SU*]AO'o8qc:)hHf"DG3Sq(njjT
tES.?U7J!N:f0L+7+EPV;%?g+K:^6R-WW2nUgGpM+bSbQ(YJ-&Eb!W.M!aa`NAbjEh=WN()Q
HS4G'obE8A&0*rcg!LV0%9ImbcU-78063a"ncoMp7YZ)1R[u%+F#;FWW)Yr8I49VQ!.lnHME
NDZVhAh@%q+2rZ!qB:EbP(8eu,KD3036tNq`VTBEB5'L=FU&=0sMS?GTj=%&Kd^%a\10`k$5
ZlWXuMrdjNrG8Qu1-<.^':%K!/VgLu.L7k:A/]A4p#PA6JfD+^Zb:atW=!_?/%*c:ZjbOtO\d
N&E$Ab9DLFP"s\"DWTjo+:\\Gc(P;)8.nHT^862`B/OF3s-$,Y#"?bKh@cWCXSaR#ao&b?=.
j:H`k2+:&sJ:g"T$)-`VFfSG#Sl%hMd@]AY:kP9W<F9+mG^%6Hs3$46S8rHBdFJm9B+T!CDj=
`@(o:5k^qV4[VEr-tP&P8J_aG'e6,RRl+.BO4pCf"Gd]AfR"ucAAtJi:]Ai2L5J>h_Td;9U#jc
0aS`)FG"dKK\?%rIqIl::1%MZ\d2?RsuLWsjCrK&Qd).@7TK/5Y16!uGA1#>dW+PkrST;g;U
U+K/d]AB*"8n3WqkP6sA9%@dqSU5]AA09IX6#tQ1^I$&J'Br0`'U7W9f3gnR;K-5T)^e$rtG\S
rkW0+:`W6om?4>"fLYql!aYPU3hPG:FKSb-X@!C>U3&?NeCp+F6Q!ki^2bT:Y9G^7_0.]A(ti
<#;10O<63-#]AkZ@/(M:b]A?TL"giRhE7#$d_G/Z(_"u^(>hI(pIeUha1-F5V1Pn7W#)!8f%O?
+10Ejs2O+-!Jh!4V_3=c;HC@?J@KQ>qB\4$m?9.*+>3""T']Aju>GV]A.Ll55mDRMLR]A$c94`.
`VhB#;[Ua/'.ELl$u1-\(NDM=SUc_uP3Dq::nSrMZst4@!k(:Z%PtP7SE2&8?#g5<M).GbcB
'T[[Z4b,J4j7t@ED!f/VDV/Q1Ae-k+7*j(Gq(BtFNG.(Id/"Q(UK`OT,b4i'<[$Ar8dY.]AiP
+f.<>EjF=]Ag[0Q"[G67olC0l2$Gi/VL3ppdD9Ut^\H,T1PX$mU"+D#*h[h&#LXIlp"sGZpIH
)-&/?[uf?P86j=oC8>pqr`(cj?`TJ0OM<)8q+S^iKFhg6TGn5&;C!CFuV^8_98C<EFqn\P=D
aNth%aAhQ#3r7-Ur#Zmlmf5W:OB6Lr8hFW<&bun:KSSA0`uEjB[-ga*7kC:@8Tt:[%.*\_Y0
#H3-r@?pNqY*b?k#\O#XBH5%ihNGlhYMBFhB[q-/U-O)9V06'lTNMdbK6H0'2E*d[^JR24gf
7m2-gFgsA<OR`\PjmL=jFK\'(VP!b_*2^M:sk*Yf4#StVh4>Zl'QTg`m2,I5fo(?L[$::g3g
@&VM<jX,KV5A9T2bm[E//d1/A\BBA%90<LRGOtbT=tn%#QP<AY=%")9uG<Je_4@'p%c`X/U]A
kaK!>-ZfuK[P_t<uKKs`p1+-o)M!&^0L_JEo>.J'47]As),m-bb5N2(j?^!+oZ;HE9=kgjb`6
DQ7G0or_*V\G.;s#7mJdTbI.e8):nn<&uE"2.#dK9_qdrF1oO5b)%3:R$[0oQgKdk.::sWG#
kdqN<>KjAZg(?2(kX_rO^\NOlB?fkgRrb*[6WZ6h\3Yp?$;mIXPrQZK9cf;b:?R@$`1Ar2Tc
!LNREP00ClVz8OZBBY!QNJ~
]]></IM>
</FineImage>
</Background>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="64" foreground="-1"/>
<Background name="ImageBackground" layout="2">
<FineImage fm="png">
<IM>
<![CDATA[!<`W(q2%pC7h#eD$31&+%7s)Y;?-[seGoRL;[<R-!!!;(6:LqT"j9J*5u`*!mG2&]A**![Xn?
lW3[N[,7d8Ee?`/70\g)#T7OJl.k]Aea;5[mjR2M@]ADH<6u8S8tT'4g/a)".mE0l&$8hC;5'Y
[k+N<n0+"np1V7G0U.L7blT)T5ARdX_m`t6j4-T\u+'[0sF,0SShE.-nS&rUub(G>)K5>^Z5
kK:l[&61]A21HYtG[A0\YqeSB6I.a<k>]ANp5OdiErd9L9r`%;>2h]A2PM!I1lGoJ\S)0bKLmbI
[ZTO5);4NpS63-Ltc%GdD:g:?FG8`AH]AmJJ!"UjYK/)Y&+K(]A0ldGrKO%Uo!dS0c+lhDcVU%
$P";p>kgG[db8Z*NEO=+5/D]Aq5#;5"fO$DrEpXjs>:H%I`RDK'/3#<`*TK$W8cC"&4CpKGG@
TG3Bd-Ufo=<ZIfY^\6ABs.E5GNW,!.&1O89A!^JJoG1^hJ8RJrTs*%aeD+o<+'!;#Hs!Vqtj
4(fW-#3R6@8"\PY>T(e[s7fd("?s!(J<2&VAD*\C-1lQU+NQ#t^HS"@tJ/Y#U%?Cu-/F?'&-
B)(J&l!%`$GZ_T,6pj//=/GI/a*Un'oK0[7g]At9l36QM!8)s;D81;-^'\qlWsX*s$"*sD?[^
RMT]AGZ(s5cW%`<4bM8$)]Au6H-js^"PmWfSi1?]A\M,JW9$m6LUSM^70D2&F7KT+.=gh)Pq1pt
N)IP/'FU!:O3SUmH/"Gb704aVL^ZbZL8mMGc[m>A&uFeOl^A#m_O(`+%np^S#`pkddGF#\Pj
`P</e0"dM#M(6ZRr*BA+eg]AP0.q9S//&q2JtX\J>jVUkD4:U$Pf8"!f/2q]AG&bs!qI.NC)7&
8FOOP1K4h%]AU>s)STh;!#`[iRs&J'EULu,/7V]A9??H8,CK&/'Cm>u1:q_qN'0U]ASqCj^JD>"
(,"\"s>2nU.[<?Mg)Q:!D&,2d4KAd`>@6^!2PA8\s^^\_qKeEU]Ao.H)6&'a0*EC\T$Le;;1L
8Cg*%7^n:P(umWh/hWdcTK"<\G(3VBh><.AX!!g"2'bG^)oTNqgg>&^FKb8okXg4]AO&"c)A'
)6&X2(BT[6]AV^!Q6?Q,:&:h-L2`sa3G&%lqO;7lE%J&`'ZeC*5UkQHG;_D$/g4]AO&J_ZeqI7
UWSA"n98!/X5<=nNdMZI9&%T*L12F7`)bgQXnL/dNTa!oLbrn\'EsU`LYQd$U*k:rsrtg'%L
&R;D+LmBt:%TqMYf)hE0@!(eKC]Ak4m*m+!]As+L)o!m>Om3Dqq0q(dJ]AGNA]AOd[+s9B#k+eok
fC1MJSLPR^19N\!/\O[q59J%Y*q4I'?7,nj7NDSP9!2,%9.am7J)^cT`@Y]Ao_f53%9;8)Y1G
9?+:3:WqY[FG_Is,"#1pPrj\Y&qf'qDYDtTh*lufPo5h-b`D6I,>3.Qu`aWj`$LT7k0oD,]AP
[KRZOYRAiTgOZB4JEVIT%KKU!G0(UB(g,L3W2/r?E0#04!3AFB'fsX"OTHhGgmD[N&!!T4#X
FmJDi#I4=t@,N2*>?=<::NO(8?4ODjl[6MQV:FcR2MhG7Ga-I,5qn%h:5[C7o=$LHgE<"(>L
Z3h4OXQM2Y$ojA@pL1%iF^utMP-T5hQW2G3H2-sWQLoDMmgnE)^'sRnAecOI:*>^@OV=p78=
V>MClG<&i.s]A)0eq/MS&09/_/8r+KQ*9"e]AYFJO%b=DJ!s0%Y;0hM"2,+$g5rQ?H__l8H_#\
4PAI1`2[:biMUGe^!/hHku+GX`;qd9HKWB/SaQ-\PEdEYHZ9i>>??([&S?N&d_1a3;&F5,$\
>caK[N`p!a&`:?[LY.sH1%bVUo2QnlL52pYLY>bA?8Ms*&%,K[ca`b^`K#Q:29[;uRAo2A"U
?*3D=Ynt/*5p^:ZWbSJ1+LAB!7D08Y"u?J(U%YAk'\V]ADqp3!(fUS7'8jaJc~
]]></IM>
</FineImage>
</Background>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9C$$'5,m>\(bII/TeH<X$T^6NPX1<>;+buZ<c0R:s#G3g8[^r[T66L(C;7OBpZ!4U8.uE.Y
4Z?.r27V7?%REMAB\i&eQ9r+G1pN0SGgHgb87pg>2^MIr.FEVu>?bT0+k>cCF^mRrcmP^?;$
]Ak<Gc)+8saN?VQnAiR*knY:Q(qiF1Mp#nJWe`QurhXPP_O1gr`4k:*UIr-G&E\>QIqh'&ZB`
HaT)ikt2Vk$EE^N2V-rB?tthhYK=MYC!$/q9@Dr4Z;rK00Xbuqh1L^IBe=lnje1V[JUiUs4O
4"*YT6kCRRBQ`7^2tQ:sk6&VkX'0LMPk[jA>&KDMq#QCV:Ld[cW+U-Y$]A!D"WGSk\M6l#746
QE:j:Na*rNSF"1gTLFYVSl9l!AW\4*[B#o_p"ARjl-814a",KfbrM\J,]AV-!V5+&M=E(TdcR
0dC?9W'e#+(R#AE1.i5+MW#)T$kf_>Aq=]AV]AF<dR!+1fAs)gqQ;u^f5@RZ<:JbPIiM/>m#7P
.&nXa>i`s@!U/tp+\Oo$+g+iN)oeqGP5N!on.NY"rHaG\G1<,foagdbE?@5cLRe'/1D$L#hO
A_X6\n/K_97-H/&V1`ogX"eRB&'1WA$%!2Z...:pAHHL0)9nW\TK3&8qKi_1OI9J5IXe.;`_
DMNhqI??<^m'P*N7I$9.>>7+)]AGZfbDD+]A#.$dIE53Wapo^')lRbREtctR?'PhGr\OgPE+1q
_QYTkauB^5>/#QUVY\f6Xj,&Kbc\rE+S,cuGpD[__eSh1.h[+fA\rKrNL)epNOJV-U_;5<M0
Z+2QJn)8'#/!UB]AI"jk7@HkDf*T[WVq`64]Ah2pLO*UTqn:"H+fVJejOg]Apg7FhAC:pg8;36e
:\E4MOpaeY]AG@-tJ^!N-:4A%p.rZr8*?>EkcbUMQ`I5Z-Z=d_c^FCaUhVJu1lDl19b>e9\$I
Hon@]Ari5*R`X2=R1qPE2>21u/-!'#G_Oh+9`$LsS$U\uail=uX?L=,D9^7)*OEd6<2-uAhf)
]A"XNu)[/*f(Wa)@:8m4VcXX[2Z_4rg=/6p-pa>G!=VZK>!ok-(4aJ'sg4A(,S]AE*SdX.=]A<q
)CWql*&JN9#o(oubA]AE:j-V'?1Jn1l]AP$U'XK5a<QH,'Inb(*5KA3hsa,e;is-cT1E]A[E,Jg
HQ495OJP$a,sCLP#l;7Z/PL=IDE_0B(fng3UtA1Q9pJOm%8dW;H1l\EJ:T5RMkF1;:*$P&?,
p<SB*9H":L3S\%b+<N>RFO.ME96rmNR--]AK_!f=!2cU<RjF;h?+6*X3)3t$dDU)n%tXGBh#J
N\9fd2E62a+2h$FU'[[_eRLD@6RWX-'AV4]AH2l>DZ+i]AORS!2?p]AmbTS&FC.RBXT0i<Pj_$3
Y<Fb!>ZUC,b=2`.&Mf?:)UX6oILj`s2rCGbYLbIOchAm1&^AE8sViI&oncZj`mNN!AjGBKm/
3e.,SO.V+omUfIckP:7Z636qU11R3mh2;>f6bjYE1(1C3i6aLJZFd`*[;,?a"gpALeI3(O!>
gEip=\'5ngR$1H@a3GQZgpBB<N7lOX.]AN=L$s5V0Vm#N)LVErsZK/g!si`9EG"8M%%2PMlTe
prV78V)[I,W]Ab!Tf@&j4YN>'FsP+bB8)Fm]AL]A?Y(B:a`=D,nD#e1[UjK3Bc!PpE:#he>D.P"
hC'8WVE+3nt`9Db,qJeSO]Ah9igM,t;t#oV-r:/>%%N8B\ANb2U;Ur"r,k+pj-LIR]A42UDB!U
`:gsJ_G@Z*Mjb[Qa=kF0EmN?1"$4kdTdBnqCNjcn]A-q@q%m0dG:`#tW<V8\R.T@Wl;]A9BNjp
BBRf:M5feET83oO+A%=[L*[Z#I(f$*H.V8udiHIaYA-X"AH[2mH`P1cMiBL\g>=">.@'+Sgr
31u6I)^12CduNs8/5MaN=f8AUHS&1be.Y0hZ7!_7jZ*V9EcgbG7;;?7Ro`^nDM=D5H`8Y0S7
TM7hO0X'tnZL9O.g/OZ\d8bp2p9(j%a!faf(92Mg%S:[e`D)&m:EbdHVpTt\1JmiapJ-3E1C
MEbM_JH_Q&l9CtDf0Pf?"s;9@Erj&ne'CbZsQ`"C`l3ka=QBB:'h_>r69P/92*]AV%^.bAo&)
L2O%SKI(cYo(cqf&&$JXJece_H<LU$98WumeLj0sNJ\jfDG*7)Q5h6W;QY+of:n)7u,O\l/`
7)i@)5aGs`FL9*6$HM(0<F!]AsP$Fc9PDXP\'9OGKP=[Mmn8S(`9;CBog>(e+9e?0,;RYDEe.
==-X1P@!<<anhb:C]AW^]ABh!;-P#WN%teoK!S#9aH/2OX)M/\?HgEnXh<eE&&Fmt[1S_7TB[%
q+r9;:1o-jNH^:h=0p(:#F@?g?7q)S3"tiu9kETIf5[G6>e57U&h##&FYg^QAPD7jq[%PLA@
0C"_CtSQ4p#6VGU"\as9nRFZIu88;rKc?e^*P2f9dIgdgX@^]ArQ7dWi!>ljpLZ&MrjmHilY2
-E%B3j_'O@tYK[P1,WDWfR*7uk5f+5R1FAs*O_P;S&,L)/X]ANH]Au7b"eLXaQ)LP.%&L,j-KN
L%O06'G@,tn`m<UgI@&0]A+3ep+PX'O;cns-78D^o.tc[R]A,QZ+D;cdPjU,FM+S^5g=rjI]AEY
hpP/a!=.\Sp#'&f?NMG6DdHdpr-&o:qV#/aOO?TB>KXi9ni5\m%gr4`YO%01OR4Fkg6Rg`qE
??acD_V8WYR_8&7^N>VMIa@^NoZ$[)6.$6H/T=#4-jnaACgYX(lRt<j!btcN%rH'<Wjlr.N/
;Dhr#S>n<>OE9>2HF(h]AK9h8<TFghU/Q%><0T3S\KsM7eo3.NWDO$R/I\eC6DsB7S3J86<;9
J>Kk\bZ*.M=dH8]At+[mI;)8RqX%l-r@]AcZM>'\(dD9`*"RCZal07/bIl_B]A%B+QBrB]AQ/h>@
f[G=WXAI(5Uu"6\FG\Rrcm(:_G)<dl=q4WR0SlJO-d2+.UR<1+Xt0:6)p?A]AE^ha$"Vdml((
[g?2-<LJG=Z6a,uP!V<-(AfYhl*(X\?ZZhqA+OD5q8[G<*jk^63I/Y;L@Pc$+<4nt=UA/=>n
l$u8+X0c2QDB8.k]Aj)L?uj`.86:/(["C:9@4Dr2r1E8/)t\(Lfc*V]AC^HF(N+3FT1!9&p13#
)\1.bmGKoZ?3J8'aaDtl,G@#_TZe>B6\@,U>r)RHS0)S=(79\-u9"jLJ<qQ[J_c1h+1E:CML
Eud=b`t9$4bN=6JVo',?i[n=,(FVDm<XoIH&\%Q#?k)IjqnLO#D/3@]AT9+f*7c_qpB<@BEb\
L!s/7E;H[ie26/;:\>&e4uG*`<-5d7Iln:e*6_T`o6957Ac27f$B+Y\Z5,U9:Tn[L)+8]AY]An
,\PI)=*Rs7LD%j?aYsQY5gRqr;r8.8*LXn5k`7ja:T!iFhmU7`/nGODd*gM2mpDMN6kCVqVD
8*0,.r>o"7s0YKnDgbgD#rUMTOJ!+J:S6Jok+b5D@DoRi+1[QsR>EQ[c]A6(0DPE!BuH]A&#=4
5SMo\4=i=&QcNq'nnG9.$Wh)M5e'U0lJ6u3`&S3V.jaPKo<0K\R3cDoj6CtXRJ1/KfWg7,LR
bjML,.W`SJ8IGu'EmPckEY*C;e)%b\Hpa,CjuZ\RD)kL,l('QP1a-US.Sg%Y55BsK#N__D`S
]A-YQAMh,H`hqJui:53?!;`))1Q3dfA-Y=dTH2NL$l=)Wm@i.nK"_6I/hB+7^&\44[ei-B/=s
Wa/O8Tk*>AeIbqFlgHgu/IIco<6+pnee_<q>rISA.;E7e3uSB99#/SDL9%Jd-I=!)5r!5R%B
VT/>#\0Q?Vs4c:GjI$MOmINpa!f0Z7q81Pq@"1==0o![,?+r'Ue2/+#>95L(NFf`l0'c,mE;
Q79b&]A"KVT['Y$g1)?u;[^A9#-Zp"LP\CGoj&LBWCJSqU7(GI)0VKh`D`!XFM#/QHT%A?J3b
3kGt9d=C_9,B-:5ufbGq64$!6(=)-:LbbM-$;h`6@(9Mn3Cipdcu+;uo(EM*=bP83q1<N8]A#
W`##KVJA*.hUXqTbIO@H\3s$PhO5Y71#1C*R\AmuJ%V8*)%[\V59>fe:YSE@-C#u$$BoMOb*
Haretotm<#I&r9dBC+DF3XTLrrUHA8]AcBA#N1_Pk-[I-,RU$k/]Af4jJXjA(W6,0Q80>qni3+
_>.m9>d9RosSB^_fTQFU2j/bf&'&,$6*KRriXM.j@Iore9M%'?tYmh\cR#*k'ge1VpWq[uIA
P#NN%k]AsV=CXM.8Q]AtHp"fNIO*g'n(<:_S!MbR#O\V?J%i%M!Bq\VhR?T9R-tu*bOZ,<hCXe
7VkGkBgR.3/&H=Uc^B1Hi_&sI$-.UOGOV7p*#*:)<^DV6rf>.".oIQ:gZHI&)qkee-5SS1`:
5I]At_Z;Qbs+M9Gj*dOH`@PjOaSXdRW5L/;!E1.1/!;qq__s#RQL^[XJp61d5No+,<Ih8o]A=H
nUud3*cLO(3S%TQ"'rQ%YN5m]AB0mIaLkh9\n6%4UlLAdI,EGGb$G?K1/aqZ^34-8bq'R@76i
U5drRhdB-k;*]A7usKE_qjNERL"Z4PecQH0pRqqE(YL>Kepr<CPmOeK!JA6:@8K)`2m<s^$#K
^nak_TTX_\Pg[?,`OMS9r:6FJ<65>22>;gAUae6>95m5UTDaG*@idJlZ;\hSk&V@3UB.;[3]A
&&E?'Uc=t10f.$[6=5Sk\Y-(L*Dg/Kfprc7Uf#5S\9NYMR`:F?TV<U]A:P:+VOG@d'VI_4I#m
=LiR@\V*i\q[7i'&a`Lbk3+BcZYt(:Sc9.<S:N*MBAufZ&hc@c>f`[O)b#Kn/LF'W%Q)6Y[^
YSYS&8&,$!W-V=u*r`/;>)iDR>ZK!hpdE'%,lU@1e.:Ws_&.TGTDHdnr&MT#%g-/LrQ[N`BJ
@/^UVN)EgcVd%q2Qc[@8jX.9m-.@jC0-'5iC88T%njaA83SE+/*Op?bHbq%j*fn;!mrX=)2D
g_)q]A1qJ0]AHb)666]AL7''WR6mBeZLR6;8..dBt;"SXk:>"qMGD9h]AM@8S8iF4$<gf]A9TQ3o:
QFha$2`33<,3>)VR*"X5tAi=3%A"H@(#GML8JqH5slAOF]ArgXd!+*:Unc6Q>A!k-YkkksI1p
%eWdk?ub236L@rn/1l=^m"!1(5WNDlH@JHUWXdK[*n`s#CV?,sc#_,S<&(Cb2]A$WN]A=@9e^;
@i4Z\>=b\><U)P$F"t:Z&jooCHaV$3;L%f;,n"%VI%b)s[Rk>LI@I2`<(QQBq'[OX(aj'A&M
fk$!D&cj77'AKsh/j8jGL`r]AB%kL+KB]A\KP>V<n\*XUu:YD53Lj[oQ'Z]A&F&MIV@E"go&&"n
I=P4@s!N$?-TEdOZXQ;:%AmDH#"7+9!FAX<D2&,NO3gZr=c4D-2U40UR@-@4o4$'A7\5uO<n
Er\s!N=KsX=F?^QY/0hPJTEE[!6f6^%<S\+"O]A(RLb>/dORNl*(iWJNVPFQsaA8>eCr5U`R5
)&Wa%d83ZD_Q3$?H'\$W5,'ZdnhtJ@nVEAIb"QEL#E^AjcAH#=<5&iFMXajd4j%(HjaJ[Q_5
l5hHf%lmgdHO%K_(V^3R$0GUJA:hjBNlFiSmUGC12&)).CKVfm[kMJgV/q&q5U-9V!217R7-
3gLr\fO%jX,s'0KiY9JA8]AMd%9iAn*/hRuFt,a4Kcka&iq#0pWmY/K8Z-[_cnancMuQbedp]A
,K:G]At_50lrt8b=%<Odp(<:YTgKNgMVRLM>/^=Za-!*LK<7t4.;8tnnXK-06glgWhsH4G2gO
8n,(\[PN%g[Ae\:;H7cn>D/rkh[L.ZHo9&C`f$)G]ANmRCrr_&J/DHo1M0W*$elfFlECYQBGE
[D9nXbCq*40eG8ilPuOTF.,fr$u8Ee3F@JiOT?ESF/pMgV>C2*B[9,$r0eZ".sZ7$oA>Y<Ea
8BgF`u#q`e:lIW7"A.)391K]A%)#rQd(BrnjQJt-DIKl5YB!<F\XItb'iI",)4dSNsOV-CpO7
Xe>-1%9cZqDn)\?+4Ih_XpE?1'i,LT-_I%n>+jrYNI%j;%K*dTb/l&h0.d,R\=kY68:nifPK
I'UaA=re8)IIfn>.@]Ak4+lVZ,0;jWZV@',RdQ1nF!U*OgQ>6he>I4<j3nq+J&gB8j)-!R:5t
c<3u<5jhJG&qig?2,>\j"Hq'i+j@4D5V'N#=MQ"5lK0m7#.K*`9'^UZ4_/ZL91n\&sj,S&sA
$+pNI4_n=^2]Am=gkoDC-R&F]AR;>$$EUi`'^Z-V"1aYR)Nf%O(p="BM!'S))O$L\`2_pLi2_*
'/"\@%Du7%9)Ii.k^p@nc#'6!82$N/Y?fNlLi1ouMa]A_O#:Oc(RU*^R!F^0F[S(r$0L1M@7&
j]Ahg,I*:]ABD!c*0G-s0Q.V-t_$MKG("RIcurol$B"a7\4WID<4AXRp&"b`:?O4P#N]AgdjB5^
hR3;AQ;e`Fa?R",^MeWMRG4*\[@Rh;OX=oi^?toE=\ME#i3l,Q%Va%(=TRX;4Dj*QKHLY\gG
kcgsS[7aJZbaf$ToB@8DH*0R@4eo)RmqA3/cEEg5LXlFkRTqn<>j1@K/@OnkN]AN28O(bZE?d
B'LUb,9#`ir01]A^(IX"OB=Va"]ABdRGQ,J_X4Eku[GcW#Lj4L["C=[iHC/<CoX;C?aeuOc6:T
dgn@lBZd:X?0/>,e+8J*6<mC@/;9bJ%O8(Jd0NPAHVCC:-"+hAaB*$N9R8*02nLX+"'IH9/>
f<7sqeDE`@_pL%A(PP&[q@J\3n]AjRbYSuLlRY1G:k*A@K^7OqWpZYnA.=foTt8)?85/^^sK<
+Lu3^2l5j.79t\]AE?Y=#+']AHi7UrLqp>r+gu%.:dBVHD(]A=bE;]A_SKqltjV>tUBMdrRMl5)j
=TTb`K^7:crd47d]A([3a^e\LVS3NpV#cG%CUo`!O'/Ws&!^rNrE3eNd!3Bou58!f"'<HI>rX
8*BE?rqOb&^?UR<*dFGR+*[V&mbY_@(Q";Bf08M!,qWPR3\kWCoH&<hbL*tWD24`(l(/[UFc
!8dhP6&!i0a*Q7#(I,Y1$=XSU:qR-hCCI_F'"ijVY_bCtT1G`<%+<Zj%fU[/VS1\M[>%"'KO
n(<<@Z[cI%*FWc$HO[XhGXHCI69gN>-(?@n\\4^YAU[7Ht!u%V`k)?G0CXnS^CU`uo&^Fs/G
a._`rO:$OQ1:nY#Bg-S_JE\]A/d!po!7tUufZ[!d2nq3Tm,\*gE9)P#UZm#$l4G'Cm3'[Wo>1
OW?d[X&J2(_/7s;j22NMA>pOg`f;/ED9h[LPt<AE641@Kj0kI#6:?EKc!$-M?!;'Cp(e-3d:
.n9EDVQo:\T[6Rho:84C=um_Tj2h,2+YPL%]AU^EJ!N@nl8kD</D^J#2.*9W.iV`8O/pcW_-9
.TR#Nbsb5P56X:r`=OEI\qrJTA8&MD,>h'?pC8:<Z]AM!3+9HV)Ek3-o!P1DMioYO;$4VSNY6
O9'Cb5cPRl4%8_tKQgoK/p**<??V)mg9-4T/"l!(Pq.sKX\-a:tipRP=MpaiuWS(oj(r?+d-
%=7#Ym$RmH0o"`NAT#IRXZC(Lm<KHL^#mJYRGZHRf'cYGoWKt!W)h.N`]A9.]An%*;[;-$,B7R
EuNQZA#)qJed,o&BPp[9I[2]Ar(IqeH(+"5T.8ap?0\"GC-W5,1.*JV*1WlIC)U]Ac%=PM33MN
;@[AgfqW<Hb:i3oYR.("%VS`)59cF4%p3@?ed(s@g`(Nq"Ufe+b5M@^*5.*JP"!>CSTX,BLO
dKQnj=I!q-fb&O%.`F20p&[OL4.%!Y4B\IBmqj@u(W%)+F1F<>&L<=>fNOjjaABQ14RpLFH.
eQ`brG%tM*Jl[;p8QuZ$"i>p=S,TCP=IBl8m&^]A(3j!ErQa1+e:++Z1@qe2>PHst>_nTSI:-
%5SKGQ,)!846Le%Wp'(P&@AC"N;Siogr4!L)0i6C2$BGU#/r^B\u6Pp"IWZO+I'CIVa'N*fC
E=((3*m_LQcfXeT$u7nQ'@/&^2B+/kT$:ifXEl5D]AdogHtD+<J'/,93>tr3spZP>\aMQU&\n
UtCBo2(%H@6!7>^30+[8?36(WPglFbPnS_K8"2"3n3D;;&f<ihY4pCBL&f^_P*YVWngZqPAh
YSEa>"LK*8b>PY0dr["%WX,7:k$0;qL&.fDilDBNo-cK\8"k(h\KPE=uciq9$hoAKNj]AqOag
%M<tUGo-9NB/1Bg)i@_YbSlm-F<-i%U&0/Km!-HEm("aLcAetKXA9_C#7921`%JTl2<u`'W1
MV-ZC!OCJ_"T8Hj21WL2Fe7"XF_k^%U<%!%m',dBm^\[5aVus$j3u2;2MFQj?@1imXo\0W8n
Y]A9M,HX227X''c@Y(EX0>\k(T]A8HNEBI3]APZF)<]Al:h"uHZhVoZ-BOa^66Jr2SkrUJ6D1I2S
(?9Bb\CmL5m3%:KKuL/2qq3dPDju0OV`u#XY+H/4<O1nh`:6n#GUrVVD++P%GBn:@AHS8\'6
)3is&jB$OdZGL%1**/TZ5-H/P(;O3aLbSq`A<?LZE6.Zin?iE.U698AP!OX$B[)\Zc/-]A8;I
pg^<?"C/>6(h9.GPO'/nnA=,q$!paogo0q"r%/$VP06H<)/-+KqmHi9"EMbnE[(d]A(0GB0%q
3lIGpb5.(Gag@6-USgIG`6?S/8)5ns$hg\GCaniRDZcV9$`IuU*&54fk&T45]AtH@T8/>dp4-
la@sTcF)<_9#$M=7>4a`F/34S;=2^PYN+IMK.Vqc\HF0R11=5p\=lWLl-:3lQ^ZU`>SDOS<7
XOe"2PdIRE%oaPt>28._QF^0p'c3@'h:MU:rL`[&2pP5O/f,e0LB#rPS8rk'[VXc4R]AEL-I3
&@cf70;S=4nlTI/K`t-4d]AT@Q@.QH:&Ec']Af5k0:/*?,^4f)XaU4[Nd^Fql%+tk-cNQ_s4Y8
>'Jq,$I-GA#Z$]A.p4LZR$k)g)<qV05DIJR9fE;BZFbhk`fMT'&G6A?0*rO*BC!4\i<ZIshh6
7d/uq$2so`bJ7$^iGO1F;l)(^0,oL(p>]A44E:>,kJ0CK;MK9t`Z8@s\tFJ_;,m?@8J^gV&F#
pLo<#9U*IH,"Q8S+/(LI_Qc%nl[mon?6GShFb3<6[1E*j>hP9S`FT2WnHh'5(#7VYa.,Fs@_
=7Z,?b`fRU!-`!+QI5IkfX=!m%d?dqTg6C/Cs'FC]A'JV#Edi$N>PHjF*EDaF2s5&/*%IKQ0>
7u6]A/\C[*C'MWh#J1k%tZM\NL7lMDuqRQ%7pd54JD,pi8@R="q:SA<PT=_^"%KCX)M%A'g?N
Bc[T_?2nT$2n\GEEo:^X?UG(rbna1GPPB>#j">hE=8bmNi4$WuQ8fgrIYfME=J5Ie/=87DQL
I4&iQ_ng%[m+X>-9Bu8]AcT8!!;VOQ&c(1"h[l#::&SK=ZYQdAd,Aa0Ksf]Aj`^X)gjhY=L@ql
GC7!fm`LSYpEQQbg1DGeLZ)CMa)n-[*)<l+l*7L';Rp1PW[)SJ#,OFSK*RQs>[[,H##Bn1F:
#K$hHgfFIW;'B:]A>>'$+HR=:T"'`@]AkA,-Y21XUJ(t$eq(G*EF&=<cMokJc6b=(4$4g_gIp6
6Y62YmI;aVZR(/s?I864UlBO4XpVlZkd;\h.jeBRpG\l)>%`jmbX1(ioO7"nZWlE[srJ$j8a
eGs`DTE.QP;i>3_*^pDE_6l30p=Q09""QtE(>8N>LNVUt#689qQ2d%V9&YJ.?`ihCZ_XUaAD
dsrD0pt_>Y>$6/F?Dh*LQ&r^odS28O^QKlK54.R4.a8Q=Yin1$n=L'S7V[Pr!^Y\YuC`VhAO
`$GER:$D::a@Ih3q)^,';rH7PA--M[^)\[;WO1B?U)#A0Eeb@'!%J?V_.M+9nF^A^B;^YlQi
L/n$=Rb)s,$`Q=nfB_EWV(ek;)`lL3MC:hs0ZaQ`ecUe2&h15CSR=hIKAD2_[+aDlT,)B-f7
J[42PV/5H05Nq%T,M53fk=3p[&-CfMH^,fRs:#qOq@$7.TUoTQu\1V><^n#U(;1jmN8;]A/4O
rk5m!bIgl_KEWcT[6B&`HY%Kj2d$cjb]A4iN1nG0#Gee&Z#gB$E:"<&8AZRrt,"N=ukjH>.m[
XO@TjU/LGJC,m3cD$>Wl#AHV*K00&1%I7gkt"*_m-%rN6Xo+tYU]A]ATN")SZ!;ELZ=ih7<`0E
c]A$!+qNdI!&I5_R[CFM4&AiSP,IC((4L=n4,j113[sp&e4A"uHMfX@=*RDhO/-cF-6MT)I\,
mJE2%W;<::BS]AE_JZ]A%u?EJGkWG&?I6N_IkW=7j]A&es:=qL]A>m/GZ#',-h:?4[#$IRfe6GB'
^Cr)>Z[1+9Mlb[Qd`Bh[FLP+@X(q+EcBt;NE'qK7VNq/!#^Fl7cVE#'fI\ZS)?Lbo+umU55C
2J21QW2OH!On1akGNB4<85j>r3N*LitWaXp$?pDL70Ek(3&!8Nn5R"'rjf_cGL]AA"D[:<Ac6
#'!eFqFkIHX^YaaTFpW2JGHOnDOuKKS=(>2sp]Ad<uU/oB]A'^8G1LN'/+=8bB9&$ph)BsP3M8
j:OY^gh!"u;;LEHhLbR&unNBFp/$D]A0lC>3?,kH_o@XH8)B=mu]AMMCJn%O8ZJ:V`R`C]AaCtJ
8!CX%ol9a\P\TgcQ2t<FQns$/^+h2pN),:i/*cSI8rO"[I:(<#"3kft;hMuF'7`fVi@uA8Ka
-E:lfY,ASZHP(Z5@&HEgHk`(0]A75a_SQMp"bqHe1q/K@Y;U%jps@QabVb,'+\!27bjo_8i9H
F-r`oNqjhiE8MA#SU-sBi%=sM9"Y$.K7Yj?W^IFH?f82LAkk?^JgZ75%q^LQF4V#-^"7QL!Z
X?`dha_0:OK"R3aN/:95#AX,ZQ4bV7%cI.$c*F/"9KTb7XfC:6rZiW#4[ZZkb")@dp>'*qmZ
V#hZ~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="22" y="66" width="375" height="103"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.RadioGroup">
<Listener event="afterinit">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[setInterval(function(){$(".x-text").css("color", "white");},500)]]></Content>
</JavaScript>
</Listener>
<WidgetName name="p"/>
<WidgetID widgetID="d25adfd7-ee98-44e6-b712-f93aa6696dd6"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="radioGroup0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<fontSize>
<![CDATA[14]]></fontSize>
<Dictionary class="com.fr.data.impl.CustomDictionary">
<CustomDictAttr>
<Dict key="日" value="昨日"/>
<Dict key="周" value="上周"/>
<Dict key="月" value="上月"/>
</CustomDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[月]]></O>
</widgetValue>
<MaxRowsMobileAttr maxShowRows="5"/>
</InnerWidget>
<BoundsAttr x="597" y="11" width="172" height="27"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="准点率-机型维度"/>
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
<WidgetName name="准点率-机型维度"/>
<WidgetID widgetID="22d7bf2d-9cc6-4149-8b84-c280c4274407"/>
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
<Plot class="com.fr.plugin.chart.line.VanChartLinePlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
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
</Plot>
<ChartDefinition>
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[03运行指标-机型维度]]></Name>
</TableData>
<CategoryName value="mp_fleet"/>
<ChartSummaryColumn name="准点率(全口径)" function="com.fr.data.util.function.NoneFunction" customName="全口径准点率"/>
<ChartSummaryColumn name="准点率(考核)" function="com.fr.data.util.function.NoneFunction" customName="考核准点率"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="30485ae5-2ab7-4525-86db-8b562b15ffd9"/>
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
<WidgetName name="准点率-机型维度"/>
<WidgetID widgetID="22d7bf2d-9cc6-4149-8b84-c280c4274407"/>
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
<Plot class="com.fr.plugin.chart.line.VanChartLinePlot">
<VanChartPlotVersion version="20170715"/>
<GI>
<AttrBackground>
<Background name="NullBackground"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
<AttrBorder>
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
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
<Attr position="1" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
</Attr>
</TextAttr>
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0.50"/>
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
<![CDATA[03运行指标-机型维度]]></Name>
</TableData>
<CategoryName value="mp_fleet"/>
<ChartSummaryColumn name="准点率(全口径)" function="com.fr.data.util.function.NoneFunction" customName="准点率(全口径)"/>
<ChartSummaryColumn name="准点率(考核)" function="com.fr.data.util.function.NoneFunction" customName="准点率(考核)"/>
</MoreNameCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="132b3991-b71a-45fe-b8ae-e8268fedd117"/>
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
<BoundsAttr x="448" y="38" width="288" height="145"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="延误-时长维度"/>
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
<WidgetName name="延误-时长维度"/>
<WidgetID widgetID="e29fbdf3-21b1-41eb-b901-4f5e592cf963"/>
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
<![CDATA[延误时长(min)]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="3" align="9" isCustom="true"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="80" foreground="-13421773"/>
</Attr>
</TextAttr>
<PieCategoryLabelContent>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="80" foreground="-13421773"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
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
<Attr isCommon="true" isCustom="true" isRichText="false" richTextAlign="center"/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="35.0" isHighlight="true"/>
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
<PieAttr4VanChart roseType="normal" startAngle="3.0" endAngle="360.0" innerRadius="80.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
<ChartDefinition>
<OneValueCDDefinition seriesName="延误区间分布" valueName="数量" function="com.fr.data.util.function.SumFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[07延误-时间分布]]></Name>
</TableData>
<CategoryName value="无"/>
</OneValueCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="8c7bf98e-8e47-4d09-9b1c-8a61ad157294"/>
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
<WidgetName name="chart0"/>
<WidgetID widgetID="e29fbdf3-21b1-41eb-b901-4f5e592cf963"/>
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
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
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
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
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
<PieAttr4VanChart roseType="normal" startAngle="0.0" endAngle="360.0" innerRadius="0.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
</Chart>
<UUID uuid="6960b153-8272-44ec-be0a-d5da1a3c56b3"/>
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
<BoundsAttr x="369" y="419" width="249" height="157"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="详情链接"/>
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
<WidgetName name="详情链接"/>
<WidgetID widgetID="843e37c3-c9a2-4e11-acf1-f0360ad6f8d3"/>
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
<O>
<![CDATA[更多详情]]></O>
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
<![CDATA[/347732/运行-延误明细.cpt]]></ReportletName>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1" underline="1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9P-B'3DcC]AC"&7<`nfS^%<(,mV]AMANI@T<5PRq'U.qal@-'#qMiuri,BZkGDdtunhR21pXc
fco#UgN7<UoUq>g"V)KZnVQf4`N!&7bm[<'uV+^bglkjC;fiKN51g:RO#b"*H+frgZ!mSF`?
HGM_6S47='dOSLeac4?QE@9?XaS<\"Fs(,<b':c;2n#q32#NV.7<r?E*=BI#dEr!$-*OUpAF
k\hPTe`f7H!Wu;7p!/NH5tcXB"Js?#CcC9h!b4<n2hS@Y<J.cMq'p5H1-I^kc9.3glrgCGJN
J6O5^XC6hkr%"7)-*P,+p#g[<k,H;7b9B)B8]A:0mMj$Ob:j$[m#i#_Bgl-1\P+L=MJE<#;b<
X\`n[iLp4MZP?i^nNb:i@7TIj%;U2qS8J;'7t`KoS>]Aq;WjW>\qs+lP?8\Q^pT;FVmsX5c*\
i-&=BSeEg.tMChX-l0^M1+aSOOlj6TC?-0]A.fW]AV]Aiu.#9TKIRS-VKp\#62O3J=MX=+agg\I
pVD<%,IU0="0Y#>=oCn2]ABf'u-rdmO>`"O]AdI\WQ[-l=0;`o)lTlQH42mM^:sM=.As0o!U*'
FT`s\X@@%nE&i_WV!WUSs11tHdA1F"LY-j2+[ggIGrkcWk+tn)WaMSE):QgXakX"(k+PFFCD
kj1ZQ6sZ.EQuVG_6oQ+Ap]AG:Al7Ci!iN=1I-9g_)<UP9^tQS1?e(@iMWKDXD-pFddU7d6^@]A
jt!5fP6JLs9:a)8/>)T0T8tt=R@F:`nV+"):r4\dr)q604u0WpqfsH5:7VaJZ^$lib-noR[s
I[IH<o<Y]Ai7#>h2t%9jB'2a8#Ei$+m:Lq-u$2]AkX\"`T?Bk$)l'pCBH\]AM4tp"oQ/Em<(D!)
+;Y:Kb/Pn>$a;,(X&cn-N>Erg.@E43i6FO.d*1>X?(&D^f[bA`0@FA%`LY;RbOoPG8EY=hdK
Z67e1np.pKnc#[l[u_1O3)hueIu@Q\AZ^23.9khO.5p'gO-ec,@M$A6k?a)X>*>W7=*16pV0
eq6iMdeL&+_@aS'XALA[3(DMVrM5>FD?oJRUf8m4;+M5N,^/p&%dq9fX?@EEsCgXtO67l$O%
Mio.QQ+,D[V':qiDS+/-jrQJ[e[Gc5Y>r3XOn^JsD/9?WLp-%tkJH-;j.t)4mZXITaM2lu>W
jq6OtO)&FHs/H?*!BJX,ATmA):Dhc-RXfX@Z14?=5+nBe'@ID%MW#3_)/T7,)'&[u+9%J+&`
ZV\$]Ac-r9\BJCp==D;G/;gU0VHAQJ9+'fJ&"Z.Jm1T^'dgRH>Ff#MKM7*<01?BtWV!U1gQ<j
knNF$AY?\PH>b`ep0r,0QtGFCo(<:^)'XLG=$8RQYMq8,)2;o#6&+RqkU!JA9!j"m0tcd5s:
QZeZPWB8fDFt!QXt/jc:%[bDs\n>#8#"G"-?K/fEJh;ru'fSF1W<fE\iflOhasia7MP%rIUV
BN_^B)Apsl74Q.='-?m_9#J!q1^0iB7_*nD_!>sAoN]AjP\U<jYr0,*)Fd9JKYeVh0C3-T/]As
iVeotFX4B9eI&$>"[/dEo%JS!dlTO!4]Ar<3DZH6JaZ:Upogie)\",3Rd;XhS//Emn\7Vgl4e
OXG&CUnD#m;8bAhG`qdcg*5+gkM6Ei\2C72C+""Za^(AFqrm>>GknD4eamKRsh:_,j%;G-S5
XY?Tn3UbInckpFJg\qshg_5Re5ZKCdbU6#Hn15ZH3%=4q4bFumlcNg!rUQt-7$M`-bV\2c2'
>FD]Alc![/GHtMJpX]AIgGnO7fick2kR2uZ;P$H4Mss]AI^PHp,3A,mE9o]A1iih2C2MHA/S("Gf
!$k!4pA7dhW!>;3b#TQH?a?=#&W!eJ3/2paj'1!3HRrk'"QiI-%0=*-GJX)#>-4rm='QKSF9
4BQ9/M\4iZEdJA7M%%(aTB=@2$23'uq]ANjI.Ok):^%T@U<M`KH8Rf>Zr&1e<8m4-2$Vf*7I*
W(`3>V-P/PX+OBirm?+,Fl4A>LdidlX`jluH4nhL<ons,/GPTaRq(j4$9S</fV!M3sZ^D"nd
02:R\^S@IkcNTW9jZDD384_s:0ll*=WAA<C;_WQ@5gqI`g\R0N=[979jS96@3,lh^-a.\6am
k"DVK:5=10t>CN`)RT_X1@6V8T*A>V"MD[JGM8S6cDU@`iL$D/3+?X-TTjMEf?A<Ae*]AoJPZ
cMYIV&rC`H+SA/2W/$-p[GJK)gp&.]A^]A>;M9T?-"a-CtEpON:e?4^K>OCViFJ-3);m)38nV,
)O,AUg;ih>)o9)VD6KZ-&#.S]AdDuKum]AAWKel$0+e.B0K)J5]A:AR]AfA?2OBqXq*0VII=P(qm
#%s\VOR#(.dWLB5#?iZLi5G`m;ATT[s-i93O12umDAompG-s6;YM.ZRR.MSE"'19fOal"El(
M5=rnZ52J=\U.#?:XhU9H#\p@]Al2Z.M2,tPu?o"%sH[#UX#1u"-!?fm'aRbLXVoi4U`!GB41
L*K!.r\`rehckSE,lTUf\NpMf`pOFG`j[Ts,Rmf1iYbaBcO(XRP#8p7;m$On(WdQiGXF\/06
0>dQGj<#lWB>BQ4lRg.<;%<PgMMp);QO[<O$N*+*j=nZcLE(uWBO/r%fa-/nGA[nN4=d^]A$c
'Vo,^cCT?1]A=+2=C339rO9\%?`V_D/Y;FcmleXn-4kXHjcAhC86p+OTA$O)[r<-AXp"FY\L[
3:)Wt[JJJ?iD\H=Dc5"pn@3,k/A.CLA:"83:4Yl-k:**OeX#:%Qs''#$hK&QeUqZ%7W?F+2b
/-@3>u:HrmYC6#b4*U?@W+s,ANG.E7qP7T"&9)>X'H#er:t4JH60^3HTH<q0#pWYBLg#k)A&
%531=H-"gGDVipaIe1DAjMGp(@H'9HqC)NaZn?1q2S5fY1-)@\<sdUaEC!PMBdmCUGL9$nK4
NV)=bEe>Y=+15lf2UR=<)hTA"(>3'fFj[.ZbfT#HL'F8bQI-88$0Q\r<,)+Tn-0M[JQW\k.K
o:CJMg>j+W$O.g%;TE]Al>hrB4KrLeDl]AE,fC:=l,9$\\-a;CGol%VI_#eiZon%UV-!PfWsP;
nGK\kn^^dIH^b[QA;%3^W)8?YWK/beLN9L&f(^<VAQKVfba8$+q!Gt#F'gA%,5od-gU,!clL
0tSA@?'4EFit5'`Q(gd@q.aAlVPR7Le9p%L:/Y$1%H;_bt2K\Jln&]AJjKRBe&oDVBF*4JAEA
0F*kMUb,e5%50Ji6o.2EU/r_1_DQZj".e?jP?;r/ajL&(f%.Mf't(oq@Bq.rB+1S58]AQlWF6
*."fa=UTkLE\2M-1_#=lZK_Lkf\7spBOj85c0#(&$P;]A?f:ce)"%[O,]A;ZdkO.!dh'X0Q5+#
rl^.1s=ZVKtDrCQXJ!Bf[9g1D\7MKJJeu+g#Uo^9,@d6,7d^Ua;d6X`i3nRKgcmqI;$Uaq+R
n"9m'Per(e?!Vq67hiaEq$K!JOd8)UBG>/TqS00[nelN?Jdm7=$2;_2sC/Lj31o.Q;UaRc4W
E8G_Z-TCT,"l2o_`\n62A?QJ3%8(o[B&N@eO>ZAN=-#iq3I!/Q#ac(eB_;*<>u<V-k->)KW@
0_"<OuuQ332T+E[>!d#ECGGCe!U8c-ou^*grIm@I98@0@6%b>Do1A`/N1fJ%I*OE>ggJqMAZ
2Bp+jr%7@t@Xq3R67<Bo-,F+1-^9^=f6'5E,9%$p,?j,m3NRRq9'l!XVMOA8nZ&]A1Q5t88J6
SkA'>$=EqY8j0)`_aW/8bFH?ah+`[;E_[rq,$]A@o*hlKScu5\o&7M!+s/LQkUY(BP94Kr0b8
B_YYC!Q1qL49o?VhJ*Lq:#\-$_lrr&($t=*nE+*#enX/)cQeHK)E4sFl.L0fe<QP^He3NJM0
Us*8f6gH%LBk7S')]A3+5q2`@rCg77cT7d3%hoBp#g@>!Xc']Ao5?2.*lCs(`7aYHd92tV_P(q
[Il2^,7f\nR!,r[)I>;?[\\!ciQ/`6V_i!P)DLVTWS>FMrMH!W!tpg^PH@-QuZ1?F@F^%(#\
Gd,W\%.i-`9uKQEBooin:FU>:QjaC5R:pZ!=D0S0D"'&t#Zt-kcg%7F!V/2'O<X*k(]AAlqR8
rWp"C@8^5p$_k"&GWWlBtOf2i9\F#6R%0i-m%BHq#]A[E/=]A$>)*PgJi!/5*Fh1f&#-97pX6j
DJB^Bf]A3R+8Xj>8>$dlk9gJNL@&4_o+rc\S4&N@,Z"aIHFA9SGY#UEnW;`@h:Mrh1VNWKYl:
P$/Cl0$<_S>nN@[hXkS+5FiKc'fY."P>b8+e:r$53fU"Z/Bd(Gg6Jdr_bKPo>.rrYrDg9b;?
qseZ>fq*Cl.o_5n'r0#HB:]A"er%d%rCX\XEio<bh`S[j!f/"Ks;X9]A'K/(nmXiZn0%;c'i,V
rV\i2<%N951MSYeaQN;nJC$"XB5=f-#<id#b'Qn&R]A"9&d1lLb&$(lZ:K7Gg#P17uX<C`de'
sM`MKd9-Zkt2C0F@rH21<YN;gBFkM3\4*r,uDICst6)l1SWt+l4FM,/D>bP(BT759n+%9,_Q
3!TR*"*Zi5XK;kJ>'BharBcma)<e-rIru!22`dEn79T0.Y85gV/0C%!:1W?Ehq2-RimiBg8Q
bbc_4#]AgTC:-,X)GL>,,S6CK5sSiLD@H\`pl_QSNSjD#J@UKbm"'7.QatIS[[Url;4\k6_aG
Ikir#EDLR77>+D@f$ANB0IK_dSM=@q^fA%JJDH/MCE6!gqjDLgC4D;tn?<t;)1]AJVOoTUmlB
i+3YhAJB?6Be:.6`Ji<^8.?51K?Zac+P0XsROePHG'[7?CT(MJi*2TnceJR[FpP=7e;ZB5K)
o=sB]A0oiBZM;a[?3qUA*n<*]APG$gK<E'2n<dXhGT_&#*)^71EM,)D-c0V3.H?EkOiL7mkpRW
37I6e5o9d%sL?jCtC7%%8k8e=>;-q/-:&L032,D@"*M4]A\%K+.<3N#i,Z;pBSc%@=D#KiH1R
=)+VaG^C<PliK2(PP6pW8`>6)AH*AISL#sKb/,&>jm:;.tIj4]AVKB3Lk/#]A+o>H;GdnbfcU=
8141d^+cScgFI&s"^<R%+V9>d.9^!uBDE^J42PiGduQ)t]A7082-:GdPMC*28!4boUHk733U&
Xd1N4nQEf+Uho'G5[?^U`7'ap?qHH=IhW&YESVn(dh"?"cK/(:-@cT#la3i9P"(/^b,9]A(3U
\<grFu$;(W9ejs5K5D?J5'a)#7CHipGj*?@V]AnrsJ~
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
<WidgetID widgetID="843e37c3-c9a2-4e11-acf1-f0360ad6f8d3"/>
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
<O>
<![CDATA[更多详情]]></O>
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
<ReportletName showPI="true">
<![CDATA[/347732/运行-延误明细.cpt]]></ReportletName>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1" underline="1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!?'5+o>XBSt'Q/ckbm?*K6"Au5deo$TQ81WEAX?r]AJdTRs_'lC!S&\495?+"q22'Zg=WY
eVQ?(P>ZH+[u(QXm\=$5!HX.b[.b8haWY@gHTN\]AgK"ASk52Dt\bY+D1VCq=;f)^>JhbhVW[
Jr6Lj(d$Ua2qrscHTJ6fjbZb\ooMe4Td"oZU(eNRep#.03:f-9n$g55&]ABk1;9e5+,48Q;V]A
Rm!%a!1+M(aa`2*;iFsp1_31?J?J4p#_4923FeQEHpNCn'q"^WVa!<F4Q(P3*`R8ZK+@iLTj
D*s&#A5bFYuL[II/ZTrj0;%r905-a@.KhcM\d;Vd?1;bGu$pf_>6,9j#Qa+jD.llE3=7-)+4
HKsVTqjB"_Ec+s<9`EdJDg^",%)jaG+@AQ5*CIifn%[eS;85;:6>`#AmTI^On\\p#)"m^$lb
%=,V!)CONrQlHHT)_JH>`45R7'gsP%iIb0I!7_Wt@"*k*F_K$8XFinlU9/BfD*l/@AjDZ'co
9CA+Y`,Y&hiF9:FCX&,:a"l"AVO,tZ,/bl2[P!=^p`Zj/\eYpEmR"'7<A+A;96CD(*0?"7n+
/_A@*dr#;h!B9i"u^"7hqk$UaKG1g:jR8,F-[cQZ?fU&-tfeG6f3`m_m8+D;32q`/97cSjeh
V_D9\"PX3glQ8#b;nr>fCOImFCAqgN]A0X]A;C5`S4/=Ud4C,&(gScYK^40VEf"c;:fm9h?B#Z
:9GaUPX.t#$iK9A%bH3l\j?aJbk@'H9)eNU51>6e:H%jZql4#omZO=ocu%1=PBr5TWpBAM')
3Et*\"jU[G7KgEQMLLWQj'8/rP',FA!IZ@3s(Y>%X^JpSrX'I9arU*_Y35*XdJXN`'UShT"4
0jBAXZD?%6Uh/6<]Ag`,YqDc>.nS:(+3LE$mUPu\g2-mJf\5eUhW0>3G]ACj?-N(X01mH,Cu9^
3#:-7W/l<r_QA=L<pRJ#c*tp'HVuu+j*]A-=ujf,itM-)DIGS7$\(6"5t14Om&IB[SXH^0X)c
W!"M9[hg)EeOTBEK3ge<dScBcQUZ@*Q@LKKItHIeCQbsRT9UpA&nbpK@*87Uj)a(Eom=:"4u
.qo\G^-N"uD*j*U2gQ6R&?8@DI5#*;-/@+ZAQK=>$n!Nmc"\Ln[WZPW!)5U?>.#dGMsoEe*3
LS-H.m:#8dQm$]Ag&)nc`HHEP5d<7#GrGd`%d:efL]Arp;gJ+DA4EG*`K/:?cnG9emX$o?[OFU
V?`hhA^Y<Va&0'6Y]A3a<b%j?G>;"7u&1&EKe`%c4.^N5oA:P#"1Y4'+]A?T=2UU&P-2C3E$q4
.GNR#bJrYN"jeWp'9YBahQsYT7,a0k;-(-`m819j_4Y8rY3k+KMDB>U4#nbQgl<s4Ytfe8j?
.U9fkMcp3cn\B":U,?[\6,rW5p1(hSG5e3_6\5;[sT?GE3-[=7jFGiTH/5iVYii/1'@q@9mS
Xq$_'N30*Eent`<LN[_JWXEo<dWtFlRb);Y@iL+`QcYS89[rOSk9SYK_i53agJ+3B:;)n3N1
#+_.O_>uCC5oY1JP?s=7[q8-$=F;.>7$bgAP#.9PsE^1U)7S=ScjTn6'Tm]A"BEKgjU@&Z^>%
s5/*r\dJZ8C#J^<(p[N[@hs]AV&80K!1^V"SgDVPN?QT5gW4GW*#$-.KM5-4>nl<-\JddQ3[6
t*er\OdnC$)RR&UVY3d;24)X+ZUbr`O(k&/mV.WP[2i>&_q$W7&uDb>&ua0E!Q&_8Zq&jH5A
]Ah'"t'7%]AHm'fHm1S8X`1%3f38'+4DuHOiu/6l)\(1XM8`SC>Y=<D$\e`OO0#?f9ot13@+f4
+e#Z.,i)C-q,Qd@ao.gNpSbH&.q!F6e<Fat>GKng`iX*B.aTabn31epf2GK(\Cbc/!LqdijO
P<J>d:KXW5X2pP^Z.CO97Eo^+V)[M+_d.IHA1AROqL9%+sQoM0;_#U1-QH>Isj[4pmI$f?R0
)a"LhON/Im>GMBa%CQ"&RGb;_R2]AED@X3HR$I89kpa0NKE.ZGYg!oO/R0'u@6U>>dI*'XF&e
hAhNBPClu5HNA'G[URM933q0Va&HK&+'X)gsfL&M!aqE7Rlr2.@AK_V/j?u]Abgqe18\q\4g$
aM!PBAc%d;`=>Tea^:D>/qY#>kj&BDME)(r/(([lHA^A*59V-6&'!\A"UBIE+`c7tN;R2/3j
=TIXDToi:6bg-Bq<]A8.^^0RRp"HLE&h!K"B$D>unj.?Bf%g33c9G!#1.X)n5l"q[l4$lZ`>j
rJV+I3>P1B35C39=5W8HCen)Ted_C('B)S)`bOnMIJ`ni87M60_oeOS&n)17)oKZP%X*%$+o
MEjrj7dCX>qK1k7_4q?`Q.'u>_kP<X[RO/rp,r2Q@-^s(:%>+WcP?nJTr7,D8E3[4^&NCM-9
,QjmFm4OJ6P^+7lipSGPF?_ki0rF73bY=ROWq,3Wi+kY-,"e0S)Za7Ok:ZY?9a3UNq$ML,40
F)KYmp`!RF*3*J*+STL;fS)ND?5ClJ0=BAp*LlL!-L0QI(K?l!Qlj>hP@N(h6LSDG:mN"#oX
m]A-j$14_]A&;6.`,"u<>&=QHjL1^p;AV:6'Da^B/EFR3fT.OpK'^#!m7M_\Y4-^$_sg)M-kB*
!HNC'P1mq&)N[=Y!Ej-.nPPCHc2__@Uq#&57,MO<sS4oLNqq\JiqJ;mnkOYOf)kAi`=SHKel
F%<CQiO$I:ZX-9:$af%V;8)ui<93=._Z#O']AI8h=r&7BWF/ZWCHQ?3n:.QY)=2eph,.((Kd1
@TBJ1W'#X_1"X+kj>[lA+T=]Ak*N$C__`GYY7-W?JO"4=P)dM&;eN(c4H0KU644sf3r=aibp`
pIQ%ggQ$[k2CP[>P#"!#Ld3<UbO8%G-!1AOt$=349p&.P"3\_E'"U*5eh^JL[bQq0r$]At\,L
2\*LaqfkL2H;Dh08WNU[aFi@7ohLh8$0e/bC<,LrasgWTF'<SXGoC@bGSZUe:r[%Q!:35@Aj
k!Zk42W^!biQ44l2i/FN$bGJX_C5I-SLW1rj'cfNjH\E7(>gDMc4JaBf+GUBf0Y9_,Z)Q.PX
<R/?JRTB3<;o\O@d2!R:(`*?&[EB&8PE(Ctrl>I5VJ>++J-HP]AS+Csb:]A%ogqjI8Oc>jpE%#
UQ^q,%>M6>2!45H0#?f+#(CoeqtbL7MZK8*M_?DdYW%n^"85&F^Q"_rUJ.#&-OgjcLrLFR0Y
u)?#QrP)`gFZ."ZYk>EM1>nNhohi-]A8>);!Oh%[1^\US[[iUH1M1]A\l)2oSJ<m,>X'eK=.J.
%+QqseD,DP5tlns<>XPGE[rl$f*!FH9c=1LBa^mdY^mu2WCZ!YNRMiJ:8_rjC-gii_qP/-c$
qV_quhVD#JlJA$a8JJb:kW&Qf]Ajj[,1%]Ada3f!r9a87q/#>WDku,%'eM3\_))bg/X3<K4rT*
;_r@+)DAk<'gs.GhQ(L6>71*Mgo[]A_(DgQX4W*=e`q4.sdh9oTtBgnV4YVE0!.#9`VdVZ0.K
J6Te-KOIPj+-"hOl1F@NN;6=Ns']A1:@#$&J%?-jGaFLBEGbf_:OZCKMQ'H6g&8nNRpuMRTg3
&-?Uqfa81O$?C-Mqns'<ZlI'#QW"r1W/k@GQ=PH)k=ik%In,4jt*d)'<YF2^3;M.Ud#5fH28
]AlYu3JsF^X)?VEDlO\ZfLY(Udj!IcZdeIM&efmJ1'dsn^#mI*6^9?KNX"3FBTl$3'SS1c,&f
1c/.qU6W(R``m+VHS]AMMuD?4bhNP)Yd/CcQoO+=M9MCm4=$hlY3)JQLdQ8j-@j7"!<p@)-D.
e6N"/+Y8he>pI[*-ploc@?HBM/.@[4_rSB&Pk,gT"QnZZ3o'H2BH=ekq)agQi3e<MAN,#=FO
g;o&/bQ5H:KLLjH'?1DCr"oQY*qYQ\mQg?oi[7DU.XUL3h;YLK6giKA4RjTc%N=HVl@+MY!o
Bug1e,q=/j_JmIot:B['&9Z*7qGl0FQH93d<.dDQ<YHp$>paO8?pX%Y^6H<:bid$3SE'H2!_
>&O^RMDIIi/VZrj9<I8FYj(OP3PV4PmkOhalMN"EH4N#P7\%RD=q\[nC1,k4RPrN<a^\g9V4
,M9,B;otpcb_C:d-I1+^q(3f>pV2*S@g28hbrIj,4=7,IN%m`Uj:Aj^GQB/G4*:+\dq_S$`e
Y"6rN7E4c>+r0(Q7X_D%0;Z9Dk9`[*LHY>1Ja!WWX_62tHQTa0VH<aPZ<!Dt[?kirJ5,T$Og
n4#[XnWb60?`^)lq"#*>teaE85k3iA.CO)$nOrek&.%;V@&5hMPZ(_7AH;l1C-qM7UcUAFcV
;hTmAG%GOR\_+6mu>YUG:GOY@%J-BD?4dFJlk[F$\a)p@U!J(P?"dY6$jJl6fWX/8"LGjiX_
c"kgNb^);h;s#CiFn;TQjXdIJAIFp)M;!Ilc_5q)9e6P\oO3AoR*\eN&n=?XM6DJCc]AHfS!4
!XXZ?3fu!IlGXUkD-cKTFBq4G8/Dd*@I%;6JY,\5puW(-@-3=t+*9,Er%iZUjEaa]AlQIo6lr
XW]AW1m7^,6L:K`?h,C#X2'qR1?<*BTOgST,ekQ'WN0YX/5.mY\;lE]A0_e=0NFHrG6d=itq6)
9)YG1<X^L&#d_tWS_G8j0l*Gi35+GVmV/C4"k$.\L%K8j?3)\=Gt8foN'O89At[*WR6,JCO#
WCJLd*$cS]ARjnqEBI+o#Hk9fX`JX\.&]ANo/NVo#8C&Y0TNCZTYu-,9d>Rgk4^u9Lct8_#dIl
^Q5BA5#@_u%YRdb?H,K05ikP*)A(^CYU@>KpIlQ[E&)s2-PeFmf=hPHC]A_*T[CH=p8;8biPX
=T"%TnpbN3*(ufJ_XTE).Xj/#JNW8A$o4[DY"T(b$"@r@:>]Akm@O66QBa=D`4P`V1c>NboD%
QVIE4tJZ0eWFb3`V-?`:fCZ'P/e:f_:]A('aDUmJ-#>4@4mp&_oh\.LjYa@(GL"$A3oQ%jfj3
WX/@pG`1",:tt$eV_6%38X[@/P[\@iNn\%e2eM)L/f9jJjG%24_8>8rLcJe1D?8j)'5]A``Mg
a8&mr%+m\+5p9?#=,,FJNAqT66.ZeYF0>D&LIU4lN#h8GnO+S=fIUMq/'i33j0+cX6]AZcEF=
J/Et3&@3o'P^3)1a/-tsa6)WQVLSO)cohE0-[K%F\G`,p<g=nD=P3?j*$@\3_.[o(#Q&o3C"
-Mif$jS'2MTB8Cd8c(UUN[W/d<)GZ:#ap(>,bIG<KU`\>oXranb]A8YS`Xq$qKV4)BDL?.;.,
6&%du51BV/?5j&%t109KcgOM-.nN'O1pfAb*pQ]A`h1n"eg_.pCR<BpZ'DYo\k/WK`TU/rckS
\\'/^L%bK3!kh&kRM<q"0B\CrfS_UH?AN_%O1+dA*lL1IJHWM&:#jtT/?$#gct`$rr<~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="318" y="410" width="100" height="35"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<Listener event="afterinit">
<JavaScript class="com.fr.js.JavaScriptImpl">
<Parameters/>
<Content>
<![CDATA[setTimeout(function() {
var a = '延误-明细表'; //获取对应报表块名称
var b = a.toUpperCase(); //防止大小写出现误差，此处自动将名称转成大写
var wid = ($("div[widgetname='" + b + "']A").width() - 17) + 'px'; //获取报表块宽度
$("div[widgetname='" + b + "']A").css('width', wid); //重置报表块宽度
var height = ($("div[widgetname='" + b + "']A").height() - 16) + 'px'; //获取报表块高度
$("div[widgetname='" + b + "']A").css('height', height); //重置报表块高度
}, 100);]]></Content>
</JavaScript>
</Listener>
<WidgetName name="延误-明细表"/>
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
<WidgetName name="延误-明细表"/>
<WidgetID widgetID="8a3f7215-9414-4004-8955-6ff7021a65ab"/>
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
<![CDATA[1143000,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2468880,2621280,2743200,2895600,2926080,3230880,4572000,14234160,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[航班号]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[飞机号]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[机型]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[实际起飞]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[实际到达]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[延误时间(>480min)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="0">
<O>
<![CDATA[延误原因]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="08延误-明细表" columnName="航班号"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper">
<Attr divideMode="1"/>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="1" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="08延误-明细表" columnName="飞机号"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="08延误-明细表" columnName="长机型"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="08延误-明细表" columnName="实际起飞机场"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="08延误-明细表" columnName="实际降落机场"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="08延误-明细表" columnName="到达延误"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="08延误-明细表" columnName="不正常原因大类原因"/>
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
<WorkSheetAttr/>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="64" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border>
<Top style="1" color="-15378278"/>
<Bottom style="1" color="-15378278"/>
<Left color="-15378278"/>
<Right color="-15378278"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<![CDATA[m9FpA;eO[A3gD<_3jh_`,&sJXYuS''U+AmjZpd7e/LjpS=,Sq>e0p,(=fs>.FKn;F1pmUO.\
qq7&M^TQC8kZ7+UDP1!"iANQGi.U^%VoeRG)BDFZt;GDtG"Eji8IUG<+j!c["C1SG*Jb7n88
[4ZW%(!eK:;GgRK!&."?m&I;m45!IQrQZ\^["pkE%hVpJ#>F'S[W4crleE^i6c>nu(Z"F2Tf
2Vd;E`tBa]Ac(h4P;E.21+n#?kJ\Y^b,/FR3]AaKgh%(=-+-5-heC/MK_of4GAoe?n_l@0&)[R
R8b<!)I*("k:.Sk*NZFId,'+,"GU8<@MI]Aa>NSD_#Ze:lRlFV((-H7cl=3QOB?-\5DgfHj*%
=;I`TC^*D)H4h^aCu9am=n11Z2qtqWk<%uI%e]A5X,+7pokP>]Ai3$tm9?e;JqIA+>#3q:',r`
oH]AarT)r[fo<qqfshX5i_RPBS.$d@<JkF8=LU(FagbnhV$'(gbbl`.7(KbbQl8@"oQ`lLCnl
;3i@gt'tu,u$8+gA>M$TM10+4>*MWD+]Ah$h>Q2QZr+";@7ePYhQgX7D0O[LTUGH1Q=L<6UF,
5^Kt@2CCObYB,:Wf61_]A!6*\:?#<Tg`<fONN@>Hr>II?*/q4GG?AD^,WpU9,q[J]Ao7*JIB[S
d[#@\Tm8<+a&%.Y^/G:[[Gqkas0%eT15dPaHB<h`LsldBHM[dYSY8,8Hukb?+h5lN,=$ek2^
TRpYsPbC@WC%0c.+/9cj,mj-nC\.+Va7%fR5jk=>Cl_)S*W)6Sd>9=klLSJI.EH[@qgRK%-b
(+!f*%QV,0ERL\p#mSM*1aHYau`11N1PJ/rWZslUB^X[$5$eA!C]A)=WqoiR?`2pc.Pii%;p6
g(6:R*GPVtE9.D,SS>D-B3&^sK>'^j;\sOs'ak)qd"ebV5FjmG/)k;!pZO`9V'6VT9`E"MT0
@HEt0SARVpV6$3)a,Cf2HC^O(i<q"6IoQu/iTWU(h2"jhL98'50NJ@<+hi>WZ;CRIIo>/?ge
[s_;FahY.[e;2*G2ZV+4.[H/5#;;,%`JF&IZlGh'roP38c;o$113VHIroOHlc'3P--Q%pP",
2\^o>*!:V!L(SL5[+`+;,j!jJ/hN-S"p%rNNR^oBZS>`UPo[&F)%(rkL"/\+C!;a6r<HB6i@
o"`E69Nq%Q[TJWn)$-U7lRl1OP0L^="2eZ1<qp=3ISK+3d*EQ$2YL<Poo"oH8\V!&JB9\3D>
C'4PA-$OOs3"b#)Ma=NC0$Vit%MaSrBP#mXX/$nF1I88,%QAf<A,^%A=J=KO,RQ8Xo>"'VI#
st]AC'Z=ek(E-pmUsW.\Y;I("Ob"X:j]AL^,\m/t^TS!=I"@Wcs$?qrHJ-mK"V,\BL3S1_jL*r
A8<#3S<(,@>UHf`1si3`KInBiFL3uINpS$e]A9hDS@>Bu"TICY`G&Ojb^h'F$Z`c(\MQ5ZL&r
c\_X#P0qrocg(enIVq-E\emiSS._\0OEmeH.Q__>A_;o7=JDC`fr*Zm^MrS;mfpDq9.\lhQQ
4rERoPsn?-$4J-&OGEMQNk7#f0e>WA6KAXrYri+iGcIH\@")q\c>=,R80l<\W$@<#3HJ#Y^<
HE(BAhBVmLf+cE.38BK%LP^1I+MINNiGgs-,S]AOe<VqVSZg.WQ4^0cl2:B"3]A?_QSO*;&RTj
K'>^AYV("<KHG/fX2/oQ'k(+M<-*ep+?NcoZlHq[\.CY:SQXf0*PnZh5II78e4!:e^b-9?gC
d@^:^sQF`Yc\*SO!?rq]A=FR"Km\oYG@<+#/Z_3kG%HFk7!l+fmG7Vt1qd<c8L$,jNtS-nA+o
V#+0B5I:M94qY?LkmfRQZtTR/6W[JhF+AX@)u*lD)*MH0U?nUH!*ZN[UOCVXQB'$bd%rul)L
H%DZ+6dBg%.Wl\G.AOa;sdBP@TpBLr-M<F89[sJfY:Wl+1h[)TTVm&FXr>E)mVZIZ)eI0I1d
$C1liQDBS"\>_jeYH6MOCn/+iU,5P/m:Jt$&,dj:Ls3Yg:s/^D"0L,!jDp&Z,bR#Z.D0r8N3
,Mh9/)XC=kS#Nq`nD`B5oj%/MVrCXp:n=f@W#ZD#K]A_$Va\YR$>GZsJb1;H[N#'Y$le7/=VI
D"Oe)uggO_d@&uBZL.fP[?Js0YWq@#>"inDf57CS1C-j$(83iLt*M0K$ML-9C-U5#=5CTX=1
5t>ie$_n0*D-_ah*SRBsJEM/d\csT.JK/p@XI5q0ZO4:%"4&sMI$gt[d8\gWb-4i,gb9b1bO
VbgZIe>QH5,b%,gth\d=dNACYD$[pP+j<-<6#8%Ol"+97]A91BUpE(7l:Q#8:Q*r1LOM0r$u?
U8M)[H#)<)W/_6SlR^a)5HdH-;1ZJSC2UtY'e6-p;8P3*#H<qDNp!+-0A,*AL`gJ,1/9maJ9
tE(i-6VX^<@+Um?N(F50*h+U+%A5tLg3mI.?F)m9;+m'5tIgeO`LcH'XU$7moin.BXSRR.0O
EX,Yqe>8@EMM!:748W`gCA5a(hFVO)UUHn'p:UMQX-FsmUUKmO@5lJ1N?2fKO9V*Y@6>0,,L
r:#W2-h=k3NKM21%!/f7;KOQd"R^KEL0g[u"s(FLdCI-U7M1?k:)Rf'Pfm"gn1-^_[<!t8P-
lJDr<BXtDG3=5Z=^oVE&0!D'StH"RUT,/WE70?r.#cUQQN$*W>2F,H/7bSZdpBYpgdLic0]A&
a;q`b.;o+r;N^LH1C=-GOQf?6,*Y`T>['N"2PF065?B*&uJI9[gZP]AKo\-3`kcjJ^8l32_'k
r3A/j:Si'S!QtS6g*C18?`2&+sTZ&,X9SFFAHUpqPV#FgLeVEAEQ^[nDPO-qW@KPrD7>a@VQ
hAmDl>.[l9SG:DZ*LcV$mZbQc>>0mPEbnRB1+*=:#;"FrD?k-Q^b,rEQF):Ik?`?:U&?>)3]A
12d>cQeWu]AVE&j6.77kP>ud=7-'Kg*+Tm9]A@GXu#[[6G"<daF<5(.G=Ut:$WQ1dI-aV^EW22
(O'@Aap=QDl3Bo(ikjLsT%+ke4haR@GTdPE<o8D5t`VI3pQ5.TR"4[0HI.V/:0%K(MGAh,#!
VCm0QnZA\_aoFY^W^XD(b71CkT\eSmEg\.d?<QTBiO#lmIf6&G,2D9$<6>]A?X2`nAaHfI(Yb
I:/b=m-I.cI;S#169#6E:^UPhKdC@UtRA+5hn.R6ajFlEIeBB3I=q]AJLhk]Aa)`j_7ie-QNtj
i5ZTkE8qE['eY?[WL^6%utB)T<l9>kV8L8-ff""<!$?c!55N$CKbJ)!cI!R!j$EuHh;mmF(D
FGr1OQ[5U3*U\'[QNICj:f+1X!tges+`<'%T/(6S01/=*4m_dJf*%&_QN"=7o87O..ND6Q=G
l60"/$Ig+Cm!E</94^%Yp;+FLU,.UWVNW0Ri4Js7:,c6OVg/S'g?@TuTaX]Aj]Af_98f.BW,,D
ZZ]AOA(32?OrB(O`c=hh/*<6nN@'oK13K=4)U@l-_O4Z(OX3DHu*U@_PA6f'(XOWLb_.0'Wbd
Al;DKYV8f)W2mW9et7F1gQGeWUQW\N=(Zl+gNua_fsq9)P2(Sm=+<e`eN+G$,]AfDpQ]A&kaXs
1m6-\K5;]A"n!Gt8i7f\Qo\R)Ah%`1sEfqXH]AIT*U2:1ZA5</<ZO\k3R\6-#@*CbF.29Ie2\Z
k4;T]AgRhR1FiR-Tc"/Asc"O.9j3p0XNsCdT]AbLP1W6+d>Bi^A]AgTJhDU2[6?h;0!9*nQ![J?
P3-J@n*u]AW:$SM:Tmnc7pfX]A]Aa+8^(Ui$Bq8QZ4VJZbTHQd^3Y[P9,KM:V$BX-SrL-.Xi_S.
4Lt"IN9!NBT+1UnaKe-@h!$\9m]A]AO5[?]A9GgE.qE[qe!CD/[)d=YmfVKeC>2h428Trbr1f'U
rni)Un:/nRJgus6"E4^\f/il[tA(nn4cQf'l7;R83,;>luUAZNXL1ph*]AfOdUF;7\8@^s54;
XPS(pTGcit9`md44YFMQ(\#5S4Z^Wot3>T$Sd?B2&%SXkO\2<8;gi8-7oBA5q.>Y5*?R0k[S
J?m6r$\4F^Qr&c%j[U&[!',5NqK(#+13&I7P6\A,[2P=H5+F.jT3E+9Ed<<GHRd<qQQ,7D;Y
DI;(/)CTJpWqe9B;/3,"JrX,XX;t<1<roWa03['7NF`:R[KGA;k\5&o"em6@`":%rDT!jh0D
WNO*ptg4QuL_8:NKOffMA0ns6WJis[W\mA%_=IEp'mj(2Z+)DQ^XgM#Rr4(m#-Nu)IXs;'8*
GoaFF<=%S2sVq5EH`Pc(80!a^"LO2I%7*-26Ch\OMW*LXjA:=^-[Xg'qEL>*._pqD5+Og&:m
A!O74W3V8^2(#@KPCoAg-D?-YTP>"uB_7]Ag_BjCtkf)a58i>aAD<5M?kGb^O52/#h'#lHq=7
G[Ke0-VNSK8;WQH;C]AG(:JAO`eoi`W&(aNTqB9E4p#J*DjYYcGOC167NG8UU-R_l@b_JST)%
b9HRUQ=Y!R5L3$\7Nm@sqnI="687I7a'DRQ3Thjb?t83cU1*F[qSk[4>3^A9P)CV%p""GF"#
cF'>t"]A)o@p=T([bCCgK\JtCl^)gW2U!_bC!V>ca0j@//so?`bU\BF5"<K(FEloCWniYIk1L
5-!IqRdjHgrci&L2uq]AI`S?=AphjGp%DZ!\pg=KLl(YE*4b="=Z#24VC"s1fV>pIl!Y&]ADTu
!8k^0FdVk?g8*:+1a+b?L#YIDU:AQrO/a+3o>HT5Bba30+aG?uI9f>P_-CI4OXZHap!.G\mK
"ZM)Qqtl#Q/^-M"-c;[D[O_'hJpus0j.<8\Ct87emV3JZJXPS"ZtiF'91*O6f]AQ5?H>^0RR+
W@^oFJ&sHKCrHbZStnGj*T@WKdjSPTU<pU!c*rLsZ>siij8`VYf,O-O6T)6r<DOe47-as+IX
,5XQ0ZSPo`=G4f_#_/,S'F<Y:E@G7bDL=eoMG2Z"?J5KSlkX,e6Fn3lr_mW!Feg9J_.,Y[[7
RLgp?lg:@hbA(uU+bd'gsgp-[p"$$$Mkbd7uAY%$?XbQnF'0ZVa@=^LYb8tVh(P@Md6B.2%<
$CDW:m<'($,TWVpD$2^D+BZ3IB!3FFW\gS=F#p?LD"DoGTKTe6CRls:*Nd@Am;Q<D$5XZ3)Z
g4gtpPKb4t]A[_Xe(n4JqQX)kSJC1[a!@fi[oOG9d0@X^_W-gS;P.Y;H!1$tSR-9\.SF?isCW
>IN5ob_<gXh;-je"[b`k%q?.GD"CMTq:"L^I-#"SAX6?@M6qYEGgBglPW8cYfZp5b-M7[nZG
Ll./6T]A7MGR=86F8.<e?s00bL8?HG2l2cq?'I[J,O:+Q5Ro*U12?N.iF)Rc0V00]A!Th&cnuI
do)KX<)(r]AbKeRrk<jnElgVh(U<5[RD[!`3E-@#W&c_4-jNhu7iaY?^9$Z@b0'g&=lA?5!'P
onjL]A<Q_X(g!f9NCIGL8N0DS/D%T!0g-B=h&RKq2h);VJJQ\piM#E9@XsI[[]A]Ad4]AXE`3"_n
h'=72O>AV8e+pHeAEhb7NP^(me+3<uG8Y\O^"bpj<ATOYPgH;^b,_@DnYh/DoR9C:qqK`kL6
<]A-0XNMeJHUp'4=^p`E_Du8f=5&a:t0]A9Iu/uNAp&m2jHG).Y#WN0@cuC-?iSUiA0]A=D).#^
o#,;VsB\U&hA(8WWEngL4Rf1=bXB3]Ai)o8f)2]Abm^8[s6K:1Z%Pb,!A$)@"(RD4B_3CST3p4
'-^0E?9b8K[%o/R"Q9tDdP%7]AkcJ\E/XD[,C8^?GeWD'Vg(D7\Y58Mpp0:@VOo)Zpgq=bXud
3%f2'1'Af7!Kl1UYKeKkmP/W7Gnbk41jki8JZ#RM_P@n_jF#i7Y0ruO=G"]A[kV%nPb6q0?#L
'bT#G26qT^-1+5AI!&Q49jXV)Qo,LQU$9+nn,i;L,k/g\QPRLP:1#')CJ/g!m5$PDn($2WR9
@IG"M0!l=]ARQDCPC[%HuIMgM'I(CR)R6@kikrVne?>0l6Vb^F*UcWndkV$Vnm:dpMKaE#5.!
_-asU^gK%3?ihR1LmK1j%bV%$'%_:WM>nHkQ^%;%NouNnD'YAaA'7[Jh5<L\a[Y]A?lrj-0#K
;r^nV.&?O^X_5Ed0)>!bP_U.^I12?7-:;;GRlX.T^-6^N#sj":c#V_a[BGugkn]A.&tDUkGM5
s:l!$o=Eg>Pr%"[lLG%GVK58_S+7VX5j[HO*(0RObEdC*UQKI)bEoK-aZ5-iIL%C>Nmn$ncV
n4Mn[V5f%FR4G6DhdH-Gf]A2R<[<kMp5;n1Of,I>gl@0`gZ0uWf=e5JeBhY?.k!e1Op@\D(A&
=B1d`o"Ne!WX546j$K1[86L!lh#A9-_G1X(f)C)`ZH?m)5FO#)$-0D53SeZ!KJUZ#qVK(sBR
%]A9U;"LcH^(FRqh*d[o?l6r4WAq3QPk<$IW2&'R/p`1YP->Mg.Ddn5(sp<FTHoB0Yr@>SgM_
sEe<WS`CeFkKp1m(+e4,0-XB0j)F"/U^q\Ahd<*\W:s@bb&\^g-(ce,f5A#rPT@TaHX\XCig
+"mbk^%n8asSQkKVqB5A$:3?u<JJ8fg<+^WaV?XSXXbTDe3Ca+]AK[_,-ek3S%6+gcBhr;RBb
rs$egZ9e>\Ip'tW\5N_031S)G7iP2\&o[[(7nsr.j.pKrg/aW-/CmO6M8Xjn@#I83E![OH-M
E#iDlrr0Y$rsd(2gJN*PBUD:hTtB'+?Y>ATI*Q@`,B_F[gs.2!2V%aSSB;]AjS?!Dm.s-O0d#
e$,,J@Qf3)C1G`S:WaSq`A*=7=NrW1$q'La6'.]AHT7)(3P82s?KhuOZBV@85oMf/Bb4KKrE8
;6F.LOrcNnCGF]Ag%paWDBU%2UMTu0\\9r'i8H"a4BcQub3Cl%hd>t19[J3@.K%%lgafi67pJ
SIVb6BDR?rrG]A\8"IqYsSu9%cG+*dn1ELDR8ji8!GS/m#f20@%NeQ$S\If\,>X2T-&,9Y%sW
FLtRo?U<7;a4Bb&(O%\/iqWGeXGU`3c7Y7Ca&;W6K>5E;7F.Z_HbIHeZ[;?Sb-!Od^PSlL@[
B9.Ve+G$T4D(pQ)t8)cbY6_SSibAZO9i+]A*`5Oq>?q6X9F#dJ4b^b#:&&BR>FH/S>KHrA)G1
Sejm.#5L\?gIbX!EFJb4s4;E]A3a5i?DU%;25:$O:BX/,GV]AM'CE@&tBlKi7X,VpgB8\9R@W2
_<__p7m6+@4]AK;744BP6mRO.H7GMZ'^!WllG9UEjGGq"YONl)fRjee<jRTJnt&1#D6MkX#$?
*!4SG^Dq_7_W^NAeq?F/o*>hiXL'sAT-M7F=m;%j7Vr:-r4(/EcJha56HLXcDt>T.^BNJ+S3
Po4,YfNN@s:Q?9Z&TKp<W@jE9;*Jb_MrTNaCg<<k\JErPLB?6qn"2$l2Z?;K+"U]Ag48luKZ0
msQ[elE!<$JBh;9l9Z*5cRQmQ?WCq0$MfS;8grkn+p?"eJWS(l,TBS63[pqdU"\Dr*3XGsD"
'##.OXs-Y=&a2VZKgm;VAi0B'."!?>Z@\L#bHM?$&SE:smiFZ9+49KsT[a#\_#EuqTe*b&gR
Ki_uS,,$..DTH&4#DoPPg/8hO955FH.Z6c7YHsL/D+*gfA.='B.I79%E"^s68I;@bo)XMYb$
Y.D$&\3Gs#8Z-tqq]AQ]AO/H_013VW(Y-9MPo#n;Qo"nAuP_@:U17]Ae^EeI8mL5VF:E/nXeOc3
2pcZZ_@("^7\JQ!]ASG.l6HY)(517I^XZj2(os$[bg]AHE-KJ**f1m[I'm+aGp&8nC>cEHSOg#
m1aIu1uZ3N0jNKJ=IeZ(K3D+*KkSR"6RjXm-QG':\i$b4&-PCC`e)ikJSgLs^hnY""q7hai+
+E^S_RIr&`@cCLPMO(o+W=q';E\A5dprru%U$ra=\'JD\p%$>EjF+27Vq=(>S@i5CIgc3-E8
rE`5FB=o\RT?MJr8W"V7T@9b.?/56`B'X/8iuQ6s#pMR4TQN]A0d=p<N#&Ud/EhmE>Q[t#"_/
lTi\KOX"d$#+j6e\.*L>]AC_dB3&KmVl/HcE-UO1H#9Ts>5)^2jdtN_A)eLF(XD>K*dgQ]AW\F
pW6cm3LApQ#feq>*8p3#i:U/)^Hns.OP4"K&o`;W5*Lmr_('Y0E$n(ZDo,1Ds0VBEi)8@d8E
iCZeeNF$roi"[Irt"aA`Wk-`76!4o5M,,_H!9n_-5?;r3[U$SM"UN'TS]A<]A7Frgp8rj2a$f'
A<MB"dF880n0m=9og+.Ng)Echa+0b;dc!h^mo('!B=51LQWV\eFpZUheIl&D6_r%W\9j;,oW
kjBTU0D1kSYiN_h/=;M>:&PuIds@e@E"Np-dL&SYOmQHh.F0PWFfa1S3nBN?a]AGlhc"T$Hp!
D)@((5QH72l5O1T_=CM:'W#u8@]A?T6b`ecn=nXGiKPEpl'pg3W4-=JgG5rl,X>)cqjMGcda`
,!f3MXr^<8al5+n"&rH?6=-O-]AQl@G?Yqo\&j?2.0s>PLq9e-l3*eQ@n2HJI!#<#5n:fr;%<
)6LH>fa^UT36mhUL*%T<cWZ`c<_\"^^`p`4+EHkN6\a4uHNU0>Pd/_<\:R)u_S`0gagDr]AN@
->b9!UYO_t3F-pT_NTaL;)ul$DFU_CXEMf_s*ciu!+2@]A<428Lqk]A7dNoDWua"%[kdDN2e&U
k5%s?/eqd4kHM%[2ifdOIud+SnWP>n9&_]Ab1R?QEPdH8e/q+2raf&fCRG#rXP52d&3gNnL^E
rjd!<LZS?aE2hj1`(ZRB@>p8Tq^STK,3'ADu0T5N_F[,sV-22K3%^oVp.'_"u^KQ:os=h&Mg
bh*[gomA<!G.^)P0nnXYM*M8BRWFF0Zrc1Gp:MZRAW9'"oC/Jk@`$jBZeDTt>s1]Ai@o\$H&+
Qu8"\")$e@gG)LnV9eKEko+A^_S5\o*j_f3ML,hDej\o0A]A;a8>1o\LtQIA/GI]Aq\TeO&C[+
p35/#lK%A!0EVDDUY%pgU`DWLNNl?YDfYe5Ij]A&XkVSWIA>e'67go(Umf9@@o[jtrAaeeN^&
sOW\1WMguB/qD"hjtL8Pp!:m6(I&qZ;;Oukn'[ga)B/A8.ZK0jMSo:dd?Q80-1#cd]A`:MT\n
^X5`*ATn,S;cpoN>0(XPK2OrX6rIoNo3e>6^$rM^r#X$3UBV'!oPqV/uhdCU`)lj0dK9#P(u
fP]ABDlH%#>@hlWDkk\O(.csir\\'aM>AM,f<o[29/]A(.$']AE7E)o2oe7kb>XMsu/1LI`*hil
F,R+Z8%De+"HF;]A^2,mr&J@nQDR"TXmN"Tb8jc+fT1kZ]At+.=M:Z9$4#'p-@^Ah7Q3n+Zos6
LfGH$V!'lYNmQK3+G)tfW^qO+Td6MqWMa1,ulI7QXY&Pht9'uhu\+#VQ>OAOo++0LH8:g\.J
]AM!`$[='4\`kp:%?B*m5>/Q_El2^n@WJ\qUFIAYWrMumegCbCL)MFTl@&Ve=@4o)C,&02N_-
tOjfZ<m4TlUCYj#.ZfjS\uKLYTO_SIrIYkfFSi?U14"=mDiZf.$KrbmRl$mg[$;()hlC(-7I
-%1PA(Oli`ibD$GFpiQRkk`2AP/<FlZC+itEl%7R!Nng:F?F3s<AV;Ve(Ft:LeFImE)aN4\F
C@uZ258*=3(J^q>Ca'j9W%E(GbucTJYLm-=<Tm`rbH;]AOf^5AMEpI=#&R.,"G2O=13'n:5kD
dd:"spE-`X%C(PP+!'I=A#eS!2qabQ$FDZ&"UuFm%hSWIUor2u8ie$o`%CnMtj&(0?nb"9Q=
W%.5(luR6dMWP.L5`NXg`KCdVQ?n1LCSO)!2MEH0NlEgSLT;bC3p*Fs,TuOlQ%6f_C<SU_t*
H'L-dUsJD7-,Ob?/*2I]A;`aRRCgMR3_kB8iiie*S_0mRn*g\;X1OMW/aiC>:[R#TckI!P93\
blFXmQ3qW<%TQ*;O:7Wl[,kuqW!?_OY4#8H<AM1+e5pkYLYaU6d0!h6+7F,b\?)Q#T9<u6K]A
DeO``(;MEt&Nbn_bueoGY7nkoOls3J-(+/2[tb)hXt?_QekE4-Fbq9&DT#)XCTIe'n7E&R$`
.6UP]A+kefpX["koW#,4t>ZF7O;QIDU`M^XX0Hf(anQ+k0kfk_FhY?qW;MP/6+5LfLNs4`B53
0\29*l)R0$.4Jg3l&\i1GLH4([<bM3BZFK!V(*9!?F$mqnbr(OmkRKgcp_SN-_8_osGnA%f
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
<WidgetName name="report2"/>
<WidgetID widgetID="8a3f7215-9414-4004-8955-6ff7021a65ab"/>
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
<![CDATA[2468880,2621280,2743200,2895600,2926080,2743200,4572000,2743200,14234160,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[航班号]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[飞机号]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[机型]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[实际起飞]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[实际到达]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[延误时间]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="0">
<O>
<![CDATA[延误原因]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="0">
<O>
<![CDATA[责任部门]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="航班号"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper">
<Attr divideMode="1"/>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="1" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="飞机号"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="长机型"/>
<Complex/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="实际起飞机场"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="实际降落机场"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="到达延误"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="不正常原因大类原因"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="7" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="不正常原因责任部门"/>
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
<FRFont name="微软雅黑" style="1" size="64" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border>
<Top style="1" color="-15378278"/>
<Bottom style="1" color="-15378278"/>
<Left color="-15378278"/>
<Right color="-15378278"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<![CDATA[m<j7c;chOnXEBo]Ag<A;H]Ab]A&*RT_7u8h15lZ)&J*TGbS3H@]Ab;U88\W8:ZdAXfY:_-#K;C6q
A>WN)`/4N"D.3;PhG\>V$IRLmgR7+UP]ACb;n`K3:0[,F3_G9bk/gIdm*d+A"U*QhKqEO=jL8
uj(H,6'g:[#R8;g]A\1&qo^DVgE9d8S9'3G20=3+/qm@Rt*iBCMVim$*,A0)[faUW+Z?g2[!r
SFT"PCK`YIp_[$kM'l\Sf*g_on5mu)4Q*Ja-@SSI_##.?P'u4$!Of`VuM+_T0>KueD\6]AB>4
7\"R^AuW))LXgtjjZc(Jd4-7rb55P9dY<LKAKoSnk3GUp4?HM-E<lbFAlg)j!=L+?XZ4N!Ie
mq%m%Bt2An]A/X(!j%%<I#RAZgggge+[qYn*jmKoC2D2Pp!<:[D\Fqcb?0WJL#]A@.QcTEN'mV
2R3U7nsB8_@mHmkuJ//0loaiVm.k_B.N*))[fFGAr&VWds(YpeR_OH(+'(7UN"s%!+^uE?p8
dnUnWR)t0D]AGhTe.os;lJC)7n740-7=7r=ViHFu?n3n[%A*"Ws5,ZbaYH8FMl$2bW8?Gtg+M
g9XFPhj<Sn.^+i1qZ+eRT/4R>lSM$p7XIH9*U$+C0*jWHm2LZkV_8^]AsfOiGQ?!"ej\mfZX5
<KbfVj-NH0fi\+iKUOI\jXnFhn[Pp!,H5t<R>!]AiB+4VIof<Yoh?E$$Q)M![?oVl:,(Ht8H<
PI"TIn8`9<TmP<t`*&T!H:KlQ;'G7lV^'rYb!%rTb6":$d(N.8\$Fr8"a/^[m3A(>>`RR,:K
cA_X%lTdKA_@B2\[bdbF$_I3P44qN8,W2%a%pVgL%`pe3@HF/f]AEd/F:Tma;eLr,&Z-7),oE
De4+)Be=Q0a\3;dV47*65)5i9gRacK-"$*:7>3K*8i@)s?\Oc:DPrQ^>#Dt3!?j6(n3f&#AH
e%h/U#AC27g/bmE]A*csZbC^f8C.\068l]ABk%RVf-Wm3p4,6a^#+XBrR)c/:ZX'.,"-'"pml/
Zl6o.`@X+a`td_o__QM6-QX+<#t#VG4n8VBlnF.*kHju[#k2@6O^<o(;hP#kRk==Q.7CuN^9
)'U@>#]A)+T,h*_aLNWe+:75Z6^&5G%00\N)NI,:'O\@rO7&\X;c5&\f2?YZ[.FJY(A\06I07
.!Ufh?F$jE[*CWUnIrZXWSA8X3,qf"A3I2ICR*WIVoa33qmBo#DdACO;"11\o^Ak;`qb=&[X
80*W)R&"s+$7Uig?92WKopq*KC\_NKgi+<os;9dhl5,Zs5'sZ[g\<8ObIT?C=$YBm'B;Kf=V
2(c0(=hIgS*&'ndA0hL\+KK:@3>I+_X#Z09>*MOC]AHdtVUrmZU5o:\&J0it\B1p6d33bb$kl
WmTif0-i:lH!hCTuQaMV8gQ^`cB@QUP)4tn?%-\r^gD+R':+ggT->g;0E-hqREiTD;Jmg96m
rYCk"2pp_I:KmC\AjbHV,SG%uMgrG`a6'HTo<)0PBX[fWiEB00*o)KrlZ[+SVL;I?a.L.qXg
F")`pL@Cm8!q'gKH6hgnWg$I<fS=DI-EM@JPRfU7ZL""efpZr5+c/GFYIVn^sER5A(0]AV',W
qHcJnU_u_Sc_Q!OrKca'IJHj#"X&TSDHJ)R]Am'@V[50-S3J@RE8jE`Zt&8J@uNIkK8*q$q`]A
Bf_=ZLS#'Cm0-b.5G8fi?Mp<eEhWnI9%A2<O^K&K(Tie8;pVMJ=nAO5*:piMfd,tClgHd$9g
oDbK7Qc4A>PEl<US-e!6St??(g<ngMs4Z>?@OfTcSH*`hc=4U&38R,de&#n@;eR6<C$q,T+(
l!ugq2oR>'%*G9EAk"[PX^p(S;R*YS6mf0eLb+5]AS6637:_2&-1U,L:7AOa`O_"Y#MZpe9P=
,h$!p8.3$"Yaa/=i1H+b3pP4oM%sTeX"+MpiO9)PGtsele8%YEW>dK*U,V;]AF-f62oqD@cnJ
1o@sds(oGbB/k=cSJ?kIbqQAPWbh;uSS]A//9NdHJV9:?j)PJdAog=E+GN5CNtT0*<_kuM($)
nJ'Xqf<':E^3ah?:&L"C$\HU9&sS$G#MQtldSW,lZ_E7CIlNa;jQ?T4';_gWE,t`]A%"$N]Ag5
'!9]AS]Ap5*WkZ(\Lds8`':9bW[Ft-\s^%9WX0j+*Ccmj/fjLAoJn-]Ae8GXY>bsVN8RH0I?M1.
.5c&5-H@2+4O%<agktI[S;B4KW/a,8g?$KXfL>d)DhcSd[4oJM?Jg/uAH!1liLE1-ej*GB,G
%CAW3ui?Dp=QjEYboL(qrH?jKg>bj@S%klZkham)nb)3%L5@Uc.aa[NXHXe(m.P#F_?_@D-5
*<RI=OH-0h)Yt<X#V2qr4Q("cNm)Q(7!dWOteILe:@ed[mX^2Z"La[=bfPb&l!O-N@(G4<-J
Jbq]Al=EONcsIP.9_=>t.N=+cV6%tPn0]Auh;cUo0:r'tA-0C=9SlCVD;(;Nu">7f>G?pkl@'h
&P2G6<WI]A'Bl[@4Z.GH1jTSg\?+C53('l<XNSCs4sS9qIH1)44EZ(['B[YH[9SQK'4M0:[?\
WCX@4X$7UKp3+e3\)XR09%2a5o,*"X/T/WpfLY;o=#GlrA4'^^:g6%bEqU-j8RX:4phm^Uj/
`HqOmf&qT(RcDQe4Z'ab%^_1IJ7>?5=nB$S:ALC2<4-B"64D<l"T+A/53:aQ>AY&K7ZC%OT=
:Q*(1JX&MI.?OA),Z31c0WDJ^MV\!U.,&]A>'>;5B`[A^#5i#B9<:`Cl22ZU(k6/W-,JEJg7q
^='i%a=KL3$1aG1(NLRCL_O(^N;(mkE;^rmf:1+a>:"-kS:qO)1`YP`=QU]AYK)+*nrjh%%M7
aRHAUN.e7C:i.Y[qYi>Lj>29som[e(nbgMn"3k&1`k#mBkGp6J\T8X$NR$FPcPNsGp<'9Kk2
P5&Hn([P,CD=W(Hi@?tE+^Z0UFtT(`r79@",J23?]A7B\sD]A.S#;k5Z_p05h8Y>)Lh/h,`;(3
CaPbSNlN9BQ^&k8MMH<s7U-TKDTDKA&R>$$m=%^`'@B[cuMo8^tqF:b2"Z;'!tU-?3/NZ8dO
U[TS6TXNP!DdLVh,,Q6c$6%70$?g+DPX)Z]A3WddHVaXTK:OjrbMElk62AFI=o>6O8$Uk%B:-
b0]A[aBW:]AQ&IQQRZ?`;DL=TpGWjlqdf?D#]Ah/,p3b`!&,n+lW(Y:XDXI@JgG<iuWcpstN3s+
6.4.?;P%uJMlg(@I#kT3P+O1kC[DX]AVq^7B#caE/^pm9+_"<,uE_=FEC5nNGD.?-h[)pgeeI
<B^_X@rhLXc(Gmh>HPnHkaK;@M2ddcpuS"sSB(Fd%)(N1WLB[J;`4l==rhERI5pj"r.9&6@^
9B*;&uHmC?1_jG\qU+OQkl2;Y;,W?CN.^@'eb$,lk5o6Abm?G(=EoIodB:DkQ;Vql3Q<nK$F
s?:!RE3m6o,#lUK!dR,(A=sRG,_bZj?!&Nl@QW/0,e+K2)Q7PddVnGsGSJmP?%%QWKgcDCTc
OjM2KBpYfGj:MnHsYI4U+fLe<BY:amMT:0;'_QGLlm"u*OJUSb17U9*<sK$,M9KmVN_lBmf$
kB&:pZAF=oYEcdPbH4`J`<=d(-ss#&o9c!>_Sg6h]AJ8]ACDC3)Q`g0Y-rqlQ(b:3%P[lMYcbJ
/K2dEj7Q*&S=^IBX\kt]ARHV9q)INOriZ,a\Ef)B'8-`\u+dCo\fRb6?$U+\E@J=]Ao(79de).
RDk8`8#_UXoe.JUl%'QJ`F`JtqVfMI9maF!!?/+b;Q-TRcGo-CbS5W#i2^WH>Ch!'g.\XJaG
Yp<<cZD-;\LdeLIg_(>t/l&CPLL5og;#'rs@]APBs5_E-2K#kr^B__26sLtB;]A?\2$85foV6A
2FLgK)tu6UgL%V:<@r6!a%[nKG%iKGV>D5+ol$&jn3bAL"a8&-U(/eig?-H8o@58JIQAaE,:
.nXf,i*J,Af!1BXkD%>0r&MNFSE'OR.m`t']Ad&&KP*H;[FeFDkpu_H'lIA>iqKS=r.2'e'jc
CCiBA&GH`H(&i/U$bLX>4l5Ha`q_<?%4q%@2d[kAWn,..]AHe:q=\LV)QN$s/3^->/._Y5:V9
8>B7&UpGJXq2BA[D8tiPLJ`"L)Ud,t*JG<cQpP3d^#3b9l[f$1@;,<.A(h%L7"b'.ei"rlj*
P:h//LcU5l4c'?'o(`"J8PMdSVH?4JH1;O9I/4NBU"%$+Sg/JRHHTJJ_4j`$B"mR@Kk=L`NS
tgCq^/_AlD@nZ-jEN0odH&-OCc*S1.?d;TM/_U2M\OcY`"3b(oq'S>)>Pq?K/<13N!aW#^9?
SBAkP\6NH<0mc6E_6""n*U[(NCMA3j7q/S&4a/3cXGQ!%%$Gdcjo@enB*&qA%F&i_\r9`I6@
ibt,n?h&q<\I*/%jb*4fKSC]A'A8\g!%O%iD?>%S?L9$#jWBcG+4D/L`CuKH-!4&]AcSs#Bhf;
\/WB0j,1?k@mDLnO?7Sb'RATRUA#`Z?(%#$9?u9M4S13T,D+LAZ9h?rkNAR;I#G/*V%u3ORh
Cd\WZJe&u<<@"UQrHc>L.!hQ>TZchP%RiBqZOLc?!+iTTH3nqI(C4n%^q'122(Q$82Ht8#$'
q&A19lLICq>@EAlmlOHlCCPE0C]Adm%5USj(-<IuqA0$dQ0!*'c8<]A_:&<3opb[E;m>O\$EJg
u2pYNf4+B[4@hjFHiG#acj^[Q>+I#T5K.I6kmg=Xg(fO#5YUAs)"nd#tM@J="[SSYHq%qU+$
,F;SLU#KpBXJ45)0S9RH]A\Cc9>N.Pr]A,!CAUC$=j23^XA8V+!r?03&ck<'I;KTQ'"4MmBcn*
\dJ+a!LLTp`Z+8bO^VB84*WO@,I'Sm$&CBnpeK-'u,)cn%LmL1b_.g(u5`2l7j0TA#cXnOH<
ENg./^mjh@&hfA">b2Pp[r]AdZ,Uib@Qr--j/aM`B&/@hTrf;6=E+3gk=*abOY<t2!A['jc00
%E[%I[q1hDcu+($F_>!)fJF-HuL5P/HbJl!VWL&TM0^%!*]A`8>SUu-hi1Mr<UAP=VS_"9C63
:RZS8`s'X_'.=5[tGoU!n=HKKIprYG2rZOi4cL^!5<rU#;>B`2;QIgFHEJu3!*`79$KJ,,%B
=.>Ebbm:dI-E`C9:Je*A>j"f38M0RN2<_B_.Nb52\ii[T>C_f>hQeGp0[V[sX0&Z+aA]AZ[:\
Gudl&UP686l&+:[>L)X1;noXYO#*/1W%-fp'n@,kCU[96=s(Tq[6*HGOZe2f[SJlZoN*eEm_
6s4,#(_E%/ljqn'\l5Qi]AE1O9.gtR]AAA58":AV_)ao:+I]ASlce-1B0e[g=TF#Mj%ar[_<NR,
BpcR.8e4YQ6aZ[T6TJ]A4`o[[L@fW\GU2b4mb?k%/SfNq01u8pT%?H2VgugY56m=MpaIWo7us
P[N%D[#Gj'4h:-V`@@:QWLCd639[gg!t*bY/?/OFu(9`]A/ag'eNqgOUmeD0H94n%qZu$d1G&
8IS<PQ*Ncmd.EMDVgW\M'R-GD*r*Jkha8_G)m[I8L$qjrBq+QK5RqC[H2Z_ms5?.>H+Grh";
B+?!?C-LkQglpI;<2u*c67MX#?(Qh]AuPgE\(VQA2G-h,tV#;$\]AuUa;=I8<au+JqNJt\2UCj
/r\g>QT#.<HdEH,p_p`>eMYs=]A1sBUES[2,gF[(Tn2Fp$JNUNQ_QeoaFhrsW81^_`dJ,/D$?
04^X0#=3KnNWhQUGf&Ek@O*pIiXIPB0u=odkla#ZGp9Y2=#SEU@u)c[(;Y_>6fJ9']AM\*Ln1
?2(R9r+2\_c88ZBn7rPM'G6m8g7dNZMZ'N6$V%)k8SE0`!FjHbDrYGF1e<cafE]A=bQ@ad0F1
\)>PKod"j<6]A$KJ,$Ut>!PX(CEBFYdB`_H)RMPH1$h)!oo@H>OArag(cZQ#Ta\8b^n%FD:=U
?V*I0O1$;1If&kYlM_@'OT@TKXZ6lZNt\cm84JEJpbDefD"+BX\3TMa[lH-asZ6,___-RU%h
[23!fn+%3ATn%nm_g:s:+E9SF.&H(Hp*qH\Xm1Ll$`R1sS,'9%M2=G<n+)&GVF,G3QTQ2r7-
&.s=lA?.\kr>-%OGmoT1>9qA+mM_a@N$I,#p,9C_(>QtB)dp"2VU*H=\0bE$Z#;'r/9cX+XG
$g07;/GKMJ4*.psGMXVN!H8h8LH.2)$6@*QDUWq7H4V5hr7.p"]ABRMIP?=E`W7kc&hJ'3"Z)
o7;Fj!*$dg%joFbGWcgQ)F\.u2XH^mJPj2W+RR7;@d9:"C;4uiBO3IQ]A:XU5IIkpV_XSe7s6
W1t&0b&S16CA1.$2[/$i[PG'X]A*QIPhb5&A\H!)sUh!!i)GSG,RgF`(Gth!r*"Z7/`0HnNS_
s.+=6d9V3)&Xd$Uh0-R&=(kX'>GG!19@EC?*d'+c]Ah*"?V0cnJ)7$?i4I]A;B&NaYLoakIb@*
WMu7UT4@7+i`__:7Fr3c4q><TV9h'f>,"a*ifHi/el4<j!:Y2'hgJFEESIFP(oYWm*`1qq;X
^65EZ2"*=Ciu`%!G=!dq_bB+Y=V'1AJYVK,+ek9a6pp;O2-2NZ;$EJi(=gX?!R.,8<nZ^-!=
mD\o+G\Dj=X4Q#qO1,m4&ZS.@+G@DK"bq>j3\m!IDPY\N`7RKR00*"l[C[BWI7"Z\gkXOZ9r
.RS?4;k!#jt1iIhk_#;DO8?<AsQeG:Yn$/Y-uW)D3NHFFP[9@0hUJd=,('gA,(9R!./37sKW
JSqhJ;g5AL0H16__OnCi*!TuNd[:)JF6Z]A?o?$;hgR%?3A546tqfS1[%q)uan0JA-s>_#PT?
D0i59iE?o=H)biN=t+i[jW/s#5TGrCLeTri@/mDBeAuM0j@N"#8:g_UDP86!#/A`ntkFqP0r
ZT"G<&M@2,Hr?fa!GA0C3f1%l"LEULZ>#F!2Vgl60LGJh+h/:\bD^cE_8rm9J9U#mn'HO@)G
0B?PBk^A7^^sXEdnpL=M6j)/R(-[CB!8Uc8`B)_9HC\%NY@KM"8J((<Mh2+nC9iVt-JJT;p`
.a7%+ci*js@,S"i.Um?IN?kh$-o:J(BAl*%"46a`_;:7T6lWj4YG@Po([K5,PYrCeY(^dT'c
a3r*gLY8HHBNiBqjMtYFj*P.>oY:B'HmVd1.>%5O!#s$#BZY8t4$Q.:qhm.(6C'Z)<II7I5%
n>_H>%G:R6kD)]A1;(;ZcZ99g#EH4Yj^orga+Wi2Kr&HC7^R?V,?B6F=Oi,0lK6l:XF""`4._
W@#;ACJVCEE3`4DDVBAcY/=H[%W[+53R&%R.&cq7)O6"BG$f',[cp7]As?AtT1)Ila\D>6gCo
-hVconQ=VIiD<u;&bYS":oK?^\Pn)'FG1H\=aD+ND4,W`6SsRN!AQcDb/RW,?[<#3RFa&M@=
<o:FD]AJ$Dfn5.K)O3T\p++L-'H,Z_8:1&K&\eR]AGBeb'"YarJS8mI`ebRr";nuTN?Lg/A8TS
($'k=!:qL#kCW$eRZ>`G^qHC#c/RT+OiL_<qB'mH*=(')%:rW?Z[gnFDX'&PQK58_Up$J'-M
NHbAnj9EqD#mE;H$G]A8&1\"^PS-rX?$)([(emHfX7h>!AG,6u@o9([*cGm/:p;ttVl:+G93l
6UX>R=ubXZ^J+iJD^9r#VEo%CY*DeZ6XZ7TQ"L1\b/*e,Xu8Qq(!8%*&:3Hg7&&'!=LbZGM$
:28*acOsA8:"RXd07*C(aW;mds+GD04\.P*B7>ARV[S-_mN.lkdG`lmNg+r)4oZa?Y'/jOjT
dr3&H@9C@@;d;4VZFoI).k5@+/UAW(0EPSj+(_rI;(I5G#1TlcikL4&IYi"=bi?aA[JFo&'t
_e=8KKDG"TRYr.I*'\gm7Ko`RS7s;CVK1m+I`4%@T;ES7Og*WT3:D^2oQf*o9?B\mti9G=\P
,GK_X0IUO#hX*L@\Vp<'E\F$4=RM`2kUX'7_II)=r!lllo)>rU6;,dH98S>[ic,2aNc.bX*Z
<N,/(H"S.A)b^\$]Abh8m<c.N&#,=hM/j08@[AT=K*;qm\5naOI8OLHa\p#*C3%W]A=#rqeb6K
Z[(cS3SrO3A5B\dID`=k!pqcaaCj]Aj"_/ElEX^"YflBCX:`IQ#ga(A`?4IfsDVL<6.Ch%3Me
XDsgG7sCl)0Y/l1Y<B?I%92In!/P5]A*kedDHr[rE(h27.SoLFW?b2pWL5!?I'A-3-05L#FZ9
.ZNR3:3#17'nXoO/\9NkjIbC8`Jm+o5/6KdFJ@@b"p7UT0,LC^o;6>k+6ct@(IH@(3&t3>3a
.ZA1X3o`63o@AFdUG43Z`Dk7HP.6c_5K%Fj@>*<^A[Mi@=+@r*9V2l0+6#k:;1Yf(%!I4-)*
L&b:#[gO"lL4R"2A!m4\2E2n*f%OFMN3`en_'g(YGn2bUOlrh$qnq#?Icc2S0/29RCS2$");
1'1>2:=fQ(kg;Y=>TIOJ3u]A0]Ai1b/rKDlk0oBcj9g=2-<CEoOmD+Y*Wg<dP77M%$*Rcjqg3n
[+/>cFdVYW$8Lau!K^D*,B@rIJ=9<?G*.s,r8'kl<9NU-B!3[;Y!<XbF!JK`UqrkQZ+D*#Kp
PZ3QdPOJ**S)2+)9ZG,8"a%up`@%a,EFjVr+6A&>s^b.8BMplb<F!tW<Hk6D(\tl<SNu7[9@
Us`o3#e?L3VM@?^K47[`[3+L<@]AIq#o*o:'qZ-`8WYHV4So)mr*=O"Q'?B[8jS@!rtgnf%Y]A
G(H"c.+U<gh>#IAh'D?Fqro_8O')(DkmGZa2EUKlf"H/*_*R:LAH/)G26g7kq\FLVXJr@fQ`
G!lmMn*gScYk"8EcpU-u2O\t0AfnCpN/:CVE2@["0bdqF"3S!uFI,<.JWX+q]AmtA4#"[j=TV
jMfA"7n8bjkKK&PI\q*b_8s7o#!Fir:sPA8dEEW7P.=-#QL8VFl)[<$e';!;a%::-c.^-`ER
h=%B#?.$nQN@[3co"=SXQ-6;6*$:A;Hd/''IkZT^0("s@d?0GG-A*5W*duSV<_pi-lZ`[fZa
Kgm0AqE8629Q*ar?KVjNof]A40SCX&4r#&WP#7U,*&n.0Jn52q\&kk=MPmZJY0rj')gL2m-+h
$C"Q'/Gi!lO#hdM([<,0.hEB*"r.?k6UPQ=/gC8J>lHCE4>e0r_5\4A34BMgS:-_QJtD'bbY
?p&HHDJ`up(1NbR]APO1-6?I:E=E+VQLFe*uXr-f"H9#8sB:Je6)0,$eg;BBW0jYd#6q@?/Y-
7uS@V#CsKPT@n(M+X`1'S!eOMrUY+@MsT7AFOu]ASG'/'GKgfe[9YPo;Js-g,5"=QFea6KK??
<'OB$M#oG.9S<q`1!X/R*[0RiKXYeel0kIHVO=IIIWcb`"P3FK_94=n+-B8"pR^.TVB:p>a+
^e%+nlVh<>=]AX0d3rRg0c?o1?V6tqS\#m?'<lqn(!Pp[#V,pBX3#IL)<6k!KPM=`.Jc/5,Y$
8a]A>rD.)&HSN&W9@lf(tt_i&;u"R_3!$R(sA%]ACI?:J*6D>E6+XdDln>lr/H[Xrso~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="33" y="435" width="352" height="149"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="延误-延误原因维度"/>
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
<WidgetName name="延误-延误原因维度"/>
<WidgetID widgetID="e29fbdf3-21b1-41eb-b901-4f5e592cf963"/>
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
<![CDATA[延误原因]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="3" align="9" isCustom="true"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="80" foreground="-13421773"/>
</Attr>
</TextAttr>
<PieCategoryLabelContent>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="80" foreground="-13421773"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
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
<Attr isCommon="true" isCustom="true" isRichText="false" richTextAlign="center"/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="40.0" isHighlight="true"/>
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
<PieAttr4VanChart roseType="normal" startAngle="3.0" endAngle="360.0" innerRadius="80.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
<ChartDefinition>
<OneValueCDDefinition seriesName="不正常原因大类原因" valueName="数量" function="com.fr.data.util.function.SumFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[09延误-不正常原因]]></Name>
</TableData>
<CategoryName value="无"/>
</OneValueCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="b21203c8-ca6a-46cc-a56c-e33ee3dd4b94"/>
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
<WidgetName name="chart0"/>
<WidgetID widgetID="e29fbdf3-21b1-41eb-b901-4f5e592cf963"/>
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
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
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
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
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
<PieAttr4VanChart roseType="normal" startAngle="0.0" endAngle="360.0" innerRadius="0.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
</Chart>
<UUID uuid="23085a44-8bb2-4b4c-ba88-3b67d7779b0d"/>
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
<BoundsAttr x="597" y="419" width="213" height="157"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="延误-航班对象维度"/>
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
<WidgetName name="延误-航班对象维度"/>
<WidgetID widgetID="e29fbdf3-21b1-41eb-b901-4f5e592cf963"/>
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
<![CDATA[航班对象]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="3" align="9" isCustom="true"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="80" foreground="-13421773"/>
</Attr>
</TextAttr>
<PieCategoryLabelContent>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="80" foreground="-13421773"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
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
<Attr isCommon="true" isCustom="true" isRichText="false" richTextAlign="center"/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="35.0" isHighlight="true"/>
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
<PieAttr4VanChart roseType="normal" startAngle="3.0" endAngle="360.0" innerRadius="80.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
<ChartDefinition>
<OneValueCDDefinition seriesName="集团外部标签" valueName="数量" function="com.fr.data.util.function.SumFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false">
<SeriesPresent class="com.fr.base.present.DictPresent">
<Dictionary class="com.fr.data.impl.CustomDictionary">
<CustomDictAttr>
<Dict key="0" value="O线"/>
<Dict key="1" value="IBU"/>
<Dict key="{null}" value="其他"/>
</CustomDictAttr>
</Dictionary>
</SeriesPresent>
</Top>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[10延误-航班对象]]></Name>
</TableData>
<CategoryName value="无"/>
</OneValueCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="92c4631b-a477-45d4-aae5-0f231f5d4d16"/>
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
<WidgetName name="chart0"/>
<WidgetID widgetID="e29fbdf3-21b1-41eb-b901-4f5e592cf963"/>
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
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
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
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
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
<PieAttr4VanChart roseType="normal" startAngle="0.0" endAngle="360.0" innerRadius="0.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
</Chart>
<UUID uuid="3c92699a-6338-4c35-8bf9-301d08e2bd70"/>
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
<BoundsAttr x="798" y="419" width="180" height="157"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="延误-机型维度"/>
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
<WidgetName name="延误-机型维度"/>
<WidgetID widgetID="e29fbdf3-21b1-41eb-b901-4f5e592cf963"/>
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
<![CDATA[机型]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="3" align="9" isCustom="true"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="80" foreground="-13421773"/>
</Attr>
</TextAttr>
<PieCategoryLabelContent>
<AttrToolTipContent>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="verdana" style="0" size="80" foreground="-13421773"/>
</Attr>
</TextAttr>
<richText class="com.fr.plugin.chart.base.AttrTooltipRichText">
<AttrTooltipRichText>
<Attr content="" isAuto="true" initParamsContent=""/>
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
<Attr isCommon="true" isCustom="true" isRichText="false" richTextAlign="center"/>
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
<Attr position="4" visible="true" predefinedStyle="false"/>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
</Legend>
<Attr4VanChart floating="false" x="0.0" y="0.0" layout="aligned" customSize="true" maxHeight="35.0" isHighlight="true"/>
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
<PieAttr4VanChart roseType="normal" startAngle="3.0" endAngle="360.0" innerRadius="80.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
<ChartDefinition>
<OneValueCDDefinition seriesName="方案机型" valueName="数量" function="com.fr.data.util.function.SumFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[11延误-机型维度]]></Name>
</TableData>
<CategoryName value="无"/>
</OneValueCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="0e8e8972-cac1-480a-ad4c-0566cb5625b6"/>
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
<WidgetName name="chart0"/>
<WidgetID widgetID="e29fbdf3-21b1-41eb-b901-4f5e592cf963"/>
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
<FRFont name="Microsoft YaHei" style="0" size="128" foreground="-13421773"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="0"/>
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
<Attr lineStyle="1" isRoundBorder="false" roundRadius="0"/>
<newColor borderColor="-1" autoColor="false" predefinedStyle="false"/>
</AttrBorder>
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
<PieAttr4VanChart roseType="normal" startAngle="0.0" endAngle="360.0" innerRadius="0.0" supportRotation="false"/>
<VanChartRadius radiusType="auto" radius="100"/>
</Plot>
</Chart>
<UUID uuid="406aa372-8fab-494d-9061-00a889e47385"/>
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
<BoundsAttr x="969" y="419" width="180" height="157"/>
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
<WidgetID widgetID="b4c94e38-14b8-4326-ba90-0f007d4a0147"/>
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
<![CDATA[近12个月出勤率]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
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
<OColor colvalue="-15378278"/>
<OColor colvalue="-1197808"/>
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
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
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
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[时间维度-优化]]></Name>
</TableData>
<CategoryName value="date_time"/>
<TableMoreCate>
<oneMoreCate cateName="年"/>
</TableMoreCate>
<ChartSummaryColumn name="执行航段量" function="com.fr.data.util.function.NoneFunction" customName="执行航段量"/>
<ChartSummaryColumn name="延误航段量" function="com.fr.data.util.function.NoneFunction" customName="延误航段量"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[时间维度-优化]]></Name>
</TableData>
<CategoryName value="date_time"/>
<TableMoreCate>
<oneMoreCate cateName="年"/>
</TableMoreCate>
<ChartSummaryColumn name="去年出勤率(全口径)" function="com.fr.data.util.function.NoneFunction" customName="去年出勤率"/>
<ChartSummaryColumn name="出勤率(全口径)" function="com.fr.data.util.function.NoneFunction" customName="今年出勤率"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="f282b7be-32d9-471b-8475-23006cb05c52"/>
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
<WidgetName name="chart2"/>
<WidgetID widgetID="b4c94e38-14b8-4326-ba90-0f007d4a0147"/>
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
<![CDATA[近12个月出勤率]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="1" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[02运行指标-时间维度]]></Name>
</TableData>
<CategoryName value="日期"/>
<ChartSummaryColumn name="执行航段量" function="com.fr.data.util.function.NoneFunction" customName="执行航段量"/>
<ChartSummaryColumn name="延误航段量" function="com.fr.data.util.function.NoneFunction" customName="延误航段量"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[02运行指标-时间维度]]></Name>
</TableData>
<CategoryName value="日期"/>
<ChartSummaryColumn name="出勤率(全口径)" function="com.fr.data.util.function.NoneFunction" customName="出勤率(全口径)"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="f923ca16-f3ad-4546-80cc-06b8e81763f5"/>
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
<BoundsAttr x="788" y="184" width="339" height="188"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="延误量"/>
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
<WidgetName name="延误量"/>
<WidgetID widgetID="d2ac673b-358c-4f34-8bb0-33d76d0e13b6"/>
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
<![CDATA[1371600,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3139440,3596640,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[延误量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="1">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="包机延误航段量"/>
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
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9FL1;cgDNDWfT=>,C(>X`aiqetL+JBXGGgq9#++4"7F,d99`$U^B_l<$LlNno6_N<3/\e%B
32:;N2Ho'rk4X6BY)@@RN`j,pJEV$,cfejGSDXEt?R`*Ug[^[a2k8;mGg:5B8Z/YJ'[VfDD_
Y%Xe-($JO"MIe23f8X$$k^ThnBUe1S-0ko&\bCB15rlt<,Zhc%D@QtaFo[UGB%h<]AQauEl0r
!W,,Ed?/+A`U0tl_^OWSkXPah3e2\3nh3FYC1^Hp!WK%Ik#d?K;PJlpMF$B/bPHjTp$OoQ2U
6]Aj-QqhIb1#j/DUNT/5M?UA%BkbN1j'XR%X':.$NG(bKdWRnO)uCX<jb29iF\t77Z51JmE:)
[6pknk2'4amBk_`4CHg,o"TtXcgRY]AVJ!j0<qUdMDuBWlmX4P`5WB.ff2F5LAX);b99&TnOm
)q)i#W8bHr8H`Y-s>?N#@E_)eNNr3>Fi0Qp=d1@\/.);S2O+bM[([Gu_Cb),0F++Pg@T^dp(
H3]AmMb8s.[^VY\5EW7dXQa5VL$8i(O8qu:?>`0;Ij??U?<<'MC]A$!`r@X`WiTAhSaB1KAFr"
(ZT2TDQUkO-B>%hWa6-`ejSNM>8[&H&?$mT\2Eb`GW`pa,^ug?>6F&\p2oc2PnebiZ2`2AGi
?uFniI'RqhtEE.D2n)>*W@(UNa<3n@DnS[k8a]A@hX4a^>MC(Mu4P9O6PH&LBXe$Z:2R.+2X=
KH>80Dl;`RRaMo"4@-%FlIBQ>fI>FDBKu10iXL2Pbre7/A*\MRq((jelWQNKSU;nGX)[X"=L
.LVG4mp6A\0L^DL*1aataQ$iOQWr7CXccg<2tp5=WbOMtoU2dK0T\gE2Y(\058m0`ke?Q=Jd
PFfd5thWO@0O44YO>R\d$hDI#^>qbA6Q.ngk<B.=^+kQYe(:_#nd$%M01l!!UTmq720^kLT$
OR#DdgM(rf"dhNHMW!BPJYY[_sPbEUiUBQbq`C=&+/%]AORj7=?;HNGGY.HMkntOjjOX8+Q!m
?X%'AEJgSPS<n@_]AAlhhmtUh/)IrC:uU2AZ`]ATkE8nd9'8`8["rGJt9FQR"8VeS^Yo]AY/r/a
7I0!rIZ']ACl5eMs'"QSj/ZR]A\aY"r1a3\ltY!m)QMK[EIG]AL27RAOmb;j7-W2!pro/F]A2/%R
4U/;3I05H``-jcF_Fkb8)rYJt"rEWPfgd`epCf_c<9!D1*>I*!drm1r%R$4bdK?=&"`fqOT-
pL3G:\7LjksB!Fg1HXrUIc$(B7T3d`.[FTkTlO#rmi+KPETf<O+#[7%pDdO!6L^^J408l=qd
Cg)oIE:q<9jOR;BFSO-h@l"h[pomGM>#ULbbIQfB0)np+e_8e;g'gqT/lJIYNB4#%6ENQ7bY
5]A/]A[IcM=Lg/p0QD&>S7<N9EcMo.DadVAduRMYa<<c@47*.bET3/_J!Zbla;)Z"jIf[7t)+G
X\(</0PtK(BLIg=f8K'2CL,q#".QpNcJ?<"aRgM-'H2OM+*hPl80SfTQ+f]AoM3#d:fDq?FLI
MT&[oImD"LS]ALQ!Ccr'^FmsOJ(BPdnl_N$3XKccf8JO6;,)aqQ)*nIPZkQbC/s!;<+4B=X2q
s0DKs5(9\J`T-hsi0Y9_KD/CYgX<C2Bmc)qAZF=DVeW48;Po;U'0V$RNn9-U?K9[TRh$<mhD
hEK6Yu)aKVF>74R*n,tp!!mj$hF5'4.2tKPaDm%(+o5;"9j0uQ)"\aJF=b1:[#?*Nr_T@+E1
-\X`^6;*M`itCuIX`n4\,E)[a=_7\d2Z8gY`UJ1]AVX`<jWU),P_eol$G&ptaHm]A+]A3&m[#[/
pW//aUR/K1LZ@$RmG&pD0%1ohJa_C6PgYX;$L_ab6Pjing;lm2:9b'C'&D[m69S=,7FdMA;C
iB6l2UUL;/'NWQDh7<'TZkN&"CFF?a_#;)E%HDm\B.(+)7=cY+nX9cVP/V9(pt5q.?S??)ar
PADjEI'CSXo+1]AWcFMp\G`YNPF"MLW&%;HR7nEpq>Kc,K5)FPuhP"GQCW6GKS8)\KleEBMt;
o9DDi+ZZ?^L9mdnn:(1Ra=3$B6A7d^@N/rnsaP+[k+o[e?peE0*H]AkK-qo0fY2-,h@K1iVPV
f@jU&!`_,/?6jG/<s#?if;%Q`XP2"]Ac$IpnY<UHlc*Up1WO*(ge:CdOK4C.P]AjY7aam/p]AWu
)oYE0mi]A[KKVut#p`*IKpR3'C[mn^8-g:fRE1ef1DKG;q(V40e)#Lo9.;ZsJXCI9ra=1=^".
g=3N>b_h?V6;XFh3lUSO^Y-0^g`c]A(g?fH,Sp.<-`@2[2O,e$:-LJGIdC%?pNU\[`\2.,M]Ab
#hRY*)O2S</FPI`NNs5h-5=Ad[cVmBDW-r3bV-#.;p6A+QS]A_fQY"&+sME2*$r3%<)Y&Ir/S
(QRqR2#s.B?V8"U?aq2VuiZb&897#C0&1nb2@5k9QJp0\`Dm=/F\LiN=rU&XLR=>L`BkQo=D
;Vk>W41-hpZ@o&haZ$EY&C=I1>nRaW$N@BH@G7VQG.>,P*@q7*m-f?MEhEe.';4k`jQdIa^Z
F(ji7HCGT8h!b/X`IDHRm'=WY]A.TOIV=+(;,olQ<;>#e>?]AF1Xp"*nma/dIA>>MOVC%MKV!b
nZL[!8"REiU?^[$ClO)@st%6Z8Q&iEBV9Z]At`8[>k5#oue$4MR:_9/+.uB=b-:$%nkln8gkj
%5k"Fa8EanGqcP+!X*_tFqunskL36X;q^p#=GSgtg_+#&omj_9d%1^l=OnTb>(oi:<Wp:r1#
hcT_@]A3GK2l?fT,%825W(5YVDhGQNA@fZB04G?@d&eMO2(^7d,Z<jfg]Aa5#F7L:_2g,QdHr(
Cr_-1(cbeCmcP.^kuP;C,`"=iHqBO;fEn^`Zs/jgLs=A3R8-;i$_l"/==$\\,-K'kLb>#P(k
J6#ZX-@>V>Q!=!&:`InYp0)Y#GC?KSU&12H'\#&7`V%,-bNFTl?g(`_-tXk/:62<LTn6G0;"
8N,C2T-!,=2hqS:<]ALre\X5lfm$P%Wj&O;538Q*nZO/Ke::=`Fe!WM5<!8fUbMAf4WrkGC>d
5>Er8b;O6C#54T=\J]Ail3#14DY8<H,CJCCE.8bY?J0Sj(0m+VlF2\'U:JZ^.F/4(62boa_ai
!P7Sc_&C_m9=cE6\jC7GTcliL#lX?3NX2C3Vb:'Z(W[n1EN,)ri.u/P<(<-6=Gp14o9Fe@TD
>%.>NCYG?i@DrRH7g(qLp\66n't\MAobYk:J<BJTmkc+3M1hW?H6RCj2\S4?gu8Z5!#cPCNt
424A)N?a/AWH<hO?C`W,KF=Zt!Ar$.be7C^S_Ji+OhqJ8$#B=P)ouR?%"<)T#/,V0l&-h>8+
o"$i0ZBZ>Wh_V.%O\T;`I_t(E*=h8#SuJJ8MhR>i2cV)3'FAe?0QYM5O$^9I=1)r18-6(8[I
\$>r`C?7hq&B:3mPm>&@t!EDHb^Sp&V]A8.D\"WW[]ASh`$Yl1"6r,hfG;h">qkPs(uT'eTaZ^
<%M.e>i<uJ84kHaIo*qbKAI`\T8q3T>pAIoPrLS0<THM/ab.RWXGmp9tG\]ASdH*<0!b4l$P2
h4`Q1N74K?6pKr=UcI:C#f#d/?[(LAdgk'D1#Y)PB6Q\`!9XN"D6qt=)%S$LC6Yrm>RMia_P
c#HZrnL7O=7FK[_7i\>q;#AT\a"gQhm^Dd_bU8dlS:@=;S<=X+1Cc=@'J59SZ4)rIX.nNZoG
GgH%)%@jLj=FH[`11u&]ApuZI+2B#.Tt8e:/DV6P0o_%8PiDh=S#k(SEPV12D$#b8Pn(WP6%)
S7!j)6Y9`r"CVeIf'<TM^cfOVom9/qV7!HON[T),iX_Ma8C"GkPT@Vk?/Y(/4RD7):J(9#0n
=[;_CGfVO"RsUUoB_QEkF&k\05rh1P"4rc$biSEmuJjU;RNE`q)8r>Q&j2h/."-=-f]AVC<oX
0P+Yn9f`j[fH(cZT_/-!4XgGBZJ$r4,r>_jAA*<$Ng,9OUeZ#bD(DgViL@&jjF@d"PV,@%W&
E<HjmM!fBKa;DCX0.e@@WX?^m.N06:XkF[_$n"'es7Fc#b(nacHqnTI*Nb0hp^`&-cZC]AjHd
KV-0/qgZQctKX*(E1)l,[0Q9DWL-"EC4B`i?a%#/`bi%jZ>@'D$DqK^99VqnF"qO<5BW-ha+
brh9f`<^',LEsZsEAH74>IqMn-Tu(WlV'sLJ]A24Y'XstL]Ap`HgCG_VJ[hNF3_%jXqG+@>D6Z
&5P"L4V>f."pUBRaV7AA?4'p"S#Jn]AGa<e^AYqJ;hQ:12P6sB*TOjUHoLhIf@+t``l>Wu(1N
(Amkc_!"*U$dl%&JOHk-kc3!6O`)!;XR"-HQf91BB^MI,bI&;"IR/Y8\Lllob8H:5uW</jo3
!J.l<Wj(EK]AL]AOD._Dhp!d6F%L%,NSS-!XXUk-'c,_D4G_Ln^\SgI,MX$Xkg>HR3op84HC6?
hoXf'XFM^(3!W^C++G%+/A-W/h\;H.[NeBKu`d?FHSuPm(,GGRC)MfcplQiD/'D$sOXU>DQ"
rLo)tUrA%1NPj]AV6Ro=S*K<UKMSi[g/0&o1T>g2dCHFd^XC<:[r(q\Ip#nMFo!AXZ$B4FS9k
^.mBR&"j\-)B^,;/`T<paiX#i^gGcMROj`ErWqu&L>T0#%X(.^qH/5??Ch@4`i<g"^$hdmI+
bUI06M+C)^]Abob/dpcW4[INp&#QC^d*aNi,0jP#Stj4:P^&K39<MNeBl$fsD"<C[+u*'g2($
CpTFJ$3V%B=.X9D+!ZV;Yf6dg)RXCO2<JCq`;F!W&-S5'VE2UlK4112s!^Km5O`.T>[OC&6@
+s^F"ILiG6On^2Yl/`ZK22W9D.E_'.&;GAU=<C]A23OeOMC?pmpZ:o%ZOA]Afbl&(@5eY'(I9@
IlR09)eesWZll`8#e<iL^VH;8ul:O_T#6DB6N[Ljo"_[&-_8u5uHU2h/?uN&r)9l@:@!b5]AS
cm]Ao>a#>f!>`ss:I2)N:WTXE\b4:6>LnCkp:Ybi8B&)/Rd,]A@9T>#.k_5I`10W:^8;@iOI.0
k<JXDaKWroP#o[SH"IJ%smR2mjickq3l%HI_YN2JKh'onX'TPbJU0Dq*[M09F"QtSMq4WlVR
+te7?l-pi2VG70!a2qX?,6\eV4(Vg)`q37=b=&V=&5lRk&rf(:m]A0_/Sb1;<@"mM&Ur+&%WG
I!dgR>>":<kcS(Q/:ZAl-9\!NMm0:pH,^V(iVd*M(Le=q;;N%:A5]Aq%aWL!E>k-A^1.0ddTY
fn#02H3=5/*b,5ED\`P&r;lbf\QA@U(7uW?=B[i$W]AORak:6H1"l+/sYphb[o$CM5/RD!c[?
).P27EkP`P"#s8RD@&MDMW;-^h0('SENRQV:9WI^[^U>7/JteeJuqW;TJ]Au(F%@`r`8Wo0$T
E<N$A/ZCf)aKd$u*G7FFSM5EXh&"PjbHMff3=4iVRi#'ppk37!"r<QmG)&G)FR7!H_jhi0b*
<=N/NU-77d+pVOLVJZJi8QfnGm]ArB__G)-fh`E1eoE)_hOOUdrdWH>`>b4<G\_^pK"B94Q;W
Bkc$T+lDU?CtHeWfNQ@fa4355pZ0Hp`,!2rbo#^kgZAY$m&`[l3W"l)s$t5*bNV_i>78*'HS
d\!W_U/%jfc*2E4ON9I*qiI5/Z)_?)M9K7fF"5'KbKVk%A4qe3%`+%(jPbI\#U8\U?4d=mJ&
PQOABNT,&LeAKSXn.(Hp;jEq+qr?!fgBD$:q$]A=S_mA>BPPmIT(]A]A3r(7]AlD722cCmK?pj4+
@%2O,*tV`i;5X.UXn96%A%_mdnp^?GrRBfrB5/ciSi;PU#@a^Kb[`4<]AXeO1bUct+ub$$f6m
;:`%jj9#n6TrI"_VF7:F[KdkF_P1@A2s&pLYI+8Jn!lW:pci*;'ufUqS9oS3)iEa6C-+59f$
[0=b-CrpN@T$>Fj\(KSaQ"1-+r1.-0rK;F+VuEFi?b1iaR<o94d-60l<[Q>OadS4B]ApV4D3L
'2Kd!;_Ta.M),P+N$a8[!D44BZH;?u?b'mVh!Y&q=WAX*pIUm'Jq2_P5f8YYU%<^;Z"(5;6U
Ab#qq0Aie32k9@CutAm9i7d?=b$IM7NCs`D+'/dSb@"e+)umUbHP@:ou1c45JMUhF`\\oI$J
VucJAbK/.t?Ppb:PO!6f!OEhg:/"t>-V_W_u%/gc8pe@AoF<?%TILE3skBQ##"'eVF;.lj=(
Z.#2=7T5:NScjXU/*X^51=!]Aj!M6QI-_,rT"^m3imcm'q<k_QU*hdt8#\?A6p&[Ppp?0i&"^
a72hD6;$Ue192LI'TreoZcA)1_[n_3bLE(]AuMUaT'ba:,`ssR1`t8/BgAWN0.?eo]AI5%*bKI
IFd7`27*N`mTRj^qHq/go5.<NcmC>)?"c)=Qa>opg3qU#.O^_-9R;oG#!JL#',+Mn,)#>++,
sflHM]AebcIc\-=A2/Z?pE-DK+Ok8lTb9*R$Ui(k$N^iqf-rRl2jT[<N%4?28.hX?qM'%@f#^
>BH)dO4_&3oNo/!9alhs\@#K-=3V=f9_S&9U[9*8ld`_7oOV.PAao8#2feMc6R(N?TQ"!oe3
^&p37,pCKSBW2P?$ms\Zj<Lqpg^MP9-,I,-jniPG,sV(oh<csJ`((dEMaVcO9,$c%!^6Ggd9
4IQjNl#JFBsVpn%RU2;7]A'`4'Y)&EHZ:q(iUbS+uPt%Nsr_P.LNO1`1n7O3"f<\`-PatcN)(
i^lh7@+U>mt:MM/&C`?aupu1]AW)Eh=2(oQE,(C6F:R#-^95H,h,>VfNn$Ki+=.Zlif0V>Yj`
M/_8(XN/$_7+cpCLcUV@]AU&D79jI80&FNs\m^-T<k*@*0]AQ@MM1#FB1u>!CL0fFV]AG.F?Xh-
8#jj'[I--f[[=m^H`T'mo1CHD:f(oC4((9u!m)0+]A5<53?0!+#=t#sbaVK*el7P`Zdp]A#2E>
Cgf+J#GGNi1cA_`e'o)),',7=.p;@R:o`^:Tt2'PD<`%NiGl$A-5>2O'jD?]AYu-j0OV>#jUH
j$RJh_#pN!TA@#YSM]A[0HKUP.3B&&;=VZ"&O.V+ESUsf_iM'@tMu:AmE)CL@$#E,Vq_1`$?P
9b3OR'nh^J<UR72YpU2[XQlL)DD6nRq#*uqthc@kSKJ?Ra`gUT!3pD%"gI_S<JTIU2i/ZE/5
3'4'>@mp4P89<&9cbOI53U>=nbf?%Uo\,[\I10i%[HdEnS^gN;^["'T9&X//@g5$PoC,:f>D
@Z:O)?'iJfqK0Y&)F9[($kmVp<C51cE%8GWmD`$g<_:cUdD+QBuKja_jfb'&:JOYXlWIXnHL
8;%#Hk3(+GT?-XHT\b/[U^5hc>m9@.,JB+cBCX(1,D?)eLlb>!o7R4;UH^R:ilA3>Q*gl.%-
BZ5T=Ca]AN3KO3'2?ZBFjlMNLG+5mHjEoWo?1f^ijZYi.nRQ5*X!Wp_k9I_$!q>d8C,?(q8=.
rdR]AQ)eEmdV8E\[O1E)o[>A\.+Iu_"dhHpF!TWDd^RHS!1'OZ(3UP1a@L1(_o'E@odV%p2Is
-N`e~
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
<WidgetName name="计划量"/>
<WidgetID widgetID="d2ac673b-358c-4f34-8bb0-33d76d0e13b6"/>
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
<![CDATA[1371600,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3139440,3596640,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[计划量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="1">
<O t="DSColumn">
<Attributes dsName="06出勤率-同环比" columnName="计划航班量"/>
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
<FRFont name="微软雅黑" style="1" size="64" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
<FRFont name="微软雅黑" style="0" size="72" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9C*F;t[iDbMBah6$54cBG2,e#+8LkKXPU#%CiZO,6l/t%Vau>6*2uNkuX<,*Ks/(a[dXVgE
pCFW!jja#c7>nC)]AKV!Ybq=8o0\J%;D7XBtenVS9q9j*U^2qhrj-B'du1?iAp)j5Q?f%qg75
ppIfc&g"#0:5FM80))GmKc?j0BRMdo1J=A9'k3mck6fcCeSb(YnB!?r6.t7Hob51)2`PUfMh
KlC*lK<ZOr;<;p)NGm=_5$Jd3P*o%=hJ;mNi_%W3qp]A'olmM4\)[1eA\Z@?;uFP>Xp=CPN;V
D8_EV]A@O2Ql^^:3OhlF15sHX99FT3]AHn6sT[/-U/*W:X6/Q'dYunK]Ant.Kks97eU,#E5BFAV
Vf?mtr9U8V77._)!r!!.cGC/*$l.Ib9mt!DHDZ#Adso..02Jp'8iF>UVj/*I"'<6S/EF\-1u
)=EfoW&60)1aE',U;q--oYiiLFVM_JctHE<4NT/*TiU,"F=HfKi:m!kmXV7;9825mnF!Q\P+
_fo/D`<dq2J9\h]A!&iFcnA_J@9FgDp?bDM#b#2V1_h8_XD5C*hEp6t`_8a5g8`TXSE7W3h``
Xl,OUFFK#;*2YXUG'.sdW+M2KeuV6Imd\ceL]A10R5_'ZNT=8F?:"P1<!oQ5U<o1pAd7hHeLG
<dVWb#+Pu)CJ[Q"%3ml9n1#%$2#aHIh_2l?U!*TsNUW0\6E>"A2;0$\GAr3NC59TJkODm+/A
VUSMj_aH-3K2%=TD$Jb>3Ng-6^,E&cRElpd+0.7+`=;392@SXak,4*-E5fQS*-dgJVs!i3\L
hV.Z68p/cddT<#E''I$Si[<=!qU2o`PdI+g\@lNaF`>>&URHd?IcDBhHPp_ojGs?d<WMRmq)
jDOm",ndh8ea+3a*"c)$$r)jL#O_K*6[#pEdaH.t@aREWA_1E)E1apV']AUuT?+=XV,%UErH$
7E/GFHR:FL-5&r@V;?2LEYh(^C;q&E[)p:Zrsu:SP;UiNER\smq-HKE2fN]Ad?d7V_j@sis&$
SaB(?pXP]A,D^6-c6'Lq/ataNVXJ+h'<b;j\[`oPgK#I+(sC8a"$cFs)S:;;d%;>WR6lDum;]A
qbcClWPYZVq:Rcmnrp?-rHMAdYPiot<r8bWOPK96qZmLK(J?`kL`!H(?)sL+I,-NfVVJJnSQ
fuoCJ'FhKl0VaG.:[dq>)L7W7o>6hkFGH-I/b,22!417g2Ag<kmPU[<9+9p/OGQ1J^?EP07.
ueMbT0@*!Mj*K'5QaC<h[YHATkUHD!WMOD>lqJV&Z`"SYbLF9s9iN):=IXKW.15[e:5ODZ@<
&@"q.CYqSiNo&>`NKbGJpj%Xm*1-73k2^N&p*@OLDIAT=0VSf+'iRrk[h/\]ADY<tM'#a5^/5
O`1Wa$9(Rt]Auk^Y]AA!T#R,_`\+s/2,.]AL#VBt&\Mm^'9&MSb'4O#jrnK41%gei>"Rl;a^AZq
`L):h'CS.+bf.Dn4Y9\C0fPE.9S^gn*?f%\(\&`,!Z`9Imq;,'%Q>F%O6Uj56Hh`$RUF!B/n
T5H5;&#n9rHaJI!2<HT?uep!(iXC<V#1TXXoBiUlsJ,$Keh[]A8?-lk/Xf%GBrT&i_]AroJoE1
ud8W9XIT^Qtc*XsX1^fO/B2EK\]A\puddWe"jS1u)'7u,mQ%&V:674Hr!r73\bEW.%<Mo7BuR
p2k00(E@ZDD*pVUE.$Y6X]A$K*O$W[]A4Y%k=qf/![._lE$FG5iderMBDe74>8LAc&.6(ItU@0
HK'\YC6'(2l=Z.-o=T"R/DDHFFCOn>Z>rn.]A!n`eLt4KF[!r6qd=-psJdU"A_/8pd$XX8K]A>
eQrA_T"Hi[/:Y</8@Jd>%(KilGU.Vucf!;&lqqir'f(p\<_q!^Qf;PnU6IHE'!H%tFC;&a=8
HKfGA6^J!.Q\inXqMW\\sNfUTscm[/t,NjM<2Z#fW4ML!efec<)ZhUiA\b.b)g-mDcK,nV<7
_E&..X@W!b%T:&lh?6iP5/nDrVSOs[\c5<aOmD6-KO"0C3f9]Ap,N,RG=4(mF,iK=r1B`:9,.
2Gl;FQ!\WGK3NII)uXX)Uus)?e2WcGl4Yl)qio>Y4/b;c<m%]AGS]AbL3oTAa6NMpu<#g$:;KY
foH&"aEF261u_<NX?Z,0GE7T+E<V*kq`BLSW0baqac%YQ`(e^0mk_\1)YZ\1B;h!,m!ZQ'KT
H=#0,iUM/$Ac0TN(W_=2D_C]A_@Q;:m%YK@R(`S99kh63d^meul<(]A@5B]AK9+4co4PR=(,_2m
'qh!p@5?cC\-'TbDOVa$&;DZ-k;"MM"Q,ZCtRoOGm3$G71Qoi1niZ^;pA]A_+]A6l8`H3Re3EG
s<E)G[[\qh?.hKq?a`?8#nJ=VMX`-suG`Gbob;.2sd#Jo/Q>=hg+u_DX7>^!kPc!=:_$jR\C
7Qe*gZm'?e-So(jblpWm235.eP81Q%:iia=^.]A?_rGn*7B_!i&iF+5P1[-0-t^4Q8Nu>iP7Z
1)#fSZ&>A+fbApn;)GS^TurlW!A9'QS#]A@th^FT3WH<N[dE$,qIFjbn%($9["W6<@\1oX>rG
ll<.GJtB(bkXiO@59A5Y&>J'*RQsFibQ<>J*j*[X3F[t<Z)O_6`"Kr-nR-iYWXQdtLJ;.;@6
4<V?&+B+98LPe!c,GU-.(b&Q*Vt]Ajp(T1PAbJNq3@(cR5@4ZQe/C;>AJLFDW4q>[)B!#2d[S
FQ:lZgRII?">o;C!/F!+@&C2O_SptLFc-:Q,ar:YK!aPs3l!smKhU:L;9/&fI^<H7k"<rtuY
!(c<rP1OV3"gDUMERT9K"n=3ENW4F3t$f"d\1UL,uH]AuUd$S8qQ!`oVp-Nkj^>0NnT6*`B]A)
i<[Wp#J^l_UT^dgQUG\j]Al+X$=79S,'4$@g]AH-94#J%J'l4-CrPFH:ldOA4,P64aIiG\,@A.
CKotJkm-LR&"BnlVVsolXZAEu$FT=>n<n[[1qu&Dip"ISp90fT3:-uGADhPZ?E=Qs*Qob!!<
^TqIYZ8./Z`d!0\TORCK!C>:ZN:2r\PO%a&IcRZct6sCn)#WasCg&&jf]AQ_t#Sm@GVq&\CZG
KJ<:6[4n;or#'HWYml&I"R=t\U2g6]Ab@<BT`=eg0QbLrZM_qdpUiFT*C8$JujBJ>0R`HN"2n
[$9C4408L82^XHnR!0\;e$cSAWVBg@s(D%1NbXU<2,ChY9T7#[gL+?AbTkcpuhc)T>=:GQQ5
?s7Qc>BqS=AD2BMg:Mc2"0gSg`X4eGcj1dC&Tm!!qqmE[R&dK;*_.D[:F@A8P;qkua.1GAgg
TdiH3/@&:rbG&Z?s6Q7O*#e0AUh:>3@P0Gal=;.30T0c25b"%/CoA)_,t\n$YrFc`$Mh>/K]A
,,p!IG4']A&)?C\pqM<:)>!r+nD9tO\UM#1CBu.H,QXmT/UfKJ;W;R;-Y$",fYbH8+$f)Tr3-
ThHget_hF/1D<n$6"U!`FII5\8J9d9kFhLVQTH6gdpHN*Jp!q:QG:`Ftr$^PZPMkK0([D.Ze
>VQ7D>e/MOch+!0&N6BMO99rAX/o2N/^*A,NCV1m.!X9_pEAKY"VRSI@R;Jfi9"ee9-eQK;0
<fdig(>qSPk!gtoV.Y"Zl54dbm;Z5>M6$)c2rKWaO,[JQN*W'596/s2=Cme4VcQ$3@2>HK/3
&(V+`f?PgBEN'.3+S^2'e0FQR9[(Ff:XOHE@7)Q9Zn^9oiPTtc8t4(0*"(,8N<t:Kp'P2.Gc
b)A$bPj5T"Fk_oMBrEJ^?L&W94'h&(AFF*BdH70@Kd#Wn6OuVM`X8-M2jbQ:[ZOJ=`gEqFE,
-ctck6E+'IK59F/]AQL:ed9YQ"gL[d$i>YITqNG*?a.ZTJa3a:6+'Cj:.H=e_Ya<VMfrZ<BUg
VncK[OO#ETUnS+H2c#SocBDYraf7D@X=?WmhAO2?*bI8ZFUB?f)KpN(P[;o?T#K-Ff65_H<Z
[jO-ri^q=3TkC,BVSNNS<<i=hF:a^38GLp.@umQIh[r5fB@[`OiHFQ7e;WI)Ns^NfC9k+nkZ
*"GW]A66=]AXe7k1b;MQ?%D5R!=LcUh^V,.'0b&+P"S(q&"R"=%"!iB7V@+0?;oTUZl,Q"'>-F
j4M*u[I`?PEre<h`R,2PD1h+;IPl<BJ[l^:=&$S$##XhO0j\A]AZ.%Xb1G'ko\_>Z3_4kST"<
$GHso30"uh@*Grs-h_D4oP562tDr!t0@p#SXW4=)sg!.R'2PNC>]A1uM2n7K2_'OqMa79T]AlF
l.U^RmtMZ6V6/<9!l01;!]A9lAb/(C_Io\l8Q)#`kmPpZc:oEL`pNuCCj2F@>g$AOh>J2UP[m
r,3`_PecgSuk3F>%L\f,S`fS?&.2n)6VKpuqdhkgs<lYZ)tO-@DXUc87pOp9>`(S8#c:&;if
.EE%e>KNaA$_j]ASs*:R`Fj4Z&?Cl:VaW/fQ0rjFbjn:O\[h0B6!U0_a?6"Kg3nh8h)BuXH7,
/Fe+e$1R?2M,G]A>0p/gHP``]AXN!X3p\oN"Bh1NFI\*/ILP'+?mhNh!l+j<_#e^IAd&:"MO?u
^[]A0tg^LB>6i7o8Hr^k/k5?rLhm@R3g]A8nt5qH_:5mu&2&%K6AB]A8WaI(MSCF?@g(@Z_"uq#
Cm19G9J/*P@@VoP"[esPD&2pHU/Bt><lEe\*0fjhCSWJqu6t_JhLF7dI$[XA]AZ<[!6r9,)5d
tCEI(8:W<k(+bdWW\X"75/9E7'5p(RB!4:jIhf)4V&L-l-@Nf$Q$RGU"oDg75b_%M#nQ):Y'
c<\I2"flKc[s[h#;VQl2't!W-oX99Tq$46BNX,O2Q355INY*JS!o7&`Lq;Ee3ecBY\"3\&b%
+Zd4t?fmGAF]A"#0`*(#cK,KjHa\7UcGQc-FL]AjLt\"=`&:K1i"Aj[A`j"tR?!t.mSuMZ6!BX
tam8u#1=<(!VE^l87t<*kdXTRBlV1aSS[RI?qoU$j_4QL&VK`4Kb2m\#X7\'Q'/gen`7kA$M
N%$&eh#pCLE(O5S$9I^&3HH4Vt48bmX![.?&q>d>n:"K<oWDfq#paCl5NjglgFM<ctS&*lu7
qd-k:WVMU9Wi'dMFS2[GsIYrK`;/AF6WUT!BFcjEsXC]A-M=QiKtT6%;RXKUWtdAe,0bSi/%,
[7OLc@8]A/N-*a59C1,2$4Z%,P`E((C)M$Ci9!JL#5[QdP+O2*\H3TXMP#YNohR0+l&C@IW0^
(MI`hd-X.k1bDfD/=9S+\8>]A17ElRIT,m5p(3K?JfM0i+m)4XWga^6&=cu;R._r1A"@;$,m6
&;pr8lh;4(.:;-tj`'D@L2C77j$=q:>j!"%(0,br(346m2)7XVjlM?+noP)otbIa&sBe8IEI
h!`el@BUh>9Wh/W[Tc*r4r.A.2MKA6)C@/BT6,pYk-5B[TnYMli_a6'&74LEhS-B7F?BG!Ci
kMZZ#gR0S3colYeH>3`"_<dpK_np12tL-3X\Qr*0S@NgXhTl"*[)Esbo#=Um_)?S)uQ!R&,2
M:s\<^ACl/R+aFfI:FV(.>mbu(cdhCj>-X7Ht#+r@8fY\:q;[G4W+2BBPBE?hFJl3@Ul02k4
=c%pnk1-XlcKf=jkYr@W8:JL!C_gE!CaqY*86NV5:*M_I29\B4`D.=-WfTJ):b5hA`S@^@j.
n!Xctb[B8'tVH``&Dl_`=NTT,)3PJ*V.Xr85PgkuaeE)r8O"qAZFaN-R%`n#?e>]AFXlqJW%d
>eC#+;G#!B8S8V0%CM'#B0P#aH#L<PtW!SDa<8@Z<qL!PgOsnn2ZlWIdb-eY=[:NGcn?9k*O
4iT[=<Z#4AC:5db@Mhc;h9n27D@(O[a]ASbh*O$<Huqf+dsRThj9_B]A-gLq^PJf/_NT\moV3f
PUZ_mB7fnlpK\SL,s$/.'n<F4bkhJ6=A_C72T8J6!JLVd8(@3cUbL0cf+EcBaj]A19#1$\dWU
C6,4RE62$bi!+QLfGW;gfdtT@!+]ATX+4YC0*0ldMd4^XDN(e&YoH]A+kKWge./Ag-kg+$3,^n
dCmWG<pb%rS$!_1aO%i1AoVVZH4g6ru+qVjM(8e>4M<dG!G%]A5TZ2_ec?p;2sAtF)$$JJERd
dm3eHfl08^#pP`Gclb,X81V%QQ-uI&oqhoZfW4e[)hX,^"QSpEO,>okkd9)h!QVH\6_oMZ[?
9M[dmplD95f[B:V)2B6;cX]A'nA;Uu$CL\hH1pImM$2D`cW`3&4'M8q$\]A4rrUM`.*4!51[!M
I'U*6?-=<.UhY1LrC>S6cKUc+@S^/?%:Z.lnJAuN;Bggmh+Hj[riGq7\q]A1c6MGqXkbqh^!r
CDq.MAX9IZNsdmSS7$]AL4ig7)Ccm3U?_EK3M-J@(nn\,f2-^*si!AOieS#R_=V4Q$$rcBV$a
W[C*)SAZ+rRJHID7U%p@ZhBr=X;[7A_hH[q-c_E=j%@=8H6sEYOQ=j$g^,8-[^TJ?d6R8Pt6
[``4#D_F7amJ:X:W;<a<fL/_Jtsl9^4X2bjp&j_G`i3U&>TF_KrtC%J29X?L-tb"#rIn6,TC
p"U2Ya&XoH8^K4KV?!rs5`o_AOG@gHc#FGOE.c/4.-R0prcR$0&ZK\h)gikGXak=&9_J=\$s
Ic'VK668ZCKDiI9Nr&'LK6>c#gt<h7Cn_Jt<BZpm+4T]AMp([SuWuuJM$p1)GLgRd;%jD_+9>
-<[3+jGQH5.GgFRABuag/B9@p[V[b;Q*\[a[K`/@A@g3sGi6O;ii$4k;F%Gqob8WZ9&LLVi-
B#'%pg[->]Al$U$G\*h0$sA1<9s7EU2?YT2e_VBFP1W8n'fW7fHqH>E6F305*PphH)+_SjDG]A
rL'*OJ04$-;\sN0FN.PS?Xh;fn%3l`X-Fu]A0L-PVS3K=+N[mZ?/P,$Ea`=*DGfi:Sm4a$S2L
9^d.Xc;G&-"0NR@[cc#G>'%`^EAr&qX>B3B,uJT\aUAJcCM([TLK4GDV6U\O#(E5Ylqb=iZ:
5T"ZP:Ij``E?HeE;Zi(H=O8OZbmA>&M&al`QM(@Y1rE!g"TGSS!haa@&CJDUYVT,;;=rm@Dn
ch6%FtN85TO(C<2gn6q#OUZ/*q:&>7s",WZ+!g_j^6@bZmH,RL+6&B$[X!:aiJ*nQEGo-.cS
&8JK65GHDuhHaDUJlQdEq4<_cY*REPe)I;GpO>).1hdse/co%Xl!0"mY?j9.>WAtT6GUNWOp
&[BJ<)AgO83msCF!*oK%[Z^r:a*pFah32/"]A->r*R;D9Sp?MMZ>%:DS78N!2`<AD7kF#AE'c
iG-lIe.%(;s5O';B(;L"&;gI,L/RbQ\eX;m&`Y61S\\ZI&k"q/NZ(,4eBOL0#X9hmIm,_Ac8
,@#.JO@5*tU)/22*$<o'`rOA8XiH)t-j,dKC0-S*)UtH)#El0F.MLu,1jfqW7O^*nYr\oBZG
YPCJ%Z*6T4Ga"OS+IkaRjg$)kNWTQ39;/o?R:J10IAH0a!cR"`8<7\+kA$(<98EGhGi9GRF*
tNSs.;)W""MSKo/akf-kFDo?gRCd%DO1r.%W))uFP\dJMcfO_V,Gm`X5'"kshBLKksnCb[(]A
S+5kA@LA!^&;ZCs#kE!QA!RO(5]Agj"!8Q3+-/oYk,i=e8R0>_*,V3C4Q*rHBF]A@fT\i,r1$f
gp1PhMeYA('4*/JV7FOTf(DHc1_-Ph7BIO+cXc_AUZn?sW[;C3@o-PfR1)Yo4\N>RE=FOC$M
Na,X3M1N;;9)*dh>fke'P%i'E-K8iCNL2=##uH(4J;J0N:k33,n)!.grs<o@%-1LHb1/#&r8
r\trAO~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="1002" y="124" width="125" height="50"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="执行量"/>
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
<WidgetName name="执行量"/>
<WidgetID widgetID="d2ac673b-358c-4f34-8bb0-33d76d0e13b6"/>
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
<![CDATA[1371600,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3139440,3596640,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[执行量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="1">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="包机执行航段量"/>
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
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9FL1;cgDNDWfT=>,C(>X`aiqetL+JBXGGgq9#++4"7F,d99`$U^B_l<$LlNno6_N<3/\e%B
32:;N2Ho'rk4X6BY)@@RN`j,pJEV$,cfejGSDXEt?R`*Ug[^[a2k8;mGg:5B8Z/YJ'[VfDD_
Y%Xe-($JO"MIe23f8X$$k^ThnBUe1S-0ko&\bCB15rlt<,Zhc%D@QtaFo[UGB%h<]AQauEl0r
!W,,Ed?/+A`U0tl_^OWSkXPah3e2\3nh3FYC1^Hp!WK%Ik#d?K;PJlpMF$B/bPHjTp$OoQ2U
6]Aj-QqhIb1#j/DUNT/5M?UA%BkbN1j'XR%X':.$NG(bKdWRnO)uCX<jb29iF\t77Z51JmE:)
[6pknk2'4amBk_`4CHg,o"TtXcgRY]AVJ!j0<qUdMDuBWlmX4P`5WB.ff2F5LAX);b99&TnOm
)q)i#W8bHr8H`Y-s>?N#@E_)eNNr3>Fi0Qp=d1@\/.);S2O+bM[([Gu_Cb),0F++Pg@T^dp(
H3]AmMb8s.[^VY\5EW7dXQa5VL$8i(O8qu:?>`0;Ij??U?<<'MC]A$!`r@X`WiTAhSaB1KAFr"
(ZT2TDQUkO-B>%hWa6-`ejSNM>8[&H&?$mT\2Eb`GW`pa,^ug?>6F&\p2oc2PnebiZ2`2AGi
?uFniI'RqhtEE.D2n)>*W@(UNa<3n@DnS[k8a]A@hX4a^>MC(Mu4P9O6PH&LBXe$Z:2R.+2X=
KH>80Dl;`RRaMo"4@-%FlIBQ>fI>FDBKu10iXL2Pbre7/A*\MRq((jelWQNKSU;nGX)[X"=L
.LVG4mp6A\0L^DL*1aataQ$iOQWr7CXccg<2tp5=WbOMtoU2dK0T\gE2Y(\058m0`ke?Q=Jd
PFfd5thWO@0O44YO>R\d$hDI#^>qbA6Q.ngk<B.=^+kQYe(:_#nd$%M01l!!UTmq720^kLT$
OR#DdgM(rf"dhNHMW!BPJYY[_sPbEUiUBQbq`C=&+/%]AORj7=?;HNGGY.HMkntOjjOX8+Q!m
?X%'AEJgSPS<n@_]AAlhhmtUh/)IrC:uU2AZ`]ATkE8nd9'8`8["rGJt9FQR"8VeS^Yo]AY/r/a
7I0!rIZ']ACl5eMs'"QSj/ZR]A\aY"r1a3\ltY!m)QMK[EIG]AL27RAOmb;j7-W2!pro/F]A2/%R
4U/;3I05H``-jcF_Fkb8)rYJt"rEWPfgd`epCf_c<9!D1*>I*!drm1r%R$4bdK?=&"`fqOT-
pL3G:\7LjksB!Fg1HXrUIc$(B7T3d`.[FTkTlO#rmi+KPETf<O+#[7%pDdO!6L^^J408l=qd
Cg)oIE:q<9jOR;BFSO-h@l"h[pomGM>#ULbbIQfB0)np+e_8e;g'gqT/lJIYNB4#%6ENQ7bY
5]A/]A[IcM=Lg/p0QD&>S7<N9EcMo.DadVAduRMYa<<c@47*.bET3/_J!Zbla;)Z"jIf[7t)+G
X\(</0PtK(BLIg=f8K'2CL,q#".QpNcJ?<"aRgM-'H2OM+*hPl80SfTQ+f]AoM3#d:fDq?FLI
MT&[oImD"LS]ALQ!Ccr'^FmsOJ(BPdnl_N$3XKccf8JO6;,)aqQ)*nIPZkQbC/s!;<+4B=X2q
s0DKs5(9\J`T-hsi0Y9_KD/CYgX<C2Bmc)qAZF=DVeW48;Po;U'0V$RNn9-U?K9[TRh$<mhD
hEK6Yu)aKVF>74R*n,tp!!mj$hF5'4.2tKPaDm%(+o5;"9j0uQ)"\aJF=b1:[#?*Nr_T@+E1
-\X`^6;*M`itCuIX`n4\,E)[a=_7\d2Z8gY`UJ1]AVX`<jWU),P_eol$G&ptaHm]A+]A3&m[#[/
pW//aUR/K1LZ@$RmG&pD0%1ohJa_C6PgYX;$L_ab6Pjing;lm2:9b'C'&D[m69S=,7FdMA;C
iB6l2UUL;/'NWQDh7<'TZkN&"CFF?a_#;)E%HDm\B.(+)7=cY+nX9cVP/V9(pt5q.?S??)ar
PADjEI'CSXo+1]AWcFMp\G`YNPF"MLW&%;HR7nEpq>Kc,K5)FPuhP"GQCW6GKS8)\KleEBMt;
o9DDi+ZZ?^L9mdnn:(1Ra=3$B6A7d^@N/rnsaP+[k+o[e?peE0*H]AkK-qo0fY2-,h@K1iVPV
f@jU&!`_,/?6jG/<s#?if;%Q`XP2"]Ac$IpnY<UHlc*Up1WO*(ge:CdOK4C.P]AjY7aam/p]AWu
)oYE0mi]A[KKVut#p`*IKpR3'C[mn^8-g:fRE1ef1DKG;q(V40e)#Lo9.;ZsJXCI9ra=1=^".
g=3N>b_h?V6;XFh3lUSO^Y-0^g`c]A(g?fH,Sp.<-`@2[2O,e$:-LJGIdC%?pNU\[`\2.,M]Ab
#hRY*)O2S</FPI`NNs5h-5=Ad[cVmBDW-r3bV-#.;p6A+QS]A_fQY"&+sME2*$r3%<)Y&Ir/S
(QRqR2#s.B?V8"U?aq2VuiZb&897#C0&1nb2@5k9QJp0\`Dm=/F\LiN=rU&XLR=>L`BkQo=D
;Vk>W41-hpZ@o&haZ$EY&C=I1>nRaW$N@BH@G7VQG.>,P*@q7*m-f?MEhEe.';4k`jQdIa^Z
F(ji7HCGT8h!b/X`IDHRm'=WY]A.TOIV=+(;,olQ<;>#e>?]AF1Xp"*nma/dIA>>MOVC%MKV!b
nZL[!8"REiU?^[$ClO)@st%6Z8Q&iEBV9Z]At`8[>k5#oue$4MR:_9/+.uB=b-:$%nkln8gkj
%5k"Fa8EanGqcP+!X*_tFqunskL36X;q^p#=GSgtg_+#&omj_9d%1^l=OnTb>(oi:<Wp:r1#
hcT_@]A3GK2l?fT,%825W(5YVDhGQNA@fZB04G?@d&eMO2(^7d,Z<jfg]Aa5#F7L:_2g,QdHr(
Cr_-1(cbeCmcP.^kuP;C,`"=iHqBO;fEn^`Zs/jgLs=A3R8-;i$_l"/==$\\,-K'kLb>#P(k
J6#ZX-@>V>Q!=!&:`InYp0)Y#GC?KSU&12H'\#&7`V%,-bNFTl?g(`_-tXk/:62<LTn6G0;"
8N,C2T-!,=2hqS:<]ALre\X5lfm$P%Wj&O;538Q*nZO/Ke::=`Fe!WM5<!8fUbMAf4WrkGC>d
5>Er8b;O6C#54T=\J]Ail3#14DY8<H,CJCCE.8bY?J0Sj(0m+VlF2\'U:JZ^.F/4(62boa_ai
!P7Sc_&C_m9=cE6\jC7GTcliL#lX?3NX2C3Vb:'Z(W[n1EN,)ri.u/P<(<-6=Gp14o9Fe@TD
>%.>NCYG?i@DrRH7g(qLp\66n't\MAobYk:J<BJTmkc+3M1hW?H6RCj2\S4?gu8Z5!#cPCNt
424A)N?a/AWH<hO?C`W,KF=Zt!Ar$.be7C^S_Ji+OhqJ8$#B=P)ouR?%"<)T#/,V0l&-h>8+
o"$i0ZBZ>Wh_V.%O\T;`I_t(E*=h8#SuJJ8MhR>i2cV)3'FAe?0QYM5O$^9I=1)r18-6(8[I
\$>r`C?7hq&B:3mPm>&@t!EDHb^Sp&V]A8.D\"WW[]ASh`$Yl1"6r,hfG;h">qkPs(uT'eTaZ^
<%M.e>i<uJ84kHaIo*qbKAI`\T8q3T>pAIoPrLS0<THM/ab.RWXGmp9tG\]ASdH*<0!b4l$P2
h4`Q1N74K?6pKr=UcI:C#f#d/?[(LAdgk'D1#Y)PB6Q\`!9XN"D6qt=)%S$LC6Yrm>RMia_P
c#HZrnL7O=7FK[_7i\>q;#AT\a"gQhm^Dd_bU8dlS:@=;S<=X+1Cc=@'J59SZ4)rIX.nNZoG
GgH%)%@jLj=FH[`11u&]ApuZI+2B#.Tt8e:/DV6P0o_%8PiDh=S#k(SEPV12D$#b8Pn(WP6%)
S7!j)6Y9`r"CVeIf'<TM^cfOVom9/qV7!HON[T),iX_Ma8C"GkPT@Vk?/Y(/4RD7):J(9#0n
=[;_CGfVO"RsUUoB_QEkF&k\05rh1P"4rc$biSEmuJjU;RNE`q)8r>Q&j2h/."-=-f]AVC<oX
0P+Yn9f`j[fH(cZT_/-!4XgGBZJ$r4,r>_jAA*<$Ng,9OUeZ#bD(DgViL@&jjF@d"PV,@%W&
E<HjmM!fBKa;DCX0.e@@WX?^m.N06:XkF[_$n"'es7Fc#b(nacHqnTI*Nb0hp^`&-cZC]AjHd
KV-0/qgZQctKX*(E1)l,[0Q9DWL-"EC4B`i?a%#/`bi%jZ>@'D$DqK^99VqnF"qO<5BW-ha+
brh9f`<^',LEsZsEAH74>IqMn-Tu(WlV'sLJ]A24Y'XstL]Ap`HgCG_VJ[hNF3_%jXqG+@>D6Z
&5P"L4V>f."pUBRaV7AA?4'p"S#Jn]AGa<e^AYqJ;hQ:12P6sB*TOjUHoLhIf@+t``l>Wu(1N
(Amkc_!"*U$dl%&JOHk-kc3!6O`)!;XR"-HQf91BB^MI,bI&;"IR/Y8\Lllob8H:5uW</jo3
!J.l<Wj(EK]AL]AOD._Dhp!d6F%L%,NSS-!XXUk-'c,_D4G_Ln^\SgI,MX$Xkg>HR3op84HC6?
hoXf'XFM^(3!W^C++G%+/A-W/h\;H.[NeBKu`d?FHSuPm(,GGRC)MfcplQiD/'D$sOXU>DQ"
rLo)tUrA%1NPj]AV6Ro=S*K<UKMSi[g/0&o1T>g2dCHFd^XC<:[r(q\Ip#nMFo!AXZ$B4FS9k
^.mBR&"j\-)B^,;/`T<paiX#i^gGcMROj`ErWqu&L>T0#%X(.^qH/5??Ch@4`i<g"^$hdmI+
bUI06M+C)^]Abob/dpcW4[INp&#QC^d*aNi,0jP#Stj4:P^&K39<MNeBl$fsD"<C[+u*'g2($
CpTFJ$3V%B=.X9D+!ZV;Yf6dg)RXCO2<JCq`;F!W&-S5'VE2UlK4112s!^Km5O`.T>[OC&6@
+s^F"ILiG6On^2Yl/`ZK22W9D.E_'.&;GAU=<C]A23OeOMC?pmpZ:o%ZOA]Afbl&(@5eY'(I9@
IlR09)eesWZll`8#e<iL^VH;8ul:O_T#6DB6N[Ljo"_[&-_8u5uHU2h/?uN&r)9l@:@!b5]AS
cm]Ao>a#>f!>`ss:I2)N:WTXE\b4:6>LnCkp:Ybi8B&)/Rd,]A@9T>#.k_5I`10W:^8;@iOI.0
k<JXDaKWroP#o[SH"IJ%smR2mjickq3l%HI_YN2JKh'onX'TPbJU0Dq*[M09F"QtSMq4WlVR
+te7?l-pi2VG70!a2qX?,6\eV4(Vg)`q37=b=&V=&5lRk&rf(:m]A0_/Sb1;<@"mM&Ur+&%WG
I!dgR>>":<kcS(Q/:ZAl-9\!NMm0:pH,^V(iVd*M(Le=q;;N%:A5]Aq%aWL!E>k-A^1.0ddTY
fn#02H3=5/*b,5ED\`P&r;lbf\QA@U(7uW?=B[i$W]AORak:6H1"l+/sYphb[o$CM5/RD!c[?
).P27EkP`P"#s8RD@&MDMW;-^h0('SENRQV:9WI^[^U>7/JteeJuqW;TJ]Au(F%@`r`8Wo0$T
E<N$A/ZCf)aKd$u*G7FFSM5EXh&"PjbHMff3=4iVRi#'ppk37!"r<QmG)&G)FR7!H_jhi0b*
<=N/NU-77d+pVOLVJZJi8QfnGm]ArB__G)-fh`E1eoE)_hOOUdrdWH>`>b4<G\_^pK"B94Q;W
Bkc$T+lDU?CtHeWfNQ@fa4355pZ0Hp`,!2rbo#^kgZAY$m&`[l3W"l)s$t5*bNV_i>78*'HS
d\!W_U/%jfc*2E4ON9I*qiI5/Z)_?)M9K7fF"5'KbKVk%A4qe3%`+%(jPbI\#U8\U?4d=mJ&
PQOABNT,&LeAKSXn.(Hp;jEq+qr?!fgBD$:q$]A=S_mA>BPPmIT(]A]A3r(7]AlD722cCmK?pj4+
@%2O,*tV`i;5X.UXn96%A%_mdnp^?GrRBfrB5/ciSi;PU#@a^Kb[`4<]AXeO1bUct+ub$$f6m
;:`%jj9#n6TrI"_VF7:F[KdkF_P1@A2s&pLYI+8Jn!lW:pci*;'ufUqS9oS3)iEa6C-+59f$
[0=b-CrpN@T$>Fj\(KSaQ"1-+r1.-0rK;F+VuEFi?b1iaR<o94d-60l<[Q>OadS4B]ApV4D3L
'2Kd!;_Ta.M),P+N$a8[!D44BZH;?u?b'mVh!Y&q=WAX*pIUm'Jq2_P5f8YYU%<^;Z"(5;6U
Ab#qq0Aie32k9@CutAm9i7d?=b$IM7NCs`D+'/dSb@"e+)umUbHP@:ou1c45JMUhF`\\oI$J
VucJAbK/.t?Ppb:PO!6f!OEhg:/"t>-V_W_u%/gc8pe@AoF<?%TILE3skBQ##"'eVF;.lj=(
Z.#2=7T5:NScjXU/*X^51=!]Aj!M6QI-_,rT"^m3imcm'q<k_QU*hdt8#\?A6p&[Ppp?0i&"^
a72hD6;$Ue192LI'TreoZcA)1_[n_3bLE(]AuMUaT'ba:,`ssR1`t8/BgAWN0.?eo]AI5%*bKI
IFd7`27*N`mTRj^qHq/go5.<NcmC>)?"c)=Qa>opg3qU#.O^_-9R;oG#!JL#',+Mn,)#>++,
sflHM]AebcIc\-=A2/Z?pE-DK+Ok8lTb9*R$Ui(k$N^iqf-rRl2jT[<N%4?28.hX?qM'%@f#^
>BH)dO4_&3oNo/!9alhs\@#K-=3V=f9_S&9U[9*8ld`_7oOV.PAao8#2feMc6R(N?TQ"!oe3
^&p37,pCKSBW2P?$ms\Zj<Lqpg^MP9-,I,-jniPG,sV(oh<csJ`((dEMaVcO9,$c%!^6Ggd9
4IQjNl#JFBsVpn%RU2;7]A'`4'Y)&EHZ:q(iUbS+uPt%Nsr_P.LNO1`1n7O3"f<\`-PatcN)(
i^lh7@+U>mt:MM/&C`?aupu1]AW)Eh=2(oQE,(C6F:R#-^95H,h,>VfNn$Ki+=.Zlif0V>Yj`
M/_8(XN/$_7+cpCLcUV@]AU&D79jI80&FNs\m^-T<k*@*0]AQ@MM1#FB1u>!CL0fFV]AG.F?Xh-
8#jj'[I--f[[=m^H`T'mo1CHD:f(oC4((9u!m)0+]A5<53?0!+#=t#sbaVK*el7P`Zdp]A#2E>
Cgf+J#GGNi1cA_`e'o)),',7=.p;@R:o`^:Tt2'PD<`%NiGl$A-5>2O'jD?]AYu-j0OV>#jUH
j$RJh_#pN!TA@#YSM]A[0HKUP.3B&&;=VZ"&O.V+ESUsf_iM'@tMu:AmE)CL@$#E,Vq_1`$?P
9b3OR'nh^J<UR72YpU2[XQlL)DD6nRq#*uqthc@kSKJ?Ra`gUT!3pD%"gI_S<JTIU2i/ZE/5
3'4'>@mp4P89<&9cbOI53U>=nbf?%Uo\,[\I10i%[HdEnS^gN;^["'T9&X//@g5$PoC,:f>D
@Z:O)?'iJfqK0Y&)F9[($kmVp<C51cE%8GWmD`$g<_:cUdD+QBuKja_jfb'&:JOYXlWIXnHL
8;%#Hk3(+GT?-XHT\b/[U^5hc>m9@.,JB+cBCX(1,D?)eLlb>!o7R4;UH^R:ilA3>Q*gl.%-
BZ5T=Ca]AN3KO3'2?ZBFjlMNLG+5mHjEoWo?1f^ijZYi.nRQ5*X!Wp_k9I_$!q>d8C,?(q8=.
rdR]AQ)eEmdV8E\[O1E)o[>A\.+Iu_"dhHpF!TWDd^RHS!1'OZ(3UP1a@L1(_o'E@odV%p2Is
-N`e~
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
<WidgetName name="计划量"/>
<WidgetID widgetID="d2ac673b-358c-4f34-8bb0-33d76d0e13b6"/>
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
<![CDATA[1371600,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3139440,3596640,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[计划量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="1">
<O t="DSColumn">
<Attributes dsName="06出勤率-同环比" columnName="计划航班量"/>
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
<FRFont name="微软雅黑" style="1" size="64" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
<FRFont name="微软雅黑" style="0" size="72" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9C*F;t[iDbMBah6$54cBG2,e#+8LkKXPU#%CiZO,6l/t%Vau>6*2uNkuX<,*Ks/(a[dXVgE
pCFW!jja#c7>nC)]AKV!Ybq=8o0\J%;D7XBtenVS9q9j*U^2qhrj-B'du1?iAp)j5Q?f%qg75
ppIfc&g"#0:5FM80))GmKc?j0BRMdo1J=A9'k3mck6fcCeSb(YnB!?r6.t7Hob51)2`PUfMh
KlC*lK<ZOr;<;p)NGm=_5$Jd3P*o%=hJ;mNi_%W3qp]A'olmM4\)[1eA\Z@?;uFP>Xp=CPN;V
D8_EV]A@O2Ql^^:3OhlF15sHX99FT3]AHn6sT[/-U/*W:X6/Q'dYunK]Ant.Kks97eU,#E5BFAV
Vf?mtr9U8V77._)!r!!.cGC/*$l.Ib9mt!DHDZ#Adso..02Jp'8iF>UVj/*I"'<6S/EF\-1u
)=EfoW&60)1aE',U;q--oYiiLFVM_JctHE<4NT/*TiU,"F=HfKi:m!kmXV7;9825mnF!Q\P+
_fo/D`<dq2J9\h]A!&iFcnA_J@9FgDp?bDM#b#2V1_h8_XD5C*hEp6t`_8a5g8`TXSE7W3h``
Xl,OUFFK#;*2YXUG'.sdW+M2KeuV6Imd\ceL]A10R5_'ZNT=8F?:"P1<!oQ5U<o1pAd7hHeLG
<dVWb#+Pu)CJ[Q"%3ml9n1#%$2#aHIh_2l?U!*TsNUW0\6E>"A2;0$\GAr3NC59TJkODm+/A
VUSMj_aH-3K2%=TD$Jb>3Ng-6^,E&cRElpd+0.7+`=;392@SXak,4*-E5fQS*-dgJVs!i3\L
hV.Z68p/cddT<#E''I$Si[<=!qU2o`PdI+g\@lNaF`>>&URHd?IcDBhHPp_ojGs?d<WMRmq)
jDOm",ndh8ea+3a*"c)$$r)jL#O_K*6[#pEdaH.t@aREWA_1E)E1apV']AUuT?+=XV,%UErH$
7E/GFHR:FL-5&r@V;?2LEYh(^C;q&E[)p:Zrsu:SP;UiNER\smq-HKE2fN]Ad?d7V_j@sis&$
SaB(?pXP]A,D^6-c6'Lq/ataNVXJ+h'<b;j\[`oPgK#I+(sC8a"$cFs)S:;;d%;>WR6lDum;]A
qbcClWPYZVq:Rcmnrp?-rHMAdYPiot<r8bWOPK96qZmLK(J?`kL`!H(?)sL+I,-NfVVJJnSQ
fuoCJ'FhKl0VaG.:[dq>)L7W7o>6hkFGH-I/b,22!417g2Ag<kmPU[<9+9p/OGQ1J^?EP07.
ueMbT0@*!Mj*K'5QaC<h[YHATkUHD!WMOD>lqJV&Z`"SYbLF9s9iN):=IXKW.15[e:5ODZ@<
&@"q.CYqSiNo&>`NKbGJpj%Xm*1-73k2^N&p*@OLDIAT=0VSf+'iRrk[h/\]ADY<tM'#a5^/5
O`1Wa$9(Rt]Auk^Y]AA!T#R,_`\+s/2,.]AL#VBt&\Mm^'9&MSb'4O#jrnK41%gei>"Rl;a^AZq
`L):h'CS.+bf.Dn4Y9\C0fPE.9S^gn*?f%\(\&`,!Z`9Imq;,'%Q>F%O6Uj56Hh`$RUF!B/n
T5H5;&#n9rHaJI!2<HT?uep!(iXC<V#1TXXoBiUlsJ,$Keh[]A8?-lk/Xf%GBrT&i_]AroJoE1
ud8W9XIT^Qtc*XsX1^fO/B2EK\]A\puddWe"jS1u)'7u,mQ%&V:674Hr!r73\bEW.%<Mo7BuR
p2k00(E@ZDD*pVUE.$Y6X]A$K*O$W[]A4Y%k=qf/![._lE$FG5iderMBDe74>8LAc&.6(ItU@0
HK'\YC6'(2l=Z.-o=T"R/DDHFFCOn>Z>rn.]A!n`eLt4KF[!r6qd=-psJdU"A_/8pd$XX8K]A>
eQrA_T"Hi[/:Y</8@Jd>%(KilGU.Vucf!;&lqqir'f(p\<_q!^Qf;PnU6IHE'!H%tFC;&a=8
HKfGA6^J!.Q\inXqMW\\sNfUTscm[/t,NjM<2Z#fW4ML!efec<)ZhUiA\b.b)g-mDcK,nV<7
_E&..X@W!b%T:&lh?6iP5/nDrVSOs[\c5<aOmD6-KO"0C3f9]Ap,N,RG=4(mF,iK=r1B`:9,.
2Gl;FQ!\WGK3NII)uXX)Uus)?e2WcGl4Yl)qio>Y4/b;c<m%]AGS]AbL3oTAa6NMpu<#g$:;KY
foH&"aEF261u_<NX?Z,0GE7T+E<V*kq`BLSW0baqac%YQ`(e^0mk_\1)YZ\1B;h!,m!ZQ'KT
H=#0,iUM/$Ac0TN(W_=2D_C]A_@Q;:m%YK@R(`S99kh63d^meul<(]A@5B]AK9+4co4PR=(,_2m
'qh!p@5?cC\-'TbDOVa$&;DZ-k;"MM"Q,ZCtRoOGm3$G71Qoi1niZ^;pA]A_+]A6l8`H3Re3EG
s<E)G[[\qh?.hKq?a`?8#nJ=VMX`-suG`Gbob;.2sd#Jo/Q>=hg+u_DX7>^!kPc!=:_$jR\C
7Qe*gZm'?e-So(jblpWm235.eP81Q%:iia=^.]A?_rGn*7B_!i&iF+5P1[-0-t^4Q8Nu>iP7Z
1)#fSZ&>A+fbApn;)GS^TurlW!A9'QS#]A@th^FT3WH<N[dE$,qIFjbn%($9["W6<@\1oX>rG
ll<.GJtB(bkXiO@59A5Y&>J'*RQsFibQ<>J*j*[X3F[t<Z)O_6`"Kr-nR-iYWXQdtLJ;.;@6
4<V?&+B+98LPe!c,GU-.(b&Q*Vt]Ajp(T1PAbJNq3@(cR5@4ZQe/C;>AJLFDW4q>[)B!#2d[S
FQ:lZgRII?">o;C!/F!+@&C2O_SptLFc-:Q,ar:YK!aPs3l!smKhU:L;9/&fI^<H7k"<rtuY
!(c<rP1OV3"gDUMERT9K"n=3ENW4F3t$f"d\1UL,uH]AuUd$S8qQ!`oVp-Nkj^>0NnT6*`B]A)
i<[Wp#J^l_UT^dgQUG\j]Al+X$=79S,'4$@g]AH-94#J%J'l4-CrPFH:ldOA4,P64aIiG\,@A.
CKotJkm-LR&"BnlVVsolXZAEu$FT=>n<n[[1qu&Dip"ISp90fT3:-uGADhPZ?E=Qs*Qob!!<
^TqIYZ8./Z`d!0\TORCK!C>:ZN:2r\PO%a&IcRZct6sCn)#WasCg&&jf]AQ_t#Sm@GVq&\CZG
KJ<:6[4n;or#'HWYml&I"R=t\U2g6]Ab@<BT`=eg0QbLrZM_qdpUiFT*C8$JujBJ>0R`HN"2n
[$9C4408L82^XHnR!0\;e$cSAWVBg@s(D%1NbXU<2,ChY9T7#[gL+?AbTkcpuhc)T>=:GQQ5
?s7Qc>BqS=AD2BMg:Mc2"0gSg`X4eGcj1dC&Tm!!qqmE[R&dK;*_.D[:F@A8P;qkua.1GAgg
TdiH3/@&:rbG&Z?s6Q7O*#e0AUh:>3@P0Gal=;.30T0c25b"%/CoA)_,t\n$YrFc`$Mh>/K]A
,,p!IG4']A&)?C\pqM<:)>!r+nD9tO\UM#1CBu.H,QXmT/UfKJ;W;R;-Y$",fYbH8+$f)Tr3-
ThHget_hF/1D<n$6"U!`FII5\8J9d9kFhLVQTH6gdpHN*Jp!q:QG:`Ftr$^PZPMkK0([D.Ze
>VQ7D>e/MOch+!0&N6BMO99rAX/o2N/^*A,NCV1m.!X9_pEAKY"VRSI@R;Jfi9"ee9-eQK;0
<fdig(>qSPk!gtoV.Y"Zl54dbm;Z5>M6$)c2rKWaO,[JQN*W'596/s2=Cme4VcQ$3@2>HK/3
&(V+`f?PgBEN'.3+S^2'e0FQR9[(Ff:XOHE@7)Q9Zn^9oiPTtc8t4(0*"(,8N<t:Kp'P2.Gc
b)A$bPj5T"Fk_oMBrEJ^?L&W94'h&(AFF*BdH70@Kd#Wn6OuVM`X8-M2jbQ:[ZOJ=`gEqFE,
-ctck6E+'IK59F/]AQL:ed9YQ"gL[d$i>YITqNG*?a.ZTJa3a:6+'Cj:.H=e_Ya<VMfrZ<BUg
VncK[OO#ETUnS+H2c#SocBDYraf7D@X=?WmhAO2?*bI8ZFUB?f)KpN(P[;o?T#K-Ff65_H<Z
[jO-ri^q=3TkC,BVSNNS<<i=hF:a^38GLp.@umQIh[r5fB@[`OiHFQ7e;WI)Ns^NfC9k+nkZ
*"GW]A66=]AXe7k1b;MQ?%D5R!=LcUh^V,.'0b&+P"S(q&"R"=%"!iB7V@+0?;oTUZl,Q"'>-F
j4M*u[I`?PEre<h`R,2PD1h+;IPl<BJ[l^:=&$S$##XhO0j\A]AZ.%Xb1G'ko\_>Z3_4kST"<
$GHso30"uh@*Grs-h_D4oP562tDr!t0@p#SXW4=)sg!.R'2PNC>]A1uM2n7K2_'OqMa79T]AlF
l.U^RmtMZ6V6/<9!l01;!]A9lAb/(C_Io\l8Q)#`kmPpZc:oEL`pNuCCj2F@>g$AOh>J2UP[m
r,3`_PecgSuk3F>%L\f,S`fS?&.2n)6VKpuqdhkgs<lYZ)tO-@DXUc87pOp9>`(S8#c:&;if
.EE%e>KNaA$_j]ASs*:R`Fj4Z&?Cl:VaW/fQ0rjFbjn:O\[h0B6!U0_a?6"Kg3nh8h)BuXH7,
/Fe+e$1R?2M,G]A>0p/gHP``]AXN!X3p\oN"Bh1NFI\*/ILP'+?mhNh!l+j<_#e^IAd&:"MO?u
^[]A0tg^LB>6i7o8Hr^k/k5?rLhm@R3g]A8nt5qH_:5mu&2&%K6AB]A8WaI(MSCF?@g(@Z_"uq#
Cm19G9J/*P@@VoP"[esPD&2pHU/Bt><lEe\*0fjhCSWJqu6t_JhLF7dI$[XA]AZ<[!6r9,)5d
tCEI(8:W<k(+bdWW\X"75/9E7'5p(RB!4:jIhf)4V&L-l-@Nf$Q$RGU"oDg75b_%M#nQ):Y'
c<\I2"flKc[s[h#;VQl2't!W-oX99Tq$46BNX,O2Q355INY*JS!o7&`Lq;Ee3ecBY\"3\&b%
+Zd4t?fmGAF]A"#0`*(#cK,KjHa\7UcGQc-FL]AjLt\"=`&:K1i"Aj[A`j"tR?!t.mSuMZ6!BX
tam8u#1=<(!VE^l87t<*kdXTRBlV1aSS[RI?qoU$j_4QL&VK`4Kb2m\#X7\'Q'/gen`7kA$M
N%$&eh#pCLE(O5S$9I^&3HH4Vt48bmX![.?&q>d>n:"K<oWDfq#paCl5NjglgFM<ctS&*lu7
qd-k:WVMU9Wi'dMFS2[GsIYrK`;/AF6WUT!BFcjEsXC]A-M=QiKtT6%;RXKUWtdAe,0bSi/%,
[7OLc@8]A/N-*a59C1,2$4Z%,P`E((C)M$Ci9!JL#5[QdP+O2*\H3TXMP#YNohR0+l&C@IW0^
(MI`hd-X.k1bDfD/=9S+\8>]A17ElRIT,m5p(3K?JfM0i+m)4XWga^6&=cu;R._r1A"@;$,m6
&;pr8lh;4(.:;-tj`'D@L2C77j$=q:>j!"%(0,br(346m2)7XVjlM?+noP)otbIa&sBe8IEI
h!`el@BUh>9Wh/W[Tc*r4r.A.2MKA6)C@/BT6,pYk-5B[TnYMli_a6'&74LEhS-B7F?BG!Ci
kMZZ#gR0S3colYeH>3`"_<dpK_np12tL-3X\Qr*0S@NgXhTl"*[)Esbo#=Um_)?S)uQ!R&,2
M:s\<^ACl/R+aFfI:FV(.>mbu(cdhCj>-X7Ht#+r@8fY\:q;[G4W+2BBPBE?hFJl3@Ul02k4
=c%pnk1-XlcKf=jkYr@W8:JL!C_gE!CaqY*86NV5:*M_I29\B4`D.=-WfTJ):b5hA`S@^@j.
n!Xctb[B8'tVH``&Dl_`=NTT,)3PJ*V.Xr85PgkuaeE)r8O"qAZFaN-R%`n#?e>]AFXlqJW%d
>eC#+;G#!B8S8V0%CM'#B0P#aH#L<PtW!SDa<8@Z<qL!PgOsnn2ZlWIdb-eY=[:NGcn?9k*O
4iT[=<Z#4AC:5db@Mhc;h9n27D@(O[a]ASbh*O$<Huqf+dsRThj9_B]A-gLq^PJf/_NT\moV3f
PUZ_mB7fnlpK\SL,s$/.'n<F4bkhJ6=A_C72T8J6!JLVd8(@3cUbL0cf+EcBaj]A19#1$\dWU
C6,4RE62$bi!+QLfGW;gfdtT@!+]ATX+4YC0*0ldMd4^XDN(e&YoH]A+kKWge./Ag-kg+$3,^n
dCmWG<pb%rS$!_1aO%i1AoVVZH4g6ru+qVjM(8e>4M<dG!G%]A5TZ2_ec?p;2sAtF)$$JJERd
dm3eHfl08^#pP`Gclb,X81V%QQ-uI&oqhoZfW4e[)hX,^"QSpEO,>okkd9)h!QVH\6_oMZ[?
9M[dmplD95f[B:V)2B6;cX]A'nA;Uu$CL\hH1pImM$2D`cW`3&4'M8q$\]A4rrUM`.*4!51[!M
I'U*6?-=<.UhY1LrC>S6cKUc+@S^/?%:Z.lnJAuN;Bggmh+Hj[riGq7\q]A1c6MGqXkbqh^!r
CDq.MAX9IZNsdmSS7$]AL4ig7)Ccm3U?_EK3M-J@(nn\,f2-^*si!AOieS#R_=V4Q$$rcBV$a
W[C*)SAZ+rRJHID7U%p@ZhBr=X;[7A_hH[q-c_E=j%@=8H6sEYOQ=j$g^,8-[^TJ?d6R8Pt6
[``4#D_F7amJ:X:W;<a<fL/_Jtsl9^4X2bjp&j_G`i3U&>TF_KrtC%J29X?L-tb"#rIn6,TC
p"U2Ya&XoH8^K4KV?!rs5`o_AOG@gHc#FGOE.c/4.-R0prcR$0&ZK\h)gikGXak=&9_J=\$s
Ic'VK668ZCKDiI9Nr&'LK6>c#gt<h7Cn_Jt<BZpm+4T]AMp([SuWuuJM$p1)GLgRd;%jD_+9>
-<[3+jGQH5.GgFRABuag/B9@p[V[b;Q*\[a[K`/@A@g3sGi6O;ii$4k;F%Gqob8WZ9&LLVi-
B#'%pg[->]Al$U$G\*h0$sA1<9s7EU2?YT2e_VBFP1W8n'fW7fHqH>E6F305*PphH)+_SjDG]A
rL'*OJ04$-;\sN0FN.PS?Xh;fn%3l`X-Fu]A0L-PVS3K=+N[mZ?/P,$Ea`=*DGfi:Sm4a$S2L
9^d.Xc;G&-"0NR@[cc#G>'%`^EAr&qX>B3B,uJT\aUAJcCM([TLK4GDV6U\O#(E5Ylqb=iZ:
5T"ZP:Ij``E?HeE;Zi(H=O8OZbmA>&M&al`QM(@Y1rE!g"TGSS!haa@&CJDUYVT,;;=rm@Dn
ch6%FtN85TO(C<2gn6q#OUZ/*q:&>7s",WZ+!g_j^6@bZmH,RL+6&B$[X!:aiJ*nQEGo-.cS
&8JK65GHDuhHaDUJlQdEq4<_cY*REPe)I;GpO>).1hdse/co%Xl!0"mY?j9.>WAtT6GUNWOp
&[BJ<)AgO83msCF!*oK%[Z^r:a*pFah32/"]A->r*R;D9Sp?MMZ>%:DS78N!2`<AD7kF#AE'c
iG-lIe.%(;s5O';B(;L"&;gI,L/RbQ\eX;m&`Y61S\\ZI&k"q/NZ(,4eBOL0#X9hmIm,_Ac8
,@#.JO@5*tU)/22*$<o'`rOA8XiH)t-j,dKC0-S*)UtH)#El0F.MLu,1jfqW7O^*nYr\oBZG
YPCJ%Z*6T4Ga"OS+IkaRjg$)kNWTQ39;/o?R:J10IAH0a!cR"`8<7\+kA$(<98EGhGi9GRF*
tNSs.;)W""MSKo/akf-kFDo?gRCd%DO1r.%W))uFP\dJMcfO_V,Gm`X5'"kshBLKksnCb[(]A
S+5kA@LA!^&;ZCs#kE!QA!RO(5]Agj"!8Q3+-/oYk,i=e8R0>_*,V3C4Q*rHBF]A@fT\i,r1$f
gp1PhMeYA('4*/JV7FOTf(DHc1_-Ph7BIO+cXc_AUZn?sW[;C3@o-PfR1)Yo4\N>RE=FOC$M
Na,X3M1N;;9)*dh>fke'P%i'E-K8iCNL2=##uH(4J;J0N:k33,n)!.grs<o@%-1LHb1/#&r8
r\trAO~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="1002" y="88" width="125" height="50"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="计划量"/>
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
<WidgetName name="计划量"/>
<WidgetID widgetID="d2ac673b-358c-4f34-8bb0-33d76d0e13b6"/>
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
<![CDATA[1371600,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3139440,3596640,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[计划量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="1">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="包机计划航班量"/>
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
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9FL1;cgDNDWfT=>,C(>X`aiqetL+JBXGGgq9#++4"7F,d99`$U^B_l<$LlNno6_N<3/\e%B
32:;N2Ho'rk4X6BY)@@RN`j,pJEV$,cfejGSDXEt?R`*Ug[^[a2k8;mGg:5B8Z/YJ'[VfDD_
Y%Xe-($JO"MIe23f8X$$k^ThnBUe1S-0ko&\bCB15rlt<,Zhc%D@QtaFo[UGB%h<]AQauEl0r
!W,,Ed?/+A`U0tl_^OWSkXPah3e2\3nh3FYC1^Hp!WK%Ik#d?K;PJlpMF$B/bPHjTp$OoQ2U
6]Aj-QqhIb1#j/DUNT/5M?UA%BkbN1j'XR%X':.$NG(bKdWRnO)uCX<jb29iF\t77Z51JmE:)
[6pknk2'4amBk_`4CHg,o"TtXcgRY]AVJ!j0<qUdMDuBWlmX4P`5WB.ff2F5LAX);b99&TnOm
)q)i#W8bHr8H`Y-s>?N#@E_)eNNr3>Fi0Qp=d1@\/.);S2O+bM[([Gu_Cb),0F++Pg@T^dp(
H3]AmMb8s.[^VY\5EW7dXQa5VL$8i(O8qu:?>`0;Ij??U?<<'MC]A$!`r@X`WiTAhSaB1KAFr"
(ZT2TDQUkO-B>%hWa6-`ejSNM>8[&H&?$mT\2Eb`GW`pa,^ug?>6F&\p2oc2PnebiZ2`2AGi
?uFniI'RqhtEE.D2n)>*W@(UNa<3n@DnS[k8a]A@hX4a^>MC(Mu4P9O6PH&LBXe$Z:2R.+2X=
KH>80Dl;`RRaMo"4@-%FlIBQ>fI>FDBKu10iXL2Pbre7/A*\MRq((jelWQNKSU;nGX)[X"=L
.LVG4mp6A\0L^DL*1aataQ$iOQWr7CXccg<2tp5=WbOMtoU2dK0T\gE2Y(\058m0`ke?Q=Jd
PFfd5thWO@0O44YO>R\d$hDI#^>qbA6Q.ngk<B.=^+kQYe(:_#nd$%M01l!!UTmq720^kLT$
OR#DdgM(rf"dhNHMW!BPJYY[_sPbEUiUBQbq`C=&+/%]AORj7=?;HNGGY.HMkntOjjOX8+Q!m
?X%'AEJgSPS<n@_]AAlhhmtUh/)IrC:uU2AZ`]ATkE8nd9'8`8["rGJt9FQR"8VeS^Yo]AY/r/a
7I0!rIZ']ACl5eMs'"QSj/ZR]A\aY"r1a3\ltY!m)QMK[EIG]AL27RAOmb;j7-W2!pro/F]A2/%R
4U/;3I05H``-jcF_Fkb8)rYJt"rEWPfgd`epCf_c<9!D1*>I*!drm1r%R$4bdK?=&"`fqOT-
pL3G:\7LjksB!Fg1HXrUIc$(B7T3d`.[FTkTlO#rmi+KPETf<O+#[7%pDdO!6L^^J408l=qd
Cg)oIE:q<9jOR;BFSO-h@l"h[pomGM>#ULbbIQfB0)np+e_8e;g'gqT/lJIYNB4#%6ENQ7bY
5]A/]A[IcM=Lg/p0QD&>S7<N9EcMo.DadVAduRMYa<<c@47*.bET3/_J!Zbla;)Z"jIf[7t)+G
X\(</0PtK(BLIg=f8K'2CL,q#".QpNcJ?<"aRgM-'H2OM+*hPl80SfTQ+f]AoM3#d:fDq?FLI
MT&[oImD"LS]ALQ!Ccr'^FmsOJ(BPdnl_N$3XKccf8JO6;,)aqQ)*nIPZkQbC/s!;<+4B=X2q
s0DKs5(9\J`T-hsi0Y9_KD/CYgX<C2Bmc)qAZF=DVeW48;Po;U'0V$RNn9-U?K9[TRh$<mhD
hEK6Yu)aKVF>74R*n,tp!!mj$hF5'4.2tKPaDm%(+o5;"9j0uQ)"\aJF=b1:[#?*Nr_T@+E1
-\X`^6;*M`itCuIX`n4\,E)[a=_7\d2Z8gY`UJ1]AVX`<jWU),P_eol$G&ptaHm]A+]A3&m[#[/
pW//aUR/K1LZ@$RmG&pD0%1ohJa_C6PgYX;$L_ab6Pjing;lm2:9b'C'&D[m69S=,7FdMA;C
iB6l2UUL;/'NWQDh7<'TZkN&"CFF?a_#;)E%HDm\B.(+)7=cY+nX9cVP/V9(pt5q.?S??)ar
PADjEI'CSXo+1]AWcFMp\G`YNPF"MLW&%;HR7nEpq>Kc,K5)FPuhP"GQCW6GKS8)\KleEBMt;
o9DDi+ZZ?^L9mdnn:(1Ra=3$B6A7d^@N/rnsaP+[k+o[e?peE0*H]AkK-qo0fY2-,h@K1iVPV
f@jU&!`_,/?6jG/<s#?if;%Q`XP2"]Ac$IpnY<UHlc*Up1WO*(ge:CdOK4C.P]AjY7aam/p]AWu
)oYE0mi]A[KKVut#p`*IKpR3'C[mn^8-g:fRE1ef1DKG;q(V40e)#Lo9.;ZsJXCI9ra=1=^".
g=3N>b_h?V6;XFh3lUSO^Y-0^g`c]A(g?fH,Sp.<-`@2[2O,e$:-LJGIdC%?pNU\[`\2.,M]Ab
#hRY*)O2S</FPI`NNs5h-5=Ad[cVmBDW-r3bV-#.;p6A+QS]A_fQY"&+sME2*$r3%<)Y&Ir/S
(QRqR2#s.B?V8"U?aq2VuiZb&897#C0&1nb2@5k9QJp0\`Dm=/F\LiN=rU&XLR=>L`BkQo=D
;Vk>W41-hpZ@o&haZ$EY&C=I1>nRaW$N@BH@G7VQG.>,P*@q7*m-f?MEhEe.';4k`jQdIa^Z
F(ji7HCGT8h!b/X`IDHRm'=WY]A.TOIV=+(;,olQ<;>#e>?]AF1Xp"*nma/dIA>>MOVC%MKV!b
nZL[!8"REiU?^[$ClO)@st%6Z8Q&iEBV9Z]At`8[>k5#oue$4MR:_9/+.uB=b-:$%nkln8gkj
%5k"Fa8EanGqcP+!X*_tFqunskL36X;q^p#=GSgtg_+#&omj_9d%1^l=OnTb>(oi:<Wp:r1#
hcT_@]A3GK2l?fT,%825W(5YVDhGQNA@fZB04G?@d&eMO2(^7d,Z<jfg]Aa5#F7L:_2g,QdHr(
Cr_-1(cbeCmcP.^kuP;C,`"=iHqBO;fEn^`Zs/jgLs=A3R8-;i$_l"/==$\\,-K'kLb>#P(k
J6#ZX-@>V>Q!=!&:`InYp0)Y#GC?KSU&12H'\#&7`V%,-bNFTl?g(`_-tXk/:62<LTn6G0;"
8N,C2T-!,=2hqS:<]ALre\X5lfm$P%Wj&O;538Q*nZO/Ke::=`Fe!WM5<!8fUbMAf4WrkGC>d
5>Er8b;O6C#54T=\J]Ail3#14DY8<H,CJCCE.8bY?J0Sj(0m+VlF2\'U:JZ^.F/4(62boa_ai
!P7Sc_&C_m9=cE6\jC7GTcliL#lX?3NX2C3Vb:'Z(W[n1EN,)ri.u/P<(<-6=Gp14o9Fe@TD
>%.>NCYG?i@DrRH7g(qLp\66n't\MAobYk:J<BJTmkc+3M1hW?H6RCj2\S4?gu8Z5!#cPCNt
424A)N?a/AWH<hO?C`W,KF=Zt!Ar$.be7C^S_Ji+OhqJ8$#B=P)ouR?%"<)T#/,V0l&-h>8+
o"$i0ZBZ>Wh_V.%O\T;`I_t(E*=h8#SuJJ8MhR>i2cV)3'FAe?0QYM5O$^9I=1)r18-6(8[I
\$>r`C?7hq&B:3mPm>&@t!EDHb^Sp&V]A8.D\"WW[]ASh`$Yl1"6r,hfG;h">qkPs(uT'eTaZ^
<%M.e>i<uJ84kHaIo*qbKAI`\T8q3T>pAIoPrLS0<THM/ab.RWXGmp9tG\]ASdH*<0!b4l$P2
h4`Q1N74K?6pKr=UcI:C#f#d/?[(LAdgk'D1#Y)PB6Q\`!9XN"D6qt=)%S$LC6Yrm>RMia_P
c#HZrnL7O=7FK[_7i\>q;#AT\a"gQhm^Dd_bU8dlS:@=;S<=X+1Cc=@'J59SZ4)rIX.nNZoG
GgH%)%@jLj=FH[`11u&]ApuZI+2B#.Tt8e:/DV6P0o_%8PiDh=S#k(SEPV12D$#b8Pn(WP6%)
S7!j)6Y9`r"CVeIf'<TM^cfOVom9/qV7!HON[T),iX_Ma8C"GkPT@Vk?/Y(/4RD7):J(9#0n
=[;_CGfVO"RsUUoB_QEkF&k\05rh1P"4rc$biSEmuJjU;RNE`q)8r>Q&j2h/."-=-f]AVC<oX
0P+Yn9f`j[fH(cZT_/-!4XgGBZJ$r4,r>_jAA*<$Ng,9OUeZ#bD(DgViL@&jjF@d"PV,@%W&
E<HjmM!fBKa;DCX0.e@@WX?^m.N06:XkF[_$n"'es7Fc#b(nacHqnTI*Nb0hp^`&-cZC]AjHd
KV-0/qgZQctKX*(E1)l,[0Q9DWL-"EC4B`i?a%#/`bi%jZ>@'D$DqK^99VqnF"qO<5BW-ha+
brh9f`<^',LEsZsEAH74>IqMn-Tu(WlV'sLJ]A24Y'XstL]Ap`HgCG_VJ[hNF3_%jXqG+@>D6Z
&5P"L4V>f."pUBRaV7AA?4'p"S#Jn]AGa<e^AYqJ;hQ:12P6sB*TOjUHoLhIf@+t``l>Wu(1N
(Amkc_!"*U$dl%&JOHk-kc3!6O`)!;XR"-HQf91BB^MI,bI&;"IR/Y8\Lllob8H:5uW</jo3
!J.l<Wj(EK]AL]AOD._Dhp!d6F%L%,NSS-!XXUk-'c,_D4G_Ln^\SgI,MX$Xkg>HR3op84HC6?
hoXf'XFM^(3!W^C++G%+/A-W/h\;H.[NeBKu`d?FHSuPm(,GGRC)MfcplQiD/'D$sOXU>DQ"
rLo)tUrA%1NPj]AV6Ro=S*K<UKMSi[g/0&o1T>g2dCHFd^XC<:[r(q\Ip#nMFo!AXZ$B4FS9k
^.mBR&"j\-)B^,;/`T<paiX#i^gGcMROj`ErWqu&L>T0#%X(.^qH/5??Ch@4`i<g"^$hdmI+
bUI06M+C)^]Abob/dpcW4[INp&#QC^d*aNi,0jP#Stj4:P^&K39<MNeBl$fsD"<C[+u*'g2($
CpTFJ$3V%B=.X9D+!ZV;Yf6dg)RXCO2<JCq`;F!W&-S5'VE2UlK4112s!^Km5O`.T>[OC&6@
+s^F"ILiG6On^2Yl/`ZK22W9D.E_'.&;GAU=<C]A23OeOMC?pmpZ:o%ZOA]Afbl&(@5eY'(I9@
IlR09)eesWZll`8#e<iL^VH;8ul:O_T#6DB6N[Ljo"_[&-_8u5uHU2h/?uN&r)9l@:@!b5]AS
cm]Ao>a#>f!>`ss:I2)N:WTXE\b4:6>LnCkp:Ybi8B&)/Rd,]A@9T>#.k_5I`10W:^8;@iOI.0
k<JXDaKWroP#o[SH"IJ%smR2mjickq3l%HI_YN2JKh'onX'TPbJU0Dq*[M09F"QtSMq4WlVR
+te7?l-pi2VG70!a2qX?,6\eV4(Vg)`q37=b=&V=&5lRk&rf(:m]A0_/Sb1;<@"mM&Ur+&%WG
I!dgR>>":<kcS(Q/:ZAl-9\!NMm0:pH,^V(iVd*M(Le=q;;N%:A5]Aq%aWL!E>k-A^1.0ddTY
fn#02H3=5/*b,5ED\`P&r;lbf\QA@U(7uW?=B[i$W]AORak:6H1"l+/sYphb[o$CM5/RD!c[?
).P27EkP`P"#s8RD@&MDMW;-^h0('SENRQV:9WI^[^U>7/JteeJuqW;TJ]Au(F%@`r`8Wo0$T
E<N$A/ZCf)aKd$u*G7FFSM5EXh&"PjbHMff3=4iVRi#'ppk37!"r<QmG)&G)FR7!H_jhi0b*
<=N/NU-77d+pVOLVJZJi8QfnGm]ArB__G)-fh`E1eoE)_hOOUdrdWH>`>b4<G\_^pK"B94Q;W
Bkc$T+lDU?CtHeWfNQ@fa4355pZ0Hp`,!2rbo#^kgZAY$m&`[l3W"l)s$t5*bNV_i>78*'HS
d\!W_U/%jfc*2E4ON9I*qiI5/Z)_?)M9K7fF"5'KbKVk%A4qe3%`+%(jPbI\#U8\U?4d=mJ&
PQOABNT,&LeAKSXn.(Hp;jEq+qr?!fgBD$:q$]A=S_mA>BPPmIT(]A]A3r(7]AlD722cCmK?pj4+
@%2O,*tV`i;5X.UXn96%A%_mdnp^?GrRBfrB5/ciSi;PU#@a^Kb[`4<]AXeO1bUct+ub$$f6m
;:`%jj9#n6TrI"_VF7:F[KdkF_P1@A2s&pLYI+8Jn!lW:pci*;'ufUqS9oS3)iEa6C-+59f$
[0=b-CrpN@T$>Fj\(KSaQ"1-+r1.-0rK;F+VuEFi?b1iaR<o94d-60l<[Q>OadS4B]ApV4D3L
'2Kd!;_Ta.M),P+N$a8[!D44BZH;?u?b'mVh!Y&q=WAX*pIUm'Jq2_P5f8YYU%<^;Z"(5;6U
Ab#qq0Aie32k9@CutAm9i7d?=b$IM7NCs`D+'/dSb@"e+)umUbHP@:ou1c45JMUhF`\\oI$J
VucJAbK/.t?Ppb:PO!6f!OEhg:/"t>-V_W_u%/gc8pe@AoF<?%TILE3skBQ##"'eVF;.lj=(
Z.#2=7T5:NScjXU/*X^51=!]Aj!M6QI-_,rT"^m3imcm'q<k_QU*hdt8#\?A6p&[Ppp?0i&"^
a72hD6;$Ue192LI'TreoZcA)1_[n_3bLE(]AuMUaT'ba:,`ssR1`t8/BgAWN0.?eo]AI5%*bKI
IFd7`27*N`mTRj^qHq/go5.<NcmC>)?"c)=Qa>opg3qU#.O^_-9R;oG#!JL#',+Mn,)#>++,
sflHM]AebcIc\-=A2/Z?pE-DK+Ok8lTb9*R$Ui(k$N^iqf-rRl2jT[<N%4?28.hX?qM'%@f#^
>BH)dO4_&3oNo/!9alhs\@#K-=3V=f9_S&9U[9*8ld`_7oOV.PAao8#2feMc6R(N?TQ"!oe3
^&p37,pCKSBW2P?$ms\Zj<Lqpg^MP9-,I,-jniPG,sV(oh<csJ`((dEMaVcO9,$c%!^6Ggd9
4IQjNl#JFBsVpn%RU2;7]A'`4'Y)&EHZ:q(iUbS+uPt%Nsr_P.LNO1`1n7O3"f<\`-PatcN)(
i^lh7@+U>mt:MM/&C`?aupu1]AW)Eh=2(oQE,(C6F:R#-^95H,h,>VfNn$Ki+=.Zlif0V>Yj`
M/_8(XN/$_7+cpCLcUV@]AU&D79jI80&FNs\m^-T<k*@*0]AQ@MM1#FB1u>!CL0fFV]AG.F?Xh-
8#jj'[I--f[[=m^H`T'mo1CHD:f(oC4((9u!m)0+]A5<53?0!+#=t#sbaVK*el7P`Zdp]A#2E>
Cgf+J#GGNi1cA_`e'o)),',7=.p;@R:o`^:Tt2'PD<`%NiGl$A-5>2O'jD?]AYu-j0OV>#jUH
j$RJh_#pN!TA@#YSM]A[0HKUP.3B&&;=VZ"&O.V+ESUsf_iM'@tMu:AmE)CL@$#E,Vq_1`$?P
9b3OR'nh^J<UR72YpU2[XQlL)DD6nRq#*uqthc@kSKJ?Ra`gUT!3pD%"gI_S<JTIU2i/ZE/5
3'4'>@mp4P89<&9cbOI53U>=nbf?%Uo\,[\I10i%[HdEnS^gN;^["'T9&X//@g5$PoC,:f>D
@Z:O)?'iJfqK0Y&)F9[($kmVp<C51cE%8GWmD`$g<_:cUdD+QBuKja_jfb'&:JOYXlWIXnHL
8;%#Hk3(+GT?-XHT\b/[U^5hc>m9@.,JB+cBCX(1,D?)eLlb>!o7R4;UH^R:ilA3>Q*gl.%-
BZ5T=Ca]AN3KO3'2?ZBFjlMNLG+5mHjEoWo?1f^ijZYi.nRQ5*X!Wp_k9I_$!q>d8C,?(q8=.
rdR]AQ)eEmdV8E\[O1E)o[>A\.+Iu_"dhHpF!TWDd^RHS!1'OZ(3UP1a@L1(_o'E@odV%p2Is
-N`e~
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
<WidgetName name="计划量"/>
<WidgetID widgetID="d2ac673b-358c-4f34-8bb0-33d76d0e13b6"/>
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
<![CDATA[1371600,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3139440,3596640,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[计划量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="1">
<O t="DSColumn">
<Attributes dsName="06出勤率-同环比" columnName="计划航班量"/>
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
<FRFont name="微软雅黑" style="1" size="64" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
<FRFont name="微软雅黑" style="0" size="72" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9C*F;t[iDbMBah6$54cBG2,e#+8LkKXPU#%CiZO,6l/t%Vau>6*2uNkuX<,*Ks/(a[dXVgE
pCFW!jja#c7>nC)]AKV!Ybq=8o0\J%;D7XBtenVS9q9j*U^2qhrj-B'du1?iAp)j5Q?f%qg75
ppIfc&g"#0:5FM80))GmKc?j0BRMdo1J=A9'k3mck6fcCeSb(YnB!?r6.t7Hob51)2`PUfMh
KlC*lK<ZOr;<;p)NGm=_5$Jd3P*o%=hJ;mNi_%W3qp]A'olmM4\)[1eA\Z@?;uFP>Xp=CPN;V
D8_EV]A@O2Ql^^:3OhlF15sHX99FT3]AHn6sT[/-U/*W:X6/Q'dYunK]Ant.Kks97eU,#E5BFAV
Vf?mtr9U8V77._)!r!!.cGC/*$l.Ib9mt!DHDZ#Adso..02Jp'8iF>UVj/*I"'<6S/EF\-1u
)=EfoW&60)1aE',U;q--oYiiLFVM_JctHE<4NT/*TiU,"F=HfKi:m!kmXV7;9825mnF!Q\P+
_fo/D`<dq2J9\h]A!&iFcnA_J@9FgDp?bDM#b#2V1_h8_XD5C*hEp6t`_8a5g8`TXSE7W3h``
Xl,OUFFK#;*2YXUG'.sdW+M2KeuV6Imd\ceL]A10R5_'ZNT=8F?:"P1<!oQ5U<o1pAd7hHeLG
<dVWb#+Pu)CJ[Q"%3ml9n1#%$2#aHIh_2l?U!*TsNUW0\6E>"A2;0$\GAr3NC59TJkODm+/A
VUSMj_aH-3K2%=TD$Jb>3Ng-6^,E&cRElpd+0.7+`=;392@SXak,4*-E5fQS*-dgJVs!i3\L
hV.Z68p/cddT<#E''I$Si[<=!qU2o`PdI+g\@lNaF`>>&URHd?IcDBhHPp_ojGs?d<WMRmq)
jDOm",ndh8ea+3a*"c)$$r)jL#O_K*6[#pEdaH.t@aREWA_1E)E1apV']AUuT?+=XV,%UErH$
7E/GFHR:FL-5&r@V;?2LEYh(^C;q&E[)p:Zrsu:SP;UiNER\smq-HKE2fN]Ad?d7V_j@sis&$
SaB(?pXP]A,D^6-c6'Lq/ataNVXJ+h'<b;j\[`oPgK#I+(sC8a"$cFs)S:;;d%;>WR6lDum;]A
qbcClWPYZVq:Rcmnrp?-rHMAdYPiot<r8bWOPK96qZmLK(J?`kL`!H(?)sL+I,-NfVVJJnSQ
fuoCJ'FhKl0VaG.:[dq>)L7W7o>6hkFGH-I/b,22!417g2Ag<kmPU[<9+9p/OGQ1J^?EP07.
ueMbT0@*!Mj*K'5QaC<h[YHATkUHD!WMOD>lqJV&Z`"SYbLF9s9iN):=IXKW.15[e:5ODZ@<
&@"q.CYqSiNo&>`NKbGJpj%Xm*1-73k2^N&p*@OLDIAT=0VSf+'iRrk[h/\]ADY<tM'#a5^/5
O`1Wa$9(Rt]Auk^Y]AA!T#R,_`\+s/2,.]AL#VBt&\Mm^'9&MSb'4O#jrnK41%gei>"Rl;a^AZq
`L):h'CS.+bf.Dn4Y9\C0fPE.9S^gn*?f%\(\&`,!Z`9Imq;,'%Q>F%O6Uj56Hh`$RUF!B/n
T5H5;&#n9rHaJI!2<HT?uep!(iXC<V#1TXXoBiUlsJ,$Keh[]A8?-lk/Xf%GBrT&i_]AroJoE1
ud8W9XIT^Qtc*XsX1^fO/B2EK\]A\puddWe"jS1u)'7u,mQ%&V:674Hr!r73\bEW.%<Mo7BuR
p2k00(E@ZDD*pVUE.$Y6X]A$K*O$W[]A4Y%k=qf/![._lE$FG5iderMBDe74>8LAc&.6(ItU@0
HK'\YC6'(2l=Z.-o=T"R/DDHFFCOn>Z>rn.]A!n`eLt4KF[!r6qd=-psJdU"A_/8pd$XX8K]A>
eQrA_T"Hi[/:Y</8@Jd>%(KilGU.Vucf!;&lqqir'f(p\<_q!^Qf;PnU6IHE'!H%tFC;&a=8
HKfGA6^J!.Q\inXqMW\\sNfUTscm[/t,NjM<2Z#fW4ML!efec<)ZhUiA\b.b)g-mDcK,nV<7
_E&..X@W!b%T:&lh?6iP5/nDrVSOs[\c5<aOmD6-KO"0C3f9]Ap,N,RG=4(mF,iK=r1B`:9,.
2Gl;FQ!\WGK3NII)uXX)Uus)?e2WcGl4Yl)qio>Y4/b;c<m%]AGS]AbL3oTAa6NMpu<#g$:;KY
foH&"aEF261u_<NX?Z,0GE7T+E<V*kq`BLSW0baqac%YQ`(e^0mk_\1)YZ\1B;h!,m!ZQ'KT
H=#0,iUM/$Ac0TN(W_=2D_C]A_@Q;:m%YK@R(`S99kh63d^meul<(]A@5B]AK9+4co4PR=(,_2m
'qh!p@5?cC\-'TbDOVa$&;DZ-k;"MM"Q,ZCtRoOGm3$G71Qoi1niZ^;pA]A_+]A6l8`H3Re3EG
s<E)G[[\qh?.hKq?a`?8#nJ=VMX`-suG`Gbob;.2sd#Jo/Q>=hg+u_DX7>^!kPc!=:_$jR\C
7Qe*gZm'?e-So(jblpWm235.eP81Q%:iia=^.]A?_rGn*7B_!i&iF+5P1[-0-t^4Q8Nu>iP7Z
1)#fSZ&>A+fbApn;)GS^TurlW!A9'QS#]A@th^FT3WH<N[dE$,qIFjbn%($9["W6<@\1oX>rG
ll<.GJtB(bkXiO@59A5Y&>J'*RQsFibQ<>J*j*[X3F[t<Z)O_6`"Kr-nR-iYWXQdtLJ;.;@6
4<V?&+B+98LPe!c,GU-.(b&Q*Vt]Ajp(T1PAbJNq3@(cR5@4ZQe/C;>AJLFDW4q>[)B!#2d[S
FQ:lZgRII?">o;C!/F!+@&C2O_SptLFc-:Q,ar:YK!aPs3l!smKhU:L;9/&fI^<H7k"<rtuY
!(c<rP1OV3"gDUMERT9K"n=3ENW4F3t$f"d\1UL,uH]AuUd$S8qQ!`oVp-Nkj^>0NnT6*`B]A)
i<[Wp#J^l_UT^dgQUG\j]Al+X$=79S,'4$@g]AH-94#J%J'l4-CrPFH:ldOA4,P64aIiG\,@A.
CKotJkm-LR&"BnlVVsolXZAEu$FT=>n<n[[1qu&Dip"ISp90fT3:-uGADhPZ?E=Qs*Qob!!<
^TqIYZ8./Z`d!0\TORCK!C>:ZN:2r\PO%a&IcRZct6sCn)#WasCg&&jf]AQ_t#Sm@GVq&\CZG
KJ<:6[4n;or#'HWYml&I"R=t\U2g6]Ab@<BT`=eg0QbLrZM_qdpUiFT*C8$JujBJ>0R`HN"2n
[$9C4408L82^XHnR!0\;e$cSAWVBg@s(D%1NbXU<2,ChY9T7#[gL+?AbTkcpuhc)T>=:GQQ5
?s7Qc>BqS=AD2BMg:Mc2"0gSg`X4eGcj1dC&Tm!!qqmE[R&dK;*_.D[:F@A8P;qkua.1GAgg
TdiH3/@&:rbG&Z?s6Q7O*#e0AUh:>3@P0Gal=;.30T0c25b"%/CoA)_,t\n$YrFc`$Mh>/K]A
,,p!IG4']A&)?C\pqM<:)>!r+nD9tO\UM#1CBu.H,QXmT/UfKJ;W;R;-Y$",fYbH8+$f)Tr3-
ThHget_hF/1D<n$6"U!`FII5\8J9d9kFhLVQTH6gdpHN*Jp!q:QG:`Ftr$^PZPMkK0([D.Ze
>VQ7D>e/MOch+!0&N6BMO99rAX/o2N/^*A,NCV1m.!X9_pEAKY"VRSI@R;Jfi9"ee9-eQK;0
<fdig(>qSPk!gtoV.Y"Zl54dbm;Z5>M6$)c2rKWaO,[JQN*W'596/s2=Cme4VcQ$3@2>HK/3
&(V+`f?PgBEN'.3+S^2'e0FQR9[(Ff:XOHE@7)Q9Zn^9oiPTtc8t4(0*"(,8N<t:Kp'P2.Gc
b)A$bPj5T"Fk_oMBrEJ^?L&W94'h&(AFF*BdH70@Kd#Wn6OuVM`X8-M2jbQ:[ZOJ=`gEqFE,
-ctck6E+'IK59F/]AQL:ed9YQ"gL[d$i>YITqNG*?a.ZTJa3a:6+'Cj:.H=e_Ya<VMfrZ<BUg
VncK[OO#ETUnS+H2c#SocBDYraf7D@X=?WmhAO2?*bI8ZFUB?f)KpN(P[;o?T#K-Ff65_H<Z
[jO-ri^q=3TkC,BVSNNS<<i=hF:a^38GLp.@umQIh[r5fB@[`OiHFQ7e;WI)Ns^NfC9k+nkZ
*"GW]A66=]AXe7k1b;MQ?%D5R!=LcUh^V,.'0b&+P"S(q&"R"=%"!iB7V@+0?;oTUZl,Q"'>-F
j4M*u[I`?PEre<h`R,2PD1h+;IPl<BJ[l^:=&$S$##XhO0j\A]AZ.%Xb1G'ko\_>Z3_4kST"<
$GHso30"uh@*Grs-h_D4oP562tDr!t0@p#SXW4=)sg!.R'2PNC>]A1uM2n7K2_'OqMa79T]AlF
l.U^RmtMZ6V6/<9!l01;!]A9lAb/(C_Io\l8Q)#`kmPpZc:oEL`pNuCCj2F@>g$AOh>J2UP[m
r,3`_PecgSuk3F>%L\f,S`fS?&.2n)6VKpuqdhkgs<lYZ)tO-@DXUc87pOp9>`(S8#c:&;if
.EE%e>KNaA$_j]ASs*:R`Fj4Z&?Cl:VaW/fQ0rjFbjn:O\[h0B6!U0_a?6"Kg3nh8h)BuXH7,
/Fe+e$1R?2M,G]A>0p/gHP``]AXN!X3p\oN"Bh1NFI\*/ILP'+?mhNh!l+j<_#e^IAd&:"MO?u
^[]A0tg^LB>6i7o8Hr^k/k5?rLhm@R3g]A8nt5qH_:5mu&2&%K6AB]A8WaI(MSCF?@g(@Z_"uq#
Cm19G9J/*P@@VoP"[esPD&2pHU/Bt><lEe\*0fjhCSWJqu6t_JhLF7dI$[XA]AZ<[!6r9,)5d
tCEI(8:W<k(+bdWW\X"75/9E7'5p(RB!4:jIhf)4V&L-l-@Nf$Q$RGU"oDg75b_%M#nQ):Y'
c<\I2"flKc[s[h#;VQl2't!W-oX99Tq$46BNX,O2Q355INY*JS!o7&`Lq;Ee3ecBY\"3\&b%
+Zd4t?fmGAF]A"#0`*(#cK,KjHa\7UcGQc-FL]AjLt\"=`&:K1i"Aj[A`j"tR?!t.mSuMZ6!BX
tam8u#1=<(!VE^l87t<*kdXTRBlV1aSS[RI?qoU$j_4QL&VK`4Kb2m\#X7\'Q'/gen`7kA$M
N%$&eh#pCLE(O5S$9I^&3HH4Vt48bmX![.?&q>d>n:"K<oWDfq#paCl5NjglgFM<ctS&*lu7
qd-k:WVMU9Wi'dMFS2[GsIYrK`;/AF6WUT!BFcjEsXC]A-M=QiKtT6%;RXKUWtdAe,0bSi/%,
[7OLc@8]A/N-*a59C1,2$4Z%,P`E((C)M$Ci9!JL#5[QdP+O2*\H3TXMP#YNohR0+l&C@IW0^
(MI`hd-X.k1bDfD/=9S+\8>]A17ElRIT,m5p(3K?JfM0i+m)4XWga^6&=cu;R._r1A"@;$,m6
&;pr8lh;4(.:;-tj`'D@L2C77j$=q:>j!"%(0,br(346m2)7XVjlM?+noP)otbIa&sBe8IEI
h!`el@BUh>9Wh/W[Tc*r4r.A.2MKA6)C@/BT6,pYk-5B[TnYMli_a6'&74LEhS-B7F?BG!Ci
kMZZ#gR0S3colYeH>3`"_<dpK_np12tL-3X\Qr*0S@NgXhTl"*[)Esbo#=Um_)?S)uQ!R&,2
M:s\<^ACl/R+aFfI:FV(.>mbu(cdhCj>-X7Ht#+r@8fY\:q;[G4W+2BBPBE?hFJl3@Ul02k4
=c%pnk1-XlcKf=jkYr@W8:JL!C_gE!CaqY*86NV5:*M_I29\B4`D.=-WfTJ):b5hA`S@^@j.
n!Xctb[B8'tVH``&Dl_`=NTT,)3PJ*V.Xr85PgkuaeE)r8O"qAZFaN-R%`n#?e>]AFXlqJW%d
>eC#+;G#!B8S8V0%CM'#B0P#aH#L<PtW!SDa<8@Z<qL!PgOsnn2ZlWIdb-eY=[:NGcn?9k*O
4iT[=<Z#4AC:5db@Mhc;h9n27D@(O[a]ASbh*O$<Huqf+dsRThj9_B]A-gLq^PJf/_NT\moV3f
PUZ_mB7fnlpK\SL,s$/.'n<F4bkhJ6=A_C72T8J6!JLVd8(@3cUbL0cf+EcBaj]A19#1$\dWU
C6,4RE62$bi!+QLfGW;gfdtT@!+]ATX+4YC0*0ldMd4^XDN(e&YoH]A+kKWge./Ag-kg+$3,^n
dCmWG<pb%rS$!_1aO%i1AoVVZH4g6ru+qVjM(8e>4M<dG!G%]A5TZ2_ec?p;2sAtF)$$JJERd
dm3eHfl08^#pP`Gclb,X81V%QQ-uI&oqhoZfW4e[)hX,^"QSpEO,>okkd9)h!QVH\6_oMZ[?
9M[dmplD95f[B:V)2B6;cX]A'nA;Uu$CL\hH1pImM$2D`cW`3&4'M8q$\]A4rrUM`.*4!51[!M
I'U*6?-=<.UhY1LrC>S6cKUc+@S^/?%:Z.lnJAuN;Bggmh+Hj[riGq7\q]A1c6MGqXkbqh^!r
CDq.MAX9IZNsdmSS7$]AL4ig7)Ccm3U?_EK3M-J@(nn\,f2-^*si!AOieS#R_=V4Q$$rcBV$a
W[C*)SAZ+rRJHID7U%p@ZhBr=X;[7A_hH[q-c_E=j%@=8H6sEYOQ=j$g^,8-[^TJ?d6R8Pt6
[``4#D_F7amJ:X:W;<a<fL/_Jtsl9^4X2bjp&j_G`i3U&>TF_KrtC%J29X?L-tb"#rIn6,TC
p"U2Ya&XoH8^K4KV?!rs5`o_AOG@gHc#FGOE.c/4.-R0prcR$0&ZK\h)gikGXak=&9_J=\$s
Ic'VK668ZCKDiI9Nr&'LK6>c#gt<h7Cn_Jt<BZpm+4T]AMp([SuWuuJM$p1)GLgRd;%jD_+9>
-<[3+jGQH5.GgFRABuag/B9@p[V[b;Q*\[a[K`/@A@g3sGi6O;ii$4k;F%Gqob8WZ9&LLVi-
B#'%pg[->]Al$U$G\*h0$sA1<9s7EU2?YT2e_VBFP1W8n'fW7fHqH>E6F305*PphH)+_SjDG]A
rL'*OJ04$-;\sN0FN.PS?Xh;fn%3l`X-Fu]A0L-PVS3K=+N[mZ?/P,$Ea`=*DGfi:Sm4a$S2L
9^d.Xc;G&-"0NR@[cc#G>'%`^EAr&qX>B3B,uJT\aUAJcCM([TLK4GDV6U\O#(E5Ylqb=iZ:
5T"ZP:Ij``E?HeE;Zi(H=O8OZbmA>&M&al`QM(@Y1rE!g"TGSS!haa@&CJDUYVT,;;=rm@Dn
ch6%FtN85TO(C<2gn6q#OUZ/*q:&>7s",WZ+!g_j^6@bZmH,RL+6&B$[X!:aiJ*nQEGo-.cS
&8JK65GHDuhHaDUJlQdEq4<_cY*REPe)I;GpO>).1hdse/co%Xl!0"mY?j9.>WAtT6GUNWOp
&[BJ<)AgO83msCF!*oK%[Z^r:a*pFah32/"]A->r*R;D9Sp?MMZ>%:DS78N!2`<AD7kF#AE'c
iG-lIe.%(;s5O';B(;L"&;gI,L/RbQ\eX;m&`Y61S\\ZI&k"q/NZ(,4eBOL0#X9hmIm,_Ac8
,@#.JO@5*tU)/22*$<o'`rOA8XiH)t-j,dKC0-S*)UtH)#El0F.MLu,1jfqW7O^*nYr\oBZG
YPCJ%Z*6T4Ga"OS+IkaRjg$)kNWTQ39;/o?R:J10IAH0a!cR"`8<7\+kA$(<98EGhGi9GRF*
tNSs.;)W""MSKo/akf-kFDo?gRCd%DO1r.%W))uFP\dJMcfO_V,Gm`X5'"kshBLKksnCb[(]A
S+5kA@LA!^&;ZCs#kE!QA!RO(5]Agj"!8Q3+-/oYk,i=e8R0>_*,V3C4Q*rHBF]A@fT\i,r1$f
gp1PhMeYA('4*/JV7FOTf(DHc1_-Ph7BIO+cXc_AUZn?sW[;C3@o-PfR1)Yo4\N>RE=FOC$M
Na,X3M1N;;9)*dh>fke'P%i'E-K8iCNL2=##uH(4J;J0N:k33,n)!.grs<o@%-1LHb1/#&r8
r\trAO~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="1002" y="53" width="125" height="50"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="02.指标卡-出勤率"/>
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
<WidgetName name="02.指标卡-出勤率"/>
<WidgetID widgetID="45084d18-4b73-4ff6-bff2-df443ba75d54"/>
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
<![CDATA[762000,822960,762000,975360,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[304800,4053840,1798320,335280,2651760,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" rs="4" s="1">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="包机出勤率(全口径)"/>
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
<C c="2" r="0" s="2">
<O>
<![CDATA[年度值]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="4">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="累计包机出勤率(全口径)"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.ObjectCondition">
<Compare op="4">
<O>
<![CDATA[0.98]]></O>
</Compare>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-486008"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="0" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" s="2">
<O>
<![CDATA[目标值]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" s="5">
<O>
<![CDATA[98%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="2" s="2">
<O>
<![CDATA[环   比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="6">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[大于0]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[E3 > 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[↑]]></O>
</HighlightAction>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[小于0]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[E3 < 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[↓]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="4" r="2" s="7">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="包机出勤率(全口径)环比"/>
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
<C c="0" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="3" s="2">
<O>
<![CDATA[同   比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="8">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[E4 > 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[↑]]></O>
</HighlightAction>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[CopyOf条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[E4 < 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[↓]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="4" r="3" s="7">
<O t="DSColumn">
<Attributes dsName="运行指标-上个月/周/日" columnName="包机出勤率(全口径)同比"/>
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
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="176" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="80" foreground="-8988015"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="SimSun" style="0" size="64" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<j7cPP<mVBA9uB.U+u#X2;:TI1:s2WC>m0B6C0eC(ZG[F/fp'Jkuab6:0,S>,G/1W?EaH9G
E>C,U.77$&Op>C*H4Q!>.kU&0_5iP)t>YVu+/Ichk(rB1SVlIC?Q65L<3=q;&g'p\K?Blh^V
=fZpt7/cFd(^O5=GVj;6#o:L1hp!g=PVk/3\a"MlOIIbM%s#:",V/QC_+&N3,;oA!*(XgV.2
8/k(/&JJ+?[7;'+'YtqCeFT9r0=r5?%FFD@P9YErT`ggq`d%<igF-nqW0(DSj#I;eJ6Xkg\8
DrIcqRTs1Z#;'E/8!rPdO"NPEg!qoI<G]AMZ^MhKiKth!H1q6kXJF]A1m.G=(+@h^o(qV:YPT3
hD93S:^@9_XMd0d8Y#$$$<(in_kF7okHJ/j+%qo#XkFCMs2!h]A+NsODVud!?p1p8LnYVNfN^
0+"cBbHm^:=%NO3`=&;:Fp)mgh57n7leV@1D5g9Af[)[iUPuS\80X<&t)emHo/,@e&l9)!K?
PPfUjk%?)I@Z<e*Dc*P*3n1g.)R^4Xoh)!QEC?>#Fk4/-XT/ZdiT_T,r@9rba2*#2NMaPMMf
6qo.1"5$[l=>3=aab5g4ar_;OVWSiiR37WS![tA%"6R2;sV,qKCTOWi_e5dSo9/7X7f9e'5t
aQMgJQs;--Ob1:G:$ncrs"Os<uM6.rmLJG`0l"E/OgC+sgQV<lo+'!"E-Fr#PPE*Q<&CJ%3T
<7O%:-T4gi7rKKBq$,nmL%NsW&2jOM'[^g?N>EQcIq../kT\LT[-dI+N8:>)ef'_bi`/t8k2
]Af^o.R)8^0$koXR@c6?!i;o&JV*SmNaMd$\YM;FrB^]AmgJ5rcd6B4DiHqg]AKHfqb:fd<I@-U
d3466.)h73NE'UNk6u_q>T9"ns2q@%:a6ct*k*`GT)SY9F6qq43$k-[Ss5D?in5@UOdU&^K>
/1(t0eEEt?Z+RWOALg6k(&M)3k`&d"]A.0)g9h+@n7Y^>H83#//j;/+W5#tUT6dT1Fr,W:jMs
UYYDnT:UPPQ[R#XPqQWjSmBRcE$7M^Uni^jm>\YI26K*db"=7L9mWbIQ\P7DJY)d8iW!59Fr
p=hZZ=M-+uMVEMN173eln"OsbDn\DJnqVogAT6*91f?5D6c1cm<5ZDZd2^\C."6#(ATt&m`Q
hanX?Q/i-mD6lKb[F&&A=/*^XPg"I^QgA^Lu/a";DQgfi!p-RGZlYYo,o'?cCmKf>^V^kM=!
M*tG;+2_YlVnYQgM2;FHbA[&BfgT/]A_ICMZ/csQMS[o_5hk8VEU4!"hgIjjD:m0W(UQGa=%k
jXA8Y\St5.UR[!(?]ASj,f)7+o/T]AO(rE7iiRR-f283O^;lA=G[\jkC8";3(gGlVDMPK=GIIk
j>95fTOR;/"27:!SLab\*t6'4+).S*>c4B=n?e!Bdkas)Lk4pa`,F-?ifg697t*`@D,f):BT
=4)a0;P@st8ba%H=E``C-=r1N?<(^dC.3oRX'=j1+l_R13;%1ZK3jl0)VMBX.Pp>Qe,B;`Uj
\3'NLPeoBsd_#H%gMOl'4u(:I=;#GVK1'Q%B`QP>)Ca_:(EM2XZ=F'e(Nm^YDTJ)Qm`Q-Gf[
CYX\[;8gWL)LJ<JqcOt,"X'1Zfn9Z[t%iB:YLF1a\qE*4[7iV<c/[a$/$!D100'f$$W="/uI
=g#5ZYj4;Oidgt)XT_$\YjuZ*SVYrG5;5'Pc,..JR8R,P)NuV3Eo8Fh3o<.SU"1>-nA!K-d.
*b<,+EG1<Mg+cNtS'WrUA0%tS#.7ue&eN$:e]A9iC$7#V[/J!:/j/*kND^2;70i0<d5?D!MqF
Xn46A&n1A4#OS1uLYN)/W^%ba")ZF,!ln%+gpf`;R(LBDXCOT[7E78k+Bj`CWCfVRHWntT"@
<T=_&<0=f(O=)Y2q!^EC,<i0arJr5F0,'h::P*nT!g)C)&#q`Tf#?Y&*0%8(DWMi@-Mue/q1
F#U`4)=og<;.g;/(WtiO]AR`7r'iu(EoKeXR*Q7;;J)l,=cPf&/oo^nF5D:6Gj)#V"T3:VK=F
FA[5/^cUAJ?P'WK,T`hi-TQWg07.S,$eJ4oVUDq?dIPh$Ws)kfF,KWO,a]ApOY%dfX!#8kARc
oXSeR<ECf2:%_".(Km4,aNgm8DoFs0k>%Ll\Td[E6c3Wj&k]A''H\_-*?(%7O6dg5A='=E:]AS
6Lu?.5c)>-?%=&5P7QP3m@Zn3MnJ;M62\t4KbL<gMS\(eHjnA+C)0bedA+LK1)9$*2FnDqqn
7TAl3`E1>His$%-!cX*@3rUY!b4g^YkJEYV6=L2W_V5aZ2R&RSL*PeB^mKDp5InbsS9$foI_
eM0\\]A.sS!>#C@hb_OP.jPeu#u6Sf>[-1<.'!AhVsE`hicr"+@j7c2US(a9&O5Yg'.__IS&1
"bRpK)l@94$Ds*(4M6lTHANu]A%ahK?<9Vn<*M=i)Xfgn`tOE"ki=0KVU5&\X*LZ?Z(Z]A&6D=
>,GrQ5'+&ME#q`f*=\ZtP'Y(o'@8;BD75r@=<e6i>\&]ACRALIqC"MC$Ab@Xsq]AkW*%\e1<!)
TA(G^"D0Z'DB3d%Ni;1QKULTVb&^J9_c1ne(bH(Eq6GYn_qJ2Xpo:Uh12PgRA*]An-W6""u=u
aQ/?-\FkpAEbY8\(+.L_Kbi8g(GnVp]A9UWF2&<#\YHrPoM!A5g]A&.^c]AEP4?0/Wg>k]AqT\O"
O.C\C#Yk*%DjBP53O$G8$,.&>I.%;;>CW"q'N+<N&#a6ja)mjqu[OEfOmT2f!S.$u7$nip,_
gb08&&i-qiYHeQesfAk3irMROg_*R%mC5c_.a%?1h!fm%UIOpIL-/1%L'C^=FA_q8bmU+G'\
WH?M+,_!&h_QPPJH>J^\uRqBd[tDU3fF"!GP%[4`TAYmC]AXH&@DP-HsG%8Yro]A)\5^qVcM;K
#JeR_=8S=$&cuM6J2K;-B'^Ls.*.GMVF6S.KL(BcMI4OS,/ab*.i]AdIKjjA=@(+nr-&M/K%&
1k5[L-Nhd-T@D+`&OT4fO)'H4mRDHD\'ZSuH&Iri3X6NB[<8kJjk/(rB#Lm0CBKgt7r)YZ:a
=Y0lGs'o&fJ=BSUeLY]A3M]AiAPcH3>?1VQ!aEFqIX*=?FsaXYX&k&X_*Oa[PugIP=G?,I(oSp
Mg<pql<2523k/0b>hMq_so=;e[3B[Ur<'oXM@TnW:-1CQOaZ$D%^uR,k39W;qpKA/_4aPA&Q
db_9F]A'mnj,&rtR!GWkR>RWe*Kq(7:"o'N$Qn7W6qX]AD6c5,5hHDdlq>,4(>2&gCfFE[WH<D
NXeI%3*7PFE85XO]AI!6H0(qEJG05428MS#Vn'GUFOPMrWgN:4L.Dj.Ir_hI+H-+pH!qsY7'8
Be=0jBf<R(9p_q^PQO/eoA->9aqZ=%r+BbGj'o,E84sL73k,&>QiFD$\6qW571fLCccs6<b:
9c0088S^@MHR3NJ9-!T_KOikf+9lLNVs%EApO29`VG[3`%n06m@;L*@UT2aR*QgLIPbAgkUF
fNaDP#D(Z_mV#2Arp#oRHDN]Ar#(LbcK;MTaiQVO+c*a:UX+)`^s_tHkmGD$)Q!l$=at[DE\\
[PotP55VS7GiUMNsSp/O"OZs9KA:FC-NKTPKPb.[#jZYg$F+>CsKRHh'bJYT[X8gG!Z[b.6%
,=*WDn.qoKVu>-hdSN`"=]A$)s4-#\VD,E24WAKI";EU[p)R$$#[$K6pjA(UrfGlN&&j!-q8Z
9GBc'XLXC8FVHHA6[9p7W#-<0U,ObZ,rR#>?!jrMLo0AB?nf*5s[YKtO1ilN7c]ACEj\>d3oc
i_Rqlard3J#JRm5u,SVaj\M<2J/!+6pMQaf!:rEY(niaEJm</sqi'3X[s'J-*.AG\U_fE1:7
CUmA"("4Erle3f*sdmd;[-C"mOVCLI3Tqe6*_p*l_UMcX-;NM*W>O-Yl7N_l.N=V)U>7'6am
E%>T`mUqbrf4r4jRWZJ*#*(BD?=M3>h_0,H_!Bo:k7R#gDX530O&3itA9YYDrJAlTJ"Q]A*6;
R4s+82_BAQk7;&59Q(8e!Tlu@5<J6;bI0A"Mj^ErS-CoJN`:I9rgAbU-aB3s'J.M?d\nDWeY
_@UIc1@HPma;*[tZS)@u&l6cR8CgCBi:C!bG@r*'/jsJ!b2OZZ4k:0Z)s=RUs,(:$=72b_^H
:@X&j.pp4G\g9A4,TKK0N->/OBP"ZGsP'gH(jSER]A=s[[N5$`gO8]AE(f]Aq(JZ6%N`12*l[S+
aJMFED;HZ*G/800mLU]Aj_^#Y&a]A0,Jqdh)oe=RGAkOO1>6%`Bo))>,Oq<mM*H\7>BeKJj*Tn
%:1,)"!cN<JW;c-PQK=cV9Mj'sN\W($e:gp`a+j>)t9dX1pHSZ.(aTk7MQ3]AT,TIJJPRZT2M
lViSF"Unl+J@%$f-bI/>4&b<`[GriV>96(2GV&R^jDD$,oc%5-M)DV*MgTtM`7SA11Q]AC+XI
>S%9c8VLK"$NhT:b\K1';t"%\9Ah'TRI`E<KG1#?s^UPE6OHKGW5dU9XhjQ6c\7[^DUji'XC
&L:NpT6ttitc&>cgUD41W:=Da03\6Nt.&VrT<(#dom5NA0hM=UcCi[OOY:q(QO4S&01;?3#:
EB9'jo^>4F8B@$6f"RorZ$p?P-6=W4(%Yi[8b+GjA@t5aP\DeQY#3Bm(A7-ft*m_->15":\U
*'4G]AJ]AL3acP?69,>W"-%_+HHdher,EbcT5VSm+Cot\oqgOcJHddKI"_Ik@-m5RE9s8;RpPD
ddk7KQYOP."0WrKO\/XV@s'[D]AITM!*KCS,),iKbbDqeKh)7uc<Jt7abZ7DjI=q4a26jo*Go
i/^o2H(1(KGYXl3`D^K@:7s8Hg,U92h#h?UnB\,M9_]A0_ctbNW._OF'<Zok2*9=Ue=spJo-P
ZJ7SsIhf,'q<85l:T)<>Yg2B.6:uXZH\<D5,WYmJ$^IXRL%td&</KCl4S7kM6]AmOq-3dHf2n
d>A5iJ=f>)@>8aZt*p$%&a&W]A]AIIM+QDuhR5e!E'q8+t"Jj/?V!ZIp*)Y>8^<)Oe+0nU<HQ+
/TEsFYS_%VuO6.NA^R#k8s.Rp@#>#t!LK*jb)6?jqOB2sf-&CE#18!)]AlJ/A(DAtonRSjaL$
'Z_K>*`0hW1`%E[4&'c$.3^C2>IX0B$t)/G<U=k(fQ3C0BH%hi/Oq9p.AC6m$K%NuDW,T#bG
jc+Kh4^.]AUbVWgD3YVY[h-&&C(V&N_bV4XRbDb8\46;1ti'%*q:gu3V@!D*f.D]A:P*-')e'D
fZR0;jU+tM8IsE,iF8e$8@<&TPh9hVGc62EE;rQrlPHQ`t2Jn?enZt0E7M$(;1P>,uOk)nc#
>EMKU%V&d_?m%/Si2=erBZ?I>q@MVh2M3CPV6!nV)Tl%qp9[49lIkWRqh&-JOaE_c=3Kt69p
h"]A=#UJ7=A`-mAKGuRT?R;",cgF5&sheE-9sTHI'9DP16cqFE)RT3tA)1aD\ulQ4[MS?]AkC!
8VH_/X_lC4D&4:Z2^"CGb>1dS$#+r&E2\kiA?M]ANees]Aa1N5)sT+'0,nNK-r77YCh)h[bI78
p(u8.iPJK]A^*-QgsX$_oX7Vc+E:7LQdR1YbIsU]AZVfTE.MCtUY'RmkBVqUW9qG-f#d:g*t^F
"Anpe5<cr!YHK*WjM@STO>d8fai<R8_"V+1(=BMh#FiXn'f/;\tOGdg`/\%W>_WfoNG3)>ZG
0);CEjbJHK/q-tNk[`)rJn&qir7E67P4?5U6u7]AL?hs'2eTC^E\GdlM`'*XP4")AJn@DAV4p
Xb9[em^Y$J;h)kfqkM^/C[NQ12a:2U)1.FD<n"I(hW0()Qt$ti^9j:t\:#5ak,cD9mecch?u
WA0q<;ag294\+&KhC3&00Wf,j)Egaj@o3j9'D=QD)YqUqbbDusRi.(#+&,G)G-.Lom&D'bm6
>EaT&IigF]AT460[,W@TXM$7#+&')^E!=nL"_Z/ZFkBDr.HltPh!tpWrBCR2<qPg:DL4Q7Kdk
N@*X[\(L6[%i?RrrT`POiZgpkn!5'7mp`u2j*=-HN_@;B,PL.(p,bk&YbGeakl_M)OU1&')0
R@@o.OX<I0-UR"IEH$3W[5_//j('JjYTlgVq:-1Z3cW>?Z-%(esYVYD)Z[sqQcGm8\<JaYHC
R-F>Z(&L@$iY6L%oE,>:*>R%#8P>_!&Dn>:!a8955@)-;<Fq_9)*TXEPV,pqYO]ARN>d_s+Z_
&U$Yb;E9<OPWO-gUs_ed,tL!YiUiUdQW%T2()&/s:&OO9ELZ[da)f'eDV4@3[0p'!ZSs1KVV
P@Y:ArXr=e14dbSo-rQHJ&#2s89i\*rWFMj9P)(BHN.B54R5IQfTel<%tS+kbW`WnL$3J:KK
20dQ2o,Pnc24p"@IRMi;P5SMp+YL1C:;+.IT5!!U=VHjUFaG@YsCf!?s1m-,\\U:oX&QUDG3
,c3f*88mG:EGrc,fq\cm9Ln[cP;Xh+<*.K6`eU)@tp8c*OF5g?oj-\<*<jg[:Z`Uq;,ANfdn
87Vt&1I[9W;^o-q6m3%Ju:]ASCo_DJ(/YJ+KP3"`dGs%leGWL#&a=[+qq&Xrj99jUZ-FmII&^
842bl'&\t$cn]A7ZK\"Ko4rD=S^IOYiV)Vr9C+Sn'FS2.2R!+;O;b'2'U10g.DRG?A%S$eQdn
0gk*a9]AQ!AL`c<0^_C1kop\i6V:CRCYHQX5B"6T*j#S:>Ii<g1f;T$#IGopWt!opqu#'qO+(
)NPr%`n+btSn??L/&YGR5-r5^$*08(SL>a%6KhWc":$T>l.R3BZnY3nR\QkP/HT+JS`L0>:N
!QTXIi]A9qZ9QQ'd+OJ:CW60#R:NP4'G3X<=#>[R$B2rd9)OhSn->Kr;e?#'X3jlgQpiL`ki9
LR4V]AUT_L_qtdR5+;F=7@g>+<9[%8f<lCpC\nWP#4Q:`R.(]AB<+9\?uANZ3M<Rd]AED`m&;.[
UcGD^e&29b0Cjn+cotD(q^'5>CQ[HIInLBQi$7r0G#tmM3$*4VnYPJllq&,D-fa]A,NIKl4Y\
AV'*/ghgFduY%=;DD:d%NBu,DJ'V`3O!(RehQ">nV%1p%DIB3-ep9DjE)3<"^\LGZ(AY0E'j
&:$nR[FoHjL-)g10nqLipZDAJ.5ML0^("JOm4t4b3"Hb5<_.onqoM9\Y^7l9>om7-E%V86aP
G%s<R8%\"^l$1E"-<j/WKh60^CcOL_DJV"7JE7Ro5`<$V`#*l0,h9iQVr'KNI^W9\#XcOe3(
cJ3S*o5SrliaAXu[R+1g)j'9F6i]AK'?40WVSnYf@LgF(qbW?=WR?"b1K1&_6$81;IkHM!S8%
FT'kP6SbJ=NN+nLd+=MDP\TOm'%Q%[_lAnu>8/9AMK29n:8L6cD0Fr!)ngp\]A-s`E"P;$o'm
`dVKUs"VP>RdWZT7U5P%\q\.6_,cVM.;m'd7\XYSOh"6>mI_.aU,\!b)%*.hJNm'HMXkNg8#
\3bR4$\)3!1nRHcgj#t,<-4<lDhMD8RO$5P%1\MU(!47WWfX-^L,XEtR'0i;/8#YO&aGS;GN
1kK\pZti]Ag&L0"C?mk<6l(&^57*9gl3WjgCk6-e[%2pPB8Cpcmtt,E.#!lO*D>M51BFM%0<.
f(mF8T834S[bc,qU;M?]Acn1KGO-%8n6hde%O!ID7utQnIQ0e.;prEK;?#[Y^`$3&6lO`!A.?
(F@2Be',3O(!2.6\l1\TQ&emJm-Ed0E*0=aPRpZpO\K<Vqa=?*A@iO`:8]AQBH)&36.`h<R+l
G`4?IXkjPFOSWUZ&H8o%a44P_LHM.--V"HVk$7$q$FE.!nC#A:jF*[aoe'M`'tVW`;!EB'rs
A6/N0GE-`>6CYUe3(/`V0JS81,>#&)na%(o?d_2kYha'!g\J?i5Zp5@_hNJ+EGXKNoiB]A,WB
-fi3\ntN/EML()-M(q7/=G"-24lihiHCA5bhI,h[R?Mt24bsY3OOLH#@]A[dSC&U>aC>dq>gU
_o-8d%+T*4-r/FWJ1[:j@/e$p&'Q6O1Slt=#fZZA">?)=g"f#U0-2l.*eRVfe5\=QYZm1;>c
`M-Y5CTlABCr7]AtP#(DdQ;:^\Br1.C.#l3s_Ya8&dn-@SE/O@Jo]A]A;u_^+r3"a>n^]AP&Le%M
E?k(-CcFH*PuP\jU,!@IeTHPhYmm(+dp7.Ykb]A"[h!KFtF.N%>T/K%U/9FQ'7VEgsMP4`iI*
O>Q>2MQTqjcVt[V[1S_Gk[r4>fh9f(X%eOB*#N)T0^OcB#RWi$*R-Qo<iiNEM47IZc*iK'6[
GJuMNZuX0Wn#+bZcp]A?GQAK[;Oj@(do]A>$#43e^bTU2"'V6pP#_\V0V[GtTR"igXLKf4m1r.
upXjQHgB+4nQ-iF0"6jIAt"/UV=p?.Dl/W&+B@o7]AclMQ#7;9)O/O?58(hjYYZ*=q7qK*'%.
@P7YU(_5J`Q]ApeWSMg70>4B4eI<#%.Up?B4%o6gqKQ2rJ!ed4g1d.3^:`6,*P2FifY:+";i%
XOA4g.Ko+ASK&?;ruQ>p`8ZJO-P3p6"&^ai$k?D9!ln7D)+6hF\CQW\""-<ZS:fFd/kN![Rt
f&$6Ta<bo!3[qbPsjpj%1.T\Tnd3m7=7!+U0kU:@#>Z<(*F[)NAV?KJ1Yj7e=,I1i-PQTEUH
F%3J0-u?OB^7Z]An5em3r"c*V(TU$VI`'IVUjNT-2o?#%LIYOR@lWFhp'i'G-S+>*;5Mt]Ar1`
"(01q"M<2)fsC&$J29Q,4chGU,P([qt'`Mi1AE_YZHV"mcd!5Obm%5UE``gp?Y_;BkjE!=S=
O;X?&!tZjBoZ'%Oi-'&:b0>6K,D.B00,0]A5E%+?>;SL1Jj^V(nS:lb*:dr0$775$Cd$R%^R&
7"5he'aD%1FH5kS=1Mk;!\/^;8nYTlM;e>pL3@5$'K/I+ti*)tESt*#)l3l_?jRJP>0-U!*Q
DBMQlu^DE.AkdgAe7TLn0Wipdjg<*M\qfsGUA4BNp7(^!r4\pVb*af#)!N5%\S=YYP@?*2Kp
)SYUQMHmpl<j)d,H;$#h@f.S.]Ah)9L$D=VZ)cq&r+)5`CIi#T^\ZYc]AAEE_Fj6C";A[m8q6+
_q?7r,c;VF@a6jaW`IU13rPDLgo>m5bN?9*r:Um;4o(BP`mYV;JE6?0TC#(K`siqSrfe?XZh
[7I-ZNog"8TmbR@%mkPUSYTb;k(Y$41PUNXp'*0_CD!!*):<K)p@09]A%94PS?e`;dmS/4(jg
E=B<Guf#(F"VaLj(</+8dM$X&V<m-1ml9fPso`G!2ml8.XTgqF2P>5@-is\65RKfWY0e:F_S
4l0nth@t(U#dX!!_h92duUdo]A-Bt$0Sqf@E[Mfna-<]ARma>'rQ`1uL'2q1Z8-JXX66h?t(DR
t*Bm9'1GGq8NP`MY9O)FC`lK`<_RY)jM\NKTZCr%BN=?f!Egh67OjA\rtWAF7'4-Ek=4Js1i
B>Za-i%<C2<?!*@rKcd4[aqj(?j50eMMa#U3<#oLVU:Pe^1]A32iP'6,Gi[iPQuH^Bt4&ZkOJ
r<[tQ,j*qKC+&tk.K$hC9F<Vbd*hgKS_6XJD7*$keKtZd<NWt+XQ"]AdlalNHBM)X=!+>u2r3
[59lJjnT=enrs]AVC1VM.PCL/R;qT0W/?8p9H6,a?Y*I/u$uW!9SoQfEgr:XI,C7IrSOU#`EY
lZ-'I8_a'TkqNFEsNr7+4^?.PHS!@6sdHH@6Ut0s6D3M=$Og]AhoQ\*&)hJstnA+G`gLP-/@4
dSDA/mo'FIDs'Lj[@(),O7:(TYr%3\rJBhLloiOQ,s&"ZWe;7H(1%G2PJ2O#5=eCq?(-tVJg
.<emcDIF$gJ)Sn6<o#/6VbqLLIKGg*]A[#N=37$&PTi),j0Y9c<rk^oa9t)Z<qj!D5CMFS7MI
nEt&;,GEZQ?8$&FQsX)Zc+/D5'8"oh_sV7,/Z0pl6m#HbRn?W"qQP!Hd%%*8$BWZM"m`6j6$
R*Z\F!_EYf8ou>D/-HG38#W)s1J2$3AR';V;&TBD0P'=D#e`K]A1XgfgZ\'g/&8f,p#s:QdDZ
:K"%1Ab"g[/BkQpI`t@,(3J>H-AVX_SaZK=@RdSq"fPr>.[^,i)U!LF7g$g;DO*MNNIMa\3q
\#mp=T2G,r+UF3WZ'dbfA02W99%nL.^(R5mH#)&i5^5AfgS2,;>e/(d\;#%jX>s$hg%7b&f4
:U?IdS9/G:N?Qu+-TqmqD9+YHJE>]Ab:MVtGL5%KTJcor;sjXG-TlicIm)FL\?t9KGabg.Q18
^r86^1rLIm2nW28pYbV#V5tKe7o!B1-I?ldNTJO^=U7Yf"j?$G(LNJ_?L;#P@9o&#1d:sUSG
dV0^1_ddPZ+c*B^EMM(?<r7rl/p@3#i5*[X:&V)XPjAX9LWOUliS>+dJR^R.TIdr\eFe=Ug=
`=ds#BT)-RXm^P#PGR'n#Y$a1CLkY*"e^>6)ZCqCUC15Hg5f<L_,ZX%l[[dPETi9[A2%/o+8
%0hk9Y;7$.bWam"n4"<lAXf!J)2k,g)*4a##Glte#"sOnG#EAk_e&E/MBFO/g>8Rr7.KS2Wb
a;DZ852AT3E"=560+dRgR6j%FD`&ST[nRbQ+l/aBlD[6.U4^>?-e2$E-%hu5i5l\u%'8ZYB@
AnL/PEW-O^VO?PD0t)p)CNdW7OJkX9Bj,tJ:"<ICmjU-k]AOa1jm8[S#Pt?/[3>"%H[DH\j]Am
(]AfG,-reTRd&90OBrQ9iY=ZWJ_@a^OF"n2-HJ-.3@((lfdDQJb!jSqqhsl%@sQGEa*(PWi_c
22tWWnXNIKQ'X_H?nNeASP(;82q/8cCm>quOldl'<8!`"=%ll^$c]A!cJqdMm@IV=u[kO<5&:
_gqH2nV69Ud&%+oB`6>q;\-SB_LnAj?5\Vs"u/YohGT'".n#,YFD(@>AuPAHosUh_2rV'l%4
gWgk8YX='t-TVKdU2M$N&gba[h!7oHEWUC'X=J*Gsdq2XKh=*i.s@BBI4q=1&'U8nAXa\7S[
#_u\hpn;u(IFaC[qLQT*[sR4TTD01,ME@/'T82QQ=OOrq2sm]A19q?Kphtbk/n]A+1-b,,><h]A
EX.*V"N?)*%)CHB4\@'.Dm2oTcD`872)-1Lj^%KUH6mX;eBAHqoNOgFp:Pn9E3:g$\3Z/cYu
t%2bF9G.<l3,*YPd0)V`%'N%3l#?W'VfY@=is!a&ak!a^j1Elj6`b3!pW:@&qCWc?:o901EB
p6/TS>>0LM<?,=rO^[@n):qA5r(PbgrS`,EO5K1m?@bj4Z%=EP2`JO5gfpBI]A>$eqZo,]A)^>
d#*A;GCDZ>XtBsi'EZL#n.MH1Zkrs5p0CFFYD+o9?jB\_jSMW9g@DgFb/^<%8+O!n6i[VO]AG
)T?FL_JpiQ<)s92Ej`NVXT(B-Co0;K`Vq.F`Gj<.N5^dd9t#.lf@),rFnGm5nF912G3K6`&X
VJ>>R\<!IKY]Ab6SRdaP7BW`LOB8SX'%Z3N4>#=Ri+=@QZ+i-_KGPHk(]A<PQ1pislU=hDD1aJ
"LaJIGN+@Kd`KDPAV#Fubp[1S\'Y0J`DFFlaJ/\c;=4@+EkXfY#cm':Hj>hR^YCD1p'e.=$q
S?3!o,E+"B6KKFqPDJr\TR#3_0N`PO>KRiGfSHE9QVZ6HNh3(!ABen%30T!PgL!W!5!@Mh`h
LVMNS+PJ9A@GgEq-qV-?]A3+Y?S\Pi-K[,Vj1-+H1+;qQ1'ealgBtVq^AE,CMYHq,J?%,^4#W
3mljV5=iAkn#'$k8*?/"VKg6Ek8$DPeDrHW(i&nXaK4]AO8,W/\0[^;sUGeTbjiE,mK0)X.'8
'@NiHA#,h*4Xk0Gu/UDC9ljRA/if5$.Qh(;N8_a.kK]ADg5Jd=Ec=]A8Mhn<[HicEDR<`35NrZ
'bDa8qb4MUeTk4C4\LaL;e-t>s;=:LhL9o&9ho[-Sp*Y83/TP-e:/]A^QT(1^V,C.-5ImU7+1
I%6@aJ2-MB=L:W7'1k#rdo^mhY.Qt7V$AT`6L.k$Q;Z`_9<b^>?IBN7&+9.2\OXS:]A/8!??A
&N9bt6]ARJm+2GF@>qL0@?*c"<p0@"+YP/B0Q6dC7#WW\08uj[?Y$gUkPON3RDiUCC[N\PXPS
e\SCNR[ehDO`pK;n]A7g(Kmc-/;Ha%[Yp*F3-bk(foikC7"npcj^XX8<Ys'T);S&'eN(p'0o$
i0aWQ)>:0:;d!0'6#WMlOuAMY1iq-f`hRbRJfVHX/+`>6\OQ`_nYPc@E@`OkQ1,oa?s;-6+A
?]A<6jiDCM`0k"@hG82@qLhtQ0A$/sU:]An99R,JZXO3%k,Ah]AdLs6=+4d\cd!]AbO7OAG1Tls^
>/KBQfBI?]A1_3>GhbU^-bVjQrI0QlF\KM(a,hKe_btE\/>q&F,4Q<?`0>'6f6XKp4%c`+@>n
1lAd<+o'$blKMpU6s)^MqpY+tU'+ll50pIW-o1$W0G"usjPXsar&Lj)@aHW'2-Iie[N:gH\n
BV9)6pVNDO'2[4\08(eS.3dn"F3$o9hpi1pZf7nD&O+%Trr=k61j93DOs3L2J!C'Jh4]A7RpA
)m'Y_?-r-#f^Z)Ni0`(kg$@aREdl^8GRCq_m>tf:MKE-TpjIbju)?`:Ni0m\lPlCQ+sa'4E5
earLc]AZ5M72(H*nUb,dKjQr5AWbo%l7.#ld@eh,Xa'G6Wfm.*>00R:N?lOLD#E_5![^$\q=-
ZJs$_+b0Ci.@AP08LDfeTUc?5=\Q.hQ)!PZ!DXC?DMhVn&YB/lPE@`3,t`FQef1%2s&EbkDD
\YSW#G3o2`bEdiWF,3q\=IA$HdE2pUMEgX49ESBEu\7s9VH45JGkOM6WQmkH;_D<Nb?lAV=D
2PVPC::3'eUa^`JC06q2rS1[0)Or_E*(k?&ms;2&?HPUPSLjK-datQ6==r^pmhnJdpTD3>N#
Lb.*6sg$]ARdXLGmkfk\ZjVN]A&52?8"aCdDf.l*!uKb;0Y9#?;q,rm$obE;ZkTKko6M`FeE(X
p%,5B?O`nO@eZtX*\aVos(C_#/ci#gIApCA^PV+'bYR]AOI23Ng4&M^bfl&U]A)H-UmD7$Et`G
irGIL6&h?$L`JBfQDJ("d;%<ggPs`9hr4/,dF9nI,V!dFoo6^!HJaA/-*D)j*C/TI3V:SI?k
TkoNj4\G[i^tj\E5dZ#BilT$oJ[KTN-L?L[<.aD\(BeL'6>?qMAk$_@sc\qZ(XJ8Eh_6?-_?
;@#r.UjUeiLM#:;Kld4J^I&"2`:?_aatX."c(QWOP/"WeKN#NS4TS9LAP3;PDSdd!'h<HHX4
QjUT8uau/Yf`_:2=_+INLMccGKmA#^qVA2K$DpR)D`WI&A)`ps,4`PRB\KnZ%<%B\<^Ir`"q
MG59ER#SO\UP^*D"q2U5JA:r!p^gXr]A79SRW]At`iZ.,I1Ef\mU(Hk9gM8S,g>*E`NNLc&bjo
Y72be]Ar)?%&p.JhYO^ba59%Fl0b.lkB$#jAAIcA)\Fp4<LG2HV0+FHJTH,T(@<#uSPc2"d'/
!h=Lu"t>ZE9,L@01<4DeNTkXaB9hX$-\nYU7ROtj.";O6St$2LM<[Gf\*BR3;8JhKmM$Zfm0
lfW^2/>ncKYiuSp>+C96oll^r[W<I*,rGQgTI%eW<K21DZ:C2Jhn)^7GE>=uJRu;!b(3-b4!
Y%D=[&[Sd-UmjNa;N'$J>/X<s*U='T9=1E>(EPKt78V:Cf.EiM/HoL+'V?WOmpObG\hS>sV+
iPVWj6Q7'1gJuen`Y+UjjR(mZ?Aj$;'5QU:0cgj6;&fb"@Q.mCL)r7H^'3g`8qISD,aEAd5e
:FMDiQJ/^YtKt1.2mADGsD]AE/L^#;1+lg7\-P/k91$Auir&6V4;r,Tfk*$DWsl"@s6^XG=*O
"nE'cYO/"HM-5;E2!Diloga8LZEO-)_i$'N<`0HY*m!B@cIVg!nSKu+DPB5/Tl2=+4V%BT0-
57Ba@RK2p!GM_>j/lTI^CL$GP/LXMnP]A*.6,Knm5l+sE*5PIO$&(_L_F&"BQ@Kc65Eq8,DE9
FF!5;N'F/*1WnS''kFTr<r8r-Ic$.)YTm]A\tEIMTI4"AA)lbVjVW&7`C`;$tjYaB#^Bdm@OE
h47XI;KQj/742c#inUJm7ptr=[kNlm=:WjN$;V6F4NNJ%S!W]Amm8p!Wt4pC=dUS"p%T!YqTG
c`OudJg-"PmiFfVd&7<#j,hF82t%IPIhN!dIXJj5<6sf1#\8tcMI0PKPmKaO_n[PGs/<0.7,
6.[ZA#KSL^8h)8:lSH,9]A6BM8uTGIZm>$lmi>fa'P'MIb1]A#SqViZ9$f"hAY%CL%G+uhg)C;
(HYm`OVb!ieU@iT]AEkQBXbTl/`Qid-N1L`YJ(d&DJPm*uf1I$,SYF#Z(piDe2Y)GWUgr5)mV
0*p>"@iXn$l5?n#h:oB'Xb2kUqW/j2bkl`OKT9D%k!M:E9'U%f8IOlngW;%27&L!_(88Zt\$
dmbHp/5A]A$<gZ7Yb+3FGdN&4ai>F9ackmZ;lkYpQrJ]AJ<e3RmKM)M?s^M*%m(V.c)\CYhdk]A
rDe+h+/8VJG'+Zs'24bd>PKG^?"3<`Rt4=imNCM3VK#=b,8mj"\U`p'7k=FOgO1*dPb19'#g
YLCXS:):(tp*MBFo1FpVRO]A-#9V%+"ldhR>T/#PRP(qJ2O'qZkE32>dTg%[XURVt7$aQm-Lb
4UXUHCOIF`@uOEujEmT!?%]A9u\S6t?JZeHSFG^YbJ6[*1j`:b"f8JFp;pgQ6B^"hr\^Ng(L]A
N7reeZf#i<GofWZR7u3_?7O4VWf;$@]ATJio*h_TC'_/rks-]Am3DWI~
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
<WidgetName name="指标卡-准点率"/>
<WidgetID widgetID="45084d18-4b73-4ff6-bff2-df443ba75d54"/>
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
<![CDATA[243840,723900,304800,944880,944880,853440,274320,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[304800,2164080,2346960,1798320,518160,1432560,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<PrivilegeControl/>
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
<C c="0" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="2" s="1">
<O>
<![CDATA[准点率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="1" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" cs="2" rs="4" s="4">
<O>
<![CDATA[89.20%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="2" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="5">
<O>
<![CDATA[目标值:]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="3" cs="2" s="2">
<O>
<![CDATA[92%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" s="5">
<O>
<![CDATA[同  比:]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="4" s="2">
<O>
<![CDATA[↑]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="4" s="2">
<O>
<![CDATA[1.5%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="5" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5" s="5">
<O>
<![CDATA[环  比:]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="5" s="3">
<O>
<![CDATA[↓]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="5" s="2">
<O>
<![CDATA[2.4%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="6" s="0">
<PrivilegeControl/>
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
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="192" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<j7c;chPYe(-"VRLrjpXcSrSZlQ]AUPR<-j[8UY,W#85Yat6(^<"P9"!CDsL[+%C`<'/$&'!
'R45tqn&+bXMQVNa`R>S72Q0gZ3R#pCRLj<QbC_:iVdI0IpnI8%E'iZJ/Kib#OJhWn=jZdrI
Ai*Y&)9RUKt.ha7'R(DQYmsd$"_F3sJ#qrHLr%e0bS$I))KF*?`X574_@HK"+HZ@2o`"T%mW
;i5-fTQ*-M/8Z2Iohhdp>UF3&'(#]ApWo7M]A(1R0IhVVLL46GsV6,@-M-lda'm_e:jm%mB<Nf
^alOE7=R$E`b\u^riESkY:!bDT9RGVYZnVY2q#<EiK/L37\j^^3X.^0*FS;;6NXu3)3@b?(N
+*F269]A`pqD!Bf@n(YQ,s75[rP%&jrF0cuF'US/^<r*n>4'ldZ7]Ac>3a1_>l^TRM)>:Vr21O
OR_AI1ZN;Bq3MFj;eOl?8/Z6/nu2[+1F/Q!6Cbl06bap:GU7G"u2Q^R5&HdHK_=ocNcM"kLL
l"_UoJi0"48,!g-D:Te#EcEa?ja!L^k>c?C6pr6/>E@2P$;@Fp$i?<(-Z3LV/$R5#WI;.Bd^
c=q]A?.0g3AL=jV\8-Rq=%b?;&dbRo"rk$*ht1K.6C^*"?aeG7@QGs!f,%?Ec9sO.rO2R=K?U
RHK+3T;EDYi#ifHg!S$uR]A/d$Zi$.5lLo6\#CkV&XMmb2SMQ3Ne\(H&G)Y+.&NJcdtM%HrU3
<SSW/q9EA@mFAT*f?W0Fq%?XmM.+!Glr[tL7ElYE2eaBR=s(9`?)c"+;Wan;NjSj=<uWK3`=
RB:W&m?2D`)dAkt^qc%84OgI*kd#h?O,LrKTL(amM3dp&LRGked2Bad4Q"h=YQBiH5PYqSXp
L__o5MY#&6FjIM?[<S]A-EQGFV,&487fi32Rj=`hc-Ba4l#ru/?ql_,RPAW8md);\Q\6Vu=!>
jY\]AdPOXT>XlV0eJ@YGVp-T^n_8oprjpOBj\Kdg!7c-6VH0g+dBWJOeW<,lholR+s#b-qZ/p
E/^Em]AF#S0+g.q$-lV.GY\eKO*J!/_7ZHEg=2IBJ;\Yb"Ym<30Ei]Ak-.BZ*$'q4en*hpTiTi
0OO<e0CVV0N7Pp(/jlg;`a1'%VS7Jm<1NSnprWsA%%VR$K!SsR$2/.Rjf'9nDuaDu+H^Z'0c
+&?3X_4&]A.EsZhks_IEEF7QjAJ.fFm7^SHo8$@<d9;cp/_]Ae)BJ)V/bVo.orC&)g=aGJ?S4?
?ig23OD_e_-&j5RZ?J$jajgR3;=8b(Yc9M:7%/?@R</E8=M$]AWgWuqD/FI-1KRsQb:qHN781
9df.$&a]ASk6@G]A>qp-_lH0@GX1NH,W6qKO32co"-b/<>L9gCo3&k<73,]Ah^-5sbG)BZ.o]AF*
>aFg\h+@M0bi89]A<hq;rJ&PE*Wo]A:E\m)WqC^%g_&V)1$dZ7^mD@\IoCB]AgLFTh<j8iP!Rp/
]A33=+8gB7P/[UmH\I"aJ^c.i&2n#?lGE/JK'Hd,@A&Q2<Ro=J<hS-8l?_AeiHXJa;]AjnQ&85
BWa54FfToY4M9V^,@A-jOF`hO^!OB^q;$8m9CYH4mQslHrkV;5fZbicuN$,_^C7n2<2bdSZH
/6UPM\s%!Yf?a.a''Y_*J[JE-ioE$.Pnb2FDb>gd2`=^8NJL*NB[U\:u%(SPON0]AI<PWA"XF
VUIaMKpFf`C9YG&rEIhKFQcCp()Mn[!d*0eAo00mJRrF0s`GXL@hM;5br[9(ZquV9RmC'."c
bGUEmm_K5<XNjMj8so*[pDf]ASY&$d*F^+L>)gHm3'Lcj\/dQjc&8J+p>;i%Kb^4$@H8hK"#8
J^rhI8`Cj#;cHc*f**oMJ=_N/FF?Jh\jTB&qXqO"Ga0:J-aq<l0-6Nt^f[Qs0T>51)=M=(l^
;Y$L#G.*YKXu._?c,6:_#McEDF$Kj;:T5]AK-uqn+'V"5Ad1(n$3F%bB'q2\ePFpMQXguh3WA
J<e:KhP"0k*@R=`j2te1[QrZP*A9`=a=k92Lo1YrqMr)hbFhs#c2#\jjrm0ul[0Ai_F*"\U!
nRNBBpd'botG=OnQ>.!4S65B@LF4o2]A;cWj*=hea"FsZd=#.$:/T0oo/;JfQsBdVY^C"I^.R
Wc`Wq/^/dDnBCQ/$NlR)h#K&r,?cq=J09K@_W2%pG4Bn4.BpfB0eU20ca.D?5<\VP=GS4U,J
;1[f6S67EX%Cg79fW)_JaDk09^Q4Y8RVO(e<j.P`6WJ7AVldE(oU!HdTk)1@A:*P><r7C[5Z
*Rsb)[&-8"^=U#Q5(e,YP'2jZL<7hDbOsiN2-Gl+3$b?A=Yl"_UALrplt)30g7<?-R5ipmCK
t:<!G?Vm=XT!oDQ$Y>r]Au@]Am;uZo1HF<9/pNAJ[er+:/Znf:_G%dshJnp_h<E=Z?Fm;rC/>G
HVL^G87K;BW9ObKG[QUSS3o]AlYX7l`59_[_;le)"!:P)\C)'qRS3[NVT9<QkR>mN7eRU3UTa
\p6,;WUE^Y,r(<S)^Y\cR2!=V=N^lqaiXAt*ZZSDt^HM$ZnG#t^6"MHHL*,Rchkk(B(A",JF
3U?A(p>RL.7neQgZfPq@eqLr.,;Xp3Kg#'6TliffLu$ZiZN>_43ks:B8.sC9H4u,B)"/%M@i
kFK'M-LkYP^(%J!;`u'3()mmaCUmrI+r/lBWZSg=*[PC><`E/;Z0:YC'`GpY0KNc*4B_,_T<
OS,$DMlWKCq*oN(Lm$u#NK,>5Y=rXXge_r9nr7dgO?>iFcrR4cApfYBJU@<ds_+BkNNW4`4m
im5><KnqfIf5Y75FolcV/.g1V1[<80g,$_Ob:ESf$BFc\Vkdlp`\Ie2h&c&rf48R16,5_9+F
Vc^hcH$5qb$ah(l%'Np4Em7>l*)k"PB<p_11<U#$D8gEl=HgW/N]AZI?!qg7@p/K[_5d!`0ZG
-;.]AoB^n!fChrk@ml^7k='j'mBcmEZf%?C.4Tl[fZRA:1\*GM[BCAl^eie5#4Z-3:&iNiUC>
c+KKu-187.9iIhn(R$K[^=s[`'K5,A-[+[FO4[1t/_!?;m@5P.DKBo8QYf$/(3*s((sYCdTu
bEn%sMQ*J!ZXH[,1,2)F.d2P,O")Tl)dd\3,oUS9IBuW!u<s+:TNL7r#q]A9f?+"M6V(?bBt+
6JT4e,\OpT!kd?lpa:$%L5OV[>MN7T'>O*0UOnte*\>NSCoMYT&D(mAIMa,-NTc0.?&F">(C
fY44GV>?n%O!8El2t_psZm7G6-%ks$HVC(#_.B;ac8L<q[^&(PsZg?^_g,`W2=>6pZg_EG$L
Yph3dC7@kNL=0<I7KltCS!L8Nb4!]AOBsj`3^lOg;U8rYDf'il:=`g5@mll=HV^hCjqR)E=Xj
L@qRA>aUs6WKB@"-F></@Y=;ssp)7dT!0l]AD=.Vlcl[>L/U-0M;Q#DN+F-(pZ^Rk8;]ADnQ#T
P]A;JUKhXY&nohoN>0".D<#a)Go%.;@rb!%Q,B#>?fI`aAB*\I&U#pX5T[.9f3EluT>'"l153
\.Hi2d^N7h4Z-@d!CXC;=,AJTfHf/*D<)f(%djBR?B>8#%P/b(p_*[$\`h6RI:DG@tXE,+AK
Pu"7/IMR:(grSdAP1M0u`-UMN2e;Ku*&/Fp*sp_cbYG0uODR>L'2^55C)[0P#h33fth+(Y/1
0nC(We2]AE_>D@R(8(.=HR.,\4?*Kp%2)0;@mZJu_AVUNC4o8\kXX]ASr=DM2725Xf)CK7rj]At
#+YJ"W&%)1(=2`:f4-@.?lXqBfdti=U[=+^1n+X,N@9n?C-48pq)^i"]ASZj6M"BQB,-(s1o,
'Q<&,K(G8Np4Zk>B[enFM.;UG5,4Ee"o$K:H1D>L=]AT4p:Jk)!X;H`C$lakl'TbdD-/X5=De
*Oq>ZIhKpfZTRpAFq<t_f/k%k!%1W7p6?I%\MA4GtiX_p$%aW8Zmhtm=sQ$C;YUC@j'G-n(+
0gik0(s:Pt_g,\"H'2eT&bL@*ieBUhf1Tr.^K(`Wr%W#P.)iWjA@)KS8>F>`D.O&=fhhqp`Q
+E?'>&mi,Gp&G=E;<ZDW_duo?,gdU.D/oUFSU"GB$[(@:>ilO9*?*mMhpH\)dU>tleBtFGfk
QeMi]Agq_6R4r:n6!EtGh=&i(8ArAE:q8Ob;KpV)N/`A\;2'Qk3;E=4u8^^(h.\2QigJ^Q_At
R*mZ\DkdjM1eUZ?un6%#f(2FfEg"?Ngqs:M\g#=J!M8S\$0gUKtlK]Ais]A!%K+oi+Kg-ASG%F
C,H.Jd3m)P2:.]AoP.l[W@r%?F1E;^7b&t_bUhf@',!e,RjkW.)4#Gk"MXGR2c*M@kJ[Ji1SB
fDig!*8:3Pn;'!>ArB);5BJt^KX@&VtacMN\:9]A^\/@6JS`G4esA@hNr1TH8uEj8(9ss-l-k
U9fsr@p6XYEg):=;%hN$C1<fOU96%%0XT%g'@/el'W_=4$f'^Np5S"u4`o`M2E)38g:+de9l
*KK$ETX?@!6OI#An)Y?tL(OPmjmflqVWl,P.CVB,3/9F51RIW<sb$cec4YDTVL>E\<Uh=ur@
7?7G89U*ZuESS.eKi!(hD,ib8ZR01mS%(XA%]A>Kco<SMbWHT'\t-WU;FJ4F:kr0gIgkP!MVL
'rG@':<Q?9g1[KJAjJ:>pau-j*A@W<8WfQ*Kc22I<FqDp^MXgUjGeo(<2ZtB4kPa;6BrM5gG
\Kiq*W3%7%"_iJ?>KRb(+P[(Y<#$:-k4cmg\"5S]A.j:oSjUob#gTblN8pUSeRPi<nc:MXm\Z
nVj:K=`mLb[=N**S#E]AOHX]A4T/&,5DqfGagfU[+(JQja#Qm1\)G)=F(E2N)9S1mf7c[s#VGg
h2RUrk)9i`=P=ZjCD/b.0fI;a:P*j*Nm]AWLO]Aj=l3PF+?6"7g;IT!S"F/efU`Qi08>DBUj"J
s%N=g$N-4,aF+aH]A$j]Aggk7)TITU>+U*cp'WH3;BuU90=5fRWbtN'j/`e$aVZU4;l@Z<.gA;
W:HHf9F>S/_p06$Qu:ucQHQA/Xr\'?kRSfDFjJeQ_u]AO]Ae=/`LP@l1"ns[i8o]ACLCAKb#?`0
c_C+j1*MPQMa?)%fYVA"pBamj_El6qN$/-K!bm%[j:_Z3&)PfME/G"'p;q1pm]Ae9Lq#_*`%N
:W4`nq=$FsMDDL<W,cORb'o^UY>j+T36Hq0]A(1]A(fa@>Y@%>bYdYJnG00"nU=SrmkLn355-9
V7Di;+T[3<C8fU89<(Q@Vu5c>98K%DOa@I\Z*Ob$(*/I>M!m.i,gV"V+cp1>BL@NIe@(M/e$
DC/3dDY8ndmSLkQ<AS(.QjE`p/d%(p(LQWIf.QlL7T<3RcdAOWO:h`c9'fS*P$C@rJhKSDg5
6!0j8NeKi5>ZhnE/(6&Pf)-@:s#4J/G*K[5+82=2`'gOZ7rUci=?Wi[UHuS70VOTFElM#Hn+
qc'1b9+R3^nf:cBAG2$(H3T]A*"3j7De8aZU`50?*7HiX:H(_eK*Q6d;6Lci.-HlcfqE%XlbM
gY-/2b.,jrf+V+R"g2'D"'nJPHa7\GcUsG.-17pf#A5bBFBoG]A+;'74p7Gn1M:Ne/[!?J]A-A
S%Rf@aj%d%Q9\X]A[g+0.b@LR=)>]ADpG+AS4QPJe::9j/Y=Pgr5j2^gmN.V[_sNQkTl*`oC^F
?D'GFN`am[59?_t]A/eG&9L\re$-/T\#m0A_Upc!O<4o=2k!:(LQY6s(PK#Np=!d-CMiACETW
pjt\#&JubW/i.U#.n*?]A-Pbl-`BW_3\ftG([=WU`hl$R?ln4;-UpHKaYl\bV)*mlQVF'[7gU
jFMINZrngIV5m7r=Y0rpiRb':!SWK-e^Z7sKDh2kR^6]A7*'C=71%4'^\/F)L9DDLGnFNqc9/
^`cVLW=A;`[]A3oS]Aj(DZI6Fe,;uAu!#4A_9RSYD#H#Eb/M]AJh.RP:s_Zi3;0e2G]A:$d`TK`t
mfS]AjHEg4frMr'VKE+@&&s%^)7m='e_O^8r$`S@^p_Ogl+i'<!g9SP:S8h/=5d<cmhT%VZ^!
r^<rZ`Z)l,j+[!fc'r"*.O2BSHM`5^\N0#cTq&.CLXDJRhe<_IX"PnXPM@TN/r*4HQ;aBWr&
J[sXU0*O'1u(LZ@JDrG37okBPN6pMD0;B[&uJp/GTTcO3Z1@/Ssl48fq:G21:$B$oDH]A]Ap-"
uHAtmi'Y:1!:olHu+,ec[a1c?\kd^UJ`E#7t#64PtTRObP>aBmB\Bfh[=PZRb4Xsn4RRG3?b
]A2QQtHkE?:#u./n2DnaoJiTd^Q0tFe"/kZ/=DgQ)IiHa:$WSrjJ6fWdggH;gdrnH,!ALr4ZR
N@@'fkf>I#VLlZjO^Gf7?,3b"N6V!dZMU2PrD!dHRNBJA+#IhH,;V7P[`/9<Z<rdJf^_HYfI
_Xkqo6^7MLL;ljs2%j'q/bX##Zcnr?$bHiJJ:Jl1HS*u$pf;eBU7pS$?#-KCsbc2\3>PD_%_
ihQi;fPQX`6SG8'I\O@Z+R0?)f-Fd,*I6*63u[c0s=*TOhnbG.]A"I7','e+mWI!7!-9j++mp
O,-RbM$,m9?ebg0Jgb%ps&?K.ptJ<StJpoZp]A,7;QRUo%0?9MQHs%0gCih</FLR+N:UMmXV;
a2WPsTTli0[.Gl-Q,\]AFWl+JrP'G)D&"8XC]A#5@:J9$$+_7$b!$9GsbOosDQ<,)&R_gU%R$4
]A/\o\GL`oSu&VV9HhBPro\]AhVnQ"^k-c-?&ghpe3Y>#>t9QC.&_c5HPI-.ZB^KhrYl.nAN4l
I>YQaVJehN7W0G(,.6&^,qt_#]A-e+K&<St9oQoYBEe@c:)SE[VM-sb/fG9&)k5c7bSP3<ZG_
a+`FI-;CuXW3^64Al[GZbUOQZh6<:VJO#]A>k_)&knZ1#40C-i+[\%?EYPk8h+1!3`r.d_U&>
=\%d=<\../!mIgU-:Dq;6iiiMlW]AHG7#3)\Q:Zii!QPiCL?2":6:r5'\/l#jQc;6"e<c$d1:
(/6Lf4br>#rFUSU@g@q)144k`.MQ-g.a+5uW&^b6_.d))&Ut#-d&;>#,P;RPVo+1GB+EXJPT
!f3b15#Y,,aF?-)\V2FV@Ta<`iP6Rc<5PSB@AE09i5/[1Y'kAsn.TDbd7RL7t)gkWHon`']AZ
potfuYG.\Lo-<@s:VEU9`A/=@D@?:e0r,EW70+?3X%d!gl,/3\:7^"^t"Dqg9,G/9K$`QY"R
kkOXC'@3=jFf#ofmER"$9U2Lo72k!Ak4aaI68]AZ67Ij^H-?#@4[&Z:ALqgg*c'SS\9PWHFYX
*l=)V\J6ZLE/$>')>CH!2.R]Ab&A8&HbB;hnQq3jbOOR*Sl0D&r7Y$Vg8U`%(,/aPa;e+puZ#
)J6m]AYYSupED^tnHi$!hKfdcg!92PB9pGgC-3^PpFtZ(!#&22rd3uUX=3O61nQjl#[U_qr1.
+u!3k>KEit^`bbu'*U<u#-0$`?o^_auM_EH]A&^k?G]A*Xf(&MG]AbTUj[17gQc7`KLUD\?_MF2
c@Y.3?g$fI&'&,h=&tX8i23k7u#-T;T=6CuBP:5fY4?UrdPSIbXB:L-L:aC9E:69aXL[49oe
=EQ50W/MNZIBY,ONsPQ5OKYSYY=34P4SD\5&bU3ZM/k>[.p9$eIupUpM?h1Ib[s-GPnqQFVN
<$%oT]A/[8*fcP9AVTeT!5^#K$%^7Z+0MY]AYA*b6;mT7r)5nU?gc6NNeF+0E"_+[lo(tj>#Q7
:JK?KSRm,57"(R.Qc$KbM&Ik`=Bnf7*lLBn!bR_0ECdOLPTU:6:XoG#'JnSXNCs*ND+;BU/c
Ba*+tI%1hDH]AX1*'Ok^62BjM$Y@nI<%n11Gh.WBb;a=f2>NSmfJjr$?_o_P*\[J%OB!J*iZh
P.#a%@=ut0A![#5[pfo2:n[eg*/PN:eEA!/c@ZO49&(g%n\*DXqL,Ee,pN:b1cXXY@)Hfso7
60a:4t@Z=dT^/16f#p#jbi)=\_4HXRmZr1Er^8!#oYd4n(KQtilj*6i/0lEC@(9pa]A%oh`T3
$2g.;\qQ`47P@B6`LoeZ7:SCWD/BH$q*Y)E$XiI:rk;mDS@cIfX@8C[N>]AVq/6<F1=8-SHdE
'ND&M]AU[;`:#h]Ae7r%4h+`(Q2>85cPC#Z$+i,eQVk<h-GZ8uO*72VW;bLYnK2'>I)k@3IYi%
_*$1`b7rYA$q$$?k2E7>W8oOg,'K<hJSYWsYTXoQ?WajH?rXq[jJV_t.IfL-L')KV0M%*lu$
KH0&24hDFK6969?MfoieCTP@@/#;\\]AcFfpC$muT)D^b4,m(@Yc25"N\KV-ZNJgh_H<7#ts\
HgdYi_mj#k@q9t<)IYm(bY%+ED&gSo.^=G$dQ`Tp$#EdRO()urMT8l5Qkit0S.Rc"LqX0J()
ieH8X1nhC>8dD%X%%+3FipU9D3h8gfr(`kFk*#nKY=T7JXcj[?lNM_BJ)Z,CB9;46oLMAfm6
GGi->"U3bjn2tAGQTIAF,bj2MD6`S)Z#kUr%21$l5ZqK>A#.-8\Y86D*,&qD#*]Am4:c,.&(R
oJLWA.jr<k)Q&"*op@,"fL3Ef*J)g*>='/Zj-fK;igDeA0^^+U<6h']A5OmGnbM+FYU2HT!i*
%">TC/+qn]A<W)b2eGbnn32I6#I(oui4BCg-4s5HI#cgNq&WC6R":upg[ojhlpDn@dQK?oTGQ
5@IaBW@[/[mk31ClhD]A[Hh\W^aMp6InhgD1_&-&kWuIN4]A.iGWhkYpiaJ[%_D4AZQN/Dj:O[
KFiqheYAX07SMi2N:cn-_=bk4o?M$Ic7L[j?sYs"-aboJDFXq,j4g@0#9:U:tKM6J-Xk3)uQ
^Ur(XYZ?62N!PmEh9a;F]Ar/!o;$lb$A_:KV?(XF;\]Ak3Y(ljV12n$DqSU4h@ZiLQK1&UQ9\=
[$Ghc;/$-u]AEHTA08<S^uX*a8HE`_j`MOIh`]AYn<a[5.P?>7V<bAUPpmYj73burb\>sj70kG
=Ng=]A+$:Sqe*P:W@CLf+b<M%9YJ!ar4^<lhn\U#o?BS]Aj4V0d6;e#!ur&F?f.Kj_*;es4gCr
aZZ3A?W,7c83@_Do&"801QG=P$ALA[VD0qSuDkCR!Bguom-9J2+u[KkM]AlAC"&H!q3QA'-!\
1a&@r7)`o2sW^II[A.&b/4XP<ITWhQ437EHp+#5sS0QZ%8R=^/!]A>]ACA'Eb%o]AB6f<7T>+>R
'_"Wel6Ip15b;Gc#FLKYkMF9q.Ep-:P5dXjGfC8ImLMPeY^b!IES-;h(,9VuL1$K@8fK=!bp
ks_h4l]A!OngRi\,@/Loj&DT!1EO&kWH.40gC!;.bl<3:`)s;A5bCH)T.>QAR>hR+Nc4LJhS2
'ZNEGQK-BIdSB,t>1Y#Tr`Jp)$a)Tm)j:!D&j;gD:,WfLQ\md6\j/Y=[<Wr,:T&jMVK>/95G
&noaWb`5dX>?Gt<rHZNl<HOM-b<!MMjOHgh2ae9ZNg0*h=rXAQ6MDA\EqD;l&_h,_N63@@`g
`@5Vs#$,p60aVVKVT?3KcCpPmh]ATP2)lW7&mHHeM4h2!dSq3V)^\oWcK]A'enbh.*+*\D>W%2
k2e?jO1^!W6qF2eb"A]Au*lB2\R?#Zsf3i*[T$Yi8qY"R52o2rHp`ruf%t/7CWW1RT*$@$f1W
+j2DXAZB_e3?gp1cA3o!<PsEO=]AP--4Zpi<Wp1C.,_8XWDd-q&VgY@E.`2&hKV+P:/u'X-q\
j9-FlLiiuhAc6>fBWU!)4aRmLD0ACsRQrDn<XZn!&csiFSogt1S2Y9#/&Gu'%@#h'diM'Rs7
CJDqFd0ohVHst176^;UdFB"fls#(A]ANRF["F3hN<:)m3Qi+nO6f=LXZH6C(BPICp>V)5&XN=
a.G[.1d[07ZtdKO2h'AIk\euB&gS2>;\Ic8:$Cn3f>4d'CmSpnB<d9QG1T*'>-5eH_]A/m2Q7
;BqdZq_`"HA9CEeHY>A?jgJfB2^<(!$oMC\N`aKNknbS&Epn/^&]A,<*&NZY)0!\cX1`lMR68
fJHc5+DReRM]Ash`gm?PFUt(3A(_*+?:;7N^"c3F5r&r8*#_ej@^QeBj$6@&nY-cbZ2'O=?!Q
'ECl)=)3lD!D]AP+Rf$O@$BW?*bLORQB88quX)WD&AX#A;_"\ZT_A,0^T5(AFTdJD[D7sMZkr
;WrFN--2(Z._2D2.Ln,Ebo40:(LMD!qJL,+Y2nM[5P>7S^/):r&:<unXceiAk`g3:,[jQ0[<
,LO)EPSUmpC5m!'->mjMWMrUS;ZNXdLM=("\1du?I*ZB?d7E='f1X+@.j9Fn@!Tg:Rc0f0e.
Q7oG\M3@6$aTMaW:iiN!aEX>%]AMJILonc[/$SM9%,LOK,Y_kn2h^$:7Db.Z"fa-J^$B_ftRp
#><OcPC,b,:ef^;V]A"(b8!r)PO-#*NtEgYi@#\nm^s*;i.D6KlkC%HRGKL6FAuin",63rI[p
T?;-T`j/tjED$\_Lo.s2K;$9lNK'#uUrg:D>c6_Ih"R#lI$X'XuIYLTCkTm+6@9*`PZkfZ+:
d4O1ic.7H/r7Qf/.87NMpL5YHh+cJWcnR&]Aj+V:#ql&#2c8JqDC[o\Ga#4Nmp"40k*429%UC
fI5L7]AG!RcKJ@+m_1qYc>>$cf/X(gDd-+foV?"^XS)'67tT-C.H)ESf*Hh75,(!tH8<XJ!Ht
_!V&9\o$-'(/@faA.6gHgbJW%#$eqY4Fk`-<ua@XS#iY/0'Lg=c6JA:aW]A)kWuJ#["OAm2Pm
qq'Zq=tR/BP&\*"j`FPSh0h[Sg+s3aA$RR:%^/8cn)tZBc?$;G^(E_(;mbEEi=?qEmT,B"2V
4RFSC%peA<Y[3sE>KEOpekei-@hK0T2U]A0bJ0K)GoIF\tR8$e.:"O1<#W&BCZBa$4</c+3Uh
'kt6PJ>[XnO&EJa3uoJBj&";d50q905VCCIBC1@5]A(^Q=/tnfgD:pCc88OoW,a,8+sNX0XY;
JY\fMm^h<;#2doM9kggD[r`q'eX4/aYJWFM3rj$EcE[tZRE)"]A@IQn>`m>U#/;Fr[j7#\Il8
)2]AP2+u7Z`cikIXpC7i"dR1/u<iJd6TUTdg09S(E#l'uOhf)Wc)Hjor>t;\&74//T;93uemn
JW`5Ng*>6fXReG69glQe(X>.a'%O`$%h^?W?KeBLj^>NsTOeN06+p[q1A#iWp"")Ng]A;>M,_
*B3"O5$`B"2NP<&F?Lf1.\$gI7ocEYS*:dm?C\;rHk0#RoR%lnn:i2%eL)!<G!h,f=]A18rU1
IAqAk>fN(XIOhi-U$p\egjg`,SCL1rT-fhHAZ0JZ5al7&)j%5EF1n%>Jp6dap^[-RJ5j$gJa
Id[1^M:q')nD^ZNY-nOuDC"_6<>YsN3@588(M3WkKRnX%"&0j_?FiSfEO9&P18O.K?*X[A:J
U[RO&I!HkZ_HleeE^o[m2YdT_321u&H%lX#TB;gpM"ua`@^WLd6ba>,mel+kol&Rgh1@!tS)
K<1!1\!l>AjDf7VTI^dmWS@oi[K'1ErEQc*1Ah3(uHAb="]A3LDtW_)LJrV3?&Rl[@G>s/KiI
(/rr7c]AP?FX8*KrhdA)CI3Mp^q*YN4DU[Qs[o)QPWY=,1g]A-i5S,Me#(iM[dIYu-=Us*690`
eEuN$=sk2'J#91@Fn;U?]A3Og+Z^guQ(OO`CRtO_6mT[nE*fssr'Z4=faE0+rYsSm6tLHOF0R
L#$4&tQ1A>N`ZO%g#Q-C)UgPnLBGc@a^2ip#n$r]Ae+T&Fk&3.Mmsq/]A-OkOP34A?2+Z1fEkE
AP?Y"jN/p4.E@-=%q#;Spf*YP@br$8pej1SDa6hb6$Eo`JsTedK->IMd"Ufe7o6TFf>U"0`X
(!j.0DfccSmFA>ntfN*0#c5]A'^KDlN+"hNrS*OLi)'\1H^.0X^nsh4\\cEX$n6gUUUKEZIW?
GfOC[#Us_%QQ1F.Al%fn2aQH6F0H'G<`^?`s$ig>;UudK#??'JTjrc-1LI?)/o>Y=F(YK`;:
uuTi;pt\t8(HW^3f`"Y%_6=ukR6tj&<_nb7Y,s@/2D)79q?3]Afl?cJQbSKT8[mJdaV)H?K1;
"H)\aa=(Ha)aD`3S6S&Vtk,W:Kja<#L14hAtA)E`Jo2Uc,'4ka5n]AZbT6`?BRaWV(%m:No.#
PMtH"Z0R[I,LrW['Ze97b^3DS`pCmK#i6!Z33nAmk1lG'Z_-\5e+gQ"R(h<o"I]AIhc!PUc"6
m%Mfd<=TM[\PV]AYkKi'tB2Ao'((Rm[6<3L>a[)O/uR1?E'Yo;P=Z8FiM#OWYQa/f+#QZa*bj
<_'1tOqlE]A8^9JXKH?Ne9%qrC"9r:Muo?Em^kp_Sa7mV7#5Vhsn9n0jiEC<9MqiFb"=uA.-*
^CLH]A2sfT<oQBb4G4AqHX:1;?B;H!V%49TLatH5G'$kR*'<[73L5>/^rs=rcNCLP1Te]AO53(
uir^???bqd,_$Bkg=(;]A@S?aE[p?'[lH'2AEnW>ecmBVMKkD(250&Q+NIfH8V.4]A%%*SZ:ZX
%bqYMpLq6m88%#]AI@OQ_a`VFA<<SO91a6J4P.W5,\ij'tO*(.P&)!b2mEEj\(PJG->lJl2,B
Q/U.GO16UI(K;%7E+?iGtS'.q=7m&GmL*Q]AUDuT4B$lbQ8g4pX+%GKfBR`0ibgf8;GHnT4.M
4J6\DH&=nNbCVhU1Ed/!/)qdc6GI%@1kqgT4CF@Fo^lnjS0FLW#p`*T>:sk6_25cX;[rpp/-
]A_$!Vqq(8pX*M?MVMM@q$,>DY57iVnT@<ZcXso!n.5HCCF?oI<ioL$roNl4mJfB~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="782" y="53" width="231" height="119"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="08.运行指标-国际国内维度"/>
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
<WidgetName name="08.运行指标-国际国内维度"/>
<WidgetID widgetID="8a3f7215-9414-4004-8955-6ff7021a65ab"/>
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
<![CDATA[883920,944880,944880,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2804160,0,0,3718560,3322320,2743200,14234160,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[国际/国内]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[执行航班量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[不正常量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[全口径准点率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[考核准点率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[出勤率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="1">
<O>
<![CDATA[国际]]></O>
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
<C c="1" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="05运行指标-国际国内" columnName="国际执行航段量"/>
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
<C c="2" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="05运行指标-国际国内" columnName="国际执行不正常航段量"/>
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
<C c="3" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="国际" columnName="包机准点率(全口径)"/>
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
<C c="4" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="国际" columnName="包机准点率(考核)"/>
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
<C c="5" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="国际" columnName="包机出勤率(全口径)"/>
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
<C c="0" r="2" s="1">
<O>
<![CDATA[国内]]></O>
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
<C c="1" r="2" s="1">
<O t="DSColumn">
<Attributes dsName="05运行指标-国际国内" columnName="国内执行航段量"/>
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
<O t="DSColumn">
<Attributes dsName="05运行指标-国际国内" columnName="国内执行不正常航段量"/>
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
<C c="3" r="2" s="2">
<O t="DSColumn">
<Attributes dsName="国内" columnName="包机准点率(全口径)"/>
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
<C c="4" r="2" s="2">
<O t="DSColumn">
<Attributes dsName="国内" columnName="包机准点率(考核)"/>
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
<C c="5" r="2" s="2">
<O t="DSColumn">
<Attributes dsName="国内" columnName="包机出勤率(全口径)"/>
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
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
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
<![CDATA[m9>'F;s"#!lb-GhEk>WK(U1K*iq44X)$t2]AX#42J+tGH%bb?:+=b_I2ZQ6[6>5j&#"0Q/AX#
h!`-(Te!E3PO(XJmlSFm@V>0OWgf*4E]A/cF.f>pRqHbigao!H?Jaar!22N4jW_F54?hpoDX-
/BA9"[c'rh@N*F3:_BuBe^?itGYhqj(KoKG^o1d_ASptCM4Y1CODoK"PT%^L%@29Q!Y02:OG
4BLs[+2oH[s.$1NE_a`&[QTAfp.h"[siS2Gl<I$^UbZTp*Tu!4ug>a;!^5^p$74s41W3]AlaP
Mf%$IP>>90?KOQ@-oc^HI"^1b?0]Ad5-3S$[_l\ak;6`<'C(HuY]AsHC4^Ud>"L+G8_fncFbA&
2NtEHMmSZB;>8gLaPUA2Sp?ss22;9Vg_L+\<?M/fZiAkZD5EBBZ@#=!:,W`OI3IpR0MY!`jg
.tc:[>`2-n)0F$s?\6L<`Jsa,^a@g#d5>C?^5:qEc)rs1Au8Sn\PnQY)MCgFDscH>mpps3h-
A.[BCV)hU55f^QJ,isfF(k]A.c;)'@K1o_j]A7'&U4O-)nN?Q):E)VhJE]A<e!dp\Gtec8'$hV@
?GFC\3#Q640!*US';5$q(26k&5"L&.Nr^:KGnrD@*?7FY0<&,VcLM`I*kQq?SV#-/>m+s#Ii
qR8Dqq:hO8I_h7>Z%<P?DD*7*GCiO*MW^pO?"Ys9KV-6o,0hF6"GP9F47[UhC%ETD4Up1I]A,
G4'q4#6a!!W3LYm\O)$VV=CeS+S(hdqJi<LFX`o]Agm"B5C[mTegGP/+$3*C(*4.lflE2=f^[
;$E-GrnfXK*".\Z>r-\_"<[M/_]AHk1-2U>5t+ieqRhl!Kle:6C'Gb=)W7e`9Omf3RK`m!RYu
52$\/^H*n,U'Js7Zo_UPD,p92KZ5K^(=NSSP3Mu6?k.[X%`-Dj!A4Tg_$^ddK@*[;;.lTADq
IMnCOQ["jf!.c@q.6sfqnh%ijE)9<Jb7rf%H!3,DGai7fr'j[rNE&`-PaT1`s)*'7Od?0Qri
.[R<tpRBppI*M%F_m\n9FADf!#&Vf$Cn[cgbI0A>139dUpj:*'(T+Z0<sh_8Fa%`QX`MW2uB
C'=Rk=@S:cnoqP%fX5ReS=Oksopu;*>ZgeJap^ru59W\#:4aj,W#r#4deKL&1$]A"KSFUi#m$
ESX??WO^.)0AIlg$;Lgi6*KqR"\0*c>:FWSG27FBFiFBdtK3??.M2BJsXC7b;G$$\$:4V$]AO
eD1\5jZDD_5UfJZ\#%X1I(9CYtAp7<lBOH>NEEb2B>@;kNK4YW=;B7KM?gHgL3c^o=Q%p-0o
k^oj>mn=?\CoP'7gui\$\^EJ`m+a1qn+\%kesi-lG(eGcb++9<H=.G`8L6jmTe+A4YD]AB8aK
R!;1/7D.cNu\l%A]A2-feg"`6@0#]A!D634N\R`9:1.9Zr-bb^d*2OfR#4J0A5F/Hbqu"j*qc2
dQJ^<XZ`/VY@#*t-k&2-d5JCEmCn.&?`Ud[_%P`Nria$q^.m7Lo%pikaY&TuE&-bU(ATYq"o
K[1E5A>I7<ZjGYJ#V]A#b>(e=.,7p[=M7b9cre5Sj.I&7#)7k'?\EJPcNa%QpF8$K-B!s=r>k
BGbDqS"p-=WQX_H#VaBcYJP^e+/!s)GMhfM-U:9guiW,H)6_pVU6&)l\iFQ0=b^bZEfMl7o$
;#5?g2k]AeZ8FXjb+.hj\%)4tP*ojF^Mf%fO1\Ve!*&E<28_!Uq]A/HcMqq/%g2\*rb-,S>Fbm
h0XRKi-Q'g3@,%nhd2j(#9g.8!Zi''-djO49d:rH\7#s$6C"Yhe$n.oGhX^F:cE;V#e#)BYu
Wl*ZD.OjFD)SpWN7&>1P-Q%EI<FT`tK>q&,-4h0@)tXF]AU-Uol^q*+)^ulR)37(p"h7rI.6l
GZQS7dD1o<F]A/,ZdE&gC%!V5B+$tn]A5Cr]AA]ADZqcgoPK,FjYn.,[L2K/^ChtG4kMmZ^2X%k!
f>49>XJr1Io>6P@M^Y6764)1lF;rGb6+Z$tEFf9lr5s^/)(Y<34&j1dK$(kE!BPj1OgQdYp5
_pAZ+Zj-l$FtPB`s;YeE]A:/'8C2J2!fb?G'ptW3SVq3GJS0)E]A#<K[?!%j<#J0lgI,NNh'^"
K;,Xk+B"1M6oHX#@Nk_m:6'25C1_3l<,mM>J2n/HlR$_)(VX5;9Q(O";2.h(h^]ASU.DV-UJq
qlZd89K5+UZo+.bi/qTt"1^<lV8--qAW\kL%<ZFgjoB^JKdP06+AN1#4KUOHP9<1j-t##36<
677")NpP*k1#(ASdrQq0*,X.'D\b^QYSQ"-rS-V/-[bAL`)2<g&9"QPRBjLVQ["YN>24=gGC
)#`^4f-V8QXHLl"')EI?6L'!dRY1MPb[8L4dX0"oiWd^*TV$;;!B1(aP_Z[S&U(WWZmV*Gaa
H!J:*Za@4:CZiA:;hpRJCmjJK!cVCjNMULjWTXo355E75#6+?p6["UnkMR%VmXG=pb_cAkH!
6%@6C/qD4Ppj"I>XbELuUa/c#jac/rr.fCTpK/LV%j*SA84k;1D<,6d!AC(]A-5b9[*j_#k4*
\2k1:(4sh17OZ#Q%Bg6^=_c`j3#XW=B.>h5PsBDtAFUtBouoPHbKVia;=m#Q?Mtj&KNooT5f
n/+i3+0co*#rVT5)FQ)Z&73Fq^B9G*RI>Y?0JPf<7l*f08ssP-IGFPLb$+-=)3[q.Me<>ur'
^/bE[_13!$:TYXt8+6Z[c4np7'H'-J]A@W`,bn4Kcm@V?rZ@*UVp*,Z,q2LO*:jD_7fUps>*G
<daUc#9'B#`Fs\&Hg[4'+V#5Zq"oB\D%!14B6GTYY4K=AGCP@_kAEX35gQko&M4)d\.8=U\W
%Kcb#6T.fT+lX?3)XRQl0mk!53;ID2F3i3Uu+c88Vsges7[0/Q)R!e+j&S&TU8j`kFd'.i^!
HD=Z^NC0rH5>/a,D>(\M*:P94>0/p:=7^a#;rd=(>D5\&:jN#Zfso?IkkH`56=O10pt@i;W(
AkcIppV\KX>G\mRGV*L$U!8:3OZQk\3r(.mC(C<E1C!A<`8smk%1>QTZ=#KiE"Q>2*&_It:M
U*l&YGq26$3V34HA9Q$Bu*$fq8%uFI"HSPVgXpd62Jg>6<0%"1?h(Q6)O#1$U%RhB#K_1ON+
AQ-%GYk7H#?M.Cc<q=)%OY67WC>[_'iOKP3hEK:9e'k_Bqrdua`nV9"qWPi3\:M"LFuPR(h+
$AC%Yq!;9RAhGW;]A_S*.QU`EEV._Ht*i-=<q#l=k*1MBu:F"nD;mc%>3T<e[rL-18t(8:0_W
8:="2-Hf#ZEo.:%Yc9i3oc@)P8J7-I=uR1"q=$#27AW?j"`TGsF"<&aW.ZD<akkM3\uB0'A`
<c&L'e@GdkVNHm0(R!&Mefqo@92U7.lsWs(B?N`,o?V2ed,YB;pg$KWna"?Fm[Y3#I<RYU!<
qe"`&QU/:dm(N`d=/LltuH*P-nHad`:VN,L+&e>o[Y->dsj^b\)53Y9hB=F-(a,p7C9)d>Tf
l>5>2cJ*McMJ1=.RuJ_dWPmj"0]A9s;N307JoKJ?[JS,*PN&Wu314Iq4FJ-9-OOj#[.HY?HZJ
0Xg^Vqp$<b!e$i$%'=0<P,_996C4W6U94&ELp&b1!9+SfmDSAAJUgo'X$:#V@U'Ec',lWFa8
`dOK>-MW/[97hB@QlSLegD"95Zt<[A]AMKj[,1b8%.WW#fC/7Lu4bh/Cdp0(b7>2r`K0f[EK<
-=-V2'iLN4B`ROXW,t%bBoAk`C'6['1@?B#J_=7lkC-6$XW:n5uVZfq&LednQ4"ClnXr8$?r
CT:a]AQDtHk"%3_%a1399E#Xq`*!F8jtB_r!.i(WAL758c7\P"UuI!OAonSpi<658%tj6<I.%
nf!-FPAeC^0+ip)L.;s^PS0^cU,&]A[h#GRRhFO>.X[D)%C0."1+-<u,3-SWr2K7R^u,eDjSY
NqjoR(-8tN476PN]A*fmC:qDOJ\GJ[]A'CP9k>\;NjmCC4a,p"F]A>K==Q&YL`'?;9B(8T$=b<E
;Z\TT%LQbA!<HQm.u%dN27`I7RZ\)fX<@']A]AOai^RIn"aWn(6%3k'jZHc-CfPDj]ALlou\=VX
/7jKu:/g^aFFn!H1EZ`J246hA3F`g(L^4_G^oni`&.\CVL(5i&"+@>=8sV=8.>ip/b[lr"!'
LW<O+q`NsRP*L:tF"0/uE<pTE6m=X6o-cSBP+'e\kpQUjT"nJ/*UW6ZF%KaW/"TAg%fd[b6F
O4N'3G=c'!\T94G'h3d&PDB'ljN1]AK)u/6a-@UIBjjX6IZTE'KS]Ak(4$seB-e(]A!fk<uc;qM
hA$X2ETr@[aL\:!9F//1p2]A-/p8OZqF0GW)hl'^Ed$B)ASVU:d5d!@o8eG4&$2Qk)@"+]AL_C
2R(9?(0fjrM`0J"FjU2S:/sHfi4Hc]ANo<WE"]AiW4F:C%ca+#gR5Rj:"T=iN&H;^5E#TfsmV]A
kDGh14mdA8Kq'mC#1W\@HRT%DTDjBj0/qf'hp7>C4R$*jUl*hi:Jr=r?siHVf!8?_67F)4I!
PWH?qlr5$?sA+2B`2(Ki`laF%i_%k!c9A8?5B'L3/]ApuQdZ_1[dBJ`#4Xc4Ete,+@T_V+0^(
Ue]AuNaqsOmEJ;Y`KQ5J:aYZ1aV-p*@r\^$ADBs:H889W7bn^q/Z,chm\:CIH<5=7V<6a]A%Xf
U-e!0&V:2_6d:Kb/fApuPcQnRBqm.nbX;8-*A5:0D(9WKnL*tAr`aE1!k)@gU`/bRbG)@Z6b
@BOVS"Q3ps37=^tK(Jrm>cdSIDkb``em;=C,:'t-?5+ZaJ.2]AeFW.%s(tMu]AaCm-a%WZ`JGd
te@,GJ<En&`[sMUXP/+(,r2l:NP`Z2VOba$:_ne3:&Em3tLW%C;[pfu;LM]A.iS5IMchdil1h
m?Y3L[O:oTk7U.Q_^9To&H[*JB]A48)%hdU0)m9dT5Q7fh9_HLSGDDGL:AR15=EgkP')%!sK`
d0\UMMQ]AJ[Al7C`o?7gC!:/mHlI?WHddIjqaYk'_Ui#)Moe_]A.&)<tW#eb5/n\M96nbZ""Mm
1Zs3n(>1[hMK,;79_6%Z2oe"!?"dZ+4d(@_>^dfYPX@P)cOs8#KFO2`JAA$Q"E)6I(2ZbCaW
^-&`2>N;EB1]AW(Qib>d8cd)T_UeP>qYc&+9[,CN4]A15(8dDg*tGTDjk"&Jpjjhq&Kc5q"n]A\
O)'q$6OgAJgtID*3\^DV;lQ:H#37daC1c=)s.(cnWm.i6?"9c)mF"LJ`*P1!p)u)h^GY@B/B
A&&`+j[HIeu+ToD%nU-8JN8K[IT_DJOhta2KLjmupD\I1:Z&9$o,kG'P>)@nbkB$D!T9E!U_
8KKa."S!go$bbhHOfC8kGK_A,",1TFuaG._)E9#!J!'IKN`)&$ZG"u5coB?k$IRbVfHU#qNH
48Zo`!PcKpm2$#RWgH;tf&.B2mF&=rcek5LuhW7:UN]A4QY$4JLhYA?cHsYAL.tVbuk7NC$6^
qA.dE*t7)S\g9EAs+Ms"S)+DqM0>N`s&]AlQYQ7pR5tFj4#DJk<?8t!,VXrb#WCKjYmAJc)39
U+a<X/@\QGie:/V&0;8pY(`*P[ZQ?Db-d[s01(XM:Jrn2jna,$"fKd`Y2@)(%4u]A1`Y3_]AK]A
$5p);Igg6n8.0R[jk@amt.#J)-Q<`GO*R@sXVtZRcmpH'[<qelk5KBEIc&1KmeaYl5(2HCHG
g"p7.Mg[PYZb[.gHS.dFYYp/LPppKltHol#>teW1j>DJ7R\MRhXebJk+ElOVb,0>`!"I`[t%
Z_QetTPQc>,>Mai>PQD2[q$"'#i6]A2h,f#2QV^7N0(dG=]Ask--P'<Bk=#7\f82gn;nc"q8:?
W8_)LQFDqlCTA?F?g-e(m]A'H+&fLHl;Zc.-m>f<EaH0ZWTd(5<nhVe"[!9,m%t-/AqW!T;SY
mjU>g-:YS7_%A^lkAfDNA#I7Q$Tm@0u7o\>(%^g0hBA<liO-.Am\AlBtiU^)N:l)5;-^:Tr.
gA9!\WIUC?miIj(<jQ(+Xlp<&^&ngAq_d;.=qD+XbXdPF1oJ:N-^BBiPpS9`(B)hjJlRKJbe
c,*qYtiaWd(5&!mki"HF&b1EhlTmq7sV\/a`?Z0*CEVZ7I8d,CgTR<k!W"G/g=K<UW8pq4Jl
r`l_5Jo]AD?(CY02BkkWlfg$Mkg!%dar!;rfcIWju1qIq;:`g`UXQ/4!9nL3*VZW`";L8;Pl0
r=+":5r*g5i+mI/RG+Hk)(N*0$M2+lT''c_.:Y%>QUCdu+$HaA]Ac%LDZh(RuMFS'GKB#JOk8
cW,rFO_)p&,,k?LSX]ALO+)?%,qlAHQ),9nb[Hppm%oE'a0K!cmNh#:SMU-SOCleC$t,!QX)e
P7t,!UlHu6:V4rKC/I^F&!UZe]AE[`R9(a&LqSM6!WlG$V4=``mH!-N`\gO(''Vb_6,Vc/LD(
WE%pkp%h1Wbe=-o:J-N/#K>d1Ir1]Ao@'s6^fVghn6D-LO)>h?TGVXj\IUHkFf/pVT'R8mRBk
ogERH"1)Z83S7NFk]Ai42Ge$Iup[PX362)iK8b7_n^6=)8G@?YFT'BbE/U1[J2Dgmn,>47:6+
d>n?r?J9L1m&5F+$X"nHqGG!gjNh?b04IkW-k_h[IFd',,J)L9T;nI;Xc81/bB3'k/I(Q#;r
F9D(MKN?$qjt/]Ad*WkWju5q4Fs-1K<Ds40,3'=\@u5W&\&0_XPZ3b'4A3>AlV^[DZXI$N]AS+
>=&WUQ#il/0ZL;ed.3$`mqW;8&-%oT8+Kjjn)V$$B.:(]A;jK"FF3Q&=@lJ\nk=eOd\e*U6em
u'd;>7@]A7nFYi!(7(?Pkhn7B_S,E!F^IXg2HbCoSfcauMtn@kX,=>Zg"/]A-.!e:(&_rl$f5B
Hn?g,s^-7[_E4lW_#XJ$`LCbE!e8'maD,mo,1]ApIhS@2@;6g!VOn"N(2)5j7["?;R:gG@13#
6<1-c"D_Z!h6fhB!llr#lt\gTHdO#)Gcj"!8keYXg95!<MA?CS0simB-@37iTK8s^4PK55j6
O^&BAGfsic-Y/T1MGL[L9q[%!Xg/D]Ad)$PZ@RCai0K$@%cD!`VZ-_X/"m?9fs2(^b7T%G31i
b!)YKuP4QiiFN(l*/+dr(`B^bCF6*d^aLR(*kJ[=?e*P,m*_e!qNh/f!UjR7Hm<qGfJDK[N\
9Z9#./)g3DI1Wgh'\ZrD#"XO%ko;EYhN@dFA.F*i;aQ$EVf_MYm7o>o)Z9&h-M<-/nPPV=i_
S/Z7l8ao"bUXp`<`#_$D,oVM9C14kUa$[oaIUe;/m#nGju[@^c_J1V"c[ole[.YA*r^2Ml2:
irn2`[1&7`W4'l0$a;6c3:uME"1&&S[f/+oQ)B,%ArEJ$*'P`hHjCArHm'&RFeQH5l/6?c"1
Nt0MLBIpknilJ3QR=B!mJL/:oH#qCu>c6JVZ`C7PtrOA1CYY>]A%ad3ucS3Td!p\Ub(mTV39F
t6!-mTm%JMa5\6,,@_gRm*k6uS-og\kC/hs<461'k+@(WZ&BP;SEfmSZAt%3(c/,Mc;1fD#2
@[>!$I?]A&ljPOh/)-%`BFRloO_FPfkkQBBH'ET8SfBJWeY[r?2`UgSFRRC2o\S1/"&oJ'.;(
]AJK+$dEU/0"OI,Vs",OAuF0,]A/&hQ85P`B`<d(k^kFp)Ld\>uSgRB&\*pb\r#;SI'8^1dj//
,Z,X]A*.hR=k]A^8:7rKe^#a#;_)$R&iq<Bp2+ZgS^a?Z>3()OoG'(>4?:+\H:3B&?e),(dLU.
&g\,1gEs=#+3/$ADn`0JI915)#u3/Hs'D#3obQ+n.pXip&TCJ:$._A4T@;!'?[C24d8^S,S+
RSmI\=LfFjqMXZ]A#9GuZbr?#QP"Mi1tR&79cX[`#,RLjjd,[&Tc7,\?4ku=HM3Ok,(@#Y^o>
`Eq&dF<RQne@:!U_"1fKPkEfW5XSe3UI4^2bPYi+rRbJ3-N>1H@?st'oe#",m&=mD:Y@l),M
Fm"[r,AS#YE9/K&<+\&!kS.pS#-?,5(4A'!><&>66F75KUY_jB?j2TcDe1^SToQ109AUKGR7
dtZtE2B,OnNW(gP@8%R`ddP@^2-,^m0\)No[4G]A^IDEEjJ0I:8`I>t8OT%BK\!d_&Eto+f(M
`saE'%iKQ4k60.O-RMN`Vn[;]AM(CmSH.MO6*Ke%JZff6"pRHC++M3"T)O=#lQr"o3IF(%+1b
bY@KNfXFj<u#$+G0Q`C!m3<L;=</HAoii/b-]ArFGaKO>')L%[\Z_9o:tKqW_n_b;>=.YmJfO
3fU1E!&aa@&$`DUdARq0&9C[mp"<?1U=&WQLPHeB`3]A.'@3Dq_u@sJ5.[VC>Qbu0O[$F*lZM
J$6AXt.Q4:F"?l42Y@?d&N,;POaP"e\Y>*O^<4#<]AO-g8LE0.*#[YPp`Gl.NEYe^N'IhiEWT
KoD7R0&8JI$uSne=10&h?`%IY_T+^/gNuW5,RRN*%@g#G75m&FM=<QJb1'Yo%;3SWIk)RG^$
O+<fDkOD!<~
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
<WidgetID widgetID="8a3f7215-9414-4004-8955-6ff7021a65ab"/>
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
<![CDATA[2468880,2621280,2743200,2895600,2926080,2743200,4572000,2743200,14234160,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[航班号]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[飞机号]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[机型]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[实际起飞]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[实际到达]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[延误时间]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="0">
<O>
<![CDATA[延误原因]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="0">
<O>
<![CDATA[责任部门]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="航班号"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper">
<Attr divideMode="1"/>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="1" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="飞机号"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="长机型"/>
<Complex/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="实际起飞机场"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="实际降落机场"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="到达延误"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="不正常原因大类原因"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="7" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="不正常原因责任部门"/>
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
<FRFont name="微软雅黑" style="1" size="64" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border>
<Top style="1" color="-15378278"/>
<Bottom style="1" color="-15378278"/>
<Left color="-15378278"/>
<Right color="-15378278"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<![CDATA[m<j7c;chOnXEBo]Ag<A;H]Ab]A&*RT_7u8h15lZ)&J*TGbS3H@]Ab;U88\W8:ZdAXfY:_-#K;C6q
A>WN)`/4N"D.3;PhG\>V$IRLmgR7+UP]ACb;n`K3:0[,F3_G9bk/gIdm*d+A"U*QhKqEO=jL8
uj(H,6'g:[#R8;g]A\1&qo^DVgE9d8S9'3G20=3+/qm@Rt*iBCMVim$*,A0)[faUW+Z?g2[!r
SFT"PCK`YIp_[$kM'l\Sf*g_on5mu)4Q*Ja-@SSI_##.?P'u4$!Of`VuM+_T0>KueD\6]AB>4
7\"R^AuW))LXgtjjZc(Jd4-7rb55P9dY<LKAKoSnk3GUp4?HM-E<lbFAlg)j!=L+?XZ4N!Ie
mq%m%Bt2An]A/X(!j%%<I#RAZgggge+[qYn*jmKoC2D2Pp!<:[D\Fqcb?0WJL#]A@.QcTEN'mV
2R3U7nsB8_@mHmkuJ//0loaiVm.k_B.N*))[fFGAr&VWds(YpeR_OH(+'(7UN"s%!+^uE?p8
dnUnWR)t0D]AGhTe.os;lJC)7n740-7=7r=ViHFu?n3n[%A*"Ws5,ZbaYH8FMl$2bW8?Gtg+M
g9XFPhj<Sn.^+i1qZ+eRT/4R>lSM$p7XIH9*U$+C0*jWHm2LZkV_8^]AsfOiGQ?!"ej\mfZX5
<KbfVj-NH0fi\+iKUOI\jXnFhn[Pp!,H5t<R>!]AiB+4VIof<Yoh?E$$Q)M![?oVl:,(Ht8H<
PI"TIn8`9<TmP<t`*&T!H:KlQ;'G7lV^'rYb!%rTb6":$d(N.8\$Fr8"a/^[m3A(>>`RR,:K
cA_X%lTdKA_@B2\[bdbF$_I3P44qN8,W2%a%pVgL%`pe3@HF/f]AEd/F:Tma;eLr,&Z-7),oE
De4+)Be=Q0a\3;dV47*65)5i9gRacK-"$*:7>3K*8i@)s?\Oc:DPrQ^>#Dt3!?j6(n3f&#AH
e%h/U#AC27g/bmE]A*csZbC^f8C.\068l]ABk%RVf-Wm3p4,6a^#+XBrR)c/:ZX'.,"-'"pml/
Zl6o.`@X+a`td_o__QM6-QX+<#t#VG4n8VBlnF.*kHju[#k2@6O^<o(;hP#kRk==Q.7CuN^9
)'U@>#]A)+T,h*_aLNWe+:75Z6^&5G%00\N)NI,:'O\@rO7&\X;c5&\f2?YZ[.FJY(A\06I07
.!Ufh?F$jE[*CWUnIrZXWSA8X3,qf"A3I2ICR*WIVoa33qmBo#DdACO;"11\o^Ak;`qb=&[X
80*W)R&"s+$7Uig?92WKopq*KC\_NKgi+<os;9dhl5,Zs5'sZ[g\<8ObIT?C=$YBm'B;Kf=V
2(c0(=hIgS*&'ndA0hL\+KK:@3>I+_X#Z09>*MOC]AHdtVUrmZU5o:\&J0it\B1p6d33bb$kl
WmTif0-i:lH!hCTuQaMV8gQ^`cB@QUP)4tn?%-\r^gD+R':+ggT->g;0E-hqREiTD;Jmg96m
rYCk"2pp_I:KmC\AjbHV,SG%uMgrG`a6'HTo<)0PBX[fWiEB00*o)KrlZ[+SVL;I?a.L.qXg
F")`pL@Cm8!q'gKH6hgnWg$I<fS=DI-EM@JPRfU7ZL""efpZr5+c/GFYIVn^sER5A(0]AV',W
qHcJnU_u_Sc_Q!OrKca'IJHj#"X&TSDHJ)R]Am'@V[50-S3J@RE8jE`Zt&8J@uNIkK8*q$q`]A
Bf_=ZLS#'Cm0-b.5G8fi?Mp<eEhWnI9%A2<O^K&K(Tie8;pVMJ=nAO5*:piMfd,tClgHd$9g
oDbK7Qc4A>PEl<US-e!6St??(g<ngMs4Z>?@OfTcSH*`hc=4U&38R,de&#n@;eR6<C$q,T+(
l!ugq2oR>'%*G9EAk"[PX^p(S;R*YS6mf0eLb+5]AS6637:_2&-1U,L:7AOa`O_"Y#MZpe9P=
,h$!p8.3$"Yaa/=i1H+b3pP4oM%sTeX"+MpiO9)PGtsele8%YEW>dK*U,V;]AF-f62oqD@cnJ
1o@sds(oGbB/k=cSJ?kIbqQAPWbh;uSS]A//9NdHJV9:?j)PJdAog=E+GN5CNtT0*<_kuM($)
nJ'Xqf<':E^3ah?:&L"C$\HU9&sS$G#MQtldSW,lZ_E7CIlNa;jQ?T4';_gWE,t`]A%"$N]Ag5
'!9]AS]Ap5*WkZ(\Lds8`':9bW[Ft-\s^%9WX0j+*Ccmj/fjLAoJn-]Ae8GXY>bsVN8RH0I?M1.
.5c&5-H@2+4O%<agktI[S;B4KW/a,8g?$KXfL>d)DhcSd[4oJM?Jg/uAH!1liLE1-ej*GB,G
%CAW3ui?Dp=QjEYboL(qrH?jKg>bj@S%klZkham)nb)3%L5@Uc.aa[NXHXe(m.P#F_?_@D-5
*<RI=OH-0h)Yt<X#V2qr4Q("cNm)Q(7!dWOteILe:@ed[mX^2Z"La[=bfPb&l!O-N@(G4<-J
Jbq]Al=EONcsIP.9_=>t.N=+cV6%tPn0]Auh;cUo0:r'tA-0C=9SlCVD;(;Nu">7f>G?pkl@'h
&P2G6<WI]A'Bl[@4Z.GH1jTSg\?+C53('l<XNSCs4sS9qIH1)44EZ(['B[YH[9SQK'4M0:[?\
WCX@4X$7UKp3+e3\)XR09%2a5o,*"X/T/WpfLY;o=#GlrA4'^^:g6%bEqU-j8RX:4phm^Uj/
`HqOmf&qT(RcDQe4Z'ab%^_1IJ7>?5=nB$S:ALC2<4-B"64D<l"T+A/53:aQ>AY&K7ZC%OT=
:Q*(1JX&MI.?OA),Z31c0WDJ^MV\!U.,&]A>'>;5B`[A^#5i#B9<:`Cl22ZU(k6/W-,JEJg7q
^='i%a=KL3$1aG1(NLRCL_O(^N;(mkE;^rmf:1+a>:"-kS:qO)1`YP`=QU]AYK)+*nrjh%%M7
aRHAUN.e7C:i.Y[qYi>Lj>29som[e(nbgMn"3k&1`k#mBkGp6J\T8X$NR$FPcPNsGp<'9Kk2
P5&Hn([P,CD=W(Hi@?tE+^Z0UFtT(`r79@",J23?]A7B\sD]A.S#;k5Z_p05h8Y>)Lh/h,`;(3
CaPbSNlN9BQ^&k8MMH<s7U-TKDTDKA&R>$$m=%^`'@B[cuMo8^tqF:b2"Z;'!tU-?3/NZ8dO
U[TS6TXNP!DdLVh,,Q6c$6%70$?g+DPX)Z]A3WddHVaXTK:OjrbMElk62AFI=o>6O8$Uk%B:-
b0]A[aBW:]AQ&IQQRZ?`;DL=TpGWjlqdf?D#]Ah/,p3b`!&,n+lW(Y:XDXI@JgG<iuWcpstN3s+
6.4.?;P%uJMlg(@I#kT3P+O1kC[DX]AVq^7B#caE/^pm9+_"<,uE_=FEC5nNGD.?-h[)pgeeI
<B^_X@rhLXc(Gmh>HPnHkaK;@M2ddcpuS"sSB(Fd%)(N1WLB[J;`4l==rhERI5pj"r.9&6@^
9B*;&uHmC?1_jG\qU+OQkl2;Y;,W?CN.^@'eb$,lk5o6Abm?G(=EoIodB:DkQ;Vql3Q<nK$F
s?:!RE3m6o,#lUK!dR,(A=sRG,_bZj?!&Nl@QW/0,e+K2)Q7PddVnGsGSJmP?%%QWKgcDCTc
OjM2KBpYfGj:MnHsYI4U+fLe<BY:amMT:0;'_QGLlm"u*OJUSb17U9*<sK$,M9KmVN_lBmf$
kB&:pZAF=oYEcdPbH4`J`<=d(-ss#&o9c!>_Sg6h]AJ8]ACDC3)Q`g0Y-rqlQ(b:3%P[lMYcbJ
/K2dEj7Q*&S=^IBX\kt]ARHV9q)INOriZ,a\Ef)B'8-`\u+dCo\fRb6?$U+\E@J=]Ao(79de).
RDk8`8#_UXoe.JUl%'QJ`F`JtqVfMI9maF!!?/+b;Q-TRcGo-CbS5W#i2^WH>Ch!'g.\XJaG
Yp<<cZD-;\LdeLIg_(>t/l&CPLL5og;#'rs@]APBs5_E-2K#kr^B__26sLtB;]A?\2$85foV6A
2FLgK)tu6UgL%V:<@r6!a%[nKG%iKGV>D5+ol$&jn3bAL"a8&-U(/eig?-H8o@58JIQAaE,:
.nXf,i*J,Af!1BXkD%>0r&MNFSE'OR.m`t']Ad&&KP*H;[FeFDkpu_H'lIA>iqKS=r.2'e'jc
CCiBA&GH`H(&i/U$bLX>4l5Ha`q_<?%4q%@2d[kAWn,..]AHe:q=\LV)QN$s/3^->/._Y5:V9
8>B7&UpGJXq2BA[D8tiPLJ`"L)Ud,t*JG<cQpP3d^#3b9l[f$1@;,<.A(h%L7"b'.ei"rlj*
P:h//LcU5l4c'?'o(`"J8PMdSVH?4JH1;O9I/4NBU"%$+Sg/JRHHTJJ_4j`$B"mR@Kk=L`NS
tgCq^/_AlD@nZ-jEN0odH&-OCc*S1.?d;TM/_U2M\OcY`"3b(oq'S>)>Pq?K/<13N!aW#^9?
SBAkP\6NH<0mc6E_6""n*U[(NCMA3j7q/S&4a/3cXGQ!%%$Gdcjo@enB*&qA%F&i_\r9`I6@
ibt,n?h&q<\I*/%jb*4fKSC]A'A8\g!%O%iD?>%S?L9$#jWBcG+4D/L`CuKH-!4&]AcSs#Bhf;
\/WB0j,1?k@mDLnO?7Sb'RATRUA#`Z?(%#$9?u9M4S13T,D+LAZ9h?rkNAR;I#G/*V%u3ORh
Cd\WZJe&u<<@"UQrHc>L.!hQ>TZchP%RiBqZOLc?!+iTTH3nqI(C4n%^q'122(Q$82Ht8#$'
q&A19lLICq>@EAlmlOHlCCPE0C]Adm%5USj(-<IuqA0$dQ0!*'c8<]A_:&<3opb[E;m>O\$EJg
u2pYNf4+B[4@hjFHiG#acj^[Q>+I#T5K.I6kmg=Xg(fO#5YUAs)"nd#tM@J="[SSYHq%qU+$
,F;SLU#KpBXJ45)0S9RH]A\Cc9>N.Pr]A,!CAUC$=j23^XA8V+!r?03&ck<'I;KTQ'"4MmBcn*
\dJ+a!LLTp`Z+8bO^VB84*WO@,I'Sm$&CBnpeK-'u,)cn%LmL1b_.g(u5`2l7j0TA#cXnOH<
ENg./^mjh@&hfA">b2Pp[r]AdZ,Uib@Qr--j/aM`B&/@hTrf;6=E+3gk=*abOY<t2!A['jc00
%E[%I[q1hDcu+($F_>!)fJF-HuL5P/HbJl!VWL&TM0^%!*]A`8>SUu-hi1Mr<UAP=VS_"9C63
:RZS8`s'X_'.=5[tGoU!n=HKKIprYG2rZOi4cL^!5<rU#;>B`2;QIgFHEJu3!*`79$KJ,,%B
=.>Ebbm:dI-E`C9:Je*A>j"f38M0RN2<_B_.Nb52\ii[T>C_f>hQeGp0[V[sX0&Z+aA]AZ[:\
Gudl&UP686l&+:[>L)X1;noXYO#*/1W%-fp'n@,kCU[96=s(Tq[6*HGOZe2f[SJlZoN*eEm_
6s4,#(_E%/ljqn'\l5Qi]AE1O9.gtR]AAA58":AV_)ao:+I]ASlce-1B0e[g=TF#Mj%ar[_<NR,
BpcR.8e4YQ6aZ[T6TJ]A4`o[[L@fW\GU2b4mb?k%/SfNq01u8pT%?H2VgugY56m=MpaIWo7us
P[N%D[#Gj'4h:-V`@@:QWLCd639[gg!t*bY/?/OFu(9`]A/ag'eNqgOUmeD0H94n%qZu$d1G&
8IS<PQ*Ncmd.EMDVgW\M'R-GD*r*Jkha8_G)m[I8L$qjrBq+QK5RqC[H2Z_ms5?.>H+Grh";
B+?!?C-LkQglpI;<2u*c67MX#?(Qh]AuPgE\(VQA2G-h,tV#;$\]AuUa;=I8<au+JqNJt\2UCj
/r\g>QT#.<HdEH,p_p`>eMYs=]A1sBUES[2,gF[(Tn2Fp$JNUNQ_QeoaFhrsW81^_`dJ,/D$?
04^X0#=3KnNWhQUGf&Ek@O*pIiXIPB0u=odkla#ZGp9Y2=#SEU@u)c[(;Y_>6fJ9']AM\*Ln1
?2(R9r+2\_c88ZBn7rPM'G6m8g7dNZMZ'N6$V%)k8SE0`!FjHbDrYGF1e<cafE]A=bQ@ad0F1
\)>PKod"j<6]A$KJ,$Ut>!PX(CEBFYdB`_H)RMPH1$h)!oo@H>OArag(cZQ#Ta\8b^n%FD:=U
?V*I0O1$;1If&kYlM_@'OT@TKXZ6lZNt\cm84JEJpbDefD"+BX\3TMa[lH-asZ6,___-RU%h
[23!fn+%3ATn%nm_g:s:+E9SF.&H(Hp*qH\Xm1Ll$`R1sS,'9%M2=G<n+)&GVF,G3QTQ2r7-
&.s=lA?.\kr>-%OGmoT1>9qA+mM_a@N$I,#p,9C_(>QtB)dp"2VU*H=\0bE$Z#;'r/9cX+XG
$g07;/GKMJ4*.psGMXVN!H8h8LH.2)$6@*QDUWq7H4V5hr7.p"]ABRMIP?=E`W7kc&hJ'3"Z)
o7;Fj!*$dg%joFbGWcgQ)F\.u2XH^mJPj2W+RR7;@d9:"C;4uiBO3IQ]A:XU5IIkpV_XSe7s6
W1t&0b&S16CA1.$2[/$i[PG'X]A*QIPhb5&A\H!)sUh!!i)GSG,RgF`(Gth!r*"Z7/`0HnNS_
s.+=6d9V3)&Xd$Uh0-R&=(kX'>GG!19@EC?*d'+c]Ah*"?V0cnJ)7$?i4I]A;B&NaYLoakIb@*
WMu7UT4@7+i`__:7Fr3c4q><TV9h'f>,"a*ifHi/el4<j!:Y2'hgJFEESIFP(oYWm*`1qq;X
^65EZ2"*=Ciu`%!G=!dq_bB+Y=V'1AJYVK,+ek9a6pp;O2-2NZ;$EJi(=gX?!R.,8<nZ^-!=
mD\o+G\Dj=X4Q#qO1,m4&ZS.@+G@DK"bq>j3\m!IDPY\N`7RKR00*"l[C[BWI7"Z\gkXOZ9r
.RS?4;k!#jt1iIhk_#;DO8?<AsQeG:Yn$/Y-uW)D3NHFFP[9@0hUJd=,('gA,(9R!./37sKW
JSqhJ;g5AL0H16__OnCi*!TuNd[:)JF6Z]A?o?$;hgR%?3A546tqfS1[%q)uan0JA-s>_#PT?
D0i59iE?o=H)biN=t+i[jW/s#5TGrCLeTri@/mDBeAuM0j@N"#8:g_UDP86!#/A`ntkFqP0r
ZT"G<&M@2,Hr?fa!GA0C3f1%l"LEULZ>#F!2Vgl60LGJh+h/:\bD^cE_8rm9J9U#mn'HO@)G
0B?PBk^A7^^sXEdnpL=M6j)/R(-[CB!8Uc8`B)_9HC\%NY@KM"8J((<Mh2+nC9iVt-JJT;p`
.a7%+ci*js@,S"i.Um?IN?kh$-o:J(BAl*%"46a`_;:7T6lWj4YG@Po([K5,PYrCeY(^dT'c
a3r*gLY8HHBNiBqjMtYFj*P.>oY:B'HmVd1.>%5O!#s$#BZY8t4$Q.:qhm.(6C'Z)<II7I5%
n>_H>%G:R6kD)]A1;(;ZcZ99g#EH4Yj^orga+Wi2Kr&HC7^R?V,?B6F=Oi,0lK6l:XF""`4._
W@#;ACJVCEE3`4DDVBAcY/=H[%W[+53R&%R.&cq7)O6"BG$f',[cp7]As?AtT1)Ila\D>6gCo
-hVconQ=VIiD<u;&bYS":oK?^\Pn)'FG1H\=aD+ND4,W`6SsRN!AQcDb/RW,?[<#3RFa&M@=
<o:FD]AJ$Dfn5.K)O3T\p++L-'H,Z_8:1&K&\eR]AGBeb'"YarJS8mI`ebRr";nuTN?Lg/A8TS
($'k=!:qL#kCW$eRZ>`G^qHC#c/RT+OiL_<qB'mH*=(')%:rW?Z[gnFDX'&PQK58_Up$J'-M
NHbAnj9EqD#mE;H$G]A8&1\"^PS-rX?$)([(emHfX7h>!AG,6u@o9([*cGm/:p;ttVl:+G93l
6UX>R=ubXZ^J+iJD^9r#VEo%CY*DeZ6XZ7TQ"L1\b/*e,Xu8Qq(!8%*&:3Hg7&&'!=LbZGM$
:28*acOsA8:"RXd07*C(aW;mds+GD04\.P*B7>ARV[S-_mN.lkdG`lmNg+r)4oZa?Y'/jOjT
dr3&H@9C@@;d;4VZFoI).k5@+/UAW(0EPSj+(_rI;(I5G#1TlcikL4&IYi"=bi?aA[JFo&'t
_e=8KKDG"TRYr.I*'\gm7Ko`RS7s;CVK1m+I`4%@T;ES7Og*WT3:D^2oQf*o9?B\mti9G=\P
,GK_X0IUO#hX*L@\Vp<'E\F$4=RM`2kUX'7_II)=r!lllo)>rU6;,dH98S>[ic,2aNc.bX*Z
<N,/(H"S.A)b^\$]Abh8m<c.N&#,=hM/j08@[AT=K*;qm\5naOI8OLHa\p#*C3%W]A=#rqeb6K
Z[(cS3SrO3A5B\dID`=k!pqcaaCj]Aj"_/ElEX^"YflBCX:`IQ#ga(A`?4IfsDVL<6.Ch%3Me
XDsgG7sCl)0Y/l1Y<B?I%92In!/P5]A*kedDHr[rE(h27.SoLFW?b2pWL5!?I'A-3-05L#FZ9
.ZNR3:3#17'nXoO/\9NkjIbC8`Jm+o5/6KdFJ@@b"p7UT0,LC^o;6>k+6ct@(IH@(3&t3>3a
.ZA1X3o`63o@AFdUG43Z`Dk7HP.6c_5K%Fj@>*<^A[Mi@=+@r*9V2l0+6#k:;1Yf(%!I4-)*
L&b:#[gO"lL4R"2A!m4\2E2n*f%OFMN3`en_'g(YGn2bUOlrh$qnq#?Icc2S0/29RCS2$");
1'1>2:=fQ(kg;Y=>TIOJ3u]A0]Ai1b/rKDlk0oBcj9g=2-<CEoOmD+Y*Wg<dP77M%$*Rcjqg3n
[+/>cFdVYW$8Lau!K^D*,B@rIJ=9<?G*.s,r8'kl<9NU-B!3[;Y!<XbF!JK`UqrkQZ+D*#Kp
PZ3QdPOJ**S)2+)9ZG,8"a%up`@%a,EFjVr+6A&>s^b.8BMplb<F!tW<Hk6D(\tl<SNu7[9@
Us`o3#e?L3VM@?^K47[`[3+L<@]AIq#o*o:'qZ-`8WYHV4So)mr*=O"Q'?B[8jS@!rtgnf%Y]A
G(H"c.+U<gh>#IAh'D?Fqro_8O')(DkmGZa2EUKlf"H/*_*R:LAH/)G26g7kq\FLVXJr@fQ`
G!lmMn*gScYk"8EcpU-u2O\t0AfnCpN/:CVE2@["0bdqF"3S!uFI,<.JWX+q]AmtA4#"[j=TV
jMfA"7n8bjkKK&PI\q*b_8s7o#!Fir:sPA8dEEW7P.=-#QL8VFl)[<$e';!;a%::-c.^-`ER
h=%B#?.$nQN@[3co"=SXQ-6;6*$:A;Hd/''IkZT^0("s@d?0GG-A*5W*duSV<_pi-lZ`[fZa
Kgm0AqE8629Q*ar?KVjNof]A40SCX&4r#&WP#7U,*&n.0Jn52q\&kk=MPmZJY0rj')gL2m-+h
$C"Q'/Gi!lO#hdM([<,0.hEB*"r.?k6UPQ=/gC8J>lHCE4>e0r_5\4A34BMgS:-_QJtD'bbY
?p&HHDJ`up(1NbR]APO1-6?I:E=E+VQLFe*uXr-f"H9#8sB:Je6)0,$eg;BBW0jYd#6q@?/Y-
7uS@V#CsKPT@n(M+X`1'S!eOMrUY+@MsT7AFOu]ASG'/'GKgfe[9YPo;Js-g,5"=QFea6KK??
<'OB$M#oG.9S<q`1!X/R*[0RiKXYeel0kIHVO=IIIWcb`"P3FK_94=n+-B8"pR^.TVB:p>a+
^e%+nlVh<>=]AX0d3rRg0c?o1?V6tqS\#m?'<lqn(!Pp[#V,pBX3#IL)<6k!KPM=`.Jc/5,Y$
8a]A>rD.)&HSN&W9@lf(tt_i&;u"R_3!$R(sA%]ACI?:J*6D>E6+XdDln>lr/H[Xrso~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="448" y="292" width="323" height="96"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="07.运行指标-OIBU线维度"/>
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
<WidgetName name="07.运行指标-OIBU线维度"/>
<WidgetID widgetID="8a3f7215-9414-4004-8955-6ff7021a65ab"/>
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
<![CDATA[822960,944880,944880,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2834640,0,0,3779520,3413760,2743200,14234160,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[O线/IBU线]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[执行航班量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[延误量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[全口径准点率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[考核准点率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[出勤率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="1">
<O>
<![CDATA[O线]]></O>
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
<C c="1" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="04运行指标-O和IBU线" columnName="集团包机执行航段量"/>
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
<C c="2" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="04运行指标-O和IBU线" columnName="集团包机延误航段量"/>
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
<C c="3" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="O线" columnName="包机准点率(全口径)"/>
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
<C c="4" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="O线" columnName="包机准点率(考核)"/>
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
<C c="5" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="O线" columnName="包机出勤率(全口径)"/>
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
<C c="0" r="2" s="1">
<O>
<![CDATA[IBU线]]></O>
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
<C c="1" r="2" s="1">
<O t="DSColumn">
<Attributes dsName="04运行指标-O和IBU线" columnName="外部包机执行航段量"/>
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
<C c="2" r="2" s="1">
<O t="DSColumn">
<Attributes dsName="04运行指标-O和IBU线" columnName="外部包机延误航段量"/>
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
<C c="3" r="2" s="2">
<O t="DSColumn">
<Attributes dsName="IBU线" columnName="包机准点率(全口径)"/>
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
<C c="4" r="2" s="2">
<O t="DSColumn">
<Attributes dsName="IBU线" columnName="包机准点率(考核)"/>
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
<C c="5" r="2" s="2">
<O t="DSColumn">
<Attributes dsName="IBU线" columnName="包机出勤率(全口径)"/>
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
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
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
<![CDATA[m<X+]A'5./"Y.Jh#>G_5_f;2IiF_q8nXjjaX&X1_Ph$>'"F=jmMC$W3lU.,=JOMfT8ASFd`)J
DtZ;AYR@4f!t(Elt=3`0<S&`$gD"Qp?=d$m[![adg(2Is1M^R-@\Tr`\(fs7!VD]A[$Den(c7
fh"UES+2,<R3;L$^IiAq10KEaeM^nl2I`2a%R(3(G&(&)(n\I&/5X<cqQkpS;2>odikG$5V=
*At_[/'VAHQ1FH3S-sHS/BtgG[C'gJrJ#jJ'kM).D<6(cd'nX^Gt`Ka=mF#C+mOC*h)\fdOM
@_-V/For9Kss:p$6V#b.!81ES@c*d="ak#!JJ7kL3;TT8[8V#;5/6NP_+g/A5T(>D#dg2/6i
S^\+k7c=?S8Tp-HT_";4JB@Jqh1WF_5Q:5lZbl%SCqA;>Z/T06L2Dc6_doIQ]AO$r',dnL`GY
dZ)m.o/U_b]AGpPa>K:-pcI$JBIOqAQ-Ctp5Gis(<d_H]A!(-tgpYp0psBcE[10qJ`.706l9gb
nDEV:fljp;`H:Mu:.aieJ4?b]A3@#);gK;MjKB;Y(;le(cu+LtkE]Adbp'*fqEp8K*VXI[V3-?
5Q>d$Lh4nM?>[s_DBWgOBQDa/)[Q)]A8q^cQ)+?]AN*N\J<>D&-H_]AiEe2frGjL54qQY.jLPDJ
03V:a[aRTl`a/Lj+bf]AhC-1hge=Ud#!0&AhGB2_ZBiGuQLhPYb9nQZ\)B-CqEt?:lb-)tL;3
Y&J`r"N]A0UR[XackF]AJ1f-JHubNq"+S+`3n!r7a#Be?,*^'uj,kcQH6Fbl2SrW:d0$h3'-d>
?Au:4mk2]Ar70Ed2WC64f`.>k0f?a"YG3&^+6/X?WV7a#fo-oF,r]AkW/3a>_ALe%]AY-):Ru&`
<gCWH$m\_D&gPckJkJdWo*dI8\FX]A#Gd.>otiY@Y6G6(Zf"Z^e,$(6(9pi=@`5eN2-m1I,GN
]AQA_;:%gSO.f,!2,DISUq=XGCPfUnSf>omo_G3I$1lK.C+k?^U[JNq/,`\S<[&T4$*f@7nmo
6'V6=RG?S1!H*g(q.43SjfXdI5B]A]AEW0WGLE?roMh#R5Kb?<(6QL9PkVJiqnM<0Bd^T62Q,A
]A%Su'H.MKGIrbbsCak1&oNJ6=q_+`,;nBc^gNE*_%$``5dZUbPoUDK`;;h(:^gF,qj&3q;^>
o/oAW=%-I25k^b8u+"]Alm?A6`\GUAQ7'L*8lRhWB-Nj\T)o#9G2+kUOkp:@cj/g#YVcFRFZ&
AMA>`qVX4lsR%)[8d1AM&[Yj"g_WHeL6W",5?LUK1/rT_Fho@ig332>H9f]A4f3B`52ji1-@^
0kE#`:iX6ZAFhr3/VID]ARirAeF*d8"5js?mQ's$D4pnXH`oaCMotOY&MMKqmE:q0@.#2EKkC
"KKV73rfdRQdpC:o50FI4Dmo7QdReP#"[c`6$MdF&[+47?_kN<!*%RNed:Hdm:O\RdeD?E]Ao
+<s#^W_o,UXgGk#9%9XSQWh7U'4@F=>`/OEc2p<go'e-Emm4pWb7Sh75kJMLjg"n$N_gdVRR
0Hm+IWga)!RY3B^Bf]A?0Ncsi@0CF,1/K?Ee68_'*2dU><oS=W0)$9O`j8K&an0^'sR=DkUK#
6Dq[ZF%j;.9>p).P#!;uc>#9t-4As3X>>^B:4J"C^T]AWFJNTVVa>!;QN_Tm$lLchk#^HV)#!
j4(%s,m"^GK:)o<N6+SHc3LII.1.H1VhN^<2o!'<^^"&?F\-VkL*0E&0@7Tn%cX5">\Zn68H
0i#C'4QcEu2t"nP$+;f#FEpU[8&CtDAW=;"p2>lI]AOn7$&&HI?Ck"a[^kl(fuNC%tE4b62S[
W146XjXtp(Sk,F"[_K848@a[.E9#42RLVsA5Wu5Bc)\QPoa36]ANrBqMdM<`5_Mnis]Af=^"!0
G:PV*Y9^e_N>Pp(q?l%:[Y@J)$`Ci+AL[lRLn>n=iX._;^H=XfT_QhNWA9jfP'RMe<:p:5rC
N/Y[2JOB4%26KYc!)rb+#MC2KNcs&c)??eX^E;D]AM]A7!uRTcU_EO#i^UE5pNrb-"3[_cB/:M
)D9999WZoCe)(e49([HD//o:Vhsu6.=rh]A0K%PGlRoG3!_q\$aSB$RTk$DU7"RebBY3!H-Aj
[Qa[M^;8\s0gYBO.p1;ba#aea8+>hJ;j[F=*<HHmAu@&SZ<'_+s/aeS>\:beN&"S$]A6e-8p0
!cq&/>W&t-XpsNF#h7;3f@$bV-r,&6*A9<:H8OIR"PP#TNgKLncR0DSV_mhK2f#;t2Ye7=pi
V=*r87:nl9*bMeoLH<Z@eIle?T0hb)nSqW>'7lW\:Vl4+Up<>M',;Y9Ukek7>l=p>?6D6\K]A
VDMtUEUL-P%4W5Icbd<`(QlXUuS0,pua+.rj.L:Zj\h=K#SU_[=//9;[>%0(O==4-@ae-F-L
!8]AC=qO.X?+qmMj"aITd'mVX!+jT.ao06A(63I?0ruf\B,a)I>"*$f:T6+ls585;%c_9Md`s
M@V&Fr`eSG*K1@hG@'hZQ3d)_+:MrY"I`9rd9"-+/V0>UH@WQAh>Co+1!oQUH:BA]APY@q&3;
Njl:2^Goo8I&afO`4Aq#H99j;A&=a`h-4F/AdEms(`mY'Mi",;i1%IPg2@"A9*Bqqa6R8+$%
Mi-d#RFWc:<&.!(PJO!d#Vioi';g:GTL(.KNIIlW_>G\:Tln9hBK!R&g#d`@&jf';11+c&+V
$Z$(Y<?VIA*U9ECRNq.QO@aOsZXuL/&O8nW/o!oN4bb&&*g#^m56J)%FVO=C/$QI#;J4#M]AA
K%dH)]AY\IrOQcB.rON<aAbOSFA[6gD]A%iUEL^?(GDe;LONT?l_4.__&1A1_6ZrHBYndDh_s1
UOAQLZ+c?2c?V\AFrNnH8$M%tW/Gp^0hoQBA!j[]AUZ"+Z'9I'\O1'[/mJ2*7XWE@48pY9c[b
!pe2PAMos*0pa"c)r)ck'Kn$tQhVBAK6lK_?;@^?hm3Q2]AtZQa-Vga&$/>,#BS#1;)Qs0ic9
[F5NO#6@O(\X%p/*FU5cN:ce9F[G2#UV/]A1Nf/ksU'=!u!7/0[pZ<OEbP-0m3`Hh;Jg^Wnu<
8@9a<(H6fG>r,<p5>M.Q1NK>7#4iXUa\/Q0KY1(9"^+LOSNU_*/O]AP41Jp9V93Nd>.qdnR6!
%L$j!M*^![F8?_B=bu!Mt+q#,DZ[12-h&trpqIE\KM%,,j$1BDpU?9gI;,do/6HKoWJ)qkoO
':k86h?QIH3_USM*5(1PCjMBVk"Kffm,)t@]A>$DFlEU3ZS47DA@ZXWfH)kGe&05_"n0ENWm[
i)Ij=2:`]A/MC*5geFH1"%p#go`L84p7+jH/eXh7_/9:b8$?`TB3.Al2Y@tq]AJV\^QFROM&n&
V)d\!4(Y"A$&hg3VtY[T+sD4EnAm6a"72^\PGL8t`cM.le<[F&S-<\_<k.P6hCc1#GPn6=L%
?c3s&X)#<rTB.XETf5a7"pI<kDR9KgYL7ZZR%7bj"AfLbo.D>?%)f[Nid1o@5[Qgkbg(K3>l
SIHL2\95_WL4nTkQK'3;nl&qcBX4fs!/a?G=ieddQ!_gK]A%4Eg>aB-3lF&:Bg,%Y.]APeU=-T
^-8nQ#H:bp:>Qm.c/^&L#Up#`8"qe\>CZ0l)GJE%RXn`3E(_GO=1DT_T2/rFeTP'sC*,(S=1
+]ABHMg-m"p]AhpTTd=kB411]A@PA^Rahpgqp]A.I4pjZcXtQ_07-jHngXRYifqXV-(+%h[9l?SH
Bc-?%;GP&dchGF#2$7Agu(l1TJ?W=$:M]A'GZd<N*'L)dj,,+9$s-"md,r=`EsqdVhZDS^Bo_
Z#>C!_9g\tBeh'AfRmC77LZ4H8B(q"]A=Ie]A9V)D$ZS)?LJ,+62W4`5soCV?%eo<qHf`YajRP
HW\\?5Je2-30]AZ6$;'d_]A/9R.$j<mCFn5,buF!.kk9^1-'04>'N>!!Yq@$_RZqgFr>A^<Q=A
`e),d)iG/at`JX*CU1MjIO^#r0nq?4fA[H6,$CG=skBr=i*,jPcCn6!,FMmQ]A@'S\*Z-q0t$
UA0FhB=-/Z&8'f;C:th_.ldX,:f*"3`;2["h*,;e(36pJU1Bo-n]AV%Ai->(p1i6W0dnnW?V<
ZC'rhP`Ne\@CG(@a6BODLT.]A!gdXLs*j=f?cY58QT5\]ATcOeN\S>FH5I*WAbU`GEh"Wj]Ad0,
R!NIOC,>:8%D1t!ZI9mB%r]AG3RHLQL[P\:",q)^rngBsCu6@meO1@Bh]ANdD=/&#(rMZD\aC^
]A8@mF@_<ebm/*m$BCr_n:<"'XejGN[?.'K[Ru!bK;-,55Ub&mKVJ\Lm$74(M+oic7<H>267a
<;"8ImA3gD0KJM3Zi@Tsu5X3IR9,BH`-P0Jh[q)&H47Z1H[Q>178/oh&r1*/f2<&YiG,ZX_!
A>@aunaV,[l2UI_;-9f_R-o8F?(=RT[-mGS$AljR#MtBOf=#"m!`)c0ac13@PD^d#^ABOt:&
AJX,XX`ToA#KVT4p-r8I$YMS/Caqj^.\PV"d)Rgdk1G0_+MZ]A?Dr\`g=3YYDs/HD7p`%W9\P
^jkpA<!FOC7qjEoCVajq+YahEcoNT.:_=Jnl@QQoC[D9K0i0e$MrNSS3l?Q?[8ghY1/I_7FL
1f-T2939"(RYJ$lKlUIPF@9QGtsGadPaF`jOaX@MN&#F`,iHRS._n%&A"`GqE1'ko:^]Aq]A:'
?fG@9N?N'Soh&N>tE`L`[>'C`DYc,$pk7gJL"SM2UIcEu#^6gP>eR/XGP"REIPe5-M*,G?a;
\VYL+:p3X+SYMgMO6+dse*.'mmGpNu5_c;t/7^8Q+D%A5dB!msL4D"R<og1\ob[7""J"Zgm-
/1%.ElR9>W?\@?nGE0#<o+=B@uC8e3nq!V#<D@qi%I"cSIcrjsL$`]A?1NrGH9(e<E0cB#tIc
F`$4'0-d2Fl]A)10ZW2@<b9J,d]A2[Kr9jWhg)*\Jn,5fJWu<YRG16jdhGc*S#OF?/_DjjNCnO
GtaHnRVQI9#_R`*,icoLL9ohgFKY/`7inTM>GH#oe=k?oU\h`L5UcS#6uaug,7OU(p2X")>!
5)RI!;,GACmT?^/2cBC;Z+H`5NG0^OR3*qB%_FWQ!siRJRHe9YrnB^5%^p9F(B\ISS.45t+e
m?pBZf?$69S,ULm*L9*-Bkbr'VjTaUg.)Nn(+_.0"F2!Sg3peo:GG.(^9UltMm4g`^"CF<7Q
$O2Agoa;Qb^Mi?m]AWc::.tV0S]A8LZ/;KD1T^)@/N2Yi2ZGCK53@<[5O7L1o,g%+>N/m_VpeU
BB:ZepM9Fs:Q[Q`R*TGZU8Vg@3L0Vp-6]A<fYCF.!HR0`K:dt8l0`=GV7*R'2W[QG/_9oa("Q
kf@9NlV_c=,8S;igaRpJQuWb;#VE0oO!08h#BKb6Q<AjG(0Nc`H2peBD"#1?q?Sbh>K`rAD;
Yg7ffAjK3-p=f)0&LO^Xjlre3A!`e(@(Yp5e`!T;"V;`OWck]A9+)IFso&b+nfd[#?ebG09Q_
?,hiHeNrk>=VoXaaW8n:Kp[!j@?)h0[$d;Z/seic+20(rJD!UUcMJY"gUOoVGFXu2_=qfKYO
k"9E8U-]A;mKP":>^>hkM_AS2n"^'ptTkl/!@&EAq=(j/2q*:k\JD8^^mJgNc5a?g9-^b@I6Z
HfWqPS-c^[#:6f=]A.`FN=.cjc5#B_@DUQJ\sK'B>:;q#:fYoo2I(%Zs@c#GA57e'8fmM(-=T
uGSMOM\f=,/rhicS;V7Cq!N>g\1lHOKE_bbapb(/-"Z+CM<$Qc_t&UXanL9C]AIa>/QeCEJBp
a>,PEp_>kJq9XE^[4Wt'PENB-Q43-750D;DPY!52/.WWb!d''VRqh<3(DY?RHl2j$J.=:D`%
N#TVKn/4;XQo>Y2c`uO3)P5?daCSs&0r]A5"1:-JkVo8bm10+eDf\gl'TVT`Z;P@^j-e[5LhJ
lg^G#Z_K@9k@Vp0a!V=Ud/Sg4D.'k>+ri#^[F^DfiOY2XZBW70+lV*?$_el&?S:ks6aGeNM!
jWY$D(TT'R3T-5V0I,.HUWq8JPV*$6.g4P*b'.R$l8]AfED.j1-)-f-'d^0\%(aic5kjl=Yp%
E]AOM6S$@LFo47YAgn]Ao:&#BCWM\c*A#mK(gMS8d<W$"DY:&B&j/BXu:tmFCCXc'O=fAYZqo5
<B9="'(p[Kb,pHJ_p]AZJCt4Tir/.@(p;6=rV-!s*!?+D4_hnV"rFY?9,N&2ji(Z,pMQXHUUd
<iHh0#NaY63HlQt0)S+ZT:U22A.=oo='\g[e*c+/A#IZmWs:.i/JcF^`n%I753.`'kK#P:%t
S8:*_/;%KeCReQ44cM=pPGqXii$-++@*RUXl<seZN>X=iaff$@7+WrOAJ[YgNXWhWpIcab0%
G>fq:brL\:$7PPUKObPhTgSjgBj7go7Ueo-kMHa'6KCJSok2?.6h:1Wuc=f0iS[=%[H7;5.P
mo\O5(3Vqp&V6$jhab5Z.KAif2fZ2bT>d/V\0are9NofL:L,7MrjXFk&moD'Q&R*(>>$`hGG
8;[Yc25lA*:/rKtO07f6rHW:%`ce*51JV`g1/Ktb*5n2*D7oNED#-:Z($iB!a#k"P.XQJTFH
jeiSh\3d1Pdp@!-,p5jl%GRo\.Cl>6-Xi=Q$/>(;IPl#EmK6t,nFh-VZ3''l5e!A?mW@&(Lc
dA[b3<4A*k#6e91l;^156,3i`rBoPgTY+Qj*[oAiR.pZ&46/KqBhk)2T@bC8J)Og/?nG''?K
)lQSMGI!!$)3`ZkJqnLJSH]Adt?Ql/J$o/*)KJ5;Vm+]A#A5:YFlaE$GY#NNN5Prt;-fAM\ISo
BU3QarKObkRkYUSnC=`"O$08^F?@4#SF;r?k$#67(-]A0b&UrB7^hU&fl`fjmpan5/0Uf6)#K
hkX4Kcl0c)U?/fqOTp^B]AlfV'g:BEa5D8pk%u^F3H?V6G3e1J48,glLgt`inq4&+o.#*_K'u
'DE3F?M+k#=');K.-kH`KnLPKoBLU`Cj!3PPs7^ZEic)SqPUO!lV\R$&BY(5,JYscL-R'dcm
N/]AWdpVH%t'/sVF-qk6,!D0l2RLXjJ8*V3OX9;j5T#Mn_g;3:a7K@AXQc&4dlqb@-/l?Rj?&
FdlpRP_tPm*@a.h4cUT]A@B4.j3e<F8kYDDS_8h3X+CT2a+m&V$48"7Eq+CFB=0OB^.e9R9MG
??7"]AQp?#RHiIdhkd&GGFEF!:CPs"8K9ngP-NC-_@(/:I<WkhL\JkhT1)EEA5>&!DaNj#U-,
[Qc:VDcp;a^e4pP]AC-+?(rQMU&nYbGB9R+.)@p=A$U_8j=FTC/RQ/n^$Ql7-fn?AT\H!bRo-
G<+0WJF(*:\Yff>dLtPp^[*>+H;kQo1j)i#j3\dU"+b7ENbWlt@7tpPDnsNO+A#h,@>-qP*<
!^)"+@ccCH)lN@G?@`"]A1abHOD%h/U($9U'%NWYLE(*TN=BD)k?\;:YH,"dk*O<I=6kbSk^L
8!]AssWc9OACrJi'-1Z-?2l^rQkbhHqXC5"sSF2kcWQ^HAeKZtW?(c9E+Ng0Zr==irUrL-+;q
L7[GXO#^M-S69pGd700,DYFk7pd*YFk96e'9bnE3)QX^/H,)c6G(tU&:c^6O5D14'tZnE3U0
I9"Ng7G)&[+Vfl%W]A@oB%JMBoD&+93A_`T>=b!]AaM:]ACuC">#'>o1PS\`ro,#ABU1E4nBj!8
CaS-4RLYAuZN+>pO!AQoZ'n9%"q]A0eaBpAQBS7VV!Fk"9<pd"d1'<aB"c%n*UIipSqY`G<=!
B"'R+TVT^WD%ReL8Bl8EL4K0>29=2/I[eM1HRZc4^b7CdS9CO,?8r"B]A]A[QaN6g8u^:`M<'6
ZDuc[PR$kZeBRjn)%+I'D8VtM0#Om-D?o@4FAn>A@pL2QfJke(qL8CQF!`q60,nbrQc5D*,J
.L)$V9GJ+;in.i-u8F30eF:XW7QiEJ.tHN4oGPh-26T+jZi0$[PSIqS<,uO).c2]A1Y^.f5:V
tJ."goM22m4/P361=ZVW&C%oHMBhuLK1[&q7JE+\TK'g*i).nFf,!G>',q(2:TA!N^ILh'gG
TS>_mETYdiCRu#aFVO-]A!u0g6ciQ8N=6Q6&cdaXqWqnn*:?ICfRE"?/_6P,oL)H7!8din_<i
HpD.C1T-SKi#V(6ar>F!7%h3kL+`P''`N9-]Aj]Aa#eq=`1Y1o3pVAh7i$3m5Jlolb5`D,H=kr
\h'_V@!Ac)YQT[mJ"t)#4Js=-$d)A>j,0K)6.eDRU/B[SF9t_<fkJm\*RmS/H1m,^hbZLs(a
9EAoCN?(?9g%(E*kqKYEH3'IfC-egL*ftp]A/Z.Vh&r)=?3+1C0j,\W)#6hG;iDsr,V<e7Q@Y
V$fo[,7S41%A*]A%sgG_6WRS^CN!,P:t(-um4(_QHV:.$H@IIMPsFMS_WB.\gA#Kp2M)]Ac,ac
rZ[UeT;dC7PYb^BEq1(IIPT-%.D[FK]AglJ!_3hJIor+%Z8u[]A(LnL3f653'o^G3G4iWP1E@?
2,?J4%(XbDULLA23jCT,e:#Jhn:7(]A^XZJUr/N7L58/cmWJn;#kjlB!]A73j_P$rj$8cnW:TN
$s,VhK,8G1Y*RD?c6-#T,T`;sC[,T'bIt%@bru1~
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
<WidgetID widgetID="8a3f7215-9414-4004-8955-6ff7021a65ab"/>
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
<![CDATA[2468880,2621280,2743200,2895600,2926080,2743200,4572000,2743200,14234160,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[航班号]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[飞机号]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[机型]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[实际起飞]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[实际到达]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[延误时间]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" s="0">
<O>
<![CDATA[延误原因]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="0" s="0">
<O>
<![CDATA[责任部门]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="航班号"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper">
<Attr divideMode="1"/>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="1" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="飞机号"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="长机型"/>
<Complex/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="实际起飞机场"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="实际降落机场"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="到达延误"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="6" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="不正常原因大类原因"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="7" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="延误-明细表" columnName="不正常原因责任部门"/>
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
<FRFont name="微软雅黑" style="1" size="64" foreground="-1"/>
<Background name="ColorBackground" color="-15378278"/>
<Border>
<Top style="1" color="-15378278"/>
<Bottom style="1" color="-15378278"/>
<Left color="-15378278"/>
<Right color="-15378278"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<![CDATA[m<j7c;chOnXEBo]Ag<A;H]Ab]A&*RT_7u8h15lZ)&J*TGbS3H@]Ab;U88\W8:ZdAXfY:_-#K;C6q
A>WN)`/4N"D.3;PhG\>V$IRLmgR7+UP]ACb;n`K3:0[,F3_G9bk/gIdm*d+A"U*QhKqEO=jL8
uj(H,6'g:[#R8;g]A\1&qo^DVgE9d8S9'3G20=3+/qm@Rt*iBCMVim$*,A0)[faUW+Z?g2[!r
SFT"PCK`YIp_[$kM'l\Sf*g_on5mu)4Q*Ja-@SSI_##.?P'u4$!Of`VuM+_T0>KueD\6]AB>4
7\"R^AuW))LXgtjjZc(Jd4-7rb55P9dY<LKAKoSnk3GUp4?HM-E<lbFAlg)j!=L+?XZ4N!Ie
mq%m%Bt2An]A/X(!j%%<I#RAZgggge+[qYn*jmKoC2D2Pp!<:[D\Fqcb?0WJL#]A@.QcTEN'mV
2R3U7nsB8_@mHmkuJ//0loaiVm.k_B.N*))[fFGAr&VWds(YpeR_OH(+'(7UN"s%!+^uE?p8
dnUnWR)t0D]AGhTe.os;lJC)7n740-7=7r=ViHFu?n3n[%A*"Ws5,ZbaYH8FMl$2bW8?Gtg+M
g9XFPhj<Sn.^+i1qZ+eRT/4R>lSM$p7XIH9*U$+C0*jWHm2LZkV_8^]AsfOiGQ?!"ej\mfZX5
<KbfVj-NH0fi\+iKUOI\jXnFhn[Pp!,H5t<R>!]AiB+4VIof<Yoh?E$$Q)M![?oVl:,(Ht8H<
PI"TIn8`9<TmP<t`*&T!H:KlQ;'G7lV^'rYb!%rTb6":$d(N.8\$Fr8"a/^[m3A(>>`RR,:K
cA_X%lTdKA_@B2\[bdbF$_I3P44qN8,W2%a%pVgL%`pe3@HF/f]AEd/F:Tma;eLr,&Z-7),oE
De4+)Be=Q0a\3;dV47*65)5i9gRacK-"$*:7>3K*8i@)s?\Oc:DPrQ^>#Dt3!?j6(n3f&#AH
e%h/U#AC27g/bmE]A*csZbC^f8C.\068l]ABk%RVf-Wm3p4,6a^#+XBrR)c/:ZX'.,"-'"pml/
Zl6o.`@X+a`td_o__QM6-QX+<#t#VG4n8VBlnF.*kHju[#k2@6O^<o(;hP#kRk==Q.7CuN^9
)'U@>#]A)+T,h*_aLNWe+:75Z6^&5G%00\N)NI,:'O\@rO7&\X;c5&\f2?YZ[.FJY(A\06I07
.!Ufh?F$jE[*CWUnIrZXWSA8X3,qf"A3I2ICR*WIVoa33qmBo#DdACO;"11\o^Ak;`qb=&[X
80*W)R&"s+$7Uig?92WKopq*KC\_NKgi+<os;9dhl5,Zs5'sZ[g\<8ObIT?C=$YBm'B;Kf=V
2(c0(=hIgS*&'ndA0hL\+KK:@3>I+_X#Z09>*MOC]AHdtVUrmZU5o:\&J0it\B1p6d33bb$kl
WmTif0-i:lH!hCTuQaMV8gQ^`cB@QUP)4tn?%-\r^gD+R':+ggT->g;0E-hqREiTD;Jmg96m
rYCk"2pp_I:KmC\AjbHV,SG%uMgrG`a6'HTo<)0PBX[fWiEB00*o)KrlZ[+SVL;I?a.L.qXg
F")`pL@Cm8!q'gKH6hgnWg$I<fS=DI-EM@JPRfU7ZL""efpZr5+c/GFYIVn^sER5A(0]AV',W
qHcJnU_u_Sc_Q!OrKca'IJHj#"X&TSDHJ)R]Am'@V[50-S3J@RE8jE`Zt&8J@uNIkK8*q$q`]A
Bf_=ZLS#'Cm0-b.5G8fi?Mp<eEhWnI9%A2<O^K&K(Tie8;pVMJ=nAO5*:piMfd,tClgHd$9g
oDbK7Qc4A>PEl<US-e!6St??(g<ngMs4Z>?@OfTcSH*`hc=4U&38R,de&#n@;eR6<C$q,T+(
l!ugq2oR>'%*G9EAk"[PX^p(S;R*YS6mf0eLb+5]AS6637:_2&-1U,L:7AOa`O_"Y#MZpe9P=
,h$!p8.3$"Yaa/=i1H+b3pP4oM%sTeX"+MpiO9)PGtsele8%YEW>dK*U,V;]AF-f62oqD@cnJ
1o@sds(oGbB/k=cSJ?kIbqQAPWbh;uSS]A//9NdHJV9:?j)PJdAog=E+GN5CNtT0*<_kuM($)
nJ'Xqf<':E^3ah?:&L"C$\HU9&sS$G#MQtldSW,lZ_E7CIlNa;jQ?T4';_gWE,t`]A%"$N]Ag5
'!9]AS]Ap5*WkZ(\Lds8`':9bW[Ft-\s^%9WX0j+*Ccmj/fjLAoJn-]Ae8GXY>bsVN8RH0I?M1.
.5c&5-H@2+4O%<agktI[S;B4KW/a,8g?$KXfL>d)DhcSd[4oJM?Jg/uAH!1liLE1-ej*GB,G
%CAW3ui?Dp=QjEYboL(qrH?jKg>bj@S%klZkham)nb)3%L5@Uc.aa[NXHXe(m.P#F_?_@D-5
*<RI=OH-0h)Yt<X#V2qr4Q("cNm)Q(7!dWOteILe:@ed[mX^2Z"La[=bfPb&l!O-N@(G4<-J
Jbq]Al=EONcsIP.9_=>t.N=+cV6%tPn0]Auh;cUo0:r'tA-0C=9SlCVD;(;Nu">7f>G?pkl@'h
&P2G6<WI]A'Bl[@4Z.GH1jTSg\?+C53('l<XNSCs4sS9qIH1)44EZ(['B[YH[9SQK'4M0:[?\
WCX@4X$7UKp3+e3\)XR09%2a5o,*"X/T/WpfLY;o=#GlrA4'^^:g6%bEqU-j8RX:4phm^Uj/
`HqOmf&qT(RcDQe4Z'ab%^_1IJ7>?5=nB$S:ALC2<4-B"64D<l"T+A/53:aQ>AY&K7ZC%OT=
:Q*(1JX&MI.?OA),Z31c0WDJ^MV\!U.,&]A>'>;5B`[A^#5i#B9<:`Cl22ZU(k6/W-,JEJg7q
^='i%a=KL3$1aG1(NLRCL_O(^N;(mkE;^rmf:1+a>:"-kS:qO)1`YP`=QU]AYK)+*nrjh%%M7
aRHAUN.e7C:i.Y[qYi>Lj>29som[e(nbgMn"3k&1`k#mBkGp6J\T8X$NR$FPcPNsGp<'9Kk2
P5&Hn([P,CD=W(Hi@?tE+^Z0UFtT(`r79@",J23?]A7B\sD]A.S#;k5Z_p05h8Y>)Lh/h,`;(3
CaPbSNlN9BQ^&k8MMH<s7U-TKDTDKA&R>$$m=%^`'@B[cuMo8^tqF:b2"Z;'!tU-?3/NZ8dO
U[TS6TXNP!DdLVh,,Q6c$6%70$?g+DPX)Z]A3WddHVaXTK:OjrbMElk62AFI=o>6O8$Uk%B:-
b0]A[aBW:]AQ&IQQRZ?`;DL=TpGWjlqdf?D#]Ah/,p3b`!&,n+lW(Y:XDXI@JgG<iuWcpstN3s+
6.4.?;P%uJMlg(@I#kT3P+O1kC[DX]AVq^7B#caE/^pm9+_"<,uE_=FEC5nNGD.?-h[)pgeeI
<B^_X@rhLXc(Gmh>HPnHkaK;@M2ddcpuS"sSB(Fd%)(N1WLB[J;`4l==rhERI5pj"r.9&6@^
9B*;&uHmC?1_jG\qU+OQkl2;Y;,W?CN.^@'eb$,lk5o6Abm?G(=EoIodB:DkQ;Vql3Q<nK$F
s?:!RE3m6o,#lUK!dR,(A=sRG,_bZj?!&Nl@QW/0,e+K2)Q7PddVnGsGSJmP?%%QWKgcDCTc
OjM2KBpYfGj:MnHsYI4U+fLe<BY:amMT:0;'_QGLlm"u*OJUSb17U9*<sK$,M9KmVN_lBmf$
kB&:pZAF=oYEcdPbH4`J`<=d(-ss#&o9c!>_Sg6h]AJ8]ACDC3)Q`g0Y-rqlQ(b:3%P[lMYcbJ
/K2dEj7Q*&S=^IBX\kt]ARHV9q)INOriZ,a\Ef)B'8-`\u+dCo\fRb6?$U+\E@J=]Ao(79de).
RDk8`8#_UXoe.JUl%'QJ`F`JtqVfMI9maF!!?/+b;Q-TRcGo-CbS5W#i2^WH>Ch!'g.\XJaG
Yp<<cZD-;\LdeLIg_(>t/l&CPLL5og;#'rs@]APBs5_E-2K#kr^B__26sLtB;]A?\2$85foV6A
2FLgK)tu6UgL%V:<@r6!a%[nKG%iKGV>D5+ol$&jn3bAL"a8&-U(/eig?-H8o@58JIQAaE,:
.nXf,i*J,Af!1BXkD%>0r&MNFSE'OR.m`t']Ad&&KP*H;[FeFDkpu_H'lIA>iqKS=r.2'e'jc
CCiBA&GH`H(&i/U$bLX>4l5Ha`q_<?%4q%@2d[kAWn,..]AHe:q=\LV)QN$s/3^->/._Y5:V9
8>B7&UpGJXq2BA[D8tiPLJ`"L)Ud,t*JG<cQpP3d^#3b9l[f$1@;,<.A(h%L7"b'.ei"rlj*
P:h//LcU5l4c'?'o(`"J8PMdSVH?4JH1;O9I/4NBU"%$+Sg/JRHHTJJ_4j`$B"mR@Kk=L`NS
tgCq^/_AlD@nZ-jEN0odH&-OCc*S1.?d;TM/_U2M\OcY`"3b(oq'S>)>Pq?K/<13N!aW#^9?
SBAkP\6NH<0mc6E_6""n*U[(NCMA3j7q/S&4a/3cXGQ!%%$Gdcjo@enB*&qA%F&i_\r9`I6@
ibt,n?h&q<\I*/%jb*4fKSC]A'A8\g!%O%iD?>%S?L9$#jWBcG+4D/L`CuKH-!4&]AcSs#Bhf;
\/WB0j,1?k@mDLnO?7Sb'RATRUA#`Z?(%#$9?u9M4S13T,D+LAZ9h?rkNAR;I#G/*V%u3ORh
Cd\WZJe&u<<@"UQrHc>L.!hQ>TZchP%RiBqZOLc?!+iTTH3nqI(C4n%^q'122(Q$82Ht8#$'
q&A19lLICq>@EAlmlOHlCCPE0C]Adm%5USj(-<IuqA0$dQ0!*'c8<]A_:&<3opb[E;m>O\$EJg
u2pYNf4+B[4@hjFHiG#acj^[Q>+I#T5K.I6kmg=Xg(fO#5YUAs)"nd#tM@J="[SSYHq%qU+$
,F;SLU#KpBXJ45)0S9RH]A\Cc9>N.Pr]A,!CAUC$=j23^XA8V+!r?03&ck<'I;KTQ'"4MmBcn*
\dJ+a!LLTp`Z+8bO^VB84*WO@,I'Sm$&CBnpeK-'u,)cn%LmL1b_.g(u5`2l7j0TA#cXnOH<
ENg./^mjh@&hfA">b2Pp[r]AdZ,Uib@Qr--j/aM`B&/@hTrf;6=E+3gk=*abOY<t2!A['jc00
%E[%I[q1hDcu+($F_>!)fJF-HuL5P/HbJl!VWL&TM0^%!*]A`8>SUu-hi1Mr<UAP=VS_"9C63
:RZS8`s'X_'.=5[tGoU!n=HKKIprYG2rZOi4cL^!5<rU#;>B`2;QIgFHEJu3!*`79$KJ,,%B
=.>Ebbm:dI-E`C9:Je*A>j"f38M0RN2<_B_.Nb52\ii[T>C_f>hQeGp0[V[sX0&Z+aA]AZ[:\
Gudl&UP686l&+:[>L)X1;noXYO#*/1W%-fp'n@,kCU[96=s(Tq[6*HGOZe2f[SJlZoN*eEm_
6s4,#(_E%/ljqn'\l5Qi]AE1O9.gtR]AAA58":AV_)ao:+I]ASlce-1B0e[g=TF#Mj%ar[_<NR,
BpcR.8e4YQ6aZ[T6TJ]A4`o[[L@fW\GU2b4mb?k%/SfNq01u8pT%?H2VgugY56m=MpaIWo7us
P[N%D[#Gj'4h:-V`@@:QWLCd639[gg!t*bY/?/OFu(9`]A/ag'eNqgOUmeD0H94n%qZu$d1G&
8IS<PQ*Ncmd.EMDVgW\M'R-GD*r*Jkha8_G)m[I8L$qjrBq+QK5RqC[H2Z_ms5?.>H+Grh";
B+?!?C-LkQglpI;<2u*c67MX#?(Qh]AuPgE\(VQA2G-h,tV#;$\]AuUa;=I8<au+JqNJt\2UCj
/r\g>QT#.<HdEH,p_p`>eMYs=]A1sBUES[2,gF[(Tn2Fp$JNUNQ_QeoaFhrsW81^_`dJ,/D$?
04^X0#=3KnNWhQUGf&Ek@O*pIiXIPB0u=odkla#ZGp9Y2=#SEU@u)c[(;Y_>6fJ9']AM\*Ln1
?2(R9r+2\_c88ZBn7rPM'G6m8g7dNZMZ'N6$V%)k8SE0`!FjHbDrYGF1e<cafE]A=bQ@ad0F1
\)>PKod"j<6]A$KJ,$Ut>!PX(CEBFYdB`_H)RMPH1$h)!oo@H>OArag(cZQ#Ta\8b^n%FD:=U
?V*I0O1$;1If&kYlM_@'OT@TKXZ6lZNt\cm84JEJpbDefD"+BX\3TMa[lH-asZ6,___-RU%h
[23!fn+%3ATn%nm_g:s:+E9SF.&H(Hp*qH\Xm1Ll$`R1sS,'9%M2=G<n+)&GVF,G3QTQ2r7-
&.s=lA?.\kr>-%OGmoT1>9qA+mM_a@N$I,#p,9C_(>QtB)dp"2VU*H=\0bE$Z#;'r/9cX+XG
$g07;/GKMJ4*.psGMXVN!H8h8LH.2)$6@*QDUWq7H4V5hr7.p"]ABRMIP?=E`W7kc&hJ'3"Z)
o7;Fj!*$dg%joFbGWcgQ)F\.u2XH^mJPj2W+RR7;@d9:"C;4uiBO3IQ]A:XU5IIkpV_XSe7s6
W1t&0b&S16CA1.$2[/$i[PG'X]A*QIPhb5&A\H!)sUh!!i)GSG,RgF`(Gth!r*"Z7/`0HnNS_
s.+=6d9V3)&Xd$Uh0-R&=(kX'>GG!19@EC?*d'+c]Ah*"?V0cnJ)7$?i4I]A;B&NaYLoakIb@*
WMu7UT4@7+i`__:7Fr3c4q><TV9h'f>,"a*ifHi/el4<j!:Y2'hgJFEESIFP(oYWm*`1qq;X
^65EZ2"*=Ciu`%!G=!dq_bB+Y=V'1AJYVK,+ek9a6pp;O2-2NZ;$EJi(=gX?!R.,8<nZ^-!=
mD\o+G\Dj=X4Q#qO1,m4&ZS.@+G@DK"bq>j3\m!IDPY\N`7RKR00*"l[C[BWI7"Z\gkXOZ9r
.RS?4;k!#jt1iIhk_#;DO8?<AsQeG:Yn$/Y-uW)D3NHFFP[9@0hUJd=,('gA,(9R!./37sKW
JSqhJ;g5AL0H16__OnCi*!TuNd[:)JF6Z]A?o?$;hgR%?3A546tqfS1[%q)uan0JA-s>_#PT?
D0i59iE?o=H)biN=t+i[jW/s#5TGrCLeTri@/mDBeAuM0j@N"#8:g_UDP86!#/A`ntkFqP0r
ZT"G<&M@2,Hr?fa!GA0C3f1%l"LEULZ>#F!2Vgl60LGJh+h/:\bD^cE_8rm9J9U#mn'HO@)G
0B?PBk^A7^^sXEdnpL=M6j)/R(-[CB!8Uc8`B)_9HC\%NY@KM"8J((<Mh2+nC9iVt-JJT;p`
.a7%+ci*js@,S"i.Um?IN?kh$-o:J(BAl*%"46a`_;:7T6lWj4YG@Po([K5,PYrCeY(^dT'c
a3r*gLY8HHBNiBqjMtYFj*P.>oY:B'HmVd1.>%5O!#s$#BZY8t4$Q.:qhm.(6C'Z)<II7I5%
n>_H>%G:R6kD)]A1;(;ZcZ99g#EH4Yj^orga+Wi2Kr&HC7^R?V,?B6F=Oi,0lK6l:XF""`4._
W@#;ACJVCEE3`4DDVBAcY/=H[%W[+53R&%R.&cq7)O6"BG$f',[cp7]As?AtT1)Ila\D>6gCo
-hVconQ=VIiD<u;&bYS":oK?^\Pn)'FG1H\=aD+ND4,W`6SsRN!AQcDb/RW,?[<#3RFa&M@=
<o:FD]AJ$Dfn5.K)O3T\p++L-'H,Z_8:1&K&\eR]AGBeb'"YarJS8mI`ebRr";nuTN?Lg/A8TS
($'k=!:qL#kCW$eRZ>`G^qHC#c/RT+OiL_<qB'mH*=(')%:rW?Z[gnFDX'&PQK58_Up$J'-M
NHbAnj9EqD#mE;H$G]A8&1\"^PS-rX?$)([(emHfX7h>!AG,6u@o9([*cGm/:p;ttVl:+G93l
6UX>R=ubXZ^J+iJD^9r#VEo%CY*DeZ6XZ7TQ"L1\b/*e,Xu8Qq(!8%*&:3Hg7&&'!=LbZGM$
:28*acOsA8:"RXd07*C(aW;mds+GD04\.P*B7>ARV[S-_mN.lkdG`lmNg+r)4oZa?Y'/jOjT
dr3&H@9C@@;d;4VZFoI).k5@+/UAW(0EPSj+(_rI;(I5G#1TlcikL4&IYi"=bi?aA[JFo&'t
_e=8KKDG"TRYr.I*'\gm7Ko`RS7s;CVK1m+I`4%@T;ES7Og*WT3:D^2oQf*o9?B\mti9G=\P
,GK_X0IUO#hX*L@\Vp<'E\F$4=RM`2kUX'7_II)=r!lllo)>rU6;,dH98S>[ic,2aNc.bX*Z
<N,/(H"S.A)b^\$]Abh8m<c.N&#,=hM/j08@[AT=K*;qm\5naOI8OLHa\p#*C3%W]A=#rqeb6K
Z[(cS3SrO3A5B\dID`=k!pqcaaCj]Aj"_/ElEX^"YflBCX:`IQ#ga(A`?4IfsDVL<6.Ch%3Me
XDsgG7sCl)0Y/l1Y<B?I%92In!/P5]A*kedDHr[rE(h27.SoLFW?b2pWL5!?I'A-3-05L#FZ9
.ZNR3:3#17'nXoO/\9NkjIbC8`Jm+o5/6KdFJ@@b"p7UT0,LC^o;6>k+6ct@(IH@(3&t3>3a
.ZA1X3o`63o@AFdUG43Z`Dk7HP.6c_5K%Fj@>*<^A[Mi@=+@r*9V2l0+6#k:;1Yf(%!I4-)*
L&b:#[gO"lL4R"2A!m4\2E2n*f%OFMN3`en_'g(YGn2bUOlrh$qnq#?Icc2S0/29RCS2$");
1'1>2:=fQ(kg;Y=>TIOJ3u]A0]Ai1b/rKDlk0oBcj9g=2-<CEoOmD+Y*Wg<dP77M%$*Rcjqg3n
[+/>cFdVYW$8Lau!K^D*,B@rIJ=9<?G*.s,r8'kl<9NU-B!3[;Y!<XbF!JK`UqrkQZ+D*#Kp
PZ3QdPOJ**S)2+)9ZG,8"a%up`@%a,EFjVr+6A&>s^b.8BMplb<F!tW<Hk6D(\tl<SNu7[9@
Us`o3#e?L3VM@?^K47[`[3+L<@]AIq#o*o:'qZ-`8WYHV4So)mr*=O"Q'?B[8jS@!rtgnf%Y]A
G(H"c.+U<gh>#IAh'D?Fqro_8O')(DkmGZa2EUKlf"H/*_*R:LAH/)G26g7kq\FLVXJr@fQ`
G!lmMn*gScYk"8EcpU-u2O\t0AfnCpN/:CVE2@["0bdqF"3S!uFI,<.JWX+q]AmtA4#"[j=TV
jMfA"7n8bjkKK&PI\q*b_8s7o#!Fir:sPA8dEEW7P.=-#QL8VFl)[<$e';!;a%::-c.^-`ER
h=%B#?.$nQN@[3co"=SXQ-6;6*$:A;Hd/''IkZT^0("s@d?0GG-A*5W*duSV<_pi-lZ`[fZa
Kgm0AqE8629Q*ar?KVjNof]A40SCX&4r#&WP#7U,*&n.0Jn52q\&kk=MPmZJY0rj')gL2m-+h
$C"Q'/Gi!lO#hdM([<,0.hEB*"r.?k6UPQ=/gC8J>lHCE4>e0r_5\4A34BMgS:-_QJtD'bbY
?p&HHDJ`up(1NbR]APO1-6?I:E=E+VQLFe*uXr-f"H9#8sB:Je6)0,$eg;BBW0jYd#6q@?/Y-
7uS@V#CsKPT@n(M+X`1'S!eOMrUY+@MsT7AFOu]ASG'/'GKgfe[9YPo;Js-g,5"=QFea6KK??
<'OB$M#oG.9S<q`1!X/R*[0RiKXYeel0kIHVO=IIIWcb`"P3FK_94=n+-B8"pR^.TVB:p>a+
^e%+nlVh<>=]AX0d3rRg0c?o1?V6tqS\#m?'<lqn(!Pp[#V,pBX3#IL)<6k!KPM=`.Jc/5,Y$
8a]A>rD.)&HSN&W9@lf(tt_i&;u"R_3!$R(sA%]ACI?:J*6D>E6+XdDln>lr/H[Xrso~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="448" y="196" width="323" height="96"/>
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
<WidgetID widgetID="05d02478-05ec-489a-9d7f-fab75eb7a581"/>
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
<ChartAttr isJSDraw="false" isStyleGlobal="false"/>
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
<![CDATA[近12月准点率趋势]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
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
<![CDATA[月]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<![CDATA[延误量]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="1"/>
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
<![CDATA[月]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<![CDATA[延误量]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="1"/>
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
<Attr isCommon="true" anchorSize="22.0" markerType="RoundFilledMarker" radius="3.5" width="30.0" height="30.0"/>
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
<![CDATA[月]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<![CDATA[延误量]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="1"/>
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
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[时间维度-优化]]></Name>
</TableData>
<CategoryName value="date_time"/>
<TableMoreCate>
<oneMoreCate cateName="年"/>
</TableMoreCate>
<ChartSummaryColumn name="执行航段量" function="com.fr.data.util.function.SumFunction" customName="执行航段量"/>
<ChartSummaryColumn name="延误航段量" function="com.fr.data.util.function.SumFunction" customName="延误航段量"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[时间维度-优化]]></Name>
</TableData>
<CategoryName value="date_time"/>
<TableMoreCate>
<oneMoreCate cateName="年"/>
</TableMoreCate>
<ChartSummaryColumn name="准点率(全口径)" function="com.fr.data.util.function.NoneFunction" customName="准点率(全口径)"/>
<ChartSummaryColumn name="准点率(考核)" function="com.fr.data.util.function.NoneFunction" customName="准点率(考核)"/>
<ChartSummaryColumn name="去年准点率(全口径)" function="com.fr.data.util.function.NoneFunction" customName="去年准点率(全口径)"/>
<ChartSummaryColumn name="去年准点率(考核)" function="com.fr.data.util.function.NoneFunction" customName="去年准点率(考核)"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="f3587271-1a6a-429e-8066-288a18333c7d"/>
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
<WidgetID widgetID="05d02478-05ec-489a-9d7f-fab75eb7a581"/>
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
<ChartAttr isJSDraw="false" isStyleGlobal="false"/>
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
<![CDATA[近12月趋势]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="1" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<![CDATA[月]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<![CDATA[延误量]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="1"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<![CDATA[月]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<![CDATA[延误量]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="1"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<![CDATA[月]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<![CDATA[延误量]]></O>
<TextAttr>
<Attr rotation="-90" alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="1"/>
</Title>
<newAxisAttr isShowAxisLabel="true"/>
<AxisLineStyle AxisStyle="0" MainGridStyle="1"/>
<newLineColor lineColor="-5197648" predefinedStyle="false"/>
<AxisPosition value="2"/>
<TickLine201106 type="2" secType="0"/>
<ArrowShow arrowShow="false"/>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<FRFont name="微软雅黑" style="0" size="64" foreground="-1"/>
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
<![CDATA[02运行指标-时间维度]]></Name>
</TableData>
<CategoryName value="日期"/>
<ChartSummaryColumn name="延误航段量" function="com.fr.data.util.function.SumFunction" customName="延误航段量"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[02运行指标-时间维度]]></Name>
</TableData>
<CategoryName value="日期"/>
<ChartSummaryColumn name="准点率(全口径)" function="com.fr.data.util.function.NoneFunction" customName="准点率(全口径)"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="bf320846-5647-4e49-826c-794ef8c9aa8f"/>
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
<BoundsAttr x="28" y="183" width="390" height="189"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="延误分析-标题"/>
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
<WidgetName name="延误分析-标题"/>
<WidgetID widgetID="32cad330-66a7-48fd-a9a1-47919782b329"/>
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
<![CDATA[1158240,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3261360,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[延误分析]]></O>
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
<![CDATA[m9G-?;eMPr]A/sNCSq_CB=fi;r?&mq`3`>6:"VOA8Yst_SLISON6S5_dB`SA?Jg%VPSScpi&l
DT3@nb@9+V%sL$4J5B;lPTV8Lgea#*Vo?&Hc?\'+"EI2pRhOc8=GAP]A[?jro#kj9>4d%o=iQ
B^@-7VUaFQ_>e"la84^gc)qM4K'GBs]A;Fnkn^@q>_nP9Wp^@Y/kaI\V*C]AB#aH@5Wo>$e"Mn
,&IDRp0W6.p^&?RCW6lrHAcQ<JN-<qYoM:#d54MI9PcHeNUFG:%HM[F6O"'kPsgd9D)\nIEW
j$gnNEXSD"R=@erpmUi9K7R\IH!_dBm0$Yb+ii+MTU/mgj&[3@)s\3O_1I/bl"l=ki8.E;AO
Dnb5W+*<A:@MpQM%kpgW?7]AS8=8gY#!=.O0NMNlZiEQ?3s2"BXh-m+DQNF>N/Bqkt::2:Z.>
UJn,TUcj\?!;<oq]A$iJ$ben8"aQ4CmXh"N6:iGAD'5&8P'OmDc+_c9]AS%+O3+M2>h\?8AXPe
>R(MfTj,MUWTnPg%fgk9eSM-Ic)F]A4a8G^>se@'Ph@]AnWgTAtiU9d)t&brf<N5e36AdB2k[C
s&%qX1WhFdun5SnF*`&M+?ZQDF(YM>=gWbc51a*D9^WdH,edSogO2XM.IkQG9Ee3mo1CpI#F
qsO(FbrCW\>af'h'H>Uc`(Gk[hEHjftZW)u+[7P"'q#p\u`.a70Nd%-V3b\C1+Kn$l(b#B$<
MYl>'0(V,mM&"S#Gn49J(<+;QekN#W3T\ah"0C(_b^t)mFI?]AQZ_fp]A[Ya^d8rUm/846?u!^
lE5r=kkioBAPgC0&KGXe'3u:fFnNhVd`_&2hS2[;*p>g!-'">Kua+NKZq#O8[>)oD"AVCsR1
.!Ob6\?>s2$eJ^cl8Q>('&YE["q;`XU;]AD+:8eRG[0I_'`WVp[n8_F=%+%@;V,'2#WqI]Abd#
m);PXh]A2H"egNKYN*0j)k!I5K_ZockW-.CA]A9_A0ghkp3[)ft'J><\s*DK;Pp7i:C13]AM)QZ
o<IAbC<ATQD7_+OX0fRI/P.[O%TN<KC&Kd]A>4]AnXiX?AgK)1k,.0k;?*S[8u]A2g`@GBTK+%l
o61[W1g'><o@I/d['nite(GDh`7>.bR+,<E?+)<,;JZ%Cj0(+F3j-I!O!,A@&c=*$Nbn^rn,
&<^m#h:!+B\0UG6M1$G\UKRDpmQjra;qGk:OfULf#f#dsld5^GFB*fIlhp&hdSah$=;aVh@d
Ojk=&2fo[@6"id;mQ;K2_o>Q61ls>;4pu73_&/dr`AgDN?o"e-FbgVkjKosI#kEc>Pr>t4+$
J\[SGUMuM<U?!2Q[\a:5aQRP#.L\tR_V,O"m'"H"E"@A27HCS=UCT'+b=WgT#=W5$\00cT)E
:k3M5<ifX?c62ua`-@YAVe.n0`0#&W`,j3Z6Di!/*DLDPdUYO0WB#$to::#&5nNJEY)#G1.B
3(BgYZQhn[M&TZT9Q>"&o9]AEprGCtnb,:O]Aj.-.>I7Kc%IS8^,b\%+SVOC^'NmtLm6KP43;E
P+B48%j7!)Cu@n*N+9epMDn-0)`F&ZU_pocIoic/;2K=.QBrAUQ[?'b?`9QUm;0O7:&]A'#Mk
*^AD^t:E(R-eJqHZNaE!tJs!Z%UP,ccEjLS@QNIl:atBJZKAPF*WXCZ=0+8J0;)iLOPq=g+^
umG[.BM0QS`t]A+F_`tf]Aq=705W7khT%"1nU`tb^aY`3_AG\Qkr.YJV`8&k/d[)TkmIL@KFhI
h05MWHT%G3\rCE*MJ[biG4L<&-,\tMVPprM&D@nU\sldmgp,7"KRh/o4g@S/"c^8`<=[,$72
hE*=_"5pX"!#V]A16p]AY3)=2-Ps%`(39,JX,P(Wp*%Pk(!CTW-uJ_=j_E3R/'\SAkfmN/+j^5
jF=[&q`RFoN7cs0=i-\ae\Jc#OmXCeB20j!%n]A_?)oFgm/>HS)P;5Wk\F).qt]A/L]Ar7M$*o,
d@]A>iF]ALYYOL;YjR@jN[h+ac0,=Wj&=T*$0n+E^5Z@E9Z!([O0EZ4VK%U:_H5@o$5D4"S%?<
M4bc8k:58SXHU2E/&aSVk5V^NeoFq1iA/T&dYCc"fL1I2V0-d`$#IKl,L4Vi%oKq1?6:bO<p
%*[Ld5d2iM5P')WrV?f/koXjMTPK<HL*U1O/aOX?mm0DnDPUbH..3W'$$ACb@6_17ru]AFcp/
56U1ROPWM8=;QXUi=>c!p?8q>Y^qb'_9"q<WV^.+,6>0Lf==J@cLO(g@)2m)#'t6B"KTj*N6
K@VE@#Y;'hr2S-DTc*Y:3#+k$!Fs[AC=nl8!;/6&_Ga9-ur8J`UUKRa*ueSsdG(j%.k3oki:
KPHNqeE"aBlCCX"WXO0uPk+#&&F03Ns%gXn5,oKC&2AR$#8'fFY'u^V0[H=o)KLUN%WB;mqZ
/Cj`Ael<PH06SD5W9fl*e^"q3dYMHAn5`7]ADZ,8l2+7+4bQk&A9oUG]AP8`fhc3Y5;95Qu*%)
0uJI.Qc.fD?\_tc1^HhpQb.9QU4bSLEdoR%>!cf,#[29?r$E7LTm"1\smB]AW534O0!relGDH
V&<FBekcXTPD3,pOk)qG6-)Z3qD8G9:<r"NO"$0r=loNLa#uq!]AMBj*llRC&*WFCEac(hBF4
B;=F.<AaY1U^+:KlV/3.$TrjAa4p*HL$YBn`5?/oMN;7_cnQd^s)^hr8)DmXc93:/7#i9Vl"
-05HepVm6GAmkqSo;h<AC0'CXgEK!#N%,'aSU111=r-05P.c4=d^,%_S;q^@&WU([^aqf9q$
Qpo\AY7K.>ub9a:o`=S!B"<7*U'lK=B2.o"%d1nUe\M&HSMQNcbm7#o+D0Ah$D1h#E*Wo/_`
+Ng6Sf/<dCtpX@.jJ42fc:%+_#<Bn\E8TMkK^*R`G'\U:Smbm/gY,Rt#Sq978g3)o`@qr=DZ
3#UB'B9uL?J1MA!\i0l#:d;08<#DTW_FuOHm>5dniHc9?cPl1)\6u.fboMs20uaD%N'aLj\q
Xg5".&4iUcKKJ\@?tqW/56.al*i!R.l68,8:n>E"81:/kSI,Pf<53.m]A^H88%6JN_-0,78b$
"ppHWT)Ym)EiPDKSXAR=TKsBo`'Nu+]A@sXOO;B`fAgJX\`2!ECj9OP#_F5,Q&DK`hT-<Dh9;
J&t<T@H98MIu30lWg4FU<i:d)Tq#M-o`]Ap>T+4WMqiA6M]AGh@*H'9`@UqN*@6XsYX6rs-jVX
MbGETG$_2PjVi>p`o<!5#JhpZ>84c)EbdiV%/+1">G4Ao<1<$]A<&q,^HVhV12NEk]A,h&[Z*d
:JE\NHTcg[]AcJ!."ZhYkd\TRc-G]A4T.>01@m!oHDIY9u.)Q_fTQQC-C*Bqrd0>HpGK+Yq-r:
lu*O%eF7D^4/UK8'o&H&:S86SP,F#,JNTc[-i[XL/72(-&lB3t+<OaLN*pAl:pO*O"K?iffq
l!oSH87u7:8*UJFdk,+f^WM`TBXQ-pb84##*!S/NS.rS'*T20'hJ0f=5mS6ld0p]AXD`p>"U<
gTf1ML8kI;Xi?nltXpQ7msRQjR401(YsAJiaX1@qd1Lc)8kF=(XoE!2eL^=g.=5lZ9Eo*aU)
qq:.Ym)]A22mQJ\'7YcB!Unl"`-#EEP^UBgF/NMBL#7"),4P=s)F28gt3)Wui%^)SL>T[EraQ
S:_L^bG=^I[2eXG\uKE?6_p:XA2$!&S3bWD?<-c$?\+k]Ahk;5r/HRle&e;JkQ@%W\eTAb(T5
Y"&d)nYrd,aZ@GiW*`WW]A*>,EF>=WqDe*nl:bUR"o-;gbB.JJH7aSR6XZ[VUH]ALiQf?rB",i
(5pLQC46HOahd*b!pa3/?jd7k'je]A=jjMRVVH>^3=mjl_V'dcQm_E+,Mq*`e03Oc$dVn@c;K
G]A?5R^g3kp$)WjOsUPiW>LAWnTgSPWq*n?7;!gf@!>nW_F]A.3&M4[l$:7]A[Z&DGUmi"ULm(J
k4#U`)f`pAm3?^)PNk_rkM7Q1BsIBql:@C>PYY.=jkLZ?Zm"FOg<<"A6&&P5A2Yitk-FMHkX
3W(pkLM12Qn!cLi>Sm?(I9im!PD4f7D2`+sk%@6t[uK@4>S3NaS;4F*lHA--SJ]AP;_/,0.i<
IL&L`dN;<Qns4WK(tl!;]AYj&WbTtb(^$.5=h^o+2!"eX,e2E$3l'\Y)/_o:=m.U@)7@++J@M
)G);%EOFi3.np*C-T4_kNAgVZ^l\nP;%gN/0j[u\ENh0_7d/=OOn:)BTfJ_=.6j`QAGR;DIq
=@hKlWbpgkV21N]AJ8_@I9O)a-Lc`\[*FR)Y=c>RcClYB4nd9^Sjf#L&`H##+cgra&n>JE;`>
tuWn]A0uA(_,ZLpK2EFDdQS!ZWu(3lBl.8:4ihge;8[[JOR9"M83a6PUlVfF)Oj0R7_elKri8
*.H^1&.eh,P^0ppG)-0H``5Z$7SCB"lp5h7buc'%XFqjbqJd$OL]A1$YHg-SpN3/eSQU/]AB*W
)3NKek$*%-g?9cf:\8gBg![4u[bYA)\Zc;Y&3@d?-asm/oq`Ti1`-19<((Gb3J-EIXs'RBR#
'q%38(5#adKF_Amr1X(.'5j8r%HtskA*LHMXcC75+ZOb'8+@bKB7PJllk!d?"-8:R(P\.T#/
8"l]AT,<4#P9/WY1um=UfQesrP/21F]Abqkc`e2YaLm1DjP`c!>HMjs0J]AMjJeUg#n$BtW@R9A
5g)Z2qK8;(k[B^7):al+6[=H`P,iq1If.jH&?4'=@:rP1;`lk(F$1ZcA,1,LhKX+r:\9A7[o
LWJqej`p-T&`Y(&%e,M3S%=QZ@JQc[L9hup&K[MA.n,I7KG"Clf5G'$M.?Rf+p!u]AXu";n2Y
^[5Qn8mo)n@\cU6(oN[7maMV`AW4?k]A#9buLOt/+[1pKC7rP(9H$Gjf&hh$Hnd6G-R;'4DI!
sV;*N',qc>Xo79t+S>[t>f*)&=Ed)*@e%E0Es,P#c"3^;nOAq;nPuVpr4lq@YGEY2g."/o9X
r?Yq$`%Un$GG'R.KbAPIG0Wp7@bC.i5H?5^-jSs.s>_d8YuQ#eS^:)Ya9FUoljgJ$.lX"/r9
kbKb^#kcpp4ApJ.NiILaR8q.r)Hjok7[0G:!sfE_@)WeI@:WGn*8$b?T,5))^E$LG?M9)13$
AFL))qs/hWbqZrmLd$f`!*Q(4Y.l,q2R\o"f:%)Jh:T1KH(s8Z,R".ViK`K3VdFoEKDu)~
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
<WidgetID widgetID="32cad330-66a7-48fd-a9a1-47919782b329"/>
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
<![CDATA[1981200,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3261360,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[总体情况]]></O>
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
<![CDATA[m9G!;;eNPZC,OL</rNrI$6eG%Mpk\F=pBN\P1A9TH6$OpD,GSU.!ULrPXaLTVrLV<=IZ\j?I
@09e@(!1+[JLgJHS=d[U?&qOl.J3a[dmA+_",3hK+:T3]ALn74)7:J$A:WKMo3j9^2JMu[t"9
drp]A6uN($MnJ&9OXDpcR+?@(/Jmr>4shqWInI-c\]AhR;"]AYFodn9/!qYHka8[QlE?uPDho[Q
G!-<M6/.smTJTMG(?@Va-o$9\,F<.rqq]A;=7t`p=]A;smj7n+qGjGb4;hA@>/,4S[Y5M+phBI
,G>Wq[]AU\ekU/YB?"C\GmdnUi8f]A5rJ7qYa2#ZFLPS`$%WMDhTmibJY^Ms&n8%T.oUZT?=A4
nCGAPj2?QUY-9Eqh4LTK/""a(/Qp@q*;\9:F?bR]A'66F,R9ja)-C!aM$BWcrb9Y^&A2HNh23
.%*iDd`1h<#D0DUS1!lABJeZ.+3pr1]A]AB<b@UJDmr9QH`JQmI?WfDAj`FBqeeBcIWiLn/$qh
#Q&GHo3N&ZrR(Ac1l`)8`8s)pq\O@6QCjY7u55KmX1Pr<%$@^^O-ou%UR*/9uSlM@q`89'm<
j2Co7,rUP`YnO:]A,Zj]Ak!^Q8gRWnm`.3SCqf#6N/([b2WV"A@(qp_u\np@j>l@Lm@4F^L0X[
fVC1:tWX[[JDZDN[e=#>Md(BdZ2m)DcQ%#%A980.QDONt!_L8"GDU#'@nPZ=Q;XVK`L]AT\:+
.WmC]Aq((]A)E-:Xo^-;#Bmq9#1!o'+pR_E%8$6?LDajfl1qXM"'Cl)-I%mtn\eV#]A2.h(R';,
ueU&SIfgH7>AV^kmt!F9E[Gi8,AMSqWU72RMnLQ-bBq[C3/K=Y2@2h`lbsX=H\U=]AI3iZ<BI
p?6rf)*OXQqnq8jfFYcBn2C,dhq%XC7TLcRaF7!b'>:&OI+'uQ1Wc_YOd]AIgeq&A[!]Ac,S"h
3I+$Z7s=r%-J:l<3FSaDRMVFUR7;T7Bb1/kW\N/KZ-9>me%fC?sBoR0jA<^^1&_E[3`0S_:/
OTmf"`a+E%[:d7F8=PbiOa%qb8VUY#H\@g(Ph8d1hs5fXIV3G'WDA7ggkV9[RqgTFVB0Nr[A
)KW:<g!SA]ArPZAp[mne"IB!J9CRfWC7%,]A5bbmNOcLE5*qRu"Y&1_fJ[NEPahM!4E``]A<PFS
#G8gTX8e=.Q3r2c]AME7jVGlK@,jbJ$T()h9KE)dh:0A>KQpBkH"2),.YRu;rMDi2bfT%g`:(
.2NV/^qSb"<*cYK]AYKZr\]AC,W-&H>Y^Y,\t_#40O-?'SWGGuHeeLnVV:iZjgKf7,fgRgEN3]A
Nq3]AIO,U3fW1<YKuAKTH`(lpfU6YM0_8O(JEMJ]AU*YMuT.e74bJAl@"h4%[4>6BQ%DnC8O+&
m]AmZoT9L5.I^Ts*I$ZL7I79(=@ld8A%A,*SpR]A7Tus5d&'u-k"9B1.bK]AY1ifOd;9ASOO958
fte)N</lB=LG'Y[2Xg*6LAHk^LN&k`*hlR3&sY04,57+MZot"EDV!a:BIIiHc=aghnQ#sVnp
2XGU0^JEDu[%"#3iLUC:jHWmi8(RW0KqH`-PjYW*6$Eh\LjCo9$"XaXCZb6AmEbEn4R1$Vpq
!>,Tru`*KGoSGHV,7^3Dng1DZaij@]AfHkl'c34ThaiTbkJBb=)[l1UVB+ZWu3G*)2P>Q=A9:
2J\I`=5I8#C(O^Xr;elRLiYf)Mo9F?@'/To\I#o(MNS)g@*7a:YlFM?+kSe(^07hM8Z45RQs
m6,3OscmCaDZM<cfIjcm,fN\4Qu))!i]AV:TY*r64t_r-H8\%ra,YO[,9q=pgDkd=:+O-,-p]A
%0)J)+?6V)e9bjVm^[]A(8W;s<gEFA6\aH9)@0h'u@pr]AEd$YIU80k$M;:,FLZR)ttI).4SaL
MZAo[DjO6"$s,j2>e,QL):V=`n=P!\s0&6[!bUCHkTC?#+3[*V9:"0/[eT"&8SY?=&HXAYX-
jKOFZaJ%_(u6oIqJ:r,m-k`."K*6eN;V^F'OD%&eRNVK"/,PBiN=%IPn?>Poj%/jNTIXLq$B
;ZJa>]Aj&i6'+hG(lDkN:19a+V'`uD?uB\?Rg?kR,*9K27Pdj#hc'GRR!@7lW#C8R2"4RN]Afu
Gf0Ipk0Tj&J68U5f+ZtAcV!+E[M#Za5+p\a4beolA$b_V:;kTWfcRAA=a[<Z4Yp'R9#GOlC\
M)BU?1^cpa:@ZEEjT*B'd>p")Z@I'P+Ra724a$Y+OOoIFL`S(;$\c&R<gai,_KN6mdaR9>V[
kVd`K/0-OdIX8-k:JBZZqr)ru6>Z(?]Ai"l&XK'_HaUYROWTNXQ;YnTk2"#"O,(GK.UK;4Gb@
=q54]A1+a[l?3G';D9o8[X]A@Rf\Q9Po,m=pJ;3#,sV)Y[NU9ru>V6;(`rqsSn]AMiV+l,+$N3?
jWdpoq_c'9)5qH#%'2A]AaSr$#unqqO+G9\Z##9<@>%c:$i+]A0MYPpkdu'h(OY'uR+^?uh6K;
ZK]A[k$n!*N!<FaBK?7e>Ub_HAs*bDhr&I.729/;fXE8d4jVp<-O[V3"O_G<\0P>rekHfKTQp
2]Af^Kb:.U0!tDX9WHuBgF3CerV?,[^MfYMu&qo6986t\,0OpE_3>ib-Ji<Y^d:WJ[CsW?SU1
pcC`&9+JN.'.'?L;%%c'Aj>fT$56H?qE[m[`T7MS[pQf"4i('J2o?94N?`N'"nt_pXo,D*j3
6Zq^f%e3!Q/6_>9$8]AVCGk/@XY4#cS(WSX?XL>sDJ:`bd^!2;?nFY6)mVW\e<DhWfOdULbT!
Q0'G\f/"PD5Llr#;3&5cCYu6Iifgs&45A9T$bWE_c.-`.?R@g__J3;Ss8(=n$"sk$]ATL]A9_#
>7"OuL2oKud^jd%uTXJQb!%5H,`Z2k[&Gg[G5c.B8k[;=W9VO=,SO#mt*,@u-C1.6!"WYpF=
ic_S,=U#OnfO%:U'a'(s]A.;OB5EaDfr.@Jc,U-:l.)tN[1o\[EK8J>:7S]A_M*LL>!HSUIMio
)s$IJQ^ZHJ_9IXC*B5akc&`6[)"tHP"HhYmu1uD#I$8-V[J*r_t3Y!Z@dZ`bcnj:3=e"TYP#
m>0sl>n'a)1c,Yf423*e)-KtL1'>\\LK!3bfX0qn*CX^XKg9#[`\Je3XP56oq;'EMO%q[rEi
tXRH%_ENhJr,>7=<Jg#2dCkt&MVG(F$$UJbhK?;"-`/Z"W[-So4UFeL07H*K@=N,/^$ju2(S
ToaUKB<89*#CaEM%O^-Y<\mFEjE6$nRk/5_\!]A[/ii@>&$HL*lZ4cq%.SR%)"J)^_>B%q8_Y
j&00nWBCJ=eJ2qCbk9L#Ho6V5>#XY-P>K$qIW/bhk9<8:&@k'/gs73XGjA&7(QR]An[K1X,<0
a'=qIjKb+S\:38%CcDbi9&lj\LI!/j1J'(om<1-9^l-`OG![&9aW)C4Z`P5Jt_nNOm=;2!R#
6/.Y57I'b\&BZK3iNBZ1jJ+Mh&BpT=/o\ZqMJ"GOTp71`B'hc<"=YPp:Na[B7"S95or1Xbb1
>Ij'NJ936l9cl8QH1B@K]A7pPVBlS*C&0gZq%mW;(uUQYi=!`8kURY8n$,.JCKra\@q-fAb1@
>a#f#Rg%6tD;01@Q/Ed[>L\Q'nPQAuSo'`;OG`_"Th9td50*uT"ug1KOZ?o]A^n4,RB*+YpLo
Sc/\<[EbI(6tp[BFA;bgR3ZJ\A7Qji6f9#O>"h9qX8X"F(g,PUBqa9d%bi,T[!Z9j^;m+N.$
?EVD$_VWOSW]ARpNdlgZF<%IeLE9:Plf==1[F_qVD[kCih/W-`<Dme@o-HrDaQRuFu%N55W34
pN`hAZRdM8>32o(cr#*6&\[+Yra??]A^'5Ohi0SpD^QS0,AX&X)@d,=MG2"2VQ'IPT/TU[GWT
$(gJd'V,F?nT#)g`4=13M%2l6^-bt+k\Y.[;25??7<XL`KWaV3b'l=\nK4WO1mkMSt8n+N_.
"#M^50Ur4DJ^$5RO)"p(%Ch*gObkS8V3Q=\]AMWk2Q:\#]Aeo^-RL*iDMfJ>AeeLl11_S>!a-V
?^"ibeBb(@6WLrLi\);:HqrOTF9J%Ui`gYaPqQsVVLh)Xk";XU\jcl0L0.qu$D$Fh':BU;Rc
6*S\G`.5qu+D@"(UjW+_H-&;/[sPToRF@ANSe)_L2?FV#Kemg*SP:RJqc(X4Ad!bHsLc&o?;
';f+UnZu%ck7R<WGCoNJ24^&%/^LOT:n"bSR!K2-oD"U%-1ED!m/a&4=jiehi+%&1.L2+l6W
_(Hg*3<cIET<UnX=b6K>@6L*!Q>g"[[S^m4E1<;VQ:``3q8YU:iKDihO,#7R_qs$4g;eUZIF
$&80SBCaO]AmO49:E>ngen/!.bu`P"nAHU*]AQ!qN-="TS'S%Tj\9M%5^Lp%k#uI]Aa7'k8`Q?O
X'X?C[)';/QAe;330#JMphI^]AP`%(;"nMjpr+rk6fo`/EDqo'WBooJaj&f]AF=Nt!*enMW\!K
^l",GR1rChOq2`6K?-q-`5#CjO^[>Bb>/7@.p0&%hJ+J7p&;R3Z6r(pp$#&\_*'=Q2pB5]AE5
7e%pScB,GGQL*<fl6(Uj3C'<!RN3?`kC?V3b2,;/kl6cn3f?KC"VQCjfG7KtC^2I]A+3AMYaC
,V;-iL8mdpXbHqoYud#5dS"W&ONDHP<'KCn(_kSA)*(GUl&Ms0APYC+3sI8Q$c<&l-`Q-Iqm
>r>#]AHWeO`6"aBGi*#tE's!*5V<5mT7eWd^oEbB0$U`cdF]A-YdrC%m"U572m7g^t6hiSr*)s
9rc=!amU<3&odGS7#f04JZJ3qUU>gt6]AMD2g1+jH2J!ch"#pTZGCKe#'c^mX',>ZnRL4$6n"
'"MP[EZ<kFpgOO4@gb^jLkZc3(*7'9L8PB*Ns8!:^17/6uaD(m_RoCi#.qmBi;I3`29=W]AA"
=m@U(lTO;H%H^$f,7-`Vfa]A2ARI1?=&N&@A+)dVTIC"*W(BbK\s1JH$+hWcV;qhj5@XY#Gsl
$$Z;gB\Jr#\Ek0\QE#<oT;n*rQDQoGjM).9<b+29J@EK>gLO6E"a\f2&ASGD`270d=d+EC)&
RFIdbI<I!O,Wb)>%0c;t1a/V$>)6CE,dKcT*Q"&\0&)0`/<"WEM,F5/'")_^(cTYet+FN3]AI
:h)<!7(CKR?E`Xmi;PBR9]As%cUee.dr*mLgk4i@L)dhJ";Z2LkHi=3~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="19" y="390" width="252" height="41"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="出勤率-标题"/>
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
<WidgetName name="出勤率-标题"/>
<WidgetID widgetID="32cad330-66a7-48fd-a9a1-47919782b329"/>
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
<![CDATA[1158240,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[4206240,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[出勤率]]></O>
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
<![CDATA[m9G'9;eN\^nTOTZ(:JGA>P[^#go`N;E"s*Y+DEc?j%!0Z-bIks8b^r-[<=js1D5l,ehM%qO=
H6P9$Auj9#lulR@9hhS@WGZ!Kr$N,)_Q9k1`.2&jj[[agieQl'5QG^<Ye#91nt(1E9`Xo=iO
rIa@W_4jSKGa20F8B9skqM2R:=G2n>/Ih<Lk'Ho)HiQi>?!5J)%e#U+?iq?P7^A]A%aY&.XLk
hSBt+*jocs3joU>AfH<Id$AKjn!lCn".8IoIkd/^(KPeCO^&qSptL+h'YG^[eR1eX+,OPMgO
Fd,HUt;+IICRNqnTEq'X\<MNWfV<FqIX?ZihZ;U#H]A]Al9]Amqnf!1$eVX3g':OhFZ73s/$n=&
$[;WNZ.s:Plr4^jCK;j(p-&=LZ\E.6l(>V]A:]A?i/*u`!i+nU9JB_o>FIs3%t?Eib8bkai2mb
8,O#mgZL7S*ohV-t$k/9[np=+W/Fk;'a:j^^b_\W1B8=.=s7:QqN?3Q\ul9[$?EH3J&t><Y(
<C[ju_5hi)JATVSi]AaZ9^FF>A_0Ut\p?Ku+9b;lLR/g6A@$@SW"d:Q)GhF4]A_\Lh)e*8N9ma
pX[,QBG=D.q[MfeV[eth21EWMG';Y742BCr,7J_qgRt3^.(K^/G.!^8M"Ee\!R(A,0d@h8lq
;UU8CM>nV0ObGB,X3ZS+2gINjrraL1;Acd2r[+hHTL-2R"1'o@B"EANfV;Yu65lY,bJ8eu:'
W=VcJE`gK`OY/KHmHJ]AeFABu0jO0PD,%WlV<*juP?-G]At9anGh1S(kEl)L$_GM9@'aa2\Nr"
nplY,[r9M-P@ga/9j#Q']AW&r1Nd%gc"Wgd#g5U=8;7>Sn8*g?ZfEi<MuU9Y%PAgpf3/?eE(S
H^4ai2?Ge47Yl:s9Kj960(Rcd:kM8U<r%<K(hboqZa1)JZT;"?2VpBAZ\`=:4WlQJi%mEfYc
;>*JY7r9=XV8pt[=>O=qQ\qdSXV1Hs&M+BfAAb_,,Ak<o3:2X(mu7DcbVH^]AgpU=hHhKG\,?
2epbOedch)_"GMd2O2sM;R/.mBc'mcgG<4.]AVU=ZK1QfZZI]A7N+.*ri(g??rp5OH%@CnbpW9
]AoIqAI=o)rF7N(I2K?(6R/+@KUM@F@`&S@B(KNnkkaZ-r)\LK^]A-aEg8Rfa'qI`21?gAej'E
q3oS31;DDHhhl)OWG:/J[#rj_Up-!8m7`rMqIhD.f47*SU"&@`JsjaB_9:Tkgf#lH*nDjG1W
\1@.C>_:Bp+)DfT.:r?#1X:'>3gn^L#Wt\2o+31T=]ACUHFI7V9"C3*:Ac1c:=hYKcV\_a:L4
FlJ$7eYEEYR<J.0Gfa/hB*&Vbs^D8NemOlo''H=iU<n/(SkX`$Qidcg:Z&^ra-GgH9#:Sm(L
eq,TT#6)Gap+4P5+9[^U=Pmco.[%_]A$b>.W1K66MQmBDD,H,H1f@6%'VJ[pRWLeJ1:E#DbKB
o8A%U'+AC`Q(E"qmWm8"GG?!;:.lcRg$sd_)c(]AEF2BDJAJ%SNJaNf]A4[&LYNR8?pl[MU&-b
25"aaPH6YMg9JUhnRln_80HK<83);%l!!HOp]AT+"#.%9YUEiE-bOAKLdotJ[1bdb>f?2[bdd
N>]AbC*]AO7Rr+!.D"5?0oRU,6N?g6r/up'VNQ6(I6"qZXUL&gBHfr9CV"+B$gtAGT*\)-M>J+
\UJ2W(]A`APQ=rWaqmH+A]Ao>[fr<llrqXL$Wj;,c[,Q7%GRiEoB@;3o*'VFhVXnHm=(nTKO<r
_&pK#D>/c9oLaSIr)U;1g\]A]AQrC;N:Z<'l55b)8g6(5GWjR2n+4/dd*>/3,`u(?i#d+i#gcj
a,@_sP![fE21e=^a,MiQaQhV'r1q'peWesASFW^(#?p(KYnIWRc[i/DG7Tquq>V,DRR4!Am-
F*?=j>>6)6a4D;^)&;HH,,ON]A(cI"$PF'.G<;Q$P#rl7Qk2[q_h[2(9[YO/>5%(U/.?/Jbo`
mV)FPSr'<%G'mQ[#Dm1#NA41GoStnBBE?Uq+IRZQ%rtG':E:16fmR1!4$RuX:Clc)e".pUg-
FD@O?Dd@Ieh^q,PR/ML+K@eACTmN?=\)K'(F22/0`''`)OdDT-rce<fBAGcq#W38TS*%`,R1
d(nMrWY_q@gI.5'o=g'+!;;amEBDh7VAq`E0kH0gEfC]A`oeJ8<!$`tu"r+X=SYAp8d5T>NF#
:]AG+Y6eUHoP!,gF5bplSh<.UMiC"Uqi<tVKb"Y^?OZW!W<(Z[gC'J\qD>PFb@6G-P+\oF#7K
CX+%b$M=Jp2DA(@'Y*\48EIL*C#+_6g:c6Y%>``g,\X;/d<bp)8(N=!1ho[\X>j"bANBhIY%
17;7E0oM0P:bd2k3r.k,P+"C6Q@``#l-%e='Veg]A,\%_nY]AIe>?K"3GWKg?!\JQ[nc5XI8&`
=I8r5Y<tqJb$nSFsEg.TGqns6VJ-K`-H\`^AuC5G<Y!JdYHmM=]A90:#PSL`P!Z%4AdT,K)T;
UFWiFb-2OXA8CLf03daRV(kB#r4ZMb_^Ok6M)6)(]Ab"D9UZ8&W#iA("47%pfpU6OR^k1JphA
J+&>Z'k0s"9OQ>8RUJLnS$b=c=m@"?lWb!t0kTmUl81U^GLL54]A?Z0A<&crbh!:%)aC$:`U,
m@_S7\hRGdt'<eV@hdd`O_YNpj;*J/P2MC,@slLiYrlp#c6:HM:>+^h_4J\@9]ALDN<t^Eg4K
?3&"c6G<e'762Iq_\sRl4BC`n)/7`l.:e!BVZ<I5bQjgAD(Fo4)LDd&"!7iYiS"]Ae7:oDKEL
IlF5-r6*/DbdY;67]A,HdH]A)##!R\oSp5A0/lhU9)1IM9IDcP^d6F5bI5\*pe1gX>]ARTW4:V5
iXLO.URU^GQE\Od5dMEDt^)-j9<4JQ4.JamR*8Opfr6SXq&JThlg"^F.-jiZ$Y%9(<dDhG,)
iPXpR(KuODH]A);liA\5bf"XoC!MNaK<;]At%SNYk&[#?h.Q;E2?9"5pEh_$:W8P:opPrJ6<7q
'"&ITk\M!TG>h^d(SI4^0R)AG`/^Q/GpX]ANoY-Rj*Q+U2k>l\6R:`H'jiFK-]A+*31C@!7C=1
t<MU\T9N_&TZ[S7UqZ[H9P/d.DIn,<5aC2`Vr(;_X<oQa4:AJ<"58!,se8uUp6*^O7Y(K]A`?
n!HK^Dh!$3X97!&%]A\cIP7uoO0N2G;.gT0Z/)t:4+k]AfZjWl%L$&kaC5.a)Gm8RWn/Dk^Gdt
1QDN()dR7_^ndS\KX&MWE8(#4U;fY2DfEC1kuhEDCeV7jC!qa%<64+@XJj6DoV!q&/Gq[QUl
,.r,e7,S<i<^asV6P/7T/=/KPdclBFDUBR:1*BV9IpVYVKT48;c-Z?HRTlrO%(#Es&*n8b0^
MnE`V6pqeL(bG(:7R$pE#1W"^$aV[Y@`2(q?WO_b*b_eC'1q-Vt;ZV]A[?lE=uihl^SMq_rl,
16nKrf%_&HT.\#AP#a?7u2=XOl;C(E'F3=C3o2HUlfJKD??t%JDe"1Sn':bu#%us"d\":q)_
PBRjGghn<;a!md]AIqe3R"*.i+"6a[_sf"F\29%/gbS<h0dC3fnS"[iWn[U?NSm?n`4*Ym!ri
D)Z3=<f,k=d6$iK-a#^=h39cP:&43gcM>Q_PA33$04#@a]AC^8[.QpKthbZDVGOY_L3#4aK?C
0M:<Ta9%-)(#A0#J41]A;oqpL<FRV;nhZ@GRXlIoY'TtMmZfb)WQ#3sj4(0N"`C2>i%Y5)TV]A
,M?M]ALM2h-'a7.C#Vu]AR/8\p#'--$jHpR!Vm'ta4b'A[jFE_P2]A+KLf6)r[B0B0Sqbq"2aC0
?[q9VaeHN9\hh:76a3J!(A1i+UaH-8]A):lRbUfB#G.FIn_Odrgt5/!c9YW6.ge"ZR.8*mN!l
#7-cn1D'Lc%bCmnJQ0l-ii:dmQpGm=VNY'e2N#+>?pUL1?REgI8J*iaLXJLm-CqH+cbQN)P"
(nZJ<01L_g2!mEQm!IU^^tIg.K`VCV4@Q<H@lZ5+!"KL/,4EeD'SO:&Rs/?h_l`"qi#NIM8W
+HBVd\ULXY81bMf1i>J%c%'d#8AE]A$%ucr*VsH.RKEk0eK&A`oaB*7ret^PO#EVmdlbuE_BH
[u+W@MD`A7[V5gX"lDC^1@s1s)-IKnMfX!Z="_4>(..OAVDPJms)]A<:cu,i3ALI^@_q+FGXm
!ItuJa#R5Ufqe)N%T'(b8O/$2r>gpJ0&%DO!,ab/U<qmIL0T8qY9P+Lh$Moe6(W=aV.6l%o9
1tJe=1XnHLn+]A@Hqn6QBlHoVJ[H&"CaG\!-?.p.%PFTd4%DD%4rc;mY?sQA".l#"AEGCQ7Wb
I\5&NOJ#VPgs&2@ptjhJ/+fPr`HNBNV8_+]Ar<2)+).+MEAbRG*Qa38cnq'RK6G1._;K]AK:t5
dRjd`9B"<X?!9@u/HVO?j/MsX.;:MQT2P3mi"$s7O.dbD;.9'80:QCGCPBJiDs2c<Nt/2[9S
W(+(_;ei4NMt$!98D"'ttJ2)2+5Q/eN^/6\ajmSH1<oBct<>WCHLiL)tk]APc7Y6Lh]Ac%WhlI
'^.qADA'@+CH%(47R`DD<FECF0-4:lHprCse-@U#/Z%Sj4OE]AZb#'OI6`S/S>C(0mh5)u9hQ
K6GanM$4`@Z)&D5(MT;h`&+J;R]A1_O/ZPiMXHf'UfM3]ALta2]A?S<k"hl#XWE\TU8c.l4>Kk_
<qJu7mcf1M`:is(rLVnD97-4>/k[t/5WA60cYpg:GG#3'/D$X8Dhi=D$__OgUUJXV*8K'd7T
]A/a!-%)TIDm^M^r$>"[,0nUFB3`u:L:u<VSO!_^l(<)%2@4PH$'XFt+art'``(1D@n?&=6Hd
sY=Qu8tVP3]AM@\"=JDG\UC/N"=CE:%'fT<GQ6^Cis?=\)qZc0j3P_jp,]A$$qhC?KqE,,@@S5
R)jX\"Hk%AY;Z^aN3<*IPcoiJm(ELAoVt7#'d4gR^-9_&b5f*_kY?(th<ST&'AI)J6Rqn?6A
.CP3?l.&Ta3X>Z?hs?a1+B'Jl-"T:8H+l3AE&p'/&=[\qc9Sh239%13+\9K%S?I9=!hU!6#W
bg'1?7fe.LpmdZu*h=CqeXXTEM3DAb0bTc\XJVds8(&.+;UAft0k#`S=$=tI(7:G'a8PfMu=
G3BBrEO[5I?tV+G#]A!&j2t#\Wq(4W#-i'LK@j_l:=]AN^SSjGORpg=P"#7WtF@fVpp!7:q%+2
Ves*nj=,<Wd&kV`]A3V&GU:0nYB[Q2(-Bid@JXS_G+AAldOlSAK9EQQ_QX!RSmh()dh=T*A+c
D-&oj=a?SVKHkMg_GEf/C]AYK?@Il@:BbNn>@qUYQD$N~
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
<WidgetID widgetID="32cad330-66a7-48fd-a9a1-47919782b329"/>
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
<![CDATA[1981200,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3261360,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[总体情况]]></O>
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
<![CDATA[m9G!;;eNPZC,OL</rNrI$6eG%Mpk\F=pBN\P1A9TH6$OpD,GSU.!ULrPXaLTVrLV<=IZ\j?I
@09e@(!1+[JLgJHS=d[U?&qOl.J3a[dmA+_",3hK+:T3]ALn74)7:J$A:WKMo3j9^2JMu[t"9
drp]A6uN($MnJ&9OXDpcR+?@(/Jmr>4shqWInI-c\]AhR;"]AYFodn9/!qYHka8[QlE?uPDho[Q
G!-<M6/.smTJTMG(?@Va-o$9\,F<.rqq]A;=7t`p=]A;smj7n+qGjGb4;hA@>/,4S[Y5M+phBI
,G>Wq[]AU\ekU/YB?"C\GmdnUi8f]A5rJ7qYa2#ZFLPS`$%WMDhTmibJY^Ms&n8%T.oUZT?=A4
nCGAPj2?QUY-9Eqh4LTK/""a(/Qp@q*;\9:F?bR]A'66F,R9ja)-C!aM$BWcrb9Y^&A2HNh23
.%*iDd`1h<#D0DUS1!lABJeZ.+3pr1]A]AB<b@UJDmr9QH`JQmI?WfDAj`FBqeeBcIWiLn/$qh
#Q&GHo3N&ZrR(Ac1l`)8`8s)pq\O@6QCjY7u55KmX1Pr<%$@^^O-ou%UR*/9uSlM@q`89'm<
j2Co7,rUP`YnO:]A,Zj]Ak!^Q8gRWnm`.3SCqf#6N/([b2WV"A@(qp_u\np@j>l@Lm@4F^L0X[
fVC1:tWX[[JDZDN[e=#>Md(BdZ2m)DcQ%#%A980.QDONt!_L8"GDU#'@nPZ=Q;XVK`L]AT\:+
.WmC]Aq((]A)E-:Xo^-;#Bmq9#1!o'+pR_E%8$6?LDajfl1qXM"'Cl)-I%mtn\eV#]A2.h(R';,
ueU&SIfgH7>AV^kmt!F9E[Gi8,AMSqWU72RMnLQ-bBq[C3/K=Y2@2h`lbsX=H\U=]AI3iZ<BI
p?6rf)*OXQqnq8jfFYcBn2C,dhq%XC7TLcRaF7!b'>:&OI+'uQ1Wc_YOd]AIgeq&A[!]Ac,S"h
3I+$Z7s=r%-J:l<3FSaDRMVFUR7;T7Bb1/kW\N/KZ-9>me%fC?sBoR0jA<^^1&_E[3`0S_:/
OTmf"`a+E%[:d7F8=PbiOa%qb8VUY#H\@g(Ph8d1hs5fXIV3G'WDA7ggkV9[RqgTFVB0Nr[A
)KW:<g!SA]ArPZAp[mne"IB!J9CRfWC7%,]A5bbmNOcLE5*qRu"Y&1_fJ[NEPahM!4E``]A<PFS
#G8gTX8e=.Q3r2c]AME7jVGlK@,jbJ$T()h9KE)dh:0A>KQpBkH"2),.YRu;rMDi2bfT%g`:(
.2NV/^qSb"<*cYK]AYKZr\]AC,W-&H>Y^Y,\t_#40O-?'SWGGuHeeLnVV:iZjgKf7,fgRgEN3]A
Nq3]AIO,U3fW1<YKuAKTH`(lpfU6YM0_8O(JEMJ]AU*YMuT.e74bJAl@"h4%[4>6BQ%DnC8O+&
m]AmZoT9L5.I^Ts*I$ZL7I79(=@ld8A%A,*SpR]A7Tus5d&'u-k"9B1.bK]AY1ifOd;9ASOO958
fte)N</lB=LG'Y[2Xg*6LAHk^LN&k`*hlR3&sY04,57+MZot"EDV!a:BIIiHc=aghnQ#sVnp
2XGU0^JEDu[%"#3iLUC:jHWmi8(RW0KqH`-PjYW*6$Eh\LjCo9$"XaXCZb6AmEbEn4R1$Vpq
!>,Tru`*KGoSGHV,7^3Dng1DZaij@]AfHkl'c34ThaiTbkJBb=)[l1UVB+ZWu3G*)2P>Q=A9:
2J\I`=5I8#C(O^Xr;elRLiYf)Mo9F?@'/To\I#o(MNS)g@*7a:YlFM?+kSe(^07hM8Z45RQs
m6,3OscmCaDZM<cfIjcm,fN\4Qu))!i]AV:TY*r64t_r-H8\%ra,YO[,9q=pgDkd=:+O-,-p]A
%0)J)+?6V)e9bjVm^[]A(8W;s<gEFA6\aH9)@0h'u@pr]AEd$YIU80k$M;:,FLZR)ttI).4SaL
MZAo[DjO6"$s,j2>e,QL):V=`n=P!\s0&6[!bUCHkTC?#+3[*V9:"0/[eT"&8SY?=&HXAYX-
jKOFZaJ%_(u6oIqJ:r,m-k`."K*6eN;V^F'OD%&eRNVK"/,PBiN=%IPn?>Poj%/jNTIXLq$B
;ZJa>]Aj&i6'+hG(lDkN:19a+V'`uD?uB\?Rg?kR,*9K27Pdj#hc'GRR!@7lW#C8R2"4RN]Afu
Gf0Ipk0Tj&J68U5f+ZtAcV!+E[M#Za5+p\a4beolA$b_V:;kTWfcRAA=a[<Z4Yp'R9#GOlC\
M)BU?1^cpa:@ZEEjT*B'd>p")Z@I'P+Ra724a$Y+OOoIFL`S(;$\c&R<gai,_KN6mdaR9>V[
kVd`K/0-OdIX8-k:JBZZqr)ru6>Z(?]Ai"l&XK'_HaUYROWTNXQ;YnTk2"#"O,(GK.UK;4Gb@
=q54]A1+a[l?3G';D9o8[X]A@Rf\Q9Po,m=pJ;3#,sV)Y[NU9ru>V6;(`rqsSn]AMiV+l,+$N3?
jWdpoq_c'9)5qH#%'2A]AaSr$#unqqO+G9\Z##9<@>%c:$i+]A0MYPpkdu'h(OY'uR+^?uh6K;
ZK]A[k$n!*N!<FaBK?7e>Ub_HAs*bDhr&I.729/;fXE8d4jVp<-O[V3"O_G<\0P>rekHfKTQp
2]Af^Kb:.U0!tDX9WHuBgF3CerV?,[^MfYMu&qo6986t\,0OpE_3>ib-Ji<Y^d:WJ[CsW?SU1
pcC`&9+JN.'.'?L;%%c'Aj>fT$56H?qE[m[`T7MS[pQf"4i('J2o?94N?`N'"nt_pXo,D*j3
6Zq^f%e3!Q/6_>9$8]AVCGk/@XY4#cS(WSX?XL>sDJ:`bd^!2;?nFY6)mVW\e<DhWfOdULbT!
Q0'G\f/"PD5Llr#;3&5cCYu6Iifgs&45A9T$bWE_c.-`.?R@g__J3;Ss8(=n$"sk$]ATL]A9_#
>7"OuL2oKud^jd%uTXJQb!%5H,`Z2k[&Gg[G5c.B8k[;=W9VO=,SO#mt*,@u-C1.6!"WYpF=
ic_S,=U#OnfO%:U'a'(s]A.;OB5EaDfr.@Jc,U-:l.)tN[1o\[EK8J>:7S]A_M*LL>!HSUIMio
)s$IJQ^ZHJ_9IXC*B5akc&`6[)"tHP"HhYmu1uD#I$8-V[J*r_t3Y!Z@dZ`bcnj:3=e"TYP#
m>0sl>n'a)1c,Yf423*e)-KtL1'>\\LK!3bfX0qn*CX^XKg9#[`\Je3XP56oq;'EMO%q[rEi
tXRH%_ENhJr,>7=<Jg#2dCkt&MVG(F$$UJbhK?;"-`/Z"W[-So4UFeL07H*K@=N,/^$ju2(S
ToaUKB<89*#CaEM%O^-Y<\mFEjE6$nRk/5_\!]A[/ii@>&$HL*lZ4cq%.SR%)"J)^_>B%q8_Y
j&00nWBCJ=eJ2qCbk9L#Ho6V5>#XY-P>K$qIW/bhk9<8:&@k'/gs73XGjA&7(QR]An[K1X,<0
a'=qIjKb+S\:38%CcDbi9&lj\LI!/j1J'(om<1-9^l-`OG![&9aW)C4Z`P5Jt_nNOm=;2!R#
6/.Y57I'b\&BZK3iNBZ1jJ+Mh&BpT=/o\ZqMJ"GOTp71`B'hc<"=YPp:Na[B7"S95or1Xbb1
>Ij'NJ936l9cl8QH1B@K]A7pPVBlS*C&0gZq%mW;(uUQYi=!`8kURY8n$,.JCKra\@q-fAb1@
>a#f#Rg%6tD;01@Q/Ed[>L\Q'nPQAuSo'`;OG`_"Th9td50*uT"ug1KOZ?o]A^n4,RB*+YpLo
Sc/\<[EbI(6tp[BFA;bgR3ZJ\A7Qji6f9#O>"h9qX8X"F(g,PUBqa9d%bi,T[!Z9j^;m+N.$
?EVD$_VWOSW]ARpNdlgZF<%IeLE9:Plf==1[F_qVD[kCih/W-`<Dme@o-HrDaQRuFu%N55W34
pN`hAZRdM8>32o(cr#*6&\[+Yra??]A^'5Ohi0SpD^QS0,AX&X)@d,=MG2"2VQ'IPT/TU[GWT
$(gJd'V,F?nT#)g`4=13M%2l6^-bt+k\Y.[;25??7<XL`KWaV3b'l=\nK4WO1mkMSt8n+N_.
"#M^50Ur4DJ^$5RO)"p(%Ch*gObkS8V3Q=\]AMWk2Q:\#]Aeo^-RL*iDMfJ>AeeLl11_S>!a-V
?^"ibeBb(@6WLrLi\);:HqrOTF9J%Ui`gYaPqQsVVLh)Xk";XU\jcl0L0.qu$D$Fh':BU;Rc
6*S\G`.5qu+D@"(UjW+_H-&;/[sPToRF@ANSe)_L2?FV#Kemg*SP:RJqc(X4Ad!bHsLc&o?;
';f+UnZu%ck7R<WGCoNJ24^&%/^LOT:n"bSR!K2-oD"U%-1ED!m/a&4=jiehi+%&1.L2+l6W
_(Hg*3<cIET<UnX=b6K>@6L*!Q>g"[[S^m4E1<;VQ:``3q8YU:iKDihO,#7R_qs$4g;eUZIF
$&80SBCaO]AmO49:E>ngen/!.bu`P"nAHU*]AQ!qN-="TS'S%Tj\9M%5^Lp%k#uI]Aa7'k8`Q?O
X'X?C[)';/QAe;330#JMphI^]AP`%(;"nMjpr+rk6fo`/EDqo'WBooJaj&f]AF=Nt!*enMW\!K
^l",GR1rChOq2`6K?-q-`5#CjO^[>Bb>/7@.p0&%hJ+J7p&;R3Z6r(pp$#&\_*'=Q2pB5]AE5
7e%pScB,GGQL*<fl6(Uj3C'<!RN3?`kC?V3b2,;/kl6cn3f?KC"VQCjfG7KtC^2I]A+3AMYaC
,V;-iL8mdpXbHqoYud#5dS"W&ONDHP<'KCn(_kSA)*(GUl&Ms0APYC+3sI8Q$c<&l-`Q-Iqm
>r>#]AHWeO`6"aBGi*#tE's!*5V<5mT7eWd^oEbB0$U`cdF]A-YdrC%m"U572m7g^t6hiSr*)s
9rc=!amU<3&odGS7#f04JZJ3qUU>gt6]AMD2g1+jH2J!ch"#pTZGCKe#'c^mX',>ZnRL4$6n"
'"MP[EZ<kFpgOO4@gb^jLkZc3(*7'9L8PB*Ns8!:^17/6uaD(m_RoCi#.qmBi;I3`29=W]AA"
=m@U(lTO;H%H^$f,7-`Vfa]A2ARI1?=&N&@A+)dVTIC"*W(BbK\s1JH$+hWcV;qhj5@XY#Gsl
$$Z;gB\Jr#\Ek0\QE#<oT;n*rQDQoGjM).9<b+29J@EK>gLO6E"a\f2&ASGD`270d=d+EC)&
RFIdbI<I!O,Wb)>%0c;t1a/V$>)6CE,dKcT*Q"&\0&)0`/<"WEM,F5/'")_^(cTYet+FN3]AI
:h)<!7(CKR?E`Xmi;PBR9]As%cUee.dr*mLgk4i@L)dhJ";Z2LkHi=3~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="782" y="11" width="252" height="41"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="准点率-标题"/>
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
<WidgetName name="准点率-标题"/>
<WidgetID widgetID="32cad330-66a7-48fd-a9a1-47919782b329"/>
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
<![CDATA[1584960,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3261360,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[准点率]]></O>
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
<![CDATA[m9L0#;eMP2cZEpfY2E'9XXf&a`JeeMbM#13?ud5m,A@BNX)t`q72`'h5Qq8lq3b0mdVU9Z0f
6>-VG(s]A*RolZ(c3MM;@-E?:`N2>KY'&W"-O5+J\WR]AH_]A&mmO@&Fdu:2Td;q:&ptbgqhg=8
DI@o\N^Dm3$I0t>XgdQ;%_SYF]AY?S=V/F;Q,Ycsbup9@-0:GVZ7%Y]AVMo8DZeX'R;:@d?V/N
SL*)qocYlRh,JkX5"_Vo;]A^pR2PI.*a+!WB-47*qslBmhNCPB(B".j-[rOH^35k7k*,G.ANW
6rX40)Hp$[A#O<?\9e[jWl:D'#)U+gfL`hh7TK%8b-0Po@nrH!@(S_na6YO%6bcdA9_2r^E%
<41eK"&n!S0K5T0LlIr%W@j7SQ[/3ShhZn%<r;oq_O>Nir)#YE$Ib;6)F*&Bkh)E[`j&Q73]A
>_M>BVM@lO0,IM:^iLl+>&u'unCVoBONlL"\]A_cK1PkqcR-<S5%\LUGlZjHbFS+KgqcX)4]A[
Kr%XTrEg5recFleTh_!qsO#rG/MW3:NN;m]A>n$FU#[H4@Yr#AeaY8,##kKs2fe5rfi)P_fD4
dpGnS(DaK^3NQ89No:)Yr:->DJe<6(RTn`"I<IRlk6+3*n"kA(um$WALAG*Ta*M&1,q_KD,l
)-TNTDl]Aq<s+p^Quo<SuJ<nh/\@P/+c0D=c8>o+[@R]A>&8)Hf`N3fR:HRYDm0P)9secWr<Cp
SFOLL<tj,rWXWDdKq1p:7=HkO._X-<j98bHYLFB^nihu5pO+Hk/(e0F:^WHSeYVPKSoq-BE=
5BFlI`bID*t`rHI&k"a0VcTnh,=A`UlHUqliJdjh!TRR%?6O[EsaRQMR^u6iFa-^lGLu%9q&
>_VAYWVK%[16nj#Ts-@16>._JIR<lO#P]Ak29+&kd.-:d:bl?YYFGI5V)>sM^@)D/O1kP?Oog
K+jW0,[t52HY=oYu+`nMjo-?eTYij]A4meU7O#aHE]A0**GkD1l0C!a@^=[b]AR:<RcH]Aou$LV:
sDi-72CFnJqr0qR(X+?`*0CtZI*6OrE8cs2&D0S7L#4Q%rRa8^iqW,0X?p8'n?Y\oibRWuU9
Fo5F*/ptg'95aIGe36LY10/bSVV795::]A\n@VJ>9rpoONikPeIoUSjdVc;O]AK"qUGCa@$Cni
=6B)@.k:^[o83NeQ6Vr:hbJOl@BFj6\t<.#"3CDXsF+PY<gVT3E469<uObH#_iC!Vq+5g8Vf
-%5h'8Kq7!2cZrY,s72Bn5o-bgrD2[UMEXnEJ$REq\%h`b9$AsA*^u"2Ll.^3([oGN%]AH\e5
MSGfXi/WiHY%Orp?n=mY-b)uQNq4-KY#@^bSJH/;#m0nYK3&=Ma0)oer-AC=Fa>@:Qt2N)4X
g"^r`b_=^4@--_D4VQlM%JV^!jGD!n9ZU:#/pN6[TcQ5C^B0e,]AXXjlZ61n>\$OX^]AT4Q`jT
)[Dj$ZZ0S>S[H0^/U8jRoc7[0#9GglK!7GdNHNO"7lbGaqPTB#1ErKPaI?rP!<8Y;[^"R0mf
2h3gcM*^pQ+"@SOCT8o;k(+S:U#&b3tMKJV7mb23ref''AFSd&n_<hBUmeB`44bhf))T,(dc
_SM+NZOcOW\J=auA7=^>U/3L6H5Y[S]A\,?VHPD8r4L'KO1g*540Ap[G!mD[-"!I(N#U;]AQ#[
7't.j^UY*J,EcU7&e:5X]AGVYmU-r^XW0-]AT*trVHa5ccpYME69$u1gXD4]A8i27c'9BKU)9V6
(1"#i9[;RuDDkkFe!]AkR/(1'a]Am(;r\4:&N,);NNMO6QkCo1gRgGp!U<'#lI5u.&9@,J;k)o
D04j&2d`"_eTZW]Ai"6*r$8O.ME4,ii:*?&h\B.MM<1^Mjh]AQ6Yd<WD!2?!P;\E`_o^g\k0jD
+((iX"2E]AB+=>'qbe;*1WWt$ep5GGGQE``Xe*4UabDe]Aa4Ud#!4qXo'\>eM7)Ui3#kJf/EZ$
^!''%FfeZPI*\r#=6u">0q`fVh+i'V7:r!PD=_OXkc:_E3aC3)>Ho59n.=&[)`m91j.08f@6
aJojh/NGYm]A:sL##0@S0IB7gLE0.t.eueO)UQmL7c_RTnX+.m,PQ/RjYpQ5>m<t&Q<o1\S3s
0[b<mV;8`8Zu>o39V#UF5.U+SF_)#5Qie\X(=Kk=ih\;[$]A*9.p]A@3a>S^nu%J5k8A=BC[im
='(L,S]ARSpcYbdp:V)4H:&4TJB]AqEBL5CRQ&CWD(d\JNi=-NqMGqBuW1&G!<[/u'%MN5eOGd
S5Z^"8+;/Qr?""5t,:dR7i;d=*n$@>hqJJ[nI`;JRrG0HghoCkQJYOPA)<\'MYGp*_a*"N#3
uScHoe\-dS+%\a4]AE-A:dj$DQJaMd:L[A!g0LOn\`G@6UN;eb"qZr_:dqo"Eei8DtIOua`aY
:O0;^^=O3diCD`Dp:$.Er3XgRj:]AGd8.Zt5AW(F]AGH*pUhC[iD,isG41G+36+Ki1Un1#Kq.1
]AfoFU-e6NO8PJu%B#I,9S$DK$m8[MU1t^D>GaJl"'s.WU4hJn?F@3%4$UkFlP)9C>oajh%.<
n=41)h[F"PTbK69;FJ,bC3C%`9rt'b@A,]A1PYRVB7d@Nh#a)(6"aCc#g=@+:9!-_;9>"+g*I
5::jH*6Q'Vp[(>ZUbO+22;gKj>NN]A;li=n)!*q$O[_1ACstVH>?hF44u;lMocWHq.?Kg`lJi
<OLSH27_H2X9Hte6odgKHB$$F[]AO7:LdaeAApiX8\ifQORIDSEq=Bh_=qJ]AG//[n_^ZZhT"O
sk4f6<HSL8rg-S`,j*MLNj-fOMP*$'n!ku/9H7G!F`TBMC,DDL<PupS'qI@r$:Z]AV7?S,oW'
^[7,YZ)>/sg3#Y^lS11"4an+L_nh;USnY1EEK]A\D`X=S$C;7&m%NlR'Yc&2/mueR?eh*0?b7
-9H/dK+GO*)9EWu-""5.:@j"G`Tm"^7ILJ-dLoqe.H^8/#Yn$Hc=kEYk_-9%\`PU^IKjABJ5
sJCJ[Bf*@Kn(!2a#B=.#O.N`LK=+P7#gL@VMAYJ\ujB<::XG4;5=u7D0//W716`Ym3se87<"
W(]Aq==;d+qkKG;EnWA'dO69tZWphh6gSr.2"MifFCpRVSASQ9dP1sg]AXLiB3.G`kQ?e^e/(+
Eq<?>=BqcF@-O%<I%($W.9f)64>?^TY?aY.K*7QMc&\gooht+W%$+FTrl&B('4Ka[o$Hd`eK
a>n+NCH_#C[?2@^J!5iC4p![B-8%[,Z'Z[k"l-uF,!Ol2R]Ag(k3#gEK6<]A@"jqGPW4':<!g+
jjnt`3fsQo(i[;#>BU.%S83,Fo7==WOAs_B$QGlT5cmtYgPBLdi:@m2G4f@uQ-^K1eu(JD^i
Ka=OX(ncH3O#^^`@t,3o7G4%WWsTPDu5A+"[0UM3ik"bn?>Xh71&IZ#"Rc,EreU);tr&*5$F
A'e\Hk-`(e-,aNUZ!-+]A*.]AcbLSf-*if%"2'W4s!(9It&NB`A9/jpi*ZZ/T^O!u;&,C#U:0'
*A7Imc7S(Cd(7?;og5h`]A%]AgQ3:3EM'5'H;BmFu1m.#1YE,Z:#_sg8H*2>]A&7e`U\e2]A[VpL
[DdK'[3I_MkA/HVCBM)a<p&J>rl=\:-Vo/`l!gKP(JraDSnG_M`GU"pIH]A-(Sc-.GC:(Xb&L
i'kh545L$?$@)9$!LOAdIt!bRZq2AX,64'G-js@K`q,Vd2H]A&JS'uGR4k/AV<rEK"c8A:6g@
ssoTDur+<r4,fJ,H&0jC92Zp`C.):QK?qJ'#2VHA>`e=24>m#G[?TBe;>WlO(&2U`:4o09GE
B]AF&NII5%QP.2ZKD/gG8i*\b%$cN.:JJV4]AFQtKP:*s(A7331EJbn,#^^Cq&=?d,1"9"h#)j
$?@)[@T+M[mApdd1b%8?IuQ=;h[W.kFa;7Xfb1_4'KL3/jg&?E:ZMnC'eC9#*EP!EcTFL?$R
=CO[k!$[#[ck6[;j:#5'<JKr+WgUrilSUAu3KGL2ufUOfr'GBkW3h$tD>dGpXf^*D,)"7T$%
KiFU?/COU<:U^\;,e6XY<ijaPbJH,lA!.n>B$SspVei/?>gcVX:f`%;?D/i[=kOoQE1LNKMH
SXns(fWag*QS"&tMg\:A!Eg-67dEN:jD.'#@.p%@;pJ7Sko=FeR#8r5:nR-soF2B5OgH=EH8
$Je=-s?S^L=`7l]A2kZRbh?is^BPUk84$"q'\C.>\RpbI;dJ)ZH@Q5+>qdl1Mq5*DF@"9Oo^6
(s]AYkt/k]AK)n\"+C/iYEC&GO@aIqM)F!_7M17XQh$M7?YV$s2%P-+E]AhcG"%[G$KCr<IAW'#
lks(sPa]AgFQTO;^E'M6-;S]A(h?&=^bL+lg7VZB"-WC^:!@B/pjWEQ#d;.m@s_d`@ssBG^2_%
2)j9\\$ATEH_^^tQ2d6h6e/p@(Ed%9Yn<4mLrVid+Ebd#/nCMJ.p*)b<rHh[>Bsn(a:.^t5^
F$.?;/7f<F/TY7pF[L)+<1Hij<:K6P:,?OXn-T2HkoFbuBET,[h]A/rX`)4,Q''3YSUE+d54_
[\m>Z?$)A+bMZt!S.]AfWiX+Z]A=0).)*j9f2COC9CWHq#F)K@?rI#qN0&<[.ZlDO!g]AHWeR7K
72UNHSWZD!r`BH*\;5BZ[mL?-?IPc"3'4=-*#@A1Cs8TgbT?KPHdS:4rG:re#MN(56"hp7D^
]A-nP"D#b/jW121g.C(jq1"5YAo:Lg0a!K:Z5f@2^&La!!_nUduP173ZhKIK6P81t_#FD*H?'
UkY\&+!B=K&JBrX$t215,gn<MQn,-[[<j6Z>^7OQ3>q]A[]Ac))%P-&nk6u<l&@.96@Pn7XF6`
aV1%aGET8oU^AI#<gtaYZZsS[,2<1,p/emljtp>kk"ac3-XnV)/Fg1]AW!Z(^q;M0tRo+l&Jo
G4%rqsG">!fGAK[NZ5?$A`7L@fWNar2A4A#kFDsZgLJ\)eF!isrj%V'>%GWf)\?I0p[l@J`R
!&F?L[S!f5D-S!Y[\JCNj_[#5B4U]AH/FsN\0l$B)5-#q5qKFgdM#i\&oGlJ1Nbgr\]A@sI/h%
tj_#'_^Z#iO#XA^MiC!n8[-DB9lS%5Kk8WZ15P*'k$n/MSGU3rBL^']AYgbs_ZU"mb`$VfI*+
WVFP(WMC+2bHEIfesd_\mQQlch8@6S%JX<7R8gIB3ZT(^R.o<n/R/XJ!pbTiM-ItQ]AT]AKQi%
as86)@7N9dD]Ap$9-nW[]A6M".d]A]AES'[tVo2c0@Zt=X!$pc7G^6."Egq<MZBan8VK(B,7_#T+
#-3oLt_#G,,ek?^UO9?0:,Y@N"GDcfD$=7L)=tEtodOO]Ar/L/9t&(5aLJkIHi3J4M`EoQ#G)
j+RiTB(Jn=``R]ADnZ%_~
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
<WidgetID widgetID="32cad330-66a7-48fd-a9a1-47919782b329"/>
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
<![CDATA[1981200,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3261360,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[总体情况]]></O>
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
<![CDATA[m9G!;;eNPZC,OL</rNrI$6eG%Mpk\F=pBN\P1A9TH6$OpD,GSU.!ULrPXaLTVrLV<=IZ\j?I
@09e@(!1+[JLgJHS=d[U?&qOl.J3a[dmA+_",3hK+:T3]ALn74)7:J$A:WKMo3j9^2JMu[t"9
drp]A6uN($MnJ&9OXDpcR+?@(/Jmr>4shqWInI-c\]AhR;"]AYFodn9/!qYHka8[QlE?uPDho[Q
G!-<M6/.smTJTMG(?@Va-o$9\,F<.rqq]A;=7t`p=]A;smj7n+qGjGb4;hA@>/,4S[Y5M+phBI
,G>Wq[]AU\ekU/YB?"C\GmdnUi8f]A5rJ7qYa2#ZFLPS`$%WMDhTmibJY^Ms&n8%T.oUZT?=A4
nCGAPj2?QUY-9Eqh4LTK/""a(/Qp@q*;\9:F?bR]A'66F,R9ja)-C!aM$BWcrb9Y^&A2HNh23
.%*iDd`1h<#D0DUS1!lABJeZ.+3pr1]A]AB<b@UJDmr9QH`JQmI?WfDAj`FBqeeBcIWiLn/$qh
#Q&GHo3N&ZrR(Ac1l`)8`8s)pq\O@6QCjY7u55KmX1Pr<%$@^^O-ou%UR*/9uSlM@q`89'm<
j2Co7,rUP`YnO:]A,Zj]Ak!^Q8gRWnm`.3SCqf#6N/([b2WV"A@(qp_u\np@j>l@Lm@4F^L0X[
fVC1:tWX[[JDZDN[e=#>Md(BdZ2m)DcQ%#%A980.QDONt!_L8"GDU#'@nPZ=Q;XVK`L]AT\:+
.WmC]Aq((]A)E-:Xo^-;#Bmq9#1!o'+pR_E%8$6?LDajfl1qXM"'Cl)-I%mtn\eV#]A2.h(R';,
ueU&SIfgH7>AV^kmt!F9E[Gi8,AMSqWU72RMnLQ-bBq[C3/K=Y2@2h`lbsX=H\U=]AI3iZ<BI
p?6rf)*OXQqnq8jfFYcBn2C,dhq%XC7TLcRaF7!b'>:&OI+'uQ1Wc_YOd]AIgeq&A[!]Ac,S"h
3I+$Z7s=r%-J:l<3FSaDRMVFUR7;T7Bb1/kW\N/KZ-9>me%fC?sBoR0jA<^^1&_E[3`0S_:/
OTmf"`a+E%[:d7F8=PbiOa%qb8VUY#H\@g(Ph8d1hs5fXIV3G'WDA7ggkV9[RqgTFVB0Nr[A
)KW:<g!SA]ArPZAp[mne"IB!J9CRfWC7%,]A5bbmNOcLE5*qRu"Y&1_fJ[NEPahM!4E``]A<PFS
#G8gTX8e=.Q3r2c]AME7jVGlK@,jbJ$T()h9KE)dh:0A>KQpBkH"2),.YRu;rMDi2bfT%g`:(
.2NV/^qSb"<*cYK]AYKZr\]AC,W-&H>Y^Y,\t_#40O-?'SWGGuHeeLnVV:iZjgKf7,fgRgEN3]A
Nq3]AIO,U3fW1<YKuAKTH`(lpfU6YM0_8O(JEMJ]AU*YMuT.e74bJAl@"h4%[4>6BQ%DnC8O+&
m]AmZoT9L5.I^Ts*I$ZL7I79(=@ld8A%A,*SpR]A7Tus5d&'u-k"9B1.bK]AY1ifOd;9ASOO958
fte)N</lB=LG'Y[2Xg*6LAHk^LN&k`*hlR3&sY04,57+MZot"EDV!a:BIIiHc=aghnQ#sVnp
2XGU0^JEDu[%"#3iLUC:jHWmi8(RW0KqH`-PjYW*6$Eh\LjCo9$"XaXCZb6AmEbEn4R1$Vpq
!>,Tru`*KGoSGHV,7^3Dng1DZaij@]AfHkl'c34ThaiTbkJBb=)[l1UVB+ZWu3G*)2P>Q=A9:
2J\I`=5I8#C(O^Xr;elRLiYf)Mo9F?@'/To\I#o(MNS)g@*7a:YlFM?+kSe(^07hM8Z45RQs
m6,3OscmCaDZM<cfIjcm,fN\4Qu))!i]AV:TY*r64t_r-H8\%ra,YO[,9q=pgDkd=:+O-,-p]A
%0)J)+?6V)e9bjVm^[]A(8W;s<gEFA6\aH9)@0h'u@pr]AEd$YIU80k$M;:,FLZR)ttI).4SaL
MZAo[DjO6"$s,j2>e,QL):V=`n=P!\s0&6[!bUCHkTC?#+3[*V9:"0/[eT"&8SY?=&HXAYX-
jKOFZaJ%_(u6oIqJ:r,m-k`."K*6eN;V^F'OD%&eRNVK"/,PBiN=%IPn?>Poj%/jNTIXLq$B
;ZJa>]Aj&i6'+hG(lDkN:19a+V'`uD?uB\?Rg?kR,*9K27Pdj#hc'GRR!@7lW#C8R2"4RN]Afu
Gf0Ipk0Tj&J68U5f+ZtAcV!+E[M#Za5+p\a4beolA$b_V:;kTWfcRAA=a[<Z4Yp'R9#GOlC\
M)BU?1^cpa:@ZEEjT*B'd>p")Z@I'P+Ra724a$Y+OOoIFL`S(;$\c&R<gai,_KN6mdaR9>V[
kVd`K/0-OdIX8-k:JBZZqr)ru6>Z(?]Ai"l&XK'_HaUYROWTNXQ;YnTk2"#"O,(GK.UK;4Gb@
=q54]A1+a[l?3G';D9o8[X]A@Rf\Q9Po,m=pJ;3#,sV)Y[NU9ru>V6;(`rqsSn]AMiV+l,+$N3?
jWdpoq_c'9)5qH#%'2A]AaSr$#unqqO+G9\Z##9<@>%c:$i+]A0MYPpkdu'h(OY'uR+^?uh6K;
ZK]A[k$n!*N!<FaBK?7e>Ub_HAs*bDhr&I.729/;fXE8d4jVp<-O[V3"O_G<\0P>rekHfKTQp
2]Af^Kb:.U0!tDX9WHuBgF3CerV?,[^MfYMu&qo6986t\,0OpE_3>ib-Ji<Y^d:WJ[CsW?SU1
pcC`&9+JN.'.'?L;%%c'Aj>fT$56H?qE[m[`T7MS[pQf"4i('J2o?94N?`N'"nt_pXo,D*j3
6Zq^f%e3!Q/6_>9$8]AVCGk/@XY4#cS(WSX?XL>sDJ:`bd^!2;?nFY6)mVW\e<DhWfOdULbT!
Q0'G\f/"PD5Llr#;3&5cCYu6Iifgs&45A9T$bWE_c.-`.?R@g__J3;Ss8(=n$"sk$]ATL]A9_#
>7"OuL2oKud^jd%uTXJQb!%5H,`Z2k[&Gg[G5c.B8k[;=W9VO=,SO#mt*,@u-C1.6!"WYpF=
ic_S,=U#OnfO%:U'a'(s]A.;OB5EaDfr.@Jc,U-:l.)tN[1o\[EK8J>:7S]A_M*LL>!HSUIMio
)s$IJQ^ZHJ_9IXC*B5akc&`6[)"tHP"HhYmu1uD#I$8-V[J*r_t3Y!Z@dZ`bcnj:3=e"TYP#
m>0sl>n'a)1c,Yf423*e)-KtL1'>\\LK!3bfX0qn*CX^XKg9#[`\Je3XP56oq;'EMO%q[rEi
tXRH%_ENhJr,>7=<Jg#2dCkt&MVG(F$$UJbhK?;"-`/Z"W[-So4UFeL07H*K@=N,/^$ju2(S
ToaUKB<89*#CaEM%O^-Y<\mFEjE6$nRk/5_\!]A[/ii@>&$HL*lZ4cq%.SR%)"J)^_>B%q8_Y
j&00nWBCJ=eJ2qCbk9L#Ho6V5>#XY-P>K$qIW/bhk9<8:&@k'/gs73XGjA&7(QR]An[K1X,<0
a'=qIjKb+S\:38%CcDbi9&lj\LI!/j1J'(om<1-9^l-`OG![&9aW)C4Z`P5Jt_nNOm=;2!R#
6/.Y57I'b\&BZK3iNBZ1jJ+Mh&BpT=/o\ZqMJ"GOTp71`B'hc<"=YPp:Na[B7"S95or1Xbb1
>Ij'NJ936l9cl8QH1B@K]A7pPVBlS*C&0gZq%mW;(uUQYi=!`8kURY8n$,.JCKra\@q-fAb1@
>a#f#Rg%6tD;01@Q/Ed[>L\Q'nPQAuSo'`;OG`_"Th9td50*uT"ug1KOZ?o]A^n4,RB*+YpLo
Sc/\<[EbI(6tp[BFA;bgR3ZJ\A7Qji6f9#O>"h9qX8X"F(g,PUBqa9d%bi,T[!Z9j^;m+N.$
?EVD$_VWOSW]ARpNdlgZF<%IeLE9:Plf==1[F_qVD[kCih/W-`<Dme@o-HrDaQRuFu%N55W34
pN`hAZRdM8>32o(cr#*6&\[+Yra??]A^'5Ohi0SpD^QS0,AX&X)@d,=MG2"2VQ'IPT/TU[GWT
$(gJd'V,F?nT#)g`4=13M%2l6^-bt+k\Y.[;25??7<XL`KWaV3b'l=\nK4WO1mkMSt8n+N_.
"#M^50Ur4DJ^$5RO)"p(%Ch*gObkS8V3Q=\]AMWk2Q:\#]Aeo^-RL*iDMfJ>AeeLl11_S>!a-V
?^"ibeBb(@6WLrLi\);:HqrOTF9J%Ui`gYaPqQsVVLh)Xk";XU\jcl0L0.qu$D$Fh':BU;Rc
6*S\G`.5qu+D@"(UjW+_H-&;/[sPToRF@ANSe)_L2?FV#Kemg*SP:RJqc(X4Ad!bHsLc&o?;
';f+UnZu%ck7R<WGCoNJ24^&%/^LOT:n"bSR!K2-oD"U%-1ED!m/a&4=jiehi+%&1.L2+l6W
_(Hg*3<cIET<UnX=b6K>@6L*!Q>g"[[S^m4E1<;VQ:``3q8YU:iKDihO,#7R_qs$4g;eUZIF
$&80SBCaO]AmO49:E>ngen/!.bu`P"nAHU*]AQ!qN-="TS'S%Tj\9M%5^Lp%k#uI]Aa7'k8`Q?O
X'X?C[)';/QAe;330#JMphI^]AP`%(;"nMjpr+rk6fo`/EDqo'WBooJaj&f]AF=Nt!*enMW\!K
^l",GR1rChOq2`6K?-q-`5#CjO^[>Bb>/7@.p0&%hJ+J7p&;R3Z6r(pp$#&\_*'=Q2pB5]AE5
7e%pScB,GGQL*<fl6(Uj3C'<!RN3?`kC?V3b2,;/kl6cn3f?KC"VQCjfG7KtC^2I]A+3AMYaC
,V;-iL8mdpXbHqoYud#5dS"W&ONDHP<'KCn(_kSA)*(GUl&Ms0APYC+3sI8Q$c<&l-`Q-Iqm
>r>#]AHWeO`6"aBGi*#tE's!*5V<5mT7eWd^oEbB0$U`cdF]A-YdrC%m"U572m7g^t6hiSr*)s
9rc=!amU<3&odGS7#f04JZJ3qUU>gt6]AMD2g1+jH2J!ch"#pTZGCKe#'c^mX',>ZnRL4$6n"
'"MP[EZ<kFpgOO4@gb^jLkZc3(*7'9L8PB*Ns8!:^17/6uaD(m_RoCi#.qmBi;I3`29=W]AA"
=m@U(lTO;H%H^$f,7-`Vfa]A2ARI1?=&N&@A+)dVTIC"*W(BbK\s1JH$+hWcV;qhj5@XY#Gsl
$$Z;gB\Jr#\Ek0\QE#<oT;n*rQDQoGjM).9<b+29J@EK>gLO6E"a\f2&ASGD`270d=d+EC)&
RFIdbI<I!O,Wb)>%0c;t1a/V$>)6CE,dKcT*Q"&\0&)0`/<"WEM,F5/'")_^(cTYet+FN3]AI
:h)<!7(CKR?E`Xmi;PBR9]As%cUee.dr*mLgk4i@L)dhJ";Z2LkHi=3~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="19" y="4" width="252" height="55"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="出勤率画布"/>
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
<WidgetName name="出勤率画布"/>
<WidgetID widgetID="be1c2b5b-e5ce-4ae5-8473-fa3f41b48bb1"/>
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
<WidgetName name="出勤率画布"/>
<WidgetID widgetID="be1c2b5b-e5ce-4ae5-8473-fa3f41b48bb1"/>
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
<BoundsAttr x="768" y="7" width="377" height="371"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="延误分析画布"/>
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
<WidgetName name="延误分析画布"/>
<WidgetID widgetID="3310313d-fd19-4555-8524-36f29e05f7f4"/>
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
<WidgetName name="延误分析画布"/>
<WidgetID widgetID="3310313d-fd19-4555-8524-36f29e05f7f4"/>
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
<BoundsAttr x="7" y="390" width="1138" height="208"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="准点率画布"/>
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
<WidgetName name="准点率画布"/>
<WidgetID widgetID="2df5fe96-606a-4a71-9d7c-e840c3ec1a66"/>
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
<![CDATA[m9G!?'5+o>XBSt'Q/ckbm?*K6"Au5deo$TQ81WEAX?r]AJdTRs_'lC!S&\495?+"q22'Zg=WY
eVQ?(P>ZH+[u(QXm\=$5!HX.b[.b8haWY@gHTN\]AgK"ASk52Dt\bY+D1VCq=;f)^>JhbhVW[
Jr6Lj(d$Ua2qrscHTJ6fjbZb\ooMe4Td"oZU(eNRep#.03:f-9n$g55&]ABk1;9e5+,48Q;V]A
Rm!%a!1+M(aa`2*;iFsp1_31?J?J4p#_4923FeQEHpNCn'q"^WVa!<F4Q(P3*`R8ZK+@iLTj
D*s&#A5bFYuL[II/ZTrj0;%r905-a@.KhcM\d;Vd?1;bGu$pf_>6,9j#Qa+jD.llE3=7-)+4
HKsVTqjB"_Ec+s<9`EdJDg^",%)jaG+@AQ5*CIifn%[eS;85;:6>`#AmTI^On\\p#)"m^$lb
%=,V!)CONrQlHHT)_JH>`45R7'gsP%iIb0I!7_Wt@"*k*F_K$8XFinlU9/BfD*l/@AjDZ'co
9CA+Y`,Y&hiF9:FCX&,:a"l"AVO,tZ,/bl2[P!=^p`Zj/\eYpEmR"'7<A+A;96CD(*0?"7n+
/_A@*dr#;h!B9i"u^"7hqk$UaKG1g:jR8,F-[cQZ?fU&-tfeG6f3`m_m8+D;32q`/97cSjeh
V_D9\"PX3glQ8#b;nr>fCOImFCAqgN]A0X]A;C5`S4/=Ud4C,&(gScYK^40VEf"c;:fm9h?B#Z
:9GaUPX.t#$iK9A%bH3l\j?aJbk@'H9)eNU51>6e:H%jZql4#omZO=ocu%1=PBr5TWpBAM')
3Et*\"jU[G7KgEQMLLWQj'8/rP',FA!IZ@3s(Y>%X^JpSrX'I9arU*_Y35*XdJXN`'UShT"4
0jBAXZD?%6Uh/6<]Ag`,YqDc>.nS:(+3LE$mUPu\g2-mJf\5eUhW0>3G]ACj?-N(X01mH,Cu9^
3#:-7W/l<r_QA=L<pRJ#c*tp'HVuu+j*]A-=ujf,itM-)DIGS7$\(6"5t14Om&IB[SXH^0X)c
W!"M9[hg)EeOTBEK3ge<dScBcQUZ@*Q@LKKItHIeCQbsRT9UpA&nbpK@*87Uj)a(Eom=:"4u
.qo\G^-N"uD*j*U2gQ6R&?8@DI5#*;-/@+ZAQK=>$n!Nmc"\Ln[WZPW!)5U?>.#dGMsoEe*3
LS-H.m:#8dQm$]Ag&)nc`HHEP5d<7#GrGd`%d:efL]Arp;gJ+DA4EG*`K/:?cnG9emX$o?[OFU
V?`hhA^Y<Va&0'6Y]A3a<b%j?G>;"7u&1&EKe`%c4.^N5oA:P#"1Y4'+]A?T=2UU&P-2C3E$q4
.GNR#bJrYN"jeWp'9YBahQsYT7,a0k;-(-`m819j_4Y8rY3k+KMDB>U4#nbQgl<s4Ytfe8j?
.U9fkMcp3cn\B":U,?[\6,rW5p1(hSG5e3_6\5;[sT?GE3-[=7jFGiTH/5iVYii/1'@q@9mS
Xq$_'N30*Eent`<LN[_JWXEo<dWtFlRb);Y@iL+`QcYS89[rOSk9SYK_i53agJ+3B:;)n3N1
#+_.O_>uCC5oY1JP?s=7[q8-$=F;.>7$bgAP#.9PsE^1U)7S=ScjTn6'Tm]A"BEKgjU@&Z^>%
s5/*r\dJZ8C#J^<(p[N[@hs]AV&80K!1^V"SgDVPN?QT5gW4GW*#$-.KM5-4>nl<-\JddQ3[6
t*er\OdnC$)RR&UVY3d;24)X+ZUbr`O(k&/mV.WP[2i>&_q$W7&uDb>&ua0E!Q&_8Zq&jH5A
]Ah'"t'7%]AHm'fHm1S8X`1%3f38'+4DuHOiu/6l)\(1XM8`SC>Y=<D$\e`OO0#?f9ot13@+f4
+e#Z.,i)C-q,Qd@ao.gNpSbH&.q!F6e<Fat>GKng`iX*B.aTabn31epf2GK(\Cbc/!LqdijO
P<J>d:KXW5X2pP^Z.CO97Eo^+V)[M+_d.IHA1AROqL9%+sQoM0;_#U1-QH>Isj[4pmI$f?R0
)a"LhON/Im>GMBa%CQ"&RGb;_R2]AED@X3HR$I89kpa0NKE.ZGYg!oO/R0'u@6U>>dI*'XF&e
hAhNBPClu5HNA'G[URM933q0Va&HK&+'X)gsfL&M!aqE7Rlr2.@AK_V/j?u]Abgqe18\q\4g$
aM!PBAc%d;`=>Tea^:D>/qY#>kj&BDME)(r/(([lHA^A*59V-6&'!\A"UBIE+`c7tN;R2/3j
=TIXDToi:6bg-Bq<]A8.^^0RRp"HLE&h!K"B$D>unj.?Bf%g33c9G!#1.X)n5l"q[l4$lZ`>j
rJV+I3>P1B35C39=5W8HCen)Ted_C('B)S)`bOnMIJ`ni87M60_oeOS&n)17)oKZP%X*%$+o
MEjrj7dCX>qK1k7_4q?`Q.'u>_kP<X[RO/rp,r2Q@-^s(:%>+WcP?nJTr7,D8E3[4^&NCM-9
,QjmFm4OJ6P^+7lipSGPF?_ki0rF73bY=ROWq,3Wi+kY-,"e0S)Za7Ok:ZY?9a3UNq$ML,40
F)KYmp`!RF*3*J*+STL;fS)ND?5ClJ0=BAp*LlL!-L0QI(K?l!Qlj>hP@N(h6LSDG:mN"#oX
m]A-j$14_]A&;6.`,"u<>&=QHjL1^p;AV:6'Da^B/EFR3fT.OpK'^#!m7M_\Y4-^$_sg)M-kB*
!HNC'P1mq&)N[=Y!Ej-.nPPCHc2__@Uq#&57,MO<sS4oLNqq\JiqJ;mnkOYOf)kAi`=SHKel
F%<CQiO$I:ZX-9:$af%V;8)ui<93=._Z#O']AI8h=r&7BWF/ZWCHQ?3n:.QY)=2eph,.((Kd1
@TBJ1W'#X_1"X+kj>[lA+T=]Ak*N$C__`GYY7-W?JO"4=P)dM&;eN(c4H0KU644sf3r=aibp`
pIQ%ggQ$[k2CP[>P#"!#Ld3<UbO8%G-!1AOt$=349p&.P"3\_E'"U*5eh^JL[bQq0r$]At\,L
2\*LaqfkL2H;Dh08WNU[aFi@7ohLh8$0e/bC<,LrasgWTF'<SXGoC@bGSZUe:r[%Q!:35@Aj
k!Zk42W^!biQ44l2i/FN$bGJX_C5I-SLW1rj'cfNjH\E7(>gDMc4JaBf+GUBf0Y9_,Z)Q.PX
<R/?JRTB3<;o\O@d2!R:(`*?&[EB&8PE(Ctrl>I5VJ>++J-HP]AS+Csb:]A%ogqjI8Oc>jpE%#
UQ^q,%>M6>2!45H0#?f+#(CoeqtbL7MZK8*M_?DdYW%n^"85&F^Q"_rUJ.#&-OgjcLrLFR0Y
u)?#QrP)`gFZ."ZYk>EM1>nNhohi-]A8>);!Oh%[1^\US[[iUH1M1]A\l)2oSJ<m,>X'eK=.J.
%+QqseD,DP5tlns<>XPGE[rl$f*!FH9c=1LBa^mdY^mu2WCZ!YNRMiJ:8_rjC-gii_qP/-c$
qV_quhVD#JlJA$a8JJb:kW&Qf]Ajj[,1%]Ada3f!r9a87q/#>WDku,%'eM3\_))bg/X3<K4rT*
;_r@+)DAk<'gs.GhQ(L6>71*Mgo[]A_(DgQX4W*=e`q4.sdh9oTtBgnV4YVE0!.#9`VdVZ0.K
J6Te-KOIPj+-"hOl1F@NN;6=Ns']A1:@#$&J%?-jGaFLBEGbf_:OZCKMQ'H6g&8nNRpuMRTg3
&-?Uqfa81O$?C-Mqns'<ZlI'#QW"r1W/k@GQ=PH)k=ik%In,4jt*d)'<YF2^3;M.Ud#5fH28
]AlYu3JsF^X)?VEDlO\ZfLY(Udj!IcZdeIM&efmJ1'dsn^#mI*6^9?KNX"3FBTl$3'SS1c,&f
1c/.qU6W(R``m+VHS]AMMuD?4bhNP)Yd/CcQoO+=M9MCm4=$hlY3)JQLdQ8j-@j7"!<p@)-D.
e6N"/+Y8he>pI[*-ploc@?HBM/.@[4_rSB&Pk,gT"QnZZ3o'H2BH=ekq)agQi3e<MAN,#=FO
g;o&/bQ5H:KLLjH'?1DCr"oQY*qYQ\mQg?oi[7DU.XUL3h;YLK6giKA4RjTc%N=HVl@+MY!o
Bug1e,q=/j_JmIot:B['&9Z*7qGl0FQH93d<.dDQ<YHp$>paO8?pX%Y^6H<:bid$3SE'H2!_
>&O^RMDIIi/VZrj9<I8FYj(OP3PV4PmkOhalMN"EH4N#P7\%RD=q\[nC1,k4RPrN<a^\g9V4
,M9,B;otpcb_C:d-I1+^q(3f>pV2*S@g28hbrIj,4=7,IN%m`Uj:Aj^GQB/G4*:+\dq_S$`e
Y"6rN7E4c>+r0(Q7X_D%0;Z9Dk9`[*LHY>1Ja!WWX_62tHQTa0VH<aPZ<!Dt[?kirJ5,T$Og
n4#[XnWb60?`^)lq"#*>teaE85k3iA.CO)$nOrek&.%;V@&5hMPZ(_7AH;l1C-qM7UcUAFcV
;hTmAG%GOR\_+6mu>YUG:GOY@%J-BD?4dFJlk[F$\a)p@U!J(P?"dY6$jJl6fWX/8"LGjiX_
c"kgNb^);h;s#CiFn;TQjXdIJAIFp)M;!Ilc_5q)9e6P\oO3AoR*\eN&n=?XM6DJCc]AHfS!4
!XXZ?3fu!IlGXUkD-cKTFBq4G8/Dd*@I%;6JY,\5puW(-@-3=t+*9,Er%iZUjEaa]AlQIo6lr
XW]AW1m7^,6L:K`?h,C#X2'qR1?<*BTOgST,ekQ'WN0YX/5.mY\;lE]A0_e=0NFHrG6d=itq6)
9)YG1<X^L&#d_tWS_G8j0l*Gi35+GVmV/C4"k$.\L%K8j?3)\=Gt8foN'O89At[*WR6,JCO#
WCJLd*$cS]ARjnqEBI+o#Hk9fX`JX\.&]ANo/NVo#8C&Y0TNCZTYu-,9d>Rgk4^u9Lct8_#dIl
^Q5BA5#@_u%YRdb?H,K05ikP*)A(^CYU@>KpIlQ[E&)s2-PeFmf=hPHC]A_*T[CH=p8;8biPX
=T"%TnpbN3*(ufJ_XTE).Xj/#JNW8A$o4[DY"T(b$"@r@:>]Akm@O66QBa=D`4P`V1c>NboD%
QVIE4tJZ0eWFb3`V-?`:fCZ'P/e:f_:]A('aDUmJ-#>4@4mp&_oh\.LjYa@(GL"$A3oQ%jfj3
WX/@pG`1",:tt$eV_6%38X[@/P[\@iNn\%e2eM)L/f9jJjG%24_8>8rLcJe1D?8j)'5]A``Mg
a8&mr%+m\+5p9?#=,,FJNAqT66.ZeYF0>D&LIU4lN#h8GnO+S=fIUMq/'i33j0+cX6]AZcEF=
J/Et3&@3o'P^3)1a/-tsa6)WQVLSO)cohE0-[K%F\G`,p<g=nD=P3?j*$@\3_.[o(#Q&o3C"
-Mif$jS'2MTB8Cd8c(UUN[W/d<)GZ:#ap(>,bIG<KU`\>oXranb]A8YS`Xq$qKV4)BDL?.;.,
6&%du51BV/?5j&%t109KcgOM-.nN'O1pfAb*pQ]A`h1n"eg_.pCR<BpZ'DYo\k/WK`TU/rckS
\\'/^L%bK3!kh&kRM<q"0B\CrfS_UH?AN_%O1+dA*lL1IJHWM&:#jtT/?$#gct`$rr<~
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
<WidgetName name="准点率画布"/>
<WidgetID widgetID="2df5fe96-606a-4a71-9d7c-e840c3ec1a66"/>
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
<![CDATA[m9G!?'5+o>XBSt'Q/ckbm?*K6"Au5deo$TQ81WEAX?r]AJdTRs_'lC!S&\495?+"q22'Zg=WY
eVQ?(P>ZH+[u(QXm\=$5!HX.b[.b8haWY@gHTN\]AgK"ASk52Dt\bY+D1VCq=;f)^>JhbhVW[
Jr6Lj(d$Ua2qrscHTJ6fjbZb\ooMe4Td"oZU(eNRep#.03:f-9n$g55&]ABk1;9e5+,48Q;V]A
Rm!%a!1+M(aa`2*;iFsp1_31?J?J4p#_4923FeQEHpNCn'q"^WVa!<F4Q(P3*`R8ZK+@iLTj
D*s&#A5bFYuL[II/ZTrj0;%r905-a@.KhcM\d;Vd?1;bGu$pf_>6,9j#Qa+jD.llE3=7-)+4
HKsVTqjB"_Ec+s<9`EdJDg^",%)jaG+@AQ5*CIifn%[eS;85;:6>`#AmTI^On\\p#)"m^$lb
%=,V!)CONrQlHHT)_JH>`45R7'gsP%iIb0I!7_Wt@"*k*F_K$8XFinlU9/BfD*l/@AjDZ'co
9CA+Y`,Y&hiF9:FCX&,:a"l"AVO,tZ,/bl2[P!=^p`Zj/\eYpEmR"'7<A+A;96CD(*0?"7n+
/_A@*dr#;h!B9i"u^"7hqk$UaKG1g:jR8,F-[cQZ?fU&-tfeG6f3`m_m8+D;32q`/97cSjeh
V_D9\"PX3glQ8#b;nr>fCOImFCAqgN]A0X]A;C5`S4/=Ud4C,&(gScYK^40VEf"c;:fm9h?B#Z
:9GaUPX.t#$iK9A%bH3l\j?aJbk@'H9)eNU51>6e:H%jZql4#omZO=ocu%1=PBr5TWpBAM')
3Et*\"jU[G7KgEQMLLWQj'8/rP',FA!IZ@3s(Y>%X^JpSrX'I9arU*_Y35*XdJXN`'UShT"4
0jBAXZD?%6Uh/6<]Ag`,YqDc>.nS:(+3LE$mUPu\g2-mJf\5eUhW0>3G]ACj?-N(X01mH,Cu9^
3#:-7W/l<r_QA=L<pRJ#c*tp'HVuu+j*]A-=ujf,itM-)DIGS7$\(6"5t14Om&IB[SXH^0X)c
W!"M9[hg)EeOTBEK3ge<dScBcQUZ@*Q@LKKItHIeCQbsRT9UpA&nbpK@*87Uj)a(Eom=:"4u
.qo\G^-N"uD*j*U2gQ6R&?8@DI5#*;-/@+ZAQK=>$n!Nmc"\Ln[WZPW!)5U?>.#dGMsoEe*3
LS-H.m:#8dQm$]Ag&)nc`HHEP5d<7#GrGd`%d:efL]Arp;gJ+DA4EG*`K/:?cnG9emX$o?[OFU
V?`hhA^Y<Va&0'6Y]A3a<b%j?G>;"7u&1&EKe`%c4.^N5oA:P#"1Y4'+]A?T=2UU&P-2C3E$q4
.GNR#bJrYN"jeWp'9YBahQsYT7,a0k;-(-`m819j_4Y8rY3k+KMDB>U4#nbQgl<s4Ytfe8j?
.U9fkMcp3cn\B":U,?[\6,rW5p1(hSG5e3_6\5;[sT?GE3-[=7jFGiTH/5iVYii/1'@q@9mS
Xq$_'N30*Eent`<LN[_JWXEo<dWtFlRb);Y@iL+`QcYS89[rOSk9SYK_i53agJ+3B:;)n3N1
#+_.O_>uCC5oY1JP?s=7[q8-$=F;.>7$bgAP#.9PsE^1U)7S=ScjTn6'Tm]A"BEKgjU@&Z^>%
s5/*r\dJZ8C#J^<(p[N[@hs]AV&80K!1^V"SgDVPN?QT5gW4GW*#$-.KM5-4>nl<-\JddQ3[6
t*er\OdnC$)RR&UVY3d;24)X+ZUbr`O(k&/mV.WP[2i>&_q$W7&uDb>&ua0E!Q&_8Zq&jH5A
]Ah'"t'7%]AHm'fHm1S8X`1%3f38'+4DuHOiu/6l)\(1XM8`SC>Y=<D$\e`OO0#?f9ot13@+f4
+e#Z.,i)C-q,Qd@ao.gNpSbH&.q!F6e<Fat>GKng`iX*B.aTabn31epf2GK(\Cbc/!LqdijO
P<J>d:KXW5X2pP^Z.CO97Eo^+V)[M+_d.IHA1AROqL9%+sQoM0;_#U1-QH>Isj[4pmI$f?R0
)a"LhON/Im>GMBa%CQ"&RGb;_R2]AED@X3HR$I89kpa0NKE.ZGYg!oO/R0'u@6U>>dI*'XF&e
hAhNBPClu5HNA'G[URM933q0Va&HK&+'X)gsfL&M!aqE7Rlr2.@AK_V/j?u]Abgqe18\q\4g$
aM!PBAc%d;`=>Tea^:D>/qY#>kj&BDME)(r/(([lHA^A*59V-6&'!\A"UBIE+`c7tN;R2/3j
=TIXDToi:6bg-Bq<]A8.^^0RRp"HLE&h!K"B$D>unj.?Bf%g33c9G!#1.X)n5l"q[l4$lZ`>j
rJV+I3>P1B35C39=5W8HCen)Ted_C('B)S)`bOnMIJ`ni87M60_oeOS&n)17)oKZP%X*%$+o
MEjrj7dCX>qK1k7_4q?`Q.'u>_kP<X[RO/rp,r2Q@-^s(:%>+WcP?nJTr7,D8E3[4^&NCM-9
,QjmFm4OJ6P^+7lipSGPF?_ki0rF73bY=ROWq,3Wi+kY-,"e0S)Za7Ok:ZY?9a3UNq$ML,40
F)KYmp`!RF*3*J*+STL;fS)ND?5ClJ0=BAp*LlL!-L0QI(K?l!Qlj>hP@N(h6LSDG:mN"#oX
m]A-j$14_]A&;6.`,"u<>&=QHjL1^p;AV:6'Da^B/EFR3fT.OpK'^#!m7M_\Y4-^$_sg)M-kB*
!HNC'P1mq&)N[=Y!Ej-.nPPCHc2__@Uq#&57,MO<sS4oLNqq\JiqJ;mnkOYOf)kAi`=SHKel
F%<CQiO$I:ZX-9:$af%V;8)ui<93=._Z#O']AI8h=r&7BWF/ZWCHQ?3n:.QY)=2eph,.((Kd1
@TBJ1W'#X_1"X+kj>[lA+T=]Ak*N$C__`GYY7-W?JO"4=P)dM&;eN(c4H0KU644sf3r=aibp`
pIQ%ggQ$[k2CP[>P#"!#Ld3<UbO8%G-!1AOt$=349p&.P"3\_E'"U*5eh^JL[bQq0r$]At\,L
2\*LaqfkL2H;Dh08WNU[aFi@7ohLh8$0e/bC<,LrasgWTF'<SXGoC@bGSZUe:r[%Q!:35@Aj
k!Zk42W^!biQ44l2i/FN$bGJX_C5I-SLW1rj'cfNjH\E7(>gDMc4JaBf+GUBf0Y9_,Z)Q.PX
<R/?JRTB3<;o\O@d2!R:(`*?&[EB&8PE(Ctrl>I5VJ>++J-HP]AS+Csb:]A%ogqjI8Oc>jpE%#
UQ^q,%>M6>2!45H0#?f+#(CoeqtbL7MZK8*M_?DdYW%n^"85&F^Q"_rUJ.#&-OgjcLrLFR0Y
u)?#QrP)`gFZ."ZYk>EM1>nNhohi-]A8>);!Oh%[1^\US[[iUH1M1]A\l)2oSJ<m,>X'eK=.J.
%+QqseD,DP5tlns<>XPGE[rl$f*!FH9c=1LBa^mdY^mu2WCZ!YNRMiJ:8_rjC-gii_qP/-c$
qV_quhVD#JlJA$a8JJb:kW&Qf]Ajj[,1%]Ada3f!r9a87q/#>WDku,%'eM3\_))bg/X3<K4rT*
;_r@+)DAk<'gs.GhQ(L6>71*Mgo[]A_(DgQX4W*=e`q4.sdh9oTtBgnV4YVE0!.#9`VdVZ0.K
J6Te-KOIPj+-"hOl1F@NN;6=Ns']A1:@#$&J%?-jGaFLBEGbf_:OZCKMQ'H6g&8nNRpuMRTg3
&-?Uqfa81O$?C-Mqns'<ZlI'#QW"r1W/k@GQ=PH)k=ik%In,4jt*d)'<YF2^3;M.Ud#5fH28
]AlYu3JsF^X)?VEDlO\ZfLY(Udj!IcZdeIM&efmJ1'dsn^#mI*6^9?KNX"3FBTl$3'SS1c,&f
1c/.qU6W(R``m+VHS]AMMuD?4bhNP)Yd/CcQoO+=M9MCm4=$hlY3)JQLdQ8j-@j7"!<p@)-D.
e6N"/+Y8he>pI[*-ploc@?HBM/.@[4_rSB&Pk,gT"QnZZ3o'H2BH=ekq)agQi3e<MAN,#=FO
g;o&/bQ5H:KLLjH'?1DCr"oQY*qYQ\mQg?oi[7DU.XUL3h;YLK6giKA4RjTc%N=HVl@+MY!o
Bug1e,q=/j_JmIot:B['&9Z*7qGl0FQH93d<.dDQ<YHp$>paO8?pX%Y^6H<:bid$3SE'H2!_
>&O^RMDIIi/VZrj9<I8FYj(OP3PV4PmkOhalMN"EH4N#P7\%RD=q\[nC1,k4RPrN<a^\g9V4
,M9,B;otpcb_C:d-I1+^q(3f>pV2*S@g28hbrIj,4=7,IN%m`Uj:Aj^GQB/G4*:+\dq_S$`e
Y"6rN7E4c>+r0(Q7X_D%0;Z9Dk9`[*LHY>1Ja!WWX_62tHQTa0VH<aPZ<!Dt[?kirJ5,T$Og
n4#[XnWb60?`^)lq"#*>teaE85k3iA.CO)$nOrek&.%;V@&5hMPZ(_7AH;l1C-qM7UcUAFcV
;hTmAG%GOR\_+6mu>YUG:GOY@%J-BD?4dFJlk[F$\a)p@U!J(P?"dY6$jJl6fWX/8"LGjiX_
c"kgNb^);h;s#CiFn;TQjXdIJAIFp)M;!Ilc_5q)9e6P\oO3AoR*\eN&n=?XM6DJCc]AHfS!4
!XXZ?3fu!IlGXUkD-cKTFBq4G8/Dd*@I%;6JY,\5puW(-@-3=t+*9,Er%iZUjEaa]AlQIo6lr
XW]AW1m7^,6L:K`?h,C#X2'qR1?<*BTOgST,ekQ'WN0YX/5.mY\;lE]A0_e=0NFHrG6d=itq6)
9)YG1<X^L&#d_tWS_G8j0l*Gi35+GVmV/C4"k$.\L%K8j?3)\=Gt8foN'O89At[*WR6,JCO#
WCJLd*$cS]ARjnqEBI+o#Hk9fX`JX\.&]ANo/NVo#8C&Y0TNCZTYu-,9d>Rgk4^u9Lct8_#dIl
^Q5BA5#@_u%YRdb?H,K05ikP*)A(^CYU@>KpIlQ[E&)s2-PeFmf=hPHC]A_*T[CH=p8;8biPX
=T"%TnpbN3*(ufJ_XTE).Xj/#JNW8A$o4[DY"T(b$"@r@:>]Akm@O66QBa=D`4P`V1c>NboD%
QVIE4tJZ0eWFb3`V-?`:fCZ'P/e:f_:]A('aDUmJ-#>4@4mp&_oh\.LjYa@(GL"$A3oQ%jfj3
WX/@pG`1",:tt$eV_6%38X[@/P[\@iNn\%e2eM)L/f9jJjG%24_8>8rLcJe1D?8j)'5]A``Mg
a8&mr%+m\+5p9?#=,,FJNAqT66.ZeYF0>D&LIU4lN#h8GnO+S=fIUMq/'i33j0+cX6]AZcEF=
J/Et3&@3o'P^3)1a/-tsa6)WQVLSO)cohE0-[K%F\G`,p<g=nD=P3?j*$@\3_.[o(#Q&o3C"
-Mif$jS'2MTB8Cd8c(UUN[W/d<)GZ:#ap(>,bIG<KU`\>oXranb]A8YS`Xq$qKV4)BDL?.;.,
6&%du51BV/?5j&%t109KcgOM-.nN'O1pfAb*pQ]A`h1n"eg_.pCR<BpZ'DYo\k/WK`TU/rckS
\\'/^L%bK3!kh&kRM<q"0B\CrfS_UH?AN_%O1+dA*lL1IJHWM&:#jtT/?$#gct`$rr<~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="7" y="6" width="757" height="372"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="准点率-标题"/>
<Widget widgetName="准点率画布"/>
<Widget widgetName="出勤率画布"/>
<Widget widgetName="p"/>
<Widget widgetName="出勤率-标题"/>
<Widget widgetName="准点率-机型维度"/>
<Widget widgetName="02.指标卡-出勤率"/>
<Widget widgetName="计划量"/>
<Widget widgetName="准点率-同环比"/>
<Widget widgetName="执行量"/>
<Widget widgetName="延误量"/>
<Widget widgetName="chart0"/>
<Widget widgetName="chart2"/>
<Widget widgetName="07.运行指标-OIBU线维度"/>
<Widget widgetName="08.运行指标-国际国内维度"/>
<Widget widgetName="延误分析画布"/>
<Widget widgetName="延误分析-标题"/>
<Widget widgetName="详情链接"/>
<Widget widgetName="延误-时长维度"/>
<Widget widgetName="延误-延误原因维度"/>
<Widget widgetName="延误-航班对象维度"/>
<Widget widgetName="延误-机型维度"/>
<Widget widgetName="延误-明细表"/>
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
<Widget widgetName="绝对画布1"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="510"/>
<ResolutionScalingAttr percent="1.2"/>
<tabFitAttr index="0" tabNameIndex="0">
<initial>
<Background name="ColorBackground" color="-15386770"/>
</initial>
<click>
<Background name="ColorBackground" color="-15386770"/>
</click>
<isCustomStyle isCustomStyle="true"/>
</tabFitAttr>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<carouselAttr isCarousel="false" carouselInterval="1.8"/>
</Center>
</InnerWidget>
<BoundsAttr x="0" y="0" width="1152" height="648"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="true"/>
<MobileWidgetList>
<Widget widgetName="tablayout0"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
<AppRelayout appRelayout="true"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="960" height="540"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList/>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="0"/>
<AppRelayout appRelayout="true"/>
<Size width="960" height="540"/>
<ResolutionScalingAttr percent="1.2"/>
<BodyLayoutType type="1"/>
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
<TemplateIdAttMark TemplateId="1e0748df-f8c0-4a4b-960b-6ae7b29b79ca"/>
</TemplateIdAttMark>
</Form>
