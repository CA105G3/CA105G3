<%@ page language="java" contentType="text/html; charset=UTF8"
    pageEncoding="UTF8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF8">
<title>會員資料查詢</title>
<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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
</head>
<body bgcolor='white'>
<h3>會員資料查詢:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

	<li><a href='ListAllMember.jsp'>List</a> all PPTs.<br><br></li>
	
	<FORM METHOD="post" ACTION="member.do" >
        <b>輸入會員編號 (如M0001):</b>
        <input type="text" name="memno">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
	</FORM>
<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemberService" />
	<FORM METHOD="post" ACTION="member.do" >
       <b>選擇會員編號:</b>
       <select size="1" name="memno">
         <c:forEach var="memVO" items="${memSvc.all}" > 
          <option value="${memVO.memNo}">${memVO.memName}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
   <h3>新增會員</h3>
   <ul>
    <li><a href='addMember.jsp'>add a new PPT</a></li>
   </ul>
</body>
</html>