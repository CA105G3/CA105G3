<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.menu.model.*"%>    
    
<%
String chefNo = request.getParameter("chefNo");
MenuService menuSvc = new MenuService();
List<MenuVO> list = menuSvc.getOneChefMenu(chefNo);
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
    max-width: 220px;
    max-height: 300px;
}
</style>
</head>
<body>

<form method="post" action="menu.do">
  <div class="container-fluid">
    <div class="row">
    	<c:forEach var="menuVO" items="${list}">      
	      <div class="col-xs-12 col-sm-3 col-lg-2">
	        <div class="card">
	          <div class="card-image">
	            <img src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=${menuVO.menuNo}" alt="Card image cap">
	          </div>
	          <div class="card-content">
	            <div class="form-group">
	              <label class="control-label" for="mainCourse">餐點名稱</label>
	              <div class="">
	                ${menuVO.mainCourse}
	              </div>
	              <label class="control-label" for="unitPrice">餐點價格</label>
	              <div class="">
	                ${menuVO.unitPrice}
	              </div>
	              <div class="">
	                <label>
 	                  ${menuVO.deliverable}
	                </label>
	              </div>
	            </div>
	          </div>
	        </div>
      	</div>
      </c:forEach>	
    </div>
    <div class="col-sm-2 col-sm-offset-5">
      <input type="hidden" name="chefNo" value="<%=list.get(0).getChefNo() %>">
      <input type="hidden" name="action" value="getOne_For_Update">
      <input type="submit" class="btn btn-primary" value="修改基本菜單">
    </div>
  </div>
</form>  
  
  <script src="https://code.jquery.com/jquery.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>


</body>
</html>