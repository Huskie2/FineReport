<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="ds1" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="mth"/>
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
<![CDATA[select a.年月,b.事件数量,c.万时率,d.吨公里成本目标,e.考核准点率目标,f.考核准点率,f.考核准点率年度累计 from
(
select concat('${mth}',t.月份) 年月,t.月份 from (
select
      distinct(right(period_date,2)) 月份 
from ads_sec_oe_event_survey_cm_all_mi
where period_date_year = '2019'
union all
select '全年' from dual) t
) a
left join 
(
SELECT 
      concat(period_date_year,'全年') 年月,
      '全年' 月份,
      sum(cast(ES_COUNT_CUM as signed)) 事件数量
FROM ads_sec_oe_event_survey_cm_all_mi
where es_qualative_cn in ('事故','事故征候')
  and period_date_year = '${mth}'
  and period_date = concat('${mth}',if('${mth}'<DATE_FORMAT(date_add(now(),interval -1 month),'%Y'),12,DATE_FORMAT(date_add(now(),interval -1 month),'%m')))
group by concat(period_date_year,'全年')
union all
SELECT 
      period_date 年月,
      right(period_date,2) 月份, 
      sum(cast(ES_COUNT_CUM as signed)) 事件数量
FROM ads_sec_oe_event_survey_cm_all_mi
where es_qualative_cn in ('事故','事故征候')
  and period_date_year = '${mth}'
group by period_date,right(period_date,2)
) b on a.年月 = b.年月
left join (
SELECT 
      concat(period_date_year,'全年') 年月,
      '全年' 月份,
      rate_cum 万时率
FROM ads_sec_oe_event_survey_cm_all_mi
where es_qualative_cn = '严重差错'
  and period_date_year = '${mth}'
  and period_date = concat('${mth}',if('${mth}'<DATE_FORMAT(date_add(now(),interval -1 month),'%Y'),12,DATE_FORMAT(date_add(now(),interval -1 month),'%m')))
union all
SELECT 
      period_date 年月,
      right(period_date,2) 月份, 
      rate_cum 万时率
FROM ads_sec_oe_event_survey_cm_all_mi
where es_qualative_cn = '严重差错'
  and period_date_year = '${mth}'
group by period_date,right(period_date,2)
) c on a.年月 = c.年月
left join (
SELECT 
      t.period_date 年月
     , t.period_date_year 年份
     , t.period_date_month 月份
     , t.target 吨公里成本目标
FROM diap.conf_busi_atkm_cost_tar t
where period_date_year = '${mth}'
) d on a.年月 = d.年月
left join (
SELECT 
      t.period_date 年月
     , t.period_date_year 年份
     , t.period_date_month 月份
     , t.target 考核准点率目标
FROM diap.conf_busi_otr_check_tar t
where period_date_year = '${mth}'
) e on a.年月 = e.年月
left join (
SELECT 
      concat(period_date_year,'全年') 年月,
      otr_check_year 考核准点率年度累计,
      otr_check_mth 考核准点率
FROM conf_busi_res_of_eva_ind
where period_date_year = '${mth}'
  and period_date = DATE_FORMAT(date_add(now(),interval -1 month),'%Y%m')
union all
SELECT 
      period_date 年月,
      otr_check_year 考核准点率年度累计,
      otr_check_mth 考核准点率
FROM conf_busi_res_of_eva_ind
where period_date_year = '${mth}'
) f on a.年月 = f.年月
order by case a.月份 when '全年' then 1
                     when '01' then 2
                      when '02' then 3
                       when '03' then 4
                        when '04' then 5
                         when '05' then 6
                          when '06' then 7
                           when '07' then 8
                            when '08' then 9
                             when '09' then 10
                              when '10' then 11
                               when '11' then 12
                                when '12' then 13 end
]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="数据更新时间" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select
distinct date_format(load_tm,'%Y-%m-%d') 加载时间
from ads_sec_oe_event_survey_cm_all_mi
where period_date_year >= '2021']]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="ds2" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="mth"/>
<O>
<![CDATA[]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[diapsec_noshare]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select* from(
SELECT 
      concat(left(month,4),'全年') 年月,
      '全年' 月份,
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
FROM air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}',if('${mth}'<DATE_FORMAT(date_add(now(),interval -1 month),'%Y'),12,DATE_FORMAT(date_add(now(),interval -1 month),'%m')))
group by concat(left(month,4),'全年')
union all
select 
      month 年月,
      right(month,2) 月份, 
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
from air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}',if('${mth}'<DATE_FORMAT(date_add(now(),interval -1 month),'%Y'),12,DATE_FORMAT(date_add(now(),interval -1 month),'%m')))
group by month,right(month,2)
) a
order by case a.月份 when '全年' then 1
                     when '01' then 2
                      when '02' then 3
                       when '03' then 4
                        when '04' then 5
                         when '05' then 6
                          when '06' then 7
                           when '07' then 8
                            when '08' then 9
                             when '09' then 10
                              when '10' then 11
                               when '11' then 12
                                when '12' then 13 end
]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="ds3" class="com.fr.data.impl.DBTableData">
<Parameters>
<Parameter>
<Attributes name="mth"/>
<O>
<![CDATA[]]></O>
</Parameter>
</Parameters>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[diapsec_noshare]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select* from(
SELECT 
      concat(left(month,4),'全年') 年月,
      '全年' 月份,
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
FROM air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}',if('${mth}'<DATE_FORMAT(date_add(now(),interval -1 month),'%Y'),12,DATE_FORMAT(date_add(now(),interval -1 month),'%m')))
group by concat(left(month,4),'全年')
union all
select 
      concat(left(month,4),'01') 年月,
      '01' 月份, 
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
from air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}','01')
group by concat(left(month,4),'01')
union all
select 
      concat(left(month,4),'02') 年月,
      '02' 月份, 
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
from air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}','02')
group by concat(left(month,4),'02')
union all
select 
      concat(left(month,4),'03') 年月,
      '03' 月份, 
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
from air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}','03')
group by concat(left(month,4),'03')
union all
select 
      concat(left(month,4),'04') 年月,
      '04' 月份, 
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
from air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}','04')
group by concat(left(month,4),'04')
union all
select 
      concat(left(month,4),'05') 年月,
      '05' 月份, 
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
from air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}','05')
group by concat(left(month,4),'05')
union all
select 
      concat(left(month,4),'06') 年月,
      '06' 月份, 
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
from air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}','06')
group by concat(left(month,4),'06')
union all
select 
      concat(left(month,4),'07') 年月,
      '07' 月份, 
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
from air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}','07')
group by concat(left(month,4),'07')
union all
select 
      concat(left(month,4),'08') 年月,
      '08' 月份, 
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
from air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}','08')
group by concat(left(month,4),'08')
union all
select 
      concat(left(month,4),'09') 年月,
      '09' 月份, 
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
from air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}','09')
group by concat(left(month,4),'09')
union all
select 
      concat(left(month,4),'10') 年月,
      '10' 月份, 
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
from air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}','10')
group by concat(left(month,4),'10')
union all
select 
      concat(left(month,4),'11') 年月,
      '11' 月份, 
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
from air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}','11')
group by concat(left(month,4),'11')
union all
select 
      concat(left(month,4),'12') 年月,
      '12' 月份, 
      sum(target_t_km*nofuel_tar_t_km_amt)/sum(target_t_km) 年度累计吨公里成本
from air_abc_fact_kh_zb
where left(month,4) = '${mth}'
  and month <= concat('${mth}','12')
group by concat(left(month,4),'12')
) a
order by case a.月份 when '全年' then 1
                     when '01' then 2
                      when '02' then 3
                       when '03' then 4
                        when '04' then 5
                         when '05' then 6
                          when '06' then 7
                           when '07' then 8
                            when '08' then 9
                             when '09' then 10
                              when '10' then 11
                               when '11' then 12
                                when '12' then 13 end
]]></Query>
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
<NorthAttr/>
<North class="com.fr.form.ui.container.WParameterLayout">
<WidgetName name="para"/>
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
<Background name="ColorBackground"/>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.parameter.FormSubmitButton">
<WidgetName name="Search"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Text>
<![CDATA[查询]]></Text>
<Hotkeys>
<![CDATA[enter]]></Hotkeys>
</InnerWidget>
<BoundsAttr x="560" y="25" width="80" height="21"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.ComboBox">
<WidgetName name="mth"/>
<LabelName name="年份"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="mth" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<Dictionary class="com.fr.data.impl.CustomDictionary">
<CustomDictAttr>
<Dict key="2020" value="2020"/>
<Dict key="2021" value="2021"/>
<Dict key="2022" value="2022"/>
</CustomDictAttr>
</Dictionary>
<widgetValue>
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=format(MONTHDELTA(today(),-1),"yyyy")]]></Attributes>
</O>
</widgetValue>
</InnerWidget>
<BoundsAttr x="130" y="25" width="80" height="21"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="Labelmth"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="Labelmth" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[年份：]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="微软雅黑" style="0" size="72"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="50" y="25" width="80" height="21"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="mth"/>
<Widget widgetName="Search"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<Display display="true"/>
<DelayDisplayContent delay="true"/>
<UseParamsTemplate use="true"/>
<Position position="0"/>
<Design_Width design_width="960"/>
<NameTagModified/>
<WidgetNameTagMap/>
<ParamAttr class="com.fr.report.mobile.DefaultMobileParamStyle"/>
<ParamStyle class="com.fr.report.mobile.EmptyMobileParamStyle"/>
</North>
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
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="21"/>
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
<BoundsAttr x="0" y="539" width="375" height="21"/>
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
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="27"/>
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
<BoundsAttr x="0" y="253" width="375" height="27"/>
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
<HC F="0" T="1"/>
<FC/>
<UPFCR COLUMN="true" ROW="false"/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1676400,1296000,0,1296000,1296000,1296000,1296000,1296000,1296000,1296000,1296000,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2880000,1728000,1728000,1728000,2160000,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<O>
<![CDATA[指标名称]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O>
<![CDATA[类别]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[价值\\n维度]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[权重]]></O>
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
<C c="0" r="1" rs="3" s="1">
<O>
<![CDATA[不含油可用\\n吨公里成本]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" s="1">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" rs="3" s="1">
<O>
<![CDATA[成本]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" rs="3" s="1">
<O>
<![CDATA[40%]]></O>
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
<C c="1" r="2" s="1">
<O>
<![CDATA[月达成]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="2" s="3">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=ds2.select(年度累计吨公里成本, 年月 = E1)]]></Attributes>
</O>
<PrivilegeControl/>
<Expand dir="1" upParentDefault="false" up="E1"/>
</C>
<C c="1" r="3" s="1">
<O>
<![CDATA[年累计]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="3" s="4">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=ds3.select(年度累计吨公里成本, 年月 = E1)]]></Attributes>
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
<Expand dir="1" upParentDefault="false" up="E1"/>
</C>
<C c="0" r="4" rs="3" s="1">
<O>
<![CDATA[考核准点率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="4" s="1">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="4" rs="3" s="1">
<O>
<![CDATA[客户]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="4" rs="3" s="1">
<O>
<![CDATA[15%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="4" s="5">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="考核准点率目标"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="1" r="5" s="1">
<O>
<![CDATA[月达成]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="5" s="6">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="考核准点率"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="1" r="6" s="1">
<O>
<![CDATA[年累计]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="6" s="5">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="考核准点率年度累计"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="0" r="7" rs="2" s="1">
<O>
<![CDATA[人为原因的\\n严重差错\\n万时率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="7" s="1">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="7" rs="4" s="1">
<O>
<![CDATA[风控]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="7" rs="2" s="1">
<O>
<![CDATA[30%]]></O>
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
<![CDATA[right(E1, 2) = "全年"]]></Formula>
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
<![CDATA[right(E1, 2) != '全年']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[/]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="1" upParentDefault="false" up="E1"/>
</C>
<C c="1" r="8" s="1">
<O>
<![CDATA[年累计]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="8" s="3">
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
<C c="0" r="9" rs="2" s="1">
<O>
<![CDATA[人为原因的\\n事故/征候\\n发生值]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="9" s="1">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="9" rs="2" s="1">
<O>
<![CDATA[一票\\n否决项\t]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="9" s="2">
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
<C c="1" r="10" s="1">
<O>
<![CDATA[年累计]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="10" s="7">
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
<![CDATA[E11 > 0]]></Formula>
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
<FRFont name="微软雅黑" style="0" size="72"/>
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
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
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
<![CDATA[#0.00%]]></Format>
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
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="259"/>
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
<BoundsAttr x="0" y="280" width="375" height="259"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report0"/>
<WidgetAttr invisible="true" description="">
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
<WidgetID widgetID="68c77a97-cf6a-4e66-9c8d-494a7cb811fe"/>
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
<![CDATA[720000,1080000,720000,723900,432000,1440000,1440000,1008000,1008000,1008000,723900]]></RowHeight>
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
<C c="0" r="5" rs="2" s="3">
<O>
<![CDATA[指标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5" cs="2" s="3">
<O>
<![CDATA[成本]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5" cs="2" s="3">
<O>
<![CDATA[客户]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="5" cs="4" s="3">
<O>
<![CDATA[风控]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="6" cs="2" s="3">
<O>
<![CDATA[不含油可用\\n吨公里成本]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="6" cs="2" s="3">
<O>
<![CDATA[考核准点率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="6" cs="2" s="3">
<O>
<![CDATA[人为原因的\\n严重差错万时率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="6" cs="2" s="3">
<O>
<![CDATA[人为原因的\\n事故/征候发生值]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="7" s="4">
<O>
<![CDATA[权重占比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="7" cs="2" s="4">
<O>
<![CDATA[40%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="7" cs="2" s="4">
<O>
<![CDATA[15%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="7" cs="2" s="4">
<O>
<![CDATA[30%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="7" cs="2" s="4">
<O>
<![CDATA[一票否决项]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="8" s="5">
<O>
<![CDATA[月份]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="8" s="6">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="8" s="5">
<O>
<![CDATA[实际]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="8" s="6">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="8" s="5">
<O>
<![CDATA[实际]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="8" s="6">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="8" s="5">
<O>
<![CDATA[实际]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="8" s="6">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="8" s="5">
<O>
<![CDATA[实际]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="9" s="5">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="年月"/>
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
<C c="1" r="9" s="6">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="吨公里成本目标"/>
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
<C c="2" r="9" s="5">
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="9" s="7">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="考核准点率目标"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Result>
<![CDATA[$$$]]></Result>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0" leftParentDefault="false" left="A10"/>
</C>
<C c="4" r="9" s="8">
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="9" s="6">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[right(A10, 2) = "全年"]]></Formula>
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
<![CDATA[right(A10, 2) != '全年']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[/]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0" upParentDefault="false" up="E2"/>
</C>
<C c="6" r="9" s="9">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="万时率"/>
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
<Condition class="com.fr.data.condition.ListCondition">
<JoinCondition join="0">
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[A10 >= format(today(), "yyyyMM")]]></Formula>
</Condition>
</JoinCondition>
<JoinCondition join="0">
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[right(A10, 2) != '全年']]></Formula>
</Condition>
</JoinCondition>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0" leftParentDefault="false" left="A10"/>
</C>
<C c="7" r="9" s="6">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[right(A10, 2) = '全年']]></Formula>
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
<![CDATA[right(A10, 2) != '全年']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[/]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="8" r="9" s="5">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="事件数量"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Result>
<![CDATA[$$$]]></Result>
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
<![CDATA[A10 >= format(today(), "yyyyMM")]]></Formula>
</Condition>
</JoinCondition>
<JoinCondition join="0">
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[right(A10, 2) != "全年"]]></Formula>
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
<![CDATA[E13 > 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="微软雅黑" style="1" size="72" foreground="-65536"/>
</HighlightAction>
</Highlight>
</HighlightList>
<CellInsertPolicy/>
<Expand dir="0" leftParentDefault="false" left="A10"/>
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
<FRFont name="微软雅黑" style="0" size="72"/>
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
<Background name="ColorBackground" color="-4531745"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.0%]]></Format>
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="ColorBackground" color="-2758673"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
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
<![CDATA[m(EX'PM+MG4u3sr&CAf*"X@'p4+JLt&5#Dg;3@O28<G*j+MB$3+HVP6?k$.oP_]ASW.1rO&KS
ZQ=U]A^aPQ37?t!Kqtp";6mqK6,3Mj)EoMhXA29qu,,U/_>SqT!S1[m/>]A#SEKFb;6Z&.\*Dk
"p!m,9LCW`6rmb(C!+1/^B_A[-ZJXkZ4alhM=3n/^mFut311QhNK&+RC_nm\"j0HF'^%TL)!
Q1kDj1>LB^-2>*.J79'O[ZiScC[bCQ2HoqP4obGSGhU)KBF!hrYuH`U1CuIq]A\"CA(3$aUUr
%KWNI45mghVr+?BOE'KC8^=StR.UNsc^K2a0MejG*.'^ep'3hL3SnImKTo)<K=mMJKX,3=.N
jU@9$_PY?Sn9klq%h4]AIH<^WQ^t#uN'&$<*1_5,>,M%`r#sG3P7hY!7iV`n=+2/lZ&LBiQK(
Fl[3u%5PX`[e,3tD!]A55sL7UKWNJ\j&mboF#H_`W*&M;bO5`aI,Gl'=C3miA)#PK/l7]A@1BX
3=31sJ[2G2WMu=M'nQB9'[iDdB;Q/6R\;aZ5?-U\drioS0mHJ(VXL=5`XGhJ$nb1bFZt==KW
6YrQnc6\YfA.`u^ul%[\6PrW4q<]A/aYRTj%a_=n4e@n;Yl]AHH1SA!IPt,1cH$^HYRI'Fk[-*
Ig0i/5Uqm@^eJ)5$kg"']Ato8]A_a5kuk`9O/^6\!8KK-(kHT,jKY[CJa#LE8>;EX%D^VKBjU&
.ksr2DiA2$H0)80Slu9IjjAWjLGBiY/b\oMes0XWj(_e^JA^L=EHuc;!Ho@F]AP@C?A\1G&Y`
Gt_>uLBh8Z[oRkAl7AFHY7$_s:EHBT.1)kuQ&2R3LgsA-GD0]AWS?[-9fC9O]A:G7E\;4*hPZU
UVosMTDcr;%>8kVI+*H5^I<Qfs<E74b)Hsms^8Pa?$=*['e2LA$\UrM@8%-R<Vs^jE;Ihg;)
2\!Z2:#WK>cr3#o1Xm$_.'j&mIi;.LrK836TNL%%+]Ao3L-W[Bfc#t>MLFd)8895B_<Tjt*oE
6%?r3c[:ucb@1)PDA&CWM"hdcA4l?/Q_lC5-8A(^j1S.&ZQr)GClA9u.sRUDFan3g?l,Hh3X
:aifDH7r*TcW+iV9HMJB[iDXS5gkFjIn`,!Z-Dp&o0p#SYBCl1jW]A#M4Z3\%po)YLqmMn#Xl
3X:F6h[I[aX?rqi#MqDsY3>45#8KZ#2RhD'`bO0Y'!5a'RsHXo1]A_(o1&DLYu_AGB8MR835!
TAK+[a(o/F>XF&1l;4MO%,c@gGM!u=kit4/q+!&\+@Ao_.YW-E>4=W:!T>r)@ICTlqiTK3e>
b4.jg.WO^:AK?ZoQ-H05B5gtgW;3<:on00o2Tls1?H&?S^l>^HUU_@qBV-aaYm'\H1_#T`1/
7)q)r4]Af62ad'TWa?32RBs(ABiicImuF.*F(ms+-]Aj_Tb$H[5dR:F:l4R=0s[m3O3d?F)*j?
jt!XW,m,fXV]AejDiE)*3bN>t-PP:-]A+e!o4f\sm3akJqLN5;$IcT*A>h\;68F#Is/l$W=V]AL
JaZ_Ar$U]A/kH<lV>o!VAjIRQ5G'rg(>C%S32Xn$A4>!8Z,dT3g00r%9X51>3HS@nlD)m>MHf
N48_+IaNh?i'Dr_[oPIX78"9!?n"&esK6t(U<i`Z1:Fpf3Gj"GN@aBu,YoCcn-6M%BN)j70,
A0'D`q+o10HV:X&.eSL8)?WTD>8b-,Dip_oBbNo&fE&1i^qF?53cmL_\Zs]A=[3)'Z*>YK\JG
0ma1n^K)8NAYpQ!3g*qMJ@A`&WX!jGG]A0C/U&Yi8pp.(ti2L9)aai@]ArbA(lD*$)m.spHD6i
2JNEnZhBq=rs<on-$VpS%<HZ"QcIuNjd.@Mb!]A\+Ap]AAGE8@qc4Ot;H58XXoY`Y@,CHEP8$6
sFcFP_N<K5*el[MS#fe"<-qp(P`O(/:L!kJA1T0Yc5>TCp3#@GgM!KuJFm3MCZRXY-Ju@2D-
'?2-J=mL:Oe$ifF*.fd0P,.W*c&M@O!J\<9V7O[\(!R9?D1=(@J=KOiB_j$`UV)al$4_=I5$
<\SnItO$#^E\83W"AciTKsN=ENR>n<$$j`_(C(\(iI>'Vp*('H/f(od*uGr\g:rZ'SI`+()l
djCskl7[6Ach,YFhZ0/TpD\%7gbhGb/O2(KU=X3:2\Z'X(u%_!S>\Wl2]AP%W2?S3;S-K_,ol
pM7utP_a$1=)MuVjNmnq/E^[>j80hWkk_ppe/4$t9["dmhPM>+n4[ktVp'<LO*IV!KpZNRq6
f(5HF%3<YBN@[RQj"5).m%[CcMho6oBVGB2o=B0<-iQ#Mp[`.1SMbp<qMPr8R#6TPZ>7fb2K
"j(!.Yl[%=R.:2%bpc\OUbrP6kCbNNTBH!Ua;*R)t_f>B9^o.N"@mQ#]A5cdL\(0-TqJ2LIIe
VmD21K>3Z4VS2GOW<rQ,Je'g(P-:$#:_B(dRGq/O>4G(4!O!>c@+2DT_DW$d3\;%HcqZmWKn
q0cp&q[_^muNO1fTd*[M"%[CaR&j@AlMgQF:%<=Tmn6S8rf]Ai>23ctPWbHIB=@7aZZ0QbRtk
N(Q7Q&Y"]Ao,VMUfo`t:F0t>*AB;F96Ucq"#E9#f!"%RQX8L((\UVg!r3hY$K>Uu!'6lTW-V9
8AH=hE.p4E''XIDAG;=s)p0OZ&=+\@8dL3>No3<-SI:jDG$YB;fLq10E##S2('8Y@hRJqP87
iU5\c\%Ik6&B`0@HTh@.dFT+rTk98q(XKQVMC4ls*\:&_"*N@!UC-8MIPm2R,j4R7fZf]A[Ql
b0LrVV[=_b"YJ9Z`)cD4o"5l6#:P`$31\G@dr;^YK;t]A"irjQoDJ@R(H'^eJlb3Al%`rW2i]A
;h^Z,f?,pK7m/hkTD0c?/Rr9Q"uXKg!&=<'>##j:lPP=PTJd#;d@))*SY6E'>'UdqmCHb"gb
WAh.t_3J=N8F*?gRbO[SVfupCC=+,o?^3e,iLCct7nU(_R9/s9Qs,3?%0&aMDpG2#ES-dc)I
tVtl6Ot@qZ+i(bA"t4GNG(')XrG$,)cjlU1o\-dX=4.!$r<K[]A>2!N[025"h>E*ZiN^qdF^4
,;\d\tSdk1"kT%F+CC.r%hrK;Xar!eF?*N.kIXQ@ni<n_?a<ILR&"g9_>mFTV_\VT9"m34AW
$+[(aHLg">OsKJau\Q[4-eW=+\T=b.>Qcaqq$=eVT"6QqCsNQHgokDl&?Wf>K\mT&TJ9K(r7
bS3WK*7H6W&?m%grI'kFdfKj7e79gFOW9Vr;a7#j[LoZa>4k*`>R$!*jN9M41BbYoKo)6YmI
K$FN.i!P=:#B.Qm;c@AL"G%Gi1j&7c%Jkt8ir`fAfn2V'h0McX]A'M"b5;n\RjA;e*I?d:Co0
W;`jlO&-KF;%<Db%!>UH+^1"RSkPZW(p6p7P@Jc]APojQs2G(g6p>od(+pb]Ah7q]A>cDuirEph
SKfiK]AcW;?nT'FM[R'sfW8pF@sd).C.e9of8H+6WV^]A;Wn?Dh1I[l-jH2#cijfXDM;+#7a[U
:e5&Q@Pd]A`jqt_C4/=,6qTD^S2ic2"f"T,HL-6d=1el@!C4/^&ur@XU)TFn\UkR(O[C'JN?r
+`ZP6atA+3s&YOQJY(jED0a+3-A&?FU_4Y5.R\@aegHHhGt7O_^[(Y3(1>%BNm)AcJ92-YgG
h5\#-=i8.E+lNTf)eDpSFu68lgA-lfl\!lC=/b*?Rh+M6303Z>R[0`C;9#WOiJW+EhdF6"WA
QAK(#5`gbCHOW&G-d6=[DAYn?lOamV0U0!B=l]AS`"mtTYh3b?Dg+drE,DMm1o5<draCQ2;]A(
Q@NBF*WjO>i2H,qChVn$/'n]A$177,9;I-#Y#&('j;e$F"?]Adg^cm(qqi5+K_94P^ud8"u'(C
kO]APZ<(`$^A61VoP6O&4`ruY=<[>'53cZm"C7'm/L\G[qi!\]AhSSas^*MU1@ou3ID63Ta_$*
,CjX28k%I5lFe:DpMTE0%(rIWYb/(n,0Ab"j'mK[&FWTHmlQB)kQ`ds7O`N^1)J8o@@j0k4u
[<]An'a#*(Er\qQ?,Mg;bp?nS4S5u;irL4KI5S=)=0$orR.chfAf%TSd>)P<Mi^='Fm[B\ao(
UA!;Y#J\b4,_2Q7Q>6'+hb3,sqd5%Kn$/?/GYpe!#1JXlq;90MCX#(Cd$]AFJFN<*PEVRTh/`
*]Ad$eGdR#%0Us'*+;R<$"3i@t$WMKnhg_+6OU:('5=\aUN0"Gcl=Ha<'J<@p7`cG=!E7-QkO
B^lIjBQQ+qU-V36^#1d^1X:<-j&rudglr?Um"h-*4AF,22l7K!SrO+,2s[33?`d:Zugr:)B^
6:8a.q=IkmaNeJT"Pbo]A;N'\C!Ep'l\2d^k*@:ROXdU-lDc\W3'<[SmOk`F6bGF\0%mXHMd"
2oX1&fTJ-2!R*T:%Dud@gC=;,bWpHs-;sKfZ'"]A\-*5BO.^[30,]A^m+X9_?*mXPG]AS.9T(g[
[`Hc/C9%*edY;FFiV<6U@hrdPJNq/:2=;%\59\$QChJhtiYSI"j4d;EF6Jbf5V!D/PaZLclo
VK[EkrV-&TBC>c>'A<Y`]AQI==#kV'r-"=m@hI_bhiTe-0_?$hLG]A'DH[mcch:)p+>0^1/8-a
J$$@q)8p_Uo_SiT<"Y1W>q8p7+;W.FmVIOcb'rFqKRQ[p.A?fEYsE`#5@tlZ:UGoUl=ank2>
:!h"$%0o&O@SJI7O]AT2cg0XuQk04,dqKs$G]A]AR\6el:f5D@A$X-g#;k?lWt.Nsa0mD-I1$M%
hpt^0U8GhgO-k0o1f4F"75e4,6u0(1R5K5=I8+,%>*)1QWFaQ5efU+V+M1f!FVgVaBrLf,$I
CA*2JL4lgnS;17FK<+qN;VMAsT!<WP%;l/GgR8N:'@rH`b(;8E\utbD<d(K`HC4^$"&0+7gU
uV"Ri66?R4i6Qd1]A<f["l!,F=G+@@sQBHbS\D/_J/7bU2@:U20p-gmuS<oM8)assd9k88->b
r"?16;&mh^!h%6+5S13gf;5;N'pDdR2KPFB?npMm21o^`&>g"V\i_BlID2QH^?,^<4J:R;8i
%%.o)2c;.aPGr(LGj@(.0X]A[;CDRM@:h^$sN:kl@<E(o,cjZ2EsEaU.Ku5p6RKPK#fOQFZK^
jdm(clQpgsj1\^d81LCNS]A'!-I)0,i\3XfR\Dkp89s\ItQs+laep-DHa21p3RQ_OOqequF-r
7hDL`W[&+'%r270r5B/."S^)F>8%H,75BbH6;j7cH&5IN'V:F_6lg8NRq2;TW0>KoQhP-B>.
_]A-lJ_oV6IBh`nBW]Ao<qtJ4i*#C?HC*UefOcfG?;WeL*m2';ULbQ5*]AG)ZM[k<#?t&m-OM-K
>/l]A1JpXb5AmV'>kpNTqGa@Ffc_lt+7dtsTc[KdTiCk!<o-R2fn2+"X`t!lfY>@C@>41-18H
gKM<#NYfU+Pmpq4Q^j[m.OjW6AoH"s&?$f&R\&QWNjcDc1WO'`7s<]AcR^_k5G=qp'Zj0*7Vl
nFZiE%0j*VL*)CqVbHY]A$PqB1OQAc#rrhE_Qh4Mk9VHNKY>P^D:ZC:,WePtC*]AIOi\]A"-\V`
K=pel>(WPdXrQ$YFpriL^X0Y2a0ARIlE00DTMuJP1$.N-KTOo+$M+5+t!'-O9q`TtL>O;6<b
J)*)nEI#^.'_o66,Q:nj?co"5M4)JMh33%CALRUeM[ICO_,9:4W*a96").Rhk#tO^\r=N&h)
'@*BOi1C$UXnp#?5TKQPr"E=+gZ'*]AdmnM(pd]AE0/Z2Jo<l/B,boAQQ>Y]AD?'g81iC>sC!92
!d9hh_N=T"RSh<c\1Q![MA5Ksq4>.8,,CHXH%D7Vqe&DnFV4alFjo?LX$Q;m?EjN-Sk<\e3M
HHqCINcDtj`1n)bRSY.#aIJG3j%4&VMNSD/+lfR)Xhj$,TOifrbE[9>?dN1Fo^gZs%uj5'gV
19NIAbNZY,'`A!a\Y*iLhVjnAVF,.6f$,eFR3D*R8=H"CQ@I3%)ek]AHI9iNW@K419/6E7]AM^
$.Emi;8W@W1_A8?X`^l()eU;ZghN3gMT,6KaFp$ntc9$gX&TTkNM:l3!.49]A^BQ_P5Vcq7Sj
<Zj*0rp0)[$@5-(M-%@<i?Pthbf5jrAZeUV\tDG*M*?#C1PADnUP0brM!6T%[Fp]A!"(Mb#tb
rqR]A./PM&9.50\js*((8d]A?6@B+ak[nS'gU[*2KIQYdDsq.+jao)=P>jQ>3/\K1YX)'X??T]A
bJJe$4`d3#6K)M2C%e>!lG/;D0)joK;g=$uf[JE*Ldh0eNfHLk?*ofe;,*E1^60DXk$+%T8`
qW.RZ^]AHnV]ANL330$P[@7D*$f'ZT:cd^46"`W@&dd&,?g>!5hK_Gp%N:ZPG:ImG:ZS[-TJSj
[$VI?nFo_:$Xo_(KHoE1EN20bu8i,+_8mFD*o\PbFEdXE/g#1XmToZ0G0/UoH:g]A`J?VM]A!N
ecU8&;V&!8k<(VLrnAS(s(hTBD$2u?NjNRNtR0"?L!:15aR\p^gWQ;O`@k>]AI8_eHsBcC]A:`
JQC`-<fRBb``)\3_uVUs1ua-B*oojYaRnB7mTTZY:;%VZhO<cZtc;St:+?XFfSbkq6QYEqd0
G!PNW<f/HhZCY51.lCJlk.5fA"ef,+A'!pf:!h-K%PP'qXKi*jM/@RGbMQ/o$"2=&g^#7?"'
ih&/C=mLXm;]A<"0aO"$t&0.%\+,'K!`j.m[C3CgcJt#?'V&L'nl+7B"r1-lU0YQ@/@BlBk`S
-YDdm*bs[Zu5/.VQa&C+=d7(:8^u2-&,O83]ACOPMIRuuoO?_7HY!NVAt"+n'U5C4q/CNkMBe
OF4:Vcm&uWQ0)G1<5WS`P/-K+F^=/Er[!"^R]AL0;j+S?)D9RV[@Dk`\Q(OTm,I;Db-oiGK,h
'!!I+HMInVEnIN!m<&re?gOB[:7"06!<qVG)]AJ#s>F)Y6e+Y3AphH/!cb>S"+dXlrMYZW/Y$
KP'AjKa60Fc[e1D/IO<Re:A84@%[&-dbZ_14>R.C&0*$2Yq24#`74=G5etdreE$Z9IN8h:%<
6*9QhlKTWaX=<rKM!?8ASubKUcqlX>&H^,F%E,-m=-Y:M+Tm-(aR?X>A!&55Oe`&NF;sL^c.
Xe/X[eGJM:/3+<gkMohT'+Jm,ujsY-%;\`59;Hd2[PUh$J_4K%+";5Ym+\@(Am%,J'N)"&5b
B:Ke]A?lN5Yq,*HDE3b`*`]A^LIZiA=&bt6u:B,$X>HnheT$k7U;NSlEmJjc=#h[C/oB78FdLb
%X:[VB:0.0:,rtcsm$U5<RLI,Ro'E:Jer$fAgkSQGYj0U5R@eB3e"T`S^Su$'%1E6>+(o:5^
21Vsmlp8P8a3Z'R!"a2A_s$K[U?auh,*acQ\0PR<jaSj"c8hd:iob5lS4kAJ=4I,S_4<oIV3
q$O1I\MClWYl'Io560,"ej1+nOc.Qa!DN_ZB6M6YC4Q2fq2S?EKT#?&nF+AY-+\eUDie'/'k
uV[uWoTrCu6Nl1m_E?#HY0BDXQ"aT<=qNX8D=^N`::5r7sKn7/16Cno]A*F:8bJP4K:Em\kK1
*6Eba#.Tgm#oO'5;e@774gO4(Xr+d=[hcJfcXVu*M6Jt"X?LRq1'omb`Waf9\%uU-&C[hSNd
CWE-QV1[!A3u1YL1VHksPh1jbrn5dfr+(2j2@`tYe@R#Y>.[1i+ZQXob&K]AkKQ1\36%mcef`
AG&peE>+;CaU*aJ?'rf)r!g`PL.08cI3I_of$[Mn[u)gM`hb$h#RpT(DcaWF7@BP0oM^r,4*
L:ARDF]Ar*c^>qoN`\A!'f4Ip#.bSmGuC[6kP]A=f<fWE5R$=r/j#c0$7Pi"8JVkP*a'1VJ'aX
kqqMu_X,g@5>*If+a_&%GR$]A"88D75(p*d&fqOX`NT$^3&bg[P6p[(R8`e><#+P2E6S,8B^j
Jl.QFB;%5o-:EJKMk)6q?((s`T$,eNNm6o.iCX6`#Z(j.976CF.k="d<"c`qYdKdFp$]Acm,p
(L\ADt:@]A/d/?T)0,]AXC2t8fuuGQqSg8h9W(?3*&qD`]AfCA15O)Ze"bogIXFaKis3t9UQ1^/
$,,n6\Ktch[>4>mW?bA.9B!UR^tS#r_KblX!fTijV;g&8f_S!Cj#t]A.J'uC,bU[5IG]ANI()S
!D=TOl$%,t7l#MGn^.<PdCdWoG;C0h#/]AQF>\n`ZD_mX"FOV!5OSD5%krak.DQAp"akOBm7i
Ue\T9F2s0:o!OoE*7l<n9h8BS%!%N\%5@Z7E4Ro7#XFkpmcuqa"[<EuY(eJJ+PeGabILuE#(
8c8*Dj:m-f"mc')uWL*qJ\r[jh<&ocn9R?1k",gGrR.k-oV3c*BnE^%j9U7\5Oul"30!9l02
&:0e(lWV@3&%:H9`DoX(6uNI1C_KX+Zl_D83<Ns@^&(-loDl:tG.jTKW7"J'Hi7q`sYbLtR9
OV!jc/99NRg"iqI)>E'<6%\A#65oSRXBPIjS1oIN5@R&:4?kI$O2IL?q.Gq8]Ai1tGPasNugZ
T*A]Afu".-\LM[NID9rbhW._Gf,)Jl0cp/)fqTp&mj'&@H/Y35F$IRkp4hBl7%`WElWps<^C,
l-(s,_OJ>sB3\V*)"LfUM??0O1GF]A`.\8h>%`*i7B+=/L_nnKVXlI=#\D]ANuhYu_/*;;bYS@
Za5T0!W7k>!kU(rYR`20IP-=CF?-bVqc@%//P-f[8YRNkTrU!*cGb;2S:8ZCV@AWWcOo?/%F
e1`oqU.=m)cro&Fu:;47lt4;m]A8-f`L_Aqq1C+'A4.#P!*\k*k**kW&FT"M&mX32hYlo%(2>
fI(Y!q:(OEnmmlk$:i?)l!tE1>!0db0Y&R92,j90P)#C%0oVJ.WW!G5:,]ADERk"\[LXqE,]As
W%m2F<<KHKk\PZ-9Y#K9_u6GF;b8@[E<"Igb+Rg%_*Q$&/YT,4NM"f2t'G5#-d0H&8Ps_aoH
&?kOCt3D2_*GlG!]AQo]AH%b%8?LC;>_P*o+t$8uM&#1Gt6WNre5XOp]Ag2cl32'Qi&;(a^qa-f
n8*eK']AgB1D4YZ]A1#D41/k&uf=AmcK<WHM*p#gRh`i/o^>aJV`\//Z2.97Vj#tD*s/F!9UGn
ZMWWj68PK]AR'r1UR1EqR/++,NmX7q(2R'R+m$>q?FVqghsM)1=,\PR$Y%:Y'f,%irKi:]AG=_
.d,($(G>V;.I/I5E^(4+dqC_hc^G_\`U^MN[.q8-9N2WuF,JFLH(lT,'aB,F9l=mO^V<:NJ[
0`9_lh=%C7[+d$Q:]AW0g.Q&->>cd/J/nUQ8)Kd1ll"7`4k1dm*pI0h:6(#4d)YI[Oe;R?2C*
83S7MJ%o.XH/VB>Wc:gsT(nXDhA?^_8Lqqn"mo.Anm%Ko,:,E:\hu8!AGiT;o'P9W<r%YK!9
PTl&N)S1&@9uK#=T8:OQO:]Ak4?dDXfgn%6XPGr'MDSZ]A5Y6P2FVpWZ.9"qkXfuR8'iX;b(>h
TX]AIrWS(9XOQ@eZrmHOZp*>O"Z/'F?fG0NX999%GSMM^5([er%fBQIa_$-Yp1h7`idc;7HEf
MXsajmp50SFipDIAh/E\9-X<C851s,<@$9/j"RHug'&m']AB,k$mnTsmj@LtKbtK0&02@'\BJ
&[@,0(9&>E.rq0:ahjDtFQ"d,I+pq-qq=cgPAfRSHr'%TGGAk,RFa*6t06DS>pI41Xa80,Sn
ZA3rMO3q7h&b9HTc(lrhh_KH(N<,5D`%HF<ZMf8:5p;[:?;<cgZ_D)7'?s_<UO7Lte3XR+G]A
qtE*^EbdtP0ofWP)/"17X]AUdHbjfU.Aj8pBh=g*`>,C"R$(a@;AUZ;fXM5)j2Rl^G$;g$Y+,
O;qs^bc?<9h='I&>M+im9J4lC/Tk6m=f_k033PY1bFl'J:)KYQe8qXGSRN)BYf`m(b428.>C
Z@N$^'Jh-CS),p#LK*'^0d(dd(B@1)"@LC&g38Nr51gQ/\qB6Gg@"7p]A%<?ZU5-3IabSDIOM
2F:dirO>.HDr%iq6HD+nCUmcTj\_=e2@5'Y[T-dq\a!Bt]A?]A._r5`nASp0cLVMG1m?Z3CZti
eF$ms'C/Jbt5g7`E(ZNUR8p<(aA]AA:Z^1Bb1i.%8e.*flJiba;K2h^mNh1.U,9m;E=I#cjE'
cSC_X[UP2WsJD?BC_k\;903V35&F3)0\c5ITJuXdbNWSM%3[:cd[:i,8l.P(;6!*VKZnk!R0
AMcB5rC0?'?!lTYHjpB;[GS#Os!jd6(+/iE*R%DLf`&PRkI-l$Tl+Tk#)NJr_#gJ<lNotV\!
-UNAJ;Z9De7\*XLSWsWt)Z@XXJWZo,;Pa*H9(%@=U$.aaeG/aK)2U]ARi4J`*EnaqP0RHL[(S
U^tpCH_7]AW$.dSHd7?KXOpu*&uu-I5+j<kQig.c&?\N&"]A#$2Rtghe\\?^'>H6-J7_bW8kMg
`,403<+?&YF]AKt6YD5'a;o1_H"(V,Ch@#r!Z\#%H,'Kd'JqR]Ap%?rK=7O-+DD(AH<d7dntRj
eWH$!YW%kZ%u$cqjZT&rDntYQ6P$uQ?'?g9OWh@g?Ok(n,*E_EA=K;Z>n>X!?`&9n`"dH\&P
?r?U?1iIN63:Gb,I3.0n9d2i9T$[\C\3L-,Cp4%]Ama^WYY4]AJAfmDWO_VP9CO!`F0g/Xh:_+
ZtZ\(#q+tuNdgb*>!8+4\%(=>U9E\Z"VBHVKekqC#dRjfjT38CU@%@$Yto.B1L/0oP_\4aA-
W(-oaC_R?h/fRqiK3a`\^"Ts#[o;_gT7WP/;^_AVmA8(oo\9&qKKb:>M6l'XeYpm!hi'/=N+
g1(Uo%['MX32:Zan'g#dTb%*s6mYD:^b4OJS7fU2#]APbs.N_ffbYD)kYhA&92Ja'/hoNkQho
l5\\N-p1e[^KY(42G>D2)j;$Su9CXPu198*qJC@^M;,bG]AOH$LVYt%c9Z_&X&fd`5K&N2A*P
e("LUN?#o]A4F7NX7'D3brlmbsQh=O'$uBt8q#2CI+H>fZ#Ko&<G[9P8%d!m]A`]AQ4Od(1tMkI
W!&CG`3.L*<V^5,9KYqK5oMC_LZ>TaE+19.R8QjlY6=?]AQP0==s2GURQL'cti=M!B9o`ome\
=eR4aj>=U1KkCK0YJ"@+sYfN3HueYTsm1Vf/jjM@MMROk]A_6<49n#M19do`2+b)+aEi$EPqZ
PZ8@,on6QL6rnI*"=>a`=T?KAD$TDTB0t%\hVU!EJ2l:JXi$bt,r%.X"#jh'S1?INMZj<q$)
hYkV=Yb-)C3`1BEPHCCZaBtg.NWb;U[f!SqT(T%?!Me\;$S<jC@J:A_g8#NN%S4Ber4q?N(_
]A?L),.2847]Ag0\W,!6^RM&WR9,;O$%0=4l.5\\"R'eqr5_rEDZa7?#46UjGOIm"=!C@ru8ci
0KU+sEc;24)t^';h)=1@9\Fe)[TpU&A=u"1iK]A&uUE%*1]A!XfmS:t8:q'G%fUDXA5o,?pBQT
t^a("`<.Y"I;u_QLSI>nl^14-I+%g,tog3GDci4J80oRO(2H<41fZDlV*)"R4.X+ucsLqthH
$+_pKjp;AeOKYr##7XJ^UFBBm,MDgu8FpRnMp'KBN[&"!I@[UBmHuVAa5P!$AGgl?;_pHe3b
@Q2ce;pRXOqmD6<e;QYrCFBt\mc9W8bAli`&Bue+C5J]AcW)soTuki*gjO=T+g`[fE]A4Z^/@b
LEXmjX![>_$0_eLb[Q$;`$EGT;]A@)IVm"I'AmWpL11I^WMoUp3pdNA\<pp:?ks!QJJkdDBD;
m4>33pFn.u2(oG&d5[_15Z;o((0?kn/n("Y(R;,21?)o'/1#]A.bc;d@+R((r:X*P^pG?Kd%L
rfGP2aH4=HeRNVZ_'n,&SJWBLH</.C!\)R"&AP=4b8-14dc68tih5,#[g"M9/@5Z+bh8dQI0
Ge,<cN(MN/f6G7A$n0>$$Hm@fa-V_&tMWd2]A!BWu>In50HQY-i[Chh<-?O=)M/buCAL#Hd]A'
tOVR0IP//j/^^6`=IDuSVl1/&$O'#@D!=6S5Hd8&m\YO`D@#R@;.T5YpZLd<*e+>,80ncDjN
I<I\",$!a#hs_VZ0;E,WItf-Y:34;Ad5Vc,Vri^FWM$aY/5@i:7D.cDinqZE$;)+cfnIa=j.
pPWYeE7i><aY7s@kn3Iui_Bj0@*N\g3B:SbP2(dlGQT-]A$(q@.CKe#)F$G#b)*i0"28U$_dj
+@HStJIT,E@P1:Z>%M0;`"t:GrVKWREs@X,JdYBq=ltggduJg0B,=,D(99QZdJ_#-bPAYM#_
qReN&g"p&56(jk6%f263RRB?!(@XUYFR8Q",aW?pY-$!n]AhWM'SA<Z\Op@OL?V<[@ll_`2O/
O@P['R\N^fF.8Gl^,g'*\`cB2H6mXjGl*sA]AHBgh@m_'nFo5,Z3:gKl.lp>I)rY6-JskMeTe
ZT`-X2[+_^^1a!uj9V.HP[=PYH\c`#1jH`T:aOGN$)fX2b%A,Z;!ku!3Yn8osS)BIcg6G>9Z
&IY<(;&+E[]AJ3a.35_H(Ga(?"P=7dN0MH>peB91%1S.EM"u)hHZQ_cuM0j:)mIdAhae@iM]A6
>=T!mT4.\PI_p^-+X-9tYFqF16;'\0:8&8&M4LkD#[iR5aJZ==-kg-jO3"Z]Ad(+`-RbWNh_`
bn6T?Fa)e$q7#7/SdDouU?()U[/M1jmQQD)*f&UQjh7EjRmOa*=X47bj+pW0o,:g;9'BhC\)
H2X1cnn9L!Z69OXl6LHQ'S38=^mBBAQ&kXk&R1l?Wue)I4pohX]Ab1j/C!1lJ_dC`2%]AEk5FR
t>Y(2*@[&?k;V.qfb0WC>Boj*CIaeF(1=a.t6,2Q^ui/pLg<fg;#'k1>p/L`+\Q#=.+d(Xm0
^bt#-I/Bl*LfiWU"gU><gA#9@.%"L5;"5o9O_=f64K9I>OTs2IC@/EcWg!0SXTfT]AY*]A7<d@
7ks6qJ9"e;.@lLggHqW9CrAf<)"kD/3@f_]A,=9nB.Acm7R5LG@r`B8FXP=`->lP\s0/9aKKC
VDYWS31^_oRhbm1qX:26d6E*?9erbJOfu%"*e&QPpJk7foY18HH8cV.mTG6gN_M;'mULHNW2
&(Hni*HJ"QO'$>d['8(cbD6[e1,=/RHKiAK3fgK=d'h55kQdAA(sD>'pR(oN[q`5du"S!T%C
Z:)+sZ>mpKI:4BTSUd7M$$k9k2P[Fo"_f3PE?h6uEjnYj:j@sWj2QBfq&O5g(g05(M\CdI>I
J-_i4[AP2R$=b0\g1q(#MFg3%'j0>Hk<oLUlJ+?N&3c->i]ApccbAWd2,=KP]A<:q.s&*i/ai7
JqFQ*3Cp.U/ZLAXL.\.6Zc3fbQPf^=a2F)7u^OT51k;;H`5tP4Js`%lI>0n?DT72E-F/$NLf
iOLR0pOB:M+Yum4U[P2*CVHHpU3=T%]AZd`sCbQn0!49NlR8CQRVM8oLCp$Zgq2aP9U/>64#f
K&1RliX8emE\\K:TYl!g!8WQ9F?$J^W2\0o&9T-/sfp&(>^_2r5/\8IM]A7T2.]A)P36K9nh!(
f9<F>%Ts5OOMcPd/BZb>YdgQSO01#)_UFOLeHE_=TO=O29ak0:rQL7^^1l^N/\@kJk=,fOc*
*ImJ!rDh"Qk!L6P^ONTlYk.,:qfmV>95`A?Igc\aguotPfn9'#`[O6Ai&kpi[^=M5-_gr_(@
K\r7)G`pd795c"M#,]AV).f.c5:P+Vn_?u7$,2Ag&mC(b[MN5`t.Xge,9M:kJrIe<F/<qh-IJ
_=[hsbB%mlRpp"C^Z)G2j\$bc>M#.[bL6gGBEpt':_-\<pQ[bK<:%\FRWj<bA;nW6?@"Fi!o
%G<8Bl'<o10CU]A,#pZ;]Aua_0?a%E:^4XGqks[PL3m.+-9^%7SiH,/?6`l>V0@SY[TdM%9?;'
o#q-0Y"paTgdl[!!81q)"V30e2c'=DDBS6"TqCJoZPX-B\(f[FE0'$p3`''t#[2AB]AN]A)tQq
goV(ra<HaDak;IaVncl<p9u5d8U-Xo)Eq!c<b@;dlb0+Pen[,,Ac&<%34rp=<of#H0dEZTrL
"-s9\G*3$_=jdBU?W0,`[0,S42X4U`aAQ1\VWF@?\baRF]A<JVk+JEfM+&^6(U*j<:5<t!IQ.
m&*6Mq<Or."X2qILJ25q)D'W$M)1Cc9,WTuDa<@sB>W%s;5u/D1qDQ(jD1hjK=I%)3B6ATOl
)AOIrSb@?)oXUDs#/?pZQ,Uj:9)b*5pNd.VrftB3G:O;$H!tO_ehafQ!sT!Ot>MLhS/)c/Z$
Cjac0-g0H99Q0:d'A/)27!:/WQGGo03@e7f_2HQp55r#e,`,:g4m5P;a"%7@cjT0!X%o-MQH
/`8tlR;-`#O&$S,'h=u>/T:2k$YMgr;Z!nNaCsoi,()_Y![Uc(8s:(=m3A%3$H<7/b$qG3;:
CsZVd#G$);7=#M0_cuhQc^I#QX,jCsjAcabY]ALr%8XOZ&d-qU`:2Sr'BRDf;=BH%mE&iac1j
(Ej!.)gAWA6<2oZua"c@0/8HN+G^%H[h&[uSEWY3T]A1ccs/:'<'oG\Pff",W&/QDV[PQ-m+:
2is.nhAFGh1&L8"s='e)F1J9,2+l`#Bl"aSfMYsPR&1ro912rrDO_33EVE4`sdgVW3X"<C[[
[qqa&[4#?qtMX_S.V\m>`i("&es)KM942sjZ4h#VZ[:*>0YSCHZ%4V!I>HfQ.Q8;J%Bq7le2
ZLpW1^6)BBQ=KSh3sd-t;1%P1oJDc>hpt2'iqTNl8c<fiB6@_#\?sKKJ3_>&;n]A=%s(W(i"r
a@-(5/h%55,C'9[+?CY?oK"9h`-8HRcfu]A2]A/FqftZT]A1NR8r;#_>[#*?reH+$Ze`3AYOLLM
"9U;#IY68MC5f9[A+jRQlSN/(M\_O&0JRI785DqLIcqhk!k:I"]Apk/;!`(RjqE)PVG=Uj,u@
5X,VWXu`8[h^0sPYKK,i:^p:[S15Q[D`"!d!g./5]AH7rBCJE/<B&Q,F3]A2u5d<%4TNLBg^"5
Eps8:L:d;?.JS&GI]AKkXmo&tcX8f%s.dh6@?OI?Uo3[$'b0(>5"\CRbFTpfo(n1;p^J[fMk.
E-kYolW=Cg5UGD5?\7Phpt-!V6j:gJ"aUs<%J!?c#6q1(p)OShN+g^Ud:c&_W*#4m3bWk2#F
NI,-7feYGk<`DU\gX0^aY0+^o(-1bpP\@+;.,\&go=,Mt=57qIT_B'!bP09gS76G(_]A4G,+N
gD?9)`-dOh"<?B!!3$ZktkcT9FHg,I3#@Wi1j\'Gff=rEdrKg!c0'i`-Dkm?#*+o1h6uG9hj
i.3-LV*T>d=4AEdTNtmeIGg)QF,PF-K4\S;+0AJP-KWP;+-YCO+&1>n95>tR9@SQ9VV`>?b1
_%H!s8iCJ!cf.t>ILGHB]A[lCKZaRI[BTIriX-6#$a(HBpKg7uRBC*]ACNa/eMl"HV@!\:Vq_H
b,1Qi(r7%QWL<5jaJVGULF+Q")"F%V@9HK2%KmEbn:\f'GO^$,,]A,1!"nh;@6[P[u_U1rVjJ
FcR!6pQ+c-Ss.2(6]A=N/Ti[C.X0'k2uSYn)\[5;?sM@&<dj8rU1efZ]A4]A)fb=0:kua^OpilU
2\(r%h"19=5p-eXWVFLMA/d0!>\%5<27YL7Fhe@CtS*d-)M@O?=YMEikboFkC:7#*Uq7_e@3
.EEUipdNBg]AqY4V6Dm&RlVT)TGld^H@`%O?<f6QT>TV&L[.nNKW:N&9&k:?\]A7<Bn?64("iJ
cZ,r6.kQ3PfMZ^gUu^FLXOD7tj4U1q,G[J?C@>R5:nHB_bl#2"68-5Ai-q0!W,9iCQ8=drsU
4>GSlTV+hO/+9O6bh,E2o+qj(PRsSOm#Bms$N6U3>%`"U#%/9mW[WF%]A*uXoH08&J2ZU[BX=
E<hh#$/(G_+m%Vi3&JlI.40bnFiD,\2_<6pYeZ,F'ZpIWoLJS`2KE]A3DI>0SOks))68nd;54
Z)fr[hQ42#VfmOsHm]AGH.msMr1<7]A1!\l'mf7rT+%$d0s:^3a@u`F&.3(Y)'p:G8A]Al)s"qk
BLjf3_>#jb3Zn]AoOmrABD.F8j"g^:I2f6BTYV8Ro5ca;)=/$0#+4J(1.2T5?[LXjAN<m[1Er
R2X&Io5V;rRZ<ti'G[PsS#V*_AJ63IVPJg>`t-k@m>YFGo^8Gi/-X>`*?'*Y=X/?52hgKKN*
dqIlcB^*m5*kTD#L6aHS=\At<I"#'hnn#mZF#b%`UBRF=Z3M!<aW:PX1>=P-k5Jo$26CVT8H
PGaV28NpU,,Fe-4(<_dOc]AqrR%#;p&$\!6fGrgP&o.X]AK0uTW*:s^FZfluCIR?RcL>F%JD)L
2MkHjYEXD8`JH`DF-@e&h";@%T0Jo'rW>KL;e#i4<KE4ILo,\HBRG+'=BhIA+;jmHR#l8,i6
KJu<qsCYShMu77?*@8\*DH,S@tW,X!"fE:">UIl)1t%s2uZG=P-Vsk)L$Gm2FWJn8q<,ikF[
jM?f:(QJIP(AC;QhXg"Vq4,%TDp@\Q%hM=)jj]AL_6I4["*<gP^E1<<:$#j$i=:n=]A!hnYr(m
41udGDMFbiHntCY$9]Aq/:<&,H?2J:XAs]AL5&N:F_\Yh[1'1mNt3PqE2%!I"BF+b=d/=CS:GH
cL+C;d?A'2DWtL)+C%%klC(5-`7CAH#b"fppq0FuX-jrq%l!M_,hAVIo[6ccqfRqfhu<1VP^
+\"VRuEr$mHjqUlTJk='P&YAbb=iXmN?R".ub2`<?TAI1Q\89Qs8cE;UJh2,7%fJ*X9Z.AFV
*9\!qZpE5QAL.bi0^ui'-B_p$h2T;eWPB\ED_'UCDu<5I;UBXG>9q]AX2K@W`OuOF=2rg,T+<
XQ0;/H^C6o.>oFhD.(5o"p/tWR4E<X@$c<#=l=+Go[nkSgX)E`Qk+N?rJ'jtMTX#'1bBl\G?
PB#K1YA-=1gHuaS:.Bf@@a1r8koBO.X$LaB]ABqes:[]Ai4<,1b*@mn1Zf0J?dR>9<6`0iYr8$
#Z[>(]AH=eGY5eEPKPAV@KZ?A6\.Jbl.CTCt!FNP:X_-?t*e\mCP<<H6oM?.sl;Am>EYoL<F&
4jQ;N(/YT<i5%57F<&E4o+d(RE*)p<_*^<Y$$"lf:).I%$f<I+f0hUI)"N8-"]AsC;R9=p>m;
H)np".W2`O>gpo3/Huq0@1E_,$2D'@R\KBL*[JXgDJI*`n8)[WJ$`W\9uA^/]Al(M*Zf)Ed76
"jFRN/B6RZng3KB%sZ+<lirR]ARA2EteM/r2,;m1>bQ;<51Q8up#ZDJ,1*=q7Kci@jlB"W+_i
5$,Z[5K&CVA`@2&*gP/rA#)Um`i5t'"J+hFKJX%CZ*hT,Y]AnZ-igoT_UDgtfma@qgc@M<\/V
bj=_HAUYNI3>-muoN&ZP%ZffjA?H3t)I;PKbfp.`MnDGLN4*9)iBj0BJF8i\ALeQSEf?76&.
SG5ufTl*%eQ?UV7_e%D6rH9V&IE!N,J"1`lgS4L$?RT'@\'>01SCKu$]A6POUAg"2;PeTJ!Kc
FFCh,/m9\;?>.YU]A0#;e7F,o74!f)6FPKid.2!+d#,(rk@8rM&9[i)eGQY<?:1T\M!?)ofgV
!]AZTKhor(JYT'3'`-dB]Aq1iZ(\]A1jEh[.t3+AHFdniWZa2$om$Z>M\XA%9aXa<!e4MsfGO\F
AF*INYHl1C>1jCEUIsN?-.2>^jaq0,oQY"P83VJP`3AK8AgiX#3M4f8!4rXoorZ&5N:(XM:@
!qX\Ib*6mdh3+"_L>h=Q9@;%WnJ]A4j6"`L@K'?[u2HamcqLP;BmpgC0qcmn#=#]A`nnbY\lpg
m>ApA^cnl-NG\O8$ofQ*?cIT>c1kiFOK2sVp4;hu%/rdTm/.`&,%K5EROEXck)a04c)`$7L,
Q_d4#'?Ku"-_.MM7U6N(5j0!iO]AA;9CCYMktX6or#ZPKBbX0d&fVUp@f1pofVV8T[J7FQAc:
9hZ9I>aOK_-sWLd%koVsR/RE_HmM&nig,ZV*+BF!%0+="audNTH?_2CLIqL*h]A5@dl%a9t0E
FshY+)s.^6J12k]A#0==5BL?TEOmOHZGf_Dq?=QB8Tm'd1eZs1c+WrNjJi_VX+"f?Y1&6['h[
PVgSh;ZoNdD+.26*>5bDN$9=W7%i1d&Wd(bBQ->i3P+,EkE[/Mg<'0j;M#3U?OZk599OaJ_,
Y/1*k>6RS)jeT=VsBg0P!bFQY(cETaI&=OKlgTp.pp>FrY:62URC10!O6Am8r!gjiG>p7@d1
TOs(/MR8/K2BhAJRAO@n[*OB!R-RG_#Zm=3sst<g$?4SD6kWc77:\=U,9flnYq+Y+?1'k4OR
HBpL^o\"#1;)XRgJi.IID(E)n7@MgS(@7F@8n(`mSt`7tc#HZ!]Ao?2>2C+;e3'F@oL`aYp2Y
:qMa]A&Y`]A8"5qQHQ"mXf0!jEkemRf6@T7JH&Sr-\7:GQScId[2qGfClhU.I'`U`U,j^#?`L*
rIgRV=.VKGb:r!&;#nj`(Gg"epm*fpp5oGUE?=D3dP/5:^clkL7-mb5`t]A]AjStug/(j$3un0
n0JmjD8E4@=fEBD)3s]AeZcBN<\-oel7IJBs5feq04!'lC]A'_l[_PcJZ,oaNdnh52I4pMFu'U
K<+/C!Bf_+a.8shI'6DdFM-59E)0=qi$hD5kb<e^ML[PK[[>qA<GU\j77g2peR?d%=d>:*M'
46FqRR=Of``,d8ZJ-V_cbGS5.iAI6jeh#uiJ(rPR,pE`9`M$Hcnohu$c&reoc#jqjHV9!hqX
In/)o*.1!NB#jhk$Qge,r_RM*K1l)g4mU,#b70@%kOH+2ONpL:6*!D%b[BdlIKE8(M3_*Kfk
<cjZn0!a"qbp-UZYBhJXK']AX`RX+\!V.99fWM'%4Qg>G]AoF^i_58X52N5[,`^g\L*q\W$0&a
(5.,n[1RMLa24'>?72H8&\F>@?[:pi@VB&]ATB>Ebj3"HN-8`p5c\rop%2VURhP3j><q&#HVo
]AMK\&Rc>![7h+QW2r>GC0%3/L:NA"_&_03C#\o\^`\iah';(u7DI;BW^d%YYpQ3)k-<>4LTS
9k3JQ-UV+BR@m%6\D^]At)ZLVobE@ZLe_Y3UU(R7cut?`/jKm?r<PG78uXMRanOr\8-hZK:E:
H!)qIA&<HGCE[BfnIR0s/p%P"a^P:4$1kIq`BmbS2eLDK?JHIheBuH>bL[UV[4Q-iO>4D2VM
[<<,e@T%Hk,\#?<4(IWa1YuoZGFbJA]A$<MR$qE&dOl1r[;0FGOF=]A>T]Al!6HESNS*@PNGs-?
$=^.np(8nG7o/P(sAAYs?lbIRL(96*V0s@O^^`&,0@%7io;EH'$-igf/&DL.`+_:Y`RI^b)k
_9gR+C!i&esdun\C0UQ'V9(YM]A'/h/,p*h%Q":XD(f&\Y3i'fl-HgPVf^H!Cqs!Ae_G)IK>u
/gfU)!kC8Y.cShS&=\%J6n4[]A6KX\h8R<tVoO"+>?pd0^)5UK+^00JJ:G+`qF/5JD#q3>gV?
TknR5B;JdXY;Q\RW!#\,BX\[<+QN'PI7`Y*E2@5E!q(<_r]An9]A,5c_]AENr<?,TD+uU/l/s(%
3L4&9=r%j%@Cd]AjMJ6FIT]A`7JTd:psE$q<83<VB.MD5.fK"F$KWJCCTNS!b]A"pXDu)/KE4[R
27LO6uTTU$aaBZRdgKE84F_`kd0SqImPMs%A;lL8s18&WO!jfRQLBXS5XGX5(W^OOI6M_@Zn
0IW7^*L1HMY#L+nUmNmRCbB-"A2#h/I4[$D]ADUph*:<qP5t"W\LdiCHHBT.&TV4[R#BW'*G9
0Hc5pdL"q;VrlH";"LM1kN3+D2H3;G5#lo4hk>\6[k)Xe:UIJNi<YGs"7QcUPAJYH9-*.'Ym
C+A#7"qdN9QuL/hs'pgm__Oh4$rD/!&]A`mZ@k:8^`RMlidXE8)@,1OA*Gi:T0Z`hrmVdLfSe
cer7kQO6]AUff^)<YF?#_/60)lVfMkXL#ls$jEP8PSo!?7`]Au9ks?W_,[,@Er#:BW;DJgrVbc
Rrgg6s3fLV=V`)kNoN=KRoBBg^l^(a3[oTR?*JQ]AS>\TsI9hN%GNO@u_@*uN/ro9W8PpJ1df
6Z>mh"OrThmAg?D]AaG^5()Ji[jqm]ANAlr;>qqa&rB+4hrq%YmD?mtkYoPG>V,d$@d'K3G@_e
W)9E.<K'nE[7#3aU05G,X%@'O:2cQLp+gup]A7>t_pcnUNi,"Fh%Cs03-ZVDIoPW$<tE>-E>A
6DbL>qpt.5O&s9FAS?R;C#Q'k;+all&sZsW:GKZ.o.T=-O0eUl3?Pa/+#S'pJ*=o*<&p>4dL
"GlVffio;u<]ASrdLFi8FO`hc1kP.%`Ae8qKj=^eo82LltjoK$SepdP9^*I6_SdJah2*u\/H7
BT"gQ[\!O:V_D$U:qo5U<UX-892nIYN$%4INhgo4Ljk.Ftqqo>"iFp?=TRFRn9ut2j.N_=Nc
X2E0[:"WY5G%\'jOmbuE5UjtisV?X$Z4<TEBgGXLq<G?e\W'j?4MM8^$h8]AL&2por/E%G=[=
Oscb35O=#"'rs-C#egK,_N7Ubg>2%)`m,81g(q:Od4:/Ct!gbhTO:DEAr6#9-1Tb"=%""e7E
m#n,bEJ,>=Qh?aqEgbEbN)i2hF]A_bo:Fi_X\1XUoW-QN7N>'([Nhu5[Ms:(l=Pgf&Us'[M[]A
G\5e"?0ECbHRqD`tb9^jBYn+0FEjM11aqWuNFJ6bWLQN*-*bTJ\\dP'ZDuTr,SSnK6a)*t&#
V0X<^I,H6R#,`/m<_,DInR4(slADs\r!>lgtT!beX%t[#5:<'b+s!?<u.09d\,\UUqHP>>rH
KV3pUS8M@1BPc#XWJ=;ar`$Yi?Mpp/h:i=-+<^FcVekRYPJse)Lkp"9L^H1mAgr.P;p]At4==
'FZ8@%OmuOXI+*!)9VAI9Uco).oGEUjZ$>em1hI39%'R4_.$'ocj\RbO1M&5moqfhr]AB9G2f
pn8Ru052GG_fu+j1P(dPou0I;P4c]A^KM6!PI%)K"*2%**i<rAh$=R%0VK,c"T#V4LXZeEFJh
,`js#3XA'[p\HkJ)<<pMn>?=+U96("qXp,RY\sH3km@G]AmH:V6410j*^,Cs();fmI>dL*o%$
gA8?X0q`eL8Y3bE#IkH*Fo[0^?`kT4hC?h=-A9Vrr+FQZdr2PY[>o/N674*m0jr\g?pLYJZ[
JkZ%p%".s!XrH3oRF^T<.(<C1(F'F=0s5N53KT+m4E/c8#44]A8eP-bpXu,=Q'LN?I,4Na/h;
/1.cn(FBJ8%^Dm3h)&i3Xn.d2R9UiW,.p]Ae0m<&M`6qRlq#[\Y!*c^o_s;5SbqL9^J)f`eX`
5g+[SX<$XV9A)PCMnf6p\gt#EQ&fIVm*EEeD+dcHme<UZ!ikR5o?&XUn$Q%iJWjf@6be&H*I
>5Dde_S]AHW!6Vs7kp;#3u:TB7IVa*^\<D`EVQ$P2(Qn0)*C[Coj$fiTBmdi.9EuFtfi.Z3o_
m<pUo_$d3AY!(9r2$rIqZRW88uE2W]A/\?il@KaL2?9JRjq+"J&JX/L;Uh9a)\4+B6TQ(=KdC
bZtr+`ETll;s?!g2V1_X5NmiEJH+P3V>a@0`:.,M_;.(^riI]Aq9tI\.4EGR^QMPVSSn%GGk:
:\e!'n_a0AHW7j>PBG'>gQ;H2&MGQ*E,$j[dRH`o'"S>ElRjr$_Sc124T@nWhhBgP&\r;mP]A
bbj8@gg6^j3Mk!srB@do&T?O<VfPU3!*sr/fVY[g3,$+8f"".tVV)dZi,&gY3%+(QJu1<QhO
C/B9j3o939]A/)J&lq6kkkt?NFW7?XSD23kcF3uC@8nZCnL@tYA"X]AXn`3_Z>@f,9[rkQN:hI
J2U&r-;&f#O\LC6081L$bH@Mp@Bn8>uPCS"-&h+RQdl^"\5PQ80jEdAS)7FJ`K3=PWJ-[3$b
5^iiEdV9KQ@uC5IikWKpFd_Ert<)fZr(Kbq]A,S-k+LPL"O3,c-l<>tdP;H+23Y@SZt*3_o+b
[EXY.r$0[QX,U(\4f`sR="fY;sAq&aEE*XFK)J<"AAr5C<39UVbEUNrK"s-Y>XbXAG#qX)bA
E\ti-6Wl3@J#uH>[,iCBp^cqDhD0NjbeNXE3^Fk^mf#<kh78.>`)0GD;++IWVB6S^Kbe*u)8
`d_8>-#$qqF-'[nmVt'/`QjJ*P`i8)s^W_!GEDnGe17N*mWfgkT_TkZmMl9_a*_#l/kH(&;R
@r76T$'*ceJ>Yr`>"Y5pN*sBh%/_&KJN;K*FIk#1$Q4t#8mkfec8uZROcMXYqngS\3LhqS@2
.;V!AHr=<TlW4%oQu@a!,8ciZ/?HX%0Lb[Ui.!=9,;,6D>%'<SImp7Lcm1]AruE)"M7hGu$_9
BQ]ACbUmW#,@q]A9)K_U5uj;4,FTaW7@D`l#4u0s(gLqA"+scYdZmq@A\mD"B,Yf5AJsd`#p#e
#SDfZ1(l5bKM`@Y0`Dp3`nYl#k^GdkFGN/I"ej**2FCq@!h$:#-]A$E+5dP?LUlujmN3S]A9GZ
MC^:=&b6:)P<?QgNUT@44cu/mHYGhWK;>n,&)ca<<!f-s*P@G^YEipFDZZ7JNA8m/J?EVkKi
m:/iiU^5;2uN/"\s+?hK8r:*9.<pp$U(oY0P-kMb%L[j+kI^Gj"c&0Ib.`@X9<=NR2(p'Hmk
3S/;fM9L1VV:nZ[MmrC&gsq*`\*f_T>_OgKR;W"_dDYrR04>f!cd/mrMPY7Ki_P;$^-V2lPP
kTGib*N3tbAl9^r%ZI2^9$-fo5G5OPgo2AX`2pUg>TB.!*4]A5a;ur/;)td/J/8&7$G<X%,LC
XQ^Ys]Aq\8CYpC=&2UhsF.Jd7dQ8,M\_Uf&D]A6W307PnjMUFSN]AF]ANo16b/gTrF"?pbY&`11O
W&>VWsbLQrnd3\0LU^/-QEN&_*cB5&fWdQ$U#=6goo/JRHprp^*h.SFa&.*j`\JAF:En\fhG
*e>V<Rm'H3a2Ui%F!gXa^Pj2)se0#D3BoQNL(L+V0ON&&D9:g,.@#V\M"s(hU>7Um=N#S)Q:
Q:9<P:X&i[?6';LBeOH%WPH7iXH'HLh18P0G#Af4]Ah$]A[>rD>GNEE]A?`Zoo3pMc%%(fZ#5b\
h"XD_S2lqJUXK-R:YBZ8e&$Y?6I/HSRMEO.[@ru`l?TTML2#&VO1f46uDKpbCVcQA_8=A$iL
$Qj:e8%4FD\rT+S/2IA@ng%(4$[k52KkY[OV_GtZ-S4PYDi2&-(\*-/TlCsdqP0t<?5Xi[ap
Wl/?kK)E+'njmG5+RXp7o:91n^g$m=7BSW7*.I7Mn55;fGbKi=eJ/:gO^lK5R/[0p:]Ar:/m[
h$\Q!QA9e@oMk"j_IkPXm>>.iK'5E)Wg7&dEQ',(OT1mKY-%oIIMtFum@r.7ciT`jR3Ut/9[
?7Cp]A-.9?KR2T_B.W,1`cr/K8*J6D8SHC-mjKQ;SQ6iWo;frMQC472k4/$^[;>F+2U-r=Whh
nFY:C/R!u2M2^LQ;q,]A!!4Zd]AANWHcRq?RlSP1;oL)/\s!*Xc36#Cs!_a/m)-/&SsW=2<&5!
5(ogf4\*=H*;^]AhF*[6(e64`o@MoF!JQ66oESl&YLgQ>]A:tk,`R1*.g1-:adn2_oX5s;@E6c
QEhmNu_%,oAB$n/EJ5UJ7\,YiFsnL\$pXLK(*!46^Gh/12:&B4+7lKb;S>>'#@X'-pKbDXV$
u0W8:Ci&TDZI8eL<*ik>U%T<kAUuDoP;<Ts)L5W;0b':PlIHg6,=hT`MF?[t2K9AVW+i"Pr6
3eKAO[Z&g^d:YY(j[M49c9AMA7EK?e`h$&bVQ)o!8Jk_9k8I7Xc0n$W;[DW=hD)@\j5J25t*
uM;(d<iW3[J2<pN%[M\%a"HA*]A?[U5BTcmJXP^qJ&_]At%=T7&fI2PgD0!pE$1Cr*i),h`%PJ
XJq29YEh/9o#6+OOgh#=))13jSd*m"<FWn_p.!$7[cSpY3)W0SN@eLj,22EOOkGq6$E'7b(g
U11<Dn_nERR2uIB?K88FI6:nXHl2`qQjRd5pm-XV>7FmD@dXhj(gpBidVrD:M#79F!R-2(Jf
Uo/+t;PIp'P<hG*$lbT$1dQ^paP$[l">eUKTNqI73JVhjFl1St6D]Aa6FH3C1UIpUJ"grGrcp
i=u).3*H9h6p8B2WjmO%3mV#cRl,1g&/V&#o45:eX2"($X0_WJRe7WJ/:f-PL89O_`8GBIER
Vh(b2%\KJVPG;n0I"Ha$E=;F(#<Y&RL(/lk3WXQ,oY5`!;;UGh[(Hc?7Gl*(CKBX'e&8:W>t
']AqFdg'i?`BLO^ILP=+6UCNt(k*Zla:gO6;TKGrAYEc:#l$s\n1:G1oET)4_P[O&dI8ok(!$
n9W6Wh)(0*liY,/_W&+^0m8^N<MPnuSWM7b.4aX\[sq3kQoW6[sAd<`FLpl>+eth2@^0]AWt[
)DBm;=7(1U8NW<kkQQ]A73&C<FIRG-7d'F9m]AVd*]ATeQ("fQ*S(Em/(3m:1SI1JpPIE$Lh8Dk
bSa;b?gmq(PY?.+[>P@`hI3kq7h>.-3I&-EE=N"bJL?P[U:seJjp%D5M0&u5>-\\)U.8^i"E
=t-2a)3rCRk_-]A!SlKl\u]Am#r)hWP6=fp9G9lguF-n+=bno$Go-h;C!k'G[P`Gl8uR[Mtb*5
K2XiNs)]A(&ZJ1p_%bG6>4[O:#*BbEBhZQc&l$$3C\1kmo)?=]A@?mS&(Aj6GF@7%H*N!L`-&B
[/kj=/STYn5#CIMmH)Vf'Z^3&+a[E!a!:04%h"""o2jCkD'5A]AtDN18]Akr"U"_NF0`SoJl=e
fO9g\pIF;[^<DOiaXZkBJmq@QA5]A]A;+@o7*$:H,iL1&227k^mXl"YnO/D6eNHYq]Aua_uV7d?
7SW9BHR#;o#7j9B)3[$maFleE+jRPT43$mhF&T;1)/0,a$PK$iAYQk,JuA&fOaP>'/[:K;l)
meW?q^\Uo]Ai=Kms4W1(q6E=.6-[[r!6AnH^?r&Hf6:@.'_B6VZ',U^DAC&%#`feh2q#!+"g9
=Elq'd::c<5D"CA?Ff4#?WM">l<a~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="253"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<body class="com.fr.form.ui.ElementCaseEditor">
<WidgetName name="report0"/>
<WidgetID widgetID="68c77a97-cf6a-4e66-9c8d-494a7cb811fe"/>
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
<![CDATA[720000,1080000,720000,723900,432000,1440000,1440000,1008000,1008000,1008000,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2304000,2016000,2016000,2016000,2016000,2016000,2016000,2016000,2016000,2743200,2743200]]></ColumnWidth>
<CellElementList>
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
<C c="0" r="5" rs="2" s="3">
<O>
<![CDATA[指标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="5" cs="2" s="3">
<O>
<![CDATA[成本]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="5" cs="2" s="3">
<O>
<![CDATA[客户]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="5" cs="4" s="3">
<O>
<![CDATA[风控]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="6" cs="2" s="3">
<O>
<![CDATA[不含油可用\\n吨公里成本]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="6" cs="2" s="3">
<O>
<![CDATA[考核准点率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="6" cs="2" s="3">
<O>
<![CDATA[人为原因的\\n严重差错万时率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="6" cs="2" s="3">
<O>
<![CDATA[人为原因的\\n事故/征候发生值]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="7" s="4">
<O>
<![CDATA[权重占比]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="7" cs="2" s="4">
<O>
<![CDATA[40%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="7" cs="2" s="4">
<O>
<![CDATA[15%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="7" cs="2" s="4">
<O>
<![CDATA[30%]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="7" cs="2" s="4">
<O>
<![CDATA[一票否决项]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="8" s="5">
<O>
<![CDATA[月份]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="8" s="6">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="8" s="5">
<O>
<![CDATA[实际]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="8" s="6">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="8" s="5">
<O>
<![CDATA[实际]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="8" s="6">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="8" s="5">
<O>
<![CDATA[实际]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="7" r="8" s="6">
<O>
<![CDATA[目标]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="8" r="8" s="5">
<O>
<![CDATA[实际]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="9" s="5">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="年月"/>
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
<C c="1" r="9" s="6">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="吨公里成本目标"/>
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
<C c="2" r="9" s="5">
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="3" r="9" s="7">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="考核准点率目标"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Result>
<![CDATA[$$$]]></Result>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0" leftParentDefault="false" left="A10"/>
</C>
<C c="4" r="9" s="8">
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="5" r="9" s="6">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[right(A10, 2) = "全年"]]></Formula>
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
<![CDATA[right(A10, 2) != '全年']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[/]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0" upParentDefault="false" up="E2"/>
</C>
<C c="6" r="9" s="9">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="万时率"/>
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
<Condition class="com.fr.data.condition.ListCondition">
<JoinCondition join="0">
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[A10 >= format(today(), "yyyyMM")]]></Formula>
</Condition>
</JoinCondition>
<JoinCondition join="0">
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[right(A10, 2) != '全年']]></Formula>
</Condition>
</JoinCondition>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0" leftParentDefault="false" left="A10"/>
</C>
<C c="7" r="9" s="6">
<PrivilegeControl/>
<HighlightList>
<Highlight class="com.fr.report.cell.cellattr.highlight.DefaultHighlight">
<Name>
<![CDATA[条件属性1]]></Name>
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[right(A10, 2) = '全年']]></Formula>
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
<![CDATA[right(A10, 2) != '全年']]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.ValueHighlightAction">
<O>
<![CDATA[/]]></O>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="8" r="9" s="5">
<O t="DSColumn">
<Attributes dsName="ds1" columnName="事件数量"/>
<Condition class="com.fr.data.condition.ListCondition"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper"/>
<Result>
<![CDATA[$$$]]></Result>
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
<![CDATA[A10 >= format(today(), "yyyyMM")]]></Formula>
</Condition>
</JoinCondition>
<JoinCondition join="0">
<Condition class="com.fr.data.condition.FormulaCondition">
<Formula>
<![CDATA[right(A10, 2) != "全年"]]></Formula>
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
<![CDATA[E13 > 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.FRFontHighlightAction">
<FRFont name="微软雅黑" style="1" size="72" foreground="-65536"/>
</HighlightAction>
</Highlight>
</HighlightList>
<CellInsertPolicy/>
<Expand dir="0" leftParentDefault="false" left="A10"/>
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
<FRFont name="微软雅黑" style="0" size="72"/>
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
<Background name="ColorBackground" color="-4531745"/>
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
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.0%]]></Format>
<FRFont name="微软雅黑" style="0" size="72"/>
<Background name="ColorBackground" color="-2758673"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style imageLayout="1">
<FRFont name="SimSun" style="0" size="72"/>
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
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="253"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="report0"/>
<Widget widgetName="report2"/>
<Widget widgetName="report1"/>
<Widget widgetName="report3"/>
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
<PreviewType PreviewType="4"/>
<MobileOnlyTemplateAttrMark class="com.fr.base.iofile.attr.MobileOnlyTemplateAttrMark"/>
<StrategyConfigsAttr class="com.fr.esd.core.strategy.persistence.StrategyConfigsAttr" pluginID="com.fr.plugin.esd" plugin-version="1.5.4">
<StrategyConfigs/>
</StrategyConfigsAttr>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="1ceb7c78-59f9-4feb-b6bf-51d2e8cbb5bb"/>
</TemplateIdAttMark>
</Form>
