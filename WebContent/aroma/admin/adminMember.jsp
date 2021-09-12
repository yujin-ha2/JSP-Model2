<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-latest.js"></script>  
 
<head>
<style type="text/css">
    .nav-link{
        color: white;
    }
    .nav-link:hover{
        color:white;
    }
    
</style>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Funding</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="icon" href="${contextPath}/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
</head>
<body>

	<ul class="nav nav-tabs" id="myTab" role="tablist" style="background-color: #3549EC;">
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/AdminApproveListAction.ad" aria-selected="true">승인관리</a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" onclick="location.href='${contextPath}/AdminMemberGeneralListAction.ad'" aria-selected="false">회원관리</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/AdminBannerSetAction.ad" aria-selected="false">배너관리</a>
        </li>
        <li class="nav-item">
         	<a class="nav-link" href="index.jsp" aria-selected="false">
        	<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16" style="color: white; padding-bottom: 3px">
  				<path fill-rule="evenodd" d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6zm5-.793V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z"/>
  				<path fill-rule="evenodd" d="M7.293 1.5a1 1 0 0 1 1.414 0l6.647 6.646a.5.5 0 0 1-.708.708L8 2.207 1.354 8.854a.5.5 0 1 1-.708-.708L7.293 1.5z"/>
			</svg>
			</a>
		</li>
	</ul>

    <!-- start 관리자 메뉴 -->
    <section class="order_details section-margin--small">
    	<div class="container">
			<table style="text-align: center; width: 100%">
            	<td width="200px"  style="border-right: 1px solid lightgray;">
                	<img src="./img/r10.jpg" style="border-radius: 100px"/> <br/>
                    <p style="margin: 10px">관리자님 <br/> 안녕하세요</p>
                    <a class="button button-header" href="#">로그아웃</a>
				</td>
		        <td width="1000px" align="center" style="padding-left: 30px">
            	<h3 style="text-align: left">회원관리</h3>
            	<p style="text-align: left; margin-top: 15px">회원의 활동 상태를 관리하는 페이지입니다.</p>
	
	            <section class="product_description_area">
	            <div class="container">
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item">
							<a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">일반회원</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
							 aria-selected="false">판매회원</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
							 aria-selected="false">정지회원</a>
						</li>
					</ul>
					<!-- 일반회원 -->
					<div  class="tab-content"  id="myTabContent">
						<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
							<div class="single-search-product d-flex">
					          <table class="table">
					          <thead class="thead">
					          	<tr>
					          		<th scope="col">회원이름</th>
					          		<th scope="row">회원아이디</th>
					          		<th scope="col">회원이메일</th>
					          		<th scope="col" style="text-align: center;">관리</th>
					          	</tr>
					          	</thead>
					          	<tbody>
					          	<c:forEach var="g" items="${g}">
					          		<tr>
					          			<td>${g.name}</td>
					          			<td>${g.id}</td>
					          			<td>${g.email}</td>
					          			<td scope="col"><input type="button" value="정지" onclick="location.href='${contextPath}/AdminMemberSuspenderAction.ad?id=${g.id }'"></td>
					          		</tr>
					          	</c:forEach>
					          		
					          	</tbody>
					          </table>
          					</div>
						</div>
				
					<!-- 판매회원 -->
					<div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
						<div class="table-responsive">
							 <div class="single-search-product d-flex">
						          <table class="table">
						          <thead class="thead">
						          	<tr>
						          		<th scope="col">회원이름</th>
						          		<th scope="row">회원아이디</th>
						          		<th scope="col">회원이메일</th>
						          		<th scope="col" colspan="2" style="text-align: center;">관리</th>
						          	</tr>
						          	</thead>
						          	<tbody>
						          	<c:forEach var="se" items="${se}">
						          		<tr>
						          			<td>${se.name }</td>
						          			<td>${se.id }</td>
						          			<td>${se.email }</td>
						          			<td scope="col"><input type="button" value="정지" onclick="location.href='${contextPath}/AdminMemberSuspenderAction.ad?id=${se.id }'"></td>
						          		</tr>
						          	</c:forEach>
						          	</tbody>
						          </table>
						      </div>
						</div>
					</div>
				
					<!-- 정지회원 -->	
					<div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
						<div class="table-responsive">
							 <div class="single-search-product d-flex">
						         <table class="table">
							         <thead class="thead">
							        	<tr>
							        		<th scope="col">회원이름</th>
							          		<th scope="row">회원아이디</th>
							        		<th scope="col">회원이메일</th>
							          		<th scope="col" style="text-align: center;">관리</th>
							        	</tr>
							        </thead>
							        <tbody>
									<c:forEach var="su" items="${su}">
					          		<input type="hidden" value="${su.makerNo}" name="maker">
						          		<tr>
						          			<td>${su.name }</td>
						          			<td>${su.id }</td>
						          			<td>${su.email }</td>
						          			<td scope="col"><input type="button" value="해제" onclick="location.href='${contextPath}/AdminMemberStateReturnAction.ad?id=${su.id}'"></td>
						          		</tr>
						          	</c:forEach>
						          	</tbody>
					            </table>
				          	</div>
						</div>
					</div>
					</div>
				</div>
			    </section>
				</td>
			</table>
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