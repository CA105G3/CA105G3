<%@page import="com.activity.model.ActivityService"%>
<%@page import="com.activity.model.ActivityVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>
<%@ page import="com.memberchef.model.*"%>  
<%@ page import="java.util.*" %>

<!-- 顯示首頁醫生訊息 -->
<%@ page import="com.doctor.model.*"%> 
<jsp:useBean id="doctorVO" scope="page" class="com.doctor.model.DoctorVO" />
<jsp:useBean id="doctorSvc" scope="page" class="com.doctor.model.DoctorService" />
<jsp:useBean id="memberVO" scope="page" class="com.member.model.MemberVO" />
<jsp:useBean id="memberSvc" scope="page" class="com.member.model.MemberService"/>

<%
	MemberVO memVO=null;
	memVO = (MemberVO)session.getAttribute("memVO");
	
	if(memVO!=null){
		request.getSession().setAttribute("memno",memVO.getMemNo());
	}
	List<String> errorMsgs = (LinkedList)request.getAttribute("errorMsgs");
	List<String> loginerrorMsgs = (LinkedList)request.getAttribute("loginerrorMsgs");
	List<String> accessfail=(LinkedList)request.getSession().getAttribute("accessfail");
	 
	//for login and signup
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
	<%@include file="member/includedfiles/css.file" %>
</head>


<%--   <body <%=(loginerrorMsgs==null)?"":"onload=faillogin()" %>> --%>
    <body<% if(loginerrorMsgs!=null||accessfail!=null){
    	out.print(" onload=faillogin()");
    }else if(errorMsgs!=null){
    	out.print(" onload=failsignup()");
	}
    %>>
    
	<%@include file="/front-end/member/includedfiles/nav.file" %>
    <!-- END nav -->
    
    <!-- 可動部分 -->
    <section class="home-slider owl-carousel">
      <div class="slider-item" style="background-image: url('<%=request.getContextPath() %>/front-end/member/images/bg_1.jpg');">
        <div class="overlay"></div>
        <div class="container">
          <div class="row slider-text align-items-center" data-scrollax-parent="true">
            <div class="col-md-6 col-sm-12 ftco-animate" data-scrollax=" properties: { translateY: '70%' }">
              <h1 class="mb-4" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">舒適的問診體驗</h1>
              <p class="mb-4" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">輕鬆簡單的方式，讓您在家也能體驗醫療的好處</p>
              <p data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"><a href="<%=request.getContextPath()%>/front-end/medicalOrder/ScanDoctor.jsp" class="btn btn-primary px-4 py-3">立即預約</a></p>
            </div>
          </div>
        </div>
      </div>

      <div class="slider-item" style="background-image: url('<%=request.getContextPath() %>/front-end/member/images/bg_2.jpg');">
        <div class="overlay"></div>
        <div class="container">
          <div class="row slider-text align-items-center" data-scrollax-parent="true">
            <div class="col-md-6 col-sm-12 ftco-animate" data-scrollax=" properties: { translateY: '70%' }">
              <h1 class="mb-4" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">專業的醫療服務</h1>
              <p class="mb-4">為家中不方便的患者所提供的線上諮詢，您一定不能錯過!!</p>
              <p><a href="<%=request.getContextPath()%>/front-end/medicalOrder/ScanDoctor.jsp" class="btn btn-primary px-4 py-3">線上預約</a></p>
            </div>
          </div>
        </div>
      </div>
    </section>

<%
    ActivityService activitySvc = new ActivityService();
    List<ActivityVO> actlist = activitySvc.getAll();
    pageContext.setAttribute("actlist",actlist);
%>


<section class="ftco-section" id="menuTarget">
	<div class="container">
    	<div class="row justify-content-center mb-5 pb-3">
        	<div class="col-md-7 text-center heading-section ftco-animate">
            	<h2 class="mb-2">活動專區</h2>
            	<p>歡迎在本站參與活動，與其他會員一起創造美好的記憶八!!</p>
         	</div>
       	</div>
        	<div class="row owl-carousel owl-theme" id="carousel-id">
          		<c:forEach var="actVO" items="${actlist}" begin="0" end="2">
          			<div class="col-md-4 ftco-animate item">
            			<div class="article" style="border:5px #FFAC55 solid;">
              				<a href="<%=request.getContextPath()%>/activity/activity.do?action=Show__join_act&actNo=${actVO.actNo}" class="block-20" 
              				style="background-image: url('<%=request.getContextPath()%>/activity/activityPic.do?actNo=${actVO.actNo}');">
             				</a>
					            <div class="text d-flex py-4">
									<div class="desc pl-3">
						            	<h3 class="heading">${actVO.actName}</h3>
						                <div>${actVO.actDesc}</div>
									</div>
	        					</div>
              			</div>
            		</div>
          		</c:forEach>
          	</div>
       	<input type="button" class="btn btn-primary" value="查看更多" onclick="location.href='<%=request.getContextPath() %>/front-end/activity/joinactivity.jsp'"></input>
	</div>
</section>

 


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
      				<div class="img mb-4" style="background-image: url(<%=request.getContextPath()%>/doctor/doctorImg.do?drno=${doctorSvc.getOneDoctor("D0001").drno});"></div>
      				<div class="info text-center">
      					<h3>${memberSvc.getOneMember(doctorSvc.getOneDoctor("D0001").memno).memName}</h3>
      					<span class="position">${doctorSvc.getOneDoctor("D0001").major}</span>
      					<div class="text">
	        				<ul class="ftco-social">
			              <li class="ftco-animate"><button type="button" class="btn btn-primary"><a href="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do?action=findDr&&drno=D0001">前往</button></a></li>
			            </ul>
	        			</div>
      				</div>
        		</div>
        	</div>
        	<div class="col-lg-3 col-md-6 d-flex mb-sm-4 ftco-animate">
        		<div class="staff">
      				<div class="img mb-4" style="background-image: url(<%=request.getContextPath()%>/doctor/doctorImg.do?drno=${doctorSvc.getOneDoctor("D0002").drno});"></div>
      				<div class="info text-center">
      					<h3>${memberSvc.getOneMember(doctorSvc.getOneDoctor("D0002").memno).memName}</h3>
      					<span class="position">${doctorSvc.getOneDoctor("D0002").major}</span>
      					<div class="text">
	        				<ul class="ftco-social">
			              <li class="ftco-animate"><button type="button" class="btn btn-primary"><a href="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do?action=findDr&&drno=D0002">前往</button></a></li>
			            </ul>
	        			</div>
      				</div>
        		</div>
        	</div>
        	<div class="col-lg-3 col-md-6 d-flex mb-sm-4 ftco-animate">
        		<div class="staff">
      				<div class="img mb-4" style="background-image: url(<%=request.getContextPath()%>/doctor/doctorImg.do?drno=${doctorSvc.getOneDoctor("D0003").drno});"></div>
      				<div class="info text-center">
      					<h3>${memberSvc.getOneMember(doctorSvc.getOneDoctor("D0003").memno).memName}</h3>
      					<span class="position">${doctorSvc.getOneDoctor("D0003").major}</span>
      					<div class="text">
	        				<ul class="ftco-social">
			              <li class="ftco-animate"><button type="button" class="btn btn-primary"><a href="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do?action=findDr&&drno=D0003">前往</button></a></li>
			            </ul>
	        			</div>
      				</div>
        		</div>
        	</div>
        	<div class="col-lg-3 col-md-6 d-flex mb-sm-4 ftco-animate">
        		<div class="staff">
      				<div class="img mb-4" style="background-image: url(<%=request.getContextPath()%>/doctor/doctorImg.do?drno=${doctorSvc.getOneDoctor("D0004").drno});"></div>
      				<div class="info text-center">
      					<h3>${memberSvc.getOneMember(doctorSvc.getOneDoctor("D0004").memno).memName}</h3>
      					<span class="position">${doctorSvc.getOneDoctor("D0003").major}</span>
      					<div class="text">
	        				<ul class="ftco-social">
			              <li class="ftco-animate"><button type="button" class="btn btn-primary"><a href="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do?action=findDr&&drno=D0004">前往</button></a></li>
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

<%
    MemberChefService chefSvc = new MemberChefService();
    List<MemberChefVO> list = chefSvc.getAll();
    pageContext.setAttribute("list",list);
%>

    <section class="ftco-section" id="menuTarget">
      <div class="container">
        <div class="row justify-content-center mb-5 pb-3">
          <div class="col-md-7 text-center heading-section ftco-animate">
            <h2 class="mb-2">送餐專區</h2>
            <p>A small river named Duden flows by their place and supplies it with the necessary regelialia.</p>
          </div>
        </div>
        <div class="row owl-carousel owl-theme" id="carousel-id">
          <c:forEach var="chefVO" items="${list}" begin="0" end="2">
          <div class="col-md-4 ftco-animate item">
            <div class="blog-entry">
              <a href="<%=request.getContextPath()%>/shoppingCart.do?action=getMenu_by_chefRep&chefRep=${chefVO.chefRep}" class="block-20" 
              		style="background-image: url('<%=request.getContextPath()%>/front-end/memberchef/memberchefImg.do?chefNo=${chefVO.chefNo}');">
              
              </a>
              <div class="text d-flex py-4">

                <div class="desc pl-3">
	                <h3 class="heading">${chefVO.chefStoreName}</h3>
	                <div>${chefVO.chefDescrip}</div>
	                <div class="container">
						<div class="row">
							<div class="col-xs-12 col-sm-4" style="margin-top: 10px; padding-right: 0px;">廚師：</div>
							<div class="col-xs-12 col-sm-8" style="padding-left: 0px; padding-right: 0px;"><h4>${chefVO.chefName}</h4></div>
						</div>
					</div>
	              </div>
              </div>
            </div>
          </div>
          </c:forEach>
        </div>
       	<input type="button" class="btn btn-primary" value="查看更多" onclick="location.href='<%=request.getContextPath() %>/front-end/memberchef/listAllChef.jsp'"></input>
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
          <form action="<%=request.getContextPath()%>/front-end/member/member.do" method="post">
            <div class="form-group">
              <!-- <label for="appointment_name" class="text-black">Full Name</label> -->
              <input type="text" class="form-control" id="sign_account" placeholder="使用者名稱(必填)" NAME="memid">
            </div>
            <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="password" class="form-control" id="sign_password" placeholder="密碼(必填)" NAME="mempsw">
            </div>
            <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="text" class="form-control" id="sign_name" placeholder="姓名(必填)" NAME="memname">
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
              <input type="text" class="form-control" id="sign_email" placeholder="E-mail(必填)" NAME="email">
            </div>
            
            <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="text" class="form-control" id="sign_phone" placeholder="電話(必填)" NAME="phone">
            </div>
           
<!--            <div class="form-group"> -->
<!--               <label for="appointment_email" class="text-black">Email</label> -->
<!--               <input type="text" class="form-control" id="sign_locno" placeholder="郵遞區號" NAME="locno"> -->
<!--             </div> -->
           
           <div class="form-group">
            <div id="twzipcode">
		     <div class="form-control" data-role="county" data-style="Style Name"></div>
		     <div class="form-control" data-role="district" data-style="Style Name"></div>
		     <div class="form-control" data-role="zipcode" data-style="Style Name"></div>
		    </div>
           </div>
           <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
             
              <input type="text" class="form-control" id="sign_address" placeholder="地址(必填)" NAME="addr">
            </div>
           
           <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="text" class="form-control" id="sign_medhistory" placeholder="過去病史(必填)" NAME="medhistory">
            </div>
           
           <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="text" class="form-control" id="sign_famhistory" placeholder="家族病史(必填)" NAME="famhistory">
            </div>
           
           <div class="form-group">
              <!-- <label for="appointment_email" class="text-black">Email</label> -->
              <input type="text" class="form-control" id="sign_allergy" placeholder="過敏記錄(必填)" NAME="allergy">
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
  
  <%@include file="member/includedfiles/js.file" %>
   

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

<style>
.city, .town{width: 100%;}
.f1{float:left;margin-left:5px;margin-right:5px;width:calc(5% - 10px)}
.f2{float:left;margin-left:5px;margin-right:5px;width:calc(10% - 10px)}
.f3{float:left;margin-left:5px;margin-right:5px;width:calc(15% - 10px)}
.f4{float:left;margin-left:5px;margin-right:5px;width:calc(20% - 10px)}
.f5{float:left;margin-left:5px;margin-right:5px;width:calc(25% - 10px)}
.f6{float:left;margin-left:5px;margin-right:5px;width:calc(30% - 10px)}
.f7{float:left;margin-left:5px;margin-right:5px;width:calc(35% - 10px)}
.f8{float:left;margin-left:5px;margin-right:5px;width:calc(40% - 10px)}
.f9{float:left;margin-left:5px;margin-right:5px;width:calc(45% - 10px)}
.f10{float:left;margin-left:5px;margin-right:5px;width:calc(50% - 10px)}
.f11{float:left;margin-left:5px;margin-right:5px;width:calc(55% - 10px)}
.f12{float:left;margin-left:5px;margin-right:5px;width:calc(60% - 10px)}
.f13{float:left;margin-left:5px;margin-right:5px;width:calc(65% - 10px)}
.f14{float:left;margin-left:5px;margin-right:5px;width:calc(70% - 10px)}
.f15{float:left;margin-left:5px;margin-right:5px;width:calc(75% - 10px)}
.f16{float:left;margin-left:5px;margin-right:5px;width:calc(80% - 10px)}
.f17{float:left;margin-left:5px;margin-right:5px;width:calc(85% - 10px)}
.f18{float:left;margin-left:5px;margin-right:5px;width:calc(90% - 10px)}
.f19{float:left;margin-left:5px;margin-right:5px;width:calc(95% - 10px)}
.f20{float:left;margin-left:5px;margin-right:5px;width:calc(100% - 10px)}
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
<script type="text/javascript">
  function faillogin(){ 
  	$("#mylogin").trigger("click");
  };
  
  function signup(){ 
	$("#loghide").trigger("click");
  };
  
  function failsignup(){ 
	  $("#signup2").trigger("click");
  };
</script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>	 -->
<!-- <script src="/front-end/member/js/jquery.twzipcode-1.4.1.js"></script> -->
<!-- <script src="/front-end/member/js/jquery.twzipcode.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.15-rc1/jquery.twzipcode.js"></script>	
<script>$('#twzipcode').twzipcode();</script>

<script>
$("#zipcode3").twzipcode({
"zipcodeIntoDistrict": true,
"css": ["city form-control", "town form-control"],
"countyName": "city", // 指定城市 select name
"districtName": "town" // 指定地區 select name
});
</script>

<script src="<%=request.getContextPath()%>/front-end/memberchef/js/jquery-3.3.1.min.js"></script>
<script src="<%=request.getContextPath()%>/front-end/memberchef/js/owl.carousel.min.js"></script>
  
<script type="text/javascript">
  $(document).ready(function(){
    $('.owl-carousel2').owlCarousel({
        loop:true,
        margin:10,
        nav:true,
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
</body>

  <!-- 以上為可動部分 -->
<%@include file="member/includedfiles/footer.file" %>
</html>