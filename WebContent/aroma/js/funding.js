var index = 0;
var UsingOption = false;

$(document).ready(function() {
	$("#productSelect").change(function(){
		//이미 선택한 옵션인지 아닌지 판단
		var selectedOption = $("#productSelect option:selected").val();
		var data = {rewardId : selectedOption};
		
		optionCheck(selectedOption);
 		if(UsingOption == false){
  			//ajax처리 (rewardId를 통해 리워드 정보 가져오기)
  			$.ajax({
  				type: 'post',
  				url: 'getRewardInfo.do',
  				data: JSON.stringify(data),
  				contentType: "application/json; charset=utf-8",
  				dataType: "json"
  			}).done(function(result) {
  				change(result);
  			}).fail(function() {
  				alert("펀딩 옵션 선택에 실패하였습니다.");
  				//console.log("fail");
  			});
  		}
	}); 
});


function change(reward) {
	++index;
	var UlLength = $("#productsToBuy ul").length;
	var LiName = "optionLi" +index;
	
	var html = "";
	html += (UlLength == 0) ? "<ul id='productToBuyUL' style='border-top: 1px solid #c7c7c7; border-bottom: 1px solid #c7c7c7;'>" : "";
	html += "<li id='optionLi"+index+"' style='padding:15px 14px 15px 0; border-top: 1px solid rgba(0, 0, 0, 0.05);'>";
	html += "<input type='hidden' id='rewardId' name='rewardId' value='"+reward.rewardId+"'>";
	html += "<div>";
	html += "<div style='margin-bottom: 15px;'>";
	html += "<p style='margin-bottom: 0; color: #4a4a4a; font-weight: 500;'>"+reward.rewardOption+"</p>";
	html += "<p style='margin-bottom: 5px;; font-size: 12px; line-height: 19px; color: #929292;'>"+reward.rewardDetail+"</p>";
	html += "<div>";
	html += "<span style='width: 100%; margin-bottom: 5px; float: left; font-size: 12px; line-height: 22px; color:#9b9b9b;'>";
	html += "배송비 <em style='display: block; font-style: normal; font-size: 14px; color: #4a4a4a'>"+reward.deliveryFee+"</em>";
	html += "</span>";
	html += "<span style='width: 100%; margin-bottom: 5px; float: left; font-size: 12px; line-height: 22px; color:#9b9b9b;'>";
	html += "리워드 발송 시작일 <em style='display: block; font-style: normal; font-size: 14px; color: #4a4a4a'>"+reward.deliveryDate+"</em>";
	html += "</span>";
	html += "</div>";
	html += "<p style='font-size: 12px; line-height: 21px; color: #6b90dc;'>";
	html += "제한수량 <strong>"+reward.salesQuantity+"</strong>개 &nbsp; <em style='padding: 2px 6px; font-style: normal; font-weight: 500; background-color: #E7F9F9;'>현재 "+reward.remainingQuantity+"개 남음!</em>";
	html += "</p>";
	html += "</div>";
	html += "<div style='display: block; height: 35px; padding: 3px 0;'>";
	html += "<div style='float: left; border: solid 1px #dde0e3;  position: relative;'>";
	html += "<input type='button' style='width: 34px; height: 100%; background-color: #f1f2f4; margin-right: -4px; border: none; cursor:pointer;' onclick='minusProduct("+LiName+", "+reward.price+");' value='-'>";
	html += "<input type='number' min='0' max='100' value='1' id='productNumber' name='productNumber' style='border: none; width: 44px; text-align: center;'>";
	html += "<input type='button' style='width: 34px; height: 100%; background-color: #f1f2f4; margin-left: -3px; border: none; cursor:pointer;' onclick='addProduct("+LiName+", "+reward.price+");' value='+'>";
	html += "</div>";
	html += "<span style='float: right; margin: 0 0 4px 0; font-size: 13px; color: #222222'>";
	html += "<span id='productPrice' style='display: inline-block; vertical-align: middle; font-size: 15px;  font-weight: bold; margin-top: -5px;'>"+reward.price+"</span>원";
	html += "<button style='margin-left: 7px; border: none; background-color: white; font-size: 17px;' onclick='excludeProduct(optionLi"+index+");'>Ｘ</button>";
	html += "</span>";
	html += "</div>";
	html += "</div>";
	html += "</li>";
	html += (UlLength == 0) ? "</ul>" : "";

	//옵션 기본(상품선택)으로 변경 추가
	$("#productSelect option:eq(0)").prop("selected", true); //첫번째 option 선택
	
	//리워드 정보 띄우기
	if(UlLength == 0){
		$("#productsToBuy").append(html); 
		
		var html2 = "";
		html2 += "<div id='totalAmount' style='margin-top: 26px; font-size: 14px; line-height: 23px;'>";
		html2 += "<strong>총 상품 금액</strong>";
		html2 += "<div style='float: right;'>";
		html2 += "<span style='padding-right: 18px; color: #999999;'>총 수량 <strong id='totalCount'>1</strong>개 </span>";
		html2 += "<strong style='font-size: 18px; line-height: 20px; color: #6b90dc;'>";
		html2 += "<span id='totalPrice' style='font-size: 24px; font-weight: bold;'>"+reward.price+"</span>원";
		html2 += "</strong>";
		html2 += "</div>";
		html2 += "</div>";
		$("#productsToBuy").after(html2);
		
	}else{
		$("#productToBuyUL li").last().after(html); 
		changeProductToBuy();
	}
}	


function optionCheck(selectedOption) {
	UsingOption = false;
	var UlCount = parseInt($("#productsToBuy ul").length);
	if( UlCount > 0){
		$("#productToBuyUL li").each(function(index, item){
  			if($(this).find("#rewardId").val() == selectedOption){
  				alert("이미 선택한 옵션입니다.");
  	  			$("#productSelect option:eq(0)").prop("selected", true); //옵션 기본(상품선택)으로 변경 
  				UsingOption = true;
  			}	
  		});
	}
	//alert("UsingOption: " + UsingOption);
}

function addProduct(LiName, defaultPrice) {
	//LiName 찾기
	var name = LiName.id;
	
	//input type=number value 증가 
	var productNumber = $("#"+name).find("input[id='productNumber']");
	var addNumber = parseInt(productNumber.val()) + 1;
	//console.log("[더하기] currentValue: " + productNumber.val() + ", addNumber: " + addNumber);
	productNumber.val(addNumber); 
	
	// 옵션의 가격을  '가격*개수'로 변경
	var productPrice = $("#"+name).find("span[id='productPrice']");
	var newPrice = addNumber * parseInt(defaultPrice);
	//console.log("[더하기] currentPrice: " + productPrice.text() + ", newPrice: " + newPrice)
	var newPriceText = String(newPrice).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	productPrice.text(newPriceText);
	
	changeProductToBuy();
}

function minusProduct(LiName, defaultPrice) {
	var name = LiName.id;
	//input type=number value 증가 
	var productNumber = $("#"+name).find("input[id='productNumber']");
	var addNumber = parseInt(productNumber.val()) - 1;
	if(addNumber > 0){
		console.log("[빼기] currentValue: " + productNumber.val() + ", addNumber: " + addNumber);
		productNumber.val(addNumber); 
		
		// 옵션의 가격을  '가격*개수'로 변경
		var productPrice = $("#"+name).find("span[id='productPrice']");
		var newPrice = addNumber * parseInt(defaultPrice);
		console.log("[빼기] currentPrice: " + productPrice.text() + ", newPrice: " + newPrice);
		var newPriceText = String(newPrice).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		productPrice.text(newPriceText);
		
		changeProductToBuy();
		
	}else{
		alert("1개 이상부터 펀딩하실 수 있습니다.");			
	}
}

function excludeProduct(LiName) {
	var name = LiName.id;
	var LiLength = $("#productToBuyUL li").length;
	
	if(LiLength == 1){
		//div empty
		$("#productsToBuy").empty();
		$("#totalAmount").remove();
	}else if(LiLength > 1){
		//해당 <li>만 삭제
		$("#"+name).remove();
		changeProductToBuy();
	}
}

function changeProductToBuy() {
	//총 개수, 총 가격 수정
	var totalCount = 0;
	var totalPrice = 0;
	$("#productsToBuy li").each(function(index, item){
		totalCount += parseInt($(this).find("#productNumber").val());
		var currentPrice = $(this).find("#productPrice").text().replace(/[^\d]+/g, '');
		//console.log("currentPrice: " + currentPrice);
		totalPrice += parseInt(currentPrice);
	});
	var price = String(totalPrice).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	//console.log("price: " + price);
	$("#totalCount").text(totalCount);
	$("#totalPrice").text(price);
}

function checked() {
	//옵션이 있는지 없는지 체크
	var LiLength = $("#productToBuyUL li").length;
	if(LiLength == 0){
		alert("옵션을 추가해주세요");
		return false;			
	}
}

