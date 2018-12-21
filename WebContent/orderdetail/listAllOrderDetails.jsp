<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%> 
<%@ page import="com.orderdetail.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    OrderDetailService orderDetailSvc = new OrderDetailService();
    List<OrderDetailVO> list = orderDetailSvc.getAll();
    pageContext.setAttribute("list", list);
%>
<html>
<head>
<title>所有訂單明細 - listAllOrderDetails.jsp</title>

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
		 <h3>所有訂單明細 - listAllOrderDetails.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
		<th>訂單明細編號</th>
		<th>訂單編號</th>
		<th>菜色編號</th>
		<th>數量</th>
		<th>單價</th>
		<th>刪除</th>
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
			     <input type="submit" value="刪除">
			     <input type="hidden" name="odno"  value="${orderDetailVO.odno}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>


</body>
</html>