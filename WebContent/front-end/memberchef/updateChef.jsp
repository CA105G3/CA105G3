<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.member.model.*"%>
<%@ page import="com.memberchef.model.*"%>

<%  
MemberVO memVO = (MemberVO)session.getAttribute("memVO");
MemberChefVO chefVO = (MemberChefVO) session.getAttribute("chefVO");
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
	<style>
	.file input {
	    position: absolute;
	    opacity: 0;
	    left: 0;
	}
	
	</style>

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
 <%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
   
   <div class="container" style="margin-top: 20px;">
   <form method="post" action="memberchef.do" name="chef" enctype="multipart/form-data">	
	<div class="row">
		<div class="col-xs-12 col-sm-3">
			<img src="<%=request.getContextPath()%>/front-end/memberchef/memberchefImg.do?chefNo=<%=chefVO.getChefNo()%>" id="preview" style="width: 280px; padding-top: 20px; padding-bottom: 20px;"/>
            <div class="file btn btn-lg btn-primary">
            	CHANGE PHOTO
                <input type="file" name="chefPic" accept="image/*" onchange="readURL(this);"/>
            </div>		
		</div>
		<div class="col-xs-12 col-sm-9">
		<div class="form-group row">
           <label for="chefNo" class="col-4 col-form-label">廚師編號</label> 
           <div class="col-8">
           		"<%=chefVO.getChefNo()%>"
           </div>
         </div>
         <div class="form-group row">
           <label for="chefName" class="col-4 col-form-label">廚師姓名</label> 
           <div class="col-8">
             <input id="chefName" name="chefName" value="<%=chefVO.getChefName()%>" placeholder="請輸入廚師姓名" class="form-control here" required="required" type="text">
             <br><div class="errMsg">${errorMsgs.chefName}</div>
           </div>
         </div>
         <div class="form-group row">
           <label for="chefAddr" class="col-4 col-form-label">地址</label> 
           <div class="col-8">
             <input id="chefAddr" name="chefAddr" value="<%=chefVO.getChefAddr()%>" placeholder="請輸入地址" class="form-control here" required="required" type="text">
             <br><div class="errMsg">${errorMsgs.chefAddr}</div>
           </div>
         </div>
         <div class="form-group row">
           <label for="chefPhone" class="col-4 col-form-label">電話</label> 
           <div class="col-8">
             <input id="chefPhone" name="chefPhone" value="<%=chefVO.getChefPhone()%>" placeholder="請輸入電話" class="form-control here" required="required" type="text">
             <br><div class="errMsg">${errorMsgs.chefPhone}</div>
           </div>
         </div>                              
         <div class="form-group row">
           <label for="chefRep" class="col-4 col-form-label">負責人</label> 
           <div class="col-8">
             <input id="chefRep" name="chefRep" value="<%=chefVO.getChefRep()%>" placeholder="請輸入負責人" class="form-control here" required="required" type="text">
             <br><div class="errMsg">${errorMsgs.chefRep}</div>
           </div>
         </div>
         <div class="form-group row">
           <label for="chefStoreName" class="col-4 col-form-label">商店名稱</label> 
           <div class="col-8">
             <input id="chefStoreName" name="chefStoreName" value="<%=chefVO.getChefStoreName()%>" placeholder="請輸入顯示商店名稱" class="form-control here" required="required" type="text">
             <br><div class="errMsg">${errorMsgs.chefStoreName}</div>
           </div>
         </div>
         <div class="form-group row">
           <label for="chefDescrip" class="col-4 col-form-label">商店簡介</label> 
           <div class="col-8">
             <textarea id="chefDescrip" name="chefDescrip" placeholder="請輸入40個字以內的簡介" cols="50" rows="7" class="form-control" required="required"><%=chefVO.getChefDescrip()%></textarea>
             <br><div class="errMsg">${errorMsgs.chefDescrip}</div>
           </div>
         </div>
         <div class="form-group row">
           <label for="chefStatus" class="col-4 col-form-label">狀態</label> 
           <div class="col-8">
           	 ${chefVO.chefStatus}
           </div>
         </div>
         <div class="form-group row">
           <div class="offset-4 col-8">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="chefNo" value="<%=chefVO.getChefNo()%>">
            <input type="hidden" name="memNo" value="<%=chefVO.getMemNo()%>">
           	<button type="submit" class="btn btn-success">送出修改</button>
           	<button type="reset" class="btn btn-secondary">清空重填</button>
           </div>
         </div>
		</div>
	</div>
	 </form> 
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
  
   <script>
// Hide submenus
   $('#body-row .collapse').collapse('hide'); 
   // Collapse/Expand icon
   $('#collapse-icon').addClass('fa-angle-double-left'); 
   // Collapse click
   $('[data-toggle=sidebar-colapse]').click(function() {
       SidebarCollapse();
   });
   function SidebarCollapse () {
       $('.menu-collapsed').toggleClass('d-none');
       $('.sidebar-submenu').toggleClass('d-none');
       $('.submenu-icon').toggleClass('d-none');
       $('#sidebar-container').toggleClass('sidebar-expanded sidebar-collapsed');
       
       // Treating d-flex/d-none on separators with title
       var SeparatorTitle = $('.sidebar-separator-title');
       if ( SeparatorTitle.hasClass('d-flex') ) {
           SeparatorTitle.removeClass('d-flex');
       } else {
           SeparatorTitle.addClass('d-flex');
       }
       
       // Collapse/Expand icon
       $('#collapse-icon').toggleClass('fa-angle-double-left fa-angle-double-right');
   }
   </script>
	
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