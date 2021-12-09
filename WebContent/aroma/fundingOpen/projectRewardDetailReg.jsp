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
		function selectCategory() {
			 var selectBox = document.getElementById("category");
			 var selectedValue = selectBox.options[selectBox.selectedIndex].value;
			 
			 var id = $("#category option:selected").val();
			 var data = {categoryId : id}
				$.ajax({
					type: 'post',
					url: 'conveyCategorydetail.on',
					data: JSON.stringify(data),
					contentType: "application/json; charset=utf-8",
					dataType: "json"
				}).done(function(result) {
					var list = result;
                   	var html ='';
                   	
                   	$("#Categories").empty();
                   	
               		html += '<table class="table table-hover">';
               		html += '<thead><tr>';
               		html += '<th style="width: 30%">항목</th>';
               		html += '<th style="width: 30%">예시 및 부가설명</th>';
               		html += '<th style="width: 40%">입력란</th>';
               		html += '</tr></thead>';
               		html += '<tbody>';
               		
                   	$.each(result,function(index, item){
                   		html += '<tr>';
                   		html += '<td style="word-break:break-all" width="30%">'+item.DetailName+'</td>';
                   		html += '<td style="word-break:break-all" width="30%">'+item.Example+'</td>';
                   		html += '<td style="word-break:break-all" width="40%"><input type="text" class="form-control" id="answer'+item.DetailId+'" name="answer'+item.DetailId+'"></td>';
                   		html += '</tr>';
                    });
                   	
                   	html += '</tbody>';
               		html += '</table>';
                   
                    $("#Categories").append(html);
                    
				}).fail(function() {
					console.log("fail");
				});
		}
		
		function inputCheck() {
			var isRight = true;
	   		$("#rewardDetailForm").find("input[type=text]").each(function(index, item){
	               // 아무값없이 띄어쓰기만 있을 때도 빈 값으로 체크되도록 trim() 함수 호출
	               if($(this).val().trim() == '') {
	                   isRight = false;
	               }
		    });
	   		if($("#policy").val() == ''){
	   			isRight = false;
	   		}
	   		
	        if(isRight) {
	        	$("#rewardDetailForm").submit();
	        }else{
	        	alert("모든 항목을 입력해주세요.");
	        }	
		}
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
              <button type="button" class="btn btn-outline-primary btn-rounded btn-fw" onclick="location.href='myprojectList.on'">나가기</button>
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
                    <form class="forms-sample" id="rewardDetailForm" action="${contextPath}/rewardDetailReg.on" method="post">
                    <input type="hidden" name="cmd" value="register">
                    <input type="hidden" id="fundingId" name="fundingId" value="${fundingId}">
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
                            	<input type="button" class="input-file-button col-md-1" style="font-size: 17px;" onclick="selectCategory();" value="선택">
							</div>
                          </div>
                          <div style="margin: 30px 0;" id="Categories">
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
                            	<textarea rows="7" cols="" class="form-control" id="policy" name="policy"
                            	placeholder="(예시)
-보증기간: 리워드 수령일로부터  1년
-규정: 정상적인 상태에서 사용중 발생한 제품하자인 경우 1:1교체
-A/S불가 규정: 보증기간 이내일지라도 사용자의 고의 또는 과실로 인하여 제품 수리 및 재생이 불가능한 경우"></textarea>
                            	
							</div>
                          </div>
                        </div>
                    </div>
                    <div class="col-md-3" style="padding-left: 0;">
                    	<input type="button" class="saveBtn" value="저장하기" onclick="inputCheck()">
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