<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>makerStudio</title>
    <c:set var="contextPath" value="${pageContext.request.contextPath}/aroma"/>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="vendors/themify-icons/themify-icons.css">
    <style type="text/css">
	.input-file-button{
	  background-color:#00c4c4;
	  border-radius: 4px;
	  color: white;
	  cursor: pointer;
	  height: 40px;
	}
	
    </style>
</head>
<body>
    <div class="container-scroller">
      <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-top justify-content-center" style="padding-top: 20px;">
          <a class="navbar-brand brand-logo" href="${contextPath}/makerStudioMain.on?fundingId=${report.fundingId}">makerStudio</a>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-center">
           <ul class="navbar-nav mr-auto">
            <li class="nav-item">
	           	<div class="profile-image">
	              <img class="img-xs rounded-circle" src="${contextPath}/img/noProfile_M.png" alt="profile image">
	              <span style="margin-left: 10px; padding-top: auto;">${sessionScope.id}님의 프로젝트 번호는 ${report.fundingId}</span>
	            </div>
            </li>
            </ul>
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <button type="button" class="btn btn-outline-primary btn-rounded btn-fw" onclick="location.href='myprojectList.on'">나가기</button>
            </li>
          </ul>
        </div>
      </nav>
      <div class="container-fluid page-body-wrapper">
        <jsp:include page="nav.jsp">
        <jsp:param name="fundingId" value="${report.fundingId}"/> 
       	</jsp:include>
        
        <div class="main-panel">
          <div class="content-wrapper">
            <div class="row">
             <div class="col-md-3 grid-margin">
                  <div class="card-body">
                    <h4 class="card-title" style="font-size: 33px; font-weight: 700; margin-bottom: 10px;">펀딩 현황</h4>
                    <p class="card-description"></p>
                  </div>
              </div>
              <div class="col-md-3 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                  	<h4 class="card-title" style="font-size: 19px; font-weight: 700;">${report.fundingTitle}</h4>
                    <p style="text-align: right; font-size: 18px;"><span style="font-size: 16px; color: #797270;">by</span> ${report.makerName}</p>
                    <h4 class="card-title"></h4>
                    <p></p>
                  </div>
                </div>
              </div>
              <div class="col-md-3 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body"  style="text-align: right;">
                    <h4 class="card-title" style="margin-bottom: 5px;">예상 목표 금액</h4>
                    <fmt:formatNumber value="${report.salesTarget}" var="salesTarget" pattern="#,###"/>
                    <fmt:formatNumber value="${report.totalRevenue}" var="totalRevenue" pattern="#,###"/>
                    <p style="font-size: 17px; font-weight: bold;">${salesTarget}원</p>
                    <h4 class="card-title" style="margin-bottom: 5px;">현재 총 펀딩 금액 (달성률)</h4>
                    <p style="font-size: 17px; font-weight: bold;">${totalRevenue}원  (${report.achievement}%)</p>
                  </div>
                </div>
              </div>
              <div class="col-md-3 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body"  style="text-align: right;">
                    <h4 class="card-title" style="margin-bottom: 5px;">펀딩 진행 기간</h4>
                    <fmt:formatDate value="${report.startDate}" var="start" pattern="yyyy-MM-dd"/>
                    <fmt:formatDate value="${report.endDate}" var="end" pattern="yyyy-MM-dd"/>
                    <fmt:parseDate value="${report.startDate}" var="strPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="startDate"></fmt:parseNumber>
					<fmt:parseDate value="${report.endDate}" var="endPlanDate" pattern="yyyy-MM-dd"/>
					<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
                    <p style="font-size: 17px; font-weight: 700; margin-bottom: 0px;">${start} - ${end} (${endDate - startDate }일간 진행)</p>	
                    <p class="card-title" style="font-size: 19px; font-weight: bold;">펀딩 종료까지 ${report.dayDiff}일 남음</p>
                     <h4 class="card-title" style="margin-bottom: 5px;">오늘 총 펀딩 금액</h4>
                     <fmt:formatNumber value="${todayRevenue}" var="todayRevenue" pattern="#,###"/>
                    <p style="font-size: 17px; font-weight: bold; margin-bottom: 0px;">${todayRevenue}원 </p>
                    <p></p>
                  </div>
                </div>
              </div>
              <div class="col-md-6 grid-margin">
                <div class="card">
                  <div class="card-body">
                    <div class="wrapper">
                      <h4 class="card-title" style="font-size: 25px; font-weight: 600; margin-bottom: 10px;">오늘의 판매현황</h4> 
                    <canvas class="my-auto mx-auto" height="200" id="todayChart"></canvas>
                  </div>
                </div>
                </div>
              </div>
              <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <div class="wrapper">
                      <h4 class="card-title" style="font-size: 25px; font-weight: 600; margin-bottom: 10px;">옵션별 판매현황</h4>
                    <canvas class="my-auto mx-auto" height="200" id="optionChart"></canvas>
                  </div>
                </div>
              </div>
            </div>
              <div class="col-md-12 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title" style="font-size: 25px; font-weight: 600; margin-bottom: 10px;">날짜별 판매현황</h4>
                    <div>
					   <canvas class="my-auto mx-auto" height="120" id="dayChart"></canvas>
					  </div>
                  </div>
                </div>
              </div>
              </div>
    	  </div>
    	</div>
    </div>
    </div>

    <script>
    var optionName = [];
    var optionQuantity = [];
    var todayQuantity = [];
    var dateName = [];
    var dateActual = [];
    var color = ['rgba(255, 99, 132, 0.8)',
        		'rgba(54, 162, 235, 0.8)',
        		'rgba(255, 206, 86, 0.8)',
        		'rgba(75, 192, 192, 0.8)',
        		'rgba(153, 102, 255, 0.8)',
        		'rgba(255, 159, 64, 0.8)',
        		'rgba(236, 198, 74, 0.8)',
        		'rgba(158, 158, 158, 0.8)',
        		'rgba(1, 188, 214, 0.8)'];
    var optionColor = [];
    for(var i=0; i<${byOption.size()}; i++){
    	optionColor[i] = color[i];
    }
    
    <c:forEach items="${byOption}" var="option">
    	optionName.push('${option.rewardOption}');
    	optionQuantity.push(${option.quantity});
    </c:forEach>

	<c:forEach items="${today}" var="today">
		todayQuantity.push('${today.quantity}');
	</c:forEach>
    
    <c:forEach items="${byDate}" var="byDate">
    	dateName.push('${byDate.date}');
    	dateActual.push(${byDate.actual});
	</c:forEach>
	
    var ctx1 = document.getElementById('optionChart').getContext('2d');
    var todayChart = new Chart(ctx1, {
    	type: 'doughnut',
		data: {
		  labels: optionName,
		    datasets: [
			    {
			      data: optionQuantity,
			      backgroundColor: optionColor,
		      	  borderWidth: 2
		    	}
			]
		  },
		  options: {
			responsive: true,
		  }
    });
    
    var ctx2 = document.getElementById('todayChart').getContext('2d');
    var optionChart = new Chart(ctx2, {
    	type: 'doughnut',
		  data: {
		    labels: optionName,
		    datasets: [
			    {
			      data: todayQuantity,
			      backgroundColor: optionColor,
		      	  borderWidth: 2
		    	}
			]
		  },
		  options: {
			responsive: true,
		  }
    });
    
    var ctx3 = document.getElementById('dayChart').getContext('2d');
    var str = ""
    var todayChart = new Chart(ctx3, {
    	type: 'bar',
		  data: {
		    labels: dateName,
		    datasets: [
			    {
			      label: '펀딩 기간 동안의 매출액',
			      data: dateActual,
			      borderColor: 'rgb(255, 99, 132)',
			      backgroundColor: 'rgb(255, 99, 132)',
	              fill: false,
		      	  borderWidth: 2
		    	}
			]
		  },
		  options: {
			responsive: true,
		    scales: {
	            xAxes: [{
	                display: true,
	                scaleLabel: {
	                    display: true,
	                    labelString: '펀딩 날짜'
	                },
	                ticks: {
	                    autoSkip: false
	                }
	            }],
	            yAxes: [{
	                display: true,
	                ticks: {
	                    suggestedMin: 0,
	                },
	                scaleLabel: {
	                    display: true,
	                    labelString: '매출액'
	                }
	            }]
	         }
		  }
    });
 
</script>
  </body>
</html>