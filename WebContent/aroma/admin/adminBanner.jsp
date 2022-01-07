<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	function readURL(obj) {
		console.log("id : " + obj.id)
		var index = (obj.id).substring(13);
		console.log("index: " + index);
		var bannerImg = $("#bannerTr" + index).find('img'); 
		var imgName = $("#bannerTr" + index).find('#fileName');
		//var fileName = $("#bannerTr" + index).find('#fileName'+index);
		
		//console.log("bannerImg_src: " + $(bannerImg).attr("src"));
		console.log("imgName: " + $(imgName).text());
		
 		var reader = new FileReader();
	    reader.onload = function(e) {
	    	$(bannerImg).attr('src', e.target.result);
	    };
	    reader.readAsDataURL(obj.files[0]);
	    $(imgName).text(obj.files[0].name);
	    //fileName.val(obj.files[0].name);
	    
 	}
	
	function deleteBanner(obj) {
		var cnt = $('#bannerTableTbody tr').length;
		
		if(cnt>1){
			$(obj).parent().parent().remove();
		}else{
			alert("배너는 1개 이상 작성하셔야 합니다.");
		}
	}
	
	function addBanner() {
		var count = $('#bannerTableTbody tr').length;
		++count;
		
		var html = "";
		html += "<tr id='bannerTr"+count+"'>";
		html += "<td width='15%' id='fileName' style='vertical-align: middle;'><input type='hidden' id='fileName"+count+"' name='fileName"+count+"'/></td>";
		html += "<td width='40%'>";
		html += "<img src='http://placehold.it/400x200/ffffff/BDBDBD?text=Preview' id='bannerImg' name='bannerImg' width='100%' height='110px' style='border: 1px solid #BDBDBD'>";
		html += "</td>"
		html += "<td width='30%'>"
		html += "<textarea rows='4' id='link"+count+"' name='link"+count+"' style='width: 100%;'></textarea>";
		html += "</td>"
		html += "<td width='15%' style='vertical-align: middle;'>";
		html += "<label class='btn btn-outline-primary btn-sm' for='bannerImgFile"+count+"' style='margin-bottom: 0; margin-right: 5px;'>배너수정</label>";
		html += "<input type='file' id='bannerImgFile"+count+"' name='bannerImgFile"+count+"' style='display: none;' onchange='readURL(this);'/>";
		html += "<input type='button' id='deleteBtn' value='삭제' class='btn btn-outline-primary btn-sm' onclick='deleteBanner(this);'>";
		html += "</td>";
		html += "</tr>";
		
		var lastTr = $('#bannerTableTbody').find("tr:last");
		lastTr.after(html);		
	}
	
	function checked() {
		var count = $('#bannerTableTbody tr').length;
		$("#bannerCount").val(count);
		console.log("배너 개수: " + $("#bannerCount").val());
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
            <a class="nav-link active" href="${contextPath}/AdminBannerSetAction.ad" aria-selected="true">배너 관리</a>
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
       <h3 style="text-align: left">배너관리</h3>
       <p style="text-align: left; margin:15px 0 30px 0;">메인 페이지의 슬라이드 배너 목록입니다.</p>
       
       <form method="post" name="form" enctype="multipart/form-data" action="${contextPath}/AdminBannerUpdateAction.ad" onsubmit="return checked()">
       		<input type="hidden" id="bannerCount" name="bannerCount">
       		<table class="table" style="text-align: center;">
	        	<thead class="thead">
	          		<tr>
		          		<th width="15%">파일이름</th>
		          		<th width="40%">배너 이미지</th>
		          		<th width="30%">링크</th>
		          		<th width="15%">관리</th>
		          		
		          	</tr>
	          	</thead>
	          	<tbody id="bannerTableTbody">
	          		<c:if test="${empty banners}">
	          		<tr id="bannerTr1">
	          			<td width="15%" id="fileName" style="vertical-align: middle;">
	          				<input type="hidden" id="fileName1" name="fileName1" value=""/>
	          			</td>
	          			<td width="40%">
	          				<img src="http://placehold.it/400x200/ffffff/BDBDBD?text=Preview" id="bannerImg" name="bannerImg" width="100%" height="110px" style="border: 1px solid #BDBDBD">
	          			</td>
	          			<td width="30%">
	          				<textarea rows="4" id="link1" name="link1" style="width: 100%;"></textarea>
	          			</td>
	          			<td width="15%" style="vertical-align: middle;">
	          				<label class="btn btn-outline-primary btn-sm" for="bannerImgFile1" style="margin-bottom: 0;">배너수정</label>
							<input type="file" id="bannerImgFile1" name="bannerImgFile1" style="display: none;" onchange="readURL(this);" />
	          				<input type="button" id="deleteBtn" value="삭제" class="btn btn-outline-primary btn-sm" onclick="deleteBanner(this);">
	          			</td>
	          		</tr>
	          		</c:if>
	          		<c:forEach var="banner" items="${banners}" varStatus="status">
	          		<tr id="bannerTr${status.count}">
	          			<td width="15%" id="fileName" style="vertical-align: middle;">
	          				${banner.originalFileName}
	          				<input type="hidden" id="fileName${status.count}" name="fileName${status.count}" value="${banner.originalFileName}"/>
	          				<input type="hidden" id="savedFileName${status.count}" name="savedFileName${status.count}" value="${banner.savedFileName}"/>
	          			</td>
	          			<td width="40%">
	          				<img src="${pageContext.request.contextPath}/bannerUpload/${banner.savedFileName}" id="bannerImg" name="bannerImg" width="100%" height="110px" style="border: 1px solid #BDBDBD">
	          			</td>
	          			<td width="30%">
	          				<textarea rows="4" id="link${status.count}" name="link${status.count}" style="width: 100%;">${banner.link}</textarea>
	          			</td>
	          			<td width="15%" style="vertical-align: middle;">
	          				<label class="btn btn-outline-primary btn-sm" for="bannerImgFile${status.count}" style="margin-bottom: 0; margin-right: 5px;">배너수정</label>
							<input type="file" id="bannerImgFile${status.count}" name="bannerImgFile${status.count}" style="display: none;" onchange="readURL(this);" />
	          				<input type="button" id="deleteBtn" value="삭제" class="btn btn-outline-primary btn-sm" onclick="deleteBanner(this);" >
	          			</td>
	          		</tr>
	          		</c:forEach>
	          	</tbody>
	         </table>
	         <div class="col-md-3">
	         	<input type="button" class="btn btn-primary" value="배너 추가" onclick="addBanner();">
	         	<input type="submit" class="btn btn-primary" value="저장하기 ">
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