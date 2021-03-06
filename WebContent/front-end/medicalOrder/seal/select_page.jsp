<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>病歷資料查詢</title>

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

<table id="table-1">
   <tr><td><h3>病歷資料查詢首頁</h3></td></tr>
</table>



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

<ul>
  <li><a href='listAllMedicalOrder.jsp'>所有病歷資料查詢</a><br><br></li>
  
  <jsp:useBean id="medicalOrderSvc" scope="page" class="com.medicalorder.model.MedicalOrderService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do" >
       <b>選擇病例編號:</b>
       <select size="1" name="moNo">
         <c:forEach var="MedicalOrderVO" items="${medicalOrderSvc.all}" > 
          <option value="${MedicalOrderVO.moNo}">${MedicalOrderVO.moNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="查詢">
    </FORM>
  </li>
  

<h3>病例管理</h3>

<ul>
  <li><a href='addMedicalOrder.jsp'>新增一筆病例</a></li>
</ul>

</body>
</html>