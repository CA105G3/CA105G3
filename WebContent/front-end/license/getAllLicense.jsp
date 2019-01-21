<%@page import="com.administrator.model.AdministratorVO"%>
<%@page import="java.util.List"%>
<%@page import="com.member.model.MemberVO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.license.model.*"%>


<%
	// 	MemberVO memVO=null;
	// 	memVO = (MemberVO)session.getAttribute("memVO");
%>

<% 
	LicenseService licenseSvc = new LicenseService();
	List<QualifyVO> list = licenseSvc.getAll();
	pageContext.setAttribute("list", list);
	
	AdministratorVO adminVO=null;
	adminVO = (AdministratorVO)session.getAttribute("adminVO");
%>
<html>
<head>
<title>資格驗證 - qual_by_lic.jsp</title>

<style>
table#table-2 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-2 h4 {
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


<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->

<link rel="Shortcut Icon" type="image/x-icon"
	href="<%=request.getContextPath()%>/front-end/images/favicon.ico">


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

<!-- =============================================================================== -->



<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/activity/css/leftsidebar.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css"></link>
<!--     ================================================================================= -->

<style>
.content-loader tr td {
	white-space: nowrap;
}
</style>

<style>
#owlpic {
	max-width: 100%;
}

#map {
	height: 500px; /* The height is 400 pixels */
	width: 100%; /* The width is the width of the web page */
}

.form-control {
	width: 150px;
	height: 38px !important;
}
</style>
<style type="text/css">
#sidebar-container {
    min-height: 200vh;
    background-color: #333;
    padding: 0;
}
a {
    -webkit-transition: .3s all ease;
    -o-transition: .3s all ease;
    transition: .3s all ease;
    color: #000000;
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
	          <li class="nav-item"><a href="food.html" class="nav-link"><%= (adminVO==null)? "訪客" :adminVO.getAdminName() %> 您好!</a></li>
	          <li class="nav-item"><a href="#" class="nav-link">個人設定</a></li>
	          <li class="nav-item"><a href="<%=request.getContextPath() %>/front-end/memberchef/listAllChef.jsp" class="nav-link">送餐專區</a></li>
	          <li class="nav-item"><a href="<%=request.getContextPath()%>/front-end/medicalOrder/ScanDoctor.jsp" class="nav-link">線上問診</a></li>
	          <li class="nav-item"><a href="<%=request.getContextPath() %>/front-end/activity/joinactivity.jsp" class="nav-link">活動專區</a></li>
	          <li class="nav-item cta"><a href="<%=request.getContextPath() %>/back-end/admin/admin.do?action=adminLogout" class="nav-link" <%= (adminVO==null)? "data-toggle='modal' data-target='#modalRequest'" :"" %>  ><span id="mylogin"><%= (adminVO==null)? "登入/註冊" :"登出" %></span></a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- END nav -->



	<section class="home-slider owl-carousel">
		<div class="slider-item bread-item" id="owlpic"
			style="background-image: url('<%=request.getContextPath()%>/front-end/license/img/hunterlic.png');"
			data-stellar-background-ratio="0.5">
			<div class="overlay"></div>
			<div class="container" data-scrollax-parent="true">
				<div class="row slider-text align-items-end">
					<div class="col-md-7 col-sm-12 ftco-animate mb-5">
						<h1 class="mb-3"
							data-scrollax=" properties: { translateY: '70%', opacity: .9}">會員證照管理</h1>
					</div>
				</div>
			</div>
		</div>

		<div class="slider-item bread-item" id="owlpic"
			style="background-image: url('<%=request.getContextPath()%>/front-end/license/img/downjia.jpg');"
			data-stellar-background-ratio="0.5">
			<div class="overlay"></div>
			<div class="container" data-scrollax-parent="true">
				<div class="row slider-text align-items-end">
					<div class="col-md-7 col-sm-12 ftco-animate mb-5">
						<h1 class="mb-3"
							data-scrollax=" properties: { translateY: '70%', opacity: .9}">會員證照管理</h1>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Bootstrap NavBar -->
	<!-- This menu is hidden in bigger devices with d-sm-none. 
The sidebar isn't proper for smaller screens imo, so this dropdown menu can keep all the useful sidebar itens exclusively for smaller screens  -->
	<li class="nav-item dropdown d-sm-block d-md-none"><a
		class="nav-link dropdown-toggle" href="#" id="smallerscreenmenu"
		data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Menu</a>
		<div class="dropdown-menu" aria-labelledby="smallerscreenmenu">
			<a class="dropdown-item" href="#">Dashboard</a> <a
				class="dropdown-item" href="#">Profile</a> <a class="dropdown-item"
				href="#">Tasks</a> <a class="dropdown-item" href="#">Etc ...</a>
		</div></li>
	<!-- Smaller devices menu END -->
	<!-- NavBar END -->
	<!-- Bootstrap row -->
	<div class="row" id="body-row">
	<div class="col-ms-3">
		<!-- Sidebar -->
		<div id="sidebar-container" class="sidebar-expanded d-none d-md-block">
			<!-- d-* hiddens the Sidebar in smaller devices. Its itens can be kept on the Navbar 'Menu' -->
			<!-- Bootstrap List Group -->
			<ul class="list-group">
				<li
					class="list-group-item sidebar-separator-title text-light d-flex align-items-center menu-collapsed">
					<small>證照查詢</small>
				</li>
				<!-- Menu with submenu -->
				<a
					href="<%=request.getContextPath()%>/front-end/license/getAllLicense.jsp"
					class="bg-dark list-group-item list-group-item-action flex-column align-items-start">
					<div class="d-flex w-100 justify-content-start align-items-center">
						<span class="fa fa-dashboard fa-fw mr-3"></span> <span
							class="menu-collapsed">所有證照</span>
					</div>
				</a>
				<a
					href="<%=request.getContextPath()%>/license/license.do?action=drCheck_qualify&licStatus=審核中"
					class="bg-dark list-group-item list-group-item-action flex-column align-items-start">
					<div class="d-flex w-100 justify-content-start align-items-center">
						<span class="fa fa-user fa-fw mr-3"></span> <span
							class="menu-collapsed">審核中證照</span> <span
							class="submenu-icon ml-auto"></span>
					</div>
				</a>

				<!-- Separator with title -->
				<!--             <li class="list-group-item sidebar-separator-title text-light d-flex align-items-center menu-collapsed"> -->
				<!--                 <small>參與活動查詢</small> -->
				<!--             </li> -->
				<!-- /END Separator -->
				<a
					href="<%=request.getContextPath()%>/license/license.do?action=drCheck_qualify&licStatus=生效中"
					" class="bg-dark list-group-item list-group-item-action">
					<div class="d-flex w-100 justify-content-start align-items-center">
						<span class="fa fa-calendar fa-fw mr-3"></span> <span
							class="menu-collapsed">生效中證照</span>
					</div>
				</a>
				<a
					href="<%=request.getContextPath()%>/license/license.do?action=drCheck_qualify&licStatus=已失效"
					" class="bg-dark list-group-item list-group-item-action">
					<div class="d-flex w-100 justify-content-start align-items-center">
						<span class="fa fa-calendar fa-fw mr-3"></span> <span
							class="menu-collapsed">已失效證照</span>
					</div>
				</a>
				<!-- Separator without title -->
				<!--             <li class="list-group-item sidebar-separator menu-collapsed"></li>             -->
				<!--             <a href="#" data-toggle="sidebar-colapse" class="bg-dark list-group-item list-group-item-action d-flex align-items-center"> -->
				<!--                 <div class="d-flex w-100 justify-content-start align-items-center"> -->
				<!--                     <span id="collapse-icon" class="fa fa-2x mr-3"></span> -->
				<!--                     <span id="collapse-text" class="menu-collapsed">Collapse</span> -->
				<!--                 </div> -->
				<!--             </a> -->
				<!--         </ul>     -->
				<!-- List Group END-->
		</div>
		<!-- sidebar-container END -->
		</div>


<!-- 		<h4>我是drQual</h4> -->


		<div class="col-ms-9">
		<br>


		<div class="row d-flex justify-content-center">
		<div class="col-lg-2">
		</div>
			<div class="col-lg-10 ">
				<div class="panel panel-default">
					<div class="panel-heading"><h4>所有證照</h4></div>
					<!-- /.panel-heading -->
					<div class="panel-body">




						<form METHOD="post"
							action="<%=request.getContextPath()%>/license/license.do"
							style="margin-bottom: 0px;">

							<%-- 錯誤表列 --%>
							<%-- 		<c:if test="${not empty errorMsgs}"> --%>
							<!-- 			<font style="color: red">請修正以下錯誤:</font> -->
							<!-- 			<ul> -->
							<%-- 				<c:forEach var="message" items="${errorMsgs}"> --%>
							<%-- 					<li style="color: red">${message}</li> --%>
							<%-- 				</c:forEach> --%>
							<!-- 			</ul> -->
							<%-- 		</c:if> --%>

							<table
								class="table table-striped table-borderedtable table-hover"
								id="dataTables-example">
								<tr>
									<th>證照編號</th>
									<th>會員姓名</th>
									<th>證照資料</th>
									<th>證照狀態</th>
									<th>證照描述</th>
									<th>科別</th>
									<th>證照時效</th>
									<th>會員狀態</th>
								</tr>
								<%@ include file="page1.file"%>
								<%-- <%!int licDuecount= 0 ;%> --%>
								<c:forEach var="qualifyVO" items="${list}" varStatus="s" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
										<jsp:useBean id="ms" scope="page"
											class="com.member.model.MemberService" />
									<tr>
										<td>${qualifyVO.licNo}</td>
										<td>${ms.getOneMember(qualifyVO.memNo).memName}</td>
										<!-- 照片	 -->
										<c:choose>
											<c:when test="${(qualifyVO.licData)!=null}">
												<td><img
													src="<%= request.getContextPath() %>/license/licensePic.do?licNo=${qualifyVO.licNo} "
													height="250px" width="300px" /></td>
											</c:when>
											<c:otherwise>
												<td><img
													src="<%=request.getContextPath()%>/front-end/activity/img/nopic.jpg">
												</td>
											</c:otherwise>
										</c:choose>
										<td><select name="licStatus">
												<option value="生效中"
													${'生效中'==qualifyVO.licStatus? 'selected':'' }>生效中</option>
												<option value="審核中"
													${'審核中'==qualifyVO.licStatus? 'selected':'' }>審核中</option>
												<option value="已失效"
													${'已失效'==qualifyVO.licStatus? 'selected':'' }>已失效</option>
												<%-- 						    <option value="心理諮商" ${(dvo.major=="心理諮商")? 'selected':'' }>心理諮商 --%>
										</select></td>
										<td>${qualifyVO.licDesc}</td>


										<jsp:useBean id="ds" scope="page"
											class="com.doctor.model.DoctorService" />


										<td>${ds.getOneDoctor(ds.getDrno(qualifyVO.memNo).drno).major}</td>







										<td>${qualifyVO.licDue}</td>

										<!-- 					<td><input id="f_date1" name="licDue" size="45" -->
										<%-- 							value="${(qualifyVO == null) ? '' : qualifyVO.getLicDue()% }" /> --%>
										<!-- 					</td> -->

										<%-- <c:set scope="request" var="qualifyVO" value="${qualifyVO}"/> --%>

										<%-- <td><c:out value="${pageScope.qualifyVO}"    default="無資料" /></td> --%>

										<%
											// 		licDue
												// 		java.sql.Date licDue = null;
												// 		try {
												// 			QualifyVO qvo =  (QualifyVO)request.getAttribute("qualifyVO");
												// 			licDue = qvo.getLicDue();
												// 		} catch (Exception e) {
												// 			licDue = new java.sql.Date(System.currentTimeMillis());
												// 		}
										%>


















										<td><select name="ident">
												<option value="一般會員"
													${"一般會員"==qualifyVO.ident? 'selected':'' }>一般會員</option>
												<option value="醫療人員"
													${"醫療人員"==qualifyVO.ident? 'selected':'' }>醫療人員</option>
												<%-- 						<option value="餐飲業者" ${"餐飲業者"==qualifyVO.ident}?selected:"" }>餐飲業者</option> --%>
										</select></td>
										<td><input type="submit" value="確認"> <input
											type="hidden" name="licNo" value="${qualifyVO.licNo}">
											<input type="hidden" name="memNo" value="${qualifyVO.memNo}">
											<input type="hidden" name="queryStatus" value="${qualifyVO.licStatus}"> 
											<input type="hidden" name="listAll" value="yes"> 
											<input type="hidden"
											name="action" value="drLicStatusChange"></td>
									</tr>
								</c:forEach>
							</table>
							<%@ include file="page2.file"%>
						</Form>



					</div>
					<!-- /.panel-body -->
				</div>
				<!-- /.panel -->
			</div>
		</div>

</div>
	</div>






















	<!-- ======================================================================= -->
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


	<script src="<%=request.getContextPath()%>/front-end/js/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/js/jquery-migrate-3.0.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/front-end/js/popper.min.js"></script>
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
	<script src="<%=request.getContextPath()%>/front-end/js/aos.js"></script>
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
	<script src="<%=request.getContextPath()%>/front-end/js/google-map.js"></script>
	<script src="<%=request.getContextPath()%>/front-end/js/main.js"></script>
	<script
		src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	<script src="<%=request.getContextPath()%>/front-end/js/index.js"></script>


	<script src="https://code.jquery.com/jquery.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<!-- ============================================================================ -->



	<%
		// 		java.sql.Date licDue = null;
		// 		try {
		// 			licDue = licenseVO.getLicDue();
		// 		} catch (Exception e) {
		// 			licDue = new java.sql.Date(System.currentTimeMillis());
		// 		}
	%>

	<!-- 	<script -->
	<%-- 		src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.js"></script> --%>
	<!-- 	<script -->
	<%-- 		src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.full.js"></script> --%>
	<script>
// 		$.datetimepicker.setLocale('zh');
// 		$('#f_date1').datetimepicker({
// 			theme : '', //theme: 'dark',
// 			timepicker : false, //timepicker:true,
// 			step : 1, //step: 60 (這是timepicker的預設間隔60分鐘)
// 			format : 'Y-m-d', //format:'Y-m-d H:i:s',
<%-- 			value : '<%=licDue%>', // value:   new Date(), --%>
		//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
		//startDate:	            '2017/07/10',  // 起始日
		//minDate:               '-1970-01-01', // 去除今日(不含)之前
		//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
// 		});

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




	<!-- 	<br>本網頁的路徑: -->
	<!-- 	<br> -->
	<%-- 	<b> <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br> --%>
	<%-- 		<font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> --%>
	<!-- 	</b> -->

</body>
</html>