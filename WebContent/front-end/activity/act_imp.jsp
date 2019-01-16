<%@page import="com.impression.model.ImpressionVO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.activity.model.*"%>

<jsp:useBean id="act_imp" scope="request" type="java.util.Set<ImpressionVO>" /> <!-- 於EL此行可省略 -->
<jsp:useBean id="activitySvc" scope="page" class="com.activity.model.ActivityService" />


<html>
<head><title>活動心得 - act_imp.jsp</title>

<style>
  table#table-2 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-2 h4 {
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
	width: container-fluid;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-2">
	<tr>
		<td>
		 	<h3>活動心得 - act_imp.jsp</h3>
		 	<h4><a href="<%=request.getContextPath()%>/front-end/impression/impsearch.jsp"><img src="<%=request.getContextPath()%>/front-end/activity/img/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
		</td>
	</tr>
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
		<th>修改</th>
		<th>刪除</th>
	</tr>
	
	<c:forEach var="ImpressionVO" items="${act_imp}" >
		<tr>
			<td>${ImpressionVO.impNo}</td>
			<td>${ImpressionVO.impTime}</td>
			<td>${ImpressionVO.impName}</td>
			<td>${ImpressionVO.actNo}</td>
			<td>${ImpressionVO.memNo}</td>
			<td>${ImpressionVO.impCon}</td>
<!-- 影片			 -->
			<c:choose>
				<c:when test="${(ImpressionVO.recVideo)!=null}">
			<td>
				<video width="400" controls>
				<source src="<%= request.getContextPath() %>/impression/impressionVideo.do?impNo=${ImpressionVO.impNo} " type="video/mp4"/>
				</video>
			</td>
				</c:when>
				<c:otherwise >
			<td>
			<img src="<%=request.getContextPath()%>/front-end/activity/img/no-video.png">
			</td>
				</c:otherwise>
			</c:choose>
<!-- 照片			 -->
			<c:choose>
				<c:when test="${(ImpressionVO.recPic)!=null}">
			<td>
				<img src="<%= request.getContextPath() %>/impression/impressionPic.do?impNo=${ImpressionVO.impNo} " height=50%/>
			</td>
				</c:when>
				<c:otherwise >
			<td>
			<img src="<%=request.getContextPath()%>/front-end/activity/img/nopic.jpg">
			</td>
				</c:otherwise>
			</c:choose>
			
			<td>${ImpressionVO.impField}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/impression/impression.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="impNo"  value="${ImpressionVO.getImpNo()}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/impression/impression.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="impNo"  value="${ImpressionVO.getImpNo()}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>