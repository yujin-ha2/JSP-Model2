<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    <script type="text/javascript">
    $(function() {
    	//$("#q1div").hide();
    });
    
    function view_div() {
        document.getElementById("#q1div").style.display = 'block';
        //$("#q1div").show();
    }
    function hidden_div() {
        document.getElementById("#q1div").style.display = 'none';
        //$("#q1div").hide();
    } 

    function checked() {
	
    	var reward = document.getElementById("reward");
		var b_delivery = document.getElementById("delivery");
		var q1_differ = document.getElementById("q1_differ");
		

		num_temp = document.all.Q1_radio.length;
		for (i = 0; i < num_temp; i++) {
			if (document.all.Q1_radio[i].checked == true) {
				break;
			}
		}
		if (i == num_temp) {
			alert("Q1 질문에 체크해주세요!");
			return false;
		}
		
		if($('input:radio[id=no]').is(':checked')){
			if (q1_differ.value.length == 0) {
				alert("Q1 내용을 입력하세요!");
				q1_differ.focus();
				return false;
			}
		}
		
		if (reward.value.length == 0) {
			alert("리워드 내용을 입력하세요!");
			reward.focus();
			return false;
		}

		if (b_delivery.value.length == 0) {
			alert("리워드 전달 계획을 입력하세요!");
			b_delivery.focus();
			return false;
		}
		num_temp1 = document.all.Q4_radio.length;
		for (i = 0; i < num_temp1; i++) {
			if (document.all.Q4_radio[i].checked == true) {
				break;
			}
		}
		if (i == num_temp1) {
			alert("Q4 질문에 체크해주세요!");
			return false;
		}

		return true;
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
                    <h4 class="card-title" style="font-size: 36px; font-weight: 700; margin-bottom: 10px;">기본 요건</h4>
                    <p style="font-size: 16px; margin-bottom: 32px; line-height: 1.41;">
                    	펀딩 진행을 위한 기본 요건을 확인하고자 합니다. 심사 시 확인하는 중요한 정보이므로 반드시 정확한 정보를 입력하세요.<br>	
                    	답변 내용이 사실과 다른 경우, 약정 위반에 따른 불이익이 발생할 수 있습니다.
                    </p>
                    </div>
                    <form action="./BasicRequireReg.on" method="post" onsubmit="return checked()">
                    <input type="hidden" name="cmd" value="register">
                      <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <input type="hidden" name="fundingId" value="${fundingId}">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;">
                            	Q1. 리워드가 타 크라우드펀딩사 및 온라인 커머스등 다른 판매처에서 유통된 적이 있거나 현재 유통중인가요?
                            </p>
                            <div class="form-radio form-radio-flat">
                            	<label class="form-check-label" style="	">
                            		<input type="radio" class="form-check-input" id="no" name="Q1_radio" value="no" onclick="hidden_div();">
                            		아니요. 다른 곳에서 유통한 적이 없으며 처음 선보이는 제품입니다.
                            		<i class="input-helper"></i>
                            	</label>
                           	</div>
                           	<div class="form-radio form-radio-flat" style="margin-bottom: 15px;">
                            	<label class="form-check-label" style="">
                            		<input type="radio" class="form-check-input" id="yes" name="Q1_radio" value="yes" onclick="view_div();">
                            		예, 다른 곳에서 유통한 적이 있습니다. 또는 유통중입니다.
                            		<i class="input-helper"></i>
                            	</label>
                            </div>
                            <div id="q1div" name="q1div" style="">
	                            <p style="font-size: 13px; color: #90949c; margin-bottom: 5px; padding-left: 10px;">
	                            	- 리워드가 다른 판매처에서 유통된 적이 있다면 리워드로 제공할 수 없습니다.<br>
									- 기존에 유통하던 제품/서비스에 비해 개선된 점이 있다면 아래에 상세하게 작성해주세요.</p>
	                            <textarea rows="2" cols="" class="form-control" name="q1_differ" id="q1_differ" 
	                            placeholder="ex) 리워드의 개선점을 보완하여 세부기능 OO이 추가되었고, 이전에 판매된 적이 없는 새로운 브라운 컬러로 리워드 프로젝트를 진행하려 합니다."></textarea>
                            </div>
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;	">
                            	Q2. 현재까지 진행된 리워드의 준비 상태 및 앞으로의 계획을 구체적으로 설명해주세요.
                            </p>                            
                            <div>
                            	<p style="font-size: 13px; color: #90949c;">- 현재 리워드의 제작 상태 및 제조 시설명과 일일 최대 생산 가능량을 포함한 앞으로의 생산 계획을 작성해주세요.</p>
                            </div>
                            <textarea rows="2" cols="" class="form-control" name="reward" id="reward"></textarea>
                          </div>
                        </div>
                        </div>
                         <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;">
                            	Q3. 리워드의 전달 계획을 알려주세요.
                            </p>
                             <div>
                            	<p style="font-size: 13px; color: #90949c;">- 리워드 제작 및 전달 일정이 변동될 가능성이 있다면 사유를 알려주세요 그리고 발송 업체명 및 일일 최대 발송 가능량을 입력해주세요.</p>
                            </div>
                            <textarea rows="2" cols="" class="form-control" name="delivery" id="delivery"></textarea>
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;">
                            	Q4. 리워드 제작 형태를 알려주세요.
                            </p>
                            <div class="form-radio form-radio-flat">
                            	<label class="form-check-label" style="	">
                            		<input type="radio" class="form-check-input" id="all" name="Q4_radio" value="1">
                            		메이커가 아이디어 단계부터 리워드의 기획 및 개발, 생산까지의 전 과정을 담당합니다.
                            		<i class="input-helper"></i>
                            	</label>
                           	</div>
                           	<div class="form-radio form-radio-flat">
                            	<label class="form-check-label" style="">
                            		<input type="radio" class="form-check-input" id="part1" name="Q4_radio" value="2">
                            		메이커가 아이디어 단계부터 직접 기획 및 개발한 제품이지만, 제품의 양산 등의 과정은 제3자인 위탁 생산 업체가 담당합니다.
                            		<i class="input-helper"></i>
                            	</label>
                            </div>
                            <div class="form-radio form-radio-flat">
                            	<label class="form-check-label" style="	">
                            		<input type="radio" class="form-check-input" id="part2" name="Q4_radio" value="3">
                            		메이커가 국내외 제조업체에서 개발이 완료된 제품의 일부를 개선 혹은 변경한 뒤 자신의 브랜드로 위탁 생산을 의뢰하였습니다.
                            		<i class="input-helper"></i>
                            	</label>
                           	</div>
                           	<div class="form-radio form-radio-flat">
                            	<label class="form-check-label" style="">
                            		<input type="radio" class="form-check-input" id="part3" name="Q4_radio" value="4">
                            		이미 제작 완료된 해외 브랜드의 제품을 메이커가 국내 첫 단독 총판의 자격으로 수입하여 유통합니다.
                            		<i class="input-helper"></i>
                            	</label>
                            </div>                            
                          </div>
                        </div>
                        </div>
	                    <div class="col-md-3" style="padding-left: 0;">
	                    	<input type="submit" style="color: #fff; background-color: #2196F3; width: 100%; height: 40px; border: 0; border-radius: 5px;" value="저장하기">
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
</body>
</html>