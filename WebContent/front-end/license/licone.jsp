<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.license.model.*"%>

<% LicenseVO licenseVO = (LicenseVO)request.getAttribute("licenseVO");%>

<html>
<head>

<title>活動資料-actone.jsp</title>
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

<table id="table-1">
	<tr><td>
		 <h3>證照資料 - licone.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/license/licensesearch.jsp"><img src="<%=request.getContextPath()%>/front-end/license/img/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>證照編號</th>
		<th>會員編號</th>
		<th>證照資料</th>
		<th>證照狀態</th>
		<th>證照描述</th>
		<th>證照時效</th>	
		<th>修改</th>	
		
	</tr>
	
		<tr>
			<td>${licenseVO.licNo}</td>
			<td>${licenseVO.memNo}</td>
<!-- 照片	 -->
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
				<form METHOD="post" action="<%=request.getContextPath()%>/license/license.do" style="margin-bottom: 0px;">
					<input type="submit" value="修改">
			     	<input type="hidden" name="licNo"  value="${licenseVO.licNo}">
			     	<input type="hidden" name="action"	value="getOne_For_Update">
				</form>
				
			  	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/license/license.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="licNo"  value="${licenseVO.licNo}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
</table>


</body>
</html>