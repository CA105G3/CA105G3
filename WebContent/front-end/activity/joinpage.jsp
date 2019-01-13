<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.activity.model.*"%>
<%@ page import="com.member.model.*"%>

<% 
	String memNo = "M0001";
	pageContext.setAttribute("memNo", memNo);
	ActivityVO activityVO = (ActivityVO)request.getAttribute("activityVO");
%>

<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath()%>/template/css/style.css">
<title>���ʸ��-actone.jsp</title>
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
  word-wrap{
   word-break: break-all;
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

<table id="table-1">
	<tr><td>
		 <h3>���u��� - actone.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="<%=request.getContextPath()%>/front-end/activity/img/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>���ʽs��</th>
		<th>�|��H�s��</th>
		<th>���ʦW��</th>
		<th>���ʦa�I</th>
		<th>���ʮɶ�</th>
		<th>���ʪ��A</th>
		<th>���ʳ̦h�H��</th>
		<th>���ʳ̤֤H��</th>
		<th>���ʦ��ߧP�w�ɶ�</th>
		<th>���ʷӤ�</th>
		<th>���ʱԭz</th>	
		<th>�ѥ[����</th>	
	
		
	</tr>
	
		<tr>
			<td>${activityVO.actNo}</td>
			<td>${activityVO.memNo}</td>
			<td>${activityVO.actName}</td>
			<td>${activityVO.actLoc}</td>
			<td>${activityVO.actTime}</td>
			<td>${activityVO.actStatus}</td>
			<td>${activityVO.actMax}</td>
			<td>${activityVO.actLimit}</td>
			<td>${activityVO.timeCheck}</td>
			<td>${activityVO.actDesc}</td>
<!-- �Ӥ�			 -->
			<c:choose>
				<c:when test="${(activityVO.actPic)!=null}">
					<td>
						<img src="<%= request.getContextPath() %>/activity/activityPic.do?actNo=${activityVO.actNo}" height=50% weight=50%/>
					</td>
				</c:when>
				<c:otherwise >
					<td>
						<img src="<%=request.getContextPath()%>/front-end/activity/img/nopic.jpg">
					</td>
				</c:otherwise>
			</c:choose>

			<td>
				<form METHOD="post" action="<%=request.getContextPath()%>/activity/activity.do" style="margin-bottom: 0px;">
					<input type="submit" class="btn btn-primary" value="�ѥ[">
					<input type="hidden" name="actNo"  value="${activityVO.actNo}">
			     	<input type="hidden" name="memNo"  value="${ memNo}">
			     	<input type="hidden" name="actStatus"  value="${activityVO.actStatus}">
			     	<input type="hidden" name="action"	value="Join_act">
				</form>
			</td>

		</tr>
</table>


</body>
</html>