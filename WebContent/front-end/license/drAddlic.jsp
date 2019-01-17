<%@page import="com.member.model.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.license.model.*"%>

<%
	MemberVO memVO = (MemberVO) session.getAttribute("memVO");
	LicenseVO licenseVO = (LicenseVO) request.getAttribute("licenseVO");
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
	<%@include file="/front-end/member/includedfiles/nav.file"%>





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
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<div class="row d-flex justify-content-center">
		<div class="col-lg-9 ">
			<div class="panel panel-default">
				<div class="panel-heading">醫療人員資料新增</div>

				<!-- /.panel-heading -->
				<div class="panel-body">




					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/license/license.do"
						name="form1" enctype="multipart/form-data">
						<table class="table table-striped table-borderedtable table-hover"
							id="dataTables-example">
							<tr>
								<td>會員編號:</td>
								<td>
<!-- 									<input type="TEXT" name="memNo" size="45" -->
<%-- 										value="<%=(licenseVO == null) ? "M" : licenseVO.getMemNo()%>" /> --%>
										${memno}
									
								</td>
							</tr>
							<tr>
								<td>證照狀態:</td>
								<td><input type="TEXT" name="licStatus" size="45"
									value="<%=(licenseVO == null) ? "審核中" : licenseVO.getLicStatus()%>" /></td>
							</tr>
							<tr>
								<td>證照描述:</td>
								<td><input type="TEXT" name="licDesc" size="45"
									value="<%=(licenseVO == null) ? "" : licenseVO.getLicDesc()%>" /></td>
							</tr>
							<tr>
								<td>證照時效:</td>
								<td><input id="f_date1" name="licDue" size="45"
									value="<%=(licenseVO == null) ? "" : licenseVO.getLicDue()%>" />
								</td>
							</tr>

							<tr>
								<td>證照上傳:</td>
								<td><img
									src="<%=request.getContextPath()%>/front-end/license/img/nopic.jpg"
									id="output" width=50% height=60% /> <input type="file"
									name="licData" size="45" onchange="loadFile(event)"></td>

							</tr>


						</table>
						<br> 
						<input type="hidden" name="action" value="insert">
						<input type="hidden" name="" value="insert">
						<input type="submit" value="送出新增">
					</FORM>













				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
	</div>


	<!-- ===================================================================== -->

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



	<!-- 			================================================ -->

	<script>
		var loadFile = function(event) {
			var reader = new FileReader();
			reader.onload = function() {
				var output = document.getElementById("output");
				output.src = reader.result;
			};
			reader.readAsDataURL(event.target.files[0]);
		};
	</script>
	<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

	<%
		java.sql.Date licDue = null;
		try {
			licDue = licenseVO.getLicDue();
		} catch (Exception e) {
			licDue = new java.sql.Date(System.currentTimeMillis());
		}
	%>
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.css" />
	<script
		src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.full.js"></script>

	<script>
		$.datetimepicker.setLocale('zh');
		$('#f_date1').datetimepicker({
			theme : '', //theme: 'dark',
			timepicker : false, //timepicker:true,
			step : 1, //step: 60 (這是timepicker的預設間隔60分鐘)
			format : 'Y-m-d', //format:'Y-m-d H:i:s',
			value : '', // value:   new Date(),
		//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
		//startDate:	            '2017/07/10',  // 起始日
		//minDate:               '-1970-01-01', // 去除今日(不含)之前
		//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
		});

		// ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

		//      1.以下為某一天之前的日期無法選擇
		//      var somedate1 = new Date('2017-06-15');
		//      $('#f_date1').datetimepicker({
		//          beforeShowDay: function(date) {
		//        	  if (  date.getYear() <  somedate1.getYear() || 
		//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
		//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
		//              ) {
		//                   return [false, ""]
		//              }
		//              return [true, ""];
		//      }});

		//      2.以下為某一天之後的日期無法選擇
		//      var somedate2 = new Date('2017-06-15');
		//      $('#f_date1').datetimepicker({
		//          beforeShowDay: function(date) {
		//        	  if (  date.getYear() >  somedate2.getYear() || 
		//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
		//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
		//              ) {
		//                   return [false, ""]
		//              }
		//              return [true, ""];
		//      }});

		//      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
		//      var somedate1 = new Date('2017-06-15');
		//      var somedate2 = new Date('2017-06-25');
		//      $('#f_date1').datetimepicker({
		//          beforeShowDay: function(date) {
		//        	  if (  date.getYear() <  somedate1.getYear() || 
		//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
		//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
		//		             ||
		//		            date.getYear() >  somedate2.getYear() || 
		//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
		//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
		//              ) {
		//                   return [false, ""]
		//              }
		//              return [true, ""];
		//      }});
	</script>
</body>
</html>