<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.foodorder.model.*" %>
<%@ page import="com.menulist.model2.*" %>
<%@ page import="com.member.model.*" %>

<% 
  MemberVO memVO = (MemberVO)session.getAttribute("memVO");
%>
<%	
FoodOrderService foodOrderSvc = new FoodOrderService();
List<FoodOrderVO> foodOrderVOList = (List<FoodOrderVO>) foodOrderSvc.findBy_Memno(memVO.getMemNo());
pageContext.setAttribute("foodOrderVOList", foodOrderVOList);
%>
<%	
// 	FoodOrderService foodOrderSvc = new FoodOrderService();
// 	List<FoodOrderVO> list = foodOrderSvc.getAll();
// 	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="menuListSvc" scope="page" class="com.menulist.model2.MenuListService" />

<html>
<head>
<meta charset="UTF-8">
<title>我的訂單紀錄 -search by memno</title>

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
		<h3>我的訂餐紀錄</h3>
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
<%-- <font color=red><b>${param.memno}</b></font> --%>
<table>
	<tr>
		<th>訂單明細編號</th>
		<th>餐飲業者</th>
		<th>餐點名稱</th>
		<th>供餐時段</th>
		<th>單價</th>
		<th>數量</th>
	</tr>
<%-- 	<c:forEach var="foodOrderVO" items="${foodOrderVOList}"> --%>
		<c:forEach var="menuListVO" items="${menuListSvc.findByMemno(memVO.memNo)}">
		<tr>
		 <td>${menuListVO.odno}</td>
		 <td>${menuListVO.chefRep}</td>
		 <td>${menuListVO.mainCourse}</td>
		 <td>${menuListVO.menuTimeSlot}</td>
		 <td>${menuListVO.unitPrice}</td>
		 <td>${menuListVO.amount}</td>

<%-- 			<td>${menuListSvc.findByMemno(foodOrderVO.memno).getChefRep()}</td> --%>
<%-- 			<td>${menuListSvc.findByMemno(foodOrderVO.memno).mainCourse}</td> --%>
<%-- 			<td>${menuListSvc.findByMemno(foodOrderVO.memno).menuTimeSlot}</td> --%>
<%-- 			<td>${menuListSvc.findByMemno(foodOrderVO.memno).unitPrice}</td> --%>
<%-- 			<td>${menuListSvc.findByMemno(foodOrderVO.memno).amount}</td> --%>
		</tr>
		 </c:forEach>
<%-- 	</c:forEach> --%>
</table>

</body>
</html>