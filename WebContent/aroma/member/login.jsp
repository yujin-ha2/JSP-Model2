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
  
  	<!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="category" style="height: 150px;">
		<div class="container h-100">
			<div class="blog-banner" style="top: 85%;">
				<div class="text-center">
					<h1>로그인</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
		            <ol class="breadcrumb">
		              <li class="breadcrumb-item"><a href="#">GoodFunding Login</a></li>
		            </ol>
		         	</nav>
				</div>
			</div>
    	</div>
	</section>
	<!-- ================ end banner area ================= -->
  
 	<!--================Login Box Area =================-->
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="login_box_img">
						<div class="hover">
							<h4>아직 굿펀딩 회원이 아니세요?</h4>
							<p>굿펀딩 회원이 되어 세상의 모든 펀딩을 누려보세요!</p>
							<a class="button button-account" href="register.jsp">회원 가입하러 가기</a>
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="login_form_inner">
						<h3>Log in to enter</h3>
						<form class="row login_form" action="./MemberLoginAction.me" id="contactForm" >
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="id" name="id" placeholder="ID를 입력하세요" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Username'">
							</div>
							<div class="col-md-12 form-group">
								<input type="password" class="form-control" id="pwd" name="pwd" placeholder="비밀번호(영문,숫자,특수 문자 포함 8자 이상)" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Password'">
							</div>
							<!-- <div class="col-md-12 form-group">
								<div class="creat_account">
									<input type="checkbox" id="f-option2" name="selector">
									<label for="f-option2">아이디 저장</label>
								</div>
							</div> -->
							<div class="col-md-12 form-group">
								<button type="submit" value="submit" class="button button-login w-100">Log In</button>
								<div style="padding-top: 30px;">
									<a href="FindIdForm.me">아이디 </a> / 
									<a href="FindPwdForm.me">비밀번호 찾기</a>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================End Login Box Area =================-->

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