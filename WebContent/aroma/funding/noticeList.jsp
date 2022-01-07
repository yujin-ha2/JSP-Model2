<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <script type="text/javascript">
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
<jsp:include page="../top1.jsp" />
<section class="" style="margin-top: 60px;">
	<div class="maincontainer" style="padding: 0 150px;">
        <h3 style="text-align: left">공지사항</h3>
        <form action="noticeList.do" name="searchForm">
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
				<table id="mytable" class="table table table-hover">
					<thead style="background-color: white; color: #979797;">
						<th width="55%">글제목</th>
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
					<c:forEach var="v" items="${vector}">
						<tr>
							<td><a href="notice.do?noticeId=${v.noticeId}">${v.title}</a></td>
							<td>${v.writerName}</td>
							<fmt:formatDate var="regdate" value="${v.regdate}" pattern="yyyy-MM-dd" />
							<td>${regdate}</td>
							<td>&nbsp&nbsp${v.hit}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<nav class="navbar" style="margin-top: 30px;">
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