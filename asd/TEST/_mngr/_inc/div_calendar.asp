<% @LANGUAGE='VBSCRIPT' CODEPAGE='65001' %>
<% Option Explicit %>
<%Response.CharSet = "utf-8"%>
<!-- #include virtual="/_mngr/_inc/headNoCache.asp" -->
<!-- #include virtual="/_mngr/_inc/func.asp" -->
<!-- #include virtual="/_mngr/_inc/base64.asp" -->
<!-- #include virtual="/_mngr/_inc/ad_config_inc.asp" -->
<%
' ##############################################################################
' �޷�
' �ʷ�, ���, ����, ���� ��¥ �Է�
' �ۼ��� : 2007. 11. 16
' ##############################################################################
Dim reField : reField = request("reField") ' ��ȯ�Ǿ��� �ʵ��
Dim chkType : chkType = request("chkType") ' �޷��� ���� ���а�(������������, ����, ���� ��)
Dim cate    : cate = request("cate")

' ��� -------------------------------------------------------------------------
Dim LNG : LNG = Ucase(Trim(request("LNG")))
if isEmptyStr(LNG) then
	  LNG = "EN"
end if
' ------------------------------------------------------------------------------


' ------------------------------------------------------------------------------
Const LimitDateStart = "2015-10-24"  ' ���డ�� ������
Const LimitDateEnd	 = "2015-11-01"  ' ���డ�� ������

Dim calMode ' ������ �� �ִ� ��¥�� �������� ����
calMode = Lcase(Trim(request("calMode")))  ' LIMIT
' ------------------------------------------------------------------------------


' ------------------------------------------------------------------------------
Dim getDate
getDate = request("movedate")
' ��ȯ�Ǵ� ��¥�� ��ȿ���� ������� ���ó�¥�� ����
if isEmptyStr(getDate) then 
    getDate="2015-01-01"
end if
    
if not isDate(getDate) then
    if calMode="limit" and isDate(LimitDateStart) then
			  getDate = Left(LimitDateStart,8) & Day(now)  ' ���� ��¥ �ڽ� ���� ǥ��
				if not isDate(getDate) then
            getDate = LimitDateStart
        end if
		else
				getDate = Date
		end if
end if
' ------------------------------------------------------------------------------
'if isTestAdmin() then
'    echobr getDate
'    'response.end
'end if

Dim DD,MM,YY
DD = Day(getDate)
MM = Month(getDate)
YY = Year(getDate)

Dim startMonthDay   ' �ش���� ù ��¥�� ����
startMonthDay = YY & "-" & MM & "-01"

Dim endMonthDate, endMonthDay   ' �ش���� ������ ��¥�� ����
endMonthDate = dateAdd("d",-1,dateAdd("m",1, startMonthDay)) 
endMonthDay  = day(endMonthDate)

Dim startWeekDay   ' �ش���� ù ���ۿ����� ����
startWeekDay = weekDay(startMonthDay)

Dim nextStartWeek  ' �������� ù ���ۿ����� ����
nextStartWeek = weekDay(Dateadd("d",1,endMonthDate))

Dim prevMonthDay, nextMonthDay
prevMonthDay = dateAdd("m",-1,getDate)  ' ������
nextMonthDay = dateAdd("m",1,getDate)   ' ������
%>

<div id="calendar">
  <ul>
    <li style="text-align:right;padding:5px; 5px 0px 5px"><span onclick="PopupCalendarClose();" style="cursor:pointer;">X</span></li>
  </ul>
	<ul>
    <li class="c_prev"><a href="javascript:PopupCalendar_01('<%=calMode%>','<%=reField%>','<%=prevMonthDay%>');"><img align="absmiddle" src="/_images/btn_prevc.gif" width="7" height="7" border="0"/></a>&nbsp;<span onclick="PopupCalendar_01('<%=calMode%>','<%=reField%>','<%=prevMonthDay%>');" style="cursor:pointer;">prev</span> </li>
    <li class="c_date"><ul><li><%=MM%><span class="txt_2015"><%=YY%></span></li></ul></li>
    <li class="c_next"><span onClick="PopupCalendar_01('<%=calMode%>','<%=reField%>','<%=nextMonthDay%>');" style="cursor:pointer;">next</a>&nbsp;<a href="javascript:PopupCalendar_01('<%=calMode%>','<%=reField%>','<%=nextMonthDay%>');" ><img align="absmiddle" src="/_images/btn_nextc.gif" width="7" height="7" border="0"/></a></li>
  </ul>
  <ul id="c_date2">
  	<li class="d_bg">
		  <ul>
  		  <li><font color="red"><% if LNG="KR" then %>일<% else %>S<font style="font-size:8pt;">u</font><% end if %></font></li>
        <li><% if LNG="KR" then %>월<% else %>M<font style="font-size:8pt;">o</font><% end if %></li>
        <li><% if LNG="KR" then %>화<% else %>T<font style="font-size:8pt;">u</font><% end if %></li>
        <li><% if LNG="KR" then %>수<% else %>W<font style="font-size:8pt;">e</font><% end if %></li>
        <li><% if LNG="KR" then %>목<% else %>T<font style="font-size:8pt;">h</font><% end if %></li>
        <li><% if LNG="KR" then %>금<% else %>F<font style="font-size:8pt;">r</font><% end if %></li>
        <li><font color="blue"><% if LNG="KR" then %>토<% else %>S<font style="font-size:8pt;">a</font><% end if %></font></li>
			</ul>
      
      
 <%
        response.write "<ul>"
        
        ' ���� �� ���� ä�� ----------------------------------------------------
        for i=1 to startWeekDay-1
            response.write "<li>&nbsp;</li>"
        next
        ' ----------------------------------------------------------------------
        
        
        ' ��¥ ��� ------------------------------------------------------------
        Dim tdColor, dayColor, onTdColor, dayStyle, onOffMouse
        for i=1 to endMonthDay
            if (i+startWeekDay-1) mod 7 = 0 then  ' �����
                tdColor   = "#FFFFFF"
                dayColor  = "#0033FF"
                onTdColor = "#ECF7FF"
            elseif (i+startWeekDay-1) mod 7 = 1 then   ' �Ͽ���
                tdColor   = "#FFFFFF"
                dayColor  = "#ff0033"
                onTdColor = "#FFE6FD"
            else
                tdColor   = "#FFFFFF"
                dayColor  = "#333333"
                onTdColor = "#EFEFEF"
            end if
            
            if i=DD then  ' �������� �ΰ�� TD �� ����
                if (i+startWeekDay-1) mod 7 = 0 then  ' �����
                    'tdColor   = "#ECF7FF"
										tdColor = "#FFFFFF"
                elseif (i+startWeekDay-1) mod 7 = 1 then   ' �Ͽ���
                    'tdColor   = "#FFE6FD"
										tdColor = "#FFFFFF"
                else
                    'tdColor   = "#EFEFEF"
										tdColor   = "#FFFFFF"
                    dayColor  = "#333333"
                    onTdColor = "#EFEFEF"
                end if
            end if
            		
            dayStyle   = "font-family:Arial,Gulim,Dotum,sans-serif; font-size: 9pt; color:000000; text-decoration: none; line-height: 1.6;background-color:"&tdColor&"; color:"&dayColor&";"
            onOffMouse = "font-family:Arial,Gulim,Dotum,sans-serif; font-size: 9pt; color:000000; text-decoration: none; line-height: 1.6;onMouseOver=""this.style.backgroundColor='"&onTdColor&"'"" onMouseOut=""this.style.backgroundColor='"&tdColor&"'"""
            
						if calMode="limit" then ' ��¥ ���� ���� ���
    						Dim newDate
    						newDate = CDate(YY&"-"&calc(MM,2)&"-"&calc(i,2))
    
    						if Datediff("D",LimitDateStart,newDate)>=0 and Datediff("D",LimitDateEnd,newDate)<=0 then
                	  response.write "<li style="""&dayStyle&"; cursor:pointer;"" "&onOffMouse&" align=""center"" onClick=""inDate('"&calc(i,2)&"','"&calc(MM,2)&"','"&YY&"','"&reField&"','"&cate&"');"">"&i&"</li>"
                else
    								response.write "<li style="""&dayStyle&"; color:#999999; background-image: url(/images/x-line.gif); background-repeat: no-repeat; background-position: center center;"" "&onOffMouse&" align=""center"">"&i&"</li>"
    						end if
						else
								response.write "<li style="""&dayStyle&"; cursor:pointer;"" "&onOffMouse&" align=""center"" onClick=""inDate('"&calc(i,2)&"','"&calc(MM,2)&"','"&YY&"','"&reField&"','"&cate&"');"">"&i&"</li>"
						end if
						
						if (i+startWeekDay-1) mod 7 = 0 and endMonthDay>i then
                response.write "</ul><ul>"
            end if
        next
        ' ----------------------------------------------------------------------
        
        
        ' ������ �� ���� ä�� --------------------------------------------------
        if nextStartWeek>1 then
            for i=0 to 7-nextStartWeek
                response.write "<li bgcolor=""#FFFFFF"">&nbsp;</li>"
            next
        end if
        ' ----------------------------------------------------------------------
        
        response.write "</ul>"
%>            
      
						 
     </li>
	</ul>
	<ul>
    <li>&nbsp;</li>
  </ul>
	
</div>
      