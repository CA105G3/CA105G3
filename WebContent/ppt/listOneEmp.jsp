<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.ppttool.model.*"%>
<%@page import="java.io.OutputStream" %>>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
  PPTToolVO pptVO = (PPTToolVO) request.getAttribute("empVO"); //EmpServlet.java(Concroller), �s�Jreq��empVO����
	pageContext.setAttribute("pptVO", pptVO);
%>

<html>
<head>
<title>PPT��� - listOneEmp.jsp</title>

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
	width: 600px;
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

<h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>���u��� - ListOneEmp.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>PPT�s��</th>
		<th>��v�s��</th>
		<th>PPT</th>
	</tr>
	<tr>
		<td><%=pptVO.getPptno()%></td>
		<td><%=pptVO.getDrno()%></td>
		<td><img src="<%=request.getContextPath()%>/ppt/pptImg.do?pptno=${pptVO.pptno} " /></td>
	</tr>
</table>

</body>
</html>