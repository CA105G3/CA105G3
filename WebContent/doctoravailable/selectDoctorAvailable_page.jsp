<%@page import="com.doctoravailable.model.DravailableVO"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*" %>
<jsp:useBean id="memberVO" scope="page" class="com.member.model.MemberVO" />
<jsp:useBean id="memberSvc" scope="page" class="com.member.model.MemberService"/>
<%
	DravailableVO dvo = (DravailableVO) request.getAttribute("dvo");
	memberVO = (MemberVO)memberSvc.getOneMember("M0001");
	session.setAttribute("memberVO",memberVO);
%>


<html>
<head>
<title>CA105G3 DoctorAvailable:Home</title>
<style>
table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
	border: 3px ridge Gray;
	height: 80px;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>
</head>

<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td><h3>CA105G3 DoctorAvailable:Home</h3>
				<h4>( MVC )</h4></td>
		</tr>
	</table>

	<p>This is the Home page for CA105G3 DoctorAvailable:Home</p>

	<h3>資料查詢:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message }</li>
			</c:forEach>
		</ul>
	</c:if>


	<ul>
<!-- 		<li><a href='listAllDrAvailable.jsp'>List</a> all DoctorAvailable.  -->

			<jsp:useBean id="doctorSvc" scope="page"
				class="com.doctor.model.DoctorService" /> 
				<%-- 		<jsp:useBean id="dravailableSvc" scope="page" --%>
			<%-- 			class="com.doctoravailable.model.DravailableService" /> --%>
		病患角度查詢選擇醫生可預約時間（表格版）
		<li>
			<form method="post" action="dravailable.do">
				<b>選擇醫生編號</b> <select size="1" name="drno">
					<c:forEach var="doctorVO" items="${doctorSvc.all}">
						<option value="${doctorVO.drno}">${doctorVO.drno}
					</c:forEach>
				</select> <input type="hidden" name="action"
					value="getSameDravailable_By_Drno"> <input type="submit"
					value="送出">
			</form>
		</li>


		<li>
		醫生角度查詢(登入後可以透過join獲得drno，查看行程)月曆版
			<form method="post" action="dravailable.do">
				<b>醫療人員行程</b> <select size="1" name="drno">
					<c:forEach var="doctorVO" items="${doctorSvc.all}">
						<option value="${doctorVO.drno}">${doctorVO.drno}
					</c:forEach>
				</select> <input type="hidden" name="action"
					value="getSameDrschedule_By_Drno_B"> <input type="submit"
					value="送出">
			</form>
		</li>
		<li>
		醫生角度查詢(登入後可以透過join獲得drno，查看行程)表格版
			<form method="post" action="dravailable.do">
				<b>醫療人員行程</b> <select size="1" name="drno">
					<c:forEach var="doctorVO" items="${doctorSvc.all}">
						<option value="${doctorVO.drno}">${doctorVO.drno}
					</c:forEach>
				</select> <input type="hidden" name="action"
					value="getSameDrschedule_By_Drno"> <input type="submit"
					value="送出">
			</form>
		</li>





<!-- 		<li> -->
<%-- 			<form method="post" action="<%=request.getContextPath()%>/doctor/doctor.do"> --%>
<!-- 				<b>選擇醫生科別</b> <select size="1" name="major"> -->
<%-- 					<c:forEach var="doctorVO" items="${doctorSvc.major}"> --%>
<%-- 						<option value="${doctorVO.major}">${doctorVO.major} --%>
<%-- 					</c:forEach> --%>
<!-- 				</select> <input type="hidden" name="action" value="getDrs_By_Major"> -->
<!-- 				<input type="submit" value="送出"> -->
<!-- 			</form> -->
<!-- 		</li> -->
<!-- 	</ul> -->



	<h3>醫療人員可預約時間新增:</h3>
	<ul>
		<li><a href='addDravailable.jsp'>Add</a> a new Doctoravailable.</li>
	</ul>
</body>


</html>