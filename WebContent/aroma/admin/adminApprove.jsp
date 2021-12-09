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
  <script type="text/javascript">
  	function newInputForm(fundingId, projectTitle, btnValue) {
  		var projectStatus = (btnValue == "승인") ? "approve" : "reject";
  		var html = "";
  		html += "<div style='margin: 50px 0;' class='card'>";
  		html += "<form method='post' action='${contextPath}/AdminApproveAction.ad' name='approvalForm' onsubmit='return checked()'>";
  		html += "<input type='hidden' id='projectStatus' name='projectStatus' value='"+projectStatus+"'>";
  		html += "<input type='hidden' id='fundingId' name='fundingId' value='"+fundingId+"'>";
  		html += "<div class='card-body'>";
  		html += projectTitle;
  		html += "<textarea rows='3' id='comment' name='comment' style='width: 100%' placeholder='메이커에게 전달하고 싶은 메세지를 입력해주세요'></textarea>";
  		html += "<input type='submit' class='btn btn-outline-primary' style='float: right; margin-bottom: 20px;' value='프로젝트 "+btnValue+"'>";
  		html += "</div>";
  		html += "</form>";
  		html += "</div>";
  		
  		$("#messageDiv").empty();
  		$("#messageDiv").append(html);
	}
  	
  	function checked() {
		if($("#comment").val().length < 15){
			alert("메세지는 15자 이상이어야 합니다");
			return false;
		}
	}
  	
  </script>
  <style type="text/css">
    .nav-link{
        color: white;
    }
    .nav-link:hover{
        color:white;
    }
  </style>
</head>
<body>
	<ul class="nav nav-tabs" id="myTab" role="tablist" style="background-color: #3549EC;">
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/MemberManagement.ad" aria-selected="false">회원 관리</a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" href="${contextPath}/AdminApproveListAction.ad" aria-selected="true">승인 관리</a>
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

  	<section class="order_details section-margin--small">
    <div class="container">
        <h3 style="text-align: left">승인관리</h3>
        <p style="text-align: left; margin-top: 15px">승인 관리가 필요한 글 목록입니다.</p>
        <table class="table">
        	<thead class="thead">
          		<tr> 
	          		<th width="15%">메이커</th>
	          		<th width="35%">프로젝트 이름</th>
	          		<th width="20%">신청일자</th>
	          		<th width="15%">상세내용</th>
	          		<th width="15%">승인</th>
          		</tr>
       		</thead>
       		<tbody>
       		<c:if test="${empty approvalList}">
       			<tr>
       				<td colspan="6" style="text-align: center;">승인 신청한 프로젝트가 없습니다.</td>
       			</tr>
       		</c:if>
       		<c:forEach var="list" items="${approvalList}">
       			<tr>
        			<td width="15%">${list.makerName }</td>
        			<td width="35%">${list.projectTitle}</td>
        			<fmt:formatDate var="submitDate" pattern="yyyy-MM-dd HH:mm:ss" value="${list.submitDate}"/>
        			<td width="20%">${submitDate}</td>
        			<td width="15%"><input type="button" value="상세내용 보기" class="btn btn-outline-primary" onclick="location.href='BasicRequireRegForm.on?fundingId=${list.fundingId}';" ></td>
        			<td width="15%">
        				<input type="button" id="approveBtn" value="승인" class="btn btn-outline-primary btn-sm" style="margin-right: 5px;" 
        						onclick="newInputForm('${list.fundingId}','${list.projectTitle}','승인');">
        				<input type="button" id="rejectBtn" value="반려" class="btn btn-outline-primary btn-sm" 
        						onclick="newInputForm('${list.fundingId}','${list.projectTitle}','반려');" >
        			</td>
        		</tr>
       		</c:forEach>
          	</tbody>
        </table>
        <div id="messageDiv">
        </div>
    </div>
  </section>

  <jsp:include page="../bottom.jsp" />
</body>
</html>