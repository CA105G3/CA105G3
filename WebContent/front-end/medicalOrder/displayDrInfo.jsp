<%@page import="com.doctor.model.DoctorVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.doctoravailable.model.DravailableService"%>
<%@page import="com.doctoravailable.model.DravailableVO"%>
<%@page import="com.doctor.model.DoctorVO"%>
<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemberService" />
<jsp:useBean id="memVO" scope="session" class="com.member.model.MemberVO" />

<%	DoctorVO dvo = (DoctorVO) request.getAttribute("dvo");	%>

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

<!-- 月曆使用的工具jsp -->
<%@ include file="calendarCommon.jsp"%>

<html>

<head>
<title>displayDrInfo</title>
<!-- include css -->
<%@include file="/front-end/member/includedfiles/css.file" %>

<!-- ===================================== -->


<style>
.content-loader tr td {
    white-space: nowrap; 
}
.navbar {
position:;
    min-height: 50px;
    margin-bottom: 20px;
    border: 1px solid transparent;
}
img{
	width: auto;
	height: auto;
	max-width: 100%;
	max-height: 100%;	
}
</style>

</head>

<body>
	<!-- START nav -->
<%@include file="/front-end/member/includedfiles/nav.file" %>
	<!-- END nav -->

<!-- 	幻燈片START	 -->
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
							<h1>醫生基本資料與預約時間</h1>
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
							<h1>醫生基本資料與預約時間</h1>
						</p>
					</div>
				</div>
			</div>
		</div>
	</section>
<!-- 	幻燈片START	 --


	<!-- ====================================== -->
<br>
<br>

<div class="container-fluid">
    <div class="row">


<!-- 		左方問診管理		 -->
		<div class="col-xs-12 col-sm-3 col-lg-3">
			<%@ include file="sidebar.jsp" %>
		</div>

<div class="col-xs-12 col-sm-3 col-lg-9">
		
<p>&nbsp;</p>
	<div class="row d-flex">
		<div class="col-lg-12">
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

					<table width="100%" border="0" cellpadding="2" cellspacing="0" class="col-lg-12"> 
						<tr>
							<td class="content-loader" valign="top"><img
								src="<%=request.getContextPath()%>/doctor/doctorImg.do?drno=${dvo.drno}"></td>
<!-- 							<td width="20" align="left" valign="top"><img -->
<%-- 								src="<%=request.getContextPath()%>/WebContent/front-end/doctor/blank.gif" --%>
<!-- 								alt="" width="20" height="5" /></td> -->
							<td class="content-loader align-top" align="left" >
								<table
									class="table table-striped table-borderedtable table-hover"
									width="100%" border="0" cellpadding="2" cellspacing="0">
									<tr>
										<td align="left" valign="top" class="Content-text-bold">姓
											名:</td>
										<td class="Content-text"><c:forEach var="memVO"
												items="${memSvc.all}">
												<c:if test="${memVO.memNo==dvo.memno}">
	                    							<pre>${memVO.memName}醫師</pre>
                    							</c:if>
											</c:forEach></td>
									</tr>
									<tr>
										<td align="left" valign="top" class="Content-text-bold">科
											別:</td>
										<td class="Content-text"><pre><%=dvo.getMajor()%></pre></td>
									</tr>
									<tr>
										<td align="left" valign="top" class="Content-text-bold">診療費用:</td>
										<td class="Content-text"><pre>NT$<%=dvo.getFee()%>/次</pre></td>
									</tr>
									<tr>
										<td width="117" align="left" valign="top"
											class="Content-text-bold">經 歷:</td>
										<td width="618" class="Content-text"><pre><%=dvo.getResume()%></pre>
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
	</div>
</div>		

	</div>		
</div>		
<!-- include醫生月曆		 -->
<div class="container-fluid">
		<div>
			<c:if test="${month == 'thismonth'}"><%@ include file="calendarMonthThisView.jsp" %></c:if>
			<c:if test="${month == 'nextmonth'}"><%@ include file="calendarMonthNextView.jsp" %></c:if>		
		</div>
	</div>
</div>	

<!-- include footer -->
<%@ include file="/front-end/includedfolder/footer.file" %>


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

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.33.1/dist/sweetalert2.all.min.js"></script>	
<!-- include js -->
<%@ include file="/front-end/medicalOrder/includedfiles/javascript.file" %>
</body>
</html>