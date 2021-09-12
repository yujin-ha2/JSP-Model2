<%@page import="net.funding.open.db.myProjectBean"%>
<%@page import="net.action.StatusName"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="icon" href="${contextPath}/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nouislider/nouislider.min.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <script type="text/javascript">
  	function goStudio(fundingId) {
  		alert('goStudio' + fundingId);
		location.href='${contextPath}/makerStudioMain.on?no=' + fundingId;
	}
  </script>
<body>
  <jsp:include page="../top1.jsp" />
    
   <section class="order_details section-margin--small">
    <div class="maincontainer">
    <c:set var="count" value="0"/>
    <c:if test="${projectList ne null}">
    	<c:set var="count" value="${projectList.size()}"/>
    </c:if>
	<h3>만든 프로젝트</h3><h3>${count}</h3>
	  <div style="padding-bottom: 35px;">
	  	<button type="button" onclick="location.href='makerStudioMain.on?no=0';" class="btn btn-outline-primary" style="float: right; margin-right: 10px;">프로젝트 오픈신청</button>
	  </div>
	  <hr>
	  
   	<div class="tab-content" id="myTabContent" style="padding: 10px;">
   		<%-- 이전에 생성한 프로젝트가 없는 경우 --%>
   		<c:if test="${projectList eq null || projectList.size() eq 0}">
			<div align="center" style="padding: 50px 0;">
				<p style="font-size: 20px; font-weight: 700; padding-bottom: 2	00px;"> 등록된 프로젝트가 없습니다. </p>
			</div>
		</c:if>
		<%-- 이전에 생성한 프로젝트가 있는 경우 --%>
	   	<div class="row">
			<c:if test="${projectList != null}">
			<c:forEach var="list" items="${projectList}" varStatus="status">
			  <c:choose>
			  	<c:when test="${list.mainImg ne null}">
			  		<c:set var="mainImg" value="${list.mainImg}"></c:set>
			  	</c:when>
			  	<c:otherwise>
			  		<c:set var="mainImg" value="noImg.PNG"></c:set>
			  	</c:otherwise>
			  </c:choose>
			  
			  <c:choose>
			  	<c:when test="${list.title ne null}">
			  		<c:set var="title" value="${list.title}"></c:set>
			  	</c:when>
			  	<c:otherwise>
			  		<c:set var="title" value="제목을 입력해주세요."></c:set>
			  	</c:otherwise>
			  </c:choose>
			  
					<div class="col-md-3">
						<div class="card-deck">
							<div class="card" style="">
							    <img class="card-img-top" src="/goodFunding_/fundingUpload/${mainImg}" style="height: 200px;">
							    <div class="card-body" style="height: 150px;">
							      <h6 class="card-title" align="left" style="height:35px;">${title}</h6>
							      <p class="card-text" align="left">${list.makerName}</p>
							      <p class="card-text" align="left">${list.status}</p>
							    </div>
							    <div class="card-footer" style="cursor: pointer;" onclick="location.href='makerStudioMain.on?no='+${list.fundingId};">
							      <p class="text-muted" style="font-weight: 700; color: #000000D6; font-size: 15px; margin: 0;">스튜디오 바로가기</p>
							    </div>
						  	</div>
					  	</div>
				  	</div>
			  	
			  </c:forEach>
			</c:if>

		
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