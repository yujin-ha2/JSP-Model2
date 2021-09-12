<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script type="text/javascript">
 $(function(){
	$('#click1').click(function(){
		var input = document.getElementById("file1");
			    var reader = new FileReader();
			    reader.onload = function(e) {
			      document.getElementById('banner').src = e.target.result;
			    };
			    reader.readAsDataURL(input.files[0]);
			  
	}); 
	$('#click2').click(function(){
		var input = document.getElementById("file2");
			    var reader = new FileReader();
			    reader.onload = function(e) {
			      document.getElementById('banner').src = e.target.result;
			    };
			    reader.readAsDataURL(input.files[0]);
			  
	});
	$('#click3').click(function(){
		var input = document.getElementById("file3");
			    var reader = new FileReader();
			    reader.onload = function(e) {
			      document.getElementById('banner').src = e.target.result;
			    };
			    reader.readAsDataURL(input.files[0]);
			  
	});
	$('#click4').click(function(){
		var input = document.getElementById("file4");
			    var reader = new FileReader();
			    reader.onload = function(e) {
			      document.getElementById('banner').src = e.target.result;
			    };
			    reader.readAsDataURL(input.files[0]);
			  
	});
}); 
</script>
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
	<!-- ================ start banner area ================= -->	
	<!-- ================ end banner area ================= -->


	<!--================Product Description Area =================-->
 
  <ul class="nav nav-tabs" id="myTab" role="tablist" style="background-color: #3549EC;">
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/AdminApproveListAction.ad" aria-selected="false">승인관리</a>
        </li>
        <li class="nav-item">
            <a class="nav-link active" onclick="location.href='${contextPath}/AdminMemberGeneralListAction.ad'" aria-selected="false">회원관리</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${contextPath}/AdminBannerSetAction.ad" aria-selected="true">배너관리</a>
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
  <!--================Order Details Area =================-->
  <section class="order_details section-margin--small">
    <div class="container">
                        <table style="text-align: center; width: 100%">
                                <td width="200px"  style="border-right: 1px solid lightgray;">
                                <img src="./img/r10.jpg" style="border-radius: 100px"/> <br/>
                                <p style="margin: 10px">관리자님 <br/> 안녕하세요</p>
                                 <a class="button button-header" href="${contextPath}/MemberLogout.me">로그아웃</a>
                                </td>
    <form method="post" name="form" enctype="multipart/form-data" action="${contextPath}/AdminBannerUpdateAction.ad">
      <td width="1000px" align="center" style="padding-left: 30px">
            <h3 style="text-align: left">배너관리</h3>
            <p style="text-align: left; margin-top: 15px">메인 페이지의 슬라이드 배너 목록입니다.</p>
            <img src="http://placehold.it/400x200/ffffff/BDBDBD?text=Preview" width="500px" height="170px" style="border: 1px solid #BDBDBD" id="banner">
            <br>
             <div class="single-search-product d-flex">
             
          <table class="table">
          <thead class="thead">
          	<tr>
          		<th scope="col">순서</th>
          		<th scope="col">배너 URL</th>
          		<th scope="col">이미지명</th>
          		<th scope="col">관리</th>
          	</tr>
          	</thead>
          	<tbody>
          		<c:set var="v" value="${v}"/>
          		<tr>
          			<td>${v[0].bannerId }</td>
          			<td><input type="text" size="55" value="${v[0].link }" name="link1">  </td>
          			<td>${v[0].img } </td>
          			<td><input type="button" id="click1" value="미리보기">&nbsp;&nbsp;<input type="file" name="file1" id="file1" onchange="readURL(this);" ></td>
          			
          		</tr>
          		<tr>
          			<td>${v[1].bannerId }</td>
          			<td><input type="text" size="55" value="${v[1].link }" name="link2"></td>
          			<td>${v[1].img } </td>
          			<td><input type="button" id="click2" value="미리보기">&nbsp;&nbsp;<input type="file" name="file2" id="file2"></td>
          		</tr>
          		<tr>
          			<td>${v[2].bannerId }</td>
          			<td><input type="text" size="55" value="${v[2].link }" name="link3"></td>
          			<td>${v[2].img } </td>
          			<td><input type="button" id="click3" value="미리보기">&nbsp;&nbsp;<input type="file" name="file3" id="file3"></td>
          		</tr>
          		<tr>
          			<td>${v[3].bannerId }</td>
          			<td><input type="text" size="55" value="${v[3].link }" name="link4"></td>
          			<td>${v[3].img } </td>
          			<td><input type="button" id="click4" value="미리보기">&nbsp;&nbsp;<input type="file" name="file4" id="file4"></td>
          		</tr>
          		
          	</tbody>
          </table>
          </div>
          			<p style="text-align: left; color: #FF7E7E">1번 배너부터 우선 노출됩니다.</p>
          			<button type="submit">저장</button>
					
      </td>
      </form>
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