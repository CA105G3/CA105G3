<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.reportdr.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
    ReportDrService rdSvc = new ReportDrService();
    List<ReportDrVO> list = rdSvc.getAllReportDr();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>�Ҧ����|���� - listAllReportDr.jsp</title>

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

<h4>�����m�߱ĥ� EL ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>�Ҧ����|���� - listAllReportDr.jsp</h3>
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
		<th>���|�s��</th>
		<th>���|�̷|���s��</th>
		<th>�Q���|�������H���s��</th>
		<th>���|�z��</th>
		<th>���|�ɶ�</th>
		<th>�B�z���A</th>

	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="ReportDrVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${ReportDrVo.rdrNo}</td>
			<td>${ReportDrVo.memNo}</td>
			<td>${ReportDrVo.drNo}</td>
			<td>${ReportDrVo.rdrReason}</td>	
			<td><fmt:formatDate value="${ReportDrVo.rdrTime}" pattern="yyyy-MM-dd"/></td>
			<td>${ReportDrVo.rdrState}</td> 
	<!--	<td><fmt:formatDate value="${empVO.hiredate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>	�b�ɶ���ܤQ�i�H�Τ��P�覡���-->			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/reportDr/reportDrServlet.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�">
			     <input type="hidden" name="rdrNo"  value="${ReportDrVo.rdrNo}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/reportDr/reportDrServlet.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�R��">
			     <input type="hidden" name="rdrNo"  value="${ReportDrVo.rdrNo}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>