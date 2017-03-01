<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	function goPopup(){ 
		var pop = window.open("/popup/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes"); //경로는 시스템에 맞게 수정하여 사용 
	} 
	function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn){ 

		document.form.roadFullAddr.value = roadFullAddr;
		document.form.addrDetail.value = addrDetail; 
		document.form.jibunAddr.value = jibunAddr; 
		document.form.zipNo.value = zipNo; 
		document.form.rnMgtSn.value = rnMgtSn; 
		document.form.bdMgtSn.value = bdMgtSn;
	}
</script> 
</head> 
<body> 
<form name="form" id="form" method="post"> 
<input type="button" onClick="goPopup();" value="팝업"/> 
도로명주소 전체(포멧) <input type="text" id="roadFullAddr" name="roadFullAddr" /><br> 
도로명주소 <input type="text" id="roadAddrPart1" name="roadAddrPart1" /><br>
고객입력 상세주소<input type="text" id="addrDetail" name="addrDetail" /><br>
참고주소<input type="text" id="roadAddrPart2" name="roadAddrPart2" /><br>
영문 도로명주소<input type="text" id="engAddr" name="engAddr" /><br>
지번<input type="text" id="jibunAddr" name="jibunAddr" /><br>
우편번호<input type="text" id="zipNo" name="zipNo" /><br>
행정구역코드 <input type="text" style="width:500px;" id="admCd" name="admCd" /><br>
도로명코드<input type="text" style="width:500px;" id= "rnMgtSn" name= "rnMgtSn" /><br>
건물관리번호<input type="text" style="width:500px;" id="bdMgtSn" name="bdMgtSn" /> </form>
</body>
</html>