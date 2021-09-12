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
    	  	  	<h2>나의 펀딩</h2>  	                
	        </div>
	        <hr>
	        <div class="row mb-5">
	        	<div class="col-md-12">
	        	<!-- Example single danger button -->
					<div class="btn-group" style="float: right;">
					  <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="true">
					    Action
					  </button>
					  <ul class="dropdown-menu">
					    <li><a class="dropdown-item" href="#">전체</a></li>
					    <li><a class="dropdown-item" href="#">결제 예약</a></li>
					    <li><a class="dropdown-item" href="#">결제 완료</a></li>					    
					    <li><a class="dropdown-item" href="#">취소 / 실패</a></li>
					  </ul>
					</div>
	        	</div>
	        </div> 
	         
          </div> <!-- col-md-12 -->          	     
      </div> <!-- row mb-5 끝 -->                    	
	  <div class="row mb-5">
	      <div class="col-md-12" style="text-align: center; display: block;">
	      	<p id="body_font"><b>펀딩 프로젝트에 참여한 내역이 없습니다.<br>
	      		                              지금 바로 펀딩 프로젝트를 둘러보세요!</b><br><br>
	      		
	      		<span class="dp-ib"><a href="#"><strong>펀딩 프로젝트 바로가기</strong> <i class="fas fa-angle-right"></i></a></span>
	      	</p>		
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
