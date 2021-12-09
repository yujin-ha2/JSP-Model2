<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>  
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
  <script type="text/javascript" src="${contextPath}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
  
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
 	<section class="order_details section-margin--small">
    	<div class="container">
         	<h3 style="text-align: left">공지사항 관리</h3>
         	<p style="text-align: left; margin-top: 15px">공지사항을 관리하는 곳입니다.</p>
			<form action="./NoticeUpdate.ad" method="post" onsubmit="return checked()">
			<input type="hidden" id="noticeId" name="noticeId" value="${bean.noticeId}">
				<table class="table table-hover " style="text-align: center; border: 1px solid #dddddd">
					<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="title" id="title" maxlength="50" value="${bean.title}"></td>
					</tr>
					<tr>
						<td>
							<textarea class="form-control" name="content" id="content" rows="10" cols="100" maxlength="2048" style="height:412px; display: none;">
								${bean.content}
							</textarea>
						</td>
					</tr>
					</tbody>
				</table>
				<div align="center">
					<!-- 글쓰기 버튼 생성 -->
					<input type="button" class="btn btn-primary pull-right" value="수정" onclick="submitContents(this);">
					<input type="button" class="btn btn-primary pull-right" value="취소" onclick="location.href='NoticeView.ad?cmd=view&noticeId=${bean.noticeId}';">
				</div>
			</form>
		</div>
	</section>


  <jsp:include page="../bottom.jsp" />
  
  <script type="text/javascript">
	var oEditors = [];
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		sSkinURI: "/GoodFunding/aroma/editor/SmartEditor2Skin.html",	
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	function submitContents(elClickedObj) {
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		var title = $("#title").val();
		if(title === '<p>&bnsp;</p>' || title === ''){ 
			alert("제목을 입력하세요");
			return false;
		}else{
			elClickedObj.form.submit();
		}
	}
	</script>
</body>
</html>