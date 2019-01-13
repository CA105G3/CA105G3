<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.activity.model.*"%>

<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>

<% 
	String memNo = "M0001";
	pageContext.setAttribute("memNo", memNo);
%>
<jsp:useBean id="actall_ByCompositeQuery" scope="request" type="java.util.List<ActivityVO>" /> <!-- 於EL此行可省略 -->



<html>
<head><title>複合查詢 - actall_ByCompositeQuery.jsp</title>

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
</style>

<style>
  table {
	width: 800px;
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

<h4>
☆萬用複合查詢  - 可由客戶端 select_page.jsp 隨意增減任何想查詢的欄位<br>
☆此頁作為複合查詢時之結果練習，<font color=red>已增加分頁、送出修改、刪除之功能</font></h4>
<table id="table-1">
	<tr><td>
		 <h3>查詢活動 - actall_ByCompositeQuery.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="<%=request.getContextPath()%>/front-end/activity/img/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>


<table>
	<tr>
		<th>活動編號</th>
		<th>舉辦人編號</th>
		<th>活動名稱</th>
		<th>活動地點</th>
		<th>活動時間</th>
		<th>活動狀態</th>
		<th>活動最多人數</th>
		<th>活動最少人數</th>
		<th>活動成立判定時間</th>	
		<th>活動敘述</th>
		<th>舉辦活動圖片</th>	
		<th>修改</th>	
	</tr>
	
	<%@ include file="page1_ByCompositeQuery.file" %>
	<c:forEach var="actVO" items="${actall_ByCompositeQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr align='center' valign='middle' ${(actVO.actNo==param.actNo) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色而已-->
			<td>${actVO.actNo}</td>
			<td>${actVO.memNo}</td>
			<td>${actVO.actName}</td>
			<td>${actVO.actLoc}</td>
			<td>${actVO.actTime}</td>
			<td>${actVO.actStatus}</td>
			<td>${actVO.actMax}</td>
			<td>${actVO.actLimit}</td>
			<td>${actVO.timeCheck}</td>
			<td>${actVO.actDesc}</td>
<!-- 照片			 -->
			<c:choose>
				<c:when test="${(actVO.actPic)!=null}">
			<td>
				<img src="<%= request.getContextPath()%>/activity/activityPic.do?actNo=${actVO.actNo}" height=50% weight=50%/>
			</td>
				</c:when>
				<c:otherwise>
			<td>
			<img src="<%= request.getContextPath()%>/front-end/activity/img/nopic.jpg">
			</td>
				</c:otherwise>
			</c:choose>
			
			<td>
				<form METHOD="post" action="<%=request.getContextPath()%>/activity/activity.do" style="margin-bottom: 0px;">
					<input type="submit" value="參加">
			     	<input type="hidden" name="actNo"  value="${actVO.actNo}">
			     	<input type="hidden" name="memNo"  value="${memNo}">
			     	<input type="hidden" name="actStatus"  value="${actVO.actStatus}">
			     	
			     	<input type="hidden" name="action"	value="Join_act">
				</form>
			</td>
		</tr>


	</c:forEach>
</table>
<%@ include file="page2_ByCompositeQuery.file" %>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>