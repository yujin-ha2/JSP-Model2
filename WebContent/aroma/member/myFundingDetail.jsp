<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
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
  <link rel="stylesheet" href="css/style.css"> 
  <script type="text/javascript">
  </script>
  <style type="text/css">
  	.fundingCancel{
  		border: 3px solid #2ed5d5; 
  		background: none; 
  		text-align: center; 
  		font-weight: 700; 
  		width: 165px; 
  		height: 50px;
  		cursor: pointer;
  	}
  </style>
</head>
<body>

<jsp:include page="../top1.jsp" />
	
  <!--================Order Details Area =================-->
    <section class="order_details section-margin--small">
    <div class="maincontainer" style="padding: 0 120px;">    	
   		<div style="padding-bottom: 160px; max-width: 1000px; margin: 0 auto;">
    		<div style="padding: 24px 24px; margin: 0 auto; background-color: #F5F7FA;"> <!-- 첫번째블럭 -->
 	  			<p style="color:#60656a; margin-bottom: 12px;">펀딩 / ${history.categoryNm}</p>
 	  			<p style="color:#60656a; margin-bottom: 6px; font-size: 12px; line-height: 20px;"><i class="fas fa-circle" style="margin-right: 5px;"></i>${history.statusNm}</p>
 	  			<a href="#">
 	  				<p style="color:#60656a; margin-bottom: 8px; font-size: 17px; font-weight: 700; text-decoration: underline;">${history.title}</p>
 	  			</a>
 	  			<p style="color: #60656a;">by <a href="#" style="text-decoration: underline;color:inherit;">${history.makerName}</a></p>
 	  			<div style="color:#60656a;">
 	  				<div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 5px;">
 	  					<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">주문 번호</p>
 	  					<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">${payment.orderId}</p> 
 	  				</div>
 	  				<div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 5px;">
 	  					<fmt:formatDate var="orderDate" value="${payment.orderDate}" pattern="yyyy.MM.dd hh:ss"/>
 	  					<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">펀딩 날짜</p>
 	  					<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">${orderDate}</p>
 	  				</div>
 	  				<div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 5px;">
 	  					<fmt:formatDate var="endDate" value="${history.endDate}" pattern="yyyy.MM.dd"/>
 	  					<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">펀딩 종료일</p>
 	  					<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">${endDate}</p>
 	  				</div>
 	  				<div>
 	  					<c:set var="reservationStatus" value="결제 완료"/>
	            		<c:if test="${payment.cancel == 1}"><c:set var="reservationStatus" value="결제 예약취소"/></c:if>
 	  					<div style="display: flex; align-items: center; justify-content: space-between;">
 	  						<p style="font-size: 14px; line-height: 20px;">펀딩  상태</p>
 	  						<p style="font-size: 14px; line-height: 20px; font-weight: 700;">${reservationStatus}</p>
 	  					</div>
 	  					<c:if test="${payment.cancel == 1}">
 	  						<div style="position: relative; line-height: 20px; font-size: 14px;">결제 예약이 취소되었습니다.</div>
 	  					</c:if>
 	  				</div>
 	  			</div>
		    </div>
		    <div style="padding: 24px 20px 30px; margin: 12px 0; background-color: #F5F7FA;"> <!-- 두번째블럭 -->
		    	<c:forEach var="reward" items="${rewardList}">
			    	<div style="margin-bottom: 15px;">
			    		<h3 style="margin-bottom: 5px; line-height: 1.5; color: #1d2129; font-size: 16px; font-weight: bold;">${reward.rewardOption}</h3>
			    		<div style="margin-bottom: 5px; line-height: 1.6;">
			    			<p style="font-size: 13px; line-height: 20px; margin-bottom: 0; ">*구성 : ${reward.rewardDetail}</p>
			    		</div>
			    		<div>
			    			<p style="margin-bottom: 5px; font-size: 14px; color:#60656a;">${reward.price}원 / ${reward.salesQuantity}개</p>
			    			<p style="margin-bottom: 5px; font-size: 14px; color:#60656a;">발송 시작일 : ${reward.deliveryDate}</p>
			    		</div>
			    	</div>
		    	</c:forEach>
		    </div>
		    <div style="padding: 24px 20px; margin: 12px 0; background-color: #F5F7FA;"> <!-- 세번째블럭 -->
	    		<div>
	    	  		<div style="font-size: 14px; color: #60656a; font-weight: 600; margin-bottom: 20px;">결제 내역</div>
	    	  		<ul>
	    	  			<li style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 5px;">
	    	  				<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">리워드 금액</p>
	    	  				<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">${payment.totalAmount}원</p>
	    	  			</li>
	    	  			<li style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 5px;">
	    	  				<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">포인트 차감금액</p>
	    	  				<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">${payment.usedPoint}원</p>
	    	  			</li>
	    	  			<li style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 5px;">
	    	  				<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">추가 후원금</p>
	    	  				<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">${payment.donation}원</p>
	    	  			</li>
	    	  			<li style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 5px;">
	    	  				<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">배송비</p>
	    	  				<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">${payment.deliveryFee}원</p>
	    	  			</li>
	    	  			<li style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 5px;">
	    	  				<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">최종 결제 금액</p>
	    	  				<p style="font-size: 14px; line-height: 20px; margin-bottom: 0;">${payment.finalAmount}원</p>
	    	  			</li>
	    	  		</ul>
	    	  	</div>
	    	</div>
	    	<div style="padding: 16px 20px 12px; margin-bottom:12px; background-color: #F5F7FA;"> <!-- 네번째블럭 -->
	    		<c:set var="carNumber" value="${receiver.cardNumber}"/>
	    		<h4 style="font-size: 14px; color: #60656a; font-weight: 600; margin-bottom: 20px;">결제 정보</h4>
		    	<span>결제방법<font style="float:right"><b>신용(체크)카드 
				</b></font></span><br>
		    	<span>카드번호<font style="float:right"><b>************${fn:substring(carNumber, 12, carNumber.length())}</b></font></span><br>
	    	</div> 
	    	<div style="padding: 16px 20px 12px; margin-bottom:20px; background-color: #F5F7FA;"> <!-- 다섯번째블럭 -->
	    		<h4 style="font-size: 14px; color: #60656a; font-weight: 600; margin-bottom: 20px;">배송지 정보</h4>
	    		<div>
	    			<p style="color:#60656a; margin-bottom: 16px; font-size: 14px; line-height: 20px;">
	    				<span style="margin-bottom: 4px; display: block;">${receiver.name}</span>
	    				<span style="margin-bottom: 4px; display: block;">${receiver.phone}</span>
	    			</p>
	    			<p style="color:#60656a; margin-bottom: 20px; font-size: 14px; line-height: 20px;">
	    				<span style="margin-bottom: 4px; display: block;">[${receiver.postCode}] ${receiver.address}</span>
	    				<span style="margin-bottom: 4px; display: block;">${receiver.detailAddress}</span>
	    			</p>
	    		</div>
	    	</div> 
	    	<div>
	    		<p style="font-size: 15px; line-height: 18px; color:#60656a;">※ 펀딩 종료 이후에는 서포터의 배송지 정보가 메이커에게 전달되기 때문에 종료 이후 배송 정보 변경 등에 대한 문의는 메이커에게 직접 해야 합니다.</p>
	    	</div> 
	    	<c:if test="${payment.cancel == 0}">
		    	<div style="padding: 10px 0; width: 165px; margin: 50px auto 10px;">
		    		<input type="button" class="fundingCancel" value="펀딩 취소하기"
		    			   onclick="location.href='${contextPath}/MyFundingCancel.me?orderId=${payment.orderId}';">
		    	</div>
	    	</c:if>
	    	<c:if test="${payment.cancel == 1}">
		    	<div style="padding: 10px 0; width: 165px; margin: 50px auto 10px;">
		    		<input type="button" class="fundingCancel" onclick="location.href='${contextPath}/MyFundingHistory.me';" value="목록으로 돌아가기">
		    	</div>
	    	</c:if>
	    </div>    	 
	</div>
  	</section>

<jsp:include page="../bottom.jsp" />

</body>
</html>
