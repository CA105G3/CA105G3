<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.medicalorder.model.*"%>
<%@ page import="com.doctor.model.*"%>
<%@ page import="com.member.model.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="doctorVO" scope="page" class="com.doctor.model.DoctorVO" />
<jsp:useBean id="doctorSvc" scope="page" class="com.doctor.model.DoctorService" />
<jsp:useBean id="memVO" scope="session" class="com.member.model.MemberVO" />
<jsp:useBean id="memberSvc" scope="page" class="com.member.model.MemberService"/>

<%	
	MedicalOrderService moSvc = new MedicalOrderService();
 	List<MedicalOrderVO> list = moSvc.findListforMember(memVO.getMemNo());	//上線版
 	pageContext.setAttribute("list", list);

%>

<!DOCTYPE html>

<html>
<head>
<title>會員病例歷史紀錄</title>
<!-- include css -->
<%@include file="/front-end/member/includedfiles/css.file" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
							<h1>個人看診紀錄<h1>
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
							<h1>個人看診紀錄<h1>
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
		
<!-- 		右方會員看診紀錄資訊 -->
		<div class="col-xs-12 col-sm-9" >
			<table class="table table-striped table-bordered">
			  <thead>
			    <tr align='center'>
			      <th scope="col">看診單編號</th>
			      <th scope="col">醫生姓名</th>
			      <th scope="col">診療狀態</th>
			      <th scope="col">診療費用</th>
			      <th scope="col">約診時間</th>
			      <th scope="col">病況說明</th>
			      <th scope="col">取消原因</th>
			      <th scope="col">問診文字紀錄</th>
			      <th scope="col">取消問診</th>
			    </tr>
			  </thead>
			  <tbody>
<c:forEach var="moVO" items="${list}" >
			    <tr>
			      <td scope="col" class="text-center">
			      <c:if test="${moVO.moStatus == '等待問診'  || moVO.moStatus == '等待審核'}">	
<%-- 			      	<a href="<%=request.getContextPath()%>/front-end/webrtc/treament_patientside.jsp?moNO=${moVO.moNo}">${moVO.moNo}</a> --%>
					<form action="<%=request.getContextPath()%>/front-end/webrtc/treament_patientside.jsp" method="post">
					<input type="hidden" name="moNO" value="${moVO.moNo}">
					<input class="btn btn-success"type="submit" value="進入問診">
					</form>
			      </c:if>
			       <c:if test="${moVO.moStatus == '問診完成'  || moVO.moStatus == '取消問診'}">	
			      	${moVO.moNo}
			      </c:if>  
			      </td>
			      <td scope="col" class="text-center">			      
<%-- 			  ${moVO.drNo} 1.先取出medicalOrderVO的drNo--%>
<%-- 			  ${doctorSvc.getOneDoctor(moVO.drNo).memno} 2.再從doctorServicec呼叫方法取出會員編號--%>
			      ${memberSvc.getOneMember(doctorSvc.getOneDoctor(moVO.drNo).memno).memName} <%-- 再從memberService呼叫方法取出memName --%>
			      </td>
			      <td scope="col" class="text-center">${moVO.moStatus}</td>
			      <td scope="col" class="text-center">${moVO.moCost}</td>
			      <td scope="col" class="text-center">${moVO.moTime} 

			      	<c:choose>
			      		<c:when test="${moVO.moHour==9}"><c:out value="09:00~12:00" /></c:when>
			      		<c:when test="${moVO.moHour==13}"><c:out value="13:00~16:00"/></c:when>
			      		<c:when test="${moVO.moHour==17}"><c:out value="17:00~20:00"/></c:when>   	
			      	</c:choose>
			      </th>
			      <td scope="col">${moVO.moIntro}</td>
			      <td scope="col">${moVO.moCancelReason}</td>
			      <td scope="col">${moVO.moText}</td>
			      <td scope="col">
	<c:if test="${moVO.moStatus == '等待問診'  || moVO.moStatus == '等待審核'}">			      
			      	<button type="button" value="${moVO.moNo}" id="cancel" class="btn btn-warning cancel">取消預約</button>
			      </td>
	</c:if>
</c:forEach>
			    </tr>
			  </tbody>
			</table>
		</div>
	</div>
	</div>
</div>
</div>
	<br>
	<script>

		
		$(".cancel").click(function(e){	
			Swal({
				title: '是否取消預約問診',
				text: "若取消問診，將無法進行預約看診",
				type: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: '取消預約',
				cancelButtonText: '回到紀錄'
			}).then((result) => {
				if (result.value) {
				    Swal({
				    	title: '請輸入取消理由',
				    	input: 'text',
				    	showCancelButton: true,
					  	confirmButtonColor: '#3085d6',
					  	cancelButtonColor: '#d33',
					  	confirmButtonText: '取消預約',
						cancelButtonText: '回到紀錄',
						inputValidator: function (value) {
							return new Promise(function (reject) {
						    	if (value){
						    		console.log(value);
						    		window.location.href = "<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do?action=cancelMO&moCancelReason=" + value + "&moNo=" + $(e.target).val();
						      	} else {
						        	reject('你需要輸入取消理由')
						      	}
						    })
						}
					})
				}
			})
	 	});
		
	</script>	
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.33.1/dist/sweetalert2.all.min.js"></script>
<!-- include js -->
<%@ include file="/front-end/member/includedfiles/js.file" %>
	<!--以下可改動-->
</body>
<!-- include footer -->
<%@ include file="/front-end/includedfolder/footer.file" %>
</html>