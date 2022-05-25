<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
String proc = request.getParameter("proc");

if(proc.equals("regi")){
	String msg = request.getParameter("msg");
	
	if(msg.equals("OK")){
	%>
		<script type="text/javascript">
		alert("성공적으로 가입되었습니다");
		location.href = "member?param=login";
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
		alert("다시 기입해 주십시오");
		location.href = "member?param=regi";
		</script>
		<%
	}
}else if(proc.equals("login")){
String msg = request.getParameter("msg");
	
	if(msg.equals("yes_login")){
	%>
		<script type="text/javascript">
		alert("환영합니다");
		location.href = "bbs?param=bbslist";
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
		alert("아이디나 비밀번호가 틀렸습니다. 다시 기입해 주십시오");
		location.href = "member?param=login";
		</script>
		<%
	}
}
else if(proc.equals("write")){
	String msg=request.getParameter("msg");
	
	if(msg.equals("write_success")){
		%>
		<script type="text/javascript">
	
		alert("정상적으로 글이 추가되었습니다");
		location.href="bbs?param=bbslist";
	
		</script>
		<%
	}else{
		%>
		
		<script type="text/javascript">
	
		alert("다시 작성해 주십시오");
		location.href="bbs?param=bbswrite";
	
		</script>
		<%
	}
}
else if(proc.equals("answer")){
String msg=request.getParameter("msg");
	
	if(msg.equals("answer_success")){
		%>
		<script type="text/javascript">
	
		alert("답글입력 성공");
		location.href = "bbs?param=bbslist";
	
		</script>
		<%
	}else{
		%>
		
		<script type="text/javascript">
	
		alert("답글입력 실패");
		location.href = "bbs?param=bbslist";
	
		</script>
		<%
	}
}
else if(proc.equals("update")){
String msg=request.getParameter("msg");
int seq=Integer.parseInt(request.getParameter("seq"));
	
	if(msg.equals("update_success")){
		%>
		<script type="text/javascript">
	
		alert("업데이트 성공");
		location.href = "bbs?param=bbsdetail&seq=<%=seq%>";
	
		</script>
		<%
	}else{
		%>
		
		<script type="text/javascript">
	
		alert("업데이트 실패");
		location.href = "bbs?param=bbsdetail&seq=<%=seq%>";
	
		</script>
		<%
	}
}
else if(proc.equals("delete")){
String msg=request.getParameter("msg");
	
if(msg.equals("delete_success")){
	%>
	<script type="text/javascript">
	
	alert("삭제 성공");
	location.href = "bbs?param=bbslist";
	
	</script>
	<%
}else{
	%>
		
	<script type="text/javascript">
	
	alert("삭제 실패");
	location.href = "bbs?param=bbslist";
	
	</script>
	<%
	}
}
%>
</body>
</html>