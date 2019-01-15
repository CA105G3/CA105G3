<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.doctoravailable.controller.Month,java.util.*,java.io.*,java.sql.*"%>
<%@page import="com.doctoravailable.model.DravailableService"%>
<%@page import="com.doctoravailable.model.DravailableVO"%>
<%@page import="com.doctor.model.DoctorVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
	String drno = request.getParameter("drno");
	pageContext.setAttribute("drno", drno);
%>
<%-- <%=list == null%> --%>

<%
	List<Hashtable<String, String>> avaTime = (List<Hashtable<String, String>>) request.getAttribute("avaTime");
	pageContext.setAttribute("avaTime", avaTime);
%>



<%@ include file="calendarCommon.jsp"%>

<html>
<head>
<link rel="StyleSheet" href="<%=request.getContextPath() %>/front-end/doctoravailable/calendar.css" type="text/css"
	media="screen" />
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>設定可預約時間</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
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
	border-top: 1px solid #9acfea;
	border-bottom: 1px solid #9acfea;
	background-image: linear-gradient(to bottom, #d9edf7 0px, #b9def0 100%);
	background-repeat: repeat-x;
	color: #31708f;
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
/* #side-menu{ */
/*  text-align:left; */
/*  font-size:16px; */
/* } */
</style>


<!-- Bootstrap Core CSS -->
<link
	href="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link
	href="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- DataTables CSS -->
<link
	href="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link
	href="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link
	href="<%=request.getContextPath()%>/front-end/doctor/admin/dist/css/sb-admin-2.css"
	rel="stylesheet">

<!-- Custom Fonts -->
<link
	href="<%=request.getContextPath()%>/front-end/doctor/admin/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">




<style type="text/css">
.month_year_header {
	text-align: center;
	color: darkblue;
	font: 1.2em Verdana;
}

.panel {
  margin-bottom: 20px;
  background-color: #fff;
  border: 1px solid transparent;
  border-radius: 4px;
  -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
          box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
   width: fit-content;
}
</style>





</head>

<body >
<%@ include file="/front-end/doctor/doctorAdminNav.file"%>
	
	
	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">設定可預約時間</h1>

			</div>
			<div class="col-md-1 col-md-push-11">	
				<form method="post" action="dravailable.do">
						<input type="hidden" name="action" value="getSameDrschedule_By_Drno_Nextmonth">
						<input type="hidden" name="month" value="<%=nextMonth%>">
						<input type="hidden" name="year" value="<%=nextYear%>">
						<input type="hidden" name="drno" value="<%=drno%>">
						<input type="submit" value="下個月" class="btn btn-info">
				</form>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">




























<!-- 	<table class="table" id="table-1"> -->
<!-- 		<tr> -->
<!-- 			<td> -->
<!-- 				<h3>單一醫療人員行程 - getSameDrschedule_By_Drno.jsp</h3> -->
<!-- 				<h4> -->
<%-- 					<a href="<%=request.getContextPath()%>/doctor/admin/pages/index.jsp?drno=${drno}"><i --%>
<!-- 						class="fa fa-user-md fa-fw"></i>&nbsp;&nbsp;返回管理頁面</a> -->
<!-- 				</h4> -->
<!-- 			</td> -->
<!-- 			<td align="right"> -->
<!-- 			<form method="post" action="dravailable.do"> -->
<!-- 				<input type="hidden" name="action" value="getSameDrschedule_By_Drno_Nextmonth"> -->
<%-- 				<input type="hidden" name="month" value="<%=nextMonth%>"> --%>
<%-- 				<input type="hidden" name="year" value="<%=nextYear%>"> --%>
<%-- 				<input type="hidden" name="drno" value="<%=drno%>"> --%>
<!-- 				<input type="submit" value="下個月" class="btn btn-info"> -->
<!-- 			</form> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<!-- 	</table> -->

	<div id="calendar_print_view_main_div" style="overflow-y: auto;">
		<table  cellspacing="0" cellpadding=4 width="80%"
			height="100%" id="calendar_table" class="table">
			<tr>
				<td colspan="7" class="month_year_header"><%=monthName%>, <%=intYear%>
				</td>
<!-- 				<td align="right"> -->
<!-- 					<form method="post" action="dravailable.do"> -->
<!-- 						<input type="hidden" name="action" value="getSameDrschedule_By_Drno_Nextmonth"> -->
<%-- 						<input type="hidden" name="month" value="<%=nextMonth%>"> --%>
<%-- 						<input type="hidden" name="year" value="<%=nextYear%>"> --%>
<%-- 						<input type="hidden" name="drno" value="<%=drno%>"> --%>
<!-- 						<input type="submit" value="下個月" class="btn btn-info"> -->
<!-- 					</form> -->
<!-- 				</td> -->
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
									Map<String, String> morningMap = (Map<String, String>) avaTime.get(morning);
									Map<String, String> afternoonMap = (Map<String, String>) avaTime.get(afternoon);
									Map<String, String> nightMap = (Map<String, String>) avaTime.get(night);
									pageContext.setAttribute("morningMap", morningMap);
									pageContext.setAttribute("afternoonMap", afternoonMap);
									pageContext.setAttribute("nightMap", nightMap);
				%>

				<td align="right" valign="top" class="day_cell"><%=days[i][j]%>
					<table class="table table-hover">

						<div style="text-align: left" "data-index="310" id=<%=morning%>
							data-value="${morningMap['可否預約']}">
							<c:if test="${morningMap['可否預約'] == 'V'}">
								<strong>9:00~12:00 開放中</strong> 
                    		</c:if>
                    		<c:if test="${morningMap['可否預約'] != 'V'}">
								<strong>9:00~12:00+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong> 
                    		</c:if>
							
							<form action="">
								<input type="hidden" name="dravano" value="${morningMap['dravano']}">
								<input type="hidden" name="drno" value="${morningMap['drno']}">
								<input type="hidden" name="可否預約" value="${morningMap['可否預約']}">
								<input type="hidden" name="index" value="${morningMap['index']}">
								<input type="hidden" name="clock" value="9">
								<input type="hidden" name="requestURL"
									value="<%=request.getServletPath()%>"> <input
									type="hidden" name="action" value="update">
							</form>
						</div>

						<div style="text-align: left" data-index="310" id=<%=afternoon%>
							name="test" data-value="${afternoonMap['可否預約']}">
							<c:if test="${afternoonMap['可否預約'] == 'V'}">
								<strong>13:00~16:00 開放中</strong> 
                    		</c:if>
                    		<c:if test="${afternoonMap['可否預約'] != 'V'}">
								<strong>13:00~16:00+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong> 
                    		</c:if>
							<form action="">
								<input type="hidden" name="dravano" value="${afternoonMap['dravano']}">
								<input type="hidden" name="drno" value="${afternoonMap['drno']}">
								<input type="hidden" name="可否預約" value="${afternoonMap['可否預約']}">
								<input type="hidden" name="index" value="${afternoonMap['index']}">
								<input type="hidden" name="clock" value="13">
								<input type="hidden" name="requestURL"
									value="<%=request.getServletPath()%>"> <input
									type="hidden" name="action" value="update">
							</form>
						</div>

						<div style="text-align: left" data-index="310" id=<%=night%>
							data-value="${nightMap['可否預約']}">
							<c:if test="${nightMap['可否預約'] == 'V'}">
								<strong>17:00~20:00 開放中</strong> 
                    		</c:if>
                    		<c:if test="${nightMap['可否預約'] != 'V'}">
								<strong>17:00~20:00+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong> 
                    		</c:if>
							<form action="">
								<input type="hidden" name="dravano" value="${nightMap['dravano']}">
								<input type="hidden" name="drno" value="${nightMap['drno']}">
								<input type="hidden" name="可否預約" value="${nightMap['可否預約']}">
								<input type="hidden" name="index" value="${nightMap['index']}">
								<input type="hidden" name="clock" value="17">
								<input type="hidden" name="requestURL"
									value="<%=request.getServletPath()%>"> <input
									type="hidden" name="action" value="update">
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
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->
	</div>


	<script>
// 		$(document).ready(function() {
// 			$('#dataTables-example').DataTable({
// 				responsive : true
// 			});
// 		});
	</script>

	
	
	
	
	
	
	<script src="https://code.jquery.com/jquery.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script>
		window.onload = function() {
			for (var i = 0; i < <%=daysInCurrentMonth%> * 3; i++) {
				var element = document.getElementById(i);
// 				console.log(element);
				element.style.cursor = 'pointer';
				// 隨value變色
				if (element.getAttribute('data-value') == "V"){
					element.className = 'event begin end'; 
				}else{
					element.className = 'event all-day begin end';
				}
					element.onclick = function(){
					var element = this;
					if(element.id < <%=(currentDayInt - 1) * 3%>){ //還沒處理完當天時間
						window.alert("無法設定過去日期");
						return;
					}
					var data = {
							action : 'updateByAjax',
							dravano : element.children[2].value,
// 							vx : element.getAttribute('data-value')
							vx : element.children[4].value,
							index : element.children[5].value,
							clock : element.children[6].value,
						};
					$.ajax({
						url : '<%=request.getContextPath()%>/doctoravailable/dravailable.do' ,
								type : "get",
								data : data,
								dataType : 'json',
								success : function(res) {
									
									if(res.notToday){
										window.alert("無法設定過去時段");
										return;
									}
									
									element.setAttribute('data-value', res.vx);
									element.children[4].value = res.vx;
// 									console.log(element.children[4]);
// 									console.log(element.children[4].value);
									var index = element.children[5].value;
// 									console.log("index = " + index);
									var time = index % 3;
// 									console.log("time = " + time);
									if (element.getAttribute('data-value') == "V"){
										element.className = 'event begin end'; 
										switch (time) {
										case 0:
											element.children[0].innerHTML = "9:00~12:00 開放中";
											break;
										case 1:
											element.children[0].innerHTML = "13:00~16:00 開放中";
											break;
										case 2:
											element.children[0].innerHTML = "17:00~20:00 開放中";
											break;
										default:
											break;
										}
									}else{
										element.className = 'event all-day begin end';
										switch (time) {
										case 0:
											element.children[0].innerHTML = "9:00~12:00+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
											break;
										case 1:
											element.children[0].innerHTML = "13:00~16:00+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
											break;
										case 2:
											element.children[0].innerHTML = "17:00~20:00+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
											break;
										default:
											break;
										}
									}
			//							$('#answer').text(res.answer);
			//							$('#image').attr('src', res.image).css('display', 'block');
								},
								error : function(res) {
			//							$('#answer').text('Error! Could not reach the API. ');
								}
							});
							
				}
			}
			var days = document.getElementsByClassName("day_cell");
			days[<%=currentDayInt - 1%>].className = "today_cell";
			
		}

		
	</script>
<!-- 	路徑加上front-end -->
	<!-- jQuery -->
	<script
		src="<%=request.getContextPath()%>/doctor/admin/vendor/jquery/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script
		src="<%=request.getContextPath()%>/doctor/admin/vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script
		src="<%=request.getContextPath()%>/doctor/admin/vendor/metisMenu/metisMenu.min.js"></script>

	<!-- Morris Charts JavaScript -->
	<script
		src="<%=request.getContextPath()%>/doctor/admin/vendor/raphael/raphael.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/doctor/admin/vendor/morrisjs/morris.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/doctor/admin/data/morris-data.js"></script>

	<!-- Custom Theme JavaScript -->
	<script
		src="<%=request.getContextPath()%>/doctor/admin/dist/js/sb-admin-2.js"></script>

</body>
</html>


