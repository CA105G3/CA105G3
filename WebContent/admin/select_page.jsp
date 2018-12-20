<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理員資料管理</title>
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

<h3>管理員資料查詢:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<li><a href='ListAllAdmin.jsp'>List</a> 所有管理員列表<br><br></li>

<FORM METHOD="post" ACTION="admin.do" >
        <b>輸入管理員編號 (如A0001):</b>
        <input type="text" name="adminno">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
	</FORM>
	
<jsp:useBean id="adminSvc" scope="page" class="com.administrator.model.AdministratorService" />
	<FORM METHOD="post" ACTION="admin.do" >
       <b>選擇管理員:</b>
       <select size="1" name="adminno">
         <c:forEach var="adminVO" items="${adminSvc.all}" > 
          <option value="${adminVO.adminNo}">${adminVO.adminId}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
    <h3>新增PPT</h3>
   	<ul>
    	<li><a href='addAdmin.jsp'>新增管理員</a></li>
   	</ul>
    
</body>
</html>