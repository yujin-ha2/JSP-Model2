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
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <style type="text/css">

  </style>
</head>
<body>


<jsp:include page="../top1.jsp" />
	
    <section class="order_details section-margin--small">
    <div class="container" style="width: 750px; margin:0 auto; ">    	
    	<div>
    		<div style="padding: 30px 0 40px;">
    			<h2>펀딩 완료</h2>
    		</div>
    		<div style="padding: 20px; border: 1px solid #F5F7FA; border-radius: 23px; background-color: #F5F7FA;">
    			<div style="margin: 20px 0 30px;">
    				<p style="font-size: 25px; font-weight: bold; color:#2e2e2e;">든든한 서포터 <b style="color: #2ed5d5;">${userName}</b>님<br>펀딩해주셔서 감사합니다.</p>
    			</div>
    			<div style="margin-bottom: 20px;">
    				<p style="font-size: 16px; font-weight: bold; margin-bottom: 0; color:#535353;">
    					<fmt:formatDate var="date" value="${nextDate}" pattern="yyyy년 MM월 dd일"/>
    					<span style="display: block;">${funding.title}</span>
    					<span style="display: block;">결제 예정일 : ${date}</span>
    				</p>
    				<span style="font-size: 14px;">프로젝트 성공시에만 결제됩니다.</span>
    			</div>
    			<div>
    				<p style="font-size: 16px; font-weight: bold; margin-bottom: 0; color:#535353;">
    					리워드 발송 시작일 : ${funding.deliveryDate}
    				</p>
    				<p style="font-size: 14px;">리워드 준비중 예기치 못한 사정으로 리워드 발송이 지연되거나 리워드 품질이 기대와 다를 수 있음을 알려드립니다.</p>
    			</div>
			</div>
    		<div style="margin: 40px auto; text-align: center;">
    			<div>
    				<p style="font-size:15px; font-weight:600; color:#535353;">결제 예약 결과 및 배송 예상일 조회는 <br>나의 펀딩현황에서 확인하세요.
    			</div>
    			<div style="margin-bottom: 100px;">
    				<button style="width:180px; height:50px; border: none; border-radius:10px; background-color: #6b90dc; color: white; font-size: 16px; font-weight: bold;" onclick="location.href='MyFundingHistory.me';">펀딩 내역 보러가기</button>
    			</div>
    		</div>
	    </div>
    </div>
 	</section>


<jsp:include page="../bottom.jsp" />

</body>
</html>