<!--
/* <% ' 대문자 변환 ex) toUpperCase(문자) %> */
function toUpperCase(str) {
    var ret;
    str != null ? ret = str.toUpperCase() : ret = "";
    /* if (str) {
        ret = str.toUpperCase();
    } else {
        ret = '';
    } */
    return ret;
}

/* <% ' 소문자 변환 ex) toLowerCase(문자) %> */
function toLowerCase(str) {
    var ret;
    str != null ? ret = str.toLowerCase() : ret = "";
    /* if (str.length>0) {
        ret = str.toLowerCase();
    } else {
        ret = str.toLowerCase();
    } */
    return ret;
}

/* <% ' 첫문자를 대문자로 %> */
function toUCaseStart(str) {
    var newStr = '';
    if (str.length>0) {
        newStr = toUpperCase(str.substring(0,1)) + str.substring(1, str.length);
    }
    return (newStr);
}


/* 첫문자를 대문자로 - 2009. 2. 13 */
function toUCaseStartChar(f) {
    var newStr = toUCaseStart(trim(f.value));
    f.value = newStr;
    return;
}




/* <% ' 이름 대/소문자 교체 %> */
function toNameChar(f) {
    var newStr = toLowerCase(trim(f.value));
    newStr = toUCaseStart(newStr);
    f.value = newStr;
    return;
}

/* Auto Completed Middle initial - 2009. 2. 13 */
function toMiddleInitial(f) {
    var newStr = toLowerCase(trim(f.value));
    newStr = toUCaseStart(newStr.substr(0,1));
    var allowStart = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var tmpIdx = 0;
    
    for (var i=0; i<allowStart.length; i++) {
        if (allowStart.substr(i,1)==newStr) {
            tmpIdx++;
        }
    }
    if (tmpIdx>0) {
        f.value = newStr + '.';
    } else {
        f.value = '';
    }

    return;
}





/* title */
function toTitleChar(f) {
    var str = trim(f.value);
    var newStr;
    var strRight = str.substring(str.length-1,str.length);
    if (strRight!='.') {
        newStr = str + '.';
    } else {
        newStr = str;
    }
    if (str.length>0) {
        f.value = newStr;
    }
}


/* <% ' 한글 검사 %> */
function isKorChar(f) {
    var str = f.value;  
    for (var i=0; i<str.length; i++){
        var g = str.charCodeAt(i);
        if ( !( ( 0xAC00 <= g && g <= 0xD7A3 ) || ( 0x3131 <= g && g <= 0x318E ) )){
            return false;
            break;
        }
    }
    return true;
}

function hangul() {
    if(((event.keyCode < 12592) || (event.keyCode > 12687)) && (event.keyCode!=32) &&((event.keyCode<48) || (event.keyCode>57)))
    //alert(event.keyCode);
    event.returnValue = false
}


/* Explorer */
function isIE() {
    if (navigator.userAgent.indexOf("MSIE") != -1) {
        return true; 
    } else {
        return false;
    }
}
/* trim */
String.prototype.Trim = function() {  // <% ' Trim 정의 %>
    return this.replace(/(^ *)|( *$)/g, "");
}


// -----------------------------------------------------------------------------
/* rTrim */
function lTrim(str) {
    var i;
    for (i=0; i<str.length; i++) {
        if (str.charAt(i) != ' ') { 
            break; 
        }
    }
    return str.substr(i, str.length-i+1);
}

/* lTrim */
function rTrim(str) {
    var i;
    for (i=str.length-1; i>=0; i--)
    if (str.charAt(i) != ' ') {
        break;
    }
    return str.substr(0, i+1);
}

/* trim */
function trim(str) {
    str = lTrim(str);
    str = rTrim(str);
    return str;
}
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
/* <% ' 파일확장자를 제거한 이름을 가져옴 %> */
function getFileNameM(str) {
    var limitCnt = str.lastIndexOf('.');
    var strLen = str.length;
    var fileName = str.substring(0,limitCnt);
    
    return fileName;
}

/* <% ' 파일확장자를 가져옴 %> */
function getFileNameC(str) {
    var startCnt = str.lastIndexOf('.');
    var strLen = str.length;
    var fileName = str.substring(startCnt+1,strLen);
    fileName = toLowerCase(fileName);
    return fileName;
}
// -----------------------------------------------------------------------------




// <% ' 폼 허용 문자열 체크 %> -------------------------------------------------
/* <% ' 이메일 체크 %> */
function isMailChars(str) {
    var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
    var filter = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
    if (!filter.test(str)) {
        return false;
    } else {
        return true;
    }
}


/* <% ' 아이디체크 %> */
function isIDChars(str) {
    //var filter = /^[a-z]+([a-z]|[0-9])/gi;
    //if (!filter.test(str)) { return false; }
    
    var allowStart = 'abcdefghijklmnopqrstuvwxyz';
    var allowStr = 'abcdefghijklmnopqrstuvwxyz0123456789';
    if (!isDataTrue(str,allowStr)) { return false; }
    if (!isDataTrue(str.substring(0,1),allowStart)) { return false; }
    return true;
}

function isPwdChars(str) {
    var allowStr = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    if (!isDataTrue(str,allowStr)) { return false; }
    return true;
}

function isEngName(str) {
    var allowStr = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ()';
    if (!isDataTrue(str,allowStr)) { return false; }
    return true;
}

function isNameChars(str) {
    var allowStr = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.- \'";
    if (!isDataTrue(str,allowStr)) { return false; }
    return true;
}

function isSubjectChars(str) {
    var allowStr = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ~!@#$%^&*()_+| `-=\\\'"<>?/[]{},.';
    if (!isDataTrue(str,allowStr)) { return false; }
    return true;
}

function isAlphabet(str) {
    var allowStr = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (!isDataTrue(str,allowStr)) { return false; }
    return true;
}

function isTelNumber(str) {
    var allowStr = '0123456789-+ ';
    if (!isDataTrue(str,allowStr)) { return false; }
    return true;
}

function isNumeric(str) {
    var allowStr = '0123456789';
    if (!isDataTrue(str,allowStr)) { return false; }
    return true;
}

function isNumericMoney(str) {
    var allowStr = '0123456789,';
    if (!isDataTrue(str,allowStr)) { return false; }
    return true;
}


function isCardNo(str) {
    var allowStr = '0123456789-';
		if (!isDataTrue(str,allowStr)) { return false; }
		return true;
}

function isDataTrue(str,varStr) {  // <% ' 허용 문자열 체크 %>
    for (var i=0; i<str.length; i++) {
        if (varStr.indexOf(str.charAt(i))==-1) {
            return false;
            break;
        }
    }
    return true;
}
// -----------------------------------------------------------------------------



// User Column Others Enabled --------------------------------------------------
function enableOthers(t,n) {
    var form = t.form;
    var field = eval('form.'+t.name);
    var fieldOthers = eval('form.'+t.name+'Others');
    
    if (field[n].checked==true) {
        fieldOthers.disabled = false;
        fieldOthers.style.backgroundColor = '';
        fieldOthers.style.borderColor = '';
        fieldOthers.focus();
    } else {
        fieldOthers.disabled = true;
        fieldOthers.style.backgroundColor = '#EFEFEF';
        fieldOthers.style.borderColor = '#CCCCCC';
        fieldOthers.value = '';
    }
}
// -----------------------------------------------------------------------------



// -----------------------------------------------------------------------------
function replaceGoNext(form) {  // <% ' 폼 전송시 쉼표 치환 %>
    var listCount = form.elements.length;
    for (var i=0; i<listCount; i++) {
        if (form.elements[i].name!="uploadFile1" && form.elements[i].name!="uploadFile2") {
            form.elements[i].value = replaceComma(form.elements[i].value);
        }
    }
}

function replaceHistoryBack(form) {  // <% ' 수정(history.back)시 치환된 쉼표 복구 %>
    var listCount = form.elements.length;
    //alert(listCount);
    var newValue = '';
    for (var i=0; i<listCount; i++) {
        if (form.elements[i].type!="file") {
            form.elements[i].value = roleBackComma(form.elements[i].value);
        }
    }
}

function replaceComma(str) {
    str = str.replace(/,/g,'&#44;');
    return str;
}

function roleBackComma(str) {
    str = str.replace(/&#44;/g,',');
    return str;
}

// -----------------------------------------------------------------------------



// -----------------------------------------------------------------------------
function setComma(x) {  // insert Comma
    var txtNumber = '' + x;
    var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])');
    var arrNumber = txtNumber.split('.');
    arrNumber[0] += '.';
    
    do {arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2'); 
    } while (rxSplit.test(arrNumber[0]));
    
    if (arrNumber.length > 1) {
        return arrNumber.join('');
    } else {
        return arrNumber[0].split('.')[0];
    }
}

function unSetComma(x) {
		x = x.replace(/,/g,'');
		return x;
}


function setSpace(x) {  // insert Comma
    return setComma(x).replace(/,/g,' ');
}

// -----------------------------------------------------------------------------



// 입력 Byte 계산 --------------------------------------------------------------
function checkBytes(field,len) {
    var bodyVal = field.value;
		var bodyLen = bodyVal.length;
		var bytesLen = 0;
		var validBodyLen = 0;
		var validBytesLen = 0;
		for (var i = 0; i < bodyLen; i++) {
		    var oneChar = bodyVal.charAt(i);
				if (escape(oneChar).length > 4) {
				    bytesLen += 2;
				} else if (oneChar!='\n' ) {
				    bytesLen++;
				} else if (oneChar=='\n' ) {
						bytesLen += 1;
				}
				if (bytesLen <= len)	{
				    validBodyLen = i + 1;
						validBytesLen = bytesLen;
				}
		}
		if (bytesLen > len) {
		    alert("Please enter your "+field.name+" in "+len+" byte.");
				var realBodyVal = bodyVal.substr(0, validBodyLen);
				field.value = realBodyVal;
				return;
		}
    viewByte_id.innerHTML = '<font color=\'\'>' + bytesLen + '</font>';
}



// ------------------------------------------------------------------------------



// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

function setCookie(name, value, expiredays) {
    var todayDate = new Date();
    todayDate.setDate(todayDate.getDate() + expiredays );
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function getCookie(cookieName) {
    var search = cookieName + "=";
    var cookie = document.cookie;
   
   if( cookie.length > 0 ) {
      // <% '해당 쿠키명이 존재하는지 검색한 후 존재하면 위치를 리턴. %>
      startIndex = cookie.indexOf( cookieName );
      // <% '만약 존재한다면 %>
      if( startIndex != -1 ){
       // <% '값을 얻어내기 위해 시작 인덱스 조절 %>
          startIndex += cookieName.length;
    
       // <% ' 값을 얻어내기 위해 종료 인덱스 추출 %>
          endIndex = cookie.indexOf( ";", startIndex );
    
          // <% ' 만약 종료 인덱스를 못찾게 되면 쿠키 전체길이로 설정 %>
          if( endIndex == -1) endIndex = cookie.length;
    
          // <% ' 쿠키값을 추출하여 리턴 %>
          return unescape( cookie.substring( startIndex + 1, endIndex ) );
        } else{ // <% ' 쿠키 내에 해당 쿠키가 존재하지 않을 경우 %>
            return false;
      }
   } else {   // <% ' 쿠키 자체가 없을 경우 %>
      return false;
   }
}



/* Get Mouse Event Position */
function getPosition(e) {
    isIE();
    var x, y;
    var cursor = {x:0, y:0};
    
    var posx = 0;
    var posy = 0;
    //if (!e) var e = window.event; // 이벤트 검사
    var evt = e ? e : window.event;

    if (e.pageX || e.pageY) { // pageX/Y 표준 검사
        posx = e.pageX;
        posy = e.pageY;
    } else if (e.clientX || e.clientY) { //clientX/Y 표준 검사 Opera
        posx = e.clientX;
        posy = e.clientY;
        if (isIE) { // IE 여부 검사
            posx += document.body.scrollLeft;
            //posy += document.body.scrollTop;
						posy += document.documentElement.scrollTop;
        }
    }
    
    cursor.x = posx;
    cursor.y = posy;
    return cursor;
}



/*  */
function newCenterWindow(w,h,opt,url,winName) {
    var winWidth = w;
    var winHeight = h ;
    var x = screen.width/2 - winWidth/2;
    var y = screen.height/2 - winHeight/2;
    var winName = window.open(url,winName,'left='+ x +',top='+ y +',width='+ winWidth +', height='+ winHeight +', scrollbars='+opt)
    winName.focus();
}

function onlynumbericIns(obj){
    val=obj.value;
    re=/[^0-9]/gi;
		var valA=val.replace(re,"");
    if(!valA||valA==""){
		    valA="";
		}else{
		    valA=parseInt(valA);
		}
		obj.value=valA;
}

function onlynumberic(obj){
    val=obj.value;
    re=/[^0-9]/gi;
		var valA=val.replace(re,"");
    if(!valA||valA==""){
		    valA="";
		}
		obj.value=valA;
}


function onlynumberic_telephone(obj){
    val=obj.value;
    re=/[^0-9+-]/gi;
		var valA=val.replace(re,"");
    if(!valA||valA==""){
		    valA="";
		}
		obj.value=valA;
}

function isPwdChars_01(str) {
    var allowStr = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()';
    if (!isDataTrue(str,allowStr)) { return false; }
    
    var str_01= 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var str_02= '0123456789';
    var str_03= '!@#$%^&*()';
    
    var chk_01 = "N";
    var chk_02 = "N";
    var chk_03 = "N";
    var allChk = "N";
    
    for (var i=0; i<str.length; i++) {
        if (str_01.indexOf(str.charAt(i))>-1) {
            chk_01="Y";
        }
        if (str_02.indexOf(str.charAt(i))>-1) {
            chk_02="Y";
        }
        if (str_03.indexOf(str.charAt(i))>-1) {
            chk_03="Y";
        }
        if(chk_01=="Y"&&chk_02=="Y"&&chk_03=="Y"){
            allChk="Y";
            break;
        }
    }
    if (allChk=="N") { return false; }
    
    return true;
}


function onlynumberic_1(obj){
    val=obj.value;
    re=/[^0-9,"."]/gi;
		var valA=val.replace(re,"");
    if(!valA||valA==""){
		    valA="";
		}
		obj.value=valA;
}

function onlynumberic_s(obj){  // <% '첫자리 0 삭제 %>
    val=obj.value;
    re=/[^0-9]/gi;
		var valA=val.replace(re,"");
    if(!valA||valA==""||valA=="0"){
		    valA="";
		}
		obj.value=valA;
}


function toNameChar_first(str) {
    var newStr = '';
		var cval=str.value;
		var fchar;
		var nchar;
		if (cval.length>0) {
  		  fchar=cval.substring(0,1);
				nchar=cval.substring(1, cval.length);
        newStr = toUCaseStart(fchar) + nchar;
				str.value = newStr;
    }
    
    return;
}



function  toNameChar_first_han(str){
    var newStr = '';
    var cval=str.value;
		var fword;
  	if (cval.length>0) {

				fword=cval.split(" ");
				for(var i=0;i<fword.length;i++){
				    if(newStr==''){
						   newStr = toUCaseStart(fword[i])
						}else{
						   newStr = newStr+" "+toUCaseStart(fword[i]);
						}
				}
				str.value = newStr;
    }
    return;
}

function isNameChars_chk(field) {
    if (!isNameChars(field.value)) {
        alert('Please enter only alphabet characters and numeric or dash(\'-\').');
        field.value = ''; field.focus(); return false;
    }
}

function inAry(obj,str){
  var rVal;
	rVal=true;
  for(var i=0;i<obj.length;i++){
	   if(obj[i]==str){
		     rVal=false;
				 break;
		 }
	}
	return rVal;
}

function  toabsTitle_han(str){

    var newStr = '';
    var cval=str.value;
		var fword;
		var lcaseAry=new Array;
		lcaseAry=["by","be","this","that","to","and","but","or","nor","yet","so","a","an","the","on","in","of","behind","about","also","at","then","foward","under","with","as","among","from with at","vs","without","through"];
		if (cval.length>0) {
		
		
				fword=cval.split(" ");
				 for(var i=0;i<fword.length;i++){
				
				
				    if(newStr==''){
						   //if(inAry(lcaseAry,fword[i].toLowerCase())){
							     newStr = toUCaseStart(fword[i])
							 //}else{
							 //    newStr = fword[i].toLowerCase();
							 //}
						   
						}else{
						   if(inAry(lcaseAry,fword[i].toLowerCase())){
							     newStr = newStr+" "+toUCaseStart(fword[i])
							 }else{
							     newStr = newStr+" "+fword[i].toLowerCase();
							 }
						}
				}
				str.value = newStr; 
    }
    return;
}




// 주민번호 체크
function isJuminNumber(str) {
    var juminNo = str;
		
		if (parseInt(juminNo.substring(2,3))>1 || parseInt(juminNo.substring(4,6))>31){
         return false;
    }
   
    a = new Array(13);
   
    for (var i=0; i < 13; i++) {
        a[i] = parseInt(juminNo.charAt(i));
    }
   
    var j = a[0]*2 + a[1]*3 + a[2]*4 + a[3]*5 + a[4]*6 + a[5]*7 + a[6]*8 + a[7]*9 + a[8]*2 + a[9]*3 + a[10]*4 + a[11]*5;
    var j = j % 11;
    var k = 11 - j;
   
    if (k > 9) {
        k = k % 10
    }
   
    if (k == a[12]) {
        return true;
    } else {
    		return false;
		}
}

function noneSpace(x) {
		x = x.replace(/ /g,'');
		return x;
}

String.prototype.replaceAll = function(org, dest) {
   return this.split(org).join(dest);
}


var tableRowAr = new Array("Firefox","Opera","Safari","rv:11.0","MSIE 10.0");
//-->