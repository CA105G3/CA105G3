<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.memberchef.model.*"%>

<%
  MemberChefVO chefVO = (MemberChefVO) request.getAttribute("chefVO"); //MemberChefServlet.java(Concroller), 存入req的MemberChefVO物件
%>
<!DOCTYPE html>
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
    

</head>
<body style="background-color:white;">
 <div class="container emp-profile">
    <form method="post">
        <div class="row">
            <div class="col-md-4">
                <div class="profile-img">
                    <img src="<%=request.getContextPath()%>/front-end/memberchef/memberchefImg.do?chefNo=${chefVO.chefNo}" alt=""/>
                </div>
            </div>
            <div class="col-md-6">
                <div class="profile-head">
                    <h5>
                        <%=chefVO.getChefStoreName()%>
                    </h5>
                    <h6>
                        <%=chefVO.getChefDescrip()%>
                    </h6>
                    <p></p>
                    
                </div>
            </div>
            <div class="col-md-2">
                <input type="hidden" name="chefNo" value="<%=chefVO.getChefNo()%>">
                <input type="hidden" name="chefName" value="<%=chefVO.getChefName()%>">
                <input type="hidden" name="chefStoreName" value="<%=chefVO.getChefStoreName()%>">
                <input type="hidden" name="action" value="getOne_For_Update">
                <input type="submit" class="profile-edit-btn" name="btnAddMore" value="Edit Profile"/>
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
                                <%=chefVO.getChefNo()%>    
                                </td>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>廚師姓名</label>
                            </div>
                            <div class="col-md-8">
                                <p><%=chefVO.getChefName()%></p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>地址</label>
                            </div>
                            <div class="col-md-8">
                                <p><%=chefVO.getChefAddr()%></p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>電話</label>
                            </div>
                            <div class="col-md-8">
                                <p><%=chefVO.getChefPhone()%></p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>負責人</label>
                            </div>
                            <div class="col-md-8">
                                <p><%=chefVO.getChefRep()%></p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <label>狀態</label>
                            </div>
                            <div class="col-md-8">
                                <p><%=chefVO.getChefStatus()%></p>
                            </div>
                        </div>
                        <div class="row">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>           
</div>
</body>
</html>
