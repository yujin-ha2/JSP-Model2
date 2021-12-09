<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <%-- <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css"> --%>
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css"> 
</head>
<body>
<jsp:include page="../top1.jsp" />
	
    <section class="order_details section-margin--small">
	    <div class="maincontainer" style="padding: 0 120px;">
    		<h2 style="font-size: 32px; padding: 56px 40px 24px;">나의 펀딩 내역</h2>    	
            <div style="border-top: 1px solid rgb(0 0 0 / 20%); padding: 40px 40px;">
            	<c:if test="${empty historyList}">
            		<div style="padding:50px 0; text-align: center; display: block;">
	      				<p><b>펀딩 프로젝트에 참여한 내역이 없습니다.<br>지금 바로 펀딩 프로젝트를 둘러보세요!</b></p>
	      				<p>
		      			<span class="dp-ib"><a href="#"><strong>펀딩 프로젝트 바로가기</strong> <i class="fas fa-angle-right"></i></a></span>
	      				</p>		
		  			</div>
            	</c:if>
            	<ul style="width: 100%; max-width:1500px;">
            		<c:forEach var="history" items="${historyList}">
	            		<li style="margin-bottom: 16px;">
	            			<a href="MyFundingHistoryInfo.me?orderId=${history.orderId}&fundingId=${history.fundingId}" style="width: 100%;">
	            				<dl style="background:#fff; box-shadow: 0 0 1px 0 rgb(0 0 0 / 40%);">
	            					<dt style="position: relative; padding: 20px 20px 0; font-size: 12px; letter-spacing: -.02em; line-height: 16px;">
										<fmt:formatDate var="orderDate" value="${history.orderDate}" pattern="yyyy.MM.dd"/>
	            						<em style="padding-right: 6px; color: #90949c; font-style: normal;">펀딩  / ${history.categoryNm}</em>
	            						<em style="position: absolute; right: 20px; color: #90949c; font-style: normal;">${orderDate} 펀딩</em>
	            					</dt>
	            					<dd style="padding: 10px 20px;">
	            						<p style="padding-bottom: 4px; font-size: 12px; line-height: 18px; font-weight:600; letter-spacing: -.02em; color: #90949c; margin-bottom: 5px;">
	            							${history.statusNm}
	            						</p>
	            						<p style="padding-bottom: 4px; margin-bottom: 5px; font-size: 19px; font-weight: 500; line-height: 24px; letter-spacing: -.02em; color: #44484b;">
	            							${history.title}
	            						</p>
	            						<p style="margin-bottom: 5px; font-size: 12px; line-height: 18px; letter-spacing: -.02em; color: #90949c">by ${history.makerName}</p>
	            						<p style="margin-bottom: 0;">
	            							<c:set var="reservationStatus" value="결제 완료"/>
	            							<c:if test="${history.cancel == 1}"><c:set var="reservationStatus" value="결제 예약취소"/></c:if>
	            							<em style="font-size: 15px; line-height: 20px; color: #557CF2; font-weight: 500; font-style: normal;">${reservationStatus}</em>
	            						</p>
	            					</dd>
	            				</dl>
	            			</a>
	            		</li>
	            	</c:forEach>
            	</ul>  
            </div>
    	</div>
  </section>

<jsp:include page="../bottom.jsp" />

</body>
</html>
