<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<%!
// 댓글용 depth와 image를 추가하는 함수
public String arrow(int depth){
	String rs = "<img src='images/arrow.png' width='20px' height='20px'/>";
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
	
	String ts = "";
	for(int i = 0;i < depth; i++){
		ts += nbsp;
	}
	
	return depth==0?"":ts + rs;
}

%>


<%
Object obj = session.getAttribute("login");
if(obj == null){
	%>
	<script>
	alert("로그인해 주십시오");
	location.href = "login.jsp";
	</script>	
	<%
}

MemberDto mem = (MemberDto)obj;
%>    

<%


int PageNumber = (Integer)request.getAttribute("pageNumber");
String choice = (String)request.getAttribute("choice");
String search = (String)request.getAttribute("search");
int bbsPage = (Integer)request.getAttribute("bbsPage");

BbsDao dao = BbsDao.getInstance();

List<BbsDto> list = (List<BbsDto>)request.getAttribute("list");

%>

<script type="text/javascript">
$(document).ready(function() {
	let search = "<%=search %>";
	if(search == "") return;
	
	let obj = document.getElementById("choice");
	obj.value = "<%=choice %>";
	obj.setAttribute("selected", "selected");
});
</script>  
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbslist.jsp</title>
</head>
<body>

<h2>게시판</h2>

<div align="center">

<table border="1">
<col width="70"><col width="600"><col width="150">

<tr>
	<th>번호</th><th>제목</th><th>작성자</th>
</tr>

<%
if(list == null || list.size() == 0){
	%>
	<tr>
		<td colspan="3">작성된 글이 없습니다</td>
	</tr>
	<%
}else{
	for(int i = 0;i < list.size(); i++){
			BbsDto bbs = list.get(i);
	%>
		<tr>
			<th><%=i + 1 %></th>
			<td>
				<%=arrow(bbs.getDepth()) %>
				<%
				if(bbs.getDel()==1){
				%>
					<%="이글은 작성자에 의해 삭제되었습니다" %>
				<%
				}else{
				%>
					<%-- <a href="bbsdetail.jsp?seq=<%=bbs.getSeq() %>"> --%>
					<a href="bbs?param=bbsdetail&seq=<%=bbs.getSeq() %>">
					<%=bbs.getTitle() %>
						</a>
					</td>

				<%
					}
				%>
				</a>
			</td>
			<td>
				<%=bbs.getId() %>
			</td>		
		</tr>
	<%
	}
}
%>
</table>

<br>
<%
for(int i = 0;i < bbsPage; i++){		// [1] 2 [3]
	if(PageNumber == i){	// 현재 페이지
		%>
		<span style="font-size: 15pt; color: #0000ff; font-weight: bold;">
			<%=i+1 %>
		</span>
		<%
	}else{
		%>	
		<a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
			style="font-size: 15pt; color: #000; font-weight: bold; text-decoration: none;">
			[<%=i+1  %>]
		</a>		
		<%
	}	
}
%>


<br><br>

<select id="choice">
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="writer">작성자</option>
</select>

<input type="text" id="search" value="<%=search %>">

<button type="button" onclick="searchBtn()">검색</button>

<br><br>

<a href="bbs?param=bbswrite">글쓰기</a>

</div>

<script type="text/javascript"> 

function searchBtn() {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	/*
	if(search.trim() == ""){
		alert("검색어를 입력해 주십시오");
		return;
	}
	*/
	location.href = "bbs?param=bbslist&choice=" + choice + "&search=" + search;
			
}
function goPage(pageNum){
	
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	location.href = "bbs?param=bbslist&choice=" + choice + "&search=" + search+ "&pageNumber="+pageNum;
	
}
</script>

</body>
</html>






