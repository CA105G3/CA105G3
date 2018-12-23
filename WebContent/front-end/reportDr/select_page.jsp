<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>檢舉醫生功能首頁</title>

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
   <tr><td><h3>檢舉醫生功能首頁</h3></td></tr>
</table>

<p>This is the Home page for 檢舉醫生功能首頁</p>

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
  <li><a href='listAllReportDr.jsp'>List</a> 所有檢舉醫生資料  <br><br></li>

  <jsp:useBean id="rdSvc" scope="page" class="com.reportdr.model.ReportDrService" />
   
  <li>										
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/reportDr/reportDrServlet.do" >
       <b>選擇檢舉單編號:</b>
       <select size="1" name="rdrNo">
         <c:forEach var="reportDrVO" items="${rdSvc.allReportDr}" > 
          <option value="${reportDrVO.rdrNo}">${reportDrVO.rdrNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
</ul>

<ul>
  <li><a href='addReportDr.jsp'>新增一筆檢舉單</a></li>
</ul>
<ul>
  	<li><a href='getNeedUpdate.jsp'>查詢所有未處理檢舉</a></li>
</ul>

</body>
</html>