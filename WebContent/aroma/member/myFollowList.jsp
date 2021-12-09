<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<jsp:include page="../top1.jsp" />
  	  
    <section class="order_details section-margin--small" >
    <div class="maincontainer" style="padding: 0 140px; margin-bottom: 150px;">    	
    	<div class="col-md-12">
    	  	<div class="my_funding" style="padding-bottom:10px">
    	  		<c:if test="${type eq 'supporter'}">
    	  	  		<h2>나의 메이커 팔로잉 리스트</h2>  	
    	  	  		<p style="margin-top: 15px; font-size: 17px;">팔로잉을 맺으시면 팔로잉한 메이커들의 펀딩 활동을 편리하게 확인하실 수 있습니다. </p>
    	  	  	</c:if>
    	  	  	<c:if test="${type eq 'maker'}">
    	  	  		<h2>나의 팔로워 리스트</h2>  	
    	  	  		<p style="margin-top: 15px; font-size: 17px;">팔로잉을 맺은 팔로워들을 확인하실 수 있습니다. </p>
    	  	  	</c:if>            
	        </div>
	        <hr>
			<c:forEach var="maker" items="${makers}">
				<div>
					<div class="row" style="padding: 5px 15px;">
					  <div style="width:150px;" align="center" >
					  	<!-- c:if 마지막에 빼야함! 원래는 이미지 무조건 있음 -->
					  	<c:if test="${v.profile eq null}">	
							<img id="thumbnail" src="${pageContext.request.contextPath}/profileUpload/noImg.PNG" style="border-radius: 100px; width: 100px; height: 100px;">
						</c:if>
						<c:if test="${v.profile ne null}">
					  	<img alt="" src="${pageContext.request.contextPath}/profileUpload/${maker.profile}" width="100px" height="100px" style="border-radius: 100px;">
					  	</c:if>
					  </div>
					  <div class="col" style="padding-top: 20px;">
					  	<c:if test="${type eq 'supporter'}">
					  		<span style="font-size: 26px;">${maker.name}</span>
					    	<button type="button" class="btn btn-info" style="width:120px; height:50px; font-size:17px; font-weight:600; float: right; margin-right: 15px;" 
					    			onclick="location.href='CompanyDetail.do?makerId=${maker.userId}';">보러가기</button>
					  	</c:if>
					  	<c:if test="${type eq 'maker'}">
					  		<span style="font-size: 26px;">${maker.userId}</span>
					  	</c:if>
					  </div>
					</div>
					<hr>
				</div>
		    </c:forEach>
        </div> 
	</div>
  </section>
  
  <jsp:include page="../bottom.jsp" />

</body>
</html>