<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.license.model.*"%>

<%
	LicenseVO licenseVO = (LicenseVO) request.getAttribute("licenseVO"); //licenseServlet.java (Concroller) 存入req的licenseVO物件 (包括幫忙取出的licenseVO, 也包括輸入資料錯誤時的licenseVO物件)
%>

<html>
<head>

<title>證照資料修改-update_lic.jsp</title>
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
	width: 100%;
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

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>證照資料修改-update_lic.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/license/licensesearch.jsp"><img src="<%=request.getContextPath()%>/front-end/license/img/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/license/license.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>證照編號:</td>
		<td><%=licenseVO.getLicNo()%></td>
	</tr>
	<tr>
		<td>會員編號:</td>
		<td><input type="TEXT" name="memNo" size="45" 
			 value="<%=licenseVO.getMemNo()%>" readonly="true" /></td>
	</tr>
	<tr>
		<td>證照檔案:</td>
		<c:choose>
				<c:when test="${(licenseVO.licData)!=null}">
			<td>
				<img src="<%= request.getContextPath()%>/license/licensePic.do?licNo=${licenseVO.licNo}" id="output" height=50% weight=50%/>
				<input type="file" name="licData" size="45" onchange="loadFile(event)"/>
			</td>
				</c:when>
				<c:otherwise >
			<td>
			<img src="<%= request.getContextPath()%>/front-end/license/img/nopic.jpg" id="output" width=50% height=50%>
			<input type="file" name="actPic" size="45" onchange="loadFile(event)"/>
			</td>
				</c:otherwise>
			</c:choose>
	</tr>
	<tr>
		<td>證照狀態:</td>
		<td><input type="TEXT" name="licStatus" size="45" 
			 value="<%= (licenseVO==null)?"": licenseVO.getLicStatus()%>"/></td>
	</tr>
	<tr>
		<td>證照描述:</td>
		<td><input type="TEXT" name="licDesc" size="45" 
			 value="<%= (licenseVO==null)? "" : licenseVO.getLicDesc()%>"/></td>
	</tr>
	<tr>
		<td>證照時效:</td>
		<td>
		<input type="TEXT" name="licDue" size="45" id="f_date1"
			 value="<%= (licenseVO==null)? "" : licenseVO.getLicDue()%>"/>
		</td>
	</tr>
	<tr>
		
	</tr>
	
	
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="licNo" value="<%= licenseVO.getLicNo()%>">
<input type="submit" value="送出修改"></FORM>
<script>
  var loadFile = function(event) {
    var reader = new FileReader();
    reader.onload = function(){
      var output = document.getElementById("output");
      output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
  };
</script>
</script>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  java.sql.Date licDue = null;
  try {
	  licDue = licenseVO.getLicDue();
   } catch (Exception e) {
	   licDue = new java.sql.Date(System.currentTimeMillis());
   }
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/license/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/front-end/license/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/front-end/license/datetimepicker/jquery.datetimepicker.full.js"></script>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '',              // value:   new Date(),
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
</body>

</html>