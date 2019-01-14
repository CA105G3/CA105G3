<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.devdaily.calendar.Month,java.util.*,java.io.*,java.sql.*,com.devdaily.*" errorPage="error.jsp" %>
<%@ page import="com.menu.model.*"%>    
<%@ page import="com.menulist.model.*"%>    
    
<%
	String chefNo = (String)request.getAttribute("chefNo");
	List<MenuVO> menu = (List<MenuVO>)request.getAttribute("menu");
	List<MenuListVO> menuList = (List<MenuListVO>)request.getAttribute("menuList");
%>  

<%@ include file="calendarCommon.jsp" %>
<!DOCTYPE html>
<head>
  <title>修改上架餐點</title>
  <script src="https://code.jquery.com/jquery.js"></script>
  <link rel="StyleSheet" href="css/calendar.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<style type="text/css">
.card {
	position: relative;
  	margin:2% 5px 2% 5px;
  	background-color: #fff;
  	transition: box-shadow .25s;
  	border-radius: 2px;
   	box-shadow: 0 2px 5px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12);
	padding:0;
	min-width:200px;
	max-width:250px;
}
.card .card-image img {
	display: block;
	border-radius: 2px 2px 0 0;
	position: relative;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	width: 100%;
}
.card .card-content {
	padding: 0 0 0 0;
	border-radius: 0 0 2px 2px;
	height: 73px;
}

.card .card-content p {
	margin:0;
	font-size:1.45rem;
	color: #555555;
}
/*----3.a.Horizontal----*/
.card.horizontal .card-image img {
	max-width: 100px;
    max-height: 73px;
}

.card.horizontal {
  	display: -webkit-flex;
  	display: -ms-flexbox;
  	display: flex;
}
.card.horizontal.small .card-image,
 .card.horizontal.medium .card-image,
  .card.horizontal.large .card-image {
  	height: 100%;
  	max-height: none;
  	overflow: visible;
}
.card.horizontal .card-image img {
  	width:150px;
	height:150px;
	margin-right:0px;
}
.card.horizontal .card-stacked {
  	-webkit-flex-direction: column;
    -ms-flex-direction: column;
    flex-direction: column;
  	-webkit-flex: 1;
    -ms-flex: 1;
    flex: 1;
  	position: relative;
}
.card.horizontal .card-stacked .card-content {
  	-webkit-flex-grow: 1;
    -ms-flex-positive: 1;
	flex-grow: 1;
}
.card .card-image {
  position: relative;
}
h2 {
    margin-top: 10px;	
}
h4 {
    display: block;
    margin-block-start: 0.1em;
    margin-block-end: 0.4em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
}
h5 {
    display: block;
    margin-block-start: 0.1em;
    margin-block-end: 0.4em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    text-align: center;
}
.descrip_title {
	text-align: left;
    padding-left: 10px
}
.descrip_content {
	text-align: right;
    padding-left: 20px;
    padding-right: 10px
}
.col-sm-10 .descrip_title {
	text-align: left;
    padding-left: 6px
}
.monthControll {
	margin-top: 10px;
}
</style>

<script>
	var timer;
	function passValue(e){
		$("#mode").text("上架餐點");
		$("#shelf").css("visibility","visible");
		$("#target div").remove();
		$("#target").append($(e).clone().css("display","none"));
	}

	function setMenu(e){
		var element = e;
		var menuPic = $("#target img").attr("src");
		var mainCourse = $("#target span[name='mainCourse']").attr("value");
		var unitPrice = $("#target div[name='unitPrice']").attr("value");
		var deliverable = $("#target div[name='deliverable']").attr("value");
		var menuNo = $("#target input[name='menuNo']").attr("value");
		var menuListNo = $(element).find("input[name='menuListNo']").attr("value");
		var menuTimeSlot = $(element).find("input[name='menuTimeSlot']").attr("value");
		var menuDay = $(element).find("input[name='menuDay']").attr("value");

		if(menuPic === ""){
			menuPic = "<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg";
		}
		
		$(element).find("img").attr("src",menuPic);
		$(element).find("span[name='mainCourse']").text(mainCourse).css("font-size","1.2em");
		$(element).find("div[name='unitPrice']").text(unitPrice);
		$(element).find("div[name='deliverable']").text(deliverable);
		$(element).find("input[name='menuNo']").attr("value",menuNo);
		
		
		console.log(menuTimeSlot);
		console.log(menuNo);
		console.log(menuDay);
		
			
		
		if(menuListNo != ""){
			if($("#target img").attr("src") != ""){
				$.ajax({
					url: 'menulistajax.do',
					type: "post",
					data: { 
						action: "update",
						menuNo: menuNo,
						menuListNo: menuListNo,
						menuTimeSlot: menuTimeSlot,
						menuDay: menuDay,
						menuMonth: "<%=intMonth+1%>",
						menuYear: "<%=intYear%>"
						},
					dataType: "json",
					success: function(res){alert("access success!");},
					error: function(xhr){alert("access error!");}
				});
			} else {
				$.ajax({
					url: 'menulistajax.do',
					type: "post",
					data: {action: "delete", menuListNo: menuListNo},
					dataType: "json",
					success: function(){
						$(element).find("input[name='menuListNo']").attr("value", "");
						alert("access success!");
						},
					error: function(){alert("access error!");}
				});
			}
		} else {
			if($("#target img").attr("src") != ""){
				$.ajax({
					url: 'menulistajax.do',
					type: "post",
					data: { 
						action: "insert",
						menuNo: menuNo,
						menuTimeSlot: menuTimeSlot,
						menuDay: menuDay,
						menuMonth: "<%=intMonth+1%>",
						menuYear: "<%=intYear%>"
						},
					dataType: "json",
					success: function(res){
						/* $(element).find("input[name='menuListNo']").attr("value", res.menuListNo); */
						alert(res);
						},
					error: function(xhr){alert("access error!");}
				});
			}
		}
	}

	$(document).ready(function(){
		$("#shelf").click(function(){
			var menuPic = $("#target img").attr("src");
			if(menuPic === ""){
				console.log("空值");
			} else {
				$("#target div").remove();
				$("#target").append($("#default").clone());
				$(this).css("visibility","hidden");
				$("#mode").text("下架餐點");
			}
		});
	});
	
	function debounce(callback, time){
		if(timer)
			 clearTimeout(timer);
		timer = setTimeout(function(){callback();}, time);
	}
</script>

</head>
<body id="print_view_page">

<div class="container-fluid">
<div class="row">
<div class="col-sm-2">

	<div><font size="3">編輯模式：</font><font id="mode" size="4">下架餐點</font></div>

	<div id="target">
		<div style="display: none;" class="card horizontal">
			<div class="card-image">
				<img name="menuPic" src="">
			</div>
			<div class="card-stacked">
				<div class="card-content">
					<div class="descrip_title" name="timeSlot">已選取餐點</div>
					<h4><span name="mainCourse" value=""></span></h4>
					<div class="descrip_content" name="unitPrice" value=""></div>
					<div class="descrip_content" name="deliverable" value=""></div>
					<div type="hidden" name="chefNo" value=""></div>
					<div type="hidden" name="menuNo" value=""></div>
				</div>
			</div>
		</div>
	</div>

	<div id="default" style="display: none;" class="card horizontal">
		<div class="card-image">
			<img name="menuPic" src="">
		</div>
		<div class="card-stacked">
			<div class="card-content">
				<div class="descrip_title" name="timeSlot">已選取餐點</div>
				<h4><span name="mainCourse" value=""></span></h4>
				<div class="descrip_content" name="unitPrice" value=""></div>
				<div class="descrip_content" name="deliverable" value=""></div>
				<div type="hidden" name="chefNo" value=""></div>
				<div type="hidden" name="menuNo" value=""></div>
			</div>
		</div>
	</div>
	
	<input class="btn btn-primary" type="button" style="visibility:hidden" id="shelf" value="進入下架模式"/>

	<c:forEach var="menuVO" items="${menu}">  
		<div class="card horizontal" onclick="passValue(this)">
			<div class="card-image">
				<img src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=${menuVO.menuNo}">
			</div>
			<div class="card-stacked">
				<div class="card-content">
					<div class="descrip_title" name="timeSlot">基本餐點</div>
					<h4><span name="mainCourse" value="${menuVO.mainCourse}">${menuVO.mainCourse}</span></h4>
					<div class="descrip_content" name="unitPrice" value="${menuVO.unitPrice}">${menuVO.unitPrice}元</div>
					<div class="descrip_content" name="deliverable" value="${menuVO.deliverable}">${menuVO.deliverable}</div>
					<%-- <input type="hidden" name="chefNo" value="${menuVO.chefNo}"/> --%>
					<input type="hidden" name="menuNo" value="${menuVO.menuNo}"/>
				</div>
			</div>
		</div>
	</c:forEach>
		
</div>
<div class="col-sm-10">
	<div id="calendar_print_view_main_div">
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-4">
				<td id="prev_link">
			      <form class="monthControll" method="post" action="menulist.do">
			        <button type="submit" class="btn btn-default" aria-label="Left Align" name="PREV">
			        	<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			        </button>
			        <input type="hidden" name="chefNo" value="CHEF0001">
			        <input type="hidden" name="action" value="For_Update">
			        <input type="hidden" name="month" value="<%=prevMonth%>">
			        <input type="hidden" name="year" value="<%=prevYear%>">
			      </form>
			    </td>
			</div>
			<div class="col-xs-12 col-sm-4">
				<td colspan="7" class="month_year_header">
			      <h2><%=monthName%>, <%=intYear%></h2>
			    </td>
			</div>
			<div class="col-xs-12 col-sm-4">
				<td id="next_link">
			      <form class="monthControll" method="post" action="menulist.do">
			        <button type="submit" class="btn btn-default" aria-label="Left Align" name="NEXT">
			        	<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			        </button>
			        <input type="hidden" name="chefNo" value="CHEF0001">
			        <input type="hidden" name="action" value="For_Update">
			        <input type="hidden" name="month" value="<%=nextMonth%>">
			        <input type="hidden" name="year" value="<%=nextYear%>">
			      </form>
			    </td>
			</div>
		</div>
	</div>
	<table border="1" cellspacing="0" cellpadding="4" width="100%" height="100%" id="calendar_table">

	  <tr class="week_header_row">
	    <th width="15%" class="th_day_cell day">Sun</th>
	    <th width="14%" class="th_day_cell day">Mon</th>
	    <th width="14%" class="th_day_cell day">Tue</th>
	    <th width="14%" class="th_day_cell day">Wed</th>
	    <th width="14%" class="th_day_cell day">Thu</th>
	    <th width="14%" class="th_day_cell day">Fri</th>
	    <th width="15%" class="th_day_cell day">Sat</th>
	  </tr>
	<%
	{Month aMonth = Month.getMonth( Integer.parseInt(currentMonthString), Integer.parseInt(currentYearString) );
	  int [][] days = aMonth.getDays();
	  for( int i=0; i<aMonth.getNumberOfWeeks(); i++ ){
		%><tr class="week_data_row"><%
	    for( int j=0; j<7; j++ ){
	      if( days[i][j] == 0 ){
	        %><td class="empty_day_cell">&nbsp;</td><%
	      } else {
	        // this is "today"
	        if( currentDayInt == days[i][j] && currentMonthInt == aMonth.getMonth() && currentYearInt == aMonth.getYear() ){
	          %><td class="today_cell"><div><%=days[i][j]%></div>
	          	<div>
	          	<%	List<MenuListVO> tempMenuListVO = new ArrayList<MenuListVO>();
	          		StringBuilder timeFlag = new StringBuilder();
	          		for(MenuListVO menuListVO : menuList){
	       				if(menuListVO.getMenuDate().getDate() == days[i][j] && menuListVO.getMenuDate().getMonth()+1 == intMonth+1 && menuListVO.getMenuDate().getYear()+1900 == intYear) {
	     					tempMenuListVO.add(menuListVO);
	     					timeFlag.append(menuListVO.getMenuTimeSlot());
	       				}
	       			}
	          		
	          		switch(timeFlag.toString()){
	          		case "早午晚":
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			break;
	          		case "早午":
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          			break;	
	          		case "午晚":
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
						for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			break;	
	          		case "早晚":
	          			int flag = 0;
						for(MenuListVO menuListVO : tempMenuListVO){
		          			for(MenuVO menuVO : menu){
		          				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
		          					if(flag == 0){
		          						%><div class="card horizontal" onclick="setMenu(this)">
			          			            <div class="card-image">
		              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
		              			            </div>
		              			            <div class="card-stacked">
		              			              <div class="card-content">
		              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
		              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
		              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
		              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
		              			                <form>
			              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
			              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
			              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
			              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
			              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
			              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
		              			                </form>
		              			              </div>
		              			            </div>
			          			          </div>
			          			          <div class="card horizontal" onclick="setMenu(this)">
								            <div class="card-image">
								              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
								            </div>
								            <div class="card-stacked">
				      			              <div class="card-content">
				      			              	<div class="descrip_title" name="timeSlot">午餐</div>
				      			                <h5><span name="mainCourse"></span></h5>
				      			                <div class="descrip_content" name="unitPrice"></div>
				      			                <div class="descrip_content" name="deliverable"></div>
				      			                <form>
					       			                <input type="hidden" name="menuListNo" value=""/>
					       			                <input type="hidden" name="menuNo" value=""/>
					       			                <input type="hidden" name="menuTimeSlot" value="午"/>
					       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
					       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
					       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
				      			                </form>
				      			              </div>
				      			            </div>
								          </div>
			          					<%	flag++;
		          					} else {
		          						%><div class="card horizontal" onclick="setMenu(this)">
			          			            <div class="card-image">
		              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
		              			            </div>
		              			            <div class="card-stacked">
		              			              <div class="card-content">
		              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
		              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
		              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
		              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
		              			                <form>
			              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
			              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
			              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
			              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
			              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
			              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
		              			                </form>
		              			              </div>
		              			            </div>
			          			          </div>
			          					<%
		          					}
		          				}   						
		          			}
		          		}
	          			break;	
	          		case "早":
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	              		%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">午餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="午"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
	    					<%
	          			break;	
	          		case "午":
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
						%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          			break;	
	          		case "晚":
	              		%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">午餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="午"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
	    					<%
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			break;
	          		default:
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">午餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="午"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          		}
	          	%>
	          </div>
	          </td><%
	        } else {
	          %><td class="day_cell"><div><%=days[i][j]%></div>
	          <div>
	          	<%	List<MenuListVO> tempMenuListVO = new ArrayList<MenuListVO>();
	          		StringBuilder timeFlag = new StringBuilder();
	          		for(MenuListVO menuListVO : menuList){
	       				if(menuListVO.getMenuDate().getDate() == days[i][j] && menuListVO.getMenuDate().getMonth()+1 == intMonth+1 && menuListVO.getMenuDate().getYear()+1900 == intYear) {
	     					tempMenuListVO.add(menuListVO);
	     					timeFlag.append(menuListVO.getMenuTimeSlot());
	       				}
	       			}
	          		
	          		switch(timeFlag.toString()){
	          		case "早午晚":
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			break;
	          		case "早午":
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          			break;	
	          		case "午晚":
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
						for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			break;	
	          		case "早晚":
	          			int flag = 0;
						for(MenuListVO menuListVO : tempMenuListVO){
		          			for(MenuVO menuVO : menu){
		          				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
		          					if(flag == 0){
		          						%><div class="card horizontal" onclick="setMenu(this)">
			          			            <div class="card-image">
		              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
		              			            </div>
		              			            <div class="card-stacked">
		              			              <div class="card-content">
		              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
		              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
		              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
		              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
		              			                <form>
			              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
			              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
			              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
			              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
			              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
			              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
		              			                </form>
		              			              </div>
		              			            </div>
			          			          </div>
			          			          <div class="card horizontal" onclick="setMenu(this)">
								            <div class="card-image">
								              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
								            </div>
								            <div class="card-stacked">
				      			              <div class="card-content">
				      			              	<div class="descrip_title" name="timeSlot">午餐</div>
				      			                <h5><span name="mainCourse"></span></h5>
				      			                <div class="descrip_content" name="unitPrice"></div>
				      			                <div class="descrip_content" name="deliverable"></div>
				      			                <form>
					       			                <input type="hidden" name="menuListNo" value=""/>
					       			                <input type="hidden" name="menuNo" value=""/>
					       			                <input type="hidden" name="menuTimeSlot" value="午"/>
					       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
					       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
					       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
				      			                </form>
				      			              </div>
				      			            </div>
								          </div>
			          					<%	flag++;
		          					} else {
		          						%><div class="card horizontal" onclick="setMenu(this)">
			          			            <div class="card-image">
		              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
		              			            </div>
		              			            <div class="card-stacked">
		              			              <div class="card-content">
		              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
		              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
		              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
		              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
		              			                <form>
			              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
			              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
			              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
			              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
			              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
			              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
		              			                </form>
		              			              </div>
		              			            </div>
			          			          </div>
			          					<%
		          					}
		          				}   						
		          			}
		          		}
	          			break;	
	          		case "早":
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	              		%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">午餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="午"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
	    					<%
	          			break;	
	          		case "午":
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
						%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          			break;	
	          		case "晚":
	              		%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">午餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="午"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
	    					<%
	          			for(MenuListVO menuListVO : tempMenuListVO){
	              			for(MenuVO menuVO : menu){
	              				if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
	              					%><div class="card horizontal" onclick="setMenu(this)">
	              			            <div class="card-image">
	              			              <img name="menuPic" src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
	              			            </div>
	              			            <div class="card-stacked">
	              			              <div class="card-content">
	              			              	<div class="descrip_title" name="timeSlot"><%=menuListVO.getMenuTimeSlot()%>餐</div>
	              			                <h5><span name="mainCourse"><%=menuVO.getMainCourse()%></span></h5>
	              			                <div class="descrip_content" name="unitPrice"><%=menuVO.getUnitPrice()%>元</div>
	              			                <div class="descrip_content" name="deliverable"><%=menuVO.getDeliverable()%></div>
	              			                <form>
		              			                <input type="hidden" name="menuListNo" value="<%=menuListVO.getMenuListNo()%>"/>
		              			                <input type="hidden" name="menuNo" value="<%=menuListVO.getMenuNo()%>"/>
		              			                <input type="hidden" name="menuTimeSlot" value="<%=menuListVO.getMenuTimeSlot()%>"/>
		              			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
		              			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
		              			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
	              			                </form>
	              			              </div>
	              			            </div>
	              			          </div>
	              					<%
	              				}   						
	              			}
	              		}
	          			break;
	          		default:
	          			%><div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">早餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="早"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">午餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="午"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
				          <div class="card horizontal" onclick="setMenu(this)">
				            <div class="card-image">
				              <img name="menuPic" src="<%=request.getContextPath()%>/Imgs/Menu/nullpic.jpg">
				            </div>
				            <div class="card-stacked">
      			              <div class="card-content">
      			              	<div class="descrip_title" name="timeSlot">晚餐</div>
      			                <h5><span name="mainCourse"></span></h5>
      			                <div class="descrip_content" name="unitPrice"></div>
      			                <div class="descrip_content" name="deliverable"></div>
      			                <form>
	       			                <input type="hidden" name="menuListNo" value=""/>
	       			                <input type="hidden" name="menuNo" value=""/>
	       			                <input type="hidden" name="menuTimeSlot" value="晚"/>
	       			                <input type="hidden" name="menuDay" value="<%=days[i][j]%>"/>
	       			                <input type="hidden" name="menuMonth" value="<%=intMonth+1%>"/>
	       			                <input type="hidden" name="menuYear" value="<%=intYear%>"/>
      			                </form>
      			              </div>
      			            </div>
				          </div>
						<%
	          		}
	          	%>
	          </div></td><%
	        }
	      } // end outer if
	    } // end for%></tr><%
	  }
	}
	%>
	</table>
	</div><%-- end of "calendar_div" --%>
	
</div>
</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>	

</body>
</html>


