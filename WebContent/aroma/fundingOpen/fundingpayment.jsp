<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>makerStudio</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
    <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/ionicons/dist/css/ionicons.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/css/vendor.bundle.addons.css">
    <link rel="stylesheet" href="${contextPath}/assets/css/shared/style.css">
    <link rel="stylesheet" href="${contextPath}/assets/css/demo_1/style.css">
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
          <a class="navbar-brand brand-logo" href="#">makerStudio</a>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-center">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
              <a class="nav-link count-indicator" id="messageDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
                <i class="mdi mdi-bell-outline"></i>
                <span class="count">7</span>
              </a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link count-indicator" id="notificationDropdown" href="#" data-toggle="dropdown">
                <i class="mdi mdi-email-outline"></i>
                <span class="count bg-success">3</span>
              </a>
            </li>
            <li class="nav-item dropdown d-none d-xl-inline-block user-dropdown">
              <a class="nav-link dropdown-toggle" id="UserDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
                <img class="img-xs rounded-circle" src="../assets/images/face8.jpg" alt="Profile image"> </a>
              <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="UserDropdown">
                <div class="dropdown-header text-center">
                  <img class="img-md rounded-circle" src="../assets/images/face8.jpg" alt="Profile image">
                  <p class="mb-1 mt-3 font-weight-semibold">Allen Moreno</p>
                  <p class="font-weight-light text-muted mb-0">allenmoreno@gmail.com</p>
                </div>
                <a class="dropdown-item">My Profile <span class="badge badge-pill badge-danger">1</span><i class="dropdown-item-icon ti-dashboard"></i></a>
                <a class="dropdown-item">Messages<i class="dropdown-item-icon ti-comment-alt"></i></a>
                <a class="dropdown-item">Activity<i class="dropdown-item-icon ti-location-arrow"></i></a>
                <a class="dropdown-item">FAQ<i class="dropdown-item-icon ti-help-alt"></i></a>
                <a class="dropdown-item">Sign Out<i class="dropdown-item-icon ti-power-off"></i></a>
              </div>
            </li>
          </ul>
          <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
            <span class="mdi mdi-menu"></span>
          </button>
        </div>
      </nav>
      <!-- partial -->
      <div class="container-fluid page-body-wrapper">
        <jsp:include page="nav.jsp"></jsp:include>
        
        <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
            <div class="row">
            
             <div class="col-md-3 grid-margin">
                  <div class="card-body">
                    <h4 class="card-title" style="font-size: 36px; font-weight: 700; margin-bottom: 10px;">결제 현황</h4>
                    <p class="card-description">내 결제를 확인하세요 </p>
                  </div>
              </div>
              
              <div class="col-md-3 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body" style="text-align: right;">
                    <h4 class="card-title">목표 금액</h4>
                    <p>1,521,000</p>
                  </div>
                </div>
              </div>
              
              <div class="col-md-3 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body"  style="text-align: right;">
                    <h4 class="card-title">펀딩 시작 날짜</h4>
                    <p>2021-06-13</p>
                  </div>
                </div>
              </div>
              
               <div class="col-md-3 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body"  style="text-align: right;">
                    <h4 class="card-title">펀딩 종료 날짜</h4>
                    <p>2021-09-21</p>
                  </div>
                </div>
              </div>
            
            
            
            
              <div class="col-lg-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body" >
                    <h4 class="card-title">결제 정보 </h4>
                    <table class="table">
                      <thead>
                        <tr>
                          <th colspan="3">합계</th>
                          <th>507,000</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td colspan="3">리워드 금액</td>
                          <td>476,000</td>
                        </tr>
                        <tr>
                          <td colspan="3">쿠폰 금액</td>
                          <td>5,000</td>
                        </tr>
                        <tr>
                          <td colspan="3">배송비</td>
                          <td>26,000</td>
                        </tr>
                        <tr>
                          <td colspan="3">결제 완료율</td>
                          <td>68*</td>
                        </tr>
                        <tr>
                          <td colspan="3">결제 완료 건수</td>
                          <td>4건</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <div class="col-lg-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">결제 정보</h4>
                    <table class="table table-hover">
                    	<tr>
                          <th colspan="2">총 금액</th>
                          <th colspan="3">a</th>
                          <th>507,000</th>
                        </tr>
                        <tr>
                          <td colspan="2">반환 신청금</td>
                          <td colspan="3">d</td>
                          <td>507,000</td>
                        </tr>
                        <tr>
                          <td colspan="2">누적 반환 완료 금액</td>
                          <td colspan="3">c</td>
                          <td>270,000</td>
                        </tr>
                        <tr>
                          <td colspan="5">신청+반환금액</td>
                          <td>301,000</td>
                        </tr>
                        <tr>
                          <td colspan="2">총금액-쿠폰-누적반환금-반환신청금=</td>
                          <td colspan="3">(a-b-c-d)</td>
                          <td>31,000</td>
                        </tr>
                        <tr>
                          <td colspan="5">남은 후원금액</td>
                          <td>31,000</td>
                        </tr>
                    </table>
                  </div>
                </div>
              </div>
              <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h1>계좌 정보</h1>
                    <p class="card-description"> 국민은행 <code>.table-striped</code> </p>
                    <table class="table table-striped">
                      <thead>
                        <tr>
                          <th> User </th>
                          <th> First name </th>
                          <th> Progress </th>
                          <th> Amount </th>
                          <th> Deadline </th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td class="py-1">
                            <img src="../../../assets/images/faces-clipart/pic-1.png" alt="image" />
                          </td>
                          <td> Herman Beck </td>
                          <td>
                            <div class="progress">
                              <div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                          </td>
                          <td> $ 77.99 </td>
                          <td> May 15, 2015 </td>
                        </tr>
                        <tr>
                          <td class="py-1">
                            <img src="../../../assets/images/faces-clipart/pic-2.png" alt="image" />
                          </td>
                          <td> Messsy Adam </td>
                          <td>
                            <div class="progress">
                              <div class="progress-bar bg-danger" role="progressbar" style="width: 75%" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                          </td>
                          <td> $245.30 </td>
                          <td> July 1, 2015 </td>
                        </tr>
                        <tr>
                          <td class="py-1">
                            <img src="../../../assets/images/faces-clipart/pic-3.png" alt="image" />
                          </td>
                          <td> John Richards </td>
                          <td>
                            <div class="progress">
                              <div class="progress-bar bg-warning" role="progressbar" style="width: 90%" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                          </td>
                          <td> $138.00 </td>
                          <td> Apr 12, 2015 </td>
                        </tr>
                        <tr>
                          <td class="py-1">
                            <img src="../../../assets/images/faces-clipart/pic-4.png" alt="image" />
                          </td>
                          <td> Peter Meggik </td>
                          <td>
                            <div class="progress">
                              <div class="progress-bar bg-primary" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                          </td>
                          <td> $ 77.99 </td>
                          <td> May 15, 2015 </td>
                        </tr>
                        <tr>
                          <td class="py-1">
                            <img src="../../../assets/images/faces-clipart/pic-1.png" alt="image" />
                          </td>
                          <td> Edward </td>
                          <td>
                            <div class="progress">
                              <div class="progress-bar bg-danger" role="progressbar" style="width: 35%" aria-valuenow="35" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                          </td>
                          <td> $ 160.25 </td>
                          <td> May 03, 2015 </td>
                        </tr>
                        <tr>
                          <td class="py-1">
                            <img src="../../../assets/images/faces-clipart/pic-2.png" alt="image" />
                          </td>
                          <td> John Doe </td>
                          <td>
                            <div class="progress">
                              <div class="progress-bar bg-info" role="progressbar" style="width: 65%" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                          </td>
                          <td> $ 123.21 </td>
                          <td> April 05, 2015 </td>
                        </tr>
                        <tr>
                          <td class="py-1">
                            <img src="../../../assets/images/faces-clipart/pic-3.png" alt="image" />
                          </td>
                          <td> Henry Tom </td>
                          <td>
                            <div class="progress">
                              <div class="progress-bar bg-warning" role="progressbar" style="width: 20%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                          </td>
                          <td> $ 150.00 </td>
                          <td> June 16, 2015 </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              
              
            
            </div>
          </div>
          <!-- content-wrapper ends -->
          <!-- partial:../../partials/_footer.html -->
          <footer class="footer">
            <div class="container-fluid clearfix">
              <span class="text-muted d-block text-center text-sm-left d-sm-inline-block">Copyright © bootstrapdash.com 2020</span>
              <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center"> Free <a href="https://www.bootstrapdash.com/bootstrap-admin-template/" target="_blank">Bootstrap admin templates</a> from Bootstrapdash.com</span>
            </div>
          </footer>
          <!-- partial -->
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