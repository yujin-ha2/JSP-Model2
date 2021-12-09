<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/ionicons/dist/css/ionicons.css">
  <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/flag-icon-css/css/flag-icon.min.css">
  <link rel="stylesheet" href="${contextPath}/assets/vendors/css/vendor.bundle.base.css">
  <link rel="stylesheet" href="${contextPath}/assets/vendors/css/vendor.bundle.addons.css">
  <link rel="stylesheet" href="${contextPath}/assets/css/shared/style.css">
  <link rel="stylesheet" href="${contextPath}/assets/css/demo_1/style.css">   
</head>
<body>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
   <ul class="nav">
     <li class="nav-item nav-profile">
       <a href="#" class="nav-link">
         <%-- <div class="profile-image">
           <img class="img-xs rounded-circle" src="${contextPath}/img/noProfile_M.png" alt="profile image">
           <div class="dot-indicator bg-success"></div>
         </div> --%>
         <div class="text-wrapper">
           <p class="profile-name">${sessionScope.id}님</p>
           <p class="designation">프로젝트를 시작해보세요</p>
         </div>
       </a>
     </li>
     <li class="nav-item nav-category">Main Menu</li>
     <li class="nav-item">
       <a class="nav-link" href="${contextPath}/makerStudioMain.on?fundingId=${param.fundingId}">
         <i class="menu-icon typcn typcn-document-text"></i>
         <span class="menu-title">Dashboard</span>
       </a>
     </li> 
     <li class="nav-item">
       <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
         <i class="menu-icon typcn typcn-coffee"></i>
         <span class="menu-title">프로젝트 준비</span>
         <i class="menu-arrow"></i>
       </a>
       <div class="collapse" id="ui-basic">
         <ul class="nav flex-column sub-menu">
           <li class="nav-item">
             <a class="nav-link" href="${contextPath}/BasicRequireRegForm.on?fundingId=${param.fundingId}">기본요건 작성</a>
           </li>
           <li class="nav-item">
             <a class="nav-link" href="${contextPath}/BasicInfoRegForm.on?fundingId=${param.fundingId}">기본정보 / 스토리 작성</a>
           </li>
           <li class="nav-item">
             <a class="nav-link" href="${contextPath}/rewardRegForm.on?fundingId=${param.fundingId}">리워드 설계</a>
           </li>
           <li class="nav-item">
             <a class="nav-link" href="${contextPath}/rewardDetailRegForm.on?fundingId=${param.fundingId}">제공 정보 작성</a>
           </li>
           <li class="nav-item">
             <a class="nav-link" href="${contextPath}/makerInfoRegForm.on?fundingId=${param.fundingId}">메이커 정보 작성</a>
           </li>
         </ul>
       </div>
     </li>
     <li class="nav-item">
       <a class="nav-link" href="${contextPath}/fundingReport.on?fundingId=${param.fundingId}">
         <i class="menu-icon typcn typcn-shopping-bag"></i>
         <span class="menu-title">펀딩 현황</span>
       </a>
     </li>
     <li class="nav-item">
       <a class="nav-link" href="${contextPath}/fundingResult.on?fundingId=${param.fundingId}">
         <i class="menu-icon typcn typcn-th-large-outline"></i>
         <span class="menu-title">결제 현황</span>
       </a>
     </li>
   </ul>
</nav>
  <script src="${contextPath}/assets/vendors/js/vendor.bundle.base.js"></script>
  <script src="${contextPath}/assets/vendors/js/vendor.bundle.addons.js"></script>
  <script src="${contextPath}/assets/js/shared/off-canvas.js"></script>
  <script src="${contextPath}/assets/js/shared/misc.js"></script>
  <script src="${contextPath}/assets/js/demo_1/dashboard.js"></script>
  <script src="${contextPath}/assets/js/shared/jquery.cookie.js" type="text/javascript"></script></body>
</body>
</html>