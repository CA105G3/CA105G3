<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.doctor.model.DoctorVO"%>
<%@page import="com.member.model.MemberVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="doctorVO" scope="page" class="com.doctor.model.DoctorVO" />
<jsp:useBean id="doctorSvc" scope="page" class="com.doctor.model.DoctorService" />
<jsp:useBean id="memberVO" scope="page" class="com.member.model.MemberVO" />
<jsp:useBean id="memberSvc" scope="page" class="com.member.model.MemberService"/>
<%
	HashMap reserveMap = (HashMap)request.getAttribute("reserveMap");
	pageContext.setAttribute("reserveMap", reserveMap);	
%>
<!DOCTYPE html>

<html lang="en">
<head>
<link rel="Shortcut Icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/template/images/favicon.ico">
<title>checkReserve</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700" rel="stylesheet">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/animate.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/owl.carousel.min.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/owl.theme.default.min.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/magnific-popup.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/aos.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/ionicons.min.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/bootstrap-datepicker.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/jquery.timepicker.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/flaticon.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/icomoon.css">
<link rel="stylesheet"	href="<%=request.getContextPath()%>/template/css/style.css">
<link rel="stylesheet"	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"	integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
	crossorigin="anonymous">
<style>
.btn {
	border-radius: 0
}
</style>

</head>
<body>

	<nav
		class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light"
		id="ftco-navbar">
		<div class="container">
			<a class="navbar-brand"
				href="<%=request.getContextPath()%>/template/index.html">Plus <i
				class="fas fa-plus-square"></i></a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#ftco-nav" aria-controls="ftco-nav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="oi oi-menu"></span> Menu
			</button>

			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item "><a
						href="<%=request.getContextPath()%>/template/index.html"
						class="nav-link">回到首頁</a></li>
					<li class="nav-item"><a
						href="<%=request.getContextPath()%>/template/food.html"
						class="nav-link">送餐專區</a></li>
					<li class="nav-item"><a
						href="<%=request.getContextPath()%>/template/doctors.html"
						class="nav-link">線上問診</a></li>
					<li class="nav-item"><a href="../impression/impsearch.jsp"
						class="nav-link">活動專區</a></li>
					<li class="nav-item"><a
						href="<%=request.getContextPath()%>/template/contact.html"
						class="nav-link">聯繫我們</a></li>
					<li class="nav-item cta"><a
						href="<%=request.getContextPath()%>/template/contact.html"
						class="nav-link" data-toggle="modal" data-target="#modalRequest"><span>登入</span></a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- END nav -->

	<section class="home-slider owl-carousel">
		<div class="slider-item bread-item"
			style="background-image: url('<%=request.getContextPath()%>/template/images/bg_1.jpg');"
			data-stellar-background-ratio="0.5">
			<div class="overlay"></div>
			<div class="container" data-scrollax-parent="true">
				<div class="row slider-text align-items-end">
					<div class="col-md-7 col-sm-12 ftco-animate mb-5">
						<h1 class="mb-3"
							data-scrollax=" properties: { translateY: '70%', opacity: .9}">會員病例歷史紀錄</h1>
					</div>
				</div>
			</div>
		</div>
	</section>
	<br>
<!-- 幻燈片輪播 -->

<div class="container">
	<div class="row">
		<table class="table table-striped table-bordered">
		    <thead>
			    <tr  align='center'>
			      <th scope="col">醫生姓名</th>
			      <th scope="col">看診時間</th>
			      <th scope="col">看診時段</th>
			      <th scope="col">看診費用</th>
			      <th scope="col">病況說明</th>
			      <th scope="col"></th>
			     </tr>
			</thead> 
			<tbody>
<form method="post" action="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do">
				<tr>
			      <td scope="col" class="text-center">${memberSvc.getOneMember(doctorSvc.getOneDoctor(reserveMap.drno).memno).memName}</td>
			      <td scope="col" class="text-center">${reserveMap.year}/${reserveMap.month}/${reserveMap.date}</td>
			      <td scope="col" class="text-center">${reserveMap.hour}</td>
			      <td scope="col" class="text-center">${doctorSvc.getOneDoctor(reserveMap.drno).fee}</td>
			      <td scope="col"><input type="text" name="moIntro" size="70"></td>
			      <td scope="col"> 	
					<input type="hidden" name="drno" value="${reserveMap.drno}">  
					<input type="hidden" name="year" value="${reserveMap.year}"> 
					<input type="hidden" name="month" value="${reserveMap.month}">
					<input type="hidden" name="date" value="${reserveMap.date}">
					<input type="hidden" name="hour" value="${reserveMap.hour}">
					<input type="hidden" name="fee" value="${doctorSvc.getOneDoctor(reserveMap.drno).fee}">			
					<input type="hidden" name="moIntro" value="moIntro">
					<input type="hidden" name="action" value="insertMo"> 
					<input type="submit" class="btn bg-primary text-white" value="確定預約">   
		      	  </td>
		      	</tr>
		    </tbody>
</form>   
</table>
	</div>
</div>
<!-- <table> -->
<!--      <tr> -->
<!--       <th>醫生姓名</th> -->
<!--       <th>看診時間</th> -->
<!--       <th>看診時段</th> -->
<!--       <th>看診費用</th> -->
<!--       <th>病況說明</th> -->
<!--       <th>確定預約</th> -->
<!--      </tr> -->
<!--     <tr> -->
<%-- 		<form method="post" action="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do"> --%>
<%-- 	      <td>${memberSvc.getOneMember(doctorSvc.getOneDoctor(reserveMap.drno).memno).memName}</td> --%>
<%-- 	      <td>${reserveMap.year}/${reserveMap.month}/${reserveMap.date}</td> --%>
<%-- 	      <td>${reserveMap.hour}</td> --%>
<%-- 	      <td>${doctorSvc.getOneDoctor(reserveMap.drno).fee}</td> --%>
<!-- 	      <td><input type="text" name="moIntro"></td> -->
<!-- 	      <td> 	 -->
<%-- 			<input type="hidden" name="drno" value="${reserveMap.drno}">   --%>
<%-- 			<input type="hidden" name="year" value="${reserveMap.year}">  --%>
<%-- 			<input type="hidden" name="month" value="${reserveMap.month}"> --%>
<%-- 			<input type="hidden" name="date" value="${reserveMap.date}"> --%>
<%-- 			<input type="hidden" name="hour" value="${reserveMap.hour}"> --%>
<%-- 			<input type="hidden" name="fee" value="${doctorSvc.getOneDoctor(reserveMap.drno).fee}">			 --%>
<!-- 			<input type="hidden" name="moIntro" value="moIntro"> -->
<!-- 			<input type="hidden" name="action" value="insertMo">  -->
<!-- 			<input type="submit" value="確定預約">    -->
<!--       	  </td> -->
<!--       	</form>    -->
<!--     </tr> -->
<!--   </tbody> -->
<!-- </table> -->
	


	<br>
	<script src="<%=request.getContextPath()%>/template/js/jquery.min.js"></script>
	<script	src="<%=request.getContextPath()%>/template/js/jquery-migrate-3.0.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/template/js/popper.min.js"></script>
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
	<script src="<%=request.getContextPath()%>/template/js/scrollax.min.js"></script>
	<script	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<script src="<%=request.getContextPath()%>/template/js/google-map.js"></script>
	<script src="<%=request.getContextPath()%>/template/js/main.js"></script>
	<!--以下可改動-->
</body>
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
							style="background-image: url(images/image_1.jpg);"></a>
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
							style="background-image: url(images/image_2.jpg);"></a>
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
</html>