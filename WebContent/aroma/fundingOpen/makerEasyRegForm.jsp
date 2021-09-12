<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop - Checkout</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="icon" href="${contextPath}/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nouislider/nouislider.min.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <style type="text/css">
	p{
		font-size: 10px; font-weight: 300;
	} 
  </style>
  
</head>
<body>
	<jsp:include page="../top1.jsp" />

    <!-- Modal -->
	<div class="modal fade" id="LoginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
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
  
  
  <!--================Checkout Area =================-->
  <section class="checkout_area section-margin--small" style="margin: 100px 300px;">
    <div class="container">
        <div class="billing_details">
            <div class="row">
                <div class="col-lg-12">
                    <h3>메이커 정보</h3>
                   	<h6>메이커/기업명</h6>
                   	<p>법인사업자는 법인등기부산 법인명/개인 사업자는 주민등록상 성명 또는 상호/ 개인은 주민등상 성명을 입력하세요</p>
                    <form class="row contact_form" action="makerEasyReg.on" method="post" novalidate="novalidate">
                        <div class="col-md-8 form-group">
                            <input type="text" class="form-control" id="makerName" name="makerName">
                        </div>
                        <div class="col-md-8 form-group p_star" style="margin-bottom: 0px;"><h6>개인/사업자 구분</h6></div>
                        <div class="col-md-8 form-group p_star">
                            <select class="country_select" id="makerType" name="makerType">
                                <option value="개인">개인</option>
                                <option value="법인사업자">법인사업자</option>
                                <option value="개인사업자">개인사업자</option>
                            </select>
                        </div>
                        <div class="col-md-8 form-group p_star" style="margin-bottom: 0px;"><h6>관리자명</h6></div>
                        <div class="col-md-8 form-group p_star">
                            <input type="text" class="form-control" name="memberName" value="${member.name}" readonly>
                        </div>
                        <div class="col-md-8 form-group p_star" style="margin-bottom: 0px;"><h6>관리자 이메일</h6></div>
                        <div class="col-md-8 form-group p_star">
                            <input type="text" class="form-control" name="memberEmail" value="${member.email}" readonly> 
                            <p>관리자명과 이메일 주소는 로그인 아이디와 연동되어 있으므로 변경을 원할 경우 회원 정보 설정에서 변경하세요</p>                        
                        </div>
                        
                        <div class="col-md-8 form-group p_star" style="margin-bottom: 0px;"><h6>관라자 휴대폰 번호</h6></div>
                        <div class="col-md-8 form-group p_star">
                            <input type="text" class="form-control" name="memberTel" value="${member.phone}" readonly>
                        </div>
                        
                        <div class="col-md-8 form-group" style="margin: 5px; margin-top: 50px;">
                        <h6><input type="checkbox" style="margin-right: 10px">(필수) 개인정보 수집 동의</h6>
                        </div>
                        <div class="col-md-8 form-group" align="center">
                      	  <button class="col-md-4" type="submit" style="color: #fff; background-color: #17a2b8; border-color: #117a8b;">메이커 등록하기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
  </section>
  <!--================End Checkout Area =================-->

  <jsp:include page="../bottom.jsp" />

  <script src="${contextPath}/vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="${contextPath}/vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="${contextPath}/vendors/skrollr.min.js"></script>
  <script src="${contextPath}/vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="${contextPath}/vendors/jquery.ajaxchimp.min.js"></script>
  <script src="${contextPath}/vendors/mail-script.js"></script>
  <script src="${contextPath}/js/main.js"></script>
</body>
</html>