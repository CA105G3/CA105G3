<%@page import="com.member.model.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.activity.model.*"%>
<%@ page import="java.util.*" %>
<%
MemberVO memVO = (MemberVO)session.getAttribute("memVO");
String memNo=memVO.getMemNo();
pageContext.setAttribute("memNo", memNo);
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="Shortcut Icon" type="image/x-icon" href="<%=request.getContextPath()%>/template/images/favicon.ico">
    <title >Health PLUS</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/template/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/template/css/animate.css">
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/template/css/owl.carousel.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/template/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/template/css/magnific-popup.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/template/css/aos.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/template/css/ionicons.min.css">

    <link rel="stylesheet" href="<%=request.getContextPath()%>/template/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/template/css/jquery.timepicker.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/template/css/spring.css">

    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/template/css/flaticon.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/template/css/icomoon.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/template/css/style.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/activity/css/leftsidebar.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css"></link>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.css" />
    <!-- 我跟你說這些link你可以全部存在一隻jsp，之後的網頁再去link後來的jsp，這樣畫面會比較乾淨 、script一樣-->

    <style>

  #owlpic { 
	max-width:100%;
  } 
  #map {
		height: 500px;  /* The height is 400 pixels */
		width: 100%;  /* The width is the width of the web page */
	}
</style>
  </head>
  <body>
    
	  <%@include file="/front-end/member/includedfiles/nav.file" %>
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
            <a class="dropdown-item" href="#">Dashboard</a>
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
            
            <a href="<%= request.getContextPath()%>/front-end/activity/join_actall.jsp" class="bg-dark list-group-item list-group-item-action">
            <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/activity/activity.do" name="form1" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="Show_all">
                    <input type="hidden" name="actStatus" value="募集中">
                    <input type="submit" class="btn btn-info" value="查詢募集中活動">
               </FORM>
            </a>
            
            <!-- /END Separator -->
            <li class="list-group-item sidebar-separator-title text-light d-flex align-items-center menu-collapsed">
                <small>活動管理</small>
            </li>
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
                	<a href="<%= request.getContextPath()%>/front-end/activity/actone.jsp"  class="list-group-item list-group-item-action bg-dark text-white">
                    	<span class="menu-collapsed">查詢我建立的活動</span>
                	</a>
                	<a href="<%= request.getContextPath()%>/front-end/activity/personact.jsp" class="list-group-item list-group-item-action bg-dark text-white">
                    	<span class="menu-collapsed">查詢已參加的活動</span>
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
                <a href="<%= request.getContextPath()%>/front-end/impression/listOneImp.jsp" value="${memNo}" class="list-group-item list-group-item-action bg-dark text-white">
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
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/activity/activity.do" name="form1">
			
			<div class="container">
				<div><b>萬用複合查詢:</b></div>
				<div class="row">
					<div class="col-xs-12 col-sm-2">
						<b>輸入活動名稱:</b>
						<input type="text" name="actName" value="" style="width:150px; height:30px;">
					</div>
					<div class="col-xs-12 col-sm-2"style="width:150px; height:20px;">
						<b>輸入活動地點:</b>
						<input type="text" name="actLoc" value="桃園" style="width:150px; height:30px;">
					</div>
					<div class="col-xs-12 col-sm-2"style="width:150px; height:20px;">
						<b>起始時間:</b>
						<input type="text" name="startTime" id="f_date1" style="width:150px; height:30px;">
					</div>
					<div class="col-xs-12 col-sm-2">
						<b>中止時間:</b>
						<input type="text" name="endTime" id="f_date2" style="width:150px; height:30px;">
					</div>
					<div class="col-xs-12 col-sm-2">
						&nbsp;
				        <input type="submit" value="送出" class="btn btn-info">
				        <input type="hidden" name="action" value="actall_ByCompositeQuery" style="width:150px; height:30px;">
					</div>
					<div class="col-xs-12 col-sm-2">
					</div>
				</div>
			</div>
		</FORM>
</div>
	
   
        <div class="form-group">
			<label for="setRadius">搜尋距離</label>
			<div class="input-group" style="width:20%">
				<input type="text" id="setRadius" value="20000" class="form-control">
				<div class="input-group-addon">公尺</div>
				<div class="input-group-btn">
					<button class="btn btn-info" type="button" id="setRadiusBtn" onclick="initMap()">
						<i class="glyphicon glyphicon-search">確定</i>
					</button>
				</div>
			</div>
		</div>
		<div id="map"></div>

<!--         <div class="form-inline"> -->
<!--         <div class="card"> -->
<!--             <h4 class="card-header">Requirements</h4> -->
<!--             <div class="card-body"> -->
<!--                 <ul> -->
<!--                     <li>JQuery</li> -->
<!--                     <li>Bootstrap 4 beta-3</li> -->
<!--                 </ul> -->
<!--             </div> -->
<!--         </div> -->
        
<!--        <div class="card"> -->
<!--             <h4 class="card-header">Requirements</h4> -->
<!--             <div class="card-body"> -->
<!--                 <ul> -->
<!--                     <li>JQuery</li> -->
<!--                     <li>Bootstrap 4 beta-3</li> -->
<!--                 </ul> -->
<!--             </div> -->
<!--         </div> -->
        
<!-- 		<div class="card"> -->
<!--             <h4 class="card-header">Requirements</h4> -->
<!--             <div class="card-body"> -->
<!--                 <ul> -->
<!--                     <li>JQuery</li> -->
<!--                     <li>Bootstrap 4 beta-3</li> -->
<!--                 </ul> -->
<!--             </div> -->
<!--         </div> -->

<!--     </div>Main Col END -->
    
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
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&sensor=false&libraries=places&libraries=geometry">
  </script>
<!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&callback=initMap&libraries=places&libraries=geometry" -->

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
	<script src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.full.js"></script>
   <script>
   $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '',              // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });

        $('#f_date2').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '',              // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
   </script>
   
   <script type="text/javascript">
	function initMap(){
		var thePlaceNeedToBeDynmic = { lat: 24.968269, lng: 121.192192 }; 
        var map = new google.maps.Map(document.getElementById('map'), { zoom: 14, center: thePlaceNeedToBeDynmic });
        var marker = new google.maps.Marker({ position: thePlaceNeedToBeDynmic, map: map ,title:"中央大學"});
        
		navigator.geolocation.getCurrentPosition(myLoc);
	}

	function myLoc(pos){

		var loc = {lat: pos.coords.latitude, lng: pos.coords.longitude};

		map = new google.maps.Map(document.getElementById('map'), {
			center: loc,
			zoom: 12
		});
	
	var marker = new google.maps.Marker({
		position: loc,
		map: map,
		animation: google.maps.Animation.DROP,
		draggable: false
	});


	//畫圓
	var circle = new google.maps.Circle({
	  center: loc,
	  radius: parseInt($("#setRadius").val()),
	  strokeOpacity: 0,
	  fillColor: '#76A2DC',
	  fillOpacity: 0.35,
	  map: map
	});

	
	var markerArray = [];
	var infowindow = new google.maps.InfoWindow();
	
	<%
		ActivityService actSvc = new ActivityService();
		List<ActivityVO> list = actSvc.startact("募集中");
			for(ActivityVO actVO : list){
				String lat = actVO.getLatiTude();
				String lng = actVO.getLongtiTude();
	%>
			
			var json_Loc = <%="{\"lat\":"+lat+",\"lng\":"+lng+"}"%>;
			var dist = google.maps.geometry.spherical.computeDistanceBetween(
			           new google.maps.LatLng(loc),
			           new google.maps.LatLng(json_Loc)
			         )
console.log(dist);
			//距離低於搜尋範圍才標示marker
			if(dist < parseInt($("#setRadius").val())){
				
				var marker = new google.maps.Marker({
					position: json_Loc,
					map: map,
					animation: google.maps.Animation.DROP,
						draggable: false,
						//自訂標籤圖示
// 					icon:{
<%-- 						url:"<%=request.getContextPath()%>/front-end/activity/img/icon.png", --%>
// 						scaledSize: new google.maps.Size(20, 32),
// 					}
				});
				 markerArray.push(marker);

					google.maps.event.addListener(marker, 'click', function(){
					  msg ='<div style="font-weight:bold;background-image: linear-gradient(to top, #feada6 0%, #f5efef 100%);">'+'<%=actVO.getActName()%>'+'</div>'+'<div>'+'<%=actVO.getActLoc()%>'+'</div>'+'<%=actVO.getActTime()%>'+
					  	   '<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/activity/activity.do" name="form1" enctype="multipart/form-data">'+
	                   	   '<input type="hidden" name="action" value="Show__join_act">'+
	                       '<input type="hidden" name="actNo" value="<%=actVO.getActNo()%>">'+
	                       '<input type="submit" class="btn btn-info" value="查詢活動內容">'+
	               		   '</FORM>';

					  infowindow.setContent(msg);
				      infowindow.open(map, this);
					});
				}
			<%}%>
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