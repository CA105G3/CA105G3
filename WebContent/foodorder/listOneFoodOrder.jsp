<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.foodorder.model.*"%>
<%
	FoodOrderVO foodOrderVO = (FoodOrderVO) request.getAttribute("foodOrderVO");
%>
<html>
<head>
<title>訂單資料 - listOneFoodOrder.jsp</title>

<title>訂單資料</title>
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
	width: 600px;
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
	<tr><td>
		 <h3>單筆訂單查詢 - ListOneEmp.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>訂單編號</th>
		<th>會員編號</th>
		<th>送餐地址</th>
		<th>業者編號</th>
		<th>訂單狀態</th>
		<th>送餐時段</th>
	</tr>
	<tr>
		<td><%=foodOrderVO.getOrderno()%></td>
		<td><%=foodOrderVO.getMemno()%></td>
		<td><%=foodOrderVO.getDeliverAddr()%></td>
		<td><%=foodOrderVO.getChefno()%></td>
		<td><%=foodOrderVO.getOrderStatus()%></td>
		<td><%=foodOrderVO.getOrdTime()%></td>
	</tr>
</table>
</body>
</html>