<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.menulist.model2.*" %>


<html>
<head>
<meta charset="UTF-8">
<title>購物車頁面</title>

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
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}

#font-type {
	font-weight: bold;
	font-family: "微軟正黑體";
}

.first {
	margin-top: 100px;
}

.second {
	margin-top: 20px;
}

.card-img {
	widows: 230px;
	height: 150px;
}

.card-body {
	margin-top: -15px;
}
</style>
</head>
<body><br>
	<% @SuppressWarnings("unchecked")
	   Vector<MenuListVO> buylist = (Vector<MenuListVO>) session.getAttribute("shoppingcart");
	   System.out.print(buylist);
	   %>
	   
	<%if (buylist != null && (buylist.size() > 0)) {%>

	<img src="images/shopping-cart.png"><font size="+3">目前購物車的內容如下：（Cart.jsp）</font>
	<table id="table-1">
		<!--<img src="images/food_header.jpg">  -->
		<tr><td>
			<h3>餐飲業者餐點列表</h3>
			<h4><a href="<%=request.getContextPath() %>/front-end/searchPage/select_page.jsp"><img src="<%=request.getContextPath() %>/front-end/searchPage/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
		</td></tr>
	</table>
	<form id="checkoutForm" action="<%=request.getContextPath() %>/shoppingCart.do" method="get">
	<table border="1" rules="rows">
		<tr>
			<th width="90">業者</th>
			<th width="140">餐點名稱</th>
			<th width="130">供餐時段</th>
			<th width="90">單價</th>
			<th width="90">數量</th>
			<th width="70">取消</th>
		</tr>
	<% 
	 	 for (int index = 0; index < buylist.size(); index++) { 
			 MenuListVO order = buylist.get(index); 
			 String chefRep = order.getChefRep();
			 String chefNo = order.getChefNo();
			 String mainCourse = order.getMainCourse();
			 String menuTimeSlot = order.getMenuTimeSlot();
			 int unitPrice = order.getUnitPrice();
			 int amount = order.getAmount();
			 String menuListNo = order.getMenuListNo();
	%>
		<tr>
				<td width="90"><div align="left"><%=chefRep%></div></td>
				<td width="140"><div align="left"><%=mainCourse%></div></td>
				<td width="130"><div align="left"><%=menuTimeSlot%></div></td>
				<td width="90"><div align="left"><%=unitPrice%></div></td>
				<td width="90"><div align="left"><input type="text" name="amount" size="3" value=<%=amount%>></div></td>
				<td width="70">
				<a href='<%=request.getContextPath()%>/shoppingCart.do?action=DELETE&del=<%= index %>'>
				<img src="<%=request.getContextPath()%>/front-end/searchPage/images/delete.png" width="20" height="20"></a></td>
				<input type="hidden" name="menuListNo" value="${menuListVO.menuListNo}">
				<input type="hidden" name="chefNo" value="${menuListVO.chefNo}">
	         	
			</tr><%}%>
	</table> <%}%>
 				<p> 送餐地址(可不填)：<input type="text" name="deliverAddr">
</div>
	<p>
          
              <input type="hidden" name="action"  value="CHECKOUT"> 
              <input type="submit" value="付款結帳" class="button">
          </form>

</body>


</html>