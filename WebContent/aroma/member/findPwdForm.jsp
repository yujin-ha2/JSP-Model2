<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="net.member.db.MemberBean"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.p1{
	font-size: 20px; font-weight: bold; color: black; margin-bottom: 0;
	}
.p2{
	margin-top: 0; font-size: 15px;
}
</style>
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
  
  <script type="text/javascript">
	function check(f) {
	
		if(f.id.value==""){
		 	document.getElementById('idck').innerHTML='아이디는 반드시 입력해야합니다.';
		 	f.id.focus();
		 	return false;
		}
		
		if(f.email.value==""){
	    	document.getElementById('emailck').innerHTML='이메일은 반드시 입력해야합니다.';
	    	f.email.focus();
	    	return false;
		}
		
</script>
</head>
<body>
	
  <jsp:include page="../top1.jsp" />

  <div class="col-lg-8" style="padding-left:700px"><br>
      <p class="p1" align="center">비밀번호 찾기</p>
      <hr>
      <form class="row contact_form" method="post" id="f" action="CheckMember.me" onsubmit ="return check(this);">
         <div class="col-md-12 form-group p_star">
         	<h6><i class="fa fa-lock"></i> 아이디 </h6>
        	<input type="text" class="form-control" name="id" >
       		<span id="idck" style="color: red;"></span>
         </div>
         <div class="col-md-12 form-group p_star">
         	<h6><i class="fa fa-envelope"></i> 이메일</h6>
            <input type="text" class="form-control" name="email">                         
        	<span id="emailck" style="color: red;"></span>
         </div>
         <div class="col-md-12 form-group" align="center" style="margin-bottom: 50px;">
	      	 <button type="submit" value="submit" class="button button-tracking">인증 하기</button>
  		 </div>
      </form>
  </div>


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