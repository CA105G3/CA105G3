<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ page import="com.menulist.model.*" %>

<html>
<head>
<meta charset="UTF-8">
<title>�\���~���\�I�C��  - listAllMenuByChef.jsp</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

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
</style>
<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>
</head>
<body>

<table id="table-1">
	<!--<img src="images/food_header.jpg">  -->
	<tr><td>
		<h3>�\���~���\�I�C��</h3>
		<h4><a href="<%=request.getContextPath() %>/front-end/searchPage/select_page.jsp"><img src="<%=request.getContextPath() %>/front-end/searchPage/images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>
	<form name="menuForm" action="/CA105G3/shoppingCart.do" method="POST">
<table id="table-1">
	<tr>
		<th width="90">�~��</th>
		<th width="140">�\�I�W��</th>
		<th width="130">���\�ɬq</th>
		<th width="90">���</th>
		<th width="90">�ƶq</th>
		<th width="70"><img src="<%=request.getContextPath() %>/front-end/searchPage/images/shopping-cart.png" width ="45px" height ="35px"></th>
	</tr></table>
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<table>
	<c:forEach var="menuListVO" items="${menuListVOList}"> 
		<tr>
		<form name="menuForm" action="/CA105G3/shoppingCart.do" method="POST">
			<td width="90"><div align="center">${menuListVO.chefRep}</div></td>
			<td width="140"><div align="center">${menuListVO.mainCourse}</div></td>
			<td width="130"><div align="center">${menuListVO.menuTimeSlot}</div></td>
			<td width="90"><div align="center">${menuListVO.unitPrice}</div></td>
			<td width="90"><div align="center"><input type="text" name="amount" size="3" value=1></div></td>
			<td width="70"><div align="center"><input type="image" src="<%=request.getContextPath() %>/front-end/searchPage/images/plus.jpg" class="button" width="35" height="25"> </div></td>
			 <input type="hidden" name="chefRep" value="${menuListVO.chefRep}">
		     <input type="hidden" name="mainCourse" value="${menuListVO.mainCourse}">
		     <input type="hidden" name="menuTimeSlot" value="${menuListVO.menuTimeSlot}">
		     <input type="hidden" name="unitPrice" value="${menuListVO.unitPrice}">
		     <input type="hidden" name="chefNo" value="${menuListVO.chefNo}">
		     <input type="hidden" name="menuListNo" value="${menuListVO.menuListNo}">
		     <input type="hidden" name="action" value="ADD">
		</tr>
		 </form>
	</c:forEach>
</table>
 		

<form name="myShoppingCart" action="<%=request.getContextPath()%>/front-end/searchPage/shoppingCart.jsp" method="POST">
<!--       <input type="hidden" name="action"  value="myShoppingCart">  -->
      <input type="submit" value="�d�ݧڪ��ʪ���" class="button">
</form>
	
</body>
<!-- <script> -->
<!--  	var xhr = null; -->
	
<!-- 	function createXhr(){ -->
<!-- 		if(window.XMLHttpRequest){ -->
<!-- 			xhr = new XMLHttpRequest(); -->
<!--  	}else{ -->
<!--  			xhr = new ActiveXObject("Microsoft.XMLHTTP"); -->
<!-- 		} -->
<!--  	} -->
	
<!--  	function addMenu(){ -->
<!--  		//����ݭn�[�J�ʪ����ӫ~�s�� -->
<!-- 		var ids = ""; -->
<!--  		var chefRep = document.getElementsByName("chefRep"); -->
<!-- 		for (var i = 0; i < chefRep.length; i++){ -->
<!-- 			if(chefRep[i].checked){ -->
<!--  				ids += chefRep[i].value + ","; -->
<!-- 		} -->
<!--  		} -->
<!-- 	//�s�u��O,�N�ӫ~�s��,�ǰe���O -->
<!-- 		createXhr();  //�}�ҳs�u -->
<%-- 		xhr.open("post", "<%=request.getServletPath()%>/shoppingCart.do", true); --%>
<!--  		xhr.setRequestHeader("content-type", "application/x-www-form-urlencoded"); -->

<!--  		var data = "action=ADD&ids="+ids; -->
<!-- 		xhr.send(data); -->
<!--  		xhr.onreadystatechange = function(){ -->
<!-- 			if(xhr.readyState==4 && xhr.status==200){ -->
<!-- 				if(xhr.responseText=="ok"){ -->
<!-- 					alert("�s�W���\!"); -->
<!-- 				}else{ -->
<!--  					alert("�s�W����!"); -->
<!--  				} -->
<!-- 			} -->
<!--  		} -->
<!--  	} -->
	
<!-- 	function allCheck(obj){ -->
<!-- 		var checkBoxList = document.getElementsByName("chefRep"); -->
<!-- 		if(obj.checked == true){ -->
<!-- 			for (var i = 0; i < checkBoxList.length; i++){ -->
<!-- 				checkBoxList[i].checked = true; -->
<!-- 			} -->
<!-- 		}else { -->
<!-- 			for (var i = 0; i < checkBoxList.length; i++){ -->
<!-- 				checkBoxList[i].checked = false; -->
<!-- 			} -->
<!-- 		} -->
<!-- 	} -->
	
</script> 
</html>