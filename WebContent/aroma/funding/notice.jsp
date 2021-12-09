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
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <script type="text/javascript">
  </script>
</head>
<body>
<jsp:include page="../top1.jsp" />
	
<section class="product_description_area">
	<div class="maincontainer" style="padding: 0 150px;">
        <div class="card gedf-card">
           <div class="card-header">
               <div class="d-flex justify-content-between">
                   <div class="d-flex justify-content-between">
                       <div class="text-left" style="color: #000000D6; font-weight: 500;">
                           <div class="h5">${notice.title}</div>
                           <fmt:formatDate var="regdate" value="${notice.regdate}" pattern="yyyy.MM.dd"/>
                           <div class="h7 text-muted">${notice.writerName}&nbsp;${regdate}</div>
                       </div>
                   </div>
               </div>
           </div>
           <div class="card-body text-left">
            <p class="card-text">${notice.content}</p>
           </div>
           <div class="card-footer text-left">
           	<!-- 좋아요 눌렀으면 <i class="fa fa-heart" aria-hidden="true"></i> -->
               <a href="#" class="card-link"><i class="fa fa-eye" aria-hidden="true"></i> Hit ${notice.hit}</a>
           </div>
       </div>
       <div style="margin: 20px 0; float: right;">
			<input type="button" class="btn btn-primary" style="width: 95px; height: 45px;" value="목록으로" onclick="location.href='noticeList.do';">           
       </div>
	</div>
</section>			

<jsp:include page="../bottom.jsp" />

</body>
</html>