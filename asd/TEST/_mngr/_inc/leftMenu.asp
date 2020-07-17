
    
    <div class="left_menu" id="left_menu_lsit">
   <%
    Dim menuI,menuSubIdx,classTxt_sub
    
    
    
    Dim classTxt
    
    
    for menuI=0 to ubound(menuAr_Info)
        
				
				
        if menuIdx>=cint(split(menuAr_Info(menuI),"|")(1)) and  menuIdx<=cint(split(menuAr_Info(menuI),"|")(2)) then
            classTxt = " class='bigBmenu' "
        else
            classTxt = " class='noneBmenu' "
        end if
       
        response.write "<div style='height:18px;width:125px;'></div><span "&classTxt&" >"&split(menuAr_Info(menuI),"|")(0)&"</a></span><div style='height:5px;'></div>"
        
        for menuSubIdx=cint(split(menuAr_Info(menuI),"|")(1)) to  cint(split(menuAr_Info(menuI),"|")(2))
        
				
				    
            if menuIdx=menuSubIdx then
                classTxt_sub = " class='selectedMenu' "
        		else
                classTxt_sub = ""
        		end if
            
            response.write "<p "&classTxt_sub&" style='height:18px;text-align:right;padding-right:10px;cursor:pointer;font-size:12px;' onClick=""location.href='?menuIdx="&menuSubIdx&"'"">"&menuAr_Info_sub(menuSubIdx)&"</a></p>"
        
				next
        
        
        
        
    next
    %> 
   
    <br><br><br>
    <p onClick="location.href='/_mngr/login.html?loginMode=logout';"  style="text-align:center;cursor:pointer;">Log-out</a></p>
    
    <br><br><br>
    <p id='topBtn' style="display:none;text-align:center;cursor:pointer;" onclick="upscroll();" ><img src="/_mngr/_img/topBtn.gif" width="20" title="Top"  onclick="upscroll();" style="cursor:pointer;"></p>		 
    </div>	