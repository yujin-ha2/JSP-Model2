<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"	 %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop - Product Details</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="icon" href="${contextPath}/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
<style type="text/css">
.maincontainer {
   margin: 0 auto;
    padding: 0 80px;
    width: 100%;
    max-width: 1440px;  
}
</style>
</head>
<body>
<jsp:include page="../top1.jsp" />
	
	<!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="blog" style="height: 200px; background: #f1f6f7;">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
						홈리빙
			        </nav>
					<h3 style="font-size: 30px;">클레오파트라의 피부비결, 각질 관리도 개운하게 | 이집트 천연 루파 샤워 타올</h3>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->


	<!--================Product Description Area =================-->
	<section class="product_description_area" style="margin-top: 0;">
			<ul class="nav nav-tabs" id="myTab" role="tablist" style="background: none; border: 1px solid #f1f6f7;">
				<li class="nav-item">
					<a class="nav-link" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">스토리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
					 aria-selected="false">반환/정책</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
					 aria-selected="false">커뮤니티</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" id="review-tab" data-toggle="tab" role="tab" aria-controls="review"
					 aria-selected="false" onclick="location.href='${contextPath}/FundingDetailSupport.do?fundingId=1'">서포터</a>
				</li>
			</ul>
	<!-- ==============정책============== -->
		<div class="maincontainer" >
			<div class="tab-content" id="myTabContent" style="border: none;">
				<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
				<div class="row">
					<div class="col-lg-8 posts-list">
						<div class="single-prd-item" >
							<div align="left" style="font-size: 20px; padding-top: 30px ">
								<h2><strong>현재 이 프로젝트에 </strong></h2>
								<h2><strong><span style="color:blue"> ${count } 명</span>의 참여가 이루어졌습니다.</strong></h2><br><br>
								
								<!-- 목록 -->
							<div class="list" style="font-size: 18px">
							<hr>
							<c:forEach var="v" items="${v}">
								<div class="row">
								  <div style="width:150px" align="center"><img alt="" src="/goodFunding/upload/${v.receiver }" style="border-radius: 100px; width: 80px; height: 80px;"></div>
								   <div class="col" style="padding-top: 20px;"><span>${v.userId }님이 ${v.amount }원 펀딩으로 참여하였습니다.</span></div>
								</div><hr>
							</c:forEach>
							
							
							
							</div><!-- list -->
							
							</div>
						</div>
					</div>	
					<!-- ==============정책============== -->
					
					
					
					<!-- ==============우측 배너============== -->
					<div class="col-lg-4">
						<div class="blog_right_sidebar">
							<strong style="font-size: 25px; color:black;">오늘 자정 마감</strong>
							<hr>
							<div>
							<strong style="font-size: 22px; color:gray;">1583%</strong><b> 달성</b><br><br>
							<strong style="font-size: 22px; color:gray;">47,516,000</strong><b> 원 펀딩</b><br><br>
							<strong style="font-size: 22px; color:gray;">178</strong><b> 명의 서포터</b><br><br>
							<button type="button" class="btn btn-primary btn-lg btn-block" style="background-color:LightSlateGray; 
							font-size:18px; border: none;width: 324px;height: 50px ">펀딩 하기</button>
							<div class="row" align="center" style="padding-left: 7px; padding-top: 20px">
							<div style="padding-left: 9px">
							  <button type="button" class="btn btn-outline-secondary" style="width: 157px; height: 45px;">좋아요</button>
							</div>
							<div style="padding-left: 8px">
							  <button type="button" class="btn btn-outline-secondary" style="width: 157px;height: 45px;">문의하기</button>
							</div>
							</div>
							</div>
							</div><br><!-- blog_right_sidebar -->
							
								<div class="blog_right_sidebar" style="height:330px">
						<img alt="" src="./img/worker.png">
							<strong style="font-size: 20px; color:black;padding-left: 10px"> 디알에스코퍼레이션</strong>
							<hr>
							<div>
							<b>메이커 정보</b>
							<p>drsmaster@naver.com</p>
							<p>031-307-0555</p>
							<p>카카오 플러스친구</p>
							<p>www.drsmaster.com</p>
							</div>
							</div><br><!-- blog_right_sidebar -->
							
						<div class="blog_right_sidebar" style="height:360px">
							<strong style="font-size: 20px; color:black;"> 343,000원 펀딩</strong>
							<div style="padding-top: 8px">
							<b>[ 슈퍼얼리버드-Q ]</b>
							<p>닥터메트 퀸(Q) x 1</p>
							<b>배송비</b>
							<p>10,000원</p>
							<b>리워드 발송 시작일</b>
							<p>2021년 07월 초(1~10일)예정</p>
							<p style="color: blue">제한수량 100개</p>
							<b>총37개 펀딩 완료</b>
							</div>
						</div><br><!-- blog_right_sidebar -->
						
						<div class="blog_right_sidebar" style="height:360px">
							<strong style="font-size: 20px; color:black;"> 343,000원 펀딩</strong>
							<div style="padding-top: 8px">
							<b>[ 슈퍼얼리버드-Q ]</b>
							<p>닥터메트 퀸(Q) x 1</p>
							<b>배송비</b>
							<p>10,000원</p>
							<b>리워드 발송 시작일</b>
							<p>2021년 07월 초(1~10일)예정</p>
							<p style="color: blue">제한수량 100개</p>
							<b>총37개 펀딩 완료</b>
							</div>
						</div><!-- blog_right_sidebar -->
					</div>	
				</div>
			</div>
		</div>
	</section>
	<!--================End Product Description Area =================-->

  <jsp:include page="../bottom.jsp" />


  <script src="${contextPath}/vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="${contextPath}/vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="${contextPath}/vendors/skrollr.min.js"></script>
  <script src="${contextPath}/vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="${contextPath}/vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="${contextPath}/vendors/jquery.ajaxchimp.min.js"></script>
  <script src="${contextPath}/vendors/mail-script.js"></script>
  <script src="${contextPath}/js/main.js"></script>
</body>
</html>