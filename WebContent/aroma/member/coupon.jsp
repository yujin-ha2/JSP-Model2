<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>나의 펀딩</title>
    
	<link rel="icon" href="img/Fevicon.png" type="image/png">
    <link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
	<link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
	<link rel="stylesheet" href="vendors/linericon/style.css">
    <link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
    <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
    <link rel="stylesheet" href="vendors/nice-select/nice-select.css">
    <link rel="stylesheet" href="vendors/nouislider/nouislider.min.css">
     	
    <link rel="stylesheet" href="css/style.css"> 
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<% 
	//세션id값 전달받기 
	String id=(String)session.getAttribute("id");
%>
<jsp:include page="../top1.jsp" />
  	  
  <!--================Order Details Area =================-->
   <section class="order_details section-margin--small">
    <div class="container">    	
      <div class="row mb-5">
    	  <div class="col-md-12">
    	  	<div class="my_funding">
    	  	  	<h2>쿠폰</h2>  	                
	        </div>
	        <hr>
	        <div class="row mb-5">
	        	<div class="col-md-12">
	        	<!-- Example single danger button -->
					<div class="coupon"> 
					  <img alt="쿠폰로고" src="img/쿠폰 로고.jpg">					  
					</div>
	        	</div>
	        </div> 
	        <div class="row mb-5">
	        	<div class="col-md-12">
	        	<!-- Example single danger button -->
					<div class="coupon">
					  <img alt="쿠폰" src="img/쿠폰.jpg">					  
					</div>
	        	</div>
	        </div> 
          </div> <!-- col-md-12 -->          	     
      </div> <!-- row mb-5 끝 -->                    	
	  <div class="row mb-5">
	      <div class="col-md-12" style="text-align: left; display: block;">
	      	<strong style="color: black;">쿠폰 이용안내</strong>
	      	<p>1. 본 쿠폰은 다운(쿠폰 받기) 후, 사용할 수 있습니다.<br>
	      	   2. 쿠폰은 펀딩 서비스 이용 시 사용할 수 있습니다.<br>
	      	   3. 쿠폰은 다른 쿠폰과 중복하여 사용할 수 없습니다.<br>
	      	   4. 쿠폰의 구체적인 사용 조건은 발행되는 쿠폰 별로 다룰 수 있습니다.<br>
	      	   5. 펀딩이 실패하거나 펀딩 예약 취소를  한 경우, 쿠폰은 반환됩니다. 단,반환 시점에 쿠폰 유효기간이 만료된 경우 자동 소멸됩니다.<br>
	      	   6. 펀딩 결제 실패인 경우에는 쿠폰이 반환되지 않고, 소멸됩니다.<br>
	      	</p><br><br>	                              
	      		      			
		  </div>
	   </div>	
    </div>
  </section>
  <!--================End Order Details Area =================-->


<jsp:include page="../bottom.jsp" />


  <script src="vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="vendors/skrollr.min.js"></script>
  <script src="vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="vendors/jquery.ajaxchimp.min.js"></script>
  <script src="vendors/mail-script.js"></script>
  <script src="js/main.js"></script>
</body>
</html>
