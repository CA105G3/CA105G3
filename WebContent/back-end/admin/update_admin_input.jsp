<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.administrator.model.*"%>

<%
	AdministratorVO  adminVO = (AdministratorVO) request.getAttribute("adminVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理員資料修改 - update_admin_input.jsp</title>
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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>
</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>管理員資料修改 - update_admin_input.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="admin.do" name="form1">
<table>
	<tr>
		<td>管理員編號:<font color=red><b>*</b></font></td>
		<td><%=adminVO.getAdminNo()%></td>
	</tr>
	<tr>
		<td>管理員名稱:</td>
		<td><input type="TEXT" name="adminid" size="45" value="<%=adminVO.getAdminId()%>" /></td>
	</tr>
	<tr>
		<td>管理員密碼:</td>
		<td><input type="TEXT" name="adminpsw" size="45"	value="<%=adminVO.getAdminPsw()%>" /></td>
	</tr>
	<tr>
		<td>管理權限:</td>
		<td><select name="priority">
			<option value="一般管理員" ${(adminVO.priority=='一般管理員')?'selected':'' }>一般管理員</option>
			<option value="可新增管理員"${(adminVO.priority=='可新增管理員')?'selected':''}>可新增管理員</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>管理員狀態:</td>
		<td><select name="status">
			<option value="生效中" ${(adminVO.status=='生效中')?'selected':'' }>生效中</option>
			<option value="已失效"${(adminVO.status=='已失效')?'selected':''}>已失效</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>註冊日期:</td>
		<td><input name="reg" id="f_date1" type="text" value="<%=adminVO.getReg()%>"readonly></td>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="adminno" value="<%=adminVO.getAdminNo()%>">
<input type="submit" value="送出修改"></FORM>
</body>
</html>