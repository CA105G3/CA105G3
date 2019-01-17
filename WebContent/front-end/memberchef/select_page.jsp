<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<title></title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>IBM Chef: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Chef: Home</p>

<h3>資料查詢:</h3>
	


<ul>
  <li><a href='listAllChef.jsp'>List</a> all Chefs.  <br><br></li>
  
  
  <li>
    <FORM METHOD="get" ACTION="memberchef.do" >
        <b>輸入廚師編號 (如CHEF0001):</b>
        <input type="text" name="chefNo">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
    <FORM METHOD="post" ACTION="chefOrder.do" >
        <b>查詢訂單：輸入廚師編號 (如CHEF0001):</b>
        <input type="text" name="chefNo" value="CHEF0001">
        <input type="hidden" name="action" value="getOrder">
        <input type="submit" value="送出">
    </FORM>
  </li>
</ul>

<ul>
  <li><a href='addChef.jsp'>Add</a> a new Chef.</li>
</ul>

</body>
</html>