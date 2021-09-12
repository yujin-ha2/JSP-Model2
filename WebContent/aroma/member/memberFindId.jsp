<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String id = (String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop - Login</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="icon" href="${contextPath}/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nouislider/nouislider.min.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
</head>
<body>
	<jsp:include page="../top1.jsp" />
    
	   <section class="order_details section-margin--small">
    <div class="container">  
      	
	<ul class="nav nav-tabs" id="myTab" role="tablist" style="background: none;">
		<li class="nav-item">
			<a class="nav-link" id="password-tab" data-toggle="tab" href="${contextPath}/" role="tab" aria-controls="pwdUpdate" aria-selected="false">비밀번호 변경</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" id="myinfo-tab" data-toggle="tab" href="${contextPath}/" role="tab" aria-controls="myinfo" aria-selected="false">개인정보 수정</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" id="delete-tab" data-toggle="tab" href="${contextPath}/" role="tab" aria-controls="delete" aria-selected="false">회원 탈퇴</a>
		</li>
	</ul>
	<div class="tab-content">
	  <div class="tab-pane fade" id="pwdUpdate" role="tabpanel" aria-labelledby="password-tab">
	    <p>Nunc vitae turpis id nibh sodales commodo et non augue. Proin fringilla ex nunc. Integer tincidunt risus ut facilisis tristique.</p>
	  </div>
	  <div class="tab-pane fade" id="myinfo" role="tabpanel" aria-labelledby="myinfo-tab">
	    <p>Curabitur dignissim quis nunc vitae laoreet. Etiam ut mattis leo, vel fermentum tellus. Sed sagittis rhoncus venenatis. Quisque commodo consectetur faucibus. Aenean eget ultricies justo.</p>
	  </div>
	  <div class="tab-pane fade" id="delete" role="tabpanel" aria-labelledby="delete-tab">
		<p>dfsdfsdkfjkdl</p>
      </div>	  
	</div>
	
  </div>
  </section>
  

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