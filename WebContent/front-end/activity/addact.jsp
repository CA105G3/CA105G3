<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.activity.model.*"%>

<%
String memNo=(String)session.getAttribute("memno");
pageContext.setAttribute("memNo", memNo);
	ActivityVO activityVO = (ActivityVO) request.getAttribute("activityVO");
%>

<html>
<head>
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

<title>新增活動-addact.jsp</title>
</head>
<body>
	<header style="background-image:url('<%=request.getContextPath()%>/front-end/activity/img/act1.gif'); height:150px;background-repeat: no-repeat;
    background-attachment: fixed;background-position: center;background-size: cover;">
		<span>&nbsp;</span><br>
		<span>&nbsp;</span>
			<h3 class="title"style="color:black;"><span><b>建立活動</b></span></h3>
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
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/activity/activity.do" name="form1" enctype="multipart/form-data">
	<div class="container-fluid">
		<div class="row">
  			<div class="col-xs-12 col-sm-6">
  				<div class="form-column">
    				<div class="row">
    					<div class="form-group col-md-12">
      						<label for="inputEmail4">活動名稱:</label>
      						<input type="text" class="form-control" name="actName" placeholder="請填入該活動名稱" value="<%= (activityVO==null)?"": activityVO.getActName()%>">
    					</div>
    					<div class="form-group col-md-12">
      						<label for="inputPassword4">主辦人會員編號:</label>
      						<input type="text" class="form-control" name="memNo" placeholder="EX:M0001" value="<%=memNo%>" readonly>
    					</div>
						<div class="form-group col-md-12">
    						<label for="inputAddress">活動位置:</label>
						  	<input id="address" type="text" size="50" class="form-control" name="actLoc" value="<%= (activityVO==null)?"": activityVO.getActLoc()%>">   
						  	<input type="button" value="查經緯度並在地圖上顯示" id="submit">
						  	<input type="hidden" name="latiTude" id="lat" value="<%= (activityVO==null)?"": activityVO.getLatiTude()%>">
							<input type="hidden" name="longtiTude" id="long" value="<%= (activityVO==null)?"": activityVO.getLongtiTude()%>">
							<div id="map"></div>
  						</div>
  						<div class="form-group col-md-12">
						    <label for="inputAddress2">活動時間:</label>
						    <input type="text" class="form-control" name="actTime" placeholder="請選擇日期" id="f_date1" value="<%= (activityVO==null)? "" : activityVO.getActTime()%>">
  						</div>
					  	</div>
			    	<div class="form-row">
						<div class="form-group col-md-6">
					    	<label for="inputZip">活動人數下限:</label>
					    	<input type="text" class="form-control" name="actLimit" placeholder="至少為1人" value="<%= (activityVO==null)? "" : activityVO.getActLimit()%>">
						</div>
				    	<div class="form-group col-md-6">
							<label for="inputState">活動人數上限:</label>
							<input type="text" class="form-control" name="actMax" placeholder="至少為1人" value="<%= (activityVO==null)? "" : activityVO.getActMax()%>">
						</div>
		  			</div>
  				</div>
			</div>
			<div class="col-xs-12 col-sm-6">
				<div class="form-group col-md-12">
			  	</div>
				<div class="form-column">
					<div class="row">
						<div class="form-group col-md-12">
							<label for="inputZip">圖片檔案:</label>
						</div>
					</div>
						<div class="col-xs-12 col-sm-12">
							<img src="<%= request.getContextPath() %>/front-end/activity/img/nopic.jpg" id="output" width=80% height=60%/>
							<input type="file" name="actPic" size="45" onchange="loadFile(event)">
						</div>
				</div>
				<div class="form-row">
					<div class="form-group col-md-12">
					    <label for="inputState">活動敘述:</label>
					    <textarea name="actDesc" class="form-control" rows="8" cols="50" ><%= (activityVO==null)? "" : activityVO.getActDesc()%></textarea>
					</div>    
				</div>   
				<div class="form-row">
					<div class="form-group col-md-10">
					</div>
					<div class="form-group col-md-2">
						<div class="row">
							<input type="hidden" name="timeCheck" value="1">
							<input type="hidden" name="actStatus" value="募集中">
							<input type="hidden" name="action" value="insert">
						    <button type="submit" class="btn btn-success">新增</button>
						</div>
    				</div>
  				</div>
			</div>
		</div>
	</div>
</form>

<script>
  var loadFile = function(event) {
    var reader = new FileReader();
    reader.onload = function(){
      var output = document.getElementById("output");
      output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
  };
</script>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  java.sql.Date actTime = null;
  try {
	  actTime = activityVO.getActTime();
   } catch (Exception e) {
	   actTime = new java.sql.Date(System.currentTimeMillis());
   }
%>

	
<script>
		//初始化地圖
		function initMap() {
	    	//put the lat and lng in the map
	        var thePlaceNeedToBeDynmic = { lat: 24.968269, lng: 121.192192 }; 
	        var map = new google.maps.Map(document.getElementById('map'), { zoom: 14, center: thePlaceNeedToBeDynmic });
	        var marker = new google.maps.Marker({ position: thePlaceNeedToBeDynmic, map: map ,title:"中央大學"});
			
	        var geocoder = new google.maps.Geocoder();
	        document.getElementById('submit').addEventListener('click', function() {geocodeAddress(geocoder, map);
	        });
	            	
		//查詢地點
	    function geocodeAddress(geocoder, resultsMap) {
	        var address = document.getElementById('address').value;
	     	
	        geocoder.geocode({ 'address': address }, function(results, status) {        	
	            if (status === 'OK') {
	                resultsMap.setCenter(results[0].geometry.location);
	                //I got the realAddress!!!
	                console.log(results[0].formatted_address);
	                //I got the lat and lng!!!
	                console.log(results[0].geometry.location.lat());
	                console.log(results[0].geometry.location.lng());
	                document.getElementById( 'lat' ).value = results[0].geometry.location.lat();
	                document.getElementById( 'long' ).value = results[0].geometry.location.lng();
	                marker = new google.maps.Marker({
	                    map: resultsMap,
	                    position: results[0].geometry.location,
	                    animation: google.maps.Animation.DROP,
	                    draggable:true
	                    
	                });
	              //拖曳位置
	                google.maps.event.addListener(marker, 'dragend', function(marker){
	                    var latLng = marker.latLng;
	                    console.log(latLng);
	                    currentLatitude = latLng.lat();
	                    currentLongitude = latLng.lng();
	                    $("#lat").val(currentLatitude);
	                    $("#long").val(currentLongitude);
	                    geocoder.geocode({
	                        'latLng': latLng
	                      }, function(results, status) {
	                          if (status === 'OK') {
	                        	  document.getElementById( 'address' ).value = (results[0].formatted_address);
	                              }
	                          });	
	                 });     
	            }else{
	                alert('Geocode was not successful for the following reason: ' + status);
	            }
	        });	        
	    }
		
	    function geocodePosition(pos) {
	    	  geocoder.geocode({
	    	    latLng: pos
	    	  }, function(responses) {
	    	    if (responses && responses.length > 0) {
	    	    	document.getElementById( 'address' ).value = updateMarkerAddress(responses[0].formatted_address);
	    	    } else {
	    	      updateMarkerAddress('Cannot determine address at this location.');
	    	    }
	    	  });
	    	}
	        //畫圓圈
// 	        var circle = new google.maps.Circle({
// 			  center: thePlaceNeedToBeDynmic,
// 			  radius: 1000,
// 			  strokeOpacity: 0,
// 			  fillColor: '#76A2DC',
// 			  fillOpacity: 0.35,
// 			  map: map
// 			});
	        

	    }
</script>

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCTnkH63kGQfUHVWE7JNFKvt4QobWesS-Y&libraries=places&callback=initMap">
</script>
<!-- ----------------------------------------------------------------------------------------------------------------------------->
<script>

    $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '',              // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });

 
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
             var somedate1 = new Date('2019-01-24');
             $('#f_date1').datetimepicker({
                 beforeShowDay: function(date) {
               	  if (  date.getYear() <  somedate1.getYear() || 
        		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
                     ) {
                          return [false, ""]
                     }
                     return [true, ""];
             }});

        
        //      2.以下為某一天之後的日期無法選擇
        //      var somedate2 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>
</body>
</html>