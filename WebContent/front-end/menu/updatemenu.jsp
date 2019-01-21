<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.menu.model.*"%>  
<%@ page import="com.member.model.*"%>
<%  
MemberVO memVO = (MemberVO)session.getAttribute("memVO");
String chefNo = (String)session.getAttribute("chefNo");
List<MenuVO> list = (List<MenuVO>)session.getAttribute("list");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="Shortcut Icon" type="image/x-icon" href="<%=request.getContextPath()%>/front-end/images/favicon.ico">
    <title >Health PLUS</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/animate.css">
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/owl.carousel.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/magnific-popup.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/aos.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/ionicons.min.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/jquery.timepicker.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/css/spring.css">

    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/flaticon.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/icomoon.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/style.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/activity/css/leftsidebar.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css"></link>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.css" />
    <!-- 我跟你說這些link你可以全部存在一隻jsp，之後的網頁再去link後來的jsp，這樣畫面會比較乾淨 、script一樣-->
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
		var menuIntro = $(element).parent(".card").find("input[name='menuIntro']").val();
		var unitPrice = $(element).parent(".card").find("input[name='unitPrice']").val();
		var deliverable = $(element).parent(".card").find("input[name='deliverable']").prop("checked");
		var menuPic = $(element).parent(".card").find("input[name='menuPic']")[0].files[0];
	
		var formData = new FormData();
		formData.append('action', "insert");
		formData.append('chefNo', chefNo);
		formData.append('mainCourse', mainCourse);
		formData.append('menuIntro', menuIntro);
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
		var menuIntro = $(element).parent(".card").find("input[name='menuIntro']").val();
		var unitPrice = $(element).parent(".card").find("input[name='unitPrice']").val();
		var deliverable = $(element).parent(".card").find("input[name='deliverable']").prop("checked");
		var menuPic = $(element).parent(".card").find("input[name='menuPic']")[0].files[0];
	
		var formData = new FormData();
		formData.append('action', "update");
		formData.append('menuNo', menuNo);
		formData.append('chefNo', chefNo);
		formData.append('mainCourse', mainCourse);
		formData.append('menuIntro', menuIntro);
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
		$("#menu").after('<form id="menu" method="post" action="menu.do" enctype="multipart/form-data" style="width: 200px;margin-top: 20px;margin-bottom: 20px;"><div class="col-xs-12 col-sm-3 col-lg-2"><div class="card" style="width: 190px;"><div class="card-image"><img style="max-width: 190px; max-height: 250px;" src="<%=request.getContextPath()%>/Imgs/Menu/nopic.jpg"/><input class="menuPic" type="file" name="menuPic" accept="image/*" onchange="preview(this);" value=""/></div><div class="card-content"><div class="form-group" align="left"><label class="control-label" for="mainCourse">餐點名稱</label><div class=""><input type="text" class="form-control" name="mainCourse" value="" placeholder="請輸入餐點名稱" required/></div><label class="control-label" for="menuIntro">餐點簡介</label><div class=""><input type="text" class="form-control" name="menuIntro" value="" placeholder="請輸入餐點簡介" required/></div><label class="control-label" for="unitPrice">餐點價格</label><div class=""><input type="number" class="form-control" name="unitPrice" value="" placeholder="請輸入餐點價格" required/></div><div class=""><label><input type="checkbox" name="deliverable" value="可送餐" checked/>可送餐</label></div><input type="hidden" name="menuNo" value=""><input type="hidden" name="chefNo" value="${chefNo}"></div></div><input type="button" class="btn btn-success btn-sm" onclick="insert(this)" value="新增菜單"/></div></div></form>');
	}
	
	</script>

  </head>
  <body>
    
	  <%@include file="nav.file" %>
    <!-- END nav -->

	

    <section class="home-slider owl-carousel">
      <div class="slider-item bread-item" id="owlpic" style="background-image: url('<%=request.getContextPath()%>/front-end/memberchef/images/hover01.jpg');"  data-stellar-background-ratio="0.5">
        <div class="overlay"></div>
        <div class="container" data-scrollax-parent="true">
          <div class="row slider-text align-items-end">
            <div class="col-md-7 col-sm-12 ftco-animate mb-5">
              <h1 class="mb-3" data-scrollax=" properties: { translateY: '70%', opacity: .9}">送餐專區</h1>
            </div>
          </div>
        </div>
      </div>
      
      <div class="slider-item bread-item" id="owlpic" style="background-image: url('<%=request.getContextPath()%>/front-end/memberchef/images/hover02.jpg');" data-stellar-background-ratio="0.5">
        <div class="overlay"></div>
        <div class="container" data-scrollax-parent="true">
          <div class="row slider-text align-items-end">
            <div class="col-md-7 col-sm-12 ftco-animate mb-5">
              <h1 class="mb-3" data-scrollax=" properties: { translateY: '70%', opacity: .9}">送餐專區</h1>
            </div>
          </div>
        </div>
      </div>
      
      <div class="slider-item bread-item" id="owlpic" style="background-image: url('<%=request.getContextPath()%>/front-end/memberchef/images/hover03.jpg');" data-stellar-background-ratio="0.5">
        <div class="overlay"></div>
        <div class="container" data-scrollax-parent="true">
          <div class="row slider-text align-items-end">
            <div class="col-md-7 col-sm-12 ftco-animate mb-5">
              <h1 class="mb-3" data-scrollax=" properties: { translateY: '70%', opacity: .9}">送餐專區</h1>
            </div>
          </div>
        </div>
      </div>
    </section>
		
	<!-- Bootstrap NavBar -->

<!-- Bootstrap row -->
<div class="row" id="body-row">
    <!-- Sidebar -->
    <div id="sidebar-container" class="sidebar-expanded d-none d-md-block"><!-- d-* hiddens the Sidebar in smaller devices. Its itens can be kept on the Navbar 'Menu' -->
        <!-- Bootstrap List Group -->
        <ul class="list-group">
            <!-- Separator with title -->
            
            <!-- /END Separator -->
            <li class="list-group-item sidebar-separator-title text-light d-flex align-items-center menu-collapsed">
                <small>基本選單</small>
            </li>
            <!-- Menu with submenu -->
            <a href="<%=request.getContextPath()%>/front-end/memberchef/memberchef.jsp" class="bg-dark list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-user fa-fw mr-3"></span>
                    <span class="menu-collapsed">基本資料</span>
                </div>
            </a>            
           <a href="<%=request.getContextPath()%>/front-end/menu/menu.do?action=getOne_For_Display" class="bg-dark list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fas fa-calendar-alt fa-fw mr-3"></span>
                    <span class="menu-collapsed">基本菜單管理</span>
                </div>
            </a>            
            <a href="<%=request.getContextPath()%>/front-end/menulist/menulist.do?action=For_Display" class="bg-dark list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-calendar fa-fw mr-3"></span>
                    <span class="menu-collapsed">上架菜單管理</span>
                </div>
            </a>            
            <a href="<%=request.getContextPath()%>/front-end/memberchef/chefOrder.do?action=getNowOrder" class="bg-dark list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fas fa-list fa-fw mr-3"></span>
                    <span class="menu-collapsed">訂單管理</span>
                </div>
            </a>            
    </div><!-- sidebar-container END -->

   <!-------------------------------------------- MAIN -------------------------------------------->
<div class="container">
	<div class="row">
		<c:forEach var="menuVO" items="${list}">
	    	<form name="menuForm" method="post" action="menu.do" enctype="multipart/form-data" style="width: 200px;margin-top: 20px;margin-bottom: 20px;">  
		    	<div class="col-xs-12 col-sm-2 col-lg-2">
		        	<div class="card" style="width: 190px;">
		          		<div class="card-image">
		            		<img style="max-width: 190px; max-height: 250px;" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=${menuVO.menuNo}"/>
		            		<input type="file" name="menuPic" accept="image/*" onchange="preview(this);" value="${menuVO.menuPic}"/>  
		          		</div>
			          	<div class="card-content">
				            <div class="form-group" align="left">
					            <label class="control-label" for="mainCourse">餐點名稱</label>
					            <div class="">
					             	<input type="text" class="form-control" name="mainCourse" value="${menuVO.mainCourse}" placeholder="請輸入餐點名稱" required/>
					            </div>
					            <label class="control-label" for="menuIntro">餐點簡介</label>
					            <div class="">
					             	<input type="text" class="form-control" name="menuIntro" value="${menuVO.menuIntro}" placeholder="請輸入餐點簡介" required/>
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
					    <input type="hidden" class="btn btn-danger btn-sm" onclick="remove(this)" value="刪除餐點"/>
		    		</div>
	      		</div>
	      	</form>
		</c:forEach>
		<form id="menu" method="post" action="menu.do" enctype="multipart/form-data" style="width: 200px;margin-top: 20px;margin-bottom: 20px;">	
	      	<div class="col-xs-12 col-sm-2 col-lg-2">
		        <div class="card" style="width: 190px;">
		        	<div class="card-image">
		            	<img style="max-width: 190px; max-height: 250px;" src="<%=request.getContextPath()%>/Imgs/Menu/nopic.jpg"/>
		            	<input class="menuPic" type="file" name="menuPic" accept="image/*" onchange="preview(this);" value=""/>  
		        	</div>
		        	<div class="card-content">
			            <div class="form-group" align="left">
			            	<label class="control-label" for="mainCourse">餐點名稱</label>
			            	<div class="">
			              		<input type="text" class="form-control" name="mainCourse" value="" placeholder="請輸入餐點名稱" required/>
			            	</div>
			            	<label class="control-label" for="menuIntro">餐點簡介</label>
				            <div class="">
				             	<input type="text" class="form-control" name="menuIntro" value="" placeholder="請輸入餐點簡介" required/>
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
			            	<input type="hidden" name="chefNo" value="${chefNo}">
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
    			<input type="hidden" name="chefNo" value="${chefNo}">
	    		<input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" class="btn btn-primary" value="結束修改"/>
			</form>
    	</div>
	</div>
</div>   
   <!--------------------------------------------/MAIN -------------------------------------------->       
</div>
  <!-- body-row END -->
  <!-- Modal -->
  <div class="modal fade" id="modalRequest" tabindex="-1" role="dialog" aria-labelledby="modalRequestLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="modalRequestLabel">登入會員</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true" id="loghide">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form action="<%=request.getContextPath() %>/front-end/member/member.do" method="post">
            <div class="form-group">
              <!-- <label for="appointment_name" class="text-black">Full Name</label> -->
              <input type="text" class="form-control" id="appointment_name" placeholder="帳號" NAME="account">
            </div>
            <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="password" class="form-control" id="appointment_email" placeholder="密碼" NAME="password">
            </div>
             <div class="form-group">
              <input type="hidden" name="action" value="authorization">
              <input type="submit" value="登入" class="btn btn-primary">
              <input type="reset" value="清除" class="btn btn-primary">
<!--               <a href="signup.jsp" data-toggle="modal" data-target="#modalRequest2" id="signup"><input type="button" value="註冊會員" class="btn btn-primary" onclick="signup()" ></a> -->
<!--             	<a href="signup.jsp" data-toggle="modal" data-target="#modalRequest2" id="signup"><input type="button" value="註冊會員" class="btn btn-primary" onclick="signup()" id="signup2"></a> -->
            </div>
          </form>
          
          <c:if test="${not empty loginerrorMsgs}">
			<font style="color:red">請修正以下錯誤:</font>
			<ul>
			<c:forEach var="message" items="${loginerrorMsgs}">
			<li style="color:red">${message}</li>
	        </c:forEach>
			</ul>
		  </c:if>
		  <c:if test="${not empty accessfail}">
			<font style="color:red">請修正以下錯誤:</font>
			<ul>
			<c:forEach var="message" items="${accessfail}">
			<li style="color:red">${message}</li>
	        </c:forEach>
			</ul>
		  </c:if>
        </div>
      </div>
    </div>
  </div>

  
  <script src="<%=request.getContextPath()%>/front-end/js/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/front-end/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="<%=request.getContextPath()%>/front-end/js/popper.min.js"></script>
  <script src="<%=request.getContextPath()%>/front-end/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath()%>/front-end/js/jquery.easing.1.3.js"></script>
  <script src="<%=request.getContextPath()%>/front-end/js/jquery.waypoints.min.js"></script>
  <script src="<%=request.getContextPath()%>/front-end/js/jquery.stellar.min.js"></script>
  <script src="<%=request.getContextPath()%>/front-end/js/owl.carousel.min.js"></script>
  <script src="<%=request.getContextPath()%>/front-end/js/jquery.magnific-popup.min.js"></script>
  <script src="<%=request.getContextPath()%>/front-end/js/aos.js"></script>
  <script src="<%=request.getContextPath()%>/front-end/js/jquery.animateNumber.min.js"></script>
  <script src="<%=request.getContextPath()%>/front-end/js/bootstrap-datepicker.js"></script>
  <script src="<%=request.getContextPath()%>/front-end/js/jquery.timepicker.min.js"></script>
  <script src="<%=request.getContextPath()%>/front-end/js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&sensor=false&libraries=places&libraries=geometry">
  </script>
<!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&callback=initMap&libraries=places&libraries=geometry" -->

  <script src="<%=request.getContextPath()%>/front-end/js/google-map.js"></script>
  <script src="<%=request.getContextPath()%>/front-end/js/main.js"></script>
  
  
	
  </body>
  <!-- 以上為可動部分 -->
  <footer class="ftco-footer ftco-bg-dark ftco-section">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md-3">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Plus      <i class="fas fa-plus-square"></i></h2>
              <p>隨著老年人口日漸增加，青壯年人口隨著少子化議題逐漸縮減，照護人力明顯失衡，我們想藉由Live++這個平台提供年長族群有個可以彼此認識、交流的管道同時又提供生理及心理方面的照護。</p>
            </div>
            <ul class="ftco-footer-social list-unstyled float-md-left float-lft ">
              <li class="ftco-animate"><a href="#"><span class="icon-twitter"></span></a></li>
              <li class="ftco-animate"><a href="#"><span class="icon-facebook"></span></a></li>
              <li class="ftco-animate"><a href="#"><span class="icon-instagram"></span></a></li>
            </ul>
          </div>
          <div class="col-md-2">
            <div class="ftco-footer-widget mb-4 ml-md-5">
              <h2 class="ftco-heading-2">快速連結</h2>
              <ul class="list-unstyled">
                <li><a href="#" class="py-2 d-block">關於我們</a></li>
                <li><a href="#" class="py-2 d-block">未來展望</a></li>
                <li><a href="#" class="py-2 d-block">發展計畫</a></li>
                <li><a href="#" class="py-2 d-block">部落格</a></li>
                <li><a href="#" class="py-2 d-block">聯絡我們</a></li>
              </ul>
            </div>
          </div>
          <div class="col-md-4 pr-md-4">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">相關部落格</h2>
              <div class="block-21 mb-4 d-flex">
                <a class="blog-img mr-4" style="background-image: url(images/image_1.jpg);"></a>
                <div class="text">
                  <h3 class="heading"><a href="#">Even the all-powerful Pointing has no control about</a></h3>
                  <div class="meta">
                    <div><a href="#"><span class="icon-calendar"></span> Sept 15, 2018</a></div>
                    <div><a href="#"><span class="icon-person"></span> Admin</a></div>
                    <div><a href="#"><span class="icon-chat"></span> 19</a></div>
                  </div>
                </div>
              </div>
              <div class="block-21 mb-4 d-flex">
                <a class="blog-img mr-4" style="background-image: url(images/image_2.jpg);"></a>
                <div class="text">
                  <h3 class="heading"><a href="#">Even the all-powerful Pointing has no control about</a></h3>
                  <div class="meta">
                    <div><a href="#"><span class="icon-calendar"></span> Sept 15, 2018</a></div>
                    <div><a href="#"><span class="icon-person"></span> Admin</a></div>
                    <div><a href="#"><span class="icon-chat"></span> 19</a></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="ftco-footer-widget mb-4">
              <h2 class="ftco-heading-2">Office</h2>
              <div class="block-23 mb-3">
                <ul>
                  <li><span class="icon icon-map-marker"></span><span class="text">中央大學，工程二館，資策會CA105G3,中壢區，台灣</span></li>
                  <li><a href="#"><span class="icon icon-phone"></span><span class="text">30-3345678</span></a></li>
                  <li><a href="#"><span class="icon icon-envelope"></span><span class="text">2018CA105G3@gmail.com</span></a></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 text-center">

            <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
          </div>
        </div>
      </div>
    </footer>
</html>