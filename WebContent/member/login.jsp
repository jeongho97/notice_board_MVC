<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>

<style type="text/css">
.center{
	margin:auto;
	width:60%;
	border:3px solid #0000ff;
	padding: 10px;
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
</head>
<body>

<h2>login page</h2>

<div class="center">

<form action="../member" method="post">
<input type="hidden" name="param" value="loginAf">

<table border="1">
<tr>
	<th>아이디</th>
	<td>
		<input type="text" id="id" name="id" size="20"><br>
		<input type="checkbox" id="chk_save_id">아이디 저장
	</td>
</tr>
<tr>
	<th>패스워드</th>
	<td>
		<input type="password" name="pwd" size="20"><br>
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="로그인">
		<a href="../member?param=regi">회원가입</a>
	</td>
</tr>
</table>
</form>
</div>
<script type="text/javascript">

let user_id=$.cookie("user_id");
if(user_id !=null){
	$("#id").val(user_id);
	$("#chk_save_id").prop("checked",true);
}

$("#chk_save_id").click(function(){
	
	if($("#chk_save_id").is(":checked")){//체크가 되었을때
		
		if($("#id").val().trim()==""){
			alert("id를 입력해 주십시오");
			$("#chk_save_id").prop("checked",false);
		}else{
			//cookie에 저장
			$.cookie("user_id",$("#id").val().trim(),{expires:7,path:"/"}); //7일동안 지금 경로를 지정
			
			
		}
		
		
	}else{ //cookie 삭제
		$.removeCookie("user_id",{path:"/"}); //기간설정 안해주면 바로 삭제됨
	}
	
});

</script>

</body>
</html>