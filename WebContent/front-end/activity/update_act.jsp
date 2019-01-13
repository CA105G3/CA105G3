<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.activity.model.*"%>

<%
	ActivityVO activityVO = (ActivityVO) request.getAttribute("activityVO"); //impressionServlet.java (Concroller) �s�Jreq��impressionVO���� (�]�A�������X��impressionVO, �]�]�A��J��ƿ��~�ɪ�impressionVO����)
%>

<html>
<head>

<title>���ʸ�ƭק�-update_act.jsp</title>
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
  #map {
		height: 400px;  /* The height is 400 pixels */
		width: 50%;  /* The width is the width of the web page */
	}
</style>

<style>
  table {
	width: 100%;
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
		 <h3>���ʸ�ƭק�-update_act.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/activity/joinactivity.jsp"><img src="<%=request.getContextPath()%>/front-end/impression/img/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<h3>��ƭק�:</h3>

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
<table>
	<tr>
		<td>���ʽs��:</td>
		<td><%=activityVO.getActNo()%></td>
	</tr>
	<tr>
		<td>�|��H�s��:</td>
		<td><input type="TEXT" name="memNo" size="45" 
			 value="<%=activityVO.getMemNo()%>" readonly="true" /></td>
	</tr>
	<tr>
		<td>���ʦW��:</td>
		<td><input type="TEXT" name="actName" size="45" 
			 value="<%=activityVO.getActName()%>" />
		</td>
	</tr>
	<tr>
		<td>���ʦ�m:</td>
		<td>
			<input id="address" type="text" size="50" class="form-control" name="actLoc" value="<%=activityVO.getActLoc()%>">   
	  		<input type="button" value="�d�g�n�רæb�a�ϤW���" id="submit" >
	  		<input type="hidden" name="latiTude" id="lat" value="<%=activityVO.getLatiTude()%>">
			<input type="hidden" name="longtiTude" id="long" value="<%=activityVO.getLongtiTude()%>">
				
				<div id="map"></div>
		</td>
	</tr>
	<tr>
		<td>���ʮɶ�:</td>
		<td><input type="TEXT" name="actTime" size="45" id="f_date1"
			 value="<%= (activityVO==null)? "" : activityVO.getActTime()%>"/></td>
	</tr>
	<tr>
		<td>���ʪ��A:</td>
		<td>
		<select name="actStatus">
		<option value="�Ҷ���" ${('�Ҷ���'==activityVO.actStatus)? 'selected':'' } >�Ҷ���</option>
		<option value="�w����" ${('�w����'==activityVO.actStatus)? 'selected':'' }>�w����</option>
		<option value="�w����" ${('�w����'==activityVO.actStatus)? 'selected':'' }>�w����</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>���ʤH�ƤW��:</td>
		<td><input type="TEXT" name="actMax" size="45"
			 value="<%= (activityVO==null)? " " : activityVO.getActMax()%>" /></td>
	</tr>
	<tr>
		<td>���ʤH�ƤU��:</td>
		<td><input type="TEXT" name="actLimit" size="45"
			 value="<%= (activityVO==null)? " " : activityVO.getActLimit()%>" /></td>
	</tr>
	<tr>
		<td>���ʽT�{�ɶ�:</td>
		<td><input type="TEXT" name="timeCheck" size="45"
		value="<%= (activityVO==null)? " " : activityVO.getActLimit()%>" /></td>	
	</tr>
	<tr>
		<td>���ʱԭz:</td>
		<td><input type="TEXTAREA" name="actDesc" size="45"
		value="<%= (activityVO==null)? " " : activityVO.getActDesc()%>" /></td>	
	</tr>
	<tr>
		<td>�Ӥ��W��:</td>
		
		<c:choose>
				<c:when test="${(activityVO.actPic)!=null}">
			<td>
				<img src="<%= request.getContextPath()%>/activity/activityPic.do?actNo=${activityVO.actNo}" id="output" height=50% width=40%/>
				<input type="file" name="actPic" size="45" onchange="loadFile(event)"/>
			</td>
				</c:when>
				<c:otherwise >
			<td>
			<img src="<%= request.getContextPath()%>/front-end/activity/img/nopic.jpg" id="output2" width=50% height=40%>
			<input type="file" name="actPic" size="45" onchange="loadFile2(event)"/>
			</td>
				</c:otherwise>
			</c:choose>
		
	</tr>
	
	
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="actNo" value="<%= activityVO.getActNo()%>">
<input type="submit" value="�e�X�ק�"></FORM>
<script>
  var loadFile = function(event) {
    var reader = new FileReader();
    reader.onload = function(){
      var output = document.getElementById("output");
      output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
  };
  
  var loadFile2 = function(event) {
    var reader = new FileReader();
    reader.onload = function(){
      var output = document.getElementById("output2");
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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/front-end/activity/datetimepicker/jquery.datetimepicker.full.js"></script>

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
<script>
		function initMap() {
	    	//put the lat and lng in the map
	        var thePlaceNeedToBeDynmic = { lat:<%=activityVO.getLatiTude()%>, lng: <%=activityVO.getLongtiTude()%> };

	        
	        var map = new google.maps.Map(document.getElementById('map'), { zoom: 14, center: thePlaceNeedToBeDynmic });
	        var marker = new google.maps.Marker({ position: thePlaceNeedToBeDynmic, map: map });
			
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