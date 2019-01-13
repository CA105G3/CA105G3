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

<title>所有募集中活動 - join_actall2.jsp</title>
 	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<style>
   h3.title{
 	text-align:center;
 }
  h4 {
    color: #FF0088;
    display: inline;
  }



</style>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/css/normalize.css"/>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/css/default.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/css/styles.css">
	<script src="<%=request.getContextPath()%>/template/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/template/js/jquery.min.js"></script>
</head>
<body style="background-image:url('<%=request.getContextPath()%>/front-end/activity/img/bridge.jpg');background-attachment: fixed;
    background-position: center;
    background-size: cover;">

<table>
	<tr><td>
		 <h3>所有募集中活動 - join_actall2.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="<%=request.getContextPath()%>/front-end/activity/img/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<!-- 錯誤列表 -->
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>	
		</ul>
</c:if>

		<div class="wall">
<c:forEach var="actlist" items="${actlist}" >		
<!-- 		  <a class="article"> -->
<%-- 		    <img src="<%= request.getContextPath()%>/activity/activityPic.do?actNo=${actlist.actNo}" /> --%>
<%-- 		    <h2>${actlist.actName}</h2> --%>
<!-- 		  </a> -->

		  <div class="article">
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
		    <h2>${actlist.actName}</h2>
		    <div>
		    	<form method="post" action="<%= request.getContextPath()%>/activity/activity.do">
			     	<input type="hidden" name="actNo"  value="${actlist.actNo}">
			     	<input type="hidden" name="memNo"  value="${memNo}">
			     	<input type="hidden" name="actStatus"  value="${actlist.actStatus}">
			     	<input type="hidden" name="action"	value="Show__join_act">
					<button id="particpate" type="submit" value="" class="btn btn-info" >查看詳情</button>
				</form>	
		    </div>
		  </div>
</c:forEach>		  
		</div>



<script src="<%=request.getContextPath()%>/template/js/jquery.min.js"></script>
<script src="http://libs.useso.com/js/jquery/2.1.1/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/front-end/activity/js/jaliswall.js"></script>
<script type="text/javascript">
	$(function(){
		$('.wall').jaliswall({ item: '.article' });
	});
</script>  
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
<script type="text/javascript">
  document.querySelector('#sortable').sortablejs()
</script>
</body>
</html>