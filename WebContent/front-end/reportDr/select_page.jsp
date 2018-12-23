<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>���|��ͥ\�୺��</title>

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
   <tr><td><h3>���|��ͥ\�୺��</h3></td></tr>
</table>

<p>This is the Home page for ���|��ͥ\�୺��</p>

<h3>��Ƭd��:</h3>
	
<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllReportDr.jsp'>List</a> �Ҧ����|��͸��  <br><br></li>

  <jsp:useBean id="rdSvc" scope="page" class="com.reportdr.model.ReportDrService" />
   
  <li>										
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/reportDr/reportDrServlet.do" >
       <b>������|��s��:</b>
       <select size="1" name="rdrNo">
         <c:forEach var="reportDrVO" items="${rdSvc.allReportDr}" > 
          <option value="${reportDrVO.rdrNo}">${reportDrVO.rdrNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li>
  
</ul>

<ul>
  <li><a href='addReportDr.jsp'>�s�W�@�����|��</a></li>
</ul>
<ul>
  	<li><a href='getNeedUpdate.jsp'>�d�ߩҦ����B�z���|</a></li>
</ul>

</body>
</html>