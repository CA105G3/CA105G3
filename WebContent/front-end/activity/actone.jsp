<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.activity.model.*"%>

<%  String memNo=(String)session.getAttribute("memno");
pageContext.setAttribute("memNo", memNo);
	ActivityService actSvc = new ActivityService();
	List<ActivityVO> activitylist = actSvc.findmyact(memNo);
	pageContext.setAttribute("activitylist", activitylist);
%>

<html>
<head>

<title>我建立的活動-actone.jsp</title>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+TC">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.css" />
	<script src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.full.js"></script>
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

<style>
  table {
	width: container-fluid;
	background-color: white;
	margin-top: 10px;
	margin-bottom: 10px;
	
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th{
  	text-align: center;
  }
  th, td {
    padding: 5px;
  }
  img{
		 max-height:300px;
		 max-width: 300px; 
		 vertical-align:middle;
	 }
</style>
	
</head>

<body>
	<header style="background-image:url('<%=request.getContextPath()%>/front-end/activity/img/act1.gif'); height:150px;background-repeat: no-repeat;
    background-attachment: fixed;background-position: center;background-size: cover;">
		<span>&nbsp;</span><br>
		<span>&nbsp;</span>
			<h3 class="title"><span><b>我建立的活動</b></span></h3>
			<h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><batton class="btn btn-Success" style="margin-right:20px;">回首頁</batton></a></h4>
	</header>

<table>
	<tr style="background-image: linear-gradient(120deg, #e0c3fc 0%, #8ec5fc 100%);">
		<th>活動編號</th>
		<th>活動名稱</th>
		<th>活動地點</th>
		<th>活動時間</th>
		<th>活動狀態</th>
		<th>活動最少人數</th>
		<th>活動最多人數</th>
		<th>活動敘述</th>	
		<th>舉辦活動圖片</th>	
		<th>修改</th>	

		
	</tr>
	<c:forEach var="activityVO" items="${activitylist}" >
		<tr>
			<td>${activityVO.actNo}</td>
			<td>${activityVO.actName}</td>
			<td>${activityVO.actLoc}</td>
			<td>${activityVO.actTime}</td>
			<td>${activityVO.actStatus}</td>
			<td>${activityVO.actLimit}</td>
			<td>${activityVO.actMax}</td>
			<td>${activityVO.actDesc}</td>
<!-- 照片			 -->
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
					<input type="submit" value="修改" class="btn btn-info">
			     	<input type="hidden" name="timeCheck"  value="${activityVO.timeCheck}">
			     	<input type="hidden" name="actNo"  value="${activityVO.actNo}">
			     	<input type="hidden" name="memNo"  value="${activityVO.memNo}">
			     	<input type="hidden" name="action"	value="getOne_For_Update" >
			     	
				</form>
			</td>
		</tr>
	</c:forEach>
</table>


</body>
</html>