<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="com.doctor.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<%
	//     List<DoctorVO> list = (List<DoctorVO>) request.getAttribute("list");
	// 	pageContext.setAttribute("list", list);
	String major = request.getParameter("major");
	DoctorService ds = new DoctorService();
	List<DoctorVO> list = ds.getByMajor(major);
	pageContext.setAttribute("list", list);
%>

<html>
<head>
<title>${major}醫療人員資料- getDrs_By_Major.jsp</title>
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
				<h3>${major}醫療人員資料-getDrs_By_Major.jsp</h3>
				<h4>
					<a href="selectDoctor_page.jsp"><i
						class="glyphicon glyphicon-home"></i>&nbsp;&nbsp;回首頁</a>
				</h4>
			</td>
			<td>
				<form method="post" action="<%=request.getContextPath()%>/doctor.do">
					<input type="hidden" name="memno" value="M0020"> 
					<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> 
					<input type="hidden" name="action" value="enter_dr_admin">
					<input type="submit" value="我是醫療人員"  class="btn btn-info">
				</form>
			</td>
		</tr>
	</table>

	<table class="table table-hover">
		<tr>
			<th>醫療人員編號</th>
			<th>會員編號</th>
			<th>履歷</th>
			<th>上線狀態</th>
			<th>看診權限</th>
			<th>科別</th>
			<th>診療費用</th>
			<th>照片</th>
		</tr>

		<c:forEach var="dvo" items="${list}">
			<tr>
				<td>${dvo.drno}</td>
				<td>${dvo.memno}</td>
				<td>${dvo.resume}</td>
				<td>${dvo.isonline}</td>
				<td>${dvo.status}</td>
				<td>${dvo.major}</td>
				<td>${dvo.fee}</td>
				<td><img
					src="<%=request.getContextPath()%>/doctor/doctorImg.do?drno=${dvo.drno}" /></td>
				<td>
					<form method="post" action="doctor.do">
						<input type="hidden" name="drno" value="${dvo.drno}"> <input
							type="hidden" name="action" value="getOne_For_Update"> <input
							type="submit" value="修改">
					</form>
				</td>
				<td>
					<form method="post" action="doctor.do">
						<input type="submit" value="刪除"> <input type="hidden"
							name="drno" value="${dvo.drno}"> <input type="hidden"
							name="action" value="delete">
					</form>
				</td>
			</tr>
		</c:forEach>
</body>
</html>