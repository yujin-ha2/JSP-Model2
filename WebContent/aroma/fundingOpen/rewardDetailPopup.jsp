<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
  <link rel="stylesheet" href="../vendors/bootstrap/bootstrap.min.css">
   <script src="https://code.jquery.com/jquery-latest.min.js"></script>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
 $(function(){
	$('#aa').change(function(){
	var num = $("#aa option:selected").val()
	$('input[name=test]').attr('value',num);
	var ac = $('input[name=test]').val();
	
});}); 
$(function(){
	$('#aa').change(function(){
		var sss = $('#aa').val();
			      var data = {num : sss}
			   	 $.ajax({
			   		type: 'post',
			        url: 'detailAction.do',
			        contentType: "application/json; charset=utf-8",
			        data: JSON.stringify(data), 
			        dataType: "json"
			     }).done(function(result) {
			    	 $("#info_name").empty();
			    	 var html = "";
			    	$.each(result, function(index, entry){
			    		html += "<div class='form-group'>";
			    		html += "<div class='form-group'>";
			    		html += entry;
			    		html += "</div>";
			    		html += "<input type='text' class='form-control' id='name"+index+"' name='name"+index+"'>";
			    		html += "</div>";
				 	})//done
				 	$("#info_name").append(html);
				 }).fail(function() {
					console.log('fail');
				 });//ajax
			
		});//selectType
	});
	
	function checked(){
	 	
		for(var i = 0; i<13; i++){
		 name[i] += document.getElementById("name[i]");
		 if(name0.value ==""){
			 name0.focus();
			 alert("첫번째 문항 입력하세요");
			return false;
		 }
		 if(name1.value ==""){
			 name1.focus();
			 alert("두번째 문항 입력하세요");
			return false;
		 }
		 if(name2.value ==""){
			 name2.focus();
			 alert("세번째 문항 입력하세요");
			return false;
		 }
		 if(name3.value ==""){
			 name3.focus();
			 alert("네번째 문항 입력하세요");
			return false;
		 }
		 if(name4.value ==""){
			 name4.focus();
			 alert("다섯번째 문항 입력하세요");
			return false;
		 }
		 if(name5.value ==""){
			 name5.focus();
			 alert("여섯번째 문항 입력하세요");
			return false;
		 }
		 if(name6.value ==""){
			 name6.focus();
			 alert("일곱번째 문항 입력하세요");
			return false;
		 }
		 if(name7.value ==""){
			 name7.focus();
			 alert("여덟번째 문항 입력하세요");
			return false;
		 }
		 if(name8.value ==""){
			 name8.focus();
			 alert("아홉번째 문항 입력하세요");
			return false;
		 }
		 if(name9.value ==""){
			 name9.focus();
			 alert("열번째 문항 입력하세요");
			return false;
		 }
		 if(name10.value ==""){
			 name10.focus();
			 alert("열한번째 문항 입력하세요");
			return false;
		 }
		 if(name11.value ==""){
			 name11.focus();
			 alert("열두번째 문항 입력하세요");
			return false;
		 }
		 if(name12.value ==""){
			 name12.focus();
			 alert("열세번째 문항 입력하세요");
			return false;
		 }
		 
		}
		
			return true;
	}

	</script>
</head>
<body>
<div id="dictionary">
	<div class="container">
    	<!-- <div class="col-lg-12"> -->
        	<h2>리워드 정보 제공 공시</h2>
            <p>서포터에게 제공하는 리워드의 종류를 선택하고 해당하는 리워드 정보 제공 고시를 입력하세요</p>
           <form onsubmit="return checked()" action="infoAction.do" method="post">
          	<select id="aa" name="aa">
                     <option value="a">선택</option>
                     <option value="100">가전</option>
                     <option value="200">패션/뷰티</option>
                     <option value="300">베이비</option>
                     <option value="400">푸드</option>
                     <option value="500">취미</option>
                 </select>
                 <div id="info_name">
			  </div>
			  <input type="hidden" name="test" id="test">
			  <div>
			  	<button type="submit">제출하기</button>
			  </div>
			</form>
			         
	</div> 
</div>

</body>
</html>