<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理員登入頁面</title>
</head>
<body>
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<h3>管理員登入頁面</h3>

<form method="post" action="admin.do">
	請輸入管理員帳號：<input type="text" name="adminId" size="15"><br>
	請輸入管理員密碼：<input type="password" name="adminPsw" size="15">
	<input type="hidden" name=action value="adminLogin">
	<input type="submit" value="送出">
</form>


</body>
</html>