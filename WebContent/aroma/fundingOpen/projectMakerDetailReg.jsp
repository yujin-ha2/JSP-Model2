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
    	var type = document.getElementById("type"); 

    	for(var i=0; i<type.length; i++){ 
    		if(type[i].value == "${bean.type}"){ 
    			type[i].selected = true; 
  			} 
  		}
    });
	 
	function changeProfile(a) {
		$("#profileName").text(a.files[0].name);
	}
	
   
    function checked() {
    	
    	var name = document.getElementById("name");
		var type = document.getElementById("type");
		var ceoName = document.getElementById("ceoName");
		var ceoEmail = document.getElementById("ceoEmail");
		var profile = document.getElementById("profile");
		var makerEmail = document.getElementById("makerEmail");
		var makerTel = document.getElementById("makerTel");
		var makerHomepage = document.getElementById("makerHomepage");
		var bankName = document.getElementById("bankName");
		var accountNumber = document.getElementById("accountNumber");
		var accountHolder = document.getElementById("accountHolder");
		
		if (name.value.length == 0) {
			alert("메이커명을 입력하세요!");
			name.focus();
			return false;
		}
		
		if(type.options[type.selectedIndex].value == "사업자 구분 선택"){
			alert("사업자 구분을 선택하세요!");
			type.focus();
			return false;
		}
		
		if (ceoName.value.length == 0) {
			alert("대표자 이름을 입력하세요!");
			ceoName.focus();
			return false;
		}
		
		if (ceoEmail.value.length == 0) {
			alert("대표자 이메일을 입력하세요!");
			ceoEmail.focus();
			return false;
		}
		
		if (profile.value.length == 0) {
			alert("프로필을 선택하세요!");
			profile.focus();
			return false;
		}
		
		if (makerEmail.value.length == 0) {
			alert("문의 이메일을 선택하세요!");
			makerEmail.focus();
			return false;
		}
		
		if (makerTel.value.length == 0) {
			alert("문의 전화번호를 선택하세요!");
			makerTel.focus();
			return false;
		}
		
		if (makerHomepage.value.length == 0) {
			alert("문의 홈페이지를 선택하세요!");
			profile.focus();
			return false;
		}
		
		if(bankName.options[bankName.selectedIndex].value == "은행 선택"){
			alert("은행을 선택하세요!");
			bankName.focus();
			return false;
		}
		
		if(accountNumber.value.length == 0){
			alert("계좌번호를 입력하세요!");
			accountNumber.focus();
			return false;
		}
		
		if(accountHolder.value.length == 0){
			alert("예금주 입력하세요!");
			accountHolder.focus();
			return false;
		}
		
		if(summary.value.length == 0){
			alert("예금주명을 입력하세요!");
			summary.focus();
			return false;	
		}
		
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
                    <h4 class="card-title" style="font-size: 36px; font-weight: 700; margin-bottom: 10px;">메이커 정보</h4>
                    </div>
                    <form class="forms-sample" action="makerInfoReg.on" enctype="multipart/form-data" method="post" onsubmit="return checked()">
                    <input type="hidden" name="cmd" value="register">
                    <input type="hidden" name="fundingId" value="${fundingId}">
                      <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;	">
                            	메이커명
                            </p>                            
                           	<p style="font-size: 13px; color: #90949c;">
                           		- 법인사업자는 법인등기부상 법인명 / 개인 사업자는 주민등록상 성명 또는 상호 / 개인은 주민등록상 성명을 입력하세요.
                           	</p>
                            <div>
								<input type="text" class="form-control" name="name" id="name" value="${bean.name}">                           
                            </div>
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;">
                            	사업자 구분
                            </p>
                            <div>
                            	<select class="form-control form-control-lg" name="type" id="type">
                            		<option value="사업자 구분 선택">사업자 구분 선택</option>
                            		<option value="개인">개인</option>
                            		<option value="개인사업자">개인사업자</option>
                            		<option value="법인사업자">법인사업자</option>
                            	</select>
                            </div>
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;	">
                            	대표자 이름
                            </p>             
                            <p style="font-size: 13px; color: #90949c;">
                           		- 사업자인 경우 사업자등록증 상의 대표자명, 개인인 경우 주민등록증 상의 성명과 일치해야합니다.
                           	</p>               
                            <div>
								<input type="text" class="form-control" name="ceoName" id="ceoName">                           
                            </div>
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;	">
                            	대표자 이메일
                            </p>  
                            <p style="font-size: 13px; color: #90949c;">
                           		- 펀딩하기 서비스 제공 시 추가 계약・약정이 필요한 경우, 입력된 대표자의 이메일로 전자 약정서가 발송됩니다.
                           	</p>                           
                            <div>
								<input type="text" class="form-control" name="ceoEmail" id="ceoEmail">                           
                            </div>
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;">
                            	메이커 프로필 이미지
                            </p>
                            <div>
                            <label class="input-file-button col-md-2" for="input-file" style="text-align:center; font-size: 17px; line-height: 2.4;">업로드</label>
							<input type="file" id="input-file" style="display: none;" name="profile" id="profile" onchange="changeProfile(this)"/>
							</div>
							<span style="color: blue; font-size: 14px;" id="profileName"></span>
                            <div style="padding-top: 10px;">
                            	<p style="font-size: 13px; color: #90949c;">
                            		3MB 이하의 JPEG, PNG 파일<br>
									사이즈: 300X300 픽셀 이상<br>
								</p>
                            </div>                    
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;	">
                            	문의 이메일
                            </p>                            
                            <div>
								<input type="text" class="form-control" name="makerEmail" id="makerEmail">                           
                            </div>
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;	">
                            	문의 전화번호
                            </p>                            
                            <div>
								<input type="text" class="form-control" name="makerTel" id="makerTel">                           
                            </div>
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;	">
                            	문의 홈페이지
                            </p>                            
                            <div>
								<input type="text" class="form-control" name="makerHomepage" id="makerHomepage">                           
                            </div>
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;">
                            	계좌 정보
                            </p>
                             <p style="font-size: 13px; color: #90949c;">
                           		- 펀딩 성공시 정산금을 수령할 계좌정보를 입력하세요. <br>
								- 개인(사업자)의 경우 본인/사업자 명의 계좌 등록이 가능하며, 법인 사업자의 경우 법인계좌만 등록 가능합니다. <br>
								- 입금이 가능한 계좌인지 확인 후 입력하세요. <br>
								- 저축성 예금계좌, 외화예금계좌, CMA계좌, 평생계좌번호(휴대폰 번호) 등은 입금 불가 <br>
                           	</p> 
                            <div>
                            	<select class="form-control form-control-lg" name="bankName"  id="bankName">
                            		<option value="은행 선택">은행 선택</option>
                            		<option value="국민은행">국민은행</option>
                            		<option value="농협은행">농협은행</option>
                            		<option value="신한은행">신한은행</option>
                            		<option value="우리은행">우리은행</option>
                            		<option value="하나은행">하나은행</option>
                            	</select>
                            	<input type="text" class="form-control" placeholder="계좌번호" style="margin: 6px 0;" name="accountNumber" id="accountNumber">
                            	<p style="font-size: 13px; color: #90949c; margin-bottom: 2px;">
                           		- 특수문자(-)없이 숫자만 입력해주세요.
                           		</p>
                            	<input type="text" class="form-control" placeholder="예금주 명 입력" style="margin: 6px 0;" name="accountHolder" id="accountHolder">
                            	<p style="font-size: 13px; color: #90949c;">
                           		- 예금주 명은 계좌의 예금주와 정확하게 일치해야 합니다.
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
    <script src="${contextPath}/assets/js/shared/jquery.cookie.js" type="text/javascript"></script></body>
</html>