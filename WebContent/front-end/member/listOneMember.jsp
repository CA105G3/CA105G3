<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.member.model.*"%>

<%
  	MemberVO memVO = (MemberVO) request.getAttribute("memVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
	pageContext.setAttribute("memVO", memVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	width: 600px;
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
<title>會員資料- listOneEmp.jsp</title>
</head>
<body bgcolor='white'>
<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>會員資料- listOneEmp.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>會員編號</th>
		<th>會員帳號</th>
		<th>會員姓名</th>
		<th>會員密碼</th>
		<th>性別</th>
		<th>生日</th>
		<th>血型</th>
		<th>E-mail</th>
		<th>電話</th>
		<th>郵遞編號</th>
		<th>地址</th>
		<th>會員狀態</th>
		<th>過往醫療史</th>
		<th>家族病史</th>
		<th>過敏記錄</th>
		<th>是否抽菸</th>
		<th>註冊日期</th>
		<th>會員身分</th>
		<th>最後登入</th>
	</tr>
	<tr>
		<td><%=memVO.getMemNo()%></td>
		<td><%=memVO.getMemId()%></td>
		<td><%=memVO.getMemName()%></td>
		<td><%=memVO.getPwd()%></td>
		<td><%=memVO.getGender()%></td>
		<td><%=memVO.getBirth()%></td>
		<td><%=memVO.getBloodType()%></td>
		<td><%=memVO.getEmail()%></td>
		<td><%=memVO.getPhone()%></td>
		<td><%=memVO.getLocNo()%></td>
		<td><%=memVO.getAddr()%></td>
		<td><%=memVO.getMemStatus()%></td>
		<td><%=memVO.getMedHistory()%></td>
		<td><%=memVO.getFamHistory()%></td>
		<td><%=memVO.getAllergy()%></td>
		<td><%=memVO.getSmoking()%></td>
		<td><%=memVO.getRegDate()%></td>
		<td><%=memVO.getIdent()%></td>
		<td><%=memVO.getStayTime()%></td>
	</tr>
</table>
</body>
</html>