<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.foodorder2.model.*"%>
<jsp:useBean id="MenuSvc" scope="page" class="com.foodorder2.model.MenuService" />
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
Map<Long,LinkedHashMap<String,LinkedHashSet<MenuListVO>>> map
				= (Map<Long,LinkedHashMap<String,LinkedHashSet<MenuListVO>>>)request.getAttribute("showDatesToOrderFood");
%>



<form METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/foodOrder2/foodorder2.do" style="margin-bottom: 0px;">
<table>
	<%Set<Map.Entry<Long,LinkedHashMap<String,LinkedHashSet<MenuListVO>>>> set = map.entrySet();
		Iterator<Map.Entry<Long,LinkedHashMap<String,LinkedHashSet<MenuListVO>>>> it = set.iterator();%>
		
	<tr>
	<th>時間</th>
	<th>早</th>
	<th>中</th>
	<th>晚</th>
	</tr>
	<%
	while(it.hasNext()){
		Map.Entry<Long,LinkedHashMap<String,LinkedHashSet<MenuListVO>>> entity  = it.next();
	%>

	<tr>
		<% 
		SimpleDateFormat  sdf = new SimpleDateFormat ("yyyy-MM-dd");
		java.util.Date date = new java.util.Date(entity.getKey());
		String str  = sdf.format(date);
		%>
		<td width="400"><%=str%>									</td>
		<td width="500">
		<%
			Iterator<MenuListVO> itSetBreakfast = entity.getValue().get("早").iterator();
		
			MenuListVO menuListVO;
			while(itSetBreakfast.hasNext()){
				menuListVO = itSetBreakfast.next();
		%>
		<%=MenuSvc.getOneMenu(menuListVO.getMenuNo()).getMainCourse()%>
		<input type=" number" name="<%=menuListVO.getMenuListNo()%>">
		<br>
		<%}%>
		</td>
		
		<td width="500">
		<%
			Iterator<MenuListVO> itSetLunch = entity.getValue().get("午").iterator();
			while(itSetLunch.hasNext()){
				menuListVO = itSetLunch.next();
				menuListVO.getMenuListNo();
				
		%>
		<%=MenuSvc.getOneMenu(menuListVO.getMenuNo()).getMainCourse()%>
		<input type=" number" name="<%=menuListVO.getMenuListNo()%>">
		<br>
		<%}%>
		</td>
		
		
		<td width="500">
		<%
			Iterator<MenuListVO> itSetDinner = entity.getValue().get("晚").iterator();
			while(itSetDinner.hasNext()){
				menuListVO = itSetDinner.next();
				menuListVO.getMenuListNo();
				
		%>
		<%=MenuSvc.getOneMenu(menuListVO.getMenuNo()).getMainCourse()%>
		<input type=" number" name="<%=menuListVO.getMenuListNo()%>">
		<br>
		<%}%>
		</td>
		
		
		
		
		
		
		
	</tr>
	<%}%>
</table>
<input type="submit" value="送出訂單" > 
<input type="hidden" name="action" value="SendOrderDetail"></form>







</body>
</html>