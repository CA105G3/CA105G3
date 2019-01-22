<%@page import="com.member.model.MemberVO"%>
<%@page import="java.util.List"%>
<%@ page import="com.doctor.model.DoctorVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ppttool.model.*"%>


<%
	MemberVO memVO = (MemberVO)session.getAttribute("memVO");
	// 	DoctorVO dvo = (DoctorVO) request.getAttribute("dvo");
	// 	String drno = (String) request.getParameter("drno");
	String drno = (String) session.getAttribute("drno");
%>


<%
	PPTToolService ps = new PPTToolService();
	List<PPTToolVO> list = ps.getPPTsByDrno(drno); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
	pageContext.setAttribute("list", list);
%>
<html>
<head>
<title>員工資料修改 - update_doctor_input.jsp</title>

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
/* table { */
/* 	width: 450px; */
/* 	background-color: white; */
/* 	margin-top: 1px; */
/* 	margin-bottom: 1px; */
/* } */

/* table, th, td { */
/* 	border: 0px solid #CCCCFF; */
/* } */

/* th, td { */
/* 	padding: 1px; */
/* } */
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
<style>
[hidden] {
	display: none !important;
}
</style>
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
				<h1 class="page-header">看診圖片上傳</h1>
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
					<!-- <div class="container"> -->
					<!-- <div class="col-md-8 col-md-offset-2"> -->

					<table class="table table-striped table-borderedtable table-hover">
						<c:forEach var="pptVO" items="${list}" varStatus="s">
							<tr>
								<td valign="top" style="width: 50%; align: right;">
									<div>
										<img class="pull-right" id='output'
											src="<%=request.getContextPath()%>/ppt/pptImg.do?pptno=${pptVO.pptno}"
											width="300px" height="300px" />
									</div>
								</td>
								<td style="width: 50%"><label class="btn btn-danger">
										刪除照片 <input type="button" hidden name="drPic"
										onclick="location.href='<%=request.getContextPath()%>/front-end/ppt/ppt.do?action=delete&pptno=${pptVO.pptno}';">
								</label></td>
							</tr>
						</c:forEach>
					</table>
					<h3>
						新增圖片
						<c:if test="${not empty errorMsgs}">
							<c:forEach var="message" items="${errorMsgs}">
								<font style="color: red">${message}</font>
							</c:forEach>
						</c:if>

					</h3>
					<form method="POST"
						action="<%=request.getContextPath()%>/front-end/ppt/ppt.do"
						enctype="multipart/form-data">
						<!-- COMPONENT START -->
						<div class="form-group">
							<div class="input-group input-file" name="Fichier1">
								<input type="text" class="form-control"
									placeholder='Choose a file...' /> <span
									class="input-group-btn">
									<button class="btn btn-default btn-choose" type="button">Choose</button>
								</span>
							</div>
						</div>
						<!-- COMPONENT END -->
						<div class="form-group">
							<button type="submit" class="btn btn-primary pull-right">Submit</button>
							<button type="reset" class="btn btn-warning">Reset</button>
						</div>
						<input type="hidden" name="drno" value="${drno}"> <input
							type="hidden" name="action" value="uploadPPT">
					</form>



					<!-- </div> -->
					<!-- </div> -->

				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->
	</div>



	<script>
		var loadFile = function(event) {
			var reader = new FileReader();
			reader.onload = function() {
				var output = document.getElementById('output');
				output.src = reader.result;
			};
			reader.readAsDataURL(event.target.files[0]);
		};
	</script>
	<script>
		$(document).ready(function() {
			$('#dataTables-example').DataTable({
				responsive : true
			});
		});
	</script>
	<script src="https://code.jquery.com/jquery.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script>
		var loadFile = function(event) {
			var reader = new FileReader();
			reader.onload = function() {
				var output = document.getElementById('output');
				output.src = reader.result;
			};
			reader.readAsDataURL(event.target.files[0]);
		};
	</script>

	<script type="text/javascript">
		function bs_input_file() {
			$(".input-file")
					.before(
							function() {
								if (!$(this).prev().hasClass('input-ghost')) {
									var element = $("<input type='file' class='input-ghost' style='visibility:hidden; height:0'>");
									element.attr("name", $(this).attr("name"));
									element.change(function() {
										element.next(element).find('input')
												.val(
														(element.val()).split(
																'\\').pop());
									});
									$(this).find("button.btn-choose").click(
											function() {
												element.click();
											});
									$(this).find("button.btn-reset").click(
											function() {
												element.val(null);
												$(this).parents(".input-file")
														.find('input').val('');
											});
									$(this).find('input').css("cursor",
											"pointer");
									$(this).find('input').mousedown(
											function() {
												$(this).parents('.input-file')
														.prev().click();
												return false;
											});
									return element;
								}
							});
		}
		$(function() {
			bs_input_file();
		});
	</script>
	
	

</body>
</html>