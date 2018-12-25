<%@page import="com.doctor.model.DoctorVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	DoctorVO dvo = (DoctorVO) request.getAttribute("dvo");
%>
<html>
<head>
<title>醫生資料 - listOneDoctor.jsp</title>

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
				<h3>員工資料 - ListOneEmp.jsp</h3>
				<h4>
					<a href="selectDoctor_page.jsp"><i
						class="glyphicon glyphicon-home"></i>&nbsp;&nbsp;回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>醫療人員編號</th>
			<th>會員編號</th>
			<th>履歷</th>
			<th>上線狀態</th>
			<th>看診權限</th>
			<th>科別</th>
			<th>費用</th>
			<th>照片</th>
		</tr>
		<tr>
			<td><%=dvo.getDrno()%></td>
			<td><%=dvo.getMemno()%></td>
			<td><%=dvo.getResume()%></td>
			<td><%=dvo.getIsonline()%></td>
			<td><%=dvo.getStatus()%></td>
			<td><%=dvo.getMajor()%></td>
			<td><%=dvo.getFee()%></td>
			<td><img width="300px" src="<%=request.getContextPath()%>/doctor/doctorImg.do?drno=${dvo.drno}"/></td>
		</tr>
	</table>


	<script src="https://code.jquery.com/jquery.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>