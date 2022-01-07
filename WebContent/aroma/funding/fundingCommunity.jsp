<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
  <link rel="stylesheet" href="${contextPath}/vendors/fontawesome/css/all.min.css">
  <link rel="stylesheet" href="${contextPath}/vendors/themify-icons/themify-icons.css">
  <link rel="stylesheet" href="${contextPath}/vendors/linericon/style.css">
  <link rel="stylesheet" href="${contextPath}/css/style.css">
  <script type="text/javascript" src="${contextPath}/js/funding.js"></script>
  <script type="text/javascript">
    $(document).on("click", '#followBtn', function () {
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
    			//팔로우 버튼 클래스 변경 /버튼 텍스트 변경
    			$("#followBtn").attr('class','btn btn-outline-primary');
    			$("#followBtn").html('-팔로우취소'); 
    	      	$("#status").val("1");
    	      	
    		}else{
    			$("#followBtn").attr('class','btn btn-primary');
    			$("#followBtn").html('+팔로우'); 
    	      	$("#status").val("0");
    	   	
    		}
    		
    	}).fail(function() {
    		console.log("팔로우 오류");
    	});
    }
    
    function orderFunding() {
    	if(${empty sessionScope.id}){
	   		alert("로그인 후에 이용해주세요.");
		}else if('${report.status}' == 'success' || '${report.status}' == 'fail'){
			alert('이미 종료된 펀딩입니다.');
		}
		else{
			var UlLength = $("#productsToBuy ul").length;
	    	if(UlLength == 0){
	    		alert("리워드 옵션을 먼저 선택해주세요");
	    	}else{
	    		orderForm.submit();	
	    	}
	   	}
	}
    
    $(document).ready(function () {
    	  $(document).on("click", "input[name='orderBtn']", function () {
    		  orderFunding();
    	  });
    });
    
    function addComment() {
    	console.log("id: " + '${sessionScope.id}');
    	var data = {
				fundingId : '${fundingInfo.fundingId}',
				writerId : '${sessionScope.id}',
				content :  $("#commentInput").val(),
				parentId : '0'
			};
			
		if($("#commentInput").val().length == 0){
			alert("댓글을 입력해주세요");
		}else{
			$.ajax({
	    	    type: 'post',
	    	    url: 'insertComment.do',
	    	    data: JSON.stringify(data), 
	    	    contentType: "application/json; charset=utf-8",
	    	    dataType: "json" 
	    	}).done(function(result) {
	    		if(result == 0)
					alert("답변 등록에 실패했습니다.");
				location.reload();
	    		
	    	}).fail(function() {
	    		console.log("댓글 등록 오류");
	    	});
		}
    }
    
    function editCommentForm(content, replyId) {
		//console.log("content:" + content + ", replyId: " + replyId);
		content = content.replace(/&&/gi, "\n").replace(/&/gi, " ");
		var updateDiv = $('#commentLi' + replyId).find(".updateForm");
		
		var html = "";
		html += "<div>";
		html += "<textarea class='form-control' id='commentInput' rows='2' style='font-size: 14px;'>"+content+"</textarea>";
		html += "<div style='padding-left: 91%; margin-bottom: 10px;'>";
		html += "<button type='button' class='btn btn-dark mt-2' style='font-size: 13px;' onClick='updateComment("+replyId+")'>수정</button>";
		html += "</div>";
		html += "</div>";
		
		updateDiv.empty();
		updateDiv.append(html);
	}
    
    function updateComment(replyId) {
    	console.log("comment update");
    	var content = $('#commentLi' + replyId).find("textarea").val();
    	console.log("replyId: " + replyId + ", content: " + content);
    	if(content.length == 0){
			alert("댓글을 입력해주세요");
		}else{
			update(replyId, content);
		}
	}
    
    function update(replyId, content) {
    	var data = {
    			replyId : replyId,
				content : content,
			};
		
		$.ajax({
    	    type: 'post',
    	    url: 'updateComment.do',
    	    data: JSON.stringify(data), 
    	    contentType: "application/json; charset=utf-8",
    	    dataType: "json" 
    	}).done(function(result) {
    		if(result == 0)
				alert("댓글 수정에 실패했습니다.");
    		location.reload();
    		
    	}).fail(function() {
    		console.log("댓글 수정 오류");
    	});
	}
    
    function deleteComment(replyId) {
	   	var data = {
	   			replyId : replyId,
			};
		
		$.ajax({
	   	    type: 'post',
	   	    url: 'deleteComment.do',
	   	    data: JSON.stringify(data), 
	   	    contentType: "application/json; charset=utf-8",
	   	    dataType: "json" 
	   	}).done(function(result) {
	   		if(result == 0)
				alert("댓글 삭제에 실패했습니다.");
	   		location.reload();
	   		
	   	}).fail(function() {
	   		console.log("댓글 삭제 오류");
	   	});
	}
    
    function showReplies(replyId) {
    	if($('#replyDiv'+replyId).length>0){ 
    		if($('#replyDiv'+replyId).css('display') == 'block' ) {
    			console.log('show');
    			$('#replyDiv'+replyId).hide();
    		}else{
    			console.log('none');
    			$('#replyDiv'+replyId).show();
    		}
    	}else{
    		getReplyList(replyId);
    	}
	}
    
    function getReplyList(replyId) {
    	var data = {
    			parentId : replyId
			};
		
		$.ajax({
    	    type: 'post',
    	    url: 'showReplies.do',
    	    data: JSON.stringify(data), 
    	    contentType: "application/json; charset=utf-8",
    	    dataType: "json" 
    	}).done(function(data) {
    		console.log('start');
    		var html = "";
    		html += "<div id='replyDiv"+replyId+"' style='background-color: #f5f7fa; padding: 15px 14px 10px; margin-left: 35px;'>";
    		//for문 시작
    		$.each(data, function(i){
		     	html += "<div style='margin-bottom: 10px;'>";
	    		html += "<div>";
	    		html += "<img class='thumbnail' src='${pageContext.request.contextPath}/profileUpload/"+data[i].profile+"'>";
	    		html += "<span style='font-weight: 600;'> "+data[i].name+"</span>";
	    		var date = new Date(data[i].registerDate);
	    		var startDate = date.getFullYear() + "-" + (date.getMonth()+1) + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes(); 
	    		html += "<span style='color: #0000008A; font-size: 13px; padding-left: 15px;'>"+startDate+"</span>";
	    		html += "</div>";
	    		html += "<div id='replyUpdateDiv"+data[i].replyId+"'>";
	    		html += "<div style='padding-left: 37px;'>";
	    		html += "<p class='replyContent' style='color: #676763; font-size: 14px; font-weight: 500; margin: 7px 0;'>";
	    		html += data[i].content;
	    		html += "</p>";
	    		html += "</div>";
	    		console.log("sessionId: "+'${sessionScope.id}');
	    		console.log(data[i].writerId);
	    		console.log('${sessionScope.id}' == data[i].writerId);
	    		if('${sessionScope.id}' == data[i].writerId){
		    		html += "<div style='margin-bottom: 10px;padding-left: 82%;'>";
		    		html += "<button type='button' class='btn btn-outline-secondary' style='font-size: 13px; margin-right: 3px;' onclick='editReplyForm("+data[i].replyId+")'>수정</button>";
		    		html += "<button type='button' class='btn btn-outline-secondary' style='font-size: 13px;' onclick='deleteComment("+data[i].replyId+")'>삭제</button>";
		    		html += "</div>";
	    		}
	    		html += "</div>";
	    		html += "</div>";
		  	});

    		if(${!empty sessionScope.id}){
	    		html += "<div class='newReplyInput"+replyId+"'>";
	    		html += "<div>";
	    		html += "<img class='thumbnail' src='${pageContext.request.contextPath}/profileUpload/${member.profile}'>"
	    		html += "<span style='font-weight: 600;'> ${member.name}</span>";
	    		html += "</div>";
	    		html += "<div style='padding-left: 33px;'>";
	    		html += "<textarea class='form-control' id='replyInputarea' rows='2'></textarea>";
	    		html += "</div>";
	    		html += "<div style='padding-left: 91%; margin: 10px 0; background-color: #f5f7fa;'>";
	    		html += "<button type='button' class='btn btn-dark' style='font-size: 13px;' onClick='addReply("+replyId+");'>등록</button>";
	    		html += "</div>";
	    		html += "</div>";
    		}else{
	    		html += "<div class='form-inline mb-2'>";
	    		html += "<img class='thumbnail' src='${pageContext.request.contextPath}/profileUpload/noImage.png' style='margin-right: 10px;'>";
	    		html += "<div class='needLogin'>";
	    		html += "로그인이 필요합니다.";
	    		html += "</div>";
	    		html += "</div>";
    		}
    		html += "</div>";
    		
    		var repliesDiv = $('#commentLi' + replyId).find(".commentPart");
    		repliesDiv.after(html);
    		
    	}).fail(function() {
    		console.log("댓글 수정 오류");
    	});
	}
    
    function addReply(parentId) {
    	var content = $(".newReplyInput"+parentId).find('#replyInputarea').val();
    	console.log('textarea: ' + content);
    	console.log('newReplyInput: ' + parentId);
    	
    	var data = {
				fundingId : '${fundingInfo.fundingId}',
				writerId : '${sessionScope.id}',
				content :  content,
				parentId : parentId
			};
    	
		if("dfdsfdsfds".length == 0){
			alert("대댓글을 입력해주세요");
		}else{
			$.ajax({
	    	    type: 'post',
	    	    url: 'insertComment.do',
	    	    data: JSON.stringify(data), 
	    	    contentType: "application/json; charset=utf-8",
	    	    dataType: "json" 
	    	}).done(function(result) {
	    		if(result == 0)
					alert("대댓글 등록에 실패했습니다.");
				location.reload();
	    		
	    	}).fail(function() {
	    		console.log("대댓글 등록 오류");
	    	});
		}
    }

    function editReplyForm(replyId) {
    	var updateDiv = $("#replyUpdateDiv" + replyId);
    	var content = $("#replyUpdateDiv" + replyId).find('p.replyContent').text();
    	console.log(content);
    	
    	var html = "";
    	html += "<div style='padding-left: 33px;'>";
    	html += "<textarea class='form-control' rows='2' style='font-size: 14px;'>"+content+"</textarea>";
    	html += "</div>";
    	html += "<div style='padding-left: 91%; margin: 10px 0; background-color: #f5f7fa;'>";
    	html += "<button type='button' class='btn btn-dark' style='font-size: 13px;' onClick='updateReply("+replyId+");'>수정</button>";
    	html += "</div>";
    	
    	updateDiv.empty();
    	updateDiv.append(html);
    }

    function updateReply(replyId) {
    	console.log("reply update");
    	var content = $("#replyUpdateDiv"+replyId).find("textarea").val();
    	console.log("replyId: " + replyId + ", content: " + content);
    	
    	if(content.length == 0){
    		alert("대댓글을 입력해주세요");
    	}else{
    		update(replyId, content);
    	}
    }

  </script>
  <style type="text/css">
	.tableTh{
		width: 80px; 
		vertical-aligin: top; 
		text-align: left; 
		color: #868e96;
	}
	
	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    margin: 0;
	}
	
	.thumbnail{
		border-radius: 100px; 
		width: 27px; 
		height: 27px; 
		cursor: pointer;
	}
	
	.needLogin{
		width:93%; 
		opacity: .45; 
		border: 1px solid rgba(0,0,0,.15); 
		background-color: #f0f0f0; 
		cursor: default; 
		padding: 8px 12px; 
		font-size: 14px;
	}
  </style>
</head>
<body>
<jsp:include page="../top1.jsp" />
	
	<!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="blog" style="height: 200px; background: #f1f6f7;">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
						${fundingInfo.categoryNm}
			        </nav>
					<h3 style="font-size: 30px;">${fundingInfo.title}</h3>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->

	<section class="product_description_area" style="margin-top: 0;">
		<ul class="nav nav-tabs" id="myTab" role="tablist" style="background: none; border: 1px solid #f1f6f7;">
			<li class="nav-item">
				<a class="nav-link" id="home-tab" href="${contextPath}/fundingStory.do?fundingId=${fundingInfo.fundingId}" role="tab" aria-selected="true">스토리</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="profile-tab" href="${contextPath}/fundingRewardInfo.do?fundingId=${fundingInfo.fundingId}" role="tab" aria-selected="false">반환/정책</a>
			</li>
			<li class="nav-item">
				<a class="nav-link active" id="contact-tab" href="${contextPath}/fundingCommunity.do?fundingId=${fundingInfo.fundingId}" role="tab" aria-selected="false">커뮤니티</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="review-tab" href="${contextPath}/fundingSupporter.do?fundingId=${fundingInfo.fundingId}" role="tab" aria-selected="false">서포터</a>
			</li>
		</ul>
		<div class="fundingcontainer" >
			<div class="tab-content" id="myTabContent" style="border: none;">
				<div class="row">
					<div class="col-lg-8 posts-list">
						<div class="single-prd-item" >
							<div style="margin-bottom: 40px;">
								<p style="line-height: 24px; color: #1d2129; font-size: 17px;">
									서포터님!<br>처음 <strong>메이커의 열정과 가치에 공감</strong>해주셨듯, 마지막까지 <strong>메이커를 응원</strong>해주세요.
								</p>
							</div>
							<div style="margin-bottom: 25px;">
								<p style="font-size: 14px; margin-bottom: 4px;"><strong>굿펀딩에서 펀딩하는 방법이 궁금하다면?</strong></p>
								<h2 style="font-size: 24px;">FAQ</h2>
							</div>
							<div id="accordion" style="margin-bottom: 80px;">
							  <!-- FAQ 1번 -->
							  <div class="card"> 
							    <div class="card-header" id="headingOne" style="background-color: none;">
							      <h5 class="mb-0" >
							        <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
							         	결제했어요. 펀딩은 언제, 어떻게 진행되나요?
							        </button>
							      </h5>
							    </div>
							    <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
							      <div class="card-body">
							      펀딩기간 중에는 결제 예약 상태이며, 프로젝트 종료 후 다음 1영업일 5시에 결제가 진행됩니다. 이때, 결제 실패된 건에 한하여 종료일+4영업일동안 매일 5시에 결제가 진행됩니다. (펀딩 종료일+4영업일 오후 5시 4차 최종 결제 진행)
							      </div>
							    </div>
							  </div>
							  <!-- FAQ 2번 -->
							  <div class="card"> 
							    <div class="card-header" id="headingTwo">
							      <h5 class="mb-0">
							        <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
							          	결제 실패 알림을 받았어요. 어떻게 해야하나요?
							        </button>
							      </h5>
							    </div>
							    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
							      <div class="card-body">
									카드 잔고 부족이나 한도 초과, 거래 정지된 카드인 경우 결제가 진행되지 않습니다. 최종 결제일 16시 30분 전까지 다른 카드로 결제 정보를 변경해주세요. 최종 결제일까지 매 영업일 5시마다 결제가 진행됩니다.
									・ 결제정보 변경은 로그인 - [나의 리워드] - [펀딩 내역] - [참여 프로젝트]에서 결제 정보를 변경할 수 있습니다.
									・ 반드시 참여한 프로젝트 펀딩 상세 내역 페이지에서 결제 정보를 변경해주세요. 나의 리워드 - 간편결제 정보 변경하면 해당 카드로 결제가 진행되지 않습니다!
							      </div>
							    </div>
							  </div>
							  <!-- FAQ 3번 -->
							  <div class="card">
							    <div class="card-header" id="headingThree">
							      <h5 class="mb-0">
							        <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
							          	카드 결제가 진행된 후, 다른 카드로 변경할 수 있나요?
							        </button>
							      </h5>
							    </div>
							    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
							      <div class="card-body">
									결제 예약으로 진행되는 크라우드 펀딩 특성상 이미 종료된 프로젝트는 취소 후 재펀딩이 불가능하니, 결제 전 등록한 카드정보가 맞는지 확인해주세요.
							      </div>
							    </div>
							  </div>
							  <!-- FAQ 4번 -->
							  <div class="card">
							    <div class="card-header" id="headingFour">
							      <h5 class="mb-0">
							        <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
							          	배송지나 옵션을 변경하고 싶어요.
							        </button>
							      </h5>
							    </div>
							    <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordion">
							      <div class="card-body">
									프로젝트 진행 중에는 [나의 리워드] - [펀딩내역]에서 직접 변경이 가능합니다.
									펀딩이 종료된 이후에는 직접 변경이 불가능하니, 아래 [메이커에게 문의하기]를 통해 문의해주세요.
							      </div>
							    </div>
							  </div>
							</div>
							<!-- 응원,의견,체험 리뷰 -->
							<div style="margin-bottom: 20px;">
								<div style="line-height: 24px; color: rgba(0,0,0,.84); font-size: 19px; font-weight: bold;">
									<p style="margin-bottom:8px;">응원/의견/문의<b style="margin-left: 4px; color: #00b2b2;">330</b></p>
								</div>
								<p style="color:rgba(0,0,0,.54); font-size: 14px;">펀딩 종료전에 남긴 글입니다.</p> 
							</div>
							<div class="card mb-2">
								<div class="card-header bg-light">
						        	<i class="fa fa-comment fa"></i> REPLY
								</div>
								<div class="card-body">
									<ul class="list-group list-group-flush">
										<c:if test="${!empty sessionScope.id}">
								    		<li class="list-group-item" style="padding: 0; margin: 10px 0;">
												<div class="form-inline mb-2">
													<img class="thumbnail" src="${pageContext.request.contextPath}/profileUpload/${member.profile}">
													<span style="padding-left: 10px; font-weight: 600;"> ${member.name}</span>
												</div>
												<textarea class="form-control" id="commentInput" rows="2"></textarea>
												<div style="padding-left: 91%; margin-bottom: 20px;"> 
													<button type="button" class="btn btn-dark mt-3" style="font-size: 13px;" onClick="addComment()">등록</button>
												</div>
								    		</li>
							    		</c:if>
							    		<c:if test="${empty sessionScope.id}">
							    			<li class="list-group-item" style="padding: 0; margin: 10px 0;">
												<div class="form-inline mb-2">
													<img class="thumbnail" src="${pageContext.request.contextPath}/profileUpload/noImage.png">
													<div class="needLogin" style="margin-left: 5px;">로그인이 필요합니다.</div>
												</div>
								    		</li>
							    		</c:if>
							    		<c:forEach var="comment" items="${commentList}">
								    		<li id="commentLi${comment.replyId}" class="list-group-item" style="padding: 0; margin: 10px 0; border:none;">
								    			<div class="commentPart">
									    			<div class="form-inline mb-2">
									    				<img class="thumbnail" src="${pageContext.request.contextPath}/profileUpload/${comment.profile}">
														<span style="padding-left: 10px; font-weight: 600;"> ${comment.name}</span>
														<fmt:formatDate var="date" value="${comment.registerDate}" pattern="yyyy-MM-dd hh:mm"/>
														<span style="padding-left: 15px; color: #0000008A; font-size: 13px;">${date}</span>
													</div>
													<div class="updateForm">
														<div style="padding-left: 35px;">
														    <p style="color: #676763; font-size: 14px; font-weight: 500; margin-bottom: 7px;">${comment.content}</p>
														</div>
														<c:if test="${sessionScope.id eq comment.writerId}">
														    <div style="margin-bottom: 10px;padding-left: 72%;">
														    	<input type="button" class="btn btn-outline-secondary" value="답변  ${comment.replyCount}" style="font-size: 13px;" onclick="showReplies(${comment.replyId})">
																<input type="button" class="btn btn-outline-secondary" value="수정" style="font-size: 13px;" onclick="editCommentForm('${comment.content}', ${comment.replyId})">
																<input type="button" class="btn btn-outline-secondary" value="삭제" style="font-size: 13px;" onclick="deleteComment(${comment.replyId})">
														    </div>
													    </c:if>
													    <c:if test="${sessionScope.id ne comment.writerId}">
														    <div style="margin-bottom: 10px;padding-left: 88%;">
														    	<input type="button" class="btn btn-outline-secondary" value="답변  ${comment.replyCount}" style="font-size: 13px;" onclick="showReplies(${comment.replyId})">
														    </div>
													    </c:if>
													</div>
										    	</div>
								    		</li>
							    		</c:forEach>
									</ul>
								</div>
							</div>
						</div>
			  		</div>
					<!-- 우측 div 시작 --> 	
					<div class="col-lg-4">
						<div class="blog_right_sidebar" style="padding-left: 0;">
							<c:set var="dayText" value="${report.statusName}"/>
							<c:if test="${report.status eq 'start'}">
								<c:set var="dayText" value="${report.dayDiff}일 남음"/>
								<c:if test="${report.dayDiff == 0}">
									<c:set var="dayText" value="오늘 자정까지"/>
								</c:if>
							</c:if>
							<strong style="font-size: 25px; color:black;">${dayText}</strong>
							<hr>
							<div>
								<strong style="font-size: 22px; color:gray;">${report.achievement}%</strong><b> 달성</b>	
							</div>
							<div>
								<fmt:formatNumber var="totalRevenue" value="${report.totalRevenue}" pattern="#,###"/>
								<strong style="font-size: 22px; color:gray;">${totalRevenue}</strong><b> 원 펀딩</b>	
							</div>
							<div>
								<strong style="font-size: 22px; color:gray;">${report.supporterCount}</strong><b> 명의 서포터</b>
							</div>
							<div style="border: 1px solid #e9ecef; border-radius: 8px; padding: 16px; margin: 15px auto;">
								<div style="margin-bottom: 10px;">
								 	<a href="">
										<button class="profileDiv" style="background: white; width: 38px; height: 38px; border-radius: 70%; overflow: hidden; margin-right: 12px;">
											<img class="profileImg" src="${pageContext.request.contextPath}/profileUpload/${maker.profile}"
												style="width: 100%; height: 100%; object-fit: cover;">
										</button>
										<span style="line-height: 28px; font-size: 18px; font-weight: 700; font-style: normal; letter-spacing: -.3px; color: #212529;">디알에스코퍼레이션</span>
									</a>
								</div>
								<div>
									<table style="line-height: 18px; font-size: 15px; font-weight: 300;">
										<tbody>
											<tr>
												<th class="tableTh">이메일</th>
												<td style="padding: 0 0 8px;">${maker.makerEmail}</td>
											</tr>
											<tr>
												<th class="tableTh">문의전화</th>
												<td style="padding: 0 0 8px;">${maker.makerTel}</td>
											</tr>
											<tr>
												<th class="tableTh">홈페이지</th>
												<td style="padding: 0 0 8px;">${maker.makerHomepage}</td>
											</tr>
										</tbody>
									</table>
									<div style="margin-top: 15px;">
										<input type="hidden" id="status" name="status" value="${check}">
										<c:set var="followClass" value="btn btn-primary"/>
										<c:set var="followText" value="+팔로우"/>
										<c:if test="${check == 1}">
											<c:set var="followClass" value="btn btn-outline-primary"/>
											<c:set var="followText" value="-팔로우취소"/>
										</c:if>
										<button type="button" id="qnaBtn" class="btn btn-outline-primary" style="padding: 9px 16px; width: 49%;" 
												onclick="location.href='${contextPath}/CompanyDetail.do?makerId=${maker.userId}';">메이커페이지</button>
										<button type="button" id="followBtn" class="${followClass}" style="padding: 9px 16px; width: 49%;">${followText}</button>
									</div>
								</div>
							</div>
							<form method="post" action="fundingOrder.do" name="orderForm">
								<input type="hidden" id="fundingId" name="fundingId" value="${fundingInfo.fundingId}">
								<div class="form-group">
									<select id="productSelect" class="form-control" style="margin-bottom: 0;" >
									    <option value="">상품 선택</option>
									    <c:forEach var="reward" items="${rewardList}">
										    <option value="${reward.rewardId}">${reward.rewardOption}</option>
									    </c:forEach>
									</select>
								</div>	
								<div id="productsToBuy">
								</div>
							</form>
							<input type="button" id="orderBtn" name="orderBtn" value="펀딩하기" class="btn btn-primary" style="font-size:18px; border: none; width:100%; height:48px; margin-top: 15px;">
					</div> 
				</div><!-- 우측 div 끝 -->
				</div>
			</div>
		</div>
	</section>

  <jsp:include page="../bottom.jsp" />

</body>
</html>