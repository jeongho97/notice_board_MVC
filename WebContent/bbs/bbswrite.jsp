<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.*"%>
<%
Object obj=session.getAttribute("login");
if(obj==null){ //session 정보 날라 갔을때
	%>
	
	<script>
	alert("로그인해 주십시오");
	location.href="login.jsp";
	</script>
	
	<%
}
MemberDto mem = (MemberDto)obj;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>글쓰기</h2>
<div align="center">
<form action="../bbs" method="post">
<input type="hidden" name="param" value="bbswriteAf">
<input type="hidden" name="id" value="<%=mem.getId() %>"> <!-- 외부에 안드러내고 id값을 넘기고 싶을때 -->



<table border="1">
<col width="200"><col width="400">
<tr>
	<th>아이디</th>
	<td><%=mem.getId() %>
		<%-- <input type="text" name="id" value="<%=mem.getId() %>" readonly> --%>
	</td>
</tr>
<tr>
	<th>제목</th>
	<td><input type="text" name="title" size="60"></td>
</tr>
<tr>
	<th>내용</th>
	<td><textarea rows="20" cols="50" name="content"></textarea></td>
</tr>
<tr>
	<td colspan="2" align="center">
		<input type="submit" value="작성완료">
	</td>
</tr>



</table>

</form>
</div>
</body>
</html>