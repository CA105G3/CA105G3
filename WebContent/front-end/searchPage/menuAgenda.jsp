<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.menulist.model2.*" %>

<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

	<title>Menu Agenda</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<!--[if lt IE 9]>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
<style type="text/css">
	.agenda {  }
/* Dates */
.agenda .agenda-date { width: 170px; }
.agenda .agenda-date .dayofmonth {
  width: 40px;
  font-size: 36px;
  line-height: 36px;
  float: left;
  text-align: right;
  margin-right: 10px; 
}

.agenda .agenda-date .shortdate {
  font-size: 0.75em; 
}

/* Times */
.agenda .agenda-time { width: 140px; } 

/* Events */
.agenda .agenda-events {  } 
.agenda .agenda-events .agenda-event {  } 

@media (max-width: 767px) {
    
}
</style>
<style>
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  position: relative;
  background-color: #fefefe;
  margin: auto;
  padding: 0;
  border: 1px solid #888;
  width: 80%;
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
  -webkit-animation-name: animatetop;
  -webkit-animation-duration: 0.4s;
  animation-name: animatetop;
  animation-duration: 0.4s
}

/* Add Animation */
@-webkit-keyframes animatetop {
  from {top:-300px; opacity:0} 
  to {top:0; opacity:1}
}

@keyframes animatetop {
  from {top:-300px; opacity:0}
  to {top:0; opacity:1}
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
</style>
</head>
<body>

<!------ Include the above in your HEAD tag ---------->
<!-- <div class="container"> -->
<h2>Agenda</h2> 

    <p class="lead">
        This agenda viewer will let you see multiple events cleanly!
    </p>
   
<div id="printtable"></div>
<div id="myModal" class="modal">
	<div class="modal-content">
		<span class="close" onclick="modal.style.display='none'"> &times; </span>
		<table>
		<tr><td>ABC</td></tr>
		</table>
	</div>
</div>
<div>
            <div class="form-inline">
            	<button class="btn btn-primary" id="previous" onclick="previous()"> Last month </button>
            	<button class="btn btn-primary" id="next" onclick="next()"> Next month</button>
            </div> <br/>
            <form class="form-inline">
            	<select class="form-control col-sm-4" name="month" id="month" onchange="jump()">
            		<option value=0>一月</option>
            		<option value=1>二月</option>
            		<option value=2>三月</option>
            		<option value=3>四月</option>
            		<option value=4>五月</option>
            		<option value=5>六月</option>
            		<option value=6>七月</option>
            		<option value=7>八月</option>
            		<option value=8>九月</option>
            		<option value=9>十月</option>
            		<option value=10>十一月</option>
            		<option value=11>十二月</option>
            	</select>
            	<select class="form-control col-sm-4" name="year" name="year" onchange="jump()">
	            	<option value=2018>2018</option>
		            <option value=2019>2019</option>
		            <option value=2020>2020</option>
		            <option value=2021>2021</option>
		            <option value=2022>2022</option>
		        </select>
            </form>
       
</div>
		
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"
        integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ"
        crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
        integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
        crossorigin="anonymous"></script>
     
</body>
  <script>
	    var modal = document.getElementById("myModal");
// 		var btn = document.getElementById("myBtn");
		var span = document.getElementsByClassName("close")[0];
		
		window.onclick = function(event) {
			if (event.target == modal){
				modal.style.display = "none";
			}
		}
  
 		function init(){
 			
 			function days_of_a_year(year){
 				return isLeapYear(year)? 366:365;
 			}
 		
 			function isLeapYear(year){
 				return year % 400 === 0 || (year % 100 !== 0 && year % 4 === 0);
 			}
 				var daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
 				var today = new Date();
 				var thisYear = today.getFullYear();
 				var month = today.getMonth()+1;
 		
 				var firstDate = new Date(thisYear,month-1,1);
 				var firstDay = firstDate.getDay();
 				
 				var yearDay = days_of_a_year(thisYear);
 				var day;
 				
 				if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month ==10 || month == 12 ){
 					day = 31;
 				}
 				if (month == 4 || month == 6 || month == 9 || month == 11){
 					day = 30;
 				}
 				if (yearDay == 365 && month == 2){
 					day = 28;
 				}
 				if (yearDay == 366 && month == 2){
 					day = 29;
 				}
 		
 			var table = '<div class="agenda"<div class="agenda"><div class="table-responsive"><table class="table table-condensed table-bordered">';
 			
 			//星期的bar
 			for (var j = 0; j < daysOfWeek.length; j++){
 				table += "<th>" + daysOfWeek[j] + "</th>";
 			}
 			table += '<tr></tr><tr>';
 			
 			//找出每個月的第一天是星期幾並決定在月曆中前面要有幾個空格
 			for (var k = 1; k <= firstDay; k++){
 				table += '<td></td>';
 			}	
 			var z = 1+firstDay;	
 			for (var i = 1; i < day; i++){
 				table += '<td><table><tr><td class="agenda-date" class="active" rowspan="3">' + i + '</td>' + 
						 '<td class="agenda-time"><button onclick="modal.style.display=\'block\'">早</button></td></tr>' + 
						 '<tr><td class="agenda-time"><button onclick="modal.style.display=\'block\'">中</button></td></tr>' + 
						 '<tr><td class="agenda-time"><button onclick="modal.style.display=\'block\'">晚</button></td></tr></table></td>';
 		
 				if(z%7===0) table += '</tr><tr>';
 				z++;
 			}
 			table +='</tr></table>';
 			document.getElementById("printtable").innerHTML=table;	
 		};
 		
 		window.onload=init;
  </script>
</html>