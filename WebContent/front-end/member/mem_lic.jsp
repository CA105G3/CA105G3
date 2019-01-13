<%@page import="com.license.model.LicenseVO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>

<jsp:useBean id="mem_lic" scope="request" type="java.util.Set<LicenseVO>" /> <!-- 於EL此行可省略 -->
<jsp:useBean id="activitySvc" scope="page" class="com.member.model.MemberService" />


<html>
<head><title>證照 - mem_lic.jsp</title>

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
	<tr><td>
		 <h3>證照內容 - mem_lic.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/license/licensesearch.jsp"><img src="<%=request.getContextPath()%>/front-end/activity/img/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
		<th>證照編號</th>
		<th>會員編號</th>
		<th>證照資料</th>
		<th>證照狀態</th>
		<th>證照描述</th>
		<th>證照時效</th>	
		<th>修改</th>	
		<th>刪除</th>
	</tr>
	
	<c:forEach var="licenseVO" items="${mem_lic}" >
		<tr>
			<td>${licenseVO.licNo}</td>
			<td>${licenseVO.memNo}</td>
<!-- 照片			 -->
			<c:choose>
				<c:when test="${(licenseVO.licData)!=null}">
			<td>
				<img src="<%= request.getContextPath() %>/license/licensePic.do?licNo=${licenseVO.licNo} " height=50%/>
			</td>
				</c:when>
				<c:otherwise >
			<td>
			<img src="<%=request.getContextPath()%>/front-end/activity/img/nopic.jpg">
			</td>
				</c:otherwise>
			</c:choose>
			<td>${licenseVO.licStatus}</td>
			<td>${licenseVO.licDesc}</td>
			<td>${licenseVO.licDue}</td>

			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/license/license.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="licNo"  value="${licenseVO.getLicNo()}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/license/license.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="licNo"  value="${licenseVO.getLicNo()}">
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