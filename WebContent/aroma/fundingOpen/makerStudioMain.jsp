<%@page import="net.action.StatusName"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
    <title>Star Admin Premium Bootstrap Admin Dashboard Template</title>
    <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/ionicons/dist/css/ionicons.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/css/vendor.bundle.addons.css">
    <link rel="stylesheet" href="${contextPath}/assets/css/shared/style.css">
    <link rel="stylesheet" href="${contextPath}/assets/css/demo_1/style.css">
    <link rel="shortcut icon" href="${contextPath}/assets/images/favicon.ico" />
    <style type="text/css">
    .submitBtn{
    	color: #fff; 
    	background-color: #2196F3;
    	width: 100%;
    	height: 50px; 
    	border: 0; 
    	border-radius: 5px; 
    	font-weight: 700; 
    	font-size: 18px;
    }
    </style>
    <script type="text/javascript">
    	function goOtherPage(s, sep) {
			//console.log(s);
			//console.log(sep);
			
			var cmd;
			if(sep == "작성하기")
				cmd = "reg";
			else if(sep == "수정하기")
				cmd = "mod";
			else
				cmd = "view"

			location.href = s + '?cmd=' + cmd;	
		}
    
    </script>
  </head>
  <body>
    <div class="container-scroller">
      <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-top justify-content-center" style="padding-top: 20px;">
          <a class="navbar-brand brand-logo" href="#">makerStudio</a>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-center">
        	<%-- 프로제트 번호: ${projectId} --%>
           <ul class="navbar-nav mr-auto">
            <li class="nav-item">
	           	<div class="profile-image">
	              <img class="img-xs rounded-circle" src="${contextPath}/assets/images/face8.jpg" alt="profile image">
	              <span style="margin-left: 10px; padding-top: auto;">${sessionScope.id}님의 프로젝트 번호는 ${fundingId}</span>
	            </div>
            </li>
            </ul>
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <button type="button" class="btn btn-outline-primary btn-rounded btn-fw">미리보기</button>
            </li>
            <li class="nav-item">
              <button type="button" class="btn btn-outline-primary btn-rounded btn-fw">나가기</button>
            </li>
          </ul>
        </div>
      </nav>
      <!-- Left side menu -->
      <div class="container-fluid page-body-wrapper">
        <jsp:include page="nav.jsp">
        <jsp:param name="fundingId" value="${fundingId}"/> 
        </jsp:include>
        
        <div class="main-panel">
          <div class="content-wrapper">
            <!-- Page Title Header Starts-->
            <div class="row page-title-header">
              <div class="col-8">
                <div class="page-header">
                  <h4 style="width: 100px;">펀딩 준비</h4>
                  <div class="quick-link-wrapper w-100 d-md-flex flex-md-wrap">
                    <ul class="quick-links">
                      <li style="color: #60656a; font-size: 17px;">펀딩을 오픈하기 위해 프로젝트에 대한 필수항목을 작성하세요.</li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
            <!-- Page Title Header Ends-->
            <div class="row">
              <div class="col-md-8 grid-margin">
                <div class="card" >
                  <div class="card-body">
                    <h5 style="font-weight: 700; color: #000000D6;">프로젝트 준비상태</h5>
                    <% String status = (String)request.getAttribute("status");
                       String statusDetail = status + "Detail"; %>
			 		<h5 style="color: #2196F3; font-weight: 700;">→ <%=StatusName.get(status)%></h5>
				 	<div style="padding-left: 20px; font-size: 14px; color: #000000D6;"><%=StatusName.get(statusDetail)%></div>
                  </div>
                </div>
              </div>
              <div class="col-md-8 grid-margin">
                <div class="card" >
                  <div class="card-body">
                  <div>
                     <div style="border: 1px solid #e6eaed; border-left:5px solid blue; width: 100%; color: #0000008A; margin-bottom: 20px;">
                     	<div style="font-weight: 700; font-size:20px; color: #000000D6; padding: 32px;">기본요건 작성 
                     		<span style="margin-left: 15px; font-size: 12px; font-weight: 600; color: #2196F3;">${writeList.get(0)}</span>
	                      	<div style="float: right">
	                      		<input type="button" class="btn btn-outline-secondary btn-fw" style="padding: 7px 10px; font-size: 15px;"
	                      			   value="${statusBtnList.get(0)}" onclick="goOtherPage('myprojectList.on','${statusBtnList.get(0)}')">
	                      	</div>
                     	</div>
                   	 </div>
                     <div style="border: 1px solid #e6eaed; border-left:5px solid blue; width: 100%; color: #0000008A; margin-bottom: 20px;">
                     	<div style="font-weight: 700; font-size:20px; color: #000000D6; padding: 32px;">기본정보 작성 
	                      	<span style="margin-left: 15px; font-size: 12px; font-weight: 600; color: #2196F3;">${writeList.get(1)}</span>
	                      	<div style="float: right">
	                      		<input type="button" class="btn btn-outline-secondary btn-fw" style="padding: 7px 10px; font-size: 15px;"
	                      		 	   value="${statusBtnList.get(1)}" onclick="goOtherPage('myprojectList.on','${statusBtnList.get(1)}')">
	                      	</div>
                     	</div>
                   	 </div>
                   	  <div style="border: 1px solid #e6eaed; border-left:5px solid blue; width: 100%; color: #0000008A; margin-bottom: 20px;">
                     	<div style="font-weight: 700; font-size:20px; color: #000000D6; padding: 32px;">리워드 설계 
	                      	<span style="margin-left: 15px; font-size: 12px; font-weight: 600; color: #2196F3;">${writeList.get(2)}</span>
	                      	<div style="float: right">
	                      		<input type="button" class="btn btn-outline-secondary btn-fw" style="padding: 7px 10px; font-size: 15px;" 
	                      			   value="${statusBtnList.get(2)}" onclick="goOtherPage('myprojectList.on','${statusBtnList.get(2)}')"></button>
	                      	</div>
                     	</div>
                   	 </div>
                   	  <div style="border: 1px solid #e6eaed; border-left:5px solid blue; width: 100%; color: #0000008A; margin-bottom: 20px;">
                     	<div style="font-weight: 700; font-size:20px; color: #000000D6; padding: 32px;">제공 정보 작성 
	                      	<span style="margin-left: 15px; font-size: 12px; font-weight: 600; color: #2196F3;">${writeList.get(3)}</span>
	                      	<div style="float: right">
	                      		<input type="button" class="btn btn-outline-secondary btn-fw" style="padding: 7px 10px; font-size: 15px;" 
	                      			   value="${statusBtnList.get(3)}" onclick="goOtherPage('myprojectList.on','${statusBtnList.get(3)}')">
	                      	</div>
                     	</div>
                   	 </div>
                   	  <div style="border: 1px solid #e6eaed; border-left:5px solid blue; width: 100%; color: #0000008A; margin-bottom: 20px;">
                     	<div style="font-weight: 700; font-size:20px; color: #000000D6; padding: 32px;">메이커 정보 작성 
	                      	<span style="margin-left: 15px; font-size: 12px; font-weight: 600; color: #2196F3;">${writeList.get(4)}</span>
	                      	<div style="float: right">
	                      		<input type="button" class="btn btn-outline-secondary btn-fw" style="padding: 7px 10px; font-size: 15px;" 
	                      		       value="${statusBtnList.get(4)}" onclick="goOtherPage('myprojectList.on','${statusBtnList.get(4)}')">
	                      	</div>
                     	</div>
                   	 </div>
                  </div>
                  <div class="col-md-4" style="padding: 20px 0;">
                  	<c:choose>
                  		<c:when test="${status eq 'prepare' || status eq 'reject'}">
                  			<input type="submit" class="submitBtn" value="제출하기" onclick="" >
                  		</c:when>
                  		<c:otherwise>
                  			<input type="button" class="submitBtn" value="제출완료" disabled="disabled">
                  		</c:otherwise>
                  	</c:choose>
	              </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="${contextPath}/assets/vendors/js/vendor.bundle.base.js"></script>
    <script src="${contextPath}/assets/vendors/js/vendor.bundle.addons.js"></script>
    <script src="${contextPath}/assets/js/shared/off-canvas.js"></script>
    <script src="${contextPath}/assets/js/shared/misc.js"></script>
    <script src="${contextPath}/assets/js/demo_1/dashboard.js"></script>
    <script src="${contextPath}/assets/js/shared/jquery.cookie.js" type="text/javascript"></script>
  </body>
</html>