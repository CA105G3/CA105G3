<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.foodorder.model.*" %>
<%-- <%@ page import="com.orderdetail.model.*" %> --%>
<%@ page import="com.menulist.model2.*" %>
<%@ page import="com.member.model.*" %>

<%-- <jsp:useBean id="listOds_ByOrderno" scope="request" type="java.util.Set<OrderDetailVO>" /> <!-- 於EL此行可省略 --> --%>

<% 
  MemberVO memVO = (MemberVO)session.getAttribute("memVO");
%>
<%-- <jsp:useBean id="foodOrderSvc" scope="page" class="com.foodorder.model.FoodOrderService" /> --%>
<%	
   FoodOrderService foodOrderSvc = new FoodOrderService();  
   List<FoodOrderVO> foodOrderVOList = (List<FoodOrderVO>) foodOrderSvc.findBy_Memno(memVO.getMemNo());  
   pageContext.setAttribute("foodOrderVOList", foodOrderVOList);  
%>
<%	
// 	FoodOrderService foodOrderSvc = new FoodOrderService();
// 	List<FoodOrderVO> list = foodOrderSvc.getAll();
// 	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="menuListSvc" scope="page" class="com.menulist.model2.MenuListService" />

<html>
<meta charset="UTF-8">
<title><%=memVO.getMemName() %>的餐飲訂單查詢</title>
<style type="text/css">
.button{
	background-color: #e5ffff;
	color: black;
}
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

tbody:nth-child(even) {
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
            <a class="navbar-brand" href="index.html">Plus      <i class="fas fa-plus-square"></i></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="oi oi-menu"></span> Menu
            </button>
            <div class="collapse navbar-collapse" id="ftco-nav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item "><a href="<%=request.getContextPath() %>/front-end/index.jsp" class="nav-link">回到首頁</a></li>
                    <li class="nav-item"><a href="<%=request.getContextPath() %>/front-end/memberchef/listAllChef.jsp" class="nav-link">送餐專區</a></li>
                    <li class="nav-item"><a href="<%=request.getContextPath()%>/front-end/medicalOrder/ScanDoctor.jsp" class="nav-link">線上問診</a></li>
                    <li class="nav-item"><a href="<%=request.getContextPath() %>/front-end/activity/joinactivity.jsp" class="nav-link">活動專區</a></li>
                    <li class="nav-item cta"><a href="contact.html" class="nav-link" data-toggle="modal" data-target="#modalRequest"><span>登入</span></a></li>
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
    
    
    
    
    
    <div class="container" style="margin-top:30px;display:none;" id="orderDetails">
    	<table class="table">
	  		<thead class="thead-dark">
				<tr>
					<th>訂單明細編號</th>
					<th>餐點名稱</th>
					<th>供餐時段</th>
					<th>單價</th>
					<th>數量</th>
				</tr>
			</thead>
			<tbody id="orderDetailsTbody" class="odTable">
			</tbody>
		</table>
    </div>
    
    
    
    
    
<div class="container">
	<h3><font><%=memVO.getMemName() %>的訂餐紀錄</font></h3>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤：</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
		<table class="table">
	  	<thead class="thead-dark">
			<tr>
				<th>訂單編號</th>
				<th>餐飲業者</th>
				<th>單價</th>
				<th>數量</th>
				<th>送餐地址</th>
			</tr>
		</thead>
		<c:forEach var="menuListVO" items="${menuListSvc.findByMemno(memVO.memNo)}">
		<tbody>
			<tr>
			 <td>
				 <FORM METHOD="get" ACTION="<%=request.getContextPath()%>/front-end/foodorder/foodorder.do" style="margin-bottom: 0px;">
<%-- 				    <input type="submit" value="${menuListVO.orderno}">  --%>
					<input type="button" value="${menuListVO.orderno}" class="button ordernoClick">
				    <input type="hidden" name="orderno" value="${menuListVO.orderno}">
				    <input type="hidden" name="action" value="find_od_by_orderno">
				 </FORM>
			 </td>
				 <td>${menuListVO.chefName}</td>
				 <td>${menuListVO.unitPrice}</td>
				 <td>${menuListVO.amount}</td>
				 <td>${menuListVO.deliverAddr}</td>
			</tr>
			</tbody>
			
			</c:forEach>
		</table>
		<br>
<%-- <%if (request.getAttribute("listOds_ByOrderno")!=null) { %> --%>
<%-- 		<jsp:include page="listAllOdByOrderno-session2.jsp" /> --%>
<%-- <%} %> --%>
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
<script type="text/javascript">
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
<script>
	$(document).ready(function(){
		$(".ordernoClick").click(function(){
			var url = "<%=request.getContextPath()%>/front-end/foodorder/foodorder.do";
			var orderno = $(this).next().val();
			var action = $(this).next().next().val();
			var dataSend = "";
			dataSend = dataSend + "orderno=" + orderno + "&action=find_od_by_ordernoWithAjax";
			$.ajax({
		  		type: 'get',
		  		url: url,
		  		data: dataSend,
		  		success: function(data){
		  			console.log(data);
		  			var detailList = JSON.parse(data);
		  			var orderDetailsTbody = $("#orderDetailsTbody");
		  			
		  			orderDetailsTbody.empty();
		  			for(var i = 0; i < detailList.length; i++){
		  				console.log(detailList[i]);
		  				orderDetailsTbody.append("<tr><td>" + detailList[i].odno + "</td><td>" + detailList[i].mainCourse + "</td><td>" + detailList[i].menuDate 
		  								+ " " + detailList[i].menuTimeSlot + "餐" + "</td><td>" + detailList[i].unitPrice + "</td><td>" + detailList[i].amount + "</td></tr>");
		  			}
		  			
					$("#orderDetails").show();
		  			
		  		}
	  		})
			
		});
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