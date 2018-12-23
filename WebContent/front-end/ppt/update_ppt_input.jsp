<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ppttool.model.*"%>

<%
  PPTToolVO pptVO = (PPTToolVO) request.getAttribute("pptVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>PPT資料修改 - update_ppt_input.jsp</title>
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
</head>
<body bgcolor='white'>
<table id="table-1">
	<tr><td>
		 <h3>PPT資料修改 - update_emp_input.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<FORM METHOD="post" ACTION="ppt.do" name="form1" enctype='multipart/form-data'>
<table>
	<tr>
		<td>PPT編號:<font color=red><b>*</b></font></td>
		<td><%=pptVO.getPptno()%></td>
	</tr>
	<tr>
		<td>醫生編號:<font color=red><b>*</b></font></td>
		<td><%=pptVO.getDrno()%></td>
	</tr>
	<tr>
		<td>PPT檔:</td>
		<td><input type="file" name="ppt" size="45" onchange="loadFile(event)"
			 value="<%= (pptVO==null)? request.getContextPath()+"/oracle_imgs/Doctor/03.jpg" : pptVO.getPpt()%>" /></td>
	</tr>
	<tr>
		<td>目前PPT檔</td>
		<td><img src="<%=request.getContextPath()%>/ppt/pptImg.do?pptno=${pptVO.pptno}"/></td>
	</tr>
	<tr>
		<td>欲修改成的PPT檔</td>
		<td><img id="output" width=50% height=50%/></td>
	</tr>
</table>
<input type="hidden" name="action" value="update">
<input type="hidden" name="drno" value="<%=pptVO.getDrno()%>">
<input type="hidden" name="pptno" value="<%=pptVO.getPptno()%>">
<input type="submit" value="送出修改">
</FORM>

<script>
  var loadFile = function(event) {
    var reader = new FileReader();
    reader.onload = function(){
      var output = document.getElementById('output');
      output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
  };
</script>
</body>
</html>