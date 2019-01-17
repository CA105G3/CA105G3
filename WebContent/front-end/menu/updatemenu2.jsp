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
  <script src="https://code.jquery.com/jquery.js"></script>
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
<script>
function preview(input){
	var element = input;
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function (e) {
	        	$(element).parent(".card-image").find("img").attr('src', e.target.result);
			};
			reader.readAsDataURL(input.files[0]);
		}
}

function insert(e){
 	var element = e;
	var chefNo = $(element).parent(".card").find("input[name='chefNo']").val();
	var mainCourse = $(element).parent(".card").find("input[name='mainCourse']").val();
	var unitPrice = $(element).parent(".card").find("input[name='unitPrice']").val();
	var deliverable = $(element).parent(".card").find("input[name='deliverable']").prop("checked");
	var menuPic = $(element).parent(".card").find("input[name='menuPic']")[0].files[0];

	var formData = new FormData();
	formData.append('action', "insert");
	formData.append('chefNo', chefNo);
	formData.append('mainCourse', mainCourse);
	formData.append('unitPrice', unitPrice);
	formData.append('deliverable', deliverable);
	formData.append('menuPic', menuPic);
	
	$.ajax({
		url: "menuajax.do",
		type: "post",
		data: formData,
		processData: false,  // tell jQuery not to process the data
       	contentType: false,  // tell jQuery not to set contentType
       	success : function(data) {console.log("update access!")}
	});
}

function update(e){
 	var element = e;
	var menuNo = $(element).parent(".card").find("input[name='menuNo']").val();
	var chefNo = $(element).parent(".card").find("input[name='chefNo']").val();
	var mainCourse = $(element).parent(".card").find("input[name='mainCourse']").val();
	var unitPrice = $(element).parent(".card").find("input[name='unitPrice']").val();
	var deliverable = $(element).parent(".card").find("input[name='deliverable']").prop("checked");
	var menuPic = $(element).parent(".card").find("input[name='menuPic']")[0].files[0];

	var formData = new FormData();
	formData.append('action', "update");
	formData.append('menuNo', menuNo);
	formData.append('chefNo', chefNo);
	formData.append('mainCourse', mainCourse);
	formData.append('unitPrice', unitPrice);
	formData.append('deliverable', deliverable);
	formData.append('menuPic', menuPic);
	
	$.ajax({
		url: "menuajax.do",
		type: "post",
		data: formData,
		processData: false,  // tell jQuery not to process the data
       	contentType: false,  // tell jQuery not to set contentType
       	success : function(data) {console.log("insert access!")}
	});
}

function remove(e){
 	var element = e;
	var menuNo = $(element).parent(".card").find("input[name='menuNo']").val();
	
	$(element).closest("form").remove();

 	$.ajax({
		url: "menuajax.do",
		type: "post",
		data: {action: "delete", menuNo: menuNo},
       	success : function(data) {console.log("remove access!")}
	});
}

function addColumn(){
	$("#menu").after('<form id="menu" method="post" action="menu.do" enctype="multipart/form-data"><div class="col-xs-12 col-sm-3 col-lg-2"><div class="card" align="center"><div class="card-image"><img src="<%=request.getContextPath()%>/Imgs/Menu/nopic.jpg"/><input class="menuPic" type="file" name="menuPic" accept="image/*" onchange="preview(this);" value=""/></div><div class="card-content"><div class="form-group" align="left"><label class="control-label" for="mainCourse">餐點名稱</label><div class=""><input type="text" class="form-control" name="mainCourse" value="" placeholder="請輸入餐點名稱" required/></div><label class="control-label" for="unitPrice">餐點價格</label><div class=""><input type="number" class="form-control" name="unitPrice" value="" placeholder="請輸入餐點價格" required/></div><div class=""><label><input type="checkbox" name="deliverable" value="可送餐" checked/>可送餐</label></div><input type="hidden" name="menuNo" value=""><input type="hidden" name="chefNo" value="<%=list.get(0).getChefNo()%>"></div></div><input type="button" class="btn btn-success btn-sm" onclick="insert(this)" value="新增菜單"/></div></div></form>');
}

</script>
</head>
<body>


<div class="container-fluid">
	<div class="row">
		<c:forEach var="menuVO" items="${list}">
	    	<form name="menuForm" method="post" action="menu.do" enctype="multipart/form-data">  
		    	<div class="col-xs-12 col-sm-3 col-lg-2">
		        	<div class="card" align="center">
		          		<div class="card-image">
		            		<img src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=${menuVO.menuNo}"/>
		            		<input type="file" name="menuPic" accept="image/*" onchange="preview(this);" value="${menuVO.menuPic}"/>  
		          		</div>
			          	<div class="card-content">
				            <div class="form-group" align="left">
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
					    <input type="button" class="btn btn-info btn-sm" onclick="update(this)" value="送出修改"/>
					    <input type="button" class="btn btn-danger btn-sm" onclick="remove(this)" value="刪除餐點"/>
		    		</div>
	      		</div>
	      	</form>
		</c:forEach>
		<form id="menu" method="post" action="menu.do" enctype="multipart/form-data">	
	      	<div class="col-xs-12 col-sm-3 col-lg-2">
		        <div class="card" align="center">
		        	<div class="card-image">
		            	<img src="<%=request.getContextPath()%>/Imgs/Menu/nopic.jpg"/>
		            	<input class="menuPic" type="file" name="menuPic" accept="image/*" onchange="preview(this);" value=""/>  
		        	</div>
		        	<div class="card-content">
			            <div class="form-group" align="left">
			            	<label class="control-label" for="mainCourse">餐點名稱</label>
			            	<div class="">
			              		<input type="text" class="form-control" name="mainCourse" value="" placeholder="請輸入餐點名稱" required/>
			            	</div>
			            	<label class="control-label" for="unitPrice">餐點價格</label>
			            	<div class="">
			              		<input type="number" class="form-control" name="unitPrice" value="" placeholder="請輸入餐點價格" required/>
			            	</div>
			            	<div class="">
			                	<label>
			                		<input type="checkbox" name="deliverable" value="可送餐" checked/>可送餐
			                	</label>
			              	</div>
			            	<input type="hidden" name="menuNo" value="">
			            	<input type="hidden" name="chefNo" value="<%=list.get(0).getChefNo()%>">
			            </div>
		        	</div>
		        	<input type="button" class="btn btn-success btn-sm" onclick="insert(this)" value="新增菜單"/>
		        </div>
	      	</div>
      	</form>
    </div>
	<div class="row">
    	<div class="col-xs-12 col-sm-2" align="center" onclick="addColumn()" style="padding-top: 20px;">
			<input type="button" class="btn btn-secondary" value="新增更多輸入欄位"/>
    	</div>
    	<div class="col-xs-12 col-sm-2 col-sm-offset-4" align="center" style="padding-top: 20px;">
    		<form method="post" action="menu.do">
    			<input type="hidden" name="chefNo" value="<%=list.get(0).getChefNo()%>">
	    		<input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" class="btn btn-primary" value="結束修改"/>
			</form>
    	</div>
	</div>
</div>

</body>
</html>