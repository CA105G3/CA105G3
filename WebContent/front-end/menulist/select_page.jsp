<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title></title>

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
   <tr><td><h3>IBM Menu: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Menu: Home</p>

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
  
    <FORM METHOD="post" method="post" ACTION="menulist.do" >
        <b>輸入廚師編號 (如CHEF0001):</b>
        <input type="text" name="chefNo" value="CHEF0001">
        <input type="hidden" name="action" value="For_Display">
        <input type="submit" value="送出">
    </FORM>
    
        <FORM METHOD="post" method="post" ACTION="menulist.do" >
        <b>輸入廚師編號 (工程師畫面):</b>
        <input type="text" name="chefNo" value="CHEF0001">
        <input type="hidden" name="action" value="For_Display_Test">
        <input type="submit" value="送出">
    </FORM>

</ul>

<ul>
  
</ul>

</body>
</html>