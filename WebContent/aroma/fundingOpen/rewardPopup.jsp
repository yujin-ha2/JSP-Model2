<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//Dli HTML 4.01 ulansitional//EN" "http://www.w3.org/ul/html4/loose.dli">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <script src="https://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
li{
	list-style: none;
}

   

</style>
<script type="text/javascript">

 function view_div(val) {
    document.getElementById(val).style.display = 'block';
}
function hidden_div(val1) {
    document.getElementById(val1).style.display = 'none';
} 

function Checked(){
	var r_num = document.getElementById("r_num");
	var r_name = document.getElementById("r_name");
	var r_conf = document.getElementById("r_conf");
	var r_option = document.getElementById("r_option");
	var r_delfee = document.getElementById("r_delfee");
	var r_count = document.getElementById("r_count");
	
	if(r_num.value == ""){
		alert("리워드 금액을 설정하세요!");
		r_num.focus();
		return false;
	}else if(isNaN(r_num.value)){
		alert("목표 금액은 숫자로 입력해주세요.");
		r_num.focus();
		return false;
	}
	if(r_name.value == ""){
		alert("리워드 이름을 설정해주세요!");
		r_name.focus();
		return false;
	}
	if(r_conf.value.length == 0){
		alert("상세 설명을 입력해주세요!");
		r_conf.focus();
		return false;
	}
	if(r_option.value.length == 0){
		alert("옵션 조건을 입력해주세요!");
		r_option.focus();
		return false;
	}
	num = document.all.wr_3.length;
	for(i=0; i<num; i++){
		if(document.all.wr_3[i].checked == true){
			break;
		}
	}
	if(i == num){
		alert("배송조건을 선택해주세요!");
		return false;
	}
	if(r_count.value == ""){
		alert("제한 수량을 입력하세요!");
		r_count.focus();
		return false;
	}else if(isNaN(r_count.value)){
		alert("수량은 숫자로만 입력가능합니다!");
		r_count.focus();
		return false;
	} 
 	if($("#r_deldate option:selected").val() == "1"){
 		alert("날짜를 선택하세요!");
 		r_deldate.focus();
		return false;
	}
 	if($("#r_deldate2 option:selected").val() == "1"){
 		alert("세부 날짜를 선택하세요!");
 		r_deldate2.focus();
		return false;
	}
	return true;
}

/*  function closePop(){
	self.close();
} */


 


</script>
</head>
<body>

	<form action="rewardAction.do" method="post" onsubmit="return Checked()">
			<div>
				<ul >
					<li ><h2>리워드 추가</h2></li>
				</ul>
				<ul>
					<li style="float: left;">금액</li>
					<li><input type="text" name="r_num" id="r_num">원</li>
				</ul>
				<ul>
					<li style="float: left;">리워드명</li>
					<li><input type="text" name="r_name" id="r_name"></li>
				</ul>
				<ul>
					<li style="float: left;">상세 설명</li>
				</ul>
				<div><textarea rows="5" cols="50" name="r_conf" id="r_conf" placeholder="제공하는 리워드가 무엇인지 간략하게 제시해 주세요"></textarea></div>
				<ul>
					<li style="float: left;">옵션 조건</li>
				</ul>
					<div><textarea rows="5" cols="50" name="r_option" id="r_option" placeholder="옵션 값을 입력하세요.					예시: 블랙,230mm 화이트,240mm"></textarea></div>
				<ul>
					<li style="float: left;">배송조건</li>
					<li><input type="radio" name="wr_3" id="wr_3" onclick="view_div('div1');">배송이 필요한 리워드 입니다.</li>
				</ul>
				<ul>
					<li style="float: left;"></li>
					<li><input type="radio" name="wr_3" id="wr_3" onclick="hidden_div('div1');">배송이 필요없는 리워드 입니다.</li>
				</ul>
				<div id="div1" style="display:none" >
					배송료<input type="text" name="r_delfee" id="r_delfee" >원
				</div>
				<ul>
					<li style="float: left;">제한 수량</li>
					<li><input type="text" name="r_count" id="r_count">개</li>
				</ul>
				<ul>
					<li style="float: left;">발송시작일</li>
					<li>				
						<select name="r_deldate" id="r_deldate">
							<option value="1" selected="selected">시스데이터</option>
							<option value="2">시스데이터+1</option>
							<option value="3">시스데이터+2</option>
							<option value="4">시스데이터+3</option>
							<option value="5">시스데이터+4</option>
							<option value="6">시스데이터+5</option>
							<option value="7">시스데이터+6</option>
							<option value="8">시스데이터+7</option>
							<option value="9">시스데이터+8</option>
						</select>
						<select name="r_deldate2" id="r_deldate2">
							<option value="1">시기</option>
							<option value="2">초(1~10일)</option>
							<option value="3">중순(10~20일)</option>
							<option value="4">중순(20~31일)</option>
						</select>
					</li>
				</ul>
				<button type="submit" onclick="closePop">제출하기</button>
		</div>	
	</form>
	
</body>
</html>