<%@page import="net.funding.open.db.RewardBean"%>
<%@page import="net.funding.open.db.MakerBean"%>
<%@page import="java.util.List"%>
<%@page import="net.funding.open.db.ReportJoin"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="net.funding.open.db.JoinFunding"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"	 %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop - Product Details</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <link rel="icon" href="${contextPath}/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="${contextPath}/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="${contextPath}/vendors/nouislider/nouislider.min.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <script src="https://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
.maincontainer {
   margin: 0 auto;
    padding: 0 80px;
    width: 100%;
    max-width: 1440px;
   /* border-bottom: 1px solid #f0f2f5; */        
}
</style>
</head>
<script type="text/javascript">
$(function(){
	$('#aa').change(function(){
	var num = $("#aa option:selected").val()
	$('input[name=rewardId]').attr('value',num);
	var ac = $('input[name=rewardId]').val();
	
	});
}); 

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
			    	 console.log(result);
			    	 $("#ajaxName").empty();
			    	 $("#ajaxOption").empty();
			    	 
			    	 var rewardOption = result.rewardOption;
			    	 var name = result.rewardDetail;
			    	console.log(name);
			    	console.log(rewardOption);
			    	
			    	$("#ajaxName").append("* 제품명 :"+name);
				 	$("#ajaxOption").append("* 옵션명 : "+rewardOption);
				 
				 	
				 }).fail(function() {
					console.log('fail');
				 });//ajax
			
		});//selectType
	});
	
function CheckForm(){
	var salesQuantity = document.getElementById("salesQuantity");
	var aa = document.getElementById("aa");
	
	if(aa.value == 0){
		alert("리워드 옵션을 선택해 주세요!");
		aa.focus();
		return false;
	}
	if(salesQuantity.value == ""){
		alert("옵션 개수를 입력하세요!");
		salesQuantity.focus();
		return false;
	
	}else if(isNaN(salesQuantity.value)){
		alert("옵션 개수는 숫자로만 입력가능합니다!");
		salesQuantity.focus();
		return false;
	}
	
 	
	return true;
}

</script>
<body>
<%

ReportJoin ab = (ReportJoin)request.getAttribute("report");
List<ReportJoin> list = (List<ReportJoin>)request.getAttribute("abc");
MakerBean maker = (MakerBean)request.getAttribute("maker");

int test = 0;
int test2 = 0;
int test3 = 0;
for(int i=0; i<list.size(); i++){
	test += list.get(i).getPrice();
	test2 += list.get(i).getSalesQuantity();
	test3 += test*test2;
	test = 0;
	test2 = 0;
}  
double basic = ab.getSalesTarget();
double num1 = (test3/basic)*100;




%>

<jsp:include page="../top1.jsp" />
	
	<!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="blog" style="height: 200px; background: #f1f6f7;">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
						홈리빙
			        </nav>
					<h3 style="font-size: 30px;">"${story.title }"</h3>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->


	<!--================Product Description Area =================-->
	<section class="product_description_area" style="margin-top: 0;">
			<ul class="nav nav-tabs" id="myTab" role="tablist" style="background: none; border: 1px solid #f1f6f7;">
				<li class="nav-item">
					<a class="nav-link active" id="home-tab" data-toggle="tab" href="${contextPath}/fundingDetailStory.do?fundingId=${fundingId}" 
					role="tab" aria-controls="home" aria-selected="true">스토리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="profile-tab" data-toggle="tab" href="${contextPath}/fundingDetailInfo.do?fundingId=${fundingId}" 
					role="tab" aria-controls="profile" aria-selected="false">반환/정책</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="contact-tab" data-toggle="tab" href="#" role="tab" aria-controls="contact" aria-selected="false">커뮤니티</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="review-tab" data-toggle="tab" href="${contextPath}/FundingDetailSupport.do?fundingId=${fundingId}" 
					role="tab" aria-controls="review" aria-selected="false">서포터</a>
				</li>
			</ul> 
		<div class="maincontainer" >
			<div class="tab-content" id="myTabContent" style="border: none;">
				<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
				<div class="row">
					<div class="col-lg-8 posts-list">
						<div class="single-prd-item" >
							<img class="img-fluid" src="${contextPath}/img/bed.png" style="padding-left: 100px" alt="" >
							<div align="center" style="font-size: 20px; padding-top: 30px ">
							<strong id="storyContent">${story.storyContent } </strong>
							<strong>${storySummary }</strong>
							</div>
						</div>
					</div>	
					
					<div class="col-lg-4">
						<div class="blog_right_sidebar">
							<strong style="font-size: 25px; color:black;">오늘 자정 마감</strong>
							<hr>
							<div>     
							<strong style="font-size: 22px; color:gray;"><fmt:formatNumber value="<%=num1 %>" pattern="###,###"/></strong><b> %달성</b><br><br>
							<strong style="font-size: 22px; color:gray;"><fmt:formatNumber value="<%=test3 %>" pattern="###,###"/></strong><b> 원 펀딩</b><br><br>
							
							<form action="./payment.do" method="post" onsubmit="return CheckForm();">
								<div class="row">
									<div  align="center" name="select">
								      <select name="aa" id="aa" style="width:520px; height:45px; margin-bottom: 20px" >
								    	 <option value="0">개당 용량/중량/정 x 수량</option>
								      <c:forEach var="reward" items="${requestScope.reward }">
								         <option value="${reward.rewardId}">${reward.rewardDetail}</option>
								      </c:forEach>
								      </select>
								   </div>
								   <div style="background-color: #eeeeee; width:520px; margin-bottom: 20px;height: 145px">
								   
								   
									  <p id="ajaxName" style="padding-top: 10px;margin-bottom: -10px">* 제품명 :
									   </p><hr>
									  <p id="ajaxOption" style="margin-top: -5px;margin-bottom: -10px">* 옵션명 :
									  </p><hr>
									  
									   <span style="margin-top: -10px;margin-bottom: -10px">* 수량 선택: </span><input type="number" min="1" max="10" style="width: 100px" id="salesQuantity" name="salesQuantity">
									  </div> 
									  
									
									<button type="submit" class="btn btn-primary btn-lg btn-block" style="background-color:LightSlateGray; 
									font-size:18px; border: none;width: 324px;height: 50px ">펀딩 하기</button>
									</div>
									<input type="hidden" name="rewardId" id="test">
								</form>
							<div class="row" align="center" style="padding-left: 7px; padding-top: 20px">
							</div>
							</div>
							</div><br><!-- blog_right_sidebar -->
						
						<div class="blog_right_sidebar" style="height:330px">
						<img alt="" src="./img/maker.png">
							<strong style="font-size: 20px; color:black;padding-left: 10px"> <%=ab.getUserId() %></strong>
							<hr>
							<div>
							<b>메이커 정보</b>
							<p><%=ab.getMakerName() %></p>
							<p><%=maker.getMakerTel() %></p>
							<p><%=maker.getMakerEmail() %></p>
							</div>
							</div><br><!-- blog_right_sidebar -->
				<c:forEach var="reward" items="${requestScope.reward}">
						<div class="blog_right_sidebar" style="height:360px">
							<strong style="font-size: 20px; color:black;"> ${reward.price }원 펀딩</strong>
							<div style="padding-top: 8px">
							<b>${reward.rewardOption }</b>
							<p>${reward.rewardDetail }</p>
							<b>배송비</b>
							<p>${reward.deliveryFee }원</p>
							<b>리워드 발송 시작일</b>
							<p>${reward.deliveryDate }</p>
							<p style="color: blue">제한수량 ${reward.quantity }개</p>
							<b>총${reward.salesQuantity }개 펀딩 완료</b>
							</div>
						</div><br><!-- blog_right_sidebar -->
					<%-- <c:set var="j" value="${j+1 }"/> --%>
				</c:forEach>
				
							
						
					</div>	
				</div>
				</div>
		</div>
	</section>
	<!--================End Product Description Area =================-->

  <jsp:include page="../bottom.jsp" />


  <script src="${contextPath}/vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="${contextPath}/vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="${contextPath}/vendors/skrollr.min.js"></script>
  <script src="${contextPath}/vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="${contextPath}/vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="${contextPath}/vendors/jquery.ajaxchimp.min.js"></script>
  <script src="${contextPath}/vendors/mail-script.js"></script>
  <script src="${contextPath}/js/main.js"></script>
</body>
</html>