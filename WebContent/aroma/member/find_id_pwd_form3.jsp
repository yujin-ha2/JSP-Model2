<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma-master"/>
  <link rel="icon" href="${contextPath}/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nouislider/nouislider.min.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  
</head>
  <script type="text/javascript">
  function check(f) {
		
		if(f.pwd.value==""){
		 	document.getElementById('pwsame1').innerHTML='비밀번호를 입력해 주세요.';
		 	f.pwd.focus();
		 	return false;
		}
		//비밀번호 길이 체크(4~15자 까지 허용)
		else if (f.pwd.value.length<4 || f.pwd.value.length>15){
			document.getElementById('pwsame1').innerHTML='비밀번호는 4자리이상 15자리 이하입니다.';
		 	f.pwd.focus();
		 	f.pwd.select();
	 		return false;
		}
	
		if(f.pwd_rpeat.value==""){
		 	document.getElementById('pwsame2').innerHTML='비밀번호를 입력해 주세요.';
		 	f.pwd_rpeat.focus();
		 	return false;
		}
		//비밀번호와 비밀번호 확인 일치여부 체크
		else if (f.pwd.value!=f.pwd_rpeat.value){
		 	document.getElementById('pwsame2').innerHTML = '비밀번호가 다릅니다 다시 확인해 주세요.';
		 	f.pwd_rpeat.value="";
		 	f.pwd_rpeat.focus();
	 		return false;
		}
	}	
	</script>
<body>
  <jsp:include page="../top1.jsp" />
  <!--================네브바 =================-->
   <section class="order_details section-margin--small">
    <div class="container">  
      	<ul class="nav nav-tabs" id="myTab" role="tablist">
		  <li class="nav-item">
		    <a class="nav-link active" id="find_id-tab" data-toggle="tab" href="#find_id" role="tab" aria-controls="find_id" aria-selected="true">아이디찾기</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" id="find_pwd-tab" data-toggle="tab" href="#find_pwd" role="tab" aria-controls="find_pwd" aria-selected="false">비밀번호 찾기</a>
		  </li>
		</ul>
			
			 <div class="tab-content" id="myTabContent">
			 
			 <!--================아이디찾기 =================-->
			  <div class="tab-pane fade show active" id="find_id" role="tabpanel" aria-labelledby="find_id-tab"  align="center">
			  <div class="col-lg-8" style="height:450px; padding-top: 35px"><br>
        		
        	<form class="row contact_form" method="post" id="f" action="./FindId.me" onsubmit ="return check(this);">
           
            <div class="col-md-12 form-group p_star" style="margin-bottom:0px; margin-top: 120px">
            <h6 style="float: left;"><i class="fa fa-envelope"></i> 이메일</h6></div>
            <div class="col-md-12 form-group p_star" style="padding-bottom: 30px">
                <input type="text" class="form-control" name="email" placeholder="이메일 계정을 입력해 주세요">                         
            	<span id="emailck" style="color: red;"></span>
            </div>
           
             <div class="col-md-12 form-group" align="center">
          	 <button type="submit" value="submit" class="button button-tracking">찾기</button>
          	 <!-- <button type="submit" value="submit" class="button button-tracking">취소하기</button> -->
      		 </div>
      		 
            <br><br><hr><br>
        </form>
    </div>
			  
			  
			  </div><!-- 아이디 -->
			 
			
			   <!--================비밀번호 찾기 =================-->
		<div class="tab-pane fade" id="find_pwd" role="tabpanel" aria-labelledby="find_pwd-tab" align="center">
		
		<div class="col-lg-8" style="padding-top: 90px; height: 450px"><br>
        	<form class="row contact_form" method="post" id="f" action="PwdUpdate.me" onsubmit ="return check(this);">
             <input type="hidden" name="id" value="${requestScope.uid }">
             <div class="col-md-12 form-group p_star" style="margin-bottom: 0px;">
             <h6 align="left"><i class="fa fa-lock"></i> 비밀번호</h6></div>
            <div class="col-md-12 form-group p_star">
            	<input type="password" class="form-control" name="pwd" placeholder="대소문자,숫자 및 특수 문자를 조합해 8~15자 이내로 작성해 주세요.">
           		<span id="pwsame1" style="color: red;"></span>
            </div>
            
            <div class="col-md-12 form-group p_star" style="margin: 30px 0 0 0; width: 100%">
            <h6 align="left"><i class="fa fa-lock"></i> 비밀번호 확인</h6></div>
            <div class="col-md-12 form-group p_star">
                <input type="password" class="form-control" name="pwd_rpeat" placeholder="대소문자,숫자 및 특수 문자를 조합해 8~15자 이내로 작성해 주세요.">                         
           		<span id="pwsame2" style="color: red;"></span>
            </div>
          
            
             <div class="col-md-12 form-group" align="center" style="margin-top: 35px">
          	 <button type="submit" value="submit" class="button button-tracking">변경 완료</button>
          	 <!-- <button type="submit" value="submit" class="button button-tracking">취소하기</button> -->
      		 </div>
      		 
            <br><br>
        </form>
    </div>
</div><!-- 비번 -->
		
		
		</div><!-- myTabContent -->	 
      </div><!-- container -->
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