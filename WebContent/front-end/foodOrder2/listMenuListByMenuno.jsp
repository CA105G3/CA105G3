<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.foodorder2.model.*"%>

<jsp:useBean id="MenuListSvc" scope="page" class="com.foodorder2.model.MenuListService" />


<!DOCTYPE html>
<html>
<head>
<title>ShoppingCart</title>
</head>




<body>

<% @SuppressWarnings("unchecked")
Map<String,LinkedHashMap<String,String>> viewlist 
				= (Map<String,LinkedHashMap<String,String>>)request.getAttribute("listMenuList_ByMenuno");
%>
<br>
<br>
<br>
<br>
<br> 
<br>
<br>
<br>
<table>
	<tr>
		<th>供餐日期</th>
		<th>--早上--</th>
		<th>--中午--</th>
		<th>--晚上--</th>
	</tr>
	<%Set<Map.Entry<String,LinkedHashMap<String,String>>> set = viewlist.entrySet();
		Iterator<Map.Entry<String,LinkedHashMap<String,String>>> it = set.iterator();%>
	<%
	while(it.hasNext()){
		Map.Entry<String,LinkedHashMap<String,String>> entity  = it.next();
	%>
	<tr>
		<td width="200"><%= entity.getKey()%>									</td>
		<td width="100"><%=entity.getValue().get("breakfast")%>  </td>
		<td width="100"><%=entity.getValue().get("lunch")%>			</td>
		<td width="100"><%=entity.getValue().get("dinner")%>    	</td>
	</tr>
	<%}%>
</table>
</body>
</html>