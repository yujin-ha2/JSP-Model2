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
	
		if(f.pwd.value==""){
		 	document.getElementById('pwsame1').innerHTML='비밀번호를 입력하시오';
		 	f.pwd.focus();
		 	return false;
		}
		//비밀번호 길이 체크(4~15자 까지 허용)
		else if (f.pwd.value.length<8 || f.pwd.value.length>15){
			document.getElementById('pwsame1').innerHTML='비밀번호는 8자리이상 15자리 이하입니다.';
		 	f.pwd.focus();
		 	f.pwd.select();
	 		return false;
		}
	
		if(f.pwd_rpeat.value==""){
		 	document.getElementById('pwsame2').innerHTML='비밀번호를 입력하시오';
		 	f.pwd_rpeat.focus();
		 	return false;
		}
		//비밀번호와 비밀번호 확인 일치여부 체크
		else if (f.pwd.value!=f.pwd_rpeat.value){
		 	document.getElementById('pwsame2').innerHTML = '비밀번호가 다릅니다 다시 확인하세요';
		 	f.pwd_rpeat.value="";
		 	f.pwd_rpeat.focus();
	 		return false;
		}
	}	
	</script>
</head>
<body>
  <jsp:include page="../top1.jsp" />
  
  <div class="col-lg-8" style="padding-left:700px"><br>
  	<p class="p1" align="center">비밀번호 변경</p>
   	<hr>
    	<form class="row contact_form" method="post" id="f" action="passwordUpdate.me" onsubmit ="return check(this);">
        	<input type="hidden" name="id" value="${id}">
        	<div class="col-md-12 form-group p_star">
        		<h6><i class="fa fa-lock"></i> 비밀번호</h6>
        		<input type="password" class="form-control" name="pwd" placeholder="대소문자,숫자 및 특수 문자를 조합해 8~20자 이내로 작성해 주세요.">
       			<span id="pwsame1" style="color: red;"></span>
        	</div>
        	<div class="col-md-12 form-group p_star">
           		<h6><i class="fa fa-lock"></i> 비밀번호 확인</h6>
           		<input type="password" class="form-control" name="pwd_rpeat" placeholder="대소문자,숫자 및 특수 문자를 조합해 8~20자 이내로 작성해 주세요.">                         
       			<span id="pwsame2" style="color: red;"></span>
        	</div>
      	   <div class="col-md-12 form-group" align="center" style="margin-bottom: 50px;">
      		 <button type="submit" value="submit" class="button button-tracking">변경</button>
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