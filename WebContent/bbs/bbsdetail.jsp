<%@page import="dto.BbsDto"%>
<%@page import="dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int seq=Integer.parseInt(request.getParameter("seq"));

%>
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
BbsDao dao=BbsDao.getInstance();
dao.readcount(seq);
BbsDto dto = dao.getBbs(seq);



%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>상세글보기</h2>
<div align="center">

<table border="1">
<colgroup>
	<col style="width :200px">
	<col style="width :400px">
</colgroup>

<tr>
	<th>작성자</th>
	<td><%=dto.getId() %>
		<%-- <input type="text" name="id" value="<%=mem.getId() %>" readonly> --%>
	</td>
</tr>
<tr>
	<th>작성일</th>
	<td><%=dto.getWdate() %></td>
</tr>
<tr>
	<th>조회수</th>
	<td><%=dto.getReadcount() %></td>
</tr>
<tr>
	<th>제목</th>
	<td><%=dto.getTitle() %></td>
</tr>
<tr>
	<th>정보</th>
	<td><%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %></td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="15" cols="90" readonly="readonly"><%=dto.getContent() %></textarea>
	</td>
</tr>

</table>

<br>
<button type="button" onclick="answerBbs(<%=dto.getSeq()%>)">답글</button>
<button type="button" onclick="location.href='../bbs?param=bbslist'">글목록</button>

<%
if(dto.getId().equals(mem.getId())){	//글쓴사람이랑 수정하는 사람의 id가 같을때(작성자만 수정할 수 있게)
%>
<button type="button" onclick="updateBbs(<%=dto.getSeq()%>)">수정</button>
<button type="button" onclick="deleteBbs(<%=dto.getSeq()%>)">삭제</button>


<%
}
%>

<script type="text/javascript">
function answerBbs(seq){
	location.href="../bbs?param=answer&seq="+seq;
	
}
function updateBbs(seq){
	location.href="../bbs?param=update&seq="+seq;
	
}
function deleteBbs(seq){
	location.href="../bbs?param=delete&seq="+seq;
}


</script>

</div>
</body>
</html>