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
	<jsp:include page="../top1.jsp" />
  	  
    <section class="order_details section-margin--small" >
    <div class="maincontainer">    	
    	<div class="col-md-12">
    	  	<div class="my_funding" style="padding-bottom:10px">
    	  	  	<h2>나의 메이커 팔로잉</h2>  	
    	  	  	<p style="margin-top: 15px; font-size: 17px;">팔로잉을 맺으시면 팔로잉한 메이커들의 펀딩 활동을 편리하게 확인하실 수 있습니다. </p>                
	        </div>
	        <hr>
			<c:forEach var="v" items="${v}">
			<div>
				<div class="row" style="padding: 5px 15px;">
				  <div style="width:150px;" align="center" >
				  	<!-- c:if 마지막에 빼야함! 원래는 이미지 무조건 있음 -->
				  	<c:if test="${v.profile eq null}">	
						<img id="thumbnail" src="${contextPath}/img/noImg.PNG" align="center" style="border-radius: 100px; width: 100px; height: 100px;">
					</c:if>
					<c:if test="${v.profile ne null}">
				  	<img alt="" src="${contextPath}/profileUpload/${v.profile}" width="100px" height="100px" style="border-radius: 100px;">
				  	</c:if>
				  </div>
				  <div class="col" style="padding-top: 20px;">
				  	<span style="font-size: 26px;">${v.name }</span>
				    <button type="button" class="btn btn-info" style="float: right; margin-right: 15px;" 
				    		onclick="location.href='CompanyDetailAction.go?companyId=${v.userId}&companyName=${v.name}'">보러가기</button>
				  </div>
				</div>
				<hr>
			</div>
		    </c:forEach>
        </div> 
	</div>
  </section>

  <!-- 팔로잉 리스트 페이지만 bottom 박아넣음 ㅎ 내용이 없어서 하단에 고정이 안됨 -->
  <div style="position: fixed; bottom: 0; width: 100%;">
	  <jsp:include page="../bottom.jsp" />
  </div>

  <script src="${contextPath}/vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="${contextPath}/vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="${contextPath}/vendors/skrollr.min.js"></script>
  <script src="${contextPath}/vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="${contextPath}/vendors/jquery.ajaxchimp.min.js"></script>
  <script src="${contextPath}/vendors/mail-script.js"></script>
  <script src="${contextPath}/js/main.js"></script>
</body>
</html>