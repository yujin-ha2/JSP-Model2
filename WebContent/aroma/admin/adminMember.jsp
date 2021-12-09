<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
  <title>GoodFunding</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <style type="text/css">
    .nav-link{
        color: white;
    }
    .nav-link:hover{
        color:white;
    }
    
    #subTab .nav-link {
        color: navy;
    }
    #subTab  .nav-link :hover{
        color: navy;
    }
  </style>
</head>
<body>
	<ul class="nav nav-tabs" id="myTab" role="tablist" style="background-color: #3549EC;">
		<li class="nav-item">
            <a class="nav-link active" href="${contextPath}/MemberManagement.ad" aria-selected="false">회원 관리</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/AdminApproveListAction.ad" aria-selected="false">승인 관리</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/AdminBannerSetAction.ad" aria-selected="false">배너 관리</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/NoticeList.ad" aria-selected="false">공지사항 관리</a>
        </li>
        <li class="nav-item">
         	<a class="nav-link" href="${contextPath}/main.do" aria-selected="false">
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
           	<h3 style="text-align: left">회원관리</h3>
           	<p style="text-align: left; margin-top: 15px">회원의 활동 상태 및 권한을 관리하는 페이지입니다.</p>
            
			<ul class="nav nav-tabs" id="subTab" role="tablist">
				<li class="nav-item">
					<a class="nav-link active" id="home-tab" data-toggle="tab" href="#home">일반회원</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile">판매회원</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact">정지회원</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="contact-tab" data-toggle="tab" href="#adminAccount">관리자</a>
				</li>
			</ul>
			
			<!-- 일반회원 -->
			<div  class="tab-content"  id="myTabContent">
				<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
					<div class="single-search-product d-flex">
			          <table class="table" style="text-align: center;">
			          <thead class="thead">
			          	<tr>
			          		<th width="20%">회원이름</th>
			          		<th width="20%">회원아이디</th>
			          		<th width="20%">회원이메일</th>
			          		<th width="20%" style="text-align: center;">계정 상태 변경</th>
			          		<th width="20%" style="text-align: center;">계정 권한 변경</th>
			          	</tr>
			          	</thead>
			          	<tbody>
			          	<c:forEach var="g" items="${generalMembers}">
			          		<tr>
			          			<td width="20%">${g.name}</td>
			          			<td width="20%">${g.id}</td>
			          			<td width="20%">${g.email}</td>
			          			<td width="20%">
			          				<input type="button" value="정지계정으로" class="btn btn-outline-secondary" 
			          						onclick="location.href='${contextPath}/ChangeAccountStatus.ad?current=using&id=${g.id}';">
			          			</td>
			          			<td scope="col">
			          				<input type="button" value="관리자권한으로" class="btn btn-outline-secondary" 
			          						onclick="location.href='${contextPath}/ChangeAccountAuthority.ad?current=user&id=${g.id}';">
			          			</td>
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
					          <table class="table" style="text-align: center;">
					          <thead class="thead">
					          	<tr>
					          		<th width="25%">회원이름</th>
					          		<th width="25%">회원아이디</th>
					          		<th width="25%">회원이메일</th>
					          		<th width="25%" colspan="2">계정 상태 변경</th>
					          	</tr>
					          	</thead>
					          	<tbody>
					          	<c:forEach var="se" items="${sellerMembers}">
					          		<tr>
					          			<td width="25%">${se.name }</td>
					          			<td width="25%">${se.id }</td>
					          			<td width="25%">${se.email }</td>
					          			<td scope="col">
					          				<input type="button" value="정지계정으로" class="btn btn-outline-secondary"
					          						onclick="location.href='${contextPath}/ChangeAccountStatus.ad?current=using&id=${se.id}';">
					          			</td>
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
					         <table class="table" style="text-align: center;">
						         <thead class="thead">
						        	<tr>
						        		<th width="20%">회원이름</th>
						          		<th width="20%">회원아이디</th>
						          		<th width="20%">회원이메일</th>
						          		<th width="20%" style="text-align: center;">계정관리</th>
						          		<th width="20%">계정권한</th>
						        	</tr>
						        </thead>
						        <tbody>
						        <c:if test="${empty suspendedMembers}">
						        	<tr>
						        		<td colspan="5">정지 계정인 회원이 없습니다</td>
						        	</tr>
						        </c:if>
								<c:forEach var="su" items="${suspendedMembers}">
				          		<input type="hidden" value="${su.makerNo}" name="maker">
					          		<tr>
					          			<td width="20%">${su.name }</td>
					          			<td width="20%">${su.id }</td>
					          			<td width="20%">${su.email }</td>
					          			<td width="20%">
					          				<input type="button" value="계정 정지 해제" class="btn btn-outline-secondary"
					          						onclick="location.href='${contextPath}/ChangeAccountStatus.ad?current=suspend&id=${su.id}';">
					          			</td>
					          			<td width="20%">${su.authority }</td>
					          		</tr>
					          	</c:forEach>
					          	</tbody>
				            </table>
			          	</div>
					</div>
				</div>
				<!-- 관리자 계정 -->	
				<div class="tab-pane fade" id="adminAccount" role="tabpanel" aria-labelledby="contact-tab">
					<div class="table-responsive">
						 <div class="single-search-product d-flex">
					         <table class="table" style="text-align: center;">
						         <thead class="thead">
						        	<tr>
						        		<th width="25%">회원이름</th>
						          		<th width="25%">회원아이디</th>
						          		<th width="25%">회원이메일</th>
						          		<th width="25%" style="text-align: center;">권한관리</th>
						        	</tr>
						        </thead>
						        <tbody>
								<c:forEach var="a" items="${adminMembers}">
					          		<tr>
					          			<td width="25%">${a.name }</td>
					          			<td width="25%">${a.id }</td>
					          			<td width="25%">${a.email }</td>
					          			<td width="25%">
					          				<input type="button" value="관리자 권한 해제" class="btn btn-outline-secondary"
					          				 		onclick="location.href='${contextPath}/ChangeAccountAuthority.ad?current=admin&id=${a.id}';">
					          			</td>
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


  <jsp:include page="../bottom.jsp" />

</body>
</html>