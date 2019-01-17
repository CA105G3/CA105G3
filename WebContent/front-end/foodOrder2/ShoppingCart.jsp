<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.* " %>
<%@ page import="com.foodorder2.model.* " %>
<html>
<head>
 <title>shoppingCart</title>
</head>
<body><br>


<table>
   <tr>
		<th>�\�I�W��</th>
		<th>�\�I����</th>
		<th>�\�I�Ӥ�</th>
		<th>�\�I���</th>
		<th>�h�X�\��</th>
	</tr>
	
	<c:forEach var="menuVO" items="${shoppingCart}">
		<tr>
			<td>${menuVO.mainCourse}</td>
			<td>${menuVO.menuIntro}</td>
			<td><img style="max-width: 190px; max-height: 250px;" src="<%=request.getContextPath()%>/front-end/foodOrder2/foodorderImg2.do?menuno=${menuVO.menuNo} "/></td>
			<td>${menuVO.unitPrice}</td>

			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/foodOrder2/foodorder2.do" style="margin-bottom: 0px;">
			    <input type="submit" value="�h�X�\��" > 
			    <input type="hidden" name="menuno" value="${menuVO.menuNo}">
			    <input type="hidden" name="action" value="deleteMenuFromCart"></FORM>
			</td> 
		</tr>
	</c:forEach>
</table>
</body>
</html>