<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.foodorder2.model.*"%>
<link   rel="stylesheet" type="text/css" href="datetimepicker/jquery.datetimepicker.css" />
<script src="datetimepicker/jquery.js"></script>
<script src="datetimepicker/jquery.datetimepicker.full.js"></script>
<jsp:useBean id="MenuSvc" scope="page" class="com.foodorder2.model.MenuService" />

<html>
<head><title>所有餐點 -selectMenu.jsp</title>

<style>
  table#table-1 {
	background-color: orange;
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
  
  
    .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

</head>
<body>

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有餐點 - selectMenu.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
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

<table>
	<tr>
		<th>餐點名稱</th>
		<th>餐點介紹</th>
		<th>餐點照片</th>
		<th>餐點單價</th>
		<th>供餐時段</th>
		<th>加入餐車</th>
	</tr>
	
	<c:forEach var="menuVO" items="${listMenu_ByChefno}">
		<tr>
			<td>${menuVO.mainCourse}</td>
			<td>${menuVO.menuIntro}</td>
			<td><img style="max-width: 190px; max-height: 250px;" src="<%=request.getContextPath()%>/front-end/foodOrder2/foodorderImg2.do?menuno=${menuVO.menuNo} "/></td>
			<td>${menuVO.unitPrice}</td>

			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/foodOrder2/foodorder2.do" style="margin-bottom: 0px;">
			    <input type="submit" value="供餐時段"> 
			    <input type="hidden" name="menuno" value="${menuVO.menuNo}">
			    <input type="hidden" name="action" value="getMenuListsByMenuno"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/foodOrder2/foodorder2.do" style="margin-bottom: 0px;">
			    <input type="submit" value="加入餐車" > 
			    <input type="hidden" name="menuno" value="${menuVO.menuNo}">
			    <input type="hidden" name="action" value="addMenuIntoCart"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

<%if (request.getAttribute("listMenuList_ByMenuno")!=null){%>
       <jsp:include page="listMenuListByMenuno.jsp" />
<%} %>
<%if (session.getAttribute("shoppingCart")!=null){%>
       <jsp:include page="ShoppingCart.jsp" />
<%} %>


    
    
   <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/foodOrder2/foodorder2.do" style="margin-bottom: 0px;">
 開始日期:<input type="text"   name="startDate" id="start_date" ><br><br>
 結束日期:<input type="text"   name="endDate"   id="end_date"  >
			    <input type="submit" value="開始點餐" > 
			    <input type="hidden" name="action" value="beginOrder"></FORM>


</body>

<script>
$.datetimepicker.setLocale('zh'); // kr ko ja en
$(function(){
	 $('#start_date').datetimepicker({
	  format:'Y-m-d',
	  onShow:function(){
	   this.setOptions({
	    maxDate:$('#end_date').val()?$('#end_date').val():false
	   })
	  },
	  timepicker:false
	 });
	 
	 $('#end_date').datetimepicker({
	  format:'Y-m-d',
	  onShow:function(){
	   this.setOptions({
	    minDate:$('#start_date').val()?$('#start_date').val():false
	   })
	  },
	  timepicker:false
	 });
});
</script>






</html>