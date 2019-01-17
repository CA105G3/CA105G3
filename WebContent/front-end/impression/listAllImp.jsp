<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.impression.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
	ImpressionService impressionSvc = new ImpressionService();
    List<ImpressionVO> list = impressionSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>�Ҧ����u��� - listAllImp.jsp</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+TC">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.css" />
	<script src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.full.js"></script>
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
  word-wrap{
   word-break: break-all;
  }
</style>

<style>
  table {
	width: container-fluid;
	background-color: white;
	margin-top: 10px;
	margin-bottom: 10px;
	
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th{
  	text-align: center;
  }
  th, td {
    padding: 5px;
  }
  img{
		 max-height:300px;
		 max-width: 300px; 
		 vertical-align:middle;
	 }
</style>
	
</head>

<body>
	<header style="background-image:url('<%=request.getContextPath()%>/front-end/activity/img/mountain.jpg'); height:150px;">
		<div>
		 	<h3 style="display:inline">�Ҧ��߱o-listallImp.jsp</h3>
			<h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="<%=request.getContextPath()%>/front-end/activity/img/back1.gif" width="100" height="32" border="0">�^����</a></h4>
		</div>
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

<table>
	<tr style="background-image: linear-gradient(120deg, #e0c3fc 0%, #8ec5fc 100%);">
		<th>�߱o�s��</th>
		<th>�߱o�ɶ�</th>
		<th>�߱o�W��</th>		
		<th>���ʽs��</th>
		<th>�|���s��</th>
		<th>��r�߱o���e</th>
		<th>�v������</th>
		<th>�Ӥ��O��</th>


	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="impressionVO" items="${list}" begin="<%= pageIndex %>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${impressionVO.impNo}</td>
			<td>${impressionVO.impTime}</td>
			<td>${impressionVO.impName}</td>			
			<td>${impressionVO.actNo}</td>
			<td>${impressionVO.memNo}</td>
			<td>${impressionVO.impCon}</td>
<!--�v�� -->
			<c:choose>
				<c:when test="${(impressionVO.recVideo)!=null}">
			<td>
				<video width="400" controls>
				<source src="<%= request.getContextPath() %>/impression/impressionVideo.do?impNo=${impressionVO.impNo} " type="video/mp4"/>
				</video>
			</td>
				</c:when>
				<c:otherwise >
			<td>
			<img src="<%=request.getContextPath()%>/front-end/impression/img/no-video.png">
			</td>
				</c:otherwise>
			</c:choose>
<!--�Ӥ� -->
			<c:choose>
				<c:when test="${(impressionVO.recPic)!=null}">
					<td>
						<img src="<%= request.getContextPath() %>/impression/impressionPic.do?impNo=${impressionVO.impNo} " height=50% />
					</td>
				</c:when>
				<c:otherwise >
					<td>
						<img src="<%=request.getContextPath()%>/front-end/impression/img/nopic.jpg">
					</td>
				</c:otherwise>
			</c:choose>		
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file"%>
<script type="text/javascript">
var v = document.querySelector('video'),
sources = v.querySelectorAll('source'),
lastsource = sources[sources.length-1];
lastsource.addEventListener('error', function(ev) {
var d = document.createElement('div');
d.innerHTML = v.innerHTML;
v.parentNode.replaceChild(d, v);
}, false);
</script>

</body>
</html>