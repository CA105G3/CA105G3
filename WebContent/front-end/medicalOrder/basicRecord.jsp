<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<%@include file="/front-end/member/includedfiles/css.file" %>

</head>
<body>

	<!-- START nav -->
	<%@include file="/front-end/member/includedfiles/nav.file" %>
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
							<h1>個人基本病歷表</h1>
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
							<h1>個人基本病歷表</h1>
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
							<input type="hidden" name="memId" value="${memVO.memId}">						
							<input type="submit" class="btn bg-primary text-white" value="提交">
							<input type="hidden" name="action" value="updateBasicRecord">
						</div>
					</div>

				</form>	
			</div>

	</div>
</div>
	

	<br>
<!-- include js -->
<%@ include file="/front-end/member/includedfiles/js.file" %>
	<!--以下可改動-->
</body>
<!-- include footer -->
<%@ include file="/front-end/includedfolder/footer.file" %>
</html>