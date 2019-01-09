<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.menu.model.*"%>    
<%@ page import="com.menulist.model.*"%>    
    
<%
	String chefNo = (String)request.getAttribute("chefNo");
	List<MenuVO> menu = (List<MenuVO>)request.getAttribute("menu");
	List<MenuListVO> menuList = (List<MenuListVO>)request.getAttribute("menuList");
%>  
<!DOCTYPE html>
<html lang="">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
  <title>Title Page</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
  <!--[if lt IE 9]>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->
<style type="text/css">
  img {
    max-width: 100px;
    max-height: 150px;
}
</style>
</head>
<body>

<div class="container-fluid">
	<div class="row">
		<div class="col-xs-12 col-sm-6">
			<table class="table table-striped table-hover table-bordered">
				<caption>MENU</caption><%=chefNo %>
				<thead>
					<tr>
						<th>menuPic</th>
						<th>menuNo</th>
						<th>chefNo</th>
						<th>mainCourse</th>
						<th>unitPrice</th>
						<th>deliverable</th>
					</tr>
				</thead>
				<tbody>
				  <c:forEach var="menuVO" items="${menu}">  
					<tr>
						<td><img src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=${menuVO.menuNo}"></td>
						<td>${menuVO.menuNo}</td>
						<td>${menuVO.chefNo}</td>
						<td>${menuVO.mainCourse}</td>
						<td>${menuVO.unitPrice}</td>
						<td>${menuVO.deliverable}</td>
					</tr>
				  </c:forEach>	
				</tbody>
			</table>
			
		</div>
		<div class="col-xs-12 col-sm-6">
			<table class="table table-striped table-hover table-bordered">
				<caption>MENULIST</caption>
				<thead>
					<tr>
						<th>menuPic</th>
						<th>menuNo</th>
						<th>mainCourse</th>
						<th>unitPrice</th>
						<th>deliverable</th>
						<th>menuDate</th>
						<th>menuTimeSlot</th>
						<th>menuListNo</th>
					</tr>
				</thead>
				<tbody>
				  <c:forEach var="menuListVO" items="${menuList}">  	
					<tr>
						<c:forEach var="menuVO" items="${menu}">
		                    <c:if test="${menuListVO.menuNo==menuVO.menuNo}">
								<td><img src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=${menuVO.menuNo}"></td>
								<td>${menuListVO.menuNo}</td>
		                   		<td>${menuVO.mainCourse}</td>
								<td>${menuVO.unitPrice}</td>
								<td>${menuVO.deliverable}</td>
		                    </c:if>
		                </c:forEach>
						<td>${menuListVO.menuDate}</td>
						<td>${menuListVO.menuTimeSlot}</td>
						<td>${menuListVO.menuListNo}</td>
					</tr>
				  </c:forEach>	
				</tbody>
			</table>
		</div>
	</div>
</div>








</body>
</html>