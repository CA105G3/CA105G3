<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.doctor.model.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="doctorVO" scope="page" class="com.doctor.model.DoctorVO" />
<jsp:useBean id="doctorSvc" scope="page" class="com.doctor.model.DoctorService" />
<jsp:useBean id="memberVO" scope="page" class="com.member.model.MemberVO" />
<jsp:useBean id="memberSvc" scope="page" class="com.member.model.MemberService"/>


<%	
	MemberVO memVO = (MemberVO)session.getAttribute("memVO");
%>

<!DOCTYPE html>
<html>
<head>
<!-- included css  -->
<title >ScanDoctor</title>
<%@include file="/front-end/member/includedfiles/css.file" %>
<style type="text/css">
#drbtn {
	color: #fff !important;
	background: #31b0d5;
	border: none !important;
	padding-top: 0.5rem !important;
	padding-bottom: .5rem !important;
	padding-left: 20px;
	padding-right: 20px;
	margin-top: 6px !important;
	-webkit-border-radius: 30px;
	-moz-border-radius: 30px;
	-ms-border-radius: 30px;
	border-radius: 30px;
}
</style>
</head>
<body>
	<!-- START nav -->
	<%@include file="/front-end/member/includedfiles/nav.file" %>
	<!-- END nav -->

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
							<h1>醫生總覽</h1>
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
							<h1>醫生總覽</h1>
						</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<br>
<!-- 幻燈片輪播 -->

<div class="container-fluid">
    <div class="row">


<!-- 		左方問診管理		 -->
		<div class="col-xs-12 col-sm-3">
			<%@ include file="sidebar.jsp" %>


		</div>
		


		<!-- 右方醫生表列 -->		
		<div class="col-xs-12 col-sm-9" >
		
			<div class="row">
				<c:forEach var="doctorVO" items="${doctorSvc.all}">
	        		<a href="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do?action=findDr&&drno=${doctorVO.drno}">
	        		<div class="col-lg-3 col-md-6 staff">
	      				<div class="img mb-4" style="background-image: url(<%=request.getContextPath()%>/doctor/doctorImg.do?drno=${doctorVO.drno});"></div>
	      					<div class="info text-center">
	      					<h3><a href="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do?action=findDr&&drno=${doctorVO.drno}">
	      						<c:forEach var="memberVO" items="${memberSvc.all}">
	      							<c:if test="${memberVO.memNo==doctorVO.memno}">${memberVO.memName}</c:if>
	      						</c:forEach>
	      						<span class="position">${doctorVO.major}</span>
	      					</a></h3>
	      					
	      				</div>
	        		</div>
	        		</a>
	        	</c:forEach>
			</div>
		</div>
		
	</div>
</div>



	<br>
<!-- 	include javascript -->
<%@ include file="/front-end/member/includedfiles/js.file" %>
	<!--以下可改動-->
</body>
<!-- include footer -->
<%@ include file="/front-end/includedfolder/footer.file" %>
</html>