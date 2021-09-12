<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop</title>
	
  <link rel="icon" href="img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="vendors/linericon/style.css">
  <link rel="stylesheet" href="vendors/owl-carousel/owl.theme.default.min.css">
  <link rel="stylesheet" href="vendors/owl-carousel/owl.carousel.min.css">
  <link rel="stylesheet" href="vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="vendors/nouislider/nouislider.min.css">
     	
  <link rel="stylesheet" href="css/style.css"> 
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">	
    
  
 <!-- jQuery  --> 
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>  
 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>
<% 
	//세션id값 전달받기 
	String id=(String)session.getAttribute("id");	
%>

  <!--================Order Details Area =================-->
   <section class="order_details section-margin--small">
    <div class="container">    	
      <div class="row mb-5">
	      <div class="col-md-12 col-xl-0 mb-0 mb-xl-0">
	      	 <div class="popup_check">
		    	<a class="back" href="#">← 스토리로 돌아가기</a>	
		    		<p class="title">
		    			<strong>잠깐!</strong>
		    			결제하기가 아닌 펀딩하기인 이유를  확인하고, 펀딩하세요.
		    		</p>  
		    		<form class="form_large">
		    			<dl>
		    				<dt>
		    					<label class="check_circular">
		    						<input class="confirm-checkbox" type="checkbox" name="check2" value="Y" autocomplete="off">
		    						<span class="table_check">
		    							<b>펀딩한 리워드는 새롭게 준비하고 있는 제품·서비스입니다.</b>		    							
		    						</span>
		    					</label>
		    				</dt>
		    				<dd class="table_body">
		    					<p>펀딩 후, 리워드를 제작·준비하는 크라우드펀딩 특성상, 품질 이슈가 발생할
		    					수 있습니다.</p>
		    					<p>리워드 품질 이슈 발생시 반환·정책-<strong>상세 정책</strong>을 꼭 확인해주세요.
		    					</p>
		    				</dd>
		    				<dd>
		    					<div>
		    						<span><b>프로젝트 상세 정책</b>
		    							<i class="fas fa-angle-down" style="float:right"></i>
		    						</span>		    						
		    					</div>
		    				</dd>
		    			</dl>
		    			<dl>
		    				<dt>
		    					<label class="check_circular">
		    						<input class="confirm-checkbox" type="checkbox" name="check2" value="Y" autocomplete="off">
		    						<span class="table_check">
		    							<b>바로 결제되지 않으며, 펀딩 종료 후에는 결제를 취소할 수 없습니다.</b>		    							
		    						</span>
		    					</label>
		    				</dt>
		    				<dd class="table_body">
		    					<p>펀딩이 종료되고 목표 금액이 달성될 경우 <strong>2021.07.07</strong>에 결제가 진행됩니다.</p>
		    					<p>펀딩 종료 <strong>2021.07.06</strong> 이후에는 메이커의 프로젝트 수행을 위해 결제 취소가
		    					   불가합니다.</p>
		    				</dd>		    				
		    			</dl>
		    			<dl>
		    				<dt>
		    					<label class="check_circular">
		    						<input class="confirm-checkbox" type="checkbox" name="check2" value="Y" autocomplete="off">
		    						<span class="table_check">
		    							<b>펀딩한 리워드는 즉시 배송되지 않습니다.</b>		    							
		    						</span>
		    					</label>
		    				</dt>
		    				<dd class="table_body">
		    					<p>메이커가 약속한 리워드 발송 시작일을 확인했나요? 메이커는 펀딩이 성공해야
		    					      리워드 제작 · 준비를 진행합니다.</p>
		    					<p>리워드 펀딩 특성상 발송이 지연되거나 불가할 수 있으니, 반환·정책-<strong>상세 정책</strong> 
		    					      을 꼭 확인해주세요.</p>
		    				</dd>		    				
		    			</dl>
		    			<div>
			      			<button type="submit" class="btn btn-danger btn-block" disabled id="btn">계속해서 펀딩하기</button>			      				
			      		</div>
		    		</form>   			   		
	      	 </div>	      	
	      </div>	
	  </div> <!-- row mb-5 끝 --> 	      
	</div><!-- 컨테이너 끝  -->
	     
  	</section>
  <!--================End Order Details Area =================-->


</body>
</html>