<%@page import="com.impression.model.ImpressionVO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.activity.model.*"%>

<jsp:useBean id="act_imp" scope="request" type="java.util.Set<ImpressionVO>" /> <!-- ��EL����i�ٲ� -->
<jsp:useBean id="activitySvc" scope="page" class="com.activity.model.ActivityService" />


<html>
<head><title>���ʤ߱o - act_imp.jsp</title>

<style>
  table#table-2 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-2 h4 {
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
	width: container-fluid;
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
<table id="table-2">
	<tr>
		<td>
		 	<h3>���ʤ߱o - act_imp.jsp</h3>
		 	<h4><a href="<%=request.getContextPath()%>/front-end/impression/impsearch.jsp"><img src="<%=request.getContextPath()%>/front-end/activity/img/back1.gif" width="100" height="32" border="0">�^����</a></h4>
		</td>
	</tr>
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
		<th>�߱o�s��</th>
		<th>�߱o�ɶ�</th>
		<th>�߱o�W��</th>
		<th>���ʽs��</th>
		<th>�|���s��</th>
		<th>��r�߱o���e</th>
		<th>�v������</th>
		<th>�Ӥ��O��</th>
		<th>��������</th>
		<th>�ק�</th>
		<th>�R��</th>
	</tr>
	
	<c:forEach var="ImpressionVO" items="${act_imp}" >
		<tr>
			<td>${ImpressionVO.impNo}</td>
			<td>${ImpressionVO.impTime}</td>
			<td>${ImpressionVO.impName}</td>
			<td>${ImpressionVO.actNo}</td>
			<td>${ImpressionVO.memNo}</td>
			<td>${ImpressionVO.impCon}</td>
<!-- �v��			 -->
			<c:choose>
				<c:when test="${(ImpressionVO.recVideo)!=null}">
			<td>
				<video width="400" controls>
				<source src="<%= request.getContextPath() %>/impression/impressionVideo.do?impNo=${ImpressionVO.impNo} " type="video/mp4"/>
				</video>
			</td>
				</c:when>
				<c:otherwise >
			<td>
			<img src="<%=request.getContextPath()%>/front-end/activity/img/no-video.png">
			</td>
				</c:otherwise>
			</c:choose>
<!-- �Ӥ�			 -->
			<c:choose>
				<c:when test="${(ImpressionVO.recPic)!=null}">
			<td>
				<img src="<%= request.getContextPath() %>/impression/impressionPic.do?impNo=${ImpressionVO.impNo} " height=50%/>
			</td>
				</c:when>
				<c:otherwise >
			<td>
			<img src="<%=request.getContextPath()%>/front-end/activity/img/nopic.jpg">
			</td>
				</c:otherwise>
			</c:choose>
			
			<td>${ImpressionVO.impField}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/impression/impression.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�">
			     <input type="hidden" name="impNo"  value="${ImpressionVO.getImpNo()}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/impression/impression.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�R��">
			     <input type="hidden" name="impNo"  value="${ImpressionVO.getImpNo()}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

<br>�����������|:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>