<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%> 
<%@ page import="com.orderdetail.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
    OrderDetailService orderDetailSvc = new OrderDetailService();
    List<OrderDetailVO> list = orderDetailSvc.getAll();
    pageContext.setAttribute("list", list);
%>
<html>
<head>
<title>�Ҧ��q����� - listAllOrderDetails.jsp</title>

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
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>�Ҧ��q����� - listAllOrderDetails.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
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

<table>
	<tr>
		<th>�q����ӽs��</th>
		<th>�q��s��</th>
		<th>���s��</th>
		<th>�ƶq</th>
		<th>���</th>
		<th>�R��</th>
	</tr>
	
	<c:forEach var="orderDetailVO" items="${list}" >
		
		<tr>
			<td>${orderDetailVO.odno}</td>
			<td>${orderDetailVO.orderno}</td>
			<td>${orderDetailVO.menuListno}</td>
			<td>${orderDetailVO.amount}</td>
			<td>${orderDetailVO.unitPrice}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/orderdetail/orderdetail.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�R��">
			     <input type="hidden" name="odno"  value="${orderDetailVO.odno}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>


</body>
</html>