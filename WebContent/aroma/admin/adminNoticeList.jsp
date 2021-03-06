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
  	//검색 결과를 리스트로 받아올 때는 로딩시 키워드, 키필드를 채워줘야 함!!
	function searchFormCheck() {
		if(document.searchForm.keyword.value == ""){
			alert("검색어를 입력하세요");
			document.search.keyword.focus();
			return;
		}
		document.searchForm.submit();
	}
  	
  	function changePage(page) {
		$("#selectPage").val(page); 
		searchForm.submit();
	}
  </script>
  <style type="text/css">
    .nav-link{
        color: white;
    }
    .nav-link:hover{
        color:white;
    }
    #wrapper{
	  display: flex; 
	  min-height: 90%; 
	  flex-direction: column;
	}
	.main-content{
		flex: 1;
	}

	html,body{ 
		margin:0; 
		padding:0; 
		width:100%; 
		height:100%;
	}
  </style>
</head>
<body>
<div id="wrapper">
	<ul class="nav nav-tabs" id="myTab" role="tablist" style="background-color: #3549EC;">
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/MemberManagement.ad" aria-selected="false">회원 관리</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/AdminApproveListAction.ad" aria-selected="false">승인 관리</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/AdminBannerSetAction.ad" aria-selected="false">배너 관리</a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" href="${contextPath}/NoticeList.ad" aria-selected="true">공지사항 관리</a>
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
    <section class="order_details section-margin--small main-content">
    	<div class="container">
           	<h3 style="text-align: left">공지사항 관리</h3>
           	<p style="text-align: left; margin-top: 15px">공지사항을 관리하는 곳입니다.</p>
			
			<form action="NoticeList.ad" name="searchForm">
			<input type="hidden" id="selectPage" name="selectPage" value="1">
			<div class="row">
			<div class="input-group col-lg-4 ml-auto">
			<div class="input-group-prepend">
		      <select class="custom-select" name="keyfield" style="width: 6em;">
				  <option value="title">제목</option>
				  <option value="writerId">작성자</option>
			 </select>
		      <input type="text" class="form-control" name="keyword" style="height: 38px;">
		      <button type="submit" class="btn btn-default" onclick="searchFormCheck();">검색</button>
		     </div>
		   	
		    </div><!-- /input-group -->
		    </div>	
	        <div class="table-responsive" style="padding-top: 3em;">
			<!-- Table -->
			<table id="mytable" class="table table table-hover">
				<thead style="background-color: white; color: #979797;">
					<th width="10%">번호</th>
					<th width="45%">글제목</th>
					<th width="15%">작성자</th>
					<th width="15%">작성날짜</th>
					<th width="15%">조회수</th>
				</thead>
				
				<tbody>
				<c:if test="${empty vector}">
					<tr>
						<td colspan="6" align="center">등록된 글이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="v" items="${vector}" varStatus="status">
				<c:set var="index" value="${status.count + (currentPage-1)*5}" />
					<tr>
						<td>${index}</td>
						<td><a href="NoticeView.ad?cmd=view&noticeId=${v.noticeId}">${v.title}</a></td>
						<td>${v.writerId}</td>
						<fmt:formatDate var="regdate" value="${v.regdate}" pattern="yyyy-MM-dd" />
						<td>${regdate}</td>
						<td>&nbsp&nbsp${v.hit}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<div class="float-right">
		   	<input type="button" value="공지사항 작성" class="btn btn-primary pull-right" onclick="location.href='NoticeRegisterForm.ad';">
			</div>
			<div class="clearfix" style="padding-top: 2em;"></div>
			
			<nav class="navbar">
				<ul class="pagination mx-auto" >
					<li class="${className}" style="padding: 0;">
						<a class="page-link" onclick="changePage('prev');">이전</a>
					</li>
					<c:set var="start" value="${startPage}"/>
					<c:set var="last" value="${lastPage}"/>
					<c:forEach var="page" begin="${start}" end="${last}" step="1">
					<c:if test="${page eq currentPage }">
						<c:set var="className" value="page-item active"/>
					</c:if>
					<c:if test="${page ne currentPage }">
						<c:set var="className" value="page-item"/>
					</c:if>
					<li class="${className}" style="padding: 0;">
						<a class="page-link" onclick="changePage(${page});">${page}</a>
					</li>
					</c:forEach>
					<li class="page-item" style="padding: 0;">
						<a class="page-link" onclick="changePage('next');">다음</a>
					</li>
				</ul>
			</nav>
           </div>
           </form>
		</div>
	</section>
</div>
<footer>
	<jsp:include page="../bottom.jsp" />
</footer>
</body>
</html>