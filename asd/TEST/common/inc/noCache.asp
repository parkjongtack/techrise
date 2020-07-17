<%
' ##############################################################################
'Response.AddHeader "cache-control", "no-store"
Response.AddHeader "Cache-Control", "no-cache" 
Response.AddHeader "Pragma", "no-cache"      '// cash server를 사용하지 않음.
Response.AddHeader "Expires", "0"
' ##############################################################################
%>