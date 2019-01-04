<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>
<%@ page import="java.util.*" %>
<%
	MemberVO memVO = (MemberVO)session.getAttribute("memVO");
	if(memVO!=null){
		request.getSession().setAttribute("memno",memVO.getMemNo());
	}
	
	List<String> loginerrorMsgs = (LinkedList)request.getAttribute("loginerrorMsgs");
	
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
%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="Shortcut Icon" type="image/x-icon" href="images/favicon.ico">
    <title >Health PLUS</title>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
    <link rel="stylesheet" type="text/css" href="css/spring.css">

    
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/icomoon.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
  	<style>
  	.modal {
  	overflow-y:auto;
	}
  	</style>
  </head>
  <body <%=(loginerrorMsgs==null)?"":"onload=faillogin()" %>>
    
	  <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	    <div class="container">
	      <a class="navbar-brand" href="index.jsp">Plus      <i class="fas fa-plus-square"></i></a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> Menu
	      </button>

	      <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	          <li class="nav-item"><a href="food.html" class="nav-link"><%= (memVO==null)? "訪客" :memVO.getMemName() %> 您好!</a></li>
	          <li class="nav-item"><a href=<%=(memVO==null)? "index.jsp" : request.getContextPath()+"/front-end/member/member.do?action=getOne_For_Display&memno="+memVO.getMemNo() %> class="nav-link">個人設定</a></li>
	          <li class="nav-item"><a href="food.html" class="nav-link">送餐專區</a></li>
	          <li class="nav-item"><a href="doctors.html" class="nav-link">線上問診</a></li>
	          <li class="nav-item"><a href="../impression/impsearch.jsp" class="nav-link">活動專區</a></li>
	          <li class="nav-item"><a href="contact.html" class="nav-link">聯繫我們</a></li>
	          <li class="nav-item cta"><a href="member.do?action=logout" class="nav-link" <%= (memVO==null)? "data-toggle='modal' data-target='#modalRequest'" :"" %>  ><span id="mylogin"><%= (memVO==null)? "登入/註冊" :"登出" %></span></a></li>
	        </ul>
	      </div>
	    </div>
	  </nav>
    <!-- END nav -->
    
    <!-- 可動部分 -->
    <section class="home-slider owl-carousel">
      <div class="slider-item" style="background-image: url('images/bg_1.jpg');">
        <div class="overlay"></div>
        <div class="container">
          <div class="row slider-text align-items-center" data-scrollax-parent="true">
            <div class="col-md-6 col-sm-12 ftco-animate" data-scrollax=" properties: { translateY: '70%' }">
              <h1 class="mb-4" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">舒適的問診體驗</h1>
              <p class="mb-4" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">輕鬆簡單的方式，讓您在家也能體驗醫療的好處</p>
              <p data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"><a href="doctors.html" class="btn btn-primary px-4 py-3">立即預約</a></p>
            </div>
          </div>
        </div>
      </div>

      <div class="slider-item" style="background-image: url('images/bg_2.jpg');">
        <div class="overlay"></div>
        <div class="container">
          <div class="row slider-text align-items-center" data-scrollax-parent="true">
            <div class="col-md-6 col-sm-12 ftco-animate" data-scrollax=" properties: { translateY: '70%' }">
              <h1 class="mb-4" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">專業的醫療服務</h1>
              <p class="mb-4">為家中不方便的患者所提供的線上諮詢，您一定不能錯過!!</p>
              <p><a href="#" class="btn btn-primary px-4 py-3">線上預約</a></p>
            </div>
          </div>
        </div>
      </div>
    </section>




    <div class="container">
      <div class="row justify-content-center" >
        <div class="col-md-7 text-center heading-section ftco-animate mb-5 pb-5">
            <h2 class="mb-3">活動專區</h2>
            <p>為您的生活添加樂趣，與其他人一起參與吧!</p>
          </div>
        </div>
      <div class="row">
        <div class="col-xs-4 col-sm-4">
          <div class="xxx">
            <img src="https://api.fnkr.net/testimg/350x400/00CED1/FFF/?text=img+placeholder">
          </div>
        </div>
        <div class="col-xs-4 col-sm-4">
          <div class="xxx">
            <img src="https://api.fnkr.net/testimg/350x400/00CED1/FFF/?text=img+placeholder">
          </div>  
        </div>
        <div class="col-xs-4 col-sm-4">
          <div class="xxx">
            <img src="https://api.fnkr.net/testimg/350x400/00CED1/FFF/?text=img+placeholder">
          </div>  
        </div>
      </div>  
    </div>


    <section class="ftco-section">
      <div class="container">
      	<div class="row justify-content-center mb-5 pb-5">
          <div class="col-md-7 text-center heading-section ftco-animate">
            <h2 class="mb-3">遇見懂你/妳的醫生</h2>
            <p>每天線上都有優質的醫師群等著為您服務</p>
          </div>
        </div>
        <div class="row">
        	<div class="col-lg-3 col-md-6 d-flex mb-sm-4 ftco-animate">
        		<div class="staff">
      				<div class="img mb-4" style="background-image: url(images/tomcat.gif);"></div>
      				<div class="info text-center">
      					<h3><a href="teacher-single.html">Tom cat</a></h3>
      					<span class="position">軟體治療師</span>
      					<div class="text">
	        				<p>Far far away, behind the word mountains, far from the countries Vokalia</p>
	        				<ul class="ftco-social">
			              <li class="ftco-animate"><button type="button" class="btn btn-primary"><a href="about.html">前往</button></a></li>
			            </ul>
	        			</div>
      				</div>
        		</div>
        	</div>
        	<div class="col-lg-3 col-md-6 d-flex mb-sm-4 ftco-animate">
        		<div class="staff">
      				<div class="img mb-4" style="background-image: url(images/dragon.jpg);"></div>
      				<div class="info text-center">
      					<h3><a href="teacher-single.html">Mark KO P</a></h3>
      					<span class="position">藍綠心理分析師</span>
      					<div class="text">
	        				<p>Far far away, behind the word mountains, far from the countries Vokalia</p>
	        				<ul class="ftco-social">
			              <li class="ftco-animate"><button type="button" class="btn btn-primary"><a href="about.html">前往</button></a></li>
			            </ul>
	        			</div>
      				</div>
        		</div>
        	</div>
        	<div class="col-lg-3 col-md-6 d-flex mb-sm-4 ftco-animate">
        		<div class="staff">
      				<div class="img mb-4" style="background-image: url(images/eason.jpg);"></div>
      				<div class="info text-center">
      					<h3><a href="teacher-single.html">Patrick Eason</a></h3>
      					<span class="position">Ear治療師</span>
      					<div class="text">
	        				<p>Far far away, behind the word mountains, far from the countries Vokalia</p>
	        				<ul class="ftco-social">
			              <li class="ftco-animate"><button type="button" class="btn btn-primary"><a href="about.html">前往</button></a></li>
			            </ul>
	        			</div>
      				</div>
        		</div>
        	</div>
        	<div class="col-lg-3 col-md-6 d-flex mb-sm-4 ftco-animate">
        		<div class="staff">
      				<div class="img mb-4" style="background-image: url(images/black.jpg);"></div>
      				<div class="info text-center">
      					<h3><a href="teacher-single.html">Ivan Black</a></h3>
      					<span class="position">無照醫師</span>
      					<div class="text">
	        				<p>Far far away, behind the word mountains, far from the countries Vokalia</p>
	        				<ul class="ftco-social">
			              <li class="ftco-animate"><button type="button" class="btn btn-primary"><a href="about.html">前往</button></a></li>
			            </ul>
	        			</div>
      				</div>
        		</div>
        	</div>
        </div>
        <div class="row  mt-5 justify-conten-center">
        </div>
      </div>
    </section>

    <section class="ftco-section">
      <div class="container">
        <div class="row justify-content-center mb-5 pb-3">
          <div class="col-md-7 text-center heading-section ftco-animate">
            <h2 class="mb-2">送餐專區</h2>
            <p>A small river named Duden flows by their place and supplies it with the necessary regelialia.</p>
          </div>
        </div>
        <div class="row">
          <div class="col-md-4 ftco-animate">
            <div class="blog-entry">
              <a href="blog-single.html" class="block-20" style="background-image: url('images/image_1.jpg');">
              </a>
              <div class="text d-flex py-4">
                <div class="meta mb-3">
                  <div><a href="#">Sep. 20, 2018</a></div>
                  <div><a href="#">Admin</a></div>
                  <div><a href="#" class="meta-chat"><span class="icon-chat"></span> 3</a></div>
                </div>
                <div class="desc pl-3">
	                <h3 class="heading"><a href="#">Even the all-powerful Pointing has no control about the blind texts</a></h3>
	              </div>
              </div>
            </div>
          </div>
          <div class="col-md-4 ftco-animate">
            <div class="blog-entry" data-aos-delay="100">
              <a href="blog-single.html" class="block-20" style="background-image: url('images/image_2.jpg');">
              </a>
              <div class="text d-flex py-4">
                <div class="meta mb-3">
                  <div><a href="#">Sep. 20, 2018</a></div>
                  <div><a href="#">Admin</a></div>
                  <div><a href="#" class="meta-chat"><span class="icon-chat"></span> 3</a></div>
                </div>
                <div class="desc pl-3">
	                <h3 class="heading"><a href="#">Even the all-powerful Pointing has no control about the blind texts</a></h3>
	              </div>
              </div>
            </div>
          </div>
          <div class="col-md-4 ftco-animate">
            <div class="blog-entry" data-aos-delay="200">
              <a href="blog-single.html" class="block-20" style="background-image: url('images/image_3.jpg');">
              </a>
              <div class="text d-flex py-4">
                <div class="meta mb-3">
                  <div><a href="#">Sep. 20, 2018</a></div>
                  <div><a href="#">Admin</a></div>
                  <div><a href="#" class="meta-chat"><span class="icon-chat"></span> 3</a></div>
                </div>
                <div class="desc pl-3">
	                <h3 class="heading"><a href="#">Even the all-powerful Pointing has no control about the blind texts</a></h3>
	              </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    
    
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

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
          <form action="member.do" method="post">
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
              <a href="signup.jsp" data-toggle="modal" data-target="#modalRequest2"><input type="button" value="註冊會員" class="btn btn-primary" onclick="signup()"></a>
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
          
        </div>
      </div>
    </div>
  </div>
  
  
  
  
  
  <div class="modal fade" id="modalRequest2" tabindex="-1" role="dialog" aria-labelledby="modalRequestLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="modalRequestLabel">會員註冊</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form action="member.do">
            <div class="form-group">
              <!-- <label for="appointment_name" class="text-black">Full Name</label> -->
              <input type="text" class="form-control" id="sign_account" placeholder="使用者名稱" NAME="memid">
            </div>
            <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="password" class="form-control" id="sign_password" placeholder="密碼" NAME="mempsw">
            </div>
            <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="text" class="form-control" id="sign_name" placeholder="姓名" NAME="memname">
            </div>
            <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <p>性別</p>
              <select name="gender">
			  <option value="男" selected="selected">男</option>
			  <option value="女">女</option>
			</select>
            </div>
            <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
               <p>生日</p>
              <input name="birth" id="birth_date">
            </div>
            <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <p>血型</p>
              <select name="bloodtype">
			  <option value="A" selected="selected">A</option>
			  <option value="B">B</option>
			  <option value="O">O</option>
			  <option value="AB">AB</option>
			  </select>
            </div>
            <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="text" class="form-control" id="sign_email" placeholder="E-mail" NAME="email">
            </div>
            
            <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="text" class="form-control" id="sign_phone" placeholder="電話" NAME="phone">
            </div>
           
           <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="text" class="form-control" id="sign_locno" placeholder="郵遞區號" NAME="locno">
            </div>
           
           <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="text" class="form-control" id="sign_address" placeholder="地址" NAME="addr">
            </div>
           
           <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="text" class="form-control" id="sign_medhistory" placeholder="過去病史" NAME="medhistory">
            </div>
           
           <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="text" class="form-control" id="sign_famhistory" placeholder="家族病史" NAME="famhistory">
            </div>
           
           <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="text" class="form-control" id="sign_allergy" placeholder="過敏記錄" NAME="allergy">
            </div>
           
           <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
            <p>是否抽菸</p>
            <select name="smoking">
			<option value="有" selected="selected">有</option>
			<option value="沒有">沒有</option>
		    </select>
            </div>
           
            <div class="form-group">
            <input type="hidden" name="action" value="insert">
              <input type="submit" value="註冊" class="btn btn-primary">
              <input type="reset" value="清除" class="btn btn-primary">
              <input type="hidden" name="memStatus" value="停用">
			  <input type="hidden" name="ident" value="一般會員">
			  <input type="hidden" name="regdate" value="<%=regDate%>">
			  <input type="hidden" name="staytime" value="<%=stayTime%>">
            </div>
          </form>
          
          <c:if test="${not empty errorMsgs}">
			<font style="color:red">請修正以下錯誤:</font>
			
			<ul>
			<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
	      </c:forEach>
			</ul>
		  </c:if>
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
  <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
  <script src="js/index.js"></script>  
  <script type="text/javascript">
  function faillogin(){ 
  	$("#mylogin").trigger("click");
  };
  
  function signup(){ 
	  	$("#loghide").trigger("click");
	  };
  
  </script>
  
  
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>
<script>
        $.datetimepicker.setLocale('zh');
        $('#birth_date').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   //value: '<%=regDate%>',  // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
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