<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.doctor.model.*"%>
<%@page import="com.member.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="doctorVO" scope="page" class="com.doctor.model.DoctorVO" />
<jsp:useBean id="doctorSvc" scope="page" class="com.doctor.model.DoctorService" />
<jsp:useBean id="memberVO" scope="page" class="com.member.model.MemberVO" />
<jsp:useBean id="memberSvc" scope="page" class="com.member.model.MemberService"/>
<jsp:useBean id="memVO" scope="session" class="com.member.model.MemberVO" />
<%
	HashMap reserveMap = (HashMap)session.getAttribute("reserveMap");
	pageContext.setAttribute("reserveMap", reserveMap);
	
%>
<!DOCTYPE html>
<html>
<head>
<title>checkReserve</title>
<!-- include css -->
<%@include file="/front-end/medicalOrder/includedfiles/css.file" %>
</style>

</head>
<body>

	<!-- START nav -->
	<%@include file="/front-end/medicalOrder/includedfiles/navbar.file" %>
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

<div class="container"  style="width:85%;">
	<div class="row">
		
		<!-- 		左方問診管理		 -->
		<div class="col-xs-12 col-sm-3 col-lg-3">
			<%@ include file="sidebar.jsp" %>			
		</div>
		
		<div class="col-xs-12 col-sm-9" >
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
</div>


	<br>
<!-- include js -->
<%@ include file="/front-end/medicalOrder/includedfiles/javascript.file" %>
	<!--以下可改動-->
</body>
<!-- include footer -->
<%@ include file="/front-end/includedfolder/footer.file" %>
</html>