<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
  <title>굿펀딩</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <script src="https://use.fontawesome.com/1210e2d4a3.js"></script>
  <style type="text/css">
    .nav-link{
        color: white;
    }
    .nav-link:hover{
        color:white;
    }
    .card-inner{
    		margin-left: 4rem;
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
    <section style="margin: 50px 0 100px 0;">
    	<div class="container">
    		<h3 style="text-align: left">공지사항 관리</h3>
            <p style="text-align: left; margin-top: 15px">공지사항을 관리하는 곳입니다.</p>
	
            <div class="card gedf-card">
               <div class="card-header">
                   <div class="d-flex justify-content-between">
                       <div class="d-flex justify-content-between">
                          <!--  <div class="mr-2">
                               <img class="rounded-circle" width="45" src="https://picsum.photos/50/50" alt="">
                           </div> -->
                           <div class="text-left">
                               <div class="h5 ">${bean.writerId}</div>
                               <fmt:formatDate var="regdate" value="${bean.regdate}" pattern="yyyy-MM-dd"/>
                               <div class="h7 text-muted"><i class="fa fa-clock-o"></i>&nbsp;${regdate}</div>
                           </div>
                       </div>
                       <div>
                           <div class="dropdown">
                               <button class="btn btn-link dropdown-toggle" type="button" id="gedf-drop1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                   <i class="fa fa-ellipsis-h"></i>
                               </button>
                               <div class="dropdown-menu dropdown-menu-right" aria-labelledby="gedf-drop1">
                                   <a class="dropdown-item" href="#" onclick="location.href='NoticeView.ad?cmd=update&noticeId=${bean.noticeId}';">수정</a>
                                   <a class="dropdown-item" href="#" onclick="location.href='NoticeDelete.ad?noticeId=${bean.noticeId}';">삭제</a>
                               </div>
                           </div>
                       </div>
                   </div>
               </div>
               <div class="card-body text-left">
               	<input type="hidden" value="${bean.noticeId}" id="boardId" name="boardId">
                    <h4 class="card-title">${bean.title}</h4>
                    <hr>
                    <p class="card-text">${bean.content}</p>
               </div>
               <div class="card-footer text-left">
               	<!-- 좋아요 눌렀으면 <i class="fa fa-heart" aria-hidden="true"></i> -->
                   <a href="#" class="card-link"><i class="fa fa-eye" aria-hidden="true"></i> Hit ${bean.hit}</a>
               </div>
           </div>
           <div style="margin: 20px 0; float: right;">
				<input type="button" class="btn btn-primary" value="목록으로" onclick="location.href='NoticeList.ad';">           
           </div>
		</div>
	</section>
</div>
<footer>
  <jsp:include page="../bottom.jsp" />
</footer>

</body>
</html>