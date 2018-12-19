<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<title>Select PPT</title>
</head>
<body bgcolor='white'>

<h3>資料查詢:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

	<li><a href='ListAllPPT.jsp'>List</a> all PPTs.<br><br></li>
	
	<FORM METHOD="post" ACTION="ppt.do" >
        <b>輸入PPT編號 (如P0001):</b>
        <input type="text" name="pptno">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
	</FORM>
<jsp:useBean id="pptSvc" scope="page" class="com.ppttool.model.PPTToolService" />
	<FORM METHOD="post" ACTION="ppt.do" >
       <b>選擇員工編號:</b>
       <select size="1" name="pptno">
         <c:forEach var="pptVO" items="${pptSvc.all}" > 
          <option value="${pptVO.pptno}">${pptVO.pptno}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
    
   <h3>新增PPT</h3>
   <ul>
    <li><a href='addPPT.jsp'>add a new PPT</a></li>
   </ul>
</body>
</html>