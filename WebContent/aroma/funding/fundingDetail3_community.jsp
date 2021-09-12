<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"	 %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop - Product Details</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma-master"/>
  <link rel="icon" href="${contextPath}/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nouislider/nouislider.min.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
<style type="text/css">
.maincontainer {
   margin: 0 auto;
    padding: 0 80px;
    width: 100%;
    max-width: 1440px;
   /* border-bottom: 1px solid #f0f2f5; */        
   
	
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
					<a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">스토리</a>
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
					<a class="nav-link" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review"
					 aria-selected="false">서포터</a>
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
								<b style="font-size: 23px; color: black;">서포터님!</b>
								<p style="font-size: 22px;color: black;"><strong>처음 메이커의 열정과 가치에 공감해주셨듯, 마지막까지 메이커를 응원해주세요.</strong></p><br><br>
								<p style="font-size: 25px"><strong>굿펀딩에서 펀딩하는 방법이 궁금하다면?</strong></p>
								<span style="font-size: 28px"><strong>FAQ</strong></span><br><br>
			
									
			<!-- FAQ 영역 -->
			<div id="accordion">
			  <div class="card">
			    <div class="card-header" id="headingOne" style="background-color: none;">
			      <h5 class="mb-0" >
			        <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
			         	결제했어요. 펀딩은 언제, 어떻게 진행되나요?
			        </button>
			      </h5>
			    </div>
			
			    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
			      <div class="card-body">
			      펀딩기간 중에는 결제 예약 상태이며, 프로젝트 종료 후 다음 1영업일 5시에 결제가 진행됩니다. 이때, 결제 실패된 건에 한하여 종료일+4영업일동안 매일 5시에 결제가 진행됩니다. (펀딩 종료일+4영업일 오후 5시 4차 최종 결제 진행)
			      </div>
			    </div>
			  </div>
			  <div class="card">
			    <div class="card-header" id="headingTwo">
			      <h5 class="mb-0">
			        <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
			          	결제 실패 알림을 받았어요. 어떻게 해야하나요?
			        </button>
			      </h5>
			    </div>
			    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
			      <div class="card-body">
					카드 잔고 부족이나 한도 초과, 거래 정지된 카드인 경우 결제가 진행되지 않습니다. 최종 결제일 16시 30분 전까지 다른 카드로 결제 정보를 변경해주세요. 최종 결제일까지 매 영업일 5시마다 결제가 진행됩니다.
					・ 결제정보 변경은 로그인 - [나의 리워드] - [펀딩 내역] - [참여 프로젝트]에서 결제 정보를 변경할 수 있습니다.
					・ 반드시 참여한 프로젝트 펀딩 상세 내역 페이지에서 결제 정보를 변경해주세요. 나의 리워드 - 간편결제 정보 변경하면 해당 카드로 결제가 진행되지 않습니다!
			      </div>
			    </div>
			  </div>
			  <div class="card">
			    <div class="card-header" id="headingThree">
			      <h5 class="mb-0">
			        <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
			          	카드 결제가 진행된 후, 다른 카드로 변경할 수 있나요?
			        </button>
			      </h5>
			    </div>
			    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
			      <div class="card-body">
					결제 예약으로 진행되는 크라우드 펀딩 특성상 이미 종료된 프로젝트는 취소 후 재펀딩이 불가능하니, 결제 전 등록한 카드정보가 맞는지 확인해주세요.
			      </div>
			    </div>
			  </div>
			  <div class="card">
			    <div class="card-header" id="headingThree">
			      <h5 class="mb-0">
			        <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
			          	배송지나 옵션을 변경하고 싶어요.
			        </button>
			      </h5>
			    </div>
			    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
			      <div class="card-body">
					프로젝트 진행 중에는 [나의 리워드] - [펀딩내역]에서 직접 변경이 가능합니다.
					펀딩이 종료된 이후에는 직접 변경이 불가능하니, 아래 [메이커에게 문의하기]를 통해 문의해주세요.
			      </div>
			    </div>
			  </div>
			</div><br><br>
			
			<!-- 메이커에게 문의하기 -->
			<p style="font-size: 25px"><strong>리워드, 배송 등 펀딩에 대해 궁금한 사항이 있다면?</strong></p>
			<span style="font-size: 23px;">메이커에게 문의하기</span><br><br>
			<div style="height:180px">
						<img alt="" src="./img/worker2.png">
							<strong style="font-size: 20px; color:black;padding-left: 10px; padding-right:100px"> 디알에스코퍼레이션</strong>
							<button type="button" class="btn btn-outline-primary" style="width:230px; height: 50px">문의하기</button>
							<br><br><hr>
							</div><!-- blog_right_sidebar -->
			
									
			<!-- 응원,의견,체험 리뷰 -->
				
					<span style="font-size: 25px"><strong>응원/의견/체험 리뷰</strong></span>
					<span style="color: blue; font-size: 23px">1</span>
					<p>펀딩 종료전에 남긴 글입니다.</p>
					<div class="card mb-2">
						<div class="card-header bg-light">
						        <i class="fa fa-comment fa"></i> REPLY
						</div>
						<div class="card-body">
							<ul class="list-group list-group-flush">
							    <li class="list-group-item">
									<div class="form-inline mb-2">
										<label for="replyId"><i class="fa fa-user-circle-o fa-2x"></i></label>
										<img alt="" src="./img/worker.png">
										<b> 아이디</b>
									</div>
									<textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea>
									<button type="button" class="btn btn-dark mt-3" onClick="javascript:addReply();" style="float: right;">등록</button>
							    </li>
							    <hr>
							    
							    <!--댓글창  -->
							    <div class="show-comment" style="height: 130px; margin-bottom: 20px">
								    <img alt="" src="./img/worker.png" style="padding-left: 10px;">
								    <b>아이디</b>
								    <p style="padding-left: 20px; padding-top: 15px">빛이나는 솔로 뚜룬뚜뚜뚜뚜두두두두두~</p>
								    <span style="font-size: 15px;padding-left:20px;padding-top: 50px">2021-06-24 17:31</span>
								    <button type="button" class="btn btn-outline-secondary" style="height:35px;width:60px;margin-left: 405px">수정</button>
								    <button type="button" class="btn btn-outline-secondary" style="height:35px;width:60px;margin-left: 3px">삭제</button>
								    <button type="button" class="btn btn-outline-secondary" style="height:35px;width:60px;margin-left: 3px">등록</button>
							    </div><!--댓글창  -->
							    
							    <!-- 답글달기 -->
							    <div class="reply" style="background: #F6F6F6; height: 260px; padding-top: 20px ">
							     <b>└ 답글달기</b>
									<div align="center">
								    <textarea class="form-control" id="exampleFormControlTextarea1" rows="6" style="width: 720px"></textarea>
								    <button type="button" class="btn btn-outline-secondary" style="height:35px;width:60px;margin-left: 662px; margin-top: 5px">등록</button>
								    </div>
							    </div><!-- 답글달기 -->
							    
							    <!--답글 달았을 때(전체) -->
							    <div class="show-comment" style="height: 130px; margin-bottom: 50px; padding-top: 20px">
								    <img alt="" src="./img/worker.png" style="padding-left: 10px;">
								    <b>아이디</b>
								    <p style="padding-left: 20px; padding-top: 15px">빛이나는 솔로 뚜룬뚜뚜뚜뚜두두두두두~</p>
								    <span style="font-size: 15px;padding-left:20px;padding-top: 50px">2021-06-24 17:31</span>
								    <button type="button" class="btn btn-outline-secondary" style="height:35px;width:60px;margin-left: 405px">수정</button>
								    <button type="button" class="btn btn-outline-secondary" style="height:35px;width:60px;margin-left: 3px">삭제</button>
								    <button type="button" class="btn btn-outline-secondary" style="height:35px;width:60px;margin-left: 3px">등록</button>
							     </div><!--답글 달았을 때(전체) -->
								     
								     <!-- 답글 -->
								     <div style="padding-left: 30px;padding-top:30px; background: #F6F6F6;height:210px ">
								      <span>└</span>
								      <img alt="" src="./img/worker.png" style="padding-left: 10px;">
								      	<b>다른사람</b>
								      	<p style="padding-left: 40px; padding-top: 15px">후 회~하고있어요</p>
								      	<span style="font-size: 15px;padding-left:40px;padding-top: 50px">2021-06-24 17:31</span>
								      	<button type="button" class="btn btn-outline-secondary" style="height:35px;width:60px;margin-left: 595px">수정</button>
									    <button type="button" class="btn btn-outline-secondary" style="height:35px;width:60px;margin-left: 3px">삭제</button>
								      </div><!-- 답글 -->
								      
								</ul>
							</div><!--card-body -->
						</div>

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