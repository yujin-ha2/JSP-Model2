<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>GoodFunding</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
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
							<a class="button button-account" href="${contextPath}/join.me">회원 가입하러 가기</a>
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="login_form_inner">
						<h3>Log in to enter</h3>
						<form class="row login_form" action="${contextPath}/loginAction.me" id="contactForm" >
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="id" name="id" placeholder="ID를 입력하세요" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Username'">
							</div>
							<div class="col-md-12 form-group">
								<input type="password" class="form-control" id="pwd" name="pwd" placeholder="비밀번호(영문,숫자,특수 문자 포함 8자 이상)" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Password'">
							</div>
							<div class="col-md-12 form-group">
								<button type="submit" value="submit" class="button button-login w-100">Log In</button>
								<div style="padding-top: 30px;">
									<a href="findIdPwd.me">아이디  / 비밀번호 찾기</a>  
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
</body>
</html>