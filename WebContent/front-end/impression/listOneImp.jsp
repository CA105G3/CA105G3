<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.impression.model.*"%>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
	String memNo=(String)session.getAttribute("memno");
	pageContext.setAttribute("memNo", memNo);
	ImpressionService impSvc = new ImpressionService();
	List<ImpressionVO> list = impSvc.myimpression(memNo);
	System.out.println(list);
	request.setAttribute("list", list);
%>

<html>
<head>
<title>�ڪ��߱o - listOneImp.jsp</title>

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
  word-wrap{
   word-break: break-all;
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
<body bgcolor='white'>

<h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>�ڪ��߱o- ListOneImp.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="<%=request.getContextPath()%>/front-end/impression/img/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>�߱o�s��</th>
		<th>�߱o�ɶ�</th>
		<th>�߱o�D��</th>
		<th>���ʽs��</th>
		<th>�|���s��</th>
		<th>�߱o���e</th>
		<th>�v��</th>
		<th>�Ӥ�</th>
		<th>��������</th>
	</tr>
	
	<%@ include file="page1.file" %> 
	<c:forEach var="list" items="${list}" begin="<%= pageIndex %>" end="<%=pageIndex+rowsPerPage-1%>">
	<tr>
			<td>${list.impNo}</td>
			<td>${list.impTime}</td>
			<td>${list.impName}</td>
			<td>${list.actNo}</td>
			<td>${list.memNo}</td>
			<td>${list.impCon}</td>
<!--�v�� -->
			<c:choose>
				<c:when test="${(list.recVideo)!=null}">
			<td>
				<video width="400" controls>
				<source src="<%= request.getContextPath() %>/impression/impressionVideo.do?impNo=${list.impNo} " type="video/mp4"/>
				</video>
			</td>
				</c:when>
				<c:otherwise >
			<td>
			<img src="<%=request.getContextPath()%>/front-end/impression/img/no-video.png">
			</td>
				</c:otherwise>
			</c:choose>
<!--�Ӥ� -->			
				<c:choose>
					<c:when test="${(list.recPic)!=null}">
						<td>
							<img src="<%= request.getContextPath() %>/impression/impressionPic.do?impNo=${list.impNo} " height=50%/>
						</td>
					</c:when>
				<c:otherwise >
					<td>
						<img src="<%=request.getContextPath()%>/front-end/impression/img/nopic.jpg">
					</td>
				</c:otherwise>
				</c:choose> 
			<td>${list.impField}</td>
			<td>
				<form METHOD="post" action="<%=request.getContextPath()%>/impression/impression.do" style="margin-bottom: 0px;">
					<input type="submit" value="�ק�">
			     	<input type="hidden" name="impNo"  value="${list.impNo}">
			     	<input type="hidden" name="action"	value="getOne_For_Update">
				</form>
			</td>
	</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>
</body>
</html>