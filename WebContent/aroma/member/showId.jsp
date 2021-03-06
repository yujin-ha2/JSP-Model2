<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop - Checkout</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="icon" href="${contextPath}/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nouislider/nouislider.min.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  
  <style type="text/css">
  .p1{
	  font-size: 20px; font-weight: bold; color: black; margin-bottom: 0;
	 }
  .p2{
	  margin-top: 0; font-size: 15px;
  }
  </style>
</head>
<body>
	<jsp:include page="../top1.jsp" />
  
    <div class="col-lg-8" style="padding-left:700px"><br>
        <p class="p1" align="center">아이디 찾기</p>
        <hr>
		<div class="col-md-12 form-group p_star" style="margin-bottom: 0px;">
        	<h6><i class="fa fa-envelope"></i>회원님의 아이디는?</h6>
        </div>
        <div class="col-md-12 form-group p_star">
            <input type="text" class="form-control" name="id"  value="${id}" readonly="readonly">                       
        </div>
           
        <div class="col-md-12 form-group" align="center" style="margin-bottom: 50px;">
        	<a href="MemberLogin.me">로그인하기</a> / <a href="FindPwdForm.me">비밀번호 찾기</a>
      	</div>
    </div>


  <jsp:include page="../bottom.jsp" />

  <script src="${contextPath}/vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="${contextPath}/vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="${contextPath}/vendors/skrollr.min.js"></script>
  <script src="${contextPath}/vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="${contextPath}/vendors/jquery.ajaxchimp.min.js"></script>
  <script src="${contextPath}/vendors/mail-script.js"></script>
  <script src="${contextPath}/js/main.js"></script>
</body>
</html>