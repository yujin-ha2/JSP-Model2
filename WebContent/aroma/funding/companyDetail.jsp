<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String companyName = request.getParameter("companyName");
	pageContext.setAttribute("companyName", companyName);
	
	String id = (String)session.getAttribute("id"); 
	System.out.println("id:"+id);
%>
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
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <script src="https://code.jquery.com/jquery-latest.min.js"></script>
  <style type="text/css">
	.count_table th,td{
		padding-top:10px;
		padding-right:20px;
	}
  </style>
  <script type="text/javascript">
   $(document).on("click", '#follow_btn', function () {
  		var btn_value = $("#follow_btn").text();
  		var id = $("input[name='id']").val();
		var cid = $("input[name='companyId']").val();
		var data = {id : id, companyId : cid}
		
  		if(btn_value == "팔로우 하기"){
		  		console.log(data);
		        $.ajax({
		           type: 'post',
		           url: 'FollowAction.go?companyId='+cid+'&followbtn=0',
		           data: JSON.stringify(data), 
		           contentType: "application/json; charset=utf-8",
		           dataType: "json" 
		        }).done(function(result) {
		        	var button = document.getElementById('follow');
		           console.log(result);
		           document.getElementById('followCnt').innerText=result;
		          	
					var html = "<div class='card_area d-flex align-items-center' id='followButton'>";
			        	html += "<a class='icon_btn' id='follow_btn' style='width: 150px'>";
		           		html += "<i class='far fa-heart' style='color: red'></i>팔로우 취소";
		           		html += "</a>";
		           		html += "</div>";

          			$('#followButton').replaceWith(html);
				
		        }).fail(function() {
		           console.log("fail");
		        });
  		   
  		}else{
  		  		console.log(data);
  		        $.ajax({
  		           type: 'post',
  		           url: 'FollowAction.go?companyId='+cid+'&followbtn=1',
  		           data: JSON.stringify(data), 
  		           contentType: "application/json; charset=utf-8",
  		           dataType: "json" 
  		        }).done(function(result) {
  		           console.log(result);
  		           document.getElementById('followCnt').innerText=result;  //팔로워수
  		           
  		         	var html = "<div class='card_area d-flex align-items-center' id='followButton'>";
			        	html += "<a class='icon_btn' id='follow_btn' style='width: 150px'>";
		           		html += "<i class='fas fa-heart' style='color: red'></i>팔로우 하기";
		           		html += "</a>";
		           		html += "</div>";

   					$('#followButton').replaceWith(html);
	
		            console.log("click_end");	
  		        }).fail(function() {
  		           console.log("fail");
  		        });
  		}	
	});
  </script>
</head>
<body>
<jsp:include page="../top1.jsp" />

	<div class="product_image_area" style="padding: 100px 100px">
		<div class="container">
			<div class="row s_product_inner">
				
				<div class="col-lg-5 offset-lg-1">
					<div class="s_product_text" style="margin-left: 15px">
					<form action="FollowAction.go" method="post">
					<input type="hidden" name="companyId" value="${param.companyId}">회사이름
					<input type="hidden" name="id" value="${sessionScope.id}">아이디
					<h3>${companyName}</h3>이름
							        
			       		<c:set var="v" value="${v}"/>
	                       <c:set var="followCount" value="${followCount}"/>
	                       <c:set var="fundingCount" value="${v.size()}"/>
	                       
	                       <table style="text-align: center;" id="count_table">
	                           <tr>
	                               <td><h2>${fundingCount}</h2></td><td><h2 id="followCnt">${followCount}</h2></td>
	                               
	                           </tr>
	                           <tr>
	                               <td>펀딩</td><td>팔로워</td>
	                           </tr>
	                       </table>
						
						
		<c:set var="check" value="${check}"/>
		<c:set var="follow_status" value="팔로우 취소"/>	
							
		<c:if test="${check eq 0 }"> <!-- check==0팔로우 하기 -->
			<c:set var="follow_status" value="팔로우 하기"/>
		</c:if>
		
		
		<div class="card_area d-flex align-items-center" id="followButton">
			<a class="icon_btn" id="follow_btn" style="width: 150px"><i id="heart_i" class="far fa-heart" style="color: red"></i>${follow_status}</a>
		</div>	
		
		</form>
		</div>
	</div>
	  <!-- Start 프로필이미지 -->
            <div class="col-lg-6">
                <div class="owl-carousel owl-theme s_Product_carousel">
                    <div class="single-prd-item" style="margin: 80px 0 0 230px"><!-- 이미지 -->
                        <img class="img-fluid" src="img/${v.get(0).mainImg}" alt="" style="border-radius:200px; width: 100px; height: 100px; margin-left: 10px">
                    </div>
                </div>
            </div>
       <!-- End 프로필이미지 -->
		</div>
	   </div>
	  </div>
	
	<!--================End Single Product Area =================-->

	<!--================Product Description Area =================-->
	<section class="product_description_area"  style="margin-bottom: -100px;">
		<div class="maincontainer" style="padding: 0 50px;">
			<ul class="nav nav-tabs"  style="height:405px;">
		   <div class="row" align="left" style="margin: 15px 150px;" >
		   		<div class="col-md-4">
				 <div class="card" style="width: 12rem;margin-left: 40px">
					  <img class="card-img-top" src="img/r1.jpg" alt="Card image cap" >
					  <div class="card-body">
					    <b class="card-text">초보 웹 개발자를 위한 스프링 프로그래밍 책!</b>
					    <p class="card-text">(주)아이티윌</p>
					    <b style="font-size:12px;">도서</b>
					  </div>
					</div>
					</div>
					<div class="card" style="width: 12rem;margin-left: 10px">
					  <img class="card-img-top" src="img/r1.jpg" alt="Card image cap">
					  <div class="card-body">
					    <b class="card-text">초보 웹 개발자를 위한 스프링 프로그래밍 책!</b>
					    <p class="card-text">(주)아이티윌</p>
					    <b style="font-size:12px;">도서</b>
					  </div>
					</div>
					<div class="card" style="width: 12rem;margin-left: 10px">
					  <img class="card-img-top" src="img/r1.jpg" alt="Card image cap">
					  <div class="card-body">
					    <b class="card-text">초보 웹 개발자를 위한 스프링 프로그래밍 책!</b>
					    <p class="card-text">(주)아이티윌</p>
					    <b style="font-size:12px;">도서</b>
					  </div>
					</div>
				  </div>
			</ul>
			
		</div>
	</section>


  <jsp:include page="../bottom.jsp" />

  <script src="${contextPath}/vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="${contextPath}/vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="${contextPath}/vendors/skrollr.min.js"></script>
  <script src="${contextPath}/vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="${contextPath}/vendors/jquery.ajaxchimp.min.js"></script>
  <script src="${contextPath}/vendors/mail-script.js"></script>
  <script src="${contextPath}/js/main.js"></script>
</body>
</html>