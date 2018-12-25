<%@page import="java.util.Hashtable"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="com.doctoravailable.model.DravailableService"%>
<%@page import="java.util.List"%>
<%@page import="com.doctoravailable.model.DravailableVO"%>
<%@page import="com.doctor.model.DoctorVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% 
	String drno = request.getParameter("drno"); 
	pageContext.setAttribute("drno", drno); 
%>
<%-- <%=list == null%> --%>

 <%
 	List<Hashtable<String, String>> avaTime = (List<Hashtable<String, String>>) request.getAttribute("avaTime");
 	pageContext.setAttribute("avaTime", avaTime);
 %> 
<html>
<head>
<title>單一醫療人員可預約時間資料 - listSameDravailable.jsp</title>

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
				<h3>單一醫療人員可預約時間資料 - listSameDravailable.jsp</h3>
				<h4>
					<a href="selectDoctorAvailable_page.jsp"><i
						class="glyphicon glyphicon-home"></i>&nbsp;&nbsp;回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>醫療人員可預約時間編號</th>
			<th>醫療人員編號</th>
			<th>年</th>
			<th>月</th>
			<th>日</th>
			<th>時段</th>
<!-- 			<th>醫療人員照片</th> -->
		</tr>
		<c:forEach var="app" items="${avaTime}">
			<tr>
				<td>${app["dravano"]}</td>
				<td>${app["drno"]}</td>
				<td>${app["year"]}</td>
				<td>${app["month"]}</td>
				<td>${app["日期"]}</td>
				<td>${app["時段"]}</td>
			</tr>
		</c:forEach>

		<td><img width="300px" src="<%=request.getContextPath()%>/doctor/doctorImg.do?drno=${drno}" /></td>





		<!-- =========================================================================== -->

		<!-- yyyy-mm-dd -->
		<%-- <% --%>
		<!-- 		// for(DravailableVO dvo :list){ // out.println(" -->
		<!-- 		<tr> -->
		<!-- 			"); // out.println(" -->
		<!-- 			<td>" + dvo.getDravano() + "</td>"); // out.println(" -->
		<!-- 			<td>" + dvo.getDrno() + "</td>"); // out.println(" -->
		<!-- 			<td>" + dvo.getDraym().toString().substring(0, 4) + "</td>"); // -->
		<!-- 			out.println(" -->
		<!-- 			<td>" + dvo.getDraym().toString().substring(5, 7) + "</td>"); // -->
		<!-- 			//這個月有幾天 // GregorianCalendar cal = // int daysInThisMonth = -->
		<!-- 			dvo.getDraym().getMonth() // out.println(" -->
		<!-- 		</tr> -->
		<!-- 		"); -->
		<!-- 	} -->
		<!-- %> -->
	</table>


	<script src="https://code.jquery.com/jquery.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>