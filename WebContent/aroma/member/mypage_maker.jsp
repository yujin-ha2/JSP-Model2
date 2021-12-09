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
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
</head>
<body>
<script type="text/javascript">
function popup_profile(){
	var pop = window.open("member/popup_profile.jsp?profile=${member.profile}&mType=maker","","width=450,height=500, left=110, top=105");
}

</script>
	<jsp:include page="../top1.jsp" />
	
    
    <section class="order_details section-margin--small">
    <div class="maincontainer">  
    	<ul class="nav nav-tabs" id="myTab" role="tablist">
	  		<li class="nav-item">
	    	<a class="nav-link active" id="Maker-tab" data-toggle="tab" href="#Maker" role="tab" aria-controls="Maker" aria-selected="true">Maker</a>
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
		  			<div><br>	
		        		<h3 class="billing-title" align="center"><b>${sessionScope.id }</b>님</h3>	        	  	
			            <p id="member" align="center">메이커</p><hr>
			        </div>
	        		<div align="center">굿펀딩 계정으로 로그인 중</div>
	            	<div align="center" style="padding-top: 30px;">
		            	<button type="button" class="btn btn-secondary" onclick="location.href='${contextPath}/myInfo.me'">My 정보설정</button>
	            	</div>
         		</div>
        	</div>          	
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
						    	  	  	<div style="padding-top: 10px;">
						    	  	  		<div style="height: 55px;">
					  		    	  	  		<h6 style="padding-left: 5px;">${title}</h6>
						    	  	  		</div>
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
							<div class="col-6">답변하기<a style="float: right" href="#">&gt;</a></div>
						  	<div class="col-6" onclick="location.href='${contextPath}/fundingOpen/makerStudioMain.jsp'" style="cursor: pointer;">
						  		메이커 스튜디오<span style="float: right; color: blue;">&gt;</span>
						  	</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-6" onclick="location.href='${contextPath}/myFollowList.me?type=maker';" style="cursor: pointer;">
				  			나의 팔로워<a style="float: right" href="${contextPath}/myFollowList.me?type=maker">&nbsp; &gt;</a>
				  			</div>
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
	</div>
  	</section>
  

  <jsp:include page="../bottom.jsp" />

</body>
</html>