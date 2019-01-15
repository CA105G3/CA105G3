<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.foodorder.model.*" %>
<%@ page import="com.menulist.model2.*" %>
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
		<h3>恭喜您訂餐成功!</h3>
	</td></tr>
</table>
<form id="new_order" action="<%=request.getContextPath() %>/front-end/foodorder/foodorder.do" method="get">
<table id="table-1" style="margin: auto;">
	<tr>
		<th width="90">業者</th>
		<th width="140">餐點名稱</th>
		<th width="130">供餐時段</th>
		<th width="90">單價</th>
		<th width="90">數量</th>
	</tr></table><table style="margin: auto;">

	<%  @SuppressWarnings("unchecked")
		Vector<MenuListVO> buylist = (Vector<MenuListVO>) session.getAttribute("shoppingcart");
		String total =  (String) request.getAttribute("total");
		String deliverAddr =  (String) request.getAttribute("deliverAddr");
		String[] amountArray = request.getParameterValues("amount");
	%>
	<%	for (int i = 0; i < buylist.size(); i++) {
		MenuListVO order = buylist.get(i);
			String chefNo = order.getChefNo();
			String chefRep = order.getChefRep();
			String mainCourse = order.getMainCourse();
			String menuTimeSlot = order.getMenuTimeSlot();
			String menuListNo = order.getMenuListNo();
			int unitPrice = order.getUnitPrice();
			int amount = order.getAmount();
	%>
	<tr>
		<td width="200"><%=chefRep%>     </td>
		<td width="100"><%=mainCourse%>   </td>
		<td width="100"><%=menuTimeSlot%></td>
		<td width="100"><%=unitPrice%>    </td>
		<td width="100"><%=amount%> </td>
	<tr>
		<td colspan="6" style="text-align:right;"> 
		   <font size="+2">總金額： <h4>$<%=total%></h4> </font>
	    </td>
	</tr>
	<%
		}
	%>
</table>
	<p>送餐地址:${foodOrderVO.deliverAddr}

</form>
	<p><a href="<%=request.getContextPath() %>/front-end/searchPage/select_page.jsp"><font size="+1"> 我 想 繼 續 訂 餐</font></a>
</body>
</html>