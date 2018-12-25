<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>

<title>CA105G3 Doctor:Home</title>
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
<body  bgcolor='white'>

<table id="table-1">
   <tr><td><h3>CA105G3 Doctor:Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for CA105G3 Doctor:Home</p>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message }</li>
		</c:forEach>
	</ul>
</c:if>


<ul>
	<li><a href='listAllDoctor.jsp'>List</a> all Doctors.
	
	
	
	<li>
		<form method="post" action="doctor.do">
			<b>輸入醫生編號(如D0001):</b>
			<input type="text" name="drno">
			<input type="hidden" name="action" value="getOne_For_Display">
			<input type="submit" value="送出">
		</form>	
	</li>
	
	
	<jsp:useBean id="doctorSvc" scope="page" class="com.doctor.model.DoctorService" />
	
	<li>
		<form method="post" action="doctor.do">
			<b>選擇醫生編號</b>
			<select size="1" name="drno">
				<c:forEach var="doctorVO" items="${doctorSvc.all}"> 
					<option value="${doctorVO.drno}">${doctorVO.drno}
				</c:forEach>
			</select>
			<input type="hidden" name="action" value="getOne_For_Display">
			<input type="submit" value="送出">
		</form>	
	</li>
	
	
	
	
	
	<li>
		<form method="post" action="doctor.do">
			<b>選擇醫生科別</b>
			<select size="1" name="major">
				<c:forEach var="doctorVO" items="${doctorSvc.major}"> 
					<option value="${doctorVO.major}">${doctorVO.major}
				</c:forEach>
			</select>
			<input type="hidden" name="action" value="getDrs_By_Major">
			<input type="submit" value="送出">
		</form>	
	</li>
</ul>



<h3>醫生資料新增:</h3>
<ul>
	<li><a href='addDoctor.jsp'>Add</a> a new Doctor.</li>
</ul>

</body>
</html>