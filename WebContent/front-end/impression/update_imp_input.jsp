<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.impression.model.*"%>

<%
ImpressionVO impressionVO = (ImpressionVO) request.getAttribute("impressionVO"); //impressionServlet.java (Concroller) �s�Jreq��impressionVO���� (�]�A�������X��impressionVO, �]�]�A��J��ƿ��~�ɪ�impressionVO����)
%>

<html>
<head>
 <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+TC">
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

<title>�߱o��ƭק� </title>
</head>
<body>
	<header>
		<span>&nbsp;</span><br>
		<span>&nbsp;</span>
			<h3 class="title"><span><b>�߱o��ƭק� </b></span></h3>
			<h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><batton class="btn btn-Success" style="margin-right:20px;">�^����</batton></a></h4>
	</header>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="impression.do" name="form1" enctype="multipart/form-data">
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-12 col-sm-6">
				<div class="form-column">
    				<div class="row">
    					<div class="form-group col-md-12">
      						<label for="inputEmail4">�߱o�D��:</label>
      						<input type="text" class="form-control" name="impName" value="${impressionVO.impName}"/>
    					</div>
						<div class="form-group col-md-12">
      						<label for="inputEmail4">�߱o�s��:</label>
      						<input type="text" class="form-control" name="impNo" value="${impressionVO.impNo}" readonly/>
    					</div>
						<div class="form-group col-md-12">
      						<label for="inputEmail4">�߱o�ɶ�:</label>
      						<input type="text" class="form-control" name="impTime" value="${impressionVO.impTime}" readonly/>
    					</div>
    					<div class="form-group col-md-12">
      						<label for="inputEmail4">���ʽs��:</label>
      						<input type="text" class="form-control" name="actNo" value="${impressionVO.actNo}" readonly/>
    					</div>
    					<div class="form-group col-md-12">
      						<label for="inputEmail4">�|���s��:</label>
      						<input type="text" class="form-control" name="memNo" value="${impressionVO.memNo}" readonly/>
    					</div>
    					<div class="form-group col-md-12">
      						<label for="inputEmail4">�߱o���e:</label>
      						<textarea name="impCon" class="form-control" rows="8" cols="50" ><%= (impressionVO==null)? "�߱o" : impressionVO.getImpCon()%></textarea>
    					</div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-6">
				<div class="form-column">
    				<div class="row">
      					<div class="form-group col-md-12">
        					<label for="inputZip">�Ϥ��ɮ�:</label>
      					</div>
    				</div>
    					<div class="col-xs-12 col-sm-12">
      						<c:choose>
								<c:when test="${(impressionVO.recPic)!=null}">
									<td>
										<img src="<%= request.getContextPath()%>/impression/impressionPic.do?impNo=${impressionVO.impNo}" id="output2" height=50% width=50%/>
										<input type="file" name="recPic" size="45" onchange="loadFile(event)"/>
									</td>
								</c:when>
								<c:otherwise>
									<td>
										<img src="<%= request.getContextPath()%>/front-end/impression/img/nopic.jpg" id="output2" height=50%>
										<input type="file" name="recPic" size="45" onchange="loadFile(event)"/>
									</td>
								</c:otherwise>
							</c:choose>
    					</div>
  				</div>
  				<div class="form-column">
    				<div class="row">
      					<div class="form-group col-md-12">
        					<label for="inputZip">�v���ɮ�:</label>
      					</div>
    				</div>
    					<div class="col-xs-12 col-sm-12">
      						<c:choose>
								<c:when test="${(impressionVO.recVideo)!=null}">
									<div>
										<video width="400" controls>
											<source src="<%= request.getContextPath()%>/impression/impressionVideo.do?impNo=${impressionVO.impNo}" id="video_here">
										</video>
											<input type="file" name="recVideo" size="45" class="file_multi_video" accept="video/*">
									</div>
								</c:when>
								<c:otherwise >
									<td>
										<video width="400" controls poster="<% request.getContextPath();%>img/novideojpg.jpg">
											<source src="<%= request.getContextPath() %>/impression/impressionVideo.do?impNo=${impressionVO.impNo} " id="video_here">
										</video>
											<input type="file" name="recVideo" class="file_multi_video" accept="video/*">
									</td>
								</c:otherwise>
							</c:choose>
    					</div>
  				</div>
  				<div class="form-row">
    				<div class="form-group col-md-10">
    				</div>
    				<div class="form-group col-md-2">
      					<div class="row">
      						<input type="hidden" name="action" value="update">
							<input type="hidden" name="impNo" value="${impressionVO.impNo}">
							<input type="hidden" name="impField" value="${impressionVO.impField}">
							<input type="submit" value="�e�X�ק�"class="btn btn-success">
    					</div>
    				</div>
  				</div>
			</div>
		</div>
	</div>
</FORM>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script>
	$(document).on("change", ".file_multi_video", function(evt) {
		  var $source = $('#video_here');
		  $source[0].src = URL.createObjectURL(this.files[0]);
		  $source.parent()[0].load();
		});
</script>
<script>
  var loadFile = function(event) {
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