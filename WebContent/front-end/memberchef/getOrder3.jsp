<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.foodorder2.model.*"%>
<%@ page import="com.member.model.*"%>    

<%
	String chefNo = (String)request.getAttribute("chefNo");
	List<FoodOrderVO> FOlist = (List<FoodOrderVO>)request.getAttribute("FOlist");
	List<OrderDetailVO> ODlist = (List<OrderDetailVO>)request.getAttribute("ODlist");
	List<MenuVO> menu = (List<MenuVO>)request.getAttribute("menu");
	List<MenuListVO> menuList = (List<MenuListVO>)request.getAttribute("menuList");
	List<MemberVO> member = (List<MemberVO>)request.getAttribute("member");

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
				<caption>訂單明細</caption>
				<thead>
					<tr>
						<th>訂單編號</th>
						<th>餐點圖片</th>
						<th>餐點名稱</th>
						<th>訂購者</th>
						<th>地址</th>
						<th>數量</th>
						<th>單價</th>
						<th>總額</th>
					</tr>
				</thead>
				<tbody>
				  <c:forEach var="OrderDetailVO" items="${ODlist}">  
					<tr>
						<td>${OrderDetailVO.orderno}</td>
						<c:forEach var="MenuListVO" items="${menuList}">
							<c:if test="${OrderDetailVO.menuListno==MenuListVO.menuListNo}">
								<c:forEach var="MenuVO" items="${menu}">
									<c:if test="${MenuListVO.menuNo==MenuVO.menuNo}">
										<td><img src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=${MenuVO.menuNo}"></td>
										<td>${MenuVO.mainCourse}</td>
									</c:if>
								</c:forEach>
							</c:if>
						</c:forEach>
						<c:forEach var="FoodOrderVO" items="${FOlist}">
							<c:if test="${OrderDetailVO.orderno==FoodOrderVO.orderno}">
								<c:forEach var="memberVO" items="${member}">
									<c:if test="${FoodOrderVO.memno==memberVO.memNo}">
										<td>${memberVO.memName}</td>
										<td>${memberVO.addr}</td>
									</c:if>	
								</c:forEach>
							</c:if>
						</c:forEach>
						<td>${OrderDetailVO.amount}</td>
						<td>${OrderDetailVO.unitPrice}</td>
						<td>${OrderDetailVO.amount * OrderDetailVO.unitPrice}</td>
					</tr>	
				  </c:forEach>	
				</tbody>
			</table>
		</div>
	</div>
</div>


</body>
</html>