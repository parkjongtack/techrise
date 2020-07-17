<%

		
Dim  tmpSaveDir
'tmpSaveDir     = Request.ServerVariables("APPL_PHYSICAL_PATH")&"upload\temp\"   
tmpSaveDir      = "D:\Temp"

Dim tableName : tableName="AAC_gallery"

Dim saveFileDir : saveFileDir = Server.MapPath(".") &"upload\"  '' 이미지지가 저장될 상위 경로


saveFileDir = replace(saveFileDir,"_mngr\active\GALLERY","")


Const viewImgWidth  = 550  '590  
Const viewImgHeight = 354   '354  
''''''''''''''''''''''''''''''''''''''''

''''''''''''''''' 슬라이더 미니 사이즈
Const viewImgWidth_s  = 80 '550  ' 본문 보기에서 이미지 가로 사이즈 (default : 411)
Const viewImgHeight_s = 60 '331  ' 본문 보기에서 이미지 세로 사이즈
''''''''''''''''''''''''''''''''''''''''


Const pvLiImgWidth    = 230 ' list에서 이미지 가로 사이즈
Const pvLiImgHeight   = 190 ' list에서 이미지 세로 사이즈

Const pvImgWidth    = 120  ' 미리보기에서 이미지 가로 사이즈
Const pvImgHeight   = 90  ' 미리보기에서 이미지 세로 사이즈


Dim imageLocation : imageLocation = "/upload/photos/"  ' 주 이미지 경로
Dim thumbLocation : thumbLocation = "/upload/photos/sm/"  ' 썸네일 이미지 경로


Dim listColCount : listColCount  = 5 


Const photoFolder = "photos"     ' 원본 이미지 저장될 폴더명
Const thumbFolder = "photos\sm"  ' 썸네일 이미지 저장될 폴더명
Const viewFolder = "photos\vw"  ' 썸네일 이미지 저장될 폴더명

Const maxImageSize    = 20971520      ' 5M = 5M * 1024 * 1024
Const uploadOutTime   = 10000          ' 10 Minute = 10M * 60Sec



Dim allowMimeType : allowMimeType = array("image/pjpeg","image/jpeg", "image/gif", "image/bmp", "image/x-png")
Dim allowFileType : allowFileType = array("jpg", "jpeg", "jpe", "gif", "bmp", "png")



%>