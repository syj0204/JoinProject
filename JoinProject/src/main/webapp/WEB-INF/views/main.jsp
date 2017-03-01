<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<script src='https://www.google.com/recaptcha/api.js'></script>

<script type="text/javascript">

function getReturnValue(roadFullAddr,addrDetail,jibunAddr,zipNo) {
	document.getElementById("road_name_address").value = roadFullAddr;
	document.getElementById("detail_address").value = addrDetail; 
	document.getElementById("lot_number").value = jibunAddr; 
	document.getElementById("post_code").value = zipNo;
}

function verify_captcha(captcha_response) {
	$.ajax({
		url : "/verify_captcha",
		type: "POST",
		data : {"captcha_response":captcha_response},
		success:function(data) {
		    //$("#result").html(data);
		    alert(data);
		},
		error: function(jqXHR, textStatus, errorThrown) {
		    alert("FAIL!!");
		}
	});
}

$(function(){
	$("#password1").change(function() {
		var check = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
		var password1 = $("#password1").val();
		var password2 = $("#password2").val();

		if(!check.test(password1)) {
			$("#password1_error").text("비밀번호는 영문,숫자,특수문자를 혼용하여 8~16 이내로 해야 합니다.");
			
		} else {
			$("#password1_error").text("");
		}
		
		if(password1 != password2) {
			$("#password2_error").text("패스워드가 다릅니다.");
		} else {
			$("#password2_error").text("");
		}
	});
	
	$("#password2").change(function() {
		var password1 = $("#password1").val();
		var password2 = $("#password2").val();
		if(password1 != password2) {
			$("#password2_error").text("패스워드가 다릅니다.");
		} else {
			$("#password2_error").text("");
		}
	});
	//$("#find_address").postcodifyPopUp();
	/*$("#find_address").click(function() {
		alert("abc");
		//window.open("/popup/addr_popup.jsp", "popupWindow", "width=570,height=420, scrollbars=yes");
		$(this).postcodifyPopUp();
	});*/
	$("#find_address").click(function() {
		
		var address_popup = window.open("/popup/address_popup.jsp", "popupWindow", "width=570,height=420, scrollbars=yes");
		address_popup.focus();
	});
	
	$("#phone").change(function() {
		var check = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		var phone = $("#phone").val();
		if(!check.test(phone)) {
			$("#phone_error").text("유효하지 않은 핸드폰번호 입니다.");
			
		} else {
			$("#phone_error").text("");
		}
	});
	
	$("#email").change(function() {
		var check = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		var email = $("#email").val();
		if(!check.test(email)) {
			$("#email_error").text("유효하지 않은 이메일주소 입니다.");
			
		} else {
			$("#email_error").text("");
		}
	});
	
	/*$("#recaptchaCheck").click(function(e) {
		alert(document.getElementById("g-recaptcha-response").value);
	});*/
	
	$("#join_form").submit(function(e) {
	
		var imgsrc = document.getElementById("image").src;
		var name = $('#name').val();
		var road_name_address = $('#road_name_address').val();
		var detail_address = $('#detail_address').val();
		var lot_number = $('#lot_number').val();
		var post_code = $('#post_code').val();
		
		var phone = $('#phone').val();
		var email = $('#email').val();
		var joinpath = $(".rdclass :checked").val();
		var interests = [];
		var captcha_response = document.getElementById("g-recaptcha-response").value;
				
		$(".chkclass :checked").each(function() {
			interests.push($(this).val());
		});
		var allData = {"imgsrc":imgsrc, "name":name, "road_name_address":road_name_address, "detail_address":detail_address, "lot_number":lot_number, "post_code":post_code, "phone":phone, "email":email, "joinpath":joinpath, "interests":interests.toString(), "captcha_response":captcha_response};

		//verify_captcha(captcha_response);
		$.ajax({
			url : "/join",
			type: "POST",
			data : allData,
			success:function(data, textStatus, jqXHR) {
			    //$("#result").html(data);
			    alert(data);
			},
			error: function(jqXHR, textStatus, errorThrown) {
			    alert("FAIL!!");
			}
		});
		e.preventDefault();
		e.unbind();
	});
});
</script>
<style type="text/css">
table {
    border-collapse: collapse;
    width: 60%;
}

table, th, td {
   border: 1px solid black;
}
td {
    padding: 15px;
    text-align: left;
}
</style> 
</head>
<body>

 <h2> 회원가입 </h2>
 <!-- <form action="${pageContext.request.contextPath}/join" method="post"> -->
  <form id="join_form" accept-charset="UTF-8">
   <table>
   <tr>
     <td>사진</td>
     <td>
	     <input id="image" type="file" name="image" accept=".gif, .jpg, .png"
	     onchange="document.getElementById('image_output').src = window.URL.createObjectURL(this.files[0])"/><br />
	     <img id="image_output" width="100" height="100" style="border-style:none"/>
     </td>
    </tr>
    <tr>
     <td>이름</td>
     <td><input id="name" type="text" name="name"/></td>
    </tr>
    <tr>
     <td>주소</td>
     <td id="find_address">
	     도로명주소: <input id="road_name_address" type="text" name="road_name_address" readonly/> <br />
	     상세주소: <input id="detail_address" type="text" name="detail_address" readonly/> <br />
	     지번: <input id="lot_number" type="text" name="lot_number" readonly/> <br />
	     우편번호: <input id="post_code" type="text" name="post_code" readonly/> <br />
     </td>
     <!-- <td><button id="find_address" type="button">주소</button></td> -->
    </tr>
    <tr>
     <td>핸드폰번호</td>
     <td><input id="phone" type="text" name="phone"/><i style="color: red;" id="phone_error"></i></td>
    </tr>
    <tr>
     <td>Email</td>
     <td><input id="email" type="text" name="email"/><i style="color: red;" id="email_error"></i></td>
    </tr>
    <tr>
     <td>비밀번호</td>
     <td><input id="password1" type="password" name="password1"/><i style="color: red;" id="password1_error"></i></td>
    </tr>
    <tr>
     <td>비밀번호확인</td>
     <td><input id="password2" type="password" name="password2"/><i style="color: red;" id="password2_error"></i></td>
    </tr>
    <tr>
     <td>가입경로</td>
     <td>
     <div class="rdclass">
     	<input type="radio" name="joinpath" value="검색" />검색
		<input type="radio" name="joinpath" value="지인권유" />지인권유
		<input type="radio" name="joinpath" value="기타" />기타
	</div>
	</td>
    </tr>
    <tr>
     <td>개인관심사항</td>
     <td>
     <div class="chkclass">
     	<input type="checkbox" name="interests" value="인터넷" />인터넷
		<input type="checkbox" name="interests" value="게임" />게임
		<input type="checkbox" name="interests" value="영화" />영화
		<input type="checkbox" name="interests" value="운동" />운동
		<input type="checkbox" name="interests" value="기타" />기타
	</div>
	</td>
    </tr>
   </table>
   <div class="g-recaptcha" data-sitekey="6LesJhcUAAAAAFwDkIV6-38oQwS1dauiBbDuLHRL"></div>
   <!-- 
   <div id="recaptcha"></div>
   <input id="recaptchaCheck" type="button" value="Check"> -->
   <input type="submit" value="Submit" /><input type="reset" value="reset" />
  </form>
  
  <div id="result"></div>
</body>
</html>
