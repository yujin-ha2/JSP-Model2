/**
 * 
 */

/*$(function (){
	//전체선택 체크박스 클릭 
	$("#allCheck").click(function() {
		console.log('click');
		//만약 전체 선택 체크박스가 체크된상태일경우 
		if ($("#allCheck").prop("checked")) {
			console.log('체크된 상태');
			//해당화면에 전체 checkbox들을 체크해준다 
			$("input[id=check_1]").prop("checked", true);
			$("input[id=check_2]").prop("checked", true);
			// 전체선택 체크박스가 해제된 경우 
		} else {
			//해당화면에 모든 checkbox들의 체크를해제시킨다. 
			$("input[id=check_1]").prop("checked", false);
			$("input[id=check_2]").prop("checked", false);
		}
				
	})
});*/

/* 약관 동의 체크박스 시작 */
function allCheckFunc( obj ) {
		$("[name=checkOne]").prop("checked", $(obj).prop("checked")); 	
}

/* 체크박스 체크시 전체선택 체크 여부 */
function oneCheckFunc( obj )
{
	var allObj = $("[name=checkAll]");
	var objName = $(obj).attr("name");

	if( $(obj).prop("checked") )
	{
		checkBoxLength = $("[name="+ objName +"]").length;
		checkedLength = $("[name="+ objName +"]:checked").length;

		if( checkBoxLength == checkedLength ) {
						
			allObj.prop("checked", true);
			
			if($("input[id=check]").prop("checked", false)){
				alert("필수 체크 항목도 체크해주세요");
				return false;
			}else {
				return true;
			}
						
		} else {
			allObj.prop("checked", false);
		}
	}
	else
	{
		allObj.prop("checked", false);
	}
}

$(function(){
	$("[name=checkAll]").click(function(){
		allCheckFunc( this );
		alert("모든 체크박스가 체크 되었습니다.");
	});
	$("[name=checkOne]").each(function(){
		$(this).click(function(){
			oneCheckFunc( $(this) );
		});
	});
});
/* 약관 동의 체크박스 끝 */

/* 필수 선택항목 체크 확인 시작 */
/*$(allObj).click(function() {
	var checked = $(allObj).is(':checked');
	
	if(checked){				
		if($("input[id=check]").prop("checked", false)){
			alert("필수 체크 항목도 체크해주세요");
			return false;
		}else {
			return true;
		}
	}
});
*/
/* 필수 선택항목 체크 확인 끝 */

/* 다음 우편주소 API 부분 스크립트 시작 */
function sample6_execDaumPostcode() {
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
                document.getElementById("sample6_detailAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_detailAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}
/* 다음 우편주소 API 부분 스크립트 끝 */

/* 윈도우 창 크기 조절 고정 부분 시작 */
function window_resize(){
	//&nbsp;만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	var popupX = (document.body.offsetWidth/2)-(570/2);
//	var popupX = Math.ceil((window.screen.width - 570)/2);
	//&nbsp;만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	var popupY = (window.screen.height/2)-(730/2);
//	var popupY = Math.ceil((window.screen.height - 70)/2);
	
    window.open('popup_check.jsp', '_blank', 'width=570, height=730, resizable=no, left='+ popupX +', top='+ popupY);
	
}
/* 윈도우 창 크기 조절 고정 부분 끝 */

//배열로 받은 성별과 취미의 선택 여부를 확인하는 메서드
// 동의 모두선택 / 해제
/*function CheckValue() {
	// 동의 모두선택 / 해제
	const agreeChkAll = document.querySelector('input[name=agree_all]');
	    agreeChkAll.addEventListener('change', (e) => {
	    let agreeChk = document.querySelectorAll('input[name=agree]');
	    for(let i = 0; i < agreeChk.length; i++){
	      agreeChk[i].checked = e.target.checked;
	    }
	});
}*/
	

/* 예약 결제 유효성 체크 시작 */
function CheckForm(){
	 console.log('dddd');
	 var cn1 =$("input[name = 'card_number1']");
	 var cn2 =$("input[name = 'card_number2']");
	 var cn3 =$("input[name = 'card_number3']");
	 var cn4 =$("input[name = 'card_number4']");
     var cv = $("input[id = 'card_validity']"); 
	 var cp = $("input[id = 'card_password']");
	 var bd = $("input[id = 'birthday']");
     var sc = $("input[name = 'select']");
     
	 //카드번호를 입력하지 않았을 경우(regExp)
	 //카드 유효기간을 입력하지 않았을 경우(regExp(4자리여서 같이 사용))	 
	 //생년월일 앞 6자지 입력하지 않았을 경우(일반인인 경우나 생년월일로 입력하고 싶어하는 메이커)
	 var regExp = RegExp(/^[0-9]{4}$/);
	 var cpExp = RegExp(/^[0-9]{2}$/); //카드비밀번호를 입력하지 않았을 경우(regExp2)
	 var bdExp1 = RegExp(/^[0-9]{6}$/);	
	 if(cn1.val()=="" || cn2.val()=="" || cn3.val()=="" || cn4.val()==""){
		 alert("카드번호를 입력하세요");
		 return false;
	 }
	 
	 if(!regExp.test(cn1.val()) || !regExp.test(cn2.val()) || !regExp.test(cn3.val()) || !regExp.test(cn4.val()) ){
		 alert("카드번호는 4자리 숫자입니다");	 
		 return false;
	 }
	 
	 if(cv.val()==""){
		 alert("카드 유효기간을 입력하세요");
		 return false;
	 }else if(!regExp.test(cv.val())){
		 alert("카드 유효기간은 월/년 입니다");
		 return false;
	 }
	 
	 if(cp.val()==""){
		 alert("카드 비밀번호를 입력하세요");
		 return false;
	 }else if(!cpExp.test(cp.val())){
		 alert("카드 비밀번호 앞 2자리를 입력하세요");
		 return false;	 
	 }
	 
	 if(bd.val()==""){
		 alert("생년월일이나 사업자 등록번호를 입력하세요");
		 return false;
	 }else if(!bdExp1.test(bd.val())){
		 alert("생년월일 앞 6자리를 입력하세요 ");
		 return false;	 
	 }
	 
	 if(!allCheckFunc(allObj)){
		 alert("약관에 모두 동의 하셔야 합니다.");
		 return false;
	 }
	 
	return false;	
}
/* 예약 결제 유효성 체크 끝 */
