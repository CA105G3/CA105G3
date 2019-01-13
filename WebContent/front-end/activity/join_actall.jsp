<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.activity.model.*"%>
<%@ page import="com.joinact.model.*"%>
<%
	String memNo="M0001";
	pageContext.setAttribute("memNo", memNo); 
	JoinActService service = new JoinActService();
	List<JoinActVO> list = service.getAll();
	pageContext.setAttribute("list",list);
%>


<html>
<head>

<title>�Ҧ��Ҷ������� - join_actall.jsp</title>
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
  #table-1{
  	width:100%;
	table-layout:fixed;
	word-break:break-all;
  }
  table, th, td {
    border: 1px #FFAC55 solid;
    padding:1px;  
    
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
  body {
  	background-image:url('<%=request.getContextPath()%>/front-end/activity/img/bridge.jpg');
	opacity:1;
	filter:alpha(opacity=80);
	background-repeat: no-repeat;
    background-attachment: fixed;
    background-position: center;
    background-size: cover;
  }
</style>

</head>
<body bgcolor = 'white'>

<table id="table-1">
	<tr><td>
		 <h3>�Ҧ��Ҷ������� - join_actall.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="<%=request.getContextPath()%>/front-end/activity/img/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<!-- ���~�C�� -->
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>	
		</ul>
</c:if>

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
		<th>���ʱԭz</th>
		<th>�|�쬡�ʹϤ�</th>	
		<th>�ק�</th>	

		
	</tr>
	

	<c:forEach var="actlist" items="${actlist}" >

		<tr>
			<td>${actlist.actNo}</td>
			<td>${actlist.memNo}</td>
			<td>${actlist.actName}</td>
			<td>${actlist.actLoc}</td>
			<td>${actlist.actTime}</td>
			<td>${actlist.actStatus}</td>
			<td>${actlist.actMax}</td>
			<td>${actlist.actLimit}</td>
			<td>${actlist.timeCheck}</td>
			<td>${actlist.actDesc}</td>
<!-- �Ӥ�			 -->
			<c:choose>
				<c:when test="${(actlist.actPic)!=null}">
			<td>
				<img src="<%= request.getContextPath()%>/activity/activityPic.do?actNo=${actlist.actNo}" height=50% weight=50%/>
			</td>
				</c:when>
				<c:otherwise>
			<td>
			<img src="<%= request.getContextPath()%>/front-end/activity/img/nopic.jpg">
			</td>
				</c:otherwise>
			</c:choose>
			
			<td>
				<form method="post" action="<%= request.getContextPath()%>/activity/activity.do">
			     	<input type="hidden" name="actNo"  value="${actlist.actNo}">
			     	<input type="hidden" name="memNo"  value="${memNo}">
			     	<input type="hidden" name="actStatus"  value="${actlist.actStatus}">
			     	<input type="hidden" name="action"	value="Show__join_act">
					<button id="particpate" type="submit" value="">�ѥ[</button>
				</form>
			</td>
		</tr>

	</c:forEach>
</table>


  <script src="<%=request.getContextPath()%>/template/js/jquery.min.js"></script>
  
  <script type="text/javascript">
var action = ${action};

console.log(action);
$(function(){
	 if(action===0){
		 $('#particpate').attr('disabled',true);
		 <%pageContext.setAttribute("action",1);%>
	 }
	
})
 
	 


</script>
</body>
</html>