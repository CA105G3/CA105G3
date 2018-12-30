<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.memberchef.model.*"%>

<%
	MemberChefVO chefVO = (MemberChefVO) request.getAttribute("chefVO");
%>
<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="robots" content="noindex, nofollow">

    <title>廚師基本資料</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <link href="css/memberchef.css" rel="stylesheet">
    <script src="css/jquery.min.js"></script>
    <script src="css/bootstrap.min.js"></script>
    <script type="text/javascript">
        window.alert = function(){};
        var defaultCSS = document.getElementById('bootstrap-css');
        function changeCSS(css){
            if(css) $('head > link').filter(':first').replaceWith('<link rel="stylesheet" href="'+ css +'" type="text/css" />'); 
            else $('head > link').filter(':first').replaceWith(defaultCSS); 
        }
        $( document ).ready(function() {
          var iframe_height = parseInt($('html').height()); 
          window.parent.postMessage( iframe_height, 'https://bootsnipp.com');
        });
    </script>
</head>
<body>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message.value}</li>
		</c:forEach>
	</ul>
</c:if>

<div class="container emp-profile">
    <form method="post" ACTION="memberchef.do" name="form1" enctype="multipart/form-data">
        <div class="row">
            <div class="col-md-4">
                <div class="profile-img">
                    <img src="<%=request.getContextPath()%>/memberchef/memberchefImg.do?chefno=<%=chefVO.getChefNo()%>" id="preview"/>
                    <div class="file btn btn-lg btn-primary">
                        Select Photo
                        <input type="file" name="chefPic" accept="image/*" onchange="readURL(this);" value="<%=chefVO.getChefPic()%>"/>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="profile-head">
                    <h5>
                        <input type="TEXT" name="chefStoreName" size="20" placeholder="請輸入顯示商店名稱"  value="<%=chefVO.getChefStoreName()%>"/>
                        <div class="errMsg">${errorMsgs.chefStoreName}</div>
                    </h5>
                    <h6>
                        <textarea style="border:none" name="chefDescrip" rows="7" cols="50" placeholder="請輸入40個字以內的簡介"><%=chefVO.getChefDescrip()%></textarea>
                        <div class="errMsg">${errorMsgs.chefDescrip}</div>
                    </h6>
                    <p></p>
                    
                </div>
            </div>
            <div class="col-md-2">
                <input type="hidden" type="button" class="profile-edit-btn" name="btnAddMore" value="Edit Profile"/>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="profile-work">
                    <p>MENU</p>
                    <a href="">基本資料</a><br/>
                    <a href="">基本菜單管理</a><br/>
                    <a href="">上架菜單管理</a><br/>
                    <a href="">訂單管理</a><br/>
                </div>
            </div>
            <div class="col-md-8">
                <div class="tab-content profile-tab" id="myTabContent">
                	<ul class="nav nav-tabs" id="myTab" role="tablist" style="margin-bottom: 20px;">
                        <li class="nav-item">
                            <a class="nav-link" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">會員基本資料</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">廚師基本資料</a>
                        </li>
                    </ul>
                    <div></div>
                    <div class="tab-pane fade" id="home" role="tabpanel" aria-labelledby="home-tab">
                        <div class="row">
                            <div class="col-md-4">
                                <label>User Id</label>
                            </div>
                            <div class="col-md-8">
                                <p>Kshiti123</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>Name</label>
                            </div>
                            <div class="col-md-8">
                                <p>Kshiti Ghelani</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>Email</label>
                            </div>
                            <div class="col-md-8">
                                <p>kshitighelani@gmail.com</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>Phone</label>
                            </div>
                            <div class="col-md-8">
                                <p>123 456 7890</p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>Profession</label>
                            </div>
                            <div class="col-md-8">
                                <p>Web Developer and Designer</p>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                        <div class="row">
                            <div class="col-md-4">
                                <label>廚師編號</label>
                            </div>
                            <div class="col-md-8">
                                <td>
                                    "<%=chefVO.getChefNo()%>"
                                </td>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>廚師姓名</label>
                            </div>
                            <div class="col-md-8">
                                <input type="TEXT" name="chefName" size="45" placeholder="請輸入廚師姓名" 
                                value="<%=chefVO.getChefName()%>"/>
                                <div class="errMsg">${errorMsgs.chefName}</div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>地址</label>
                            </div>
                            <div class="col-md-8">
                                <input type="TEXT" name="chefAddr" size="45" placeholder="請輸入地址" 
                                value="<%=chefVO.getChefAddr()%>"/>
                                <div class="errMsg">${errorMsgs.chefAddr}</div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>電話</label>
                            </div>
                            <div class="col-md-8">
                                <input type="TEL" name="chefPhone" size="45" placeholder="請輸入電話" 
                                value="<%=chefVO.getChefPhone()%>"/>
                                <div class="errMsg">${errorMsgs.chefPhone}</div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>負責人</label>
                            </div>
                            <div class="col-md-8">
                                <input type="TEXT" name="chefRep" size="45" placeholder="請輸入負責人" 
                                value="<%=chefVO.getChefRep()%>"/>
                                <div class="errMsg">${errorMsgs.chefRep}</div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>狀態</label>
                            </div>
                            <div class="col-md-8">
                                "<%=chefVO.getChefStatus()%>"
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="chefNo" value="<%=chefVO.getChefNo()%>">
                                <input type="hidden" name="memNo" value="<%=chefVO.getMemNo()%>">
                                <button type="submit" class="small button">送出修改</button>
                                <button type="reset" class="small button">清空重填</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>           
</div>
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>              

<script>
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#preview').attr('src', e.target.result);
        };

        reader.readAsDataURL(input.files[0]);
    }
}
</script>
</body>
</html>