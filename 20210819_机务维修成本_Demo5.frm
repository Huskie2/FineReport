<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="飞行小时与维修成本2" class="com.fr.data.impl.DBTableData">
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
<![CDATA[select * from (
select
      gjahr 年份,
      '机群' 机型,
      max(interval_msg) 最大月份,
      sum(res_dmbtr)/10000 维修成本万元,
      sum(fh) 飞行小时,
      sum(res_dmbtr)/sum(fh) 小时成本
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di
where interval_date = 'monthly'
  and gjahr = DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%Y')
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and model = 'fleet'
  and bukrs = 'EX01'
  and analysis_description = '运营成本'
union all
select 
      gjahr 年份,
      model_msg 机型,
      max(interval_msg) 最大月份,
      sum(res_dmbtr)/10000 维修成本万元,
      sum(fh) 飞行小时,
      sum(res_dmbtr)/sum(fh) 小时成本
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di
where interval_date = 'monthly'
  and gjahr = DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%Y')
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and model = 'model'
  and bukrs = 'EX01'
  and analysis_description = '运营成本'
group by model_msg
union all
select
      gjahr 年份,
      '机群' 机型,
      max(interval_msg) 最大月份,
      sum(res_dmbtr)/10000 维修成本万元,
      sum(fh) 飞行小时,
      sum(res_dmbtr)/sum(fh) 小时成本
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di_history
where interval_date = 'monthly'
  and gjahr < '2021'
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and model = 'fleet'
  and bukrs = 'EX01'
  and analysis_description = '运营成本'
group by gjahr
union all
select 
      gjahr 年份,
      model_msg 机型,
      max(interval_msg) 最大月份,
      sum(res_dmbtr)/10000 维修成本万元,
      sum(fh) 飞行小时,
      sum(res_dmbtr)/sum(fh) 小时成本
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di_history
where interval_date = 'monthly'
  and gjahr < '2021'
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and model = 'model'
  and bukrs = 'EX01'
  and analysis_description = '运营成本'
group by gjahr,model_msg 
) a
where 1=1
  and a.机型 = '${jx}'
order by 2,1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="维修成本结构拆分" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="jx"/>
<O>
<![CDATA[机群]]></O>
</Parameter>
<Parameter>
<Attributes name="cb"/>
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
      t.*
from (
select
      gjahr 年份,
      analysis_description 成本结构项,
      res_dmbtr/10000 成本金额,
      fh 飞行小时
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di
where interval_date = 'yearly'
  and gjahr = '2021'
  and bukrs = 'EX01'
  ${if(jx == '机群',"and model = 'fleet'","and model = 'model'")}
  ${if(jx == '机群',"","and model_msg = '" + jx + "'")}
  and left(analysis_num,2) = 'F0'
union all
select
      gjahr 年份,
      analysis_description 成本结构项,
      res_dmbtr/10000 成本金额,
      fh 飞行小时
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di_history
where interval_date = 'yearly'
  and gjahr < '2021'
  and bukrs = 'EX01'
  ${if(jx == '机群',"and model = 'fleet'","and model = 'model'")}
  ${if(jx == '机群',"","and model_msg = '" + jx + "'")}
  and left(analysis_num,2) = 'F0'

union all 
select 
      a.年份,'架次',sum(b.架次) 架次,null
from (
select distinct substr(ac_op_date,1,4) 年份 
from  dim_sh_aircraft_info_df
where status_name = '运行'
  and substr(ac_op_date,1,10) < date_format(now(),'%Y-%m-%d')
) a
left join (
select 
      substr(ac_op_date,1,4) 年份,
      count(*) 架次
from dim_sh_aircraft_info_df 
where 1=1 
  and status_name = '运行'
  and substr(ac_op_date,1,10) < date_format(now(),'%Y-%m-%d')
  ${if(jx == '机群',"","and mp_ac_type = '" + jx + "'")}
group by substr(ac_op_date,1,4)
) b on a.年份>=b.年份
where b.年份 is not null
  and a.年份 > 2016
group by a.年份
) t
where 1 = 1
  ${if(or(len(cb)==0,cb="全选"),"","and 成本结构项 in ('架次','" + cb + "')")}
order by case when 成本结构项="发动机循环成本" then 1
               when 成本结构项="飞机机身成本" then 2
                when 成本结构项="周转件成本-维修" then 3
                 when 成本结构项="飞机运营定检" then 4
                  when 成本结构项="飞机日常维修成本" then 5
                   when 成本结构项="过渡检成本" then 6
                    when 成本结构项="周转件成本-折旧" then 7
                     when 成本结构项="发动机机身成本" then 8
                      when 成本结构项="航材处置成本" then 9
                       when 成本结构项="大部件维修成本" then 10
                        when 成本结构项="工具成本" then 11
                         when 成本结构项="技术服务费" then 12
                          when 成本结构项="周转件成本-租赁" then 13
                           when 成本结构项="飞机成本-飞机改装-适航类" then 14
                            when 成本结构项="发动机小修成本" then 15
                             when 成本结构项="飞机成本-飞机改装-运行改善类" then 16
                              else 17 
                               end,1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="成本结构项" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
      distinct 
      analysis_description 成本结构项
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di
where interval_date = 'yearly'
  and gjahr = '2021'
  and bukrs = 'EX01'
  and left(analysis_num,2) = 'F0'
  and analysis_description not in ('飞机成本-飞机改装-适航类','飞机成本-飞机改装-运行改善类','过渡检成本','飞机机身成本','发动机机身成本','航材处置成本','大部件租赁成本')
order by case when 成本结构项="发动机循环成本" then 1
               when 成本结构项="飞机机身成本" then 2
                when 成本结构项="周转件成本-维修" then 3
                 when 成本结构项="飞机运营定检" then 4
                  when 成本结构项="飞机日常维修成本" then 5
                   when 成本结构项="过渡检成本" then 6
                    when 成本结构项="周转件成本-折旧" then 7
                     when 成本结构项="发动机机身成本" then 8
                      when 成本结构项="航材处置成本" then 9
                       when 成本结构项="大部件维修成本" then 10
                        when 成本结构项="工具成本" then 11
                         when 成本结构项="技术服务费" then 12
                          when 成本结构项="周转件成本-租赁" then 13
                           when 成本结构项="飞机成本-飞机改装-适航类" then 14
                            when 成本结构项="发动机小修成本" then 15
                             when 成本结构项="飞机成本-飞机改装-运行改善类" then 16
                              end]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="飞行小时" class="com.fr.data.impl.DBTableData">
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
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
      distinct 
      gjahr 年份,
      fh 飞行小时
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di
where interval_date = 'yearly'
  and gjahr = '2021'
  and bukrs = 'EX01'
  and fh > 0
  ${if(jx == '机群',"and model = 'fleet'","and model = 'model'")}
  ${if(jx == '机群',"","and model_msg = '" + jx + "'")}
union all
select
      distinct 
      gjahr 年份,
      fh 飞行小时
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di_history
where interval_date = 'yearly'
  and gjahr < '2021'
  and bukrs = 'EX01'
  and fh > 0
  ${if(jx == '机群',"and model = 'fleet'","and model = 'model'")}
  ${if(jx == '机群',"","and model_msg = '" + jx + "'")}
order by 1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="架次" class="com.fr.data.impl.DBTableData">
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
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
      count(*) 架次
from dim_sh_aircraft_info_df 
where 1=1 
  and status_name = '运行'
  and substr(ac_op_date,1,10) < date_format(now(),'%Y-%m-%d')
  ${if(jx == '机群',"","and mp_ac_type = '" + jx + "'")}]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="单机成本" class="com.fr.data.impl.DBTableData">
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
      gjahr 年份,
      b.mp_ac_type 机型,
      model_msg 机号,
      b.出厂日期,
      b.运营日期,
      b.机龄,
      b.司龄,
      res_dmbtr/10000 维修成本万元,
      res_fh_cost 小时成本
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di a
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
) b on a.model_msg=b.ac_reg
where interval_date = 'yearly'
  and gjahr = '2021'
  and model = 'aircraft'
  and bukrs = 'EX01'
  and analysis_description = '运营成本'
  ${if(jx="机群","","and b.mp_ac_type = '" + jx + "'")}
order by 6 desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="单机成本明细" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="jx2"/>
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
      gjahr 年份,
      b.mp_ac_type 机型,
      model_msg 机号,
      res_dmbtr/10000 维修成本万元,
      res_fh_cost 小时成本
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di a
left join (
select distinct ac_reg,mp_ac_type from dim_sh_aircraft_info_df
where status_name = '运行'
) b on a.model_msg=b.ac_reg
where interval_date = 'yearly'
  and gjahr = '2021'
  and model = 'aircraft'
  and bukrs = 'EX01'
  and analysis_description = '运营成本'
  ${if(jx2="机群","","and b.mp_ac_type = '" + jx2 + "'")}
order by res_fh_cost desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="指标卡-维修成本飞行小时" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
      a.年份,
      a.最大月份,
      a.维修成本/100000000 维修成本亿元,
      a.飞行小时/10000 飞行小时万,
      cast(a.小时成本 as decimal) 小时成本,
      a.维修成本/b.维修成本tq-1 维修成本同比,
      a.飞行小时/b.飞行小时tq-1 飞行小时同比,
      a.小时成本/b.小时成本tq-1 小时成本同比
from (
select
      gjahr 年份,
      max(interval_msg) 最大月份,
      sum(res_dmbtr) 维修成本,
      sum(fh) 飞行小时,
      sum(res_dmbtr)/sum(fh) 小时成本
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di
where interval_date = 'monthly'
  and gjahr = DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%Y')
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and model = 'fleet'
  and bukrs = 'EX01'
  and analysis_description = '运营成本'
) a
cross join (
select
      gjahr 年份tq,
      max(interval_msg) 最大月份tq,
      sum(res_dmbtr) 维修成本tq,
      sum(fh) 飞行小时tq,
      sum(res_dmbtr)/sum(fh) 小时成本tq
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di_history
where interval_date = 'monthly'
  and gjahr = DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 13 month), '%Y')
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 13 month), '%m')
  and model = 'fleet'
  and bukrs = 'EX01'
  and analysis_description = '运营成本'
) b]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="指标卡-架次" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
      a.架次,
      a.架次-b.架次 架次同比
from (
select count(*) 架次 from dim_sh_aircraft_info_df
where 1=1 
  and status_name = '运行'
  and substr(ac_op_date,1,10) <= date_format(date_sub(date_sub(curdate(),interval 9 day),interval 1 month),'%Y-%m-%d')
) a
cross join (
select count(*) 架次 from dim_sh_aircraft_info_df
where 1=1 
  and status_name = '运行'
  and substr(ac_op_date,1,10) <= date_format(date_sub(date_sub(curdate(),interval 9 day),interval 13 month),'%Y-%m-%d')
) b]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="指标卡-航班量" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
      a.年份,
      a.最大月份,
      a.航班量,
      a.航班量/b.航班量-1 航班量同比
from (
select 
      left(period_date,4) 年份,
      max(right(period_date,2)) 最大月份,
      sum(circle)/10000 航班量
from dws_sh_fli_fo_flight_ino_cm_all_di
where statistical_dimension_info = 'fleet'
  and left(period_date,4) = DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%Y')
  and right(period_date,2) <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
group by left(period_date,4)
) a
cross join (
select
      left(period_date,4) 年份,
      max(right(period_date,2)) 最大月份,
      sum(circle)/10000 航班量
from dws_sh_fli_fo_flight_ino_cm_all_di
where statistical_dimension_info = 'fleet'
  and left(period_date,4) = DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 13 month), '%Y')
  and right(period_date,2) <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 13 month), '%m')
group by left(period_date,4)
) b]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
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
<TableData name="维修成本结构拆分优化" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="jx"/>
<O>
<![CDATA[机群]]></O>
</Parameter>
<Parameter>
<Attributes name="cb"/>
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
      t.*
from (
select
      gjahr 年份,
      analysis_description 成本结构项,
      sum(res_dmbtr)/10000 成本金额,
      sum(fh) 飞行小时
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di
where interval_date = 'monthly'
  and gjahr > '2020'
  and gjahr <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%Y')
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and bukrs = 'EX01'
  ${if(jx == '机群',"and model = 'fleet'","and model = 'model'")}
  ${if(jx == '机群',"","and model_msg = '" + jx + "'")}
  and left(analysis_num,2) = 'F0'
group by gjahr,analysis_description
union all
select
      gjahr 年份,
      analysis_description 成本结构项,
      sum(res_dmbtr)/10000 成本金额,
      sum(fh) 飞行小时
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di_history
where interval_date = 'yearly'
  and gjahr < '2021'
  and bukrs = 'EX01'
  ${if(jx == '机群',"and model = 'fleet'","and model = 'model'")}
  ${if(jx == '机群',"","and model_msg = '" + jx + "'")}
  and left(analysis_num,2) = 'F0'
group by gjahr,analysis_description
union all 
select 
      a.年份,'架次',sum(b.架次) 架次,null
from (
select distinct substr(ac_op_date,1,4) 年份 
from  dim_sh_aircraft_info_df
where status_name = '运行'
  and substr(ac_op_date,1,10) < date_format(date_sub(curdate(),interval 9 day),'%Y-%m-%d')
) a
left join (
select 
      substr(ac_op_date,1,4) 年份,
      count(*) 架次
from dim_sh_aircraft_info_df 
where 1=1 
  and status_name = '运行'
  and substr(ac_op_date,1,10) < date_format(date_sub(curdate(),interval 9 day),'%Y-%m-%d')
  ${if(jx == '机群',"","and mp_ac_type = '" + jx + "'")}
group by substr(ac_op_date,1,4)
) b on a.年份>=b.年份
where b.年份 is not null
  and a.年份 > 2016
group by a.年份
) t
where 1 = 1
  and 成本结构项 not in ('飞机成本-飞机改装-适航类','飞机成本-飞机改装-运行改善类','过渡检成本','飞机机身成本','发动机机身成本','航材处置成本','大部件租赁成本')
  ${if(or(len(cb)==0,cb="全选"),"","and 成本结构项 in ('架次','" + cb + "')")}
order by case when 成本结构项="架次" then 1
              when 成本结构项="发动机循环成本" then 2
               when 成本结构项="飞机机身成本" then 3
                when 成本结构项="周转件成本-维修" then 4
                 when 成本结构项="飞机运营定检" then 5
                  when 成本结构项="飞机日常维修成本" then 6
                   when 成本结构项="过渡检成本" then 7
                    when 成本结构项="周转件成本-折旧" then 8
                     when 成本结构项="发动机机身成本" then 9
                      when 成本结构项="航材处置成本" then 10
                       when 成本结构项="大部件维修成本" then 11
                        when 成本结构项="工具成本" then 12
                         when 成本结构项="技术服务费" then 13
                          when 成本结构项="周转件成本-租赁" then 14
                           when 成本结构项="飞机成本-飞机改装-适航类" then 15
                            when 成本结构项="发动机小修成本" then 16
                             when 成本结构项="飞机成本-飞机改装-运行改善类" then 17
                              else 18 
                               end,1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="维修成本结构化拆分汇总和飞行小时" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="jx"/>
<O>
<![CDATA[机群]]></O>
</Parameter>
<Parameter>
<Attributes name="cb"/>
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
      a.年份,
      a.成本金额 年度累计成本,
      a.飞行小时,
      b.成本金额 月度累计成本,
      b.飞行小时 月度累计飞行小时
from (
select
      gjahr 年份,
      sum(res_dmbtr)/10000 成本金额,
      sum(distinct fh) 飞行小时
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di
where interval_date = 'monthly'
  and gjahr > '2020'
  and gjahr <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%Y')
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and bukrs = 'EX01'
  ${if(jx == '机群',"and model = 'fleet'","and model = 'model'")}
  ${if(jx == '机群',"","and model_msg = '" + jx + "'")}
  and analysis_description not in ('飞机成本-飞机改装-适航类','飞机成本-飞机改装-运行改善类','过渡检成本','飞机机身成本','发动机机身成本','航材处置成本','大部件租赁成本')
  ${if(or(len(cb)==0,cb="全选"),"","and analysis_description in ('" + cb + "')")}
  and left(analysis_num,2) = 'F0'
group by gjahr
) a 
left join (
select
      gjahr 年份,
      sum(res_dmbtr)/10000 成本金额,
      sum(distinct fh) 飞行小时
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di
where interval_date = 'monthly'
  and gjahr > '2020'
  and gjahr <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%Y')
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and bukrs = 'EX01'
  ${if(jx == '机群',"and model = 'fleet'","and model = 'model'")}
  ${if(jx == '机群',"","and model_msg = '" + jx + "'")}
  and analysis_description not in ('飞机成本-飞机改装-适航类','飞机成本-飞机改装-运行改善类','过渡检成本','飞机机身成本','发动机机身成本','航材处置成本','大部件租赁成本')
  ${if(or(len(cb)==0,cb="全选"),"","and analysis_description in ('" + cb + "')")}
  and left(analysis_num,2) = 'F0'
group by gjahr
) b on a.年份 = b.年份
union all
select 
      a.年份,
      a.成本金额 年度累计成本,
      a.飞行小时,
      b.成本金额 月度累计成本,
      b.飞行小时 月度累计飞行小时
from (
select
      gjahr 年份,
      sum(res_dmbtr)/10000 成本金额,
      sum(distinct fh) 飞行小时
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di_history
where interval_date = 'yearly'
  and gjahr < '2021'
  and bukrs = 'EX01'
  ${if(jx == '机群',"and model = 'fleet'","and model = 'model'")}
  ${if(jx == '机群',"","and model_msg = '" + jx + "'")}
  and analysis_description not in ('飞机成本-飞机改装-适航类','飞机成本-飞机改装-运行改善类','过渡检成本','飞机机身成本','发动机机身成本','航材处置成本','大部件租赁成本')
  ${if(or(len(cb)==0,cb="全选"),"","and analysis_description in ('" + cb + "')")}
  and left(analysis_num,2) = 'F0'
group by gjahr
) a
left join (
select
      gjahr 年份,
      sum(res_dmbtr)/10000 成本金额,
      sum(distinct fh) 飞行小时
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di_history
where interval_date = 'monthly'
  and gjahr < '2021'
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and bukrs = 'EX01'
  ${if(jx == '机群',"and model = 'fleet'","and model = 'model'")}
  ${if(jx == '机群',"","and model_msg = '" + jx + "'")}
  and analysis_description not in ('飞机成本-飞机改装-适航类','飞机成本-飞机改装-运行改善类','过渡检成本','飞机机身成本','发动机机身成本','航材处置成本','大部件租赁成本')
  ${if(or(len(cb)==0,cb="全选"),"","and analysis_description in ('" + cb + "')")}
  and left(analysis_num,2) = 'F0'
group by gjahr
) b on a.年份 = b.年份
order by 1
]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="维修成本结构拆分优化2" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="jx"/>
<O>
<![CDATA[]]></O>
</Parameter>
<Parameter>
<Attributes name="cb"/>
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
      t.*
from (
select
      gjahr 年份,
      analysis_description 成本结构项,
      sum(res_dmbtr)/10000 成本金额
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di
where interval_date = 'monthly'
  and gjahr > '2020'
  and gjahr <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%Y')
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and bukrs = 'EX01'
  ${if(jx == '机群',"and model = 'fleet'","and model = 'model'")}
  ${if(jx == '机群',"","and model_msg = '" + jx + "'")}
  and left(analysis_num,2) = 'F0'
group by gjahr,analysis_description
union all
select
      gjahr 年份,
      analysis_description 成本结构项,
      sum(res_dmbtr)/10000 成本金额
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di_history
where interval_date = 'monthly'
  and gjahr < '2021'
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and bukrs = 'EX01'
  ${if(jx == '机群',"and model = 'fleet'","and model = 'model'")}
  ${if(jx == '机群',"","and model_msg = '" + jx + "'")}
  and left(analysis_num,2) = 'F0'
group by gjahr,analysis_description
union all 
select 
      a.年份,'架次',sum(b.架次) 架次
from (
select distinct substr(ac_op_date,1,4) 年份 
from  dim_sh_aircraft_info_df
where status_name = '运行'
  and substr(ac_op_date,1,10) < date_format(date_sub(curdate(),interval 9 day),'%Y-%m-%d')
) a
left join (
select 
      substr(ac_op_date,1,4) 年份,
      count(*) 架次
from dim_sh_aircraft_info_df 
where 1=1 
  and status_name = '运行'
  and substr(ac_op_date,1,10) < date_format(date_sub(curdate(),interval 9 day),'%Y-%m-%d')
  ${if(jx == '机群',"","and mp_ac_type = '" + jx + "'")}
group by substr(ac_op_date,1,4)
) b on a.年份>=b.年份
where b.年份 is not null
  and a.年份 > 2016
group by a.年份
) t
where 1 = 1
  and 成本结构项 not in ('飞机成本-飞机改装-适航类','飞机成本-飞机改装-运行改善类','过渡检成本','飞机机身成本','发动机机身成本','航材处置成本','大部件租赁成本')
  ${if(or(len(cb)==0,cb="全选"),"","and 成本结构项 in ('架次','" + cb + "')")}
order by case when 成本结构项="架次" then 1
              when 成本结构项="发动机循环成本" then 2
               when 成本结构项="飞机机身成本" then 3
                when 成本结构项="周转件成本-维修" then 4
                 when 成本结构项="飞机运营定检" then 5
                  when 成本结构项="飞机日常维修成本" then 6
                   when 成本结构项="过渡检成本" then 7
                    when 成本结构项="周转件成本-折旧" then 8
                     when 成本结构项="发动机机身成本" then 9
                      when 成本结构项="航材处置成本" then 10
                       when 成本结构项="大部件维修成本" then 11
                        when 成本结构项="工具成本" then 12
                         when 成本结构项="技术服务费" then 13
                          when 成本结构项="周转件成本-租赁" then 14
                           when 成本结构项="飞机成本-飞机改装-适航类" then 15
                            when 成本结构项="发动机小修成本" then 16
                             when 成本结构项="飞机成本-飞机改装-运行改善类" then 17
                              else 18 
                               end,1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="飞行小时与维修成本" class="com.fr.data.impl.DBTableData">
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
<![CDATA[select * from (
select
      gjahr 年份,
      '机群' 机型,
      sum(res_dmbtr)/10000 维修成本万元,
      sum(fh) 飞行小时,
      sum(res_dmbtr)/sum(fh) 小时成本
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di
where interval_date = 'monthly'
  and gjahr > '2020'
  and gjahr <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%Y')
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and model = 'fleet'
  and bukrs = 'EX01'
  and analysis_description = '运营成本'
group by gjahr
union all
select 
      gjahr 年份,
      model_msg 机型,
      sum(res_dmbtr)/10000 维修成本万元,
      sum(fh) 飞行小时,
      sum(res_dmbtr)/sum(fh) 小时成本
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di
where interval_date = 'monthly'
  and gjahr > '2020'
  and gjahr <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%Y')
  and interval_msg <= DATE_FORMAT(date_sub(date_sub(curdate(),interval 9 day),interval 1 month), '%m')
  and model = 'model'
  and bukrs = 'EX01'
  and analysis_description = '运营成本'
group by gjahr
union all
select
      gjahr 年份,
      '机群' 机型,
      res_dmbtr/10000 维修成本万元,
      fh 飞行小时,
      res_fh_cost 小时成本
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di_history
where interval_date = 'yearly'
  and gjahr < '2021'
  and model = 'fleet'
  and bukrs = 'EX01'
  and analysis_description = '运营成本'
union all
select 
      gjahr 年份,
      model_msg 机型,
      res_dmbtr/10000 维修成本万元,
      fh 飞行小时,
      res_fh_cost 小时成本
from dws_sh_me_ef_fc_ac_doc_rec_dtl_di_history
where interval_date = 'yearly'
  and gjahr < '2021'
  and model = 'model'
  and bukrs = 'EX01'
  and analysis_description = '运营成本'
) a
where 1=1
  and a.机型 = '${jx}'
order by 2,1]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
</TableDataMap>
<FormMobileAttr>
<FormMobileAttr refresh="false" isUseHTML="false" isMobileOnly="true" isAdaptivePropertyAutoMatch="true" appearRefresh="false" promptWhenLeaveWithoutSubmit="false" allowDoubleClickOrZoom="false"/>
</FormMobileAttr>
<Parameters>
<Parameter>
<Attributes name="p1"/>
<O>
<![CDATA[2]]></O>
</Parameter>
<Parameter>
<Attributes name="p2"/>
<O>
<![CDATA[2]]></O>
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
<Margin top="0" left="1" bottom="0" right="0"/>
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
<WidgetID widgetID="0aae5e55-9300-41d4-94fd-f9d47bb1e43f"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="2" color="-723724" borderRadius="10" type="1" borderStyle="0"/>
<WidgetTitle>
<O>
<![CDATA[=\"  \" + $jx + \"单机维修小时成本(不含发动机成本)\"]]></O>
<FRFont name="微软雅黑" style="0" size="80" foreground="-15386770"/>
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
<![CDATA[1152000,637800,781800,637800,1080000,432000,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[1440000,1440000,1440000,1440000,1440000,1440000,1440000,720000,720000,720000,1440000,720000,1440000,720000,720000,576000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="12" s="0">
<O>
<![CDATA[  * 点击指标字段名可实现该列降序排序]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="0" cs="4" s="1">
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
<![CDATA[/数字化平台/HZW/1_Dev/成本看板/20210729-机务维修成本明细清单.frm]]></ReportletName>
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
<C c="0" r="1" cs="2" rs="3" s="2">
<O>
<![CDATA[机型]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" cs="2" rs="3" s="2">
<O>
<![CDATA[机号]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" cs="2" rs="3" s="2">
<O>
<![CDATA[机龄\\n（年）]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="动态参数1">
<JavaScript class="com.fr.js.ParameterJavaScript">
<Parameters>
<Parameter>
<Attributes name="asc"/>
<O>
<![CDATA[E5]]></O>
</Parameter>
</Parameters>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="6" r="1" cs="3" rs="3" s="2">
<O>
<![CDATA[司龄\\n（年）]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="动态参数1">
<JavaScript class="com.fr.js.ParameterJavaScript">
<Parameters>
<Parameter>
<Attributes name="asc"/>
<O>
<![CDATA[G5]]></O>
</Parameter>
</Parameters>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="9" r="1" cs="3" rs="3" s="2">
<O>
<![CDATA[机务\\n运营成本\\n（万元）]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="动态参数1">
<JavaScript class="com.fr.js.ParameterJavaScript">
<Parameters>
<Parameter>
<Attributes name="asc"/>
<O>
<![CDATA[J5]]></O>
</Parameter>
</Parameters>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="12" r="1" cs="3" rs="3" s="3">
<O>
<![CDATA[维修\\n小时成本\\n（元/小时）]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="动态参数1">
<JavaScript class="com.fr.js.ParameterJavaScript">
<Parameters>
<Parameter>
<Attributes name="asc"/>
<O>
<![CDATA[M5]]></O>
</Parameter>
</Parameters>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="15" r="1" s="4">
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
<![CDATA[∑单机维修成本/∑单机飞行小时]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="15" r="2" s="5">
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
<![CDATA[∑单机维修成本/∑单机飞行小时]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="15" r="3" s="6">
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
<![CDATA[∑单机维修成本/∑单机飞行小时]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="0" r="4" cs="2" s="7">
<O t="DSColumn">
<Attributes dsName="单机成本" columnName="机型"/>
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
<![CDATA[Q41 = MAX(Q41[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0" order="2">
<SortFormula>
<![CDATA[eval($asc)]]></SortFormula>
</Expand>
</C>
<C c="2" r="4" cs="2" s="8">
<O t="DSColumn">
<Attributes dsName="单机成本" columnName="机号"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters>
<Parameter>
<Attributes name="aircraft"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=$$$]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="600" height="400"/>
<ReportletName showPI="true">
<![CDATA[/数字化平台/HZW/1_Dev/成本看板/20210819_机务维修成本_机号单机成本结构项.frm]]></ReportletName>
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
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[Q41 = MAX(Q41[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="4" r="4" cs="2" s="9">
<O t="DSColumn">
<Attributes dsName="单机成本" columnName="机龄"/>
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
<![CDATA[Q41 = MAX(Q41[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="6" r="4" cs="3" s="9">
<O t="DSColumn">
<Attributes dsName="单机成本" columnName="司龄"/>
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
<![CDATA[Q41 = MAX(Q41[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="9" r="4" cs="3" s="9">
<O t="DSColumn">
<Attributes dsName="单机成本" columnName="维修成本万元"/>
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
<![CDATA[Q41 = MAX(Q41[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="12" r="4" cs="4" s="9">
<O t="DSColumn">
<Attributes dsName="单机成本" columnName="小时成本"/>
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
<![CDATA[Q41 = MAX(Q41[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="0" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="5" s="10">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="5" s="10">
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
<FRFont name="微软雅黑" style="0" size="80" foreground="-13732426"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-13732426"/>
<Background name="ColorBackground" color="-2167817"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-2167817"/>
<Border>
<Top style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-2167817"/>
<Border>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-2167817"/>
<Border>
<Bottom style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border>
<Top color="-855310"/>
<Bottom style="1" color="-855310"/>
<Left color="-855310"/>
<Right color="-855310"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770" underline="1"/>
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
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
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
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<f4BPLm6d:T`_,<N76&"O^Hc)$Fq'#U-<;;41Ta;$`tRMMOllA4T7o,"A@TMD>L$.KUe$+s
LN[RL#$1,!m9"&-ISGKIJ))+8"@C;pFLqo@FKH\`S1;c'+^3pY+q]Af=TU??XeM(ZC<^mdEGB
Mq./(-/Xp!/q.)PIP>A(#s6&RFGNMh3d@Yea(qFe<GMC$a"t8BJm<tFdPs^#q<M/lOH'F"ej
Sp(8keN*kRLedmI<rrPSi[>>]Ata-EGh0:nnWe?S"W#Ef^0Pq'nsuu#%[1DG^Ktfj7sfl8kk/
2Oc1=(II^`d7L:VAWcR>SI+'dZ$bb0q2`.cB79_sr*SO-gQo@a<^&^hoC'9\48LeThs47ngg
,Z'2ElaF'OjI@J@]AP^pZ?9g:?gH"Mi@Ya^r[m7Z*i]AY<F+Z*qF5egC6O^'0PAn.U$1:"4ZTS
]AoD^n.V^A?hQj$:oTs%0r"d+cbGE3GmWR&&1:h`^d,`kS;TJL:i.FP>o&lN?dQ<?gQ3]A:c"7
!%36YEHkWA<Zp1LOhM?!HH*t"I`(GqH5!&AV0%`bLQ\,M/S$e_Cm=MH6RcG.cp$-G6YP6rLk
gUP8g]A`QEGEP/@i[p-4b"cTg?<X'IEf_o\k"Ig!eng<>/TD*.R4t!G_h5L;j2)_'l#(jRG%1
Bu!X=cL61BuCTt]AlBD`lI>?dq-_hPT:Pe6m62T<JTJBJ%6=RKjW\5a<'3%V9!t-D0(AI`q4q
S=/ZWY$44GFSPQLP-j7\F`L&_%q2MXof2+j(YKUA4abdp'[jCjZoDna*?qD.5*>#9Pkbl&[u
D?@>VB;)]A'0X8Mpn<-qQQ5h^$%pX1S%f.Zdb`q@'HibVu.re=9"hkk01]A\cI-\a#:XcBpBX<
em+-@1X:&\^c<oHR8I5Q->*8=("nF\q3Ic-bR?;7`iU`3dB5S+&'OlpU)Hs1gH%jjOD!EXqc
FfIcJX(&/0%#Ko?'OnNeFH/gcOHef)st0^O)nfU*JD`r1CC<8*a\+cXC`f/L<u:qcP-ai\f'
Q7;[D]A::Y%2GAX0?Ha<@V%?EEQuH9c!HR9,lrNGH7ce0,Uf<?'$ogrqU51l(-^4F0a=#.^-@
6!/)[L[s%Yb00PC6;n)<<U:WWhc6pYO0?:[g8YT0KED/:eP`0A'+D<>"QKq#jdq7<$]Am'KW+
-DuVnSLMMG8(,ge<[;AdDNk\mM8T>cZ1t,ThKB$?Kf#ENH+KMCu9hMV'b4X"a<Q`71,Z'c3P
;b+s\[<lCb6m4%d+rI5^PC0C:fVBW4I817#0kA>;EV=;3Os1hA/U^d%Ilkgg[OUa+F]A^IToP
!45npq,C$O->XF49uj0m22HPbm5[9%FoYDY!4QLE;L.(E14Gu@d8]Asj@tpp*kFa@_d'o-:=F
s0@+RYU[sOgWl<>a<@O_$8bS-58PIUmoVN:d![9F2l;jTI$REF).A"e`3Wh[6"AI<M8mFj-:
6!mWlNj@VkB@jVjTpfc38+<tl]A5A5O33;I-X0"\4Tj3t%`1t$S4tgqkF\8^+\p$[@4bY%\e5
Y\2I+msjqn[8Td5):;QMk3HP`N#fn5e&fY%j<j<&m$O_X#W@BL!!p6;s$V_7\%1Sn?`X;01o
D_:]A=UJS!B7(WkCn)KTKDA&8$4Q$u58)W=@3GAi`_kFV(^mbk<=*@OFeE-L<AoXe\:ceLo[g
[bg8Y0Q)MgbJOU16stFoltlaU-^Z2'8!YofUm`i@CF<o\+i(K?+p._WiP>!ZBtaVV+3YmggM
"7GGbiUj?eLq&WLAe#QV>!P<#^kL!j*>>'b^G^s%"0),8%C>#Pf'<_!-&Dc6oDF_W,7^SU6g
9L``"6Ed+(ML&fjs(RN4p?EfcDW@%)9-jK3Sn:R%>sT0HK#kYMo^f&3QQi?aEkb=#S1lugij
`]A$Vl`c<mQVL#S[bXV:-D>?Jt5*uTMcaV)o%*`X7emg2!sGLM63TDnd.&.n@\Ipjj_bW[[8Q
:n8M=I6ICr)FZ0/;e##9,X7>=9.+)>!QH,=CR2^ooU9lcEW[JD-CqThN4m1TQRC+5Z(MqXKB
!q9#EU)'P(E=TF,9&%7`(cE;TaL>J:iR(^[*c0!+_R%F-G,$/cR[s0\Tq:@Z!5d9jG]AGIqDe
mcC)]AlFXAnP_>S5'S;+"[\:;fmHU:H,_dY_lSZ;[B`FT*`(jj;-",^qrqJg\/R'O=UcYQTUJ
`@4H-pEq^DQj@8H29EM^2EXbqHrS%;7R]Akr&t%F3pfS93;^7Oq=5.pd'bXriDA6qKa6r5_<2
lE>Pnf#qUTic^q?*$\'k)p]A;9ERNK<h$q'B"Rs69\^\fG<s:H)-jrOcNSHjiGDY);fFgCurR
0D/Ras6Oi&^C8+i81olo`QtO!#Ip6p<&jKWZ5n*59JlJ.k7i/>VYG"]A$0_]A^+r49u'R!J#&l
+X&kRFJR;_?L.#YOCi6'3W;fFuGUqU;[^Df6.Klp8)"+A3Nj?YS'0_1@+Z,XHCLMS`VP_i>i
_^oB9/afFEh0gG#.4DO[rKO:_$Vr6tPCW^W$_\]AZJA:D4SH!'c<IAFi4CAN')<[$pUS]Ao>ML
r990*>EpYsB%ZZ1<S9_H0gC3W9Ven'*#XV<T@ApCqR-<S>B'URXLlZ.H>LK=JQipsL@lMoT,
F_>Y#;c,Vg]AWGa2Z2WcZl"c[B!eb-3GSJ12fsM#h/Yb;J:>Vdfn@$-`)I?;Lpql3Zi8K+m^0
<;*7eE+F]A%()lH<2[pIL&g,"V\6_c)OYE:.5AfFsKPQb>/f(mj,8*m9#O9`FkoqE*`/(=od:
%O3IZhiKY5d[hPE/N@-/\M":]AK5ToMh>s%?dD1i`E1gR9;`YsOj,X'#BReF[h;5.nf_f!k;-
<P?&"'1$u\02UYZ;I_HIN8FObr%eHO"cp):=+>Gb%]A+YKn5G5j8T358MgdUPni$/Rk`j-u[s
Wl3e=G$7FYK'CGnMRe/\8'-W5Z3[T!3R6bAl24d!PlGeJ<a7de%`M:"EplTFW$-iRpI/L:-/
;AB*q!eW]A4)]AT@X.-j-%jJ4U,)&m.tb.0P\5*sSSO/3[pWsH]A,hI9Q_K'N]AIaBjoC2P51'`U
fMGV\H*N4C*ceokj"g&bgh9<"`'<.^WfZ/Y8if[6,E*c5$]A\0iD%p+/>LQ[ebb#gqYa#]AXl:
V^k'-&O<_AX)Z_+WYq#3HT8PN@><$o\#-EgNBo\4/QEF+g\4GSDa(GEMDZo&Tmg!0a=,$=qW
-IX:gIJCYK_doQ*f8GZ?:nF"DZM13:pkVD^Km1CZ@fG+fuu%Nk5e>Af(.YgIX6Y7E0G9[(O-
IW1G\)eKI5_Bo=;XUNsOS4%GdFT'8@Y/L2)Z4\ts9,;!NE`s2O%hp6[A<HWB=L^d97TR<c$L
3Z?90&U_bj#peEnQ8&[M-kJ;)X#r<ZCtfEA#7H/8EY.!nA/C%3[9J,`>a=B6KGZ&hCpp0<@u
(_^^llW%9Wp*Q)At4tdVoS)hZ48Vitk:B3;Zh?;iM/^)4;PNg[a7b^a(Mblfi71uD)@@+hTI
GtQ!IBBgq5:6an8o(12c#OM^@t$:2DtaGcT!%@:V[ESSKK_;&:SeQV/X\7Q6s89U#Y:g=`l`
K$qUTBS!K.crNV/m8.@Q!Kn_lCC8R=[&rf'&+FLIMDV,M^*N_c29'KZb`?/HK*dPU)24;Cn]A
[iD,2`l#=F6&ZM&js_0K6rO__&&8/;dVSsh$eYj@M8!WLS3=R7NuO+-2H\-:`S1Oe4277@p;
?5Q[K/V2__7S!(tU$RlLs[-6;=RgKoZq(I<HlA@8dKFjfI60!=^q83?+iKpRL0d@p&2NdWBi
g#cmS'jF_Of#aq!MV?LTYr5ouA-u&HqEBB.@&Drhr@>Z6^ZlC!8$K[<9qO705Gl-d$ir_bGn
9DX**7m!795Vh;8d`p'DMN'&/XT=M9)?X3QL8f8,<W(d664e>ab@jb]AOt1]A6>26J1$'(3o4m
#*=2'l&HMQDd2(W>Ce+2kBZkf(62m^2q\(1#Hmpgb14jT>YD_VKmW>^)QCY?dNgYI^!DX1.g
_fPQQCmS]A=]A9q>]A[S"MXeJ]A1'h'S8Sb%I2`CuK03b3[/AmcR<u/ig7,@SK!;Dp(O2NKQ8)'u
6cU@i!K%_I9M/e-D)(HfsS2P%&[q9c8Zsp:`kPE1>SCVt#(.FHct9Nie68L5^"5K*VaN+]Ap`
82+"j+`gU0[3mGWt6r$B0CsYAr*!WkmeL(u3<aiZ9->QfgH+QeqG(#Bp6PB[%#SJl[q:0`a>
,<2[M&1Q15o4-PB,r8;d<\"t*t+6*j2$LhVcFt[;aBQ`h^97iWQR:AM;C;]AB-D_38Tnt^hs\
U>L!^i<X&aPRa0EC-1Y=cKE5P?86P&pWe4a)n[SM:q_909E(uTF]AXL$1.#r\#c/,8(EU0oE4
.VINB$+"K,MT!e5gfP[sq"o*QJM60Z-6XVoVKXo^Q'43I"8acdX^>SX'FAq&+#/E_=-q1M,M
a<[a4#D]AnU3mMS/6"_M6i_#I0IPoXtoa8B8@@_%>&A&@SLKs[S^<o-+4ToL)WiPGkQ@&1f:@
gbT4.7j*;XAHhAoXFm&]AJ:#!a,H=r;f"2:1X^."u=J$2DUpesNcGu_QO$(oOR=pJY=jp3NTV
BtDqO'1EERiS#JiHfSt:,hQ*RV@7O;C\ZZ0Y$R<&+r\d:`;*!m+RG@8]ACK+'gZF>`kue"&C)
pl$]AQ=l.ed$gKF0rIRno!7HUgR()sK<drEQ#k.^cR-o;8?F8g7!ECqj/Ir7`bc(Y)-OhtD*D
+$dsJO7LP"W)gP!1l$$"U5D*c@o&YA:hsTe`X&8Dnkt0;M/bJ2]ADR<m[hpbb+Z0r)`eq&qU7
*IQ6;QGp(%#fn<XsIJMV9j>)BIM/YNFU<V$6'9grgbD0BS8]Ai:j]A3]AR.9@,IH>N-=`n3gM4,
8*]AVM^b\!1la$f#cH$OiU6Ll+W'9@2Kog:/*=P"*VrZ&,SUDPB%j\PJ&&i!"mB4R5I'"S.@7
@JU%h\nN3BRUX=G?3EgSpc/.-V6bgCunL/;3$WQH@TIt^QKl0mFQkTQ''U[?=/s9<]A20*1f<
[bM,,W77KY'X6f,F`Gm)%rl4;+m]ArYgnm;<cG-I_kXM;cS#\d1*P=4EUR4EJ>-j%CsI$$U)2
A)+6Ja6>O^Q6tlIjHqH.,:/3#L!H1";W\=-d'Dgk7&iO%]A%%TO\r.)1L\S\Sa?_,LMBQSglk
<lROlC'ZC<sI6,;[pP`H+%iEnW^LaR!@oD(RJ6IqF]A.k8u2<ems5\14O&13JNA:je/u&0;[D
?)'PeQc$\*=(.rfJ'mbG4>qFLC+EtX7&I]A;p>/kP^8a434Rgt;'l=+<C6:eM[Oj_I[md<<s#
u]AI1hJ!Om[bP@?XM'?/2c4or44WE@,]A#PGmrVk"VZRsk]A-FI_SVt!L$-bilfLui]A:Xd0pUb#
BDGL[padG6Y%eIuFq(B%L?$gNpO@U`Y?'YM;LGFO&aSM<6%L1At/[[?.GQ!n_1(p-hqQ$&1!
(JMZ]AMp&T&<&r>!N\dSObG@Z;(F%HXrM8QAjMDYhdCRrBd:0CKBfFqBlQW3U\^Zlp*qo8"(>
M41i9>gE:VjrO$[Y?[%u+qtr<KAJ;%-Nb[-;8Dm6/u(8IX3qQD$]AD.Z%&lKrPWqJO8S1)<E;
?r]AGo_grISbKo'Z-o:=GE246J+KgQf=%7H^`,?Co[na7&$_kcm-:,$-^;i^g!d^BCK;[WQao
/K($."bDjHV-;=94/*81SDqA'9h8[c[Cttji_U0>f'`P5r-Y!AikKXQbQ'/AQF#NX7)c>DW[
LL_Vjf]Adj8SXHjCUjVrJY2n5[=_f-s^CjXBBse>=DV#UKAOc&.MC-@-^82ldOHBd@EXkB]AFq
1pj@9QOtK?R>CE910Jo8j)m+NDFW[!37=ipI-ZWkMLo3&770o=a00o6E<V#37`!arKh?;3qe
>3JA,^Gji6&W82Q<R8BN8eG6HJS$B(kj0#$PME#[q13T(7>-+bO4MK6"!5mRa_%*0i'ZMqY.
Wd(IVU=)8-ULPH)EN0S:qA.6k[Aj`5Djc0,b?3_updkM&n/0Ntr$4`:#)_P3Y(sl$+I^=-n^
Wn[`SWJN]ArbV-OYG:F.(6G*$eS@r!2M[kfb?l5?X07P[jNKdFkf.L/-0YuM;U$CiUZps%UlR
]AKU1*_hJUQKgJm*Wj3N/N)T4IGU/,pt]Ai7?!=34m%VI(8)B&ZZT*9iXACanE,N@-Ou<+40lK
)&]A/IC$:h>;-TO*h;pMM^8*k-(q$^-o=oQ/WSbBRcO&`%]A`k*ofWH<gAkoJi_`<$7*<3\6ZD
l9J^Nbf5VKZcSYS<RjRoAWHT#kNGb.+[o=^W;Zr)ielSSVZlMk$g0,#.2Uqs-sT2E#[BG8+R
_MO**1:<<:"'W^231Zr!]A]AB+kSJ&oU6CJZ<QKSm+]A8`'4JD![rs0T!hF@,lkbJmuUGUdSZ.[
,%;d:-T!)m\NO%@(-f?Yu]AA7o$eiZ@d?2?8n:hC@-D#5K*`'"F#-c;=S>aDHFp^QXSlu&#di
Z%rcCH)jUTqKag+["UfDj'^*pI=SjDtr1<s78'/YQXJq'#Bjj82.0elpo2<k%oK0PQFI3*C"
A[b\*$%B44ZC@.\1$:9;7B+\p7r*=a'QNoiJ>6&.L@_s]AG4):Ymc/do0+H-e]ANSU*hN7hWmZ
Y[_L(N79rRT0^<J"\BCj]ARAEiMe!d11BcIQ5`SYp%6$=L:H,eh5(e***b;L-)MOX1X_4hu#R
T!UTIZ*5WK[jJ5ED67s&0m9&/XTNceaFZ,NK]AZsQ'Bq5OT2MG\6Y%0*33Ob-al3pKGa[P#@6
PL(7"VZlS=XHL)k_f9(dC<&-'C88S?:cR8VQ"3Lkp,oC>#SEj^Z6_o5D,jLJB>q*!b>$hY(@
L^@Vkr#A*Za)'P>Q6-:tYVZR:XA69AAPmbSH,_;C!IAR@p]AUj56?mGad&T`F<R:=00+X'.+e
A,Icg(T6^oMfd7fq=Lm.LCMNEWKqfs=OcT`kDsYE3fNY!dPu9ha2Hgd<2C)/H8Ctc[tV`u8h
OF>G-\M[T`->tBbU:u+.Su3\[+*'55um3o[MS07W]A\eoM!L?$u>Mh/UP]AZA:+"+maXdPT`0@
k+1X'oX,pKCpBA@\YL+pKj80*J"/>BqL2]ARb=',Q96F5(S1bpH9+RCVYj_J4*5G-"9B@A23k
QQ#.(-A-jD$[sNFrS\Fk!TIBqH4=62k<_M>NZl<pU$lq#YDSQk47jBf.c@:]A@>N9l^9gJoD4
Q^rfc[(?j[Y`^C%;nTssAj]A\9uc>m2U>2N\-W,$S<5XXh"+$3)&]A#k=:pOs91OK8*CnlgEP_
$DlkkUJ;.Ob4`\$fmP:EQ+kZ*]A>]AU^ntI>)iBtRs,!(_J7(pe*q"&.PPm%s)W2nS4OQ)q1A8
WBX>Q</Do0)0&G>`O(.68qK=eATLkLB3`bHpagcu>e]A63j3Lq9Mt8XJ9:!jcn*rVBQT.T%pq
+45+1m77[D`k1M_f9`'Nu^P7L,QLH:7H"bZ!iM3'M?A%B8pFN#X2K_$t-8#_-XElEagYdO6G
qPO+n>WJ?@s5FdfiX%tI9a2Ff^H/ef]A;]A?hg5SgUA.L@2n.Y]A1t::+/BQ*T$VdH3NU:ReX3"
&*D>r&&?OjIbZ_aVAJ_SrC7[CfFU@uIUYKc;1XRe2NVQ1]Aqe?pse5K'=tO6aupckR_qo7SbD
ob6pdY`>:[D7s1)*UEImf[EsrT"Y(89^X\8=q:(h9SWL69Dmf=U2V'+?k`o?f.#%+nS+K//B
pt5-dW5pbHR*TZcRSbT*7KmF&Wlnq#/:dQ!l;UGJ?#WmClk=O.;ZUhf$O0_#EchSm@AUM,^p
m-D:^oJ%6a<dC(QM"=nq!A[m8I3@pKem.7R.Ebp`M:=:J(3Zjrqah6Gk5\+hkd<jF@<FI.Sg
c\crFtraBpKs[ep21JlLA@l*A\003'Y0Z-MP?3Vr-lK,M]A2_Pj;L#hSgiE4m9P*JYPlbG($,
'?gMWA"&c,`>K%h!UCc>Rd/Zn,%oqecHQt5""P+7h_qRO,V$tJBV')V7n1_0Z2,_l&\?2e'^
n8.0=cbi77ddmQN$cYZ\X:!a7(CeW3PE[NMh>;H163dkWX1!NGlb%KZI>EfaV[Ik2%kNJq4.
/-<8\O`@C9^l3<G(UR1-uf"%/Qh&OXK9CJ`p[6;)9-U4T-H]AO&gX)`Bm:34835B-8?hYJjSR
pjMs/m%Q4nX1@dI#2CV4(M-:^u`B:7Hag/ND7eGY'BiOK9]APQigmN]A.56QnETde83;p+oo^l
[X&;UTXLfLQ7tl*0TIFF)N'.=:phE38]AtCX(=Wf8oqsj=PV8"e<!i)(c<b&_[-2.gd,h7rnH
ub(-C"7f=:q&Y=osrJaMgK"0MLtqW+s&Ogi_FPl'!NV(UYjYi*McA[gh-iId>'0RT.Nil\a:
buAuR>81T!UjM0srm#t&brZ%oYX6Y*HEdpuk'6C#2@4#DO.9Hd2I0iQcVRtO1:F-0_7gY;Uk
'9HB9f]A;`k<#J)=H%\r9>J8#6r?f4:;K*[mNXu'<-5Kh>^=_H3QP*4+-C4GLntee]AHFP?b,,
6e%qucjMqcf?b;S8dQ)la2La*7`463E.P'(oZ=lgE;Mf&/Mhp6U<^r6sqN#P`<.CFeBhCqDE
j*EE7rF[aDi.2F)#f,V2pF4Jj25U<kiWd)4*st"gQXtj_mZ[[lqG@Y*r-?2hJ:66.UdqD`EN
tR/Lk;57hmu<9'C$)ma8a\5F@K6RP_QXPA(oM)/MSk=gI,9acVS'ro^R<-o8Wk)3u*NeA3@Q
W8-)gfT7*VC19[#qQV6#V^L`7^XZqH"p\Zs>1Ogbn5o#q'B00e&E29ure#8;m_lcPL[:[q:t
=!(e^bbPc"8^KE=Xji`6%Gp[P3B/\XGdILc*?.S=^CV_4`2-"=IqhSBJ_UX+s5FOi5SN5"1L
tU-WWu(U)=;'tToWo&POe*R#h.Z=giDlO6B_g28i@7+P\dY\uN,3EB9cDclFdkA**I*s/T1o
-*.'7`C^?e6AfWFPMr9Or%WAdg$#c]A2D)1DDm,Y4h<Q$g^.>@Ol+V[pKC<Ym7Q(QCn@fkHk_
]A%HSRb,EW5UgL.'.Y"ACBnPSf;Ejj,Z9E0U2j\ZD/,b;0,Q]A4j&;Am<$MBXTq77^GP)A5Qa+
X7.hCC49WjjS8N36Wg[K,h+/,iB<q]A!s>F5,Z:Lirp4Gq$%mqZf$H,HW&_pnEd]AdnjCflcNp
fYR[\+V&3B>ckoNR7'+o\S"(Pf<CBp9:IQL!jTVo#0/;:bq!5=JBE,n":\XOL!RATt-P=LtW
;=,7N)S%,U>F4h.BRA]ANO`AuAE<n;YF2c`MT;ddE=QG?17UCYWe@b?*#S!]A5=crQ43<bLhb+
/bZ7Lf88jo/<("OdrR[3$7I$D@:SjN[r"g`J&1-L$&9#Wna^QhePqR6"`&tYoDTb1O+=Of[5
GL]A_&u>a81mJRpFb[)$5I#(M<#GBV(ukGZKS:Vd:Cn7;3E`Y?B0i<E-PpG2>JjQ\dZVR2@A#
ki,_,:Af995PebhYDD94=i7K=KlCk0Y#VgG[k)2Ep&;2bEFXRmdCWJf+#Qh5=s7W`C/Wd;`p
2XLeQG<Fe>CG7U8"m8/QP-"?DpBGOdXG;Ci=a*;u/>o(SdFQD4PZ@)7=>G:,cu-(6I-"`7Au
gG77RDA<'hrd&*\MRd#S(<&71rpIFNV1c_<sZT[9[G%6esG?+*>j0GnUl5$7f,aVl'oEKWWb
UV.aZ_o_/VqWY)Rk!)I9Fk$mMd9RIJ@Z)kpe!FoloGc]A)biko%maJ8%I8?p"Ghf_eBpH!LAd
+pBkU&2VcstWaYV+TCi%$)Zgedi9sP0>G5HTH`P/jqG<&X&`+h%$"/qhBBN+MqWa&&sG^.,F
ldfTQD>.k27^i83F/Ra%dN$Z07BLmrPEftn5$fWWbrK/0"j,Pc9Ke9JfI`WM?+i+T)qS>pS&
Ym#3[bU_Qenn]Aa2eYlL"X"B;e0V22R!X15-<=`r,FU;-X2@>YF^dq*4X*VFQ"sgDRNu@#.t!
AQ\gIkKFD50_^Z@c?%f@/L-A=]A#^naCR9/*YPg/R3'ib(WkoN@8AHfa,Ha"_X")WV#='dVP"
^Lm\3"(_)Uc/AL.2X\=E+;tiPn7\o[ESZ=D&-Mr4+.gT`-2KNc71sR\Y.<TqhV0,-bd+t)p4
a`jEL9emVQD:+/rD^**-+A^Q8HF@l;RIjqVDaSf,Fu(Xd+$\f[Qdb=W)db'3g9adc<M$&AV\
^b2%s9M,[7S)O#ng3prs^_L-%n_jtkIj=3W>f[9qbMjO\U^-0JBRWoUD'-GD1gp#^T,k>Vc4
.93X]Ag]A\$BsZeqgWm&fB17+1\:]AJTO7!Jaj82ugd6AcXideb7+F1RO$?kWcs"HD6Z%aEE;AV
kqY2'u$eABE6p3o(3EY$llCfnbm-0V.!&*77PPC`sr<i"/_aSs^E]A-njdmOaSJ/bX4C>sJA.
#'?P%slN>QPrMD#FKdqEMUr>U>;>pnE?_"n.tCk['>X3bb*0]A_GboNW"Y>(o5,6:L;kh.Im"
aSS"NFkYKn,cSn^RT'I3t,`sun1`^Ec[H\6Ud3<>Zda26Mq5_cI99AJHA5%JT=Eq_5+SAMZP
-KD="CG[F:/,i*HjbC7K%o!6Qo3093MqeS8j2d*\p1XT@\GF8&&:@gDb-BAT."Tf^!KN?uJf
_g;o]A$uP,B2XMM]AEg8,%Sjm<fckIA`V[g$OKkJgPXg*:UGLm`l?2/0LqKH!7V@M\U`ID'XLp
g9D\'=>(l7o@WYH\<P/f1NTY^RrRm6uf9j":N+'h$N(pDo7?Z.7\j[!2.[UXGSe+h67[\+'4
<%dWRWsEN&n/@rcJN9<LFPu1`B?+5S4SeHoYspt0"KGrds)UWT046EM..:XZs]A;oq6DO98u7
).)<\+l1Ok3oKV;.B.)NUVqn.n\kISbQ\"9gbFW!M6Xlo:uLMd=8&*AnRKd+r@/1.PM2fsrc
(Di,'4bVi&koa+Oa$WoOaA-HhQh=ulDWH[d(bI-r;L0kr*njKS=-:=FcLO@.'h$LQGECUO?r
"XfF8h3f4LGg&j=J2%JItsd3;qNLN9KLg@egM;CS]ABrkfJIUU=OD]A]A&ehSo!:PDLeZi8.P\*
<"Ha2mBMj6=n^cYq=A_IGoN.<I'L$B.B(!&mcGW0"$Z$H$kNRqNkHY6mR->mF&?]ASC+q)4o)
2ZM*NY/_Fk^"Sm3_8VAU&T+DVh1poHi[tD('!sf/r)9I(h,SKJ)kTDM096gnhX`-eW@BJKj?
HWVdohN\6T%RVLKG<MfoQj4)\klbLK^,:]A<g6)W@AF>'U+i>]Ab!9`X1$3K!Fs"n-J%\@^fk5
W<3FfUpQ.[gqfg<-0+KCntgLL?\tF,`BK%+m77_-;QVd5e1Z@$l0#K=Mi1T)R37"8GV9X(V7
pROm)PN,"R^;5s1N^lU),RlWUOHQ'Y&;Ys-g6NQRj-eX_s2)ISo"8^/]A-9jm7*H;[PI%dUXC
ad4dO\<VE>Z:,%*PN@p?YZjVa!_!W7^F?GZQe-M,J=P?k=XB`).a"J_5HnQjI'S1YaV+^0q<
")BsmNAuJ/EWo*roJm4EPWek!ac*'6p7rnYMU^IWVBX24EGHVMXS2a?WsUd.`t]A2K^m<GY$u
"k>Qd*nB##1]AGHL4Hj>?-W)M1T>Q(YCf%\LOmaD(1(5Mt3s:8gl5.1a7+]A-3$f]A^m!)VdY"/
QS*&D`+/K'LC7U:CMb9[(+Es^jOgs+FJYA#m!2UbNQK]AtFqHq:XhS]Al.P-Z6o\'qhcYRf1,0
O2kcoqA;mee%?f7&2PrEQ<-/pC11k;NU5FGj)Ph7DX)[MT2(?'T2e;sJg,!ho%!Tcea-2Znb
l=7]A[!ibS,Bo3@=770<)g5FI_!=(gH@cDC-Z^7FsM_*q#:XmVjE=o\TRH:`0El/!.-VpfP7*
SbrpDs(,)Jgu\h%+&-nGI;6edZ)N+c4q\m?EpoPq=J1r_pk\*9T#K%8M-bQI,j4S@c+I:o>/
nE)i7Y.%rUeC5+p&n7FZ/'l$)!%de8%i!.jF+l`3>.ehPn6Y]AG<Ad^<s>0'&"l"S/8_lW0\?
W,8$8i<>uO25,45C]A4)og"O4?)DBa"f8tqN52&oDIANE>D!Ba*o-5>61N"JpW<n"+rN44,>X
WpNWqkeC#p8Se';^+]Al4T8$*cB3Nhd:Jt*f)7%Kqpi.,Tg*'Q2,@BZO:q%+Ap*SA\,#TeM>X
PYphK@YCC'@[O5jC<bZ)bo3>#P@/Xs7?@ZUT6JT;\E4q#8?.uuoDL9^]ADCW-P__%SKefd*HG
r^8M<Y*DZ]A&,J-QZsUORLJ'+kIo@$'N/aMX5]An_3$\)RbhBQ`U&287o?reCI`bkZ2qVNQn^u
N"_X8-BkgjoU9tOu1k#oHt<@V\qNr9a[nTh1ufBofsPBYn-7R(R6AZgRonTjC`mXqQ-Q.kM7
PTB$:DTSV3NNk)-dW)[Doj\EV+PUEZ\`:EAo\ekQaX.e+QO-3-h8._\hSfE;18jR@^oIC(G$
aXh#3ZU`*r@Wi]AZ&dD+0<A'DYT/mBCqdsj);N.MeD`:!:!Co2jcFWc3/A',4F9I4N/6VB%QH
%orG^8qR7LPG'qmMk#]A=lW1-(i0-?YP]AFFq`Q[R&LH\:fpQ+WPL(S'Xig?27DMENb`,9-Ee%
_`_pH+I$lbp,G:ZrB^D,52p2kPDi282mu`NRXkW5JeW/_Y#"fKiM:3LGQFiWKS:$E]AR$D;5L
Wb/.4ECE,C,!WC&L&qdH?=ag(o>UUn/V?>?b'W.3[F-a-oN3KucF[Oh>.,l:Z(SFH@FG@)9'
ZZPEm;\CI.>efb\<:b7ns#gti*Ye(Yh<!/hff9Ekbtm-sRP"0h`k63q;`ePcSh#?f![,:3^@
fqUj=.mIJ>QFl"l5&cd/f$(J?[Q4CL;,q8<t)Y8CRn:5Yu!7?^o-`?*@/L+M<3\%TnXUP:$o
_!h)GE\b97D%K^K3^a&,boL]A$irr(U5VTgKln8%HSM14gu,+I11o$nb+(d)tWTafq*]AZdSYq
.<=R%9o*MZ'Z#Q]A`+p.*&-$17W;e0=0>p9DDdptIqAsY,.68nV]A!fnaWhhA7Z2P#oL=-Lr'P
]AS0JieV1AGAXJ76cE"[jjl-f'#U[]ASq/Y]A^BqSOYLq&C,7k0Y'M<dt0g5>CW]AAFT(6bWfDIA
*5d,)M*1qHCASMdFGSh*8M36#X1SZ>HoN&4mZ-86)BeFl#If8\r$1X67$k^T]A@*KaD9rTZiV
s[8Jt=0rM(V2#p'$c!6p`-&\Ogfk)3$KTZM"Mt"TFK$c#*k,4$(c4Uje*uJ%`d=?IDOa=Sqs
Yho]A:VG,M+MT`8mIO,VaF+(\1P>l:3tp\Ft)(uSe1%`rTqIJr1oB@DB"$m:+I#sD;b"U!&c(
u?Ktoi\N"]AWX]A0GBR>.HOlWTcGfS.n+-[QJKVM8V"u]AOLXeD"1)Z\8#mS%N+4m^urUU#YXA,
g#$"+cH"BXpk6k=bRRCQa%SoOlc-&<3m]Aa3Kf/d1^VjSHE"Z.Zdc)]AmR/W;"'s#3n44rHN=2
q-(8LAUZ+0=k[-sRaO!E\aJ">r"Aj5rc!BDTI!pQqCSsk4'7Sdd6qYZ$GmR"K/7X(3Mgf=N-
@ebfjp;@-hd3>@Yi;k$`o`maIGl+K6d4e\)+eBWT(`/'/%**[Y/i3dU'.Gb8dhKM>(o?h/Ce
H!uTPf9aK)/_B?6EGtT$s)<MFPgUJX"nK.;0DSPoV^m+[JH7ZdK!o+"SB\GJamM`+[fmfaHf
M\%qb%"s5bPPQhDopMXR5aK^mKcq%PkoC;_oYn=nVnab+_S38J`0Mq%&8Oo]AOX(2C]A.$cnBr
[YQ:es3DjC8q+bZ(M[srl/mm%+<6%VLS1Y8&`]A#t%ue>?grqJ]AP@fh[_-;MX7g:)+*1kJ':g
\^7/6S>Bk)_PYt%!M'&J,WL)<^JK\FrYMb3JtCt=n?"r_eV2\'aaesh0RTe*]ArkqN3P%_&&q
$W8KP3XZd>-^Fk&&<?q*YG0"*V-d7*.%lD1auNEXJb6pm.A>.3qL9ILKm40S3:c+?4_j<HZ(
[n\9P>s5T8c5iN$3pj^7E_qO\KX$>719r749kt[H&iH*jGQf`*4QoG,XN\iD@?>pNn)1L7U1
c!K/oP:\mVcXUg599hZlGMIB:[.au,*3grI6(A`(bB@g_8,W95n/0FqYmt9fQm(om'k7T2e_
Tkf1TlH?"Hr!%L.<5%T$1*".CA3R)10m0'cNIS2\4+LCd&\$aT3%(uFs+R&h^U`rea&mY)=U
KhBu-RKkr_O]At1-@'4@0+4(D,DteemSdp+X>A1gOo7nmA:6jIqS6;FF#;Ks.`S2^8"jgJ#O%
S(I;>kn6[d5qL2_tJQ]A`EiFb7pKG=1]A.D,AOldoK_aO\+^E\J`;+\JRJWDg=R]A.;M*9rP)d=
'Vb4Xb'"T5_aSjldr_96F-2-A[iujf7#uC^OB/#P/rs6pG"*2D2c`]AuK$d_bJcEB0lrMue"9
Fh+d/:TU#rbo!?F+(]A+g@W2jRei^7`a:?MWT#\J4h":A7V_jXq=C4]A.!j4$r0@PrB/ig\o\U
^PmhM#_*;aK=Zhkp(mn\S*k^h?pgPG\X^o*&9o8#HGrf>jLH[e5A5["a'A\O5LhDHbd^T@b5
5d?"io-h\a$k%DCp8Bl>o0$">\)kp8f.$]Ab:@\A_Q0p_I;tD6?rMu@>i#BX>Dl<a0_HpP&pb
MYl'V+T$@'`_$.OQHknpOdfJ*-LoJ[Y(b<GL:NhSLNQ"C<U""lqZ\`gSADKKI?2XhZm&cj79
KZeb7@p(.0&FgD'"*N2!c,;Y]AR3AInR1=+!)H<<Wr&C#U-+5ZVQPfjiWY)1fIq9Yr]A[7Qp,O
!B*qE>e3V;p0+7>g^T:o+d,%r`<LV!VSjO))&&+RshU?8DcR=<7n_Hop#!`"$]A+r^@l;uk"Y
_5p&"<7"^qcjccdkGf,EqS722!LC=qp?S%:g21r&aA)S6fa5`ZCaa#UXHU#r'"2:"Ui8nq#s
%Qu9#k,#'n_"!)q<qZ>J?Eq36g2"JoMo\cPlW,L#Lr^78diaE-9Ql5]AQ-+$Fb\sK:A&j3@jN
V\->Hb_@<mnKR:cXE;48hAK-3Z:j\`M0,[!ZT,8G(aSes4KW]A3]AhI@6u.40o\#<Lqs%]AkIF$
eKft#/M*tG+Hi!_Hrc;i)8^G@CAN:Z&;-S,62ha432+P)EH'6d;=&t0UY<0%'E4o'5^=G1-#
+hOANc5h8@-6p]AAtG>FiUBf<!5_8"l!hgl7k\!RXZEb$n^56#rE8t.:0:Ckd@6Vog6QapPHt
eLQsEl`Xd(#pV@S7WV!_(@%i;0g.+LV2_TQ]A<>@$>njljV'RhaNJ31;38lFV7X2^2"0h#$a\
#m!s1q'\?LU>,6IDohcJ:>&AAo@MAH.c\RMs).knQ9;!3^^:+J8Q/S6>2/M*;r6p#n`F#+=*
si4h.p3)DnPr8$3*laR.7%<BV"ZolZkbXcI7Pr?i\Abo'r"1h%"D0M#n,u^AbuU2Z>n]AOeA%
TUmT,Sb.l6!\O<uZfUV<"0MHsN!A#s:BG"t,-a94?5CkfL-J;iP695Ua^`>M3Ao"g#T"R/5X
1:2d$0Ye['iPB=JJrSsK;l+@%Fj2FCJLnM(*$r`CPgr\'.$b(;":P`4IT%jgPdcQGn%@NXdq
H,jcBDsqB>iS]ANjN%#%Wp(><)!AS#Z]A3*&m^>Ii,'ec"1;MrPT0QiG2S:)Y.GP2ZRb"S.(9@
bPKMT_o_;]AN\&XeP2ubFYPQ?!VF@SMm(W'<6sN^l6+t,h$64eKn\=d$6NljOb:6C'\kuD0BJ
;/ZU;!Hmc'HA_0B*j94'Htf&,rKHh*2F/5bT+3?@PZ(r>U;"FKD'Ie6l$,lAJ.gP`"!6<U;:
M*/7C,Uuj1l.TLfah:6FF1p:"aY/)Xo+gcq(0L_&,5j]AZomssEFZ33J7;LiTbj7XI1<uh\C9
:[B=Oa\d.J="Wua'OGKWJ\h0k(*LV<+uZT-\9b]A5f*1>lg,,i?=96^MgFjjIa$O[*PgS@jR5
>Q"D_qkkQIj/J[Sr:l%%_c-BD%N70;TBpBnYBX`YV;Z3`7uJG(Ll\Uhs0J.@ij[Zd(8K8rm1
[!1N`',igb)%<<S,C2Sl@I6d^KX52o?X80ejSp\"KZZ#^jGSjG0XRfa9Vg3j9<UWj$RfnCPb
A(I$!25)R:Ns8hO27Vp(_7$etX14Cak^#6SPZY9TQ^EG8i(s.VIf3=lg9kB(c.a.<F'dD9Rc
0iVp[pfS$,hcdR:D8pW;d+gf>(1'JVLY/l"n\bcjYIWN5ocn$/?2BQ17S'$-MWOW1I<AS$+W
![>Rd:3"jLZSsSo;[b$(?lrW6kq05!16/pfg<@[]AbSV,.?j_dMH:pO%qmVT.^^ECPS.^'C>,
po&XX?bI8AM&ppYdtG6:NkEs4hC#pcDJ5/@u@5#Ade"7ull;EetpWgj&U1B7[7:3;<R)da:0
Pu8rm$r02OLcWJ.-tt_m*X(tte#I5JCqFRCaE=N(5D)e3^(1+-880G[3,0$o7ISH<ak[rDNE
j7"cm8\Y2T;QqQ:NHK"$',TZ:<J5:h,$mc_"88HD9D(]APNbUEDE-rodUMK;H@QFamK*TY\?C
dfllP-[gJ1:76_7/j;CAdJ3s*/;fp$F^N5nKGudi^EjSR<X]A6qQ.4KZXc#Y-.4P#SGo._K->
OIRQa^-HWk-:j&"Tid72Q.lggcT_;KQVTR65lCef;E.N2E9X+.0k8eRTiJGMT`hqq$Z&1W7T
N>indhQji*uAfn.gbC0=Cu9d*fuef4m9NrW"<roh-!bmbfAl7Hm1g$eH4!,`kG^_c8JV6)l%
;^s^eBb=KU<%7s()qRVZ.Ka&l*FR@T2JqsJDuc7Kd[k+n8^TJ_Y6aOer]AAZ)rt!!h9#uCQP\
3TXdr`XfFr^uN'X!&/K.Sn`?q1E_6HtrUBi]AKnLd$YE+Y6,h)S.<'HM@(U?jZr68JoZ0mj!\
5WJ22a_dr\WkNNj(Y'?$A+R;*:bXEt33a_rW-2\J3`Y&)5?Gh3h>RYF03?ZgZ+r%>3JK[\[q
(&EqCJW>c3X>T;V(g%AMXYs1giV"D3R/fBk#!#Z5&OBsj*#p"+Qo4lc!$1uegPeuar;n*s/R
'?<;gP/VA"&+q]Aa;(;=!RsOG&189t4J1_Z+'N7UUZ`\0n)(0qNbN1I-dq$(*M*anb78^`-);
]A^Q$Z!;q+"Sj0fTolgB^pp'uY$Cuob`EL_[qG@6H.,\,4Q/C`XI1NoWaC3Tc3X1T:!`NDHF3
Bl<1kufs.:(>c>]A/1T*4S=Ro#Nt&-T'-^^_Y9c%)<6k7A&/!ab=+1qfXfNn2ZIQQA8W&n>F&
[V5d4g1]Af]A!T9o;'kc3^%)JifkaGmr?'[(6;XWa0`B:C,uP'j+C!V#Z[/R.8Co%.6Q>RtpDp
>.aH\1T[V&'2-EjmCJrP]A@8D$Lo$^VSl4[%TN!II[N<QW('\$>R`2PL]AM8sPl7IX&ZSl\R#i
M?'((<Re'2<R\5n(sMk-`&$1c'n9&BBuQ*+NLE;k/B-i/(pN5qYAE$KK+^GNXTgG&[1'%&t;
b*J'1r'"Ng!RVUKeN]A;3hfA\;0/oV3K$$M)mt"e/c%&oN)cqnX_VN"\?DWhZ!iRL4/aZPded
GJD)cT@UWLq.phl)hZ"p,[B2#Fg]A?3jh#HKI@3nN]AVu>9G1[!jE$`<hcK1CBi.V"b`3h=[F4
Ek$tlqJ$;!M!#kl1K)"A-kW_bclQqAY"/8b_n2$2IcidkiU.RgH$24Odb$NfRi;*hY6AVR->
QI=^Wt+tT.RsMCV7m;PZ?sq0M']A*L$dcj1'ng:aNBWIIn#]ARIPnYm7>!g;[RoK1#1j&[Nf_o
b5ld*\'hhGE3SE0W+1JgRW+F?hV(9]Abq'@7biWe4@54"6Et-FamMV7;ct![@Pmlm_SA^eS+/
_9@CiLGl"ZHjS.gUWlCWr4Q!;'Nrh-XoQdE<uUs'U@Fjs,P%GP-ipA&+@(E!l0t%>@DBGef'
&n-LUJblVMQ\J4;%SDjFe/L'T9dk,dFX]A'j:F@euQ+8AoOtl7&;B%&Rqt]Ag&EOBBdlf<ZPIr
T-oP)`)E:cj_3BOsZLQJ!df9V)"7ZB`>BAi>`T;p0)^Z:=^?bHrF3adb.o(TLi\]ARa5K1'-/
L&@[<4@VYRjHunE0Z&(j]A^*c9P2[BCcGLi'mH=2QN*Y31gg[tE7k,)4ll\![AqYG:qU7BFP[
fmm9`XH#jS.0fp9Cli.h0Ea5d,+X']AD(q@Ah&:#-*h;?Q]A334[0.4CS$YIZCmjh4]A24#]ASu@
./Q=rpLI!`Ze@0Zq$Lm]AfL9sPoC?H*bP/6`,LiP@g)`6oAFK4b+T"+F,jZKP\7Y9?A]A9/Zp?
7!!NV*8r09ECH+mZmdp[i+(e]A0<cSt89ig!r]A+nL40FKb6#/ns6eRpC6>Z4a'WrI&d,^N*:V
4YR#rdRck<\JOuTR<4eU-#>Aq*'H\g$cuD4Co(9O1p$N-_G"_pccjj;RX/c\'!V6&H5L8cup
7S:\j#?$7nc5:;"P=g3UC;X_h^eMQ^K[HDTh..#j=BXQ_>^s).OIncCCoGH9_P`2@"2Qs.e+
"aQh4HKP^4GCf7R%s?E(T(V8:+)]AmKL0.L/tZ7*7eSn;eA7jWqra-@YQuhlfa3MA@V/akI>Y
X6%++-O^+"iBPs`Lan?4VgWi4UG\4bJ)V-lT<4TR2W\fNl1k8\~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-15386770" foldedHint="前十" unfoldedHint="全部" defaultState="0"/>
<collapsedWork value="true"/>
<lineAttr number="14"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="36" width="371" height="280"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="Title_report3"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="  " + $jx + "单机维修小时成本(不含发动机成本)"]]></Attributes>
</O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="2" autoline="true"/>
<FRFont name="微软雅黑" style="0" size="80" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<border style="2" color="-723724"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="371" height="36"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<title class="com.fr.form.ui.Label">
<WidgetName name="Title_report3"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[新建标题]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="宋体" style="0" size="72"/>
<border style="1" color="-723724"/>
</title>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report3"/>
<WidgetID widgetID="0aae5e55-9300-41d4-94fd-f9d47bb1e43f"/>
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
<![CDATA[1008000,432000,576000,432000,1080000,576000,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[1440000,1440000,1440000,1440000,1440000,1440000,1440000,720000,720000,720000,1440000,720000,1440000,720000,720000,576000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="12" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="  " + $jx + "单机维修小时成本前十(不含发动机成本)"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="0" cs="4" s="1">
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
<![CDATA[/数字化平台/HZW/1_Dev/成本看板/20210729-机务维修成本明细清单.frm]]></ReportletName>
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
<C c="0" r="1" cs="2" rs="3" s="2">
<O>
<![CDATA[机型]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" cs="2" rs="3" s="2">
<O>
<![CDATA[机号]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" cs="2" rs="3" s="2">
<O>
<![CDATA[机龄\\n（年）]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="动态参数1">
<JavaScript class="com.fr.js.ParameterJavaScript">
<Parameters>
<Parameter>
<Attributes name="asc"/>
<O>
<![CDATA[E42]]></O>
</Parameter>
</Parameters>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="6" r="1" cs="3" rs="3" s="2">
<O>
<![CDATA[司龄\\n（年）]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="动态参数1">
<JavaScript class="com.fr.js.ParameterJavaScript">
<Parameters>
<Parameter>
<Attributes name="asc"/>
<O>
<![CDATA[G42]]></O>
</Parameter>
</Parameters>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="9" r="1" cs="3" rs="3" s="2">
<O>
<![CDATA[运营成本\\n（万元）]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="动态参数1">
<JavaScript class="com.fr.js.ParameterJavaScript">
<Parameters>
<Parameter>
<Attributes name="asc"/>
<O>
<![CDATA[J42]]></O>
</Parameter>
</Parameters>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="12" r="1" cs="3" rs="3" s="3">
<O>
<![CDATA[小时成本\\n（元/小时）]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="动态参数1">
<JavaScript class="com.fr.js.ParameterJavaScript">
<Parameters>
<Parameter>
<Attributes name="asc"/>
<O>
<![CDATA[M42]]></O>
</Parameter>
</Parameters>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="15" r="1" s="4">
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
<![CDATA[∑单机维修成本/∑单机飞行小时]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="15" r="2" s="5">
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
<![CDATA[∑单机维修成本/∑单机飞行小时]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="15" r="3" s="6">
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
<![CDATA[∑单机维修成本/∑单机飞行小时]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="0" r="4" cs="2" s="7">
<O t="DSColumn">
<Attributes dsName="单机成本" columnName="机型"/>
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
<![CDATA[Q42 = MAX(Q42[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0" order="2">
<SortFormula>
<![CDATA[=eval($asc)]]></SortFormula>
</Expand>
</C>
<C c="2" r="4" cs="2" s="8">
<O t="DSColumn">
<Attributes dsName="单机成本" columnName="机号"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="网络报表1">
<JavaScript class="com.fr.js.ReportletHyperlink">
<JavaScript class="com.fr.js.ReportletHyperlink">
<Parameters>
<Parameter>
<Attributes name="aircraft"/>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=$$$]]></Attributes>
</O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features width="600" height="400"/>
<ReportletName showPI="true">
<![CDATA[/数字化平台/HZW/1_Dev/成本看板/20210819_机务维修成本_机号单机成本结构项.frm]]></ReportletName>
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
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[Q42 = MAX(Q42[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="4" r="4" cs="2" s="9">
<O t="DSColumn">
<Attributes dsName="单机成本" columnName="机龄"/>
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
<![CDATA[Q42 = MAX(Q42[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="6" r="4" cs="3" s="9">
<O t="DSColumn">
<Attributes dsName="单机成本" columnName="司龄"/>
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
<![CDATA[Q42 = MAX(Q42[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="9" r="4" cs="3" s="9">
<O t="DSColumn">
<Attributes dsName="单机成本" columnName="维修成本万元"/>
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
<![CDATA[Q42 = MAX(Q42[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="12" r="4" cs="4" s="9">
<O t="DSColumn">
<Attributes dsName="单机成本" columnName="小时成本"/>
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
<![CDATA[Q42 = MAX(Q42[!0;!0]A)]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BorderHighlightAction">
<Border topLine="0" topColor="-16777216" bottomLine="1" bottomColor="-1" leftLine="0" leftColor="-16777216" rightLine="0" rightColor="-16777216"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="0" r="5" cs="16" s="10">
<O>
<![CDATA[* 点击指标字段名可实现该列降序排序]]></O>
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
<FRFont name="微软雅黑" style="0" size="88" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-13732426"/>
<Background name="ColorBackground" color="-2167817"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-2167817"/>
<Border>
<Top style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-2167817"/>
<Border>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-2167817"/>
<Border>
<Bottom style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border>
<Top color="-855310"/>
<Bottom style="1" color="-855310"/>
<Left color="-855310"/>
<Right color="-855310"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770" underline="1"/>
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
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border>
<Top color="-855310"/>
<Bottom style="1" color="-855310"/>
<Left color="-855310"/>
<Right color="-855310"/>
</Border>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-13732426"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<f4B;qKU/Xf^GHKs-@V'$.12!hrR<b)fh_;?=UkMDD#[MMQs?L,!CX0m+V<Jq,VPMEhbF6q
$15&ES]ARW?;<U#VcsF!&4UIaE7ESp\*HYNn<<D*PVP04R0hJS\=dOlWrtkem9`E\%=]AHd9<J
+A&aHf><h#XA&aK%&Mn%CSH$'$lJKgh5olLNj')!(c(FE_c5`j(/$sP_Q'Y;GjmRiIT/:16\
7GDF9\agVVod$6b*g@m5+@tQ?rP7fT[]Ach:R@[MP+*?&rRd7L\_gXRF8=;(/%kMQe2T+BeBa
X/kNAtWf/A[K>W&cMe9._M,8M`6q*YYs-&Ce3N[h^<]A31ph@1R5Lk'4^e7N&J0+&p<IS&8!H
+nWn8VXV3GQ'&DimEt?S`FmLUQ;.kK;)_\L%T$(rn$)5]AQ0fN#4sAe3bs?f55)!@:>Wqb<,K
'IdI0PRVE/\7iERX'DI>T>cdO4Lt^R94Jd."rA`105F/WD"LTRt3JPNShAs76/l93=Um>*d(
<U5Tl;M7bgRh-ujKQ79g&>I7r?%'TVL_:5$C<c<n3V%,FH*JbJ75`gh(.jo^0ZDqSC00^kda
G8=_>$9/[mq+W]A/.:;hNjVbuEO)HnZ]Au\Jnb4Z(<Ffs=h4b@3[P+&LE1o+gs45q5]AMs2P/m4
XQ"RV0/bZ1f(`Ud(fhrpd4D.MtATML,`Miu,=DOjP`EVej^>$\SnlI#(j6k_0(H]A4u<TWh.8
AZqc$ic)N9SZ?>ZjiGlU\koA%32fLg4lbI)eUHAX$ssqcIrBI'BZd8\_%46TWtUkbNSbr%aS
LmWf;^1r`_&u<kc9l=jSam><pMZbYtt"T(Lt'l:"tQ"``tKQ(Db6iWTela`1HVuHmeNB1SdS
q@kW8Y6^)dahSZ0l"R)lqS@)U8IVRCNfgXY![khRD&+Hpfg?2's/;"qb!HWqUo+/UTqASh6[
o7D:g:Z`lA('n]A`ZG7W0"RWVfIg2D-'dRV>$T4Q$S<R#q4`J!>H?&<B`mZ6H+<o@@,M)'bg@
dU(o#Kf?CKZ\pm0[4kf,bMXjLKtML`\tCYJK]AqB48#A:%mrlN`)u[=R0qO_I@-RJAUZ"=;g(
#^\rWJ&<8bV13If><TX]AhOV)oD4gs3q2AO,j)OaFNh\LoJ%@T=LTs9V/gi(9.*[tOGs=Cml;
!7jC*-%%)XdT_g0<k.:(O:$#1"7#QA5=qV)Q</H%n6HOFR%A6!s081I:1/4BWI5Gltp!f^%1
)ldkKb5HmhLV*8D\c0[NUQo!87?;d8GIA!XLbiKGSkP_Bded;i:1<%T,edM1;2%O'aPpn8g7
,DQ\G3L@M4/r2'lZ$`,,-NDAPBrsDg18`_@3RA[WD7;N&V21]AdZXSNqL.b[#J*+%+t^'iBo5
uJ,L8OMO88_X8oM+G5/'H4TID1JQSe&<-h8HDr!RpD(/]A(J4cp8XV17?HFti-mfl5!j^4Ird
5^JM4Z':nRCQH.RFpVn]A9&,OkGLH"\@*fQs=bK5:WVu[hE'YGNFJ;"QGC/3"Ur<#SmP\:U>8
3Eu%6o@-rX8&-)"UXZkp:'6G->K;*9tO^.GkcbQ<'0?Nt]A2Rcc,;i%1g<t;g-[G]A"Seuj*%6
V6[gTc)*6I(mBKD.B1?Oj\3&PI(KqZ#cKmgDG6TMq_9-s(S^(.tH$tMG1D9X&rZO#73u?WdV
J66&6=V,p;hn^NUPGtp%'-r''nA^QU!J2]A>&cT5%@W/61MfWF'\i+Cl6W4k96U*e^TAr:hj=
[&XV68L!6A'!NS3L@NOCc9(h0phHF#V@C>+\WCpf*`l'19:_rn)sc+EU>l<.DJp7QeU[2nQB
;LVpKJ%SG/;8(?<;<A-&0l\pDgZ^qGq!5O)F*K+]A4Bm4HS#Jm!qb)EKLZe-+YIg]A=oC8pMq'
6@l<a$`DHWnn^foqU:V=\J]A0V4pEOpD?1Oq:\!W'hj"CLjE1kY-]A)MD@1X6rV=MR^bHdg-0u
!m*pMh7[4jc5<\[$D8i7_Z@6:Nke>@VrV#f:E;&fZ.Ao-BKeZ(H"NtEA:@p\qjlaRM,776Qr
cLBC,e"4Q7q8&eY<B;<\,D-,_*hH'G&3Y\lFWC\,jWf^gX.#/'CBA"4q+(_;dFBTo)\7m'T)
Qm$+irSaY%W?CH![Ukm`euOPjPM!j:f5Q<U(:^JS(R5'J[bb[HfW^p0eib#(p//V3tC'Ot@h
AHq[s2SA*^:Pd%c&^Cms4o>"Q!OP8pDB1u9;,6&<)jqo!HT3i,rl!GfnUVSh,dlo>Nb/%g%?
;RckGREt6Z#Z36gK@IDL$M&.%dtN@WTuEQ*Q9WL"Tk.:]A"OJ),hf_?lc9]ANSGW$SU3SrIPq)
Er>LeRog-R^]AnR$_!(>imAlbMmUgnOUj;'?t*k]AW0%3;cqFS]AZK*R3Hm]AW#@VKGkt^!TZXTp
GU>0m@-d\?rP@=O=2;K3Pqle8]Ak=J[sk<8Nih/``*n/,*_Dn%V:r'(BP!j'Y2tGBKZ&KFgc_
SW+'B'e^n_j?Coq`OKUM-<KneEQ&$D;EMH\G<5\`/O@Wc`&EGnLb4nI+]AmcjR41\]A/V?u:ES
:s`5k>\Cep='!#-\mOA2&7S^]A!ujPe[6E,sKOoF2`5iE1Y77(%Aub9Fi5J-e)KXH/Q(N>Jl*
8pihT+fCGj`Obl.Hl<d]A.2&q,5I<^8XVC1S-pGAt!S,).N-mPmGF,LF+NgP4lT;VEg\#Fq8?
T/!',mN%?G6!@3?>a=2:]AY;Z.;k%J!p'qu+eMD>$5H;i9N2]A?E5!e7-Z.uE4WAPE]A'WSmoJ>
>qSeS!k`"hT2[&nS;7`8dS'#2hgIA2&C9)VBYVNIi:UJ0gH,kh'RuA!jn@gW*,l"'0k\knIt
l3m3,7QelK5`;lO9=q??8@'5DlQqfBr?To:&c8`cN5nHlS&RnEkh$^nRK+";;.AM>)<@U2#e
;*pWY61QI4"33o/6"GPU=9f]AHB+O]ALUa4cugUnsFW>KqB8PfBrXFnsEKJ&!H[EO8b+I/oon]A
Ks\,(,_0)D+mHnZ9]Anb:s90jXmhG5n]AMoIPSp%bnr)TT3GY=C(',]A6\cl2$A*/'1K0fh)i$o
DcKE,mkV\N,*\5M(&2g2gAQPeNH<'Xn"T*a-b$-D;@D\t9NIrroTD+hbn5K#R71OVhJf&,sZ
G_7r$lPE<7X=/KMpem=H(aWTeOm)%1WG^WA=NT#."AR/k]A9"45'8(]AG4@?=c2qhq<Tb%<meO
DL;BdkT+;rV6_lH^>K^0ZR%OSd)flgu)kfLn(M</]A'%DR-\UAnceQmaK9HS6i`c'4l<<Pf*N
VOd\._hdq]AfgQO!JWjHfbOfr\SNOTT9'm"$U=N9]A*tW)d?B_Y]AU:$l-;G[4,c*>C)E8,a$ca
,a8=mf"[]A0XGCBj(MGQnuBBnXtb`8<n)B^;m:e4gi5QoOIdRfN6g10QK?KT]AK:$N*D+@OB3R
p@:ei^Pn,;omBD3ATpl,j>U`#p&[FBi9m([/2`@OW88NM=(#t'TCJBJMQg-tDe9`7H>E?*Uj
R/6H0,(PN&!0s[(##&lhk/!U1F@fo)9VVD>0`7X>3.BC5a3uH^^6)do;J>6=&"dVL6ipjFl%
N]A:pgF_)cQTo7tTEH.u0sd&T_^#jKYKZ$g3`Eo91Td*`;!FQGZ3Je[giPje,P6@]A*rfg9D^%
msNWi_)<hC3]A#8AZT2ek_N'UT$\Tb*Xeckg^nL-F'`r"+/0HI*(BoNmNdFQ&[^(>4Le;XS:8
d0%O#D$TgR"G,fW0]A)qkD:sfQQnZraBo#P.Ytg0C2a1g"%\mmp]A,0H^EkaNh$+mh"EFIMmPE
b+-%.Cee_gE]AA?G5X4UV4+7NAHh>60POuaV6Kf2V?<L[[-TUi/jR<U;hJ=DK\=dA<,$78(C3
TDCMg4\n#Eu5BEcJt8jmV.\H]A%5fO9I'*$b[Hqr$<u#0YTVaU/YFB:rs.7uq[jFJigb?p)Ke
ut5pC4u4amgI&cj%A]ArsPD0'EF%2!f*9k7[gUi5X^_TRCYK]Aq]A+0F4:MOeB?g-]A\^/1;+%;,
qK`CjM?#JR4T_-Q.?\0]AH(qr/&%NUDb[#ZA:LKrXA$5\IrHaf*/N,oF0H$88qQ4Ggm/'nW3]A
+`jUIiO4&NddOK(&?,Ko_9s)LIj@r`HCi*4HU3dM/9)?Z<).T'TZg-)X8f),Ks^5V2'A*;3i
[HL78@(.Ps:N<cP-^`T?u:6'u@-Met?=?Cg#:94rk?A%pF!/(_^9u_If2li.D;6`0J55uK3?
]A7</du-#_.i]AUhcO?L+9'gn`dqI>!_c.^W]A5/Y.O:a_SOi$eoFB_u$5e_+[0B(\&:8`r#`]A6
\A@:l'?*858]A<aHZ_h%SrcH%*oEkIP0B5g-,!#=6o6pisXfP+D'4ej3`D"f]AQ\=-,@%;2ri%
E-TS8m(d.Dql*&(WXLg"gl>uC)-&TRmL5'>$Bmd:7N?.T/+hdoNVZjAWXU6-IR"A[kf!7p;p
]AcIXLU+N\=gM*##3%ZXqEkQat:ZZqa"[X9uBtG%kjHC:#uW9.NRJ`!D>+a0m@\7`Jum%m+TY
NHEVgJ^lsMoKoB^:_a4FW*Vl*BD'6E@crh>kJA'CQ7>:VOF-kPdNG2+m>=1tHesGmt[KknEE
Z??g*;N.a"%*,-=pafgSBId&Ha*L\g-?^m9>)aCLL3_Yeb&M'=KJY5;Q$@^5F9Ao`+BKboNB
-A()BXJ\@RFl('f[;a.=u['2VYV[ng"2<YgE`7`R$b1[@HHqe^r!WjSP(\N;JmTK+02j@Hr#
p8\4!n6XVEZR<XF-.r/mEU=+)=c!AWI/Sh]A<Z1;-^9:;PkpDoo8Js<`BS@0DiXC7h.U(I[6N
`MC(1+p6+lm:8[;Ma:eil<8J2^BQq<h;rScOk[#g/fC+E]AZ"oq.k!:7oJ"h&El-:J0(e(7&7
EAu;0*cLp@HL-2WJeaKCo=F9t56j(T7`sHh[8_3P-9W*PPpHmRAT5:G0m.e1BR37^Z;CJNB>
02a::FJ62=c\fEFo+8.@b/ZcRl)E\0]A]APAO`)as6>^1ugQ%MEgUFF,=M=mh#P9]AiP]A+523uX
_rDE^^3B9cs="F@_4Tb8!4-7[TQf9/#3TJ$rV7nq`WI3#ZpTkgaR?6IIN)n*;u%NG/^"HE=H
d1S[60Io-+h_M*KK87Yam@;8`g4O.l*%tQ?Emq(W,-dWdenFuOqTq+cipBdk#B9!ViZ'$SnN
El)]AHF2JdrpiPic9,+6tc`GVjm,bg47'D)hB@Y.M"*(X3]A\i-N)PdJ)MIeC(jZtL9sBo9jY3
HS@?F\)<RPa2G7_QXK33V@N6V^m(D/p/b-HnQ#X5kg(fj+V;UoO6>&sZ0S!d5%5'"V9hgo3V
5kca+'0&!=1XAA4h-qn;lokFB3durY;VIqgYaB<mVW_0X7BpaaCt$]AeS_a3mb]AMZk!Y1t<r!
-KOEnK2`gTroW7b_odej#q&`JQc@/kRGjebH&oq/Qa1=R#Q"$s9/"h>CZP9;aWnJ)=[*TBt<
N&Qhq2q`eBT9ha17utOCF2n=UX$[c(L&'0gi++g0]Au#Ia+D>Kgl+Cl?AOVRD4([ell+u=KMR
rQARd,cORJ@+A0.#%),-+4^K[Gr1E>6BR%t2kj+uni"nIN:D:hmopQ5>c1:*g9NFk/^!N:63
%b,/1K2s"7hFPY8*7\>dpZ-UjtKHk>pX8.0no@sn,VmqsUbLaUa-'d-IPPT3W`,PILTfUQH5
I^dBQnh`2;7(Ajnn`o2TH&@')n#-m98#FoS>kbCQe&RS(3R>qjO+`ec7Ll>-9uk\3WJ/RUKo
ae18OO<KI>.Kd;Irtlg#T4WB[$*cNDa@f:qWdlS4Xj=F6Repsos*o!$sc6/gZKSLoo8#>c'1
]A)NuCh)d7g:\=1I69@l0f!ug$/,&[Ec13#Hd!udaNP9C7X!Uo@]AAn"/U9f6^dFnIaH&9a?s2
)T`4.#,N#5kgEm<_H&h-8H7/8:@4OqRnR]ARJ"Y2Jo&RW3F_im]A+Z[&=!qK=ANdEg&?oY/s0u
_7mHU$U$"#0mhEdt+k<+O`r9b_$$LLF'nVi*8_]AU)*7b>dFiqo?DQ_%1an-2'd9U0AkFEHH_
L+P(3N&\/J<]A3iKdHNdcFPC&RW_eje-:AlZ>81>*sVp(@.uQsq/rGg>qX"/K.U7l0m]AZW``N
n\NX(Xj8&YHS:/ZY/MeB<"nb"q..IYeR]A5R87]A3iq+NG?1C^SN\sY\(2I'0)T"e#AbjGZ(TJ
U@m0S-]Aaji<Y-i<qF4_7XA#X)K0s4'Wkjgh[#lB`fJVLlF+F'j0)l_Na'u[@^0]AObhNk/4BU
:>2d?,sOo(4$W.<n[uAghR,;jdILe+C-j5<&Jd7\dlMc2u8U0Va[ZTGg2\PZ+kFL>G*l^Hl1
GkM>)/M)S`50\h#t9^PK8\d*J:)&HPJCO+/`cN.^;RX1IL*o,_cP:ScX7,PDi=Yu^+^;c]A7I
4DBO]A4\G7L:8o#UWi(p;KdllInS\=``$&HK=%gd\ETH\VcsDi+363a:DgL^+a(P=RoX%e`Xu
oVo!_18A)6DVa[K2nVoJVR-@+FsBO=tZgF`G*MBC"0#g_BP\lO<H4r?M3$Rde(Q$7>mpUj\$
Ng8`j$`B--C/+fA]AAMb_mIIN.Y<!G%B?SfQ]A/MEllhq3Dc(R%chP@96R6;lU&0H>m;;e==07
*Yt)+hp[)+(Db@t-.1(L>:6GWe6"(QmRWB""sB'-A<:ER9#%N>8rIV0>+(d>fH,a'6N7*8pH
OPO'MX72mt5:H`5-R/TDF-=1L8A3I!iqmt/<H*O+QGIhPUl*)c@5;?Q&<iENFlrFlc>Uiabl
!erE@jbCh)\bFpN;_S8%4<#MKb1.WJTIuE2(X&B2;d]AU0&shDJ\g(W$NiW-6sFKe-.j.k*X?
RNcWo0R7lr+?D+/eq`CEIq*bs)s\TYpKU.8Z2rN\)!7EB'``4QZnLM3qPR1@d).,2hS*%s$2
6BPZ+cPpR:@-Q,'@O9Fa:9.+dJYHBg(,NLj>kg$$LK8EbbD$7nQqC.jkuG8%`l+p6A>/?fo3
)k\ZpM2+-2[DG#0c3Po1mkj<b<<W5%_.)DiS4!SCWlqh+O\a5;0AL<ui6X*f2g7FQ71,QIN'
0ZX*tqL.6c8L/n!;=>RGH,?33'B+KR>5[e^P[GrfeRJ.$k&haYfj6&'#o@k1.P;H9g0'D]A01
#%+8C.Ml1RN`0qF<+V\8e;6&-n]AC$G4^!k)+Fi]A<@sB20^taF`ACV^UE-Y6hed**iuu`9<n.
R?,dta24+<CX1R_P3BQp4Se?SQMcO$-N.(5n>YMaT!.[d"4%@hiB<ue+!pu=Z0]A2CZ:k*0(d
GjMh4\O/!;ET3@k9d1Y)#XBS^IH%AF]A=B=3_8nOkgn=!W"5[DnksqIj>1U%Ul>qHC.uV+*+&
mNi]A/Z/*+@HRAR43h9q)c^DT5+OGRcdtW"_cd84r,C%(M8EhG25S7/G>$dFa"cZ!1S@K[Wl4
[O^5Wjn[@:u,p=Td*6Z"W*W.3>O&kucKfJ+o9)jDaViQ8;\]A'!9er?;!@jP1HBLb@cpVX4`6
s^d0B5*r3db^1V&`'QZ$GnO0C-Jr,=nd_b<5KWtBMEC32Mo#n79e7>eQUWdm^?G9'5qu^/g&
chbd]AIdp-<1kC%SisHPr!QltZ!K*ouN0o@8$P\@mf[kJq3M=`r"u6o^/^GrMta&@;5sOk`m1
o(D4(,@gDAdW=T18e@Lch)-9)=pG7`F)6jlS$ZGVR]A<CQgSGNAZ&>itnubqfYg+#H5K)D9R2
);88@#]APY^7/\ZsB>a5<1IF^tQAD_eODae.;Gn_$c;>Os"P)+!pd(,[4i^9B:47eN2IQF*5Y
[_WsUdI2LttQr-]Am'UU^DP"GHo,BC0hBdgUPa>(4772Hur[4NAg,sJWI=kY^b@`3Gk%#ZYa0
GF6YAY5qqfah9@@Qe7g`OTSX\Wje.\oM;5qtgcV[/k'f>WC%MPrFAuk)#N2*cum([)ls43[(
+UL()q$+?A;#%+Qa5'P!!fGHIaXbn&(sC>A!X=[u%,^rk*WCX$lV&<a'UrbM6==JrP?F)2F!
H_D'>o:2JpXIA0L[Ri4$Ro$WILBFU*!TWju$uoDCfh]Ab[HVt7TLM(.H[9IESn9]A:s29U&.P:
K<GkOLn.i>#r?:fUpg/Kd:,<N/a]AQA4/IL[8Lu;>GRVnn@".A$joD<H(L'3ajVSX]AZuL8pL)
r8)%*OhLlK>,GiVJ9ViAqhHu3^qV1Tn?e.dsEqEaX@V_^/WAE[Bs7/4ZCK=R%"I3R:F#^nMo
_B2<j1e]A3#]Af2UBJUH)6cri<#JJ\&CD(p\^e62U)JZos0h6JEs*9eC"+F,+s$RdQQ!?br.gL
f&X#P>8+C_A4S_]AHF.W,_r::sED5#"?>-M5JWk1^O0[Ram5<SMmBOucFl^5JIL$a]AG%F@DL.
RlS!IOOFC^71kp$d%n)-+@$X44i.?.Mmehp[A)hmn5:R=OCkrk6\<-Wcs@^V[!il[o"_+*A&
c:n+4*46*ts"$<Dj>[m^_`bDU0]ANNhc871_Y.=B%f`1O:c-SeQtI`'>R<O.$Y>\^LK)4<;f*
W,WGQ@gM\k&P?MgYZ)/T&%2MGQV4fkg?qtac5[T3mZ_QD8^.'0Q:D)c5LY9HiFW$]A=&u$]ANI
ak"O'=hm'j,Z$rcGf75r*jks`V.H_1Qb1rI_!]AR-/$o#SVCJ#Hl(SePe)bX\>V0d5]A,dGOZT
5eJCsYioKf)pXm=(J"21l`BiEH)Q`hI;kq8bLBE<H66@;";ksM:D<LFIG-AsOF.u,m!%R%gD
8GjhGg0u<.J_l`l&&(:hW7jc8Gd#od26q1jbV@t4b[*O(r=\gDN?MOY'2oj=ZhekC<#t29C5
[!s3S%oW4JhB@6Iie5_a.WZFb%Gs%;[P8dC&&o`_e6sO79c?OgT15WOkMD!<P4%,=/fceq!p
R23!K6gJI0ZQ"G?\3ftfr8"im2IVr7tNSS6rdi^AWq\4f%+0>on-[VLm\XkVSb3hAT..[7I*
M/T/9'#A4[Ma1b:(f4%H<=;+As`9<O_D[W&'(:1f+-WEVfVgTE3`i8:I0#>:e0brn(CLs.*C
c#Z4Kr%U3eI"LIq`e.c$l#(QU%V,i0D*ASZO/EutB!T,!(qU%Bpl[o7);r[m>()0+2L`K!S@
>W8E8+53k3G8#(M,]AC'EW'TkGBSU:iQp(+nO'1e/r<#WHD5jeplItILN_a+Nf@]APLZ<]AjNil
9u!HpZ;$RqqXYE-G5$QCE7k\2!MEi5*OZ*gpMr?mpb]AM>RXR^M%`d:t?ANnAQ2h1,:(^T^uB
"kn58t!GC<:+?Tm0"`nm.PK3L/ouiVYkr$71fmZdcj<BCqIqgXE(M3+q2qJ/"VMTT.,.o*\6
@:!1LA_\$&=g5#\/[`RH\I`#N$1>Glq$mKD3FgL-KH@0<n'hcq>%CK7/uR0N4j.dkeb[')O$
1&"k8=,-f>3:[U++bhC-*aEhoV@0$1RDb\np04=;B60&`i9rILT<@8Od,d1(9_=Pas_QK%Q*
2*68EnJ2>o_.cmDL9]Aa34Zuq`#qLANdn7!&"6lk>&U*2t[IJ+!Z<"O5DIRC;S(gh%00\bh,M
%0fUslhKI$4nEI>i@j>7Ebk#`Z[H4O^MgV_s@aRc+GlkuR4@V!VsBM?D_SNNA[d`?m73/:ZP
9Sf9hJ>k[N%oJ,@d3DGiJe_#*mIs>>\,`s4?rTm-.H[RNtgf!HFpM6HSrEG#\H67PL1Jl@Z/
K17X+V5_(6L0gN/Qu]A^Eui1\lKc1:]AQphD_Qm5s8+SV;pUB&#:F=P4dF,m(+aB6G#bElibP=
qHULd0bf[Y^rV+Ybq[#/Rs!tJa=&+9f>:#+D).K=*,Q[pcUbG'@E]A`KMnN#G8L4.]A&Oa7W#@
jhr0(PLtnV2\4p"e8F*:U>[=H<Ck)m/Co.>;$LokYZfJ?df6gX[(*:`ZRL()gps"bLB+G,ER
CPi6Mi8HZJ["M_/#qcpoqARqiQ<SFY^?mU"O,A(B9aAX/VX0!Uf;6GggTh'<`M3$qRL_/4,R
[b2FB4X!ZPE,nA=4CFr#F)m;t"$D1R5IWbNi&W8n7Y]AE5k%6$ha]A2::TZO:bb%5`aA]A+ZVZ\
S2/YKfMIlV4GTbIYL3poc1@9?51qF"(g_.(U8e';sNDQAsiIhXB32A<K:$t%18ZXoPi!+%63
,8Zf]A<$c]A;J7qo_<J^i>+/OK#iS#]AnVCrQA28h>SpCET=N3g[PMn8?IocbCd/[b>a*$$$fl!
<\`gZ>]AhiA?^sOFTtP$eqgtBjU.nl,b05M`B@7dA,3htD<F.3U_-1d7hI?bG[d0^]A8=7Ub9G
JSlf%fD4F$;%"LW-!H*EiWXX7TG^3RM_U@>T2e8QX`?IdFi:3%jL76s)TK(V4[CE?igk2p<4
PJpSklIOpm!(VKZCQd3:t"KOrI)Gh+]AlV/39]ADc-!"_,%:=IehP,XLG1Q1Eu,\]ARa*8P7P+H
(pc#NWG>X3#$Kg.&NpemX6\cG''mAF^<L;F=Y^&rKZ>ul]AXL=\f^(l>."PN48aM<SS0Umr-e
;E9-pu^,#WD/`hTH<28ZJ+RnopNB-T!?pi8,;Y,e746;K/l@9+Sn?1Sa+GSNEAID!@:P=I(a
#,DgN>MK6f\h?'#mrN"9)oTg,X>rd%Q1net@D.$%OcC,gn"4u,IFEdF2K[)*r,s8;G?cRgd?
s#IbJV=1#.?PA/o&LE9B=>*3O-#*3""^LE9,d2<UlhGa,BUG7uhgoA;EeIYeV3M>cGm3>@:M
G4(_iu%Fcg7KY/)+>7fm>(U]A.\MF3NER9+4*jQ#m9'nmWSrF5lp*LRY_G[98S=RW=74lpVg.
::@TSf)FpBUJK6UXoB!&L`Z3!::;138/"(!0l+LV/BALs!48UrN`28:OV6?#G1#NgFW`,Bkf
10f55RJE@r/8UJJ=E^LqP9r_?;>Abo'jNi+I#TBG=24m%qDHSAT*=`jOo%g1>8T,5+kIo%'q
[m!&lhZS=%iGA0).)M+;-lp;i;Qe)*-``?.0EB(X_D()JM3PhI6!W`-HFAsuQA1Gq#HY$^"n
pNM__ot$"9Z3S,`HdDNq=Uab%-(.WfNWVC:f@nDo`j:ApTB?.>/EDana>MB/>_PYOFP;Y3i^
W"1GiBe8R8=r0c,\EoI[nBMU=24Qgh+JFuOC*\#e;FT7Zs3hKH=/'l/dIhs'ic(M+[ZGm_@V
.C[)3eL6VDAU9n\?r?@B@EbZVX`>'-suQR-I.=UO$:@]AIq8CHP0!MlC00rqSN>>saHZd0^b)
6Ukb_&1pr<TK6TX:Vf>Aj,KNCt)(AhW`&3-dkMNMjRAlV.WVWM))jsT^<FQuZU+q0&6=\[8J
=cK-@D<'%K05UBbTMH<BCMG$<EPn$)V'Lg"`6UR%Re8Pa4l.s;2a/]A=on5%+B:#/p'j]At2Eo
]A_AigQ@k3Kph`iG@-2lgmH`9:'[3D:#C?77M^dlKX1kB/9Vls/'*+D]AuMrrK)r3=1dL`og"i
R@!Ic^@o'f,Sq(5ii&mgU:[uO*Rq&&InETfGEVl31o(lY$RM[<q[m^j6G0Y,I83J?IaU\!VU
_DgD_n)G8T/S+i.tUda^JDRjP!"\9pPoRVEHcd\O5G4t8"tj8l0ZoTnNJ%8Enu_ufM'K'V,9
hb+FLQ65T?YT>fB!KSS5%LgEPNm`kQ3Xq2[)?M=qGgId=l2kHt#N(U*AubM/t"&\Fr[Bi/!W
(m&o(<Ggh<jBHpK>J>["21H!P4.U8t`r,tdg\sh">\u`/FF\`8P0$9oNN#q0f/I!ls'IKKSQ
7X\A.DjI.f-sRm`s?(`lBUl>0W,Ah8]A)o:k'J*;kN,+=IfAmL6>tk?0DQHrIaaUjTeka(QrZ
^X,V&tG]A7"el5nGGLkW:tZLL(1T5$c!o]ASts;T:ocL:Q89&$?oLTo`CAl,PAgPj\%_rt27+g
.e$a4o`#2eh?LHMS[X-SkUm5AJ<UirUB>FSuUTq1@&/(RAW6jk_Je^0402QFo"=<M5L4cm:;
\QV%<%-jECAF\Q<91rTXI":J52XC\.9Xm^:o69DD8+G<YiT6T:t9AmHf.BJ4*P`/om\5X(F7
iNLM-/J>@CpE+>,`;a_cLmde7C2Fc-B:FBi<pdZk*7.[1Hi]A@BG$"I]AGg;n?<BI<*%!6!rT=
a$nQPY)[]A,q+MOF-p6%_8Q/l:YkuD8!l]A<jOU5S_e+bs/[gP`Tl.n-s+^SqpbdQj1h-t2?3(
s7mH95QUI%AnZ09mbn6,Eh3S:k)MJB+\2cX\iI-]AnSOH]A^cR.4WS.EMmea'8HMDkD.&G^]A0F
+C,F01X7gW[:Y/Q]A<Tr[m[KDQ3[mD-E\T[cHKpLU&?_6>/5&[pIDG0f)<UaQZc6T<73Si@Dp
.,Z0$<r66rt2_Vl0Lc2Im%\@?MPoK;rrIFFs:RBTG69#b$O"uu]ACQ_QD6EGhW=V[uk*3M1(t
IOH;@Y7$m]A(KR2*M[V?G<I$,COge)<2*r'6U""oJ_@;",/p,snPGKTmH-fOb39-TV$aX5/-8
iJ[[MEPoL?;HLqf`=9OPqXcFi!]AqT*AnNi^O;>r3[h*W8@;<CgOk4hL`\QG`G$ee,Kp[)tMp
=I8S8,5HURqn`Rd_/K5'c^XFcIU`4+T48t=gLg+aZ*P-/GD[f)9!$+'BF,&QsfMhuo;-g`;e
GYeU"TlE_3F&QX>Y=IW&YB#Xk\5f"jM=.0AU9(3aZ1GIA7''UPqbY:1-[G>hfO>IM-IMAenM
X^*)?eH3B`uSK2D9gRLV(jpi@d@gU%!!nGUqBciJ,G<.Y4_^oho+0,uHn^7m7PVbQiEpnHts
n\itlPhFC:^7*#dHDIk/?X(<<%X,OQ#]AD<e[T&-M(A6oW#)[T:3TB8p`:?,Lr4a+<qcI-a%o
.>'mp+JLR:c%B'C6k-B@-.<=2qmS(MX=Ng/>34o$VI7CAd^a]A$Om;PH]AhuXt/XAVnsKU?<97
oE6"Hh*FdPoZ?*^XT0M=Jrrs5J(E8Q?n10pUlH.L8jOZ<9bg@<S1?t6uPWD[RiNICmp/ACQJ
i<,"+;[be<8%MtOq0UqM>mPHQY-Ks23)Wq?0KA(n\/t>pS'TcY1C0\lH\ZL;$n![?;W2hU"\
Poi<k<N2m?d@K+i3=AR6db1)=cp!59cBH(\VNdt_AdYM>E+h=/?$n^.<teX7Z-h=k:J5$Uh]A
(X+(QmJ\firHSahRJkl6&L">Zs#,Uj'h-8.W*0#sO;d*H&I,6;5D1.J5!O%,:$l7AIl[EgX:
0MT?W0m]A&OP':%\Ff%8^)X)`'_;K$oJ[o#56,0(e+p.j?9UVr=9SE6`9Qk`Xcoqc[q38Fj_9
NBJ@t:lh>nMINrAj@L+I:T"^_<)J+1DY2J71ANF,IfM$Un.FO4N3SXto<#*Ja7Jk/+fHZH$E
VI7%^[L?O:IGV/KK[VM]A15$p'mZ[aH8IKZgbo/HGR=(3Xn!pR(PE,Z$L@1fR<M#q37+i$#7l
)KpW3KlMp0q]AP3kr!h[7UKIiqrkmk*`B<RAU"=5N1+<j<Mp>c&u:'g"_s`JOS#nB0^:ioUrf
6/$_4rN[cP$8"`5?,KuO?aKjJ'"M:lg*->%lt2\FW<l@ce&DT4>;+SJdptp]A#k7Yu#`:FfTg
@-iUo=0=L:h[Sb-+$>CERPu+[t#4[m7Y]AjpbJf03?Q/Ysd[9A'^>02n`>p9b0M;.^F98-I4:
bTG1o.3W.V!9monN7gd"4Aif<DX[A[+f?WD^)$k(e!`h!g_P%sti/<3EK.5aEdbfhTTqhX0.
ZrV`Hf1//bs&Q+m9El1$CJ``le!g1=<4JT#U1e=.5DBF+[(FuMu*$&!)8SsDNK#-*8i>lKa]A
+_IML@0]AtsBj+'GN?p\0l=I/P!f7O:=O]A:hMNN?)S[Yt!Ip[9>b>5E.NJr&FTgo=<Ef[/fXa
$T*tD-dt\6o/oi1'X'LV2oo\LB`mO4bMi3<mR<8b!Se/*R'j3iLsE8,[?nR8(B$a$`&*Qs[S
:,cRb,3^p:1SXqkm56s,iYpDpUd,"jg-G_/sH"Aap^=^?:]AsQS)%K+9,WRh]AaNdKhqDt)&'m
;*j_X8&:D-a,lDtu=6od<,\K^ep';6G4Or[hEu00<m!bOFER64XpRflXqmQ<u6XW_B(MTCSq
]AkG(hKaidEOBL)YK6!1ikAmsQ`?-]A,]A/VSLJ./I([$5cXkIm1ej$O[,U.36l)!]ASns^:?FQZ
]Au3KKU<<j+2/(h=+3A$PQ2LUJ75)tI&"nr!1HO&Z>oeqt)Zj6i8[NL(X]A!kJ2^=8PkObYoCO
<AcGF);6@\WERmgl)mYl<Y`o'4K(+2]AME?jiKZ)t)lgc4LZ?E8pdC8<OfhJ@,O<Mlb6*fIP]A
E`@l32-SlqqO%!V\3->^>9cjKD59J@0b9"OXL3.8IYumP<HGD$.Vnop/Z:m]AlN[(!;i+ZE#X
k<o7A*4"pgfgi^H4d'V0NNiPH>+.Me,.D72H]A>'nZED+0?(LA*^&j[A(SS<Ze#/0^m=31rN(
1_A8[[Q=lE2r2&7f>%`UQN]ANfmom1mHEOB]AY;A7&cMFr$$_Cf5QL,Hn#m+*35!)BlTj&Ll\7
I*ltuGE\o:YGOG8%Pc%IIkAKb`:`OeSt8PrW+7b.bs1lD.0>``TMi8E$U94-Q*e@*.Q!9X?`
0me"6\uT6jbliUq;U_<hIp&GtU!s<%K9peCC/s_$^WiBBSV-7BJ!;<&)6?!7(O]A22I,Bi81)
cu%oj\9k(r"6J!tcKX>k;0Lr?j(YcMZ\MJ(fCFSI3MmX9^5DZmN_#o`AJ]Ajh4u,0<Z+:[F]A<
OpdqsaV3diUoM5@nS<s1?2eemRc\!u3eH@VO!*7mK&T2<+435MjMJ!#J'>ji/i?ld2Ya9((R
KF[t+6PG',^@,WS>'&;1GL)j%88dn,_ir6FUI^dN5KL4(m329ETA&92b=prf%A[Onk@BmiZM
g:L[ilV6F[f^Qn,LofaBW%h#mVt1!S@V7lgKP*r,S_&oMefa&PqcVD0KB@\Y;(5^.j_.u1a2
jZfjh&]A?"E,ls9-2ApJ<8"FmM[9&5B7+t_(j!Oful#BnZYmdeK3ujB=IU*mf1JK%aJFHU\ac
LLE`Sg"0GblY?Od36RMGctUd**IN\tlsD^"6VGLq=QJR-,=+^r(*kiTC5GK^cCeZ9"q@4QmY
!B*3-,UV=EI_j8=:SL6*[Nf9R)4Sq@-GQ0WV6;]AUn]Am_'[r<n/g2HN]A0Rgi%HS'&Z0TZRV=M
S2Wj8)_;;))N),<i(RY?iB[=jctBsZ[jSC6<b.U;EYU,CE*K9*Cp64EE3p]A"CbT^\35i/F-h
U\nZE>6Ob%7q5`d_YF"^_b>#/dgW%`aX"Dn^'1mj^5ML=<ecCSA36JKFQ1/Rl&0s=>o+NYGB
hk;q6fA;VU"KBY>[br:o71mZiUZf!]A+o(PdkZ=UmNhZY[d8(Q4IYK^=PkcHKTiTL"1:&mk4J
bf"-[t>gE227I5`.:2I**M\dgA`-bJm75&NjV%T*h/\AR(DHLr=lY2F/Q#UCggY%22rB]AE(r
c66)i8W`KO(#YO4=F.@_B#;*ts]AZK')k/+kFN:.]AA-8#)=#0Wa*C]AYc`8nQeSg&L(^h/m!@1
VG6mT9t/R(omBoK+;#3)_aQ3@eVBPlo8g(iCh6TnC:SncaOj]ALW:n,_dg-Sba1dP/Cpbg+gX
NnZ,n7\KJ<r]A!$::Q)$M897<&i:Wqm"<,dIen1qV*bJc(B\fjCk+"V^Zmp52eH2InWmP;cSu
^3S#>$lm#_e8"Vo6LOSu9S3_,:qd5^VZ/^<$<nUNh5D2/9[BHlLZRFs'Ug1SYerl4<4V6j)$
n@cJ-&M7\k%.D,oCncKH>g9PnWG!PN&fA#Ne(t_*<^"962-M'hmj?@rBaA8P3>O\u#!Y=?E@
@"//@1U>&X0's]A*XdKAVkOkL^56WdikkiWJWI<DJu/jV56k."tuc?W1'P;QCP,YHC4#]A)tt9
ZQ\qDcYgsV%PK/XZd%Z#Uj5EZl[Kfr3+>N0[FK+6]A/MK?<Pg1OHT0pUHB(XWA+G-mqjht/+/
KAK=tN9PfKN]A'FV1rq66"jC"q,h;S;=2#:/h=\iqE5o&0W$!uqf$Bl5AP/$4C^k"g4,U01Fh
8dFMV4"hA=jU5GReB1Yi6RB5,DSncr,<us=h`@uL`s.oDoa3XH'R9QoJ4mj'qG8uBoY=s!&D
Z?H94G_7WFuupI!-hBL7fl>iMONKHLTDB&3*&<:QG"eWkgEY.WTLc?`=h>Ii+b0+YuhAc]AjB
#(lZ5p3Z)n9]Ac&*(5A-o;4#3HCC>PahS(aWFoLV^_@3m79UfOl%p"+sgWJ#p7*6Nj/Q:0k76
]A:N%FMdA,krB`dFI3`9(d'B"`.1Z)0TaNlJL[R;oDt?2E,RrWK:>UGM.Qj'PsQTuc;Ml4/sR
/7k@Og6+ocO2N*2c<r2gBF/b/q_3KsOoSU()!<i+\kpW#*Nhiqm,]AhblO.*F=Ai!/h'<hhtR
T6lJ<__,PnBC+9Jqnl-q!<\=Mn@/n\s2bh2Nr*jq<^_^Q4J`N!!oh`3-A`m=^75>`GY0p4Bt
=??j(^]AkG;\]Ai!)!#t#@mlo'AXCAb8:t%+::umXV,B`/Tgn!Fu,8=f]A-ul2Vo6FH$RUY?Z+G
L.tpp5@Xq]A9DB0d)Tf7D,<qI5#[=POcEZl+eJm:13Rl"gb\$5>B@#?!\3)V'J##G"8DH!RhP
b9JL.K?oj%n9W3^SKNmKob'^mu(YoSH2s5QJ^=AGZ[E;<A'B"=5E\Y?RUF&$-W!<2e6iS6]AC
JD1]A1XXA^>7\/n)PVi)PRt+lpccF\fkH*i72G`sD?/3h36Z:kBao73L8:3u,#Lp%2(<]A]A5qT
q@c&J%HCXj)&Kn['bcg$n4MQESY/("2Om"hc%u`-X5L6".fAMdO<7\6kj93R6&B8';!#m@H@
JT?^B9rl8+l,PpFEC2ql<ET=\,@ljuq(tV]A!k)nDg1;2qe?Don"=T&QDQW/)%$.D%5$k%>tj
kl"B7_`Tj;Z?m%h-Aj6E`---h\Uc3P:""h9l"t_>?_H")U11U"0<=mth:j?\SS/im1H/%`Md
rrb5&]AXj8+Fa2&qWXu)4TdDj,XIt-G=oYZ1RL=]AC(W$Fh@'G$!QN1Lq?s/K7+*TfL*QHC#Q4
X$TRs:DT+eH'()\:%J^nZ>]A/ZR?0LN:j58NCpPo@<@ZA!<<"Q_;#$;XGbfC+@Jkn@3L9EtDE
luGkDhHVj(F_!d-Y:7s6e-B^m]A7X%1cmkJ7#SI/_*&XS&5nstPI7Wl.q)-rAn&tuLDt),n</
'clEhTuP"RY(p-,rb\K;XV69MM@ghh@'iQlD/HHq"EGKg>`cR\[inWeUK=7X4VLj1hs45rVM
[*9B`t=!o@\![s>NI7RgiPF>VZFZ68*iAPqb^5'g,[@sF9gTpi^jO.&!(hYFFgFP6_i#;HhG
W$\"o46nQ$`>-X<WV4]AkZ?odIu2>\NAjPrB_]A0j_eoV_s0"E\G)Oh2,6Lq@Oh)f=&?KaYbr8
;BXl*q!!L:6:*<7L9M[eia[,MVPA^I;I840hI5h#.nlR<)&Y#Vl!65!8XP2lW@b^Vh,+M<&c
QZ)J6%W80B2'24A>Q(;_BUYgRD<al`Qk@d8JQJ;RaV0E4mcSfum>f\R@c3qU#S'>>m`CnIB6
ED,BI[4!gdUoWjj=btRl@QD$RRBbiMX&<ft71ka?cp:)7tD)Y?Cd'=n,k/4o.B@@q/'lKbB[
`'U'@$T)QfEp%AcL-`.IGK,"ZXM;^ZLN(2dBX3ro_@b@J><\&JUeU@os/\VfK,43uWoL^pu,
geUEY%IOHBoS^ALS,VIDG1+-]ARE_]A<[;klKS3c(GV-&cFsn*Lk<&Z&^Ot0kL7XET,I`=2q33
&@rZE7npsXXuaY\HbN<t1[gXJnqeH0^)>Y!%qP;A[SK\M]ACCcpK+fU5@E6O;cU[Kt7TD16hn
>1A14D;K)Zi;!0),O-6_A4aRF&,;2%JP*4A#9[i.rVO"%7aY[F)eJ26n7qc[C.1+\*.HTo6I
[grcCFe+_DSrL"o6G?s4P!&FYe1#Qf%d,~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="前十" unfoldedHint="全部" defaultState="0"/>
<collapsedWork value="true"/>
<lineAttr number="11"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="983" width="371" height="316"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="absolute0"/>
<WidgetID widgetID="b0e35bd5-a435-4f3a-9b48-b60927edb388"/>
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
<WidgetID widgetID="fcc8684f-0354-4bc8-9ef6-b97b805ede0d"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="comboBox0" frozen="false"/>
<PrivilegeControl/>
<MobileStyle class="com.fr.form.ui.mobile.DefaultMobileStyle" isCustom="true" borderType="1" borderRadius="6.0" iconColor="-14701083">
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
</InnerWidget>
<BoundsAttr x="91" y="40" width="348" height="30"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="机型"/>
<WidgetID widgetID="e3cb86ec-b11c-400c-bda3-db9ec4e76218"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="label0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[机型]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="7" y="40" width="84" height="30"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ComboCheckBox">
<WidgetName name="cb"/>
<WidgetID widgetID="b50bb660-4950-4c88-9f59-ec51a5954c26"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="comboCheckBox0" frozen="false"/>
<PrivilegeControl/>
<MobileStyle class="com.fr.form.ui.mobile.DefaultMobileStyle" isCustom="true" borderType="1" borderRadius="6.0" iconColor="-14701083">
<Background name="ColorBackground"/>
<FRFont name="SimSun" style="0" size="96" foreground="-15386770"/>
</MobileStyle>
</WidgetAttr>
<allowBlank>
<![CDATA[false]]></allowBlank>
<Dictionary class="com.fr.data.impl.TableDataDictionary">
<FormulaDictAttr kiName="成本结构项" viName="成本结构项"/>
<TableDataDictAttr>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[成本结构项]]></Name>
</TableData>
</TableDataDictAttr>
</Dictionary>
<widgetValue>
<O>
<![CDATA[全选]]></O>
</widgetValue>
<RAAttr delimiter="&apos;,&apos;" isArray="false"/>
</InnerWidget>
<BoundsAttr x="91" y="73" width="348" height="30"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="成本构成"/>
<WidgetID widgetID="e3cb86ec-b11c-400c-bda3-db9ec4e76218"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="label0" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[成本构成项]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="7" y="73" width="84" height="30"/>
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
<![CDATA[434880,576000,434880,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3600000,3456000,720000,2743200,2743200,2743200,864000,1440000,439200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="9" rs="3" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="  " + $jx + "飞行小时与维修成本"]]></Attributes>
</O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="true" topRight="true" bottomLeft="false" bottomRight="false"/>
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
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<jCg'DMHT[shqu[FVb?C(W>+)TB!S/QsX=ZHa4XWoZUMT="S?[C!o=Q;g+YaH-5lj(Heh.V
-OqZj9eNQ*%!Q[17a5f@=V0.>^;I<?O4HGT_a)K]AKYuYAXKP6?4\[#$/?sO8P^AFa*;$hs:)
a4^ZOelgjIn5*J&#V_`dJgMODo9mc/^B5bEL8)2j:]A7&e%Vte$[YV!0T[bKY%SG'n]AcY_?VV
;lO_hA6mV4o/p2Z@eh0G1Xq$6Vlh)4M5NC`1<ea550\2SglmMc`;EL5(!;L61_cI0-$?()-k
tMjQ9m-TDi[rp1D,N"KR$BqSgW5X9TLZPC3RpFor&iZd<qXd<Bf_h!B3denqQp!;0qOHeX)F
9s&O[jtDM!=f,4h`lIH_;gJ.f:c@$_(0?rY<te!;EjpTY,o]ADmfY2!^ZIH0F>U@jqR)trne)
).tRLmTCCkPR,&EVfpiM3SSPE?*g`tdZYO-lOZYb\)2Y.,bhT(SE$\D2B[!q#EAjhYR$F`k<
.GSS-YM[`03>3^pC9dk/a*WpFD2Xb0SI(Z=^i\Ja9U=J-P\fc2#nqO_`dDR\<S8&85$4q9n5
h]A,[2!J^*O+GBR.-nKY;8[AjQ3)mPm2+&!>#hu*#>IDIro@lXdY>_UHKY!I\kK7k8WTR#F`q
eD9I>qP\nXYEnaSo'EcHS^,58RNXf<nRBgI<T\M!S0Z?'Gc[A'u,ANj?BXXm=8="A`\OGhZY
=&M%Zi]AsIp7WasdNOLN0/L0YPcXNl%`&XkG"'sCT[i>nW"]A*W'?'d1uH1cFo]ACb+S]Amm2dhV
BAqIB&+Zk:WGi[ckodDcY)h\iUAX7(hD+)Ou-='+m+6^ZkAU/67=u[U7+IZ(`XX5(nE'Bq<Y
Pc\=me=9KGsjdl6Ndp@qiFjFjp$`c2VZaDI(YOn^Z06i^g\6Yq!5Kmetk3D$q`VkpkMTETd4
K5YIRu@5lDZ.MZMT5D$'pW5<QQr-bs(^ZW`(bR",7!&NXbr2#-D[#'Z2?ptd+]AGSj_WVQK(k
Wo^REo$3i\4srO$01<[E'GE.PEK.DO90pDf7kM/qkCkE#H=kDp!$Kuo=V+/JYPZ3Y`Mp>tWu
D=IN+DeIh3`"UN/'IHf6HQAS.h]Aq!VDPpPq':ms*+^D1$bH,PXb=nOdm[LuES!?qCg7+OgQ?
,pd(A!`j1-U^]AkfdBK&'C2e,iIR>?coCn^MKR7').XO>)nFi2_/XuT6-C[-I[_p\`i$;+3F;
&Z/il0J]A%B$87`bF`9-J@0^_-jXn+3+&oGg274L>W+fVAuW6*MZJ'gMue88?,38UA(Fc/Q7/
6UI!DC(+-T&!(g$01JF%iQ5f*/,$?n\oU@FX?SC#!OTgXkWN6oHh#[Bu-t$=C:]A)"c@M?RJf
cRW%E!RVpUE7[:Ntr[%^'VY<0mX$B=6.Q<Oj/]A>s]A\#5bu8efTsTIOoA:I/580bV)qgAZD!%
m&nD?r-n@,'`'N<Z!CO0OBgsl8BHgT1u5aX-[c)OXJ0OuhL(:0pmr1@cSqNMAh!!740YPS[*
aBlJ%m0\Y1aKBfA)<F/3AtM;0BNin/XJ?bYtO+M6r-5n7J(Hbqs:kdq"#C&kXS>I*DVqL_GH
J8\e$SKl;ru"nE;P3q%H;G5>nEmjV,]A#YiZ%LX1PHh5R[bR^Za"A:'O_5BI6AN[a8KDJJ9G^
DO;?BdG7&;7:_fkcU]AqZXlCDn,>&8,=\Z4ICpl+-a8]A\=S.&[67\G3laNXUEhuGe]AMRIa`Vd
UO^s7^bpJ"K=ANr+oY^>\0^ZYIQI^1G:k9fS(lo8H"Rl=SVr=K^<d;kd]AT=9707+1C+VF&0F
;;1?`;-oq.2f8C".gF*"*C*R+F<AP&4.&QE<WYHl2;R_R>rm9s.ASW_kVaB9_cFPY:b_.m.E
LN5ZlU>M[*,3I826L5WKGXN%6`X;#0:Ka+0\UD+kkTlVOXkd,c(=%LfcdgFH0ncG+u$@"(8i
A=_a[:,#[_u&+.rqLbiU<LZQdo%@`7qTAl<bNnT:266rXn/L@Y_C^R)FnNq_;CYQ*GO\Y1nL
i2PBcgt]A+Rg8J#iW0jI_1;9()k-^EAm#CL;%ieXZ^Z\4b\2q(nBJi0[s?G7cqE8_jiuQN3TP
(A*MTgVm4"LhI&-@d8,,Omp?3kqoK"ClA'dc-T3kSK_Q:IM;%c8?TQg-F*Vf"<Ui=?bqTkT+
#I9JfpN1F"I4ebLhR)6QZ6K^_db`h*hAq3FbQtA=K^LX5;I&H;;cU8#5G)%8qPd&tUEkt;NL
hQB8QBK'7-OX:rDXJ7gJ+3?nRg(Hs%IBJI0<V-D+b>9pPUG9`t%`Tp)BURWYh0aW,uK&.=4b
V47'n(n+P+r7doG.5A)rtfCnbLZ^e$YiP/eJ]AOY[r:8/,5P;e;&S:4FE<!E8FTC'LlfB1UZ9
jXE+(,]AUqVn>Y.68Ad9r6LaoH.NrTRJaTeY(0hY'?)=%H1o=?^ba-RkuX4m]AVs%,lUp4hda3
af6%[VYH.&fDH@T=)D6#.mDV(`&Km+XD^3_Jk_%!O=?iBuW?Kr'VAB"R"*0[_<qCdifnEdrR
'_2oE]A:l^o[_+u??R[O+JQ/fq`DjS%;*/hT@T_+:'noqNXA?K4VEu^n7rc#"8?,9ri";q208
WY1VK7d\kc+oo;L^o4A#OUjnQ\ICm=B^&QY\`.-rC]A8,th8ep@^[;[p=B_1d?O?A1/\5Zn(7
):gXAL_U*E;YM':5n<R74-#`n\o(%Iq*Nah5Hf]AeH$LE$dT#]AeVd`rA:fou,%6+_NF@&;8?e
HA?^Kb6ijSM^3U^1+/<08eh.b1l/rN0`tmq*s?bVbM_aJ]A<0)i5YN:!*6(aEb81h23EQK`nu
O-`870sGr&1IQV;pr8CW<nX&0*p92uFiFJ[,@ATo*Cq*foAMW=cDrb#)B/G,*o-to)&]A%c$o
3$>C9T2Zdm@/s'bLn=C[n)N7X!\?pMA.Bm@\Js,U:NT*8"/tQ\[B(cFF7N3hDnZ9-lARl,2e
T9iEet]A.#Kc*PhDXP,QERUD='!]A>2uIbSkB"+#@<q;QV]APQ,Gb#iBm!pj=G3lrFV]A-ckg77-
eWqdfg0Da0FI-@c9ITI:1)MtYC53\+?_smap`asK2<o.eSL..n"1\+[7W``I>#JGN,3qn6iN
d<"6"A$Mi/2#ak47##uefa,u4YZA&.njI+[!YO8+q9gAaa`!"59o7U-<O?VB+Rc2a$HTc$C#
25*:AG,)p5R$EosgnkWY>20M!L>C*cLP<g$pHr6.WV]ALBkf7/uID7eGbO,')^/c>oD*ZW(&6
cOnECi=@A80;^(CV-+TC)nZE^*H<4J<QTfjPt/c@B]AaY>E15Oa49Ko&@KCMS7gShK^\&tr_I
U[J%#XkpIOA*[$=7n"61i"mIS@W]A2ENnm.FL/:P4d#FPkoF)qJ%TV.D_'NL()["OLk?+PaM+
]Ah,C@!UkkCV`trrg8lVb2<.;LI9SU^uUQ?HcH%"1tG`bNKHZTbJ"\oliAJJ-82<$k6_3pLCe
rb96RBo12P8HI15Lh0^*H%ek,nTWp'F$)"b31MIf%B[F09gE*("ebkXgD`CmZ^[[T.p_:hS-
U&0lO:s_Z">I8o0![H3RH,bP)BBbV3<KeN29=4r^F9.#L*-FS"SGK.#W1)@C[oY3=KLC@9Bc
pX&@+LKDE\`km[;ikr9PXF!^'R'3.o<-EaSRe8+=Gh-FrSnu1"XtR(R\XeI[k]AQPZkqBZC[>
sta:FdD*[3?+*amH`7%lPW(b:j(b7a-NA^Ya7McNV_7R;E!oHC%U/-<;1=Gt#))CgW4>)R=(
^5Ji>%\VY]A&n!QNk,os4^p?19WXc.VXJuAqLAt*q*f&>`l]Ak>hkYM8fAEglM1kM#='BX%93+
YI'[,I[o`/9X'HJnj(>KaY0Wb5'tjYOX<3WB^mB]AB3Q&V+6>Z$;p!nMfL]ABbISf[fad>>:l(
]AA*5lUtO^4N=4gU!%+D&j\$>4,pV#+DH+4%:r]APB."OQ"jB9k[&!B$1#"Gn26brkAKE@UL3j
',OSXoXX#c51RQGl@=!hG>=2eQLZISolGpU!Be8ReO0CZ_aANaB7nsm+;MieiCCk8$E=a@Hq
Mc*W?S\K9@uX55X5!;[K#D+RqBO^bfgK3/eRT:]Anm_hOP\K!"0*Ar\CD3!=Z`[a0M,fr0K2>
G(m.VoQ`.\o!T#B0j,7(>1nXQ;HJPZ'j-_<s/\u(7kfC]Aomu.9(N^f$?_!lUnYtl@'q$OjR.
c(#AiUr#G)s[-tm?%W/,9&C2<U$&]A,'K^Ph"/_1Z?<_kV68mU'2`nT6Pd%I:odO<S5&=5oBl
=56"l\g;Q09P@`-XCLBr/Iq.$$9QTInaF<t!o0Je';RGQJ&''H@RCM;&?\"/IaYF+tei(j%J
6uTBc/?.C(D>#JcC[!EqlBKJ3F>BTj+_q$?IU7i&MX2J^"F',IchD(1Z`']A4MS[TU;Ue+]A3<
t@=dDZ,q\0m?*'B^k3O^(WC$*OB6FeXqj;]A;I<1?H^&ip7V3;BRnaA%eoC9ed$0c!1$=Qc/N
f5R<6[$:0g04#B1D)J5!h,BF!E!I'Ka,MB5O]A^>LRG)eAdG)5kD'it-uFj*Lr28Dmf3_QBB=
m4a^`E-CW1&<\b]A]AWY]A_q-Z9ko-*_Qla"k$/[`6!T#%OAoNMAk@MjA6=9b^g:bB]AMk2Z*'rR
ktN6Y!F*":(<_cNJMpma,Tq]A)`Zc@LY2]A=:hj,LesLiE-OXemk_n[V&)]ADF%IR;+Kfli&f&q
<_#:Wq.$Mu\kLmr!.QO@U<?ZFeTp=\)qBCs4e"-,pDLFS\>O9?QF%R"EIR)J>iA0HQ8-H6<i
T>AhkZB8,0f-8Lt;^cB*8QG6#r[mjW'V6l+:H7aNX&+S?-j$"TJ?Rrt,1+.2d2.4n6ef(sQO
cIH`]A/`4m@nX78/?FS9$lF7(&!FfCsMn!0`:@fubfTO*teDMK2t7daaT6*bk6a2<75NKQsAr
9nf/mrfFP6-*++EK$!'>-Q<`W=i5.0cRQ,Po\N*j&'rbW&i:A[ETXpgs7J]ACBSkGp_r2m>KY
:Xb_0L%<K@A;V00^l*RoJ.E9A'V/2oa@VbY`PW$9W69nqu:^j5A2g*4%?*/8n2`#+"Nnr8J`
qsV%^*7jaS7r@)F#"uBcEGOLU'_>oGp@SL&53gk>?nB_qlI9;q6Y/M(!K3?u)^6gomesR@&o
@f_;IQ*Q4>o=QKe+[cO[:B(eP?uud^^U4eis:tbK-_pP$#Vj#SfP)>c18srQR$`s7&Z>71Us
O%;8=+!lt3f+l-h<b-'C/pFd#*-;</-p[;[h+'@@ZI*YibI:hCrmI4e*eGD1A-P&cVP/k^Db
r$0pH%CdrH`:[R?[eB??(SUR:O4[S!NrBZ81;QO(7*5'LA9%hN@o(lq(``jKf4-f)]AmL#aNU
/L5*K"^DJ@R5XKq$VA(E>QAV*]A;'79JSThB%8`ZuH+j307tI[%$$P^aWDLAGP<!l*0nh"oN^
J(+]AkeLsXFAZCo5`Tcn1ou1rjLK/Zh=F$4s>eD"c'%q7n'V+*djh`dbnK$100U)?H!1Ws(%e
`e/#Y$e84fI,rDQ+`59u#j!7WBQg"X08B`*[>q=V^(ri3&"SV9$=tGb%,[0b/<6V50)BrbtH
3GC75_peVBE'=a3`@<48\>2@)<X!*3DWc]A+rG,+@k>,H?ER9ZdaEo.qXj$,_-V#l,&]A-5[fR
<!t6*l",:H"C#YMX"i6U9I)q_=c3L[Ja%=RNrPpEt\Z7"!9A@It/1;5+)9Y*hLF?e+$(1i>L
f8@(!0uk2g>9jH(ZKFF9YGSqNo3TllP48,n9N$Q%9\0<-CTOkpG@FW?@)"m#"L/W$O"n8m#>
^TMb;__+g_4rWXRY%((g*SJP@ZNcupm@U:C<Y86X#,g89'XO%$d1t+oQ\R)gQ(iXAJV[>"nC
,gYeMFF\j)fS`e)l(6;>(2Ag#1Ai-ctqVR]ApkANW=.D^7i%p44*"0\s(CC)>3AtG!pBrD]AnE
g^P>RI8R25)d$3]A#W%fr?/?)=W*^TlQ4Z+hQ6G:8+hRSa%BRJ3m1RlSZc#%+PdF;/a/b@@NV
GnTFP'p.mY*qf,<N_GBF'4>^f.Ui*:-+C6W.:/l%5.H'dYfJ#.5LDNaj$;W^N1S+qJhpR$%+
i68p;j_)NX4pp1_N=Mmt%bLMeoAPilb(;X;kHmY'i+2qSDm-\dS":Y9ZrPSHB=X#b\88X3Z*
dL_T65McsGqOM]A\mg1=Z![FF8YYQX]A;"+:DPEcg_&K_I,TBnGRX:qo4f.1DG-5B4;$)8!r8#
68Kd@14dXK6T";9e&;%D806cl8Ss_IS<WVXnJfB*WhAWF>bf>\AD@3A@TsK$N\=3JM02^?P.
Z*J[Rf01ph\IgAnQHM#l6"H/Du<X?n8Og?4d(:0/5]Au?#te4YB4M4rc55OJKrAZK9;*b):N3
hM_YK&.E&PW1Sg(SV.<LfK/5Dao'M1h%_epM;N[Lih,QfkFj7_$;LD(p`E8h\&EBDPc+l-bU
Hu6^2@#<*/NnlU/E/RnYK:rVRh%S.p3dAa#N)QCWhE_E&E[Z(-QYqU\d'jIKHi-:k*C<CHVP
ega=+<b*IC+L\l%E1u.hO=dR)98qh4f3CSdWn]A(":#d,5XSd"o73$gP5H`f]A=+B1>fZ+b;^q
GJ0[305DE**8\/d>@s#><%F7&+RG.J)6um^\pp_Z4&@:n[X9:&M8j,I1h$/^]AN/aH$N8`iKg
js26C[%jam/7_/+c>:jt]AT2gSZ,ku(WLU&A1Ig]An.2:Rsi=D&Z_EIfp8X.aV4kA:W+6Mo(YX
K#j,dP_6/[%RdcZNt^-'Y:sZ5';fQ/^@=6hXm8S"HF\]A+p.tW`[Cm>:,SAjibkr[SNgUY:\N
PT#FgFDaWWf7`X.?bBJ)sN;FC+=6Q7*UX^5`bRS,hSk3NMWgI>Vr?nt)f1O,O6iG/Gl5[U":
bVV,W0I8>.4t-[>qcF"WVI%@<a,"cD>!\S3;>6iuZ-ri=pgL=89SG[ShA^]AU.30%f6#e+W4b
$IgVSl2.9MgV.8K!u93\jr1TnEL&>m@,W$1H)WSD]A';RgB;3p4o!>_l1?F,hS+g)&!+UeSm"
T)\.i1Khq]AuJ?1=0bK?<A/jc6#4Kj,?Y>k$-NDI.!'a0@"e9?K&T1*_,s)?XnnMYC<E)_Lta
Q_?C^]AnTO'!Y-%qf"Tm?dO0fR_Ho3_bt?ja]AkIKG;o:g/H2'XRr,R9A_/oO,hNp8eRl<b%Q;
jL?C*9YpUKjXlc9K?)0m;"$T@6h@[P/3?fa4&\A0&IR6HHn06M=dfeGUPBXFU:Xdq8<$aZ,o
O^&GTrI"fpf1V&NhgG"P9abH..D$P+%KiWDN]AboCZ*G3HL"?28RArZrhJtNCk61m9#.H5_35
Z=<F=Fl,/X*,E]AfKJ)#j)uFK/.i5a<IDaC.mg^^!K(s/,\2u8iQrp2oF:m/McF/j0TqpE`%H
;DM#<2>^`qDBdr.Lbf>cD]A;o&HciDW[peP'?_5s$'@DWk!dn<Zf]A[)bn9Xqt(rj'sAq,g6c9
DAjL/tH!hVj1m?)>AYaO55o\\aqp6Eun3-_THhF)Eu@'mdF16)Qt9*Zb6_!f23L_>u+mc'W[
/]A5C.Vc&6KPq'IZ($/^ia@[/fm9`;*i#I'o#[:S=6p(EQa#3^+8RWtH.c5)Tc-k_nfSUY.*T
`M6,,;PbW(R+Q[<TpWq:<_3=)&rU(s@SdcB@5W(Jl]A%0(/m*$polb@%?8sRfgnmIQ/#C%N-W
mT[iVNG)V575HPI%o[NPkUVS/o*'fSp4&#?LlXc\&cEa.-HHBf_">@&tTU^<U;jWaIQ/lU')
h[h*e;NC]A@M/r/g\.@Z3G6WI6g=Z)>^QXk"9UC\/2\u.+e1[q9#aL0V=4D5;q+.^>od;E>p5
%1HEes,.a!bjoIoQ<XR64iCb7sBb[/8&EuJ^t>WE.sF\a['iA(R$Qn,Dt$ch2f0SA_!J?N6P
(r'Z#sRda+:XMHJ#]A7HCL\'"cJ,A+_SWG!T7($ld*@)lL=$IS,6,]A[,G_8IF6q9tq\io99a/
.S?*@39mR'T=?I@N#fOIWbBL5;W[lFhu4K2UMYD[@ls=23A;"oWg9c:#?m75&D>)63V(]AhaE
mu3,=;J3gSZ.9>f`dr&cckQE4a[Uc-2p+$R"(k[50[QJtsVgW@Go&!533kHlc/a;\fOckW?O
Q3q;u+Q/AE-bb-RK96-"CjPR\[>FGQ@OF>]ArPe;9WIc7!b&#W>"9e6(nY5Rs@[q]AE!eWlnN?
<e_Y;\qK\Du0.hLIRu2GBcp2#d.cM:R>c9j?l&ge"[n%jI5WRo>id8I0hqpL1cOGrXOa`!jr
Gtks8]A/8:OJn-So+bDc_q.[;/QmC[ACu=?)*8(VI@Z8%kTCjE74nDi'X9Kg=i/6;:i>Yf`ej
]A-Rg%o>Y$[>(%FD"m:ie2pW^:=$qmGnPZ<jJ!KJ<FPK_TDK(q`$J^th^aeZ$4"`-Sl`F%:8F
3Wk*p;2.H8^=A=/Z8/kj7^8+%SK!eZoc`^tVk!RDdHq&Q]A`15jib;9npAaIe!cCo2ElL-`%&
n%t6;2*F!lo+0d%!4Y^0C+%s49ABIarnCHAY&VdF`j62[91"N#`X]A64q+7j<'e;Q(#'66,5M
F)K4Lf05hZNr0=^*Nd_AqOd6+h?&VN90b.IGf=:D:bG_(ohG4RSgJp+563]A4O&9%jZ`OZkfk
1V>,.^Nd=&_K7(D..m3^$;NfJ92m%XGR<D1EM!#d]A:K;"I"C9FC5PTj&o["6Y,P('89K0OV7
oFjR?8X)a"K\-[]A50rKJlqcRb\YCX?5PAsV_^"F-T:0.,2\9&,[G]A*AIa.)`!-W$@X4]Ap`>J
W0*QOhb!b-a+Y8,t<CM2+E8XjLmqGK`Y`+b*qTRpq+qL>?.l/2#8(c6Xu?a24G!"I0u7NYpg
Mrc%rOXgArPGtdh^BYnl)eo,ClpVT=JG41)Ok32@7SO5S3NZuO*LaPL?EC\'4M$YAHph1'94
WTb`R.fa`Qn[V=<fmp^*?&n"m)?5I`:u&SKFc=4(E-J1csJ3Varq>t;jn$_=kXmM$)(;!I$%
opQ@!fC:rmYK;E.h[a$=3*hn*TqYpAZS5iN:h3od8U,&,hOA;nld:aWR#J2eLb_5$LQhRBsN
rTh`N@ZoMpBnGn#"/ko8!;=FP]AuaQC`Y^:o[e^]A[5+b+4L+O6ob^ShQTRu881Yna76Oh@28R
/qk(;@p7[D*FVHrgshpD4nI?RTA)'Zsnb:_A#;6H/2d1(^Y^r'hbl&9RcJ2b9&?+i_a]A6YP!
N^e64\#DXWVR2.KRk%1]A(_O5?Mnj=T3'5O!Y'#pfK@LRu`*ppj&RRGQ2Jl]AI\2T%tI1Tl`6V
@Td6D>iTcdnHMGd22?hSpUI6-P89oe.OnR/[]AR'&_PL3@oLMN`u[(_G^tSH;HZ8NaXr*<P's
=E,CGQ(H/WbCgL^M;VK>"%`J,9q*[d127:FX6V//B+&8S_>W5&SqR7TN5.`s"ufPq=M=Pq"1
Jo7m\d4W__?)V1jXNZ(*oP\S5Qo"e7>19N=I]A!4W/k@u+XoAW(p)mr=e%nBRB7>T+Zgh/fB3
)b.B>Gis@2%)g:l@A:n_g-:+0rD1'aOnf;AXbnefcf(F^Plrhbg/d#FnUN>;E8^`8@'>9)-'
Z=:dXZeq#YiG)*_E8e.^-Th@,?e(TWSfRX9j30UuK+.fiEIl#N6<q/A9BFSK0gOq5adTs#Yn
#?,Jl\H$q3S4S)7H7o.]AdkCg$HI4=AUMXeF$:np*_o;e/IX-mKl"-nn[Qq?Pb4PiDM&M3b2L
+u1CRLKmVN?jpAOW)`c5\&'4Z%r.)I-QdZS-TMo'/He8#A3_9dMtSo9).-jJrOB/XGQDuBIO
!UEc_KW0Oq4`(pH;>4Y_):mKh(3b;+go8K/U-f8]AKcCV8UF,i``/u(C=;Jk(;"natkKV4ilI
iC:5663`o_kIM!)TTG&5RL-_M@>#ZXBi/B>Ie52L@k'2RK\;IrC&!c5_47'J3:^'r37&Jb@a
o1tOp<d-KYT%E"LL8+AfCS=HYja%ZoiI$]AUo3Q70gI'::P>j:@Sb.>\%_<Yh@'L).![67U"k
sVm5]AWhZcetqJ^-?@*gkbl-]Aqj4B@AcU_Wb>R^#(BZ(Im]ApP+KLb_c4%AbR8[(P&q!AmYjoC
VNjmaVii&=F(S7-.8V2q'n^bS2VBs-p^:^k(hRotLAU7&;oaRV=1B_g(('OHhU,Sr6qX9,q4
gY^4S2$Rh_V()uN_-_m-AZ33I$#m&>!4RId0kl(R%sBJfC=a_rS_q!C)cCn2R3[o")U_o\^*
iUa_2:2:h6npbBurYbW_..ae9o;g&eNAJP0:J@1J>YGdPKYq2>W>D\BqDJ/IV*_OKt($r<BX
]AP9uM1aT[@V"r_aY?3aU1Ph(CBL:KD)$ndX;@519'\aJ[C%3-*(AC\$6(o,2'e\>R`-jh]Ak;
25M2AG2KhQ'f@5%d$VV0*3P,qN.=GiE^AnBOW;!gAM3B[//B$VP%MI)-CkTM(okdq^Xi>=_i
,T:TS'X?M(-fdPJ9If?h3nkLfGE)$%k@f0]AM*0/Lif0bR0X7Qhk$DR2%'iDam!%U@1L"S:Kt
EBb71%r^[8$W?6+]AtgXpa&S,M+aS&C,(92i%pr%o#pYEH+7++o-o_tH[mL,bYq%\!aV(TPk-
n=^1*%W[2F?W@s#R(PkJFs8\MLrQOmsNf;)9JIKiN,:>eCS(DBMdccNg`@b&G.03H.(*1j6f
2KnYGnK@C-4d$+_Q8N[t5/lt0iU(_[(Tmn3<gVu)#(EC5lS:W<"A*abjluZ0>$qc;tN:]AVH7
]Asq13@Vf.odh@s2F3XM:J1B<f9]AWH\]At.%mE'"43:trAs82fu~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
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
<BoundsAttr x="0" y="526" width="444" height="36"/>
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
<WidgetID widgetID="eef68379-8991-4092-823e-43de4421337f"/>
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
<![CDATA[432000,1008000,432000,1295400,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900,576000,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[1440000,1440000,1440000,1440000,1440000,1440000,1440000,720000,720000,720000,720000,1440000,720000,1440000,720000,576000,0,2743200,720000,1440000,720000,2743200,720000,720000,1440000,720000,1440000,720000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="1" cs="3" s="0">
<O>
<![CDATA[同期月累计]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="当前决策报表对象1">
<JavaScript class="com.fr.form.main.FormHyperlink">
<JavaScript class="com.fr.form.main.FormHyperlink">
<Parameters>
<Parameter>
<Attributes name="p2"/>
<O>
<![CDATA[2]]></O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<realateName realateValue="report0_c" animateType="none"/>
<linkType type="1"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="15" percent="50" topLeft="true" topRight="false" bottomLeft="true" bottomRight="false"/>
</CellOptionalAttrHolder>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$p2 = 2]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-1"/>
</HighlightAction>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-14701083"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="12" r="1" cs="3" s="0">
<O>
<![CDATA[同期全年]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="当前决策报表对象1">
<JavaScript class="com.fr.form.main.FormHyperlink">
<JavaScript class="com.fr.form.main.FormHyperlink">
<Parameters>
<Parameter>
<Attributes name="p2"/>
<O>
<![CDATA[1]]></O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<realateName realateValue="report0_c" animateType="none"/>
<linkType type="1"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="15" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$p2 = 1]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-1"/>
</HighlightAction>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-14701083"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="0" r="3" cs="3" s="1">
<O>
<![CDATA[维修成本(万元)\\n飞行小时]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="3" cs="4" s="2">
<O>
<![CDATA[小时成本]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="4" cs="16" rs="16">
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
<AxisRange minValue="=0"/>
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
<Background name="ColorBackground" color="-9390107"/>
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
<AxisRange minValue="=0"/>
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
<Background name="ColorBackground" color="-11487581"/>
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
<Background name="ColorBackground" color="-1196643"/>
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
<AxisRange minValue="=0"/>
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
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="堆积和坐标轴2">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="0" stacked="false" percentStacked="false" stackID="堆积和坐标轴2"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
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
<![CDATA[飞行小时与维修成本]]></Name>
</TableData>
<CategoryName value="年份"/>
<ChartSummaryColumn name="维修成本万元" function="com.fr.data.util.function.NoneFunction" customName="维修成本(万元)"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[飞行小时与维修成本]]></Name>
</TableData>
<CategoryName value="年份"/>
<ChartSummaryColumn name="飞行小时" function="com.fr.data.util.function.NoneFunction" customName="飞行小时(小时)"/>
<ChartSummaryColumn name="小时成本" function="com.fr.data.util.function.NoneFunction" customName="小时成本(元/小时)"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="9df1bc62-0b83-4235-a527-ac948c93ed17"/>
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
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="17" r="4" rs="16">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$p2 != 1]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性2]]></Name>
<Condition class="com.fr.data.condition.ListCondition"/>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ColWidthHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="0" r="20" cs="16" rs="16">
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
<AxisRange minValue="=0"/>
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
<Background name="ColorBackground" color="-9390107"/>
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
<AxisRange minValue="=0"/>
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
<Background name="ColorBackground" color="-11487581"/>
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
<Background name="ColorBackground" color="-1196643"/>
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
<AxisRange minValue="=0"/>
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
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="堆积和坐标轴2">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="0" stacked="false" percentStacked="false" stackID="堆积和坐标轴2"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
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
<![CDATA[飞行小时与维修成本2]]></Name>
</TableData>
<CategoryName value="年份"/>
<ChartSummaryColumn name="维修成本万元" function="com.fr.data.util.function.NoneFunction" customName="维修成本(万元)"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[飞行小时与维修成本2]]></Name>
</TableData>
<CategoryName value="年份"/>
<ChartSummaryColumn name="飞行小时" function="com.fr.data.util.function.NoneFunction" customName="飞行小时(小时)"/>
<ChartSummaryColumn name="小时成本" function="com.fr.data.util.function.NoneFunction" customName="小时成本(元/小时)"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="f44f6d88-b4bd-4b99-9019-dd6a97bff0c3"/>
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
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="17" r="20" rs="16">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$p2 != 2]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性2]]></Name>
<Condition class="com.fr.data.condition.ListCondition"/>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ColWidthHighlightAction"/>
</Highlight>
</HighlightList>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border>
<Top style="1" color="-14701083"/>
<Bottom style="1" color="-14701083"/>
<Left style="1" color="-14701083"/>
<Right style="1" color="-14701083"/>
</Border>
</Style>
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
<![CDATA[m(@UCP?6L&MR@1,<ie%_!STRgK7H3tMA)_Y1<:l*<$OdKK?=l6;/&9aK$#X.Lr]Au+1(U?MLe
NXRF+>+E,QtuK":1+\UpXRsqjruE>N_NaIVTtqLG&7Fp>5O_h:Hf<45@/%Du-$/['5XRd!)B
`SZi_>g&_m"g+<6J<o@o7lbK2\6HeOfT/^R+ON\Q3MK]At-O.k/nTf@bU/+`WNRqpnFYtH[Gm
kh3O"a+/oM_t9Vk;W#DDn_4>^\-=R;6fJ,n[UQh"&9L<8$(S$^3011o$@n^?[j;IAD<5Va.s
dU!]AG>9lY^odQi8KLA>"i8R6-fElRM8qA\(h19LM1._p+'D-FM(F`]A;nj$X.SG-e2_BS[Z>d
b07nrTb<2_RV?ZAY>iDFRafV?IZ^-"n=2j=D1P_qJgK!Mq`_98Z!8oN)XEb8Ish8%I':3,Ep
qb"`G49sDLVAR%<oI'NYCHcWINeE5Fbp#LnG/L]AeJ<$L%Bn#SumfJL$u:gFtEt::]As4Kmgd#
WSi##h07G0m3<L^ROcd,u[2Oj]A8,G8t)EJJVOc2,<#A_PES:_]Ar?2<JW10F>,Sdta?^HHbi6
O\/i!o8Q]Ah%,r-dI<$D-`fEA_lYL=78.HTaLPKP5:IQFaZujEmm[2h9Am(eOT`k.`C2:Ni2f
auUSlH3$YbY-`>E)$b;JWO_ZOK9;HlLA0jGs_K_M*oZNLZ:Z#+_m>/gon->0=?iZAAQ2G5<h
Gj3%4A?a,CO8Y_%Cms3_5De!*1^`T5XD$*GM`rR`>[NLG@7acAe]AtR9^Go;/$'n-Z^@"kJkJ
uG$QQ]AFc3;#H.U$J4@&`S8G\<usP=$"r>WQ1_Xh7[mL\uLXpfIn_\[+JZU)#B?M39Lq[*AlD
s0QBTSd8=iNLZn36@!rTR$OHbGn_dNR$b>.6QEflJh9*TU$SZI5^%O`.1OapTkBM"V>>&*\Y
m3.W[h/0YTm1nd_a$P"b)9oJn15M&.9>Zf]Ai7f++l>h<XlA7VRZpmu>GA)8a8iL.-7P9?m7X
.'B8XP]Aj.`VsDki8.&1<F[Eu/^]A`,PSkV_c:=#Js^1XV[diojSp,EO>L]AWejg6KA*GMFWjkb
8!H-Yg,0)N-fJmB@9@3IH/>Y@Ii2ZG]Ai%LO$Hu[ra_KW`A@;^NYMdNG4k7R&<%;8=5SJ>B^-
ij?H+EBciLSfi_K,d["hH\sCkbpla^:a=?SkN?h^^our)!#kTnGmqgrMXf%YalUbq!#J6-\i
(kfd5GDDke]A\9L@1"%r!W]As7c9PNR;ogg,eJAEC_c[YA$N8s9n,dQ_Ui]A^UGJlr_e"7<]A?]Af
fEY(JTKFY6osM#+l1UX)[fQpUrQR.`AT0>X,eA4QGp\bS.+.ZXMD7]AO>t:lWBOAu[&lKd&.@
sehFFUrJQc&=>aOX)i&J*V9t-0!LA#>1hc!*T@R*WPh(n4`(IH-'D+K`r_qdWmUE1"6^*H%H
[:#q*"JLH0$,o'gkoV$'2X?U,Ei/gS77M3qdZ8`Bgj29NH5cSV#lI"3,@"O`[s'1&Xfe]Au/C
tnG&9Kt[gkCm"YS:lJM[Y6A+M\VHV$mdN<s>t50Dl4f4HTt(/0U?.DoTXK^1nc\Spq/;q78l
U5kbeH+JL*JS`EVO1ZnkS%S39pXOc:TRq'NW&7(=*Y)&:PT4sF$?EFLU)mmct;MN(_b[O5t-
F@UGJdH:g!cSRUf_,pD)0bJ]A3DD!;,uMD7Z8g,U5!JVA1KZugg,/<'DuC$S(9fR5_9>smAAE
31_?A8/>C7VhN7)_g7@j<T/8s<([[j@^f),C);]A?\7/tF1.L0=%AX*1t-kWgH@[^nMle_iu_
Wf79]Ab>e_Rh)#_bj^`]A#6G+l*,M#L"7(5Ks`FU/X:6,ZE%l$?fahYI9>4ih^hE`EVh34n;M^
I$=PrYW/[45V#N8uP!1Jqqo8#qa\_rI0\g9tJOC/m5E-0R[&]AGi\]ACW5[><oN4J'jccu]AY^H
o?b\6QIe6=FV$N3j[_8KRB=0>7)XQ(%1PR)poCooXL^OkLKm:EA68Hk_9kNKk+l4sHZB*j<8
SGJNLe3"KH9(,S!hr:Gfp.]ANl4nFYM!s1uR;GD-+2ID*E6tP8L(U!JFmQpZ";V[0[Od/>Q-s
.GkE8R\QJ_8fDV+W,d8<qF/@f*!-bfas@qEKQ1\tC(`&Z/[C%!,L@l*84(ZMWA_;6*<AKTB@
Dku-nK/77hL+@*gM&,"J++gHQqj2LSp_;r%GJCLdQ&'+<p;(cm'VIkiJ%f0(T>.-"_i+J8A,
;=un;BKmS%-TgI=QqU)ZiGVpZ1DP(1ll<-^mJ?MiY6^+8D=>%/Y;6V"e<jFU?Wt3!1/_FuW<
S\k\sbO1:\o2GO&J+8^QKZ*%L#Cf$GDr9'O:#l"Q/XJ<PX!2'bgPegtuAD93`#3pqF5d+^P9
k<FsLpa:+]A.*IRNTDRL;ejrdkYAMS-U8)7^'^R3g,\41(Z]A&j*BqN/Z/j3dLqgSc2UF0aN:?
Gng]AYgriFeUj?/4ZD@7P(6jfa2/rpXKFI.Lu!\uT<)O#a5eX)M,RBEV.oUF+Sf-Q7HZb.*_p
gAjTepcj/a,YdeF[!5%d5U*YXZ,JM]ADgmQmD1#^p'I*_7F;2a[^csYHA0(5o*Ur:->Z%Dgn@
ar18`D]A=Cn/[GE;>9,lff-B9i+5GUa&1rs3<SAf7M.H#LhC^el,)Z:m;meB%oA4SujfXcXXM
s@N@Y2f!inaJQWQGQHElciD[aBDD"!c;+TPgAk:mR0s=HLTIipBSp/kO$TaN=hV'5t=?X&_]A
>eB[G0nc_5N",>`kO3sN>3:6WteT0mA[M`0Z"?%(Rju7Zh#;deQ/+cFt7_M[X&,?:ct0&gn4
r0bUR8uBD7p&b@`A;M/[$&\AV_5()dji(6!`V6>!f%eu]A7N'>`+`ZA6k;Rf>Xm*3s*?K&r<5
?uW<?k'[6O07:D8S&E2$ESG6kKo*:\a@!*GlCcM__laKrT?>pMcOdc$qRYO[/1+SNLLAa!,&
'rS'-e(l+2]A`IYS"q;Tosir0\q@5-705XnQ*kJhacCnTU]AXcO?:aW1q<&59t[U/HnYfaGhl(
]ADqku\I=("./82^,=qXH5ig=P%NnDOLb@7!cb,eqhlG3qKDti0X7\/,n0/##UDWI\BH3<Y2m
WND(0CRhub\kh>AUJ8($Zhb*))?6dFSan6SR!e^)*-]Au)QtG4>mADf.Tsj$p3;YC[5YqDK*m
Nt-g*sG]AfHeT,&Y!#m_S]A_h(TJ[6UXYB<^t)f4K1fC:+=H%/BS\Nc=j`/NO74og0KnPn*aFt
%@'WQ=rK3"M06@]AV$C9"0Vp'8fJ)@o/84a\4J!ct_u<?99IQ9fWk(K'qpt9GSm>5^iI3kC!_
cO#iL\9Y/U3`Q5Qb6Ncql<t3mj(V)ERGd:bgbFYZ(&:"F`Qf&u`ELQp4XmZn5)\=h;p(q;,"
.d6N-@]AgE4/riK<X#O*u$3lPedM'Mf>`p`TH*T#\-]Atns6gJ0jaNVE`to,UI6-\eD2Y.nm8!
%>Uc7(Ki.Mh68?8[uiRFuaI)bB9^NjC=g]AXuba*9STe1Pf*go]A=c]AbRj)$>j5PQkR":67-^G
S9d3gh%Jj)<SGVLSMT=Q^r^A*V]AWIbQ$;KLjXK:PG;Nc@M<=&Z\'?90QY:R=.0jQ]AI;H<q%=
3GPL<L#`pA_uN)qdaI.H0)cPTrC80\e.L:.o<WoX*&D^8Y<[:1.8Elp4/>CIP^O-WX+]Aq#3J
d]A.=Hpb@Fl)7QWCq%,0:ie'c<8^aPbS1ScrOj!ZbQrtJ&GhBZr[imrPI(b0gBF-3"(E;^OPN
U('tYCrHBR1@0E31CSlC##iM[e#8OcVTPaib\FZO>rpe<>dL[b:4g`T>6K[1`YpJ$\2#fa6+
H!5m<OnUbP/K_nJL[78?7"a$C3O7`91XFk&eKq)J#hnN5LbVH]Ar1fF"&p&G4ZA*Ye_5o]ApKQ
ZAJH''>qB(H+p&@8M?_i$"j4Gb>nt1Zp+!/LB1KOK>@(GSD;B,5c^P!dBG`h+.B_Eu;qp4Vl
ja?-j3Z3301RDeFkI\Wd;lra)b<'tQ>Q,D'16<kks8&G%VoXEg2%3!W06\-4]A9nDG*KKMk=Q
ZUW&$IdX,)Q@aF,dUeYAha]A4P9J<;U=:]A]A'94Y"Wh6OXsP9ed?i1nj<n1ON;3TnF$UHE1WA4
ZG#:BRs6Lh\@_c#7N"_sk;P(GeXZ$'#)!AD$n/53s`'PIHHfqEG.dk':.8&!LXV(=!T"8V&2
fKBj>ddrREE&;bWtTL826mGBde<$pDJ38nrAfc1r%mt%HJ0A51!f[;h/SV0rRKg%^dK3]A60L
UG>$b9l/ilRqWLcD'>Ft]A)e<pZ5*b`2)hQPeR$#HK,XO\1c:B(@"F0#Eud1b*-\rKCnf=.ut
h,;e5VH!?*cWFlBBspLEq!meqYIkK@YBCn$IGMgLe!_mh6R_`/oSeV`efpZN#$-R[p.V6>PN
)>"FT^0)LIb3C:Z^LG6CAjAQt%dCoUq1m'Xt)p>CEZP_r\GnQ!)\(i-m1_Kg``6`Mo:F/HJ(
bBg(Ok]AMig,-&A[qn^>I=hDe%mDE"8qbOH:racYOlZgC2QEOTMI5PBp?P9!;,A.[>b<CMW=d
sRTt8IIJ:U.[8\AB0YiM7-J2T)P(mT-7PJn1Fq`HjsR$fR<:*^FF3WrE/O*.>\ahm"mXO^3-
WYCXgEsKnNd1E>MJL9ri,jA)fFhBiiA%,t+n">=h]A?$a14m^(-3#rGSG=Rr7TZ7PtbD@K<s\
p%tf31atel/Qf^[NBY[&]AJZ#WSKBOB5cum]AD2cs^mnl8gh8c[BQoI8XrN6@u1"2cG$Osh+Ks
R0=m!jNG:4gf^__(R'gbRDg;%Db@*l!5JSt\t[7`O7ELcKj8gKH:+2(^7UA/K48>-5[\EPRg
*`G&YH5;PrV;lCn$[6`d9s45EaeeQ;4Q,/(pZ1.23-ZL?t[B04OSrM%`LO62=N\tOH,ukZZU
p7@+b8Vd)^T4#.&M)M)/0ju34!b%p1DE-8&1TiX/]A!mDn-'pacK)X.[F\Xl)VkuJJQ`Qq>H]A
0E;+25c:Bg,u0r!nIUgnH4nRR=UZYIVUBP$mnHf2/Rl?PfQ)(K:OZ"-fHDf\b/Y$d!,U<#8%
H`(uE$q7VYkan\\+60rX9QuVGSX,:AcHPOfi0nVa0G2>eT)1-r<UPS_d$+q:8si.r^>WD,+M
d(bcngDFe+`3dT$=6[C=E7EO2Yd7^@RM!oM[iXk8^c"Pl^&ri;UjdGU-EID/d_0f8`MK>@3T
IggtH_&#S?O-[e3M3T$@X]A-=Xbmd@c$Ju:TI?8dB)`ot@=0U_@%qGm.UO6<<ULqG34i%T#u(
)>1q%Tbcj[:emZTt)/Rj*t3"qSY?HO]A=TRV9,+1%`LpD'A!iS0T$YNs"U.f#7/T`a_l0(SpP
\O`b/'pBZ:&-Im*Zn(76XfjfYjce,_4^*&"]AA\#Fp,U^<p%k"DL[`>(PlQ?TT^o=-k.W=Hl1
'n"]A<J#cF*9B$"7:=1D_-8hq*!`'sPFhT5[B"=-LoaE%;oXnlYF\&E1X!oTn\B!!HK_bS^C9
V3Q"$%HPAg?@>aPpYUC:j8-6.t$RDd7WA@]A7+UrJkZ(WE<!QoBPFCT,OtR8n6lpW]A*/E;\0`
+X!t+)<t^Q%jN!m,DHmW^ZB62CH^$d2Q:>;46('6qr-XC8,U9MCg+efP.F(RU+G9>*qD!5Pj
R-%Xl#+uOq"UG9bBr6fE#Z!RE\e+foaJBUS0b$0B5bq%i5-d^TiKp%&VtI+!p;Zk?a?cPLl6
JpZZ]A'"pS]AI3mUMgPAu=RcS#C*1Pa3!cboE=MaPZQ.M)j\#"bb2rbd">8p'&K6o8dCc1#!#3
U\R+A`DrtV;?*3E``RJs2JAfJRaTLAl+Mu/2<sotVS]Ac<.c#K13!!ZARaU!<5NV.H`9UqZ"0
HpME-gp5I:ZHKGhRYMEp_dADjtU_*V+R,V$+448N!=2.\tRL`XAAI)(C-R2i]AVo#k;'S.A3%
O\ed3#]Ak]A6,m81=Q.@a:Yh5j+Nd3-[8Q1;&7^caDWO,JC&J5:0'81*RYq2gA__/fi8.F%"gh
hs"lLeUPB9eM/(7F?!!&B$a)BS,=$AT?b!eD%Ye-Wa5'3_8*3[0U!r\A[;spMWjVHN/C.9fb
]AN0ItJWh!1d_B4+2j(`XH<lQGI[XTmJ*Maetf'0,526.=h#;hT3fOUO[EoG5"_0.$U+W!&,=
AK]AE9_PD`;-XGr(?$3pi[4"Hpr-u!5,ICd[Ep!Kjg9:3<[0_H9b<jD&3#t&1#If$\RJXn:YN
Mh&Du]Anif,!8@!SUR;N?e=0jPPRg=.;9C>NuuR^2WnEcdp9.&\l%XbWq2)-a*J^ga^t_8o)6
(U!)n_I9t98*6mb?"J9f]A.7oJ>*k(:e4E%(1+2nlI9B@Ah&4,R\IZkPSDf#Ef&Hi'6LE(d_(
e@\1[4(u@_u0L<Y2bYNag>u>NdQWKOE+%5HY9P.$u^[b6:,Qc*PgrkjP_\RfNT<9[7s!@\&[
]A)/oWm4iCt7J$GI.Yf^(.uH72V[lO>lkr!fYUK0#H]As7l?PFrQM`op.%P%)Q8s3n9n!!fmV?
qc8cb0QeP%h7%`!^KWfO,a:B/.Z(-oT)4aT=/5rGCP1A%ddEP@MLG0l"fDt>ip=M#UIX>]AD%
+E?K$WLoEI!f35]Au<H[<l.L.,/Koh@U[f5n9TH(3utcp(GmVOg/<ac/0o?$Y5a1nY_Z/=?RI
8rGl(980j,.\'C7hRp:!CMu7TEDfBFLAX'M<:02N>6\h@1qmI+!.Nl(@-5nqIpnedfOH<30]A
K;o@A88HAMgY1g28^LKHu=Ml@-e,+b_?@nI&9IG&1'As7i2$RE_8IlfH*1E`Q$YcNl7r!Y8[
&l;%#S1[4s0CoO:[\]AKEecK$Z6<^@UgB,+']AG'(25.BQa<eZYpG%lHUQn(\!NsANVuuf`t8"
s-&E[J`%/#fQqa6AEeqco^Begcbj5orB>\+NFD=r^AEN%&)/+.2e9]AMYo2pJ`X*NN&%lj)Wh
9uEc>RFV-JLf">+aQ!NjIcT!("'".M,:knTfk"%CA,Q.)_TMm_LT`g<$&s]AdC+e)`cJ*45N"
J"1d7#?Jj%DCa=ep/AH#?:1E4JCKNr8Sf%$:<`gF'n<CFo*9Th->Z'[K6(R$-ko1(dK$4e."
JjQ[Do:'6s&TEqCS@Y1!t<?UVpoO5gI?sT,^_7e9D[[Rk=.Z7j"bN&@^FEII<B86#i>I?B66
FRr,@2YgNF8sShB@%kpnV')e6l73HNN+!TU(mD:9M,]AF>ZEa.B(D40dduNlXY#D3uT+T^TKV
je+bBp1E_-g)`_rO;*01f+"m'mcHS(-"mRm1]ARs=]Aku4TKMApG!2^*=0S+Re[/'0l_<#YI`,
JUYYeWH>2pNF6)W=Q+2-_\J7r<14a*,SFRtMPQDB+$-(::P_\X$["pR4jT%d<_`?4^!mh,5%
Ih=/(-/82!.Ij4?iI<)cqVWtIId,GYR6%/i^=mEk'8>i1!3>L>q=s3YZ^7*k8Fe$(1\O5SGJ
3X<RQl+(=H<V,oD/k=*"Qhr+Q1E"7S'VKR-@uX3CmBX#F7=X!<PW--=UuU+l?Vnoc"8-+!2S
DM%LRDd[FgDZ=mYL!gpV*^T$V(=SE4S`eNdNd?-XN:Ojn/V:bs0WGStY7B\m,adZ!OJ*LiYC
#u%_<`D9<'EK?d@7X@AN%f12^0gX&ARr>D7a=A.phPRR'Figc9(2%&7&4mVjARj\o*]Ao&1":
)/1;XM2/,G4.i'Ubt.^V2#=^[L%#2K=\,1'O*9iUHiJ]Ahq`lhGAmLN&&S;C6)\Ga8GX8+^ZA
]Ar[Y*HHl>(BI_\#AAep8.SdsodHn?TN(aCpnb,p"8c[VD86B9#s&_TW8]APD;KdA0`/j)X9o+
_AKUZtcdmA^o%+Ps\n3=fs!#qB9\;2BePuJX/FI'qDUlGep\W\k%]ApB*M+s8S/*p$["$3^Tc
rY4lGFi?fXAj=sD=72Q@_ss+qV?Qf5,p+2?D^7#o4qMt\.9Uu.B;0Nf>-)F!LP?gcX7:mB(q
>-c;Cd0(;7X"pUs3gjMF]A5(XI+ZuMPVE3tZ2V>DK*o'"5pPPnGds,?Ik(o>#@+jVZ6<'&C"]A
u<Q1"Zb?duc!rmNHA@/aRZt;,,'4]A7(2+/9VOJ'7@AjC@[+P@KOtG)#sL?iVO</KQB"\,RFb
3gks-$7_[3!^`>bqF\t&"4SIRM@B"i<kN!!Rmn1P;/>4Dc"HlJ5W0t&^eDoZj4N$Zu@=H$U`
1H'<[/CY]AmtJhmRQUfqgR1tR>;iY>JGgQpELSR_?m[I^eBsK?ESgNa<KdSQMEbcF09gHh?]AU
2I4"ksu,8LHql#B\,&;3AghOV\'=1f>`h#:5GjCHWh#E)3XDKdJNE:\hD[L7U[+NlB(7oBi#
TXl+#Z10a46/QBUCjh1hk&X@LM%r=F0cB-:FbOUl:O*bM<&T4Vq68P2LqL)bW%6o.WhB"((0
NYed$=YICD=\rMUUlG$\GpEbWJqB;qP*>Mr^_$\Z^/Sa/mg!07pC7P*<DTr%dLa<1t]A\hOnk
,_l^IPK#<&cjF#`U.A\XSW5r@Eon2k6Dobo%G]A:><R',&u<FC17TN&/$PW=ZMRtg.[f\DA/Q
,br$dNPMqD3V`B22!u5>!]A4Z4G$Wj2]Ah'#G_&#K`2agFGo!Ks0m7@bQ#TJ(n8Z)QQ=uUgLb^
qFY:/6'>4?^/b@U7IGh28p&lIiXcKlJFqA7=reFd1h-0p#*6L^t&_@-m@&*S&he""khocRu!
h1,Snr:i[8]AfNr/2QWbg=Lq'd7Y,?qXNR6BRcH&Di4VHXA\CJ+]AU7,W"ic[=OoB[DeNb]A75c
J:GDd:8GhV9aZHBZ=.qb;--O^B$F[QAVfe^Z@G\,H;5LA/piB)88IDa^`JQR-o;<Nh.:@5,S
,Qo)4>iMNKZL-D+nC/EIQPS/dCB=&EJirPB02GOGm>%E+/-"fOTQns)d2UZQTGd8YtIJ5W))
oN[\gL]Al0l6na8Y&pS#FUR%O':(*UY+4T&f)H7V?6/\[liV<e`Nf&cOj&Ag4+H"rf_=e#WEp
kMX)$0BhV5>Iml,fap350#)Ws0Z1#>unDe.mUi-JMFej$i%,!pB)`#AaGNCVoR=_H@h$UHP8
qXkteB8EhF"-jaZBN\jDPVl?`+fX>eK!Ya&7Vck+^475k9Ze;h=_^V"N5M25IiEJ'RAN"V7[
_WFYQ%-s),j`40*G#B^T@,`M9="NoF1PbYaLTB^4&4`_TL!fabI'C;gVq)+U`(//ep`2INqO
&j8;^<aknFE]A7*B92'^u/Z92Y:$JX[1'<co_MkP;e_ltq(gpR6>4F+AcgTbL&;a(Isffi'A\
BobSmka"?_[D$VG1`hrO^hGDq<]A9<4\;u00W\u:m)t9=d_@MWMc.,U#Wdpm0AZTTifG+o&c]A
ht16AL`kG4>lr0(00,\S*>1^!;;1m$jTRdA2!Ydt(XQDa%7K*#)S`m2gUoW,,#Z7CAf-sgQ-
*Lr0ngLbX8ink_KoaES!#BG;L.#?aa0h_?8M]A#8Y\M%Up!=n3-pV>jKBh7sIVqqrYHM>U(as
mDSTD>#+2srla@Vg$4DQh^+)Q<TI_uhB"d'6!`Bcp$G[IQcT1d3<n^ek*n&CHf,12=2PnLV#
]AZ]A3h@O]AI,jppCo_n+b,?aM.DDH8jF[LkW6/>]Ar2IJ?:7om+D)m!#L*K'CL9#`grJ4oP1\i/
U2Q(jSB0fa"7K<.-CN8io'?;SmL=?S;bP`F"--EW@;(CIFmb72s0-e"SC>,)Rt)\_t\oPm8*
05h4]AW]A0(+HtV''qKh7i3>25)\*ne5\r!a.O\>NP.A&R`]A/^^mH&;s/m=V4#QaqZNO\)b(N,
H=YMI?P]AUZfcqHW5QJ>@,n.G0Xa=8\$T*N:<ZX,e3Qqn7HK%6'U#EbPN$WSaTlP;]Ar&IY*eH
jM#ji]A]A082bFpro><=M%50NU&2$n5%qF?T6n%6aW&rRnDO8BJ2gZX%6C9+2DAbM8G#=5S'1f
]A+XDTqW3NE<B)hdHL?;jjW&B%,oL6)RgOGgbcn<JgJ`NTuDV]AY?/=h6!FnrQC+fNp0b]Apgqc
b#d8>>G/Nq95ut!iYaGVVq2Hr8s#$MZsCN0"bg!&Zuc1osorM=<+W;>"n9mLm!!qfVBI?Dq2
BMC7]A-2LBEfoH;*Wd'n>kYo:J3E5nnDL1#1<H#K_VV=pnWlKd6a-:I>D:Z6S=YT\TX/.TI52
aD4,Vk[(mt,I-]AiNHZ08r%p8l7=Y#O(PNBVYC&C,*%*Pgs2e/,Ld/-C_`d%5/XN=$S3g9BJJ
/6AlO=<'b*#]Ar/QmO?T7Bmk"XL61:+aU&g"*,+MFAH`#>qHeH44,!#eKLIHb8P$[rP:i;n_X
^)T:AF2)[/mm*8DAojil`Vc[Im+QgEA-!_M,ne/#'6ag)rqQBi;WdiD+3X197YqF)G/TZ^hN
@Wf`#iL-BY0`88"DqUnZjSe]A.bEWE#eH;*p8K@phs-;P"(:mgMN*jO?'17Db&73#7*2Qa3!L
,h_f,#B0K1WI.<bK<..o_V_QpXF`E^;pR6)m6j)')t!7Mk2olDji-up9U#&6CK\I;YgeWNsi
0lJlsC9!/o:t#sJq6]A:6#\)XF+VL&?Y-hZjhZ$*k\kM9\hKbn+deQcU9QU^8@7??C;[Q?Ic,
'b"Z,?,L=6D3Y4ltDed5JXG[-XH78*Pl=SoiEm6XK]A0&G<if^2ZWr^->g'A3Em2n?JoO+ND,
h3OR7G71fF@EVYW:!$ud6,f@kM:+Y/?H9oBX%Ss;Ks0LkijPM,iN^"_BFB@+AjEKi3!%H\@Y
Qn*(;F>H>d>ho]A2OC4@_0ah6=F.-@T3\"MorX%I?7U/nlPi[LRq%AIH%fen]AOQiDo5+rAq,:
AJ]AeY$1N#YLcdPKWA)(8*O%OkOW9\#:I&EAXg%70jP/J7TH;In"CS=u1&E`!H/mY`Jtrdl*`
)J$&ig?gAInqSf![SG^8SU3"JjTn4!5Leo.KZhp%G^7tT0M6Z7c\a$ekr01gM>Er[Nnh"DDA
^Fg(N[Eu]A4#nUYU-gV6\d$Zcg3%F$s$u8NW*,1:_PaO5UQEUGZjQl/:U21T1Wa:^!s\5oDr-
@L9nK8dljL6<Mh0P?X<RX*%>PEAWVIGdncBY+e@$t,G_GA@NmCDN<=T'Aks=sI)E>+g86.C@
.qIMp1;q4:islLNK_!-aj6ueWcBVC1^,Z.Pdb7YT>osn[N9B2^k'J7\$qp;"(PTtD<Jq\R3P
[e[u;HEO+Wo@JU=Y^KIn6cp`c?ipeks<$V2Q[=me%f2TOM15jcg]A,kI;dlGFYE(R,*GgNesK
=?!6/K-_=V,7@A3L^AI6r-mn/m8Etc5Cn.+-:BXE7U:"bn0hqN2>]A:&5he)CW8S>^)#=ATX)
#hPgfel727h.f<]Ahs[a;Eo$ep4(]A1:Up+!%76rkm>PUgp.\J4RP]AK)*OiWcU_1P/3j[cGKtS
&-oNDk.69iV?M$N&mk)iYq_+$)r5-"OSOo%aMV"q`m-XP$>.f*%iB*gFION>(KUmVtS''![]A
i]AO80:^93R@X:\PsCXJ.9g'4lsGaa^]APQuhVAtjQ&aHZYC>7#E7Mg#6,WNr%(^hli+[Fgbfo
/E:kYT1ma/q)G.F9)[6%R4SK;;Jn('2X;3YeI!l&ka:ucJ7J!V!ijZK=,E>uA?e'!pJ<`>j.
ZW^\uL=,i_"otDeX,Nq9$6Q:'F^&/[C+9cjN:&X*SG6\N-%t-oGU)3MWZBBnX,A!4X0'X.E1
'QJHX2PdCmD%PSLc`E-5ft!EL.s0.3L.i0Ffndd=;lO^7;^.<E*VWMN_^#HPrRVb5!\&UpGn
rOq4b[9?M-=IBu._iJs5J9J4KG>`Z?M78ZMV:tW;n?X4;sL-Br"qB@p&mbR!7BqH$fiW,e:q
j.@FcCW9+kF`G0ooO"d@<R<!jB!sOC5lHSR0-bkFb]AQ,(SYe2Zd]AHSq2j@J^4cVR>@RT[kGp
-LP^em^E5/DP6mFKuJLn0k'KGrG/^eZK]AgCI=O4Y6t-2!o'jM(bn9F93Y`/\4j<p*jCppk?*
f;-oI5'@ZZILb7!'M&l*P:WdaLgf#)!p*,ao:l*d!3bBXD9#0m>JHqik!erGQF]AF:dDoTKn#
Zl\\cM(RA2T^QHbW.<>Sf302Yn=o[g2@;1,I0s84=aAYPcDCR)Vd$#2XX%i"7"gR#G3i;&A!
b?t,k#RfTo6>P`FbH1:5V!I`F/8K>S^;9HZ&.88d]ArJ_K;9,FO.\b:nFe2<^YmebK66qVWjM
.B<>@GPs9g#BSoZjT%>hcl\h3HA!db;#r=:2/D^5%eW#FI8uSf2OH+;8fmHbOs+5SCG4N)bC
cnpn1iejd-7t=AS4V-'8%k"CU/F"HN3Cq22+JpAlg-+E8!&1i&_'Wia=e.fiQP&"kg,7V>T`
LG$rhraTCUR9Q/`,YQ/HHZ1A0.T+F>pKkHrAKWqu8[qCN#1#,\n=9Gj9;ENlA7HC@pOQUTCV
?ag>JAMZ#l_XX14BoUelM[f9^B-JrQV*oCDm_8P731laZqfl$NOE5!o0R]AU/igS>SLGhQ_RP
<`-FulH4YTb/Y<rjl9V\oDp@NJUMUdFP\b9j_t_=F!7f(Z$71Xl=5ma@&[UKilP&++lQOU&2
a57_(t]A4=*PpSjNldfG#NePl?<lOJN@iM@dK[94T9O1#>h8O;]A`:%#HCJ0.o^X"SgA]ACAPef
u[U`T-nprIdFdc<gC;*hl]A^@Y`q6l/N9J`K[d3Fh(P/Gp\[&,8$.\_nRVi#G=]A^SQ!flGS0H
!AI&njc3AL++J>1Q+#oofh+->UTLH#J"8&,992<B+`NbsJr5%i^\Jpsju[@>0j(GRnBjXLk0
T3a%,!@s4!CA$lHpq=1+2;^Wn=_U2IO]A[RTfC52N9OV]AJ63o%`k"Gb`-Tn4_H@FjMEfg5"_\
>^l(=Ik#qS^m&<8u'7=P%pj9T/aT1RD`Ng5YFa5C`1'$B^L<&SKj8SQVk>EREl(+D\JIMUsa
g:M<OVVoH^bTZol"h(,4Zu84G>]ADjG]A_JPH?\%\j^mAt7%f;,PmkL^3A.'qdM&W9F`hh6$\X
$,h&"k[;t-\'ET+Gq_RJTL(sUO7+t\Ob8339ekUgqNF)T1&gljffLl(Y9P7Cu"@%`OqJfkL\
.O,HN)BNln);of@GYC_4\ceu(fMKH?ibQ/h%*B"S72i%HNiK5?a`Ia5:bU%<d08BH^qUgCcR
"5=`)C@HZVe-$KU([RN&$1%>6T\913`P%TVj<q:X[Zbf'.\Y.#/XX]AcbD\Q35*/EliQa[VC(
1&r!b>)]AL%?/cFBE&Q,RY=c#gI1.l6c$L@?Jpg?%rg<1jIW.Uo3%"I0fR"&A3_Bi+oJdauTS
SB_/2WIXRZU2ft]A;G/MeJtr/Xi]AB;S;NbQA5%)p>O&SdBc/ad/a+-E]AWgOXSFOZ+fZsCOnJt
G_*fBseN<[[0Q\W&>?<V4]A=l::TC`s^G54pB^Z$Nqt!6b\H\ZG&H(>/Th,PF^DeNT:7<Gqq7
d_/'''W*T'KHcf!4TsZDR\U?k7$PjLI\Qi]A4pFh.aQ;X9OZW`']A&IU*\'4dq1b$jE_n"as-A
kZP7c_qo6B_LH8lf=ahJtWF"gD6\UjWCMCR%UJRWN8]A$>Pa$hsS7"8R)ZoX4u1?<PCG=)'#>
U4)h]A1p?NLCNGfU6&&+gH6`q:26>G[q!2f;YBs#E@/Pgb&MU7e2?N7Bl*ROpe,Cp=hPRUg,`
6IYio-X"r/*JUVG=)N@SV0mpW!+]A\V_:pM4H%R8n8RHc`,_!+Zgr,FR99>R,Yr<.hdq,H[%p
d.E)VMeGum7>"o`Q6TX"P!N#!S^I\$.tW!"mS&=b^@K]A$;rKp2T8KA&AYi:@c79--bVrFa$J
j]Aogl'>/L(,JZ]AO>bQ`F8HoA'=*@k\nN/UNCIYE?@m>E803Ast%1;@\p^&@aM*Q@!rh7-!_=
A0bFsI;tRNaTV'C'CZ@n,$`BgTO/\FdqsiWXH8ksN]ARAP$sa*2E]AY[9DL]AI_K2Qg]AQ)'(0RY
L=he0FiAZA(YR=m*N"KF`OEXe%6-j>N.f1A69Rp+T@,Y^[>=b'N&F4>i@)0_%4du+9JOiG>n
WHAR.%n>5O_d(*Rm]AF:A#McjoWp:N)HLt;@Mk^/_A5KJ\[K$-I3hOXk<YefW]Ai+6PX_0=ohl
BSpl1m2X70F;0/(I5Jl4M@N;70OhE$U:HF&;pKjd]AQV65-k8!9-]A"j=$[?$fZ!lHA;N#'[8;
0^6!MEJ,t@a4>8g8#Lu?@,0]A;;8"Ka.U$7ZR\NF6kDKGl6c((!Q`OO+CnOcDgFZgVI?@ZE_;
kfN[<#;k2)Jq%fc*BIR=@H;e0?-G,P9Z(P"HkV9P.Rm$\#d\XM_(fZe2EXS=3nT@C*mk)$5u
[#ZU(FMmdlNEpV1jBeo!WIFUpZXNtpJ(E[+$-D9PEBe:[K`8W5rSW5fbJ)$rl?5;@(`"[T!/
8h]AK<c+QCD9_?N:\8=]A+I4nrRVmc+VU@dn!Q)&Y*h>3&?iImR[_EO@!WD6!TlrUe/d>-6:g5
9Y`IH"9L#$#-QU%;hJgAfuE`^EIjeA[]A?jSR\SWE:<bB.&fd9F;%q7#X'_7h/.oW_5^W39YW
F%mALp*ltB+Pf*GY6K"u\dYq4"2>s@io7BTOoh/$aA3YZ*M42J`]A&>!AP"]A,5r)2jRPp\4TP
B*QSQ@C&&gXsR>6o;+*^F$Hi_oCti"+KO#X?+f39T[f,V8BX<E0d3%/*HAL=JhnIoX(]A+Hcq
XFgs<:2S7Q&V\oSn.9-ojRk7"/7iF#Tjn68!8#EW/4&:DDNVRL6H=2GdfZPkHgZQ%.s7dau#
tR*?&*cn25g`tGIJ29,;FmgaZ+s3>gZQaV%q8T-d/A=[L$TZWRfU#U,DT+tBR:&:2sBtE="j
"NQWs1JEr6UP4R^+)[C%gle-apD<>":Cpa5rUbgn!rkRXP97Q$W1OZ2_8#dDY,>B@h`>S&mA
eX@6XA!*']AETl>KbteSFU+64ol3cNQ=56a$:rU@:i8WnpmF<M)kiWPsY+SLX5%4):Pgo[R>M
\_!S'MTO8MC5((`#GVWu+Uf'&;BMME]A>VQe]AAg3/<BSiZ32F,YMhpOnfVaZ)H<(e>;9>.g,c
*;1]A,Z4i%bI-2k`*!+XmY5AP0'D3231l']AfBJ(0Qo0S(aDdO',DUfWuh^)n:%?/UtYccTE^$
TYHUK+o1>HCtWFJp7=cbd39T5^*BP]A/d/8XU5`ZXng!,gQ'!<Y6h0T%gK*fk2]AQV!U&5kTRs
`&H4-el*3'kD>5Fpsr]AkS>;j;jW]Ac4?KG1hPn0G?9'O@D<#Rh3]As<81%=8kqt#6`GkI%Om9h
7ZJJgX4@$-1ReL!NT]Ak_g_Z#TXdq"f7CiDQP6CQ(,]ATM4OY2g39aLGiW26oNn9Ckm_'\0Smm
kt!9Je"!-LJVi]ApEO2e^h7;6,dfY)?MOmFVdd1QXQ:4Dq^WtZHP@0DCi1BJ%7P:J_2XR2U]Au
[?$W()'<ThI4^$i5hYu$D%Rtab)6jY@67$ot`:SBsLhBClO6?8R5JI3("L`*`[#SCV_\EOm/
Imo+%0p_b6PqCH-/R-OZ7!k\Am\Y\rsmN1mq#nTq"^V$_]A,WOquIJb0>Ci=,*O?P#GiueeSb
RbT&#?rm!`3`Je&W'2Sp&R50_98'Fc2Pki;g3nGcaT!D>l:R=thZ\A7Fr$Nh[J$s[?CRM)%>
.W;g.!$DJ@E"&G^8<@cNb42n66Tl_L%!DISDt'K1=M-ebPj6@Z#nsM_3fDfnOi\m;$T.p/mQ
4b7F2@QaQGfV9\NGT)c%Hljq\aEHQ<>(+DS3=;@u^,pOdV0Q7C+Od]A^CK&\_NCUDbce!^+BY
NG4>BrqV$+l5JqJFor$@=4AO]AF,9^=Wokq*:fR?)raQ*#3R)aJ!ZsM'1[+m9*kOfN&(aR]Ap+
(EV19pa7kBCOX4!9Y2]A*1h-/CFXq!V+aSqWC42fUn^Cufm#S"GpQO0$Q)F'e]A/Vlh/i6[7d'
CGU,XO8H&$bS.:i@d*<K:5Bdhf,gRD+[=Xqu@I&AmL]A<6tJA@k4*r1&dkBrT-r7*OiqfT8I1
Jqa6WgXX7>)0(e^:G,OIPS$H.&dQ0%nCKc"e.\X`2?'YF9gaCCHQ>9/k;%d^(a59S=3(lioB
1n]AD4S/VLho)mHc7,E(5#g</]AogV?*nrAlu"kZknXgI!i@D1CT#&722d0:<R))$S.>D21>__
u.lj_K;9AZ_IUd?9+)\j7MMnUa++a49>e9'ILHR1gmuNn03m!p/VFa=??L#63(&5B9H*=8gL
Z?_*9QQ15WT/&['Y/PqpUa^WJ>EA'<t,n#59t%`s,TWF%;,?7%;(sDoTq^5%9FdCa1%2hX<A
g$.fF^!A21A!e%I!Fd'<ba`=cF(6BHXFhJE1Y&uiiiM(Uh'OUOf!YQ@=C5ThK%bC_;g;95eN
Z#hk/<t7)9gpm@6Wf>Sg=f^dOI&B2.9KgL(a%?imHa']A^!'dje;<l+,2%Q)A%*ED"<*X[FT3
mie'fGbE^k+=j@o;Co\eTYEY7/`Zc1ct:`d8m<8>Pr]A6`#pdFC]A70<.>SW63-]A7`H6\"FJKO
+%:=To(C+/r?``W&9F)oA/.k\7gO4fYZLA<E4<Yb)`Mp1m+-V\TQAhpp_3W6RL]A=EDA9;!\J
')<29%&/dja<n+l]AX&`IJnKj0&ZLZ:1,JciWL8V&WpU>A)uPM<9^RM\O.<scKdDO,5>t5IiN
%paCUi-.H=L):]AO!Z.p>F)W!`+P'";S!2!M$t!OB.l]Ak`LsAKH33AuG%X5&ed#E,k1$dXMpB
f9b>aBY?tNk\GMlf`BNQC0'`nlK8N!T7I(K!69H(ouktc97O(T3T##qTqk`0_i8[$&EF@i6b
71uC9h3O5&kl4F4rPkf\^7dc,iY9``u=2!I-D)&*7ej?Rt0sMS,[h2J`s_mD6n.1HKB#j2u]A
&'<Tb+`nfH5pBNbD<`M,\TW_]AeIMeb(4r]AB@+Q`XSdL+t$[']A*+#bKbB#tR-IB4$k?I?u*qO
!0-AY)F)t4hLN^S5p&#1Gs?LZXhp19Amm)qtk`qP7Y'9Vgs("U]ApVTS)WF8H0ah[5\V-NO%a
o=B;CaXB1)ZQIRelP=&_RdmtQ$T:>kFY;D@^_gidk]A4aETaU`0XaL+'V298f!":GV/SbZq>7
?LfJ/FH;!1;1-l8SW"1PV(H1--e%2A`oKbdSP<urm"=$]AN$sDBDQ!#GW\Hf-,F4D$csT(AIO
ga6`T8)sB+@']AYO?toKKajQ'h44e2\IGE04_is-eA*qC3E=,5>c)(*M"]AumQ)C.W@:O=fp-u
O@[>nZ;dal\Dd9)h/oR!$(J05]AeLUZ-PVcd4F@"298aH=p14"W262H%ZWO+\O8RjhK!VT>)F
MlCCIUNYB?[4Gq9pOBb_[!^ma6)a!"J:B"UIG%>QD*+.>+L8N#_:2Zkf:N*bO04u^YI5dn,c
qT-3l11jJfL*V&9Csl5JkXU.#f(7n`9K,FE%8P.ZCEkl:&R[hYA1j8uO@BR]AP`IR,I$6E@cu
%;KXXMm7PG08fHu"Z!u\j"1n"Aq7\-,c=S?Tse*3S!<s$\qRV*8IGkK>,d6@/PWX2lAeq@G2
,0s\T9,l<<cA`di(eJ&&#O"-HA:m'GCo2OKaXI"lRpD]A`\%-+#(=)A1YGDL58F$bcpFE^,aE
/)u[L=FM+OrAQh_)T_=!h2Yi4le1gRNN3W@D@2O49?$j=HrU!mDSfD>Z/r%Q3_#8EpCkgYYr
Thd:g7#+TPlP^[f)s-7T@\#.a'k#]A!mXH<QtMI?WPJ@PAuXR_Q-FXf8,sLbaf:ZI!MsM?=qO
?hhM^Lkc]A*E_->Z.;)cb3&j$+oa<cCPu_H`B(qaQ=3$PPaZ9oCQqa(T/nYTQ+P,i3`JErl>-
p0,Xr#=q'?UYA3Ga8ap.>gjs*eLrOh*(Z:6aGKZUTjLO_mfmIa`,]A!NM!iIC3"_8S%HCUk8:
"\(Aj'MXPK,"mbhefh,`i)r;WHfA!Xi:Y[e\sjg?_h/a0YGIJX\W%d>gsV*q=tX;=04-V1J&
$fQ!@.qAh+L6o?CR>dGUS$-/Ct?_%pV5n>Z(5Ua!D29C;(pBl+^Am1uEJfK80%Ve"IrcZE=H
S3#;*7eW,GYZnUs&%DS]A;?Ra@1(qI@"=Y0<+qSV_k06?N-MdP%R#%LIWo_]Aq=;*U.-B=AG&h
!VZ'JTHoM95(.qsX6BF4C>lp0217=H\Qc/tsN(L@*[aRA_Ngk"3CU9(r;C898f>9c]ALi36_1
Fu`XO^uE*Y1`pr<3eJm;O_%&]AT]AgRcPE_3.ApiS.[F33_Z03VSq1U3K?PMLC]AS\5<Xn$06Gr
_b=mYUfm42,<qL"^P9*NKQ!.eaic*jRQTPa8^EhEC!e'd/jcfDILRK+&t`*`4%'gE7kX$/Nu
R;\b#3@.!mhL0k`*eRTtt<kMsrYcQR.dW@SY*DAh";L@D']Ak@Ei^I?"I]A\i-59c1#^m-<jkg
hnMEboO]AHE=K2FM2dc]Aj!3m^Fn]A>OFf>bHjdr#=9CWG%a3'@\,EkeV[jm!N.J=e?PFR5n0Z#
&dAM0-1pm8;;+=hbO*<^L(>i+Qh9^LDNlF@PlZ0!W34I!E1S>4`fqJ%]Ahe2BM'dTq'Qg32l4
)g#M&p5-/[k-4$sp8g$<W[2X?A.;5a@F7U#pJ?Ip$Ygeu[%/""%+8g37?G^?m6>"Q$@k%j`B
C__#_LB,L#st@eHWA&=8fc=*Sq<kNdl(RaM&*T$a-)p+LW?L<4Dm,D7ntNaB;dSC(E4tJmeD
Zr`-TIPIsj>?[mS]A2pgh=0<"@)PZ]A#1U!Od(H3"TF\`A^Ps1H#jlk+S4T'a$XH.'1qBdA!oK
_QkUbmM@5!9SuEU5ADV-Zd2j?lJ&NIB)2upH/TPPE]A,#56+G.rXb.b7JM"a;Qk):1ihY8gsf
s!9N6t.:![p+s+feM5V.+-?<%N+Q.MH(`XeBp@M$SpmrV3(h:e]A$/@cSOrckHO3NZ0oKJ-Xr
U'0/Ok@NGl9A21J.0Ke@?/!1lhKso9VKWK&gOhe\ONHI*HlA""9,^L18u^#&]A)$`cW[jI.h1
@-<8h(94R7e,DMcXS0m@dQSh!^1Bo,0V)2iUmP9tb4%o]A2_I;D*&HGnb=C`WM%7q;up70c]A_
2MJ$t,r><(bXR60pDqYhG5/.<0Xus@$AZH##@?a#F-[lD$>5iREg7T7!1FQlG(BD=m3s!o09
6TUI\V8(s(65o?(CaSJAJT)ST\=(PB">WH9-/<p9TqNBf([E]AnmK8`"elX.:')e,(uJk.62]A
([+NGP+7#r`]A.5_n0Oq#lM9d<)_0@^a'5I@[#mU;\3<GR]A4*hT&"[PhMW]AFF.A8ZE(7Eq1Nm
)j^:FK_?BG,']A&u5M",>P$biHSml`2f^5'&/<_o^L-1O68/ZVtKVhaJ:9HsL+K'F"JOAmPU<
tVe<8?O_nZhjFh;78SoC_PPJr`\;:*gUh,0\jt;'@SG_Bo03C9&\F[pe5"_PUCn2eZ!/4[ZA
]AL+k7XVL.R#`_:0h1cha]A^#qJ,4c&1GmO87'"#A`@]AKZW]AlKqd!+"pk@gI=(P9I024ZhDStC
dNlm;`VbuFr.qR5^]A]A3:WY.T;*:E_<7_K$ru</!KUquLr26$RW`n!&6`r0",>7canq+kKqna
MXaDu;i]Ab9el1ZQsLo-$'den[646_*>rP'n-AAL"Z[?.b_?UahlJ!;N8ikts,1l(H4+/Gp\-
reC;Vfb3(9@*8E;ds?d;mcI%_^u_NJ8(2nFl;`OZj#9NA1Z^f!UiQ#0Y^/=i[Xh+^gNtRE*=
5Iq)(g.cT#)sk[d+/XrhklV0jK>6/kP)<@@ljon(WPP]A_0-U3n?3#i@33mP]AjNq\EDB![ptq
B;SnEMd9/5l*=.&nhUbdCXb%T![l8<9ec4\l)S"*74>sTn0C;S8"#bJ7(iHMoXu&_fBdlo^g
uCDXs#H"lYT';F_G"gTdt+)aiVkS3i<c`@b)_8:reD[1ql1.0)5cu(7#C$XHJ=q[\9N@8S26
h-(=sJ,D.lS7@X7G!cA%#hAcQTmo?UpXJ\V'#E5)i!nXD]A';/:5UKk.AJInpF!bm%uhrb@]A5
QP'f$NcX9qM!Eh9o`dsUA'M^9Q+oR,Y;j^aO);)_#0X)"_/e$*T>LrJmQ+nJ@dUg6b(:<JS[
1rh9.a'FnLI8ir?+,aiZ*IEBPin=)d6g]AS'SU$7;(E;mL+C]AiOi:#Z`/qHkc.U>@]A$;eb`-!
2LW7?JmZF7Qe@+72n9,=7,@2:/0,:o-_jMruH!ORKlbK(mVft2sJnq2-T_DIE9p6c4:TQ<C3
[DQ^s4WSYlWjc(U5F;t8?.;cPMFl<"s.O#Otp\E*S)X??QN?q<,sp_fIbMYgTP&tMX6f!0%#
?gW6]A]AQn#Seb<7!7R+S<=HIpTK"2cKoW/AXP&=T89imAcftnb[+=9g5dKXojmRq[Pt5B=(*Q
cU.cM^d#e-AiPbu]A]Ad>_X*1P&Oo(]A%`3FXmA&3B'r/ntIk)W6aVlp_;1gYQZL3R_).'9re?i
n%=7G$Mb!mdeq;k1E9=U7'4EV]AUijjIUajP"8sT?u9>m,ucg^sMDO0L<pBnl@!u"gTrBEU[.
F:Xj&^ATj_:eOq#G9=-3f[[Yme7IjZHF3EAZ3hmnE#`8%TlRqMXbUYD%\2f&u;e_Ig`6f.Pq
*"_3f<</=lJn(Fk^_1l^e19"Wt.*0Cr4%Na?Y$Q`gK'"/#p^6Gl,[Th"!_71<@`ca_f*6iH$
k&*<g,&O&;12P,\$MAs-XHpK*\3r5$nc:mBT']AXXoR&Kq]A')Srdd$VatL/U2*;<\aV4OH93-
2pNCK@H%dSTZ=J>%9Z7TD)8&N$VWpL3:;s2;.+ZW%;!RRlV)5b;3:,)YO@'2&3=6r1(B4e#^
s50\4;n:g?G=aS@U#-EmE+.1F4]A*o,GpW/OkZW%LWsKc3k9h)kBP^70=3t8%tmUHMN!)[VLl
!l<nFQSBRYLf9XYiU[/:lUG*1(4-R-q0767FqBWFiDOlo)A<,":-+_X690m*oa<Xh\0cL_(I
E7BIji@tTTN2bcXBA=e#jrE-m%tjND`ZBE>clB.cJ^gir3&,/'1s\0Q/5*3ji'!BBg^!U'[$
d:nlFg:80%Ksr$05YAqVUIpt*&"mqkT[0-$Zf>]A:tg2OS)S+[9+Dr\tntZ17e+V"(1;[I`-:
3IO8eb8f'"1[Jp*[C_gXQKrNtCIdWO%]ANX&9SL\Z1[)HK9$@u'*I?ZM(o2(-Q$2?[Z=blFXE
BN4DY(KB?(=\rIDEsHaemFgH#.lil$%=TJ>6aYQIi(akjKbl!RaX::SRYkqeH!^=Wrc8Cg:4
_W@jmOQ^h$S:ikah3Ar)8]APM\fHGYI!1,C6u:.t-Zj(ieSJ7)Gma^C@MLjWJ]ATR@:=UelT]Ai
%YmjD"4/IJ/-Eaf+aB?Z2cZ%%b<p;cs40De*O%7I:Y=V+UcQ/OVADL[SJHFD29"gpeNm+Bpt
7i\3'k=@Ou$L`pBWjZ["adU\*-r`<kON'p-)g`V!NtN%Ahp&eCS]ABFMZ'Y7b]AH\/01qlGo?c
L[1G@W^:@gFi$P9,"='N"dp_k9`02'T4V!(q;^M='B1khH[$m@'UjG<La"FTiP:+eR.^<Y[c
-Z="ZuXD*th$ipeVbgQG'?`X^\e7JtqN#:XJ1C&"p^,@eL#Oc*)iQ5PD[4N7R:u:]Al[eea%i
>9saN&F&Ao[6col@KK8W>QnKn`NPbsK5[W9@#kFd2^AIiWC2B;BhRqNoP8-aF2r84KBn,h>_
UGjjl0A8tn7G>I;@DkZ4/EF;]Ad1Z#^TiLc%R:(T$q.ZXG-@2oieP=/4PLr@iY'M2Y/[1M]A[$
+RSr)F'q1X9IEaqTr@bTSn[I4fhs%*1skQrXUSZ[2(WfSbojkLGr7@6%nFpU$%R#aa0TE1)5
FG/5',CH+#-(n+MHs4#@@>uk"m+M^,:2DXK'6?o(#6/;oTP*(R?rJCO6b1*'"#a?\#,>YP"1
a/9fRXc1h8aWs,eE\LqQFJ4-C:!G>+L]AbO?3H<UDQb%HgNXs9Nu=<2>KZ[9'D^u00_h(E_ar
iAOu*p2KcPLgFYpV!#<QdcZdL=<pZah9iVeDf-d/AFMD]ABP$tCr^936F0*AksA1gGq[G]A:Op
>a%?=QK3/MPD:W;_Yfg(E2m1%(FpboShcA&g6*IAK[i@>[oRphi9_!#a,<';2'pYDhlEGHk[
\U_ULl&VgYVi+%,>U\WJ2,0t9%%O#+d,6WMi9WqFNNJD;D5o9PjiX8)_O,ZFn0>2Df@>LVq/
>e5<nl%R$Qk?4Oq)9Z&uAI?[k3-oqh#p;A$Znqb<4T6=g0*iC>=!.%g&#oG`6C)MrQhZM&&f
FF"#D`UJd1:1=?@F>OMH#!pm"["Z)[ZYpQ&i5oqZ<2ajuTV=KC8&`49Q>/3g)R-93j6thFi(
Xgb[6=:-1Re3(c9t-[dT9dK@q]A`tQKgM2@df4W2!&s'kCZ_j\f\[UIZOB0_5l6rAc5U&rc-)
Pl$d'pU,Z`%cf7?3LsGF;.<B,>nZ?2sJa'73QcKG9R.u&4l#9KI#FiSGU$mk<5DlbP1eG+5c
$A%^W@Pf3\>Zk:1gq0-SC?]A3h9r4b!:qn+0RY-[tmOrL70noYQ;Tr\g2:C>ar6l=cn&4b@-q
0-_6/EXM$M^AS4Ha<7>a[GSOg7b.=^<CT8h/t"h&VK0#-9*"L_`V]AS5Z]A+OYS]A>(^Ks/e'8[
"W(UJfX+TA$4@nc!@Y+cDMt&+2k,,kEtthPK^\bfaDKai@`lX02?^GNT,"iL=dfKa!N.7#-&
;LZppn0S%0=Gt?m?^8-TQ>3r>u/&'h\4S3)7=>1e=l!rOB$\pVJ,.:f&q;,K4dZ$<A)KNW\I
$\l+T"n!>*Va7<@)q%)aL8e3jgm1uCP)Z3&_5XGX1qjEnp`0,I*4\.bZb-q!Q^ekBgd5i*e(
fYW+d;uYGOXCT5-6d_u,YbQoB\mm\;RKkn"Y/dGn@HY`7a:I%AO8K<k14qTrGs57t^oj!Dp1
p/'c%_(4u=U?ET:35c(t66.L:-?<XlOYcX5!1$nGOaTeY%sbXYQs$G'FZs?7d*Z(Y..aFE]Aj
^1f@,:WunP$h'DLfkBh^sb91p/IA0J6\+s/R"[_gHOgObs1fZ;bTTpQ#pJQ7b5fUCS+br_a,
m=gkYh=1O_TL95>>l8)573&p1fi77`oH6<Pqp876t*mjj$")-M`pb0D_W4kA_MWNW6i$%uh8
&2ipM?:+HV>rlI3UU^7M,Hh2Q,V+lpF,%7T&`8j`WrN>B"rg&3eXqlSmiO4!^hsZnF$L/Hc`
foO=%ZLTa!(Eig0(aD>n&/aDa/i/)NrL8=p$p`i09uj(>bYN2n6IhQ6bmZJ$Ic)Tg7!o:#XH
66bH_*QL=8^eoB]A__CGolPr"GW['$Uocuu$=#T&Xb\h=^p#gHd^4<FJY'.-2`6Om,9j.-*!#
)f^^fPT'I'd/tmdD)hoYOj$pl4fp+giiFZDe)5*g>m%\j%VZ/<hn7+ql`C:M6e5Vo%8fcsIX
,[')V2,nBsK\N6AZWh`rHl#7CCILH4"A'<XF#j]A5]An#l&V?biK__$t2q0(Tcb('>@FdQ@SJ;
]AIhR;p7NS<cb\I*+gQDS\OfW&`S]AckLVS+>FWR;:nkb+'r8+<mF(MdJ9mR9kBdj0-?k[SPPR
"!A)j/F?>0[$8DBM3lSW5`[0`F&VmqW6UmD!4XO5YK:XkO8I+!?:b.(UO!$'Y%F\UCq"C`SK
b-n52!&*182)0XIQP?a4LAL]Ade[,(7DNZqpZ:8X+p1)$bS,CIe:nla2jC7ZV_E:B(dYWtHTa
cuZgM,1ON/,SKq&_"/WM!jJ1ltPdXC78l(Z+gCTs!]AuDrBMMa`hZ_a2*HgkOas\,a4Al/NL2
_EHLS7_+!bL\\*/j;UF\6URq7rMoocJ,=[CdG4_>V`]AEOgmRhM@,A;8t)Y]AC@mqHpp^aC.:p
4qSLNQ&_NB/+<Z@7>a&"'lZJf,'bmko3>b&A^p6N3B!Lm&O#^`euR/N(<9cIsnVM?#p$^\+k
eTE#H#%XLV`f]A/_XW?O$,/=T!d?71g^7WKbZ%:In('aj(\J0uUJum1c;eOoUrnT(I0km]A3`/
a^'>U2UdrZ7deIW="'%aQd#p+<Q>7VTCb?'<Ot12j>pIEmqU+k)m8aHs3_u2G[SuIdW.,@VX
T.s91\$V7"fGQSnjKm+1s#7C/WKR(H)<.]AE$qg9_D'c6@Z,Y6?YC=nGDMg!ElBhP1]AVkhj:W
XFadp>kNOe9^!0aX:h_3-8+j4_;TQ1#^/S+4L&^_BSh[Rk6C)9)Kt7c$f;-6bk-Rl]AVD]A9]As
"G)!I'Zr+%beg3G7U\XkmZs[;5b-p=>jX/NSU&'c/C]A5&fC#sA3hdY^dZ@3K^(pA\KX7T9gQ
c7J:0Fae,qtF^;cKsKS5(nF9"+B[<9iID0]AT__<J5U#bm;_h;!1fon_?$_!>rZnN<a+fG7]AF
#KfDCSYmeemc1m_%"+B6+.>C>rT).N1`$rm(Fi.ZKqM\nU>5]ASTjb##,F;SSo6.$0&-\,2Vm
e/A,$>'BH<>PM9c:D-2FnslI?M7''L$QU1Y.uqHVLG8H\Kd<FJ&0fCCO7r=E`4_1bbJ&nN"]A
:pRpW/SQuB2rV5UTNc+)rb]A.#DQGi;6B_l#1L25$,L>&I6K@K+`-&ptl8$YW>XaV,[lI&g5!
MO+mfkrFGMq!BMe6M5u6.6F^ASc\1L?CE0fOJP%be=i0#M,.9^qG?"cLC8Dh[EBVQo8.me[c
.g8R#f5Wfd8`2O1)]AQC1oOW"'(N,[nf/-+`4re=*3r"_V?(Ca!OYNBXtVoF.UQS^2cmA&=a?
^j6SSG[bfkcY4`\J(bBU%A:2A`nMr6Z8P!pCLSJuZ:H$hRP',%02i6iUKt5fS(0@n3\,kc<m
n'0,FEt)_2$f+\4FKb5$G#f;eHeYl&I'Ih,;t.Zm_4"UY<S(6$RJHd:#b'&dlbFCU;`QV7<R
;9D@pL4mX/(`LW8Y_oU9Klc:n9g.o2,H$.c;=*lf6A3s.4qVCi$I.ruXo.uYpOi*Z^e$l7Kl
Z<HqMUu4Z;JTYD[:skDq2^=WH/&!%O)9iF;[PD\F_@XApVp'iT*<*9#q%ENeP7(GZN^lq8I9
joK%k0e!,bCpEhd!CZ@mkM5MZ:O2Q8RS)k)uG2^<1WZrg4_[IVk;J[;_L21oQ>r7b;aFiYN>
bj^sPWo`+ff\\`2@%"dP`a&KahNcI)?LR->m(R_%W^<2'G>*gD%Ap*@*Kt_H5.Bc,7p%LtoJ
"/<cX]A`"oGZb]AC8OnNm#Aat?_cCNC99l'#[A2-G-<)STBq@M&[M4:D0,\_P.IG]Am6IbF"_rI
)gtf9i0p<3[>]A=`mEJIP1C+4Ym(^L*iNJg-o"jl[-B73b2k1ll4j1R=&8f0_U'rR/[:d*n&e
Q'>MN;L7B\64g,)1PrmXW#`)#jdko8iu5,dbo^(qA0di83+$Z`Y>7lj))H1eSEVgUW["iM:f
P'h]AulP<-DP!3=Vjd6(5ttNcrl_O4Ke\a\rJ*?*e9Ue'LYh<>he!aEBfHKa9%4\Q9\T^.^9C
m5lbKS;[ojN#@$9LSj?=8@pU1]Am8>$D=]Ag<1f6_#\^8e]Al,;KN)[amF,*u0PS(mbrZ:s_jo3
P9r_VQ;JM0-%Jr=#%c`?0(]A6#oP!]Ahb6J1UnugmBpOO-ASn_:/ESK/G"ufi7J_7O]ABJeZ4iT
=0e:q,?nh3&KH&Mn:,paITUV''hg<\$3a`1]A0i"B45l;@H\i2$B/Y!$-oEpOr1)=INoS@/h#
hqPf)tE2IU*R)-nTH)b(u$9G`p'gh4GL$aec`N[1eZYgF]A3>&5s['gP+"k4ld4,u]A8:?tTmO
jiYp=2.fkm[fT/fG-e<W6MeXu0KCb+A6No+*_<6*EVEa(AbjQ'&U'$flcpW%RR[8&40L(Tn.
f2k<K'Ack[j&IrNN)kQlHRD>fC9-/M4p%uV3e,%13,i'q"L<L!@ahTHFhLk^hd'<Y:d"@<nh
ZYFWW@Tu1Js?V?Z)WR7a'9l>GPE=(cddU*ulX>Q:6eg]AghNXUG_^2&VVLDca#QNaa,7W[V):
C1I7I\8qDo,0`K;@cqQD36h$bsVq49hm7e5c67NV_(CPV%ea3AIJSJcI-Sm?^]A:iunqtBCj'
:=Q\PB!I8M^pk",M'#-D3l`RfsUS\S3K:6=KEqs]ABMZfF2F8e)Ff76_jTCPo8fEOSDOgCR`F
bFlj^Ui]A^bdQLD9jhf`:SCkGO=9P"<?<$MJ[!K8*bX=l]A6jA0ua#Pm<+^hdQuF[9KTie$*Pt
BNUTdA+BlZPtQV2cBQ1S:ul4[7?h$L1(L9SEF+?4^979!k#/\qDr=9723QfNM'*q>-0^fhP'
,KG:f,]At^i47(=2-)H6JgpLlgC]AVJ5KT1QlUd0;5+o2c+1@%JD1,t2+%$cEcJL`rI88!3Ghj
:\Ni?iePhe"rsOEU.UVU9R'NY!d,2h8<UG9Td6tOT\3DTY9=4nhg:R@!AIe_Kf"/Pgr;!$O/
53bsTHi?31X)jY;KYe@OXeD28\\Jf1BM1X8j,aaHY9'J#B3@\Er@0:Oh%SKfP9fc@j1Wk[Nt
Gkm[5J9:&0#Fn_D@YR/BtID4o2MTTP32Xi!At-PFoCZHU+0`7cc[.)b3#qH@WnoB<DJ!(o+^
p>uC%4H&-*kA#(^fh+PW>O=KmncY>7e=0d1rFOf]AB-aMqejMI5"3I\f*ei:KLg4.h)^s*n1j
$(3I5g=0;Ind'N3J]ARm&<?ja6WI)$<8Sr[Gd;D5XH$Yf.L5%Cd:a,jUO?`7EnWM]AknZUB[FJ
YRGi-3Y?2cR,_Gu,8HF@AHk,"]AO*OE.iXBnePFm?<10'Jl0[SoBQ[E_q#H+T#ckAM_Yj"eYC
3OVoHu$BR%K,?Bdo!qd5=-S@@uF5%]AD/p6C"j!%=1tbMYl:oc\`QkPRdY[N7QG9o'K<<?n'?
m1`BoskhZldus.!`NLC6hEb.[#H>iUms7,IhBK,,_n%K-#I^7RN3T#-pCp>>ANF$U64kajsZ
>.9;u0ioftrM*mqi&#Ysh,,J%!<s]A!nQ![g,]A/jc!@^W8W4Olbh/%IH3SrLnf#d$_95WaZbh
5CA(^:B8]AXFRO*!"ui8Ej]AlR_pt)?c^.!"HqE\Zj9M]A]AV(p*_$19iOU#fnTi`rBFZ(r7FWdp
4dg@JpIfU]AOJ3Ml#F9k=ZVl;!5gTutVPW97\;\qY,bNh0@NM%Y<G\P?DH$5jW+7"=96?BWFB
bcYjanB/HN@)]AW#r)LVj(0@`0Q4F,<*4SNC"5u.Zp6_AV\[1F"+.S@3j6U'I\(.$mrjW.$<'
BP;\0>l1tuF[g6LVC_a('+Q#E,82oo7qWj4_tX)hi@dDVK6<m0^bOCKU[Mt:^4T<G\d']A='/
,+`S7j'G<?W'Dn4-9E1LbPf"jdFS*HHiR?:7s@0bTY6sa_>EUk1"K\:Emfo5=juDr'RrifTJ
"W_=r`bOIK$-41oL&`/*N&ij#'i86^(2MUZhQ`RMJktfJ+%#UTs@SP00(0dk>fF9sNVfY$X$
M[q-7.U-kXPQi)MoTtCMdYQ4_k>3&*Bbq6CJ,9K]A2=@-/Ea:H<;H>7,_]AuGrB`>IZ>bTmhCC
7U_slS#.Cd8Z3srV]ASE-Ga:Gq8c9D6W%("FF;\*:5]A&AcKgB28B(DE*-@#+Q,dd98"Y`GcT[
GiMq9jI-ClQXs+4eR'8Gh*_onZ+!?bThq@K)qJ$Vad"1j2UT0RA%QfDqqm)!gi[Q>H4!V[\5
o@q:Pm3CB[q=$i;-TI_?#EtT00E+0056qd3[4#5JdhW`.\#^,HRQ.LO6T?T2j9%]AYk:$+)Nh
9mb;/tO//H,8f/+m/:P]A.-LQNH=L?\IM_('UFFWpnt)l[n=9bq/Jdp:c:7L@ha7kcMr0BLLU
g`q8@aDuZZC/&Cs!p>BNB5j.djVt4kK6Ol(md4b+$nf1n<%>fgJEZbiKZ]AfkCf[^lRZ(J^G5
V)$($.$49!"7;G;8R;s\mJaR\0e*R7Z]AgC0b]A;US3D=HH,S><H5EmCd5!0@aHPW(ZYE3`)n[
m8?-Zi:AuDGLU>YeB(Q1$DAek+lr\I/O>Y>E>)q4'96DGa@F3TmhOWbFC:u@bsir^r&+\'kb
<>tj8UQfp+_KaW.h(TXHA+osP9a=NUON=#fSjFdKGmiP*DT`&4/lTe$:INIaSdI(E&^YC\l3
MUg`H=l#FDUPc:e.?r--$1kAOlGaCM4->$G*V&qU+&\GtVi.R7!;OU8^uP$mEDWdT*k<&p0r
4M0pF^Zn4d^7akp+Qsj9F0uaK$i6YP+;#^-,0sF:Ta5<+[o)BT/?=Xa2s.]A?NP.fPLkp:8o5
.e(9Rp6ClP/_2WXgoK1MeIKKg6J0>[#Yb7=(!08ftGPK3`XdoRNmIVm:nq99;EmDIfnoCP)D
8ORM7_]APZ<"acs6I8J1AXbm,)92D>p!;>:MF82(\)#\:?0=jWVa`<@+AD!PAg_L2@Re6rQDk
'M8KqoGI_7BZ]A+[c#4LAXF6=1P1>fdI4'Y5>U3s?A1IqE]AV'_EHe!X4[,;eh@ZG2TM:@B'de
&5Y_!\,ea3X9rriOg%#fZfSCZ+30a8Z[9s+`=cZ.#p*.0flO)*q,]A$2mK,9tTWX_s4c"S5g_
(Xo=#i(1b/\fQe`%2Zbd41-E>C!ZXHh&;:#$38`hP!7tF$&3J!"TGbojVb&'s3pRZfcI:*)J
2u4$C*IpK*Ff4Hh%.U#X9uJ4pIGkl+k(.E>5%#0Y,j==S.Pu?b]A7Vt7QK;O[[R;H'.J0:Y%9
>%`rd7lI5%YiE63'EkOIYk:OYQ^UrfbIqnRYH",nMgM87$>hMWD:QTWl:om2BJmdZb??`Y%1
H:U3A26@=^d/.e.LpkR^4?DphK+sQ_4QFGAk3=;fZbMi6T`*0D!Z"Z^o#S/sE15gj)oG$e\^
*p&+K0)'4".n2Fhk_-XcW&kn9\cQ]A+RJbS^n,5GNGW]A13%ZNaP_5F>#A$hiVo7q`e>eAHsFG
r\pLiA7W3%gY?^bYq.kcPp/n?lCsR3JasY)p!1,%[,6V"!n__/SRC'WI*WO:a0=%-c5HOXO(
XRtR9AK3ud5VD/'8L\P3F7@7'WZBnpA6uMNJmZA#[9tREb3>a2qL88b+P+KWA;L\>ETq,aMQ
LLKQi(OIr`5I$0ZZTZi;'qO]A.PbkjK/?cO<^nJ.ZaF;(aY"KE=8U^&PKXb=?Bi)p:,3.MF[\
]A#JB[R)N57f*,JW>'2-D4uRA)0'#i*?UZNS59%>WK#IjD+S`4)1Hs^.d<"7]A[D1EqCF87haO
#L[TUh&_X-0:$j^I-6IF?EDl8Wa1Cht]A/_hcj\BLAT9#T.U5cf0?#8BLC9g?q2ZUXl%$g;0g
Fg-QLPeHbi#^aOuc1K1o33DH"*"_["Dr6G'e51Wkp`j-D!/pg[jEESB(gE.)u)gm[kOP:Tdm
[km*Y*+Wi_#`tA[(fjXNmPaf\aih"f>85InUV+`aUm1$DlMnb6Mbgn@jD0?OS<%$n[hA5n-5
qJqEd^iC4>;YFc9olD03h!n9m?5rDF1FD2g=q=Q&T2f]AOH:lpcigX"X3VP--UuBKDcN;nH>3
QcL]A*b+N^m]Ac.td]ATs1sA"lAhq3F2GU#E>5d&Yd+clT%ZhOTuh$-J0`+cM'k[#Vpm/BrL]Afc
?*DE<Sk7FfneJ@i&HqiU=mSXnM_e1B;VI67n+o(f2^9cWdSL(E58#'n+GW-<(q^FB&2RD:J&
0aM\2nI/)mW$;hLbZg.beG/lQb\&MsB`%b2$Pp2R&\=h2[&B)(?DH</]Ag(4B-l7'QL9.Za4"
&Dgq]ADb(`G[9U@+qV*@Q0+!Zk:'g0Q4`J$D4\8Y>jN;s(ulkla]AjF##.p+!4Nntl/%!>LP<B
_BlPWQ9(r8!6^/_qI&:^hqEC$jB+H,;8JC75`>OC\_U[W!mfe&??$]A&s@*2YhgFU21XfrmoN
GXJfdrLWfHHgGnQ-W.kr<qV"HIotGb=H;3PI(`BXTR%Kb=Zb<!>eT4\:C=r"CfE=H+Rq1QKL
__a:$P'sj]ACT"'*'=Pe`i%I#?it"O8^4<12G+G:tVC1&I!B=*nsW3^,"iC0!X`q>*T!0B__s
Lor]Agk;pSTa7Y#$m`?CWioS8CD')U.GL@"b1S,n%D'sV#^WIa8(pM`\T32h%igUb-[EsXAm)
X9D.+WK(P:HMnMHdU47%7D-7piX-"Hce1G4GOFC8$c;:\]A@A><n:VNpQ25iN;T=aNT@Yp`MX
-O!:0?[e)nL%m`OH%Si]AU)JsN)1HeA8BopHu[?`u3YUT'^j;Z7&`dg&`trdNDg*D)*W)\&ga
H>!F,'H!gmY^kQl)G#[%%GSKJk.>C(A9\RVGC:lhfO+L%k2OWa(1c+?s.*rSlPBL:10lJY=<
t'1X7,=G'eRft^NtM6]Ag_78k>.8bjK7L?9nes<gp?ruqn0AKfW4$c)W%Zig0P)4"OLZM1_'$
.C?H^.YJ%MC]AsG@`Y5J=$JV[sl*0uk]AfF37+,T2RO:H\Zh/[2K(5I%KPamJbiRNVm_qn/9#P
+R,4Jiu_S+@cdkHsEE*K$3h[Oo<c<UX;5A_Xf$>94q=Nie&VX#((fN@LDd=k4['kUDL-*<d\
X`#/4A'D6\(bic3+C!M.L.pKfG]ApX?$93QZ79^r!j*#b#F`DM<6&P^5BFiOc<j<!C0in]A&#K
U>d,;C]A6HkJ>7cl0>g[pRJZ!nlA44;-e8PVDK0<U(0i:Jr'La,Rf-<spSR<j0$tRZ3G^+sk:
4RZOp9):B@i\ab+ml$g/"=En9mKE^S4P>lJ+^54.o;TjnQ^t",gG^DuAn&NSPHsdJh[r</0o
c?6&Ou*`rur@L>BPK_$n!VF:G9([Dp,[6Y_(ZKYX`rqKW(oN)YY)Wh[_="Pk&n*(^]A:C:?j;
P&J;`(/GYIH6a((!^Ju;7Pge#mg'ka.8)RhYJ:f?M:La`Cu1q=ur2Vk;`d';f9uZ->O@>O"n
N-^R'@1(iM#K8b;*bTg5i$f<"Y)%%E[)a&Q^nY.eQq7G.@adUN@c8+.8rLR+r8ZC+n6#%l,r
*OF@#H8[#pf29^kV;FPN5fHH+ZrQsJ`+YiJ/AEDn7Qh'>MlZ7B_V=7-/XNW#q<r;_X9FBJ"t
sI6V]A1N)$l=I^n)&PSq0(?^:[h?2I2t>O-ZHJJ(^GhWN?/^dm3o^;+mrV4[GVt>cdt*7'q6I
pP<Va@E]Ad]A=^YrJTLT1]AEChVJ_!afL?oCckV:D3<"_d,o\e?CV,J1b.!<iu4QXeG<UrETekh
6"/i&p'hV.5>ed7<pnGdGdVBMg1%Cfh^Kg$(fGng)$In:8tES20O^CP$/b4&Ybn!ffQq)jU^
sQ!%$,!B3I26HfG_=5S.Z$F>upq2@A*Ea05'mj.I^"&F+<!@:df(G=%E&j!J-?!;f-iQDaiN
6HjTMpqt0<6K0<-!,'`ej"/LPYn!ImiKgUpl*(OPdH3-Umk0]A9GV:^`IQ@@]AhC>=l6/fRi2q
UYXddD58'aP3I\Pst;3^s9T$n9+Oea%*G7&LFMHkS2s2IXhZq%,SVY7QVZW\JlAcna+=S1-N
Y$4OWb:e(/nHU@XLq`D+o=N6r\\j^A-os8LRQk?Q>Br7u:C'eWtg/B9&KuG%?mUul"&&.LnN
>PMrS'WAMi-/1J@7_DX?*&_jU5(PZ6:uZ*[F1iO3a^[Bj4q*QThj,MrL>274X/\*(q\3?1)f
mMG[e'%OQG6A+L<pPh7(.p+Q*0D>QJ)27$WUC:m4aJ+0+[/j[2ZJFo/m'<2N\\K7MGLh&K[a
n3jl5<2e>setsEX9^c`8iSZ>XN!FH%BXK;$fW?PSO.0/V!2ir]AU8_[Gma3JD,@9_X/kMtX4j
P,%5$T9-F'i_8l\BVYB,.DJ7nC%I^m_;&IYnp2(%]AcG[?aL0atfHm>/0*?S+L^5p&NiRo^fK
0BgT:A?E#n!?n?$F5/SGMaL4-*Uq>KN5G-(W:ot4kYeF5]A\238Scd*Y"_-<T.S&A9U`cZct6
"8K_cqn6crr[)4>?PKudRs^:PcAV`n$58+s7upNU[]A=hL@gEUE"^9p$*,k\8D<7/HYWT/\[A
"8[=,p`=(NM<,.q@^U"BTkUI@P,ZRQ8lVQf.f>qs,1<^7=FdNY>mF@PJcC`'Q:=9/lJ7@ap^
UUBO<Bq0Q<g+@QJi+,JsfYt81[SW7]A6(DYdk)&ikG<;#M6G-u3PI4kW6:'c;Oi_PG3OoEao`
I5$YaNBD$a3Q&n0r,F,JldE0jiq1%!.Y=M.HK4O!*oB_-1<;==9p6Y`S2qhMQI4JXRl8YG0Z
h/C>Gc0M6E-C[OZS[=1L6q%1Po92jqb0>[RAqg:F\;,0579KHUXTel%(R/2KPI1/=;P=@crg
om4#TNo-$U*GM2f=\95VCt+L?NZ<eH?[q-I^%&"1kZkIU?5Ss,$jgc:U#F^?BpAYFd]A`XG-Q
L:/_k$k^4W,\l%Xs.I]A%<f/LCjrnu%l<8m]AJijo575/KF-X!?8f)iC4.=,i<G-#-C49N9""M
5hj-0a.rZp:*pUFFlGg;O>(N0l_V+*i5O:q1O!#IB0B!'1-#%BL2D'L35!O%KT15<E'<)V'I
A&dA+#I!\("5uEG)T!^6`$]A4r'J7(s%KIHW<"j"aF""K0<Sb2P8;nCHiM(;l`V40&nZ@0R`g
_"c,m>LP79(M`Y?[G@uI1:)&+;j6R9W926<Q;i7K<KT:M[$Wh8W6(1?)ohmI62';G9/6J<XJ
29?j4bX*VO/-H2N"ddBoW.l+oGbpu`L#"OZjSRAdjt$b\,VbhZ)!p8M`i"G0`Y=jjTi1)LK!
-B_C?]AE'`&_U7Gl[Ei,+2W7FJ7@`RLqN4TYW#[kf$]A4Gn&NQrRkNdWlrPr#;a&D<m?%i67al
aL@+c$B(/Y4q.ou&"_e14tUWY)rijp@`fFf@&&3T]Ak[QtrU&XTs12g9QM"C72,s><_Mm"[cQ
,/<IMZ?alZuQhQqBI+2E-^lgKWethAumPYn?o;]AN:N:++NQ@)t)DaXPBBnC`^+u'#IJ&L$>4
95cS-+'nqVGrH&W.]Ao8,)#S\K:R"Lf/$L8YdZmqML&O!`!>Sg%L<spL]ArndBCI`"XUB4HddM
<PnXOocoFhqY`7mj8TGl1-:^SP+quETmtl5^g?4oBdb5J(H8AjAN.oBXhbJn2T]A^e.]AAn!L"
O0/*F5V7k@oDk*1[CZIg7\24Ne<*3=37A?5rWpVH)oQT1\(7ri(NpHYeQ+/f;;:'T9:9i5>>
bd4K1Vh2Ib(crogbB+]AA#OcWEBb@V:'*'_7E(S.NibL)BRUO\D>pDN_$o:+%:eZ<4!N]A2D#R
3^K<X"J+H^gJRcHg&P<urVGlP5_T5lD$W1aKHUdQqVuKW`,R\Eu3?j,2$"(!k<]AcMdFBM=1F
9*Z\eh8r7B#XVY>l7Xb,G\rSTa8o(JT0d53A3mYnhY"Z`=dTt,1br6W):^J9GT=O)Ek7\-*Y
YU*GSr&sD6LDp?_"Y[.OnAWIdm6+3O(mr,k5n,'Hge2geWs9=Aa$)q%Ob,(.$aPW1PM)MdlY
oo?f$@tY_<YrrjPabk4s;IOX;W[(mCOTOXX5`VS:KBRT!)P2V2ZcAW_>#=OVtGDo7<7Zr!Jm
S3&FiS=nS))>U'@-Hk7B-Pp^*IXMQ@2t0R'MGMQrhk-XT;FHN"cS3QocHpW,E6FkHY)C*<&4
'W[cFdFUE81,m^co]A-ogpa'iGDm[b*#i.o#-mR2NC/R2TclSD$5Ds/qPDHGjuPK_SENgYIRh
;a(pA&?kB[c[cTEAKH-%'WX*tI;Luq@-!RUV(^BcnQE8+(\^-EC,'6S8>^TiBZ6BkR]A$tCM'
4]A[`l>je,PY*;/<.Y8Q9</34**7$A9b*j-/,Bsp1!4s4Yf`cFrW^jO??B-pZ?Yo%J?U9aG?]A
-b$sp.POi:tY7Ja+/0`m&6B*3uGilcbZ(72Y^K_5!;Y/"o_'0uSQh1#JVG5)ZRl^O_rI*!:r
Q]A/SH[QMM/]AQPnqDE)S+8==+`Tb7FCMB!$_8jfGsqVl""&Gq,JjF8@Ch"OeV*Y1eD?;=8_IS
/C?8e#q#K6'iW=+B1GI]A&t=]AA9K+8RZrjint!P6&5:3;rD'_B\I4_lV-MZQhY*[oa^rH7Hp0
n)h%VFQ6pt[9LVt`TNr]AZeaBm74m%J::2P-Ebqm&k=!VtUoqNr4TB+J9brfao/0cd>56'l<7
r-Vl3mWLLNW,*U$HSt]Af9^/QAYhR.#iAnY`n44oK))X^,-EPLhTRIbd59r_\D(bDCjgG;l!=
[[*e"ZK=mWdY[J\sjMjEM'l"SiV%_fAJ990<0hM>3Dc0Ao`ns?GA!"Qeei%.iEdcUNQ5_7,i
nQ8*)HhUNKCYpu+dOZrQ11bfl7,n8.Dap;rFq-(ho']Ad3l@CKcAXR5I"1-R/`PosRZZqkFKu
pBDM0!R9:k:/.#db;\Rcf'k7>ia&-K\\!/Xj4s(ATD,r*@)FFiIi3TG#BHI[jnbkG=#BFm?T
MH+Q(tF6plpojS8G=ORKZGafG"(,NkhMd]A*cT1AN!%MW94&r>=n=\diU4Mf,^Mn5N/@m/;!6
`TE"n)RMCB9'`J$$PWj.E9_RQ2(El@QDqE1XLp*e+W*)#%,o>4q;O8)'VMH5s!O]AI9hKlQ$U
"H@1clf%t5H7*EAe,2or6N`8EE7$/NVY>#II`W6s&s;hHk-9S3J6cTS_o+-",[*if@'%LSl1
M)><5Ma^hM;*OuBDF_q(`V@ldS8#&pIj?D+Gn8L,m1&l;Pd":1m'Q>>1%IHA-)*J:s)-1'qA
K)@j<FY(*W`Y?Z:7jA,M[njKA:YEWs'Bp7h160$H[OMR?"qcqOhunE)9n1ou#*ADm&MB9*J$
mY/n1s):-3q.h&(CKg,$Mp_\>Jh@%^2$3HF*!dqj3,b(XpOEtOLjr7%'=:ZjdR^6Bb+V.W_L
@+*7.JMRi?d>d[MNEN.`>D@7Y6j+Z,KfcI-XEM0V/T:&M)X>mFbX5_&s"MD/jF3>L:boL)eH
.D0t+j1<`SXJ^n1PM:fZk>lJ9U6b&:_mrYs"BC!ttJOWdE@d<f^omd.-Z?24$Akh(Nk,l:i#
9Wsn8AMOb:5fb*%lTCNFG(,*!%pgXc+A8*'WNm\Z1sF^e=*VW,k-@$n8/m0u=eD'.#mW@gmd
&GH%N#qbU+X!+B]Al6MB55V-'F4k<_-0sD`F&Y`3m<^TUa5ans&De"(<DPSgHMc>qi#4CU<S=
/8C+qCkIf1c7<:D;',;j4'<KbjW4M-@QS/-4J;.3,Xn0'q;KaFjZIXFrZ/%;**;7Z>&!omYd
uc)gXW''8hYJ=Z2d$b9@ER7jkcu".4SZJ[g`!A\_f%b]AV$ZOO&+94/K`A_Ul;)#?H4@hM8]A]A
Y#V7()&RWT?P20At>^hZ"p)jt1s3"n>_i)44Y?$-;SX0iD@(&fVo&Vl15QJVKL`P1lmQ$he[
*H?rq\S6a;1Y,j_]AL8Sjn!agrnCm`%nY*_VCt:hu77dVK&Hq-D(sE"H0cQJu7H%FaNVZ`)+c
=G;OT12)bpLP<UF2@>]AuL2Ip#hhelO`X2TeS;1`C*@`3(02mG;tD*[]A!cj1d=Qa]ASEG:'*aM
L9+%?M%@c-#\r<q;Ss#4l>M/5_\"#ePDXt,=oV=OoX6eW/Z;XsDWQQX1VU?$g9ta#6EKM#/<
)ZfO=ES*CTaJ!2WEs!E+gA`H%2G!mkm&e[XE(fo+1fMEQ'J0T4-hQsI$.ZMfXpotI.D$@'[L
9]Ar7U>C+K8iU!#Is?i(SD";gL*6I^/A/:/cmL:6!V5#4qRAQG@:)l\Z%3+%*bZ$B8#/<&Sg=
hG`cY:j4KD&c`YQc]AgC<hT%fAc@,Js&$\Bu@:(FlK/]AIOn/^^QnE^%Tf4Jb&DYX9eo1IO#Nr
acXn-CdaB%4k8X`dqkXF(6OHWTE"LaCknbWfCqqQ;n;Nnts=RiCjG0!1r,oqCn_5VjLKXuLG
j%24I@WL[J7W3g=_g@ZO`02]A,9jSdl%P0:8aJV<Zn#(g)Y)5Wc.;.7-#rMKM3qI!1Ek/3Xf`
W&<Y;,R:0<Ea3\R$Qf1M1#mChOoQAg!eZB]A$?N#Nm(L-OQ&e.Tj/8-6fYL9'#9*;Dp`N&Z:m
'kmUbt:5pAk2>^LkV/jDC3pYV#h;&8ghQ4+[6qWB5mJT$6#9VR)`JsJX2'EOFT-ROdp8P\T'
,8ZS&J.B1L)"<@u"!%/ABc[W-5qKm>\k_%9CSmgMR3$VW`BGdR&J@4AH<6s_%Qrml)7md12a
JuuBfl`/(1BI`U>Q@;qsKDH$cS"V&P47mf/2e<>2p*BJm)?<Ef^;eI&=$ZKU#7.M,-;Uq]A'L
<1S:]A:^okF++Z:gO,ZY#?Y7_RcWH4pGl\"/(Ku9EQ8(H+1PP`bM@uDF\LA)C>1C!,=a!-/4X
S;4@[*17b1V3"%[M2p]Arlr:G^/*I.Ie;knh,LV/=6gUX7[&I<0a<&*[68tNN0Wrp*TQI0<*&
RWC#6'l_5f*C`DX@`dur"0N&#2!h%9?crpL2ZnM:]A1A74^^%$ei49Z@Ua"6orRO5,M;"s3r[
#=/QB:CBsHLNQunoeI9u*?pGoQPZ:QU&:hSL0#n'lUIB,V)pQ,`fJa:.,Y&]A`Gd<(S&srW9P
_u,lBq^Y#Yg775Nc>\nQ&8:8#o4RejH6L9bF9.7qVi%Ok0<H$"=Qfl!>McJnCRud9a%6r)Q7
<e(R6f2Z>Zf8;(\36\Y,H+^_="rTZ+.14n4QP#L7A$tdnjb/JYhZ/;hU-NUc.?/b#[5Y#lk%
,c*kaSs>OQF%IMKU8Q`/!['+>9DFVWp^$0kVmmiG((W.g>fq;=7nrZhi1Z#p(k#GGmF!kY,$
7\Z''l8dd&P:r7+gT.$HWd">!ITfX+oJ%TqD4HCi2N`hn0?J((;72A!;eD`F;,UG=LpdE3b+
1moDum$7&fWeb=S;JL8lRqMQ)al9>$9+H#LjoF6+=^M%!??AI%Sb>_T^"qa(s04?%pZgi7Q$
s1%ZO)`c\1-9+j.l9L*cD]A,[J)*r.uKKAg;kf,3?cmm[>$&XR8nPWf`NjZE<Y`5`jhN13%Nl
JY\uVArr.bFWY7XQ0R$B;OU0jQ0$U8(k/@7Fi)Aj8Qhbid4QOZPjo<aT6n0ICGfAQZD4T:>M
eHn-P`]A/dJ,*b@[&T=B8$G4e2>$Jn?&/A/9aXeKZNA%HA9.Fe\-0oEGkq1-C:)Lo]AuA5RlG,
%=49`7)I`>GXr)ojkWrQCp)-V3*ck-"+Qi:oQ&;=5@#rG?ka0BpQ>BK8d>M%5%"Re@*g/ua0
NXmBDI[-4N%$(jfVlV"eJKZ@<cP9(r$")rIU"_i>fgB/gpdF8mRWSDSK&jSE:cnS!^*&3Bq!
2Q#1M?ui%*fRY(3Fm+NaY.uRE5$0NlVa[U0f1eQ5:lo#XA<9fe1_^'8"[nglkpNaHC]AVV2_;
chItm#Sb0b*T,lD.!1N%b@h`TV;H(2*L+Sig5BPr]AV#dOYn>bRY]AL?32Fn'++g#SWg=(P>-k
"PTWa?N8eY'TdRp]AaUikbI`G"hBH.GP[$K-mFFL@`6pO'\"Gu1&o>uBkuKB5>2?RChcsET,5
$2S>_@l>@*tciaU9GCUilZ..JZnh'LWiJ0Cpc!B4M=A(,d1H\TV&p;C93Ra14?[LnRTju3tN
b'8%8`##=4m*;3^3DQY[bcu5+JklJ=E@K"@iobKaZM#ceL,]Ah68,BpT0mKIGC7]A\hK60GWhu
8>TgJD(T!;Nn_IP4`oIsQ>A/&U98h?>[A4r>M,\j$!fUV`ed[si-sk4k/fE]AF<XJDGd.]A3\"
IfK]A:jp`8O@%D4tb_V^55P&[;"E0S_PLaamOMB@Mk<k/1l(Y)MhM2B&H'<L*41PbVi5HhHff
m+eeeEeVO+4Rm&f1/X(Ol(Dspt8b^d_5:e`L8'";l\*>1J.$j=>5fbd"]APS*'5$!aU-2Q2,/
%:<LjqnMSK<Aa`)uh>+6F`UatfY$jp-OD!pLPat4G#SWZ&ZUmG-l>tu'MnEgt>Og*a4L)]AHg
cb!O)LZTT*e1K'$-$=^n^=XX:iC:g;^sRIX-cfA9:%F]AUf93hdY]AlR-]A#$<FqYc^a72c2"!P
2AsY:,$CBKd(kH#<rH4g2n@heK0[^u@>,:q+@WoL"-61GCE.#O"kKeH4jkb[En;Pd8\uYd4O
GY>tCh>M21t['F"PVTl;BO,H0S6V+,k+D!q(pGe]AaL_tL.Ajo-0H+pUKBphF[cpMWO@YK8Kf
<curdt+rkQ0O[hR&U:D6OQY"Vn$F,N+2Y]A_b&1K3ubl:$0jWtaKkT]AN\2dMX5Ku?g@D\FEl:
X2fbnrk]AD10Hn`eSPM.]AfRLL@fIh#4[6*uoW%FYI\`+t\R1c'%i^D8ngkS;T"J'ke5kB8bM)
\N%!/Wa"A8/#Si'6Sn(?6a/a.>cmtDYLKeCMSNRQ]A3oB/YT?iZJ$%fjrYQ]A`MclK=hB-N:9.
P(\U!!i!E!sJ;5M*#L@GCZ5,b:WpcMU=<613&nNFTTAZLKG<RJIcY0F_O[^#ZQnqRJL[>M)r
GTOT]Ae2,\mhTk;[hq\$&5AE+1pAir2H=7+?\3D*cs=t.i8?Q/k?So+RF5pA#L%G.7&`P>gr_
Mi'$^OL2X[k+1l+&HW#?7`*X50XAD34s%,_X@G5_Z,j*)jg!_jbQ+\*mPr:Y?A"L+/P4g(A,
m2n<`/1Jaqa,UJ,S&e&:*K+`?=3#7<e>oIdTq.Gle6*79CGNRUg#10[f<_40uSG60.?Va+AZ
`dcjGqN1m_jKc.q#1uqb0%5#mJC0Md(_?)@P+<O5>JMsA&W^ke>6"Z@!c%`&["6ZXlB6W"PI
\f9Gn_,!O<O)D1bR^.>o4Ar=eb<,a&R'4W@]A7JMS_*_kp$1AAF\k[$c:>X6Y<2NlT<TVX<fs
2QZs=^LURnjSR4Fq/sG[P1d'6)#Mn.2XJ/BsA9u<[noA4RCFlI;-kEYQS@;Ak8Qb2\qn1J\M
gjGBdoQ&]A0#2tEUWMk<nki!3<l@9=^+!IhQb^5W4i1O5d8XaHmq6.&3prZkYEbZm?60HKCH6
k$;c/WL=5cZM`8;GnUY)ts1i46bEL(nJ.8ZWgmpkQlG?;&_p9:"5WF<<:'"XVk5pX$A7%qmJ
&/UL(Ae8hTg_5gM-rJo0g4$9k^sG#(MG'O'pug;1=E-h&6]A$*&fWjkN%`6hGpf:i;muD^k<r
9NYPIg,e(a^c`1fe6+5<A]AbqE-Nfe$amM9jZ"_hqk.bUOJ-K[&?j:*sI9]AD/gd&_UY65hW_;
Z=iH4nA1a[r(Y#0/K?**&-YCt2FX&U&D3n(Vh1?F52BQH799Q,eY-CI)%c+J&jRf]A9HdFLKi
*f<b-^$>3'WK2gVfBDDkCrAD1WtLhX;2rR\fqKq.3%5`=lHU5pg.f/hZ4j1L8V:PaqD'0K&T
+aI&u_X3@jC#r1S.lKQp8H_Ic2p#uS/tPJ43PPl1!kTjNm0$N;iYZ.UO(!^[;*="?46(3nMS
MD'DPZY.OlMQes3`=hdaS;26Yf8"Q-$*../TBC;&2+A1)$HH`i9@KS/ais+ckY-CLW)CZZbO
U#^k73c:?j?.6fF=M^6oUu@7XQMsa*>StXX21^Go:.!(o^fh%20U:>H.4qn!Ps@?e/R6.6W?
#??pt&is_-nM9oSCr7N^uo([ahp2L>Dj3s]Ac^KLA5N%85I/1R)0@GbD<[di1(M`lZoS9)K\S
j-ssnnZ(DLN/QU*'8EP8H(n3%jImsE1V?.^ht?WC_[t+K7'R_$\$)H-p/YBJ`F![L#Kb"Ss6
;+hKqd#fM)u1mu>BU"6&VT!7TF<$n2O_h5FQU0-L#""j$g2/drV3RaGp4*+OC,nAuIJm3LZ+
.K#b=(`c&j'mE3<g!%42)!BgX$5qTa?J\Y^3u>bOE&n.Uj1GIfeli.=e7n?ZH<KAV*T8`[F5
jF@<W_nYF/f82'\Bm=.=8Ac/^lEe7J)XpZqd4Q0WS?PI#?Veg0_3'Z3C;NjbQ9c.goCbC6@-
!bC6\%)ZN;p[pEZ/80k-P6)$<d=t</$1,(i#5(_9l*Ib_0m?XrUruJI*i;'nYauD[Ag;`MQZ
LbsR]Ah8e`HsX:lrmAV6l>@"WeG*_EP&e8;Ug+hM[UT/G=P0<Zlbrl@cgb`+HDgf7:1?sqZLQ
8.dpM>e.`5u(hb6+[`$c?]AA\%/%dYS"[IlS2*%)!!j_r_[6l-j/d[;Res$JRY[n0Z_:5>^Li
3ciWpiFb@D2cFJun.a?]ADmHQL#P*B6=<UJ)UXEF'9::k+cB7ET=%b]AuXB8a"UcK+,a;L0j3'
f#$G2f_9rTtP-E[q'\WE,',,O*pP84.b^;lg(,brcOVN9=0$qR>SX.5Pc.,/WLC6N;h;s+d=
X8I&Z6s,f*W01WSdX9!cg3p^bj[5WZj5i'jgp^46.Zh"i79i.`Qg4NQKkJ:r6OfhbFP&2]A,*
=,E@M`)p==tdm4RJM=(nXcFFjY8Y*LM^E3Vu.913>4u?Ok1"N*_Zua8P!;KS#+6U73UJERf1
kDF[[:BCY<!;WA^,q]A_Q&UV=':$Jtu3Bj]A^i(oXOc`Y+tAc&G1*N8n9KI@W&<h]AijsJ7G(2F
8`odB?s$FnApiu<?u=hegJGJbj)D=JKr$CQ!@a.ckYa(+IpF%#GHRV,gp`:r2$7O`J%nmCrJ
(js]Alb'c-Ihu@.sS2Zbm4Quh(h,9mL>j,Z2.MZR*E(W56LP]AiUhD9lWOSPo>8MOW&i76'JYA
EQ^e_fH"3fX0h,s+cq)jT^Uht%'Y:Vb]A8Ik`G%4[I-9G=2nLGW!GB[m?fn_u<Eu!_uL86)c-
Ra4>7_-,'d'M)m@<'@-EQBpLCB]A#hP06)WZk"87[ONQ'DGcs8':kee88$p?j2i3LQ>6I*84s
l"beDoE2sfXJ#Frn=;Z(<bY,bAd_Hl=$2hPW!)baRp_Rd]Aq!CVTX5l[]A-V['V9R`CU)KC(ut
&eHt!_MFDQR"HbfXXJ1l/o:4\"HL<'^UpPHhhTs(o@/$lD;fF71h%]A(BF)5Qfg-XG6*IB\&?
KBlGjkq`2;Y]A_L2"ar@]Aa!W/>)R3Gn*s4pq]Ao?[H0Dib!QnH$tDFFhu/0l,/@`DRbR#.pS,e
/8P$?p;lFh7jWE30YM"XC-#_b>SkEZd"2MH(\+<^n2,5f(8S=&"dfL1dK3Z/5a4,B<%#8*:`
^n]ADX:)6']AH)lcE<<oH1^tCLQTO78*1[G46UhXD]ArtW"I'lWD-=H6N_I`pX:M,+%5&>9qZbC
XT*30XQ[@l)`*<dFJ^*DsS:GL9ah7bHV9YK72]AQe%Hlr!F*cRDgti<drOEAM^mrc[\rYK]AZ0
ee]AJ;NA!Hni,Bq8+B-JLId'D)%AG<pn1a$#?!*THUtE;_-t60OSm*CMe^J.jD5"YMH19bjTJ
b.Lc5`$uLi&Z\*&P5PBla7/51oZuEdU"E*#*AmA%gPA4*":KVWnkJi$#OUO'K!fM+\aZSD.Z
I*9QC/&:K3`j]AX<'1Df5-]Ag*K$`R,rW;\#sF/\0#ap-jcM++5frMNJ^aIp56^gm/^*KW3$nL
<MA7q^giGJk&;Rh84d[qc-.D=HTdK`c@jX"'sd*]A33pmoTm_.0B(kP5fCpB!u9P8eF,mLI'J
,EnC'enFjs(;/=nfH;X,#>mRp5,1cL1pf?"Y+$QQ-omp9;e4+GBP'/)hk8t4\Bb0H@bbJ.as
<ccX#-cfki=!YA&je,J-jUkf[Tt-)j(oGj_(hDe0.j@.k3f0GcNGab<g4I"$Vmc=B)R6lj(Q
5+P'kN?$%4bNQX7G)@@lMg=R@Rcf]A,+T[GjUft3:(C$0Pr(,\q#%E?cN!n->Z,'!aF^I_=OG
[.\`GWcF0pJ^LjV;[-h1f5grHoT$aadU"A[8'2UAc(8ED[FUZ_Q8Oo;i'P9*WkVVA_k,+NuD
/Gc"]A*3+FS4eT,8'TX"0<6N&1igP,&5u?cP'm!g#b+IkFVt\s#)sCH!NZCJ4jQMfl$iJFWd7
_0b)+7U"EGA1Jk)@8]AXDh9>2qb]APp3@h;_jYOmp35g7(M<)P20QQ1@BfJT0mttH4[(e`l%QB
i/7T>4X'n5"nU]ADf:urI3.]Af0fW.T5gp.f/U]A0nUHJ)#l,i6:NjJ3[XC4,VK[C&L)Rnhq<"X
&iPE&fSLiGM7UGs,_QXag'Aq^E':9G!chq`>WLV@8JM5iQn*j&/%9@XCsJ/Co=!d0H%1@"_S
06#UL]AaSrEG,Ap'd,b[k2rB5$1>EFZ$W`Jr5DsB21h#1\TV6;i05E?-f-uJPiW0$_(\KT.lp
)lRG1j:2pd5jAFX+Ho?Ek)3CnNBLB:Bsu#ZN6&p!.D\27p9Bj\q_rR"`,3SXM+<i^`U\9T1T
kSc!ao>-WT:\cA9!JE6sUAX@FaO)PjDflAU)?$parh%c@S:5P7P("e(qlZ(83CW0GVR0-3OE
B%l4<8-[o'DPZ/oRkctBF!h[HfB&:u1,b#1m5SZL>2*T^SUlmbLHXm?.%@M)3po_tK)cP`[I
on)85dn&,!"-gFuEj1V<Sc]A\$Zl!0&lt^Xm$#sVhT>\^j&HQ*/HD]A0R%1bc@5ZnY(F$T4R*#
nXZGAgqqhJs#K1br-Dnd@Pj9o"oq=+XB@Rma$DFrPME>g3n>9[O@K6T`Tnq0f7c22$mN%(M;
JeMqLJ'!`NuA.i*#Bu5%inb0YfrAH77_N*[a"@[kuT^:=2i;dB<9#tf</q3\d-l.UYmfjMBF
=pKJ:eTgW"VqCef.5Yc6HUZ`_iaXR7SOOI#h*,c5"%Q6,r%k.VJ-XdAK%+DGeV*p=+._h1Hp
<-8PO-?b0uo&0DZ+1D5DVlo2+?]ANEFJW&oN^71$f:,6%HVAFS?%&/uh7n!g<");f1_Z-75bj
Jghs5=oNq]A6W'PalXj(-KqqBQMVXE\lNjE1gmm:fYOn+)mPUPFh`tOV'=K5.QL`4TWCus3d2
?^+:5>Lp=[B7S#dZdt/b_nb@IY?)K:1.2/r'n_^sg7D$Ja6-Yeq\66O_PfBiq\@0c+;O8;64
Z+bJT>pTM)?3c*N>ptM5V*^H<2O]ALmTR51W.^O("hDX/Dm=P;A>2*BZO0Lg`aGV;k;O(h5^I
$1h+ISd2*5Gl'"1hBHYm_*=6CoCT`u#QgNH4#fPmKJ6#0FO`p2*%o2^qYbZ4I5A/lKtTRTh$
5Z:,=qIirR&"n>T%l!>T/5\^>)PFDCiH=*eh;dD_!-SfZ,]Aq]AFJXXh=?rnjZ:ADt$!6]Al`b[
D7ZcW^n"0Np]AKZ$e-+E,g[Nqa;aC1EFh(I%@??]AYb5Ibs+hh=Si$9;*3&B]A92KTjR.<:T*fj
-f7@O1$"e`Pn>TBJK_<^6PjiY060LItDj7acYZ:`9'/"9jCXm(\_tu7[g!ZdEfh$6tL)us7$
T&3MSMsnee@bOb1fUd.V#C:rQPH=X*'TW@e]Al'.r:;+kh9Qq+`hiONnM-g2_J3<Z^?l0MNmT
7^*k8`V0:>T.r"rAV&:3YT7*5hLj9d`jnh^d>nO>ki15Qq@rIAg>7XS7$QS:)rFOK5>)a^:t
&Vi;h"nI/d))_Eu%b\nE!Y$H\)DDi$%!##ZY&13%[t!!.@H$e/7lUJ>1;t%&J\2Arb"HgXh#
-L9\?!@H#cu9m%-L.D\"pSAfA%=k65^NUfZ52h`$o?ZjM1n/?/3!a)l_0.>>E>U[f,esf#;"
D'6X_\:Sr<LN4gRijDi$'dKf2'qD)ac._?&ti*V.4FT27#m@X;hc\NYf5udPmb?Y'YrtW"Ub
@o[:j6kdJfpV`fc;[t*PC_p:C@SH9eBF$Zm7dE5NI@Y:7J9&/V[i`AgGiJ?k)B%X<eiQHlJu
P<XJBuJZo,0p$g1Ogr(co$O(Rc>!gUA1G^(&(g3;gYgIKSN)Mb#q/066aRfBZ4D6[780-_*:
q]AJ)\.8_c5EG+lLZ6jVcrSiSJg&(*JI\Y34A!OB-n,/K9roIXPQ,$]A30Vh4b@Am,gB&Mk&Ha
.pY=F]Ah0%rf]A>nK*gnH7KV_:nW#-mjU?]A@0JUJHV"M.4Y#-'V<[VL3S`D2Wi1t3iWqAQrj!O
75U(WC%cZ>)cYdjc@;'E!\NbUETUbo,UqZ`Y=3&d7JRNZKJFW8cG2X/HD1#P@?jKt9;N(plF
N-7]ATg,6*(kgS\;_"C]ADg'hB&Nf0<nDusMPsEM0rm.%rm3g2*oZ6Fu7F'IsI&N!+=dC<@#jf
sim!rMk)ErJ%Bk^m]AorEtg0h("1B,uOLhY-n]AcVg#l!r[OT%m`(M!2F]A">F++F0']AZr6p\5]A
_XB4W!b)RbGJ)UjfAQQB:U9f#?Ig#=onh7rAQI+?*nk3MVtZi#?!]A)%PDGS"6=BQ>q^;YpkA
BTQW!('9D"?Sjf,@D"a+:Wec'<eTkdc99Q_LgXMu6_dGLsb4:%iE8kUdsg*":^bNuDJS[1;(
^K+)7'm5`Jj(VY]An1jb@@%GfT?50/l\dH%olN3f!`"r!Y>1*^DU+4hUlK1>^=>?7(%QF!2nU
jG=\VgLQ$3T]A7Z`l[>p3-c%UHTnP2!"F=gHrZ5\eLnmTZ*uS&3)Nkpo-&J>YNht7jEAQ;7,F
"1_=]Aa$2qXLC6l$ZP8u^FPJ6e_uG:sUs%r%THlRNST_90F2jA^g*L7G>e?!p/u;;n'&]Anaa=
S_M5s]AViXlG\,+)b.:b9IXT"<"Rou6Z+e9S?Kp!8#*IS`m.uWd[0tX!bEXkt2Bq"l7DFN2Y'
$#PiEIA[c%\6U@K*(em=fAc0'UoIMm5jf2uHb#h=ZA*qK>m'b1;jgQb*`gOK4Q9G\,R^ZmOI
f>$BH;XFRTK(b2/]AEZ:%(SM%B`'sYiC!iqgYXtH:?]AC]Ae=$7Y!#0(``orn)Ojp9@)ZjdTFa]A
R]A-9V^&ft![%*&+'KYhkR[_pHVm^\9.B\,/8(6c<6"Zhbl4cMdWRn:c0>DRk&Q6Y7_iA"B(O
GQs0)4p+YIO]A8"7b)gM-@UNR+2c6%YO%NZ:JMKE&X*K?>/V<NB#u15"k8kkJfAXO^q"PfX`&
F,:-#j0"2+hA068dqfBq=/)pN0'1b/C,M$V8eN:$8$G$<<)"jG4:]A'&M+d(Fok<DC4CT'i`l
JQn]AUTo3f.daNoG8M7aBoB?IT]An5`rlR6Dp-TuT^AHQq2o*T7R6]AVl-C0+!WT49=uFEb]AQ*3
#9:6kMU-QKWlF7eXp&?jmmSQ\aBc@9pTeg_O3[5bTl8[EWJeSe&6GcD:i)<.FdRlqN#g1*l$
$&T[,`tuE.Zc&b;A>f?'p4tb/qF957#6^5O\:4d":/([KERH'Y$\EY>2NKc-\XGF=8l]ALZHn
!WrP$&0ffLQLa4=+?^9j->C&S`195q*&Sis9Fmd#(,7a._&R7#Ti4T(`SE$.^^*V_mtiBqQB
]AZ77Eb@qt;B6$WD7M""dpMWWXfmgagGOYPBG+p]A9AmXEdS2/VTB@G4H\FicS5T]A9U9+UhObb
A)7D]AJk-[[JT#5U:MZ0g<$"b@f:;ITB)'3\G4H37!i2`?(+]AaS=u0YmuL=+Res<T6e[s*fF(
hVfr[aCen`o,X$ReI%+ql?0=60E,>o>Ic:^.hT,:&]ASdNInD(?W@JFUeLQm3Kb%bh;-gI^i'
mR\f$d(4%D>AdHHpc;:7#_kE!!Jr"2[1&7iOB2kG93Q]A;U<.^S13Ae;VUdCr+qV=>s0.-q@U
cCH.7WQ/O(p+!G=oo1?"D5$RKf0DtLKcc5qC!0&OI4\U@PVrb!DPW1%trR-YK+h,_M3mfi]Au
n?Bt;<LbMJ$Da]A!8J&UT5b&5@]A#]A3_Up,W%^s=9o.'B81)"q;1Hk%OF4k8NhZ?Y=<K?Yt/i"
hQ3*ERis+jp_(\capR(0"'ScLGY"DU#RbaF^uYg`g8!P!mp^JaU9;LL2-CFuUtgdCIA?Z0Vp
F$TAP&g-(@i"mK15=1>Ld3eN%,A/6u<Xe6qq+Yf4HM+d"&nnO?NC9[#4<>#]A.dj8#&WN#ml@
[4;P=84!rhLd-lo_":Q#a;If(tElo25$DuH,&1iE)S17'@Ie?dsQqV/i:3647@:9h62G&<jj
'_ZKZ'KOT@m$6smNNR=s3CT$1'kdgjkT:QH`Q&tX8R,<)N\N[Yj+1qX-'^,JWnJDJ44geqJ@
?Pfs*i]AXD"_)5Y_d'buh."tD'14J.&%;b^gqlpO%#[i`4m-Z[;I$l*EA=Yi3PEr3eRc86>_^
E0@)R@0-F+kJ)'a45)-\J:a^:WjXYRCHk>kf/Z9Clr)b!BpQ-RgdiE&sY-Sn"3:J(qr\!8*&
"I"]AP!%mo6?rTU_I"Cc3N8.4=>gN4098EY83d`Y3k=gP//>e=)T/I\<5]AWn%EFa+SMR:\HBC
`HN5$P3a"j7@9HXU(SOJM-B`Si?2U`Cl]AD!rUiA?8*E<;&sLC9HIfr@WLSDr&,JnfKrBC'LA
QsnqdI.r&ZM6.W3BF!L)?T)t-?<M<,>GDjm^%6:&ms5-O'[oV>+DUOnQ,eCg=kaci[DPrLV,
Pj`BW4>eJhjA0VB6eh%;84e(Xl+d"Do$6TL?oB;r3&;ejilK4J\!X_h!7mk"f$HdoD5!^R4T
>n>X%=PgOO9[j([=?^9iiP592&34("QF?1#,/:<@U^pSX@j5LR#BkiZXZ<V$t0UpCTL.A?Pi
]AUItd;[stPCA$;t=1J;MMIeQREG,ZR(h7?VW-mlD:`h-p]AVsaiA7kl0H<tW/Z(HP&h%L6IhA
7,*koWIOfPhYjUpq5%V'8I+'PCfS`QoU2DEWhC9ZU<YejW#fN^nF(a#%1'&DXI.@qI>oYK,F
E3?^D]A@OjrdFr5eT<D["_5Z:']A9@K=eTBWM.+qdOikWu&rHPEgk^;TH%iERGi\d^g:tE%c-[
Yj-2X<nMqi&JDiDb1W&Ec(,]ApYqH2q;m2E-_7Rm^+"nt0Z#)/SV@Rq@UbhdcJc2\S<!_'&mg
iOsaK_F;'uE=D'LWCZ0"t?X@J^XaYnCW;IK]A[QEY)\#Lf)s^Tn..J'1p"=6@lO@%a-s2qDm:
u:gZI,cRSKpVGd]AdMlmG8bdN%XQmJHd]A.!s<IF?h#A+S`He=gpL-1st4(F&5qi%NkiDrOMD_
TC5SZEZIAW8sB8nA^c:KoN!7k;2I8fVbQs-CLA2h?#F2q^J(r3bR0i]AXYp>R887\B!#$qg]AX
+3RS"8sj-$<u8;ZnWRF'-o0.;!^pA/o=e<7H?;3n]AO+9nd_fa+qglBA`<'!D1fOHf\H_$Ar!
@@<43:q+`5-L50jM3.\i#e+24([!]A+-ak-(s5oI`\XRP5O[4PT]A[dI7<YRim!d0g4*ulN!Gu
SP4W)c[>2gEdIl2TO$&)Sq^n]AQ(=P@gS?i/pj-XcOkm$3VW1a$Q_;"aH61Qo]A'PoK6#/5g0U
0<i::12"!V-VQrad.df'J)E:A#4E.9r*nJecR.rWr"2oOG^N1%!^Q+N!9\HG@F5U:q5+!4fW
tP's?45u3YH-.4^;T1%r=DuTnlu6P$."r\'&GZ1f6-_u_/,@0Q*/D6C\mY0a#0Od!n=Zk]A:$
#+/;_7R%Ko0Ip7T'rO5[><+0l@O5$IYDV:L,>WTuS-/hc?=SURn6RgptRA8VesoVA`,'=Z;%
EQTqZTOAiWKL=MT1%-U1(d'cPL$1+eX>06o.!Ylkh8V*Si%BGrhM5"%V4r?;/PBqZOPg3]A(g
l&3hI2ClIg$YPW6-YPPF1>94pfe'md@HHXh4;NFgs+TYNE*d1OPN3FGR<]AmoD)Xg9]A#WLsoB
`n>?0UBITRe!F_C"Gml^Xbd>Bt(_dMkU-)spbWt::6MJ%/GA'BPe9WIh4'dHejM##9&m:;;&
cB'=9r>UI+TkQ_EBrp34slp,%ttoeA>AN67@-t<(3HdiHs@IO'O#T%\k)dEA/L]Adgg>o.eYC
TDhKT0#R#El9/)hu0/3d.?b]AO>h(9d]A3AL/VsQklA7-0u:lBcM=cKW-"Us,`biVjOtqaUrWf
#cGhgECuC56RAmJG5jqt_gj,I"gTFeJ7En%EHtC%!-Y/Xf'`6/%[qhSKCJrkLFirEYp%g>o:
^'53E5Z0Q96$!s,of$&HE>U;b.[`%Ms?Nlh5J+U2sl)n9X3Jr,\+X.ZsA1-H=Kug9UR2HCN1
rQH$6&7l3p1$q.gHD6\_Z!t3SLF.W&KA.0P21BP6EPrb]A0J0F(a)nHZZP9NI"p;OYj$Aq=`l
IG8]ANd2I(/8m2eo68f/[5E#_d8s*_KG>dELsaBh@W`g@=1Za^3WYlQQH3,6gsl"TDK]A5fQnY
*LW4pf"=dH..UgP$r,8P*+O?2JAUI8*dkmTp0"tKd1c&e:BqJDNm?C[HY,sO&0/]A"ml;*N*s
%dXZnnr%M(a7Y'Zm,M?p$#)J`=tG0cOW8WR>9t5&e6IV71M0uNZEe\4W-8U2bhC['`8SK2'&
7J#=5rI]AV8GZ,R2bPMg2n&t_ocYe)jXgKbpJDG,dEa("%tb,R>f#\;sAlZ$;Lk*Gdj&[Cbm9
?^63R`OXmEVRimZ-^CUSIo0YkSc%WM#mm!+uPcQl.A3jtW[ga4B:H,M0actsUOTqf%1Ne!LK
'WXW,N*5d?`ZCJm]AC`]A#f>#!3]AJ?AeXDYh'tgRG-7c@ZeB$IK#U;M$W6651WbO#!H,44A5Ed
cTO(>a4G(75dN0BYj)P!#o_k$10_LUWr=!!Gg#P^V5@)gI'6m3'GL,.?6"H40KL(XXNhDe@\
>'#bidA<t`:i$1lT]Aiu'k5I%06RJi'_:q*HU9#FLFa\a.ir<;@I5Um3TiW2@nCn\Kj*WW?-f
0#)K'nh*rUtrUcKJ]A+Y/O&!Kj]A3FDa6W5p=(D54EK#N_u3PRlrb[3L#u7HN6Tu+$(_;rEn(<
S$cb[ZEsEMeW4*"!(ELHW#,k8lg.lBN'9RXT#T#=D-O)g/r4a!P]APSG'2Yd%#%T.`$iPa'N'
L/XZ03UF8o[)-h&p(!kS\b2a5BVm-IXc:WLOsu&fT!ZE@2ZmR3^PF.F93&)1tR\ndiqU01O/
VTc)G8gP]A&&9,4k*%Ujq/WQ&[]AD(FM/qj<Hg2#.,-%=[#EhT@D%nqC0)4cdM;;,pt0_mAVJn
VWm8J?*@N;g"LMlS:Wf[<KbuE.-J=PoT).a*[LR7Ic"cKm7X!*\nBVm1.mg2ZthtYZ7?gY:J
J>%<QY+BGtD&8:(lt*;ah6YhNbkSA<.ULPLnm4f*ArJGPu$f#*J%H,#.(@TfY3UhpQ!GRR&J
Mc'<#18bE0gQW*HF5r'4pp9oGbj9u^c60OW"]A\GCE3C8'=`,+Vh(Isd,F_?E%[lu73^@E!'P
Isq[ZI@;l>K@a5?ZCK64CghbJBQ`aY7-`<PY5UM=IK)D3&cN8:[%N^7OXu.eek#2:%d$(:Gj
[2fX2+C\ag(h3H2_[a*6G3/<9K00BQ.!l*0c6nfe%1#T*XAr)ppGYZdu79!$i^=Z`?>IlaEJ
Y1=H"\]At0R(e#rlE>u/^PAFh.<^LJ6B`DK%<G2luFQ,O:V,kH[16T!D`A1Q-Ba&?fX_pGeP'
qSu/Zk<^=>.E0XOr[hS$s]ASS>O3TXrK[0PZapW8L$l-F(0q#/$N70P(U"9iaGIk6_AH&XRU<
9QWfaG54Ua,lsI4TchGYK,<9MGifZrH+aN1Y46mEJ`&NV/XBJ]A1.N4Mdq.)L[C$YEkmon>[m
%m^"X.D7`Ylq<c;cEQdWJ;S/K0`lE`>%0E>k%Wof<Q(&F2:N>fY-P$$K7<`l;ah-iZ#K"++@
WRCt4n>Y`cRHDdTD4(G.@g6RsOgesV1=*L"6pe50`<%9k$![%\4TV,HNK<LTAVgF57/#UFSY
-;Hpecg0Tgl^fHVXk&XD=.m00mu?:3j-OnO>1e.+k\\*$Z@R4g`[bt53Kf`3;D%4I1m'A_Vc
U$c=r`KEhnErA;:4aCSGqiKnsd[T1UA6:gAV*j+>Z<"rGF8b/'#u6<2MQD2L.4h]Ar%b4%4da
?/**?=PA##NGN5mhc2F?WB?qL=X]AE.s-#uA!-#.kWWa7e"3B3Xk9agpKb1#]A.eL]A8:Qt^kKb
]A9f3dSL`CP#hJ.<V>?ign)0.B#:bOr>0]AJ75m0DN5PYngr+>oY*74O8OP<?!Rqj>n;Fg-s!D
-."!<%+0G]At=/bpfb@fTl4i3:]A8rSF_92X4?sk\,G=GolfPl"@h>s"=~
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
<WidgetID widgetID="eef68379-8991-4092-823e-43de4421337f"/>
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
<BoundsAttr x="5" y="562" width="434" height="372"/>
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
<![CDATA[434880,576000,434880,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[3600000,3456000,720000,2743200,2743200,2743200,864000,1440000,439200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="9" rs="3" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[="  " + $jx + "成本结构"]]></Attributes>
</O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="10" percent="50" topLeft="true" topRight="true" bottomLeft="false" bottomRight="false"/>
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
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<j7c'6h%%?-gBe2nIaRnIj+7H@"AQY#)04.$/8QVlX'5[oKB$jE.@)7;e*R5VD(WCo(>^=K
U#;9@d!V'esJ=&OS<B`9:*U80O8Q"L8jsOs)(oaWr\6Rpb&0OBK:fK!kJ[5P]AriA2<b)TBCK
lpO0fo++CO[Er)"\;^P5-1k#&#?[?kCU`V?=9q"39?i?q\bZ(mR-;DWd[JH^92[BcY[[g-<1
F#il7f2/oolYu)Isf5bIeh4:$\/(-K#?'8m<l(kmtHCLN_FnAc+eoqpFF3e8&H209r5TA3[l
Gn%2jKpROfPnFW6mBOjEj4lR.:pE!5/GZnTU-+h@g,2&55Z0p.?A!]A%Wq>#Jg";'?(7d$iYI
O4ii0T1(W-k\78;a-KS@qg8=ERmZC"kT9F2"@JK".:fb="m\'.YZZq?(Hmh%Irm-_B\>fiPX
__c>9"jW1o^>4,7eKJ0q6#*I,I'`eF>If*n&Lk9c=ep`^r_LXCI.@>\9:N8b^:n/DL-QKgeJ
a\MD'8\SRZr\&pOCe03JM/H,DnS*"lMY9?f@dAh>@Bql.M2rCbnTnF#C<$m`q\QSc`L5'Hg^
?\Y>R("*e#Y]AaFP-l!YB,7oQ=n?57HVqkdKR@sRj=V(b;W4),;_<D')PYo.K_&HBoC\J8Xd#
*SZT*t(&qq4Fa4[Gf@HQh:KHi-'Z@m*FXkc2T4)IJsK;6&(T4j`I-h$c.SETB^]As>MRBi<ED
\mit!;Ki!S]ANt(7hOU-4dZb(BbI46aEI?8AXAM#IIu-ZVk=KNIH]A5C8o'T3292"jpkk,`M*S
9oe/IL0Y<jO-a4$Ke;.oNH:P68ad)__LSURH$&Sfr`ZjutO(_T=T@k&!pJKGKD/WN97tECp$
Vr>"&jiYoDqLuC\hdS6R,29?U=_.M\Yku-9h>Kil.UO1:/1B/RK]A'nFp1TB:;$X46V0!^k9,
e*RagDi,ho-@2$H@10VktOOiH\Ia89A$,orki"irXuE>,hV1JQB3F+ogN%BR?1-PQ!@8SY:`
i!AsAXaOYuS(,]AJlg;uIC;06slA8A]AG7G1HdDKPro;$UI'j1b/4cNU+=jYE-C:T6;@BKc'!B
%O%a!M`#fe\Z3<D.fG=6(d%]Ahb;'bh%jB4D2$ZjVb\\VCSmN_3WBPR:&NfsB47#D_ou8H?p!
^W?Qd4<2iRPj"k\`O-X,V:bq,,O&k*7]A+C"&V'GoL/_+-9Fb9h/(1Z5D[mFX`cLS5t`)?Xk`
=A0Y8F^KTER<pKn4')^DU,Ad'L\!QI,34k?jk;GQ4D>&ORfTXpN(0ND_7cfcWe65[]Aj@788d
Ck1!_\h'C;nblq21Eh/ZmpMgZ<=WjH$Yf&nN`@2Gl!_PiP-a!rq=T\-pH.l&?R`,LJ&0(`!T
7hrKjgX==*Y.h?cd%bU,p+DYGT&Jieb6o!m)UmbFW:e-/o'iI"93dP=7Tgm.BJmpnrNPVsEE
RC/1&<m1]A?3e<f;cbQ*o4%K__SFaG<$gr?`ReO.O?(4JE/^_*Ff#W(]A3[M@-5O\:+1/a6[G,
9"b9>Tk^L,U&#r0e0R\V?&qW8AZQkd2GsI?8oHB@+";*B(lJk(h?/or[OY`6j'GfQeqP6\r:
k\g`CYhHO]Ar4Zu2Hlm%Z+$%me@OBjQCi73N"f[k*_+dMI;$[?f'D+'k7hD;^\Q0[l4>,J!T\
9Z%R8k.gHoWZM1VGj+%rSIa8?Hf&)NtfbV\o-elo3;ue*L!sX\^j)R>t('\b4Igga.8u:WgL
@CrkME4gmrs+er<pq\'fFs?Tgd9#06akiC,?S(KRB[#sRAHB)*hqYH"L<0$HMK&T%1@Z^6r+
J\#uR%Y\?N=1:\XCaA\g7NK`Jp\30P;`2#+iW(DqPXAm]A:F5D2CriSY$56/:m-"u,E%2kp=V
p%Sie3M>;TTE(NO6b`&CJ9e`K[M84q&#^3(2X51))W-2&]AS55aAGPUcgsFR2$:f%,79VK]AqB
#i7Cs[7]Ae]APQ?DtOr%s>R)<us/<\?B8F3#M:<,mP56":RR!-N\,2-RW8DX$N\Cq3`g,^QuIS
=uSX:b]AXb-ckXmW>]AGM&%%Ng7?siP?>;d&]AXi5SHrf#DCt7"uW:6'm=G4(6R0c;?5=6L5-^S
lJS`8Q[lH?ArFb]ARpRglLWfF/HMmF>GCldo_!.RhfG.c+P_,g#I<fb$P3jm"AXqT^K+6!t=K
p=_(d6Mpmk$:YC?F;IHT#Z^JKMo\9!8'YLHjquCfG"JbjgQ$JR-^Y*jDJ$o$Tr^.TVFg9!r#
kf83>kTNaS;qq_+M_J9_-:a]A7LEU>)p<W(rdR9e=*k4CPuS>gFN%JG84C'B2bu+<LJfZc^`N
!_Q=I`O<I[-7u15N;8VbD[iZN!6G\c$)3"&YrP&s":_-rL^Ymg4D.3\nJZgXPE!k`e1f/"+*
)<YA1m)i!>Hjc+1V%RNQC^`YN>HGD`P9Ta($rcC9idgu5qT*:&9026^6WlLkC!KFc693`_,`
RQXo/AH"Pf>ZGj$GN6t2\>\\#"2=lc,Sk=ba&jU:^=MtJZ%-L7I5gOHcEMu>u?;R@@E5T2,>
F3K9bWsqkX"uut_Co(u,6R1GOaH=_WR/JNcZ.2Rb=o-jVq0a?!3Ta'oH(mUpF(iT:k209THg
T=)BjJ[Z]A'hLVR?k9&/ai&-1'[#*_l11IVt[g.^B.H5]AW&.&'rL=47^V0i]AAb[C<u-m)kf^N
7>U?2/hgXCTs)37LC`4@u8+6O\2LOFYS-tb9BCBks"I0(5lUYPG%9Zat!Kl/=`@\Tp9?8<gr
/\Hppgd*L1jF%RAG5+L"J:oH4@9NfIMHITG_Sj,[B#l?ZmKLOqb=2M79nBM0_eSJnT4RM`cZ
^V]A)o7*!YK94-#6pM)XU@;:TN9a1E=Tm5['\fKDJ?T`_hYg8ntau*."7TlA!'""j.T@%i9<A
)t!GoiB46^g&I:H:RWd_2hpR%]A>'k8=G7r(4I[<e`3aNL7/o[\(;Ge@-)lDamS^9!9?O(km2
^coSK2c(-S3M;ntl=f1*[M_'c?+^`5t"FM$TO6[0t%a.;Vf4C:DCL0f2Lf+3K6<9O2LXU#fG
rW?"$SFpQApR25;TI(d8(<Kj6i<hJPBCTLqUr[q+)a.-Vqc]A;"5+3$nAIX*)f6'[iG4(RF1Z
X"u,c?^\jg)BZ@7+GocqPj5,$#VrpV%_23.T?@`L,88_V/c\WkXQcn[<tABCso,Z:q[n:#Y$
b+gU_,Bg^^kYKL.mR'&#BN'UFffGTFcD&>\#jm?8pP,<.o&Te]Ago?'$&Z<s@:RA/huN'SQ3,
ji.M"[p2t@8'AkVR6R[`ZaNIiqcQ=l)!MT>XCuYR-WDEZBerV_=ik*OaO^dTq<U/u.U'F[ap
l5]AH@N?IfQAAH_,e68l#fGZ8H$iTf'D%oD/+7r]A0a3aG(R'E`.!q"m(:Qt"_Re\VKsatL<lq
7il7>4[m`&jC>+as7uGY%"8i%*B;0VAcB>lf]As?.5S_Xlp_Kq>UiG7k*@1\=NQGMFagUB,p/
gMZZaM"]ABRlJYJC&TSdB^CGH<qe9AaOqkdi$&'jXLNpQ6fjQ[&PG?n9,=.#:cs.%QA1,Po%*
sk9<j)9@pZh)#=dQ,.<#!ij-R&(Cm:?;iN:nI-'hT.98==,Vk<fP0/)aa;5Cdu#ti$`Iq>on
>+8q9_pCREa^d$2bY-d$Y-2@4c=JQKN(]ATcXLe8eOL1sB`6mO'?_X[J4'&PkLN^#S3`b>2AZ
%Mmid.fIlZ"9s9@"GEf>[a'gm:MM>fD^/;8i'I(``P\0(Vj3eam,9I0GnuX]AoR(Di._O'"26
/W6.)R\4`)+*[dhqs(oG@b-fFl[eT\,Em>XXN;t2ie+H-(^+g.oDYLOnf@!rgp\\kCQZJI@2
BH*kEE*XFb"t'IY8d10WWo$-41As,?UDqWbqn.ZWB49%;*GEL'$[Da<;^3:p">2BieZ-pU&-
0?>ZYsp9,Y(U(@%e-*TkULMCk__))K<82&bhPRDXhI1Bg,4i%SI*T/=5MbKOCUd\f6meb\\2
0B7J6C$3aR%EN*VOO?IaM;>j]Ao)KljC:=[U,E#&.KApblCCW^Y@Vk1<L0>c<SA;Dod0@@*fR
I;[UBWQJd!]A,E2,$bdMgmO4%YKTk@GMUsU%J$g2th-=;.aK^bEpSeWQ\Mfbi=31!"C9PR;(X
>PDuteQ[r[s@p_a`qd<U!17s]AoWI46u<Un>jmcSu3+(`1VN!E+h4=`VH)Cf+YNHb'3,srdp*
BFs`E]ANGZe<gJ=bkTMhn%H!7UGd%cF1tV>"X*]A`:YPp7r#Ge$r4V7$H%!JpDRE8,[\ns5C>D
&Ie"W_p,_`FTg8:THpBQY:$&urFad2W1++fe2^d,.AiK;:%GeNi(pXnK722"u*OuK`rNe6KF
q%A07O#2WFmoA7m+D-eT=1k<YS.On^f";8"OaOUSIVn$Fhk_#_aa=f*6fC]AEoXoXg+Of!uch
mWPRPYnt0]AuM_pEr:Dd+Vrh5V81SmEJJ$T/mURG-@@7&/XhkQg;N6re_7GJ)eJprK9?ef=Z*
OkCgf^glfG%Of*HE'Ce!_Ejg<(_\qfYBE,i@QA]A):o[NJP\IQZR?@\g=8^RYPJi4Ju6`P]AHq
u8>'a!8'b\RI\sGiV1Fk;7G.:0[8C2*FaM58rrH)0DqPG"kWZaqVmo5aAPaf*9l_4)a]AI?/]A
4.c8pt;nJ]A"$F_FsgNPbp1/e^=r)_7;?HYdL@2RdZ?"!0AE\!__n1qDN&3T9FM2&0]Ad1):ge
:V0,IIXU<3a3STqdZh=-@-]Atb_\UEUZOpZ4gjK%jmI<j0.>e0e$C:)$CH^B2j,X:a9?%0O`N
5fE1P9[_/<C`@O^o80R<UY<K_gbL1j:5K#'5f7Xk*\FXi:Ksl156q:WL@`_sbJ"ha;f?rr>b
d-Q3en?MQQ?aG28:l&7cXJI'fVAa&Rf5`3OU,ot`!KWk0Ib1:4p'L3SNhcn;()sD!IqP!iJ3
"`WeUC]ADnJ"=`-1'@K(_4Igds)rM4o*"AtTJoDU)EQSNE:-3QfGNM#FZ`&R^HY@u&Ua9U]AX`
3$-V3!;EF:Z-\FV[2W<MSegd'=X2#V-h#.EXH7]Af;ik`LW]AW_CZ7YDfE\ko+fsS7Qn&".m"3
WA]AaWHZX8+eHEi_el_gD<lU9H'sc`U8&6`d)h)ZSfJiS'i4_!Bd'c"Wb/$f^SJpVng9V/;b>
SCDqTV>'$np56Kgpcg*pPQ2Z%NGm/7Lm``JgSs!,W/9ARfS<=kB3m<AXg)%j<;oXk0M'jNP1
AbR,"i,^PaWpUsDU<LOE\pC#V]A4e\Md;X:p/a;o`l&V<Se_C-.(0,%@>T):IKe,g!J.Psl\#
g(M%nsouf#a!3NB&1EKJ;%XJAuN*lT\#X/%tRQmD?*+Z]A_7f^H."m<_3.[((!&I#C((fU7/2
j7',E=Ec%&^^$0E6!fTTXn#JD7OD8I6X&$oHH=remA@iB[i?iq3G!qo#%[qdI"1c7`#)Oq2#
JERX#nhu$,Agfj-'4RTf$j;W!9U@(,edA?0"Ih(3CD^!ag[P2VhsDD92Ys2):h?Y>B&1W=.8
7WApB;9_NYSE"GBdV.)\iXE?A^aMJ&aKR9&I$OcT;'3EBH+6_G7p.l<!<1TssX/)Le/%HdYh
NLiBJgH8grC#\0Zjg.k&:i8H6R:i@5eH&%D[R?!;t!7NtBPW6#p9E29#MQk(RbB^oZ$!M[J*
8n(/1^H#Qf%27+$M4u?0LPW+Q-54elYiiI4kohT$!8CQ!CQ/1\c'1Bc9>?QkO?r.C92BuPA5
p\WJ#]AQ4os*<c"H_Z[n8;#VJXE[f`puElOP^=TcN:jEds$\0)-4]AX\7sI<F)3N26H`"<nl:V
O(8(9#6\_:#f%0UX9HK]AjTSa:IM%A.Plhr!4+,V8h3rH@'!8To.+b#8O19hHALc\ub>Dj:Z*
A@1T:B<kXL.u[%J'2EHe]AjN^XF+&bBYb%^_VQ<51n.&0X4M9LM+Ms!mHCAJm-(sZp1^GcY>e
>)aHQk1[h!rgQjV_H>t=jVS7O<Kt]A?j!tToai^)&J=r.q]AkY7!BJVKMp@TFFMaT,B?`$c!TX
Igl;\JSfu)sFJ341VjNI2tT-Qa?&(/bs2odO6dm94dG\;hon!l.RUcJ"]Af.pTXN?I(8KR4S<
6<fR`]AWMYNU'h!gAIY,Bidlsb40A`r+NPe_Re#[+=2CT5Bi_=k:,kAq==k9&3%YU&o9iG,"d
>.1&l#N>9*p0kn(mSeOkRHqm7F`3\.b^F*71hl=5bZ<?#,ts(jT&GN3f?Fi>Had=g6dUTRJ3
k=";CQl&$F\34%u"RX`%qIUTRd%@Cla#j8a"iZ5\gWVOTKB_jp+rY(<#7#d'GtS:L`51\70)
_l3>G<NI:e25IO7<'6]A+kf[<$s7BVA*LK?!ml+o%p!sPXT_?:^0h1QW1/a8F[;]ACuV;:>X$N
p$U`V[Gi+GErN9*+Uatcolu<,RM`r636?m-sm.t5t5%Sj\e)MGIC["(n-uh<1dbL!tIQDH_,
Zn:"s\*Ue64O^T)kY<i)u(GV0'CedLFNNt^"8;#Sr+Hm9!,5NVG!+G$ps;u4D/965qmh\Hr%
(-4"t4)[(LP2%$T@]A,^cVVKn0a#4$Ya%ggB"PDY34<]AT&_'7W71XQ/q^aPg-"d!hG@[b@]Ao/
r9:Z(&ad5Vsi)E)'h&[m-k*kB/Jm;>(=8Z/a'#S&$/5CIG0s`GuX=%`BpsEW5QtfcENQn#4>
b:<,Mt[)gZ3F8Wc>Yd.t(XFi=C?]ARs6%?158%5qO)"V2Xm64<Ho`$cSg5A2.gQ:kQ-(t!1=T
;nG8@4OMP5,eU1`4r0]Ai7@)Z*C-[GG%[]A=X'8j.ZP[u[[C-Ga1+&=K/DgCu,!cDqIBEFrqQ,
_7IC_R`CNK*h3Kn+B]A).>`d'.i]Am2^Zk=+mm8]A;^<D&:HDT$LuQ8RR-1U>VY#Rn\L!Tc'72Q
Mb"leClG-"C>cmT:J>&-2a?=+/?:oKUa8qQlU>P)Nf[F_hn#%P1kLLZ[`Zu$QWh:\ai_HNTJ
+b3lL]AZd_fD'cR?0o:m!]Afhl7b[A($`jJHW#XfAYZ?6%<h:tZ@-q6qQh*CfD\25K8Cs^#(*b
KJlfu$f>gmg:EMiEY*dl#eRbRD^EW=/AufmoQbj!(NadRKE1P=@#8qRma=&"U]A%3&S9u?VOa
W$[$eYG?Z52aKbGKhl!3[JA/gP%B$glq+9Cka`o@uu''^V7BLA?jBjMTM]Ad)"YHUc$@Mnk!g
pK3"H"+^=1Wr7J*@rl0:h-$C:2_P'nQII)TmZhbJ6LN+-m+O=nE!6mjJoMas=!(u!g9KD&;T
0A6[C:miLCc'UO]AJEaeu:ORIUcES.MO4#rAmc_"!@Z"?<aHGgkdW<]A75;f('k5O'4.aSR/h)
$uoCGHB$+7e90APPGMY!)igbrb\i0V9[7T%>&Jj='Pe9-.Ud%Dl]AfPPT3olHKjQ/k&j`rg*M
n\ND]A?#4lo6$3J3W7<<TFTStB4\X[9DI3oLNbPft3e^-gXVtWs\rf`-HCH61AqSUJB0a2*dC
PP(Cojo]A7B4J*"Qn$Z1Z]A]A^jK:]AGX0-]AON&Y/=q;KYT63&1pEm/pS->40t"HYk^^`p&9r4ph
@2,Qri@NYqIP0hd;5m.)W))^jrUB!;]AFp("POLON)I*3MP!Yat_\Rk1NL;Esc7Z92R>pdVW&
pGc&QD+n>_+HpO78<2msP`/)0KbnC0c^inDQg5OEnW5`IlC[NK@tc-nP(]Al[?;>jf`PV\)`A
tFX?A28=CEW[_)k^qE]AlptW5+sbbs0+NCY:j4BI\&WC"UecS_g>UQV_h+;"L#=#n95om98@5
UpFpLLcDpYOT</jA@7'_@=W.l9+%YRqCBiLr^!;>7J;?.Gqs-HQGM&&8f'D\%%gjY1fk4W$b
>hiZB`#VQ@&UYCGO[A;3N`h4E=A";l7O+Z34OaTQ>RjGf)hTrPf:W\HP2u<bVPI1T"I]A;1r>
J@K&QdO>W:ig?jW7K<O$\MhLc6jM9cBJcMX@C.3PZZ6daU;dnnrAM96#k`/u'CHMG5T*1PU.
gM)tWT?A@T"4Wg=09qa7ljh*Fe-5-b("D'7ifUf<B;"hR9:g:T,ChY=">VtK:72(*;bXc(0A
h8M8[#4=J"HCHP&5H%;iLBm1ToYLRn2f'mglLN1=+?!I6SW"/eB5DI6\jf@u!5-2_GeVjrCa
fYe"r!*<fgHr/!)BHne'@bOQ*Q4ocAe$'^M)1.:T2GU)YS&K%B6]A1jX,>Vmfu,C-\567W-[\
dFmVHM3I"qC5$Fg_1OEm:PJLhgO0+^9EALC:YbKS36(g\k=Di:*0%j!,.WY6F8g;p!(s+:+)
.F*O:o'*K^HfNhi[uXDp?"W\P+#=L=`8+q#:qAhJl[Bs,&G56aJ7l(lH-Ya[^(%q61b]An*pb
_QJ/T6hH1]A-?PN=afIoko'l4L__'@@>D5',.g>!XT+c?(M'4P;ABI,MpW38t(/5$+ha2[.Vj
@aAhJpR=k/P(rMo!.3PSH7Fjm/I-HJ9K`@Lsi7"`i7'@uVD[?Ff'@Cp$_lFuY,JYUklXlT;Q
XkYam=U-5dtS_Y]Ap\t9^^1g-Nr$HGqjK\$`&PF_(#Qc@E#\5.Zn-Pr9Sk,GmXE]AM;K:r`mI`
Ys[1Y/llsV2k`*jC%E,<oLpTWcS`$h^CuU"DFJC:lsecENCGD",@@;SS?o@"=M;@5jBG8pM0
#Fp5Y&VA+t?U&_Yn]A1R<gc8@/i4LDmR[D3H"u+adI:N7Bk(f<QP6Yl;hCliB4V\(g]A5K4#0K
!q3h(Z_uB,jb4?88`Dle%o.,]AITO__Tau@aS7Pbbg/2s7<`2FBgt81?17f<rh+Cbanr!HoUR
?;`iPVqgOPV*MTX]ArF5b1EWW%LK\+9&opB7KgJJZ%/*$HQgm`fROqpguX9,Q$bOJ<%F?(sg[
V%ql]A!TWpu^5%QCF98*@I;'_jXM_l%(cmb#b(ti\UZ6N5N=`t3G<<D`N$4r.../2eCO!ugnC
2kkI%M(u.PJUdqh:a)Yi800M&!.UcVbjV7m%NQVj7$@ge3M7haOrc9EtD^(+?->R>u]APF/=U
Cq+g_:8]AP+drnW$c^F)l=f*>W4SP^u'j;_%lLJZH@-YTu)><6qCnQjVUe`g@6FhLTDr'n0sj
/qLbFipmo+<9M+(PoL&Q!!`GU9)>,u@J"C'ms$*fc2js\Y`hGNLH!Xdj^\$\\20qDitsP[G\
:RaX9gVe@&>G2.Iq\\L/@!;'-JI<&\XNZ2L(b%&HYraB4%bDfR`5\T_EHZ(?.u9*0gc*"LHd
(9=_8FXRPR)fe6SA0?/JE1k]Aa;9mD[e`/Yk)@"5QgIN^_r[:3s8+HgQSRZn5SX@kg5BLeNT:
*1-gQXMA.p^3#g_0A,q=B!GgQOIS(V?4.qs5CO[m_:4>ZdI]A@ZqpFlHX#=p>7!E?6r3dMD#"
D;Ac#`pIN\N\]Apu^1?=udoIC(kGb>`*!!C&H+"gm0#SlE`*ajh!839Voc[J+\YK8]Af'HC!Da
:DHRpJ\7K#ANMVD'8:GWeY@m,e"nHIqn>-!<L[U1YGpsgd^J*^7,o1!P&)Q*IR<Z]AJaYtrMJ
cYhFK)Cu3cI%EVa05#T%R3EL<4g?J0oj7[WjmP2/B(pg4U1;C(TC-;NS]Ai'HM3[2BD<jKM=k
A0*Sr#W7$+]A*?`!HRa9oRmoduY2Y7+=:iS155"$XG[oG:k]A4+1IXO&5jM/8XXrM7#$RSK%CM
4_i:16"qA6WasFUne1VeAZqM,&!T"]A1/`[#Em'/c1WI`0um42l.ThL/QmBG)@/;DI\QDg;ho
fug\F'tW.1lJC]A-n=<rVjnr]A^~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
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
<BoundsAttr x="0" y="0" width="444" height="36"/>
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
<WidgetID widgetID="eef68379-8991-4092-823e-43de4421337f"/>
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
<![CDATA[432000,1008000,432000,864000,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2743200,2743200,2743200,2880000,2880000,2880000,720000,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" s="0">
<O>
<![CDATA[同期月累计]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="当前决策报表对象1">
<JavaScript class="com.fr.form.main.FormHyperlink">
<JavaScript class="com.fr.form.main.FormHyperlink">
<Parameters>
<Parameter>
<Attributes name="p1"/>
<O>
<![CDATA[2]]></O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<realateName realateValue="report0" animateType="none"/>
<linkType type="1"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="15" percent="50" topLeft="true" topRight="false" bottomLeft="true" bottomRight="false"/>
</CellOptionalAttrHolder>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$p1 = 2]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-1"/>
</HighlightAction>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-14701083"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="5" r="1" s="0">
<O>
<![CDATA[同期全年]]></O>
<PrivilegeControl/>
<NameJavaScriptGroup>
<NameJavaScript name="当前决策报表对象1">
<JavaScript class="com.fr.form.main.FormHyperlink">
<JavaScript class="com.fr.form.main.FormHyperlink">
<Parameters>
<Parameter>
<Attributes name="p1"/>
<O>
<![CDATA[1]]></O>
</Parameter>
</Parameters>
<TargetFrame>
<![CDATA[_blank]]></TargetFrame>
<Features/>
<realateName realateValue="report0" animateType="none"/>
<linkType type="1"/>
</JavaScript>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="15" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$p1 = 1]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-1"/>
</HighlightAction>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-14701083"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="0" r="3" cs="2" s="1">
<O>
<![CDATA[维修成本(万元)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="3" cs="2" s="2">
<O>
<![CDATA[飞行小时]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="4" cs="7" rs="22">
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
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName="商务"/>
<isCustomFillStyle isCustomFillStyle="false"/>
<PredefinedStyle predefinedStyle="false"/>
<ColorList>
<OColor colvalue="-15118441"/>
<OColor colvalue="-11184811"/>
<OColor colvalue="-4363512"/>
<OColor colvalue="-16750485"/>
<OColor colvalue="-3658447"/>
<OColor colvalue="-10331231"/>
<OColor colvalue="-7763575"/>
<OColor colvalue="-6514688"/>
<OColor colvalue="-16744620"/>
<OColor colvalue="-6187579"/>
<OColor colvalue="-15714713"/>
<OColor colvalue="-945550"/>
<OColor colvalue="-4092928"/>
<OColor colvalue="-13224394"/>
<OColor colvalue="-12423245"/>
<OColor colvalue="-10043521"/>
<OColor colvalue="-406154"/>
<OColor colvalue="-13031292"/>
<OColor colvalue="-16732559"/>
<OColor colvalue="-7099690"/>
<OColor colvalue="-11991199"/>
<OColor colvalue="-331445"/>
<OColor colvalue="-6991099"/>
<OColor colvalue="-16686527"/>
<OColor colvalue="-9205567"/>
<OColor colvalue="-7397856"/>
<OColor colvalue="-2712831"/>
<OColor colvalue="-4737097"/>
<OColor colvalue="-11460720"/>
<OColor colvalue="-6696775"/>
<OColor colvalue="-3685632"/>
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
<AxisRange minValue="=0"/>
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
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0" maxValue="=roundup(架次.value(1, 1) * 5, -1)"/>
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
<AxisRange minValue="=0"/>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="6" align="9" isCustom="true"/>
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
<Attr isCommon="false" isCustom="true" isRichText="false" richTextAlign="center"/>
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
<HtmlLabel customText="function() {
var point = this;
var series = this.series;
var points = this.points;/*获取当前分类下所有点*/
var validPoints = points.filter(function(p) {
return p.series.visible &amp;&amp; p.visible &amp;&amp; !p.isNull;/*获取当前分类下的有效点*/
});
var len = points.length;
var vlen = validPoints.length;
if (point == validPoints[vlen - 1]) {
var value = 0;
for (var i = -1; ++i &lt; len;) {
if (points[i].series.visible) {
value += points[i].getTargetValue();/*获取点的值*/
}
}
return value;/*返回相加后的值*/
} else {
return &quot;&quot;;/*返回各个系列的值*/
}
}" useHtml="true" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
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
<Background name="ColorBackground" color="-9390107"/>
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
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[架次]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="发动机循环成本配色">
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
<![CDATA[发动机循环成本]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="2">
<ConditionAttr name="周转件成本-维修配色">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-13679276"/>
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
<![CDATA[周转件成本-维修]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="3">
<ConditionAttr name="飞机运营定检配色">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-10379096"/>
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
<![CDATA[飞机运营定检]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="4">
<ConditionAttr name="飞机日常维修成本配色">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-2850203"/>
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
<![CDATA[飞机日常维修成本]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="5">
<ConditionAttr name="周转件成本-折旧配色">
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
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[周转件成本-折旧]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="6">
<ConditionAttr name="大部件维修成本配色">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-9134205"/>
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
<![CDATA[大部件维修成本]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="7">
<ConditionAttr name="工具成本配色">
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
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[工具成本]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="8">
<ConditionAttr name="技术服务费配色">
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
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[技术服务费]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="9">
<ConditionAttr name="周转件成本-租赁配色">
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
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[周转件成本-租赁]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="10">
<ConditionAttr name="发动机小修成本配色">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-11246224"/>
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
<![CDATA[发动机小修成本]]></O>
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
<AxisRange minValue="=0"/>
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
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0" maxValue="=roundup(架次.value(1, 1) * 5, -1)"/>
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
<AxisRange minValue="=0"/>
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
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[1]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="1">
<O>
<![CDATA[架次]]></O>
</Compare>
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
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[1]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[架次]]></O>
</Compare>
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
<ConditionAttr name="年累计">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-14071687"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="NONE" lineWidth="0.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="DiamondFilledMarker" radius="3.5" width="30.0" height="30.0"/>
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
<ConditionAttr name="飞行小时">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-11487581"/>
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
<AxisRange minValue="=0"/>
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
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0" maxValue="=roundup(架次.value(1, 1) * 5, -1)"/>
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
<AxisRange minValue="=0"/>
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
<Attr xAxisIndex="0" yAxisIndex="0" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
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
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="堆积和坐标轴2">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="2" stacked="true" percentStacked="false" stackID="堆积和坐标轴2"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
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
<OneValueCDDefinition seriesName="成本结构项" valueName="成本金额" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[维修成本结构拆分优化]]></Name>
</TableData>
<CategoryName value="年份"/>
</OneValueCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[维修成本结构化拆分汇总和飞行小时]]></Name>
</TableData>
<CategoryName value="年份"/>
<ChartSummaryColumn name="年度累计成本" function="com.fr.data.util.function.SumFunction" customName="成本汇总"/>
<ChartSummaryColumn name="飞行小时" function="com.fr.data.util.function.SumFunction" customName="飞行小时"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="fc6bb683-4001-4702-9271-30eda2280b07"/>
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
<C c="7" r="4" rs="22">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$p1 != 1]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性2]]></Name>
<Condition class="com.fr.data.condition.ListCondition"/>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ColWidthHighlightAction"/>
</Highlight>
</HighlightList>
<Expand/>
</C>
<C c="0" r="26" cs="7" rs="22">
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
<AFStyle colorStyle="1"/>
<FillStyleName fillStyleName="商务"/>
<isCustomFillStyle isCustomFillStyle="false"/>
<PredefinedStyle predefinedStyle="false"/>
<ColorList>
<OColor colvalue="-15118441"/>
<OColor colvalue="-11184811"/>
<OColor colvalue="-4363512"/>
<OColor colvalue="-16750485"/>
<OColor colvalue="-3658447"/>
<OColor colvalue="-10331231"/>
<OColor colvalue="-7763575"/>
<OColor colvalue="-6514688"/>
<OColor colvalue="-16744620"/>
<OColor colvalue="-6187579"/>
<OColor colvalue="-15714713"/>
<OColor colvalue="-945550"/>
<OColor colvalue="-4092928"/>
<OColor colvalue="-13224394"/>
<OColor colvalue="-12423245"/>
<OColor colvalue="-10043521"/>
<OColor colvalue="-406154"/>
<OColor colvalue="-13031292"/>
<OColor colvalue="-16732559"/>
<OColor colvalue="-7099690"/>
<OColor colvalue="-11991199"/>
<OColor colvalue="-331445"/>
<OColor colvalue="-6991099"/>
<OColor colvalue="-16686527"/>
<OColor colvalue="-9205567"/>
<OColor colvalue="-7397856"/>
<OColor colvalue="-2712831"/>
<OColor colvalue="-4737097"/>
<OColor colvalue="-11460720"/>
<OColor colvalue="-6696775"/>
<OColor colvalue="-3685632"/>
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
<AxisRange minValue="=0"/>
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
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0" maxValue="=roundup(架次.value(1, 1) * 5, -1)"/>
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
<AxisRange minValue="=0"/>
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
<Attr showLine="false" isHorizontal="true" autoAdjust="false" position="6" align="9" isCustom="true"/>
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
<Attr isCommon="false" isCustom="true" isRichText="false" richTextAlign="center"/>
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
<HtmlLabel customText="function() {
var point = this;
var series = this.series;
var points = this.points;/*获取当前分类下所有点*/
var validPoints = points.filter(function(p) {
return p.series.visible &amp;&amp; p.visible &amp;&amp; !p.isNull;/*获取当前分类下的有效点*/
});
var len = points.length;
var vlen = validPoints.length;
if (point == validPoints[vlen - 1]) {
var value = 0;
for (var i = -1; ++i &lt; len;) {
if (points[i].series.visible) {
value += points[i].getTargetValue();/*获取点的值*/
}
}
return value;/*返回相加后的值*/
} else {
return &quot;&quot;;/*返回各个系列的值*/
}
}" useHtml="true" isCustomWidth="false" isCustomHeight="false" width="50" height="50"/>
</AttrToolTipContent>
</labelDetail>
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
<Background name="ColorBackground" color="-9390107"/>
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
</AttrList>
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[架次]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="发动机循环成本配色">
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
<![CDATA[发动机循环成本]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="2">
<ConditionAttr name="周转件成本-维修配色">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-13679276"/>
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
<![CDATA[周转件成本-维修]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="3">
<ConditionAttr name="飞机运营定检配色">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-10379096"/>
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
<![CDATA[飞机运营定检]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="4">
<ConditionAttr name="飞机日常维修成本配色">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-2850203"/>
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
<![CDATA[飞机日常维修成本]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="5">
<ConditionAttr name="周转件成本-折旧配色">
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
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[周转件成本-折旧]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="6">
<ConditionAttr name="大部件维修成本配色">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-9134205"/>
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
<![CDATA[大部件维修成本]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="7">
<ConditionAttr name="工具成本配色">
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
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[工具成本]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="8">
<ConditionAttr name="技术服务费配色">
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
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[技术服务费]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="9">
<ConditionAttr name="周转件成本-租赁配色">
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
<![CDATA[3]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[周转件成本-租赁]]></O>
</Compare>
</Condition>
</ConditionAttr>
</List>
<List index="10">
<ConditionAttr name="发动机小修成本配色">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-11246224"/>
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
<![CDATA[发动机小修成本]]></O>
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
<AxisRange minValue="=0"/>
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
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0" maxValue="=roundup(架次.value(1, 1) * 5, -1)"/>
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
<AxisRange minValue="=0"/>
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
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[1]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="1">
<O>
<![CDATA[架次]]></O>
</Compare>
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
<Condition class="com.fr.chart.chartattr.ChartCommonCondition">
<CNUMBER>
<![CDATA[1]]></CNUMBER>
<CNAME>
<![CDATA[SERIES_NAME]]></CNAME>
<Compare op="0">
<O>
<![CDATA[架次]]></O>
</Compare>
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
<ConditionAttr name="年累计">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-14071687"/>
<Attr gradientType="normal" gradientStartColor="-12146441" gradientEndColor="-9378161" shadow="false" autoBackground="false" predefinedStyle="false"/>
</AttrBackground>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrLine">
<VanAttrLine>
<Attr lineType="NONE" lineWidth="0.0" lineStyle="0" nullValueBreak="true"/>
</VanAttrLine>
</Attr>
<Attr class="com.fr.plugin.chart.base.VanChartAttrMarker">
<VanAttrMarker>
<Attr isCommon="true" anchorSize="22.0" markerType="DiamondFilledMarker" radius="3.5" width="30.0" height="30.0"/>
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
<ConditionAttr name="飞行小时">
<AttrList>
<Attr class="com.fr.chart.base.AttrBackground">
<AttrBackground>
<Background name="ColorBackground" color="-11487581"/>
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
<AxisRange minValue="=0"/>
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
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
</Attr>
</TextAttr>
<AxisLabelCount value="=1"/>
<AxisRange minValue="=0" maxValue="=roundup(架次.value(1, 1) * 5, -1)"/>
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
<AxisRange minValue="=0"/>
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
<Attr xAxisIndex="0" yAxisIndex="0" stacked="false" percentStacked="false" stackID="堆积和坐标轴1"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
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
</ConditionAttr>
</List>
<List index="1">
<ConditionAttr name="堆积和坐标轴2">
<AttrList>
<Attr class="com.fr.plugin.chart.base.AttrSeriesStackAndAxis">
<AttrSeriesStackAndAxis>
<Attr xAxisIndex="0" yAxisIndex="2" stacked="true" percentStacked="false" stackID="堆积和坐标轴2"/>
</AttrSeriesStackAndAxis>
</Attr>
</AttrList>
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
<OneValueCDDefinition seriesName="成本结构项" valueName="成本金额" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[维修成本结构拆分优化2]]></Name>
</TableData>
<CategoryName value="年份"/>
</OneValueCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[维修成本结构化拆分汇总和飞行小时]]></Name>
</TableData>
<CategoryName value="年份"/>
<ChartSummaryColumn name="月度累计成本" function="com.fr.data.util.function.SumFunction" customName="成本汇总"/>
<ChartSummaryColumn name="月度累计飞行小时" function="com.fr.data.util.function.SumFunction" customName="飞行小时"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="4bedfb40-3575-45af-baab-9f97d72d43f4"/>
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
<C c="7" r="26" rs="22">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[$p1 != 2]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性2]]></Name>
<Condition class="com.fr.data.condition.ListCondition"/>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ColWidthHighlightAction"/>
</Highlight>
</HighlightList>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border>
<Top style="1" color="-14701083"/>
<Bottom style="1" color="-14701083"/>
<Left style="1" color="-14701083"/>
<Right style="1" color="-14701083"/>
</Border>
</Style>
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
<![CDATA[`4ZIV;eHn)g/\AV&.oY15Uo`15qo#ERF3R@<J3C6b)f4`<2Lf0OJIJc9Sk_/.M*>K.KYUN9L
pBp6j,o20IIFo.7T%W`d82/^OBN5fR*XFmoj"tB[:tMIeW=ocedhJ2!Plm9=Yce/&(iA)nDR
OQll:hRq7\"^0.a:7LJp[F_#a82r?I_Il@>kGYmr:GrPiQRhBt/bFHMJ`['ZR)`"HYDVrFs8
FHh!m<IU@cK;=9<NUTCgJTKR5*,$1ARZj4;YIf<<9EoIV1&*!5$2j`Fer`6ZKYCk>BPojo<T
3\j+Q#p3cFnh'9A4J"e=4ciT;.YJ;`nVBn.b90_BZIOTlO1D!R\FI4mB/c8Q66CKK(sR@XW=
O,1b)$[;)8:QuAXf#ssW2eN]An-5)GO*rS\?oMd0?n1@+0_ZmrX^KpQ;Nd2*T)ueaHcRodF=o
hqraO[Rbjqd?;X$AN1s)[EsB&Uo;!d5b>o3)7P,?kp:7?dQ%,$usV_6ZB*a'A"f1b.k(s*5Z
1W@VB16o\S2.#s$lCAQe;VZ$4<gU,4ckk7,_4)]ATg,Cs!bT:[5_\0XQ#i>_]Af='gjmI5hltE
W@iZH_O=5@IBGef']AHji([aU69%RW@*KKOQ)6^jWS1h\n`I6Q/`B)>/`)4VXn9(aiWZSrU[O
3Kc$e/@D)CZ-ROJNd"bE("9+f@$<jWk+79TPtfO&AIWg+UeT@Qp+$KZu^6_f":4OhCGf<&7H
46_I2b\SWE\l*:b10V.@%o]APfCWu]Amm^op%mZ59gGR[uDq,2k[m=ITF[hcL,Wgd>X-f@.ebT
Zt%41)Cm!NN#!@IjL\TK+%CU\U"]AdmbM"io9Bg/IsY`Q*iA#S3eT!)Q6!`n80+_&C#E%*YHI
cV]A@H5=,`?Zb2O@MNMH4LbGSX-h;?!cc;:3B2kR`m$/[DK[/1%a@`6TsaEue^KPRTB;,#;7p
6KU!UH-a9h,qLHQaR^WR.c18fJW=5$]Aa6?[?FHN=rI_LAOn-VDGC$$GaqK-$6G%;S=\5kU;H
noIp1o=?3ot4?:1>gURru=CG)AF8+o%%;LE!Rib"JO%u@0*pkR<qb59c>$d:KGM4C*#"5+UA
5:`AJ5j`g-q8U\.)Uj5iGH]AEjbR9i`'cG$uLf9btd1)hQSQsJmr!.3/-t(U8_DU[!'+;SJ<@
<f2*l6o7:S]A]A3qob6(m[!)`b8"e&&SJeO%/J6?)fQJ95M.CjIL&"pq1CS,L3=&(3i#bF4;gG
53jWsV:"9hs45O8_M-%Odaq:S[T4:AV>i0NHmD,(0=asgl!F^pJ@!snikp?\d^6'js?)*G7H
npQc(]A@ZcJ8d4Y0Ji5![Sj6:CjWi,=JP#sSXaK'&#Z0mc8>]A\d`"Gfp$K`=Z)FmZI^/+M-`;
Wt=12Mo@+?lH_,`l]AY,OCh$W18#HT8^(c]ABmEYVcAN3leJB!:Co^X8q>DdkhrDJ4iYO*IQ66
_k8;P0IL09\f9:mT_^Lqola!U?CQFDS;`C3m#:sK'`sEY#FaHpSl:Br"T_&HoipUs]A3B?G>0
g1Ip)g+Zg`]A*jQO;5,eB&oFm&[B@H5Cu/O8iFA^nk#&.iCVN>M:N:jKpma!$\-+:Au>;Fjh&
-HSKQ+g;Vc/rJklYl/bn^eRW%F&';Ol,n:CuBaX<k)@^a\:=_@M$tPeI/rlOuY$HT7I%u.^o
bn*8R/ZHE1<bXEb$c3&bX)t/nX4klcU9dthmoA>6(MbnQ49P7Np9`ESb'bKgeU]AOfk:%&-Xg
t"H&D$Eq40>9dg&OXg]Aoi%AOp8U1,3s$9Ukon-nVdeSK108?X97EB`J"%r%A:Gd<`FgS'pH>
k1QA_]AR^Fp'.8U*SH`$TERI(TKLW10^&*;$iF[;@#mpLY^?9p%Df&?5+/(=`:ip81QX2?^c!
$%;"SCHp?F5RGHPD?ObkTl:H.Q%k&oAZkW>_QePNFuTN;1lU;uF_:WhmA+"KG7:cs)aQBG-q
bHh_!^*TjLU*c%N8:H8C?iqL3)5#so6rd>'oERIp5\+D2S>k@C2R^pq;kM`c6\DqXj:8Y^_m
nRMR:`P.eCNFi1=_OH=Z]AYSa=!Q98P(QkkHC[f>hK>*/8<:0uAI)VH'_L%UZLc!InVjo#h0-
tXgrDs7be4RXp]Ao&q>StmhVnB&8UWPHek1(?!r:%DkY-X$JlqTNub>j-8a1RB^S><#C*(%&R
V]A]A1G_Jfa0)8>[Y+[up0J/O9'7i9O]AjbQhPWq^8W7aG$,NYg'&L#q(H'?/Nbrf+uH3'GI1Vt
YZFPFcA13L*A]A7pB-Tr1&27Ua]A#/Q^PB(?EkV'U&<l"jf<WTl9eO/VOB?hGIl(g0E0K%/.Rp
@4DC.rNX?H&r]Am9Bp<<N$%Ha`3?96nQBT/k2T!EY7]AUime^,:"1]AaGnE.S[Na<#S$G0[nsE$
S/_uI)8)FITE)U/Dg!K]AW5r\6UM-a\`T4;3k*GYgThO_%[XK?CJb.]A1dVlGP/Ifd.i?Bbbr>
>OC#h#?`8nalToA$ArfZe_#CpRb3,a-C/Ha"Zd[nq>Q`@gUN&it_2L]Aj1*g7V4Y@7UA-@B(o
l./\M*f+V+&Y``NkbNe56^%rg<$7U$]AmId2Sq+=V<1>e[3Tl#$qq+i]ANC%C4EE6E#an9SiQd
I;@O:#Tnb5@+d@PbYt79'iTppom:[_]A(5Mga9j=%#5_S/]Aic4\R_KJ9KVLD[[eBkcDG)I0JJ
Oca09R3-eM"WJs(s2Y2_U5'GccYgO"oR?6^%p2P.=:o?TAC3o8&fi"S$Lu3U!YnGSB&QAOL8
d/"ngEYXZYP8;"9RNn]A-UDumk`-S\Lerigj'q_fSpc(%m(t)tV##0kT0kj?N56B/Q>h6(g[>
g8Y%4QPO8QOO%Hagan/-0/6)L<HTLh*F\Qh+1ZR>ELi]A\<]AHC7S18<Zh'?fU3KJ90k0>.o;N
1_XaBJ^XSbRU&+dLUo$l-T.%LQ`??DFYsaii30Y^IQ$19:GETaPsb4/mI;qT#CXhR9"=n%!C
AmJk&a,5!?8mu.@S(?k^4G?Aeq8fi64A08]A-t(Vj;`O4tFAMWJU3X[Qphij&1uX#f2[d%/&X
DO@(galcIJjG5oO?hg-4=)ahH>ruYQfiP#7%3upBQ]A#Z)]A8P[0,LbC@chES&#g&q1/+o;5Xa
`m]A02'Eq$BDObXjo;mfrriT3p\o/=T`^+9e"7f*Dn#!O0i%UI8VW[`.>Sl`Bp0@nci6P6s.:
oS=eHDiQWQi*W16r%-SFqE!bWfMiuon2l\V3s,=SB8QLKOi"Fi#ql$hRgR$%k7$u:C-l&2Dp
)-BF.D:uJds4Cmq/&GG^0^*V1%#Cfnl&%fq^+Z?3)Z$6eF+bY`H]A`[Tgb-$RTBMU&I]A=fQ@C
KV1iJCWm4#VfkdGNFo)JX3le*:QsU*86O]A9=]A'b5NAEWLK?b@eSLJcH&:@lmJ$9,6p0OaI&X
U,VB[an[OW-(k359bj[$pcB%FcB@D2\c;T/%Vl6+dH.VVZ]ARNbuPB1DWX,C'd_hct"b=^VV5
J?M-YUo0.-N9_C:FFr.(-X]Aq/)"F5>'7>b]A&eT:d%$+k$SACnU$T]A'F#hl4m]AFX^E)n$HK0-
d\hXicAR926U4J'4f>Q]AE>oeYTRa)op0`S/.MP;TKF$CA1:Wtk=dFf.<GWJ03/R^@Gb/,mf-
?fA;p%`q-s89K3eC;MaMpA,\3R2,TWIUl>hM]AltSVKE'6/3`eOoSg#;R7&)2s*79=,#'Uc11
KQYQFbqL`Xd7@?$#2.Wq.Ub<X@@s2+WbsIUc%S=\KUE.*."SHdge3H,!K'n%^Of9sMS;G?-n
^rh-+ei$dd_b':cWVK7i<4IIR\FCcogiPZ=Qk%/9&3EYdOZf;4pRbVV0<I_dfYG^Z*mRcr7Y
N3T(PIS("U6Ho@]A\,q"k@1TDMp=G=ECphk+MYC&3F568)53jLF/MK`]AIeennrrF]A,'K^F9:5
3M".kB;3T4/ICcL6%@.b.9Wib7S_ES,)8SQs+4aCll<+_L)OXQ\\D':bs=Ti46DQ)"[SIXWY
Z&g"SractL+j9G/%Dp]A.ioQ/YF'JilqN/`Le&NUpS'5I6rX8SG!^.0!km>uCRol.e^Y8[]A:Q
d.kB=%u<kc*'3FST<=UA(RfNHEr7mC^efnpZf_4sklN85ARJ@)&Vk?VUF0hPPbce;i5hMXS-
k7BkE7B,#=f,=l"+;sl?YY'ec#R<g\YFEiGrhMto-X,4/A5_e0[F/mR3;eNX1<).]ASh#h]Ana
.UVSmYH+"iT/^$&\jKBC\m9r5;d:L%O-Stk:Pn`87[SS`"RWb%6;:'21ZsG:GCb?nnlQ`NEA
&2H1a01(eDmpU!Bt^&L(IgG@Eqf[2<!8HE5JpXEX*<2PC@'RD!2F>dPIXM:?&>KX6!Q^6qj6
$PE4T'tb\*?7K.,rfO-BF6QV759"%i2)3`O8%Q<.936,+3gT&lGE16]A/OpN7G6mN0dW1W_C-
j\eW"F*hi&%]AcFE^Q4.)M:o[-&;=2CZTS,*VmFj`E@13sgd-f$)$J>nO0!_hPQ]A,Q,eOYMg^
GL1GW6I!l-+6cc_03-p;$nj$7$PMJMlXnM84WBF2IcR/r36\H1WLf!'J-#!OQ9$_@A)G?K&/
AgKX,2l%@f6M2pDgs(\H[=%BaI`'HH$l2$\!d7#.K-o^M1SBgkkom9]ARQUU2rMd(S-r>0/pZ
uI4f.Mg.10NQ(.:GmH'`m_,"pLi%E5T_CgF4fjIWd4Vjo(YH3Z:Q<9ChIh;9E+J'_-!rh9mM
(#ljJbiAY5b9+t(V.3tYaBNf2#GFcnWl#Gjck,J(^YUJQ(6U9.X7k4_.]A[tL+4@B[-2/aoc[
bc$EZ!c?MR*6e&]AQ]AZoPg`O58Mr22a&!M06_1DFqd$7iOn`C'\HcTka9Tc03&Yu&1jj-0]ALe
pOlaJ1_?6<63\2gG=%&2:R-^'.hZ;Ki[Df^$+qeZGe@1^K]A&l>-71O>/BB"CSdCEZd)5V?>j
)F'dQRTnE?AS8+d[B_\P2iumKI1I8D=W1>hnJZe^P&)TNYp=No(Ie@CY@#IU?jFdBhaDepg#
!2(O;TBXc7_f#NqX(\;cO6Q#0f6e;ebShWX2hRZd,^n1f2BT0o3<UJ%Ku`HC+(a)!\".MUdA
R+H8LQ<XZ[Z5i475/4u>!5#P6e"nTS0Gh5C#fXgYOerH)nd/moI(o21Y>.tjd)SB2mrX.2Ac
%2\*3=dc/p,X>8?NdWG#2]A_HPm^iR9MM#p/]AG!+nVY/btWY#!S,XgWF-u&SP*s6[u#l,I&:@
$lO]AWdpR>gPC$3_mIrUQih[R]AB5<[CgYHS<u3/h6l5/-0OS`-0lJA56UqTF98YYtmj`5u4N*
+mR<a^Z'.d%Da"Vu[=*TH>'Z]APH=9bJo3t\J)ls,)jZbr6]A2[>P%P*RXuWZEljHkBc.1>TlL
DNLhX]A@A"9_?:N1kZheJ7E..oAB[@a--J_If1+oT5HreaYlH)e.<[eE)+e[]AOj"rSjCC8u:#
;U8;^;&8'!TX,!FYL,h9BMbB1N]Aig%`pDt,^MNj&a@L2F[0t+@9#>%$2<]Ab"mn'fR(B8AG$X
VOiG83+trJNls!f(htXk,=DiGhAA"MIB4aA&aM*Q:L*G%(C"]A.B"U?1PNnKaGNQQE0PP.#7k
0(cu'q"<5S[ogQA'<`/UT6j?V@AS>jJ'0@SZf^s.ars\a,V;f>egI\or#Tj^*7h`H5.[MA4S
*9"HHKWM_qtJ,2on`d+?T*4'Z\am(\@U]A<!UU,Z@I(7mrL[kW80t7fCmfK2C'dXY/)1oG2jR
VXPaqnh"!j(OH/8SjDKr0Eie5Urfp/j1!)q`-^H%&S\tUMRKA(H&ag6n9VG^!0rOTa;O8jDt
D"AnP\EUW79`)='&i:&>;7AaEQ6ifK(JHJ!g^#T+gIsrZJ4UAZ[u^nf[S(=[H$RomlPss^Zi
h@IiFD$j1:*Y:)P/\hN]AdR+e$l"IXk^hCjrC^6?XbWq:?>@=jk*itTkb%/R$%M&l]A`l8BQDi
EG&fRjJ^g:V34Y\h!%F;Zh:a,c8S?PM=\=fIPR\W2/B+U>e#d<@6Rp2[P08h5P;.6M>u3MTZ
cHRTXhVQV>&B6=^>mLj.0n"`L8PkK9>`f'6-mUWk&a)JG`+N.G?d)r^b0k^gOe)e8<6s7LpT
OhfWJ#cD>edF=tDo6?JsgDg:FeW@,u.R=Bf]Aj5_AM:.Zb9k$#/>Z)GnI_75P7+UD-qF$,17O
A(T&#7qs?G<q5QV+AeZTMd0A\!jR#?gpVZ-7+s?l8H[JRFL:>#>6lCFPWR,-.B"a(rf;2SQ`
F_&j#p!oG?*2mBT$'V^jG6RTA)a2:)pDU,L!Bi"H'3L$6"ds-N<22<u1DBJqao!N[?m/*]AN%
91:0(E5BY^LE;RgVC28^]A2qBdS;\i&+'\Y4:1F#b5]A4!;@&]AlB[\>6JImi:4iSOMP7$usDqj
G't<>e6VO=?MgC\1os60CmE]AohSgL#2'HRI)!L&4-A3<F%n"A%&K`-n`8\<W5\)*5F12F`d:
/KoufD(a:4d+q(17GJ%nn*Sbs0p_M%,i)Dq7!QCj>Nf\JgOkjX/7WulB38bZ$o4^Y\#/rYuR
_Ca[:'bATgY`)+GCF%Y=[<-SXp)M7tdKX/&YR01.)<gA:$8f",iJhG!ZMF-Q3boc(W7.f$%6
9ABhJJneYmYE4]A,Jftc/J@<.t!7@-K!!bhagpBKe7WtbXpZ#TI2'^G9!>kKtGth@80C:UM!M
!Kp;c"<4\nt?^XXUmHoH07Ll/VHaum#'$,`4<9$VDHB+EW77n5Kp\r2$D4eNZq'p_?/[87H#
BtFJNj9]A&S6ls6A6rM`P,+A7e:a!Jc6'@8ZmKNLOc?jf?a$]A.I4e.NW9@>,rN)[-3;$U>GZu
U4F]A[QXT)C:GL*l_l3m>Og;uHXgO+9C)95.\`VV@f#5C]A;s?:i3'aU:&u4e3l\(s)<g2N;NY
Eq&-QC;4J]ACT'rp5^$/rW[Od1GZP6ZZeqp%X%6oJP7TqK;PJ*%4c-._fC*9meu0\p\34mrKH
8K8W$muZS>F`R8G(&qh>Vq+g+Xc7f]A.e)Z;b8#;'MAb)rYD$"Jg;=\Zif/9jI,YYb>_S]A0DY
0Bi-++:krE6/[Ks(@T&0"WC2#a-)L[p?*YBs1&2Q+:MXdo!)&;UM]A2e>2[S,m'Q"8On&%Vm0
@%i7.N#:QPsm=qqXEk*KFQhE9sLPM^lFg;itcfh_s#uq=K"reAK3AVTDs3q'@FBRL"j$.(F.
0L:k<7*k`n8H9GpZ*An?Qc-C_[EcV"a*@#S.FF%XL!:UU/k<YEbjFZp$hQ!oYfk(a/@S)3@b
R(HW6cSbBD'R4(XbP>+M>.SXC"Lks<-@erS7"P`!>L!!G\no'rb`+k2%&OB?e^mI,ocb$gHh
ktYJ5'qKBR*Vl=?Xi@DQARC;/sISQOT@''%"_I_*R`GF+@?Z!u0^(9=qo<7'GDHeF$[pD_&]A
gQ0(k+QO,L:iZ7Nm+p<m%]AYtE(Zd>p;8LR$VAEa(02imYJ!gs)oDe"!G6PeUCG`B-3Dq%?C%
jM("g(rOBmmUl[Z`UllIe#Jh/7lHFDBN<\7sc4nYO*6!8p0P5q]A@$`&+Eb!JX\f?]AtKt@iUS
;qi2ePjhhS*0V]A:N=HI?C.;/<Z\)^e&^=AXfJ.,_EpNg+`W$kJQVo(^K&,6\h]A3$93%?8qP9
N`slZ;/'!-a+D:a[/E^Q96q@q?c2)3N.YV+igfOt5)+p8b2)<a6jiOHnH/iT6N4p"HFB12%S
sL;MG)Y^_N(4e`]AuD>P2%<?*bAF%<1RC8<88BD,++q))"ehj*Xc/dom(Hn+l;akA2sp'FD+>
ZL_RZ=#MAia4R*T!hnDO\PE0#tnBLZ6PRqtFf="h;#qDc5r'D".:H<q,)Xb7/b<6EOSVr?lE
ClEt5URpEP=KBuAOSi+Ft-pC1@e_NdIFPj:KS`2:_gB/@K&*G$^pCk$YLDob%Ope#Wiaa]Agi
Vq!\j:nlh*Dp)4/tm2At;.4/i#@R=tkl$a$/Ji@K8Xd,L^t4S`Y04fjk*$obY)b]A4Gle6AG'
>g]A8nZ5!Mi0=g`Db;ger5g"2P#31\YCX?&TAZVe^!%hb"_:fZCSb.3O_(!GQq./7Sgg,II,&
mX9_qbVJFV@m$kO/6F&?Y^Y4WX13>:&&/F5"cT]Aa2N@+E4/SI;U.RdbUl\n,'.%h-1i-C1&E
$)EW##H%`HO@`V*F#Q$g]A^gN_!R/pAQcH5;l[%eLAI*03+IW26ja?/NKl[E(]A,0reqf/+?.H
'8>Z%I'gmd:QL73K?C*8dZ#>bHbmbaK@"oK-PkHP0)Z=0/#.(cnW4CAF\s"HZ4GIhA"SP`+P
MbLQ=I[TEejP+P()Dl<:Pb.0s5Q@b+iQi+5AW7+pXZ"FMV<a9fR`(d_H$V\IfuUAp&p7I-^E
JW@B0W!aFu.l*O[/Ym&-?7l6W$<,f3DDIXXeC5&J-!u$Z4m5kc`MRa`j9%nO9A.RBj((g351
'Iq]A/q)?ZR;DVao"^W04_)b]A<qdk_<91*Rhk?SZEpjto%u3dS9%82?C]ABAO>k;r%_dU]AZ`Ad
Q:eL@dbO;=\D,i;]A=3C7''Zn@HP5t7bDGg2H::i!&:F:\#'3L$*)8&2@Sg)i#5Z]AoA%g'$`J
B_Mbq*Fs*lncEZ0oL=TredK!C_cJEo&rmI@Z[6Rh$),21I$u6PbrHai.%p]A%KT"(fZ`h\I\j
*5;h\/Varf!"bNBZk=gRQd-M+\Y]ALK[hB53A7FI(7(E_?:.:@jP1daq?Ei&^t8TO]A:`m#9h-
6#/-Pa?rNOG#4c)%XsM69mNiCrO?kif9C[5Ff^SQXVZ4)FtLY!5s(ao[r>+M(d)-JCbEnW&(
8[DDU%Q(YucB-hCW'O@>qBp<FI)N]AA2^t>8M6o?l?`QT\8B!R^.*sc7Hp2('X4QHn-Tc*(Na
BE^UG1U2K8H)8J42;.D_r:1!mCXJ``7rm:TTk/[6[&l;\SK_^=UeS5(r#<T?>9LD/hE.eA-F
\klsd47$c+,b#PW"@Y0@rd]A`XD(H'P)@saB54!<"I4)*jf(&_ZtS]A4?,QSYcRqB@QqZIaEbl
;siX(Q#&og5\\<OM<1Z>qf0FQ3#SkIHFLGQa&ZoL3`#cO_"lJuJ*@<R7,?+98H%3R,VV9i2X
1!U^Ni=LW'4(:V2j;>\GLjh"(jtJZIOr"qt>G:#1p8G;4Jq?/Te#*W)(@RWXJp%W#EHN$?G:
0s'bm(Aa&ucgG=L0`7ri1]A5@C%(2HILU<N6sc-?0$"62L=`j:oOk>,d61qfhncRToRHLa@aj
sFH7Irj[[]AM4.?N'KDoTpmY2$YmoE#m\9beOY(>>F8K=DZedVbFU<f/.ZBg%_ThJjSfJXM`m
-T7Gcg;jmcr388*&2%q_86A"MfSlHd*D;ud7sB%YLbV=,S5r5K^K9a/Z&-Xa?YDGZ&"Gcoln
@kA2#R<H,QBAS!ZJd'E&ZU1"0F#o!-6;m'9#bGg&?bBGpPg94"!]ABBf^#k]A$5h>"h@\)<"+G
lcM[9-t\2tJgBV^hN^60:A($PQ`rCSa]A-oAZkX\)/_fee"n/#;*0NbblUpI%T"sP^aOQmqNU
Lf;IX]A.*B/:YCej(-7N<8E%CeNc3YG6ub.>7A'&jPk?Pr-@CU,>Rn`<R!Vf%*cPD*35k52sb
3CE\h-;3:R8BtE<9dD)9_"QJHFRk:'"]AF.dtJ1"Gu4CtHXg6>d4Wfn%r]AsA>Y?41l.[tMX@H
CYbb*C6o^8uDp7ZiIbGN'Jt!!!&j/7_jYFa'S49ME-/BdT)a5NtbOn]AB[$Zo;aAM[,KT^&fn
\.FSLcoo&gU`<_Y08anEcCG5\.6r\O?jduu`qk6sl9cFHUP=*f%(+a*F[GLa5@]AZ5k3,9Trf
(7WPo,-"%p6_?J53:<[S#e1oQB]A>E#M7oX'&1>J:)nIjH`i^tH>KVC`93NEP3]A'mI[.\=C6N
[\'k'Nk&nkS/+LL*)cZPi&#?&BN-B.0Xf?H-9g9cZ.X&1&mQ'=J>N/#XA-$Pg-VI1;'Za^S/
jC$`>,J_.?ch(es=^S\k52WoePI<A97aR&9>_o>rP5a.SC/Jf3(lI-=nn[:p=GgaY]AJG/.$7
^G9MVS]AcG4RX-mTP"C1i7YuJcrMES-kh'hp4Ag>]AD0j&XS;j0TSuaPo/YI68<V:aco7Rca)5
PkLH:4@01s\gB)j?*>F>HMZl\pM^]Ah*<TlOaUG25,d?(7IYa1[`MBt(Z!H<J.Z"3cCGQ^Q<4
1O>DrPIDV5+TuapU>5t$Qe'iE7i%Q[L5TZDF)i.H`=D#O,<8a+c'st`Y1t<X_iCA2$md2;"C
G@BBc$q5m/F!<5R&@p0!aSqWS.@n5u2-jH-g&"AJ<&X,&b2U]A9,B,pMG;%<+<T5d/><oc0N3
$BJ*bCgG?]A>JC*##652?"'g&hYldqDE$#!HfR^q*sJkQieRi6$d[L0FDcVU:Ffn7Pu3@2VkX
MKI".<'R^]A#E;h=o3Kh`S#[@KckosrVQIe1?d*XH!EMQ6)Pg[:Al(h1_Ju1fPMlbauA"5;'>
Z_eAI.Ea&>R1jr'E_ICTPu+O<ZLW,BQrW2?Z*8N,#S]Ad%qd8`PaRc;+;%0o5F4Yb-5VKrGrT
XujH0)OZOn!rl+KghONphuRqW5:DLE2Phh:./b>qZgHF^2P("$ZksU//)PDoYF]AMK^GE6km9
\fK0m7^_ULl%s./huVN=7_DJmp=$.DbPP)WJRnS?bJ1_71LSbrg2eW%TCG-uC:+OeleR=)WJ
$69N7Y[]A^W3gNn(T<K2Mn9WN9Si'tlc+5#jtl#0p"B[pXOgL6mD-G1s*[/k*BIr]AC('7'A!Z
)a?ePsS5(l,mHrdPIKe:S#R&0>g8VTl>c;p4N@qQ;Hg;c"GDFr@TcI=D$N19M3;d!rE$9'C1
8m,[-/hC5Ydo0n[A_mcXl99k8Np4fPG!Pb8'#(79?omT6G<hNPp>"3!e346Ku="Cf;+4\+ZY
7`jDMA/u_7_L&qE=d`?PM7_/8Tr>4=3eN68Hold=+T*MXWes9=S?J=dLd74\iTpmfhV@VD``
[7hX%cVH"u(;'@iW$oN$b*_I?n=lr$j_:f`Q)6KVYAQ*Ekd`SOFoIkBu56K0MTq;G.jjZYLm
Ic"XsN?57h^mDSPRp&_A`?\s/E"S>p^g3YUM2U!&:Z0TZDRE]A2\pM0lpBk?70]ApMQW5#/e^0
#Q6>WqBt0qsNl0O1$6ZX*Z0H2SkrLH2bePC=RdhM:>>P\F_a'$RXA!+ZAs%0tq[I!+LA?q3e
ZpOA[-9ViiGWQ38_%aWb^B5nDQZ"U$AeE,pl63UM_mQ8f&9K=EhC1MpX.$Qc0c7#G.QpUN]A4
%LT\J$L@r*4f4\.FQY`hr3k/5hm\F4-t8t6$8tWlS[QL_[#o"q]AbPE*g=)$^*d`CUGs,;pB#
+u9G3Ik'?SuU"a?nDO4,qehU-KHFZH,g;ot&=*bB?2KNUJ$3V`BgW*FIp=jf4Dh8Q;)%)>A"
bR-1Akl-,e]A%dPj+drc=ML>qI^<30oR@'MJgod8A"C3:F1q<_G>NL4)[F&:KhJ4ZNuq3uNY2
f+fS>_+OEM^K.XGKZ45#<VQ3FhtT=+b$BYf?JF<YkZeUo6&N;ff43X,X-XQ\fulr]AY-liUgc
$+WaCg]A*]A?Us*d`03<;S>#HdD1A379\j5)2K%`LL11-laXo9tFu-C(\-]A./u>(WXm]AM4Pu.o
p-q-QSuM'LiD#W1/dQ%L7^++fX<[`hs$&5_Upt^<Lp<]AtbL7\=Hi9NAejW;gRim#M8$G0')K
2r&9rt,V\:u)q<)`)<ptl6$nKmm/+M#JmYNpaGQ_O0<"oe'Df?u]A[--XBVrd*Y?n]AYlY:F'M
rn?cMLP^e9d5FG!flf#Thb<,)HQ)qn_f;_+(Q.a2-;!Td_?56C1>dC#geB+fq\o8DPFoJVuH
`lJ)I4`6"W:":tT-K$W2epdCl3bK1A,%<'P7h+s4AdnHjECfMjf,Ff7Yg9(TG.LWJ=d`QK"I
e[L+R$bG.CN_GEIgBW?4+Mf#B]A-UhIo#?c3-X&NL)g'0]Akjjn'>1hu@d$M,9"krthSn9@:OQ
-pt-ERihaTkUsSCe+-TiRK2j!?ZpYrc-jZPSGY`T=.On=FRIpn=_kX.G1%[rlEc92'2S,OV,
;IYTXY%l8:re84<M\ZJsWVSKSo^PIS%:K-!>S>m"C]A3WC>X%Z(UIJHG(aRRPhqJ`d]A"6g5h^
-efXUAs'ftV#;[gEDuBS.7bEQ(UeoRrLFqL`!P-"J?!&^9'Jo+c%1LfRfO4g_q;&E6Q5E=Ma
I.@2&n;K,UOt3!4%nBe<K8%lZ?M3U[?(9c!_gMViMb=m:gup.pW-GHrr<-^qq@XV^dR>g3dH
p?JHDVW*"6Hk&Pg!EL`GD4XQ[ttRbih6IJs@!!nM`[.]APe:`#7\8<,pOk&0JrD?uuhB8$F)=
`8]AX:B4#Ib(7;>LiJ!]A?jXi!p$>qq*'Fur,ql::oEZj)#)^BK(lJ(fQ;f]AtHE7Utsi;<\mGJ
AdE"4W<1M>1(Md<F6^pAfek1E\=dS6Ta2K-YmcfH1]AR07R#[,m=8hGc^seqf@=?YE7!E.e>m
UY%(tR-fYR]Adp,50BG7LfY&&<KU'M3(H>]A:F^]Ac'mc4UDqOohF&5g?g(hq<l)`<et)Srud%_
-`)>;tj;ap"$>%1Qg8ef)[AF@@b3occ-2>/Y$r5mrtB+9);sUlBI[>D;&:A-Lg.-IF&`Jb6B
LW[%O7*Jc(a(+1l'O39<*k:0eWb&caWASac8C$;K=galTGnc+`i10(MK;9b)YZ4PZpChmo6j
Vl1NMICt^i9?F.7&k+kZr%M$H09MmloL>EU`:eY%^H4X\G`!(q4nAe8%94C=a+-(nD*faaa'
:RNhsKff@QBTXmoFu6D@cY/8Hn*jIbiQ6E]A_nBkV#+0TQep/%;$oY(_Q+d6q#'2@8]A1M)de>
eZhNVd-iKBO#Q8Fb="SOuXdVS4_"Rd[#d,*H@SP;b)dU?c)X>QQ^Qn.dOQ+0MbGf[g1!7<ZW
sQSKl4s*c1c)D[7rfa@4]A3CpH7l0&AsqfYUulk90!R1,;)1msJhMKZ,iWo`%@)h[H0R%(D'?
!FU=DT;--O"EGEd6$SP#sB*)3d?3uQP'aus:[A2:#C'DR:M.[\\md_seBc2r_;]Aa;GK1B2cp
,_JT!]AK@1XGJF=9Mbl$NB%#0j?58ak_S_>;p*PO#KS6W$3XV4RAV>?;j(eprf)qrZcY+1FR[
7obe_>43a,FSR]AGH((3k0M4m^]A%<l(3bP.;Zp!/"q04`YqZj8V4)@Th?V7%Nj.T%;;KD$F9F
:a0DEcI<bUe=hk0$gDaMh*""9(%AA\Q>PJafZ>etF<E^;5d3bbl8Ch-m49tqNJ+uC2cZ3kfQ
oeu7;b89#VYNj5?Mq/kPSGR=73tLRQ=k#Smq,(D/\H"P+R1bClZp)DWoalV_na'2IbRAJX-#
WK<XgX<39P7'AHZd`5m:u!%5o2d0'LLNkSSG]AHU)HsDh=%89lVO/Q@WT\OX%6#VI_T.;*`gQ
-`/QlEW9SVRX=;p#2Ss0AfAf'@nJfkAqd[&`)*[(X"+8$9Pt.E'h%aZ@a0d67-VuSMDe#^+g
s&"V=_9TC;Z;mn+hn[k07*&L#W4'`Pb,G[?ERj'Ii$a^#qk:;8*K)[dl>dF.44-/8U\<)9C-
X)F%3M%M8?aG>HVW[H"!?j\6;Y9MO$eJB&')e3">OaqEof$CO3.fu[1/a"[.s>[U&Yp-.aVK
q-?h$L^MFlSZ@Ke&KR_k"_ljRZ^.mKW*MO+*U(n.*a:]A!_n*jh(34n03B@T,)UGb0/DWee;&
CUlJi:qfB3VS/s2m1\%J4?jK.\PaK[NI;aLI-\;2(j^.SjaLTX4rp;2g0<P8n-a`='sX8>_`
Q%:?7IgQBYcY/GQaAj:r%Zhk'Hqb&7J"Y"L0U)(JRI!K-<F#b['Z9T1+_RhDYmZn_Fu,_RAJ
jH<@kdoZX8Kis>)@c+gKZ`9k>)*R;b<hn%l/\Ees*$lqa$+K*#rJ/=bP`:k?25hnU^J8f@,/
JABR,aAJ@q(Kq/a_+>O)'j8]Ag#FK!2c4+JUMb6(Hr6J4I.J%2%eLM5/QQr\t$TmBFZc;dt[)
cd"gHo]A2!MpKWKRT3MgBCK]ANb&!*SH^"1,ad!fQEMXa;/am&!`rIWG'L>8#.WBLlY]A^(4e?*
kE4p"(?HKG=^QpudL!J-EK'\Ke7V^CPD\MP;OYqSBD-[N.8VqK$ba#SdcPf(An3BDVbW,r8/
n&K<S#C#KQ)kIInH/-!Gk&_3Sg"$gmd_0UaT$^M_#?7ce`b,Sr]Ajih__N([5+N"*+RnJ$^[j
t%IGpt+gZTT*9#lnh$!SQeL'!GHa\S[[k_^1L2ELj4R@Ucg8V9A5IN*2*(qU8D"JLgt,_g']A
>e%$`%NF;#0KPa]AVFDX7j4p5_6'8\k"4ELL\PtbFpG"b!b[sY,B6Kr`T@d*lm$_FOZ\"\$KW
`;TO/ZT7!%1V6W3)j'T)_s6cf?X#R06[k?E+/K2Be(HO70O?jL:-6[AP^#@4PfX.O0)bk:LK
/nji!*:`25:$+MK?pY;*?GpnX5a9)*U0+&>\YCp*e-\F0,7rd7,RZ+B1*<>Kn3OE7,X"%,?3
D5Ct7D3M0GZIgt]AcscLD*<f["biRTuJCCJ_^)J_a@!\PQe>EXQeS%7UPDs;E>,<F[[sJDH#'
]AClcts5LhV\]Ark^.k*g?L$K8"Y/T!E8iCq"ARnq6G8&=-4!n*epoCQPs<5^U4)kX*#Ym0an8
aQLqm$dkt)iQJ"&saQX9ss,qa]Aesh&-,XcUCYjRU0XT2'Glb(A2po`eP0,%,78/0<BpumiB@
DN/(&tij?XTW_1&WfrLbU\d&0rS`T9F`DcT*M"WnLUl!R@`D3Bl8gk`$*]AsW2GFu7U-<%J%t
]A,<lf\u(sOE4]AD!`3s*FWWQ9Cs]A]Aj,#nH"\LQT2L'bA=X(C;FQ,;$ePTS6I\$flWTdm@O^P^
3tp-LmAE9[$Rh_\dVsb3d'M=icbN=-a;J"r89sG,ii)*]ALoG@U2,+6P5Zk7-lN.tqeIXsr3t
O)R)W@+0!+9%4)@&W]A]AU@%??V9oYr'5DRMaG`0F^=@X4dq5pdQP%"XsJds`H5NSL.kH`n%C-
dj+Uja>%NG@hg.-`WrYDCA&<fNM?A)S)1^%reI[#61A/&rR?@1Rb[t,$A:kr!Z\ael$`6Y+R
;I;$peZZn,[Hi?>nr@W<JW]Al%9ML\WBL]At=AIf5W#F"-QjOj^%CdG2K<1khY0aM;7FUfqCO,
j9DRB]A&UJ*aBH$j6'g==^[SHZ)fM)"n?;t!Bb8U/no.$tYN(LZbk7]AB;0ag:,`_<cJe*aS_d
H_Ap1??Bo]A"0GBDlQu*Nn`XDnbUIlBQ9>Y^Q6DiKs8#,1+iTBPqE\$s]AZ<1'bFU7$f`%^g!!
X]AQ3MYApE7%;B`d&X&AC!^.P)E0(8glPg(SWR/D0]A42,h0X@h-LJ(?n#8@kj();SFGRDLq;@
+K1R^n+bsc;'\8ZD=iu:t>4e&JAE8%S_(pOaS23BB3JRaj950msGa[HdiQWSECp$FJ(6F]Agm
kjM8Y^-91.J$]Aj+$#3"d3GQaMQ^5!L\Ms<:lhmfPou^FaPjOqCr"@L87?@GqcJOWT,G.,)5:
+&2[eb0WL<8BdbeS_4`c/Gd!Z[3-(QP^g%[qH-t<sj;gIb9lEthq5Wkhn$1"+?-1gqtA[JN'
?T]A(=)#n/nHhkC\lbFa)(W#ZX:gW(EhYQbCp\gH1bq\rQoRqX@*pSWY0Y7ie$R\-f@OSb!TH
PX=3lR9?M">-<($'(C5gEG9`0$\"?DNuZUsYpC(Q!/4mSD!0aRTmoI>-[:',kZ#]AJ(/'?1<q
g"0IKE7lQd2&%<T!P?(bUEV/sJf"l\mWrtL4f%485NL6QTLK#DAF9upkb09N+d^C/G&5-7OD
RdB3C>m#c`cbWuA!F:(mcO50^+L*"I9;82:8>fJ$3ht?c-8eaE,2hd6F#8EVSE8r%@&'RAgn
lN,$5Aukn2b*`0>Tu&ACl![F,MOL7e"fm03EdOs`:6Mq9Hg&5'DU_Mh1Il#]A-?kfmpV:\0-f
fi%[H^m$%3)<:1'OqGY!rD&QcL.7`ml.ZraM!V@YBmN8i^2,Wq*pPo4mOJmO2:E*FdH(aJcR
3U2JWp9>MGXP_d%R<OptW/sei"s\(Nc`^]Af/OWLPFj8c<6MN%bir_nJN1?j2=l[%!HT'[noA
3n(cTr!1s.'i*Wq:KjGN@:S!@n]A8E$s'99ApLg$\E@97+UGOac_EAen"MDZK3HtDSkGWEJ=#
DHmabT<?B\ImDDs,pS?/Ik"G!SW-)L51,$]Ahd;=_59,ai-`6#bK5]Aq'PHeRi%[H(JM_+)o>&
3E;=UP)g]A%I=5#8+@Fn%m,hfU0^6h6Z[-k7E=2Jk+VR+piT<VX":O]A,URf-9Yq2O?3AY2>ut
Md1Zgm'@;ed#\s`n#7#Ue03B"p#o3XapN2[$>7]A*\Ln):oh>/S/YXAjDoMD_U>GbtY4'?(l,
:.`"IZe&A[BG7G0]A^Yp`)>?4f%'#3@f#fU2s-^oY7!o4t=RpEZXe[7[Q>>!VOKVGeh>F_+LJ
ce7d6f]AVkj%6AfA)NR744%@tntI&Y+#jf`a8)Ugls`$@8-RDbEqmUPecKQZ2e2SPhoVAT_Q2
esCWIO#QiZUllN=@K'bhp]AY;G:lq$8e>@nP2[#qf+2b$#\&#@#LBV)&443@-dS8Hnt*#[m3h
B?CA8\C^:j7t?D;'C-ksfRI6O%-!W\$5WfP;SlQtn/p"f>u+5WQ`*h(X'I1m>kd"b]ABb*8)L
AT%:N2Ph'2-MO_J%A9W0;iKC;K-4a9^u<B9n/"^No(#3U$BRNk`PS:1GK+/iauKTll#YE^Lg
Xq1]APMA!9oX+U,&11YqOJIL!SC&B\8BT`$RMd@(@CCt@?EJGjDfuH\20Xt`tu9]A/3rc=`RWl
Y!W]AIEi6a?-L!uq^*6nF%YK"eWfc1k2T`6#.=iC6rrs+gbZ`PZ+p956jo,CrM-]AVU+K>aiYd
i:#i>HRf;U%D7uF1e'm4KM)-=hGO?O!ViHImqMpfEp.MhV)(LG@0/d"Bg+\;N7?@3^$c*%I+
AX-"pSdOD[A=N(Wu;o)"D_,on+0K"(uVniruc2jcCq5bR%;<jU[5Ms3J[^sXa0\'*BO)\.=R
oD.nUg``[f-qUTmr2Djd)>8AGE%gCB:_#<Y9h3\pjVA;=an$bD6/b>TpKIXNNjkg@mRG6F`W
bHiqo.DM-T1'AiTb1P@__?&jf/;:&Q>T6%(V[17Fd"$;&1f)B_M#tO0aFPG<f'2!j,5h/+?W
Al<7G1s*":eF8Xlil#Q5%lE^TM\#;aQK0?$ISB^40*:T=MIbc2$WWD[f"Y"8X4)HL'+,/HAr
8?M2_!t1E/iWABT/RE/EAL>5+Rk`N^'9''Uf6nmM!.,LbsM3O>#q8F2:&Ws>;P%Er5:MqQ)O
5@fi0)25'+4Z#nHE5K3#*\.u,MNo/6o]A?U."Z`r*^s8I&CK_!CqL`!,.#HL:RaO`r6X!(;1=
UCrH)Gg=oYipnS3]A=Y[!"c@D[@&8=/aLIIG6!cY?\&D7hIf7tk*-0ljnY"3b<fM[-"jOJQDa
B5lEl%CnHjJf#(hdGDQNLGi3Lg<m;+9D':<W1aH*]A!a^;UH*+uX2<I*k-EB?VVUI!+o;2$e5
[_F<]A*#9JC#$+acu[F/TJ<)!K1([LPES#m&8iG35ga-a9:(E'S3?Vu3$c5Ju40%SEMJY:k+q
\;7q9cQad#9n<?Qc`ENlHq]A_p]A(O.e5oZ`.#+!N/sqXm\><qBTJ)j'gXs<F:%uDo17ORXorh
*3hpu^od9B("@KP[V/a;0BI*%TqrLZDd^(:",c&_m%/eS[]A<'jO(V(5SF3F`5j8:Ro@4"BSm
TC:\8Mh7i)#3ns?C&doYr61DMpoa^.P3Q:^4BlN7g0^'+?CdcC^/g]AI_8'RLiS!,YrVUZ/b\
G*Wj;0A1XZA2a-Ra^7QBjcM^pA;c(jGcMro!1oTZBqN?\IEnQ\+Dm?uH[h21Dq/SEl?\.`lk
%-1Rq&qcDo2d&Z\IB_M9@i#A;_#aC/<)_F*a;95"4LF[JsfQqAaSPh[ZOjKpZf.129>I6T.h
kBT*$QT5lW7iHj#p7DjZ0U9V@B;_-L4<5dQ,^7jT(rQ$[B9I9EX593gT5(WhOP6lMA2$07eK
YHAqX#d`o"K@&XD`e<)ELMDYJSO\!09FRnde[.^<u%:SsPje`;;Gjp-IcCd.XkBD>"F]Ailtb
TUSufC993IA/QS26&SN.YbEJ*J_t#)K'1$.XMf<i6U.J%!4ID#SlDmbqTi5]A4i4<c^*ai9D/
]AF66TIstj]Ac&oc\W:M5)7%o[a_50K-TgF]A!1FT[a<pj+h[>iXt$6_7aa;$e:H4J5Y]AI9^)Wf
8Mip:$;-j(_0C>U.CAa?UVrY(Z!\A8;EPT77PD3&,5s>./n:e%DqW*S[>b!b_3Pm*JYWgL"(
E*L14Oat_Fm(<:Pt.'6/I>;!^QfK*%1ICkm3`$\$2j:9G,B]A'LVm!S<"3aBI$3K*O/E\/<,t
BX$JtsS/ENImhVR_(JHLku1U_^r@4`862(3e*fO]AuPi`<dBUh5Q7;qa@t]A/Ynhi-k0^8%Oc,
65Xoj4C@oF&_(',-^p`&`B=lmr48%<I]AjGK2'[RpLD_S'1lnb0`G]A*)\Q*mtG]AVuJHr/Ei#a
L4#Ed61\U`o0-MU_Q-,pe?@s)(lY\/q*L$fECJ.8@.L+F,T),cdDa9ag25W'5ghZc0Sri=4W
@\'GB#K)SPW$cF:NQs<1#b-+T[04FOQ.07a'+f#UUe<H!@PEps#@o99NV;'"68=d<`Va9pQ6
+Tt4BYDRR?U$0J;Va:Gj*Tt^1+Qits-1:rj*,,qCVRUum!S'J+dqH80/)/YS^X]AU]A8Hu*BgZ
MoSj!gP]Af"7'<Z82bl>Z5WIXAA?A+%aZ>Q)JHm3b^$X1\/L:$/g=d^[i14V>S\hIc+F8b\j&
F^E.]A_kpHfD;L!Q'MN`-aQBVC/*aYMTH-r6apLKC&?Ugk>NmRVO_]A]AHO#MR`Qla6!)"ghINq
9U6(k/&6i$OAc.(hcO^j]A+6Pc,IA%!R+"j4p<tnp[B3TIbQR??Bn9E,r"Mg%CT8?]A4&1Gi@^
J,f8L*=lJtDlN(*!-&Xu=K9rLJC^[\7h$EJ-4AI1#HI>(V`[fJ/9,XI7G#rWF2^M%;7!^At/
c%fM3ajS)Uo^pga\p$d2]AfFroeYI&DYK/Aa=6qLIc=s_kkX2G9iiuDs&@<<Z8G]AIKpE2(j#m
.<]AD%hG[MO9o+AcaBb%:12XSiVlO-UR/38<$N[W(0(nL7^UTkC%lc9Ahd8!rd%;I4cG\$SR,
lBK/"AL_?P%l`'rbZ87b*SSEqm&W;)9-h&H)</)7j3CV?Q"Lj6l-ll4j[LY8Z]Ad=oQ\MU1<<
\1GW1ih,T;(W;OPeTridUlU$Q/:Z&qbTXK%8ZAhm+J:KNZC'j18:GR^Va6i?(C@2?G&NI(@/
^SRUNu9)MDsQ!1H9'8[NPKe6NrZ<Fg;9d_am@ai?6CENaQd>lP`46_f501'>9i'1D^4*g!.q
E0q$SOL^k>1HKs5P'YKl5"7Ep$<4&=[lnm1KX".?)*Q[gG9E%m;>;?5Lm_%]A2X6&\#r\7>Aj
(s=8T]A6W]AI,#/h[pjlb9"[r"Mj"U$qi>26h%&=RB+TMETkjW;;K)?;'YDrs<99]A-[;VaAX/a
`)l_#MABO:js6N*e[Hk5k^b&e:0<hOVChjf$<Qu37T/XEfe@Z7)8)-[cpE3.ct5A501Br%>b
IqH;.07Jb!>lDP>dM>,u/;&Z._4*Pqiu!aLg0LR<'^t4-_[i#nPm1.J3'^,8LI3$KjJ*AkA8
<6=4'u'<.[\:>tlBN]AbKYE6E2Mh,WGul+;cbN!FuThW"*I'["YMP'4\3Q$bDjGu*1hYs<KPY
$=6+e45()AC0?,::!<6KXe2.Q<cYXR5uu/RL7'&E?Fmo@Ti@rMAr>5+(T;]AV^+3%8^U;qT$>
GLXHpcIal2V\*Fk\RZtLW!Lk>WEF_]AVookmEd_pZT:g%t38/b%#7W#]Ai"W39-S`;'6e+)q7m
'-7]A*lNa/;Ep-FY/@HE;4('-Fo.:dW-n2)Mgbm:IHS>P[(C@7T<WGCVkt2;$Y5NMsE+Dc_ZL
=554`\T72cNPoaojX^S\gD8:Z_(kSWX&$6PeP[2UtqaN=T4^UOG9###0I&W<"Tu5:;'_T,7M
;M0H/?>?iA[:cVfEZtmG;0UoNi-)ddQ6Qd8l[ZO6p50dg[U%Q-*iY$;,'UR,MkeR@%KY(8c%
Y_7W?94"O9#dGR)!hb9;",AOc3>T7l";H6(XPAl2(:%<?%qa$Fr1&MLZY"X"Xm;@6m0rY+NG
6RjB+m(^I@3$E8QGGAUkCRrMoEU"NtQ&H'TA+,uVVb8@8dQXaaC(3#..W]A,Hj#Hm)jZ",^3d
A<]Ae,GQkPS',l3f50J[hP%<3E9PF^)`7b'Wg7"K]An=*=&2CIs6)om#[im+.BWf$r5dIU_-5?
:s,Zf>FSO'HUP`Dh"HM=dk=GV?1BgK1M?I.^<n7`l[!IMu"a^\7*C[FLssH+0ZrC?lh'jc>V
'lF-!t'rR]AF:89u'T;M=tnLX/OCS&7e6[B2lbtV0iV1%?un6J*W+:#>i]ANQ%mGQhCcKu2s_$
/C&oapb_)70"?kru$I:nRM/);Uch+hc!:0YMfC?[$C@O1<Y5R@dSDrg.dBlrYsE@KKN:a/mt
.^U9HB1JB(u<o(8K_@joo`Ja#*lVBF*!?\EJB.Y;0%L):fV5*o2IT8tp84ZZ/PV``f[l?n?^
iiM]A#?Pd[/F8'J/Wd,h'/!]A/q<oKRUl0J0aduU5e<Re&=F&QOGn:KB5XlaM2W\o2,KLJ^^0Z
6p[5T[+#]AW/3;3]A?F"1>:1S-!o<ogD3)5@hIP#E_7km7&27o(n?#c$i4`9Y:V#mHd.&^Cc7^
]Ac3m5U9/h.M[!1lA+;TWK[^fK";Gtq/F=a:LBNo!K%@i.=P2u&,+!ONO*!*j-KmXa<J'O)YY
(%.:.ej+e%+N4^OkAS93,]AZT%2c?Wrpt5/Eq\9NK@X0[GQ!A]ACJaqgW'eap!X.^RL]ASRl`+'
BOH."B['S.08^hIA5o0r]AMIK8Z)"8O3#X<k,KVf]ANqe'<%Wr@S_dj`<'L4+bg4(!9ssD:;dd
r28t*+7K-ur7NN]A+7]AB]A)`+''(,/?MVTp:,!%_d]A#ZqSNoqoSeqCMmK44,bj(Q$ZI-9ON.al
"`Z!3?RCma?=pTRbZW)cSU]A2l#fNj)!;\%'T5iPAA8RDGBANn)XT^79WIJ:et5jW%/pTfg\T
GYd8->,okZ8?'/(TQ_.&tBlqRCGbBU!H/*<1)HhG^PRK#.a=0I"XH[TkBnui)^V(JchqA'ej
NPPjSie;VIGJ27XMa$F/'$LM,QE"8m?`QCX,U+#:X84Q-`3BF]Aqpdu8="!f[D-fY,A2IjX#m
>9=T)omJr=3o$[!aj"@,D$1ipLsO4tEPU^`U`6u60+KTplH.a>Y^2><-$]A@FjJ&.(Sf]A:cd7
#lp7QSuoP2UBa>GN4KOBhBo0o`%Lrd03c79-El<dR;TWY4F`KNcZjj\d81okM*iT(<:+Vd_R
:t7b)[D8D#Ht!!,#Dp(fiaJotb.2%2T`Z`)B@rB%WJ7l<?(\S#_q$LQ6_;2E(8lW?&t<A.O2
u:R1b6eYM+&bEW:"n,j`Di+%GMR5u?uUSb&>MAi-\D&oBkLk^tk`?\p[\>Df1<?Z(A(+/t7g
aY=)>E*I2]AA?)j_\u6-G?_fNgZni=d+-5%DehHe66o"Ol3<LV8BrBYO,M'5\t^_6Olm5U-uT
8uF8tdA<hPb%RE17Z%,_?H&ll"6gfghiSI#fbWi/$sDQ10*%j6L1#D[]AdJ,EjoI.L=cJR=D?
^KCt2h=nhFeq1Ar:ImYcr5)_7lC*([Aj,a:V/Zh&oat=(T3kN2S>u\NGgcj^_$&dW=uCHAq2
W7ohhkS5o#ORuXoE.4an,S"3<Ib_4RbLEP@EO?6=S#e[hdjQP-:N$37b"]A[X+6sBem88A1Xc
f4^L23[RP[>d"p8_huFF[hCZPgMS%jB/>klrhu0EkCQ,I7=cZi,k32R^bn"Z?YmHE"q=4<R.
)_[*bO;t;l]A`0":Jp>!YuJP1o/ZDd(<;^>ifp]A$n14n2k^o7.F[(QuMsioqCIW#COpoO?g-q
A=^C;qqRdM*o^Oj5A:1j_=AZKrlgj#)ip="o`U`I%!)tOlbKK7Gf>$9fI+M,MPL(MC,'Hf@m
(1./YIp"hQR=<s^"oKa1*unWB<]AsW&ln^/_S95;"#3.s`nWOSpVRs:4'Wr0\e%7Mq:l(@T.1
@W;@qQi_USMS`\?_\"E*YClPR:*D/paG8aV8+Jf>%Hj9:nfXck09fAU*t8"W,;g8(DZVW'P5
n`!IY_r2-e\V&\e$hW"[h`-+!7!'/[s@plK<a?'bC-.aoO%2'T,obJ9X=$:O=0oJQ=LMa.\`
siR)>4_.hO9IJ!QCOQm[XL_SIHl&F))$>i0O+T7!'0hX^0;(C*hb(L_lqY)%@O<V]A^HhSjOE
6?r1m<i/jd%ZE!p$irW,O;lTAW85\u++=]Aol)gP0L6eJKX5$@WLdRLX#hA"Fni,fMOV3b-eG
H^/`-hN?6Ka"'dL*9em8gBuNZTXtn-DC7Oi@_jEVgMdoK`d@(*;Pg19*[bddAS%95(GDPSDO
8KoA"iTG=`ZU-,9nh1F+,<+87U40MInLQ,=cV_]AMhb!Bsc'pa^ZmO6UN/?RFL:m$%,bh*2!m
:=RH=\T[Ct2FX8l$g.?2-X_WRonFLX,EP8n&*p$.@/PePOSd+n(O%^>;;t]A(@UM3DK/,R0cJ
b(GcC-mD_jDe\6kBeESCBqYX:t&+T?GXWY^K\PfE#7F"R0%GeglkjrM>Jfo##6riA1SS1a\T
Cmb;EZS:B#sGoOEHbCVM+6NlE[`??45+cm*2.me&(FPbk1/;'ubkCs"qr">nr;:1MY@h7><O
iTN39LRq-P>FRXHHGuW.&T/`.FHGrs.'2ThCU71M3G&&(J4LO8l8PEJmj&[Y0dn8F,I,%6oY
&;$`Ze6uYI.'RLXnT#3[p/agE\_!p%qSAnSX)!Lr-B[!CJd%2<k[99g$Y`i]AuQn-X8olI@?k
-PH"+DKQsF2c_,AS3jiL<ZVm[sAro$ineZ+&3f\RIELr-5l+K<ObTCSfU=6S]A*j)Io`e\8:m
&Z+d\gW?ReF'GghhNc\J`!CqE6T89^=cB;*S#e)*JaI_h6(p/i7KHk:$g?R\tA]A?#\fSrc.o
sQ^^cN^[S:Z7^M<Z:Gc:B*s3JC7[#$%OK;(no-C(jnb0hI`,naZ</S&D:0N0F4OfLfW.O#V5
B:Z+k@M0RU?t(\)=GJWNr8-m>h<t#QVYg<U^;'Zs]AO1.!HC]A,KkBYA=]AO*<WrXVfMk8ks/.6
H-aH*\so`l4='FPcg<gbpIrhuN+iqr7:2p#F/oh=9nl>M&8Q=PBB*EQmMj1-QG>+opG"bb4(
=%pT\m4gq/I0N5QeZ0tkSiPs0WB4k\6Fr`T@[$e>SlSS/-5]A)Y9^f7$n`4]AGS_D]AEPW']AcAM
gV[Ya/#X]AL4+-,5P[^ekgbhcbGgO)(a=f"(XOoNOcK'IpJAT\Q;9N/&\3$2AqTJj=D'q?N"$
q9-"G<RCed!ZQ'k8j)NMX@Bts3r9VO`*-)unS/]AsWt2QZPn)jTL-IdLWipIKHr!\T]A!.*e;c
qEh3.>(+K2GuG=ih\I$#lkr#b'#HVH1/d`Gemri9.J_Z@.+X[F*+:e&I,X\0)m"9>^`FNZ=_
%1,]A$5G?a&'.TcL1Y`cu`NTLJGD;\lgn*n0[O!7%^(uX^,I:lVT[=3R)dEhA%&VDbZKd6I)'
/W0!/bdA8WpA)7_P,]Af+)Nn#JTI%_NC7u.F?10M?!_h596eSlD`(:_kcWIggcHm4Ee,GolAb
Db#81f/]A3\=g!@m[?NtOVQ\eYDLjQ:X>cKX0Pp#h.7-R9%CM$<$[GEm%'QH/C!Z;XMN:^7J#
o'h>=R2$qhcI[7d/29LgbR6>A3nqS_Cl>!SA-ZEuIQa6WB[hA!EDWWe'91BL=uX?1#@U>!pg
/A1Tc[F(9jmnVJCf)+XA*o]AVWO335-W'<(snqV#TDKq4#pSK4dQ+&nq.3&Xh+C4\E\%r1"e2
`b+<;aa>E80,#[2!VVKl+tJpQtWgbG8G((G/KKmL34qc?[O]AqRoeDP`'GB7k2i0\2@UO<=D:
(+^NF>,!O.JYN4?e:IQ_7$_6%*7T^:CDTiiK*._,fNq%JY)'1t9(H7m:A4b&oLqLaAXtgN6m
;$s5;(nIOk:T7gS$H)Ej!KMQbaA/J6-E\(kbp=Gk*g;j;S;L$m3sJ9C4bWKS?0$?bJr)1]A.5
4S1J_2sQ:mFg.lrH!SW*)a3f+H.m>A=DXXK=MAR%_LmLd`!=^B%eL"&R^l`(FZ!03T<AKuZ=
5ON0YKA/>sJc><K$s8Ot&]A*bDXYtkfo2E(CicFXU.G;6.%XhmB0.%<g,beF0Ya]A<0bZC3do[
_^n?Z?%cRirN,JbMdlbFc/nUXd7+qC]AV.bO';G3"JJie=jM:5&?Lk\r,.@(#i;T>R^1547)Q
26`#,`Po9OsX#Cmo"`:?>=/8L40g<)->;Z':KLY.$(XXS\8"iTm]AeUG+,Alq4I!qNC[[]AF$E
,K)($>ne=8Dc8<6/!:)lMq`*#af8(2C^erWK"JhQJXjrRu>h8p;N)KUHK#+lW>_=D[0o\jP5
:TO:=SdXeDg*s!\b.9L7)(NL`;.HrsQd;=IA7KeJYb/D?\dg-mX76"U[89aQaaNl>sM"e<XQ
2TI%sW<4l[+XhqXcMXuleS2B%bQ?S9W85MIBeiqn^]AHf--i9QXHe`qVV:]AP"M=K\RL!)JOZF
"#>-TK*f4@h>b$g@KY?m1[5I;l:+s*l!iY]AJE^2s-l&mVU2n9+u(bn_/FH=s(s2lJ6>_@N[/
KghTpp+SQJ?i+9pXc-hV2@(AqZn<)X8ZWi-5rc6A*8V'%;n>`lk.dYoZI<cu0dCm]Agf[7kJp
UD.E<G=(=5phs1%-G#R.568>(1QG;cR2te<e82]A`\PiG1D,>BXpq!1l]A6mGrWV`[Y/PYq'@s
Ge-LVPQZdUR2*Ih8Bf5<0LoOX?>NOO3rXef:;pS,7H0X'DHefk<TQYT]AJ/\NOW$IqraC2.sE
L??Cqhp&2hqlu@MjR`fq#``^NL0@FBU*kbr-q&tsH$M-N!"c4^7CS779!?+!%.J9?UO%^7Ee
CcNMi6ug?0oAN-`KiI2f[UEifbsH!2Hf7mmb@T\X9#*N3*b)AKbm%E-lG8qYl=G3BTRB4mm=
g_S'`#;`[HQ,Hpqi"_C@('2ha+BQY3"L&pV1,aO5H*V*F'FU[tQ[L@1=2>l?'8h^u;C*]A0$#
1p7g&QQ!#6=7Jc1*T$UeL]Au7Hl,jUq7834%SYoM,HpNsm>7C3@$tN#GejeARXRjSpSGT]AJ63
L78ITR(]A2lrRT_XMt@98IJ#+mE<^%\F+j,@&'r@>3UUb4/3m:m&[)q.>Bl37;F^g^>,VIZ/E
'cra_iQ1q9^s_YRN;A8BYT^lQP>;ZL<^;2sW`3K@$=&oa`'.Fk>Eth0ATYU&I1GN/A<ODujt
TJ4F#r.:Y(T!u,%=#eD9=Q]AX()=LcLIWi`AAKi(C(?lFNlkoU#eK<N^7A+[Ca`)6tQ/+jB,j
B@GQ'WI"<1+e[^M$JL1i^gi4pM!F^S#;Nq.Cn2-<Q[g#c.N)$pNA,!MH"b@Q1o#r`s4Gh5MI
>^p7Pur7Y0BY?Da\L;Nch>&VXQXBI.8$*RD<NRD@8OBN`K+X:\-BM'atf5o$*In`]AFZ6o9bV
1.eb`_U\_-B7j^:CFEG=n1rMmr7cP7I^kW#t0FfhAaIr.fq01Y#]A/`.+E8GZ]A\9`H%(4@?tZ
PZ9a=A#.+efoksL)NVN4&N;$((U,8/?nf2<ishR_Z%JcCpG'ki4)a1T=%j%%ShIkWEaJTD>J
2$OmcT:GjQ7W[G\f%rLHH]A!]A0G*KVh"TXe]A3hF>q\a@PNh'E^K2'u9-h+61,XO.`7"9g-YGh
nrSs,q&au3$&D6_JhX'Ocgn(8f0i3^iV1=%n0Rha'^FtoM?KomY$-@[cQo(.YU+M:+?42VhM
<m5?)&Yg%ZI9Ua2Eb@>1.C.$R=mBA:=PqPCR5LqVfd-)kr=GM&fQ1Zmju)<$c:L.bciW2S,<
7RoU?83[$TA1\a.`c)sZ?&*u%]AG[T,aX_/J9aXb=C,h:H^VG-b$X.QPDVkt[s]A3Od?a-8>9>
V9.R>6Xi+ceH<kH9.pL\j=bZb's?;m<865tWPYa!+0`e#%!3hl$O[8tbOlnnr-ZbccDi*bQM
K5o5,MY'CuH59IX:/!)8q.X>[q\E5iojRl9lulaK$"=HsML",JW2'Bo`Fs66fcA]A2h;VqO=R
*eSINp"l"l65U+@/)D4PT=F5,@@e?B:8jWYjr:E-D_jM@i&Ro]AU&H@saa&A2D`!^709\4U]AL
]Ar*@Fsbc.Ze/(cO/fp^5(XmBQ[<SX8.l^Ec7ek9GbOWBW+AgroF,ft%UmDcQIf,SH`h1:TX.
bh`-e;QJJ,>SQ]A]As6=MCoJpOFJ=oSEa[=);kb3a:SF&K'cuS`&T_cigYVe![Cck(XKT%I&h>
ORLYT@ZQ]AW*0&kNA[5q+`]A@4&s)$1!SdPYqq"(Cqk7IPD4c<:+#T#>`rSuZk+PL&T>8f3t23
:4cX$\`rc<Fp4psFr!inNYPE#HYf0k/>_;$o4+36%1Kg&,c?UP-%'d=(u7fs/pJFWmGL)^4T
bfAVjX\N/a7#kOqNNO$]A<DeS7n/IQf#+ebV&``jqL-!sjTN`06>ar[ln4Ih$GZgrV;n;i"E$
#+0\h'?!LN1lZ]AG>O*!Hl&.e'Qd;D$mJI%'Xhhrji7A8)ghsr";<E^\B;nF,'L^cYVM?1kEe
5G?3V.Y:X$:spRaLi-T==W6$&+3D_8#-+I8"VT4(FN-icb/6Mo=ekBT:7:BA59gT,URT?IIG
2@0Zrq87\T=5[[qF+`5]A!41qY]A-`jmbp@I;NmOCe4G_h:?L5`WFPf''%5ml<@XY8:J^dE+4o
3(*1Le83c,L%CfX$caA,J!ndFK.$gl"ugBm8Y*+L!Z"^78lHr9`r<+NhHK)=[^g4ZQHuA.."
tn/;c-S'mjoo/sT+G&X"[ME"\d`Y3mcb_t_Fl"(NRU=eCr*oh"7S>IV+`/aAVQ>fKHEco$L/
P.b(1jDU7Sf2JnC;519P=,RC4et*H'g+`o2a8XJS$D8a^rHd\,peN-0tf>J0K&;L_-RWW)t#
&_n$Dc9gg?'=ZR=Nn'b:R..;=b5MPQM.7Td75h6knL&!dMC&nEU!M1(kPpp!KS.VOoiG9im,
ld7E>FO@GNK<_Q?Fac'@pJEWZ51kAH[$f75H<KhE;I]A[EZ\PAF83XBM=,>h\*M6!,P-4h*5+
aLkNO>76D5)+e-$c]Ap;c#$RQgkjr5HT0NO.-IG)-kj5>tR;Q(?8[ZAPA]A_5J7SZg2f`Jdnl8
lINXO&7E=B/`/5B,\EkD?8Q#0I=[\f5T0.&X!@0K@["HAfNE>Pr+e69H\$QR?%f;R*,'pj(U
`tmkBr^L^1Pf<U^H5S-Q*P]A,]ALIe(45Z]AY_^*;^&X/km2"ti3CcuCf6S"qV9u.Jha::&oSn(
?AqhXZqD+hbBbB!4@#Pt&_C2MKWDiglm0'p^9l?UnD3$Ji8^9Z#;Da'#(+&8c0O*,.F(#iW]A
PujF"nq*%O&3b`?LPPeScdRb-B4d4;gN;djlaG"pA^EXkV_[E5kk&u#XDI!]A.i1r@h7+.8_G
+6"G&MKD[EfGn"nFu^7EaI_Fn2gth0[VU85;gEX.6St3"P1(M;&/H/q/l`BVBR]AKha"3_;9u
nEHLSG;]ACk\Bg4pL<o^N+o?G=Ed\TBWbj!@!Ua'g/@m8@VD$u%99I3Q50P'V!X5HOL1#)C2@
-cto$#uE/o;<H6e[OVWD3d+b5cQGfpot^T<IaT$I5SfJOfL[K1k)cHe1p#MR?.I1FQg!^?m4
,WJkO)+3WIHD;Q9+ugoft?S%*bq\9g+WNLgodDL:=W::nC2*2QMtAfO26%o_r+k4H"jN<E0W
PV+GB9cQJ@3k1?.%9/s7WO3agN0[Gjir^h:P2#$Q>TB3WT^7u=T*u#SMf_*b[O_GD%c99U#O
RDjG'=t#&;n,8:SCBr$j":nZ2nFYWqD1r:7QS.H<(9;JjPUIRY*WWW]A@icJ@@+cg>kVVoG9B
bo:3dTBgP2]A3;.E^%d+$%5FNtQF,:WY5mR0o@7C3<oiT"R`;?_mrIOr8U%).qeU/'.oF^Eb?
R5HniP.WJ6QJ>mKmP]AaJ9Tl:J^C57b38EiC,*d;3^4:b^BOIt;3FDJQ]A"#p]AU_aY&_e^`EeX
r77R-\]A_Attg>^N;bDCCPqG-E'VPq'4(h2enp^-Q9+_#lA*R7YV<36nN`nZ(W<qFYY6$g8oh
FVrKMl:gEYiWa,1=)psiKlFPFi[.5]A*fgL%<=^9]A*[lkcRhhE5)hGKdJQ[9MB-#0K@Sa$>[m
sHe?(M=P[%geG$Z><@UnFA5hKmjR`t]A5J;=DPq6"j$Ea>+G$6L!^ijde#il3[au[%uIqFP$u
1;8t=$TWiiLq1V[V,WM_B3,#hmDPl:1#o!9a*t=e[#Etu,IQW^+h0hJ>g>JH'1"X2&43fsGL
6FNP$eY_bb,rU[2F8QfnKt,.qdD&hb<q-e`^DN[+RHTM26+gTeu@]AW=.,EPT)`fE;W`;USc8
_84i>M7*$iWj&ICP%H=f<\C<Z6iTr$Kg-&eIQh&cW>Gp3HTf>hNTG7&LH990+oCleJo@Kl`E
6:3C+=N/kR*jL8+d\>odNlk&Ai%_aoo$hcnJ"h>#ON\)/?D^1h8%pKn/tl:q@#H0^`n)9aRq
(I5huFn]AEH@*.GSt`5&6'8QK`DTcGt6``9:tD;P2N04F&/,U+4Anibc9hM8=F0J!R)=`b'N;
\@>m\2UcsoD^Vc7V0S.'/AH`;5CibF/kQ)OY-qsJ[mqYJZ'A<'5J,)c'ZS>j!%jeFtkI*VIJ
U3;u?8*)P:l#-i@(6"G@Et?+;,J8!2h$[T9uc9>g1RVtIHEA%YJUTZ+8&[=Q#+b0J3g*m4jJ
fqT'6ln5HL,k@L$EKmga4[ENcV^dMb_He*S/Y`4XKd`F0F*#<.SGqQkt@mYcR[AATAOOiAL/
[(SX=XC,fS)-VUr]AoX&/-)L?%`q-.&!j#S[8b5A>*ODcDk3deI5>$aOHftb7dnn2GCA16c"[
R>*%-:!Rbd(-&<X5RUYVNVo"bZ'aQIPf9PnWp-@?2`V[k7%b_*]AXVb9m']AB&kR2Crqb.`;E'
]ApJdD/VJ3t?VNnZA7s>PE4t]ARC1Cuje)S%NbS*CM;T9$bkn(njb8ri?PS3(e[>usSfr?cd)!
bDO6eg6]A?0U%R#pr+A]A)[)`=#eBpj6Y8(B\6*CN)^U?<$53[r"Ai2;i*n]A'!o;$uPeBt.lZY
/D!iGG6F"UDEnh$]A?Mt<>c=Mj(YHWn_S_Y:/.(s)rd)dA+%L*^<95/1TFG?mflem]A9c#B21V
r@Z@kGcXUkR[)*c_-&L[e-nY9g_n6=Bf;>c>L.cEY?.s8@u\&".h,QA+dtVb/4N*1Q7ADUgF
h<*p]A/.4+YZ/]AS)I\@*mu:1SIK-`<;T_V8_:&?N?B\aKd@%Sn(]A!$b?mSuJ3Y"=B9JLl`1'g
Hn>H>_!h>/#-1c8_nJ59ZbF\gd2t?.?`"pJ$p2cKl=7,C&-G;OlE0^=fF&2,@a6iqZ6AkUD>
5T/YZ`M!"*;Md\:P-daC5Ob7?O\n)#$515F`>iIf<=')\ZAX9@M#(=lM1_mPq=GAB0f;3rjJ
&APVmIj5C<[Ur]A8k9"Jt%[RHBLVb"ccU!X+bdZ-pg9(pIpoV*;]A!YKVViCX<-98tTr_JHnGA
E[APU\k)t&AWk6.S$C]AN`]A>eaOt%Hr68f-aCermjJWoR6/l%1B,>WiI+$g^b`/)m48C-WZOn
E5=4&fZ/(%h'#B;%CT=gm+lTYEB2K"CHZBiETT]ARM/,/X(""4E:tg0<Doan9%'WpA@`dQ6;*
NT>`(1SLbb=ZIVucpA?7U2q:/6c*gd$SV$f??G`L.,0`aVqcd(n2Tg;[WkbVt-E:>'3?h\'O
n0!Z$:TkhY[0`lOIg61D-OP'g<PE+)XI,tGUeUol#sb,TY`:F""FX;%1mi2^hf^@a1#WCA':
MOTituI)ijI,`P$M4E[9?[X$1G5V6o["XOZ*Xe;rJ3"al&<U(=I@+,ddle_rNRJPF0+Zqc#8
&L19>,eVl8j>t5Bbg<jf(N8nl/MCtkFTO:G+DMAN>7QQUL@2-&h&aS`^.(D,)r;>Ii;V.)H8
*6^ebkB,pF:S1@-iCZO'XaOY>LP9k?/,4.K^]A/7A8&X!9uRpEOYIBgtaC%=[olWZ5"2X-Gc`
@WG_:g*(?=`ON4A^QctQQ6/sl;o7D=+f$$7Zo/X*C:oAQEa\%(QIOUc5WFo<6.90H6;I*a=8
qaWBd/[$@h9'-nE@htj@JE)G6?=59@3&`r<2Nf9k]AI0H/aF<fV$l77\.cbME5.A_$YX.8^Co
337kc[c2s8nA@S@BQk^#%r=#M5Ah-<RJ_Yj'>`[q6/Q^2J@g3X5LURn1KlHa#\78M[@b1S'k
&\hP1mUs$3L7ra4cuXN^7ZXePc3Sm_>j#j[ka\I`V!1Es[XK7Ua'AEBruS;UYUW8W_NggKG-
VlhJioLFOc[8\I3)E9B5]AH\b$$65q4(dJo;J\3dYLk1P`TQ&noCnlo/EdmJo'"2.U.>6'f2!
*7-)8S^B8CiAfSlu]A0'R+crY#/jA>jcJ%1fG7:WI%/`=fraL]AsR,u`>9:antYHg0-JKQs2rH
r;U-dEp>qm-HGOeX5LWXf0I2$OHa8%Aqa*90\USLJI.s/JJeEG;(8GlIFhUbqmrk7(ALQWLL
B"a'>TnqPi%hq!59FT"/m#1Q\X*$-;aj>Pc7^O[oN6RH0*]AfQ0j!i+\uP4T59KSB=S,1=U6V
</9u]A+YT88=TYR=R$)rA#+O%O?+2ed_R9QmD\u9%)TEFL/N4RJk@X-J\Rh2*O_KGk:li^-Z7
s!3kjt7%9+OS9'B8md*p\F2Msnd@\A`&h[T]A>7pH4H&g8"LGKG.b"a-Gcf<muHfjQVrQJ(0,
[&*LjnE)qA]AlS_[0kCM%q8]Ac?b[`/R8QPrdZ>h\CdTHMVc#sC=.Y9UPBU#%!g^)39#Akj#GE
15f*BdHtR2REM'IL19uV]AJ'0bGCt)lUi",*^mkGc+Y=RX3f(7Sl?jR6DeaJmpJGDn%`g6#h,
J2W-)SDMjhmamGtIsXat#GgWJ%>^a>p(;T?:U*rMCnFdS?%h/`&dU!nV`*T"M*S'k<DI<bC\
Y]A4CAbmR8gjWS-bU)u'IP^"i3chX7KikDKDJRF1`5uE,7'?U>=&T.We@hBe+.3&W7Y@_Zc7(
mLSfHXE1O)aU?a@pKc;ftf\F:6"j3>(#GRc4#B'<YqcJ1iJ+$Tft*>b(`_pZ9.8$C:T(+O]AB
S^iI)"dKYN7O,&4XWRnSjUFV>]A>V0@5b'N/"+mhb!e&u"<%?ci+Xu(U\K*)Y&,tG\8p[%6ma
^pUR+Mp3&s-,4F)jp_$jo/Zk5=ce9Fb'9,ouY3ulSPE7`cMU>Ma'T]A5(+Gp`(V3`R5DC?gEr
lS`]Ah)Y?4UE<%fALBQoD\1kiKdDh%O@7[jV7=Lb%HM8k._@4@WhlY,$D?QF3*HUtk`YWLAa?
gatjNp-',=Dp+XNEUEh24R0^$$8:dMQBD/[!&C7@(Ku<0(5m:#P7LBI$3\.P+J7`%.VGIY#q
*\TRqTM/jFVdHct5!hOKt&Oo`K3sUQ758$:t@-8XanW+?BtkX]A8\GSTFb?FLi2h*dtXJ[2`t
3d3Ai_c@fGaOtq+\nfQ2/$87J5@GA-k<h&\8b]A+A2'?C"1*]A%0KkG'!3m!0*m@!/PiTA=JI*
l-!7ol/^V%,A$k%A9K06!c+XWf3b!XM`i]AS1-_(+$8<oj8D*oB^1M1b=;Q':mZ/_Cb=r\Mfm
?JR!iFo5DN_7X#X8W.<(7qXhU]A0CCW6k<IOf_YE?R[C(%.C[2\/1NSa5qHK0k5NkH72G;*]Ag
FKPJIo16p>ikIKZ"]AKSCOZ!4LlIu]A$+1sgr,r]A':g%C3Fps;]AL:Fi,#r&0XWVjB]Ai4"(EQ*C
u<,jR_S:X0K-D8WOE;4s:GWM-ZC!0q:pd$foE</tQ8&'=0J.DAufGM$5./W2PIOju-n9Up2t
9(jR4nboNCcY#<#@f=3F+;SsDLogbPMILX:!<WD3*/icDj7LcmuiXk62YFGd/P,2):oC+`nj
WQ=T>VGAX5,8"f<KNiBghBQ5Mg#FGc`mODbBL^^<l[4fhWD9FJ[g)6]AB%soKV8a3Nm*B;itT
I;SN7f4(J)I=4cd%>"GhI&/3-`gYI[]AXfbU4Y5fNj23e)jX;Q"bnQ;-@+5`@3Eb9S[A`Q?Yt
gPESBKs-C-J$fMc"k6Qc.es0"V#3gWIWWR^e5+fZ7\_a5Fngk:UB`%O1"Fb7:Q[5/S9!r_E>
jFJ/+AT6'Hj=.@cD2FmFp8s'i3'f$<^B*&Kp3RDlMY1'YqsmJU"/@7pa#5jm82qfZJ3K_E[O
roJ(!e>$RR\,J_\NYZTOFZa&r#g-k1`g,PD<c\(fh<-9$i;@8VuiduENoDPVfk1V&GGMioqh
JcA&>0X=O_rY9uY&]A5dYE]A">7d.T+'+0pb:;(f>ZCSoj#^WCHHG%G5E$Jg2d<"?EPiG%E-e/
2Wf/u,#>PjoTk3o)dFC-an//ONQnh2-MBpR!Unk[mi7iAKAbc#9jG9*Yn`*[L^*>kr&Fu/IU
UpWC=oreUBmA'%B$jf9)^pb;/i:64Bofaq&m'MEE(p-e+p&&82r$N/0Eb/NaqjTPM)kjG/Hd
&L*D/TEZ2gH\jgn]AN``M(u1R4]A;G`CWMoUD$>;Y1#`pN$R@ULf5W0cC54nH'H*680*ZL;6;i
A@PM(4i$^c.P?*2KN)#)J9>@1G<rXs]AiYgj2RHlU$nXQiMA;fBtbjp;IH&j;\7:iu:r(OOu<
6&d]A8$Ff[^3T\-CM@$2[t/-q*o)VdJ+/^OJ;)+#eq.K%/J*9]Ah-3Y`n@NM?0:b=XfsiS%r:,
Js3h))K"LImm=iPr/"F%,>^=L@p(jZ\ec>&;9b()/JGnp+fr,bI*>Lqg1=aCkR#Pd^KnCXR]A
"!hl]A`idSZ<&Yd'KB\qi%+O;d600qN\Ij#5pSDQ:ID^qHm?f3=pJ]AMbMg8fa<IhKrJnr!iR)
7#b'JQ\T*.f+",]AL'!-CFJOG_dN]AfqL:b$-RaOrpVh+0ZVM@h3EZtTUuK<*m'pDUJq>Uq/C-
hSZMdA@K9NKh&\?Zn`-cJbO=3eUBq8R%,"T\["g.1/QD'YpcjDJHPoZ#TtW<dQ)Muml%PsKN
rbTY(2%Z'0GPQh4S@<o;j"/Xl/("h&6SJ":?K/RQP!!H>dsJJO7bGkqY7t;Pdu\MF+.46<+$
I&]ACU)%$"cfU.VS'cG5S5'D[?GXjoIKgq=Yjao^<O[rt#Jj+\OSrSIcekNP9N!a&nUIIi.YV
=FSJkX]A%7n&@1gPZ[YS:l4IgV@ublH09!I[YQ)3$kD=3]AKHu%lMO+$`b`Le[(o/XRD;\b3mY
"Eu4UiRh@=1>gImqCNWb_Sn8]Ak(Hbesao<3#$\ctD_%m"6nDHkC6Pd.'1bIthI&HEnW**rBT
6drC,=)A(A_<BbH?fFEV#,&P?L(t`C&Ijaj*]A$\?<5f2c01PgZH=S;gX)H6a_XafN6#UC_40
R9Sm,?IM%gaG)L0H"]A4EV?iU7W0Qj24#q\GVAah71GU5aH#bt[A"JQ)^OTYqZ/:5I,&MM3Jt
-`h6c"eE&Wk$V+W$"Sl/=5G=J`@GgE.bcfPFp'.,')UkO+pFXo,b9O3sh,V/CeoY(9lD['h+
#baIV$q.oo[f1-l=a/dee1Z^HKGOV+Fo8/+\@sI.\W8r#^t>j-UGZ<fH'1BJ26=HVWkZR-`B
F::4bP>/HMNajaC8O4N7^#YSZJR6hbd@chf1scBA:XslUQg*+.mj.60)-D3mQn0[afP[6Q[0
p*%qRNo#,5N0b"h)VEbLco1]A)@4X]AOAC1PJt?]AWNoH+ur_VQJh+]An95`_4ha;[*_me4H%\aD
-,sb5!i*?)#T.T]A8Dk>&VFdY/mA'9EnAu$MuW5E:GtHhpHlFWjP=G:V]Aa_TMEHk+G=R<o[HF
O=a4;,\hNm/dR#hqq([SmRh&F_7X_f9O1-aN<ipuV,kT-kT9!fWs>KQ2fR^MjiXGYLBR7E8X
5GUdc"p1P,N,Om->)\F.RB?<#M#Em`<6$d$Ja?%%*FVQ"9#TpaGq`LK.c2bl0kQ2X@+Foulu
!'>(XAi4DoYY6l\XPDI,0kiLP:&Qr]ADFaKtk)s\)RPKL7BCqmZ1:i"oZ-sX_#kgcEeOdP`GD
>m?S(>NtDAlRBSo+>DBj+S-#aM!1=%_@bK#aac"3=0kP_;IP<q5;""T.]A.#o&hhDoPb\.fOZ
H`G4jl/,4"^\COgg5--U_PbQ7Tu<X)YmO=?P%W3U\J64Y`rMPBm"j87d*u/i:c@/nF'YeaB,
HsFb(>W9>u-g`SlNkjt"!0'p'DBMGk<Lh@)oe3Nmd4#4V%6J:3FYfleRML_cSc'[#)R4J-fU
^^t(^<tHr!l`:>'OahD2<!$K6!\"H4k27$-ae703!<<H?Jues)$gT!$n4/1tppP!/_>WqELu
0!b1/Kd1=0OE+'hl+A;QpU0]A3$"f'Rd9_Ta+U<l]A]A;uYj<JT/n!maPENG!p<?ZS.P$__^rL"
I>I:.TmL%9(R*dl<a@j;*]A0;k%#AD@aG;uAK(-F^\'j+),5Q"Esk:1(11sSE]A9CC^rR.a4[8
K&AgZ/r!c3W$50#`'ccXp=YV"%e:db?`pd$p5?m8LkJ^(ibRcCPG`?e><g,8;c-b?MamTIs;
9$q'7,W!iZE5!bh9%h-c'lXM2$V/IK+j#2XYS<#Ho,!q'PEo8$YC)O6#/5]AXgL2"<%h?b:E%
&MUoJ5O`E=dbQ=1Pj_F:@UN458pipt,IZg:Fh:BPn=o;43UE%=GE'@M(#'sVV`W<L-a@e5,u
.!(8PU0:0lK]A<W$B6!&gk2_94h/CDYDu*A4#=:b.YLbAX>W,2-5q7_<=(TA)p\L>AnF;>]Aa@
K)+Y)$Ol;\uI_]ABdem`:q$@><`PVPRb.M_L>LqJ8bS5qJN?aZg$/_j0Dm\>X:^%[&'if5?UP
AGK*K^Jd"B#6DT=C*SH@O0rRf[T%krOWU4?g[>>1u&*f$L>utcu;7^qm$NrZG'ZUTe=tLTQ-
#<h7Ii$b*'6u`9<.8NO<BD/hd8m5"s6<iA9Cm5iA.A3P5nHXT9B&%oo+E@2!t2VLh"r!qBld
5<S(a;1-*<]A$sF(i3UYd*q(#tdKE-cZ:L01RC:cln0?]A:R*\W#5[OIan/G+sd<DfSc'rhO_]A
-5*q=+!eGNF>X-@#up!jY(/RRKTdL"m=2eMaJt%jeF_+T?%hmHaI/k?6j<ThWr-Cn:oNcque
OF^m[F1oa.V1*S=BpaA!Hjp$EEAKhF'c/cQ^aJ6m]A;3JnANB&k*o]AuEG[H_Y/Arg<?W^,rd*
OUOjiI1?aKTuUlc'dn(HO^k\bZV$d@.E(q/QM1t92!gt%mF:J&]A24PnY=:AJN]A?6$WiW)Ku.
"-AbJUq4Aqg\qU*]Ae0T.4ui5(HTpK4-d&eMCVXDeV%_ti^FJm(1(U\4^rZ0'coJ#5.TnQ&*Z
5442+bBY#?3Iu.t_isdRTp'>Jb?TI0h,GL%Ul(!J,;5JJGn:qCdAi^2D_/B)(Mr-b9(-ULnT
>H>@Fl`n+;Tr5G$%1uW4XO3jQE8:0cO8kTjOoG?)lNXUmgkKR7D(In%a39Dbt[M_@f\8"JSk
E%no:FC*o_'T1o"MbdXuSW=eHK#MiJ?Zp>[rk,N&Q>4qKcWjC[r3<$AAOq"fa@Aq/<Jl0Z1V
1F?c07uRor;-=d!"pKoAtE%HoBj$_KqcoPX(1/iiQO'Cm/@&.I]ArGB@HL9`N>G?$q@egE/cA
<tB<W?h$'!]A$ChW.?ipkd1QWu%2?r??W5M=EIVqC+t%hH7*QYaO3!`A$@IY6og1oaM*<ZU?^
QMR[*W+>kgo"9#2=X7*@n0UXC.n?Z.JXPAB#EJoXUnVRJ",I45^ej`I]AL's^p$*u__L+7qER
CI>U1`c>l7fHV+DUFG6QKns$Cc+-*JWi[AZKMR<\#L9<0NP1$H05?O'`#*WNt!;.P=HB*mZ)
Z>;"JV-Tq#?^EoCmdnsh(Lr-JtP%eAAk>P3C=WH`:`'1]ABd%NdVJ[K1-!n??@;K<F_h-=oqA
:g&Q[#86bHK7Jj9AZ5RS/UjqF)B5og'u>RpGtW_QlT]AFQ,jD=Q-J0&8&Fd*<*=$2[,4uEgH%
0Gk<;>^ar2du`%oqK,n^eh.8_ci4p[;c"rM-0n'J+XEi`^M:[13058JZ&$tJ<q79I4jA&f[9
9%mo$o=CZTP@?!+K1O`8Ou;T`i/`pL:<o1E+oaCY;1Vm8H:ea4lDhpaMtLj$AZEeY#@0ZL*M
^W]A53RiC,M%jMkZ&P^?$ESR?0k$Ql9n<.*DrgO@*P>41=bbKFn5,[TU2dRO1)lt4/MX+_l0D
=i)->h*Z0i+p3?H)mLY>t,!KKQJCe,3YK]A"W\0l?1'<pNt'0u4@>$k^Y)'+;IJp"ZPd'.WqJ
chLtG[5<!S*A`OR.d6hPG%VdS$m`gZOQYt;!pBg[!;cr51UR+<!D`CKEcMK25@t'qGa^M9A%
Z7Nq/br<mjB#-(S8.RK)#%(WFA)k_9U?`BM>0,Jf.aI,Q7;LF[F7n/ruW7U+dVM!r!B\`#oL
6V5.F_[,-Ck7XmXk/D<VB"a$$bA)WHBX!Bg5sPo"rfaqn[^!33Ve:FtGsg_gbV/[\`eTKs)[
V>V2egh%$+lBc"HAbUl"!a6bm!;85\KTu2o?6J0NsfspX'*5C$j2l><5(Nkqc8B=SJ-?<@r.
S[ARY/]A,&>1<-Eh/c7khQ&L]A*59$KIlW/O)/^aaGugUed_9X!kJHZk"c7\ms,U]Ao78YStn*'
9(E^lRL%!GN?Io!JSXDGjA/^$A8d)0aJaunda=3PRcH-l$,usnq]A4hFpJkO(m2TnB%q%Rm.L
g[Wt<)AO*+aZI;-=s8g\c'c%E6U#e?(G-j,T]A"-jU0iVih;#G(\qQ#\DF^?(C?!Q)6gZd2."
D!<]Al^1P2k_tuqKIHm'Bia.-*;fH?n97[ZNYQooY;o&r$N[0-lQ9R#%E?ks!$Zb"!Wd<PuW!
XU8hHJ$RolJgrhS8HL6dl-<K'Y`n?^C:9nGLAj_7UsMi)\hR&.;4giVIa;K)pLN>9RqeokLP
j;0Rr<2o!Ej^f0pKFQ.6r4(tS@I[RE=ho0`h'@,c8A^7YRYR9/6%\0ZI"uV:o.V82k(KtrI+
E=='7>oO6X.8cCY:DecQc<Mc)H<#PBpm99b=)$BcA<10L!]A"U^$88D(nX+.aN71U*jD59"tc
FFja>m]A!ZT$,UD\2OW0RtQ"T-m3amu7=%mcS()`.]AkDu4f;fCIQeq">lD#rrS(Rs`((ZEbZg
+#DE,E9_0i]A^G+?)73K-hoZ.VS=P.IJJ<[m25X>Sqqa<F#qE8gkMJl5VB/KddB0WSAJ;tb1T
n&d&k&;1"0d?lo7=cd@R?-Bpu>ogT]A\r1HT\#5Qign@KGe4%ATZ0$d*IbDd/ZArW6SK$p,[S
DI0:q6g^bo/]AA/`ScEii:R3ob'A(6ZSAh2SA!f<2lF=$S7WG77nG!?HUc)S?,DcB?RNm:M%U
QD9l[PEFG?R$"`C]AS;S`]Ar[!!FC_pOaB+i5CI61N(tHCrJ!]AJQpTW@B]ALQ<d?h(o8Q35\^\Z
@e_%MOs)$TuN9=8l>8O2@Q4/o9kD.Et=huHH1@mH.*bYbGqh4;:slC1Ju`Ma<^*&+mL,bnRc
ZQR.*hfI:.78.BoaXf4]AcjW%$k?d#ZA:Pj/9)/np3Am"O/f>gGcOVA*>%H9u\o_;Ec4kM*RZ
m=A1?/0WA+QNZ**>LMFTA2-=Sc^WKq+JNo\lmhn/#XLTCi%VXq"p%i=]A+E7T,(;7$[OQh\n/
3r5ns^OESb#o;kWupp_.6-M>ZX47N0tCP\hT#f%B=-\NtZ.*bomE]A:d$&/5*@=2Ro\W(c<^>
>cAd?lum]AaH-='+MtqaQ-$)r&J4CMo\L>&p"J7[?eX0)7C:@9[?6T[bYf$?c#$k#%NlBdAaM
=F5-aJ:\tP;uJq"+EUi(0q<gdf!@_521I4Fl89]ACPC4Z45CaL&WpcI[\1>\0,b[;FdeBs(C=
SV+6(E7fu0phJ;dkj'FJeO-D&W)Zt2_Ok2DS6_Q4.B'/VomtK;5P4*<]A'aLjI^I>.bYra9g@
;5;>Jir]A%5#&?!ZKPB'&i<A&D)DO`@NT!e8533l!jg>k&p3Z2qMK82@)JGG)P%C9Z7C=^@bH
CH;=U7=H?>HS1<e5ks/J@PG*/d'NInH<Tg;/ek8g/@7I=6QQZ%jd+Gt`B>&67\\rbl$iNWI-
mq`tpD?qb3VsfQVoa]AYm0$9()/Ssf"BOf_-m[4+IIUE1r`-mY1,Ngto#Hd#Y#lP:RbA]A.3%!
KYHC=7':;DiblJD*.)WQ[(eCJQ">Wo;]Ajp`XWmN=-=got=Iq;pjf@3:6Ds'3:SpA1o?QSi[k
IgLQb=5_+-Ue/l)<t`IqNeB?1E^GMFGU_J+qMh]A@lYhCCLG^d73ENKn0)JXp:7:Ei.)Gf=jI
GI,I(X4'C?J<SEASX!EQXWX_trBBk,\JlWk"O0:23(5K#.7\im*1D0iP3p\W*b0Ca6bBe\DG
Zc\Zhq4Z2*>I`e2!Nu??op[NZ[LMT<(e;2;'dlu\sqtCQfBuqcs@tQR:@1<NW6/`SG58N3iQ
O"[>'ai\C[;;[G_4Nj^]A,e!Y-Fr(tHD.^k77%@;G@eUg:%J[dC([cRI?C4/1s84U6pUBZTS]A
mT/K&;Mmd#@i!hVdOMIjQlp-=;):<X,^SB=A68h;`o'b2f:Ygu\,r!8LFQ#`Th1Rn%+k+(QE
cmV-@-skg]AB<"1D=qQp,:(rId-+u9!?@F)N?hE@UMr&OkhLY*h#MA>\?u>DqpjY.@+.hjaeD
i^FN!l/`G%H\D6=%M5,a$RQg#jY"Trn]AGaR8I-Q.N.q4ZV(l:Jm"mLWX9)n@M]A<K=@o)2-;!
\0UV2KpHQZ&3M1AIn[NE>Qfee>/]A+pJ!V#Kl/#E0c0_L18Dm2pDCcpR(bs?=Er]ApjH,P3.*%
X?:A+5S)m(sO?jMNPL6<e"L*AQ9t"Y.bjY=7]Ap^"bUI?q[.1=s)qo%QD3Od/mBgNC7@mMhZp
")#ThBr/>N+0qAM0bq&EUlh(Gd\cgpGe_7^Yj6Re^[YGHG1[=X]A^$Qe_m\Kkk?-B`P\e:G=r
iV_3c]AhfSH@;=:FNH,9m)[]Am,\8CK-VO#f0#;:N(?H%b*+=fcr&&s,Znh8BB&g4Q2IN)D,CC
HF:_i\edf89ZU`"(/RVtBBeI`(nqe.C*g/,U_&_o<GH:fQ$g?5g30q]A20bQAm$f)tH]AE>X#B
_Gn+.F@'(C?rSFaCoZKK$rI:XW3G/JJeYeQAY,UegjuS'\+6qU(BPYj^cGDlL&J*M\,qJ\KL
6r%q@)%Sj+EmhN"NsUJ;S&oL%%lpT=*'aRqpmp.dbQd$8\"ior88D9[@H356]A=ICY/_5%LBd
`tHg:uGWg@3+>>2YWm,M3BgDJ8G$XfE.iX`m1*\0gYCRa#RClnS%mp=in-)Ts`qpCHK&G#1[
O*IdH9QQV;akM%2/f^cI:L;THgE)R%TdYl1-Fe`u#$rXL+:@YN#>b-"BIb\\J',sVH%>JE-s
2I1:mA:V,iot&=hN]AY11p4ZjLr?tV3'2",4V19,Q;?%rW%g%48E#f8Ui87]A1FQ!1A:ODje2_
]A=q=G`hFBN+cI0BfGjCJYNh-`0[hQkt.0%jbJ%YU/MZmS1GF&LMGr#hkm1&mp5-F,F_[j\H;
TfgbKss;kYhh<B5GTo26nG%$NN6jWIq('>N#sm:4h'!MlS<@kb?>([I'7US[(kr38`?O2n?8
[3rc_K)]AoYHgXtUs3Wa\J=B]ApPZX`aZADZ5([iik^q,BPq9p:EqBh;\f(S't5]A=mcst[r/DX
?G5c[_$NKFkFCNsbY=[biWgUKn,$6$hI,#UG>jd`ST!,E:!nFOa>U1IF5UsW@[**8<`\W@K?
hrk3\W*+I1K\tJII4_m[jOH47WJ.rukg7f(,r7a14U&j[7FJZ3g7r5aZ=ON#s=H@Lt<>PU8C
O29O*=54lYgggXls7KK='!cXubb-pf1RJId4["R%@`;SX&;DhUi!nA%c`!f&$?jIkRi]Ak::G
7QBiJJf?`L[YBq0I]A@09?lk)s"Kd"m/HChjoYU=l/!Mt%2u.f>ZFH7J^U35N.4%1BCIR6qNh
gIUOn&?&V:e1Du;Me)[[3]A"<dhH3\Vl)>Ta7-)c[Wsn+Q?:6HYZXOM-NE3Z5=;P^/6Q\Z^3e
PQ,#aN#YOZh9?2)0d.P]A/i[dtpmeRn+I^hH$?Xjl$Wn4l*#5^s,NTPh9Yn]AKhRtSf#L*$>\+
G,GmR1+)c>t:+L]A,=._SuWmC>\OQ4#cg$X9-IfdDFFK+W]A'?AFJRb%Q_EcI7mM+)qqgdhH_A
;`cfI958GY>0j*!--SgR@$s^MeQ^T6aKe/0/*<l$XDB>T8%u'u-JH]A0o_fnVchrWR"$!eJoD
d5&i*'1*gYqS75^om3or=qc;"RYTA3V;]A^<eb7PL2qi._mpZA^`Mt4XbsQIS_N."*oI>H5$M
1=4e7IDNdYhF=_Vh2C@H\2!_f50l_W]A2?3F8;X<$]AXQYCi0?/PN.dm.53"a3%[$VU7i[K+PF
-^T=#S8P>f!Wl"sLWI%:QRr9m$Vq7#kU]Ac'<"qk>?Kij'/2/Pl`+TMXg.oQ.-;F^TouS17"\
r+LX/\m9<4q0:4E'lJ:#"s;lOXf'F(B2>1i#PaA^#S]ALA]A/GU//Za_-?LLNp(BBKL.XBN,=\
p^=[jN>+d3t(D'$7__<K./1,I,$QMIi=Rb2K=O]AVR-Ll?cihH^n=]A`On:(!)SLa2t-2HGE/o
7+SaGp1g%oprneJ_ZLfBC\8h/5NQlSt/p<`0(7A('[+/J6g7]AHET1SZ=E<9'1oL!3RQ6k==E
LUT-ojf'[0ui`/bpm/DYXMOV`$<F.Zft?NI#_Y$4VB0<`,:%!<S6'.oeh]Anr:upjf98-S6fK
7]A2*c/W'97+G-WP2I&R>Z7[=2'fr*c4)=Woo?&(aH=33+CG=/pGKBUC[Cb\.XGS35Aemlo]A8
Ls67X0`@K@_,mJ!U")kWckt@sUVUl%^qJq0r~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="4" vertical="4" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
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
<WidgetID widgetID="eef68379-8991-4092-823e-43de4421337f"/>
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
<BoundsAttr x="5" y="108" width="434" height="400"/>
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
<WidgetID widgetID="1cb3bb7c-a88f-4762-8ec3-06f853d430a3"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-855310" borderRadius="10" type="0" borderStyle="0"/>
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
<WidgetName name="report1"/>
<WidgetID widgetID="1cb3bb7c-a88f-4762-8ec3-06f853d430a3"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-855310" borderRadius="10" type="0" borderStyle="0"/>
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
<![CDATA[m9OL0;cgPBk1",n($6K_Y\KCEF"Ek,QQfNu_;n^6Bgn^q>D*"(@RW^.2C]Ai&4Ca?gMhKR5$;
+j\EWD4O<A"jh8LKImQ:k1B.^r*q5Ys(I$mC_uf`=1Z%Qj#'#,K`<LX0I8XM$7THIr&-hm^L
[GCfo5rbguh*#oq6^AZV%>9"XFi>ip;m6;@K$\,J?g&ca/LSUNNhcR?>M)3Md/q-gQiB?Wfh
UnhmFl@5]AmlS:':_-#93[sUq1@sW-)?"DukH;9XkfQbM4V,;Ej(clWbOl=&7I07(q`Ano;Rs
Tq05/T!do(7CS"YFqk/.#?_gAe&H")M*`b<RUOET47o4BQbDjkSWS+Ml\$t^PZ(=Hi5m6dLZ
<(\a;lCXjOr"B8!/+?'"Q<e0PE.Kt\FS!mEi5Tcq0'83Ih4J1_6,bgG^bD-`iWKUI`GTom<7
GWGUV@$tdt8:nl9FVod(Y9(XKM%3p`ZO(9l8R(D<bt`<W,SiCYF]AbQfTse/W/oIN;$&_eS]AV
-EFWt3*YHg"DNVGaU=dj_XS-?m0AahDJ.D==p'WpOi;WRd*<MLT4!C,%D!m_CiGlAgG'?*fk
g;V`M4!^\BWS:AW9h9C5csgY6`BpP]A(PR,LTQSY2nVJRX_LhEd@8'o9k(]AuZHE&qHRiX<8iE
J]A-P5<@7"=m;ZLuSbWb0!8:FWI/i==Z=Hgu,.?E]AO`cW-fJV<VRHnVR82X4;D5a*XoE?^AE2
]AD]A]A$\X:>.,AGpX$-!X8KJ\adme@Du]AeZa:c.G2qEP>!]A)b&EgFW?E!&&kfBIq_[oOYtNt^D
f@V/]An$J.ucVn6t`qTN6o7bk<TED1#b-2;`%N(-=:l8RkD7BN://-jhmkP5SZ&@Q^l:[Mr7Y
VepcBVGA/%l8V/1D@0GU6B/[^s><FW0%rkP;-$Y]Ahq;7W1@3>O)g!oTc/oitEd727jnaa'u*
WOnEaCNGfiAKJ\)$DTIJJ;2\''4T6iBE[Y-I%p*HqANRpIIdjrF=QX<*gff)!WN\&aDScWFt
!e[$YKo:m<:@.bcBu\U3KMID&lI]A""6d"N+lV"^XXR5g)Wq+pb3>(hL664,ZtbcDFsGf6mVI
m_lN@h16An2*O\^<q6(\lgWDof`L#Z?3F^#lG66[[uoL$b#@dZ$s,?ImEM@IhH*1$\d!&pS(
SZk1jiCBm'".(4B,/cKAa(?67!q`HMsutDf_tXkj%-L&]Ak!-r(R-/g>bh`6i;`.QCF53'tJ/
MVHbmRd!-iNFWWY<T_^S`=r`Y3(fIa89cc!q'7XVE0'tpC_9P^5dP)N"nWl\!hX615SJ."]AI
)MH]A2toh[X*AIjh==N*Z^odFo+jPl7PoT_7Qc+nq!'*8;MgesDn1I.WqNH>1"uD^+42N,Xk7
XAr3)<.Bi2G5q%BO-oMpg)*S*7[/b^J5L,m'TU?`(;f\[BpG^MeJc5i&:J<r]A3DYP3:AV6U7
,@Zi_?\j%$5)@m,bP&e7^"B(R7c>)H+[K=P,2#*r98SI)pjn'6\/BVcP.29F.YO:+0Ul\N,9
FPO\cp5=-T@SQ"$:YS\3Ba?b*)T=5(?BI,hfk*HlIF[@,d"lR("upk#5,9*2VnqXgD"c:)SC
UYU/a8%iStkB[<c2_:nslJJZW6b.24867X=*U2M\`p4:3C_[*HgXbUFNK%I:?a00L,H4%pNm
0!sChO2cu1oiWs+4G<3E/*@?bj0;0Q[<'Vk1EWl>D53ZY+J9MM;7N5,:lsTnicdm,AW0;j&7
D.?qJ@_"TV>`\#bYQ7u,tQ[J3^D1E5_Oo@6Ld0q3,P:1Go#!0>:_"E$[e73-&t@-p_M_k/u7
JVZ$@R@[k[lG]AsMJ3g;pBnUgkpqu;R6[T$/LkM8tb]A9c_kWX96TCghrUE"1Pc@K(4XK8'UDe
ggi7i>IGJq_V+WOBhU*)8KP8<@#+8]AJpc8%&*(f<c(eMP[0&=<M`YE$UPK[pfV4&$,l%CJ;?
JVm?kTS(R1]Ac>)BS11QdP]Au>q>`Z70:e116<S?]AbNM\!$'9O(_IAZj,bFP%$1Plo2G2BU2g&
"0FLbj.]AMdOY4RQmiXUU&hp7q?W^4!%\+e?uk-gC&\Aa;l0PY"6Y2J20V\&-E8BNKW84PVQY
7peqELr@Ab,YSVQ%`(0lEp2RNtX6je^CV[li?<`fr/=HS\D"a7L=H/]A"4O+4js&9[&e,,1?#
Yd*WW:`L&I>#s&\*MqKQ"*#MV*nL.hbukQK8+DtEf<@eDLqMN75R%'8i&lVm#K0fi(<*AK2_
>'(kk,t(,scId@'FIhWq/LghR"NUUcW-p`aJ-.,%_m?Ru)rHm%Oc"R^cC[@</uh`(<Htm'8a
f/1@3:A-lIj%9WH):n6)*VB=sEEoc=bP+Zb+F8g,eh"pg"c^A(_Qp2ak)ffMM#cuEU!4/+Ph
:S\G-[0s8drE2LQ<pi'fnSN!b:ri3a:i4s`Ao15J-qjL*OUdM``J7!.Ol`Jm1:25Xl'3-%Jm
U<JkU]A'hbK8Kk*Jij1C:k;mj<6OfA,sZGkji`gH>J85"WCXX9FHU[B2cWgLi,W>iR7gDu#!5
';urOl\sHBXD%a:DJXPp5Tq_[`0lTX(]A-W'8DrPl.7of:!_NuD*]Aqr@2S..f)U.;o!7H4aoE
-h)/@\?A1g$J3K:E$)8B:.[08d)%>5f`(N#oVqe;bB2%=Ug67fNn[h'`/6dI4Q6QSBab[P*,
:U`mm%!SGrQpNYHW:GdI5%tFf@n7uqc;_oOT#.g1iAIp,Rs#B`JK@lj.=G^EE:iQ9<Fn0YCC
V+"8^o+tCmbN!,d>[0KjFS-=<NSeu6(Rd"Ec#nq;V[P5IU1\T!7t`%DD(r?MoYFCgF,qR3jl
sb5QD6*KEKWrCt_f1Rr>9gImS1nMhuV8+(cjm6&kQLR'Lc&T%E`U57IlR/%p0BgNXWZ^/^tA
,?%9KjT51o#rVP4:EfR;TNcn6W4[i-!"(Rs83X`U!^VrZHsW%HPr(hJfnq!neSXQCPXqfE?K
_og8Xr$,7(IGp:jFkOG![L#j.X#%C*YED[h2t$NcrT-]Aof$5H-[i0]A9sR=Pb\<7Ak?")Z9__
$![<(&FnkS2aa))oL[:<JCW6N=AW0%ZKYUeFQFJTA+."Eo@WkpGE<i1sVZm5BG*QWpQq`HL1
M%(BJ!o6c;Yd`SVc7R:,^o6ad.X.o'R+5]Ao"441+Akm)PWO?a,-Ju0%q6rV6)l)+q]A/+772W
k^Z&drt>g0&N.]A@YX!4#tWVA')sCo#'C8&#]ANJL:$`<ae_qMd=b.)Kr]A'jOfEe_e3*7Jn^Ge
<#/NjfH=9=6`6uP=c`GJemJGI+<!/%pA(MHhZ@Ed&dc*Vet@u6:#ZW1d[[oeOkVHU'5*KP_/
0VCIGOY<<ja"g8B6E<81agm9D#;HPQ/"5LlKRk-LE^PQe;^ldop-e(QGG)E?Y\H\qb92o5-C
YU:s(1aC'QqCf9_t*23m.SJG2MP_ndi6*GC^Vs9!iESo5.O-hqRE-C.#>G&r3)En%4NQ:)20
EPqS0.dGkH\kbjE/'8Pm>C;4`@m&$ZF0f<<=egqgL"%U[q/%q#J07^r*&26qZi(d)-t'ph0(
j8R4VO%PmK$Qgs[FgHA5RG2Z:?M;.g&S3%@kLWIm_0TgXt*1>ij?mq;p6%FLhk%(*#C6/TFp
JBGCT96NUlcJ@3Xhh7*a+uXIJ\S:0/J?233S4YR^@,*7r.m*32]A=:6$q1GT+<1q,b']AgB5r?
VK`q6LqpQ07&*.Il1%8C5gVaImD_a_3<"K5P*uB]ADM;,R>OgaeuJ>%JjNV$hHhBPFR_u2E]AX
/!cf91"bt)Ok#I`ST*%u>V^VYh-Wc`?p5SGP_2%`0T`\bH4/i`*m?*E0A+`l*:$$A=PYq*HY
eW=go]Abbo\D\<D@OL!.@Ob/J8"L_?\;_V!23gO7h>k^oQXP`,j%N("ET[]A,AX.E\Aq?09D!@
&qRaACCVT:&qe>FW_)-&:9*DH@MQTD6UKq[U-CPJ92,h(@=NU=m)rmd!W<DC=\;`EM42f06Y
M(hf->GjGZ0<C;Z?c@kD0RVVAV`5.S[W%n"nTSI:RpY]Ani,GB1FT(+X&\9c;BSKc9oT">9Za
4W&9.5tmf>@p*KuiXII0:N7p,PktG=HEf0YE(p]Au:P5gjIV:0^#Df?2oe=oVB75i()d]A&\;J
J5OeH(j.s;TXjB!4Pm;i*c\ZX(O"$js!A$bfQ,e_-PtjB=S\(^i&2W#ICZeiCqH]A:l77&$dA
3p<2QMsmfIf.m!WHH'*B.$NVg]A)cJLQL8@_RK'3DcM^t;/<:d?kdAi?XYdO<Gh:b1#gBo%$I
]A39pF:WTBhAI/;gp$4Nl"4+\qu%6<e$eECS9=3$5msB]AkbgB[3]AX-rb*\8=J%2o:oZ)Wp)(U
qdI0\5IQ&bL!Q^,PHEt85;'R4rtTaIM1^5)G82nW[q/<"`_<,M;Hb_U*<LU@A2O_9C4JqXAs
SK!kdWn7UWK4fna@"ceU0K1Ar_b3FH^bD!oG`i&c+2M)a;d4prKI<C]A.##j/g8%e%K*o(UHO
Nq*b%V$4=l9hq@g7'RB?l9u7bJTcNKV<uAl<<\=jX:-u&*cBfcb,mC7KdZ2kO3/tu%S^LARb
jj-U1j#/J3O;:a@D76o8X'!nE(d96F[A4[T(7'p&BGLF)G_c_Nhu]AU`YgE+67;[;\.A@;Gmo
P^K&9*j8c67"XfKd\e"W%r?Po%lT>'7:G7VB2pZcr+1AlajpIQkR=#*gk>\&3XnGl>MDJ\VT
ZQ".I'*R<I:oSuM48e5fR,s+ncb!_Y#\6n2;pSVE7he!g]A=?l9VE!i(CY06@5r+!b$n(Os0g
3Bb[AuW#42#iD.&NOiSF70pO]A'I`FHq8WN#A#HQa%E3_&;Eg?XVU[eC9W\b&bO#/7i9+.bI`
G*CAi)D/u.*!-<@9=G=I3[+gD-0U/R5Fn0T1gj#dALlKH3\kLF6Ee>Wd\]ADU?fK'a[YXA:-!
#]A4+DGK.Y*DSqX]AWY9[n;$K/s0cU`6g*as%\[^V4eoY)=#Z+U6mYHd32caUXl<'bWf7!\NsX
M_OH(s4A7*&HmsWZWR'IhGSB!m*!oGc7p-]A@ji>XRBd+7B<B4PHa2U>4i$?ASu!eu8de_$g,
CJ:%<:9_LoCkqM17e"J4;C/VS&VI?bi4Q<0ap`C@8A9m<UDk5j_:8d`<KN+RS_:5$]A:IWQ:M
-%]AJP!UZcKn@=kQZ1ZjqTMFkA(_chc`5]ASM[(aLgc\E!*hbioXt^1@Q-Cq&!M?SA%m1BO\8E
n^p\XL!1IaE3eP(FCfDj*,iG,P?G8RL!4CRLJMP1j$7N1$rPHl6%!h6C96t@B%C2*/".8Pp$
>T72:/ii9Qfq[dB)5kWO@rV$&GPlPAYnB$RmE]ABqKBBQ^+KXYOrTETWn:WIeM"D5(tsmO0bc
rWWcDZa(a)q5l34D&eKb4(N?Ae%A.jb9#[JhDicZMAAJiKW&#<rWM>A2';3.]A);cD0/-6=af
]AVtQPXF&PNRL-CLS*spdq:a=MbrAGZ_m)u<0Li,6$4(!e7ikS_0/DDp5t$BL@3DBpblq<&'l
o]As+[/DLau.f`(Tbm#`)7.aN\E("Q&=C[N/t]A=YV>8$#uYr!+SKM"o4_,OOXT-D]A)B->jYP4
+DAsO_*5j6gD3`F0p3^_Qh(]A.VK..c+h_GST[R%0$nMl_?gNMWo"PFp7,@j-k4*m)D*XIU7n
fB]A;.o`[iY(n^S'OqftWI]Ao!Zm;#JGYR!"!aYUEQO0C"X;3>QBnp^]A&4Jo`E6.KM<7<[o<#u
.p;L;[kG&gtu@6((:oV;c%V/Il-84Q_]AE,ERTUTJloC2S(Z(7oe`g]A\=1-:;(q9%beAT[fR[
a-Rof[h<U8b-a#kfjigoOk\Pf==FPFnP+'Q`jB<SF'Xe4`4%"S?B8NjQl&6^lRRL;dKmR6bA
XQcD0Bg+F)&Ft#5]AlWo_@KTj%'?"B)$(?5k/;S\+>\HP#Sl^V_*-I]A`<,6R1AFXgV7QhE>q>
0#3I-%F<"l7;Yi*%20Z]A.5L^a#&RdSmP@K"H+kJF!!$i"/S_:'L:'-E^hD6Ao85c)>13Eq2,
-bpJn0*=I__W^%!F1L<,<V]A:I3Sg/iE)&=%B?;JH,qq)6=qf^""%nOPRu&5nQ@5]A&S(\+J5A
%,5qUja[9*i*b8q;Z-4aa%FpW=h(*#?O_H+,X+=6:c@Q,)HX):.6H7U,8&2Yc"m2B:8:qt:e
\Ej:triC#-5He-D-)<O*K/\l22Bbcj`%XrkrR6'FdmS0p!m>;H6cLA5hh%N;B).4?fR]A6lRP
rm20_2VqE?>YkKY_+6JPY`"BcqqrE:l@HcM_/GR&hD$Kas[&.fd;^Pl[PhSSb9(%u@]AGH9CT
VIQr[+D7A#\CBBN#s&V7NR%ge`_daf030u(D)#"i?E\5)9oYa>iL0fO`1m/eLR\WtagZdGd'
_p0$I1u5q]A]A-s4mS^rBR0'_%IS_^j"GpcgPMDS6#h,(gBYPcOdoP_.jNdLMXoL!pnlEnDE_m
7lA'4cakfCO[Mb8Rq$t\=;U,L6V:1+@dEpBJG+OX?k`BKfj%5Tkf4"-P7e:ZgN@>l/Up[_GJ
8Uusss70%L:mJoiWEdpt"&h3ld&/[f!1/%t=+IH%\CG^>OLu^(Ilih.4YGohX?+Y&i7/$ANS
B2+$DaH8Br$$O4$l$.&276tNV!QmV]Ak"r7ABdO26S+.=!i'ePInrtCQU7Zd<\d-0Yd;6'dCa
=+M[A2b-c9-dHa:H$/1C('J(lG?TKbeqGllDM<E/=]APj\8[D*'tUd;5>bENGj*du(0Y6&VWe
@Y]AXC<(-oK]Ap2:Bj#<0b%Q)>8>U0VOn^rb+LG!C+s!5Egd*6%36'I8pf`0Ue_.9;kJAG-$aB
b(J(8mX'Uab"<B)(_P=E^`(K1\:+R>;#,.>]A$H-`i1Sq5VK3D`Te&PaG]AY>]AQnH7m;,L%l_8
9Y[1N'+Io>mEY<.jGoQ0g1;L]A'6#[iIfG(\9Kbd<9jMrUq<a1*_;T7aF1Ke"(X/Ai'CV+'c@
jJo62WYFO3cub5fEAK'd?AU-e$.i+f"M$nC-$#SZ\U@Y]A@;VY-O!)TP\U]A/_L2'q.F_mju;2
HY$MVS3P^.$h@TV)jk"\rrI4~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="526" width="444" height="408"/>
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
<WidgetID widgetID="039a0378-7af9-4265-95c5-984ffcaf1c5e"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-855310" borderRadius="10" type="0" borderStyle="0"/>
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
<WidgetID widgetID="039a0378-7af9-4265-95c5-984ffcaf1c5e"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Margin top="0" left="0" bottom="0" right="0"/>
<Border>
<border style="1" color="-855310" borderRadius="10" type="0" borderStyle="0"/>
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
<BoundsAttr x="0" y="0" width="444" height="515"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report2"/>
<Widget widgetName="机型"/>
<Widget widgetName="jx"/>
<Widget widgetName="成本构成"/>
<Widget widgetName="cb"/>
<Widget widgetName="report0"/>
<Widget widgetName="report1"/>
<Widget widgetName="report0_c"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="233" width="371" height="750"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="指标卡"/>
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
<WidgetName name="指标卡"/>
<WidgetID widgetID="14ef713d-676c-4fa9-9a83-318198f7e351"/>
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
<![CDATA[576000,576000,723900,723900,1152000,0,432000,576000,576000,723900,723900,1152000,0,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[144000,1872000,2016000,2016000,216000,216000,1872000,2016000,2016000,216000,216000,1872000,2016000,2016000,144000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" rs="2" s="0">
<O>
<![CDATA[飞机架次]]></O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="3" r="0" s="1">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="4" r="0" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" cs="2" rs="2" s="0">
<O>
<![CDATA[飞行小时]]></O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="8" r="0" s="1">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="9" r="0" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="0" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="0" cs="2" rs="2" s="0">
<O>
<![CDATA[航班量]]></O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="13" r="0" s="1">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="14" r="0" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="4">
<O t="XMLable" class="com.fr.general.ImageWithSuffix">
<FineImage fm="png">
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
</FineImage>
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
<![CDATA[数据截止日期前状态为运行的飞机架次]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="6.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="8" r="1" s="4">
<O t="XMLable" class="com.fr.general.ImageWithSuffix">
<FineImage fm="png">
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
</FineImage>
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
<![CDATA[滑入时间-滑出时间]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="6.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="13" r="1" s="4">
<O t="XMLable" class="com.fr.general.ImageWithSuffix">
<FineImage fm="png">
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
</FineImage>
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
<![CDATA[O3航班量，含试飞、训练航班]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="6.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="1" r="2" rs="2" s="5">
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="2" rs="2" s="6">
<O t="DSColumn">
<Attributes dsName="指标卡-架次" columnName="架次"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="2" rs="2" s="7">
<O>
<![CDATA[(架)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="2" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="2" cs="2" rs="2" s="8">
<O t="DSColumn">
<Attributes dsName="指标卡-维修成本飞行小时" columnName="飞行小时万"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="2" rs="2" s="7">
<O>
<![CDATA[(万时)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="2" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="2" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="2" cs="2" rs="2" s="8">
<O t="DSColumn">
<Attributes dsName="指标卡-航班量" columnName="航班量"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="13" r="2" rs="2" s="7">
<O>
<![CDATA[(万班)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="2" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="3" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="3" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="3" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="3" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="3" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="4" s="7">
<O>
<![CDATA[同比]]></O>
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
<![CDATA[指标 \"货量”，“件量”，“吨公里”的 同比=本年/上年。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="0.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="true" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="4" cs="2" s="9">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=if(C6 > 0, "+" + format(C6, "#,##0"), format(C6, "#,##0"))]]></Attributes>
</O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[H13 < 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-13395610"/>
</HighlightAction>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性2]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[H13 > 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-65536"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="4" r="4" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="4" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="4" s="7">
<O>
<![CDATA[同比]]></O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="true" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="7" r="4" cs="2" s="10">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=CONCATENATE(if(H6 > 0, "+", ""), format(H6, "0.00%"))]]></Attributes>
</O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[H6 < 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-13395610"/>
</HighlightAction>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性2]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[H6 > 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-65536"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="9" r="4" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="4" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="4" s="7">
<O>
<![CDATA[同比]]></O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="true" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="12" r="4" cs="2" s="10">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=CONCATENATE(if(M6 > 0, "+", ""), format(M6, "0.00%"))]]></Attributes>
</O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[H6 < 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-13395610"/>
</HighlightAction>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性2]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[H6 > 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-65536"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="14" r="4" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="5" cs="2">
<O t="DSColumn">
<Attributes dsName="指标卡-架次" columnName="架次同比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="4" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="5" cs="2">
<O t="DSColumn">
<Attributes dsName="指标卡-维修成本飞行小时" columnName="飞行小时同比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="9" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="5" cs="2">
<O t="DSColumn">
<Attributes dsName="指标卡-航班量" columnName="航班量同比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="1" r="6" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="6" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="6" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="6" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="6" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="6" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="6" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="6" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="6" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="6" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="6" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="12" r="6" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="13" r="6" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="6" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="7" cs="2" rs="2" s="0">
<O>
<![CDATA[维修成本]]></O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="3" r="7" s="1">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="4" r="7" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="7" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="7" cs="2" rs="2" s="0">
<O>
<![CDATA[小时成本]]></O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="8" r="7" s="1">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="9" r="7" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="7" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="7" cs="2" rs="2" s="11">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="true" topRight="false" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="13" r="7" s="12">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="true" bottomLeft="false" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="14" r="7" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="8" s="4">
<O t="XMLable" class="com.fr.general.ImageWithSuffix">
<FineImage fm="png">
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
</FineImage>
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
<![CDATA[指运营成本，即飞机投入运营后不含改装的维修相关成本]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="6.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="8" r="8" s="4">
<O t="XMLable" class="com.fr.general.ImageWithSuffix">
<FineImage fm="png">
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
</FineImage>
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
<![CDATA[∑维修成本÷∑飞行小时]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="6.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="13" r="8" s="13">
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
<![CDATA[待实现]]></O>
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Style borderType="0" borderColor="-16777216" borderRadius="4.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="6.0" padRegularType="auto_height" padWidth="60.0" padHeight="10.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<Expand/>
</C>
<C c="1" r="9" cs="2" rs="2" s="8">
<O t="DSColumn">
<Attributes dsName="指标卡-维修成本飞行小时" columnName="维修成本亿元"/>
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
<C c="3" r="9" rs="2" s="7">
<O>
<![CDATA[(亿元)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="9" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="9" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="9" cs="2" rs="2" s="5">
<O t="DSColumn">
<Attributes dsName="指标卡-维修成本飞行小时" columnName="小时成本"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="8" r="9" rs="2" s="7">
<O>
<![CDATA[(元/时)]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="9" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="9" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="9" cs="2" rs="2" s="14">
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="13" r="9" rs="2" s="15">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="9" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="10" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="10" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="10" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="10" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="14" r="10" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="11" s="7">
<O>
<![CDATA[同比]]></O>
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
<![CDATA[指标 \"载运率”，“主舱利用率”，“全舱利用率”的 同比=本年-上年。]]></O>
<FRFont name="SimSun" style="0" size="72"/>
<Style borderType="0" borderColor="-16777216" borderRadius="0.0" bgColor="-1" bgOpacity="1.0" mobileRegularType="auto_height" mobileWidth="60.0" mobileHeight="10.0" padRegularType="auto_height" padWidth="60.0" padHeight="9.0"/>
</JavaScript>
</NameJavaScript>
</NameJavaScriptGroup>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="true" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="2" r="11" cs="2" s="10">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=CONCATENATE(if(C13 > 0, "+", ""), format(C13, "0.00%"))]]></Attributes>
</O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[C13 < 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-13395610"/>
</HighlightAction>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性2]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[C13 > 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-65536"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="4" r="11" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="11" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="11" s="7">
<O>
<![CDATA[同比]]></O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="true" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="7" r="11" cs="2" s="16">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=if(H13 > 0, "+" + format(H13, "0.00%"), format(H13, "0.00%"))]]></Attributes>
</O>
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[H13 < 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-13395610"/>
</HighlightAction>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性2]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[H13 > 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-65536"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="9" r="11" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="11" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="11" s="15">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="true" bottomRight="false"/>
</CellOptionalAttrHolder>
<Expand/>
</C>
<C c="12" r="11" cs="2" s="17">
<PrivilegeControl/>
<CellOptionalAttrHolder>
<CellBorderRadiusProperty class="com.fr.plugin.cell.attr.BorderRadiusProperty" pluginID="com.fr.plugin.cell.attr.borderRadius" plugin-version="10.4.975" borderRadiusType="0" value="13" percent="50" topLeft="false" topRight="false" bottomLeft="false" bottomRight="true"/>
</CellOptionalAttrHolder>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[L12 < 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-13395610"/>
</HighlightAction>
</Highlight>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性2]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[L12 > 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ForegroundHighlightAction">
<Foreground color="-65536"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="14" r="11" s="3">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="12" cs="2">
<O t="DSColumn">
<Attributes dsName="指标卡-维修成本飞行小时" columnName="维修成本同比"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="7" r="12" cs="2">
<O t="DSColumn">
<Attributes dsName="指标卡-维修成本飞行小时" columnName="小时成本同比"/>
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
<PaperSetting>
<PaperSize width="24688800" height="43891200"/>
</PaperSetting>
<Background name="ColorBackground" color="-1"/>
</ReportSettings>
</ReportAttrSet>
</FormElementCase>
<StyleList>
<Style horizontal_alignment="4" vertical_alignment="3" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="2" vertical_alignment="3" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
<FRFont name="微软雅黑" style="1" size="144" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
<FRFont name="微软雅黑" style="1" size="144" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="1" size="144" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.TextFormat"/>
<FRFont name="微软雅黑" style="1" size="88" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<FRFont name="微软雅黑" style="1" size="88" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="4" vertical_alignment="3" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96" foreground="-15386770"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="2" vertical_alignment="3" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-15386770"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style imageLayout="4">
<FRFont name="SimSun" style="0" size="72" foreground="-16776961" underline="1"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
<FRFont name="微软雅黑" style="1" size="144" foreground="-15386770"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-15386770"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="88" foreground="-15386770"/>
<Background name="ColorBackground" color="-855310"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0%]]></Format>
<FRFont name="微软雅黑" style="1" size="88" foreground="-15386770"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<f.@PNV\K'a;!1XAf?3;!UBKJ;@m+BjF\(W8Kq<MLZ*Y)"pQ627714`=bEY<<S176pq;2@$
D@.1;cjR=<Wb;<^On&hOo$?U#BecXm=lfX"E^#c?#Ruc@+U53A9!u0fP5!TtFj^U.'*X^><e
=B[K`IU.%t\QUq;ZAT\;)Em^W%`J=/:FY#4T\3rCcHmgtV/df&NY*KSc/N2eIb#^@L:>`e\1
,VA:C!F[j4&KR%DtpF0\YtcshrWJe?1&VrLp;gZF/1i3F]AP[&GEnl00@k[_X8U,CqEZ\Xj1A
[IG!8[XVXo(r9VD*iS0EBE]A#2K?&F8>QLQQ=JE0e2!No19OnUeUnpUeMBOI'B%WPH8.KO!$&
5>Vei%bDU@6n7_OZo"IHc0]ANK+L3&QXEG/$,@$AGK6o1`pXdk>iJc,9;\mT#1n$Q$aQhhs6T
"_jaiRW3C9bQ3dO8go`E-u\5;OI/JAmM(AG(3Es5Am\G/?TAgrZ''5rcQ:eX#OdH@4jY^W$]A
UJ42X();P4:X4s&uGcE^l2f.Zrh;3JAOMQ<O/P<H'h<d8K,D9"hWIWm*&2L9Wa;&HJ%&WMV_
[Jm4(NT[@6/e,s:Ss^0nZ)EDVA&a`(D]ABJOOIClWEp6W<-W3cT6X<XJf8klL?j%O4[.[NgSb
E?agE(^[7!hKAkMq_T<91%/6k9t<e\d(P-^DWj!WS&U`"lX<aKCc3qZ13GM.5@hj+2#\#bH%
Y.HARc,Cl3G(2`7jE_@uc=,1GLA:'3XQBQkT:5>Zcp8bs=,(tqgcIAWq[.sJ)]AOCVjj/_kO,
$<4?m<5>SI?D+\=PN7)W>kn>:oj4'\S`h;;ZCQ.:PY^>0uiK8Bd,a_<ok)KOHJH3`-JgkG^b
60;6o+]AGncM(01WIDkCZ[ABmTB/=:<FJ9gp>Cc(.A.!kG%EaWA)e6%Bn(-;$WE&hn'j"d6cb
U@,m#\od-cqA9O7GYH3rS$-gamN4EZM?RLi.0VgU"W#&U=('=JbOc!7p"A=q,U4!Ri5'&^:C
$]A!&6+Jc3sn8cUQ.p#q$3aQ2.AX`U'->'?Y\tOWf+LK0*aOa4VY<kE.e>Gi#4':heF=L^hIn
Wo9D8Dh/IE*dDAHggZWE.;;b1)l9rnd;e/DU@$H:,:/.c-:j"JAi.p`e`^DRr<fdA!eYP0=]A
9)Y$k;)h4R_k1KlCF,Mf0$=&G`$+Hr$<50]A-Bk)7%'<b8bcEPrB/f!Ps<N%URD>)T2YL$X7<
IC"*Q^(/sd`Krkb5:N33`QsAQc&UsTC'Ns7rN>2>F'S.oi$6cN)>!(:#Hql1s(9Ee%Y-fF+j
n*W5i5!XilNlITZ.I-G\ABtplHj+VkAOR.?Md,-:XgH"S!#V9j%b&I:e4Tq*13+!(Lo9gOg6
HmoX5ShY:FZj)-IJC.#\6PT%\'N/f9snPN$%i!!.pVC;$bsPo')Z+n5L&TQ"Td4".'WW&p9k
pi9;Sre!)EK@i#?`IuHs/8R#B&tADFGgHnq(->OPbo<NNp"_N0JdTULWN#34onUt:AjX=j4F
#-4Ulj)Ee+&TX?FuN`7MEHjRt1qkOs?o+s0@RAZJb(J_?gV/\Pk6.VbS5Ym0(8h:62hb4Vn!
AfH'<C@]At:e.4HG8"&NE1ql.6+RZ5r]AHaCE'W_Wbuj;VJ!&A>tf,Kgc6)%sT\;Di@3i!]A47G
A?NH=m&d+k4r`/4HjXKek-Oa%po<$<9$9Rs&a^+giHL3SEU0h8fDj2fQI$nZ8Ei0!;I^n'63
?aO*t<=:66V*h^UsaT$#9i*oXK/\Yi79dc.3f"oP#3rq!Z\XN?13^uiYBi/Z$IQ5=*m2r/oK
JL&KH6[Vb.%>'&8o?ZRC_M&LUfe5_PX0lA3:sJBX*D_aAg;0C=Wh1JVps6t+hP2Z^C<<`c"h
_/<J]AK>Z3#aq99U]A>^r*@4tQLd*gH.RuG)0/eq/j%c<dVIrDjM:Cp,^k&O4/F&W=;K+3(&!^
^7.3G(#6`CHKo?N>>"iU3i$?(!C!k^eG#WT4(@7D+&8_uddk_D1bUj%u_<029j)m>pd/8eRk
R;3!D,u'AI+gV5N]A/lmU+#MG9.a"B+=B[4H$Bu-BuB]AOd*8b=?WOo0(%mG>D$Z,Nh#_T`^tg
VjaAUqJ+]A-PBb+\lS(Be4f:$Tab=773'@Z6Jq&\]A1IUc5a2$ZG>9ah-u.jL,Ud8$HCqAP%PD
aF4S(9R>Y`1.7/<0%<R7c$bK*IYr[&EcjCggS;1QTKIU%bqPs2M9O@+U,K:dp`X(pbgqW=fq
:5;B:KM"OAF3o!62Q79pjm52dhkLiogeZdH3QP!Cb:n#V'$f;7l@fq!a`:e*/H5Vh2t)[ASd
,1S^i%iB]AD2Yf`']AV>BF,h6m<?1N;k\bnV/9%_Q^r#!mBOh8'sN,opmt.m7MXbjc1U:@Hlc*
&M<d<9L98o3__SEXc`oO!_%f(Ih?D=1WRTls?uK'IKVPT'qd`^Dbp6?09&H4nN%J/f9uD\[L
OUl,SHn3FY%C4h)\/(JQV?ll3J*&Tr\r7c'Z"#Pf-&b1iK.V@[V1Su]AHOQ&</.P6CSe,'SH6
86?FSip0r%YWsEFb_o@%SdGfQ1U$hcKOXI8X@ef-f,&#3:Rd_#DXM/QA=<7ulQG?6`]A[TWT3
ed[-96h5>H0K9]AV*kVa2j)S?U`4!ic6Y0/d6[7Nh;Fq*O76R!j4#$-T?X'kqm7g/tCR)='O_
E!QTL50r,(gDoR<k^]AAT%GqgIY"NJn':?J/"6k[3*cu>PXF-N]AV)[9D6jXY"Md609(XT5W5%
\fqsBMM,*^+p;n^;Q&EQ;**H<9`cl=TFQ>1NQiE^nV:Pb>Msn,7ki6r<<(">9#gS"e0J/VPX
<%^#9QQ8CChWpMPKc_*N`$:G6QA!-7\D4/d9tJ7Sek0I;=^.jM22A?VHS:4Y6ETWd`"(\"QL
Rrhl)/!l=YRGS+FQ()BS@n8r[Q1_!X+kd6Z9h&N<<BaeD4F]AqR$b;r!XZQGd2:Ib6GEbWiQ^
C90g,8MgK1UJscs<epVDF*l#ML[OiADPP%EODIo2X%m+[&p/6f)WiRt3pB(Nte^0reDN(pt>
%%AT1AG9t2:3_ta8@M"BiT6o#a%P?L2oal/MKu#;N;iDkt-T3pm#a0WuP[a]AqZ4RS(Lb"'<%
FO^paXX7]A/eh.uCm@'sJ7&TnLk;=:_9``uDpOuuR_E!]ANLYV=_Y\OElB@kPqOL5`8MQgeJ:H
PnQB'V[GopIXD1i*1NS5/EpFFecm46!I+10RH4k3tQbY`f,QW<qr"d79Sf&lUkbJ@6@I8k($
DNYNS?k[NYhT#^--"?p16I=69Q7.(DDHK5]A-#=r&QI-L>]A/>71DS/QMDBQC#Yq3WVa9^!b"X
<o-SqEk3[3I&u&LWjYigCO/H5n.<SYBb4M`4<AimM?r\16`lW`72eF<>[\P1f5t0J[sQF59:
<Dc`pI!X<eENtW+QinDJ,#5)%D92MMaA!FV&52OJM<k1t8hWak^8GH__:mJd:<bqaccX&cII
JKcCQS>o4c=G3cARV$rE\=SL>#JQ29FJ@7Qrr@\ZF&NLE,A4c#3t!"eAd4P:Ym!V.Wk#1f\+
]A(:/gB0Er+.Gcpi_q.kXigkeE-!8+/gFO&AlE.".0)m<pl)SL^n[34^Q_,:usW5W;Cf*V?kZ
`%cRBR87H;A6g'EE*""'LtWMKZ_kgu2PJ8mQd9ia*iESL2h6eYq8T^t<Y8)sp7q\E-9o8Jbf
<R3fZ1/LrH&LEeqgVeJ%p>BLJRq%iYIp7jkU'JSGD1G7`q<Q*l@t+@E6;eXJYILL&nXd&QH=
?MpCCeo6TZ.]A@uN&UsEJ^.NGW!8``DJ3DkDbLU5>><5+o+^b/XG82-R_1JZ\Ko.sK8Ff2DnL
IM(43=_NbVEK2cr]Aj=,[']A6ERsD]AU0-6f3#L7fR2hQCWWZ8]Aip[5F#Bm/c&8!'$@@T"RM!jL
qp/P9<gpusPiKW[.-6e#c3oLDra5^@0@#W97!<=,Ys4*>NO>j=`fN5QM#,qBo6W#l_RA,sV6
)E\V:iJOlsl=>94>TtofUY_!b/V[[?@:*30X`Zul4j`QD@@o4R'<o-CLY6"Ri^5>n&F#E"6)
@n_UW`J?9/=hn%1C7p@>oVJRTDC_M>lf')jsa=g[;r1Cd4ZY>1-Tp-cXf4:!;W3XW?Z>H3r\
-FPFBmk(/FtOTT=V5G[&+JK([;JnGE74Uio(89i_O`2ML6r.u,7\GSb*r/3r'YBBKj9iL6&4
Trt;8SBV^<$7T4]A\>eUV4$;t3dK[@7Mn'uPg\Gcp*34F;t>;-";CYV_TBAW)V#\\4rU+\bXb
8dQCWJ_rciYQei$A;rW_2n'0H0s-Y_+$B5)hLVo([o`u;hEL_ELBG.#Qu)eOhY&>agr5EG8R
Zf=T%@3Z'N1_8n,IXf+F+C@ja;N&hDS0=:dGA+`eF+Ds\c$pJ_*<:A"P<uokrj,V5'#XuL(Z
"L7Z3EI/+mM'u2:-R8n^&5a\X0`r4L3K&T:l!/=o:rM>[=R@$(titC\/sEJBUMI_gm1aH5^.
UODWb)GUr3j_OQ@:Lc!qB^=U65Uug>*2ZQ9ab%l!GL]Au+ni/q0=k_g.dekAa]AKPUe:`kp6Ed
ekcN5\?ucn70A[bc%P^Q>jNPH4.Q7dN/mEM!`ZWA\3/q8%ut/aVGZp0TJ6eYU1JU,BHRu/3W
s0ptDlHK>Vri0eIZLnQD_rr"T1]A^uMMi1R_a-F`l=;-d:bn\-%#[n9,S8[mb[mh]Ao.,b=SJo
PhDqP*%VaB7"uuS64,NtD$JU)6tAdC4dW]A!ChlOWIu$3]A^h.*^a-qn?\D0]A%!p+H!7]A+/bQ=
D!Uh%+Dd.NWJA=$^D0HAqdpX0lAZ8)Zq.?""nHSnP7)4`#eEnd`C/W9?7t;9^6mOZt\Lh'M'
eL>bHlUC/;lk=2ns14h>?7BG+nn5[g,!!up,"YVfFR=BhQ^dX>@3>NL83#>!)K9>JKNTr;$2
]A<Q//d^_;m0dDY1caUF$67djWJ4drG@-Qa(O9^<O;>aAka/3rW]Ag%&[='WTqjbYqkK]AIt&Pe
3Fq_+`&&Pb3p7/SV?:-u0mXFn_%<,g8:)"VSMQK*.3gEI;Tk0iVgdC*`YU1rhW]A+e]A0;H,[:
F"+u%H6#F4eH+9bdf`dZNQm5oAWEj1p!HI71:f(2):>K.0u`kpqcAIK*8T"eLbkpDJY?G!6R
iZrj4'!*kNo\!,H<@CXQf3,C8<u)*HPba!S^a*$QbpeJVjJiXC!"l',3Eq5\CeU>LV*BUeqo
S=]Aun@F#ne?1T;P.]AQUC$(GIAGC*'otGOu:LCN*90&S=?"0"CGON(&*,5cl_CNTpW.;;GT(o
3_B!["EF$<mIbueUX-77eNcTkEpYnjoY4!2@8`SYo?QXJ+Y?r\>JAFGnOH*X<]ApW.3/\WT?>
F=rlVZJ`H\"a6o#]A^%0@a^T?u,@(98`tYok?jQMEc_416\udUV17k_pR58R#af4qu!IoN7.;
[8r;1B_r:-e$7jACfQ9THKIuQ+K9*&8Xc=6:`?^b+7:%+:U*'C5.1sL08%-Aa&CX3,1I;DU<
99+YqC)KQi`Iufo;H8:gs_J,ADsQZk3NQZ%G7NV7jkQ@Q`@VTSLp;VjZVUXj]A10PKF8#O8<a
BZm*FNP6csOdN2I+O(I7fWj!E)>lf1>I2$bNIi4Uk'f7s08m`")c*f.bljB8!Z3*sio,^eq^
ruJS?#rG,8%fA7I[dWJR%dDi8\\APA'?W+&c\S&]A1*!i[`F^ifpFan#Kq);FI2[0*8`ObEek
,Y?KCILm_fED<&8W)^7&j?1o8ZM"k`INML_)u\LsO.UKG4C[kaHE1\1@=8DBshdLl(hPG<Jk
7Q:hp[59m7&`W]AV<Le7*nk[M!HMk,Ylr`-=_A3%!AYL!^/j6^N+ou(Wr6A%.0(W0q5/hUM-?
q7%N3d^pQYg,90hMq-V7Qq\cL7da9O1(o"f-'65cT.<08RD)a5+nHn(:-JI:d+noF(5Kf>X%
+cgG1L)Y#,S%DZpaIsP6\2T&`4+6'HGm,6C""4f(OUs6[21SAiXm@ORldJ:t2MCW8g]A=!SPS
a[#K33^AhH;V2__08$L*4K!"P@A%'d6#(#A"3uK4O_[0.8O'"50dCDo/reIH(5+,=ag17o?m
76ObqOXCpdc*Ej`fP.OojMQ?fJQe0SHC#QnuEcHm.mGMcF<Dt=<q3oL8>4_Wk]A=2dS)/!S)J
^hT,&>Bp'.Z$[beMr?IH&I?5*Og4SbPi[X*g%=7G/@PBTeO.L\0f*Q<fr+a!HFsQ,Qa9QQoe
]ABE2di_3U3D@R&``*G[<`keGd+_Qluc5ke`"k`SRi=0d;?:6Ap7%ooJ6m5g4!8>7ucF2@',R
<lF9bX/ZMRI_?Ln'5eS]AX^mH/+IH6!/da?\&ZDtq_G<75Wp\KMP6\af*(??ld1r4X1g+E!F!
GFag3GkD-(f$d(;;\Xo>7!*tg'M,`R?:u4!>VtD<'f>Sb1S*+Y-iu@4OO8BNi<5LDbBnK]A<O
)/O;<reVqL`E41hPjl0&9qgrT`_2YULK'1<OcHAGR\8LeeHJ[*UF7nDpa9Y1@[o8KL:Xp0^,
7A5JmW`$F2VsP>"@<n(Al602N^>.5>;>h^#HS,+-;hrC^]A?-<gr;.Aa5hSsM`a/3aOG:>gg+
E&Ma/)nE&rRq576]AdaE)#l9.I-ZtFGd^,W#CLU;H2/C^hG9tm5HEER89e<O.NcJpMVm1GW%_
5]A5cO`1d05Cdr8CR'l:^ko[E)KCb4,A&7lH/b9::KH?+o?5]ABGA`;(AA;^Au-FBtJTI&t#M1
>G-bDE^lQ$-P1('Hc.!S$?Ad*e]AQ[SdTf-^JJuhgRr7]A<eP,em1?AOe?u!T<u%U1/i7u\N.X
O;GkFseb3[8^2_4gm$kT)Dnk1egRkd,.+T9i^(P"*Qo'PLX;.3,L]A6k(rI;-`]A\G#pu7?Ac`
&7N?mohi4D1gmRlicu0R,2Ebk6&rX=[U37#T^VWd\`6Os=p+LjO',r=Lah&c,<h%>5&G7]AfA
25C1S:()VS;?22AX=6`QM>hWk*+MR@1<%c`%DjV7FEV<Y(GW`emB=6U\,B,'5eH*`4"r`#'?
%aTk?Y-n<:VI2,DUKJBQue+f>>5=d*7!WR-Opch:uYI/+RSJ]A]AI\hNRKoI3TfL>eSA?u[i&!
CeO=07bBrbae4$.r^SHOFO)E^#>FGa7R&p5g:)om7r^_g$SVi&]AAO<]A9.T6>LZ[IPkiBMbCL
BPS9gdIBs'%*?QT'bFAU_nT\/1h.t2\L@iO.s._lECQ%j4tr=pmap0dRCatAiHkbXElb\IFi
3P>MPPK-!Z5)4ETepNp_H:^QtKRHI%>I)is'AS%":Mt<*&C4O5/-BPQU_c^>gEim24D)gG7E
)o#2F@Yu\.dFBJ.0&Tb(;^(&N*@*"S:HDLp8MAB/=dV1.ee;@uj,*)h@1sGAh`'1a/]AW4Ek9
o_T>FWdW.0cnf545i+t2tnt`4j/r#:Ab/g%0o-N[OCe9O'S75DMn'sV5Oci+<Anfa2&$Dkb0
J!1Q@7F;iMX?GMFhLnk'JtN);NiJ?Hr]ArNEbMSMWh?9;;3a=N(EUB.c`ll:7K8Uk`pmhl&rl
^NC-EQ_R1ZI)J3qahRn]AM`,7JibY%d5f6)D&<p+"M#JBn@,_T!]AZNL8c#$'j529B>n<_ACF[
,u!4M!T'f9j0a%V_ASMo0qXX7fASVrR(15pHCTFt"+[\ai_MUij\=o?dp?f9\s$b)36/oONY
?-'LA&Js8dT\Ol%sQ6coFQ?[;pYZjE;]AjZR%b:*c.+"S]Aj)O5Sm:TO>#bNQCI.s'L]A[?-9W_
YDY>u\;_3>[JAl]AH'RsS"G>npaI,+S`c'a=eT:t0]AgH)mM)&'f6*GXfgfo9i>.5g5.\PlW6!
6SMt`^8AV4ik#6R2rW3!*rPbZeNjZXFK#0T%'#R(hPJkPi_u^&P3l_/^_Gk%.=_J`g(Rd;mm
R@Y0D]Am$PR]AVS[(heV2C!tm'[kHl-mNtRs)6;-d)Re_'hdS`c*+<gb\DKBtl!<"dhQ^N1_Z'
$"nOc1@I^3E2GL9K`Z:WpRs1:mcX%G'YdCMStEA(oe@q7TWI#B"P^XY)HGNn3knKfLD*<u"N
q9<lO"(,T\5)ZY%/E!a5]Ai_J'4L<.26X/cJGi(/&JbZZDJJW=T@U71X-^rjq6+j8[a2$*8!-
ES#_q8%.'P0m+."V1-"b:K<frU1$Bi@R3"dco71E7!W1+2'q>:ll#.sIhun/Ced6).%0<=h4
F,q/eKkB3*M+[Ne@)MpWPgug3[+LDCc1,cb7r3iS!U?8M24!U7e_Hs__G/3[Ei[CnXY*S.J!
7e1*9h?Y5Jf+d@)1%R9DPonVdBTb`]A;ulPMbOkDntKIl3hsqRtQjR^UE<@g"+BH!)VIeu3`%
L><"p2tt`un!1/t2AHe/4-#J6M2j9OaYN]AKKaqYDD(S,]A9uU;Le!4EiED#=fC(\tbrl6Ice+
sE4O9b/hVWkfnPd7Sj=CQ&p?7N7<^Npb_f3i36_'Ka2LU$2m5;\\2T#0;)=d^[(CdPRgFh,[
m1*e%4Eo%u113@EniXDEqT_>+[jg^\W7oQmOBPbrTi%ujF8V(:<#<OSjFS-C8,(!(bU-e9IS
[an$ULfp>kK(GKP^Cbp]A_Fg@?&G9s!(h2f2S:$fXfhZG6ga/KOjWk&E$+MfCCg7r[Pk%]A*J@
b4KXQ[S8@fe,SkZ8l%A"'&]A`pcs0j8(dJHdhk!:[=W8?C.jort_L`tj7TMD9O&T0nnIHN`-M
TM[<cWYQ8T++7tAAI36BLM51t]AXg2"SM]A>Da!loe%A\.frsBF[]AG'k)T<o+cS5)Ed3f@7H7t
2_KEb6$B%j!CQ0!'d]AQZ1D<,0$ZuZLbQCmY@a=qJY2CYPcVRQnsVsZ8-EC4(M@>MDbkoDJJq
uDWL_NI^p\UW_LTf-,rpA:O!&3'Ce=HgP/^*=3Q/+:VDYQ<7\^D`=G1#A>E1heKa#d8+W%@C
7Wo;BnY\C&Jh..-'\aEf[CT+8\.C#1RdfnmMSP@fo?]A*b&afJho>'cC5[H/II8dRZ"ikmK%p
l)W0&:BIJ^_RcU``jb!nP/`JI%8?&sM>T"\N4*FC8VNbN$u^3c+PWh-/EDE0Z%ia*IPfbZq$
]AY_h6aZpd?H6"k[,>u2^mp'=j<+snsYF<kdOspS4s)g1JjlS%A<Fqf\C9^Peq:Y+n^:8A^$$
jDEZ6ZPG47o#/Ja"GKjYK[+[kq%:EQo^<NKJK2Q#K9)3Y@CNkjB7(EViL]AT4ur6Dd'#e?fpD
)]AGHf(e6#Bm3W?;2`&C)00`-OC`%)FPRMY(nUeEnVS]AU%bE^J*Abu:i8r+@DDacqcAW^V(0q
?sqo=HprH^n[[C2e,5q`mRE/+s\^%oGd_l&'-/(.H9]A5*bpGWFb_(A[@;@,\lU%rg<d]AUpfZ
:26tkf[?_:TB)U?8ccS/9R^(pS%YG8g2/A"Y1L:5G#)0MA$\$mDT63Is]A\E`Q9cBCG72@p!L
l2qK4SK4<Eo,R1Jn_b5iJ$%lJ)$5;"IIC<B:!5!lMNFdoc.X7KW/ZXjTKZ_4=fjF(^o/cfT7
6$o!/;GDdXF2\b:"\boqTM@V_+s)H7*`[+m<[--ofJ8iNZU)53dLm!Rci6)7IPJdK=7,=Q)Y
hNN]A90<)opdYi2lq2%O8S)87[??Whg+EDP0e?+JnC/?=Sn'.!a-In1_fHs.[S\b?]AuMN7$bK
Qu(^+*Opb*]A'_P#llsYX1C47]A/ul5OHE^]AQat-Q""!`BQ2'Q4en%'!R@9!0PKcN!'dSCs2T@
%>"(dgfj.IJI=[c/q=&lQTr0h"=rM-@2X<&m_Znok21boG`Rd,AoF1MosT,Oi$E:l$-i_Y>&
a)+IE"`FW+6KRX:?.,@N2_g#Y@:V!%iX1ahFdk<,;N.&F6;e!A]A<sk7hHDO#=BdDM0S%"(Km
lot;=qc4lr+]A^iKS7*W;M>.lVcX7)O;$MQ`=Am1.2a*-5H8DTDKpYeG:%`V&QT(:mX1jlPio
"Z9r,-4*;@`G;gI]A7kE<lhImGAA0ZarpbYZ!5VnfRDa?;q0ls8_&FBoeNFj[n`Y7![8uDf.A
6hX`pG`YT)RA$^%:MGb2h9l[Nt-k`!t"</\BR=19OT'A\ZRijr\.2$SA0+R4l_mQUsq[2<gu
c>Sf*qVn"nb*]Ai3*2C/[GGFiGW<Hbq0?@)OlM-CbtGb;dGXK6o'n+XWQ<C%I(a2@"GCKRr.d
KdU[@fAB@s]A',N0D,'LT=pgpK1kQ%^?`9FMRkradfNHqoBM>LDYd0?Kn>eLUW-,P@G\)$R-t
^5]A(71'9?/uMf_#U%<mLXbCPC=%1A2Ba^;9Y.mm%KK"/l+;mQ^c`*LaEtj)GTklF,F8`qX_]A
e_m'":("L"66^=Ru1hXk7Y,_cqKUoG@Lq#>:lq"KsQ0IRrM1pS3\Q3EDglkh:^:"T4=<5aDd
R3o^n$CB.Z<ei3:![7+HOf##R.cBck.g6%d.=Q&4gMQ[\3mk\SAW3BicW#]A(H&9V8:FJOEa*
EU']AEm2.i?(&L>Kf4akJV*Su1-([t[9TY9@d%Y#I]AT?.\maN^Z/+>Qk^5f--a^T?,6XMD+Rp
4$@G*/XFiuYdaH$ZVn#6N(NJu5%/'"?'O!4I:o#5am<9b'8Y-b0l7*8Zsm$<:5SiOqqnc$ph
M</-5lk&W-IuihVI5u-Paa1p"iACg'b[W+l`56IE\!2LJ;jU30cLP,iQDfCU5<+,Qj!;h:3:
Q7eVGIJ"^!WdTmIe%t&G37NaHYNC$d5BV\[QQV(rtJ!0AS%N6]A\VqYp-4PNEJ]A7UV"#b[sV1
Z%\+`m`_jTp_WED3n^@#MQFQS+oNQYM#/aBo:YgPaG9Y6bN!\[Hk3JC\N\-&H$51XOd#H[St
K/4JHKSkr@&S94_V'Fu0iPR6ViW9"l/1)$ORf0qeoPjerXRX_fkJ\!QoecAnna3EQjo5uD^U
qG/aY[o`NF+D<aQ/m"LmW8,P/XG2db/t^gMHK"M>fN:X^a:6(*6%J=5AG^%,ipEa=EB@?V!_
6k86/G9<[+KBQ.m(quV$</ZNV(GnTHbAu_#r"#0H#VQ`H&1s?(WW"%#:Zk\lqgr!1CA!XRWa
fg_+)sY.GD(aJ`5@>o^`u]AJn6Fr)^j=QdH:>`,lGP,\c=?_X_hel5Q5[3(hW=nF]Ag'Acl?r\
nrJPedAC6gphU@G&U`N;l`b\V9h9:bi^--_)=CSd,]A%rm)L"_=f/=mQ(Z2ek@D=c7phBc?aD
U5m]A)uLTh34ML=3#OLakiKg(@+:HPCtZFff8Jq33NcBb+,-l:P7;*W5T?/f;tG/KAhbRU/-L
[&[@T7;,>A$:8egHcODV)0TO#pYpCJW\3,dRb9!Ukt/shP"C19[2c\O?Ss]AZohT7IPl!mhYA
`WY6Y$J,h?YSg,`KKYic;t,)1s>i*UmHJs+`Oe.]ABJ5I%h&gq^nk^gaP;$WTVJk$B!c:hW&s
hC'7S]A[r_&CIi;[JD;,4-'u>1]AP$(^fa]AbXIJ(25\;faSf)dFdr2W.`g5pXn=7X<Oe^k<oha
[!aZVd2:aCt4A!Ftu$4dDtpE,1tbo5%_nXied`*O25MIl9Wb@X4I%9Wfu^!C,\!`PH$`#Wa\
Bf'[eDEq(!m:/LeA.))5$BA##ZTI"%uQ_O9[.D+B$Z1E/?&6gZ\>?siu>>OL6F>Um&Q14/qF
WReBI_qCopN#[o%"uT%N3c%m(V'q4u8NS6,IAFXp8_*$S4Ak<VKSBTQb'NI@JQe&e0+Z<M34
oDA]A<<F;<R0&K<Y<_`o;[6^Lf!.?W6efn7imXSRMdp<EnKSHi1]AU'AUO:W<YJ6-+ULV/4W$\
AVRY;^8(T/50>cu2VQ=qLFu7o5Ck*heBuUF(!sD,&#EI]AhL-_0'-3&*FG5Ci^Tu1br7YAt<m
31QSk"d,j&a#c&-!$(M3nOGkp_?<8iNN>M2<;eCaKN4EQ:kY:<*Ya+^aJ!5YI_:Q0tmknf06
m]AjA&0:foHQ#W0=$T1ba*=*11\V+q(#'n@5rHqsm($2R]A#^.n(jK5MNA)mj!8UhOL)umY@ii
'6Oc"C6?Waq3.:f;5NP.O:4gqOk^HU[EW2(iOJTbZ;FsWI=@A?aeG8:<SdLp1G>>BW.cYsV@
ZJZH$Er-V1H!RY#6hT?h-(/o-uZ)s044;cn3#q7$4quR!rssUcS=*d["ZiBu2KM:35*LM_Vd
T<4p8ZT7(6e;+4\[@1[dgo&ZK/"r`V2m[S)8SIl3"Wr!F:%20i[Yko.Q\*_bL38`%I]A99:%G
$>seh)lCkn'&XaoT(jj$?HF=C6tYAI,1VmQFkE)K%T*!l!?i`KWC`s0en400(WN@P@\'D17+
CIS%3Y'q"(^e#%a)Be_aQ@2<,JNi`;FLM&3]AFl^>>\qLF;6dV6e)e[Dn>diTcpR&Uhjl;$Tr
?JPL*c1Bkp=c5D97>cW&\+scM6*DaFA5E9%K+VWMDqoQ)YA16YU=T'LX48M(fCtT_mNI;LbS
WpHclRlL[/W&/n@HI('GgZV:]AigNGb5C7_+oG&)g;,-f9n>e\B3+"TnKQjFI/`[H+f9.GJKN
FI;\_g@\Lt@J03T"3]Abu,8u#"Io.ZIV]Am^ekNV.ekXR=%1eHZbA]Aq$;.M5"?aLP"rh#1;Y^e
"j"65;4X.1;"n\.nA'1nK$AbqMhi@9%fZq\"0,o\?j_cf']A@7Lg?-$(R*Kik)FPM&BQW8+mX
tpjAjLdeq<\&V(kIALA*dob\2n+IqlX,lD!EZd'`g\k_5pZf#-k&p/(JM8S`)"'?f'+h^B,n
PED/'D`F9H!iml<LMr_Dm8`/[H$DM^hNCgrkEZ12W\%*q;?WbL*oq@H5i!MJ<U@IOb^5fSG+
L+eLAt0T'l(,:-3`@E@)L`=7bmNik@;.8jG^)D4W6UN-=s6dYL99R?f0F[;@-5EFEon>KQH;
IiC[Y"%P^.a4@Teh@#n-e>Eg$EF"#N&hX]AMs`i<jnCp3a_>6kV,%,qTaJ'$<ZKa.PI@Wk6?,
f^Y\WUft1L=&muD-pe2&,k!9HYLu?j6K^&TsO]A1acHY_q[VpS/D.1'pI@:B_RlXq!Gcu0ToX
<V*+E*S'@m!qL2R'P*hfRII;n-QcX7;\eQDUii_+`2K[[A>`=k$V&QE'16]A[tDl5[]A'N]A_pF
ppHOhU6A^97'GtkoJ`#b$gZP+bR5K>-2=!cA_O88:XQ(GgN!MbD*f$;ON.7[YO<+4-CdsS^0
F(9b%46Z3C]A6-=i;miKJ_b+lnduFhO8Im^02ip)tV$bf2@j4C9@1B]AuG!>OJ`>Jl&YGNERg+
D-RMmaCJl@>KunTeo;[VrU,&?..s8^JPd,t+V$>b#+8Z5F#1C@=),k,CT_$c`;/ii<m3#9Yf
Yr:)`@U8Z;-p<PTfE53V;CKgeU"-eaV&=;55TN6(g6l3Mk%>X!9)__dasDEhNStpm,!3]Ap@q
76'sj:VL$^/=AXu/7e2COAL3r=e%:SCrg6rEm^.(#sWoZu?@tFcFJ!0JcOl#<\me4h6(OHkn
dtGnVqpb+)dcm.3olYlm)On5DU5qbWI;620]A9QXO'+D1r]A(mIU@DUDL,.dK7q6c,`@g)J`qT
IHb4&@BlpRB'$8UpEthVn.0Q1jE2k@.J!3S]A-g;&,,%kZH]A_e[2G7P!RVZ\!:YT]AL^4^Fug.
r*fT[b21jPTUcZ>_En_$Z,\?+t3<VdO0;_?i\]AWj(qoA[PM9`4nGDCII#cmILb$#ZG3m`BPp
[(4Y<&MTs5<0=XB>,(F9jYf<B;\S`kVcs?YIL5eZ35m4<!`YI1i/)lKJ'kbY2UC(&1kn*nPS
LA=Fb8`&%<BgQ7[j#oJLbNJXj#[VWNm%\Gkoj;,<0/G5=YKZ?g=8f?V2:%9l3$D>()/j^kht
$I0ZVRoOY':kSOS@&rttISBWpKTpP0m96eo2!]A5=HeFk4PipNXBopn*l#3d1O*cuXKM2&<Qr
\`55c7FkR]AH-]AId*S#-I45S?V8+N$uC!&%M9.nfe,RMK.^-C4`']A%@UNm.JM+U:?_"g?m`h=
a==2=!<t/dj";'"Vjg-W[.H1\ao=HAq0[u-6]A;?`o8Xp@"p)D[2Jc$,XbiPS`B<O5V7;nM_`
%X+hJGbD)Pa3:r]A<C9rKG/0JU''eh;CC,*_6m[g%4T0(ap%S*g9+Wr2;*?'CSa]A3DaU)$/B@
GTnZ7IKJuMMX!W"P#`X]A+$FEuUGF07O+!,sfRM+.lPE;)ll@/#eKT7q_GD'0bX\ZPbNnA\A0
,EMQ[9f`"7!D4p,*n%G09&!:S`,AXK64'VMcSC++H"aL)2VZ7j$LMB?\c"lXj5a"FbD3'*H:
rFuWoHe-eE3)uKsG*rQG#oOFkVctkZJr8g"KRa<pP7g^6Pn6G1]AL5r9-%ZjXKhDe^oJB-+/c
!_1b!ha'`5Vbc<&OYI$;UUGd7aRXp&CU92Vca'<D?J,YjG(s#)qh(*3r%YEN:iQtD!5*Oq<R
Fl%,g4(P+GNJYF>>?UXRmjL2(Mrps=#4.$Y*&&ZBu-BaX)-"=0)t&@kbaCf`Ya]A$,#!5Elbj
jIn`6^EN-?:Y[mNAX=&[+sU$?7R#U`*a_Z<BKoS`tF.hh-Vp1TOrKdl!NY1>u!7h2-JFc92-
^RVTJFHp@K13]A;9P>V-+`L5@,;g7.!CJD@s/!]A6G+R\1j6bVC;N*VRqPi"9$]AP7g;qacK*#q
n7;Ztt*P8D_A;3'h1L7(kID^5DI6a(c-4g]AG'pLZ<%eA9"VCBYj2W+meYWd!*YdY-o]A!CSQ9
c:=#"B'(je4#*^qA+d6*@mLg3LSRi,#1"I)(YjC&f6-EGS_h8Kc6dJH^CC7P+Xmh7l1Vu0WK
?BFT9Eo[+TSNn-DC9e\rUO%<7i$?eEg(@k#pE^WU?3aX@`iKV(^j%c3KFcQ@.2X`G#%a,1Q7
V"eM,:P1H<BIqlc:HO^XX1dVZ]Aj[,t#<VqKXP[/QlB6pR)^mnKV"VE+j9&ka,hLh]AeX?N]AY$
9GgKEVcYrj#A+q?UGbEO[JXq=[FtP6N%ZIZ`q)YG2R[:,%4?ZPE##_EhpU0Q,a\noqN%8(>)
9`q9kU4ZM&G<!s)PB^1>@Elq^H:2!d_i>qi;i$6Kb'9E$$@UWi@TT-#jSpo\k<*nCY514,lC
WJ-%PAgXCWOnca2F9co>/qV/a[]AqQSt&WV+Z,?QcS&4XHpWe;QCYA6QM"E!!@B^leb&SGc*C
h(U4!el62)4Zd\3=.Pk+cKWY_ZPDJ,dEaC"D9^*Oa%c?E;u'!otu62b\=1ugeaB[T&.&:RV6
Xch!NU0K/Y0jY]AucB2iU-ORnqm<]ADb_EXn0V>@_Qj^.\eD^s),8^\l*Yp0g9bq7s2sn1p"YC
[`%4_I.K:VQ/_uj.W<bu<)bZD4Qsm8.[1#c!2="PK!)&^N<Y?^M]A]AcL'RGJ$[002R6hKikA?
/<7Rd=@HmJtDJ(#0hhh#$Vqqrq7;6-\X3dY35UJ/TmEQ3GI-!q4'c8t*Q=5s`^\f15]AN_go&
HmF`L,XJ*:'G>q:'N(m3=f`=t'\<-7.T@!`X"J!A;9Xk90W6&Zk6\X<C/ITpj+;T1YKE.%b?
)h(c#da[o.Y(+%md9%Xcsur(d\sgXd21kLK2lLUANitcBR3.JnX-rGZ.a-Z5i73UX<]A6HDJn
5:E:P7B<=,DgIAn9J`?DMr(SqCTXcTq%'Qd`MSu&B8oaE_WPn0ZT[uAk(^Xb7Yi%h1om$j_)
_!<K,4O6Ug,T%0c5WeVuaKhP7M:rSJ"#+RWG-[%?-gIHmI[s_Sm9+lsZTUTs5V^VffNU]A\l$
A9p=oh*)j%)i!aT[moIpEJI%9SqE4C`?G"[hVM(R'dl)9.D4^"DF`MCWK0<UG"ImQ2.ZpgMQ
sTo?6QfsPKZF]ArWs7'``3n64YY%f<^e-I?L+9m*YB8aAF]Ab.<(WIFN&o-S=kg;q>o0<;2JA&
2=9[:Eaq^Ne'l\&9Sgl\@p?OQCG5f^"J8Ol10J6UibFg'OE\Ze`)@4h=^8WDq8>GPI:o#,X@
0,d>2Wi^fla-JNS?'DsQt*_/(.aV>uFPA)niYeR+NK_2=j5ll:1i)a-t,<3[=R/+_!R@[Hkp
E0&pI?FJ91O5R,I&-q@"+i:0:/aES'WM5*\ME1:j&V.XY*d+t66%tjj5*VDoV$qY#G;np4c_
.C4;HFKSS2gWXfrgTXN$t+2D@\cb3>',7"mHO>H'5iI'[BTF&as%'%5&;a=j"pp=)W0<nk8p
)($N!#M+\7>e225EA`uq]AQmsLn>a=\1$p<$I"?'PC+ul^ohhbh)DM0;qoTX/C8A#iM.&42u#
p-7/AOi@nM#Gc8Ro807L+r<B*bfqWp%;Odf>=bsBoM]AM..e`#+L/o+acNPWMm1*_*+N#d<Ck
j-2l\B/f(nXC3!:0(Qr309@(3"+d4VaY&IghUl-).lEbMc;&^*>SanM7)_kZb!ZI;<//JgOD
bC$7pY6]AYBDht&]AbZrYfKMF]AHX;W'18>Yt5[;qbjG/8'/MLMB'en)!jP!2.sFu+5K'6giS:>
Ur&`dhr-B!,L,_)KBd:0o&]A$$e/+i5[a.DRL!kD,/Kc2[U-pG.-0sFIiqo49s'6.7"q9W2bg
<A('*J@f=dh"KDssiIg7-c;A%t;AQ*"C5W*P3W%*Bs/TM<0(ZM&2eOfclP`phB4_?5%QXe^@
Z-f!k;0O&"SUX.YMDi5B!JOkk)l6ImEN=-FD+LkTn1rSc:Q>V8(qklqL6A/f#iAc0T5A,$Xb
B3[j.&k57uW^lB*Hi[H'mk=??i1.Vkp4=%;mHas7LW0UbM@o3L9W:I2='dtmBPHi_ULoIV9Y
N-B+C%E+0mZ0N0b^grAoq;Ie#_7R"V]Ae]A?5^GFS!:I^7+&GauBM$&:^%TR(1VnNgGD+'([1q
/*t8BrIJK\\O!iAA2:$rGUf;&ES_EfgV`2<CBsPc`8;*T=kpe6I10@Hb_QPs8/['lYK(^:b*
rF.)NSnY/aunSB6u%2$W6A@Y]AC0P"#?QER9XD-aKu_dah%SMAX(eKo0-/U@u?s+ou/4-[HK\
!AiL*$8&:pG/nOh<cgmFbdJg'o`Ci#QK2*9DRbh,VR&T^TYB&Aj<!OoIhgj+ma$u`@LYI9j(
.\#`eusUqESdq+2+G:8FpseV/AZG&=e!s,+c\eg;4nb.t3J.N>4:Yt7U(Ag@F^nIZ<9#p*OU
h`VA3VRTiJ*U4m7`[=A<Y<on2nm:p92ib<6$"IGZoqLQ8+f8<./1D.%dW.UkNX.)(ot:YfJi
nLcC0Cb*X1o@&pZuKM'tKD.ECDlB5I28UT[i6&)7I>h.aRkOD9[=_[$FGe+<9'q4PV$r]Ap2r
YZ,VfOH7W('kZb>.CR0>SX>u!,Tk>uh@a1^'<\rjT%eg\C"I_fq\d53C46-h2IWd7Kl1Er1@
5_aC$rM[rKbH8Q0W7c:IAZog;^&8nTTi@*%0Xu."m/tRP1@JiZVN<Q5`='PD=B9&(&B^_p<>
Ar`Ub%F#Zh;4Upo8Lbjhsj7i)\u+_t:<BWa3Vb)k>@EY2&6FZj"i(5fU((A^T[FhE_;0)a(H
Wq(a.gofhJJidmfpoRcE]AIOhqUXR9u=.B;P_OijVa;49q5WEZ9ejl5:,3"?pb]A#`Z`"WO[O;
:]A+?<6$k"Tgl1L>Tmd,?tWmP15G'cA`.)0mge&ge,']A\92M]A&64OZIrn3]ABpm&5Jn2mc6M7&
$h:rX+E,&0s``4&HRJ(]Ak;g!Np%ccfM'2usEf^''[pg,%??17P)fY$UdIHY/sZoNa7lNArG@
4u<-dH'\_i$4taOM@:i_/eolEaZ>pT8,pqG?o>)HZEZjH5&m#J*7q7.A<b\n?0?e8ZEVUq%(
^"Lt+lnG]A0fNOk4qQoLkSj-(IfbTab?+!rL6'!mg<[VufO\C``F?:t\I&VdFj#5<Y;Vd$Sk3
Nh7W2i<0g[YiZA)!$UT'Oiq`b6#YRFg%RC/>3m4<=m8A4r=&tT1\/lh-OYqJe%ib>Q*.d_f#
k9?rsPQ8:0Z/tKP\C]A^Q.Z,r*'qo'%-KNb1gp;^/>1>dHoAPR#D7*4L:-#Y6DL3]AW$c"Qe,6
rg`rl-ZbM+X!(_KAIY#CLJ4(J:2TIWDT>)IN@]AN9"P9$^5oQPf@?03ArG_kce*aW(5]AhFKIf
H>(AbbF_nGEk""->`cTfEp@9l\,8j<D&@D@ZM_rLp1s]A?c<Hs75HCUajq(h519+&388jJ'm6
3VdP[YM-L^`A$i$VtjI_;k9TT7@NHi)_k!"^6p.sh3^]A(p9V]ApP%PA_k?E`_!r/b6F;"dP\A
A%(&T^&GuG]A(@mS3#;g1lfc'8WOT%%B&Ag'8bBM?RY6&e3leZeM[JG;RJVm%%l\I[f-ME+FB
+US4U=KkCR]AS#eeq)lh[%i0P-cKXJ8CDnhl[%D.-YR1\Df0q>jMn&mX;K9jYV6B.7%/"LAWj
6^Vs$b5Po*?KUH-A^6,ej4TKkh*@p8o5]Ad=hkKpCt]AW[kV)Rn#&V!=YZHIE*>GN[-$.hTqGR
&YB)jj\$9^YO_S@XugGDEk']A>$_c(LKc'Kop[dcp>sQq3bR<nMg'NPPF^"Dh=qu#"W2F=!0"
1.Y@P=A1!spsS:E*r_mLe\riL@4F#1dfBH6!SOe&lf8PE:V5[7`G]AqIj_GV]AU&q<A3_TJ_Ef
._`NX57[i\9N#1jaG_TuOS`"+C<?bKp!c:n28jet2s9XkKl3EVgUr!WbHR/SU:Tu0GI?\EG'
MMEhg`t"o?rBoN@-gWDkEC\X=LHhYH?RM//grcTD<"@a>SA)o@7'h&\-]A@cej@[nT\V',u7&
tlor#mQK^mlQoMR:Qcte"q^%eV(XHOQ"JL)aQYQ3/8mPF82=aAV/^,]AX;Z>O)s+<RYT"1JI&
t%Q?*7:_]A,OHLDm\IL@O;3DN>7VSK:\2e[i$4#^]AA!9]APe^E\55/j>0&GEiBjl>Q_!HHsb([
(P2?U0'R*Lq$,Sf4g?]A^W\=P2=D(buIMLH@=*MG>M)@@l's'RB1>O44=]AO+3ggs4_YN_BnAp
oCl#>h%k@np!\!_"7pOi(X`;GY1mE2[jQl_<.lqZOu>-H]A1%Sdn\NX`Toq*R)m"?(^4:[a#q
#"&'_=MAMiE#8e15M1&Zq4Li%iD?/bU@PIc]AJ*^j0O4rXk1[&(Q=DNe.3M>^p-r794^8H`#V
>MeKM[N/BD`rqacs#qgHGr,p;*-2np_Hk0s2Z$*o<E0B+2%6Wj\p%0k=#"HJ()!Q3US(Xr)h
BDTQ>`L9@T"XPTm4H%J<i2G8KX$$8J4-KM7T%N]AY6-W[9(=!DmCus9M07uCh4NU(E4>a7C#1
uXq7m4S$Zt,fL5:_Aabo5BMSoA#<=@c\eO`7aX06:aeQquZlU($_=95kI@IOX9H.DY2<bS=b
0;Qh+BS'r%mt,g/,u)GPoiJk7J8/:U_J?LD9GZ'a(71$P0VO!U5ighPfj>SPrr,Qn?N4KkVU
8JMR8N'qr/P"*Z%ti[b6Oils0`UGkiPkK<)-,,d^+WQatTJ#ceTrYI(1eXliC>0rk/QDd_-h
NeQCPZTnchqUVc`!U=ItY2q"<n$bTu9:N$bIH./9CTW5]AZ@H;M-e!hH$gHR+b7CR-[R6a/"C
Sp,`jVcYeNB>*ZVfmFPqbZ`T\8c_H`>]Ao8UfoUPd2IQX48YI:Ku'@nEX=B0RqBN^c.Ro1GHW
*HWd(7'.XUV*CfMa'ntDiJ7O47imhUndh/9hd#bC;7g.Q<@&!c^'Gl?RXmMTEn$hmT@*<(Zc
hFBV,0h8hP[]AeGV=MQugXt@9&(gsS:rY^*)l4J;o>gKibqqB)')R$7fh>dG:[nj+XBAHS?D>
3!23c3m+Ia+A[hLdocX8thEE81Gk<Zbq4W>c\XR19ISKd/ppfq5-/NA9:KJH1M2n$B&*O5*;
>E&XeD(:6<//4sm$DoUaW&inCrmi#&i(eNO2]A'PJ^E=q?4?5g*3cc2j0hudN8X6&ZQG$hc3)
WtA5R<^MVmLC)h0rMF*Ds[Q%]A<o8V6&+=TZS!s.cgHZL%Zj23&g(!+)`JuT:He@jdr]AGR<*;
Do\b:XR/?0*c6TQ+1h]ARt(OoFS+kX[''Q<`sR5<o,QVT8gYO#-R32,9ei6XY6?nNF8B2rBN9
@&7ZLRIa72qa/`S;kQ18oge>udZ"PGCc_a4(@S3-RP.I(rf]A"[4#refN@)G(5oRD&bgX;1KK
kl&#utl548u8l8?+2#6&%qm*(,Ma/kSt$kQBiO,V]APEceebSKHopOef1c@ll7%==*=1l\l\*
Bqg&BT+@AD_\&._8R's^l(%4R,OQCF`khp$_PQ.6cm8^d_p:!E_rt=[Z$0E_uB1obZ72B'.M
,$2\_R=KNX<cC*LWH!*Tg-a401iU>+q?KA&klgA3h?s`hs_b*+C0B(^K2Bd]A2HVMpo)QN3a;
)R*!Qhki?[umUVHj\lk$0g=<PsG"@p3%5oa2ds,[AdWUH:=Wj&Dn^#Y_G]AYm)(>S/2CD`26.
Qnuk&!:F)?V?_B--^`4VlYlpA5X7=$hFsjrXmV/>+V6qpE*_\^,U7H_1#E`K,Q?aIOVr)m'o
mD4QWcIP;3FG/4Pqs+q/;q?-3sba8)ij%ac8fA!&[@60#ll1CufYrE13YiHVqY,k"'m)&4Sn
%s)I7N']A:9Qcb89+Bn[AViIdm+OBRKcR3hpN00ruke@6bLWg";"$(mqbGkDoAdmbMk11>o;P
#RZniMIjgeq\a,U4&]A']AFY?W'/0\U^Q-DDhp3&]A<o'?u).683KmPdt1TV:K+]A7(r9e_nTSH,
&IG-g<1[FWV,G^hf>JRY[7\3DgcrlJ%4h7K[Q%/lQ]A36S<$Oi7J*cF$Z(>0=n,UE&/i).E[m
N2HT&<;=RGW+?f<U?KD_Y4^l8E3*<<i2*59/8mAuWQ,b$`79u([`'phnR[X"9GTBY8r-/Hfi
hI2-5+5cIi2&I;F:^:fhgK!bU6]A"@4Qm887n$87%RtIU.jk`%nF?:'TJDqE=jnbXk5N+0\2-
'L_#haaN"6u(^gi8XaZU#M&/%NEn3gPJ)@jU-^JC%=F;S<a^N:^Wo0lu;I#=hA-d-G39HU?[
>C^2ML`p<cU:;2fg2k%E2$1u`HtQ`**!*nU;@X:Rj7r"p*3=O/qg;\U7aj@%#-U`s,QVQJCU
s)A<+.GHh;0<Ku0M`Xa[s^M$]Aof*am"BEiei@\_=g"m3A4T:pk0JVo/@eclU<fL9'g\`2%uH
=neM>qtp#N@>_ZpY*L\ZPYcPma3J]AHP3N;0jb[H.\B9G56J*qYR$Og[M1c^f`_Y`f<f1#13^
sV?)fqG+0A]A,tZ%T+ZE=_b\mf&-\k!NS;hs,H6&4-/D<:420\P"<cZ3VR,'UR))RRjOY0nTA
*qB'dqq)X!m6\n*f$.i.mpb.81#XYh-"Ah'Mrd3UG!(:2Rr&Q9?#a@;W?4/KNStmhHKYm6EC
"WQ[+Z5*>MW:b@G`N2rkPS-H`4(R,r*tB^kcNH=f\#DDklnlr6T.LPn5)E!m"]AH.M[S^flP)
(h-)O\>-&gS.6P0)b<_'a.!"f=`+-ACnC7-0b3F-@GUDspp@t.';DHc!f*M<Y$2c*4fJkmXd
Q7d+7[:bXHh1%\u/>1;'LL%[X('u:qKD6OX/IP[+?TF%[KQ3m,-:hQH,joT\#9%Fk$m5\jbG
ILd<##!k/a[+um?-ll2*=ER_W6:;4^KQ1A9Zhe"0%#Eba*4_e%RM'Jj^to!"0VdOZ<"oXG9-
c]AYAU7r#_T.r\ep65m9A3'+mFDhG@>K%VBjf!)`DMW)M/a`g&g&=Es-t/D'[+YM9[5i+tA:2
]Ai_=.;<Sf;5bFtFH!"9&4aQkApKW&.WH?BnZL[]A$pK5GL0^(Ci'rRWHGXA:M9j42kAe0jP+r
?a?D3Qt2lB_MHA@:aN&//*"cNfbao=n8pp]A!d$[=(O2bbP(H*p<Z?d(S<Q;@Im-s@b1DM_oA
#B$(2.p!bpj08Y.HsZ%SI/sdE=fD>FQA(8+c&>eQMW'Uo,TVGT"N%K>/TJqo6!]AL=>r:]A!.H
dEkQ-lOfcs]AM<4f83A#%9eT0f]AN8]AUiZ&IgWMNiXG`D\![1j:;KTRK]AfCUHsHJc)-4WkVmgs
me%P`*'4ug_GW/qL1KPta.=(M%Lq!N&,??teh.[;&0rcPTcb_q7Gs%T(\F,JI9F20d`IrdTE
;a:'Y%KIt]AYOUH2%g!(JoC2[0aW0Jl]Aq6q?pag=7t.a%L>VuoUl8)kK&+X54(08r]A)Q[]AnUJ
/f(_o6O-&"LK\<Taoplq_c4'XJ$#/)R-B>0TX3o1H8,fL<,Qp$++o"U9RrXj*oejGrMqEl5H
M=N3%OKAEK+G[JmX"[b:B8VrL.O`n,8\+n#UhAcgYS?t)R+cn.*.Qn'#0,Xt]A`&^J%Y+_D'1
&19Ht,@^Dlg_&!R^T.#i[s\otj+OO=g"U%NcftFL=M&*BolZ$'\,?$(Csm3(A.c+t;I`%R;U
9,c.W;Z0%BLjmdXbWPk^X)SBcN)Si8]A!/T`-dPr.2\4AZ3o(NKt=>p1fVXWG(>5gmDq1jhHh
"\'Vq0WXT^P?0<(@1#_AnA1=,c_f8(W$rc#cTd9?Lma/#ujalW.ENL=9N+Rj:Lc='#b;NARC
,u"X56>PV`UE6O+5'9eDD*OV,gP"(62X3Q.e)T1I'3#nim(O/]A<Jguf%C,k]AK%7IZp#rEX-U
]Amqda8D(SWnt<K::*p'rB=h]ApJNjVNA);;'5Oj$?^Ii[*o@s;s61Te7q>]AR+T1GY?/-.-OQo
ues,2hF!>W+uW_@pfaEunG+V5,28#&@a7p$E@;\I05oc@t]AK2abjcOV2<Ph]A7XO%rDEme_8q
-CC@%nd_Fnu*k(hbI7iJu`6\iPr*Fr)bb@FX]AEM!O!ST[Eq'$.\-1NR]A[,sg8b?9XNSq:>i5
)(!Be;)P:,QaF&4sm@5+=1c%m#aj=Ec!er_Fc/6-[a7Bi]Ak\P+jfOX>`\X*$5_-ns)2YGM<d
7<HcB<j7uE2"9%pEYps0s`?;P^E_;\BN5+0s&G#7`sd96":6<#`tk2o5t-<7,u0\jZJ5mcfU
q#&dgKKBD`F$PKL*jHD@KEXml6o\&b=MU$1(4SOPJBhtf>ru*4igOE9\6?o^,kM[?@&s'pQ>
6FjCI#ZQcc-9h'1l&RDa$i$L!$/9`AA4hJ)aH/;s7(?`$gCp6%n8D+)0.U<a>gX2dR`nLVC]A
>(t%ue`48-mUm_S,(2t$a&'tcXnk`Q3GFA_D-s,PI'(</u&,,fm?R-@0#X`%q[=fra`;0+V?
TJ/TIc\d-"h5&kpKs&$ch4b=3;bt(%71B8T%&rTF,]AqHmKjRT?%iPAanZk7Q0$>E[o`L?D%Z
9hT`aHSZhC!)o`"m~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="371" height="167"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="日-指标卡"/>
<WidgetID widgetID="14ef713d-676c-4fa9-9a83-318198f7e351"/>
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
<![CDATA[723900,288000,723900,723900,288000,288000,723900,723900,288000,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[288000,2743200,2743200,288000,288000,2743200,2743200,288000,288000,2743200,2743200,288000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="1">
<O>
<![CDATA[统计截至]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="1">
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
<C c="9" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="0" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="0" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="1" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="1" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="1" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="1" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="1" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="1" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="1" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="1" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="2" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="2" cs="2" s="3">
<O t="I">
<![CDATA[1]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="2" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="2" cs="2" s="3">
<O t="I">
<![CDATA[1]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="2" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="2" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="2" cs="2" s="3">
<O t="I">
<![CDATA[1]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="2" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="3" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="3" s="6">
<O>
<![CDATA[当日货量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="3" s="7">
<O>
<![CDATA[（吨）]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="3" s="4">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="3" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="3" s="6">
<O>
<![CDATA[当日货量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="3" s="7">
<O>
<![CDATA[（吨）]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="3" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="3" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="3" s="6">
<O>
<![CDATA[当日货量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="3" s="7">
<O>
<![CDATA[（吨）]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="3" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="4" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="4" s="9">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="4" s="9">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" s="9">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="4" s="9">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="4" s="9">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="4" s="9">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="4" s="9">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="4" s="9">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="4" s="9">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="4" s="9">
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
<C c="1" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="5" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="5" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="6" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="6" cs="2" s="3">
<O t="I">
<![CDATA[1]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="6" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="6" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="6" cs="2" s="3">
<O t="I">
<![CDATA[1]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="6" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="6" s="1">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="6" cs="2" s="3">
<O t="I">
<![CDATA[1]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="6" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="7" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="7" s="6">
<O>
<![CDATA[当日货量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="7" s="7">
<O>
<![CDATA[（吨）]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="7" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="7" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="7" s="6">
<O>
<![CDATA[当日货量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="7" s="7">
<O>
<![CDATA[（吨）]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="7" s="5">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="7" s="8">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="7" s="6">
<O>
<![CDATA[当日货量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="7" s="7">
<O>
<![CDATA[（吨）]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="7" s="2">
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="8" s="0">
<PrivilegeControl/>
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
<C c="7" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="9" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="10" r="8" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="11" r="8" s="0">
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
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="128" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border>
<Top color="-9847561"/>
<Bottom color="-9847561"/>
<Left color="-9847561"/>
<Right style="1" color="-9847561"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border>
<Top color="-9649411"/>
<Bottom color="-9649411"/>
<Left color="-9649411"/>
<Right style="1" color="-9649411"/>
</Border>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="96" foreground="-1"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="80"/>
<Background name="ColorBackground" color="-15386770"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[jaDVDdrkZ)ICo(!q9aW%.k+?h237@PM(Hp`&D4.lZrkG(=-t,2UETdX11Z@BW[q4$/eOL9J<
`Z1FZOXpXGneVQtrq*U_=X4@"X$O`\q5kkPP.&&%l;>]AVf1]ApZW1ipZ2.!rHLLJcc>)AHG0"
3^T:X$pX]Ae%4_rWM\^*M79_,8f%tr5sFoRC"ocX$nf67?.baPs2_"5l7rR\pW)]A^To]A[=Loe
'4?K(RAq;;uM%^G-&@GVe:i^msFQrq[7lZs(p/f0"dYjebmi_kF_e)';$iN6Y=jD5JR!T2eA
579G\dXF(m1X=.qHSB$ENlA]AUp7Lq*9#LR&@W>&hi8nt<*jj*%g:FK,FD[XtlD?l-bk^4o*7
&4^,g$)U`=VaC#=:TdUhe*KqG>fGKUi)S2#3IU0#K$Q"1r^X=h-QAeM3E]AP"!n_%=`FbAO-R
bIE6.iT+<Ts#^/D#CqBsiE1`,DN.LSCC:ca$M<KL-HO>KPE&@Z'cpD#LIna3[9@cqo@&6qSq
@<JL$8!tL%5[A_LpV.Xli$S('k$RF/1\BfGb0\`#d@O[MaP4W'aEOnH#Y?7f`W'JsXS@%3Sd
Ws5&'JrVSVTb(Da'KJL1Gi'>5/Si&.r;8pI&p0/M[VPo73%#q1'?iASg^GG[O^lAmMC8`?Fk
u0E;hPS-fYN+D7/V0ledSq(a.)h"gPn29peu[R7s_JU0Yh$Do**>gY</N9dI)'-^r)1TM7?t
flXEq<q*J#;_!%?&K:VXIa<PhSu+&N=n>LPOl_&)LI9">r-B,.@;rVp\F%oKWIho=V-VDJ(V
O_"<isQ5,HE4C=W80YFB+E>jb%GTq\L"\ZtU7<4B-g<g*5!PM/00SZT@i6.RjQ+EQ@_SmDfD
dK_]A(t95!"b:r5\agA]AqnUJM7`qQ!\=.`g;'^Zt?Z''8['`;1.sQ=Mcra)uDiU7rV\I]A>Okn
&gV3-n8m<j(_f(H*j6:p9u^_]Ae$$iPN5f22`M.hpk"]A4g3j^:\/Q(D/`;n+#9.1$_`!:`>$e
iIHJmhJ7"[pIm3FnB;=PIV6"SR(-/3WUX$(jr.cD9AgTUe!E@A?de9X9#'nIJ['fEhVs73rP
FAW'U#jb"*-LQEU:pk2S6j:#c[jf]A9,HNHa;!b:7V/po&X-drO7s5^QllPk2W<eD8=6+0`?`
UVK;iH?1BH4uh0hkb[fg^IZ<uOkP*W3!nhKKOC2H;$F?^XiBJmV\&7?B<<^RAhlN#UY)aAFI
+q5X9#l"]A8"X,-u`=cNk4C`mas:(+V)eh,kOPY>?L=[F<uYt_--G4p<\(Sjk::P/(5gTR:3W
Gr(4om]AR[DlKaZ%;Z=JM+V#F/*p*e[=uW/(opZ0F0*9j[gAN=>^jG!CfT6JmW_T$dIj\#?+h
KJA[quoToRGM+/d%q$`WNX79#@iBW(@rI2/a$9/\X@BDd<1<Q'mHf7H61,-TJBWE*&2a'*n-
"icgNj&E"HIP\#abmIc)L^jNd^[7ZeEG.A#TjJKJ)ctCs(F3,p??UfQJ>Uga`Ic;B-%G626l
F.VHmL+H(HF_d9MWTt51,,'OLOg3>MDD>9YmnO]Ak?ccP*V]A,:3+OG2GDS0)7q,?(Qn(UB@XR
8gDpV#CccRY+(RF"p=4%=1]AUA[,&C,iXt%UZ'MG^!/(WokXf*Y.Xg40AK_:8L*FHjXF$.Qg(
mf*sl*HlUikOLE,;VKX3n:Y51I$tCS^pM=R/qc1XmNn`k-b_IEa^^M@EM2S0;utIL,HpkNWd
+9,J3bkJ6Z_[ZO<CPgOn8pVOWipRDrqP$IM=eJMg$Y(mUki6+"JacQeW2/pI1jVM*-/+W//#
_%i-iO#<#X!')=i%bHM58.9K=ih-i/'YCQJTuUfKAL2Cp%o'#=Ik1l3%<<Wd7@0"7FPE(%^(
o3%mBc5D9C^nJ(bH9VAP.'^HFNe4Z"fhmfu[he)lhOoY#.mC0'sBQ%n*+L?;MfKd[GtgB)4!
do@Mm!_FHs;*al_Y!qsi<k=6tX%/8:p&h2NW[Q09^b/^sQ-h:Pp,\C43UG$YOrjQ/3j7&WhR
`[9]Aen*iP4'3TkQrNN&O4T]AG%!"O?j&>C3.\*?u10Rd0)R@p+:13I!8b2!pd3$WV;$ij*G\r
O\3/QJuUY'@;<U#>KMcA[sFdbAbju*,8&u2RL%q^)8Nk(624=78L6'S27h^("&6j@2tC+6@c
^i42GmRB3HdP.GAPLgX6VPh%0[s9]A>YZch8-(V_eN`Zs58dJ1t:afiRHuuj9T!1uM0L]A^09s
SG]AX@l6CLbpkES?e3XKMuuFQJ'+_$h:RI/Qn8b!&''a;:ZYXrb&<B`sSl!p:RdVAJ;Kb0;1D
;JdlJ=4<s#&[c@[+Qh=R\=\5U6>5nDP[$;N+;jqEk$;0?Fs&R6dBR%./?u-ss_)CkuW?*^6@
*m-d5s4?;AL5Lq6Pc*0d<rHnjq`i/hMP=\r9PIZ^XYCpZt1Nr`g^6Q(Lk^@6=luDPOmuG#?9
dpf/hbcV_b]AHkB*%:/Is/=/nB>M5W%YW;4n.qkf$+sT&s,N,.rl8H.ZO]A5"i.FAqY=hH?;8n
Gu4>Q8m+bq:;VC;UKG?>'c0PI"!Fg8[.;6Ho-E<r]ASo97FOY?umUH.m:Q02_i*+!FL;B=9Q`
B?6e:HP[7p8'uLla#6LpUI.BGb662UqYKEK^(fQFfL<U!!4Be#np:.a("A0dLd78WlFT:*4Y
t1STYj15U5nY95rU1`/JI_91Wj!,@4P/X(qp<f^<]AX\8&@_TSaf*?m+;6[-TnkggZa`mi+BG
D?asG-2R2n+=j!jY&nHXg3D@AXB8Wg&0Bp>o_IlL!3,\'!450o"S8l['lS)4#>&n"ORf;T>7
fC]ADcKX+\ZBpZRdq)9KT!_?m;"=F64QF'aD+s<La]A^6-"c:K'6g9dm>Uef(#0!_3/!XBi[c?
!3jNp#htkVfm,4^3Cs;^[<=r0POfLgHLaeF[#Kp-N!`A&M'U/la"+".67"^pXTHsXPt:^#nA
%8FXpF1NO!`"mA;R4CP\(k_&)N$dRc:I*5=XZ'd,:#C/=='pNQL<Iq'fT5qmNP/kKfhtBTH5
5r[R><H-9^H7@=*$\eQso?Lo,T3=>nXM/OjGZM<ZQat)>"jU83NP,Tb9EFfe8(:$8-*75f&f
SZg!<i/M'%8G3#aJLek./D9l<$hOR^,=TF>Je0d'HHcCE2i6H[>4:lrH6blXrCgH&H),;$?l
*i83PW)H.*\q9*X+%4._?0h,@8HjCff"^9"-0*'J2=>NiC?50rb%N6TVR-U,1b^lf9FbOVZc
-VL)sh*1Afk%5QoILW@XlqOS<&DOPp"2ig@lK/A/9ZLNK:cmFK6`g_OX+KlIqPL^8-JsUAR?
Ghj.qlGu&k@#M">UgI'!1se[8,5`!Dm.B)XmcM2ufVEM=hhh0_2:tC]A;&R&soqkbcGlEmRjI
:n*MkP!coKN(Urk4eu?-]Ab_[i#+aI^+1u3>`>'IkBWl38f-)@B$J4eM4hqAS&(8kj"U;')*S
\j&f[(VuWM*j*h8rDo(".BeQ]A.A6YUaJ^fl3;[I.6sVl(eK+Dg\$t;W.DMgd1V5n,"G/nbYY
Pm;g\5Y_(P@O\<IiGekfmOHsn1+!m"0<3dgsFQFm4!qW!uDMsrKJ;qp'Ti/VDf(lMd$lWi"h
_[3$f?k`ij19=<R!Ic%sXnVTnlPBle/R\]A\@9kbs+R[gGf1qX31Wt[a!6FpFqS&h]A2h1IReR
kG.@nP^NJa]A$i1E-9uTSs0uoLnRYMbcG3YKnSN8b,<5a*a`rrUiH@@HuJ#/MYp@WpMiI!G&.
'Bi*OW[f01t;>sT$R(jac&@u`=a\Q-T%ogDBNcRL!P.iBP_FOs=4Y-mper[6b$7i=0q2o8*_
!J2LB*&rSf/kk53CL5EP&Q6""T\KjHeS;E_).*_'*alb&o"0Q,eu)sa[!,HDrI*8Z9/?Q;>r
'`!GLq8M6!<Pk8H'1X!A+Z[H/(mJ%8aA:`e;iB=b^O+S@UHF@X:43%-Srrrq!F.#u;A\Y?jQ
,kDp>^tb3I2kL:)f9Q<O5sJ3@VQa5OR!i"lF#Q&M-umgA+k,;a6bgIAZnoZ2_i+JYbWe*lN+
/KueBF[omkP8Q$<@!O=B3rcF9IUAZ;*]ADLcC2$M.#&efq\RGo[W`3\>dY=/*:GUfR:Xe]A=-3
LC.)q"U9B7rr")*`QOu6ICK$*[md%8s^UO>6PrL9Mh'*VL-Q@9<'uqTmhH+r==h4VS/oeB(Z
ZU'>DQ@'9l3VHgXf-]A=gOtGr^?n#n!$OJ3U3KFLE0[^XWXK$TLZQJk1E66'[q,)L6?/$dVd1
K-Uc[2T/mue(-mBW/_=<Xm6$e$PqpC[FoJ`'/3eiQ>d'T"#Jr@I5FrjK-*q*'#J84k]A^5O0U
b`3"dpTJL_91[CPGZj@)o=dpW>?38S0_\M:J(Z1'h@kRZUPEk=:o%l#7DSj\h=`.ABug[Dl"
&Le@L4Ea+"ZpJqQ,?,XS#A/>B=$USlNG+[Smi@"Y6$j0Wg3*8XM*"&hAimF1^;XmUF9X/@go
[:U.V2)tZ\(c*G"fLcZX\NAtn.lhe#UZ8O0nJl$P1hFdJ7?7hOj9=hfcJCU$P0-1SjL]AL<I:
&pSN>QaF>-m#X"0eRAI'&cR@d:s[,KdBWL/q6;7T#_<hXgF!FZ69jcBYSr.gI.oB)g[g(bei
&LN,i+Z!p^uT;M/Y1X8)keS#SO-^%jC735Gulnh)8Y]A:L^CiFR]A7"S4`6HJN_0I"[D6*mu$Y
l;8O[X.EtM[BZ"!o8%+k]A0+J1>Fqet,ZM%$D`Uf\f<7Zm*X"$Re,)SV$VkcGm@=a4#PFj]AT&
\PF3a6GI.?A;NG+!3eW0Ni:Y>7&8.ZXV.c`@u=?\2_IJG!9T!3Cd=KNJ^Dq2;2ZR"R<9&&Q)
>D6K"JQu]Apr2HFNNeVMm[=Rg*-9.hSU9l-,N'-df(+;5.%>lIb;D&`KM9Wa;JBPR0.B(P35?
ebP[+RC)*_mAHq[*mYh>HqQBHcU[Vae_i+9/(<MBEbYQ:MNr8qr-Qt:g^O#X!KVafDSE`C3,
a;Mj1uS%HlH>7,:#P8h"o.+_+V=Lg#D3D=#;]A:\`Au@qC2D5K#(JW#BurC9_oqQK539kH$lq
niU0n:@SH5i$<d@XUg/D.Se&L.U=dnVQJ7c,PL^NU,XQu;n_"a)NFNtX9?LA\(0^uE8Q:\e&
JbPVGOY[-,ko02ge9=.jtn+h$,=/#?,k:g;Z1K.N6`nC+X\[3?t@tXrL+gRK\]A7M;9,dOP$3
k4,_CMk-$<h#->q-4?tuL.AKKio7U&b23!#r3ehrhA6CtEr:3`KaH!O_1o3;\l%*+X%p!\.Q
UHKVh//%HB@2aQre?ca06Qt>*ic07e^;\+dJ4rKDgT3cI0q2WWj]A6oe^AFbQ9)ESf12nsG1$
+FlfZ$k[T#:(DAf1@Ml<htjadjPD<FD-Z=u?Z8nM^JW;USQ(9eYk=d&1oFkhc3hYlD$>Kh*9
"\Z>S`h*-g<IDJM`j2d5I=f@b,^*+%3o5EHWDI.O%IpnKKf=nPUsEPP%/6`<PB\uOjciDC;@
TK)WcQZFD69.uJ)FRP8I+)-l5h53\?52jZ*7i$4MXF!C0dWpM4O@!-daomNc?]A.CKfB&^LW=
QZaWb&P3a$!%7jXWU2P8oYt&i?2#[ROh"%_UD)]AfXR@+pXe(*r_^Y\=dq"e[">?19%Np-%NP
hOqEY2OVAc.2@7+!_S$*DU2FpB3A%(&FOf]Aq[hS/@aC3ST_.:/(T5nSo:Oq()uEI#(E/pXm_
!Pktj_[=]AN1"4/83RiOT7:Ytb'uo64D?:5I9Ra0b_:RV5'&GmW:%R&+I0ol7]A.-Fg%FHV=1F
.gX3_rp(Usk7c"Bk3HnI@*rRN7Ueak.dJb%kdq`@/E\c^IquKD;8hIAR</uOT%LpLFRUHp:V
@IH>bBO:G2X+=?qqY/?ju.<`tbbdi.*-CHjl+PR183I<T,/WLZ_u0"0I]A'BgG+3<\9%f.T+Y
8m6mW0l,PPQVc5B)m@Y6d0,FGI%ANk#-%5uskQWS7'hok*lsW,Y)('W+F.UFqg7*p-.n`Et'
RhIV#`7KYcGt2%>>4N\)<Vr$P&D^>e+?sKRVlEa4/#K!`qN5qmFm>G%;k?(6#i9pp*uHe[@A
d1#]A!RWgB#Y#r$d-MUC%G)%HcQ="tL83J7MT66RdSId3H8McS\\<U(_7.2q=8Z'Wf#XJo;qn
0,*r.6IW_ZZhmI!Ci3N=$KQ#Wh_6t7!X`el/riHd[U"SU.?O,7@.n,%7/P*C2Ycn7@ZRddNm
!tTo:rR/oh]A"SngNHd3NRnAff*;5.]A-)+h6Ibq>N%#e/nkl@PUUUNE3B1HZtcfDFJ3)1qHA1
7a'(`D1E/FVr"s.pPW1;fW)6Xr!Ma"6`YF#@Q@;gdh-YdF!,hX;Y^Kb1J!s7;MNt+X(6/PK4
kA,__u;s0L>ODOoNXVJ8rJ93V++<mBNQR3MV[udNp,#aMhaU0aZDPnODPffdE?,/WIr%iDC:
cK]AjfCX!U"Uh?fcaU0&O;l.'oW7^`O:c&"r[e9tH%]AljZ-i<*k*AO\j_9VXkp'c=IoMi)rAJ
m_#m8(8=qn%UVhYhAn\ZTp)V4K*:KN%6Yt9"cr5(l,Oao@ac1^q!rH0>1t&!QZei%D)W4@^G
>db/E$D2fcjL[T>'`$=c(/cH@!B4]A"NuDW$^RuL<[(,3`q==L;nJDW:tEZ7q68q>)/\-RA:"
04]A)eU.uDt.GAZdl95rI+S`_k,3mRT0\j9hK06Tp,m]AKkq1"qpd.;mq[hmsXe*me9Bau.tb^
?)FJ-d4L@T!mt1FQJYN*]AXOJHUgauZ(>+b]A4YiPdeJk&egQT!9"=)t&GkEg[B)%O+lSU$%JG
!KEX03`.WO3MmusZrj%Z`1g$G:T.4$0D,)W-hkh@oo9?_/nP6Qu$p#'!=iFaU4ErPC=-n9I'
bZ=MCm80Q19%2BRr1m>n6-"ch%u?Tq:?VBK3.t,W9.18[\&%I]A]ABg(p!g.`lJl,9g4j[-X/5
]A,4KJMM'/>J5KogZ>YaOhV=UX,)CAAQE/+]Au\"GXYPl+-,mR^hntPm[a`)\Jr&=&'<=i#CHh
egN@cnP;7/B/tN[H"ZeuhFGmFA)/^r_9frjZF$gHJRhR7(H>`P+N$kuAJnsc8om5Y+G$:f9o
:O4JH0/\3KL7W]AOX<*88)"<a)8/LG9Y[a,-L('b0BID^jEc[JlHt6Zn!j[#eH2?R(Z-4(T9G
ZW92@VR]A<E=^[?lDGl=F628mb9WeP`SD\T[=/1siAL%@b/bmkK2e,AeC@JoM[-"XA^IO,/9f
[DSok=3Zo/BS*9aEOKjCg6HG0`uQ_2'8\8eKA]An$e3NNli,<1_HjRfPOb?OUqT7$c1))+8rm
*_t=E7a"UDV3)77.TDWJU@[5rhc:?X\S8koX1+Nr`.3#4m+q,`]AUMO'-NgPP?El6'CDt9L_#
<0WkT9Xko8<]A0ddPe<m!0F4]A1!g.0P$9>m1`['<ljOAqWeJ@WXDj;jG086SlL`ti3#1N8a%G
h;u\YL!#Z6CJiWE(?6drcpLL'7D0Ti#L@sWPBeW8tpeLK<(jBhrdsY,p-ce]A&AY=bc'0_Y4Q
o<1E2Z]Al/EZ0iK,KET(+^Ui;WDPSK'QTZHU=O#DkZ!4k`4*V-D>8D$"UZd,R&"UX-B=C.U=)
=Po3uJ2Y/Iah0lYrgHb!EaCjT-D3]ANG)j/JW>oA_X@kmkERu!GeVF0tNi&7:VpAKf&.TMecN
=S2c%C6-4r=NG=8LT3+A$:e1rl@.I:q2O'^lKg>e7>1<>gHg0]AQf&XY41IYWm(UmlG;]A&!(D
`#%,baISJ38A>%nW*'D]A@mC]AT2'PB?!;X8W+d\kGA!UZoIn#WtB'hamkn)d,h!N:6DH*KTE0
Nh[rS-'C[G+Zr$EVI5cCuW$]AH"8OL!#hmQ!j+KB/l-?@Cs!]A)T1]A8TgKMf[NU5Vn`8cGj]AV&
I%Jr&tffgc]Ae:&Ul/,Q0Eso4D>+pp?pdg$p.c%!C)+ZP6h\4o0ll..?Ng]An5*)Y%H%c.ElAO
<j_[2rs,-Mp:2ZA2nf,[0m=GSeYg\u3EejdW5%D?2Xt+GqF"a2>;8&m"1Ka`]Ar]A1Sl/)Xl0K
VBboNnAPK%E_p^ha]AZN;OZ_@GeL"-ch[Um._<^EJ'DQ2\5UUH75GT?7Q^cAPmMBA!_/E[ucS
<G)tjtoTKN*-RNsbLO<;Vs&0Ll+60jZkfUWE<kj8jmG/;tN8A8+MWm,3;[cRceuAl(oG]A6o/
9uP[n0%3%PhauLa>3,NoqhQ3k]A\l+_5Mlp!DbAol-4(54sYYl5Vi/G6I0l02+H_1^Yo`<k8$
kRTG(NCrA?,G4?k^,h3.oP-t\B`kmDr'ji,#8h,-@=PN.(5"b:+*g&^U?+(jLO%I%S`fF_RG
`YCY*EuHIEBk*H,^b=I[?^ZejNbJ*.(FrQ_M50^fhYM;]AGGt>+G`T)8n#^k+39Zjd1D4Hm_H
00"cCf:)q&5!/@IuDiJpj(<p^mPt,2B"4hEqt6(?p(iHMjZe;U;d1X\H941ZqNO;VItUAYHr
\D79h&1P2BGiWO.f7;9F3RR]AmXh/D:"0]AYW93Kcrdmj[_CW:"3&>&k2;]A'9oV<t*tD#Z$3l\
a:l&1M`_/Y>CYYW,d.h_60-)hc>2\i;.alil4@gIen#:Da)NZapsSY3Un]AcS7kSEVEX^TVj7
+R:KZ(l?-VYVY)2;2$GarP&5!54Y![qe'_):4ql51JB/Fs]A>EecY>.;j/Qj!+Oa$%,c8ILEB
`MQeN8`]Aob$RWSLLE$X%3:UIB'497*rtR-^lcjXM7"jG]AMU.*B3s/)P+cC+1rRc(Deaa[*&b
EBYmqI\YPBKMXDHgWO`\6mTBe@J,q"hu%5X8"=[$q;+8/s*j7c7BJ'\6W]A1Kob<%l`(,gl=7
WWR'3I9,n4^.'TcOcQ/7YIs83_<S/Y4ODsHU<5k::=_"cbr+eq>SUI.14Q>=dD$"K2Y4*U>m
_Lf"PkH>9C3S6.CY/$<l5>>qa:q9Xo4U%8BVi'_S))N^:b,H6]Aj@gV@%JrMmm=+'b<sZLP38
cSqRK*PP@PYfU!gRDpatT4C=LXq7)N2]A$@SI!8%446n!?X]Am[AuNs.l`,dMkgJZ-UBS/rG!c
NZTHcY=dO)!_E,>EZLYEIM1]AmXN^1r=2'Q[+5BE(93(Dt7002ls8EX;(LfLIa@t>:4ogm`84
eIBd$2HuX?,]ABZ/Am3@Wise^@AFp5"d[46J4HpMJI=!81"6r\^#8,Is^kPB/B>o.XXIIPXBW
R-i=#W!Trf=L@rsWC=!SXQ-VBa.AQL9?SlL:d+&'P#@]Am&/<iD*T,g1(P7lG"YI.CS;::FX,
u*Sn!"tuYet/CerojJTRIc53nlNjJR'+g>`6+T/_L!C9Z,(_S3n8H(^7DcUYCE?r;GLd?r3]A
%VrATF2_"X+C_<$#U9JE#CQ,8<\Y,`"r4ih[#Ht/9^'YbD:UBaW73)4StEkMjRiI%"k_I4"B
gjuXjMFP+'))ZMk]A(e\$Ne+tnNk9QW*Jd_jmPHVRq(#Q3SVu=HUhT3C$`&OtRMY#539(D*]A2
Xu7c=.TK]APmS$1nYON2T82:<9oS'*ZWKlC`_/-$b7R&`P^qX^?>Xrf;;nW['f<]AgSq_*U0kH
MMcX.GX=c(L9K(=s5$=nW%O#9AP:#He=574EZ3W+QDM`l8EiU%pbNa#+j]A5TRS;169#-Oghe
fTZ&ZmOL^)DtR]AqL:`,Ap:J[F]A`n]A%F=>6ghJ&h3@4OtClF9ZX\2$K_2ehB@=k/0302qf_kf
@]A1t"dKl%qhB"8^X%I%f*?e*aUb[nOse#NR6^,DrRTUg;;\erOb<1cm;H`@Ic&4g46HIdF2J
4d5"f1P'[A-jC.qCDr;i8/n!U'"GDQc1+,sg5pQ8c)k,69";k69n)\5`5noBmC9%nU8c]Aq$G
KX^f,j^E\c'U1#NRP;SB!Sm"@rCO!s?"':r8:u/sj%J:tY9ae=1([_&Z>MEkAn=K<4=3L'7'
cC%d`#b/]A&J8jT3f%lk.'@-m&%_-]A/$9W:R<Y?R%B,pCa$A2Oeii]Ap\KGaZ]A'$=JesN.qr&`
*JnXgsd.gMb)OBdeGS>7X,/Nkl9eY;=?=5M(_p)B$_-QFpX5HjmNK-s8S8=.*TktU;*srA8H
-Q!/F_l(,b8`S!o=P7-p*A+@$'X=mq&4KIdYA<[/\H<eh_:YM%B2"e\j9k.jK(BI)r$E*&>N
\a$h5qE&#_enJWr,g8i`_a/ch:ZtsenqlR96!uonB4`c(9Wi\\64pc1alZ/r_Yj.0d_jf<di
2$_5S>.lCQ3dG_Bn0^%s^f"dDZlnL5C2Ie^S&E?o$Sa.3RmMH*pD_AF)_Pg]Aq\a:Uc=`SjnO
n`g6&co!RM*CK`/J[O.GV'<mRFV0OD'.;_n\$080/n85U?XfVQj(Of82&!,dij"u0R;!$U78
03NSrki)XPbC(V*cG*?kBMHE''C3g4rlIEOkMb?qF0o>"EAi$;S1F8c^HOXp=fQaAn1JbPa6
hLG+(31P[HH#Cd:2R=%9t1L,eoP!=Zci&]A6b!=W]A#?O>VQJqRO53!ALAg;h=\i";WZh%ur@g
Co0H-UR)m?Q-5fX3Wb1@?@&>jGT_[#9[&MN#8oP!54:93In]AGK;fuSM8tl@.-(KUbkS'fX*=
*p`;7#-W"hM-AICBUB03[\f9G_j"$eM!E5"9tX!qFif&cFZ^Qd#EI>Xc>=00mG`9B5:&7i[c
ZH:#+8=h()>'hOs%=KsHoW[oZorq*ND5p&CK47h]ANmu&^1l*;hI;4eo?)/`YRO2aJS^0WZYT
e_.&gcaK50\[=o2LoLo.`eGMlZ:+c:FmQ"Yd0>uDu_WPKEaM9hc]AU,WB\(lAF<Q&(bY5\rPm
jUQrieE%nE\WIlB]AuH0=)ncQ*<tKU;)slnTEHnDlRaQ;>=#gPJgjkAbUJ$,MXAe3#^%ZVWI:
KT3u+?#E;hASNZqP`c^/5q,L,UbFs&c6b(ja53m,)]Ajn,+:<E!/OK;PCsQ7WR'O$)%Ie&h^+
)[0@et?52GXW<<jh?u&(ptFdr?*R8Zd2%c@gmNLmQY*#fH0pqHsiC^1m7.*.jQ6*X0B)bSsD
R]Ak^;)VbB!$1`CIp3h`is:6g!rA`7K%<4X!C[PDNV,r^,(Xg`drkX3B*ndFFh-0Ea7,(0"0Y
hG[@"gnf<YAHYNDj'_S:7`)g0.Wo1()d@YPLYP3_?;ECfHPB/LbAFCP4a)n&R9)+hk$5arqC
_sn%\u.d-%iYF3J/l)0)+tUm&c]A,[`9Z<Wd]AHoc1?%Y?VW\jhOY`ou=h&AFgJ+6@Ek9/@9a=
fY5[oef8XoT:VNri^>97W,#uU=[XL&k`^h-,!Cl^F4_DPD+TFt;$!K85da@>h0JVi!8*Ah`Y
DFr<#TSa0ZSLZ\9h?4m[3!skZuclW7me)]A(@CSe+rq&YnhX%F;f#_l"Doe,rlKiJ0dS&;VJn
d.,tS/#'l!OT><NO@SO3`DoTS/5ZPMKWE,1?4R(J8-kB*<[X2Pi4f?m>`dHbePj-C@ocD:q3
_(/^ZJm5*Zr&_.\d+V/a)b(Ik9g?tDMZo:qShU:cWpC(FB=`>X7!<I.0X,C'ec_'.jS,S?$j
H$([Aqo>aq15BHSk=C&lbPCu.8Ne4hZ>lhq2?l=,\ZJ&gC'<RZ?+"]AkR,2eJ(dWV=m?,V-%$
G6N&PJ8E>:f'"r.gBuFu$YnDWi`ODsFI2_g4WWpB.YF+qS)'N??8UIa-dFI$J<an$T6eo6&h
dQ%Vm+h/m"ij]A=lI<k>UDMHp%AFJDU;cuMp>%R=I8o@St[1^R4_IAT"_.Z">A644Da=_BtBG
Ec[-i5OhUZsf@VL)6<FRGX\1eQ?Z)VGJ7o4OXn1#ZD"1`N4;(E"<'kH$)QDqI1@?'Iria&Zr
uT2E/`^T(b-DZ$XuY\@kl>Xq`j<\g9!>9>lB[7n/JrsYMo)7e,YcSOa(/=Ed)F`a/q0<-`OX
ccDj6RZ.`0Fgr%t)a9rR)(ImW2"VhX(eC\")tOQ1g-2X^-4.h_C=!lT0I&<jF:R/k+SX9#mC
08i.F;%8]A]Ajtf-?nDL1ZC0=(D@aQ8:eJp?g#ip5KDl7eLo,_%Bqqh0V81B[lp_G#`$^%ZXAq
0'OT3g#palf%u(1^Dq_Tot$b8Iho0<7U1mFXHQ8ahjd5,-rd!hE+Ri$9Ye)O&GB]A_Lh`[)#"
nK]AXDkB_AYLqt0A@C+'!c:;!#Cc$K?N0H1O+2"?%OpSJ9WB2/7Z4#QO)H$?o.GJU"um4*Xq4
+;3!]A+`%s1*i@df7$i$5D,_[i8#CBBb4u_>.WhG=sdcAp2!N*r9:3Rc5.j*d+B`]As1PfO\]Am
\bqfYB^%P\R(H)P1!.Ql>^l!]Ak3[N)gc<+u6WiH5!XOSTsJrfB0kY0gq0EFccJ:$m@UYBQb4
2^9)e)FePGKE9a?P_n._=BlJF`cN(Gre@244[qEGMg=h.2gg8>NXNb\Y_^'D<^Vh[7gCVV6<
t5hT:S@c=SkuRJ$5"&$7'B,50O?IE"S\&,1IK9#L9&$S^/KBRfLV`a>r.i+lUTOCW]A8:(?gY
M\V@;2FmDn3gHIqnS;t-`MfBi`[]A'D):I+?e&><V4!HaWV*cRY^JCa"2)Q&m$q)?X##R?U:f
%D'=6m@Ja$icEHjIHQr:NI.@EDo2?p&JhB1$;D#l8)o888TMZn:nGIK=,:W!+ZmnhW7>6[0U
m@%LS\DY]AOa.M*U>DFo4HTe9N*#$)9tF77b.9k0nYh;`'";naG7dm'TqjQTA-n]ASV,ITkBnh
O+"d[B`,n`j'J1?<7#F;5UmD]A&A!.rnBaNKU&E3X>.8PZ1/^Wom_f7qiPD_U73I7l(Ktmg<1
S[bHg6+o[#I)2AL0[=kqZNZ,nU$;e3jB?%F_J8]A,W!8NHgn?HVUL;)EoiEfh#Le?RMTnq/jh
X+h'%9Uuh8BBrp50DS&O`Vk:I%D0*_G0=4:*jGCXaDje@5-mAOJ>&/cZ67:c1=PPJO%S,(=/
4QI.4DIoo#M-?%TI!4O=j-d`Ed5Vd^HLVBJUV8V$_q;=GRoKY=b"PLgqG.D6I@F_$=r!"3M2
<Ai#"S&-dcMp\UNNCb6B8bSk$H91Gag45L3IEZA!5;&u]A=D*Hs10e%Ke]AVm/c&ZOK:Zj-6Oe
d>*i[JIeY:Eoon?/trJh]AM*BCCh'l9<of&nFmUmUYW"r1fR@Nd)6$,c*N:Gqd&9K:YojFD#Y
HD+TE>o_4Oe[kH@Rs:4Mk\/eT'a)UREk;)sQ..n/(.9"[:Zs,:<jT;FUO(g%_SXA2=7DRlKW
gYDn1`<4bgQP/+Ps4^Qe:UD5(rs-#N8!K_>aj'-iW/<F9CW,HU_=*_E[HRA_)Cjt90*pjSF,
'(&MjaK)<aaW!63Vp:"![oDMrTuL]A34Q;aJ]A"fU2C'3@&BJTVOMPD]AkIeW/`s9sf\taUYs5!
n.MdB/+M.c^hCpQ3pqW[\6%Km^i\prqWrC*@Q^:8+tq!\#kf0+3Qc`b%^rrE~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="66" width="371" height="167"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="标题"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="report0" frozen="true"/>
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
<border style="0" color="-5318927" borderRadius="0" type="0" borderStyle="0"/>
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
<![CDATA[3456000,2743200,2743200,2743200,720000,720000,720000,720000,1440000,2160000,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="5" rs="4" s="0">
<O>
<![CDATA[        机务维修成本(运营)]]></O>
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
<![CDATA[运营成本=总成本-非运营成本;\\n【运营成本】飞机/发动机日常维护、大修摊销和航材保障成本;\\n【非运营成本】飞机/发动机机身折旧、客改/过渡检和航材处置成本。]]></O>
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
<![CDATA[运营成本=总成本-非运营成本;\\n【运营成本】飞机/发动机日常维护、大修摊销和航材保障成本;\\n【非运营成本】飞机/发动机机身折旧、客改/过渡检和航材处置成本。]]></O>
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
<![CDATA[运营成本=总成本-非运营成本;\\n【运营成本】飞机/发动机日常维护、大修摊销和航材保障成本;\\n【非运营成本】飞机/发动机机身折旧、客改/过渡检和航材处置成本。]]></O>
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
<![CDATA[="  统计周期：" + 统计截至.select(起始时间) + "~" + 统计截至.select(统计截至)]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" cs="7" s="6">
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
<Style horizontal_alignment="2" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
<Style horizontal_alignment="4" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="72" foreground="-15386770"/>
<Background name="ColorBackground" color="-1"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m<s7b;g5ge2SDqb/2Lct.Kn1+B4RN5EC#F48R"5eX@kV.dA^NJ<JqQVTH[$p,K39WRV5uG-$
<$_C*>2X+CqGc@RU_C,mm1p&HW(p"L9E<S9k<P*D,a2;!RN+?U+@]Ad'J+dpN`CoID0X`[ZBQ
@HiM+S2^:eNn=KTfpD8c*nR)&',B0j$idq*kFWiJ\`/'%)B>=K7a/MQimYX"TgCC5?,qm%1;
ra1rOls`S/pmD%La$4u_@Jq]A03.Fg1JGDb1jS]A%1K:Q%*4U?oZ5T@4IJa#u]A0:X-APk8P/)"
XDQN-BphiQl4T(56q]A0OjbrlL+o_=QQnht8;5HFh[hL_u7#U!tc5Y09iiV:pg;UD7Xsiq^6N
'LkSG%B2im:O\d&Sqm:rkI8S+n^bR)(>Mpb,Ck<#nlfn*prC9b2qCIi^g+%hQp_4KN;Ro6]Ad
a.$NK[+Xr!Vg%a`7&sHD-._CUk+&TM/]A+pE>+8W@#lNKer<?&,"k*E+3#4O"UH+[@1\&T_Fs
m8m5H%CbNn4-Y4;I[X0WKN55njNA%="+,o7NCQ]ATOcd%h9hX[6WdCb=;Nq6Kp1!/F%dP9g&6
pK\B@h6V??Cm9pB_K1f,F..N_'L\?hG,2\P4%uSk4XijK\l4T02k:eTreYb`+*Z_Gn,CJ;L_
/%l;IZ39KqrRN2kkj8\_?#kVscVNV(T#CPCh=\O6\>>p'IE;Hb)NCV&3LB'nfQX.<QpZ\>cj
^?h/_\O7<I',o=mPXSPo'`_3tOK@V@[qhJ31egga_C,E171*8ojIBeRnn(ZOUfkW%#H#k9CO
5UQ))e*cC_?11j8kMZoP#'dHc!U6c20UT'.R5`H1!*3A>i&ng)b%29c#aJ?M7mmfB=1e+ifI
`T2cri5MB;lEJtNFc*9%m2jim;\Wai#MB[4SK:5b)28O`%h1W=)_+829f@sEkPGJm4.nVi-Z
(4h[(%A<9\3nf8T9M*b`L:sPi-8rZ*t^kWaO+Sfnb*5s9@#QaY:AFsn$eF)^Mg)QM#6Vr6J@
Ve\"i\6c#G3MnG@gBQ2.ns0m2N4"ghqEEP@]Ab@S]A,PADc.kPZ_g4RMT9JkBJ+2Wq6Z"YK10)
=grpNNQsKDN-m:8!VJ@3P.ms75PC\sD,Ku$==7`$XOXDpSLs3Vh.YZc\GN8*\AqD#XDJ;$,o
ORG,Y9qF5=Zd+)>C=3XM.f*1*sX5VsNY.F'I0ubut^km\cI=$`up&2]AU)`bttmp372LKRrU7
FE.#NL]A^21&%+ZC>SI'aL4dr-Gm.TL:&F_QfFmem31/mp+Vdt?!OT@9:LnqOlq?sXmjW(:d.
V/2ci4I3I-Y27?"c$kt<dr,Jo#>aQhm@Gr(";4+[Fp6t41aj/<ei<.A([RudItt$>Y&Yf4I2
\td4<dM-Zj^]A5$Zj$L/&gi`f:e:?*K+QfQqu+nO94T7llgj=T>BYG%P&\mR3AgWi6o]A=Y-"a
,buY"ljmLm+MD@dS(5-QASZT9%@50`i/Fto=apjR+%_&YZ-&CNORL;@SFlXC"T;:\'9VLI&\
)=?RoWJ.--NcZK(^1AQuPf#Kd^Tph*QUE&R."!Vt"@P%@l$n:-kb&E%%H[Abp+*a[h;&;2r8
!qHW`@)]Ae65ZFqj!1'KLTYY8^i;+2ma9d7IQrBa@;=IDs[&Ct1#7k.WXRh`e-K.]A7K[g.6co
Ao*`%<kS49CtJVbZe_]A:o3"t,VS:Tcl]A?)=c#U:hTcFR*MTY8#nb(UhrB]A.2-uB-W!e9*:7N
P3R=r:*OLgb.;U)iT9UU)E`TXt>`;*@Eq[dK/&mi4K:XMqpq''CI\o0@RP8%Ou:B"f(W_`=9
X-;#OGqr:[WkKQVI8V!ph9G*t';5^Wlt`&TgS/U6SB0/1=`qWsJPp0eM>'0!MYc2D2M$C:hA
gtmm.TCrM@UNGc@;CiU>?)'5Q(9!*-6G&45f$N?a`OgTl)qS%NSteB_(E7AAQ!D3=2nLU_fO
qV/mYP.M&*4_&6*72kX[;h7f:Y8Bu<DE8l_(J*om#n!<L,Pa1XZ'&0C(c&3QOC4\epr0PH+i
)dHWnJ>*E8Z-&N[IHHc2R^&?]AYp?1o[P@_&D:(LE?do5p9oQQN6E5g-_B?E(Xc:FE\9AX@=:
_e#hlqANhaT?,ngcb(]A7c,_=*nZZt02h+D+XHTUQUVD\(I5_T36B`1AaQD85T??LVE`nKKg0
r=;M%TpMrGl!lj/FoKD*%JcWrDB%8"d>`Vd!BL2J.[>;XAb5>"\c0R+&S&:EBeM+UgJ$TtJJ
)k''e@C:]A+GapCpEXc3DnHC$kP^WQ42AH!-X>7.R02+b9k-lEWNe=T*;#>'"cKA#[l<:(D)u
JEbGe17g@,t$'@lG7@TZ[(.&hScWd2J9#U3b]Ai\X<.(?F7(SqhMq82cL%mbB"e:=':10CI'n
*de9d94Pe(CGPZW/NE13[+SJ%1jDoLj[1u]ArP'3Umhh0N7dXVprt*(^Tq2A;Ti<PO;K[[0jS
AiTrL_hB8d%VV:Ql-NMdJL-$'<>?)`fL9V4J#>cO+RIbka94?M5oVpWhCC=a"6I_*hdpNiOQ
n0tg7[[7$8Vt@:;7l0;#U`>#/^5XPZE4s\U8@8eFWle"cAVfa!S]ARt(:O/X7U<>.g!%3aW7:
i"heiDYJ+t;Hc;SV*?p&?YmkL=k`>X`.%)g<g_>rZO0)*+OHeq.?\CcGF1i.m2<QI:.O1`m6
Ja&M]A54elo=.;rU=)dtqY%$[Vib%8@X_*3j$Xp[(';Y]A[e[%=F_,QWmR[J#FNG:^LY/kF_VQ
8j0V9PWL_aDpO,HN'IoR'cu"Z6tPWBPq/-f(MS2YHJeYIgl'b8R_Jf=nK"WO1KJ0]A,O`3NY=
PWp9j;@R7R=<%,)N=]AK_4XeE?T]A[#S\aO,`>[<QAXE@NFP*mYke7OdIMjZ;")/N^S_`X$r6A
>NM,d9:%R#X^LV!*,9cR)?JB'pC;(M)f-,'lZ2eRMC/X:$5%.%)n+o*d]Al1Qj7fHC+)<"G?m
1)[QV?KJo:".-&:A^#Bp1`Tq1`9<h%#Jj?4\TKr$PgOO&,9nMIJ_.dZ*#jFhKcgpNI#kL_?)
=[4I\g_m[#O]ABm%LbPHB\7#h#T]AQa1R'5qV5H#bsto+KN$:*JLhSRWR2U]AOV>M_]AuaV7(9e8
Qr^uO7t$DB)I$t6P?(#O:M=6'X]A-Zl*@C=<1,[?qC6%bC^hZj181[`Ms6hCpRV[&aUBMGAkR
jU+?E@Pdb'<#-;ClTUEi9fKV#i)]AIcc4j]AkjOeaOF'l/ZUFL/Tu`]AO7^bOp?VD?CkG/3Cgu'
D\L0j/iT(UbI!Tn`D\t/IBK.44V2kEb\roRpVc`-RnM("ch%+SNpQ8uP^&J(;4B1:kmsO>D.
>#gfhFbh?I<;3]AL%rYf>ZXAD,!+RaWXoB\*%kG%bf,GhdC:#Z15d'HYOFo60p]AO)8;EXhBT`
efe)!0*.B[5?Ba`Q,fP7G]A_*r8SL*+#24otYR?N1\Y0'J2fMD)(7Boir8DoITLIIHm8'.#A3
g7g*AG>:==XWT;1^[.]AZ^&*(AB#u)O'!?@;WYLE^%tSuKdS7;[YT&U6]AFipBB:<uZH-2njeI
BL-eosg&9D0&bKJSGDlh(:L/+7\+0MmVpLCR\\#<`h<U3fK9E+6L>9HGbFE_(M=2B-RI=Ekd
l_h%knp8F]A&d6J*P\$'3l)[9mTs\MD@$j5UgLXe/gT9p(',8RJ%.spX.E3=1<7;B\/JtX[K<
'<(F6Kt(P!url;qHUJi2nAP]AWNPJh,c=421'Fn<;*V#do<Y<#Tlac\=Lb):\Kc?ps,!!OeHM
bM7>Qd4A`>5:8VPVKh+Ys9q\aoll%J)3q7N8!M`tqX,udD$t7\p?V72mY:nsBA827aO?X+kW
9X*;Jnat*``'=(_A"_hXX)XC]A6H+&6(Coc6#=s`jWkg4AP[@Q4^r-n,?5Qs9Hj*\:\68NgTm
#g$_[4gP#lWn\>:m%#6:fMn:^qpjX^"3;efN@R3FU$ea+1X;JV1;RF'[Igh2/>A.26#GBPF1
c*#;fQ_/S*Dd\Rp_J@=te2##A(eSW&Eg=3)+&MF.#:m1#3S.Orccm;&f[--+`O8?`!3H"d,H
nd+F!*uW"u6btI'nO&;E4,+BWaN18mMGi-qhfJ9gK\=G?/8mI^4cC3i.5Ij0N-]A;6QYPM:C(
7[*;%]A.eC=e2og`%ElcUE>0p^CLI_EVD,q,B!,+EANRM_*KeGHO:k#XX\ht<YY=a3p'4$Z>G
tp&1JNY+LmImJg@i$`)-7aF6hoL$U:kAjr*D,e$e3*C1dphI@lI)0(m1N]A)12WS)2l3Z"HR"
r[e1.k\GESsO\k!dNb\ouqCPeW;Q<5[%-:</kUOd'W4oe:pF?%6CarOobb+,!5+YuL!rE/`p
+T,\%49;lIR=\$!2tr9nLs$R7p[H#@Us;r?^-g+NVFk^NPAJ9F:Pjn7f]Ask/LD76:7FYV&GV
QFKmaA*Zp35%U@QQY1SA"c6r6jG*noT21V[LV&U=s50Worl6mdBqi1gVJs)6K'S0j]A+0&(8P
mrL)u0Vh'=.c4_'c7Kd@P.Ebnu$f!6b[=>8?(%__Po@pgs7=]A+?"A+Sfh4KW?TW;sj5X>0EC
4'cBo:MZmOjBaD&u+H,_(qh>Dr$B,ViIm0ltZ*!ak_TuE(<r8?sRrk^/q]AZ-Pb;+=c>--b%;
tpUnQQZ)NMKK]AJeSIqC86kO@U[F:Lu*(haoG1I\FNpVio#)$4<AA@81?o\5Ll,>3+3H8Ga+b
%#jlV8_CA=5=9]Ak)W"$A@$'Si/2K6k+Su80s(%8KS3W`q]AiJ]Af)*V=^kn1#e]Au=<&DPmn6K5
P?*R:jPO>'2uFk7dfMU;6'Vhs)tB$g]Af54ZP8`>J>s8`.&"p"9Pm<[A!KG6@]A:0Wk_C]AAd5Z
MQAfp"%BNlm0)HWRq1\5T`?/K1E>t`:W53Ml(-r\1MCeNSEf$?uY6a"tg%g]AN:`(h=GTBD(@
^W:kV-\D8cT(L&N>ll7p)XP:XGQ9]AFF2Zs1g(T5?bT""3pVc'l`iZ,hRZ*h]AjEEW-822I@%F
fN::o!ID4*R`Q0@V]Al`qA.43f0>-;hB(W=5AH:YWBbf7NR>iZpRb"lqrM#t"NlE@uu28Xk,l
A,I0>:9_cO@luO`DuEr!Oh&!l'W>$>YX!iO-G-/FF&hKfepBR)ffR0dc1_jo'MVT\Rt-L1MH
D>a*>4Ob#qND"2fTXVg!4;O[np4,i#O4R*C?CAcj["JlBZa:W!fa[%eerh4?%no:N^N;]AWLW
*HQE1-N>;<'/=_%ZU.(da-nk4F,8kt3gBFG0hfONTNJpY%(KRP6=8gf_K`Vt4?.DT5j\nahp
qa#=+M?fsfk>E:^TAc(>Pj8$A`kL@XuEKR!XjCU-SteriDD:`qRLH+<tcr.75.!RE19X-!pe
Sjpld$L0Hn68!*+nfWPN8bL*NS"P$.d[A(Cg8H>e283(9C-QRU.*;"dj1E.q65!eOeJ)1HWm
Vm$E3P3uVk8[IENAEbCp(n2?DiD+.S\.>Q>rI+)uB@<3ep2.8=phm4lQnL"jo$]AB1k$Y-LO%
gXgh#1nC%9YUN5jcP#UshX/_Q<9jU;MUaJ&[>]AGr+\<RqFAGA1TPhM/P$rp3"OA,=UYK\\od
35?Us4E1Y5*O-eDo:f4uIkJNJT':pnPknSO:>KH_u9E!2[EKM.l(oPeh/q.UQa1=r]AO"]At*E
gcM^,nP-<^7Fie^$5s"7sOoXUYBe_k)YK\Ko6G;:[T]AVQB]A&P"OEX!=0Hs/4pXcdD7aO.^Ji
\/HYOCaC.E=ng$"WrK@d0;'5p$VBmA+jqCQBZ%rQK*11dDZZi+7q^,>,[K]A&R`K9mZd;Xb4Z
lFFgj2@ST^i2!hU2.tgLlMG7):us_NR(qE4U?T*L;DDQ2@VfP20>U.2q2?WF"Cs<Ym,dJaA:
D"?6K+GfJWlE)UU$a&5dI]A:A114^[l#VQ2N:&):F%1X%_H1!CbGric(-[@g`_]Ab_kF"Y!F[B
r"4Rf)\gA(54>!>Eh;-dkd$2gSL_Xp+X/#g,R>[FoG_fY=O=0O`M*\!5/l]Ao(2<+u^Rd(NTW
YFPZCB`I+:^b5Y=g(bc+tP0')q0_P8<.q;P:]APkFL'kM+rml@dRc^rh-,8>G3BO!7G49]A&UM
mXjL&oB6<WX'O#AP=`M??tp4W6]A,n[?61ucg;jDPL8+*Cj_9[F"[Ff,#C$3T2,0g]A<<,G7D(
;.nrMienuBfTqpbWVh-S\>eK4H[DV[Pjl_DddmHj0#JU=jnjHDj6<gD(9fL.#7lbt`*.T)\F
LmCVlf9Yfu9E(UN'blXUK>n:]AQ'UL5@:8l83]ASF5HKG-uZI^Y.L_r<CJ&L"TVHV'sffK#Z#f
$SK7d8eoN3oYZT``<2u0P5al)AY:,1nSH.*0!Yc;J/Al8JRGua7:p2<Km_k)W9g;`aQ!BrT-
Bme80M"1F)L(9Km0d-`UpUY_X$Imc8h+CLIJ;>#O'>]APbjc,UPU&o.kOg[@;<i10iLKIr.a!
WkB@s4`S[PZ[[!l#`HqH=qdN-ciVG+>AfOXpP>74B[3\#Gs['PHOZch@LVGsM);Ahqt-QTEb
S&,I.MIBHlU;X_QWJM3ORsM\(g$`5l#`q*X^]An'O_CJ#JF!OLaT46+V(<_roHe.XXCYi*S5R
RcJF_OkfDSPdtc>oMp=OOf\ggqV_HiZ#fNm'C.pTBjYTXBeGX(i]AhK?Ve4`'W&aJ'\2:NB,n
FKXBe'G0P.f8oU=Nodq)#;lQ=P+_[*a2,EHV"0sTE^+_u6&^_6R>lCP*Lj(&]AItY=:b'd]AXp
!On9+NMW\:fQpkVhq/:bPAp9q4M:nEd#_sVIb[sG@\mRTEl\0A""\p[HFsCM?IPIr=Dt3cPE
ni:e6%J]AUDh<iWPWkr3GAI%B/9gMAFqc'ZXbIZ;k_C7!E>UP=n2#$a%CR;F@.km;Gi'W2rA_
g&PNH9L_K8IDng;/N#1XKjIQWOlZ\"*o-%e5M(P2e)4cAQ^K>[$WT`>+!.#;Gr[KA:nUHL9P
LC;^c/BMX(,fNTN1W/eLQU)SAU9:F)5Sb@sJ\DkBe7qQLWI60J92iAKaL8b4TA'EJm^HdFBs
XLTOf(h3d_%$n7u`7AFRT3^4UmUnB^LWX-I?Ca>WSGXrsEVNb[;f<kq#[+)Cc\!a4pZfkt$D
.>PrH)j;&@Ko6IR$Vo]A2I!;(SkM8q+^J-Zg9?8Fl3Fb.Q!n6>Y<J."o"*9%4&$@kShaR^_Mc
+Aa:T/U.Xo#+hOO%GlY:QZr5l=q9=cVK=4q,BonOMJo:f1jRm=5!(=7FOHfi`rd10q2;F!#m
:Rc2eK\u!]A.^M=tT'dfQlb@-Xe%I4r'Cll[UY(d:QtD&A'n4)fV"_]Ag!E<XbCSKiVkn1Xbi2
.t=(in(D[O+^mZVLMfSR;e+BZRe2UV;N(#u6'K9NC*/*gX@b)kYcUCML/8/tb'oFa=8:r,R"
c@nfjD5IFJ\(XUh'>d$c08i,.GOfV2=3ig?b(f+BBZRDkFOYRdUb=qXY9&hkt_-ZmFFcWk&c
oF^%!]AHH*r_;93qQjR5%^`KF^X9\;St9aY+jjj(:cp2[>N^$J]AJ;o^-Q6W6]AU2us&n/%_;6S
u:V<V?Wq:Q.pl(cHGA#S]A*'TV^F%'bq]AVB)+o6SH&qLS%7U]A-"[r)<a23^1mTM(O_t*ZKGTD
/K9/6,SU+:c7\bI83TC$b9W:AYqQNT8BZs-p/taS]ASmTNP2/+W98ED9Ng$n2fp6q@>aqP%^i
^q4mi7GZ(7O3W*ZRASl7im]A%OV2)(><<S\B]AZD.jUlI_SObgq"dGk=Yq6*o3#DpPkR"p?d&n
V$s5^WJIbp!9L%f]Al=MB(:"dsu.D208(mQ/oqhK-3H,K*0I6.4bc*2AAG]AM#RrQ,M/hk'I;F
&)I$M^sd=`.;s`l2-HVej+rEBA)E(qR7iW[eQa5_AkUUD>TR##DYG_OS-J@;\)iE:89V_<ee
t^b^ORqd(OUO;M*?fhq+i0XUU;ubUY=fh_FoJ9!YJi:U`6h4`U:#PI>pjN'_Yu]AgNZ(>L_ob
R!%6ToAQnoi=AN_L0-9/Gs<^9eI`Y]Al\1rW06-o5@91go;d<-r1go'8]ApYFb[Z#cac@-6]A&b
eCJ(mcH#1&d=Ee$19Df<r?*I.56j]A;V]A*m2,NX/6s&;8(oZbce:W.go[IK(<,iaI><NuouVY
N[W1()a]A`h1Iar+,GlNF4):']Af#LO)NjfA!NFfnOUNul.l?,X^(qYds#7-HfX9fWc;:7(45"
@Lqh<a(&g4V!Ff%$e6#e2BR^jTLUH<[7if7.XZbkRF<Ap[a"U,dqH(o5GI_c>b_KAG3F3o.2
7^m^g>)TiCs)"%ik$/HCpl_hRK34/OM<;#N(c0N><9^BGKJb$&>6Io2T@,f&JS$;<$hFqTH=
d81YBWtY"R&n'i1/8TCpSbtCVh=<QQTOf[:o.@Yb0LZZC4BhYu:(>?UO)":4^9,r+5<`N]AEi
^@i,`O$TcZQYo")n%t%,WrBH/1m/_@p=7o5WZ]A%k#hTM$<0rCY1!sg3%G*rXl/h!R]Ai0aJpf
X%nMc-kOBUSKL)AW^r<1%)u<+k%+tMBqT9j1?O^j+K3s"#JQ[9WUtV=H26G=K?c8AHGegE@B
>kS+7o"(Yf>Z#hD`l_8[K!l`3W?Y:TV>A#8N(aaCc#8$/_m9Lm*Y,II>a<HYsKS&r`G\P(oK
`bQR7r8GW`j5ZeM.^%'&s,??g%>p-01::=@S(L#6CkV,O","@Kc]A?07&FGE*o*nC-#?>?`h_
[c\j"3u9f@f1;&+?)AJe/OJWNT-['RMupbuPgnb:oEls]Aj6@CZSf4?Z?nmG3&&/b29u=JODD
:AJ5uPOK?M5(>_at/NHX"sJmDa>kC<$5`k=e:m6bKKE0N^?<Q&4N0><T`D37Qk/#=-V/e@Wm
l7GtUkE`lp=OcqbD(!@tEdQ(/>7;Vi[DA70]AQ<`e9EDXsVcUEpO2)o]As<k"<8_Ko^YmY4D\D
fZd4lWr+eoS+mKdHXK(*#e6MK^1;SB$"K=4u>7q5LP&Dcl5II:#s/oY)joM%?L?HW?`qVf2_
:cV-mLtU6caIT5P?ZXMR_.T`N*%X^>^fCfdk"h`FE20%M?9dNF/7Ke#=A5i&;R8fl_Bn*51i
\7/te!Gduc9Pu?:k=-aZ[)!:/%6Npu+kt94nk"_Ic27MM8c^Hj/j4m.6aP.Yq]A)`bd\G@1P9
u&KBC((>WC<Pn_0GDs]A.6HTi>.`XIX_qIeCdSZ#FEVs!aJ'7f`ZLE'*Gs)h@1&b>,sD;-E_>
H-l;^$<p7.O/_HUq5`p<Q4XUS\0ZIi8SOrpoDXdZT+M@g<@KgF`&AH5RcfBg]A)fgHk2pSuN[
A**bf^cp>B/_hD5=*WY0k(f[gbB<uW`%ll1Y6Y]ADM1@>_Ap/c1-*=546.G&l@R+E=Qq@"\We
&(?+=R"ht0)"WPKJWnbU"T#ccj*Og2O%")FoZV=P"B]Am&I25:itS-;fS)>P]ABWF%8ja`AtN<
-JidW?F;&>LM#SM_`,o>@d@jH8Za$cOidke.dTlMa1's3'9nZLAB#@n9)2+@S]A2&@WI?H"OR
gLLksqu<eo;E'[2X^VFQ*koP.m1VTj^1Iqb<IJij.!Y5pL#ZY=+^G!7Hdp_ZHk8r:p*i\O:X
:[d5/a,qg.EHL&*AnQEAQ.!IBthH/I-_2:guQYi+NHl^`0Xgocu[6&tVD\/LfaW3>BZOJX,]A
V*b$dH)P]Acc6K6W'bKN>W(*m6qUd:.B1PLV#GD2]AR`^IDdfhULDFIIT[%s?S;cEtZTGRC."O
oXWCt!WX.A<H2atJ2e4Vqa)_g.ONKS>8;//%)(VVh7GWbp8R%ZL"aM,FSQ5fF'=m(0n*A;:9
-O4^`ci+0e=#p_i6#.PgbobXO\uT_1+WBddmqhpuF++>(G\F1TQ\(Nh8iM!nPh]Aee"H8]A'Te
:hhaQ2eSZr<RTD"0dB`b_5k.spT*&'h^dX;98uNmh%-(Y)e4E.7`K'3<emjl,1J5$!F^D%Il
W[+'CsEuod<Q0D.RB`]A#e$*Q7Dm`%c.I"M.-)\dC\7sEOMk\A+Y^;gSBQ;PD7S#4(jAI(I"R
tt=n?%oGSjMo$i0HS.C.'=V>ITZ-K'A(+O(VcM.l%O!SEp!k.2a`!;ES5`FWOU=r:O/NZ-[Y
12M3.O/DK*XXO+gj>ak-eUX]A?#iYr:l.6mAfKq[p>#L]A.AUmr`)Z\FbDKihQmsLY6'8hI?C8
;[q:\jT8aAVEm,EZ79&#pYBQJR/YEe3q2A4TSHSEUW01Irn<Es,H_iKK\Yf77>XNaX\,-:F0
fYt"%ClQ6a*6ZH,N*CR]AhqtoiI[U+SH9XF7&*.8Wj<ZL-_gM'X=i'\\WD=P_i^Ym.K:1G=*s
Of.XPO'fe;,EWt[K"M]A"b@W,ls0$X:c5<SKRcna*j]AH85DS[39CIoF="cMom_lZ^jTa_a.K(
A@]A42j;OWob#ZQ:5HJD#C?JhS;<BS+c@i+BM_CoN=O7WTjY:64ZNi[B8)AhUW^QjlDmAIF*r
1"EBSrqf(6u8O/*cV+07F&Csq<h86@sj*+&^t*[YK?[63kfGLo!j%p]AZoo;IFdop5!R[Wh.<
rbB4NVt!2jrd"biOJAd(B7FYIBX,K8;*(k-kB!TgHufI%TAd_gF!=:=O[O0EioVc's12KhN*
l3pjIE'9^1^^$&YCgu>/9,#YMX4[iI>Zu+i2WJX=n)UoUj-0n58A=<ZKH;**R:H4mF:D8Nd(
oZN":5Ikq6$#I8MFf-nYO]A(CT2m#[ETfa*)CKG+[1*%ue]AYsd0XpG#fBPhQL'C,a@(pS^W>9
H4&!H6B!e8;!XH<H7t9bqC^[lBi0e/NMJa1\jc[.[QEs(/U-5A'Eu)***YS3RJ/.jl</p@Nf
!,lXBF@:@7V,dDeP-L=h4G!7=+\+HC&hZtt$<maZ6*-]A^-%&PcFIWRtG$"8=i&[f2KdqQM!!
9@Q*@EY?)5m#6-H?^(bHT,b6DVpf<(3t'0Fp4_S]AJBGspK%Vla)//Y'?$7Yl.Y_Ak18R7_s-
4?eUL=A_0)t#Qg:F)b.J3_]Ad#&=CNc'^!8%QeHnHS@X;&#(&>Fq?]A`emY"VDuCo=q.pB*no,
5NLFgajY#+tD@E;pXf8]AsL2_]AG^"FH_D/5+I1=TQ.AQiY?@_)]AJb]AeYb!eCWd,Gn!Z!U:"N"
H/>*!<#YUr`89I-pU3f4bsL`>%]A3X8qTU5"$#6VEDqOl^)@tPKc^+D[\[PXK]A<*n`=0/8)_b
30iQf',pJ"bpCgVU5PT/rL_(!:35%p6'o>DEZL3"F):1=Ko>O05KJBUigc;;siU_aG@./JcR
*OPYTiO3*N3n>SG+a=Kl73+Au*F`cLF6q,[N?qK[_hdh+9c\T?]A$`$#EF/EL7&2M>AN$bV;V
&uuBJK4^?K@(^'.1Ms@W/pD8Y#$cV`INc[dc=k,#U'co#8,fXSZ[%cX_dW)ko#]AL8?Y\K,`^
>gcZZ&F#`qG:4T]AuXqE$ln;^pf>%7O;0d,bJaALS+q,GMDoIP,-p(UGH@'l,CTK9.&"FQ#Zd
tX%f_?5Y!_*ga\)d!VS5>264$oRLY5PM;DnWD,]A&$MTs7dC9!&5uhEb<g*$qG7.ee;&tiloa
B?2-o]AF@K;P8)@7,rEYTdo-j@@YRJXoQmR==XF#HAjX-nKIV@>p%^4&iJmuVhJJMcch>N1"^
6Q1[4WFPr0km\L*8I.bg@$bD7W.0G^T2mA0bi]A\sp_9h*KqXdqifo>OE4cKeJ@cGS6`2!4m\
)gkk]A/dG!!LE^?nBR/Yg4g3C(jQYr\"^]AL@]A!<]A&37cn6)n*52ljK!#M$i>bQHd14L&()%t!
p$N_n=4&MJ6"f*@pOVjeOpcGq3;3`7U'JnE-2&U.jNh&!Hj]AVH>>jfWT<XDHog[CLri=;\dK
,p9gQl-AoOb#-Q`o\N-$.l/61GM@m6^k?T<b3NA*B"_o4f"\)WBj;?`Gisc2__ckJo91l!6i
kn+1RQn;Ar;&ApHL"F;$J9E3f@>diMPF6*nQWFuIlB,nDa+[&c2[@^&2gER>?L]Ah^U[Ws57R
=(+6*%A-qg:9g0OK"o<1[2X6+C&ukNKDgP\+PeXuY7,SA%=3'9rbqZG]ADdMLR>lljQ=.W:P[
LssUnVlM!1=J)US5G%1El6G-^KRH#WD)tm$uT_0Prq=HKBF:C6(RCPll`8Mb"pJ7]AYHJ(-_W
')8lkR0D]AB"X:QaFi5u@6AiZ6;Nu9;nGT1F%S_,#:%26$SmjWtB5l!>UY2TT``3+#5L0TiO?
;)SJMc'f_F-iqS>WEoo2[,h/@5*e_*dqT!*9]A)fL^H>h$Qjc_R4G\=Xc;q^F@PdQEd`loLIR
A.0<d;<2p&+4f,8f1ChGbZlmHuu?HarX!faCJ,R%VQ@C-Nf,qjne'V_3=U$p-/FL;4!+qZm&
6rpl3e;e!sE"p%0>tDfHT_KFG%-]A#uJJbYZNbYst1^usX8BZ>C@&tV-TNSE4]A6"#O\K"-K\(
a3Yq(,+\V6>,*qKm..MB(poQ7#0/CokMaZ*^UqE<sJmfnrpI)ZhukOk<O(&qhsZ%2!i>q_>C
$81rmU<qujQNCP)X\>o%R'K!XL>:[<A83Q:'Y1tE3SR^Inn:n-"lZ4piD&)4ITR(7B_c*'m]A
+T\`r3e!,NKRcT+g5;78gg4?91n`nZ]A86%?]A7P?om%S_)17iVBl=^gQ2eh[MUftUqFD9b8os
E@2$bipO514TFc=(hll4*Ho<4!&X\c'X?30AAq2;&Cr@&8<\)nRS.!Xq%*O1*]AN;Y/@(tiIk
A8Ya;f;5Z^<B&N6O"-AcfWD8A-)$7\GFu/L2=Z@47]Ab-&!Q\0^?sB-?JEM7;O_jUOmbEAN8:
__n,;I=fF/R8i%&Bgrg7rPU3hpsh]AH4E,qC>(`J*,.jR*,kn1\8?STmAk^_Ac7X\150shWBe
&6<=)YE$r8]AN4[hid$lQ@E46jjHSh@;4FPG3V@Qshk1ULngQkc0n/fWm;GY;Y]ALKtp"dfhuL
F/7?hB116W\Q)hLu!71OSm&S6d.R^ikamTGTMLi_ZDSnPg=tumc<DS%uq9:lH)J,%Qs?'m0!
:2J3Zs`p$UV"80GdO7sB2sCfk>G##S,)&(lnJNBrS&a1XA@pbjT;43iI)R/PE#7k\@^7;DmY
0l5W&SG(VDiPH+D0BR`a1P3sZM1n\u%@?b"j8[FrR&ksX!0l^hH$t^:hSi[b4$7]A7!iX9OIm
B>eKY+V6kA`gRL3'8=@./8\R.na-c?_ES[;DY+#\\C%^bqWP1Y@uBJ=bXg+2a*^Sg;(Dh3W"
![i9*=e-\OHZ5,!4bMMN.$^K^oWo>Qg"<dd\P$-G:`F6#=d<l'reV"J"G'("H_#46C;C29j.
HZpg1@.8Q!(Q:B!7`&35UM[6/Xn0,lD8l-6L+_5"8\>.2$_oW3JJ2/c\oPC0hkq9!Vc*;(EP
YU\7:R.Ng^(s;BP=J)6@gR._>!"(sF3L>GEYQpADM%APa#'O_-qVi,Q=I67s8HNDFi^dGuu@
>du2bi:=[`Y=Tm\nZa-\]Ao_plee9]AF$4C$cokAig[(LP]A-\:t"SOD(@4BdTd_q_WRMPbFp,D
S-74c^?rDIkb=UZe,F_I(tPF-/$UI.<$C`WMGO,+mD6i*e#J&fp)=01.)q4@cO[GL<e]A<#tt
\SLMmX2=)c8iNqk"E#VI\=bm^:%?.OuA>tIuW)Ta6`Eou4I!IteE2Qo::%heIfV72#L2hmaY
'Ms1ILBb34*"n?2>]AL2[9T8@^0&)?0.IuNcWu3D6oIrI9n:"qfG0d_Q=6!@Cd6e:DWSHLO&i
!UT2Hn*,!U.DaIuYVrmUe$?,s3^(id+37eg^J]AjWhm/pf&\"O^d/(r'Ib##,l`3h(_,M0Xqo
QR06Cs/kG`<SqO<9g_KD>0&V``jjQa:<T^=ZaQ(H46,,;l6pLq^Fh&ZJ1t'\L[KOSU/$?"r;
1]AN,B\L"*$0\11]A+BIh_04mfbaYj~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="371" height="66"/>
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
<BoundsAttr x="0" y="0" width="371" height="66"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="true"/>
<MobileWidgetList>
<Widget widgetName="标题"/>
<Widget widgetName="指标卡"/>
<Widget widgetName="absolute0"/>
<Widget widgetName="report3"/>
</MobileWidgetList>
<FrozenWidgets>
<Widget widgetName="标题"/>
</FrozenWidgets>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetZoomAttr compState="1"/>
<AppRelayout appRelayout="true"/>
<Size width="371" height="1299"/>
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
<TemplateCloudInfoAttrMark createTime="1628474288074"/>
</TemplateCloudInfoAttrMark>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="aa5c6a09-b688-4017-b520-e0be3f31c027"/>
</TemplateIdAttMark>
</Form>
