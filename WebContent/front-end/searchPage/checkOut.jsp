<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.menulist.model2.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>結帳頁面</title>

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
<img src="images/foodorder2.png"> <font size="+3">訂餐內容</font>
<hr><p>

<%-- <form id="checkoutForm" action="<%=request.getContextPath() %>/shoppingCart.do" method="get"> --%>
<table id="table-1" style="margin: auto;">
	<tr>
		<th width="90">業者</th>
		<th width="140">餐點名稱</th>
		<th width="130">供餐時段</th>
		<th width="90">單價</th>
		<th width="90">數量</th>
		<th width="200">送餐地址</th>
	</tr></table><table style="margin: auto;">

	<%  @SuppressWarnings("unchecked")
		Vector<MenuListVO> buylist = (Vector<MenuListVO>) session.getAttribute("shoppingcart");
		String total =  (String) request.getAttribute("total");
		String[] amountArray = request.getParameterValues("amount");
		String deliverAddr=(String)request.getAttribute("deliverAddr");
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
		<td width="100"><%=amount%> </td><td width="120"></td>
		
		</tr>
	<%
		}
	%>
	<tr>
		<td colspan="6" style="text-align:right;"> 
		   <font size="+2">總金額： <h4>$${total}</h4> </font>
	    </td>
	</tr> 
</table>
       <p>
       	 
   送餐地址:<%=deliverAddr%>
<!-- </form> -->
<form name="new_order" action="<%=request.getContextPath()%>/shoppingCart.do" method="POST">
	   <input type="hidden" name="chefNo" value="CHEF0001">
   	   <input type="hidden" name="memno" value="M0001">
   	   <input type="hidden" name="deliverAddr" value="<%=deliverAddr%>">
   	   <input type="hidden" name="orderStatus" value="接受">
   	   <input type="hidden" name="total" value="<%=total%>">
   	   <input type="hidden" name="menuListNo" value="${menuListVO.menuListNo}">   		       
       <input type="hidden" name="action"  value="insert"> 
       <input type="submit" value="完成結帳" class="button">
</form>
       

</body>
</html>