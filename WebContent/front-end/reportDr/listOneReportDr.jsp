<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.reportdr.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  ReportDrVO reportDrVO = (ReportDrVO) request.getAttribute("rdrNo"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>單筆檢舉資料 - listOneReportDr.jsp</title>

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
	width: 600px;
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

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>單筆檢舉資料 - listOneReportDr.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>檢舉編號</th>
		<th>檢舉者會員編號</th>
		<th>被檢舉之醫療人員編號</th>
		<th>檢舉理由</th>
		<th>檢舉時間</th>
		<th>處理狀態</th>

	</tr>
	<tr>
		<td>${reportDrVO.rdrNo}</td>
		<td>${reportDrVO.memNo}</td>
		<td>${reportDrVO.drNo}</td>
		<td>${reportDrVO.rdrReason}</td>	
		<td><fmt:formatDate value="${reportDrVO.rdrTime}" pattern="yyyy-MM-dd"/></td>
		<td>${reportDrVO.rdrState}</td> 
	</tr>
</table>

</body>
</html>