<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>�\���q��d��</title>

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
  		<font size="20" color="white"><b>�\���q��d��</b></font></td></tr>
<!--   <div class="centered"><font color="white" size="50">�\���q��d��</font></div> -->
</table>
	
<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<p><h3>�̭q��s���d��</h3></p>
<ul>  
  <jsp:useBean id="foodOrderSvc" scope="page" class="com.foodorder.model.FoodOrderService" />
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/foodorder/foodorder.do" >
          �п�J�q��s�� (�p20181220-0001):
        <input type="text" name="orderno">
        <input type="hidden" name="action" value="getOrder_by_Orderno">
        <input type="submit" value="�e�X">
    </FORM>
  </li>
</ul>
<p>==========================================</p>
<p><h3>�̱b���BEmail�η|���s���d��</h3></p>
<ul> 
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/foodorder/foodorder.do" >
         �п�J�b�� (�p David):
        <input type="text" name="memId">
        <input type="hidden" name="action" value="getOrders_by_memId">
        <input type="submit" value="�e�X">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/foodorder/foodorder.do" >
        	�п�JEMAIL (�p david001@gmail.com):
        <input type="text" name="email">
        <input type="hidden" name="action" value="getOrders_by_email">
        <input type="submit" value="�e�X">
    </FORM>
  </li>
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/foodorder/foodorder.do" >
         �п�J�|���s�� (�p M0001):
        <input type="text" name="memno">
        <input type="hidden" name="action" value="getOrders_by_memno">
        <input type="submit" value="�e�X">
    </FORM>
  </li>
</ul>


<ul>
  <li><a href='addFoodOrder.jsp'>�ڭn�q�\</a></li>
</ul>

</body>
</html>