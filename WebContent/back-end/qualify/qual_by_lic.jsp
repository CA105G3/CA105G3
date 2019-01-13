<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.license.model.*"%>

<jsp:useBean id="qual_by_lic" scope="request" type="java.util.Set<QualifyVO>" />
<jsp:useBean id="licenseSvc" scope="page" class="com.license.model.LicenseService" />


<html>
<head><title>資格驗證 - qual_by_lic.jsp</title>

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
	width: 100%;
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
<Form>
<table id="table-2">
	<tr><td>
		 <h3>資格驗證 - qual_by_lic.jsp</h3>
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
		<th>會員狀態</th>
	</tr>
	
<c:forEach var="qualifyVO" items="${qual_by_lic}" >
	<form METHOD="post" action="<%=request.getContextPath()%>/license/license.do" style="margin-bottom: 0px;">
		<tr>
			<td>${qualifyVO.licNo}</td>
			<td>${qualifyVO.memNo}</td>
<!-- 照片	 -->
			<c:choose>
				<c:when test="${(qualifyVO.licData)!=null}">
			<td>
				<img src="<%= request.getContextPath() %>/license/licensePic.do?licNo=${qualifyVO.licNo} " height=50%/>
			</td>
				</c:when>
				<c:otherwise >
			<td>
			<img src="<%=request.getContextPath()%>/front-end/activity/img/nopic.jpg">
			</td>
				</c:otherwise>
			</c:choose>
			<td>${qualifyVO.licStatus}</td>
			<td>${qualifyVO.licDesc}</td>
			<td>${qualifyVO.licDue}</td>
			<td>
					<select name="ident">
						<option value="一般會員" ${"一般會員"==qualifyVO.ident}?selected:"" }>一般會員</option>
						<option value="醫療人員" ${"醫療人員"==qualifyVO.ident}?selected:"" }>醫療人員</option>
						<option value="餐飲業者" ${"餐飲業者"==qualifyVO.ident}?selected:"" }>餐飲業者</option>
					</select>

			</td>
			<td>
				
					<input type="submit" value="確認">
			     	<input type="hidden" name="licNo"  value="${qualifyVO.licNo}">
			     	<input type="hidden" name="memNo"  value="${qualifyVO.memNo}">
			     	<input type="hidden" name="licStatus"  value="${qualifyVO.licStatus}">
			     	<input type="hidden" name="action"	value="getOne_For_Update">
			
			</td>
		</tr>
	</form>	
	</c:forEach>
</table>
</Form>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>