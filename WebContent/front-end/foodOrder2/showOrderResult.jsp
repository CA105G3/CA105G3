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
Map<String,Object[]> collectByChefnoMap =(Map<String,Object[]>)request.getAttribute("collectByChefnoMap");
int total = (Integer)request.getAttribute("totalPrice");
MemberChefService memberChefService = new MemberChefService();
%><table><tr><th>供餐店家</th><th>供餐廚師</th><th>明細數量</th><th>總金額</th></tr>







<% 
String result;
if(check){
	result = "success";
	Iterator<Map.Entry<String,Object[]>> it = collectByChefnoMap.entrySet().iterator();
	Map.Entry<String,Object[]> mapEntry;
	MemberChefVO memberChefVO;
	Object[] object;
	List<OrderDetailVO> list ;
	while(it.hasNext()){
		mapEntry = it.next();
		memberChefVO = memberChefService.getOneChef(mapEntry.getKey());
		object =mapEntry.getValue();
		list = (List<OrderDetailVO>)object[1];
		%><tr><td><%=memberChefVO.getChefStoreName()%></td><td><%=memberChefVO.getChefName()%></td><td><%=list.size()%></td></tr><% 
		
		
		
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
}else{
	result = "fail";
}
%>
	<%=result%>
 



</body>
</html> 