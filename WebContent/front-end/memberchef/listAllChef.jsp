<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.memberchef.model.*"%>    
    
<%
    MemberChefService chefSvc = new MemberChefService();
    List<MemberChefVO> list = chefSvc.getAll();
    pageContext.setAttribute("list",list);
%>    
    
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Title Page</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<!--[if lt IE 9]>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<link rel="stylesheet" href="css/animate.css">
<link rel="stylesheet" href="css/owl.carousel.min.css">
<link rel="stylesheet" href="css/owl.theme.default.min.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/style2.css">

<script>
</script>

</head>
<body>
	<div class="container">
    <div class="row">
      <div class="owl-carousel owl-theme" id="carousel-id">
      	<c:forEach var="chefVO" items="${list}">
	        <div class="item ">
	          <div class="card" onclick="location.href='<%=request.getContextPath()%>/front-end/memberchef/memberchef.do?action=getOne_For_Display&chefNo=${chefVO.chefNo}';">
	            <img class="card-img-top img-fluid" src="<%=request.getContextPath()%>/front-end/memberchef/memberchefImg.do?chefNo=${chefVO.chefNo}" alt="Card image cap">
	            <div class="card-body">
	              <h4 class="card-title">${chefVO.chefStoreName}</h4>
	              <p class="card-text">${chefVO.chefDescrip}</p>
	              <p class="card-text">by <h3>${chefVO.chefName}</h3>
	            </div>
	          </div>
	        </div>
        </c:forEach>
      </div>
    </div>
  </div>

	<script src="<%=request.getContextPath()%>/front-end/memberchef/js/jquery-3.3.1.min.js"></script>
	<script src="<%=request.getContextPath()%>/front-end/memberchef/js/owl.carousel.min.js"></script>
  
  <script type="text/javascript">
  $(document).ready(function(){
    $('.owl-carousel').owlCarousel({
        loop:true,
        margin:10,
        nav:true,
        responsive:{
            0:{
                items:1
            },
            600:{
                items:3
            },
            1000:{
                items:5
            }
        }
    })  
  });  
  </script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>