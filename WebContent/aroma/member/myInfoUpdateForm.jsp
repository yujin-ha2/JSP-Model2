<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="net.member.db.MemberBean"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.p1{
	font-size: 20px; font-weight: bold; color: black; margin-bottom: 0;
	}
.p2{
	margin-top: 0; font-size: 15px;
}
</style>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop - Checkout</title>
	<link rel="icon" href="img/Fevicon.png" type="image/png">

  <link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="vendors/linericon/style.css">
  <link rel="stylesheet" href="vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="vendors/nouislider/nouislider.min.css">

  <link rel="stylesheet" href="css/style.css">
  
  <script type="text/javascript">
	function check(f) {
		 if(f.email.value==""){
	    	document.getElementById('emailck').innerHTML='이메일은 반드시 입력해야합니다.';
	    	f.email.focus();
	    	return false;
	    	
		}else if(f.phone.value==""){
	    	document.getElementById('phoneck').innerHTML='휴대폰번호는 반드시 입력해야합니다.';
	    	f.phone.focus();
	    	return false;
		
	    }
	}	
	</script>
	</head>
	<body>
  <!--================ Start Header Menu Area =================-->
		<jsp:include page="../top1.jsp" />
	<!--================ End Header Menu Area =================-->

	<!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="category">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>프로젝트 준비</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
			            <ol class="breadcrumb">
			              <li class="breadcrumb-item active" aria-current="page">메이커님의 간단한 정보를 등록해주세요!</li>
			            </ol>
          			</nav>
				</div>
			</div>
    	</div>
	</section>
	<!-- ================ end banner area ================= -->
  
    <div class="col-lg-8" style="padding-left:700px"><br>
        <p class="p1" align="center">회원정보 수정</p>
        	<hr>
        	
         	<form class="row contact_form" method="post" id="f" action="MyInfoUpdate.me" onsubmit ="return check(this);">
	            <div class="col-md-12 form-group">
	            	<h6><i class="fa fa-user"></i> 아이디</h6>
	            	<c:set var="member" value="${requestScope.mb}"/>
	                <input type="text" class="form-control" name="id" value="${member.id}" readonly="readonly">
	            </div>
            	
    		 	<div class="col-md-12 form-group">
    		 		<h6><i class="fa fa-lock"></i> 이름</h6>
           			<input type="text" class="form-control" name="name"  value="${member.name}" readonly="readonly" >
         			<span id="nameck" style="color: red;"></span>
           		</div>
            
	            <div class="col-md-12 form-group">
	                <h6><i class="fa fa-envelope"></i> 이메일</h6>
	                <input type="text" class="form-control" name="email" value="${member.email}">                         
	            	<span id="emailck" style="color: red;"></span>
	            </div>
	            
	            <div class="col-md-12 form-group">
	            	<h6>
	            	<i class="fa fa-mobile" aria-hidden="true"></i>
	            	 핸드폰 번호</h6>
	                <input type="text" class="form-control" name="phone" value="${member.phone}">                         
	            	<span id="phoneck" style="color: red;"></span>
	            </div>
	            
	             <div class="col-md-12 form-group" align="center" style="margin-bottom: 50px;">
	          	 	<button type="submit" value="submit" class="button button-tracking">수정완료</button>
	          	 	<!-- <button type="submit" value="submit" class="button button-tracking">취소하기</button> -->
	      		 </div>
        </form>
    </div>


  <!--================ Start footer Area  =================-->	
  <jsp:include page="../bottom.jsp" />
  <!--================ End footer Area  =================-->



  <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="vendors/skrollr.min.js"></script>
  <script src="vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="vendors/jquery.ajaxchimp.min.js"></script>
  <script src="vendors/mail-script.js"></script>
  <script src="js/main.js"></script>
</body>
</html>