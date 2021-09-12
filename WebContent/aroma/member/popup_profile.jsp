<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%
    String profile = request.getParameter("profile");
    %>
<!DOCTYPE html>
<html>
<head>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
<style type="text/css">
	#submit{
		width:100px;
    background-color: #3549EC;
    border: none;
    color:#fff;
    padding: 8px 0;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 15px;
    margin: 4px;
    cursor: pointer;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
var profile=null;
function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			document.getElementById('profile').src = e.target.result;
			profile=e.target.result;
			opener.document.getElementById('thumbnail').src= document.getElementById('profile').src;
		};
		reader.readAsDataURL(input.files[0]);
	} else {
		document.getElementById('profile').src = "";
	}
}
function popUpClose(){
	var frm = document.form;
	var path='<c:out value="${contextPath}"/>';
	frm.action= path+"/memberProfileChange.me";
	frm.submit();
	window.close();
}

</script>
<form method="post" name="form" id="frm" enctype="multipart/form-data" action="${contextPath}/memberProfileChange.me">
	<div style="margin: 30px;">
	<div align="center">
		<h2>프로필 변경</h2>
		<c:set var="img" value="${param.profile }"/>
		<c:if test="${img ne ''}">
			<img src="/goodFunding/upload/${param.profile }" style="border-radius: 100px; width: 200px; height: 200px" id="profile">
		</c:if>
		<c:if test="${img eq ''}">
			<img style="border-radius: 100px; width: 200px; height: 200px" id="profile" src="http://placehold.it/500x500/ffffff/3549EC?text=no image" border="1px solid #3549EC">
			<br><br>원하는 사진을 선택해 프로필 사진을 등록하세요.
		</c:if>
	</div>
	
	<div align="center" style="margin-top: 30px">
	<label class="input-file-button" for="input-file" style="color: #3549EC">
  	<b>파일 선택</b>
	</label>
	<!-- <input type="file" id="input-file" style={{display:"none"}}/> -->
		<input type="file" name="file" id="input-file" class="filebox" onchange="readURL(this);" style="display: none;"><br>
		<input style="margin-top: 20px" type="submit" value="설정 완료" id="submit">
	</div>
	</div>
</form>
	
</body>
</html>