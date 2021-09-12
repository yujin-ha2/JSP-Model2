<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
function popup_profile(){
	var profile = '<c:out value="${mb.profile}"/>';
	var pop = window.open("member/popup_profile.jsp?profile="+profile,"","width=340,height=450, left=110, top=105");
}

</script>
	<jsp:include page="../top1.jsp" />
    
  <!--================Order Details Area =================-->
   <section class="order_details section-margin--small">
    <div class="maincontainer">  
      	
    <ul class="nav nav-tabs" id="myTab" role="tablist">
	  <li class="nav-item">
	    <a class="nav-link active" id="Maker-tab" data-toggle="tab" href="#Maker" role="tab" aria-controls="Maker" aria-selected="true">Maker</a>
	  </li>
	</ul>
	<div class="tab-content" id="myTabContent">
	
	   <!--========== Support Tab 영역 시작 ==========-->
	  <div class="tab-pane fade show active" id="Support" role="tabpanel" aria-labelledby="Support-tab">
	  <div class="row mb-6" style="padding-top: 10px">
    	  <div class="col-md-3">
    	  	<div class="confirmation-card">
    	  	
  	  	    <div align="center" onclick="popup_profile()">
	 			<c:set var="img" value="${mb.profile }"/>
				<c:if test="${img ne null}">
					<img id="thumbnail" src="/goodFunding/profileUpload/${img}" align="center" style="border-radius: 100px; width: 100px; height: 100px;">
					<i class="fas fa-pen-square" style="font-size: 30px;  float: right; position: absolute; padding-top: 70px; margin-left: -26px;"></i>
				</c:if>
				<c:if test="${img eq null}">
					<img id="thumbnail" src="http://placehold.it/500x500/ffffff/3549EC?text=noimage" align="center" style="border-radius: 100px; width: 100px; height: 100px;">
					<i class="fas fa-pen-square" style="font-size: 30px;  float: right; position: absolute; padding-top: 70px; margin-left: -20px;"></i>
				</c:if>
   			</div>	   			
   					
  			<div><br>	
        		<h3 class="billing-title" align="center"><b>${sessionScope.id }</b>님</h3>	        	  	
	            <p id="member" align="center">메이커</p><hr>
	        </div>
	        
	        <div align="center">굿펀딩 계정으로 로그인 중</div>
	            <div align="center" style="padding-top: 30px;">
	            	<button type="button" class="btn btn-secondary" onclick="location.href='FindIdForm.me'">My 정보설정</button>
	            </div>
         	</div>
	           
        	</div> <!-- confirmation-card -->         	
         	<div class="col-md-9">
    	  	  <div class="confirmation-card">
    	  	  	<div>
    	  	  		<h4 style="font-weight: 700;">만든 펀딩  <span style="color: #00B2B2;">${projectList.size()}</span></h4>
    	  	  		
    	  	  	</div>
    	  	  	<hr>
				  <div class="container" style="padding-top: 5px">
				  <%-- 이전에 생성한 프로젝트가 없는 경우 --%>
		   		  <c:if test="${projectList == null}">
					  <div align="center" style="padding: 50px 0;">
						  <p style="font-size: 20px; font-weight: 700;"> 등록된 프로젝트가 없습니다. </p>
					  </div>
				  </c:if>
				  <%-- 이전에 생성한 프로젝트가 있는 경우 --%>
				  <div style="padding: 0 10px 0 5px;">
			   	  <div class="row">
					<c:if test="${projectList != null}">
					  <c:forEach var="list" items="${projectList}" begin="0" end="3" step="1">
  					    <c:choose>
  					  	<c:when test="${list.mainImg ne null}">
					  		<c:set var="mainImg" value="${list.mainImg}"></c:set>
					  	</c:when>
					  	<c:otherwise>
					  		<c:set var="mainImg" value="noImg.PNG"></c:set>
					  	</c:otherwise>
					  </c:choose>
					  
					  <c:choose>
					  	<c:when test="${list.title ne null}">
					  		<c:set var="title" value="${list.title}"></c:set>
					  	</c:when>
					  	<c:otherwise>
					  		<c:set var="title" value="제목을 입력해주세요."></c:set>
					  	</c:otherwise>
					  </c:choose>
			  
				  	  <div class="col-md-3">
				       <img src="${contextPath}/img/${mainImg}" style="height:140px; width: 190px;">
		    	  	  	 <div>
  		    	  	  		<h6 style="padding-top: 10px; padding-left: 5px;">${title}</h6>
		    	  	  		<p style="padding-left: 5px">${list.status}</p>
		    	  	  	 </div>
				      </div>
				    </c:forEach>
				    </c:if>
				  </div>
				  </div>
	      		<div style="padding: 15px 0 30px 0;">
	      			<button type="button" class="btn btn-primary btn-lg btn-block" style="background-color:LightSlateGray; font-size:18px; border: none;" 
	      					onclick="location.href='${contextPath}/myprojectList.on'">만든 펀딩 더보기</button>
	      			<button type="button" class="btn btn-primary btn-lg btn-block" style="background-color:LightSlateGray; font-size:18px; border: none;" 
	      					onclick="location.href='${contextPath}/fundingOpenMain.on'">펀딩 오픈 신청하기</button>
	      		</div>
	      		<hr>
	      		<div class="row">
				  <div class="col-6" onclick="" style="cursor: pointer;">
				  	답변하기
				  	<span style="float: right">&gt;</span>
				  </div>
				  <div class="col-6" onclick="location.href='${contextPath}/fundingOpen/makerStudioMain.jsp'" style="cursor: pointer;">
				  	메이커 스튜디오
				  	<span style="float: right; color: blue;">&gt;</span>
				  </div>
				</div>
				<hr>
	          </div>   
        	</div>       
	   	</div>
	  </div><!-- Support Tab 영역 끝 -->
	</div><!-- 네브탭 -->
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