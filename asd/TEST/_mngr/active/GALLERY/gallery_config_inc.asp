<%

		
Dim  tmpSaveDir
'tmpSaveDir     = Request.ServerVariables("APPL_PHYSICAL_PATH")&"upload\temp\"   
tmpSaveDir      = "D:\Temp"

Dim tableName : tableName="AAC_gallery"

Dim saveFileDir : saveFileDir = Server.MapPath(".") &"upload\"  '' �̹������� ����� ���� ���


saveFileDir = replace(saveFileDir,"_mngr\active\GALLERY","")


Const viewImgWidth  = 550  '590  
Const viewImgHeight = 354   '354  
''''''''''''''''''''''''''''''''''''''''

''''''''''''''''' �����̴� �̴� ������
Const viewImgWidth_s  = 80 '550  ' ���� ���⿡�� �̹��� ���� ������ (default : 411)
Const viewImgHeight_s = 60 '331  ' ���� ���⿡�� �̹��� ���� ������
''''''''''''''''''''''''''''''''''''''''


Const pvLiImgWidth    = 230 ' list���� �̹��� ���� ������
Const pvLiImgHeight   = 190 ' list���� �̹��� ���� ������

Const pvImgWidth    = 120  ' �̸����⿡�� �̹��� ���� ������
Const pvImgHeight   = 90  ' �̸����⿡�� �̹��� ���� ������


Dim imageLocation : imageLocation = "/upload/photos/"  ' �� �̹��� ���
Dim thumbLocation : thumbLocation = "/upload/photos/sm/"  ' ����� �̹��� ���


Dim listColCount : listColCount  = 5 


Const photoFolder = "photos"     ' ���� �̹��� ����� ������
Const thumbFolder = "photos\sm"  ' ����� �̹��� ����� ������
Const viewFolder = "photos\vw"  ' ����� �̹��� ����� ������

Const maxImageSize    = 20971520      ' 5M = 5M * 1024 * 1024
Const uploadOutTime   = 10000          ' 10 Minute = 10M * 60Sec



Dim allowMimeType : allowMimeType = array("image/pjpeg","image/jpeg", "image/gif", "image/bmp", "image/x-png")
Dim allowFileType : allowFileType = array("jpg", "jpeg", "jpe", "gif", "bmp", "png")



%>