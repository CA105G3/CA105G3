<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Imp: Home</title>

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
   <tr><td><h3>IBM Imp: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Imp: Home</p>

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
  <li><a href='listAllImp.jsp'>List</a> all Imps.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="impression.do" >
        <b>��J�߱o�s�� (�p20181213-0001):</b>
        <input type="text" name="impNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="�e�X">
    </FORM>
  </li>

  <jsp:useBean id="impressionSvc" scope="page" class="com.impression.model.ImpressionService" />
   
  <li>
     <FORM METHOD="post" ACTION="impression.do" >
       <b>��ܤ߱o�s��:</b>
       <select size="1" name="impNo">
         <c:forEach var="impressionVO" items="${impressionSvc.all}" > 
          <option value="${impressionVO.impNo}">${impressionVO.impNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
    </FORM>
  </li>
 
 <jsp:useBean id="activitySvc" scope="page" class="com.activity.model.ActivityService"/>
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/activity/activity.do" >
       <b>��ܬ��ʽs��:</b>
       <select size="1" name="actNo">
         <c:forEach var="activityVO" items="${activitySvc.all}" > 
          <option value="${activityVO.actNo}">${activityVO.actNo}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="�e�X">
     </FORM>
  </li>
</ul>


<h3>���u�޲z</h3>

<ul>
  <li><a href='addImp.jsp'>Add</a> a new Imp.</li>
</ul>

</body>
</html>