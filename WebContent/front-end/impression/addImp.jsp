<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.impression.model.*"%>

<%
	String memNo = "M0001";
	pageContext.setAttribute("memNo", memNo);
	ImpressionVO impressionVO = (ImpressionVO) request.getAttribute("impressionVO");
%>


<html>
<head>

	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<title>���u��Ʒs�W - addImp.jsp</title>

		<style>
		  table#table-1 {
			width:container-fluid;
			background-color: #CCCCFF;
		    border: 2px solid black;
		    text-align: center;
		    table-layout:fixed;
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
			width:container-fluid;
			table-layout:fixed;
			word-break:break-all;
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
			 <h3>�߱o��Ʒs�W - addImp.jsp</h3></td><td>
			 <h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="img/lu.jpg" width="100" height="100" border="0">�^����</a></h4>
		</td></tr>
	</table>

	<h3>��Ʒs�W:</h3>

<%-- ���~��C --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color:red">�Эץ��H�U���~:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color:red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/impression/impression.do" name="form1" enctype="multipart/form-data">

<table>
	<tr>
		<td>���ʽs��:</td>
		<td><input type="TEXT" name="actNo" size="45" value="<%= (impressionVO==null)? "ACT0001" : impressionVO.getActNo()%>" /></td>
	</tr>
	<tr>
		<td>�߱o�D��:</td>
		<td><input type="TEXT" name="impName" size="45" value="<%= (impressionVO==null)? "" : impressionVO.getImpName()%>" /></td>
	</tr>
	<tr>
		<td>�|���s��:</td>
		<td><input type="TEXT" name="memNo" size="45"value="${memNo}" readonly="true"/></td>
	</tr>
	<tr>
		<td>�߱o���e:</td>
		<td><input type="TEXT" name="impCon" size="45"
			 value="<%= (impressionVO==null)? "�߱o" : impressionVO.getImpCon()%>" />
		</td>
		
	</tr>
	<tr>
		<td>�v���ɮ�:</td>
		<td>
			<video width="400" controls>
				<source src="<%= request.getContextPath() %>/impression/impressionVideo.do?impNo=${impressionVO.impNo} " id="video_here">
			</video>
				<input type="file" name="recVideo" size="45" class="file_multi_video" accept="video/*">
		</td>
		
	</tr>
	<tr>
		<td>�Ӥ��ɮ�:</td>
			<td>
				<img src="<% request.getContextPath();%>img/nopic.jpg" id="output2" width=50% height=40%/>
				<input type="file" name="recPic" size="45" onchange="loadFile2(event)"/>
			</td>
	</tr>
	<tr>
		<td>
		</td>
	</tr>
	<tr>
		<td>��������:</td>
		<td>
		<select name="impField">
		<option value="��r�߱o" ${('��r�߱o'==impressionVO.impField)? 'selected':'' } >��r�߱o</option>
		<option value="�v��" ${('�v��'==impressionVO.impField)? 'selected':'' }>�v��</option>
		<option value="�Ӥ�" ${('�Ӥ�'==impressionVO.impField)? 'selected':'' }>�Ӥ�</option>
		</select>
		</td>
	</tr>


</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="�e�X�s�W"></FORM>
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