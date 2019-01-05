<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>
<%@ page import="java.util.*" %>
<%
	MemberVO memVO=null;
	memVO = (MemberVO)session.getAttribute("memVO");
	memVO=(MemberVO)request.getAttribute("memVO");
	if(memVO!=null){
		request.getSession().setAttribute("memno",memVO.getMemNo());
	}
	
	List<String> errorMsgs = (LinkedList)request.getAttribute("errorMsgs");
%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="Shortcut Icon" type="image/x-icon" href="images/favicon.ico">
    <title >Health PLUS</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
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
  	
  	
  	<style type="text/css">
  	#mytable{
  	padding-top:1%;
  	padding-bottom:1%;
  	padding-right:15%;
  	padding-left:15%;
  	}
  	#mydata{
  	text-decoration:underline;
  	}
  	table {
  	padding-top: 10%;
   	margin: 0 auto;
  	z-index: 1;
   	width:50%; 
   	height: 50px;
	}
  	
  	</style>
  
  </head>
	<body>
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
    
    
	<section>
	<div class="panel panel-info" id="mytable">
		  <div class="panel-heading">
		    <h3 class="panel-title">會員資料</h3>
		  </div>
		  <div class="panel-body" id="mydata">
		   	<div >
				<c:if test="${not empty errorMsgs}">
					<font style="color:red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color:red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>
				<FORM METHOD="post" ACTION="member.do" name="form1">
				<table>
					<tr>
						<td><p>會員編號:</p></td>
						<td><input name="memno" type="text" value="<%=memVO.getMemNo()%>" readonly></td>
					</tr>
					<tr>
						<td><p>會員帳號:</p></td>
						<td><input name="memid" type="text" value="<%=memVO.getMemId()%>" readonly></td>
					</tr>
					<tr>
						<td><p>會員密碼:</p></td>
						<td><input name="mempsw" type="password" value="<%=memVO.getPwd()%>"></td>
					</tr>
					<tr>
						<td><p>會員姓名:</p></td>
						<td><input name="memname" type="text" value="<%=memVO.getMemName()%>"></td>
					</tr>
					<tr>
						<td><p>會員性別:</p></td>
						<td><select name="gender">
							<option value="男" ${(memVO.gender=='男')?'selected':''}>男</option>
							<option value="女" ${(memVO.gender=='女')?'selected':''}>女</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><p>生日:</p></td>
						<td><input name="birth" id="birth_date"></td>
					</tr>
					<tr>
						<td><p>會員血型:</p></td>
						<td><select name="bloodtype">
							<option value="A" ${(memVO.bloodType=='A')?'selected':''}>A</option>
							<option value="B" ${(memVO.bloodType=='B')?'selected':''}>B</option>
							<option value="AB"${(memVO.bloodType=='AB')?'selected':''}>AB</option>
							<option value="O" ${(memVO.bloodType=='O')?'selected':''}>O</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><p>E-mail:</p></td>
						<td><input name="email" type="text" value="<%=memVO.getEmail()%>"></td>
					</tr>
					<tr>
						<td><p>電話:</p></td>
						<td><input name="phone" type="text" value="<%=memVO.getPhone()%>"></td>
					</tr>
					<tr>
						<td><p>郵遞區碼:</p></td>
						<td><input name="locno" type="text" value="<%=memVO.getLocNo()%>"></td>
					</tr>
					<tr>
						<td><p>地址:</p></td>
						<td><input name="addr" type="text" value="<%=memVO.getAddr()%>"></td>
					</tr>
					<tr>
						<td><p>會員狀態:</p></td>
						<td><input name="memstatus" type="text" value="<%=memVO.getMemStatus()%>" readonly></td>
					</tr>
					<tr>
						<td><p>過往病史:</p></td>
						<td><input name="medhistory" type="text" value="<%=memVO.getMedHistory()%>"></td>
					</tr>
					<tr>
						<td><p>家族病史:</p></td>
						<td><input name="famhistory" type="text" value="<%=memVO.getFamHistory()%>"></td>
					</tr> 
					<tr>
						<td><p>過敏記錄:</p></td>
						<td><input name="allergy" type="text" value="<%=memVO.getAllergy()%>"></td>
					</tr>
					<tr>
						<td><p>是否有吸菸:</p></td>
						<td><select name="smoking">
							<option value="有" ${(memVO.gender=='有')?'selected':''}>有</option>
							<option value="沒有" ${(memVO.gender=='沒有')?'selected':''}>沒有</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><p>會員狀態:</p></td>
						<td><select name="memstatus" disabled="disabled">
							<option value="正常" ${(memVO.gender=='正常')?'selected':''}>正常</option>
							<option value="停用" ${(memVO.gender=='停用')?'selected':''}>停用</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><p>註冊日期:</p></td>
						<td><input name="regdate" type="text" value="<%=memVO.getRegDate()%>" readonly></td>
					</tr>
					<tr>
						<td><p>會員身分:</p></td>
						<td><input name="ident" type="text" value="<%=memVO.getIdent()%>" readonly></td>
					</tr>
					<tr>
						<td><p>最後登入時間:</p></td>
						<td><input name="staytime" type="text" value="<%=memVO.getStayTime()%>" readonly></td>
					</tr>
					<tr>
					<td><input type="hidden" name="action" value="update"></td>
					<td><input type="submit" class="btn btn-primary" value="送出修改"></td>
					</tr>
				</table>
				</FORM>
			</div>
		  </div>
		</div>
	</section>


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
		   value: '<%=memVO.getBirth()%>',  // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           maxDate:               '+1970-01-01'  // 去除今日(不含)之後
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

            <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
          </div>
        </div>
      </div>
    </footer>
</html>