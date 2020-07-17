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

function ShowDiv(obj){

	$('#'+obj).fadeIn('fast');
}


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

        lr_SpecialCharacters.style.top = (topLocation-350)+"px";
        
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
}






function CountCharters(field) {
    var form = document.forms['absForm'];
    var field_O = form.objective.value.Trim(); if (field_O) { field_O = field_O + '\n';}  // <% ' 입력값이 있으면 기본 enter 키값 추가(키운트 증가 위함) %>
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
    var field_O = form.objective.value.Trim(); if (field_O) { field_O = field_O + '\n';}  // <% ' 입력값이 있으면 기본 enter 키값 추가(키운트 증가 위함) %>
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




