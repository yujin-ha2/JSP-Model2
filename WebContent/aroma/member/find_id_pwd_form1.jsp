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
	
		if(f.id.value==""){
		 	document.getElementById('idck').innerHTML='아이디를 입력해 주세요.';
		 	f.id.focus();
		 	return false;
		
	
		}else if(f.email.value==""){
	    	document.getElementById('emailck').innerHTML='이메일을 입력해 주세요.';
	    	f.email.focus();
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
		  <div class="col-lg-8" style="padding-top: 50px; height: 450px"><br>
        	
         	<form class="row contact_form" method="post" id="f" action="CheckMember.me" onsubmit ="return check(this);">
             <div class="col-md-12 form-group p_star" style="margin-bottom: 0px;margin-top: 50px">
             <h6 align="left"><i class="fa fa-lock"></i> 아이디 </h6></div>
            <div class="col-md-12 form-group p_star" style="padding-bottom: 15px">
            	<input type="text" class="form-control" name="id" placeholder="아이디를 입력해 주세요">
           		<span id="idck" style="color: red;"></span>
            </div>
			
			<div style="margin: 10px 0 40px 0; width: 100%">
            <div class="col-md-12 form-group p_star">
            <h6 align="left"><i class="fa fa-envelope"></i> 이메일</h6>
            </div>
            <div class="col-md-12 form-group p_star">
                <input type="text" class="form-control" name="email" placeholder="이메일 계정을 입력해 주세요">                         
            	<span id="emailck" style="color: red;"></span>
            </div>
            </div>
            

             <div class="col-md-12 form-group" align="center"" style="margin-bottom: 50px;">
          	 <button type="submit" value="submit" class="button button-tracking">인증 하기</button>
          	 <!-- <button type="submit" value="submit" class="button button-tracking">취소하기</button> -->
      		 </div>
      		 
            <br><br><hr><br>
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