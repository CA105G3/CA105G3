<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.administrator.model.*" %>
<%@ page import="java.util.*" %>
<%
	AdministratorService adminSvc = new AdministratorService();
	List<AdministratorVO> list = adminSvc.getAll();
	pageContext.setAttribute("list",list);
	
	AdministratorVO adminVO = (AdministratorVO) request.getAttribute("adminVO");
	pageContext.setAttribute("adminVO", adminVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>所有管理員資料-listAllAdmins.jsp</title>

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
<body bgcolor=#00DDDD>
<h4>此頁練習採用 EL 的寫法取值:</h4>

<table id="table-1">
	<tr><td>
		 <h3>所有管理員資料-listAllAdmins.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

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
		<th>管理員編號</th>
		<th>管理員帳號</th>
		<th>管理員密碼</th>
		<th>管理員姓名</th>
		<th>管理員權限</th>
		<th>管理員是否生效</th>
		<th>管理員註冊日期</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="adminVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
	<tr>
		<td>${adminVO.adminNo}</td>
		<td>${adminVO.adminId}</td>
		<td>${adminVO.adminPsw}</td>
		<td>${adminVO.adminName}</td>
		<td>${adminVO.priority}</td>
		<td>${adminVO.status}</td>
		<td>${adminVO.reg}</td>
		<td>
			 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/admin/admin.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="adminno"  value="${adminVO.adminNo}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
		</td>
		<td>
			 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/admin/admin.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="adminno"  value="${adminVO.adminNo}">
			     <input type="hidden" name="action" value="delete"></FORM>
		</td>
	</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>
</body>
</html>