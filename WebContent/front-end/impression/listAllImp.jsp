<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.impression.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	ImpressionService impressionSvc = new ImpressionService();
    List<ImpressionVO> list = impressionSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有員工資料 - listAllImp.jsp</title>

<style>
  table#table-1 {
	width:container-fluid;
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
    table-layout:fixed;
    
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
  	width:container-fluid;
	table-layout:fixed;
	word-break:break-all;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
  img {
	max-width: 400px; 
	width:expression(this.width > 00 ? "400px" : this.width);
	overflow:hidden;
}
</style>

</head>
<body bgcolor='white'>

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有員工資料 - listAllImp.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="<%=request.getContextPath()%>/front-end/impression/img/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>心得編號</th>
		<th>心得時間</th>
		<th>心得名稱</th>		
		<th>活動編號</th>
		<th>會員編號</th>
		<th>文字心得內容</th>
		<th>影片紀錄</th>
		<th>照片記錄</th>
		<th>分類標籤</th>

	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="impressionVO" items="${list}" begin="<%= pageIndex %>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${impressionVO.impNo}</td>
			<td>${impressionVO.impTime}</td>
			<td>${impressionVO.impName}</td>			
			<td>${impressionVO.actNo}</td>
			<td>${impressionVO.memNo}</td>
			<td>${impressionVO.impCon}</td>
<!--影片 -->
			<c:choose>
				<c:when test="${(impressionVO.recVideo)!=null}">
			<td>
				<video width="400" controls>
				<source src="<%= request.getContextPath() %>/impression/impressionVideo.do?impNo=${impressionVO.impNo} " type="video/mp4"/>
				</video>
			</td>
				</c:when>
				<c:otherwise >
			<td>
			<img src="<%=request.getContextPath()%>/front-end/impression/img/no-video.png">
			</td>
				</c:otherwise>
			</c:choose>
<!--照片 -->
			<c:choose>
				<c:when test="${(impressionVO.recPic)!=null}">
			<td>
				<img src="<%= request.getContextPath() %>/impression/impressionPic.do?impNo=${impressionVO.impNo} " height=50% />
			</td>
				</c:when>
				<c:otherwise >
			<td>
			<img src="<%=request.getContextPath()%>/front-end/impression/img/nopic.jpg">
			</td>
				</c:otherwise>
			</c:choose>
			
			<td>${impressionVO.impField}</td>

		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>
<script type="text/javascript">
var v = document.querySelector('video'),
sources = v.querySelectorAll('source'),
lastsource = sources[sources.length-1];
lastsource.addEventListener('error', function(ev) {
var d = document.createElement('div');
d.innerHTML = v.innerHTML;
v.parentNode.replaceChild(d, v);
}, false);
</script>

</body>
</html>