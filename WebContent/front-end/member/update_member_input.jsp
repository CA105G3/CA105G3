<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>
<%
  MemberVO memVO = (MemberVO) request.getAttribute("memVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員資料修改 - update_member_input.jsp</title>
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
		 <h3>會員資料修改 - update_member_input.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
<FORM METHOD="post" ACTION="member.do" name="form1">
<table>
	<tr>
		<td>會員編號:</td>
		<td><input name="memno" type="text" value="<%=memVO.getMemNo()%>" readonly></td>
	</tr>
	<tr>
		<td>會員帳號:</td>
		<td><input name="memid" type="text" value="<%=memVO.getMemId()%>"></td>
	</tr>
	<tr>
		<td>會員密碼:</td>
		<td><input name="mempsw" type="password" value="<%=memVO.getPwd()%>"></td>
	</tr>
	<tr>
		<td>會員姓名:</td>
		<td><input name="memname" type="text" value="<%=memVO.getMemName()%>"></td>
	</tr>
	<tr>
		<td>會員性別:</td>
		<td><select name="gender">
			<option value="男" ${(memVO.gender=='男')?'selected':''}>男</option>
			<option value="女" ${(memVO.gender=='女')?'selected':''}>女</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>生日:</td>
		<td><input name="birth" id="birth_date"></td>
	</tr>
	<tr>
		<td>會員血型:</td>
		<td><select name="bloodtype">
			<option value="A" ${(memVO.bloodType=='A')?'selected':''}>A</option>
			<option value="B" ${(memVO.bloodType=='B')?'selected':''}>B</option>
			<option value="AB"${(memVO.bloodType=='AB')?'selected':''}>AB</option>
			<option value="O" ${(memVO.bloodType=='O')?'selected':''}>O</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>E-mail:</td>
		<td><input name="email" type="text" value="<%=memVO.getEmail()%>"></td>
	</tr>
	<tr>
		<td>電話:</td>
		<td><input name="phone" type="text" value="<%=memVO.getPhone()%>"></td>
	</tr>
	<tr>
		<td>郵遞區碼:</td>
		<td><input name="locno" type="text" value="<%=memVO.getLocNo()%>"></td>
	</tr>
	<tr>
		<td>地址:</td>
		<td><input name="addr" type="text" value="<%=memVO.getAddr()%>"></td>
	</tr>
	<tr>
		<td>會員狀態:</td>
		<td><input name="memstatus" type="text" value="<%=memVO.getMemStatus()%>" readonly></td>
	</tr>
	<tr>
		<td>過往病史:</td>
		<td><input name="medhistory" type="text" value="<%=memVO.getMedHistory()%>"></td>
	</tr>
	<tr>
		<td>家族病史:</td>
		<td><input name="famhistory" type="text" value="<%=memVO.getFamHistory()%>"></td>
	</tr> 
	<tr>
		<td>過敏記錄:</td>
		<td><input name="allergy" type="text" value="<%=memVO.getAllergy()%>"></td>
	</tr>
	<tr>
		<td>是否有吸菸:</td>
		<td><select name="smoking">
			<option value="有" ${(memVO.gender=='有')?'selected':''}>有</option>
			<option value="沒有" ${(memVO.gender=='沒有')?'selected':''}>沒有</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>會員狀態:</td>
		<td><select name="memstatus">
			<option value="正常" ${(memVO.gender=='正常')?'selected':''}>正常</option>
			<option value="停用" ${(memVO.gender=='停用')?'selected':''}>停用</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>註冊日期:</td>
		<td><input name="regdate" type="text" value="<%=memVO.getRegDate()%>" readonly></td>
	</tr>
	<tr>
		<td>會員身分:</td>
		<td><input name="ident" type="text" value="<%=memVO.getIdent()%>" readonly></td>
	</tr>
	<tr>
		<td>最後登入時間:</td>
		<td><input name="staytime" type="text" value="<%=memVO.getStayTime()%>" readonly></td>
	</tr>
</table>
<input type="hidden" name="action" value="update">
<input type="submit" value="送出修改">
</FORM>
</body>

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
		   value: '<%=memVO.getBirth()%>',  // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
</script>       
</html>