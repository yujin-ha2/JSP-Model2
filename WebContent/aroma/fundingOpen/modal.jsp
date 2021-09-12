<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Aroma Shop - Login</title>
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
 
 <script type="text/javascript">
/*    $('#myModal').on('shown.bs.modal', function () {
        $('#myInput').trigger('focus')
      })
      
 */   

	 $('#clickbtn1').on( "click", function() {
		 aleret("dd");
		   $('#LoginModal').modal('show');
	});
	 
	 $('#clickbtn').on('show.bs.modal', function(e) {
			
			var button = $(e.relatedTarget);
			var modal = $(this);
			
			modal.find('.modal-body').load(button.data("remote"));
	
	});
	 
	 $(document).ready(function() {
		$('#LoginModal').modal('show'); 
	 });
 </script>
</head>
<body>
   <jsp:include page="../top1.jsp" />
   
   

   <!-- ================ start Modal area ================= -->
   <!-- Button trigger modal -->
   <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#LoginModal" >
     Launch demo modal
   </button>
   
   <button type="button" class="btn btn-primary" id="clickbtn" name="clickbtn">
   	click
   </button>
   
   <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#rewardModal">
     reward modal
   </button>

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


<!-- Modal -->
<div class="modal fade" id="rewardModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content" style="width: 650px; margin-top: 20px; padding: 80px 100px;">
      <div class="modal-header" style="border-bottom:0px;">
        <h5 class="modal-title" id="exampleModalCenterTitle" style="font-weight: 700; font-size: 23px;">리워드 정보 제공</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="padding-right: 25px; font-size: 2rem;">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" style="font-size: 17px; letter-spacing: -.02em;">
             서포터에게 제공하는 리워드의 종류를 선택하고 해당하는 리워드 정보 제공 고시를 입력하세요.
      </div>
      <div class="modal-footer" style="border-top: 0px; padding: 0 15px 20px 15px; flex-wrap: unset; text-align: center;" >
        <button type="button" class="btn btn-secondary" style="width: 100%; height: 40px; border: 1px solid rgba(0,0,0,.15);" data-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" style="width: 100%; margin-left: 10px; background-color: #00c4c4; border-color:#00c4c4; height: 40px;">등록</button>
      </div>
    </div>
  </div>
</div>

   <!--================End Modal Area =================-->


 <jsp:include page="../bottom.jsp" />



 <script src="${contextPath}/assets/vendors/js/vendor.bundle.base.js"></script>
 <script src="${contextPath}/assets/vendors/js/vendor.bundle.addons.js"></script>
 <script src="${contextPath}/assets/js/shared/off-canvas.js"></script>
 <script src="${contextPath}/assets/js/shared/misc.js"></script>
 <script src="${contextPath}/assets/js/demo_1/dashboard.js"></script>
 <script src="${contextPath}/assets/js/shared/jquery.cookie.js" type="text/javascript"></script>
</body>
</html>