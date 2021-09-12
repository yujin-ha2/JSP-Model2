<%@page import="net.funding.open.db.fundingorderBean"%>
<%@page import="net.funding.open.db.RewardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="net.funding.open.db.ReportJoin"%>
<%@page import="java.util.Date"%>
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
    <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/mdi/css/materialdesignicons.min.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/ionicons/dist/css/ionicons.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/iconfonts/flag-icon-css/css/flag-icon.min.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="${contextPath}/assets/vendors/css/vendor.bundle.addons.css">
    <link rel="stylesheet" href="${contextPath}/assets/css/shared/style.css">
    <link rel="stylesheet" href="${contextPath}/assets/css/demo_1/style.css">
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
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
<%
ReportJoin ab = (ReportJoin)request.getAttribute("report");
List<ReportJoin> list = (List<ReportJoin>)request.getAttribute("abc");
List<fundingorderBean> repo = (List<fundingorderBean>)request.getAttribute("repo");
List<fundingorderBean> repo7 = (List<fundingorderBean>)request.getAttribute("repo7");
List<RewardBean> reward = (List<RewardBean>)request.getAttribute("reward");
List<fundingorderBean> chartDate = (List<fundingorderBean>)request.getAttribute("chartDate");

int test2 = 0;
int[] test = new int[list.size()];
int[] testNum = new int[list.size()];
for(int i=0; i<list.size(); i++){
	test[i] += list.get(i).getPrice();
	testNum[i] += list.get(i).getSalesQuantity();
	test2 += test[i]*testNum[i];
}




int Datetest2 = 0;
int[] Datetest = new int[repo.size()];
for(int i=0; i<repo.size(); i++){
		Datetest[i] += repo.get(i).getAmount();
		Datetest2 += Datetest[i];
}
int count2 = 0;
int[] count = new int[repo.size()];
	for(int i=0; i<repo.size(); i++){
		count[i] += repo.get(i).getQuantity();
		count2 += count[i];
	}
	

int totalDatetest2 = 0;
int[] totalDatetest = new int[repo7.size()];
for(int i=0; i<repo7.size(); i++){
		totalDatetest[i] += repo7.get(i).getAmount();
		totalDatetest2 += totalDatetest[i];
}
int totalcount2 = 0;
int[] totalcount = new int[repo7.size()];
	for(int i=0; i<repo7.size(); i++){
		totalcount[i] += repo7.get(i).getQuantity();
		totalcount2 += totalcount[i];
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date startDate = sdf.parse(ab.getStartDate());
	Date endDate = sdf.parse(ab.getEndDate());
	String firstDate = sdf.format(startDate);
	String secendDate = sdf.format(endDate);
	
	double a = Math.ceil(endDate.getTime());
	double b = Math.ceil(startDate.getTime());
	double c = (a-b)/(1000*3600*24);
	int numb = (int)c;

	Date nowTime = new Date();
	
	int numt = (int)Math.ceil((endDate.getTime()-nowTime.getTime())/(1000*3600*24));
	
	double Amount  = (1-((double)numt/numb))*100;
	long AmountDat =Math.round(Amount); 
	 
	double nowprice = test2;
	
	 double rate = (100/Amount)*nowprice;
	 long rateDate = Math.round(rate);
	 
	 DecimalFormat df = new DecimalFormat("###,###");
	 String Srate = df.format(rateDate);
	 
	 long priceTotal = ab.getSalesTarget();
	 
	 double aa  = (1-((double)rate/priceTotal))*100;
	 
	 double bb = 100-aa;
	 long lastPrice =Math.round(bb); 
	 

%>
<body>
    <div class="container-scroller">
      <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-top justify-content-center" style="padding-top: 20px;">
          <a class="navbar-brand brand-logo" href="#">makerStudio</a>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-center">
        	<%-- 프로제트 번호: ${projectId} --%>
           <ul class="navbar-nav mr-auto">
            <li class="nav-item">
	           	<div class="profile-image">
	              <img class="img-xs rounded-circle" src="${contextPath}/assets/images/face8.jpg" alt="profile image">
	              <span style="margin-left: 10px; padding-top: auto;">${sessionScope.id}님의 프로젝트 번호는 ${fundingId}</span>
	            </div>
            </li>
            </ul>
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <button type="button" class="btn btn-outline-primary btn-rounded btn-fw">미리보기</button>
            </li>
            <li class="nav-item">
              <button type="button" class="btn btn-outline-primary btn-rounded btn-fw">나가기</button>
            </li>
          </ul>
        </div>
      </nav>
      <div class="container-fluid page-body-wrapper">
        <jsp:include page="nav.jsp">
        <jsp:param name="fundingId" value="${fundingId}"/> 
       	</jsp:include>
        
        <div class="main-panel">
          <div class="content-wrapper">
            <div class="row">
             <div class="col-md-2 grid-margin">
                  <div class="card-body">
                    <h4 class="card-title" style="font-size: 36px; font-weight: 700; margin-bottom: 10px;">펀딩 현황</h4>
                    <p class="card-description">내 결제를 확인하세요 </p>
                  </div>
              </div>
              <div class="col-md-2 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body" style="text-align: right;">
                  	<h4 class="card-title">프로젝트 이름</h4>
                    <p>${report.title }</p>
                    <h4 class="card-title">목표 금액</h4>
                    <p>${report.salesTarget }</p>
                  </div>
                </div>
              </div>
              <div class="col-md-2 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body"  style="text-align: right;">
                    <h4 class="card-title">예상 목표 금액</h4>
                    <p><%=Srate %>원</p>
                    <h4 class="card-title">예상 달성률</h4>
                    <p><%=lastPrice%>%</p>
                  </div>
                </div>
              </div>
              <div class="col-md-2 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body"  style="text-align: right;">
                    <h4 class="card-title">펀딩 시작 날짜</h4>
                    <p><%=firstDate %></p>
                    <h4 class="card-title">펀딩 종료 날짜</h4>
                    <p><%=secendDate %></p>
                  </div>
                </div>
              </div>
               <div class="col-md-2 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body"  style="text-align: right;">
                    <h4 class="card-title">펀딩 기간</h4>
                    <p><%=numb %>일</p>
                    <h4 class="card-title">남은 기간</h4>
                    <p><%=numt %>일</p>
                  </div>
                </div>
              </div>

              
              <div class="col-md-5 grid-margin">
                <div class="card">
                  <div class="card-body">
                 	 <div><h3>펀딩 현황 정보</h3></div>	
                    <table class="table table-bordered success">
						<thead>
							<tr>
								<th class="info">오늘 판매 개수</th>
								<td align="right"><%=count2 %></td>
							</tr>
							<tr>
								<th class="info">오늘 판매 금액</th>
								<td align="right"><fmt:formatNumber pattern="###,###" value="<%=Datetest2 %>"/></td>
							</tr>
							<tr>
								<th class="info">최근 일주일간 판매개수</th>
								<td align="right"><%=totalcount2 %></td>
							</tr>
							<tr>
								<th class="info">최근 일주일간 판매금액</th>
								<td align="right"><fmt:formatNumber pattern="###,###" value="<%=totalDatetest2 %>"/></td>
							</tr>
							<tr>
								<th class="info">총 판매 금액</th>
								<td align="right"><fmt:formatNumber pattern="###,###" value="<%=test2 %>"/></td>
							</tr>
							<tr>
								<th class="info">진행도</th>
								<td align="right"><%=AmountDat%>%</td>
							</tr>
							<tr>
								<th class="info">예상 목표 금액</th>
								<td align="right"><%=Srate %>원</td>
							</tr>
							<tr>
								<th class="info">예상 달성률</th>
								<td align="right"><%=lastPrice%>%</td>
							</tr>
						</thead>
					</table>
                  </div>
                </div>
              </div>
              <div class="col-md-5 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <div class="wrapper">
                      <h4 class="card-title" style="font-size: 36px; font-weight: 700; margin-bottom: 10px;">옵션별 판매현황</h4>
                    <canvas class="my-auto mx-auto" height="200" id="myChart2"></canvas>
                  </div>
                </div>
              </div>
            </div>
              <div class="col-md-10 grid-margin stretch-card">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title" style="font-size: 36px; font-weight: 700; margin-bottom: 10px;">날짜별 판매현황</h4>
                    <div>
					   <canvas class="my-auto mx-auto" height="120" id="myChart"></canvas>
					  </div>
                  </div>
                </div>
              </div>
               <div class="col-md-10 grid-margin">
                 <div class="card">
                   <div class="card-body">
                     <h4 class="card-title" style="font-size: 36px; font-weight: 700; margin-bottom: 10px;">리워드별 판매현황</h4>
                     <canvas class="my-auto mx-auto" height="120" id="myChart3"></canvas>
                   </div>
                 </div>
               </div>
              </div>
    	  </div>
    	</div>
    </div>
    </div>


    <!-- plugins:js -->
    <script src="${contextPath}/assets/vendors/js/vendor.bundle.base.js"></script>
    <script src="${contextPath}/assets/vendors/js/vendor.bundle.addons.js"></script>
    <script src="${contextPath}/assets/js/shared/off-canvas.js"></script>
    <script src="${contextPath}/assets/js/shared/misc.js"></script>
    <script src="${contextPath}/assets/js/demo_1/dashboard.js"></script>
    <script src="${contextPath}/assets/js/shared/jquery.cookie.js" type="text/javascript"></script>
     <script>
     
    
    var ctx = document.getElementById('myChart').getContext('2d');
    var data = {
        type: 'line',
        // The data for our dataset
        data: {
            labels: [
            	<%
                

             	String[] chartOrder = new String[chartDate.size()];
             	for(int i=0; i<chartDate.size(); i++){
             		chartOrder[i] = chartDate.get(i).getOrderDate();
             		%>'<%=chartOrder[i]%>',<%
             		}
             		%>
            ],
            datasets: [{
                label: "날짜별 판매 그래프",
                fill:false, // line의 아래쪽을 색칠할 것인가? 
                lineTension:0.1, // 값을 높이면, line의 장력이 커짐.
                data: [
                <%
            	int[] chartCount = new int[chartDate.size()];
            	for(int i=0; i<chartDate.size(); i++){
            		chartCount[i] = chartDate.get(i).getQuantity();
            		%><%=chartCount[i]%>,<%
            		}
            		%>],
            borderColor: [
					'rgba(255, 99, 132, 1)',
					'rgba(54, 162, 235, 1)',
					'rgba(255, 206, 86, 1)',
					'rgba(75, 192, 192, 1)',
					'rgba(153, 102, 255, 1)',
					'rgba(255, 159, 64, 1)'
				],
				backgroundColor: [
				'rgba(255, 99, 132, 0.2)',
				'rgba(54, 162, 235, 0.2)',
				'rgba(255, 206, 86, 0.2)',
				'rgba(75, 192, 192, 0.2)',
				'rgba(153, 102, 255, 0.2)',
				'rgba(255, 159, 64, 0.2)'
			],
                	
                
            }]
        },
        // Configuration options go here
        options: {}
    }
    var chart = new Chart(ctx, data);
    
    var ctx = document.getElementById('myChart2').getContext('2d');
    var data = {
        // The type of chart we want to create
        type: 'pie',
        // The data for our dataset
        data: {
        	labels: [<%
                 

             	String[] rewardName = new String[reward.size()];
             	for(int i=0; i<reward.size(); i++){
             		rewardName[i] = reward.get(i).getRewardDetail();
             		%>'<%=rewardName[i]%>',<%
             		}
             		%>],
            datasets: [{
            	
                label: "옵션별 판매개수",
                
                fill:false, // line의 아래쪽을 색칠할 것인가? 
                
                
                data: [  <%
            	int[] rewardCount = new int[reward.size()];
            	for(int i=0; i<reward.size(); i++){
            		rewardCount[i] = reward.get(i).getSalesQuantity();
            		%><%=rewardCount[i]%>,<%
            		}
            		%>],
          		borderColor: [
     					'rgba(255, 99, 132, 1)',
     					'rgba(54, 162, 235, 1)',
     					'rgba(255, 206, 86, 1)',
     					'rgba(75, 192, 192, 1)',
     					'rgba(153, 102, 255, 1)',
     					'rgba(255, 159, 64, 1)'
     				],
     				backgroundColor: [
    					'rgba(255, 99, 132, 0.2)',
    					'rgba(54, 162, 235, 0.2)',
    					'rgba(255, 206, 86, 0.2)',
    					'rgba(75, 192, 192, 0.2)',
    					'rgba(153, 102, 255, 0.2)',
    					'rgba(255, 159, 64, 0.2)'
    				],
                    
            }]
        },
        // Configuration options go here
        options: {
        }
    }
    var chart = new Chart(ctx, data);
    
    var ctx = document.getElementById('myChart3').getContext('2d');
    var data = {
        // The type of chart we want to create
        type: 'line',
        // The data for our dataset
        data: {
            labels: [
            	 <%
             	String[] rewardName1 = new String[reward.size()];
             	for(int i=0; i<reward.size(); i++){
             		rewardName1[i] = reward.get(i).getName();
             		%>'<%=rewardName1[i]%>',<%
             		}
             		%>
            	],
            datasets: [{
                label: "리워드별 판매 그래프",
                backgroundColor: 'rgb(255, 99, 132)',
                fill:false, // line의 아래쪽을 색칠할 것인가? 
                borderColor: 'rgb(255, 99, 132)',
                lineTension:0.5, // 값을 높이면, line의 장력이 커짐.
                data: [
               	
                <%
            	int[] rewardCount1 = new int[reward.size()];
            	for(int i=0; i<reward.size(); i++){
            		rewardCount1[i] = reward.get(i).getSalesQuantity();
            		%><%=rewardCount1[i]%>,<%
            		}
            		%>
                ],
            }]
            
        },
        // Configuration options go here
        options: { 
        }
    }
    var chart = new Chart(ctx, data);
</script>
  </body>
</html>