<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>메이커 스튜디오</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
    <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/ionicons/dist/css/ionicons.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/css/vendor.bundle.addons.css">
    <link rel="stylesheet" href="${contextPath}/assets/css/shared/style.css">
    <link rel="stylesheet" href="${contextPath}/assets/css/demo_1/style.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript" src="${contextPath}/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
    <script type="text/javascript">
    $(document).ready(function(){ 
    	
    	var category = document.getElementById("category"); 
    	
    	for(var i=0; i<category.length; i++){ 
    		if(category[i].value == "${bean.categoryId}"){ 
    			category[i].selected = true; 
  			} 
  		}
    });

    </script>
     <style type="text/css">
	.input-file-button{
	  background-color:#2196F3;
	  border-radius: 4px;
	  color: white;
	  cursor: pointer;
	  height: 40px;
	}
	
	.saveBtn{
	  color: #fff; 
	  background-color: #2196F3; 
	  width: 100%; 
	  height: 40px; 
	  border: 0; 
	  border-radius: 5px;
	}
    </style>
</head>
<body>
    <div class="container-scroller">
      <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-top justify-content-center" style="padding-top: 20px;">
          <a class="navbar-brand brand-logo" href="${contextPath}/makerStudioMain.on?fundingId=${fundingId}">makerStudio</a>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-center">
           <ul class="navbar-nav mr-auto">
            <li class="nav-item">
	           	<div class="profile-image">
	              <span style="padding-top: auto;">${sessionScope.id}님의 프로젝트 번호는 ${fundingId}</span>
	            </div>
            </li>
            </ul>
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <c:set var="exit" value="location.href='myprojectList.on'"/>
              <c:if test="${sessionScope.authority eq '관리자'}">
              	<c:set var="exit" value="location.href='AdminApproveListAction.ad'"/>
              </c:if>
              <button type="button" class="btn btn-outline-primary btn-rounded btn-fw" onclick="${exit}">나가기</button>
            </li>
          </ul>
        </div>
      </nav>
      <div class="container-fluid page-body-wrapper">
        <jsp:include page="nav.jsp">
        <jsp:param name="fundingId" value="${fundingId}"/> 
        </jsp:include>
        
        <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper">
            <div class="row">
              <div class="col-12 grid-margin">
                <div class="card">
                  <div class="card-body" style="padding: 40px;">
                  	<div>
                    <h4 class="card-title" style="font-size: 36px; font-weight: 700; margin-bottom: 10px;">기본 정보</h4>
                    <p style="font-size: 16px; margin-bottom: 32px; line-height: 1.41;">
                    	프로젝트를 대표할 주요 기본 정보 및 메이커님의 프로젝트를 입력하세요. 스토리에는 메이커님의 진심이 잘 녹여질 수 있도록 명확하고, 솔직하게 작성하세요.
                    </p>
                    </div>
                    <form class="forms-sample" action="./BasicInfoUpdateForm.on" method="post" >
                    <input type="hidden" name="fundingId" value="${fundingId}">
                      <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;">
                            	프로젝트 제목
                            </p>
                            <input type="text" class="form-control" name="title" id="title" value="${bean.title}" readonly="readonly">
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;	">
                            	목표 금액
                            </p>                            
                            <div>
                            	<p style="font-size: 13px; color: #90949c;">- 최소 50만 원 ~ 최대 1억 원으로 설정하세요.</p>
                            </div>
                            <div>
                            	<fmt:formatNumber var="target" value="${bean.salesTarget}" pattern="#,###"/>
								<input type="text" class="form-control" style="display: inline-block; width: 95%" name="salesTarget" id="salesTarget" value="${target}" readonly="readonly">
                            	<span style="padding-left: 10px;">원</span>                            
                            </div>
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;	">
                            	프로젝트 일정	
                            </p>                            
                            <div>
                            	<c:set var="sdate"><fmt:formatDate value="${bean.startdate}" pattern="yyyy-MM-dd"/></c:set>
                            	<c:set var="edate"><fmt:formatDate value="${bean.enddate}" pattern="yyyy-MM-dd"/></c:set>
								<input type="text" class="form-control" style="display: inline-block; width: 30%" name="startdate" id="startdate" value="${sdate}" readonly="readonly"> -
								<input type="text" class="form-control" style="display: inline-block; width: 30%" name="enddate" id="enddate" value="${edate}" readonly="readonly">
                            </div>
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;">
                            	카테고리
                            </p>
                            <div>
                            	<select class="form-control form-control-lg" name="category" id="category" readonly 
                            	        onFocus='this.initialSelect = this.selectedIndex;' onChange='this.selectedIndex = this.initialSelect;' >
                            		<option value="선택">선택</option>
                            		<option value="100">전자제품</option>
                            		<option value="200">패션</option>
                            		<option value="300">영유아</option>
                            		<option value="400">식품</option>
                            		<option value="500">뷰티</option>
                            	</select>
                            </div>
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;">
                            	대표 이미지
                            </p>
                            <div>
                            <label class="input-file-button col-md-2" for="input-file" style="text-align:center; font-size: 17px; line-height: 2.4;">업로드</label>
							<input type="file" id="input-file" style="display: none;" disabled="disabled"/>
							</div>
							<input type="hidden" name="mainImg" id="mainImg" value="${bean.mainImg}">
							<span style="color: blue; font-size: 14px;">${bean.mainImg}</span>
                            <div style="padding-top: 10px;">
                            	<p style="font-size: 13px; color: #90949c;">
                            		3MB 이하의 JPEG, PNG 파일<br>
									해상도 1200x675 픽셀 이상<br>
									텍스트 및 로고 삽입 금지<br>
								</p>
                            </div> 
                          </div>
                        </div>
                        </div>
                         <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;">
                            	소개 사진 등록
                            </p>
							<div>
                            <label class="input-file-button col-md-2" for="input-file" style="text-align:center; font-size: 17px; line-height: 2.4;">업로드</label>
							<input type="file" id="input-file" style="display: none;"  disabled="disabled"/>
							</div>
							<input type="hidden" name="storyImg" id="storyImg" value="${bean.storyMainImg}">
							<span style="color: blue; font-size: 14px;" >${bean.storyMainImg}</span>
                            <div style="padding-top: 10px;">
                            	<p style="font-size: 13px; color: #90949c;">
									2MB 이하의 JPEG, JPG, GIF, PNG 파일<br>
									사이즈 : 최소 630X400 픽셀 이상<br>
								</p>
                            </div>
                          </div>
                        </div>
                        </div>
                        <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;	">
                            	프로젝트 요약
                            </p>                            
                            <div>
                            	<p style="font-size: 13px; color: #90949c;">- 프로젝트 페이지 상단 및 지지서명 시 노출됩니다.</p>
                            </div>
                            <textarea rows="2" cols="" class="form-control" placeholder="내용 입력" name="summary" id="summary" readonly="readonly">${bean.storySummary}</textarea>
                          </div>
                        </div>
                        </div>
                         <div class="row" style="margin-bottom: 20px;">
                        <div class="col-md-7">
                          <div class="form-group">
                            <p class="col-form-label" style="font-size: 16px; font-weight: 400;">		
                            	프로젝트 스토리
                            </p>
                             <div>
                            	<p style="font-size: 13px; color: #90949c;">- 진정성있고 매력적인 스토리를 작성해보세요.</p>
                            </div>
                            <textarea class="form-control" name="story"  id="story" rows="10" cols="100"  style="height:412px; width: 100%;" readonly="readonly">${bean.storyContent}</textarea>
                          </div>
                        </div>
                        </div>
                        <c:set var="mode" value="${mode}"/>
                        <c:if test="${mode eq 'update'}">
	                    <div class="col-md-3" style="padding-left: 0;">
	                    	<button class="saveBtn">수정 페이지로 이동</button>
	                    </div>
	                    </c:if>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="${contextPath}/assets/vendors/js/vendor.bundle.base.js"></script>
    <script src="${contextPath}/assets/vendors/js/vendor.bundle.addons.js"></script>
    <script src="${contextPath}/assets/js/shared/off-canvas.js"></script>
    <script src="${contextPath}/assets/js/demo_1/dashboard.js"></script>
    <script type="text/javascript">
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "story", //textarea에서 지정한 id와 일치해야 합니다. 
        sSkinURI: "${contextPath}/editor/SmartEditor2Skin.html", //SmartEditor2Skin.html 파일이 존재하는 경로  
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,             
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,     
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,         
            fOnBeforeUnload : function(){
                 
            }
        }, 
        fOnAppLoad : function(){
            //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용

        },
        fCreator: "createSEditor2"
    });
    </script>
</body>
</html>