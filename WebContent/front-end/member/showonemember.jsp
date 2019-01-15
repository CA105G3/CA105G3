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
    <%@include file="includedfiles/css.file" %>
  	
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
	<%@include file="includedfiles/nav.file" %>
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
		   	<form action="member.do" method="post">
			<table>
<!-- 			<tr> -->
<%-- 				<th><p>會員編號</p></th><td><%=memVO.getMemNo()%></td> --%>
<!-- 			</tr> -->
			<tr>
				<th><p>會員照片</p></th>
				<td>
				<img src=<%=(memVO.getMemPic()==null)?request.getContextPath()+"/front-end/images/person_1.jpg": request.getContextPath()+"/front-end/member/membergetpic.do?memno="+memVO.getMemNo()%> width="180" height="160">
				</td>
			</tr>
			<tr>
				<th><p>會員編號</p></th><td>${memVO.memNo}</td>
			</tr>
<!-- 			<tr> -->
<%-- 				<th><p>會員帳號</p></th><td><%=memVO.getMemId()%></td> --%>
<!-- 			</tr> -->
			<tr>
				<th><p>會員帳號</p></th><td>${memVO.memId}</td>
			</tr>
			<tr>
				<th><p>會員姓名</p></th><td><%=memVO.getMemName()%></td>
			</tr>
			<tr>
				<th><p>性別</p></th><td><%=memVO.getGender()%></td>
			</tr>
			<tr>
				<th><p>生日</p></th><td><%=memVO.getBirth()%></td>
			</tr>
			<tr>
				<th><p>血型</p></th><td><%=memVO.getBloodType()%></td>
			</tr>
			<tr>
				<th><p>E-mail</p></th><td><%=memVO.getEmail()%></td>
			</tr>
			<tr>
				<th><p>電話</p></th><td><%=memVO.getPhone()%></td>
			</tr>
			<tr>
				<th><p>郵遞編號</p></th><td><%=memVO.getLocNo()%></td>
			</tr>
			<tr>
				<th><p>地址</p></th><td><%=memVO.getAddr()%></td>
			</tr>
			<tr>
				<th><p>會員狀態</p></th><td><%=memVO.getMemStatus()%></td>
			</tr>
			<tr>
				<th><p>過往病史</p></th><td><%=memVO.getMedHistory()%></td>
			</tr>
			<tr>
				<th><p>家族病史</p></th><td><%=memVO.getFamHistory()%></td>
			</tr>
			<tr>
				<th><p>過敏記錄</p></th><td><%=memVO.getAllergy()%></td>
			</tr>
			<tr>
				<th><p>是否抽菸</p></th><td><%=memVO.getSmoking()%></td>
			</tr>
			<tr>
				<th><p>註冊日期</p></th><td><%=memVO.getRegDate()%></td>
			</tr>
			<tr>
				<th><p>會員身分</p></th><td><%=memVO.getIdent()%></td>
			</tr>
			<tr>
				<th><p>最後登入時間</p></th><td><%=memVO.getStayTime()%></td>
			</tr>
			<tr>
			<td><input type="hidden" name="action" value="getOne_For_Update"></td>
			<td><input type="hidden" name="memno" value=<%=memVO.getMemNo()%>></td>
			<td><button type="submit" class="btn btn-primary">修改</button></td>
			</tr>
			</table>
			</form>
			</div>
		  </div>
		</div>
	</section>
  <%@include file="includedfiles/js.file" %>	
  <!-- 以上為可動部分 -->
<%@include file="includedfiles/footer.file" %>
</html>