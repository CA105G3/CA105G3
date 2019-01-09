<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  <title>devdaily.com calendar</title>
  
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
h5 {
    display: block;
    margin-block-start: 0.1em;
    margin-block-end: 0.5em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
}

</style>
</head>
<body id="print_view_page">

<div id="calendar_print_view_main_div">
<table border="1" cellspacing="0" cellpadding="4" width="100%" height="100%" id="calendar_table">
  <tr>
    <td width="100%" colspan="7" class="month_year_header">
      <%=intMonth+1%>,<%=monthName%>, <%=intYear%> ,<%=prevYear%> ,<%=nextYear%>
    </td>
  </tr>
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
          %><td class="today_cell"><%=days[i][j]%>
          	<div>
          	<%	for(MenuListVO menuListVO : menuList){
       				if(menuListVO.getMenuDate().getDate() == days[i][j] && menuListVO.getMenuDate().getMonth()+1 == intMonth+1 && menuListVO.getMenuDate().getYear()+1900 == intYear) {
     					for(MenuVO menuVO : menu){
							if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
								%><div class="card horizontal">
						            <div class="card-image">
						              <img src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
						            </div>
						            <div class="card-stacked">
						              <div class="card-content">
						                <h5><%=menuVO.getMainCourse()%></h5><span><%=menuListVO.getMenuTimeSlot()%>餐</span>
						                <span><%=menuVO.getUnitPrice()%>元</span><span><%=menuVO.getDeliverable()%></span>
						                <input type="hidden" class="btn btn-styled"/>
						              </div>
						            </div>
						          </div>
								<%
							}   						
     					}//end for menu
       				}
       			} //end for menulist
          	%>
          </div>
          </td><%
        } else {
          %><td class="day_cell"><div><%=days[i][j]%></div>
          <div>
          	<%	for(MenuListVO menuListVO : menuList){
       				if(menuListVO.getMenuDate().getDate() == days[i][j] && menuListVO.getMenuDate().getMonth()+1 == intMonth+1 && menuListVO.getMenuDate().getYear()+1900 == intYear) {
     					for(MenuVO menuVO : menu){
							if(menuListVO.getMenuNo().equals(menuVO.getMenuNo())){
								%><div class="card horizontal">
						            <div class="card-image">
						              <img src="<%=request.getContextPath()%>/front-end/menu/menuImg.do?menuNo=<%=menuVO.getMenuNo()%>">
						            </div>
						            <div class="card-stacked">
						              <div class="card-content">
						                <h5><%=menuVO.getMainCourse()%></h5><span><%=menuListVO.getMenuTimeSlot()%>餐</span>
						                <span><%=menuVO.getUnitPrice()%>元</span><span><%=menuVO.getDeliverable()%></span>
						                <input type="hidden" class="btn btn-styled"/>
						              </div>
						            </div>
						          </div>
								<%
							}   						
     					}//end for menu
       				}
       			} //end for menulist
          	%>
          </div></td><%
        }
      } // end outer if
    } // end for%></tr><%
  }
}
%>
</table>

<%-- end of "calendar_div" --%>
</div>

<!-- navigation links -->
<%-- sorry, i don't know how to get this look without a table --%>
<table id="calendar_nav_table" border="0">
  <tr>
    <td id="prev_link">
      <form method="post" action="menulist.do">
        <input type="submit" name="PREV" value=" << ">
        <input type="text" name="chefNo" value="CHEF0001">
        <input type="hidden" name="action" value="For_Display">
        <input type="hidden" name="month" value="<%=prevMonth%>">
        <input type="hidden" name="year" value="<%=prevYear%>">
      </form>
    </td>
    <td id="next_link">
      <form method="post" action="menulist.do">
        <input type="submit" name="NEXT" value=" >> ">
        <input type="text" name="chefNo" value="CHEF0001">
        <input type="hidden" name="action" value="For_Display">
        <input type="hidden" name="month" value="<%=nextMonth%>">
        <input type="hidden" name="year" value="<%=nextYear%>">
      </form>
    </td>
  </tr>
</table>
  <!-- navigation links end -->

</body>
</html>


