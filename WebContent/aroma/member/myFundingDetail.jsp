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
    <script type="text/javascript" src="payment.js">
    	window_resize();
    </script>
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
    	  <div class="col-md-12" id="my_md">
    	  	<div class="confirmation-card-body" id="my_height">
    	  		<div class="row mb-5">
    	  			<div class="col-md-12" id="my_fd1">    	  		
		    	  		<span>펀딩/디자인소품</span><br>    	  
				    	<span><i class="fas fa-circle"> 종료</i></span><br>
				    	<strong style="color: black;">[목표관리 3분전략]전세계의 플래너를 분석했다고? 하이파이브 플래너</strong><br>
				    	<span>by 하이파이브투게더</span><br><br><br>
				    	<span>펀딩 번호<font style="float:right">4883353</font></span><br>
				    	<span>펀딩 날짜<font style="float:right">2020.12.08 23:46</font></span><br>
				    	<span>펀딩 종료일<font style="float:right">2020.12.21</font></span><br>
				    	<span>펀딩 상태<font style="float:right"><b>결제 예약취소</b></font></span><br><br>
				    	<span>결제 예약이 취소되었습니다.</span><br>	
				    </div>
				    		    	  	
	    	  	</div> <!-- row mb-5 끝 -->
	    	  	<div class="row mb-5">
    	  			<div class="col-md-12" id="my_fd1">    	  		
		    	  		<strong style="color: black;">[얼리버드](6개월)하이파이브 패키지x1</strong><br><br>
				    	<span>*구성:하이파이브 6개월 플래너 1권+스티커 1개+데일리 루틴 1개+사용 설명서 1개</span><br><br>
				    	<span>27,820원/1개</span><br>
				    	<span>발송 시작일:2020년 12월 말(21~말일)예정</span><br><br>
				    	<span>※ 프로제트 교환/펀딩금반환/AS 정책은 반환·정책을 확인하세요 </span><br>
				    	<a href="#"><span>프로젝트 반환·정책 바로가기</span></a><br>				    		
				    </div>
				    		    	  	
	    	  	</div> <!-- row mb-5 끝 -->
	    	  	
	    	  	<div class="row mb-5">
    	  			<div class="col-md-12" id="my_fd1">    	  		
		    	  		<span><b>결제 내역</b></span><br><br>
				    	<span>리워드 금액<font style="float:right">27,820원</font></span><br>
				    	<span>쿠폰 차감금액<font style="float:right">-0원</font></span><br>
				    	<span>포인트 차감금액<font style="float:right">-2,000원</font></span><br>
				    	<span>추가 후원금<font style="float:right">0원</font></span><br>
				    	<span>배송비<font style="float:right">3,000원</font></span><br><br>
				    	<span><b>최종 결제 금액</b><font style="float:right"><b>28,820원</b></font></span><br><br>
				    		
				    </div>
				    		    	  	
	    	  	</div> <!-- row mb-5 끝 -->
	    	  	
	    	  	<div class="row mb-5">
    	  			<div class="col-md-12" id="my_fd1">    	  		
		    	  		<span><b>결제 정보</b></span><br><br>
				    	<span>결제방법<font style="float:right"><b>신용(체크)카드</b></font></span><br>
				    	<span>카드번호<font style="float:right"><b>************7116</b></font></span><br>	
				    </div>
				    		    	  	
	    	  	</div> <!-- row mb-5 끝 -->
	    	  	
	    	  	<div class="row mb-5">
    	  			<div class="col-md-12" id="my_fd1">    	  		
		    	  		<span><b>배송지 정보</b></span><br><br>
				    	<span>홍길동</span><br>
				    	<span>010-1234-1234</span><br><br>
				    	<span>[43019]대구 달성군 무가읍 유기농대로 170(봉파,제일풍파채센트럴)<br>
				    	      304동 401호 
				        </span><br>				    		
				    </div>
				    		    	  	
	    	  	</div> <!-- row mb-5 끝 -->	    	  	
	    	  	
	    	  	<div class="row mb-5">
    	  			<div class="col-md-12" >    	  		
		    	  		<div id="my_fd2"><b>펀딩 종료 이우에는 서포터의 배송지 정보가 메이커에게 정달되기 때문에 종료 이웋 배송 정보 변경 등에 대한 문의는 메이커에게 직접 해야 합니다.</b></div><br><br>
		    	  		<div id="my_fd3"><i class="far fa-comment-alt"> 메이커에게 문의하기</i></div>				    	   		
				    </div><br>
				    <div id="my_fd4"><p><b><i class="fas fa-info-circle"> 리워드 발송은 메이커의 의무로 프로젝트 진행시 메이커가 약속한 리워드 발송 시작일에 제공하는 것을 원칙으로 합니다.다만 크라우드펀딩 특성상 메이커의 예기치 못한 일정 병경이 있을
				                                        수 있으며,리워드 발송에 대해 발생한 이슈는 프로젝트 상세 페이지-펀딩 안내 탭에 명시한 정책에 따릅니다.</i>
				    </b></p></div><br><br>
				    <div id="my_fd5">
				    	<button type="button" id="btn">목록으로 돌아가기</button>
				    </div>					    	    	  	
	    	  	</div> <!-- row mb-5 끝 -->	    	  	
	    	</div> 	
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
