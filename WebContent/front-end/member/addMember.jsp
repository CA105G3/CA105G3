<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>
<%
MemberVO memVO = (MemberVO) request.getAttribute("memVO");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員資料新增 - addMember.jsp</title>
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
		 <h3>會員資料新增 - addMember.jsp</h3></td><td>
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
<FORM METHOD="post" ACTION="member.do" name="form1">
<table>
 	<tr>
		<td>會員名稱:</td>
		<td><input type="TEXT" name="memid" size="45" 
			 value="<%= (memVO==null)? "M0001" : memVO.getMemId()%>" /></td>
	</tr>
	<tr>
		<td>會員密碼:</td>
		<td><input type="password" name="mempsw" size="45"
			 value="<%= (memVO==null)? "123456" : memVO.getPwd()%>" /></td>
	</tr>
	<tr>
		<td>真實姓名:</td>
		<td><input type="TEXT" name="memname" size="45" 
			 value="<%= (memVO==null)? "易小川" : memVO.getMemName()%>" /></td>
	</tr>
	<tr>
		<td>性別</td>
		<td><select name="gender">
			<option value="男" selected="selected">男</option>
			<option value="女">女</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>生日</td>
		<td><input name="birth" id="birth_date"></td>
	</tr>
	<tr>
		<td>血型</td>
		<td><select name="bloodtype">
			<option value="A" selected="selected">A</option>
			<option value="B">B</option>
			<option value="O">O</option>
			<option value="AB">AB</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>E-mail:</td>
		<td><input type="TEXT" name="email" size="45" 
			 value="<%= (memVO==null)? "abc123@gmail.com" : memVO.getEmail()%>" /></td>
	</tr>
	<tr>
		<td>電話:</td>
		<td><input type="TEXT" name="phone" size="45" 
			 value="<%= (memVO==null)? "0912345678" : memVO.getPhone()%>" /></td>
	</tr>
	<tr>
		<td>郵遞區號:</td>
		<td><input type="TEXT" name="locno" size="45" 
			 value="<%= (memVO==null)? "12345" : memVO.getLocNo()%>" /></td>
	</tr>
	<tr>
		<td>過去病史:</td>
		<td><input type="TEXT" name="medhistory" size="45" 
			 value="<%= (memVO==null)? "無" : memVO.getMedHistory()%>" /></td>
	</tr>
	<tr>
		<td>家族病史:</td>
		<td><input type="TEXT" name="famhistory" size="45" 
			 value="<%= (memVO==null)? "無" : memVO.getFamHistory()%>" /></td>
	</tr>
	<tr>
		<td>過敏記錄:</td>
		<td><input type="TEXT" name="allergy" size="45" 
			 value="<%= (memVO==null)? "無" : memVO.getAllergy()%>" /></td>
	</tr>
	<tr>
		<td>是否抽菸</td>
		<td><select name="bloodtype">
			<option value="有" selected="selected">有</option>
			<option value="沒有">沒有</option>
		</select>
		</td>
	</tr>
	</table>
	<br>
	<input type="hidden" name="regdate" value="regDate">
	<input type="hidden" name="action" value="insert">
	<input type="submit" value="送出新增">
</FORM>
</body>

<% 
  java.sql.Date regDate = null;
  try {
	    regDate = memVO.getRegDate();
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
        $('#birth_date').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   //value: '<%=regDate%>',  // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
</script>
</html>