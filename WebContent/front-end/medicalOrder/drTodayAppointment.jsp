<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="com.medicalorder.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	String drno = (String)session.getAttribute("drno");
	MedicalOrderService mSvc = new MedicalOrderService();
	List<MedicalOrderVO> list = mSvc.getByDrnoToday(drno);
	pageContext.setAttribute("list", list);
%>

<jsp:useBean id="memSvc" scope="page"
	class="com.member.model.MemberService" />

<html>


<head>
<title>醫生歷史看診紀錄 - getMoByDrno.jsp</title>
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

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->

<!-- Bootstrap Core CSS -->
<link
	href="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link
	href="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- DataTables CSS -->
<link
	href="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link
	href="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link
	href="<%=request.getContextPath()%>/front-end/doctor/admin/dist/css/sb-admin-2.css"
	rel="stylesheet">

<!-- Custom Fonts -->
<link
	href="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">



</head>



<body>

	<%@ include file="/front-end/doctor/doctorAdminNav.file"%>


	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">今日剩餘預約</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<!-- 					<div class="panel-heading">DataTables Advanced Tables</div> -->
					<!-- /.panel-heading -->
					<!-- 					<div class="panel-body"> -->

					<table class="table table-striped table-borderedtable table-hover"
						id="dataTables-example">
						<tr>
							<th>看診單編號</th>
							<th>患者姓名</th>
							<th>診療狀態</th>
							<th>診療收入</th>
							<th>看診日期</th>
							<th>看診時段</th>
							<th>取消預約</th>
						</tr>
						<%@ include file="page1.file"%>
						<c:forEach var="mvo" items="${list}" begin="<%=pageIndex%>"
							end="<%=pageIndex+rowsPerPage-1%>">
							<tr>
								<td><a href="">${mvo.moNo}</a></td>
								<td><c:forEach var="memVO" items="${memSvc.all}">
										<c:if test="${memVO.memNo==mvo.memNo}">
	                    	${memVO.memName}
                    					</c:if>
									</c:forEach></td>
								<td>${mvo.moStatus}</td>
								<td>NT$${mvo.moCost}</td>
								<td>${mvo.moTime}</td>
								<td>${mvo.moHour}:00~${mvo.moHour + 3}:00</td>
								<td id="canceltd${s.index}">
									<form method="post"
										action="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do">
										<input type="hidden" name="moNo" value="${mvo.moNo}">
										<input type="hidden" name="action" value="cancle_medicalorder_ByDr">
										<input type="hidden" name="drno" value="${drno}">
										<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
										<input id = "${s.index}" type="submit" class="btn btn-danger" value="取消">
									</form>
								</td>
							</tr>
						</c:forEach>
					</table>


				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->
			<%@ include file="page2.file"%>
	</div>

    <!-- jQuery -->
    <script src="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/raphael/raphael.min.js"></script>
    <script src="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/morrisjs/morris.min.js"></script>
    <script src="<%=request.getContextPath()%>/front-end/doctor/admin/data/morris-data.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="<%=request.getContextPath()%>/front-end/doctor/admin/dist/js/sb-admin-2.js"></script>





	<script>
		$(document).ready(function() {
			$('#dataTables-example').DataTable({
				responsive : true
			});
		});
	</script>
</body>
</html>