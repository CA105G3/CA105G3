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
				<c:if test="${not empty errorMsgs}">
					<font style="color:red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color:red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>
				<FORM id="myform" METHOD="post" ACTION="member.do" name="form1" enctype='multipart/form-data'>
				<table>
					<tr>
						<th><p>會員照片</p></th>
						<td>
						<img src=<%=(memVO.getMemPic()==null)?request.getContextPath()+"/front-end/images/deafult_pic.jpg": request.getContextPath()+"/front-end/member/membergetpic.do?memno="+memVO.getMemNo()%> id="myPic" width="180" height="160">
						</td>
					</tr>
					<tr>
						<th><p>上傳照片</p></th>
						<td><input type="file" class="form-control" name="memPic" onchange="loadFile(event)"/></td>
					</tr>
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
						<td><p>過往病史:</p></td>
						<td><input name="medhistory" type="text" value="<%=(memVO.getMedHistory()==null)?"無":memVO.getMedHistory()%>"></td>
					</tr>
					<tr>
						<td><p>家族病史:</p></td>
						<td><input name="famhistory" type="text" value="<%=(memVO.getFamHistory()==null)?"無":memVO.getFamHistory()%>"></td>
					</tr> 
					<tr>
						<td><p>過敏記錄:</p></td>
						<td><input name="allergy" type="text" value="<%=(memVO.getAllergy()==null)?"無":memVO.getAllergy()%>"></td>
					</tr>
					<tr>
						<td><p>是否抽菸:</p></td>
						<td><select name="smoking">
							<option value="有" ${(memVO.smoking=='有')?'selected':''}>有</option>
							<option value="沒有" ${(memVO.smoking=='沒有')?'selected':''}>沒有</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><p>會員狀態:</p></td>
						<td><input name="memstatus" readonly value="<%=memVO.getMemStatus()%>"></td>
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
	
  <%@include file="includedfiles/js.file" %>
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
<script>
  var loadFile = function(event) {
    var reader = new FileReader();
    reader.onload = function(){
      var output = document.getElementById('myPic');
      output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
  };
</script>  
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">

$(window).load(function () {
    var submit = false;
    $("#myform").submit(function(e) {
    	e.preventDefault();
    	swal("確定修改資料!")
    	.then(() =>{
    		submit = true;
    		$("#myform").unbind("submit").submit();
    	});
    });
});
</script>
     
  <!-- 以上為可動部分 -->
  <%@include file="includedfiles/footer.file" %>
</html>