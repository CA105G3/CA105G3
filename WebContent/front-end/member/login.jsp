<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.member.model.*"%>
<%
	MemberVO memVO = (MemberVO)session.getAttribute("memVO");
%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>線上醫療網</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
	</head>
	<body>
		<header>
		<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
						<span class="sr-only">選單切換</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">CSS可樂</a>
				</div>
				
				<!-- 手機隱藏選單區 -->
				<div class="collapse navbar-collapse navbar-ex1-collapse">
					<!-- 左選單 -->
					<ul class="nav navbar-nav">
						<li class="active"><a href="#">關於CSS可樂</a></li>
						<li><a href="#">CSS教學</a></li>
						<li><a href="#">CSS範例</a></li>
						<li><a href="#">原創CSS</a></li>
					</ul>
				
					<!-- 搜尋表單 -->
					<form class="navbar-form navbar-right" role="search">
						<div class="form-group">
							<input type="text" class="form-control" placeholder="請輸入關鍵字">
						</div>
						<button type="submit" class="btn btn-default">搜尋</button>
					</form>
				
					<!-- 右選單 -->
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#">${(memVO==null)?'訪客': memVO.memName} 您好!</a></li>
						<li><a href="${(memVO==null)?'login.jsp':'member.do?action=logout'}">${(memVO==null)?'登入':'登出'}</a></li>
						<li><a href="#">個人設定</a></li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">繁體中文 <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="#">繁體中文</a></li>
								<li><a href="#">English</a></li>
								<li><a href="#">日本語</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<!-- 手機隱藏選單區結束 -->
			</div>
		</nav>
		</header>
		<br>
		<br>
		<br>
		<br>
		<div class="container">
			<div class="row">
				<FORM METHOD="post" ACTION="member.do">
    			<table>
    				<tr>
    					<td>帳號</td>
    					<td><INPUT TYPE="TEXT" NAME="account" placeholder="帳號"></td>
    				</tr>
    				<tr>
    					<td>密碼</td>
    					<td><INPUT TYPE="password" NAME="password" placeholder="密碼"></td>
    				</tr>
    				<tr>
    					<td><INPUT TYPE="SUBMIT" value="送出"></td>
    					<td><input type="reset" value="清除"></td>
    				</tr>
    			</table>
    			<input type="hidden" name="action" value="authorization">
    			</FORM>
    			
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

		
		
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>