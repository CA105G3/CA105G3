<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.foodorder.model.*" %>
<%
	FoodOrderService foodOrderSvc = new FoodOrderService();
	List<FoodOrderVO> list = foodOrderSvc.getAll();
	pageContext.setAttribute("list",list);  //前面的list是pageContext裡站存空間的list,後面的list是自己VO裡的list
%>

<html>
<head>
<meta charset="UTF-8">
<title>餐飲訂單列表  - listAllFoodOrders.jsp</title>

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
		<h3>餐飲訂單列表</h3>
		<h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

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
		<th>訂單編號</th>
		<th>會員編號</th>
		<th>送餐地址</th>
		<th>餐飲業者編號</th>
		<th>訂單狀態</th>
		<th>送餐時段</th>
		<th>訂單狀態</th>
	</tr>
	<c:forEach var="foodOrderVO" items="${list}"> 
		<tr>
			<td>${foodOrderVO.orderno}</td>
			<td>${foodOrderVO.memno}</td>
			<td>${foodOrderVO.deliverAddr}</td>
			<td>${foodOrderVO.chefno}</td>
			<td>${foodOrderVO.orderStatus}</td>
			<td>${foodOrderVO.ordTime}</td>
			<td>
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/foodorder/foodorder.do" style="margin-bottom: opx;">
					<select size="1" name="orderStatus">
          				<option value="接受">接受
          				<option value="審核中" selected>審核中
          				<option value="取消">取消</FORM>	
			    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>front-end/foodorder/foodorder.do" style="margin-bottom: 0px;">
			     <input type="submit" value="送出">
			     <input type="hidden" name="orderStatus"  value="${foodOrderVO.orderStatus}">
			     <input type="hidden" name="action" value="update_Order_Status"></FORM>
       		</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>