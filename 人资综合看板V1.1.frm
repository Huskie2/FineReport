<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
<TableData name="月度趋势比对" class="com.fr.data.impl.DBTableData">
<Parameters/>
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
left join (select distinct type_code,short_name  from air_rz_fact_kq_month a2 where a2.type_code ='全司' and a2.short_name='全司') a2
on 1 = 1) a
left join (select max(year_code) as year_code,type_code,short_name  from air_rz_fact_kq_month where type_code ='全司' group by type_code,short_name) b
on a.type_code = b.type_code
and a.short_name = b.short_name
left join air_rz_fact_kq_month c
on a.type_code = c.type_code
and a.month_code = c.month_code
and b.year_code = c.year_code
and a.short_name = c.short_name
and c.type_code ='全司'
left join air_rz_fact_kq_month d
on a.type_code = d.type_code
and a.month_code = d.month_code
and b.year_code = cast(d.year_code as SIGNED)+1
and a.short_name = d.short_name
and d.type_code ='全司'
order by cast(a.month_code as signed) asc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="部门比对" class="com.fr.data.impl.DBTableData">
<Parameters/>
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
where type_code='部门'and date_format(STR_TO_DATE(concat(time_code,'01'), '%Y%m%d'),'%Y%m')=DATE_FORMAT(date_add(now(),interval -1 month),'%Y%m')
group by time_code,rz_bm_new,short_name,rz_bm_system,rz_bm_system_sort
order by rz_bm_system_sort asc ,sum(cast(zz_rgs as signed))/sum(people_rate) desc]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="部门年度累计排名" class="com.fr.data.impl.DBTableData">
<Parameters/>
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
from air_rz_fact_kq_month
where type_code in ('部门','公司') and zz_rgs_pj_avg_rn<=5
and date_format(STR_TO_DATE(concat(time_code,'01'), '%Y%m%d'),'%Y%m')=DATE_FORMAT(date_add(now(),interval -1 month),'%Y%m')
order by cast(zz_rgs_pj_avg as signed) asc,zz_rgs_pj_avg_rn desc
limit 5]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="Embedded1" class="com.fr.data.impl.EmbeddedTableData">
<Parameters/>
<DSName>
<![CDATA[]]></DSName>
<ColumnNames>
<![CDATA[月份,,.,,人员,,.,,飞机量,,.,,人机比,,.,,目标值]]></ColumnNames>
<ColumnTypes>
<![CDATA[java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String]]></ColumnTypes>
<RowData ColumnTypes="java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.String">
<![CDATA[--j=A^b?#qcnc]A>:J<Tbs2D#1qA$sTRMg,h2Bj5aO9:('2ae&GTgUHJ#$8\sKF%_8"1LXL"J
_Z:Hj'c!!U<@r"j]AI&+$kI%TO6n7%BP-F,p7TH<fd!UZZPuLXo(O.~
]]></RowData>
</TableData>
<TableData name="月度表" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
concat(right(month,2),'月') as '月'
,t.*
from air_szh_fact_ry_rc_month t
where type_code='全司' and left(month,4)=date_format(now(),'%Y')]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="体系人员" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
concat(right(month,2),'月') as '月'
,rz_bm_system
,sum(zz_num)

from air_szh_fact_ry_rc_month
where type_code='部门' and left(month,4)=date_format(now(),'%Y')
and rz_bm_system in ('机务体系','地服体系','飞行体系')
group by concat(right(month,2),'月'),rz_bm_system 
order by sum(zz_num) desc




]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="部门表" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
t.*
from air_szh_fact_ry_rc_month t
where type_code='部门' 
and date_format(str_to_date(concat(month,'01'),'%Y%m%d'),'%Y%m')=date_format(date_add(now(),interval -1 month),'%Y%m')
order by cast(lz_num as unsigned) desc
]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="指标卡" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select 
concat(right(t.month,2),'月') as 月
,concat(left(t.month,4),'年') as 年
,t.*
,concat(round(p_reg_rate,1),':1') as 人机比

from air_szh_fact_ry_rc_month t
where type_code='全司' 
and t.month=date_format(date_add(now(),interval -1 month),'%Y%m')]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="指标-累计满足率" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select time_code
,zz_rgs_rate
from air_rz_fact_kq_month
where type_code='全司' 
and date_format(STR_TO_DATE(concat(time_code,'01'), '%Y%m%d'),'%Y%m')<=DATE_FORMAT(date_add(now(),interval -1 month),'%Y%m')
and left(time_code,4)=date_format(now(),'%Y')]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
<TableData name="参数" class="com.fr.data.impl.DBTableData">
<Parameters/>
<Attributes maxMemRowCount="-1"/>
<Connection class="com.fr.data.impl.NameDatabaseConnection">
<DatabaseName>
<![CDATA[MYSQL_共享数据平台]]></DatabaseName>
</Connection>
<Query>
<![CDATA[select distinct(t.month)
from air_szh_fact_ry_rc_month t
order by t.month desc]]></Query>
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
<Background name="ColorBackground" color="-15378022"/>
<Alpha alpha="1.0"/>
</Border>
<LCAttr vgap="0" hgap="0" compInterval="0"/>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WAbsoluteLayout">
<WidgetName name="absolute0"/>
<WidgetID widgetID="d6a94487-301c-4bee-9c03-4be94677e731"/>
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
<WidgetName name="指标-人均工时投入"/>
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
<WidgetName name="指标-人均工时投入"/>
<WidgetID widgetID="a9b555cb-fba5-417c-94bd-463ada77b43a"/>
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
<![CDATA[944880,1127760,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[396240,3352800,2651760,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=VALUE("指标卡", 1) + "人均工时投入"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="指标卡" columnName="zz_rgs_pj"/>
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
<FRFont name="微软雅黑" style="0" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00]]></Format>
<FRFont name="微软雅黑" style="1" size="176" foreground="-1197808"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G'A;cfE3g1d*Q8!p:A9$9`5CTZ@<2H[uiSTHbi<%N\WMCk.X:o/VK'G(NVan3bM/W^;Q;,
K(t7:I!1Uk5rsWD\QU,R"m8?m:786O85^P)t`Omp>YNf'[&9bs$5^`PN]A\4RmC9\aOfnn,*!
qn%&7]A&g+aD\'OtqhRn+AeuX?!ch$9^L7^End5QOG3:b1hKs,?c2_UN&k4Lr9F,uC=]AXXj`/
c-VoeQr-+s42/I%-raRHs=V$a]ADg'Lp+>-?f6DsB)MJ"Du@=g8+N61=!%3Sl@`G:b6tnhAMB
nA.[q6`[f+[kJMD#,bMY'R$,jlkWK=(nIO3./=dIn_IDS3(/8NT!rpLeZR:Q8Ip'#Y)fK@"X
LCV*u4?2\-+20aP1qi<'bC.B)IkX.@d@&_?XW48l+rjbD@D[!KZ,n55f$)pug*aB0NsYf4TF
_(uR$6cBJ9kbkrSIFQFQWaHjVm!9A.l@8;S(u?R;>GM6?*QEJ0;HB#<Vh(\q.Q*8R-t8UQO/
3/OuT)DWG@Jn<ddBVQk?3^@?Sp6VV:,DcXFA/!Kf]AF/@u[fY9+p;lG`*=/G@=YE<n93#,T"L
Yc(8\&;eh3u_qr;VqJeXI-j#(KK(6UO@@[<#KgG'kFX6B"8+=k5VZlR]A?'`VU;f*IY)4EOdC
#2s5pqgeYZ<C6)(Q%FehFb*+(?Xn*$b>AsCfO8Z]A%@7BC%CH#pRfVB+@JQ*?Is>'T-]AHIe\8
8kY8'=BF2t.ja?1]A'U<aOZ6:![62l+]AQ#/r1S8@uV=ZP>ne,c0NjjZ1b@l`m^&ML1\;J;GRo
:iu?W@K&.KamI!IK!;ZP`6RBMN03JpUhU1RPd[2iqmDXQenWR3Sf:lD;5'DTBB%CATjmO%'B
nXgY$m.Vm/\jMHjrE[=in/Enb\h-O8AI9*1S>NiJkKHm`cr5(q3L"&,"a9:2i;%oIH,>Q",-
A_N?_rGp$esJ[8b[NZYJGRp*V*>f`j=j!B=[m`SXC6)`oq=4/g=DllTS;mj\4_O8kO[<iRo:
MB<d:H\f:XiSNLl1up='\=Cd(jWS.dYc2rR.I50AY!;*/2WdMn-H2LY\n,3@\*HVS._381o*
h5DFa$li"9ANJ[\$upsb\,1(hX5p]AQ#6!id4eno+*GQtl7^B`PVG=fgN>D3rP8H<+kF$Z(),
08H^<$h8G_,K0d#bVcD43-G$+StI:l&%e?ZT`J0D91F_f2C6/Vr`B=Fs53Q4Fo"VHkS,hT[=
9i3DkIR&VNqUF(Qc>WNih4\1l%.^X;;GQOfs#l1U_Ph;UR%QR^i4)a-0Br99!\(u6l+k(]AQ=
g_7_,Ku?9]A""l+TbM]A@oYp&6]A7+^Imb3hsXua!%I6[&WmN3TLfU/MDS6fKSr/(4SW&+fB5JQ
4haapg\qa9Rjs'F(p%<q0I;80R-rhthc9?@ee5L':V3%LHr;@AfJrT?^gjosN4U7V&b>Xij3
o]A,4<36shL@?h5PHA,.+Ik1<Hdg?-NJHb(JTA;_@9L![fU[FoGhD\J/5Nl&2H(Gi0/,Cr92D
/9;a]A1/,gnHpiO"t;d'(HHS$D4=;:ql?H/>jaW62rHLU$'dOao@[i^\6WI5<]Ah9iA$iUQ2Ct
mpIC9q*-LK^iG7R]A4MD>UDj4lZDK6dtoG!CRp:&BDci;.;D?f*/3UFKHB5%`f%6Jk8=Vgo*F
)[qE$1/C%C^s1Z]AjK\WVXG`Ur!7E,d3]A_:d-N'HDXQXd,PfgM1eWY0:Ri[Z]A'k<KOdt`B"mc
l;q61:5_[[?m@^rZK$*p/25Tcj?[d6g0_l;=je=H?A</m$ARg=4k,i_';khR,,O-2,&i@1@8
f4uhK'8<@PCR4+h^3oa>_BkHU1YSc^?[f?"^/$RHeU5WZ_#ZZRb#d%&O.0SP]A>T..1h^N-J1
&@Z@P%\DT(Y.),*9A.1&:>r4Y$d*U6Xnh58)%)0nU"/e(3g%:Z*Y=P(GM%)m37We?Bl#Z]AcL
JkpAOCUf#!j')+/d8t7@/"uc+hm/$=W&-BD",5O>r*WdGZR&nc@*Fk2M(R]A/=^(h4N_#7ck7
Te36[hb0M"ALnPA=GL?`=n8_6$To:esFr?Q9c!RNXRE3LEg>IYQle:eP[=`4e$lk?;Yf@=jd
.'!m]A<*/%Jn)*WSq.$8[VQ;MFd1rN9[M$ER$d?*`1IFHP'9/Y9'U(5Q>QB%Jl*+@lEBcJXG0
Mpj:_(u*^Ud#1thqqbqtj8Or:Ag)'R_l#*7*4\:W,`'?OlSWM<IM$AD?5eJU9-'mTG"ZEF+(
R6>ST4P253$I_D?X+Hn;Y=mAW'l:GW9@g@Zgl9f;ANIc"Hk'I7@P[2\;A=%tXG3+bIB+C!Hn
7@JMm^'*O'<QEVaBLZf<=`HRcFG@\do>>D)dRVHo)h^g!LcSDth[efOu1''15K&Quj$ZMR>P
RN5gI`'\GQuQI6Y1"OdG:!arp'Mh_o4)(OI#IN3EZ!%P"Frj)R>,2jdP&N"B(h_d<OdY&9<$
WD8WDiU<Z,&,j:V-+Lo9c8H3/]Acq'$-P@:'omWh'i8=9OJ>JTQF,19n/a#21U]AOX0D4-/t+k
U>6=*:hWUu6;ueL3ZiBn8fB4h[3FjZ;?L(R/TBj%!KtT*Rp+Fe4'%NeJ?:6Ph#rGkF"H-Z=9
:?k[0Jn7ELZTWj^i-pn*i/pYcL0a79-Y']Ae#%E^*ALi*lI2;).00/iN's]ATt$;f4!1N%p>tU
gf3V^j>7aa2G-4g]A)Z/WR9Om(80oF+sfSg3KK=]A9t>[nIOpmGs@3ZI\RYqZSqm$@<HK^2u`X
d;ZgIJ?C>J%$CDlO(W&hI_Kq.&skWOp9p04[#I1j(U^56#jEYi*K&q0EKn`>!h,>*^jU7M`R
B]APW7&pT.^CUT."hp-HSq2iAmJ/HB3?db&Z.$cY5V7o(5ndhU91-HXXqE4n+RjN=@_1'0/(W
j!.3HHpXSaHVhI7''8*-9j-cT@(`QA2K4*3,]AMZ(EMT_>2WZ7Z`7WSG,[ZrWpk.h"EjaZ;>o
]AM_3Tpn]A+9WVJ%gpIki&uQ8#s(6<Erf>S-U/iBMeGYsEk%4aX,l6!AY<ffBte.4=Y9]A>?e[K
lZ@2O@f`L:A-,QrB'.'0J&XUhgMMBE`HrJadn$J:$K*`[JE=q(AciWTu\4l.u,tRH4l]AV-lP
TrgJ7hLDnT8fM(nN>*1&d!I_o;4dc3%otQKK9`9a*@:10Rs9qNL9o^T)kuZko[.5\t(BqILl
h>7VlRAZL,epEH]AeC)0<b1^<AKm_nGD4Jm@-V-KRb<M:<6?!5<k3G>QlE1bm]ALes4CR^u)Ff
<nhOS+Flu=q23V]A*"%-&=0=+ihfcWd/m9lK'q'"t=7N^H#<tK)ooa6Ye3>PkIh';%4i*\3Rh
!'>Pj<a\&nhce:=[IUhdpE;9#fr;D_knbBs^:JTFA9U5>'$4Z22M=n?'j^d*]A5ZhFGW\dm)c
LnW0Om3nR@ZZ&g*QS+nV`E(pUCQ8^G7SHU>VATK&IfG9bCqe5JD&0.fS35;=K[Z.?T*t!bFU
SpTXi=UAr\4,&sA?a56jKA1:L_E<s-KW,lJbZY]Apl4qZ=a(1/.ln<5]AA#KYJ[__nlY(^\J4+
h=q2Z3*5($7cHZHdX"._mM3<[.b4b<D+&UX)1-cFZ*,"_3XH+cQ&Ugn@@!?=95B"Ph''hR3U
X0qLKlf%cZ/5a#&.7?5-YaZ<6P:`9X_T:$=V+cVudZO#>q<KHoT$*_S(@=.L$+/M_@Tk$WHE
6mc.FH9XhS@OF=6VQ3r-44^9C7p,LZQ7fNe&Og\-R1PVB$p'e^HE9jJO4.DFp>FLL13@P[Fi
"OcOPB8c(qon:FZTgiuBr[-HJY@,&kaNNR%1-<k6B7gU<6?(DcP+r0?\)RP6bVLdU"%uG6W*
mPT+TdET-Ebj-0Ekrs_AX/8K^%%O;g&Bi#++>ufMUb6Ed[kWX]ALjF&=qOj>ame<rZF8^%A5;
>;71oaJ>X^+0`Io@\HU+8[kcH+8R1cmF6`tJTO+%/(ep/*9@>:J59f`lD9Hefk!9Ofq6RFob
el@*jZS+ssf!2b0FM@[:W!KhQlE[V\c+P=P#-Mrj682dE`GrSh_gWP[04ZICL1g%@)_R=s2r
t>OX(=HBe(-+#2H>'j0rAbJcT1fR_"C@.KlF(!PmQ^N!Nuq#3i[t06hI=iG<]A0V6TecA<TX&
G?\3\gEVeirl'YnTHW1-e"cZSFl9+Bh=)>([W]AWq+Q5ciSFO+uW-AtZ4SYgsXr>F02Vh:FSU
Zk3i*gL"6Po(1,P'JBI`$1la/<Et6_W(6eF2^uIN+%%>k8HQE,I<>INI1tR#L&IE-=t_<.%X
:hAtMH`Cb`A8_PtL3oauVD6*[:i4oDJ*Zf6G&=]AU[Q=g,RrK>mRZ:`/n_/oW4(nCQdr<-sZ&
Mad*-Y$2e^76UC\]A']AtCho$:!#FoB)NN@2<7G1)/!T>DuB8M?eB!PIGL_W[AU]ALR1k!o,-O&
t>YO-ZR99(P'KY3SgJY;aHp7jSlL5G^YgRKD'&U*OKn5r@KNM+*n"b`ud]Ao_Sd5K07!&1B#_
+$gtjNE.@;uV6+Fs:7"2'\'<KcJ?a??nT=).l7X)dhV5j#b!\=__h%T_no):)Ii1%ph'*/XW
EZmSl;s=,L;]AcSI.jS:<G9G4kI="EY)Pr"p-jA1`)%mRCfuYhe>q*E7c9+ZH,!;.cI*rW>5X
s1if=tp0=@ojio&P.W7g<4/K#QiZT2@IWS`c;]AO=Hh8g70G?qUd-8o`f)]A<G-HkK?pgY=;p8
Z-c_j2a_bCiEA+&lXaJ?g31t#UQc&M>jD+GV2fV@;Fg&@4A:DB83Z@XOpNCK9'5<<(<kRl"`
APSr_?l!583ind^h:$9HRllm2oH>ceM(0AkW5M6-qB,`5Y?J'K6\VgJ(1\K>U"M"Ai6^]Aci6
?CaST4/jTI:T7nH6l0I$#YHnghmDEX>/GjHuq/.L5h!!/rXcTaJ.dTkc$*V)@*\"$#!oTDYe
ARnI-+]AA>Z(5ol^hKOM]AJ+CQYT2jbo+SQ;:VBX)E7^P__W3j+g3\q@QaoWW)1$2Q4>KNCRC-
/4=BmqHA<1^N4Tanal??^CjpMA#A&OF:&<$.bAI)p[-$cK\JT[?KU%P^E^h!hFdgH0j-Mo@3
3@DFgH*Y'+Qd9M(BRkOdc/f[&U0!UMXsVk^@Vj&FnC@ir+6&)WQQZrSTQ.,Dap.6P&iH868b
X:e3-cZK,]AQNrfGR*ahqm]A!m=e-q7&_m.6m2KR=UTS8`VWdDQ'/^cP1,dgOp0KH1(^&h\:ai
ccXTl`SQLQqgH[.s==ge&@e7)K6==N/U,3e;#FgS9d]AR'rHkE*M`_M;YJ5[@-YCsqN?)r;/S
+toD`:(RMb\X05F"mH'_rso028s#8`+sbJAk_<hV1ZZ=TFFIaS6:EbQVUl,7I@-O_kjB3KY;
,7_Al21:i_&MPf#0=+a';V+Q7=Dk_foo_cL7+UaCp:8Ho*R$73!\8K:#"NhE7$Y!UE"[!=-9
ipu%UkRV1#XTJmfo4VHtg/>m:fe`/XT,#OH%HfpR0OV(BMd9h61f^+8c6>]AuQYj:BpoA<C7`
Rl;A\/KQ`Ru_*YSQ+`U^$X6$'<W_%sTJYJ'Tg%0MGeq]AS!IDW25,E.s;@/3k1JT;*5r.<f=k
R6'i,>bXF=C(u:Y0GS.G0pg02VpTR`a-Kk4K%q21#l?&eKOraWa1HFT-f[A^fXo_0=#`%lMl
,9[\0&dN]AMfdgO)ffLQgObQ*O<L$jf:XJUfhk`,gDS0/L3emGBn#^JLKhT)<B:A=_"<QR/J5
p.h*\^[,/R4jdEB-Tn'B#;VTe0<P!oZCSHA'Y32R#NEepKXr&K&%01LF3=NW@"cBuO/qsXn(
J!LTC?WUR3;0"7n;cm9^8$h>kf)9:u%6CR*a0\iVa8Rh9IT=dh;TROHSUH#MZ39i@Y1i\@1I
gc4?R$N0`^mN"BBY\4"`)<-Ta$`hI$J*Bli)h.\mKDQ(u[#9EfnQ]AiXGpLUm=NR8oYbn@67+
4/^Zgta[Ai`6$O;UULU\$Rr9fGX>)NUJskj#,.oA*H)H/[+t&bDiQZeV\R*EG>MdN6HS$P(%
=00?P&PXkg+#DOXr.Jn(EH<CH+ZLHYBM,+.?;#p]A/Bp8j\8l2K?#YOi/<EJ:kE%aN'[riMQD
EZ?DQ)I\<EVH\P'WN4>m/Yh3S8*4.3q;[ku#k.P^(.,%T1>Q$Ui-0*o?@J6">m'usW<Xlc7m
i/#=A:U<GVW(iR3cB7g+?Ic*cOXblF)3!/DS:XHo0CC[RGj;\)&B6m5.=Fq4HfU8L?1<]AbB-
uN1N;)"tq!RL<"4,dD*PPl+&]ADQ>[`:;G1g/5d7;??>iQI@]Ac_`k$KKe.WNt]Aks,o4["/q[;
MZ7=4p2#:&#!_+RIkpj$Xi]A+;iPP',_BUi\l'ZG&RgbE9;R&Qhp/sTE:]AurK_CeH52YV*(&1
ffa&ZK6DrAlM?5+J#kN"?=DJ)jG]AsBdGiAVq/o:0P<L:eq"I3qt?4dndZMa0*KA&T#[@>2Ns
NU+?YK/P:k>M+8\Wu\j!M/4\a`d50VV,Y6d!aFW-"kZ31gNg2S:_Yn+A4NT1%MSJjE8YQkqZ
&fnI[%'d)Be>4OH).l*c5JJ<-=i3ONQ7\VqJ_Fi&22bSF#4g1r1o&%qim%<0fnk)M.)nPCg4
qB@ocUk3Wh&.:E*-To8;*V"cG[t9(o=R'1bSV6bLq9F[*"0-WWV!k3@*3$Voo>9cjmhrLH"f
gjZtA)Z"um`WZ3KClE*T,J<`on1hRB:7R5coI&+GB3Mp`4Nr?C74:gESi*k-%/rrM#V9\&Gl
-p,`5a)bqK5%Sn*&?^HJqb)[j^?OP9V2]A*M'SnKe.C(KiXl,@7-lsq/\hkJ<PEjWoM*B)%(9
WFM;qEI,VoGXJH!hH!a/U>Yh1&82G,m1;Nob="SF6qHhiL69EI;FS`C`mJu9<P>9&ToZn`LL
U_p4-gV[9H7KdUYSLLHV<:tP^?Po:Dh(F["Z=Af`)E5X_?N2+Oc3rkVaQH.pj96+t3l6KbgL
33<-:Z2n%ACN:MK$>X9^^Ut(hlLBXPcKTBAklGr3G:Fc\C\gdi5TI$XBQK^n;8q:&2b)`r]AV
p?n:e-7$2]A?f1R]A_bK&Z4aoH@WS0i3133H.qO<Zak1<O.[#e;0q+AJ$[gFpu-TU2c@ld>dWT
^a/VKPHkupQXE8IU'*:jPK?@:X]A*7p\Rn.&+aRFla_mp'jH/Sahr:R-E\OnhNB/"@Iktm7SY
(u4^")'$KHLG/$$JQ3_DnDnCgH==0JY6K5s\QaD-ukkj30D#_bS(6)N&?qUf&$m%7E&_n=QS
GcrH:#_]AN=.$T:aWuqpe*j*@1BYhkf`;$!lc_g".\GS'97QDEE+KbpYIM&G?;Hn*G7p.VW*H
O5Q0$!l$dO/&3iYW)EA`eAqN(QH!<@"<``$qQ]AdD%%$\9!q\A7&,kN$g[B=1frr<G9t02(a<
W:!74J(SPq3[6VKNfO]AY"Jet*67WO)*HPs`R,q^Clfg/\X6Tb1LR8ln8G_Tn0)8"S%]AbZ@#b
61)N+lK6AD5'!te?>8,jfoI;Ym`@BMRcdeO8]Ab\4X\;.;Q"LJ82PLbi??_`L)5C6%a<`\cOd
AJWu^T[70Y_/1<k_`5+S]AcPB:42$YHT23ceG8%R30.IRm>:,I+&T&Er6;\iT%bW8Fpe34#ff
QY0Si/L4F+'e6POQ$%I0$K$s=E+]AcA`G`[kfdq;q6G)g1T6rZIl%qb!<b+qN_gFK9'NnM(0!
gLOPYuE6MJL=1`O$=,bZpat!hZ7*-;"XT[?JG+!6k=$0l@X="Q6u8"FdN'80u[6K,kFkr:sg
dMWn>'kiLr/=]ANTH>mb@BdDPPkNk^jc]AR"qo4QL/"b4sT7ro]AUArsJ~
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
<WidgetID widgetID="a9b555cb-fba5-417c-94bd-463ada77b43a"/>
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
<![CDATA[1188720,2407920,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[396240,1767840,2621280,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" s="0">
<O>
<![CDATA[事故数量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="Embedded2" columnName="指针值"/>
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
<FRFont name="微软雅黑" style="0" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="176" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G-C'6fo.Y1Ij+GJa1Jg:D%?h6MIoKl0g"'d4j%NOPm#-.m%5FX;7nBkbb*>)@o'aP>A&``
n/H8iGK@824"O<V!MSPSu=/[07#*#`)>W7`8^<UdGd30ZbS]APIfSMQ$d3d=WbWX#ER1%qL63
NIc&KKj7@\Ss-9^Nc?Naj"*&=#1R:21FB)T$]AtCkbH_12`IE[n!b+<o*0!9HXZDC4T`Kce9/
QlF@ZLO^(T')>6DXLe6[,]AOgq;3i%^[fDKRl^R^p-VWhrVlEC+4%;EIOTBr486ph@u&O`Nh%
DaJ#X[*r\K5.ReA7FU:r(H6;OsTU<qc?R[qR_/F;ct)-(b+;cW-:SNYh/;^f3I?u$M7>tYiQ
=DV:XDmXL[XJ@l,Da(6^o%5g/huCI(:\IH.^<JfnnDTW*$i`cs_[Vi"*^!b.ABiKD"<ho-bA
-FZR6UVCWlTguYM/#rqLmJdk]Ak_=Xo+(fhEY*%_'c-Uf6BfPN/Sp.5KWZt:A`TOh^1MZ@=^\
8.'cm-"W@9"45S)jiB'T7QBs9o,**3WF9omT@0[t)2#Sp%HO8uX4hf(Xegf'DBV\>Oj.C&cF
n!r"#+qaNA<UY4'm,rsChB:*j4='cXuU(AnD)C'.`K5AZ7t<*$FO5e8NXRg[qicuSBSq*PK#
t<g$/-+\pAh)Q$RLEYT'a+J%a.3$"$cDdtOhps+O878!?!JZ\<Kll[Q;V.R)4N@lP4USfY7_
'H]A:_/u`MCBN=Q!MY8$P;X6$=h&+FfL,:)m/Ktt$:6UT2ep+N.@>scTUa"WGQCRTs`*-Nr_9
cnSb2FY9I+P<=IF3(H>69(ImQo[T%%X;355"<o4'c#=C:FL;<7\<XV"%,i=J.f2C`*ufG#%K
;Eh)b.?TM[4An$+_U&R*ckPCa,048"pM>MZ9As;aS%\jJsS^s=jLVe*FN-4ZEnOBk>T=n@@.
+']AFCo[.GR@)*dOuNMS0Rl_RRg"P1KO-^@ol&O(h7]AGPqs03-&2*PiD>@__qdN%Urk=1Xo!r
m,IRluKhlCttoZb;Tbq@7t7m>1Dc]A!#=KNDP5(=fqS5e9Lf:>CUP(f$5]A1Y7FajdT1]A)buFV
J,?8E16SF=XM$6K[oG#(N7V_-ST%p'G]AC]A2eDb_NoM8EjA&!F:Y/m:iF>nK:WNuIfR9!>cm<
b:#77\'@r`S;q&i<W@q1Neurpek?@Qng-F5b$2J5r.Ol%2STT8VQhL;WgIL*!Y\7Ia$<FH#a
diY*[KS`ItMFI;SARo[")pgX7Ekof(^diHL?bS2a#/XKe$r0.%H3r5U$S'J5%hjtE?"%ql>C
f,n1PSpD5GiQT`pgRom=UlP0k*sE+.'<C'k9I,0YJGt!e&CS/@Glj_QXuVB/+WQbSe`pR*[$
DbWU>nDh%l8Nos_g[/X#E(-j*0n\CL5)JUXn9<o1:\=+:(r0sk"6kS:mef&%B0':mR/-B0_'
&`BVS./kD5^1:2kon`@_2cOh:(e;2=a&Lh`.^\U^mtR^YEj'ga<(4;fSnk94e@cTF8";[%[>
CuHK6Ug$[VT5KQm)HLVdZ(Ud>"#Uh+fGmF#Dh+4nMDtXkN^HUk_J?;XZFecOR*8C/77"T9q2
Z^[CNhg#2[#nthr"K5$gsL,bh,4&a%]A6,WY&L!o_"l8EY7@n+Cj3eCk;a-Cbo`#m\a9i7[#G
YE\rZT1/=_5Lq<:U/;>o`\UM@[Vk#8,j.NGa(:PB<,r6b.S$u\2N;N=,h6FRe3Oi+DG=>T=/
Ke%Bpn?f9[HD(^+l_.RQ<C9(dLMYZNhGW]API("]A<FmGO,+If:l6lO(Pfr\gBSkI!oUL3EB2p
c!`W8/4if6`XED7_!Pn;hk:1JW=:`ZbDmdeU)3r1F*NS\a7-J!e)dWX2m_F&`6rAJq&6"W+m
UFfZSYUQ\T0O,'_e@hI!]AMN]A+7@e@JDfj<EUt)#68Ao\(82")l"F^RXUEP1RbP88&YlJ1I0.
aIk(Vgp^4Nq51]A@aKi_?=mK)cje+$jkRE(StdjQdBHr2_pm_cY,JiorT[\7#/P?rjD9.i6(=
r/L3f9c(<4,CGh*1h2ql2;\=9^ZNPZ!&F0#dlXm(Ts;BX\WR")8/*-]A)1%K_ulXo5O4?l[31
=aJ#D2=n+,bHL<2R`G:X5"KI\$?e@\#W1?d/,)"3Z&c:!/qb;.?44$u>]AKmU!SOT,J>bR_rZ
]AB*qI!XlA_,=0]AdM"h&@m'Z8!c_att.olBBptiiY..PNl3P#?j<cF_Bo/JkD'!SpS3NZo2%L
.+DdJ$*bDpbH@l^_YgHP?:/+G35'.p<*=H5jqCC3a`%NVD@:j=4JX\.LZt\ZJrpTio+$@O\k
k&FUlgPD&C$I&)Zu$oH96Aeh,k9$IIM/Jq@lV1XG?/rM8]ASr$R^Xqs?4$dXBfh.;V/70X)E)
PLI;Hp(^cZngLj#ga=t>jot#R&$`t&b$E>N.*aV]A1N-#QfgP@U8pp&bBjah04Nktd"LjHhWh
aW(7!bjjb.-E2]AqC.C(?<@QFR%'[VTnC9\VkT71gB!Onj?BepGo?'?UT@!QGe.qsDJP=I+hU
WQDY6q?(2Ze\:H_fDG6g82C:-_kJE>TL,V6Gq.5[e!L`(s)%odZs+5ti/HOW"JZf)r[O"s$P
S%cNN(NM^>m-tM2F`Chh_FY&oWF*DWR?QoT%NI2d`^IJ=b^Mc"Tms"1XgECW<F(7Db`E"!bY
[p4XU7^C!L)7D7Au$;GPV,cGWQ"qj"E(`5Ub/\e:XBM#aS.bXn\Q\U@/8hbK#_,Ab_KlY"fE
W`pVn:4II5NH3<5jBA"_*g2>G2b%[@)3Q(MRSLs_P%EuLJkA0h,e0d]A\GOB1l<AR+eeML1el
IR[n1eSec$:#?erp&D<9N;TtmES:k<-fb"-@;S^C<p$o6f6Q/SEc(sHSij0bK.Zl#NHLmeHD
!Q3U+`,]Ag1[cPf>[2r1aI\nZmEkqWGo,VoP5ctk!K4q^fA1PSBXHY3D;DY0`K,<S2fL[2'o%
YVVJ@(meSBmoIdJ5jOp>fLa"7*c$FQAH.>olaN;*tXu@P`pW/&@%>Xi^g&I:tr3BK(JW.NsG
NOTdI">c4@)Pn]AVk#Bla&K@`VLnKY;F.b78KW,NWQnSTK*iXMS[#0g2QMs`=--oadh^s=3kE
ApHd+cM&3V`m[(585``"]AGn%WHIR3.U:(>=66eA6S)OFn;^,[ChO(#Ct"9[6JL9f6sNid?$6
si"r]AVc+;u"he4q@t/2]AcfNJP82Gj%7,"%0Jf9j?s'[qS><h#Ii(I%/;!T_fnGPKPPb;F80]A
T$odGd"mW3!F6(SG`)1rE*4)?!TY3MN6E39Y#E,g>bKqgbthgdMd^F"N1gSaBL?Z%$]AGrd3V
jt[nN0k&9[G)GOT=!,i=UN0a!,FO@7qtVV*5"=Gr;qLQu#5<!kT%KWL6IDM%E7%nc-SrU[Gk
nW"1)YX`!?3^p=4l;SW]AI%_o*MI(L6,]AT:<6`&ZVQFWHnU%89V&kgRQkRH=o7D$1$/_]A57mr
Cmqam]A;MfO!5&_MQ[4hkQY\nEmIOVH.U\:m$,J`Y9bU^[4rNq`/H9Y6NI)g.GUX!V[>uu?#3
,+(/82/">)(+aLO0]AgD+0\P=>:Nl>AmsW/@8u.]AU"mLKPoU3;jX's0)gb]A\kh"PMAEq33X7!
8Ds%Q_2oO>CP$]A6R=]A&i.L#"?;M,Ws"Rq2CY>NWc`a`NNqs?qh.lf`1LE^.#K`+6/1)+o:Qr
7!gm2,m'-7_tR+tW/.lck"-Sii;V'0iiPI,>X^0]A"]A>pRcpU`NLi!Y=_[4$Mld3-sTH"KIr>
,2mnJs+d[W`S=i'%nEQ&`JeLBK.g!&<0#6)B3h'iPp\WR[.0mT.o-DS+H,\(iUJ=alTX*N`5
P0F&jHo3$$bSA8,\qBM'q@-0,ABEO'+<nG_2<?F6O=#(J\6)+FW+AB'_#qh!jGq7Q-(4i93Q
)C4TJH))@!UaPFrA/;%YYAO4b'iNI*6MfFal=Y0/8L-0Rls0ST$AY_/%oSdFt[8HR"JD(D$t
Z[qOo3'9<&q@sD4D!6ttE%=1gXJ^='4&#8?3FJ&'L-`GT#6F:S%nTXN&a&AL"^iQ`9ghcL]A[
71E<US_!aa8SJdu%d%@kbe]A#h(E>VLFcLP2:<o#mnVk1F"NaQV%C-**V[mIFHs09:c2l_FtG
tGA,R#"]A9eJ=n;\8q@*0'(p[YRW\@$P_145U(@PrQYCYs2:7(D^q%21:E3mnQ,DNH?`bl[60
M!H*"_gi-eIJ$4)WMZko'N/:BHppXY3#WZo6.*9Q&Sr=hs$\k/CI[FU#&@kD.LY4$XAVO\U^
PQ&XZp:HNX&gGKsGGU8',d:k0it1\m7i4#WH&K@[ngDETg1jNe't;'o5"97!B:'$,3&h_a*E
WKu^fIa6ogY5iaUkr%j1H`#Y6"'e'Y_saulkF8`Ei-<V'A<YotrA)VYTQQX0Qf6k#[$KH84o
ei4>4iORXY'bc(Q*BB6\/?KdhtA$GKu/+kC4]Ab;EZSRW4(c9m%0+H,SmJ;N'Q4k[&S"_B]A>0
Y@?C]A:\[-.dX#5>M+2#cXnOL;JmMf1YLaMaL0Ggak=p,s,.b"/c/"#mmc3):Z1n$pWRq!.&N
8g4hilJA2_6Mg)?_A&q*=`\;&-A.-@hLU9har4rVG:n#oJ`g^JP1Y8OA<.WAOQ!%VHK\)TF-
k:V&;Kuj"1Gt23%Ve=H5Pf!<mt3Vh.:VFLqEJMKRlCW6.'jRSUL-bLG#)ZaHco&80(2f/JQp
rKOM$S-F'I^24fd^;EE+/7`1S<Elhg3Y*ji"pI,b1_m\G>k9[U=AF,F(L6'65qB/hG8Qis,P
4.dpX<MpE"dM+(ZncjJT["F9M?g70udk]A$(PEO)cFDV(nX50.6+i')f&GR$Oadklt\sdo1ei
O2AWh^eqV/tYc)D@Y"!&3EW*j9qdP]At8'U%HQ6Y'.1#M;L=PWOdZJ*i5W8LU,1=?3;rQ5E%5
F7.ULe<P7,cZLQ3/BiqF-at^qm'0PO59NB]ALa+=-%C"]AE'co.hU3f<C"H(/3s'k4h$OS?\b?
t)0OABn=5!s=#&3+PFJ]Ana&`Ycel1bH))@L`\H!(^A>m2!r%Pe+rI4FANOhgmp&kMO>n4lSl
?PFhR'h!>$/aR<WRg(b6i&9N$pDl(A+8#?`3*p=/p+rmRA&IlhLZ04jd@no/F/fgQjC#0!V.
c'Q`CuIs$?LGK%3j$h:+=dNh>s^pBTclL@H7.P7]AY+dC4l]ANG%k(&%ZV#n+N/=^>q1_G^''?
EPm6WXiSd?V0$/QkIXThsEQk%ds1*/arR:f>f)Gg~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="625" y="10" width="159" height="84"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="关键业务体系人员"/>
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
<WidgetName name="关键业务体系人员"/>
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
<O>
<![CDATA[关键业务体系在职人员]]></O>
<TextAttr>
<Attr alignText="0" predefinedStyle="false">
<FRFont name="微软雅黑" style="1" size="112" foreground="-1"/>
</Attr>
</TextAttr>
<TitleVisible value="true" position="2"/>
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="5"/>
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
<OColor colvalue="-1197808"/>
<OColor colvalue="-12080918"/>
<OColor colvalue="-8988015"/>
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-1"/>
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
</YAxisList>
<stackAndAxisCondition>
<ConditionCollection>
<DefaultAttr class="com.fr.chart.chartglyph.ConditionAttr">
<ConditionAttr name=""/>
</DefaultAttr>
</ConditionCollection>
</stackAndAxisCondition>
<VanChartColumnPlotAttr seriesOverlapPercent="20.0" categoryIntervalPercent="30.0" fixedWidth="false" columnWidth="0" filledWithImage="false" isBar="false"/>
</Plot>
<ChartDefinition>
<OneValueCDDefinition seriesName="rz_bm_system" valueName="sum(zz_num)" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[体系人员]]></Name>
</TableData>
<CategoryName value="月"/>
</OneValueCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="24c4e795-0e1b-42bb-92e8-f978ea1ab259"/>
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
<UUID uuid="c8d3cff5-6ea5-44ee-a8f9-9dbbc22836c5"/>
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
<BoundsAttr x="325" y="116" width="287" height="233"/>
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
<WidgetID widgetID="d2353c4f-2056-4f97-a9b3-06cd9c892b35"/>
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
<![CDATA[3383280,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
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
<![CDATA[/347732/工时投入看板V1.5.frm]]></ReportletName>
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
<FRFont name="微软雅黑" style="2" size="80" foreground="-1" underline="1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;P@p=s::G@-42SA:cFQQ0C!feqZq*8Z+G$nhg3@=+(c,i\6KH)%<%F8mKEt.]AVe8`E$5
#*"[DklYO`UU[a8e[R3L1gZPbc5);D-W@@Ye85?NMDFrF.F\gZEp2-KA-?oGml*piu8RoD:\
ckBXg,d^Dsfs#Bkq&J5V52f<m9f+AUUiZfWgH0l[q6_>>NIk`;pigjFmI/,(7aiTCu[(P&C$
XW0?3mp(_RQW=eEM"po17S0.0B)*!?*or=&lpsjp&"sSe0FuI<.eQOEVV7l#VU'8]AJ;\7[X7
jBriTTT\u1S=(6ZoI[#7ArP1LH1N=C<1OF6_oF\Fg[VtalbIdAi(AmZ?ao\8724@l8<o/2I*
'XXu5Tj!'GkSo$Fo`K5/^8rmF>FQ*bpmh%Y$m,0?^U\\<?_d2&`XT@b#0A8B(i3pH77IX_\V
<lNlTKJ)/$:b1`hk1teJ2^S1i(9aPK`oWh=oLYp#!pbD"Bi),I6'a(JtEU':GE%F%o;jE@Fu
KehSMZ/\1dRBZGu%W@e+0lkOY3WK[?nMpZr9%T`G941eYM[Nn6>l+m'EbiT[\K:ZqC]A(:U/[
Tq\YSJhSZOe1iQe2'SEGgWtirO[_dK!*I6o1PRJ7EatRZ5P*3l\\0aS>l?K8&m6(W%D-o2=[
DI8=sj6$al*`dC$]Aukm@k#]A:.g4;++(T:WmCO93O9BQOIn=2OR#5TB;CIs)*e*\+=LpXgb@C
Vp]AK61E*@mlcI`M[kIa7]AS$lh>2RC"9jLW$Ca,"5N;cVd/4#"]Anf:&6h7f+cZl-3En[?TX8m
[j%.@YAXip<S>kWn5jd<-7LH\3oRZS-4RXS%bQ+GWq"GM6EMC2fojWoO)#[`6*5Oa2`m?Wdf
ob9pp]AT<1hs-uHnFl+>cl"&&%$IZ4(e%:/2Rh@Q(Jh;R^uQuEnTc>/X;*9:*trTm&?MIpiM@
fi^4hR/-'d;7RfZS/N]A;g.JF%8h9F7N-12YL-saMiRD<C@EDUStP[\pmgJO7+#6aS#"]AHD9h
m@Lu\H[d+,)&&^eSsMeuP5[L)&NkdGDJSj><hICAU&kqu_,[\=FY`Q2\!Q/>tnp/`e:(;!B@
0j0k,\Bt!r_mSZsa-%n$`i1_6d2f`7\bi$eU.=r;ir3F*f^6!D!HaK-U+cL0#%(+`4VGt([#
=aLN&508&-J%/)KY\BDPt;=WI;J(2_Er>AKFH?J+;Rpj?\,31<%rB4:.?1aa<#l&=Y?!-peG
DIAc.rn^45l_b_`/Mj6A1#\pBq9DP$6J%ZcE=iB7ubt&e@rkgut?a,,"K-t33=Vepr]AHc0VM
#:l:5NN#l2M^j7'.'"%%^K'=,^S>*/Xg`@YaZ)!6?f84K!<)?`BZKMOAmMo$8M(kK);_6e.6
`AVi\#1GtNC'EC2[`UN-l7aEt'6F*GIp5+bifb%1Q,k^H<?4nBI)48@s/n!5)nR7U/)(3B#G
JMkWc4_@[nY=ZC\;uH'qQM$8;jmhkF^WX;Oi.(S`C/>b;#b[7OC@D>73<l,HPOX%RgJ3>apo
0QSS<X'So$Fp*&AC?+R>M2#af;f*!-eZkD@&QPUMt3P`s'h*!trPDaR3clGPq9i&:.hHZ,1[
rRscM;fGhru&@/:'U(Qq%1Q2-_]A#8V"hr8o$12)sm/*t$WVZ$p1q'rXoWk",aPB"qb%%6mV2
m.flp$[$i+e9.'d[Z,/2DrUinu]A*h"8u*!-K()2Z@`#mC2<-4()/b/fM0lW^BnQRFm)>Nf*4
Z%eDm>*:''WU??pL\a/5M30t[>LkLnUj6*CmaVm%]A58a6,=p47NO5?Q/Vcr1_]A[db*8b[+f+
Fb1))-F@j4\#]AW/^9V%%(u8D%=J;l"n619V]AXRh>fL-hJjuh:[nMQ'F;YBdg.H[tu/:,-Dd)
*GVd\rOgf$HeM>b)`]A*%W0)+,'H%RKBr:K,=.ZpAHMNe"$5`.[$'*5qbsZSBaM1bt/$_*)b8
rF5CA-%rg[Kgg_'MYjn_L8(-&95To<"7KH'Cq+&N'J:K=7+[1;b7]A>4#[`V&M"1HqY1Gf^H_
T9WR!jI;<5u[+fghY*O*nU]A9KUuum,@Du&ZbBk43CQ<HR@:81A<8!,2h:@5<MA">/niZ9n="
2JUfg=SWOPc[)odF(L&i\k)/>Qr5Q_5?le;=?3PheJ@)W8.4k[9$A:q+.*1gY['K-#iFdg(%
iUW:cirT*b^;df1"A7nXaO![:5mF&,RD>'W@<Q=gcLVBRASb,@pn[Z*YO4]A-A"/Gpn=^s#Y_
g#E^HfUI%3o*O\9Umf#l&&R&NkP3Jt.WSBgW7eSJ("iO;eLg0N@)X'SZqA%uh.R",'4J2un1
#qbJ\[D7>2\.N)XRNkuOYTjpb`R+GqM81W\M$44Gs@64bL_1T(Ho!TCJgl(NQ.ABS=&Eif';
$n3b)"SRsc=3^PX1.LLJ]AhM]ANd7_.Y"PLu/))^T[D%XJpOiiSCSiVtdV)tUJ>A(85S^X8Oi"
q;2f=.&RfN&o$)ins*V/"RYD(-g(h"[lR/DD)T_DB#@97XrNmn4rc`\H+RLn#"YY!&3P:6,2
@Q9sS&58H<S%+60XM[HX>S=tT/#<c_2HJ!9@oiq6\J:24O(*e$R/$t'1WSEX-QT"(]AEr3I:%
7:$4Z)l^;Wi0_Pmq.8<sX%AjrqNF]AHW"*^VO1ocgisER+3`)<H<4IZO:Ncbu-U3'7pN=k9Ak
cP'@X-e47K!b8!l_!!rbKKBH3t(h(1W*TE^GYQ=^QfE>ldKG%GpJr+*u>DQ,f$diB`EWhi6>
gOs[UcGo=o*u-[mnb,GC,(kY/<3\#5e3+ITAj4D1.Q*gm]A-o>S7tO#d%#0m(m[GMQ<fauNBe
1+OEit#q3nH+@&,;=MOoMn;753B@53Md]A%)BE$@4t@.A[<oo]AL9A_J>:NGkk\3OX=Db4bRQa
iEI]AP#.ad)N1sdc-oIWBAej"KZ:F#!5u60>G^.PUHOX0]AZ&mq,1cA%iiOp?%otcMP<1O/>^i
dBu8UYtuE'PrW;?=1h1um.K54T[%`uO'*j'-"'%n`P*p/3Ua$7&_I/5""LTNUV>eD1b=+*sT
)',;pFSH_DPn_G,!97TT-\'>-ifj1<$2S)+.:`-pg;L7U9iA`&%B*=&If\Z^#4PH_*&gSQ^p
"!5.,E"n3JITlNS>$7Zdgi%k:`;A<TTN9[ke<h`\GS2m%M+[EePQdQr;$;%;iSU(_3P2nhOI
EM>/D$k<[c=Kj,.e\nVt&ql_DZ23*3RT2ZF<uYJ\;Y>ViU9#8We,6T3Ws%!"74eD\IFB>G.D
n$&[om;<c1$Uil"@'N.N=]AshtJ`/BY[R7kfYptbH+EQlri-Cd\[@n\n[365&!eh^kD3k`%T(
\pVpdq<13]A8h*no?h2A7hEf=OV<)7NQh#;CDM\g3V>+jJfV%cL\j2?AFL'3_qXO+eF4!*jRC
106^q/Xm)4=$F.,:>R'gd%%`Sm(g39m?XA2BNSMsK:r#IKE;?m<W<MQJd)48Ba1^'J[1ZktK
#LZ`.`FMFOcn?#'<<=2AhN8MYXD^<h.#qr?sAc-M]A*9`j0>-HWgV#;4qF]AIGK?#T%ME$S5,D
6ri_h^1FTCO\2'VR]Aq&>EN$.cTZTT0Wp[WkSMb<.M@dj4$j$G3l.j%)*rWu%9S%>\5e*AEtu
Fs)P&^oMEe$@AFZ=321jjJcC?FfOU+8J4c9Eb%!AGTf68Re-&g:$iImVKVfRK&[UI>%+<MP9
<6gLqZN4qV<%>jDaRb\A9P"m.L0GoK*r/d?c=I&XE9/D::D[A,e<;M-kB&3d(CbPCW%r-IG?
=r_1s-,n@mNP+\_OF?6YO@)^&jPTi_-n:8-JE9#f;&YB)TR0t78a9hK;0X2guPSD0oGRBB]A#
pR9XKe)jdI3nTUWp^V7116gmE?U6H$$S&p'io:a!_AKLQY`+9U;1M/8QJS7R>2-/</QG0$Ad
]Ag^e.D"TDAQ;P`qM?.aQU-"1rnqQ$Fq[/i`@m&QYW,klKcRm[A4e_Sr)1_dDEK)r-GI,X`+k
erHO,K+W6B1'(XO17qj-Og!FoR$qf-*Z)TRXWiAH>c+(3k5='lkIB/!\i-pJZI=oT*g[cbOO
.E'Ul]A&f-b:;%mf'qV@cn_JQQgcBP/C&OX6+Qr==k"e"2Gi!A%Ah-\MT#3KmQGRF-#jmOQ^*
K.+uNW=mm'AY"KArNffYZ;M-tGC_ESqH@)hqFU9I>-&>1T8`6?blUC?D++r02d\+`]A(WB$Hb
B6(PbBHXlG6)Jbr%GH11U?hjFF"$?SW7!sl1Cg'D[t&>;<//cgGc0'P9Ai_7H5f>a6SMj9qm
uo[VfKj^.j<E/TLXmaN"i`X?bq4WJ&!>F;8eX-95UIV[[?8*m]A$:::KqhjnUSAmWOV4`jT\)
=7\a>2a544<;3j_\eUh6os!7+4cH]A)oe;DlQ";X9o'ggkJossOj*Dn[WeFmhmg."#P3>i3=B
55MN6i!/A#PU+fH12"N(P_Ae2n]AXD@(G*=h54$5t7,b+gW_eA5)u#1+m[O\1`K_#KrbG(4HJ
LUfH(XQbj*2M<sc#OL'mDA39m4nK>*Q>s!=8Kj=l@9EFk;k5Q$#Et*^J$HE=8Mj"Cn"_Z]A]Af
=P(f,Cu7)'Yrl&<V*GH"]A2GWD([A%H%N?&L40.SU*dDtBhl\XYWt'5;.B$Dd"+9o$>nHeB0(
R7EK5Ps[>RoJ<]AHan[np$3\JBno<@pg#j1\_rH*CLOe*emL06YVE54>QlE"B1e9;qi3+B1!k
^qO.5lEt6nY@KmHa)_/+SCc?sReoWZ84uHq1QtK1WR+O;N"BWp.TiT3;[hP7/4jQ"f7ph8Qq
N.SV=XgAJaQ/3hERa>a(%V;+j?fa.7M5b'UTeh_UWV,ks$?N)=OH<11^;Xk/-iSBuZ52+G:*
p":P$O8=4>o^[WmNdGZ8e0chlD&RFk5$FjPb#[a`gkn^dEfghae5ut3bg+bpu"ANo^kOUS'P
073=6[r-Z?NnR`Zi]A?G"^cg)0!sA*iH:'!_;S:AZ&H1&lpCI;26&9J\VMK9$3t?<]AlbUF3Kn
-MZ,(sB_9:(fK,?5kb=neS@FZt:^'[Shon:"F@fmI.SOR>Ol>Xm.S21+kUs.4?((Ij[@%:%S
HEAmuo_c$qAqrpf,oR*<-Kd[0U8Fo]A":SXI"*t%a9&nW+E@<0ONX#q1,qkbd&cA7W+1E>K*f
`McD-Xj;jg5!$it).l~
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
<WidgetID widgetID="d2353c4f-2056-4f97-a9b3-06cd9c892b35"/>
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
<![CDATA[3383280,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
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
<![CDATA[/347732/工时投入看板V1.5.frm]]></ReportletName>
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
<FRFont name="微软雅黑" style="2" size="80" foreground="-1" underline="1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;P@p=s::G@-42SA:cFQQ0C!feqZq*8Z+G$nhg3@=+(c,i\6KH)%<%F8mKEt.]AVe8`E$5
#*"[DklYO`UU[a8e[R3L1gZPbc5);D-W@@Ye85?NMDFrF.F\gZEp2-KA-?oGml*piu8RoD:\
ckBXg,d^Dsfs#Bkq&J5V52f<m9f+AUUiZfWgH0l[q6_>>NIk`;pigjFmI/,(7aiTCu[(P&C$
XW0?3mp(_RQW=eEM"po17S0.0B)*!?*or=&lpsjp&"sSe0FuI<.eQOEVV7l#VU'8]AJ;\7[X7
jBriTTT\u1S=(6ZoI[#7ArP1LH1N=C<1OF6_oF\Fg[VtalbIdAi(AmZ?ao\8724@l8<o/2I*
'XXu5Tj!'GkSo$Fo`K5/^8rmF>FQ*bpmh%Y$m,0?^U\\<?_d2&`XT@b#0A8B(i3pH77IX_\V
<lNlTKJ)/$:b1`hk1teJ2^S1i(9aPK`oWh=oLYp#!pbD"Bi),I6'a(JtEU':GE%F%o;jE@Fu
KehSMZ/\1dRBZGu%W@e+0lkOY3WK[?nMpZr9%T`G941eYM[Nn6>l+m'EbiT[\K:ZqC]A(:U/[
Tq\YSJhSZOe1iQe2'SEGgWtirO[_dK!*I6o1PRJ7EatRZ5P*3l\\0aS>l?K8&m6(W%D-o2=[
DI8=sj6$al*`dC$]Aukm@k#]A:.g4;++(T:WmCO93O9BQOIn=2OR#5TB;CIs)*e*\+=LpXgb@C
Vp]AK61E*@mlcI`M[kIa7]AS$lh>2RC"9jLW$Ca,"5N;cVd/4#"]Anf:&6h7f+cZl-3En[?TX8m
[j%.@YAXip<S>kWn5jd<-7LH\3oRZS-4RXS%bQ+GWq"GM6EMC2fojWoO)#[`6*5Oa2`m?Wdf
ob9pp]AT<1hs-uHnFl+>cl"&&%$IZ4(e%:/2Rh@Q(Jh;R^uQuEnTc>/X;*9:*trTm&?MIpiM@
fi^4hR/-'d;7RfZS/N]A;g.JF%8h9F7N-12YL-saMiRD<C@EDUStP[\pmgJO7+#6aS#"]AHD9h
m@Lu\H[d+,)&&^eSsMeuP5[L)&NkdGDJSj><hICAU&kqu_,[\=FY`Q2\!Q/>tnp/`e:(;!B@
0j0k,\Bt!r_mSZsa-%n$`i1_6d2f`7\bi$eU.=r;ir3F*f^6!D!HaK-U+cL0#%(+`4VGt([#
=aLN&508&-J%/)KY\BDPt;=WI;J(2_Er>AKFH?J+;Rpj?\,31<%rB4:.?1aa<#l&=Y?!-peG
DIAc.rn^45l_b_`/Mj6A1#\pBq9DP$6J%ZcE=iB7ubt&e@rkgut?a,,"K-t33=Vepr]AHc0VM
#:l:5NN#l2M^j7'.'"%%^K'=,^S>*/Xg`@YaZ)!6?f84K!<)?`BZKMOAmMo$8M(kK);_6e.6
`AVi\#1GtNC'EC2[`UN-l7aEt'6F*GIp5+bifb%1Q,k^H<?4nBI)48@s/n!5)nR7U/)(3B#G
JMkWc4_@[nY=ZC\;uH'qQM$8;jmhkF^WX;Oi.(S`C/>b;#b[7OC@D>73<l,HPOX%RgJ3>apo
0QSS<X'So$Fp*&AC?+R>M2#af;f*!-eZkD@&QPUMt3P`s'h*!trPDaR3clGPq9i&:.hHZ,1[
rRscM;fGhru&@/:'U(Qq%1Q2-_]A#8V"hr8o$12)sm/*t$WVZ$p1q'rXoWk",aPB"qb%%6mV2
m.flp$[$i+e9.'d[Z,/2DrUinu]A*h"8u*!-K()2Z@`#mC2<-4()/b/fM0lW^BnQRFm)>Nf*4
Z%eDm>*:''WU??pL\a/5M30t[>LkLnUj6*CmaVm%]A58a6,=p47NO5?Q/Vcr1_]A[db*8b[+f+
Fb1))-F@j4\#]AW/^9V%%(u8D%=J;l"n619V]AXRh>fL-hJjuh:[nMQ'F;YBdg.H[tu/:,-Dd)
*GVd\rOgf$HeM>b)`]A*%W0)+,'H%RKBr:K,=.ZpAHMNe"$5`.[$'*5qbsZSBaM1bt/$_*)b8
rF5CA-%rg[Kgg_'MYjn_L8(-&95To<"7KH'Cq+&N'J:K=7+[1;b7]A>4#[`V&M"1HqY1Gf^H_
T9WR!jI;<5u[+fghY*O*nU]A9KUuum,@Du&ZbBk43CQ<HR@:81A<8!,2h:@5<MA">/niZ9n="
2JUfg=SWOPc[)odF(L&i\k)/>Qr5Q_5?le;=?3PheJ@)W8.4k[9$A:q+.*1gY['K-#iFdg(%
iUW:cirT*b^;df1"A7nXaO![:5mF&,RD>'W@<Q=gcLVBRASb,@pn[Z*YO4]A-A"/Gpn=^s#Y_
g#E^HfUI%3o*O\9Umf#l&&R&NkP3Jt.WSBgW7eSJ("iO;eLg0N@)X'SZqA%uh.R",'4J2un1
#qbJ\[D7>2\.N)XRNkuOYTjpb`R+GqM81W\M$44Gs@64bL_1T(Ho!TCJgl(NQ.ABS=&Eif';
$n3b)"SRsc=3^PX1.LLJ]AhM]ANd7_.Y"PLu/))^T[D%XJpOiiSCSiVtdV)tUJ>A(85S^X8Oi"
q;2f=.&RfN&o$)ins*V/"RYD(-g(h"[lR/DD)T_DB#@97XrNmn4rc`\H+RLn#"YY!&3P:6,2
@Q9sS&58H<S%+60XM[HX>S=tT/#<c_2HJ!9@oiq6\J:24O(*e$R/$t'1WSEX-QT"(]AEr3I:%
7:$4Z)l^;Wi0_Pmq.8<sX%AjrqNF]AHW"*^VO1ocgisER+3`)<H<4IZO:Ncbu-U3'7pN=k9Ak
cP'@X-e47K!b8!l_!!rbKKBH3t(h(1W*TE^GYQ=^QfE>ldKG%GpJr+*u>DQ,f$diB`EWhi6>
gOs[UcGo=o*u-[mnb,GC,(kY/<3\#5e3+ITAj4D1.Q*gm]A-o>S7tO#d%#0m(m[GMQ<fauNBe
1+OEit#q3nH+@&,;=MOoMn;753B@53Md]A%)BE$@4t@.A[<oo]AL9A_J>:NGkk\3OX=Db4bRQa
iEI]AP#.ad)N1sdc-oIWBAej"KZ:F#!5u60>G^.PUHOX0]AZ&mq,1cA%iiOp?%otcMP<1O/>^i
dBu8UYtuE'PrW;?=1h1um.K54T[%`uO'*j'-"'%n`P*p/3Ua$7&_I/5""LTNUV>eD1b=+*sT
)',;pFSH_DPn_G,!97TT-\'>-ifj1<$2S)+.:`-pg;L7U9iA`&%B*=&If\Z^#4PH_*&gSQ^p
"!5.,E"n3JITlNS>$7Zdgi%k:`;A<TTN9[ke<h`\GS2m%M+[EePQdQr;$;%;iSU(_3P2nhOI
EM>/D$k<[c=Kj,.e\nVt&ql_DZ23*3RT2ZF<uYJ\;Y>ViU9#8We,6T3Ws%!"74eD\IFB>G.D
n$&[om;<c1$Uil"@'N.N=]AshtJ`/BY[R7kfYptbH+EQlri-Cd\[@n\n[365&!eh^kD3k`%T(
\pVpdq<13]A8h*no?h2A7hEf=OV<)7NQh#;CDM\g3V>+jJfV%cL\j2?AFL'3_qXO+eF4!*jRC
106^q/Xm)4=$F.,:>R'gd%%`Sm(g39m?XA2BNSMsK:r#IKE;?m<W<MQJd)48Ba1^'J[1ZktK
#LZ`.`FMFOcn?#'<<=2AhN8MYXD^<h.#qr?sAc-M]A*9`j0>-HWgV#;4qF]AIGK?#T%ME$S5,D
6ri_h^1FTCO\2'VR]Aq&>EN$.cTZTT0Wp[WkSMb<.M@dj4$j$G3l.j%)*rWu%9S%>\5e*AEtu
Fs)P&^oMEe$@AFZ=321jjJcC?FfOU+8J4c9Eb%!AGTf68Re-&g:$iImVKVfRK&[UI>%+<MP9
<6gLqZN4qV<%>jDaRb\A9P"m.L0GoK*r/d?c=I&XE9/D::D[A,e<;M-kB&3d(CbPCW%r-IG?
=r_1s-,n@mNP+\_OF?6YO@)^&jPTi_-n:8-JE9#f;&YB)TR0t78a9hK;0X2guPSD0oGRBB]A#
pR9XKe)jdI3nTUWp^V7116gmE?U6H$$S&p'io:a!_AKLQY`+9U;1M/8QJS7R>2-/</QG0$Ad
]Ag^e.D"TDAQ;P`qM?.aQU-"1rnqQ$Fq[/i`@m&QYW,klKcRm[A4e_Sr)1_dDEK)r-GI,X`+k
erHO,K+W6B1'(XO17qj-Og!FoR$qf-*Z)TRXWiAH>c+(3k5='lkIB/!\i-pJZI=oT*g[cbOO
.E'Ul]A&f-b:;%mf'qV@cn_JQQgcBP/C&OX6+Qr==k"e"2Gi!A%Ah-\MT#3KmQGRF-#jmOQ^*
K.+uNW=mm'AY"KArNffYZ;M-tGC_ESqH@)hqFU9I>-&>1T8`6?blUC?D++r02d\+`]A(WB$Hb
B6(PbBHXlG6)Jbr%GH11U?hjFF"$?SW7!sl1Cg'D[t&>;<//cgGc0'P9Ai_7H5f>a6SMj9qm
uo[VfKj^.j<E/TLXmaN"i`X?bq4WJ&!>F;8eX-95UIV[[?8*m]A$:::KqhjnUSAmWOV4`jT\)
=7\a>2a544<;3j_\eUh6os!7+4cH]A)oe;DlQ";X9o'ggkJossOj*Dn[WeFmhmg."#P3>i3=B
55MN6i!/A#PU+fH12"N(P_Ae2n]AXD@(G*=h54$5t7,b+gW_eA5)u#1+m[O\1`K_#KrbG(4HJ
LUfH(XQbj*2M<sc#OL'mDA39m4nK>*Q>s!=8Kj=l@9EFk;k5Q$#Et*^J$HE=8Mj"Cn"_Z]A]Af
=P(f,Cu7)'Yrl&<V*GH"]A2GWD([A%H%N?&L40.SU*dDtBhl\XYWt'5;.B$Dd"+9o$>nHeB0(
R7EK5Ps[>RoJ<]AHan[np$3\JBno<@pg#j1\_rH*CLOe*emL06YVE54>QlE"B1e9;qi3+B1!k
^qO.5lEt6nY@KmHa)_/+SCc?sReoWZ84uHq1QtK1WR+O;N"BWp.TiT3;[hP7/4jQ"f7ph8Qq
N.SV=XgAJaQ/3hERa>a(%V;+j?fa.7M5b'UTeh_UWV,ks$?N)=OH<11^;Xk/-iSBuZ52+G:*
p":P$O8=4>o^[WmNdGZ8e0chlD&RFk5$FjPb#[a`gkn^dEfghae5ut3bg+bpu"ANo^kOUS'P
073=6[r-Z?NnR`Zi]A?G"^cg)0!sA*iH:'!_;S:AZ&H1&lpCI;26&9J\VMK9$3t?<]AlbUF3Kn
-MZ,(sB_9:(fK,?5kb=neS@FZt:^'[Shon:"F@fmI.SOR>Ol>Xm.S21+kUs.4?((Ij[@%:%S
HEAmuo_c$qAqrpf,oR*<-Kd[0U8Fo]A":SXI"*t%a9&nW+E@<0ONX#q1,qkbd&cA7W+1E>K*f
`McD-Xj;jg5!$it).l~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="867" y="120" width="75" height="33"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="chart0_c_c_c_c"/>
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
<WidgetName name="chart0_c_c_c_c"/>
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
<O>
<![CDATA[人员主动离职率]]></O>
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
<OColor colvalue="-1222640"/>
<OColor colvalue="-1197808"/>
<OColor colvalue="-1222640"/>
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
<![CDATA[月度表]]></Name>
</TableData>
<CategoryName value="月"/>
<ChartSummaryColumn name="a_lz_num" function="com.fr.data.util.function.NoneFunction" customName="主动离职人数"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[月度表]]></Name>
</TableData>
<CategoryName value="月"/>
<ChartSummaryColumn name="a_lz_total_rate" function="com.fr.data.util.function.NoneFunction" customName="累计主动离职率"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="f45930b0-4a18-4c2a-afa7-9c0bf0b64c0a"/>
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
<UUID uuid="c525f713-5ba6-4bd5-b7d5-d0a172b464fd"/>
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
<BoundsAttr x="320" y="370" width="292" height="258"/>
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
<![CDATA[1310640,1219200,914400,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[579120,3383280,2895600,3108960,487680,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" s="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="3" s="1">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=VALUE("指标卡",1)+"部门入离职人数"]]></Attributes>
</O>
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
<![CDATA[部门]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="1" s="2">
<O>
<![CDATA[入职人数]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="1" s="2">
<O>
<![CDATA[总离职人数]]></O>
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
<Attributes dsName="部门表" columnName="short_name"/>
<Complex/>
<RG class="com.fr.report.cell.cellattr.core.group.FunctionGrouper">
<Attr divideMode="1"/>
</RG>
<Parameters/>
</O>
<PrivilegeControl/>
<Expand dir="0"/>
</C>
<C c="2" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="部门表" columnName="rz_num"/>
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
<C c="3" r="2" s="4">
<O t="DSColumn">
<Attributes dsName="部门表" columnName="lz_num"/>
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
<![CDATA[#0]]></Format>
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
<![CDATA[m<j7c;cgPRca9I<WPWcD<00abNjZ6.'bMtjm-3Gq<a*>VN)N/SNCp<FKW$'TZ9+n<k_Q$@@^
H1c;?W$s7M-5RX%alIOqaiaKHt"4&V4b]AODL)N^%]A!U3cj"8_"RZZ1T0oP5KY)IG1Kjo?-i,
Vn+3UqG,6dc:]AL6lT0N&%A(+e7D=Lhk4n_h>@uiePk*&`"J,*d(D`86BJ+EHq=#9D?#E?lrF
XoX8[`MK.Imr5knM)-%?S_(6lTA^+YP@Y"5Pb,,JsTj#nbDs:[&,A"r]AKE600fE.Geq7.'kN
_PVqc0:IfHgHCRtgG,i_/_:@A#ZZ*DG#im4.$*NUd8Fa*'"=_bD^KlK'%p'MX>SRg&$H>j[N
MsJZug;2q_1A"imN>:ej>ENfL=\*qa[[atc?T(BYD'uF^&MoI*]AK0ZL[VhjYa:N4u9t&XNm=
B2(i`^P=>5rYIj/FZicuNDk7`j(sO#H]ANe$ZLGP%App`f!'SJ]A%R%*.r2R>DE\ZVb'pj=<SW
p=jOS#Z\QK-\b_keQkm&rQ4\#_gnO"6"\;%e!@EFtknj$MZn:(B4PnlUh%Flpm$.C$ZC.)c/
]A_^FX5$2!I)=DKjOf]A8Gd8l#0N\/es$PU@AI5\+b35Z[Ri_tiC7\c0NdbKfXl(@L!4919*\=
6eKY/R"os85op`$%8o\jgaF"T@ma-*3-l[5gNAu/]AL^!_(Lk:-8@6$(,=[TiH.<N[j;aP$a-
Vf5Qu:UGG[0L70^Wl<\cPk%%nC`/2@"]A65K)_O=>CgEi4:U[,V$>3kCNT]AfYa<geACV*VKDT
`q%6K>g@ZFY#$dtfH_Wik>4qe!ZcQ.m'cm)W@;F0`G*&]AT;pfhMs%D7KO>0U-VeR@fW%8mIT
XmXdW=___bii!\U3<N_ls3.'Ai;>48Fc()I1X7un#HadhRm.92V>s!&V"_+4fHeLR13hnH08
]Ag;)CS\fYC=;[mld6`Ra&\\>4K`@C49`X[.e/%G`U2HP?-Ts)"]A4^uDUdBk^$uB8LA?O\Z_X
3X>+`=Q[6-Wng?1#8>%cm+U&U'>Bmf2-kKaR$12FJu%en;=-L".0n\rc'p?g1*U3+cO65^]AP
15qUo*&5B^,3Y!_[5*tJ)7=K9(;u\;PHa[=f$0IZS/!)fG2jA;\Z\M]A;s`?K25N1=\f+S(Fm
gq#8mKIj$i0K(eq'oV9>\T4oP^lM*/0ln6G2I=h8BYYJuO=,UPU\nm&;8&_@tG>bK,7<ji(1
'8jmpg8^sH<VK#*FFn7C]A7Mk\0.oAaM2a@M^'6X^0:aO!AKjK20N!M^ue5Dd5f$^EV7NY=:U
J=p3QTr'P5K]AK:<8kE0;]AW2T_,=_]Aa.c8#Cge*j>+JBMLN4:q"M.4]AM@nMo!`TQfs2G'`[_:
5GT<6la?:IC%iYh3Cq_#W[7^)eQ_kK/L1?,M"EX'fFGR)mM,aIcWAWZ9>Wr9m63Cl:r:7E"h
rAOPe*_7#>2*:bGg]A<(CF2.MaT!X*'/i5OVIOUD4\.[E6C8iL[pT^h-Vl^RYYu2sj$mh4lQ\
_FK1f7/,/ZJW;Ge$m'ppdJ&-]A_6-P/%.,:O=IT[=+Ksq;h`t=*NGB=\:[`2Bqnn=B?u&>o1[
`mr=$[]A9&f![am!Kp\7Q6'I`Tt%0U_$=r(]A,DmhqaY=;Jq>g'_?CQQ$+)5,/6:ljFH!E;.6#
^WdWbnaCA:&AjkMN?FupNHg6+I1:56Zq2Y'Et`6OrfE/io^f`9VC-W8\WW!iOm@1k50"-oOB
1Tg&'&!ggU=d3\JMWc;O"jLLr.PUW-BI:pIJ7JkIVaI;Hj)EJksd*:hQDcucoEcPnHaqO[=.
SHp]AHaem5QDHB\V8k<!SIEI6gq>iup))<(5?O?d9%^4[o;1rq7F:mm7dd^s.1]AU\NNSY$m`$
):K8*_gBR5L[lruC)Dh4DLj+]AL<CLqLSuDI;l;hpl;i@h'TlpDm=rIT7TcTqUXASh>GVW3YO
/4+28UNf@`"gNo=]AMtEQr)XFUbRX6S%lB!EO(Y-d)6:LPZ^hl,,?Wc:R2fCH-:JoW,ePgfO:
OCiSZ3?X1qK\nY3K?4)r]A=\p9Bg;`b.J`Da1LLM3d#&1mmO8da9]Ah\;6?P<!U;)D_tnG<`BU
S?2grj3Cs[VnWqT3TVV[1m(cJ'R*`6Vf^kVKj]AV1Fg]A.6R9NOnK<8%ZR36YF?J_,8Wq""gL9
lh]AUY/$/*7:sEVP9k7H;rt^p/j)kf8f7*T&"9KEGG/:8=_Bi>+^/%en!mGfP*+5Uk1H;*7=h
p^uWVGUPiG*oCTC$@L\-ZPW4e2@0/SOb?<'\5F(6RZ_I-Xm3F(%HU9tAO)P@BXhgp)(EOO:]A
'E(=%1NqjQ[e%t\Nai0D.c!bROcp!\7==S_*nFG'lkoW<J;'S$^HOW1,ggs&Sa<,9THFQboO
e!6rrt=^.S43!FB'NcL_-c+nC"t@g1b2J?Q4Gk'o/T)$6mVEU;5dC$mP-?FU4VXp,LT2QK1A
59T*UP&/7qkJ+6*mL5foJK"W9.PA&r2%7W$g\UDTsc9,I/ibW,X(XR\b(1=.bb\XFFnntia@
(aXVW'(Ka60'IrrOjR#B#A>fC1pLGH>!C0bDAN]Ab;am>XF0I.HbW]A<0o5&%9RAf!1.&a$i=m
t8IG^ont0h79ppr#Tn)/[]AG3<cu6M./hZKH0WV:P^sY:`)RHLd=,KW;Q6E.0G)mUUI1kO7\c
^%UTrTq[A(.p5trK>l+r;%JYR"itI:5Vp6!F3M#gLHaM1VO'YHMhFtE^]A^iUl8=c',$$L=WE
m)^r]A\!<tZV!AL]A>PU>F*>n"9C"gDE6^%"S)E*65>qi8DT(bcnBHuFRISsfJisjo;n>!2efM
_qN>a%RW-L<E0&nC+2Q*jh24[`nDONtrp=s75a>c76FDO+7k2#=%[s,Ns"h0r>!nh4Q\P*C"
Ss`kh\giB5kC,,_8l7#XW7FM16LW9t)>gK56JtXNRtm=W><>t_=0WXB`u<u!I@jS#j"quK^B
>RYAd+JB:a3aYLqUG*[4l)\IIVdFTj#sZV']A/"6$>fldh!p#^jht@bY-1KKTSka2CEMt!&K>
`k&^F\6CEoF)0g(:"`#kn0il\aQttK+GV;o)SX*<`Rie6(ps=MsjdNccf6AV4guSn+bo+Q#d
9p!A7X=Vu-pEk&G'bm^AE9#9]A)XRIJb9OAQqQ$sI.#^2r,q2^?MSHh!ah[KEF41#F[/*"Uj^
n:!GJ1gdXr\B1aQCH_DNRM]A'&kZ:#7k@\_hUJH&e4Q;t*8"H/P]A!Wbf'?;_@^O^CQI]A62mHR
YPq:lX^d+(<\@"hTQs;EMj?OgDSk@Zd^\&@]A2-SD5DO%P$i-Kh(Hs(7#12dkE]A_2O=dZM/_K
jok=;oZ6omFWjCJ!QpmB90M:8+b#6/EVdr=5pD[F2.#[]Ailq.Rif@)'j#edgt!S^T4rnQs[a
<>:Ma8IDe7b(>`2rk2=&h6DL]A^RD#CV*T2<;`,_5dcWD$_f0jib7&iS]A@!#!$W`dhBXH#Ti-
l:`[BSKD["p0POeCH<l@L6qHJ9J'=F^/;0P6[^<ab&g?.4a#"K&&F!BV8o/=9g(U!neK$-XZ
\NN<=c:m7i#'A1M85pM]A=j]ADB-Z$[&R(GW#dc3<?p4(a<GL)23\U[tb3DQ3>.q/1lW%&R#PH
\PJe7^;b,?okV#M5cdA/)#q6S2#ts_Cbm7OG"cc$4Il`KIVJ'gE^'Ng<)sGI*pN'[+jl'_TM
1Q:_krub@:c%ZXmt8*7"tUkF5L`?*iDRJ5jWa>VH[KT5ik'C9bacE9Vs+!24_2>NH"7H$`mi
Srofu[I]AdW-Z;lNJVHEYST$-Kbq/*qgj-;kpV;ZN`5"kKReoH3C]A^hR8GCGW)oI.d"eU>Eqp
j,\k$@>u#69Ko/W]Aaek^3Rd_@bYcU1c]ApOcA?o\gr$3b`0/u-<)]AYc?62>k?B(W+K;an9q]Au
hI/neSI%+"1D&I\DLVgHZA]A#.^oURho*HV`9_;&kNs#)"<5H)YCJ1tM^>]A&BkVl^#2n,j(=N
0s2,N%P#nh1XL/[n&Er71te"&%#.sR'ctd)]Am5):-$mj%2+A1\L4hl4;(L1*moML%a2UidqJ
[oSs)G@;Lc>TFVAr!YpT.U8\0)?9b2+#K`\@dTpGl-K.V:p%i<;AHd)`;!?/^t5!/Zs(kguF
@JG82n,-p&<&gan6rDThUDFJ&ZXSj[LobKAr9*%7VZ)o?m;.%cFo19hPW7DB;U<KFp=6GRtJ
qddIRN#`#N+E1eesiR(I=fb/(/EG-rbE6D4#<1F16Jn'Ba\QWJSrJfe1uU]A:T<U02SJEK9-]A
u"([qo=^.hJ/\OM."HrI26:+q\EminR'?LWN$8.i_c]At5eb"(F'!`6Ll!B1N*K>HeTFp-aks
>a$#^S/?!J2Z6^OA8V2'3_dPrJUeO\K;^?Jb_"AqV+6H=rLCbl:R\cG>jZo=[\D]AYo<&kN4b
/K%=Mu?>cXEAf\M7YTYMCW32?c%ao+<DY3WE3>b_ti5qAn4<.)1c:0]A^/Qg8`A^H+3l1pCh[
:?E6s26-d=#b1_J&hY>Kfdj3&q2YOT8AiFb#:e:kWmE3%RiJc'bJ>IR0h!c35mAjS/R\;b(8
gah`0$(7Mif.h3mM/r(V6;.aCA</@J5EZPd-.fu0$mn)VMA$I/BB\PQF/EAglWOj;GP_f.H&
Ze>N-`\L8G)"Eh4eaet$54o:%k@l6^:WZ.3^r?<O):b?K"K!,SGJm'Q`!XSTn$BJ>I>mNAT7
7tgOT'V@lEC6&./r4(L0W6obdGkDGjma"A_!(*^D>b1d5?o/0/)8bGD'L`4PMEk8_6gi+YO4
m*%qXcs?F%)[[%CT;mF/I)!r1c$UBrp.B^jrDK3SRai>mI+AXo$:/W>p%GGn:]AgT+<T[<ND!
(dM'&M;6qi:fkS\nmqZ9?>FuAnqE=2W8??FG\>U\f=Gc/#ek+p/TpC0,A,Wq1.K)rekOTRfc
jDo/#1CcE1BH^L)N'e_-<+p6U"&t.9>_rae`a]A?.;(YQ<41Ta&$Vo6^SDonC>=r6UDMF0._5
s(Z&`<L80.+Y!E3s=_#SJ.qFHmtd?3]A5d\+#&9D)s0<VsnJW@ND.K]A2Cg)INl`n0akXk>HEm
op_(j]A3IgF6D<*"N\np!Rh"jtH+0hOXOfP8e`0l'oQ"lF\I>uW&!R&sC4I=o=^KCo;/NJVE]A
ZKD@ibu!qla(Z2fcW#Xh2M(j0B>!=RD*&^h`1iFdWn4ZM_D)9V'rU0q)#J1`=Jqs(;:`!$Ae
Zs%p+CRNrh6T/uq!\ZIU>qIWf;>:s%<0?AT;-$Y=g4GtGiBU;gt)<*>8_NX(UgR_3.O<!#<X
a/mE&i7UEPLUu!jm2UVCNU$1QMHX[U/:;CADhthk]A%"O.V`!:P"q@ZbW@?u$Zo\+&1M^&Md1
';?Jh[Citf*p_hQi`;0/(KTOZ!^;KIP'o-A;cOL2sro,Mb4rs%uY%X%/M"aAE""dGl/C=kS3
;U<ajjUC#0F183h6QP[Am]A^'6N$SPAaMuP)ZJJKr\MP+@ah16(8H,VnGedGM@^^[Fe_7Ihkb
q1"]AXPJM,H^ta3$B;$MOHEN0Yg_c&Xa"I.#2-SpZDYi#7(Q1eAANS'8&>aKMl6\js_K1Qoar
<^.kZ1V=<#B<gHFG:]ANt*<O?ONTS?=?Y03/05)Tgj3QN7EI7bEAc^k(`Tc[:p*ar4rX!Z4X=
4E0qC+^hL7]A$q/lWj=A1jWDAhSEkqH[Mc+rt3&BgA>Gs-Zg-_)Sp!(ZF0OfX'O#rdGo*aX0-
NR]A&dL0i/L`,a,THn!;-l4=-_)\\&8c@f$e,GrH01!:.oEFf0>b,RA_2$!sTP8+OF>"*[(2,
YlTqB-./;_<p+bVQ7,:/hRI-K.^j2d`I9%l=*Scn/_kM<)+9I0EtTiZ?CTNub,bma9qVa6H8
!@KQW3#d+_VE@;*l/lUI(0HMo6?UTp)XZW-Jc5B4E<1NS.h(@8V+6\9+[MBRd]A`^?WGI8dMp
[-h4om;&MAH!oFaQCX8ghEC;M$*(BuZakn7,$npLH)bYK8Fj;#dBT!cG73KfMU$FRJ)ll9,#
Okt41P]AJIatgj<H.CF^^d%=ki=D#7'#/s"`H'kgs*a`CE&5DhQ"S!g0&fCY"o\Sq%Y3B.TGp
#TGC'P^qIH7&#[aY2F,Hoa"2:lMMXeS='YT]Ag%Dr9e2SVA9-D#e'_(UAk:U40\'A`rdC@K(H
6t>rK-5eF(>B]ACo%Gc=ab,S\8QYsPf`mW)TQ<3dV5WNSS=uYc/Vl?s7]A=T(c=V_Aj-H-?FSu
;igGOZA<,GHoc&3G3-^rI*CkgE@<AXZeJ,qA%)6C:P2&."N?in]ATJ+O0/f7U7i"Z=)["f5BE
</_bb/b-J(bfsg8]AdalI%'oCOldM_c5e;lUIMI=\h"I]A!L:RoG/+85V$@k_Ue1hKK[XZ1HS$
(T2R#d&TRMt[n[K*3+_[,AW+:H/&<9^8p/^j0"06ZEX-<WWA[hTObs'[5%Z/Y*0Js%n0g)ZR
FN)F`:7l<+'O@<E7h1^AWhY3Moj\,BrLhUNo_f_6pO+K>@97@sn=pu61mKu9@"XK;8Y#qA]A$
,4gG\C2n`C`5k6qoO3^t]A)[IQP7]AZcJK,i*]A?qW$HGs(\Z$H/;41d#5N^"%]A:e&[HLO'l505
qG3J]AMT4;9?kf?:/2j$Kb'qWNoS2Ac5Z?Y>M/gj!MG)+1_T%j<9XG=o2$b8CNKo^Io.R:JJ8
M_#2d_.!nJ)AlkWnY.;i;1a[dK\&'cAo*Pk<:1n)Rhbjt3]Aug.\MQ"&nS75R!!7`#PO[dKKM
QaF0m"ZI?m,DO`@2Sb*k1G\U*5f3=A3cbg_]AMXB_jOCU[Tpf"\=5^B6d`H/"Be6`G>/;1BF"
7_7]A=&"egO7U\IR8Hdbb;S]AGL)A4,gu0UXE-5^YcKkUu<WU[dt=2213+^J\TB>1+*3%V0XKS
U]AT4E0c/Sfdm_N@:s28+8JN?DXNWW=e6&+]Ac6b_)X]A+11`YfD@H$s/WMqU7[TFs\<KK`[\+c
%VC"c?&U(Y'HXNI%J*YUc/sh3WKHJ0\a.!&oG)UKLUl7F^rY^$&]A^`Km)iFMkKm)H6rKljfL
4ARuD09oF&uJg\c&bq!7?b.UlHb!?qCVuj7ekaKIf)<$gC''1q=hES<m\*f&#H4+Aqs"q/)&
^WQ17ODUW"_^G<h9G7ZGTYR;j)<TY;&W_3cca2)dTi\_oj+h+!uk[_hk6HYW&7$"ON3_:H+L
0)WU0"d;5Pg!rTk)q)0LH%lT-(67'T:"Q;?akk$WnLNBN05#f^"lJ$9/3-opCYPO]A[hAu^$8
SD!3i,Fr9:F'I'3>!bF=<l_TV*GHZp?WYGj[fj#W_oUeWf3;9cSIVf"I-%<Jl^O:-[G`:T,q
\:dg:>,sZZBDp5VJ`_Koe4YW*C`<ZGCh.efOTgGK?apdk\3p]Ad>m)=QLuH[.[ja2@7ad@e92
,\G\D@+TdqM))2.+1Q;C7n.X[B0DjFKDmC,!ak@lY57M"[>0J7\4hLSb/W-b>LG`ZNC9t,t7
SZp7]A_B_<D,92\\=58ng!OG""!e1f]A4ZHh1eC(@P]AR93X*M*BC[[IE;]AESRNiUCE?1J9S=5A
ku_O-:,cTo#pcd?aK4`&:SWbhbL\]AiE86ZZU5irr#u?OLh4j&MfU9CT_J>p.,!oj2b#`!a*Y
f-Ft#jDV3kLD#3B-Y4BrA>,=Qh/[@ue3B5uK$\=XObQ1tVMY0`kdImU_n;\*a*EgLED))DgX
?bQED<,.M)=&8T!rZfm+F)R:H<qs4es3D%8Kf?(I2&^FG:-DUoH^eS8F]A?VQ^jB1^.ac(AM/
q0H(F\AWL#k4r5uG_]A+_]Arr<\\jBW9^&7;<*3o-[%,_X(VS)pe#XQ^iG8)tPb[P6hkSKUrt'
m8&o[^Lp?G%f4ga<;e<D[UGGO-j4j&23^ZdG/akA_9]A8<`[f1$DmB?HpF'e:r&a&iL]A)"G*U
YkXU;EiD5@um%]Ap+>&f$"D!VmS?Bkof\IP"SY\1iANa68a)/J]A.XZMPtQhsotJA\RYdW@60!
<)_"L<-;IFi>S[,0Y)*]A*4D>_Gt;X/8G@YSBrUYo[@1!>3jm]AX(^LS1#l+BY^cs*g<-!C`/K
TfjMb]AX&fZ&dcrZ^ED@bf85/IK-F49RfLrH%Rl0^q,ZD5u/d-Zl*UEm*k$PRE&J:D>:p/D&G
kJ#7Y2X@;1"nEo*#U?;+;`9#e24_o/U</P.[??_'pR!n'\F]ABE+3:'Rkqaa_^G"P+gb7""<4
u6k'hB42?fjQ5%84i12oS/o/<M"h5%@V%P[RNt@oGG)mS!OMthDKEsn#Z,*KlbmX(0ksU4bd
1<Q8/g7%i=.Udn5l'X_>W3$cns`/n%GChQ!$Sc*G&_C/Z/()35aG%I715+GlJkT.Xr.<d-RW
=t&d7-0`9G-X<bsp/&`)Ah<nfQLQsgIjW%kph^$-9()U)m)#9YPYt%c2l2E@'N"s]A'A77b(E
:,qm+i\bCl0\UM1SY,6:Cl7;d-;XE7uB%j\#g1ppNe3?1:?_nOIg_Sck/I']AFXm=NgL\c+P:
7]A'8/PAF&*.W@YeW_:ao-OD(tiN5ZFaScc2>`t[#^P&_MMhlETp5"ooXGAl^-8H74u>u*frK
/qFS.hW3ke=cr'Uar=N'4mY1.uTbj.pDquSBgtJ4[B.Q>R5S_h0*S-NdSfB]A(r0b\0R`kFjB
QtAGqmM*M(`_fJMrNB[%.V`UejL[9f-'_=ItIVR!a%UKe4Mo*noIUF+LVjG_N1bR:1$4Ad5n
4r@#c-u7'>Wn!Gn-_'%Cs1U$:,@7R@R;>%;s!-d.^Mhd[<%c/N\UF8N/\<?u1$:gbB3If8=L
-JPZ^3+eO#J0#2<X*q3j<d!<47s<D]A,6OW[?>DVG1XpFG_u$k[`,L3#dEB0D,*j*OuEe1JnR
s0+(qKr4f6(/[fD6Y8V8n4n#@c?(NcNF<eH%['7FC79LfcHdPeVES(nYb.<DEmN2+Z^mGPZo
XQ0Y[Vj/q5K='h[A8<dS`bntW)B-!r3fn?#rP"`]AX!A_3Gh7_d5iF3P9D3Yb>6[@8MPn&<_u
haI.lu=6e9&=mZs)/D@"<6>:?Z^^%MJkJp0$g.*K=iL9Dh5$s]Ai'[WpQN[;)lY73VGVd;54D
58&g4\D8n)0RllO:lU:Y?dXq?Tc=Rrs.1adSZCs[[]AJ?D;qtdMh3Qqsi%!BiDo+#)^C`?HgT
80!>h1r^Ea'Sp-fb^@/o:>32aNeOa_VAW[0t75V@&YS+2ttH^SQ7uBoX&GY5?]Abql\)P5Hid
YB3u?%`C%A/^Wl5alCm(`arC1O>AF(nE>dm7CU/(]AC"Mo;4Z@GWhrmg]Adp4Q*Cu(?.^O6Y/j
DF!:agh:N[O3ne;EctoZdV=TRtuEg8'kU$Gi%A"hC*-i*uT;&^`1DH1Jtj<lR)\kk$Uu0i_M
^tr\'MdXZ8hheM@"ok.*tN]AqK3Vc73nQE$H_78`KV:_eGIr)k=R1=T^6+M*fFTn:4dY\M5OT
9n69mOkeGQ5N9i^R+Ha$C>e$m(M1IiK6HCrD;Eu1nfqhX*U(Z^ncQ4Ynq$?T51DKCg%Q!FPc
Unc]AT?[k#)*^o4*k=p,35#A\NP.$3pU6ib?sD>[e1XW3uV%oF3V=f2_7Yg.chf$/O/5(\'$Z
[LCN>]ApEL8K5i/GIM1/s:gNna/>`cKScmNqZZ4eueb,\8$"O&^QD12-Wg;9er/X<G-n%q;$a
nSWCa-PuK.Rrb]A.50R2h]AX3kR$+Rrc;/7jj<eso]Ag_4X5EUAi&#\!M5&JnI9=D.6''AO2Ru/
$PP4(dd\^q^Gj=aFcItJ7n:n,Y-1i&+5#!9!;1Mm09N*#20$Q\W+Q&J-L-:,.@(mm);$2qsQ
kLNPM\s&rn\/&\B@c<t$'i5J0I1J!:G3#14%f`mtXC0.$.U=Z9QTGjC9ltfN5-$h^^pON"qc
dpn/S?Ek6+1fe8+cVtA"4@Fr<$n5&+!E3%k-DC?F^e#XB!E:QUZb`(]A;?P@6sHSW>'SgZIQB
@&5I?o[5S4cl\3J#;T84m<F]A+l#.V>9"a!sP>ZZeDFjF;6lhS3$R@PbGAOYD^%='H/*8L(CG
N$Da+R4-nZ_u%[6,e^.\Ahljml<"KP(M2K,D$f4"KC3-c"O=UeH4'bCo5$Sc-o<$n]AZ%;mZB
lm(Ir^oL2_((q6>(?3%1),n*,@p9Z!O@_sV(F0De@gCD.V9$DMag9`4MEM6Ft@U2D:>fBliu
CPt[u_ulR2`>#\L4#N1moL_@cn'7S3&)(ZteLTbXT'u_bTq-3nkns>mm&T3I)[S:\.>Cco"(
p2iJdHHSG_:-th=e"pB`',o'B`PJ/*FC=YdL(n2$s(CEIRR+Hh65V?]AJ1AF<k&??s_B#[,hJ
6D-nT"ao&N:;`X`P8QJ`tTY5B&bhEgr+U'o*$(-:g?5;;-;66;Ml%.JMn$64D2_:roN5EB2$
!P\nHI?$A$)_3k$EQ[5^=0Z1K1]AZNlo3uqLRho4',ndbJpo[8g$2HibZ0q1D:Ps@7"rFf)tJ
VEQ#GAj\eX2mS*of%F9R6'gk]A-X&cim1KU7gWFB6BSGD#&(<ePAU2AU7l$4I^c;R3l\NfsWZ
D8637%SgIGG$sYrR;'T_TM'S_A>6QDhlnZlfsX96-g_B2QW8\/HWlhoCZHM-fH5R87AV>BW"
;%<,h8ks!Ni$=f`49P`_p&t[S!s.6<^Zg_i8d!(g@OhNJf]Al9H]A%hAY>3"3POFBE\YQBk"tI
(5"2*4')%C3,^Y43^6*Hf.GF-=O':p0.a^]A-Of[tF'D6Op&\E;5r;=L"!+5c]AG`%Mt=YTA'^
`UN,hE)ItHhYf@f%-qg\K@*pM'+_J<(Y8K)f'c[^?_6[=^f[AV9*fN,SOd^.Zmq!Xk7:@ar+
k+*guBA;o>2n4Qe.g6hjKqeVR&34K$G7Z$;a\bd)$K4=`uGJE>Q&8Z,dWZ#B2UB.)%$g&M$_
[M(D>k4['Ms&/m!X0\M.1INX?C!TA^`Tg!F/h7`$gcTf]AfZkE$R)2ML_:5qIaPH<bhjh2m&P
X#);friP5*W5`Hb.d&<)nI".^O5G``\HFbYD?uccaCVEH3<1Df!!E?'<l'q+E%d-YI@r5eJq
3j=(t\_j%ibD!=.m$9VeF^Mo"Mq^fn;c']Ao(R3W^^?I._\63rC$U^X2K<gt9pg:a)jL/""Fq
-)I2AG!!e$=//9[J^bFj?>Tt`KS:DP>aGoqDq3Npc[[Wiak)*8S7QQ\7kaipAN$US;o_rr%N
k5THgVnZ"jI;-3&+Y@-gB'QMPe\Aed_flR28l89Somc#Y.,q2l*U[mT"uNfG+WqLYL0Bih@V
qn[]A-oA1W2NI5;Sp[\2gCRkEW-itk^=7OZ_qE1Lu\FeGac6EQV+\+qdhDrf[mf>mUiI6rQ[_
&K+M7_2-X(5k#qE(GU#q&`0B<OCKak-).ks9'<5-JCf+Yb;5gKtaJeWrW$IHr)B1Z;OKGLK/
J"H?KX\9RNfn,OZ.mZ1OGY&iJ<U;D:"Q:/>!$mCm=Qd(dj4%PQu&eZ$`XX;X`13YgE&k"cr?
'\:U1K+$%]ATJqKr#Vm%O!W8(o.K5c$]A^7HSalB-+-W.:o="Rqlg"3u";$o^[5uG0@Z/l@<_\
U_aqW$e.-GS-D&p0s!LA3Wp>!F$FZdc3BoA:2,7Z'2%d^B>r5V0'HcSSG%l9^Rm;K=P#P4"*
%Bbh:?>f0&LV*8AHS,o)jqB*nJFtEIL"'hBd1&h9M\?o?<pk;7aE>f'O^MaZ7\Om$dF"neV9
b<H\gHRra>K"cd\DEd_^\46[j+b=%5LD8qqQ`8>Od9BaBL=DOoEcEdQWoS:SQ"QO1hia"0aq
s&RfEK^[dRm#RjLXDfj?Mp\l91#X>=4r4Qh"mI&ruQ[p0IEcP!5kO$YT?)bhk+$G-tg!uUEW
Q:^leVplAk)i>Br]AO@1NjSf:D>=2XdZKVri]A[0=oJoe^>$"@dAj/7)H?<'WhrK#1[J'5Jr.#
P=KotQrD&Y9hY,!k#R3:erquC9ZdUZ6`Al"b4J.4BLRA>4D6juLWFX5QCoWtKIq?Q4IjeUa@
S]AQk="Wngh4NEaX_C`n_rbijDWsTBqo)&9#N*<RZA]AI%8+g?WL,ecdXId[4jO0MnRpF\0Kjk
9rQq-L@sq2P"@43e)4<obLnB)'_ca@Ycd+X%0ug&7Q!U?3/[]AKl%JP'&iApZ\qI=k*?L?1</
@%m#\LF$2Y+,_,\9T[pU@`-o609\bd*pDY=\rQ5M&U5)r'OWWcT:UXTEmZ="4Nuh@]AOGa[ml
<1*5p<!E^=+As!+F8pG90XOH\'49t?ss"nbb@kuY;2<PiXC;u/")?K%rdauoRj,8Ihtdb:HM
Y>",.9/=fq"9.Y&>.#IAX-^*TFE>W3[]A^CFFs'mqAZjPeB,j?o^I862et"IkrU\W,Cio&"<0
fDT/g9lDH524Y#QhTOr,%gK<jC$b`]AoDTJ*o\]AT:V6d+[A0n9bOm;m8pDP+K&cXUNK&L'A7=
$=C3tct5lo%a$Q%C.LJ&qkLZ,TPnoX_SR?OBB5mRXTF(&Y;GGP?m.eOj/j*qn,'078^F("75
I#ND1@9-RL8Rb>H*K)+()H1.R77[n)G%TfAH:Qt:fg!8A8>F/Hh(?-q:4)q]A,[dNHgh0#kSa
`@f!k`B5kaDm^kmm&@39\'[A@%Up?:^nBLWlsh*IAlU?21^;IE=brm5G*,,[L%d]A,`NIof_^
eE3&8VPa4_2-$lsU>QjSn,7SE1eThIHmSkTSJm,Or/X(*UUrgU'kkoMM1q\.JQ<)s*]Ab;*WW
V`'@bQnON4<I6U*EU(&2&RJ^U$CT.(OkIitAkp&s)-4%"Gn+?T(jT1/>8%!Q924jqP3:>[c8
Gd=Jb6dCA8AV'L\.i(^k_oc@c-TFj)8_Km_R%%cEb./[A5#slQ%.t,ajidRt14n!WI)SY(6Y
)-mn%\rWfEY?]AEaIKWead?Okmp*V(o5L3+YonJS3o"p!6-?uf:R+BT@%'4<oD&4uk9/@;3UX
aQ2!H.Fh@H\WAK3!1KL0+pLF4/&8n;.q<4'N`m'6#B%`9dJ3]AVg0;+_9fAVo*5Y_.YHkrj>e
95/Be0KQk,10rpl%(<6EeX3+'#*K4DVH?h?&$JMaS+\()mc3M>2=0YKiBCO9rYk3hjdAoU`W
O#6$O)f$-A6mmCX?,+J4`_s3<Nq8Q_8)(3Rr>&*_R%G8BnD5pac\a&G!Q9t]A-]A.U,Tn:>C>u
&"XH1E9Pbg1U5(G23P^V6WG!cgJ>n]A3X%#U<Nc/fE!t+t!b[3=FQI?V^d=+G1R-ehdZsf#jq
7Z-Y@hUrGrpT]A-&08P?p&/]Asri[A43J.n8--iWnLC[L=;Imb$Z@mnY$Fl4Krn7lf\2(,`;2N
HA'kR=/KV\EPldf:#EcnA^0^=gJ;(3=ndXFc-&2IUIVZEsbKCL6jaGAKb$UBQ=M]A-X4!!\:+
U,!H`+dWANKmg\a%B*'WA$)'G$Q,4V.n+E*%8o'=n++nJCf\UZo+p&?PJ%tU7E*=,lN_T2nl
.)hp/g1aG\QRH%OO)!4rSp"+/K%J4L1-p(``BFcUEoqYTg[#!&UHFE-_tZAkNW1'@,V;?9Fr
F&1+NQ)Y&Qu#^A$3%kUKY3_[!IHF\#sn%;``Sn]Ad7%7_.T+tO*c?Qd't['`0UWu)S1[q7V'k
TY`ltAl["'ID_W)4U$8D'GEAchj(V%'oDj_3Eu%3+D63rWFehR;;ED<oE(s'qFHS\@Kh94i(
fD.p<Ra]ADMqaqohDu:SBMZkXs8:\iQlec&p3J9u=u5S/Sc9-<0+K&ae%^>p!PDSjm\Q\6V:^
lJ,_;Jg+ce5Q5qK'%Bp3dbY8J.:W$-1"p/a5sTVMK2j=^'H[64&]ArH,Gk)QAbVRGT'4nDtaj
W@(&FQl'V[kl6`h?7L'H3rl;r09q%9-;R5f0E:nAb^u80XbSpQOB;1:$KhmZg.7Q]Ar`eI&Li
U'DDS"!,jC3/]ADc7,FQ++%?5^jtTeNW#G\.ATU0#\0_-\gF8-DZl4L]AXBU:"4@oA20J/H#s>
bkRd#LEX9&en?nE.UrK[WA/r5$H#sDdkS3:eFUD-GIt.`@lUF=e1)f/%RM82dY;YP+J`=?W]A
V/dVLP2RF)5`LFa2;8O:<J;,i0_]AEJ!P78K_u5c'%gtkNI%<:(;l/,jFm#lDN-h@JpLsort!
lG?%?id9lC*t%4;/18J%qGnk]AiDHtTeqMYfU^9/,]A1&=cKp>"BbMP=n,Z"?H"NTmP;9ICl35
5S'$1[r1`V0#g_DDQtONT.",b:q"@^:&6!moH)u4&cAPja5S0G)ZT9bAGDP^0SYb!UUKG^(/
QT(RU5U>);$-R[p:Nf-''%[7h4Fc*Bo\=+9!Am+4&A>Vl)pG#g>W6?8>e2C<d%O%+3U1l/W[
W"mOT1n,Y-kUa01+Z`W;TKGk+bob+h,E4Q0BL!=)uS)+B1aD,7BrBL,Gh=)ZOr;Y%^@+KB0+
E&a"D;or=NCB?7_)gel#7EMW9]AfkX*,9OMQW6)05UA5O=nl9I751,So8nc\$#Bi.rg7oQMS2
2\DUr=9J$8m$g#CJq>P#]A2!<~
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
<BoundsAttr x="20" y="370" width="300" height="272"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="指标-累计投入工时满足率"/>
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
<WidgetName name="指标-累计投入工时满足率"/>
<WidgetID widgetID="a9b555cb-fba5-417c-94bd-463ada77b43a"/>
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
<![CDATA[975360,151200,1127760,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[396240,7162800,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=VALUE("指标卡",1)+"累计工时满足率"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="指标-累计满足率" columnName="zz_rgs_rate"/>
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
<![CDATA[len(B2) != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.RowHeightHighlightAction"/>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="1" r="2" s="2">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=MathGeometricMean(B2)]]></Attributes>
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
<Style imageLayout="1">
<FRFont name="微软雅黑" style="0" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="80" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="176" foreground="-1197808"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;;cgQNa&MH;_UL39%[,n]Ae>pU>,1e:M,ajs5/63'70(-D$d;iHmW"F<0KZ(;o;\_ioRU
W=Z,,I%20ss1n"`eFeM$>+*W):o0NStEM`$?U`4O60aO27gKk:X8>jl%;_A[:"dg\^o_n,%O
JD]Ae[.f$\1p)>n#15etUq<k\?!5euj0!<H-M9Rd-@jJ0RV]Ac@ZgmA&9>I@6LMUurM)a76iGT
ATIJpQ0n)mXdq#bahJ]A[kFmZIstQuaE#;'Yfo2QakI0>QcQ'/n()>=2"S%#ao@n"D"PlO1$@
E<]A%$6S;FOmKXWq3%G9E\(#t<e'8btV,P-"2P*A%PPbdDk08Nco:o?<B.;%]A3X\o.ML[O`X=
qk.nT8XLF-/O0otoo>(&c=Kaca-=lfQCkm?@!kREW\?'eEpd)Q-N<@]AS7lm&frXP_QfJ=bq%
S34_bhXte^0bb+W8/Te8>O85BGK^_8iWY"k6;T,a>TkMRq$4MHV#:$`-;ZN\/da4$kEuTd;P
'odi6Xs'Tml0d<"10;->$nFeDO#i3`GphOOi^Xo7l>tTGIY$tD%MQLi&iT,EYGs"P8@[L]A.A
tdf^("TEd_=+A0I^Ufu%CiFnQCiH63K_$-s,1LHXD+gf#uMs<(I&:3#*S<5`Uu-URJed*V,\
51YD!bq*MRVIbNiA/,'=-ubM1CLXI#Y*0O$cs/r>I<(Pu*;6`2K+2OE:\l<7"N+@iJq6s`K0
,*PW(5To5(eF4d>,0OlLl1mhXm.ZdPkn->dT8;`!AudDJXg*)R.ZkKP6X!Zf=G2mH"&U>Mq(
D@_daa#LBP)Dn\V\S75AI`sEH'XnElq=F*6dh9nP&2m/R<6aZEn^-]AmK7e,gg_/X(r)$f6-8
V&k^NVU?b?C650mj3jpl%=rlGaaQYD5_tTm"=d:^4,d[,Eem5U8/=B-ioV>7.M4s&?[>B6O9
1X3o3p\rJ%EI_c\'4`629G.n$r1Lt2HP]A`;B'J!%X).qW6<NJG?:)dY&/^N#I**g2O0VAaeI
WKL1]A,RBo04DW^811`P)MVF)S2g'!#+b*:6a:!a-8@@SpAp!i2?lM:h^BT1(qod*SB#fpj.M
Lp0f)&^K%54digX208prDm%>G/Pi/]Aghr=YgdB2ucqNWq7(r^=oA;ac/C@HG$<nWQ,-MsEqV
3U6e+[gB%>?YD]A)sU4%Yf\RcfJf/"3'guk&&mpDXpVGb;%5.f;HVu&8O".T:N('!#Y]AY9F#P
l[-uV<NIB0)4hT\eq5N4BeuF5hOWR)bXL?+VQ)Z&?l@PZcD[/<7O`L90:(8L94t!0Lh"QFg/
QVCk\8%ep,I6laL<FM`GUL!HqPPnUSW3#Ib]A%4P\Cu=Rrg2'.I[kW2KbN-P.H1*/rKo]A-2#G
LrhS"Z!fmNbPNNu]A.:0*WrO+3_.in"cZnFY"S\?U5spJ!$g:OJSAZ=drfa4"m^&)G1'fQiD4
9T8Bf4XAeVd""\1^\^u9q[NFVrq4$p5'+b&@h3'=_=^<D"HF/#HMt#=b,Kc]ASSTc3=`b3:N_
lCVZQJr5K'R).QR8OQG2A@B6&*O@Zc+#a=743*H@3WJk91l>h2[7Bs3p`"FL4oj80r)e]AC^C
>3sCZ$VDPFgp:hE8_sUBl:MjFl7Bp0qcUk\&@;R[Je/<`B+5uao77$M`mOWp[Ug5/np%p`uR
SpQlTIRjT>Hm1^:Vb^Q+A;OUPS[3C0o$A3)C=Uqq]A3-`2qn5aiBBs*V*)*sr>gA.L`(H,49\
=\-Y=rQXY"f`lfgcg"O;]Aq&gAF"e)ia%<gG\^XUkiP1t8$Vi$q4PI.S9@Ag=8/HCcIqYJ+pd
kp1Y@"aL?MH!rQ:c1(#*?$@RXaY^>(U0nKs;h!T7I#cb0bdM$\`Kk>qmO&#3i:M3P_i4O3.l
XV[i&A5C:<>]Ak&<?B=cjri%45shZ]AZU'[0@E7no6.k0G7%Y\RDk;+.3/gp`I@3YG#`<46cK$
0C_Xmo4\q;k>rC(AJF36n2I/MObcbg^L%QICk]AK7E6:WsKf]AV/QT(A?P?d[4^@3i&$jLoos)
M[+0#SMBoTfIO>qVS5o&Xao;<_*iUAH[n$rf9dLEV;.?XTOT?Am.)#0_^ED9*NTjOc&4:0!f
BZfc'1S;SaPmG[:4(r)O!:K:+U[Pi"jI@_NhhXM]A6Y;PFu)\b-;3Js!U0lSuL;c_A"1>0d^G
R-":Lbd%C3rF2J+!Bbo"d54%]AblQ*(DQGS?Lt%@s0,KBC4f!:&fCJ;"qOOE@gu3`\rU[.;PY
W3>(j/.(il6A^LL:qUR&D\[BJ#^=qqo:$3*Em27MKpLaM4G8Dkj7q[5_Zp9WB@P3V.TXs0Z*
5fRTaXoP]Aa^:7/9e@&mq4OpbT*oOSErO"/:mp#ghF4I40ojfTFr3RbQ/W,0sfp=G2<G]A+3E(
CK1H_hREYSGm:NDBocZU>uGE.W]AX)s,E6fRF/eN(lEkcQeoK1r%@?nQXCGr+$,!Z5*iHM`cH
EJ(blQ81'H_gRUGBY$dBnW"f"j8jF;md6=3^;qn+!L%g-;G$mL9fQo0^,<'>Jj\u[aqHM871
GioqhmN3<1PlujOT)';]AogeP_FoHg/.^I2,!.B>2Z?_`e+#VsU1h5\!Jg$)-?'mS]ACDuiI*F
P8SjK5?\QT[m-V)2.)*W\lXlDnOAaJKfr&L/j$koT=*-=Hb]AQf]Abi#l.4YQn6_;C,1f^<pm5
A4j<iQ@%.O!,*#]A[0*7oYL-K8%a!:[AR%17>SKleC@p*aG.6c#R7NKMdaXJ5'<LnHG<X>S]AC
D%AdiY&^k*%9[34C$$Y9;pod]AtIhAJuC/EDKX2V+P_eKh)3!t&X-iqE;Z$Ip;hosH5\Piq_<
s)*$=Ud"HBiHOd-2'^#4^N_D"<Ten*#)K0KT%3YGl`O_$OZgG(mVH%]AfaL8>!gbXYkB?64ZM
5F+>/QQB&d&@fpLQ\'#HZ.=SIpQ\m)E?$k/FrLi"Mq\#=aeAlGK]AcJjkA'M5L80f>_/39Z8P
&IBX_2_ToA6jqd3gO^ZaGB%?K[(;K87MtQ]AlNta&PLP6mRO&Zb2nIeO5c+N`k`0?rkcL).LN
M^5;<Z8+0dfMMXn[jC6fDB)g["%TYIN=)i1O?glte*:6ubONNe:J4ho:N;)i5NprQOMQ*r<b
J@?*PtYG3Hh<St'>Et*p]A=`)=V&-[F6R-aY`a(;W]A55r3@&YETg4,]A%V"<,ku7!N#K$nGJ\?
1?o%Ge"%*]Ag&>l2If+aiEKNI9+j;pN5&C+7Bf(T$=C20eZDdBm(iqn8afger!`i'c\C"L-#J
pJFU6^Su$M2Lp4c(lj&fT_PS*J?"dki+_V26h*2C=L;"DXtu5`L=s@b>[`!8s#SP-)N.lIrn
so"^=`crs+"%\8diKAcY9.]AVo![f]AH0QsTt.@pO@UA>10_t03Ni[hl"`u?^fe/tE6DBg#$Iu
/$V=NJDU8O"+3g%I=O:_;9(PabEV11u+]AQ>ID8<b*G7.n<qXk*R_9?*t,h=qfqS.S-$M8b]A!
TXEuk35sd,LL;nFuHHBQt]A6fp!^\d48P\C_p[i`#usLD(dl)G^e(Rk3k"*>S5Zp4X4LPo[C\
QgD4LQ480:Tk-NtOkU<VCL>?o'%NMP5K6Y1"UI8RcF;/,!AN2E?I$P<3pFdt0^R/m.%#J@3G
JP50-.kW#ncOnr7T341>#[eOi#Vb7L2U=)t!>O1o"WnQ8H,W`foJ+@Or'T?.XY@LS!Vm&Cs$
&eUd)Fp"G!H0ac0o"+B">S?^uA.8XIc02!TjLQr?MZ0U^so2NoLMEUGVaA1g>H?kW`?.d,T9
lD63oBl'?'5,ThSR-SqPRWK`\+qs.Dm;jMJQZZ6T7eHi9iE=!iTABY%dAYO>Egu[9m:snUs/
@.>$q\sLSB5R\2.+4XmNIEDoZts)8gShEd,!3S9f\Ltqm!.)jOKtUEAJ`.aVT_Z(5qN8PPg%
M2<NSEn)M%C5A[:Z`Yfm,kKM+ibR/b>LWD&;p6c\FV&BPR8C+U6LRE`<+Cqi&>6G+;%ih^co
]AIZd?H"V\nSODA[S,$6c1Mm8o+$RnUWD?Ho@XC;K"`f3]Aq"O8[Lq?Gr\7r>cj+MD',A:A-2J
Zfi<(W(n)a)NV*T&:hUJ]A:IMj"c'bS@^98M!.N:&uJ:,((uf273]AcJ[2fL!)V[.\F8o\F+!p
4^hS"f0<KZL]A<Usf"*hFX<QXPaK(Z+\67%R:7L`\++>iT]Ar+9l+TMS#JWpQLD-80%&TX(!8r
U2tWm,_5#<4mu-2,Y46=WRAEdaiQ=T-&5UUhV_CWZX\&h?,r]A,BnN8`Vg3?LdDi?L]A1-fpW\
Wq_kOA;h@Y(;!@q_?7gsUD$<&6(o/'JK!7HHE3ET:-*+t6):ih88#@%g%DZ^"$NS9'I*W_Q@
^@a]AjI#p<FIVmrh=^V!NSd%W\<sW&G'Lk\-gI.2ib?5A,akL:EeKmpr?=cfm0"%l+gSOGrj4
WXGPosd,c*WBU84*)1p2]A<i=i7X*Ca257FaA#"gU:9e5(=0dPM]AJ#lNBJO15H>nSnTA/bqJk
dgg[5;dXmYo$tY_?,f*UtGC.+)6',^iZ?sG!`i^Bp)\<uoSmSVcIEH#N80.oS?Vk&T:VT^4J
UI^Ebc411<es#Mg>^!WOj`:g/SktVgIQ0$qe';2aHFH:k1qMVAbTP/;^kC7Es#<t<VT%6c<;
I':YZ6r1(#m+?*?b2NIVg.E,GVGiV[\<b73J6MKJUSE]A%'*LR"`O!1`I-F%qc,-(9H"US0rX
WotQ5bX5LX,,LtBD\P[$:jA8c#Mc-E]A#Jk0QQ/#]A-:%hI`ImU*l]AQk)cL5Tl+Fsuo!;p=:pd
J(fis5qb<XeC9]A/(-@pVAL.Y1=p:b-gC\i+QJ>5QGrpNOt3<I(2nd=O)+YP=Z43^g;VG87oa
XXst'SV>=,bd.9N#)hh'o<.g!+g*>#Nr[L[_ZI3_=NFEK[W%]Alef)+=s`aM%?\pHApU<&IYs
*VCaX16f5AcoYQ(b/75k>3WQMYTD#=,Ig,%NB)j))K\@cug#?82=)>"l3D&fRNT)/bdTL'1c
'FdG)GR0a]A3m7>FM:Z^VUM\/MW"DZ%$@]A*fJ47(RqF'9aRCQs&4D0Pf)g4Z5>2RIPIr?5<d"
mkTea<.f#nTI#TY)3EQ!JT@?h5c]An-@-PmGj5Oq[3B0n-Nb.S_GnNXC<6I@4mqDs4W+6>I8$
^Jb<FBer*f6MYh`j'oK)^f&o^I&>is[U"$>=X7G4P44]A=iS<Q`a!r3'+i-Y8?`h8"t3%`:\*
cf6]AhA<9MIds&PiEVo9i5rrUOmhb=ItDP[_L$j`bLd8m)2OEDK,)GW,L?_Y6rMj&[TNCJ@Yd
H(/#a]A38!iedTIiq)20.8Kg5`H`*TGli7Ii#]A]AhTor/+gKW=n*_E$n;.T)!BH(fH0\A0<d;,
:AETb>HF9d^4B"Q[]A3,G/a^n%*0q:"BhXoekm>pR1k`J(((d-=ud&>(h*H5SO(5\4I6>8VS]A
'4Ak\iVe+Z(AoL3NL&KfdT_9@oF_I@2I:0C5`nWSaMnfuqce./=2(%tScn8:d@:pL6qoad\I
Vbf99t2Xm4?]AY:9qB'WPV;"i;=/+,%,+5#p@>\MuF7C>lcOn&.M;S!\..2F@Le[%I+BM#_=I
>:h8-a^!eVu)\mo%HYpaU=&6K7l+R*#~
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
<WidgetID widgetID="a9b555cb-fba5-417c-94bd-463ada77b43a"/>
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
<![CDATA[1188720,2407920,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[396240,1767840,2621280,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" s="0">
<O>
<![CDATA[事故数量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="Embedded2" columnName="指针值"/>
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
<FRFont name="微软雅黑" style="0" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="176" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G-C'6fo.Y1Ij+GJa1Jg:D%?h6MIoKl0g"'d4j%NOPm#-.m%5FX;7nBkbb*>)@o'aP>A&``
n/H8iGK@824"O<V!MSPSu=/[07#*#`)>W7`8^<UdGd30ZbS]APIfSMQ$d3d=WbWX#ER1%qL63
NIc&KKj7@\Ss-9^Nc?Naj"*&=#1R:21FB)T$]AtCkbH_12`IE[n!b+<o*0!9HXZDC4T`Kce9/
QlF@ZLO^(T')>6DXLe6[,]AOgq;3i%^[fDKRl^R^p-VWhrVlEC+4%;EIOTBr486ph@u&O`Nh%
DaJ#X[*r\K5.ReA7FU:r(H6;OsTU<qc?R[qR_/F;ct)-(b+;cW-:SNYh/;^f3I?u$M7>tYiQ
=DV:XDmXL[XJ@l,Da(6^o%5g/huCI(:\IH.^<JfnnDTW*$i`cs_[Vi"*^!b.ABiKD"<ho-bA
-FZR6UVCWlTguYM/#rqLmJdk]Ak_=Xo+(fhEY*%_'c-Uf6BfPN/Sp.5KWZt:A`TOh^1MZ@=^\
8.'cm-"W@9"45S)jiB'T7QBs9o,**3WF9omT@0[t)2#Sp%HO8uX4hf(Xegf'DBV\>Oj.C&cF
n!r"#+qaNA<UY4'm,rsChB:*j4='cXuU(AnD)C'.`K5AZ7t<*$FO5e8NXRg[qicuSBSq*PK#
t<g$/-+\pAh)Q$RLEYT'a+J%a.3$"$cDdtOhps+O878!?!JZ\<Kll[Q;V.R)4N@lP4USfY7_
'H]A:_/u`MCBN=Q!MY8$P;X6$=h&+FfL,:)m/Ktt$:6UT2ep+N.@>scTUa"WGQCRTs`*-Nr_9
cnSb2FY9I+P<=IF3(H>69(ImQo[T%%X;355"<o4'c#=C:FL;<7\<XV"%,i=J.f2C`*ufG#%K
;Eh)b.?TM[4An$+_U&R*ckPCa,048"pM>MZ9As;aS%\jJsS^s=jLVe*FN-4ZEnOBk>T=n@@.
+']AFCo[.GR@)*dOuNMS0Rl_RRg"P1KO-^@ol&O(h7]AGPqs03-&2*PiD>@__qdN%Urk=1Xo!r
m,IRluKhlCttoZb;Tbq@7t7m>1Dc]A!#=KNDP5(=fqS5e9Lf:>CUP(f$5]A1Y7FajdT1]A)buFV
J,?8E16SF=XM$6K[oG#(N7V_-ST%p'G]AC]A2eDb_NoM8EjA&!F:Y/m:iF>nK:WNuIfR9!>cm<
b:#77\'@r`S;q&i<W@q1Neurpek?@Qng-F5b$2J5r.Ol%2STT8VQhL;WgIL*!Y\7Ia$<FH#a
diY*[KS`ItMFI;SARo[")pgX7Ekof(^diHL?bS2a#/XKe$r0.%H3r5U$S'J5%hjtE?"%ql>C
f,n1PSpD5GiQT`pgRom=UlP0k*sE+.'<C'k9I,0YJGt!e&CS/@Glj_QXuVB/+WQbSe`pR*[$
DbWU>nDh%l8Nos_g[/X#E(-j*0n\CL5)JUXn9<o1:\=+:(r0sk"6kS:mef&%B0':mR/-B0_'
&`BVS./kD5^1:2kon`@_2cOh:(e;2=a&Lh`.^\U^mtR^YEj'ga<(4;fSnk94e@cTF8";[%[>
CuHK6Ug$[VT5KQm)HLVdZ(Ud>"#Uh+fGmF#Dh+4nMDtXkN^HUk_J?;XZFecOR*8C/77"T9q2
Z^[CNhg#2[#nthr"K5$gsL,bh,4&a%]A6,WY&L!o_"l8EY7@n+Cj3eCk;a-Cbo`#m\a9i7[#G
YE\rZT1/=_5Lq<:U/;>o`\UM@[Vk#8,j.NGa(:PB<,r6b.S$u\2N;N=,h6FRe3Oi+DG=>T=/
Ke%Bpn?f9[HD(^+l_.RQ<C9(dLMYZNhGW]API("]A<FmGO,+If:l6lO(Pfr\gBSkI!oUL3EB2p
c!`W8/4if6`XED7_!Pn;hk:1JW=:`ZbDmdeU)3r1F*NS\a7-J!e)dWX2m_F&`6rAJq&6"W+m
UFfZSYUQ\T0O,'_e@hI!]AMN]A+7@e@JDfj<EUt)#68Ao\(82")l"F^RXUEP1RbP88&YlJ1I0.
aIk(Vgp^4Nq51]A@aKi_?=mK)cje+$jkRE(StdjQdBHr2_pm_cY,JiorT[\7#/P?rjD9.i6(=
r/L3f9c(<4,CGh*1h2ql2;\=9^ZNPZ!&F0#dlXm(Ts;BX\WR")8/*-]A)1%K_ulXo5O4?l[31
=aJ#D2=n+,bHL<2R`G:X5"KI\$?e@\#W1?d/,)"3Z&c:!/qb;.?44$u>]AKmU!SOT,J>bR_rZ
]AB*qI!XlA_,=0]AdM"h&@m'Z8!c_att.olBBptiiY..PNl3P#?j<cF_Bo/JkD'!SpS3NZo2%L
.+DdJ$*bDpbH@l^_YgHP?:/+G35'.p<*=H5jqCC3a`%NVD@:j=4JX\.LZt\ZJrpTio+$@O\k
k&FUlgPD&C$I&)Zu$oH96Aeh,k9$IIM/Jq@lV1XG?/rM8]ASr$R^Xqs?4$dXBfh.;V/70X)E)
PLI;Hp(^cZngLj#ga=t>jot#R&$`t&b$E>N.*aV]A1N-#QfgP@U8pp&bBjah04Nktd"LjHhWh
aW(7!bjjb.-E2]AqC.C(?<@QFR%'[VTnC9\VkT71gB!Onj?BepGo?'?UT@!QGe.qsDJP=I+hU
WQDY6q?(2Ze\:H_fDG6g82C:-_kJE>TL,V6Gq.5[e!L`(s)%odZs+5ti/HOW"JZf)r[O"s$P
S%cNN(NM^>m-tM2F`Chh_FY&oWF*DWR?QoT%NI2d`^IJ=b^Mc"Tms"1XgECW<F(7Db`E"!bY
[p4XU7^C!L)7D7Au$;GPV,cGWQ"qj"E(`5Ub/\e:XBM#aS.bXn\Q\U@/8hbK#_,Ab_KlY"fE
W`pVn:4II5NH3<5jBA"_*g2>G2b%[@)3Q(MRSLs_P%EuLJkA0h,e0d]A\GOB1l<AR+eeML1el
IR[n1eSec$:#?erp&D<9N;TtmES:k<-fb"-@;S^C<p$o6f6Q/SEc(sHSij0bK.Zl#NHLmeHD
!Q3U+`,]Ag1[cPf>[2r1aI\nZmEkqWGo,VoP5ctk!K4q^fA1PSBXHY3D;DY0`K,<S2fL[2'o%
YVVJ@(meSBmoIdJ5jOp>fLa"7*c$FQAH.>olaN;*tXu@P`pW/&@%>Xi^g&I:tr3BK(JW.NsG
NOTdI">c4@)Pn]AVk#Bla&K@`VLnKY;F.b78KW,NWQnSTK*iXMS[#0g2QMs`=--oadh^s=3kE
ApHd+cM&3V`m[(585``"]AGn%WHIR3.U:(>=66eA6S)OFn;^,[ChO(#Ct"9[6JL9f6sNid?$6
si"r]AVc+;u"he4q@t/2]AcfNJP82Gj%7,"%0Jf9j?s'[qS><h#Ii(I%/;!T_fnGPKPPb;F80]A
T$odGd"mW3!F6(SG`)1rE*4)?!TY3MN6E39Y#E,g>bKqgbthgdMd^F"N1gSaBL?Z%$]AGrd3V
jt[nN0k&9[G)GOT=!,i=UN0a!,FO@7qtVV*5"=Gr;qLQu#5<!kT%KWL6IDM%E7%nc-SrU[Gk
nW"1)YX`!?3^p=4l;SW]AI%_o*MI(L6,]AT:<6`&ZVQFWHnU%89V&kgRQkRH=o7D$1$/_]A57mr
Cmqam]A;MfO!5&_MQ[4hkQY\nEmIOVH.U\:m$,J`Y9bU^[4rNq`/H9Y6NI)g.GUX!V[>uu?#3
,+(/82/">)(+aLO0]AgD+0\P=>:Nl>AmsW/@8u.]AU"mLKPoU3;jX's0)gb]A\kh"PMAEq33X7!
8Ds%Q_2oO>CP$]A6R=]A&i.L#"?;M,Ws"Rq2CY>NWc`a`NNqs?qh.lf`1LE^.#K`+6/1)+o:Qr
7!gm2,m'-7_tR+tW/.lck"-Sii;V'0iiPI,>X^0]A"]A>pRcpU`NLi!Y=_[4$Mld3-sTH"KIr>
,2mnJs+d[W`S=i'%nEQ&`JeLBK.g!&<0#6)B3h'iPp\WR[.0mT.o-DS+H,\(iUJ=alTX*N`5
P0F&jHo3$$bSA8,\qBM'q@-0,ABEO'+<nG_2<?F6O=#(J\6)+FW+AB'_#qh!jGq7Q-(4i93Q
)C4TJH))@!UaPFrA/;%YYAO4b'iNI*6MfFal=Y0/8L-0Rls0ST$AY_/%oSdFt[8HR"JD(D$t
Z[qOo3'9<&q@sD4D!6ttE%=1gXJ^='4&#8?3FJ&'L-`GT#6F:S%nTXN&a&AL"^iQ`9ghcL]A[
71E<US_!aa8SJdu%d%@kbe]A#h(E>VLFcLP2:<o#mnVk1F"NaQV%C-**V[mIFHs09:c2l_FtG
tGA,R#"]A9eJ=n;\8q@*0'(p[YRW\@$P_145U(@PrQYCYs2:7(D^q%21:E3mnQ,DNH?`bl[60
M!H*"_gi-eIJ$4)WMZko'N/:BHppXY3#WZo6.*9Q&Sr=hs$\k/CI[FU#&@kD.LY4$XAVO\U^
PQ&XZp:HNX&gGKsGGU8',d:k0it1\m7i4#WH&K@[ngDETg1jNe't;'o5"97!B:'$,3&h_a*E
WKu^fIa6ogY5iaUkr%j1H`#Y6"'e'Y_saulkF8`Ei-<V'A<YotrA)VYTQQX0Qf6k#[$KH84o
ei4>4iORXY'bc(Q*BB6\/?KdhtA$GKu/+kC4]Ab;EZSRW4(c9m%0+H,SmJ;N'Q4k[&S"_B]A>0
Y@?C]A:\[-.dX#5>M+2#cXnOL;JmMf1YLaMaL0Ggak=p,s,.b"/c/"#mmc3):Z1n$pWRq!.&N
8g4hilJA2_6Mg)?_A&q*=`\;&-A.-@hLU9har4rVG:n#oJ`g^JP1Y8OA<.WAOQ!%VHK\)TF-
k:V&;Kuj"1Gt23%Ve=H5Pf!<mt3Vh.:VFLqEJMKRlCW6.'jRSUL-bLG#)ZaHco&80(2f/JQp
rKOM$S-F'I^24fd^;EE+/7`1S<Elhg3Y*ji"pI,b1_m\G>k9[U=AF,F(L6'65qB/hG8Qis,P
4.dpX<MpE"dM+(ZncjJT["F9M?g70udk]A$(PEO)cFDV(nX50.6+i')f&GR$Oadklt\sdo1ei
O2AWh^eqV/tYc)D@Y"!&3EW*j9qdP]At8'U%HQ6Y'.1#M;L=PWOdZJ*i5W8LU,1=?3;rQ5E%5
F7.ULe<P7,cZLQ3/BiqF-at^qm'0PO59NB]ALa+=-%C"]AE'co.hU3f<C"H(/3s'k4h$OS?\b?
t)0OABn=5!s=#&3+PFJ]Ana&`Ycel1bH))@L`\H!(^A>m2!r%Pe+rI4FANOhgmp&kMO>n4lSl
?PFhR'h!>$/aR<WRg(b6i&9N$pDl(A+8#?`3*p=/p+rmRA&IlhLZ04jd@no/F/fgQjC#0!V.
c'Q`CuIs$?LGK%3j$h:+=dNh>s^pBTclL@H7.P7]AY+dC4l]ANG%k(&%ZV#n+N/=^>q1_G^''?
EPm6WXiSd?V0$/QkIXThsEQk%ds1*/arR:f>f)Gg~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="958" y="10" width="186" height="84"/>
</Widget>
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
<O>
<![CDATA[公司人员增长情况]]></O>
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
<OColor colvalue="-1222640"/>
<OColor colvalue="-1222640"/>
<OColor colvalue="-1222640"/>
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
<![CDATA[月度表]]></Name>
</TableData>
<CategoryName value="月"/>
<ChartSummaryColumn name="zz_num" function="com.fr.data.util.function.NoneFunction" customName="在职人员"/>
</MoreNameCDDefinition>
</DefinitionMap>
<DefinitionMap key="line">
<MoreNameCDDefinition>
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[月度表]]></Name>
</TableData>
<CategoryName value="月"/>
<ChartSummaryColumn name="p_reg_rate" function="com.fr.data.util.function.NoneFunction" customName="人机比"/>
</MoreNameCDDefinition>
</DefinitionMap>
</DefinitionMapList>
</CustomDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="c57a152b-bd84-4f15-9ab5-9963c3f97bd0"/>
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
<UUID uuid="00a8e269-f087-4419-b880-85b8cff1b60b"/>
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
<BoundsAttr x="20" y="116" width="287" height="233"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="chart2_c"/>
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
<WidgetName name="chart2_c"/>
<WidgetID widgetID="98fd8a48-b10e-455b-8109-5add380ff46a"/>
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
<![CDATA[=VALUE("指标卡",2)+"度累计排名"]]></Attributes>
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="5"/>
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
<OColor colvalue="-12080918"/>
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
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
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
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
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
<OneValueCDDefinition valueName="累计人均投入工时" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[部门年度累计排名]]></Name>
</TableData>
<CategoryName value="部门简称"/>
</OneValueCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="f7615585-b308-41a1-bc77-7837a436756d"/>
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
<WidgetID widgetID="98fd8a48-b10e-455b-8109-5add380ff46a"/>
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
<Attr lineStyle="0" isRoundBorder="false" roundRadius="5"/>
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
<OColor colvalue="-12080918"/>
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
<FRFont name="Verdana" style="0" size="88" foreground="-10066330"/>
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
<FRFont name="微软雅黑" style="0" size="88" foreground="-1"/>
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
<OneValueCDDefinition valueName="累计人均投入工时" function="com.fr.data.util.function.NoneFunction">
<Top topCate="-1" topValue="-1" isDiscardOtherCate="false" isDiscardOtherSeries="false" isDiscardNullCate="false" isDiscardNullSeries="false"/>
<TableData class="com.fr.data.impl.NameTableData">
<Name>
<![CDATA[部门年度累计排名]]></Name>
</TableData>
<CategoryName value="部门"/>
</OneValueCDDefinition>
</ChartDefinition>
</Chart>
<UUID uuid="64631e46-1228-4af4-a061-3f0c03e04ca5"/>
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
<BoundsAttr x="958" y="116" width="186" height="233"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="chart7_c_c_c"/>
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
<WidgetName name="chart7_c_c_c"/>
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
<![CDATA[="部门"+VALUE("指标卡",1)+"月度工时投入比对"]]></Attributes>
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
<Compare op="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=max(round(value("部门比对",9),2))]]></Attributes>
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
<Attr class="com.fr.plugin.chart.base.AttrTooltip">
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
<UUID uuid="b1397d91-a89d-472d-84aa-9002fb3acf82"/>
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
<UUID uuid="1bce83fd-12e3-41c2-a576-37b540a025ca"/>
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
<BoundsAttr x="625" y="370" width="520" height="258"/>
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
<UUID uuid="5ccdd27f-4ffb-4f60-9e12-0d60515574f2"/>
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
<UUID uuid="b0b1294c-b208-4841-8097-eb86325a15b5"/>
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
<BoundsAttr x="625" y="116" width="317" height="233"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="指标-工时投入满足率"/>
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
<WidgetName name="指标-工时投入满足率"/>
<WidgetID widgetID="a9b555cb-fba5-417c-94bd-463ada77b43a"/>
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
<![CDATA[990600,1463040,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[396240,2712720,3169920,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=VALUE("指标卡",1)+"工时满足率"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="指标卡" columnName="zz_rgs_rate"/>
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
<FRFont name="微软雅黑" style="0" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="176" foreground="-1197808"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;;eNPJFW@:O_6glX<Kp1\[C.NGqPka,<"Z+LRRZ9=JKTT&'SHfcLu^:me^R'a.Nqd,'G
-+rLk$*M8D;LD,XQ`(!I7(l+hWs?#nTFDEpfVWF)0Abk@?/*\(]Ag`.VBd:ZhOImDuY95J)Bh
8LKj[g^Gt]A$C"&s(hY@*HXja/l^eU@WrI[?5&Us:^dX1kg9fjQS\:-"U+_.0TD/A-je?;4E^
-7.LGTQA7$J,@:jKria8=bcfci:*TV:bf#gD5+:XKq0A#+(R`r;ZVk:5=U4H*Tm:q('+9J*?
9b/5;o64kER4%7WlX)-2ZGgHConK1=M$?fVX'a0!38kJd71Nn;P$FBQ<J:ioK[I;.8n&!Crh
BcIB$BH%Y)^^[?4T;6HQV>[$qrq0YHj]An-j93fP8:H&1Zkt0(7&"InA&mcJn=7!('3;,<0I"
D<Gd5Q8%os6Nq'kmkHjnKM'2";]AQ*-'ao<6h#iD)#>6:WB1N!>MRA"5WmTJPEg(CtH\)LJV6
XZY5fU!mR,Ts)m*H2EpWjG'7E<I<oH'iTR4FK6sKTE-ltC^8THONF>2A9\p?5b@oe93?0mZ$
jHt1=R)/dpD(hnRd$5HJHLb7m%r2fRH*kR[/B$g>0.;u&dB1!&'*=PME13FS"_MQ^24q[]AY@
*\e@hZ!CUi.G.K;k+jP-)snjA(r9q(<eQ[UUDGbZ'@7[1gshK6XBBG6O+\CQO!:nmuKrkQK[
V.2I>T9ndTfN\>B$11!\i=h3JmdW`2%PFtCn=o>QYNgM_Sr(5K&Ei9;f:'-/nH,+96egc9R\
A/]Acrrg&Mic90Tl\U+ln,7G@^lYnqjTE4o>R1hG7ubQ9:Cjbc)WQrKd3Rt@tmYfi?)OsD-n;
SM0Hie_T<C#H:)jT,dDU2?)Vc#gS?Y2-XK\7b<W!Z/`bG^bNB(u0og4s*gfQXDhph.c)0=PI
*pbNj0r#`k"b\M.Z#]A1;Tu1_E;H`P=;YSk<E;IZ-<I2RS4JX4@YgDCmiC[SLA>^2:..h,p=5
<=.!m5WRm;>U]A#;nm;>Jr(^tpJ[CS<FQ)/0<9np!BABc0rN[(]AY0OU!ng*u%J[H`SJC/h@WY
oHR*0$:SZ;DOj.&Ipuq6lu'uY@cj,HjX'#D=uM(UV5H.A,6po6Wni*;lCm,Ma,Y#5`tmJQb0
6#)fC7V14)^^7PrV@[FB@B(mO`ak?pW9O6h@IJ6A#ra.J`ccSZmV'_#=\n^%6ik^duI&3%"!
&d4"Af2cDQa??g;Ga(.c`N5-LSa*mS6@S%da+M"iB,.lHO]A0'ZPrAu]ATMfT]AlEISBcn@ksH%
aQS<V"amNaXa\:BAk0G\mmLK14Mpq0K?<Sc8FKs?QG@+M^,aSQRc@8&O7++[L%I`P*8Pk[>f
"raX'rjLAgmOam-/N^aq.^)anW)heo??Fo8I*PP&nZ'1(u^ocD6+ZU"Qu^N8'3Nd]A.6-^Pr7
Cf9TO:.dVnlm#^\j%`TsG*0qds,#9D2Kr*P]A6G^[!bL(J)s(U:nPGou@'&X2rKA4VA"ApMm(
9`Qj[ECYX,:Ar@D0TP<]AmXg>n\jJV[=ZX%OGDd<>h.5@/bd%8D<4M/*j-drSSj4FjGob=d0:
5duWRlmaq.:F[N?70.Da**kX(B8;Xaf,"I-[&GDuD._F($A*0g_$=R7\=/jlO%-I4%C`$%Bc
rY(-'T>N4Fa]A^)kE9c3P(HN^EO01Xq-)FclURCjS^*mZg'^#'auq+/<2[9]A+@Ei*h-<'Y3[&
jEBnb/s@IMLunR4ccagV+o=!B1#I4St:A?KM(XcgLV!L+4$c49ftM<DZO5LOuoq='*t-O4a&
dhA>E%Xlr`L`+?if18Ubhf/Rc-V(894lINr7$>Ni^>>/X>#[]A1\mYOOf:PSPrG;stI34W1+K
a>F:Zrd+98mk]A!tpO+.?e'HC&@@EFG]A*K[R:jUY,Mj]A+9^*Wqfqt`>&A^bIC]Au%4h3#99<V>
uPN;ptSS2iFb1N"<X/n?b_]AIF29Vs^ZFR%MO6#O?LrT#*\C+Gg!C^.3S!`a8^#deAg-Zbq]A`
AZ,;l;I&_!"')j4Xsk5H6;suVkd""1#M53(D%imZUVmAAh:C)&ON^j,29k9CtWPbMV!O<q@m
:ZB^;@_]A>;mg=qTX2[r]A9+giURqJF^]A">,c;nJV_K/J44$gqO7I6G^AnN-\H4:"j'&!_K+nu
#!:Nu\@rjK=Gcq=QM0+=SflPqf>3S8l8cR,Y^DN+C3fXpaV>TT,p^+V!Hs&d$fj><BIlfc-7
"1Z.L9J=$MXfFD395fdZU^cgA>88+JU;!#F,S.&+Y)IZ7GIW.,3MTIE)@_pYa6K>Zj60*/RK
?450s>U>/7r9%cet!8G_B\E-bB+-8<+"8OSu/)D?$[rHLXCDCi3'ZP%'QoW*M??XY6G/LW=U
,lc8)Onhf8uCeJWb[sd$i"XL3qMu\_.hjZV&/M^f@4X?[m/ki?M(<N'/H:?RL[PQPjK/<itR
+]AQ,CJl3#>KiaH=k=d*)V<7pb7KM7P@Qb`V">^?T0aT6_[K/6)6a\rdQ[WRTPNRgKY/<.BM,
:BcOOe9i0sM?OMWD7F??AM;agnH3.+J_arA7qi,3DPZFZ/s]A/TIqP_l+=m]AhN_Q+>pFWWS<f
3dOP=;Sor+S,?`O3S;oS$`L.iqggp#*?_`7RuWHd]AE+p<#Q@S(bt[-[@ie,dlRh59B'"Y:(7
`o^T$g`A!rq"XK-^$?ULT;FO)mHaQ"uU5LZ,$kJnRAr\[tg&2G%nK5d=('.c&n[QAO`br*HH
a!0_[.-#sG(cC#C+04]AgFgQKMM0j9/KOrIU\BpG>)eoPcf?C17HtP6/4#l0mkVnpBf6TRE1i
4H[A<i>R$\%(`:\:O>Q]Ak:(1"B#FMFm4_m/mfqG30TC$P*F1ElT1JPsP.A8pggmrjL$/Ac!%
]A<&0J2H]A1+bTR+/.l=CgirOV+>m;9)WVMf!9=qUER_M(jF5`3)H+HZP3#h!?oC>5Pf(oej=e
XC4mqOqh_X@6")]A,JLEi!D[_L`W"Ua!&\)VJ[=)O<tm3ZSV<r)89b8GA4qMKW?L-*ECL8Z%.
<F,:/13]A7/s]A"gjjb=cb?6:"=:'bq6#+O`DC+<LFrX!/=Eai`'-4Mb,:Sk1Q"$nfsW"N30:I
"r\iDZ.t+'OD$cSqcUa?F/7,Y&oe8`2J9d?\&*&$2$K\=K8i@lW$tqqHg9LP<O28OgY*LTg0
oF2!jOYdn<--NZTC5cIaoK#+TXVD@%1DB>5d9dV3=`Q]AX8/ZXoZb2P4LdLusIS\mkb!G`I%)
T6SOP@3,Gs5C/\#HURVof<4>%j;<gc:?O.<dQ!*SQu.F**9ZtN@JQn?\C)5^N?%p>"Zp((d>
`kcGs7;n4A'hR'sp5?U03A.e+Z%*LfR.53m+%X]A.^sakNKYs5[F;1\AS3boXlfu**N>8g^MQ
1VU'XOM`]A)LWS:+AL`&,:.cZZZLU4p(J$-.Oh0HkWLSqX[=/R.qG64rHdhRXsi0u"$n*<*%`
:2e24,8c6V@F:>&OSNd\PI9,?Zr$.>3s0Xi7fe7&o0KadNMZn4^QW\ZZ4WL"@':=c,DOt8V#
J_krdV3=6ZCBbgBoTfAdcrIFW^0r#/&l0t!)#K(tJ@4Gqq[0*upW2N16=O\I:$C^65GVDqk`
aPfalJO]A+6PMSZqdQ1-1LA9uKiE)IX;U5AFbHH33`@IolTeY?LYcmnXe$j,q,2[]A-nW^#(8r
9r%48(sX:GT9&\=*V6-72BLg!h@3cN9,*.`\gK1tLKbCJcE/rJ,=gd'g2)l%[YVf`VV4ju(%
r3&OUU>Sm^daB^(2'tXZH3[NTog;'.S^!9t3b/6*IRdL50Ql)`b4u6an>AticYhA*F%`9cX@
T"]AV=J;,&N3Z;Ni%ISO7GqlphGrJ>B'4+G1*tfjHFl&=Qn.&O@M7@);ftU`o5Y@X21Cjg_3b
t5<\"u,V1H`J2j/s$c7MWUZ)aN[$?%h8>0O8INc*lWLfN3IqG(WJX3XnXN%8c7H49t)PHf^S
Xk6!!)%Y&k^<D2'V%3)P"'4BA]AYPb"fT2%JYJLo<=Lf,CP/Nfpp"J-X09bL7Do8IC\I/QC9T
]A9$+`o<<k>6D:l(/\l_%]AA^F3YqD$B=^EAgS:UNuqNV!H^<e*0MiMe/Em+3B&*>oZ6NhKCa)
O2$b+%[rJ5#>'19GEd"Zk52&?)-RdY*A,IEfJP^j!Au>!b75%:=@rda@ZV2R=G[jFZH1#QP8
:3:L-rlPCOeC,Sm^!mE[jhaqdVCT5cl%grBsD9PP_=--#_st^rf53E26^.JK63"M)i0+8`/M
\UiqEK!4LXFo;AH8jDt(9bfrGU<pR`a:lZ#4b+.XB1\q(DIIdQT9]Ar^<fL!Y1"HBua??\Y?S
Y+D*$8,TU!l\EbAUiWW<,gb(P1."8PE&g1,iYaQH`u`DU7#Hbp=PNq:lY<PZjI#4-c!^8rQ^
!HI4!ATR+7b^Gn^l=&0LlELQU)$&AaF,%?ngOK;'\Ic0<sOfBR[YZ42f!Z6."p#D:?0UU"aF
%nI+mm@ih1dSIp:m:Ma7a<SGanF=`XT*DVUhg5J>U4kj+(q"turCE!g\qLL.S@dmPi7cfT>@
6Y3EmZb0B?[i=1%As/,Ep2:(9fHRRNVq[Z^GT6ACJ9PebHp"e*T->!;U]A0gp$l1652?cY;a[
.%D4\Dk[+o7MC]A99'iAKScc`?'bn@$e_l$?@/VZ9/c'mIt0*e-&T!Q!6\D,.`Y=j8/D-EbiS
!l<t-qSjAT<83)9Q8=R_%`T\^c3l]AmH`0)[A:*o\+k\prF0Q?4F??n.Ui",a@94N<-rL=Xa+
;b/Z=CBARbQm]Aa]AP3Hl/Ml*T5\gk8U('V*9@#nb0>%KL:m0fqi6EXYRt5bZtSAT-XL%&8kMn
')qD6t-XlA[e5A+:7MpV,,&1Q"'"hcl76Cr,.1>TWlP#_*I8.XZ/k()ib?oi@i>PJ[c(%llE
g45@r$#Rhfk5Q-d;!Z0!nh+dbQH21h>HSKFE5fNV,#+Q7>su03*3\$dkg>P>(PG=QX&7Ae^a
).51CO[Erud2:o0AWVsdR)/*rq18#J6GjAI>QQVK@57)%s6Lrh?ujUQ>")Jk3CR`1opW\^5Y
0n>RB>\>*C@,*F)jNLm*'1l0"`MlV+A9Vd9#ms(lG2L[SpQ()-\p_ibW9&2s/F,KZXXS!Q!C
7lfP2>+2=obC:,9ie4.7\]ADZ7Np.FiRMkS+e,%-!0?LCWi2H'F5q#M%oK-2#k%ZYj&JHX.=3
3-%#!)8DG3J4c]At#:"9;O5ml&_DV?MEBiDr+loQ,Ki)HM;FZ:-qgJu#93f/4/4CW&__^+iQl
5s8F/l=YMV7$,[ZRAq$.!8-NrI.brJI*&;QCkKN70QLmEJsX1DnBL:(FJ/t%bugFpFE_+hBR
URk#stJpg-AOM3>sa+$bksrN0EETi2Tif99<UD[]A8io+a<$.YdJ@eO-Tb81[_*1<HB1C*d'P
InuK-+!hU@7Q#"Ukq;7;%$k=aeG<F7dA4Gr:p,tk'1G,\&]AQV"(cTLA@mssjs.#1VbfC@FUq
,0FXhVJI?cZjPTr61!5^6SUR/9iYY>'3AIp%b\LnkC6T?Bj4M)*V*r,2Cl*?c,&HlcMW'>h1
&q_*;(*G)_YB@_%?XJD8nL6oF3+>'aCap7iH_)Sb`L!eAQ\;<8>3&ooO'hG5t4FXI]A*i_E,Z
pSIPGqubs=4)0*$LXJ`A[e_BVFu*>/WuXDD#N4:'[<qF&DrD+d3u;5d=q-]AT6`2(acIM!0H.
M`1)Q8sDo4'm^)\iAUf/V@.1>Ya\b(DO0a4I(3;mT23obqU>Ag/T.kD+!Qk,NOr!*be-cU-#
bo1+tDo7X'n&@74;PMX&[PJ1O--^eVLL=OXfm8`I19]A&P]A_8TgrmeOBFqg3AeQD!f,1W:T!T
:eN"*NWHajV*HVqT\,>l1%rIkG#.I6JF[_(LB9-+49QPlOE(X#<&J%.2QZK3]A[;pHWQ3STr\
)[HQle5E_&^i_&fEKOHu=L[r-JisU+-]Ak#I.^ZG>.;p[gbNi:/M[k$cf"B3V7>)t=.A+\Gqe
081LlY3H7FqQ6QO)Ub:'R_^ZO6>pQ+K#']AG&2);+NeAt*Gn!<p6WiN8Eq/XVZ.EFASP1&a\e
HBkW^GJh.$tZ9^"0*l=l\tZj$E(*j3ZoBk4jp]AbMt.%Q=Fo&-p!taM#,VjE#PZ;<!TN9kp\T
RF,[>_*Oj!]AXD(`.O*!^?ZMXs+k'@R<cb$6`"W1@7/)(igQ,3,=C%(+8oO:T^EIu)/8Wr'TT
i'&Y0IN3#W`AQje#lr[_IAAS92XDVEuL'EbO#=q5SA*d@W]AP_d?l'p<d(VjO+.Foj6PL[J>H
(lF.@@"jni^,2W0#So`\V\E3r%@`RnPK?U:E^1s,n0/*!?12-/I:\?4h5Lf#:eF?_\nD/9IB
ip\1cj'g;_s*AsW;m;ZP5F5G5;hG*U$<[AA72=\m!lKWp6Tc$>+(eO*k]Am$3bm9G$d!f?`iR
9LT+(&h:SD*ZDhR@@-:,6fe!inE&$&6tW2&.sDYB%DfY'a9qN3<)9?OnHhEms$kV:W#9JnJQ
7[\kIMV=GLdfgmEFOn"c"LHBVNL5tqBjHt1XYWJN>Dd`="61@7\9Sl:qCHY*<uuB>TCZ'tMb
"a.!G#-B!j0;LH;!IMhOb@_7<e;X,H]A8k)8?B.b/i[2#1V2AWq?esnt4ik,SaXt::qYCr0t;
@M";gKlU*WlC[6/[Al<aE`TBtrhKC14rV5q$\at7QRUJE*>ONNiSIX?f\(?OdeD/&sGKi$oa
?$Y@SpVWrf)DkI'WkHE%bM15B2e)E"9Z5!XEcfT]A\)?VcGp-"%n2K3g]A=$9`9$/t=gfO,E^X
$d&KMJh,jm(aD[g']A!Q!9]A!urc*\ID]AdGq/J9kLJ]AteOZ!uSrX&j7)dADk4(,N'5g".;8sOT
#_V2M#mSRZrVgO=IO3uXd#uUa8olT\2[="1=4#ZYl9sUPLF/mY).U%kNT=EhE?Fl9B/^]A/0n
bKRBWO>I>5mVn#F\ZLo)qAa)9K)Xg49c/fgon./DP<@WjpSkV4#5BCNt/&<oT!r&[a'j0UUC
hM9lkg/>m&5L.?i8LIUHuRZ(<6H7q8F2o+Y(j<Er+eYnNik#=r4[:`n#r#EWk#oDVCom<CI\
6"igNsS[DX:#hd]Ao!F?M*.[930I8ms7dkf%eD8F16iph1H%G1!17;[WWog%>#8dlRLJL'5K9
+cR=EUXZ$p3a.O`0fZLj[moaM73"Y(b=*-l?V"HFP(_cJHV6P?V2+kU:`CI7m+3D1GmrB=KS
[NM[f"bj'jK8uu\pdI_>o.ViU&XXSAHI%BrMQm\#*(O<DJ._.H'0-#.Y2H4(KnnE9PR9F=$a
:d'cS!20"Lb>`8$.b0T+d#,B%1XXntN>olT397+17e^depEZQ<cHaEJ@m;2.l+;Lj9IWpU6R
[)d?%8UbVt@E/63'[gW^*4_N+#aenb\e4cP?#rRP_Ao!*Ke73r&Y@L#SG>)kPblO8Q*i9+RA
Cb]ADH=_#'#q`i'Gm)JF69!>OBeo@f^WFp=Kd\BR!I2lg3BT<bi(D/T8-LP<Y**V,9Q`;/n*\
1N>gZt%6se;7+DWVL83e!i)!haFY:1J,9*]A54@Cbo^9n[Mj*<dnR`gVb9&G*<K>(+IQ\q20W
>X3(Gnd<#Xpr00p:'I;%:%^JE4UtYV@q\b2fRV&g2CDN7):=<'ZmuoL^Yiro(JZ[EKG-PBGG
@f!!l`ml^-+-d]AhZ)iBEs,t_XSZPMpX]AVLJ%mTZMk%#:":,u7=tu*%",YVJsOmWnJ#sHRmH^
X;h&s"a#/]AA&\j1`f;\Oi']A+/E7;\\B:Xl8$gb'ACltL]A*]Asck>a05IdU5_$HLA[-4PEmFfX
M,.KC):@`B9A]AtK@9%LipI=O)//&DlgS=>[XuK"Z.*Fl8Pe;W$9,^(DP/j+=HF/tjd6#Yk;M
DtjoRW['*:n#_]Ap>--Y)tO.gjLeQ#\'@VZRc$Hd90Xf!N#U<Kt'&:N-*)UhEXP7k-8@bMUml
BE%6]A>L(S%WAEO:6:9QKjI*ijX^<Ho7sl2\<iVhGFl8Zi?/oSD3J`I$+bh4qS5JEZ''OD!Nu
C':j8ki7\H!6p<[,#"XDGRJ8YQ<fk^ZrO6%j5ilI>auG<J/hQ9DTnlFbtg<"]Au)li<@\<`ol
;Yo7tDA&C<!LkPEfZ1X=(J/V*[W=]AEEUN]Ak"Kg7?2GUhf1gXMN(qZ]AYi!/frL_gf9mn'k2$s
7sffWX&^H$SC]ALPZ,e\j9.9m[/m[#B^&N_TeaE<=CKRFXlnrIj"D(CW>.h91@S*=0nE%Jb&E
=\GBNg/o%9q0g=3fe?gunPbWU5A0DML+)GtI<LD_#T;9D*gMNM;0KaQ9CMVQSka<go.JkO%d
(KQWX3.M3[Muh7Hj$*\Oe,cn<-:,oGS4r.WBYGk.g/HBU%K<c_GK]Ai`lZRdS56~
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
<WidgetID widgetID="a9b555cb-fba5-417c-94bd-463ada77b43a"/>
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
<![CDATA[1188720,2407920,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[396240,1767840,2621280,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" s="0">
<O>
<![CDATA[事故数量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="Embedded2" columnName="指针值"/>
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
<FRFont name="微软雅黑" style="0" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="176" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G-C'6fo.Y1Ij+GJa1Jg:D%?h6MIoKl0g"'d4j%NOPm#-.m%5FX;7nBkbb*>)@o'aP>A&``
n/H8iGK@824"O<V!MSPSu=/[07#*#`)>W7`8^<UdGd30ZbS]APIfSMQ$d3d=WbWX#ER1%qL63
NIc&KKj7@\Ss-9^Nc?Naj"*&=#1R:21FB)T$]AtCkbH_12`IE[n!b+<o*0!9HXZDC4T`Kce9/
QlF@ZLO^(T')>6DXLe6[,]AOgq;3i%^[fDKRl^R^p-VWhrVlEC+4%;EIOTBr486ph@u&O`Nh%
DaJ#X[*r\K5.ReA7FU:r(H6;OsTU<qc?R[qR_/F;ct)-(b+;cW-:SNYh/;^f3I?u$M7>tYiQ
=DV:XDmXL[XJ@l,Da(6^o%5g/huCI(:\IH.^<JfnnDTW*$i`cs_[Vi"*^!b.ABiKD"<ho-bA
-FZR6UVCWlTguYM/#rqLmJdk]Ak_=Xo+(fhEY*%_'c-Uf6BfPN/Sp.5KWZt:A`TOh^1MZ@=^\
8.'cm-"W@9"45S)jiB'T7QBs9o,**3WF9omT@0[t)2#Sp%HO8uX4hf(Xegf'DBV\>Oj.C&cF
n!r"#+qaNA<UY4'm,rsChB:*j4='cXuU(AnD)C'.`K5AZ7t<*$FO5e8NXRg[qicuSBSq*PK#
t<g$/-+\pAh)Q$RLEYT'a+J%a.3$"$cDdtOhps+O878!?!JZ\<Kll[Q;V.R)4N@lP4USfY7_
'H]A:_/u`MCBN=Q!MY8$P;X6$=h&+FfL,:)m/Ktt$:6UT2ep+N.@>scTUa"WGQCRTs`*-Nr_9
cnSb2FY9I+P<=IF3(H>69(ImQo[T%%X;355"<o4'c#=C:FL;<7\<XV"%,i=J.f2C`*ufG#%K
;Eh)b.?TM[4An$+_U&R*ckPCa,048"pM>MZ9As;aS%\jJsS^s=jLVe*FN-4ZEnOBk>T=n@@.
+']AFCo[.GR@)*dOuNMS0Rl_RRg"P1KO-^@ol&O(h7]AGPqs03-&2*PiD>@__qdN%Urk=1Xo!r
m,IRluKhlCttoZb;Tbq@7t7m>1Dc]A!#=KNDP5(=fqS5e9Lf:>CUP(f$5]A1Y7FajdT1]A)buFV
J,?8E16SF=XM$6K[oG#(N7V_-ST%p'G]AC]A2eDb_NoM8EjA&!F:Y/m:iF>nK:WNuIfR9!>cm<
b:#77\'@r`S;q&i<W@q1Neurpek?@Qng-F5b$2J5r.Ol%2STT8VQhL;WgIL*!Y\7Ia$<FH#a
diY*[KS`ItMFI;SARo[")pgX7Ekof(^diHL?bS2a#/XKe$r0.%H3r5U$S'J5%hjtE?"%ql>C
f,n1PSpD5GiQT`pgRom=UlP0k*sE+.'<C'k9I,0YJGt!e&CS/@Glj_QXuVB/+WQbSe`pR*[$
DbWU>nDh%l8Nos_g[/X#E(-j*0n\CL5)JUXn9<o1:\=+:(r0sk"6kS:mef&%B0':mR/-B0_'
&`BVS./kD5^1:2kon`@_2cOh:(e;2=a&Lh`.^\U^mtR^YEj'ga<(4;fSnk94e@cTF8";[%[>
CuHK6Ug$[VT5KQm)HLVdZ(Ud>"#Uh+fGmF#Dh+4nMDtXkN^HUk_J?;XZFecOR*8C/77"T9q2
Z^[CNhg#2[#nthr"K5$gsL,bh,4&a%]A6,WY&L!o_"l8EY7@n+Cj3eCk;a-Cbo`#m\a9i7[#G
YE\rZT1/=_5Lq<:U/;>o`\UM@[Vk#8,j.NGa(:PB<,r6b.S$u\2N;N=,h6FRe3Oi+DG=>T=/
Ke%Bpn?f9[HD(^+l_.RQ<C9(dLMYZNhGW]API("]A<FmGO,+If:l6lO(Pfr\gBSkI!oUL3EB2p
c!`W8/4if6`XED7_!Pn;hk:1JW=:`ZbDmdeU)3r1F*NS\a7-J!e)dWX2m_F&`6rAJq&6"W+m
UFfZSYUQ\T0O,'_e@hI!]AMN]A+7@e@JDfj<EUt)#68Ao\(82")l"F^RXUEP1RbP88&YlJ1I0.
aIk(Vgp^4Nq51]A@aKi_?=mK)cje+$jkRE(StdjQdBHr2_pm_cY,JiorT[\7#/P?rjD9.i6(=
r/L3f9c(<4,CGh*1h2ql2;\=9^ZNPZ!&F0#dlXm(Ts;BX\WR")8/*-]A)1%K_ulXo5O4?l[31
=aJ#D2=n+,bHL<2R`G:X5"KI\$?e@\#W1?d/,)"3Z&c:!/qb;.?44$u>]AKmU!SOT,J>bR_rZ
]AB*qI!XlA_,=0]AdM"h&@m'Z8!c_att.olBBptiiY..PNl3P#?j<cF_Bo/JkD'!SpS3NZo2%L
.+DdJ$*bDpbH@l^_YgHP?:/+G35'.p<*=H5jqCC3a`%NVD@:j=4JX\.LZt\ZJrpTio+$@O\k
k&FUlgPD&C$I&)Zu$oH96Aeh,k9$IIM/Jq@lV1XG?/rM8]ASr$R^Xqs?4$dXBfh.;V/70X)E)
PLI;Hp(^cZngLj#ga=t>jot#R&$`t&b$E>N.*aV]A1N-#QfgP@U8pp&bBjah04Nktd"LjHhWh
aW(7!bjjb.-E2]AqC.C(?<@QFR%'[VTnC9\VkT71gB!Onj?BepGo?'?UT@!QGe.qsDJP=I+hU
WQDY6q?(2Ze\:H_fDG6g82C:-_kJE>TL,V6Gq.5[e!L`(s)%odZs+5ti/HOW"JZf)r[O"s$P
S%cNN(NM^>m-tM2F`Chh_FY&oWF*DWR?QoT%NI2d`^IJ=b^Mc"Tms"1XgECW<F(7Db`E"!bY
[p4XU7^C!L)7D7Au$;GPV,cGWQ"qj"E(`5Ub/\e:XBM#aS.bXn\Q\U@/8hbK#_,Ab_KlY"fE
W`pVn:4II5NH3<5jBA"_*g2>G2b%[@)3Q(MRSLs_P%EuLJkA0h,e0d]A\GOB1l<AR+eeML1el
IR[n1eSec$:#?erp&D<9N;TtmES:k<-fb"-@;S^C<p$o6f6Q/SEc(sHSij0bK.Zl#NHLmeHD
!Q3U+`,]Ag1[cPf>[2r1aI\nZmEkqWGo,VoP5ctk!K4q^fA1PSBXHY3D;DY0`K,<S2fL[2'o%
YVVJ@(meSBmoIdJ5jOp>fLa"7*c$FQAH.>olaN;*tXu@P`pW/&@%>Xi^g&I:tr3BK(JW.NsG
NOTdI">c4@)Pn]AVk#Bla&K@`VLnKY;F.b78KW,NWQnSTK*iXMS[#0g2QMs`=--oadh^s=3kE
ApHd+cM&3V`m[(585``"]AGn%WHIR3.U:(>=66eA6S)OFn;^,[ChO(#Ct"9[6JL9f6sNid?$6
si"r]AVc+;u"he4q@t/2]AcfNJP82Gj%7,"%0Jf9j?s'[qS><h#Ii(I%/;!T_fnGPKPPb;F80]A
T$odGd"mW3!F6(SG`)1rE*4)?!TY3MN6E39Y#E,g>bKqgbthgdMd^F"N1gSaBL?Z%$]AGrd3V
jt[nN0k&9[G)GOT=!,i=UN0a!,FO@7qtVV*5"=Gr;qLQu#5<!kT%KWL6IDM%E7%nc-SrU[Gk
nW"1)YX`!?3^p=4l;SW]AI%_o*MI(L6,]AT:<6`&ZVQFWHnU%89V&kgRQkRH=o7D$1$/_]A57mr
Cmqam]A;MfO!5&_MQ[4hkQY\nEmIOVH.U\:m$,J`Y9bU^[4rNq`/H9Y6NI)g.GUX!V[>uu?#3
,+(/82/">)(+aLO0]AgD+0\P=>:Nl>AmsW/@8u.]AU"mLKPoU3;jX's0)gb]A\kh"PMAEq33X7!
8Ds%Q_2oO>CP$]A6R=]A&i.L#"?;M,Ws"Rq2CY>NWc`a`NNqs?qh.lf`1LE^.#K`+6/1)+o:Qr
7!gm2,m'-7_tR+tW/.lck"-Sii;V'0iiPI,>X^0]A"]A>pRcpU`NLi!Y=_[4$Mld3-sTH"KIr>
,2mnJs+d[W`S=i'%nEQ&`JeLBK.g!&<0#6)B3h'iPp\WR[.0mT.o-DS+H,\(iUJ=alTX*N`5
P0F&jHo3$$bSA8,\qBM'q@-0,ABEO'+<nG_2<?F6O=#(J\6)+FW+AB'_#qh!jGq7Q-(4i93Q
)C4TJH))@!UaPFrA/;%YYAO4b'iNI*6MfFal=Y0/8L-0Rls0ST$AY_/%oSdFt[8HR"JD(D$t
Z[qOo3'9<&q@sD4D!6ttE%=1gXJ^='4&#8?3FJ&'L-`GT#6F:S%nTXN&a&AL"^iQ`9ghcL]A[
71E<US_!aa8SJdu%d%@kbe]A#h(E>VLFcLP2:<o#mnVk1F"NaQV%C-**V[mIFHs09:c2l_FtG
tGA,R#"]A9eJ=n;\8q@*0'(p[YRW\@$P_145U(@PrQYCYs2:7(D^q%21:E3mnQ,DNH?`bl[60
M!H*"_gi-eIJ$4)WMZko'N/:BHppXY3#WZo6.*9Q&Sr=hs$\k/CI[FU#&@kD.LY4$XAVO\U^
PQ&XZp:HNX&gGKsGGU8',d:k0it1\m7i4#WH&K@[ngDETg1jNe't;'o5"97!B:'$,3&h_a*E
WKu^fIa6ogY5iaUkr%j1H`#Y6"'e'Y_saulkF8`Ei-<V'A<YotrA)VYTQQX0Qf6k#[$KH84o
ei4>4iORXY'bc(Q*BB6\/?KdhtA$GKu/+kC4]Ab;EZSRW4(c9m%0+H,SmJ;N'Q4k[&S"_B]A>0
Y@?C]A:\[-.dX#5>M+2#cXnOL;JmMf1YLaMaL0Ggak=p,s,.b"/c/"#mmc3):Z1n$pWRq!.&N
8g4hilJA2_6Mg)?_A&q*=`\;&-A.-@hLU9har4rVG:n#oJ`g^JP1Y8OA<.WAOQ!%VHK\)TF-
k:V&;Kuj"1Gt23%Ve=H5Pf!<mt3Vh.:VFLqEJMKRlCW6.'jRSUL-bLG#)ZaHco&80(2f/JQp
rKOM$S-F'I^24fd^;EE+/7`1S<Elhg3Y*ji"pI,b1_m\G>k9[U=AF,F(L6'65qB/hG8Qis,P
4.dpX<MpE"dM+(ZncjJT["F9M?g70udk]A$(PEO)cFDV(nX50.6+i')f&GR$Oadklt\sdo1ei
O2AWh^eqV/tYc)D@Y"!&3EW*j9qdP]At8'U%HQ6Y'.1#M;L=PWOdZJ*i5W8LU,1=?3;rQ5E%5
F7.ULe<P7,cZLQ3/BiqF-at^qm'0PO59NB]ALa+=-%C"]AE'co.hU3f<C"H(/3s'k4h$OS?\b?
t)0OABn=5!s=#&3+PFJ]Ana&`Ycel1bH))@L`\H!(^A>m2!r%Pe+rI4FANOhgmp&kMO>n4lSl
?PFhR'h!>$/aR<WRg(b6i&9N$pDl(A+8#?`3*p=/p+rmRA&IlhLZ04jd@no/F/fgQjC#0!V.
c'Q`CuIs$?LGK%3j$h:+=dNh>s^pBTclL@H7.P7]AY+dC4l]ANG%k(&%ZV#n+N/=^>q1_G^''?
EPm6WXiSd?V0$/QkIXThsEQk%ds1*/arR:f>f)Gg~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="791" y="10" width="151" height="84"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="指标-主动离职率"/>
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
<WidgetName name="指标-主动离职率"/>
<WidgetID widgetID="a9b555cb-fba5-417c-94bd-463ada77b43a"/>
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
<![CDATA[990600,1463040,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[396240,2834640,2865120,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=VALUE("指标卡",1)+"主动离职率"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="指标卡" columnName="a_lz_total_rate"/>
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
<FRFont name="微软雅黑" style="0" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0.00%]]></Format>
<FRFont name="微软雅黑" style="1" size="176" foreground="-1197808"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9>!@;eME*l]A1C._/-Te$6mT6)94K1!(<[SO\@,S=Aao$XmK64fVn"aVA:jl&s@F+-CkL><?
kOu9SuBBKa^"o(eE@YM$+uX+,H$6C5;nQ>e)"_P+1P#NUsDt([gZh\kf0A5C=`jH-^c^q`>n
7F'eje?CMr4e+l5!0k3]ABM^tELBuZ+(ctCRi\`R72iLbKoo]ArV8AcR`qI/Z.OStgMSCPr!oL
WaT/4su:_s1Fi,\,W!NO`.Fe^\X.\@KmpB\MX]Amm$!K3(&g7\oBpZacVj:6XPWm6d8)E%\57
F4CZ5-t#5=tGT.or_IK-Hp!Gu.R]A$?Ip1]AgE_^EZp#8/rObe,'BSF(:tW5TCT0Za7EUUL'51
Z:ir)9>gc*_5gYnDd]Ao"Sj<d`NT'62"t?@fm,JVZq8\h('eu5ac[jEJ`n;d05neSf8<NEh2(
EDDBi1B[Q7_amm#0ok*r$jKdEVr.fcN5VqN`U5?]Au?RBUqQG+S.ZjY\`LKTC37fTTYJS=J*c
p+7@3HV7nLM9'=f0%Ti&+r&1l<Cr:ee"hQqlo[(#'ngg5AL8*g_[.:e'pXTeM9#Fmb9XjW@;
TQ`\;VLCsJ5gmm>VnU4,CWtW"#E^CCtJ/>RuXIU\(St&6f%?`=/bg"^sC6VA5tWAF#WSaSAo
cdFsF[qdCt0H7VY!cPI9)Cm<32]A!.>S)P)+:c\#U0_e\-0MfH/-m`?&r@@4u/'k3U<lE6dhW
Hr!:5`bu\.DTOFuC9QfsPigH#Z>(LN<R,X1m[^bOI=Zn38sn`0mk;W2WB*uM_>%a+?.\*2_i
g<)Qg8F+d9/g-.rioGf9T@P%<i`UcKNj2?3BtLX6QhfHfai#5FehBlt1H3Eu7T:9dhm5^p9p
n+=0CgP[cGP]A<C+K`=hVYbSe[K`!fB8DLffj<JBb$C[$+SnEJ`Ur'/f'a7ntChj1WeaOK1+c
ami::l?MD"%XBNQ*>(Z?.)_(>J?Ht78_U'`jPO&=5m'E?fM(:q%@m(Xh?W=mf*$6'IFLUpKF
`?d,d]AAJT'RMqhhJ_.cGR]A2g8KAgju<sF_9[f4a=8MCD*hY*7m$+*`%bI!tWgh7[L=:=@@4I
)blssG-]ApGAA#DCB'jV6HI;`bZ+`"a;0KV^@J9?khHk?EnqR,-)lr=$DV3@8BTGT+<[%3u]AQ
6TnYiV-0cjT6_`7FEnS9&E7[2o%)%C)(t7r(0dW5I>:&AL<M>ZtZ\en>4X$#_mXe*:l<fVM?
)olSKlI;n*d#VN."Z,!8Y7r_W>')<1/ajN6=;u7L'j`01G9,1I2CtTS\f-!((p\LEnG=sVL,
+7,u_L=?=ra1uq_nDq/*c,7rhF6YjnF>R!jRS,fT/'*Q<TA#mEbVaE'QqKp_0jo$3Ds@liP>
628QQpkk00`m8uEJ!E^<)9d_2]A5K0nh=$@DY<2^;5paq%%&cHWj`Qc7,aO,oZ]AnpOa1k5fpO
`V?*'IK'\DY?-UHENdTa1W=oi;"$Nr3Gq1Aon=mV/+B3A$3XH32/W?&\LE42>4_B<mpa+3@<
?C>W);4(,>gJ&]A"ru9$)RjOoiDNcIf=![LakJL$r7)J5H+;emX*oc(.bIHi07pb$$1:/N=3m
1EgLk(#f&>14>ae1UHUT?N,A)W?Mj%gl_9`*>D,+sWnu_kf;==m%#!r@32[*`SSZ(bir+>]AC
1Fb!KT6`f0G03^CCO/e0Nf,?\//8\IGBf?WAfTq/4d9>e+d_+RsVCPHR"EDmadjjbER4i?C9
X3fPf@)'*^:MNj^)oFLu=fD2dk"F0t<lm04kT.NuS,ZF?US'uS]Afd7FE:DdqDR\B_\+A]AFCH
8V9)0)=3OYpr4HC'KUX7UfHl#>D.gaUcH<VQpG3,8!s:I1[%:*ke03MkXIo&niarAR&1\MTL
2d2[7W"2QQ")r$=^G9X^hJ/0m*fC%hF'56u)p%f8(t>S.>Bbg)NH]AmZ9kj\qa+S!S$p_,@'D
uH@$r4N5\b_Wo3H^Yd=_:6ec+MTlb+\oq\#%f3S,rmd)m%\5_`[kaW8ji;P]A,dIsYgoOMaZ-
^$3N706*.X,`keOtK$O<d+:D#X*WG/5V*4WSVBH)KX.:8Ch?'j#CS/1JKM[+M,(6:g%Ahl!7
EfiAuD!%/clCYfF\CFZX.2F^&!Q%'di#M!;p`;:?U*c@L%g'jY95g_DiA%d(ChE.oV$:flC6
4k?1*q^a(Q:(o%@hG;H:&l0%ibD\7/U`X/q0qV"gF91j&72Jl$OrCRfn;CnUhNNTa**Edu[r
<3s?N^"gHa0mp.l4DGXopYVn7YF`Ug_bU!m09#o<_a3<`Wop);-WC^E2uE).$>>G.4='$s&$
WI*\5j90)7U+-o<FPpK7qg]A-!$AA9G>oQDlV:(&P5Nu^EUQ)eea*:r%[#ubu+_sbP7okpC1P
]Ak3+RP6ZWqH;'^V5DsJ`cUkBW@h6hiUQ2^Vf%%5oTU)^N2(:a$9qN6S(0p37)DH+@iM+S5S/
+a%T]A)N>I.V+j_hdf!ET<G+6*B8bghqQpK:7[2-bWHOUAgRXt=_"=85O@be&>/IC<E\.s-f#
jL;@pr=P>?Sa:6,d>80-(+`0iY-q^;@*E@Qf28qMZou^\nLTs@d<WG-2qcCmfdtl>WP,la).
AFXjCZMBV<:9DC()CRh(EeX[gDr`*eX#J!7U1'MQ#p<j,(kEi!hSpg:C19RL:mW.Us9iW^(^
L3e:MnBtrWnfeI.:)euREcdd[PE&R2o8WfeQFb@nd.ep?;B/GjT1f=9ARlQpIn\0GHEG2l?k
!kfWH-nZlX!Bog^0r33=3?IlXF6"P2?SD'm#3^9rK.0/e_/e.H,gVpW)IlklgYs63#0h,APm
Q-q\4-Aq()IMH=V"@\su\l'Trs)i)FtCArqk8aUHM#Ct@`<(A'TEh1FODV9uae)1;a0'Pdn7
>2,8_nKGQnjKBW>UhR9%^NCgMkO3ECfAf`WcT@H0gk8uFDXrkAr%)iqfK;q;=r-=KT^6t53J
SbAB6Td)]AF(eoH(UsLZ<BC^jjK!NNF'INMgJ%n'HTTK$g85t)gLkj`MD[3k30MB'2S]A0V&5l
1do?+Q'soqs"Zo=70tZ*+OcmTb8.T]A1Q)5iHZga]Ak(e"p]AiD#G,0p>Q']A)jk;Nb>,g*%LmT6
`hXAg/s]A__laf).2tf3-1:1a&k]A(s6D_]A"LF7UeF2*e]AcGE]Au"MG_TW"a*e]AKU-t/.N%TMA?
SVOAcj^h>3,MB<Y<$`&2Iq9?T:/^0i'h</^S\:bR@RmP1$PW>k)1fB5o)rWO8Y89D(&`crA<
06rQ3(tk6M;(V:LBgK_Er>VdhC!LH.4=XumePo@N02OSYleEm.(ek2&=q6kQ2C^l(>:7[!Xk
<8@7ZOX6G>E=A%GZYH39$G7Y@2NO*6fBhLN%oFnh^bnib[kG1qeCW69,NHP^`Ai$%cPRXE"d
.gbM^C]A+rG9h7o[Wq$<(Ie)1X7bkCoZU0K4)]AU);h0_<V`r]ABgNdjYki<g(??X2[b1pOKC"Z
B#2V(&!rM_tp#.(qoTf7L4-#SX/1fqq6``R+)SgWTeK\f.cKlRHOM-"*NO5GjIT/[JJlV4nP
"Y.s:K#!,EP\*c0'*WT)X$Ac\&m%uHQrD9FN%#hD;!/g!46Y\TV<TBEYd@umt.O@#eiA!FkP
V.@Pc?%&T]AiV%t+*E([[CeJ8SZU_?<80-_<g9@J?Z*4W.h91$\O78_k:_c8uHd=B9OTLid2b
l#^1c,SO7T<Lkj:irrK:EsHX"3bk?@E4J'Bbu:C3LHQX4o_J24j..);ZE]A]A*9<afsXC'Mrh=
`"T-AfC(W8<n$XFV$HesZSp[@^5I4_hQ0_7t5ERS/hWPnA*Dq:WNs.Fk!MDeKaR(%nDS@CA^
VlgG^?dbJ?3(*'MjL9[-4.1ZIuWh:*[[*EPi(:W,a93o\B^e2SKItqN_#Vn8r>phM`C890lr
GEeq.&,o46W&q/8I_*Bb%O!mT*8ma#C1HCkI/+C02$53hn.BYTZgAGN6\LHE'M7c><XknsUQ
k=_Dj.,]AtYU$b47GmG)keR!kYFZqUA_mnInVB_^F9\+Jdgh'9e>77Nu%nkcRj^5WBWT7on_r
4&IpbkV,niB]Ae&E[HtSe9YkVqrrNOl@Je-3'<[52%1Cfb+T4pGKbl60]AM*ho7"dLS#)]A17iY
Co=Yp^k\F$8`[:p>R!4aeZBE]A#qQlp,I6Q`i(Fo3WobNJ5NHXpri!c_imBs\fL1D(P[RY_Q(
n(aJU@N2i&aJ>=?mVC!M(YR$^iC"t7UPBk[E+1lR5q=UTO=DuP]AX/2+#mpd_2D.YmAn-n9Vd
b]AUEPYkp"J&/O:NR&+hH#-Jr"A@n3OFW9R/:i(#k*m.,%%`NrHZNHmH.jW8dK!2MCG]A]Atnl]A
1kWN-JFg1$19>IjO@$Qc$U,eNQZWTT.eoBG=AEQ5ZsT4HaQ53OaQ)kr+f`_Gr>A&)*ZGuG3f
)uHQu@kba$9Hni_OR5G;>a0\]AM,d0Zm@5bsY$l4f4-^VGp0ILF795fEG]AYF*,N)<U'`PU*%7
1rCog9bGIT9-b(>IcZ.8DTT+%s<th9aV-7SC]AV.XJT;JO&K7$@+`jT)">LWt^3D4oVKeF+*P
*Q]Am,#mk+Rh=i*aPH\^\$`a9WB@9$N,g43idBoP'jS5>k-t+N+inia4M:k)S^/,8GPN30!a(
BIX?\?UmWP6;LJs7t&o<TrT=lWuNoGkU9mead5I.RE["FZlUjIUEp>;q>mNLRa[`9EXj'QQF
s/PP)bqMF"TS_L16u&fIJpHCoqen'P;*e]A?`leeQ7%KHm_2A+aG5IAmNU-^HQS'V:k,T\eIc
fO%D0p\hp=1GjC(6L"51jCO6P2l7BMYcb)2O_mKk.69=US0:>F'5C]Angs.o=]A7ueBp6agDp5
WK8!"S,CHN.*FtbOD1Cidm?emmKPc3*iI<LFf5=L\c>(Pd[u@p*bFTEgYq0"A)Z"!KU?>;Tg
4\Mte>ZjE2M1NG8QS@W(gJ8CR+.TA'.>)*mAj?h<!aq($Y-T'nGh<!FH&`B.HH^F,*:7.T;#
+-0ajBr3,grJ;TJQe\DOJmjU=:2^+&N_d,P'iiEu$WrD,ekI>-Ts6M\>0,0U2Fiq8*#>a#iX
I%:`5g3&#ic.Q5bi)[M8J*YZ,qt@016)/4-i?]Aa7FIH\jRql(Q)^lp61`LC3NU6LL,,\=bg'
Aq>--G?.6DLlWaLd-t[M(sF&R]AYLkkbgD>?J>I,oV=@5U3I[bp2SoV&>f4?6fMNbpTDhKKf"
@SnjM+=3?JKp[6jfYbf>[*<]A4+A(c+#oXa34iI'N*j>QbQcuHe\^-nVcU%f+#(;aQ$=cU:o!
1/P<kXNpkOkA`'NeB8mGl7lZ*%Ug:]A5_1FHZ+nME7Ha4J-klF$2rgkNppSrmuQe[gIf4'Ni.
HNM8:fKo#c>haF?0>;9@Gua0BI(-W_&A!_59pkOHYo?R3?,ikE9bec@hkCu]Ate$H&Gd#+\Z.
k?GR*p'0Ee49+=T8$`Zl1%]AddFT:XVDKa4?+)&(7GMao_P9tiI7QFeWLl!DI=LQ0\2OnN;9g
YJh+@Tl3!TEd16QYW>2P%di+6LL:,+R90G2KS7R^4UF7ruGb&F+Q7:u_?OdlU^t^3rqe$7$8
pX5I3kDOKMA,m!K8)ot43YiX?1`(YbVRn2F;_JjXK%J3;8EY;s3M2Qkh1H-SCg8&>L(]A;@!_
1hd!J-h@g^c7$bgBA[tkp.FN,hb(JNG2Yt%MEr(?-#V3R4):\849:6N,Fdl7DFrlYVM*3$h,
1=R0N]A@"2>NTIuf%7``k*hOjjC.<,b>5!&DC8ADiFR]AF]AI(M:IC@4,@Vfg``T/6..>+/MpK\
RC\b5'E7Z%_q.$1B`.;(FbC0rq3,tN0t!UiojU<+4n>"$fKQFiqb'hJG`.tXSc9)=1X%&B)t
"G)`2r0idZ^;OTOH24+mBe5#a9(=PA?1AeEjG?C7H*^L!#p\>kQ]A.F*i/EM3nV=?Huq1/=EN
>Qn2VL/*>*WPI1)oeIDdTQ1PHM9be-',e=bS^/I`qi3iB0P*1IWY()UnW`'Urd)?9Is+OiXV
)"39DCl+S7Podo&Vap/f.P]A#&,1&2r<HD`]ApD62be'R+e1K.u[ia5o/SR3mrUjLs6Bn?17uF
2eKrk(Ol?AF<Rj@)V^h='"hCY24aW!Kq9-jMr"")Xg#mmBi+)2&%Elthc,?0Bq"esHnQGZXH
'K=iQ)HZ^55]Ab&`II"&LRN2=j'6&(NI,2.aK7m<bh<,M@E/K[nC%EJ_/D<S;^^%+qFTRPAN3
%VLL\&S$&ooNop3IALY%5,jC?3<(U!]Ah`U1.^"gmmV[`/e^WZ2+AaU.V-^%,W1)82$XaQ6Tq
::4A@C1!,lhD<[X>1;_?sSAE=2)kDI&c31,Bfn=064]A!T)$'jSJf+_!rdk.S<h4eZ4DoSj[?
Z.PWrRf3WF4%@BZ@N/iYKSH2>[&g@]Atdo"SHuskXGRXqP"(VG+HQKBjM2_n]A)l]AqrBlE`PAH
\`:QtF-83.S^mNjFK8sTo/)1f\$0EpVe3UVtHAVL01"7@G\#uHr[,(:RWhQtn2(/<mFpT)It
\ioIDjCfS-S'nM!hJjQ,,"D7I\1lnLCFU^VXME"t?cjd<G:l55]AaU`9MEXFUc8B,e5I$aFXX
_F<\nG3"1E%kPUQLju:J^->,ADHrd=+_Kgcu#-;]A-R0@WKdoVVhDJ\LcDSGQ<bigm-[.ium<
c8P;%mq%401>+^HRP:BON!g-1pn#P@o!l#L>dV7M^2ep<\dcZ9=A")%:dRfb^XoM%!+"s0e4
<#fmQq/EAg09#bhU3&+Q=5,L+6a'Tg+>+dXF2r_rSGYij;>66a=gdjr7a;)b;km@ear#P6?&
\sV5X/5)k[hXG85-L/ut5(cEEHNNsPULA_'@WZur@$@us(FBd)@OaXG"kMn/\NkC/]Al1RB2@
HKXsc3BmtF^Ma)%`>M$K0sc=P[t!]AWqu*\$AE/stj\%n6CIm0^,H=KG4%1n+fS*A9k7G$c5R
WdL"RHXW[H-`Fo_K&LI9-Zd8O]Ak)'PGN;B/l#j&)<0mWZ6K<-6P)B]A#,(V75l*JmSgq^EV\`
H]AD)al&4@Y=W03n=@eG9b0J&A/c(PmaS;<N4DK$bU;Bq7DXN/,!"6H1&Q,%E";*nmRA0LOW_
*4?Va.8>>?Q4k$hKV(>k`gbIjj+N1$rV0R#4"&`fR[HS_0.&X*,uXsaR9l2,aaP1)+pYl`,N
.LfY=/H$Abs9-nl&)bnNT.M+M]Ai4cn\aVb@Zj<P]AhHE`-UnIaNU)<H"6E"9nuK93=U]A#b&A"
7l[6"NNdh!U/SOK^ft7jo?@QBfEdW)?*mbjTM(TKl@.Z/5QXt-?@`Ef1"#C:#MW=:E=fAg6j
MismnQ_=+>G<OG?c1+a^kP1\L^rA&T5c/*6\7KZp_0h"M1!PRfLoMOs^Y\ZZ+t<eFbPIH5EA
HW-K\b('PB1p9#Q/kG*^W\c5+X.meLuSP/0CTl^`c/_dX&jaYKCkj,a.8kBH]A&GlM8@[jR-h
4ssXpVln4+".J;/F*R)JJT/Z4?>oZJ]A+@/2,SXE@*k$lKp0,@]A)71A5G"2(I!]A'3NPs;>U4Z
?RQ\sE_P+b[<&kbh8ji,bI[CYEAL#GfqS*A+)0#f/V>s,HZ$eFGd'3B4pn4G<lA>el0j-)kT
O(IWC%JCX[qd<@t&s0bF*mq*]A#X%)E@>9c;-(M9KPo?dj\goiond>!K14m3@""]ApWL>*2(d[
&,!iFF5EgIoY74\qV&Mb$"$dgIsJNI";I$#f;RC9PMr@G+P7Pj6.B(pj\61F0]A_#aLI(.l>@
9!r[o.q'9M5@4oNgV8bPaDT]A2n+7*j04,\s#SecR0\8>uTSLf/,<[X-7jU.Z,Lu`0'7oXHa+
1s!I`)*`hm$cG&CtK-e^Hm!"(k."onbnc8A[$a%;?acaO+`FIO@(LB)3JA^Ui&HCOt>=bJiu
1/OhuBf!_og>Y!8#@[P1h"LM0:YKCcpgMok[3@W+4I(b#AK'5@moLb%"9/ClH&`Y`1=)b:uL
]AAQ-=/AmqqU]A?;_A<=E]A>6>mA+H[TT7[M'+<;$d,LHY`q-1PO$@D!Kl[YZ8B/`ELX/glj!R>
2TV-Wr6Z9CM*Lf>H%po(4/ZQ\kRJ\7\:KOJ/A<3"qgV?$8<(8W'Ea>%+tcH&b_,H8EDS>ma%
5489M-j@g(P-6@u=;YB4p#9n<8/]Ai$p2lRo<i9V:<6A*gN<'mK^n?mae,JW+7?+%+!aO.%"@
AdM0e2XBA3u3tN!*2]AmgLEh+9G@"H8^,QtCY^r-,1iE/pC@YR>")-2%^fsTO[6>'%K?)'N^.
-_L@Rpl[Wo3=cl`/%'b[&M58#Y0]ARfuO50Xd2r\R4Heg,[J?5Z2W3F$gI#*J'!DZZ_OB160j
jI@doa<_+e&XhL]ADGmCE9"S>(5.gguc:"2:"*I1)V&uibW?pBBH;$%Vq"PF25/csCdj.IVaB
(;O>Kb+Z;T["`>T?5r*[0\"[/;S(P4`&tOkGN,'o63e2?:LlJh+rUmT9nh\<Ca;ZVSC,]A>_c
U6!?</nu,3aY+3ccdi%9IA/&Q=l/Rc<Fg3Q%&[H%COqH47F#'VC='NaUI%!k/1sq"EP<1knn
g:*77f^Xh-)ACfJ>_$j4P6:cSh\JF-6E11?3/0m*kLBsN6S^nq+$@23s5NSiX9OoYPuf8rp.
<"~
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
<WidgetID widgetID="a9b555cb-fba5-417c-94bd-463ada77b43a"/>
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
<![CDATA[1188720,2407920,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[396240,1767840,2621280,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" s="0">
<O>
<![CDATA[事故数量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="Embedded2" columnName="指针值"/>
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
<FRFont name="微软雅黑" style="0" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="176" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G-C'6fo.Y1Ij+GJa1Jg:D%?h6MIoKl0g"'d4j%NOPm#-.m%5FX;7nBkbb*>)@o'aP>A&``
n/H8iGK@824"O<V!MSPSu=/[07#*#`)>W7`8^<UdGd30ZbS]APIfSMQ$d3d=WbWX#ER1%qL63
NIc&KKj7@\Ss-9^Nc?Naj"*&=#1R:21FB)T$]AtCkbH_12`IE[n!b+<o*0!9HXZDC4T`Kce9/
QlF@ZLO^(T')>6DXLe6[,]AOgq;3i%^[fDKRl^R^p-VWhrVlEC+4%;EIOTBr486ph@u&O`Nh%
DaJ#X[*r\K5.ReA7FU:r(H6;OsTU<qc?R[qR_/F;ct)-(b+;cW-:SNYh/;^f3I?u$M7>tYiQ
=DV:XDmXL[XJ@l,Da(6^o%5g/huCI(:\IH.^<JfnnDTW*$i`cs_[Vi"*^!b.ABiKD"<ho-bA
-FZR6UVCWlTguYM/#rqLmJdk]Ak_=Xo+(fhEY*%_'c-Uf6BfPN/Sp.5KWZt:A`TOh^1MZ@=^\
8.'cm-"W@9"45S)jiB'T7QBs9o,**3WF9omT@0[t)2#Sp%HO8uX4hf(Xegf'DBV\>Oj.C&cF
n!r"#+qaNA<UY4'm,rsChB:*j4='cXuU(AnD)C'.`K5AZ7t<*$FO5e8NXRg[qicuSBSq*PK#
t<g$/-+\pAh)Q$RLEYT'a+J%a.3$"$cDdtOhps+O878!?!JZ\<Kll[Q;V.R)4N@lP4USfY7_
'H]A:_/u`MCBN=Q!MY8$P;X6$=h&+FfL,:)m/Ktt$:6UT2ep+N.@>scTUa"WGQCRTs`*-Nr_9
cnSb2FY9I+P<=IF3(H>69(ImQo[T%%X;355"<o4'c#=C:FL;<7\<XV"%,i=J.f2C`*ufG#%K
;Eh)b.?TM[4An$+_U&R*ckPCa,048"pM>MZ9As;aS%\jJsS^s=jLVe*FN-4ZEnOBk>T=n@@.
+']AFCo[.GR@)*dOuNMS0Rl_RRg"P1KO-^@ol&O(h7]AGPqs03-&2*PiD>@__qdN%Urk=1Xo!r
m,IRluKhlCttoZb;Tbq@7t7m>1Dc]A!#=KNDP5(=fqS5e9Lf:>CUP(f$5]A1Y7FajdT1]A)buFV
J,?8E16SF=XM$6K[oG#(N7V_-ST%p'G]AC]A2eDb_NoM8EjA&!F:Y/m:iF>nK:WNuIfR9!>cm<
b:#77\'@r`S;q&i<W@q1Neurpek?@Qng-F5b$2J5r.Ol%2STT8VQhL;WgIL*!Y\7Ia$<FH#a
diY*[KS`ItMFI;SARo[")pgX7Ekof(^diHL?bS2a#/XKe$r0.%H3r5U$S'J5%hjtE?"%ql>C
f,n1PSpD5GiQT`pgRom=UlP0k*sE+.'<C'k9I,0YJGt!e&CS/@Glj_QXuVB/+WQbSe`pR*[$
DbWU>nDh%l8Nos_g[/X#E(-j*0n\CL5)JUXn9<o1:\=+:(r0sk"6kS:mef&%B0':mR/-B0_'
&`BVS./kD5^1:2kon`@_2cOh:(e;2=a&Lh`.^\U^mtR^YEj'ga<(4;fSnk94e@cTF8";[%[>
CuHK6Ug$[VT5KQm)HLVdZ(Ud>"#Uh+fGmF#Dh+4nMDtXkN^HUk_J?;XZFecOR*8C/77"T9q2
Z^[CNhg#2[#nthr"K5$gsL,bh,4&a%]A6,WY&L!o_"l8EY7@n+Cj3eCk;a-Cbo`#m\a9i7[#G
YE\rZT1/=_5Lq<:U/;>o`\UM@[Vk#8,j.NGa(:PB<,r6b.S$u\2N;N=,h6FRe3Oi+DG=>T=/
Ke%Bpn?f9[HD(^+l_.RQ<C9(dLMYZNhGW]API("]A<FmGO,+If:l6lO(Pfr\gBSkI!oUL3EB2p
c!`W8/4if6`XED7_!Pn;hk:1JW=:`ZbDmdeU)3r1F*NS\a7-J!e)dWX2m_F&`6rAJq&6"W+m
UFfZSYUQ\T0O,'_e@hI!]AMN]A+7@e@JDfj<EUt)#68Ao\(82")l"F^RXUEP1RbP88&YlJ1I0.
aIk(Vgp^4Nq51]A@aKi_?=mK)cje+$jkRE(StdjQdBHr2_pm_cY,JiorT[\7#/P?rjD9.i6(=
r/L3f9c(<4,CGh*1h2ql2;\=9^ZNPZ!&F0#dlXm(Ts;BX\WR")8/*-]A)1%K_ulXo5O4?l[31
=aJ#D2=n+,bHL<2R`G:X5"KI\$?e@\#W1?d/,)"3Z&c:!/qb;.?44$u>]AKmU!SOT,J>bR_rZ
]AB*qI!XlA_,=0]AdM"h&@m'Z8!c_att.olBBptiiY..PNl3P#?j<cF_Bo/JkD'!SpS3NZo2%L
.+DdJ$*bDpbH@l^_YgHP?:/+G35'.p<*=H5jqCC3a`%NVD@:j=4JX\.LZt\ZJrpTio+$@O\k
k&FUlgPD&C$I&)Zu$oH96Aeh,k9$IIM/Jq@lV1XG?/rM8]ASr$R^Xqs?4$dXBfh.;V/70X)E)
PLI;Hp(^cZngLj#ga=t>jot#R&$`t&b$E>N.*aV]A1N-#QfgP@U8pp&bBjah04Nktd"LjHhWh
aW(7!bjjb.-E2]AqC.C(?<@QFR%'[VTnC9\VkT71gB!Onj?BepGo?'?UT@!QGe.qsDJP=I+hU
WQDY6q?(2Ze\:H_fDG6g82C:-_kJE>TL,V6Gq.5[e!L`(s)%odZs+5ti/HOW"JZf)r[O"s$P
S%cNN(NM^>m-tM2F`Chh_FY&oWF*DWR?QoT%NI2d`^IJ=b^Mc"Tms"1XgECW<F(7Db`E"!bY
[p4XU7^C!L)7D7Au$;GPV,cGWQ"qj"E(`5Ub/\e:XBM#aS.bXn\Q\U@/8hbK#_,Ab_KlY"fE
W`pVn:4II5NH3<5jBA"_*g2>G2b%[@)3Q(MRSLs_P%EuLJkA0h,e0d]A\GOB1l<AR+eeML1el
IR[n1eSec$:#?erp&D<9N;TtmES:k<-fb"-@;S^C<p$o6f6Q/SEc(sHSij0bK.Zl#NHLmeHD
!Q3U+`,]Ag1[cPf>[2r1aI\nZmEkqWGo,VoP5ctk!K4q^fA1PSBXHY3D;DY0`K,<S2fL[2'o%
YVVJ@(meSBmoIdJ5jOp>fLa"7*c$FQAH.>olaN;*tXu@P`pW/&@%>Xi^g&I:tr3BK(JW.NsG
NOTdI">c4@)Pn]AVk#Bla&K@`VLnKY;F.b78KW,NWQnSTK*iXMS[#0g2QMs`=--oadh^s=3kE
ApHd+cM&3V`m[(585``"]AGn%WHIR3.U:(>=66eA6S)OFn;^,[ChO(#Ct"9[6JL9f6sNid?$6
si"r]AVc+;u"he4q@t/2]AcfNJP82Gj%7,"%0Jf9j?s'[qS><h#Ii(I%/;!T_fnGPKPPb;F80]A
T$odGd"mW3!F6(SG`)1rE*4)?!TY3MN6E39Y#E,g>bKqgbthgdMd^F"N1gSaBL?Z%$]AGrd3V
jt[nN0k&9[G)GOT=!,i=UN0a!,FO@7qtVV*5"=Gr;qLQu#5<!kT%KWL6IDM%E7%nc-SrU[Gk
nW"1)YX`!?3^p=4l;SW]AI%_o*MI(L6,]AT:<6`&ZVQFWHnU%89V&kgRQkRH=o7D$1$/_]A57mr
Cmqam]A;MfO!5&_MQ[4hkQY\nEmIOVH.U\:m$,J`Y9bU^[4rNq`/H9Y6NI)g.GUX!V[>uu?#3
,+(/82/">)(+aLO0]AgD+0\P=>:Nl>AmsW/@8u.]AU"mLKPoU3;jX's0)gb]A\kh"PMAEq33X7!
8Ds%Q_2oO>CP$]A6R=]A&i.L#"?;M,Ws"Rq2CY>NWc`a`NNqs?qh.lf`1LE^.#K`+6/1)+o:Qr
7!gm2,m'-7_tR+tW/.lck"-Sii;V'0iiPI,>X^0]A"]A>pRcpU`NLi!Y=_[4$Mld3-sTH"KIr>
,2mnJs+d[W`S=i'%nEQ&`JeLBK.g!&<0#6)B3h'iPp\WR[.0mT.o-DS+H,\(iUJ=alTX*N`5
P0F&jHo3$$bSA8,\qBM'q@-0,ABEO'+<nG_2<?F6O=#(J\6)+FW+AB'_#qh!jGq7Q-(4i93Q
)C4TJH))@!UaPFrA/;%YYAO4b'iNI*6MfFal=Y0/8L-0Rls0ST$AY_/%oSdFt[8HR"JD(D$t
Z[qOo3'9<&q@sD4D!6ttE%=1gXJ^='4&#8?3FJ&'L-`GT#6F:S%nTXN&a&AL"^iQ`9ghcL]A[
71E<US_!aa8SJdu%d%@kbe]A#h(E>VLFcLP2:<o#mnVk1F"NaQV%C-**V[mIFHs09:c2l_FtG
tGA,R#"]A9eJ=n;\8q@*0'(p[YRW\@$P_145U(@PrQYCYs2:7(D^q%21:E3mnQ,DNH?`bl[60
M!H*"_gi-eIJ$4)WMZko'N/:BHppXY3#WZo6.*9Q&Sr=hs$\k/CI[FU#&@kD.LY4$XAVO\U^
PQ&XZp:HNX&gGKsGGU8',d:k0it1\m7i4#WH&K@[ngDETg1jNe't;'o5"97!B:'$,3&h_a*E
WKu^fIa6ogY5iaUkr%j1H`#Y6"'e'Y_saulkF8`Ei-<V'A<YotrA)VYTQQX0Qf6k#[$KH84o
ei4>4iORXY'bc(Q*BB6\/?KdhtA$GKu/+kC4]Ab;EZSRW4(c9m%0+H,SmJ;N'Q4k[&S"_B]A>0
Y@?C]A:\[-.dX#5>M+2#cXnOL;JmMf1YLaMaL0Ggak=p,s,.b"/c/"#mmc3):Z1n$pWRq!.&N
8g4hilJA2_6Mg)?_A&q*=`\;&-A.-@hLU9har4rVG:n#oJ`g^JP1Y8OA<.WAOQ!%VHK\)TF-
k:V&;Kuj"1Gt23%Ve=H5Pf!<mt3Vh.:VFLqEJMKRlCW6.'jRSUL-bLG#)ZaHco&80(2f/JQp
rKOM$S-F'I^24fd^;EE+/7`1S<Elhg3Y*ji"pI,b1_m\G>k9[U=AF,F(L6'65qB/hG8Qis,P
4.dpX<MpE"dM+(ZncjJT["F9M?g70udk]A$(PEO)cFDV(nX50.6+i')f&GR$Oadklt\sdo1ei
O2AWh^eqV/tYc)D@Y"!&3EW*j9qdP]At8'U%HQ6Y'.1#M;L=PWOdZJ*i5W8LU,1=?3;rQ5E%5
F7.ULe<P7,cZLQ3/BiqF-at^qm'0PO59NB]ALa+=-%C"]AE'co.hU3f<C"H(/3s'k4h$OS?\b?
t)0OABn=5!s=#&3+PFJ]Ana&`Ycel1bH))@L`\H!(^A>m2!r%Pe+rI4FANOhgmp&kMO>n4lSl
?PFhR'h!>$/aR<WRg(b6i&9N$pDl(A+8#?`3*p=/p+rmRA&IlhLZ04jd@no/F/fgQjC#0!V.
c'Q`CuIs$?LGK%3j$h:+=dNh>s^pBTclL@H7.P7]AY+dC4l]ANG%k(&%ZV#n+N/=^>q1_G^''?
EPm6WXiSd?V0$/QkIXThsEQk%ds1*/arR:f>f)Gg~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="475" y="10" width="137" height="84"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="指标-入职人员"/>
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
<WidgetName name="指标-入职人员"/>
<WidgetID widgetID="a9b555cb-fba5-417c-94bd-463ada77b43a"/>
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
<![CDATA[990600,1463040,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[396240,1188720,4389120,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=VALUE("指标卡",1)+"入职人员"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="指标卡" columnName="rz_num"/>
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
<FRFont name="微软雅黑" style="0" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<Format class="com.fr.base.CoreDecimalFormat" roundingMode="6">
<![CDATA[#0]]></Format>
<FRFont name="微软雅黑" style="1" size="176" foreground="-1197808"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9>'F;s2\Tle>V/X/rm`<IqR'1*`/i76j5G%B3:,0dZh7+K6P]AMZSK^+X),8FgR-!/V`2eUd
gJCM\.AU-mT-l8qNiRCJZ:=6AQIF+;$4b^[?GgT6>B"o3=6*[9ELGBRG'mH-UKFkBt&->X)K
$ElitNVS4`rba8]A0s18!-0k6foN>_?3MW^U!^\Kk`:C1ONA=[#;ps7Gq7sith]AUuX@i7!\!T
4[%tIVi6)(&us-n\hQ+>Lkoh^DJir>0O=BV(XC04^l>e?ZSKbjk"ZomYgubNZ`l4T=Sc1FSQ
eLgSW5EK]Ab*B3_o@%6'hJ`n8n^O9L?+BDcj_#ThCTh3Cc1iD.1MGjL_n9Or[>Z0`J1g_V`+a
3GhEDa!-/<M!W\RlI6/jI,P2=9@m#g*bn69B2agdGj*m(/G&!m,ZntC3r@gLq+j6QrN\u3a+
mb)k&IEY?LWb`%"GOE'"7U9iRPr1RF3[mlJ6'c]AWm8kP<k>=Ra7K?a1,P2A#7KYBl(eHUIbh
)6,IGc@1GdmX8&QKQ;j:o2uAu=S$aDPS+K2$lsi5a+]AE+A>hq/F?.D9QdbE1d6+b=O2^bF)p
0NR4dCZg1'$aK'"ubjm)7Aem[q4A(hDWcdSgk;9f"CD5d*OuTc5,-IlB_*h-I#NGZH3ffF7B
+Z/aHV^Wie)+bFpG%(?2BYA+U_l*`JSITIDGa<Im+u?<L\oX31:QXD`#KJ"P_kD7NBOV)rdg
*rK"7J?5JC%TV=mP[1gc]A@UP=4-#eIfiD&a)/hW!:p:]A5K4-i(R0S^QD5)-=lE@@c`Y*!E9/
/g5[1i,t+ZncUTW7@&ckFj5O7[6lNddFa.7raDes`<[)QW"j['GNha_UJ0q/TK4$8J7K67au
PmQ^i-+g2;!%<&Y7\tI2pKl_XoB3t4U<J)P]AJ7Z1_%D)5@dN,UYSu2sONM@r8KYK]A$^?pBj[
+s*Pm(XJ)f.;%%fDA/sa%?SO:cl0Q<P#XP-.@VK'f@uW\&b&:2(D/rR2#`^:&+!*'No-P:XX
DUecU-Dha'W'lGhcPdL=t.oLHLLH>V\pI:>RhUo5RmE@mY.N1o,I8r@W\oD_Hk]AkdL/63c5V
K]AVtq)U$W11VB>/-po@3h'&,6F+`&gC<9/LOZkaGAS"$6F9f'S8\<>Cl`%Umh&eKO[iA;rZa
@?pTnDOOB%"8k>J;t#WNgQ1lM6F1nTR#E%`&lK5)hkQs+jg"OeI#t2u9cm%#-ND'92t<k2DB
\s![TLIhQN%2Nli9Ubu46Ld)O0Qq9n:OP2.'qrZH?s45.'[T*Za:LiPm-eJ:\oi"f7,ah@?2
('I<]A_]Ad)H*L>X"E>U^i8f2]AH,o]AY8&LV(/8bJ#NAc+A<"F5G>1$\(mMW%<rlDFrM67TUk!d
9?I85&[9_DUmJ[e/>f7G)io!@?O#p"#MS,I\,4LhP-mPKErC-V^B8*?[5>jfk1FjpiN`cjQk
[4RC2arf"7EL0+.dai*s<*LST<C[j,'u+huC5`U09^WKT/f\/lr`S.33ETg77k(fdAd@:8iI
q81DR1b\m5"500%3UA6Vg15B"f&Xg7sSoh[QNjou/[NZe@S0Z+Vp@DuoO=S-`,$dPdEYh*75
QLk;qV8BUZeUn4E^E89n/%Bi>PY:nujX03R,H<qPc\Y\s6/9tbo-LIm$mn]A3t0/buKPCJ<j"
*$M>$*<6u[!2`A6Ya<0WE#Mum?c8"Es`>HY)CXq&>SL]AmIQ]ABlh+s+g"DR[b\s,UGk@7XjXS
KK8b.Dg%+#YcV4Lt!I??p<VEuQA>FK$Ej)EEi`sJHAX4Kff&ILl\'e]ACHqVKhXIL&"_nSktJ
%F5@(r9@Sqn4Z%/[\>W4S\7e<Ehl#?1.gXI[!?3i&Jr-Ia;ITm(NZluSVIi`R#p#D@H3QS]AF
5uoZ$3'c<?/JrYSZjs\$?o2=kb5TX,1?TmhH`gmVEG;[JkI>$K327T_k#*%Fe^[;+D1ZfM76
mJdd@lSL`?q4sd01jT0*-0k@r;&&e"uS'*J=c#lN%.?)ob:oC#_:dd/5eUlct5"Sp\8jo0ip
B"gf<pCQp`^`*u(^]AuOUQL;[J^8>g9`$=<f-780PNBudO2t$e7u_lZHqP(<bW*k6N9(?/LC"
'8aB5*@[<5B\S%Y'ghm%-.=Rq0uW?d[0d2-)@f3:I9TR=san=CD]A+-lIGb*"34c<8CSPU$;g
CckPLg2tm1D6?j)Eh)V7/R9N:c]AKbsT_#!5.:`p0o7;F0G5.0e"&_,U87,Zm,Xl)C4.?Pa<X
>XW\c+WJ`)Wq9KhBonh/8]Acs+84"KMLI*iaTAni:rXH,OHW2&d8fiC7M3+ljieR5Q2V5pMN]A
=o:+u.4EAe"`LPa"+15/O>iE8tom5ZrY+*$a9=,E_0^02ugm$?s,&8%katZsAbK*[(iT-s>F
KZmI/'TFRVpuNXO1B0sVNR_:!.EW^4.HAi`o%Q&3u)KVk:Ah\QMeL6-!/X>\Hd6cH>,,a$^?
6AX=i^<"!A(1/rB4tnb+L32SN`/,C*j.K:i(p>lu;:*HQiY'L+79_Dl*:p5q#e\'?=D4"p`N
T2mR1`jH`\S&p>"7VAJA(f/10dAVM7Qi4(#kSmmL4;N:Fk<72?KPD1rePeZEb[R2Hc2-T,g#
MtPiq9k=]A[O_N$"[RHqrCO1R8.?\Cc931;2QTAf;5U1F:h^4:N9BWL<d^,L<G\`XjGI<KtN-
Gf*(28YD*j4<R(BkZD0TL^EZgL*L.n-o+O84"7B5<ZMlo,S#7X$)D3XLREc.dLB?oh[EL_@;
IOb0Oc%70(:GE0V<a3bdlo`in($bb#XUKt.)"Q3PYOY#:S!.#/Z7srEmdEI,?3uN2HsN85pT
+tbZeYE"%2@DnHCB<M71VFWZUEr:e;Kc,SkENU1<U<MC`6d_\?h[3rZ\n[E8MWD8T"urV%gI
N__4<iD,i)m&[^J=3L9!L2Q6FH4gB6QQBabFsTbFN.J;\EcFdhIPl6"fj-3VF#HkV]Au=f;jD
CKW^Y+O;8_:(QGLC=4Y3J?Jr/,:*-qg]ASZg;fVhlqF0).Et"/=n%)F=^V5<<X=[+a2IA4oQ]A
CI&!%H5@F-Bq=h1Wo$:V>Gq$AYqajL?AJc#9f>U"=X#0"BdM+u,kqZ%@VGmG^p-]AfkaR9f0S
S]AumDtTbOm0X09O&sUlk!83h.'?06EZZ(r?hW'Id%+o?Y><8q;*oX'r=<g+jq68j)`2iQL?l
`5Z5)C#J_$+G&e$?MTY!e*Q+Nm=q+(I9m=pnd8\T@ZMLT.4]AA%N>Fm@^cY:0N#F0ZejTri7V
`Ur97Hns4_L.JI)G:T-aEW5R#9'\c1Z.9u!#q[)0lW>hT78Co:=WJ^4WCjBFX8hTlh(9i:[g
(XhYI.f?g>5KR54p2.,"tbU)KPd20CX#2S@KDa\cfRFf9J`BqP@.SB+f$$lM/DY@HqO/8hnm
AVYt>.4>]A*i*RXrb7/eYX4HA:uTh7W'FtR_Pl.C;30stedSsulI@9lTTa!gB6W\e6eekiSH5
r!@np/Qh6Ht3iBV8E=sL5`1m2g,<tJ]A>n'C.SDo>"M/AN0bBPHK.aEeMoC2+.lhSk8/8T,h6
N6[R=dOBRl&cLm<m$2d^8"(A>U#Z1Im1qd9Xh#`%:pgQ(-mlPA0=]AsF%sAIipr8W((80A:3G
?6]A11=H%rd:n;/uet),(4M@DGorTJ<%%=a=f1OZ^jl!L"c^RGfe+<gkAFpdoE;sGq\YdBo@P
uJ2Ij#C4?+8aKXQ\8F^GtQG*jXX@\Z$acQt9p5G/rK^fT'4`'79@O$C9bR3iSNrc-ug8>2P5
@n]ApEXBE:H'QnQB";(;eI796+Kn--Z4EHP&_Wk_1g\<c*(Ao^mF1-RC1%b)2[X-p;ccFCt7K
GJ.H"UN]AI'kg/E-4MrK3YZ9V,6*A\H7qt(b5iWD1q9HaBsmr9'b&LAL\>oPF'_i_kE5To&LH
OJes`+@0O$9kEI'P'"`$'7nI\j!k&^@"E[XKk#tL"??du`8YMnup4-=&'4.S8'I"oH)G?=oZ
j++f#4luI-<`YeaZ0NHWU%\K:r:cNPS/SGIGLlIn;J8X<]AD_NjGfOAOT<r^]ATJr3.5NQE9$i
2`Yoi5lS9s^.i&Vc4koXj)5h;@JQAe6IPdDS&Go(M3+d^(mFj[Y8B3;'/7g=5=*6--e1c/IJ
?oi@A2-cJ<nk*YPCnb;A*$nnC0$8IK5kC&P24YVK+2K$crjd/WM.ZuIV8:Na'V-Pk^(NQE"^
Jm"2nJ+mN'r31CATe<[^lL^X+`1>SNMZJ3@e3B:1i#qnh>P:_48Ws45Q5PgZn)/Ub!:fTmrU
%A=M/F`AU-+tQuTDt<E'03NF[86A_88mJ/RWUeT+AGT6uf=)pgX`e2a/?FI@0L#gQ&M`Go0o
Q&t$_Aa^09qV<-Jf&=p;&"PDF#[!sJ?:@Nc&tan(ieB?&P[D&X*`\aVR(j<-%JD?<ZeceX/a
MH?>!3t;2Y1B^ZH&H%,_*h?3*AnLb*beMn)9/g\,W/ZVSk>tmDYJM@ghoVLOsd\M/bq^fTZ:
P<c0WrX>^MEXt:]AS8G`Cs#o\aU^FIH]AD[S^89hljI6!$*[W^g\rht1CtOXq=+2J;4e-?,<ZG
dc[<\&b!V-;00O65di1-$s5t+tI!iV.c%MMFX/r/rQm['T#)Mh?_%K>d'6g[2%jqJ:@?"G\a
)%4l8WhBs6:]A2m@eX%6'gM_J>8.-kj6gA<d>X2Eq)eE2H7OK%qA`_22U`^'>/EgX0_GlC%H5
GAf-Oo&e2'6(DPNrVLfIOV2iJZXU)adHk!Dr?blMcgi'.hRnY'Iq0eh$R6,&dU#,+V?EJ,I1
U*@5PYIPBOP640WB7Y>81e]A%CBf&&'p0+n'+K1qW7h1/cnN50MQ^$N[IX?VAX#*HJWCk2btP
[RLM=4'N>?5"K%Ia7S*OqE0Yc2#cFjlG%G!>Ss[1Z+l!q#-Y#Fdk&a%f@G+Etdf0b]AD/UJM%
<F_J>eDH>ZSR[#EC.'HdbkD6F?!]AaV)Vr#!(BJ=d;>KcN6j"%iUZ.(&NoqZJ;mqleaCJQKB$
@Lh]ALn'48ZtZ`c&M8%u0pdJR_%gWZ[#[*?V;+(tIf=S"d9aVkK,[)M.$?P]AkHZBGVT-mI-rY
/\_M.6h5MBN8qC%#[mGOI5"a+^o@oJ->76[efo[_PWgidPl%3%DIue9IM%s_2Su5$aUQ%f4U
fVYCD+0[^j7ainQ9%p/K*Qk%S"b1!J_,V^6p`Oo;uX^,Z&"X94_a%PmI7XW(tacRH=%(LZlH
p<+6?a-Vk-A*j%&Uaa_a7Xk?3r_,UHHd7_m.6DqLrNuajA%LorWLpe"ahai%fM^bgFE*OSf_
h0gZ<0`EBP4)A,D-3&_(*nIM!\1Eqe.'7ZAKqSR\40>a\Q'4E_IZss,d'TnfJ3c<EW^=Kd=D
'm1Vgq<R$2eeM@`-7-4bMC)IT>%GW\Ni-V]A>MM??Ef,]AM2W4VERo$^r6GRkVcNf8%PZ.bW-4
5`W);6"Per14N1b=E4j'2CsmnAW/!)H!hO&Z]A,%\\s+"oRaP(U;C;:X63LCHP)f4UK!==Zdo
("C"Q;*hFH?p_oDHe:&AsRt/DJo^Je_dK-\ISc+:U;.B//g'o.X'23!FbH<6^K(q<tUV!ikC
0qoR7P*k#GiGchlXoqT2d*73gNJr.re*nCTBcC;juf.b%k.[e.ep`s]A$d&%K?7TeCEEOlPh8
e*>glMMG-QJ;K_YTn]AmPogt\qP-CW]A6&Uq<6B;P(&2,I(1RUeDk=8m!807!1<.+>Z/Mo2"W7
(VhE7?WJdJ+EC"-6H'K!**nQbK;s&8M3n3i-",$#_t+-,+N$Re-4R!=!P/940:\M2J0pA@HK
q$2SqI09iH"-^1\AEnJUD&0>o5bnP*30WMA<q\s\M9[C7Z?8dc"mihARb@nA;00:JjbOC6YB
LehKm"Y9+PsGG<5XZ0R"%QB[%1#)O+O9V*NsK`ESN4*^%3uRf_*?KN4,07dSPTWW(.ZG'ZA8
3RY:7C,X`-<7OS8C6ts?MgHHpjBD4Hc`%.VJIhXpCZMKW;qkH+d0Yog%+L5='h:eG:?MXC5i
(QqD``b+;qT6WbrNec]A'M6u#2F(\S5<R;R(`>\ecj%#:WlWHf't@*A1J64\#T.0P&Q?L7"()
AO[AO%=Qp=p4BkaUbfiZ!Q#`"IiCX.u(n4:!Sk`l=DTXY*;Ua?YZAj$=Xb)U\VW_<dl[irFm
pU#]A*8Y`A:1"KGqHZ(E'G3s#-$t:,p)a.nN\9jN&Y>#[a9u>Ce(;&rUK38^PF:Elq`&3FRDI
rLVZl=P0J5hKM,`LS<.bRa*Je>`d4A<T"L35;'H7OXtZ5/G6P!Ae8rqC]AdRs1R.6WibmE=jn
GHb#M?[?#H+iWWl^on<FV+Il:/I/dsl%aT)bYuHJgBlW7^W3liF:-gkA1E5,;Wt5qH-3thH4
?u\!G5HS"5be>UB6n]AoXg^1-g7\Z?YW(VkI#\i4%WK0#qbSFg5Fr\k!9X;aTi$Z3Kr@mI"0,
s/h%"uVXZkp.!]A#F<M4qjp$JoGPKb:>,l``Y:J''\6(H'?'UmXkfkE`PONO65p`-3\SI=*p>
`dp@e]A)&5B+pso^G'O?pfQ;#ribS]AIr!,%(hHVh$\-:a?;rR6deXoi0)"J(,ogI,\7Mn<C8B
Wi]Aha(K^[L)_j;!S%&ltMJ$O!gL>S+._mE&:9o*A^3XDJ&%-MYHK2(g]A!h<&\6j)n++XlD3[
Sp:!2^cbbCc=9fNsOdCCFo2G%7E3?h"7^-SEip*'Vmh"qBhXm1*=$#=VEbmV/0P]Au$cPb2L&
[MZ^aEGo23t=^s1pXq9I40'8HiD9o&+FC"K1j0?!PaF?YMl_HBl^s1]AQ+5,#N18B3#<!Lp3>
p_2ih10W`.o1T'PG,[*.%OQ:-cWOt*&0#(4L6glaokDYBaD!h5s2nOGKGAJd:J%c>.e1hhLQ
EPNYDnI;^5]A=`3NKspp6-d%G./2<C/Sb..)c00G>Q&DSYo`6R%@chdYQWrgFHRr%>c35jfp8
dh+2TAM@EL`mEM>l70j2QDJ@3qF&NHChSSqKKkMOC(WAeHH]A'J>'0##*e'ob<.+9(rre42Wk
aRaI[RB4QoIq0>/0W&_'9C%k,u?k2+JLbDORmp.e'%p2`#@9PZJ%=#CJY.00VmI<a]AJ'&/rn
RH/I)YmuHLQ,pcpqa%$(.+h4-\7BHs/]AoYO1bJTSejk4_KOILCRU3Y.CC;kTQnP#Y(CN:1X,
]AP]AY<VTGhbFib,`5nk#K2`UN:6(MO6t3HJ[kOJ$Wsq;OF&2=_U\LK4u(c!aS%k$;^a'TE?T-
a,d1A4pd>9LsJpiTfgTR->d&V6Zo8!2maDhOjp"0\-Pa[4:.i"bCo^p3@_GQ)Qo>9g6e8(L?
&#T_uZ^q1^JZD"hV@VI!H;#^*<b3D,Ab<d%I*VmKOf$S)&cm''*+SbB=VH%YadnEAO"Z]AS?Q
:5uZiMZ\\?(igt2WjRR_=H6%i5&#4LM@"-5aR#G#o,klUc@2,60Ju594*R@eS\*^a@@(:^N`
?XJmb]A,^^+EDGS3>>nh+VZs._-,X.?^2o7o_o/F+2N$"DTP0\I6P:l'<GR5nh)W:E\G;+A@E
Qa&j!o[3;lOZ"TtrOjUV#ki7X\+P0mVX@;'d3NO+VAp4n_c,s?r._N6)bX,m'c.@d<1n/dNB
(t)dmNK1e367hV>pZL^"0uQYRFVW\h.G*Cnr+Ng\#:pZ4=8=@S*SC'^=!j3rGRQoNF?856^f
udRZ;F*b"%JTsE_Q_WK/LMBg!PZ,;gKu,K9hW>n=j.-XgdFr2%k0(9L9Cha2$g_0[&`^S?Uk
sqVp5<"'Tp_GpME%Ltsf>/fSYorCgG>6KOP#U_V+Cbc;TChn[8+Xr[P'oZOW4?4"4r*M^l\Z
%N4k@C]A6+@?UaPUDiNT4]AVHb)0?$_5E'"\AQVW(0U8p+Yu1(f!F?-Po<<('[4a-GBKCFWLF8
X]ALG=muI]A,TcUu<e+.A;Ae8N4cZP)cWC0rk)B-Ij3ud*9@*rE]A_`<I_au9[m)e?X&mXC*m$_
QreD`;'658kpDJ@5B@'o43k>Ui:=>i?>SOJK[s?4XC!KJk#(&q!pB*)6a.%G4bhsO0IQ#(?"
nrm!FJLk6ls:\gmSHn7Iu2ll2_8%lW"m5ek%664Ptdk)iStA=<ae4:PN`2#>%BLbcIHkN(CN
C$"6bl#61@.+'-3\5Bo?_p,&J1FU_%6<[[%.!eR$9Sd2,!TnZPU=cD-\!/%)[_%p*b*3Fr"B
Gb$S-&NDo5C`nq$68<fJRe9k*CS%@j3(`\KZ-aiE/5b:+IWnp94een5jjI3NK.:n6":]AiGjM
_O[1R]A(ICA:!3T3'/NBr%GNEj$hb[94Us8N*~
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
<WidgetID widgetID="a9b555cb-fba5-417c-94bd-463ada77b43a"/>
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
<![CDATA[1188720,2407920,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[396240,1767840,2621280,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" s="0">
<O>
<![CDATA[事故数量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="Embedded2" columnName="指针值"/>
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
<FRFont name="微软雅黑" style="0" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="176" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G-C'6fo.Y1Ij+GJa1Jg:D%?h6MIoKl0g"'d4j%NOPm#-.m%5FX;7nBkbb*>)@o'aP>A&``
n/H8iGK@824"O<V!MSPSu=/[07#*#`)>W7`8^<UdGd30ZbS]APIfSMQ$d3d=WbWX#ER1%qL63
NIc&KKj7@\Ss-9^Nc?Naj"*&=#1R:21FB)T$]AtCkbH_12`IE[n!b+<o*0!9HXZDC4T`Kce9/
QlF@ZLO^(T')>6DXLe6[,]AOgq;3i%^[fDKRl^R^p-VWhrVlEC+4%;EIOTBr486ph@u&O`Nh%
DaJ#X[*r\K5.ReA7FU:r(H6;OsTU<qc?R[qR_/F;ct)-(b+;cW-:SNYh/;^f3I?u$M7>tYiQ
=DV:XDmXL[XJ@l,Da(6^o%5g/huCI(:\IH.^<JfnnDTW*$i`cs_[Vi"*^!b.ABiKD"<ho-bA
-FZR6UVCWlTguYM/#rqLmJdk]Ak_=Xo+(fhEY*%_'c-Uf6BfPN/Sp.5KWZt:A`TOh^1MZ@=^\
8.'cm-"W@9"45S)jiB'T7QBs9o,**3WF9omT@0[t)2#Sp%HO8uX4hf(Xegf'DBV\>Oj.C&cF
n!r"#+qaNA<UY4'm,rsChB:*j4='cXuU(AnD)C'.`K5AZ7t<*$FO5e8NXRg[qicuSBSq*PK#
t<g$/-+\pAh)Q$RLEYT'a+J%a.3$"$cDdtOhps+O878!?!JZ\<Kll[Q;V.R)4N@lP4USfY7_
'H]A:_/u`MCBN=Q!MY8$P;X6$=h&+FfL,:)m/Ktt$:6UT2ep+N.@>scTUa"WGQCRTs`*-Nr_9
cnSb2FY9I+P<=IF3(H>69(ImQo[T%%X;355"<o4'c#=C:FL;<7\<XV"%,i=J.f2C`*ufG#%K
;Eh)b.?TM[4An$+_U&R*ckPCa,048"pM>MZ9As;aS%\jJsS^s=jLVe*FN-4ZEnOBk>T=n@@.
+']AFCo[.GR@)*dOuNMS0Rl_RRg"P1KO-^@ol&O(h7]AGPqs03-&2*PiD>@__qdN%Urk=1Xo!r
m,IRluKhlCttoZb;Tbq@7t7m>1Dc]A!#=KNDP5(=fqS5e9Lf:>CUP(f$5]A1Y7FajdT1]A)buFV
J,?8E16SF=XM$6K[oG#(N7V_-ST%p'G]AC]A2eDb_NoM8EjA&!F:Y/m:iF>nK:WNuIfR9!>cm<
b:#77\'@r`S;q&i<W@q1Neurpek?@Qng-F5b$2J5r.Ol%2STT8VQhL;WgIL*!Y\7Ia$<FH#a
diY*[KS`ItMFI;SARo[")pgX7Ekof(^diHL?bS2a#/XKe$r0.%H3r5U$S'J5%hjtE?"%ql>C
f,n1PSpD5GiQT`pgRom=UlP0k*sE+.'<C'k9I,0YJGt!e&CS/@Glj_QXuVB/+WQbSe`pR*[$
DbWU>nDh%l8Nos_g[/X#E(-j*0n\CL5)JUXn9<o1:\=+:(r0sk"6kS:mef&%B0':mR/-B0_'
&`BVS./kD5^1:2kon`@_2cOh:(e;2=a&Lh`.^\U^mtR^YEj'ga<(4;fSnk94e@cTF8";[%[>
CuHK6Ug$[VT5KQm)HLVdZ(Ud>"#Uh+fGmF#Dh+4nMDtXkN^HUk_J?;XZFecOR*8C/77"T9q2
Z^[CNhg#2[#nthr"K5$gsL,bh,4&a%]A6,WY&L!o_"l8EY7@n+Cj3eCk;a-Cbo`#m\a9i7[#G
YE\rZT1/=_5Lq<:U/;>o`\UM@[Vk#8,j.NGa(:PB<,r6b.S$u\2N;N=,h6FRe3Oi+DG=>T=/
Ke%Bpn?f9[HD(^+l_.RQ<C9(dLMYZNhGW]API("]A<FmGO,+If:l6lO(Pfr\gBSkI!oUL3EB2p
c!`W8/4if6`XED7_!Pn;hk:1JW=:`ZbDmdeU)3r1F*NS\a7-J!e)dWX2m_F&`6rAJq&6"W+m
UFfZSYUQ\T0O,'_e@hI!]AMN]A+7@e@JDfj<EUt)#68Ao\(82")l"F^RXUEP1RbP88&YlJ1I0.
aIk(Vgp^4Nq51]A@aKi_?=mK)cje+$jkRE(StdjQdBHr2_pm_cY,JiorT[\7#/P?rjD9.i6(=
r/L3f9c(<4,CGh*1h2ql2;\=9^ZNPZ!&F0#dlXm(Ts;BX\WR")8/*-]A)1%K_ulXo5O4?l[31
=aJ#D2=n+,bHL<2R`G:X5"KI\$?e@\#W1?d/,)"3Z&c:!/qb;.?44$u>]AKmU!SOT,J>bR_rZ
]AB*qI!XlA_,=0]AdM"h&@m'Z8!c_att.olBBptiiY..PNl3P#?j<cF_Bo/JkD'!SpS3NZo2%L
.+DdJ$*bDpbH@l^_YgHP?:/+G35'.p<*=H5jqCC3a`%NVD@:j=4JX\.LZt\ZJrpTio+$@O\k
k&FUlgPD&C$I&)Zu$oH96Aeh,k9$IIM/Jq@lV1XG?/rM8]ASr$R^Xqs?4$dXBfh.;V/70X)E)
PLI;Hp(^cZngLj#ga=t>jot#R&$`t&b$E>N.*aV]A1N-#QfgP@U8pp&bBjah04Nktd"LjHhWh
aW(7!bjjb.-E2]AqC.C(?<@QFR%'[VTnC9\VkT71gB!Onj?BepGo?'?UT@!QGe.qsDJP=I+hU
WQDY6q?(2Ze\:H_fDG6g82C:-_kJE>TL,V6Gq.5[e!L`(s)%odZs+5ti/HOW"JZf)r[O"s$P
S%cNN(NM^>m-tM2F`Chh_FY&oWF*DWR?QoT%NI2d`^IJ=b^Mc"Tms"1XgECW<F(7Db`E"!bY
[p4XU7^C!L)7D7Au$;GPV,cGWQ"qj"E(`5Ub/\e:XBM#aS.bXn\Q\U@/8hbK#_,Ab_KlY"fE
W`pVn:4II5NH3<5jBA"_*g2>G2b%[@)3Q(MRSLs_P%EuLJkA0h,e0d]A\GOB1l<AR+eeML1el
IR[n1eSec$:#?erp&D<9N;TtmES:k<-fb"-@;S^C<p$o6f6Q/SEc(sHSij0bK.Zl#NHLmeHD
!Q3U+`,]Ag1[cPf>[2r1aI\nZmEkqWGo,VoP5ctk!K4q^fA1PSBXHY3D;DY0`K,<S2fL[2'o%
YVVJ@(meSBmoIdJ5jOp>fLa"7*c$FQAH.>olaN;*tXu@P`pW/&@%>Xi^g&I:tr3BK(JW.NsG
NOTdI">c4@)Pn]AVk#Bla&K@`VLnKY;F.b78KW,NWQnSTK*iXMS[#0g2QMs`=--oadh^s=3kE
ApHd+cM&3V`m[(585``"]AGn%WHIR3.U:(>=66eA6S)OFn;^,[ChO(#Ct"9[6JL9f6sNid?$6
si"r]AVc+;u"he4q@t/2]AcfNJP82Gj%7,"%0Jf9j?s'[qS><h#Ii(I%/;!T_fnGPKPPb;F80]A
T$odGd"mW3!F6(SG`)1rE*4)?!TY3MN6E39Y#E,g>bKqgbthgdMd^F"N1gSaBL?Z%$]AGrd3V
jt[nN0k&9[G)GOT=!,i=UN0a!,FO@7qtVV*5"=Gr;qLQu#5<!kT%KWL6IDM%E7%nc-SrU[Gk
nW"1)YX`!?3^p=4l;SW]AI%_o*MI(L6,]AT:<6`&ZVQFWHnU%89V&kgRQkRH=o7D$1$/_]A57mr
Cmqam]A;MfO!5&_MQ[4hkQY\nEmIOVH.U\:m$,J`Y9bU^[4rNq`/H9Y6NI)g.GUX!V[>uu?#3
,+(/82/">)(+aLO0]AgD+0\P=>:Nl>AmsW/@8u.]AU"mLKPoU3;jX's0)gb]A\kh"PMAEq33X7!
8Ds%Q_2oO>CP$]A6R=]A&i.L#"?;M,Ws"Rq2CY>NWc`a`NNqs?qh.lf`1LE^.#K`+6/1)+o:Qr
7!gm2,m'-7_tR+tW/.lck"-Sii;V'0iiPI,>X^0]A"]A>pRcpU`NLi!Y=_[4$Mld3-sTH"KIr>
,2mnJs+d[W`S=i'%nEQ&`JeLBK.g!&<0#6)B3h'iPp\WR[.0mT.o-DS+H,\(iUJ=alTX*N`5
P0F&jHo3$$bSA8,\qBM'q@-0,ABEO'+<nG_2<?F6O=#(J\6)+FW+AB'_#qh!jGq7Q-(4i93Q
)C4TJH))@!UaPFrA/;%YYAO4b'iNI*6MfFal=Y0/8L-0Rls0ST$AY_/%oSdFt[8HR"JD(D$t
Z[qOo3'9<&q@sD4D!6ttE%=1gXJ^='4&#8?3FJ&'L-`GT#6F:S%nTXN&a&AL"^iQ`9ghcL]A[
71E<US_!aa8SJdu%d%@kbe]A#h(E>VLFcLP2:<o#mnVk1F"NaQV%C-**V[mIFHs09:c2l_FtG
tGA,R#"]A9eJ=n;\8q@*0'(p[YRW\@$P_145U(@PrQYCYs2:7(D^q%21:E3mnQ,DNH?`bl[60
M!H*"_gi-eIJ$4)WMZko'N/:BHppXY3#WZo6.*9Q&Sr=hs$\k/CI[FU#&@kD.LY4$XAVO\U^
PQ&XZp:HNX&gGKsGGU8',d:k0it1\m7i4#WH&K@[ngDETg1jNe't;'o5"97!B:'$,3&h_a*E
WKu^fIa6ogY5iaUkr%j1H`#Y6"'e'Y_saulkF8`Ei-<V'A<YotrA)VYTQQX0Qf6k#[$KH84o
ei4>4iORXY'bc(Q*BB6\/?KdhtA$GKu/+kC4]Ab;EZSRW4(c9m%0+H,SmJ;N'Q4k[&S"_B]A>0
Y@?C]A:\[-.dX#5>M+2#cXnOL;JmMf1YLaMaL0Ggak=p,s,.b"/c/"#mmc3):Z1n$pWRq!.&N
8g4hilJA2_6Mg)?_A&q*=`\;&-A.-@hLU9har4rVG:n#oJ`g^JP1Y8OA<.WAOQ!%VHK\)TF-
k:V&;Kuj"1Gt23%Ve=H5Pf!<mt3Vh.:VFLqEJMKRlCW6.'jRSUL-bLG#)ZaHco&80(2f/JQp
rKOM$S-F'I^24fd^;EE+/7`1S<Elhg3Y*ji"pI,b1_m\G>k9[U=AF,F(L6'65qB/hG8Qis,P
4.dpX<MpE"dM+(ZncjJT["F9M?g70udk]A$(PEO)cFDV(nX50.6+i')f&GR$Oadklt\sdo1ei
O2AWh^eqV/tYc)D@Y"!&3EW*j9qdP]At8'U%HQ6Y'.1#M;L=PWOdZJ*i5W8LU,1=?3;rQ5E%5
F7.ULe<P7,cZLQ3/BiqF-at^qm'0PO59NB]ALa+=-%C"]AE'co.hU3f<C"H(/3s'k4h$OS?\b?
t)0OABn=5!s=#&3+PFJ]Ana&`Ycel1bH))@L`\H!(^A>m2!r%Pe+rI4FANOhgmp&kMO>n4lSl
?PFhR'h!>$/aR<WRg(b6i&9N$pDl(A+8#?`3*p=/p+rmRA&IlhLZ04jd@no/F/fgQjC#0!V.
c'Q`CuIs$?LGK%3j$h:+=dNh>s^pBTclL@H7.P7]AY+dC4l]ANG%k(&%ZV#n+N/=^>q1_G^''?
EPm6WXiSd?V0$/QkIXThsEQk%ds1*/arR:f>f)Gg~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="323" y="10" width="137" height="84"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="人机比"/>
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
<WidgetName name="人机比"/>
<WidgetID widgetID="a9b555cb-fba5-417c-94bd-463ada77b43a"/>
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
<![CDATA[990600,1188720,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[396240,1188720,2804160,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=VALUE("指标卡",1)+"人机比"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="指标卡" columnName="人机比"/>
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
<FRFont name="微软雅黑" style="0" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="176" foreground="-1197808"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9L0''5+cIG1Z,ahNHX)eQRN/f<q\W)d@HI^J*BqXkJr:=fmUFm]Ar+#D2J0]A%"q=SCpk'PeO
Dr\LfTA/1pq3?.3Z5R8gO=&:dO2UU`fm%B1N(q-HXKeJaRCJ?C?j\IJ0WWI3*fqT/5[-k.Kk
?k<3J;Hi2OX%o%@tdY%o?*a8*NdPV[b9Opkbn?\I1q$ZJO%s"8p4CLS-l4lsa($mp8g\U:)I
%0[tpQ]ABHikGi856"OAcS&!e\T%E8N"7;:@m6?Wg_TP-j&6c!Sp=`6CX5[:'/soWs1@[E0DD
S/n`%Kr+1CR:hLW'abWcL7B\D[*qGief33O9a;8&$PqjIkZYb/HU(#,b/<@#0UZnj/4mWc6r
B7%,UU&5djiFtkh/Jh"e;n;r+^tc6[3?0i=k2IBKn^9)T<\>!JYA\KIMEQ;:VknA$a^rj;C;
13)CtaTQjYGHAg=f^Mb$r8agU;tacu5L,2o.SY@#ZafZc-c58[YXX1`UT1A6a+3rXi:IS#i$
?'.:uN/*e%s2uJe0G5$M?WR,@DZ&poh\1VK(Wbnb3T/nnQEg(W=*.4jf)>=l5fGgVsOQ@W:@
8d??gp@$1/?55T?%:uE4kfHsgTJ'<Z<$(R-S7q?l162AGKsj0ZDl`)2WZd+5:`ncfMW"n0i*
JGg^eMuYD0>NajQU98Z/()MtIlYPNV(d:6#1XSP?Q(P+aF2A#-?jcTQ8,H4:D1csC_Ta*%.I
Y=bsBpU@4tPagsdjeaBh;+KrAT.^et\j^kTqDA\1B1D*HW6=X(qX.8ECbhVsERIGA\XP6#h5
-MtCiA,&\bRDMW$%qV>kkjN=ntlsZp8!oF^8ECTd(_J2+-[E'%8&BWU!M?A]AOW):g2oW")^W
N@Y:t(>0o2Q(Q<%qV"X'c]AZiT7rNt:s`VH6u\f>H(n6`Zj39$_H1eQMYI60:r=d(iC9Xafi,
C<*b9="nJC18(T<Vo\[>2C>F"o>esa&GO2f"884U3!96jieNJU1K\W[#H#CrrB:+D'OCc&!'
6C)`DVN=_ZX0mc7j[F%hIY5=kXB)JEK)8EH[Q9d+,`DD)_p@!kO'6M>l?/dhDa:L()F(U_pE
m5=@D8>nIgCUn+hl]A'Dh3^`]APbXAV-h8?9M+kd<+4)0mFl'!PD3gZM-U$YrP*R;,WkG#<m=D
BfM:Z]AQ"HDUYu,10/jXj_bBb5]A;YWJbKhs/8"\P,@.9]Aq7Bm\^nkgM5j60HOJpY5BqZh8K-!
n>I(MH>pL'Y4YS.HKoV#\e)p4YgdV&MD?H4I\#cp>d';5X&:MY!:)HLBU8OA92pb\6fhYU32
Y'LU>cRZ>n*DB1k$3rDfp^b'h5?SsCZD&%4^&N6j9Q#7kp@):f9=au42-12G'=t[o^T!H_:0
]A60T'_p(B0UQ6fb-#dqV>_*sZ.3(4L.hGl%Hs@,uro6-@HspPTp\6<IoNIkWC.COK.Ub3qiG
hOC?V?1=AGiDk/uYH"+5NuVDaUI_6gSNF,!JnEWjn!S2FPEXNKWdm<nfo-Og4aS9@Do7\B$U
0kgNIIX%GH2Zt0m%;tc!8kGl=W`Uo?II@@i`dbrdB_cd%"/qS,g)W&\7E,pWZjU?)W?80&IU
BVnLhZeMMVH)HfLM;U$@9p60GIKO9DTEAN5X$\'<Ym2pc*Y@X_VB7e$_LP/G/ceiof5>SJ_n
Wm;U^YQ1mDOS5n`'2--)!+NOBa%QEIT:8;\o[KYam-WWQ*D-bI[f%f(?t3#]A1H3?=flZ^@I+
37B)3$RqI/Z![!',%-8%>';^%RLS9a7+JR2,]AiL(4B]AM!$f]AA+ZeCuS_iD7CP)m;D250!QA4
WsrWNGO;(JfW,S'P^Ra5&LhMl+sR6+6r[2kUd7RBVqVZCp]A?BcqHOr%q@fCl\!'gG%\<\B7.
CIQHI9WN'0C]An"2TH(:r<"H6U$.[1PDe?ktlM-_6b=F7!d.]A#u[c5e"&F@PZlJ>^sgoR']A(g
d[D"-^\r(p9>hdt=-\I^0:BW+f_e(+#_U']A^hG(8OT9lGK>J^i;R;_kj$6e)Xib-#k;q^.pb
[H2(0^Zj-WQ]ADW)s1>ir+j8l'1Cap5D<ZDhscpmF,tIBA2*8T:AG<aG.aC>,i"FsrQ9X"P]AW
X]Adc2gf"FIh8R@UV&50MWi<PJ%Q'<.`,1f8aWCMci15`ha=N2&3tn&3L8NQ1mc,U/]A@>i9lX
hpoQ`NaF=X%69`:6sGjIfpF:<VIgpOW*h%HbH8=M#D?o.B8V+YNMcUrV'-[Yf>bZh#r<4]A?e
"BoGV%Rdmp9c`bbI<=G7X:uo?p<ZOVUeR:.kF1(C\qBeB50?6Ms\Y;sA2&2)f\X"6RE,PM+K
B50/khEqR6*\1[?<EL_[4=]A+\/V1cF<G/LBAVTZ<IM3*7d($b<GlI!\CQeXoAmhL%QOKt>L(
KguM@\%O-obO*^D=B1!V_/W.2[O'oldnKCY[7'jdZ2q_X)*0bI:']A<JTH*/*j(&G6]AO/FW>!
LShtQ9I*$u@6.>YYQ;bIpaZPcA)U4I)Kq^GUXN147SiOJ//r2fc7J+oXO\R4N`#SGL"/@&9K
W=mFG6"kYcMZlDh:I[R0C?CB%4]A@RR)jMT;W.0da;c/5[3'6M2R&=S=Sed$AkE2nAFW8(FEn
!XJ)C7=Bf@q>-:DiZFZb3hRCCu"%2*rtM.Mt\IK$cK)M16'&mU7O"D!<QZOc&ljh*tU`$<)\
,;=!9iAN=1;+t[F]AUPL$2q[LbP.]AO=:-**LKqPZAbd0eQ9r/@>qWK!$cCSaBK$N@3_:\WpBo
=3?Se]A2pJG([W/s$2dEhWXKlS_$$f%Fo%R8aI/C.Yg!TJKq'0W_%H;*qgLbIaL0$[.C%(\3!
#BUqE3XOD\2BoH'7Yo-H^.3cd#\_lRiU=0!a<_pm#Qqjt+bKEg50,CeRTG.CJd=cJt2O?=,Q
[^fL/Q"WkoMVOqOY[9ZH9W-pHiKI"fLmJVNWkoUKZrl&Cba$JWV^Tq("qp39P7I!%D^/g8.Y
9%JUAq=@r7o$,csMjr@?3+;"<7IR8$X2PMQfL)f$RYR'fp.TR-^6(`DCC]AB!S*'.8#6Rg-Ee
rIX?\%jGpZuM=)jfi^=W,,_()u9^V;oj"]A1PqggJ!2oq?88j,DJ5XA;1,0(\G;SalS<='\P8
<0^6]A0-j'8b)e[8#/,#kj,s#T[-<k\#]AJY!DeaX'!$Y-O5cuuS@F"K>JUp(:84eo:/M^sF=B
6;1S&W=q2hJ5'B73#,ARN+#4U9c>Us$-:5F:Of+^7qnf__..oh8F4DrKlQFc'hk=J'@0$/Je
3+SUHinr_.dVk.kp]Ad:I$jUM4hd'"EBl$%e&+HhN[q_)U_2n(;31OYi=Gq<HAr9c,_qqgCA%
k'M[bc(g>>.\1hbk^Y\CSI>pm*"aonW]A[e4=VeYU5`+ShaL4\*ki)7B!u</ns1;^!$QeV9k;
]AaammW.A8;^nQ]A'r-Bp]A=R/%*<\X.)#2FWpi5P'4SmSUd'.)K*S,GT-2a[HBIB2PR+@7#/0B
*np*c_hsuT1K8pnQsh/?!e,,_\t#UQMFLa1t<M1,YV638YiOhH\D$ua&U!:(m]A@;bP-LaTH1
1IT.N)(q:hT$Eo:cI>sUMJP\aqE"3lQq+^'A[p,NO-M*W_(dt;0hicc$c"us:ekjg4YjH,J9
Lr6$6+0U5\qFR<1j)KDri3,Z`Bm$pKSgU#Abj&4([LaAd]AgR0o4"C*@5#+X@m>q!)P(C`)%D
VP8XYoes0qDf<Gtk$(dbT5CFS+@;=*e*.dYuTFZYZf;BYHH@:E*Sg>5HjCLa`]AlK!s624E><
nX7T]A/F^IRXU16CsVJ8-FFj?ac=d3;gIG*hWg)m,,o9R"P_A[)'7BaEE8&T[-Z+d@lrrmLd-
qtK^,?aM.jB)aUIlgq;#m*/aT?r5(4/Rgr/..nOl`ARLH0bd`.A>[>hYd\E0pj_Wa[5kDM+=
Mg^Q<?dV@`IlQ#]AgS*T&PTZPsAM0M(Ho:]AF/bkhN[.D7c$;d`jF6kttMRQ'Mf[r2R_gURW"j
_/tsO*+YA<X!0-Aonm<;\D&,fR\JlgDRr)C:,$HeT<@uQ3b.6JAPjlChCAt45VXBa^%!1>qN
JH?VKDNuU$rr0[ab?4c"O+[CO,ATg;^nMPe?iZ7t6$ggNb75NlPk<>N=[PCP%ci\T_X^r*Uc
G.,ZkDqC,C/4o8*fLV+&_:02pePQi0jNi%bdQEh2O@5$PlEoFq(&&o9?o#aclfhO*,3@=dj#
D?VP`QJQ,B>NNoQpN)t@^0%"\.dd'Q0XEI`eSVp.fn.arT*BUhJ0a7E:;@1)F@^U?R`kH1?h
rn_EG&eOajfjo;Wq0i6DgRF8&i?KpQh+6?P='c;6b[)0\)499pN0$u>US?f&^]Afoj,+SJ6F@
(.=Wf"G7&P0NJJF,TTFUjX0(?lcqR%c[!Qh/N<A_^&_X4?hG[.&Va&=&>VF15D@c4A;k_M,,
NHG`<G9QkINaP9HUEiqITJqFDCZL&8#V.qVB:Uce`b2R38Og6jbn+Q-'0,Da\jJ>rY@8)"<b
JPXXlp#a@T*&r7n,gIFl/V@Dqb:7G=7g"r<j@XYd+i7qg5V(d@tf-LJi(pLk&-7'u=-aC@OW
%5.:MRQl.hJs18Yqp^]AP5lAX5CG/G\c!pTS@ugBWDKF!Vo6kgJ@@p>[Rb`e_ciF(#67oXiB5
HBHES;f:"NPN1Fe^NZ7(k:ZACBHEc*"^$RBb7HC'OC&\C1gm"tiMPV>g,DF-k1K2i96P5ks.
pCuA#*^#95'RQ63]A5\-??8fE%mW^S8,RQAbkbok-XXiuP'Q'*-[RM2:R1CtMEG!_l*4M%2Lt
%p!pV7fGiU/7XBSceih"JULP`Kq@!;s)0H8-"r!3W6j6lQCg'YI7S(dafLEZXo"">KQt0qm5
%G?up,<:OtPnc^b"[am"Ug*\%F;Lo"i>O3=ua=NV&+s2Hu\":qI.e\+dHE^7'M(XbBQ%qiZC
#'M<Y1BjgKAKGdYN_(_`m.^OY&s3'`nG@N9BSnDdW*8RGGf+6/N8r[.EE$X`]At#oL)gk!AQ8
2A8X67VJ\f+n3-Y'ag30IN,_eAU<Eh-)[CI,HPWZpUXa,c33Et]A\O$3eV,S!p)S=Xl@D:J0;
LTr,.dhYc;V=@PM&QM#FXIh2Par#d:m$YN]Al--*&*:X'oH(Z4%1^2B1qGc&+:'E=TlHmU3K4
Y:X9$Irq8k8qRfiTR>-r@$7MB!4Ypp.a196Amr5a+)Komro&]A.*uj/+?FqTJYr8>%KGVhLgt
m;M"EMo:XVGP4ou"i!QG,c7k"hUQL.eSoECTTc:nUZAsQ]A/l")VI9L_M4bYe7^@=o+8.u#<@
VjHq/pSO(0Eo%c@tXIX.<SG5VKY-g/3'UKbBTUXI5lH]Aqd8@!a*>+qpNPHk(!k=\S@<3ek5$
+-gB,(AHWHA&A15E+-LkNPUAPQniu7'Q"QObHiL(!a+Rl&t(oA<%MK55?8.I%hlZ(g9^lckZ
nt!(6KW_1@N.bls0cONH\17P_`<a#64ID#n>]A<WZks/,-Pl$MK`aFZaP_JgPr,ZnHRGhaS#B
O6i-'d,NEB=t9<61(X'S>32fsk=9=GJhf'^[H*8V(BeUiVsZUkDQpp/m8uEDW]A^"Bu2`NY`t
6+cra3fI$ienUNAiQaB22pV,NK-CbOdml21hUqKF*9+'V"Z+S6<<_LQT^r07b,N+@gUo?Ekd
fp-3J\'>Cd?+'=-KLO=!U9okU/$A_fLWB"[$$.""o2Ahgi)3c"R54OrOJ*+CcJ0WKX`h4VaB
iRl=J9rpM@V6`/;RDhK\T%$#aZ)hjW)41^aahKFkjt^Bfcugcc=5W-,46YcSspK(?M9kZ2<.
Y(N#Q53HX<FVY_Hl%h[[_oK?)M1@*Oh__*Ua9R@GQKG<8dr0^=d-gdO]A;7D?RA0,:7&NlVV^
mZ7A4>J6\[:f\a\=t@@$qj>IpU>uad_)=lc5"K?IK_+cB$"@U;IAU6Zi,J:1UFi".r>"=Ehn
pM#pH%o,0^MWY9J1W9&rs,M'r!l1$G9Rnn.EhZ6Jg0rq-gmm=f:FVLO=Mjm[rHZ&8XT,2@>?
Sh-&.g_@N?G$X:Ec9>]AM?Bu\gW#q%Y-fq=(U^H'$$+tlj7`=[a5nB-`[Nu`9Kt,*>aT>%"o.
6<FJWI@Si6%1[,OC6(9'9?E9V0RmG!<he+m2<%IS$ZX]AtlIF'S)=;G-]A3^+IEm5RNp+2ZTbr
fG@2qU$&k((PGG$&(]AbNZh6"iWOane;<.A`+GNeKgkSArn0fu'[4u;LnQpZEd@Cc!04_%Kk(
g1F7C6<AgjXO@P(LP:3[hM<dmD7,+UnG?$]A/[58jHe,dV#@49VJ(MWmC(hfZp[HoY,&BbP_>
_h`g4br"cDRI6`<)X^Yu3F,;?l,g2JU$`R3McnbfZ[Jn9FE6%'-:"Kj#N=l?ti5+YmnFTbL&
g8M8S.b,V#D613If]As+F1bW2Yn(e'M5o[n$gD"nhC<?^*s)H8h?pPl-3W?sLD7LG0^8-FAlF
l]A^IkQU>3JL1_t+NNR79GM?Be[YS(1qt+<LqWf`mHZ[c")K(R-Zi>E4F9Y'fH[>6+/7<NQto
-]AS6@5-ZG$i)i;B%5AP5QM:!O_>l.SG'8^.TK_ahZjjPe@&<o[!L]Ap[>Xk#j!`Qh23K^SOKE
8H!A#)@3"]AQ:mX!o=[TOSc<K-GKaqV<5#6+#m'2%m`/%3SL[IboAQ,ln(bE6OI;_[mrmX6I=
+@pCI1@i;??fpthcYHE_-bFha\TT+*k@A$G_8DB*aJQ4NJ4%HQ&T-bV^]A]A0WQ(g1]A^*!.iF<
Dq@3jZo9/=4?c#aRGq+FXo_2(bVd#2,O@&X6*UUBQ#E"]A$/a?BUa+a@d#t@kdW0%%AGnbJSo
bn<u2\S**#d0dM`lnn:q%);@rjf1F,Xr:1W79EbZbUN-W-se8bT\?AsCJ\Wk/tOp3=d[)*JO
(R*jR[qWT_,>l7uB[t7q><q+]A+d2mEhsg9W"60\lH-H\]A5mF7NM>t'l2ifs$1[1[W`FZ/>?,
mLYMV'+I4"MBRp3*_RD]A^'"JSsi69?=(VnCPe=PuQT=C*^<O0\<$S(CfhQ&D3eRp5!W*=#ra
Bj*OQq9+3o=NG[>FTJB*&6fi\@BVTbtRAeM2q,tBKe5^QNY'Fj/3R!RF7>S\h:eQ(+&B#Iu.
fs/`:onn."+:PrVMhK+a"/6@Qo=Fm;LCla^:dW!2m!nL?&^&R9D#R&NiQPaP]A3aW04<rC8Qn
!:(P3R:Cs?jbUN-oM9KidHH=%M%)86S;Ifmr&@.X-3Gk`glBO>YY>-EK.i1Ortg'a?VE:L3i
q/(YeMRtYPj*<[-gi-*Dbr.a51=hr.EmfA)=TNO2s!-r'>WsmPP0uYBEP,?\p[[P)IB=Lg+.
<(>:nF(HeR]AitSYs$)BrCmk6)u^s\H-YFrH>SD[2uOQba$p'S_46_8@-u0RY$0E951;D.FLZ
4PWKrV_k>o<*k5\UYBOkXTRNtE(;'4fk?`H"^B"~
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
<WidgetID widgetID="a9b555cb-fba5-417c-94bd-463ada77b43a"/>
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
<![CDATA[1188720,2407920,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[396240,1767840,2621280,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" s="0">
<O>
<![CDATA[事故数量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="Embedded2" columnName="指针值"/>
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
<FRFont name="微软雅黑" style="0" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="176" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G-C'6fo.Y1Ij+GJa1Jg:D%?h6MIoKl0g"'d4j%NOPm#-.m%5FX;7nBkbb*>)@o'aP>A&``
n/H8iGK@824"O<V!MSPSu=/[07#*#`)>W7`8^<UdGd30ZbS]APIfSMQ$d3d=WbWX#ER1%qL63
NIc&KKj7@\Ss-9^Nc?Naj"*&=#1R:21FB)T$]AtCkbH_12`IE[n!b+<o*0!9HXZDC4T`Kce9/
QlF@ZLO^(T')>6DXLe6[,]AOgq;3i%^[fDKRl^R^p-VWhrVlEC+4%;EIOTBr486ph@u&O`Nh%
DaJ#X[*r\K5.ReA7FU:r(H6;OsTU<qc?R[qR_/F;ct)-(b+;cW-:SNYh/;^f3I?u$M7>tYiQ
=DV:XDmXL[XJ@l,Da(6^o%5g/huCI(:\IH.^<JfnnDTW*$i`cs_[Vi"*^!b.ABiKD"<ho-bA
-FZR6UVCWlTguYM/#rqLmJdk]Ak_=Xo+(fhEY*%_'c-Uf6BfPN/Sp.5KWZt:A`TOh^1MZ@=^\
8.'cm-"W@9"45S)jiB'T7QBs9o,**3WF9omT@0[t)2#Sp%HO8uX4hf(Xegf'DBV\>Oj.C&cF
n!r"#+qaNA<UY4'm,rsChB:*j4='cXuU(AnD)C'.`K5AZ7t<*$FO5e8NXRg[qicuSBSq*PK#
t<g$/-+\pAh)Q$RLEYT'a+J%a.3$"$cDdtOhps+O878!?!JZ\<Kll[Q;V.R)4N@lP4USfY7_
'H]A:_/u`MCBN=Q!MY8$P;X6$=h&+FfL,:)m/Ktt$:6UT2ep+N.@>scTUa"WGQCRTs`*-Nr_9
cnSb2FY9I+P<=IF3(H>69(ImQo[T%%X;355"<o4'c#=C:FL;<7\<XV"%,i=J.f2C`*ufG#%K
;Eh)b.?TM[4An$+_U&R*ckPCa,048"pM>MZ9As;aS%\jJsS^s=jLVe*FN-4ZEnOBk>T=n@@.
+']AFCo[.GR@)*dOuNMS0Rl_RRg"P1KO-^@ol&O(h7]AGPqs03-&2*PiD>@__qdN%Urk=1Xo!r
m,IRluKhlCttoZb;Tbq@7t7m>1Dc]A!#=KNDP5(=fqS5e9Lf:>CUP(f$5]A1Y7FajdT1]A)buFV
J,?8E16SF=XM$6K[oG#(N7V_-ST%p'G]AC]A2eDb_NoM8EjA&!F:Y/m:iF>nK:WNuIfR9!>cm<
b:#77\'@r`S;q&i<W@q1Neurpek?@Qng-F5b$2J5r.Ol%2STT8VQhL;WgIL*!Y\7Ia$<FH#a
diY*[KS`ItMFI;SARo[")pgX7Ekof(^diHL?bS2a#/XKe$r0.%H3r5U$S'J5%hjtE?"%ql>C
f,n1PSpD5GiQT`pgRom=UlP0k*sE+.'<C'k9I,0YJGt!e&CS/@Glj_QXuVB/+WQbSe`pR*[$
DbWU>nDh%l8Nos_g[/X#E(-j*0n\CL5)JUXn9<o1:\=+:(r0sk"6kS:mef&%B0':mR/-B0_'
&`BVS./kD5^1:2kon`@_2cOh:(e;2=a&Lh`.^\U^mtR^YEj'ga<(4;fSnk94e@cTF8";[%[>
CuHK6Ug$[VT5KQm)HLVdZ(Ud>"#Uh+fGmF#Dh+4nMDtXkN^HUk_J?;XZFecOR*8C/77"T9q2
Z^[CNhg#2[#nthr"K5$gsL,bh,4&a%]A6,WY&L!o_"l8EY7@n+Cj3eCk;a-Cbo`#m\a9i7[#G
YE\rZT1/=_5Lq<:U/;>o`\UM@[Vk#8,j.NGa(:PB<,r6b.S$u\2N;N=,h6FRe3Oi+DG=>T=/
Ke%Bpn?f9[HD(^+l_.RQ<C9(dLMYZNhGW]API("]A<FmGO,+If:l6lO(Pfr\gBSkI!oUL3EB2p
c!`W8/4if6`XED7_!Pn;hk:1JW=:`ZbDmdeU)3r1F*NS\a7-J!e)dWX2m_F&`6rAJq&6"W+m
UFfZSYUQ\T0O,'_e@hI!]AMN]A+7@e@JDfj<EUt)#68Ao\(82")l"F^RXUEP1RbP88&YlJ1I0.
aIk(Vgp^4Nq51]A@aKi_?=mK)cje+$jkRE(StdjQdBHr2_pm_cY,JiorT[\7#/P?rjD9.i6(=
r/L3f9c(<4,CGh*1h2ql2;\=9^ZNPZ!&F0#dlXm(Ts;BX\WR")8/*-]A)1%K_ulXo5O4?l[31
=aJ#D2=n+,bHL<2R`G:X5"KI\$?e@\#W1?d/,)"3Z&c:!/qb;.?44$u>]AKmU!SOT,J>bR_rZ
]AB*qI!XlA_,=0]AdM"h&@m'Z8!c_att.olBBptiiY..PNl3P#?j<cF_Bo/JkD'!SpS3NZo2%L
.+DdJ$*bDpbH@l^_YgHP?:/+G35'.p<*=H5jqCC3a`%NVD@:j=4JX\.LZt\ZJrpTio+$@O\k
k&FUlgPD&C$I&)Zu$oH96Aeh,k9$IIM/Jq@lV1XG?/rM8]ASr$R^Xqs?4$dXBfh.;V/70X)E)
PLI;Hp(^cZngLj#ga=t>jot#R&$`t&b$E>N.*aV]A1N-#QfgP@U8pp&bBjah04Nktd"LjHhWh
aW(7!bjjb.-E2]AqC.C(?<@QFR%'[VTnC9\VkT71gB!Onj?BepGo?'?UT@!QGe.qsDJP=I+hU
WQDY6q?(2Ze\:H_fDG6g82C:-_kJE>TL,V6Gq.5[e!L`(s)%odZs+5ti/HOW"JZf)r[O"s$P
S%cNN(NM^>m-tM2F`Chh_FY&oWF*DWR?QoT%NI2d`^IJ=b^Mc"Tms"1XgECW<F(7Db`E"!bY
[p4XU7^C!L)7D7Au$;GPV,cGWQ"qj"E(`5Ub/\e:XBM#aS.bXn\Q\U@/8hbK#_,Ab_KlY"fE
W`pVn:4II5NH3<5jBA"_*g2>G2b%[@)3Q(MRSLs_P%EuLJkA0h,e0d]A\GOB1l<AR+eeML1el
IR[n1eSec$:#?erp&D<9N;TtmES:k<-fb"-@;S^C<p$o6f6Q/SEc(sHSij0bK.Zl#NHLmeHD
!Q3U+`,]Ag1[cPf>[2r1aI\nZmEkqWGo,VoP5ctk!K4q^fA1PSBXHY3D;DY0`K,<S2fL[2'o%
YVVJ@(meSBmoIdJ5jOp>fLa"7*c$FQAH.>olaN;*tXu@P`pW/&@%>Xi^g&I:tr3BK(JW.NsG
NOTdI">c4@)Pn]AVk#Bla&K@`VLnKY;F.b78KW,NWQnSTK*iXMS[#0g2QMs`=--oadh^s=3kE
ApHd+cM&3V`m[(585``"]AGn%WHIR3.U:(>=66eA6S)OFn;^,[ChO(#Ct"9[6JL9f6sNid?$6
si"r]AVc+;u"he4q@t/2]AcfNJP82Gj%7,"%0Jf9j?s'[qS><h#Ii(I%/;!T_fnGPKPPb;F80]A
T$odGd"mW3!F6(SG`)1rE*4)?!TY3MN6E39Y#E,g>bKqgbthgdMd^F"N1gSaBL?Z%$]AGrd3V
jt[nN0k&9[G)GOT=!,i=UN0a!,FO@7qtVV*5"=Gr;qLQu#5<!kT%KWL6IDM%E7%nc-SrU[Gk
nW"1)YX`!?3^p=4l;SW]AI%_o*MI(L6,]AT:<6`&ZVQFWHnU%89V&kgRQkRH=o7D$1$/_]A57mr
Cmqam]A;MfO!5&_MQ[4hkQY\nEmIOVH.U\:m$,J`Y9bU^[4rNq`/H9Y6NI)g.GUX!V[>uu?#3
,+(/82/">)(+aLO0]AgD+0\P=>:Nl>AmsW/@8u.]AU"mLKPoU3;jX's0)gb]A\kh"PMAEq33X7!
8Ds%Q_2oO>CP$]A6R=]A&i.L#"?;M,Ws"Rq2CY>NWc`a`NNqs?qh.lf`1LE^.#K`+6/1)+o:Qr
7!gm2,m'-7_tR+tW/.lck"-Sii;V'0iiPI,>X^0]A"]A>pRcpU`NLi!Y=_[4$Mld3-sTH"KIr>
,2mnJs+d[W`S=i'%nEQ&`JeLBK.g!&<0#6)B3h'iPp\WR[.0mT.o-DS+H,\(iUJ=alTX*N`5
P0F&jHo3$$bSA8,\qBM'q@-0,ABEO'+<nG_2<?F6O=#(J\6)+FW+AB'_#qh!jGq7Q-(4i93Q
)C4TJH))@!UaPFrA/;%YYAO4b'iNI*6MfFal=Y0/8L-0Rls0ST$AY_/%oSdFt[8HR"JD(D$t
Z[qOo3'9<&q@sD4D!6ttE%=1gXJ^='4&#8?3FJ&'L-`GT#6F:S%nTXN&a&AL"^iQ`9ghcL]A[
71E<US_!aa8SJdu%d%@kbe]A#h(E>VLFcLP2:<o#mnVk1F"NaQV%C-**V[mIFHs09:c2l_FtG
tGA,R#"]A9eJ=n;\8q@*0'(p[YRW\@$P_145U(@PrQYCYs2:7(D^q%21:E3mnQ,DNH?`bl[60
M!H*"_gi-eIJ$4)WMZko'N/:BHppXY3#WZo6.*9Q&Sr=hs$\k/CI[FU#&@kD.LY4$XAVO\U^
PQ&XZp:HNX&gGKsGGU8',d:k0it1\m7i4#WH&K@[ngDETg1jNe't;'o5"97!B:'$,3&h_a*E
WKu^fIa6ogY5iaUkr%j1H`#Y6"'e'Y_saulkF8`Ei-<V'A<YotrA)VYTQQX0Qf6k#[$KH84o
ei4>4iORXY'bc(Q*BB6\/?KdhtA$GKu/+kC4]Ab;EZSRW4(c9m%0+H,SmJ;N'Q4k[&S"_B]A>0
Y@?C]A:\[-.dX#5>M+2#cXnOL;JmMf1YLaMaL0Ggak=p,s,.b"/c/"#mmc3):Z1n$pWRq!.&N
8g4hilJA2_6Mg)?_A&q*=`\;&-A.-@hLU9har4rVG:n#oJ`g^JP1Y8OA<.WAOQ!%VHK\)TF-
k:V&;Kuj"1Gt23%Ve=H5Pf!<mt3Vh.:VFLqEJMKRlCW6.'jRSUL-bLG#)ZaHco&80(2f/JQp
rKOM$S-F'I^24fd^;EE+/7`1S<Elhg3Y*ji"pI,b1_m\G>k9[U=AF,F(L6'65qB/hG8Qis,P
4.dpX<MpE"dM+(ZncjJT["F9M?g70udk]A$(PEO)cFDV(nX50.6+i')f&GR$Oadklt\sdo1ei
O2AWh^eqV/tYc)D@Y"!&3EW*j9qdP]At8'U%HQ6Y'.1#M;L=PWOdZJ*i5W8LU,1=?3;rQ5E%5
F7.ULe<P7,cZLQ3/BiqF-at^qm'0PO59NB]ALa+=-%C"]AE'co.hU3f<C"H(/3s'k4h$OS?\b?
t)0OABn=5!s=#&3+PFJ]Ana&`Ycel1bH))@L`\H!(^A>m2!r%Pe+rI4FANOhgmp&kMO>n4lSl
?PFhR'h!>$/aR<WRg(b6i&9N$pDl(A+8#?`3*p=/p+rmRA&IlhLZ04jd@no/F/fgQjC#0!V.
c'Q`CuIs$?LGK%3j$h:+=dNh>s^pBTclL@H7.P7]AY+dC4l]ANG%k(&%ZV#n+N/=^>q1_G^''?
EPm6WXiSd?V0$/QkIXThsEQk%ds1*/arR:f>f)Gg~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="170" y="10" width="137" height="84"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="人员总数"/>
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
<WidgetName name="人员总数"/>
<WidgetID widgetID="a9b555cb-fba5-417c-94bd-463ada77b43a"/>
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
<![CDATA[1005840,1127760,426720,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[396240,2590800,2773680,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" s="0">
<O t="XMLable" class="com.fr.base.Formula">
<Attributes>
<![CDATA[=VALUE("指标卡",1)+"人员总数"]]></Attributes>
</O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="指标卡" columnName="zz_num"/>
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
<FRFont name="微软雅黑" style="0" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="176" foreground="-1197808"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G!;;eNO_<i=YcH*l1#&N%%Y;eb8kn:AY2Bq$SU.S1p<cD;.*<O>k+6%P,Z9\"l%'r'4mX[
!d:$"Yg`R8P.V77drWLo;`<U_lG:(dc(aYEO%q8K[]Al/GTckdCC!MJ)DMe^9c.0p2Bt[HggF
m#rOotpZ]AJk-VToc]A41SOX!UMbOt^=]A'.]A]ADLjlY=i8kC]A-KM1-]A_2[aVtf,N=44_732Pqe^
V(NZp4r@IV)`m8DX8iU^!QfOKU&qs0h!0)rdO;PJ,IT9eXLIuSTfN(mUXUX7S,*LpI"pq0>T
:Nc2Hi.Y4sXY+rb!@4lC>D\Y\$pW>pZr0kpM#I?9]A8N""U4I]A)4HN@:!,jJdN"Jq!RSlXe)R
HI>%t*DrG1;/;UY[@cip4k0%CbrYA=>4U8.g*'s5Z>/+4#C^igZ&aF5gg-<$#1(XS41F*pa?
i+?+M'mN[TN"+$QE4\o['7>r!T>)&jdd8f=3VX6B'6,Gh>@>%sY:A%8.G6d^X`A"1r"56erP
iVAp6%FKeo7DCOc2ohq3GRA\8.-IdUuSfnCrS%QL2BBf#gZhqK):X:fJ-)Hk0eS^XPoWO<IY
>$dSM8VKjBt<1r)jj]AYQX4_caFY6=dEG/0T["=&.JjVPBP+82B(ll?q$??Jp.>Hb8on2eEdP
"B\!Y`7_k`jV7t,G-C)aFkg/<DN&oYLH>G74V0?Qn.?_1>^NP!0Ul="n)RLCpa?hX49[p?JQ
6Pf9X=l+T,0O;#>;&"%)(1-le1djR!<L0%NUl%4&\$8I=.jJY=R90ls.Q6Rn[dk,H;Gbk>]Ae
h@,]A\^0;<-%HM9e''G9bH$M0_CM;l&<.5qOY^5hPYI+E#s]A4c8T9qEJMg:H*LQ+b+Xe0kl6;
.dNi>UbTtA3VF!&_Sn4q&=q_cALuKkQ(Xbq+e;/ojjotddeo$b=Wm>?C(7dQr_S`X@iE8=*,
HWC8;)HQKiNr-%mp3D<dnBI=S*L_c\UKICm]AdTt.R'#kX`gEC52R*OMPKG*Fc/TWCa^l.J+F
't5?$%#>K^o?[W.oH7sAULWaJPsRsmEh?Z&gU<,en/GhRM>$7_5GgPu/IbYnXUM/OC^IQ<s<
ph\Gf?:XE?GZm1)oqQ)en^cm#NZ48^/a7Nro6'4c`V$0H6efaYo\]AK0a&Uh#RPiBtVNsU_NQ
@Ms8<A5p%[4naG$Rl'&rh7NOe(:mBGWS)-!Ae;/_hoGMZ77u_2Lg87@JtN$)tBlal3aG=%@V
F[07!U,eHghD2l]Ad>1417hJXQ->Llkd@p&jr4R6Mt]A#4+"Nhd-D\cI\De!h(s/Lt;,k5%09r
tiI0b552%lOiOGrOotaF!Ggk\F**eQ<E$H?Q=+U^0!T3B.T`0br?_V]A[cUl!F0(F+bY\Sn]A7
$^*]Ami-X7E,upN#)i#\.l:O'aH`oQd%?-hX:<)/ZmX@TJcnUrq0cS`uipgesf&o+rMr/j_=b
NC9B=rf,lWb9V,=`pG"<aUJ[u`daM>+Pj>bQ3B-NI:sC0UbY;Ohpe^+2m&8V*e&TL6Na`/M"
l=:,fM4<Fa#cAHTHTUXKsrh**mf>pU[UY<IE,tU[k*m^$,m74HUCnLSb`Zcm1IWO$j3aDJ9-
Pn3j^miiOc*kbR)8fJ"1M\O1JXSB"PDOq%[[1mS4Lrk-jZG(:eb#,k3@6*?e>f2p<<;ZaHI)
P*$.E]AK'KgH5ATm+t8RE=3jZ9b4dl,mIhc<=qRI_ZtI9j+S/(RVO<PqM2mZ6'[K2:ZN)EYnb
D31OIl#m*CpG<5=q>]A:Aak;Gu&tF2LSR6^Ssn[GitLe,86+p"cGs7T"5[4ma+YfgA+f/2AK@
L5TJaducr-c=VQ<>)IR2F81)_=V&&-Z<<<&Wqr>Mol)-/Z:iuPL&*Dt_n=q3$^r4Qe-db1JR
/1[Wbh(^@7=CkT!TcD>HSoOY@Xc%h0:*5jUg]A>;Nf"N^m@*Y+iNfdN>*CBDTL"C$l5BX<>W3
Jc!7AW]AkO<\-3nEHc91K?)C4fg.ZM2n:[2Pf(,CPlLr66,P`R#/?`P/\m]A<&eS+*XG>g8+$F
7o8">NG@D[iN97cK$LdOR6)HPbQ'8A3k;+7$\dtlYu?@f?rX_1tZESJD?C=ViiO,h96X%7en
KfXA6h/8F^`0-Y3cC9?q^+\4o%e[i9l[=qO<`VmL@;ehu(ucE/l^pN6*HnWSV26jpH-"X^9F
;cCq\F_X\!4*+C\bQ(M?N%2[VFRKAuS[B3.9$'OWP]AA"k8iWGXH&3pXL,,F_cR"P:+c#BDcM
56T"q?_#Em%RKMN`=?U^:SL%QW-XALsRl*k2'5hhQ6HIIV0rAhj0`5gCNGZZ@TO:E;ire0tV
4>mEj=6?`+6.a>88p?nUmrH4ZbdlrT>C&2$'AR-Gdl#\QSi"_G%8)8n8q_AFpQMu`ZId=Ffq
+u-U5+On4qYB(+enhpQlJ/V=Ilc8u+;H,>k6s!q:]AdVsWH%XTd"e$sViJ1>Ap)R1/)ar)nDF
gUp*rhm%;G`K0!QV%3f6B8?NncJW:Os$mr_`e'QSHcd:rT3i8h^FFu(leE/cD'4$()tiS2D>
ct(srcM8T^C]Ai@09ce(PaOlRGlq,tCl\F7eSGja<7)B?gliSO]AbF^(iW$af.9CVTGRI'k(W_
&?RBNMprKNtp<BLkt?]A^*#,<A2c@GqT^.lr%_YChI?!#c'CW(]A>**lLqk%CHo:UW:-R$;c.p
U9-IVdC4dqpo$F9r//Pb!qY&,%[UBh>JK\Bg)68_f(&6rP5J,O+lnhq5%pc7DTs.OUD>e%TF
3+X"PV/K29@m%_bn%)W0RSCs=`+"n7FMSB'`V]A8i#hP.IisITXk=t[G#(+dnIb,S9ZX8QeLg
.&Xm\9JOn%+,[tn'nGeEq%^tcIeO7onfm?d/POfcZ5?ELmjG+^AL>f"&5>se9#Bc_`ub^jL7
K3klQ%(0+^:Nq2dmN,K9;9ZJk<UuY5>?_t_fV<6DUFD#L))GqD\6?jJ4#mP$O7O%ZW"GG2O@
gJB6<OH0%_kn:>0#p/&*:B1#FX%6l?,:'^1q!b3Er+iP*/@klq;#gS17#q[S'q'A"bTgJ.Q'
Y2I)W!\&dPVL\i]AH)Pu=f.WhoX;p,[6]Ad/<Y+l!;%?m#"S:uo@Y<Fc2q&S;926K^[(Mq(Zh8
'\fIWB^Lj\tKIk&8iVDi%O!qZ_`Vk,cddZ:[j^TGIo`DZo+gl2Olu^7KKO0Z^7YLh4C$7,$V
>+,ZH"VIs/HkfaP2<BXWM/W+]A^4;p98(m6jaCS4f)fE?pT2<ca=B"8B2Q8a\+-"m"aY6c#;m
(q>[+]Au?gtO2b*JUdgf&aLQ06+I0s"d5Xl7_`@NC9#4PXU5f^R*1^$nWmh4$>B5i3NcUOZ<u
MWEO/<Z/b[>DX^IWJs^)FR]Ah%7dl-fd7A4snNrBh7#UF[G+GI3KZK8TL403h!CO81%(Ipu.r
<U2uZAZ5fjj4e6f0Ja30-;ob5pKWN_nTdM6Ph\p(?E+S$`gnb3,+?RG"JNbfaFG:pp<tKtia
$UpU'U#Y%Tf?oJ7\Pcd4#>LIH%FuHDW>g:SDqHAo=EN$5QXA\mXg)caY/e3l\4W2VSA<(D(C
>O+18;&K_1[dOuoc/=6jqGm)DF3Cq.J`S?OImGfiSk)/`nk*a]AfQHmL8P"@qD4G$!bR1VR>U
%B^E=Z\T%[5_;*;&5\dk9J["U\nnuYpk6rZ(q`@]A6</s7;n>0?WAP6pUfF^dh*Y<sT,GYnd5
PV.=aKnlX!EAj/k6o+G\RL$XWF'se5T0%H>5jV-Q,Rf]AbMNpm&oGlMd6`#\;^U=C"q8lCRJ!
dZqsee\*Y5h0<_lARo99_9q@YCm.W(#neBMZlFN)XUuYLcaN!+H;U79B'%r`(cK<&l1%q<t"
MH-+V1"OG\nXeLVGCrqk51QALndf;HM*+VM4T"pZ=(b3au0UDf"b>;a$bplNls"o5q6O35p/
$3p]AqS[R>q"&/3;0qTK;oEP,Dsf#t!G5QDcfgjmG0jqg#K@hDhK[^L"Nq&^ISK&\Zg=@0Rr-
VUPQ`2W2$W.qZ6t?(N!N`U'2,Z\6Ci&Oe]AtHN`"e,4Y=thoXP[L<0T4GN_gGnV*c$kRd`"ru
A><.MCGGA?/.06aft"SINbEN?XiXIli[3dN65LPOnP":Hn'WdF5=cWHu^,":_T,J^E3/(jjK
$<#MN[pbgr308B>)rLKQm6S&2GZ:DZOge",>^CuCH3koX[VY6<oL?#;@Xc$o!ae*4::*92W7
Tb(:!!Xl8hU8c8*L/;#n-.L="CtfT<3>"&IV6^+RFM:c!8X582InBpDnIqIs4GES;N<'+[IF
$3)tQ!$%<h/6Unu*5Muj:$V<ct<XV+'DXc%;1ShAbU*5OK/$)I>9]AB;U>"iPr"\ia?Q[X`Q!
Q-o@_r8XqA@OnttE3npAW]Al%9Hcd"5gn*@Zed\(FOq!a11&1j'[P'PXRYG>-cgV):luGr-A[
ITGq-jr<G6KsXLbjX2"fs5)LP+#1hbrke8@o9?1bSCS\HM.on;Ys?ae4:!G)C*E(mj525=l;
tIDcR-V\;VX@7o-FDM%.;0SDqg^ldIf()]ANerFoimIt\EV0#]Ai`q.&4\Q.=+&bl75,#;@nh)
TQJ[)\Lq!KrM?G_n8sg5hg+H12J0X;m+GJL>Wht;`BRa<#`]AIa*a%d0Mc`J"A)^EY6Qj]A-nR
Won_dM.pf^73G3Y'HcW_BE1[`.R9ac$A+\DmY.E>Y1;P!?.#DNS_F$Q-J-4IP0qr,GJ24-]A7
KhLUP,8)cZp9tP,:WK9*qEYl;I).=)Er.T<+uhn?2s/pn`\HauS`ea2.G'QsjK!:IN.^8*<J
uGuh@YMXju<EOgFLF&!X8F<Of`l#m<`Tm`)6%G6tQ'EB>4,0#O#o_R#UNAi8_#Phr6*`nKe#
pVF#JLo0/ZYW9/\ses6@P:RV1HBPO7r@IU`CR^Ssn@N%VM'qi$@^]Agd:ch/<T*rE2n]Ai2$8M
P"L15m<4Gk@=@QCU1jQ$BX/1()pnGOg,,41'>-$;!>M8;Tch=%(fJ/RAE9n%Dq&%R03_nYMn
S;iXS.#XlkS8Ahm.r`q#YY+c`3E2Y;Y@dN5W&'O]AsaCE,H$LXu''n:Zn7*,0Tn%'[BXarhWQ
kM'b4S;UcPFeXN2FT6oiP\bif_ddi#\.5Lf<A[uPOE5SRTW:OmHO6G\kTcIr%Qu`$%?<*7E?
#JOLDQ]ACA&\0KYk5'>DZV*P.guEtKL*`an!%9(5C1\pa/W*j#lKpib#`DEFOKuITEa63[iY3
[C9t+Z::fPq^>QXR&RtA=:l)BK!>G'7P"G+(OS7[^e!/jbP!guPoRS=&!mAm0Sr?``M!JfG2
KGKRMi1^bK[WNqB+*NB"kFg6(G/A4MBN$L0>5;&(;]AYp%"26;>4"<]AMdc8ZC/p((KjHKTR;t
2DTmA+.cB<DrF=)Pq"e(KhT+j?/WSaIY0Ksd#.WI]AG:*,>_):06[Wt8L&>RbXqcq,01;fSAk
+/up7A-3<`mC.S8LG&fn^Wg1DfmkA^P[`im!5T=P!ZZ8#GY5H!b^@0M+GO8g!p3YAp/0C`A&
:K,+<0nI6N<c@4[XKZG*X#DJ4\hfAZ93Zc1?2$f?\%?)!RmdhA0C6.OH:4rUs(qp6EbeHa,j
poRr9UrZk%N?(s*:1nHH5K,O6j+,E#L!KQ!g+D.rm@oLSW8.A!a9@]AR/,8hZb[EWr51Xb!SH
afMt)1ZC6-'5_o)nT"P%5n-Y1sQdHlRXA%icIP5(kWS<))FC-.3hYrL^XC5]A1#f`''r-)U`s
n,+-=G[355\u2D3a5*SK$(*s&td\<^:MC-Ef;X-(\"s5tTMC.QPD[VV8sH-$XV`^KF:2/5pp
Nn"2U)B']AKel@b91KfA=Zh>;7UO^b<\SKci(a=uA2WG@Z^Ttrl+$oAZ_R#`M*S=@d_m@XKd8
0"F]AT6Cgs'aR[9Ab$J$F1h#S6EpPo36A@-BJ[nTE*_/T;G%@a6j3I_Cuj+QbC]A6B_RQ#3paJ
[2dJCo]A*6D@N.t1Nr>?7Q>6H-SUI+?r_`?LkImm;e^C,E)k+/eV+u$CD`5ul__o."Un8LGOH
YZih-"7!'9hJJ6f5pH5BF!=e3^:SG-ZCto@,[R52I?LN10Ck#Tf``P3S"!^.#4V6*]A,$=/I<
k\\.Q-I`u/Q\JUS)_9:%7;m@RjK19XTDmha=>\.V:0-@i:Mlhk3ib#.Zo2;YK)c+5FTRRn?9
s8Gcp=)>`e`3>R10cL4>?)8P4^r.]A:4S-UoRbnW6ZL:u^G@FB=V9!7sf%DD_#)5r.Jn+C=>,
f\EJbB"F+9Aa\Jl_LuT]A#:53j8N1>"e5eMlR^!qfp80&4`&XPXb*Ml%-\TOk3+2Dd(e7p4^,
%/pVB\eA<*Xb0HQ>HA(%">jWu`PO;2Y]A:E*Rp"+]AL\1Fr%Yf<f)i@/7jB![eI_1c8FD-l$ZE
-(dl`^0*Ms1=p5^uf?*+7IRkdtNA\*s'92(Qt.Tq?,3;A,W#JVh&G=V;CfYIf[T/VscsFe9i
XA&Y(2FBg]A^7m,RSns&KpoLXSlU.jV2K;d07<%[9tE"A-H/ei(Nq>43u:\Z$j=JY:0io<7(8
6pD6u%+L^LX%K:"\.qD&N)_LKSA6&KpDc`C^kA,RCd'E1lkX1-KCVa%aB"5(=^qFLQnIT0,T
ARXKor*P(-QWdZ\NtI[M6*0WSYbB;e$dbQnE'""Vn.&-CiO"L7N,/oN_QO8Nu'q,Tj-n4<;a
Xa"j6nFo@n_=?.JU6&;1JK4a9eYm#YY6g8'gnDGK/D?iWMDnpB-b:6e&=-oeb<FDcFCK0I8N
1G1r*q-%5YT=A/bT;1^YQ]Ao25iZ]A-^'Q'NVM1-u"T$EaSXIlAgY+Hf9e,2oYnM#pcFP0PVpp
bSBRWEGb%W\mJVOCa`5T[0D\>S;JU8!Q&,mO=i,:<]AptQucm_h1_+/N@M2]A]ASL7*fCpiWsc\
3<hi6!p"ps6B75o*.k<<rRl/c"6Tk4Kjsas+Bk4?i[Y:[Fc;LhAuq_P\S%u/Rl#FCU`BKN2#
kCh6fd3E,VSpme6-.[gk)6k]A_(30cVTVBhZK2WBNVUQ-L^+H;_E^+/"O1T.#smO!BQF@C`o4
%j+HS'RKq]AUYopj%1%ad>-tsriKGj;0$mS[&*JblRB(;+j`21bX&ZIV)j9+llq[)0d-XW8gr
23W?`IdD4XXeR1YNMV`6TY/K,dLiB#5:%-%b7nif@$2pDr"nHjXJXb3\?30[Ai3t]AHFo93#N
-gB^a#Tl/S@JcjUt$&l6h3R>Q*o=P<\%ES]AW!U+N\WX4R_&=:-`TEg59KS3)OJ'5!+$);1Zf
cJ3rl7E%tL3)3jdP=7YbZE;-f/VZ,&jLOe=gN]A4Td;?5W-+WSe5c%JeaOVEjFLSN[gB@3HCt
I4!$CaW9rdbheqo9WZ^[,5-:FW^Ce\\osO9Z70ZoVPMliu:9g,nVGDN'baV@.$h#aC4t[M[b
,)R^W"CV%l&P)cjFqD50CkM'fn?\&7a`u,#:mln;^!K?S<j"'%T.1mdREkY?/qERt6f^'u3Z
&I/T35,5:oWgK9"qU.[.EOi4nIlUVcY9?%2_ZZ"1b%mLmIFr!^j?>+hs+aZJC,[03Rp.to7Q
&6+j=bS6<;\l?JLJU2a8$9AemTF',/K:qrA#\D7'OVQiD0U&tbo?QrQd>alUoY:lq2g3LJa>
Eg1Ukc<Gj*q9X8Gd8EiNGSSU@K%\]Ab,04terDkbP$`+5EZ?e,BmOI0Zn:q8ZX+J0/RN1c8U:
VNA6'o&2)d+BNh'\noN2/HF:R@]Ao<rQt8J`)XI*'oKQfa%BgJTGc8U(;\b=V#[na[N6$%X&)
n3srs9er68F0c`_+c[d;!Z+@MB0IC&4,$WRL5>j0fds`7((-W=)m.2s#bXk$-AL]A$-Li5%-N
f$Zj(D$"^+R)FQ7YIW@<tk[_NZjq4R09D7a!*R=f8J<5_uX/"6<68=(Xl#*i6sO64XqKi?B<
!D,]AA^u)OYfMg7fMebKQ>"n]A4/--(#TfUH!Q3(_Y%'p-Nr@=.g+5M6oJ.&r]A`k>7QO,[Q2u/
4UX9KWg9_hJ;o"ZG@0G=Tf@?J`d8@Ta%tJQg*^e1dn:8P=%t&7r8/-0:I+r^=;q4nnQ4=[ru
V~
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
<WidgetID widgetID="a9b555cb-fba5-417c-94bd-463ada77b43a"/>
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
<![CDATA[1188720,2407920,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[396240,1767840,2621280,2743200,2743200,2743200,2743200,2743200,2743200,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0">
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="0" cs="2" s="0">
<O>
<![CDATA[事故数量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="1" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="Embedded2" columnName="指针值"/>
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
<FRFont name="微软雅黑" style="0" size="112" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="1" size="176" foreground="-1"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[m9G-C'6fo.Y1Ij+GJa1Jg:D%?h6MIoKl0g"'d4j%NOPm#-.m%5FX;7nBkbb*>)@o'aP>A&``
n/H8iGK@824"O<V!MSPSu=/[07#*#`)>W7`8^<UdGd30ZbS]APIfSMQ$d3d=WbWX#ER1%qL63
NIc&KKj7@\Ss-9^Nc?Naj"*&=#1R:21FB)T$]AtCkbH_12`IE[n!b+<o*0!9HXZDC4T`Kce9/
QlF@ZLO^(T')>6DXLe6[,]AOgq;3i%^[fDKRl^R^p-VWhrVlEC+4%;EIOTBr486ph@u&O`Nh%
DaJ#X[*r\K5.ReA7FU:r(H6;OsTU<qc?R[qR_/F;ct)-(b+;cW-:SNYh/;^f3I?u$M7>tYiQ
=DV:XDmXL[XJ@l,Da(6^o%5g/huCI(:\IH.^<JfnnDTW*$i`cs_[Vi"*^!b.ABiKD"<ho-bA
-FZR6UVCWlTguYM/#rqLmJdk]Ak_=Xo+(fhEY*%_'c-Uf6BfPN/Sp.5KWZt:A`TOh^1MZ@=^\
8.'cm-"W@9"45S)jiB'T7QBs9o,**3WF9omT@0[t)2#Sp%HO8uX4hf(Xegf'DBV\>Oj.C&cF
n!r"#+qaNA<UY4'm,rsChB:*j4='cXuU(AnD)C'.`K5AZ7t<*$FO5e8NXRg[qicuSBSq*PK#
t<g$/-+\pAh)Q$RLEYT'a+J%a.3$"$cDdtOhps+O878!?!JZ\<Kll[Q;V.R)4N@lP4USfY7_
'H]A:_/u`MCBN=Q!MY8$P;X6$=h&+FfL,:)m/Ktt$:6UT2ep+N.@>scTUa"WGQCRTs`*-Nr_9
cnSb2FY9I+P<=IF3(H>69(ImQo[T%%X;355"<o4'c#=C:FL;<7\<XV"%,i=J.f2C`*ufG#%K
;Eh)b.?TM[4An$+_U&R*ckPCa,048"pM>MZ9As;aS%\jJsS^s=jLVe*FN-4ZEnOBk>T=n@@.
+']AFCo[.GR@)*dOuNMS0Rl_RRg"P1KO-^@ol&O(h7]AGPqs03-&2*PiD>@__qdN%Urk=1Xo!r
m,IRluKhlCttoZb;Tbq@7t7m>1Dc]A!#=KNDP5(=fqS5e9Lf:>CUP(f$5]A1Y7FajdT1]A)buFV
J,?8E16SF=XM$6K[oG#(N7V_-ST%p'G]AC]A2eDb_NoM8EjA&!F:Y/m:iF>nK:WNuIfR9!>cm<
b:#77\'@r`S;q&i<W@q1Neurpek?@Qng-F5b$2J5r.Ol%2STT8VQhL;WgIL*!Y\7Ia$<FH#a
diY*[KS`ItMFI;SARo[")pgX7Ekof(^diHL?bS2a#/XKe$r0.%H3r5U$S'J5%hjtE?"%ql>C
f,n1PSpD5GiQT`pgRom=UlP0k*sE+.'<C'k9I,0YJGt!e&CS/@Glj_QXuVB/+WQbSe`pR*[$
DbWU>nDh%l8Nos_g[/X#E(-j*0n\CL5)JUXn9<o1:\=+:(r0sk"6kS:mef&%B0':mR/-B0_'
&`BVS./kD5^1:2kon`@_2cOh:(e;2=a&Lh`.^\U^mtR^YEj'ga<(4;fSnk94e@cTF8";[%[>
CuHK6Ug$[VT5KQm)HLVdZ(Ud>"#Uh+fGmF#Dh+4nMDtXkN^HUk_J?;XZFecOR*8C/77"T9q2
Z^[CNhg#2[#nthr"K5$gsL,bh,4&a%]A6,WY&L!o_"l8EY7@n+Cj3eCk;a-Cbo`#m\a9i7[#G
YE\rZT1/=_5Lq<:U/;>o`\UM@[Vk#8,j.NGa(:PB<,r6b.S$u\2N;N=,h6FRe3Oi+DG=>T=/
Ke%Bpn?f9[HD(^+l_.RQ<C9(dLMYZNhGW]API("]A<FmGO,+If:l6lO(Pfr\gBSkI!oUL3EB2p
c!`W8/4if6`XED7_!Pn;hk:1JW=:`ZbDmdeU)3r1F*NS\a7-J!e)dWX2m_F&`6rAJq&6"W+m
UFfZSYUQ\T0O,'_e@hI!]AMN]A+7@e@JDfj<EUt)#68Ao\(82")l"F^RXUEP1RbP88&YlJ1I0.
aIk(Vgp^4Nq51]A@aKi_?=mK)cje+$jkRE(StdjQdBHr2_pm_cY,JiorT[\7#/P?rjD9.i6(=
r/L3f9c(<4,CGh*1h2ql2;\=9^ZNPZ!&F0#dlXm(Ts;BX\WR")8/*-]A)1%K_ulXo5O4?l[31
=aJ#D2=n+,bHL<2R`G:X5"KI\$?e@\#W1?d/,)"3Z&c:!/qb;.?44$u>]AKmU!SOT,J>bR_rZ
]AB*qI!XlA_,=0]AdM"h&@m'Z8!c_att.olBBptiiY..PNl3P#?j<cF_Bo/JkD'!SpS3NZo2%L
.+DdJ$*bDpbH@l^_YgHP?:/+G35'.p<*=H5jqCC3a`%NVD@:j=4JX\.LZt\ZJrpTio+$@O\k
k&FUlgPD&C$I&)Zu$oH96Aeh,k9$IIM/Jq@lV1XG?/rM8]ASr$R^Xqs?4$dXBfh.;V/70X)E)
PLI;Hp(^cZngLj#ga=t>jot#R&$`t&b$E>N.*aV]A1N-#QfgP@U8pp&bBjah04Nktd"LjHhWh
aW(7!bjjb.-E2]AqC.C(?<@QFR%'[VTnC9\VkT71gB!Onj?BepGo?'?UT@!QGe.qsDJP=I+hU
WQDY6q?(2Ze\:H_fDG6g82C:-_kJE>TL,V6Gq.5[e!L`(s)%odZs+5ti/HOW"JZf)r[O"s$P
S%cNN(NM^>m-tM2F`Chh_FY&oWF*DWR?QoT%NI2d`^IJ=b^Mc"Tms"1XgECW<F(7Db`E"!bY
[p4XU7^C!L)7D7Au$;GPV,cGWQ"qj"E(`5Ub/\e:XBM#aS.bXn\Q\U@/8hbK#_,Ab_KlY"fE
W`pVn:4II5NH3<5jBA"_*g2>G2b%[@)3Q(MRSLs_P%EuLJkA0h,e0d]A\GOB1l<AR+eeML1el
IR[n1eSec$:#?erp&D<9N;TtmES:k<-fb"-@;S^C<p$o6f6Q/SEc(sHSij0bK.Zl#NHLmeHD
!Q3U+`,]Ag1[cPf>[2r1aI\nZmEkqWGo,VoP5ctk!K4q^fA1PSBXHY3D;DY0`K,<S2fL[2'o%
YVVJ@(meSBmoIdJ5jOp>fLa"7*c$FQAH.>olaN;*tXu@P`pW/&@%>Xi^g&I:tr3BK(JW.NsG
NOTdI">c4@)Pn]AVk#Bla&K@`VLnKY;F.b78KW,NWQnSTK*iXMS[#0g2QMs`=--oadh^s=3kE
ApHd+cM&3V`m[(585``"]AGn%WHIR3.U:(>=66eA6S)OFn;^,[ChO(#Ct"9[6JL9f6sNid?$6
si"r]AVc+;u"he4q@t/2]AcfNJP82Gj%7,"%0Jf9j?s'[qS><h#Ii(I%/;!T_fnGPKPPb;F80]A
T$odGd"mW3!F6(SG`)1rE*4)?!TY3MN6E39Y#E,g>bKqgbthgdMd^F"N1gSaBL?Z%$]AGrd3V
jt[nN0k&9[G)GOT=!,i=UN0a!,FO@7qtVV*5"=Gr;qLQu#5<!kT%KWL6IDM%E7%nc-SrU[Gk
nW"1)YX`!?3^p=4l;SW]AI%_o*MI(L6,]AT:<6`&ZVQFWHnU%89V&kgRQkRH=o7D$1$/_]A57mr
Cmqam]A;MfO!5&_MQ[4hkQY\nEmIOVH.U\:m$,J`Y9bU^[4rNq`/H9Y6NI)g.GUX!V[>uu?#3
,+(/82/">)(+aLO0]AgD+0\P=>:Nl>AmsW/@8u.]AU"mLKPoU3;jX's0)gb]A\kh"PMAEq33X7!
8Ds%Q_2oO>CP$]A6R=]A&i.L#"?;M,Ws"Rq2CY>NWc`a`NNqs?qh.lf`1LE^.#K`+6/1)+o:Qr
7!gm2,m'-7_tR+tW/.lck"-Sii;V'0iiPI,>X^0]A"]A>pRcpU`NLi!Y=_[4$Mld3-sTH"KIr>
,2mnJs+d[W`S=i'%nEQ&`JeLBK.g!&<0#6)B3h'iPp\WR[.0mT.o-DS+H,\(iUJ=alTX*N`5
P0F&jHo3$$bSA8,\qBM'q@-0,ABEO'+<nG_2<?F6O=#(J\6)+FW+AB'_#qh!jGq7Q-(4i93Q
)C4TJH))@!UaPFrA/;%YYAO4b'iNI*6MfFal=Y0/8L-0Rls0ST$AY_/%oSdFt[8HR"JD(D$t
Z[qOo3'9<&q@sD4D!6ttE%=1gXJ^='4&#8?3FJ&'L-`GT#6F:S%nTXN&a&AL"^iQ`9ghcL]A[
71E<US_!aa8SJdu%d%@kbe]A#h(E>VLFcLP2:<o#mnVk1F"NaQV%C-**V[mIFHs09:c2l_FtG
tGA,R#"]A9eJ=n;\8q@*0'(p[YRW\@$P_145U(@PrQYCYs2:7(D^q%21:E3mnQ,DNH?`bl[60
M!H*"_gi-eIJ$4)WMZko'N/:BHppXY3#WZo6.*9Q&Sr=hs$\k/CI[FU#&@kD.LY4$XAVO\U^
PQ&XZp:HNX&gGKsGGU8',d:k0it1\m7i4#WH&K@[ngDETg1jNe't;'o5"97!B:'$,3&h_a*E
WKu^fIa6ogY5iaUkr%j1H`#Y6"'e'Y_saulkF8`Ei-<V'A<YotrA)VYTQQX0Qf6k#[$KH84o
ei4>4iORXY'bc(Q*BB6\/?KdhtA$GKu/+kC4]Ab;EZSRW4(c9m%0+H,SmJ;N'Q4k[&S"_B]A>0
Y@?C]A:\[-.dX#5>M+2#cXnOL;JmMf1YLaMaL0Ggak=p,s,.b"/c/"#mmc3):Z1n$pWRq!.&N
8g4hilJA2_6Mg)?_A&q*=`\;&-A.-@hLU9har4rVG:n#oJ`g^JP1Y8OA<.WAOQ!%VHK\)TF-
k:V&;Kuj"1Gt23%Ve=H5Pf!<mt3Vh.:VFLqEJMKRlCW6.'jRSUL-bLG#)ZaHco&80(2f/JQp
rKOM$S-F'I^24fd^;EE+/7`1S<Elhg3Y*ji"pI,b1_m\G>k9[U=AF,F(L6'65qB/hG8Qis,P
4.dpX<MpE"dM+(ZncjJT["F9M?g70udk]A$(PEO)cFDV(nX50.6+i')f&GR$Oadklt\sdo1ei
O2AWh^eqV/tYc)D@Y"!&3EW*j9qdP]At8'U%HQ6Y'.1#M;L=PWOdZJ*i5W8LU,1=?3;rQ5E%5
F7.ULe<P7,cZLQ3/BiqF-at^qm'0PO59NB]ALa+=-%C"]AE'co.hU3f<C"H(/3s'k4h$OS?\b?
t)0OABn=5!s=#&3+PFJ]Ana&`Ycel1bH))@L`\H!(^A>m2!r%Pe+rI4FANOhgmp&kMO>n4lSl
?PFhR'h!>$/aR<WRg(b6i&9N$pDl(A+8#?`3*p=/p+rmRA&IlhLZ04jd@no/F/fgQjC#0!V.
c'Q`CuIs$?LGK%3j$h:+=dNh>s^pBTclL@H7.P7]AY+dC4l]ANG%k(&%ZV#n+N/=^>q1_G^''?
EPm6WXiSd?V0$/QkIXThsEQk%ds1*/arR:f>f)Gg~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</body>
</InnerWidget>
<BoundsAttr x="20" y="10" width="137" height="84"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="人员总数"/>
<Widget widgetName="人机比"/>
<Widget widgetName="指标-入职人员"/>
<Widget widgetName="指标-主动离职率"/>
<Widget widgetName="指标-人均工时投入"/>
<Widget widgetName="指标-工时投入满足率"/>
<Widget widgetName="指标-累计投入工时满足率"/>
<Widget widgetName="chart0_c_c_c"/>
<Widget widgetName="关键业务体系人员"/>
<Widget widgetName="chart0_c_c"/>
<Widget widgetName="chart2_c"/>
<Widget widgetName="report0"/>
<Widget widgetName="report2"/>
<Widget widgetName="chart0_c_c_c_c"/>
<Widget widgetName="chart7_c_c_c"/>
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
<TemplateIdAttMark TemplateId="12901d82-0d3e-4d43-a441-c319094a0839"/>
</TemplateIdAttMark>
</Form>
