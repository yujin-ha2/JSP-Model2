<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>GoodFunding</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <script type="text/javascript">
	function infoCheck(obj) {
		if(obj.myEmail.value==""){
	    	document.getElementById('emailck').innerHTML='이메일을 입력해 주세요.';
	    	obj.myEmail.focus();
	    	return false;
		}else if(obj.myPhone.value==""){
	    	document.getElementById('phoneck').innerHTML='휴대폰번호를 입력해 주세요.';
	    	obj.myPhone.focus();
	    	return false;
  		}
	 }
  	
  	function pwdCheck(obj) {
		//비밀번호 길이 체크(4~15자 까지 허용)
		if (obj.pwd.value.length<8 || obj.pwd.value.length>15){
			document.getElementById('pwsame1').innerHTML='비밀번호는 8자리이상 15자리 이하입니다.';
			obj.pwd.focus();
			obj.pwd.select();
	 		return false;
		}
	
		if(obj.pwd_rpeat.value==""){
		 	document.getElementById('pwsame2').innerHTML='비밀번호를 입력해 주세요.';
		 	obj.pwd_rpeat.focus();
		 	return false;
		}
		//비밀번호와 비밀번호 확인 일치여부 체크
		else if (obj.pwd.value!=obj.pwd_rpeat.value){
		 	document.getElementById('pwsame2').innerHTML = '비밀번호가 다릅니다 다시 확인해 주세요.';
		 	obj.pwd_rpeat.value="";
		 	obj.pwd_rpeat.focus();
	 		return false;
		}
  	}
  	
  	function deleteCheck(obj) {
  		if(obj.delPwd.value==""){
	    	document.getElementById('pwdck').innerHTML='비밀번호를  입력해 주세요.';
	    	obj.delPwd.focus();
	    	return false;
		}	
  	}
  	
  </script>
  <style type="text/css">
	.p1{
		font-size: 20px; font-weight: bold; color: black; margin-bottom: 0;
		}
	.p2{
		margin-top: 0; font-size: 15px;
	}
  </style>
</head>
<body>
  <jsp:include page="../top1.jsp" />

   <section class="order_details section-margin--small">
   		<div class="container">  
      		<ul class="nav nav-tabs" id="myTab" role="tablist">
		  		<li class="nav-item">
		    		<a class="nav-link" id="MemberUpdtae-tab" data-toggle="tab" href="#MemberUpdtae" role="tab" aria-controls="MemberUpdtae" aria-selected="true">MY정보수정</a>
		  		</li>
		  		<li class="nav-item">
		    		<a class="nav-link active" id="find_pwd-tab" data-toggle="tab" href="#find_pwd" role="tab" aria-controls="find_pwd" aria-selected="false">비밀번호 변경</a>
		  		</li>
		  		<li class="nav-item">
		    		<a class="nav-link" id="MemberDelete-tab" data-toggle="tab" href="#MemberDelete" role="tab" aria-controls="MemberDelete" aria-selected="false">탈퇴하기</a>
		  		</li>
			</ul>
			<div class="tab-content" id="myTabContent"  align="center" >
			
				<!--================정보 수정=================-->
				<div class="tab-pane fade" id="MemberUpdtae" role="tabpanel" aria-labelledby="MemberUpdtae-tab"  style="width: 700px;margin: 100px 120px">
					<form class="row contact_form" method="post" id="myInfoForm" action="myInfoUpdate.me" onsubmit ="return infoCheck(this);" >
	            		<div class="col-md-12 form-group" style="margin-bottom: 30px" >
	            			<h6 align="left"><i class="fa fa-user"></i> 아이디</h6>
	                		<input type="text" class="form-control" name="myId" value="${mb.id}" readonly="readonly">
	            		</div>
	            		<br><br>
		             	<div class="col-md-12 form-group p_star" style="margin-bottom: 0px;">
	             			<h6 align="left"><i class="fa fa-lock"></i> 이름</h6>
	             		</div>
	            		<div class="col-md-12 form-group p_star" style="margin-bottom: 30px">
	            			<input type="text" class="form-control" name="myName"  value="${mb.name}" readonly="readonly" >
	           				<span id="nameck" style="color: red;"></span>
	            		</div>
	            		<br><br>
	            		<div class="col-md-12 form-group p_star" style="margin-bottom: 0px;">
	            			<h6 align="left"><i class="fa fa-envelope"></i> 이메일</h6>
	            		</div>
	            		<div class="col-md-12 form-group p_star" style="margin-bottom: 30px">
	                		<input type="text" class="form-control" name="myEmail">                         
	            			<span id="emailck" style="color: red;"></span>
	            		</div>
	            		<br><br>
	            		<div class="col-md-12 form-group p_star" style="margin-bottom: 0px;">
	            			<h6 align="left"><i class="fa fa-lock"></i>핸드폰 번호</h6>
	            		</div>
	            		<div class="col-md-12 form-group p_star" style="margin-bottom: 50px ">
	                		<input type="text" class="form-control" name="myPhone">                         
	            			<span id="phoneck" style="color: red;"></span>
	            		</div>
	             		<div class="col-md-12 form-group" align="center">
	          	 			<button type="submit" class="button button-tracking">수정완료</button>
	      		 		</div>
	            		<br><br><hr><br>
	        		</form>
				</div>
				
				<!--================비밀번호 찾기 =================-->
			 	<div class="tab-pane fade show active" id="find_pwd" role="tabpanel" aria-labelledby="find_pwd-tab" align="center" style="margin: 60px 120px 100px;">
			   	 	<div class="col-lg-8" style="height: 450px"><br>
	        			<form class="row contact_form" method="post" id="findForm" action="passwordUpdate.me" onsubmit ="return pwdCheck(this);">
	        				<input type="hidden" name="type" value="mypage">
	        				<input type="hidden" name="userId" value="${mb.id}">
	             			<div class="col-md-12 form-group p_star" style="margin-bottom: 0px;">
	             				<h6 align="left"><i class="fa fa-lock"></i> 비밀번호</h6>
	             			</div>
	            			<div class="col-md-12 form-group p_star">
	            				<input type="password" class="form-control" name="pwd" placeholder="7~15자 이내로 작성해 주세요.">
	           					<span id="pwsame1" style="color: red;"></span>
	            			</div>
	            			<div class="col-md-12 form-group p_star" style="margin: 30px 0 0 0; width: 100%">
	            				<h6 align="left"><i class="fa fa-lock"></i> 비밀번호 확인</h6>
	            			</div>
	            			<div class="col-md-12 form-group p_star">
	                			<input type="password" class="form-control" name="pwd_rpeat" placeholder="7~15자 이내로 작성해 주세요.">                         
	           					<span id="pwsame2" style="color: red;"></span>
	            			</div>
	             			<div class="col-md-12 form-group" align="center" style="margin-top: 35px">
	          	 				<button type="submit" class="button button-tracking">변경 완료</button>
	      		 			</div>
	            			<br><br>
	        			</form>
	    			</div>
			 	</div>
			 
				<!--================탈퇴하기 =================-->
				<div class="tab-pane fade" id="MemberDelete" role="tabpanel" aria-labelledby="MemberDelete-tab" style="width: 700px;margin: 100px 120px;">
	         		<form class="row contact_form" method="post" id="deleteForm" action="memberDelete.me" onsubmit ="return deleteCheck(this);">
	            		<div class="col-md-12 form-group" style="margin-bottom: 40px">
	            			<h6 align="left"><i class="fa fa-user"></i> 아이디</h6>
	                		<input type="text" class="form-control" name="delId" value="${mb.id}" readonly="readonly">
	            		</div>
	             		<div class="col-md-12 form-group" style="margin-bottom: 60px">
	            			<h6 align="left"><i class="fa fa-lock"></i> 비밀번호</h6>
	                		<input type="text" class="form-control" name="delPwd">
	                		<span id="pwdck" style="color: red;"></span>
	            		</div>
	             		<div class="col-md-12 form-group" align="center">
	          	 			<button type="submit" class="button button-tracking">탈퇴하기</button>
	      		 		</div>
	            		<br><br><hr><br>
	        		</form>
				</div>
			</div>	 
      	</div>
  </section>

  <jsp:include page="../bottom.jsp" />

</body>
</html>