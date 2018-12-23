<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.reportdr.model.*"%>

<%
    ReportDrService rdSvc = new ReportDrService();
    List<ReportDrVO> list = rdSvc.getNeedUpdate();
    pageContext.setAttribute("list",list);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>未處理的醫療人員檢舉--getNeedUpdate.jsp</title>
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
<body>

<table id="table-1">
	<tr><td>
		 <h3>未處理的醫療人員檢舉 - getNeedUpdate.jsp</h3>
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
		<th>檢舉編號</th>
		<th>檢舉者會員編號</th>
		<th>被檢舉之醫療人員編號</th>
		<th>檢舉理由</th>
		<th>檢舉時間</th>
		<th>處理狀態</th>

	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="reportDrVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${reportDrVO.rdrNo}</td>
			<td>${reportDrVO.memNo}</td>
			<td>${reportDrVO.drNo}</td>
			<td>${reportDrVO.rdrReason}</td>	
			<td><fmt:formatDate value="${reportDrVO.rdrTime}" pattern="yyyy-MM-dd"/></td>
			<td>${reportDrVO.rdrState}</td> 
	<!--	<td><fmt:formatDate value="${empVO.hiredate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>	在時間顯示十可以用不同方式顯示-->			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/reportDr/reportDrServlet.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="rdrNo"  value="${reportDrVO.rdrNo}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>


</body>
</html>