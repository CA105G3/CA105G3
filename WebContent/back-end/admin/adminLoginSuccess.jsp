<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.administrator.model.*"%>
<%
	AdministratorVO adminVO = (AdministratorVO) request.getAttribute("adminVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
	pageContext.setAttribute("adminVO", adminVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登入成功頁面</title>
</head>
<body>
			       <h3> 登入成功的頁面 - login_success.jsp           </h3> 
				   <h3> 歡迎:<font color=red> ${adminVO.adminName} </font>您好</h3>



</body>
</html>