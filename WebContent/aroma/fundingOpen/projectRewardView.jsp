<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
    	var index = 1;
    	
    	function inputNumberFormat(obj) {
    	     obj.value = comma(uncomma(obj.value));
    	 }

    	 function comma(str) {
    	     str = String(str);
    	     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    	 }

    	 function uncomma(str) {
    	     str = String(str);
    	     return str.replace(/[^\d]+/g, '');
    	 }
    	 
		function addRow(obj) {
			++index;
			/* var tr = btnId.parent().parent().attr('id'); */
			var tr = $(obj).parent().parent();
			/* alert($(tr).attr('id')); */
			
			var html = '';
			html += '<tr id="dynamicTr'+index+'">';
       		html += '<td style="word-break:break-all" width="35%"><input type="text" class="form-control" id="option'+index+'" name="option'+index+'"></td>';
       		html += '<td style="word-break:break-all" width="20%"><input type="text" class="form-control" id="price'+index+'" name="price'+index+'"></td>';
       		html += '<td style="word-break:break-all" width="10%"><input type="text" class="form-control" id="quantity'+index+'" name="quantity'+index+'"></td>';
       		html += '<td style="word-break:break-all" width="20%"><input type="text" class="form-control" id="deliveryDate'+index+'" name="deliveryDate'+index+'"></td>';
       		html += '<td style="word-break:break-all" width="10%"><input type="text" class="form-control" id="deliveryFee'+index+'" name="deliveryFee'+index+'"></td>';
       		html += '<td style="word-break:break-all" width="5%">';
       		html += '<input type="button" class="form-control" id="appendBtn" name="appendBtn" value="+" style="width: 50%;" onclick="addRow(this);">';
       		html += '<input type="button" class="form-control" id="removeBtn" name="removeBtn" value="-" style="width: 50%; margin-left: 3px;" onclick="deleteRow(this);">';
       		html += '</td>';
       		html += '</tr>';
       		
			$(tr).after(html);

		}
		
		function deleteRow(obj) {
			var cnt = $('#dynamicTbody tr').length;
			
			if(cnt>1){
				$(obj).parent().parent().remove();
			}else{
				alert("리워드는 1개 이상 작성하셔야 합니다.");
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
                    <h4 class="card-title" style="font-size: 36px; font-weight: 700; margin-bottom: 10px;">리워드 설계</h4>
                    <p class="col-md-7" style="padding-left:0; font-size: 16px; margin-bottom: 32px; line-height: 1.41;">
                    	서포터에게 제공할 리워드 내용을 입력하세요. 서포터가 쉽게 펀딩할 수 있는 저렴한 리워드부터 서포터의 보다 빠른 펀딩을 유도할 수 있는 얼리버드 리워드까지 다양한 리워드를 구성하세요.
                    </p>
                    </div>
                    <form class="forms-sample" action="./rewardUpdateForm.on" method="post" onsubmit="return checked()">
                    <input type="hidden" name="fundingId" id="fundingId" value="${fundingId}">
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
							 			<td class="condition">옵션 구성</td>
							 			<td>제품 옵션 이름으로 구성을 간단하게 등록하세요.</td>
							 		</tr>
							 		<tr>
							 			<td class="condition">옵션 상세 설명</td>
							 			<td>제품 구성 및 옵션(사이즈,색상 등)에 대해 상세하게 등록하세요.</td>
							 		</tr>
							 		<tr>
							 			<td class="condition">판매 가격</td>
							 			<td>해당 옵션의 펀딩 가격을 정확히 기입해주세요.</td>
							 		</tr>
							 		<tr>
							 			<td class="condition">제한 수량</td>
							 			<td>생상 및 제공할 수 있는 리워드의 총 수량으로 해당 수령이 모두 펀딩되면 더이상 펀딩 불가합니다.</td>
							 		</tr>
							 		<tr>
							 			<td class="condition">발송 시작일</td>
							 			<td> 설정한 발송 시작일까지 리워드가 발송되지 않을 경우, 서포터가 펀딩금 반환을 신청할 수 있으니 신중하게 선택하세요.</td>
							 		</tr>
							 	</table>
                            </div>
                            <div style="margin: 30px 0;" id="Categories">
	                          <table class="table table-hover">
			               		<thead>
				               		<tr>
										<th style="width: 30%">옵션 구성</th>
										<th style="width: 30%">옵션 상세 설명</th>
					               		<th style="width: 15%">제품 가격</th>
					               		<th style="width: 10%">제한 수량</th>
					               		<th style="width: 15%">발송 시작일</th>
					               		<th style="widht: 10%">배송비</th>
				               		</tr>
			               		</thead>
			               		<tbody id="dynamicTbody">
			               			<c:forEach var="list" items="${rewardList}">
									<tr>
										<td style="word-break:break-all" width="30%">${list.rewardOption}</td>
										<td style="word-break:break-all" width="30%">${list.rewardDetail}</td>
										<td style="word-break:break-all" width="15%"><fmt:formatNumber type="number" pattern="#,###" value="${list.price}"/></td>
										<td style="word-break:break-all" width="10%"><fmt:formatNumber type="number" pattern="#,###" value="${list.salesQuantity}"/></td>
										<td style="word-break:break-all" width="15%">${list.deliveryDate}</td>
										<td style="word-break:break-all" width="10%"><fmt:formatNumber type="number" pattern="#,###" value="${list.deliveryFee}"/></td>
									</tr>
									</c:forEach>
			                   	</tbody>
	                          </table>
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