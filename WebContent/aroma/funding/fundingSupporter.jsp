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
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
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
				<a class="nav-link" id="home-tab" href="${contextPath}/fundingStory.do?fundingId=${fundingInfo.fundingId}" role="tab" aria-selected="true">스토리</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="profile-tab" href="${contextPath}/fundingRewardInfo.do?fundingId=${fundingInfo.fundingId}" role="tab" aria-selected="false">반환/정책</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="contact-tab" href="${contextPath}/fundingCommunity.do?fundingId=${fundingInfo.fundingId}" role="tab" aria-selected="false">커뮤니티</a>
			</li>
			<li class="nav-item">
				<a class="nav-link active" id="review-tab" href="${contextPath}/fundingSupporter.do?fundingId=${fundingInfo.fundingId}" role="tab" aria-selected="false">서포터</a>
			</li>
		</ul>
		<div class="fundingcontainer" >
			<div class="tab-content" id="myTabContent" style="border: none;">
				<div class="row">
					<div class="col-lg-8 posts-list">
						<div class="single-prd-item" >
							<p style="padding: 0 0 23px; line-height: 1.29; color: #0d0f12; font-size: 28px; font-weight: 300;">
								현재 이 프로젝트에<br>
								<strong style="color: #00c4c4; font-weight: 500;">${supporterList.size()}명</strong>의 참여가 이루어졌습니다.
							</p>
							<div>
								<c:forEach var="supporter" items="${supporterList}">
									<div style="border-bottom: 1px solid #e6eaed; padding: 20px 0;">
										<span class="profileDiv" style="background: white; width: 46px; height: 46px; float:left; border-radius: 50%; overflow: hidden; margin-right: 12px;">
												<img class="profileImg" src="${pageContext.request.contextPath}/profileUpload/${supporter.profile}"
													style="width: 100%; height: 100%; object-fit: cover;">
										</span>
										<div style="margin-left: 62px; padding-right: 16px; font-size: 17px;">
											<p style="margin-bottom: 0;">
												<button style="color: #0d0f12; font-weight: 500; background: none; border: 0 none; padding: 0;">${supporter.userId}</button>님이&nbsp;
												<strong>${supporter.totalAmount}원 펀딩</strong>으로 참여 하셨습니다.
											</p>
											<fmt:formatDate var="orderDate" value="${supporter.orderDate}" pattern="yyyy-MM-dd"/>
											<em style="font-style: normal; font-size: 12px;">${orderDate}</em>
										</div>
									</div>
								</c:forEach>
							</div>
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
								 	<a href="">
										<button class="profileDiv" style="background: white; width: 38px; height: 38px; border-radius: 70%; overflow: hidden; margin-right: 12px;">
											<img class="profileImg" src="${pageContext.request.contextPath}/profileUpload/${maker.profile}"
												style="width: 100%; height: 100%; object-fit: cover;">
										</button>
										<span style="line-height: 28px; font-size: 18px; font-weight: 700; font-style: normal; letter-spacing: -.3px; color: #212529;">디알에스코퍼레이션</span>
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
							<input type="button" id="orderBtn" name="orderBtn" value="펀딩 하기" class="btn btn-primary" style="font-size:18px; border: none; width:100%; height:48px; margin-top: 15px;">
					</div> 
				</div><!-- 우측 div 끝 -->
				</div>
			</div>
		</div>
	</section>

  <jsp:include page="../bottom.jsp" />

</body>
</html>