<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.administrator.model.*"%>
<%
AdministratorVO adminVO = (AdministratorVO) request.getAttribute("adminVO");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理員資料新增 - addAdmin.jsp</title>
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
</head>
<body bgcolor='white'>
<table id="table-1">
	<tr><td>
		 <h3>管理員資料新增 - addAdmin.jsp</h3></td><td>
		 <h4><a href="select_page.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>
<h3>資料新增:</h3>
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<FORM METHOD="post" ACTION="admin.do" name="form1">
<table>
 	<tr>
		<td>管理員名稱:</td>
		<td><input type="TEXT" name="adminid" size="45" 
			 value="<%= (adminVO==null)? "D0001" : adminVO.getAdminId()%>" /></td>
	</tr>
	<tr>
		<td>管理員密碼:</td>
		<td><input type="password" name="adminpsw" size="45"
			 value="<%= (adminVO==null)? "123456" : adminVO.getAdminPsw()%>" /></td>
	</tr>
	<tr>
		<td>管理員權限</td>
		<td><select name="priority">
			<option value="一般管理員" selected="selected">一般管理員</option>
			<option value="可新增管理員">可新增管理員</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>是否生效</td>
		<td><select name="status">
			<option value="生效中" selected="selected">生效中</option>
			<option value="已失效">已失效</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>註冊日期</td>
		<td><input type="date" name="reg"></td>
	</tr>
	</table>
	<br>
	<input type="hidden" name="action" value="insert">
	<input type="submit" value="送出新增">
</FORM>
</body>

<% 
  java.sql.Date regDate = null;
  try {
	    regDate = adminVO.getReg();
   } catch (Exception e) {
	   regDate = new java.sql.Date(System.currentTimeMillis());
   }
%>

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
		   value: '<%=regDate%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
</script>
</html>