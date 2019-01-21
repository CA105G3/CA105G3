<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.activity.model.*"%>
<%@ page import="com.joinact.model.*"%>
<%@ page import="com.member.model.*"%>
<%
	String memNo = (String)session.getAttribute("memno");
	MemberService memberSvc = new MemberService();
	MemberVO memberVO = memberSvc.getOneMember(memNo);
	pageContext.setAttribute("memberVO", memberVO);
%>

<!DOCTYPE html>
<html>
<head>
<title>Chat Room</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front-end/activity/css/chat_room.css"
	type="text/css" />
<style>
body {
  background-image:url(<%=request.getContextPath()%>/front-end/activity/img/oldbuild.gif);
  font-family: "Calibri", "Roboto", sans-serif;
}
#headView{
    height: 60px;
    width: 	60px;
    border-radius: 50%;
    overflow：hidden;
}
</style>	
</head>

<body onload="connect();" onunload="disconnect();">

	<div class="chat_window">
		<div class="top_menu">
			<div class="title">${activityVO.actName}的聊天室</div>
		</div>
			<div>
				<c:forEach var="joinactpic" items="${listchat}">
						<img id="headView" src="<%= request.getContextPath()%>/front-end/member/membergetpic.do?memno=${joinactpic.memNo}"/>
				</c:forEach>
			</div>
		<div style="width:800px;height:1px; background:#000000;"></div>
		<ul class="messages" id="messagesArea">
		</ul>
		<div class="bottom_wrapper clearfix">
			<div class="message_input_wrapper">
				<input id="userName" class="text-field" type="hidden" value="${memberVO.memName}" readonly/>
				<input class="message_input" id="message"  placeholder="訊息" onkeydown="if (event.keyCode == 13) sendMessage();"/>
			</div>
			<div class="send_message">
				<div class="icon"></div>
				<div class="text" value="送出" type="submit" id="sendMessage" onclick="sendMessage();">Send</div>
			</div>
		</div>
	</div>
	<div style="flex; justify-content: flex-end;"><a href="<%= request.getContextPath()%>/front-end/activity/personact.jsp">
                    	<button class="btn btn-info">離開聊天室</button>
                	</a></div>
	
</body>

<script>
	var MyPoint = "/MyEchoServer2/${memberVO.memName}/309";
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;

	var statusOutput = document.getElementById("statusOutput");
	var webSocket;

	function connect() {
		// 建立 websocket 物件
		webSocket = new WebSocket(endPointURL);

		webSocket.onopen = function(event) {
			updateStatus("WebSocket 成功連線");
			document.getElementById('sendMessage').disabled = false;
// 			document.getElementById('connect').disabled = true;
// 			document.getElementById('disconnect').disabled = false;
		};

		webSocket.onmessage = function(event) {
			var messagesArea = document.getElementById("messagesArea");
			var jsonObj = JSON.parse(event.data);
			console.log(jsonObj.userName);
			var name = jsonObj.userName;
			var message = jsonObj.userName + ": " + jsonObj.message + "\r\n";
			if(jsonObj.userName==='${memberVO.memName}'){
				$('#messagesArea').append("<div style='display: flex; justify-content: flex-start'>"+
"<img id='headView' src='<%= request.getContextPath()%>/front-end/member/membergetpic.do?memno=${joinactpic.memNo}'/>"+message+"<div>");
				messagesArea.value = messagesArea.value + message;
				messagesArea.scrollTop = messagesArea.scrollHeight;
			}else{
				$('#messagesArea').append("<div style='display: flex; justify-content: flex-end'>"+message+"<div>");
				messagesArea.value = messagesArea.value + message;
				messagesArea.scrollTop = messagesArea.scrollHeight;	
			}
		};

		webSocket.onclose = function(event) {
			updateStatus("WebSocket 已離線");
		};
	}

	var inputUserName = document.getElementById("userName");
	inputUserName.focus();

	function sendMessage() {
		var userName = inputUserName.value.trim();
		if (userName === "") {
			alert("使用者名稱請勿空白!");
			inputUserName.focus();
			return;
		}

		var inputMessage = document.getElementById("message");
		var message = inputMessage.value.trim();
		
		if (message === "") {
			alert("訊息請勿空白!");
			inputMessage.focus();
		} else {
			var jsonObj = {
				"userName" : userName,
				"message" : message
			};
			webSocket.send(JSON.stringify(jsonObj));
			inputMessage.value = "";
			inputMessage.focus();
		}
	}

	function disconnect() {
		webSocket.close();
		document.getElementById('sendMessage').disabled = true;
// 		document.getElementById('connect').disabled = false;
// 		document.getElementById('disconnect').disabled = true;
	}

	function updateStatus(newStatus) {
// 		statusOutput.innerHTML = newStatus;
	}
</script>
</html>
