<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.menulist.model2.*" %>
<%@ page import="com.member.model.*" %>

<% 
  MemberVO memVO = (MemberVO)session.getAttribute("memVO");
%>
<html>
<head>
<meta charset="UTF-8">
<title>結帳頁面</title>

<style type="text/css">
table {
  border-collapse: collapse;
  width: 100%;
  box-shadow: 5px 5px #888888;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
font {
	font-weight: bold;
	font-family: "微軟正黑體";
}

.first {
	margin-top: 100px;
}

.second {
	margin-top: 20px;
}

.card-img {
	widows: 230px;
	height: 150px;
}

.card-body {
	margin-top: -15px;
}
</style>
<head>
    <link rel="Shortcut Icon" type="image/x-icon" href="images/favicon.ico">
    <title >Health PLUS</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
  
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700" rel="stylesheet">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/open-iconic-bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/animate.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/owl.carousel.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/owl.theme.default.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/magnific-popup.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/aos.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/ionicons.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/bootstrap-datepicker.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/jquery.timepicker.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/flaticon.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/icomoon.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/css/style.css">
	<link rel="stylesheet"  href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"  
		  integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
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
	          <li class="nav-item"><a href="#" class="nav-link"><%= (memVO==null)? "訪客" :memVO.getMemName() %> 您好!</a></li>
	          <li class="nav-item"><a href=<%=(memVO==null)? request.getContextPath()+"/front-end/index.jsp" : request.getContextPath()+"/front-end/member/member.do?action=getOne_For_Display&memno="+memVO.getMemNo() %> class="nav-link">個人設定</a></li>
	          <li class="nav-item"><a href="<%=request.getContextPath()%>/front-end/memberchef/listAllChef.jsp" class="nav-link">送餐專區</a></li>
	          <li class="nav-item"><a href="<%=request.getContextPath()%>/front-end/medicalOrder/ScanDoctor.jsp" class="nav-link">線上問診</a></li>
	          <li class="nav-item"><a href="<%=request.getContextPath() %>/front-end/activity/joinactivity.jsp" class="nav-link">活動專區</a></li>
	          <li class="nav-item"><a href="<%=request.getContextPath() %>/front-end/searchPage/shoppingCart.jsp" class="nav-link">購物餐車</a></li>
	          <li class="nav-item myOrder"><a href="<%=request.getContextPath() %>/front-end/foodorder/listAllFoodOrdersByMemno.jsp" class="nav-link">訂餐紀錄</a></li>
	          <li class="nav-item cta"><a href="<%=request.getContextPath() %>/front-end/member/member.do?action=logout" class="nav-link" <%= (memVO==null)? "data-toggle='modal' data-target='#modalRequest'" :"" %>  ><span id="mylogin"><%= (memVO==null)? "登入/註冊" :"登出" %></span></a></li>
	        </ul>
	      </div>
	    </div>
	 </nav>
    <!-- END nav -->
    <!--以下可改動-->
    <section class="home-slider owl-carousel">
        <div class="slider-item bread-item" style="background-image: url('<%=request.getContextPath()%>/front-end/searchPage/images/food1.1.JPG');" data-stellar-background-ratio="0.5">
            <div class="overlay"></div>
            <div class="container" data-scrollax-parent="true">
                <div class="row slider-text align-items-end">
                    <div class="col-md-7 col-sm-12 ftco-animate mb-5">
                        <h1><font id="font-type">送餐專區</font></h1>
                    </div>
                </div>
            </div>
        </div>
        <div class="slider-item bread-item" style="background-image: url('<%=request.getContextPath()%>/front-end/searchPage/images/food3.jpeg');" data-stellar-background-ratio="0.5">
            <div class="overlay"></div>
            <div class="container" data-scrollax-parent="true">
                <div class="row slider-text align-items-end">
                    <div class="col-md-7 col-sm-12 ftco-animate mb-5">
                        <h1><font id="font-type">送餐專區</font></h1>
                    </div>
                </div>
            </div>
        </div>
        <div class="slider-item bread-item" style="background-image: url('<%=request.getContextPath()%>/front-end/searchPage/images/food9.jpg');" data-stellar-background-ratio="0.5">
            <div class="overlay"></div>
            <div class="container" data-scrollax-parent="true">
                <div class="row slider-text align-items-end">
                    <div class="col-md-7 col-sm-12 ftco-animate mb-5">
                        <h1><font id="font-type">送餐專區</font></h1>
                    </div>
                </div>
            </div>
        </div>
         <div class="slider-item bread-item" style="background-image: url('<%=request.getContextPath()%>/front-end/searchPage/images/food6.jpg');" data-stellar-background-ratio="0.5">
            <div class="overlay"></div>
            <div class="container" data-scrollax-parent="true">
                <div class="row slider-text align-items-end">
                    <div class="col-md-7 col-sm-12 ftco-animate mb-5">
                        <h1><font id="font-type">送餐專區</font></h1>
                    </div>
                </div>
            </div>
        </div>
    </section>
<div class="container">
	<h2><font>訂餐項目</font></h2>
	<hr><p>
	<%-- <form id="checkoutForm" action="<%=request.getContextPath() %>/shoppingCart.do" method="get"> --%>
		<table class="table">
	  	<thead class="thead-dark">
		<tr>
			<th scope="col"><font>餐點名稱</font></th>
			<th scope="col"><font>供餐時段</font></th>
			<th scope="col"><font>單價</font></th>
			<th scope="col"><font>數量</font></th>
		</tr>
		</thead>

	<%  @SuppressWarnings("unchecked")
		Vector<MenuListVO> buylist = (Vector<MenuListVO>) session.getAttribute("shoppingcart");
		String chefNo = (String) request.getAttribute("chefNo");
		String total =  (String) request.getAttribute("total");
		String[] amountArray = request.getParameterValues("amount");
		String deliverAddr=(String)request.getAttribute("deliverAddr");
	%>
	<%	for (int i = 0; i < buylist.size(); i++) {
		MenuListVO order = buylist.get(i);
			chefNo = order.getChefNo();
			String chefRep = order.getChefRep();
			Date menuDate = order.getMenuDate();
			String mainCourse = order.getMainCourse();
			String menuTimeSlot = order.getMenuTimeSlot();
			String menuListNo = order.getMenuListNo();
			int unitPrice = order.getUnitPrice();
			int amount = order.getAmount();
	%>
	
		<tbody>
		<tr>
			<td scope="row"><%=mainCourse%>   </td>
			<td><%=menuDate%> <%=menuTimeSlot%>餐</td>
			<td><%=unitPrice%>    </td>
			<td><%=amount%> </td>
		</tr>
	<%
		}
	%>
		<tr>
			<td scope="row" colspan="5" style="text-align:right;"> 
			   <h4><font size="+2">總金額： $${total} </font></h4>
		    </td>
		</tr>
		</tbody>
	</table>
	<br><br>
    <h4><font>送餐地址:</font><%=deliverAddr%></h4> <br><br>
    
<!-- </form> -->
	
		<form name="new_order" action="<%=request.getContextPath()%>/shoppingCart.do" method="POST">
			   <input type="hidden" name="memno" value="<%=memVO.getMemNo() %>">
			   <input type="hidden" name="chefNo" value="<%=chefNo%>">
			   <input type="hidden" name="menuDate" value="${menuListVO.menuDate}">
			   <input type="hidden" name="menuTimeSlot" value="${menuListVO.menuTimeSlot}">
		   	   <input type="hidden" name="deliverAddr" value="<%=deliverAddr%>">
		   	   <input type="hidden" name="orderStatus" value="接受">
		   	   <input type="hidden" name="total" value="<%=total%>">
		   	   <input type="hidden" name="menuListNo" value="${menuListVO.menuListNo}">   		       
		       <input type="hidden" name="action"  value="insert"> 
		       <input type="submit" value="完成結帳" class="btn btn-dark">
		</form>
	</div>
</div>

<div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px">
            <circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee" />
            <circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg></div>
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
            	<a href="signup.jsp" data-toggle="modal" data-target="#modalRequest2" id="signup"><input type="button" value="註冊會員" class="btn btn-primary" onclick="signup()" id="signup2"></a>
            </div>
          </form>
          
          <table class="table1">
		      <tr><td>信用卡號碼：&nbsp;<input type="text" class="creditnumber" maxlength="4" size="4">&nbsp;-&nbsp;<input type="text" class="creditnumber" maxlength="4" size="4">&nbsp;-&nbsp;<input type="text" class="creditnumber" maxlength="4" size="4">&nbsp;-&nbsp;<input type="text" class="creditnumber" maxlength="4" size="4"></td></tr>
		      <tr><td>到期年月：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="creditnumber" maxlength="2" size="2"> &nbsp;/&nbsp;<input type="text" class="creditnumber" maxlength="2" size="2"></td></tr>
		      <tr><td>卡背末三碼：&nbsp;<input type="text" name="creditnumber" maxlength="3" size="3"></td></tr>
    	  </table>
          
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
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
    <script src="<%=request.getContextPath()%>/front-end/js/google-map.js"></script>
    <script src="<%=request.getContextPath()%>/front-end/js/main.js"></script>
</body>

<script>
$(function() {
    $(".creditnumber").keyup(function () {
        if (this.value.length == this.maxLength) {
          $(this).next('.creditnumber').focus();
        }
    });
});
</script>

<script>
$(document).ready(function(){
    $('.owl-carousel').owlCarousel({
        loop:true,
        interval:500,
        margin:10,
        nav:true,
        autoplay: true,
        autoplayTimeout: 2000,
        responsive:{
            0:{
                items:1
            },
            600:{
                items:3
            },
            1000:{
                items:5
            }
        }
    })  
  });  
</script>
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
                <p>
                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    Copyright &copy;<script>
                    document.write(new Date().getFullYear());
                    </script> All rights reserved | This template is made with <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                </p>
            </div>
        </div>
    </div>
</footer>

</html>