<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.activity.model.*"%>

<%
	String memNo="M0001";
	ActivityVO activityVO = (ActivityVO) request.getAttribute("activityVO");
%>

<html>
<head>
 <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+TC">
<!-- 	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBIhqiPHeOg_usCkMxjSCUD0CJgzTs2egw&callback=initMap" async defer></script> -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!--   	<link rel="stylesheet" href="/resources/demos/style.css"> -->
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
  }
#map {
		height: 400px;  /* The height is 400 pixels */
		width: 100%;  /* The width is the width of the web page */
	}
</style>

<title>�s�W����-addact.jsp</title>
</head>
<body>
		 <div>
		 <div><h3 class="title">���ʸ�Ʒs�W - addact.jsp</h3></div>
		 <div><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="<%= request.getContextPath() %>/front-end/activity/img/back1.gif" width="100" height="100" border="0">�^����</a></div>
		 </div>
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/activity/activity.do" name="form1" enctype="multipart/form-data">
  <div class="container-fluid">
  <div class="row">
  <div class="col-xs-12 col-sm-6">
  <div class="form-column">
    <div class="row">
    <div class="form-group col-md-12">
      <label for="inputEmail4">���ʦW��:</label>
      <input type="text" class="form-control" name="actName" placeholder="�ж�J�Ӭ��ʦW��" value="<%= (activityVO==null)?"": activityVO.getActName()%>">
    </div>
    <div class="form-group col-md-12">
      <label for="inputPassword4">�D��H�|���s��:</label>
      <input type="text" class="form-control" name="memNo" placeholder="EX:M0001" value="<%=memNo%>" readonly>
    </div>
    
<!--   <div class="form-group col-md-12"> -->
<!--     <label for="inputAddress">���ʦ�m:</label> -->
<%--     <input type="text" class="form-control" name="actLoc" placeholder="1234 Main St" value="<%= (activityVO==null)?"": activityVO.getActLoc()%>"> --%>
<!--   	<input id="address" type="text" size="50" value="">   <input type="button" value="�d�g�n�רæb�a�ϤW���" onClick="initMap()"> -->

  <div class="form-group col-md-12">
    <label for="inputAddress">���ʦ�m:</label>
  	<input id="address" type="text" size="50" class="form-control" name="actLoc" value="<%= (activityVO==null)?"": activityVO.getActLoc()%>">   
  	<input type="button" value="�d�g�n�רæb�a�ϤW���" id="submit">
  	<input type="hidden" name="latiTude" id="lat" value="<%= (activityVO==null)?"": activityVO.getLatiTude()%>">
	<input type="hidden" name="longtiTude" id="long" value="<%= (activityVO==null)?"": activityVO.getLongtiTude()%>">
	<div id="map"></div>
  </div>
  
  <div class="form-group col-md-12">
    <label for="inputAddress2">���ʮɶ�:</label>
    <input type="text" class="form-control" name="actTime" placeholder="�п�ܤ��" id="f_date1" value="<%= (activityVO==null)? "" : activityVO.getActTime()%>">
  </div>
    <div class="form-group col-md-12">
      <label for="inputCity">���ʪ��A:</label>
      <input type="text" class="form-control" name="actStatus" value="<%= (activityVO==null)?"�Ҷ���": activityVO.getActStatus()%>" readonly>
    </div>
  </div>
    <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputState">���ʤH�ƤW��:</label>
      <input type="text" class="form-control" name="actMax" placeholder="�ܤ֬�1�H" value="<%= (activityVO==null)? "" : activityVO.getActMax()%>">
    </div>
    <div class="form-group col-md-6">
      <label for="inputZip">���ʤH�ƤU��:</label>
      <input type="text" class="form-control" name="actLimit" placeholder="�ܤ֬�1�H" value="<%= (activityVO==null)? "" : activityVO.getActLimit()%>">
    </div>
  </div>
  </div>
</div>
<div class="col-xs-12 col-sm-6">
  <div class="form-group col-md-12">
    <div class="row">
      <label for="inputZip">���ʽT�{�ɶ�:</label>
      <input type="text" class="form-control" name="timeCheck" placeholder="�ܤ֬�1��" value="<%= (activityVO==null)? "" : activityVO.getTimeCheck()%>">
  </div>
  </div>
  <div class="form-column">
    <div class="row">
      <div class="form-group col-md-12">
        <label for="inputZip">�Ϥ��ɮ�:</label>
      </div>
    </div>
    <div class="col-xs-12 col-sm-12">
      <img src="<%= request.getContextPath() %>/front-end/activity/img/nopic.jpg" id="output" width=80% height=60%/>
      <input type="file" name="actPic" size="45" onchange="loadFile(event)">
    </div>
  </div>
<div class="form-row">
    <div class="form-group col-md-12">
      <label for="inputState">���ʱԭz:</label>
      <input type="text" class="form-control" name="actDesc" placeholder="�ж�J���ʱԭz" value="<%= (activityVO==null)? "" : activityVO.getActDesc()%>">
    </div>    
</div>
    
    <div class="form-row">
    <div class="form-group col-md-10">
    </div>
    <div class="form-group col-md-2">
      <div class="row">
      <input type="hidden" name="action" value="insert">
      <button type="submit" class="btn btn-success">�s�W</button>
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
<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

<% 
  java.sql.Date actTime = null;
  try {
	  actTime = activityVO.getActTime();
   } catch (Exception e) {
	   actTime = new java.sql.Date(System.currentTimeMillis());
   }
%>

	
<script>
		//��l�Ʀa��
		function initMap() {
	    	//put the lat and lng in the map
	        var thePlaceNeedToBeDynmic = { lat: 24.968269, lng: 121.192192 };

	        
	        var map = new google.maps.Map(document.getElementById('map'), { zoom: 14, center: thePlaceNeedToBeDynmic });
	        var marker = new google.maps.Marker({ position: thePlaceNeedToBeDynmic, map: map ,title:"�����j��"});
			
	        var geocoder = new google.maps.Geocoder();
	        document.getElementById('submit').addEventListener('click', function() {geocodeAddress(geocoder, map);
	        
	        });
	            	
		//�d�ߦa�I
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
	                    position: results[0].geometry.location,
	                    draggable:true
	                });
	                
	            } else {
	                alert('Geocode was not successful for the following reason: ' + status);
	            }
	        });	        
	    }
		
	        //�e���
	        var circle = new google.maps.Circle({
			  center: thePlaceNeedToBeDynmic,
			  radius: 1000,
			  strokeOpacity: 0,
			  fillColor: '#76A2DC',
			  fillOpacity: 0.35,
			  map: map
			});
	        
	    google.maps.event.addListener(marker, 'draggable', function () {
            geocodePosition(geocoder, marker.getPosition(), circle, marker);
        });	
	    function geocodePosition(geocoder, pos, circle, marker) {
            geocoder.geocode({
                'latLng': pos
            }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    marker.setPosition(pos);
                    if (results[0]) {
                        document.getElementById("address").value = results[0].formatted_address;
                        $scope.$apply(function () {
                            vm.location.address = document.getElementById('address').value;
                            vm.location.longitude = pos.lng().toFixed(6);
                            vm.location.latitude = pos.lng().toFixed(6);
                        });
                        circle.setCenter(pos);
                    } else {
                        alert('����m�L�k�w�}');
                    }
                }
                else {
                    marker.setPosition({
                        lat: parseFloat(vm.location.latitude),
                        lng: parseFloat(vm.location.longitude)
                    });
                    alert('����m�L�k�w�}');
                }
            });
        }
	    }
</script>

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCTnkH63kGQfUHVWE7JNFKvt4QobWesS-Y&callback=initMap">
</script>
<!-- ----------------------------------------------------------------------------------------------------------------------------->
<script>

    $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '',              // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           //minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });

 
        // ----------------------------------------------------------�H�U�ΨӱƩw�L�k��ܪ����-----------------------------------------------------------

        //      1.�H�U���Y�@�Ѥ��e������L�k���
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

        
        //      2.�H�U���Y�@�Ѥ��᪺����L�k���
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


        //      3.�H�U����Ӥ�����~������L�k��� (�]�i���ݭn������L���)
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