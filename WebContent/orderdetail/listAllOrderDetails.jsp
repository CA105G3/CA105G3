<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.foodorder.model.*" %>
<%@ page import="com.orderdetail.model.*" %>
<%@ page import="com.menulist.model.*" %>
<%@ page import="com.menu.model.*" %>

<%
	OrderDetailService orderDetailSvc = new OrderDetailService();
	List<OrderDetailVO> list = orderDetailSvc.getAll();
	pageContext.setAttribute("list",list);  //前面的list是pageContext裡站存空間的list,後面的list是自己VO裡的list
%>
<%
	MenuListService menuListSvc = new MenuListService();
	List<MenuListVO> list2 = menuListSvc.getAll();
	pageContext.setAttribute("list2",list2);  //前面的list是pageContext裡站存空間的list,後面的list是自己VO裡的list
%>
<%
	MenuService menuSvc = new MenuService();
	List<MenuVO> list3 = menuSvc.getAll();
	pageContext.setAttribute("list3",list3);  //前面的list是pageContext裡站存空間的list,後面的list是自己VO裡的list
%>
<html>
<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>
<head>
<meta charset="UTF-8">
<title>送餐專區</title>
<link rel="Shortcut Icon" type="image/x-icon" href="images/favicon.ico">
    <title>餐飲業者3</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700" rel="stylesheet">
    <link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/aos.css">
    <link rel="stylesheet" href="css/ionicons.min.css">
    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/icomoon.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
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
                    <li class="nav-item "><a href="index.html" class="nav-link">回到首頁</a></li>
                    <li class="nav-item"><a href="food.html" class="nav-link">送餐專區</a></li>
                    <li class="nav-item"><a href="doctors.html" class="nav-link">線上問診</a></li>
                    <li class="nav-item"><a href="activity.html" class="nav-link">活動專區</a></li>
                    <li class="nav-item"><a href="contact.html" class="nav-link">聯繫我們</a></li>
                    <li class="nav-item cta"><a href="contact.html" class="nav-link" data-toggle="modal" data-target="#modalRequest"><span>登入</span></a></li>
                </ul>
            </div>
        </div>
    </nav>
    <section class="home-slider owl-carousel">
        <div class="slider-item bread-item" style="background-image: url('images/food1.1.JPG');" data-stellar-background-ratio="0.5">
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
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤：</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<div class="container">
  <table>
	<tr>
		<th>訂單明細編號</th>
		<th>訂單編號</th>
		<th>餐飲列表編號</th>
		<th>數量</th>
		<th>單價</th>
		<th>明細狀態</th>
		<th>加入購物車</th>
	</tr>
	<c:forEach var="orderDetailVO" items="${list}"> 
		<tr>
			<td>${orderDetailVO.odno}</td>
			<td>${orderDetailVO.orderno}</td>
			<td>${orderDetailVO.menuListno}</td>
			<td>${orderDetailVO.amount}</td>
			<td><c:forEach var="menuListVO" items="${menuListSvc.all}">
                    <c:if test="${orderDetailVO.menuListno==menuListVO.menuListno}">
	                    <c:forEach var="menuVO" items="${menuSvc.all}">
                    		<c:if test="${orderDetailVO.unitPrice==menuVO.unitPrice}">
	                   		 ${deptVO.dname} 
                    		</c:if>
               			</c:forEach>
                    </c:if>
                </c:forEach>
			</td>
			<td>${orderDetailVO.odStatus}</td>
			<td><a href=""><img src="images/plus.jpg" width="30" height="20" border="0"></td>
		</tr>
	</c:forEach>
 </table>
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
                        <div class="form-group">
                            <input type="submit" value="登入" class="btn btn-primary">
                            <a href="blog.html"><input type="button" value="註冊會員" class="btn btn-primary" ></a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="js/jquery.min.js"></script>
    <script src="js/jquery-migrate-3.0.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
    <script src="js/jquery.waypoints.min.js"></script>
    <script src="js/jquery.stellar.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/aos.js"></script>
    <script src="js/jquery.animateNumber.min.js"></script>
    <script src="js/bootstrap-datepicker.js"></script>
    <script src="js/jquery.timepicker.min.js"></script>
    <script src="js/scrollax.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
    <script src="js/google-map.js"></script>
    <script src="js/main.js"></script>
</body>
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