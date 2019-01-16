<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.member.model.*" %>
<jsp:useBean id="memVO" scope="session" class="com.member.model.MemberVO" />

<%	
	pageContext.setAttribute("memVO", memVO);

%>

<!DOCTYPE html>
<html>

<head>
<title>basicRecord</title>
<!-- include css -->
<%@include file="/front-end/medicalOrder/includedfiles/css.file" %>

</head>
<body>

	<!-- START nav -->
	<%@include file="/front-end/medicalOrder/includedfiles/navbar.file" %>
	<!-- END nav -->

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
							個人基本病歷表
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
							個人基本病歷表
						</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<br>
<!-- 幻燈片輪播 -->


<div class="container-fluid"  style="width:85%;">
	<div class="row">
			
			<div class="col-xs-12 col-sm-3 col-lg-3">
				<%@ include file="sidebar.jsp" %>
			</div>
			
			<div class="col-xs-12 col-sm-9  col-lg-6">
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
<br>
			
				<h6 class="text-danger">*請確認病歷基本資料是否有需修正</h3>
				<form METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do" name="form1">
					
					<!-- 血型 -->
					<div class="form-group row">
						<label for="bloodType" class="col-sm-2 col-form-label">血型</label>
						<div class="col-sm-10" name="bloodType">
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="bloodType" id="bloodTypeA" value="A" ${(memVO.bloodType=="A") ? 'CHECKED' : ''}>
							  <label class="form-check-label" for="inlineRadio1">A</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="bloodType" id="bloodTypeB" value="B" ${(memVO.bloodType=="B") ? 'CHECKED' : ''}>
							  <label class="form-check-label" for="inlineRadio2">B</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="bloodType" id="bloodTypeO" value="O" ${(memVO.bloodType=="O") ? 'CHECKED' : ''}>
							  <label class="form-check-label" for="inlineRadio3">O</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="bloodType" id="bloodTypeAB" value="AB" ${(memVO.bloodType=="AB") ? 'CHECKED' : ''}>
							  <label class="form-check-label" for="inlineRadio3">AB</label>
							</div>
						</div>
					</div>

					<!-- 抽菸習慣 -->
					<div class="form-group row">
						<label for="smoking" class="col-sm-2 col-form-label">抽菸習慣</label>
						<div class="col-sm-10" name="smoking">
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="smoking" id="smokingYes" value="有" ${(memVO.smoking=="有") ? 'CHECKED' : ''}>
							  <label class="form-check-label" for="inlineRadio1">有</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="smoking" id="smokingNo" value="沒有" ${(memVO.smoking=="沒有") ? 'CHECKED' : ''}>
							  <label class="form-check-label" for="inlineRadio2">沒有</label>
							</div>
						</div>
					</div>

					<div class="form-group row">
						<label for="allergy" class="col-sm-2 col-form-label">藥物過敏</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="allergy" name="allergy"
								value="${(memVO.allergy != null) ? memVO.allergy : '' }">
							請填寫會過敏的藥物，若無請填寫「無」
						</div>
					</div>
					<div class="form-group row">
						<label for="medHistory" class="col-sm-2 col-form-label">過往病史</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="medHistory" name="medHistory"
							value="${(memVO.medHistory != null) ? memVO.medHistory : '' }">
							請填寫過去曾進行過的手術以及慢性疾病，若無請填寫「無」
						</div>
					</div>
					<div class="form-group row">
						<label for="famHistory" class="col-sm-2 col-form-label">家族病史</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="famHistory" name="famHistory"
							value="${(memVO.famHistory != null) ? memVO.famHistory : '' }">
							請填寫家族病史，若無請填寫「無」
						</div>
					</div>

					<div class="form-group row">
						<div class="col-sm-10 text-center">
							<input type="hidden" name="memId" value="${memberVO.memId}">
							<input type="hidden" name="bloodType" value="bloodType">
							<input type="hidden" name="smoking" value="smoking">
							<input type="hidden" name="allergy" value="allergy">
							<input type="hidden" name="medHistory" value="medHistory">
							<input type="hidden" name="famHistory" value="famHistory">							
							<input type="submit" class="btn bg-primary text-white" value="提交">
							<input type="hidden" name="action" value="updateBasicRecord">
						</div>
					</div>

				</form>	
			</div>

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