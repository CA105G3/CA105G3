<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.doctor.model.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="doctorVO" scope="page" class="com.doctor.model.DoctorVO" />
<jsp:useBean id="doctorSvc" scope="page" class="com.doctor.model.DoctorService" />
<jsp:useBean id="memberVO" scope="page" class="com.member.model.MemberVO" />
<jsp:useBean id="memberSvc" scope="page" class="com.member.model.MemberService"/>

<!DOCTYPE html>
<html lang="en">
<head>
<link rel="Shortcut Icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/template/images/favicon.ico">
<title>瀏覽醫生</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700"
	rel="stylesheet">
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
<link rel="stylesheet"	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
	integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
	crossorigin="anonymous">
<style>
.btn {
	border-radius: 0
}

.wrapper {
    display: flex;
    align-items: stretch;
}

#sidebar {
    min-width: 250px;
    max-width: 250px;
}

#sidebar.active {
    margin-left: -250px;
}
</style>



</head>
<body>

	<div>
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
	</div>
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
							data-scrollax=" properties: { translateY: '70%', opacity: .9}">瀏覽醫生</h1>
					</div>
				</div>
			</div>
		</div>
	</section>
	<br>
<!-- 幻燈片輪播 -->
	<div>
	
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-2"></div>
			<div class="col-xs-12 col-sm-2"></div>
			<div class="col-xs-12 col-sm-2"></div>
			<div class="col-xs-12 col-sm-2"></div>
			<div class="col-xs-12 col-sm-2 ">
				<button type="button" class="btn btn-light text-primary">
				<a href="#" class="text-primary pull-right">醫生管理頁面</a>
				</button>
			</div>
		</div>
	</div>


	<section class="ftco-section">
      <div class="container">
      	<div class="row justify-content-center mb-5 pb-5">
          <div class="col-md-7 text-center heading-section ftco-animate">
            <h2 class="mb-3">Meet Our Experience Dentist</h2>
            <p>A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences</p>
          </div>
        </div>
      </div>
      <div class="wrapper">
    <!-- Sidebar -->
    <nav id="sidebar">
        <div class="sidebar-header">
            <h3>Bootstrap Sidebar</h3>
        </div>

        <ul class="list-unstyled components">
            <p>Dummy Heading</p>
            <li class="active">
                <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Home</a>
                <ul class="collapse list-unstyled" id="homeSubmenu">
                    <li>
                        <a href="#">Home 1</a>
                    </li>
                    <li>
                        <a href="#">Home 2</a>
                    </li>
                    <li>
                        <a href="#">Home 3</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="#">About</a>
            </li>
            <li>
                <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Pages</a>
                <ul class="collapse list-unstyled" id="pageSubmenu">
                    <li>
                        <a href="#">Page 1</a>
                    </li>
                    <li>
                        <a href="#">Page 2</a>
                    </li>
                    <li>
                        <a href="#">Page 3</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="#">Portfolio</a>
            </li>
            <li>
                <a href="#">Contact</a>
            </li>
        </ul>
    </nav>

</div>
    </section>
    



        <div class="row">
<c:forEach var="doctorVO" items="${doctorSvc.all}">
        	<div class="col-lg-3 col-md-6 d-flex mb-sm-4 ftco-animate">
        		<div class="staff">
      				<div class="img mb-4" 
						style="background-image: url(<%=request.getContextPath()%>/doctor/doctorImg.do?drno=${doctorVO.drno});"></div>
      				<div class="info text-center">
      					<h3><a href="teacher-single.html">
      						<c:forEach var="memberVO" items="${memberSvc.all}">
      							<c:if test="${memberVO.memNo==doctorVO.memno}">
      								${memberVO.memName}
      							</c:if>
      						</c:forEach>
      					</a></h3>
      					<span class="position">${doctorVO.major}</span>
      				</div>
        		</div>
        	</div>
</c:forEach>
        </div>

	</div>


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