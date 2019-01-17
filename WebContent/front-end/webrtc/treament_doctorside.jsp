<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ppttool.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.member.model.*" %>
<%@ page import="com.doctor.model.*" %>
<% MemberVO memVO=(MemberVO)session.getAttribute("memVO"); %>
<%String moNO=request.getParameter("moNO");%>
<% DoctorService docSvc = new DoctorService(); 
	DoctorVO docVO=docSvc.getDrno(memVO.getMemNo());
%>
<!DOCTYPE html>
<html>
    <head>
    	<meta http-equiv="X-UA-Compatible" content="IE=8"></meta>
        <title>SimpleWebRTC Demo</title>
        <%@include file="/front-end/member/includedfiles/css.file" %>
         <style>
            .videoContainer {
                position: relative;
                width: 200px;
                height: 150px;
            }
            .videoContainer_remotes {
                position: relative;
                width: 540px;
                height: 360px;
            }
            .videoContainer video {
                position: absolute;
                width: 100%;
                height: 100%;
            }
            .volume_bar {
                position: absolute;
                width: 5px;
                height: 0px;
                right: 0px;
                bottom: 0px;
                background-color: #12acef;
            }
            #remotes{
            	position: absolute;
            	top: 800px;
            	left: 100px;
            	width:640px;
            	height:360px;
            }
            #localVideo{
                position: absolute;
            	top: 1140px;
            	left: 100px;
            	width:150px;
            	height:160px;
            	z-index: 999;
            }
            #ppt{
            	position: absolute;
            	top: 800px;
            	left: 800px;
            	width:480px;
            	height:360px;
            }
            
        </style>
    </head>
    <body onload="connect();" onunload="disconnect();">
    <%@include file="/front-end/member/includedfiles/nav.file" %>
    
    <section class="home-slider owl-carousel">
      <div class="slider-item" style="background-image: url('<%=request.getContextPath() %>/front-end/member/images/bg_1.jpg');">
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

      <div class="slider-item" style="background-image: url('<%=request.getContextPath() %>/front-end/member/images/bg_2.jpg');">
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
        
        <br><br>
        <section>
    		<div class="container-fluid">
        		<video id="localVideo" oncontextmenu="return false;"></video>
        		<div id="localVolume" class="volume_bar"></div>
       			<div id="remotes"></div>
				<img src="<%=request.getContextPath()%>/ppt/pptImg.do?pptno=P0001" id="ppt">
  				<div class="row">
  					<div class="col-lg-8"></div>
  					<div class="col-lg-4">
  					<button type="button" class="btn btn-primary" onclick="back()">上一頁</button>
        			<button type="button" class="btn btn-primary" onclick="next()">下一頁</button>
  		 			<button type="button" class="btn btn-danger" data-toggle="modal" data-target='#modalRecord' id="stop">結束</button>
  					</div>
  				</div>
        	</div>
        </section>
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
   
		<!-- Modal -->
  <div class="modal fade" id="modalRecord" tabindex="-1" role="dialog" aria-labelledby="modalRecord" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="modalrecordLabel">醫囑紀錄</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true" id="loghide">&times;</span>
          </button>
        </div>
        <div class="modal-body">
<%--           <form action="<%=request.getContextPath() %>/front-end/medicalOrder/medicalOrderServlet.do" method="post"> --%>
<%--             <FORM action="<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do" method="post"> --%>
            <div class="form-group">
              <!-- <label for="appointment_name" class="text-black">Full Name</label> -->
             <textarea class="form-control" rows="7" id="medicalrecord" name="medicalrecord"></textarea>
            </div>
             <div class="form-group">
              <input type="hidden" name="moNo" value="<%=moNO%>">
              <input type="hidden" name="action" value="submitrecord">
<!--               <input type="submit" value="確定" class="btn btn-primary"> -->
              <button id="submit" class="btn btn-primary">送出</button>
              <input type="reset" value="清除" class="btn btn-primary">
            </div>
<!--           </FORM> -->
        </div>
      </div>
    </div>
  </div> 
    
  <%@include file="/front-end/member/includedfiles/footer.file" %>
  <%@include file="/front-end/member/includedfiles/js.file" %>
  <script src="//ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="simplewebrtc.bundle.js"></script>
  <script>
            // grab the room from the URL
            //var room = location.search && location.search.split('?')[1];
            var room="<%=moNO%>";
            // create our webrtc connection
            var webrtc = new SimpleWebRTC({
                // the id/element dom element that will hold "our" video
                localVideoEl: 'localVideo',
                // the id/element dom element that will hold remote videos
                remoteVideosEl: '',
                // immediately ask for camera access
                autoRequestMedia: true,
                debug: false,
                detectSpeakingEvents: true
            });

            // when it's ready, join if we got a room from the URL
            webrtc.on('readyToCall', function () {
                // you can name it anything
                if (room) webrtc.joinRoom(room);
            });

            function showVolume(el, volume) {
                if (!el) return;
                if (volume < -45) { // vary between -45 and -20
                    el.style.height = '0px';
                } else if (volume > -20) {
                    el.style.height = '100%';
                } else {
                    el.style.height = '' + Math.floor((volume + 100) * 100 / 25 - 220) + '%';
                }
            }
            webrtc.on('channelMessage', function (peer, label, data) {
                if (data.type == 'volume') {
                    showVolume(document.getElementById('volume_' + peer.id), data.volume);
                }
            });
            webrtc.on('videoAdded', function (video, peer) {
                console.log('video added', peer);
                var remotes = document.getElementById('remotes');
                if (remotes) {
                    var d = document.createElement('div');
                    d.className = 'videoContainer_remotes';
                    d.id = 'container_' + webrtc.getDomId(peer);
                    d.appendChild(video);
                    var vol = document.createElement('div');
                    vol.id = 'volume_' + peer.id;
                    vol.className = 'volume_bar';
                    video.onclick = function () {
                        video.style.width = video.videoWidth + 'px';
                        video.style.height = video.videoHeight + 'px';
                    };
                    d.appendChild(vol);
                    remotes.appendChild(d);
                }
            });
            webrtc.on('videoRemoved', function (video, peer) {
                console.log('video removed ', peer);
                var remotes = document.getElementById('remotes');
                var el = document.getElementById('container_' + webrtc.getDomId(peer));
                if (remotes && el) {
                    remotes.removeChild(el);
                }
            });
            webrtc.on('volumeChange', function (volume, treshold) {
                //console.log('own volume', volume);
                showVolume(document.getElementById('localVolume'), volume);
            });

            // Since we use this twice we put it here
            function setRoom(name) {
                $('form').remove();
               // $('h1').text(name);
                $('#subTitle').text('Link to join: ' + location.href);
                $('body').addClass('active');
            }

            if (room) {
                setRoom(room);
            } else {
                $('form').submit(function () {
                    var val = $('#sessionInput').val().toLowerCase().replace(/\s/g, '-').replace(/[^A-Za-z0-9_\-]/g, '');
                    webrtc.createRoom(val, function (err, name) {
                        console.log(' create room cb', arguments);
                    
                        var newUrl = location.pathname + '?' + name;
                        if (!err) {
                            history.replaceState({foo: 'bar'}, null, newUrl);
                            setRoom(name);
                        } else {
                            console.log(err);
                        }
                    });
                    return false;          
                });
            }

            var button = $('#screenShareButton'),
                setButton = function (bool) {
                    button.text(bool ? 'share screen' : 'stop sharing');
                };
            webrtc.on('localScreenStopped', function () {
                setButton(true);
            });

            setButton(true);

            button.click(function () {
                if (webrtc.getLocalScreen()) {
                    webrtc.stopScreenShare();
                    setButton(true);
                } else {
                    webrtc.shareScreen(function (err) {
                        if (err) {
                            setButton(true);
                        } else {
                            setButton(false);
                        }
                    });
                    
                }
            });
        </script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!--         	以下是WebSocket --> 
        <script>
//	    var MyPoint = "/MyEchoServer/peter/309";
		var roomno="<%=moNO%>";
		var userName="<%=docVO.getDrno()%>";
		var MyPoint="/MyEchoServer/doctor/"+roomno;//未來導入問診紀錄編號
	    var host = window.location.host;
	    var path = window.location.pathname;
	    var webCtx = path.substring(0, path.indexOf('/', 1));
	    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
	    
	    
	    
	    console.log("webCtx:"+webCtx+" path:"+path+" host:"+host);
	    console.log(endPointURL);
		var webSocket;
		
		
		function connect() {
			// 建立 websocket 物件
			webSocket = new WebSocket(endPointURL);
			
			webSocket.onopen = function(event) {
				console.log("Open a WebSocket!");
			};
			webSocket.onmessage = function(event) {
				var jsonObj = JSON.parse(event.data);
				var roomno2=jsonObj.roomno;
				var pptno=jsonObj.pptno;
				console.log(event.data);
				if(roomno2==roomno){
					if(pptno==null){
						alert(jsonObj.leavemessage);
					}else{
					$('#ppt').attr('src',"<%=request.getContextPath()%>/ppt/pptImg.do?pptno="+pptno);						
					}
				}
			};
			webSocket.onclose = function(event) {
			};
		}
		
		function back(){
			var jsonObj = {"userName" : userName, "message" : "back","roomno":roomno};
	        webSocket.send(JSON.stringify(jsonObj));
		}
		function next(){
			var jsonObj = {"userName" : userName, "message" : "next","roomno":roomno};
	        webSocket.send(JSON.stringify(jsonObj));
		}
		
		function disconnect () {
			
		}
		
		$(document).ready(function(){
		       $('#submit').click(function(){
		    	   var motext=$('#medicalrecord').val();
		          $.ajax({
		                url:'<%=request.getContextPath()%>/front-end/medicalOrder/medicalOrderServlet.do',
		                type:'post',
		                data: "moNo=<%=moNO%>&action=submitrecord&medicalrecord="+motext,
		                success : function(response) {
		                    swal('醫囑新增成功').then(() =>{
		                    	window.location.href = "<%=request.getContextPath()%>/front-end/medicalOrder/getMoByDrno.jsp";
		                	});
		                    
		                }
		            });
		       });
		    });
		</script>
	</body>
</html>
