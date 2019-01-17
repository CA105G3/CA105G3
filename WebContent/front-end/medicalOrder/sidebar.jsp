<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<div class="list-group">
		<a
			class="list-group-item list-group-item-action bg-primary text-white">問診相關連結</a>
		<a
			class="list-group-item list-group-item-action list-group-item-light"
			href="ScanDoctor.jsp">瀏覽所有醫生</a> <a
			class="list-group-item list-group-item-action list-group-item-light"
			href="getMedicalOrderFromMember.jsp">個人看診紀錄</a>
		<form method="post" action="<%=request.getContextPath()%>/doctor.do">
			<input type="hidden" name="memno" value="${memno}"> <input
				type="hidden" name="requestURL"
				value="<%=request.getServletPath()%>"> <input type="hidden"
				name="action" value="enter_dr_admin"> <input id="drbtn"
				type="submit" value="我是醫療人員" class="btn btn-info">
		</form>
	</div>
</body>
</html>