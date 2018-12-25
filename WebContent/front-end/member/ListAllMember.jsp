<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*" %>
<%@ page import="java.util.*" %>

<%
	MemberService memSvc = new MemberService();
	List<MemberVO> list = memSvc.getAll();
	pageContext.setAttribute("list",list);
	
	MemberVO memVO = (MemberVO) request.getAttribute("memVO");
	pageContext.setAttribute("memVO", memVO);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>所有會員資料-listAllMember.jsp</title>
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
	width: 800px;
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
<body bgcolor=#00DDDD>
<h4>此頁練習採用 EL 的寫法取值:</h4>

<table id="table-1">
	<tr><td>
		 <h3>所有會員資料-listAllMember.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
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
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="memVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
	<tr>
		<td>${memVO.memNo}</td>
		<td>${memVO.memId}</td>
		<td>${memVO.memName}</td>
		<td>${memVO.pwd}</td>
		<td>${memVO.gender}</td>
		<td>${memVO.birth}</td>
		<td>${memVO.bloodType}</td>
		<td>${memVO.email}</td>
		<td>${memVO.phone}</td>
		<td>${memVO.locNo}</td>
		<td>${memVO.addr}</td>
		<td>${memVO.memStatus}</td>
		<td>${memVO.medHistory}</td>
		<td>${memVO.famHistory}</td>
		<td>${memVO.allergy}</td>
		<td>${memVO.smoking}</td>
		<td>${memVO.regDate}</td>
		<td>${memVO.ident}</td>
		<td>${memVO.stayTime}</td>
		<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/member/member.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="memno"  value="${memVO.memNo}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/member/member.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="memno"  value="${memVO.memNo}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
	</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>