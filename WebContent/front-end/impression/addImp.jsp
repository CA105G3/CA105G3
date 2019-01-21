<%@page import="com.joinact.model.*"%>
<%@page import="java.util.List"%>
<%@page import="com.joinact.model.JoinActService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.impression.model.*"%>

<%
String memNo=(String)session.getAttribute("memno");
pageContext.setAttribute("memNo", memNo);
JoinActService joinactSvc = new JoinActService();
List<PersonActVO> listjoinact = joinactSvc.getoff(memNo);
pageContext.setAttribute("listjoinact", listjoinact);
ImpressionVO impressionVO = (ImpressionVO) request.getAttribute("impressionVO");
%>


<html>
<head>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.css" />
	<script src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.full.js"></script>
<style>
   h3.title{
 	text-align:center;
 	font-family:Microsoft JhengHei;
 	font-size:200%;
 }
  h4 {
    color: #FF0088;
    text-align:right;
  }

body {
  	background-image:url('<%=request.getContextPath()%>/front-end/activity/img/mountain.jpg');
	opacity:1;
	filter:alpha(opacity=80);
	background-repeat: no-repeat;
    background-attachment: fixed;
    background-position: center;
    background-size: cover;
    color:#B8860B;
    font-weight:bold;
  }
#map {
		height: 400px;  /* The height is 400 pixels */
		width: 100%;  /* The width is the width of the web page */
	}
</style>

</head>
<body>

	<header style="background-image:url('<%=request.getContextPath()%>/front-end/activity/img/act1.gif'); height:150px;background-repeat: no-repeat;
    background-attachment: fixed;background-position: center;background-size: cover;">
		<span>&nbsp;</span><br>
		<span>&nbsp;</span>
			<h3 class="title" style="color:black;"><span><b>建立心得</b></span></h3>
			<h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><batton class="btn btn-Success" style="margin-right:20px;">回首頁</batton></a></h4>
	</header>

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
<br>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/impression/impression.do" name="form1" enctype="multipart/form-data">
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-12 col-sm-6">
  				<div class="form-column">
    				<div class="row">
    					<div class="form-group col-md-12">
      						<label>活動編號:</label>
      							<select size="1" name="actNo" class="form-control">
         							<c:forEach var="list" items="${listjoinact}" >
								    	<option value="${list.actNo}"}>${list.actName}</option>
								    </c:forEach>   
								</select>
    					</div>
    					<div class="form-group col-md-12">
					    	<label for="inputPassword4">心得主旨:</label>
					    		<input type="TEXT" class="form-control" name="impName" value="<%= (impressionVO==null)? "" : impressionVO.getImpName()%>" />
					    </div>
					
					  	<div class="form-group col-md-12">
					    	<label for="inputAddress">會員編號:</label>
					  			<input type="TEXT" name="memNo" class="form-control" value="${memNo}" readonly="true"/>
					  	</div>					  
					  	<div class="form-group col-md-12">
					    	<label for="inputAddress2">分類標籤:</label>
					    		<select name="impField" class="form-control">
									<option value="文字心得" ${('文字心得'==impressionVO.impField)? 'selected':'' } >文字心得</option>
									<option value="影片" ${('影片'==impressionVO.impField)? 'selected':'' }>影片</option>
									<option value="照片" ${('照片'==impressionVO.impField)? 'selected':'' }>照片</option>
								</select>
					  	</div>
					    <div class="form-group col-md-12">
					      	<label for="inputCity">心得內容:</label>
					      		<textarea name="impCon" class="form-control" rows="8" cols="50" value="<%= (impressionVO==null)? "心得" : impressionVO.getImpCon()%>"></textarea>
					    </div>
					  </div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-6">		
				<div class="form-column">
					<div class="row">
						<div class="form-group col-md-12">
					    	<label for="inputZip">圖片檔案:</label>
					    </div>
					</div>
					    <div class="col-xs-12 col-sm-12">
					      	<img src="<% request.getContextPath();%>img/nopic.jpg" id="output2" width=50% height=40%/>
								<input type="file" name="recPic" onchange="loadFile2(event)" size="40"/>
					    </div>
				</div>					    
				<div class="form-column">
					<div class="row">
						<div class="form-group col-md-12">
					    	<label for="inputZip">影片檔案:</label>
					    </div>
					</div>
					    <div class="col-xs-12 col-sm-12">
					      	<video width="400" controls poster="<% request.getContextPath();%>img/novideojpg.jpg">
								<source src="<%= request.getContextPath() %>/impression/impressionVideo.do?impNo=${impressionVO.impNo} " id="video_here">
							</video>
								<input type="file" name="recVideo" class="file_multi_video" accept="video/*" class="form-control">
					    </div>
				</div>
					<div class="form-row">
						<div class="form-group col-md-10">
					  	</div>
					    <div class="form-group col-md-2">
					    	<div class="row">
					     		<input type="hidden" name="action" value="insert">
								<input type="submit" value="送出新增" class="btn btn-Success">
					    	</div>
					    </div>
					</div>
			</div>
		</div>
	</div>
</form>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script>
	$(document).on("change", ".file_multi_video", function(evt) {
		  var $source = $('#video_here');
		  $source[0].src = URL.createObjectURL(this.files[0]);
		  $source.parent()[0].load();
		});
</script>
<script>
  var loadFile2 = function(event) {
    var reader = new FileReader();
    reader.onload = function(){
      var output = document.getElementById("output2");
      output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
  };
</script>
</body>
</html>