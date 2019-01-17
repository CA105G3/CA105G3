<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.foodorder2.model.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>


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
<body>
<% @SuppressWarnings("unchecked")
Boolean check = (Boolean)request.getAttribute("showOrderResult");
String result;
if(check){
	result = "success";
}else{
	result = "fail";
}
%>
	<%=result%>
 



</body>
</html> 