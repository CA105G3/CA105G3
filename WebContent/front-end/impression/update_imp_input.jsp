<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.impression.model.*"%>

<%
ImpressionVO impressionVO = (ImpressionVO) request.getAttribute("impressionVO"); //impressionServlet.java (Concroller) 存入req的impressionVO物件 (包括幫忙取出的impressionVO, 也包括輸入資料錯誤時的impressionVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>員工資料修改 - update_imp_input.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>心得資料修改 - update_imp_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="<%=request.getContextPath()%>/front-end/impression/img/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="impression.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>活動編號:</td>
		<td>${impressionVO.impNo}</td>
	</tr>
	<tr>
		<td>心得時間:</td>
		<td><input type="TEXT" name="impTime" size="45" 
			 value="${impressionVO.impTime}" readonly="true"/></td>
	</tr>
	<tr>
		<td>活動編號:</td>
		<td><input type="TEXT" name="actNo" size="45" 
			 value="${impressionVO.actNo}" readonly="true"/></td>
	</tr>
	<tr>
		<td>會員編號:</td>
		<td><input type="TEXT" name="memNo" size="45"
			 value="<%= (impressionVO==null)? "M0001" : impressionVO.getMemNo()%>" readonly="true"/></td>
	</tr>
	<tr>
		<td>心得主旨:</td>
		<td><input type="TEXT" name="impName" size="45" 
			 value="${impressionVO.impName}"/></td>
	</tr>
	<tr>
		<td>心得內容:</td>
		<td><input type="TEXT" name="impCon" size="45"
			 value="<%= (impressionVO==null)? "心得" : impressionVO.getImpCon()%>" /></td>
	</tr>
	<tr>
		<td>影片檔案:</td>
		<c:choose>
			<c:when test="${(impressionVO.recVideo)!=null}">
				<td>
					<video width="400" controls>
					<source src="<%= request.getContextPath()%>/impression/impressionVideo.do?impNo=${impressionVO.impNo}" id="video_here">
					</video>
					<input type="file" name="recVideo" size="45" class="file_multi_video" accept="video/*">
				</td>
			</c:when>
			<c:otherwise >
				<td>
					<video width="400" controls>
						<source src="<%= request.getContextPath() %>/impression/impressionVideo.do?impNo=${impressionVO.impNo} " id="video_here">
					</video>
						<input type="file" name="recVideo" size="45" class="file_multi_video" accept="video/*">
				</td>
			</c:otherwise>
		</c:choose>
		
	</tr>
	<tr>
		<td>照片檔案:</td>
		<c:choose>
			<c:when test="${(impressionVO.recPic)!=null}">
				<td>
					<img src="<%= request.getContextPath()%>/impression/impressionPic.do?impNo=${impressionVO.impNo}" id="output2" height=50% weight=50%/>
					<input type="file" name="recPic" size="45" onchange="loadFile(event)"/>
				</td>
			</c:when>
			<c:otherwise >
				<td>
					<img src="<%= request.getContextPath()%>/front-end/impression/img/nopic.jpg" id="output2" width=50% height=50%>
					<input type="file" name="recPic" size="45" onchange="loadFile(event)"/>
				</td>
			</c:otherwise>
		</c:choose>
	</tr>
	<tr>
		<td>分類標籤:</td>
		<td>
		<select name="impField">
		<option value="文字心得" ${('文字心得'==impressionVO.impField)? 'selected':'' } >文字心得</option>
		<option value="影片" ${('影片'==impressionVO.impField)? 'selected':'' }>影片</option>
		<option value="照片" ${('照片'==impressionVO.impField)? 'selected':'' }>照片</option>
		</select>
		</td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="impNo" value="<%= impressionVO.getImpNo()%>">
<input type="submit" value="送出修改"></FORM>
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