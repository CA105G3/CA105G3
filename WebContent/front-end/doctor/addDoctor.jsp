<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page import="com.member.model.MemberVO"%>
<%@page import="com.doctor.model.DoctorVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	DoctorVO dvo = (DoctorVO) request.getAttribute("dvo");
	String memno = (String) request.getParameter("memno");
%>

<%-- <%=dvo == null%> --%>

<%
	MemberVO memVO=null;
	memVO = (MemberVO)session.getAttribute("memVO");
	
	if(memVO!=null){
		request.getSession().setAttribute("memno",memVO.getMemNo());
	}
	 

	  
%>




<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>醫療人員資料新增 - addEmp.jsp</title>

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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
}

table, th, td {
	border: 0px solid #CCCCFF;
}

th, td {
	padding: 1px;
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



<link rel="Shortcut Icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/front-end/images/favicon.ico">

<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700"
	rel="stylesheet">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/css/animate.css">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/css/owl.carousel.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/css/owl.theme.default.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/css/magnific-popup.css">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/css/aos.css">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/css/ionicons.min.css">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/css/bootstrap-datepicker.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/css/jquery.timepicker.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front-end/css/spring.css">


<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/css/flaticon.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/css/icomoon.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/css/style.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
	integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
	crossorigin="anonymous">






<style>
.content-loader tr td {
	white-space: nowrap;
}
</style>

</head>
<body>

<%@include file="/front-end/member/includedfiles/nav.file" %>
	<section class="home-slider owl-carousel">
		<div class="slider-item"
			style="background-image: url('<%=request.getContextPath()%>/front-end/images/bg_1.jpg');">
			<div class="overlay"></div>
			<div class="container">
				<div class="row slider-text align-items-center"
					data-scrollax-parent="true">
					<div class="col-md-6 col-sm-12 ftco-animate"
						data-scrollax=" properties: { translateY: '70%' }">
						<h1 class="mb-4"
							data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">舒適的問診體驗</h1>
						<p class="mb-4"
							data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">輕鬆簡單的方式，讓您在家也能體驗醫療的好處</p>
						<p data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">
							<a href="doctors.html" class="btn btn-primary px-4 py-3">立即預約</a>
						</p>
					</div>
				</div>
			</div>
		</div>

		<div class="slider-item"
			style="background-image: url('<%=request.getContextPath()%>/front-end/images/bg_2.jpg');">
			<div class="overlay"></div>
			<div class="container">
				<div class="row slider-text align-items-center"
					data-scrollax-parent="true">
					<div class="col-md-6 col-sm-12 ftco-animate"
						data-scrollax=" properties: { translateY: '70%' }">
						<h1 class="mb-4"
							data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">專業的醫療服務</h1>
						<p class="mb-4">為家中不方便的患者所提供的線上諮詢，您一定不能錯過!!</p>
						<p>
							<a href="#" class="btn btn-primary px-4 py-3">線上預約</a>
						</p>
					</div>
				</div>
			</div>
		</div>
	</section>



	<!-- ====================================== -->
	<p>&nbsp;</p>

	<!-- 	<table id="table-1"> -->
	<!-- 		<tr> -->
	<!-- 			<td> -->
	<!-- 				<h3>醫療人員資料新增 - addDoctor.jsp</h3> -->
	<!-- 				<h4> -->
	<!-- 					<a href="selectDoctor_page.jsp"><i -->
	<!-- 						class="glyphicon glyphicon-home"></i>&nbsp;&nbsp;回首頁</a> -->
	<!-- 				</h4> -->
	<!-- 			</td> -->
	<!-- 		</tr> -->
	<!-- 	</table> -->




	<p>&nbsp;</p>
	<div class="row d-flex justify-content-center">
		<div class="col-lg-9 ">
			<%-- 錯誤表列 --%>
<%-- 			<c:if test="${not empty errorMsgs}"> --%>
<!-- 				<font style="color: red">請修正以下錯誤</font> -->
<!-- 				<ul> -->
<%-- 					<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 						<li style="color: red">${message}</li> --%>
<%-- 					</c:forEach> --%>
<!-- 				</ul> -->
<%-- 			</c:if> --%>
			<div class="panel panel-default">
				<div class="panel-heading">醫療人員資料新增</div>
				<!-- /.panel-heading -->
				<div class="panel-body">





					<form method="post"
						action="<%=request.getContextPath()%>/doctor/doctor.do"
						enctype="multipart/form-data">
						<table class="table table-striped table-borderedtable table-hover"
							id="dataTables-example">
							<tr>
								<td valign="top"><img id="output" height="250px"
									src="<%=request.getContextPath()%>/Imgs/Doctor/No-Image-Basic.png" /></td>

								<td><label class="btn btn-default"> 選擇照片 <input
										type="file" hidden name="drPic" onchange="loadFile(event)">
								</label></td>
								<td>
									<font style="color:red">${errorMsgs.photo}</font>
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

							<!-- 							<tr> -->
							<!-- 								<td>上線狀態:</td> -->
							<!-- 								<td><select size="1" name="isonline"> -->

							<%-- 										<option value="線上" ${(dvo.isonline=="線上")? 'selected':'' }>線上 --%>


							<%-- 										<option value="離線" ${(dvo.isonline=="離線")? 'selected':'' }>離線 --%>


							<!-- 								</select></td> -->
							<!-- 							</tr> -->


							<tr>
								<td>科別:</td>
								<!-- 				<td><input type="TEXT" name="major" size="45" -->
								<%-- 					value="${dvo.major}" /></td> --%>
								<%-- 									<td>${dvo.major}</td> --%>
								<td>
								<select size="1" name="major">
										<option value="家醫科" ${(dvo.major=="家醫科")? 'selected':'' }>家醫科
										<option value="外科" ${(dvo.major=="外科")? 'selected':'' }>外科
										<option value="耳鼻喉科" ${(dvo.major=="耳鼻喉科")? 'selected':'' }>耳鼻喉科
										<option value="皮膚科" ${(dvo.major=="皮膚科")? 'selected':'' }>皮膚科
										<option value="心理諮商" ${(dvo.major=="心理諮商")? 'selected':'' }>心理諮商
								</select>
								</td>
							</tr>

							<tr>
								<td>診療費用(/次):</td>
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
						<br> <input type="hidden" name="action" value="insert">
						<input type="hidden" name="memno" value="<%=memno%>"> <input
							type="hidden" name="isonline" value="線上"> <input
							type="hidden" name="status" value="審核中"> <input
							type="submit" class="btn btn-primary" value="送出新增">
					</form>


				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
	</div>
	<footer class="ftco-footer ftco-bg-dark ftco-section">
		<div class="container">
			<div class="row mb-5">
				<div class="col-md-3">
					<div class="ftco-footer-widget mb-4">
						<h2 class="ftco-heading-2">
							Plus <i class="fas fa-plus-square"></i>
						</h2>
						<p>隨著老年人口日漸增加，青壯年人口隨著少子化議題逐漸縮減，照護人力明顯失衡，我們想藉由Live++這個平台提供年長族群有個可以彼此認識、交流的管道同時又提供生理及心理方面的照護。</p>
					</div>
					<ul
						class="ftco-footer-social list-unstyled float-md-left float-lft ">
						<li class="ftco-animate"><a href="#"><span
								class="icon-twitter"></span></a></li>
						<li class="ftco-animate"><a href="#"><span
								class="icon-facebook"></span></a></li>
						<li class="ftco-animate"><a href="#"><span
								class="icon-instagram"></span></a></li>
					</ul>
				</div>
				<div class="col-md-2">
					<div class="ftco-footer-widget mb-4 ml-md-5">
						<h2 class="ftco-heading-2">快速連結</h2>
						<ul class="list-unstyled">
							<li><a href="#" class="py-2 d-block">關於我們</a></li>
							<li><a href="#" class="py-2 d-block">未來展望</a></li>
							<li><a href="#" class="py-2 d-block">發展計畫</a></li>
							<li><a href="#" class="py-2 d-block">部落格</a></li>
							<li><a href="#" class="py-2 d-block">聯絡我們</a></li>
						</ul>
					</div>
				</div>
				<div class="col-md-4 pr-md-4">
					<div class="ftco-footer-widget mb-4">
						<h2 class="ftco-heading-2">相關部落格</h2>
						<div class="block-21 mb-4 d-flex">
							<a class="blog-img mr-4"
								style="background-image: url(<%=request.getContextPath()%>/front-end/images/image_1.jpg);"></a>
							<div class="text">
								<h3 class="heading">
									<a href="#">Even the all-powerful Pointing has no control
										about</a>
								</h3>
								<div class="meta">
									<div>
										<a href="#"><span class="icon-calendar"></span> Sept 15,
											2018</a>
									</div>
									<div>
										<a href="#"><span class="icon-person"></span> Admin</a>
									</div>
									<div>
										<a href="#"><span class="icon-chat"></span> 19</a>
									</div>
								</div>
							</div>
						</div>
						<div class="block-21 mb-4 d-flex">
							<a class="blog-img mr-4"
								style="background-image: url(<%=request.getContextPath()%>/front-end/images/image_2.jpg);"></a>
							<div class="text">
								<h3 class="heading">
									<a href="#">Even the all-powerful Pointing has no control
										about</a>
								</h3>
								<div class="meta">
									<div>
										<a href="#"><span class="icon-calendar"></span> Sept 15,
											2018</a>
									</div>
									<div>
										<a href="#"><span class="icon-person"></span> Admin</a>
									</div>
									<div>
										<a href="#"><span class="icon-chat"></span> 19</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="ftco-footer-widget mb-4">
						<h2 class="ftco-heading-2">Office</h2>
						<div class="block-23 mb-3">
							<ul>
								<li><span class="icon icon-map-marker"></span><span
									class="text">中央大學，工程二館，資策會CA105G3,中壢區，台灣</span></li>
								<li><a href="#"><span class="icon icon-phone"></span><span
										class="text">30-3345678</span></a></li>
								<li><a href="#"><span class="icon icon-envelope"></span><span
										class="text">2018CA105G3@gmail.com</span></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 text-center">

					<p>
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
						Copyright &copy;
						<script>
							document.write(new Date().getFullYear());
						</script>
						All rights reserved | This template is made with <i
							class="icon-heart" aria-hidden="true"></i> by <a
							href="https://colorlib.com" target="_blank">Colorlib</a>
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
					</p>
				</div>
			</div>
		</div>
	</footer>

	<!-- loader -->
	<div id="ftco-loader" class="show fullscreen">
		<svg class="circular" width="48px" height="48px">
				<circle class="path-bg" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke="#eeeeee" />
				<circle class="path" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="modalRequest" tabindex="-1" role="dialog"
		aria-labelledby="modalRequestLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalRequestLabel">登入會員</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="#">
						<div class="form-group">
							<!-- <label for="appointment_name" class="text-black">Full Name</label> -->
							<input type="text" class="form-control" id="appointment_name"
								placeholder="使用者名稱">
						</div>
						<div class="form-group">
							<!-- <label for="appointment_email" class="text-black">Email</label> -->
							<input type="text" class="form-control" id="appointment_email"
								placeholder="密碼">
						</div>

						<div class="form-group">
							<input type="submit" value="登入" class="btn btn-primary">
							<a href="blog.html"><input type="button" value="註冊會員"
								class="btn btn-primary"></a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>




	<script
		src="<%=request.getContextPath()%>/front-end/js/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/jquery-migrate-3.0.1.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/popper.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/bootstrap.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/jquery.easing.1.3.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/jquery.waypoints.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/jquery.stellar.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/owl.carousel.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/jquery.magnific-popup.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/aos.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/jquery.animateNumber.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/bootstrap-datepicker.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/jquery.timepicker.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/scrollax.min.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/google-map.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/main.js"></script>
	<script
		src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/index.js"></script>


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
</body>
</html>