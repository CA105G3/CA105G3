<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.activity.model.*"%>
<%@ page import="com.joinact.model.*"%>

<% 
String memNo=(String)session.getAttribute("memno");
pageContext.setAttribute("memNo", memNo);
JoinActService joinActSvc = new JoinActService();
Set<PersonActVO> personactSet = joinActSvc.getAll(memNo);
pageContext.setAttribute("personactSet", personactSet);
%>

<html>
<head>

<title>查詢所有參加活動-PresonAct.jsp</title>
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
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
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
  word-wrap{
   word-break: break-all;
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
	<header style="background-image:url('<%=request.getContextPath()%>/front-end/activity/img/mountain.jpg'); height:150px;">
		<div>
			<h3 style="display:inline">我建立的活動-actone.jsp</h3>
			<h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="<%=request.getContextPath()%>/front-end/activity/img/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
		</div>
	</header>

<!-- 錯誤列表 -->
<c:if test="${not empty erroeMsgs}">
	<font style="color:red">請修正以下錯誤</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}" varStatus="s">
				<li style="color:red">${message}</li>
			</c:forEach>	
		</ul>
</c:if>

<table>
	<tr style="background-image: linear-gradient(120deg, #e0c3fc 0%, #8ec5fc 100%);">
		<th>活動編號</th>
		<th>活動編號</th>
		<th>活動名稱</th>
		<th>活動地點</th>
		<th>活動時間</th>
		<th>活動照片</th>
		<th>活動敘述</th>
		<th>修改</th>
		<th>聊天室</th>
		
		
	</tr>
	
		<c:forEach var="personActVO" items="${personactSet}">
			<tr>
				
				<td>${personActVO.memNo}</td>
				<td>${personActVO.actNo}</td>
				<td>${personActVO.actName}</td>
				<td>${personActVO.actLoc}</td>
				<td>${personActVO.actTime}</td>
<!-- 活動照片 -->
				<c:choose>
				<c:when test="${(personActVO.actPic)!=null}">
			<td>
				<img src="<%= request.getContextPath()%>/activity/activityPic.do?actNo=${personActVO.actNo}" height=50% weight=50%/>
			</td>
				</c:when>
				<c:otherwise >
			<td>
			<img src="<%= request.getContextPath()%>/front-end/activity/img/nopic.jpg">
			</td>
				</c:otherwise>
			</c:choose>
				<td>${personActVO.actDesc}</td>
<!--退出活動 -->
				<td>	
			  		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/joinact/joinact.do" style="margin-bottom: 0px;">
				    	<input type="submit" value="退出活動" class="btn btn-info">
				    	<input type="hidden" name="actNo"  value="${personActVO.actNo}">
				    	<input type="hidden" name="memNo" value="${personActVO.memNo}">
				    	<input type="hidden" name="action" value="delete">
			     	</FORM>
				</td>
<!--加入聊天室 -->
				<td>	
			  		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/activity/activity.do" style="margin-bottom: 0px;">
				    	<input type="submit" value="進入聊天室" class="btn btn-info">
				    	<input type="hidden" name="actNo"  value="${personActVO.actNo}">
				    	<input type="hidden" name="memNo" value="${personActVO.memNo}">
				    	<input type="hidden" name="action" value="chat_room">
			     	</FORM>
				</td>
			</tr>
		</c:forEach>
</table>


</body>
</html>