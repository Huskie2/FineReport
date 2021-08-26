<?xml version="1.0" encoding="UTF-8"?>
<Form xmlVersion="20170720" releaseVersion="10.0.0">
<TableDataMap>
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
<TableData name="明细" class="com.fr.data.impl.DBTableData">
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
order by case 划分 when "国内" then 1 when "国际" then 2 when "地区" then 3 end,3]]></Query>
<PageQuery>
<![CDATA[]]></PageQuery>
</TableData>
</TableDataMap>
<ReportFitAttr fitStateInPC="1" fitFont="true"/>
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
<InnerWidget class="com.fr.form.ui.container.WTitleLayout">
<WidgetName name="report2_c"/>
<WidgetAttr invisible="true" description="">
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
<![CDATA[1104900,723900,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2304000,2016000,2016000,2016000,2016000,2016000,2016000,2016000,2016000,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="9" s="0">
<O>
<![CDATA[  往返低主舱利用率航段明细]]></O>
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
<FRFont name="微软雅黑" style="1" size="128" foreground="-15386770"/>
<Background name="NullBackground"/>
<Border/>
</Style>
</StyleList>
<heightRestrict heightrestrict="false"/>
<heightPercent heightpercent="0.75"/>
<IM>
<![CDATA[j]Ar7!;s3t"m@r@`P'-.cSCL;MD7A(AXY&$(a]A=>`&8CP2e!<YT3QE[c7$I\^S/0[Q$T2,"VM
LC<0@X-`ek>(eS>KuHU7;;9-jZdT#T,o7\R3WBrtE"*blp9GXP<Tpn)s(W38aJDchfiNqn@i
'G\L%7rBL+s:WAA5GQ39j0.n;)N^OgFmbV=KBKYfDk&J.bEniXRG/9*OrI*P2.il_Ns)_\]AI
)Wm]AYF\kd)qA/rc!0kq[!O1UIs1a2c(u4JRa%K)r0+m\IIb97QH$DJpsk;;Gp_X$bo.B+6>,
ZJ.W$k[n&+`m5LS9Ib/et1lgp%s(_5hLPY'Q<7ulo%2]AYsgS$UH._6"[sq.-pDNnC>X<+N-!
b4e(EhTATZmn%5qlu0;8+TC"o`J.`RX:VDIdFU1dk\'Y%-aY)MZfg^5a`?pY^-ZT9=4leCfQ
l7qp%fWBS6Cg?hImr-n%&#Y&hXPji_I04?@hBH\Jf\&hZ)bVqEj$;ilj(L+DoF;]A6Q;#hjSA
m,15I_[17/0b+iRVZ%(g#h!HM#CFWHIqW=;H\:u31Li,*l'`,9#pJlIu:g@?Q2!6RM)q]A_Cj
eo.pMV0U@SBC5d.o26G4l6)EWp%7UH%j6O,f>\&V4<Sr<48@AI(&!#Z?QsEs+5$*EV:1o6RK
Ec6$ZB<C\uNY:M3O63jo=-B:@F-`D^iY/*FIg)_3PdV,L$T2SHsEDr-&T6tdR76Q30-Os5"c
AdY[WXsrCLB)B"ibJZ7'g>7;!\F.M2faJcsP87d]Abl0B+OCNf>(c5<#L21c!Y2Y$3R)DIZ]At
-KOa)IS*G(0</KPc,T`:'AFTec2ZJJFCujMm3]AUm8k*Qak?8s3/@OQ]Ad8=j1KtMjk9#+<t+1
Q0/Q@sQ?&*njE\8F7N\h8fL"0#pbe,CSE7A9rAf8j>]A.S4EoB':3/sau9etALI]ABt7'opVC/
nV.1)82oiNb.<8);Z`VmFdq<([)6,791s/gm^)6V00aYDP3;-VOu))@!J]A[l28,W!HZHd=,V
&JPOkKpPf"l?CUO-Fa/$)gfa+RfEFA77\ZW+SLqO\1imCHZ_C*8:!rf21P=-_j$^PpVI$?c&
RK[FPG!)uhEQ#%FjpG$l$`cpA1jQ"n#hSY+"Z8%n2QgVaWc8>b09W"`NHO(%NW$8nJ\>F2gK
u7EC$O#YO'h@d]A\()Zo25:NW+MTeAGBrGgp=,^L)4M!XI3Ta+`fLoma&I9jTDD[kfj#7YP[2
P[CW/._EL>\FZJT*e-T!q\[<.ALVc!)^5BD_HhCCU2qCpG'60?n+1!)eMm(29=tY^beobQTP
ur5c%;\C%R3\erNV(P);WSW69H(sY]AdXUVrPahOC]AhCYmKnR6*s+qa7*diK=K53TgR[k^8#j
5-MVV#I]AE@UR')!9Ar5%0F#p$s1Wcc^K`2X$%1rn@QYf/^>(SLYYI>=tqc+L!F%lqgnl1W%S
-,N+%fhH+=p'^A7iVr-A6QINQ`XdcO3QO)9jmp@mB#nYb6<)24!n19.U:n\A0k0>#ruc)O@W
QSem/.*NCYA"1=<3;M.o\Y28Xgdq6%Xk2Z6(tgLj8OSbL*CKJNja=bQ6%X6oaLnWZR3>bTH&
@Y[9Ts?4r\n;Mj>FkOUP>>.K)h8A<nPSi?)i0<(d\/H6Oa0C2[u=c9mrAIuk7gd=OUL2jK7*
o%,pHp((Mha;Ti+MWqngR4.IaJ+buEW;+2ngIni#$8/^Ce@7Eq-%3R*:!$ii&t>tO)[4_EqD
n`hYI%X%R/7rX)iR:?ZQKZOF(57]A1fErdTJ53fF_=8\%u9F?p:L,D=hHJ/2h<./=BBjk_Q5h
-Yn'=2?c6XZM^YVA2#:rK=i4D]AXO3Dbk$9qBO?4c'l'ae4KR:<Y-<=W;HjHG<$)nC3'kZ2-f
2=tE\pPU]A#8kF2*O5l+",FFd78P:9fACViJW--0.=@X)h+I]AM3ZhQ)Ol]A5WjCp@[JZ;8m5]AW
P0+4@#kr)E1-5/J]As(-JscC)c-7*Daer!bQ.i?QRC'kuF@W(YrNBXO!A+c484Qt</A^Z['kZ
or_$a>fal4`s'1Ok+]AUa.WThrGOV9BTUK:0HS07aIN5rlegYJ?%kUVb3H+RoX"o?Y\dOA(\,
'*4<FTD\4Mdu@_89,2^f6cN/LUY4An7DgE8#OcMEpsNn-'io).kpS&nWb\%b=4QY3"u4!b9)
r`E.eP&`-Z-0F/s#bLUoOgW/@F=3OC+gg]APgSk<c<RNW$IY*<ejPE:B%Rj9LUd(bq,T2hkPK
;@AXne*[J[EWZq..kBlq(n5.^W58SkqbY2OEcK-Fn8<H>bO%#5ap=';ukHN0dVD+7<8&eaE&
%mjY8^U3.N\Pj<Vs52jp<4J._CWKsAik81SHfc5mWM"ia3a(]A",&[s$d;lN)pB6)im>nXPEc
ZR:_*8]A-IX<81Xcq@>uK$Tqbj7e:YbJ(i[cI+1l5gS#kc^*U&.?&NeC6QW#oDo$b6uJ29GFH
44$,b>k-DMhML,mB8.*VD[FKGVWDDETZG-6'pPtpCg:#DAs<Bt50S4%S3+e?T\X`pj\8?tA<
+':U<VO"+;AR+$,_+Vl@Nl=PHcA&$;PX0pj[3+M@2]Ac3gc0>tnnjN1ce$rX]AFj^L.+LID"_]A
=-X.S,L:429&sh.(<)SW%pWi`1clB0F<2RkkVBPe^onPeZpkI)FqE+6C3<s1k%C9**`ia.3*
p+<5uK08`A4$lU.5r6<I2Qecfm?(u>ngQ1l)7u8U_*<+(DC0hgV^>CQp\7HYpiFA'M3?W=oN
V#uI+^VR\G5W\1"^0T_rt8<ZIATYE(k9c$?XGgY,>r^TFj&$7W!Z!U%']A=jY&P%n2HVg>Z)t
GP\2?q??-n>)Ae1IoTmrL*(OYr<e?<;N=&DQPfsd-PU5^U\-i'^6$W/;L@UPu1Qd:EI/[i3W
6.>LK<Mm#HN\7.?lQ[9@N%5c()g_,n02;/Q*j*8lLo4+1ARAV5h.Q"tPJX#)b/midPfndSAn
\ucIC6*R0JqY58/9&sFW&bEbS3Ur=+t"\a"&4NVD44?VYrR1Ct^2Z]Ah&ttknmoE1A@iGHN,o
L_gCs#QV"`HA"3,t,46A,kH`V2I^P?ph=J&@O!te^ZdF5Z;e3"9Xd$<[P!1DY=9d+Ear!dIa
*8e@U#eH2j]A?Wq`O0[-k.g^#Ka0d8s!`U6bkW1O7HGo^6$!bs]Ae(9ghC"L,rJ$@D\aS4h0(\
]AHkB+:US:7Dm;f"T@s/"@IB^JSL.k/g*pV,"P<B.'uT/C5b,_?:!G2ji>LMq.S?X[=?Hh+1a
T3T`21<;8i/'s3s6.g&f3@a2Zq>OML82?u6@srn@C`J%@ie[dV)Z@'[@dgk.<HEpX,s*Z:(U
9[na#K&o\k%Q$I>\n1E$(qr,d`Y2_X;`E%;Xd_ni)E7JFAoYchD#K`UakQ'Z'7eHN.O!`&`f
!D>d-t@*A"G*/5)ef(/+W^MJ=K>"X?l^M.Q_e=tilB6[i]A!Iq'"q_."Qgdg@0%#sB-4H94kX
s,LH.bLFM(0YniCoI0$bHm&S<^NA"`WPT8lX4HdN1*Z;Kt*V)gRfO5LBqJf@bX1`W<]AE/?EC
qI#+&j_O\k#o^(JA`j:[mpC,F7:pa28Hj0=I>WNm6.V6qZ1Dq*'!.g#TAHJCbeq_H.S2k+sc
qVjP5m5$pHQhf$.kd';5ZBh9ZhcE)hE@2?ASX5:uPE"GlSX=%OZ;e8%YHlj)P&u$BP&:Uqs1
8(V6DgJWmB,mmAcZ6iFMCT;=k]AP;TbYUG_F&N"42G,I/*/`t_T\!eh:pY0aqE#IZBbe'hg:<
g`A1)pUp5T_.H`kg.HPRU2>Rb%r1B4I4G;Wi9"3P0GNDeDQA^"3a7O1!]AtKe35I^^U1?#4s+
/8`.;bIk5K*A.*cQ>"_aK8\WX]AH[c4P\KBMt',ngSAm*m73`[%^``>g1"1k,#5ub]ApI^2pe@
Ua-^&n-^Dc*Q1UcRu'-4B\'LJV7)uEMkZb)(\:>)"!K^9EfFqebriJ@o=WbO+$"n%JI0?^8O
9eTc!l$P8T`;Tt@)"J[q5PA>JJ]A@)/OE*=s>F':um<CUC^b=;$EBmY-UL"dSj.k@(<DiumaW
cA#:cAQdqR>"lN[:D8=-Wj%RNQGbY'rNs':Hs_2"#7p^spn]AaV6CE<jL'FBQp)m@aaHXF^gt
9mu949D'WmKl<2D]A74fn'>H8DJ%^`%[pC-^iTp2lPRGDD6bt=dS^>oTi6*A?$4]Ahm`$)fc4U
kr.1KH/EQ\1NUE/j\ZJ&.$&h&K%&m,cR<ic:bda'&n]A;S*^9*qWS[7?D$83So_tCINRY;j(>
<Sbgg6@\a6NroYm1pVT5g-h6!Zpe$@^Ue)PIrMt\r?I.ZANLbr)_d=7!D!Yt_3^9lhg;Y>?0
93S2rFs&hPfA4'o:6noG`KN`5c?cd>M/o0L8+`ZL)jFu;gm?)%>0T2\L).9rA;82*K3qNDJ'
%1T4RXK4MJM6$QeH_>I%8?Tamfc-l5<g(ikj6G/TrXYRJ7),(4<D$g\=dC/=5V9Y?iT&o1YG
-/Tr)19j%V\9lk7?ct?HCR<H44D2G<Da;0_LhFbo'(IE(+m'/OlU?H]A930D)UGVsrH]A%E0H]A
7,CMI=s6Kf\T:R`SJ1d0Xjj=>$[\cfospG?TLL()H1WC=e+)B63,f(6Tq.4*0BbRnJuZnP7u
c#Z(A#>;KlTp:CnB/D),-/Z^co9?9P;]A`4%I2YZLLrX_SF5aO62_LuKVNSb,qIYN\&/RQ7d.
mBFt]A?g3&j^oE)q7lFF-[^=4MZEkS?ni*W@(ZZL71%3uJ8=[Yn:@N"BpR1ZR@s(1CCK,8r@?
okS9b^/(KV_&86NYq56I;*(b70ZpggqE>%ek([F*>AL7-AcBNq!%:'4Ied)6A2)=aCD2;>i*
mmoK%/pa17l4qU,3J[>@'3,1BO'!fAbH#MXDits06M(rGK]A9d&!iS['d1Q[3T^GRh)IK!J;_
=q,,$2abPPu6u1[8,PaC?s9kZ=BeilOIhur:@h[S#Ioj/g`/#GFt2h$58h]A)hb9GMNWZ8*F7
&nEFP!.3LiI;i*CiIKDbs^CH.B''X3kc%i;Dthd_+XA^/^1+pHqP$RGG!a3$od]ARs%>bb+4Q
T#s,mr,f@k=a4<XV):<ErQrE>h/bC+Nb:s*$$C4@#8^^jC7VrAXo<9[X7OF<@u)pi;"!!Vo$
GATqr[.@GK_$dZ@W^+I_BUE$K6aZb0sH__eq$!r^7%jV>\]A+5ed<R,hn`lm^)5'G^7n7C?_b
$fpqe(ep;k..m'0F?O0U921+=![Qh)*Grg9[=W;30UFun5-KeWCCCk2chk(s3[2ki8mUWG74
WN@(4IJKN&%=--e*'/7O-_DT%ben=K?9kE`0Sa]AO4.A6+Fe3MoX0Fq-Rl._mrs4d]A_@g+%jX
2A)@de=+'u^FP%<Co:jpkka7K$E\S>"9X3Ac5D)=B,ADHU?`k7uN@#`SM-/TO>Sqm0[DIW#t
.66VOgN^5*gp8n23bptYVmsY%(OBU(!l(k'+:h/p4UZS8\nu?<p#):LHEH?-9X\e-#e$LU'3
>b!W>t8>M7]Aup3?JIL0"*09,R/0ZjM:D(P(DJS@uo%f3)DCtr&Y`b?IqtCK->K+7"0)o&Xe3
5^EW$UA!f*ol]AEpdq<(AA-SVjRQCjSjOuO2FIrWW>l@rCZ-$nW#XC<tNXrHDDVJKQZ5(0?6e
.0X)Q3\Q;4C/A]A[@d&OA&.%gJ5CjKD]Agh)XX25#ZM+?%>7@dB$(M$:M.D43hDPJ'*dV2H"cB
6-\XL5]A5q*p=)\[[77M)2O\RINc1Aj+FO$k@ZJCMds>W[o$RVLg#SKBim.)!ZOY.M)05u?,Z
=nmUY6I@LG9CRLm^9F>`T&4o&1sB]AZEC3%7/2A4K+*1sBLqSt_$aKll36J^easjXYK.Z_-'H
_YY4=X1/(O'Wj10Nn>O\`Jh>[j&"Dq&3j.1es;l@Q!q1M!UmK(UrI<]AE8Q&BDOMVrKfqGm?f
.rb=q]Acuib`-\A#u8J@j2O1lWFXeU-!_O/CJf&q]A&U#<R9,)ZNB)WAT8+)_1mRNp8QV=*=E1
(F'paWQ8#]Al-`5K**fu`TE5IO!?Ob`[9`uWYW_OA`Z1k:F`q1%8AD2T,>j=LEpm9:s3\spF,
mn_r]ACrDl5VT9F4X8i/Y,@\frX8^r0J9']A+'TOk\OE]A5LVHJ2>);j:.$9QNj_c$RFQDa]Am1p
BK_.2.U]ABAHVul=(0m)D=_]A2CEF@<UQK%O[*8WOJFRa?YF#VgPIS<K3[857c_j&RU6#e\;N>
XprrddfR\bPks4h)sM,;k8(8SQOmT$T5nj<s@0CYX*U9YRFgbHIgm3U2^gDe9*)B'5^;pmj^
dI4Js$-Em<LY>D@=0amE$2R9eCoX0s:Z%V;Qm/lrT\sQd(0O0a1/$9OkDoRbk\,jJ-=8dI!.
:Q!l0VTV$O4*=9SO[.D[D:C!8-cdnQMk48XB)_B"?-GZj,M);P^g1e0PWOe/ogEnQ<ubGgiu
qp)@dP?KnM,!qXj'U4j2T%SKmsrrL@`!GQpk`"9)R9$b.arlM%$m7h+>Wl*f/,r)(eacmE*^
4PW6S9?-EGCQ/@[LR.*tMTKaag76-CKWHTZ6f40`DV1cSM%q%iV5:NJ/&N?/,^Yo*?9'+ql.
Gb_4l3[K+E]AZD]A5oPHN)-XSO,Q<14BLQLKBu512?\aLLc(9Wd@D5;R*5L(?'n'D:cIrD;aU_
_IOK(^:2)gI3OYn9\27g!f=)a@kl)U="T=_?\bdHMQFc\"OK9r>T8`b$l&$8gEBCC@FEhCk]A
T5lZ1/r6Wp_7m4lAXZn-.:kBIV.CFTj+MN=,nhqk7[bSa=?"ciAE**b(;e+T.51hM0ZG;+LS
CJ8!I&CG:Q^,1s%__bdn+G'4Q)HFb^ejN_fDoGP^`:3.2U>"`:]A,7RLQ7$rU:]A5tSf$Vm>do
CP*OdiPg1)PGW]A6X/b6j&N!/eX8'U4Jr3E5TVI!^<t9m)!U?.V$76T&li+eZAW_Tu>X*8B`d
Ik/s'8d#2l*$="K3FEi,5H:5:1ak^6k*Z/QHsT%Ua-7>6PQU`,JkM2(sj`\Ss2ugOGE;<HDY
9+FK,AER&;rG_D*=.U,;de429I!VJ.k&aqP'B.3!C@>W2gNDjAI#6Oum.E/T:.<o&s8t"a6O
QD<!ZqcVXJQlk`hI/s*kMofOTs[c.H%n4iW]Amu9-Z[$`Os(M=`O1Sl0Y!iHjQt.t$73(OI-2
UaI)#0(IoUdapUpd!:&,(AW=uq]A:S4eu/%@L!(sG,b9@FE^'Hn\NO]AlA%p-:uP%qrNF-\/92
9\)U3oBZL311KY_5k!F-OqJ%>*PF?#2(BWamod!Kk%ibS#V>P:4HsjZW_Yoi9nh.cd/DQ72"
@-1d;Oklk0W6:\7urZas\FI9ZCaGDs$ZUjrG\uAXpGEmJ=<I(E`T#Wfi'r>=Ifu6jY4XF>0s
\iFpf)F&.r-ooM2tXqB=0)l5,E<WOLhG(LOg'NDeJG!XqgG(D"@Te;YNko,27n+R6meJTp^D
I[_?6_@9.?[Z/&el9QY?f;cK=.@Kt$:;.$C]AltA(C\/KO:jE5OgjP;%[IfNH@]AX(!&CP'GPL
B,n60pa>9L/Lc+3*B0:3B`3l5CcK"r@Bf>K$KhE$Yn4CH8kTZ"Ka8hJs7&cu'qFU%>3kP%Xh
[keW6[X:]Au,1s6ZF`V0,ng521,L_/0f*s!elc-I2nZ.uFlO8"Sm%r%FH'_r3Ai;uc,onYYgI
MP#a@hHYSl3]AI;i_/l.foi/=Peo5m/V@D;J;VtT.'so8/-tS%[4:0UH^ch+eOd$<%dZ7.b0/
P%`<(f]A+YFY;]AQg26%HSNqAJ4XiqFH#H%clE`_#8@[%8LbeO/P$_2E"MM*:TD/</t:>m@$hY
K0lf(0A%"re%h3`^o<nS?MZ&D'3WKrti0k_E:r)%_MGVljXi^%j)k%328\b1GobRT!2\eC8[
Z`q?f97I/6kA-$tE(RWLg&cm_=Zo)_cC+qa+<Ma=8=Jd]Ar#1+i]A9-43iiIep7]AP=h*j/V.l;
j#d1cUZlg>@b1+Q)jV/5ZT>cis67n0.pR54o^QTr'(1/`bWsYm23X>kO*^,MigEcgT[?'gQ"
tZ>7Qh1Zer=pk1)-")^Dk`9GeM_M;"qEePRHqDYAtR>d4q;V@ESVZdt/Q\a%sX&2L9\1_Y>Z
q2iV1^X'<>_.>5tR*O^o;H#G#uB<p1h,4P>6!^*u^S3SZkJu3YY-CG:s)JW4qcJ9([JY;>F^
B7if',@T<<A*bW-#5Ns4ak,sn;b7M$O3Z9"lm-2m#cVgO_f+&D!%*p*fON:\?,Z$TAY`f?D0
dr>kf,DOpnI_dQ"uO8Uk(6"Fi/&Q<36Gk_F]A/qCU?q;K[TC!Lg:B=_q10c`#crLd7'FYIY#i
.@,oOUuE"%0HSB)1jMM>A;LP@2gKq:5K=/kkO*T-gr,l0s%H#N%(4SQH%_)dL!Hh0'1^/4O>
;9&;SYG*cohrO&>!Qc16[6K&:A!nl<\8."u#9+MX0PR'X70UhJC8DWU79dJH&XG\K&1N&RMK
2&$<6loS(&X(Q33A/nVUp!lAlqQnlsc(o9JtfR*'9SS]Am9[=O*=CS6u@_JA.`2]A_$9BO%`6e
I+RCM9`!g;9a+MhYpOB`qb-UBZiXAa6rA@'\jo:^r(?[#_E/JHO.eTOlg@9a`_^Fm`"87E0P
mJ<Su\laZ!3P7WELibO;;SI[ndOTeqgsSrgO5)RhB!rLY\A\+R;sM*F-#]ADMI9=_*5aIn.k@
[>Yd%YXY)FC0NWjI,Mff's!FK!PG4cH;d-3;sZ*CqMVr>4jA;O-UBY+i(/>sFN<^J>2(Nm"V
f$TpM"p:qjh@k"rC&+oH=V]AXp^2ro3/&^Mlnh]AR2F#q-&@%:#fmo$1`5=Q9CXQB>6G3-UU&%
g3?Kj[*9`5Q/2[?;cieuc0fbeY.8Hh94#D:n5@*qcHd7fU"AG&,[Y4!,[ta'!'0Ijd!jA=e<
p/p-i_C-0nT!U^g\#ln02-I\q?8F,"1PD0/AHW?d40I088BMPl<KQ]AiVC#1_GrH^ab$AVLQ<
>aoV5iHKo<VtX5pFqE;`P7/Du1m-L+JQ<i2t"WGgO4,efsf-?lC7luiq#N<ci>_=oKU[Y.BF
mX%E0#X*fo=cHYlDp%n,(L?oS4$sPm-$@/pj825:eeSK2+>\L9\<nI*cTFIC55+ociZlQJ_M
ooEfsGNQ'J>N0T*,LYi,pX]AV"@f+gLDDc^_U_VYhoqY7J9(aHlt6/p`]Ae`-(Q?uV478lG(m9
4e%B1tT1eR4V3tr&E:]AQc"+J'INLPtnDN1LO.n1$8,js"j5E1B)NYnj79Jf@77k^#6SEnM-I
ZH#7A-%gJ&n-5F!LSMkj8HVr'#p4mTi6rQbaOeU#.Wkr;V2sjbnIboQ:$6i'6Xb8K.6_MK"l
$pKi"-nghg!*OE"%"Opb7G!.f)k9!FKB4Abt3*MDqp7Ngm=cqU8$>s1r9')pUEkq<)=3o)(!
&n"6cnL1NHo17bt(-4^8C*=Ij'"gkp@@7u53P/"_mdAIq#YLD8E=CE2A,noXi#'.4M@DZKN!
-C5.AK32RMaITlHaC;P&?%=JDb(C-Yk`0hdk-t2uW%I0^6($*bF=@kh>Z3D*ok6Ie:W.=!uL
N&';VS_!AJ<,Bji55!-mER;bc4CIZfuX]Au9\N9p3U2p.Pd7QnITXeMue1U(+4-'EX;,3ccQV
%L#B-QnE"=qcN40`m&*90"m$$.]A.!o\rf/9<\F[&CLW5K4&.gn.LKtAVSMDrFE#6EC'BOeF]A
M$Ve'`kkg*SP8A13!Iqs]Anbd&ma%!2br\1DX>J%^,>Br^=k(&6kYo\,#o:6#-9d-[PO`+:pM
G2#\F##G[Q9I'KJI1tW7hje"W[s'8+5<X>5cGcZFZDXJ+OU:!H33t0D7qn[K!2t`n2!mi<3h
$uHH!_?dk]AZ8Lm[`oPT"bmh.EL%%5:3ZDK%8s2qjPoce7e'_&7;aQ+4s'6ia2E6S';tirheZ
>$Ng@9E\.>)>V<DO9KM/*!(eE>A+pEEV>usr'3P"M@Z*P4eGR=I_aVg9^1/#U*$?+Y>N8HZg
Qc\GRK^n<<AJ9MrT-4'RV.t=a[N_OVuK4MMCS''?[sJ_S3TF4BV]A/m#.ZbDh_[WM+8l_DqJ2
)=JM98X&>:M:-r+9W=5HhX,I1AN0:%07\eHct64bN%jk+Cc+t\2^P1T4$I>\V.YVM;MG:(]Ar
kA&d4@,-;[mRS]A`#Y5d(::\n['0[9FJHc0oHRoUqYnL$TcT,;BU:sL;L#6@BpDs,H&?Qfs.G
gW7UcP+)JA<#1h,sF=bF3[r*,=_/Su+:V?TGDZj;VdWj,Of\#osUJhs8NuHYX?]A-QZ)mcs(B
-p[:dj!.u#&J"XPgNW7.\Z>Gtl.CY%%HjT?n=Om`ZbO+BSWP8+<;ToXUs$.=QLR-<9);(4A"
`X@o=%A"tDWuP/kJeE!Ol^+rLVL%:3==`t<_P*!r#VCM[Vbon95&:GZ-Whfr+eO!4>9&t+7t
5k&^8'd2Br?3\!?rCfHN<B6ooFqeeVJmhCeO&B#mNGAXMs7n?RXbk*^bu)$\?mo..\r^]A<nq
5J[=>hrb+AQcD$)5[>/%kZ$RT+B;E5(`fr@.DZ6a=HHAN(YKpb7F%H^o!&1i3)ARPO@(E7Mr
]ABB#/t=u(c:$$?i.AP\Pb_Ld&JTW#Zs@(j0aog6B(dT4@6;5Or5)@3K]A3DKHe=&3K(Z]A!<F1
W&H%7WP4Kn;,f/]A0?u:r[K*@:HH[#5u7AI5;30S<%$#l#L)5o'Sd?:4.XY,(+!#Sr#&),YUF
4LW'+j0W'Yh>OcW<d.NH93-9KCe>`SP1JUV9fR/]AJ?i?E>OWgmo&.WT^0SqL";fH?e5:#";<
jSmcN.n*$7^!Ik(;T*>\Z_+aB]Aj0/+l;ag$CPJ_3&\'R)<!qZ$T]An/6q*J5M!E0I[RG`"?Ap
BTjj1NaD7l^'d1EB.mD'@7J)3kE)Mo:KdVK.%>ZL5qZMr<3(`/;bB&6><te1.4M%Z2Od^Q\3
jOf/^ND7_XXLi8-kalfG"81'kZFN/[PRum8G(mr$0/$bB,3>Ur$(WDYpr[?,%]A3SL`q^JgK\
Il`te[Q]A!*8\7(Keq2?(M5tVW[;Dg`n53WG7?8=0-QB&0ok(A?amTnCQEP;PkH0C%3q;CWT.
<MRE&IPZC%bK)P*o37?-Y<4GODOrrd.q%934iH<,Q5=Neef`-cTcGE2,Ue*FJ:Rc2\$85YfE
Mon>5q>EnE&HgDp"AKDs9dI@3#Mo0(@hS'u"r$3%29j0esiR8C)-dB/GS!3^B!><UsDB1U_B
h_0?1_N`4f'FA]AU'f5P.6@hV@+Bj0i/XTr\@Xr8#/)LIh@[>:`n7;`4;d7c8MtZ(@bV8.;X6
iWtXFMW"U`gV&3nb$H/fDW9*`FBl=FDBqN&28*X!RZrhP(o-o@hmJM>tP4^+iQ<*<MiQN7?L
@*:a6+*%#I_LVQ5)M-?p7*blpo(G&*Q#.fO)3>u63XMs0*#;r!G!#AW=WU.UOcom7c&eEKZG
=m@C?YS.!fg2#S*3\-<p!]ACLbI>p6**j46MH`R2AcCiBiNkM1-,D$7Cdu//$/i%L0k`7'hr"
0rod3"^8ORdMEKU>o*UViN!TZZ%]A0X=k_[r07aQd9<b9fVA(s%Md#^l6Z4$2*l<hEV*3+c?-
*Q-9l48-hA9kgg;c?Ln00#PD;i2=UC]A]AsuOrdN<UikGX'MdG3=!jD+n!<~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="244"/>
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
<BoundsAttr x="0" y="316" width="375" height="244"/>
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
<HR F="0" T="0"/>
<FR/>
<HC/>
<FC/>
<UPFCR COLUMN="true" ROW="true"/>
</ReportPageAttr>
<ColumnPrivilegeControl/>
<RowPrivilegeControl/>
<RowHeight defaultValue="723900">
<![CDATA[1440000,1080000,723900,723900,723900,723900,723900,723900,723900,723900,723900]]></RowHeight>
<ColumnWidth defaultValue="2743200">
<![CDATA[2160000,2160000,1872000,1872000,1872000,1872000,2520000,2520000,0,2743200,2743200]]></ColumnWidth>
<CellElementList>
<C c="0" r="0" cs="2" s="0">
<O>
<![CDATA[航段]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="2" r="0" s="0">
<O>
<![CDATA[区域]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="3" r="0" s="0">
<O>
<![CDATA[主舱\\n利用率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="4" r="0" s="0">
<O>
<![CDATA[载运率]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="5" r="0" s="0">
<O>
<![CDATA[航班量]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="6" r="0" cs="2" s="0">
<O>
<![CDATA[机型]]></O>
<PrivilegeControl/>
<Expand/>
</C>
<C c="0" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="明细" columnName="航段"/>
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
<![CDATA[row() % 2 != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="2" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="明细" columnName="划分"/>
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
<![CDATA[row() % 2 != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="3" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="明细" columnName="主舱利用率"/>
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
<![CDATA[row() % 2 != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="4" r="1" s="2">
<O t="DSColumn">
<Attributes dsName="明细" columnName="载运率"/>
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
<![CDATA[row() % 2 != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="5" r="1" s="1">
<O t="DSColumn">
<Attributes dsName="明细" columnName="航班量"/>
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
<![CDATA[row() % 2 != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="6" r="1" cs="2" s="1">
<O t="DSColumn">
<Attributes dsName="明细" columnName="机型"/>
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
<![CDATA[row() % 2 != 0]]></Formula>
</Condition>
<HighlightAction class="com.fr.report.cell.cellattr.highlight.BackgroundHighlightAction">
<Background name="ColorBackground" color="-855310"/>
</HighlightAction>
</Highlight>
</HighlightList>
<Expand dir="0"/>
</C>
<C c="8" r="1">
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
<FRFont name="微软雅黑" style="0" size="72" foreground="-13732426"/>
<Background name="ColorBackground" color="-2167817"/>
<Border>
<Top style="1" color="-1"/>
<Bottom style="1" color="-1"/>
<Left style="1" color="-1"/>
<Right style="1" color="-1"/>
</Border>
</Style>
<Style horizontal_alignment="0" imageLayout="1">
<FRFont name="微软雅黑" style="0" size="64"/>
<Background name="NullBackground"/>
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
<FRFont name="微软雅黑" style="0" size="64"/>
<Background name="NullBackground"/>
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
<![CDATA[m<j7G;cgEAI8JWeU",H!"k%.fdh,.c'p4T"VCLu0PtmlI&4f-iTN+:8RY8=)<7)=MeW(5-dM
A+Q4qLQl'1a@2Ld30Z5_LE"5lq)o+b@:IIODRp.r]A=M=L>d9G>7u;31R>L?JkV1\%]APnY)el
;9R?6:(FMnD0^8Q1(4SGTJt()>$.$9Xr,^5/qBu2$E5I:as*T=d?iEgFmo'e-CLYb2WNBOcQ
ML=n,Bp0%Is7%D]A3dZVlh&,DcR+,S^$Ppee'AJd-e"]ASD0^P6^t3e%rUcYq4s`rVSafVW[dT
jcIe)?4$3+a%IXKh.A'9d476bUb1uCLBGE4r76R]AR>,\b.kUfYWA<'mJ0EA*;IYXX2D1J'rG
O'kJ1b%?W'#M5m)TB>FbeM$PkYIeCKB:6e&M#WQd2!S7AO7UQ)G\6G%Rp?1!8R]AXoG?44p)6
!e?GD++F$pN%*Tpr]A7`7=U3)3%f,]Ad*qLkh[g"LcJc]AhHH:.7q5Ud02:&LKUgJK',/]ATKo>O
lhT0uE1ntY/V1qMgVWGR]ALb3]ANB&"GM,NkD"*9Ts+RWnflJ^*hXm=T+8g,%lb-02DZX0#f*[
9q@*htj`ilE1;c8'aCLT8o)=bo#rQ<.>o?5=;l%je_=)a6'biaBq>,Y2p.[@q/D\a@!:]AcSl
7SER\L\!'MD<cN,AUT$8'f9u=p4!GFJrJe--i-LYC7`@%%0lfPn(:H0HW*c/pJJ]A[oa=-Kee
;burL&iW-AL_4J58F4pb%eQHb+la&H,A!1frKE,E^T7iA0-_;aK?i(YV%\dM?X)Dq>,Cshbj
W[1Q<Ucd[D[3%D/5.a%3EfsS]AD63_<A;O^bU5Frp/G<pPpJ;e*L]AJYa&e[#9W_9^-;8IN2GS
d'YYN*^?20<qlO"Pk<8U[(UKCcnkI40bmV3E,io7V^Ib87F*60aK_+ueh!_aj^m_"RM0%NBX
6u&^s'f*_/73IU05\3/>bB+08F2hTSDS^khOg">^%EF=d_+jl%?pLBQqH+1h4dtN/!C_i;Ff
G-Mo,ReKcV!2HpE"dIX"F_i5W^fM>m2"PElD?0bMuLkYf)0o,:;TQP+K"mgjiAA3k>\o/UF7
VrI8F2kU4G(7QqLpAG(3@u%L)U7AD.:l.4\bP\%gD]AlaHd$,rh/&fO!>O&Ca,QAKX\rE-Hf!
m&OIcuB-dEmu-*@Z;N,l\`o5Y,]At_GP^NRU"]ArI,ta:`G<Gi,@5<5RdIH09Y]A+>EP@rUUI[.
^Fa<r=LLY4kSib_Ho.G:nKJ-X?(,*kp5*L??0CLuJO+J-pmbi<[4#<>"MWD/&/YNE0ak+RH4
=&2!<A@UD#Zj@$>t?g69A_$*'3#:$goBNJr;2crT)EA7*VT-6'4CC,@"WCWB:j+pJM.(g)m4
\!".onRC&--UK=MfrlE@87"dY6iQ0WRTb*m@/s$?X10fAf'N+4ssCR=MZKf?m[-#c_E=&0in
/7mBFoTAgr7ErJsZlO&"#u[:+Yp+02`Vji8Tu>fpg\8uN1o]A6^1@fn,k4E;_G5;t*"MiTFc4
N<D7"`M%"r"W%1U0$O41KMEELM:j`"mT?7d@PO]A6rp??SS`VAFsB'::,5HV=lPjrHIDZhS;g
lMY*`4\\"Cm`-!S`?9iOkDqDj/ojgXm(FT"3,A6)9]A0YKjH$0Ugb[VuHEVOk79!Fc_\QA!J=
_>"1XhfE<YqE!q<o7&I"$#3173k/+hP`soY'_N)Y:u;om:ZiT8$g+:IXkW,<pO\qV9Sd/4a6
#@>ijS=V,c8.N.)=*lir:42o+:aJS;,9D+/>o2@Uk$e^2t)<pSR*KqY^`BSnN[G#ZUW/l'WA
.*RUui;GMADb;g-/S_o?EUR3>)c3^PRD$G?79WKQ7=Uh<m4$V:V/4&nPlt%_?1r6+I,H.%PK
mOKh:E0@O?fF#bj0OaGnG@-[`g5,+$WL%g\Gi4;[PSL`FA;>#m(J=Ct0.*co)3&A/AmX.!E/
GFtX!bQ5?n(]A@=d+*R,Ar/Z[d1qE*),i[<_iN2Kk!`c!ZO49\3_%N=_R[:"?u+VInu/s!g]A0
k`o#X4"PiY14L))P,HV0P)R7q3KQ@lU%TLEaV%;%&Ns"N"Ya2B1Coj[CA::>Lh!W/`Kjbbeq
\%?q$*mP)oMhZQ4HubuDk+ej,oWrL>OG=,UVZ)3)!R)*4TYLJ9F+.qJ>jK(ipL=-&_T#O4!Z
nT"R!0fOX+hL+HK>bDUo3&r%enIE""Es)p3V(W$?XN<7]AI1-V=pK-K\ep6%O9gI=gAUgXDrA
VN^"3,]At><F&?/5`V"MG<s-.U0=r,sd.fF`ZAMh7OfV^ahS,"g97jJo7]A3qfqaXs1NH-N)ZL
N_\m=Lh)Io;T0ES*<`.0[Jd^GB+%r?"'P74^M?/?(Y]A1CU*<Y/kk+9t/d7C\3+lc1WYuhCBp
!CK_hF\?8;T7COQPG-b;-/LT(,HnZ+\u<?UQDWmj#ZT/eu8iJh<&3i?Ue&V?ZlMiYC22'mkX
NKXk/4(6m#Nrl8abB"5W7,$Ufp',&S[%V+XdqbLI!"=1!,k=/3?"Z^VJ./$+,H3W>8s^J82P
D)I"R2K-5WPijAadaC).`!u8"e,f>iV]A$dZ*d>1HiH?\6F<4'&Kt9C456)hs,0@!t+gUaIEj
IEr3m8d<lZ#8DWn/8;P"ee%!r8L?[usH#Hn2T#d,PlfPHafrh55=(.\1T-R-.Zol2>XbkJdi
2ScdP$I*sqr=3OEA(>p%2kIjYnZU=$N=-4_ZJs'EoZ!(tRI\a_km[n"\@ho4b[\SJd=pYRNg
+-lNUFH"R0.j(P4KW:6Hlh`UCJd5q+'M.Rg$EBG^(t7f$&cB;K5DL*l`/h;Cb3C;<07&,o5M
]A]A8gRUWoB.U-=&`o("t_qoMntFI/d+815Y%Q9=r*+@LFPdOX'f9KW*"=rbb1t?H9Ua<<^W:.
B(or7B!hbWCghlnM"L.XDgP3BVgt@1lo:,i`g/O7rE+_;h0#V_.P11$:hOr^L.s"c-/0sh11
T68]AdFX.KDdn;%_I+EUR1SX!!8LhX[![i^Je;+]A'UDh,seE2;8m-<!U1N<IKX="ODS.&gLZZ
)YBiZ`PL\Ae@I^O&DU'94NS5CQnkqoGPt$T>0FB`TF\11Ap!eiN<5[D']AWes;b&>LnO'PD:_
mm&%KRSrU-nCkJ%U>4lM!/)7oYj=W*0>LDV\q*3.q5^d5qcU[\^@@EC]A%4KL(5]Ab3gJ3P_%3
.%fsdh'Tq*\2#i\`7fN)4#4:0?Cb\/KD9P&?mPdH02WW*airc*^$HXij,/!\i'>uDBM'3AVG
NSK5JIG/&HZ"f6?fr3cXBZut49nKl=p@,Q1H"hD1WV=pe^6G']ARI.o$mPS=_gU006JCu:;hc
F/iS<Zgb"q7?="3oBQn%i\b.9a%E[MMFQjgC"EG=e]ANNk>M)F]AQ!QIo\5CpipO\VC&4<R>(i
^J?J<b$HmTIbVuSj\<c[8p<,s*qHNSNM3qpSp2?E\.>mk,^hQ*Y4Q_B']A'u0sNcMLZ,rsFq;
'l5M.@:ZIg)3pKofW70diPMe\Bu:7@#P5FNm>B'Iip4"ThD#(Sf>(&A>]A"3JCtSIT$j''oDA
S7R8:F7#t)9qeJUEsM=Y7d]AMCh)Ar.>E8=F.gLJS'BEIY040T&NEIb>^J?R9?`/Y9j[M5g1]A
(3=EAH_R!Zm<i-64cNacUt2qHM^#4(R-a;Zi??uL?)K(&`9jtA#_)!ojL;+c1c0Vb_d>qX>_
UgPh$qFL=LgG\$XqW.4]A]AnB1fFBeI?76EnJ>5f(dL&ph(1J?=a%t/ZNlG/&1/a`+$pWL5+"S
W[TR6Yn'B@_m@fuU+emp>YeAkbj153U'^-oO@#Mp,GpK?"9j=K+/1TCg.4<jgq>$;Sj?O%A_
I]A@3'8i-s-fsg";+]A)lFS[Q2\,N`6l*s[1rnM6^eK0j=M&c@S[fOIg3d7?^Y%t4i7lG]AeODJ
<>"Js(eJ$(V#*!"\I!MjF%_/rt>)mGLj%TT1o$R`f*5$+WrgiVTnjiA<T+/0r);K'kG<)^4r
5^^u,_.uM36rik`FbM6#%`f%LL%$.fs!rV-1ao^+d)&2TLUue`9"!eTdDDnc9p/A[!@R4j2R
=t"ZD^p-g1Nr<P*h[Lb[#Uh3hUrnT_Yb@<&8)%+m;;-BlTbK[Y[n*HcSG+W/T4EK#Fc]ARcH4
APJM%:=<Z"-Dt5F=bB7IAD<_+c";&dE#GNqiQ.2BJM3Iccb+<6ghAqh=9:%/%S,>:[-0,LhJ
h%at:R=0Wj$B(O5b&Trn0b(j9o>*![!`&DkicsD]A`Y]A"ef?XY5MHioT$4^sd;CpD;Z/=X9!7
)A^#E^,d&#]AcgeBq$57B$aqlMEcH.d!U:J-m:B!#l5ouc&U6]AN"PL,#[#/Ul[XD<TaJY',k!
e^#e`j8W^P27/mH;)@(>P'X8,l+R_3b'a8))58*^AY/[kCGV^kCYiGSgk"SDbDRlXVtYjF]An
N=bfIDiPi9Z^%F6Zuon5836.sd8\VNtu%b3UGg^U6!fkK-K,J$'R:[#5&&De$UoVXa<]A>frZ
GE1M2K8)m_?)u?D?)\6pl]AfArpmtIAu>ok*KBN.C>oGX4^[eK9NeOGbq'pPMY/b<K`T;]A;G7
$V@GUBdHS&>K@$QSiQTVG5+4q+&s%g<SePYmEZGArBE0s-"QL#4dJ>SJ=Z+Fl-EW%XeN3J;0
kbTY`d:YDeTK>`7$ZBT@,S77uN/"m2lT3\uA>`S\B.oO%tseXOt=;FSn"R2ABh&XNQ1-gs2"
iuL_O]A9/OSDEEA_@.rdQ5<JRh%Y>F5l<KR,#E^a)?bAiJ9o7+,FQ.4(NTLYBdf!O]A!E5#/<I
T3V`V0&I6d6*GeZ^P9S>k,bW0*EZlItI2'Fn&ijC'[.gWTI-GiM7J>%nBh-<ftg'>rXam5.;
I$X'Aje/L:Xll9V\HVe=[p@@'=[EY@E$AGQj61sdM:[Kd7/`8/'TnKSU!@2DufWX57%4F&rD
7YI;g#uNhIeXXh/"2N'@PJn8AL%F5NRe++g+-"QYkn`^e[fhm?^Ik2n>r%--4IS=;%jtYr1`
r<[\4uE(ZodIX<3JDf!>HLf)*l+<au:/pnK,&l8GS%2D<P'_jQoh@0MX,&08RA=l7*n#N)WG
#?RNoh`43b(,MS8`]Ar.?[LP34(O:!_APfM7jr$D!&KQY,E#(\hLr$B5npN"]AYl&Qd5U6.t6U
tW&OPX+?3uCEc58"RloT:0F_rp_qDtaG?0%iBfn,?k5'i]A[3O5QsKDr"%1n`EN4j\'oCTiqp
Tp/):!UFX;l^S/Y51^=)T77:T3FDZiQ3_H)7,F\?VA/!Frcd^SB_bpl^1q<iJ7=i^s:gF3Xi
DTf]AjsL?/Ls3iWhLA!VoZEIK_=cfEf_Ma?:d/['O.s(QYJ6?rgKJW0H4aNB9?crQZf$*;;bm
%EXJr)i+3E'*E<DrMpQH27D^QUIoHbkLXNOTc5tP+X6tT@b[oD6\=fFPa,t^rhko+5]AH_ZmD
<88lXZ9!<3fP/>c,.g<Q-i'Hq!$<bQ8@m@8QZu.cnT5]AIBUYp4%*qBIX4O!iXh9SoMkd!)o.
KA!OK@hN)aERb:fPTikF#^Z_[U+^B[]Ae-D+D'[Ykt<U\@/D8oPD*9O`t&\c68%gjg5rCh!0J
DCpbki7p-6O2QJkp;DZnbQ86G/Rha\]AY)Y'+W8a47HNQPE4Wk7JOc=G4eT--:o=G18mff74;
V%qbXARLC,p$GYG:SpMqKt7A;[1L*)f"/TZ]ApUpYF<5V:05Ch6&f8!k0%=t9K%XbW4RB):1C
PW]A+-s2<<f?=\Sd,t?!\L2mJYmj/ml*^-63P;o*+iFW3bPC47r<u^[cVl1q"OHckbBt`u<lh
a^gZl\)=t(8qVMM$_<>p?iOtQ'B>#:A*mMlmb'opoHBLe)X+EXjJ$Zf*LfY=$Hkc:nl=h6#S
G.1^3>_nUc7k"UkB*@!R[!/F91_3!1$??[\g=<%,!pNlUhmO80HR7NZOaUBl#^LJpoJN;em<
VY<W_PGErC^b%>tBb6>-iCrY$DN>-[1o*V1hb+;&BSQVG2lr>HKI_h!C.`MG*\lMM4)$_'H<
()EtJkH+<M4/SQPi6Usb7&7PVr2E:q5X.B*gGZH7"f)W]A/&4q9+Y%JG$F93?p?f[K&ETX'(*
9c)J.*\cH<bClpj*-%YlrM2G./S@^N\@Xd!:\HDW'Whoac\ojsRHe01ktdUd>?d\4sFj&="+
7]ADaZ]A-aI.FZ=MLWphM2FL6>G*47/-<dhiFcpZ>A8*N5Hlf]AT?abpFnB;-Yso",?r^)FZ8b*
L^bW8[7(T,H]A'`VW7K1UkMiTdr.ONa\gqfgQY<,hAV2UeXar?(&YZ#bV[urL<?4U<&6=4uSU
"V'+ad_t&?2dm4XiQ\d8"k]AJjVPJPo=#+R6<QH'3;.;g"!/&T(mepa0mn+&nq?"DF/UdS;@H
84eP6B3_uMtd$3fJVKj-41Q8rr,%mF_r9NOMF3'Ho+q-gP<aaK%0RSVBi+H\^;89AK1)X;g9
"J2lDK&(OT41DACa]AaO7O"%bYkU:0Ck>n(hjbInOM6m]Aa5I[b14<).gNHbqS2=Ph6,"i;3+@
7A$91bF"Q5$9,KtrI!p]A8'NnMTLQX9EtPjU67F]AhO$G#G@IhD(WA;c@EE'=9"_H%g.ZGMVX(
LT9no/?nj[,6_SjhjcW&L@E()NUAfdM;5D?7!>S9/_S2:W^$Y#JC^Im8*34q8O)g6HQS:cUj
*<Mb]A*X,25VmPlZ:LG+Hn%(QDL2=1rog69KID.9MW7MG7p7d\Gtj+js+>O>7N?L5E_M+D126
C%1;obD:S`lg;ngR"NW"MH?!==\nH*LUe1cc(HnnOGFsr(Qm@iB-L/eC?C^FrAZ",DD3=geE
78aGZ_$ZPY@ZQ[<d9M&."AaGeD`+*R*H;7ZK<L%5a#l(nGm5Lhs5e'TK6`K$ENMJNh3d'6C<
gV/WXiG_o,>d#\'H=pD-R?Mb*\'Tpp$AA;Tn%b8Qmj`OS*[MD7mtcEn8\,P+/lca!o-"62f.
+Y:Q@T,fQL4&d1ndILNMie^S1I*#XIc&R:[Sli:\"G01E\B]AEV\QHj@M;(!99"3$.(-XS<O$
-43NlJm^JZX:W)l53(Re\+-"/f$V8LODZBYd$>!6<9B/iZ1fL!dpP8Y82s1``$rB&&i[SY1j
AkDAU!UA.+h^!3?`g`BPOY=$51n[2NE%GY%52IsL[BBagofF:6(MuVR9>o,]A`mMpPT:oVT;D
t__GdJt#;7R4.?qcN8onQ^r''GEYWaL1r%@MQ<Mo2?HItS_aJTth1s*Yf[XEE&01(a^gT$2p
KGK9<(6ks8Rrf]A9BXP15BNRFjnLKS&:YQ)>SNJO.g/`Y\J!'9S[M6*1U8V%r]AAE$,.Rb.EXL
Dl&6>9_JX!fJ+XZcXWE7VULF4dSpLfDjUhhqj9nN%&0RWH7XX`>YZ7C+5cM<k7k"Q*<+b7;1
hK)*:cd[(KN:<e1uq.)'qgG!!6^hk'/cd:5B2)R'D+OGj]Ap]A%=*6[JRj74`M(K:8)Ad7d+<#
^T(&3N:\-;t"A#bi7%ZflH5GRYiCf$`6!rG7O]A":$:pDf'#ht$Kc$=06K0`X]AN"'[g\$V:QQ
#8qY:\`e4Lo?EN+9fK871tPl#76dV?GCd--NgPJmq(;q0P"F;$j'YC#:Uo9m=U9pT3q:n.Fg
eJ?:DZjpu>?qSKK9ASM#LU<U4QarK5L0r$Q[=9m\OX&PRs/n75(aB@m>7&ZIX-]A8-`&pGF*g
3-A$O&f15uX&&P%84gmgJaKdoWQ$nNA:b,c"RK+u"4oX)h7\21!YZMr>%.$KZ%L(`pO@W7[?
n9$8t&dAGCd#XUXVrJK=j]A0-I3G:O]A3]AXKh$p/_'U=gnTQ6cW^,CpTu"<:I#f*b&[rl>sWub
rK+8&>r0Xe!Q0b$!^pL6X.h3_>VE%r-Vu\_7DXK9:@r8Mp-taq4"f"1c=r.Z_bpR>m<_rJ,?
rsg=bl:clK]AK9U3kceWZa#&[G<1mVF`"&[nXk!qG/pbd@X\:gKAf9\&EP692*6GaeS-3<uMc
Vt0'b*2c28+.&u_Fgp`o6O@`oRC8EHJkTJ5N2E\T%`9*$L?McV4cROcEdDl.(o&c3`K<sZ?Q
5.a.Ds?/6RYg8ZdPS#n;LPG1sF2XPE"1`&)mBuXo9<B-8F#u-=aKpA','6Odo_XF^jdf8\ko
N1/h^iA_G,pd-;%1fRL4GI9-([1n2oQ7bV!#::SqiO]AD%rLJ5,K4D;C"8p4.;"gQr78/%5\r
Y1/!+FQuf>NBUhY))?l8Pq2jfD;S&]APpb*2B_p6,1PZ$Z%MZ@&$b%GKiZTD1FR;GLo9IaD18
KP<6*`f1Jrp"0eIQDPjtOgcr_7t[A!a<"WOHC@QfrVF.rJnI-X+E4LTc8OQoq0;up=[N-NB>
j<]AstmN%&$+;#?/:J)ji7J6a,4'>7b"(apSEmHRlA,9mp6aOEdI*'4a"0f05dcd0U\""!"Oa
c3Bg)=!r<@Om7hccLMp4:RF,e+4>e<DlA6<;m6Qj7man_-pY?9sL)[`()=HqIcAPkKIZ!P:>
jo+9E4!oq=[p@um1[/0Ee"D5>Jl)!"m>_u:`",@7]AP(%QW7?O[Vi)XOn0Ks/?:C%!NFFH/U]A
ml*G.Z[t#h!Ee)%sEKDO/FD,kj5!>q0L8MI,:QM\r;ut>Cl,IC7?m!f^/,!PGUCu8Q"dG`YS
1\oBknTdYu]A>G1+t"qLn7M6$&n>9N/kA`m4K=3A,^KMEV4pX-o=jSZj?EIO?130a!9QjWQ"U
Kt^jR*DGgA$g\IX]AT[Tjl&-NoF#,B0FMj\a83Us#<508t0Yo"(Q@&,q;.K-ikI:QBC1B+QkJ
m/R#B*/H*1:C\lhQm2EV?4oW/>mFJ2UrpnS7'rC;9VoSr&dh8h*qQ7YtR?3pQti\tP_,i]Ana
<-!'%:]AF5C/A^!tjC#\Ou9qET,"?#/_A%Q1L;%n`".O2@Nog>^FlUEK``$n&`er_<Lk@>H%L
&d7]Aon1fL0md#tQh"!`ZW^VjE_eo6<rL_mTa)4Wis-@pf]A!d?\m^<c\=C#"e,'Cm:6T5Pc4S
i]AK"JDORe_+qAnp:\Kk8-S8<S]ABr06DuV9[*;8mZ77#No-@`%nBdCh^\r#PVg+2AX->>AY<#
`7SPu;:gqjg66mk7V5".W;YrFU!!`$h3F,FW.p`leVLVW>7Ho/-"J!j'\TmhB3[d[!&MtNhA
iM0/L:)5*^n$ri`e*aP,&dj)$QWUR?[-)Srk`6oZ?D>9*Q3g$H%7u-X;4(8/@]ASN^jX&9)t(
s$J0P+L2FSb:kQ@5pem!L;ImmF>.jN@-GTT+s+e6ik0KHAnoma_JAJ+f;'%N;prH`]A"&)>g"
7F1B4Y'fF%?Z,#8L+G!Ce<SVmibbYdW>L0MX(S.=[:W0,+8Qm?DDBCa#4+#mY++c0#\PB+"r
%T$0OHdWC$0gZn4WSXV>V,?L>AFrrHO)-/Hq?K*:tta!*"'-M*>Bbl99YnjQ,l%?bn)'G7^G
7*pY#k(Ta9]A:gM8<T/Q9GeScGR,!n5!a0,thPs9<F<+<=^l0Tci'gNnBcS'P+@SiE4_l;N?,
IXc;VpVo5A#Wg2_hXZjj3+F$XR^BI?;6GKTj8$f]A9BRB3rFjlGl?P'qjTP;,nH><1o&r2BpU
+'kBdNL`_eL51(td$$bO0Jnar+W^QS=Dqq)\3+]A2fhS$QWXcgVe"]A#O'C$Y/a\*O@mHF8N=p
NXfP-P'tuW2;sj;ZSZD%Iofol>AH]A-p^1naMs(iUNA(TrLY33\]A3%YnQk.jnW[b&HcJ.8V"=
!L:b%Lt:<(.sabBbIp%VFZ.^Lis-Za\VhcV(b>d@<]A"^>Bbnj[sjnE@R,H]AN\NZb]ArC6qr;(
mlAcq=]ADHAGrfF2RJVYS%:(PDh<&AL9]A1=^N;b_TH/j\lKKXY%K?-IuPG5:S7&JA,U7m[`[G
'3_*d7epG2o7]AA#Bnj\ml$".,c2-V'q2npN)6TC$Qg_q.Lel&'JV#._"/!&Qg3`MuK7!;-Z;
&cpY0M^Hi/hE+8%gCgKG?oZP3</+;HA<Eh?A[^@@,jNi+aIGm.`5(@1;&)-jqE(n51iAsBlM
]A&LF0?\!(7U+,O/%@oI9FZ5/-6W]AA]A8srVn4i$8_bn'PgckeU+1pNDQi]A>F"icgT4m2B3`3"
bDr-GflcUtjW#f]A6Z4Ds_<ZjFT#W"\-171GQZfb>.\]A(),*LUtYH*CnJ(">56FV'2I"i]A9'D
[4B5qLt"e+K%P0."[=KMi3RWj-]ARg%Jni3E0Tq-^Nm_]A^l8=IhPsP/LcD6b[YH_>&+A<,#\H
=?'_%7^7%/p]A.^cW0WBnUQ[,54Mt>c@>(7i0M37o>(glPEB\1sE\c#aC$*AG!$?S#gDb7Nim
1ol^ZXYARZ,&uP/iBZk+fM7DDb3)\SQa]A]A:>`SGH?N%V<Ol/$;Un,H"JWOqOQfr%)hIe8rTG
hRcLl`pFKGPlFeib32:i>^h2<QI]ApqK;`3`@"2bk=8*j=C!IJBur>=^)LGt+*f$Td$^\9S6f
8QT;j'pn7rU)G/:OXf0/X<rj9h[ml)CF$?>GSP*8FOd/ST's1S;NVkT#GFYdk]A_`*C3Xoq#t
B_G)Hl\>a/M(g%NC'9pahjMlFW2qs;RiI`6E]AM@iC;ju-jhi^/N`3ji14:i2Lpjj%A5()e;r
`n1M#Y0_/]AOk<r8BB.J7n;>""3#8@sK0a06>ec`8qJ1B>?8FXOC6O,J`Gn5bH3<(=t#:jirq
:EX`<BL_iQ&T'b!30M\N-G"(e,orVq+Au=9f>?g3WWQ1,@>Bo/q19s5$k.oP$n!G78e+$#$2
#Jq\!h=ui$N`@6r<`W$r5@l*[dBP<56P<:IAgB$]A-HOi+M#e-B+9;(8)lP<M?qf>C/?EYjot
Sq,=mY-.+mU%j0tNOKKHi($^Rq-SGp^Do\O(?Nqg-YN=/LFE>7kV;akg4&jsOjMkf.DPK.-[
L>ZN7\T?5tb2p3nhA1f(,K@6[O'C9u"ZeI8=EjQ?*,tq]A4Nd69RuUDiYS,i^s.la9hr:?g`H
:Grm&=sUk8#62DR1I"*(lojd5&'IdCC5EdPX^:rnq1.!hsOB(lS>I)oq!ip\e_e5)pBMZ0nn
`nj?$iqTG22*;Kj[kXuf)[Z='`N]AH-D9Sl!?arU;7`tqR88CS9:jIGO3A@0+&iNZo2WVnHc-
Du/^Ub!gT9;+[QUi%]AC8$nP?e%L<h4n4$b?iFGSK45+6W:Yb[(g]A"U&`Gg\&i.bheR=V]ABD]A
jaorc5R1<p.r&VWE+iOKZ/LXh-ph1,WV?f"28A3CR&I@!JE>VAOQs-+dN#L_7J1(jqtJ:q:>
Rao.hd;etfT!XeZ&4jOm'dKsNs!+'PGbPEeTH^3;b:$N62nmi6g(LGRMu=hP43DnoDWk![hY
8N9mPV*Bkj%&K]AHQaL!e3?hk+P()AKRqp5.J#/g35o0k&-Aa:R?>XK2n#n#\5*.-'A.?H=r:
]ArsMaa0$KhR3W66BVa3No8@q]A]A#i8WMQDC8f"]A["^V]A0g_hqI-T2-##32ccr)F'=W>A)H!Z[
XI.e2Y#3TliQub!7e$dVA@M0nC,8-WjrFiPEJ\MHS"C%.&"J)<\Fr`M$j[%2Eg>VBpFl@'Yp
Y$dbs%JS'ebI1eZAfMbBtjaOU8/0"J+8gW$=@eH"*<=#tAKp(Y%WConX!?!b`M*4\sdhQODe
F,e[gq3l<sPQeNT4Z?A.L/!S'0nRT+EcTn9k'o#nm.lX"e5c[Xm`XDoo#3]A-DXGBher<rK/k
WG>_;POmjJg22%n?@f"I::gH73LLaNknJ;b*hc3I),>'Fr$#f]A9[MJ,uRS;T7`:+,C8?9"=u
c+'`7&@+1n1$OW<`.DRPUZqNsiS>\CurkdPg1_YJY#9R2JW;;S"*<qV!CB6;H8<DkbH+3Yro
H&e;jaDiP`2:8MM-=qKV2H&JHWP@Hm/ase8_@)C5jO3?SeU$4G9Eke0]AKOFgKpM19fee50Ik
1Q0@`K([sl-3rJ(B,,OJ@tXQhnL6NNtQ"a6K4mf\u$.4K)FakYWH.<ouG?[K/1E!Y`E&,q\F
4ShgWbR=ZWSFn+l^pi'NOTD"aC[Yrta(&[5fe`ilUB4ZU!1QXBR_jFXJdn3g$^$Nre_i4)>Q
f=!*12;.(qL5H<ds6FCAR<oVCB:bfA%;["S)K^`\8LB$Vhr#p@A,OXsjFHmYE,0<4g?WfEjb
Djhk45Xf\DhjDs&b$k2PnAHI7=*He:;+;]AL(F'O#UTF+0jSkDo%7L(A.gC<eLnJ!S&kWQ"8"
H&&e%M]A:G?\j%*>_L;"=Ua5Lc9IU9Aa9<Ga>c$bJZ`s5H-^meM4CF=*_HaGX)u.]AC?on0Q81
pHj>[>7nOWn,It'2A^ok&f8k4:^l+4T"mihMrnIu^?p%0ZS%F:%G2`5sYB[mAGCe'5_nOSGB
)$u^T\H0#J,Qckmm1'h.Am9Es#d,?XFi1XO,DJ'l6mEi<M``/ChV]A<a^JV/LdhRgLJWIV,;<
A.;%hcF9:R>5Xo%7!n07O-]AjNnasU7:!2]A@6G&Ug1DtX,4\^&t;iKi*"`&!aE0cJV8[#&iZJ
j)1QTn-Gbk%;l2)1C=XM@n:DdZoA4)aM<j_)8>CsFN@NOpg3caj[bXl=nj]AK=:H7ed]Ar588-
-\`MTM.-q@BQ7&#c\ZclhJf:+$NcNetei]AW'*irj37U[7DCf=ac"f0[,eZ@%g'bCo03WU`Bq
W,O]AiL.ZqU#PE._Ka*KlIVZR*p5AN!!t-A8niC++'MJa(7o9Ab,8:8uEO9/?<apm%;,e6uDZ
.=c^Y*7pl%A^-1+7/u(I<On"VY&+lX?Qe+G^e$c6R'^YkCG^7nk_!j&rW2WtU<,^\F6FKuQ$
.@"_DV'M`*%Ie<Tk]AK'lR`H%k'c[jQQBj*C_Uul<EMU)S#\8`D5&22Pkq&=99:ma%>KCg,Q0
-q<Pi7<C#.N?7fdJdW6"".1E=i'^\,ZYSca>n)Z]A57/S]Ahqa2PEV^97N3S_25$E!^\&gCHHq
GNJjk?4$;MF<)drjETBO"/a^0P-bX3(@bU.lG,7W?j>cHT"j:d$7.f#+D`Ho&5('jW<7L*^?
$r_213<?!O8$Xn_.jUF*?,6`4sXr6gaW37`<dAsPR$QLkc7_V'u>**12i7J%Kdkgho!'7mTX
,J\EQ<LM5u]AkL,d1ns]AG4Tj+aY/<\N*uC>KAY+J33c#')8:`HnB/a;h(ZH9!H&%:h8H"@^U@
fbcN5t8rO.-F;MqC*b3dl(M(,tQW5:L!ahr:_m;h)4meORY`0?S9ue)Snt4N'f>B=VCHD2RE
u]AaPVDGV%]A/LLB,G2^?%H/l$W#&-5_#dR)5L+;aU]A3@&\?Fk:mHAn#F1"IklF;`\)^C!qE^`
%nD4Ge$=k&:ou:A:$!u)<#Q0G"C_j'TrC5:WL?+dV_*/g6>;r]ABOSr^+@JUj?^MW\g*Ttn(W
C\c.+8kTS#\/g%QTqiI-XS'868D..eQN?e2$8m3&Lp%(1>tIp5!\>8454;9!8AGesomSHmlA
LW$,@KeusXP\%"ACn2;72'7A]A1N$*:r032c*digf(F`MPR%HQn=.qh:ge[o,Dt/m"*l/bcj0
Kj(0Y%6?F%m-EOR'$dE\bP:C^Ho[kI@g$G#PX?oU2aco6Cs&]Ah)NfTh@,'d,A8dWMIAHQM%"
hq1n;s.)i'tpofnf2K*"\qB#a\O!`;)H0;%d2Clc.li'-Z.&$e)A9'LBdcSf!LB<%^G4(/u<
uVJ4U%h4#`-IFTg8/n3DKA8e7Nt>FiPHEMU5XKlDf?bfW[2e`F7W4U[qJh\_L0/L#Yp*P:J`
UWGsc\$cD3V[UCR.GN7?"oG*jLZ%mbDJA.@/$D^]AY^Jt_50<M(Dgls[S:&Rf"HbY3/hgmZ?;
7)Kc(W%JXqPleqM^>M;(n0,EP4<`"EO$IaZE?>?g`V-Vp*cZ)pF'W^E_/uF.:NR93;7e]As[<
I9Xs5b7`AEsh>VI'-eSN&uM+en_,_et.E-,pX;%N=B$!c>M)3Wp4PPL:Y"]A1.YnGd2aJ6\"d
Z@`JJ3h8Ki?bXOOA0KonXQLKQd@C?"8KSm`WosT3<jK?1/Du;G=4G*KVP-u81:^AT=6V-;G4
<9D_@2[,*;^F?;1nJYf5G[[oW6MQlS&9B."dCqN5>C)TY[QQ=?R(Ej5=EBDXC6YrKP0e)bK>
BE/@Gg*iC)Fa41,N!8^#7E/=UKi3)'<OhgJ?7T#@_4qfOh$rf[^cmdprTl5"Nr@5J>(Yl..i
Ua'VKS]AoWVTdrENe.@H2/fs=d]A0>Eh[@:0hn[Ktt(!-IpkFo0?dH=EcKeq6#%&pa-l+9C\/]A
gaF+?@OMB<jY6LlU*-/fn`QoC5u=O-%A]ABaP^R.4YLm8bS_r4F]AjfrrhQCqb*5,54qut`r?,
~
]]></IM>
<ElementCaseMobileAttrProvider horizontal="1" vertical="1" zoom="true" refresh="false" isUseHTML="false" isMobileCanvasSize="false" appearRefresh="false" allowFullScreen="false" allowDoubleClickOrZoom="true" functionalWhenUnactivated="false"/>
<MobileFormCollapsedStyle class="com.fr.form.ui.mobile.MobileFormCollapsedStyle">
<collapseButton showButton="true" color="-6710887" foldedHint="" unfoldedHint="" defaultState="0"/>
<collapsedWork value="false"/>
<lineAttr number="1"/>
</MobileFormCollapsedStyle>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="276"/>
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
<BoundsAttr x="0" y="40" width="375" height="276"/>
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
<WidgetName name="air_season"/>
<LabelName name="年份:"/>
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
<BoundsAttr x="64" y="6" width="380" height="36"/>
</Widget>
<Widget class="com.fr.form.ui.container.WAbsoluteLayout$BoundsWidget">
<InnerWidget class="com.fr.form.ui.Label">
<WidgetName name="Label航季"/>
<WidgetAttr description="">
<MobileBookMark useBookMark="false" bookMarkName="Label年份" frozen="false"/>
<PrivilegeControl/>
</WidgetAttr>
<widgetValue>
<O>
<![CDATA[航季]]></O>
</widgetValue>
<LabelAttr verticalcenter="true" textalign="0" autoline="true"/>
<FRFont name="微软雅黑" style="1" size="72" foreground="-15386770"/>
<border style="0" color="-723724"/>
</InnerWidget>
<BoundsAttr x="4" y="6" width="60" height="36"/>
</Widget>
<ShowBookmarks showBookmarks="false"/>
<Sorted sorted="false"/>
<MobileWidgetList>
<Widget widgetName="Label航季"/>
<Widget widgetName="air_season"/>
</MobileWidgetList>
<FrozenWidgets/>
<MobileBookMarkStyle class="com.fr.form.ui.mobile.impl.DefaultMobileBookMarkStyle"/>
<WidgetScalingAttr compState="0"/>
<DesignResolution absoluteResolutionScaleW="1920" absoluteResolutionScaleH="1080"/>
</InnerWidget>
<BoundsAttr x="0" y="0" width="375" height="40"/>
</Widget>
<ShowBookmarks showBookmarks="true"/>
<Sorted sorted="true"/>
<MobileWidgetList>
<Widget widgetName="absolute0"/>
<Widget widgetName="report1_c"/>
<Widget widgetName="report2_c"/>
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
<PreviewType PreviewType="0"/>
<MobileOnlyTemplateAttrMark class="com.fr.base.iofile.attr.MobileOnlyTemplateAttrMark"/>
<StrategyConfigsAttr class="com.fr.esd.core.strategy.persistence.StrategyConfigsAttr" pluginID="com.fr.plugin.esd" plugin-version="1.5.4">
<StrategyConfigs/>
</StrategyConfigsAttr>
<TemplateIdAttMark class="com.fr.base.iofile.attr.TemplateIdAttrMark">
<TemplateIdAttMark TemplateId="a16c93bb-948f-4b40-ae17-fde5679556b7"/>
</TemplateIdAttMark>
</Form>
