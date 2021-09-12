<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop - Login</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="icon" href="${contextPath}/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nouislider/nouislider.min.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <script type="text/javascript" src="${contextPath}/login.js"></script>
</head>
<body>
 <jsp:include page="../top1.jsp" />
	<div class="container">
		<input type="button" class="btn btn-default btn-lg" onclick="location.href='${contextPath}/MyInfoUpdateForm.me'" value="내 정보 변경" >
		<input type="button" class="btn btn-default btn-lg" onclick="location.href='${contextPath}/FindIdForm.me'" value="아이디 변경" >
		<input type="button" class="btn btn-default btn-lg" onclick="location.href='${contextPath}/FindPwdForm.me';" value="비밀번호 변경" >
		<input type="button" class="btn btn-default btn-lg" onclick="location.href='${contextPath}/MyInfoUpdateForm.me';" value="탈퇴" >
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