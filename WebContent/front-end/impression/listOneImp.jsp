<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.impression.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	String memNo=(String)session.getAttribute("memno");
	pageContext.setAttribute("memNo", memNo);
	ImpressionService impSvc = new ImpressionService();
	List<ImpressionVO> list = impSvc.myimpression(memNo);
	System.out.println(list);
	request.setAttribute("list", list);
%>

<html>
<head>
<title>我的心得 - listOneImp.jsp</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+TC">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.css" />
	<script src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.full.js"></script>
  <style>
   h3.title{
 	text-align:center;
 	font-family:Microsoft JhengHei;
 	font-size:200%;
 }
  h4 {
    color: #FF0088;
    text-align:right;
  }
</style>

<style>
  table {
	width: container-fluid;
	background-color: white;
	margin-top: 10px;
	margin-bottom: 10px;
	
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th{
  	text-align: center;
  }
  th, td {
    padding: 5px;
  }
  img{
		 max-height:300px;
		 max-width: 300px; 
		 vertical-align:middle;
	 }
</style>
	
</head>

<body>
	<header style="background-image:url('<%=request.getContextPath()%>/front-end/activity/img/act1.gif'); height:150px;background-repeat: no-repeat;
    background-attachment: fixed;background-position: center;background-size: cover;">
		<span>&nbsp;</span><br>
		<span>&nbsp;</span>
			<h3 class="title"><span><b>所有募集中的活動</b></span></h3>
			<h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><batton class="btn btn-Success" style="margin-right:20px;">回首頁</batton></a></h4>
	</header>

<table>
	<tr style="background-image: linear-gradient(120deg, #e0c3fc 0%, #8ec5fc 100%);">
		<th>心得編號</th>
		<th>心得時間</th>
		<th>心得主旨</th>
		<th>活動編號</th>
		<th>會員編號</th>
		<th>心得內容</th>
		<th>影片</th>
		<th>照片</th>
		<th>修改</th>
	</tr>
	
	<%@ include file="page1.file" %> 
	<c:forEach var="list" items="${list}" begin="<%= pageIndex %>" end="<%=pageIndex+rowsPerPage-1%>">
	<tr>
			<td>${list.impNo}</td>
			<td>${list.impTime}</td>
			<td>${list.impName}</td>
			<td>${list.actNo}</td>
			<td>${list.memNo}</td>
			<td>${list.impCon}</td>
<!--影片 -->
			<c:choose>
				<c:when test="${(list.recVideo)!=null}">
			<td>
				<video width="400" controls>
				<source src="<%= request.getContextPath() %>/impression/impressionVideo.do?impNo=${list.impNo} " type="video/mp4"/>
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
					<c:when test="${(list.recPic)!=null}">
						<td>
							<img src="<%= request.getContextPath() %>/impression/impressionPic.do?impNo=${list.impNo} " height=50%/>
						</td>
					</c:when>
				<c:otherwise >
					<td>
						<img src="<%=request.getContextPath()%>/front-end/impression/img/nopic.jpg">
					</td>
				</c:otherwise>
				</c:choose> 
			<td>
				<form METHOD="post" action="<%=request.getContextPath()%>/impression/impression.do" style="margin-bottom: 0px;">
			     	<input type="hidden" name="impNo"  value="${list.impNo}">
			     	<input type="hidden" name="impField"  value="${list.impField}">			     	
			     	<input type="hidden" name="action"	value="getOne_For_Update">
					<button type="submit" class="btn btn-info">修改</button>
				</form>
			</td>
	</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>
</body>
</html>