<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.devdaily.calendar.Month,java.util.*,java.io.*,java.sql.*,com.devdaily.*" errorPage="error.jsp" %>
<%@ page import="com.member.model.*"%>
<%@ page import="com.menu.model.*"%>    
<%@ page import="com.menulist.model.*"%>  
<%  
MemberVO memVO = (MemberVO)session.getAttribute("memVO");
java.sql.Date regDate = null;
try {
	    regDate = memVO.getRegDate();
 } catch (Exception e) {
	   regDate = new java.sql.Date(System.currentTimeMillis());
 }
java.sql.Timestamp stayTime = null;
try{
	  stayTime=memVO.getStayTime();
}catch(Exception e){
	  stayTime=new java.sql.Timestamp(System.currentTimeMillis());
}

String chefNo = (String)session.getAttribute("chefNo");
List<MenuVO> menu = (List<MenuVO>)request.getAttribute("menu");
List<MenuListVO> menuList = (List<MenuListVO>)request.getAttribute("menuList");
%>
<%@ include file="calendarCommon.jsp" %>
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
<!--     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css"> -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/css/spring.css">

    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/flaticon.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/icomoon.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/activity/css/leftsidebar.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css"></link>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.css" />
    <!-- 我跟你說這些link你可以全部存在一隻jsp，之後的網頁再去link後來的jsp，這樣畫面會比較乾淨 、script一樣-->
<script src="https://code.jquery.com/jquery.js"></script>
<link rel="StyleSheet" href="css/calendar.css" type="text/css" media="screen" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<style type="text/css">
.card {
	position: relative;
  	margin:2% 5px 2% 5px;
  	background-color: #fff;
  	transition: box-shadow .25s;
  	border-radius: 2px;
   	box-shadow: 0 2px 5px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12);
	padding:0;
	min-width:200px;
	max-width:250px;
}
.card .card-image img {
	display: block;
	border-radius: 2px 2px 0 0;
	position: relative;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	width: 100%;
}
.card .card-content {
	padding: 0 0 0 0;
	border-radius: 0 0 2px 2px;
	height: 73px;
}

.card .card-content p {
	margin:0;
	font-size:1.45rem;
	color: #555555;
}
/*----3.a.Horizontal----*/
.card.horizontal .card-image img {
	max-width: 100px;
    max-height: 73px;
}

.card.horizontal {
  	display: -webkit-flex;
  	display: -ms-flexbox;
  	display: flex;
}
.card.horizontal.small .card-image,
 .card.horizontal.medium .card-image,
  .card.horizontal.large .card-image {
  	height: 100%;
  	max-height: none;
  	overflow: visible;
}
.card.horizontal .card-image img {
  	width:150px;
	height:150px;
	margin-right:0px;
}
.card.horizontal .card-stacked {
  	-webkit-flex-direction: column;
    -ms-flex-direction: column;
    flex-direction: column;
  	-webkit-flex: 1;
    -ms-flex: 1;
    flex: 1;
  	position: relative;
}
.card.horizontal .card-stacked .card-content {
  	-webkit-flex-grow: 1;
    -ms-flex-positive: 1;
	flex-grow: 1;
}
.card .card-image {
  position: relative;
}
h2 {
    margin-top: 10px;	
}
h4 {
    display: block;
    margin-block-start: 0.1em;
    margin-block-end: 0.4em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
}
h5 {
    display: block;
    margin-block-start: 0.1em;
    margin-block-end: 0.4em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    text-align: center;
}
.descrip_title {
	text-align: left;
    padding-left: 10px
}
.descrip_content {
	text-align: right;
    padding-left: 20px;
    padding-right: 10px
}
.col-sm-10 .descrip_title {
	text-align: left;
    padding-left: 6px
}
.monthControll {
	margin-top: 10px;
}
</style>

<script>
	var timer;
	function passValue(e){
		$("#mode").text("上架餐點");
		$("#shelf").css("visibility","visible");
		$("#target div").remove();
		$("#target").append($(e).clone().css("display","none"));
	}

	function setMenu(e){
		var element = e;
		var menuPic = $("#target img").attr("src");
		var mainCourse = $("#target span[name='mainCourse']").attr("value");
		var unitPrice = $("#target div[name='unitPrice']").attr("value");
		var deliverable = $("#target div[name='deliverable']").attr("value");
		var menuNo = $("#target input[name='menuNo']").val();
		var menuListNo = $(element).find("input[name='menuListNo']").val();
		var menuTimeSlot = $(element).find("input[name='menuTimeSlot']").val();
		var menuDay = $(element).find("input[name='menuDay']").val();

		if(menuPic === ""){
			menuPic = "<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg";
		}
		
		$(element).find("img").attr("src",menuPic);
		$(element).find("span[name='mainCourse']").text(mainCourse).css("font-size","1.2em");
		$(element).find("div[name='unitPrice']").text(unitPrice);
		$(element).find("div[name='deliverable']").text(deliverable);
		$(element).find("input[name='menuNo']").attr("value",menuNo);
		
		console.log(menuListNo);
		
 		if(menuListNo != ""){
			if($("#target img").attr("src") != ""){
				$.ajax({
					url: 'menulistajax.do',
					type: "post",
					data: { 
						action: "update",
						menuNo: menuNo,
						menuListNo: menuListNo,
						menuTimeSlot: menuTimeSlot,
						menuDay: menuDay,
						menuMonth: "<%=intMonth+1%>",
						menuYear: "<%=intYear%>"
						},
					dataType: "text",
					success: function(res){console.log("update success!");},
					error: function(xhr){alert("access error!");}
				});
			} else {
				$.ajax({
					url: 'menulistajax.do',
					type: "post",
					data: {action: "delete", menuListNo: menuListNo},
					dataType: "text",
					success: function(){console.log("delete success!");},
					error: function(){alert("access error!");}
				});
			}
		} else {
			if($("#target img").attr("src") != ""){
				$.ajax({
					url: 'menulistajax.do',
					type: "post",
					data: { 
						action: "insert",
						menuNo: menuNo,
						menuTimeSlot: menuTimeSlot,
						menuDay: menuDay,
						menuMonth: "<%=intMonth+1%>",
						menuYear: "<%=intYear%>"
						},
					dataType: "text",
					success: function(res){
						$(element).find("input[name='menuListNo']").attr("value", res);
						console.log(res);
						console.log("insert success!");
						},
					error: function(xhr){alert("access error!");}
				});
			}
		} 
	}

	$(document).ready(function(){
		$("#shelf").click(function(){
			var menuPic = $("#target img").attr("src");
			if(menuPic === ""){
				console.log("空值");
			} else {
				$("#target div").remove();
				$("#target").append($("#default").clone());
				$(this).css("visibility","hidden");
				$("#mode").text("下架餐點");
			}
		});
	});
	
	function debounce(callback, time){
		if(timer)
			 clearTimeout(timer);
		timer = setTimeout(function(){callback();}, time);
	}
</script>

  </head>
  <body>
    
	  <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="<%=request.getContextPath() %>/front-end/index.jsp">Plus<i class="fas fa-plus-square"></i></a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span>Menu
	      </button>
	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	          <li class="nav-item"><a href="food.html" class="nav-link"><%= (memVO==null)? "訪客" :memVO.getMemName() %> 您好!</a></li>
	          <li class="nav-item"><a href=<%=(memVO==null)? request.getContextPath()+"/front-end/index.jsp" : request.getContextPath()+"/front-end/member/member.do?action=getOne_For_Display&memno="+memVO.getMemNo() %> class="nav-link">個人設定</a></li>
	          <li class="nav-item"><a href="<%=request.getContextPath() %>/front-end/memberchef/listAllChef.jsp" class="nav-link">送餐專區</a></li>
	          <li class="nav-item"><a href="<%=request.getContextPath()%>/front-end/medicalOrder/ScanDoctor.jsp" class="nav-link">線上問診</a></li>
	          <li class="nav-item"><a href="<%=request.getContextPath() %>/front-end/activity/joinactivity.jsp" class="nav-link">活動專區</a></li>
	          <li class="nav-item cta"><a href="<%=request.getContextPath() %>/front-end/member/member.do?action=logout" class="nav-link" <%= (memVO==null)? "data-toggle='modal' data-target='#modalRequest'" :"" %>  ><span id="mylogin"><%= (memVO==null)? "登入/註冊" :"登出" %></span></a></li>
	        </ul>
	      </div>
	    </div>
	  </nav>
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
            <a href="<%=request.getContextPath()%>/front-end/menu/menu.jsp" class="bg-dark list-group-item list-group-item-action">
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
            <a href="<%=request.getContextPath()%>/front-end/memberchef/chefOrder.do?action=getOrder" class="bg-dark list-group-item list-group-item-action">
                <div class="d-flex w-100 justify-content-start align-items-center">
                    <span class="fas fa-list fa-fw mr-3"></span>
                    <span class="menu-collapsed">訂單管理</span>
                </div>
            </a>            
    </div><!-- sidebar-container END -->

   <!-------------------------------------------- MAIN -------------------------------------------->
<body id="print_view_page">

<div class="container">
<div class="row">
<div class="col-sm-2" style="position: relative;left: -300px;">

	<div><font size="3">編輯模式：</font><font id="mode" size="4">下架餐點</font></div>

	<div id="target">
		<div style="display: none;" class="card horizontal">
			<div class="card-image">
				<img name="menuPic" src="">
			</div>
			<div class="card-stacked">
				<div class="card-content">
					<div class="descrip_title" name="timeSlot">已選取餐點</div>
					<h4><span name="mainCourse" value=""></span></h4>
					<div class="descrip_content" name="unitPrice" value=""></div>
					<div class="descrip_content" name="deliverable" value=""></div>
					<div type="hidden" name="chefNo" value=""></div>
					<div type="hidden" name="menuNo" value=""></div>
				</div>
			</div>
		</div>
	</div>

	<div id="default" style="display: none;" class="card horizontal">
		<div class="card-image">
			<img name="menuPic" src="">
		</div>
		<div class="card-stacked">
			<div class="card-content">
				<div class="descrip_title" name="timeSlot">已選取餐點</div>
				<h4><span name="mainCourse" value=""></span></h4>
				<div class="descrip_content" name="unitPrice" value=""></div>
				<div class="descrip_content" name="deliverable" value=""></div>
				<div type="hidden" name="chefNo" value=""></div>
				<div type="hidden" name="menuNo" value=""></div>
			</div>
		</div>
	</div>
	
	<input class="btn btn-primary" type="button" style="visibility:hidden" id="shelf" value="進入下架模式"/>

	<c:forEach var="menuVO" items="${menu}">  
		<div class="card horizontal" onclick="passValue(this)">
			<div class="card-image">
				<img src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=${menuVO.menuNo}">
			</div>
			<div class="card-stacked">
				<div class="card-content">
					<div class="descrip_title" name="timeSlot">基本餐點</div>
					<h4><span name="mainCourse" value="${menuVO.mainCourse}">${menuVO.mainCourse}</span></h4>
					<div class="descrip_content" name="unitPrice" value="${menuVO.unitPrice}">${menuVO.unitPrice}元</div>
					<div class="descrip_content" name="deliverable" value="${menuVO.deliverable}">${menuVO.deliverable}</div>
					<%-- <input type="hidden" name="chefNo" value="${menuVO.chefNo}"/> --%>
					<input type="hidden" name="menuNo" value="${menuVO.menuNo}"/>
				</div>
			</div>
		</div>
	</c:forEach>
		
</div>
<div class="col-sm-10" style="position: relative;left: -270px;">
	<div id="calendar_print_view_main_div">
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-3">
				<td id="prev_link">
			      <form class="monthControll" method="post" action="menulist.do">
			        <button type="submit" class="btn btn-default" aria-label="Left Align" name="PREV">
			        	<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			        </button>
			        <input type="hidden" name="chefNo" value="CHEF0001">
			        <input type="hidden" name="action" value="For_Update">
			        <input type="hidden" name="month" value="<%=prevMonth%>">
			        <input type="hidden" name="year" value="<%=prevYear%>">
			      </form>
			    </td>
			</div>
			<div class="col-xs-12 col-sm-4">
				<td colspan="7" class="month_year_header">
			      <h2><%=monthName%>, <%=intYear%></h2>
			    </td>
			</div>
			<div class="col-xs-12 col-sm-3">
				<td id="next_link">
			      <form class="monthControll" method="post" action="menulist.do">
			        <button type="submit" class="btn btn-default" aria-label="Left Align" name="NEXT">
			        	<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			        </button>
			        <input type="hidden" name="chefNo" value="CHEF0001">
			        <input type="hidden" name="action" value="For_Update">
			        <input type="hidden" name="month" value="<%=nextMonth%>">
			        <input type="hidden" name="year" value="<%=nextYear%>">
			      </form>
			    </td>
			</div>
			<div class="col-xs-12 col-sm-2">
			  <form method="post" action="menulist.do">
				<input type="hidden" name="chefNo" value="<%=chefNo%>">
	   		   	<input type="hidden" name="action" value="For_Display">
	  		    <input type="submit" class="btn btn-primary" value="結束修改">
	  		  </form>
			</div>
		</div>
	</div>
	<table border="1" cellspacing="0" cellpadding="4" width="100%" height="100%" id="calendar_table">

	  <tr class="week_header_row">
	    <th width="15%" class="th_day_cell day">Sun</th>
	    <th width="14%" class="th_day_cell day">Mon</th>
	    <th width="14%" class="th_day_cell day">Tue</th>
	    <th width="14%" class="th_day_cell day">Wed</th>
	    <th width="14%" class="th_day_cell day">Thu</th>
	    <th width="14%" class="th_day_cell day">Fri</th>
	    <th width="15%" class="th_day_cell day">Sat</th>
	  </tr>
	<%
	{Month aMonth = Month.getMonth( Integer.parseInt(currentMonthString), Integer.parseInt(currentYearString) );
	  int [][] days = aMonth.getDays();
	  for( int i=0; i<aMonth.getNumberOfWeeks(); i++ ){
		%><tr class="week_data_row"><%
	    for( int j=0; j<7; j++ ){
	      if( days[i][j] == 0 ){
	        %><td class="empty_day_cell">&nbsp;</td><%
	      } else {
	        // this is "today"
	        if( currentDayInt == days[i][j] && currentMonthInt == aMonth.getMonth() && currentYearInt == aMonth.getYear() ){
	          %><td class="today_cell"><div><%=days[i][j]%></div>
	          	<div>
	          	<%	List<MenuListVO> tempMenuListVO = new ArrayList<MenuListVO>();
	          		StringBuilder timeFlag = new StringBuilder();
	          		for(MenuListVO menuListVO : menuList){
	       				if(menuListVO.getMenuDate().getDate() == days[i][j] && menuListVO.getMenuDate().getMonth()+1 == intMonth+1 && menuListVO.getMenuDate().getYear()+1900 == intYear) {
	     					tempMenuListVO.add(menuListVO);
	     					timeFlag.append(menuListVO.getMenuTimeSlot());
	       				}
	       			}
	          		
	          		switch(timeFlag.toString()){
	          		case "早午晚":
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			break;
	          		case "早午":
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          			break;	
	          		case "午晚":
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
						for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			break;	
	          		case "早晚":
	          			int flag = 0;
						for(MenuListVO menuListVO : tempMenuListVO){
		          			for(MenuVO menuVO : menu){
		          				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
		          					if(flag == 0){
		          						%><div class="card horizontal" onclick="setMenu(this)">
			          			            <div class="card-image">
		              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
		              			            </div>
		              			            <div class="card-stacked">
		              			              <div class="card-content">
		              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
		              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
		              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
		              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
		              			                <form>
			              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
			              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
			              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
			              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
			              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
			              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
		              			                </form>
		              			              </div>
		              			            </div>
			          			          </div>
			          			          <div class="card horizontal" onclick="setMenu(this)">
								            <div class="card-image">
								              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
								            </div>
								            <div class="card-stacked">
				      			              <div class="card-content">
				      			              	<div class="descrip_title" name="timeSlot">午餐</div>
				      			                <h5><span name="mainCourse"></span></h5>
				      			                <div class="descrip_content" name="unitPrice"></div>
				      			                <div class="descrip_content" name="deliverable"></div>
				      			                <form>
					       			                <input type="hidden" name="menuListNo" value=""/>
					       			                <input type="hidden" name="menuNo" value=""/>
					       			                <input type="hidden" name="menuTimeSlot" value="午"/>
					       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
					       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
					       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
				      			                </form>
				      			              </div>
				      			            </div>
								          </div>
			          					<%	flag++;
		          					} else {
		          						%><div class="card horizontal" onclick="setMenu(this)">
			          			            <div class="card-image">
		              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
		              			            </div>
		              			            <div class="card-stacked">
		              			              <div class="card-content">
		              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
		              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
		              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
		              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
		              			                <form>
			              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
			              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
			              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
			              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
			              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
			              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
		              			                </form>
		              			              </div>
		              			            </div>
			          			          </div>
			          					<%
		          					}
		          				}   						
		          			}
		          		}
	          			break;	
	          		case "早":
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	              		%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">午餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="午"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
	    					<%
	          			break;	
	          		case "午":
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
						%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          			break;	
	          		case "晚":
	              		%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">午餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="午"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
	    					<%
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			break;
	          		default:
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">午餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="午"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          		}
	          	%>
	          </div>
	          </td><%
	        } else {
	          %><td class="day_cell"><div><%=days[i][j]%></div>
	          <div>
	          	<%	List<MenuListVO> tempMenuListVO = new ArrayList<MenuListVO>();
	          		StringBuilder timeFlag = new StringBuilder();
	          		for(MenuListVO menuListVO : menuList){
	       				if(menuListVO.getMenuDate().getDate() == days[i][j] && menuListVO.getMenuDate().getMonth()+1 == intMonth+1 && menuListVO.getMenuDate().getYear()+1900 == intYear) {
	     					tempMenuListVO.add(menuListVO);
	     					timeFlag.append(menuListVO.getMenuTimeSlot());
	       				}
	       			}
	          		
	          		switch(timeFlag.toString()){
	          		case "早午晚":
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			break;
	          		case "早午":
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          			break;	
	          		case "午晚":
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
						for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			break;	
	          		case "早晚":
	          			int flag = 0;
						for(MenuListVO menuListVO : tempMenuListVO){
		          			for(MenuVO menuVO : menu){
		          				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
		          					if(flag == 0){
		          						%><div class="card horizontal" onclick="setMenu(this)">
			          			            <div class="card-image">
		              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
		              			            </div>
		              			            <div class="card-stacked">
		              			              <div class="card-content">
		              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
		              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
		              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
		              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
		              			                <form>
			              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
			              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
			              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
			              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
			              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
			              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
		              			                </form>
		              			              </div>
		              			            </div>
			          			          </div>
			          			          <div class="card horizontal" onclick="setMenu(this)">
								            <div class="card-image">
								              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
								            </div>
								            <div class="card-stacked">
				      			              <div class="card-content">
				      			              	<div class="descrip_title" name="timeSlot">午餐</div>
				      			                <h5><span name="mainCourse"></span></h5>
				      			                <div class="descrip_content" name="unitPrice"></div>
				      			                <div class="descrip_content" name="deliverable"></div>
				      			                <form>
					       			                <input type="hidden" name="menuListNo" value=""/>
					       			                <input type="hidden" name="menuNo" value=""/>
					       			                <input type="hidden" name="menuTimeSlot" value="午"/>
					       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
					       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
					       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
				      			                </form>
				      			              </div>
				      			            </div>
								          </div>
			          					<%	flag++;
		          					} else {
		          						%><div class="card horizontal" onclick="setMenu(this)">
			          			            <div class="card-image">
		              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
		              			            </div>
		              			            <div class="card-stacked">
		              			              <div class="card-content">
		              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
		              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
		              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
		              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
		              			                <form>
			              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
			              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
			              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
			              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
			              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
			              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
		              			                </form>
		              			              </div>
		              			            </div>
			          			          </div>
			          					<%
		          					}
		          				}   						
		          			}
		          		}
	          			break;	
	          		case "早":
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	              		%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">午餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="午"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
	    					<%
	          			break;	
	          		case "午":
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
						%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          			break;	
	          		case "晚":
	              		%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">午餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="午"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
	    					<%
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			break;
	          		default:
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">午餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="午"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          		}
	          	%>
	          </div></td><%
	        }
	      } // end outer if
	    } // end for%></tr><%
	  }
	}
	%>
	</table>
	</div><%-- end of "calendar_div" --%>
	
</div>
</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>	   
   <!--------------------------------------------/MAIN -------------------------------------------->       

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