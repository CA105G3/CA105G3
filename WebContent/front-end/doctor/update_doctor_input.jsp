<%@ page import="com.doctor.model.DoctorVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
// 	DoctorVO dvo = (DoctorVO) request.getAttribute("dvo");
// 	String drno = (String)request.getAttribute("drno"); 
// 	pageContext.setAttribute("drno", drno);
%>
<%
// 	DoctorVO dvo = (DoctorVO) request.getAttribute("dvo");
// 	String drno = (String)request.getParameter("drno");
// 	String drno = (String)session.getAttribute("drno");
// 	pageContext.setAttribute("drno", drno);
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
<!-- 	<table id="table-1"> -->
<!-- 		<tr> -->
<!-- 			<td> -->
<!-- 				<h3>員工資料修改 - update_doctor_input.jsp</h3> -->
<!-- 				<h4> -->
<!-- 					<a href="selectDoctor_page.jsp"><i -->
<!-- 						class="glyphicon glyphicon-home"></i>&nbsp;&nbsp;回首頁</a> -->
<!-- 				</h4> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 	</table> -->

	<%-- 錯誤表列 --%>
<%-- 	<c:if test="${not empty errorMsgs}"> --%>
<!-- 		<font style="color: red">請修正以下錯誤</font> -->
<!-- 		<ul> -->
<%-- 			<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 				<li style="color: red">${message}</li> --%>
<%-- 			</c:forEach> --%>
<!-- 		</ul> -->
<%-- 	</c:if> --%>

<%@ include file="/front-end/doctor/doctorAdminNav.file"%>

	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">個人頁面</h1>
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
						<form method="post" action="doctor.do"
							enctype="multipart/form-data">
							<table
								class="table table-striped table-borderedtable table-hover"
								id="dataTables-example">
								<tr>
									<td valign="top">
									<img id="output" height="250px" src="<%=request.getContextPath()%>/doctor/doctorImg.do?drno=${dvo.drno}" /></td>

									<td>
										<label class="btn btn-default"> 選擇照片 
										<input type="file" hidden name="drPic" onchange="loadFile(event)">
										</label>
									</td>
									<td>
									<td><font style="color:red">${errorMsgs.photo}</font></td>
									</td>
								</tr>
								
								<!-- 			<tr> -->
								<!-- 				<td>醫療人員編號:<font style="color: red"><b>*</b></font></td> -->
								<%-- 				<td>${dvo.drno}</td> --%>
								<!-- 			</tr> -->
								<!-- 			<tr> -->
								<!-- 				<td>會員編號:<font style="color: red"><b>*</b></font></td> -->
								<%-- 				<td>${dvo.memno}</td> --%>
								<!-- 			</tr> -->

								<tr>
									<td>上線狀態:</td>
									<td>
										<select size="1" name="isonline">

											<option value="線上" ${(dvo.isonline=="線上")? 'selected':'' }>線上

											<option value="離線" ${(dvo.isonline=="離線")? 'selected':'' }>離線
											
										</select>
									</td>
								</tr>

								<tr>
									<td>看診權限:</td>
									<!-- 				<td><select size="1" name="status"> -->
									<%-- 						<option value="生效中" ${(dvo.status=="生效中")? 'selected':'' }>生效中 --%>
									<%-- 						<option value="失效" ${(dvo.status=="失效")? 'selected':'' }>失效 --%>
									<%-- 						<option value="審核中" ${(dvo.status=="審核中")? 'selected':'' }>審核中 --%>
									<!-- 				</select></td> -->

									<td>${dvo.status}</td>

								</tr>

								<tr>
									<td>科別:</td>
									<!-- 				<td><input type="TEXT" name="major" size="45" -->
									<%-- 					value="${dvo.major}" /></td> --%>
									<td>${dvo.major}</td>
								</tr>

								<tr>
									<td>診療費用:</td>
									<td>NT$<input type="TEXT" name="fee" size="9"
										value="${dvo.fee}" /></td>
									<td><font style="color:red">${errorMsgs.fee}</font></td>
								</tr>
								
								<tr>
									<td>經歷:</td>
									<td>
										<%-- 					<input type="TEXT" name="resume" size="45" value="${dvo.resume}" /> --%>
										<textarea name="resume" rows="10" cols="50">${dvo.resume}</textarea>
									</td>
									<td><font style="color:red">${errorMsgs.resume}</font></td>
								</tr>
<!-- 								<tr> -->
<!-- 									<td>照片:</td> -->
<!-- 									<td><img -->
<%-- 										src="<%=request.getContextPath()%>/doctor/doctorImg.do?drno=${dvo.drno}" /></td> --%>

<!-- 									<td> -->
										<!-- 					<input type="file" name="drPic" onchange="loadFile(event)">  -->
<!-- 										<label class="btn btn-primary"> 選擇照片 <input -->
<!-- 											type="file" hidden name="drPic" onchange="loadFile(event)"> -->
<!-- 									</label> -->
<!-- 									</td> -->
<!-- 								</tr> -->

<!-- 								<tr> -->
<!-- 									<td>欲修改成的照片檔</td> -->
<!-- 									<td><img id="output" /></td> -->
<!-- 								</tr> -->

							</table>

							<br> <input type="hidden" name="action" value="update">
							<input type="hidden" name="drno" value="${dvo.drno}"> <input
								type="hidden" name="memno" value="${dvo.memno}"> <input
								type="hidden" name="status" value="${dvo.status}"> <input
								type="hidden" name="major" value="${dvo.major}"> <input
								type="submit" class="btn btn-warning" value="送出修改">
						</form>

					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
	<!-- 	<FORM action="uploadDoctorPhotoServlet.do" method=post -->
	<!-- 		enctype="multipart/form-data"> -->
	<!-- 		<input type="file" name="upfile1"> <br> <input -->
	<!-- 			type="submit" value="上傳"> <input type="hidden" name="action" -->
	<!-- 			valuace="uploadDrPhoto"> -->
	<!-- 	</FORM> -->

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
</body>
</html>