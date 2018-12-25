<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>餐飲訂單查詢</title>

<style>
  table#img1 {
    size:100%
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

</head>
<body bgcolor='white'>

<table>
  <tr><td id="img1" style="background-image: url('/images/food_header.JPG')" >
  		<font size="20" color="white"><b>餐飲訂單查詢</b></font></td></tr>
<!--   <div class="centered"><font color="white" size="50">餐飲訂單查詢</font></div> -->
</table>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<p><h3>依訂單編號查詢</h3></p>
<ul>  
  <jsp:useBean id="foodOrderSvc" scope="page" class="com.foodorder.model.FoodOrderService" />
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/foodorder/foodorder.do" >
          請輸入訂單編號 (如20181220-0001):
        <input type="text" name="orderno">
        <input type="hidden" name="action" value="getOrder_by_Orderno">
        <input type="submit" value="送出">
    </FORM>
  </li>
</ul>
<p>==========================================</p>
<p><h3>依帳號、Email或會員編號查詢</h3></p>
<ul> 
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/foodorder/foodorder.do" >
         請輸入帳號 (如 David):
        <input type="text" name="memId">
        <input type="hidden" name="action" value="getOrders_by_memId">
        <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/foodorder/foodorder.do" >
        	請輸入EMAIL (如 david001@gmail.com):
        <input type="text" name="email">
        <input type="hidden" name="action" value="getOrders_by_email">
        <input type="submit" value="送出">
    </FORM>
  </li>
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/foodorder/foodorder.do" >
         請輸入會員編號 (如 M0001):
        <input type="text" name="memno">
        <input type="hidden" name="action" value="getOrders_by_memno">
        <input type="submit" value="送出">
    </FORM>
  </li>
</ul>


<ul>
  <li><a href='addFoodOrder.jsp'>我要訂餐</a></li>
</ul>

</body>
</html>