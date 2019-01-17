<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.activity.model.*"%>
<%@ page import="com.member.model.*"%>

<% 
String memNo=(String)session.getAttribute("memno");
pageContext.setAttribute("memNo", memNo);
ActivityVO activityVO = (ActivityVO)request.getAttribute("activityVO");
%>

<html>
<head>
<title>活動資料-actone.jsp</title>
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
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

</head>

<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>員工資料 - actone.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="<%=request.getContextPath()%>/front-end/activity/img/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>活動編號</th>
		<th>舉辦人編號</th>
		<th>活動名稱</th>
		<th>活動地點</th>
		<th>活動時間</th>
		<th>活動狀態</th>
		<th>活動最多人數</th>
		<th>活動最少人數</th>
		<th>活動成立判定時間</th>
		<th>活動照片</th>
		<th>活動敘述</th>	
		<th>參加活動</th>	
	
		
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
					<input type="submit" class="btn btn-primary" value="參加" id="sumbit">
					<input type="hidden" name="actNo"  value="${activityVO.actNo}">
			     	<input type="hidden" name="memNo"  value="${memNo}">
			     	<input type="hidden" name="actStatus"  value="${activityVO.actStatus}">
			     	<input type="hidden" name="action"	value="Join_act">
				</form>
			</td>

		</tr>
</table>
<script type="text/javascript">
var remaining = ${remaining};
console.log(remaining);
	$(function(){
		if(remaining===0){
			$('#sumbit').attr('disabled',true).css('opacity',0.3);
	 	}
	})
</script>

</body>
</html>