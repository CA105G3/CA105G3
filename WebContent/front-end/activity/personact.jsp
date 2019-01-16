<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.activity.model.*"%>
<%@ page import="com.joinact.model.*"%>

<% 
	String memNo="M0001";
	JoinActService joinActSvc = new JoinActService();
	Set<PersonActVO> personactSet = joinActSvc.getAll(memNo);
	pageContext.setAttribute("personactSet", personactSet);
%>

<html>
<head>

<title>查詢所有參加活動-PresonAct.jsp</title>
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
    border: 1px #FFAC55 solid;
    padding:1px;  
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor = 'white'>

<table id="table-1">
	<tr>
		<td>
			<h3>查詢所有參加活動 - PersonAct.jsp</h3>
			<h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="<%=request.getContextPath()%>/front-end/activity/img/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
		</td>
	</tr>
</table>

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
	<tr>
		<th>活動編號</th>
		<th>活動編號</th>
		<th>活動名稱</th>
		<th>活動地點</th>
		<th>活動時間</th>
		<th>活動照片</th>
		<th>活動敘述</th>
		
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
				    	<input type="submit" value="退出活動">
				    	<input type="hidden" name="actNo"  value="${personActVO.actNo}">
				    	<input type="hidden" name="memNo" value="${personActVO.memNo}">
				    	<input type="hidden" name="action" value="delete">
			     	</FORM>
				</td>
<!--加入聊天室 -->
				<td>	
			  		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/activity/activity.do" style="margin-bottom: 0px;">
				    	<input type="submit" value="進入聊天室">
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