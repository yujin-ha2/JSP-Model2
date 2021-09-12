<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="icon" href="${contextPath}/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nouislider/nouislider.min.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	  
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
	      	 <div class="content" style="width: 700px; margin:0 auto; ">
	      	 <div>
	      	 	<h2>결제 예약</h2>
			    		<hr>
			    		<a style="font-size: 13px; color: #3549EC" id="left_info"><b>[얼리버드] 온 가족과 함께SET[6+3]2개월분x9박스(18개월분)></b></a><br>
			    		<a style="font-size: 12px;">2개월분x9박스 (18개월분)1개월당 13,877원</a><br><br>
			    		<a style="float: right; font-size: 12px;"><b>수량:1개&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;249,800원</b></a>
			    		<br>
			    		<hr>
			    		<span><b>추가후원금</b><font style="float: right;">0원</font></span>
			    		<hr>
			    		<span><b>배송비</b><font style="float: right;">0원</font></span>
			    		
			    		<div style="background-color: #F6F6F6; height: 170px">
			    		
			    		<hr style="border: 1px Dashed gray">
			    		<span><b>쿠폰 사용</b><a href="#" style="float:right;"><b>
			    			<c:choose>
			    				<c:when test="${mb.coupon_check == 'false'}">
			    					보유한 쿠폰이 없습니다.
			    				</c:when> 
			    				<c:when test="${mb.coupon_check == 'true'}">
			    					다운로드 가능한 쿠폰이 1장 있습니다.
			    				</c:when>				    		
			    			</c:choose> 
			    			</b></a>
			    		</span>
			    		<hr>
				    		<div style="height: 70px">
                      <span id="use_point"><b>포인트 사용</b></span>
                      <div style="float: right; ">
                         <input type="checkbox" id="point" name="selector">                   
                         <span style="font-size: 15px;" id="all_use"><b>모두 사용(보유 포인트 ${mb.point }P)</b></span><br>
                      
                      <input type="text" id="using_point" style="float: right;" value="3000">   
                      
                      </div>
                   </div>   
				    		
				    	<div id="funding_price" style="background-color: #EAEAEA;">
				    	<br>
				    		<div id="price"><b>펀딩금액</b><font style="float: right;">249,800 원</font></div>
				    		<br>			    		
				    		<div id="price"><b>쿠폰 차감금액</b><font style="float: right;">-</font></div>
				    		<br>
				    		<div id="price"><b>포인트 차감금액</b><font style="float: right;">-</font></div>
				    		<br>
				    		<div id="price"><b>추가 후원금</b><font style="float: right;">0원</font></div>
				    		<br>
				    		<div id="price"><b>배송비</b><font style="float: right;">0원</font></div>
				    		<br>
				    		<div id="price" style="color: #3549EC"><b>최종결제금액</b><font style="float: right; color: #3549EC">0원</font></div>
				    		<br>
				    	</div>		    	
				    	<br><br>
				    	</div>
				    	</div>
				    	<div style="margin-top: 325px"><!-- 테스트 -->
				    	<div class="row mb-5">
		      		<div class="col-md-6" >	      		
		      			<form class="fuding_support" id="card_pay" action="paymentconfirm.me" onsubmit="return CheckForm();">
			      			
			      			<span id="support_input" style="font-size: 22px; color: black;"><b>펀딩 서포터</b></span>
			      				<br><br>
			      				<div style="background-color: #EEEDE9;">	
			      				<div class="confirmation-card-body3" style="text-align: left; padding: 10px">	      						
			      					<div>
			      						<span>이름</span><br>
			      						<b style="color: gray">정수연 ${mb.name }</b>
			      					</div>
			      					<br>
			      					<div>
			      						<span>이메일</span><br>
			      						<b style="color: gray">admin@naver.com ${mb.email }</b>
			      						
			      					</div>
			      					<br>
			      					<div>
			      						<span>휴대폰 번호</span><br>
			      						<b style="color: gray">01012341234${mb.phone }</b>
			      						
			      					</div>
			      					<hr>	      						
									<div>
										<input type="checkbox" id="check" name="selector">
										<span><b>(필수)펀딩 진행에 대한 새 소식 및 <br>&nbsp;&nbsp;&nbsp; 결제 관련 안내를 받습니다.</b></span>
										<script type="text/javascript" src="payment.js"></script>
									</div>									
			      				</div>
			      				</div>
			      			</form>	
		      			</div>
		      			<div class="col-md-6" >
		      				<div class="col-md-12">			
				      				<form class="reward_destination" action="paymentconfirm.me" onsubmit="return CheckForm();">
					     				<span id="support_input" style="font-size: 22px; color: black;"><b>리워드 배송지</b></span>
					      				<hr>
					      				<div>
					      					<span>이름</span><br>
					      					<input id="delivery_request" type="text" value="${mb.name }" size="38">
					      				</div>
					      				<br>
					      				<div>
					      					<span>휴대폰 번호</span><br>
					      					<input id="delivery_request" type="text" value="${mb.phone }" size="38">
					      				</div>
					      				<br>
					      				<div>
					      					<span>주소</span><br>
					      					<input class="adress_left" id="sample6_postcode" style="margin-top: 10px;" type="text" placeholder="우편번호"  size="22">
					      					<button class="adress_right" type="button" onclick="sample6_execDaumPostcode()">우편번호 검색
					      						<script type="text/javascript" src="payment.js"></script>
					      					</button><br>
					      					<input class="adress_bottom" id="sample6_address" style="margin-top: 10px;" type="text" placeholder="주소" size="38"><br>
					      					<input class="adress_bottom" id="sample6_detailAddress" style="margin-top: 10px;" type="text" placeholder="상세주소" size="38"><br>
					      				</div>
					      				<hr>
					      				<div>
					      					<span>배송 시 요청 사항 (선택)</span><br>
					      					<input id="delivery_request" type="text" placeholder="ex) 부재시 경비실에 보관해주세요." size="38">
					      					<div style="">해당 요청사항은 배송에 관련된 내용만 적어주세요.</div>
					      				</div>
					      			</form>
					      		 <!-- col-md-6 끝-->	
			      			</div>
		      			</div> <!-- col-md-6 끝-->  	
		      		</div>
				    	</div>
				    	
				    	
			   	<div class="order_details section-margin--small" style="background-color: #F6F6F6; " align="center">
			   		<form id="card_pay" action="paymentconfirm.me" onsubmit="return CheckForm();">
		    	  		<div style="padding: 30px 0;">		    	  	
			    	  		<span style="font-size: 22px;"><b>결제 정보 입력</b></span><br>
			    	  		<div style="padding: 7px 0 15px 0;">
			      				<span><b>신용(체크)카드번호</b></span><br>
			      				<input id="card_number" name="card_number1" type="text" style="width:100px;">
			      				<input id="card_number" name="card_number2" type="text" style="width:100px;">
			      				<input id="card_number" name="card_number3" type="text" style="width:100px;">
			      				<input id="card_number" name="card_number4" type="text" style="width:100px;">
			      			</div>
			      			<div style="margin-bottom: 15px;">
			      				<span id="validity"><b>유효기간</b></span>
			      				<span style="padding-left: 120px"><b>카드 비밀번호</b></span><br>
			      				<input id="card_validity" type="text" placeholder="MM/YY" style="width:203px;">
			      				<input id="card_password" type="text" placeholder="앞 2자리" style="width:203px;">	      					      			
			      			</div>									
			      			<div>
			      				<span><b>생년월일(주민번호 앞 6자리)</b></span><br>		      				
			      				<input id="birthday" type="text" style="width:405px;">
			      			</div>
		      			</div>
		      			<div style="padding: 10px 15px;">
		      				<span style="font-size: 17px; color: #000000;"><b>결제 예약시 유의 사항</b></span>
		      				<p style="padding-top: 10px;">
		      				- 결제실해일에 결제자 귀책사유(한도초과,이용정지 등)로 인하여 결제가 실패할 수 있으니 ,
		      				    결제수단이 유효한지 한번 확인 하세요.
		      				- 1차 결제 실패 시 실패일로부터 3영업 일 동안 재 결제를  실행합니다.&nbsp;&nbsp;
		      				- 결제 예약 이후, 결제할 카드를 변경하려면 마이페이지>
		      			   	 나의 펀딩의 결제 정보에서 카드 정보를 변경해주세요.      
		      				</p>
		      			</div>
		      		</form>	
		      		<div style="padding: 20px 0;">
		      			<span style="font-size: 22px; color: black;"><b>약관 동의</b></span><br>
		      			<table border="1px #777"; style="width: 95%; height: 150px;">
			      			<tr>
				      			<td>
				      				<input type="radio" id="allCheck"  name="checkAll">
				      				<span id="full_agreement"><b>전체 동의하기</b></span><br>	
				      			</td>
			      			</tr>
			      			<tr>
				      			<td>
				      				<input type="radio"  id="check_1" class="normal" name="checkOne">
					      			<span id="single_info"><b>제 3자에 대한 개인정보 제공 동의</b></span><br>
					      		</td>
			      			</tr>
			      			<tr>
				      			<td>
				      				<input type="radio"  id="check_2" class="normal" name="checkOne">
					      			<span id="liability_regulation"><b>책임 규정에 대한 동의</b></span>
					      		</td>
			      			</tr>
		      			</table>
		      		</div>	
		      		<div class="col-md-12 form-group" align="center" style="padding:20px 0 50px 0;">
          	 			<button type="submit" value="submit" class="button button-tracking">결제 예약하기</button>
      		 	 	</div>
      			</div>
	      		</div>
	      	<div>
	    	</div>
	    </div>
  	</section>
  <!--================End Order Details Area =================-->


 
  

<jsp:include page="../bottom.jsp" />


  <script src="${contextPath}/vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="${contextPath}/vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="${contextPath}/vendors/skrollr.min.js"></script>
  <script src="${contextPath}/vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="${contextPath}/vendors/jquery.ajaxchimp.min.js"></script>
  <script src="${contextPath}/vendors/mail-script.js"></script>
  <script src="${contextPath}/js/main.js"></script>
</body>
</html>