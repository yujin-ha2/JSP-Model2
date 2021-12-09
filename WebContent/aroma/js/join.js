function checkForm(f) {
	if(f.id.value == ""){
	    document.getElementById('id_ck').innerHTML='아이디는 반드시 입력해야합니다.';
	    f.id.focus();
	    return false;
	  }else{
		  document.getElementById('id_ck').innerHTML='';
	  }
	
	let regExp_pwd = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
	if(f.pwd.value==""){
    	document.getElementById('pwd_ck').innerHTML='비밀번호는 반드시 입력해야합니다.';
    	f.pwd.focus();
    	return false;
	}else if(!regExp_pwd.test(f.pwd.value)){
	  	document.getElementById('pwd_ck').innerHTML='영소문자,특수문자 8~16자리로 입력해야 합니다.';
		f.pwd.focus();
		return false;
	}else{
		document.getElementById('pwd_ck').innerHTML='';
	}
		
	
	if(f.pwd_confirm.value == ""){
	  	document.getElementById('pwd_confirm_ck').innerHTML='비밀번호 확인란은 반드시 입력해야합니다.';
		f.pwd_confirm.focus();
		return false;
	}
	
	if(f.pwd_confirm.value != f.pwd.value ){
	  	document.getElementById('pwd_confirm_ck').innerHTML='비밀번호는 위와 동일해야 합니다.';
		f.pwd_confirm.focus();
		return false;
	}else{
		document.getElementById('pwd_confirm_ck').innerHTML='';
	}
	
	if(f.name.value == ""){
	    document.getElementById('name_ck').innerHTML='이름은 반드시 입력해야합니다.';
	    f.name.focus();
	    return false;
	}else{
		document.getElementById('name_ck').innerHTML='';
	}
	
	if(f.phone.value == ""){
	    document.getElementById('phone_ck').innerHTML='핸드폰번호는 반드시 입력해야합니다.';
	    f.phone.focus();
	    return false;
	}else{
		document.getElementById('phone_ck').innerHTML='';
	}
	
	var regExp_email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	if(f.email.value == ""){
	    document.getElementById('email_ck').innerHTML='이메일은 반드시 입력해야합니다.';
	    f.email.focus();
	    return false;
	}else if(!regExp_email.test(f.email.value)){
		document.getElementById('email_ck').innerHTML='이메일은 형식에 맞지 않습니다.';
		f.email.focus();
	    return false;
	}else{
		document.getElementById('email_ck').innerHTML='';
	}
	
	if($("#id_ck").text() == "이미 존재하는 아이디 입니다."){
		alert("다른 사용자가 사용중인 아이디입니다. 다른 아이디를 입력해주세요.");
		return false;
	}
}


$(function(){
	$("#id").focusout(function(){
		
		var data = {id : $("#id").val()}
		$.ajax({
			type: 'post',
			url: 'IdCheck.me',
			data: JSON.stringify(data),
			contentType: "application/json; charset=utf-8",
			dataType: "json"
		}).done(function(result) {
			$("#id_ck").text(result);
		}).fail(function() {
			console.log("fail");
		});
	});
	
});




