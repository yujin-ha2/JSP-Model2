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
		}else if('${report.status}' == 'success' || '${report.status}' == 'fail'){
			alert('이미 종료된 펀딩입니다.');
		}
		else{
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
  	.rewardInfo_row{
  		border-bottom: 1px solid #f0f2f5; 
  		padding: 6px 0; 
  		display: flex;
  	}
	.rewardInfo_label{
		color: rgba(0,0,0,.84)!important; 
		width: 180px; 
		margin-right: 10px;
	}
	
	.rewardInfo_value{
		color: #60656a; 
		font-size: 14px;
	}
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
				<a class="nav-link active" id="profile-tab" href="${contextPath}/fundingRewardInfo.do?fundingId=${fundingInfo.fundingId}" role="tab" aria-selected="false">반환/정책</a>
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
					<div class="col-lg-8 posts-list">
						<div class="single-prd-item" >
							<div align="left" style="padding-top: 12px; margin-bottom: 40px;">
								<h3 style="line-height: 32px; font-size: 24px;">이 프로젝트의 정보 및 정책을<br>반드시 확인하세요.</h3>
							</div>
							<div>
								<h3 style="font-size: 17px; font-weight: 700; margin-bottom: 12px;">펀딩 취소 및 리워드 옵션 변경, 배송지 변경 안내</h3>
								 <fmt:formatDate var="nextdate" value="${nextDate}" pattern="yyyy.MM.dd"/>
								<p style="font-size: 14px">펀딩 결제는 예약 상태로 유지되다가, 펀딩 마감일 다음 영업일 <strong>${nextdate} 17</strong>시에 모두 함께 진행됩니다.
								 결제 정보 변경은 결제가 진행되기 전까지 언제나 가능합니다. 참여한 펀딩 정보 변경은 펀댕 내역에서 진행해 주세요. 마감일 이후에는 펀딩에
								<fmt:formatDate var="enddate" value="${fundingInfo.enddate}" pattern="yyyy.MM.dd"/>
								대한 리워드 제작 및 배송이 시작되어, 취소와 더불어 배송지 및 리워드 옵션 변경은 <strong>${enddate}</strong> 이후로는 불가합니다.</p>
								<hr style="margin: 32px 0;">
							</div>
							<div style="margin-bottom: 32px;">
								<h3 style="font-size: 18px; font-weight: 700; color: #1d2129; line-height: 1.87;">리워드 정보 제공 고시</h3>
								<div>
									<p style="font-size: 15px; color: #777; line-height: 20px; color: rgba(0,0,0,.84); margin: 24px 0 8px 0;">
										<strong style="font-weight: 700; padding-right: 20px;">리워드 상세정보</strong>
										<span>${rewardDetailList[0].categoryNm}</span>
									</p>
									<c:forEach var="rewardInfo" items="${rewardDetailList}">
									<div class="rewardInfo_row">
										<div class="rewardInfo_label">${rewardInfo.detailName}</div>
							   			<div class="rewardInfo_value">${rewardInfo.detailContent}</div>
									</div>
									</c:forEach>
									<hr style="margin: 38px 0;">
								</div>
							</div>
							<div>
								<p style="font-size: 17px; margin: 1em 0; font-weight: 700; color: #1D2129;"><strong>사용 중 발생한 하자에 대한 A/S 정책</strong></p>
								<ul style="margin: 12px 0;">
									<li style="margin: 0 0 8px 10px; line-height: 1.65em;">${rewardDetailList.get(0).policy}</li>
								</ul>
								<p><br></p>
								<p style="font-size: 17px; margin: 1em 0; font-weight: 700; color: #1D2129;"><strong>교환</strong></p>
								<ul style="margin: 12px 0;">
									<li style="margin: 0 0 8px 20px; line-height: 1.65em; list-style-type: circle;">리워드 수령 후 개봉시에는 교환이 불가능 합니다.</li>
									<li style="margin: 0 0 8px 20px; line-height: 1.65em; list-style-type: circle;">제품이 파손된 채로 배송되었을 경우 교환 가능합니다.</li>
									<li style="margin: 0 0 8px 20px; line-height: 1.65em; list-style-type: circle;">단순변심에 의한 교환은 불가능 합니다.</li>
									<li style="margin: 0 0 8px 20px; line-height: 1.65em; list-style-type: circle;">제품하자로 인한 교환시, 발생하는 비용은 전액 메이커가 부담합니다.</li>
									<li style="margin: 0 0 8px 20px; line-height: 1.65em; list-style-type: circle;">서포터님의 부주의로 인한 교환 시 왕복배송비(5,000원)을 부담하셔야 합니다.</li>
								</ul>
								<p><br></p>
								<p style="font-size: 17px; margin: 1em 0; font-weight: 700; color: #1D2129;"><strong>펀딩금 반환</strong></p>
								<ul style="margin: 12px 0;">
									<li style="margin: 0 0 8px 20px; line-height: 1.65em; list-style-type: circle;">펀딩금 반환 신청은 서포터가 직접 ‘My 메뉴 > 나의 펀딩’에서 직접 진행합니다.</li>
									<li style="margin: 0 0 8px 20px; line-height: 1.65em; list-style-type: circle;">펀딩금 반환은 마이와디즈 서포터 탭의 [펀딩하기] 메뉴 선택하여 [펀딩 내역] 페이지에서 펀딩금 반환 신청을 원하는 프로젝트를 클릭해 신청할 수 있습니다.</li>
									<li style="margin: 0 0 8px 20px; line-height: 1.65em; list-style-type: circle;">프로젝트 페이지 상단 '반환/정책' 탭에서 자세한 내용 확인 가능합니다.</li>
									<li style="margin: 0 0 8px 20px; line-height: 1.65em; list-style-type: circle;">단순변심 또는 서포터님의 부주의로 인한 제품 손상은 교환 및 펀딩금 반환이 불가합니다.</li>
									<li style="margin: 0 0 8px 20px; line-height: 1.65em; list-style-type: circle;">리워드 교환을 원하는 경우, 메이커에게 문의하기를 통해 직접 문의 해주시기 바랍니다.</li>
									<li style="margin: 0 0 8px 20px; line-height: 1.65em; list-style-type: circle;">반환 신청 후, 신청 취소가 불가하니 신중하게 신청해주세요.</li>
									<li style="margin: 0 0 8px 20px; line-height: 1.65em; list-style-type: circle;">카드 결제 취소는 카드사에 따라 약 2-5영업일 소요됩니다.</li>
									<li style="margin: 0 0 8px 20px; line-height: 1.65em; list-style-type: circle;">펀딩시, 쿠폰 / 포인트를 사용하고 일부 리워드만 펀딩금 반환되는 경우, 사용한 전액이 우선 반환됩니다</li>
								</ul>
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
										<button type="button" id="qnaBtn" class="btn btn-outline-primary" style="padding: 9px 16px; width: 49%;"
												onclick="location.href='${contextPath}/CompanyDetail.do?makerId=${maker.userId}';">메이커페이지</button>
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
							<input type="button" id="orderBtn" name="orderBtn" value="펀딩하기" class="btn btn-primary" style="font-size:18px; border: none; width:100%; height:48px; margin-top: 15px;">
					</div> 
				</div><!-- 우측 div 끝 -->
				</div>
			</div>
		</div>
	</section>

  <jsp:include page="../bottom.jsp" />

</body>
</html>