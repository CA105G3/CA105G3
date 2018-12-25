<%@page import="com.doctor.model.DoctorVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	DoctorVO dvo = (DoctorVO) request.getAttribute("dvo");
%>

<%=dvo == null%>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>醫療人員資料新增 - addEmp.jsp</title>

<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Title Page</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
</head>
<body>
	<table id="table-1">
		<tr>
			<td>
				<h3>醫療人員資料新增 - addDoctor.jsp</h3>
				<h4>
					<a href="selectDoctor_page.jsp"><i
						class="glyphicon glyphicon-home"></i>&nbsp;&nbsp;回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料新增:</h3>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<form method="post" action="doctor.do" enctype="multipart/form-data">
		<table class="table table-hover">

			<tr>
				<td>會員編號:<font style="color: red"><b>*</b></font></td>
				<td><input type="TEXT" name="memno" size="45"
					value="<%=(dvo == null) ? "M0010" : dvo.getMemno()%>" /></td>
			</tr>

			<tr>
				<td>履歷:</td>
				<td><input type="TEXT" name="resume" size="45"
					value="<%=(dvo == null) ? "我爸連戰" : dvo.getResume()%>" /></td>
				<!-- 		如何解決多行問題 -->
			</tr>

			<tr>
				<td>上線狀態:</td>
<!-- 				<td><input type="TEXT" name="isonline" size="45" -->
<%-- 					value="<%=(dvo == null) ? "線上" : dvo.getIsonline()%>" /></td> --%>
				<td><select size="1" name="isonline">

						<option value="線上" ${(dvo.isonline=="線上")? 'selected':'' }>線上
						
						<option value="離線" ${(dvo.isonline=="離線")? 'selected':'' }>離線
						
				</select></td>
			</tr>

			<tr>
				<td>看診權限:</td>
<!-- 				<td><input type="TEXT" name="status" size="45" -->
<%-- 					value="<%=(dvo == null) ? "生效中" : dvo.getStatus()%>" /></td> --%>
				<td><select size="1" name="status">
						<option value="生效中" ${(dvo.status=="生效中")? 'selected':'' }>生效中
						<option value="失效" ${(dvo.status=="失效")? 'selected':'' }>失效
						<option value="審核中" ${(dvo.status=="審核中")? 'selected':'' }>審核中
				</select></td>
			</tr>

			<tr>
				<td>科別:</td>
				<td><input type="TEXT" name="major" size="45"
					value="<%=(dvo == null) ? "家醫科" : dvo.getMajor()%>" /></td>
			</tr>

			<tr>
				<td>診療費用:</td>
				<td><input type="TEXT" name="fee" size="45"
					value="<%=(dvo == null) ? "500" : dvo.getFee()%>" /></td>
			</tr>
			<!-- 照片 -->
			<tr>
				<td>照片: </td>
				<td><img id="output"  src="<%=request.getContextPath()%>/Imgs/Doctor/No-Image-Basic.png"/></td>
				<td><input type="file" name="drPic" size="45" onchange="loadFile(event)"
					value="<%=(dvo == null) ? "500" : dvo.getFee()%>" /></td>
			</tr>
		</table>

		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</form>
	
		<script>
		var loadFile = function(event) {
			var reader = new FileReader();
			reader.onload = function() {
				var output = document.getElementById('output');
				output.src = reader.result;
			};
			reader.readAsDataURL(event.target.files[0]);
		};
	</script>

</body>
</html>