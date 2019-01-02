<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="Shortcut Icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/template/images/favicon.ico">
<title>初診基本資料表</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700"
	rel="stylesheet">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template/css/animate.css">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template/css/owl.carousel.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template/css/owl.theme.default.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template/css/magnific-popup.css">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template/css/aos.css">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template/css/ionicons.min.css">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template/css/bootstrap-datepicker.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template/css/jquery.timepicker.css">


<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template/css/flaticon.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template/css/icomoon.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/template/css/style.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
	integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
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
							data-scrollax=" properties: { translateY: '70%', opacity: .9}">初診基本資料表</h1>
					</div>
				</div>
			</div>
		</div>
	</section>
	<br>
<!-- 幻燈片輪播 -->
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<%-- 錯誤表列 --%>


	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-3">
				
			</div>
			<div class="col-xs-12 col-sm-6">
				
				<form METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do" name="form1">
					
					<!-- 血型 -->
					<div class="form-group row">
						<label for="bloodType" class="col-sm-2 col-form-label">血型</label>
						<div class="col-sm-10" name="bloodType">
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="bloodType" id="bloodTypeA" value="A">
							  <label class="form-check-label" for="inlineRadio1">A</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="bloodType" id="bloodTypeB" value="B">
							  <label class="form-check-label" for="inlineRadio2">B</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="bloodType" id="bloodTypeO" value="O">
							  <label class="form-check-label" for="inlineRadio3">O</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="bloodType" id="bloodTypeAB" value="AB">
							  <label class="form-check-label" for="inlineRadio3">AB</label>
							</div>
						</div>
					</div>

					<!-- 抽菸習慣 -->
					<div class="form-group row">
						<label for="smoking" class="col-sm-2 col-form-label">抽菸習慣</label>
						<div class="col-sm-10" name="smoking">
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="smoking" id="smokingYes" value="有">
							  <label class="form-check-label" for="inlineRadio1">有</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="smoking" id="smokingNo" value="沒有">
							  <label class="form-check-label" for="inlineRadio2">沒有</label>
							</div>
						</div>
					</div>

					<div class="form-group row">
						<label for="allergy" class="col-sm-2 col-form-label">藥物過敏</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="allergy" name="allergy"
								placeholder="請填寫會過敏的藥物，若無請填寫「無」">
						</div>
					</div>
					<div class="form-group row">
						<label for="medHistory" class="col-sm-2 col-form-label">過往病史</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="medHistory" name="medHistory"
								placeholder="請填寫過去曾進行過的手術以及慢性疾病，若無請填寫「無」">
						</div>
					</div>
					<div class="form-group row">
						<label for="famHistory" class="col-sm-2 col-form-label">家族病史</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="famHistory" name="famHistory"
								placeholder="請填寫家族病史，若無請填寫「無」">
						</div>
					</div>

					<div class="form-group row">
						<div class="col-sm-10 text-center">
							<input type="submit" class="btn bg-primary text-white" value="新增">
							<input type="hidden" name="action" value="updateBasicRecord">
						</div>
					</div>

				</form>
				
				
				
			</div>
			<div class="col-xs-12 col-sm-3">
				
			</div>
		</div>
	</div>
		







	<br>
	<script src="<%=request.getContextPath()%>/template/js/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/template/js/jquery-migrate-3.0.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/template/js/popper.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/template/js/bootstrap.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/template/js/jquery.easing.1.3.js"></script>
	<script
		src="<%=request.getContextPath()%>/template/js/jquery.waypoints.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/template/js/jquery.stellar.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/template/js/owl.carousel.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/template/js/jquery.magnific-popup.min.js"></script>
	<script src="<%=request.getContextPath()%>/template/js/aos.js"></script>
	<script
		src="<%=request.getContextPath()%>/template/js/jquery.animateNumber.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/template/js/bootstrap-datepicker.js"></script>
	<script
		src="<%=request.getContextPath()%>/template/js/jquery.timepicker.min.js"></script>
	<script src="<%=request.getContextPath()%>/template/js/scrollax.min.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
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