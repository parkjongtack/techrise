<style type="text/css">
<!--
#SpecialCharacters { position:absolute;  width:422px;}
#RomanAlhabets { position:absolute; left:1px; top:50px; width:420px;}
#MathematicalSymbols{ position:absolute; left:1px; top:50px; width:420px;}
#Unit { position:absolute; left:1px; top:50px; width:420px;}
#Superscript { position:absolute; left:1px; top:50px; width:420px;}
#Subscript { position:absolute; left:1px; top:50px; width:420;}

-->
</style>





<script language="JavaScript" type="text/javascript">
<!--



function ShowHideLayer(nID, txtAreaObj, event) {
    //var layer = document.all;
    var lr_SpecialCharacters = document.getElementById('SpecialCharacters');
    var lr_RomanAlhabets = document.getElementById('RomanAlhabets');
    var lr_MathematicalSymbols = document.getElementById('MathematicalSymbols');
    var lr_Unit = document.getElementById('Unit');
    var lr_Superscript = document.getElementById('Superscript');
    var lr_Subscript = document.getElementById('Subscript');
    
    /* var y_cusorPoint = getPosition(event).y;
    var topLocation = y_cusorPoint; */
    
    
    var topLocation =event.pageY ? event.pageY : document.documentElement.scrollTop + event.clientY;
   
    
		
	  if (!txtAreaObj) {
        txtAreaObj = document.forms['absForm'].txtAreaName.value;
    } else {
        document.forms['absForm'].txtAreaName.value = txtAreaObj;

        lr_SpecialCharacters.style.top = (topLocation-430)+"px";
        
    }
    
    switch (nID){
        case 'All' : lr_SpecialCharacters.style.display = 'block'; 
                     lr_RomanAlhabets.style.display = 'block'; 
                     lr_MathematicalSymbols.style.display = 'none';
                     lr_Unit.style.display = 'none';
                     lr_Superscript.style.display = 'none';
                     lr_Subscript.style.display = 'none';
                     break;
        case 'R' :   lr_SpecialCharacters.style.display = 'block'; 
                     lr_RomanAlhabets.style.display = 'block'; 
                     lr_MathematicalSymbols.style.display = 'none';
                     lr_Unit.style.display = 'none';
                     lr_Superscript.style.display = 'none';
                     lr_Subscript.style.display = 'none';
                     break;
        case 'M' :   lr_SpecialCharacters.style.display = 'block'; 
                     lr_RomanAlhabets.style.display = 'none'; 
                     lr_MathematicalSymbols.style.display = 'block';
                     lr_Unit.style.display = 'none';
                     lr_Superscript.style.display = 'none';
                     lr_Subscript.style.display = 'none';
                     break;
        case 'U' :   lr_SpecialCharacters.style.display = 'block'; 
                     lr_RomanAlhabets.style.display = 'none'; 
                     lr_MathematicalSymbols.style.display = 'none';
                     lr_Unit.style.display = 'block';
                     lr_Superscript.style.display = 'none';
                     lr_Subscript.style.display = 'none';
                     break;
        case 'P' :   lr_SpecialCharacters.style.display = 'block'; 
                     lr_RomanAlhabets.style.display = 'none'; 
                     lr_MathematicalSymbols.style.display = 'none';
                     lr_Unit.style.display = 'none';
                     lr_Superscript.style.display = 'block';
                     lr_Subscript.style.display = 'none';
                     break;
        case 'B' :   lr_SpecialCharacters.style.display = 'block'; 
                     lr_RomanAlhabets.style.display = 'block'; 
                     lr_MathematicalSymbols.style.display = 'none';
                     lr_Unit.style.sisplay = 'none';
                     lr_Superscript.style.display = 'none';
                     lr_Subscript.style.display = 'block';
                     break;
        case 'Close' : lr_SpecialCharacters.style.display = 'none'; break;
        
        default : lr_SpecialCharacters.style.display = 'none'; break;
    }
}



/* function $(Element){
  return document.getElementById(Element);
 } */

 
function insertSpecialChar(prefix) {
  var form = document.forms['absForm'];
  var obj = eval('form.'+form.txtAreaName.value);
  
  if (document.getSelection)    ts = document.getSelection();
  else if (document.selection)  ts = document.selection.createRange().text;
  else if (window.getSelection) ts = window.getSelection();

  if (ts != ""){ //IE
   document.selection.createRange().text = prefix + ts ;
  }else {
   if (obj.selectionStart == obj.selectionEnd){
    if(/*@cc_on!@*/false){
     obj.focus();
     document.selection.createRange().duplicate().text = prefix + document.selection.createRange().duplicate().text ;
          document.selection.createRange().select();
    }else{
     var s1 = obj.value.substring(0, obj.selectionStart);
     var s2 = obj.value.substring(obj.selectionStart);
     obj.value = s1 + prefix  + s2;
    }
   }else{
     var s1 = obj.value.substring(0, obj.selectionStart);
     var s2 = obj.value.substring(obj.selectionStart, obj.selectionEnd);
     var s3 = obj.value.substring(obj.selectionEnd);
     obj.value = s1 + prefix + s2  + s3;
   }
  }
  obj.focus();
	CountCharters();
}



/* function saveCurrentPos (objTextArea) {
    if (objTextArea.createTextRange) 
    //objTextArea.currentPos = document.selection.createRange().duplicate();
    objTextArea.currentPos = document.body.createTextRange().duplicate();
    return true;
}


function insertSpecialChar (spChar) {
    var form = document.forms['absForm'];
    var objTextArea = eval('form.'+form.txtAreaName.value);
    if (objTextArea.createTextRange && objTextArea.currentPos) {
        alert("a")
        //var currentPos = objTextArea.currentPos;
        //currentPos.text = spChar;
    } else {
        alert("b")
        //objTextArea.value = objTextArea.value + spChar;
    }
} */

/* 
String.prototype.Trim = function() {  // <% ' Trim ���� %>
    return this.replace(/(^ *)|( *$)/g, "");
} */






function CountCharters(field) {
    var form = document.forms['absForm'];
    var field_O = form.objective.value.Trim(); if (field_O) { field_O = field_O + '\n';}  // <% ' �Է°��� ������ �⺻ enter Ű�� �߰�(Ű��Ʈ ���� ����) %>
    var field_M = form.methods.value.Trim(); if (field_M) { field_M = field_M + '\n';}
    var field_R = form.results.value.Trim(); if (field_R) { field_R = field_R + '\n';}
    var field_C = form.conclusions.value.Trim(); if (field_C) { field_C = field_C + '\n';}
    var strFieldAll = field_O + field_M + field_R+ field_C;
    var strLength = field_O.length + field_M.length + field_R.length + field_C.length;
    var tmpStrCount = form.tmpStrCount.value;
    var tmpInt = 0;
    
    for (var i=0; i<strLength; i++) {
        //if (strFieldAll.substring(i,i+1).indexOf(' ')!=-1) {
        if (strFieldAll.substring(i,i+1).indexOf(' ')!=-1 || strFieldAll.substring(i,i+1).indexOf('\n')!=-1) {
            tmpInt++;
            form.tmpStrCount.value = tmpInt;
        }
    }
    /* for (i=0; i<document.all.countView.length; i++) {
        document.all.countView[i].innerText = tmpInt;
    } */
    for (i=0; i<document.getElementsByName('countView').length; i++) {
        document.getElementsByName('countView')[i].innerHTML = tmpInt;
    }
    
    
    var newStrFieldAll;
    var newTmpStrCount = 0;
    if (tmpInt>eval('<%=absLimitWord%>')) {
        alert('Please enter <%=absLimitWord%> words limit.');
        //field.value = field.value.substring(0,field.value.lastIndexOf(' '));
        newStrFieldAll = form.objective.value + form.methods.value + form.results.value + form.conclusions.value;        
        /* for (j=0; j<field.value.length-1; j++) {
            //if (newStrFieldAll.substring(j,j+1).indexOf(' ')!=-1) {
            if (newStrFieldAll.substring(j,j+1).indexOf(' ')!=-1 || strFieldAll.substring(i,i+1).indexOf('\n')!=-1) {
                field.value = field.value.substring(0,field.value.lastIndexOf(' '));
                tmpInt--;
                form.tmpStrCount.value = tmpInt-1;
            }
            if (tmpInt<=eval('<%=absLimitWord%>')) {
                //for (k=0; k<document.all.countView.length; k++) {
                //   document.all.countView[k].innerText = tmpInt;
                //}
                for (k=0; k<document.getElementsByName('countView').length; k++) {
                    document.getElementsByName('countView')[k].innerText = tmpInt;
                }
                break;
            }
        } */
        
        return false;
    }
}





function getCountCharters() {
    var form = document.forms['absForm'];
    var field_O = form.objective.value.Trim(); if (field_O) { field_O = field_O + '\n';}  // <% ' �Է°��� ������ �⺻ enter Ű�� �߰�(Ű��Ʈ ���� ����) %>
    var field_M = form.methods.value.Trim(); if (field_M) { field_M = field_M + '\n';}
    var field_R = form.results.value.Trim(); if (field_R) { field_R = field_R + '\n';}
    var field_C = form.conclusions.value.Trim(); if (field_C) { field_C = field_C + '\n';}
    var strFieldAll = field_O + field_M + field_R+ field_C;
    var strLength = field_O.length + field_M.length + field_R.length + field_C.length;
    var tmpStrCount = form.tmpStrCount.value;
    var tmpInt = 0;
    
    for (var i=0; i<strLength; i++) {
        //if (strFieldAll.substring(i,i+1).indexOf(' ')!=-1) {
        if (strFieldAll.substring(i,i+1).indexOf(' ')!=-1 || strFieldAll.substring(i,i+1).indexOf('\n')!=-1) {
            tmpInt++;
            form.tmpStrCount.value = tmpInt;
        }
    }
    /* for (i=0; i<document.all.countView.length; i++) {
        document.all.countView[i].innerText = tmpInt;
    } */
    for (i=0; i<document.getElementsByName('countView').length; i++) {
        document.getElementsByName('countView')[i].innerText = tmpInt;
    }
    
    
    var newStrFieldAll;
    var newTmpStrCount = 0;
    if (tmpInt>eval('<%=absLimitWord%>')) {
        return false;
    } else {
        return true;
    }
}


//-->
</script>















<!-- Start. Special Characters -->
<div id="SpecialCharacters" style="display:none;">
  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
    <tr>
      <td bgcolor="#FFFFFF">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="24" align="center" >Special Characters</td>
                  <td width="20"  align="right">
                    <img src="/_images/close_btn1.gif" alt="close" width="17" height="16" border="0" style="cursor:pointer;" onClick="ShowHideLayer('Close','',event);">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td height="1" align="center"></td>
          </tr>
          <tr>
            <td>
              <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="102"><img src="/_images/s_characters_01.gif" width="100" height="20" border="0" id="Image1" style="cursor:pointer;" onClick="ShowHideLayer('R','',event);" onMouseOver="MM_swapImage('Image1','','/_images/s_characters_o_01.gif',1)" onMouseOut="MM_swapImgRestore()"></td>
                  <td width="132"><img src="/_images/s_characters_02.gif" width="130" height="20" border="0" id="Image2" style="cursor:pointer;" onClick="ShowHideLayer('M','',event);" onMouseOver="MM_swapImage('Image2','','/_images/s_characters_o_02.gif',1)" onMouseOut="MM_swapImgRestore()"></td>
                  <td width="50"><img src="/_images/s_characters_03.gif" width="48" height="20" border="0" id="Image3" style="cursor:pointer;" onClick="ShowHideLayer('U','',event);" onMouseOver="MM_swapImage('Image3','','/_images/s_characters_o_03.gif',1)" onMouseOut="MM_swapImgRestore()"></td>
                  <td width="73"><img src="/_images/s_characters_04.gif" width="71" height="20" border="0" id="Image4" style="cursor:pointer;" onClick="ShowHideLayer('P','',event);" onMouseOver="MM_swapImage('Image4','','/_images/s_characters_o_04.gif',1)" onMouseOut="MM_swapImgRestore()"></td>
                  <td style="padding-right:4px;"><img src="/_images/s_characters_05.gif" width="63" height="20" id="Image5" style="cursor:pointer;" onClick="ShowHideLayer('B','',event);" onMouseOver="MM_swapImage('Image5','','/_images/s_characters_o_05.gif',1)" onMouseOut="MM_swapImgRestore()"></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td height="130">
              <div id="RomanAlhabets">
                <table border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
                  <tr align="center" bgcolor="#F2F2F2">
                    <td width="26" height="24" onClick="insertSpecialChar('Α');" style="cursor:pointer;">Α</td>
                    <td width="25" onClick="insertSpecialChar('Β');" style="cursor:pointer;">Β</td>
                    <td width="25" onClick="insertSpecialChar('Γ');" style="cursor:pointer;">Γ</td>
                    <td width="25" onClick="insertSpecialChar('Δ');" style="cursor:pointer;">Δ</td>
                    <td width="25" onClick="insertSpecialChar('Ε');" style="cursor:pointer;">Ε</td>
                    <td width="25" onClick="insertSpecialChar('Ζ');" style="cursor:pointer;">Ζ</td>
                    <td width="25" onClick="insertSpecialChar('Η');" style="cursor:pointer;">Η</td>
                    <td width="25" onClick="insertSpecialChar('Θ');" style="cursor:pointer;">Θ</td>
                    <td width="25" onClick="insertSpecialChar('Κ');" style="cursor:pointer;">Κ</td>
                    <td width="25" onClick="insertSpecialChar('Λ');" style="cursor:pointer;">Λ</td>
                    <td width="25" onClick="insertSpecialChar('Μ');" style="cursor:pointer;">Μ</td>
                    <td width="25" onClick="insertSpecialChar('Ν');" style="cursor:pointer;">Ν</td>
                    <td width="25" onClick="insertSpecialChar('Ξ');" style="cursor:pointer;">Ξ</td>
                    <td width="25" onClick="insertSpecialChar('Ο');" style="cursor:pointer;">Ο</td>
                    <td width="26" onClick="insertSpecialChar('Π');" style="cursor:pointer;">Π</td>
                    <td width="26" onClick="insertSpecialChar('Ρ');" style="cursor:pointer;">Ρ</td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24" onClick="insertSpecialChar('Σ');" style="cursor:pointer;">Σ</td>
                    <td onClick="insertSpecialChar('Τ');" style="cursor:pointer;">Τ</td>
                    <td onClick="insertSpecialChar('Υ');" style="cursor:pointer;">Υ</td>
                    <td onClick="insertSpecialChar('Φ');" style="cursor:pointer;">Φ</td>
                    <td onClick="insertSpecialChar('Χ');" style="cursor:pointer;">Χ</td>
                    <td onClick="insertSpecialChar('Ψ');" style="cursor:pointer;">Ψ</td>
                    <td onClick="insertSpecialChar('Ω');" style="cursor:pointer;">Ω</td>
                    <td onClick="insertSpecialChar('α');" style="cursor:pointer;">α</td>
                    <td onClick="insertSpecialChar('β');" style="cursor:pointer;">β</td>
                    <td onClick="insertSpecialChar('γ');" style="cursor:pointer;">γ</td>
                    <td onClick="insertSpecialChar('δ');" style="cursor:pointer;">δ</td>
                    <td onClick="insertSpecialChar('ε');" style="cursor:pointer;">ε</td>
                    <td onClick="insertSpecialChar('ζ');" style="cursor:pointer;">ζ</td>
                    <td onClick="insertSpecialChar('η');" style="cursor:pointer;">η</td>
                    <td onClick="insertSpecialChar('θ');" style="cursor:pointer;">θ</td>
                    <td onClick="insertSpecialChar('ι');" style="cursor:pointer;">ι</td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24" onClick="insertSpecialChar('κ');" style="cursor:pointer;">κ</td>
                    <td onClick="insertSpecialChar('λ');" style="cursor:pointer;">λ</td>
                    <td onClick="insertSpecialChar('μ');" style="cursor:pointer;">μ</td>
                    <td onClick="insertSpecialChar('ν');" style="cursor:pointer;">ν</td>
                    <td onClick="insertSpecialChar('ξ');" style="cursor:pointer;">ξ</td>
                    <td onClick="insertSpecialChar('ο');" style="cursor:pointer;">ο</td>
                    <td onClick="insertSpecialChar('π');" style="cursor:pointer;">π</td>
                    <td onClick="insertSpecialChar('ρ');" style="cursor:pointer;">ρ</td>
                    <td onClick="insertSpecialChar('σ');" style="cursor:pointer;">σ</td>
                    <td onClick="insertSpecialChar('τ');" style="cursor:pointer;">τ</td>
                    <td onClick="insertSpecialChar('υ');" style="cursor:pointer;">υ</td>
                    <td onClick="insertSpecialChar('φ');" style="cursor:pointer;">φ</td>
                    <td onClick="insertSpecialChar('χ');" style="cursor:pointer;">χ</td>
                    <td onClick="insertSpecialChar('ψ');" style="cursor:pointer;">ψ</td>
                    <td onClick="insertSpecialChar('ω');" style="cursor:pointer;">ω</td>
                    <td></td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24"></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24"></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                  </tr>
                </table>
              </div>
              <div id="MathematicalSymbols">
                <table border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
                  <tr align="center" bgcolor="#F2F2F2">
                    <td width="26" height="24" onClick="insertSpecialChar('。');" style="cursor:pointer;">。</td>
                    <td width="25" onClick="insertSpecialChar('〈');" style="cursor:pointer;">〈</td>
                    <td width="25" onClick="insertSpecialChar('〉');" style="cursor:pointer;">〉</td>
                    <td width="25" onClick="insertSpecialChar('《');" style="cursor:pointer;">《</td>
                    <td width="25" onClick="insertSpecialChar('》');" style="cursor:pointer;">》</td>
                    <td width="25" onClick="insertSpecialChar('±');" style="cursor:pointer;">±</td>
                    <td width="25" onClick="insertSpecialChar('×');" style="cursor:pointer;">×</td>
                    <td width="25" onClick="insertSpecialChar('÷');" style="cursor:pointer;">÷</td>
                    <td width="25" onClick="insertSpecialChar('≠');" style="cursor:pointer;">≠</td>
                    <td width="25" onClick="insertSpecialChar('≤');" style="cursor:pointer;">≤</td>
                    <td width="25" onClick="insertSpecialChar('≥');" style="cursor:pointer;">≥</td>
                    <td width="25" onClick="insertSpecialChar('∞');" style="cursor:pointer;">∞</td>
                    <td width="25" onClick="insertSpecialChar('℃');" style="cursor:pointer;">℃</td>
                    <td width="25" onClick="insertSpecialChar('Å');" style="cursor:pointer;">Å</td>
                    <td width="25" onClick="insertSpecialChar('≒');" style="cursor:pointer;">≒</td>
                    <td width="25" onClick="insertSpecialChar('∑');" style="cursor:pointer;">∑</td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24"></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24"></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24"></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24"></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                  </tr>
                </table>
              </div>
              <div id="Unit">
                <table border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
                  <tr align="center" bgcolor="#F2F2F2">
                    <td width="26" height="24" onClick="insertSpecialChar('＄');" style="cursor:pointer;">＄</td>
                    <td width="25" onClick="insertSpecialChar('％');" style="cursor:pointer;">％</td>
                    <td width="25" onClick="insertSpecialChar('￦');" style="cursor:pointer;">￦</td>
                    <td width="25" onClick="insertSpecialChar('Ｆ');" style="cursor:pointer;">Ｆ</td>
                    <td width="25" onClick="insertSpecialChar('′');" style="cursor:pointer;">′</td>
                    <td width="25" onClick="insertSpecialChar('″');" style="cursor:pointer;">″</td>
                    <td width="25" onClick="insertSpecialChar('℃');" style="cursor:pointer;">℃</td>
                    <td width="25" onClick="insertSpecialChar('Å');" style="cursor:pointer;">Å</td>
                    <td width="25" onClick="insertSpecialChar('￠');" style="cursor:pointer;">￠</td>
                    <td width="25" onClick="insertSpecialChar('￡');" style="cursor:pointer;">￡</td>
                    <td width="25" onClick="insertSpecialChar('￥');" style="cursor:pointer;">￥</td>
                    <td width="25" onClick="insertSpecialChar('¤');" style="cursor:pointer;">¤</td>
                    <td width="25" onClick="insertSpecialChar('℉');" style="cursor:pointer;">℉</td>
                    <td width="25" onClick="insertSpecialChar('‰');" style="cursor:pointer;">‰</td>
                    <td width="26" onClick="insertSpecialChar('€');" style="cursor:pointer;">€</td>
                    <td width="26" onClick="insertSpecialChar('㎕');" style="cursor:pointer;">㎕</td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td onClick="insertSpecialChar('㎖');" style="cursor:pointer;" height="24">㎖</td>
                    <td onClick="insertSpecialChar('㎗');" style="cursor:pointer;">㎗</td>
                    <td onClick="insertSpecialChar('ℓ');" style="cursor:pointer;">ℓ</td>
                    <td onClick="insertSpecialChar('㎘');" style="cursor:pointer;">㎘</td>
                    <td onClick="insertSpecialChar('㏄');" style="cursor:pointer;">㏄</td>
                    <td onClick="insertSpecialChar('㎣');" style="cursor:pointer;">㎣</td>
                    <td onClick="insertSpecialChar('㎤');" style="cursor:pointer;">㎤</td>
                    <td onClick="insertSpecialChar('㎥');" style="cursor:pointer;">㎥</td>
                    <td onClick="insertSpecialChar('㎦');" style="cursor:pointer;">㎦</td>
                    <td onClick="insertSpecialChar('㎙');" style="cursor:pointer;">㎙</td>
                    <td onClick="insertSpecialChar('㎚');" style="cursor:pointer;">㎚</td>
                    <td onClick="insertSpecialChar('㎛');" style="cursor:pointer;">㎛</td>
                    <td onClick="insertSpecialChar('㎜');" style="cursor:pointer;">㎜</td>
                    <td onClick="insertSpecialChar('㎝');" style="cursor:pointer;">㎝</td>
                    <td onClick="insertSpecialChar('㎞');" style="cursor:pointer;">㎞</td>
                    <td onClick="insertSpecialChar('㎟');" style="cursor:pointer;">㎟</td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24" onClick="insertSpecialChar('㎠');" style="cursor:pointer;">㎠</td>
                    <td onClick="insertSpecialChar('㎡');" style="cursor:pointer;">㎡</td>
                    <td onClick="insertSpecialChar('㎢');" style="cursor:pointer;">㎢</td>
                    <td onClick="insertSpecialChar('㏊');" style="cursor:pointer;">㏊</td>
                    <td onClick="insertSpecialChar('㎍');" style="cursor:pointer;">㎍</td>
                    <td onClick="insertSpecialChar('㎎');" style="cursor:pointer;">㎎</td>
                    <td onClick="insertSpecialChar('㎏');" style="cursor:pointer;">㎏</td>
                    <td onClick="insertSpecialChar('㏏');" style="cursor:pointer;">㏏</td>
                    <td onClick="insertSpecialChar('㎈');" style="cursor:pointer;">㎈</td>
                    <td onClick="insertSpecialChar('㎉');" style="cursor:pointer;">㎉</td>
                    <td onClick="insertSpecialChar('㏈');" style="cursor:pointer;">㏈</td>
                    <td onClick="insertSpecialChar('㎧');" style="cursor:pointer;">㎧</td>
                    <td onClick="insertSpecialChar('㎨');" style="cursor:pointer;">㎨</td>
                    <td onClick="insertSpecialChar('㎰');" style="cursor:pointer;">㎰</td>
                    <td onClick="insertSpecialChar('㎱');" style="cursor:pointer;">㎱</td>
                    <td onClick="insertSpecialChar('㎲');" style="cursor:pointer;">㎲</td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td onClick="insertSpecialChar('㎳');" style="cursor:pointer;" height="24">㎳</td>
                    <td onClick="insertSpecialChar('㎴');" style="cursor:pointer;">㎴</td>
                    <td onClick="insertSpecialChar('㎵');" style="cursor:pointer;">㎵</td>
                    <td onClick="insertSpecialChar('㎶');" style="cursor:pointer;">㎶</td>
                    <td onClick="insertSpecialChar('㎷');" style="cursor:pointer;">㎷</td>
                    <td onClick="insertSpecialChar('㎸');" style="cursor:pointer;">㎸</td>
                    <td onClick="insertSpecialChar('㎹');" style="cursor:pointer;">㎹</td>
                    <td onClick="insertSpecialChar('㎀');" style="cursor:pointer;">㎀</td>
                    <td onClick="insertSpecialChar('㎁');" style="cursor:pointer;">㎁</td>
                    <td onClick="insertSpecialChar('㎂');" style="cursor:pointer;">㎂</td>
                    <td onClick="insertSpecialChar('㎃');" style="cursor:pointer;">㎃</td>
                    <td onClick="insertSpecialChar('㎄');" style="cursor:pointer;">㎄</td>
                    <td onClick="insertSpecialChar('㎺');" style="cursor:pointer;">㎺</td>
                    <td onClick="insertSpecialChar('㎻');" style="cursor:pointer;">㎻</td>
                    <td onClick="insertSpecialChar('㎼');" style="cursor:pointer;">㎼</td>
                    <td onClick="insertSpecialChar('㎽');" style="cursor:pointer;">㎽</td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td onClick="insertSpecialChar('㎾');" style="cursor:pointer;" height="24">㎾</td>
                    <td onClick="insertSpecialChar('㎿');" style="cursor:pointer;">㎿</td>
                    <td onClick="insertSpecialChar('㎐');" style="cursor:pointer;">㎐</td>
                    <td onClick="insertSpecialChar('㎑');" style="cursor:pointer;">㎑</td>
                    <td onClick="insertSpecialChar('㎒');" style="cursor:pointer;">㎒</td>
                    <td onClick="insertSpecialChar('㎓');" style="cursor:pointer;">㎓</td>
                    <td onClick="insertSpecialChar('㎔');" style="cursor:pointer;">㎔</td>
                    <td onClick="insertSpecialChar('Ω');" style="cursor:pointer;">Ω</td>
                    <td onClick="insertSpecialChar('㏀');" style="cursor:pointer;">㏀</td>
                    <td onClick="insertSpecialChar('㏁');" style="cursor:pointer;">㏁</td>
                    <td onClick="insertSpecialChar('㎊');" style="cursor:pointer;">㎊</td>
                    <td onClick="insertSpecialChar('㎋');" style="cursor:pointer;">㎋</td>
                    <td onClick="insertSpecialChar('㎌');" style="cursor:pointer;">㎌</td>
                    <td onClick="insertSpecialChar('㏖');" style="cursor:pointer;">㏖</td>
                    <td></td>
                    <td></td>
                  </tr>
                </table>
              </div>
              <div id="Superscript">
                <table border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
                  <tr align="center" bgcolor="#F2F2F2">
                    <td width="26" height="24" onClick="insertSpecialChar('<sup>-10</sup>');" style="cursor:pointer;"><sup>-10</sup></td>
                    <td width="26" onClick="insertSpecialChar('<sup>-9</sup>');" style="cursor:pointer;"><sup>-9</sup></td>
                    <td width="26" onClick="insertSpecialChar('<sup>-8</sup>');" style="cursor:pointer;"><sup>-8</sup></td>
                    <td width="26" onClick="insertSpecialChar('<sup>-7</sup>');" style="cursor:pointer;"><sup>-7</sup></td>
                    <td width="26" onClick="insertSpecialChar('<sup>-6</sup>');" style="cursor:pointer;"><sup>-6</sup></td>
                    <td width="26" onClick="insertSpecialChar('<sup>-5</sup>');" style="cursor:pointer;"><sup>-5</sup></td>
                    <td width="26" onClick="insertSpecialChar('<sup>-4</sup>');" style="cursor:pointer;"><sup>-4</sup></td>
                    <td width="26" onClick="insertSpecialChar('<sup>-3</sup>');" style="cursor:pointer;"><sup>-3</sup></td>
                    <td width="26" onClick="insertSpecialChar('<sup>-2</sup>');" style="cursor:pointer;"><sup>-2</sup></td>
                    <td width="26" onClick="insertSpecialChar('<sup>-1</sup>');" style="cursor:pointer;"><sup>-1</sup></td>
                    <td width="26" onClick="insertSpecialChar('<sup>1</sup>');" style="cursor:pointer;"><sup>1</sup></td>
                    <td width="26" onClick="insertSpecialChar('<sup>2</sup>');" style="cursor:pointer;"><sup>2</sup></td>
                    <td width="26" onClick="insertSpecialChar('<sup>3</sup>');" style="cursor:pointer;"><sup>3</sup></td>
                    <td width="26" onClick="insertSpecialChar('<sup>4</sup>');" style="cursor:pointer;"><sup>4</sup></td>
                    <td width="26" onClick="insertSpecialChar('<sup>5</sup>');" style="cursor:pointer;"><sup>5</sup></td>
                    <td width="28" onClick="insertSpecialChar('<sup>6</sup>');" style="cursor:pointer;"><sup>6</sup></td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24" onClick="insertSpecialChar('<sup>7</sup>');" style="cursor:pointer;"><sup>7</sup></td>
                    <td onClick="insertSpecialChar('<sup>8</sup>');" style="cursor:pointer;"><sup>8</sup></td>
                    <td onClick="insertSpecialChar('<sup>9</sup>');" style="cursor:pointer;"><sup>9</sup></td>
                    <td onClick="insertSpecialChar('<sup>10</sup>');" style="cursor:pointer;"><sup>10</sup></td>
                    <td onClick="insertSpecialChar('<sup>+</sup>');" style="cursor:pointer;"><sup>+</sup></td>
                    <td onClick="insertSpecialChar('<sup>-</sup>');" style="cursor:pointer;"><sup>-</sup></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24"></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24"></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24"></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                  </tr>
                </table>
              </div>
              
              <div id="Subscript">
                <table border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
                  <tr align="center" bgcolor="#F2F2F2">
                    <td width="26" height="24" onClick="insertSpecialChar('<sub>1</sub>');" style="cursor:pointer;"><sub>1</sub></td>
                    <td width="25" onClick="insertSpecialChar('<sub>2</sub>');" style="cursor:pointer;"><sub>2</sub></td>
                    <td width="25" onClick="insertSpecialChar('<sub>3</sub>');" style="cursor:pointer;"><sub>3</sub></td>
                    <td width="25" onClick="insertSpecialChar('<sub>4</sub>');" style="cursor:pointer;"><sub>4</sub></td>
                    <td width="25" onClick="insertSpecialChar('<sub>5</sub>');" style="cursor:pointer;"><sub>5</sub></td>
                    <td width="25" onClick="insertSpecialChar('<sub>6</sub>');" style="cursor:pointer;"><sub>6</sub></td>
                    <td width="25" onClick="insertSpecialChar('<sub>7</sub>');" style="cursor:pointer;"><sub>7</sub></td>
                    <td width="25" onClick="insertSpecialChar('<sub>8</sub>');" style="cursor:pointer;"><sub>8</sub></td>
                    <td width="25" onClick="insertSpecialChar('<sub>9</sub>');" style="cursor:pointer;"><sub>9</sub></td>
                    <td width="25" onClick="insertSpecialChar('<sub>10</sub>');" style="cursor:pointer;"><sub>10</sub></td>
                    <td width="25"></td>
                    <td width="25"></td>
                    <td width="25"></td>
                    <td width="25"></td>
                    <td width="26"></td>
                    <td width="26"></td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24"></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24"></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24"></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                  </tr>
                  <tr align="center" bgcolor="#F2F2F2">
                    <td height="24"></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                    <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                  </tr>
                </table>
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!-- End. Special Characters -->