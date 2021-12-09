<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>GoodFunding</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
  <script type="text/javascript">
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('profile').src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
		} else {
			document.getElementById('profile').src = "";
		}
	}
	
	function profileSetting() {
		profileForm.submit;
	}
  </script>
  <style type="text/css">
	.settingBtn{
		width:140px;
		height: 50px;
	    background-color: #2196F3;
	    border: 1px solid #2196F3;
	    border-radius: 10px; 
	    color:#fff;
	    text-align: center;
	    text-decoration: none;
	    display: inline-block;
	    font-size: 17px;
	    font-weight: bold;
	    cursor: pointer;
	}
  </style>
</head>
<body>
<form method="post" id="profileForm" name="profileForm" enctype="multipart/form-data" action="${contextPath}/memberProfileChange.me">
	<input type="hidden" id="mType" name="mType" value="${param.mType}">
	<div style="margin: 30px;">
	<div align="center">
		<h3 style="font-size: 23px; line-height: 26px; font-weight: 600; color: #4A4A4A; margin-bottom: 30px;">프로필 사진 변경</h3>
		<c:if test="${!empty param.profile}">
			<img src="${pageContext.request.contextPath}/profileUpload/${param.profile }" id="profile" style="border-radius: 100px; width: 200px; height: 200px">
		</c:if>
		<c:if test="${empty param.profile}">
			<img src="http://placehold.it/500x500/ffffff/3549EC?text=no image" border="1px solid #3549EC" id="profile" style="border-radius: 100px; width: 200px; height: 200px">
			<br><br>원하는 사진을 선택해 프로필 사진을 등록하세요.
		</c:if>
	</div>
	
	<div align="center" style="margin-top: 30px">
		<div>
			<label class="btn btn-outline-primary" for="profileFile" style="height: 40px;">프로필 변경</label>
			<input type="file" style="display: none;" name="profileFile" id="profileFile" onchange="readURL(this);">
		</div>
		<input type="submit" class="settingBtn" value="설정 완료" style="margin-top: 15px" onclick="profileSetting();" >
	</div>
	</div>
</form>
	
</body>
</html>