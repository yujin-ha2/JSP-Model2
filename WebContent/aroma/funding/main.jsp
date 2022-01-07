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
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.7/css/swiper.min.css'>
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css'>
  <link rel="stylesheet" href="${contextPath}/vendors/swiper/style.css">
</head>
<body> 
<jsp:include page="../top1.jsp" />

  <section class="hero-slider hero-style">
	  <div class="swiper-container">
	    <div class="swiper-wrapper">
		    <c:forEach var="banner" items="${banners}">
			      <div class="swiper-slide" style="cursor: pointer;">
			        <div class="slide-inner slide-bg-image" data-background="${pageContext.request.contextPath}/bannerUpload/${banner.savedFileName}" onclick="location.href='${banner.link}';"></div>
			      </div>
		     </c:forEach>
        </div>
      </div>
      <!-- swipper controls -->
      <div class="swiper-pagination"></div>
      <div class="swiper-button-next"></div>
      <div class="swiper-button-prev"></div>
  </section>

  <section class="blog_area single-post-area py-80px section-margin--small" style="margin: 0 0 60px; border-bottom: 1px solid #f0f2f5;">
		<div class="maincontainer">
			<div class="row">
				<div class="col-lg-8 centerLine" style="padding: 50px 40px;">
				<h3 class="widget_title">이 프로젝트 어때요?</h3>  <!-- 5개 -->
					<div class="row">
						<c:forEach var="recent" items="${recentList}">
							<div class="col-md-6 col-lg-4 col-xl-4">
								<a href="fundingStory.do?fundingId=${recent.fundingId}">
					            	<div class="card card-product">
					              		<div class="card-product__img">
					                		<img class="card-img" src="${pageContext.request.contextPath}/fundingUpload/${recent.mainImg}" style="height: 150px; width: 243px;">
					              		</div>
					              		<div class="card-body" style="padding: 0;">
					                		<p class="card-product__price" style="color: #000000D6; font-size: 15px; font-weight: 400; height: 50px;">${recent.fundingTitle}</p>
					                		<p class="categorySmallname"><span class="fundingProgress">${recent.achievement}%</span>&nbsp; ${recent.categoryName}</p>
					              		</div>
					            	</div>
				            	</a>
				          </div>
			          </c:forEach>
					</div>
				</div>
				<div class="col-lg-4" style="padding-top: 50px; padding-bottom: 50px;">
					<div class="blog_right_sidebar">
				 	<aside class="single_sidebar_widget popular_post_widget">
						<h3 class="widget_title">실시간 랭킹</h3> <!-- 6개 -->
							<c:forEach var="lanking" items="${lankingList}" varStatus="status">
								<div class="media post_item" onclick="location.href='fundingStory.do?fundingId=${lanking.fundingId}';" style="cursor: pointer;">
									<div class="rankingNum">${status.count}</div>
									<div style="padding-left: 10px; padding-right: 20px; width: 255px;">
										<h3 style="font-size: 14px; line-height: 20px; color: #374047; margin-bottom: 4px;">${lanking.fundingTitle}</h3>
										<p class="categorySmallname"><span class="fundingProgress">${lanking.achievement}%</span>&nbsp; ${lanking.categoryName}</p>
									</div>
									<img src="${pageContext.request.contextPath}/fundingUpload/${lanking.mainImg}" style="height: 70px; width: 105px;">
								</div>
							</c:forEach>
					</aside>
				</div>
			</div>
		</div>
		</div>
	</section>
	
    <jsp:include page="../bottom.jsp" />
	
  <script src='https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js'></script>
  <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js'></script>
  <script src="${contextPath}/vendors/swiper/script.js"></script>
  
</body>
</html>