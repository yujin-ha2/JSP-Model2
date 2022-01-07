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
  <script type="text/javascript">
  	//var timer;
     $(function() {
    	 //카테고리 탭 선택시
    	 $("#categoryTab li").on("click", function() {
             var category = $(this).find('a').attr('id');
             var cName = $(this).find('a').text();
             var data = {category:category, keyword:'', endYn:'YN', order:'recent'};
             getFundingList(data);
             //검색, 셀렉트 박스 모두 디폴트 상태로 변경
             $("#searchText").val("");
             $("#fundingStatus option:eq(0)").prop("selected", true);
             $("#fundingSort option:eq(0)").prop("selected", true);
             //카테고리 텍스트 변경
             $("#choice").text(cName);
         });
    	 
    	 //제목 검색(keyword)
    	 $("#searchBtn").on("click", function() {
    		 getValue();
    	 });	 
    	 
    	 //진행중,종료된 검색(endYn:N/Y)
    	 $("#fundingStatus").on("change", function() {
    		 getValue();
    	 });
    	 //최신순, 펀딩액순, 마감임박순(order:recent/amount/closing)
    	 $("#fundingSort").on("change", function() {
    		 getValue();
    	 });
	});
    
    function getValue() {
    	 var keyword = $("#searchText").val();
    	 console.log("keyword: " + keyword);
		 var endYN = $("#fundingStatus option:selected").val();
		 var order = $("#fundingSort option:selected").val();
		 var category = $("a[class*='active']").attr('id');
		 var data = {category:category, keyword:keyword, endYn:endYN, order:order};
		 getFundingList(data);
	}
    
    function getFundingList(data) {
    	$.ajax({
            type: 'post',
            url: 'fundingSearch.do',
            data: JSON.stringify(data), 
            contentType: "application/json; charset=utf-8",
            dataType: "json" 
	   	}).done(function(list) {
	   		$("#searchDiv").empty();
	   		var html = "";
	   		$.each(list, function(j){
	   			console.log(list[j].fundingId);
	   			var totalRevenue = list[j].totalRevenue.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	   			console.log("totalRevenue: " + totalRevenue);
	   			html += "<div class='col-md-3'>";
	   			html += "<div class='card-deck'>";
	   			html += "<div class='card' style='border: none;'>";
	   			html += "<a href='${contextPath}/fundingStory.do?fundingId="+list[j].fundingId+"'>";
	   			html += "<img class='card-img-top' src='${pageContext.request.contextPath}/fundingUpload/"+list[j].mainImg+"' style='height: 200px;'>";
	   			html += "</a>";
	   			html += "<div class='card-body' style='height: 150px; padding: 10px 0 0;'>";
	   			html += "<div style='height: 80px;'>";
	   			html += "<div style='margin: 0 0 8px; height: 45px;'>";
	   			html += "<a href='${contextPath}/fundingStory.do?fundingId="+list[j].fundingId+"'>";
	   			html += "<p><strong style='font-size: 17px; line-height: 20px; color:rgba(0,0,0,.84);'>"+list[j].fundingTitle+"</strong></p>";
	   			html += "</a></div>";
	   			html += "<div>";
	   			html += "<span style='float: left; display:inline-block; font-size: 14px; line-height: 16px; color: #90949c; font-weight: 500; '>";
	   			html += list[j].categoryName+"&nbsp; | &nbsp; "+list[j].makerName;
	   			html += "</span></div></div>";
	   			html += "<div style='display:block; height: 3px; width: 100%; background-color: #00b2b2;'></div>";
	   			html += "<span style='font-size: 17px; color:#00b2b2; font-weight: 700;'>"+list[j].achievement+"%</span>&nbsp;";
	   			html += "<span style='font-size: 14px; color:#90949c; font-weight: 500; '>"+totalRevenue+"</span>";
	   			
	   			if(list[j].status == 'start'){
	   				html += "<span style='float: right; font-size: 14px; font-weight: 500; color:#90949c;'>"+list[j].dayDiff+"일 남음</span>";
	   			}else{
	   				html += "<span style='float: right; font-size: 14px; font-weight: 500; color:#90949c;'>"+list[j].statusName+"</span>";
	   			}
	   			html += "</div></div></div></div>";
          	});	 
            $("#searchDiv").append(html);
            
	   	}).fail(function() {
	           console.log("fail");
    	});
	}
  </script>
</head>
<body>
<jsp:include page="../top1.jsp" />
	
<section class="product_description_area">
	<div class="maincontainer">
        <!-- 카테고리 메뉴 선택 Bar -->
		<ul class="nav nav-tabs" id="categoryTab" role="tablist">
			<li class="nav-item" style="cursor: pointer;">
            	<a class="nav-link active" id="0" data-toggle="tab" role="tab" aria-selected="false">전체</a>
            </li>
			<li class="nav-item" style="cursor: pointer;">
				<a class="nav-link" id="100" data-toggle="tab" role="tab" aria-selected="false" >가전제품</a>
			</li>
			<li class="nav-item" style="cursor: pointer;">
				<a class="nav-link" id="200" data-toggle="tab" role="tab" aria-selected="false">패션</a>
			</li>
			<li class="nav-item" style="cursor: pointer;">
				<a class="nav-link" id="300" data-toggle="tab" role="tab" aria-selected="false">영유아 용품</a>
			</li>
            <li class="nav-item" style="cursor: pointer;">
                <a class="nav-link" id="400" data-toggle="tab" role="tab" aria-selected="false">식품</a>
            </li>
            <li class="nav-item" style="cursor: pointer;">
                <a class="nav-link" id="500" data-toggle="tab" role="tab" aria-selected="false">뷰티</a>
            </li>
		</ul>
            
        <!-- 정렬 Bar -->
        <div class="filter-bar d-flex flex-wrap align-items-center" style="background-color: white; margin-left: -20px;">
            <div>
              	<div class="input-group filter-bar-search" style="margin-right: 10px;">
	              	<div id="input_div">
	                	<input type="text" id="searchText" placeholder="제목으로 검색">
	              	</div>  
	                <div class="input-group-append">
	                	<button type="button" id="searchBtn"><i class="ti-search"></i></button>
	                </div>
              	</div>
            </div>
            <div class="sorting">
            	<select class="form-control" id="fundingStatus"  onchange="">
                	<option value="YN">전체</option>
                	<option value="N">진행중</option>
                	<option value="Y">종료된</option>
              	</select>
            </div>
            <div class="sorting mr-auto" >
            	<select class="form-control" id="fundingSort" onchange="">
	                <option value="recenet">최신순</option>
                	<option value="amount">펀딩액순</option>
                	<option value="closing">마감임박순</option>
              	</select>
            </div>
        </div>
        
       	<div class="container" style="margin-top: -70px">
           	<div class="section-intro pb-60px">
	         	<h2 class="section-intro__style" align="right" id="choice">전체</h2>
			</div>
			<div class="row" id="searchDiv">
			<c:forEach var="funding" items="${fundingList}">
				<div class="col-md-3">
					<div class="card-deck">
						<div class="card" style="border: none;">
						    <a href="${contextPath}/fundingStory.do?fundingId=${funding.fundingId}"><img class="card-img-top" src="${pageContext.request.contextPath}/fundingUpload/${funding.mainImg}" style="height: 200px;"></a>
						    <div class="card-body" style="height: 150px; padding: 10px 0 0;">
						    	<div style="height: 80px;">
							    	<div style="margin: 0 0 8px; height: 45px;">
							    		<a href="${contextPath}/fundingStory.do?fundingId=${funding.fundingId}"><p><strong style="font-size: 17px; line-height: 20px; color:rgba(0,0,0,.84);">${funding.fundingTitle}</strong></p></a>
							    	</div>
							    	<div>
							    		<span style="float: left; display:inline-block; font-size: 14px; line-height: 16px; color: #90949c; font-weight: 500; ">
							    			${funding.categoryName}&nbsp; | &nbsp; ${funding.makerName}
							    		</span>
							    	</div>
								</div>
								
								<div style="display:block; height: 3px; width: 100%; background-color: #00b2b2;"></div>
								<span style="font-size: 17px; color:#00b2b2; font-weight: 700;">${funding.achievement}%</span>
								<fmt:formatNumber var="totalRevenue" value="${funding.totalRevenue}" pattern="#,###"/>
								<span style="font-size: 14px; color:#90949c; font-weight: 500; ">${totalRevenue}</span>
								<c:set var="detail" value="${funding.statusName}"/>
								<c:if test="${funding.status == 'start'}">
									<c:set var="detail" value="${funding.dayDiff}일 남음"/>
								</c:if>
								<span style="float: right; font-size: 14px; font-weight: 500; color:#90949c;">${detail}</span>
						    </div>
					  	</div>
				  	</div>
			  	</div>
		  	</c:forEach>
		  	</div>
        </div>
	</div>
</section>			

<jsp:include page="../bottom.jsp" />

</body>
</html>