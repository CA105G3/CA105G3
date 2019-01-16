<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>餐飲index</title>

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
  		<font size="20" color="white"><b>餐飲查詢</b></font></td></tr>
<!--   <div class="centered"><font color="white" size="50">餐飲查詢</font></div> -->
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

<p><h3>餐點查詢</h3></p>
<ul> 
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/shoppingCart.do" >
         依業者名稱查詢 (如 "三普"):
        <input type="text" name="chefRep">
        <input type="hidden" name="action" value="getMenu_by_chefRep">
        <input type="submit" value="送出">
    </FORM>
  </li>
 <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/shoppingCart.do" >
         依供餐時段查詢 (如 "早"):
        <input type="text" name="menuTimeSlot">
        <input type="hidden" name="action" value="getMenu_by_menuTimeSlot">
        <input type="submit" value="送出">
    </FORM>
  </li>
</ul>
</body>
</html>