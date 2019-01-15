<%@page import="com.doctoravailable.model.DravailableVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	DravailableVO dvo = (DravailableVO) request.getAttribute("dvo");
%>

<%=dvo == null%>

<!-- ======================================取得月份 ====================================-->
<%
	java.sql.Date draym = null;
	int month;
	int nextMonth;
	try {
		draym = dvo.getDraym();
	} catch (Exception e) {
		draym = new java.sql.Date(System.currentTimeMillis());
		month = draym.getMonth() + 1; //0~11 (0代表一月)
		nextMonth = month + 1;
		if (nextMonth == 13) {
			nextMonth = 1;
		}
		pageContext.setAttribute("month", month);
		pageContext.setAttribute("nextMonth", nextMonth);
	}
%>
<!-- ======================================以上是取得月份 ====================================-->
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>醫療人員可預約時間新增 - addEmp.jsp</title>

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
</style>

<style>
table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
}

table, th, td {
	border: 0px solid #CCCCFF;
}

th, td {
	padding: 1px;
}
</style>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Title Page</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
</head>


<body>

	<table id="table-1">
		<tr>
			<td>
				<h3>醫療人員可預約時間新增 - addDoctor.jsp</h3>
				<h4>
					<a href="selectDoctorAvailable_page.jsp"><i
						class="glyphicon glyphicon-home"></i>&nbsp;&nbsp;回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料新增:</h3>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<form method="post" action="dravailable.do">
		<table class="table table-hover">

			<jsp:useBean id="doctorSvc" scope="page"
				class="com.doctor.model.DoctorService" />
			<tr>
				<td>醫療人員編號:</td>
				<td><select size="1" name="drno">
						<c:forEach var="dvo1" items="${doctorSvc.all}">
							<option value="${dvo1.drno}"
								${(dvo.drno==dvo1.drno)? 'selected':'' }>${dvo1.drno}
						</c:forEach>
				</select></td>
			</tr>

<!-- 			<tr> -->
<!-- 				<td>年月:</td> -->
<!-- 				<td><select size="1" name="draym"> -->
<%-- 						<option value="${month}">${month}月</option> --%>
<%-- 						<option value="${nextMonth}">${nextMonth}月</option> --%>
<!-- 				</select></td> -->
<!-- 			</tr> -->

			<tr>
				<td>選擇日期：</td>
				<td><input name="draym" id="f_date1" type="text"></td>
			</tr>
			
			<tr>
			<td>選擇時段：</td>
			<td>
			<input type="checkbox" name="drava1" value="1">9:00~12:00
			<input type="checkbox" name="drava2" value="1">13:00~16:00
			<input type="checkbox" name="drava3" value="1">17:00~20:00
			
			</td>
			</tr>


		</table>

		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</form>

</body>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=draym%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        
   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
        //      var somedate1 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});

        
        //      2.以下為某一天之後的日期無法選擇
        //      var somedate2 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>
</html>