<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.foodorder.model.*" %>


<html>
<head>
<meta charset="UTF-8">
<title>�ڪ��q����� -search by memno</title>

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
<body>

<table id="table-1">
	<!--<img src="images/food_header.jpg">  -->
	<tr><td>
		<h3>�ڪ��q�\����</h3>
		<h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~�G</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>�q��s��</th>
		<th>�|���s��</th>
		<th>�e�\�a�}</th>
		<th>�\���~�̽s��</th>
		<th>�q�檬�A</th>
		<th>�e�\�ɬq</th>
	</tr>
	<c:forEach var="foodOrderVO" items="${foodOrderVOList}"> 
		<tr>
			<td>${foodOrderVO.orderno}</td>
			<td>${foodOrderVO.memno}</td>
			<td>${foodOrderVO.deliverAddr}</td>
			<td>${foodOrderVO.chefno}</td>
			<td><select size="1" name="orderStatus">
				<option value="����">����
				<option value="������">������
				<option value="�f�֤�" selected>�f�֤�
				<option value="����">����
				</select>	
			</td>
			<td>${foodOrderVO.ordTime}</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>