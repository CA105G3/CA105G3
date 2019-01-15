<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.medicalorder.model.*"%>
				 
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	MedicalOrderVO medicalOrderVO = (MedicalOrderVO) request.getAttribute("medicalOrderVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>單筆病歷資料 - listOneMedicalOrder.jsp</title>

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

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>病歷資料 - ListOneMedicalOrder.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>看診單編號</th>
		<th>會員編號</th>
		<th>醫療人員編號</th>
		<th>診療狀態</th>
		<th>診療費用</th>
		<th>約診時間</th>
		<th>病況說明</th>
		<th>問診影音紀錄</th>
		<th>問診文字紀錄</th>
	</tr>
	<tr>
		<td><%=medicalOrderVO.getMoNo()%></td>
		<td><%=medicalOrderVO.getMemNo()%></td>
		<td><%=medicalOrderVO.getDrNo()%></td>
		<td><%=medicalOrderVO.getMoStatus()%></td>
		<td><%=medicalOrderVO.getMoCost()%></td>
		<td><%=medicalOrderVO.getMoTime()%></td>
		<td><%=medicalOrderVO.getMoIntro()%></td>
		<td><%=medicalOrderVO.getMoVideo()%></td>
		<td><%=medicalOrderVO.getMoText()%></td>
	</tr>
</table>

</body>
</html>