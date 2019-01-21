<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.foodorder.model.*" %>
<%@ page import="com.orderdetail.model.*" %>
<%@ page import="com.menulist.model2.*" %>
<%@ page import="com.member.model.*" %>

<jsp:useBean id="listOds_ByOrderno" scope="request" type="java.util.Set<OrderDetailVO>" /> <!-- ��EL����i�ٲ� -->
<jsp:useBean id="foodOrderSvc" scope="page" class="com.foodorder.model.FoodOrderService" />

<% 
  MemberVO memVO = (MemberVO)session.getAttribute("memVO");
%>
<%-- <jsp:useBean id="menuListSvc" scope="page" class="com.menulist.model2.MenuListService" /> --%>

<html>
<meta charset="UTF-8">

<style type="text/css">
table {
  border-collapse: collapse;
  width: 100%;
  box-shadow: 5px 5px #888888;
}
td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}
tbody:nth-child(even) {
  background-color: #dddddd;
}
font {
	font-weight: bold;
	font-family: "�L�n������";
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
<head>
    <title >Health PLUS</title>
    <meta charset="utf-8">
</head>

<body>
<div class="container">
	<h3><font><%=memVO.getMemName() %>���q�\����</font></h3>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">�Эץ��H�U���~�G</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
		<table class="table">
	  	<thead class="thead-dark">
			<tr>
				<th>�q����ӽs��</th>
				<th>�\�I�W��</th>
				<th>���\�ɬq</th>
				<th>���</th>
				<th>�ƶq</th>
			</tr>
		</thead>
		<c:forEach var="orderDetailVO" items="${listOds_ByOrderno}" >
				<tbody>
					<tr>
					 <td>${orderDetailVO.odno}</td>
					 <td>${orderDetailVO.mainCourse}</td>
					 <td>${orderDetailVO.menuDate} ${menuListVO.menuTimeSlot}</td>
					 <td>${orderDetailVO.unitPrice}</td>
					 <td>${orderDetailVO.amount}</td>
					</tr>
				</tbody>
		</c:forEach>
		</table>
</div>
</body>

</html>