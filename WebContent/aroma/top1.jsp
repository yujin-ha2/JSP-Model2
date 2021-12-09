<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
<%--   <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nouislider/nouislider.min.css"> --%>
  <link rel="stylesheet" href="${contextPath}/css/style.css">
<title>Insert title here</title>
<script type="text/javascript">
$(function() {
	$("#searchInput").on("keyup",function(key){
	    if(key.keyCode==13) {
	        var keyword = $("#searchInput").val();
	        location.href='${contextPath}/fundingListAction.do?keyword='+keyword;
	    }
	});
});
</script>
<style type="text/css">
.search-c #searchInput{
  min-width: 295px;
  height: 40px;
  background: #f0f2f5;
  border: none;
  font-size: 11pt;
  float: left;
  color: #63717f;
  padding-left: 45px;
  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;
  border-radius: 20px;
}

.search-c .icon{
  position: absolute;
  top: 50%;
  margin-left: 17px;
  margin-top: 10px;
  z-index: 100; 
  color: #4f5b66;
}

.search-2 #searchInput:focus, .search-2 #searchInput:active{
  outline:none;
  width: 300px;
}

.coupon_area{
  background-color:  #3549EC;
  height:35px;
  text-align: center;
  padding-top: 5px;
}
.coupon_top li a{
  color: white;
}

</style>
</head>
<body>
	<div class="coupon_area">
 	<ul class="coupon_top">
 	  <li><a href="coupon.jsp"> 회원가입 시 3000 포인트 증정</a></li>
 	</ul>
 	</div>
      <!--================ Start Header Menu Area =================-->
    <header class="header_area">
    <div class="main_menu">
      <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container" style="padding: 0;">
          <a class="navbar-brand logo_h" href="${contextPath}/main.do"><img alt="" src="${contextPath}/img/mainLogo_sm.png"></a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
            <ul class="nav navbar-nav menu_nav mr-auto" style="padding-left: 20px;">
              <li class="nav-item submenu dropdown">
                <a href="${contextPath}/fundingList.do" class="nav-link"  role="button" aria-haspopup="true" aria-expanded="false">펀딩하기</a>
              </li>
              <li class="nav-item submenu dropdown">
                <a href="${contextPath}/fundingOpenMain.on" class="nav-link" role="button" aria-haspopup="true" aria-expanded="false">펀딩오픈</a>
              </li>
              <li class="nav-item submenu dropdown">
             	<a href="${contextPath}/noticeList.do" class="nav-link" role="button" aria-haspopup="true" aria-expanded="false">공지사항</a>
              </li>
            </ul>

			<ul class="nav">
			  <li class="" style="padding-right: 17px;">
              	<div class="search-c" style="position: relative;">
              		<span class="icon"><i class="ti-search"></i></span>
              		<input type="search" id="searchInput" placeholder="어떤 프로젝트를 찾고 계신가요?" style="position:relative;"/>
              	</div>
              </li>
             </ul>
             <c:set var="id" value="${sessionScope.id }"/>
             <c:if test="${id ne null}">
             <ul class="nav-shop">
			  <c:set var="authority" value="${sessionScope.authority}"/>
			  <li class="nav-item" style="margin-left: 3px;">
			  <c:choose>
			  		<c:when test="${authority eq '관리자'}">
			  			<c:set var="url" value="MemberManagement.ad"/>
			  		</c:when>
			  		<c:when test="${authority ne '관리자'}">
			  			<c:set var="url" value="Mypage.me"/>
			  		</c:when>
			  	</c:choose>
				<button onclick="location.href='${contextPath}/${url}'">
		  		<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
				  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
				  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
				</svg>
			  	</button>
			  </li>
			</ul>   
			</c:if>
             <ul class="nav"> 
              <c:choose>
              <c:when test="${id eq null}">
              	<li class="" style="padding-right: 10px; line-height: 40px;"><a href="${contextPath}/login.me" style=" color: #676363;">로그인</a></li>
              	<li class="" style="line-height: 40px; color: #222222;"><a href="${contextPath}/join.me" style=" color: #676363;">회원가입</a></li>
              </c:when>
              <c:when test="${id ne null}">
              	<li class="" style="padding-right: 10px; line-height: 40px;"><a style=" color: #676363;">${sessionScope.id}님</a></li>
              	<li class="" style="line-height: 40px; color: #222222;"><a href="${contextPath}/logout.me" style=" color: #676363;">로그아웃</a></li>
              </c:when>
              </c:choose>
			</ul>
          </div>
        </div>
      </nav>
    </div>
  </header>
  
    <!--================ End Header Menu Area =================-->
   <script src="${contextPath}/vendors/jquery/jquery-3.2.1.min.js"></script>
<%--  <script src="${contextPath}/vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="${contextPath}/vendors/skrollr.min.js"></script>
  <script src="${contextPath}/vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="${contextPath}/vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="${contextPath}/vendors/jquery.ajaxchimp.min.js"></script>
  <script src="${contextPath}/vendors/mail-script.js"></script>
  <script src="${contextPath}/js/main.js"></script> --%>
</body>
</html>