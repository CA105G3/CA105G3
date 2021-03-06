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
 	font-family:Microsoft JhengHei;
 	font-size:200%;
 }
  h4 {
    color: #FF0088;
    text-align:right;
  }

</style>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/css/normalize.css"/>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/css/default.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/css/styles.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/css/zebra.css">
	<script src="<%=request.getContextPath()%>/template/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/template/js/jquery.min.js"></script>
</head>
<body style="background-image:url('<%=request.getContextPath()%>/front-end/activity/img/bridge.jpg');background-repeat: no-repeat;
    background-attachment: fixed;
    background-position: center;background-size: cover;">
    
	<header style="background-image:url('<%=request.getContextPath()%>/front-end/activity/img/act1.gif'); height:150px;background-repeat: no-repeat;
    background-attachment: fixed;background-position: center;background-size: cover;">
		<span>&nbsp;</span><br>
		<span>&nbsp;</span>
			<h3 class="title"><span><b>所有募集中的活動</b></span></h3>
			<h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><batton class="btn btn-Success" style="margin-right:20px;">回首頁</batton></a></h4>
	</header>

<!-- 錯誤列表 -->
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>	
		</ul>
</c:if>
<br>
<br>
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
				<img src="<%= request.getContextPath()%>/activity/activityPic.do?actNo=${actlist.actNo}" height=50% width=50%/>
			</td>
				</c:when>
				<c:otherwise>
			<td>
			<img src="<%= request.getContextPath()%>/front-end/activity/img/nopic.jpg">
			</td>
				</c:otherwise>
			</c:choose>
		    <h2>${actlist.actName}</h2>
<jsp:useBean id="getmem" scope="page" class="com.joinact.model.JoinActService" ></jsp:useBean>
<c:set var="zebra" scope="request" value="${getmem.getOneAct(actlist.actNo).size()}"/>
<c:set var="total" scope="request" value="${(zebra/actlist.actMax)*100}"/>
<c:set var="remaining" scope="request" value="${actlist.actMax-zebra}"/>
		    	<div class="container">
  					<div class="row">
            			<div class="col-md-offset-3 col-md-6">
            				<c:choose>
            					<c:when test="${actlist.actMax-zebra ==0 }">
									<h3 class="progress-title">已經額滿囉</h3>
										<div class="progress">
              								<div class="progress-bar progress-bar-danger progress-bar-striped bg-danger" style="width:${total}%">
              								</div>
        								</div>
       			 				</c:when>
       			 				<c:otherwise>	
       			 					<h3 class="progress-title">還有${actlist.actMax-zebra}個名額</h3>
       			 						<div class="progress">
              								<div class="progress-bar progress-bar-danger progress-bar-striped active" style="width:${total}%">
              								</div>
        								</div>
       			 				</c:otherwise>
       			 			</c:choose>		
        							
        							
        				</div>
        			</div>	
		    	</div>

		    <div>
		    	<form method="post" action="<%= request.getContextPath()%>/activity/activity.do">
			     	<input type="hidden" name="actNo"  value="${actlist.actNo}">
			     	<input type="hidden" name="memNo"  value="${memNo}">
			     	<input type="hidden" name="actStatus"  value="${actlist.actStatus}">
			     	<input type="hidden" name="remaining"  value="${remaining}">			     	
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