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
 	background-color: white; 
 	margin-top: 5px; 
 	margin-bottom: 5px; 
  } 
  table, th, td {
    border: 1px solid #CCCCFF; 
  }
  th, td {
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
	<%String[] timeslots ={"早","午","晚"}; %>
	<%   int weekDay = (Integer)request.getAttribute("weekDay");
			int beginMonth = (Integer)request.getAttribute("beginMonth");
			int beginDay = (Integer)request.getAttribute("beginDay");
			long firstDayLong = (Long)request.getAttribute("firstDayLong");
			int maxColunmSize =(Integer)request.getAttribute("maxColunmSize");
			int dayInWeek=0;
			int dayToCount=0;
			%>
		
		
	<tr>
	<th width="1500">    </th>
	<th width="1500">日</th>
	<th width="1500">一</th>
	<th width="1500">二</th>
	<th width="1500">三</th>
	<th width="1500">四</th>
	<th width="1500">五</th>
	<th width="1500">六</th>
	</tr>
	<tr>
	
<% if(dayToCount%7==0  &&  weekDay!=0){%>
		<td  valign="top">
			<table height="100%">
				<tr><td>日期</td></tr>
				<tr><td width="1500" height="<%=maxColunmSize*23%>px">早</td></tr>
				<tr><td width="1500" height="<%=maxColunmSize*23%>px">午</td></tr>
				<tr><td width="1500" height="<%=maxColunmSize*23%>px">晚</td></tr>
			</table>
		</td>
<%}%>
	
	
	
	
	<%
	for(int j=0;j<(weekDay%8);j++){ %>
		<td></td>
	<%dayToCount++;}%>
	
	
	
	<%
	while(it.hasNext()){
		Map.Entry<Long,LinkedHashMap<String,LinkedHashSet<MenuListVO>>> entity  = it.next();
		
		%>
	<%
		SimpleDateFormat  sdf = new SimpleDateFormat ("yyyy-MM-dd");
		java.util.Date date = new java.util.Date(entity.getKey());
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int posiInWeek = cal.get(Calendar.DAY_OF_WEEK)-1;
		if(posiInWeek==0 && firstDayLong!=date.getTime()){%>
			<tr>
	<%}%>
	<% if(dayToCount%7==0){%>
		<td  valign="top">
			<table height="100%">
				<tr><td>日期</td></tr>
				<tr><td width="1500" height="<%=maxColunmSize*23%>px">早</td></tr>
				<tr><td width="1500" height="<%=maxColunmSize*23%>px">午</td></tr>
				<tr><td width="1500" height="<%=maxColunmSize*23%>px">晚</td></tr>
			</table>
		</td>
	<%}%>
	
	
	<td  valign="top">
	<table height="100%">
		<% 
		String str  = sdf.format(date);
		%>
		<tr>
		<td width="1500"><%=str%>									</td></tr>

		
		
		
		<tr>
		<td width="1500" height="<%=maxColunmSize*23%>px">
		<%
		
			Iterator<MenuListVO> itSetBreakfast = entity.getValue().get("早").iterator();
			MenuListVO menuListVO;
			while(itSetBreakfast.hasNext()){
				menuListVO = itSetBreakfast.next();
		%>
		
		<%=MenuSvc.getOneMenu(menuListVO.getMenuNo()).getMainCourse()%>
		<input type=" number"  name="<%=menuListVO.getMenuListNo()%>"  size="3"><br>

		<%}%>
		</td>
		</tr>
		
		
		
		
		
		
		<tr>
		<td width="1500"  height="<%=maxColunmSize*23%>px">
		<%
			Iterator<MenuListVO> itSetLunch = entity.getValue().get("午").iterator();
			while(itSetLunch.hasNext()){
				menuListVO = itSetLunch.next();
				menuListVO.getMenuListNo();
		%>
		<%=MenuSvc.getOneMenu(menuListVO.getMenuNo()).getMainCourse()%>
		<input type=" number" name="<%=menuListVO.getMenuListNo()%>"   size="3"><br>
		<%}%>
		</td>
		</tr>
		
		
		
		
		
		<tr>
		<td width="1500" height="<%=maxColunmSize*23%>px">
		
		
		<%
			Iterator<MenuListVO> itSetDinner = entity.getValue().get("晚").iterator();
			while(itSetDinner.hasNext()){
				menuListVO = itSetDinner.next();
				menuListVO.getMenuListNo();
				
		%>
		<%=MenuSvc.getOneMenu(menuListVO.getMenuNo()).getMainCourse()%>
		<input type=" number" name="<%=menuListVO.getMenuListNo()%>"  size="3"><br>
		<%}%>
		</td>
		</tr>
		
		
		
		
	</table>
	</td>
	<%
		if(posiInWeek==7){%>
			</tr>
	<%}%>
		
		<% dayToCount++;%>
	<%}%>
	

	
	
</table>

<br>
<br>

<center>
<input type="submit" value="送出訂單"  style="width:180px;height:60px;font-size:20px;"> 
<input type="hidden" name="action" value="SendOrderDetail">

</center>




</form>
 






</body>
</html>