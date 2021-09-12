<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Funding Open Main</title>
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

  <!-- ================ start banner area ================= -->	
  <section class="blog-banner-area" id="category">
    <div align="center">
	<img alt="" src="${contextPath}/img/startup3copy.jpg" width="100%" height="395px;">
	   <div class="container h-100">
		 <div class="blog-banner">
		 	<div class="text-center">
				<h1 style="color: white; line-height: 50px; font-size: 45px;">굿펀딩에서 메이커를 등록하고<br>프로젝트를 오픈해 보세요</h1>
				<nav aria-label="breadcrumb" class="banner-breadcrumb" style="margin-top: 50px; text-align: center;	font-weight: bold;">
				<div class="q1" onclick="location.href='${contextPath}/makerEasyRegForm.on'">
					<p class="q3">메이커 간편등록</p>
					<p class="q4">제품, 서비스를 관리자에게 승인받으세요!</p>
				</div>
				<div class="q2" onclick="location.href='${contextPath}/myprojectList.on'">
					<p class="q3">프로젝트 시작하기</p><p class="q4">제품, 서비스를 관리자에게 승인받으세요!</p>
				</div>
	       	  </nav>
			</div>
		 </div>
	   </div>
	 </div>
  </section>

      <div  style="padding: 50px 430px;">
       <img alt="" src="${contextPath}/img/openimg.PNG">
        
      </div>
    </div>
  </section>
  <!--================End Order Details Area =================-->
  
      <!-- Modal -->
	<div class="modal" id="LoginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content" style="width: 400px; height:220px; margin-top: 20px;">
	      <div class="modal-header" style="border-bottom:0px;">
	        <h5 class="modal-title" id="exampleModalCenterTitle" style="font-weight: 700; font-size: 23px;">로그인이 필요합니다.</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="padding-right: 25px; font-size: 2rem;">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body" style="font-size: 17px; letter-spacing: -.02em;">
	           계속 진행하려면 회원가입 또는 로그인하여야 합니다.
	      </div>
	      <div class="modal-footer" style="border-top: 0px; padding: 0 15px 20px 15px; flex-wrap: unset; text-align: center;" >
	        <button type="button" class="btn btn-secondary" style="width: 100%; height: 40px; border: 1px solid rgba(0,0,0,.15);" data-dismiss="modal">회원가입</button>
	        <button type="button" class="btn btn-primary" style="width: 100%; margin-left: 10px; background-color: #00c4c4; border-color:#00c4c4; height: 40px;" >로그인</button>
	      </div>
	    </div>
	  </div>
	</div>


  <jsp:include page="../bottom.jsp" />

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