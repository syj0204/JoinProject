<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<% 
	request.setCharacterEncoding("UTF-8");  //한글깨지면 주석제거
	//request.setCharacterEncoding("EUC-KR");  //해당시스템의 인코딩타입이 EUC-KR일경우에
	String inputYn = request.getParameter("inputYn"); 
	String roadFullAddr = request.getParameter("roadFullAddr"); 
	String jibunAddr = request.getParameter("jibunAddr"); 
	String zipNo = request.getParameter("zipNo"); 
	String addrDetail = request.getParameter("addrDetail");
	
	//System.out.print("roadFullAddr= "+roadFullAddr);
	//System.out.print("jibunAddr= "+jibunAddr);
	//System.out.print("zipNo= "+zipNo);
	//System.out.print("addrDetail= "+addrDetail);
	
%>
</head>
<script type="text/javascript">
function init(){
	var url = location.href;
	var confmKey = "U01TX0FVVEgyMDE3MDIyNzE2NTUzNzE5MzEx";
	var resultType = "4";
	var inputYn= "<%=inputYn%>";
	if(inputYn != "Y") {
		document.form.confmKey.value = confmKey;
		document.form.returnUrl.value = url;
		document.form.resultType.value = resultType;
		document.form.action="http://www.juso.go.kr/addrlink/addrLinkUrl.do";
		document.form.submit();
	} else {
		window.opener.getReturnValue("<%=roadFullAddr%>","<%=addrDetail%>","<%=jibunAddr%>","<%=zipNo%>");
		window.close();
	}
}
</script>
<body onload="init();">
	<form id="form" name="form" method="post">
		<input type="hidden" id="confmKey" name="confmKey" value=""/>
		<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
		<input type="hidden" id="resultType" name="resultType" value=""/>
	</form>
</body>
</html>