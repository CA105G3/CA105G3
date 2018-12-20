<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.medicalorder.model.*"%>


<%
    MedicalOrderService moSvc = new MedicalOrderService();
    List<MedicalOrderVO> list = moSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有病例資料 - listAllMedicalOrder.jsp</title>

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
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<br>
<table id="table-1">
	<tr><td>
		 <h3>所有病例資料 - listAllMedicalOrder.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤：</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>看診單編號</th>
		<th>會員編號</th>
		<th>醫療人員編號</th>
		<th>診療狀態</th>
		<th>診療費用</th>
		<th>約診時間</th>
		<th>病況說明</th>
		<th>問診影音紀錄</th>
		<th>問診文字紀錄</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="MedicalOrderVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${MedicalOrderVO.moNo}</td>
			<td>${MedicalOrderVO.memNo}</td>
			<td>${MedicalOrderVO.drNo}</td>
			<td>${MedicalOrderVO.moStatus}</td>
			<td>${MedicalOrderVO.moCost}</td>
			<td>${MedicalOrderVO.moTime}</td> 
			<td>${MedicalOrderVO.moIntro}</td>
			<td><img src="<%=request.getContextPath()%>/medicalorder/medicalOrderServletImg.do?moNO=${MedicalOrderVO.moVideo}" width=50% height=50% /></td> 
			<td>${MedicalOrderVO.moText}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/medicalOrderServlet/medicalOrderServlet.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="moNo"  value="${MedicalOrderVO.moNo}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/medicalOrder/medicalOrderServletImg.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="moNo"  value="${MedicalOrderVO.moNo}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>