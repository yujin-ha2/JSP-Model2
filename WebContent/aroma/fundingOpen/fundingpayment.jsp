<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>makerStudio</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
    <%-- <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/ionicons/dist/css/ionicons.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/css/vendor.bundle.addons.css">
    <link rel="stylesheet" href="${contextPath}/assets/css/shared/style.css">
    <link rel="stylesheet" href="${contextPath}/assets/css/demo_1/style.css"> --%>
    <%-- <script src="${contextPath}/assets/vendors/js/vendor.bundle.base.js"></script>
    <script src="${contextPath}/assets/vendors/js/vendor.bundle.addons.js"></script>
    <script src="${contextPath}/assets/js/shared/off-canvas.js"></script>
    <script src="${contextPath}/assets/js/shared/misc.js"></script>
    <script src="${contextPath}/assets/js/demo_1/dashboard.js"></script>
    <script src="${contextPath}/assets/js/shared/jquery.cookie.js" type="text/javascript"></script> --%>
    <style type="text/css">
	.input-file-button{
	  background-color:#00c4c4;
	  border-radius: 4px;
	  color: white;
	  cursor: pointer;
	  height: 40px;
	}
	p{
		font-weight: bold;
		font-size: 30px;
	}
    </style>
</head>
<body>
    <div class="container-scroller">
      <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-top justify-content-center" style="padding-top: 20px;">
          <a class="navbar-brand brand-logo" href="${contextPath}/makerStudioMain.on?fundingId=${report.fundingId}">makerStudio</a>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-center">
           <ul class="navbar-nav mr-auto">
            <li class="nav-item">
	           	<div class="profile-image">
	              <img class="img-xs rounded-circle" src="${contextPath}/img/noProfile_M.png" alt="profile image">
	              <span style="margin-left: 10px; padding-top: auto;">${sessionScope.id}님의 프로젝트 번호는 ${report.fundingId}</span>
	            </div>
            </li>
            </ul>
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <button type="button" class="btn btn-outline-primary btn-rounded btn-fw" onclick="location.href='myprojectList.on'">나가기</button>
            </li>
          </ul>
        </div>
      </nav>
      <div class="container-fluid page-body-wrapper">
        <jsp:include page="nav.jsp">
        <jsp:param name="fundingId" value="${report.fundingId}"/> 
       	</jsp:include>
        
        <div class="main-panel">
          <div class="content-wrapper">
            <div class="row">
             <div class="col-md-3 grid-margin">
                  <div class="card-body">
                    <h4 class="card-title" style="font-size: 33px; font-weight: 700; margin-bottom: 10px;">결제 현황</h4>
                    <p class="card-description"></p>
                  </div>
              </div>
              <div class="col-md-3 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                  	<h4 class="card-title" style="font-size: 19px; font-weight: 700;">${report.fundingTitle}</h4>
                    <p style="text-align: right; font-size: 18px;"><span style="font-size: 16px; color: #797270;">by</span> ${report.makerName}</p>
                    <h4 class="card-title"></h4>
                    <p></p>
                  </div>
                </div>
              </div>
              <div class="col-md-3 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body"  style="text-align: right;">
                    <h4 class="card-title" style="margin-bottom: 5px;">예상 목표 금액</h4>
                    <fmt:formatNumber value="${report.salesTarget}" var="salesTarget" pattern="#,###"/>
                    <fmt:formatNumber value="${report.totalRevenue}" var="totalRevenue" pattern="#,###"/>
                    <p style="font-size: 17px; font-weight: bold;">${salesTarget}원</p>
                    <h4 class="card-title" style="margin-bottom: 5px;">현재 총 펀딩 금액 (달성률)</h4>
                    <p style="font-size: 17px; font-weight: bold;">${totalRevenue}원  (${report.achievement}%)</p>
                  </div>
                </div>
              </div>
              <div class="col-md-3 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body"  style="text-align: right;">
                    <h4 class="card-title" style="margin-bottom: 5px;">펀딩 진행 기간</h4>
                    <fmt:formatDate value="${report.startDate}" var="start" pattern="yyyy-MM-dd"/>
                    <fmt:formatDate value="${report.endDate}" var="end" pattern="yyyy-MM-dd"/>
                    <fmt:parseDate value="${report.startDate}" var="strPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="startDate"></fmt:parseNumber>
					<fmt:parseDate value="${report.endDate}" var="endPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
                    <p style="font-size: 17px; font-weight: 700; margin-bottom: 15px;">${start} - ${end} (${endDate - startDate }일간 진행)</p>	
                    <p style="font-size: 17px; font-weight: bold; margin-bottom: 0px;">${fundingStatus}</p>
                    <p></p>
                  </div>
                </div>
              </div>
              <div class="col-lg-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body" >
                    <h4 class="card-title" style="font-size: 25px; font-weight: 600; margin-bottom: 30px;">펀딩 정산 </h4>
                    <table class="table table-hover">
                      <tbody>
                        <tr>
                          <td colspan="3">실 결제 금액</td>
                          <fmt:formatNumber var="finalAmount" value="${result.finalAmount}" pattern="#,###"/>
                          <td>${result.finalAmount}</td>
                        </tr>
                        <tr>
                          <td colspan="3">└ 포인트 금액</td>
                          <fmt:formatNumber var="usedPoint" value="${result.usedPoint}" pattern="#,###"/>
                          <td>${usedPoint}</td>
                        </tr>
                        <tr>
                          <td colspan="3">└ 후원 금액</td>
                          <fmt:formatNumber var="donation" value="${result.donation}" pattern="#,###"/>
                          <td>${donation}</td>
                        </tr>
                        <tr>
                          <td colspan="3">└ 배송비 금액</td>
                          <fmt:formatNumber var="deliveryFee" value="${result.deliveryFee}" pattern="#,###"/>
                          <td>${deliveryFee}</td>
                        </tr>
                        <tr>
                          <td colspan="3">중개 수수료 7%</td>
                          <fmt:formatNumber var="commission" value="${result.commission}" pattern="#,###"/>
                          <td>-${commission}</td>
                        </tr>
                        <tr style="font-weight: bold;">
                          <td colspan="3">실 지급 금액</td>
                          <fmt:formatNumber var="income" value="${result.finalAmount + result.usedPoint - result.commission}" pattern="#,###"/>
                          <td>${income}</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <div class="col-lg-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title" style="font-size: 25px; font-weight: 600; margin-bottom: 30px;">결제 정보</h4>
                    <table class="table table-hover">
                    	<tbody>
	                        <tr>
	                          <td colspan="3" width="50%">펀딩 주문 건수</td>
	                          <td>${orderCount}건</td>
	                        </tr>
	                        <tr>
	                          <td colspan="3"width="50%">주문 취소 건수</td>
	                          <td>${cancelCount}건</td>
	                        </tr>
	                        <tr>
	                          <td colspan="3"width="50%">정산 계좌</td>
	                          <td>(예금주) ${report.accountHolder}&nbsp; ${report.bankName}, ${report.accountNumber}</td>
	                        </tr>
                        </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
</body>
</html>