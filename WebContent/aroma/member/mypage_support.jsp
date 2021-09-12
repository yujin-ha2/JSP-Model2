<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String id = (String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop - Login</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="icon" href="${contextPath}/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nouislider/nouislider.min.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
</head>
<body>
<script type="text/javascript">
function popup_coupon(){
	window.open("member/popup_coupon.jsp","","width=400,height=200");
}
function popup_profile(){
	var profile = '<c:out value="${mb.profile}"/>';
	var pop = window.open("member/popup_profile.jsp?profile="+profile,"","width=340,height=450, left=110, top=105");
}

</script>
	<jsp:include page="../top1.jsp" />
    
  <!--================Order Details Area =================-->
   <section class="order_details section-margin--small">
    <div class="container">  
      	
    <ul class="nav nav-tabs" id="myTab" role="tablist">
	  <li class="nav-item">
	    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#Support" role="tab" aria-controls="Support" aria-selected="true">Support</a>
	  </li>
	</ul>
	<div class="tab-content" id="myTabContent">
	
	   <!--========== Support Tab 영역 시작 ==========-->
	  <div class="tab-pane fade show active" id="Support" role="tabpanel" aria-labelledby="Support-tab">
	  <div class="row mb-6" style="padding-top: 10px">
    	  <div class="col-md-3">
    	  	<div class="confirmation-card">
    	  	<c:set var="mb" value="${mb }"/>
    	  	    <div align="center"  onclick="popup_profile()">
			    	<c:set var="img" value="${mb.profile }"/>
					<c:if test="${img ne null}">
						<img id="thumbnail" src="/goodFunding/upload/${mb.profile }" align="center" style="border-radius: 100px; width: 100px; height: 100px;">
						<i class="fas fa-pen-square" style="font-size: 30px;  float: right; position: absolute; padding-top: 70px; margin-left: -20px;"></i>
					</c:if>
					<c:if test="${img eq null}">
						<img id="thumbnail" src="http://placehold.it/500x500/ffffff/3549EC?text=no image" align="center" style="border-radius: 100px; width: 100px; height: 100px;">
						<i class="fas fa-pen-square" style="font-size: 30px;  float: right; position: absolute; padding-top: 70px; margin-left: -20px;"></i>
					</c:if>
   				</div>	   			
   					
   				<div><br>	
	        	  <h3 class="billing-title" align="center"><b>${sessionScope.id }</b>님</h3>	        	  	
		            <p id="member" align="center">서포터/개인 회원</p><hr>
		        </div>
		        <div align="center">굿펀딩 계정으로 로그인 중</div>
		            <div align="center" style="padding-top: 30px;">
		            	<button type="button" class="btn btn-secondary" onclick="location.href='${contextPath}/member/memberFindId.jsp'">My 정보설정</button>
		            </div>
	         	</div>
	           
        	</div> <!-- confirmation-card -->         	
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
					<button type="button" class="btn btn-primary btn-lg btn-block" style="background-color:LightSlateGray; font-size:18px; border: none;" onclick="location.href=''">펀딩 내역 확인</button>
					</div>
				</div><hr>
				
				
	      		<div class="row" >
	      		<c:if test="${mb.coupon eq 0 }">
				  <div class="col-6">쿠폰<a style="float: right" href="#">쿠폰 받으러 가기&nbsp; &gt;</a></div>
				 </c:if>
				 <c:if test="${mb.coupon ne 0 }">
				  <div class="col-6">쿠폰<a style="float: right" onclick="popup_coupon()">사용 가능한 쿠폰 ${mb.coupon }장&nbsp; &gt;</a></div>
				 </c:if>
				  <div class="col-6">포인트<a style="float: right">${mb.point } P&nbsp; &gt;</a></div>
				</div><hr>
				<div class="row">
				  <div class="col-6" style="padding-right: 20px">
				  <img alt="" src="./img/banner1.png">
				  </div>
				  <div class="col-6">
				  <img alt="" src="./img/banner2.png">
				  </div>
				</div><hr>
				
				<h4><b>나의 활동</b></h4>
	      		<div class="row" style="padding-top:7px">
				  <div class="col-6">좋아한<a style="float: right">&gt;</a></div>
				  <div class="col-6" onclick="location.href='${contextPath}/myFollowList.me'">나의 팔로잉<a style="float: right">&gt;</a></div>
				</div><hr>
				<div class="row">
				  <div class="col-6">메시지<a style="float: right">&gt;</a></div>
				</div><hr>
				
				
	          </div>   
        	</div>       
	   	</div>
	  </div><!-- Support Tab 영역 시작 -->
	 
	</div><!-- 네브탭 -->
	
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