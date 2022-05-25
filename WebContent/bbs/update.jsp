<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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

<%
int seq=Integer.parseInt(request.getParameter("seq"));

//부모글의 내용
BbsDto bbs=BbsDao.getInstance().getBbs(seq);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>업데이트</h2>
<div align="center">

<form action="../bbs?param=updateAf" method="post">
<input type="hidden" name="seq" value="<%=bbs.getSeq() %>">
<input type="hidden" name="id" value="<%=mem.getId() %>">

<table border="1">
<col width="200"><col width="500">

<tr>
	<th>아이디</th>
	<td><%=mem.getId() %></td>
</tr>

<tr>
	<th>제목</th>
	<td><input type="text" name="title" size="50" value="<%=bbs.getTitle() %>"></td>
</tr>
<tr>
	<th>작성일</th>
	<td><%=bbs.getWdate() %></td>
</tr>
<tr>
	<th>내용</th>
	<td><textarea rows="20" cols="50" name="content"><%=bbs.getContent() %></textarea></td>
</tr>

<tr>
	<td colspan="2" align="center">
		<input type="submit" value="수정완료">
	</td>
</tr>

</table>
</form>
</div>
</body>
</html>