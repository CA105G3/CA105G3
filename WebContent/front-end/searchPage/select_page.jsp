<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>繺都index</title>

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
  		<font size="20" color="white"><b>繺都琩高</b></font></td></tr>
<!--   <div class="centered"><font color="white" size="50">繺都琩高</font></div> -->
</table>
	
<%-- 岿粇 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">叫タ岿粇:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<p><h3>繺翴琩高</h3></p>
<ul> 
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/shoppingCart.do" >
         ㄌ穨嘿琩高 ( "炊"):
        <input type="text" name="chefRep">
        <input type="hidden" name="action" value="getMenu_by_chefRep">
        <input type="submit" value="癳">
    </FORM>
  </li>
 <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/shoppingCart.do" >
         ㄌㄑ繺琿琩高 ( "Ν"):
        <input type="text" name="menuTimeSlot">
        <input type="hidden" name="action" value="getMenu_by_menuTimeSlot">
        <input type="submit" value="癳">
    </FORM>
  </li>
</ul>
</body>
</html>