<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="Shortcut Icon" type="image/x-icon" href="<%=request.getContextPath()%>/template/images/favicon.ico">
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
    <style>
    table{
    width:100%;
    }
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
  
  #owlpic { 
	max-width:100%;

  } 

</style>
  </head>
  <body>
    
	  <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="<%=request.getContextPath()%>/template/index.html">Plus      <i class="fas fa-plus-square"></i></a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	          <li class="nav-item active"><a href="<%=request.getContextPath()%>/front-end/index.html" class="nav-link">首頁</a></li>
	          <li class="nav-item"><a href="<%=request.getContextPath()%>/front-end/food.html" class="nav-link">送餐專區</a></li>
	          <li class="nav-item"><a href="<%=request.getContextPath()%>/front-end/doctors.html" class="nav-link">線上問診</a></li>
	          <li class="nav-item"><a href="impsearch.jsp" class="nav-link">活動專區</a></li>
	          <li class="nav-item"><a href="<%=request.getContextPath()%>/front-end/contact.html" class="nav-link">聯繫我們</a></li>
	          <li class="nav-item cta"><a href="<%=request.getContextPath()%>/front-end/contact.html" class="nav-link" data-toggle="modal" data-target="#modalRequest"><span>登入</span></a></li>
	        </ul>
	      </div>
	    </div>
	  </nav>
    <!-- END nav -->

	

    <section class="home-slider owl-carousel">
      <div class="slider-item bread-item" id="owlpic" style="background-image: url('<%=request.getContextPath()%>/front-end/activity/img/beach.gif');"  data-stellar-background-ratio="0.5">
        <div class="overlay"></div>
        <div class="container" data-scrollax-parent="true">
          <div class="row slider-text align-items-end">
            <div class="col-md-7 col-sm-12 ftco-animate mb-5">
              <h1 class="mb-3" data-scrollax=" properties: { translateY: '70%', opacity: .9}">活動專區</h1>
            </div>
          </div>
        </div>
      </div>
      
      <div class="slider-item bread-item" id="owlpic" style="background-image: url('<%=request.getContextPath()%>/front-end/activity/img/island.gif');" data-stellar-background-ratio="0.5">
        <div class="overlay"></div>
        <div class="container" data-scrollax-parent="true">
          <div class="row slider-text align-items-end">
            <div class="col-md-7 col-sm-12 ftco-animate mb-5">
              <h1 class="mb-3" data-scrollax=" properties: { translateY: '70%', opacity: .9}">活動專區</h1>
            </div>
          </div>
        </div>
      </div>
      
      <div class="slider-item bread-item" id="owlpic" style="background-image: url('<%=request.getContextPath()%>/front-end/activity/img/act1.gif');" data-stellar-background-ratio="0.5">
        <div class="overlay"></div>
        <div class="container" data-scrollax-parent="true">
          <div class="row slider-text align-items-end">
            <div class="col-md-7 col-sm-12 ftco-animate mb-5">
              <h1 class="mb-3" data-scrollax=" properties: { translateY: '70%', opacity: .9}">活動專區</h1>
            </div>
          </div>
        </div>
      </div>
    </section>
		
	<!-- Bootstrap NavBar -->
  
      <!-- This menu is hidden in bigger devices with d-sm-none. 
           The sidebar isn't proper for smaller screens imo, so this dropdown menu can keep all the useful sidebar itens exclusively for smaller screens  -->
      <li class="nav-item dropdown d-sm-block d-md-none">
        <a class="nav-link dropdown-toggle" href="#" id="smallerscreenmenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Menu
        </a>
        <div class="dropdown-menu" aria-labelledby="smallerscreenmenu">
            <a class="dropdown-item" href="#">活動搜尋</a>
            <a class="dropdown-item" href="#">Profile</a>
            <a class="dropdown-item" href="#">Tasks</a>
            <a class="dropdown-item" href="#">Etc ...</a>
        </div>
      </li><!-- Smaller devices menu END -->
      
    </ul>
  </div>
</nav><!-- NavBar END -->


<!-- Bootstrap row -->
<div class="row" id="body-row">

<!-- Sidebar -->
	<div id="sidebar-container" class="sidebar-expanded d-none d-md-block"><!-- d-* hiddens the Sidebar in smaller devices. Its itens can be kept on the Navbar 'Menu' -->

<!-- Bootstrap List Group -->
    <ul class="list-group">

<!-- Separator with title -->
	<li class="list-group-item sidebar-separator-title text-light d-flex align-items-center menu-collapsed">
		<small>活動管理</small>
	</li>
		<form METHOD="post" ACTION="<%=request.getContextPath()%>/activity/activity.do">
        	<a href="<%= request.getContextPath()%>/front-end/activity/actall.jsp" class="bg-dark list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-tasks fa-fw mr-3"></span>
                    <span class="menu-collapsed">查詢募集中活動</span>
                    <input type="hidden" name="action" value="Show_One">    
                </div>
            </a>
		</form>
            <!-- Menu with submenu -->
            <a href="#submenu1" data-toggle="collapse" aria-expanded="false" class="bg-dark list-group-item list-group-item-action flex-column align-items-start">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-dashboard fa-fw mr-3"></span> 
                    <span class="menu-collapsed">活動搜尋</span>
                    <span class="submenu-icon ml-auto"></span>
                </div>
            </a>
<!-- Submenu content -->
            <div id='submenu1' class="collapse sidebar-submenu">
            	<form METHOD="post" ACTION="<%=request.getContextPath()%>/activity/activity.do">
                	<a href="<%= request.getContextPath()%>/front-end/activity/actone.jsp" value="${memNo}" class="list-group-item list-group-item-action bg-dark text-white">
                    	<span class="menu-collapsed" name="action" value="Show_One">查詢我建立的活動</span>
                    	<input type="hidden" name="action" value="Show_One"> 
                	</a>
            	</form>
            	    
                <a href="#" class="list-group-item list-group-item-action bg-dark text-white">
                    <span class="menu-collapsed">查詢已結束活動</span>
                </a>
                <a href="#" class="list-group-item list-group-item-action bg-dark text-white">
                    <span class="menu-collapsed">Tables</span>
                </a>
            </div>
            <a href="#submenu2" data-toggle="collapse" aria-expanded="false" class="bg-dark list-group-item list-group-item-action flex-column align-items-start">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-user fa-fw mr-3"></span>
                    <span class="menu-collapsed">會員專區</span>
                    <span class="submenu-icon ml-auto"></span>
                </div>
            </a>
            <!-- Submenu content -->
            <div id='submenu2' class="collapse sidebar-submenu">
                <a href="<%= request.getContextPath()%>/front-end/activity/addact.jsp" class="list-group-item list-group-item-action bg-dark text-white">
                    <span class="menu-collapsed">建立活動</span>
                </a>
                <a href="<%= request.getContextPath()%>/front-end/impression/addImp.jsp" class="list-group-item list-group-item-action bg-dark text-white">
                    <span class="menu-collapsed">建立心得</span>
                </a>
                <a href="<%= request.getContextPath()%>/front-end/impression/listOneImp.jsp" class="list-group-item list-group-item-action bg-dark text-white">
                    <span class="menu-collapsed">我的心得</span>
                </a>
            </div>            
            
            <!-- Separator with title -->
            <li class="list-group-item sidebar-separator-title text-light d-flex align-items-center menu-collapsed">
                <small>參與活動查詢</small>
            </li>
            <!-- /END Separator -->
            <a href="<%= request.getContextPath()%>/front-end/impression/listAllImp.jsp" class="bg-dark list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-calendar fa-fw mr-3"></span>
                    <span class="menu-collapsed">查看所有心得</span>
                </div>
            </a>
            <a href="#" class="bg-dark list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-envelope-o fa-fw mr-3"></span>
                    <span class="menu-collapsed">Messages <span class="badge badge-pill badge-primary ml-2">5</span></span>
                </div>
            </a>
            <!-- Separator without title -->
            <li class="list-group-item sidebar-separator menu-collapsed"></li>            
            <!-- /END Separator -->
            <a href="#" class="bg-dark list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fa fa-question fa-fw mr-3"></span>
                    <span class="menu-collapsed">Help</span>
                </div>
            </a>
            <a href="#" data-toggle="sidebar-colapse" class="bg-dark list-group-item list-group-item-action d-flex align-items-center">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span id="collapse-icon" class="fa fa-2x mr-3"></span>
                    <span id="collapse-text" class="menu-collapsed">Collapse</span>
                </div>
            </a>
            <!-- List Group END-->
    </div><!-- sidebar-container END -->

    <!-- MAIN -->
    <div class="col">
        
        
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<br>

<div class="container">
  <jsp:useBean id="activitySvc" scope="page" class="com.activity.model.ActivityService" />
  <div class="form-inline">
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/activity/activity.do" >
        <b>輸入活動編號 (如ACT0001):</b>
        <input type="text" name="actNo">
        <input type="hidden" name="action" value="Show_One">
        <input type="submit" class="btn btn-primary" value="送出">
    </FORM>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/activity/activity.do" >
       <b>選擇活動編號:</b>
       <select size="1" name="actNo">
         <c:forEach var="activityVO" items="${activitySvc.all}" > 
          <option value="${activityVO.actNo}">${activityVO.actName}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="Show_One">
       <input type="submit" class="btn btn-primary" value="送出">
    </FORM>
</div>
</div>

<h3>新增活動</h3>

<ul>
  <li><a href="<%=request.getContextPath()%>/front-end/activity/addact.jsp">Add</a> a new act.</li>
</ul>   
        
        <div class="form-inline">
        <div class="card">
            <h4 class="card-header">Requirements</h4>
            <div class="card-body">
                <ul>
                    <li>JQuery</li>
                    <li>Bootstrap 4 beta-3</li>
                </ul>
            </div>
        </div>
        
       <div class="card">
            <h4 class="card-header">Requirements</h4>
            <div class="card-body">
                <ul>
                    <li>JQuery</li>
                    <li>Bootstrap 4 beta-3</li>
                </ul>
            </div>
        </div>
        
		<div class="card">
            <h4 class="card-header">Requirements</h4>
            <div class="card-body">
                <ul>
                    <li>JQuery</li>
                    <li>Bootstrap 4 beta-3</li>
                </ul>
            </div>
        </div>

    </div><!-- Main Col END -->
    
</div><!-- body-row END -->
	
 
 
  

  <!-- Modal -->
  <div class="modal fade" id="modalRequest" tabindex="-1" role="dialog" aria-labelledby="modalRequestLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="modalRequestLabel">登入會員</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form action="#">
            <div class="form-group">
              <!-- <label for="appointment_name" class="text-black">Full Name</label> -->
              <input type="text" class="form-control" id="appointment_name" placeholder="使用者名稱">
            </div>
            <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="text" class="form-control" id="appointment_email" placeholder="密碼">
            </div>
            
            <div class="form-inline">
              <input type="submit" value="登入" class="btn btn-primary">
              <a href="<%=request.getContextPath()%>/template/contact.html" class="nav-link" data-toggle="modal" data-target="#modalRequest2"><input type="button" value="註冊會員" class="btn btn-primary" ></a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  <script src="<%=request.getContextPath()%>/template/js/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/template/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="<%=request.getContextPath()%>/template/js/popper.min.js"></script>
  <script src="<%=request.getContextPath()%>/template/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath()%>/template/js/jquery.easing.1.3.js"></script>
  <script src="<%=request.getContextPath()%>/template/js/jquery.waypoints.min.js"></script>
  <script src="<%=request.getContextPath()%>/template/js/jquery.stellar.min.js"></script>
  <script src="<%=request.getContextPath()%>/template/js/owl.carousel.min.js"></script>
  <script src="<%=request.getContextPath()%>/template/js/jquery.magnific-popup.min.js"></script>
  <script src="<%=request.getContextPath()%>/template/js/aos.js"></script>
  <script src="<%=request.getContextPath()%>/template/js/jquery.animateNumber.min.js"></script>
  <script src="<%=request.getContextPath()%>/template/js/bootstrap-datepicker.js"></script>
  <script src="<%=request.getContextPath()%>/template/js/jquery.timepicker.min.js"></script>
  <script src="<%=request.getContextPath()%>/template/js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="<%=request.getContextPath()%>/template/js/google-map.js"></script>
  <script src="<%=request.getContextPath()%>/template/js/main.js"></script>
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