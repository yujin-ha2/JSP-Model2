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
  <link rel="stylesheet" href="${contextPath}/css/style.css">
</head>
<body>
<script type="text/javascript">
	function popup_profile(){
		var pop = window.open("member/popup_profile.jsp?profile=${member.profile}&mType=supporter","","width=450,height=500, left=110, top=105");
	}
</script>
	<jsp:include page="../top1.jsp" />
    
  <!--================Order Details Area =================-->
   	<section class="order_details section-margin--small">
   		<div class="maincontainer" style="padding: 0 100px;">  
	    <ul class="nav nav-tabs" id="myTab" role="tablist">
		    <li class="nav-item">
		    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#Support" role="tab" aria-controls="Support" aria-selected="true">Support</a>
		  	</li>
		</ul>	
	  	<div class="row mb-6" style="padding-top: 10px">
    	  	<div class="col-md-3">
    	  		<div class="confirmation-card">
	    	  	    <div align="center" onclick="popup_profile();">
	    	  	    	<c:if test="${empty member.profile}">
    	  	    			<c:set var="imageSrc" value="http://placehold.it/500x500/ffffff/3549EC?text=no image"/>
    	  	    		</c:if>
    	  	    		<c:if test="${!empty member.profile}">
    	  	    			<c:set var="imageSrc" value="${pageContext.request.contextPath}/profileUpload/${member.profile}"/>
						</c:if>
						<img id="thumbnail" src="${imageSrc}" align="center" style="border-radius: 100px; width: 100px; height: 100px; cursor: pointer;">
						<i class="fas fa-pen-square" style="font-size: 30px;  float: right; position: absolute; padding-top: 70px; margin-left: -20px; cursor: pointer;"></i>
	   				</div>	   			
	   				<div>
	   					<br>	
		        	  	<h3 class="billing-title" align="center"><b>${sessionScope.id }</b>님</h3>	        	  	
			            <p id="member" align="center">서포터/개인 회원</p><hr>
			        </div>
			        <div align="center">굿펀딩 계정으로 로그인 중</div>
			            <div align="center" style="padding-top: 30px;">
			            	<button type="button" class="btn btn-secondary" onclick="location.href='${contextPath}/myInfo.me'">My 정보설정</button>
			        </div>
		        </div>
	        </div>          	
         	<div class="col-md-9">
    	    	<div class="confirmation-card">
    	  	  		<h4><b>나의 프로젝트</b></h4>
    	  	  		<hr>
	    	  	  	<div class="container" style="padding-top: 25px;padding-bottom: 25px" >
						<div class="row" align="center" style="background-color: white;">
					    	<div class="col-11" align="center" style="margin-left: 30px">
					      		<h4 style="padding-top: 15px">펀딩 하기</h4>
					      		<c:set var="fundingCount" value="${fundingCount}"/>
					      		<h3 style="padding-bottom: 20px">${fundingCount}회</h3>
					    	</div>
							<button type="button" class="btn btn-primary btn-lg btn-block" style="background-color:LightSlateGray; font-size:18px; border: none;" onclick="location.href='MyFundingHistory.me';">펀딩 내역 확인</button>
						</div>
					</div>
					<hr>
	      			<div class="row">
				  		<div class="col-6">포인트<a style="float: right" href="#">${member.point} P&nbsp; &gt;</a></div>
				  		<div class="col-6" onclick="location.href='${contextPath}/myFollowList.me?type=supporter';" style="cursor: pointer;">
				  			나의 팔로잉<a style="float: right" href="${contextPath}/myFollowList.me?type=supporter">&nbsp; &gt;</a>
				  		</div>
					</div>
					<hr>
					<div class="row">
				  		<div class="col-6">메시지<a style="float: right" href="#">&gt;</a></div>
					</div>
					<hr>
					<div class="row">
				  		<div class="col-6">
				  			<img src="./img/banner1.png" style="width: 100%; height: 100%; object-fit: cover;">
			  			</div>
				  		<div class="col-6">
				  			<img src="./img/banner2.png" style="width: 100%; height: 100%; object-fit: cover;">
				  		</div>
					</div>
	          	</div>   
        	</div>       
	   	</div>
  		</div>	
  </section>
  
  <jsp:include page="../bottom.jsp" />

</body>
</html>