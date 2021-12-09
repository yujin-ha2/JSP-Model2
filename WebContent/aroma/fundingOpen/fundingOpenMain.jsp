<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>GoodFunding</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
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
    

  <jsp:include page="../bottom.jsp" />

</body>
</html>