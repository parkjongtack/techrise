<%
' ##############################################################################
' BASE 64 Encoded 및 Decoded
' 1byte 문자 조합만 가능(한글 및 2byte 특수문자 안됨) => 한글 문자 Escape로 해결
' 마지막 수정일 : 2008.03.26 (Escape, UnEscape 추가)
' ##############################################################################

Const BASE_64_MAP_INIT = "aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ0246813579!@"

' zero based arrays 
Dim Base64EncMap(63)
Dim Base64DecMap(127) 


' ==============================================================================
' Must be called before using anything else.

PUBLIC SUB initCodecs()
    ' init vars
    Dim nl
    nl = "<P>" & chr(13) & chr(10)
    ' setup base 64
    Dim max, idx
    max = len(BASE_64_MAP_INIT)
    
    for idx = 0 to max - 1
        ' one based string
        Base64EncMap(idx) = mid(BASE_64_MAP_INIT, idx + 1, 1)
    next
    for idx = 0 to max - 1
        Base64DecMap(ASC(Base64EncMap(idx))) = idx
    next
END SUB
' ==============================================================================
 



' ============================================================================== 
' encode base 64 encoded string 

PUBLIC FUNCTION base64Encode(plain) 
'    if len(plain) = 0 then 
'        base64Encode = "" 
'        exit function 
'    end if

    Dim getStr : getStr = plain    ' Escape 추가 (2008. 03. 26)
    
    if Len(getStr)=0 or isNull(getStr) or isEmpty(getStr) then 
        base64Encode = "" 
        exit function 
    else
        getStr = Escape(getStr)
    end if
    
    
    

    Dim ret, ndx, by3, first, second, third 
    by3 = (len(getStr) \ 3) * 3 
    ndx = 1 
    do while ndx <= by3 
        first  = asc(mid(getStr, ndx+0, 1)) 
        second = asc(mid(getStr, ndx+1, 1)) 
        third  = asc(mid(getStr, ndx+2, 1)) 
        ret = ret & Base64EncMap(  (first \ 4) AND 63 ) 
        ret = ret & Base64EncMap( ((first * 16) AND 48) + ((second \ 16) AND 15 ) ) 
        ret = ret & Base64EncMap( ((second * 4) AND 60) + ((third \ 64) AND 3 ) ) 
        ret = ret & Base64EncMap( third AND 63) 
        ndx = ndx + 3 
    loop
    
    ' check for stragglers 
    if by3 < len(getStr) then 
        first  = asc(mid(getStr, ndx+0, 1)) 
        ret = ret & Base64EncMap(  (first \ 4) AND 63 ) 
        if (len(getStr) MOD 3 ) = 2 then 
                    second = asc(mid(getStr, ndx+1, 1)) 
                    ret = ret & Base64EncMap( ((first * 16) AND 48) + ((second \ 16) AND 15 ) ) 
                    ret = ret & Base64EncMap( ((second * 4) AND 60) ) 
        else 
                    ret = ret & Base64EncMap( (first * 16) AND 48) 
                    ret = ret & "=" 
        end if 
        ret = ret & "="
    end if

    base64Encode = ret
END FUNCTION
' ==============================================================================

 



' ============================================================================== 
' decode base 64 encoded string 

PUBLIC FUNCTION base64Decode(scrambled) 
    if len(scrambled) = 0 then 
        base64Decode = "" 
        exit function 
    end if 

    ' ignore padding 
    Dim realLen 
    realLen = len(scrambled) 
    do while mid(scrambled, realLen, 1) = "=" 
        realLen = realLen - 1 
    loop
    
    dim ret, ndx, by4, first, second, third, fourth 
    ret = "" 
    by4 = (realLen \ 4) * 4 
    ndx = 1 
    do while ndx <= by4 
        first  = Base64DecMap(asc(mid(scrambled, ndx+0, 1))) 
        second = Base64DecMap(asc(mid(scrambled, ndx+1, 1))) 
        third  = Base64DecMap(asc(mid(scrambled, ndx+2, 1))) 
        fourth = Base64DecMap(asc(mid(scrambled, ndx+3, 1))) 
        ret = ret & chr( ((first * 4) AND 255) +  ((second \ 16) AND 3)) 
        ret = ret & chr( ((second * 16) AND 255) + ((third \ 4) AND 15) ) 
        ret = ret & chr( ((third * 64) AND 255) +  (fourth AND 63) ) 
        ndx = ndx + 4 
    loop 
    
    ' check for stragglers, will be 2 or 3 characters 
    if ndx < realLen then 
        first  = Base64DecMap(asc(mid(scrambled, ndx+0, 1))) 
        second = Base64DecMap(asc(mid(scrambled, ndx+1, 1))) 
        ret = ret & chr( ((first * 4) AND 255) +  ((second \ 16) AND 3)) 
        if realLen MOD 4 = 3 then 
                    third = Base64DecMap(asc(mid(scrambled,ndx+2,1))) 
                    ret = ret & chr( ((second * 16) AND 255) + ((third \ 4) AND 15) ) 
        end if 
    end if 
    
    if Len(ret)=0 or isNull(ret) or isEmpty(ret) then
        base64Decode = ""
        Exit Function
    else
        base64Decode = UnEscape(ret)  ' UnEscpae (2008. 03. 26)
    end if
END FUNCTION 
' ==============================================================================




' ------------------------------------------------------------------------------ 
' initialize 초기화 

call initCodecs
' ------------------------------------------------------------------------------ 


%> 
