<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>GoodFunding</title>
  <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
  <style type="text/css">
	.count_table th,td{
		padding-top:10px;
		padding-right:20px;
	}
  </style>
  <script type="text/javascript">
   $(document).on("click", '#follow_btn', function () {
  		
	   	if(${empty sessionScope.id}){
	   		alert("로그인 후에 이용해주세요.");
	   	}else{
	   		followProcess();
	   	}
	});
   
   function followProcess() {
	   var followStatus = $("#status").val();
	   console.log("followStatus: " + followStatus);
	   
	   var data = {userId : "${sessionScope.id}", makerId : "${maker.userId}", followStatus : followStatus};
	   $.ajax({
	        type: 'post',
	        url: 'FollowAction.do',
	        data: JSON.stringify(data), 
	        contentType: "application/json; charset=utf-8",
	        dataType: "json" 
	    }).done(function(result) {
	    	if(followStatus == 0){
	    		var button = document.getElementById('follow');
		        console.log(result);
		        document.getElementById('followCnt').innerText = result;
		      	$("#status").val("1");
		      	
				var html = "<div class='card_area d-flex align-items-center' id='followButton'>";
		        	html += "<a class='icon_btn' id='follow_btn' style='width: 150px'>";
		       		html += "<i class='far fa-heart' style='color: red'></i>팔로우 취소";
		       		html += "</a>";
		       		html += "</div>";
		 		$('#followButton').replaceWith(html);
		 		
	    	}else{
	    		document.getElementById('followCnt').innerText = result;  //팔로워수
    	        $("#status").val("0");
    	       
    	     	var html = "<div class='card_area d-flex align-items-center' id='followButton'>";
    			html += "<a class='icon_btn' id='follow_btn' style='width: 150px'>";
    	  		html += "<i class='fas fa-heart' style='color: red'></i>팔로우 하기";
    	  		html += "</a>";
    	  		html += "</div>";
    			$('#followButton').replaceWith(html);
	    	}
	    	
	    }).fail(function() {
			console.log("팔로우 오류");
		});
	}
  </script>
</head>
<body>
<jsp:include page="../top1.jsp" />

	<div class="container" style="padding: 100px 100px 30px 100px;">
		<div class="row s_product_inner">
			<div class="col-lg-5 offset-lg-1">
				<div class="s_product_text" style="margin-left: 15px">
					<input type="hidden" id="status" name="status" value="${check}">
					<h3>${maker.name}</h3>
                    <c:set var="followCount" value="${followCount}"/>
                   	<%-- <c:set var="fundingCount" value="${fundings.size()}"/> --%>
	                
	                <table style="text-align: center;" id="count_table">
	                	<tr>
	                     	<td style="padding-left: 15px;"><h2>${fundings.size()}</h2></td>
	                     	<td style="padding-left: 15px;"><h2 id="followCnt">${followCount}</h2></td>
	                    </tr>
	                    <tr>
	                        <td style="padding-left: 15px;">펀딩</td>
	                        <td style="padding-left: 15px;">팔로워</td>
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
				</div>
			</div>
	  		<!-- Start 프로필이미지 -->
            <div class="col-lg-6">
                <div class="s_Product_carousel">
                    <div class="single-prd-item" style="margin: 30px 0 0 230px">
                        <img src="${pageContext.request.contextPath}/profileUpload/${maker.profile}" style="border-radius:200px; width: 130px; height: 130px; margin-left: 10px">
                    </div>
                </div>
            </div>
       		<!-- End 프로필이미지 -->
		</div>
	</div>

	<section class="product_description_area"  style="margin-bottom: -100px;">
		<div class="maincontainer" style="padding: 0 100px; margin-bottom: 100px;">
			<div class="row">
				<c:forEach var="funding" items="${fundings}">
					<div class="col-md-3">
						<div class="card-deck">
							<div class="card" style="border: none;">
						    	<a href="${contextPath}/fundingStory.do?fundingId=${funding.fundingId}">
						    		<img class="card-img-top" src="${pageContext.request.contextPath}/fundingUpload/${funding.mainImg}" style="height: 200px;">
						    	</a>
						    	<div class="card-body" style="height: 150px; padding: 10px 0 0;">
						    		<div style="height: 80px;">
							    		<div style="margin: 0 0 8px; height: 45px;">
								    		<a href="${contextPath}/fundingStory.do?fundingId=${funding.fundingId}">
								    			<p><strong style="font-size: 17px; line-height: 20px; color:rgba(0,0,0,.84);">${funding.fundingTitle}</strong></p>
								    		</a>
							    		</div>
							    		<div>
							    			<span style="float: left; display:inline-block; font-size: 14px; line-height: 16px; color: #90949c; font-weight: 500; ">
								    			${funding.categoryName} &nbsp; | &nbsp; ${maker.name}
							    			</span>
							    		</div>
									</div>
									<div style="display:block; height: 3px; width: 100%; background-color: #00b2b2;"></div>
									<span style="font-size: 17px; color:#00b2b2; font-weight: 700;">3000%</span>
									<span style="font-size: 14px; color:#90949c; font-weight: 500; ">6,546,000</span>
									<c:set var="detail" value="${funding.dayDiff}"/>
									<c:if test="${funding.statusName ne 'start'}">
									<c:set var="detail" value="${funding.statusName}"/>
									</c:if>
									<span style="float: right; font-size: 14px; font-weight: 500; color:#90949c;">${detail} </span>
						    	</div>
					  		</div>
				  		</div>
			  		</div>
			  	</c:forEach>
	  		</div>
	  	</div>
	</section>

 <jsp:include page="../bottom.jsp" />

</body>
</html>