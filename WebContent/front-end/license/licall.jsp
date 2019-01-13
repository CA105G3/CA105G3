<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.license.model.*"%>
<% 
	LicenseService licenseSvc = new LicenseService();
	List<LicenseVO> list = licenseSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<html>
<head>

<title>�d�ߩҦ�����-actall.jsp</title>
<style>
  table#table-1 {
	width:container-fluid;
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
    table-layout:fixed;
    
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
  	width:container-fluid;
	table-layout:fixed;
	word-break:break-all;
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
<body bgcolor = 'white'>

<table id="table-1">
	<tr><td>
		 <h3>�Ҧ��ҷӸ�� - licall.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/license/licensesearch.jsp"><img src="<%=request.getContextPath()%>/front-end/license/img/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<!-- ���~�C�� -->
<c:if test="${not empty erroeMsgs}">
	<font style="color:red">�Эץ��H�U���~</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>	
		</ul>
</c:if>

<table>
	<tr>
		<th>�ҷӽs��</th>
		<th>�|���s��</th>
		<th>�ҷӸ��</th>
		<th>�ҷӪ��A</th>
		<th>�ҷӴy�z</th>
		<th>�ҷӮɮ�</th>	
		<th>�ק�</th>	

		
	</tr>
	
	<%@ include file="page1.file"%>
	<c:forEach var="licenseVO" items="${list}" begin="<%= pageIndex %>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${licenseVO.licNo}</td>
			<td>${licenseVO.memNo}</td>
<!-- �Ӥ�	 -->
			<c:choose>
				<c:when test="${(licenseVO.licData)!=null}">
			<td>
				<img src="<%= request.getContextPath() %>/license/licensePic.do?licNo=${licenseVO.licNo} " height=50%/>
			</td>
				</c:when>
				<c:otherwise >
			<td>
			<img src="<%=request.getContextPath()%>/front-end/license/img/nopic.jpg">
			</td>
				</c:otherwise>
			</c:choose>
			<td>${licenseVO.licStatus}</td>
			<td>${licenseVO.licDesc}</td>
			<td>${licenseVO.licDue}</td>

			<td>
				<form METHOD="post" action="<%=request.getContextPath()%>/license/license.do" style="margin-bottom: 0px;">
					<input type="submit" value="�ק�">
			     	<input type="hidden" name="licNo"  value="${licenseVO.licNo}">
			     	<input type="hidden" name="action"	value="getOne_For_Update">
				</form>
				
			  	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/license/license.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�R��">
			     <input type="hidden" name="licNo"  value="${licenseVO.licNo}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>

	</c:forEach>
</table>

<%@ include file="page2.file" %>


</body>
</html>