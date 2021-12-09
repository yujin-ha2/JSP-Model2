<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>메이커 스튜디오</title>
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
    $(document).ready(function(){ 
    	//셀렉트박스 설정
    	$("#category").val("${rewardList[0].categoryId}").prop("selected", true);
    	$("#category").prop('disabled',true);

    });
    </script>
</head>
<body>
   <div class="container-scroller">
      <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-top justify-content-center" style="padding-top: 20px;">
          <a class="navbar-brand brand-logo" href="${contextPath}/makerStudioMain.on?fundingId=${fundingId}">makerStudio</a>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-center">
           <ul class="navbar-nav mr-auto">
            <li class="nav-item">
	           	<div class="profile-image">
	              <span style="padding-top: auto;">${sessionScope.id}님의 프로젝트 번호는 ${fundingId}</span>
	            </div>
            </li>
            </ul>
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <c:set var="exit" value="location.href='myprojectList.on'"/>
              <c:if test="${sessionScope.authority eq '관리자'}">
              	<c:set var="exit" value="location.href='AdminApproveListAction.ad'"/>
              </c:if>
              <button type="button" class="btn btn-outline-primary btn-rounded btn-fw" onclick="${exit}">나가기</button>
            </li>
          </ul>
        </div>
      </nav>
      <div class="container-fluid page-body-wrapper">
        <jsp:include page="nav.jsp">
        <jsp:param name="fundingId" value="${fundingId}"/> 
       	</jsp:include>
        
        <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
            <div class="row">
              <div class="col-12 grid-margin">
                <div class="card">
                  <div class="card-body" style="padding: 40px;">
                  	<div>
                    <h4 class="card-title" style="font-size: 36px; font-weight: 700; margin-bottom: 10px;">리워드 정보 제공</h4>
                    <p class="col-md-7" style="padding-left:0; font-size: 16px; margin-bottom: 32px; line-height: 1.41;">
                    	서포터에게 리워드 정보를 고지하여야 합니다. 서포터에게 하는 약속인 만큼, 프로젝트 오픈 후에는 수정이 불가하니 신중하게 작성하세요.
                    </p>
                    </div>
                    <form class="forms-sample" action="./rewardDetailUpdateForm.on" method="post">
                    <input type="hidden" id="fundingId" name="fundingId" value="${fundingId}">
                    <input type="hidden" id="categoryId" name="categoryId" value="${rewardList[0].categoryId}">
					<div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;	">
                            	리워드 정보 제공 고시
                            </p>                            
                           	<p style="font-size: 13px; color: #90949c;">
                           		- 서포터에게 리워드를 제공하는 경우, 리워드 정보 제공 고시를 반드시 입력해야 합니다.
                           	</p>
                            <div>
                            	<select class="form-control form-control-lg" name="category" id="category" style="width: 60%">
                            		<option value="0">리워드 카테고리 종류</option>
                            		<option value="100">전자제품</option>
                            		<option value="200">패션</option>
                            		<option value="300">영유아</option>
                            		<option value="400">식품</option>
                            		<option value="500">뷰티</option>
                            	</select>
							</div>
                          </div>
                          <div style="margin: 30px 0;" id="Categories">
	                          <table class="table table-hover">
			               		<thead>
				               		<tr>
										<th style="width: 30%">항목</th>
					               		<th style="width: 30%">예시 및 부가설명</th>
					               		<th style="width: 40%">입력란</th>
				               		</tr>
			               		</thead>
			               		<tbody>
				               		<c:forEach var="list" items="${rewardList}">
			               			<tr>
				                   		<td style="word-break:break-all" width="30%">${list.detailName}</td>
				                   		<td style="word-break:break-all" width="30%">${list.example}</td>
				                   		<td style="word-break:break-all" width="40%">
				                   			<input type="text" class="form-control" readonly="readonly" value="${list.detailContent}">
				                   		</td>
			                   		</tr>
				               		</c:forEach>
			                   	</tbody>
	                          </table>
                          </div>
                        </div>
                    </div>
                    <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;	">
                            	사용 중 발생한 하자에 대한 A/S 정책
                            </p>                            
                           	<p style="font-size: 13px; color: #90949c;">
                           		- 초기 하자(리워드 배송 완료 후 7일 이내에 발생)가 아닌 서포터가 사용 중에 발생하는 하자를 어떻게 처리할 것인지에 대한 정책을 작성하세요.
                           	</p>
                            <div>
                            	<textarea rows="7" cols="" class="form-control" readonly="readonly" id="policy" name="policy">${policy}</textarea>
                            	
							</div>
                          </div>
                        </div>
                    </div>
                    <c:set var="mode" value="${mode}"/>
                    <c:if test="${mode eq 'update'}">
	                    <div class="col-md-3" style="padding-left: 0;">
	                    	<input type="submit" class="saveBtn" value="수정 페이지로 이동">
	                    </div>
                    </c:if>
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