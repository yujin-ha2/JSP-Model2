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
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <script type="text/javascript">
	function check(obj) {
		if(obj.id.value==""){
		 	document.getElementById('idck').innerHTML='아이디를 입력해 주세요.';
		 	obj.id.focus();
	 		return false;
		}else if(obj.email.value==""){
    		document.getElementById('emailck').innerHTML='이메일을 입력해 주세요.';
    		obj.email.focus();
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
        				<form class="row contact_form" method="post" id="findForm" action="showId.me" onsubmit ="return check(this);">
            				<div class="col-md-12 form-group p_star" style="margin-bottom:0px; margin-top: 80px">
            					<h6 style="float: left;"><i class="fa fa-envelope"></i> 이메일</h6>
            				</div>
           					<div class="col-md-12 form-group p_star" style="padding-bottom: 30px">
               					<input type="text" class="form-control" name="email" placeholder="이메일 계정을 입력해 주세요">                         
           						<span id="emailck" style="color: red;"></span>
           					</div>
			                <div class="col-md-12 form-group" align="center">
          	 					<button type="submit" class="button button-tracking">아이디 찾기</button>
      		 				</div>
				            <br><br><hr><br>
        				</form>
    				</div>
			    </div>
			   <!--================비밀번호 찾기 =================-->
		 	   <div class="tab-pane fade" id="find_pwd" role="tabpanel" aria-labelledby="find_pwd-tab" align="center">
		  			<div class="col-lg-8" style="padding-top: 20px; height: 450px">
         				<form class="row contact_form" method="post" id="findForm" action="userCheck.me" onsubmit ="return check(this);">
         					<input type="hidden" name="type" value="findPwd">
             				<div class="col-md-12 form-group p_star" style="margin-bottom: 0px;margin-top: 50px">
             					<h6 align="left"><i class="fa fa-lock"></i> 아이디 </h6>
           					</div>
            				<div class="col-md-12 form-group p_star" style="padding-bottom: 15px">
            					<input type="text" class="form-control" name="userId" placeholder="아이디를 입력해 주세요">
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
             				<div class="col-md-12 form-group" align="center" style="margin-bottom: 50px;">
          	 					<button type="submit" value="submit" class="button button-tracking">인증 하기</button>
      		 				</div>
        				</form>
    				</div>
		 		</div>
			</div>	 
      	</div>
  </section>

  <jsp:include page="../bottom.jsp" />

</body>
</html>