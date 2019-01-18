<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.activity.model.*"%>

<%
	ActivityVO activityVO = (ActivityVO) request.getAttribute("activityVO"); //impressionServlet.java (Concroller) 存入req的impressionVO物件 (包括幫忙取出的impressionVO, 也包括輸入資料錯誤時的impressionVO物件)
%>

<html>
<head>

<title>活動資料修改-update_act.jsp</title>
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
 }
  h4 {
    color: #FF0088;
    display: inline;
  }

body {
  	background-image:url('<%=request.getContextPath()%>/front-end/activity/img/mountain.jpg');
	opacity:1;
	filter:alpha(opacity=80);
	background-repeat: no-repeat;
    background-attachment: fixed;
    background-position: center;
    background-size: cover;
    color:#00DDDD;
    font-weight:bold;
  }
#map {
		height: 400px;  /* The height is 400 pixels */
		width: 100%;  /* The width is the width of the web page */
	}
</style>

<title>活動資料修改-update_act.jsp</title>
</head>
<body>
	<div>
		<div><h3 class="title">活動資料修改-update_act.jsp</h3></div>
		<div><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="<%= request.getContextPath() %>/front-end/activity/img/back1.gif" width="100" height="100" border="0">回首頁</a></div>
	</div>

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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/activity/activity.do" name="form1" enctype="multipart/form-data">
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-12 col-sm-6">
				<div class="form-column">
    				<div class="row">
    					<div class="form-group col-md-12">
      						<label for="inputEmail4">活動編號:</label>
      						<input type="text" class="form-control" name="actNo" value="${activityVO.actNo}" readonly/>
    					</div>
						<div class="form-group col-md-12">
      						<label for="inputEmail4">舉辦人編號:</label>
      						<input type="text" class="form-control" name="memNo" value="${activityVO.memNo}" readonly/>
    					</div>
						<div class="form-group col-md-12">
      						<label for="inputEmail4">活動名稱:</label>
      						<input type="text" class="form-control" name="actName" value="${activityVO.actName}"/>
    					</div>
    					<div class="form-group col-md-12">
      						<label for="inputEmail4">活動時間:</label>
      						<input type="text" class="form-control" name="actTime" value="${activityVO.actTime}"/>
    					</div>
    					<div class="form-group col-md-12">
      						<label for="inputEmail4">活動人數下限:</label>
      						<input type="text" class="form-control" name="actLimit" value="${activityVO.actLimit}"/>
    					</div>
    					<div class="form-group col-md-12">
      						<label for="inputEmail4">活動人數上限:</label>
      						<input type="text" class="form-control" name="actMax" value="${activityVO.actMax}"/>
    					</div>
    					<div class="form-group col-md-12">
      						<label for="inputEmail4">活動確認時間:</label>
      						<input type="text" class="form-control" name="timeCheck" value="${activityVO.timeCheck}"/>
    					</div>
    					<div class="form-group col-md-12">
    						<label for="inputEmail4">活動狀態:</label>
      						<select name="actStatus" class="form-control">
								<option value="募集中" ${('募集中'==activityVO.actStatus)? 'selected':'' } >募集中</option>
								<option value="已結束" ${('已結束'==activityVO.actStatus)? 'selected':'' }>已結束</option>
								<option value="已取消" ${('已取消'==activityVO.actStatus)? 'selected':'' }>已取消</option>
							</select>
    					</div>
    					<div class="form-group col-md-12">
      						<label for="inputEmail4">活動敘述:</label>
      						<textarea name="actDesc" class="form-control" rows="8" cols="50" ><%= (activityVO==null)? "" : activityVO.getActDesc()%></textarea>
    					</div>
					</div>
				</div>
			</div>
<!-- 右半邊 -->
			<div class="col-xs-12 col-sm-6">
				<div class="form-group col-md-12">
					<label for="inputAddress">活動位置:</label>
      				<input id="address" type="text" size="50" class="form-control" name="actLoc" value="<%=activityVO.getActLoc()%>">   
	  				<input type="button" value="查經緯度並在地圖上顯示" id="submit" >
	  				<input type="hidden" name="latiTude" id="lat" value="<%=activityVO.getLatiTude()%>">
					<input type="hidden" name="longtiTude" id="long" value="<%=activityVO.getLongtiTude()%>">				
					<div id="map"></div>
    			</div>
				<div class="form-column">
    				<div class="row">
      					<div class="form-group col-md-12">
        					<label for="inputZip">圖片檔案:</label>
      					</div>
    				</div>
    					<div class="col-xs-12 col-sm-12">
      						<c:choose>
								<c:when test="${(activityVO.actPic)!=null}">
									<td>
										<img src="<%= request.getContextPath()%>/activity/activityPic.do?actNo=${activityVO.actNo}" id="output2" height=50% width=50%/>
										<input type="file" name="actPic" size="45" onchange="loadFile(event)"/>
									</td>
								</c:when>
								<c:otherwise>
									<td>
										<img src="<%= request.getContextPath()%>/front-end/activity/img/nopic.jpg" id="output2" width=50% height=50%>
										<input type="file" name="actPic" size="45" onchange="loadFile(event)"/>
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
							<input type="hidden" name="actNo" value="<%= activityVO.getActNo()%>">
							<input type="submit" value="送出修改" class="btn btn-success">
    					</div>
    				</div>
  				</div>
			</div>
		</div>
	</div>
</FORM>


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
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  java.sql.Date actTime = null;
  try {
	  actTime = activityVO.getActTime();
   } catch (Exception e) {
	   actTime = new java.sql.Date(System.currentTimeMillis());
   }
%>
<script src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.full.js"></script>

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
        //      var somedate1 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});

        
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
<script>
		function initMap() {
	    	//put the lat and lng in the map
	        var thePlaceNeedToBeDynmic = { lat:<%=activityVO.getLatiTude()%>, lng: <%=activityVO.getLongtiTude()%> };

	        
	        var map = new google.maps.Map(document.getElementById('map'), { zoom: 14, center: thePlaceNeedToBeDynmic });
	        var marker = new google.maps.Marker({ position: thePlaceNeedToBeDynmic, map: map });
			
	        var geocoder = new google.maps.Geocoder();
	        document.getElementById('submit').addEventListener('click', function() {geocodeAddress(geocoder, map);
	        });
	      	
		//查詢地點
	    function geocodeAddress(geocoder, resultsMap) {
	        var address = document.getElementById('address').value;
	        var lat = null;
	        var lng = null;
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
	                var marker = new google.maps.Marker({
	                    map: resultsMap,
	                    position: results[0].geometry.location
	                });
	            } else {
	                alert('Geocode was not successful for the following reason: ' + status);
	            }
	        });	        
	    }	    
	    }
</script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCTnkH63kGQfUHVWE7JNFKvt4QobWesS-Y&callback=initMap">
	</script>
</body>

</html>