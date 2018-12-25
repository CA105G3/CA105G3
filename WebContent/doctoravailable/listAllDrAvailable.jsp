<%@page import="com.doctoravailable.model.DravailableVO"%>
<%@page import="com.doctoravailable.model.DravailableService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="com.doctor.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	DravailableService ds = new DravailableService();
	List<DravailableVO> list = ds.getAll();
	pageContext.setAttribute("list", list);
%>

<html>
<head>
<title>所有醫療人員可預約時間資料 - listAllDrAvailable.jsp</title>
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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Title Page</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
</head>
<body>
	<table id="table-1">
		<tr>
			<td>
				<h3>員工資料 - ListAllDoctor.jsp</h3>
				<h4>
					<a href="selectDoctorAvailable_page.jsp"><i
						class="glyphicon glyphicon-home"></i>&nbsp;&nbsp;回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table class="table table-hover">
		<tr>
			<th>醫療人員可預約時間編號</th>
			<th>醫療人員編號</th>
			<th>年月</th>
			<th>時段</th>
		</tr>

		<c:forEach var="dvo" items="${list}">
			<tr>
				<td>${dvo.dravano}</td>
				<td>${dvo.drno}</td>
				<td>${dvo.draym}</td>
				<td>${dvo.drava}</td>
				<!-- 				<td><img width="300px" -->
				<%-- 					src="<%=request.getContextPath()%>/doctor/doctorImg.do?drno=${dvo.drno}" /></td> --%>
				<td>
					<form method="post"
						action="<%=request.getContextPath()%>/doctor/doctor.do"
						enctype="multipart/form-data">
						<input  type="hidden" name="drno" value="${dvo.drno}"> 
						<input	type="hidden" name="action" value="getOne_For_Update"> 
						<input	type="submit" value="修改">
					</form>
				</td>
				<td>
					<form method="post"
						action="<%=request.getContextPath()%>/doctor/doctor.do">
						<input type="submit" value="刪除"> 
						<input type="hidden" name="drno" value="${dvo.drno}"> 
						<input type="hidden" name="action" value="delete">
					</form>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>