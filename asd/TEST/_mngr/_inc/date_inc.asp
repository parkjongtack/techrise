<%

Dim sDate,eDate,m,nowDate,eDateQry,dateDiffCnt,dateArTxt,plusDate,monthArTxt,dateArTxt_sp,monthArTxt_sp
    sDate=request("sDate")
    eDate=request("eDate")
    m = request("m")
    nowDate = now() 
    if not isDate(eDate) then eDate=year(nowDate)&"-"&month(nowDate)&"-"&day(nowDate)
    if datediff("d",eDate,nowDate)<0  then  eDate = year(nowDate)&"-"&month(nowDate)&"-"&day(nowDate) ' 오늘 이후이면
    
    
    if not isEmptyStr(m) then
        if isNumeric(m) then
            sDate=dateAdd("m",(m*-1),eDate)
        else
            sDate=dateAdd("d",-14,eDate)
        end if
         
    end if
    
    if not isDate(sDate) then sDate=dateAdd("d",-14,eDate) 
    eDateQry = dateAdd("d",1,eDate)
    dateDiffCnt = dateDiff("d",sDate,eDate)
    
    for i=0 to dateDiffCnt
        if i=0 then
            dateArTxt=sDate
            monthArTxt = left(sDate,7)
        else
            plusDate = dateAdd("d",i,sDate)
            dateArTxt=dateArTxt&"|"&plusDate
            if instr(monthArTxt,left(plusDate,7))=0 then
                monthArTxt=monthArTxt&"|"&left(plusDate,7)
            end if
        end if    
    next
    
    
    dateArTxt_sp = split(dateArTxt,"|")
    monthArTxt_sp = split(monthArTxt,"|")


Dim sDate_01,eDateQry_01
    sDate_01     = clng(replace(sDate,"-",""))
    eDateQry_01  = clng(replace(eDateQry,"-",""))    
%>