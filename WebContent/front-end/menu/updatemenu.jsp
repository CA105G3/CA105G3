<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.menu.model.*"%>    
    
<%
	List<MenuVO> list = (List<MenuVO>)request.getAttribute("list");
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

<form id="menu" method="post" action="menu.do" enctype="multipart/form-data">
  <div class="container-fluid">
    <div class="row">
    	<c:forEach var="menuVO" items="${list}">      
	      <div class="col-xs-12 col-sm-3 col-lg-2">
	        <div class="card">
	          <div class="card-image">
	            <img src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=${menuVO.menuNo}"/>
	            <input type="file" name="menuPic" accept="image/*" onchange="readURL(this);" value="${menuVO.menuPic}"/>  
	          </div>
	          <div class="card-content">
	            <div class="form-group">
	              <label class="control-label" for="mainCourse">餐點名稱</label>
	              <div class="">
	              	<input type="text" class="form-control" name="mainCourse" value="${menuVO.mainCourse}" placeholder="請輸入餐點名稱" required/>
	              </div>
	              <label class="control-label" for="unitPrice">餐點價格</label>
	              <div class="">
	              	<input type="number" class="form-control" name="unitPrice" value="${menuVO.unitPrice}" placeholder="請輸入餐點價格" required/>
	              </div>
	              <div class="">
	                <label>
	                  <c:choose>
	                  	<c:when test="${menuVO.deliverable == '可送餐'}">
	                  	  <input type="checkbox" name="deliverable" value="可送餐" checked/>可送餐
	                  	</c:when>
	                  	<c:otherwise>
	                  	  <input type="checkbox" name="deliverable" value="可送餐"/>可送餐
	                  	</c:otherwise>
	                  </c:choose>
	                </label>
	              </div>
	              <input type="hidden" name="menuNo" value="${menuVO.menuNo}">
	              <input type="hidden" name="chefNo" value="${menuVO.chefNo}">
	            </div>
	          </div>
	        </div>
      	</div>
      </c:forEach>	
    </div>
    <div class="col-sm-2 col-sm-offset-5">
      <button type="submit" class="btn btn-primary" name="action" value="update">送出修改</button>
    </div>
  </div>
</form>  
  
  <script src="https://code.jquery.com/jquery.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script>
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	
	        reader.onload = function (e) {
	            $('#preview').attr('src', e.target.result);
	        };
	
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	$(document).ready(function() {
        $("#menu").submit(function() {
            $("#menu input[type=checkbox]:not(:checked)").each(function() {
                $(this).val("不可送餐");
                $(this).attr("checked", true);
            });
        });
    });
	</script>

</body>
</html>