<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nouislider/nouislider.min.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
<title>Insert title here</title>
<style type="text/css">
.search-c #search{
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

.search-2 #search:focus, .search-2 #search:active{
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
          <a class="navbar-brand logo_h" href="${contextPath}/Main.me"><img alt="" src="${contextPath}/img/mainLogo_sm.png"></a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
            <ul class="nav navbar-nav menu_nav mr-auto" style="padding-left: 20px;">
              <li class="nav-item submenu dropdown">
                <a href="${contextPath}/FundingListAction.do?category=0&statusVal=0&sortVal=0" class="nav-link"  role="button" aria-haspopup="true" aria-expanded="false">펀딩하기</a>
              </li>
              <li class="nav-item submenu dropdown">
                <a href="${contextPath}/fundingOpenMain.on" class="nav-link" role="button" aria-haspopup="true" aria-expanded="false">펀딩오픈</a>
              </li>
              <li class="nav-item submenu dropdown">
             	<a href="#" class="nav-link dropdown-toggle" role="button" aria-haspopup="true" aria-expanded="false">공지사항</a>
              </li>
            </ul>

			<ul class="nav">
			  <li class="" style="padding-right: 17px;">
              	<div class="search-c" style="position: relative;">
              		<form action="">
              		<span class="icon"><i class="ti-search"></i></span>
              		<input type="search" id="search" placeholder="어떤 프로젝트를 찾고 계신가요?" style="position:relative;"/>
              		</form>
              	</div>
              </li>
             </ul>
             <c:set var="id" value="${sessionScope.id }"/>
             <c:if test="${id ne null}">
             <ul class="nav-shop">
              <li class="nav-item" style="margin-left: 12px;">
             	<button>
             	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16">
			  	<path d="m8 6.236-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 
			  			3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 
			  			6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 
			  			0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 
			  			7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z"/>
				</svg>
				<!-- <span class="nav-shop__circle">0</span> -->
				</button> 
			  </li>
			  <li class="nav-item" style="margin-left: 3px;">
			  <c:choose>
			  		<c:when test="${id eq 'admin'}">
			  			<c:set var="url" value="AdminMemberGeneralListAction.ad"/>
			  		</c:when>
			  		<c:when test="${id ne 'admin'}">
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
              	<li class="" style="padding-right: 10px; line-height: 40px;"><a href="${contextPath}/MemberLogin.me" style=" color: #676363;">로그인</a></li>
              	<li class="" style="line-height: 40px; color: #222222;"><a href="${contextPath}/MemberJoin.me" style=" color: #676363;">회원가입</a></li>
              </c:when>
              <c:when test="${id ne null}">
              	<li class="" style="padding-right: 10px; line-height: 40px;"><a style=" color: #676363;">${sessionScope.id }님</a></li>
              	<li class="" style="line-height: 40px; color: #222222;"><a href="${contextPath}/MemberLogout.me" style=" color: #676363;">로그아웃</a></li>
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
  <script src="${contextPath}/vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="${contextPath}/vendors/skrollr.min.js"></script>
  <script src="${contextPath}/vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="${contextPath}/vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="${contextPath}/vendors/jquery.ajaxchimp.min.js"></script>
  <script src="${contextPath}/vendors/mail-script.js"></script>
  <script src="${contextPath}/js/main.js"></script>
</body>
</html>