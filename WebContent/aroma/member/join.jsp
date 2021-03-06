<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>GoodFunding</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script type="text/javascript" src="${contextPath}/js/join.js"></script>
</head>
<body>
  <jsp:include page="../top1.jsp" />
  
  <!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="category" style="height: 150px;">
		<div class="container h-100">
			<div class="blog-banner" style="top: 85%;">
				<div class="text-center">
					<h1>회원가입</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
         		 </nav>
				</div>
			</div>
   		</div>
	</section>
  
  	<!-- ================Login Box Area =================== -->
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="login_box_img">
						<div class="hover">
							<h4>이미 굿펀딩의 회원이신가요?</h4>
							<p>로그인하여 새롭게 올라온 펀딩을 확인 해 보세요!</p>
							<a class="button button-account" href="login.me">로그인하러 가기</a>
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="login_form_inner register_form_inner">
						<form class="row login_form" action="${contextPath}/joinAction.me" onsubmit="return checkForm(this);" id="register_form" style="margin-top: -50px">
				  			<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="id" name="id" placeholder="Enter ID">
								<span id="id_ck" style="color: red;"></span>
							</div>
				  			<div class="col-md-12 form-group">
								<input type="password" class="form-control" id="pwd" name="pwd" placeholder="Enter Pass">
								<span id="pwd_ck" style="color: red;"></span>
				  			</div>
				  			<div class="col-md-12 form-group">
								<input type="password" class="form-control" id="pwd_confirm" name="pwd-repeat" placeholder="Repeat Pass">
								<span id="pwd_confirm_ck" style="color: red;"></span>
	             			</div>
	              			<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="name" name="name" placeholder="Enter Name">
								<span id="name_ck" style="color: red;"></span>
	              			</div>
	              			<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="phone" name="phone" placeholder="Enter Phone">
								<span id="phone_ck" style="color: red;"></span>
							</div>
				  			<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="email" name="email" placeholder="Enter Email">
							    <span id="email_ck" style="color: red;"></span>
							</div>
							<div class="col-md-12 form-group">
								<button type="submit" value="submit" class="button button-register w-100">가입하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>

	<jsp:include page="../bottom.jsp" />

</body>
</html>