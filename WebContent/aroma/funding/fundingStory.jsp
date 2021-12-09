<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>GoodFunding</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <script type="text/javascript" src="${contextPath}/js/funding.js"></script>
  <script type="text/javascript">
	$(document).on("click", '#followBtn', function () {
	   	if(${empty sessionScope.id}){
	   		alert("로그인 후에 이용해주세요.");
		}else{
	   		followProcess();
	   	}
	});
    function followProcess() {
    	var followStatus = $("#status").val();
    	console.log("followStatus: " + followStatus);

    	var data = {userId : "${sessionScope.id}", makerId : "${maker.userId}", followStatus : followStatus};
    	$.ajax({
    	    type: 'post',
    	    url: 'FollowAction.do',
    	    data: JSON.stringify(data), 
    	    contentType: "application/json; charset=utf-8",
    	    dataType: "json" 
    	}).done(function(result) {
    		if(followStatus == 0){
    			//팔로우 버튼 클래스 변경 /버튼 텍스트 변경
    			$("#followBtn").attr('class','btn btn-outline-primary');
    			$("#followBtn").html('-팔로우취소'); 
    	      	$("#status").val("1");
    	      	
    		}else{
    			$("#followBtn").attr('class','btn btn-primary');
    			$("#followBtn").html('+팔로우'); 
    	      	$("#status").val("0");
    	   	
    		}
    		
    	}).fail(function() {
    		console.log("팔로우 오류");
    	});
    }
    
    function orderFunding() {
    	if(${empty sessionScope.id}){
	   		alert("로그인 후에 이용해주세요.");
		}else{
			var UlLength = $("#productsToBuy ul").length;
	    	if(UlLength == 0){
	    		alert("리워드 옵션을 먼저 선택해주세요");
	    	}else{
	    		orderForm.submit();	
	    	}
	   	}
	}
    
    $(document).ready(function () {
    	  $(document).on("click", "input[name='orderBtn']", function () {
    		  orderFunding();
    	  });
    });
  </script>
  <style type="text/css">
	.tableTh{
		width: 80px; 
		vertical-aligin: top; 
		text-align: left; 
		color: #868e96;
	}
	
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    margin: 0;
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
						${fundingInfo.categoryNm}
			        </nav>
					<h3 style="font-size: 30px;">${fundingInfo.title}</h3>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->

	<section class="product_description_area" style="margin-top: 0;">
		<ul class="nav nav-tabs" id="myTab" role="tablist" style="background: none; border: 1px solid #f1f6f7;">
			<li class="nav-item">
				<a class="nav-link active" id="home-tab" href="${contextPath}/fundingStory.do?fundingId=${fundingInfo.fundingId}" role="tab" aria-selected="true">스토리</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="profile-tab" href="${contextPath}/fundingRewardInfo.do?fundingId=${fundingInfo.fundingId}" role="tab" aria-selected="false">반환/정책</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="contact-tab" href="${contextPath}/fundingCommunity.do?fundingId=${fundingInfo.fundingId}" role="tab" aria-selected="false">커뮤니티</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="review-tab" href="${contextPath}/fundingSupporter.do?fundingId=${fundingInfo.fundingId}" role="tab" aria-selected="false">서포터</a>
			</li>
		</ul>
		<div class="fundingcontainer">
			<div class="tab-content" id="myTabContent" style="border: none;">
				<div class="row">
					<!-- 좌측 div 시작 -->
					<div class="col-lg-8 posts-list" style="padding: 20px 20px;">
						<div class="single-prd-item" >
							<div style="height: 400px;">
								<img class="img-fluid" src="${pageContext.request.contextPath}/fundingUpload/${fundingInfo.storyMainImg}" style="width: 100%; height: 400px;">
							</div>
							<div style="font-size: 17px; padding: 30px 20px; line-height: 1.7; color: #676363; font-weight: 700;">
								${fundingInfo.storySummary}
							</div>
						</div>
						<div style="border-radius: 8px; padding: 20px; background-color: #f2f4f6; margin-bottom: 50px;">
							<p style="font-size: 13px; line-height: 20px; margin-bottom: 8px; color: #6b90dc; font-weight: 500;">    
								<strong>목표 금액</strong> &nbsp;&nbsp;${fundingInfo.salesTarget}원<br>
								<fmt:formatDate var="startdate" value="${fundingInfo.startdate}" pattern="yyyy.MM.dd"/>
								<fmt:formatDate var="enddate" value="${fundingInfo.enddate}" pattern="yyyy.MM.dd"/>
								<strong>펀딩 기간</strong> &nbsp;&nbsp;${startdate} - ${enddate}<br>
							</p>
							<p style="font-size: 13px; line-height: 20px; margin-bottom: 0;">    
								100% 이상 모이면 펀딩이 성공되며, 펀딩 마감일까지 목표 금액이 100% 모이지 않으면 결제가 진행되지 않습니다.
							</p>
						</div>
						<div>
							<strong style="font-size: 19px; font-weight: 700;">프로젝트 스토리</strong><br>
							${fundingInfo.storyContent}
						</div>
					</div> 
					<!-- 우측 div 시작 --> 	
					<div class="col-lg-4">
						<div class="blog_right_sidebar" style="padding-left: 0;">
							<c:set var="dayText" value="${report.statusName}"/>
							<c:if test="${report.status eq 'start'}">
								<c:set var="dayText" value="${report.dayDiff}일 남음"/>
								<c:if test="${report.dayDiff == 0}">
									<c:set var="dayText" value="오늘 자정까지"/>
								</c:if>
							</c:if>
							<strong style="font-size: 25px; color:black;">${dayText}</strong>
							<hr>
							<div>
								<strong style="font-size: 22px; color:gray;">${report.achievement}%</strong><b> 달성</b>	
							</div>
							<div>
								<fmt:formatNumber var="totalRevenue" value="${report.totalRevenue}" pattern="#,###"/>
								<strong style="font-size: 22px; color:gray;">${totalRevenue}</strong><b> 원 펀딩</b>	
							</div>
							<div>
								<strong style="font-size: 22px; color:gray;">${report.supporterCount}</strong><b> 명의 서포터</b>
							</div>
							<div style="border: 1px solid #e9ecef; border-radius: 8px; padding: 16px; margin: 15px auto;">
								<div style="margin-bottom: 10px;">
								 	<a href="${contextPath}/CompanyDetail.do?makerId=${maker.userId}">
										<button class="profileDiv" style="background: white; width: 38px; height: 38px; border-radius: 70%; overflow: hidden; margin-right: 12px;">
											<img class="profileImg" src="${pageContext.request.contextPath}/profileUpload/${maker.profile}"
												style="width: 100%; height: 100%; object-fit: cover;">
										</button>
										<span style="line-height: 28px; font-size: 18px; font-weight: 700; font-style: normal; letter-spacing: -.3px; color: #212529;">${maker.name}</span>
									</a>
								</div>
								<div>
									<table style="line-height: 18px; font-size: 15px; font-weight: 300;">
										<tbody>
											<tr>
												<th class="tableTh">이메일</th>
												<td style="padding: 0 0 8px;">${maker.makerEmail}</td>
											</tr>
											<tr>
												<th class="tableTh">문의전화</th>
												<td style="padding: 0 0 8px;">${maker.makerTel}</td>
											</tr>
											<tr>
												<th class="tableTh">홈페이지</th>
												<td style="padding: 0 0 8px;">${maker.makerHomepage}</td>
											</tr>
										</tbody>
									</table>
									<div style="margin-top: 15px;">
										<input type="hidden" id="status" name="status" value="${check}">
										<c:set var="followClass" value="btn btn-primary"/>
										<c:set var="followText" value="+팔로우"/>
										<c:if test="${check == 1}">
											<c:set var="followClass" value="btn btn-outline-primary"/>
											<c:set var="followText" value="-팔로우취소"/>
										</c:if>
										<button type="button" id="qnaBtn" class="btn btn-outline-primary" style="padding: 9px 16px; width: 49%;">문의하기</button>
										<button type="button" id="followBtn" class="${followClass}" style="padding: 9px 16px; width: 49%;">${followText}</button>
									</div>
								</div>
							</div>
							<form method="post" action="fundingOrder.do" name="orderForm">
								<input type="hidden" id="fundingId" name="fundingId" value="${fundingInfo.fundingId}">
								<div class="form-group">
									<select id="productSelect" class="form-control" style="margin-bottom: 0;" >
									    <option value="">상품 선택</option>
									    <c:forEach var="reward" items="${rewardList}">
										    <option value="${reward.rewardId}">${reward.rewardOption}</option>
									    </c:forEach>
									</select>
								</div>	
								<div id="productsToBuy">
								</div>
							</form>
							<input type="button" id="orderBtn" name="orderBtn" class="btn btn-primary" style="cursor:pointer; font-size:18px; border: none; width:100%; height:48px; margin-top: 15px;" value="펀딩하기">
					</div> 
				</div><!-- 우측 div 끝 -->
				</div>
			</div>
		</div>
	</section>

  <jsp:include page="../bottom.jsp" />

</body>
</html>