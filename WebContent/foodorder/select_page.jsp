<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>餐飲訂單  Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>餐飲訂單  Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for 餐飲訂單  Home</p>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='<%=request.getContextPath() %>/foodorder/listAllFoodOrders.jsp'>List</a> all food orders.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/foodorder/foodorder.do" >
        <b>輸入訂單編號 (如20181210-0001):</b>
        <input type="text" name="orderno">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="foodOrderSvc" scope="page" class="com.foodorder.model.FoodOrderService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/foodorder/foodorder.do" >
       <b>選擇訂單編號:</b>
       <select size="1" name="orderno">
         <c:forEach var="foodOrderVO" items="${foodOrderSvc.all}" > 
          <option value="${foodOrderVO.orderno}">${foodOrderVO.orderno}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/foodorder/foodorder.do" >
       <b>選擇會員編號:</b>
       <select size="1" name="memno">
          <option value="請選擇">請選擇
         <c:forEach var="memno" items="${foodOrderSvc.allOrderMemno}" > 
          <option value="${memno}">${memno}
         </c:forEach>   
       </select>
<!-- 循著路徑找到註冊為foodorder/foodorder.do(也就是FoodOrderServlet)檔案裡的action,裡面的getOne_For_Display -->
       <input type="hidden" name="action" value="find_Order_By_Memno">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>訂單管理</h3>

<ul>
  <li><a href='addFoodOrder.jsp'>Add a new food order.</a></li>
</ul>

</body>
</html>