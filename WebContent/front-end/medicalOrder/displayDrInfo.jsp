<%@page import="com.doctor.model.DoctorVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- <%  --%>
<!-- // 	String month = (String) request.getAttribute("month"); -->
<%-- %> --%>

<%
	DoctorVO dvo = (DoctorVO) request.getAttribute("dvo");
%>

<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemberService" />

<%@page import="com.doctoravailable.model.DravailableService"%>
<%@page import="com.doctoravailable.model.DravailableVO"%>
<%@page import="com.doctor.model.DoctorVO"%>


<%
	String drno = dvo.getDrno();
	String month = (String) request.getAttribute("month");
	List<Map> avaTime;	

	if(month.equals("thismonth")){
		avaTime = HandleDravailable.GetDravaThismonthByDrno(drno);
	}else{
		avaTime = HandleDravailable.GetDravaNextmonthByDrno(drno);
	}
	pageContext.setAttribute("avaTime", avaTime);

%>

<%@ include file="calendarCommon.jsp"%>

<html>
<head>
<link rel="Shortcut Icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/template/images/favicon.ico">
<title>醫生個人簡介</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Title Page</title>
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->

<link rel="Shortcut Icon" type="image/x-icon" href="<%=request.getContextPath()%>/front-end/doctor/template/images/favicon.ico">
<link	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700" rel="stylesheet">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/animate.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/owl.carousel.min.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/owl.theme.default.min.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/magnific-popup.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/aos.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/ionicons.min.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/bootstrap-datepicker.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/jquery.timepicker.css">
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
<link rel="stylesheet" type="text/css"	href="<%=request.getContextPath()%>/template/css/spring.css">


<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/flaticon.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/icomoon.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/style.css">
<link rel="stylesheet"	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
	integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
	crossorigin="anonymous">


<!-- ===================================== -->


<style>
.content-loader tr td {
    white-space: nowrap;
}
</style>


</head>

<body>
	<nav
		class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light"
		id="ftco-navbar">
		<div class="container">
			<a class="navbar-brand" href="index.html">Plus <i
				class="fas fa-plus-square"></i></a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#ftco-nav" aria-controls="ftco-nav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="oi oi-menu"></span> Menu
			</button>

			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav ml-auto">

					<li class="nav-item"><a href="food.html" class="nav-link">送餐專區</a></li>
					<li class="nav-item"><a href="doctors.html" class="nav-link">線上問診</a></li>
					<li class="nav-item"><a href="../impression/impsearch.jsp"
						class="nav-link">活動專區</a></li>
					<li class="nav-item"><a href="contact.html" class="nav-link">聯繫我們</a></li>
					<li class="nav-item cta"><a href="contact.html"
						class="nav-link" data-toggle="modal" data-target="#modalRequest"><span>登入</span></a></li>
				</ul>
			</div>
		</div>
	</nav>

	<section class="home-slider owl-carousel">
		<div class="slider-item"
			style="background-image: url('<%=request.getContextPath()%>/template/images/bg_1.jpg');">
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
							<h1>醫生個人簡介</h1>
						</p>
					</div>
				</div>
			</div>
		</div>

		<div class="slider-item"
			style="background-image: url('<%=request.getContextPath()%>/template/images/bg_2.jpg');">
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
							醫生個人簡介
						</p>
					</div>
				</div>
			</div>
		</div>
	</section>



	<!-- ====================================== -->
<br>
<br>
<!-- 左邊側邊欄+右邊醫生介紹 -->
<div class="container-fluid">
    <div class="row">
		
<!-- 左邊側邊欄 -->
		<div class="col-xs-12 col-sm-3 ">
			<%@ include file="sidebar.jsp" %>
		</div>

<!-- 右邊醫生介紹 -->
		<div class="col-xs-12 col-sm-9" >

<p>&nbsp;</p>
	<div class="row d-flex justify-content-center">
		<div class="col-lg-8 ">
			<div class="panel panel-default">
				<div class="panel-heading">
					<c:if test="${dvo.isonline == '線上'}">
	                    <span aria-label="目前在線上" style="background: rgb(66, 183, 42); border-radius: 50%; display: inline-block; height: 6px; margin-left: 4px; width: 6px;"></span> 
                    </c:if>
                    
                    <c:if test="${dvo.isonline != '線上'}">
                    	<span aria-label="目前離線" style="background: rgb(128, 128, 128); border-radius: 50%; display: inline-block; height: 6px; margin-left: 4px; width: 6px;"></span> 
                    </c:if>
					
					
					<%=dvo.getIsonline()%>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">

					<table width="100%" border="0" cellpadding="2" cellspacing="0"> 
						<tr>
							<td class="content-loader" valign="top"><img width="170" height="200"
								src="<%=request.getContextPath()%>/doctor/doctorImg.do?drno=${dvo.drno}"></td>
							<td class="content-loader align-top" align="left" >
								<table
									class="table table-striped table-borderedtable table-hover"
									width="100%" border="0" cellpadding="2" cellspacing="0" >
									<tr>
										<td align="left" valign="top" class="Content-text-bold">姓名:</td>
										<td class="Content-text">
											<c:forEach var="memVO" items="${memSvc.all}">
												<c:if test="${memVO.memNo==dvo.memno}">${memVO.memName}醫師</c:if>
											</c:forEach></td>
									</tr>
									<tr>
										<td align="left" valign="top" class="Content-text-bold">科別:</td>
										<td class="Content-text"><%=dvo.getMajor()%></td>
									</tr>
									<tr>
										<td align="left" valign="top" class="Content-text-bold">診療費用:</td>
										<td class="Content-text">NT$<%=dvo.getFee()%>/次</td>
									</tr>
									<tr>
										<td width="117" align="left" valign="top"
											class="Content-text-bold" style="word-break: break-all;width:60%x`">經歷:</td>
										<td width="618" class="Content-text"><%=dvo.getResume()%>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<div>
		
		</div>
	</div>
</div>


<!-- include進來的月曆 -->
<div class="container-fluid">
    <div class="row">
		<c:if test="${month == 'thismonth'}">
			<%@ include file="calendarMonthThisView.jsp" %>
		</c:if>
		<c:if test="${month == 'nextmonth'}">
			<%@ include file="calendarMonthNextView.jsp" %>
		</c:if>			
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
									style="background-image: url(<%=request.getContextPath()%>/front-end/doctor/template/images/image_1.jpg);"></a>
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
									style="background-image: url(<%=request.getContextPath()%>/front-end/doctor/template/images/image_2.jpg);"></a>
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
		
		<script	src="<%=request.getContextPath()%>/template/js/jquery.min.js"></script>
		<script	src="<%=request.getContextPath()%>/template/js/jquery-migrate-3.0.1.min.js"></script>
		<script	src="<%=request.getContextPath()%>/template/js/popper.min.js"></script>
		<script	src="<%=request.getContextPath()%>/template/js/bootstrap.min.js"></script>
		<script	src="<%=request.getContextPath()%>/template/js/jquery.easing.1.3.js"></script>
		<script	src="<%=request.getContextPath()%>/template/js/jquery.waypoints.min.js"></script>
		<script	src="<%=request.getContextPath()%>/template/js/jquery.stellar.min.js"></script>
		<script	src="<%=request.getContextPath()%>/template/js/owl.carousel.min.js"></script>
		<script	src="<%=request.getContextPath()%>/template/js/jquery.magnific-popup.min.js"></script>
		<script src="<%=request.getContextPath()%>/template/js/aos.js"></script>
		<script	src="<%=request.getContextPath()%>/template/js/jquery.animateNumber.min.js"></script>
		<script	src="<%=request.getContextPath()%>/template/js/bootstrap-datepicker.js"></script>
		<script	src="<%=request.getContextPath()%>/template/js/jquery.timepicker.min.js"></script>
		<script	src="<%=request.getContextPath()%>/template/js/scrollax.min.js"></script>
		<script	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
		<script	src="<%=request.getContextPath()%>/template/js/google-map.js"></script>
		<script src="<%=request.getContextPath()%>/template/js/main.js"></script>
		<script	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
		<script	src="<%=request.getContextPath()%>/template/js/index.js"></script>
		<script src="https://code.jquery.com/jquery.js"></script>
		<script	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>