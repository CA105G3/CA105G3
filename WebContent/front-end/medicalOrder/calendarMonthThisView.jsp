<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.doctoravailable.controller.*,java.util.*,java.io.*,java.sql.*"%>
<%-- <%@page import="com.doctoravailable.model.DravailableService"%> --%>
<%-- <%@page import="com.doctoravailable.model.DravailableVO"%> --%>
<%-- <%@page import="com.doctor.model.DoctorVO"%> --%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>


<%-- <%@ include file="calendarCommon.jsp"%> --%>

<html>
<head>
<link rel="StyleSheet" href="calendar.css" type="text/css" media="screen" />
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>設定可預約時間</title>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" >
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" rel="stylesheet" >
<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
<style type="text/css">
.event {
	border-top: 1px solid #b2dba1;
	border-bottom: 1px solid #b2dba1;
	background-image: linear-gradient(to bottom, #dff0d8 0px, #c8e5bc 100%);
	background-repeat: repeat-x;
	color: #3c763d;
	border-width: 1px;
	font-size: .75em;
	padding: 0 .75em;
	line-height: 2em;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	margin-bottom: 1px;
}

.event.begin {
	border-left: 1px solid #b2dba1;
	border-top-left-radius: 4px;
	border-bottom-left-radius: 4px;
}

.event.end {
	border-right: 1px solid #b2dba1;
	border-top-right-radius: 4px;
	border-bottom-right-radius: 4px;
}

.event.all-day {
	border-top: 1px solid #778899;
	border-bottom: 1px solid #778899;
	background-image: linear-gradient(to bottom, #DCDCDC 0px, #DCDCDC 100%);
	background-repeat: repeat-x;
	color: #778899;
	border-width: 1px;
}

.event.all-day.begin {
	border-left: 1px solid #9acfea;
	border-top-left-radius: 4px;
	border-bottom-left-radius: 4px;
}

.event.all-day.end {
	border-right: 1px solid #9acfea;
	border-top-right-radius: 4px;
	border-bottom-right-radius: 4px;
}

.event.clear {
	background: none;
	border: 1px solid transparent;
}
</style>

<!-- Custom Fonts -->
<link href="<%=request.getContextPath()%>/doctor/admin/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">


</head>

<body id="print_view_page">


	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message }</li>
			</c:forEach>
		</ul>
	</c:if>
	
<div class="container-fluid">
    <div class="row">
		<table class="table" id="table-1">
			<tr>
				<td>
				</td>
				<td align="right">
				<form method="post" action="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do">
					<input type="hidden" name="action" value="calendarMonthNextView">
					<input type="hidden" name="month" value="<%=nextMonth%>">
					<input type="hidden" name="year" value="<%=nextYear%>">
					<input type="hidden" name="drno" value="<%=drno%>">
					<input type="submit" value="下個月" class="btn btn-info">
				</form>
			</tr>
		</table>

	<div id="calendar_print_view_main_div" style="overflow-y: auto;">
		<table border="1" cellspacing="0" cellpadding=4 width="80%"
			height="100%" id="calendar_table" class="table">
			<tr>
				<td colspan="7" class="month_year_header"><%=monthName%>, <%=intYear%>
				</td>
			</tr>
			<tr class="week_header_row">
				<th width="14%" class="th_day_cell day">Sun</th>
				<th width="14%" class="th_day_cell day">Mon</th>
				<th width="14%" class="th_day_cell day">Tue</th>
				<th width="14%" class="th_day_cell day">Wed</th>
				<th width="14%" class="th_day_cell day">Thu</th>
				<th width="15%" class="th_day_cell day">Fri</th>
				<th width="15%" class="th_day_cell day">Sat</th>
			</tr>
			<%
				{
					Month aMonth = Month.getMonth(Integer.parseInt(currentMonthString),
							Integer.parseInt(currentYearString));
					int[][] days = aMonth.getDays();
					for (int i = 0; i < aMonth.getNumberOfWeeks(); i++) {
			%>
			<tr>
				<%
					for (int j = 0; j < 7; j++) {
								if (days[i][j] == 0) {
				%>
				<td class="empty_day_cell">&nbsp;</td>
				<%
					} else {
									int morning = (days[i][j] - 1) * 3;
									int afternoon = (days[i][j] - 1) * 3 + 1;
									int night = (days[i][j] - 1) * 3 + 2;
									int day =days[i][j];
									Map<String, String> morningMap = (Map<String, String>) avaTime.get(morning);
									Map<String, String> afternoonMap = (Map<String, String>) avaTime.get(afternoon);
									Map<String, String> nightMap = (Map<String, String>) avaTime.get(night);
									pageContext.setAttribute("morningMap", morningMap);
									pageContext.setAttribute("afternoonMap", afternoonMap);
									pageContext.setAttribute("nightMap", nightMap);
									pageContext.setAttribute("IntNowday", IntNowday);
									pageContext.setAttribute("IntNowHour", IntNowHour);
									pageContext.setAttribute("day", day);
									pageContext.setAttribute("intMonth", intMonth);
				%>

				<td align="right" valign="top" class="day_cell">${day}
					<table class="table table-hover">

						
						<div style="text-align: left" "data-index="310" id=<%=morning%>
							data-value="${morningMap['可否預約']}">
							<form action="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do">
								<strong>09:00~12:00 可預約時段
<c:choose><c:when test="${morningMap['可否預約']  =='V' && (IntNowday < day)}">
								<input type="submit" value="預約" ></c:when></c:choose>
<c:choose><c:when test="${morningMap['可否預約']  =='V' && (IntNowday == day && IntNowHour < 12)}">
								<input type="submit" value="預約" ></c:when></c:choose>
								</strong> 							
								<input type="hidden" class="dravano" name="dravano" value="${morningMap['dravano']}">
								<input type="hidden" name="drno" value="${morningMap['drno']}">
								<input type="hidden" name="可否預約" value="${morningMap['可否預約']}">
								<input type="hidden" name="index" value="${morningMap['index']}">
								<input type="hidden" name="year" value="<%=intYear%>">
								<input type="hidden" name="date" value="<%=days[i][j]%>">
								<input type="hidden" name="hour" value="9:00~12:00">
								<input type="hidden" name="month" value="<%=intMonth +1%>">								
								<input type="hidden" name="action" value="reserve2">	
							</form>
						</div>

						<div style="text-align: left" data-index="310" id=<%=afternoon%>
							name="test" data-value="${afternoonMap['可否預約']}">
							<form action="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do">
								<strong>13:00~16:00 可預約時段
<c:choose><c:when test="${afternoonMap['可否預約']  =='V' && (IntNowday < day)}">
								<input type="submit" value="預約" ></c:when></c:choose>
<c:choose><c:when test="${afternoonMap['可否預約']  =='V' && (IntNowday == day && IntNowHour < 16)}">
								<input type="submit" value="預約" ></c:when></c:choose>
								</strong> 						
								<input type="hidden" class="dravano" name="dravano" value="${morningMap['dravano']}">
								<input type="hidden" name="drno" value="${afternoonMap['drno']}">
								<input type="hidden" name="可否預約" value="${afternoonMap['可否預約']}">
								<input type="hidden" name="index" value="${afternoonMap['index']}">
								<input type="hidden" name="year" value="<%=intYear%>">
								<input type="hidden" name="month" value="<%=intMonth +1%>">
								<input type="hidden" name="date" value="<%=days[i][j]%>">
								<input type="hidden" name="hour" value="13:00~16:00">								
								<input type="hidden" name="action" value="reserve2">	
							</form>
						</div>

						<div style="text-align: left" data-index="310" id=<%=night%>
							data-value="${nightMap['可否預約']}">
							<form action="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do">
							 	<strong>17:00~20:00 可預約時段
<c:choose><c:when test="${nightMap['可否預約']  =='V' && (IntNowday < day)}">
								<input type="submit" value="預約" ></c:when></c:choose>
<c:choose><c:when test="${nightMap['可否預約']  =='V' && (IntNowday == day && IntNowHour < 20)}">
								<input type="submit" value="預約" ></c:when></c:choose>
							 	</strong>
								<input type="hidden" class="dravano" name="dravano" value="${nightMap['dravano']}">
								<input type="hidden" name="drno" value="${nightMap['drno']}">
								<input type="hidden" name="可否預約" value="${nightMap['可否預約']}">
								<input type="hidden" name="index" value="${nightMap['index']}">
								<input type="hidden" name="year" value="<%=intYear%>">
								<input type="hidden" name="month" value="<%=intMonth +1%>">								
								<input type="hidden" name="date" value="<%=days[i][j]%>">
								<input type="hidden" name="hour" value="17:00~20:00">
								<input type="hidden" name="action" value="reserve2">
							</form>
						</div>

						</tbody>
					</table></td>
				<%
					}
							} // end for
				%>
			</tr>
			<%
				}
				}
			%>
		</table>
	</div>



	</div>
</div>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<script src="https://code.jquery.com/jquery.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
		window.onload = function() {
			for (var i = 0; i < <%=daysInCurrentMonth%> * 3; i++) {
				var element = document.getElementById(i);
// 				console.log(element);
				element.style.cursor = 'pointer';

				//抓出當前時間可以預約的時段
				var nowMonth = (new Date().getMonth())+1;
				var nowDay = new Date().getDate();
				var nowHour = (new Date().getHours());
				var intMonth = ${intMonth+1};
				var intDay =${day}

				if( nowHour < 12){
					idCount = -3;
				}else if ( 12 <= nowHour < 16){
					idCount = -2;
				}else if ( 16 <= nowHour < 20){
					idCount = -1;
				}else{
					idCount = 0;
				}
				
				var nowHourId = nowDay*3 + idCount;
				
				console.log(nowHourId);
				
				
				if( i <= nowHourId){
						element.className = 'event all-day begin end';	
				}else if( i > nowHourId){
					if (element.getAttribute('data-value') == "V")
						element.className = 'event begin end'; 
					else
						element.className = 'event all-day begin end';		
				};
						
				//註冊一個onclick,觸發無法預約的提醒
				element.onclick = function(){
					var element = this;
					if(element.id < <%=(currentDayInt - 1) * 3%>){ //還沒處理完當天時間
						window.alert("無法預約過去日期");
						return;
					}
					if (element.getAttribute('data-value') != "V"){
						window.alert("無法進行預約");
						return;
					} else {
// 						$('#myModal').modal('show')
					}	
				}
			}
			var days = document.getElementsByClassName("day_cell");
			days[<%=currentDayInt - 1%>].className = "today_cell";	
		}
	</script>
</body>
</html>


