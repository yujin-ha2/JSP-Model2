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
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script type="text/javascript" src="${contextPath}/js/payment.js"></script>
  <script type="text/javascript">
  	$(function(){
  		var allChecked = true;
  		var isChecked_1 = true;
  		var isChecked_2 = true;
  		
  		//약관동의
		$('input[name="allCheck"]').click(function() {
			$("#allCheck").prop('checked', allChecked);
			$("#check_1").prop('checked', allChecked);
			$("#check_2").prop('checked', allChecked);
			allChecked = ($('input:radio[name="allCheck"]').is(':checked')) ? false : true;
			isChecked_1 = allChecked;
			isChecked_2 = allChecked;
		});
		
		$('input[id="check_1"]').click(function() {
			$("#check_1").prop('checked', isChecked_1);
			if(isChecked_1 == false)
				$("#allCheck").prop('checked', false);
			isChecked_1 = ($('input:radio[id="check_1"]').is(':checked')) ? false : true;
		});
		
		$('input[id="check_2"]').click(function() {
			$("#check_2").prop('checked', isChecked_2);
			if(isChecked_1 == false)
				$("#allCheck").prop('checked', false);	
			isChecked_2 = ($('input:radio[id="check_2"]').is(':checked')) ? false : true;
		});
		
		//추가후원금
		$('input[id="donation"]').on("change keyup paste", function() {
			$("#additionalDonation").text($(this).val());
			changeTotalAmount();
		});
		
		//포인트 모두 사용 체크
		$('input[id="pointCheck"]').change(function() {
			if($("#pointCheck").is(":checked")){
				$("#point").val("${member.point}");
				$("#usedPoint").text("${member.point}");
				changeTotalAmount();
			}
		});
		
		//포인트 차감 금액 
		$('input[id="point"]').on("change keyup paste", function() {
			$("#pointCheck").prop('checked', false);
			$("#usedPoint").text($(this).val());
			changeTotalAmount();
		});
		
		
  	});
  	
  	function changeTotalAmount() {
		var rewardPrice =  Number("${totalPrice + deliveryFee}") + Number($("#donation").val());
		var point = Number($("#point").val());
		var amount = rewardPrice - point;
		//console.log("amount: " + "${totalPrice + deliveryFee}" +", donation: " + Number($("#donation").val()));
		//console.log("rewardPrice: " + rewardPrice + ", point: " + point);
		
		$("#totalAmount").text(amount);
	}
  	
	function pay() {
		$("#finalPayment").val($("#totalAmount").text());
		payForm.submit();
	}  	
	
  </script>
  <style type="text/css">
  	.totalReceiptDt{
  		display: table-cell; 
  		width: 140px; 
  		padding: 7px 0 7px 15px; 
  		font-size: 14px; 
  		font-weight: 500;
  	}
  	
  	.totalReceiptDd{
  		display: table-cell; 
  		padding: 7px 15px 7px 0; 
  		font-size: 14px; 
  		text-align: right;
  		color: #4a4a4a;
  	}
  	
  	.rewardInput{
  		border: 1px solid #A29584; 
  		border-radius: 3px; 
  		height: 36px; 
  		margin-bottom: 10px;
  	}
  </style>
</head>
<body>


<jsp:include page="../top1.jsp" />
	
    <section class="order_details section-margin--small">
    <div class="container" style="width: 750px; margin:0 auto; ">    	
    <form id="payForm" name="payForm" method="post" action="fundingPayment.do" onsubmit="CheckForm();">
    	<input type="hidden" id="fundingId" name="fundingId" value="${orderList[0].fundingId}">
    	<input type="hidden" id="userId" name="userId" value="${member.id}">
    	<input type="hidden" id="deliveryFee" name="deliveryFee" value="${deliveryFee}">
    	<input type="hidden" id="originalPayment" name="originalPayment" value="${totalPrice + deliveryFee}">
    	<input type="hidden" id="myPoint" name="myPoint" value="${member.point}">
    	<input type="hidden" id="finalPayment" name="finalPayment" value="">
    	
    	<div>
    		<div style="padding: 30px 0 40px;">
    			<h2>결제 예약</h2>
    		</div>
    		<div>
    			<div style="border-top: 1px solid #666;">
    				<ul>
    					<li style="padding: 15px; border-bottom: 1px solid #e4e4e4;">
    						<p style="margin: 8px 0 12px; font-size: 19px; font-weight:bold; line-height: 17px; color: #6b90dc;">${orderList[0].title}</p>
    						<c:forEach var="order" items="${orderList}">
    							<input type="hidden" id="rewardId" name="rewardId" value="${order.rewardId}">
    							<input type="hidden" id="rewardNumber" name="rewardNumber" value="${order.rewardNumber}">
	    						<p style="margin-bottom: 8px; font-size: 16px; line-height: 19px; color: #6b90dc;">${order.rewardOption}</p>
	    						<p style="margin-bottom: 0; font-size: 12px; line-height: 16px; color: #686868;">${order.rewardDetail}</p>
	    						<div>
	    							<p style="font-size: 14px; line-height: 24px; font-weight: 500; text-align: right; color:#4a4a4a; margin-bottom: 5px;">
	    								<em style="padding-right: 25px;  font-style: normal;">수량 : ${order.rewardNumber}</em>${order.rewardPrice}원
	    							</p>
	    						</div>	
    						</c:forEach>
    					</li>
    				</ul>	
    			</div>
    			<div>
    				<dl style="border-top: 1px solid #e4e4e4; width: 100%; display: table;">
    					<dt style="display: table-cell; width: 140px; padding: 15px 0 15px 15px; font-size: 14px; font-weight: 500;">추가후원금</dt>
    					<dd style="display: table-cell; padding: 15px; font-size: 14px; text-align: right;">
    						<input type="text" id="donation" name="donation" style="width: 120px; height: 30px; margin-right: 3px; direction: rtl;" onKeydown="javascript:handlerNum(this)">
    					</dd>
    				</dl>
    				<dl style="border-top: 1px solid #e4e4e4; width: 100%; display: table;">
    					<dt style="display: table-cell; width: 140px; padding: 15px 0 15px 15px; font-size: 14px; font-weight: 500;">배송비</dt>
    					<dd style="display: table-cell; padding: 15px 15px 15px 0; font-size: 14px; text-align: right; color:#4a4a4a;">${deliveryFee}원</dd>
    				</dl>
    				<div style="border-top: 1px dashed #666; background: #f9f9f9;">
						<dl style="border-top: 1px solid #e4e4e4; width: 100%; display: table; margin-bottom: 0;">
							<dt style="display: table-cell; width: 140px; padding: 15px 0 15px 15px; font-size: 14px; font-weight: 500;">포인트 사용</dt> 
							<dd style="display: table-cell; padding: 15px 15px 15px 0; font-size: 14px; text-align: right;">
								<div style="margin-bottom: 6px; font-size: 14px; text-align: right;">
									<input type="checkbox" id="pointCheck">
									<span style="position: relative; display: inline-block; color:#4a4a4a;">모두 사용(보유 포인트 <span id="originalPoint">${member.point}</span>P)</span>
								</div>
								<!-- <input type="text" maxlength="8" disabled="disabled" style="width: 150px; height: 30px;"> -->
								<input type="text" id="point" name="point" maxlength="8" style="width: 150px; height: 30px; color: #FF6879; direction: rtl;" onKeydown="javascript:handlerNum(this)">
							</dd>
						</dl>    				
            		</div> 
            		<div style="padding: 10px 0; background-color: #ececec;">
            			<dl style="display: table; width: 100%;">
            				<dt class="totalReceiptDt">펀딩금액</dt>
            				<fmt:formatNumber var="price" value="${totalPrice}" pattern="###,###"/>
            				<dd class="totalReceiptDd"><span>${price}</span>원</dd>
            			</dl>
            			<dl style="display: table; width: 100%;">
            				<dt class="totalReceiptDt">포인트 차감금액</dt>
            				<dd class="totalReceiptDd"><span id="usedPoint">0</span>원</dd>
            			</dl>
            			<dl style="display: table; width: 100%;">
            				<dt class="totalReceiptDt">추가 후원금</dt>
            				<dd class="totalReceiptDd"><span id="additionalDonation">0</span>원</dd>
            			</dl>
            			<dl style="display: table; width: 100%;">
            				<dt class="totalReceiptDt">배송비</dt>
            				<dd class="totalReceiptDd"><span>${deliveryFee}</span>원</dd>
            			</dl>
            			<dl style="display: table; width: 100%;">
            				<c:set var="amount" value="${totalPrice + deliveryFee}"/>
            				<dt class="totalReceiptDt">최종결제금액</dt>
            				<dd class="totalReceiptDd"><span id="totalAmount">${amount}</span>원</dd>
            			</dl>
            		</div>
    			</div>
    		</div>
    		<div style="margin-top: 20px;">
		    	<div class="row mb-5">
		    		<div class="col-md-6" >	
		    			<span id="support_input" style="font-size: 22px; color: black;"><b>펀딩 서포터</b></span>      		
		   				<div style="background-color: #EEEDE9; text-align: left; padding: 10px; margin-top: 20px;">	
		   						<dl style="margin-bottom: 15px;">
		    						<dt style="margin-bottom: 8px; font-size: 14px;">이름</dt>
		    						<dd style="line-height: 36px; font-size: 14px; color: #9B9B9B;">${member.name}</dd>
		    					</dl>
		    					<dl style="margin-bottom: 15px;">
		    						<dt style="margin-bottom: 8px; font-size: 14px;">이메일</dt>
		    						<dd style="line-height: 36px; font-size: 14px; color: #9B9B9B;">${member.email}</dd>
		    					</dl>
		    					<dl style="margin-bottom: 15px;">
		    						<dt style="margin-bottom: 8px; font-size: 14px;">휴대폰 번호</dt>
		    						<dd style="line-height: 36px; font-size: 14px; color: #9B9B9B;">${member.phone}</dd>
		    					</dl>
		    			</div>
     				</div>
	      			<div class="col-md-6" >
	     				<span id="support_input" style="font-size: 22px; color: black;"><b>리워드 배송지</b></span>
	      				<hr>
	      				<div style="padding: 0 20px 10px; border-bottom: 1px solid #e4e4e4;">
		      				<div>
		      					<p style="font-size: 14px; font-weight: bold; margin-bottom: 5px; color: #4a4a4a;">이름</p>
		      					<input class="rewardInput" id="receiverName" name="receiverName" type="text" value="${member.name}" size="38">
		      				</div>
		      				<div>
		      					<span>휴대폰 번호</span><br>
		      					<input class="rewardInput" id="receiverPhone" name="receiverPhone" type="text" value="${member.phone}" size="38">
		      				</div>
		      				<div>
		      					<span>주소</span><br>
		      					<input class="adress_left rewardInput" id="postcode" name="postcode" type="text" placeholder="우편번호"  size="22">
		      					<button class="btn btn-outline-primary btn-sm" style="height: 36px;" type="button" onclick="daumPostcode()">우편번호 검색</button>
		      					<input class="adress_bottom rewardInput" id="address" name="address" type="text" placeholder="주소" size="38"><br>
		      					<input class="adress_bottom rewardInput" id="detailAddress" name="detailAddress" type="text" placeholder="상세주소" size="38"><br>
		      				</div>
	      				</div>
	      				<div style="margin-top: 15px; padding: 10px 20px 10px; border-bottom: 1px solid #e4e4e4;">
	      					<span>배송 시 요청 사항 (선택)</span><br>
	      					<input class="rewardInput" id="deliveryRequest" name="deliveryRequest" type="text" placeholder="ex) 부재시 경비실에 보관해주세요." size="38">
	      					<p style="font-size: 12px; color: #a29584;">해당 요청사항은 배송에 관련된 내용만 적어주세요.</p>
	      				</div>
	      			</div> 
	      		</div>
	      	</div>
		   	<div class="order_details section-margin--small" style="margin-bottom: 20px;">
    	  		<h3 style="padding-top: 20px; font-size: 22px; color: black;">결제 정보</h3>
    	  		<div style="background-color: #F6F6F6; " align="center">
	    	  		<div style="padding-top: 20px;">
	      				<span><b>신용(체크)카드번호</b></span><br>
	      				<input class="rewardInput" id="card_number1" name="card_number" type="text" maxlength="4" style="width:100px;" onKeydown="javascript:handlerNum(this)">
	      				<input class="rewardInput" id="card_number2" name="card_number" type="text" maxlength="4" style="width:100px;" onKeydown="javascript:handlerNum(this)">
	      				<input class="rewardInput" id="card_number3" name="card_number" type="password" maxlength="4" style="width:100px;" onKeydown="javascript:handlerNum(this)">
	      				<input class="rewardInput" id="card_number4" name="card_number" type="password" maxlength="4" style="width:100px;" onKeydown="javascript:handlerNum(this)">
	      			</div>
	      			<div style="padding-top: 20px;">
	      				<span id="validity"><b>유효기간</b></span>
	      				<span style="padding-left: 120px"><b>카드 비밀번호</b></span><br>
	      				<input class="rewardInput" id="card_validity" name="card_validity" type="text" placeholder="MM/YY" style="width:203px;">
	      				<input class="rewardInput" id="card_password" name="card_password" type="password" placeholder="앞 2자리" maxlength="2" style="width:203px;" onKeydown="javascript:handlerNum(this)">	      					      			
	      			</div>									
	      			<div style="padding: 20px 0;">
	      				<span><b>생년월일(주민번호 앞 6자리)</b></span><br>		      				
	      				<input class="rewardInput" id="birthday" name="birthday" type="text" maxlength="6" style="width:405px;" onKeydown="javascript:handlerNum(this)">
	      			</div>
     			</div>
     			<div style="padding: 20px 0;">
	      			<span style="font-size: 17px; color: #000000; padding-bottom: 10px;"><b>결제 예약시 유의 사항</b></span>
	   				<p style="font-size: 14px;">
	    				- 결제실해일에 결제자 귀책사유(한도초과,이용정지 등)로 인하여 결제가 실패할 수 있으니, 결제수단이 유효한지  한번 확인 하세요. <br>
	    				- 1차 결제 실패 시 실패일로부터 3영업 일 동안 재 결제를 실행합니다.<br>
	    				- 결제 예약 이후, 결제할 카드를 변경하려면 마이페이지 >나의 펀딩의 결제 정보에서 카드 정보를 변경해주세요.<br>         
	    			</p>
	     		</div>
     		</div>
	      	<div style="margin-top: 20px;">
	      		<div>
	      			<h3 style="margin-bottom: 16px;">약관 동의</h3>
	      			<table style="width: 705px; height: 150px; border: 1px solid #f0f2f5;">
		      			<tr style="border-bottom: 1px solid #f0f2f5;">
			      			<td style="padding: 3px 15px; font-weight: 400;">
			      				<input type="radio" id="allCheck"  name="allCheck">
			      				<span><b>전체 동의하기</b></span><br>	
			      			</td>
		      			</tr>
		      			<tr>
			      			<td style="padding: 3px 15px; font-weight: 400;">
			      				<input type="radio"  id="check_1">
				      			<span><b>제 3자에 대한 개인정보 제공 동의</b></span><br>
				      		</td>
		      			</tr>
		      			<tr>
			      			<td style="padding: 3px 15px; font-weight: 400;">
			      				<input type="radio"  id="check_2">
				      			<span><b>책임 규정에 대한 동의</b></span>
				      		</td>
		      			</tr>
	      			</table>
	      		</div>	
	      		<div class="col-md-12 form-group" align="center" style="padding-top: 30px">
         	 		<input type="button" value="submit" class="button button-tracking" style="font-weight: 500; font-size: 15p; cursor: pointer;" value="결제 예약하기" onclick="pay();">
     		 	</div>
	      	</div>
	    </div>
    </form>	      
    </div>
 	</section>


<jsp:include page="../bottom.jsp" />

</body>
</html>