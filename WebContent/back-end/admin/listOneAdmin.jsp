<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.administrator.model.*"%>

<%
	AdministratorVO adminVO = (AdministratorVO) request.getAttribute("adminVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
	pageContext.setAttribute("adminVO", adminVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理員資料 - listOneAdmin.jsp</title>

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
		 <h3>管理員資料 - ListOneAdmin.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>管理員編號</th>
		<th>管理員名稱</th>
		<th>管理員密碼</th>
		<th>管理員權限</th>
		<th>管理員是否生效</th>
		<th>管理員註冊日期</th>
		
	</tr>
	<tr>
		<td><%=adminVO.getAdminNo()%></td>
		<td><%=adminVO.getAdminId()%></td>
		<td><%=adminVO.getAdminPsw()%></td>
		<td><%=adminVO.getPriority()%></td>
		<td><%=adminVO.getStatus()%></td>
		<td><%=adminVO.getReg()%></td>		
	</tr>
</table>

</body>
</html>