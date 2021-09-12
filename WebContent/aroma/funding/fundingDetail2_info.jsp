<%@page import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<%@page import="java.util.List"%>
<%@page import="net.funding.open.db.ReportJoin"%>
<%@page import="java.util.Date"%>
<%@page import="net.funding.open.db.JoinFunding"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
			        url: 'detailAction.on',
			        contentType: "application/json; charset=utf-8",
			        data: JSON.stringify(data), 
			        dataType: "json"
			     
			     }).done(function(result) {
			    	 console.log(result);
			    	 $("#ajaxName").empty();
			    	 $("#ajaxOption").empty();
			    	 
			    	 var rewardOption = result.rewardOption;
			    	 var name = result.name;
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
<%

JoinFunding endDate = (JoinFunding)request.getAttribute("endDate");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String date = endDate.getEndDate();


ReportJoin ab = (ReportJoin)request.getAttribute("report");
List<ReportJoin> list = (List<ReportJoin>)request.getAttribute("abc");

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
System.out.println(basic);
System.out.println(num1);



%>
<body>

<jsp:include page="../top1.jsp" />
	
	<!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="blog" style="height: 200px; background: #f1f6f7;">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
						홈리빙
			        </nav>
					<h3 style="font-size: 30px;">클레오파트라의 피부비결, 각질 관리도 개운하게 | 이집트 천연 루파 샤워 타올</h3>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->


	<!--================Product Description Area =================-->
	<section class="product_description_area" style="margin-top: 0;">
			<ul class="nav nav-tabs" id="myTab" role="tablist" style="background: none; border: 1px solid #f1f6f7;">
				<li class="nav-item">
					<a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" 
					aria-selected="false">스토리</a>     
				</li>
				<li class="nav-item">
					<a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile"
					 aria-selected="true">반환/정책</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact"
					 aria-selected="false">커뮤니티</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review"
					 aria-selected="false">서포터</a>
				</li>
			</ul>
	<!-- ==============정책============== -->
		<div class="maincontainer" >
			<div class="tab-content" id="myTabContent" style="border: none;">
				<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
				<div class="row">
					<div class="col-lg-8 posts-list">
						<div class="single-prd-item" >
							<div align="left" style="font-size: 20px; padding-top: 30px ">
								<h2><strong>이 프로젝트의 정보 및 정책을</strong></h2>
								<h2><strong>반드시 확인하세요.</strong></h2><br><br>
								<p style="font-size: 25px"><strong>펀딩 취소 및 리워드 옵션 변경, 배송지 변경 안내</strong></p>
								<p style="font-size: 17px">펀딩 결제는 예약 상태로 유지되다가, 펀딩 마감일 다음 영업일 <strong><%=date %></strong>시에 모두 함께 진행됩니다.
								 결제 정보 변경은 결제가 진행되기 전까지 언제나 가능합니다. 참여한 펀딩 정보 변경은 펀댕 내역에서 진행해 주세요. 마감일 이후에는 펀딩에
								대한 리워드 제작 및 배송이 시작되어, 취소와 더불어 배송지 및 리워드 옵션 변경은 <strong><%=date %></strong> 이후로는 불가합니다.</p><br><hr>
								
								<!-- 리워드 정보 제공 고시 -->
								<p style="font-size: 25px"><strong>리워드 정보 제공 고시</strong></p>
								<b>리워드 상세정보</b>
								<div class="rewardDetail" style="font-size: 15px">
					<c:forEach var="re" items="${requestScope.re}">
							
							
							<div class="row">
							  <div class="col"><span>${re.detailName }</span></div>
							   <div class="col"><span>${re.detailContent }</span></div>
							</div><hr>

							<c:set var="j" value="${j+1 }"/>
						</c:forEach>
							</div><!-- rewardDetail -->
							
							</div>
						</div>
					</div>
					<!-- ==============정책============== -->
					
					
					
					<!-- ==============우측 배너============== -->
					<div class="col-lg-4">
						<div class="blog_right_sidebar">
							<strong style="font-size: 25px; color:black;"><%=date %>에 마감</strong>
							<hr>
							<div>
							<strong style="font-size: 22px; color:gray;"><fmt:formatNumber value="<%=num1 %>" pattern="###,###"/></strong><b> %달성</b><br><br>
							<strong style="font-size: 22px; color:gray;"><fmt:formatNumber value="<%=test3 %>" pattern="###,###"/></strong><b> 원 펀딩</b><br><br>
							
								<form action="./payment.on" method="post" onsubmit="return CheckForm();">
								<div class="row">
									<div  align="center" name="select">
								      <select name="aa" id="aa" style="width:520px; height:45px; margin-bottom: 20px" >
								    	 <option value="0">개당 용량/중량/정  X 수량</option>
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