//숫자만 입력 받게끔 하는 함수.
function handlerNum( obj ) {
  e = window.event; //윈도우의 event를 잡는것입니다.
 
  //입력 허용 키
  if( ( e.keyCode >=  48 && e.keyCode <=  57 ) ||   //숫자열 0 ~ 9 : 48 ~ 57
      ( e.keyCode >=  96 && e.keyCode <= 105 ) ||   //키패드 0 ~ 9 : 96 ~ 105
        e.keyCode ==   8 ||    //BackSpace
        e.keyCode ==  46 ||    //Delete
        //e.keyCode == 110 ||    //소수점(.) : 문자키배열
        //e.keyCode == 190 ||    //소수점(.) : 키패드
        e.keyCode ==  37 ||    //좌 화살표
        e.keyCode ==  39 ||    //우 화살표
        e.keyCode ==  35 ||    //End 키
        e.keyCode ==  36 ||    //Home 키
        e.keyCode ==   9       //Tab 키
    ) {
 
    if(e.keyCode == 48 || e.keyCode == 96) { //0을 눌렀을경우
      if ( obj.value == "" || obj.value == '0' ) //아무것도 없거나 현재 값이 0일 경우에서 0을 눌렀을경우
        e.returnValue=false; //-->입력되지않는다.
      else //다른숫자뒤에오는 0은
        return; //-->입력시킨다.
      }

    else //0이 아닌숫자
      return; //-->입력시킨다.
    }
    else //숫자가 아니면 넣을수 없다.
 {
  e.returnValue=false;
 }
}


//우편번호, 결제정보, 약관동의 유효성체크
function CheckForm(){
	 var postCode = $("#postCode").val();
	 var detailAddress = $("#detailAddress").val();
	 var cardNumber1 =$("input[id = 'card_number1']");
	 var cardNumber2 =$("input[id = 'card_number2']");
	 var cardNumber3 =$("input[id = 'card_number3']");
	 var cardNumber4 =$("input[id = 'card_number4']");
     var validity = $("input[id = 'card_validity']"); 
	 var password = $("input[id = 'card_password']");
	 var birthday = $("input[id = 'birthday']");
     
	 if(postCode == ""){
		 alert("우편번호를 입력하세요");
		 return false;
	 }
	 
	 if(detailAddress == ""){
		 alert("상세주소를 입력하세요");
		 return false;
	 }
	 
	 if(cn1.val()=="" || cn2.val()=="" || cn3.val()=="" || cn4.val()==""){
		 alert("카드번호를 입력하세요");
		 return false;
	 }
	 
	 if(cv.val()==""){
		 alert("카드 유효기간을 입력하세요");
		 return false;
	 }
	 
	 if(cp.val()==""){
		 alert("카드 비밀번호를 입력하세요");
		 return false;
	 }
	 
	 if(bd.val()==""){
		 alert("생년월일 6자리를 입력하세요");
		 return false;
	 }
	 
	 if(!checkAgree()){
		 alert("약관에 모두 동의 하셔야 합니다.");
		 return false;
	 }
}

function checkAgree() {
	if($('input:radio[id="check_1"]').is(':checked') || $('input:radio[id="check_2"]').is(':checked')){
		return false;
	}
	return true;
}


//다음 우편번호 api
function daumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                //document.getElementById("sample6_extraAddress").value = extraAddr;
                addr += ' ';
                addr += extraAddr;
            
            } //else {
                //document.getElementById("sample6_extraAddress").value = '';
            //}

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}

