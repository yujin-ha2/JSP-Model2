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
    <script type="text/javascript" src="https://code.jquery.com/jquery-latest.min.js"></script>
    
    <style type="text/css">
	.input-file-button{
	  background-color:#2196F3;
	  border-radius: 4px;
	  color: white;
	  cursor: pointer;
	  height: 40px;
	  border: 0;
	}
	
	tr{
	margin: 4px 0;
	}
	
	.condition{
	font-size: 15px; 
	font-weight: 700; 
	width: 13%;
	}
	
	.saveBtn{
	color: #fff; 
	background-color: #2196F3; 
	width: 100%; 
	height: 40px; 
	border: 0; 
	border-radius: 5px;
	}
    </style>
    <script type="text/javascript">
		function popup(){
			var url = "${contextPath}/fundingOpen/rewardPopup.jsp";
			var name = "rewardpopup";
			var option = "width = 700, height = 850, top = 20,  location = no, scrolbar=no, toolbar=no, resizable=no, status = no, left=30, right=30 "
			window.open(url, name, option);
		}
		
		var myModalEl = document.getElementById('#LoginModal')
		myModalEl.addEventListener('shown.bs.modal', function (event) {
			$('.modal-backdrop').css('background', '#00000065');
		})
		
		/* $("#LoginModal").on('shown.bs.modal', function() {
			  console.log('dfdfdf');
			  $('.modal-backdrop').css('background', '#00000065');
			}); */

    </script>
</head>
<body>

<!-- Modal -->
<div class="modal fade" id="LoginModal" name="LoginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content" style="width: 400px; height:220px; margin-top: 20px;">
      <div class="modal-header" style="border-bottom:0px;">
        <h5 class="modal-title" id="exampleModalCenterTitle" style="font-weight: 700; font-size: 23px;">로그인이 필요합니다.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="padding-right: 25px; font-size: 2rem;">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" style="font-size: 17px; letter-spacing: -.02em;">
           계속 진행하려면 회원가입 또는 로그인하여야 합니다. 작성중인 내용은 그대로 저장됩니다.
      </div>
      <div class="modal-footer" style="border-top: 0px; padding: 0 15px 20px 15px; flex-wrap: unset; text-align: center;" >
        <button type="button" class="btn btn-secondary" style="width: 100%; height: 40px; border: 1px solid rgba(0,0,0,.15);" data-dismiss="modal">회원가입</button>
        <button type="button" class="btn btn-primary" style="width: 100%; margin-left: 10px; background-color: #00c4c4; border-color:#00c4c4; height: 40px;" >로그인</button>
      </div>
    </div>
  </div>
</div>

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
              <div class="col-12 grid-margin">
                <div class="card">
                  <div class="card-body" style="padding: 40px;">
                  	<div>
                    <h4 class="card-title" style="font-size: 36px; font-weight: 700; margin-bottom: 10px;">리워드 설계</h4>
                    <p class="col-md-7" style="padding-left:0; font-size: 16px; margin-bottom: 32px; line-height: 1.41;">
                    	서포터에게 제공할 리워드 내용을 입력하세요. 서포터가 쉽게 펀딩할 수 있는 저렴한 리워드부터 서포터의 보다 빠른 펀딩을 유도할 수 있는 얼리버드 리워드까지 다양한 리워드를 구성하세요.
                    </p>
                    </div>
                    <form class="forms-sample">
                      <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <div style="border: 1px solid #e6eaed; width: 100%; color: #0000008A; margin-bottom: 20px;">
                            	<h5 style="font-weight: 700; color: #000000D6; margin: 10px;">리워드 설계 조건</h5>
							 	<table style="font-size: 13px; margin: 10px 0 10px 10px;">
							 		<tr>
							 			<td class="condition">정렬 순서</td>
							 			<td>혜택이 높은 순으로 나오도록 정렬 순서를 등록하세요.</td>
							 		</tr>
							 		<tr>
							 			<td class="condition">제한 수량</td>
							 			<td>생상 및 제공할 수 있는 리워드의 총 수량으로 해당 수령이 모두 펀딩되면 더이상 펀딩 불가합니다.</td>
							 		</tr>
							 		<tr>
							 			<td class="condition">발송 시작일</td>
							 			<td> 설정한 발송 시작일까지 리워드가 발송되지 않을 경우, 서포터가 펀딩금 반환을 신청할 수 있으니 신중하게 선택하세요.</td>
							 		</tr>
							 		<tr>
							 			<td class="condition">옵션 조건</td>
							 			<td>옵션(사이즈,색상 등)이 필요한 경우, 옵션을 추가하세요.</td>
							 		</tr>
							 	</table>
                            </div>
                            <div>
                            	<input type="button" class="input-file-button col-md-2" style="font-size: 17px;" onclick="" value="추가하기"  data-toggle="modal" data-target="#LoginModal" >
							</div>
                            <div style="padding-top: 10px;">
                            	<p style="font-size: 13px; color: #90949c;">
                            		3MB 이하의 JPEG, PNG 파일<br>
									해상도 1200x675 픽셀 이상<br>
									텍스트 및 로고 삽입 금지<br>
								</p>
                            </div>
                          </div>
                        </div>
                        </div>
	                    <div class="col-md-3" style="padding-left: 0;">
	                    	<button class="saveBtn">저장하기</button>
	                    </div>
                    </form>
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